`include "./src/i2c_master_defines.v"

module i2c_master_bit_ctrl(
	clk, nReset, 
	clk_cnt, ena, cmd, cmd_ack, busy, al, din, dout,
	scl_i, scl_o, scl_oen, sda_i, sda_o, sda_oen
	);

	//
	// inputs & outputs
	//
	input clk;
	input nReset;
	input ena;            // core enable signal

	input [15:0] clk_cnt; // clock prescale value

	input  [3:0] cmd;
	output       cmd_ack; // command complete acknowledge
	reg cmd_ack;
	output       busy;    // i2c bus busy
	reg busy;
	output       al;      // i2c bus arbitration lost
	reg al;

	input  din;
	output dout;
	reg dout;

	// I2C lines
	input  scl_i;         // i2c clock line input
	output scl_o;         // i2c clock line output
	output scl_oen;       // i2c clock line output enable (active low)
	reg scl_oen;
	input  sda_i;         // i2c data line input
	output sda_o;         // i2c data line output
	output sda_oen;       // i2c data line output enable (active low)
	reg sda_oen;


	//
	// variable declarations
	//

	reg sSCL, sSDB;             // synchronized SCL and SDA inputs
	reg dscl_oen;               // delayed scl_oen
	reg sda_chk;                // check SDA output (Multi-master arbitration)
	reg clk_en;                 // clock generation signals
	wire slave_wait;
//	reg [15:0] cnt = clk_cnt;   // clock divider counter (simulation)
	reg [15:0] cnt;             // clock divider counter (synthesis)

	// state machine variable
	reg [16:0] c_state; // synopsys enum_state

	//
	// module body
	//

	// whenever the slave is not ready it can delay the cycle by pulling SCL low
	// delay scl_oen
	always @(posedge clk or negedge nReset)
		if(~nReset) dscl_oen <= #1 1'b0;
		else	  dscl_oen <= #1 scl_oen;

	assign slave_wait = dscl_oen && !sSCL;


	// generate clk enable signal
	always @(posedge clk or negedge nReset)
	  if(~nReset)
	    begin
	        cnt    <= #1 16'h0;
	        clk_en <= #1 1'b1;
	    end
	  else if ( ~|cnt || ~ena)
	    if (~slave_wait)
	      begin
	          cnt    <= #1 clk_cnt;
	          clk_en <= #1 1'b1;
	      end
	    else
	      begin
	          cnt    <= #1 cnt;
	          clk_en <= #1 1'b0;
	      end
	  else
	    begin
                cnt    <= #1 cnt - 16'h1;
	        clk_en <= #1 1'b0;
	    end


	// generate bus status controller
	reg dSCL, dSDA;
	reg sta_condition;
	reg sto_condition;

	// synchronize SCL and SDA inputs
	// reduce metastability risc
	always @(posedge clk or negedge nReset)
	  if (~nReset)
	    begin
	        sSCL <= #1 1'b1;
	        sSDB <= #1 1'b1;

	        dSCL <= #1 1'b1;
	        dSDA <= #1 1'b1;
	    end
	  else
	    begin
	        sSCL <= #1 scl_i;
	        sSDB <= #1 sda_i;

	        dSCL <= #1 sSCL;
	        dSDA <= #1 sSDB;
	    end

	// detect start condition => detect falling edge on SDA while SCL is high
	// detect stop condition => detect rising edge on SDA while SCL is high
	always @(posedge clk or negedge nReset)
	  if (~nReset)
	    begin
	        sta_condition <= #1 1'b0;
	        sto_condition <= #1 1'b0;
	    end
	  else
	    begin
	        sta_condition <= #1 ~sSDB &  dSDA & sSCL;
	        sto_condition <= #1  sSDB & ~dSDA & sSCL;
	    end

	// generate i2c bus busy signal
	always @(posedge clk or negedge nReset)
	  if(!nReset)
	    busy <= #1 1'b0;
	  else
	    busy <= #1 (sta_condition | busy) & ~sto_condition;

	// generate arbitration lost signal
	// aribitration lost when:
	// 1) master drives SDA high, but the i2c bus is low
	// 2) stop detected while not requested
	reg cmd_stop;
	always @(posedge clk or negedge nReset)
	  if (~nReset)
	    cmd_stop <= #1 1'b0;
	  else if (clk_en)
	    cmd_stop <= #1 cmd == `I2C_CMD_STOP;

	always @(posedge clk or negedge nReset)
	  if (~nReset)
	    al <= #1 1'b0;
	  else
	    al <= #1 (sda_chk & ~sSDB & sda_oen) | (|c_state & sto_condition & ~cmd_stop);


	// generate dout signal (store SDA on rising edge of SCL)
	always @(posedge clk or negedge nReset)
	  if (~nReset)
	    dout <= #1 1'b0;
	  else if(sSCL & ~dSCL)
	    dout <= #1 sSDB;

	// generate statemachine

	// nxt_state decoder
	parameter [16:0] idle    = 17'b0_0000_0000_0000_0000;
	parameter [16:0] start_a = 17'b0_0000_0000_0000_0001;
	parameter [16:0] start_b = 17'b0_0000_0000_0000_0010;
	parameter [16:0] start_c = 17'b0_0000_0000_0000_0100;
	parameter [16:0] start_d = 17'b0_0000_0000_0000_1000;
	parameter [16:0] start_e = 17'b0_0000_0000_0001_0000;
	parameter [16:0] stop_a  = 17'b0_0000_0000_0010_0000;
	parameter [16:0] stop_b  = 17'b0_0000_0000_0100_0000;
	parameter [16:0] stop_c  = 17'b0_0000_0000_1000_0000;
	parameter [16:0] stop_d  = 17'b0_0000_0001_0000_0000;
	parameter [16:0] rd_a    = 17'b0_0000_0010_0000_0000;
	parameter [16:0] rd_b    = 17'b0_0000_0100_0000_0000;
	parameter [16:0] rd_c    = 17'b0_0000_1000_0000_0000;
	parameter [16:0] rd_d    = 17'b0_0001_0000_0000_0000;
	parameter [16:0] wr_a    = 17'b0_0010_0000_0000_0000;
	parameter [16:0] wr_b    = 17'b0_0100_0000_0000_0000;
	parameter [16:0] wr_c    = 17'b0_1000_0000_0000_0000;
	parameter [16:0] wr_d    = 17'b1_0000_0000_0000_0000;

	always @(posedge clk or negedge nReset)
	  if (!nReset)
	    begin
	        c_state <= #1 idle;
	        cmd_ack <= #1 1'b0;
	        scl_oen <= #1 1'b1;
	        sda_oen <= #1 1'b1;
	        sda_chk <= #1 1'b0;
	    end
	  else if (al)
	    begin
	        c_state <= #1 idle;
	        cmd_ack <= #1 1'b0;
	        scl_oen <= #1 1'b1;
	        sda_oen <= #1 1'b1;
	        sda_chk <= #1 1'b0;
	    end
	  else
	    begin
	        cmd_ack   <= #1 1'b0; // default no command acknowledge + assert cmd_ack only 1clk cycle

	        if (clk_en)
	          case (c_state) // synopsys full_case parallel_case
	            // idle state
	            idle:
	            begin
	                case (cmd) // synopsys full_case parallel_case
	                  `I2C_CMD_START:
	                     c_state <= #1 start_a;

	                  `I2C_CMD_STOP:
	                     c_state <= #1 stop_a;

	                  `I2C_CMD_WRITE:
	                     c_state <= #1 wr_a;

	                  `I2C_CMD_READ:
	                     c_state <= #1 rd_a;

	                  default:
	                    c_state <= #1 idle;
	                endcase

	                scl_oen <= #1 scl_oen; // keep SCL in same state
	                sda_oen <= #1 sda_oen; // keep SDA in same state
	                sda_chk <= #1 1'b0;    // don't check SDA output
	            end

	            // start
	            start_a:
	            begin
	                c_state <= #1 start_b;
	                scl_oen <= #1 scl_oen; // keep SCL in same state
	                sda_oen <= #1 1'b1;    // set SDA high
	                sda_chk <= #1 1'b0;    // don't check SDA output
	            end

	            start_b:
	            begin
	                c_state <= #1 start_c;
	                scl_oen <= #1 1'b1; // set SCL high
	                sda_oen <= #1 1'b1; // keep SDA high
	                sda_chk <= #1 1'b0; // don't check SDA output
	            end

	            start_c:
	            begin
	                c_state <= #1 start_d;
	                scl_oen <= #1 1'b1; // keep SCL high
	                sda_oen <= #1 1'b0; // set SDA low
	                sda_chk <= #1 1'b0; // don't check SDA output
	            end

	            start_d:
	            begin
	                c_state <= #1 start_e;
	                scl_oen <= #1 1'b1; // keep SCL high
	                sda_oen <= #1 1'b0; // keep SDA low
	                sda_chk <= #1 1'b0; // don't check SDA output
	            end

	            start_e:
	            begin
	                c_state <= #1 idle;
	                cmd_ack <= #1 1'b1;
	                scl_oen <= #1 1'b0; // set SCL low
	                sda_oen <= #1 1'b0; // keep SDA low
	                sda_chk <= #1 1'b0; // don't check SDA output
	            end

	            // stop
	            stop_a:
	            begin
	                c_state <= #1 stop_b;
	                scl_oen <= #1 1'b0; // keep SCL low
	                sda_oen <= #1 1'b0; // set SDA low
	                sda_chk <= #1 1'b0; // don't check SDA output
	            end

	            stop_b:
	            begin
	                c_state <= #1 stop_c;
	                scl_oen <= #1 1'b1; // set SCL high
	                sda_oen <= #1 1'b0; // keep SDA low
	                sda_chk <= #1 1'b0; // don't check SDA output
	            end

	            stop_c:
	            begin
	                c_state <= #1 stop_d;
	                scl_oen <= #1 1'b1; // keep SCL high
	                sda_oen <= #1 1'b0; // keep SDA low
	                sda_chk <= #1 1'b0; // don't check SDA output
	            end

	            stop_d:
	            begin
	                c_state <= #1 idle;
	                cmd_ack <= #1 1'b1;
	                scl_oen <= #1 1'b1; // keep SCL high
	                sda_oen <= #1 1'b1; // set SDA high
	                sda_chk <= #1 1'b0; // don't check SDA output
	            end

	            // read
	            rd_a:
	            begin
	                c_state <= #1 rd_b;
	                scl_oen <= #1 1'b0; // keep SCL low
	                sda_oen <= #1 1'b1; // tri-state SDA
	                sda_chk <= #1 1'b0; // don't check SDA output
	            end

	            rd_b:
	            begin
	                c_state <= #1 rd_c;
	                scl_oen <= #1 1'b1; // set SCL high
	                sda_oen <= #1 1'b1; // keep SDA tri-stated
	                sda_chk <= #1 1'b0; // don't check SDA output
	            end

	            rd_c:
	            begin
	                c_state <= #1 rd_d;
	                scl_oen <= #1 1'b1; // keep SCL high
	                sda_oen <= #1 1'b1; // keep SDA tri-stated
	                sda_chk <= #1 1'b0; // don't check SDA output
	            end

	            rd_d:
	            begin
	                c_state <= #1 idle;
	                cmd_ack <= #1 1'b1;
	                scl_oen <= #1 1'b0; // set SCL low
	                sda_oen <= #1 1'b1; // keep SDA tri-stated
	                sda_chk <= #1 1'b0; // don't check SDA output
	            end

	            // write
	            wr_a:
	            begin
	                c_state <= #1 wr_b;
	                scl_oen <= #1 1'b0; // keep SCL low
	                sda_oen <= #1 din;  // set SDA
	                sda_chk <= #1 1'b0; // don't check SDA output (SCL low)
	            end

	            wr_b:
	            begin
	                c_state <= #1 wr_c;
	                scl_oen <= #1 1'b1; // set SCL high
	                sda_oen <= #1 din;  // keep SDA
	                sda_chk <= #1 1'b1; // check SDA output
	            end

	            wr_c:
	            begin
	                c_state <= #1 wr_d;
	                scl_oen <= #1 1'b1; // keep SCL high
	                sda_oen <= #1 din;
	                sda_chk <= #1 1'b1; // check SDA output
	            end

	            wr_d:
	            begin
	                c_state <= #1 idle;
	                cmd_ack <= #1 1'b1;
	                scl_oen <= #1 1'b0; // set SCL low
	                sda_oen <= #1 din;
	                sda_chk <= #1 1'b0; // don't check SDA output (SCL low)
	            end

	          endcase
	    end


	// assign scl and sda output (always gnd)
	assign scl_o = 1'b0;
	assign sda_o = 1'b0;

endmodule
