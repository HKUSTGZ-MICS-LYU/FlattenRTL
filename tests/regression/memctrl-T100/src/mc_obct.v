`include "./src/mc_defines.v"

module mc_obct(clk, rst, row_adr, bank_adr, bank_set, bank_clr, bank_clr_all,
		bank_open, any_bank_open, row_same);
input		clk, rst;
input	[12:0]	row_adr;
input	[1:0]	bank_adr;
input		bank_set;
input		bank_clr;
input		bank_clr_all;
output		bank_open;
output		any_bank_open;
output		row_same;

////////////////////////////////////////////////////////////////////
//
// Local Registers & Wires
//

reg		bank0_open, bank1_open, bank2_open, bank3_open;
reg		bank_open;
reg	[12:0]	b0_last_row;
reg	[12:0]	b1_last_row;
reg	[12:0]	b2_last_row;
reg	[12:0]	b3_last_row;
wire		row0_same, row1_same, row2_same, row3_same;
reg		row_same;

////////////////////////////////////////////////////////////////////
//
// Bank Open/Closed Tracking
//

always @(posedge clk or posedge rst)
	if(rst)					bank0_open <= #1 1'b0;
	else
	if((bank_adr == 2'h0) & bank_set)	bank0_open <= #1 1'b1;
	else
	if((bank_adr == 2'h0) & bank_clr)	bank0_open <= #1 1'b0;
	else
	if(bank_clr_all)			bank0_open <= #1 1'b0;

always @(posedge clk or posedge rst)
	if(rst)					bank1_open <= #1 1'b0;
	else
	if((bank_adr == 2'h1) & bank_set)	bank1_open <= #1 1'b1;
	else
	if((bank_adr == 2'h1) & bank_clr)	bank1_open <= #1 1'b0;
	else
	if(bank_clr_all)			bank1_open <= #1 1'b0;

always @(posedge clk or posedge rst)
	if(rst)					bank2_open <= #1 1'b0;
	else
	if((bank_adr == 2'h2) & bank_set)	bank2_open <= #1 1'b1;
	else
	if((bank_adr == 2'h2) & bank_clr)	bank2_open <= #1 1'b0;
	else
	if(bank_clr_all)			bank2_open <= #1 1'b0;

always @(posedge clk or posedge rst)
	if(rst)					bank3_open <= #1 1'b0;
	else
	if((bank_adr == 2'h3) & bank_set)	bank3_open <= #1 1'b1;
	else
	if((bank_adr == 2'h3) & bank_clr)	bank3_open <= #1 1'b0;
	else
	if(bank_clr_all)			bank3_open <= #1 1'b0;

always @(bank_adr or bank0_open or bank1_open or bank2_open or bank3_open)
	case(bank_adr)		// synopsys full_case parallel_case
	   2'h0: bank_open = bank0_open;
	   2'h1: bank_open = bank1_open;
	   2'h2: bank_open = bank2_open;
	   2'h3: bank_open = bank3_open;
	endcase

assign any_bank_open = bank0_open | bank1_open | bank2_open | bank3_open;

////////////////////////////////////////////////////////////////////
//
// Raw Address Tracking
//

always @(posedge clk)
	if((bank_adr == 2'h0) & bank_set)	b0_last_row <= #1 row_adr;

always @(posedge clk)
	if((bank_adr == 2'h1) & bank_set)	b1_last_row <= #1 row_adr;

always @(posedge clk)
	if((bank_adr == 2'h2) & bank_set)	b2_last_row <= #1 row_adr;

always @(posedge clk)
	if((bank_adr == 2'h3) & bank_set)	b3_last_row <= #1 row_adr;

////////////////////////////////////////////////////////////////////
//
// Raw address checking
//

assign row0_same = (b0_last_row == row_adr);
assign row1_same = (b1_last_row == row_adr);
assign row2_same = (b2_last_row == row_adr);
assign row3_same = (b3_last_row == row_adr);

always @(bank_adr or row0_same or row1_same or row2_same or row3_same)
	case(bank_adr)		// synopsys full_case parallel_case
	   2'h0: row_same = row0_same;
	   2'h1: row_same = row1_same;
	   2'h2: row_same = row2_same;
	   2'h3: row_same = row3_same;
	endcase

endmodule


// This is used for unused Chip Selects
module mc_obct_dummy(clk, rst, row_adr, bank_adr, bank_set, bank_clr, bank_clr_all,
		bank_open, any_bank_open, row_same);
input		clk, rst;
input	[12:0]	row_adr;
input	[1:0]	bank_adr;
input		bank_set;
input		bank_clr;
input		bank_clr_all;
output		bank_open;
output		any_bank_open;
output		row_same;

assign bank_open = 1'b0;
assign any_bank_open = 1'b0;
assign row_same = 1'b0;

endmodule
