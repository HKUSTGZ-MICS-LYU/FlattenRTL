//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Generic Dual-Port Synchronous RAM                           ////
////                                                              ////
////  This file is part of memory library available from          ////
////  http://www.opencores.org/cvsweb.shtml/generic_memories/     ////
////                                                              ////
////  Description                                                 ////
////  This block is a wrapper with common dual-port               ////
////  synchronous memory interface for different                  ////
////  types of ASIC and FPGA RAMs. Beside universal memory        ////
////  interface it also provides behavioral model of generic      ////
////  dual-port synchronous RAM.                                  ////
////  It also contains a fully synthesizeable model for FPGAs.    ////
////  It should be used in all OPENCORES designs that want to be  ////
////  portable accross different target technologies and          ////
////  independent of target memory.                               ////
////                                                              ////
////  Supported ASIC RAMs are:                                    ////
////  - Artisan Dual-Port Sync RAM                                ////
////  - Avant! Two-Port Sync RAM (*)                              ////
////  - Virage 2-port Sync RAM                                    ////
////                                                              ////
////  Supported FPGA RAMs are:                                    ////
////  - Generic FPGA (VENDOR_FPGA)                                ////
////    Tested RAMs: Altera, Xilinx                               ////
////    Synthesis tools: LeonardoSpectrum, Synplicity             ////
////  - Xilinx (VENDOR_XILINX)                                    ////
////  - Altera (VENDOR_ALTERA)                                    ////
////                                                              ////
////  To doo:                                                      ////
////   - fix Avant!                                               ////
////   - add additional RAMs (VS etc)                             ////
////                                                              ////
////  Author(s):                                                  ////
////      - Richard Herveille, richard@asics.ws                   ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: generic_dpram.v,v $
// Revision 1.3  2003/03/18 21:45:48  rherveille
// Added WISHBONE revB.3 Registered Feedback Cycles support
//
// Revision 1.4  2002/09/28 08:18:52  rherveille
// Changed synthesizeable FPGA memory implementation.
// Fixed some issues with Xilinx BlockRAM
//
// Revision 1.3  2001/11/09 00:34:18  samg
// minor changes: unified with all common rams
//
// Revision 1.2  2001/11/08 19:11:31  samg
// added valid checks to behvioral model
//
// Revision 1.1.1.1  2001/09/14 09:57:10  rherveille
// Major cleanup.
// Files are now compliant to Altera & Xilinx memories.
// Memories are now compatible, i.e. drop-in replacements.
// Added synthesizeable generic FPGA description.
// Created "generic_memories" cvs entry.
//
// Revision 1.1.1.2  2001/08/21 13:09:27  damjan
// *** empty log message ***
//
// Revision 1.1  2001/08/20 18:23:20  damjan
// Initial revision
//
// Revision 1.1  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.2  2001/07/30 05:38:02  lampret
// Adding empty directories required by HDL coding guidelines
//
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on


//`define VENDOR_XILINX
//`define VENDOR_ALTERA

module generic_dpram
   (
    input                rclk,
    input                rrst,
    input                rce,
    input                oe,
    input [7-1:0]       raddr,
    output [24-1:0]      doo,
    input                wclk,
    input                wrst,
    input                wce,
    input                we,
    input [7-1:0]       waddr,
    input [24-1:0]       di
    );
	//
	// Module body
	//


	//
	// Instantiation synthesizeable FPGA memory
	//
	// This code has been tested using LeonardoSpectrum and Synplicity.
	// The code correctly instantiates Altera EABs and Xilinx BlockRAMs.
	//

	// NOTE:
	// 'synthesis syn_ramstyle="block_ram"' is a Synplify attribute.
	// It instructs Synplify to map to BlockRAMs instead of the default SelectRAMs

	reg [24-1:0] mem [(1<<7) -1:0] /* synthesis syn_ramstyle="block_ram" */;
	reg [7-1:0] ra;                // register read address

	// read operation
	always @(posedge rclk)
	  if (rce)
	    ra <= raddr;

    assign doo = mem[ra];

	// write operation
	always @(posedge wclk)
		if (we && wce)
			mem[waddr] <= di;
























































































































































































 // !VENDOR_FPGA

endmodule

//
// Black-box modules
//























































 // VENDOR_ALTERA
































































































 // VENDOR_XILINX
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Generic Single-Port Synchronous RAM                         ////
////                                                              ////
////  This file is part of memory library available from          ////
////  http://www.opencores.org/cvsweb.shtml/generic_memories/     ////
////                                                              ////
////  Description                                                 ////
////  This block is a wrapper with common single-port             ////
////  synchronous memory interface for different                  ////
////  types of ASIC and FPGA RAMs. Beside universal memory        ////
////  interface it also provides a behavioral model of generic    ////
////  single-port synchronous RAM.                                ////
////  It also contains a synthesizeable model for FPGAs.          ////
////  It should be used in all OPENCORES designs that want to be  ////
////  portable accross different target technologies and          ////
////  independent of target memory.                               ////
////                                                              ////
////  Supported ASIC RAMs are:                                    ////
////  - Artisan Single-Port Sync RAM                              ////
////  - Avant! Two-Port Sync RAM (*)                              ////
////  - Virage Single-Port Sync RAM                               ////
////  - Virtual Silicon Single-Port Sync RAM                      ////
////                                                              ////
////  Supported FPGA RAMs are:                                    ////
////  - Generic FPGA (VENDOR_FPGA)                                ////
////    Tested RAMs: Altera, Xilinx                               ////
////    Synthesis tools: LeonardoSpectrum, Synplicity             ////
////  - Xilinx (VENDOR_XILINX)                                    ////
////  - Altera (VENDOR_ALTERA)                                    ////
////                                                              ////
////  To doo:                                                      ////
////   - fix avant! two-port ram                                  ////
////   - add additional RAMs                                      ////
////                                                              ////
////  Author(s):                                                  ////
////      - Richard Herveille, richard@asics.ws                   ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: generic_spram.v,v $
// Revision 1.3  2003/03/18 21:45:48  rherveille
// Added WISHBONE revB.3 Registered Feedback Cycles support
//
//
//

`timescale 1ns / 10ps


//`define VENDOR_XILINX
//`define VENDOR_ALTERA


module generic_spram_9_32(
	// Generic synchronous single-port RAM interface
	clk, rst, ce, we, oe, addr, di, doo
);

	//
	// Generic synchronous single-port RAM interface
	//
	input           clk;  // Clock, rising edge
	input           rst;  // Reset, active high
	input           ce;   // Chip enable input, active high
	input           we;   // Write enable input, active high
	input           oe;   // Output enable input, active high
	input  [9-1:0] addr; // address bus inputs
	input  [32-1:0] di;   // input data bus
	output [32-1:0] doo;   // output data bus

	//
	// Module body
	//


	//
	// Instantiation synthesizeable FPGA memory
	//
	// This code has been tested using LeonardoSpectrum and Synplicity.
	// The code correctly instantiates Altera EABs and Xilinx BlockRAMs.
	//

	// NOTE:
	// 'synthesis syn_ramstyle="block_ram"' is a Synplify attribute.
	// It instructs Synplify to map to BlockRAMs instead of the default SelectRAMs

	reg [32-1:0] mem [(1<<9) -1:0] /* synthesis syn_ramstyle="block_ram" */;
	reg [9-1:0] ra;

	// read operation
	always @(posedge clk)
	  if (ce)
	    ra <= addr;     // read address needs to be registered to read clock

	assign doo = mem[ra];

	// write operation
	always @(posedge clk)
	  if (we && ce)
	    mem[addr] <= di;




































































































































































 // !VENDOR_FPGA

endmodule

module generic_spram_9_24(
	// Generic synchronous single-port RAM interface
	clk, rst, ce, we, oe, addr, di, doo
);

	//
	// Generic synchronous single-port RAM interface
	//
	input           clk;  // Clock, rising edge
	input           rst;  // Reset, active high
	input           ce;   // Chip enable input, active high
	input           we;   // Write enable input, active high
	input           oe;   // Output enable input, active high
	input  [9-1:0] addr; // address bus inputs
	input  [24-1:0] di;   // input data bus
	output [24-1:0] doo;   // output data bus

	//
	// Module body
	//


	//
	// Instantiation synthesizeable FPGA memory
	//
	// This code has been tested using LeonardoSpectrum and Synplicity.
	// The code correctly instantiates Altera EABs and Xilinx BlockRAMs.
	//

	// NOTE:
	// 'synthesis syn_ramstyle="block_ram"' is a Synplify attribute.
	// It instructs Synplify to map to BlockRAMs instead of the default SelectRAMs

	reg [24-1:0] mem [(1<<9) -1:0] /* synthesis syn_ramstyle="block_ram" */;
	reg [9-1:0] ra;

	// read operation
	always @(posedge clk)
	  if (ce)
	    ra <= addr;     // read address needs to be registered to read clock

	assign doo = mem[ra];

	// write operation
	always @(posedge clk)
	  if (we && ce)
	    mem[addr] <= di;




































































































































































 // !VENDOR_FPGA

endmodule

module generic_spram(
	// Generic synchronous single-port RAM interface
	clk, rst, ce, we, oe, addr, di, doo
);

	//
	// Default address and data buses width
	//
	parameter aw = 6; //number of address-bits
	parameter dw = 8; //number of data-bits

	//
	// Generic synchronous single-port RAM interface
	//
	input           clk;  // Clock, rising edge
	input           rst;  // Reset, active high
	input           ce;   // Chip enable input, active high
	input           we;   // Write enable input, active high
	input           oe;   // Output enable input, active high
	input  [aw-1:0] addr; // address bus inputs
	input  [dw-1:0] di;   // input data bus
	output [dw-1:0] doo;   // output data bus

	//
	// Module body
	//


	//
	// Instantiation synthesizeable FPGA memory
	//
	// This code has been tested using LeonardoSpectrum and Synplicity.
	// The code correctly instantiates Altera EABs and Xilinx BlockRAMs.
	//

	// NOTE:
	// 'synthesis syn_ramstyle="block_ram"' is a Synplify attribute.
	// It instructs Synplify to map to BlockRAMs instead of the default SelectRAMs

	reg [dw-1:0] mem [(1<<aw) -1:0] /* synthesis syn_ramstyle="block_ram" */;
	reg [aw-1:0] ra;

	// read operation
	always @(posedge clk)
	  if (ce)
	    ra <= addr;     // read address needs to be registered to read clock

	assign doo = mem[ra];

	// write operation
	always @(posedge clk)
	  if (we && ce)
	    mem[addr] <= di;




































































































































































 // !VENDOR_FPGA

endmodule


//
// Black-box modules
//







































 // VENDOR_ALTERA






























































 // VENDOR_XILINX

`timescale 1ns / 10ps

/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant VGA/LCD Core; Clock Generator    ////
////                                                             ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2003 Richard Herveille                        ////
////                    richard@asics.ws                         ////
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

/////////////////////////////////////////////////////////////////////
//                                                                 //
// !! SPECIAL LOGIC, USE PRECAUTION DURING SYNTHESIS AND LAYOUT !! //
//                                                                 //
// This is a clock generation circuit. Although all output clocks  //
// are generated synchronous to the input clock, special care must //
// be taken during synthesis and physical layout.                  //
//                                                                 //
/////////////////////////////////////////////////////////////////////



//  CVS Log
//
//  $Id: vga_clkgen.v,v 1.1 2003/05/07 14:43:01 rherveille Exp $
//
//  $Date: 2003/05/07 14:43:01 $
//  $Revision: 1.1 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_clkgen.v,v $
//               Revision 1.1  2003/05/07 14:43:01  rherveille
//               Initial release.
//
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on

/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant enhanced VGA/LCD Core            ////
////  Defines file                                               ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001, 2002 Richard Herveille                  ////
////                          richard@asics.ws                   ////
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
//  $Id: vga_defines.v,v 1.6 2003/08/01 11:46:38 rherveille Exp $
//
//  $Date: 2003/08/01 11:46:38 $
//  $Revision: 1.6 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_defines.v,v $
//               Revision 1.6  2003/08/01 11:46:38  rherveille
//               1) Rewrote vga_fifo_dc. It now uses gray codes and a more elaborate anti-metastability scheme.
//               2) Changed top level and pixel generator to reflect changes in the fifo.
//               3) Changed a bug in vga_fifo.
//               4) Changed pixel generator and wishbone master to reflect changes.
//
//               Revision 1.5  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.4  2002/02/07 05:42:10  rherveille
//               Fixed some bugs discovered by modified testbench
//               Removed / Changed some strange logic constructions
//               Started work on hardware cursor support (not finished yet)
//               Changed top-level name to vga_enh_top.v
//


////////////////////////
//
// Global settings
//

//
// define memory vendor
// for FPGA implementations use `define VENDOR_FPGA



//
// enable / disable 12bit DVI output
// (for use with external DVI transmitters)
//`define VGA_12BIT_DVI


////////////////////////
//
// Hardware Cursors
//

//
// enable / disable hardware cursors
//
//`define VGA_HWC0
//`define VGA_HWC1


//
// enable / disabled 3D support for hardware cursors
//
//`define VGA_HWC_3D


module vga_clkgen (
	pclk_i, rst_i, pclk_o, dvi_pclk_p_o, dvi_pclk_m_o, pclk_ena_o
);

	// inputs & outputs

	input  pclk_i;       // pixel clock in
	input  rst_i;        // reset input

	output pclk_o;       // pixel clock out

	output reg dvi_pclk_p_o; // dvi cpclk+ output
	output reg dvi_pclk_m_o; // dvi cpclk- output

	output pclk_ena_o;   // pixel clock enable output

	//
	// variable declarations
	//
	// reg dvi_pclk_p_o;
	// reg dvi_pclk_m_o;

	//////////////////////////////////
	//
	// module body
	//

	// These should be registers in or near IO buffers
	always @(posedge pclk_i)
	  if (rst_i) begin
	    dvi_pclk_p_o <= 1'b0;
	    dvi_pclk_m_o <= 1'b0;
	  end else begin
	    dvi_pclk_p_o <= ~dvi_pclk_p_o;
	    dvi_pclk_m_o <= dvi_pclk_p_o;
	  end





















	// No DVI circuit
	// Simply reroute the pixel clock input

	assign pclk_o     = pclk_i;
	assign pclk_ena_o = 1'b1;


endmodule

/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant VGA/LCD Core                     ////
////  Enhanced Color Processor                                   ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001, 2002 Richard Herveille                  ////
////                          richard@asics.ws                   ////
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
//  $Id: vga_colproc.v,v 1.8 2003/05/07 09:48:54 rherveille Exp $
//
//  $Date: 2003/05/07 09:48:54 $
//  $Revision: 1.8 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_colproc.v,v $
//               Revision 1.8  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.7  2002/03/04 11:01:59  rherveille
//               Added 64x64pixels 4bpp hardware cursor support.
//
//               Revision 1.6  2002/02/07 05:42:10  rherveille
//               Fixed some bugs discovered by modified testbench
//               Removed / Changed some strange logic constructions
//               Started work on hardware cursor support (not finished yet)
//               Changed top-level name to vga_enh_top.v
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on

module vga_colproc(clk, srst, vdat_buffer_di, ColorDepth, PseudoColor, 
	vdat_buffer_empty, vdat_buffer_rreq, rgb_fifo_full,
	rgb_fifo_wreq, r, g, b,
	clut_req, clut_ack, clut_offs, clut_q
	);

	//
	// inputs & outputs
	//
	input clk;                    // master clock
	input srst;                   // synchronous reset

	input [31:0] vdat_buffer_di;  // video memory data input

	input [1:0] ColorDepth;       // color depth (8bpp, 16bpp, 24bpp)
	input       PseudoColor;      // pseudo color enabled (only for 8bpp color depth)

	input  vdat_buffer_empty;
	output reg vdat_buffer_rreq;      // pixel buffer read request

	input  rgb_fifo_full;
	output reg rgb_fifo_wreq;
	// reg    rgb_fifo_wreq;
	output reg [7:0] r, g, b;         // pixel color information
	// reg    [7:0] r, g, b;

	output reg       clut_req;       // clut request
	// reg clut_req;
	input         clut_ack;       // clut acknowledge
	output reg [ 7:0] clut_offs;      // clut offset
	// reg [7:0] clut_offs;
	input  [23:0] clut_q;         // clut data in

	//
	// variable declarations
	//
	reg [31:0] DataBuffer;

	reg [7:0] Ra, Ga, Ba;
	reg [1:0] colcnt;
	reg RGBbuf_wreq;

	//
	// Module body
	//

	// store word from pixelbuffer / wishbone input
	always @(posedge clk)
		if (vdat_buffer_rreq)
			DataBuffer <= vdat_buffer_di;

	//
	// generate statemachine
	//
	// extract color information from data buffer
	parameter idle        = 7'b000_0000, 
	          fill_buf    = 7'b000_0001,
	          bw_8bpp     = 7'b000_0010,
	          col_8bpp    = 7'b000_0100,
	          col_16bpp_a = 7'b000_1000,
	          col_16bpp_b = 7'b001_0000,
	          col_24bpp   = 7'b010_0000,
	          col_32bpp   = 7'b100_0000;

	reg [6:0] c_state;   // xsynopsys enum_state
	reg [6:0] nxt_state; // xsynopsys enum_state

	// next state decoder
	always @(c_state or vdat_buffer_empty or ColorDepth or PseudoColor or rgb_fifo_full or colcnt or clut_ack)
	begin : nxt_state_decoder
		// initial value
		nxt_state = c_state;

		case (c_state) // synopsis full_case parallel_case
			// idle state
			idle:
				if (!vdat_buffer_empty && !rgb_fifo_full)
					nxt_state = fill_buf;

			// fill data buffer
			fill_buf:
				case (ColorDepth) // synopsis full_case parallel_case
					2'b00: 
						if (PseudoColor)
							nxt_state = col_8bpp;
						else
							nxt_state = bw_8bpp;

					2'b01:
						nxt_state = col_16bpp_a;

					2'b10:
						nxt_state = col_24bpp;

					2'b11:
						nxt_state = col_32bpp;

				endcase

			//
			// 8 bits per pixel
			//
			bw_8bpp:
				if (!rgb_fifo_full && !(|colcnt) )
					if (!vdat_buffer_empty)
						nxt_state = fill_buf;
					else
						nxt_state = idle;

			col_8bpp:
				// doo NOT check for rgb_fifo_full here.
				// In 8bpp pseudo-color mode the color-processor must always finish
				// the current 4pixel-block(i.e. it runs until colcnt = '11').
				// This is because of the late clut-response which shuffles all
				// signals the state-machine depends on.
				// Because of this we can not doo an early video_memory_data fetch,
				// i.e. we can not jump to the fill_buf state. Instead we always
				// jump to idle and check for rgb_fifo_full there.
				//
				// The addition of the cursor-processors forces us to increase the
				// rgb-fifo size. The increased rgb-fifo also handles the above
				// described problem. Thus erradicating the above comment.
				// We add the early video_memory_data fetch again.
				if (!(|colcnt))
					if (!vdat_buffer_empty && !rgb_fifo_full)
						nxt_state = fill_buf;
					else
						nxt_state = idle;

			//
			// 16 bits per pixel
			//
			col_16bpp_a:
				if (!rgb_fifo_full)
					nxt_state = col_16bpp_b;

			col_16bpp_b:
				if (!rgb_fifo_full)
					if (!vdat_buffer_empty)
						nxt_state = fill_buf;
					else
						nxt_state = idle;

			//
			// 24 bits per pixel
			//
			col_24bpp:
				if (!rgb_fifo_full)
					if (colcnt == 2'h1) // (colcnt == 1)
						nxt_state = col_24bpp; // stay in current state
					else if (!vdat_buffer_empty)
						nxt_state = fill_buf;
					else
						nxt_state = idle;

			//
			// 32 bits per pixel
			//
			col_32bpp:
				if (!rgb_fifo_full)
					if (!vdat_buffer_empty)
						nxt_state = fill_buf;
					else
						nxt_state = idle;
		endcase
	end // next state decoder

	// generate state registers
	always @(posedge clk)
			if (srst)
				c_state <= idle;
			else
				c_state <= nxt_state;


	reg iclut_req;
	reg ivdat_buf_rreq;
	reg [7:0] iR, iG, iB, iRa, iGa, iBa;

	// output decoder
	always @(c_state or vdat_buffer_empty or colcnt or DataBuffer or rgb_fifo_full or clut_ack or clut_q or Ba or Ga or Ra)
	begin : output_decoder

		// initial values
		ivdat_buf_rreq = 1'b0;
		RGBbuf_wreq = 1'b0;
		iclut_req = 1'b0;
				
		iR  = 'h0;
		iG  = 'h0;
		iB  = 'h0;
		iRa = 'h0;
		iGa = 'h0;
		iBa = 'h0;

		case (c_state) // synopsis full_case parallel_case
			idle:
				begin
					if (!rgb_fifo_full)
						if (!vdat_buffer_empty)
							ivdat_buf_rreq = 1'b1;

					// when entering from 8bpp_pseudo_color_mode
					RGBbuf_wreq = clut_ack;

					iR = clut_q[23:16];
					iG = clut_q[15: 8];
					iB = clut_q[ 7: 0];
				end

			fill_buf:
				begin
					// when entering from 8bpp_pseudo_color_mode
					RGBbuf_wreq = clut_ack;

					iR = clut_q[23:16];
					iG = clut_q[15: 8];
					iB = clut_q[ 7: 0];
				end

			//		
			// 8 bits per pixel
			//
			bw_8bpp:
			begin
				if (!rgb_fifo_full)
					begin
						RGBbuf_wreq = 1'b1;

						if ( (!vdat_buffer_empty) && !(|colcnt) )
							ivdat_buf_rreq = 1'b1;
					end

				case (colcnt) // synopsis full_case parallel_case
					2'b11:
					begin
						iR = DataBuffer[31:24];
						iG = DataBuffer[31:24];
						iB = DataBuffer[31:24];
					end

					2'b10:
					begin
						iR = DataBuffer[23:16];
						iG = DataBuffer[23:16];
						iB = DataBuffer[23:16];
					end

					2'b01:
					begin
						iR = DataBuffer[15:8];
						iG = DataBuffer[15:8];
						iB = DataBuffer[15:8];
					end

					default:
					begin
						iR = DataBuffer[7:0];
						iG = DataBuffer[7:0];
						iB = DataBuffer[7:0];
					end
				endcase
			end

			col_8bpp:
			begin
				// doo NOT check for rgb_fifo_full here.
				// In 8bpp pseudo-color mode the color-processor must always finish
				// the current 4pixel-block(i.e. it runs until colcnt = '11').
				// This is because of the late clut-response which shuffles all
				// signals the state-machine depends on.
				// Because of this we can not doo an early video_memory_data fetch,
				// i.e. we can not jump to the fill_buf state. Instead we always
				// jump to idle and check for rgb_fifo_full there.
				//
				// The addition of the cursor-processors forces us to increase the
				// rgb-fifo size. The increased rgb-fifo also handles the above
				// described problem. Thus erradicating the above comment.
				// We add the early video_memory_data fetch again.
				if (!(|colcnt))
					if (!vdat_buffer_empty && !rgb_fifo_full)
						ivdat_buf_rreq = 1'b1;

				RGBbuf_wreq = clut_ack;

				iR = clut_q[23:16];
				iG = clut_q[15: 8];
				iB = clut_q[ 7: 0];

				iclut_req = !rgb_fifo_full || (colcnt[1] ^ colcnt[0]);
			end

			//
			// 16 bits per pixel
			//
			col_16bpp_a:
			begin
				if (!rgb_fifo_full)
					RGBbuf_wreq = 1'b1;

				iR[7:3] = DataBuffer[31:27];
				iG[7:2] = DataBuffer[26:21];
				iB[7:3] = DataBuffer[20:16];
			end

			col_16bpp_b:
			begin
				if (!rgb_fifo_full)
					begin
						RGBbuf_wreq = 1'b1;

						if (!vdat_buffer_empty)
							ivdat_buf_rreq = 1'b1;
					end

				iR[7:3] = DataBuffer[15:11];
				iG[7:2] = DataBuffer[10: 5];
				iB[7:3] = DataBuffer[ 4: 0];
			end

			//
			// 24 bits per pixel
			//
			col_24bpp:
			begin
				if (!rgb_fifo_full)
					begin
						RGBbuf_wreq = 1'b1;

						if ( (colcnt != 2'h1) && !vdat_buffer_empty)
							ivdat_buf_rreq = 1'b1;
					end


				case (colcnt) // synopsis full_case parallel_case
					2'b11:
					begin
						iR  = DataBuffer[31:24];
						iG  = DataBuffer[23:16];
						iB  = DataBuffer[15: 8];
						iRa = DataBuffer[ 7: 0];
					end

					2'b10:
					begin
						iR  = Ra;
						iG  = DataBuffer[31:24];
						iB  = DataBuffer[23:16];
						iRa = DataBuffer[15: 8];
						iGa = DataBuffer[ 7: 0];
					end

					2'b01:
					begin
						iR  = Ra;
						iG  = Ga;
						iB  = DataBuffer[31:24];
						iRa = DataBuffer[23:16];
						iGa = DataBuffer[15: 8];
						iBa = DataBuffer[ 7: 0];
					end

					default:
					begin
						iR = Ra;
						iG = Ga;
						iB = Ba;
					end
				endcase
			end

			//
			// 32 bits per pixel
			//
			col_32bpp:
			begin
				if (!rgb_fifo_full)
					begin
						RGBbuf_wreq = 1'b1;

						if (!vdat_buffer_empty)
							ivdat_buf_rreq = 1'b1;
					end

				iR[7:0] = DataBuffer[23:16];
				iG[7:0] = DataBuffer[15:8];
				iB[7:0] = DataBuffer[7:0];
			end

		endcase
	end // output decoder

	// generate output registers
	always @(posedge clk)
		begin
			r  <= iR;
			g  <= iG;
			b  <= iB;

			if (RGBbuf_wreq)
				begin
					Ra <= iRa;
					Ba <= iBa;
					Ga <= iGa;
				end

			if (srst)
				begin
					vdat_buffer_rreq <= 1'b0;
					rgb_fifo_wreq <= 1'b0;
					clut_req <= 1'b0;
				end
			else
				begin
					vdat_buffer_rreq <= ivdat_buf_rreq;
					rgb_fifo_wreq <= RGBbuf_wreq;
					clut_req <= iclut_req;
				end
	end

	// assign clut offset
	always @(colcnt or DataBuffer)
	  case (colcnt) // synopsis full_case parallel_case
	      2'b11: clut_offs = DataBuffer[31:24];
	      2'b10: clut_offs = DataBuffer[23:16];
	      2'b01: clut_offs = DataBuffer[15: 8];
	      2'b00: clut_offs = DataBuffer[ 7: 0];
	  endcase


	//
	// color counter
	//
	always @(posedge clk)
	  if (srst)
	    colcnt <= 2'b11;
	  else if (RGBbuf_wreq)
	    colcnt <= colcnt -2'h1;
endmodule


/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant VGA/LCD Core; CycleShared Memory ////
////                                                             ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001 Richard Herveille                        ////
////                    richard@asics.ws                         ////
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
//  $Id: vga_csm_pb.v,v 1.7 2003/05/07 09:48:54 rherveille Exp $
//
//  $Date: 2003/05/07 09:48:54 $
//  $Revision: 1.7 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_csm_pb.v,v $
//               Revision 1.7  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.6  2002/02/07 05:42:10  rherveille
//               Fixed some bugs discovered by modified testbench
//               Removed / Changed some strange logic constructions
//               Started work on hardware cursor support (not finished yet)
//               Changed top-level name to vga_enh_top.v
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on

module vga_csm_pb (clk_i, req0_i, ack0_o, adr0_i, dat0_i, dat0_o, we0_i, req1_i, ack1_o, adr1_i, dat1_i, dat1_o, we1_i);
		
	input clk_i;                    // clock input

	// wishbone slave0 connections
	input  [ 8:0] adr0_i; // address input
	input  [ 23:0] dat0_i; // data input
	output [ 23:0] dat0_o; // data output
	input                   we0_i;  // write enable input
	input                   req0_i; // access request input
	output                  ack0_o; // access acknowledge output

	// wishbone slave1 connections
	input  [ 8:0] adr1_i; // address input
	input  [ 23:0] dat1_i; // data input
	output [ 23:0] dat1_o; // data output
	input                   we1_i;  // write enable input
	input                   req1_i; // access request input
	output                  ack1_o; // access acknowledge output

	//
	// variable declarations
	//

	// multiplexor select signal
	wire acc0, acc1;
	reg  dacc0, dacc1;
	wire sel0, sel1;
	reg  ack0, ack1;
	
	// memory data output
	wire [24 -1:0] mem_q;


	//
	// module body
	//

	// generate multiplexor select signal
	assign acc0 = req0_i;
	assign acc1 = req1_i && !sel0;

	always@(posedge clk_i)
		begin
			dacc0 <= acc0 & !ack0_o;
			dacc1 <= acc1 & !ack1_o;
		end

	assign sel0 = acc0 && !dacc0;
	assign sel1 = acc1 && !dacc1;

	always@(posedge clk_i)
		begin
			ack0 <= sel0 && !ack0_o;
			ack1 <= sel1 && !ack1_o;
		end

	wire [9 -1:0] mem_adr = sel0 ? adr0_i : adr1_i;
	wire [24 -1:0] mem_d   = sel0 ? dat0_i : dat1_i;
	wire               mem_we  = sel0 ? req0_i && we0_i : req1_i && we1_i;

	// hookup generic synchronous single port memory
	generic_spram_9_24 clut_mem(
		.clk(clk_i),
		.rst(1'b0),       // no reset
		.ce(1'b1),        // always enable memory
		.we(mem_we),
		.oe(1'b1),        // always output data
		.addr(mem_adr),
		.di(mem_d),
		.doo(mem_q)
	);

	// assign DAT_O outputs
	assign dat0_o = mem_q;
	assign dat1_o = mem_q;

	// generate ack outputs
	assign ack0_o = ( (sel0 && we0_i) || ack0 );
	assign ack1_o = ( (sel1 && we1_i) || ack1 );
endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant enhanced VGA/LCD Core            ////
////  Hardware Cursor Color Registers                            ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2002 Richard Herveille                        ////
////                    richard@asics.ws                         ////
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
//  $Id: vga_cur_cregs.v,v 1.3 2003/05/07 09:48:54 rherveille Exp $
//
//  $Date: 2003/05/07 09:48:54 $
//  $Revision: 1.3 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_cur_cregs.v,v $
//               Revision 1.3  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.2  2002/03/04 16:05:52  rherveille
//               Added hardware cursor support to wishbone master.
//               Added provision to turn-off 3D cursors.
//               Fixed some minor bugs.
//
//               Revision 1.1  2002/03/04 11:01:59  rherveille
//               Added 64x64pixels 4bpp hardware cursor support.
//
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on

module vga_cur_cregs (
	clk_i, rst_i, arst_i,
	hsel_i, hadr_i, hwe_i, hdat_i, hdat_o, hack_o,
	cadr_i, cdat_o
	);

	//
	// inputs & outputs
	//

	// wishbone signals
	input         clk_i;         // master clock input
	input         rst_i;         // synchronous active high reset
	input         arst_i;        // asynchronous active low reset

	// host interface
	input         hsel_i;        // host select input
	input  [ 2:0] hadr_i;        // host address input
	input         hwe_i;         // host write enable input
	input  [31:0] hdat_i;        // host data in
	output [31:0] hdat_o;        // host data out
	output        hack_o;        // host acknowledge out

	reg [31:0] hdat_o;
	reg        hack_o;
	
	// cursor processor interface
	input  [ 3:0] cadr_i;        // cursor address in
	output [15:0] cdat_o;        // cursor data out

	reg [15:0] cdat_o;


	//
	// variable declarations
	//
	reg  [31:0] cregs [7:0];  // color registers
	wire [31:0] temp_cdat;

	//
	// module body
	//


	////////////////////////////
	// generate host interface

	// write section
	always@(posedge clk_i)
		if (hsel_i & hwe_i)
			cregs[hadr_i] <= hdat_i;

	// read section
	always@(posedge clk_i)
		hdat_o <= cregs[hadr_i];

	// acknowledge section
	always@(posedge clk_i)
		hack_o <= hsel_i & !hack_o;


	//////////////////////////////
	// generate cursor interface

	// read section
	assign temp_cdat = cregs[cadr_i[3:1]];

	always@(posedge clk_i)
		cdat_o <= cadr_i[0] ? temp_cdat[31:16] : temp_cdat[15:0];

endmodule

/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant enhanced VGA/LCD Core            ////
////  Hardware Cursor Processor                                  ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2002 Richard Herveille                        ////
////                    richard@asics.ws                         ////
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
//  $Id: vga_curproc.v,v 1.4 2003/05/07 09:48:54 rherveille Exp $
//
//  $Date: 2003/05/07 09:48:54 $
//  $Revision: 1.4 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_curproc.v,v $
//               Revision 1.4  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.3  2002/03/04 16:05:52  rherveille
//               Added hardware cursor support to wishbone master.
//               Added provision to turn-off 3D cursors.
//               Fixed some minor bugs.
//
//               Revision 1.2  2002/03/04 11:01:59  rherveille
//               Added 64x64pixels 4bpp hardware cursor support.
//
//               Revision 1.1  2002/02/16 10:40:00  rherveille
//               Some minor bug-fixes.
//               Changed vga_ssel into vga_curproc (cursor processor).
//
//               Revision 1.1  2002/02/07 05:42:10  rherveille
//               Fixed some bugs discovered by modified testbench
//               Removed / Changed some strange logic constructions
//               Started work on hardware cursor support (not finished yet)
//               Changed top-level name to vga_enh_top.v
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on

module vga_curproc (clk, rst_i, Thgate, Tvgate, idat, idat_wreq, 
	cursor_xy, cursor_en, cursor_res, 
	cursor_wadr, cursor_wdat, cursor_we,
	cc_adr_o, cc_dat_i,
	rgb_fifo_wreq, rgb);

	//
	// inputs & outputs
	//

	// wishbone signals
	input         clk;           // master clock input
	input         rst_i;         // synchronous active high reset

	// image size
	input [15:0] Thgate, Tvgate; // horizontal/vertical gate
	// image data
	input [23:0] idat;           // image data input
	input        idat_wreq;      // image data write request

	// cursor data
	input [31:0] cursor_xy;      // cursor (x,y)
	input        cursor_en;      // cursor enable (on/off)
	input        cursor_res;     // cursor resolution (32x32 or 64x64 pixels)
	input [ 8:0] cursor_wadr;    // cursor buffer write address
	input [31:0] cursor_wdat;    // cursor buffer write data
	input        cursor_we;      // cursor buffer write enable

	// color registers interface
	output [ 3:0] cc_adr_o;      // cursor color registers address
	reg  [ 3:0] cc_adr_o;    
	input  [15:0] cc_dat_i;      // cursor color registers data

	// rgb-fifo connections
	output        rgb_fifo_wreq; // rgb-out write request
	reg        rgb_fifo_wreq;
	output [23:0] rgb;           // rgb data output
	reg [23:0] rgb;

	//
	// variable declarations
	//
	reg         dcursor_en, ddcursor_en, dddcursor_en;
	reg  [15:0] xcnt, ycnt;
	wire        xdone, ydone;
	wire [15:0] cursor_x, cursor_y;
	wire        cursor_isalpha;
	reg  [15:0] cdat, dcdat;
	wire [ 7:0] cursor_r, cursor_g, cursor_b, cursor_alpha;
	reg         inbox_x, inbox_y;
	wire        inbox;
	reg         dinbox, ddinbox, dddinbox;

	reg  [23:0] didat, ddidat, dddidat;
	reg         didat_wreq, ddidat_wreq;
	wire [31:0] cbuf_q;
	reg  [11:0] cbuf_ra;
	reg  [ 2:0] dcbuf_ra;
	wire [ 8:0] cbuf_a;

	reg         store1, store2;

	//
	// module body
	//

	//
	// generate x-y counters
	always@(posedge clk)
		if(rst_i || xdone)
			xcnt <= 16'h0;
		else if (idat_wreq)
			xcnt <= xcnt + 16'h1;

	assign xdone = (xcnt == Thgate) && idat_wreq;

	always@(posedge clk)
		if(rst_i || ydone)
			ycnt <= 16'h0;
		else if (xdone)
			ycnt <= ycnt + 16'h1;

	assign ydone = (ycnt == Tvgate) && xdone;


	// decode cursor (x,y)
	assign cursor_x = cursor_xy[15: 0];
	assign cursor_y = cursor_xy[31:16];

	//
	// generate inbox signals
	always@(posedge clk)
		begin
			inbox_x <= (xcnt >= cursor_x) && (xcnt < (cursor_x + (cursor_res ? 16'h7f : 16'h1f) ));
			inbox_y <= (ycnt >= cursor_y) && (ycnt < (cursor_y + (cursor_res ? 16'h7f : 16'h1f) ));
		end

	assign inbox = inbox_x && inbox_y;

	always@(posedge clk)
		dinbox <= inbox;

	always@(posedge clk)
		if (didat_wreq)
			ddinbox <= dinbox;

	always@(posedge clk)
		dddinbox <= ddinbox;

	//
	// generate cursor buffer address counter
	always@(posedge clk)
		if (!cursor_en || ydone)
			cbuf_ra <= 12'h0;
		else if (inbox && idat_wreq)
			cbuf_ra <= cbuf_ra +12'h1;

	always@(posedge clk)
		dcbuf_ra <= cbuf_ra[2:0];

	assign cbuf_a = cursor_we ? cursor_wadr : cursor_res ? cbuf_ra[11:3] : cbuf_ra[9:1];

	// hookup local cursor memory (generic synchronous single port memory)
	// cursor memory should never be written to/read from at the same time
	generic_spram_9_32 cbuf(
		.clk(clk),
		.rst(1'b0),       // no reset
		.ce(1'b1),        // always enable memory
		.we(cursor_we),
		.oe(1'b1),        // always output data
		.addr(cbuf_a),
		.di(cursor_wdat),
		.doo(cbuf_q)
	);

	//
	// decode cursor data for 32x32x16bpp mode
	always@(posedge clk)
		if (didat_wreq)
			cdat <= dcbuf_ra[0] ? cbuf_q[31:16] : cbuf_q[15:0];

	always@(posedge clk)
		dcdat <= cdat;

	//
	// decode cursor data for 64x64x4bpp mode

	// generate cursor-color address
	always@(posedge clk)
		if (didat_wreq)
			case (dcbuf_ra)
				3'b000: cc_adr_o <= cbuf_q[ 3: 0];
				3'b001: cc_adr_o <= cbuf_q[ 7: 4];
				3'b010: cc_adr_o <= cbuf_q[11: 8];
				3'b011: cc_adr_o <= cbuf_q[15:12];
				3'b100: cc_adr_o <= cbuf_q[19:16];
				3'b101: cc_adr_o <= cbuf_q[23:20];
				3'b110: cc_adr_o <= cbuf_q[27:24];
				3'b111: cc_adr_o <= cbuf_q[31:28];
			endcase

	//
	// generate cursor colors
	assign cursor_isalpha =  cursor_res ? cc_dat_i[15]    : dcdat[15];
	assign cursor_alpha   =  cursor_res ? cc_dat_i[7:0]   : dcdat[7:0];
	assign cursor_r       = {cursor_res ? cc_dat_i[14:10] : dcdat[14:10], 3'h0};
	assign cursor_g       = {cursor_res ? cc_dat_i[ 9: 5] : dcdat[ 9: 5], 3'h0};
	assign cursor_b       = {cursor_res ? cc_dat_i[ 4: 0] : dcdat[ 4: 0], 3'h0};

	//
	// delay image data
	always@(posedge clk)
		didat <= idat;

	always@(posedge clk)
		if (didat_wreq)
			ddidat <= didat;

	always@(posedge clk)
		dddidat <= ddidat;

	always@(posedge clk)
		begin
			didat_wreq  <= idat_wreq;
			ddidat_wreq <= didat_wreq;
		end

	//
	// generate selection unit
	always@(posedge clk)
		dcursor_en <= cursor_en;

	always@(posedge clk)
		if (didat_wreq)
			ddcursor_en <= dcursor_en;

	always@(posedge clk)
		dddcursor_en <= ddcursor_en;

	// Alpha blending:
	// rgb = (rgb1 * alhpa1) + (rgb2 * alpha2)
	// We generate an alpha mixer (alpha1 + alpha2 = 1)
	// rgb = (alpha1)(rgb1) + (1-alpha1)(rgb2)
	// We always mix to black (rgb2 = 0)
	// rgb = (alpha1)(rgb1)
	always@(posedge clk)
		if (ddidat_wreq)
			if (!dddcursor_en || !dddinbox)
				rgb <= dddidat;
			else if (cursor_isalpha)
				


					rgb <= dddidat;
				
			else
				rgb <= {cursor_r, cursor_g, cursor_b};

	//
	// generate write request signal
	always@(posedge clk)
		if (rst_i)
		begin
			store1 <= 1'b0;
			store2 <= 1'b0;
		end
		else
		begin
			store1 <=  didat_wreq           | store1;
			store2 <= (didat_wreq & store1) | store2;
		end

	// skip 2 idat_wreq signal, to keep in pace with rgb_fifo_full signal
	always@(posedge clk)
		rgb_fifo_wreq <= ddidat_wreq & store2;

endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant enhanced VGA/LCD Core            ////
////  Defines file                                               ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001, 2002 Richard Herveille                  ////
////                          richard@asics.ws                   ////
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
//  $Id: vga_defines.v,v 1.6 2003/08/01 11:46:38 rherveille Exp $
//
//  $Date: 2003/08/01 11:46:38 $
//  $Revision: 1.6 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_defines.v,v $
//               Revision 1.6  2003/08/01 11:46:38  rherveille
//               1) Rewrote vga_fifo_dc. It now uses gray codes and a more elaborate anti-metastability scheme.
//               2) Changed top level and pixel generator to reflect changes in the fifo.
//               3) Changed a bug in vga_fifo.
//               4) Changed pixel generator and wishbone master to reflect changes.
//
//               Revision 1.5  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.4  2002/02/07 05:42:10  rherveille
//               Fixed some bugs discovered by modified testbench
//               Removed / Changed some strange logic constructions
//               Started work on hardware cursor support (not finished yet)
//               Changed top-level name to vga_enh_top.v
//


////////////////////////
//
// Global settings
//

//
// define memory vendor
// for FPGA implementations use `define VENDOR_FPGA



//
// enable / disable 12bit DVI output
// (for use with external DVI transmitters)
//`define VGA_12BIT_DVI


////////////////////////
//
// Hardware Cursors
//

//
// enable / disable hardware cursors
//
//`define VGA_HWC0
//`define VGA_HWC1


//
// enable / disabled 3D support for hardware cursors
//
//`define VGA_HWC_3D

/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant Enhanced VGA/LCD Core            ////
////  Top Level                                                  ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001,2002 Richard Herveille                   ////
////                         richard@asics.ws                    ////
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
//  $Id: vga_enh_top.v,v 1.6 2003/08/01 11:46:38 rherveille Exp $
//
//  $Date: 2003/08/01 11:46:38 $
//  $Revision: 1.6 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_enh_top.v,v $
//               Revision 1.6  2003/08/01 11:46:38  rherveille
//               1) Rewrote vga_fifo_dc. It now uses gray codes and a more elaborate anti-metastability scheme.
//               2) Changed top level and pixel generator to reflect changes in the fifo.
//               3) Changed a bug in vga_fifo.
//               4) Changed pixel generator and wishbone master to reflect changes.
//
//               Revision 1.5  2003/07/03 15:09:06  rherveille
//               Removed 'or negedge arst' from sluint/luint sensitivity list
//
//               Revision 1.4  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.3  2003/03/18 21:45:48  rherveille
//               Added WISHBONE revB.3 Registered Feedback Cycles support
//
//               Revision 1.2  2002/03/04 11:01:59  rherveille
//               Added 64x64pixels 4bpp hardware cursor support.
//
//               Revision 1.1  2002/02/07 05:42:10  rherveille
//               Fixed some bugs discovered by modified testbench
//               Removed / Changed some strange logic constructions
//               Started work on hardware cursor support (not finished yet)
//               Changed top-level name to vga_enh_top.v
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant enhanced VGA/LCD Core            ////
////  Defines file                                               ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001, 2002 Richard Herveille                  ////
////                          richard@asics.ws                   ////
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
//  $Id: vga_defines.v,v 1.6 2003/08/01 11:46:38 rherveille Exp $
//
//  $Date: 2003/08/01 11:46:38 $
//  $Revision: 1.6 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_defines.v,v $
//               Revision 1.6  2003/08/01 11:46:38  rherveille
//               1) Rewrote vga_fifo_dc. It now uses gray codes and a more elaborate anti-metastability scheme.
//               2) Changed top level and pixel generator to reflect changes in the fifo.
//               3) Changed a bug in vga_fifo.
//               4) Changed pixel generator and wishbone master to reflect changes.
//
//               Revision 1.5  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.4  2002/02/07 05:42:10  rherveille
//               Fixed some bugs discovered by modified testbench
//               Removed / Changed some strange logic constructions
//               Started work on hardware cursor support (not finished yet)
//               Changed top-level name to vga_enh_top.v
//


////////////////////////
//
// Global settings
//

//
// define memory vendor
// for FPGA implementations use `define VENDOR_FPGA



//
// enable / disable 12bit DVI output
// (for use with external DVI transmitters)
//`define VGA_12BIT_DVI


////////////////////////
//
// Hardware Cursors
//

//
// enable / disable hardware cursors
//
//`define VGA_HWC0
//`define VGA_HWC1


//
// enable / disabled 3D support for hardware cursors
//
//`define VGA_HWC_3D


module vga_enh_top (
	wb_clk_i, wb_rst_i, rst_i, wb_inta_o,
	wbs_adr_i, wbs_dat_i, wbs_dat_o, wbs_sel_i, wbs_we_i, wbs_stb_i, wbs_cyc_i, wbs_ack_o, wbs_rty_o, wbs_err_o,
	wbm_adr_o, wbm_dat_i, wbm_cti_o, wbm_bte_o, wbm_sel_o, wbm_we_o, wbm_stb_o, wbm_cyc_o, wbm_ack_i, wbm_err_i,
	clk_p_i,



	clk_p_o, hsync_pad_o, vsync_pad_o, csync_pad_o, blank_pad_o, r_pad_o, g_pad_o, b_pad_o
	);

	//
	// parameters
	//
	//
	// inputs & outputs
	//

	// syscon interface
	input  wb_clk_i;             // wishbone clock input
	input  wb_rst_i;             // synchronous active high reset
	input  rst_i;                // asynchronous reset
	output wb_inta_o;            // interrupt request output

	// slave signals
	input  [11:0] wbs_adr_i;     // addressbus input (only 32bit databus accesses supported)
	input  [31:0] wbs_dat_i;     // Slave databus output
	output [31:0] wbs_dat_o;     // Slave databus input
	input  [ 3:0] wbs_sel_i;     // byte select inputs
	input         wbs_we_i;      // write enabel input
	input         wbs_stb_i;     // strobe/select input
	input         wbs_cyc_i;     // valid bus cycle input
	output        wbs_ack_o;     // bus cycle acknowledge output
	output        wbs_rty_o;     // busy cycle retry output
	output        wbs_err_o;     // bus cycle error output

	// master signals
	output [31:0] wbm_adr_o;     // addressbus output
	input  [31:0] wbm_dat_i;     // Master databus input
	output [ 3:0] wbm_sel_o;     // byte select outputs
	output        wbm_we_o;      // write enable output
	output        wbm_stb_o;     // strobe output
	output        wbm_cyc_o;     // valid bus cycle output
	output [ 2:0] wbm_cti_o;     // cycle type identifier
	output [ 1:0] wbm_bte_o;     // burst type extensions
	input         wbm_ack_i;     // bus cycle acknowledge input
	input         wbm_err_i;     // bus cycle error input

	// VGA signals
	input         clk_p_i;                   // pixel clock
	                                         // in DVI mode this is 2x as high (!!)

	








	output        clk_p_o;                   // VGA pixel clock output
	output        hsync_pad_o;               // horizontal sync
	output        vsync_pad_o;               // vertical sync
	output        csync_pad_o;               // composite sync
	output        blank_pad_o;               // blanking signal
	output [ 7:0] r_pad_o, g_pad_o, b_pad_o; // RGB color signals

	//
	// variable declarations
	//

	// programable asynchronous reset
	wire arst = rst_i ^ 0;

	// from wb_slave
	wire         ctrl_bl, ctrl_csl, ctrl_vsl, ctrl_hsl, ctrl_pc, ctrl_cbsw, ctrl_vbsw, ctrl_ven;
	wire [ 1: 0] ctrl_cd, ctrl_vbl, ctrl_dvi_odf;
	wire [ 7: 0] Thsync, Thgdel, Tvsync, Tvgdel;
	wire [15: 0] Thgate, Thlen, Tvgate, Tvlen;
	wire [31: 2] VBARa, VBARb;

	wire [ 8: 0] cursor_adr;
	wire [31: 0] cursor0_xy, cursor1_xy;
	wire         cursor0_en, cursor1_en;
	wire [31:11] cursor0_ba, cursor1_ba;
	wire         cursor0_ld, cursor1_ld;
	wire         cursor0_res, cursor1_res;
	wire [15: 0] cc0_dat_o, cc1_dat_o;

	// to wb_slave
	wire stat_avmp, stat_acmp, vmem_swint, clut_swint, hint, vint, sint;
	wire wmb_busy;
	reg luint;
	wire [ 3: 0] cc0_adr_i, cc1_adr_i;

	// pixel generator
	wire        fb_data_fifo_rreq, fb_data_fifo_empty;
	wire [31:0] fb_data_fifo_q;
	wire        ImDoneFifoQ;

	// line fifo connections
	wire        line_fifo_wreq, line_fifo_rreq, line_fifo_empty_rd;
	wire [23:0] line_fifo_d, line_fifo_q;

	// clut connections
	wire        ext_clut_req, ext_clut_ack;
	wire [23:0] ext_clut_q;
	wire        cp_clut_req, cp_clut_ack;
	wire [ 8:0] cp_clut_adr;
	wire [23:0] cp_clut_q;

	//
	// Module body
	//

	// hookup wishbone slave
	vga_wb_slave wbs (
		// wishbone interface
		.clk_i       ( wb_clk_i        ),
		.rst_i       ( wb_rst_i        ),
		.arst_i      ( arst            ),
		.adr_i       ( wbs_adr_i[11:2] ),
		.dat_i       ( wbs_dat_i       ),
		.dat_o       ( wbs_dat_o       ),
		.sel_i       ( wbs_sel_i       ),
		.we_i        ( wbs_we_i        ),
		.stb_i       ( wbs_stb_i       ),
		.cyc_i       ( wbs_cyc_i       ),
		.ack_o       ( wbs_ack_o       ),
		.rty_o       ( wbs_rty_o       ),
		.err_o       ( wbs_err_o       ),
		.inta_o      ( wb_inta_o       ),

		// internal connections
		.wbm_busy    ( wbm_busy     ), // Data transfer in progress
		.dvi_odf     ( ctrl_dvi_odf ), // DVI output data format
		.bl          ( ctrl_bl      ), // blank polarization level
		.csl         ( ctrl_csl     ), // csync polarization level
		.vsl         ( ctrl_vsl     ), // vsync polarization level
		.hsl         ( ctrl_hsl     ), // hsync polarization level
		.pc          ( ctrl_pc      ), // pseudo-color mode (only for 8bpp)
		.cd          ( ctrl_cd      ), // color depth
		.vbl         ( ctrl_vbl     ), // video memory burst length
		.cbsw        ( ctrl_cbsw    ), // color lookup table bank switch enable
		.vbsw        ( ctrl_vbsw    ), // video bank switch enable
		.ven         ( ctrl_ven     ), // video enable
		.acmp        ( stat_acmp    ), // active color lookup table page
		.avmp        ( stat_avmp    ), // active video memory page
		.cursor0_res ( cursor0_res  ), // cursor0 resolution
		.cursor0_en  ( cursor0_en   ), // cursor0 enable
		.cursor0_xy  ( cursor0_xy   ), // cursor0 (x,y)
		.cursor0_ba  ( cursor0_ba   ), // curso0 video memory base address
		.cursor0_ld  ( cursor0_ld   ), // reload curso0 from video memory
 		.cc0_adr_i   ( cc0_adr_i    ), // cursor0 color registers address
		.cc0_dat_o   ( cc0_dat_o    ), // cursor0 color registers data
		.cursor1_res ( cursor1_res  ), // cursor1 resolution
		.cursor1_en  ( cursor1_en   ), // cursor1 enable
		.cursor1_xy  ( cursor1_xy   ), // cursor1 (x,y)
		.cursor1_ba  ( cursor1_ba   ), // cursor1 video memory base address
		.cursor1_ld  ( cursor1_ld   ), // reload cursor1 from video memory
 		.cc1_adr_i   ( cc1_adr_i    ), // cursor1 color registers address
		.cc1_dat_o   ( cc1_dat_o    ), // cursor1 color registers data
		.vbsint_in   ( vmem_swint   ), // video memory bank switch interrupt
		.cbsint_in   ( clut_swint   ), // clut memory bank switch interrupt
		.hint_in     ( hint         ), // horizontal interrupt
		.vint_in     ( vint         ), // vertical interrupt
		.luint_in    ( luint        ), // line fifo underrun interrupt
		.sint_in     ( sint         ), // system-error interrupt
		.Thsync      ( Thsync       ),
		.Thgdel      ( Thgdel       ),
		.Thgate      ( Thgate       ),
		.Thlen       ( Thlen        ),
		.Tvsync      ( Tvsync       ),
		.Tvgdel      ( Tvgdel       ),
		.Tvgate      ( Tvgate       ),
		.Tvlen       ( Tvlen        ),
		.VBARa       ( VBARa        ),
		.VBARb       ( VBARb        ),
		.clut_acc    ( ext_clut_req ),
		.clut_ack    ( ext_clut_ack ),
		.clut_q      ( ext_clut_q   )
	);

	// hookup wishbone master
	vga_wb_master wbm (
		// wishbone interface
		.clk_i  ( wb_clk_i  ),
		.rst_i  ( wb_rst_i  ),
		.nrst_i ( arst      ),
		.cyc_o  ( wbm_cyc_o ),
		.stb_o  ( wbm_stb_o ),
		.cti_o  ( wbm_cti_o ),
		.bte_o  ( wbm_bte_o ),
		.we_o   ( wbm_we_o  ),
		.adr_o  ( wbm_adr_o ),
		.sel_o  ( wbm_sel_o ),
		.ack_i  ( wbm_ack_i ),
		.err_i  ( wbm_err_i ),
		.dat_i  ( wbm_dat_i ),

		// internal connections
		.sint        (sint         ),
		.ctrl_ven    (ctrl_ven     ),
		.ctrl_cd     (ctrl_cd      ),
		.ctrl_vbl    (ctrl_vbl     ),
		.ctrl_vbsw   (ctrl_vbsw    ),
		.busy        (wbm_busy     ),
		.VBAa        (VBARa        ),
		.VBAb        (VBARb        ),
		.Thgate      (Thgate       ),
		.Tvgate      (Tvgate       ),
		.stat_avmp   (stat_avmp    ),
		.vmem_switch (vmem_swint   ),
		.ImDoneFifoQ ( ImDoneFifoQ ),

		.cursor_adr  ( cursor_adr  ),
		.cursor0_ba  ( cursor0_ba  ),    // curso0 video memory base address
		.cursor0_ld  ( cursor0_ld  ),    // reload curso0 from video memory
		.cursor1_ba  ( cursor1_ba  ),    // cursor1 video memory base address
		.cursor1_ld  ( cursor1_ld  ),    // reload cursor1 from video memory

		.fb_data_fifo_rreq  ( fb_data_fifo_rreq  ),
		.fb_data_fifo_q     ( fb_data_fifo_q     ),
		.fb_data_fifo_empty ( fb_data_fifo_empty )
	);

	// hookup CLUT <cycle shared memory>
	vga_csm_pb clut_mem(
		.clk_i(wb_clk_i),

		// color processor access
		.req0_i(cp_clut_req),
		.ack0_o(cp_clut_ack),
		.adr0_i(cp_clut_adr),
		.dat0_i(24'h0),
		.dat0_o(cp_clut_q),
		.we0_i(1'b0), // no writes

		// external access
		.req1_i(ext_clut_req),
		.ack1_o(ext_clut_ack),
		.adr1_i(wbs_adr_i[10:2]),
		.dat1_i(wbs_dat_i[23:0]),
		.dat1_o(ext_clut_q),
		.we1_i(wbs_we_i)
	);

	// hookup pixel and video timing generator
	vga_pgen pixel_generator (
		.clk_i              ( wb_clk_i           ),
		.ctrl_ven           ( ctrl_ven           ),
		.ctrl_HSyncL        ( ctrl_hsl           ),
		.Thsync             ( Thsync             ),
		.Thgdel             ( Thgdel             ),
		.Thgate             ( Thgate             ),
		.Thlen              ( Thlen              ),
		.ctrl_VSyncL        ( ctrl_vsl           ),
		.Tvsync             ( Tvsync             ),
		.Tvgdel             ( Tvgdel             ),
		.Tvgate             ( Tvgate             ),
		.Tvlen              ( Tvlen              ),
		.ctrl_CSyncL        ( ctrl_csl           ),
		.ctrl_BlankL        ( ctrl_bl            ),
		.eoh                ( hint               ),
		.eov                ( vint               ),

		// frame buffer data (from wbm)
		.fb_data_fifo_rreq  ( fb_data_fifo_rreq  ),
		.fb_data_fifo_q     ( fb_data_fifo_q     ),
		.fb_data_fifo_empty ( fb_data_fifo_empty ),
		.ImDoneFifoQ        ( ImDoneFifoQ        ),

		// clut memory signals
		.stat_acmp          ( stat_acmp          ),
		.clut_req           ( cp_clut_req        ),
		.clut_ack           ( cp_clut_ack        ),
		.clut_adr           ( cp_clut_adr        ),
		.clut_q             ( cp_clut_q          ),
		.ctrl_cbsw          ( ctrl_cbsw          ),
		.clut_switch        ( clut_swint         ),

		.cursor_adr         ( cursor_adr         ),  // cursor data address (from wbm)
		.cursor0_en         ( cursor0_en         ),  // cursor0 enable
		.cursor0_res        ( cursor0_res        ),  // cursor0 resolution
		.cursor0_xy         ( cursor0_xy         ),  // cursor0 (x,y)
		.cc0_adr_o          ( cc0_adr_i          ),  // cursor0 color registers address
		.cc0_dat_i          ( cc0_dat_o          ),  // cursor0 color registers data
		.cursor1_en         ( cursor1_en         ),  // cursor1 enable
		.cursor1_res        ( cursor1_res        ),  // cursor1 resolution
		.cursor1_xy         ( cursor1_xy         ),  // cursor1 (x,y)
		.cc1_adr_o          ( cc1_adr_i          ),  // cursor1 color registers address
		.cc1_dat_i          ( cc1_dat_o          ),  // cursor1 color registers data

		.ctrl_dvi_odf       ( ctrl_dvi_odf       ),
		.ctrl_cd            ( ctrl_cd            ),
		.ctrl_pc            ( ctrl_pc            ),

		// line fifo memory signals
		.line_fifo_wreq     ( line_fifo_wreq     ),
		.line_fifo_d        ( line_fifo_d        ),
		.line_fifo_full     ( line_fifo_full_wr  ),
		.line_fifo_rreq     ( line_fifo_rreq     ),
		.line_fifo_q        ( line_fifo_q        ),

		.pclk_i             ( clk_p_i            ),
	







		.pclk_o             ( clk_p_o            ),
		.hsync_o            ( hsync_pad_o        ),
		.vsync_o            ( vsync_pad_o        ),
		.csync_o            ( csync_pad_o        ),
		.blank_o            ( blank_pad_o        ),
		.r_o                ( r_pad_o            ),
		.g_o                ( g_pad_o            ),
		.b_o                ( b_pad_o            )

	);

	// hookup line-fifo
	wire ctrl_ven_not = ~ctrl_ven;
	vga_fifo_dc line_fifo (
		.rclk  ( clk_p_i            ),
		.wclk  ( wb_clk_i           ),
		.rclr  ( 1'b0               ),
		.wclr  ( ctrl_ven_not       ),
		.wreq  ( line_fifo_wreq     ),
		.d     ( line_fifo_d        ),
		.rreq  ( line_fifo_rreq     ),
		.q     ( line_fifo_q        ),
		.empty ( line_fifo_empty_rd ),
		.full  ( line_fifo_full_wr  )
	);

	// generate interrupt signal when reading line-fifo while it is empty (line-fifo under-run interrupt)
	reg luint_pclk, sluint;

	always @(posedge clk_p_i)
	  luint_pclk <= line_fifo_rreq & line_fifo_empty_rd;

	always @(posedge wb_clk_i)
	  if (!ctrl_ven)
	    begin
	        sluint <= 1'b0;
	        luint  <= 1'b0;
	    end
	  else
	    begin
	        sluint <= luint_pclk;  // resample at wb_clk_i clock
	        luint  <= sluint;      // sample again, reduce metastability risk
	    end

endmodule





/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant VGA/LCD Core; Dual Clocked Fifo  ////
////                                                             ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001 Richard Herveille                        ////
////                    richard@asics.ws                         ////
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
//  $Id: vga_fifo_dc.v,v 1.6 2003/08/01 11:46:38 rherveille Exp $
//
//  $Date: 2003/08/01 11:46:38 $
//  $Revision: 1.6 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_fifo_dc.v,v $
//               Revision 1.6  2003/08/01 11:46:38  rherveille
//               1) Rewrote vga_fifo_dc. It now uses gray codes and a more elaborate anti-metastability scheme.
//               2) Changed top level and pixel generator to reflect changes in the fifo.
//               3) Changed a bug in vga_fifo.
//               4) Changed pixel generator and wishbone master to reflect changes.
//
//               Revision 1.5  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.4  2002/01/28 03:47:16  rherveille
//               Changed counter-library.
//               Changed vga-core.
//               Added 32bpp mode.
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on


/*

  Dual clock FIFO.

  Uses gray codes to move from one clock domain to the other.

  Flags are synchronous to the related clock domain;
  - empty: synchronous to read_clock
  - full : synchronous to write_clock

  CLR is available in both clock-domains.
  Asserting any clr signal resets the entire FIFO.
  When crossing clock domains the clears are synchronized.
  Therefore one clock domain can enter or leave the reset state before the other.
*/


module vga_fifo_dc (rclk, wclk, rclr, wclr, wreq, d, rreq, q, empty, full);

	// inputs & outputs
	input rclk;             // read clock
	input wclk;             // write clock
	input rclr;             // active high synchronous clear, synchronous to read clock
	input wclr;             // active high synchronous clear, synchronous to write clock
	input wreq;             // write request
	input [24 -1:0] d;  // data input
	input rreq;             // read request
	output [24 -1:0] q; // data output

	output reg empty;           // FIFO is empty, synchronous to read clock
	// reg empty;
	output reg full;            // FIFO is full, synchronous to write clock
	// reg full;

	// variable declarations
	reg rrst, wrst, srclr, ssrclr, swclr, sswclr;
	reg [7 -1:0] rptr, wptr, rptr_gray, wptr_gray;

	//
	// module body
	//


	function [7:1] bin2gray;
		input [7:1] bin;
		integer n;
	begin
		for (n=1; n<7; n=n+1)
			bin2gray[n] = bin[n+1] ^ bin[n];

		bin2gray[7] = bin[7];
	end
	endfunction

	function [7:1] gray2bin;
		input [7:1] gray;
	begin
		// same logic as bin2gray
		gray2bin = bin2gray(gray);
	end
	endfunction

	//
	// Pointers
	//

	// generate synchronized resets
	always @(posedge rclk)
	begin
	    swclr  <= wclr;
	    sswclr <= swclr;
	    rrst   <= rclr | sswclr;
	end

	always @(posedge wclk)
	begin
	    srclr  <= rclr;
	    ssrclr <= srclr;
	    wrst   <= wclr | ssrclr;
	end


	// read pointer
	always @(posedge rclk)
	  if (rrst) begin
	      rptr      <= 0;
	      rptr_gray <= 0;
	  end else if (rreq) begin
	      rptr      <= rptr +1'h1;
	      rptr_gray <= bin2gray(rptr +1'h1);
	  end

	// write pointer
	always @(posedge wclk)
	  if (wrst) begin
	      wptr      <= 0;
	      wptr_gray <= 0;
	  end else if (wreq) begin
	      wptr      <= wptr +1'h1;
	      wptr_gray <= bin2gray(wptr +1'h1);
	  end

	//
	// status flags
	//
	reg [7-1:0] srptr_gray, ssrptr_gray;
	reg [7-1:0] swptr_gray, sswptr_gray;

	// from one clock domain, to the other
	always @(posedge rclk)
	begin
	    swptr_gray  <= wptr_gray;
	    sswptr_gray <= swptr_gray;
	end

	always @(posedge wclk)
	begin
	    srptr_gray  <= rptr_gray;
	    ssrptr_gray <= srptr_gray;
	end

	// EMPTY
	// WC: wptr did not increase
	always @(posedge rclk)
	  if (rrst)
	    empty <= 1'b1;
	  else if (rreq)
	    empty <= bin2gray(rptr +1'h1) == sswptr_gray;
	  else
	    empty <= empty & (rptr_gray == sswptr_gray);


	// FULL
	// WC: rptr did not increase
	always @(posedge wclk)
	  if (wrst)
	    full <= 1'b0;
	  else if (wreq)
	    full <= bin2gray(wptr +2'h2) == ssrptr_gray;
	  else
	    full <= full & (bin2gray(wptr + 2'h1) == ssrptr_gray);


	// hookup generic dual ported memory
	generic_dpram fifo_dc_mem(
		.rclk(rclk),
		.rrst(1'b0),
		.rce(1'b1),
		.oe(1'b1),
		.raddr(rptr),
		.doo(q),
		.wclk(wclk),
		.wrst(1'b0),
		.wce(1'b1),
		.we(wreq),
		.waddr(wptr),
		.di(d)
	);

endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  generic FIFO, uses LFSRs for read/write pointers           ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001, 2002 Richard Herveille                  ////
////                          richard@asics.ws                   ////
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
//  $Id: vga_fifo.v,v 1.8 2003/08/01 11:46:38 rherveille Exp $
//
//  $Date: 2003/08/01 11:46:38 $
//  $Revision: 1.8 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_fifo.v,v $
//               Revision 1.8  2003/08/01 11:46:38  rherveille
//               1) Rewrote vga_fifo_dc. It now uses gray codes and a more elaborate anti-metastability scheme.
//               2) Changed top level and pixel generator to reflect changes in the fifo.
//               3) Changed a bug in vga_fifo.
//               4) Changed pixel generator and wishbone master to reflect changes.
//
//               Revision 1.7  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.6  2002/02/07 05:42:10  rherveille
//               Fixed some bugs discovered by modified testbench
//               Removed / Changed some strange logic constructions
//               Started work on hardware cursor support (not finished yet)
//               Changed top-level name to vga_enh_top.v
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on


// set FIFO_RW_CHECK to prevent writing to a full and reading from an empty FIFO
//`define FIFO_RW_CHECK

// Long Pseudo Random Generators can generate (N^2 -1) combinations. This means
// 1 FIFO entry is unavailable. This might be a problem, especially for small
// FIFOs. Setting VGA_FIFO_ALL_ENTRIES creates additional logic that ensures that
// all FIFO entries are used at the expense of some additional logic.

module vga_fifo_4_32
   (
    input                clk,
    input                aclr,
    input                sclr,
    input                wreq,
    input                rreq,
    input [32-1:0]         d,
    output [32-1:0]        q,
    output reg [4:0]        nword,
    output  reg             empty,
    output  reg             full,
    output               aempty,
    output               afull
    );

	// reg [4:0] nword;
	// reg        empty, full;

	//
	// Module body
	//
	reg  [4-1:0] rp, wp;
	wire [32-1:0] ramq;
	wire fwreq, frreq;























	function lsb;
	   input [4-1:0] q;
	   case (4)
	       2: lsb = ~q[2];
	       3: lsb = ~(q[3] ^ q[2]);
	       4: lsb = ~(q[4] ^ q[3]);
	       5: lsb = ~(q[5] ^ q[3]);
	       6: lsb = ~(q[6] ^ q[5]);
	       7: lsb = ~(q[7] ^ q[6]);
	       8: lsb = ~(q[8] ^ q[6] ^ q[5] ^ q[4]);
	       9: lsb = ~(q[9] ^ q[5]);
	      10: lsb = ~(q[10] ^ q[7]);
	      11: lsb = ~(q[11] ^ q[9]);
	      12: lsb = ~(q[12] ^ q[6] ^ q[4] ^ q[1]);
	      13: lsb = ~(q[13] ^ q[4] ^ q[3] ^ q[1]);
	      14: lsb = ~(q[14] ^ q[5] ^ q[3] ^ q[1]);
	      15: lsb = ~(q[15] ^ q[14]);
	      16: lsb = ~(q[16] ^ q[15] ^ q[13] ^ q[4]);
	   endcase
	endfunction






  assign fwreq = wreq;
  assign frreq = rreq;


	//
	// hookup read-pointer
	//
	always @(posedge clk or negedge aclr)
	  if (~aclr)      rp <= 0;
	  else if (sclr)  rp <= 0;
	  else if (frreq) rp <= {rp[4-1:1], lsb(rp)};

	//
	// hookup write-pointer
	//
	always @(posedge clk or negedge aclr)
	  if (~aclr)      wp <= 0;
	  else if (sclr)  wp <= 0;
	  else if (fwreq) wp <= {wp[4-1:1], lsb(wp)};


	//
	// hookup memory-block
	//
	reg [32-1:0] mem [(1<<4) -1:0];

	// memory array operations
	always @(posedge clk)
	  if (fwreq)
	    mem[wp] <= d;

	assign q = mem[rp];


	// generate full/empty signals
	assign aempty = (rp[4-1:1] == wp[4:2]) & (lsb(rp) == wp[1]) & frreq & ~fwreq;
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    empty <= 1'b1;
	  else if (sclr)
	    empty <= 1'b1;
	  else
	    empty <= aempty | (empty & (~fwreq + frreq));

	assign afull = (wp[4-1:1] == rp[4:2]) & (lsb(wp) == rp[1]) & fwreq & ~frreq;
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    full <= 1'b0;
	  else if (sclr)
	    full <= 1'b0;
	  else
	    full <= afull | ( full & (~frreq + fwreq) );

	// number of words in fifo
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    nword <= 0;
	  else if (sclr)
	    nword <= 0;
	  else
	    begin
	        if (wreq & !rreq)
	          nword <= nword +1;
	        else if (rreq & !wreq)
	          nword <= nword -1;
	    end

endmodule

module vga_fifo_4_24
   (
    input                clk,
    input                aclr,
    input                sclr,
    input                wreq,
    input                rreq,
    input [24-1:0]         d,
    output [24-1:0]        q,
    output reg [4:0]        nword,
    output reg              empty,
    output reg              full,
    output               aempty,
    output               afull
    );

	// reg [4:0] nword;
	// reg        empty, full;

	//
	// Module body
	//
	reg  [4-1:0] rp, wp;
	wire [24-1:0] ramq;
	wire fwreq, frreq;























	function lsb;
	   input [4-1:0] q;
	   case (4)
	       2: lsb = ~q[2];
	       3: lsb = ~(q[3] ^ q[2]);
	       4: lsb = ~(q[4] ^ q[3]);
	       5: lsb = ~(q[5] ^ q[3]);
	       6: lsb = ~(q[6] ^ q[5]);
	       7: lsb = ~(q[7] ^ q[6]);
	       8: lsb = ~(q[8] ^ q[6] ^ q[5] ^ q[4]);
	       9: lsb = ~(q[9] ^ q[5]);
	      10: lsb = ~(q[10] ^ q[7]);
	      11: lsb = ~(q[11] ^ q[9]);
	      12: lsb = ~(q[12] ^ q[6] ^ q[4] ^ q[1]);
	      13: lsb = ~(q[13] ^ q[4] ^ q[3] ^ q[1]);
	      14: lsb = ~(q[14] ^ q[5] ^ q[3] ^ q[1]);
	      15: lsb = ~(q[15] ^ q[14]);
	      16: lsb = ~(q[16] ^ q[15] ^ q[13] ^ q[4]);
	   endcase
	endfunction






  assign fwreq = wreq;
  assign frreq = rreq;


	//
	// hookup read-pointer
	//
	always @(posedge clk or negedge aclr)
	  if (~aclr)      rp <= 0;
	  else if (sclr)  rp <= 0;
	  else if (frreq) rp <= {rp[4-1:1], lsb(rp)};

	//
	// hookup write-pointer
	//
	always @(posedge clk or negedge aclr)
	  if (~aclr)      wp <= 0;
	  else if (sclr)  wp <= 0;
	  else if (fwreq) wp <= {wp[4-1:1], lsb(wp)};


	//
	// hookup memory-block
	//
	reg [24-1:0] mem [(1<<4) -1:0];

	// memory array operations
	always @(posedge clk)
	  if (fwreq)
	    mem[wp] <= d;

	assign q = mem[rp];


	// generate full/empty signals
	assign aempty = (rp[4-1:1] == wp[4:2]) & (lsb(rp) == wp[1]) & frreq & ~fwreq;
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    empty <= 1'b1;
	  else if (sclr)
	    empty <= 1'b1;
	  else
	    empty <= aempty | (empty & (~fwreq + frreq));

	assign afull = (wp[4-1:1] == rp[4:2]) & (lsb(wp) == rp[1]) & fwreq & ~frreq;
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    full <= 1'b0;
	  else if (sclr)
	    full <= 1'b0;
	  else
	    full <= afull | ( full & (~frreq + fwreq) );

	// number of words in fifo
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    nword <= 0;
	  else if (sclr)
	    nword <= 0;
	  else
	    begin
	        if (wreq & !rreq)
	          nword <= nword +1;
	        else if (rreq & !wreq)
	          nword <= nword -1;
	    end

endmodule

module vga_fifo_4_1
   (
    input                clk,
    input                aclr,
    input                sclr,
    input                wreq,
    input                rreq,
    input [1-1:0]         d,
    output [1-1:0]        q,
    output reg [4:0]        nword,
    output reg              empty,
    output reg              full,
    output               aempty,
    output               afull
    );

	// reg [4:0] nword;
	// reg        empty, full;

	//
	// Module body
	//
	reg  [4-1:0] rp, wp;
	wire [1-1:0] ramq;
	wire fwreq, frreq;























	function lsb;
	   input [4-1:0] q;
	   case (4)
	       2: lsb = ~q[2];
	       3: lsb = ~(q[3] ^ q[2]);
	       4: lsb = ~(q[4] ^ q[3]);
	       5: lsb = ~(q[5] ^ q[3]);
	       6: lsb = ~(q[6] ^ q[5]);
	       7: lsb = ~(q[7] ^ q[6]);
	       8: lsb = ~(q[8] ^ q[6] ^ q[5] ^ q[4]);
	       9: lsb = ~(q[9] ^ q[5]);
	      10: lsb = ~(q[10] ^ q[7]);
	      11: lsb = ~(q[11] ^ q[9]);
	      12: lsb = ~(q[12] ^ q[6] ^ q[4] ^ q[1]);
	      13: lsb = ~(q[13] ^ q[4] ^ q[3] ^ q[1]);
	      14: lsb = ~(q[14] ^ q[5] ^ q[3] ^ q[1]);
	      15: lsb = ~(q[15] ^ q[14]);
	      16: lsb = ~(q[16] ^ q[15] ^ q[13] ^ q[4]);
	   endcase
	endfunction






  assign fwreq = wreq;
  assign frreq = rreq;


	//
	// hookup read-pointer
	//
	always @(posedge clk or negedge aclr)
	  if (~aclr)      rp <= 0;
	  else if (sclr)  rp <= 0;
	  else if (frreq) rp <= {rp[4-1:1], lsb(rp)};

	//
	// hookup write-pointer
	//
	always @(posedge clk or negedge aclr)
	  if (~aclr)      wp <= 0;
	  else if (sclr)  wp <= 0;
	  else if (fwreq) wp <= {wp[4-1:1], lsb(wp)};


	//
	// hookup memory-block
	//
	reg [1-1:0] mem [(1<<4) -1:0];

	// memory array operations
	always @(posedge clk)
	  if (fwreq)
	    mem[wp] <= d;

	assign q = mem[rp];


	// generate full/empty signals
	assign aempty = (rp[4-1:1] == wp[4:2]) & (lsb(rp) == wp[1]) & frreq & ~fwreq;
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    empty <= 1'b1;
	  else if (sclr)
	    empty <= 1'b1;
	  else
	    empty <= aempty | (empty & (~fwreq + frreq));

	assign afull = (wp[4-1:1] == rp[4:2]) & (lsb(wp) == rp[1]) & fwreq & ~frreq;
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    full <= 1'b0;
	  else if (sclr)
	    full <= 1'b0;
	  else
	    full <= afull | ( full & (~frreq + fwreq) );

	// number of words in fifo
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    nword <= 0;
	  else if (sclr)
	    nword <= 0;
	  else
	    begin
	        if (wreq & !rreq)
	          nword <= nword +1;
	        else if (rreq & !wreq)
	          nword <= nword -1;
	    end

endmodule

module vga_fifo_3_8
   (
    input                clk,
    input                aclr,
    input                sclr,
    input                wreq,
    input                rreq,
    input [8-1:0]         d,
    output [8-1:0]        q,
    output reg [3:0]        nword,
    output reg              empty,
    output reg              full,
    output               aempty,
    output               afull
    );

	// reg [3:0] nword;
	// reg        empty, full;

	//
	// Module body
	//
	reg  [3-1:0] rp, wp;
	wire [8-1:0] ramq;
	wire fwreq, frreq;























	function lsb;
	   input [3-1:0] q;
	   case (3)
	       2: lsb = ~q[2];
	       3: lsb = ~(q[3] ^ q[2]);
	       4: lsb = ~(q[4] ^ q[3]);
	       5: lsb = ~(q[5] ^ q[3]);
	       6: lsb = ~(q[6] ^ q[5]);
	       7: lsb = ~(q[7] ^ q[6]);
	       8: lsb = ~(q[8] ^ q[6] ^ q[5] ^ q[4]);
	       9: lsb = ~(q[9] ^ q[5]);
	      10: lsb = ~(q[10] ^ q[7]);
	      11: lsb = ~(q[11] ^ q[9]);
	      12: lsb = ~(q[12] ^ q[6] ^ q[4] ^ q[1]);
	      13: lsb = ~(q[13] ^ q[4] ^ q[3] ^ q[1]);
	      14: lsb = ~(q[14] ^ q[5] ^ q[3] ^ q[1]);
	      15: lsb = ~(q[15] ^ q[14]);
	      16: lsb = ~(q[16] ^ q[15] ^ q[13] ^ q[4]);
	   endcase
	endfunction






  assign fwreq = wreq;
  assign frreq = rreq;


	//
	// hookup read-pointer
	//
	always @(posedge clk or negedge aclr)
	  if (~aclr)      rp <= 0;
	  else if (sclr)  rp <= 0;
	  else if (frreq) rp <= {rp[3-1:1], lsb(rp)};

	//
	// hookup write-pointer
	//
	always @(posedge clk or negedge aclr)
	  if (~aclr)      wp <= 0;
	  else if (sclr)  wp <= 0;
	  else if (fwreq) wp <= {wp[3-1:1], lsb(wp)};


	//
	// hookup memory-block
	//
	reg [8-1:0] mem [(1<<3) -1:0];

	// memory array operations
	always @(posedge clk)
	  if (fwreq)
	    mem[wp] <= d;

	assign q = mem[rp];


	// generate full/empty signals
	assign aempty = (rp[3-1:1] == wp[3:2]) & (lsb(rp) == wp[1]) & frreq & ~fwreq;
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    empty <= 1'b1;
	  else if (sclr)
	    empty <= 1'b1;
	  else
	    empty <= aempty | (empty & (~fwreq + frreq));

	assign afull = (wp[3-1:1] == rp[3:2]) & (lsb(wp) == rp[1]) & fwreq & ~frreq;
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    full <= 1'b0;
	  else if (sclr)
	    full <= 1'b0;
	  else
	    full <= afull | ( full & (~frreq + fwreq) );

	// number of words in fifo
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    nword <= 0;
	  else if (sclr)
	    nword <= 0;
	  else
	    begin
	        if (wreq & !rreq)
	          nword <= nword +1;
	        else if (rreq & !wreq)
	          nword <= nword -1;
	    end

endmodule




module vga_fifo
  #(parameter aw = 3,
    parameter dw = 8)
   (
    input                clk,
    input                aclr,
    input                sclr,
    input                wreq,
    input                rreq,
    input [dw:1]         d,
    output [dw:1]        q,
    output reg [aw:0]        nword,
    output reg              empty,
    output reg              full,
    output               aempty,
    output               afull
    );


	// reg [aw:0] nword;
	// reg        empty, full;

	//
	// Module body
	//
	reg  [aw:1] rp, wp;
	wire [dw:1] ramq;
	wire fwreq, frreq;


	function lsb;
	   input [aw:1] q;
	   case (aw)
	       2: lsb = ~q[2];
	       3: lsb = &q[aw-1:1] ^ ~(q[3] ^ q[2]);
	       4: lsb = &q[aw-1:1] ^ ~(q[4] ^ q[3]);
	       5: lsb = &q[aw-1:1] ^ ~(q[5] ^ q[3]);
	       6: lsb = &q[aw-1:1] ^ ~(q[6] ^ q[5]);
	       7: lsb = &q[aw-1:1] ^ ~(q[7] ^ q[6]);
	       8: lsb = &q[aw-1:1] ^ ~(q[8] ^ q[6] ^ q[5] ^ q[4]);
	       9: lsb = &q[aw-1:1] ^ ~(q[9] ^ q[5]);
	      10: lsb = &q[aw-1:1] ^ ~(q[10] ^ q[7]);
	      11: lsb = &q[aw-1:1] ^ ~(q[11] ^ q[9]);
	      12: lsb = &q[aw-1:1] ^ ~(q[12] ^ q[6] ^ q[4] ^ q[1]);
	      13: lsb = &q[aw-1:1] ^ ~(q[13] ^ q[4] ^ q[3] ^ q[1]);
	      14: lsb = &q[aw-1:1] ^ ~(q[14] ^ q[5] ^ q[3] ^ q[1]);
	      15: lsb = &q[aw-1:1] ^ ~(q[15] ^ q[14]);
	      16: lsb = &q[aw-1:1] ^ ~(q[16] ^ q[15] ^ q[13] ^ q[4]);
	   endcase
	endfunction



























  assign fwreq = wreq;
  assign frreq = rreq;


	//
	// hookup read-pointer
	//
	always @(posedge clk or negedge aclr)
	  if (~aclr)      rp <= 0;
	  else if (sclr)  rp <= 0;
	  else if (frreq) rp <= {rp[aw-1:1], lsb(rp)};

	//
	// hookup write-pointer
	//
	always @(posedge clk or negedge aclr)
	  if (~aclr)      wp <= 0;
	  else if (sclr)  wp <= 0;
	  else if (fwreq) wp <= {wp[aw-1:1], lsb(wp)};


	//
	// hookup memory-block
	//
	reg [dw:1] mem [(1<<aw) -1:0];

	// memory array operations
	always @(posedge clk)
	  if (fwreq)
	    mem[wp] <= d;

	assign q = mem[rp];


	// generate full/empty signals
	assign aempty = (rp[aw-1:1] == wp[aw:2]) & (lsb(rp) == wp[1]) & frreq & ~fwreq;
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    empty <= 1'b1;
	  else if (sclr)
	    empty <= 1'b1;
	  else
	    empty <= aempty | (empty & (~fwreq + frreq));

	assign afull = (wp[aw-1:1] == rp[aw:2]) & (lsb(wp) == rp[1]) & fwreq & ~frreq;
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    full <= 1'b0;
	  else if (sclr)
	    full <= 1'b0;
	  else
	    full <= afull | ( full & (~frreq + fwreq) );

	// number of words in fifo
	always @(posedge clk or negedge aclr)
	  if (~aclr)
	    nword <= 0;
	  else if (sclr)
	    nword <= 0;
	  else
	    begin
	        if (wreq & !rreq)
	          nword <= nword +1;
	        else if (rreq & !wreq)
	          nword <= nword -1;
	    end

	//
	// Simulation checks
	//
	// synopsys translate_off
	always @(posedge clk)
	  if (full & fwreq)
	    $display("Writing while FIFO full (%m)\n");

	always @(posedge clk)
	  if (empty & frreq)
	    $display("Reading while FIFO empty (%m)\n");
	// synopsys translate_on
endmodule


/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant VGA/LCD Core; Pixel Generator    ////
////                                                             ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001 Richard Herveille                        ////
////                    richard@asics.ws                         ////
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
//  $Id: vga_pgen.v,v 1.7 2003/08/01 11:46:38 rherveille Exp $
//
//  $Date: 2003/08/01 11:46:38 $
//  $Revision: 1.7 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_pgen.v,v $
//               Revision 1.7  2003/08/01 11:46:38  rherveille
//               1) Rewrote vga_fifo_dc. It now uses gray codes and a more elaborate anti-metastability scheme.
//               2) Changed top level and pixel generator to reflect changes in the fifo.
//               3) Changed a bug in vga_fifo.
//               4) Changed pixel generator and wishbone master to reflect changes.
//
//               Revision 1.6  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.5  2002/04/05 06:24:35  rherveille
//               Fixed a potential reset bug in the hint & vint generation.
//
//               Revision 1.4  2002/01/28 03:47:16  rherveille
//               Changed counter-library.
//               Changed vga-core.
//               Added 32bpp mode.
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on

/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant enhanced VGA/LCD Core            ////
////  Defines file                                               ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001, 2002 Richard Herveille                  ////
////                          richard@asics.ws                   ////
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
//  $Id: vga_defines.v,v 1.6 2003/08/01 11:46:38 rherveille Exp $
//
//  $Date: 2003/08/01 11:46:38 $
//  $Revision: 1.6 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_defines.v,v $
//               Revision 1.6  2003/08/01 11:46:38  rherveille
//               1) Rewrote vga_fifo_dc. It now uses gray codes and a more elaborate anti-metastability scheme.
//               2) Changed top level and pixel generator to reflect changes in the fifo.
//               3) Changed a bug in vga_fifo.
//               4) Changed pixel generator and wishbone master to reflect changes.
//
//               Revision 1.5  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.4  2002/02/07 05:42:10  rherveille
//               Fixed some bugs discovered by modified testbench
//               Removed / Changed some strange logic constructions
//               Started work on hardware cursor support (not finished yet)
//               Changed top-level name to vga_enh_top.v
//


////////////////////////
//
// Global settings
//

//
// define memory vendor
// for FPGA implementations use `define VENDOR_FPGA



//
// enable / disable 12bit DVI output
// (for use with external DVI transmitters)
//`define VGA_12BIT_DVI


////////////////////////
//
// Hardware Cursors
//

//
// enable / disable hardware cursors
//
//`define VGA_HWC0
//`define VGA_HWC1


//
// enable / disabled 3D support for hardware cursors
//
//`define VGA_HWC_3D


module vga_pgen (
	clk_i, ctrl_ven, ctrl_HSyncL, Thsync, Thgdel, Thgate, Thlen,
	ctrl_VSyncL, Tvsync, Tvgdel, Tvgate, Tvlen, ctrl_CSyncL, ctrl_BlankL,
	eoh, eov,
	ctrl_dvi_odf, ctrl_cd, ctrl_pc,
	fb_data_fifo_rreq, fb_data_fifo_empty, fb_data_fifo_q, ImDoneFifoQ,
	stat_acmp, clut_req, clut_adr, clut_q, clut_ack, ctrl_cbsw, clut_switch,
	cursor_adr,
	cursor0_en, cursor0_res, cursor0_xy, cc0_adr_o, cc0_dat_i,
	cursor1_en, cursor1_res, cursor1_xy, cc1_adr_o, cc1_dat_i,
	line_fifo_wreq, line_fifo_full, line_fifo_d, line_fifo_rreq, line_fifo_q,
	pclk_i,



	pclk_o, hsync_o, vsync_o, csync_o, blank_o, r_o, g_o, b_o
);

	// inputs & outputs

	input clk_i; // master clock

	input ctrl_ven;           // Video enable signal

	// horiontal timing settings
	input        ctrl_HSyncL; // horizontal sync pulse polarization level (pos/neg)
	input [ 7:0] Thsync;      // horizontal sync pulse width (in pixels)
	input [ 7:0] Thgdel;      // horizontal gate delay (in pixels)
	input [15:0] Thgate;      // horizontal gate length (number of visible pixels per line)
	input [15:0] Thlen;       // horizontal length (number of pixels per line)

	// vertical timing settings
	input        ctrl_VSyncL; // vertical sync pulse polarization level (pos/neg)
	input [ 7:0] Tvsync;      // vertical sync pulse width (in lines)
	input [ 7:0] Tvgdel;      // vertical gate delay (in lines)
	input [15:0] Tvgate;      // vertical gate length (number of visible lines in frame)
	input [15:0] Tvlen;       // vertical length (number of lines in frame)

	// composite signals
	input ctrl_CSyncL;        // composite sync pulse polarization level
	input ctrl_BlankL;        // blank signal polarization level

	// status outputs
	output reg eoh;               // end of horizontal
	// reg eoh;
	output reg eov;               // end of vertical;
	// reg eov;


	// Pixel signals
	input  [ 1: 0] ctrl_dvi_odf;
	input  [ 1: 0] ctrl_cd;
	input          ctrl_pc;

	input  [31: 0] fb_data_fifo_q;
	input          fb_data_fifo_empty;
	output         fb_data_fifo_rreq;
	input          ImDoneFifoQ;

	output reg     stat_acmp;   // active CLUT memory page
	// reg stat_acmp;
	output         clut_req;
	output [ 8: 0] clut_adr;
	input  [23: 0] clut_q;
	input          clut_ack;
	input          ctrl_cbsw;   // enable clut bank switching
	output         clut_switch; // clut memory bank-switch request: clut page switched (when enabled)

	input  [ 8: 0] cursor_adr;  // cursor data address (from wbm)
	input          cursor0_en;  // enable hardware cursor0
	input          cursor0_res; // cursor0 resolution
	input  [31: 0] cursor0_xy;  // (x,y) address hardware cursor0
	output [ 3: 0] cc0_adr_o;   // cursor0 color registers address output
	input  [15: 0] cc0_dat_i;   // cursor0 color registers data input
	input          cursor1_en;  // enable hardware cursor1
	input          cursor1_res; // cursor1 resolution
	input  [31: 0] cursor1_xy;  // (x,y) address hardware cursor1
	output [ 3: 0] cc1_adr_o;   // cursor1 color registers address output
	input  [15: 0] cc1_dat_i;   // cursor1 color registers data input

	input          line_fifo_full;
	output         line_fifo_wreq;
	output [23: 0] line_fifo_d;
	output         line_fifo_rreq;
	input  [23: 0] line_fifo_q;


	// pixel clock related outputs
	input  pclk_i;            // pixel clock in
	output pclk_o;            // pixel clock out

	output reg hsync_o;           // horizontal sync pulse
	output reg vsync_o;           // vertical sync pulse
	output reg csync_o;           // composite sync: Hsync OR Vsync (logical OR function)
	output reg blank_o;           // blanking signal
	output reg [ 7:0] r_o, g_o, b_o;

	// reg       hsync_o, vsync_o, csync_o, blank_o;
	// reg [7:0] r_o, g_o, b_o;

	










	//
	// variable declarations
	//
	reg nVen; // video enable signal (active low)
	wire eol, eof;
	wire ihsync, ivsync, icsync, iblank;
	wire pclk_ena;

	//////////////////////////////////
	//
	// module body
	//

	// synchronize timing/control settings (from master-clock-domain to pixel-clock-domain)
	always @(posedge pclk_i)
	  nVen <= ~ctrl_ven;


	//////////////////////////////////
	//
	// Pixel Clock generator
	//

	vga_clkgen clk_gen(
	  .pclk_i       ( pclk_i       ),
	  .rst_i        ( nVen         ),
	  .pclk_o       ( pclk_o       ),
	  .dvi_pclk_p_o ( dvi_pclk_p_o ),
	  .dvi_pclk_m_o ( dvi_pclk_m_o ),
	  .pclk_ena_o   ( pclk_ena     )
	);


	//////////////////////////////////
	//
	// Timing generator
	//

	// hookup video timing generator
	vga_tgen vtgen(
		.clk(pclk_i),
		.clk_ena ( pclk_ena    ),
		.rst     ( nVen        ),
		.Thsync  ( Thsync      ),
		.Thgdel  ( Thgdel      ),
		.Thgate  ( Thgate      ),
		.Thlen   ( Thlen       ),
		.Tvsync  ( Tvsync      ),
		.Tvgdel  ( Tvgdel      ),
		.Tvgate  ( Tvgate      ),
		.Tvlen   ( Tvlen       ),
		.eol     ( eol         ),
		.eof     ( eof         ),
		.gate    ( gate        ),
		.hsync   ( ihsync      ),
		.vsync   ( ivsync      ),
		.csync   ( icsync      ),
		.blank   ( iblank      )
	);

	//
	// from pixel-clock-domain to master-clock-domain
	//
	reg seol, seof;   // synchronized end-of-line, end-of-frame
	reg dseol, dseof; // delayed seol, seof

	always @(posedge clk_i)
	  if (~ctrl_ven)
	    begin
	        seol  <= 1'b0;
	        dseol <= 1'b0;

	        seof  <= 1'b0;
	        dseof <= 1'b0;

	        eoh   <= 1'b0;
	        eov   <= 1'b0;
	    end
	  else
	    begin
	        seol  <= eol;
	        dseol <= seol;

	        seof  <= eof;
	        dseof <= seof;

	        eoh   <= seol & !dseol;
	        eov   <= seof & !dseof;
	    end












	reg hsync, vsync, csync, blank;
	always @(posedge pclk_i)
	    begin
	        hsync <= ihsync ^ ctrl_HSyncL;
	        vsync <= ivsync ^ ctrl_VSyncL;
	        csync <= icsync ^ ctrl_CSyncL;
	        blank <= iblank ^ ctrl_BlankL;

	        hsync_o <= hsync;
	        vsync_o <= vsync;
	        csync_o <= csync;
	        blank_o <= blank;
	    end




	//////////////////////////////////
	//
	// Pixel generator section
	//

	wire [23:0] color_proc_q;           // data from color processor
	wire        color_proc_wreq;
	wire [ 7:0] clut_offs;               // color lookup table offset

	// wire ImDoneFifoQ;
	reg  dImDoneFifoQ, ddImDoneFifoQ;

	wire [23:0] cur1_q;
	wire        cur1_wreq;

	wire [23:0] rgb_fifo_d;
	wire        rgb_fifo_empty, rgb_fifo_full, rgb_fifo_rreq, rgb_fifo_wreq;

	wire sclr = ~ctrl_ven;

	//
	// hookup color processor
	vga_colproc color_proc (
		.clk               ( clk_i               ),
		.srst              ( sclr                ),
		.vdat_buffer_di    ( fb_data_fifo_q      ), //data_fifo_q),
		.ColorDepth        ( ctrl_cd             ),
		.PseudoColor       ( ctrl_pc             ),
		.vdat_buffer_empty ( fb_data_fifo_empty  ), //data_fifo_empty),
		.vdat_buffer_rreq  ( fb_data_fifo_rreq   ), //data_fifo_rreq),
		.rgb_fifo_full     ( rgb_fifo_full       ),
		.rgb_fifo_wreq     ( color_proc_wreq     ),
		.r                 ( color_proc_q[23:16] ),
		.g                 ( color_proc_q[15: 8] ),
		.b                 ( color_proc_q[ 7: 0] ),
		.clut_req          ( clut_req            ),
		.clut_ack          ( clut_ack            ),
		.clut_offs         ( clut_offs           ),
		.clut_q            ( clut_q              )
	);

	//
	// clut bank switch / cursor data delay2: Account for ColorProcessor DataBuffer delay
	always @(posedge clk_i)
	  if (sclr)
	    dImDoneFifoQ <= 1'b0;
	  else if (fb_data_fifo_rreq)
	    dImDoneFifoQ <= ImDoneFifoQ;

	always @(posedge clk_i)
	  if (sclr)
	    ddImDoneFifoQ <= 1'b0;
	  else
	    ddImDoneFifoQ <= dImDoneFifoQ;

	assign clut_switch = ddImDoneFifoQ & !dImDoneFifoQ;

	always @(posedge clk_i)
	  if (sclr)
	    stat_acmp <= 1'b0;
	  else if (ctrl_cbsw)
	    stat_acmp <= stat_acmp ^ clut_switch;  // select next clut when finished reading clut for current video bank (and bank switch enabled)

	// generate clut-address
	assign clut_adr = {stat_acmp, clut_offs};


	//
	// hookup data-source-selector && hardware cursor module




















































		// Hardware Cursor1 disabled, generate pass-through signals
	assign cur1_wreq = color_proc_wreq;
	assign cur1_q    = color_proc_q;

	assign cc1_adr_o  = 4'h0;



















































	// Hardware Cursor0 disabled, generate pass-through signals
	assign rgb_fifo_wreq = cur1_wreq;
	assign rgb_fifo_d = cur1_q;

	assign cc0_adr_o  = 4'h0;


	//
	// hookup RGB buffer (temporary station between WISHBONE-clock-domain
	// and pixel-clock-domain)
	// The cursor_processor pipelines introduce a delay between the color
	// processor's rgb_fifo_wreq and the rgb_fifo_full signals. To compensate
	// for this we double the rgb_fifo.
	wire [4:0] rgb_fifo_nword;

	vga_fifo_4_24 rgb_fifo (
		.clk    ( clk_i          ),
		.aclr   ( 1'b1           ),
		.sclr   ( sclr           ),
		.d      ( rgb_fifo_d     ),
		.wreq   ( rgb_fifo_wreq  ),
		.q      ( line_fifo_d    ),
		.rreq   ( rgb_fifo_rreq  ),
		.empty  ( rgb_fifo_empty ),
		.nword  ( rgb_fifo_nword ),
		.full   ( ),
		.aempty ( ),
		.afull  ( )
	);

	assign rgb_fifo_full = rgb_fifo_nword[3]; // actually half full

	assign line_fifo_rreq = gate & pclk_ena;

	assign rgb_fifo_rreq = ~line_fifo_full & ~rgb_fifo_empty;
	assign line_fifo_wreq = rgb_fifo_rreq;

	wire [7:0] r = line_fifo_q[23:16];
	wire [7:0] g = line_fifo_q[15: 8];
	wire [7:0] b = line_fifo_q[ 7: 0];

	always @(posedge pclk_i)
	  if (pclk_ena) begin
	    r_o <= r;
	    g_o <= g;
	    b_o <= b;
	  end


	//
	// DVI section
	//
























































endmodule

/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant VGA/LCD Core; Timing Generator   ////
////  Horizontal and Vertical Timing Generator                   ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001 Richard Herveille                        ////
////                    richard@asics.ws                         ////
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
//  $Id: vga_tgen.v,v 1.5 2003/05/07 09:48:54 rherveille Exp $
//
//  $Date: 2003/05/07 09:48:54 $
//  $Revision: 1.5 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_tgen.v,v $
//               Revision 1.5  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.4  2002/01/28 03:47:16  rherveille
//               Changed counter-library.
//               Changed vga-core.
//               Added 32bpp mode.
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on

module vga_tgen(
	clk, clk_ena, rst,
	Thsync, Thgdel, Thgate, Thlen, Tvsync, Tvgdel, Tvgate, Tvlen,
	eol, eof, gate, hsync, vsync, csync, blank
	);

	// inputs & outputs
	input clk;
	input clk_ena;
	input rst;

	// horizontal timing settings inputs
	input [ 7:0] Thsync; // horizontal sync pule width (in pixels)
	input [ 7:0] Thgdel; // horizontal gate delay
	input [15:0] Thgate; // horizontal gate (number of visible pixels per line)
	input [15:0] Thlen;  // horizontal length (number of pixels per line)

	// vertical timing settings inputs
	input [ 7:0] Tvsync; // vertical sync pule width (in pixels)
	input [ 7:0] Tvgdel; // vertical gate delay
	input [15:0] Tvgate; // vertical gate (number of visible pixels per line)
	input [15:0] Tvlen;  // vertical length (number of pixels per line)

	// outputs
	output eol;  // end of line
	output eof;  // end of frame
	output gate; // vertical AND horizontal gate (logical AND function)

	output hsync; // horizontal sync pulse
	output vsync; // vertical sync pulse
	output csync; // composite sync
	output blank; // blank signal

	//
	// variable declarations
	//
	wire Hgate, Vgate;
	wire Hdone;

	//
	// module body
	//

	// hookup horizontal timing generator
	vga_vtim hor_gen(
		.clk(clk),
		.ena(clk_ena),
		.rst(rst),
		.Tsync(Thsync),
		.Tgdel(Thgdel),
		.Tgate(Thgate),
		.Tlen(Thlen),
		.Sync(hsync),
		.Gate(Hgate),
		.Done(Hdone)
	);


	// hookup vertical timing generator
	wire vclk_ena = Hdone & clk_ena;

	vga_vtim ver_gen(
		.clk(clk),
		.ena(vclk_ena),
		.rst(rst),
		.Tsync(Tvsync),
		.Tgdel(Tvgdel),
		.Tgate(Tvgate),
		.Tlen(Tvlen),
		.Sync(vsync),
		.Gate(Vgate),
		.Done(eof)
	);

	// assign outputs
	assign eol  = Hdone;
	assign gate = Hgate & Vgate;
	assign csync = hsync | vsync;
	assign blank = ~gate;
endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant VGA/LCD Core; Timing Generator   ////
////  Video Timing Generator                                     ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001 Richard Herveille                        ////
////                    richard@asics.ws                         ////
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
//  $Id: vga_vtim.v,v 1.8 2003/05/07 09:48:54 rherveille Exp $
//
//  $Date: 2003/05/07 09:48:54 $
//  $Revision: 1.8 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_vtim.v,v $
//               Revision 1.8  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.7  2003/03/19 12:50:45  rherveille
//               Changed timing generator; made it smaller and easier.
//
//               Revision 1.6  2002/04/20 10:02:39  rherveille
//               Changed video timing generator.
//               Changed wishbone master vertical gate count code.
//               Fixed a potential bug in the wishbone slave (cursor color register readout).
//
//               Revision 1.5  2002/01/28 03:47:16  rherveille
//               Changed counter-library.
//               Changed vga-core.
//               Added 32bpp mode.
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on

module vga_vtim(clk, ena, rst, Tsync, Tgdel, Tgate, Tlen, Sync, Gate, Done);
	// inputs & outputs
	input clk; // master clock
	input ena; // count enable
	input rst; // synchronous active high reset

	input [ 7:0] Tsync; // sync duration
	input [ 7:0] Tgdel; // gate delay
	input [15:0] Tgate; // gate length
	input [15:0] Tlen;  // line time / frame time

	output reg Sync; // synchronization pulse
	output reg Gate; // gate
	output reg Done; // done with line/frame
	// reg Sync;
	// reg Gate;
	// reg Done;

	//
	// module body
	//

	// generate timing statemachine
	reg  [15:0] cnt, cnt_len;
	wire [16:0] cnt_nxt, cnt_len_nxt;
	wire        cnt_done, cnt_len_done;

	assign cnt_nxt = {1'b0, cnt} -17'h1;
	assign cnt_done = cnt_nxt[16];

	assign cnt_len_nxt = {1'b0, cnt_len} -17'h1;
	assign cnt_len_done = cnt_len_nxt[16];

	reg [4:0] state;
	parameter [4:0] idle_state = 5'b00001;
	parameter [4:0] sync_state = 5'b00010;
	parameter [4:0] gdel_state = 5'b00100;
	parameter [4:0] gate_state = 5'b01000;
	parameter [4:0] len_state  = 5'b10000;

	always @(posedge clk)
	  if (rst)
	    begin
	        state   <= idle_state;
	        cnt     <= 16'h0;
	        cnt_len <= 16'b0;
	        Sync    <= 1'b0;
	        Gate    <= 1'b0;
	        Done    <= 1'b0;
	    end
	  else if (ena)
	    begin
	        cnt     <= cnt_nxt[15:0];
	        cnt_len <= cnt_len_nxt[15:0];

	        Done    <= 1'b0;

	        case (state) // synopsys full_case parallel_case
	          idle_state:
	            begin
	                state   <= sync_state;
	                cnt     <= Tsync;
	                cnt_len <= Tlen;

	                Sync    <= 1'b1;
	            end

	          sync_state:
	            if (cnt_done)
	              begin
	                  state <= gdel_state;
	                  cnt   <= Tgdel;

	                  Sync  <= 1'b0;
	              end

	          gdel_state:
	            if (cnt_done)
	              begin
	                  state <= gate_state;
	                  cnt   <= Tgate;

	                  Gate  <= 1'b1;
	              end

	          gate_state:
	            if (cnt_done)
	              begin
	                  state <= len_state;

	                  Gate  <= 1'b0;
	              end

	          len_state:
	            if (cnt_len_done)
	              begin
	                  state   <= sync_state;
	                  cnt     <= Tsync;
	                  cnt_len <= Tlen;

	                  Sync    <= 1'b1;
	                  Done    <= 1'b1;
	              end

	        endcase
	    end
endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant enhanced VGA/LCD Core            ////
////  Wishbone master interface                                  ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001, 2002 Richard Herveille                  ////
////                          richard@asics.ws                   ////
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
//  $Id: vga_wb_master.v,v 1.15 2003/08/01 11:46:38 rherveille Exp $
//
//  $Date: 2003/08/01 11:46:38 $
//  $Revision: 1.15 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_wb_master.v,v $
//               Revision 1.15  2003/08/01 11:46:38  rherveille
//               1) Rewrote vga_fifo_dc. It now uses gray codes and a more elaborate anti-metastability scheme.
//               2) Changed top level and pixel generator to reflect changes in the fifo.
//               3) Changed a bug in vga_fifo.
//               4) Changed pixel generator and wishbone master to reflect changes.
//
//               Revision 1.14  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.13  2003/03/19 12:50:45  rherveille
//               Changed timing generator; made it smaller and easier.
//
//               Revision 1.12  2003/03/18 21:45:48  rherveille
//               Added WISHBONE revB.3 Registered Feedback Cycles support
//
//               Revision 1.11  2002/04/20 10:02:39  rherveille
//               Changed video timing generator.
//               Changed wishbone master vertical gate count code.
//               Fixed a potential bug in the wishbone slave (cursor color register readout).
//
//               Revision 1.10  2002/03/28 04:59:25  rherveille
//               Fixed two small bugs that only showed up when the hardware cursors were disabled
//
//               Revision 1.9  2002/03/04 16:05:52  rherveille
//               Added hardware cursor support to wishbone master.
//               Added provision to turn-off 3D cursors.
//               Fixed some minor bugs.
//
//               Revision 1.8  2002/03/04 11:01:59  rherveille
//               Added 64x64pixels 4bpp hardware cursor support.
//
//               Revision 1.7  2002/02/16 10:40:00  rherveille
//               Some minor bug-fixes.
//               Changed vga_ssel into vga_curproc (cursor processor).
//
//               Revision 1.6  2002/02/07 05:42:10  rherveille
//               Fixed some bugs discovered by modified testbench
//               Removed / Changed some strange logic constructions
//               Started work on hardware cursor support (not finished yet)
//               Changed top-level name to vga_enh_top.v
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on

module vga_wb_master (clk_i, rst_i, nrst_i,
	cyc_o, stb_o, cti_o, bte_o, we_o, adr_o, sel_o, ack_i, err_i, dat_i, sint,
	ctrl_ven, ctrl_cd, ctrl_vbl, ctrl_vbsw, busy,
	VBAa, VBAb, Thgate, Tvgate,
	stat_avmp, vmem_switch, ImDoneFifoQ,
	cursor_adr, cursor0_ba, cursor1_ba, cursor0_ld, cursor1_ld,
	fb_data_fifo_rreq, fb_data_fifo_q, fb_data_fifo_empty);

	// inputs & outputs

	// wishbone signals
	input         clk_i;    // master clock input
	input         rst_i;    // synchronous active high reset
	input         nrst_i;   // asynchronous low reset
	output reg       cyc_o;    // cycle output
	// reg cyc_o;
	output   reg     stb_o;    // strobe ouput
	// reg stb_o;
	output reg [ 2:0] cti_o;    // cycle type id
	// reg [2:0] cti_o;
	output reg [ 1:0] bte_o;    // burst type extension
	// reg [1:0] bte_o;
	output  reg      we_o;     // write enable output
	// reg we_o;
	output [31:0] adr_o;    // address output
	output reg [ 3:0] sel_o;    // byte select outputs (only 32bits accesses are supported)
	// reg [3:0] sel_o;
	input         ack_i;    // wishbone cycle acknowledge
	input         err_i;    // wishbone cycle error
	input [31:0]  dat_i;    // wishbone data in

	output        sint;     // non recoverable error, interrupt host

	// control register settings
	input       ctrl_ven;   // video enable bit
	input [1:0] ctrl_cd;    // color depth
	input [1:0] ctrl_vbl;   // burst length
	input       ctrl_vbsw;  // enable video bank switching
	output      busy;       // data transfer in progress

	// video memory addresses
	input [31: 2] VBAa;     // video memory base address A
	input [31: 2] VBAb;     // video memory base address B

	input [15:0] Thgate;    // horizontal visible area (in pixels)
	input [15:0] Tvgate;    // vertical visible area (in horizontal lines)

	output stat_avmp;       // active video memory page
	output vmem_switch;     // video memory bank-switch request: memory page switched (when enabled)
	output ImDoneFifoQ;

	output reg [ 8: 0] cursor_adr; // cursor address
	input  [31:11] cursor0_ba;
	input  [31:11] cursor1_ba;
	input          cursor0_ld; // load cursor0 (from wbs)
	input          cursor1_ld; // load cursor1 (from wbs)

	input          fb_data_fifo_rreq;
	output [31: 0] fb_data_fifo_q;
	output         fb_data_fifo_empty;


	//
	// variable declarations
	//

	reg vmem_acc;                 // video memory access
	wire vmem_req, vmem_ack;      // video memory access request // video memory access acknowledge

	wire ImDone;                  // Done reading image from video mem
	reg  dImDone;                 // delayed ImDone
	wire ImDoneStrb;              // image done (strobe signal)
	reg  dImDoneStrb;             // delayed ImDoneStrb

	reg sclr;                     // (video/cursor) synchronous clear

	// hardware cursors
	reg [31:11] cursor_ba;              // cursor pattern base address
	// reg [ 8: 0] cursor_adr;             // cursor pattern offset
	wire        cursor0_we, cursor1_we; // cursor buffers write_request
	reg         ld_cursor0, ld_cursor1; // reload cursor0, cursor1
	reg         cur_acc;                // cursor processors request memory access
	reg         cur_acc_sel;            // which cursor to reload
	wire        cur_ack;                // cursor processor memory access acknowledge
	wire        cur_done;               // done reading cursor pattern

	//
	// module body
	//

	// generate synchronous clear
	always @(posedge clk_i)
	  sclr <= ~ctrl_ven;

	//
	// WISHBONE block
	//
	reg  [ 2:0] burst_cnt;                       // video memory burst access counter
	wire        burst_done;                      // completed burst access to video mem
	reg         sel_VBA;                         // select video memory base address
	reg  [31:2] vmemA;                           // video memory address

	// wishbone access controller, video memory access request has highest priority (try to keep fifo full)
	always @(posedge clk_i)
	  if (sclr)
	    vmem_acc <= 1'b0; // video memory access request
	  else
	    vmem_acc <= (vmem_req | (vmem_acc & !(burst_done & vmem_ack)) ) & !ImDone & !cur_acc;

	always @(posedge clk_i)
	  if (sclr)
	    cur_acc <= 1'b0; // cursor processor memory access request
	  else
	    cur_acc <= (cur_acc | ImDone & (ld_cursor0 | ld_cursor1)) & !cur_done;
	    
	assign busy = vmem_acc | cur_acc;

	assign vmem_ack = ack_i & stb_o & vmem_acc;
	assign cur_ack  = ack_i & stb_o & cur_acc;
	assign sint = err_i; // Non recoverable error, interrupt host system


	// select active memory page
	assign vmem_switch = ImDoneStrb;

	always @(posedge clk_i)
	  if (sclr)
	    sel_VBA <= 1'b0;
	  else if (ctrl_vbsw)
	    sel_VBA <= sel_VBA ^ vmem_switch;  // select next video memory bank when finished reading current bank (and bank switch enabled)

	assign stat_avmp = sel_VBA; // assign output

	// selecting active clut page / cursor data
	// delay image done same amount as video-memory data
	vga_fifo_3_8 clut_sw_fifo (
		.clk    ( clk_i             ),
		.aclr   ( 1'b1              ),
		.sclr   ( sclr              ),
		.d      ( ImDone            ),
		.wreq   ( vmem_ack          ),
		.q      ( ImDoneFifoQ       ),
		.rreq   ( fb_data_fifo_rreq ),
		.nword  ( ),
		.empty  ( ),
		.full   ( ),
		.aempty ( ),
		.afull  ( )
	);


	//
	// generate burst counter
	wire [3:0] burst_cnt_val;
	assign burst_cnt_val = {1'b0, burst_cnt} -4'h1;
	assign burst_done = burst_cnt_val[3];

	always @(posedge clk_i)
	  if ( (burst_done & vmem_ack) | !vmem_acc)
	    case (ctrl_vbl) // synopsis full_case parallel_case
	      2'b00: burst_cnt <= 3'b000; // burst length 1
	      2'b01: burst_cnt <= 3'b001; // burst length 2
	      2'b10: burst_cnt <= 3'b011; // burst length 4
	      2'b11: burst_cnt <= 3'b111; // burst length 8
	    endcase
	  else if(vmem_ack)
	    burst_cnt <= burst_cnt_val[2:0];

	//
	// generate image counters
	//

	// hgate counter
	reg  [15:0] hgate_cnt;
	reg  [16:0] hgate_cnt_val;
	reg  [1:0]  hgate_div_cnt;
	reg  [2:0]  hgate_div_val;

	wire hdone = hgate_cnt_val[16] & vmem_ack; // ????

	always @(hgate_cnt or hgate_div_cnt or ctrl_cd)
	  begin
	      hgate_div_val = {1'b0, hgate_div_cnt} - 3'h1;

	      if (ctrl_cd != 2'b10)
	        hgate_cnt_val = {1'b0, hgate_cnt} - 17'h1;
	      else if ( hgate_div_val[2] )
	        hgate_cnt_val = {1'b0, hgate_cnt} - 17'h1;
	      else
	        hgate_cnt_val = {1'b0, hgate_cnt};
	  end

	always @(posedge clk_i)
	  if (sclr)
	    begin
	        case(ctrl_cd) // synopsys full_case parallel_case
	          2'b00: hgate_cnt <= Thgate >> 2; //  8bpp, 4 pixels per cycle
	          2'b01: hgate_cnt <= Thgate >> 1; // 16bpp, 2 pixels per cycle
	          2'b10: hgate_cnt <= Thgate >> 2; // 24bpp, 4/3 pixels per cycle
	          2'b11: hgate_cnt <= Thgate;      // 32bpp, 1 pixel per cycle
	        endcase

	        hgate_div_cnt <= 2'b10;
	    end
	  else if (vmem_ack)
	    if (hdone)
	      begin
	          case(ctrl_cd) // synopsys full_case parallel_case
	            2'b00: hgate_cnt <= Thgate >> 2; //  8bpp, 4 pixels per cycle
	            2'b01: hgate_cnt <= Thgate >> 1; // 16bpp, 2 pixels per cycle
	            2'b10: hgate_cnt <= Thgate >> 2; // 24bpp, 4/3 pixels per cycle
	            2'b11: hgate_cnt <= Thgate;      // 32bpp, 1 pixel per cycle
	          endcase

	          hgate_div_cnt <= 2'b10;
	      end
	    else //if (vmem_ack)
	      begin
	          hgate_cnt <= hgate_cnt_val[15:0];

	          if ( hgate_div_val[2] )
	            hgate_div_cnt <= 2'b10;
	          else
	            hgate_div_cnt <= hgate_div_val[1:0];
	      end

	// vgate counter
	reg  [15:0] vgate_cnt;
	wire [16:0] vgate_cnt_val;
	wire        vdone;

	assign vgate_cnt_val = {1'b0, vgate_cnt} - 17'h1;
	assign vdone = vgate_cnt_val[16];

	always @(posedge clk_i)
	  if (sclr | ImDoneStrb)
	    vgate_cnt <= Tvgate;
	  else if (hdone)
	    vgate_cnt <= vgate_cnt_val[15:0];

	assign ImDone = hdone & vdone;

	assign ImDoneStrb = ImDone & !dImDone;

	always @(posedge clk_i)
	  begin
	      dImDone <= ImDone;
	      dImDoneStrb <= ImDoneStrb;
	  end

	//
	// generate addresses
	//

	// select video memory base address
	always @(posedge clk_i)
	  if (sclr | dImDoneStrb)
	    if (!sel_VBA)
	      vmemA <= VBAa;
	    else
	      vmemA <= VBAb;
	  else if (vmem_ack)
	    vmemA <= vmemA +30'h1;


	////////////////////////////////////
	// hardware cursor signals section
	//
	always @(posedge clk_i)
	  if (ImDone)
	    cur_acc_sel <= ld_cursor0; // cursor0 has highest priority

	always @(posedge clk_i)
	if (sclr)
	  begin
	      ld_cursor0 <= 1'b0;
	      ld_cursor1 <= 1'b0;
	  end
	else
	  begin
	      ld_cursor0 <= cursor0_ld | (ld_cursor0 & !(cur_done &  cur_acc_sel));
	      ld_cursor1 <= cursor1_ld | (ld_cursor1 & !(cur_done & !cur_acc_sel));
	  end

	// select cursor base address
	always @(posedge clk_i)
	  if (!cur_acc)
	    cursor_ba <= ld_cursor0 ? cursor0_ba : cursor1_ba;

	// generate pattern offset
	wire [9:0] next_cursor_adr = {1'b0, cursor_adr} + 10'h1;
	assign cur_done = next_cursor_adr[9] & cur_ack;

	always @(posedge clk_i)
	  if (!cur_acc)
	    cursor_adr <= 9'h0;
	  else if (cur_ack)
	    cursor_adr <= next_cursor_adr;

	// generate cursor buffers write enable signals
	assign cursor1_we = cur_ack & !cur_acc_sel;
	assign cursor0_we = cur_ack &  cur_acc_sel;


	//////////////////////////////
	// generate wishbone signals
	//
	assign adr_o = cur_acc ? {cursor_ba, cursor_adr, 2'b00} : {vmemA, 2'b00};
	wire wb_cycle = vmem_acc & !(burst_done & vmem_ack & !vmem_req) & !ImDone ||
	                cur_acc & !cur_done;

	always @(posedge clk_i or negedge nrst_i)
	  if (!nrst_i)
	    begin
	        cyc_o <= 1'b0;
	        stb_o <= 1'b0;
	        sel_o <= 4'b1111;
	        cti_o <= 3'b000;
	        bte_o <= 2'b00;
	        we_o  <= 1'b0;
	    end
	  else
	    if (rst_i)
	      begin
	          cyc_o <= 1'b0;
	          stb_o <= 1'b0;
	          sel_o <= 4'b1111;
	          cti_o <= 3'b000;
	          bte_o <= 2'b00;
	          we_o  <= 1'b0;
	      end
	    else
	      begin
	          cyc_o <= wb_cycle;
	          stb_o <= wb_cycle;
	          sel_o <= 4'b1111;   // only 32bit accesses are supported

	          if (wb_cycle) begin
	            if (cur_acc)
	              cti_o <= &next_cursor_adr[8:0] ? 3'b111 : 3'b010;
	            else if (ctrl_vbl == 2'b00)
	              cti_o <= 3'b000;
	            else if (vmem_ack)
	              cti_o <= (burst_cnt == 3'h1) ? 3'b111 : 3'b010;
	          end else
	            cti_o <= (ctrl_vbl == 2'b00) ? 3'b000 : 3'b010;

	          bte_o <= 2'b00;     // linear burst
	          we_o  <= 1'b0;      // read only
	      end

	//
	// video-data buffer (temporary store data read from video memory)
	wire [4:0] fb_data_fifo_nword;
//	wire       fb_data_fifo_full;

	vga_fifo_4_32 data_fifo (
		.clk    ( clk_i              ),
		.aclr   ( 1'b1               ),
		.sclr   ( sclr               ),
		.d      ( dat_i              ),
		.wreq   ( vmem_ack           ),
		.q      ( fb_data_fifo_q     ),
		.rreq   ( fb_data_fifo_rreq  ),
		.nword  ( fb_data_fifo_nword ),
		.empty  ( fb_data_fifo_empty ),
		.full   ( ),//fb_data_fifo_full  ),
		.aempty ( ),
		.afull  ( )
	);

	assign vmem_req = ~fb_data_fifo_nword[4] & ~fb_data_fifo_nword[3];

endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant enhanced VGA/LCD Core            ////
////  Wishbone slave interface                                   ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001, 2002 Richard Herveille                  ////
////                    richard@asics.ws                         ////
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
//  $Id: vga_wb_slave.v,v 1.12 2003/05/07 09:48:54 rherveille Exp $
//
//  $Date: 2003/05/07 09:48:54 $
//  $Revision: 1.12 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_wb_slave.v,v $
//               Revision 1.12  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.11  2002/04/20 10:02:39  rherveille
//               Changed video timing generator.
//               Changed wishbone master vertical gate count code.
//               Fixed a potential bug in the wishbone slave (cursor color register readout).
//
//               Revision 1.10  2002/03/28 04:59:25  rherveille
//               Fixed two small bugs that only showed up when the hardware cursors were disabled
//
//               Revision 1.9  2002/03/04 16:05:52  rherveille
//               Added hardware cursor support to wishbone master.
//               Added provision to turn-off 3D cursors.
//               Fixed some minor bugs.
//
//               Revision 1.8  2002/03/04 11:01:59  rherveille
//               Added 64x64pixels 4bpp hardware cursor support.
//
//               Revision 1.7  2002/02/25 06:13:44  rherveille
//               Fixed dat_o incomplete sensitivity list.
//
//               Revision 1.6  2002/02/07 05:42:10  rherveille
//               Fixed some bugs discovered by modified testbench
//               Removed / Changed some strange logic constructions
//               Started work on hardware cursor support (not finished yet)
//               Changed top-level name to vga_enh_top.v
//

//synopsys translate_off
`timescale 1ns / 10ps

//synopsys translate_on
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant enhanced VGA/LCD Core            ////
////  Defines file                                               ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/vga_lcd ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001, 2002 Richard Herveille                  ////
////                          richard@asics.ws                   ////
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
//  $Id: vga_defines.v,v 1.6 2003/08/01 11:46:38 rherveille Exp $
//
//  $Date: 2003/08/01 11:46:38 $
//  $Revision: 1.6 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: vga_defines.v,v $
//               Revision 1.6  2003/08/01 11:46:38  rherveille
//               1) Rewrote vga_fifo_dc. It now uses gray codes and a more elaborate anti-metastability scheme.
//               2) Changed top level and pixel generator to reflect changes in the fifo.
//               3) Changed a bug in vga_fifo.
//               4) Changed pixel generator and wishbone master to reflect changes.
//
//               Revision 1.5  2003/05/07 09:48:54  rherveille
//               Fixed some Wishbone RevB.3 related bugs.
//               Changed layout of the core. Blocks are located more logically now.
//               Started work on a dual clocked/double edge 12bit output. Commonly used by external devices like DVI transmitters.
//
//               Revision 1.4  2002/02/07 05:42:10  rherveille
//               Fixed some bugs discovered by modified testbench
//               Removed / Changed some strange logic constructions
//               Started work on hardware cursor support (not finished yet)
//               Changed top-level name to vga_enh_top.v
//


////////////////////////
//
// Global settings
//

//
// define memory vendor
// for FPGA implementations use `define VENDOR_FPGA



//
// enable / disable 12bit DVI output
// (for use with external DVI transmitters)
//`define VGA_12BIT_DVI


////////////////////////
//
// Hardware Cursors
//

//
// enable / disable hardware cursors
//
//`define VGA_HWC0
//`define VGA_HWC1


//
// enable / disabled 3D support for hardware cursors
//
//`define VGA_HWC_3D


module vga_wb_slave(
	clk_i, rst_i, arst_i, adr_i, dat_i, dat_o, sel_i, we_i, stb_i, cyc_i, ack_o, rty_o, err_o, inta_o,
	wbm_busy, dvi_odf, bl, csl, vsl, hsl, pc, cd, vbl, cbsw, vbsw, ven, avmp, acmp,
	cursor0_res, cursor0_en, cursor0_xy, cursor0_ba, cursor0_ld, cc0_adr_i, cc0_dat_o,
	cursor1_res, cursor1_en, cursor1_xy, cursor1_ba, cursor1_ld, cc1_adr_i, cc1_dat_o,
	vbsint_in, cbsint_in, hint_in, vint_in, luint_in, sint_in,
	Thsync, Thgdel, Thgate, Thlen, Tvsync, Tvgdel, Tvgate, Tvlen, VBARa, VBARb,
	clut_acc, clut_ack, clut_q
	);

	//
	// inputs & outputs
	//

	// wishbone slave interface
	input         clk_i;
	input         rst_i;
	input         arst_i;
	input  [11:2] adr_i;
	input  [31:0] dat_i;
	output reg [31:0] dat_o;
	// reg [31:0] dat_o;
	input  [ 3:0] sel_i;
	input         we_i;
	input         stb_i;
	input         cyc_i;
	output reg       ack_o;
	// reg ack_o;
	output reg       rty_o;
	// reg rty_o;
	output reg       err_o;
	// reg err_o;
	output reg       inta_o;
	// reg inta_o;

	// wishbone master controller feedback
	input  wbm_busy;             // data transfer in progress

	// control register settings
	output [1:0] dvi_odf;        // DVI output data format
	output bl;                   // blanking level
	output csl;                  // composite sync level
	output vsl;                  // vsync level
	output hsl;                  // hsync level
	output pc;                   // pseudo color
	output [1:0] cd;             // color depth
	output [1:0] vbl;            // video memory burst length
	output cbsw;                 // clut bank switch enable
	output vbsw;                 // video memory bank switch enable
	output ven;                  // video system enable

	// hardware cursor settings
	output         cursor0_res;  // cursor0 resolution
	output         cursor0_en;   // cursor0 enable
	output reg [31: 0] cursor0_xy;   // cursor0 location
	output reg [31:11] cursor0_ba;   // cursor0 base address
	output reg        cursor0_ld;   // reload cursor0 from video memory
	input  [ 3: 0] cc0_adr_i;    // cursor0 color register address
	output [15: 0] cc0_dat_o;    // cursor0 color register data
	output         cursor1_res;  // cursor1 resolution
	output         cursor1_en;   // cursor1 enable
	output reg [31: 0] cursor1_xy;   // cursor1 location
	output reg[31:11] cursor1_ba;   // cursor1 base address
	output reg        cursor1_ld;   // reload cursor1 from video memory
	input  [ 3: 0] cc1_adr_i;    // cursor1 color register address
	output [15: 0] cc1_dat_o;    // cursor1 color register data


	// status register inputs
	input avmp;          // active video memory page
	input acmp;          // active clut memory page
	input vbsint_in;     // bank switch interrupt request
	input cbsint_in;     // clut switch interrupt request
	input hint_in;       // hsync interrupt request
	input vint_in;       // vsync interrupt request
	input luint_in;      // line fifo underrun interrupt request
	input sint_in;       // system error interrupt request

	// Horizontal Timing Register
	output [ 7:0] Thsync;
	output [ 7:0] Thgdel;
	output [15:0] Thgate;
	output [15:0] Thlen;

	// Vertical Timing Register
	output [ 7:0] Tvsync;
	output [ 7:0] Tvgdel;
	output [15:0] Tvgate;
	output [15:0] Tvlen;

	// video base addresses
	output reg [31:2] VBARa;
	// reg [31:2] VBARa;
	output reg [31:2] VBARb;
	// reg [31:2] VBARb;

	// color lookup table signals
	output        clut_acc;
	input         clut_ack;
	input  [23:0] clut_q;


	//
	// variable declarations
	//
	parameter REG_ADR_HIBIT = 7;

	wire [REG_ADR_HIBIT:0] REG_ADR  = adr_i[REG_ADR_HIBIT : 2];
	wire                   CLUT_ADR = adr_i[11];

	parameter [REG_ADR_HIBIT : 0] CTRL_ADR  = 6'b00_0000;
	parameter [REG_ADR_HIBIT : 0] STAT_ADR  = 6'b00_0001;
	parameter [REG_ADR_HIBIT : 0] HTIM_ADR  = 6'b00_0010;
	parameter [REG_ADR_HIBIT : 0] VTIM_ADR  = 6'b00_0011;
	parameter [REG_ADR_HIBIT : 0] HVLEN_ADR = 6'b00_0100;
	parameter [REG_ADR_HIBIT : 0] VBARA_ADR = 6'b00_0101;
	parameter [REG_ADR_HIBIT : 0] VBARB_ADR = 6'b00_0110;
	parameter [REG_ADR_HIBIT : 0] C0XY_ADR  = 6'b00_1100;
	parameter [REG_ADR_HIBIT : 0] C0BAR_ADR = 6'b00_1101;
	parameter [REG_ADR_HIBIT : 0] CCR0_ADR  = 6'b01_0???;
	parameter [REG_ADR_HIBIT : 0] C1XY_ADR  = 6'b01_1100;
	parameter [REG_ADR_HIBIT : 0] C1BAR_ADR = 6'b01_1101;
	parameter [REG_ADR_HIBIT : 0] CCR1_ADR  = 6'b10_0???;


	reg [31:0] ctrl, stat, htim, vtim, hvlen;
	wire hint, vint, vbsint, cbsint, luint, sint;
	wire hie, vie, vbsie, cbsie;
	wire acc, acc32, reg_acc, reg_wacc;
	wire cc0_acc, cc1_acc;
	wire [31:0] ccr0_dat_o, ccr1_dat_o;


	reg [31:0] reg_dato; // data output from registers

	//
	// Module body
	//

	assign acc      =  cyc_i & stb_i;
	assign acc32    = (sel_i == 4'b1111);
	assign clut_acc =  CLUT_ADR & acc & acc32;
	assign reg_acc  = ~CLUT_ADR & acc & acc32;
	assign reg_wacc =  reg_acc & we_i;

	assign cc0_acc  = (REG_ADR == CCR0_ADR) & acc & acc32;
	assign cc1_acc  = (REG_ADR == CCR1_ADR) & acc & acc32;

	always @(posedge clk_i)
	  ack_o <= ((reg_acc & acc32) | clut_ack) & ~(wbm_busy & REG_ADR == CTRL_ADR) & ~ack_o ;

	always @(posedge clk_i)
	  rty_o <= ((reg_acc & acc32) | clut_ack) & (wbm_busy & REG_ADR == CTRL_ADR) & ~rty_o ;

	always @(posedge clk_i)
	  err_o <= acc & ~acc32 & ~err_o;


	// generate registers
	always @(posedge clk_i or negedge arst_i)
	begin : gen_regs
	  if (!arst_i)
	    begin
	        htim       <= 0;
	        vtim       <= 0;
	        hvlen      <= 0;
	        VBARa      <= 0;
	        VBARb      <= 0;
	        cursor0_xy <= 0;
	        cursor0_ba <= 0;
	        cursor1_xy <= 0;
	        cursor1_ba <= 0;
	    end
	  else if (rst_i)
	    begin
	        htim       <= 0;
	        vtim       <= 0;
	        hvlen      <= 0;
	        VBARa      <= 0;
	        VBARb      <= 0;
	        cursor0_xy <= 0;
	        cursor0_ba <= 0;
	        cursor1_xy <= 0;
	        cursor1_ba <= 0;
	    end
	  else if (reg_wacc)
	    case (adr_i) // synopsis full_case parallel_case
	        HTIM_ADR  : htim       <= dat_i;
	        VTIM_ADR  : vtim       <= dat_i;
	        HVLEN_ADR : hvlen      <= dat_i;
	        VBARA_ADR : VBARa      <= dat_i[31: 2];
	        VBARB_ADR : VBARb      <= dat_i[31: 2];
	        C0XY_ADR  : cursor0_xy <= dat_i[31: 0];
	        C0BAR_ADR : cursor0_ba <= dat_i[31:11];
	        C1XY_ADR  : cursor1_xy <= dat_i[31: 0];
	        C1BAR_ADR : cursor1_ba <= dat_i[31:11];
	    endcase
	end

	always @(posedge clk_i)
	  begin
	     cursor0_ld <= reg_wacc && (adr_i == C0BAR_ADR);
	     cursor1_ld <= reg_wacc && (adr_i == C1BAR_ADR);
	  end

	// generate control register
	always @(posedge clk_i or negedge arst_i)
	  if (!arst_i)
	    ctrl <= 0;
	  else if (rst_i)
	    ctrl <= 0;
	  else if (reg_wacc & (REG_ADR == CTRL_ADR) & ~wbm_busy )
	    ctrl <= dat_i;
	  else begin
	    ctrl[6] <= ctrl[6] & !cbsint_in;
	    ctrl[5] <= ctrl[5] & !vbsint_in;
	  end


	// generate status register
	always @(posedge clk_i or negedge arst_i)
	  if (!arst_i)
	    stat <= 0;
	  else if (rst_i)
	    stat <= 0;
	  else begin
	    


	        stat[21] <= 1'b0;
	    
	    


	        stat[20] <= 1'b0;
	    

	    stat[17] <= acmp;
	    stat[16] <= avmp;

	    if (reg_wacc & (REG_ADR == STAT_ADR) )
	      begin
	          stat[7] <= cbsint_in | (stat[7] & !dat_i[7]);
	          stat[6] <= vbsint_in | (stat[6] & !dat_i[6]);
	          stat[5] <= hint_in   | (stat[5] & !dat_i[5]);
	          stat[4] <= vint_in   | (stat[4] & !dat_i[4]);
	          stat[1] <= luint_in  | (stat[3] & !dat_i[1]);
	          stat[0] <= sint_in   | (stat[0] & !dat_i[0]);
	      end
	    else
	      begin
	          stat[7] <= stat[7] | cbsint_in;
	          stat[6] <= stat[6] | vbsint_in;
	          stat[5] <= stat[5] | hint_in;
	          stat[4] <= stat[4] | vint_in;
	          stat[1] <= stat[1] | luint_in;
	          stat[0] <= stat[0] | sint_in;
	      end
	  end


	// decode control register
	assign dvi_odf     = ctrl[29:28];
	assign cursor1_res = ctrl[25];
	assign cursor1_en  = ctrl[24];
	assign cursor0_res = ctrl[23];
	assign cursor0_en  = ctrl[20];
	assign bl          = ctrl[15];
	assign csl         = ctrl[14];
	assign vsl         = ctrl[13];
	assign hsl         = ctrl[12];
	assign pc          = ctrl[11];
	assign cd          = ctrl[10:9];
	assign vbl         = ctrl[8:7];
	assign cbsw        = ctrl[6];
	assign vbsw        = ctrl[5];
	assign cbsie       = ctrl[4];
	assign vbsie       = ctrl[3];
	assign hie         = ctrl[2];
	assign vie         = ctrl[1];
	assign ven         = ctrl[0];

	// decode status register
	assign cbsint = stat[7];
	assign vbsint = stat[6];
	assign hint   = stat[5];
	assign vint   = stat[4];
	assign luint  = stat[1];
	assign sint   = stat[0];

	// decode Horizontal Timing Register
	assign Thsync = htim[31:24];
	assign Thgdel = htim[23:16];
	assign Thgate = htim[15:0];
	assign Thlen  = hvlen[31:16];

	// decode Vertical Timing Register
	assign Tvsync = vtim[31:24];
	assign Tvgdel = vtim[23:16];
	assign Tvgate = vtim[15:0];
	assign Tvlen  = hvlen[15:0];


	















		assign ccr0_dat_o = 32'h0;
		assign cc0_dat_o = 32'h0;
	

	















		assign ccr1_dat_o = 32'h0;
		assign cc1_dat_o = 32'h0;
	


	// assign output
	always @(REG_ADR or ctrl or stat or htim or vtim or hvlen or VBARa or VBARb or acmp or
		cursor0_xy or cursor0_ba or cursor1_xy or cursor1_ba or ccr0_dat_o or ccr1_dat_o)
	  casez (REG_ADR) // synopsis full_case parallel_case
	      CTRL_ADR  : reg_dato = ctrl;
	      STAT_ADR  : reg_dato = stat;
	      HTIM_ADR  : reg_dato = htim;
	      VTIM_ADR  : reg_dato = vtim;
	      HVLEN_ADR : reg_dato = hvlen;
	      VBARA_ADR : reg_dato = {VBARa, 2'b0};
	      VBARB_ADR : reg_dato = {VBARb, 2'b0};
	      C0XY_ADR  : reg_dato = cursor0_xy;
	      C0BAR_ADR : reg_dato = {cursor0_ba, 11'h0};
	      CCR0_ADR  : reg_dato = ccr0_dat_o;
	      C1XY_ADR  : reg_dato = cursor1_xy;
	      C1BAR_ADR : reg_dato = {cursor1_ba, 11'h0};
	      CCR1_ADR  : reg_dato = ccr1_dat_o;
	      default   : reg_dato = 32'h0000_0000;
	  endcase

	always @(posedge clk_i)
	  dat_o <= reg_acc ? reg_dato : {8'h0, clut_q};

	// generate interrupt request signal
	always @(posedge clk_i)
	  inta_o <= (hint & hie) | (vint & vie) | (vbsint & vbsie) | (cbsint & cbsie) | luint | sint;
endmodule



