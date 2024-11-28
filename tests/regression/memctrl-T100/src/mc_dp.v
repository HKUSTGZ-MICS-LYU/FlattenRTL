`include "./src/mc_defines.v"

module mc_dp(	clk, rst, csc, 
		wb_cyc_i, wb_stb_i, wb_ack_o, mem_ack, wb_data_i, wb_data_o,
		wb_read_go, wb_we_i,
		mc_clk, mc_data_del, mc_dp_i, mc_data_o, mc_dp_o,

		dv, pack_le0, pack_le1, pack_le2,
		byte_en, par_err
		);

input		clk, rst;
input	[31:0]	csc;

input		wb_cyc_i;
input		wb_stb_i;
input		mem_ack;
input		wb_ack_o;
input	[31:0]	wb_data_i;
output	[31:0]	wb_data_o;
input		wb_read_go;
input		wb_we_i;

input		mc_clk;
input	[35:0]	mc_data_del;
input	[3:0]	mc_dp_i;
output	[31:0]	mc_data_o;
output	[3:0]	mc_dp_o;

input		dv;
input		pack_le0, pack_le1, pack_le2;	// Pack Latch Enable
input	[3:0]	byte_en;			// High Active byte enables
output		par_err;

////////////////////////////////////////////////////////////////////
//
// Local Registers & Wires
//

reg	[31:0]	wb_data_o;
reg	[31:0]	mc_data_o;
wire	[35:0]	rd_fifo_out;
wire		rd_fifo_clr;
reg	[3:0]	mc_dp_o;
reg		par_err_r;

reg	[7:0]	byte0, byte1, byte2;
reg	[31:0]	mc_data_d;

wire	[2:0]	mem_type;
wire	[1:0]	bus_width;
wire		pen;
wire		re;

// Aliases
assign mem_type  = csc[3:1];
assign bus_width = csc[5:4];
assign pen       = csc[11];

////////////////////////////////////////////////////////////////////
//
// WB READ Data Path
//

always @(mem_type or rd_fifo_out or mc_data_d)
	if( (mem_type == `MC_MEM_TYPE_SDRAM) |
	    (mem_type == `MC_MEM_TYPE_SRAM)  )	wb_data_o = rd_fifo_out[31:0];
	else					wb_data_o = mc_data_d;

//assign rd_fifo_clr = !(rst | !wb_cyc_i | (wb_we_i & wb_stb_i) );
assign rd_fifo_clr = !wb_cyc_i | (wb_we_i & wb_stb_i);
assign re = wb_ack_o & wb_read_go;

mc_rd_fifo u0(
	.clk(	clk			),
	.rst(	rst			),
	.clr(	rd_fifo_clr		),
	.din(	mc_data_del		),
	.we(	dv			),
	.dout(	rd_fifo_out		),
	.re(	re			)
	);

////////////////////////////////////////////////////////////////////
//
// WB WRITE Data Path
//

always @(posedge clk)
	if(wb_ack_o | (mem_type != `MC_MEM_TYPE_SDRAM) )
		mc_data_o <= #1 wb_data_i;

////////////////////////////////////////////////////////////////////
//
// Read Data Packing
//

always @(posedge clk)
	if(pack_le0)				byte0 <= #1 mc_data_del[7:0];

always @(posedge clk)
	if(pack_le1 & (bus_width == `MC_BW_8))	byte1 <= #1 mc_data_del[7:0];
	else
	if(pack_le0 & (bus_width == `MC_BW_16))	byte1 <= #1 mc_data_del[15:8];

always @(posedge clk)
	if(pack_le2)				byte2 <= #1 mc_data_del[7:0];

always @(bus_width or mc_data_del or byte0 or byte1 or byte2)
	if(bus_width == `MC_BW_8)	mc_data_d = {mc_data_del[7:0], byte2, byte1, byte0};
	else
	if(bus_width == `MC_BW_16)	mc_data_d = {mc_data_del[15:0], byte1, byte0};
	else				mc_data_d = mc_data_del[31:0];

////////////////////////////////////////////////////////////////////
//
// Parity Generation
//

always @(posedge clk)
	if(wb_ack_o | (mem_type != `MC_MEM_TYPE_SDRAM) ) begin
	//	mc_dp_o <= #1	{ ^wb_data_i[31:24], ^wb_data_i[23:16],
	//			    ^wb_data_i[15:08], ^wb_data_i[07:00] };
		mc_dp_o <= #1 4'b1010;
	end

////////////////////////////////////////////////////////////////////
//
// Parity Checking
//

/*assign	par_err = !wb_we_i & mem_ack & pen & (
				(( ^rd_fifo_out[31:24] ^ rd_fifo_out[35] ) & byte_en[3] ) |
				(( ^rd_fifo_out[23:16] ^ rd_fifo_out[34] ) & byte_en[2] ) |
				(( ^rd_fifo_out[15:08] ^ rd_fifo_out[33] ) & byte_en[1] ) |
				(( ^rd_fifo_out[07:00] ^ rd_fifo_out[32] ) & byte_en[0] )
			);*/

assign	par_err = !wb_we_i & mem_ack & pen;

endmodule

