//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's mem2reg alignment                                  ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  Two versions of Memory to register data alignment.          ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_mem2reg.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 
//
// Revision 1.5  2002/09/03 22:28:21  lampret
// As per Taylor Su suggestion all case blocks are full case by default and optionally (OR1200_CASE_DEFAULT) can be disabled to increase clock frequncy.
//
// Revision 1.4  2002/03/29 15:16:56  lampret
// Some of the warnings fixed.
//
// Revision 1.3  2002/03/28 19:14:10  lampret
// Changed define name from OR1200_MEM2REG_FAST to OR1200_IMPL_MEM2REG2
//
// Revision 1.2  2002/01/14 06:18:22  lampret
// Fixed mem2reg bug in FAST implementation. Updated debug unit to work with new genpc/if.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.9  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.8  2001/10/19 23:28:46  lampret
// Fixed some synthesis warnings. Configured with caches and MMUs.
//
// Revision 1.7  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.2  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.1  2001/07/20 00:46:03  lampret
// Development version of RTL. Libraries are missing.
//
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_mem2reg(addr, lsu_op, memdata, regdata);

parameter width = 32;

//
// I/O
//
input	[1:0]			addr;
input	[4-1:0]	lsu_op;
input	[width-1:0]		memdata;
output	[width-1:0]		regdata;


//
// In the past faster implementation of mem2reg (today probably slower)
//


















































































































































































































































































//
// Straightforward implementation of mem2reg
//

reg	[width-1:0]		regdata;
reg	[width-1:0]		aligned;

//
// Alignment
//
always @(addr or memdata) begin



	case(addr) // synopsys parallel_case

		2'b00:
			aligned = memdata;
		2'b01:
			aligned = {memdata[23:0], 8'b0};
		2'b10:
			aligned = {memdata[15:0], 16'b0};
		2'b11:
			aligned = {memdata[7:0], 24'b0};
	endcase
end

//
// Bytes
//
always @(lsu_op or aligned) begin



	case(lsu_op) // synopsys parallel_case

		4'b0010: begin
				regdata[7:0] = aligned[31:24];
				regdata[31:8] = 24'b0;
			end
		4'b0011: begin
				regdata[7:0] = aligned[31:24];
				regdata[31:8] = {24{aligned[31]}};
			end
		4'b0100: begin
				regdata[15:0] = aligned[31:16];
				regdata[31:16] = 16'b0;
			end
		4'b0101: begin
				regdata[15:0] = aligned[31:16];
				regdata[31:16] = {16{aligned[31]}};
			end
		default:
				regdata = aligned;
	endcase
end



endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's instruction fetch                                  ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  PC, instruction fetch, interface to IC.                     ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_if.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_if(
	// Clock and reset
	clk, rst,

	// External i/f to IC
	icpu_dat_i, icpu_ack_i, icpu_err_i, icpu_adr_i, icpu_tag_i,

	// Internal i/f
	if_freeze, if_insn, if_pc, if_flushpipe, saving_if_insn, 
	if_stall, no_more_dslot, genpc_refetch, rfe,
	except_itlbmiss, except_immufault, except_ibuserr
);

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// External i/f to IC
//
input	[31:0]			icpu_dat_i;
input				icpu_ack_i;
input				icpu_err_i;
input	[31:0]			icpu_adr_i;
input	[3:0]			icpu_tag_i;

//
// Internal i/f
//
input				if_freeze;
output	[31:0]			if_insn;
output	[31:0]			if_pc;
input				if_flushpipe;
output				saving_if_insn;
output				if_stall;
input				no_more_dslot;
output				genpc_refetch;
input				rfe;
output				except_itlbmiss;
output				except_immufault;
output				except_ibuserr;

//
// Internal wires and regs
//
wire			save_insn;
wire			if_bypass;
reg			if_bypass_reg;
reg	[31:0]		insn_saved;
reg	[31:0]		addr_saved;
reg	[2:0]		err_saved;
reg			saved;

assign save_insn = (icpu_ack_i | icpu_err_i) & if_freeze & !saved;
assign saving_if_insn = !if_flushpipe & save_insn;

//
// IF bypass 
//
assign if_bypass = icpu_adr_i[0] ? 1'b0 : if_bypass_reg | if_flushpipe;

always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		if_bypass_reg <=  1'b0;
	else
		if_bypass_reg <=  if_bypass;

//
// IF stage insn
//
assign if_insn = no_more_dslot | rfe | if_bypass ? {6'b000101, 26'h041_0000} : saved ? insn_saved : icpu_ack_i ? icpu_dat_i : {6'b000101, 26'h061_0000};
assign if_pc = saved ? addr_saved : {icpu_adr_i[31:2], 2'h0};
assign if_stall = !icpu_err_i & !icpu_ack_i & !saved;
assign genpc_refetch = saved & icpu_ack_i;
assign except_itlbmiss = no_more_dslot ? 1'b0 : saved ? err_saved[0] : icpu_err_i & (icpu_tag_i == 4'hd);
assign except_immufault = no_more_dslot ? 1'b0 : saved ? err_saved[1] : icpu_err_i & (icpu_tag_i == 4'hc);
assign except_ibuserr = no_more_dslot ? 1'b0 : saved ? err_saved[2] : icpu_err_i & (icpu_tag_i == 4'hb);

//
// Flag for saved insn/address
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		saved <=  1'b0;
	else if (if_flushpipe)
		saved <=  1'b0;
	else if (save_insn)
		saved <=  1'b1;
	else if (!if_freeze)
		saved <=  1'b0;

//
// Store fetched instruction
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		insn_saved <=  {6'b000101, 26'h041_0000};
	else if (if_flushpipe)
		insn_saved <=  {6'b000101, 26'h041_0000};
	else if (save_insn)
		insn_saved <=  icpu_err_i ? {6'b000101, 26'h041_0000} : icpu_dat_i;
	else if (!if_freeze)
		insn_saved <=  {6'b000101, 26'h041_0000};

//
// Store fetched instruction's address
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		addr_saved <=  32'h00000000;
	else if (if_flushpipe)
		addr_saved <=  32'h00000000;
	else if (save_insn)
		addr_saved <=  {icpu_adr_i[31:2], 2'b00};
	else if (!if_freeze)
		addr_saved <=  {icpu_adr_i[31:2], 2'b00};

//
// Store fetched instruction's error tags 
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		err_saved <=  3'b000;
	else if (if_flushpipe)
		err_saved <=  3'b000;
	else if (save_insn) begin
		err_saved[0] <=  icpu_err_i & (icpu_tag_i == 4'hd);
		err_saved[1] <=  icpu_err_i & (icpu_tag_i == 4'hc);
		err_saved[2] <=  icpu_err_i & (icpu_tag_i == 4'hb);
	end
	else if (!if_freeze)
		err_saved <=  3'b000;


endmodule
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
////  interface it also provides behavioral model of generic      ////
////  single-port synchronous RAM.                                ////
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
////  - Xilinx Virtex RAMB16                                      ////
////  - Xilinx Virtex RAMB4                                       ////
////  - Altera LPM                                                ////
////                                                              ////
////  To Do:                                                      ////
////   - xilinx rams need external tri-state logic                ////
////   - fix avant! two-port ram                                  ////
////   - add additional RAMs                                      ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_spram_1024x8.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//
// Revision 1.9  2005/10/19 11:37:56  jcastillo
// Added support for RAMB16 Xilinx4/Spartan3 primitives
//
// Revision 1.8  2004/06/08 18:15:32  lampret
// Changed behavior of the simulation generic models
//
// Revision 1.7  2004/04/05 08:29:57  lampret
// Merged branch_qmem into main tree.
//
// Revision 1.3.4.1  2003/12/09 11:46:48  simons
// Mbist nameing changed, Artisan ram instance signal names fixed, some synthesis waning fixed.
//
// Revision 1.3  2003/04/07 01:19:07  lampret
// Added Altera LPM RAMs. Changed generic RAM output when OE inactive.
//
// Revision 1.2  2002/10/17 20:04:40  lampret
// Added BIST scan. Special VS RAMs need to be used to implement BIST.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.8  2001/11/02 18:57:14  lampret
// Modified virtual silicon instantiations.
//
// Revision 1.7  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.6  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.1  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.2  2001/07/30 05:38:02  lampret
// Adding empty directories required by HDL coding guidelines
//
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_spram_1024x8(




	// Generic synchronous single-port RAM interface
	clk, rst, ce, we, oe, addr, di, doq
);

//
// Default address and data buses width
//
parameter aw = 10;
parameter dw = 8;










//
// Generic synchronous single-port RAM interface
//
input			clk;	// Clock
input			rst;	// Reset
input			ce;	// Chip enable input
input			we;	// Write enable input
input			oe;	// Output enable input
input 	[aw-1:0]	addr;	// address bus inputs
input	[dw-1:0]	di;	// input data bus
output	[dw-1:0]	doq;	// output data bus

//
// Internal wires and registers
//




















































































































































































































//
// Generic single-port synchronous RAM model
//

//
// Generic RAM's registers and wires
//
reg	[dw-1:0]	mem [(1<<aw)-1:0];	// RAM content
reg	[aw-1:0]	addr_reg;		// RAM address register

//
// Data output drivers
//
assign doq = (oe) ? mem[addr_reg] : {dw{1'b0}};

//
// RAM address register
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		addr_reg <=  {aw{1'b0}};
	else if (ce)
		addr_reg <=  addr;

//
// RAM write
//
always @(posedge clk)
	if (ce && we)
		mem[addr] <=  di;

	// !OR1200_ALTERA_LPM
	// !OR1200_XILINX_RAMB16
	// !OR1200_XILINX_RAMB4
	// !OR1200_VIRTUALSILICON_SSP
	// !OR1200_VIRAGE_SSP
	// !OR1200_AVANT_ATP
	// !OR1200_ARTISAN_SSP

endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's DC FSM                                             ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Data cache state machine                                    ////
////                                                              ////
////  To Do:                                                      ////
////   - Test error during line read or write                     ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////      - Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000, 2010 Authors and OPENCORES.ORG           ////
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
// $Log: or1200_dc_fsm.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed. 
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 












//
// Data cache FSM for cache line of 16 bytes (4x singleword)
//

module or1200_dc_fsm
  (
   // Clock and reset
   clk, rst,
   
   // Internal i/f to top level DC
   dc_en, dcqmem_cycstb_i, dcqmem_ci_i, dcqmem_we_i, dcqmem_sel_i,
   tagcomp_miss, biudata_valid, biudata_error, lsu_addr,
   dcram_we, biu_read, biu_write, biu_do_sel, dcram_di_sel, first_hit_ack, 
   first_miss_ack, first_miss_err, burst, tag_we, tag_valid, dc_addr, 
   dc_no_writethrough, tag_dirty, dirty, tag, tag_v, dc_block_flush, 
   dc_block_writeback, spr_dat_i, mtspr_dc_done, spr_cswe
   );

   //
   // I/O
   //
   input				clk;
   input				rst;
   input				dc_en;
   input				dcqmem_cycstb_i;
   input				dcqmem_ci_i;
   input				dcqmem_we_i;
   input [3:0] 				dcqmem_sel_i;
   input				tagcomp_miss;
   input				biudata_valid;
   input				biudata_error;
   input [31:0] 			lsu_addr;
   output [3:0] 			dcram_we;
   output				biu_read;
   output				biu_write;
   output 				dcram_di_sel;
   output 				biu_do_sel;
   output				first_hit_ack;
   output				first_miss_ack;
   output				first_miss_err;
   output				burst;
   output				tag_we;
   output 				tag_valid;
   output [31:0] 			dc_addr;
   input 				dc_no_writethrough;
   output 				tag_dirty;
   input 				dirty;
   input [20-2:0] 		tag;
   input 				tag_v;   
   input 				dc_block_flush;
   input 				dc_block_writeback;
   input [31:0] 			spr_dat_i;
   output 				mtspr_dc_done;
   input 				spr_cswe;
   
   
   //
   // Internal wires and regs
   //
   reg [31:0] 				addr_r;
   reg [2:0] 				state;
   reg [4-1:0] 		cnt;
   reg 					hitmiss_eval;
   reg 					store;
   reg 					load;
   reg 					cache_inhibit;
   reg 					cache_miss;
   reg 					cache_dirty_needs_writeback;
   reg                                  did_early_load_ack;
   reg 					cache_spr_block_flush;
   reg 					cache_spr_block_writeback;
   reg 					cache_wb;   
   wire 				load_hit_ack;
   wire 				load_miss_ack;
   wire 				load_inhibit_ack;   
   wire 				store_hit_ack;
   wire 				store_hit_writethrough_ack;   
   wire 				store_miss_writethrough_ack;   
   wire 				store_inhibit_ack;
   wire 				store_miss_ack;
   wire 				dcram_we_after_line_load;
   wire 				dcram_we_during_line_load;
   wire 				tagram_we_end_of_loadstore_loop;
   wire 				tagram_dirty_bit_set;   
   wire 				writethrough;
   wire 				cache_inhibit_with_eval;
   wire [(4-1)-2:0]		next_addr_word;

   //
   // Cache inhibit
   //
   
   // Indicates whether cache is inhibited, during hitmiss_eval and after
   assign cache_inhibit_with_eval = (hitmiss_eval & dcqmem_ci_i) |
				    (!hitmiss_eval & cache_inhibit);
   
   //
   // Generate of DCRAM write enables
   //

   // WE when non-writethrough, and had to wait for a line to load.
   assign dcram_we_after_line_load = (state == 3'd3) &
				    dcqmem_we_i & !cache_dirty_needs_writeback &
				     !did_early_load_ack;

   // WE when receiving the data cache line
   assign dcram_we_during_line_load = (state == 3'd2) & load & 
				      biudata_valid;   
   
   assign dcram_we =(// Write when hit - make sure it is only when hit - could
		     // maybe be doing write through and don't want to corrupt
		     // cache lines corresponding to the writethrough addr_r.
		     ({4{store_hit_ack | store_hit_writethrough_ack}} |
		     // Write after load of line
		     {4{dcram_we_after_line_load}}) & 
		     dcqmem_sel_i		 ) |
		    // Write during load
		    {4{dcram_we_during_line_load}};

   //
   // Tag RAM signals
   //
   
   // WE to tag RAM when we finish loading a line.
   assign tagram_we_end_of_loadstore_loop = ((state==3'd2) & 
					     biudata_valid & !(|cnt));
   


















 



   // Lines will never be dirty if always writethrough
   assign tagram_dirty_bit_set = 0;
 
   
   assign mtspr_dc_done = 1'b1;
   


   assign tag_dirty = tagram_dirty_bit_set;
   
   // WE to tag RAM
   assign tag_we = tagram_we_end_of_loadstore_loop |		    
                    tagram_dirty_bit_set | (state == 3'd6);
   

   // Valid bit
   // Set valid when end of line load, or marking dirty (is still valid)
   assign tag_valid = ( tagram_we_end_of_loadstore_loop & 
			(load | (store & cache_spr_block_writeback)) ) |
		      tagram_dirty_bit_set;


   
   //
   // BIU read and write
   //

   assign biu_read = // Bus read request when:
		     // 1) Have a miss and not dirty or a load with inhibit
		     ((state == 3'd1) &
		      (((hitmiss_eval & tagcomp_miss & !dirty & 
			 !(store & writethrough)) | 
			(load & cache_inhibit_with_eval)) & dcqmem_cycstb_i)) |
		     // 2) In the loop and loading
		     ((state == 3'd2) & load);
   

   assign biu_write = // Bus write request when:
		      // 1) Have a miss and dirty or store with inhibit
		      ((state == 3'd1) & 
		       (((hitmiss_eval & tagcomp_miss & dirty) | 
			 (store & writethrough)) | 
			(store & cache_inhibit_with_eval)) & dcqmem_cycstb_i) |
		      // 2) In the loop and storing
		      ((state == 3'd2) & store);
   
   //
   // Select for data to actual cache RAM (from LSU or BIU)
   //
   // Data to DCRAM - from external bus when loading (from IU when store)
   assign dcram_di_sel = load;
   // Data to external bus - always from IU except in case of bursting back
   //                        the line to memory. (1 selects DCRAM)
   assign biu_do_sel = (state == 3'd2) & store;

   // 3-bit wire for calculating next word of burst write, depending on
   // line size of data cache.
   assign next_addr_word =  addr_r[4-1:2] + 1;
   
   // Address to cache RAM (tag address also derived from this)   
   assign dc_addr =
		   // First check if we've got a block flush or WB op
		   ((dc_block_flush & !cache_spr_block_flush) | 
		   (dc_block_writeback & !cache_spr_block_writeback)) ? 
		   spr_dat_i :
		   (state==3'd5) ? addr_r:
		    // If no SPR action, then always put out address from LSU
		    (state==3'd0 | hitmiss_eval) ? lsu_addr :
		    // Next, if in writeback loop, when ACKed must immediately
		    // output next word address (the RAM address takes a cycle
		    // to increment, but it's needed immediately for burst)
		    // otherwise, output our registered address.
		    (state==3'd2 & biudata_valid & store ) ? 
		    {addr_r[31:4], next_addr_word, 2'b00} : addr_r;
   

 


   assign writethrough = 1;
 



   
   //
   // ACK generation for LSU
   //
   
   // ACK for when it's a cache hit
   assign first_hit_ack = load_hit_ack | store_hit_ack | 
			  store_hit_writethrough_ack | 
			  store_miss_writethrough_ack |
			  store_inhibit_ack | store_miss_ack ;

   // ACK for when it's a cache miss - load only, is used in MUX for data back
   //                                  LSU straight off external data bus. In
   //                                  this was is also used for cache inhibit
   //                                  loads.
   // first_hit_ack takes precedence over first_miss_ack
   assign first_miss_ack = ~first_hit_ack & (load_miss_ack | load_inhibit_ack);
   
   // ACK cache hit on load
   assign load_hit_ack = (state == 3'd1) & 
			 hitmiss_eval & !tagcomp_miss & !dcqmem_ci_i & load;
   
   // ACK cache hit on store, no writethrough
   assign store_hit_ack = (state == 3'd1) & 
			  hitmiss_eval  & !tagcomp_miss & !dcqmem_ci_i &
			  store & !writethrough;
   
   // ACK cache hit on store with writethrough
   assign store_hit_writethrough_ack = (state == 3'd1) & 
				       !cache_miss & !cache_inhibit &
				       store & writethrough & biudata_valid;
   
   // ACK cache miss on store with writethrough
   assign store_miss_writethrough_ack = (state == 3'd1) & 
					cache_miss & !cache_inhibit &
					store & writethrough & biudata_valid;
      
   // ACK store when cacheinhibit
   assign store_inhibit_ack = (state == 3'd1) &
			      store & cache_inhibit & biudata_valid;
   
   
   // Get the _early_ ack on first ACK back from wishbone during load only
   // Condition is that we're in the loop - that it's the first ack we get (can
   // tell from value of cnt), and we're loading a line to read from it (not
   // loading to write to it, in the case of a write without writethrough.)
   assign load_miss_ack =  ((state== 3'd2) & load &
			    (cnt==((1 << 4) - 4)) & biudata_valid & 
			    !(dcqmem_we_i & !writethrough));
   
   assign load_inhibit_ack = (state == 3'd1) &
			     load & cache_inhibit & biudata_valid;   
   
   // This will be case of write through disabled, and had to load a line.
   assign store_miss_ack = dcram_we_after_line_load;
            
   assign first_miss_err = biudata_error & dcqmem_cycstb_i;

   // Signal burst when in the load/store loop. We will always try to burst.
   assign burst = (state == 3'd2);

   //
   // Main DC FSM
   //
   always @(posedge clk or posedge rst) begin
      if (rst == (1'b1)) begin
	 state <=  3'd0;
	 addr_r <=  32'd0;
	 hitmiss_eval <=  1'b0;
	 store <=  1'b0;
	 load <=  1'b0;
	 cnt <=  4'd0;
         cache_miss <=  1'b0;
	 cache_dirty_needs_writeback <= 1'b0;
	 cache_inhibit <=  1'b0;
	 did_early_load_ack <= 1'b0;
	 cache_spr_block_flush <= 1'b0;
	 cache_spr_block_writeback <= 1'b0;
      end
      else
	case (state)	// synopsys parallel_case
	  
          3'd0 : begin
	     if (dc_en & (dc_block_flush | dc_block_writeback))
	       begin
		  cache_spr_block_flush <= dc_block_flush;
		  cache_spr_block_writeback <= dc_block_writeback;
		  hitmiss_eval <= 1'b1;
		  state <= 3'd5;
		  addr_r <=  spr_dat_i;
	       end
	     else if (dc_en & dcqmem_cycstb_i)
	       begin
		  state <= 3'd1;
		  hitmiss_eval <=  1'b1;
		  store <=  dcqmem_we_i;
		  load <=  !dcqmem_we_i;
	       end
	     
	     
          end // case: `OR1200_DCFSM_IDLE
	  
          3'd1: begin
	     hitmiss_eval <=  1'b0;
	     if (hitmiss_eval) begin
                cache_inhibit <=  dcqmem_ci_i; // Check for cache inhibit here
                cache_miss <=  tagcomp_miss;
		cache_dirty_needs_writeback <= dirty;
		addr_r <=  lsu_addr;
             end

	     // Evaluate any cache line load/stores in first cycle:
			     //
	     if (hitmiss_eval & tagcomp_miss & !(store & writethrough) &
		 !dcqmem_ci_i)
	       begin
		  // Miss - first either:
		  //  1) write back dirty line 
		  if (dirty) begin
		     // Address for writeback
		     addr_r <=  {tag, lsu_addr[13-1:2],2'd0};
		     load <= 1'b0;
		     store <= 1'b1;



		  end
		  //  2) load requested line
		  else begin
		     addr_r <=  lsu_addr;
		     load <= 1'b1;
		     store <= 1'b0;
		  end // else: !if(dirty)
		  state <= 3'd2;		  
		  // Set the counter for the burst accesses
		  cnt <=  ((1 << 4) - 4);
	       end
             else if (// Strobe goes low
		      !dcqmem_cycstb_i |
		      // Cycle finishes
		      (!hitmiss_eval & (biudata_valid | biudata_error)) |
		      // Cache hit in first cycle....
		      (hitmiss_eval & !tagcomp_miss & !dcqmem_ci_i &
		      // .. and you're not doing a writethrough store..
		      !(store & writethrough))) begin
                state <=  3'd0;
                load <=  1'b0;
		store <= 1'b0;
		cache_inhibit <= 1'b0;
		cache_dirty_needs_writeback <= 1'b0;
             end	     
          end // case: `OR1200_DCFSM_CLOADSTORE	  
	  
          3'd2 : begin // loop/abort	     
             if (!dc_en| biudata_error) begin
                state <=  3'd0;
                load <=  1'b0;
		store <= 1'b0;
		cnt <= 4'd0;
             end
             if (biudata_valid & (|cnt)) begin
                cnt <=  cnt - 4;
                addr_r[4-1:2] <=  addr_r[4-1:2] + 1;
             end
	     else if (biudata_valid & !(|cnt)) begin
		state <= 3'd3;
		addr_r <=  lsu_addr;
		load <= 1'b0;
		store <= 1'b0;
	     end

	     // Track if we did an early ack during a load
	     if (load_miss_ack)
	       did_early_load_ack <= 1'b1;
	     

          end // case: `OR1200_DCFSM_LOOP2
	  
	  3'd3: begin // figure out next step
	     if (cache_dirty_needs_writeback) begin
		// Just did store of the dirty line so now load new one
		load <= 1'b1;
		// Set the counter for the burst accesses
		cnt <=  ((1 << 4) - 4);
		// Address of line to be loaded
		addr_r <=  lsu_addr;
		cache_dirty_needs_writeback <= 1'b0;
		state <= 3'd2;
	     end // if (cache_dirty_needs_writeback)
	     else if (cache_spr_block_flush | cache_spr_block_writeback) begin
		// Just wrote back the line to memory, we're finished.
		cache_spr_block_flush <= 1'b0;
		cache_spr_block_writeback <= 1'b0;
		state <= 3'd7;
	     end
	     else begin
		// Just loaded a new line, finish up
		did_early_load_ack <= 1'b0;
		state <= 3'd4;
	     end
	  end // case: `OR1200_DCFSM_LOOP3

	  3'd4: begin
	     state <=  3'd0;
	  end

	  3'd5: begin
	     hitmiss_eval <= 1'b0;
	     if (hitmiss_eval & !tag_v)
	       begin
		  // Not even cached, just ignore
		  cache_spr_block_flush <= 1'b0;
		  cache_spr_block_writeback <= 1'b0;
		  state <=  3'd7;
	       end
	     else if (hitmiss_eval & tag_v)
	       begin
		  // Tag is valid - what do we do?
		  if ((cache_spr_block_flush | cache_spr_block_writeback) & 
		      dirty) begin
		     // Need to writeback
		     // Address for writeback (spr_dat_i has already changed so
		     // use line number from addr_r)
		     addr_r <=  {tag, addr_r[13-1:2],2'd0};
		     load <= 1'b0;
		     store <= 1'b1;



		     state <= 3'd2;		  
		     // Set the counter for the burst accesses
		     cnt <=  ((1 << 4) - 4);
		  end
		  else if (cache_spr_block_flush & !dirty)
		    begin
		       // Line not dirty, just need to invalidate
		       state <=  3'd6;
		    end // else: !if(dirty)
		  else if (cache_spr_block_writeback & !dirty)
		    begin
		       // Nothing to do - line is valid but not dirty
		       cache_spr_block_writeback <= 1'b0;
		       state <=  3'd7;
		    end
	  end // if (hitmiss_eval & tag_v)
	  end
	  3'd6: begin
	     cache_spr_block_flush <= 1'b0;
	     // Wait until SPR CS goes low before going back to idle
	     if (!spr_cswe)
	       state <=  3'd0;
	  end
	  3'd7: begin
	     // Wait until SPR CS goes low before going back to idle
	     if (!spr_cswe)
	       state <=  3'd0;
	  end

	endcase // case (state)
      
   end // always @ (posedge clk or `OR1200_RST_EVENT rst)
   

endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Generic Double-Port Synchronous RAM                         ////
////                                                              ////
////  This file is part of memory library available from          ////
////  http://www.opencores.org/cvsweb.shtml/generic_memories/     ////
////                                                              ////
////  Description                                                 ////
////  This block is a wrapper with common double-port             ////
////  synchronous memory interface for different                  ////
////  types of ASIC and FPGA RAMs. Beside universal memory        ////
////  interface it also provides behavioral model of generic      ////
////  double-port synchronous RAM.                                ////
////  It should be used in all OPENCORES designs that want to be  ////
////  portable accross different target technologies and          ////
////  independent of target memory.                               ////
////                                                              ////
////  Supported ASIC RAMs are:                                    ////
////                                                              ////
////  Supported FPGA RAMs are:                                    ////
////  - Xilinx Virtex RAMB16                                      ////
////  - Xilinx Virtex RAMB4                                       ////
////                                                              ////
////  To Do:                                                      ////
////   - add additional RAMs                                      ////
////   - xilinx rams need external tri-state logic                ////
////                                                              ////
////  Author(s):                                                  ////
////      - Nir  Mor, nirm@opencores.org                          ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2005 Authors and OPENCORES.ORG                 ////
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
// $Log: or1200_dpram_256x32.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// New
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_dpram_256x32(
	// Generic synchronous double-port RAM interface
	clk_a, rst_a, ce_a, oe_a, addr_a, do_a,
	clk_b, rst_b, ce_b, we_b, addr_b, di_b
);

//
// Default address and data buses width
//
parameter aw = 8;
parameter dw = 32;

//
// Generic synchronous double-port RAM interface
//
input			clk_a;	// Clock
input			rst_a;	// Reset
input			ce_a;	// Chip enable input
input			oe_a;	// Output enable input
input 	[aw-1:0]	addr_a;	// address bus inputs
output	[dw-1:0]	do_a;	// output data bus
input			clk_b;	// Clock
input			rst_b;	// Reset
input			ce_b;	// Chip enable input
input			we_b;	// Write enable input
input 	[aw-1:0]	addr_b;	// address bus inputs
input	[dw-1:0]	di_b;	// input data bus
























































































//
// Generic double-port synchronous RAM model
//

//
// Generic RAM's registers and wires
//
reg	[dw-1:0]	mem [(1<<aw)-1:0];	// RAM content
reg	[aw-1:0]	addr_a_reg;		// RAM address registered

//
// Data output drivers
//
assign do_a = (oe_a) ? mem[addr_a_reg] : {dw{1'b0}};

//
// RAM read
//
always @(posedge clk_a or posedge rst_a)
	if (rst_a == (1'b1))
		addr_a_reg <=  {aw{1'b0}};
	else if (ce_a)
		addr_a_reg <=  addr_a;

//
// RAM write
//
always @(posedge clk_b)
	if (ce_b && we_b)
		mem[addr_b] <=  di_b;

	// !OR1200_XILINX_RAMB16
	// !OR1200_XILINX_RAMB4
endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's interface to SPRs                                  ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Decoding of SPR addresses and access to SPRs                ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_sprs.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_sprs(
		   // Clk & Rst
		   clk, rst,

		   // Internal CPU interface
		   flagforw, flag_we, flag, cyforw, cy_we, carry,
		   ovforw, ov_we, dsx,
		   addrbase, addrofs, dat_i, branch_op, ex_spr_read, 
		   ex_spr_write, 
		   epcr, eear, esr, except_started,
		   to_wbmux, epcr_we, eear_we, esr_we, pc_we, sr_we, to_sr, sr,
		   spr_dat_cfgr, spr_dat_rf, spr_dat_npc, spr_dat_ppc, 
		   spr_dat_mac,
		   
		   boot_adr_sel_i,

		   // Floating point SPR input
		   fpcsr, fpcsr_we, spr_dat_fpu,

		   // From/to other RISC units
		   spr_dat_pic, spr_dat_tt, spr_dat_pm,
		   spr_dat_dmmu, spr_dat_immu, spr_dat_du,
		   spr_addr, spr_dat_o, spr_cs, spr_we,

		   du_addr, du_dat_du, du_read,
		   du_write, du_dat_cpu

		   );

   parameter width = 32;

   //
   // I/O Ports
   //

   //
   // Internal CPU interface
   //
   input				clk; 		// Clock
   input 				rst;		// Reset
   input 				flagforw;	// From ALU
   input 				flag_we;	// From ALU
   output 				flag;		// SR[F]
   input 				cyforw;		// From ALU
   input 				cy_we;		// From ALU
   output 				carry;		// SR[CY]
   input 				ovforw;		// From ALU
   input 				ov_we;		// From ALU
   input                                dsx;            // From except
   input [width-1:0] 			addrbase;	// SPR base address
   input [15:0] 			addrofs;	// SPR offset
   input [width-1:0] 			dat_i;		// SPR write data
   input 				ex_spr_read;	// l.mfspr in EX
   input 				ex_spr_write;	// l.mtspr in EX
   input [3-1:0] 	branch_op;	// Branch operation
   input [width-1:0] 			epcr /* verilator public */;// EPCR0
   input [width-1:0] 			eear /* verilator public */;// EEAR0
   input [17-1:0] 	esr /* verilator public */; // ESR0
   input 				except_started; // Exception was started
   output [width-1:0] 			to_wbmux;	// For l.mfspr
   output				epcr_we;	// EPCR0 write enable
   output				eear_we;	// EEAR0 write enable
   output				esr_we;		// ESR0 write enable
   output				pc_we;		// PC write enable
   output 				sr_we;		// Write enable SR
   output [17-1:0] 	to_sr;		// Data to SR
   output [17-1:0] 	sr /* verilator public */;// SR
   input [31:0] 			spr_dat_cfgr;	// Data from CFGR
   input [31:0] 			spr_dat_rf;	// Data from RF
   input [31:0] 			spr_dat_npc;	// Data from NPC
   input [31:0] 			spr_dat_ppc;	// Data from PPC   
   input [31:0] 			spr_dat_mac;	// Data from MAC
   input				boot_adr_sel_i;

   input [12-1:0] 	fpcsr;	// FPCSR
   output 				fpcsr_we;	// Write enable FPCSR   
   input [31:0] 			spr_dat_fpu;    // Data from FPU
   
   //
   // To/from other RISC units
   //
   input [31:0] 			spr_dat_pic;	// Data from PIC
   input [31:0] 			spr_dat_tt;	// Data from TT
   input [31:0] 			spr_dat_pm;	// Data from PM
   input [31:0] 			spr_dat_dmmu;	// Data from DMMU
   input [31:0] 			spr_dat_immu;	// Data from IMMU
   input [31:0] 			spr_dat_du;	// Data from DU
   output [31:0] 			spr_addr;	// SPR Address
   output [31:0] 			spr_dat_o;	// Data to unit
   output [31:0] 			spr_cs;		// Unit select
   output				spr_we;		// SPR write enable

   //
   // To/from Debug Unit
   //
   input [width-1:0] 			du_addr;	// Address
   input [width-1:0] 			du_dat_du;	// Data from DU to SPRS
   input				du_read;	// Read qualifier
   input				du_write;	// Write qualifier
   output [width-1:0] 			du_dat_cpu;	// Data from SPRS to DU

   //
   // Internal regs & wires
   //
   reg [17-1:0] 		sr_reg;		// SR
   reg 					sr_reg_bit_eph;	// SR_EPH bit
   reg 					sr_reg_bit_eph_select;// SR_EPH select
   wire 				sr_reg_bit_eph_muxed;// SR_EPH muxed bit
   reg [17-1:0] 		sr;			// SR
   reg [width-1:0] 			to_wbmux;	// For l.mfspr
   wire 				cfgr_sel;	// Select for cfg regs
   wire 				rf_sel;		// Select for RF
   wire 				npc_sel;	// Select for NPC
   wire 				ppc_sel;	// Select for PPC
   wire 				sr_sel;		// Select for SR	
   wire 				epcr_sel;	// Select for EPCR0
   wire 				eear_sel;	// Select for EEAR0
   wire 				esr_sel;	// Select for ESR0
   wire 				fpcsr_sel;	// Select for FPCSR   
   wire [31:0] 				sys_data;// Read data from system SPRs
   wire 				du_access;// Debug unit access
   reg [31:0] 				unqualified_cs;	// Unqualified selects
//    wire 				ex_spr_write; // jb
   
   //
   // Decide if it is debug unit access
   //
   assign du_access = du_read | du_write;

   //
   // Generate SPR address from base address and offset
   // OR from debug unit address
   //
   assign spr_addr = du_access ? du_addr : (addrbase | {16'h0000, addrofs});

   //
   // SPR is written by debug unit or by l.mtspr
   //
   assign spr_dat_o = du_write ? du_dat_du : dat_i;

   //
   // debug unit data input:
   //  - read of SPRS by debug unit
   //  - write into debug unit SPRs by debug unit itself
   //  - write into debug unit SPRs by l.mtspr
   //
   assign du_dat_cpu = du_read ? to_wbmux : du_write ? du_dat_du : dat_i;

   //
   // Write into SPRs when DU or l.mtspr
   //
   assign spr_we = du_write | ( ex_spr_write & !du_access );


   //
   // Qualify chip selects
   //
   assign spr_cs = unqualified_cs & {32{du_read | du_write | ex_spr_read | 
					(ex_spr_write & sr[0])}};

   //
   // Decoding of groups
   //
   always @(spr_addr)
     case (spr_addr[15:11])	// synopsys parallel_case
       5'd00: unqualified_cs 
	 = 32'b00000000_00000000_00000000_00000001;
       5'd01: unqualified_cs 
	 = 32'b00000000_00000000_00000000_00000010;
       5'd02: unqualified_cs 
	 = 32'b00000000_00000000_00000000_00000100;
       5'd03: unqualified_cs 
	 = 32'b00000000_00000000_00000000_00001000;
       5'd04: unqualified_cs 
	 = 32'b00000000_00000000_00000000_00010000;
       5'd05: unqualified_cs 
	 = 32'b00000000_00000000_00000000_00100000;
       5'd06: unqualified_cs 
	 = 32'b00000000_00000000_00000000_01000000;
       5'd07: unqualified_cs 
	 = 32'b00000000_00000000_00000000_10000000;
       5'd08: unqualified_cs 
	 = 32'b00000000_00000000_00000001_00000000;
       5'd09: unqualified_cs 
	 = 32'b00000000_00000000_00000010_00000000;
       5'd10: unqualified_cs 
	 = 32'b00000000_00000000_00000100_00000000;
       5'd11: unqualified_cs 
	 = 32'b00000000_00000000_00001000_00000000;
       5'd12: unqualified_cs 
	 = 32'b00000000_00000000_00010000_00000000;
       5'd13: unqualified_cs 
	 = 32'b00000000_00000000_00100000_00000000;
       5'd14: unqualified_cs 
	 = 32'b00000000_00000000_01000000_00000000;
       5'd15: unqualified_cs 
	 = 32'b00000000_00000000_10000000_00000000;
       5'd16: unqualified_cs 
	 = 32'b00000000_00000001_00000000_00000000;
       5'd17: unqualified_cs 
	 = 32'b00000000_00000010_00000000_00000000;
       5'd18: unqualified_cs 
	 = 32'b00000000_00000100_00000000_00000000;
       5'd19: unqualified_cs 
	 = 32'b00000000_00001000_00000000_00000000;
       5'd20: unqualified_cs 
	 = 32'b00000000_00010000_00000000_00000000;
       5'd21: unqualified_cs 
	 = 32'b00000000_00100000_00000000_00000000;
       5'd22: unqualified_cs 
	 = 32'b00000000_01000000_00000000_00000000;
       5'd23: unqualified_cs 
	 = 32'b00000000_10000000_00000000_00000000;
       5'd24: unqualified_cs 
	 = 32'b00000001_00000000_00000000_00000000;
       5'd25: unqualified_cs 
	 = 32'b00000010_00000000_00000000_00000000;
       5'd26: unqualified_cs 
	 = 32'b00000100_00000000_00000000_00000000;
       5'd27: unqualified_cs 
	 = 32'b00001000_00000000_00000000_00000000;
       5'd28: unqualified_cs 
	 = 32'b00010000_00000000_00000000_00000000;
       5'd29: unqualified_cs 
	 = 32'b00100000_00000000_00000000_00000000;
       5'd30: unqualified_cs 
	 = 32'b01000000_00000000_00000000_00000000;
       5'd31: unqualified_cs 
	 = 32'b10000000_00000000_00000000_00000000;
     endcase

   //
   // SPRs System Group
   //

   //
   // What to write into SR
   //
   assign to_sr[15:12] 
	    = (except_started) ? {sr[15:14],dsx,1'b0} :
	      (branch_op == 3'd6) ? 
	      esr[15:12] : (spr_we && sr_sel) ? 
	      {1'b1, spr_dat_o[15-1:12]} :
	      sr[15:12];
   assign to_sr[16] 
	    = (except_started) ? 1'b1 :
	      (branch_op == 3'd6) ? esr[16] :
	      (spr_we && sr_sel) ? spr_dat_o[16] :
	      sr[16];
   assign to_sr[11] 
	    = (except_started) ? sr[11] :
	      (branch_op == 3'd6) ? esr[11] :
	      ov_we ? ovforw :
	      (spr_we && sr_sel) ? spr_dat_o[11] :
	      sr[11];
   assign to_sr[10] 
	    = (except_started) ? sr[10] :
	      (branch_op == 3'd6) ? esr[10] :
	      cy_we ? cyforw :
	      (spr_we && sr_sel) ? spr_dat_o[10] :
	      sr[10];
   assign to_sr[9] 
	    = (except_started) ? sr[9] :
	      (branch_op == 3'd6) ? esr[9] :
	      flag_we ? flagforw :
	      (spr_we && sr_sel) ? spr_dat_o[9] :
	      sr[9];
   
   assign to_sr[8:0] 
	    = (except_started) ? {sr[8:7], 2'b00, 
				  sr[4:3], 3'b001} :
	      (branch_op == 3'd6) ? 
	      esr[8:0] : (spr_we && sr_sel) ? 
	      spr_dat_o[8:0] :
	      sr[8:0];

   //
   // Selects for system SPRs
   //
   assign cfgr_sel = (spr_cs[5'd00] && 
		      (spr_addr[10:4] == 7'd0));
   assign rf_sel = (spr_cs[5'd00] && 
		    (spr_addr[10:5] == 6'd32));
   assign npc_sel = (spr_cs[5'd00] && 
		     (spr_addr[10:0] == 11'd16));
   assign ppc_sel = (spr_cs[5'd00] && 
		     (spr_addr[10:0] == 11'd18));
   assign sr_sel = (spr_cs[5'd00] && 
		    (spr_addr[10:0] == 11'd17));
   assign epcr_sel = (spr_cs[5'd00] && 
		      (spr_addr[10:0] == 11'd32));
   assign eear_sel = (spr_cs[5'd00] && 
		      (spr_addr[10:0] == 11'd48));
   assign esr_sel = (spr_cs[5'd00] && 
		     (spr_addr[10:0] == 11'd64));
   assign fpcsr_sel = (spr_cs[5'd00] && 
		       (spr_addr[10:0] == 11'd20));


   //
   // Write enables for system SPRs
   //
   assign sr_we = (spr_we && sr_sel) | (branch_op == 3'd6) | 
		  flag_we | cy_we | ov_we;
   assign pc_we = (du_write && (npc_sel | ppc_sel));
   assign epcr_we = (spr_we && epcr_sel);
   assign eear_we = (spr_we && eear_sel);
   assign esr_we = (spr_we && esr_sel);
   assign fpcsr_we = (spr_we && fpcsr_sel);
   
   //
   // Output from system SPRs
   //
   assign sys_data = (spr_dat_cfgr & {32{cfgr_sel}}) |
		     (spr_dat_rf & {32{rf_sel}}) |
		     (spr_dat_npc & {32{npc_sel}}) |
		     (spr_dat_ppc & {32{ppc_sel}}) |
		     ({{32-17{1'b0}},sr} & {32{sr_sel}}) |
		     (epcr & {32{epcr_sel}}) |
		     (eear & {32{eear_sel}}) |
		     ({{32-12{1'b0}},fpcsr} & 
		      {32{fpcsr_sel}}) |
		     ({{32-17{1'b0}},esr} & {32{esr_sel}});

   //
   // Flag alias
   //
   assign flag = sr[9];

   //
   // Carry alias
   //
   assign carry = sr[10];
   
   //
   // Supervision register
   //
   always @(posedge clk or posedge rst)
     if (rst == (1'b1))
       sr_reg <=  {2'b01, // Fixed one.
		   1'b0, {17-4{1'b0}}, 1'b1};
     else if (except_started)
       sr_reg <=  to_sr[17-1:0];
     else if (sr_we)
       sr_reg <=  to_sr[17-1:0];

   // EPH part of Supervision register
   always @(posedge clk or posedge rst)
     // default value 
     if (rst == (1'b1)) begin
	sr_reg_bit_eph <=  1'b0;
	// select async. value due to reset state
	sr_reg_bit_eph_select <=  1'b1;	
     end
   // selected value (different from default) is written into FF after reset 
   // state
     else if (sr_reg_bit_eph_select) begin
	// dynamic value can only be assigned to FF out of reset!
	sr_reg_bit_eph <=  boot_adr_sel_i;
	sr_reg_bit_eph_select <=  1'b0;	// select FF value
     end
     else if (sr_we) begin
	sr_reg_bit_eph <=  to_sr[14];
     end

   // select async. value of EPH bit after reset 
   assign	sr_reg_bit_eph_muxed = (sr_reg_bit_eph_select) ? 
				       boot_adr_sel_i : sr_reg_bit_eph;

   // EPH part joined together with rest of Supervision register
   always @(sr_reg or sr_reg_bit_eph_muxed)
     sr = {sr_reg[17-1:17-2], sr_reg_bit_eph_muxed,
	   sr_reg[17-4:0]};



























   
   //
   // MTSPR/MFSPR interface
   //
   always @(spr_addr or sys_data or spr_dat_mac or spr_dat_pic or spr_dat_pm or
	    spr_dat_fpu or
	    spr_dat_dmmu or spr_dat_immu or spr_dat_du or spr_dat_tt) begin
      casez (spr_addr[15:11]) // synopsys parallel_case
	5'd00:
	  to_wbmux = sys_data;
	5'd10:
	  to_wbmux = spr_dat_tt;
	5'd09:
	  to_wbmux = spr_dat_pic;
	5'd08:
	  to_wbmux = spr_dat_pm;
	5'd01:
	  to_wbmux = spr_dat_dmmu;
	5'd02:
	  to_wbmux = spr_dat_immu;
	5'd05:
	  to_wbmux = spr_dat_mac;
	5'd11:
	  to_wbmux = spr_dat_fpu;
	default: //`OR1200_SPR_GROUP_DU:
	  to_wbmux = spr_dat_du;
      endcase
   end

endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Generic Double-Port Synchronous RAM                         ////
////                                                              ////
////  This file is part of memory library available from          ////
////  http://www.opencores.org/cvsweb.shtml/generic_memories/     ////
////                                                              ////
////  Description                                                 ////
////  This block is a wrapper with common double-port             ////
////  synchronous memory interface for different                  ////
////  types of ASIC and FPGA RAMs. Beside universal memory        ////
////  interface it also provides behavioral model of generic      ////
////  double-port synchronous RAM.                                ////
////  It should be used in all OPENCORES designs that want to be  ////
////  portable accross different target technologies and          ////
////  independent of target memory.                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Michael Unneback, unneback@opencores.org              ////
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
// $Log: or1200_dpram_32x32.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// New 
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_dpram
  (
   // Generic synchronous double-port RAM interface
   clk_a, ce_a, addr_a, do_a,
   clk_b, ce_b, we_b, addr_b, di_b
   );
   
   //
   // Default address and data buses width
   //
   parameter aw = 5;
   parameter dw = 32;
   
   //
   // Generic synchronous double-port RAM interface
   //
   input			clk_a;	// Clock
   input			ce_a;	// Chip enable input
   input [aw-1:0] 		addr_a;	// address bus inputs
   output [dw-1:0] 		do_a;	// output data bus
   input			clk_b;	// Clock
   input			ce_b;	// Chip enable input
   input			we_b;	// Write enable input
   input [aw-1:0] 		addr_b;	// address bus inputs
   input [dw-1:0] 		di_b;	// input data bus
   
   //
   // Internal wires and registers
   //
   
   //
   // Generic double-port synchronous RAM model
   //
   
   //
   // Generic RAM's registers and wires
   //
   reg [dw-1:0] 		mem [(1<<aw)-1:0] /*synthesis syn_ramstyle = "no_rw_check"*/;	// RAM content
   reg [aw-1:0] 		addr_a_reg;		// RAM address registered


   // Function to access GPRs (for use by Verilator). No need to hide this one
   // from the simulator, since it has an input (as required by IEEE 1364-2001).
   function [31:0] get_gpr;
      // verilator public
      input [aw-1:0] 		gpr_no;

      get_gpr = mem[gpr_no];
      
   endfunction // get_gpr

   function [31:0] set_gpr;
      // verilator public
      input [aw-1:0] 		gpr_no;
      input [dw-1:0] 		value;
      begin
	 mem[gpr_no] = value;
	 set_gpr = 0;
      end
   endfunction // get_gpr
   
   //
   // Data output drivers
   //
   //assign do_a = (oe_a) ? mem[addr_a_reg] : {dw{1'b0}};
   assign do_a = mem[addr_a_reg];
   
   
   //
   // RAM read
   //
   always @(posedge clk_a)
     if (ce_a)
       addr_a_reg <=  addr_a;
   
   //
   // RAM write
   //
   always @(posedge clk_b)
     if (ce_b & we_b)
       mem[addr_b] <=  di_b;
   
endmodule // or1200_dpram
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Data TLB                                           ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of DTLB.                                      ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
//
// $Log: or1200_dmmu_tlb.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed, coding style changed. 
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

//
// Data TLB
//

module or1200_dmmu_tlb(
	// Rst and clk
	clk, rst,

	// I/F for translation
	tlb_en, vaddr, hit, ppn, uwe, ure, swe, sre, ci,






	// SPR access
	spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o
);

parameter dw = 32;
parameter aw = 32;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// I/F for translation
//
input				tlb_en;
input	[aw-1:0]		vaddr;
output				hit;
output	[31:13]	ppn;
output				uwe;
output				ure;
output				swe;
output				sre;
output				ci;










//
// SPR access
//
input				spr_cs;
input				spr_write;
input	[31:0]			spr_addr;
input	[31:0]			spr_dat_i;
output	[31:0]			spr_dat_o;

//
// Internal wires and regs
//
wire	[31:13+6-1+1]	vpn;
wire				v;
wire	[6-1:0]	tlb_index;
wire				tlb_mr_en;
wire				tlb_mr_we;
wire	[32-6-13+1-1:0]	tlb_mr_ram_in;
wire	[32-6-13+1-1:0]	tlb_mr_ram_out;
wire				tlb_tr_en;
wire				tlb_tr_we;
wire	[32-13+5-1:0]	tlb_tr_ram_in;
wire	[32-13+5-1:0]	tlb_tr_ram_out;











//
// Implemented bits inside match and translate registers
//
// dtlbwYmrX: vpn 31-19  v 0
// dtlbwYtrX: ppn 31-13  swe 9  sre 8  uwe 7  ure 6
//
// dtlb memory width:
// 19 bits for ppn
// 13 bits for vpn
// 1 bit for valid
// 4 bits for protection
// 1 bit for cache inhibit

//
// Enable for Match registers
//
assign tlb_mr_en = tlb_en | (spr_cs & !spr_addr[7]);

//
// Write enable for Match registers
//
assign tlb_mr_we = spr_cs & spr_write & !spr_addr[7];

//
// Enable for Translate registers
//
assign tlb_tr_en = tlb_en | (spr_cs & spr_addr[7]);

//
// Write enable for Translate registers
//
assign tlb_tr_we = spr_cs & spr_write & spr_addr[7];

//
// Output to SPRS unit
//
assign spr_dat_o = (spr_cs & !spr_write & !spr_addr[7]) ?
			{vpn, tlb_index, {32-6-13-7{1'b0}}, 1'b0, 5'b00000, v} : 
		(spr_cs & !spr_write & spr_addr[7]) ?
			{ppn, {13-10{1'b0}}, swe, sre, uwe, ure, {4{1'b0}}, ci, 1'b0} :
			32'h00000000;

//
// Assign outputs from Match registers
//
assign {vpn, v} = tlb_mr_ram_out;

//
// Assign to Match registers inputs
//
assign tlb_mr_ram_in = {spr_dat_i[31:13+6-1+1], spr_dat_i[0]};

//
// Assign outputs from Translate registers
//
assign {ppn, swe, sre, uwe, ure, ci} = tlb_tr_ram_out;

//
// Assign to Translate registers inputs
//
assign tlb_tr_ram_in = {spr_dat_i[31:13],
			spr_dat_i[9],
			spr_dat_i[8],
			spr_dat_i[7],
			spr_dat_i[6],
			spr_dat_i[1]};

//
// Generate hit
//
assign hit = (vpn == vaddr[31:13+6-1+1]) & v;

//
// TLB index is normally vaddr[18:13]. If it is SPR access then index is
// spr_addr[5:0].
//
assign tlb_index = spr_cs ? spr_addr[6-1:0] : vaddr[13+6-1:13];

//
// Instantiation of DTLB Match Registers
//
//or1200_spram_64x14 dtlb_mr_ram(
   or1200_spram #
     (
      .aw(6),
      .dw(14)
      )
   dtlb_ram
     (
      .clk(clk),






      .ce(tlb_mr_en),
      .we(tlb_mr_we),
      .addr(tlb_index),
      .di(tlb_mr_ram_in),
      .doq(tlb_mr_ram_out)
      );
   
   //
   // Instantiation of DTLB Translate Registers
   //
   //or1200_spram_64x24 dtlb_tr_ram(
   or1200_spram #
     (
      .aw(6),
      .dw(24)
      )
   dtlb_tr_ram
     (
      .clk(clk),






      .ce(tlb_tr_en),
      .we(tlb_tr_we),
      .addr(tlb_index),
      .di(tlb_tr_ram_in),
      .doq(tlb_tr_ram_out)
      );
   
endmodule // or1200_dmmu_tlb
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Generic Single-Port Synchronous RAM with byte write signals ////
////                                                              ////
////  This file is part of memory library available from          ////
////  http://www.opencores.org/cvsweb.shtml/generic_memories/     ////
////                                                              ////
////  Description                                                 ////
////  This block is a wrapper with common single-port             ////
////  synchronous memory interface for different                  ////
////  types of ASIC and FPGA RAMs. Beside universal memory        ////
////  interface it also provides behavioral model of generic      ////
////  single-port synchronous RAM.                                ////
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
////  - Xilinx Virtex RAMB16                                      ////
////  - Xilinx Virtex RAMB4                                       ////
////                                                              ////
////  To Do:                                                      ////
////   - xilinx rams need external tri-state logic                ////
////   - fix avant! two-port ram                                  ////
////   - add additional RAMs                                      ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_spram_1024x32_bw.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//
// Revision 1.4  2005/10/19 11:37:56  jcastillo
// Added support for RAMB16 Xilinx4/Spartan3 primitives
//
// Revision 1.3  2004/06/08 18:15:32  lampret
// Changed behavior of the simulation generic models
//
// Revision 1.2  2003/10/17 07:59:44  markom
// mbist signals updated according to newest convention
//
// Revision 1.1  2003/08/27 08:38:36  simons
// Added support for rams with byte write access.
//
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_spram_1024x32_bw(




        // Generic synchronous single-port RAM interface
        clk, rst, ce, we, oe, addr, di, doq
);










//
// Generic synchronous single-port RAM interface
//
input                   clk;    // Clock
input                   rst;    // Reset
input                   ce;     // Chip enable input
input   [3:0]           we;     // Write enable input
input                   oe;     // Output enable input
input   [9:0]           addr;   // address bus inputs
input   [31:0]          di;     // input data bus
output  [31:0]          doq;     // output data bus

//
// Internal wires and registers
//








































































































































































































































































































































































































//
// Generic single-port synchronous RAM model
//

//
// Generic RAM's registers and wires
//
reg     [7:0]        mem_0 [1023:0];              // RAM content
reg     [7:0]        mem_1 [1023:0];              // RAM content
reg     [7:0]        mem_2 [1023:0];              // RAM content
reg     [7:0]        mem_3 [1023:0];              // RAM content
reg     [9:0]        addr_reg;                 // RAM address register

//
// Data output drivers
//
assign doq = (oe) ? {mem_3[addr_reg], mem_2[addr_reg], mem_1[addr_reg], mem_0[addr_reg]} : {32{1'b0}};

//
// RAM address register
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		addr_reg <=  10'h000;
        else if (ce)
                addr_reg <=  addr;

//
// RAM write byte 0
//
always @(posedge clk)
        if (ce && we[0])
                mem_0[addr] <=  di[7:0];

//
// RAM write byte 1
//
always @(posedge clk)
        if (ce && we[1])
                mem_1[addr] <=  di[15:8];

//
// RAM write byte 2
//
always @(posedge clk)
        if (ce && we[2])
                mem_2[addr] <=  di[23:16];

//
// RAM write byte 3
//
always @(posedge clk)
        if (ce && we[3])
                mem_3[addr] <=  di[31:24];


  // !OR1200_XILINX_RAMB16
  // !OR1200_XILINX_RAMB4
  // !OR1200_VIRTUALSILICON_SSP
  // !OR1200_VIRAGE_SSP
  // !OR1200_AVANT_ATP
  // !OR1200_ARTISAN_SSP

endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Top level multiplier, divider and MAC              ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Multiplier is 32x32 however multiply instructions only      ////
////  use lower 32 bits of the result. MAC is 32x32=64+64.        ////
////                                                              ////
////  To Do:                                                      ////
////   - make signed division better, w/o negating the operands   ////
////   - implement non-serial divider that is synthesizable       ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////      - Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000, 2010 Authors and OPENCORES.ORG           ////
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
// $Log: or1200_mult_mac.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed. 
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_mult_mac(
		       // Clock and reset
		       clk, rst,

		       // Multiplier/MAC interface
		       ex_freeze, id_macrc_op, macrc_op, a, b, mac_op, alu_op, 
		       result, mult_mac_stall,

		       // Overflow
		       ovforw, ov_we,
		       
		       // SPR interface
		       spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o
		       );

   parameter width = 32;

   //
   // I/O
   //

   //
   // Clock and reset
   //
   input				clk;
   input				rst;

   //
   // Multiplier/MAC interface
   //
   input				ex_freeze;
   input				id_macrc_op;
   input				macrc_op;
   input [width-1:0] 			a;
   input [width-1:0] 			b;
   input [3-1:0] 	mac_op;
   input [5-1:0] 	alu_op;
   output [width-1:0] 			result;
   output				mult_mac_stall;
   output 				ovforw, ov_we;
   
   //
   // SPR interface
   //
   input				spr_cs;
   input				spr_write;
   input [31:0] 			spr_addr;
   input [31:0] 			spr_dat_i;
   output [31:0] 			spr_dat_o;

   //
   // Internal wires and regs
   //
   reg [width-1:0] 			result;
   reg 					ex_freeze_r;
   wire 				alu_op_mul;
   wire 				alu_op_smul;      

   reg [2*width-1:0] 			mul_prod_r;
   wire 				alu_op_umul;   
 






   wire [2*width-1:0] 			mul_prod;
   wire 				mul_stall;
   reg [1:0] 				mul_stall_count;   
//    wire [3-1:0] 	mac_op;







   wire [3-1:0] 	mac_op_r1;
   wire [3-1:0] 	mac_op_r2;
   wire [3-1:0] 	mac_op_r3;
   wire 				mac_stall_r;
   wire [63:0] 				mac_r;

   wire [width-1:0] 			x;
   wire [width-1:0] 			y;
   wire 				spr_maclo_we;
   wire 				spr_machi_we; 
   wire 				alu_op_div;  
   wire 				alu_op_udiv;
   wire 				alu_op_sdiv;
   reg 					div_free;
   wire 			        div_stall;

 
   reg [2*width-1:0] 			div_quot_r;   
   wire [width-1:0] 			div_tmp;
   reg [5:0] 				div_cntr;
 



   wire 				div_by_zero;

   reg 					ovforw, ov_we;
   
   //
   // Combinatorial logic
   //

   assign alu_op_smul = (alu_op == 5'b0_0110);
   assign alu_op_umul = (alu_op == 5'b0_1011);
   assign alu_op_mul = alu_op_smul | alu_op_umul;









   assign spr_maclo_we = 1'b0;
   assign spr_machi_we = 1'b0;
   assign spr_dat_o = 32'h0000_0000;


   assign alu_op_sdiv = (alu_op == 5'b0_1001);
   assign alu_op_udiv = (alu_op == 5'b0_1010);
   assign alu_op_div = alu_op_sdiv | alu_op_udiv;   






   assign x = (alu_op_sdiv | alu_op_smul) & a[31] ? ~a + 32'b1 : 
	      alu_op_div | alu_op_mul | (|mac_op) ? a : 32'd0;
   assign y = (alu_op_sdiv | alu_op_smul) & b[31] ? ~b + 32'b1 : 
	      alu_op_div | alu_op_mul | (|mac_op) ? b : 32'd0;

   assign div_by_zero = !(|b) & alu_op_div;
   

   // Used to indicate when we should check for new multiply or MAC ops
   always @(posedge clk or posedge rst)
     if (rst == (1'b1))
       ex_freeze_r <= 1'b1;
     else
       ex_freeze_r <= ex_freeze;

   //
   // Select result of current ALU operation to be forwarded
   // to next instruction and to WB stage
   //
   always @*
     casez(alu_op)	// synopsys parallel_case

       5'b0_1001: begin
	  result = a[31] ^ b[31] ? ~div_quot_r[31:0] + 32'd1 : div_quot_r[31:0];
       end
       5'b0_1010: begin
	  result = div_quot_r[31:0];
       end

    
       5'b0_0110: begin
	  result = a[31] ^ b[31] ? ~mul_prod_r[31:0] + 32'd1 : mul_prod_r[31:0];
       end
	 5'b0_1011: begin
	  result = mul_prod_r[31:0];
       end
    
       default:







       result = {width{1'b0}};    
    
     endcase // casez (alu_op)


   //
   // Overflow generation
   //
   always @*
     casez(alu_op)	// synopsys parallel_case
       
 
       5'b0_0110: begin
	  // Actually doing unsigned multiply internally, and then negate on
	  // output as appropriate, so if sign bit is set, then is overflow
          // unless incoming signs differ and result is 2^(width-1)
          ovforw = (mul_prod_r[width-1] && 
                    !((a[width-1]^b[width-1]) && ~|mul_prod_r[width-2:0])) ||
                   |mul_prod_r[2*width-1:32];

	  ov_we = 1;
       end
       5'b0_1011 : begin
	  // Overflow on unsigned multiply is simpler.
	  ovforw = |mul_prod_r[2*width-1:32];
	  ov_we = 1;
       end
  //  `ifdef OR1200_MULT_IMPLEMENTED
 
       5'b0_1010,
       5'b0_1001: begin
	  // Overflow on divide by zero or -2^(width-1)/-1
	  ovforw = div_by_zero || (a==32'h8000_0000 && b==32'hffff_ffff);
	  ov_we = 1;
       end
 
 //  `ifdef OR1200_IMPL_OV
       default: begin
	  ovforw = 0;
	  ov_we = 0;
       end
     endcase // casez (alu_op)
   


 






























   
   //
   // Instantiation of the multiplier
   //
  







 // OR1200_ASIC_MULTP2_32X32
   or1200_gmultp2_32x32 or1200_gmultp2_32x32(
					     .X(x),
					     .Y(y),
					     .RST(rst),
					     .CLK(clk),
					     .P(mul_prod)
					     );
   // OR1200_ASIC_MULTP2_32X32   
   
   //
   // Registered output from the multiplier
   //
   always @(posedge rst or posedge clk)
     if (rst == (1'b1)) begin
	mul_prod_r <=  64'h0000_0000_0000_0000;
     end
     else begin
	mul_prod_r <=  mul_prod[63:0];
     end

   //
   // Generate stall signal during multiplication
   //
   always @(posedge rst or posedge clk)
     if (rst == (1'b1))
       mul_stall_count <= 0;
     else if (!(|mul_stall_count))
       mul_stall_count <= {mul_stall_count[0], alu_op_mul & !ex_freeze_r};
     else 
       mul_stall_count <= {mul_stall_count[0],1'b0};
       
   assign mul_stall = (|mul_stall_count) | 
		      (!(|mul_stall_count) & alu_op_mul & !ex_freeze_r);
   
  // !`ifdef OR1200_MULT_SERIAL   
   




 // OR1200_MULT_IMPLEMENTED





























































 // OR1200_MAC_IMPLEMENTED
   assign mac_stall_r = 1'b0;
   assign mac_r = {2*width{1'b0}};
   assign mac_op_r1 = 3'b0;
   assign mac_op_r2 = 3'b0;
   assign mac_op_r3 = 3'b0;
 // OR1200_MAC_IMPLEMENTED

   
   
   //
   // Serial division
   //
 
   assign div_tmp = div_quot_r[63:32] - y;   
   always @(posedge rst or posedge clk)
     if (rst == (1'b1)) begin
	div_quot_r <=  64'h0000_0000_0000_0000;
	div_free <=  1'b1;
	div_cntr <=  6'b00_0000;
     end
     else if (div_by_zero) begin
	div_quot_r <=  64'h0000_0000_0000_0000;
	div_free <=  1'b1;
	div_cntr <=  6'b00_0000;
     end
     else if (|div_cntr) begin
	if (div_tmp[31])
	  div_quot_r <=  {div_quot_r[62:0], 1'b0};
	else
	  div_quot_r <=  {div_tmp[30:0], div_quot_r[31:0], 1'b1};
	div_cntr <=  div_cntr - 6'd1;
     end
     else if (alu_op_div && div_free) begin
	div_quot_r <=  {31'b0, x[31:0], 1'b0};
	div_cntr <=  6'b10_0000;
	div_free <=  1'b0;
     end
     else if (div_free | !ex_freeze) begin
	div_free <=  1'b1;
     end

   assign div_stall = (|div_cntr) | (!ex_freeze_r & alu_op_div);


 


























   





 // !`ifdef OR1200_DIV_IMPLEMENTED
   
   
   //   
   // Stall output
   //
   assign mult_mac_stall = mac_stall_r | div_stall | mul_stall;
   
endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's 32x32 multiply for ASIC                            ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  32x32 multiply for ASIC                                     ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_amultp2_32x32.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 






























































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_pre_norm_div                                     ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  pre-normalization entity for the division unit              ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_pre_norm_div
  (
   clk_i,
   opa_i,
   opb_i,
   exp_10_o,
   dvdnd_50_o,
   dvsor_27_o
   );

   
   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;

   input clk_i;
   input [FP_WIDTH-1:0] opa_i;
   input [FP_WIDTH-1:0] opb_i;
   output reg [EXP_WIDTH+1:0] exp_10_o;
   output [2*(FRAC_WIDTH+2)-1:0] dvdnd_50_o;
   output [FRAC_WIDTH+3:0] 	 dvsor_27_o;

   
   wire [EXP_WIDTH-1:0] 	 s_expa;
   wire [EXP_WIDTH-1:0] 	 s_expb;
   wire [FRAC_WIDTH-1:0] 	 s_fracta;
   wire [FRAC_WIDTH-1:0] 	 s_fractb;
   wire [2*(FRAC_WIDTH+2)-1:0] 	 s_dvdnd_50_o;
   wire [FRAC_WIDTH+3:0] 	 s_dvsor_27_o;
   reg [5:0] 			 s_dvd_zeros;
   reg [5:0] 			 s_div_zeros;
   reg [EXP_WIDTH+1:0] 		 s_exp_10_o;
   
   reg [EXP_WIDTH+1:0] 		 s_expa_in;
   reg [EXP_WIDTH+1:0] 		 s_expb_in;
   wire 			 s_opa_dn, s_opb_dn;
   
   wire [FRAC_WIDTH:0] 		 s_fracta_24;
   wire [FRAC_WIDTH:0] 		 s_fractb_24;

   
   assign s_expa = opa_i[30:23];
   assign s_expb = opb_i[30:23];
   assign s_fracta = opa_i[22:0];
   assign s_fractb = opb_i[22:0];
   assign dvdnd_50_o = s_dvdnd_50_o;
   assign dvsor_27_o	= s_dvsor_27_o;
   
   // Output Register
   always @(posedge clk_i)
     exp_10_o <= s_exp_10_o;

   assign s_opa_dn = !(|s_expa);
   assign s_opb_dn = !(|s_expb);
	
   assign s_fracta_24 = {!s_opa_dn,s_fracta};
   assign s_fractb_24 = {!s_opb_dn,s_fractb};
	
   
   // count leading zeros
   //s_dvd_zeros <= count_l_zeros( s_fracta_24 );
   always @(s_fracta_24)
     casez(s_fracta_24)	// synopsys full_case parallel_case
       24'b1???????????????????????: s_dvd_zeros = 0;
       24'b01??????????????????????: s_dvd_zeros = 1;
       24'b001?????????????????????: s_dvd_zeros = 2;
       24'b0001????????????????????: s_dvd_zeros = 3;
       24'b00001???????????????????: s_dvd_zeros = 4;
       24'b000001??????????????????: s_dvd_zeros = 5;
       24'b0000001?????????????????: s_dvd_zeros = 6;
       24'b00000001????????????????: s_dvd_zeros = 7;
       24'b000000001???????????????: s_dvd_zeros = 8;
       24'b0000000001??????????????: s_dvd_zeros = 9;
       24'b00000000001?????????????: s_dvd_zeros = 10;
       24'b000000000001????????????: s_dvd_zeros = 11;
       24'b0000000000001???????????: s_dvd_zeros = 12;
       24'b00000000000001??????????: s_dvd_zeros = 13;
       24'b000000000000001?????????: s_dvd_zeros = 14;
       24'b0000000000000001????????: s_dvd_zeros = 15;
       24'b00000000000000001???????: s_dvd_zeros = 16;
       24'b000000000000000001??????: s_dvd_zeros = 17;
       24'b0000000000000000001?????: s_dvd_zeros = 18;
       24'b00000000000000000001????: s_dvd_zeros = 19;
       24'b000000000000000000001???: s_dvd_zeros = 20;
       24'b0000000000000000000001??: s_dvd_zeros = 21;
       24'b00000000000000000000001?: s_dvd_zeros = 22;
       24'b000000000000000000000001: s_dvd_zeros = 23;
       24'b000000000000000000000000: s_dvd_zeros = 24;
     endcase

   //s_div_zeros <= count_l_zeros( s_fractb_24 );
   always @(s_fractb_24)
     casez(s_fractb_24)	// synopsys full_case parallel_case
       24'b1???????????????????????: s_div_zeros = 0;
       24'b01??????????????????????: s_div_zeros = 1;
       24'b001?????????????????????: s_div_zeros = 2;
       24'b0001????????????????????: s_div_zeros = 3;
       24'b00001???????????????????: s_div_zeros = 4;
       24'b000001??????????????????: s_div_zeros = 5;
       24'b0000001?????????????????: s_div_zeros = 6;
       24'b00000001????????????????: s_div_zeros = 7;
       24'b000000001???????????????: s_div_zeros = 8;
       24'b0000000001??????????????: s_div_zeros = 9;
       24'b00000000001?????????????: s_div_zeros = 10;
       24'b000000000001????????????: s_div_zeros = 11;
       24'b0000000000001???????????: s_div_zeros = 12;
       24'b00000000000001??????????: s_div_zeros = 13;
       24'b000000000000001?????????: s_div_zeros = 14;
       24'b0000000000000001????????: s_div_zeros = 15;
       24'b00000000000000001???????: s_div_zeros = 16;
       24'b000000000000000001??????: s_div_zeros = 17;
       24'b0000000000000000001?????: s_div_zeros = 18;
       24'b00000000000000000001????: s_div_zeros = 19;
       24'b000000000000000000001???: s_div_zeros = 20;
       24'b0000000000000000000001??: s_div_zeros = 21;
       24'b00000000000000000000001?: s_div_zeros = 22;
       24'b000000000000000000000001: s_div_zeros = 23;
       24'b000000000000000000000000: s_div_zeros = 24;
     endcase

   // left-shift the dividend and divisor
   wire [FRAC_WIDTH:0] 		 fracta_lshift_intermediate;
   wire [FRAC_WIDTH:0] 		 fractb_lshift_intermediate;
   assign fracta_lshift_intermediate = s_fracta_24 << s_dvd_zeros;
   assign fractb_lshift_intermediate = s_fractb_24 << s_div_zeros;
   
   assign s_dvdnd_50_o = {fracta_lshift_intermediate,26'd0};
   
   assign s_dvsor_27_o = {3'd0,fractb_lshift_intermediate};
	
   always @(posedge clk_i)
     begin
	// pre-calculate exponent
	s_expa_in <= {2'd0,s_expa} + {9'd0,s_opa_dn};
	s_expb_in <= {2'd0,s_expb} + {9'd0,s_opb_dn};	
	s_exp_10_o <= s_expa_in - s_expb_in + 10'b0001111111 - 
		      {4'd0,s_dvd_zeros} + {4'd0,s_div_zeros};
     end

   
endmodule // or1200_fpu_pre_norm_div

//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Load/Store unit                                    ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Interface between CPU and DC.                               ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
//
// $Log: or1200_lsu.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_lsu(
	// Clock and Reset
	clk, rst,

	// Internal i/f
	id_addrbase, ex_addrbase, id_addrofs, ex_addrofs, id_lsu_op, 
	lsu_datain, lsu_dataout, lsu_stall, lsu_unstall,
	du_stall, except_align, except_dtlbmiss, except_dmmufault, except_dbuserr,
	id_freeze, ex_freeze, flushpipe,

	// External i/f to DC
	dcpu_adr_o, dcpu_cycstb_o, dcpu_we_o, dcpu_sel_o, dcpu_tag_o, dcpu_dat_o,
	dcpu_dat_i, dcpu_ack_i, dcpu_rty_i, dcpu_err_i, dcpu_tag_i
);

parameter dw = 32;
parameter aw = 5;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// Internal i/f
//
input	[31:0]			id_addrbase;
input	[31:0]			ex_addrbase;
input	[31:0]			id_addrofs;
input	[31:0]			ex_addrofs;
input	[4-1:0] id_lsu_op;
input	[dw-1:0]		lsu_datain;
output	[dw-1:0]		lsu_dataout;
output				lsu_stall;
output				lsu_unstall;
input                           du_stall;
output				except_align;
output				except_dtlbmiss;
output				except_dmmufault;
output				except_dbuserr;
input                           id_freeze;
input                           ex_freeze;
input                           flushpipe;

//
// External i/f to DC
//
output	[31:0]			dcpu_adr_o;
output				dcpu_cycstb_o;
output				dcpu_we_o;
output	[3:0]			dcpu_sel_o;
output	[3:0]			dcpu_tag_o;
output	[31:0]			dcpu_dat_o;
input	[31:0]			dcpu_dat_i;
input				dcpu_ack_i;
input				dcpu_rty_i;
input				dcpu_err_i;
input	[3:0]			dcpu_tag_i;

//
// Internal wires/regs
//
reg	[3:0]			dcpu_sel_o;

reg	[4-1:0] ex_lsu_op;
wire	[2:0] id_precalc_sum;
reg	[2:0] dcpu_adr_r;
reg				except_align;

//
// ex_lsu_op
//
always @(posedge clk or posedge rst) begin
    if (rst == (1'b1))
        ex_lsu_op <=  4'b0000;
    else if (!ex_freeze & id_freeze | flushpipe)
        ex_lsu_op <=  4'b0000;
    else if (!ex_freeze)
        ex_lsu_op <=  id_lsu_op;
end

//
// Precalculate part of load/store EA in ID stage
//
assign id_precalc_sum = id_addrbase[2-1:0] +
                        id_addrofs[2-1:0];

always @(posedge clk or posedge rst) begin
    if (rst == (1'b1))
        dcpu_adr_r <=  {2+1{1'b0}};
    else if (!ex_freeze)
        dcpu_adr_r <=  id_precalc_sum;
end

//
// Generate except_align in ID stage
//
always @(posedge clk or posedge rst) begin
    if (rst == (1'b1))
        except_align <=  1'b0;
    else if (!ex_freeze & id_freeze | flushpipe)
        except_align <=  1'b0;
    else if (!ex_freeze)
        except_align <=  ((id_lsu_op == 4'b1100) |
                            (id_lsu_op == 4'b0100) |
                            (id_lsu_op == 4'b0101)) & id_precalc_sum[0]
		        |  ((id_lsu_op == 4'b1110) |
		            (id_lsu_op == 4'b0110) |
		            (id_lsu_op == 4'b0111)) & |id_precalc_sum[1:0];
end

//
// Internal I/F assignments
//
assign lsu_stall = dcpu_rty_i & dcpu_cycstb_o;
assign lsu_unstall = dcpu_ack_i;
assign except_dtlbmiss = dcpu_err_i & (dcpu_tag_i == 4'hd);
assign except_dmmufault = dcpu_err_i & (dcpu_tag_i == 4'hc);
assign except_dbuserr = dcpu_err_i & (dcpu_tag_i == 4'hb);

//
// External I/F assignments
//
assign dcpu_adr_o[31:2] = 
				   ex_addrbase[31:2] + 
				   (ex_addrofs[31:2] +
				    // carry from precalc, pad to 30-bits
				   {{(32-2)-1{1'b0}},
				    dcpu_adr_r[2]});
assign dcpu_adr_o[2-1:0] = dcpu_adr_r[2-1:0];
assign dcpu_cycstb_o = du_stall | lsu_unstall | except_align ? 
		       1'b0 : |ex_lsu_op;
assign dcpu_we_o = ex_lsu_op[3];
assign dcpu_tag_o = dcpu_cycstb_o ? 4'h1 : 4'h0;
always @(ex_lsu_op or dcpu_adr_o)
	casez({ex_lsu_op, dcpu_adr_o[1:0]})
		{4'b1010, 2'b00} : dcpu_sel_o = 4'b1000;
		{4'b1010, 2'b01} : dcpu_sel_o = 4'b0100;
		{4'b1010, 2'b10} : dcpu_sel_o = 4'b0010;
		{4'b1010, 2'b11} : dcpu_sel_o = 4'b0001;
		{4'b1100, 2'b00} : dcpu_sel_o = 4'b1100;
		{4'b1100, 2'b10} : dcpu_sel_o = 4'b0011;
		{4'b1110, 2'b00} : dcpu_sel_o = 4'b1111;
		{4'b0010, 2'b00}, {4'b0011, 2'b00} : dcpu_sel_o = 4'b1000;
		{4'b0010, 2'b01}, {4'b0011, 2'b01} : dcpu_sel_o = 4'b0100;
		{4'b0010, 2'b10}, {4'b0011, 2'b10} : dcpu_sel_o = 4'b0010;
		{4'b0010, 2'b11}, {4'b0011, 2'b11} : dcpu_sel_o = 4'b0001;
		{4'b0100, 2'b00}, {4'b0101, 2'b00} : dcpu_sel_o = 4'b1100;
		{4'b0100, 2'b10}, {4'b0101, 2'b10} : dcpu_sel_o = 4'b0011;
		{4'b0110, 2'b00}, {4'b0111, 2'b00} : dcpu_sel_o = 4'b1111;
		default : dcpu_sel_o = 4'b0000;
	endcase

//
// Instantiation of Memory-to-regfile aligner
//
or1200_mem2reg or1200_mem2reg(
	.addr(dcpu_adr_o[1:0]),
	.lsu_op(ex_lsu_op),
	.memdata(dcpu_dat_i),
	.regdata(lsu_dataout)
);

//
// Instantiation of Regfile-to-memory aligner
//
or1200_reg2mem or1200_reg2mem(
        .addr(dcpu_adr_o[1:0]),
        .lsu_op(ex_lsu_op),
        .regdata(lsu_datain),
        .memdata(dcpu_dat_o)
);

endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's VR, UPR and Configuration Registers                ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  According to OR1K architectural and OR1200 specifications.  ////
////                                                              ////
////  To Do:                                                      ////
////   - done                                                     ////
////                                                              ////
////  Author(s):                                                  ////
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
//
// $Log: or1200_cfgr.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_cfgr(
		   // RISC Internal Interface
		   spr_addr, spr_dat_o
		   );

   //
   // RISC Internal Interface
   //
   input	[31:0]	spr_addr;	// SPR Address
   output [31:0] 	spr_dat_o;	// SPR Read Data

   //
   // Internal wires & registers
   //
   reg [31:0] 		spr_dat_o;	// SPR Read Data



   //
   // Implementation of VR, UPR and configuration registers
   //
   always @(spr_addr)
 
     if (~|spr_addr[31:4])
 
       case(spr_addr[3:0])		// synopsys parallel_case
	 4'h0: begin
	    spr_dat_o[5:0] = 6'h08;
	    spr_dat_o[15:6] = 10'h000;
	    spr_dat_o[23:16] = 8'h00;
	    spr_dat_o[31:24] = 8'h13;
	 end
	 4'h1: begin
	    spr_dat_o[0] = 1'b1;
	    spr_dat_o[1] = 1'b1;
	    spr_dat_o[2] = 1'b1;
	    spr_dat_o[3] = 1'b1;
	    spr_dat_o[4] = 1'b1;
	    spr_dat_o[5] = 1'b0;
	    spr_dat_o[6] = 1'b1;
	    spr_dat_o[7] = 1'b0;
	    spr_dat_o[8] = 1'b0;
	    spr_dat_o[9] = 1'b1;
	    spr_dat_o[10] = 1'b1;
	    spr_dat_o[11] = 1'b0;
	    spr_dat_o[23:12] = 12'h000;
	    spr_dat_o[31:24] = 8'h00;
	 end
	 4'h2: begin
	    spr_dat_o[3:0] = 4'h0;
	    spr_dat_o[4] = 1'b0;
	    spr_dat_o[5] = 1'b1;
	    spr_dat_o[6] = 1'b0;
	    spr_dat_o[7] = 1'b0;
	    spr_dat_o[8] = 1'b0;
	    spr_dat_o[9] = 1'b0;
	    spr_dat_o[31:10] = 22'h000000;
	 end
	 4'h3: begin
	    spr_dat_o[1:0] = 2'h0;
	    spr_dat_o[4:2] = 3'h6;
	    spr_dat_o[7:5] = 3'h0;
	    spr_dat_o[8] = 1'b0;
	    spr_dat_o[9] = 1'b0;
	    spr_dat_o[10] = 1'b0;
	    spr_dat_o[11] = 1'b0;
	    spr_dat_o[31:12] = 20'h00000;
	 end
	 4'h4: begin
	    spr_dat_o[1:0] = 2'h0;
	    spr_dat_o[4:2] = 3'h6;
	    spr_dat_o[7:5] = 3'h0;
	    spr_dat_o[8] = 1'b0;
	    spr_dat_o[9] = 1'b0;
	    spr_dat_o[10] = 1'b0;
	    spr_dat_o[11] = 1'b0;
	    spr_dat_o[31:12] = 20'h00000;
	 end
	 4'h5: begin
	    spr_dat_o[2:0] = 3'h0;
	    spr_dat_o[6:3] = (13-4);
	    spr_dat_o[7] = 4==4 ? 1'b0 : 1'b1;
	    spr_dat_o[8] = 1'b0;
	    spr_dat_o[9] = 1'b1;
	    spr_dat_o[10] = 1'b1;
	    spr_dat_o[11] = 1'b0;
	    spr_dat_o[12] = 1'b0;
	    spr_dat_o[13] = 1'b1;
	    spr_dat_o[14] = 1'b0;
	    spr_dat_o[31:15] = 17'h00000;
	 end
	 4'h6: begin
	    spr_dat_o[2:0] = 3'h0;
	    spr_dat_o[6:3] = (13-4);
	    spr_dat_o[7] = 4==4 ? 1'b0: 1'b1;
	    spr_dat_o[8] = 1'b0;
	    spr_dat_o[9] = 1'b1;
	    spr_dat_o[10] = 1'b1;
	    spr_dat_o[11] = 1'b0;
	    spr_dat_o[12] = 1'b0;
	    spr_dat_o[13] = 1'b1;
	    spr_dat_o[14] = 1'b0;
	    spr_dat_o[31:15] = 17'h00000;
	 end
	 4'h7: begin
	    spr_dat_o[3:0] = 4'h0;
	    spr_dat_o[4] = 1'b0;
	    spr_dat_o[31:5] = 27'd0;
	 end
	 default: spr_dat_o = 32'h0000_0000;
       endcase
 
     else
       spr_dat_o = 32'h0000_0000;
 










































endmodule
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
////  interface it also provides behavioral model of generic      ////
////  single-port synchronous RAM.                                ////
////  It should be used in all OPENCORES designs that want to be  ////
////  portable accross different target technologies and          ////
////  independent of target memory.                               ////
////                                                              ////
////  Supported ASIC RAMs are:                                    ////
////                                                              ////
////  Supported FPGA RAMs are:                                    ////
////  - Xilinx Virtex RAMB16                                      ////
////  - Xilinx Virtex RAMB4                                       ////
////                                                              ////
////  To Do:                                                      ////
////   - add support for other RAM's                              ////
////   - xilinx rams need external tri-state logic                ////
////   - fix avant! two-port ram                                  ////
////   - add additional RAMs                                      ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_spram_128x32.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//
// Revision 1.3  2005/10/19 11:37:56  jcastillo
// Added support for RAMB16 Xilinx4/Spartan3 primitives
//
// Revision 1.2  2004/06/08 18:15:32  lampret
// Changed behavior of the simulation generic models
//
// Revision 1.1  2004/04/08 11:00:46  simont
// Add support for 512B instruction cache.
//
//
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_spram_128x32(




	// Generic synchronous single-port RAM interface
	clk, rst, ce, we, oe, addr, di, doq
);

//
// Default address and data buses width
//
parameter aw = 7;
parameter dw = 32;










//
// Generic synchronous single-port RAM interface
//
input			clk;	// Clock
input			rst;	// Reset
input			ce;	// Chip enable input
input			we;	// Write enable input
input			oe;	// Output enable input
input 	[aw-1:0]	addr;	// address bus inputs
input	[dw-1:0]	di;	// input data bus
output	[dw-1:0]	doq;	// output data bus

//
// Internal wires and registers
//






























































































































//
// Generic single-port synchronous RAM model
//

//
// Generic RAM's registers and wires
//
reg	[dw-1:0]	mem [(1<<aw)-1:0];	// RAM content
reg	[aw-1:0]	addr_reg;		// RAM address register

//
// Data output drivers
//
assign doq = (oe) ? mem[addr_reg] : {dw{1'b0}};

//
// RAM address register
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		addr_reg <=  {aw{1'b0}};
	else if (ce)
		addr_reg <=  addr;

//
// RAM write
//
always @(posedge clk)
	if (ce && we)
		mem[addr] <=  di;

	// !OR1200_XILINX_RAMB16
	// !OR1200_XILINX_RAMB4
	// !OR1200_VIRTUALSILICON_SSP
	// !OR1200_VIRAGE_SSP
	// !OR1200_AVANT_ATP
	// !OR1200_ARTISAN_SSP

endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's WISHBONE BIU                                       ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Implements WISHBONE interface                               ////
////                                                              ////
////  To Do:                                                      ////
////   - if biu_cyc/stb are deasserted and wb_ack_i is asserted   ////
////   and this happens even before aborted_r is asssrted,        ////
////   wb_ack_i will be delivered even though transfer is         ////
////   internally considered already aborted. However most        ////
////   wb_ack_i are externally registered and delayed. Normally   ////
////   this shouldn't cause any problems.                         ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_iwb_biu.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// This module is obsolete.
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

// module or1200_iwb_biu();

// 	// THIS MODULE IS OBSOLETE !!! 
// 	// COMPLETELY REWRITTEN or1200_wb_biu.v IS USED INSTEAD !!!


// endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Instruction Cache top level                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of all IC blocks.                             ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_ic_top.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

//
// Instruction cache top
//
module or1200_ic_top(
	// Rst, clk and clock control
	clk, rst,

	// External i/f
	icbiu_dat_o, icbiu_adr_o, icbiu_cyc_o, icbiu_stb_o, icbiu_we_o, 
	icbiu_sel_o, icbiu_cab_o, icbiu_dat_i, icbiu_ack_i, icbiu_err_i,

	// Internal i/f
	ic_en,
	icqmem_adr_i, icqmem_cycstb_i, icqmem_ci_i, icqmem_sel_i, icqmem_tag_i,
	icqmem_dat_o, icqmem_ack_o, icqmem_rty_o, icqmem_err_o, icqmem_tag_o,






	// SPRs
	spr_cs, spr_write, spr_dat_i
);

parameter dw = 32;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// External I/F
//
output	[dw-1:0]		icbiu_dat_o;
output	[31:0]			icbiu_adr_o;
output				icbiu_cyc_o;
output				icbiu_stb_o;
output				icbiu_we_o;
output	[3:0]			icbiu_sel_o;
output				icbiu_cab_o;
input	[dw-1:0]		icbiu_dat_i;
input				icbiu_ack_i;
input				icbiu_err_i;

//
// Internal I/F
//
input				ic_en;
input	[31:0]			icqmem_adr_i;
input				icqmem_cycstb_i;
input				icqmem_ci_i;
input	[3:0]			icqmem_sel_i;
input	[3:0]			icqmem_tag_i;
output	[dw-1:0]		icqmem_dat_o;
output				icqmem_ack_o;
output				icqmem_rty_o;
output				icqmem_err_o;
output	[3:0]			icqmem_tag_o;










//
// SPR access
//
input				spr_cs;
input				spr_write;
input	[31:0]			spr_dat_i;

//
// Internal wires and regs
//
wire				tag_v;
wire	[20-2:0]	tag;
wire	[dw-1:0]		to_icram;
wire	[dw-1:0]		from_icram;
wire	[31:0]			saved_addr;
wire	[3:0]			icram_we;
wire				ictag_we;
wire	[31:0]			ic_addr;
wire				icfsm_biu_read;
/* verilator lint_off UNOPTFLAT */    
reg				tagcomp_miss;
/* verilator lint_on UNOPTFLAT */    
wire	[13-1:4]	ictag_addr;
wire				ictag_en;
wire				ictag_v; 
wire				ic_inv;
wire				icfsm_first_hit_ack;
wire				icfsm_first_miss_ack;
wire				icfsm_first_miss_err;
wire				icfsm_burst;
wire				icfsm_tag_we;
reg 				ic_inv_q;
   











//
// Simple assignments
//
assign icbiu_adr_o = ic_addr;
assign ic_inv = spr_cs & spr_write;
assign ictag_we = icfsm_tag_we | ic_inv;
assign ictag_addr = ic_inv ? 
		    spr_dat_i[13-1:4] : 
		    ic_addr[13-1:4];
assign ictag_en = ic_inv | ic_en;
assign ictag_v = ~ic_inv;

//
// Data to BIU is from ICRAM when IC is enabled or from LSU when
// IC is disabled
//
assign icbiu_dat_o = 32'h00000000;

//
// Bypases of the IC when IC is disabled
//
assign icbiu_cyc_o = (ic_en) ? icfsm_biu_read : icqmem_cycstb_i;
assign icbiu_stb_o = (ic_en) ? icfsm_biu_read : icqmem_cycstb_i;
assign icbiu_we_o = 1'b0;
assign icbiu_sel_o = (ic_en & icfsm_biu_read) ? 4'b1111 : icqmem_sel_i;
assign icbiu_cab_o = (ic_en) ? icfsm_burst : 1'b0;
assign icqmem_rty_o = ~icqmem_ack_o & ~icqmem_err_o;
assign icqmem_tag_o = icqmem_err_o ? 4'hb : icqmem_tag_i;

//
// CPU normal and error termination
//
assign icqmem_ack_o = ic_en ? (icfsm_first_hit_ack | icfsm_first_miss_ack) : icbiu_ack_i;
assign icqmem_err_o = ic_en ? icfsm_first_miss_err : icbiu_err_i;

//
// Select between claddr generated by IC FSM and addr[3:2] generated by LSU
//
assign ic_addr = (icfsm_biu_read) ? saved_addr : icqmem_adr_i;

//
// Select between input data generated by LSU or by BIU
//
assign to_icram = icbiu_dat_i;

//
// Select between data generated by ICRAM or passed by BIU
//
assign icqmem_dat_o = icfsm_first_miss_ack | !ic_en ? icbiu_dat_i : from_icram;

//
// Detect falling edge of IC invalidate signal
// 
always @(posedge clk or posedge rst)
   if (rst==(1'b1))
     ic_inv_q <= 1'b0;
   else
     ic_inv_q <= ic_inv;
   
   
//
// Tag comparison
//
// During line invalidate, ensure it stays the same
always @(tag or saved_addr or tag_v) begin
	  if ((tag != saved_addr[31:13-1+1]) | !tag_v)
	    tagcomp_miss = 1'b1;
	  else
	    tagcomp_miss = 1'b0;
end

//
// Instantiation of IC Finite State Machine
//
or1200_ic_fsm or1200_ic_fsm(
	.clk(clk),
	.rst(rst),
	.ic_en(ic_en),
	.icqmem_cycstb_i(icqmem_cycstb_i),
	.icqmem_ci_i(icqmem_ci_i),
	.tagcomp_miss(tagcomp_miss),
	.biudata_valid(icbiu_ack_i),
	.biudata_error(icbiu_err_i),
	.start_addr(icqmem_adr_i),
	.saved_addr(saved_addr),
	.icram_we(icram_we),
	.biu_read(icfsm_biu_read),
	.first_hit_ack(icfsm_first_hit_ack),
	.first_miss_ack(icfsm_first_miss_ack),
	.first_miss_err(icfsm_first_miss_err),
	.burst(icfsm_burst),
	.tag_we(icfsm_tag_we)
);

//
// Instantiation of IC main memory
//
or1200_ic_ram or1200_ic_ram(
	.clk(clk),
	.rst(rst),






	.addr(ic_addr[13-1:2]),
	.en(ic_en),
	.we(icram_we),
	.datain(to_icram),
	.dataout(from_icram)
);

//
// Instantiation of IC TAG memory
//
or1200_ic_tag or1200_ic_tag(
	.clk(clk),
	.rst(rst),






	.addr(ictag_addr),
	.en(ictag_en),
	.we(ictag_we),
	.datain({ic_addr[31:13-1+1], ictag_v}),
	.tag_v(tag_v),
	.tag(tag)
);

endmodule

`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_alu(
	a, b, mult_mac_result, macrc_op,
	alu_op, alu_op2, comp_op,
	cust5_op, cust5_limm,
	result, flagforw, flag_we,
	ovforw, ov_we,
	cyforw, cy_we, carry, flag
);



//
// I/O
//
input	[32-1:0]		a;
input	[32-1:0]		b;
input	[32-1:0]		mult_mac_result;
input				macrc_op;
input	[5-1:0]	alu_op;
input	[4-1:0]	alu_op2;
input	[4-1:0]	comp_op;
input	[4:0]			cust5_op;
input	[5:0]			cust5_limm;
output	[32-1:0]		result;
output				flagforw;
output				flag_we;
output				cyforw;
output				cy_we;
output				ovforw;
output				ov_we;
input				carry;
input         flag;

//
// Internal wires and regs
//
reg	[32-1:0]		result;
reg	[32-1:0]		shifted_rotated;
reg	[32-1:0]		extended;   



reg				flagforw;
reg				flagcomp;
reg				flag_we;
reg				cyforw;
reg				cy_we;
reg				ovforw;
reg				ov_we;   
wire	[32-1:0]		comp_a;
wire	[32-1:0]		comp_b;
wire				a_eq_b;
wire				a_lt_b;
wire	[32-1:0]		result_sum;
wire	[32-1:0]		result_and;
wire				cy_sum;

wire				cy_sub;

wire    			ov_sum;
wire    [32-1:0] 		carry_in;

wire    [32-1:0]		b_mux;
   
   

//
// Combinatorial logic
//

assign comp_a = {a[32-1] ^ comp_op[3] , a[32-2:0]};
assign comp_b = {b[32-1] ^ comp_op[3] , b[32-2:0]};





assign a_eq_b = !(|result_sum);
// signed compare when comp_op[3] is set
assign a_lt_b = comp_op[3] ? ((a[32-1] & !b[32-1]) |  
			      (!a[32-1] & !b[32-1] & result_sum[32-1])|
			      (a[32-1] & b[32-1] & result_sum[32-1])):
		(a < b);


   

 
assign cy_sub =	a_lt_b;
 

			      

   
   
assign carry_in = (alu_op==5'b0_0001) ? 
		  {{32-1{1'b0}},carry} : {32{1'b0}};






assign b_mux = ((alu_op==5'b0_0010) | (alu_op==5'b1_0000)) ? 
		(~b)+1 : b;









			      
assign {cy_sum, result_sum} = (a + b_mux) + carry_in;
// Numbers either both +ve and bit 31 of result set
assign ov_sum = ((!a[32-1] & !b_mux[32-1]) & result_sum[32-1]) |

		// Subtract larger negative from smaller positive
		((!a[32-1] & b_mux[32-1]) & result_sum[32-1] &
		 alu_op==5'b0_0010) |

// or both -ve and bit 31 of result clear
		((a[32-1] & b_mux[32-1]) & !result_sum[32-1]);  
assign result_and = a & b;

//
// Simulation check for bad ALU behavior
//









//
// Central part of the ALU
//
always @(alu_op or alu_op2 or a or b or result_sum or result_and or macrc_op
	 or shifted_rotated or mult_mac_result or flag or carry

         or extended
	 



) begin

	casez (alu_op)		// synopsys parallel_case



	  
		5'b0_1111: begin

		   casez (alu_op2) // synopsys parallel_case



		     0: begin // FF1
			result = a[0] ? 1 : a[1] ? 2 : a[2] ? 3 : a[3] ? 4 : a[4] ? 5 : a[5] ? 6 : a[6] ? 7 : a[7] ? 8 : a[8] ? 9 : a[9] ? 10 : a[10] ? 11 : a[11] ? 12 : a[12] ? 13 : a[13] ? 14 : a[14] ? 15 : a[15] ? 16 : a[16] ? 17 : a[17] ? 18 : a[18] ? 19 : a[19] ? 20 : a[20] ? 21 : a[21] ? 22 : a[22] ? 23 : a[23] ? 24 : a[24] ? 25 : a[25] ? 26 : a[26] ? 27 : a[27] ? 28 : a[28] ? 29 : a[29] ? 30 : a[30] ? 31 : a[31] ? 32 : 0;
		     end
		     default: begin // FL1
			result = a[31] ? 32 : a[30] ? 31 : a[29] ? 30 : a[28] ? 29 : a[27] ? 28 : a[26] ? 27 : a[25] ? 26 : a[24] ? 25 : a[23] ? 24 : a[22] ? 23 : a[21] ? 22 : a[20] ? 21 : a[19] ? 20 : a[18] ? 19 : a[17] ? 18 : a[16] ? 17 : a[15] ? 16 : a[14] ? 15 : a[13] ? 14 : a[12] ? 13 : a[11] ? 12 : a[10] ? 11 : a[9] ? 10 : a[8] ? 9 : a[7] ? 8 : a[6] ? 7 : a[5] ? 6 : a[4] ? 5 : a[3] ? 4 : a[2] ? 3 : a[1] ? 2 : a[0] ? 1 : 0 ;
		     end
		   endcase // casez (alu_op2)
		end // case: `OR1200_ALUOP_FFL1
 //  `ifdef OR1200_IMPL_ALU_FFL1





		     
		5'b0_1000 : begin 
				result = shifted_rotated;
		end

		5'b0_0001,


		5'b0_0010,
	 
		5'b0_0000 : begin
				result = result_sum;
		end
		5'b0_0101 : begin
				result = a ^ b;
		end
		5'b0_0100  : begin
				result = a | b;
		end
		     
		5'b0_1100  : begin
		                result = extended;
		end
		5'b0_1101  : begin
		                result = a;
		end		
     
		5'b1_0001 : begin
				if (macrc_op) begin
					result = mult_mac_result;
				end
				else begin
					result = b << 16;
				end
		end


		5'b0_1001,
		5'b0_1010,

		5'b0_0110,
		5'b0_1011 : begin
				result = mult_mac_result;
		end

		5'b0_1110: begin
			result = flag ? a : b;
		end


		default: begin



			result=result_and;
		end 
	endcase
end

//
// Generate flag and flag write enable
//
always @(alu_op or result_sum or result_and or flagcomp
) begin
	casez (alu_op)		// synopsys parallel_case













		5'b1_0000: begin
			flagforw = flagcomp;
			flag_we = 1'b1;
		end
		default: begin
			flagforw = flagcomp;
			flag_we = 1'b0;
		end
	endcase
end

//
// Generate SR[CY] write enable
//
always @(alu_op or cy_sum


	or cy_sub


) begin
	casez (alu_op)		// synopsys parallel_case


		5'b0_0001,
	  
		5'b0_0000 : begin
			cyforw = cy_sum;
			cy_we = 1'b1;
		end

		5'b0_0010: begin
			cyforw = cy_sub;
			cy_we = 1'b1;
		end


		default: begin
			cyforw = 1'b0;
			cy_we = 1'b0;
		end
	endcase
end


//
// Generate SR[OV] write enable
//
always @(alu_op or ov_sum) begin
	casez (alu_op)		// synopsys parallel_case


		5'b0_0001,


		5'b0_0010,
	 
		5'b0_0000 : begin
			ovforw = ov_sum;
			ov_we = 1'b1;
		end
	  
		default: begin
			ovforw = 1'b0;
			ov_we = 1'b0;
		end
	endcase
end
   
//
// Shifts and rotation
//
always @(alu_op2 or a or b) begin
	case (alu_op2)		// synopsys parallel_case
	  4'd0 :
				shifted_rotated = (a << b[4:0]);
	  4'd1 :
				shifted_rotated = (a >> b[4:0]);






	  default:
	                        shifted_rotated = ({32{a[31]}} << 
						   (6'd32-{1'b0, b[4:0]})) | 
						  a >> b[4:0];
	endcase
end

//
// First type of compare implementation
//





















//
// Second type of compare implementation
//



















 //  `ifdef OR1200_IMPL_ALU_COMP2


always @(comp_op or a_eq_b or a_lt_b) begin
	case(comp_op[2:0])	// synopsys parallel_case
		3'b000:
			flagcomp = a_eq_b;
		3'b001:
			flagcomp = ~a_eq_b;
		3'b010:
			flagcomp = ~(a_eq_b | a_lt_b);
		3'b011:
			flagcomp = ~a_lt_b;
		3'b100:
			flagcomp = a_lt_b;
		3'b101:
			flagcomp = a_eq_b | a_lt_b;
		default:
			flagcomp = 1'b0;
	endcase
end

   


   always @(alu_op or alu_op2 or a) begin
      casez (alu_op2)
	4'h0 : extended = {{16{a[15]}},a[15:0]};
	4'h1 : extended = {{24{a[7]}},a[7:0]};
	4'h2 : extended = {16'd0,a[15:0]};
	4'h3 : extended = {24'd0,a[7:0]};
	default: extended = a; // Used for l.extw instructions
      endcase // casez (alu_op2)
   end
 
	     

//
// l.cust5 custom instructions
//

























   

endmodule
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
////  interface it also provides behavioral model of generic      ////
////  single-port synchronous RAM.                                ////
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
////  - Xilinx Virtex RAMB16                                      ////
////  - Xilinx Virtex RAMB4                                       ////
////  - Altera LPM                                                ////
////                                                              ////
////  To Do:                                                      ////
////   - xilinx rams need external tri-state logic                ////
////   - fix avant! two-port ram                                  ////
////   - add additional RAMs                                      ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_spram_2048x32.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//
// Revision 1.10  2005/10/19 11:37:56  jcastillo
// Added support for RAMB16 Xilinx4/Spartan3 primitives
//
// Revision 1.9  2004/06/08 18:15:32  lampret
// Changed behavior of the simulation generic models
//
// Revision 1.8  2004/04/05 08:29:57  lampret
// Merged branch_qmem into main tree.
//
// Revision 1.4.4.1  2003/12/09 11:46:48  simons
// Mbist nameing changed, Artisan ram instance signal names fixed, some synthesis waning fixed.
//
// Revision 1.4  2003/04/07 01:19:07  lampret
// Added Altera LPM RAMs. Changed generic RAM output when OE inactive.
//
// Revision 1.3  2002/10/28 15:03:50  mohor
// Signal scanb_sen renamed to scanb_en.
//
// Revision 1.2  2002/10/17 20:04:40  lampret
// Added BIST scan. Special VS RAMs need to be used to implement BIST.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.8  2001/11/02 18:57:14  lampret
// Modified virtual silicon instantiations.
//
// Revision 1.7  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.6  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.1  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.2  2001/07/30 05:38:02  lampret
// Adding empty directories required by HDL coding guidelines
//
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_spram_2048x32(




	// Generic synchronous single-port RAM interface
	clk, rst, ce, we, oe, addr, di, doq
);

//
// Default address and data buses width
//
parameter aw = 11;
parameter dw = 32;










//
// Generic synchronous single-port RAM interface
//
input			clk;	// Clock
input			rst;	// Reset
input			ce;	// Chip enable input
input			we;	// Write enable input
input			oe;	// Output enable input
input 	[aw-1:0]	addr;	// address bus inputs
input	[dw-1:0]	di;	// input data bus
output	[dw-1:0]	doq;	// output data bus

//
// Internal wires and registers
//


























































































































































































































































































































































































































































//
// Generic single-port synchronous RAM model
//

//
// Generic RAM's registers and wires
//
reg	[dw-1:0]	mem [(1<<aw)-1:0];	// RAM content
reg	[aw-1:0]	addr_reg;		// RAM address register

//
// Data output drivers
//
assign doq = (oe) ? mem[addr_reg] : {dw{1'b0}};

//
// RAM address register
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		addr_reg <=  {aw{1'b0}};
	else if (ce)
		addr_reg <=  addr;

//
// RAM write
//
always @(posedge clk)
	if (ce && we)
		mem[addr] <=  di;

	// !OR1200_ALTERA_LPM
	// !OR1200_XILINX_RAMB16
	// !OR1200_XILINX_RAMB4
	// !OR1200_VIRTUALSILICON_SSP
	// !OR1200_VIRAGE_SSP
	// !OR1200_AVANT_ATP
	// !OR1200_ARTISAN_SSP

endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_mul                                              ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Serial multiplication entity for the multiplication unit    ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_mul 
(  
   clk_i,
   fracta_i,
   fractb_i,
   signa_i,
   signb_i,
   start_i,
   fract_o,
   sign_o,
   ready_o
   );

   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;
   
   input clk_i;
   input [FRAC_WIDTH:0] fracta_i;   
   input [FRAC_WIDTH:0] fractb_i;   
   input 		signa_i;
   input 		signb_i;
   input 		start_i;
   output reg [2*FRAC_WIDTH+1:0] fract_o;
   output reg 		     sign_o;
   output reg 		     ready_o;
   
    parameter t_state_waiting = 1'b0;
	parameter t_state_busy = 1'b1;

   reg [47:0] 		     s_fract_o;
   reg [23:0] 		     s_fracta_i;
   reg [23:0] 		     s_fractb_i;
   reg 			     s_signa_i, s_signb_i;
   wire 		     s_sign_o;
   reg 			     s_start_i;
   reg 			     s_ready_o;
   reg 			     s_state;
   reg [4:0] 		     s_count;
   wire [23:0] 		     s_tem_prod;

   // Input Register
   always @(posedge clk_i)
     begin
	s_fracta_i <= fracta_i;
	s_fractb_i <= fractb_i;
	s_signa_i<= signa_i;
	s_signb_i<= signb_i;
	s_start_i <= start_i;
     end
   
   // Output Register
   always @(posedge clk_i)
     begin
	fract_o <= s_fract_o;
	sign_o <= s_sign_o;	
	ready_o <= s_ready_o;
     end

   assign s_sign_o = signa_i ^ signb_i;

   // FSM
   always @(posedge clk_i)
     if (s_start_i)
       begin
	  s_state <= t_state_busy;
	  s_count <= 0;
       end
     else if (s_count==23)
       begin
	  s_state <= t_state_waiting;
	  s_ready_o <= 1;
	  s_count <=0;
       end
     else if (s_state==t_state_busy)
       s_count <= s_count + 1;
     else
       begin
	  s_state <= t_state_waiting;
	  s_ready_o <= 0;
       end
   
   assign s_tem_prod[0] = s_fracta_i[0] & s_fractb_i[s_count];
   assign s_tem_prod[1] = s_fracta_i[1] & s_fractb_i[s_count];
   assign s_tem_prod[2] = s_fracta_i[2] & s_fractb_i[s_count];
   assign s_tem_prod[3] = s_fracta_i[3] & s_fractb_i[s_count];
   assign s_tem_prod[4] = s_fracta_i[4] & s_fractb_i[s_count];
   assign s_tem_prod[5] = s_fracta_i[5] & s_fractb_i[s_count];
   assign s_tem_prod[6] = s_fracta_i[6] & s_fractb_i[s_count];
   assign s_tem_prod[7] = s_fracta_i[7] & s_fractb_i[s_count];
   assign s_tem_prod[8] = s_fracta_i[8] & s_fractb_i[s_count];
   assign s_tem_prod[9] = s_fracta_i[9] & s_fractb_i[s_count];
   assign s_tem_prod[10] = s_fracta_i[10] & s_fractb_i[s_count];
   assign s_tem_prod[11] = s_fracta_i[11] & s_fractb_i[s_count];
   assign s_tem_prod[12] = s_fracta_i[12] & s_fractb_i[s_count];
   assign s_tem_prod[13] = s_fracta_i[13] & s_fractb_i[s_count];
   assign s_tem_prod[14] = s_fracta_i[14] & s_fractb_i[s_count];
   assign s_tem_prod[15] = s_fracta_i[15] & s_fractb_i[s_count];
   assign s_tem_prod[16] = s_fracta_i[16] & s_fractb_i[s_count];
   assign s_tem_prod[17] = s_fracta_i[17] & s_fractb_i[s_count];
   assign s_tem_prod[18] = s_fracta_i[18] & s_fractb_i[s_count];
   assign s_tem_prod[19] = s_fracta_i[19] & s_fractb_i[s_count];
   assign s_tem_prod[20] = s_fracta_i[20] & s_fractb_i[s_count];
   assign s_tem_prod[21] = s_fracta_i[21] & s_fractb_i[s_count];
   assign s_tem_prod[22] = s_fracta_i[22] & s_fractb_i[s_count];
   assign s_tem_prod[23] = s_fracta_i[23] & s_fractb_i[s_count];
   
   wire [47:0] v_prod_shl;
   assign v_prod_shl = {24'd0,s_tem_prod} << s_count[4:0];

   always @(posedge clk_i)
     if (s_state==t_state_busy)
       begin
	  if (|s_count)
	    s_fract_o <= v_prod_shl + s_fract_o;
	  else
	    s_fract_o <= v_prod_shl;
       end

endmodule // or1200_fpu_mul

//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Generic Two-Port Synchronous RAM                            ////
////                                                              ////
////  This file is part of memory library available from          ////
////  http://www.opencores.org/cvsweb.shtml/generic_memories/     ////
////                                                              ////
////  Description                                                 ////
////  This block is a wrapper with common two-port                ////
////  synchronous memory interface for different                  ////
////  types of ASIC and FPGA RAMs. Beside universal memory        ////
////  interface it also provides behavioral model of generic      ////
////  two-port synchronous RAM.                                   ////
////  It should be used in all OPENCORES designs that want to be  ////
////  portable accross different target technologies and          ////
////  independent of target memory.                               ////
////                                                              ////
////  Supported ASIC RAMs are:                                    ////
////  - Artisan Double-Port Sync RAM                              ////
////  - Avant! Two-Port Sync RAM (*)                              ////
////  - Virage 2-port Sync RAM                                    ////
////                                                              ////
////  Supported FPGA RAMs are:                                    ////
////  - Xilinx Virtex RAMB16                                      ////
////  - Xilinx Virtex RAMB4                                       ////
////  - Altera LPM                                                ////
////                                                              ////
////  To Do:                                                      ////
////   - fix Avant!                                               ////
////   - xilinx rams need external tri-state logic                ////
////   - add additional RAMs (VS etc)                             ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_tpram_32x32.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//
// Revision 1.5  2005/10/19 11:37:56  jcastillo
// Added support for RAMB16 Xilinx4/Spartan3 primitives
//
// Revision 1.4  2004/06/08 18:15:48  lampret
// Changed behavior of the simulation generic models
//
// Revision 1.3  2004/04/05 08:29:57  lampret
// Merged branch_qmem into main tree.
//
// Revision 1.2.4.1  2003/07/08 15:36:37  lampret
// Added embedded memory QMEM.
//
// Revision 1.2  2003/04/07 01:19:07  lampret
// Added Altera LPM RAMs. Changed generic RAM output when OE inactive.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.7  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.6  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.1  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.2  2001/07/30 05:38:02  lampret
// Adding empty directories required by HDL coding guidelines
//
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_tpram_32x32(
	// Generic synchronous two-port RAM interface
	clk_a, rst_a, ce_a, we_a, oe_a, addr_a, di_a, do_a,
	clk_b, rst_b, ce_b, we_b, oe_b, addr_b, di_b, do_b
);

//
// Default address and data buses width
//
parameter aw = 5;
parameter dw = 32;

//
// Generic synchronous two-port RAM interface
//
input			clk_a;	// Clock
input			rst_a;	// Reset
input			ce_a;	// Chip enable input
input			we_a;	// Write enable input
input			oe_a;	// Output enable input
input 	[aw-1:0]	addr_a;	// address bus inputs
input	[dw-1:0]	di_a;	// input data bus
output	[dw-1:0]	do_a;	// output data bus
input			clk_b;	// Clock
input			rst_b;	// Reset
input			ce_b;	// Chip enable input
input			we_b;	// Write enable input
input			oe_b;	// Output enable input
input 	[aw-1:0]	addr_b;	// address bus inputs
input	[dw-1:0]	di_b;	// input data bus
output	[dw-1:0]	do_b;	// output data bus

//
// Internal wires and registers
//

































































































































































































































//
// Generic two-port synchronous RAM model
//

//
// Generic RAM's registers and wires
//
reg	[dw-1:0]	mem [(1<<aw)-1:0];	// RAM content
reg	[aw-1:0]	addr_a_reg;		// RAM read address register
reg	[aw-1:0]	addr_b_reg;		// RAM read address register

//
// Data output drivers
//
assign do_a = (oe_a) ? mem[addr_a_reg] : {dw{1'b0}};
assign do_b = (oe_b) ? mem[addr_b_reg] : {dw{1'b0}};

//
// RAM write
//
always @(posedge clk_a)
	if (ce_a && we_a)
		mem[addr_a] <=  di_a;

//
// RAM write
//
always @(posedge clk_b)
	if (ce_b && we_b)
		mem[addr_b] <=  di_b;

//
// RAM read address register
//
always @(posedge clk_a or posedge rst_a)
	if (rst_a == (1'b1))
		addr_a_reg <=  {aw{1'b0}};
	else if (ce_a)
		addr_a_reg <=  addr_a;

//
// RAM read address register
//
always @(posedge clk_b or posedge rst_b)
	if (rst_b == (1'b1))
		addr_b_reg <=  {aw{1'b0}};
	else if (ce_b)
		addr_b_reg <=  addr_b;

	// !OR1200_ALTERA_LPM
	// !OR1200_XILINX_RAMB16
	// !OR1200_XILINX_RAMB4
	// !OR1200_VIRAGE_STP
	// !OR1200_AVANT_ATP
	// !OR1200_ARTISAN_SDP

endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's IC RAMs                                            ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of Instruction cache data rams                ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_ic_ram.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_ic_ram(
	// Clock and reset
	clk, rst, 






	// Internal i/f
	addr, en, we, datain, dataout
);

parameter dw = 32;
parameter aw = 13-2;

//
// I/O
//
input 				clk;
input				rst;
input	[aw-1:0]		addr;
input				en;
input	[3:0]			we;
input	[dw-1:0]		datain;
output	[dw-1:0]		dataout;






















//
// Instantiation of IC RAM block
//
   or1200_spram #
     (
      .aw(13-2),
      .dw(32)
      )
   ic_ram0
     (






      .clk(clk),
      .ce(en),
      .we(we[0]),
      //.oe(1'b1),
      .addr(addr),
      .di(datain),
      .doq(dataout)
      );   


endmodule

`timescale 1ps/1ps
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
////  interface it also provides behavioral model of generic      ////
////  single-port synchronous RAM.                                ////
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
////  - Xilinx Virtex RAMB16                                      ////
////  - Xilinx Virtex RAMB4                                       ////
////  - Altera LPM                                                ////
////                                                              ////
////  To Do:                                                      ////
////   - xilinx rams need external tri-state logic                ////
////   - fix avant! two-port ram                                  ////
////   - add additional RAMs                                      ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_spram_512x20.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//
// Revision 1.9  2005/10/19 11:37:56  jcastillo
// Added support for RAMB16 Xilinx4/Spartan3 primitives
//
// Revision 1.8  2004/06/08 18:15:32  lampret
// Changed behavior of the simulation generic models
//
// Revision 1.7  2004/04/05 08:29:57  lampret
// Merged branch_qmem into main tree.
//
// Revision 1.3.4.1  2003/12/09 11:46:48  simons
// Mbist nameing changed, Artisan ram instance signal names fixed, some synthesis waning fixed.
//
// Revision 1.3  2003/04/07 01:19:07  lampret
// Added Altera LPM RAMs. Changed generic RAM output when OE inactive.
//
// Revision 1.2  2002/10/17 20:04:40  lampret
// Added BIST scan. Special VS RAMs need to be used to implement BIST.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.10  2001/11/27 21:24:04  lampret
// Changed instantiation name of VS RAMs.
//
// Revision 1.9  2001/11/27 19:45:04  lampret
// Fixed VS RAM instantiation - again.
//
// Revision 1.8  2001/11/23 21:42:31  simons
// Program counter divided to PPC and NPC.
//
// Revision 1.6  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.5  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.1  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.2  2001/07/30 05:38:02  lampret
// Adding empty directories required by HDL coding guidelines
//
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_spram_512x20(




	// Generic synchronous single-port RAM interface
	clk, rst, ce, we, oe, addr, di, doq
);

//
// Default address and data buses width
//
parameter aw = 9;
parameter dw = 20;










//
// Generic synchronous single-port RAM interface
//
input			clk;	// Clock
input			rst;	// Reset
input			ce;	// Chip enable input
input			we;	// Write enable input
input			oe;	// Output enable input
input 	[aw-1:0]	addr;	// address bus inputs
input	[dw-1:0]	di;	// input data bus
output	[dw-1:0]	doq;	// output data bus

//
// Internal wires and registers
//





 // !OR1200_XILINX_RAMB16
 // !OR1200_XILINX_RAMB4

































































































































































































































//
// Generic single-port synchronous RAM model
//

//
// Generic RAM's registers and wires
//
reg	[dw-1:0]	mem [(1<<aw)-1:0];	// RAM content
reg	[aw-1:0]	addr_reg;		// RAM address register

//
// Data output drivers
//
assign doq = (oe) ? mem[addr_reg] : {dw{1'b0}};

//
// RAM address register
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		addr_reg <=  {aw{1'b0}};
	else if (ce)
		addr_reg <=  addr;

//
// RAM write
//
always @(posedge clk)
	if (ce && we)
		mem[addr] <=  di;

	// !OR1200_ALTERA_LPM
	// !OR1200_XILINX_RAMB16
	// !OR1200_XILINX_RAMB4
	// !OR1200_VIRTUALSILICON_SSP
	// !OR1200_VIRAGE_SSP
	// !OR1200_AVANT_ATP
	// !OR1200_ARTISAN_SSP

endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  or1200_fpu_intfloat_conv                                   ////
////  Only conversion between 32-bit integer and single          ////
////  precision floating point format                            ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
//// Modified by Julius Baxter, July, 2010                       ////
////             julius.baxter@orsoc.se                          ////
////                                                             ////
//// TODO: Fix bug where 1.0f in round up goes to integer 2      ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000 Rudolf Usselmann                         ////
////                    rudi@asics.ws                            ////
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

`timescale 1ns / 100ps

/*

 FPU Operations (fpu_op):
 ========================

 0 = 
 1 = 
 2 = 
 3 = 
 4 = int to float
 5 = float to int
 6 =
 7 =

 Rounding Modes (rmode):
 =======================

 0 = round_nearest_even
 1 = round_to_zero
 2 = round_up
 3 = round_down

 */


module or1200_fpu_intfloat_conv
  ( 
    clk, rmode, fpu_op, opa, out, snan, ine, inv,
    overflow, underflow, zero
    );
   input		clk;
   input [1:0] 		rmode;
   input [2:0] 		fpu_op;
   input [31:0] 	opa;
   output [31:0] 	out;
   output		snan;   
   output		ine;
   output 		inv;   
   output 		overflow;
   output 		underflow;   
   output		zero;


   parameter INF  = 31'h7f800000;
   parameter QNAN = 31'h7fc00001;
   parameter SNAN = 31'h7f800001;

   ////////////////////////////////////////////////////////////////////////
   //
   // Local Wires
   //
   reg zero;
	reg [31:0] opa_r; // Input operand registers
	reg [31:0] out; // Output register
	reg div_by_zero; // Divide by zero output register
	wire [7:0] exp_fasu; // Exponent output from EQU block
	reg [7:0] exp_r; // Exponent output (registered)
	wire co; // carry output
	wire [30:0] out_d; // Intermediate final result output
	wire overflow_d; // Overflow
	wire underflow_d; // Underflow
	reg inf; // Output Registers for INF
	reg snan; // Output Registers for S/QNAN
	reg qnan; // Output Registers for S/QNAN
	reg ine; // Output Registers for INE
	reg [1:0] rmode_r1; // Pipeline registers for round mode
	reg [1:0] rmode_r2; // Pipeline registers for round mode
	reg [1:0] rmode_r3; // Pipeline registers for round mode
	reg [2:0] fpu_op_r1; // Pipeline registers for fp operation
	reg [2:0] fpu_op_r2; // Pipeline registers for fp operation
	reg [2:0] fpu_op_r3; // Pipeline registers for fp operation


   ////////////////////////////////////////////////////////////////////////
     //
   // Input Registers
   //

   always @(posedge clk)
     opa_r <=  opa;


   always @(posedge clk)
     rmode_r1 <=  rmode;

   always @(posedge clk)
     rmode_r2 <=  rmode_r1;

   always @(posedge clk)
     rmode_r3 <=  rmode_r2;

   always @(posedge clk)
     fpu_op_r1 <=  fpu_op;

   always @(posedge clk)
     fpu_op_r2 <=  fpu_op_r1;

   always @(posedge clk)
     fpu_op_r3 <=  fpu_op_r2;

   ////////////////////////////////////////////////////////////////////////
   //
   // Exceptions block
   //
   wire 		inf_d, ind_d, qnan_d, snan_d, opa_nan;
   wire 		opa_00;   
   wire 		opa_inf;
   wire 		opa_dn;

   or1200_fpu_intfloat_conv_except u0
     (	.clk(clk),
	.opa(opa_r), 
	.opb(),
	.inf(inf_d), 
	.ind(ind_d),
	.qnan(qnan_d), 
	.snan(snan_d),
	.opa_nan(opa_nan), 
	.opb_nan(),
	.opa_00(opa_00),   
	.opb_00(),
	.opa_inf(opa_inf), 
	.opb_inf(),
	.opa_dn(opa_dn), 
	.opb_dn()
	);

   ////////////////////////////////////////////////////////////////////////
   //
   // Pre-Normalize block
   // - Adjusts the numbers to equal exponents and sorts them
   // - determine result sign
   // - determine actual operation to perform (add or sub)
   //

   wire 		nan_sign_d, result_zero_sign_d;
   reg 			sign_fasu_r;
   wire [1:0] 		exp_ovf;
   reg [1:0] 		exp_ovf_r;
  
   // This is all we need from post-norm module for int-float conversion
   reg 			opa_sign_r;
   always @(posedge clk)
     opa_sign_r <= opa_r[31];
   
   always @(posedge clk)
     sign_fasu_r <=  opa_sign_r; //sign_fasu;


   ////////////////////////////////////////////////////////////////////////
   //
   // Normalize Result
   //
   wire 		ine_d;
   wire 		inv_d;   
   wire 		sign_d;
   reg 			sign;
   reg [30:0] 		opa_r1;
   reg [47:0] 		fract_i2f;
   reg 			opas_r1, opas_r2;
   wire 		f2i_out_sign;
   wire [47:0] 		fract_denorm;

   always @(posedge clk)  // Exponent must be once cycle delayed
     case(fpu_op_r2)
       //4:	exp_r <=  0;
       5:	exp_r <=  opa_r1[30:23];
       default: exp_r <=  0;
     endcase

   always @(posedge clk)
     opa_r1 <=  opa_r[30:0];
   
   always @(posedge clk)
     fract_i2f <=  (fpu_op_r2==5) ?
		   (sign_d ?  1-{24'h00, (|opa_r1[30:23]), opa_r1[22:0]}-1 : 
		    {24'h0, (|opa_r1[30:23]), opa_r1[22:0]})
       : (sign_d ? 1 - {opa_r1, 17'h01} : {opa_r1, 17'h0});

   assign fract_denorm = fract_i2f;
   
   always @(posedge clk)
     opas_r1 <=  opa_r[31];

   always @(posedge clk)
     opas_r2 <=  opas_r1;

   assign sign_d = opa_sign_r; //sign_fasu;

   always @(posedge clk)
     sign <=  (rmode_r2==2'h3) ? !sign_d : sign_d;


   // Special case of largest negative integer we can convert to - usually
   // gets picked up as invalid, but really it's not, so deal with it as a
   // special case.
   wire 		f2i_special_case_no_inv;
   assign f2i_special_case_no_inv = (opa == 32'hcf000000);
   

   or1200_fpu_post_norm_intfloat_conv u4
     (
      .clk(clk),			// System Clock
      .fpu_op(fpu_op_r3),		// Floating Point Operation
      .opas(opas_r2),			// OPA Sign
      .sign(sign),			// Sign of the result
      .rmode(rmode_r3),		// Rounding mode
      .fract_in(fract_denorm),	// Fraction Input

      .exp_in(exp_r),			// Exponent Input
      .opa_dn(opa_dn),		// Operand A Denormalized
      .opa_nan(opa_nan),
      .opa_inf(opa_inf),
      
      .opb_dn(),		// Operand B Denormalized
      .out(out_d),		// Normalized output (un-registered)
      .ine(ine_d),		// Result Inexact output (un-registered)
      .inv(inv_d),            // Invalid input for f2i operation
      .overflow(overflow_d),	// Overflow output (un-registered)
      .underflow(underflow_d),// Underflow output (un-registered)
      .f2i_out_sign(f2i_out_sign)	// F2I Output Sign
      );

   ////////////////////////////////////////////////////////////////////////
     //
   // FPU Outputs
   //
   reg 			fasu_op_r1, fasu_op_r2;
   wire [30:0] 		out_fixed;
   wire 		output_zero_fasu;
   wire 		overflow_fasu;
   wire 		out_d_00;
   wire 		ine_fasu;
   wire 		underflow_fasu;   


   /*
    always @(posedge clk)
    fasu_op_r1 <=  fasu_op;

    always @(posedge clk)
    fasu_op_r2 <=  fasu_op_r1;
    */
   // Force pre-set values for non numerical output

   assign out_fixed = (	(qnan_d | snan_d) |
			(ind_d /*& !fasu_op_r2*/))  ? QNAN : INF;

   always @(posedge clk)
     out[30:0] <=  /*((inf_d & (fpu_op_r3!=3'b101)) | snan_d | qnan_d) 
		    & fpu_op_r3!=3'b100 ? out_fixed :*/ out_d;

   assign out_d_00 = !(|out_d);


   always @(posedge clk)
     out[31] <= (fpu_op_r3==3'b101) ? 
		f2i_out_sign : sign_fasu_r; 
   
   
   
   // Exception Outputs
   assign ine_fasu = (ine_d | overflow_d | underflow_d) & 
		     !(snan_d | qnan_d | inf_d);

   always @(posedge  clk)
     ine <= 	 fpu_op_r3[2] ? ine_d : ine_fasu;

   assign overflow = overflow_d & !(snan_d | qnan_d | inf_d);
   assign underflow = underflow_d & !(inf_d | snan_d | qnan_d);

   always @(posedge clk)
     snan <=  snan_d & (fpu_op_r3==3'b101);  // Only signal sNaN when ftoi

   // Status Outputs   
   assign output_zero_fasu = out_d_00 & !(inf_d | snan_d | qnan_d);

   always @(posedge clk)
     zero <= 	fpu_op_r3==3'b101 ? out_d_00 & !(snan_d | qnan_d) :
	     output_zero_fasu ;
   assign inv = inv_d & !f2i_special_case_no_inv;
   
endmodule // or1200_fpu_intfloat_conv
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_div                                              ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  division entity for the division unit                       ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_div
  (
   clk_i,
   dvdnd_i,
   dvsor_i,
   sign_dvd_i,
   sign_div_i,
   start_i,
   ready_o,
   qutnt_o,
   rmndr_o,
   sign_o,
   div_zero_o
   );

   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;


   input clk_i;
   input [2*(FRAC_WIDTH+2)-1:0] dvdnd_i;
   input [FRAC_WIDTH+3:0] 	dvsor_i;
   input 			sign_dvd_i;
   input 			sign_div_i;
   input 			start_i;
   output 			ready_o;
   output [FRAC_WIDTH+3:0] 	qutnt_o;
   output [FRAC_WIDTH+3:0] 	rmndr_o;
   output 			sign_o;
   output 			div_zero_o;
   
   parameter t_state_waiting = 1'b0;
   parameter t_state_busy = 1'b1;
   
   reg [FRAC_WIDTH+3:0] 	s_qutnt_o;
   reg [FRAC_WIDTH+3:0] 	s_rmndr_o;   
   reg [2*(FRAC_WIDTH+2)-1:0] 	s_dvdnd_i;   
   reg [FRAC_WIDTH+3:0] 	s_dvsor_i;
   reg 				s_sign_dvd_i, s_sign_div_i;
   wire 			s_sign_o;
   wire 			s_div_zero_o;
   reg 				s_start_i;
   reg 				s_ready_o;
   reg 				s_state;
   reg [4:0] 			s_count;
   reg [FRAC_WIDTH+3:0] 	s_dvd;

   // Input Register
   always @(posedge clk_i)
     begin
	s_dvdnd_i <= dvdnd_i;
	s_dvsor_i <= dvsor_i;
	s_sign_dvd_i<= sign_dvd_i;
	s_sign_div_i<= sign_div_i;
	s_start_i <= start_i;
     end
   
   assign qutnt_o = s_qutnt_o;
   assign rmndr_o = s_rmndr_o;
   assign sign_o = s_sign_o;	
   assign ready_o = s_ready_o;
   assign div_zero_o = s_div_zero_o;

   assign s_sign_o = sign_dvd_i ^ sign_div_i;
   assign s_div_zero_o = !(|s_dvsor_i) & (|s_dvdnd_i);
   

   always @(posedge clk_i)
     if (s_start_i)
       begin
	  s_state <= t_state_busy;
	  s_count <= 26;
       end
     else if (!(|s_count) & s_state==t_state_busy)
       begin
	  s_state <= t_state_waiting;
	  s_ready_o <= 1;
	  s_count <=26;
       end
     else if (s_state==t_state_busy)
       s_count <= s_count - 1;
     else
       begin
	  s_state <= t_state_waiting;
	  s_ready_o <= 0;
       end

   wire [26:0] v_div;
   assign v_div = (s_count==26) ? {3'd0,s_dvdnd_i[49:26]} : s_dvd;
   wire [26:0] v_div_minus_s_dvsor_i;
   assign v_div_minus_s_dvsor_i = v_div - s_dvsor_i;
   

   always @(posedge clk_i)
     begin
	//Reset
	if (s_start_i)
	  begin
	     s_qutnt_o <= 0;
	     s_rmndr_o <= 0;
	  end
	else if (s_state==t_state_busy)
	  begin

	     if (v_div < s_dvsor_i)
	       begin
		  s_qutnt_o[s_count] <= 1'b0;
		  s_dvd <= {v_div[25:0],1'b0};		  
	       end
	     else
	       begin
		  s_qutnt_o[s_count] <= 1'b1;
		  s_dvd <= {v_div_minus_s_dvsor_i[25:0],1'b0};		  
	       end

	     s_rmndr_o <= v_div;

	  end // if (s_state==t_state_busy)
     end // always @ (posedge clk_i)

endmodule // or1200_fpu_div

//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's DC TAG RAMs                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Instatiation of data cache tag rams.                        ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_dc_tag.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_dc_tag(
	// Clock and reset
	clk, rst,






	// Internal i/f
	addr, en, we, datain, tag_v, tag, dirty
);

parameter dw = 20+1;
parameter aw = 13-4;

//
// I/O
//
input				clk;
input				rst;
input	[aw-1:0]		addr;
input				en;
input				we;
input	[dw-1:0]		datain;
output				tag_v;
output	[dw-3:0]		tag;
output  			dirty;
   























//
// Instantiation of TAG RAM block
//
// Data widths are tag width plus one for valid
   or1200_spram #
     (
      .aw(13-4),
      .dw(20 + 1)
      )
   dc_tag0
     (






      .clk(clk),
      .ce(en),
      .we(we),
      .addr(addr),
      .di(datain),
      .doq({tag, tag_v, dirty})
      );


endmodule // or1200_dc_tag
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Data MMU top level                                 ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of all DMMU blocks.                           ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_dmmu_top.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed. 
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

//
// Data MMU
//

module or1200_dmmu_top(
	// Rst and clk
	clk, rst,

	// CPU i/f
	dc_en, dmmu_en, supv, dcpu_adr_i, dcpu_cycstb_i, dcpu_we_i,
	dcpu_tag_o, dcpu_err_o,

	// SPR access
	spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o,






	// DC i/f
	qmemdmmu_err_i, qmemdmmu_tag_i, qmemdmmu_adr_o, qmemdmmu_cycstb_o, qmemdmmu_ci_o
);

parameter dw = 32;
parameter aw = 32;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// CPU I/F
//
input				dc_en;
input				dmmu_en;
input				supv;
input	[aw-1:0]		dcpu_adr_i;
input				dcpu_cycstb_i;
input				dcpu_we_i;
output	[3:0]			dcpu_tag_o;
output				dcpu_err_o;

//
// SPR access
//
input				spr_cs;
input				spr_write;
input	[aw-1:0]		spr_addr;
input	[31:0]			spr_dat_i;
output	[31:0]			spr_dat_o;










//
// DC I/F
//
input				qmemdmmu_err_i;
input	[3:0]			qmemdmmu_tag_i;
output	[aw-1:0]		qmemdmmu_adr_o;
output				qmemdmmu_cycstb_o;
output				qmemdmmu_ci_o;

//
// Internal wires and regs
//
wire				dtlb_spr_access;
wire	[31:13]	dtlb_ppn;
wire				dtlb_hit;
wire				dtlb_uwe;
wire				dtlb_ure;
wire				dtlb_swe;
wire				dtlb_sre;
wire	[31:0]			dtlb_dat_o;
wire				dtlb_en;
wire				dtlb_ci;
wire				fault;
wire				miss;


reg				dtlb_done;
reg	[31:13]	dcpu_vpn_r;


//
// Implemented bits inside match and translate registers
//
// dtlbwYmrX: vpn 31-10  v 0
// dtlbwYtrX: ppn 31-10  swe 9  sre 8  uwe 7  ure 6
//
// dtlb memory width:
// 19 bits for ppn
// 13 bits for vpn
// 1 bit for valid
// 4 bits for protection
// 1 bit for cache inhibit


















//
// DTLB SPR access
//
// 0A00 - 0AFF  dtlbmr w0
// 0A00 - 0A3F  dtlbmr w0 [63:0]
//
// 0B00 - 0BFF  dtlbtr w0
// 0B00 - 0B3F  dtlbtr w0 [63:0]
//
assign dtlb_spr_access = spr_cs;

//
// Tags:
//
// OR1200_DTAG_TE - TLB miss Exception
// OR1200_DTAG_PE - Page fault Exception
//
assign dcpu_tag_o = miss ? 4'hd : fault ? 4'hc : qmemdmmu_tag_i;

//
// dcpu_err_o
//
assign dcpu_err_o = miss | fault | qmemdmmu_err_i;

//
// Assert dtlb_done one clock cycle after new address and dtlb_en must be active
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		dtlb_done <=  1'b0;
	else if (dtlb_en)
		dtlb_done <=  dcpu_cycstb_i;
	else
		dtlb_done <=  1'b0;

//
// Cut transfer if something goes wrong with translation. Also delayed signals 
// because of translation delay.
assign qmemdmmu_cycstb_o = (dc_en & dmmu_en) ? 
			   !(miss | fault) & dtlb_done & dcpu_cycstb_i : 
			   !(miss | fault) & dcpu_cycstb_i;


//
// Cache Inhibit
//
assign qmemdmmu_ci_o = dmmu_en ? dtlb_ci : dcpu_adr_i[31];

//
// Register dcpu_adr_i's VPN for use when DMMU is not enabled but PPN is 
// expected to come one clock cycle after offset part.
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		dcpu_vpn_r <=  {32-13{1'b0}};
	else
		dcpu_vpn_r <=  dcpu_adr_i[31:13];

//
// Physical address is either translated virtual address or
// simply equal when DMMU is disabled
//
assign qmemdmmu_adr_o = dmmu_en ? {dtlb_ppn, dcpu_adr_i[13-1:0]} :
			          dcpu_adr_i;

//
// Output to SPRS unit
//
assign spr_dat_o = dtlb_spr_access ? dtlb_dat_o : 32'h00000000;

//
// Page fault exception logic
//
assign fault = dtlb_done &
	(  (!dcpu_we_i & !supv & !dtlb_ure) // Load in user mode not enabled
	   || (!dcpu_we_i & supv & !dtlb_sre) // Load in supv mode not enabled
	   || (dcpu_we_i & !supv & !dtlb_uwe) // Store in user mode not enabled
	   || (dcpu_we_i & supv & !dtlb_swe)); // Store in supv mode not enabled

//
// TLB Miss exception logic
//
assign miss = dtlb_done & !dtlb_hit;

//
// DTLB Enable
//
assign dtlb_en = dmmu_en & dcpu_cycstb_i;

//
// Instantiation of DTLB
//
or1200_dmmu_tlb or1200_dmmu_tlb(
	// Rst and clk
        .clk(clk),
	.rst(rst),

        // I/F for translation
        .tlb_en(dtlb_en),
	.vaddr(dcpu_adr_i),
	.hit(dtlb_hit),
	.ppn(dtlb_ppn),
	.uwe(dtlb_uwe),
	.ure(dtlb_ure),
	.swe(dtlb_swe),
	.sre(dtlb_sre),
	.ci(dtlb_ci),








        // SPR access
        .spr_cs(dtlb_spr_access),
	.spr_write(spr_write),
	.spr_addr(spr_addr),
	.spr_dat_i(spr_dat_i),
	.spr_dat_o(dtlb_dat_o)
);



endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_post_norm_mul                                    ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  post-normalization entity for the multiplication unit       ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_post_norm_mul(
		     clk_i,
		     opa_i,
		     opb_i,
		     exp_10_i,
		     fract_48_i,
		     sign_i,
		     rmode_i,
		     output_o,
		     ine_o
		     );

   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;

   input clk_i;
   input [FP_WIDTH-1:0] opa_i;
   input [FP_WIDTH-1:0] opb_i;
   input [EXP_WIDTH+1:0] exp_10_i;
   input [2*FRAC_WIDTH+1:0] fract_48_i;
   input 		    sign_i;
   input [1:0] 		    rmode_i;
   output reg [FP_WIDTH-1:0]    output_o;
   output reg 		    ine_o;

   
   reg [EXP_WIDTH-1:0]     s_expa;
   reg [EXP_WIDTH-1:0]     s_expb;
   reg [EXP_WIDTH+1:0]     s_exp_10_i;
   reg [2*FRAC_WIDTH+1:0]  s_fract_48_i;
   reg 			   s_sign_i;   
   wire [FP_WIDTH-1:0] 	    s_output_o;
   wire 		    s_ine_o;
   wire 		    s_overflow;   
   reg [FP_WIDTH-1:0] 	    s_opa_i;
   reg [FP_WIDTH-1:0] 	    s_opb_i;
   reg [1:0] 		    s_rmode_i;

   reg [5:0] 		    s_zeros;
   wire 		    s_carry;   
   reg [5:0] 		    s_shr2;
   reg [5:0] 		    s_shl2;
   reg [8:0] 		    s_expo1;
   wire [8:0] 		    s_expo2b;
   wire [9:0] 		    s_exp_10a;
   wire [9:0] 		    s_exp_10b;
   reg [47:0] 		    s_frac2a;

   wire 		    s_sticky, s_guard, s_round;   
   wire 		    s_roundup;   
   reg [24:0] 		    s_frac_rnd;
   wire [24:0] 		    s_frac3;
   wire 		    s_shr3;   
   reg [5:0] 		    s_r_zeros;
   wire 		    s_lost;   
   wire 		    s_op_0;   
   wire [8:0] 		    s_expo3;

   wire 		    s_infa, s_infb;   
   wire 		    s_nan_in, s_nan_op, s_nan_a, s_nan_b;   

   
   // Input Register
   always @(posedge clk_i)
     begin
	s_opa_i <= opa_i;
	s_opb_i <= opb_i;	
	s_expa <= opa_i[30:23];
	s_expb <= opb_i[30:23];
	s_exp_10_i <= exp_10_i;
	s_fract_48_i <= fract_48_i;
	s_sign_i <= sign_i;
	s_rmode_i <= rmode_i;
     end

   // Output register
   always @(posedge clk_i)
     begin
	output_o <= s_output_o;
	ine_o	<= s_ine_o;
     end

   //*** Stage 1 ****
   // figure out the exponent and howmuch the fraction has to be shiftd 
   // right/left
	
   assign s_carry = s_fract_48_i[47];
   
   
   always @(posedge clk_i)
     if (!s_fract_48_i[47])
       casez(s_fract_48_i[46:1])	// synopsys full_case parallel_case
	 46'b1?????????????????????????????????????????????: s_zeros <=  0;
	 46'b01????????????????????????????????????????????: s_zeros <=  1;
	 46'b001???????????????????????????????????????????: s_zeros <=  2;
	 46'b0001??????????????????????????????????????????: s_zeros <=  3;
	 46'b00001?????????????????????????????????????????: s_zeros <=  4;
	 46'b000001????????????????????????????????????????: s_zeros <=  5;
	 46'b0000001???????????????????????????????????????: s_zeros <=  6;
	 46'b00000001??????????????????????????????????????: s_zeros <=  7;
	 46'b000000001?????????????????????????????????????: s_zeros <=  8;
	 46'b0000000001????????????????????????????????????: s_zeros <=  9;
	 46'b00000000001???????????????????????????????????: s_zeros <=  10;
	 46'b000000000001??????????????????????????????????: s_zeros <=  11;
	 46'b0000000000001?????????????????????????????????: s_zeros <=  12;
	 46'b00000000000001????????????????????????????????: s_zeros <=  13;
	 46'b000000000000001???????????????????????????????: s_zeros <=  14;
	 46'b0000000000000001??????????????????????????????: s_zeros <=  15;
	 46'b00000000000000001?????????????????????????????: s_zeros <=  16;
	 46'b000000000000000001????????????????????????????: s_zeros <=  17;
	 46'b0000000000000000001???????????????????????????: s_zeros <=  18;
	 46'b00000000000000000001??????????????????????????: s_zeros <=  19;
	 46'b000000000000000000001?????????????????????????: s_zeros <=  20;
	 46'b0000000000000000000001????????????????????????: s_zeros <=  21;
	 46'b00000000000000000000001???????????????????????: s_zeros <=  22;
	 46'b000000000000000000000001??????????????????????: s_zeros <=  23;
	 46'b0000000000000000000000001?????????????????????: s_zeros <=  24;
	 46'b00000000000000000000000001????????????????????: s_zeros <=  25;
	 46'b000000000000000000000000001???????????????????: s_zeros <=  26;
	 46'b0000000000000000000000000001??????????????????: s_zeros <=  27;
	 46'b00000000000000000000000000001?????????????????: s_zeros <=  28;
	 46'b000000000000000000000000000001????????????????: s_zeros <=  29;
	 46'b0000000000000000000000000000001???????????????: s_zeros <=  30;
	 46'b00000000000000000000000000000001??????????????: s_zeros <=  31;
	 46'b000000000000000000000000000000001?????????????: s_zeros <=  32;
	 46'b0000000000000000000000000000000001????????????: s_zeros <=  33;
	 46'b00000000000000000000000000000000001???????????: s_zeros <=  34;
	 46'b000000000000000000000000000000000001??????????: s_zeros <=  35;
	 46'b0000000000000000000000000000000000001?????????: s_zeros <=  36;
	 46'b00000000000000000000000000000000000001????????: s_zeros <=  37;
	 46'b000000000000000000000000000000000000001???????: s_zeros <=  38;
	 46'b0000000000000000000000000000000000000001??????: s_zeros <=  39;
	 46'b00000000000000000000000000000000000000001?????: s_zeros <=  40;
	 46'b000000000000000000000000000000000000000001????: s_zeros <=  41;
	 46'b0000000000000000000000000000000000000000001???: s_zeros <=  42;
	 46'b00000000000000000000000000000000000000000001??: s_zeros <=  43;
	 46'b000000000000000000000000000000000000000000001?: s_zeros <=  44;
	 46'b0000000000000000000000000000000000000000000001: s_zeros <=  45;
	 46'b0000000000000000000000000000000000000000000000: s_zeros <=  46;
       endcase // casex (s_fract_48_i[46:1])
     else
       s_zeros <= 0;


   always @(posedge clk_i)
     casez(s_fract_48_i) // synopsys full_case parallel_case
       48'b???????????????????????????????????????????????1: s_r_zeros <=  0;
       48'b??????????????????????????????????????????????10: s_r_zeros <=  1;
       48'b?????????????????????????????????????????????100: s_r_zeros <=  2;
       48'b????????????????????????????????????????????1000: s_r_zeros <=  3;
       48'b???????????????????????????????????????????10000: s_r_zeros <=  4;
       48'b??????????????????????????????????????????100000: s_r_zeros <=  5;
       48'b?????????????????????????????????????????1000000: s_r_zeros <=  6;
       48'b????????????????????????????????????????10000000: s_r_zeros <=  7;
       48'b???????????????????????????????????????100000000: s_r_zeros <=  8;
       48'b??????????????????????????????????????1000000000: s_r_zeros <=  9;
       48'b?????????????????????????????????????10000000000: s_r_zeros <=  10;
       48'b????????????????????????????????????100000000000: s_r_zeros <=  11;
       48'b???????????????????????????????????1000000000000: s_r_zeros <=  12;
       48'b??????????????????????????????????10000000000000: s_r_zeros <=  13;
       48'b?????????????????????????????????100000000000000: s_r_zeros <=  14;
       48'b????????????????????????????????1000000000000000: s_r_zeros <=  15;
       48'b???????????????????????????????10000000000000000: s_r_zeros <=  16;
       48'b??????????????????????????????100000000000000000: s_r_zeros <=  17;
       48'b?????????????????????????????1000000000000000000: s_r_zeros <=  18;
       48'b????????????????????????????10000000000000000000: s_r_zeros <=  19;
       48'b???????????????????????????100000000000000000000: s_r_zeros <=  20;
       48'b??????????????????????????1000000000000000000000: s_r_zeros <=  21;
       48'b?????????????????????????10000000000000000000000: s_r_zeros <=  22;
       48'b????????????????????????100000000000000000000000: s_r_zeros <=  23;
       48'b???????????????????????1000000000000000000000000: s_r_zeros <=  24;
       48'b??????????????????????10000000000000000000000000: s_r_zeros <=  25;
       48'b?????????????????????100000000000000000000000000: s_r_zeros <=  26;
       48'b????????????????????1000000000000000000000000000: s_r_zeros <=  27;
       48'b???????????????????10000000000000000000000000000: s_r_zeros <=  28;
       48'b??????????????????100000000000000000000000000000: s_r_zeros <=  29;
       48'b?????????????????1000000000000000000000000000000: s_r_zeros <=  30;
       48'b????????????????10000000000000000000000000000000: s_r_zeros <=  31;
       48'b???????????????100000000000000000000000000000000: s_r_zeros <=  32;
       48'b??????????????1000000000000000000000000000000000: s_r_zeros <=  33;
       48'b?????????????10000000000000000000000000000000000: s_r_zeros <=  34;
       48'b????????????100000000000000000000000000000000000: s_r_zeros <=  35;
       48'b???????????1000000000000000000000000000000000000: s_r_zeros <=  36;
       48'b??????????10000000000000000000000000000000000000: s_r_zeros <=  37;
       48'b?????????100000000000000000000000000000000000000: s_r_zeros <=  38;
       48'b????????1000000000000000000000000000000000000000: s_r_zeros <=  39;
       48'b???????10000000000000000000000000000000000000000: s_r_zeros <=  40;
       48'b??????100000000000000000000000000000000000000000: s_r_zeros <=  41;
       48'b?????1000000000000000000000000000000000000000000: s_r_zeros <=  42;
       48'b????10000000000000000000000000000000000000000000: s_r_zeros <=  43;
       48'b???100000000000000000000000000000000000000000000: s_r_zeros <=  44;
       48'b??1000000000000000000000000000000000000000000000: s_r_zeros <=  45;
       48'b?10000000000000000000000000000000000000000000000: s_r_zeros <=  46;
       48'b100000000000000000000000000000000000000000000000: s_r_zeros <=  47;
       48'b000000000000000000000000000000000000000000000000: s_r_zeros <=  48;
     endcase // casex (s_fract_48_i)

   assign s_exp_10a = s_exp_10_i + {9'd0,s_carry};		
   assign s_exp_10b = s_exp_10a - {4'd0,s_zeros};

   wire [9:0] v_shr1;
   wire [9:0] v_shl1;
   
   assign v_shr1 = (s_exp_10a[9] | !(|s_exp_10a)) ?
		   10'd1 - s_exp_10a + {9'd0,s_carry} :
		   (s_exp_10b[9] | !(|s_exp_10b)) ?
		   0 :
		   s_exp_10b[8] ?
		   0 : {9'd0,s_carry};
   
   assign v_shl1 = (s_exp_10a[9] | !(|s_exp_10a)) ?
		   0 :
		   (s_exp_10b[9] | !(|s_exp_10b)) ?
		   {4'd0,s_zeros} - s_exp_10a :
		   s_exp_10b[8] ?
		   0 : {4'd0,s_zeros};
   
		   
   always @(posedge clk_i)
     begin
	if ((s_exp_10a[9] | !(|s_exp_10a)))
	  s_expo1 <= 9'd1;
	else if (s_exp_10b[9] | !(|s_exp_10b))
	  s_expo1 <= 9'd1;
	else if (s_exp_10b[8])
	  s_expo1 <= 9'b011111111;
	else
	  s_expo1 <= s_exp_10b[8:0];
	
	if (v_shr1[6])
	  s_shr2 <= {6{1'b1}};
	else
	  s_shr2 <= v_shr1[5:0];

	s_shl2 <= v_shl1[5:0];
     end // always @ (posedge clk_i)
   	
   // *** Stage 2 ***
   // Shifting the fraction and rounding
		
		
   // shift the fraction
   always @(posedge clk_i)
     if (|s_shr2)
       s_frac2a <= s_fract_48_i >> s_shr2;
     else 
       s_frac2a <= s_fract_48_i << s_shl2; 
	
   assign s_expo2b = s_frac2a[46] ? s_expo1 : s_expo1 - 9'd1;

   // signals if precision was last during the right-shift above
   assign s_lost = (s_shr2 + {5'd0,s_shr3}) > s_r_zeros;
   
   // ***Stage 3***
   // Rounding

   //								   23
   //									|	
   // 			xx00000000000000000000000grsxxxxxxxxxxxxxxxxxxxx
   // guard bit: s_frac2a[23] (LSB of output)
   // round bit: s_frac2a[22]
   assign s_guard = s_frac2a[22];
   assign s_round = s_frac2a[21];
   assign s_sticky = (|s_frac2a[20:0]) | s_lost;
   
   assign s_roundup = s_rmode_i==2'b00 ? // round to nearest even
		      s_guard & ((s_round | s_sticky) | s_frac2a[23]) :
		      s_rmode_i==2'b10 ? // round up
		      (s_guard | s_round | s_sticky) & !s_sign_i :
		      s_rmode_i==2'b11 ? // round down
		      (s_guard | s_round | s_sticky) & s_sign_i : 
		      0; // round to zero(truncate = no rounding)
   
   
   always @(posedge clk_i)
     if (s_roundup)
       s_frac_rnd <= s_frac2a[47:23] + 1; 
     else 
       s_frac_rnd <= s_frac2a[47:23];
	
   assign s_shr3 = s_frac_rnd[24];


   assign s_expo3 = (s_shr3 & (s_expo2b!=9'b011111111)) ? 
		     s_expo2b + 1 : s_expo2b;
   
   assign s_frac3 = (s_shr3 & (s_expo2b!=9'b011111111)) ? 
		     {1'b0,s_frac_rnd[24:1]} : s_frac_rnd; 
	
   //-***Stage 4****
   // Output
		
   assign s_op_0 = !((|s_opa_i[30:0]) & (|s_opb_i[30:0]));
	
   assign s_infa = &s_expa;
   
   assign s_infb = &s_expb;
      
   assign s_nan_a = s_infa & (|s_opa_i[22:0]);
   
   assign s_nan_b = s_infb & (|s_opb_i[22:0]);
   
   assign s_nan_in = s_nan_a | s_nan_b;
   
   assign s_nan_op = (s_infa | s_infb) & s_op_0; // 0 * inf = nan
   
   assign s_overflow = (s_expo3==9'b011111111) & !(s_infa | s_infb);
   
   assign s_ine_o = !s_op_0 & (s_lost | (|s_frac2a[22:0]) | s_overflow);
   
   assign s_output_o = (s_nan_in | s_nan_op) ?
		       {s_sign_i,QNAN} :
		       (s_infa | s_infb) | s_overflow ?
		       {s_sign_i,INF} :
		       s_r_zeros==48 ?
		       {s_sign_i,ZERO_VECTOR} :
		       {s_sign_i,s_expo3[7:0],s_frac3[22:0]};

endmodule // or1200_fpu_post_norm_mul

//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Generic Single-Port Synchronous RAM with byte write signals ////
////                                                              ////
////  This file is part of memory library available from          ////
////  http://www.opencores.org/cvsweb.shtml/generic_memories/     ////
////                                                              ////
////  Description                                                 ////
////  This block is a wrapper with common single-port             ////
////  synchronous memory interface for different                  ////
////  types of ASIC and FPGA RAMs. Beside universal memory        ////
////  interface it also provides behavioral model of generic      ////
////  single-port synchronous RAM.                                ////
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
////  - Xilinx Virtex RAMB16                                      ////
////  - Xilinx Virtex RAMB4                                       ////
////                                                              ////
////  To Do:                                                      ////
////   - xilinx rams need external tri-state logic                ////
////   - fix avant! two-port ram                                  ////
////   - add additional RAMs                                      ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_spram_2048x32_bw.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//
// Revision 1.5  2005/10/19 11:37:56  jcastillo
// Added support for RAMB16 Xilinx4/Spartan3 primitives
//
// Revision 1.4  2004/06/08 18:15:32  lampret
// Changed behavior of the simulation generic models
//
// Revision 1.3  2003/10/17 07:59:44  markom
// mbist signals updated according to newest convention
//
// Revision 1.2  2003/09/12 09:03:54  dries
// correct all the syntax errors
//
// Revision 1.1  2003/08/26 09:37:02  simons
// Added support for rams with byte write access.
//
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_spram_2048x32_bw(




        // Generic synchronous single-port RAM interface
        clk, rst, ce, we, oe, addr, di, doq
);










//
// Generic synchronous single-port RAM interface
//
input                   clk;    // Clock
input                   rst;    // Reset
input                   ce;     // Chip enable input
input   [3:0]           we;     // Write enable input
input                   oe;     // Output enable input
input   [10:0]          addr;   // address bus inputs
input   [31:0]          di;     // input data bus
output  [31:0]          doq;     // output data bus

//
// Internal wires and registers
//













































































































































































































































































































































































































































































































//
// Generic single-port synchronous RAM model
//

//
// Generic RAM's registers and wires
//
reg     [7:0]        mem_0 [2047:0];              // RAM content
reg     [7:0]        mem_1 [2047:0];              // RAM content
reg     [7:0]        mem_2 [2047:0];              // RAM content
reg     [7:0]        mem_3 [2047:0];              // RAM content
reg     [10:0]       addr_reg;                    // RAM address register
                                                                                                                                                                                                     
//
// Data output drivers
//
assign doq = (oe) ? {mem_3[addr_reg], mem_2[addr_reg], mem_1[addr_reg], mem_0[addr_reg]} : {32{1'b0}};
                                                                                                                                                                                                     
//
// RAM address register
//
always @(posedge clk or posedge rst)
        if (rst == (1'b1))
                addr_reg <=  11'h000;
        else if (ce)
                addr_reg <=  addr;
                                                                                                                                                                                                     
//
// RAM write byte 0
//
always @(posedge clk)
        if (ce && we[0])
                mem_0[addr] <=  di[7:0];
                                                                                                                                                                                                     
//
// RAM write byte 1
//
always @(posedge clk)
        if (ce && we[1])
                mem_1[addr] <=  di[15:8];
                                                                                                                                                                                                     
//
// RAM write byte 2
//
always @(posedge clk)
        if (ce && we[2])
                mem_2[addr] <=  di[23:16];
                                                                                                                                                                                                     
//
// RAM write byte 3
//
always @(posedge clk)
        if (ce && we[3])
                mem_3[addr] <=  di[31:24];

  // !OR1200_XILINX_RAMB16
  // !OR1200_XILINX_RAMB4
  // !OR1200_VIRTUALSILICON_SSP
  // !OR1200_VIRAGE_SSP
  // !OR1200_AVANT_ATP
  // !OR1200_ARTISAN_SSP

endmodule
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
////  interface it also provides behavioral model of generic      ////
////  single-port synchronous RAM.                                ////
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
////  - Xilinx Virtex RAMBS16                                     ////
////  - Xilinx Virtex RAMB4                                       ////
////  - Altera LPM                                                ////
////                                                              ////
////  To Do:                                                      ////
////   - xilinx rams need external tri-state logic                ////
////   - fix avant! two-port ram                                  ////
////   - add additional RAMs                                      ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_spram_256x21.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//
// Revision 1.9  2005/10/19 11:37:56  jcastillo
// Added support for RAMB16 Xilinx4/Spartan3 primitives
//
// Revision 1.8  2004/06/08 18:15:32  lampret
// Changed behavior of the simulation generic models
//
// Revision 1.7  2004/04/05 08:29:57  lampret
// Merged branch_qmem into main tree.
//
// Revision 1.3.4.2  2003/12/09 11:46:48  simons
// Mbist nameing changed, Artisan ram instance signal names fixed, some synthesis waning fixed.
//
// Revision 1.3.4.1  2003/07/08 15:36:37  lampret
// Added embedded memory QMEM.
//
// Revision 1.3  2003/04/07 01:19:07  lampret
// Added Altera LPM RAMs. Changed generic RAM output when OE inactive.
//
// Revision 1.2  2002/10/17 20:04:40  lampret
// Added BIST scan. Special VS RAMs need to be used to implement BIST.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.10  2001/11/27 21:24:04  lampret
// Changed instantiation name of VS RAMs.
//
// Revision 1.9  2001/11/27 19:45:04  lampret
// Fixed VS RAM instantiation - again.
//
// Revision 1.8  2001/11/23 21:42:31  simons
// Program counter divided to PPC and NPC.
//
// Revision 1.6  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.5  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.1  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.2  2001/07/30 05:38:02  lampret
// Adding empty directories required by HDL coding guidelines
//
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_spram_256x21(




	// Generic synchronous single-port RAM interface
	clk, rst, ce, we, oe, addr, di, doq
);

//
// Default address and data buses width
//
parameter aw = 8;
parameter dw = 21;










//
// Generic synchronous single-port RAM interface
//
input			clk;	// Clock
input			rst;	// Reset
input			ce;	// Chip enable input
input			we;	// Write enable input
input			oe;	// Output enable input
input 	[aw-1:0]	addr;	// address bus inputs
input	[dw-1:0]	di;	// input data bus
output	[dw-1:0]	doq;	// output data bus

//
// Internal wires and registers
//





 // !OR1200_XILINX_RAMB16
 // !OR1200_XILINX_RAMB4




















































































































































































































//
// Generic single-port synchronous RAM model
//

//
// Generic RAM's registers and wires
//
reg	[dw-1:0]	mem [(1<<aw)-1:0];	// RAM content
reg	[aw-1:0]	addr_reg;		// RAM address register

//
// Data output drivers
//
assign doq = (oe) ? mem[addr_reg] : {dw{1'b0}};

//
// RAM adress register
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		addr_reg <=  {aw{1'b0}};
	else if (ce)
		addr_reg <=  addr;

//
// RAM write
//
always @(posedge clk)
	if (ce && we)
		mem[addr] <=  di;

	// !OR1200_ALTERA_LPM
	// !OR1200_XILINX_RAMB16
	// !OR1200_XILINX_RAMB4
	// !OR1200_VIRTUALSILICON_SSP
	// !OR1200_VIRAGE_SSP
	// !OR1200_AVANT_ATP
	// !OR1200_ARTISAN_SSP

endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Exception logic                                    ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Handles all OR1K exceptions inside CPU block.               ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_except.v,v $
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 









//
// Exception recognition and sequencing
//

module or1200_except
  (
   // Clock and reset
   clk, rst, 
   
   // Internal i/f
   sig_ibuserr, sig_dbuserr, sig_illegal, sig_align, sig_range, sig_dtlbmiss, 
   sig_dmmufault, sig_int, sig_syscall, sig_trap, sig_itlbmiss, sig_immufault, 
   sig_tick, ex_branch_taken, genpc_freeze, id_freeze, ex_freeze, wb_freeze,  
   if_stall,  if_pc, id_pc, ex_pc, wb_pc, id_flushpipe, ex_flushpipe, 
   extend_flush, except_flushpipe, except_type, except_start, except_started, 
   except_stop, except_trig, ex_void, abort_mvspr, branch_op, spr_dat_ppc, 
   spr_dat_npc, datain, du_dsr, epcr_we, eear_we, esr_we, pc_we, epcr, eear, 
   du_dmr1, du_hwbkpt, du_hwbkpt_ls_r, esr, sr_we, to_sr, sr, lsu_addr, 
   abort_ex, icpu_ack_i, icpu_err_i, dcpu_ack_i, dcpu_err_i, sig_fp, fpcsr_fpee,
   dsx
   
);

//
// I/O
//
input				clk;
input				rst;
input				sig_ibuserr;
input				sig_dbuserr;
input				sig_illegal;
input				sig_align;
input				sig_range;
input				sig_dtlbmiss;
input				sig_dmmufault;
input				sig_int;
input				sig_syscall;
input				sig_trap;
input				sig_itlbmiss;
input				sig_immufault;
input				sig_tick;
input   			sig_fp;
input    			fpcsr_fpee;   
input				ex_branch_taken;
input				genpc_freeze;
input				id_freeze;
input				ex_freeze;
input				wb_freeze;
input				if_stall;
input	[31:0]		if_pc;
output	[31:0]		id_pc;
output  [31:0]      ex_pc;
output  [31:0]      wb_pc;
input	[31:0]		datain;
input   [14-1:0]     du_dsr;
input   [24:0]                       du_dmr1;
input			du_hwbkpt;
input			du_hwbkpt_ls_r;
input				epcr_we;
input				eear_we;
input				esr_we;
input				pc_we;
output	[31:0]			epcr;
output	[31:0]			eear;
output	[17-1:0]	esr;
input	[17-1:0]	to_sr;
input				sr_we;
input	[17-1:0]	sr;
input	[31:0]			lsu_addr;
input              	id_flushpipe;
input              	ex_flushpipe;
output				except_flushpipe;
output				extend_flush;
output	[4-1:0]	except_type;
output				except_start;
output				except_started;
output	[13:0]		except_stop;
output	[13:0]		except_trig;
input				ex_void;
input   [3-1:0]    branch_op; 
output	[31:0]			spr_dat_ppc;
output	[31:0]			spr_dat_npc;
output				abort_ex;
output              abort_mvspr;
input				icpu_ack_i;
input				icpu_err_i;
input				dcpu_ack_i;
input				dcpu_err_i;
output 			        dsx;
   
//
// Internal regs and wires
//
reg	[4-1:0]	except_type /* verilator public */;
reg	[31:0]			id_pc /* verilator public */;
reg                 id_pc_val;
reg	[31:0]			ex_pc /* verilator public */;
reg                 ex_pc_val;
reg	[31:0]			wb_pc /* verilator public */;
reg [31:0]          dl_pc;
reg	[31:0]			epcr;
reg	[31:0]			eear;
reg	[17-1:0]		esr;
reg	[2:0]			id_exceptflags;
reg	[2:0]			ex_exceptflags;
reg	[3-1:0]	state;
reg				extend_flush;
reg				extend_flush_last;
reg				ex_dslot /* verilator public */;
reg				delayed1_ex_dslot;
reg				delayed2_ex_dslot;
// wire				except_started;
// wire				except_flushpipe /* verilator public */;
reg	[2:0]			delayed_iee;
reg	[2:0]			delayed_tee;
wire				int_pending;
wire				tick_pending;
wire    			fp_pending;
wire    			range_pending;
reg 				dsx;
			
reg trace_trap      ;
reg ex_freeze_prev;
reg sr_ted_prev;
reg dsr_te_prev;
reg dmr1_st_prev    ;
reg dmr1_bt_prev    ;
wire dsr_te = ex_freeze_prev ? dsr_te_prev : du_dsr[13];
wire sr_ted = ex_freeze_prev ? sr_ted_prev : sr[16];
wire dmr1_st = ex_freeze_prev ? dmr1_st_prev: du_dmr1[22] ;
wire dmr1_bt = ex_freeze_prev ? dmr1_bt_prev: du_dmr1[23] ;

//
// Simple combinatorial logic
//
assign except_started = extend_flush & except_start;
   
assign except_start = (except_type != 4'h0) & extend_flush;
   
assign int_pending = sig_int & (sr[2] | 
				(sr_we & to_sr[2])) 
		    & id_pc_val & delayed_iee[2] & ~ex_freeze & ~ex_branch_taken
		     & ~ex_dslot & ~(sr_we & ~to_sr[2]);
   
assign tick_pending = sig_tick & (sr[1] | 
				  (sr_we & to_sr[1])) & id_pc_val
		      & delayed_tee[2] & ~ex_freeze & ~ex_branch_taken 
		      & ~ex_dslot & ~(sr_we & ~to_sr[1]);

assign fp_pending = sig_fp & fpcsr_fpee & ~ex_freeze & ~ex_branch_taken 
		    & ~ex_dslot;

   
assign range_pending =  sig_range & sr[12] & ~ex_freeze & 
		       ~ex_branch_taken & ~ex_dslot;


   
   
// Abort write into RF by load & other instructions   
assign abort_ex = sig_dbuserr | sig_dmmufault | sig_dtlbmiss | sig_align | 
		  sig_illegal | ((du_hwbkpt | trace_trap) & ex_pc_val 
				 & !sr_ted & !dsr_te);

// abort spr read/writes   
assign abort_mvspr  = sig_illegal | ((du_hwbkpt | trace_trap) & ex_pc_val 
				     & !sr_ted & !dsr_te) ; 
assign spr_dat_ppc = wb_pc;
   
assign spr_dat_npc = ex_void ? id_pc : ex_pc;

//
// Order defines exception detection priority
//
assign except_trig = {
		      ex_exceptflags[1]	& ~du_dsr[9],
		      ex_exceptflags[0]	& ~du_dsr[3],
		      ex_exceptflags[2]	& ~du_dsr[1],
		      sig_illegal       & ~du_dsr[6],
		      sig_align		& ~du_dsr[5],
		      sig_dtlbmiss	& ~du_dsr[8],
		      sig_trap		& ~du_dsr[13],
		      sig_syscall       & ~du_dsr[11] & ~ex_freeze,
		      sig_dmmufault	& ~du_dsr[2],
		      sig_dbuserr	& ~du_dsr[1],
		      range_pending	& ~du_dsr[10],
		      fp_pending	& ~du_dsr[12],
		      int_pending 	& ~du_dsr[7],
		      tick_pending	& ~du_dsr[4]
		      };

wire    trace_cond  = !ex_freeze && !ex_void && (1'b0

    ||  dmr1_st


    ||  ((branch_op != 3'd0) && (branch_op != 3'd6) && dmr1_bt)

    );

assign except_stop = {
			tick_pending		& du_dsr[4],
			int_pending 		& du_dsr[7],
			ex_exceptflags[1]	& du_dsr[9],
			ex_exceptflags[0]	& du_dsr[3],
			ex_exceptflags[2]	& du_dsr[1],
			sig_illegal		& du_dsr[6],
			sig_align		& du_dsr[5],
			sig_dtlbmiss		& du_dsr[8],
			sig_dmmufault		& du_dsr[2],
			sig_dbuserr		& du_dsr[1],
			range_pending		& du_dsr[10],
			sig_trap		& du_dsr[13],
		        fp_pending  		& du_dsr[12],
			sig_syscall		& du_dsr[11] & ~ex_freeze
		};

always @(posedge clk or posedge rst) begin
	if (rst == (1'b1)) begin
		trace_trap  <=  1'b0 ;
	end 
	else if (!(trace_trap && !ex_pc_val)) begin
		trace_trap  <=  trace_cond & !dsr_te & !sr_ted ;
	end
end

always @(posedge clk or posedge rst) begin
	if (rst == (1'b1)) begin
        ex_freeze_prev  <=  1'b0 ;
        sr_ted_prev     <=  1'b0 ;
        dsr_te_prev     <=  1'b0 ;
        dmr1_st_prev    <=  1'b0 ;
        dmr1_bt_prev    <=  1'b0 ;
    end 
    else begin
        ex_freeze_prev  <=  ex_freeze ;
        if (!ex_freeze_prev || ex_void) begin
            sr_ted_prev     <=  sr     [16    ] ;
            dsr_te_prev     <=  du_dsr [13 ] ;
            dmr1_st_prev    <=  du_dmr1[22] ;
            dmr1_bt_prev    <=  du_dmr1[23] ;
        end
    end
end


































   
   
//
// PC and Exception flags pipelines
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1)) begin
		id_pc <=  32'd0;
        id_pc_val <=  1'b0 ;
		id_exceptflags <=  3'b000;
	end
	else if (id_flushpipe) begin
        id_pc_val <=  1'b0 ;
		id_exceptflags <=  3'b000;
	end
	else if (!id_freeze) begin
		id_pc <=  if_pc;
        id_pc_val <=  1'b1 ;
		id_exceptflags <=  { sig_ibuserr, sig_itlbmiss, sig_immufault };
	end
end

//
// delayed_iee
//
// SR[IEE] should not enable interrupts right away
// when it is restored with l.rfe. Instead delayed_iee
// together with SR[IEE] enables interrupts once
// pipeline is again ready.
//
always @(posedge rst or posedge clk)
	if (rst == (1'b1))
		delayed_iee <=  3'b000;
	else if (!sr[2])
		delayed_iee <=  3'b000;
	else
		delayed_iee <=  {delayed_iee[1:0], 1'b1};

//
// delayed_tee
//
// SR[TEE] should not enable tick exceptions right away
// when it is restored with l.rfe. Instead delayed_tee
// together with SR[TEE] enables tick exceptions once
// pipeline is again ready.
//
always @(posedge rst or posedge clk)
	if (rst == (1'b1))
		delayed_tee <=  3'b000;
	else if (!sr[1])
		delayed_tee <=  3'b000;
	else
		delayed_tee <=  {delayed_tee[1:0], 1'b1};

//
// PC and Exception flags pipelines
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1)) begin
		ex_dslot <=  1'b0;
		ex_pc <=  32'd0;
                ex_pc_val <=  1'b0 ;
		ex_exceptflags <=  3'b000;
		delayed1_ex_dslot <=  1'b0;
		delayed2_ex_dslot <=  1'b0;
	end
	else if (ex_flushpipe) begin
		ex_dslot <=  1'b0;
                ex_pc_val <=  1'b0 ;
		ex_exceptflags <=  3'b000;
		delayed1_ex_dslot <=  1'b0;
		delayed2_ex_dslot <=  1'b0;
	end
	else if (!ex_freeze & id_freeze) begin
		ex_dslot <=  1'b0;
		ex_pc <=  id_pc;
                ex_pc_val <=  id_pc_val ;
		ex_exceptflags <=  3'b000;
		delayed1_ex_dslot <=  ex_dslot;
		delayed2_ex_dslot <=  delayed1_ex_dslot;
	end
	else if (!ex_freeze) begin
		ex_dslot <=  ex_branch_taken;
		ex_pc <=  id_pc;
                ex_pc_val <=  id_pc_val ;
		ex_exceptflags <=  id_exceptflags;
		delayed1_ex_dslot <=  ex_dslot;
		delayed2_ex_dslot <=  delayed1_ex_dslot;
	end
end

//
// PC and Exception flags pipelines
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1)) begin
		wb_pc <=  32'd0;
        dl_pc <=  32'd0;
	end
	else if (!wb_freeze) begin
		wb_pc <=  ex_pc;
        dl_pc <=  wb_pc;
	end
end

//
// We have started execution of exception handler:
//  1. Asserted for 3 clock cycles
//  2. Don't execute any instruction that is still in pipeline and is not part of exception handler
//
assign except_flushpipe = |except_trig & ~|state;

//
// Exception FSM that sequences execution of exception handler
//
// except_type signals which exception handler we start fetching in:
//  1. Asserted in next clock cycle after exception is recognized
//
   always @(posedge clk or posedge rst) begin
      if (rst == (1'b1)) begin
	 state <=  3'd0;
	 except_type <=  4'h0;
	 extend_flush <=  1'b0;
	 epcr <=  32'b0;
	 eear <=  32'b0;
	 esr <=  {2'h1, {17-3{1'b0}}, 1'b1};
	 extend_flush_last <=  1'b0;
	 dsx <= 1'b0;
      end
      else begin

	 case (state)	// synopsys parallel_case



	     3'd0:
	       if (except_flushpipe) begin
		  state <=  3'd1;
		  extend_flush <=  1'b1;
		  esr <=  sr_we ? to_sr : sr;
		  casez (except_trig)

		    14'b1?_????_????_????: begin
		       except_type <=  4'ha;
		       eear <=  ex_dslot ? 
			       ex_pc : ex_pc;
		       epcr <=  ex_dslot ? 
			       wb_pc : ex_pc;
		       dsx <= ex_dslot;
		    end


		    14'b01_????_????_????: begin
		       except_type <=  4'h4;
		       eear <=  ex_dslot ? 
			       ex_pc : delayed1_ex_dslot ? 
			       id_pc : delayed2_ex_dslot ? 
			       id_pc : id_pc;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       id_pc : delayed2_ex_dslot ? 
			       id_pc : id_pc;
		       dsx <= ex_dslot;
		    end


		    14'b00_1???_????_????: begin	// Insn. Bus Error
		       except_type <=  4'h2;
		       eear <=  ex_dslot ? 
			       wb_pc : ex_pc;
		       epcr <=  ex_dslot ? 
			       wb_pc : ex_pc;
		       dsx <= ex_dslot;
		    end


		    14'b00_01??_????_????: begin
		       except_type <=  4'h7;
		       eear <=  ex_pc;
		       epcr <=  ex_dslot ? 
			       wb_pc : ex_pc;
		       dsx <= ex_dslot;
		    end


		    14'b00_001?_????_????: begin
		       except_type <=  4'h6;
		       eear <=  lsu_addr;
		       epcr <=  ex_dslot ? 
			       wb_pc : ex_pc;
		       dsx <= ex_dslot;
		    end


		    14'b00_0001_????_????: begin
		       except_type <=  4'h9;
		       eear <=  lsu_addr;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       dl_pc : ex_pc;
		       dsx <= ex_dslot;
		    end

			
		    14'b00_0000_1???_????: begin
		       except_type <=  4'he;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       id_pc : ex_pc;
		       dsx <= ex_dslot;
		    end


		    14'b00_0000_01??_????: begin
		       except_type <=  4'hc;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       id_pc : delayed2_ex_dslot ? 
			       id_pc : id_pc;
		       dsx <= ex_dslot;
		    end


		    14'b00_0000_001?_????: begin
		       except_type <=  4'h3;
		       eear <=  lsu_addr;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       dl_pc : ex_pc;
		       dsx <= ex_dslot;
		    end


		    14'b00_0000_0001_????: begin	// Data Bus Error
		       except_type <=  4'h2;
		       eear <=  lsu_addr;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       dl_pc : ex_pc;
		       dsx <= ex_dslot;
		    end


		    14'b00_0000_0000_1???: begin
		       except_type <=  4'hb;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       dl_pc : delayed2_ex_dslot ? 
			       id_pc : ex_pc;
		       dsx <= ex_dslot;
		    end


		    14'b00_0000_0000_01??: begin
		       except_type <=  4'hd;
		       epcr <=  id_pc;
		       dsx <= ex_dslot;
		    end


		    14'b00_0000_0000_001?: begin
		       except_type <=  4'h8;
		       epcr <=  id_pc;
		       dsx <= ex_dslot;
		    end


		    14'b00_0000_0000_0001: begin
		       except_type <=  4'h5;
		       epcr <=  id_pc;
		       dsx <= ex_dslot;
		    end

		    default:
		      except_type <=  4'h0;
		  endcase
	       end
	       else if (pc_we) begin
		  state <=  3'd1;
		  extend_flush <=  1'b1;
	       end
	       else begin
		  if (epcr_we)
		    epcr <=  datain;
		  if (eear_we)
		    eear <=  datain;
		  if (esr_we)
		    esr <=  {datain[17-1], 1'b1, datain[17-3:0]};
	       end
	     3'd1:
	       if (icpu_ack_i | icpu_err_i | genpc_freeze)
		 state <=  3'd2;
	     3'd2:

	       if (except_type == 4'he) begin
		  state <=  3'd0;
		  extend_flush <=  1'b0;
		  extend_flush_last <=  1'b0;
		  except_type <=  4'h0;
	       end
               else

		 state <=  3'd3;
	     3'd3:
	       begin
		  state <=  3'd4;
	       end
	     3'd4: begin
		state <=  3'd5;
		extend_flush <=  1'b0;
		extend_flush_last <=  1'b0; // damjan
	     end

	     default: begin



		   if (!if_stall && !id_freeze) begin
		      state <=  3'd0;
		      except_type <=  4'h0;
		      extend_flush_last <=  1'b0;
		   end
		end
	   endcase
	 end
   end

endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Generic 32x32 multiplier                                    ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Generic 32x32 multiplier with pipeline stages.              ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: or1200_gmultp2_32x32.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

// 32x32 multiplier, no input/output registers
// Registers inside Wallace trees every 8 full adder levels,
// with first pipeline after level 4






module or1200_gmultp2_32x32 ( X, Y, CLK, RST, P );

input   [32-1:0]  X;
input   [32-1:0]  Y;
input           CLK;
input           RST;
output  [64-1:0]  P;

reg     [32-1:0]  X_saved;
reg     [32-1:0]  Y_saved;
reg     [64-1:0]  p1;
integer 		  xi;
integer 		  yi;

//
// Conversion unsigned to signed
//
always @(X_saved)
	xi = X_saved;

//
// Conversion unsigned to signed
//
always @(Y_saved)
	yi = Y_saved;

//
// First multiply stage
//
always @(posedge CLK or posedge RST)
        if (RST == (1'b1)) begin
           X_saved <= 32'b0;
	   Y_saved <= 32'b0;
	end
        else begin
           X_saved <= X;
	   Y_saved <= Y;
	end

//
// Second multiply stage
//
always @(posedge CLK or posedge RST)
        if (RST == (1'b1))
          p1 <= 64'b0;
        else
          p1 <=  xi * yi;

assign P = p1;

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Instruction decode                                 ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Majority of instruction decoding is performed here.         ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
//
// $Log: or1200_ctrl.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//




/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//





//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in ./src/or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented


// Define if you want full address decode inside SYS group


// Offsets of VR, UPR and CFGR registers









// VR fields





// VR values





// UPR fields















// UPR values























































// CPUCFGR fields









// CPUCFGR values




    






 






// DMMUCFGR fields









// DMMUCFGR values




















// IMMUCFGR fields









// IMMUCFGR values




















// DCCFGR fields












// DCCFGR values

















 









 






// ICCFGR fields












// ICCFGR values


























// DCFGR fields




// DCFGR values













///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 

module or1200_ctrl
  (
   // Clock and reset
   clk, rst,
   
   // Internal i/f
   except_flushpipe, extend_flush, if_flushpipe, id_flushpipe, ex_flushpipe, 
   wb_flushpipe,
   id_freeze, ex_freeze, wb_freeze, if_insn, id_insn, ex_insn, abort_mvspr, 
   id_branch_op, ex_branch_op, ex_branch_taken, pc_we, 
   rf_addra, rf_addrb, rf_rda, rf_rdb, alu_op, alu_op2, mac_op,
   comp_op, rf_addrw, rfwb_op, fpu_op,
   wb_insn, id_simm, ex_simm, id_branch_addrtarget, ex_branch_addrtarget, sel_a,
   sel_b, id_lsu_op,
   cust5_op, cust5_limm, id_pc, ex_pc, du_hwbkpt, 
   multicycle, wait_on, wbforw_valid, sig_syscall, sig_trap,
   force_dslot_fetch, no_more_dslot, id_void, ex_void, ex_spr_read, 
   ex_spr_write, du_flush_pipe,
   id_mac_op, id_macrc_op, ex_macrc_op, rfe, except_illegal, dc_no_writethrough
   );

//
// I/O
//
input					clk;
input					rst;
input					id_freeze;
input					ex_freeze /* verilator public */;
input					wb_freeze /* verilator public */;
output					if_flushpipe;
output					id_flushpipe;
output					ex_flushpipe;
output					wb_flushpipe;
input					extend_flush;
input					except_flushpipe;
input                           abort_mvspr ;
input	[31:0]			if_insn;
output	[31:0]			id_insn;
output	[31:0]			ex_insn /* verilator public */;
output	[3-1:0]		ex_branch_op;
output	[3-1:0]		id_branch_op;
input						ex_branch_taken;
output	[5-1:0]	rf_addrw;
output	[5-1:0]	rf_addra;
output	[5-1:0]	rf_addrb;
output					rf_rda;
output					rf_rdb;
output	[5-1:0]		alu_op;
output [4-1:0] 		alu_op2;
output	[3-1:0]		mac_op;
output	[4-1:0]		rfwb_op;
output  [8-1:0] 		fpu_op;      
input					pc_we;
output	[31:0]				wb_insn;
output	[31:2]				id_branch_addrtarget;
output	[31:2]				ex_branch_addrtarget;
output	[2-1:0]		sel_a;
output	[2-1:0]		sel_b;
output	[4-1:0]		id_lsu_op;
output	[4-1:0]		comp_op;
output	[3-1:0]		multicycle;
output  [2-1:0] 		wait_on;   
output	[4:0]				cust5_op;
output	[5:0]				cust5_limm;
input   [31:0]                          id_pc;
input   [31:0]                          ex_pc;
output	[31:0]				id_simm;
output	[31:0]				ex_simm;
input					wbforw_valid;
input					du_hwbkpt;
output					sig_syscall;
output					sig_trap;
output					force_dslot_fetch;
output					no_more_dslot;
output					id_void;
output					ex_void;
output					ex_spr_read;
output					ex_spr_write;
output	[3-1:0]	id_mac_op;
output					id_macrc_op;
output					ex_macrc_op;
output					rfe;
output					except_illegal;
output  				dc_no_writethrough;
input					du_flush_pipe;

//
// Internal wires and regs
//
reg	[3-1:0]		id_branch_op;
reg	[3-1:0]		ex_branch_op;
reg	[5-1:0]		alu_op;
reg [4-1:0]      		alu_op2;
wire					if_maci_op;






// wire	[3-1:0]		mac_op;
// wire					ex_macrc_op;

reg	[31:0]				id_insn /* verilator public */;
reg	[31:0]				ex_insn /* verilator public */;
reg	[31:0]				wb_insn /* verilator public */;
reg	[5-1:0]	rf_addrw;
reg	[5-1:0]	wb_rfaddrw;
reg	[4-1:0]		rfwb_op;
reg	[2-1:0]		sel_a;
reg	[2-1:0]		sel_b;
reg					sel_imm;
reg	[4-1:0]		id_lsu_op;
reg	[4-1:0]		comp_op;
reg	[3-1:0]		multicycle;
reg     [2-1:0] 		wait_on;      
reg 	[31:0]				id_simm;
reg 	[31:0]				ex_simm;
reg					sig_syscall;
reg					sig_trap;
reg					except_illegal;
// wire					id_void;
// wire					ex_void;
wire                                    wb_void;
reg                                     ex_delayslot_dsi;
reg                                     ex_delayslot_nop;
reg					spr_read;
reg					spr_write;
reg     [31:2]				ex_branch_addrtarget;



   
//
// Register file read addresses
//
assign rf_addra = if_insn[20:16];
assign rf_addrb = if_insn[15:11];
assign rf_rda = if_insn[31] || if_maci_op;
assign rf_rdb = if_insn[30];

//
// Force fetch of delay slot instruction when jump/branch is preceeded by 
// load/store instructions
//
assign force_dslot_fetch = 1'b0;
assign no_more_dslot = (|ex_branch_op & !id_void & ex_branch_taken) | 
		       (ex_branch_op == 3'd6);

assign id_void = (id_insn[31:26] == 6'b000101) & id_insn[16];
assign ex_void = (ex_insn[31:26] == 6'b000101) & ex_insn[16];
assign wb_void = (wb_insn[31:26] == 6'b000101) & wb_insn[16];

assign ex_spr_write = spr_write && !abort_mvspr;
assign ex_spr_read = spr_read && !abort_mvspr;

//
// ex_delayslot_dsi: delay slot insn is in EX stage
// ex_delayslot_nop: (filler) nop insn is in EX stage (before nops 
//                   jump/branch was executed)
//
//  ex_delayslot_dsi & !ex_delayslot_nop - DS insn in EX stage
//  !ex_delayslot_dsi & ex_delayslot_nop - NOP insn in EX stage, 
//       next different is DS insn, previous different was Jump/Branch
//  !ex_delayslot_dsi & !ex_delayslot_nop - normal insn in EX stage
//
always @(posedge clk or posedge rst) begin
        if (rst == (1'b1)) begin
		ex_delayslot_nop <=  1'b0;
		ex_delayslot_dsi <=  1'b0;
	end
	else if (!ex_freeze & !ex_delayslot_dsi & ex_delayslot_nop) begin
		ex_delayslot_nop <=  id_void;
		ex_delayslot_dsi <=  !id_void;
	end
	else if (!ex_freeze & ex_delayslot_dsi & !ex_delayslot_nop) begin
		ex_delayslot_nop <=  1'b0;
		ex_delayslot_dsi <=  1'b0;
	end
	else if (!ex_freeze) begin
		ex_delayslot_nop <=  id_void && ex_branch_taken && 
				     (ex_branch_op != 3'd0) && 
				     (ex_branch_op != 3'd6);
	        ex_delayslot_dsi <=  !id_void && ex_branch_taken && 
				     (ex_branch_op != 3'd0) && 
				     (ex_branch_op != 3'd6);
	end
end

//
// Flush pipeline
//
assign if_flushpipe = except_flushpipe | pc_we | extend_flush | du_flush_pipe;
assign id_flushpipe = except_flushpipe | pc_we | extend_flush | du_flush_pipe;
assign ex_flushpipe = except_flushpipe | pc_we | extend_flush | du_flush_pipe;
assign wb_flushpipe = except_flushpipe | pc_we | extend_flush | du_flush_pipe;

//
// EX Sign/Zero extension of immediates
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		ex_simm <=  32'h0000_0000;
	else if (!ex_freeze) begin
		ex_simm <=  id_simm;
	end
end

//
// ID Sign/Zero extension of immediate
//
always @(id_insn) begin
	case (id_insn[31:26])     // synopsys parallel_case

	// l.addi
	6'b100111:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// l.addic
	6'b101000:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// l.lxx (load instructions)
	6'b100001, 6'b100010,
   6'b100011, 6'b100100,
	6'b100101, 6'b100110:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// l.muli
	
	6'b101100:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};
	

	// l.maci
	




	// l.mtspr
	6'b110000:
		id_simm = {16'b0, id_insn[25:21], id_insn[10:0]};

	// l.sxx (store instructions)
	6'b110101, 6'b110111, 6'b110110:
		id_simm = {{16{id_insn[25]}}, id_insn[25:21], id_insn[10:0]};

	// l.xori
	6'b101011:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// l.sfxxi (SFXX with immediate)
	6'b101111:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// Instructions with no or zero extended immediate
	default:
		id_simm = {{16'b0}, id_insn[15:0]};

	endcase
end

//
// ID Sign extension of branch offset
//
assign id_branch_addrtarget = {{4{id_insn[25]}}, id_insn[25:0]} + id_pc[31:2];

//
// EX Sign extension of branch offset
//

// pipeline ID and EX branch target address 
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		ex_branch_addrtarget <=  0;
	else if (!ex_freeze) 
		ex_branch_addrtarget <=  id_branch_addrtarget;
end
// not pipelined
//assign ex_branch_addrtarget = {{4{ex_insn[25]}}, ex_insn[25:0]} + ex_pc[31:2];

//
// l.maci in IF stage
//



assign if_maci_op = 1'b0;


//
// l.macrc in ID stage
//



assign id_macrc_op = 1'b0;


//
// l.macrc in EX stage
//










assign ex_macrc_op = 1'b0;


//
// cust5_op, cust5_limm (L immediate)
//
assign cust5_op = ex_insn[4:0];
assign cust5_limm = ex_insn[10:5];

//
//
//
assign rfe = (id_branch_op == 3'd6) | 
	     (ex_branch_op == 3'd6);

   



























   
//
// Generation of sel_a
//
always @(rf_addrw or id_insn or rfwb_op or wbforw_valid or wb_rfaddrw)
	if ((id_insn[20:16] == rf_addrw) && rfwb_op[0])
		sel_a = 2'd2;
	else if ((id_insn[20:16] == wb_rfaddrw) && wbforw_valid)
		sel_a = 2'd3;
	else
		sel_a = 2'd0;

//
// Generation of sel_b
//
always @(rf_addrw or sel_imm or id_insn or rfwb_op or wbforw_valid or 
	 wb_rfaddrw)
	if (sel_imm)
		sel_b = 2'd1;
	else if ((id_insn[15:11] == rf_addrw) && rfwb_op[0])
		sel_b = 2'd2;
	else if ((id_insn[15:11] == wb_rfaddrw) && wbforw_valid)
		sel_b = 2'd3;
	else
		sel_b = 2'd0;

//
// Decode of multicycle
//
always @(id_insn) begin
  case (id_insn[31:26])		// synopsys parallel_case
    // l.rfe
    6'b001001,
    // l.mfspr
    6'b101101:
      multicycle = 3'd1;	// to read from ITLB/DTLB (sync RAMs)
    // Single cycle instructions
    default: begin
      multicycle = 3'd0;
    end    
  endcase
end // always @ (id_insn)

//
// Encode wait_on signal
//    
always @(id_insn) begin
   case (id_insn[31:26])		// synopsys parallel_case
     6'b111000: 
       wait_on =  ( 1'b0

                     | (id_insn[4:0] == 5'b0_1001)
		     | (id_insn[4:0] == 5'b0_1010)


		     | (id_insn[4:0] == 5'b0_0110)
		     | (id_insn[4:0] == 5'b0_1011)

		    ) ? 2'd1 : 2'd0;





     6'b101100:       
	 wait_on = 2'd1;





		   






     // l.mtspr
     6'b110000: begin
	wait_on = 2'd3;
     end

     default: begin
	wait_on = 2'd0;
     end
   endcase // case (id_insn[31:26])
end // always @ (id_insn)
   
   
   
   
//
// Register file write address
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		rf_addrw <=  5'd0;
	else if (!ex_freeze & id_freeze)
		rf_addrw <=  5'd00;
	else if (!ex_freeze)
		case (id_insn[31:26])	// synopsys parallel_case
			6'b000001, 6'b010010:
				rf_addrw <=  5'd09;	// link register r9
			default:
				rf_addrw <=  id_insn[25:21];
		endcase
end

//
// rf_addrw in wb stage (used in forwarding logic)
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		wb_rfaddrw <=  5'd0;
	else if (!wb_freeze)
		wb_rfaddrw <=  rf_addrw;
end

//
// Instruction latch in id_insn
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		id_insn <=  {6'b000101, 26'h041_0000};
        else if (id_flushpipe)
                id_insn <=  {6'b000101, 26'h041_0000};        // NOP -> id_insn[16] must be 1
	else if (!id_freeze) begin
		id_insn <=  if_insn;





	end
end

//
// Instruction latch in ex_insn
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		ex_insn <=  {6'b000101, 26'h041_0000};
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		ex_insn <=  {6'b000101, 26'h041_0000};	// NOP -> ex_insn[16] must be 1
	else if (!ex_freeze) begin
		ex_insn <=  id_insn;





	end
end
   
//
// Instruction latch in wb_insn
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		wb_insn <=  {6'b000101, 26'h041_0000};
	// wb_insn should not be changed by exceptions due to correct 
	// recording of display_arch_state in the or1200_monitor! 
	// wb_insn changed by exception is not used elsewhere! 
	else if (!wb_freeze) begin
		wb_insn <=  ex_insn;
	end
end

//
// Decode of sel_imm
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		sel_imm <=  1'b0;
	else if (!id_freeze) begin
	  case (if_insn[31:26])		// synopsys parallel_case

	    // j.jalr
	    6'b010010:
	      sel_imm <=  1'b0;
	    
	    // l.jr
	    6'b010001:
	      sel_imm <=  1'b0;
	    
	    // l.rfe
	    6'b001001:
	      sel_imm <=  1'b0;
	    
	    // l.mfspr
	    6'b101101:
	      sel_imm <=  1'b0;
	    
	    // l.mtspr
	    6'b110000:
	      sel_imm <=  1'b0;
	    
	    // l.sys, l.brk and all three sync insns
	    6'b001000:
	      sel_imm <=  1'b0;
	    
	    // l.mac/l.msb





	    // l.sw
	    6'b110101:
	      sel_imm <=  1'b0;
	    
	    // l.sb
	    6'b110110:
	      sel_imm <=  1'b0;
	    
	    // l.sh
	    6'b110111:
	      sel_imm <=  1'b0;
	    
	    // ALU instructions except the one with immediate
	    6'b111000:
	      sel_imm <=  1'b0;
	    
	    // SFXX instructions
	    6'b111001:
	      sel_imm <=  1'b0;











	    // l.nop
	    6'b000101:
	      sel_imm <=  1'b0;

	    // All instructions with immediates
	    default: begin
	      sel_imm <=  1'b1;
	    end
	    
	  endcase
	  
	end
end

//
// Decode of except_illegal
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		except_illegal <=  1'b0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		except_illegal <=  1'b0;
	else if (!ex_freeze) begin
		case (id_insn[31:26])		// synopsys parallel_case

		6'b000000,
		6'b000001,
		6'b010010,
		6'b010001,
		6'b000011,
		6'b000100,
		6'b001001,
		6'b000110,
		6'b101101,
		6'b001000,



		6'b100001,
		6'b100010,
		6'b100011,
		6'b100100,
		6'b100101,
		6'b100110,
		6'b100111,
		6'b101000,
		6'b101001,
		6'b101010,
		6'b101011,

		6'b101100,




		6'b101111,
		6'b110000,



		6'b110101,
		6'b110110,
		6'b110111,
		6'b111001,



	6'b000101:
		except_illegal <=  1'b0;




	      

	6'b111000:
		except_illegal <=  1'b0 

























		| ((id_insn[4:0] == 5'b0_1000) &
		   (id_insn[9:6] == 4'd3))











		;

		// Illegal and OR1200 unsupported instructions
	default:
		except_illegal <=  1'b1;

	endcase
	end // if (!ex_freeze)
end
   

//
// Decode of alu_op
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		alu_op <=  5'b0_0100;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		alu_op <=  5'b0_0100;
	else if (!ex_freeze) begin
	  case (id_insn[31:26])		// synopsys parallel_case
	    
	    // l.movhi
	    6'b000110:
	      alu_op <=  5'b1_0001;
	    
	    // l.addi
	    6'b100111:
	      alu_op <=  5'b0_0000;
	    
	    // l.addic
	    6'b101000:
	      alu_op <=  5'b0_0001;
	    
	    // l.andi
	    6'b101001:
	      alu_op <=  5'b0_0011;
	    
	    // l.ori
	    6'b101010:
	      alu_op <=  5'b0_0100;
	    
	    // l.xori
	    6'b101011:
	      alu_op <=  5'b0_0101;
	    
	    // l.muli

	    6'b101100:
	      alu_op <=  5'b0_0110;





  
	    // SFXX insns with immediate
	    6'b101111:
	      alu_op <=  5'b1_0000;
	    
	    // ALU instructions except the one with immediate
	    6'b111000:
	      alu_op <=  {1'b0,id_insn[3:0]};
	    
	    // SFXX instructions
	    6'b111001:
	      alu_op <=  5'b1_0000;




	    
	    // Default
	    default: begin
	      alu_op <=  5'b0_0100;
	    end
	      
	  endcase
	  
	end
end


//
// Decode of second ALU operation field [9:6]
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		alu_op2 <=  0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
	        alu_op2 <= 0;
   	else if (!ex_freeze) begin
		alu_op2 <=  id_insn[9:6];
	end
end

//
// Decode of spr_read, spr_write
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1)) begin
		spr_read <=  1'b0;
		spr_write <=  1'b0;
	end
	else if (!ex_freeze & id_freeze | ex_flushpipe) begin
		spr_read <=  1'b0;
		spr_write <=  1'b0;
	end
	else if (!ex_freeze) begin
		case (id_insn[31:26])     // synopsys parallel_case

		// l.mfspr
		6'b101101: begin
			spr_read <=  1'b1;
			spr_write <=  1'b0;
		end

		// l.mtspr
		6'b110000: begin
			spr_read <=  1'b0;
			spr_write <=  1'b1;
		end

		// Default
		default: begin
			spr_read <=  1'b0;
			spr_write <=  1'b0;
		end

		endcase
	end
end

//
// Decode of mac_op
//






























assign id_mac_op = 3'b000;
assign mac_op = 3'b000;



//
// Decode of rfwb_op
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		rfwb_op <=  4'b0000;
	else  if (!ex_freeze & id_freeze | ex_flushpipe)
		rfwb_op <=  4'b0000;
	else  if (!ex_freeze) begin
		case (id_insn[31:26])		// synopsys parallel_case

		// j.jal
		6'b000001:
			rfwb_op <=  {3'b011, 1'b1};
		  
		// j.jalr
		6'b010010:
			rfwb_op <=  {3'b011, 1'b1};
		  
		// l.movhi
		6'b000110:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// l.mfspr
		6'b101101:
			rfwb_op <=  {3'b010, 1'b1};
		  
		// l.lwz
		6'b100001:
			rfwb_op <=  {3'b001, 1'b1};

		// l.lws
		6'b100010:
			rfwb_op <=  {3'b001, 1'b1};

		// l.lbz
		6'b100011:
			rfwb_op <=  {3'b001, 1'b1};
		  
		// l.lbs
		6'b100100:
			rfwb_op <=  {3'b001, 1'b1};
		  
		// l.lhz
		6'b100101:
			rfwb_op <=  {3'b001, 1'b1};
		  
		// l.lhs
		6'b100110:
			rfwb_op <=  {3'b001, 1'b1};
		  
		// l.addi
		6'b100111:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// l.addic
		6'b101000:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// l.andi
		6'b101001:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// l.ori
		6'b101010:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// l.xori
		6'b101011:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// l.muli

		6'b101100:
			rfwb_op <=  {3'b000, 1'b1};

		  
		// Shift and rotate insns with immediate




		// ALU instructions except the one with immediate
		6'b111000:
			rfwb_op <=  {3'b000, 1'b1};











		// Instructions w/o register-file write-back
		default: 
			rfwb_op <=  4'b0000;


		endcase
	end
end

//
// Decode of id_branch_op
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		id_branch_op <=  3'd0;
	else if (id_flushpipe)
		id_branch_op <=  3'd0;
	else if (!id_freeze) begin
		case (if_insn[31:26])		// synopsys parallel_case

		// l.j
		6'b000000:
			id_branch_op <=  3'd1;
		  
		// j.jal
		6'b000001:
			id_branch_op <=  3'd1;
		  
		// j.jalr
		6'b010010:
			id_branch_op <=  3'd2;
		  
		// l.jr
		6'b010001:
			id_branch_op <=  3'd2;
		  
		// l.bnf
		6'b000011:
			id_branch_op <=  3'd5;
		  
		// l.bf
		6'b000100:
			id_branch_op <=  3'd4;
		  
		// l.rfe
		6'b001001:
			id_branch_op <=  3'd6;
		  
		// Non branch instructions
		default:
			id_branch_op <=  3'd0;

		endcase
	end
end

//
// Generation of ex_branch_op
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		ex_branch_op <=  3'd0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		ex_branch_op <=  3'd0;		
	else if (!ex_freeze)
		ex_branch_op <=  id_branch_op;

//
// Decode of id_lsu_op
//
always @(id_insn) begin
	case (id_insn[31:26])		// synopsys parallel_case

	// l.lwz
	6'b100001:
		id_lsu_op =  4'b0110;

	// l.lws
	6'b100010:
		id_lsu_op =  4'b0111;

	// l.lbz
	6'b100011:
		id_lsu_op =  4'b0010;

	// l.lbs
	6'b100100:
		id_lsu_op =  4'b0011;

	// l.lhz
	6'b100101:
		id_lsu_op =  4'b0100;

	// l.lhs
	6'b100110:
		id_lsu_op =  4'b0101;

	// l.sw
	6'b110101:
		id_lsu_op =  4'b1110;

	// l.sb
	6'b110110:
		id_lsu_op =  4'b1010;

	// l.sh
	6'b110111:
		id_lsu_op =  4'b1100;

	// Non load/store instructions
	default:
		id_lsu_op =  4'b0000;

	endcase
end

//
// Decode of comp_op
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1)) begin
		comp_op <=  4'd0;
	end else if (!ex_freeze & id_freeze | ex_flushpipe)
		comp_op <=  4'd0;
	else if (!ex_freeze)
		comp_op <=  id_insn[24:21];
end








   assign fpu_op = {8{1'b0}};


   
//
// Decode of l.sys
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		sig_syscall <=  1'b0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		sig_syscall <=  1'b0;
	else if (!ex_freeze) begin






		sig_syscall <=  (id_insn[31:23] == {6'b001000, 3'b000});
	end
end

//
// Decode of l.trap
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		sig_trap <=  1'b0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		sig_trap <=  1'b0;
	else if (!ex_freeze) begin






		sig_trap <=  (id_insn[31:23] == {6'b001000, 3'b010})
			| du_hwbkpt;
	end
end

// Decode destination register address for data cache to check if store ops
// are being done from the stack register (r1) or frame pointer register (r2)








   
   assign dc_no_writethrough = 0;
  
      
   
endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's DC RAMs                                            ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Instatiation of DC RAM blocks.                              ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
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
//
// $Log: or1200_dc_ram.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
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
// $Log: ./src/or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

//  `define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//


















































/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)


//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32


//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB

//`define OR1200_IC_1W_16KB
//`define OR1200_IC_1W_32KB
//`define OR1200_DC_1W_4KB

//`define OR1200_DC_1W_16KB
//`define OR1200_DC_1W_32KB




//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//


//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//


//
// LOG all WISHBONE accesses
//


//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//


//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//



//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//


//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//


//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//


//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//


//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//



//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2


//
// Implement Find First/Last '1'
//


//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//


//
// Implement multiplier
//
// By default multiplier is implemented
//


//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//


//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//


//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)


//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 




//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//

//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//




  
  


//
// ALUOPs
//


/* LS-nibble encodings correspond to bits [3:0] of instruction */

















/* Values sent to ALU from decode unit - not defined by ISA */




// ALU instructions second opcode field



//
// MACOPs
//





//
// Shift/rotate ops
//







//
// Zero/Sign Extend ops
//









// Execution cycles per instruction




// Execution control which will "wait on" a module to finish







// Operand MUX selects






//
// BRANCHOPs
//









//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store














// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31


// FETCHOPs




//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//








// Compare instructions










//
// FP OPs
//
// MSbit indicates FPU operation valid
//

// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles

// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 









// FP Compare instructions







//
// TAGs for instruction bus
//






//
// TAGs for data bus
//








//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word


//
// Instruction opcode groups (basic)
//









/* */



/* */















/* */



/* */







/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//




//
// N part width
//


//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


















/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group


// Width of the group bits


// Bits that define offset inside the group


// List of groups












/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//










//
// SR bits
//




















//
// Bits that define offset inside the group
//


//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//



//
// FPCSR bits
//














/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)






// PMR offset inside PM group of registers


// PM group


// Define if PMR can be read/written at any address inside PM group


// Define if reading PMR is allowed


// Define if unused PMR bits should be zero



/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented


//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 


// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//


































// Position of offset bits inside SPR address


// DCR bits





// DMR1 bits
















// DMR2 bits





// DWCR bits



// DSR bits
















// DRR bits















// Define if reading DU regs is allowed


// Define if unused DU registers bits should be zero


// Define if IF/LSU status is not needed by devel i/f


/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented


// Define number of interrupt inputs (2-31)


// Address offsets of PIC registers inside PIC group



// Position of offset bits inside SPR address


// Define if you want these PIC registers to be implemented



// Define if reading PIC registers is allowed


// Define if unused PIC register bits should be zero



/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented


// Address offsets of TT registers inside TT group



// Position of offset bits inside SPR group


// Define if you want these TT registers to be implemented



// TTMR bits





// Define if reading TT registers is allowed



//////////////////////////////////////////////
//
// MAC
//



//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]



//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// DTLBMR fields
//





//
// DTLBTR fields
//













//
// DTLB configuration
//











//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//


//
// ITLBMR fields
//





//
// ITLBTR fields
//











//
// ITLB configuration
//











//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//



/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.



 


//
// IC configurations
//










































/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes



 


// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//


// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions

// Data cache group SPR addresses







//
// DC configurations
//


































/////////////////////////////////////////////////
//
//

//
//
