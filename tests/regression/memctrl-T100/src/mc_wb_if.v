`include "./src/mc_defines.v"

module mc_wb_if(clk, rst,
		wb_addr_i, wb_cyc_i, wb_stb_i, wb_we_i, wb_err, wb_ack_o,
		wb_read_go, wb_write_go, 
		wb_first, wb_wait, mem_ack, wr_hold,
		err, par_err, wp_err,
		wb_data_o, mem_dout, rf_dout);

input		clk, rst;
input	[31:0]	wb_addr_i;
input		wb_cyc_i;
input		wb_stb_i;
input		wb_we_i;
output		wb_err;
output		wb_ack_o;
output		wb_read_go;
output		wb_write_go;
output		wb_first;
output		wb_wait;
input		mem_ack;
output		wr_hold;
input		err, par_err, wp_err;
output	[31:0]	wb_data_o;
input	[31:0]	mem_dout, rf_dout;

////////////////////////////////////////////////////////////////////
//
// Local Wires and Registers
//

wire		mem_sel;
reg		read_go_r;
reg		read_go_r1;
reg		write_go_r;
reg		write_go_r1;
reg		wb_first_r;
wire		wb_first_set;
reg		wr_hold;
wire		rmw;
reg		rmw_r;
reg		rmw_en;
reg		wb_ack_o;
reg		wb_err;
reg	[31:0]	wb_data_o;

////////////////////////////////////////////////////////////////////
//
// Memory Go Logic
//

assign mem_sel = `MC_MEM_SEL;

always @(posedge clk or posedge rst)
	if(rst)			rmw_en <= #1 1'b0;
	else
	if(wb_ack_o)		rmw_en <= #1 1'b1;
	else
	if(!wb_cyc_i)		rmw_en <= #1 1'b0;

always @(posedge clk or posedge rst)
	if(rst)	rmw_r <= #1 1'b0;
	else	rmw_r <= #1 !wr_hold & wb_we_i & wb_cyc_i & wb_stb_i & rmw_en;

assign rmw = rmw_r | (!wr_hold & wb_we_i & wb_cyc_i & wb_stb_i & rmw_en);

always @(posedge clk or posedge rst)
	if(rst)	read_go_r1 <= #1 1'b0;
	else	read_go_r1 <= #1 !rmw & wb_cyc_i &
				((wb_stb_i & mem_sel & !wb_we_i) | read_go_r);

always @(posedge clk or posedge rst)
	if(rst)	read_go_r <= #1 1'b0;
	else	read_go_r <= #1 read_go_r1 & wb_cyc_i;

assign	wb_read_go = !rmw & read_go_r1 & wb_cyc_i;

always @(posedge clk or posedge rst)
	if(rst)	write_go_r1 <= #1 1'b0;
	else	write_go_r1 <= #1 wb_cyc_i &
				((wb_stb_i & mem_sel & wb_we_i) | write_go_r);

always @(posedge clk or posedge rst)
	if(rst)		write_go_r <= #1 1'b0;
	else		write_go_r <= #1 write_go_r1 & wb_cyc_i &
					((wb_we_i & wb_stb_i) | !wb_stb_i);

assign wb_write_go =	!rmw & write_go_r1 & wb_cyc_i &
			((wb_we_i & wb_stb_i) | !wb_stb_i);

assign wb_first_set = mem_sel & wb_cyc_i & wb_stb_i & !(read_go_r | write_go_r);
assign wb_first = wb_first_set | (wb_first_r & !wb_ack_o & !wb_err);

always @(posedge clk or posedge rst)
	if(rst)			wb_first_r <= #1 1'b0;
	else
	if(wb_first_set)	wb_first_r <= #1 1'b1;
	else
	if(wb_ack_o | wb_err)	wb_first_r <= #1 1'b0;

always @(posedge clk or posedge rst)
	if(rst)			wr_hold <= #1 1'b0;
	else
	if(wb_cyc_i & wb_stb_i)	wr_hold <= #1 wb_we_i;

////////////////////////////////////////////////////////////////////
//
// WB Ack
//

wire	wb_err_d;

// Ack no longer asserted when wb_err is asserted
always @(posedge clk or posedge rst)
	if(rst)	wb_ack_o <= #1 1'b0;
	else	wb_ack_o <= #1 `MC_MEM_SEL ? mem_ack & !wb_err_d :
				`MC_REG_SEL & wb_cyc_i & wb_stb_i & !wb_ack_o;

assign wb_err_d = wb_cyc_i & wb_stb_i & (par_err | err | wp_err);

always @(posedge clk or posedge rst)
	if(rst)	wb_err <= #1 1'b0;
	else	wb_err <= #1 `MC_MEM_SEL & wb_err_d & !wb_err;

////////////////////////////////////////////////////////////////////
//
// Memory Wait Logic
//

assign wb_wait = wb_cyc_i & !wb_stb_i & (wb_write_go | wb_read_go);

////////////////////////////////////////////////////////////////////
//
// WISHBONE Data Output
//

always @(posedge clk)
	wb_data_o <= #1 `MC_MEM_SEL ? mem_dout : rf_dout;

endmodule
