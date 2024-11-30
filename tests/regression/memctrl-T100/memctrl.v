/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















module mc_adr_sel(clk, csc, tms, wb_ack_o, wb_stb_i, wb_addr_i, wb_we_i,
		wb_write_go, wr_hold, cas_,
		mc_addr, row_adr, bank_adr, rfr_ack,
		cs_le, cmd_a10, row_sel, lmr_sel, next_adr, wr_cycle,
		page_size);

input		clk;
input	[31:0]	csc;
input	[31:0]	tms;
input		wb_ack_o, wb_stb_i;
input	[31:0]	wb_addr_i;
input		wb_we_i;
input		wb_write_go;
input		wr_hold;
input		cas_;
output	[23:0]	mc_addr;
output	[12:0]	row_adr;
output	[1:0]	bank_adr;
input		rfr_ack;
input		cs_le;
input		cmd_a10;
input		row_sel;
input		lmr_sel;
input		next_adr;
input		wr_cycle;
output	[10:0]	page_size;

////////////////////////////////////////////////////////////////////
//
// Local Registers & Wires
//

reg	[23:0]	mc_addr_d;
reg	[23:0]	acs_addr;
wire	[23:0]	acs_addr_pl1;
reg	[23:0]	sram_addr;
wire	[14:0]	sdram_adr;
reg	[12:0]	row_adr;
reg	[9:0]	col_adr;
reg	[1:0]	bank_adr;
reg	[10:0]	page_size;

wire	[2:0]	mem_type;
wire	[1:0]	bus_width;
wire	[1:0]	mem_size;
wire		bas;

// Aliases
assign mem_type  = csc[3:1];
assign bus_width = csc[5:4];
assign mem_size  = csc[7:6];
assign bas       = csc[9];

////////////////////////////////////////////////////////////////////
//
// Misc Logic
//

always @(mem_type or wr_hold or sdram_adr or acs_addr or sram_addr or wb_addr_i)
	if(mem_type == 3'h0)		mc_addr_d = {9'h0, sdram_adr};
	else
	if(mem_type == 3'h2)		mc_addr_d = acs_addr;
	else
	if((mem_type == 3'h1) & wr_hold)	mc_addr_d = sram_addr;
	else						mc_addr_d = wb_addr_i[25:2];

assign mc_addr = rfr_ack ? {mc_addr_d[23:11], 1'b1, mc_addr_d[9:0]} : mc_addr_d;

////////////////////////////////////////////////////////////////////
//
// Async Devices Address Latch & Counter
//

mc_incn_r #(24) u0(	.clk(		clk		),
			.inc_in(	acs_addr	),
			.inc_out(	acs_addr_pl1	) );

always @(posedge clk)
	if(wb_stb_i)	sram_addr <= wb_addr_i[25:2];

always @(posedge clk)
	if(cs_le | wb_we_i)
		case(bus_width)		// synopsys full_case parallel_case
		   2'h0:	acs_addr <= wb_addr_i[23:0];
		   2'h1:	acs_addr <= wb_addr_i[24:1];
		   2'h2:	acs_addr <= wb_addr_i[25:2];
		endcase
	else
	if(next_adr)		acs_addr <= acs_addr_pl1;

////////////////////////////////////////////////////////////////////
//
// SDRAM Address Mux
//

assign sdram_adr =	{bank_adr, (lmr_sel & !cas_) ? tms[12:0] :
				row_sel ? row_adr :
				{2'h0, cmd_a10, col_adr}};

//assign sdram_adr[14:13] = bank_adr;

always @(posedge clk)
   if(wr_cycle ? wb_ack_o : wb_stb_i)	
	casex({bus_width, mem_size})		// synopsys full_case parallel_case
	   {2'h0, 2'h0}:		col_adr <= {1'h0, wb_addr_i[10:2]};
	   {2'h0, 2'h1}:	col_adr <=        wb_addr_i[11:2];
	   {2'h0, 2'h2}:	col_adr <=        wb_addr_i[11:2];

	   {2'h1, 2'h0}:	col_adr <= {2'h0, wb_addr_i[09:2]};
	   {2'h1, 2'h1}:	col_adr <= {1'h0, wb_addr_i[10:2]};
	   {2'h1, 2'h2}:	col_adr <= {1'h0, wb_addr_i[10:2]};

	   {2'h2, 2'h0}:	col_adr <= {2'h0, wb_addr_i[09:2]};
	   {2'h2, 2'h1}:	col_adr <= {2'h0, wb_addr_i[09:2]};
	   {2'h2, 2'h2}:	col_adr <= {2'h0, wb_addr_i[09:2]};
	endcase

always @(posedge clk)
   if(cs_le)
     begin
	if(!bas)
		casex({bus_width, mem_size})		// synopsys full_case parallel_case
		   {2'h0, 2'h0}:		row_adr <= {1'h0, wb_addr_i[24:13]};
		   {2'h0, 2'h1}:	row_adr <= {1'h0, wb_addr_i[25:14]};
		   {2'h0, 2'h2}:	row_adr <=        wb_addr_i[26:14];
	
		   {2'h1, 2'h0}:	row_adr <= {1'h0, wb_addr_i[23:12]};
		   {2'h1, 2'h1}:	row_adr <= {1'h0, wb_addr_i[24:13]};
		   {2'h1, 2'h2}:	row_adr <=        wb_addr_i[25:13];
	
		   {2'h2, 2'h0}:	row_adr <= {2'h0, wb_addr_i[22:12]};
		   {2'h2, 2'h1}:	row_adr <= {1'h0, wb_addr_i[23:12]};
		   {2'h2, 2'h2}:	row_adr <=        wb_addr_i[24:12];
		endcase
	else
		casex({bus_width, mem_size})		// synopsys full_case parallel_case
		   {2'h0, 2'h0}:		row_adr <= {1'h0, wb_addr_i[22:11]};
		   {2'h0, 2'h1}:	row_adr <= {1'h0, wb_addr_i[23:12]};
		   {2'h0, 2'h2}:	row_adr <=        wb_addr_i[24:12];
	
		   {2'h1, 2'h0}:	row_adr <= {1'h0, wb_addr_i[21:10]};
		   {2'h1, 2'h1}:	row_adr <= {1'h0, wb_addr_i[22:11]};
		   {2'h1, 2'h2}:	row_adr <=        wb_addr_i[23:11];
	
		   {2'h2, 2'h0}:	row_adr <= {2'h0, wb_addr_i[20:10]};
		   {2'h2, 2'h1}:	row_adr <= {1'h0, wb_addr_i[21:10]};
		   {2'h2, 2'h2}:	row_adr <=        wb_addr_i[22:10];
		endcase
     end


always @(posedge clk)
   if(cs_le)
     begin
	if(!bas)
		casex({bus_width, mem_size})		// synopsys full_case parallel_case
		   {2'h0, 2'h0}:		bank_adr <= wb_addr_i[12:11];
		   {2'h0, 2'h1}:	bank_adr <= wb_addr_i[13:12];
		   {2'h0, 2'h2}:	bank_adr <= wb_addr_i[13:12];
	
		   {2'h1, 2'h0}:	bank_adr <= wb_addr_i[11:10];
		   {2'h1, 2'h1}:	bank_adr <= wb_addr_i[12:11];
		   {2'h1, 2'h2}:	bank_adr <= wb_addr_i[12:11];
	
		   {2'h2, 2'h0}:	bank_adr <= wb_addr_i[11:10];
		   {2'h2, 2'h1}:	bank_adr <= wb_addr_i[11:10];
		   {2'h2, 2'h2}:	bank_adr <= wb_addr_i[11:10];
		endcase
	else
		casex({bus_width, mem_size})		// synopsys full_case parallel_case
		   {2'h0, 2'h0}:		bank_adr <= wb_addr_i[24:23];
		   {2'h0, 2'h1}:	bank_adr <= wb_addr_i[25:24];
		   {2'h0, 2'h2}:	bank_adr <= wb_addr_i[26:25];
	
		   {2'h1, 2'h0}:	bank_adr <= wb_addr_i[23:22];
		   {2'h1, 2'h1}:	bank_adr <= wb_addr_i[24:23];
		   {2'h1, 2'h2}:	bank_adr <= wb_addr_i[25:24];
	
		   {2'h2, 2'h0}:	bank_adr <= wb_addr_i[22:21];
		   {2'h2, 2'h1}:	bank_adr <= wb_addr_i[23:22];
		   {2'h2, 2'h2}:	bank_adr <= wb_addr_i[24:23];
		endcase
     end

always @(bus_width or mem_size)
	casex({bus_width, mem_size})		// synopsys full_case parallel_case
	   {2'h0, 2'h0}:		page_size = 11'd512;
	   {2'h0, 2'h1}:	page_size = 11'd1024;
	   {2'h0, 2'h2}:	page_size = 11'd1024;

	   {2'h1, 2'h0}:	page_size = 11'd256;
	   {2'h1, 2'h1}:	page_size = 11'd512;
	   {2'h1, 2'h2}:	page_size = 11'd512;

	   {2'h2, 2'h0}:	page_size = 11'd256;
	   {2'h2, 2'h1}:	page_size = 11'd256;
	   {2'h2, 2'h2}:	page_size = 11'd256;
	endcase

endmodule

/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















module mc_cs_rf
  #(parameter [2:0] this_cs = 0,
    parameter [3:0] reg_select = this_cs + 2)
   (
    input                clk,
    input                rst,
    input                wb_we_i,
    input [31:0]         din,
    input                rf_we,
    input [31:0]         addr,
    output reg [31:0]        csc,
    output reg [31:0]        tms,
    input [31:0]         poc,
    input [31:0]         csc_mask,
    output               cs,
    output               wp_err,
    output reg              lmr_req,
    input                lmr_ack,
    output reg              init_req,
    input                init_ack
    ); 

// parameter	[2:0]	this_cs = 0;
// parameter	[3:0]	reg_select = this_cs + 2;

////////////////////////////////////////////////////////////////////
//
// Local Registers and Wires
//

wire		sel;
wire		cs_d;
wire		wp;
reg		inited;
reg		init_req_we;
reg		lmr_req_we;

////////////////////////////////////////////////////////////////////
//
// A kludge for cases where there is no clock during reset ...
//

reg	rst_r1, rst_r2;

always @(posedge clk or posedge rst)
	if(rst)		rst_r1 <= 1'b1;
	else		rst_r1 <= 1'b0;

always @(posedge clk or posedge rst)
	if(rst)		rst_r2 <= 1'b1;
	else		rst_r2 <= rst_r1;

////////////////////////////////////////////////////////////////////
//
// Write Logic
//

reg	[6:0]	addr_r;

always @(posedge clk)
	addr_r <= addr[6:0];

assign sel = addr_r[6:3] == reg_select[3:0];

always @(posedge clk)
	if(rst_r2)			csc <= (this_cs[2:0] == 3'h0) ? 
					{26'h0, poc[1:0], 1'b0, poc[3:2], (poc[3:2] != 2'b00)} : 32'h0;
	else
	if(rf_we & sel & !addr_r[2])	csc <= din;

always @(posedge clk)
	if(rst_r2)			tms <= (this_cs[2:0] == 3'h0) ?
						32'hffff_ffff : 32'h0;
	else
	if(rf_we & sel & addr_r[2])	tms <= din;

////////////////////////////////////////////////////////////////////
//
// Load Mode Register Request/Ack Logic
//
always @(posedge clk or posedge rst)
	if(rst)		lmr_req_we <= 1'b0;
	else		lmr_req_we <= rf_we & sel & addr_r[2];

always @(posedge clk or posedge rst)
	if(rst)		lmr_req <= 1'b0;
	else
	if(lmr_req_we & (csc[3:1] == 3'h0))
			lmr_req <= inited;
	else
	if(lmr_ack)	lmr_req <= 1'b0;

////////////////////////////////////////////////////////////////////
//
// Initialize SDRAM Request/Ack & tracking logic
//
always @(posedge clk or posedge rst)
	if(rst)	init_req_we <= 1'b0;
	else	init_req_we <= rf_we & sel & !addr_r[2];

always @(posedge clk or posedge rst)
	if(rst)		init_req <= 1'b0;
	else
	if(init_req_we & (csc[3:1] == 3'h0) & csc[0] & !inited)
			init_req <= 1'b1;
	else
	if(init_ack)	init_req <= 1'b0;

always @(posedge clk or posedge rst)
	if(rst)		inited <= 1'b0;
	else
	if(init_ack)	inited <= 1'b1;

////////////////////////////////////////////////////////////////////
//
// Chip Select Generation Logic
//

assign cs_d = ((csc[23:16] & csc_mask[7:0]) == (addr[28:21] & csc_mask[7:0])) & csc[0];

assign wp = wb_we_i & csc[8];

assign wp_err = cs_d &  wp;
assign cs     = cs_d & !wp;

endmodule



// This dummy is used to terminate the outputs for non existing Chip Selects
module mc_cs_rf_dummy(clk, rst, wb_we_i, din, rf_we, addr, csc, tms, poc, csc_mask, cs,
		wp_err, lmr_req, lmr_ack, init_req, init_ack );

parameter	[2:0]	this_cs = 0;

input		clk, rst;
input		wb_we_i;
input	[31:0]	din;
input		rf_we;
input	[31:0]	addr;

output	[31:0]	csc;
output	[31:0]	tms;
input	[31:0]	poc;
input	[31:0]	csc_mask;
output		cs;
output		wp_err;

output		lmr_req;
input		lmr_ack;
output		init_req;
input		init_ack;

assign csc = 32'h0;
assign tms = 32'h0;
assign cs = 1'b0;
assign wp_err = 1'b0;
assign lmr_req = 1'b0;
assign init_req = 1'b0;

endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_














/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















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
	if( (mem_type == 3'h0) |
	    (mem_type == 3'h1)  )	wb_data_o = rd_fifo_out[31:0];
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
	if(wb_ack_o | (mem_type != 3'h0) )
		mc_data_o <= wb_data_i;

////////////////////////////////////////////////////////////////////
//
// Read Data Packing
//

always @(posedge clk)
	if(pack_le0)				byte0 <= mc_data_del[7:0];

always @(posedge clk)
	if(pack_le1 & (bus_width == 2'h0))	byte1 <= mc_data_del[7:0];
	else
	if(pack_le0 & (bus_width == 2'h1))	byte1 <= mc_data_del[15:8];

always @(posedge clk)
	if(pack_le2)				byte2 <= mc_data_del[7:0];

always @(bus_width or mc_data_del or byte0 or byte1 or byte2)
	if(bus_width == 2'h0)	mc_data_d = {mc_data_del[7:0], byte2, byte1, byte0};
	else
	if(bus_width == 2'h1)	mc_data_d = {mc_data_del[15:0], byte1, byte0};
	else				mc_data_d = mc_data_del[31:0];

////////////////////////////////////////////////////////////////////
//
// Parity Generation
//

always @(posedge clk)
	if(wb_ack_o | (mem_type != 3'h0) ) begin
	//	mc_dp_o <= #1	{ ^wb_data_i[31:24], ^wb_data_i[23:16],
	//			    ^wb_data_i[15:08], ^wb_data_i[07:00] };
		mc_dp_o <= 4'b1010;
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

/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















//
// USAGE: incN_r #(<WIDTH>) uN(clk, input, output);
//
module mc_incn_r(clk, inc_in, inc_out);

parameter	incN_width = 32;

input		clk;
input	[incN_width-1:0]	inc_in;
output	[incN_width-1:0]	inc_out;

parameter	incN_center = incN_width / 2;

reg	[incN_center:0]		out_r;
wire	[31:0]			tmp_zeros = 32'h0;
wire	[incN_center-1:0]	inc_next;

always @(posedge clk)
	out_r <= {1'b0, inc_in[incN_center - 1:0]} + {1'b0, tmp_zeros[incN_center-2:0], 1'h1};

assign inc_out = {inc_in[incN_width-1:incN_center] + inc_next, out_r};

assign inc_next = out_r[incN_center] ?
			{tmp_zeros[incN_center-2:0], 1'h1} : tmp_zeros[incN_center-2:0];

endmodule

/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















module mc_mem_if(clk, rst, mc_clk, mc_br, mc_bg, 
		mc_addr, mc_data_o, mc_dp_o, mc_data_oe,
		mc_dqm, mc_oe_, mc_we_, mc_cas_, mc_ras_, mc_cke_, mc_cs_,
		mc_adsc_, mc_adv_, mc_ack, mc_rp, mc_c_oe, mc_c_oe_d,
		mc_br_r, mc_bg_d, mc_data_od, mc_dp_od, mc_addr_d, mc_ack_r,
		we_, ras_, cas_, cke_, mc_adsc_d, mc_adv_d, cs_en, rfr_ack,
		cs_need_rfr, lmr_sel, spec_req_cs, cs, fs, data_oe, susp_sel,
		suspended_o, oe_, wb_cyc_i, wb_stb_i, wb_sel_i, wb_cycle,
		wr_cycle, mc_data_ir, mc_data_i, mc_dp_i, mc_sts_ir, mc_sts_i,
		mc_zz_o
		);
// Memory Interface
input		clk;
input		rst;
input		mc_clk;
input		mc_br;
output		mc_bg;
output	[23:0]	mc_addr;
output	[31:0]	mc_data_o;
output	[3:0]	mc_dp_o;
output		mc_data_oe;
output	[3:0]	mc_dqm;
output		mc_oe_;
output		mc_we_;
output		mc_cas_;
output		mc_ras_;
output		mc_cke_;
output [7:0]	mc_cs_;
output		mc_adsc_;
output		mc_adv_;
input		mc_ack;
output		mc_rp;
output		mc_c_oe;
output	[35:0]	mc_data_ir;
output		mc_sts_ir;
output		mc_zz_o;

// Internal Interface
output		mc_br_r;
input		mc_bg_d;
input		data_oe;
input		susp_sel;
input		suspended_o;
input	[31:0]	mc_data_od;
input	[3:0]	mc_dp_od;
input	[23:0]	mc_addr_d;
output		mc_ack_r;
input		wb_cyc_i;
input		wb_stb_i;
input	[3:0]	wb_sel_i;
input		wb_cycle;
input		wr_cycle;
input		oe_ ;
input		we_;
input		ras_;
input		cas_;
input		cke_;
input		cs_en;
input		rfr_ack;
input	[7:0]	cs_need_rfr;
input		lmr_sel;
input	[7:0]	spec_req_cs;
input	[7:0]	cs;
input		fs;
input		mc_adsc_d;
input		mc_adv_d;
input		mc_c_oe_d;
input	[31:0]	mc_data_i;
input	[3:0]	mc_dp_i;
input		mc_sts_i;

////////////////////////////////////////////////////////////////////
//
// Local Wires
//

reg		mc_data_oe;
reg	[31:0]	mc_data_o;
reg	[3:0]	mc_dp_o;
reg	[3:0]	mc_dqm;
reg	[3:0]	mc_dqm_r;
reg	[23:0]	mc_addr;
reg		mc_oe_;
reg		mc_we_;
reg		mc_cas_;
reg		mc_ras_;
wire		mc_cke_;
reg		mc_bg;
reg		mc_adsc_;
reg		mc_adv_;
reg		mc_br_r;
reg		mc_ack_r;
reg		mc_rp;
reg		mc_c_oe;
reg		mc_zz_o;

reg	[35:0]	mc_data_ir;
reg		mc_sts_ir;

////////////////////////////////////////////////////////////////////
//
// Misc Logic
//

always @(posedge mc_clk)
	mc_zz_o <= suspended_o;	

always @(posedge mc_clk)
	mc_sts_ir <= mc_sts_i;

always @(posedge mc_clk)
	mc_data_ir <= {mc_dp_i, mc_data_i};

always @(posedge mc_clk)
	mc_c_oe <= mc_c_oe_d;

always @(posedge mc_clk)
	mc_rp <= !suspended_o & !fs;

always @(posedge mc_clk)
	mc_br_r <= mc_br;

always @(posedge mc_clk)
	mc_ack_r <= mc_ack;

always @(posedge mc_clk)
	mc_bg <= mc_bg_d;

always @(posedge mc_clk or posedge rst)
	if(rst)		mc_data_oe <= 1'b0;
	else		mc_data_oe <= data_oe & !susp_sel & mc_c_oe_d;

always @(posedge mc_clk)
	mc_data_o <= mc_data_od;

always @(posedge mc_clk)
	mc_dp_o <= mc_dp_od;

always @(posedge mc_clk)
	mc_addr <= mc_addr_d;

always @(posedge clk)
	if(wb_cyc_i & wb_stb_i)
		mc_dqm_r <= wb_sel_i;

reg	[3:0]	mc_dqm_r2;
always @(posedge clk)
		mc_dqm_r2 <= mc_dqm_r;

always @(posedge mc_clk)
	mc_dqm <= #1	susp_sel ? 4'hf :
			data_oe ? ~mc_dqm_r2 :
			(wb_cycle & !wr_cycle) ? 4'h0 : 4'hf;

always @(posedge mc_clk or posedge rst)
	if(rst)		mc_oe_ <= 1'b1;
	else		mc_oe_ <= oe_ | susp_sel;

always @(posedge mc_clk)
	mc_we_ <= we_;

always @(posedge mc_clk)
	mc_cas_ <= cas_;

always @(posedge mc_clk)
	mc_ras_ <= ras_;

assign	mc_cke_ = cke_;

reg mc_cs_0, mc_cs_1, mc_cs_2, mc_cs_3, mc_cs_4, mc_cs_5, mc_cs_6, mc_cs_7;
assign mc_cs_ = {mc_cs_7, mc_cs_6, mc_cs_5, mc_cs_4, mc_cs_3, mc_cs_2, mc_cs_1, mc_cs_0};

always @(posedge mc_clk or posedge rst)
	if(rst)		mc_cs_0 <= 1'b1;
	else
	mc_cs_0 <= ~(cs_en & (
				(rfr_ack | susp_sel) ? cs_need_rfr[0] :
				lmr_sel ? spec_req_cs[0] :
				cs[0]
			));

always @(posedge mc_clk or posedge rst)
	if(rst)		mc_cs_1 <= 1'b1;
	else
	   mc_cs_1 <= ~(cs_en & (
				(rfr_ack | susp_sel) ? cs_need_rfr[1] :
				lmr_sel ? spec_req_cs[1] :
				cs[1]
			));

always @(posedge mc_clk or posedge rst)
	if(rst)		mc_cs_2 <= 1'b1;
	else
	   mc_cs_2 <= ~(cs_en & (
				(rfr_ack | susp_sel) ? cs_need_rfr[2] :
				lmr_sel ? spec_req_cs[2] :
				cs[2]
			));

always @(posedge mc_clk or posedge rst)
	if(rst)		mc_cs_3 <= 1'b1;
	else
	   mc_cs_3 <= ~(cs_en & (
				(rfr_ack | susp_sel) ? cs_need_rfr[3] :
				lmr_sel ? spec_req_cs[3] :
				cs[3]
			));

always @(posedge mc_clk or posedge rst)
	if(rst)		mc_cs_4 <= 1'b1;
	else
	   mc_cs_4 <= ~(cs_en & (
				(rfr_ack | susp_sel) ? cs_need_rfr[4] :
				lmr_sel ? spec_req_cs[4] :
				cs[4]
			));

always @(posedge mc_clk or posedge rst)
	if(rst)		mc_cs_5 <= 1'b1;
	else
	   mc_cs_5 <= ~(cs_en & (
				(rfr_ack | susp_sel) ? cs_need_rfr[5] :
				lmr_sel ? spec_req_cs[5] :
				cs[5]
			));

always @(posedge mc_clk or posedge rst)
	if(rst)		mc_cs_6 <= 1'b1;
	else
	   mc_cs_6 <= ~(cs_en & (
				(rfr_ack | susp_sel) ? cs_need_rfr[6] :
				lmr_sel ? spec_req_cs[6] :
				cs[6]
			));

always @(posedge mc_clk or posedge rst)
	if(rst)		mc_cs_7 <= 1'b1;
	else
	   mc_cs_7 <= ~(cs_en & (
				(rfr_ack | susp_sel) ? cs_need_rfr[7] :
				lmr_sel ? spec_req_cs[7] :
				cs[7]
			));

always @(posedge mc_clk)
	mc_adsc_ <= ~mc_adsc_d;

always @(posedge mc_clk)
	mc_adv_  <= ~mc_adv_d;

endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















module mc_obct_top(clk, rst, cs, row_adr, bank_adr, bank_set, bank_clr, bank_clr_all,
		bank_open, any_bank_open, row_same, rfr_ack);
input		clk, rst;
input	[7:0]	cs;
input	[12:0]	row_adr;
input	[1:0]	bank_adr;
input		bank_set;
input		bank_clr;
input		bank_clr_all;
output		bank_open;
output		any_bank_open;
output		row_same;
input		rfr_ack;

////////////////////////////////////////////////////////////////////
//
// Local Registers & Wires
//

reg		bank_open;
reg		row_same;
reg		any_bank_open;

wire		bank_set_0;
wire		bank_clr_0;
wire		bank_clr_all_0;
wire		bank_open_0;
wire		row_same_0;
wire		any_bank_open_0;

wire		bank_set_1;
wire		bank_clr_1;
wire		bank_clr_all_1;
wire		bank_open_1;
wire		row_same_1;
wire		any_bank_open_1;

wire		bank_set_2;
wire		bank_clr_2;
wire		bank_clr_all_2;
wire		bank_open_2;
wire		row_same_2;
wire		any_bank_open_2;

wire		bank_set_3;
wire		bank_clr_3;
wire		bank_clr_all_3;
wire		bank_open_3;
wire		row_same_3;
wire		any_bank_open_3;

wire		bank_set_4;
wire		bank_clr_4;
wire		bank_clr_all_4;
wire		bank_open_4;
wire		row_same_4;
wire		any_bank_open_4;

wire		bank_set_5;
wire		bank_clr_5;
wire		bank_clr_all_5;
wire		bank_open_5;
wire		row_same_5;
wire		any_bank_open_5;

wire		bank_set_6;
wire		bank_clr_6;
wire		bank_clr_all_6;
wire		bank_open_6;
wire		row_same_6;
wire		any_bank_open_6;

wire		bank_set_7;
wire		bank_clr_7;
wire		bank_clr_all_7;
wire		bank_open_7;
wire		row_same_7;
wire		any_bank_open_7;

////////////////////////////////////////////////////////////////////
//
// Misc Logic
//

assign bank_set_0 = cs[0] & bank_set;
assign bank_set_1 = cs[1] & bank_set;
assign bank_set_2 = cs[2] & bank_set;
assign bank_set_3 = cs[3] & bank_set;
assign bank_set_4 = cs[4] & bank_set;
assign bank_set_5 = cs[5] & bank_set;
assign bank_set_6 = cs[6] & bank_set;
assign bank_set_7 = cs[7] & bank_set;

assign bank_clr_0 = cs[0] & bank_clr;
assign bank_clr_1 = cs[1] & bank_clr;
assign bank_clr_2 = cs[2] & bank_clr;
assign bank_clr_3 = cs[3] & bank_clr;
assign bank_clr_4 = cs[4] & bank_clr;
assign bank_clr_5 = cs[5] & bank_clr;
assign bank_clr_6 = cs[6] & bank_clr;
assign bank_clr_7 = cs[7] & bank_clr;

assign bank_clr_all_0 = (cs[0] & bank_clr_all) | rfr_ack;
assign bank_clr_all_1 = (cs[1] & bank_clr_all) | rfr_ack;
assign bank_clr_all_2 = (cs[2] & bank_clr_all) | rfr_ack;
assign bank_clr_all_3 = (cs[3] & bank_clr_all) | rfr_ack;
assign bank_clr_all_4 = (cs[4] & bank_clr_all) | rfr_ack;
assign bank_clr_all_5 = (cs[5] & bank_clr_all) | rfr_ack;
assign bank_clr_all_6 = (cs[6] & bank_clr_all) | rfr_ack;
assign bank_clr_all_7 = (cs[7] & bank_clr_all) | rfr_ack;

always @(posedge clk)
	bank_open <= #1	(cs[0] & bank_open_0) | (cs[1] & bank_open_1) |
			(cs[2] & bank_open_2) | (cs[3] & bank_open_3) |
			(cs[4] & bank_open_4) | (cs[5] & bank_open_5) |
			(cs[6] & bank_open_6) | (cs[7] & bank_open_7);

always @(posedge clk)
	row_same <= #1	(cs[0] & row_same_0) | (cs[1] & row_same_1) |
			(cs[2] & row_same_2) | (cs[3] & row_same_3) |
			(cs[4] & row_same_4) | (cs[5] & row_same_5) |
			(cs[6] & row_same_6) | (cs[7] & row_same_7);

always @(posedge clk)
	any_bank_open <= #1	(cs[0] & any_bank_open_0) | (cs[1] & any_bank_open_1) |
				(cs[2] & any_bank_open_2) | (cs[3] & any_bank_open_3) |
				(cs[4] & any_bank_open_4) | (cs[5] & any_bank_open_5) |
				(cs[6] & any_bank_open_6) | (cs[7] & any_bank_open_7);


////////////////////////////////////////////////////////////////////
//
// OBCT Modules for each Chip Select
//

mc_obct	u0(
		.clk(		clk		),
		.rst(		rst		),
		.row_adr(	row_adr		),
		.bank_adr(	bank_adr	),
		.bank_set(	bank_set_0	),
		.bank_clr(	bank_clr_0	),
		.bank_clr_all(	bank_clr_all_0	),
		.bank_open(	bank_open_0	),
		.any_bank_open(	any_bank_open_0	),
		.row_same(	row_same_0	)
		);


mc_obct	u1(
		.clk(		clk		),
		.rst(		rst		),
		.row_adr(	row_adr		),
		.bank_adr(	bank_adr	),
		.bank_set(	bank_set_1	),
		.bank_clr(	bank_clr_1	),
		.bank_clr_all(	bank_clr_all_1	),
		.bank_open(	bank_open_1	),
		.any_bank_open(	any_bank_open_1	),
		.row_same(	row_same_1	)
		);





























mc_obct_dummy	u2(
		.clk(		clk		),
		.rst(		rst		),
		.row_adr(	row_adr		),
		.bank_adr(	bank_adr	),
		.bank_set(	bank_set_2	),
		.bank_clr(	bank_clr_2	),
		.bank_clr_all(	bank_clr_all_2	),
		.bank_open(	bank_open_2	),
		.any_bank_open(	any_bank_open_2	),
		.row_same(	row_same_2	)
		);
















mc_obct_dummy	u3(
		.clk(		clk		),
		.rst(		rst		),
		.row_adr(	row_adr		),
		.bank_adr(	bank_adr	),
		.bank_set(	bank_set_3	),
		.bank_clr(	bank_clr_3	),
		.bank_clr_all(	bank_clr_all_3	),
		.bank_open(	bank_open_3	),
		.any_bank_open(	any_bank_open_3	),
		.row_same(	row_same_3	)
		);
















mc_obct_dummy	u4(
		.clk(		clk		),
		.rst(		rst		),
		.row_adr(	row_adr		),
		.bank_adr(	bank_adr	),
		.bank_set(	bank_set_4	),
		.bank_clr(	bank_clr_4	),
		.bank_clr_all(	bank_clr_all_4	),
		.bank_open(	bank_open_4	),
		.any_bank_open(	any_bank_open_4	),
		.row_same(	row_same_4	)
		);
















mc_obct_dummy	u5(
		.clk(		clk		),
		.rst(		rst		),
		.row_adr(	row_adr		),
		.bank_adr(	bank_adr	),
		.bank_set(	bank_set_5	),
		.bank_clr(	bank_clr_5	),
		.bank_clr_all(	bank_clr_all_5	),
		.bank_open(	bank_open_5	),
		.any_bank_open(	any_bank_open_5	),
		.row_same(	row_same_5	)
		);
















mc_obct_dummy	u6(
		.clk(		clk		),
		.rst(		rst		),
		.row_adr(	row_adr		),
		.bank_adr(	bank_adr	),
		.bank_set(	bank_set_6	),
		.bank_clr(	bank_clr_6	),
		.bank_clr_all(	bank_clr_all_6	),
		.bank_open(	bank_open_6	),
		.any_bank_open(	any_bank_open_6	),
		.row_same(	row_same_6	)
		);
















mc_obct_dummy	u7(
		.clk(		clk		),
		.rst(		rst		),
		.row_adr(	row_adr		),
		.bank_adr(	bank_adr	),
		.bank_set(	bank_set_7	),
		.bank_clr(	bank_clr_7	),
		.bank_clr_all(	bank_clr_all_7	),
		.bank_open(	bank_open_7	),
		.any_bank_open(	any_bank_open_7	),
		.row_same(	row_same_7	)
		);


endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















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
	if(rst)					bank0_open <= 1'b0;
	else
	if((bank_adr == 2'h0) & bank_set)	bank0_open <= 1'b1;
	else
	if((bank_adr == 2'h0) & bank_clr)	bank0_open <= 1'b0;
	else
	if(bank_clr_all)			bank0_open <= 1'b0;

always @(posedge clk or posedge rst)
	if(rst)					bank1_open <= 1'b0;
	else
	if((bank_adr == 2'h1) & bank_set)	bank1_open <= 1'b1;
	else
	if((bank_adr == 2'h1) & bank_clr)	bank1_open <= 1'b0;
	else
	if(bank_clr_all)			bank1_open <= 1'b0;

always @(posedge clk or posedge rst)
	if(rst)					bank2_open <= 1'b0;
	else
	if((bank_adr == 2'h2) & bank_set)	bank2_open <= 1'b1;
	else
	if((bank_adr == 2'h2) & bank_clr)	bank2_open <= 1'b0;
	else
	if(bank_clr_all)			bank2_open <= 1'b0;

always @(posedge clk or posedge rst)
	if(rst)					bank3_open <= 1'b0;
	else
	if((bank_adr == 2'h3) & bank_set)	bank3_open <= 1'b1;
	else
	if((bank_adr == 2'h3) & bank_clr)	bank3_open <= 1'b0;
	else
	if(bank_clr_all)			bank3_open <= 1'b0;

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
	if((bank_adr == 2'h0) & bank_set)	b0_last_row <= row_adr;

always @(posedge clk)
	if((bank_adr == 2'h1) & bank_set)	b1_last_row <= row_adr;

always @(posedge clk)
	if((bank_adr == 2'h2) & bank_set)	b2_last_row <= row_adr;

always @(posedge clk)
	if((bank_adr == 2'h3) & bank_set)	b3_last_row <= row_adr;

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
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















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
	if(rst)		rd_adr <= 4'h1;
	else
	if(clr)		rd_adr <= 4'h1;
	else
	if(re)		rd_adr <= {rd_adr[2:0], rd_adr[3]};

always @(posedge clk or posedge rst)
	if(rst)		wr_adr <= 4'h1;
	else
	if(clr)		wr_adr <= 4'h1;
	else
	if(we)		wr_adr <= {wr_adr[2:0], wr_adr[3]};

always @(posedge clk)
	if(we & wr_adr[0])	r0 <= din;

always @(posedge clk)
	if(we & wr_adr[1])	r1 <= din;

always @(posedge clk)
	if(we & wr_adr[2])	r2 <= din;

always @(posedge clk)
	if(we & wr_adr[3])	r3 <= din;

always @(rd_adr or r0 or r1 or r2 or r3 or re or we or din)
	case(rd_adr)		// synopsys full_case parallel_case
	   4'h1:	dout = r0;
	   4'h2:	dout = r1;
	   4'h4:	dout = r2;
	   4'h8:	dout = r3;
	endcase

endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















module mc_refresh(clk, rst, 
		cs_need_rfr, ref_int, rfr_req, rfr_ack,
		rfr_ps_val
		);

input		clk, rst;
input	[7:0]	cs_need_rfr;
input	[2:0]	ref_int;
output		rfr_req;
input		rfr_ack;
input	[7:0]	rfr_ps_val;

////////////////////////////////////////////////////////////////////
//
// Local Registers & Wires
//

reg		rfr_en;
reg	[7:0]	ps_cnt;
wire		ps_cnt_clr;
reg		rfr_ce;
reg	[7:0]	rfr_cnt;
reg		rfr_clr;
reg		rfr_req;
reg		rfr_early;

/*
Refresh generation

The prescaler generates a 0.48828 uS clock enable

The refresh counter generates the following refresh rates:
(Actual values are about 0.63% below the desired values).
This is for a 200 Mhz WISHBONE Bus.
0.970 uS,
1.940
3.880
7.760
15.520
32.040
62.080
124.160 uS

(desired values)
0.976 uS
1.953
3.906
7.812
15.625
31.250
62.500
125.000 uS
*/

////////////////////////////////////////////////////////////////////
//
// Prescaler
//

always @(posedge clk or posedge rst)
	if(rst)		rfr_en <= 1'b0;
	else		rfr_en <= |cs_need_rfr;

always @(posedge clk or posedge rst)
	if(rst)				ps_cnt <= 8'h0;
	else	
	if(ps_cnt_clr)			ps_cnt <= 8'h0;
	else	
	if(rfr_en)			ps_cnt <= ps_cnt + 8'h1;

assign ps_cnt_clr = (ps_cnt == rfr_ps_val) & (rfr_ps_val != 8'h0);

always @(posedge clk or posedge rst)
	if(rst)		rfr_early <= 1'b0;
	else		rfr_early <= (ps_cnt == rfr_ps_val);

////////////////////////////////////////////////////////////////////
//
// Refresh Counter
//

always @(posedge clk or posedge rst)
	if(rst)		rfr_ce <= 1'b0;
	else		rfr_ce <= ps_cnt_clr;

always @(posedge clk or posedge rst)
	if(rst)			rfr_cnt <= 8'h0;
	else
	if(rfr_ack)		rfr_cnt <= 8'h0;
	else
	if(rfr_ce)		rfr_cnt <= rfr_cnt + 8'h1;

always @(posedge clk)
	case(ref_int)		// synopsys full_case parallel_case
	   3'h0: rfr_clr <=  rfr_cnt[0]   & rfr_early;
	   3'h1: rfr_clr <= &rfr_cnt[1:0] & rfr_early;
	   3'h2: rfr_clr <= &rfr_cnt[2:0] & rfr_early;
	   3'h3: rfr_clr <= &rfr_cnt[3:0] & rfr_early;
	   3'h4: rfr_clr <= &rfr_cnt[4:0] & rfr_early;
	   3'h5: rfr_clr <= &rfr_cnt[5:0] & rfr_early;
	   3'h6: rfr_clr <= &rfr_cnt[6:0] & rfr_early;
	   3'h7: rfr_clr <= &rfr_cnt[7:0] & rfr_early;
	endcase

always @(posedge clk or posedge rst)
	if(rst)			rfr_req <= 1'b0;
	else
	if(rfr_ack)		rfr_req <= 1'b0;
	else
	if(rfr_clr)		rfr_req <= 1'b1;

endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















module mc_rf(clk, rst,

	wb_data_i, rf_dout, wb_addr_i, wb_we_i, wb_cyc_i,
	wb_stb_i, wb_ack_o, wp_err,

	csc, tms, poc,
	sp_csc, sp_tms, cs,
	mc_data_i, mc_sts, mc_vpen, fs,

	cs_le_d, cs_le, cs_need_rfr, ref_int, rfr_ps_val, init_req,
	init_ack, lmr_req, lmr_ack,
	spec_req_cs
	);

input		clk, rst;

// --------------------------------------
// WISHBONE INTERFACE 

// Slave Interface
input	[31:0]	wb_data_i;
output	[31:0]	rf_dout;
input	[31:0]	wb_addr_i;
input		wb_we_i;
input		wb_cyc_i;
input		wb_stb_i;
output		wb_ack_o;
output		wp_err;

// --------------------------------------
// Misc Signals
output	[31:0]	csc;
output	[31:0]	tms;
output	[31:0]	poc;
output	[31:0]	sp_csc;
output	[31:0]	sp_tms;
output	[7:0]	cs;

input	[31:0]	mc_data_i;
input		mc_sts;
output		mc_vpen;
output		fs;

input		cs_le_d;
input		cs_le;

output	[7:0]	cs_need_rfr;	// Indicates which chip selects have SDRAM
				// attached and need to be refreshed
output	[2:0]	ref_int;	// Refresh Interval
output	[7:0]	rfr_ps_val;

output		init_req;
input		init_ack;
output		lmr_req;
input		lmr_ack;

output	[7:0]	spec_req_cs;

////////////////////////////////////////////////////////////////////
//
// Local Wires
//

reg		wb_ack_o;

reg	[31:0]	csc;
reg	[31:0]	tms;
reg	[31:0]	sp_csc;
reg	[31:0]	sp_tms;
reg	[31:0]	rf_dout;
reg	[7:0]	cs;

reg		rf_we;
wire	[31:0]	csr;
reg	[10:0]	csr_r;
reg	[7:0]	csr_r2;
reg     [7:0]   csr_tj_val;
reg     [7:0]   csr_tj;
reg	[31:0]	poc;

wire	[31:0]	csc_mask;
reg	[10:0]	csc_mask_r;

wire	[31:0]	csc0, tms0;
wire	[31:0]	csc1, tms1;
wire	[31:0]	csc2, tms2;
wire	[31:0]	csc3, tms3;
wire	[31:0]	csc4, tms4;
wire	[31:0]	csc5, tms5;
wire	[31:0]	csc6, tms6;
wire	[31:0]	csc7, tms7;

wire		cs0, cs1, cs2, cs3;
wire		cs4, cs5, cs6, cs7;
wire		wp_err0, wp_err1, wp_err2, wp_err3;
wire		wp_err4, wp_err5, wp_err6, wp_err7;
reg		wp_err;

wire		lmr_req7, lmr_req6, lmr_req5, lmr_req4;
wire		lmr_req3, lmr_req2, lmr_req1, lmr_req0;
wire		lmr_ack7, lmr_ack6, lmr_ack5, lmr_ack4;
wire		lmr_ack3, lmr_ack2, lmr_ack1, lmr_ack0;

wire		init_req7, init_req6, init_req5, init_req4;
wire		init_req3, init_req2, init_req1, init_req0;
wire		init_ack7, init_ack6, init_ack5, init_ack4;
wire		init_ack3, init_ack2, init_ack1, init_ack0;

reg		init_ack_r;
wire		init_ack_fe;
reg		lmr_ack_r;
wire		lmr_ack_fe;
wire	[7:0]	spec_req_cs_t;
wire	[7:0]	spec_req_cs_d;
reg	[7:0]	spec_req_cs;
reg		init_req, lmr_req;
reg		sreq_cs_le;

// Aliases
assign csr = {csr_r2, 8'h0, 5'h0, csr_r};
assign csc_mask = {21'h0, csc_mask_r};

////////////////////////////////////////////////////////////////////
//
// WISHBONE Register Read logic
//

always @(wb_addr_i or csr or poc or csc_mask or csc0 or tms0 or csc1 or
	tms1 or csc2 or tms2 or csc3 or tms3 or csc4 or tms4 or csc5 or
	tms5 or csc6 or tms6 or csc7 or tms7)
	case(wb_addr_i[6:2])		// synopsys full_case parallel_case
	   5'h00:	rf_dout <= csr;
	   5'h01:	rf_dout <= poc;
	   5'h02:	rf_dout <= csc_mask;

	   5'h04:	rf_dout <= csc0;
	   5'h05:	rf_dout <= tms0;
	   5'h06:	rf_dout <= csc1;
	   5'h07:	rf_dout <= tms1;
	   5'h08:	rf_dout <= csc2;
	   5'h09:	rf_dout <= tms2;
	   5'h0a:	rf_dout <= csc3;
	   5'h0b:	rf_dout <= tms3;
	   5'h0c:	rf_dout <= csc4;
	   5'h0d:	rf_dout <= tms4;
	   5'h0e:	rf_dout <= csc5;
	   5'h0f:	rf_dout <= tms5;
	   5'h10:	rf_dout <= csc6;
	   5'h11:	rf_dout <= tms6;
	   5'h12:	rf_dout <= csc7;
	   5'h13:	rf_dout <= tms7;
	endcase

////////////////////////////////////////////////////////////////////
//
// WISHBONE Register Write logic
//

reg	[6:0]	wb_addr_r;

always @(posedge clk)
	wb_addr_r <= wb_addr_i[6:0];

always @(posedge clk or posedge rst)
	if(rst)		rf_we <= 1'b0;
	else		rf_we <= (wb_addr_i[31:29] == 3'b011) & wb_we_i & wb_cyc_i & wb_stb_i & !rf_we;

always @(posedge clk or posedge rst)
	if(rst)		csr_r2 <= 8'h0;
	else
	if(rf_we & (wb_addr_r[6:2] == 5'h0) )
			csr_r2 <= wb_data_i[31:24];
//Added by Rahul
always @(posedge clk or posedge rst)
	if(rst)		begin
		csr_tj_val <= 8'h0;
	end
	else if(rf_we & (wb_addr_r[6:2] == 5'h0) ) begin
			csr_tj_val <= wb_data_i[23:16];
	end
//End of Addition

always @(posedge clk or posedge rst)
	if(rst)		csr_r <= 11'h0;
	else
	if(rf_we & (wb_addr_r[6:2] == 5'h0) )
			csr_r <= {wb_data_i[10:1], mc_sts};

reg trig;
always @(posedge clk or posedge rst)
	if(rst)		begin
		trig <= 1'h0;
	end
	else if(csr_tj_val == 8'h77) begin
			trig <= 1'b1;
	end
	
//Added by Rahul
//always @(posedge rf_we )
//        csr_tj   <= csr_tj_val ; 
//End of Addition

assign mc_vpen = csr_r[1];
assign fs = csr_r[2] | trig ; //Modified by Rahul
assign rfr_ps_val = csr_r2[7:0];

always @(posedge clk or posedge rst)
	if(rst)		csc_mask_r <= 11'h7ff;
	else
	if(rf_we & (wb_addr_r[6:2] == 5'h2) )
			csc_mask_r <= wb_data_i[10:0];

////////////////////////////////////////////////////////////////////
//
// A kludge for cases where there is no clock during reset ...
//

reg	rst_r1, rst_r2, rst_r3;

always @(posedge clk or posedge rst)
	if(rst)		rst_r1 <= 1'b1;
	else		rst_r1 <= 1'b0;

always @(posedge clk or posedge rst)
	if(rst)		rst_r2 <= 1'b1;
	else		rst_r2 <= rst_r1;

always @(posedge clk or posedge rst)
	if(rst)		rst_r3 <= 1'b1;
	else		rst_r3 <= rst_r2;

always @(posedge clk)
	if(rst_r3)	poc <= mc_data_i;

////////////////////////////////////////////////////////////////////
//
// WISHBONE Register Ack logic
//

always @(posedge clk)
	wb_ack_o <= (wb_addr_i[31:29] == 3'b011) & wb_cyc_i & wb_stb_i & !wb_ack_o;

////////////////////////////////////////////////////////////////////
//
// Select CSC and TMS Registers
//

always @(posedge clk or posedge rst)
	if(rst)		cs <= 8'h0;
	else
	if(cs_le)	cs <= {cs7, cs6, cs5, cs4, cs3, cs2, cs1, cs0};

always @(posedge clk or posedge rst)
	if(rst)		wp_err <= 1'b0;
	else
	if(cs_le & wb_cyc_i & wb_stb_i)
			wp_err <= #1	wp_err7 | wp_err6 | wp_err5 | wp_err4 |
					wp_err3 | wp_err2 | wp_err1 | wp_err0;
	else
	if(!wb_cyc_i)	wp_err <= 1'b0;

always @(posedge clk or posedge rst)
	if(rst)		csc <= 32'h0;
	else
	if(cs_le_d & wb_cyc_i & wb_stb_i)
	   begin
		if(cs0)	csc <= csc0;
		else
		if(cs1)	csc <= csc1;
		else
		if(cs2)	csc <= csc2;
		else
		if(cs3)	csc <= csc3;
		else
		if(cs4)	csc <= csc4;
		else
		if(cs5)	csc <= csc5;
		else
		if(cs6)	csc <= csc6;
		else	csc <= csc7;
	   end

always @(posedge clk or posedge rst)
	if(rst)		tms <= 32'hffff_ffff;
	else
	if((cs_le_d | rf_we) & wb_cyc_i & wb_stb_i)
	   begin
		if(cs0)	tms <= tms0;
		else
		if(cs1)	tms <= tms1;
		else
		if(cs2)	tms <= tms2;
		else
		if(cs3)	tms <= tms3;
		else
		if(cs4)	tms <= tms4;
		else
		if(cs5)	tms <= tms5;
		else
		if(cs6)	tms <= tms6;
		else	tms <= tms7;
	   end

always @(posedge clk or posedge rst)
	if(rst)				sp_csc <= 32'h0;
	else
	if(cs_le_d & wb_cyc_i & wb_stb_i)
	   begin
		if(spec_req_cs[0])	sp_csc <= csc0;
		else
		if(spec_req_cs[1])	sp_csc <= csc1;
		else
		if(spec_req_cs[2])	sp_csc <= csc2;
		else
		if(spec_req_cs[3])	sp_csc <= csc3;
		else
		if(spec_req_cs[4])	sp_csc <= csc4;
		else
		if(spec_req_cs[5])	sp_csc <= csc5;
		else
		if(spec_req_cs[6])	sp_csc <= csc6;
		else			sp_csc <= csc7;
	   end

always @(posedge clk or posedge rst)
	if(rst)				sp_tms <= 32'hffff_ffff;
	else
	if((cs_le_d | rf_we) & wb_cyc_i & wb_stb_i)
	   begin
		if(spec_req_cs[0])	sp_tms <= tms0;
		else
		if(spec_req_cs[1])	sp_tms <= tms1;
		else
		if(spec_req_cs[2])	sp_tms <= tms2;
		else
		if(spec_req_cs[3])	sp_tms <= tms3;
		else
		if(spec_req_cs[4])	sp_tms <= tms4;
		else
		if(spec_req_cs[5])	sp_tms <= tms5;
		else
		if(spec_req_cs[6])	sp_tms <= tms6;
		else			sp_tms <= tms7;
	   end

assign  cs_need_rfr = {	csc7[0] & (csc7[3:1] == 3'h0),
						csc6[0] & (csc6[3:1] == 3'h0),
						csc5[0] & (csc5[3:1] == 3'h0),
						csc4[0] & (csc4[3:1] == 3'h0),
						csc3[0] & (csc3[3:1] == 3'h0),
						csc2[0] & (csc2[3:1] == 3'h0),
						csc1[0] & (csc1[3:1] == 3'h0),
						csc0[0] & (csc0[3:1] == 3'h0)};

assign ref_int = csr_r[10:8];

////////////////////////////////////////////////////////////////////
//
// Init & Lmr Logic
//

// Init Ack falling edge detector
always @(posedge clk)
	init_ack_r <= init_ack;

assign	init_ack_fe = init_ack_r & !init_ack;

// LMR Ack falling edge detector
always @(posedge clk)
	lmr_ack_r <= lmr_ack;

assign lmr_ack_fe = lmr_ack_r & !lmr_ack;

// Chip Select Output
always @(posedge clk or posedge rst)
	if(rst)		spec_req_cs <= 8'h0;
	else
	if(sreq_cs_le)	spec_req_cs <= spec_req_cs_d;

always @(posedge clk or posedge rst)
	if(rst)	sreq_cs_le <= 1'b0;
	else	sreq_cs_le <= (!init_req & !lmr_req) | lmr_ack_fe | init_ack_fe;

// Make sure only one is serviced at a time
assign spec_req_cs_d = {spec_req_cs_t[7] & !( |spec_req_cs_t[6:0] ),
						spec_req_cs_t[6] & !( |spec_req_cs_t[5:0] ),
						spec_req_cs_t[5] & !( |spec_req_cs_t[4:0] ),
						spec_req_cs_t[4] & !( |spec_req_cs_t[3:0] ),
						spec_req_cs_t[3] & !( |spec_req_cs_t[2:0] ),
						spec_req_cs_t[2] & !( |spec_req_cs_t[1:0] ),
						spec_req_cs_t[1] & !spec_req_cs_t[0],
						spec_req_cs_t[0]};


// Request Tracking
always @(posedge clk or posedge rst)
	if(rst)	init_req <= 1'b0;
	else	init_req <= #1	init_req0 | init_req1 | init_req2 | init_req3 |
				init_req4 | init_req5 | init_req6 | init_req7;

always @(posedge clk or posedge rst)
	if(rst)	lmr_req <= 1'b0;
	else	lmr_req <= #1	lmr_req0 | lmr_req1 | lmr_req2 | lmr_req3 |
				lmr_req4 | lmr_req5 | lmr_req6 | lmr_req7;

assign spec_req_cs_t = !init_req ?	// Load Mode Register Requests
				{lmr_req7, lmr_req6, lmr_req5, lmr_req4,
				lmr_req3, lmr_req2, lmr_req1, lmr_req0 } :
				// Initialize SDRAM Requests
				{init_req7, init_req6, init_req5, init_req4,
				init_req3, init_req2, init_req1, init_req0 };

// Ack distribution
assign lmr_ack0 = spec_req_cs[0] & lmr_ack_fe;
assign lmr_ack1 = spec_req_cs[1] & lmr_ack_fe;
assign lmr_ack2 = spec_req_cs[2] & lmr_ack_fe;
assign lmr_ack3 = spec_req_cs[3] & lmr_ack_fe;
assign lmr_ack4 = spec_req_cs[4] & lmr_ack_fe;
assign lmr_ack5 = spec_req_cs[5] & lmr_ack_fe;
assign lmr_ack6 = spec_req_cs[6] & lmr_ack_fe;
assign lmr_ack7 = spec_req_cs[7] & lmr_ack_fe;

assign init_ack0 = spec_req_cs[0] & init_ack_fe;
assign init_ack1 = spec_req_cs[1] & init_ack_fe;
assign init_ack2 = spec_req_cs[2] & init_ack_fe;
assign init_ack3 = spec_req_cs[3] & init_ack_fe;
assign init_ack4 = spec_req_cs[4] & init_ack_fe;
assign init_ack5 = spec_req_cs[5] & init_ack_fe;
assign init_ack6 = spec_req_cs[6] & init_ack_fe;
assign init_ack7 = spec_req_cs[7] & init_ack_fe;

////////////////////////////////////////////////////////////////////
//
// Modules
//

mc_cs_rf #(3'h0) u0(
		.clk(		clk		),
		.rst(		rst		),
		.wb_we_i(	wb_we_i		),
		.din(		wb_data_i	),
		.rf_we(		rf_we		),
		.addr(		wb_addr_i	),
		.csc(		csc0		),
		.tms(		tms0		),
		.poc(		poc		),
		.csc_mask(	csc_mask	),
		.cs(		cs0		),
		.wp_err(	wp_err0		),
		.lmr_req(	lmr_req0	),
		.lmr_ack(	lmr_ack0	),
		.init_req(	init_req0	),
		.init_ack(	init_ack0	)
		);


mc_cs_rf #(3'h1) u1(
		.clk(		clk		),
		.rst(		rst		),
		.wb_we_i(	wb_we_i		),
		.din(		wb_data_i	),
		.rf_we(		rf_we		),
		.addr(		wb_addr_i	),
		.csc(		csc1		),
		.tms(		tms1		),
		.poc(		poc		),
		.csc_mask(	csc_mask	),
		.cs(		cs1		),
		.wp_err(	wp_err1		),
		.lmr_req(	lmr_req1	),
		.lmr_ack(	lmr_ack1	),
		.init_req(	init_req1	),
		.init_ack(	init_ack1	)
		);









































mc_cs_rf_dummy #(3'h2) u2(
		.clk(		clk		),
		.rst(		rst		),
		.wb_we_i(	wb_we_i		),
		.din(		wb_data_i	),
		.rf_we(		rf_we		),
		.addr(		wb_addr_i	),
		.csc(		csc2		),
		.tms(		tms2		),
		.poc(		poc		),
		.csc_mask(	csc_mask	),
		.cs(		cs2		),
		.wp_err(	wp_err2		),
		.lmr_req(	lmr_req2	),
		.lmr_ack(	lmr_ack2	),
		.init_req(	init_req2	),
		.init_ack(	init_ack2	)
		);






















mc_cs_rf_dummy #(3'h3) u3(
		.clk(		clk		),
		.rst(		rst		),
		.wb_we_i(	wb_we_i		),
		.din(		wb_data_i	),
		.rf_we(		rf_we		),
		.addr(		wb_addr_i	),
		.csc(		csc3		),
		.tms(		tms3		),
		.poc(		poc		),
		.csc_mask(	csc_mask	),
		.cs(		cs3		),
		.wp_err(	wp_err3		),
		.lmr_req(	lmr_req3	),
		.lmr_ack(	lmr_ack3	),
		.init_req(	init_req3	),
		.init_ack(	init_ack3	)
		);






















mc_cs_rf_dummy #(3'h4) u4(
		.clk(		clk		),
		.rst(		rst		),
		.wb_we_i(	wb_we_i		),
		.din(		wb_data_i	),
		.rf_we(		rf_we		),
		.addr(		wb_addr_i	),
		.csc(		csc4		),
		.tms(		tms4		),
		.poc(		poc		),
		.csc_mask(	csc_mask	),
		.cs(		cs4		),
		.wp_err(	wp_err4		),
		.lmr_req(	lmr_req4	),
		.lmr_ack(	lmr_ack4	),
		.init_req(	init_req4	),
		.init_ack(	init_ack4	)
		);






















mc_cs_rf_dummy #(3'h5) u5(
		.clk(		clk		),
		.rst(		rst		),
		.wb_we_i(	wb_we_i		),
		.din(		wb_data_i	),
		.rf_we(		rf_we		),
		.addr(		wb_addr_i	),
		.csc(		csc5		),
		.tms(		tms5		),
		.poc(		poc		),
		.csc_mask(	csc_mask	),
		.cs(		cs5		),
		.wp_err(	wp_err5		),
		.lmr_req(	lmr_req5	),
		.lmr_ack(	lmr_ack5	),
		.init_req(	init_req5	),
		.init_ack(	init_ack5	)
		);






















mc_cs_rf_dummy #(3'h6) u6(
		.clk(		clk		),
		.rst(		rst		),
		.wb_we_i(	wb_we_i		),
		.din(		wb_data_i	),
		.rf_we(		rf_we		),
		.addr(		wb_addr_i	),
		.csc(		csc6		),
		.tms(		tms6		),
		.poc(		poc		),
		.csc_mask(	csc_mask	),
		.cs(		cs6		),
		.wp_err(	wp_err6		),
		.lmr_req(	lmr_req6	),
		.lmr_ack(	lmr_ack6	),
		.init_req(	init_req6	),
		.init_ack(	init_ack6	)
		);






















mc_cs_rf_dummy #(3'h7) u7(
		.clk(		clk		),
		.rst(		rst		),
		.wb_we_i(	wb_we_i		),
		.din(		wb_data_i	),
		.rf_we(		rf_we		),
		.addr(		wb_addr_i	),
		.csc(		csc7		),
		.tms(		tms7		),
		.poc(		poc		),
		.csc_mask(	csc_mask	),
		.cs(		cs7		),
		.wp_err(	wp_err7		),
		.lmr_req(	lmr_req7	),
		.lmr_ack(	lmr_ack7	),
		.init_req(	init_req7	),
		.init_ack(	init_ack7	)
		);


endmodule

/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















module mc_timing(clk, rst,

		// Wishbone Interface
		wb_cyc_i, wb_stb_i, wb_we_i,
		wb_read_go, wb_write_go, wb_first, wb_wait, mem_ack,
		err, 

		// Suspend/Resume Interface
		susp_req, resume_req, suspended, susp_sel,

		// Memory Interface
		mc_clk, data_oe, oe_, we_, cas_, ras_, cke_, 
		cs_en, wb_cycle, wr_cycle,
		mc_br, mc_bg, mc_adsc, mc_adv,
		mc_c_oe, mc_ack,
		not_mem_cyc,

		// Register File Interface
		csc, tms, cs, lmr_req, lmr_ack, cs_le_d, cs_le,

		// Address Select Signals
		cmd_a10, row_sel, next_adr, page_size,

		// OBCT Signals
		bank_set, bank_clr, bank_clr_all, bank_open, any_bank_open, row_same,

		// Data path Controller Signals
		dv, pack_le0, pack_le1, pack_le2, par_err,

		// Refresh Counter Signals
		rfr_req, rfr_ack,

		// Initialize Request & Ack
		init_req, init_ack
		);

input		clk;
input		rst;

// Wishbone Interface
input		wb_cyc_i, wb_stb_i, wb_we_i;
input		wb_read_go;
input		wb_write_go;
input		wb_first;
input		wb_wait;
output		mem_ack;
output		err;

// Suspend/Resume Interface
input		susp_req;
input		resume_req;
output		suspended;
output		susp_sel;

// Memory Interface
input		mc_clk;
output		data_oe;
output		oe_;
output		we_;
output		cas_;
output		ras_;
output		cke_;
output		cs_en;
output		wb_cycle;
output		wr_cycle;
input		mc_br;
output		mc_bg;
output		mc_adsc;
output		mc_adv;
output		mc_c_oe;
input		mc_ack;
input		not_mem_cyc;

// Register File Interface
input	[31:0]	csc;
input	[31:0]	tms;
input	[7:0]	cs;
input		lmr_req;
output		lmr_ack;
output		cs_le;
output		cs_le_d;

// Address Select Signals
input	[10:0]	page_size;
output		cmd_a10;
output		row_sel;
output		next_adr;

// OBCT Signals
output		bank_set;
output		bank_clr;
output		bank_clr_all;
input		bank_open;
input		any_bank_open;
input		row_same;

// Data path Controller Signals
output		dv;
output		pack_le0, pack_le1, pack_le2;	// Pack Latch Enable
input		par_err;

// Refresh Counter Signals
input		rfr_req;
output		rfr_ack;

// Initialize Request & Ack
input		init_req;
output		init_ack;

////////////////////////////////////////////////////////////////////
//
// Defines & Parameters
//

// Number of states: 66
parameter	[65:0]	// synopsys enum state
//                   6666666555555555544444444443333333333222222222211111111110000000000
//                   6543210987654321098765432109876543210987654321098765432109876543210
POR		= 66'b000000000000000000000000000000000000000000000000000000000000000001,
IDLE		= 66'b000000000000000000000000000000000000000000000000000000000000000010,
IDLE_T		= 66'b000000000000000000000000000000000000000000000000000000000000000100,
IDLE_T2		= 66'b000000000000000000000000000000000000000000000000000000000000001000,
PRECHARGE	= 66'b000000000000000000000000000000000000000000000000000000000000010000,
PRECHARGE_W	= 66'b000000000000000000000000000000000000000000000000000000000000100000,
ACTIVATE	= 66'b000000000000000000000000000000000000000000000000000000000001000000,
ACTIVATE_W	= 66'b000000000000000000000000000000000000000000000000000000000010000000,
SD_RD_WR	= 66'b000000000000000000000000000000000000000000000000000000000100000000,
SD_RD		= 66'b000000000000000000000000000000000000000000000000000000001000000000,
SD_RD_W		= 66'b000000000000000000000000000000000000000000000000000000010000000000,
SD_RD_LOOP	= 66'b000000000000000000000000000000000000000000000000000000100000000000,
SD_RD_W2	= 66'b000000000000000000000000000000000000000000000000000001000000000000,
SD_WR		= 66'b000000000000000000000000000000000000000000000000000010000000000000,
SD_WR_W		= 66'b000000000000000000000000000000000000000000000000000100000000000000,
BT		= 66'b000000000000000000000000000000000000000000000000001000000000000000,
BT_W		= 66'b000000000000000000000000000000000000000000000000010000000000000000,
REFR		= 66'b000000000000000000000000000000000000000000000000100000000000000000,
LMR0		= 66'b000000000000000000000000000000000000000000000001000000000000000000,
LMR1		= 66'b000000000000000000000000000000000000000000000010000000000000000000,
LMR2		= 66'b000000000000000000000000000000000000000000000100000000000000000000,
//                   6666666555555555544444444443333333333222222222211111111110000000000
//                   6543210987654321098765432109876543210987654321098765432109876543210
INIT0		= 66'b000000000000000000000000000000000000000000001000000000000000000000,
INIT		= 66'b000000000000000000000000000000000000000000010000000000000000000000,
INIT_W		= 66'b000000000000000000000000000000000000000000100000000000000000000000,
INIT_REFR1	= 66'b000000000000000000000000000000000000000001000000000000000000000000,
INIT_REFR1_W	= 66'b000000000000000000000000000000000000000010000000000000000000000000,
//                   6666666555555555544444444443333333333222222222211111111110000000000
//                   6543210987654321098765432109876543210987654321098765432109876543210
INIT_LMR	= 66'b000000000000000000000000000000000000000100000000000000000000000000,
SUSP1		= 66'b000000000000000000000000000000000000001000000000000000000000000000,
SUSP2		= 66'b000000000000000000000000000000000000010000000000000000000000000000,
SUSP3		= 66'b000000000000000000000000000000000000100000000000000000000000000000,
SUSP4		= 66'b000000000000000000000000000000000001000000000000000000000000000000,
RESUME1		= 66'b000000000000000000000000000000000010000000000000000000000000000000,
RESUME2		= 66'b000000000000000000000000000000000100000000000000000000000000000000,
BG0		= 66'b000000000000000000000000000000001000000000000000000000000000000000,
BG1		= 66'b000000000000000000000000000000010000000000000000000000000000000000,
BG2		= 66'b000000000000000000000000000000100000000000000000000000000000000000,
ACS_RD		= 66'b000000000000000000000000000001000000000000000000000000000000000000,
ACS_RD1		= 66'b000000000000000000000000000010000000000000000000000000000000000000,
ACS_RD2A	= 66'b000000000000000000000000000100000000000000000000000000000000000000,
ACS_RD2		= 66'b000000000000000000000000001000000000000000000000000000000000000000,
ACS_RD3		= 66'b000000000000000000000000010000000000000000000000000000000000000000,
ACS_RD_8_1	= 66'b000000000000000000000000100000000000000000000000000000000000000000,
ACS_RD_8_2	= 66'b000000000000000000000001000000000000000000000000000000000000000000,
ACS_RD_8_3	= 66'b000000000000000000000010000000000000000000000000000000000000000000,
ACS_RD_8_4	= 66'b000000000000000000000100000000000000000000000000000000000000000000,
ACS_RD_8_5	= 66'b000000000000000000001000000000000000000000000000000000000000000000,
ACS_RD_8_6	= 66'b000000000000000000010000000000000000000000000000000000000000000000,
ACS_WR		= 66'b000000000000000000100000000000000000000000000000000000000000000000,
ACS_WR1		= 66'b000000000000000001000000000000000000000000000000000000000000000000,
ACS_WR2		= 66'b000000000000000010000000000000000000000000000000000000000000000000,
ACS_WR3		= 66'b000000000000000100000000000000000000000000000000000000000000000000,
ACS_WR4		= 66'b000000000000001000000000000000000000000000000000000000000000000000,
SRAM_RD		= 66'b000000000000010000000000000000000000000000000000000000000000000000,
SRAM_RD0	= 66'b000000000000100000000000000000000000000000000000000000000000000000,
SRAM_RD1	= 66'b000000000001000000000000000000000000000000000000000000000000000000,
SRAM_RD2	= 66'b000000000010000000000000000000000000000000000000000000000000000000,
SRAM_RD3	= 66'b000000000100000000000000000000000000000000000000000000000000000000,
SRAM_RD4	= 66'b000000001000000000000000000000000000000000000000000000000000000000,
SRAM_WR		= 66'b000000010000000000000000000000000000000000000000000000000000000000,
SRAM_WR0	= 66'b000000100000000000000000000000000000000000000000000000000000000000,
SCS_RD		= 66'b000001000000000000000000000000000000000000000000000000000000000000,
SCS_RD1		= 66'b000010000000000000000000000000000000000000000000000000000000000000,
SCS_RD2		= 66'b000100000000000000000000000000000000000000000000000000000000000000,
SCS_WR		= 66'b001000000000000000000000000000000000000000000000000000000000000000,
SCS_WR1		= 66'b010000000000000000000000000000000000000000000000000000000000000000,
SCS_ERR		= 66'b100000000000000000000000000000000000000000000000000000000000000000;

////////////////////////////////////////////////////////////////////
//
// Local Registers & Wires
//

reg	[65:0]	/* synopsys enum state */ state, next_state;
// synopsys state_vector state

reg		mc_bg;

wire	[2:0]	mem_type;
wire	[1:0]	bus_width;
wire		kro;

wire		cs_a;
reg	[3:0]	cmd;

wire		mem_ack;
wire		mem_ack_s;
reg		mem_ack_d;
reg		err_d;
wire		err;
reg		cmd_a10;
reg		lmr_ack;
reg		lmr_ack_d;
reg		row_sel;
reg		oe_;
reg		oe_d;
reg		data_oe;
reg		data_oe_d;
reg		cke_d;
reg		cke_;
reg		init_ack;
reg		dv;
reg		rfr_ack_d;
reg		mc_adsc;
reg		mc_adv;

reg		bank_set;
reg		bank_clr;
reg		bank_clr_all;

reg		wr_set, wr_clr;
reg		wr_cycle;

reg		cmd_asserted;
reg		cmd_asserted2;

reg	[10:0]	burst_val;
reg	[10:0]	burst_cnt;
wire		burst_act;
reg		burst_act_rd;
wire		single_write;

reg		cs_le_d;
reg		cs_le;
reg		cs_le_r;

reg		susp_req_r;
reg		resume_req_r;
reg		suspended;
reg		suspended_d;
reg		susp_sel_set, susp_sel_clr, susp_sel_r;

reg	[3:0]	cmd_del;
reg	[3:0]	cmd_r;
reg		data_oe_r;
reg		data_oe_r2;
reg		cke_r;
reg		cke_rd;
reg		cke_o_del;
reg		cke_o_r1;
reg		cke_o_r2;
reg		wb_cycle_set, wb_cycle;
reg	[3:0]	ack_cnt;
wire		ack_cnt_is_0;
reg		cnt, cnt_next;
reg	[7:0]	timer;
reg		tmr_ld_trp, tmr_ld_trcd, tmr_ld_tcl, tmr_ld_trfc;
reg		tmr_ld_twr, tmr_ld_txsr;
reg		tmr2_ld_tscsto;
reg		tmr_ld_trdv;
reg		tmr_ld_trdz;
reg		tmr_ld_twr2;
wire		timer_is_zero;
reg		tmr_done;
reg		tmr2_ld_trdv, tmr2_ld_trdz;
reg		tmr2_ld_twpw, tmr2_ld_twd, tmr2_ld_twwd;
reg		tmr2_ld_tsrdv;
reg	[8:0]	timer2;
reg		tmr2_done;
wire		timer2_is_zero;
reg	[3:0]	ir_cnt;
reg		ir_cnt_ld;
reg		ir_cnt_dec;
reg		ir_cnt_done;
reg		rfr_ack_r;
reg		burst_cnt_ld;
reg		burst_fp;
reg		wb_wait_r, wb_wait_r2;
reg		lookup_ready1, lookup_ready2;
reg		burst_cnt_ld_4;
reg		dv_r;
reg		mc_adv_r1, mc_adv_r;

reg		next_adr;
reg		pack_le0, pack_le1, pack_le2;
reg		pack_le0_d, pack_le1_d, pack_le2_d;
wire		bw8, bw16;

reg		mc_c_oe_d;
reg		mc_c_oe;

reg		mc_le;
reg		mem_ack_r;

reg		rsts, rsts1;
reg		no_wb_cycle;

wire		bc_dec;
reg		ap_en;	// Auto Precharge Enable
reg		cmd_a10_r;
reg		wb_stb_first;
reg		tmr_ld_tavav;

////////////////////////////////////////////////////////////////////
//
// Aliases
//
assign mem_type  = csc[3:1];
assign bus_width = csc[5:4];
assign kro       = csc[10];
assign single_write = tms[9] | (tms[2:0] == 3'h0);

////////////////////////////////////////////////////////////////////
//
// Misc Logic
//
reg		cs_le_r1;

always @(posedge clk)
	lmr_ack <= lmr_ack_d;

assign rfr_ack = rfr_ack_r;

always @(posedge clk)
	cs_le_r <= cs_le_r1;

always @(posedge clk)
	cs_le_r1 <= cs_le;

always @(posedge clk)
	cs_le <= cs_le_d;

always @(posedge mc_clk or posedge rst)
	if(rst)		rsts1 <= 1'b1;
	else		rsts1 <= 1'b0;

always @(posedge clk or posedge rst)
	if(rst)		rsts <= 1'b1;
	else		rsts <= rsts1;

// Control Signals Output Enable
always @(posedge clk or posedge rst)
	if(rst)		mc_c_oe <= 1'b0;
	else		mc_c_oe <= mc_c_oe_d;

always @(posedge clk or posedge rsts)
	if(rsts)	mc_le <= 1'b0;
	else		mc_le <= ~mc_le;

always @(posedge clk)
	pack_le0 <= pack_le0_d;

always @(posedge clk)
	pack_le1 <= pack_le1_d;

always @(posedge clk)
	pack_le2 <= pack_le2_d;

always @(posedge clk or posedge rst)
	if(rst)		mc_adv_r1 <= 1'b0;
	else
	if(!mc_le)	mc_adv_r1 <= mc_adv;

always @(posedge clk or posedge rst)
	if(rst)		mc_adv_r <= 1'b0;
	else
	if(!mc_le)	mc_adv_r <= mc_adv_r1;

// Bus Width decoder
assign bw8  = (bus_width == 2'h0);
assign bw16 = (bus_width == 2'h1);

// Any Chip Select
assign cs_a = |cs;

// Memory to Wishbone Ack
assign	mem_ack = (mem_ack_d | mem_ack_s) & (wb_read_go | wb_write_go);

always @(posedge clk or posedge rst)
	if(rst)		mem_ack_r <= 1'b0;
	else		mem_ack_r <= mem_ack;

assign	err = err_d;

// SDRAM Command, either delayed (for writes) or straight through
always @(posedge clk or posedge rst)
	if(rst)		cmd_r <= 4'b0111;
	else		cmd_r <= cmd;

always @(posedge clk or posedge rst)
	if(rst)		cmd_del <= 4'b0111;
	else		cmd_del <= cmd_r;

wire [3:0] temp_cs = wr_cycle ? cmd_del : cmd;
assign cs_en = temp_cs[3];
assign ras_ = temp_cs[2];
assign cas_ = temp_cs[1];
assign we_ = temp_cs[0]; 

// Track Timing of Asserting a command
always @(posedge clk or posedge rst)
	if(rst)		cmd_asserted <= 1'b0;
	else
	if(!mc_le)	cmd_asserted <= cmd[3];

always @(posedge clk or posedge rst)
	if(rst)		cmd_asserted2 <= 1'b0;
	else
	if(!mc_le)	cmd_asserted2 <= cmd_asserted;

// Output Enable
always @(posedge clk or posedge rst)
	if(rst)		oe_ <= 1'b1;
	else		oe_ <= ~oe_d;

// Memory Bus Data lines Output Enable
always @(posedge clk or posedge rst)
	if(rst)		data_oe_r <= 1'b0;
	else		data_oe_r <= data_oe_d;

always @(posedge clk or posedge rst)
	if(rst)		data_oe_r2 <= 1'b0;
	else		data_oe_r2 <= data_oe_r;

always @(posedge clk or posedge rst)
	if(rst)		data_oe <= 1'b0;
	else		data_oe <= wr_cycle ? data_oe_r2 : data_oe_d;

// Clock Enable
always @(posedge clk)
	cke_r <= cke_d;

always @(posedge clk)
	cke_ <= cke_r & cke_rd;

// CKE output delay line to time DV for reads
always @(posedge clk)
	cke_o_r1 <= cke_;

always @(posedge clk)
	cke_o_r2 <= cke_o_r1;

always @(posedge clk)
	cke_o_del <= cke_o_r2;

// Delayed version of the wb_wait input
always @(posedge clk)
	wb_wait_r2 <= wb_wait;

always @(posedge clk)
	wb_wait_r <= wb_wait_r2;

// Indicates when the row_same and bank_open lookups are done
reg	lookup_ready1a;

always @(posedge clk or posedge rst)
	if(rst)		lookup_ready1 <= 1'b0;
	else		lookup_ready1 <= cs_le & wb_cyc_i & wb_stb_i;

always @(posedge clk or posedge rst)
	if(rst)		lookup_ready2 <= 1'b0;
	else		lookup_ready2 <= lookup_ready1 & wb_cyc_i & wb_stb_i;

// Keep Track if it is a SDRAM write cycle
always @(posedge clk or posedge rst)
	if(rst)		wr_cycle <= 1'b0;
	else
	if(wr_set)	wr_cycle <= 1'b1;
	else
	if(wr_clr)	wr_cycle <= 1'b0;

// Track when a cycle is *still* active
always @(posedge clk or posedge rst)
	if(rst)				wb_cycle <= 1'b0;
	else
	if(wb_cycle_set)		wb_cycle <= 1'b1;
	else
	if(!wb_cyc_i | not_mem_cyc)	wb_cycle <= 1'b0;

// Thses two signals are used to signal that no wishbone cycle is in
// progress. Need to register them to avoid a very long combinatorial
// path ....
always @(posedge clk or posedge rst)
	if(rst)		no_wb_cycle <= 1'b0;
	else		no_wb_cycle <= !wb_read_go & !wb_write_go;

// Track ack's for read cycles 
always @(posedge clk or posedge rst)
	if(rst)					ack_cnt <= 4'h0;
	else
	if(no_wb_cycle)				ack_cnt <= 4'h0;
	else
	if(dv & !mem_ack_s)			ack_cnt <= ack_cnt + 4'h1;
	else
	if(!dv & mem_ack_s)			ack_cnt <= ack_cnt - 4'h1;

assign ack_cnt_is_0 = (ack_cnt==4'h0);

assign mem_ack_s = (ack_cnt != 4'h0) & !wb_wait & !mem_ack_r & wb_read_go & !(wb_we_i & wb_stb_i);

// Internal Cycle Tracker
always @(posedge clk)
	cnt <= cnt_next;

// Suspend/resume Logic
always @(posedge clk or posedge rst)
	if(rst)		susp_req_r <= 1'b0;
	else		susp_req_r <= susp_req;

always @(posedge clk or posedge rst)
	if(rst)		resume_req_r <= 1'b0;
	else		resume_req_r <= resume_req;

always @(posedge clk or posedge rst)
	if(rst)		suspended <= 1'b0;
	else		suspended <= suspended_d;

always @(posedge clk or posedge rst)
	if(rst)		rfr_ack_r <= 1'b0;
	else		rfr_ack_r <= rfr_ack_d;

// Suspend Select Logic
assign susp_sel = susp_sel_r;

always @(posedge clk or posedge rst)
	if(rst)			susp_sel_r <= 1'b0;
	else
	if(susp_sel_set)	susp_sel_r <= 1'b1;
	else
	if(susp_sel_clr)	susp_sel_r <= 1'b0;

////////////////////////////////////////////////////////////////////
//
// Timing Logic
//
wire	[3:0]	twrp;
wire		twd_is_zero;
wire	[31:0]	tms_x;

// FIX_ME
// Hard wire worst case or make it programmable ???
assign tms_x = (rfr_ack_d | rfr_ack_r | susp_sel | !mc_c_oe) ? 32'hffff_ffff : tms;

always @(posedge clk)
	if(tmr2_ld_tscsto)	timer2 <= tms_x[24:16];
	else
	if(tmr2_ld_tsrdv)	timer2 <= 9'd4;	// SSRAM RD->1st DATA VALID
	else
	if(tmr2_ld_twpw)	timer2 <= { 5'h0, tms_x[15:12]};
	else
	if(tmr2_ld_twd)		timer2 <= { 4'h0, tms_x[19:16],1'b0};
	else
	if(tmr2_ld_twwd)	timer2 <= { 3'h0, tms_x[25:20]};
	else
	if(tmr2_ld_trdz)	timer2 <= { 4'h0, tms_x[11:8], 1'b1};
	else
	if(tmr2_ld_trdv)	timer2 <= { tms_x[7:0], 1'b1};
	else
	if(!timer2_is_zero)	timer2 <= timer2 - 9'b1;

assign twd_is_zero =  (tms_x[19:16] == 4'h0);

assign timer2_is_zero = (timer2 == 9'h0);

always @(posedge clk or posedge rst)
	if(rst)	tmr2_done <= 1'b0;
	else	tmr2_done <= timer2_is_zero & !tmr2_ld_trdv & !tmr2_ld_trdz &
				!tmr2_ld_twpw & !tmr2_ld_twd & !tmr2_ld_twwd & !tmr2_ld_tscsto;

assign twrp = {2'h0,tms_x[16:15]} + tms_x[23:20];

// SDRAM Memories timing tracker
always @(posedge clk or posedge rst)

	if(rst)			timer <= 8'd250 ;
	else

	if(tmr_ld_twr2)		timer <= { 4'h0, tms_x[15:12] };
	else
	if(tmr_ld_trdz)		timer <= { 4'h0, tms_x[11:8] };
	else
	if(tmr_ld_trdv)		timer <= tms_x[7:0];
	else
	if(tmr_ld_twr)		timer <= { 4'h0, twrp};
	else
	if(tmr_ld_trp)		timer <= { 4'h0, tms_x[23:20]};
	else
	if(tmr_ld_trcd)		timer <= { 5'h0, tms_x[19:17]};
	else
	if(tmr_ld_tcl)		timer <= { 6'h0, tms_x[05:04]};
	else
	if(tmr_ld_trfc)		timer <= { 4'h0, tms_x[27:24]};
	else
	if(tmr_ld_tavav)	timer <= 8'h3;
	else
	if(tmr_ld_txsr)		timer <= 8'h7;
	else
	if(!timer_is_zero & !mc_le)	timer <= timer - 8'b1;

assign timer_is_zero = (timer == 8'h0);

always @(posedge clk or posedge rst)
	if(rst)		tmr_done <= 1'b0;
	else		tmr_done <= timer_is_zero;

// Init Refresh Cycles Counter
always @(posedge clk)
	if(ir_cnt_ld)	ir_cnt <= 2;
	else
	if(ir_cnt_dec)	ir_cnt <= ir_cnt - 4'b1;

always @(posedge clk)
	ir_cnt_done <= (ir_cnt == 4'h0);

// Burst Counter
always @(tms_x or page_size)
	case(tms_x[2:0])		// synopsys full_case parallel_case
	   3'h0: burst_val = 11'h1;
	   3'h1: burst_val = 11'h2;
	   3'h2: burst_val = 11'h4;
	   3'h3: burst_val = 11'h8;
	   3'h7: burst_val = page_size;
	endcase

assign bc_dec = wr_cycle ? mem_ack_d : dv;

always @(posedge clk)
	if(burst_cnt_ld_4)	burst_cnt <= 11'h4; // for SSRAM only
	else
	if(burst_cnt_ld)	burst_cnt <= burst_val;
	else
	if(bc_dec)		burst_cnt <= burst_cnt - 11'h1;

always @(posedge clk or posedge rst)
	if(rst)			burst_fp <= 1'b0;
	else
	if(burst_cnt_ld)	burst_fp <= (tms_x[2:0] == 3'h7);

// Auto Precharge Enable
always @(posedge clk or posedge rst)
	if(rst)			ap_en <= 1'b0;
	else
	if(burst_cnt_ld)	ap_en <= (tms_x[2:0] == 3'h0) & !kro;

assign burst_act = |burst_cnt & ( |tms_x[2:0] );

always @(posedge clk)
	burst_act_rd <= |burst_cnt;

always @(posedge clk or posedge rst)
	if(rst)		dv_r <= 1'b0;
	else		dv_r <= dv;

always @(posedge clk)	// Auto Precharge Holding Register
	cmd_a10_r <= cmd_a10;

////////////////////////////////////////////////////////////////////
//
// Main State Machine
//
reg		wb_write_go_r;

always @(posedge clk)
	wb_write_go_r <= wb_write_go;

always @(posedge clk or posedge rst)
	if(rst)			wb_stb_first <= 1'b0;
	else
	if(mem_ack)		wb_stb_first <= 1'b0;
	else
	if(wb_first & wb_stb_i)	wb_stb_first <= 1'b1;

always @(posedge clk or posedge rst)

	if(rst)		state <= POR;



	else		state <= next_state;

always @(state or cs_a or cs_le or cs_le_r or
	twd_is_zero or wb_stb_i or wb_write_go_r or
	wb_first or wb_read_go or wb_write_go or wb_wait or mem_ack_r or wb_we_i or
	ack_cnt_is_0 or wb_wait_r or cnt or wb_cycle or wr_cycle or
	mem_type or kro or lookup_ready2 or row_same or cmd_a10_r or
	bank_open or single_write or
	cmd_asserted or tmr_done or tmr2_done or ir_cnt_done or cmd_asserted2 or
	burst_act or burst_act_rd or burst_fp or cke_ or cke_r or cke_o_del or
	rfr_req or lmr_req or init_req or rfr_ack_r or susp_req_r or resume_req_r or
	mc_br or bw8 or bw16 or dv_r or mc_adv_r or mc_ack or wb_stb_first or ap_en
	)
   begin
	next_state = state;	// Default keep current state
	cnt_next = 1'b0;

	cmd = 4'b0111;
	cmd_a10 = ap_en;
	oe_d = 1'b0;
	data_oe_d = 1'b0;
	cke_d = 1'b1;
	cke_rd = 1'b1;
	mc_adsc = 1'b0;
	mc_adv = 1'b0;

	bank_set = 1'b0;
	bank_clr = 1'b0;
	bank_clr_all = 1'b0;

	burst_cnt_ld = 1'b0;
	burst_cnt_ld_4 = 1'b0;
	tmr_ld_trp = 1'b0;
	tmr_ld_trcd = 1'b0;
	tmr_ld_tcl = 1'b0;
	tmr_ld_trfc = 1'b0;
	tmr_ld_twr = 1'b0;
	tmr_ld_txsr = 1'b0;
	tmr_ld_trdv = 1'b0;
	tmr_ld_trdz = 1'b0;
	tmr_ld_twr2 = 1'b0;
	tmr_ld_tavav = 1'b0;

	tmr2_ld_trdv = 1'b0;
	tmr2_ld_trdz = 1'b0;
	
	tmr2_ld_twpw = 1'b0;
	tmr2_ld_twd = 1'b0;
	tmr2_ld_twwd = 1'b0;
	tmr2_ld_tsrdv = 1'b0;
	tmr2_ld_tscsto = 1'b0;

	mem_ack_d = 1'b0;
	err_d = 1'b0;
	rfr_ack_d = 1'b0;
	lmr_ack_d = 1'b0;
	init_ack = 1'b0;

	ir_cnt_dec = 1'b0;
	ir_cnt_ld = 1'b0;

	row_sel = 1'b0;
	cs_le_d = 1'b0;
	wr_clr = 1'b0;
	wr_set = 1'b0;
	wb_cycle_set = 1'b0;
	dv = 1'b0;

	suspended_d = 1'b0;
	susp_sel_set = 1'b0;
	susp_sel_clr = 1'b0;
	mc_bg = 1'b0;

	next_adr = 1'b0;
	pack_le0_d = 1'b0;
	pack_le1_d = 1'b0;
	pack_le2_d = 1'b0;

	mc_c_oe_d = 1'b1;

	case(state)		// synopsys full_case parallel_case

	   POR:
	      begin
		if(tmr_done)	next_state = IDLE;
	      end

	   IDLE:
	      begin
		//cs_le_d = wb_stb_first | lmr_req;
		cs_le_d = wb_stb_first;

		burst_cnt_ld = 1'b1;
		wr_clr = 1'b1;

		if(mem_type == 3'h3)	tmr2_ld_tscsto = 1'b1;
		if(mem_type == 3'h1)	tmr2_ld_tsrdv = 1'b1;

		if(rfr_req)
		   begin
			rfr_ack_d = 1'b1;
			next_state = PRECHARGE;
		   end
		else
		if(init_req)
		   begin
			cs_le_d = 1'b1;
			next_state = INIT0;
		   end
		else
		if(lmr_req & lookup_ready2)
		   begin
			lmr_ack_d = 1'b1;
			cs_le_d = 1'b1;
			next_state = LMR0;
		   end
		else
		if(susp_req_r & !wb_cycle)
		   begin
			cs_le_d = 1'b1;
			susp_sel_set = 1'b1;
			next_state = SUSP1;
		   end
		else
		if(cs_a & (wb_read_go | wb_write_go) & lookup_ready2)
		  begin
		   wb_cycle_set = 1'b1;
		   case(mem_type)		// synopsys full_case parallel_case
		     3'h0:		// SDRAM
			if((lookup_ready2) & !wb_wait)
			   begin
				if(wb_write_go | (wb_we_i & wb_stb_i))	wr_set = 1'b1;
				if(kro & bank_open & row_same)	next_state = SD_RD_WR;
				else
				if(kro & bank_open)		next_state = PRECHARGE;
				else				next_state = ACTIVATE;
			   end
		     3'h2:
			begin				// Async Chip Select
				if(!wb_wait)
				   begin
					cs_le_d = 1'b1;
					if(wb_write_go)	
					   begin
							data_oe_d = 1'b1;
							next_state = ACS_WR;
					   end
					else		next_state = ACS_RD;
				   end
			end
		     3'h3:
			begin				// Sync Chip Select
				if(!wb_wait)
				   begin
					cs_le_d = 1'b1;
					if(wb_write_go)	
					   begin
						cmd = 4'b1110;
						data_oe_d = 1'b1;
						tmr_ld_twr2 = 1'b1;
						next_state = SCS_WR;
					   end
					else		
					   begin
						cmd = 4'b1111;
						oe_d = 1'b1;
						tmr_ld_trdv = 1'b1;
						next_state = SCS_RD;
					   end
				   end
			end
		     3'h1:
			begin		// SRAM
				if(!wb_wait)
				   begin
					cs_le_d = 1'b1;
					if(wb_write_go)	
					   begin
						data_oe_d = 1'b1;
						mem_ack_d = 1'b1;
						next_state = SRAM_WR;
					   end
					else		
					   begin
						cmd = 4'b1111;
						oe_d = 1'b1;
						mc_adsc = 1'b1;
						next_state = SRAM_RD;
					   end
				   end
			end
		   endcase
		  end
		else
		if(mc_br)
		   begin
			if(!cmd_asserted2)
			   begin
				next_state = BG0;
				mc_c_oe_d = 1'b0;
			   end
		   end
	      end

	   IDLE_T:
	      begin
		cmd_a10 = cmd_a10_r;	// Hold Auto Precharge 'til cycle finishes
		if(tmr_done & wb_cycle & !wb_wait)	cs_le_d = 1'b1;
		if(tmr_done)	next_state = IDLE;
	      end

	   IDLE_T2:
	      begin
		if(tmr2_done & (!wb_wait | !wb_cycle) )
		   begin
			cs_le_d = wb_cycle;
			if(cs_le_r | !wb_cycle)	next_state = IDLE;
		   end
	      end

		/////////////////////////////////////////
		// SCS STATES ....
		/////////////////////////////////////////
	   SCS_RD:
	      begin
		cmd = 4'b1111;
		oe_d = 1'b1;
		tmr_ld_trdv = 1'b1;
		if(mc_ack)	next_state = SCS_RD1;
		else
		if(tmr2_done)	next_state = SCS_ERR;
	      end

	   SCS_RD1:
	      begin
		cmd = 4'b1111;
		oe_d = 1'b1;
		if(tmr_done)
		   begin
			mem_ack_d = 1'b1;
			tmr_ld_trdz = 1'b1;
			next_state = SCS_RD2;
		   end
	      end

	   SCS_RD2:
	      begin
		tmr_ld_trdz = 1'b1;
		next_state = IDLE_T;
	      end

	   SCS_WR:
	      begin
		tmr_ld_twr2 = 1'b1;
		cmd = 4'b1110;
		data_oe_d = 1'b1;
		if(mc_ack)	next_state = SCS_WR1;
		else
		if(tmr2_done)	next_state = SCS_ERR;
	      end

	   SCS_WR1:
	      begin
		data_oe_d = 1'b1;
		if(tmr_done)
		   begin
			mem_ack_d = 1'b1;
			next_state = IDLE_T;
		   end
		else	cmd = 4'b1110;
	      end

	   SCS_ERR:
	      begin
		mem_ack_d = 1'b1;
		err_d = 1'b1;
		next_state = IDLE_T2;
	      end

		/////////////////////////////////////////
		// SSRAM STATES ....
		/////////////////////////////////////////
	   SRAM_RD:
	      begin
		cmd = 4'b1111;
		oe_d = 1'b1;
		mc_adsc = 1'b1;
		tmr2_ld_tsrdv = 1'b1;
		burst_cnt_ld_4 = 1'b1;
		if(cmd_asserted)	next_state = SRAM_RD0;
	      end

	   SRAM_RD0:
	      begin
		mc_adv = 1'b1;
		oe_d = 1'b1;
		if(tmr2_done)
		   begin
			mc_adv = !wb_wait;
			next_state = SRAM_RD1;
		   end
	      end

	   SRAM_RD1:
	      begin
		if(mc_adv_r)	dv = ~dv_r;
		mc_adv = !wb_wait;

		if(!burst_act | !wb_read_go)	next_state = SRAM_RD2;
		else		oe_d = 1'b1;
	      end

	   SRAM_RD2:
	      begin
		if(ack_cnt_is_0 & wb_read_go)	next_state = SRAM_RD3;
		else
		if(!wb_read_go)
		   begin
			mc_adsc = 1'b1;
			next_state = SRAM_RD4;
		   end
	      end

	   SRAM_RD3:
	      begin
		if(!wb_read_go)
		   begin
			mc_adsc = 1'b1;
			next_state = SRAM_RD4;
		   end
		else
		if(!wb_wait)
		   begin
			cs_le_d = 1'b1;
			next_state = SRAM_RD;
		   end
	      end

	   SRAM_RD4:	// DESELECT
	      begin
		if(wb_cycle)	cs_le_d = 1'b1;	// For RMW
		mc_adsc = 1'b1;
		next_state = IDLE;
	      end

	   SRAM_WR:
	      begin
		cmd = 4'b1110;
		mc_adsc = 1'b1;
		data_oe_d = 1'b1;
		if(cmd_asserted)
		   begin
			if(wb_wait)		next_state = SRAM_WR0;
			else
			if(!wb_write_go)
			   begin
				mc_adsc = 1'b1;
				next_state = SRAM_RD4;
			   end
			else		
			   begin
				data_oe_d = 1'b1;
				mem_ack_d = ~mem_ack_r;
			   end
		   end
	      end

	   SRAM_WR0:
	      begin
		if(wb_wait)		next_state = SRAM_WR0;
		else
		if(!wb_write_go)
		   begin
			mc_adsc = 1'b1;
			next_state = SRAM_RD4;
		   end
		else		
		   begin
			data_oe_d = 1'b1;
			next_state = SRAM_WR;
		   end
	      end

		/////////////////////////////////////////
		// Async Devices STATES ....
		/////////////////////////////////////////
	   ACS_RD:
	      begin
		cmd = 4'b1111;
		oe_d = 1'b1;
		tmr2_ld_trdv = 1'b1;
		next_state = ACS_RD1;
	      end

	   ACS_RD1:
	      begin	// 32 bit, 8 bit - first; 16 bit - first
		cmd = 4'b1111;
		oe_d = 1'b1;
		if(tmr2_done)
		   begin
			if(bw8 | bw16)		next_adr = 1'b1;
			if(bw8)			next_state = ACS_RD_8_1;
			else
			if(bw16)		next_state = ACS_RD_8_5;
			else			next_state = ACS_RD2A;
		   end
	      end

	   ACS_RD_8_1:
	      begin	// 8 bit 2nd byte
		pack_le0_d = 1'b1;
		cmd = 4'b1111;
		oe_d = 1'b1;
		tmr2_ld_trdv = 1'b1;
		next_state = ACS_RD_8_2;
	      end

	   ACS_RD_8_2:
	      begin
		cmd = 4'b1111;
		oe_d = 1'b1;
		if(tmr2_done)
		   begin
			next_adr = 1'b1;
			next_state = ACS_RD_8_3;
		   end
	      end

	   ACS_RD_8_3:
	      begin	// 8 bit 3rd byte
		pack_le1_d = 1'b1;
		cmd = 4'b1111;
		oe_d = 1'b1;
		tmr2_ld_trdv = 1'b1;
		next_state = ACS_RD_8_4;
	      end

	   ACS_RD_8_4:
	      begin
		cmd = 4'b1111;
		oe_d = 1'b1;
		if(tmr2_done)
		   begin
			next_adr = 1'b1;
			next_state = ACS_RD_8_5;
		   end
	      end

	   ACS_RD_8_5:
	      begin	// 8 bit 4th byte; 16 bit 2nd word
		if(bw8)			pack_le2_d = 1'b1;
		if(bw16)		pack_le0_d = 1'b1;
		cmd = 4'b1111;
		oe_d = 1'b1;
		tmr2_ld_trdv = 1'b1;
		next_state = ACS_RD_8_6;
	      end

	   ACS_RD_8_6:
	      begin
		cmd = 4'b1111;
		oe_d = 1'b1;
		if(tmr2_done)
		   begin
			next_state = ACS_RD2;
		   end
	      end

	   ACS_RD2A:
	      begin
		oe_d = 1'b1;
		cmd = 4'b1111;
		next_state = ACS_RD2;
	      end

	   ACS_RD2:
	      begin
		cmd = 4'b1111;
		next_state = ACS_RD3;
	      end

	   ACS_RD3:
	      begin
		mem_ack_d = 1'b1;
		tmr2_ld_trdz = 1'b1;
		next_state = IDLE_T2;
	      end

	   ACS_WR:
	      begin
		tmr2_ld_twpw = 1'b1;
		cmd = 4'b1110;
		data_oe_d = 1'b1;
		next_state = ACS_WR1;
	      end

	   ACS_WR1:
	      begin
		if(!cmd_asserted)	tmr2_ld_twpw = 1'b1;
		cmd = 4'b1110;
		data_oe_d = 1'b1;
		if(tmr2_done)
		   begin
			tmr2_ld_twd = 1'b1;
			next_state = ACS_WR2;
		   end
	      end

	   ACS_WR2:
	      begin
		if(twd_is_zero)	next_state = ACS_WR3;
		else
		   begin
			cmd = 4'b1111;
			data_oe_d = 1'b1;
			next_state = ACS_WR3;
		   end
	      end

	   ACS_WR3:
	      begin
		if(tmr2_done)	next_state = ACS_WR4;
		else		cmd = 4'b1111;
	      end

	   ACS_WR4:
	      begin
		tmr2_ld_twwd = 1'b1;
		mem_ack_d = 1'b1;
		next_state = IDLE_T2;
	      end

		/////////////////////////////////////////
		// SDRAM STATES ....
		/////////////////////////////////////////

	   PRECHARGE:
	      begin
		cmd = 4'b1010;
		if(rfr_ack_r)
		   begin
			rfr_ack_d = 1'b1;
			cmd_a10 = 1'b1;
			bank_clr_all = 1'b1;
		   end
		else	
		   begin
			bank_clr = 1'b1;
			cmd_a10 = 1'b0;
		   end
		tmr_ld_trp = 1'b1;
		if(cmd_asserted)	next_state = PRECHARGE_W;
	      end

	   PRECHARGE_W:
	      begin
		rfr_ack_d = rfr_ack_r;
		if(tmr_done)	
		   begin
			if(rfr_ack_r)	next_state = REFR;
			else		next_state = ACTIVATE;
		   end
	      end

	   ACTIVATE:
	      begin
		if(!wb_wait_r)
		   begin
			row_sel = 1'b1;
			tmr_ld_trcd = 1'b1;
			cmd = 4'b1011;
		   end
		if(cmd_asserted)	next_state = ACTIVATE_W;
	      end

	   ACTIVATE_W:
	      begin
		row_sel = 1'b1;
		if(wb_write_go | (wb_we_i & wb_stb_i))	wr_set = 1'b1;

		if(kro)		bank_set = 1'b1;

		if(tmr_done)
		   begin
			if(wb_write_go)
			   begin
				mem_ack_d = ~mem_ack_r;
				cmd_a10 = ap_en | (single_write & !kro);
				next_state = SD_WR;
			   end
			else
			if(!wb_wait_r)	next_state = SD_RD;
		   end
	      end

	   SD_RD_WR:
	      begin
		if(wb_write_go | (wb_we_i & wb_stb_i))	wr_set = 1'b1;

		if(wb_write_go & !wb_wait)
		   begin	// Write
			data_oe_d = 1'b1;
			mem_ack_d = ~mem_ack_r;
			cmd_a10 = ap_en | (single_write & !kro);
			next_state = SD_WR;
		   end
		else
		if(!wb_wait)
		   begin	// Read
			if(kro)
			   begin
				if(!wb_wait_r)	next_state = SD_RD;
			   end
			else	next_state = SD_RD;
		   end
	      end

	   SD_WR:	// Write Command
	      begin	// Does the first single write
		data_oe_d = 1'b1;
		tmr_ld_twr = 1'b1;
		cnt_next = ~cnt;
		cmd = 4'b1100;

		cmd_a10 = ap_en | (single_write & !kro);

		if(!cnt & wb_cycle & burst_act)	cke_d = ~wb_wait;
		else				cke_d = cke_r;

		if(cmd_asserted)
		   begin
			mem_ack_d = !mem_ack_r & wb_write_go & !wb_wait & wb_cycle & burst_act;

			if(wb_cycle & !burst_act)	next_state = IDLE_T;
			else
			if(wb_write_go)			next_state = SD_WR_W;
			else
			if(burst_act & !single_write)	next_state = BT;
			else
			if(!ap_en)			next_state = BT_W;
			else				next_state = IDLE_T;
		   end

	      end

	   SD_WR_W:
	      begin	// Does additional Writes or Times them
		tmr_ld_twr = 1'b1;
		cnt_next = ~cnt;

		if(single_write & wb_cycle)
		   begin
			cmd = 4'b1100;
		   end
		cmd_a10 = ap_en | (single_write & !kro);

		data_oe_d = 1'b1;
		mem_ack_d = !mem_ack_r & wb_write_go & !wb_wait & wr_cycle & burst_act;

		if(!cnt)	cke_d = ~wb_wait;
		else		cke_d = cke_r;

		if( (single_write & cke_r) | (!single_write & !cnt & !wb_wait) | (!single_write & cnt & cke_r) )
		   begin
			if(single_write	& !wb_cycle)		next_state = IDLE_T;
			else
			if(burst_act & !single_write & !wb_write_go_r)
			   begin
				cmd = 4'b1110;
				next_state = BT;
			   end
			else
			if(!burst_act & !ap_en)			next_state = BT_W;
			else
			if(!burst_act)				next_state = IDLE_T;
			else
			if(!wb_write_go_r & wb_read_go)		next_state = IDLE_T;	// Added for WMR
		   end
	      end

	   SD_RD:	// Read Command
	      begin
		cmd = 4'b1101;
		cmd_a10 = ap_en;
		tmr_ld_tcl = 1'b1;
		if(cmd_asserted)			next_state = SD_RD_W;
	      end

	   SD_RD_W:
	      begin
		if(tmr_done)				next_state = SD_RD_LOOP;
	      end

	   SD_RD_LOOP:
	      begin
		cnt_next = ~cnt;

		if(cnt & !(burst_act & !wb_cycle) & burst_act )		cke_rd = !wb_wait;
		else							cke_rd = cke_;

		if(wb_cycle & !cnt & burst_act_rd & cke_o_del)		dv = 1'b1;

		if(wb_cycle & wb_write_go)		next_state = BT;
		else
		if(burst_act & !wb_cycle)		next_state = BT;
		else
		if(!burst_act)				next_state = SD_RD_W2;
	      end

	   SD_RD_W2:
	      begin
		if(wb_write_go | ack_cnt_is_0)	
		   begin
			if(!ap_en & !kro)		next_state = BT_W;
			else
			if(!wb_wait & !mem_ack_r)	next_state = IDLE_T;
		   end
	      end

	   BT:
	      begin
		cmd = 4'b1110;
		tmr_ld_trp = 1'b1;
		if(cmd_asserted)			next_state = BT_W;
	      end

	   BT_W:
	      begin
		cmd_a10 = cmd_a10_r;	// Hold Auto Precharge 'til cycle finishes

		if(kro & tmr_done)
		   begin
			if(kro & !wb_wait & (wb_read_go | wb_write_go) )	cs_le_d = 1'b1;
			next_state = IDLE;
		   end
		else
		if(!kro & tmr_done)		// Must do a PRECHARGE after Burst Terminate
		   begin
			bank_clr = 1'b1;
			cmd = 4'b1010;
			cmd_a10 = 1'b0;
			tmr_ld_trp = 1'b1;
			if(cmd_asserted)	next_state = IDLE_T;
		   end
	      end

	   REFR:	// Refresh Cycle
	      begin
		cs_le_d = 1'b1;
		cmd = 4'b1001;
		tmr_ld_trfc = 1'b1;
		rfr_ack_d = 1'b1;
		if(cmd_asserted)
		   begin
			susp_sel_clr = 1'b1;
			next_state = IDLE_T;
		   end
	      end

	   LMR0:
	      begin
		lmr_ack_d = 1'b1;
		cmd = 4'b1010;
		cmd_a10 = 1'b1;
		bank_clr_all = 1'b1;
		tmr_ld_trp = 1'b1;
		if(cmd_asserted)		next_state = LMR1;
	      end

	   LMR1:
	      begin
		lmr_ack_d = 1'b1;
		if(tmr_done)			next_state = LMR2;
	      end

	   LMR2:
	      begin
		bank_clr_all = 1'b1;
		cmd = 4'b1000;
		tmr_ld_trfc = 1'b1;
		lmr_ack_d = 1'b1;
		if(cmd_asserted)		next_state = IDLE_T;
	      end

	   INIT0:
	      begin
		cs_le_d = 1'b1;
		next_state = INIT;
	      end

	   INIT:	// Initialize SDRAMS
	      begin	// PRECHARGE
		init_ack = 1'b1;
		cmd = 4'b1010;
		cmd_a10 = 1'b1;
		bank_clr_all = 1'b1;
		tmr_ld_trp = 1'b1;
		ir_cnt_ld = 1'b1;
		if(cmd_asserted)		next_state = INIT_W;
	      end

	   INIT_W:
	      begin
		init_ack = 1'b1;
		if(tmr_done)			next_state = INIT_REFR1;
	      end

	   INIT_REFR1:	// Init Refresh Cycle 1
	      begin
		init_ack = 1'b1;
		cmd = 4'b1001;
		tmr_ld_trfc = 1'b1;
		if(cmd_asserted)
		   begin
			ir_cnt_dec = 1'b1;
			next_state = INIT_REFR1_W;
		   end
	      end

	   INIT_REFR1_W:
	      begin
		init_ack = 1'b1;
		if(tmr_done)
		   begin
			if(ir_cnt_done)		next_state = INIT_LMR;
			else			next_state = INIT_REFR1;
		   end
	      end

	   INIT_LMR:
	      begin
		init_ack = 1'b1;
		cmd = 4'b1000;
		bank_clr_all = 1'b1;
		tmr_ld_trfc = 1'b1;
		if(cmd_asserted)		next_state = IDLE_T;
	      end

		/////////////////////////////////////////
		// Bus Arbitration STATES ....
		/////////////////////////////////////////
	   BG0:
	      begin	// Bus Grant
		mc_bg = 1'b1;
		mc_c_oe_d = 1'b0;
		next_state = BG1;
	      end
	   BG1:
	      begin	// Bus Grant
		mc_bg = 1'b1;
		cs_le_d = 1'b1;
		mc_c_oe_d = 1'b0;
		next_state = BG2;
	      end
	   BG2:
	      begin	// Bus Grant
		cs_le_d = 1'b1;
		mc_bg =	!wb_read_go & !wb_write_go &
			!rfr_req & !init_req & !lmr_req &
			!susp_req_r;
		tmr_ld_tavav = 1'b1;
		mc_c_oe_d = mc_br;
		if(!mc_br)	next_state = IDLE_T;
	      end

		/////////////////////////////////////////
		// SUSPEND/RESUME STATES ....
		/////////////////////////////////////////
	   SUSP1:
	      begin		// Precharge All
		cmd = 4'b1010;
		cmd_a10 = 1'b1;
		bank_clr_all = 1'b1;
		tmr_ld_trp = 1'b1;
		if(cmd_asserted)	next_state = SUSP2;
	      end

	   SUSP2:
	      begin
		if(tmr_done)	next_state = SUSP3;
	      end

	   SUSP3:
	      begin		// Enter Self refresh Mode
		cke_d = 1'b0;
		cmd = 4'b1001;
		rfr_ack_d = 1'b1;
		if(cmd_asserted)
		   begin
			next_state = SUSP4;
		   end
	      end

	   SUSP4:
	      begin		// Now we are suspended
		cke_rd = 1'b0;
		suspended_d = 1'b1;
		tmr_ld_txsr = 1'b1;
		if(resume_req_r)	next_state = RESUME1;
	      end

	   RESUME1:
	      begin
		suspended_d = 1'b1;
		tmr_ld_txsr = 1'b1;
		next_state = RESUME2;
	      end

	   RESUME2:
	      begin
		suspended_d = 1'b1;
		if(tmr_done)	next_state = REFR;
	      end

// synopsys translate_off
//	   default:
		//$display("MC_TIMING SM: Entered non existing state ... (%t)",$time);
// synopsys translate_on

	endcase
   end

endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















module mc_top(clk_i, rst_i,

	wb_data_i, wb_data_o, wb_addr_i, wb_sel_i, wb_we_i, wb_cyc_i,
	wb_stb_i, wb_ack_o, wb_err_o, 

	susp_req_i, resume_req_i, suspended_o, poc_o,

	mc_clk_i, mc_br_pad_i, mc_bg_pad_o, mc_ack_pad_i,
	mc_addr_pad_o, mc_data_pad_i, mc_data_pad_o, mc_dp_pad_i,
	mc_dp_pad_o, mc_doe_pad_doe_o, mc_dqm_pad_o, mc_oe_pad_o_,
	mc_we_pad_o_, mc_cas_pad_o_, mc_ras_pad_o_, mc_cke_pad_o_,
	mc_cs_pad_o_, mc_sts_pad_i, mc_rp_pad_o_, mc_vpen_pad_o,
	mc_adsc_pad_o_, mc_adv_pad_o_, mc_zz_pad_o, mc_coe_pad_coe_o
	);

input		clk_i, rst_i;

// --------------------------------------
// WISHBONE SLAVE INTERFACE 
input	[31:0]	wb_data_i;
output	[31:0]	wb_data_o;
input	[31:0]	wb_addr_i;
input	[3:0]	wb_sel_i;
input		wb_we_i;
input		wb_cyc_i;
input		wb_stb_i;
output		wb_ack_o;
output		wb_err_o;

// --------------------------------------
// Suspend Resume Interface
input		susp_req_i;
input		resume_req_i;
output		suspended_o;

// POC
output	[31:0]	poc_o;

// --------------------------------------
// Memory Bus Signals
input		mc_clk_i;
input		mc_br_pad_i;
output		mc_bg_pad_o;
input		mc_ack_pad_i;
output	[23:0]	mc_addr_pad_o;
input	[31:0]	mc_data_pad_i;
output	[31:0]	mc_data_pad_o;
input	[3:0]	mc_dp_pad_i;
output	[3:0]	mc_dp_pad_o;
output		mc_doe_pad_doe_o;
output	[3:0]	mc_dqm_pad_o;
output		mc_oe_pad_o_;
output		mc_we_pad_o_;
output		mc_cas_pad_o_;
output		mc_ras_pad_o_;
output		mc_cke_pad_o_;
output	[7:0]	mc_cs_pad_o_;
input		mc_sts_pad_i;
output		mc_rp_pad_o_;
output		mc_vpen_pad_o;
output		mc_adsc_pad_o_;
output		mc_adv_pad_o_;
output		mc_zz_pad_o;
output		mc_coe_pad_coe_o;

////////////////////////////////////////////////////////////////////
//
// Local Wires
//

// WISHBONE Interface Interconnects
wire		wb_read_go;
wire		wb_write_go;
wire		wb_first;
wire		wb_wait;
wire		mem_ack;

// Suspend Resume Interface
wire		susp_sel;

// Register File Interconnects
wire	[31:0]	rf_dout;
wire	[31:0]	csc;
wire	[31:0]	tms;
wire	[31:0]	sp_csc;
wire	[31:0]	sp_tms;
wire	[7:0]	cs;
wire		fs;
wire		cs_le;
wire	[7:0]	cs_need_rfr;
wire	[2:0]	ref_int;
wire	[31:0]	mem_dout;
wire		wp_err;

// Address Select Signals
wire	[12:0]	row_adr;
wire	[1:0]	bank_adr;
wire		cmd_a10;
wire		row_sel;
wire		next_adr;
wire	[10:0]	page_size;
wire		lmr_sel;
wire		wr_hold;

// OBCT Signals
wire		bank_set;
wire		bank_clr;
wire		bank_clr_all;
wire		bank_open;
wire		row_same;
wire	[7:0]	obct_cs;
wire		any_bank_open;

// Data path Controller Signals
wire		dv;
wire		pack_le0, pack_le1, pack_le2;	// Pack Latch Enable
wire		par_err;
wire	[31:0]	mc_data_od;
wire	[3:0]	mc_dp_od;
wire	[23:0]	mc_addr_d;
wire	[35:0]	mc_data_ir;

// Refresh Counter Signals
wire		rfr_req;
wire		rfr_ack;
wire	[7:0]	rfr_ps_val;

// Memory Timing Block Signals
wire		data_oe;
wire		oe_;
wire		we_;
wire		cas_;
wire		ras_;
wire		cke_;
wire		lmr_req;
wire		lmr_ack;
wire		init_req;
wire		init_ack;
wire	[7:0]	spec_req_cs;
wire		cs_en;
wire		wb_cycle, wr_cycle;
wire	[31:0]	tms_s;
wire	[31:0]	csc_s;
wire		mc_c_oe_d;
wire		mc_br_r;
wire		mc_bg_d;
wire		mc_adsc_d;
wire		mc_adv_d;
wire		mc_ack_r;
wire		err;
wire		mc_sts_i;

////////////////////////////////////////////////////////////////////
//
// Misc Logic
//

assign obct_cs =	(rfr_ack | susp_sel) ? cs_need_rfr :
			(lmr_ack | init_ack) ? spec_req_cs : cs;

assign lmr_sel = lmr_ack | init_ack;

assign tms_s = lmr_sel ? sp_tms : tms;
assign csc_s = lmr_sel ? sp_csc : csc;


wire		not_mem_cyc;

assign	not_mem_cyc = wb_cyc_i & wb_stb_i & !( (wb_addr_i[31:29] == 3'h0) );

reg		mem_ack_r;

always @(posedge clk_i)
	mem_ack_r <= mem_ack;

////////////////////////////////////////////////////////////////////
//
// Modules
//

mc_rf		u0(
		.clk(		clk_i		),
		.rst(		rst_i		),
		.wb_data_i(	wb_data_i	),
		.rf_dout(	rf_dout		),
		.wb_addr_i(	wb_addr_i	),
		.wb_we_i(	wb_we_i		),
		.wb_cyc_i(	wb_cyc_i	),
		.wb_stb_i(	wb_stb_i 	),
		.wb_ack_o(			),
		.wp_err(	wp_err		),
		.csc(		csc		),
		.tms(		tms		),
		.poc(		poc_o		),
		.sp_csc(	sp_csc		),
		.sp_tms(	sp_tms		),
		.cs(		cs		),
		.mc_data_i(	mc_data_ir[31:0]),
		.mc_sts(	mc_sts_ir	),
		.mc_vpen(	mc_vpen_pad_o 	),
		.fs(		fs		),
		.cs_le(		cs_le		),
		.cs_le_d(	cs_le_d		),
		.cs_need_rfr(	cs_need_rfr	),
		.ref_int(	ref_int		),
		.rfr_ps_val(	rfr_ps_val	),
		.spec_req_cs(	spec_req_cs	),
		.init_req(	init_req	),
		.init_ack(	init_ack	),
		.lmr_req(	lmr_req		),
		.lmr_ack(	lmr_ack		)
		);

mc_adr_sel	u1(
		.clk(		clk_i		),
		.csc(		csc_s		),
		.tms(		tms_s		),
		.wb_stb_i(	wb_stb_i 	),
		//.wb_ack_o(	wb_ack_o	),
		.wb_ack_o(	mem_ack_r	),
		.wb_addr_i(	wb_addr_i	),
		.wb_we_i(	wb_we_i		),
		.wb_write_go(	wb_write_go	),
		.wr_hold(	wr_hold		),
		.cas_(		cas_		),
		.mc_addr(	mc_addr_d	),
		.row_adr(	row_adr		),
		.bank_adr(	bank_adr	),
		.rfr_ack(	rfr_ack		),
		.cs_le(		cs_le		),
		.cmd_a10(	cmd_a10		),
		.row_sel(	row_sel		),
		.lmr_sel(	lmr_sel		),
		.next_adr(	next_adr	),
		.wr_cycle(	wr_cycle	),
		.page_size(	page_size	)
		);

mc_obct_top	u2(
		.clk(		clk_i		),
		.rst(		rst_i		),
		.cs(		obct_cs		),
		.row_adr(	row_adr		),
		.bank_adr(	bank_adr	),
		.bank_set(	bank_set	),
		.bank_clr(	bank_clr	),
		.bank_clr_all(	bank_clr_all	),
		.bank_open(	bank_open	),
		.any_bank_open(	any_bank_open	),
		.row_same(	row_same	),
		.rfr_ack(	rfr_ack		)
		);

mc_dp		u3(
		.clk(		clk_i		),
		.rst(		rst_i		),
		.csc(		csc		),
		.wb_cyc_i(	wb_cyc_i	),
		.wb_stb_i(	wb_stb_i	),
		.mem_ack(	mem_ack 	),
		//.wb_ack_o(	wb_ack_o 	),
		.wb_ack_o(	mem_ack_r 	),
		.wb_we_i(	wb_we_i		),
		.wb_data_i(	wb_data_i	),
		.wb_data_o(	mem_dout	),
		.wb_read_go(	wb_read_go	),
		.mc_clk(	mc_clk_i	),
		.mc_data_del(	mc_data_ir	),
		.mc_dp_i(	mc_dp_pad_i	),
		.mc_data_o(	mc_data_od	),
		.mc_dp_o(	mc_dp_od	),
		.dv(		dv		),
		.pack_le0(	pack_le0	),
		.pack_le1(	pack_le1	),
		.pack_le2(	pack_le2	),
		.byte_en(	wb_sel_i	),
		.par_err(	par_err		)
		);

mc_refresh	u4(
		.clk(		clk_i		),
		.rst(		rst_i		),
		.cs_need_rfr(	cs_need_rfr	),
		.ref_int(	ref_int		),
		.rfr_req(	rfr_req		),
		.rfr_ack(	rfr_ack		),
		.rfr_ps_val(	rfr_ps_val	)
		);
 
mc_timing	u5(
		.clk(		clk_i		),
		.mc_clk(	mc_clk_i	),
		.rst(		rst_i		),
		.wb_cyc_i(	wb_cyc_i	),
		.wb_stb_i(	wb_stb_i 	),
		.wb_we_i(	wb_we_i		),
		.wb_read_go(	wb_read_go	),
		.wb_write_go(	wb_write_go	),
		.wb_first(	wb_first	),
		.wb_wait(	wb_wait		),
		.mem_ack(	mem_ack		),
		.err(		err		),
		.susp_req(	susp_req_i	),
		.resume_req(	resume_req_i	),
		.suspended(	suspended_o	),
		.susp_sel(	susp_sel	),
		.mc_br(		mc_br_r		),
		.mc_bg(		mc_bg_d		),
		.mc_ack(	mc_ack_r	),
		.not_mem_cyc(	not_mem_cyc	),
		.data_oe(	data_oe		),
		.oe_(		oe_		),
		.we_(		we_		),
		.cas_(		cas_		),
		.ras_(		ras_		),
		.cke_(		cke_		),
		.cs_en(		cs_en		),
		.mc_adsc(	mc_adsc_d	),
		.mc_adv(	mc_adv_d	),
		.mc_c_oe(	mc_c_oe_d	),
		.wb_cycle(	wb_cycle	),
		.wr_cycle(	wr_cycle	),
		.csc(		csc_s		),
		.tms(		tms_s		),
		.cs(		obct_cs		),
		.lmr_req(	lmr_req		),
		.lmr_ack(	lmr_ack		),
		.cs_le(		cs_le		),
		.cs_le_d(	cs_le_d		),
		.cmd_a10(	cmd_a10		),
		.row_sel(	row_sel		),
		.next_adr(	next_adr	),
		.page_size(	page_size	),
		.bank_set(	bank_set	),
		.bank_clr(	bank_clr	),
		.bank_clr_all(	bank_clr_all	),
		.bank_open(	bank_open	),
		.any_bank_open(	any_bank_open	),
		.row_same(	row_same	),
		.dv(		dv		),
		.pack_le0(	pack_le0	),
		.pack_le1(	pack_le1	),
		.pack_le2(	pack_le2	),
		.par_err(	par_err		),
		.rfr_req(	rfr_req		),
		.rfr_ack(	rfr_ack		),
		.init_req(	init_req	),
		.init_ack(	init_ack	)
		);

mc_wb_if	u6(
		.clk(		clk_i		),
		.rst(		rst_i		),
		.wb_addr_i(	wb_addr_i	),
		.wb_cyc_i(	wb_cyc_i	),
		.wb_stb_i(	wb_stb_i 	),
		.wb_we_i(	wb_we_i		),
		.wb_ack_o(	wb_ack_o	),
		.wb_err(	wb_err_o	),
		.wb_read_go(	wb_read_go	),
		.wb_write_go(	wb_write_go	),
		.wb_first(	wb_first	),
		.wb_wait(	wb_wait		),
		.mem_ack(	mem_ack		),
		.wr_hold(	wr_hold		),
		.err(		err		),
		.par_err(	par_err		),
		.wp_err(	wp_err		),
		.wb_data_o(	wb_data_o	),
		.mem_dout(	mem_dout	),
		.rf_dout(	rf_dout		)
		);

mc_mem_if	u7(
		.clk(		clk_i		),
		.rst(		rst_i		),
		.mc_rp(		mc_rp_pad_o_	),
		.mc_clk(	mc_clk_i	),
		.mc_br(		mc_br_pad_i	),
		.mc_bg(		mc_bg_pad_o	),
		.mc_addr(	mc_addr_pad_o	),
		.mc_data_o(	mc_data_pad_o	),
		.mc_dp_o(	mc_dp_pad_o	),
		.mc_data_oe(	mc_doe_pad_doe_o),
		.mc_dqm(	mc_dqm_pad_o	),
		.mc_oe_(	mc_oe_pad_o_	),
		.mc_we_(	mc_we_pad_o_	),
		.mc_cas_(	mc_cas_pad_o_	),
		.mc_ras_(	mc_ras_pad_o_	),
		.mc_cke_(	mc_cke_pad_o_	),
		.mc_cs_(	mc_cs_pad_o_	),
		.mc_adsc_(	mc_adsc_pad_o_	),
		.mc_adv_(	mc_adv_pad_o_	),
		.mc_br_r(	mc_br_r		),
		.mc_bg_d(	mc_bg_d		),
		.mc_data_od(	mc_data_od	),
		.mc_dp_od(	mc_dp_od	),
		.mc_addr_d(	mc_addr_d	),
		.mc_ack(	mc_ack_pad_i	),
		.mc_zz_o(	mc_zz_pad_o	),
		.we_(		we_		),
		.ras_(		ras_		),
		.cas_(		cas_		),
		.cke_(		cke_		),
		.mc_adsc_d(	mc_adsc_d	),
		.mc_adv_d(	mc_adv_d	),
		.cs_en(		cs_en		),
		.rfr_ack(	rfr_ack		),
		.cs_need_rfr(	cs_need_rfr	),
		.lmr_sel(	lmr_sel		),
		.spec_req_cs(	spec_req_cs	),
		.cs(		cs		),
		.fs(		fs		),
		.data_oe(	data_oe		),
		.susp_sel(	susp_sel	),
		.suspended_o(	suspended_o	),
		.mc_c_oe(	mc_coe_pad_coe_o),
		.mc_c_oe_d(	mc_c_oe_d	),
		.mc_ack_r(	mc_ack_r	),
		.oe_(		oe_		),
		.wb_cyc_i(	wb_cyc_i 	),
		.wb_stb_i(	wb_stb_i 	),
		.wb_sel_i(	wb_sel_i	),
		.wb_cycle(	wb_cycle	),
		.wr_cycle(	wr_cycle	),
		.mc_data_i(	mc_data_pad_i	),
		.mc_dp_i(	mc_dp_pad_i	),
		.mc_data_ir(	mc_data_ir	),
		.mc_sts_i(	mc_sts_pad_i	),
		.mc_sts_ir(	mc_sts_ir	)
		);

endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE Memory Controller Definitions                     ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/mem_ctrl/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: mc_defines.v,v 1.7 2002-01-21 13:08:52 rudi Exp $
//
//  $Date: 2002-01-21 13:08:52 $
//  $Revision: 1.7 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.6  2001/12/12 06:35:15  rudi
//               *** empty log message ***
//
//               Revision 1.5  2001/12/11 02:47:19  rudi
//
//               - Made some changes not to expect clock during reset ...
//
//               Revision 1.4  2001/11/29 02:16:28  rudi
//
//
//               - More Synthesis cleanup, mostly for speed
//               - Several bug fixes
//               - Changed code to avoid auto-precharge and
//                 burst-terminate combinations (apparently illegal ?)
//                 Now we will do a manual precharge ...
//
//               Revision 1.3  2001/09/10 13:44:17  rudi
//               *** empty log message ***
//
//               Revision 1.2  2001/08/10 08:16:21  rudi
//
//               - Changed IO names to be more clear.
//               - Uniquifyed define names to be core specific.
//               - Removed "Refresh Early" configuration
//
//               Revision 1.1  2001/07/29 07:34:41  rudi
//
//
//               1) Changed Directory Structure
//               2) Fixed several minor bugs
//
//               Revision 1.3  2001/06/12 15:19:49  rudi
//
//
//              Minor changes after running lint, and a small bug
//		fix reading csr and ba_mask registers.
//
//               Revision 1.2  2001/06/03 11:37:17  rudi
//
//
//               1) Fixed Chip Select Mask Register
//               	- Power On Value is now all ones
//               	- Comparison Logic is now correct
//
//               2) All resets are now asynchronous
//
//               3) Converted Power On Delay to an configurable item
//
//               4) Added reset to Chip Select Output Registers
//
//               5) Forcing all outputs to Hi-Z state during reset
//
//               Revision 1.1.1.1  2001/05/13 09:39:38  rudi
//               Created Directory Structure
//
//
//
//

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
//
// This define selects how the WISHBONE interface determines if
// the internal register file is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


// This define selects how the WISHBONE interface determines if
// the memory is selected.
// This should be a simple address decoder. "wb_addr_i" is the
// WISHBONE address bus (32 bits wide).


/////////////////////////////////////////////////////////////////////
//
// This are the default Power-On Reset values for Chip Select
//

// This will be defined by the run script for my test bench ...
// Alternatively force here for synthesis ...
//`define RUDIS_TB 1

// Defines which chip select is used for Power On booting

// To run my default testbench default boot CS must be 3 !!!






// Defines the default (reset) TMS value for the DEF_SEL chip select



/////////////////////////////////////////////////////////////////////
//
// Define how many Chip Selects to Implement
//

//`define MC_HAVE_CS2	1
//`define MC_HAVE_CS3	1
//`define MC_HAVE_CS4	1
//`define MC_HAVE_CS5	1
//`define MC_HAVE_CS6	1
//`define MC_HAVE_CS7	1


// To run my default testbench those need to there !!!







/////////////////////////////////////////////////////////////////////
//
// Init Refresh
//
// Number of Refresh Cycles to perform during SDRAM initialization.
// This varies between SDRAM manufacturer. Typically this value is
// between 2 and 8. This number must be smaller than 16.


/////////////////////////////////////////////////////////////////////
//
// Power On Delay
//
// Most if SDRAMs require some time to initialize before they can be used
// after power on. If the Memory Controller shall stall after power on to
// allow SDRAMs to finish the initialization process uncomment the below
// define statement


// This value defines how many MEM_CLK cycles the Memory Controller should
// stall. Default is 2.5uS. At a 10nS MEM_CLK cycle time, this would 250
// cycles.



// ===============================================================
// ===============================================================
// Various internal defines (DO NOT MODIFY !)
// ===============================================================
// ===============================================================

// Register settings encodings













// Command Valid, Ras_, Cas_, We_















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

assign mem_sel = (wb_addr_i[31:29] == 3'h0);

always @(posedge clk or posedge rst)
	if(rst)			rmw_en <= 1'b0;
	else
	if(wb_ack_o)		rmw_en <= 1'b1;
	else
	if(!wb_cyc_i)		rmw_en <= 1'b0;

always @(posedge clk or posedge rst)
	if(rst)	rmw_r <= 1'b0;
	else	rmw_r <= !wr_hold & wb_we_i & wb_cyc_i & wb_stb_i & rmw_en;

assign rmw = rmw_r | (!wr_hold & wb_we_i & wb_cyc_i & wb_stb_i & rmw_en);

always @(posedge clk or posedge rst)
	if(rst)	read_go_r1 <= 1'b0;
	else	read_go_r1 <= !rmw & wb_cyc_i &
				((wb_stb_i & mem_sel & !wb_we_i) | read_go_r);

always @(posedge clk or posedge rst)
	if(rst)	read_go_r <= 1'b0;
	else	read_go_r <= read_go_r1 & wb_cyc_i;

assign	wb_read_go = !rmw & read_go_r1 & wb_cyc_i;

always @(posedge clk or posedge rst)
	if(rst)	write_go_r1 <= 1'b0;
	else	write_go_r1 <= wb_cyc_i &
				((wb_stb_i & mem_sel & wb_we_i) | write_go_r);

always @(posedge clk or posedge rst)
	if(rst)		write_go_r <= 1'b0;
	else		write_go_r <= write_go_r1 & wb_cyc_i &
					((wb_we_i & wb_stb_i) | !wb_stb_i);

assign wb_write_go =	!rmw & write_go_r1 & wb_cyc_i &
			((wb_we_i & wb_stb_i) | !wb_stb_i);

assign wb_first_set = mem_sel & wb_cyc_i & wb_stb_i & !(read_go_r | write_go_r);
assign wb_first = wb_first_set | (wb_first_r & !wb_ack_o & !wb_err);

always @(posedge clk or posedge rst)
	if(rst)			wb_first_r <= 1'b0;
	else
	if(wb_first_set)	wb_first_r <= 1'b1;
	else
	if(wb_ack_o | wb_err)	wb_first_r <= 1'b0;

always @(posedge clk or posedge rst)
	if(rst)			wr_hold <= 1'b0;
	else
	if(wb_cyc_i & wb_stb_i)	wr_hold <= wb_we_i;

////////////////////////////////////////////////////////////////////
//
// WB Ack
//

wire	wb_err_d;

// Ack no longer asserted when wb_err is asserted
always @(posedge clk or posedge rst)
	if(rst)	wb_ack_o <= 1'b0;
	else	wb_ack_o <= (wb_addr_i[31:29] == 3'h0) ? mem_ack & !wb_err_d :
				(wb_addr_i[31:29] == 3'b011) & wb_cyc_i & wb_stb_i & !wb_ack_o;

assign wb_err_d = wb_cyc_i & wb_stb_i & (par_err | err | wp_err);

always @(posedge clk or posedge rst)
	if(rst)	wb_err <= 1'b0;
	else	wb_err <= (wb_addr_i[31:29] == 3'h0) & wb_err_d & !wb_err;

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
	wb_data_o <= (wb_addr_i[31:29] == 3'h0) ? mem_dout : rf_dout;

endmodule
