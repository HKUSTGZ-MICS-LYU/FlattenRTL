module alu (
	a,
	b,
	cmd,
	r
);
	input [15:0] a;
	input [15:0] b;
	input [2:0] cmd;
	output reg [15:0] r;
	always @(*)
		case (cmd)
			3'bxxx: r = 16'bxxxxxxxxxxxxxxxx;
			3'b000: r = a + b;
			3'b001: r = a - b;
			3'b010: r = a & b;
			3'b011: r = a | b;
			3'b100: r = a ^ b;
			3'b101: r = a << b;
			3'b110: r = {{16 {a[15]}}, a} >> b;
			3'b111: r = {16'b0000000000000000, a} >> b;
			default: begin
				r = 0;
				$display("ERROR: Unknown alu cmd: %b \n", cmd);
			end
		endcase
endmodule
module EX_stage (
	clk,
	rst,
	pipeline_reg_in,
	pipeline_reg_out,
	ex_op_dest
);
	input clk;
	input rst;
	input [56:0] pipeline_reg_in;
	output reg [37:0] pipeline_reg_out;
	output wire [2:0] ex_op_dest;
	wire [2:0] alu_cmd = pipeline_reg_in[56:54];
	wire [15:0] alu_src1 = pipeline_reg_in[53:38];
	wire [15:0] alu_src2 = pipeline_reg_in[37:22];
	wire [15:0] ex_alu_result;
	alu alu_inst(
		.a(alu_src1),
		.b(alu_src2),
		.cmd(alu_cmd),
		.r(ex_alu_result)
	);
	always @(posedge clk)
		if (rst)
			pipeline_reg_out[37:0] <= 0;
		else begin
			pipeline_reg_out[37:22] <= ex_alu_result;
			pipeline_reg_out[21:0] <= pipeline_reg_in[21:0];
		end
	assign ex_op_dest = pipeline_reg_in[3:1];
endmodule
module instruction_mem (
	clk,
	pc,
	instruction
);
	input clk;
	input [7:0] pc;
	output wire [15:0] instruction;
	reg [15:0] rom [255:0];
	wire [7:0] rom_addr = pc[7:0];
	assign instruction = rom[rom_addr];
endmodule
module MEM_stage (
	clk,
	rst,
	pipeline_reg_in,
	pipeline_reg_out,
	mem_op_dest
);
	input clk;
	input rst;
	input [37:0] pipeline_reg_in;
	output reg [36:0] pipeline_reg_out;
	output wire [2:0] mem_op_dest;
	wire [15:0] ex_alu_result = pipeline_reg_in[37:22];
	wire mem_write_en = pipeline_reg_in[21];
	wire [15:0] mem_write_data = pipeline_reg_in[20:5];
	wire [15:0] mem_read_data;
	data_mem dmem(
		.clk(clk),
		.mem_access_addr(ex_alu_result),
		.mem_write_data(mem_write_data),
		.mem_write_en(mem_write_en),
		.mem_read_data(mem_read_data)
	);
	always @(posedge clk)
		if (rst)
			pipeline_reg_out[36:0] <= 0;
		else begin
			pipeline_reg_out[36:21] <= ex_alu_result;
			pipeline_reg_out[20:5] <= mem_read_data;
			pipeline_reg_out[4:0] <= pipeline_reg_in[4:0];
		end
	assign mem_op_dest = pipeline_reg_in[3:1];
endmodule
module ID_stage (
	clk,
	rst,
	instruction_decode_en,
	pipeline_reg_out,
	instruction,
	branch_offset_imm,
	branch_taken,
	reg_read_addr_1,
	reg_read_addr_2,
	reg_read_data_1,
	reg_read_data_2,
	decoding_op_src1,
	decoding_op_src2
);
	input clk;
	input rst;
	input instruction_decode_en;
	output reg [56:0] pipeline_reg_out;
	input [15:0] instruction;
	output wire [5:0] branch_offset_imm;
	output reg branch_taken;
	output wire [2:0] reg_read_addr_1;
	output wire [2:0] reg_read_addr_2;
	input [15:0] reg_read_data_1;
	input [15:0] reg_read_data_2;
	output wire [2:0] decoding_op_src1;
	output wire [2:0] decoding_op_src2;
	reg [15:0] instruction_reg;
	wire [3:0] ir_op_code;
	wire [2:0] ir_dest;
	wire [2:0] ir_src1;
	wire [2:0] ir_src2;
	wire [5:0] ir_imm;
	reg write_back_en;
	wire [2:0] write_back_dest;
	reg write_back_result_mux;
	wire mem_write_en;
	wire [15:0] mem_write_data;
	reg [2:0] ex_alu_cmd;
	wire [15:0] ex_alu_src1;
	wire [15:0] ex_alu_src2;
	reg alu_src2_mux;
	wire decoding_op_is_branch;
	wire decoding_op_is_store;
	wire [3:0] ir_op_code_with_bubble;
	wire [2:0] ir_dest_with_bubble;
	always @(posedge clk or posedge rst)
		if (rst)
			instruction_reg <= 0;
		else if (instruction_decode_en)
			instruction_reg <= instruction;
	assign ir_op_code = instruction_reg[15:12];
	assign ir_dest = instruction_reg[11:9];
	assign ir_src1 = instruction_reg[8:6];
	assign ir_src2 = (decoding_op_is_store ? instruction_reg[11:9] : instruction_reg[5:3]);
	assign ir_imm = instruction_reg[5:0];
	assign ir_op_code_with_bubble = (instruction_decode_en ? ir_op_code : 0);
	assign ir_dest_with_bubble = (instruction_decode_en ? ir_dest : 0);
	always @(*)
		if (rst) begin
			write_back_en = 0;
			write_back_result_mux = 0;
			ex_alu_cmd = 0;
			alu_src2_mux = 0;
		end
		else
			case (ir_op_code_with_bubble)
				4'b0000: begin
					write_back_en = 0;
					write_back_result_mux = 1'bx;
					ex_alu_cmd = 3'bxxx;
					alu_src2_mux = 1'bx;
				end
				4'b0001: begin
					write_back_en = 1;
					write_back_result_mux = 0;
					ex_alu_cmd = 3'b000;
					alu_src2_mux = 0;
				end
				4'b0010: begin
					write_back_en = 1;
					write_back_result_mux = 0;
					ex_alu_cmd = 3'b001;
					alu_src2_mux = 0;
				end
				4'b0011: begin
					write_back_en = 1;
					write_back_result_mux = 0;
					ex_alu_cmd = 3'b010;
					alu_src2_mux = 0;
				end
				4'b0100: begin
					write_back_en = 1;
					write_back_result_mux = 0;
					ex_alu_cmd = 3'b011;
					alu_src2_mux = 0;
				end
				4'b0101: begin
					write_back_en = 1;
					write_back_result_mux = 0;
					ex_alu_cmd = 3'b100;
					alu_src2_mux = 1'bx;
				end
				4'b0110: begin
					write_back_en = 1;
					write_back_result_mux = 0;
					ex_alu_cmd = 3'b101;
					alu_src2_mux = 0;
				end
				4'b0111: begin
					write_back_en = 1;
					write_back_result_mux = 0;
					ex_alu_cmd = 3'b110;
					alu_src2_mux = 0;
				end
				4'b1000: begin
					write_back_en = 1;
					write_back_result_mux = 0;
					ex_alu_cmd = 3'b111;
					alu_src2_mux = 0;
				end
				4'b1001: begin
					write_back_en = 1;
					write_back_result_mux = 0;
					ex_alu_cmd = 3'b000;
					alu_src2_mux = 1;
				end
				4'b1010: begin
					write_back_en = 1;
					write_back_result_mux = 1;
					ex_alu_cmd = 3'b000;
					alu_src2_mux = 1;
				end
				4'b1011: begin
					write_back_en = 0;
					write_back_result_mux = 1'bx;
					ex_alu_cmd = 3'b000;
					alu_src2_mux = 1;
				end
				4'b1100: begin
					write_back_en = 0;
					write_back_result_mux = 1'bx;
					ex_alu_cmd = 3'bxxx;
					alu_src2_mux = 1;
				end
				default: begin
					write_back_en = 0;
					write_back_result_mux = 1'bx;
					ex_alu_cmd = 3'bxxx;
					alu_src2_mux = 1'bx;
					$display("ERROR: Unknown Instruction: %b", ir_op_code_with_bubble);
				end
			endcase
	assign decoding_op_is_branch = (ir_op_code == 4'b1100 ? 1 : 0);
	assign decoding_op_is_store = (ir_op_code == 4'b1011 ? 1 : 0);
	assign mem_write_data = reg_read_data_2;
	assign mem_write_en = decoding_op_is_store;
	assign write_back_dest = ir_dest_with_bubble;
	assign ex_alu_src1 = reg_read_data_1;
	assign ex_alu_src2 = (alu_src2_mux ? {{10 {ir_imm[5]}}, ir_imm} : reg_read_data_2);
	always @(posedge clk or posedge rst)
		if (rst)
			pipeline_reg_out[56:0] <= 0;
		else
			pipeline_reg_out[56:0] <= {ex_alu_cmd[2:0], ex_alu_src1[15:0], ex_alu_src2[15:0], mem_write_en, mem_write_data[15:0], write_back_en, write_back_dest[2:0], write_back_result_mux};
	assign reg_read_addr_1 = ir_src1;
	assign reg_read_addr_2 = ir_src2;
	always @(*)
		if (decoding_op_is_branch)
			case (ir_dest_with_bubble)
				3'b000:
					if (reg_read_data_1 == 0)
						branch_taken = 1;
					else
						branch_taken = 0;
				default: begin
					branch_taken = 0;
					$display("ERROR: Unknown branch condition %b, in branch instruction %b \n", ir_dest_with_bubble, ir_op_code_with_bubble);
				end
			endcase
		else
			branch_taken = 0;
	assign branch_offset_imm = ir_imm;
	assign decoding_op_src1 = ir_src1;
	assign decoding_op_src2 = ((((ir_op_code == 4'b0000) || (ir_op_code == 4'b1001)) || (ir_op_code == 4'b1010)) || (ir_op_code == 4'b1100) ? 3'b000 : ir_src2);
endmodule
module IF_stage (
	clk,
	rst,
	instruction_fetch_en,
	branch_offset_imm,
	branch_taken,
	pc,
	instruction
);
	input clk;
	input rst;
	input instruction_fetch_en;
	input [5:0] branch_offset_imm;
	input branch_taken;
	output reg [7:0] pc;
	output wire [15:0] instruction;
	always @(posedge clk or posedge rst)
		if (rst)
			pc <= 8'b00000000;
		else if (instruction_fetch_en) begin
			if (branch_taken)
				pc <= pc + {{2 {branch_offset_imm[5]}}, branch_offset_imm[5:0]};
			else
				pc <= pc + 8'd1;
		end
	instruction_mem imem(
		.clk(clk),
		.pc(pc),
		.instruction(instruction)
	);
endmodule
module WB_stage (
	pipeline_reg_in,
	reg_write_en,
	reg_write_dest,
	reg_write_data,
	wb_op_dest
);
	input [36:0] pipeline_reg_in;
	output wire reg_write_en;
	output wire [2:0] reg_write_dest;
	output wire [15:0] reg_write_data;
	output wire [2:0] wb_op_dest;
	wire [15:0] ex_alu_result = pipeline_reg_in[36:21];
	wire [15:0] mem_read_data = pipeline_reg_in[20:5];
	wire write_back_en = pipeline_reg_in[4];
	wire [2:0] write_back_dest = pipeline_reg_in[3:1];
	wire write_back_result_mux = pipeline_reg_in[0];
	assign reg_write_en = write_back_en;
	assign reg_write_dest = write_back_dest;
	assign reg_write_data = (write_back_result_mux ? mem_read_data : ex_alu_result);
	assign wb_op_dest = pipeline_reg_in[3:1];
endmodule
module hazard_detection_unit (
	decoding_op_src1,
	decoding_op_src2,
	ex_op_dest,
	mem_op_dest,
	wb_op_dest,
	pipeline_stall_n
);
	input [2:0] decoding_op_src1;
	input [2:0] decoding_op_src2;
	input [2:0] ex_op_dest;
	input [2:0] mem_op_dest;
	input [2:0] wb_op_dest;
	output reg pipeline_stall_n;
	always @(*) begin
		pipeline_stall_n = 1;
		if ((decoding_op_src1 != 0) && (((decoding_op_src1 == ex_op_dest) || (decoding_op_src1 == mem_op_dest)) || (decoding_op_src1 == wb_op_dest)))
			pipeline_stall_n = 0;
		if ((decoding_op_src2 != 0) && (((decoding_op_src2 == ex_op_dest) || (decoding_op_src2 == mem_op_dest)) || (decoding_op_src2 == wb_op_dest)))
			pipeline_stall_n = 0;
	end
endmodule
module mips_16_core_top (
	clk,
	rst,
	pc
);
	input clk;
	input rst;
	output wire [7:0] pc;
	wire pipeline_stall_n;
	wire [5:0] branch_offset_imm;
	wire branch_taken;
	wire [15:0] instruction;
	wire [56:0] ID_pipeline_reg_out;
	wire [37:0] EX_pipeline_reg_out;
	wire [36:0] MEM_pipeline_reg_out;
	wire [2:0] reg_read_addr_1;
	wire [2:0] reg_read_addr_2;
	wire [15:0] reg_read_data_1;
	wire [15:0] reg_read_data_2;
	wire [2:0] decoding_op_src1;
	wire [2:0] decoding_op_src2;
	wire [2:0] ex_op_dest;
	wire [2:0] mem_op_dest;
	wire [2:0] wb_op_dest;
	wire reg_write_en;
	wire [2:0] reg_write_dest;
	wire [15:0] reg_write_data;
	
    // INSTANCE: [IF_stage_inst]
    wire IF_stage_inst___clk;
    assign IF_stage_inst___clk = clk;
    wire IF_stage_inst___rst;
    assign IF_stage_inst___rst = rst;
    wire IF_stage_inst___instruction_fetch_en;
    assign IF_stage_inst___instruction_fetch_en = pipeline_stall_n;
    wire[5:0] IF_stage_inst___branch_offset_imm;
    assign IF_stage_inst___branch_offset_imm = branch_offset_imm;
    wire IF_stage_inst___branch_taken;
    assign IF_stage_inst___branch_taken = branch_taken;
    reg[7:0] IF_stage_inst___pc;
    assign pc = IF_stage_inst___pc;
    wire IF_stage_inst___instruction;
    assign instruction = IF_stage_inst___instruction;

    always @(  posedge   IF_stage_inst___clk          or  posedge  IF_stage_inst___rst )
         if ( IF_stage_inst___rst ) 
             IF_stage_inst___pc  <=8'b00000000;
          else 
             if ( IF_stage_inst___instruction_fetch_en )
                 begin 
                     if ( IF_stage_inst___branch_taken ) 
                         IF_stage_inst___pc  <= IF_stage_inst___pc +{{2{ IF_stage_inst___branch_offset_imm [5]}}, IF_stage_inst___branch_offset_imm [5:0]};
                      else  
                         IF_stage_inst___pc  <= IF_stage_inst___pc +8'd1;
                 end
    
    // INSTANCE: [IF_stage_inst___imem]
    wire IF_stage_inst___imem___clk;
    assign IF_stage_inst___imem___clk = IF_stage_inst___clk;
    wire[7:0] IF_stage_inst___imem___pc;
    assign IF_stage_inst___imem___pc = IF_stage_inst___pc;
    wire IF_stage_inst___imem___instruction;
    assign IF_stage_inst___instruction = IF_stage_inst___imem___instruction;

    reg[15:0] IF_stage_inst___imem___rom [255:0]; 
    wire[7:0] IF_stage_inst___imem___rom_addr = IF_stage_inst___imem___pc [7:0]; 
  assign  IF_stage_inst___imem___instruction = IF_stage_inst___imem___rom [ IF_stage_inst___imem___rom_addr ];
    

    // INSTANCE: [ID_stage_inst]
    wire ID_stage_inst___clk;
    assign ID_stage_inst___clk = clk;
    wire ID_stage_inst___rst;
    assign ID_stage_inst___rst = rst;
    wire ID_stage_inst___instruction_decode_en;
    assign ID_stage_inst___instruction_decode_en = pipeline_stall_n;
    reg[56:0] ID_stage_inst___pipeline_reg_out;
    assign ID_pipeline_reg_out = ID_stage_inst___pipeline_reg_out;
    wire[15:0] ID_stage_inst___instruction;
    assign ID_stage_inst___instruction = instruction;
    wire ID_stage_inst___branch_offset_imm;
    assign branch_offset_imm = ID_stage_inst___branch_offset_imm;
    reg ID_stage_inst___branch_taken;
    assign branch_taken = ID_stage_inst___branch_taken;
    wire ID_stage_inst___reg_read_addr_1;
    assign reg_read_addr_1 = ID_stage_inst___reg_read_addr_1;
    wire ID_stage_inst___reg_read_addr_2;
    assign reg_read_addr_2 = ID_stage_inst___reg_read_addr_2;
    wire[15:0] ID_stage_inst___reg_read_data_1;
    assign ID_stage_inst___reg_read_data_1 = reg_read_data_1;
    wire[15:0] ID_stage_inst___reg_read_data_2;
    assign ID_stage_inst___reg_read_data_2 = reg_read_data_2;
    wire ID_stage_inst___decoding_op_src1;
    assign decoding_op_src1 = ID_stage_inst___decoding_op_src1;
    wire ID_stage_inst___decoding_op_src2;
    assign decoding_op_src2 = ID_stage_inst___decoding_op_src2;
    reg[15:0] ID_stage_inst___instruction_reg ; 
    wire[3:0] ID_stage_inst___ir_op_code ; 
    wire[2:0] ID_stage_inst___ir_dest ; 
    wire[2:0] ID_stage_inst___ir_src1 ; 
    wire[2:0] ID_stage_inst___ir_src2 ; 
    wire[5:0] ID_stage_inst___ir_imm ; 
    reg ID_stage_inst___write_back_en ; 
    wire[2:0] ID_stage_inst___write_back_dest ; 
    reg ID_stage_inst___write_back_result_mux ; 
    wire ID_stage_inst___mem_write_en ; 
    wire[15:0] ID_stage_inst___mem_write_data ; reg[2:0] ID_stage_inst___ex_alu_cmd ; 
    wire[15:0] ID_stage_inst___ex_alu_src1 ; 
    wire[15:0] ID_stage_inst___ex_alu_src2 ; 
    reg ID_stage_inst___alu_src2_mux ; 
    wire ID_stage_inst___decoding_op_is_branch ; 
    wire ID_stage_inst___decoding_op_is_store ; 
    wire[3:0] ID_stage_inst___ir_op_code_with_bubble ; 
    wire[2:0] ID_stage_inst___ir_dest_with_bubble ; 
  always @(  posedge   ID_stage_inst___clk          or  posedge  ID_stage_inst___rst )
         if ( ID_stage_inst___rst ) 
             ID_stage_inst___instruction_reg  <=0;
          else 
             if ( ID_stage_inst___instruction_decode_en ) 
                 ID_stage_inst___instruction_reg  <= ID_stage_inst___instruction ;
  assign  ID_stage_inst___ir_op_code = ID_stage_inst___instruction_reg [15:12]; 
  assign  ID_stage_inst___ir_dest = ID_stage_inst___instruction_reg [11:9]; 
  assign  ID_stage_inst___ir_src1 = ID_stage_inst___instruction_reg [8:6]; 
  assign  ID_stage_inst___ir_src2 =( ID_stage_inst___decoding_op_is_store  ?  ID_stage_inst___instruction_reg [11:9]: ID_stage_inst___instruction_reg [5:3]); 
  assign  ID_stage_inst___ir_imm = ID_stage_inst___instruction_reg [5:0]; 
  assign  ID_stage_inst___ir_op_code_with_bubble =( ID_stage_inst___instruction_decode_en  ?  ID_stage_inst___ir_op_code :0); 
  assign  ID_stage_inst___ir_dest_with_bubble =( ID_stage_inst___instruction_decode_en  ?  ID_stage_inst___ir_dest :0); 
  always @(*)
         if ( ID_stage_inst___rst )
             begin  
                 ID_stage_inst___write_back_en  =0; 
                 ID_stage_inst___write_back_result_mux  =0; 
                 ID_stage_inst___ex_alu_cmd  =0; 
                 ID_stage_inst___alu_src2_mux  =0;
             end 
          else 
             case ( ID_stage_inst___ir_op_code_with_bubble )
              4 'b0000:
                  begin  
                      ID_stage_inst___write_back_en  =0; 
                      ID_stage_inst___write_back_result_mux  =1'bx; 
                      ID_stage_inst___ex_alu_cmd  =3'bxxx; 
                      ID_stage_inst___alu_src2_mux  =1'bx;
                  end 
              4 'b0001:
                  begin  
                      ID_stage_inst___write_back_en  =1; 
                      ID_stage_inst___write_back_result_mux  =0; 
                      ID_stage_inst___ex_alu_cmd  =3'b000; 
                      ID_stage_inst___alu_src2_mux  =0;
                  end 
              4 'b0010:
                  begin  
                      ID_stage_inst___write_back_en  =1; 
                      ID_stage_inst___write_back_result_mux  =0; 
                      ID_stage_inst___ex_alu_cmd  =3'b001; 
                      ID_stage_inst___alu_src2_mux  =0;
                  end 
              4 'b0011:
                  begin  
                      ID_stage_inst___write_back_en  =1; 
                      ID_stage_inst___write_back_result_mux  =0; 
                      ID_stage_inst___ex_alu_cmd  =3'b010; 
                      ID_stage_inst___alu_src2_mux  =0;
                  end 
              4 'b0100:
                  begin  
                      ID_stage_inst___write_back_en  =1; 
                      ID_stage_inst___write_back_result_mux  =0; 
                      ID_stage_inst___ex_alu_cmd  =3'b011; 
                      ID_stage_inst___alu_src2_mux  =0;
                  end 
              4 'b0101:
                  begin  
                      ID_stage_inst___write_back_en  =1; 
                      ID_stage_inst___write_back_result_mux  =0; 
                      ID_stage_inst___ex_alu_cmd  =3'b100; 
                      ID_stage_inst___alu_src2_mux  =1'bx;
                  end 
              4 'b0110:
                  begin  
                      ID_stage_inst___write_back_en  =1; 
                      ID_stage_inst___write_back_result_mux  =0; 
                      ID_stage_inst___ex_alu_cmd  =3'b101; 
                      ID_stage_inst___alu_src2_mux  =0;
                  end 
              4 'b0111:
                  begin  
                      ID_stage_inst___write_back_en  =1; 
                      ID_stage_inst___write_back_result_mux  =0; 
                      ID_stage_inst___ex_alu_cmd  =3'b110; 
                      ID_stage_inst___alu_src2_mux  =0;
                  end 
              4 'b1000:
                  begin  
                      ID_stage_inst___write_back_en  =1; 
                      ID_stage_inst___write_back_result_mux  =0; 
                      ID_stage_inst___ex_alu_cmd  =3'b111; 
                      ID_stage_inst___alu_src2_mux  =0;
                  end 
              4 'b1001:
                  begin  
                      ID_stage_inst___write_back_en  =1; 
                      ID_stage_inst___write_back_result_mux  =0; 
                      ID_stage_inst___ex_alu_cmd  =3'b000; 
                      ID_stage_inst___alu_src2_mux  =1;
                  end 
              4 'b1010:
                  begin  
                      ID_stage_inst___write_back_en  =1; 
                      ID_stage_inst___write_back_result_mux  =1; 
                      ID_stage_inst___ex_alu_cmd  =3'b000; 
                      ID_stage_inst___alu_src2_mux  =1;
                  end 
              4 'b1011:
                  begin  
                      ID_stage_inst___write_back_en  =0; 
                      ID_stage_inst___write_back_result_mux  =1'bx; 
                      ID_stage_inst___ex_alu_cmd  =3'b000; 
                      ID_stage_inst___alu_src2_mux  =1;
                  end 
              4 'b1100:
                  begin  
                      ID_stage_inst___write_back_en  =0; 
                      ID_stage_inst___write_back_result_mux  =1'bx; 
                      ID_stage_inst___ex_alu_cmd  =3'bxxx; 
                      ID_stage_inst___alu_src2_mux  =1;
                  end 
              default :
                  begin  
                      ID_stage_inst___write_back_en  =0; 
                      ID_stage_inst___write_back_result_mux  =1'bx; 
                      ID_stage_inst___ex_alu_cmd  =3'bxxx; 
                      ID_stage_inst___alu_src2_mux  =1'bx;$display("ERROR: Unknown Instruction: %b", ID_stage_inst___ir_op_code_with_bubble );
                  end endcase
  assign  ID_stage_inst___decoding_op_is_branch =( ID_stage_inst___ir_op_code ==4'b1100 ? 1:0); 
  assign  ID_stage_inst___decoding_op_is_store =( ID_stage_inst___ir_op_code ==4'b1011 ? 1:0); 
  assign  ID_stage_inst___mem_write_data = ID_stage_inst___reg_read_data_2 ; 
  assign  ID_stage_inst___mem_write_en = ID_stage_inst___decoding_op_is_store ; 
  assign  ID_stage_inst___write_back_dest = ID_stage_inst___ir_dest_with_bubble ; 
  assign  ID_stage_inst___ex_alu_src1 = ID_stage_inst___reg_read_data_1 ; 
  assign  ID_stage_inst___ex_alu_src2 =( ID_stage_inst___alu_src2_mux  ? {{10{ ID_stage_inst___ir_imm [5]}}, ID_stage_inst___ir_imm }: ID_stage_inst___reg_read_data_2 ); 
  always @(  posedge   ID_stage_inst___clk          or  posedge  ID_stage_inst___rst )
         if ( ID_stage_inst___rst ) 
             ID_stage_inst___pipeline_reg_out  [56:0]<=0;
          else  
             ID_stage_inst___pipeline_reg_out  [56:0]<={ ID_stage_inst___ex_alu_cmd [2:0], ID_stage_inst___ex_alu_src1 [15:0], ID_stage_inst___ex_alu_src2 [15:0], ID_stage_inst___mem_write_en , ID_stage_inst___mem_write_data [15:0], ID_stage_inst___write_back_en , ID_stage_inst___write_back_dest [2:0], ID_stage_inst___write_back_result_mux };
  assign  ID_stage_inst___reg_read_addr_1 = ID_stage_inst___ir_src1 ; 
  assign  ID_stage_inst___reg_read_addr_2 = ID_stage_inst___ir_src2 ; 
  always @(*)
         if ( ID_stage_inst___decoding_op_is_branch )
             case ( ID_stage_inst___ir_dest_with_bubble )
              3 'b000:
                  if ( ID_stage_inst___reg_read_data_1 ==0) 
                      ID_stage_inst___branch_taken  =1;
                   else  
                      ID_stage_inst___branch_taken  =0;
              default :
                  begin  
                      ID_stage_inst___branch_taken  =0;$display("ERROR: Unknown branch condition %b, in branch instruction %b \n", ID_stage_inst___ir_dest_with_bubble , ID_stage_inst___ir_op_code_with_bubble );
                  end endcase
          else  
             ID_stage_inst___branch_taken  =0;
  assign  ID_stage_inst___branch_offset_imm = ID_stage_inst___ir_imm ; 
  assign  ID_stage_inst___decoding_op_src1 = ID_stage_inst___ir_src1 ; 
  assign  ID_stage_inst___decoding_op_src2 =(((( ID_stage_inst___ir_op_code ==4'b0000)||( ID_stage_inst___ir_op_code ==4'b1001))||( ID_stage_inst___ir_op_code ==4'b1010))||( ID_stage_inst___ir_op_code ==4'b1100) ? 3'b000: ID_stage_inst___ir_src2 );

    // INSTANCE: [EX_stage_inst]
    wire EX_stage_inst___clk;
    assign EX_stage_inst___clk = clk;
    wire EX_stage_inst___rst;
    assign EX_stage_inst___rst = rst;
    wire[56:0] EX_stage_inst___pipeline_reg_in;
    assign EX_stage_inst___pipeline_reg_in = ID_pipeline_reg_out;
    reg[37:0] EX_stage_inst___pipeline_reg_out;
    assign EX_pipeline_reg_out = EX_stage_inst___pipeline_reg_out;
    wire EX_stage_inst___ex_op_dest;
    assign ex_op_dest = EX_stage_inst___ex_op_dest;
    wire[2:0] EX_stage_inst___alu_cmd = EX_stage_inst___pipeline_reg_in [56:54]; 
    wire[15:0] EX_stage_inst___alu_src1 = EX_stage_inst___pipeline_reg_in [53:38]; 
    wire[15:0] EX_stage_inst___alu_src2 = EX_stage_inst___pipeline_reg_in [37:22]; 
    wire[15:0] EX_stage_inst___ex_alu_result ;  
    

    // INSTANCE: [EX_stage_inst___alu_inst]
    wire[15:0] EX_stage_inst___alu_inst___a;
    assign EX_stage_inst___alu_inst___a = EX_stage_inst___alu_src1;
    wire[15:0] EX_stage_inst___alu_inst___b;
    assign EX_stage_inst___alu_inst___b = EX_stage_inst___alu_src2;
    wire[2:0] EX_stage_inst___alu_inst___cmd;
    assign EX_stage_inst___alu_inst___cmd = EX_stage_inst___alu_cmd;
    reg[15:0] EX_stage_inst___alu_inst___r;
    assign EX_stage_inst___ex_alu_result = EX_stage_inst___alu_inst___r;
    always @(*)
         case ( EX_stage_inst___alu_inst___cmd )
          3 'bxxx: 
              EX_stage_inst___alu_inst___r  =16'bxxxxxxxxxxxxxxxx;
          3 'b000: 
              EX_stage_inst___alu_inst___r  = EX_stage_inst___alu_inst___a + EX_stage_inst___alu_inst___b ;
          3 'b001: 
              EX_stage_inst___alu_inst___r  = EX_stage_inst___alu_inst___a - EX_stage_inst___alu_inst___b ;
          3 'b010: 
              EX_stage_inst___alu_inst___r  = EX_stage_inst___alu_inst___a & EX_stage_inst___alu_inst___b ;
          3 'b011: 
              EX_stage_inst___alu_inst___r  = EX_stage_inst___alu_inst___a | EX_stage_inst___alu_inst___b ;
          3 'b100: 
              EX_stage_inst___alu_inst___r  = EX_stage_inst___alu_inst___a ^ EX_stage_inst___alu_inst___b ;
          3 'b101: 
              EX_stage_inst___alu_inst___r  = EX_stage_inst___alu_inst___a << EX_stage_inst___alu_inst___b ;
          3 'b110: 
              EX_stage_inst___alu_inst___r  ={{16{ EX_stage_inst___alu_inst___a [15]}}, EX_stage_inst___alu_inst___a }>> EX_stage_inst___alu_inst___b ;
          3 'b111: 
              EX_stage_inst___alu_inst___r  ={16'b0000000000000000, EX_stage_inst___alu_inst___a }>> EX_stage_inst___alu_inst___b ;
          default :
              begin  
                  EX_stage_inst___alu_inst___r  =0;$display("ERROR: Unknown alu cmd: %b \n", EX_stage_inst___alu_inst___cmd );
              end endcase

     
  always @( posedge  EX_stage_inst___clk )
         if ( EX_stage_inst___rst ) 
             EX_stage_inst___pipeline_reg_out  [37:0]<=0;
          else 
             begin  
                 EX_stage_inst___pipeline_reg_out  [37:22]<= EX_stage_inst___ex_alu_result ; 
                 EX_stage_inst___pipeline_reg_out  [21:0]<= EX_stage_inst___pipeline_reg_in [21:0];
             end
  assign  EX_stage_inst___ex_op_dest = EX_stage_inst___pipeline_reg_in [3:1];

    // INSTANCE: [MEM_stage_inst]
    wire MEM_stage_inst___clk;
    assign MEM_stage_inst___clk = clk;
    wire MEM_stage_inst___rst;
    assign MEM_stage_inst___rst = rst;
    wire[37:0] MEM_stage_inst___pipeline_reg_in;
    assign MEM_stage_inst___pipeline_reg_in = EX_pipeline_reg_out;
    reg[36:0] MEM_stage_inst___pipeline_reg_out;
    assign MEM_pipeline_reg_out = MEM_stage_inst___pipeline_reg_out;
    wire MEM_stage_inst___mem_op_dest;
    assign mem_op_dest = MEM_stage_inst___mem_op_dest;
    wire[15:0] MEM_stage_inst___ex_alu_result = MEM_stage_inst___pipeline_reg_in [37:22]; 
    wire MEM_stage_inst___mem_write_en = MEM_stage_inst___pipeline_reg_in [21]; 
    wire[15:0] MEM_stage_inst___mem_write_data = MEM_stage_inst___pipeline_reg_in [20:5]; 
    wire[15:0] MEM_stage_inst___mem_read_data ;  
    

    // INSTANCE: [MEM_stage_inst___dmem]
    wire MEM_stage_inst___dmem___clk;
    assign MEM_stage_inst___dmem___clk = MEM_stage_inst___clk;
    wire[15:0] MEM_stage_inst___dmem___mem_access_addr;
    assign MEM_stage_inst___dmem___mem_access_addr = MEM_stage_inst___ex_alu_result;
    wire[15:0] MEM_stage_inst___dmem___mem_write_data;
    assign MEM_stage_inst___dmem___mem_write_data = MEM_stage_inst___mem_write_data;
    wire MEM_stage_inst___dmem___mem_write_en;
    assign MEM_stage_inst___dmem___mem_write_en = MEM_stage_inst___mem_write_en;
    wire MEM_stage_inst___dmem___mem_read_data;
    assign MEM_stage_inst___mem_read_data = MEM_stage_inst___dmem___mem_read_data;
    reg[15:0] MEM_stage_inst___dmem___ram [255:0]; 
    wire[7:0] MEM_stage_inst___dmem___ram_addr = MEM_stage_inst___dmem___mem_access_addr [7:0]; 
  always @( posedge  MEM_stage_inst___dmem___clk )
         if ( MEM_stage_inst___dmem___mem_write_en ) 
             MEM_stage_inst___dmem___ram  [ MEM_stage_inst___dmem___ram_addr ]<= MEM_stage_inst___dmem___mem_write_data ;
  assign  MEM_stage_inst___dmem___mem_read_data = MEM_stage_inst___dmem___ram [ MEM_stage_inst___dmem___ram_addr ];
     
  always @( posedge  MEM_stage_inst___clk )
         if ( MEM_stage_inst___rst ) 
             MEM_stage_inst___pipeline_reg_out  [36:0]<=0;
          else 
             begin  
                 MEM_stage_inst___pipeline_reg_out  [36:21]<= MEM_stage_inst___ex_alu_result ; 
                 MEM_stage_inst___pipeline_reg_out  [20:5]<= MEM_stage_inst___mem_read_data ; 
                 MEM_stage_inst___pipeline_reg_out  [4:0]<= MEM_stage_inst___pipeline_reg_in [4:0];
             end
  assign  MEM_stage_inst___mem_op_dest = MEM_stage_inst___pipeline_reg_in [3:1];

    // INSTANCE: [WB_stage_inst]
    wire[36:0] WB_stage_inst___pipeline_reg_in;
    assign WB_stage_inst___pipeline_reg_in = MEM_pipeline_reg_out;
    wire WB_stage_inst___reg_write_en;
    assign reg_write_en = WB_stage_inst___reg_write_en;
    wire WB_stage_inst___reg_write_dest;
    assign reg_write_dest = WB_stage_inst___reg_write_dest;
    wire WB_stage_inst___reg_write_data;
    assign reg_write_data = WB_stage_inst___reg_write_data;
    wire WB_stage_inst___wb_op_dest;
    assign wb_op_dest = WB_stage_inst___wb_op_dest;
    wire[15:0] WB_stage_inst___ex_alu_result = WB_stage_inst___pipeline_reg_in [36:21]; 
    wire[15:0] WB_stage_inst___mem_read_data = WB_stage_inst___pipeline_reg_in [20:5]; 
    wire WB_stage_inst___write_back_en = WB_stage_inst___pipeline_reg_in [4]; 
    wire[2:0] WB_stage_inst___write_back_dest = WB_stage_inst___pipeline_reg_in [3:1]; 
    wire WB_stage_inst___write_back_result_mux = WB_stage_inst___pipeline_reg_in [0]; 
  assign  WB_stage_inst___reg_write_en = WB_stage_inst___write_back_en ; 
  assign  WB_stage_inst___reg_write_dest = WB_stage_inst___write_back_dest ; 
  assign  WB_stage_inst___reg_write_data =( WB_stage_inst___write_back_result_mux  ?  WB_stage_inst___mem_read_data : WB_stage_inst___ex_alu_result ); 
  assign  WB_stage_inst___wb_op_dest = WB_stage_inst___pipeline_reg_in [3:1];

    // INSTANCE: [register_file_inst]
    wire register_file_inst___clk;
    assign register_file_inst___clk = clk;
    wire register_file_inst___rst;
    assign register_file_inst___rst = rst;
    wire register_file_inst___reg_write_en;
    assign register_file_inst___reg_write_en = reg_write_en;
    wire[2:0] register_file_inst___reg_write_dest;
    assign register_file_inst___reg_write_dest = reg_write_dest;
    wire[15:0] register_file_inst___reg_write_data;
    assign register_file_inst___reg_write_data = reg_write_data;
    wire[2:0] register_file_inst___reg_read_addr_1;
    assign register_file_inst___reg_read_addr_1 = reg_read_addr_1;
    wire register_file_inst___reg_read_data_1;
    assign reg_read_data_1 = register_file_inst___reg_read_data_1;
    wire[2:0] register_file_inst___reg_read_addr_2;
    assign register_file_inst___reg_read_addr_2 = reg_read_addr_2;
    wire register_file_inst___reg_read_data_2;
    assign reg_read_data_2 = register_file_inst___reg_read_data_2;
    reg[15:0] register_file_inst___reg_array [7:0]; 
  always @(  posedge   register_file_inst___clk          or  posedge  register_file_inst___rst )
         if ( register_file_inst___rst )
             begin  
                 register_file_inst___reg_array  [0]<=15'b000000000000000; 
                 register_file_inst___reg_array  [1]<=15'b000000000000000; 
                 register_file_inst___reg_array  [2]<=15'b000000000000000; 
                 register_file_inst___reg_array  [3]<=15'b000000000000000; 
                 register_file_inst___reg_array  [4]<=15'b000000000000000; 
                 register_file_inst___reg_array  [5]<=15'b000000000000000; 
                 register_file_inst___reg_array  [6]<=15'b000000000000000; 
                 register_file_inst___reg_array  [7]<=15'b000000000000000;
             end 
          else 
             if ( register_file_inst___reg_write_en ) 
                 register_file_inst___reg_array  [ register_file_inst___reg_write_dest ]<= register_file_inst___reg_write_data ;
  assign  register_file_inst___reg_read_data_1 =( register_file_inst___reg_read_addr_1 ==0 ? 15'b000000000000000: register_file_inst___reg_array [ register_file_inst___reg_read_addr_1 ]); 
  assign  register_file_inst___reg_read_data_2 =( register_file_inst___reg_read_addr_2 ==0 ? 15'b000000000000000: register_file_inst___reg_array [ register_file_inst___reg_read_addr_2 ]);

    // INSTANCE: [hazard_detection_unit_inst]
    wire[2:0] hazard_detection_unit_inst___decoding_op_src1;
    assign hazard_detection_unit_inst___decoding_op_src1 = decoding_op_src1;
    wire[2:0] hazard_detection_unit_inst___decoding_op_src2;
    assign hazard_detection_unit_inst___decoding_op_src2 = decoding_op_src2;
    wire[2:0] hazard_detection_unit_inst___ex_op_dest;
    assign hazard_detection_unit_inst___ex_op_dest = ex_op_dest;
    wire[2:0] hazard_detection_unit_inst___mem_op_dest;
    assign hazard_detection_unit_inst___mem_op_dest = mem_op_dest;
    wire[2:0] hazard_detection_unit_inst___wb_op_dest;
    assign hazard_detection_unit_inst___wb_op_dest = wb_op_dest;
    reg hazard_detection_unit_inst___pipeline_stall_n;
    assign pipeline_stall_n = hazard_detection_unit_inst___pipeline_stall_n;
    always @(*)
         begin  
             hazard_detection_unit_inst___pipeline_stall_n  =1;
             if (( hazard_detection_unit_inst___decoding_op_src1 !=0)&&((( hazard_detection_unit_inst___decoding_op_src1 == hazard_detection_unit_inst___ex_op_dest )||( hazard_detection_unit_inst___decoding_op_src1 == hazard_detection_unit_inst___mem_op_dest ))||( hazard_detection_unit_inst___decoding_op_src1 == hazard_detection_unit_inst___wb_op_dest ))) 
                 hazard_detection_unit_inst___pipeline_stall_n  =0;
             if (( hazard_detection_unit_inst___decoding_op_src2 !=0)&&((( hazard_detection_unit_inst___decoding_op_src2 == hazard_detection_unit_inst___ex_op_dest )||( hazard_detection_unit_inst___decoding_op_src2 == hazard_detection_unit_inst___mem_op_dest ))||( hazard_detection_unit_inst___decoding_op_src2 == hazard_detection_unit_inst___wb_op_dest ))) 
                 hazard_detection_unit_inst___pipeline_stall_n  =0;
         end
 
    
endmodule
module data_mem (
	clk,
	mem_access_addr,
	mem_write_data,
	mem_write_en,
	mem_read_data
);
	input clk;
	input [15:0] mem_access_addr;
	input [15:0] mem_write_data;
	input mem_write_en;
	output wire [15:0] mem_read_data;
	reg [15:0] ram [255:0];
	wire [7:0] ram_addr = mem_access_addr[7:0];
	always @(posedge clk)
		if (mem_write_en)
			ram[ram_addr] <= mem_write_data;
	assign mem_read_data = ram[ram_addr];
endmodule
module register_file (
	clk,
	rst,
	reg_write_en,
	reg_write_dest,
	reg_write_data,
	reg_read_addr_1,
	reg_read_data_1,
	reg_read_addr_2,
	reg_read_data_2
);
	input clk;
	input rst;
	input reg_write_en;
	input [2:0] reg_write_dest;
	input [15:0] reg_write_data;
	input [2:0] reg_read_addr_1;
	output wire [15:0] reg_read_data_1;
	input [2:0] reg_read_addr_2;
	output wire [15:0] reg_read_data_2;
	reg [15:0] reg_array [7:0];
	always @(posedge clk or posedge rst)
		if (rst) begin
			reg_array[0] <= 15'b000000000000000;
			reg_array[1] <= 15'b000000000000000;
			reg_array[2] <= 15'b000000000000000;
			reg_array[3] <= 15'b000000000000000;
			reg_array[4] <= 15'b000000000000000;
			reg_array[5] <= 15'b000000000000000;
			reg_array[6] <= 15'b000000000000000;
			reg_array[7] <= 15'b000000000000000;
		end
		else if (reg_write_en)
			reg_array[reg_write_dest] <= reg_write_data;
	assign reg_read_data_1 = (reg_read_addr_1 == 0 ? 15'b000000000000000 : reg_array[reg_read_addr_1]);
	assign reg_read_data_2 = (reg_read_addr_2 == 0 ? 15'b000000000000000 : reg_array[reg_read_addr_2]);
endmodule

