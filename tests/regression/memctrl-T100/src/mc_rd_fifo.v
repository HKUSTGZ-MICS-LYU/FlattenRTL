`include "./src/mc_defines.v"

module mc_rd_fifo(clk, rst, clr, din, we, dout, re);

input		clk, rst, clr;
input	[35:0]	din;
input		we;
output	[35:0]	dout;
input		re;

reg	[3:0]	rd_adr, wr_adr;
reg	[35:0]	r0, r1, r2, r3;
reg	[35:0]	dout;

always @(posedge clk or posedge rst)
	if(rst)		rd_adr <= #1 4'h1;
	else
	if(clr)		rd_adr <= #1 4'h1;
	else
	if(re)		rd_adr <= #1 {rd_adr[2:0], rd_adr[3]};

always @(posedge clk or posedge rst)
	if(rst)		wr_adr <= #1 4'h1;
	else
	if(clr)		wr_adr <= #1 4'h1;
	else
	if(we)		wr_adr <= #1 {wr_adr[2:0], wr_adr[3]};

always @(posedge clk)
	if(we & wr_adr[0])	r0 <= #1 din;

always @(posedge clk)
	if(we & wr_adr[1])	r1 <= #1 din;

always @(posedge clk)
	if(we & wr_adr[2])	r2 <= #1 din;

always @(posedge clk)
	if(we & wr_adr[3])	r3 <= #1 din;

always @(rd_adr or r0 or r1 or r2 or r3 or re or we or din)
	case(rd_adr)		// synopsys full_case parallel_case
	   4'h1:	dout = r0;
	   4'h2:	dout = r1;
	   4'h4:	dout = r2;
	   4'h8:	dout = r3;
	endcase

endmodule
