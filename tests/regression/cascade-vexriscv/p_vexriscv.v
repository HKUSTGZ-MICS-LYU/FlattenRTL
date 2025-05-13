module bmb_full_to_mem (
	clk_i,
	rst_ni,
	bmb_cmd_valid,
	bmb_cmd_ready,
	bmb_cmd_payload_address,
	bmb_cmd_payload_size,
	bmb_cmd_payload_wr,
	bmb_cmd_payload_uncached,
	bmb_cmd_payload_data,
	bmb_cmd_payload_mask,
	bmb_cmd_payload_last,
	bmb_rsp_valid,
	bmb_rsp_payload_data,
	bmb_rsp_payload_last,
	bmb_rsp_payload_error,
	mem_req,
	mem_gnt,
	mem_addr,
	mem_wdata,
	mem_strb,
	mem_we,
	mem_rdata
);
	parameter AddrSize = 32;
	parameter DataSize = 64;
	parameter PayloadBits = 2;
	input clk_i;
	input rst_ni;
	input bmb_cmd_valid;
	output bmb_cmd_ready;
	input [AddrSize - 1:0] bmb_cmd_payload_address;
	input [PayloadBits - 1:0] bmb_cmd_payload_size;
	input bmb_cmd_payload_wr;
	input bmb_cmd_payload_uncached;
	input [DataSize - 1:0] bmb_cmd_payload_data;
	input [(DataSize >> 3) - 1:0] bmb_cmd_payload_mask;
	input bmb_cmd_payload_last;
	output reg bmb_rsp_valid;
	output [DataSize - 1:0] bmb_rsp_payload_data;
	output bmb_rsp_payload_last;
	output bmb_rsp_payload_error;
	output mem_req;
	input mem_gnt;
	output [AddrSize - 1:0] mem_addr;
	output [DataSize - 1:0] mem_wdata;
	output [(DataSize >> 3) - 1:0] mem_strb;
	output mem_we;
	input [DataSize - 1:0] mem_rdata;
	assign mem_req = bmb_cmd_valid;
	assign mem_addr = bmb_cmd_payload_address;
	assign mem_wdata = bmb_cmd_payload_data;
	assign mem_strb = bmb_cmd_payload_mask;
	assign mem_we = bmb_cmd_payload_wr;
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			bmb_rsp_valid <= 1'b0;
		else
			bmb_rsp_valid <= bmb_cmd_valid & ~bmb_cmd_payload_wr;
	assign bmb_cmd_ready = 1'b1;
	assign bmb_rsp_payload_data = mem_rdata;
	assign bmb_rsp_payload_last = 1'b1;
	assign bmb_rsp_payload_error = 1'b0;
endmodule


module memreq_aligner (
	clk_i,
	mem_req_misaligned,
	mem_gnt_misaligned,
	mem_addr_misaligned,
	mem_wdata_misaligned,
	mem_strb_misaligned,
	mem_we_misaligned,
	mem_rdata_misaligned,
	mem_req_aligned,
	mem_gnt_aligned,
	mem_addr_aligned,
	mem_wdata_aligned,
	mem_strb_aligned,
	mem_we_aligned,
	mem_rdata_aligned
);
	parameter [31:0] AddrSize = 32;
	parameter [31:0] DataSize = 64;
	parameter [31:0] AlignmentBytes = 8;
	localparam [31:0] LOG2_AlignmentBytes = $clog2(AlignmentBytes);
	input clk_i;
	input mem_req_misaligned;
	output mem_gnt_misaligned;
	input [AddrSize - 1:0] mem_addr_misaligned;
	input [DataSize - 1:0] mem_wdata_misaligned;
	input [(DataSize >> 3) - 1:0] mem_strb_misaligned;
	input mem_we_misaligned;
	output [DataSize - 1:0] mem_rdata_misaligned;
	output mem_req_aligned;
	input mem_gnt_aligned;
	output [AddrSize - 1:0] mem_addr_aligned;
	output [DataSize - 1:0] mem_wdata_aligned;
	output [(DataSize >> 3) - 1:0] mem_strb_aligned;
	output mem_we_aligned;
	input [DataSize - 1:0] mem_rdata_aligned;
	wire [LOG2_AlignmentBytes - 1:0] shift_offset;
	assign shift_offset = mem_addr_misaligned[LOG2_AlignmentBytes - 1:0];
	wire [DataSize - 1:0] alignment_mask;
	assign alignment_mask = {{32 - LOG2_AlignmentBytes {1'b1}}, {LOG2_AlignmentBytes {1'b0}}};
	assign mem_addr_aligned = mem_addr_misaligned & alignment_mask;
	assign mem_strb_aligned = mem_strb_misaligned;
	assign mem_req_aligned = mem_req_misaligned;
	assign mem_wdata_aligned = mem_wdata_misaligned << (shift_offset << 3);
	assign mem_we_aligned = mem_we_misaligned;
	assign mem_gnt_misaligned = mem_gnt_aligned;
	assign mem_rdata_misaligned = mem_rdata_aligned >> (shift_offset << 3);
endmodule


module vexriscv_mem_top (
	clk_i,
	rst_ni,
	data_mem_req,
	data_mem_gnt,
	data_mem_addr,
	data_mem_wdata,
	data_mem_strb,
	data_mem_we,
	data_mem_rdata,
	instr_mem_req,
	instr_mem_gnt,
	instr_mem_addr,
	instr_mem_wdata,
	instr_mem_strb,
	instr_mem_we,
	instr_mem_rdata,
	debug_bus_cmd_valid,
	debug_bus_cmd_ready,
	debug_bus_cmd_payload_wr,
	debug_bus_cmd_payload_address,
	debug_bus_cmd_payload_data,
	debug_bus_rsp_data,
	debug_resetOut,
	timerInterrupt,
	externalInterrupt,
	externalInterruptS,
	softwareInterrupt
);
	parameter [31:0] AddrSize = 32;
	parameter [31:0] DataSize = 64;
	input clk_i;
	input rst_ni;
	output data_mem_req;
	input data_mem_gnt;
	output [AddrSize - 1:0] data_mem_addr;
	output [DataSize - 1:0] data_mem_wdata;
	output [(DataSize >> 3) - 1:0] data_mem_strb;
	output data_mem_we;
	input [DataSize - 1:0] data_mem_rdata;
	output instr_mem_req;
	input instr_mem_gnt;
	output [AddrSize - 1:0] instr_mem_addr;
	output [DataSize - 1:0] instr_mem_wdata;
	output [(DataSize >> 3) - 1:0] instr_mem_strb;
	output instr_mem_we;
	input [DataSize - 1:0] instr_mem_rdata;
	input debug_bus_cmd_valid;
	output debug_bus_cmd_ready;
	input debug_bus_cmd_payload_wr;
	input [7:0] debug_bus_cmd_payload_address;
	input [31:0] debug_bus_cmd_payload_data;
	output [31:0] debug_bus_rsp_data;
	output debug_resetOut;
	input timerInterrupt;
	input externalInterrupt;
	input externalInterruptS;
	input softwareInterrupt;
	wire data_mem_req_misaligned;
	wire data_mem_gnt_misaligned;
	wire [AddrSize - 1:0] data_mem_addr_misaligned;
	wire [DataSize - 1:0] data_mem_wdata_misaligned;
	wire [(DataSize >> 3) - 1:0] data_mem_strb_misaligned;
	wire data_mem_we_misaligned;
	wire [DataSize - 1:0] data_mem_rdata_misaligned;
	wire instr_mem_req_misaligned;
	wire instr_mem_gnt_misaligned;
	wire [AddrSize - 1:0] instr_mem_addr_misaligned;
	wire [DataSize - 1:0] instr_mem_wdata_misaligned;
	wire [(DataSize >> 3) - 1:0] instr_mem_strb_misaligned;
	wire instr_mem_we_misaligned;
	wire [DataSize - 1:0] instr_mem_rdata_misaligned;
	wire dBus_cmd_valid;
	wire dBus_cmd_ready;
	wire dBus_cmd_payload_wr;
	wire dBus_cmd_payload_uncached;
	wire [31:0] dBus_cmd_payload_address;
	wire [63:0] dBus_cmd_payload_data;
	wire [7:0] dBus_cmd_payload_mask;
	wire [2:0] dBus_cmd_payload_size;
	wire dBus_cmd_payload_last;
	wire dBus_rsp_valid;
	wire dBus_rsp_payload_last;
	wire [63:0] dBus_rsp_payload_data;
	wire dBus_rsp_payload_error;
	wire iBus_cmd_valid;
	wire iBus_cmd_ready;
	wire [31:0] iBus_cmd_payload_address;
	wire [2:0] iBus_cmd_payload_size;
	wire iBus_rsp_valid;
	wire [63:0] iBus_rsp_payload_data;
	wire iBus_rsp_payload_error;
	VexRiscv i_vexriscv(
		.clk(clk_i),
		.reset(~rst_ni),
		.dBus_cmd_valid(dBus_cmd_valid),
		.dBus_cmd_ready(dBus_cmd_ready),
		.dBus_cmd_payload_wr(dBus_cmd_payload_wr),
		.dBus_cmd_payload_uncached(dBus_cmd_payload_uncached),
		.dBus_cmd_payload_address(dBus_cmd_payload_address),
		.dBus_cmd_payload_data(dBus_cmd_payload_data),
		.dBus_cmd_payload_mask(dBus_cmd_payload_mask),
		.dBus_cmd_payload_size(dBus_cmd_payload_size),
		.dBus_cmd_payload_last(dBus_cmd_payload_last),
		.dBus_rsp_valid(dBus_rsp_valid),
		.dBus_rsp_payload_last(dBus_rsp_payload_last),
		.dBus_rsp_payload_data(dBus_rsp_payload_data),
		.dBus_rsp_payload_error(dBus_rsp_payload_error),
		.iBus_cmd_valid(iBus_cmd_valid),
		.iBus_cmd_ready(iBus_cmd_ready),
		.iBus_cmd_payload_address(iBus_cmd_payload_address),
		.iBus_cmd_payload_size(iBus_cmd_payload_size),
		.iBus_rsp_valid(iBus_rsp_valid),
		.iBus_rsp_payload_data(iBus_rsp_payload_data),
		.iBus_rsp_payload_error(iBus_rsp_payload_error),
		.timerInterrupt(timerInterrupt),
		.externalInterrupt(externalInterrupt),
		.externalInterruptS(externalInterruptS),
		.softwareInterrupt(softwareInterrupt)
	);
	bmb_full_to_mem #(
		.AddrSize(AddrSize),
		.DataSize(DataSize)
	) i_instr_bmb_full_to_mem(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.bmb_cmd_valid(iBus_cmd_valid),
		.bmb_cmd_ready(iBus_cmd_ready),
		.bmb_cmd_payload_address(iBus_cmd_payload_address),
		.bmb_cmd_payload_size(iBus_cmd_payload_size),
		.bmb_cmd_payload_wr(1'b0),
		.bmb_cmd_payload_uncached(1'b0),
		.bmb_cmd_payload_data(1'sb0),
		.bmb_cmd_payload_mask(1'sb0),
		.bmb_cmd_payload_last(1'b1),
		.bmb_rsp_valid(iBus_rsp_valid),
		.bmb_rsp_payload_data(iBus_rsp_payload_data),
		.bmb_rsp_payload_last(),
		.bmb_rsp_payload_error(iBus_rsp_payload_error),
		.mem_req(instr_mem_req_misaligned),
		.mem_gnt(instr_mem_gnt_misaligned),
		.mem_addr(instr_mem_addr_misaligned),
		.mem_wdata(instr_mem_wdata_misaligned),
		.mem_strb(instr_mem_strb_misaligned),
		.mem_we(instr_mem_we_misaligned),
		.mem_rdata(instr_mem_rdata_misaligned)
	);
	bmb_full_to_mem #(
		.AddrSize(AddrSize),
		.DataSize(DataSize)
	) i_data_bmb_full_to_mem(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.bmb_cmd_valid(dBus_cmd_valid),
		.bmb_cmd_ready(dBus_cmd_ready),
		.bmb_cmd_payload_address(dBus_cmd_payload_address),
		.bmb_cmd_payload_size(dBus_cmd_payload_size),
		.bmb_cmd_payload_wr(dBus_cmd_payload_wr),
		.bmb_cmd_payload_uncached(dBus_cmd_payload_uncached),
		.bmb_cmd_payload_data(dBus_cmd_payload_data),
		.bmb_cmd_payload_mask(dBus_cmd_payload_mask),
		.bmb_cmd_payload_last(dBus_cmd_payload_last),
		.bmb_rsp_valid(dBus_rsp_valid),
		.bmb_rsp_payload_data(dBus_rsp_payload_data),
		.bmb_rsp_payload_last(dBus_rsp_payload_last),
		.bmb_rsp_payload_error(dBus_rsp_payload_error),
		.mem_req(data_mem_req_misaligned),
		.mem_gnt(data_mem_gnt_misaligned),
		.mem_addr(data_mem_addr_misaligned),
		.mem_wdata(data_mem_wdata_misaligned),
		.mem_strb(data_mem_strb_misaligned),
		.mem_we(data_mem_we_misaligned),
		.mem_rdata(data_mem_rdata_misaligned)
	);
	memreq_aligner #(
		.AlignmentBytes(8),
		.AddrSize(AddrSize),
		.DataSize(DataSize)
	) i_instr_memreq_aligner(
		.mem_req_misaligned(instr_mem_req_misaligned),
		.mem_gnt_misaligned(instr_mem_gnt_misaligned),
		.mem_addr_misaligned(instr_mem_addr_misaligned),
		.mem_wdata_misaligned(instr_mem_wdata_misaligned),
		.mem_strb_misaligned(instr_mem_strb_misaligned),
		.mem_we_misaligned(instr_mem_we_misaligned),
		.mem_rdata_misaligned(instr_mem_rdata_misaligned),
		.mem_req_aligned(instr_mem_req),
		.mem_gnt_aligned(instr_mem_gnt),
		.mem_addr_aligned(instr_mem_addr),
		.mem_wdata_aligned(instr_mem_wdata),
		.mem_strb_aligned(instr_mem_strb),
		.mem_we_aligned(instr_mem_we),
		.mem_rdata_aligned(instr_mem_rdata)
	);
	memreq_aligner #(
		.AlignmentBytes(8),
		.AddrSize(AddrSize),
		.DataSize(DataSize)
	) i_data_memreq_aligner(
		.mem_req_misaligned(data_mem_req_misaligned),
		.mem_gnt_misaligned(data_mem_gnt_misaligned),
		.mem_addr_misaligned(data_mem_addr_misaligned),
		.mem_wdata_misaligned(data_mem_wdata_misaligned),
		.mem_strb_misaligned(data_mem_strb_misaligned),
		.mem_we_misaligned(data_mem_we_misaligned),
		.mem_rdata_misaligned(data_mem_rdata_misaligned),
		.mem_req_aligned(data_mem_req),
		.mem_gnt_aligned(data_mem_gnt),
		.mem_addr_aligned(data_mem_addr),
		.mem_wdata_aligned(data_mem_wdata),
		.mem_strb_aligned(data_mem_strb),
		.mem_we_aligned(data_mem_we),
		.mem_rdata_aligned(data_mem_rdata)
	);
endmodule


module vexriscv_tiny_soc (
	clk_i,
	rst_ni,
	instr_mem_req_o,
	instr_mem_gnt_o,
	instr_mem_addr_o,
	instr_mem_wdata_o,
	instr_mem_strb_o,
	instr_mem_we_o,
	instr_mem_rdata_o,
	data_mem_req_o,
	data_mem_gnt_o,
	data_mem_addr_o,
	data_mem_wdata_o,
	data_mem_strb_o,
	data_mem_we_o,
	data_mem_rdata_o
);
	parameter [31:0] InstrMemDepth = 1048576;
	parameter [31:0] DataMemDepth = 1048576;
	input clk_i;
	input rst_ni;
	output instr_mem_req_o;
	output instr_mem_gnt_o;
	output [31:0] instr_mem_addr_o;
	output [63:0] instr_mem_wdata_o;
	output [7:0] instr_mem_strb_o;
	output instr_mem_we_o;
	output [63:0] instr_mem_rdata_o;
	output data_mem_req_o;
	output data_mem_gnt_o;
	output [31:0] data_mem_addr_o;
	output [63:0] data_mem_wdata_o;
	output [7:0] data_mem_strb_o;
	output data_mem_we_o;
	output [63:0] data_mem_rdata_o;
	wire timerInterrupt;
	wire externalInterrupt;
	wire externalInterruptS;
	wire softwareInterrupt;
	assign timerInterrupt = 1'sb0;
	assign externalInterrupt = 1'sb0;
	assign externalInterruptS = 1'sb0;
	assign softwareInterrupt = 1'sb0;
	vexriscv_mem_top i_vexriscv_mem_top(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.data_mem_req(data_mem_req_o),
		.data_mem_gnt(data_mem_gnt_o),
		.data_mem_addr(data_mem_addr_o),
		.data_mem_wdata(data_mem_wdata_o),
		.data_mem_strb(data_mem_strb_o),
		.data_mem_we(data_mem_we_o),
		.data_mem_rdata(data_mem_rdata_o),
		.instr_mem_req(instr_mem_req_o),
		.instr_mem_gnt(instr_mem_gnt_o),
		.instr_mem_addr(instr_mem_addr_o),
		.instr_mem_wdata(instr_mem_wdata_o),
		.instr_mem_strb(instr_mem_strb_o),
		.instr_mem_we(instr_mem_we_o),
		.instr_mem_rdata(instr_mem_rdata_o),
		.timerInterrupt(timerInterrupt),
		.externalInterrupt(externalInterrupt),
		.externalInterruptS(externalInterruptS),
		.softwareInterrupt(softwareInterrupt)
	);
	// sram_mem #(
	// 	.Width(64),
	// 	.Depth(InstrMemDepth),
	// 	.RelocateRequestUp(64'h0000000010000000)
	// ) i_instr_rom(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.req_i(instr_mem_req_o),
	// 	.write_i(instr_mem_we_o),
	// 	.addr_i(instr_mem_addr_o >> 3),
	// 	.wdata_i(instr_mem_wdata_o),
	// 	.wmask_i({{8 {instr_mem_strb_o[7]}}, {8 {instr_mem_strb_o[6]}}, {8 {instr_mem_strb_o[5]}}, {8 {instr_mem_strb_o[4]}}, {8 {instr_mem_strb_o[3]}}, {8 {instr_mem_strb_o[2]}}, {8 {instr_mem_strb_o[1]}}, {8 {instr_mem_strb_o[0]}}}),
	// 	.rdata_o(instr_mem_rdata_o)
	// );
	// assign instr_mem_gnt_o = 1'sb1;
	// sram_mem #(
	// 	.Width(64),
	// 	.Depth(DataMemDepth),
	// 	.RelocateRequestUp(64'h0000000010000000)
	// ) i_data_sram(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.req_i(data_mem_req_o),
	// 	.write_i(data_mem_we_o),
	// 	.addr_i(data_mem_addr_o >> 3),
	// 	.wdata_i(data_mem_wdata_o),
	// 	.wmask_i({{8 {data_mem_strb_o[7]}}, {8 {data_mem_strb_o[6]}}, {8 {data_mem_strb_o[5]}}, {8 {data_mem_strb_o[4]}}, {8 {data_mem_strb_o[3]}}, {8 {data_mem_strb_o[2]}}, {8 {data_mem_strb_o[1]}}, {8 {data_mem_strb_o[0]}}}),
	// 	.rdata_o(data_mem_rdata_o)
	// );
	assign data_mem_gnt_o = 1'sb1;
endmodule


module VexRiscv (
	dBus_cmd_valid,
	dBus_cmd_ready,
	dBus_cmd_payload_wr,
	dBus_cmd_payload_uncached,
	dBus_cmd_payload_address,
	dBus_cmd_payload_data,
	dBus_cmd_payload_mask,
	dBus_cmd_payload_size,
	dBus_cmd_payload_last,
	dBus_rsp_valid,
	dBus_rsp_payload_last,
	dBus_rsp_payload_data,
	dBus_rsp_payload_error,
	timerInterrupt,
	externalInterrupt,
	softwareInterrupt,
	externalInterruptS,
	iBus_cmd_valid,
	iBus_cmd_ready,
	iBus_cmd_payload_address,
	iBus_cmd_payload_size,
	iBus_rsp_valid,
	iBus_rsp_payload_data,
	iBus_rsp_payload_error,
	clk,
	reset
);
	output dBus_cmd_valid;
	input dBus_cmd_ready;
	output dBus_cmd_payload_wr;
	output dBus_cmd_payload_uncached;
	output [31:0] dBus_cmd_payload_address;
	output [63:0] dBus_cmd_payload_data;
	output [7:0] dBus_cmd_payload_mask;
	output [1:0] dBus_cmd_payload_size;
	output dBus_cmd_payload_last;
	input dBus_rsp_valid;
	input dBus_rsp_payload_last;
	input [63:0] dBus_rsp_payload_data;
	input dBus_rsp_payload_error;
	input timerInterrupt;
	input externalInterrupt;
	input softwareInterrupt;
	input externalInterruptS;
	output iBus_cmd_valid;
	input iBus_cmd_ready;
	output reg [31:0] iBus_cmd_payload_address;
	output [1:0] iBus_cmd_payload_size;
	input iBus_rsp_valid;
	input [63:0] iBus_rsp_payload_data;
	input iBus_rsp_payload_error;
	input clk;
	input reset;
	parameter AluBitwiseCtrlEnum_AND_1 = 2'h2;
	parameter AluBitwiseCtrlEnum_OR_1 = 2'h1;
	parameter AluBitwiseCtrlEnum_XOR_1 = 2'h0;
	parameter AluCtrlEnum_ADD_SUB = 2'h0;
	parameter AluCtrlEnum_BITWISE = 2'h2;
	parameter AluCtrlEnum_SLT_SLTU = 2'h1;
	parameter BranchCtrlEnum_B = 2'h1;
	parameter BranchCtrlEnum_INC = 2'h0;
	parameter BranchCtrlEnum_JAL = 2'h2;
	parameter BranchCtrlEnum_JALR = 2'h3;
	parameter EnvCtrlEnum_EBREAK = 3'h4;
	parameter EnvCtrlEnum_ECALL = 3'h3;
	parameter EnvCtrlEnum_NONE = 3'h0;
	parameter EnvCtrlEnum_WFI = 3'h2;
	parameter EnvCtrlEnum_XRET = 3'h1;
	parameter FpuFormat_DOUBLE = 1'b1;
	parameter FpuFormat_FLOAT = 1'b0;
	parameter FpuOpcode_ADD = 4'h3;
	parameter FpuOpcode_CMP = 4'h7;
	parameter FpuOpcode_DIV = 4'h8;
	parameter FpuOpcode_F2I = 4'h6;
	parameter FpuOpcode_FCLASS = 4'he;
	parameter FpuOpcode_FCVT_X_X = 4'hf;
	parameter FpuOpcode_FMA = 4'h4;
	parameter FpuOpcode_FMV_W_X = 4'hd;
	parameter FpuOpcode_FMV_X_W = 4'hc;
	parameter FpuOpcode_I2F = 4'h5;
	parameter FpuOpcode_LOAD = 4'h0;
	parameter FpuOpcode_MIN_MAX = 4'ha;
	parameter FpuOpcode_MUL = 4'h2;
	parameter FpuOpcode_SGNJ = 4'hb;
	parameter FpuOpcode_SQRT = 4'h9;
	parameter FpuOpcode_STORE = 4'h1;
	parameter FpuRoundMode_RDN = 3'h2;
	parameter FpuRoundMode_RMM = 3'h4;
	parameter FpuRoundMode_RNE = 3'h0;
	parameter FpuRoundMode_RTZ = 3'h1;
	parameter FpuRoundMode_RUP = 3'h3;
	parameter MmuPlugin_shared_State_IDLE = 3'h0;
	parameter MmuPlugin_shared_State_L0_CMD = 3'h3;
	parameter MmuPlugin_shared_State_L0_RSP = 3'h4;
	parameter MmuPlugin_shared_State_L1_CMD = 3'h1;
	parameter MmuPlugin_shared_State_L1_RSP = 3'h2;
	parameter ShiftCtrlEnum_DISABLE_1 = 2'h0;
	parameter ShiftCtrlEnum_SLL_1 = 2'h1;
	parameter ShiftCtrlEnum_SRA_1 = 2'h3;
	parameter ShiftCtrlEnum_SRL_1 = 2'h2;
	parameter Src1CtrlEnum_IMU = 2'h1;
	parameter Src1CtrlEnum_PC_INCREMENT = 2'h2;
	parameter Src1CtrlEnum_RS = 2'h0;
	parameter Src1CtrlEnum_URS1 = 2'h3;
	parameter Src2CtrlEnum_IMI = 2'h1;
	parameter Src2CtrlEnum_IMS = 2'h2;
	parameter Src2CtrlEnum_PC = 2'h3;
	parameter Src2CtrlEnum_RS = 2'h0;
	wire [31:0] BranchPlugin_branchExceptionPort_payload_badAddr;
	wire [3:0] BranchPlugin_branchExceptionPort_payload_code;
	wire BranchPlugin_branchExceptionPort_valid;
	wire BranchPlugin_inDebugNoFetchFlag;
	wire [31:0] BranchPlugin_jumpInterface_payload;
	wire BranchPlugin_jumpInterface_valid;
	wire CsrPlugin_allowEbreakException;
	wire CsrPlugin_allowException;
	wire CsrPlugin_allowInterrupts;
	reg CsrPlugin_csrMapping_allowCsrSignal;
	reg CsrPlugin_csrMapping_doForceFailCsr;
	wire CsrPlugin_csrMapping_hazardFree;
	wire [31:0] CsrPlugin_csrMapping_readDataInit;
	wire [31:0] CsrPlugin_csrMapping_readDataSignal;
	wire [31:0] CsrPlugin_csrMapping_writeDataSignal;
	wire CsrPlugin_exception;
	wire CsrPlugin_exceptionPendings_0;
	wire CsrPlugin_exceptionPendings_1;
	wire CsrPlugin_exceptionPendings_2;
	wire CsrPlugin_exceptionPendings_3;
	reg [31:0] CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
	reg [3:0] CsrPlugin_exceptionPortCtrl_exceptionContext_code;
	wire [1:0] CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
	reg [1:0] CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped;
	reg CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
	reg CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
	reg CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
	reg CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
	reg CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
	reg CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
	reg CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
	reg CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
	wire CsrPlugin_forceMachineWire;
	reg CsrPlugin_hadException;
	reg CsrPlugin_inWfi;
	wire CsrPlugin_interruptJump;
	reg [3:0] CsrPlugin_interrupt_code;
	reg [1:0] CsrPlugin_interrupt_targetPrivilege;
	reg CsrPlugin_interrupt_valid;
	reg [31:0] CsrPlugin_jumpInterface_payload;
	reg CsrPlugin_jumpInterface_valid;
	reg CsrPlugin_lastStageWasWfi;
	reg [3:0] CsrPlugin_mcause_exceptionCode;
	reg CsrPlugin_mcause_interrupt;
	reg CsrPlugin_mcounteren_CY;
	reg CsrPlugin_mcounteren_IR;
	wire CsrPlugin_mcounteren_TM;
	reg [63:0] CsrPlugin_mcycle;
	reg CsrPlugin_medeleg_ES;
	reg CsrPlugin_medeleg_EU;
	reg CsrPlugin_medeleg_IAF;
	reg CsrPlugin_medeleg_IAM;
	reg CsrPlugin_medeleg_II;
	reg CsrPlugin_medeleg_IPF;
	reg CsrPlugin_medeleg_LAF;
	reg CsrPlugin_medeleg_LAM;
	reg CsrPlugin_medeleg_LPF;
	reg CsrPlugin_medeleg_SAF;
	reg CsrPlugin_medeleg_SAM;
	reg CsrPlugin_medeleg_SPF;
	reg [31:0] CsrPlugin_mepc;
	reg CsrPlugin_mideleg_SE;
	reg CsrPlugin_mideleg_SS;
	reg CsrPlugin_mideleg_ST;
	reg CsrPlugin_mie_MEIE;
	reg CsrPlugin_mie_MSIE;
	reg CsrPlugin_mie_MTIE;
	reg [63:0] CsrPlugin_minstret;
	reg CsrPlugin_mip_MEIP;
	reg CsrPlugin_mip_MSIP;
	reg CsrPlugin_mip_MTIP;
	wire [1:0] CsrPlugin_misa_base;
	wire [25:0] CsrPlugin_misa_extensions;
	reg [31:0] CsrPlugin_mscratch;
	reg CsrPlugin_mstatus_MIE;
	reg CsrPlugin_mstatus_MPIE;
	reg [1:0] CsrPlugin_mstatus_MPP;
	reg [31:0] CsrPlugin_mtval;
	reg [29:0] CsrPlugin_mtvec_base;
	reg [1:0] CsrPlugin_mtvec_mode;
	wire CsrPlugin_pipelineLiberator_active;
	reg CsrPlugin_pipelineLiberator_done;
	reg CsrPlugin_pipelineLiberator_pcValids_0;
	reg CsrPlugin_pipelineLiberator_pcValids_1;
	reg CsrPlugin_pipelineLiberator_pcValids_2;
	reg [1:0] CsrPlugin_privilege;
	wire [31:0] CsrPlugin_redoInterface_payload;
	reg CsrPlugin_redoInterface_valid;
	reg CsrPlugin_rescheduleLogic_rescheduleNext;
	reg [8:0] CsrPlugin_satp_ASID;
	reg CsrPlugin_satp_MODE;
	reg [21:0] CsrPlugin_satp_PPN;
	reg [3:0] CsrPlugin_scause_exceptionCode;
	reg CsrPlugin_scause_interrupt;
	reg CsrPlugin_scounteren_CY;
	reg CsrPlugin_scounteren_IR;
	wire CsrPlugin_scounteren_TM;
	wire [31:0] CsrPlugin_selfException_payload_badAddr;
	reg [3:0] CsrPlugin_selfException_payload_code;
	reg CsrPlugin_selfException_valid;
	reg [31:0] CsrPlugin_sepc;
	reg CsrPlugin_sie_SEIE;
	reg CsrPlugin_sie_SSIE;
	reg CsrPlugin_sie_STIE;
	reg CsrPlugin_sip_SEIP_INPUT;
	wire CsrPlugin_sip_SEIP_OR;
	reg CsrPlugin_sip_SEIP_SOFT;
	reg CsrPlugin_sip_SSIP;
	reg CsrPlugin_sip_STIP;
	reg [31:0] CsrPlugin_sscratch;
	reg CsrPlugin_sstatus_SIE;
	reg CsrPlugin_sstatus_SPIE;
	reg CsrPlugin_sstatus_SPP;
	reg [31:0] CsrPlugin_stval;
	reg [29:0] CsrPlugin_stvec_base;
	reg [1:0] CsrPlugin_stvec_mode;
	reg [1:0] CsrPlugin_targetPrivilege;
	reg CsrPlugin_thirdPartyWake;
	reg [3:0] CsrPlugin_trapCause;
	wire CsrPlugin_trapCauseEbreakDebug;
	wire CsrPlugin_trapEnterDebug;
	reg CsrPlugin_xretAwayFromMachine;
	reg [29:0] CsrPlugin_xtvec_base;
	reg [1:0] CsrPlugin_xtvec_mode;
	reg DBusBypass0_cond;
	wire [63:0] DBusBypass0_value;
	wire [31:0] DBusCachedPlugin_exceptionBus_payload_badAddr;
	reg [3:0] DBusCachedPlugin_exceptionBus_payload_code;
	reg DBusCachedPlugin_exceptionBus_valid;
	reg DBusCachedPlugin_forceDatapath;
	wire DBusCachedPlugin_mmuBus_busy;
	reg DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation;
	wire DBusCachedPlugin_mmuBus_cmd_0_isStuck;
	wire DBusCachedPlugin_mmuBus_cmd_0_isValid;
	wire [31:0] DBusCachedPlugin_mmuBus_cmd_0_virtualAddress;
	wire DBusCachedPlugin_mmuBus_end;
	reg DBusCachedPlugin_mmuBus_rsp_allowExecute;
	reg DBusCachedPlugin_mmuBus_rsp_allowRead;
	reg DBusCachedPlugin_mmuBus_rsp_allowWrite;
	wire DBusCachedPlugin_mmuBus_rsp_bypassTranslation;
	reg DBusCachedPlugin_mmuBus_rsp_exception;
	wire DBusCachedPlugin_mmuBus_rsp_isIoAccess;
	reg DBusCachedPlugin_mmuBus_rsp_isPaging;
	reg [31:0] DBusCachedPlugin_mmuBus_rsp_physicalAddress;
	reg DBusCachedPlugin_mmuBus_rsp_refilling;
	wire [31:0] DBusCachedPlugin_mmuBus_rsp_ways_0_physical;
	wire DBusCachedPlugin_mmuBus_rsp_ways_0_sel;
	wire [31:0] DBusCachedPlugin_mmuBus_rsp_ways_1_physical;
	wire DBusCachedPlugin_mmuBus_rsp_ways_1_sel;
	wire [31:0] DBusCachedPlugin_mmuBus_rsp_ways_2_physical;
	wire DBusCachedPlugin_mmuBus_rsp_ways_2_sel;
	wire [31:0] DBusCachedPlugin_mmuBus_rsp_ways_3_physical;
	wire DBusCachedPlugin_mmuBus_rsp_ways_3_sel;
	wire [31:0] DBusCachedPlugin_redoBranch_payload;
	reg DBusCachedPlugin_redoBranch_valid;
	reg [31:0] DBusCachedPlugin_rspCounter;
	reg FpuPlugin_accessFpuCsr;
	wire FpuPlugin_csrActive;
	reg FpuPlugin_flags_DZ;
	reg FpuPlugin_flags_NV;
	reg FpuPlugin_flags_NX;
	reg FpuPlugin_flags_OF;
	reg FpuPlugin_flags_UF;
	wire FpuPlugin_fpu_io_port_0_cmd_ready;
	wire FpuPlugin_fpu_io_port_0_commit_ready;
	wire FpuPlugin_fpu_io_port_0_completion_payload_flags_DZ;
	wire FpuPlugin_fpu_io_port_0_completion_payload_flags_NV;
	wire FpuPlugin_fpu_io_port_0_completion_payload_flags_NX;
	wire FpuPlugin_fpu_io_port_0_completion_payload_flags_OF;
	wire FpuPlugin_fpu_io_port_0_completion_payload_flags_UF;
	wire FpuPlugin_fpu_io_port_0_completion_payload_written;
	wire FpuPlugin_fpu_io_port_0_completion_valid;
	wire FpuPlugin_fpu_io_port_0_rsp_payload_NV;
	wire FpuPlugin_fpu_io_port_0_rsp_payload_NX;
	wire [63:0] FpuPlugin_fpu_io_port_0_rsp_payload_value;
	wire FpuPlugin_fpu_io_port_0_rsp_valid;
	reg [1:0] FpuPlugin_fs;
	wire FpuPlugin_hasPending;
	reg [5:0] FpuPlugin_pendings;
	wire FpuPlugin_port_cmd_fire;
	wire FpuPlugin_port_cmd_fire_1;
	wire FpuPlugin_port_cmd_fire_2;
	wire FpuPlugin_port_cmd_isStall;
	wire [1:0] FpuPlugin_port_cmd_payload_arg;
	wire FpuPlugin_port_cmd_payload_format;
	wire [3:0] FpuPlugin_port_cmd_payload_opcode;
	wire [4:0] FpuPlugin_port_cmd_payload_rd;
	wire [2:0] FpuPlugin_port_cmd_payload_roundMode;
	wire [4:0] FpuPlugin_port_cmd_payload_rs1;
	wire [4:0] FpuPlugin_port_cmd_payload_rs2;
	wire [4:0] FpuPlugin_port_cmd_payload_rs3;
	wire FpuPlugin_port_cmd_ready;
	wire FpuPlugin_port_cmd_valid;
	wire [3:0] FpuPlugin_port_commit_payload_opcode;
	wire [4:0] FpuPlugin_port_commit_payload_rd;
	wire [63:0] FpuPlugin_port_commit_payload_value;
	wire FpuPlugin_port_commit_payload_write;
	wire FpuPlugin_port_commit_ready;
	wire FpuPlugin_port_commit_valid;
	wire FpuPlugin_port_completion_payload_flags_DZ;
	wire FpuPlugin_port_completion_payload_flags_NV;
	wire FpuPlugin_port_completion_payload_flags_NX;
	wire FpuPlugin_port_completion_payload_flags_OF;
	wire FpuPlugin_port_completion_payload_flags_UF;
	wire FpuPlugin_port_completion_payload_written;
	wire FpuPlugin_port_completion_valid;
	wire FpuPlugin_port_rsp_fire;
	wire FpuPlugin_port_rsp_payload_NV;
	wire FpuPlugin_port_rsp_payload_NX;
	wire [63:0] FpuPlugin_port_rsp_payload_value;
	reg FpuPlugin_port_rsp_ready;
	wire FpuPlugin_port_rsp_valid;
	reg [2:0] FpuPlugin_rm;
	wire FpuPlugin_sd;
	wire HazardSimplePlugin_addr0Match;
	wire HazardSimplePlugin_addr1Match;
	reg HazardSimplePlugin_src0Hazard;
	reg HazardSimplePlugin_src1Hazard;
	reg [4:0] HazardSimplePlugin_writeBackBuffer_payload_address;
	reg [31:0] HazardSimplePlugin_writeBackBuffer_payload_data;
	reg HazardSimplePlugin_writeBackBuffer_valid;
	wire [4:0] HazardSimplePlugin_writeBackWrites_payload_address;
	wire [31:0] HazardSimplePlugin_writeBackWrites_payload_data;
	wire HazardSimplePlugin_writeBackWrites_valid;
	wire [31:0] IBusCachedPlugin_cache_io_cpu_decode_data;
	wire IBusCachedPlugin_cache_io_cpu_decode_isStuck;
	wire IBusCachedPlugin_cache_io_cpu_decode_isValid;
	wire [31:0] IBusCachedPlugin_cache_io_cpu_decode_pc;
	wire [31:0] IBusCachedPlugin_cache_io_cpu_decode_physicalAddress;
	wire IBusCachedPlugin_cache_io_cpu_fetch_cacheMiss;
	wire [31:0] IBusCachedPlugin_cache_io_cpu_fetch_data;
	wire IBusCachedPlugin_cache_io_cpu_fetch_error;
	wire IBusCachedPlugin_cache_io_cpu_fetch_isRemoved;
	wire IBusCachedPlugin_cache_io_cpu_fetch_isStuck;
	wire IBusCachedPlugin_cache_io_cpu_fetch_isUser;
	wire IBusCachedPlugin_cache_io_cpu_fetch_isValid;
	wire IBusCachedPlugin_cache_io_cpu_fetch_mmuException;
	wire IBusCachedPlugin_cache_io_cpu_fetch_mmuRefilling;
	wire [31:0] IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress;
	reg IBusCachedPlugin_cache_io_cpu_fill_valid;
	wire IBusCachedPlugin_cache_io_cpu_prefetch_haltIt;
	wire IBusCachedPlugin_cache_io_cpu_prefetch_isValid;
	wire IBusCachedPlugin_cache_io_flush;
	wire [31:0] IBusCachedPlugin_cache_io_mem_cmd_payload_address;
	wire [1:0] IBusCachedPlugin_cache_io_mem_cmd_payload_size;
	wire IBusCachedPlugin_cache_io_mem_cmd_valid;
	wire [31:0] IBusCachedPlugin_decodeExceptionPort_payload_badAddr;
	reg [3:0] IBusCachedPlugin_decodeExceptionPort_payload_code;
	reg IBusCachedPlugin_decodeExceptionPort_valid;
	reg IBusCachedPlugin_decodePrediction_cmd_hadBranch;
	wire IBusCachedPlugin_decodePrediction_rsp_wasWrong;
	wire IBusCachedPlugin_externalFlush;
	reg IBusCachedPlugin_fetchPc_booted;
	wire IBusCachedPlugin_fetchPc_corrected;
	reg IBusCachedPlugin_fetchPc_correction;
	reg IBusCachedPlugin_fetchPc_correctionReg;
	reg IBusCachedPlugin_fetchPc_flushed;
	reg IBusCachedPlugin_fetchPc_inc;
	wire IBusCachedPlugin_fetchPc_output_fire;
	wire IBusCachedPlugin_fetchPc_output_fire_1;
	wire [31:0] IBusCachedPlugin_fetchPc_output_payload;
	wire IBusCachedPlugin_fetchPc_output_ready;
	wire IBusCachedPlugin_fetchPc_output_valid;
	reg [31:0] IBusCachedPlugin_fetchPc_pc;
	reg [31:0] IBusCachedPlugin_fetchPc_pcReg;
	reg IBusCachedPlugin_fetchPc_pcRegPropagate;
	wire [31:0] IBusCachedPlugin_fetchPc_redo_payload;
	wire IBusCachedPlugin_fetchPc_redo_valid;
	reg IBusCachedPlugin_fetcherHalt;
	wire IBusCachedPlugin_forceNoDecodeCond;
	wire IBusCachedPlugin_iBusRsp_flush;
	wire IBusCachedPlugin_iBusRsp_output_payload_isRvc;
	wire [31:0] IBusCachedPlugin_iBusRsp_output_payload_pc;
	wire IBusCachedPlugin_iBusRsp_output_payload_rsp_error;
	wire [31:0] IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
	wire IBusCachedPlugin_iBusRsp_output_ready;
	wire IBusCachedPlugin_iBusRsp_output_valid;
	reg IBusCachedPlugin_iBusRsp_readyForError;
	reg IBusCachedPlugin_iBusRsp_redoFetch;
	reg IBusCachedPlugin_iBusRsp_stages_0_halt;
	wire [31:0] IBusCachedPlugin_iBusRsp_stages_0_input_payload;
	wire IBusCachedPlugin_iBusRsp_stages_0_input_ready;
	wire IBusCachedPlugin_iBusRsp_stages_0_input_valid;
	wire [31:0] IBusCachedPlugin_iBusRsp_stages_0_output_payload;
	wire IBusCachedPlugin_iBusRsp_stages_0_output_ready;
	wire IBusCachedPlugin_iBusRsp_stages_0_output_valid;
	reg IBusCachedPlugin_iBusRsp_stages_1_halt;
	wire [31:0] IBusCachedPlugin_iBusRsp_stages_1_input_payload;
	wire IBusCachedPlugin_iBusRsp_stages_1_input_ready;
	wire IBusCachedPlugin_iBusRsp_stages_1_input_valid;
	wire [31:0] IBusCachedPlugin_iBusRsp_stages_1_output_payload;
	wire IBusCachedPlugin_iBusRsp_stages_1_output_ready;
	wire IBusCachedPlugin_iBusRsp_stages_1_output_valid;
	reg IBusCachedPlugin_incomingInstruction;
	wire IBusCachedPlugin_injector_decodeInput_payload_isRvc;
	wire [31:0] IBusCachedPlugin_injector_decodeInput_payload_pc;
	wire IBusCachedPlugin_injector_decodeInput_payload_rsp_error;
	wire [31:0] IBusCachedPlugin_injector_decodeInput_payload_rsp_inst;
	wire IBusCachedPlugin_injector_decodeInput_ready;
	wire IBusCachedPlugin_injector_decodeInput_valid;
	reg [31:0] IBusCachedPlugin_injector_formal_rawInDecode;
	reg IBusCachedPlugin_injector_nextPcCalc_valids_0;
	reg IBusCachedPlugin_injector_nextPcCalc_valids_1;
	reg IBusCachedPlugin_injector_nextPcCalc_valids_2;
	reg IBusCachedPlugin_injector_nextPcCalc_valids_3;
	reg IBusCachedPlugin_injector_nextPcCalc_valids_4;
	wire [31:0] IBusCachedPlugin_jump_pcLoad_payload;
	wire IBusCachedPlugin_jump_pcLoad_valid;
	wire IBusCachedPlugin_mmuBus_busy;
	wire IBusCachedPlugin_mmuBus_cmd_0_bypassTranslation;
	wire IBusCachedPlugin_mmuBus_cmd_0_isStuck;
	wire IBusCachedPlugin_mmuBus_cmd_0_isValid;
	wire [31:0] IBusCachedPlugin_mmuBus_cmd_0_virtualAddress;
	wire IBusCachedPlugin_mmuBus_end;
	reg IBusCachedPlugin_mmuBus_rsp_allowExecute;
	reg IBusCachedPlugin_mmuBus_rsp_allowRead;
	reg IBusCachedPlugin_mmuBus_rsp_allowWrite;
	wire IBusCachedPlugin_mmuBus_rsp_bypassTranslation;
	reg IBusCachedPlugin_mmuBus_rsp_exception;
	wire IBusCachedPlugin_mmuBus_rsp_isIoAccess;
	reg IBusCachedPlugin_mmuBus_rsp_isPaging;
	reg [31:0] IBusCachedPlugin_mmuBus_rsp_physicalAddress;
	reg IBusCachedPlugin_mmuBus_rsp_refilling;
	wire [31:0] IBusCachedPlugin_mmuBus_rsp_ways_0_physical;
	wire IBusCachedPlugin_mmuBus_rsp_ways_0_sel;
	wire [31:0] IBusCachedPlugin_mmuBus_rsp_ways_1_physical;
	wire IBusCachedPlugin_mmuBus_rsp_ways_1_sel;
	wire [31:0] IBusCachedPlugin_mmuBus_rsp_ways_2_physical;
	wire IBusCachedPlugin_mmuBus_rsp_ways_2_sel;
	wire [31:0] IBusCachedPlugin_mmuBus_rsp_ways_3_physical;
	wire IBusCachedPlugin_mmuBus_rsp_ways_3_sel;
	wire IBusCachedPlugin_pcValids_0;
	wire IBusCachedPlugin_pcValids_1;
	wire IBusCachedPlugin_pcValids_2;
	wire IBusCachedPlugin_pcValids_3;
	wire [31:0] IBusCachedPlugin_predictionJumpInterface_payload;
	wire IBusCachedPlugin_predictionJumpInterface_valid;
	reg [31:0] IBusCachedPlugin_rspCounter;
	wire IBusCachedPlugin_rsp_iBusRspOutputHalt;
	wire IBusCachedPlugin_rsp_issueDetected;
	reg IBusCachedPlugin_rsp_issueDetected_1;
	reg IBusCachedPlugin_rsp_issueDetected_2;
	reg IBusCachedPlugin_rsp_issueDetected_3;
	reg IBusCachedPlugin_rsp_issueDetected_4;
	reg IBusCachedPlugin_rsp_redoFetch;
	wire IBusCachedPlugin_s0_tightlyCoupledHit;
	reg IBusCachedPlugin_s1_tightlyCoupledHit;
	wire MmuPlugin_dBusAccess_cmd_fire;
	reg [31:0] MmuPlugin_dBusAccess_cmd_payload_address;
	wire [31:0] MmuPlugin_dBusAccess_cmd_payload_data;
	wire [1:0] MmuPlugin_dBusAccess_cmd_payload_size;
	wire MmuPlugin_dBusAccess_cmd_payload_write;
	wire [3:0] MmuPlugin_dBusAccess_cmd_payload_writeMask;
	reg MmuPlugin_dBusAccess_cmd_ready;
	reg MmuPlugin_dBusAccess_cmd_valid;
	wire [31:0] MmuPlugin_dBusAccess_rsp_payload_data;
	wire MmuPlugin_dBusAccess_rsp_payload_error;
	wire MmuPlugin_dBusAccess_rsp_payload_redo;
	wire MmuPlugin_dBusAccess_rsp_valid;
	wire MmuPlugin_ports_0_cacheHit;
	wire [3:0] MmuPlugin_ports_0_cacheHitsCalc;
	wire MmuPlugin_ports_0_cacheLine_allowExecute;
	wire MmuPlugin_ports_0_cacheLine_allowRead;
	wire MmuPlugin_ports_0_cacheLine_allowUser;
	wire MmuPlugin_ports_0_cacheLine_allowWrite;
	wire MmuPlugin_ports_0_cacheLine_exception;
	wire [9:0] MmuPlugin_ports_0_cacheLine_physicalAddress_0;
	wire [9:0] MmuPlugin_ports_0_cacheLine_physicalAddress_1;
	wire MmuPlugin_ports_0_cacheLine_superPage;
	wire MmuPlugin_ports_0_cacheLine_valid;
	wire [9:0] MmuPlugin_ports_0_cacheLine_virtualAddress_0;
	wire [9:0] MmuPlugin_ports_0_cacheLine_virtualAddress_1;
	reg MmuPlugin_ports_0_cache_0_allowExecute;
	reg MmuPlugin_ports_0_cache_0_allowRead;
	reg MmuPlugin_ports_0_cache_0_allowUser;
	reg MmuPlugin_ports_0_cache_0_allowWrite;
	reg MmuPlugin_ports_0_cache_0_exception;
	reg [9:0] MmuPlugin_ports_0_cache_0_physicalAddress_0;
	reg [9:0] MmuPlugin_ports_0_cache_0_physicalAddress_1;
	reg MmuPlugin_ports_0_cache_0_superPage;
	reg MmuPlugin_ports_0_cache_0_valid;
	reg [9:0] MmuPlugin_ports_0_cache_0_virtualAddress_0;
	reg [9:0] MmuPlugin_ports_0_cache_0_virtualAddress_1;
	reg MmuPlugin_ports_0_cache_1_allowExecute;
	reg MmuPlugin_ports_0_cache_1_allowRead;
	reg MmuPlugin_ports_0_cache_1_allowUser;
	reg MmuPlugin_ports_0_cache_1_allowWrite;
	reg MmuPlugin_ports_0_cache_1_exception;
	reg [9:0] MmuPlugin_ports_0_cache_1_physicalAddress_0;
	reg [9:0] MmuPlugin_ports_0_cache_1_physicalAddress_1;
	reg MmuPlugin_ports_0_cache_1_superPage;
	reg MmuPlugin_ports_0_cache_1_valid;
	reg [9:0] MmuPlugin_ports_0_cache_1_virtualAddress_0;
	reg [9:0] MmuPlugin_ports_0_cache_1_virtualAddress_1;
	reg MmuPlugin_ports_0_cache_2_allowExecute;
	reg MmuPlugin_ports_0_cache_2_allowRead;
	reg MmuPlugin_ports_0_cache_2_allowUser;
	reg MmuPlugin_ports_0_cache_2_allowWrite;
	reg MmuPlugin_ports_0_cache_2_exception;
	reg [9:0] MmuPlugin_ports_0_cache_2_physicalAddress_0;
	reg [9:0] MmuPlugin_ports_0_cache_2_physicalAddress_1;
	reg MmuPlugin_ports_0_cache_2_superPage;
	reg MmuPlugin_ports_0_cache_2_valid;
	reg [9:0] MmuPlugin_ports_0_cache_2_virtualAddress_0;
	reg [9:0] MmuPlugin_ports_0_cache_2_virtualAddress_1;
	reg MmuPlugin_ports_0_cache_3_allowExecute;
	reg MmuPlugin_ports_0_cache_3_allowRead;
	reg MmuPlugin_ports_0_cache_3_allowUser;
	reg MmuPlugin_ports_0_cache_3_allowWrite;
	reg MmuPlugin_ports_0_cache_3_exception;
	reg [9:0] MmuPlugin_ports_0_cache_3_physicalAddress_0;
	reg [9:0] MmuPlugin_ports_0_cache_3_physicalAddress_1;
	reg MmuPlugin_ports_0_cache_3_superPage;
	reg MmuPlugin_ports_0_cache_3_valid;
	reg [9:0] MmuPlugin_ports_0_cache_3_virtualAddress_0;
	reg [9:0] MmuPlugin_ports_0_cache_3_virtualAddress_1;
	wire MmuPlugin_ports_0_dirty;
	reg [1:0] MmuPlugin_ports_0_entryToReplace_value;
	reg [1:0] MmuPlugin_ports_0_entryToReplace_valueNext;
	wire MmuPlugin_ports_0_entryToReplace_willClear;
	reg MmuPlugin_ports_0_entryToReplace_willIncrement;
	wire MmuPlugin_ports_0_entryToReplace_willOverflow;
	wire MmuPlugin_ports_0_entryToReplace_willOverflowIfInc;
	reg MmuPlugin_ports_0_requireMmuLockupCalc;
	wire MmuPlugin_ports_1_cacheHit;
	wire [3:0] MmuPlugin_ports_1_cacheHitsCalc;
	wire MmuPlugin_ports_1_cacheLine_allowExecute;
	wire MmuPlugin_ports_1_cacheLine_allowRead;
	wire MmuPlugin_ports_1_cacheLine_allowUser;
	wire MmuPlugin_ports_1_cacheLine_allowWrite;
	wire MmuPlugin_ports_1_cacheLine_exception;
	wire [9:0] MmuPlugin_ports_1_cacheLine_physicalAddress_0;
	wire [9:0] MmuPlugin_ports_1_cacheLine_physicalAddress_1;
	wire MmuPlugin_ports_1_cacheLine_superPage;
	wire MmuPlugin_ports_1_cacheLine_valid;
	wire [9:0] MmuPlugin_ports_1_cacheLine_virtualAddress_0;
	wire [9:0] MmuPlugin_ports_1_cacheLine_virtualAddress_1;
	reg MmuPlugin_ports_1_cache_0_allowExecute;
	reg MmuPlugin_ports_1_cache_0_allowRead;
	reg MmuPlugin_ports_1_cache_0_allowUser;
	reg MmuPlugin_ports_1_cache_0_allowWrite;
	reg MmuPlugin_ports_1_cache_0_exception;
	reg [9:0] MmuPlugin_ports_1_cache_0_physicalAddress_0;
	reg [9:0] MmuPlugin_ports_1_cache_0_physicalAddress_1;
	reg MmuPlugin_ports_1_cache_0_superPage;
	reg MmuPlugin_ports_1_cache_0_valid;
	reg [9:0] MmuPlugin_ports_1_cache_0_virtualAddress_0;
	reg [9:0] MmuPlugin_ports_1_cache_0_virtualAddress_1;
	reg MmuPlugin_ports_1_cache_1_allowExecute;
	reg MmuPlugin_ports_1_cache_1_allowRead;
	reg MmuPlugin_ports_1_cache_1_allowUser;
	reg MmuPlugin_ports_1_cache_1_allowWrite;
	reg MmuPlugin_ports_1_cache_1_exception;
	reg [9:0] MmuPlugin_ports_1_cache_1_physicalAddress_0;
	reg [9:0] MmuPlugin_ports_1_cache_1_physicalAddress_1;
	reg MmuPlugin_ports_1_cache_1_superPage;
	reg MmuPlugin_ports_1_cache_1_valid;
	reg [9:0] MmuPlugin_ports_1_cache_1_virtualAddress_0;
	reg [9:0] MmuPlugin_ports_1_cache_1_virtualAddress_1;
	reg MmuPlugin_ports_1_cache_2_allowExecute;
	reg MmuPlugin_ports_1_cache_2_allowRead;
	reg MmuPlugin_ports_1_cache_2_allowUser;
	reg MmuPlugin_ports_1_cache_2_allowWrite;
	reg MmuPlugin_ports_1_cache_2_exception;
	reg [9:0] MmuPlugin_ports_1_cache_2_physicalAddress_0;
	reg [9:0] MmuPlugin_ports_1_cache_2_physicalAddress_1;
	reg MmuPlugin_ports_1_cache_2_superPage;
	reg MmuPlugin_ports_1_cache_2_valid;
	reg [9:0] MmuPlugin_ports_1_cache_2_virtualAddress_0;
	reg [9:0] MmuPlugin_ports_1_cache_2_virtualAddress_1;
	reg MmuPlugin_ports_1_cache_3_allowExecute;
	reg MmuPlugin_ports_1_cache_3_allowRead;
	reg MmuPlugin_ports_1_cache_3_allowUser;
	reg MmuPlugin_ports_1_cache_3_allowWrite;
	reg MmuPlugin_ports_1_cache_3_exception;
	reg [9:0] MmuPlugin_ports_1_cache_3_physicalAddress_0;
	reg [9:0] MmuPlugin_ports_1_cache_3_physicalAddress_1;
	reg MmuPlugin_ports_1_cache_3_superPage;
	reg MmuPlugin_ports_1_cache_3_valid;
	reg [9:0] MmuPlugin_ports_1_cache_3_virtualAddress_0;
	reg [9:0] MmuPlugin_ports_1_cache_3_virtualAddress_1;
	wire MmuPlugin_ports_1_dirty;
	reg [1:0] MmuPlugin_ports_1_entryToReplace_value;
	reg [1:0] MmuPlugin_ports_1_entryToReplace_valueNext;
	wire MmuPlugin_ports_1_entryToReplace_willClear;
	reg MmuPlugin_ports_1_entryToReplace_willIncrement;
	wire MmuPlugin_ports_1_entryToReplace_willOverflow;
	wire MmuPlugin_ports_1_entryToReplace_willOverflowIfInc;
	reg MmuPlugin_ports_1_requireMmuLockupCalc;
	reg [8:0] MmuPlugin_satp_asid;
	reg MmuPlugin_satp_mode;
	reg [21:0] MmuPlugin_satp_ppn;
	reg [31:0] MmuPlugin_shared_dBusRspStaged_payload_data;
	reg MmuPlugin_shared_dBusRspStaged_payload_error;
	reg MmuPlugin_shared_dBusRspStaged_payload_redo;
	reg MmuPlugin_shared_dBusRspStaged_valid;
	wire MmuPlugin_shared_dBusRsp_exception;
	wire MmuPlugin_shared_dBusRsp_leaf;
	wire MmuPlugin_shared_dBusRsp_pte_A;
	wire MmuPlugin_shared_dBusRsp_pte_D;
	wire MmuPlugin_shared_dBusRsp_pte_G;
	wire [9:0] MmuPlugin_shared_dBusRsp_pte_PPN0;
	wire [11:0] MmuPlugin_shared_dBusRsp_pte_PPN1;
	wire MmuPlugin_shared_dBusRsp_pte_R;
	wire [1:0] MmuPlugin_shared_dBusRsp_pte_RSW;
	wire MmuPlugin_shared_dBusRsp_pte_U;
	wire MmuPlugin_shared_dBusRsp_pte_V;
	wire MmuPlugin_shared_dBusRsp_pte_W;
	wire MmuPlugin_shared_dBusRsp_pte_X;
	reg [1:0] MmuPlugin_shared_portSortedOh;
	reg MmuPlugin_shared_pteBuffer_A;
	reg MmuPlugin_shared_pteBuffer_D;
	reg MmuPlugin_shared_pteBuffer_G;
	reg [9:0] MmuPlugin_shared_pteBuffer_PPN0;
	reg [11:0] MmuPlugin_shared_pteBuffer_PPN1;
	reg MmuPlugin_shared_pteBuffer_R;
	reg [1:0] MmuPlugin_shared_pteBuffer_RSW;
	reg MmuPlugin_shared_pteBuffer_U;
	reg MmuPlugin_shared_pteBuffer_V;
	reg MmuPlugin_shared_pteBuffer_W;
	reg MmuPlugin_shared_pteBuffer_X;
	wire [1:0] MmuPlugin_shared_refills;
	reg [2:0] MmuPlugin_shared_state_1;
	reg [9:0] MmuPlugin_shared_vpn_0;
	reg [9:0] MmuPlugin_shared_vpn_1;
	reg MmuPlugin_status_mprv;
	reg MmuPlugin_status_mxr;
	reg MmuPlugin_status_sum;
	reg [31:0] RegFilePlugin_regFile [0:31];
	reg _zz_1;
	wire _zz_2;
	reg [10:0] _zz_3;
	wire _zz_4;
	reg [18:0] _zz_5;
	reg _zz_6;
	reg _zz_7;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_1;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_10;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_11;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_12;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_13;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_14;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_15;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_16;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_17;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_18;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_19;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_2;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_20;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_21;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_22;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_23;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_24;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_25;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_26;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_27;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_28;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_29;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_3;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_30;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_31;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_32;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_33;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_34;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_35;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_36;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_37;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_38;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_39;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_4;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_40;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_41;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_42;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_43;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_44;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_45;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_46;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_47;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_48;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_49;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_5;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_50;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_51;
	wire [31:0] _zz_CsrPlugin_csrMapping_readDataInit_52;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_6;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_7;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_8;
	reg [31:0] _zz_CsrPlugin_csrMapping_readDataInit_9;
	reg [31:0] _zz_CsrPlugin_csrMapping_writeDataSignal;
	wire [1:0] _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code;
	wire _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1;
	reg [1:0] _zz_CsrPlugin_privilege;
	wire [2:0] _zz_DBusCachedPlugin_exceptionBus_payload_code;
	wire [2:0] _zz_DBusCachedPlugin_exceptionBus_payload_code_1;
	wire [4:0] _zz_FpuPlugin_flags_NX;
	wire [4:0] _zz_FpuPlugin_flags_NX_1;
	wire [5:0] _zz_FpuPlugin_pendings;
	wire [5:0] _zz_FpuPlugin_pendings_1;
	wire [5:0] _zz_FpuPlugin_pendings_2;
	wire _zz_FpuPlugin_pendings_3;
	wire [5:0] _zz_FpuPlugin_pendings_4;
	wire _zz_FpuPlugin_pendings_5;
	wire [5:0] _zz_FpuPlugin_pendings_6;
	wire _zz_FpuPlugin_pendings_7;
	wire [2:0] _zz_FpuPlugin_port_cmd_payload_roundMode;
	wire [2:0] _zz_FpuPlugin_port_cmd_payload_roundMode_1;
	wire _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
	reg [18:0] _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1;
	wire [31:0] _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_2;
	wire [31:0] _zz_IBusCachedPlugin_fetchPc_pc;
	wire [2:0] _zz_IBusCachedPlugin_fetchPc_pc_1;
	wire _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready;
	wire _zz_IBusCachedPlugin_iBusRsp_stages_0_output_ready;
	wire _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready;
	wire _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid;
	reg _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid_1;
	reg _zz_IBusCachedPlugin_injector_decodeInput_payload_isRvc;
	reg [31:0] _zz_IBusCachedPlugin_injector_decodeInput_payload_pc;
	reg _zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_error;
	reg [31:0] _zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_inst;
	reg _zz_IBusCachedPlugin_injector_decodeInput_valid;
	wire [4:0] _zz_IBusCachedPlugin_jump_pcLoad_payload;
	wire [4:0] _zz_IBusCachedPlugin_jump_pcLoad_payload_1;
	wire _zz_IBusCachedPlugin_jump_pcLoad_payload_2;
	wire _zz_IBusCachedPlugin_jump_pcLoad_payload_3;
	wire _zz_IBusCachedPlugin_jump_pcLoad_payload_4;
	wire _zz_IBusCachedPlugin_jump_pcLoad_payload_5;
	reg [31:0] _zz_IBusCachedPlugin_jump_pcLoad_payload_6;
	wire [2:0] _zz_IBusCachedPlugin_jump_pcLoad_payload_7;
	wire _zz_IBusCachedPlugin_predictionJumpInterface_payload;
	reg [10:0] _zz_IBusCachedPlugin_predictionJumpInterface_payload_1;
	wire _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
	reg [18:0] _zz_IBusCachedPlugin_predictionJumpInterface_payload_3;
	wire _zz_IBusCachedPlugin_predictionJumpInterface_payload_4;
	wire _zz_IBusCachedPlugin_predictionJumpInterface_payload_5;
	wire _zz_IBusCachedPlugin_predictionJumpInterface_payload_6;
	wire [9:0] _zz_MmuPlugin_ports_0_cacheHitsCalc;
	wire [9:0] _zz_MmuPlugin_ports_0_cacheHitsCalc_1;
	wire _zz_MmuPlugin_ports_0_cacheHitsCalc_2;
	wire _zz_MmuPlugin_ports_0_cacheHitsCalc_3;
	wire _zz_MmuPlugin_ports_0_cacheHitsCalc_4;
	wire _zz_MmuPlugin_ports_0_cacheHitsCalc_5;
	reg _zz_MmuPlugin_ports_0_cacheLine_allowExecute;
	reg _zz_MmuPlugin_ports_0_cacheLine_allowRead;
	reg _zz_MmuPlugin_ports_0_cacheLine_allowUser;
	reg _zz_MmuPlugin_ports_0_cacheLine_allowWrite;
	reg _zz_MmuPlugin_ports_0_cacheLine_exception;
	reg [9:0] _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_0;
	reg [9:0] _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_1;
	reg _zz_MmuPlugin_ports_0_cacheLine_superPage;
	wire _zz_MmuPlugin_ports_0_cacheLine_valid;
	wire _zz_MmuPlugin_ports_0_cacheLine_valid_1;
	wire _zz_MmuPlugin_ports_0_cacheLine_valid_2;
	wire [1:0] _zz_MmuPlugin_ports_0_cacheLine_valid_3;
	reg _zz_MmuPlugin_ports_0_cacheLine_valid_4;
	reg [9:0] _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_0;
	reg [9:0] _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_1;
	wire [1:0] _zz_MmuPlugin_ports_0_entryToReplace_valueNext;
	wire _zz_MmuPlugin_ports_0_entryToReplace_valueNext_1;
	wire [9:0] _zz_MmuPlugin_ports_1_cacheHitsCalc;
	wire [9:0] _zz_MmuPlugin_ports_1_cacheHitsCalc_1;
	wire _zz_MmuPlugin_ports_1_cacheHitsCalc_2;
	wire _zz_MmuPlugin_ports_1_cacheHitsCalc_3;
	wire _zz_MmuPlugin_ports_1_cacheHitsCalc_4;
	wire _zz_MmuPlugin_ports_1_cacheHitsCalc_5;
	reg _zz_MmuPlugin_ports_1_cacheLine_allowExecute;
	reg _zz_MmuPlugin_ports_1_cacheLine_allowRead;
	reg _zz_MmuPlugin_ports_1_cacheLine_allowUser;
	reg _zz_MmuPlugin_ports_1_cacheLine_allowWrite;
	reg _zz_MmuPlugin_ports_1_cacheLine_exception;
	reg [9:0] _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_0;
	reg [9:0] _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_1;
	reg _zz_MmuPlugin_ports_1_cacheLine_superPage;
	wire _zz_MmuPlugin_ports_1_cacheLine_valid;
	wire _zz_MmuPlugin_ports_1_cacheLine_valid_1;
	wire _zz_MmuPlugin_ports_1_cacheLine_valid_2;
	wire [1:0] _zz_MmuPlugin_ports_1_cacheLine_valid_3;
	reg _zz_MmuPlugin_ports_1_cacheLine_valid_4;
	reg [9:0] _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_0;
	reg [9:0] _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_1;
	wire [1:0] _zz_MmuPlugin_ports_1_entryToReplace_valueNext;
	wire _zz_MmuPlugin_ports_1_entryToReplace_valueNext_1;
	wire [1:0] _zz_MmuPlugin_shared_refills;
	reg [1:0] _zz_MmuPlugin_shared_refills_1;
	wire [1:0] _zz_MmuPlugin_shared_refills_2;
	reg [1:0] _zz_MmuPlugin_shared_refills_3;
	wire [31:0] _zz_MmuPlugin_shared_vpn_0;
	wire _zz_RegFilePlugin_regFile_port;
	reg [31:0] _zz_RegFilePlugin_regFile_port0;
	reg [31:0] _zz_RegFilePlugin_regFile_port1;
	wire _zz_RegFilePlugin_regFile_port_1;
	wire [19:0] _zz__zz_2;
	wire [11:0] _zz__zz_4;
	wire [31:0] _zz__zz_6;
	wire [31:0] _zz__zz_6_1;
	wire [1:0] _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1;
	wire [1:0] _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1_1;
	wire [11:0] _zz__zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
	wire [4:0] _zz__zz_IBusCachedPlugin_jump_pcLoad_payload_1;
	wire [19:0] _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload;
	wire [11:0] _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
	wire [1:0] _zz__zz_MmuPlugin_shared_refills_2;
	wire [31:0] _zz__zz_decode_IS_CSR;
	wire _zz__zz_decode_IS_CSR_1;
	wire _zz__zz_decode_IS_CSR_10;
	wire _zz__zz_decode_IS_CSR_100;
	wire [31:0] _zz__zz_decode_IS_CSR_101;
	wire [31:0] _zz__zz_decode_IS_CSR_102;
	wire _zz__zz_decode_IS_CSR_103;
	wire [31:0] _zz__zz_decode_IS_CSR_104;
	wire [31:0] _zz__zz_decode_IS_CSR_105;
	wire _zz__zz_decode_IS_CSR_106;
	wire _zz__zz_decode_IS_CSR_107;
	wire _zz__zz_decode_IS_CSR_108;
	wire _zz__zz_decode_IS_CSR_109;
	wire _zz__zz_decode_IS_CSR_11;
	wire [2:0] _zz__zz_decode_IS_CSR_110;
	wire _zz__zz_decode_IS_CSR_111;
	wire [31:0] _zz__zz_decode_IS_CSR_112;
	wire _zz__zz_decode_IS_CSR_113;
	wire [31:0] _zz__zz_decode_IS_CSR_114;
	wire [31:0] _zz__zz_decode_IS_CSR_115;
	wire _zz__zz_decode_IS_CSR_116;
	wire [31:0] _zz__zz_decode_IS_CSR_117;
	wire [31:0] _zz__zz_decode_IS_CSR_118;
	wire [19:0] _zz__zz_decode_IS_CSR_119;
	wire _zz__zz_decode_IS_CSR_12;
	wire _zz__zz_decode_IS_CSR_120;
	wire _zz__zz_decode_IS_CSR_121;
	wire [31:0] _zz__zz_decode_IS_CSR_122;
	wire [31:0] _zz__zz_decode_IS_CSR_123;
	wire _zz__zz_decode_IS_CSR_124;
	wire [31:0] _zz__zz_decode_IS_CSR_125;
	wire [31:0] _zz__zz_decode_IS_CSR_126;
	wire _zz__zz_decode_IS_CSR_127;
	wire _zz__zz_decode_IS_CSR_128;
	wire [17:0] _zz__zz_decode_IS_CSR_129;
	wire _zz__zz_decode_IS_CSR_13;
	wire _zz__zz_decode_IS_CSR_130;
	wire _zz__zz_decode_IS_CSR_131;
	wire _zz__zz_decode_IS_CSR_132;
	wire [1:0] _zz__zz_decode_IS_CSR_133;
	wire [31:0] _zz__zz_decode_IS_CSR_134;
	wire [31:0] _zz__zz_decode_IS_CSR_135;
	wire [31:0] _zz__zz_decode_IS_CSR_136;
	wire [31:0] _zz__zz_decode_IS_CSR_137;
	wire [15:0] _zz__zz_decode_IS_CSR_138;
	wire _zz__zz_decode_IS_CSR_139;
	wire [38:0] _zz__zz_decode_IS_CSR_14;
	wire _zz__zz_decode_IS_CSR_140;
	wire _zz__zz_decode_IS_CSR_141;
	wire [31:0] _zz__zz_decode_IS_CSR_142;
	wire [3:0] _zz__zz_decode_IS_CSR_143;
	wire [31:0] _zz__zz_decode_IS_CSR_144;
	wire [31:0] _zz__zz_decode_IS_CSR_145;
	wire _zz__zz_decode_IS_CSR_146;
	wire [31:0] _zz__zz_decode_IS_CSR_147;
	wire _zz__zz_decode_IS_CSR_148;
	wire _zz__zz_decode_IS_CSR_149;
	wire _zz__zz_decode_IS_CSR_15;
	wire [31:0] _zz__zz_decode_IS_CSR_150;
	wire [31:0] _zz__zz_decode_IS_CSR_151;
	wire _zz__zz_decode_IS_CSR_152;
	wire [13:0] _zz__zz_decode_IS_CSR_153;
	wire [4:0] _zz__zz_decode_IS_CSR_154;
	wire _zz__zz_decode_IS_CSR_155;
	wire [31:0] _zz__zz_decode_IS_CSR_156;
	wire _zz__zz_decode_IS_CSR_157;
	wire [31:0] _zz__zz_decode_IS_CSR_158;
	wire [31:0] _zz__zz_decode_IS_CSR_159;
	wire _zz__zz_decode_IS_CSR_16;
	wire [1:0] _zz__zz_decode_IS_CSR_160;
	wire _zz__zz_decode_IS_CSR_161;
	wire [31:0] _zz__zz_decode_IS_CSR_162;
	wire _zz__zz_decode_IS_CSR_163;
	wire [31:0] _zz__zz_decode_IS_CSR_164;
	wire _zz__zz_decode_IS_CSR_165;
	wire _zz__zz_decode_IS_CSR_166;
	wire [31:0] _zz__zz_decode_IS_CSR_167;
	wire [31:0] _zz__zz_decode_IS_CSR_168;
	wire [2:0] _zz__zz_decode_IS_CSR_169;
	wire _zz__zz_decode_IS_CSR_17;
	wire _zz__zz_decode_IS_CSR_170;
	wire [31:0] _zz__zz_decode_IS_CSR_171;
	wire _zz__zz_decode_IS_CSR_172;
	wire [31:0] _zz__zz_decode_IS_CSR_173;
	wire [31:0] _zz__zz_decode_IS_CSR_174;
	wire _zz__zz_decode_IS_CSR_175;
	wire [31:0] _zz__zz_decode_IS_CSR_176;
	wire [31:0] _zz__zz_decode_IS_CSR_177;
	wire _zz__zz_decode_IS_CSR_178;
	wire _zz__zz_decode_IS_CSR_179;
	wire [31:0] _zz__zz_decode_IS_CSR_18;
	wire [5:0] _zz__zz_decode_IS_CSR_180;
	wire _zz__zz_decode_IS_CSR_181;
	wire [31:0] _zz__zz_decode_IS_CSR_182;
	wire _zz__zz_decode_IS_CSR_183;
	wire [31:0] _zz__zz_decode_IS_CSR_184;
	wire [31:0] _zz__zz_decode_IS_CSR_185;
	wire [3:0] _zz__zz_decode_IS_CSR_186;
	wire _zz__zz_decode_IS_CSR_187;
	wire [31:0] _zz__zz_decode_IS_CSR_188;
	wire _zz__zz_decode_IS_CSR_189;
	wire [35:0] _zz__zz_decode_IS_CSR_19;
	wire [1:0] _zz__zz_decode_IS_CSR_190;
	wire _zz__zz_decode_IS_CSR_191;
	wire _zz__zz_decode_IS_CSR_192;
	wire [10:0] _zz__zz_decode_IS_CSR_193;
	wire [3:0] _zz__zz_decode_IS_CSR_194;
	wire _zz__zz_decode_IS_CSR_195;
	wire [1:0] _zz__zz_decode_IS_CSR_196;
	wire _zz__zz_decode_IS_CSR_197;
	wire [31:0] _zz__zz_decode_IS_CSR_198;
	wire _zz__zz_decode_IS_CSR_199;
	wire _zz__zz_decode_IS_CSR_2;
	wire [31:0] _zz__zz_decode_IS_CSR_20;
	wire _zz__zz_decode_IS_CSR_200;
	wire [1:0] _zz__zz_decode_IS_CSR_201;
	wire _zz__zz_decode_IS_CSR_202;
	wire [31:0] _zz__zz_decode_IS_CSR_203;
	wire _zz__zz_decode_IS_CSR_204;
	wire _zz__zz_decode_IS_CSR_205;
	wire [31:0] _zz__zz_decode_IS_CSR_206;
	wire [31:0] _zz__zz_decode_IS_CSR_207;
	wire [7:0] _zz__zz_decode_IS_CSR_208;
	wire _zz__zz_decode_IS_CSR_209;
	wire [31:0] _zz__zz_decode_IS_CSR_21;
	wire _zz__zz_decode_IS_CSR_210;
	wire [31:0] _zz__zz_decode_IS_CSR_211;
	wire _zz__zz_decode_IS_CSR_212;
	wire [6:0] _zz__zz_decode_IS_CSR_213;
	wire _zz__zz_decode_IS_CSR_214;
	wire _zz__zz_decode_IS_CSR_215;
	wire [31:0] _zz__zz_decode_IS_CSR_216;
	wire [4:0] _zz__zz_decode_IS_CSR_217;
	wire [31:0] _zz__zz_decode_IS_CSR_218;
	wire [31:0] _zz__zz_decode_IS_CSR_219;
	wire _zz__zz_decode_IS_CSR_22;
	wire _zz__zz_decode_IS_CSR_220;
	wire [31:0] _zz__zz_decode_IS_CSR_221;
	wire [1:0] _zz__zz_decode_IS_CSR_222;
	wire [31:0] _zz__zz_decode_IS_CSR_223;
	wire [31:0] _zz__zz_decode_IS_CSR_224;
	wire [31:0] _zz__zz_decode_IS_CSR_225;
	wire [31:0] _zz__zz_decode_IS_CSR_226;
	wire [5:0] _zz__zz_decode_IS_CSR_227;
	wire _zz__zz_decode_IS_CSR_228;
	wire _zz__zz_decode_IS_CSR_229;
	wire [1:0] _zz__zz_decode_IS_CSR_23;
	wire [2:0] _zz__zz_decode_IS_CSR_230;
	wire [31:0] _zz__zz_decode_IS_CSR_231;
	wire [31:0] _zz__zz_decode_IS_CSR_232;
	wire _zz__zz_decode_IS_CSR_233;
	wire _zz__zz_decode_IS_CSR_234;
	wire [3:0] _zz__zz_decode_IS_CSR_235;
	wire _zz__zz_decode_IS_CSR_236;
	wire _zz__zz_decode_IS_CSR_237;
	wire _zz__zz_decode_IS_CSR_238;
	wire [31:0] _zz__zz_decode_IS_CSR_239;
	wire [31:0] _zz__zz_decode_IS_CSR_24;
	wire _zz__zz_decode_IS_CSR_240;
	wire _zz__zz_decode_IS_CSR_241;
	wire _zz__zz_decode_IS_CSR_242;
	wire [1:0] _zz__zz_decode_IS_CSR_243;
	wire [1:0] _zz__zz_decode_IS_CSR_244;
	wire _zz__zz_decode_IS_CSR_245;
	wire [31:0] _zz__zz_decode_IS_CSR_25;
	wire _zz__zz_decode_IS_CSR_26;
	wire [31:0] _zz__zz_decode_IS_CSR_27;
	wire _zz__zz_decode_IS_CSR_28;
	wire [31:0] _zz__zz_decode_IS_CSR_29;
	wire _zz__zz_decode_IS_CSR_3;
	wire [31:0] _zz__zz_decode_IS_CSR_30;
	wire [30:0] _zz__zz_decode_IS_CSR_31;
	wire _zz__zz_decode_IS_CSR_32;
	wire [1:0] _zz__zz_decode_IS_CSR_33;
	wire [31:0] _zz__zz_decode_IS_CSR_34;
	wire [31:0] _zz__zz_decode_IS_CSR_35;
	wire _zz__zz_decode_IS_CSR_36;
	wire [31:0] _zz__zz_decode_IS_CSR_37;
	wire [31:0] _zz__zz_decode_IS_CSR_38;
	wire _zz__zz_decode_IS_CSR_39;
	wire [31:0] _zz__zz_decode_IS_CSR_4;
	wire _zz__zz_decode_IS_CSR_40;
	wire [31:0] _zz__zz_decode_IS_CSR_41;
	wire [1:0] _zz__zz_decode_IS_CSR_42;
	wire [31:0] _zz__zz_decode_IS_CSR_43;
	wire [31:0] _zz__zz_decode_IS_CSR_44;
	wire [31:0] _zz__zz_decode_IS_CSR_45;
	wire [31:0] _zz__zz_decode_IS_CSR_46;
	wire [26:0] _zz__zz_decode_IS_CSR_47;
	wire _zz__zz_decode_IS_CSR_48;
	wire [31:0] _zz__zz_decode_IS_CSR_49;
	wire [1:0] _zz__zz_decode_IS_CSR_5;
	wire [4:0] _zz__zz_decode_IS_CSR_50;
	wire [31:0] _zz__zz_decode_IS_CSR_51;
	wire [31:0] _zz__zz_decode_IS_CSR_52;
	wire _zz__zz_decode_IS_CSR_53;
	wire [31:0] _zz__zz_decode_IS_CSR_54;
	wire _zz__zz_decode_IS_CSR_55;
	wire [31:0] _zz__zz_decode_IS_CSR_56;
	wire [31:0] _zz__zz_decode_IS_CSR_57;
	wire [1:0] _zz__zz_decode_IS_CSR_58;
	wire _zz__zz_decode_IS_CSR_59;
	wire [31:0] _zz__zz_decode_IS_CSR_6;
	wire [31:0] _zz__zz_decode_IS_CSR_60;
	wire _zz__zz_decode_IS_CSR_61;
	wire [31:0] _zz__zz_decode_IS_CSR_62;
	wire [3:0] _zz__zz_decode_IS_CSR_63;
	wire [31:0] _zz__zz_decode_IS_CSR_64;
	wire [31:0] _zz__zz_decode_IS_CSR_65;
	wire _zz__zz_decode_IS_CSR_66;
	wire [31:0] _zz__zz_decode_IS_CSR_67;
	wire _zz__zz_decode_IS_CSR_68;
	wire [31:0] _zz__zz_decode_IS_CSR_69;
	wire [31:0] _zz__zz_decode_IS_CSR_7;
	wire [31:0] _zz__zz_decode_IS_CSR_70;
	wire _zz__zz_decode_IS_CSR_71;
	wire _zz__zz_decode_IS_CSR_72;
	wire _zz__zz_decode_IS_CSR_73;
	wire [31:0] _zz__zz_decode_IS_CSR_74;
	wire _zz__zz_decode_IS_CSR_75;
	wire [31:0] _zz__zz_decode_IS_CSR_76;
	wire [31:0] _zz__zz_decode_IS_CSR_77;
	wire _zz__zz_decode_IS_CSR_78;
	wire [31:0] _zz__zz_decode_IS_CSR_79;
	wire [31:0] _zz__zz_decode_IS_CSR_8;
	wire [31:0] _zz__zz_decode_IS_CSR_80;
	wire _zz__zz_decode_IS_CSR_81;
	wire _zz__zz_decode_IS_CSR_82;
	wire [31:0] _zz__zz_decode_IS_CSR_83;
	wire [31:0] _zz__zz_decode_IS_CSR_84;
	wire [2:0] _zz__zz_decode_IS_CSR_85;
	wire _zz__zz_decode_IS_CSR_86;
	wire [31:0] _zz__zz_decode_IS_CSR_87;
	wire _zz__zz_decode_IS_CSR_88;
	wire [31:0] _zz__zz_decode_IS_CSR_89;
	wire [31:0] _zz__zz_decode_IS_CSR_9;
	wire [31:0] _zz__zz_decode_IS_CSR_90;
	wire _zz__zz_decode_IS_CSR_91;
	wire [31:0] _zz__zz_decode_IS_CSR_92;
	wire [31:0] _zz__zz_decode_IS_CSR_93;
	wire [22:0] _zz__zz_decode_IS_CSR_94;
	wire [4:0] _zz__zz_decode_IS_CSR_95;
	wire _zz__zz_decode_IS_CSR_96;
	wire [31:0] _zz__zz_decode_IS_CSR_97;
	wire [31:0] _zz__zz_decode_IS_CSR_98;
	wire [2:0] _zz__zz_decode_IS_CSR_99;
	wire [31:0] _zz__zz_decode_RS2_2;
	wire [31:0] _zz__zz_decode_RS2_2_1;
	wire [19:0] _zz__zz_execute_BranchPlugin_branch_src2_2;
	wire [11:0] _zz__zz_execute_BranchPlugin_branch_src2_4;
	wire [19:0] _zz__zz_execute_BranchPlugin_missAlignedTarget_2;
	wire [11:0] _zz__zz_execute_BranchPlugin_missAlignedTarget_4;
	wire [31:0] _zz__zz_execute_BranchPlugin_missAlignedTarget_6;
	wire [31:0] _zz__zz_execute_BranchPlugin_missAlignedTarget_6_1;
	wire [31:0] _zz__zz_execute_BranchPlugin_missAlignedTarget_6_2;
	wire _zz__zz_execute_REGFILE_WRITE_DATA;
	wire [2:0] _zz__zz_execute_SRC1;
	wire [4:0] _zz__zz_execute_SRC1_1;
	wire [11:0] _zz__zz_execute_SRC2_2;
	wire [1:0] _zz_decode_ALU_BITWISE_CTRL;
	wire [1:0] _zz_decode_ALU_BITWISE_CTRL_1;
	wire [1:0] _zz_decode_ALU_BITWISE_CTRL_2;
	wire [1:0] _zz_decode_ALU_CTRL;
	wire [1:0] _zz_decode_ALU_CTRL_1;
	wire [1:0] _zz_decode_ALU_CTRL_2;
	wire [1:0] _zz_decode_BRANCH_CTRL;
	wire [1:0] _zz_decode_BRANCH_CTRL_1;
	wire [1:0] _zz_decode_BRANCH_CTRL_2;
	wire [2:0] _zz_decode_ENV_CTRL;
	wire [2:0] _zz_decode_ENV_CTRL_1;
	wire [2:0] _zz_decode_ENV_CTRL_2;
	wire _zz_decode_FPU_ENABLE;
	wire _zz_decode_FPU_FORKED;
	wire _zz_decode_FPU_FORMAT;
	wire _zz_decode_FPU_FORMAT_1;
	wire _zz_decode_FPU_FORMAT_2;
	wire [3:0] _zz_decode_FPU_OPCODE;
	wire [3:0] _zz_decode_FPU_OPCODE_1;
	wire [3:0] _zz_decode_FPU_OPCODE_2;
	wire [44:0] _zz_decode_IS_CSR;
	wire _zz_decode_IS_CSR_1;
	wire _zz_decode_IS_CSR_10;
	wire _zz_decode_IS_CSR_11;
	wire _zz_decode_IS_CSR_12;
	wire _zz_decode_IS_CSR_13;
	wire _zz_decode_IS_CSR_14;
	wire _zz_decode_IS_CSR_2;
	wire _zz_decode_IS_CSR_3;
	wire _zz_decode_IS_CSR_4;
	wire _zz_decode_IS_CSR_5;
	wire _zz_decode_IS_CSR_6;
	wire _zz_decode_IS_CSR_7;
	wire _zz_decode_IS_CSR_8;
	wire _zz_decode_IS_CSR_9;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_1;
	wire _zz_decode_LEGAL_INSTRUCTION_10;
	wire [19:0] _zz_decode_LEGAL_INSTRUCTION_11;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_12;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_13;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_14;
	wire _zz_decode_LEGAL_INSTRUCTION_15;
	wire _zz_decode_LEGAL_INSTRUCTION_16;
	wire [13:0] _zz_decode_LEGAL_INSTRUCTION_17;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_18;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_19;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_2;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_20;
	wire _zz_decode_LEGAL_INSTRUCTION_21;
	wire _zz_decode_LEGAL_INSTRUCTION_22;
	wire [7:0] _zz_decode_LEGAL_INSTRUCTION_23;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_24;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_25;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_26;
	wire _zz_decode_LEGAL_INSTRUCTION_27;
	wire _zz_decode_LEGAL_INSTRUCTION_28;
	wire [1:0] _zz_decode_LEGAL_INSTRUCTION_29;
	wire _zz_decode_LEGAL_INSTRUCTION_3;
	wire _zz_decode_LEGAL_INSTRUCTION_4;
	wire [25:0] _zz_decode_LEGAL_INSTRUCTION_5;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_6;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_7;
	wire [31:0] _zz_decode_LEGAL_INSTRUCTION_8;
	wire _zz_decode_LEGAL_INSTRUCTION_9;
	reg [31:0] _zz_decode_RS2;
	reg [31:0] _zz_decode_RS2_1;
	reg [31:0] _zz_decode_RS2_2;
	reg [31:0] _zz_decode_RS2_3;
	wire _zz_decode_RegFilePlugin_rs1Data;
	wire _zz_decode_RegFilePlugin_rs2Data;
	wire [1:0] _zz_decode_SHIFT_CTRL;
	wire [1:0] _zz_decode_SHIFT_CTRL_1;
	wire [1:0] _zz_decode_SHIFT_CTRL_2;
	wire [1:0] _zz_decode_SRC1_CTRL;
	wire [1:0] _zz_decode_SRC1_CTRL_1;
	wire [1:0] _zz_decode_SRC1_CTRL_2;
	wire [1:0] _zz_decode_SRC2_CTRL;
	wire [1:0] _zz_decode_SRC2_CTRL_1;
	wire [1:0] _zz_decode_SRC2_CTRL_2;
	wire [1:0] _zz_decode_to_execute_ALU_BITWISE_CTRL;
	wire [1:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
	wire [1:0] _zz_decode_to_execute_ALU_CTRL;
	wire [1:0] _zz_decode_to_execute_ALU_CTRL_1;
	wire [1:0] _zz_decode_to_execute_BRANCH_CTRL;
	wire [1:0] _zz_decode_to_execute_BRANCH_CTRL_1;
	wire [2:0] _zz_decode_to_execute_ENV_CTRL;
	wire [2:0] _zz_decode_to_execute_ENV_CTRL_1;
	reg [31:0] _zz_decode_to_execute_FORMAL_PC_NEXT;
	reg _zz_decode_to_execute_FPU_FORKED;
	wire [3:0] _zz_decode_to_execute_FPU_OPCODE;
	wire [3:0] _zz_decode_to_execute_FPU_OPCODE_1;
	wire [1:0] _zz_decode_to_execute_SHIFT_CTRL;
	wire [1:0] _zz_decode_to_execute_SHIFT_CTRL_1;
	wire [1:0] _zz_decode_to_execute_SRC1_CTRL;
	wire [1:0] _zz_decode_to_execute_SRC1_CTRL_1;
	wire [1:0] _zz_decode_to_execute_SRC2_CTRL;
	wire [1:0] _zz_decode_to_execute_SRC2_CTRL_1;
	wire [1:0] _zz_execute_ALU_BITWISE_CTRL;
	wire [1:0] _zz_execute_ALU_CTRL;
	reg _zz_execute_BRANCH_COND_RESULT;
	reg _zz_execute_BRANCH_COND_RESULT_1;
	wire [1:0] _zz_execute_BRANCH_CTRL;
	wire _zz_execute_BranchPlugin_branch_src2;
	reg [19:0] _zz_execute_BranchPlugin_branch_src2_1;
	wire _zz_execute_BranchPlugin_branch_src2_2;
	reg [10:0] _zz_execute_BranchPlugin_branch_src2_3;
	wire _zz_execute_BranchPlugin_branch_src2_4;
	reg [18:0] _zz_execute_BranchPlugin_branch_src2_5;
	wire _zz_execute_BranchPlugin_branch_src2_6;
	wire _zz_execute_BranchPlugin_branch_src2_7;
	wire _zz_execute_BranchPlugin_branch_src2_8;
	wire [2:0] _zz_execute_BranchPlugin_branch_src2_9;
	wire _zz_execute_BranchPlugin_missAlignedTarget;
	reg [19:0] _zz_execute_BranchPlugin_missAlignedTarget_1;
	wire _zz_execute_BranchPlugin_missAlignedTarget_2;
	reg [10:0] _zz_execute_BranchPlugin_missAlignedTarget_3;
	wire _zz_execute_BranchPlugin_missAlignedTarget_4;
	reg [18:0] _zz_execute_BranchPlugin_missAlignedTarget_5;
	reg _zz_execute_BranchPlugin_missAlignedTarget_6;
	wire [2:0] _zz_execute_ENV_CTRL;
	wire [3:0] _zz_execute_FPU_OPCODE;
	reg [31:0] _zz_execute_FullBarrelShifterPlugin_reversed;
	reg [31:0] _zz_execute_MEMORY_STORE_DATA_RF;
	reg [31:0] _zz_execute_REGFILE_WRITE_DATA;
	wire [1:0] _zz_execute_SHIFT_CTRL;
	wire [31:0] _zz_execute_SHIFT_RIGHT;
	wire [32:0] _zz_execute_SHIFT_RIGHT_1;
	wire [32:0] _zz_execute_SHIFT_RIGHT_2;
	reg [31:0] _zz_execute_SRC1;
	wire [1:0] _zz_execute_SRC1_CTRL;
	wire _zz_execute_SRC2;
	reg [19:0] _zz_execute_SRC2_1;
	wire _zz_execute_SRC2_2;
	reg [19:0] _zz_execute_SRC2_3;
	reg [31:0] _zz_execute_SRC2_4;
	wire [1:0] _zz_execute_SRC2_CTRL;
	wire [31:0] _zz_execute_SrcPlugin_addSub;
	wire [31:0] _zz_execute_SrcPlugin_addSub_1;
	wire [31:0] _zz_execute_SrcPlugin_addSub_2;
	wire [31:0] _zz_execute_SrcPlugin_addSub_3;
	wire [31:0] _zz_execute_SrcPlugin_addSub_4;
	wire [31:0] _zz_execute_SrcPlugin_addSub_5;
	wire [31:0] _zz_execute_SrcPlugin_addSub_6;
	wire [2:0] _zz_execute_to_memory_ENV_CTRL;
	wire [2:0] _zz_execute_to_memory_ENV_CTRL_1;
	reg [31:0] _zz_execute_to_memory_FORMAL_PC_NEXT;
	reg _zz_execute_to_memory_FPU_FORKED;
	wire [3:0] _zz_execute_to_memory_FPU_OPCODE;
	wire [3:0] _zz_execute_to_memory_FPU_OPCODE_1;
	wire [31:0] _zz_execute_to_memory_PC;
	wire [31:0] _zz_execute_to_memory_RS1;
	wire [1:0] _zz_execute_to_memory_SHIFT_CTRL;
	wire [1:0] _zz_execute_to_memory_SHIFT_CTRL_1;
	wire [28:0] _zz_io_cpu_flush_payload_lineId;
	wire [28:0] _zz_io_cpu_flush_payload_lineId_1;
	wire [31:0] _zz_lastStageRegFileWrite_payload_address;
	wire _zz_lastStageRegFileWrite_valid;
	wire [5:0] _zz_memory_DivPlugin_div_counter_valueNext;
	wire _zz_memory_DivPlugin_div_counter_valueNext_1;
	wire [31:0] _zz_memory_DivPlugin_div_result;
	wire [32:0] _zz_memory_DivPlugin_div_result_1;
	wire [32:0] _zz_memory_DivPlugin_div_result_2;
	wire [32:0] _zz_memory_DivPlugin_div_result_3;
	wire [32:0] _zz_memory_DivPlugin_div_result_4;
	wire _zz_memory_DivPlugin_div_result_5;
	wire [32:0] _zz_memory_DivPlugin_div_stage_0_outNumerator;
	wire [31:0] _zz_memory_DivPlugin_div_stage_0_outRemainder;
	wire [31:0] _zz_memory_DivPlugin_div_stage_0_outRemainder_1;
	wire [32:0] _zz_memory_DivPlugin_div_stage_0_remainderMinusDenominator;
	wire [31:0] _zz_memory_DivPlugin_div_stage_0_remainderShifted;
	wire _zz_memory_DivPlugin_rs1;
	reg [32:0] _zz_memory_DivPlugin_rs1_1;
	wire [32:0] _zz_memory_DivPlugin_rs1_2;
	wire _zz_memory_DivPlugin_rs1_3;
	wire _zz_memory_DivPlugin_rs2;
	wire [31:0] _zz_memory_DivPlugin_rs2_1;
	wire _zz_memory_DivPlugin_rs2_2;
	wire [2:0] _zz_memory_ENV_CTRL;
	wire [3:0] _zz_memory_FPU_OPCODE;
	wire [51:0] _zz_memory_MUL_LOW;
	wire [51:0] _zz_memory_MUL_LOW_1;
	wire [51:0] _zz_memory_MUL_LOW_2;
	wire [51:0] _zz_memory_MUL_LOW_3;
	wire [32:0] _zz_memory_MUL_LOW_4;
	wire [51:0] _zz_memory_MUL_LOW_5;
	wire [49:0] _zz_memory_MUL_LOW_6;
	wire [51:0] _zz_memory_MUL_LOW_7;
	wire [49:0] _zz_memory_MUL_LOW_8;
	wire [1:0] _zz_memory_SHIFT_CTRL;
	wire [2:0] _zz_memory_to_writeBack_ENV_CTRL;
	wire [2:0] _zz_memory_to_writeBack_ENV_CTRL_1;
	reg [31:0] _zz_memory_to_writeBack_FORMAL_PC_NEXT;
	reg _zz_memory_to_writeBack_FPU_FORKED;
	wire [3:0] _zz_memory_to_writeBack_FPU_OPCODE;
	wire [3:0] _zz_memory_to_writeBack_FPU_OPCODE_1;
	wire _zz_when;
	wire _zz_when_CsrPlugin_l1302;
	wire _zz_when_CsrPlugin_l1302_1;
	wire _zz_when_CsrPlugin_l1302_2;
	wire _zz_when_CsrPlugin_l1302_3;
	wire _zz_when_CsrPlugin_l1302_4;
	wire _zz_when_CsrPlugin_l1302_5;
	reg _zz_when_FpuPlugin_l237;
	reg _zz_when_FpuPlugin_l237_1;
	reg _zz_when_FpuPlugin_l237_2;
	wire _zz_writeBack_DBusCachedPlugin_rspFormated;
	reg [31:0] _zz_writeBack_DBusCachedPlugin_rspFormated_1;
	wire _zz_writeBack_DBusCachedPlugin_rspFormated_2;
	reg [31:0] _zz_writeBack_DBusCachedPlugin_rspFormated_3;
	reg [7:0] _zz_writeBack_DBusCachedPlugin_rspShifted;
	wire [2:0] _zz_writeBack_DBusCachedPlugin_rspShifted_1;
	reg [7:0] _zz_writeBack_DBusCachedPlugin_rspShifted_2;
	wire [1:0] _zz_writeBack_DBusCachedPlugin_rspShifted_3;
	reg [7:0] _zz_writeBack_DBusCachedPlugin_rspShifted_4;
	wire _zz_writeBack_DBusCachedPlugin_rspShifted_5;
	reg [7:0] _zz_writeBack_DBusCachedPlugin_rspShifted_6;
	wire _zz_writeBack_DBusCachedPlugin_rspShifted_7;
	wire [2:0] _zz_writeBack_ENV_CTRL;
	wire [3:0] _zz_writeBack_FPU_OPCODE;
	wire [63:0] _zz_writeBack_FpuPlugin_commit_payload_value;
	wire [3:0] _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode;
	wire [65:0] _zz_writeBack_MulPlugin_result;
	wire [65:0] _zz_writeBack_MulPlugin_result_1;
	wire contextSwitching;
	reg [63:0] dBus_rsp_regNext_payload_data;
	reg dBus_rsp_regNext_payload_error;
	reg dBus_rsp_regNext_payload_last;
	reg dBus_rsp_regNext_valid;
	reg [31:0] dataCache_1_io_cpu_execute_address;
	reg [1:0] dataCache_1_io_cpu_execute_args_size;
	reg dataCache_1_io_cpu_execute_args_wr;
	wire dataCache_1_io_cpu_execute_haltIt;
	reg dataCache_1_io_cpu_execute_isValid;
	wire dataCache_1_io_cpu_execute_refilling;
	wire [7:0] dataCache_1_io_cpu_flush_payload_lineId;
	wire dataCache_1_io_cpu_flush_payload_singleLine;
	wire dataCache_1_io_cpu_flush_ready;
	wire dataCache_1_io_cpu_flush_valid;
	wire [31:0] dataCache_1_io_cpu_memory_address;
	reg dataCache_1_io_cpu_memory_isValid;
	wire dataCache_1_io_cpu_memory_isWrite;
	reg dataCache_1_io_cpu_memory_mmuRsp_isIoAccess;
	wire dataCache_1_io_cpu_redo;
	wire dataCache_1_io_cpu_writeBack_accessError;
	wire [31:0] dataCache_1_io_cpu_writeBack_address;
	wire [63:0] dataCache_1_io_cpu_writeBack_data;
	wire dataCache_1_io_cpu_writeBack_exclusiveOk;
	wire [3:0] dataCache_1_io_cpu_writeBack_fence_FM;
	wire dataCache_1_io_cpu_writeBack_fence_PI;
	wire dataCache_1_io_cpu_writeBack_fence_PO;
	wire dataCache_1_io_cpu_writeBack_fence_PR;
	wire dataCache_1_io_cpu_writeBack_fence_PW;
	wire dataCache_1_io_cpu_writeBack_fence_SI;
	wire dataCache_1_io_cpu_writeBack_fence_SO;
	wire dataCache_1_io_cpu_writeBack_fence_SR;
	wire dataCache_1_io_cpu_writeBack_fence_SW;
	wire dataCache_1_io_cpu_writeBack_haltIt;
	wire dataCache_1_io_cpu_writeBack_isUser;
	reg dataCache_1_io_cpu_writeBack_isValid;
	wire dataCache_1_io_cpu_writeBack_isWrite;
	wire dataCache_1_io_cpu_writeBack_keepMemRspData;
	wire dataCache_1_io_cpu_writeBack_mmuException;
	reg [63:0] dataCache_1_io_cpu_writeBack_storeData;
	wire dataCache_1_io_cpu_writeBack_unalignedAccess;
	wire dataCache_1_io_cpu_writesPending;
	wire [31:0] dataCache_1_io_mem_cmd_payload_address;
	wire [63:0] dataCache_1_io_mem_cmd_payload_data;
	wire dataCache_1_io_mem_cmd_payload_last;
	wire [7:0] dataCache_1_io_mem_cmd_payload_mask;
	wire [1:0] dataCache_1_io_mem_cmd_payload_size;
	wire dataCache_1_io_mem_cmd_payload_uncached;
	wire dataCache_1_io_mem_cmd_payload_wr;
	wire dataCache_1_io_mem_cmd_ready;
	wire dataCache_1_io_mem_cmd_valid;
	wire [31:0] decodeExceptionPort_payload_badAddr;
	wire [3:0] decodeExceptionPort_payload_code;
	wire decodeExceptionPort_valid;
	wire [1:0] decode_ALU_BITWISE_CTRL;
	wire [1:0] decode_ALU_CTRL;
	wire [1:0] decode_BRANCH_CTRL;
	wire decode_BYPASSABLE_EXECUTE_STAGE;
	wire decode_BYPASSABLE_MEMORY_STAGE;
	wire decode_CSR_READ_OPCODE;
	wire decode_CSR_WRITE_OPCODE;
	wire [2:0] decode_ENV_CTRL;
	wire decode_FLUSH_ALL;
	wire [31:0] decode_FORMAL_PC_NEXT;
	wire [1:0] decode_FPU_ARG;
	wire decode_FPU_COMMIT;
	wire decode_FPU_COMMIT_LOAD;
	reg decode_FPU_ENABLE;
	wire decode_FPU_FORKED;
	wire decode_FPU_FORMAT;
	wire [3:0] decode_FPU_OPCODE;
	wire decode_FPU_RSP;
	reg decode_FpuPlugin_forked;
	wire decode_FpuPlugin_hazard;
	wire [2:0] decode_FpuPlugin_iRoundMode;
	wire [2:0] decode_FpuPlugin_roundMode;
	wire decode_FpuPlugin_trap;
	wire [31:0] decode_INSTRUCTION;
	wire [31:0] decode_INSTRUCTION_ANTICIPATED;
	wire decode_IS_CSR;
	wire decode_IS_DIV;
	wire decode_IS_MUL;
	wire decode_IS_RS1_SIGNED;
	wire decode_IS_RS2_SIGNED;
	wire decode_IS_SFENCE_VMA2;
	reg decode_LEGAL_INSTRUCTION;
	wire decode_MEMORY_ENABLE;
	wire decode_MEMORY_FORCE_CONSTISTENCY;
	wire decode_MEMORY_MANAGMENT;
	wire decode_MEMORY_WR;
	wire [31:0] decode_PC;
	wire decode_PREDICTION_HAD_BRANCHED2;
	reg decode_REGFILE_WRITE_VALID;
	wire decode_RESCHEDULE_NEXT;
	reg [31:0] decode_RS1;
	wire decode_RS1_USE;
	reg [31:0] decode_RS2;
	wire decode_RS2_USE;
	wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
	wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
	wire [31:0] decode_RegFilePlugin_rs1Data;
	wire [31:0] decode_RegFilePlugin_rs2Data;
	wire [1:0] decode_SHIFT_CTRL;
	wire [1:0] decode_SRC1_CTRL;
	wire [1:0] decode_SRC2_CTRL;
	wire decode_SRC2_FORCE_ZERO;
	wire decode_SRC_ADD_ZERO;
	wire decode_SRC_LESS_UNSIGNED;
	wire decode_SRC_USE_SUB_LESS;
	wire decode_arbitration_flushIt;
	reg decode_arbitration_flushNext;
	reg decode_arbitration_haltByOther;
	reg decode_arbitration_haltItself;
	wire decode_arbitration_isFiring;
	wire decode_arbitration_isFlushed;
	wire decode_arbitration_isMoving;
	wire decode_arbitration_isStuck;
	wire decode_arbitration_isStuckByOthers;
	reg decode_arbitration_isValid;
	reg decode_arbitration_removeIt;
	reg [1:0] decode_to_execute_ALU_BITWISE_CTRL;
	reg [1:0] decode_to_execute_ALU_CTRL;
	reg [1:0] decode_to_execute_BRANCH_CTRL;
	reg decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
	reg decode_to_execute_BYPASSABLE_MEMORY_STAGE;
	reg decode_to_execute_CSR_READ_OPCODE;
	reg decode_to_execute_CSR_WRITE_OPCODE;
	reg [2:0] decode_to_execute_ENV_CTRL;
	reg [31:0] decode_to_execute_FORMAL_PC_NEXT;
	reg decode_to_execute_FPU_COMMIT;
	reg decode_to_execute_FPU_COMMIT_LOAD;
	reg decode_to_execute_FPU_FORKED;
	reg [3:0] decode_to_execute_FPU_OPCODE;
	reg decode_to_execute_FPU_RSP;
	reg [31:0] decode_to_execute_INSTRUCTION;
	reg decode_to_execute_IS_CSR;
	reg decode_to_execute_IS_DIV;
	reg decode_to_execute_IS_MUL;
	reg decode_to_execute_IS_RS1_SIGNED;
	reg decode_to_execute_IS_RS2_SIGNED;
	reg decode_to_execute_IS_SFENCE_VMA2;
	reg decode_to_execute_MEMORY_ENABLE;
	reg decode_to_execute_MEMORY_FORCE_CONSTISTENCY;
	reg decode_to_execute_MEMORY_MANAGMENT;
	reg decode_to_execute_MEMORY_WR;
	reg [31:0] decode_to_execute_PC;
	reg decode_to_execute_PREDICTION_HAD_BRANCHED2;
	reg decode_to_execute_REGFILE_WRITE_VALID;
	reg decode_to_execute_RESCHEDULE_NEXT;
	reg [31:0] decode_to_execute_RS1;
	reg [31:0] decode_to_execute_RS2;
	reg [1:0] decode_to_execute_SHIFT_CTRL;
	reg [1:0] decode_to_execute_SRC1_CTRL;
	reg [1:0] decode_to_execute_SRC2_CTRL;
	reg decode_to_execute_SRC2_FORCE_ZERO;
	reg decode_to_execute_SRC_LESS_UNSIGNED;
	reg decode_to_execute_SRC_USE_SUB_LESS;
	wire [1:0] execute_ALU_BITWISE_CTRL;
	wire [1:0] execute_ALU_CTRL;
	wire [31:0] execute_BRANCH_CALC;
	wire execute_BRANCH_COND_RESULT;
	wire [1:0] execute_BRANCH_CTRL;
	wire execute_BRANCH_DO;
	wire execute_BYPASSABLE_EXECUTE_STAGE;
	wire execute_BYPASSABLE_MEMORY_STAGE;
	wire [31:0] execute_BranchPlugin_branchAdder;
	reg [31:0] execute_BranchPlugin_branch_src1;
	reg [31:0] execute_BranchPlugin_branch_src2;
	wire execute_BranchPlugin_eq;
	wire execute_BranchPlugin_missAlignedTarget;
	wire execute_CSR_READ_OPCODE;
	wire execute_CSR_WRITE_OPCODE;
	wire execute_CsrPlugin_blockedBySideEffects;
	wire [11:0] execute_CsrPlugin_csrAddress;
	reg execute_CsrPlugin_csr_1;
	reg execute_CsrPlugin_csr_2;
	reg execute_CsrPlugin_csr_256;
	reg execute_CsrPlugin_csr_260;
	reg execute_CsrPlugin_csr_261;
	reg execute_CsrPlugin_csr_262;
	reg execute_CsrPlugin_csr_2816;
	reg execute_CsrPlugin_csr_2818;
	reg execute_CsrPlugin_csr_2944;
	reg execute_CsrPlugin_csr_2946;
	reg execute_CsrPlugin_csr_3;
	reg execute_CsrPlugin_csr_3072;
	reg execute_CsrPlugin_csr_3074;
	reg execute_CsrPlugin_csr_320;
	reg execute_CsrPlugin_csr_3200;
	reg execute_CsrPlugin_csr_3202;
	reg execute_CsrPlugin_csr_321;
	reg execute_CsrPlugin_csr_322;
	reg execute_CsrPlugin_csr_323;
	reg execute_CsrPlugin_csr_324;
	reg execute_CsrPlugin_csr_384;
	reg execute_CsrPlugin_csr_3857;
	reg execute_CsrPlugin_csr_3858;
	reg execute_CsrPlugin_csr_3859;
	reg execute_CsrPlugin_csr_3860;
	reg execute_CsrPlugin_csr_768;
	reg execute_CsrPlugin_csr_769;
	reg execute_CsrPlugin_csr_770;
	reg execute_CsrPlugin_csr_771;
	reg execute_CsrPlugin_csr_772;
	reg execute_CsrPlugin_csr_773;
	reg execute_CsrPlugin_csr_774;
	reg execute_CsrPlugin_csr_832;
	reg execute_CsrPlugin_csr_833;
	reg execute_CsrPlugin_csr_834;
	reg execute_CsrPlugin_csr_835;
	reg execute_CsrPlugin_csr_836;
	reg execute_CsrPlugin_illegalAccess;
	reg execute_CsrPlugin_illegalInstruction;
	wire execute_CsrPlugin_readEnable;
	reg execute_CsrPlugin_readInstruction;
	reg [31:0] execute_CsrPlugin_readToWriteData;
	reg execute_CsrPlugin_wfiWake;
	wire execute_CsrPlugin_writeEnable;
	reg execute_CsrPlugin_writeInstruction;
	wire [1:0] execute_DBusCachedPlugin_size;
	wire [2:0] execute_ENV_CTRL;
	wire [31:0] execute_FORMAL_PC_NEXT;
	wire execute_FPU_COMMIT;
	wire execute_FPU_COMMIT_LOAD;
	wire execute_FPU_FORKED;
	wire [3:0] execute_FPU_OPCODE;
	wire execute_FPU_RSP;
	wire [4:0] execute_FullBarrelShifterPlugin_amplitude;
	wire [31:0] execute_FullBarrelShifterPlugin_reversed;
	wire [31:0] execute_INSTRUCTION;
	wire execute_IS_CSR;
	wire execute_IS_DBUS_SHARING;
	wire execute_IS_DIV;
	wire execute_IS_MUL;
	wire execute_IS_RS1_SIGNED;
	wire execute_IS_RS2_SIGNED;
	wire execute_IS_SFENCE_VMA2;
	reg [31:0] execute_IntAluPlugin_bitwise;
	wire execute_MEMORY_ENABLE;
	wire execute_MEMORY_FORCE_CONSTISTENCY;
	wire execute_MEMORY_MANAGMENT;
	wire [31:0] execute_MEMORY_STORE_DATA_RF;
	wire execute_MEMORY_WR;
	wire [33:0] execute_MUL_HH;
	wire [33:0] execute_MUL_HL;
	wire [33:0] execute_MUL_LH;
	wire [31:0] execute_MUL_LL;
	wire [31:0] execute_MulPlugin_a;
	wire [16:0] execute_MulPlugin_aHigh;
	wire [16:0] execute_MulPlugin_aSLow;
	reg execute_MulPlugin_aSigned;
	wire [15:0] execute_MulPlugin_aULow;
	wire [31:0] execute_MulPlugin_b;
	wire [16:0] execute_MulPlugin_bHigh;
	wire [16:0] execute_MulPlugin_bSLow;
	reg execute_MulPlugin_bSigned;
	wire [15:0] execute_MulPlugin_bULow;
	wire [31:0] execute_PC;
	wire execute_PREDICTION_HAD_BRANCHED2;
	wire [31:0] execute_REGFILE_WRITE_DATA;
	wire execute_REGFILE_WRITE_VALID;
	wire execute_RESCHEDULE_NEXT;
	wire [31:0] execute_RS1;
	wire [31:0] execute_RS2;
	wire [1:0] execute_SHIFT_CTRL;
	wire [31:0] execute_SHIFT_RIGHT;
	wire [31:0] execute_SRC1;
	wire [1:0] execute_SRC1_CTRL;
	wire [31:0] execute_SRC2;
	wire [1:0] execute_SRC2_CTRL;
	wire execute_SRC2_FORCE_ZERO;
	wire [31:0] execute_SRC_ADD;
	wire [31:0] execute_SRC_ADD_SUB;
	wire execute_SRC_LESS;
	wire execute_SRC_LESS_UNSIGNED;
	wire execute_SRC_USE_SUB_LESS;
	reg [31:0] execute_SrcPlugin_addSub;
	wire execute_SrcPlugin_less;
	wire execute_arbitration_flushIt;
	reg execute_arbitration_flushNext;
	reg execute_arbitration_haltByOther;
	reg execute_arbitration_haltItself;
	wire execute_arbitration_isFiring;
	wire execute_arbitration_isFlushed;
	wire execute_arbitration_isMoving;
	wire execute_arbitration_isStuck;
	wire execute_arbitration_isStuckByOthers;
	reg execute_arbitration_isValid;
	reg execute_arbitration_removeIt;
	reg [31:0] execute_to_memory_BRANCH_CALC;
	reg execute_to_memory_BRANCH_DO;
	reg execute_to_memory_BYPASSABLE_MEMORY_STAGE;
	reg [2:0] execute_to_memory_ENV_CTRL;
	reg [31:0] execute_to_memory_FORMAL_PC_NEXT;
	reg execute_to_memory_FPU_COMMIT;
	reg execute_to_memory_FPU_COMMIT_LOAD;
	reg execute_to_memory_FPU_FORKED;
	reg [3:0] execute_to_memory_FPU_OPCODE;
	reg execute_to_memory_FPU_RSP;
	reg [31:0] execute_to_memory_INSTRUCTION;
	reg execute_to_memory_IS_DBUS_SHARING;
	reg execute_to_memory_IS_DIV;
	reg execute_to_memory_IS_MUL;
	reg execute_to_memory_MEMORY_ENABLE;
	reg [31:0] execute_to_memory_MEMORY_STORE_DATA_RF;
	reg execute_to_memory_MEMORY_WR;
	reg [33:0] execute_to_memory_MUL_HH;
	reg [33:0] execute_to_memory_MUL_HL;
	reg [33:0] execute_to_memory_MUL_LH;
	reg [31:0] execute_to_memory_MUL_LL;
	reg [31:0] execute_to_memory_PC;
	reg [31:0] execute_to_memory_REGFILE_WRITE_DATA;
	reg execute_to_memory_REGFILE_WRITE_VALID;
	reg [31:0] execute_to_memory_RS1;
	reg [1:0] execute_to_memory_SHIFT_CTRL;
	reg [31:0] execute_to_memory_SHIFT_RIGHT;
	wire [31:0] lastStageInstruction;
	wire lastStageIsFiring;
	wire lastStageIsValid;
	wire [31:0] lastStagePc;
	reg [4:0] lastStageRegFileWrite_payload_address;
	reg [31:0] lastStageRegFileWrite_payload_data;
	reg lastStageRegFileWrite_valid;
	wire [31:0] memory_BRANCH_CALC;
	wire memory_BRANCH_DO;
	wire memory_BYPASSABLE_MEMORY_STAGE;
	reg [64:0] memory_DivPlugin_accumulator;
	reg [5:0] memory_DivPlugin_div_counter_value;
	reg [5:0] memory_DivPlugin_div_counter_valueNext;
	reg memory_DivPlugin_div_counter_willClear;
	reg memory_DivPlugin_div_counter_willIncrement;
	wire memory_DivPlugin_div_counter_willOverflow;
	wire memory_DivPlugin_div_counter_willOverflowIfInc;
	reg memory_DivPlugin_div_done;
	reg memory_DivPlugin_div_needRevert;
	reg [31:0] memory_DivPlugin_div_result;
	wire [31:0] memory_DivPlugin_div_stage_0_outNumerator;
	wire [31:0] memory_DivPlugin_div_stage_0_outRemainder;
	wire [32:0] memory_DivPlugin_div_stage_0_remainderMinusDenominator;
	wire [32:0] memory_DivPlugin_div_stage_0_remainderShifted;
	wire memory_DivPlugin_frontendOk;
	reg [32:0] memory_DivPlugin_rs1;
	reg [31:0] memory_DivPlugin_rs2;
	wire [2:0] memory_ENV_CTRL;
	wire [31:0] memory_FORMAL_PC_NEXT;
	wire memory_FPU_COMMIT;
	wire memory_FPU_COMMIT_LOAD;
	wire memory_FPU_FORKED;
	wire [3:0] memory_FPU_OPCODE;
	wire memory_FPU_RSP;
	wire [31:0] memory_INSTRUCTION;
	wire memory_IS_DBUS_SHARING;
	wire memory_IS_DIV;
	wire memory_IS_MUL;
	wire memory_MEMORY_ENABLE;
	wire [31:0] memory_MEMORY_STORE_DATA_RF;
	wire memory_MEMORY_WR;
	wire [33:0] memory_MUL_HH;
	wire [33:0] memory_MUL_HL;
	wire [33:0] memory_MUL_LH;
	wire [31:0] memory_MUL_LL;
	wire [51:0] memory_MUL_LOW;
	wire [31:0] memory_PC;
	wire [31:0] memory_REGFILE_WRITE_DATA;
	wire memory_REGFILE_WRITE_VALID;
	wire [31:0] memory_RS1;
	wire [1:0] memory_SHIFT_CTRL;
	wire [31:0] memory_SHIFT_RIGHT;
	wire memory_arbitration_flushIt;
	reg memory_arbitration_flushNext;
	wire memory_arbitration_haltByOther;
	reg memory_arbitration_haltItself;
	wire memory_arbitration_isFiring;
	wire memory_arbitration_isFlushed;
	wire memory_arbitration_isMoving;
	wire memory_arbitration_isStuck;
	wire memory_arbitration_isStuckByOthers;
	reg memory_arbitration_isValid;
	reg memory_arbitration_removeIt;
	reg [2:0] memory_to_writeBack_ENV_CTRL;
	reg [31:0] memory_to_writeBack_FORMAL_PC_NEXT;
	reg memory_to_writeBack_FPU_COMMIT;
	reg memory_to_writeBack_FPU_COMMIT_LOAD;
	reg memory_to_writeBack_FPU_FORKED;
	reg [3:0] memory_to_writeBack_FPU_OPCODE;
	reg memory_to_writeBack_FPU_RSP;
	reg [31:0] memory_to_writeBack_INSTRUCTION;
	reg memory_to_writeBack_IS_DBUS_SHARING;
	reg memory_to_writeBack_IS_MUL;
	reg memory_to_writeBack_MEMORY_ENABLE;
	reg [31:0] memory_to_writeBack_MEMORY_STORE_DATA_RF;
	reg memory_to_writeBack_MEMORY_WR;
	reg [33:0] memory_to_writeBack_MUL_HH;
	reg [51:0] memory_to_writeBack_MUL_LOW;
	reg [31:0] memory_to_writeBack_PC;
	reg [31:0] memory_to_writeBack_REGFILE_WRITE_DATA;
	reg memory_to_writeBack_REGFILE_WRITE_VALID;
	reg [31:0] memory_to_writeBack_RS1;
	wire [1:0] switch_CsrPlugin_l1031;
	wire [1:0] switch_CsrPlugin_l1460;
	wire [1:0] switch_Misc_l226;
	wire [2:0] switch_Misc_l226_1;
	wire switch_Misc_l226_2;
	wire [1:0] switch_MulPlugin_l148;
	wire [1:0] switch_MulPlugin_l87;
	wire toplevel_dataCache_1_io_cpu_flush_isStall;
	reg [31:0] toplevel_dataCache_1_io_mem_cmd_rData_address;
	reg [63:0] toplevel_dataCache_1_io_mem_cmd_rData_data;
	reg toplevel_dataCache_1_io_mem_cmd_rData_last;
	reg [7:0] toplevel_dataCache_1_io_mem_cmd_rData_mask;
	reg [1:0] toplevel_dataCache_1_io_mem_cmd_rData_size;
	reg toplevel_dataCache_1_io_mem_cmd_rData_uncached;
	reg toplevel_dataCache_1_io_mem_cmd_rData_wr;
	reg toplevel_dataCache_1_io_mem_cmd_rValid;
	wire [31:0] toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_address;
	wire [63:0] toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_data;
	wire toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_last;
	wire [7:0] toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_mask;
	wire [1:0] toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_size;
	wire toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_uncached;
	wire toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_wr;
	wire toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_ready;
	wire toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_valid;
	wire [31:0] toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_address;
	wire [63:0] toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_data;
	wire toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_last;
	wire [7:0] toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_mask;
	wire [1:0] toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_size;
	wire toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_uncached;
	wire toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_wr;
	reg [31:0] toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_address;
	reg [63:0] toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_data;
	reg toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_last;
	reg [7:0] toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_mask;
	reg [1:0] toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_size;
	reg toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_uncached;
	reg toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_wr;
	reg toplevel_dataCache_1_io_mem_cmd_s2mPipe_rValid;
	reg toplevel_dataCache_1_io_mem_cmd_s2mPipe_ready;
	wire toplevel_dataCache_1_io_mem_cmd_s2mPipe_valid;
	wire when_CsrPlugin_l1076;
	wire when_CsrPlugin_l1076_1;
	wire when_CsrPlugin_l1076_2;
	wire when_CsrPlugin_l1076_3;
	wire when_CsrPlugin_l1077;
	wire when_CsrPlugin_l1077_1;
	wire when_CsrPlugin_l1077_2;
	wire when_CsrPlugin_l1077_3;
	wire when_CsrPlugin_l1153;
	wire when_CsrPlugin_l1216;
	wire when_CsrPlugin_l1216_1;
	wire when_CsrPlugin_l1216_10;
	wire when_CsrPlugin_l1216_11;
	wire when_CsrPlugin_l1216_2;
	wire when_CsrPlugin_l1216_3;
	wire when_CsrPlugin_l1216_4;
	wire when_CsrPlugin_l1216_5;
	wire when_CsrPlugin_l1216_6;
	wire when_CsrPlugin_l1216_7;
	wire when_CsrPlugin_l1216_8;
	wire when_CsrPlugin_l1216_9;
	wire when_CsrPlugin_l1259;
	wire when_CsrPlugin_l1259_1;
	wire when_CsrPlugin_l1259_2;
	wire when_CsrPlugin_l1259_3;
	wire when_CsrPlugin_l1272;
	wire when_CsrPlugin_l1296;
	wire when_CsrPlugin_l1296_1;
	wire when_CsrPlugin_l1302;
	wire when_CsrPlugin_l1302_1;
	wire when_CsrPlugin_l1302_2;
	wire when_CsrPlugin_l1302_3;
	wire when_CsrPlugin_l1302_4;
	wire when_CsrPlugin_l1302_5;
	wire when_CsrPlugin_l1302_6;
	wire when_CsrPlugin_l1302_7;
	wire when_CsrPlugin_l1302_8;
	wire when_CsrPlugin_l1335;
	wire when_CsrPlugin_l1335_1;
	wire when_CsrPlugin_l1335_2;
	wire when_CsrPlugin_l1340;
	wire when_CsrPlugin_l1346;
	wire when_CsrPlugin_l1390;
	wire when_CsrPlugin_l1398;
	wire when_CsrPlugin_l1456;
	wire when_CsrPlugin_l1468;
	wire when_CsrPlugin_l1519;
	wire when_CsrPlugin_l1521;
	wire when_CsrPlugin_l1527;
	wire when_CsrPlugin_l1540;
	wire when_CsrPlugin_l1547;
	wire when_CsrPlugin_l1548;
	wire when_CsrPlugin_l1555;
	wire when_CsrPlugin_l1565;
	wire when_CsrPlugin_l1587;
	wire when_CsrPlugin_l1591;
	wire when_CsrPlugin_l1669;
	wire when_CsrPlugin_l1669_1;
	wire when_CsrPlugin_l1669_10;
	wire when_CsrPlugin_l1669_11;
	wire when_CsrPlugin_l1669_12;
	wire when_CsrPlugin_l1669_13;
	wire when_CsrPlugin_l1669_14;
	wire when_CsrPlugin_l1669_15;
	wire when_CsrPlugin_l1669_16;
	wire when_CsrPlugin_l1669_17;
	wire when_CsrPlugin_l1669_18;
	wire when_CsrPlugin_l1669_19;
	wire when_CsrPlugin_l1669_2;
	wire when_CsrPlugin_l1669_20;
	wire when_CsrPlugin_l1669_21;
	wire when_CsrPlugin_l1669_22;
	wire when_CsrPlugin_l1669_23;
	wire when_CsrPlugin_l1669_24;
	wire when_CsrPlugin_l1669_25;
	wire when_CsrPlugin_l1669_26;
	wire when_CsrPlugin_l1669_27;
	wire when_CsrPlugin_l1669_28;
	wire when_CsrPlugin_l1669_29;
	wire when_CsrPlugin_l1669_3;
	wire when_CsrPlugin_l1669_30;
	wire when_CsrPlugin_l1669_31;
	wire when_CsrPlugin_l1669_32;
	wire when_CsrPlugin_l1669_33;
	wire when_CsrPlugin_l1669_34;
	wire when_CsrPlugin_l1669_35;
	wire when_CsrPlugin_l1669_36;
	wire when_CsrPlugin_l1669_4;
	wire when_CsrPlugin_l1669_5;
	wire when_CsrPlugin_l1669_6;
	wire when_CsrPlugin_l1669_7;
	wire when_CsrPlugin_l1669_8;
	wire when_CsrPlugin_l1669_9;
	wire when_CsrPlugin_l1702;
	wire when_CsrPlugin_l1710;
	reg when_CsrPlugin_l1712;
	wire when_CsrPlugin_l1718;
	wire when_DBusCachedPlugin_l341;
	wire when_DBusCachedPlugin_l383;
	wire when_DBusCachedPlugin_l399;
	wire when_DBusCachedPlugin_l460;
	wire when_DBusCachedPlugin_l521;
	wire when_DBusCachedPlugin_l541;
	wire when_DBusCachedPlugin_l568;
	wire when_DBusCachedPlugin_l592;
	wire when_DBusCachedPlugin_l593;
	wire when_Fetcher_l133;
	wire when_Fetcher_l133_1;
	wire when_Fetcher_l160;
	wire when_Fetcher_l322;
	wire when_Fetcher_l331;
	wire when_Fetcher_l331_1;
	wire when_Fetcher_l331_2;
	wire when_Fetcher_l331_3;
	wire when_Fetcher_l331_4;
	wire when_FpuPlugin_l215;
	wire when_FpuPlugin_l216;
	wire when_FpuPlugin_l217;
	wire when_FpuPlugin_l218;
	wire when_FpuPlugin_l219;
	wire when_FpuPlugin_l229;
	wire when_FpuPlugin_l234;
	wire when_FpuPlugin_l237;
	wire when_FpuPlugin_l253;
	wire when_FpuPlugin_l268;
	wire when_FpuPlugin_l268_1;
	wire when_FpuPlugin_l272;
	wire when_FpuPlugin_l273;
	wire when_FpuPlugin_l306;
	wire when_FpuPlugin_l315;
	wire when_FpuPlugin_l318;
	wire when_FpuPlugin_l323;
	wire when_FpuPlugin_l325;
	wire when_FpuPlugin_l339;
	wire when_HazardSimplePlugin_l105;
	wire when_HazardSimplePlugin_l108;
	wire when_HazardSimplePlugin_l113;
	wire when_HazardSimplePlugin_l45;
	wire when_HazardSimplePlugin_l45_1;
	wire when_HazardSimplePlugin_l45_2;
	wire when_HazardSimplePlugin_l47;
	wire when_HazardSimplePlugin_l48;
	wire when_HazardSimplePlugin_l48_1;
	wire when_HazardSimplePlugin_l48_2;
	wire when_HazardSimplePlugin_l51;
	wire when_HazardSimplePlugin_l51_1;
	wire when_HazardSimplePlugin_l51_2;
	wire when_HazardSimplePlugin_l57;
	wire when_HazardSimplePlugin_l57_1;
	wire when_HazardSimplePlugin_l57_2;
	wire when_HazardSimplePlugin_l58;
	wire when_HazardSimplePlugin_l58_1;
	wire when_HazardSimplePlugin_l58_2;
	wire when_IBusCachedPlugin_l245;
	wire when_IBusCachedPlugin_l250;
	wire when_IBusCachedPlugin_l256;
	wire when_IBusCachedPlugin_l262;
	wire when_IBusCachedPlugin_l273;
	wire when_MmuPlugin_l131;
	wire when_MmuPlugin_l131_1;
	wire when_MmuPlugin_l132;
	wire when_MmuPlugin_l132_1;
	wire when_MmuPlugin_l134;
	wire when_MmuPlugin_l211;
	wire when_MmuPlugin_l223;
	wire when_MmuPlugin_l250;
	wire when_MmuPlugin_l279;
	wire when_MmuPlugin_l281;
	wire when_MmuPlugin_l281_1;
	wire when_MmuPlugin_l287;
	wire when_MmuPlugin_l287_1;
	wire when_MmuPlugin_l287_2;
	wire when_MmuPlugin_l287_3;
	wire when_MmuPlugin_l287_4;
	wire when_MmuPlugin_l287_5;
	wire when_MmuPlugin_l287_6;
	wire when_MmuPlugin_l287_7;
	wire when_MmuPlugin_l311;
	wire when_MulDivIterativePlugin_l126;
	wire when_MulDivIterativePlugin_l126_1;
	wire when_MulDivIterativePlugin_l128;
	wire when_MulDivIterativePlugin_l129;
	wire when_MulDivIterativePlugin_l132;
	wire when_MulDivIterativePlugin_l151;
	wire when_MulDivIterativePlugin_l162;
	wire when_MulPlugin_l147;
	wire when_Pipeline_l124;
	wire when_Pipeline_l124_1;
	wire when_Pipeline_l124_10;
	wire when_Pipeline_l124_11;
	wire when_Pipeline_l124_12;
	wire when_Pipeline_l124_13;
	wire when_Pipeline_l124_14;
	wire when_Pipeline_l124_15;
	wire when_Pipeline_l124_16;
	wire when_Pipeline_l124_17;
	wire when_Pipeline_l124_18;
	wire when_Pipeline_l124_19;
	wire when_Pipeline_l124_2;
	wire when_Pipeline_l124_20;
	wire when_Pipeline_l124_21;
	wire when_Pipeline_l124_22;
	wire when_Pipeline_l124_23;
	wire when_Pipeline_l124_24;
	wire when_Pipeline_l124_25;
	wire when_Pipeline_l124_26;
	wire when_Pipeline_l124_27;
	wire when_Pipeline_l124_28;
	wire when_Pipeline_l124_29;
	wire when_Pipeline_l124_3;
	wire when_Pipeline_l124_30;
	wire when_Pipeline_l124_31;
	wire when_Pipeline_l124_32;
	wire when_Pipeline_l124_33;
	wire when_Pipeline_l124_34;
	wire when_Pipeline_l124_35;
	wire when_Pipeline_l124_36;
	wire when_Pipeline_l124_37;
	wire when_Pipeline_l124_38;
	wire when_Pipeline_l124_39;
	wire when_Pipeline_l124_4;
	wire when_Pipeline_l124_40;
	wire when_Pipeline_l124_41;
	wire when_Pipeline_l124_42;
	wire when_Pipeline_l124_43;
	wire when_Pipeline_l124_44;
	wire when_Pipeline_l124_45;
	wire when_Pipeline_l124_46;
	wire when_Pipeline_l124_47;
	wire when_Pipeline_l124_48;
	wire when_Pipeline_l124_49;
	wire when_Pipeline_l124_5;
	wire when_Pipeline_l124_50;
	wire when_Pipeline_l124_51;
	wire when_Pipeline_l124_52;
	wire when_Pipeline_l124_53;
	wire when_Pipeline_l124_54;
	wire when_Pipeline_l124_55;
	wire when_Pipeline_l124_56;
	wire when_Pipeline_l124_57;
	wire when_Pipeline_l124_58;
	wire when_Pipeline_l124_59;
	wire when_Pipeline_l124_6;
	wire when_Pipeline_l124_60;
	wire when_Pipeline_l124_61;
	wire when_Pipeline_l124_62;
	wire when_Pipeline_l124_63;
	wire when_Pipeline_l124_64;
	wire when_Pipeline_l124_65;
	wire when_Pipeline_l124_66;
	wire when_Pipeline_l124_67;
	wire when_Pipeline_l124_68;
	wire when_Pipeline_l124_69;
	wire when_Pipeline_l124_7;
	wire when_Pipeline_l124_70;
	wire when_Pipeline_l124_71;
	wire when_Pipeline_l124_72;
	wire when_Pipeline_l124_73;
	wire when_Pipeline_l124_74;
	wire when_Pipeline_l124_75;
	wire when_Pipeline_l124_76;
	wire when_Pipeline_l124_77;
	wire when_Pipeline_l124_78;
	wire when_Pipeline_l124_79;
	wire when_Pipeline_l124_8;
	wire when_Pipeline_l124_80;
	wire when_Pipeline_l124_81;
	wire when_Pipeline_l124_82;
	wire when_Pipeline_l124_9;
	wire when_Pipeline_l151;
	wire when_Pipeline_l151_1;
	wire when_Pipeline_l151_2;
	wire when_Pipeline_l154;
	wire when_Pipeline_l154_1;
	wire when_Pipeline_l154_2;
	wire when_RegFilePlugin_l63;
	wire when_Stream_l368;
	wire [63:0] writeBack_DBusCachedPlugin_rspData;
	reg [31:0] writeBack_DBusCachedPlugin_rspFormated;
	wire [31:0] writeBack_DBusCachedPlugin_rspRf;
	reg [63:0] writeBack_DBusCachedPlugin_rspShifted;
	wire [7:0] writeBack_DBusCachedPlugin_rspSplits_0;
	wire [7:0] writeBack_DBusCachedPlugin_rspSplits_1;
	wire [7:0] writeBack_DBusCachedPlugin_rspSplits_2;
	wire [7:0] writeBack_DBusCachedPlugin_rspSplits_3;
	wire [7:0] writeBack_DBusCachedPlugin_rspSplits_4;
	wire [7:0] writeBack_DBusCachedPlugin_rspSplits_5;
	wire [7:0] writeBack_DBusCachedPlugin_rspSplits_6;
	wire [7:0] writeBack_DBusCachedPlugin_rspSplits_7;
	wire [2:0] writeBack_ENV_CTRL;
	wire [31:0] writeBack_FORMAL_PC_NEXT;
	wire writeBack_FPU_COMMIT;
	wire writeBack_FPU_COMMIT_LOAD;
	wire writeBack_FPU_FORKED;
	wire [3:0] writeBack_FPU_OPCODE;
	wire writeBack_FPU_RSP;
	wire [3:0] writeBack_FpuPlugin_commit_payload_opcode;
	wire [4:0] writeBack_FpuPlugin_commit_payload_rd;
	reg [63:0] writeBack_FpuPlugin_commit_payload_value;
	wire writeBack_FpuPlugin_commit_payload_write;
	reg [3:0] writeBack_FpuPlugin_commit_rData_opcode;
	reg [4:0] writeBack_FpuPlugin_commit_rData_rd;
	reg [63:0] writeBack_FpuPlugin_commit_rData_value;
	reg writeBack_FpuPlugin_commit_rData_write;
	reg writeBack_FpuPlugin_commit_rValid;
	wire writeBack_FpuPlugin_commit_ready;
	wire [3:0] writeBack_FpuPlugin_commit_s2mPipe_payload_opcode;
	wire [4:0] writeBack_FpuPlugin_commit_s2mPipe_payload_rd;
	wire [63:0] writeBack_FpuPlugin_commit_s2mPipe_payload_value;
	wire writeBack_FpuPlugin_commit_s2mPipe_payload_write;
	wire writeBack_FpuPlugin_commit_s2mPipe_ready;
	wire writeBack_FpuPlugin_commit_s2mPipe_valid;
	wire writeBack_FpuPlugin_commit_valid;
	wire writeBack_FpuPlugin_isCommit;
	wire writeBack_FpuPlugin_isRsp;
	reg [63:0] writeBack_FpuPlugin_storeFormated;
	wire [31:0] writeBack_INSTRUCTION;
	wire writeBack_IS_DBUS_SHARING;
	wire writeBack_IS_MUL;
	wire writeBack_MEMORY_ENABLE;
	wire [63:0] writeBack_MEMORY_LOAD_DATA;
	wire [31:0] writeBack_MEMORY_STORE_DATA_RF;
	wire writeBack_MEMORY_WR;
	wire [33:0] writeBack_MUL_HH;
	wire [51:0] writeBack_MUL_LOW;
	wire [65:0] writeBack_MulPlugin_result;
	wire [31:0] writeBack_PC;
	wire [31:0] writeBack_REGFILE_WRITE_DATA;
	wire writeBack_REGFILE_WRITE_VALID;
	wire [31:0] writeBack_RS1;
	reg writeBack_arbitration_flushIt;
	reg writeBack_arbitration_flushNext;
	reg writeBack_arbitration_haltByOther;
	reg writeBack_arbitration_haltItself;
	wire writeBack_arbitration_isFiring;
	wire writeBack_arbitration_isFlushed;
	wire writeBack_arbitration_isMoving;
	wire writeBack_arbitration_isStuck;
	wire writeBack_arbitration_isStuckByOthers;
	reg writeBack_arbitration_isValid;
	reg writeBack_arbitration_removeIt;
	assign BranchPlugin_branchExceptionPort_payload_code = 4'h0;
	assign BranchPlugin_inDebugNoFetchFlag = 1'b0;
	assign CsrPlugin_allowEbreakException = 1'b1;
	assign CsrPlugin_allowException = 1'b1;
	assign CsrPlugin_allowInterrupts = 1'b1;
	assign CsrPlugin_forceMachineWire = 1'b0;
	assign CsrPlugin_mcounteren_TM = 1'b1;
	assign CsrPlugin_misa_base = 2'h1;
	assign CsrPlugin_misa_extensions = 26'h0000000;
	assign CsrPlugin_scounteren_TM = 1'b1;
	assign CsrPlugin_trapCauseEbreakDebug = 1'b0;
	assign CsrPlugin_trapEnterDebug = 1'b0;
	assign IBusCachedPlugin_forceNoDecodeCond = 1'b0;
	assign IBusCachedPlugin_mmuBus_cmd_0_bypassTranslation = 1'b0;
	assign IBusCachedPlugin_rsp_iBusRspOutputHalt = 1'b0;
	assign IBusCachedPlugin_rsp_issueDetected = 1'b0;
	assign IBusCachedPlugin_s0_tightlyCoupledHit = 1'b0;
	assign MmuPlugin_dBusAccess_cmd_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
	assign MmuPlugin_dBusAccess_cmd_payload_size = 2'h2;
	assign MmuPlugin_dBusAccess_cmd_payload_write = 1'b0;
	assign MmuPlugin_dBusAccess_cmd_payload_writeMask = 4'bxxxx;
	assign MmuPlugin_ports_0_dirty = 1'b0;
	assign MmuPlugin_ports_0_entryToReplace_willClear = 1'b0;
	assign MmuPlugin_ports_1_dirty = 1'b0;
	assign MmuPlugin_ports_1_entryToReplace_willClear = 1'b0;
	assign _zz_CsrPlugin_csrMapping_readDataInit_37 = 32'h00000000;
	assign _zz_CsrPlugin_csrMapping_readDataInit_38 = 32'h00000000;
	assign _zz_CsrPlugin_csrMapping_readDataInit_40 = 32'h00000000;
	assign _zz_CsrPlugin_csrMapping_readDataInit_41 = 32'h00000000;
	assign _zz__zz_decode_IS_CSR = 32'h10103070;
	assign _zz__zz_decode_IS_CSR_102 = 32'h00000010;
	assign _zz__zz_decode_IS_CSR_105 = 32'h00000010;
	assign _zz__zz_decode_IS_CSR_112 = 32'h10000020;
	assign _zz__zz_decode_IS_CSR_115 = 32'h00000000;
	assign _zz__zz_decode_IS_CSR_118 = 32'h00000000;
	assign _zz__zz_decode_IS_CSR_123 = 32'h00000040;
	assign _zz__zz_decode_IS_CSR_126 = 32'h00000004;
	assign _zz__zz_decode_IS_CSR_135 = 32'h00000020;
	assign _zz__zz_decode_IS_CSR_137 = 32'h00000020;
	assign _zz__zz_decode_IS_CSR_142 = 32'h00001060;
	assign _zz__zz_decode_IS_CSR_145 = 32'h00002060;
	assign _zz__zz_decode_IS_CSR_147 = 32'h10000060;
	assign _zz__zz_decode_IS_CSR_151 = 32'h10000020;
	assign _zz__zz_decode_IS_CSR_156 = 32'h00004020;
	assign _zz__zz_decode_IS_CSR_159 = 32'h00000060;
	assign _zz__zz_decode_IS_CSR_162 = 32'h02000020;
	assign _zz__zz_decode_IS_CSR_164 = 32'h00000070;
	assign _zz__zz_decode_IS_CSR_168 = 32'h00002010;
	assign _zz__zz_decode_IS_CSR_171 = 32'h02002060;
	assign _zz__zz_decode_IS_CSR_174 = 32'h00000010;
	assign _zz__zz_decode_IS_CSR_177 = 32'h00000020;
	assign _zz__zz_decode_IS_CSR_18 = 32'h02004064;
	assign _zz__zz_decode_IS_CSR_182 = 32'h00000050;
	assign _zz__zz_decode_IS_CSR_185 = 32'h00001030;
	assign _zz__zz_decode_IS_CSR_188 = 32'h00002030;
	assign _zz__zz_decode_IS_CSR_198 = 32'h00000070;
	assign _zz__zz_decode_IS_CSR_203 = 32'h00000020;
	assign _zz__zz_decode_IS_CSR_207 = 32'h00004010;
	assign _zz__zz_decode_IS_CSR_21 = 32'h02000030;
	assign _zz__zz_decode_IS_CSR_211 = 32'h00006014;
	assign _zz__zz_decode_IS_CSR_216 = 32'h00000038;
	assign _zz__zz_decode_IS_CSR_219 = 32'h00004000;
	assign _zz__zz_decode_IS_CSR_221 = 32'h00006024;
	assign _zz__zz_decode_IS_CSR_224 = 32'h00001020;
	assign _zz__zz_decode_IS_CSR_226 = 32'h90000010;
	assign _zz__zz_decode_IS_CSR_232 = 32'h00000040;
	assign _zz__zz_decode_IS_CSR_239 = 32'h00002014;
	assign _zz__zz_decode_IS_CSR_24 = 32'h40003054;
	assign _zz__zz_decode_IS_CSR_25 = 32'h02007054;
	assign _zz__zz_decode_IS_CSR_27 = 32'h00000034;
	assign _zz__zz_decode_IS_CSR_30 = 32'h00001000;
	assign _zz__zz_decode_IS_CSR_34 = 32'h00002010;
	assign _zz__zz_decode_IS_CSR_35 = 32'h00005000;
	assign _zz__zz_decode_IS_CSR_38 = 32'h20002010;
	assign _zz__zz_decode_IS_CSR_4 = 32'h12403034;
	assign _zz__zz_decode_IS_CSR_41 = 32'h20001010;
	assign _zz__zz_decode_IS_CSR_44 = 32'h08000010;
	assign _zz__zz_decode_IS_CSR_46 = 32'h80000010;
	assign _zz__zz_decode_IS_CSR_49 = 32'h00001040;
	assign _zz__zz_decode_IS_CSR_52 = 32'h82000000;
	assign _zz__zz_decode_IS_CSR_54 = 32'h02000050;
	assign _zz__zz_decode_IS_CSR_57 = 32'h12000000;
	assign _zz__zz_decode_IS_CSR_60 = 32'h42000004;
	assign _zz__zz_decode_IS_CSR_62 = 32'hd2000010;
	assign _zz__zz_decode_IS_CSR_65 = 32'h60000010;
	assign _zz__zz_decode_IS_CSR_67 = 32'h18000010;
	assign _zz__zz_decode_IS_CSR_7 = 32'h00001070;
	assign _zz__zz_decode_IS_CSR_70 = 32'h20000010;
	assign _zz__zz_decode_IS_CSR_74 = 32'h80000004;
	assign _zz__zz_decode_IS_CSR_77 = 32'h00000040;
	assign _zz__zz_decode_IS_CSR_80 = 32'h40000000;
	assign _zz__zz_decode_IS_CSR_84 = 32'h00001010;
	assign _zz__zz_decode_IS_CSR_87 = 32'h30000010;
	assign _zz__zz_decode_IS_CSR_9 = 32'h00002070;
	assign _zz__zz_decode_IS_CSR_90 = 32'h00000010;
	assign _zz__zz_decode_IS_CSR_93 = 32'h00000010;
	assign _zz__zz_decode_IS_CSR_98 = 32'h90000010;
	assign _zz__zz_execute_SRC1 = 3'h4;
	assign _zz_decode_FPU_FORKED = 1'b0;
	assign _zz_decode_LEGAL_INSTRUCTION = 32'h0000107f;
	assign _zz_decode_LEGAL_INSTRUCTION_12 = 32'hfc00007f;
	assign _zz_decode_LEGAL_INSTRUCTION_14 = 32'h20000053;
	assign _zz_decode_LEGAL_INSTRUCTION_18 = 32'hfe00305f;
	assign _zz_decode_LEGAL_INSTRUCTION_2 = 32'h00002073;
	assign _zz_decode_LEGAL_INSTRUCTION_20 = 32'hc0000053;
	assign _zz_decode_LEGAL_INSTRUCTION_24 = 32'hfdf0707f;
	assign _zz_decode_LEGAL_INSTRUCTION_26 = 32'he0000053;
	assign _zz_decode_LEGAL_INSTRUCTION_6 = 32'h0000107f;
	assign _zz_decode_LEGAL_INSTRUCTION_8 = 32'h00000023;
	assign _zz_decode_RegFilePlugin_rs1Data = 1'b1;
	assign _zz_decode_RegFilePlugin_rs2Data = 1'b1;
	assign _zz_execute_BranchPlugin_branch_src2_9 = 3'h4;
	assign _zz_execute_SrcPlugin_addSub_5 = 32'h00000001;
	assign _zz_execute_SrcPlugin_addSub_6 = 32'h00000000;
	assign _zz_memory_MUL_LOW_2 = 52'h0000000000000;
	assign decodeExceptionPort_payload_code = 4'h2;
	assign decode_MEMORY_FORCE_CONSTISTENCY = 1'b0;
	assign decode_arbitration_flushIt = 1'b0;
	assign execute_arbitration_flushIt = 1'b0;
	assign memory_DivPlugin_frontendOk = 1'b1;
	assign memory_arbitration_flushIt = 1'b0;
	assign memory_arbitration_haltByOther = 1'b0;
	assign when_DBusCachedPlugin_l460 = 1'b0;
	assign when_HazardSimplePlugin_l47 = 1'b1;
	assign _zz_when = {decodeExceptionPort_valid, IBusCachedPlugin_decodeExceptionPort_valid} != 2'h0;
	assign _zz_memory_MUL_LOW = _zz_memory_MUL_LOW_1 + _zz_memory_MUL_LOW_5;
	assign _zz_memory_MUL_LOW_1 = _zz_memory_MUL_LOW_2 + _zz_memory_MUL_LOW_3;
	assign _zz_memory_MUL_LOW_4 = {1'b0, memory_MUL_LL};
	assign _zz_memory_MUL_LOW_3 = {{19 {_zz_memory_MUL_LOW_4[32]}}, _zz_memory_MUL_LOW_4};
	assign _zz_memory_MUL_LOW_6 = {16'h0000, memory_MUL_LH, 16'h0000};
	assign _zz_memory_MUL_LOW_5 = {{2 {_zz_memory_MUL_LOW_6[49]}}, _zz_memory_MUL_LOW_6};
	assign _zz_memory_MUL_LOW_8 = {16'h0000, memory_MUL_HL, 16'h0000};
	assign _zz_memory_MUL_LOW_7 = {{2 {_zz_memory_MUL_LOW_8[49]}}, _zz_memory_MUL_LOW_8};
	assign _zz_execute_SHIFT_RIGHT_1 = $signed(_zz_execute_SHIFT_RIGHT_2) >>> execute_FullBarrelShifterPlugin_amplitude;
	assign _zz_execute_SHIFT_RIGHT = _zz_execute_SHIFT_RIGHT_1[31:0];
	assign _zz_execute_SHIFT_RIGHT_2 = {(execute_SHIFT_CTRL == ShiftCtrlEnum_SRA_1) & execute_FullBarrelShifterPlugin_reversed[31], execute_FullBarrelShifterPlugin_reversed};
	assign _zz__zz_IBusCachedPlugin_jump_pcLoad_payload_1 = _zz_IBusCachedPlugin_jump_pcLoad_payload - 5'h01;
	assign _zz_IBusCachedPlugin_fetchPc_pc_1 = {IBusCachedPlugin_fetchPc_inc, 2'h0};
	assign _zz_IBusCachedPlugin_fetchPc_pc = {29'h00000000, _zz_IBusCachedPlugin_fetchPc_pc_1};
	assign _zz__zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch = {decode_INSTRUCTION[31], decode_INSTRUCTION[7], decode_INSTRUCTION[30:25], decode_INSTRUCTION[11:8]};
	assign _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_2 = {_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1, decode_INSTRUCTION[31], decode_INSTRUCTION[7], decode_INSTRUCTION[30:25], decode_INSTRUCTION[11:8], 1'b0};
	assign _zz__zz_2 = {decode_INSTRUCTION[31], decode_INSTRUCTION[19:12], decode_INSTRUCTION[20], decode_INSTRUCTION[30:21]};
	assign _zz__zz_4 = {decode_INSTRUCTION[31], decode_INSTRUCTION[7], decode_INSTRUCTION[30:25], decode_INSTRUCTION[11:8]};
	assign _zz__zz_6 = {_zz_3, decode_INSTRUCTION[31], decode_INSTRUCTION[19:12], decode_INSTRUCTION[20], decode_INSTRUCTION[30:21], 1'b0};
	assign _zz__zz_6_1 = {_zz_5, decode_INSTRUCTION[31], decode_INSTRUCTION[7], decode_INSTRUCTION[30:25], decode_INSTRUCTION[11:8], 1'b0};
	assign _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload = {decode_INSTRUCTION[31], decode_INSTRUCTION[19:12], decode_INSTRUCTION[20], decode_INSTRUCTION[30:21]};
	assign _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload_2 = {decode_INSTRUCTION[31], decode_INSTRUCTION[7], decode_INSTRUCTION[30:25], decode_INSTRUCTION[11:8]};
	assign _zz_io_cpu_flush_payload_lineId_1 = {3'h0, execute_RS1[31:3]};
	assign _zz_DBusCachedPlugin_exceptionBus_payload_code = (writeBack_MEMORY_WR ? 3'h7 : 3'h5);
	assign _zz_DBusCachedPlugin_exceptionBus_payload_code_1 = (writeBack_MEMORY_WR ? 3'h6 : 3'h4);
	assign _zz_MmuPlugin_ports_0_entryToReplace_valueNext = {1'b0, _zz_MmuPlugin_ports_0_entryToReplace_valueNext_1};
	assign _zz_MmuPlugin_ports_1_entryToReplace_valueNext = {1'b0, _zz_MmuPlugin_ports_1_entryToReplace_valueNext_1};
	assign _zz__zz_MmuPlugin_shared_refills_2 = _zz_MmuPlugin_shared_refills_1 - 2'h1;
	assign _zz_FpuPlugin_pendings = _zz_FpuPlugin_pendings_1 - _zz_FpuPlugin_pendings_4;
	assign _zz_FpuPlugin_pendings_1 = FpuPlugin_pendings + _zz_FpuPlugin_pendings_2;
	assign _zz_FpuPlugin_pendings_2 = {5'h00, _zz_FpuPlugin_pendings_3};
	assign _zz_FpuPlugin_pendings_4 = {5'h00, _zz_FpuPlugin_pendings_5};
	assign _zz_FpuPlugin_pendings_6 = {5'h00, _zz_FpuPlugin_pendings_7};
	assign _zz__zz_execute_SRC1_1 = execute_INSTRUCTION[19:15];
	assign _zz__zz_execute_SRC2_2 = {execute_INSTRUCTION[31:25], execute_INSTRUCTION[11:7]};
	assign _zz_execute_SrcPlugin_addSub = _zz_execute_SrcPlugin_addSub_1 + _zz_execute_SrcPlugin_addSub_4;
	assign _zz_execute_SrcPlugin_addSub_1 = _zz_execute_SrcPlugin_addSub_2 + _zz_execute_SrcPlugin_addSub_3;
	assign _zz_execute_SrcPlugin_addSub_3 = (execute_SRC_USE_SUB_LESS ? ~execute_SRC2 : execute_SRC2);
	assign _zz_execute_SrcPlugin_addSub_4 = (execute_SRC_USE_SUB_LESS ? _zz_execute_SrcPlugin_addSub_5 : _zz_execute_SrcPlugin_addSub_6);
	assign _zz_writeBack_MulPlugin_result = {{14 {writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
	assign _zz_writeBack_MulPlugin_result_1 = {32'h00000000, writeBack_MUL_HH, 32'h00000000};
	assign _zz__zz_decode_RS2_2 = writeBack_MUL_LOW[31:0];
	assign _zz__zz_decode_RS2_2_1 = writeBack_MulPlugin_result[63:32];
	assign _zz_memory_DivPlugin_div_counter_valueNext = {5'h00, _zz_memory_DivPlugin_div_counter_valueNext_1};
	assign _zz_memory_DivPlugin_div_stage_0_remainderMinusDenominator = {1'b0, memory_DivPlugin_rs2};
	assign _zz_memory_DivPlugin_div_stage_0_outRemainder = memory_DivPlugin_div_stage_0_remainderMinusDenominator[31:0];
	assign _zz_memory_DivPlugin_div_stage_0_outRemainder_1 = memory_DivPlugin_div_stage_0_remainderShifted[31:0];
	assign _zz_memory_DivPlugin_div_stage_0_outNumerator = {_zz_memory_DivPlugin_div_stage_0_remainderShifted, ~|memory_DivPlugin_div_stage_0_remainderMinusDenominator[32]};
	assign _zz_memory_DivPlugin_div_result_3 = {memory_DivPlugin_div_needRevert, (memory_DivPlugin_div_needRevert ? ~_zz_memory_DivPlugin_div_result : _zz_memory_DivPlugin_div_result)} + _zz_memory_DivPlugin_div_result_4;
	assign _zz_memory_DivPlugin_div_result_4 = {32'h00000000, _zz_memory_DivPlugin_div_result_5};
	assign _zz_memory_DivPlugin_rs1_2 = {32'h00000000, _zz_memory_DivPlugin_rs1_3};
	assign _zz_memory_DivPlugin_rs2_1 = {31'h00000000, _zz_memory_DivPlugin_rs2_2};
	assign _zz__zz_execute_BranchPlugin_missAlignedTarget_2 = {execute_INSTRUCTION[31], execute_INSTRUCTION[19:12], execute_INSTRUCTION[20], execute_INSTRUCTION[30:21]};
	assign _zz__zz_execute_BranchPlugin_missAlignedTarget_4 = {execute_INSTRUCTION[31], execute_INSTRUCTION[7], execute_INSTRUCTION[30:25], execute_INSTRUCTION[11:8]};
	assign _zz__zz_execute_BranchPlugin_missAlignedTarget_6 = {_zz_execute_BranchPlugin_missAlignedTarget_1, execute_INSTRUCTION[31:20]};
	assign _zz__zz_execute_BranchPlugin_missAlignedTarget_6_1 = {_zz_execute_BranchPlugin_missAlignedTarget_3, execute_INSTRUCTION[31], execute_INSTRUCTION[19:12], execute_INSTRUCTION[20], execute_INSTRUCTION[30:21], 1'b0};
	assign _zz__zz_execute_BranchPlugin_missAlignedTarget_6_2 = {_zz_execute_BranchPlugin_missAlignedTarget_5, execute_INSTRUCTION[31], execute_INSTRUCTION[7], execute_INSTRUCTION[30:25], execute_INSTRUCTION[11:8], 1'b0};
	assign _zz__zz_execute_BranchPlugin_branch_src2_2 = {execute_INSTRUCTION[31], execute_INSTRUCTION[19:12], execute_INSTRUCTION[20], execute_INSTRUCTION[30:21]};
	assign _zz__zz_execute_BranchPlugin_branch_src2_4 = {execute_INSTRUCTION[31], execute_INSTRUCTION[7], execute_INSTRUCTION[30:25], execute_INSTRUCTION[11:8]};
	assign _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1_1 = _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code - 2'h1;
	assign _zz_IBusCachedPlugin_jump_pcLoad_payload_7 = {_zz_IBusCachedPlugin_jump_pcLoad_payload_3, _zz_IBusCachedPlugin_jump_pcLoad_payload_5, _zz_IBusCachedPlugin_jump_pcLoad_payload_4};
	assign _zz_writeBack_DBusCachedPlugin_rspShifted_1 = dataCache_1_io_cpu_writeBack_address[2:0];
	assign _zz_writeBack_DBusCachedPlugin_rspShifted_3 = dataCache_1_io_cpu_writeBack_address[2:1];
	assign _zz_writeBack_DBusCachedPlugin_rspShifted_5 = dataCache_1_io_cpu_writeBack_address[2];
	assign _zz_writeBack_DBusCachedPlugin_rspShifted_7 = dataCache_1_io_cpu_writeBack_address[2];
	assign _zz_decode_LEGAL_INSTRUCTION_3 = (decode_INSTRUCTION & 32'h0000407f) == 32'h00004063;
	assign _zz_decode_LEGAL_INSTRUCTION_4 = (decode_INSTRUCTION & 32'h0000207f) == 32'h00002013;
	assign _zz_decode_LEGAL_INSTRUCTION_5 = {(decode_INSTRUCTION & 32'h0000605f) == 32'h00002007, (decode_INSTRUCTION & 32'h0000705b) == 32'h00002003, (decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_6) == 32'h00000013, _zz_decode_LEGAL_INSTRUCTION_7 == _zz_decode_LEGAL_INSTRUCTION_8, _zz_decode_LEGAL_INSTRUCTION_9, _zz_decode_LEGAL_INSTRUCTION_10, _zz_decode_LEGAL_INSTRUCTION_11};
	assign _zz_decode_LEGAL_INSTRUCTION_9 = (decode_INSTRUCTION & 32'h0000207f) == 32'h00000003;
	assign _zz_decode_LEGAL_INSTRUCTION_10 = (decode_INSTRUCTION & 32'h0000707b) == 32'h00000063;
	assign _zz_decode_LEGAL_INSTRUCTION_11 = {(decode_INSTRUCTION & 32'h0000607f) == 32'h0000000f, (decode_INSTRUCTION & 32'he400007f) == 32'h00000053, (decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_12) == 32'h00000033, _zz_decode_LEGAL_INSTRUCTION_13 == _zz_decode_LEGAL_INSTRUCTION_14, _zz_decode_LEGAL_INSTRUCTION_15, _zz_decode_LEGAL_INSTRUCTION_16, _zz_decode_LEGAL_INSTRUCTION_17};
	assign _zz_decode_LEGAL_INSTRUCTION_15 = (decode_INSTRUCTION & 32'h7c00507f) == 32'h20000053;
	assign _zz_decode_LEGAL_INSTRUCTION_16 = (decode_INSTRUCTION & 32'hf400607f) == 32'h20000053;
	assign _zz_decode_LEGAL_INSTRUCTION_17 = {(decode_INSTRUCTION & 32'h01f0707f) == 32'h0000500f, (decode_INSTRUCTION & 32'hbe00705f) == 32'h00005013, (decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_18) == 32'h00001013, _zz_decode_LEGAL_INSTRUCTION_19 == _zz_decode_LEGAL_INSTRUCTION_20, _zz_decode_LEGAL_INSTRUCTION_21, _zz_decode_LEGAL_INSTRUCTION_22, _zz_decode_LEGAL_INSTRUCTION_23};
	assign _zz_decode_LEGAL_INSTRUCTION_21 = (decode_INSTRUCTION & 32'hbe00707f) == 32'h00000033;
	assign _zz_decode_LEGAL_INSTRUCTION_22 = (decode_INSTRUCTION & 32'hfdf0007f) == 32'h58000053;
	assign _zz_decode_LEGAL_INSTRUCTION_23 = {(decode_INSTRUCTION & 32'h7ff0007f) == 32'h42000053, (decode_INSTRUCTION & 32'h7ff0007f) == 32'h40100053, (decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_24) == 32'he0001053, _zz_decode_LEGAL_INSTRUCTION_25 == _zz_decode_LEGAL_INSTRUCTION_26, _zz_decode_LEGAL_INSTRUCTION_27, _zz_decode_LEGAL_INSTRUCTION_28, _zz_decode_LEGAL_INSTRUCTION_29};
	assign _zz_decode_LEGAL_INSTRUCTION_27 = (decode_INSTRUCTION & 32'hfe007fff) == 32'h12000073;
	assign _zz_decode_LEGAL_INSTRUCTION_28 = (decode_INSTRUCTION & 32'hdfffffff) == 32'h10200073;
	assign _zz_decode_LEGAL_INSTRUCTION_29 = {(decode_INSTRUCTION & 32'hffefffff) == 32'h00000073, (decode_INSTRUCTION & 32'hffffffff) == 32'h10500073};
	assign _zz_IBusCachedPlugin_predictionJumpInterface_payload_4 = decode_INSTRUCTION[31];
	assign _zz_IBusCachedPlugin_predictionJumpInterface_payload_5 = decode_INSTRUCTION[31];
	assign _zz_IBusCachedPlugin_predictionJumpInterface_payload_6 = decode_INSTRUCTION[7];
	assign _zz_MmuPlugin_ports_0_cacheHitsCalc = IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31:22];
	assign _zz_MmuPlugin_ports_0_cacheHitsCalc_1 = IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12];
	assign _zz_MmuPlugin_ports_0_cacheHitsCalc_2 = MmuPlugin_ports_0_cache_1_virtualAddress_1 == IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31:22];
	assign _zz_MmuPlugin_ports_0_cacheHitsCalc_3 = MmuPlugin_ports_0_cache_1_virtualAddress_0 == IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12];
	assign _zz_MmuPlugin_ports_0_cacheHitsCalc_4 = MmuPlugin_ports_0_cache_0_virtualAddress_1 == IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31:22];
	assign _zz_MmuPlugin_ports_0_cacheHitsCalc_5 = MmuPlugin_ports_0_cache_0_virtualAddress_0 == IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12];
	assign _zz_MmuPlugin_ports_1_cacheHitsCalc = DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31:22];
	assign _zz_MmuPlugin_ports_1_cacheHitsCalc_1 = DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12];
	assign _zz_MmuPlugin_ports_1_cacheHitsCalc_2 = MmuPlugin_ports_1_cache_1_virtualAddress_1 == DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31:22];
	assign _zz_MmuPlugin_ports_1_cacheHitsCalc_3 = MmuPlugin_ports_1_cache_1_virtualAddress_0 == DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12];
	assign _zz_MmuPlugin_ports_1_cacheHitsCalc_4 = MmuPlugin_ports_1_cache_0_virtualAddress_1 == DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31:22];
	assign _zz_MmuPlugin_ports_1_cacheHitsCalc_5 = MmuPlugin_ports_1_cache_0_virtualAddress_0 == DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12];
	assign _zz__zz_decode_IS_CSR_1 = (decode_INSTRUCTION & 32'h12203034) == 32'h10000030;
	assign _zz__zz_decode_IS_CSR_3 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_4) == 32'h10000030;
	assign _zz__zz_decode_IS_CSR_5 = {_zz__zz_decode_IS_CSR_6 == _zz__zz_decode_IS_CSR_7, _zz__zz_decode_IS_CSR_8 == _zz__zz_decode_IS_CSR_9};
	assign _zz__zz_decode_IS_CSR_10 = |{_zz_decode_IS_CSR_9, _zz__zz_decode_IS_CSR_11};
	assign _zz__zz_decode_IS_CSR_12 = |_zz__zz_decode_IS_CSR_13;
	assign _zz__zz_decode_IS_CSR_14 = {|_zz__zz_decode_IS_CSR_15, _zz__zz_decode_IS_CSR_16, _zz__zz_decode_IS_CSR_17, _zz__zz_decode_IS_CSR_19};
	assign _zz__zz_decode_IS_CSR_11 = (decode_INSTRUCTION & 32'h00002034) == 32'h00000024;
	assign _zz__zz_decode_IS_CSR_13 = (decode_INSTRUCTION & 32'h00000078) == 32'h00000060;
	assign _zz__zz_decode_IS_CSR_16 = |_zz_decode_IS_CSR_13;
	assign _zz__zz_decode_IS_CSR_17 = |((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_18) == 32'h02004020);
	assign _zz__zz_decode_IS_CSR_19 = {|(_zz__zz_decode_IS_CSR_20 == _zz__zz_decode_IS_CSR_21), |_zz__zz_decode_IS_CSR_22, |_zz__zz_decode_IS_CSR_23, _zz__zz_decode_IS_CSR_26, _zz__zz_decode_IS_CSR_28, _zz__zz_decode_IS_CSR_31};
	assign _zz__zz_decode_IS_CSR_22 = (decode_INSTRUCTION & 32'h02007054) == 32'h00005010;
	assign _zz__zz_decode_IS_CSR_23 = {(decode_INSTRUCTION & _zz__zz_decode_IS_CSR_24) == 32'h40001010, (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_25) == 32'h00001010};
	assign _zz__zz_decode_IS_CSR_26 = |((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_27) == 32'h00000034);
	assign _zz__zz_decode_IS_CSR_28 = |(_zz__zz_decode_IS_CSR_29 == _zz__zz_decode_IS_CSR_30);
	assign _zz__zz_decode_IS_CSR_31 = {|_zz__zz_decode_IS_CSR_32, |_zz__zz_decode_IS_CSR_33, _zz__zz_decode_IS_CSR_36, _zz__zz_decode_IS_CSR_39, _zz__zz_decode_IS_CSR_47};
	assign _zz__zz_decode_IS_CSR_32 = (decode_INSTRUCTION & 32'h00003000) == 32'h00002000;
	assign _zz__zz_decode_IS_CSR_33 = {(decode_INSTRUCTION & _zz__zz_decode_IS_CSR_34) == 32'h00002000, (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_35) == 32'h00001000};
	assign _zz__zz_decode_IS_CSR_36 = |{_zz_decode_IS_CSR_10, _zz__zz_decode_IS_CSR_37 == _zz__zz_decode_IS_CSR_38};
	assign _zz__zz_decode_IS_CSR_39 = |{_zz_decode_IS_CSR_5, _zz__zz_decode_IS_CSR_40, _zz__zz_decode_IS_CSR_42};
	assign _zz__zz_decode_IS_CSR_47 = {|{_zz__zz_decode_IS_CSR_48, _zz__zz_decode_IS_CSR_50}, |_zz__zz_decode_IS_CSR_63, _zz__zz_decode_IS_CSR_72, _zz__zz_decode_IS_CSR_81, _zz__zz_decode_IS_CSR_94};
	assign _zz__zz_decode_IS_CSR_40 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_41) == 32'h20001010;
	assign _zz__zz_decode_IS_CSR_42 = {_zz__zz_decode_IS_CSR_43 == _zz__zz_decode_IS_CSR_44, _zz__zz_decode_IS_CSR_45 == _zz__zz_decode_IS_CSR_46};
	assign _zz__zz_decode_IS_CSR_48 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_49) == 32'h00001000;
	assign _zz__zz_decode_IS_CSR_50 = {_zz__zz_decode_IS_CSR_51 == _zz__zz_decode_IS_CSR_52, _zz__zz_decode_IS_CSR_53, _zz__zz_decode_IS_CSR_55, _zz__zz_decode_IS_CSR_58};
	assign _zz__zz_decode_IS_CSR_63 = {_zz__zz_decode_IS_CSR_64 == _zz__zz_decode_IS_CSR_65, _zz__zz_decode_IS_CSR_66, _zz__zz_decode_IS_CSR_68, _zz__zz_decode_IS_CSR_71};
	assign _zz__zz_decode_IS_CSR_72 = |{_zz__zz_decode_IS_CSR_73, _zz__zz_decode_IS_CSR_75, _zz__zz_decode_IS_CSR_78};
	assign _zz__zz_decode_IS_CSR_81 = |{_zz__zz_decode_IS_CSR_82, _zz__zz_decode_IS_CSR_85};
	assign _zz__zz_decode_IS_CSR_94 = {|_zz__zz_decode_IS_CSR_95, _zz__zz_decode_IS_CSR_106, _zz__zz_decode_IS_CSR_109, _zz__zz_decode_IS_CSR_119};
	assign _zz__zz_decode_IS_CSR_53 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_54) == 32'h02000040;
	assign _zz__zz_decode_IS_CSR_55 = _zz__zz_decode_IS_CSR_56 == _zz__zz_decode_IS_CSR_57;
	assign _zz__zz_decode_IS_CSR_58 = {_zz__zz_decode_IS_CSR_59, _zz__zz_decode_IS_CSR_61};
	assign _zz__zz_decode_IS_CSR_66 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_67) == 32'h18000010;
	assign _zz__zz_decode_IS_CSR_68 = _zz__zz_decode_IS_CSR_69 == _zz__zz_decode_IS_CSR_70;
	assign _zz__zz_decode_IS_CSR_73 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_74) == 32'h80000000;
	assign _zz__zz_decode_IS_CSR_75 = _zz__zz_decode_IS_CSR_76 == _zz__zz_decode_IS_CSR_77;
	assign _zz__zz_decode_IS_CSR_78 = _zz__zz_decode_IS_CSR_79 == _zz__zz_decode_IS_CSR_80;
	assign _zz__zz_decode_IS_CSR_82 = _zz__zz_decode_IS_CSR_83 == _zz__zz_decode_IS_CSR_84;
	assign _zz__zz_decode_IS_CSR_85 = {_zz__zz_decode_IS_CSR_86, _zz__zz_decode_IS_CSR_88, _zz__zz_decode_IS_CSR_91};
	assign _zz__zz_decode_IS_CSR_95 = {_zz_decode_IS_CSR_11, _zz__zz_decode_IS_CSR_96, _zz__zz_decode_IS_CSR_99};
	assign _zz__zz_decode_IS_CSR_106 = |{_zz__zz_decode_IS_CSR_107, _zz__zz_decode_IS_CSR_108};
	assign _zz__zz_decode_IS_CSR_109 = |_zz__zz_decode_IS_CSR_110;
	assign _zz__zz_decode_IS_CSR_119 = {_zz__zz_decode_IS_CSR_120, _zz__zz_decode_IS_CSR_127, _zz__zz_decode_IS_CSR_129};
	assign _zz__zz_decode_IS_CSR_59 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_60) == 32'h02000000;
	assign _zz__zz_decode_IS_CSR_61 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_62) == 32'h40000010;
	assign _zz__zz_decode_IS_CSR_86 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_87) == 32'h00000010;
	assign _zz__zz_decode_IS_CSR_88 = _zz__zz_decode_IS_CSR_89 == _zz__zz_decode_IS_CSR_90;
	assign _zz__zz_decode_IS_CSR_91 = _zz__zz_decode_IS_CSR_92 == _zz__zz_decode_IS_CSR_93;
	assign _zz__zz_decode_IS_CSR_96 = _zz__zz_decode_IS_CSR_97 == _zz__zz_decode_IS_CSR_98;
	assign _zz__zz_decode_IS_CSR_99 = {_zz_decode_IS_CSR_12, _zz__zz_decode_IS_CSR_100, _zz__zz_decode_IS_CSR_103};
	assign _zz__zz_decode_IS_CSR_110 = {_zz__zz_decode_IS_CSR_111, _zz__zz_decode_IS_CSR_113, _zz__zz_decode_IS_CSR_116};
	assign _zz__zz_decode_IS_CSR_120 = |{_zz__zz_decode_IS_CSR_121, _zz__zz_decode_IS_CSR_124};
	assign _zz__zz_decode_IS_CSR_127 = |_zz__zz_decode_IS_CSR_128;
	assign _zz__zz_decode_IS_CSR_129 = {_zz__zz_decode_IS_CSR_130, _zz__zz_decode_IS_CSR_132, _zz__zz_decode_IS_CSR_138};
	assign _zz__zz_decode_IS_CSR_100 = _zz__zz_decode_IS_CSR_101 == _zz__zz_decode_IS_CSR_102;
	assign _zz__zz_decode_IS_CSR_103 = _zz__zz_decode_IS_CSR_104 == _zz__zz_decode_IS_CSR_105;
	assign _zz__zz_decode_IS_CSR_111 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_112) == 32'h10000000;
	assign _zz__zz_decode_IS_CSR_113 = _zz__zz_decode_IS_CSR_114 == _zz__zz_decode_IS_CSR_115;
	assign _zz__zz_decode_IS_CSR_116 = _zz__zz_decode_IS_CSR_117 == _zz__zz_decode_IS_CSR_118;
	assign _zz__zz_decode_IS_CSR_121 = _zz__zz_decode_IS_CSR_122 == _zz__zz_decode_IS_CSR_123;
	assign _zz__zz_decode_IS_CSR_124 = _zz__zz_decode_IS_CSR_125 == _zz__zz_decode_IS_CSR_126;
	assign _zz__zz_decode_IS_CSR_130 = |_zz__zz_decode_IS_CSR_131;
	assign _zz__zz_decode_IS_CSR_132 = |_zz__zz_decode_IS_CSR_133;
	assign _zz__zz_decode_IS_CSR_138 = {_zz__zz_decode_IS_CSR_139, _zz__zz_decode_IS_CSR_152, _zz__zz_decode_IS_CSR_153};
	assign _zz__zz_decode_IS_CSR_131 = (decode_INSTRUCTION & 32'h00004048) == 32'h00004008;
	assign _zz__zz_decode_IS_CSR_133 = {_zz__zz_decode_IS_CSR_134 == _zz__zz_decode_IS_CSR_135, _zz__zz_decode_IS_CSR_136 == _zz__zz_decode_IS_CSR_137};
	assign _zz__zz_decode_IS_CSR_139 = |{_zz__zz_decode_IS_CSR_140, _zz__zz_decode_IS_CSR_141, _zz__zz_decode_IS_CSR_143};
	assign _zz__zz_decode_IS_CSR_152 = |_zz_decode_IS_CSR_11;
	assign _zz__zz_decode_IS_CSR_153 = {|_zz__zz_decode_IS_CSR_154, _zz__zz_decode_IS_CSR_165, _zz__zz_decode_IS_CSR_178, _zz__zz_decode_IS_CSR_193};
	assign _zz__zz_decode_IS_CSR_140 = (decode_INSTRUCTION & 32'h00000030) == 32'h00000020;
	assign _zz__zz_decode_IS_CSR_141 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_142) == 32'h00001060;
	assign _zz__zz_decode_IS_CSR_143 = {_zz__zz_decode_IS_CSR_144 == _zz__zz_decode_IS_CSR_145, _zz__zz_decode_IS_CSR_146, _zz__zz_decode_IS_CSR_148, _zz__zz_decode_IS_CSR_149};
	assign _zz__zz_decode_IS_CSR_154 = {_zz_decode_IS_CSR_10, _zz__zz_decode_IS_CSR_155, _zz__zz_decode_IS_CSR_157, _zz__zz_decode_IS_CSR_160};
	assign _zz__zz_decode_IS_CSR_165 = |{_zz_decode_IS_CSR_10, _zz__zz_decode_IS_CSR_166, _zz__zz_decode_IS_CSR_169};
	assign _zz__zz_decode_IS_CSR_178 = |{_zz__zz_decode_IS_CSR_179, _zz__zz_decode_IS_CSR_180};
	assign _zz__zz_decode_IS_CSR_193 = {|_zz__zz_decode_IS_CSR_194, _zz__zz_decode_IS_CSR_199, _zz__zz_decode_IS_CSR_204, _zz__zz_decode_IS_CSR_208};
	assign _zz__zz_decode_IS_CSR_146 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_147) == 32'h00000060;
	assign _zz__zz_decode_IS_CSR_149 = _zz__zz_decode_IS_CSR_150 == _zz__zz_decode_IS_CSR_151;
	assign _zz__zz_decode_IS_CSR_155 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_156) == 32'h00004020;
	assign _zz__zz_decode_IS_CSR_157 = _zz__zz_decode_IS_CSR_158 == _zz__zz_decode_IS_CSR_159;
	assign _zz__zz_decode_IS_CSR_160 = {_zz__zz_decode_IS_CSR_161, _zz__zz_decode_IS_CSR_163};
	assign _zz__zz_decode_IS_CSR_166 = _zz__zz_decode_IS_CSR_167 == _zz__zz_decode_IS_CSR_168;
	assign _zz__zz_decode_IS_CSR_169 = {_zz__zz_decode_IS_CSR_170, _zz__zz_decode_IS_CSR_172, _zz__zz_decode_IS_CSR_175};
	assign _zz__zz_decode_IS_CSR_180 = {_zz__zz_decode_IS_CSR_181, _zz__zz_decode_IS_CSR_183, _zz__zz_decode_IS_CSR_186};
	assign _zz__zz_decode_IS_CSR_194 = {_zz_decode_IS_CSR_5, _zz__zz_decode_IS_CSR_195, _zz__zz_decode_IS_CSR_196};
	assign _zz__zz_decode_IS_CSR_199 = |{_zz__zz_decode_IS_CSR_200, _zz__zz_decode_IS_CSR_201};
	assign _zz__zz_decode_IS_CSR_204 = |_zz__zz_decode_IS_CSR_205;
	assign _zz__zz_decode_IS_CSR_208 = {_zz__zz_decode_IS_CSR_209, _zz__zz_decode_IS_CSR_212, _zz__zz_decode_IS_CSR_227};
	assign _zz__zz_decode_IS_CSR_161 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_162) == 32'h00000020;
	assign _zz__zz_decode_IS_CSR_163 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_164) == 32'h00000010;
	assign _zz__zz_decode_IS_CSR_170 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_171) == 32'h00002020;
	assign _zz__zz_decode_IS_CSR_172 = _zz__zz_decode_IS_CSR_173 == _zz__zz_decode_IS_CSR_174;
	assign _zz__zz_decode_IS_CSR_175 = _zz__zz_decode_IS_CSR_176 == _zz__zz_decode_IS_CSR_177;
	assign _zz__zz_decode_IS_CSR_181 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_182) == 32'h00000010;
	assign _zz__zz_decode_IS_CSR_183 = _zz__zz_decode_IS_CSR_184 == _zz__zz_decode_IS_CSR_185;
	assign _zz__zz_decode_IS_CSR_186 = {_zz__zz_decode_IS_CSR_187, _zz__zz_decode_IS_CSR_189, _zz__zz_decode_IS_CSR_190};
	assign _zz__zz_decode_IS_CSR_196 = {_zz_decode_IS_CSR_7, _zz__zz_decode_IS_CSR_197};
	assign _zz__zz_decode_IS_CSR_201 = {_zz__zz_decode_IS_CSR_202, _zz_decode_IS_CSR_7};
	assign _zz__zz_decode_IS_CSR_205 = _zz__zz_decode_IS_CSR_206 == _zz__zz_decode_IS_CSR_207;
	assign _zz__zz_decode_IS_CSR_209 = |_zz__zz_decode_IS_CSR_210;
	assign _zz__zz_decode_IS_CSR_212 = |_zz__zz_decode_IS_CSR_213;
	assign _zz__zz_decode_IS_CSR_227 = {_zz__zz_decode_IS_CSR_228, _zz__zz_decode_IS_CSR_229, _zz__zz_decode_IS_CSR_235};
	assign _zz__zz_decode_IS_CSR_187 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_188) == 32'h00002030;
	assign _zz__zz_decode_IS_CSR_190 = {_zz__zz_decode_IS_CSR_191, _zz__zz_decode_IS_CSR_192};
	assign _zz__zz_decode_IS_CSR_197 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_198) == 32'h00000020;
	assign _zz__zz_decode_IS_CSR_202 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_203) == 32'h00000000;
	assign _zz__zz_decode_IS_CSR_210 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_211) == 32'h00002010;
	assign _zz__zz_decode_IS_CSR_213 = {_zz__zz_decode_IS_CSR_214, _zz__zz_decode_IS_CSR_215, _zz__zz_decode_IS_CSR_217};
	assign _zz__zz_decode_IS_CSR_228 = |_zz_decode_IS_CSR_6;
	assign _zz__zz_decode_IS_CSR_229 = |_zz__zz_decode_IS_CSR_230;
	assign _zz__zz_decode_IS_CSR_235 = {_zz__zz_decode_IS_CSR_236, _zz__zz_decode_IS_CSR_240, _zz__zz_decode_IS_CSR_243};
	assign _zz__zz_decode_IS_CSR_191 = (decode_INSTRUCTION & 32'h00002024) == 32'h00000024;
	assign _zz__zz_decode_IS_CSR_192 = (decode_INSTRUCTION & 32'h00000064) == 32'h00000000;
	assign _zz__zz_decode_IS_CSR_214 = (decode_INSTRUCTION & 32'h00000044) == 32'h00000000;
	assign _zz__zz_decode_IS_CSR_215 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_216) == 32'h00000020;
	assign _zz__zz_decode_IS_CSR_217 = {_zz__zz_decode_IS_CSR_218 == _zz__zz_decode_IS_CSR_219, _zz_decode_IS_CSR_6, _zz__zz_decode_IS_CSR_220, _zz__zz_decode_IS_CSR_222};
	assign _zz__zz_decode_IS_CSR_230 = {_zz__zz_decode_IS_CSR_231 == _zz__zz_decode_IS_CSR_232, _zz__zz_decode_IS_CSR_233, _zz__zz_decode_IS_CSR_234};
	assign _zz__zz_decode_IS_CSR_236 = |{_zz_decode_IS_CSR_5, _zz__zz_decode_IS_CSR_237, _zz__zz_decode_IS_CSR_238};
	assign _zz__zz_decode_IS_CSR_240 = |{_zz__zz_decode_IS_CSR_241, _zz__zz_decode_IS_CSR_242};
	assign _zz__zz_decode_IS_CSR_243 = {|_zz__zz_decode_IS_CSR_244, |_zz__zz_decode_IS_CSR_245};
	assign _zz__zz_decode_IS_CSR_220 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_221) == 32'h00002020;
	assign _zz__zz_decode_IS_CSR_222 = {_zz__zz_decode_IS_CSR_223 == _zz__zz_decode_IS_CSR_224, _zz__zz_decode_IS_CSR_225 == _zz__zz_decode_IS_CSR_226};
	assign _zz__zz_decode_IS_CSR_233 = (decode_INSTRUCTION & 32'h00002014) == 32'h00002010;
	assign _zz__zz_decode_IS_CSR_234 = (decode_INSTRUCTION & 32'h40000034) == 32'h40000030;
	assign _zz__zz_decode_IS_CSR_238 = (decode_INSTRUCTION & _zz__zz_decode_IS_CSR_239) == 32'h00000004;
	assign _zz__zz_decode_IS_CSR_244 = {_zz_decode_IS_CSR_1, _zz_decode_IS_CSR_2};
	assign _zz_execute_BranchPlugin_branch_src2_6 = execute_INSTRUCTION[31];
	assign _zz_execute_BranchPlugin_branch_src2_7 = execute_INSTRUCTION[31];
	assign _zz_execute_BranchPlugin_branch_src2_8 = execute_INSTRUCTION[7];
	assign memory_MUL_LOW = _zz_memory_MUL_LOW + _zz_memory_MUL_LOW_7;
	assign execute_BRANCH_CALC = {execute_BranchPlugin_branchAdder[31:1], 1'b0};
	assign execute_MUL_HH = $signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh);
	assign execute_MUL_HL = $signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow);
	assign execute_MUL_LH = $signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh);
	assign execute_MUL_LL = {16'h0000, execute_MulPlugin_aULow} * {16'h0000, execute_MulPlugin_bULow};
	assign decode_CSR_READ_OPCODE = decode_INSTRUCTION[13:7] != 7'h20;
	assign decode_CSR_WRITE_OPCODE = ~|(((decode_INSTRUCTION[14:13] == 2'h1) & (decode_INSTRUCTION[19:15] == 5'h00)) | ((decode_INSTRUCTION[14:13] == 2'h3) & (decode_INSTRUCTION[19:15] == 5'h00)));
	assign decode_IS_CSR = _zz_decode_IS_CSR[41];
	assign decode_IS_RS2_SIGNED = _zz_decode_IS_CSR[38];
	assign decode_IS_RS1_SIGNED = _zz_decode_IS_CSR[37];
	assign decode_IS_DIV = _zz_decode_IS_CSR[36];
	assign decode_IS_MUL = _zz_decode_IS_CSR[35];
	assign decode_SRC_LESS_UNSIGNED = _zz_decode_IS_CSR[29];
	assign decode_FPU_RSP = _zz_decode_IS_CSR[21];
	assign decode_FPU_COMMIT = _zz_decode_IS_CSR[20];
	assign decode_IS_SFENCE_VMA2 = _zz_decode_IS_CSR[18];
	assign decode_MEMORY_MANAGMENT = _zz_decode_IS_CSR[17];
	assign decode_MEMORY_WR = _zz_decode_IS_CSR[14];
	assign decode_BYPASSABLE_MEMORY_STAGE = _zz_decode_IS_CSR[13];
	assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_decode_IS_CSR[12];
	assign decode_RESCHEDULE_NEXT = _zz_decode_IS_CSR[1];
	assign decode_FPU_COMMIT_LOAD = decode_FPU_OPCODE == FpuOpcode_LOAD;
	assign decode_FORMAL_PC_NEXT = decode_PC + 32'h00000004;
	assign decode_RS2_USE = _zz_decode_IS_CSR[16];
	assign decode_RS1_USE = _zz_decode_IS_CSR[6];
	assign decode_SRC_USE_SUB_LESS = _zz_decode_IS_CSR[4];
	assign decode_SRC_ADD_ZERO = _zz_decode_IS_CSR[32];
	assign decode_INSTRUCTION_ANTICIPATED = (decode_arbitration_isStuck ? decode_INSTRUCTION : IBusCachedPlugin_iBusRsp_output_payload_rsp_inst);
	assign decode_FPU_ARG = _zz_decode_IS_CSR[28:27];
	assign decode_MEMORY_ENABLE = _zz_decode_IS_CSR[5];
	assign decode_FLUSH_ALL = _zz_decode_IS_CSR[0];
	assign IBusCachedPlugin_externalFlush = {writeBack_arbitration_flushNext, memory_arbitration_flushNext, execute_arbitration_flushNext, decode_arbitration_flushNext} != 4'h0;
	assign IBusCachedPlugin_jump_pcLoad_valid = {CsrPlugin_redoInterface_valid, CsrPlugin_jumpInterface_valid, BranchPlugin_jumpInterface_valid, DBusCachedPlugin_redoBranch_valid, IBusCachedPlugin_predictionJumpInterface_valid} != 5'h00;
	assign _zz_IBusCachedPlugin_jump_pcLoad_payload = {IBusCachedPlugin_predictionJumpInterface_valid, CsrPlugin_redoInterface_valid, BranchPlugin_jumpInterface_valid, CsrPlugin_jumpInterface_valid, DBusCachedPlugin_redoBranch_valid};
	assign _zz_IBusCachedPlugin_jump_pcLoad_payload_2 = _zz_IBusCachedPlugin_jump_pcLoad_payload_1[3];
	assign _zz_IBusCachedPlugin_jump_pcLoad_payload_3 = _zz_IBusCachedPlugin_jump_pcLoad_payload_1[4];
	assign _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready = ~|IBusCachedPlugin_iBusRsp_stages_0_halt;
	assign _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready = ~|IBusCachedPlugin_iBusRsp_stages_1_halt;
	assign when_Fetcher_l322 = ~|IBusCachedPlugin_pcValids_0;
	assign when_Fetcher_l331 = ~|(~|IBusCachedPlugin_iBusRsp_stages_1_input_ready);
	assign when_Fetcher_l331_1 = ~|(~|IBusCachedPlugin_injector_decodeInput_ready);
	assign when_Fetcher_l331_2 = ~|execute_arbitration_isStuck;
	assign when_Fetcher_l331_3 = ~|memory_arbitration_isStuck;
	assign when_Fetcher_l331_4 = ~|writeBack_arbitration_isStuck;
	assign IBusCachedPlugin_injector_decodeInput_ready = ~|decode_arbitration_isStuck;
	assign _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch = _zz__zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch[11];
	assign _zz_2 = _zz__zz_2[19];
	assign _zz_4 = _zz__zz_4[11];
	assign _zz_IBusCachedPlugin_predictionJumpInterface_payload = _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload[19];
	assign _zz_IBusCachedPlugin_predictionJumpInterface_payload_2 = _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload_2[11];
	assign IBusCachedPlugin_predictionJumpInterface_payload = decode_PC + (decode_BRANCH_CTRL == BranchCtrlEnum_JAL ? {_zz_IBusCachedPlugin_predictionJumpInterface_payload_1, _zz_IBusCachedPlugin_predictionJumpInterface_payload_4, decode_INSTRUCTION[19:12], decode_INSTRUCTION[20], decode_INSTRUCTION[30:21], 1'b0} : {_zz_IBusCachedPlugin_predictionJumpInterface_payload_3, _zz_IBusCachedPlugin_predictionJumpInterface_payload_5, _zz_IBusCachedPlugin_predictionJumpInterface_payload_6, decode_INSTRUCTION[30:25], decode_INSTRUCTION[11:8], 1'b0});
	assign IBusCachedPlugin_cache_io_cpu_fetch_isStuck = ~|IBusCachedPlugin_iBusRsp_stages_1_input_ready;
	assign IBusCachedPlugin_mmuBus_cmd_0_isStuck = ~|IBusCachedPlugin_iBusRsp_stages_1_input_ready;
	assign IBusCachedPlugin_cache_io_cpu_fetch_isUser = CsrPlugin_privilege == 2'h0;
	assign IBusCachedPlugin_decodeExceptionPort_payload_badAddr = {IBusCachedPlugin_iBusRsp_stages_1_input_payload[31:2], 2'h0};
	assign dataCache_1_io_mem_cmd_ready = ~|toplevel_dataCache_1_io_mem_cmd_rValid;
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_wr = (toplevel_dataCache_1_io_mem_cmd_rValid ? toplevel_dataCache_1_io_mem_cmd_rData_wr : dataCache_1_io_mem_cmd_payload_wr);
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_uncached = (toplevel_dataCache_1_io_mem_cmd_rValid ? toplevel_dataCache_1_io_mem_cmd_rData_uncached : dataCache_1_io_mem_cmd_payload_uncached);
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_address = (toplevel_dataCache_1_io_mem_cmd_rValid ? toplevel_dataCache_1_io_mem_cmd_rData_address : dataCache_1_io_mem_cmd_payload_address);
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_data = (toplevel_dataCache_1_io_mem_cmd_rValid ? toplevel_dataCache_1_io_mem_cmd_rData_data : dataCache_1_io_mem_cmd_payload_data);
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_mask = (toplevel_dataCache_1_io_mem_cmd_rValid ? toplevel_dataCache_1_io_mem_cmd_rData_mask : dataCache_1_io_mem_cmd_payload_mask);
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_size = (toplevel_dataCache_1_io_mem_cmd_rValid ? toplevel_dataCache_1_io_mem_cmd_rData_size : dataCache_1_io_mem_cmd_payload_size);
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_last = (toplevel_dataCache_1_io_mem_cmd_rValid ? toplevel_dataCache_1_io_mem_cmd_rData_last : dataCache_1_io_mem_cmd_payload_last);
	assign when_Stream_l368 = ~|toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_valid;
	assign execute_DBusCachedPlugin_size = execute_INSTRUCTION[13:12];
	assign dataCache_1_io_cpu_flush_payload_singleLine = execute_INSTRUCTION[19:15] != 5'h00;
	assign dataCache_1_io_cpu_flush_payload_lineId = _zz_io_cpu_flush_payload_lineId[7:0];
	assign dataCache_1_io_cpu_writeBack_isUser = CsrPlugin_privilege == 2'h0;
	assign writeBack_DBusCachedPlugin_rspSplits_0 = writeBack_DBusCachedPlugin_rspData[7:0];
	assign writeBack_DBusCachedPlugin_rspSplits_1 = writeBack_DBusCachedPlugin_rspData[15:8];
	assign writeBack_DBusCachedPlugin_rspSplits_2 = writeBack_DBusCachedPlugin_rspData[23:16];
	assign writeBack_DBusCachedPlugin_rspSplits_3 = writeBack_DBusCachedPlugin_rspData[31:24];
	assign writeBack_DBusCachedPlugin_rspSplits_4 = writeBack_DBusCachedPlugin_rspData[39:32];
	assign writeBack_DBusCachedPlugin_rspSplits_5 = writeBack_DBusCachedPlugin_rspData[47:40];
	assign writeBack_DBusCachedPlugin_rspSplits_6 = writeBack_DBusCachedPlugin_rspData[55:48];
	assign writeBack_DBusCachedPlugin_rspSplits_7 = writeBack_DBusCachedPlugin_rspData[63:56];
	assign writeBack_DBusCachedPlugin_rspRf = writeBack_DBusCachedPlugin_rspShifted[31:0];
	assign switch_Misc_l226 = writeBack_INSTRUCTION[13:12];
	assign when_DBusCachedPlugin_l592 = {writeBack_arbitration_isValid | CsrPlugin_exceptionPendings_3, memory_arbitration_isValid | CsrPlugin_exceptionPendings_2, execute_arbitration_isValid | CsrPlugin_exceptionPendings_1} == 3'h0;
	assign when_DBusCachedPlugin_l593 = ~|dataCache_1_io_cpu_execute_refilling;
	assign when_MmuPlugin_l132 = CsrPlugin_privilege == 2'h3;
	assign MmuPlugin_ports_0_cacheHitsCalc = {(MmuPlugin_ports_0_cache_3_valid & (MmuPlugin_ports_0_cache_3_virtualAddress_1 == IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31:22])) & (MmuPlugin_ports_0_cache_3_superPage | (MmuPlugin_ports_0_cache_3_virtualAddress_0 == IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12])), (MmuPlugin_ports_0_cache_2_valid & (MmuPlugin_ports_0_cache_2_virtualAddress_1 == _zz_MmuPlugin_ports_0_cacheHitsCalc)) & (MmuPlugin_ports_0_cache_2_superPage | (MmuPlugin_ports_0_cache_2_virtualAddress_0 == _zz_MmuPlugin_ports_0_cacheHitsCalc_1)), (MmuPlugin_ports_0_cache_1_valid & _zz_MmuPlugin_ports_0_cacheHitsCalc_2) & (MmuPlugin_ports_0_cache_1_superPage | _zz_MmuPlugin_ports_0_cacheHitsCalc_3), (MmuPlugin_ports_0_cache_0_valid & _zz_MmuPlugin_ports_0_cacheHitsCalc_4) & (MmuPlugin_ports_0_cache_0_superPage | _zz_MmuPlugin_ports_0_cacheHitsCalc_5)};
	assign MmuPlugin_ports_0_cacheHit = |MmuPlugin_ports_0_cacheHitsCalc;
	assign _zz_MmuPlugin_ports_0_cacheLine_valid = MmuPlugin_ports_0_cacheHitsCalc[3];
	assign _zz_MmuPlugin_ports_0_cacheLine_valid_3 = {_zz_MmuPlugin_ports_0_cacheLine_valid_2, _zz_MmuPlugin_ports_0_cacheLine_valid_1};
	assign MmuPlugin_ports_0_entryToReplace_willOverflowIfInc = MmuPlugin_ports_0_entryToReplace_value == 2'h3;
	assign IBusCachedPlugin_mmuBus_rsp_isIoAccess = IBusCachedPlugin_mmuBus_rsp_physicalAddress[31:28] == 4'hf;
	assign IBusCachedPlugin_mmuBus_rsp_bypassTranslation = ~|MmuPlugin_ports_0_requireMmuLockupCalc;
	assign IBusCachedPlugin_mmuBus_rsp_ways_0_sel = MmuPlugin_ports_0_cacheHitsCalc[0];
	assign IBusCachedPlugin_mmuBus_rsp_ways_0_physical = {MmuPlugin_ports_0_cache_0_physicalAddress_1, (MmuPlugin_ports_0_cache_0_superPage ? IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12] : MmuPlugin_ports_0_cache_0_physicalAddress_0), IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[11:0]};
	assign IBusCachedPlugin_mmuBus_rsp_ways_1_sel = MmuPlugin_ports_0_cacheHitsCalc[1];
	assign IBusCachedPlugin_mmuBus_rsp_ways_1_physical = {MmuPlugin_ports_0_cache_1_physicalAddress_1, (MmuPlugin_ports_0_cache_1_superPage ? IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12] : MmuPlugin_ports_0_cache_1_physicalAddress_0), IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[11:0]};
	assign IBusCachedPlugin_mmuBus_rsp_ways_2_sel = MmuPlugin_ports_0_cacheHitsCalc[2];
	assign IBusCachedPlugin_mmuBus_rsp_ways_2_physical = {MmuPlugin_ports_0_cache_2_physicalAddress_1, (MmuPlugin_ports_0_cache_2_superPage ? IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12] : MmuPlugin_ports_0_cache_2_physicalAddress_0), IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[11:0]};
	assign IBusCachedPlugin_mmuBus_rsp_ways_3_sel = MmuPlugin_ports_0_cacheHitsCalc[3];
	assign IBusCachedPlugin_mmuBus_rsp_ways_3_physical = {MmuPlugin_ports_0_cache_3_physicalAddress_1, (MmuPlugin_ports_0_cache_3_superPage ? IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12] : MmuPlugin_ports_0_cache_3_physicalAddress_0), IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[11:0]};
	assign when_MmuPlugin_l132_1 = CsrPlugin_privilege == 2'h3;
	assign MmuPlugin_ports_1_cacheHitsCalc = {(MmuPlugin_ports_1_cache_3_valid & (MmuPlugin_ports_1_cache_3_virtualAddress_1 == DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31:22])) & (MmuPlugin_ports_1_cache_3_superPage | (MmuPlugin_ports_1_cache_3_virtualAddress_0 == DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12])), (MmuPlugin_ports_1_cache_2_valid & (MmuPlugin_ports_1_cache_2_virtualAddress_1 == _zz_MmuPlugin_ports_1_cacheHitsCalc)) & (MmuPlugin_ports_1_cache_2_superPage | (MmuPlugin_ports_1_cache_2_virtualAddress_0 == _zz_MmuPlugin_ports_1_cacheHitsCalc_1)), (MmuPlugin_ports_1_cache_1_valid & _zz_MmuPlugin_ports_1_cacheHitsCalc_2) & (MmuPlugin_ports_1_cache_1_superPage | _zz_MmuPlugin_ports_1_cacheHitsCalc_3), (MmuPlugin_ports_1_cache_0_valid & _zz_MmuPlugin_ports_1_cacheHitsCalc_4) & (MmuPlugin_ports_1_cache_0_superPage | _zz_MmuPlugin_ports_1_cacheHitsCalc_5)};
	assign MmuPlugin_ports_1_cacheHit = |MmuPlugin_ports_1_cacheHitsCalc;
	assign _zz_MmuPlugin_ports_1_cacheLine_valid = MmuPlugin_ports_1_cacheHitsCalc[3];
	assign _zz_MmuPlugin_ports_1_cacheLine_valid_3 = {_zz_MmuPlugin_ports_1_cacheLine_valid_2, _zz_MmuPlugin_ports_1_cacheLine_valid_1};
	assign MmuPlugin_ports_1_entryToReplace_willOverflowIfInc = MmuPlugin_ports_1_entryToReplace_value == 2'h3;
	assign DBusCachedPlugin_mmuBus_rsp_isIoAccess = DBusCachedPlugin_mmuBus_rsp_physicalAddress[31:28] == 4'hf;
	assign DBusCachedPlugin_mmuBus_rsp_bypassTranslation = ~|MmuPlugin_ports_1_requireMmuLockupCalc;
	assign DBusCachedPlugin_mmuBus_rsp_ways_0_sel = MmuPlugin_ports_1_cacheHitsCalc[0];
	assign DBusCachedPlugin_mmuBus_rsp_ways_0_physical = {MmuPlugin_ports_1_cache_0_physicalAddress_1, (MmuPlugin_ports_1_cache_0_superPage ? DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12] : MmuPlugin_ports_1_cache_0_physicalAddress_0), DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[11:0]};
	assign DBusCachedPlugin_mmuBus_rsp_ways_1_sel = MmuPlugin_ports_1_cacheHitsCalc[1];
	assign DBusCachedPlugin_mmuBus_rsp_ways_1_physical = {MmuPlugin_ports_1_cache_1_physicalAddress_1, (MmuPlugin_ports_1_cache_1_superPage ? DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12] : MmuPlugin_ports_1_cache_1_physicalAddress_0), DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[11:0]};
	assign DBusCachedPlugin_mmuBus_rsp_ways_2_sel = MmuPlugin_ports_1_cacheHitsCalc[2];
	assign DBusCachedPlugin_mmuBus_rsp_ways_2_physical = {MmuPlugin_ports_1_cache_2_physicalAddress_1, (MmuPlugin_ports_1_cache_2_superPage ? DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12] : MmuPlugin_ports_1_cache_2_physicalAddress_0), DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[11:0]};
	assign DBusCachedPlugin_mmuBus_rsp_ways_3_sel = MmuPlugin_ports_1_cacheHitsCalc[3];
	assign DBusCachedPlugin_mmuBus_rsp_ways_3_physical = {MmuPlugin_ports_1_cache_3_physicalAddress_1, (MmuPlugin_ports_1_cache_3_superPage ? DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12] : MmuPlugin_ports_1_cache_3_physicalAddress_0), DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[11:0]};
	assign MmuPlugin_shared_dBusRsp_pte_V = MmuPlugin_shared_dBusRspStaged_payload_data[0];
	assign MmuPlugin_shared_dBusRsp_pte_R = MmuPlugin_shared_dBusRspStaged_payload_data[1];
	assign MmuPlugin_shared_dBusRsp_pte_W = MmuPlugin_shared_dBusRspStaged_payload_data[2];
	assign MmuPlugin_shared_dBusRsp_pte_X = MmuPlugin_shared_dBusRspStaged_payload_data[3];
	assign MmuPlugin_shared_dBusRsp_pte_U = MmuPlugin_shared_dBusRspStaged_payload_data[4];
	assign MmuPlugin_shared_dBusRsp_pte_G = MmuPlugin_shared_dBusRspStaged_payload_data[5];
	assign MmuPlugin_shared_dBusRsp_pte_A = MmuPlugin_shared_dBusRspStaged_payload_data[6];
	assign MmuPlugin_shared_dBusRsp_pte_D = MmuPlugin_shared_dBusRspStaged_payload_data[7];
	assign MmuPlugin_shared_dBusRsp_pte_RSW = MmuPlugin_shared_dBusRspStaged_payload_data[9:8];
	assign MmuPlugin_shared_dBusRsp_pte_PPN0 = MmuPlugin_shared_dBusRspStaged_payload_data[19:10];
	assign MmuPlugin_shared_dBusRsp_pte_PPN1 = MmuPlugin_shared_dBusRspStaged_payload_data[31:20];
	assign _zz_MmuPlugin_shared_refills = {((DBusCachedPlugin_mmuBus_cmd_0_isValid & MmuPlugin_ports_1_requireMmuLockupCalc) & ~|MmuPlugin_ports_1_dirty) & ~|MmuPlugin_ports_1_cacheHit, ((IBusCachedPlugin_mmuBus_cmd_0_isValid & MmuPlugin_ports_0_requireMmuLockupCalc) & ~|MmuPlugin_ports_0_dirty) & ~|MmuPlugin_ports_0_cacheHit};
	assign when_MmuPlugin_l223 = |MmuPlugin_shared_refills;
	assign _zz_MmuPlugin_shared_vpn_0 = (MmuPlugin_shared_refills[0] ? IBusCachedPlugin_mmuBus_cmd_0_virtualAddress : DBusCachedPlugin_mmuBus_cmd_0_virtualAddress);
	assign when_MmuPlugin_l281 = MmuPlugin_shared_portSortedOh[0];
	assign when_MmuPlugin_l287 = MmuPlugin_ports_0_entryToReplace_value == 2'h0;
	assign when_MmuPlugin_l287_1 = MmuPlugin_ports_0_entryToReplace_value == 2'h1;
	assign when_MmuPlugin_l287_2 = MmuPlugin_ports_0_entryToReplace_value == 2'h2;
	assign when_MmuPlugin_l287_3 = MmuPlugin_ports_0_entryToReplace_value == 2'h3;
	assign when_MmuPlugin_l281_1 = MmuPlugin_shared_portSortedOh[1];
	assign when_MmuPlugin_l287_4 = MmuPlugin_ports_1_entryToReplace_value == 2'h0;
	assign when_MmuPlugin_l287_5 = MmuPlugin_ports_1_entryToReplace_value == 2'h1;
	assign when_MmuPlugin_l287_6 = MmuPlugin_ports_1_entryToReplace_value == 2'h2;
	assign when_MmuPlugin_l287_7 = MmuPlugin_ports_1_entryToReplace_value == 2'h3;
	assign FpuPlugin_hasPending = FpuPlugin_pendings != 6'h00;
	assign FpuPlugin_sd = FpuPlugin_fs == 2'h3;
	assign when_FpuPlugin_l237 = {_zz_when_FpuPlugin_l237_2, _zz_when_FpuPlugin_l237_1, _zz_when_FpuPlugin_l237} != 3'h0;
	assign when_FpuPlugin_l268_1 = ~|decode_arbitration_isStuck;
	assign when_FpuPlugin_l272 = ~|decode_LEGAL_INSTRUCTION;
	assign decode_FpuPlugin_iRoundMode = decode_INSTRUCTION[14:12];
	assign decode_FpuPlugin_roundMode = (decode_INSTRUCTION[14:12] == 3'h7 ? FpuPlugin_rm : decode_INSTRUCTION[14:12]);
	assign FpuPlugin_port_cmd_payload_rs1 = decode_INSTRUCTION[19:15];
	assign FpuPlugin_port_cmd_payload_rs2 = decode_INSTRUCTION[24:20];
	assign FpuPlugin_port_cmd_payload_rs3 = decode_INSTRUCTION[31:27];
	assign FpuPlugin_port_cmd_payload_rd = decode_INSTRUCTION[11:7];
	assign when_FpuPlugin_l306 = ~|writeBack_INSTRUCTION[12];
	assign when_FpuPlugin_l323 = ~|FpuPlugin_port_rsp_valid;
	assign when_FpuPlugin_l325 = ~|writeBack_arbitration_haltItself;
	assign writeBack_FpuPlugin_commit_payload_rd = writeBack_INSTRUCTION[11:7];
	assign writeBack_FpuPlugin_commit_ready = ~|writeBack_FpuPlugin_commit_rValid;
	assign _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode = (writeBack_FpuPlugin_commit_rValid ? writeBack_FpuPlugin_commit_rData_opcode : writeBack_FpuPlugin_commit_payload_opcode);
	assign writeBack_FpuPlugin_commit_s2mPipe_payload_rd = (writeBack_FpuPlugin_commit_rValid ? writeBack_FpuPlugin_commit_rData_rd : writeBack_FpuPlugin_commit_payload_rd);
	assign writeBack_FpuPlugin_commit_s2mPipe_payload_write = (writeBack_FpuPlugin_commit_rValid ? writeBack_FpuPlugin_commit_rData_write : writeBack_FpuPlugin_commit_payload_write);
	assign writeBack_FpuPlugin_commit_s2mPipe_payload_value = (writeBack_FpuPlugin_commit_rValid ? writeBack_FpuPlugin_commit_rData_value : writeBack_FpuPlugin_commit_payload_value);
	assign _zz_decode_IS_CSR_1 = (decode_INSTRUCTION & 32'h00005048) == 32'h00001008;
	assign _zz_decode_IS_CSR_2 = (decode_INSTRUCTION & 32'h12003034) == 32'h12000030;
	assign _zz_decode_IS_CSR_3 = (decode_INSTRUCTION & 32'h00004050) == 32'h00004050;
	assign _zz_decode_IS_CSR_4 = (decode_INSTRUCTION & 32'h00000014) == 32'h00000014;
	assign _zz_decode_IS_CSR_5 = (decode_INSTRUCTION & 32'h00000008) == 32'h00000008;
	assign _zz_decode_IS_CSR_6 = (decode_INSTRUCTION & 32'h00000058) == 32'h00000000;
	assign _zz_decode_IS_CSR_7 = (decode_INSTRUCTION & 32'h00002004) == 32'h00000004;
	assign _zz_decode_IS_CSR_8 = (decode_INSTRUCTION & 32'h90000010) == 32'h80000010;
	assign _zz_decode_IS_CSR_9 = (decode_INSTRUCTION & 32'h00000028) == 32'h00000028;
	assign _zz_decode_IS_CSR_10 = (decode_INSTRUCTION & 32'h00000004) == 32'h00000004;
	assign _zz_decode_IS_CSR_11 = (decode_INSTRUCTION & 32'h00000020) == 32'h00000020;
	assign _zz_decode_IS_CSR_12 = (decode_INSTRUCTION & 32'hc0000010) == 32'h40000010;
	assign _zz_decode_IS_CSR_13 = (decode_INSTRUCTION & 32'h00001000) == 32'h00000000;
	assign _zz_decode_IS_CSR_14 = (decode_INSTRUCTION & 32'h10103070) == 32'h00000070;
	assign _zz_decode_IS_CSR = {|((decode_INSTRUCTION & _zz__zz_decode_IS_CSR) == 32'h00100070), |{_zz_decode_IS_CSR_14, _zz__zz_decode_IS_CSR_1}, |{_zz__zz_decode_IS_CSR_2, _zz__zz_decode_IS_CSR_3}, |_zz__zz_decode_IS_CSR_5, _zz__zz_decode_IS_CSR_10, _zz__zz_decode_IS_CSR_12, _zz__zz_decode_IS_CSR_14};
	assign _zz_decode_SRC1_CTRL_2 = _zz_decode_IS_CSR[3:2];
	assign _zz_decode_ALU_CTRL_2 = _zz_decode_IS_CSR[8:7];
	assign _zz_decode_SRC2_CTRL_2 = _zz_decode_IS_CSR[10:9];
	assign _zz_decode_FPU_ENABLE = _zz_decode_IS_CSR[19];
	assign _zz_decode_FPU_OPCODE_2 = _zz_decode_IS_CSR[25:22];
	assign _zz_decode_FPU_FORMAT_2 = _zz_decode_IS_CSR[26];
	assign _zz_decode_ALU_BITWISE_CTRL_2 = _zz_decode_IS_CSR[31:30];
	assign _zz_decode_SHIFT_CTRL_2 = _zz_decode_IS_CSR[34:33];
	assign _zz_decode_BRANCH_CTRL_2 = _zz_decode_IS_CSR[40:39];
	assign _zz_decode_ENV_CTRL_2 = _zz_decode_IS_CSR[44:42];
	assign when_RegFilePlugin_l63 = decode_INSTRUCTION[11:7] == 5'h00;
	assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19:15];
	assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24:20];
	assign _zz_execute_SRC2 = execute_INSTRUCTION[31];
	assign _zz_execute_SRC2_2 = _zz__zz_execute_SRC2_2[11];
	assign execute_SrcPlugin_less = (execute_SRC1[31] ~^ execute_SRC2[31] ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
	assign execute_FullBarrelShifterPlugin_amplitude = execute_SRC2[4:0];
	assign execute_FullBarrelShifterPlugin_reversed = (execute_SHIFT_CTRL == ShiftCtrlEnum_SLL_1 ? _zz_execute_FullBarrelShifterPlugin_reversed : execute_SRC1);
	assign switch_MulPlugin_l87 = execute_INSTRUCTION[13:12];
	assign execute_MulPlugin_aULow = execute_MulPlugin_a[15:0];
	assign execute_MulPlugin_bULow = execute_MulPlugin_b[15:0];
	assign execute_MulPlugin_aSLow = {1'b0, execute_MulPlugin_a[15:0]};
	assign execute_MulPlugin_bSLow = {1'b0, execute_MulPlugin_b[15:0]};
	assign execute_MulPlugin_aHigh = {execute_MulPlugin_aSigned & execute_MulPlugin_a[31], execute_MulPlugin_a[31:16]};
	assign execute_MulPlugin_bHigh = {execute_MulPlugin_bSigned & execute_MulPlugin_b[31], execute_MulPlugin_b[31:16]};
	assign writeBack_MulPlugin_result = _zz_writeBack_MulPlugin_result + _zz_writeBack_MulPlugin_result_1;
	assign switch_MulPlugin_l148 = writeBack_INSTRUCTION[13:12];
	assign memory_DivPlugin_div_counter_willOverflowIfInc = memory_DivPlugin_div_counter_value == 6'h21;
	assign when_MulDivIterativePlugin_l126 = memory_DivPlugin_div_counter_value == 6'h20;
	assign when_MulDivIterativePlugin_l126_1 = ~|memory_arbitration_isStuck;
	assign _zz_memory_DivPlugin_div_stage_0_remainderShifted = memory_DivPlugin_rs1[31:0];
	assign memory_DivPlugin_div_stage_0_remainderShifted = {memory_DivPlugin_accumulator[31:0], _zz_memory_DivPlugin_div_stage_0_remainderShifted[31]};
	assign memory_DivPlugin_div_stage_0_remainderMinusDenominator = memory_DivPlugin_div_stage_0_remainderShifted - _zz_memory_DivPlugin_div_stage_0_remainderMinusDenominator;
	assign memory_DivPlugin_div_stage_0_outRemainder = (~|memory_DivPlugin_div_stage_0_remainderMinusDenominator[32] ? _zz_memory_DivPlugin_div_stage_0_outRemainder : _zz_memory_DivPlugin_div_stage_0_outRemainder_1);
	assign memory_DivPlugin_div_stage_0_outNumerator = _zz_memory_DivPlugin_div_stage_0_outNumerator[31:0];
	assign when_MulDivIterativePlugin_l151 = memory_DivPlugin_div_counter_value == 6'h20;
	assign _zz_memory_DivPlugin_div_result = (memory_INSTRUCTION[13] ? memory_DivPlugin_accumulator[31:0] : memory_DivPlugin_rs1[31:0]);
	assign when_MulDivIterativePlugin_l162 = ~|memory_arbitration_isStuck;
	assign HazardSimplePlugin_writeBackWrites_payload_address = _zz_lastStageRegFileWrite_payload_address[11:7];
	assign HazardSimplePlugin_addr0Match = HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[19:15];
	assign HazardSimplePlugin_addr1Match = HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[24:20];
	assign when_HazardSimplePlugin_l48 = writeBack_INSTRUCTION[11:7] == decode_INSTRUCTION[19:15];
	assign when_HazardSimplePlugin_l51 = writeBack_INSTRUCTION[11:7] == decode_INSTRUCTION[24:20];
	assign when_HazardSimplePlugin_l48_1 = memory_INSTRUCTION[11:7] == decode_INSTRUCTION[19:15];
	assign when_HazardSimplePlugin_l51_1 = memory_INSTRUCTION[11:7] == decode_INSTRUCTION[24:20];
	assign when_HazardSimplePlugin_l48_2 = execute_INSTRUCTION[11:7] == decode_INSTRUCTION[19:15];
	assign when_HazardSimplePlugin_l51_2 = execute_INSTRUCTION[11:7] == decode_INSTRUCTION[24:20];
	assign when_HazardSimplePlugin_l105 = ~|decode_RS1_USE;
	assign when_HazardSimplePlugin_l108 = ~|decode_RS2_USE;
	assign execute_BranchPlugin_eq = execute_SRC1 == execute_SRC2;
	assign switch_Misc_l226_1 = execute_INSTRUCTION[14:12];
	assign _zz_execute_BranchPlugin_missAlignedTarget = execute_INSTRUCTION[31];
	assign _zz_execute_BranchPlugin_missAlignedTarget_2 = _zz__zz_execute_BranchPlugin_missAlignedTarget_2[19];
	assign _zz_execute_BranchPlugin_missAlignedTarget_4 = _zz__zz_execute_BranchPlugin_missAlignedTarget_4[11];
	assign _zz_execute_BranchPlugin_branch_src2 = execute_INSTRUCTION[31];
	assign _zz_execute_BranchPlugin_branch_src2_2 = _zz__zz_execute_BranchPlugin_branch_src2_2[19];
	assign _zz_execute_BranchPlugin_branch_src2_4 = _zz__zz_execute_BranchPlugin_branch_src2_4[11];
	assign execute_BranchPlugin_branchAdder = execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2;
	assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = (CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped > CsrPlugin_privilege ? CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped : CsrPlugin_privilege);
	assign _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code = {decodeExceptionPort_valid, IBusCachedPlugin_decodeExceptionPort_valid};
	assign _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 = _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1[0];
	assign when_CsrPlugin_l1259 = ~|decode_arbitration_isStuck;
	assign when_CsrPlugin_l1259_1 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1259_2 = ~|memory_arbitration_isStuck;
	assign when_CsrPlugin_l1259_3 = ~|writeBack_arbitration_isStuck;
	assign when_CsrPlugin_l1272 = {CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack, CsrPlugin_exceptionPortCtrl_exceptionValids_memory, CsrPlugin_exceptionPortCtrl_exceptionValids_execute, CsrPlugin_exceptionPortCtrl_exceptionValids_decode} != 4'h0;
	assign when_CsrPlugin_l1335 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1335_1 = ~|memory_arbitration_isStuck;
	assign when_CsrPlugin_l1335_2 = ~|writeBack_arbitration_isStuck;
	assign when_CsrPlugin_l1346 = {CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack, CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory, CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute} != 3'h0;
	assign when_CsrPlugin_l1398 = ~|CsrPlugin_trapEnterDebug;
	assign switch_CsrPlugin_l1460 = writeBack_INSTRUCTION[29:28];
	assign when_CsrPlugin_l1468 = 2'h3 > CsrPlugin_mstatus_MPP;
	assign when_CsrPlugin_l1521 = ~|execute_CsrPlugin_wfiWake;
	assign when_CsrPlugin_l1527 = |{writeBack_arbitration_isValid & (writeBack_ENV_CTRL == EnvCtrlEnum_XRET), memory_arbitration_isValid & (memory_ENV_CTRL == EnvCtrlEnum_XRET), execute_arbitration_isValid & (execute_ENV_CTRL == EnvCtrlEnum_XRET)};
	assign when_CsrPlugin_l1548 = execute_INSTRUCTION[29:28] > CsrPlugin_privilege;
	assign CsrPlugin_csrMapping_hazardFree = ~|execute_CsrPlugin_blockedBySideEffects;
	assign switch_Misc_l226_2 = execute_INSTRUCTION[13];
	assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31:20];
	assign when_Pipeline_l124 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_1 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_3 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_4 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_5 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_6 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_7 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_8 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_9 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_10 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_11 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_12 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_13 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_14 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_15 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_16 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_17 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_18 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_19 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_20 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_21 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_22 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_23 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_24 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_25 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_26 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_27 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_28 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_29 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_30 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_31 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_32 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_33 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_34 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_35 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_36 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_37 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_38 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_39 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_40 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_41 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_42 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_43 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_44 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_45 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_46 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_47 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_48 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_49 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_50 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_51 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_52 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_53 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_54 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_55 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_56 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_57 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_58 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_59 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_60 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_61 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_62 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_63 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_64 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_65 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_66 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_67 = ~|execute_arbitration_isStuck;
	assign when_Pipeline_l124_68 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_69 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_70 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_71 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_72 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_73 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_74 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_75 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_76 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_77 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_78 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_79 = ~|writeBack_arbitration_isStuck;
	assign when_Pipeline_l124_80 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_81 = ~|memory_arbitration_isStuck;
	assign when_Pipeline_l124_82 = ~|writeBack_arbitration_isStuck;
	assign when_CsrPlugin_l1669 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_1 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_2 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_3 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_4 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_5 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_6 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_7 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_8 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_9 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_10 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_11 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_12 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_13 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_14 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_15 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_16 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_17 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_18 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_19 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_20 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_21 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_22 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_23 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_24 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_25 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_26 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_27 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_28 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_29 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_30 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_31 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_32 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_33 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_34 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_35 = ~|execute_arbitration_isStuck;
	assign when_CsrPlugin_l1669_36 = ~|execute_arbitration_isStuck;
	assign switch_CsrPlugin_l1031 = CsrPlugin_csrMapping_writeDataSignal[12:11];
	assign _zz_FpuPlugin_flags_NX = CsrPlugin_csrMapping_writeDataSignal[4:0];
	assign _zz_FpuPlugin_flags_NX_1 = CsrPlugin_csrMapping_writeDataSignal[4:0];
	assign when_CsrPlugin_l1710 = execute_CsrPlugin_csrAddress[9:8] > CsrPlugin_privilege;
	assign _zz_io_cpu_flush_payload_lineId = _zz_io_cpu_flush_payload_lineId_1;
	assign _zz_MmuPlugin_ports_0_entryToReplace_valueNext_1 = MmuPlugin_ports_0_entryToReplace_willIncrement;
	assign _zz_MmuPlugin_ports_1_entryToReplace_valueNext_1 = MmuPlugin_ports_1_entryToReplace_willIncrement;
	assign _zz_FpuPlugin_pendings_3 = FpuPlugin_port_cmd_fire;
	assign _zz_FpuPlugin_pendings_5 = FpuPlugin_port_completion_valid;
	assign _zz_FpuPlugin_pendings_7 = FpuPlugin_port_rsp_fire;
	assign _zz__zz_execute_REGFILE_WRITE_DATA = execute_SRC_LESS;
	assign _zz_execute_SrcPlugin_addSub_2 = execute_SRC1;
	assign _zz_memory_DivPlugin_div_counter_valueNext_1 = memory_DivPlugin_div_counter_willIncrement;
	assign _zz_memory_DivPlugin_div_result_1 = _zz_memory_DivPlugin_div_result_2;
	assign _zz_memory_DivPlugin_div_result_2 = _zz_memory_DivPlugin_div_result_3;
	assign _zz_memory_DivPlugin_div_result_5 = memory_DivPlugin_div_needRevert;
	assign _zz_memory_DivPlugin_rs1_3 = _zz_memory_DivPlugin_rs1;
	assign _zz_memory_DivPlugin_rs2_2 = _zz_memory_DivPlugin_rs2;
	assign _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 = _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code & ~_zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1_1;
	assign _zz_decode_LEGAL_INSTRUCTION_1 = decode_INSTRUCTION & 32'h0000207f;
	assign _zz_decode_LEGAL_INSTRUCTION_7 = decode_INSTRUCTION & 32'h0000603f;
	assign _zz_decode_LEGAL_INSTRUCTION_13 = decode_INSTRUCTION & 32'h7c00607f;
	assign _zz_decode_LEGAL_INSTRUCTION_19 = decode_INSTRUCTION & 32'hede0007f;
	assign _zz_decode_LEGAL_INSTRUCTION_25 = decode_INSTRUCTION & 32'heff0707f;
	assign _zz__zz_decode_IS_CSR_2 = _zz_decode_IS_CSR_14;
	assign _zz__zz_decode_IS_CSR_6 = decode_INSTRUCTION & 32'h00001070;
	assign _zz__zz_decode_IS_CSR_8 = decode_INSTRUCTION & 32'h00002070;
	assign _zz__zz_decode_IS_CSR_15 = _zz_decode_IS_CSR_13;
	assign _zz__zz_decode_IS_CSR_20 = decode_INSTRUCTION & 32'h02004074;
	assign _zz__zz_decode_IS_CSR_29 = decode_INSTRUCTION & 32'h00001000;
	assign _zz__zz_decode_IS_CSR_37 = decode_INSTRUCTION & 32'h20002010;
	assign _zz__zz_decode_IS_CSR_43 = decode_INSTRUCTION & 32'h28000010;
	assign _zz__zz_decode_IS_CSR_45 = decode_INSTRUCTION & 32'ha0100010;
	assign _zz__zz_decode_IS_CSR_51 = decode_INSTRUCTION & 32'h82000004;
	assign _zz__zz_decode_IS_CSR_64 = decode_INSTRUCTION & 32'h60000010;
	assign _zz__zz_decode_IS_CSR_71 = _zz_decode_IS_CSR_12;
	assign _zz__zz_decode_IS_CSR_56 = decode_INSTRUCTION & 32'h12000004;
	assign _zz__zz_decode_IS_CSR_69 = decode_INSTRUCTION & 32'ha0000010;
	assign _zz__zz_decode_IS_CSR_76 = decode_INSTRUCTION & 32'h00000050;
	assign _zz__zz_decode_IS_CSR_79 = decode_INSTRUCTION & 32'h50000004;
	assign _zz__zz_decode_IS_CSR_83 = decode_INSTRUCTION & 32'h10001010;
	assign _zz__zz_decode_IS_CSR_107 = _zz_decode_IS_CSR_11;
	assign _zz__zz_decode_IS_CSR_108 = _zz_decode_IS_CSR_8;
	assign _zz__zz_decode_IS_CSR_89 = decode_INSTRUCTION & 32'h88000010;
	assign _zz__zz_decode_IS_CSR_92 = decode_INSTRUCTION & 32'h50000010;
	assign _zz__zz_decode_IS_CSR_97 = decode_INSTRUCTION & 32'h90000010;
	assign _zz__zz_decode_IS_CSR_128 = _zz_decode_IS_CSR_2;
	assign _zz__zz_decode_IS_CSR_101 = decode_INSTRUCTION & 32'h58000010;
	assign _zz__zz_decode_IS_CSR_104 = decode_INSTRUCTION & 32'hb0000010;
	assign _zz__zz_decode_IS_CSR_114 = decode_INSTRUCTION & 32'h80000020;
	assign _zz__zz_decode_IS_CSR_117 = decode_INSTRUCTION & 32'h00000030;
	assign _zz__zz_decode_IS_CSR_122 = decode_INSTRUCTION & 32'h00000060;
	assign _zz__zz_decode_IS_CSR_125 = decode_INSTRUCTION & 32'h0000005c;
	assign _zz__zz_decode_IS_CSR_134 = decode_INSTRUCTION & 32'h00000034;
	assign _zz__zz_decode_IS_CSR_136 = decode_INSTRUCTION & 32'h00000064;
	assign _zz__zz_decode_IS_CSR_144 = decode_INSTRUCTION & 32'h00002060;
	assign _zz__zz_decode_IS_CSR_148 = _zz_decode_IS_CSR_6;
	assign _zz__zz_decode_IS_CSR_179 = _zz_decode_IS_CSR_9;
	assign _zz__zz_decode_IS_CSR_150 = decode_INSTRUCTION & 32'h12400024;
	assign _zz__zz_decode_IS_CSR_158 = decode_INSTRUCTION & 32'h00000060;
	assign _zz__zz_decode_IS_CSR_167 = decode_INSTRUCTION & 32'h00002070;
	assign _zz__zz_decode_IS_CSR_195 = _zz_decode_IS_CSR_4;
	assign _zz__zz_decode_IS_CSR_200 = _zz_decode_IS_CSR_5;
	assign _zz__zz_decode_IS_CSR_173 = decode_INSTRUCTION & 32'h00001070;
	assign _zz__zz_decode_IS_CSR_176 = decode_INSTRUCTION & 32'h02003020;
	assign _zz__zz_decode_IS_CSR_184 = decode_INSTRUCTION & 32'h00001030;
	assign _zz__zz_decode_IS_CSR_189 = _zz_decode_IS_CSR_8;
	assign _zz__zz_decode_IS_CSR_206 = decode_INSTRUCTION & 32'h00004014;
	assign _zz__zz_decode_IS_CSR_218 = decode_INSTRUCTION & 32'h00004050;
	assign _zz__zz_decode_IS_CSR_231 = decode_INSTRUCTION & 32'h00000044;
	assign _zz__zz_decode_IS_CSR_237 = _zz_decode_IS_CSR_3;
	assign _zz__zz_decode_IS_CSR_241 = _zz_decode_IS_CSR_4;
	assign _zz__zz_decode_IS_CSR_242 = _zz_decode_IS_CSR_3;
	assign _zz__zz_decode_IS_CSR_245 = _zz_decode_IS_CSR_1;
	assign _zz__zz_decode_IS_CSR_223 = decode_INSTRUCTION & 32'h00005024;
	assign _zz__zz_decode_IS_CSR_225 = decode_INSTRUCTION & 32'h90000034;
	assign _zz_CsrPlugin_csrMapping_readDataInit_33 = _zz_CsrPlugin_csrMapping_readDataInit | _zz_CsrPlugin_csrMapping_readDataInit_1;
	assign _zz_CsrPlugin_csrMapping_readDataInit_34 = _zz_CsrPlugin_csrMapping_readDataInit_2 | _zz_CsrPlugin_csrMapping_readDataInit_3;
	assign _zz_CsrPlugin_csrMapping_readDataInit_35 = _zz_CsrPlugin_csrMapping_readDataInit_4 | _zz_CsrPlugin_csrMapping_readDataInit_5;
	assign _zz_CsrPlugin_csrMapping_readDataInit_36 = _zz_CsrPlugin_csrMapping_readDataInit_37 | _zz_CsrPlugin_csrMapping_readDataInit_38;
	assign _zz_CsrPlugin_csrMapping_readDataInit_39 = _zz_CsrPlugin_csrMapping_readDataInit_40 | _zz_CsrPlugin_csrMapping_readDataInit_41;
	assign _zz_CsrPlugin_csrMapping_readDataInit_42 = _zz_CsrPlugin_csrMapping_readDataInit_6 | _zz_CsrPlugin_csrMapping_readDataInit_7;
	assign _zz_CsrPlugin_csrMapping_readDataInit_43 = _zz_CsrPlugin_csrMapping_readDataInit_8 | _zz_CsrPlugin_csrMapping_readDataInit_9;
	assign _zz_CsrPlugin_csrMapping_readDataInit_44 = _zz_CsrPlugin_csrMapping_readDataInit_10 | _zz_CsrPlugin_csrMapping_readDataInit_11;
	assign _zz_CsrPlugin_csrMapping_readDataInit_45 = _zz_CsrPlugin_csrMapping_readDataInit_12 | _zz_CsrPlugin_csrMapping_readDataInit_13;
	assign _zz_CsrPlugin_csrMapping_readDataInit_46 = _zz_CsrPlugin_csrMapping_readDataInit_14 | _zz_CsrPlugin_csrMapping_readDataInit_15;
	assign _zz_CsrPlugin_csrMapping_readDataInit_47 = _zz_CsrPlugin_csrMapping_readDataInit_16 | _zz_CsrPlugin_csrMapping_readDataInit_17;
	assign _zz_CsrPlugin_csrMapping_readDataInit_48 = _zz_CsrPlugin_csrMapping_readDataInit_18 | _zz_CsrPlugin_csrMapping_readDataInit_19;
	assign _zz_CsrPlugin_csrMapping_readDataInit_49 = _zz_CsrPlugin_csrMapping_readDataInit_20 | _zz_CsrPlugin_csrMapping_readDataInit_21;
	assign _zz_CsrPlugin_csrMapping_readDataInit_50 = _zz_CsrPlugin_csrMapping_readDataInit_22 | _zz_CsrPlugin_csrMapping_readDataInit_23;
	assign _zz_CsrPlugin_csrMapping_readDataInit_51 = _zz_CsrPlugin_csrMapping_readDataInit_24 | _zz_CsrPlugin_csrMapping_readDataInit_25;
	assign _zz_CsrPlugin_csrMapping_readDataInit_52 = _zz_CsrPlugin_csrMapping_readDataInit_26 | _zz_CsrPlugin_csrMapping_readDataInit_27;
	assign writeBack_MEMORY_LOAD_DATA = writeBack_DBusCachedPlugin_rspShifted;
	assign execute_BRANCH_DO = (execute_PREDICTION_HAD_BRANCHED2 ^ execute_BRANCH_COND_RESULT) | execute_BranchPlugin_missAlignedTarget;
	assign memory_MUL_HH = execute_to_memory_MUL_HH;
	assign execute_SHIFT_RIGHT = _zz_execute_SHIFT_RIGHT;
	assign execute_REGFILE_WRITE_DATA = _zz_execute_REGFILE_WRITE_DATA;
	assign execute_IS_DBUS_SHARING = MmuPlugin_dBusAccess_cmd_fire;
	assign memory_MEMORY_STORE_DATA_RF = execute_to_memory_MEMORY_STORE_DATA_RF;
	assign execute_MEMORY_STORE_DATA_RF = _zz_execute_MEMORY_STORE_DATA_RF;
	assign decode_PREDICTION_HAD_BRANCHED2 = IBusCachedPlugin_decodePrediction_cmd_hadBranch;
	assign decode_SRC2_FORCE_ZERO = decode_SRC_ADD_ZERO & ~|decode_SRC_USE_SUB_LESS;
	assign memory_RS1 = execute_to_memory_RS1;
	assign _zz_memory_to_writeBack_ENV_CTRL = _zz_memory_to_writeBack_ENV_CTRL_1;
	assign _zz_execute_to_memory_ENV_CTRL = _zz_execute_to_memory_ENV_CTRL_1;
	assign decode_ENV_CTRL = _zz_decode_ENV_CTRL;
	assign _zz_decode_to_execute_ENV_CTRL = _zz_decode_to_execute_ENV_CTRL_1;
	assign _zz_decode_to_execute_BRANCH_CTRL = _zz_decode_to_execute_BRANCH_CTRL_1;
	assign memory_IS_MUL = execute_to_memory_IS_MUL;
	assign execute_IS_MUL = decode_to_execute_IS_MUL;
	assign _zz_execute_to_memory_SHIFT_CTRL = _zz_execute_to_memory_SHIFT_CTRL_1;
	assign decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL;
	assign _zz_decode_to_execute_SHIFT_CTRL = _zz_decode_to_execute_SHIFT_CTRL_1;
	assign decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL;
	assign _zz_decode_to_execute_ALU_BITWISE_CTRL = _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
	assign memory_FPU_OPCODE = _zz_memory_FPU_OPCODE;
	assign _zz_memory_to_writeBack_FPU_OPCODE = _zz_memory_to_writeBack_FPU_OPCODE_1;
	assign execute_FPU_OPCODE = _zz_execute_FPU_OPCODE;
	assign _zz_execute_to_memory_FPU_OPCODE = _zz_execute_to_memory_FPU_OPCODE_1;
	assign _zz_decode_to_execute_FPU_OPCODE = _zz_decode_to_execute_FPU_OPCODE_1;
	assign memory_FPU_RSP = execute_to_memory_FPU_RSP;
	assign execute_FPU_RSP = decode_to_execute_FPU_RSP;
	assign memory_FPU_COMMIT = execute_to_memory_FPU_COMMIT;
	assign execute_FPU_COMMIT = decode_to_execute_FPU_COMMIT;
	assign memory_MEMORY_WR = execute_to_memory_MEMORY_WR;
	assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
	assign decode_SRC2_CTRL = _zz_decode_SRC2_CTRL;
	assign _zz_decode_to_execute_SRC2_CTRL = _zz_decode_to_execute_SRC2_CTRL_1;
	assign decode_ALU_CTRL = _zz_decode_ALU_CTRL;
	assign _zz_decode_to_execute_ALU_CTRL = _zz_decode_to_execute_ALU_CTRL_1;
	assign decode_SRC1_CTRL = _zz_decode_SRC1_CTRL;
	assign _zz_decode_to_execute_SRC1_CTRL = _zz_decode_to_execute_SRC1_CTRL_1;
	assign memory_FPU_COMMIT_LOAD = execute_to_memory_FPU_COMMIT_LOAD;
	assign execute_FPU_COMMIT_LOAD = decode_to_execute_FPU_COMMIT_LOAD;
	assign memory_FPU_FORKED = execute_to_memory_FPU_FORKED;
	assign execute_FPU_FORKED = decode_to_execute_FPU_FORKED;
	assign decode_FPU_FORKED = decode_FpuPlugin_forked | (FpuPlugin_port_cmd_fire_2 & ~|_zz_decode_FPU_FORKED);
	assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
	assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
	assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
	assign memory_PC = execute_to_memory_PC;
	assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
	assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
	assign memory_ENV_CTRL = _zz_memory_ENV_CTRL;
	assign execute_ENV_CTRL = _zz_execute_ENV_CTRL;
	assign writeBack_ENV_CTRL = _zz_writeBack_ENV_CTRL;
	assign execute_RESCHEDULE_NEXT = decode_to_execute_RESCHEDULE_NEXT;
	assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
	assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
	assign execute_PC = decode_to_execute_PC;
	assign execute_PREDICTION_HAD_BRANCHED2 = decode_to_execute_PREDICTION_HAD_BRANCHED2;
	assign execute_BRANCH_COND_RESULT = _zz_execute_BRANCH_COND_RESULT_1;
	assign execute_BRANCH_CTRL = _zz_execute_BRANCH_CTRL;
	assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
	assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
	assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
	assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
	assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
	assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
	assign execute_IS_DIV = decode_to_execute_IS_DIV;
	assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
	assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
	assign memory_IS_DIV = execute_to_memory_IS_DIV;
	assign writeBack_IS_MUL = memory_to_writeBack_IS_MUL;
	assign writeBack_MUL_HH = memory_to_writeBack_MUL_HH;
	assign writeBack_MUL_LOW = memory_to_writeBack_MUL_LOW;
	assign memory_MUL_HL = execute_to_memory_MUL_HL;
	assign memory_MUL_LH = execute_to_memory_MUL_LH;
	assign memory_MUL_LL = execute_to_memory_MUL_LL;
	assign memory_SHIFT_RIGHT = execute_to_memory_SHIFT_RIGHT;
	assign memory_SHIFT_CTRL = _zz_memory_SHIFT_CTRL;
	assign execute_SHIFT_CTRL = _zz_execute_SHIFT_CTRL;
	assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
	assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO;
	assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
	assign _zz_execute_to_memory_PC = execute_PC;
	assign execute_SRC2_CTRL = _zz_execute_SRC2_CTRL;
	assign _zz_execute_to_memory_RS1 = execute_RS1;
	assign execute_SRC1_CTRL = _zz_execute_SRC1_CTRL;
	assign execute_SRC_ADD_SUB = execute_SrcPlugin_addSub;
	assign execute_SRC_LESS = execute_SrcPlugin_less;
	assign execute_ALU_CTRL = _zz_execute_ALU_CTRL;
	assign execute_SRC2 = _zz_execute_SRC2_4;
	assign execute_SRC1 = _zz_execute_SRC1;
	assign execute_ALU_BITWISE_CTRL = _zz_execute_ALU_BITWISE_CTRL;
	assign _zz_lastStageRegFileWrite_payload_address = writeBack_INSTRUCTION;
	assign _zz_lastStageRegFileWrite_valid = writeBack_REGFILE_WRITE_VALID;
	assign writeBack_FPU_OPCODE = _zz_writeBack_FPU_OPCODE;
	assign writeBack_RS1 = memory_to_writeBack_RS1;
	assign _zz_writeBack_FpuPlugin_commit_payload_value = writeBack_MEMORY_LOAD_DATA;
	assign writeBack_FPU_COMMIT_LOAD = memory_to_writeBack_FPU_COMMIT_LOAD;
	assign writeBack_FPU_COMMIT = memory_to_writeBack_FPU_COMMIT;
	assign writeBack_FPU_RSP = memory_to_writeBack_FPU_RSP;
	assign writeBack_FPU_FORKED = memory_to_writeBack_FPU_FORKED;
	assign decode_FPU_FORMAT = _zz_decode_FPU_FORMAT_1;
	assign decode_FPU_OPCODE = _zz_decode_FPU_OPCODE_1;
	assign execute_IS_CSR = decode_to_execute_IS_CSR;
	assign execute_IS_SFENCE_VMA2 = decode_to_execute_IS_SFENCE_VMA2;
	assign writeBack_IS_DBUS_SHARING = memory_to_writeBack_IS_DBUS_SHARING;
	assign memory_IS_DBUS_SHARING = execute_to_memory_IS_DBUS_SHARING;
	assign writeBack_MEMORY_WR = memory_to_writeBack_MEMORY_WR;
	assign writeBack_MEMORY_STORE_DATA_RF = memory_to_writeBack_MEMORY_STORE_DATA_RF;
	assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
	assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
	assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
	assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
	assign execute_MEMORY_FORCE_CONSTISTENCY = decode_to_execute_MEMORY_FORCE_CONSTISTENCY;
	assign execute_RS1 = decode_to_execute_RS1;
	assign execute_MEMORY_MANAGMENT = decode_to_execute_MEMORY_MANAGMENT;
	assign execute_RS2 = decode_to_execute_RS2;
	assign execute_MEMORY_WR = decode_to_execute_MEMORY_WR;
	assign execute_SRC_ADD = execute_SrcPlugin_addSub;
	assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
	assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
	assign decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL_1;
	assign decode_PC = IBusCachedPlugin_injector_decodeInput_payload_pc;
	assign decode_INSTRUCTION = IBusCachedPlugin_injector_decodeInput_payload_rsp_inst;
	assign writeBack_PC = memory_to_writeBack_PC;
	assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
	assign lastStageInstruction = writeBack_INSTRUCTION;
	assign lastStagePc = writeBack_PC;
	assign lastStageIsValid = writeBack_arbitration_isValid;
	assign lastStageIsFiring = writeBack_arbitration_isFiring;
	assign CsrPlugin_csrMapping_readDataSignal = CsrPlugin_csrMapping_readDataInit;
	assign _zz_IBusCachedPlugin_jump_pcLoad_payload_1 = _zz_IBusCachedPlugin_jump_pcLoad_payload & ~_zz__zz_IBusCachedPlugin_jump_pcLoad_payload_1;
	assign _zz_IBusCachedPlugin_jump_pcLoad_payload_4 = _zz_IBusCachedPlugin_jump_pcLoad_payload_1[1] | _zz_IBusCachedPlugin_jump_pcLoad_payload_2;
	assign _zz_IBusCachedPlugin_jump_pcLoad_payload_5 = _zz_IBusCachedPlugin_jump_pcLoad_payload_1[2] | _zz_IBusCachedPlugin_jump_pcLoad_payload_2;
	assign IBusCachedPlugin_jump_pcLoad_payload = _zz_IBusCachedPlugin_jump_pcLoad_payload_6;
	assign IBusCachedPlugin_fetchPc_output_fire = IBusCachedPlugin_fetchPc_output_valid & IBusCachedPlugin_fetchPc_output_ready;
	assign IBusCachedPlugin_fetchPc_corrected = IBusCachedPlugin_fetchPc_correction | IBusCachedPlugin_fetchPc_correctionReg;
	assign when_Fetcher_l133 = IBusCachedPlugin_fetchPc_correction | IBusCachedPlugin_fetchPc_pcRegPropagate;
	assign IBusCachedPlugin_fetchPc_output_fire_1 = IBusCachedPlugin_fetchPc_output_valid & IBusCachedPlugin_fetchPc_output_ready;
	assign when_Fetcher_l133_1 = ~|IBusCachedPlugin_fetchPc_output_valid & IBusCachedPlugin_fetchPc_output_ready;
	assign when_Fetcher_l160 = IBusCachedPlugin_fetchPc_booted & ((IBusCachedPlugin_fetchPc_output_ready | IBusCachedPlugin_fetchPc_correction) | IBusCachedPlugin_fetchPc_pcRegPropagate);
	assign IBusCachedPlugin_fetchPc_output_valid = ~|IBusCachedPlugin_fetcherHalt & IBusCachedPlugin_fetchPc_booted;
	assign IBusCachedPlugin_fetchPc_output_payload = IBusCachedPlugin_fetchPc_pc;
	assign IBusCachedPlugin_iBusRsp_stages_0_input_valid = IBusCachedPlugin_fetchPc_output_valid;
	assign IBusCachedPlugin_fetchPc_output_ready = IBusCachedPlugin_iBusRsp_stages_0_input_ready;
	assign IBusCachedPlugin_iBusRsp_stages_0_input_payload = IBusCachedPlugin_fetchPc_output_payload;
	assign IBusCachedPlugin_iBusRsp_stages_0_input_ready = IBusCachedPlugin_iBusRsp_stages_0_output_ready & _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready;
	assign IBusCachedPlugin_iBusRsp_stages_0_output_valid = IBusCachedPlugin_iBusRsp_stages_0_input_valid & _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready;
	assign IBusCachedPlugin_iBusRsp_stages_0_output_payload = IBusCachedPlugin_iBusRsp_stages_0_input_payload;
	assign IBusCachedPlugin_iBusRsp_stages_1_input_ready = IBusCachedPlugin_iBusRsp_stages_1_output_ready & _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready;
	assign IBusCachedPlugin_iBusRsp_stages_1_output_valid = IBusCachedPlugin_iBusRsp_stages_1_input_valid & _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready;
	assign IBusCachedPlugin_iBusRsp_stages_1_output_payload = IBusCachedPlugin_iBusRsp_stages_1_input_payload;
	assign IBusCachedPlugin_fetchPc_redo_valid = IBusCachedPlugin_iBusRsp_redoFetch;
	assign IBusCachedPlugin_fetchPc_redo_payload = IBusCachedPlugin_iBusRsp_stages_1_input_payload;
	assign IBusCachedPlugin_iBusRsp_flush = IBusCachedPlugin_externalFlush | IBusCachedPlugin_iBusRsp_redoFetch;
	assign IBusCachedPlugin_iBusRsp_stages_0_output_ready = _zz_IBusCachedPlugin_iBusRsp_stages_0_output_ready;
	assign _zz_IBusCachedPlugin_iBusRsp_stages_0_output_ready = 1'b0 | IBusCachedPlugin_iBusRsp_stages_1_input_ready;
	assign _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid = _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid_1;
	assign IBusCachedPlugin_iBusRsp_stages_1_input_valid = _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid;
	assign IBusCachedPlugin_iBusRsp_stages_1_input_payload = IBusCachedPlugin_fetchPc_pcReg;
	assign IBusCachedPlugin_iBusRsp_output_ready = 1'b0 | IBusCachedPlugin_injector_decodeInput_ready;
	assign IBusCachedPlugin_injector_decodeInput_valid = _zz_IBusCachedPlugin_injector_decodeInput_valid;
	assign IBusCachedPlugin_injector_decodeInput_payload_pc = _zz_IBusCachedPlugin_injector_decodeInput_payload_pc;
	assign IBusCachedPlugin_injector_decodeInput_payload_rsp_error = _zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_error;
	assign IBusCachedPlugin_injector_decodeInput_payload_rsp_inst = _zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_inst;
	assign IBusCachedPlugin_injector_decodeInput_payload_isRvc = _zz_IBusCachedPlugin_injector_decodeInput_payload_isRvc;
	assign IBusCachedPlugin_pcValids_0 = IBusCachedPlugin_injector_nextPcCalc_valids_1;
	assign IBusCachedPlugin_pcValids_1 = IBusCachedPlugin_injector_nextPcCalc_valids_2;
	assign IBusCachedPlugin_pcValids_2 = IBusCachedPlugin_injector_nextPcCalc_valids_3;
	assign IBusCachedPlugin_pcValids_3 = IBusCachedPlugin_injector_nextPcCalc_valids_4;
	assign IBusCachedPlugin_predictionJumpInterface_valid = decode_arbitration_isValid & IBusCachedPlugin_decodePrediction_cmd_hadBranch;
	assign iBus_cmd_valid = IBusCachedPlugin_cache_io_mem_cmd_valid;
	assign iBus_cmd_payload_size = IBusCachedPlugin_cache_io_mem_cmd_payload_size;
	assign IBusCachedPlugin_cache_io_cpu_prefetch_isValid = IBusCachedPlugin_iBusRsp_stages_0_input_valid & ~|IBusCachedPlugin_s0_tightlyCoupledHit;
	assign IBusCachedPlugin_cache_io_cpu_fetch_isValid = IBusCachedPlugin_iBusRsp_stages_1_input_valid & ~|IBusCachedPlugin_s1_tightlyCoupledHit;
	assign IBusCachedPlugin_mmuBus_cmd_0_isValid = IBusCachedPlugin_cache_io_cpu_fetch_isValid;
	assign IBusCachedPlugin_mmuBus_cmd_0_virtualAddress = IBusCachedPlugin_iBusRsp_stages_1_input_payload;
	assign IBusCachedPlugin_mmuBus_end = IBusCachedPlugin_iBusRsp_stages_1_input_ready | IBusCachedPlugin_externalFlush;
	assign when_IBusCachedPlugin_l245 = (IBusCachedPlugin_cache_io_cpu_fetch_isValid & IBusCachedPlugin_cache_io_cpu_fetch_mmuRefilling) & ~|IBusCachedPlugin_rsp_issueDetected;
	assign when_IBusCachedPlugin_l250 = (IBusCachedPlugin_cache_io_cpu_fetch_isValid & IBusCachedPlugin_cache_io_cpu_fetch_mmuException) & ~|IBusCachedPlugin_rsp_issueDetected_1;
	assign when_IBusCachedPlugin_l256 = (IBusCachedPlugin_cache_io_cpu_fetch_isValid & IBusCachedPlugin_cache_io_cpu_fetch_cacheMiss) & ~|IBusCachedPlugin_rsp_issueDetected_2;
	assign when_IBusCachedPlugin_l262 = (IBusCachedPlugin_cache_io_cpu_fetch_isValid & IBusCachedPlugin_cache_io_cpu_fetch_error) & ~|IBusCachedPlugin_rsp_issueDetected_3;
	assign when_IBusCachedPlugin_l273 = IBusCachedPlugin_rsp_issueDetected_4 | IBusCachedPlugin_rsp_iBusRspOutputHalt;
	assign IBusCachedPlugin_iBusRsp_output_valid = IBusCachedPlugin_iBusRsp_stages_1_output_valid;
	assign IBusCachedPlugin_iBusRsp_stages_1_output_ready = IBusCachedPlugin_iBusRsp_output_ready;
	assign IBusCachedPlugin_iBusRsp_output_payload_rsp_inst = IBusCachedPlugin_cache_io_cpu_fetch_data;
	assign IBusCachedPlugin_iBusRsp_output_payload_pc = IBusCachedPlugin_iBusRsp_stages_1_output_payload;
	assign IBusCachedPlugin_cache_io_flush = decode_arbitration_isValid & decode_FLUSH_ALL;
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_valid = dataCache_1_io_mem_cmd_valid | toplevel_dataCache_1_io_mem_cmd_rValid;
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_valid = toplevel_dataCache_1_io_mem_cmd_s2mPipe_rValid;
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_wr = toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_wr;
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_uncached = toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_uncached;
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_address = toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_address;
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_data = toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_data;
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_mask = toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_mask;
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_size = toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_size;
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_last = toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_last;
	assign dBus_cmd_valid = toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_valid;
	assign toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_ready = dBus_cmd_ready;
	assign dBus_cmd_payload_wr = toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_wr;
	assign dBus_cmd_payload_uncached = toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_uncached;
	assign dBus_cmd_payload_address = toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_address;
	assign dBus_cmd_payload_data = toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_data;
	assign dBus_cmd_payload_mask = toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_mask;
	assign dBus_cmd_payload_size = toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_size;
	assign dBus_cmd_payload_last = toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_last;
	assign when_DBusCachedPlugin_l341 = (DBusCachedPlugin_mmuBus_busy & decode_arbitration_isValid) & decode_MEMORY_ENABLE;
	assign dataCache_1_io_cpu_flush_valid = execute_arbitration_isValid & execute_MEMORY_MANAGMENT;
	assign toplevel_dataCache_1_io_cpu_flush_isStall = dataCache_1_io_cpu_flush_valid & ~|dataCache_1_io_cpu_flush_ready;
	assign when_DBusCachedPlugin_l383 = toplevel_dataCache_1_io_cpu_flush_isStall | dataCache_1_io_cpu_execute_haltIt;
	assign when_DBusCachedPlugin_l399 = dataCache_1_io_cpu_execute_refilling & execute_arbitration_isValid;
	assign dataCache_1_io_cpu_memory_address = memory_REGFILE_WRITE_DATA;
	assign DBusCachedPlugin_mmuBus_cmd_0_isValid = dataCache_1_io_cpu_memory_isValid;
	assign DBusCachedPlugin_mmuBus_cmd_0_isStuck = memory_arbitration_isStuck;
	assign DBusCachedPlugin_mmuBus_cmd_0_virtualAddress = dataCache_1_io_cpu_memory_address;
	assign DBusCachedPlugin_mmuBus_end = ~|memory_arbitration_isStuck | memory_arbitration_removeIt;
	assign dataCache_1_io_cpu_writeBack_address = writeBack_REGFILE_WRITE_DATA;
	assign DBusCachedPlugin_redoBranch_payload = writeBack_PC;
	assign DBusCachedPlugin_exceptionBus_payload_badAddr = writeBack_REGFILE_WRITE_DATA;
	assign when_DBusCachedPlugin_l521 = writeBack_arbitration_isValid & writeBack_MEMORY_ENABLE;
	assign when_DBusCachedPlugin_l541 = dataCache_1_io_cpu_writeBack_isValid & dataCache_1_io_cpu_writeBack_haltIt;
	assign writeBack_DBusCachedPlugin_rspData = dataCache_1_io_cpu_writeBack_data;
	assign _zz_writeBack_DBusCachedPlugin_rspFormated = writeBack_DBusCachedPlugin_rspRf[7] & ~|writeBack_INSTRUCTION[14];
	assign _zz_writeBack_DBusCachedPlugin_rspFormated_2 = writeBack_DBusCachedPlugin_rspRf[15] & ~|writeBack_INSTRUCTION[14];
	assign when_DBusCachedPlugin_l568 = writeBack_arbitration_isValid & writeBack_MEMORY_ENABLE;
	assign MmuPlugin_dBusAccess_cmd_fire = MmuPlugin_dBusAccess_cmd_valid & MmuPlugin_dBusAccess_cmd_ready;
	assign MmuPlugin_dBusAccess_rsp_valid = (writeBack_IS_DBUS_SHARING & ~|dataCache_1_io_cpu_writeBack_isWrite) & (dataCache_1_io_cpu_redo | ~|dataCache_1_io_cpu_writeBack_haltIt);
	assign MmuPlugin_dBusAccess_rsp_payload_data = writeBack_DBusCachedPlugin_rspRf;
	assign MmuPlugin_dBusAccess_rsp_payload_error = dataCache_1_io_cpu_writeBack_unalignedAccess | dataCache_1_io_cpu_writeBack_accessError;
	assign MmuPlugin_dBusAccess_rsp_payload_redo = dataCache_1_io_cpu_redo;
	assign when_MmuPlugin_l131 = ~|MmuPlugin_status_mprv & (CsrPlugin_privilege == 2'h3);
	assign _zz_MmuPlugin_ports_0_cacheLine_valid_1 = MmuPlugin_ports_0_cacheHitsCalc[1] | _zz_MmuPlugin_ports_0_cacheLine_valid;
	assign _zz_MmuPlugin_ports_0_cacheLine_valid_2 = MmuPlugin_ports_0_cacheHitsCalc[2] | _zz_MmuPlugin_ports_0_cacheLine_valid;
	assign MmuPlugin_ports_0_cacheLine_valid = _zz_MmuPlugin_ports_0_cacheLine_valid_4;
	assign MmuPlugin_ports_0_cacheLine_exception = _zz_MmuPlugin_ports_0_cacheLine_exception;
	assign MmuPlugin_ports_0_cacheLine_superPage = _zz_MmuPlugin_ports_0_cacheLine_superPage;
	assign MmuPlugin_ports_0_cacheLine_virtualAddress_0 = _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_0;
	assign MmuPlugin_ports_0_cacheLine_virtualAddress_1 = _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_1;
	assign MmuPlugin_ports_0_cacheLine_physicalAddress_0 = _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_0;
	assign MmuPlugin_ports_0_cacheLine_physicalAddress_1 = _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_1;
	assign MmuPlugin_ports_0_cacheLine_allowRead = _zz_MmuPlugin_ports_0_cacheLine_allowRead;
	assign MmuPlugin_ports_0_cacheLine_allowWrite = _zz_MmuPlugin_ports_0_cacheLine_allowWrite;
	assign MmuPlugin_ports_0_cacheLine_allowExecute = _zz_MmuPlugin_ports_0_cacheLine_allowExecute;
	assign MmuPlugin_ports_0_cacheLine_allowUser = _zz_MmuPlugin_ports_0_cacheLine_allowUser;
	assign MmuPlugin_ports_0_entryToReplace_willOverflow = MmuPlugin_ports_0_entryToReplace_willOverflowIfInc & MmuPlugin_ports_0_entryToReplace_willIncrement;
	assign when_MmuPlugin_l131_1 = ~|MmuPlugin_status_mprv & (CsrPlugin_privilege == 2'h3);
	assign when_MmuPlugin_l134 = ~|MmuPlugin_status_mprv | (CsrPlugin_mstatus_MPP == 2'h3);
	assign _zz_MmuPlugin_ports_1_cacheLine_valid_1 = MmuPlugin_ports_1_cacheHitsCalc[1] | _zz_MmuPlugin_ports_1_cacheLine_valid;
	assign _zz_MmuPlugin_ports_1_cacheLine_valid_2 = MmuPlugin_ports_1_cacheHitsCalc[2] | _zz_MmuPlugin_ports_1_cacheLine_valid;
	assign MmuPlugin_ports_1_cacheLine_valid = _zz_MmuPlugin_ports_1_cacheLine_valid_4;
	assign MmuPlugin_ports_1_cacheLine_exception = _zz_MmuPlugin_ports_1_cacheLine_exception;
	assign MmuPlugin_ports_1_cacheLine_superPage = _zz_MmuPlugin_ports_1_cacheLine_superPage;
	assign MmuPlugin_ports_1_cacheLine_virtualAddress_0 = _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_0;
	assign MmuPlugin_ports_1_cacheLine_virtualAddress_1 = _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_1;
	assign MmuPlugin_ports_1_cacheLine_physicalAddress_0 = _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_0;
	assign MmuPlugin_ports_1_cacheLine_physicalAddress_1 = _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_1;
	assign MmuPlugin_ports_1_cacheLine_allowRead = _zz_MmuPlugin_ports_1_cacheLine_allowRead;
	assign MmuPlugin_ports_1_cacheLine_allowWrite = _zz_MmuPlugin_ports_1_cacheLine_allowWrite;
	assign MmuPlugin_ports_1_cacheLine_allowExecute = _zz_MmuPlugin_ports_1_cacheLine_allowExecute;
	assign MmuPlugin_ports_1_cacheLine_allowUser = _zz_MmuPlugin_ports_1_cacheLine_allowUser;
	assign MmuPlugin_ports_1_entryToReplace_willOverflow = MmuPlugin_ports_1_entryToReplace_willOverflowIfInc & MmuPlugin_ports_1_entryToReplace_willIncrement;
	assign MmuPlugin_shared_dBusRsp_exception = (~|MmuPlugin_shared_dBusRsp_pte_V | (~|MmuPlugin_shared_dBusRsp_pte_R & MmuPlugin_shared_dBusRsp_pte_W)) | MmuPlugin_shared_dBusRspStaged_payload_error;
	assign MmuPlugin_shared_dBusRsp_leaf = MmuPlugin_shared_dBusRsp_pte_R | MmuPlugin_shared_dBusRsp_pte_X;
	assign when_MmuPlugin_l211 = MmuPlugin_shared_dBusRspStaged_valid & ~|MmuPlugin_shared_dBusRspStaged_payload_redo;
	assign _zz_MmuPlugin_shared_refills_2 = _zz_MmuPlugin_shared_refills_1 & ~_zz__zz_MmuPlugin_shared_refills_2;
	assign MmuPlugin_shared_refills = _zz_MmuPlugin_shared_refills_3;
	assign when_MmuPlugin_l250 = MmuPlugin_shared_dBusRsp_leaf | MmuPlugin_shared_dBusRsp_exception;
	assign IBusCachedPlugin_mmuBus_busy = (MmuPlugin_shared_state_1 != MmuPlugin_shared_State_IDLE) & MmuPlugin_shared_portSortedOh[0];
	assign DBusCachedPlugin_mmuBus_busy = (MmuPlugin_shared_state_1 != MmuPlugin_shared_State_IDLE) & MmuPlugin_shared_portSortedOh[1];
	assign when_MmuPlugin_l279 = (MmuPlugin_shared_dBusRspStaged_valid & ~|MmuPlugin_shared_dBusRspStaged_payload_redo) & (MmuPlugin_shared_dBusRsp_leaf | MmuPlugin_shared_dBusRsp_exception);
	assign when_MmuPlugin_l311 = (execute_arbitration_isValid & execute_arbitration_isFiring) & execute_IS_SFENCE_VMA2;
	assign FpuPlugin_port_cmd_ready = FpuPlugin_fpu_io_port_0_cmd_ready;
	assign FpuPlugin_port_commit_ready = FpuPlugin_fpu_io_port_0_commit_ready;
	assign FpuPlugin_port_rsp_valid = FpuPlugin_fpu_io_port_0_rsp_valid;
	assign FpuPlugin_port_rsp_payload_value = FpuPlugin_fpu_io_port_0_rsp_payload_value;
	assign FpuPlugin_port_rsp_payload_NV = FpuPlugin_fpu_io_port_0_rsp_payload_NV;
	assign FpuPlugin_port_rsp_payload_NX = FpuPlugin_fpu_io_port_0_rsp_payload_NX;
	assign FpuPlugin_port_completion_valid = FpuPlugin_fpu_io_port_0_completion_valid;
	assign FpuPlugin_port_completion_payload_flags_NX = FpuPlugin_fpu_io_port_0_completion_payload_flags_NX;
	assign FpuPlugin_port_completion_payload_flags_UF = FpuPlugin_fpu_io_port_0_completion_payload_flags_UF;
	assign FpuPlugin_port_completion_payload_flags_OF = FpuPlugin_fpu_io_port_0_completion_payload_flags_OF;
	assign FpuPlugin_port_completion_payload_flags_DZ = FpuPlugin_fpu_io_port_0_completion_payload_flags_DZ;
	assign FpuPlugin_port_completion_payload_flags_NV = FpuPlugin_fpu_io_port_0_completion_payload_flags_NV;
	assign FpuPlugin_port_completion_payload_written = FpuPlugin_fpu_io_port_0_completion_payload_written;
	assign FpuPlugin_port_cmd_fire = FpuPlugin_port_cmd_valid & FpuPlugin_port_cmd_ready;
	assign FpuPlugin_port_rsp_fire = FpuPlugin_port_rsp_valid & FpuPlugin_port_rsp_ready;
	assign when_FpuPlugin_l215 = FpuPlugin_port_completion_valid & FpuPlugin_port_completion_payload_flags_NV;
	assign when_FpuPlugin_l216 = FpuPlugin_port_completion_valid & FpuPlugin_port_completion_payload_flags_DZ;
	assign when_FpuPlugin_l217 = FpuPlugin_port_completion_valid & FpuPlugin_port_completion_payload_flags_OF;
	assign when_FpuPlugin_l218 = FpuPlugin_port_completion_valid & FpuPlugin_port_completion_payload_flags_UF;
	assign when_FpuPlugin_l219 = FpuPlugin_port_completion_valid & FpuPlugin_port_completion_payload_flags_NX;
	assign FpuPlugin_csrActive = execute_arbitration_isValid & execute_IS_CSR;
	assign when_FpuPlugin_l229 = FpuPlugin_csrActive & FpuPlugin_hasPending;
	assign when_FpuPlugin_l234 = FpuPlugin_port_completion_valid & (FpuPlugin_port_completion_payload_written | ({FpuPlugin_port_completion_payload_flags_NV, FpuPlugin_port_completion_payload_flags_DZ, FpuPlugin_port_completion_payload_flags_OF, FpuPlugin_port_completion_payload_flags_UF, FpuPlugin_port_completion_payload_flags_NX} != 5'h00));
	assign when_FpuPlugin_l253 = (FpuPlugin_accessFpuCsr & (FpuPlugin_fs == 2'h0)) & 1'b1;
	assign decode_FpuPlugin_trap = ((_zz_decode_FPU_ENABLE & (FpuPlugin_fs == 2'h0)) & 1'b1) & ({writeBack_arbitration_isValid, memory_arbitration_isValid, execute_arbitration_isValid} == 3'h0);
	assign FpuPlugin_port_cmd_fire_1 = FpuPlugin_port_cmd_valid & FpuPlugin_port_cmd_ready;
	assign when_FpuPlugin_l268 = FpuPlugin_port_cmd_fire_1 & ~|_zz_decode_FPU_FORKED;
	assign decode_FpuPlugin_hazard = (FpuPlugin_pendings[5] | FpuPlugin_csrActive) | ((FpuPlugin_fs == 2'h0) & 1'b1);
	assign when_FpuPlugin_l273 = (decode_arbitration_isValid & decode_FPU_ENABLE) & decode_FpuPlugin_hazard;
	assign FpuPlugin_port_cmd_isStall = FpuPlugin_port_cmd_valid & ~|FpuPlugin_port_cmd_ready;
	assign FpuPlugin_port_cmd_valid = ((decode_arbitration_isValid & decode_FPU_ENABLE) & ~|decode_FpuPlugin_forked) & ~|decode_FpuPlugin_hazard;
	assign FpuPlugin_port_cmd_payload_opcode = decode_FPU_OPCODE;
	assign FpuPlugin_port_cmd_payload_arg = decode_FPU_ARG;
	assign FpuPlugin_port_cmd_payload_format = decode_FPU_FORMAT;
	assign _zz_FpuPlugin_port_cmd_payload_roundMode_1 = decode_FpuPlugin_roundMode;
	assign _zz_FpuPlugin_port_cmd_payload_roundMode = _zz_FpuPlugin_port_cmd_payload_roundMode_1;
	assign FpuPlugin_port_cmd_payload_roundMode = _zz_FpuPlugin_port_cmd_payload_roundMode;
	assign FpuPlugin_port_cmd_fire_2 = FpuPlugin_port_cmd_valid & FpuPlugin_port_cmd_ready;
	assign writeBack_FpuPlugin_isRsp = writeBack_FPU_FORKED & writeBack_FPU_RSP;
	assign writeBack_FpuPlugin_isCommit = writeBack_FPU_FORKED & writeBack_FPU_COMMIT;
	assign DBusBypass0_value = writeBack_FpuPlugin_storeFormated;
	assign when_FpuPlugin_l315 = ~|writeBack_arbitration_isStuck & ~|writeBack_arbitration_removeIt;
	assign when_FpuPlugin_l318 = FpuPlugin_port_rsp_payload_NV | FpuPlugin_port_rsp_payload_NX;
	assign writeBack_FpuPlugin_commit_valid = writeBack_FpuPlugin_isCommit & ~|writeBack_arbitration_isStuck;
	assign writeBack_FpuPlugin_commit_payload_write = writeBack_arbitration_isValid & ~|writeBack_arbitration_removeIt;
	assign writeBack_FpuPlugin_commit_payload_opcode = writeBack_FPU_OPCODE;
	assign when_FpuPlugin_l339 = writeBack_FpuPlugin_isCommit & ~|writeBack_FpuPlugin_commit_ready;
	assign writeBack_FpuPlugin_commit_s2mPipe_valid = writeBack_FpuPlugin_commit_valid | writeBack_FpuPlugin_commit_rValid;
	assign writeBack_FpuPlugin_commit_s2mPipe_payload_opcode = _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode;
	assign FpuPlugin_port_commit_valid = writeBack_FpuPlugin_commit_s2mPipe_valid;
	assign writeBack_FpuPlugin_commit_s2mPipe_ready = FpuPlugin_port_commit_ready;
	assign FpuPlugin_port_commit_payload_opcode = writeBack_FpuPlugin_commit_s2mPipe_payload_opcode;
	assign FpuPlugin_port_commit_payload_rd = writeBack_FpuPlugin_commit_s2mPipe_payload_rd;
	assign FpuPlugin_port_commit_payload_write = writeBack_FpuPlugin_commit_s2mPipe_payload_write;
	assign FpuPlugin_port_commit_payload_value = writeBack_FpuPlugin_commit_s2mPipe_payload_value;
	assign _zz_decode_SRC1_CTRL_1 = _zz_decode_SRC1_CTRL_2;
	assign _zz_decode_ALU_CTRL_1 = _zz_decode_ALU_CTRL_2;
	assign _zz_decode_SRC2_CTRL_1 = _zz_decode_SRC2_CTRL_2;
	assign _zz_decode_FPU_OPCODE = _zz_decode_FPU_OPCODE_2;
	assign _zz_decode_FPU_FORMAT = _zz_decode_FPU_FORMAT_2;
	assign _zz_decode_ALU_BITWISE_CTRL_1 = _zz_decode_ALU_BITWISE_CTRL_2;
	assign _zz_decode_SHIFT_CTRL_1 = _zz_decode_SHIFT_CTRL_2;
	assign _zz_decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL_2;
	assign _zz_decode_ENV_CTRL_1 = _zz_decode_ENV_CTRL_2;
	assign decodeExceptionPort_valid = decode_arbitration_isValid & ~|decode_LEGAL_INSTRUCTION;
	assign decodeExceptionPort_payload_badAddr = decode_INSTRUCTION;
	assign decode_RegFilePlugin_rs1Data = _zz_RegFilePlugin_regFile_port0;
	assign decode_RegFilePlugin_rs2Data = _zz_RegFilePlugin_regFile_port1;
	assign execute_MulPlugin_a = execute_RS1;
	assign execute_MulPlugin_b = execute_RS2;
	assign when_MulPlugin_l147 = writeBack_arbitration_isValid & writeBack_IS_MUL;
	assign memory_DivPlugin_div_counter_willOverflow = memory_DivPlugin_div_counter_willOverflowIfInc & memory_DivPlugin_div_counter_willIncrement;
	assign when_MulDivIterativePlugin_l128 = memory_arbitration_isValid & memory_IS_DIV;
	assign when_MulDivIterativePlugin_l129 = ~|memory_DivPlugin_frontendOk | ~|memory_DivPlugin_div_done;
	assign when_MulDivIterativePlugin_l132 = memory_DivPlugin_frontendOk & ~|memory_DivPlugin_div_done;
	assign _zz_memory_DivPlugin_rs2 = execute_RS2[31] & execute_IS_RS2_SIGNED;
	assign _zz_memory_DivPlugin_rs1 = 1'b0 | ((execute_IS_DIV & execute_RS1[31]) & execute_IS_RS1_SIGNED);
	assign HazardSimplePlugin_writeBackWrites_valid = _zz_lastStageRegFileWrite_valid & writeBack_arbitration_isFiring;
	assign HazardSimplePlugin_writeBackWrites_payload_data = _zz_decode_RS2_2;
	assign when_HazardSimplePlugin_l45 = writeBack_arbitration_isValid & writeBack_REGFILE_WRITE_VALID;
	assign when_HazardSimplePlugin_l57 = writeBack_arbitration_isValid & writeBack_REGFILE_WRITE_VALID;
	assign when_HazardSimplePlugin_l58 = 1'b0 | ~|when_HazardSimplePlugin_l47;
	assign when_HazardSimplePlugin_l45_1 = memory_arbitration_isValid & memory_REGFILE_WRITE_VALID;
	assign when_HazardSimplePlugin_l57_1 = memory_arbitration_isValid & memory_REGFILE_WRITE_VALID;
	assign when_HazardSimplePlugin_l58_1 = 1'b0 | ~|memory_BYPASSABLE_MEMORY_STAGE;
	assign when_HazardSimplePlugin_l45_2 = execute_arbitration_isValid & execute_REGFILE_WRITE_VALID;
	assign when_HazardSimplePlugin_l57_2 = execute_arbitration_isValid & execute_REGFILE_WRITE_VALID;
	assign when_HazardSimplePlugin_l58_2 = 1'b0 | ~|execute_BYPASSABLE_EXECUTE_STAGE;
	assign when_HazardSimplePlugin_l113 = decode_arbitration_isValid & (HazardSimplePlugin_src0Hazard | HazardSimplePlugin_src1Hazard);
	assign execute_BranchPlugin_missAlignedTarget = execute_BRANCH_COND_RESULT & _zz_execute_BranchPlugin_missAlignedTarget_6;
	assign BranchPlugin_jumpInterface_valid = (memory_arbitration_isValid & memory_BRANCH_DO) & 1'b1;
	assign BranchPlugin_jumpInterface_payload = memory_BRANCH_CALC;
	assign BranchPlugin_branchExceptionPort_valid = memory_arbitration_isValid & (memory_BRANCH_DO & memory_BRANCH_CALC[1]);
	assign BranchPlugin_branchExceptionPort_payload_badAddr = memory_BRANCH_CALC;
	assign IBusCachedPlugin_decodePrediction_rsp_wasWrong = BranchPlugin_jumpInterface_valid;
	assign CsrPlugin_sip_SEIP_OR = CsrPlugin_sip_SEIP_SOFT | CsrPlugin_sip_SEIP_INPUT;
	assign CsrPlugin_redoInterface_payload = decode_PC;
	assign when_CsrPlugin_l1153 = execute_arbitration_isValid & execute_RESCHEDULE_NEXT;
	assign _zz_when_CsrPlugin_l1302 = CsrPlugin_sip_STIP & CsrPlugin_sie_STIE;
	assign _zz_when_CsrPlugin_l1302_1 = CsrPlugin_sip_SSIP & CsrPlugin_sie_SSIE;
	assign _zz_when_CsrPlugin_l1302_2 = CsrPlugin_sip_SEIP_OR & CsrPlugin_sie_SEIE;
	assign _zz_when_CsrPlugin_l1302_3 = CsrPlugin_mip_MTIP & CsrPlugin_mie_MTIE;
	assign _zz_when_CsrPlugin_l1302_4 = CsrPlugin_mip_MSIP & CsrPlugin_mie_MSIE;
	assign _zz_when_CsrPlugin_l1302_5 = CsrPlugin_mip_MEIP & CsrPlugin_mie_MEIE;
	assign when_CsrPlugin_l1216 = (1'b1 & CsrPlugin_medeleg_IAM) & 1'b1;
	assign when_CsrPlugin_l1216_1 = (1'b1 & CsrPlugin_medeleg_IAF) & 1'b1;
	assign when_CsrPlugin_l1216_2 = (1'b1 & CsrPlugin_medeleg_II) & 1'b1;
	assign when_CsrPlugin_l1216_3 = (1'b1 & CsrPlugin_medeleg_LAM) & 1'b1;
	assign when_CsrPlugin_l1216_4 = (1'b1 & CsrPlugin_medeleg_LAF) & 1'b1;
	assign when_CsrPlugin_l1216_5 = (1'b1 & CsrPlugin_medeleg_SAM) & 1'b1;
	assign when_CsrPlugin_l1216_6 = (1'b1 & CsrPlugin_medeleg_SAF) & 1'b1;
	assign when_CsrPlugin_l1216_7 = (1'b1 & CsrPlugin_medeleg_EU) & 1'b1;
	assign when_CsrPlugin_l1216_8 = (1'b1 & CsrPlugin_medeleg_ES) & 1'b1;
	assign when_CsrPlugin_l1216_9 = (1'b1 & CsrPlugin_medeleg_IPF) & 1'b1;
	assign when_CsrPlugin_l1216_10 = (1'b1 & CsrPlugin_medeleg_LPF) & 1'b1;
	assign when_CsrPlugin_l1216_11 = (1'b1 & CsrPlugin_medeleg_SPF) & 1'b1;
	assign CsrPlugin_exceptionPendings_0 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
	assign CsrPlugin_exceptionPendings_1 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
	assign CsrPlugin_exceptionPendings_2 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
	assign CsrPlugin_exceptionPendings_3 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
	assign when_CsrPlugin_l1296 = (CsrPlugin_sstatus_SIE & (CsrPlugin_privilege == 2'h1)) | (2'h1 > CsrPlugin_privilege);
	assign when_CsrPlugin_l1296_1 = CsrPlugin_mstatus_MIE | (2'h3 > CsrPlugin_privilege);
	assign when_CsrPlugin_l1302 = (_zz_when_CsrPlugin_l1302 & (1'b1 & CsrPlugin_mideleg_ST)) & 1'b1;
	assign when_CsrPlugin_l1302_1 = (_zz_when_CsrPlugin_l1302_1 & (1'b1 & CsrPlugin_mideleg_SS)) & 1'b1;
	assign when_CsrPlugin_l1302_2 = (_zz_when_CsrPlugin_l1302_2 & (1'b1 & CsrPlugin_mideleg_SE)) & 1'b1;
	assign when_CsrPlugin_l1302_3 = (_zz_when_CsrPlugin_l1302 & 1'b1) & (CsrPlugin_mideleg_ST ~^ 1'b0);
	assign when_CsrPlugin_l1302_4 = (_zz_when_CsrPlugin_l1302_1 & 1'b1) & (CsrPlugin_mideleg_SS ~^ 1'b0);
	assign when_CsrPlugin_l1302_5 = (_zz_when_CsrPlugin_l1302_2 & 1'b1) & (CsrPlugin_mideleg_SE ~^ 1'b0);
	assign when_CsrPlugin_l1302_6 = (_zz_when_CsrPlugin_l1302_3 & 1'b1) & 1'b1;
	assign when_CsrPlugin_l1302_7 = (_zz_when_CsrPlugin_l1302_4 & 1'b1) & 1'b1;
	assign when_CsrPlugin_l1302_8 = (_zz_when_CsrPlugin_l1302_5 & 1'b1) & 1'b1;
	assign CsrPlugin_exception = CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack & CsrPlugin_allowException;
	assign CsrPlugin_pipelineLiberator_active = (CsrPlugin_interrupt_valid & CsrPlugin_allowInterrupts) & decode_arbitration_isValid;
	assign when_CsrPlugin_l1340 = ~|CsrPlugin_pipelineLiberator_active | decode_arbitration_removeIt;
	assign CsrPlugin_interruptJump = (CsrPlugin_interrupt_valid & CsrPlugin_pipelineLiberator_done) & CsrPlugin_allowInterrupts;
	assign when_CsrPlugin_l1390 = CsrPlugin_hadException | CsrPlugin_interruptJump;
	assign when_CsrPlugin_l1456 = writeBack_arbitration_isValid & (writeBack_ENV_CTRL == EnvCtrlEnum_XRET);
	assign contextSwitching = CsrPlugin_jumpInterface_valid;
	assign when_CsrPlugin_l1519 = execute_arbitration_isValid & (execute_ENV_CTRL == EnvCtrlEnum_WFI);
	assign execute_CsrPlugin_blockedBySideEffects = |{writeBack_arbitration_isValid, memory_arbitration_isValid} | 1'b0;
	assign CsrPlugin_selfException_payload_badAddr = execute_INSTRUCTION;
	assign when_CsrPlugin_l1540 = execute_CsrPlugin_illegalAccess | execute_CsrPlugin_illegalInstruction;
	assign when_CsrPlugin_l1547 = execute_arbitration_isValid & (execute_ENV_CTRL == EnvCtrlEnum_XRET);
	assign when_CsrPlugin_l1555 = execute_arbitration_isValid & (execute_ENV_CTRL == EnvCtrlEnum_ECALL);
	assign when_CsrPlugin_l1565 = (execute_arbitration_isValid & (execute_ENV_CTRL == EnvCtrlEnum_EBREAK)) & CsrPlugin_allowEbreakException;
	assign execute_CsrPlugin_writeEnable = execute_CsrPlugin_writeInstruction & ~|execute_arbitration_isStuck;
	assign execute_CsrPlugin_readEnable = execute_CsrPlugin_readInstruction & ~|execute_arbitration_isStuck;
	assign CsrPlugin_csrMapping_writeDataSignal = _zz_CsrPlugin_csrMapping_writeDataSignal;
	assign when_CsrPlugin_l1587 = execute_arbitration_isValid & execute_IS_CSR;
	assign when_CsrPlugin_l1591 = execute_arbitration_isValid & (execute_IS_CSR | execute_RESCHEDULE_NEXT);
	assign when_Pipeline_l124_2 = ~|writeBack_arbitration_isStuck & ~|CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
	assign _zz_decode_to_execute_SRC1_CTRL_1 = decode_SRC1_CTRL;
	assign _zz_decode_SRC1_CTRL = _zz_decode_SRC1_CTRL_1;
	assign _zz_execute_SRC1_CTRL = decode_to_execute_SRC1_CTRL;
	assign _zz_decode_to_execute_ALU_CTRL_1 = decode_ALU_CTRL;
	assign _zz_decode_ALU_CTRL = _zz_decode_ALU_CTRL_1;
	assign _zz_execute_ALU_CTRL = decode_to_execute_ALU_CTRL;
	assign _zz_decode_to_execute_SRC2_CTRL_1 = decode_SRC2_CTRL;
	assign _zz_decode_SRC2_CTRL = _zz_decode_SRC2_CTRL_1;
	assign _zz_execute_SRC2_CTRL = decode_to_execute_SRC2_CTRL;
	assign _zz_decode_to_execute_FPU_OPCODE_1 = decode_FPU_OPCODE;
	assign _zz_execute_to_memory_FPU_OPCODE_1 = execute_FPU_OPCODE;
	assign _zz_memory_to_writeBack_FPU_OPCODE_1 = memory_FPU_OPCODE;
	assign _zz_decode_FPU_OPCODE_1 = _zz_decode_FPU_OPCODE;
	assign _zz_execute_FPU_OPCODE = decode_to_execute_FPU_OPCODE;
	assign _zz_memory_FPU_OPCODE = execute_to_memory_FPU_OPCODE;
	assign _zz_writeBack_FPU_OPCODE = memory_to_writeBack_FPU_OPCODE;
	assign _zz_decode_FPU_FORMAT_1 = _zz_decode_FPU_FORMAT;
	assign _zz_decode_to_execute_ALU_BITWISE_CTRL_1 = decode_ALU_BITWISE_CTRL;
	assign _zz_decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL_1;
	assign _zz_execute_ALU_BITWISE_CTRL = decode_to_execute_ALU_BITWISE_CTRL;
	assign _zz_decode_to_execute_SHIFT_CTRL_1 = decode_SHIFT_CTRL;
	assign _zz_execute_to_memory_SHIFT_CTRL_1 = execute_SHIFT_CTRL;
	assign _zz_decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL_1;
	assign _zz_execute_SHIFT_CTRL = decode_to_execute_SHIFT_CTRL;
	assign _zz_memory_SHIFT_CTRL = execute_to_memory_SHIFT_CTRL;
	assign _zz_decode_to_execute_BRANCH_CTRL_1 = decode_BRANCH_CTRL;
	assign _zz_decode_BRANCH_CTRL_1 = _zz_decode_BRANCH_CTRL;
	assign _zz_execute_BRANCH_CTRL = decode_to_execute_BRANCH_CTRL;
	assign _zz_decode_to_execute_ENV_CTRL_1 = decode_ENV_CTRL;
	assign _zz_execute_to_memory_ENV_CTRL_1 = execute_ENV_CTRL;
	assign _zz_memory_to_writeBack_ENV_CTRL_1 = memory_ENV_CTRL;
	assign _zz_decode_ENV_CTRL = _zz_decode_ENV_CTRL_1;
	assign _zz_execute_ENV_CTRL = decode_to_execute_ENV_CTRL;
	assign _zz_memory_ENV_CTRL = execute_to_memory_ENV_CTRL;
	assign _zz_writeBack_ENV_CTRL = memory_to_writeBack_ENV_CTRL;
	assign decode_arbitration_isFlushed = ({writeBack_arbitration_flushNext, memory_arbitration_flushNext, execute_arbitration_flushNext} != 3'h0) | ({writeBack_arbitration_flushIt, memory_arbitration_flushIt, execute_arbitration_flushIt, decode_arbitration_flushIt} != 4'h0);
	assign execute_arbitration_isFlushed = ({writeBack_arbitration_flushNext, memory_arbitration_flushNext} != 2'h0) | ({writeBack_arbitration_flushIt, memory_arbitration_flushIt, execute_arbitration_flushIt} != 3'h0);
	assign memory_arbitration_isFlushed = (writeBack_arbitration_flushNext ^ 1'b0) | ({writeBack_arbitration_flushIt, memory_arbitration_flushIt} != 2'h0);
	assign writeBack_arbitration_isFlushed = 1'b0 | (writeBack_arbitration_flushIt ^ 1'b0);
	assign decode_arbitration_isStuckByOthers = decode_arbitration_haltByOther | (((1'b0 | execute_arbitration_isStuck) | memory_arbitration_isStuck) | writeBack_arbitration_isStuck);
	assign decode_arbitration_isStuck = decode_arbitration_haltItself | decode_arbitration_isStuckByOthers;
	assign decode_arbitration_isMoving = ~|decode_arbitration_isStuck & ~|decode_arbitration_removeIt;
	assign decode_arbitration_isFiring = (decode_arbitration_isValid & ~|decode_arbitration_isStuck) & ~|decode_arbitration_removeIt;
	assign execute_arbitration_isStuckByOthers = execute_arbitration_haltByOther | ((1'b0 | memory_arbitration_isStuck) | writeBack_arbitration_isStuck);
	assign execute_arbitration_isStuck = execute_arbitration_haltItself | execute_arbitration_isStuckByOthers;
	assign execute_arbitration_isMoving = ~|execute_arbitration_isStuck & ~|execute_arbitration_removeIt;
	assign execute_arbitration_isFiring = (execute_arbitration_isValid & ~|execute_arbitration_isStuck) & ~|execute_arbitration_removeIt;
	assign memory_arbitration_isStuckByOthers = memory_arbitration_haltByOther | (1'b0 | writeBack_arbitration_isStuck);
	assign memory_arbitration_isStuck = memory_arbitration_haltItself | memory_arbitration_isStuckByOthers;
	assign memory_arbitration_isMoving = ~|memory_arbitration_isStuck & ~|memory_arbitration_removeIt;
	assign memory_arbitration_isFiring = (memory_arbitration_isValid & ~|memory_arbitration_isStuck) & ~|memory_arbitration_removeIt;
	assign writeBack_arbitration_isStuckByOthers = writeBack_arbitration_haltByOther | 1'b0;
	assign writeBack_arbitration_isStuck = writeBack_arbitration_haltItself | writeBack_arbitration_isStuckByOthers;
	assign writeBack_arbitration_isMoving = ~|writeBack_arbitration_isStuck & ~|writeBack_arbitration_removeIt;
	assign writeBack_arbitration_isFiring = (writeBack_arbitration_isValid & ~|writeBack_arbitration_isStuck) & ~|writeBack_arbitration_removeIt;
	assign when_Pipeline_l151 = ~|execute_arbitration_isStuck | execute_arbitration_removeIt;
	assign when_Pipeline_l154 = ~|decode_arbitration_isStuck & ~|decode_arbitration_removeIt;
	assign when_Pipeline_l151_1 = ~|memory_arbitration_isStuck | memory_arbitration_removeIt;
	assign when_Pipeline_l154_1 = ~|execute_arbitration_isStuck & ~|execute_arbitration_removeIt;
	assign when_Pipeline_l151_2 = ~|writeBack_arbitration_isStuck | writeBack_arbitration_removeIt;
	assign when_Pipeline_l154_2 = ~|memory_arbitration_isStuck & ~|memory_arbitration_removeIt;
	assign when_CsrPlugin_l1076 = (2'h3 > CsrPlugin_privilege) & ~|CsrPlugin_mcounteren_CY;
	assign when_CsrPlugin_l1077 = (2'h1 > CsrPlugin_privilege) & ~|CsrPlugin_scounteren_CY;
	assign when_CsrPlugin_l1076_1 = (2'h3 > CsrPlugin_privilege) & ~|CsrPlugin_mcounteren_CY;
	assign when_CsrPlugin_l1077_1 = (2'h1 > CsrPlugin_privilege) & ~|CsrPlugin_scounteren_CY;
	assign when_CsrPlugin_l1076_2 = (2'h3 > CsrPlugin_privilege) & ~|CsrPlugin_mcounteren_IR;
	assign when_CsrPlugin_l1077_2 = (2'h1 > CsrPlugin_privilege) & ~|CsrPlugin_scounteren_IR;
	assign when_CsrPlugin_l1076_3 = (2'h3 > CsrPlugin_privilege) & ~|CsrPlugin_mcounteren_IR;
	assign when_CsrPlugin_l1077_3 = (2'h1 > CsrPlugin_privilege) & ~|CsrPlugin_scounteren_IR;
	assign CsrPlugin_csrMapping_readDataInit = ((((_zz_CsrPlugin_csrMapping_readDataInit_33 | _zz_CsrPlugin_csrMapping_readDataInit_34) | (_zz_CsrPlugin_csrMapping_readDataInit_35 | _zz_CsrPlugin_csrMapping_readDataInit_36)) | ((_zz_CsrPlugin_csrMapping_readDataInit_39 | _zz_CsrPlugin_csrMapping_readDataInit_42) | (_zz_CsrPlugin_csrMapping_readDataInit_43 | _zz_CsrPlugin_csrMapping_readDataInit_44))) | (((_zz_CsrPlugin_csrMapping_readDataInit_45 | _zz_CsrPlugin_csrMapping_readDataInit_46) | (_zz_CsrPlugin_csrMapping_readDataInit_47 | _zz_CsrPlugin_csrMapping_readDataInit_48)) | ((_zz_CsrPlugin_csrMapping_readDataInit_49 | _zz_CsrPlugin_csrMapping_readDataInit_50) | (_zz_CsrPlugin_csrMapping_readDataInit_51 | _zz_CsrPlugin_csrMapping_readDataInit_52)))) | (((_zz_CsrPlugin_csrMapping_readDataInit_28 | _zz_CsrPlugin_csrMapping_readDataInit_29) | (_zz_CsrPlugin_csrMapping_readDataInit_30 | _zz_CsrPlugin_csrMapping_readDataInit_31)) | _zz_CsrPlugin_csrMapping_readDataInit_32);
	assign when_CsrPlugin_l1702 = (execute_arbitration_isValid & execute_IS_CSR) & (({execute_CsrPlugin_csrAddress[11:2], 2'h0} == 12'h3a0) | ({execute_CsrPlugin_csrAddress[11:4], 4'h0} == 12'h3b0));
	assign when_CsrPlugin_l1718 = ~|execute_arbitration_isValid | ~|execute_IS_CSR;
	always @(posedge clk)
		if (_zz_decode_RegFilePlugin_rs1Data)
			_zz_RegFilePlugin_regFile_port0 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
	always @(posedge clk)
		if (_zz_decode_RegFilePlugin_rs2Data)
			_zz_RegFilePlugin_regFile_port1 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
	always @(posedge clk)
		if (_zz_1)
			RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
	always @(_zz_IBusCachedPlugin_jump_pcLoad_payload_7 or DBusCachedPlugin_redoBranch_payload or CsrPlugin_jumpInterface_payload or BranchPlugin_jumpInterface_payload or CsrPlugin_redoInterface_payload or IBusCachedPlugin_predictionJumpInterface_payload)
		case (_zz_IBusCachedPlugin_jump_pcLoad_payload_7)
			3'h0: _zz_IBusCachedPlugin_jump_pcLoad_payload_6 = DBusCachedPlugin_redoBranch_payload;
			3'h1: _zz_IBusCachedPlugin_jump_pcLoad_payload_6 = CsrPlugin_jumpInterface_payload;
			3'h2: _zz_IBusCachedPlugin_jump_pcLoad_payload_6 = BranchPlugin_jumpInterface_payload;
			3'h3: _zz_IBusCachedPlugin_jump_pcLoad_payload_6 = CsrPlugin_redoInterface_payload;
			default: _zz_IBusCachedPlugin_jump_pcLoad_payload_6 = IBusCachedPlugin_predictionJumpInterface_payload;
		endcase
	always @(_zz_writeBack_DBusCachedPlugin_rspShifted_1 or writeBack_DBusCachedPlugin_rspSplits_0 or writeBack_DBusCachedPlugin_rspSplits_1 or writeBack_DBusCachedPlugin_rspSplits_2 or writeBack_DBusCachedPlugin_rspSplits_3 or writeBack_DBusCachedPlugin_rspSplits_4 or writeBack_DBusCachedPlugin_rspSplits_5 or writeBack_DBusCachedPlugin_rspSplits_6 or writeBack_DBusCachedPlugin_rspSplits_7)
		case (_zz_writeBack_DBusCachedPlugin_rspShifted_1)
			3'h0: _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_0;
			3'h1: _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_1;
			3'h2: _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_2;
			3'h3: _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_3;
			3'h4: _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_4;
			3'h5: _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_5;
			3'h6: _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_6;
			default: _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_7;
		endcase
	always @(_zz_writeBack_DBusCachedPlugin_rspShifted_3 or writeBack_DBusCachedPlugin_rspSplits_1 or writeBack_DBusCachedPlugin_rspSplits_3 or writeBack_DBusCachedPlugin_rspSplits_5 or writeBack_DBusCachedPlugin_rspSplits_7)
		case (_zz_writeBack_DBusCachedPlugin_rspShifted_3)
			2'h0: _zz_writeBack_DBusCachedPlugin_rspShifted_2 = writeBack_DBusCachedPlugin_rspSplits_1;
			2'h1: _zz_writeBack_DBusCachedPlugin_rspShifted_2 = writeBack_DBusCachedPlugin_rspSplits_3;
			2'h2: _zz_writeBack_DBusCachedPlugin_rspShifted_2 = writeBack_DBusCachedPlugin_rspSplits_5;
			default: _zz_writeBack_DBusCachedPlugin_rspShifted_2 = writeBack_DBusCachedPlugin_rspSplits_7;
		endcase
	always @(_zz_writeBack_DBusCachedPlugin_rspShifted_5 or writeBack_DBusCachedPlugin_rspSplits_2 or writeBack_DBusCachedPlugin_rspSplits_6)
		case (_zz_writeBack_DBusCachedPlugin_rspShifted_5)
			1'b0: _zz_writeBack_DBusCachedPlugin_rspShifted_4 = writeBack_DBusCachedPlugin_rspSplits_2;
			default: _zz_writeBack_DBusCachedPlugin_rspShifted_4 = writeBack_DBusCachedPlugin_rspSplits_6;
		endcase
	always @(_zz_writeBack_DBusCachedPlugin_rspShifted_7 or writeBack_DBusCachedPlugin_rspSplits_3 or writeBack_DBusCachedPlugin_rspSplits_7)
		case (_zz_writeBack_DBusCachedPlugin_rspShifted_7)
			1'b0: _zz_writeBack_DBusCachedPlugin_rspShifted_6 = writeBack_DBusCachedPlugin_rspSplits_3;
			default: _zz_writeBack_DBusCachedPlugin_rspShifted_6 = writeBack_DBusCachedPlugin_rspSplits_7;
		endcase
	always @(_zz_MmuPlugin_ports_0_cacheLine_valid_3 or MmuPlugin_ports_0_cache_0_valid or MmuPlugin_ports_0_cache_0_exception or MmuPlugin_ports_0_cache_0_superPage or MmuPlugin_ports_0_cache_0_virtualAddress_0 or MmuPlugin_ports_0_cache_0_virtualAddress_1 or MmuPlugin_ports_0_cache_0_physicalAddress_0 or MmuPlugin_ports_0_cache_0_physicalAddress_1 or MmuPlugin_ports_0_cache_0_allowRead or MmuPlugin_ports_0_cache_0_allowWrite or MmuPlugin_ports_0_cache_0_allowExecute or MmuPlugin_ports_0_cache_0_allowUser or MmuPlugin_ports_0_cache_1_valid or MmuPlugin_ports_0_cache_1_exception or MmuPlugin_ports_0_cache_1_superPage or MmuPlugin_ports_0_cache_1_virtualAddress_0 or MmuPlugin_ports_0_cache_1_virtualAddress_1 or MmuPlugin_ports_0_cache_1_physicalAddress_0 or MmuPlugin_ports_0_cache_1_physicalAddress_1 or MmuPlugin_ports_0_cache_1_allowRead or MmuPlugin_ports_0_cache_1_allowWrite or MmuPlugin_ports_0_cache_1_allowExecute or MmuPlugin_ports_0_cache_1_allowUser or MmuPlugin_ports_0_cache_2_valid or MmuPlugin_ports_0_cache_2_exception or MmuPlugin_ports_0_cache_2_superPage or MmuPlugin_ports_0_cache_2_virtualAddress_0 or MmuPlugin_ports_0_cache_2_virtualAddress_1 or MmuPlugin_ports_0_cache_2_physicalAddress_0 or MmuPlugin_ports_0_cache_2_physicalAddress_1 or MmuPlugin_ports_0_cache_2_allowRead or MmuPlugin_ports_0_cache_2_allowWrite or MmuPlugin_ports_0_cache_2_allowExecute or MmuPlugin_ports_0_cache_2_allowUser or MmuPlugin_ports_0_cache_3_valid or MmuPlugin_ports_0_cache_3_exception or MmuPlugin_ports_0_cache_3_superPage or MmuPlugin_ports_0_cache_3_virtualAddress_0 or MmuPlugin_ports_0_cache_3_virtualAddress_1 or MmuPlugin_ports_0_cache_3_physicalAddress_0 or MmuPlugin_ports_0_cache_3_physicalAddress_1 or MmuPlugin_ports_0_cache_3_allowRead or MmuPlugin_ports_0_cache_3_allowWrite or MmuPlugin_ports_0_cache_3_allowExecute or MmuPlugin_ports_0_cache_3_allowUser)
		case (_zz_MmuPlugin_ports_0_cacheLine_valid_3)
			2'h0: begin
				_zz_MmuPlugin_ports_0_cacheLine_valid_4 = MmuPlugin_ports_0_cache_0_valid;
				_zz_MmuPlugin_ports_0_cacheLine_exception = MmuPlugin_ports_0_cache_0_exception;
				_zz_MmuPlugin_ports_0_cacheLine_superPage = MmuPlugin_ports_0_cache_0_superPage;
				_zz_MmuPlugin_ports_0_cacheLine_virtualAddress_0 = MmuPlugin_ports_0_cache_0_virtualAddress_0;
				_zz_MmuPlugin_ports_0_cacheLine_virtualAddress_1 = MmuPlugin_ports_0_cache_0_virtualAddress_1;
				_zz_MmuPlugin_ports_0_cacheLine_physicalAddress_0 = MmuPlugin_ports_0_cache_0_physicalAddress_0;
				_zz_MmuPlugin_ports_0_cacheLine_physicalAddress_1 = MmuPlugin_ports_0_cache_0_physicalAddress_1;
				_zz_MmuPlugin_ports_0_cacheLine_allowRead = MmuPlugin_ports_0_cache_0_allowRead;
				_zz_MmuPlugin_ports_0_cacheLine_allowWrite = MmuPlugin_ports_0_cache_0_allowWrite;
				_zz_MmuPlugin_ports_0_cacheLine_allowExecute = MmuPlugin_ports_0_cache_0_allowExecute;
				_zz_MmuPlugin_ports_0_cacheLine_allowUser = MmuPlugin_ports_0_cache_0_allowUser;
			end
			2'h1: begin
				_zz_MmuPlugin_ports_0_cacheLine_valid_4 = MmuPlugin_ports_0_cache_1_valid;
				_zz_MmuPlugin_ports_0_cacheLine_exception = MmuPlugin_ports_0_cache_1_exception;
				_zz_MmuPlugin_ports_0_cacheLine_superPage = MmuPlugin_ports_0_cache_1_superPage;
				_zz_MmuPlugin_ports_0_cacheLine_virtualAddress_0 = MmuPlugin_ports_0_cache_1_virtualAddress_0;
				_zz_MmuPlugin_ports_0_cacheLine_virtualAddress_1 = MmuPlugin_ports_0_cache_1_virtualAddress_1;
				_zz_MmuPlugin_ports_0_cacheLine_physicalAddress_0 = MmuPlugin_ports_0_cache_1_physicalAddress_0;
				_zz_MmuPlugin_ports_0_cacheLine_physicalAddress_1 = MmuPlugin_ports_0_cache_1_physicalAddress_1;
				_zz_MmuPlugin_ports_0_cacheLine_allowRead = MmuPlugin_ports_0_cache_1_allowRead;
				_zz_MmuPlugin_ports_0_cacheLine_allowWrite = MmuPlugin_ports_0_cache_1_allowWrite;
				_zz_MmuPlugin_ports_0_cacheLine_allowExecute = MmuPlugin_ports_0_cache_1_allowExecute;
				_zz_MmuPlugin_ports_0_cacheLine_allowUser = MmuPlugin_ports_0_cache_1_allowUser;
			end
			2'h2: begin
				_zz_MmuPlugin_ports_0_cacheLine_valid_4 = MmuPlugin_ports_0_cache_2_valid;
				_zz_MmuPlugin_ports_0_cacheLine_exception = MmuPlugin_ports_0_cache_2_exception;
				_zz_MmuPlugin_ports_0_cacheLine_superPage = MmuPlugin_ports_0_cache_2_superPage;
				_zz_MmuPlugin_ports_0_cacheLine_virtualAddress_0 = MmuPlugin_ports_0_cache_2_virtualAddress_0;
				_zz_MmuPlugin_ports_0_cacheLine_virtualAddress_1 = MmuPlugin_ports_0_cache_2_virtualAddress_1;
				_zz_MmuPlugin_ports_0_cacheLine_physicalAddress_0 = MmuPlugin_ports_0_cache_2_physicalAddress_0;
				_zz_MmuPlugin_ports_0_cacheLine_physicalAddress_1 = MmuPlugin_ports_0_cache_2_physicalAddress_1;
				_zz_MmuPlugin_ports_0_cacheLine_allowRead = MmuPlugin_ports_0_cache_2_allowRead;
				_zz_MmuPlugin_ports_0_cacheLine_allowWrite = MmuPlugin_ports_0_cache_2_allowWrite;
				_zz_MmuPlugin_ports_0_cacheLine_allowExecute = MmuPlugin_ports_0_cache_2_allowExecute;
				_zz_MmuPlugin_ports_0_cacheLine_allowUser = MmuPlugin_ports_0_cache_2_allowUser;
			end
			default: begin
				_zz_MmuPlugin_ports_0_cacheLine_valid_4 = MmuPlugin_ports_0_cache_3_valid;
				_zz_MmuPlugin_ports_0_cacheLine_exception = MmuPlugin_ports_0_cache_3_exception;
				_zz_MmuPlugin_ports_0_cacheLine_superPage = MmuPlugin_ports_0_cache_3_superPage;
				_zz_MmuPlugin_ports_0_cacheLine_virtualAddress_0 = MmuPlugin_ports_0_cache_3_virtualAddress_0;
				_zz_MmuPlugin_ports_0_cacheLine_virtualAddress_1 = MmuPlugin_ports_0_cache_3_virtualAddress_1;
				_zz_MmuPlugin_ports_0_cacheLine_physicalAddress_0 = MmuPlugin_ports_0_cache_3_physicalAddress_0;
				_zz_MmuPlugin_ports_0_cacheLine_physicalAddress_1 = MmuPlugin_ports_0_cache_3_physicalAddress_1;
				_zz_MmuPlugin_ports_0_cacheLine_allowRead = MmuPlugin_ports_0_cache_3_allowRead;
				_zz_MmuPlugin_ports_0_cacheLine_allowWrite = MmuPlugin_ports_0_cache_3_allowWrite;
				_zz_MmuPlugin_ports_0_cacheLine_allowExecute = MmuPlugin_ports_0_cache_3_allowExecute;
				_zz_MmuPlugin_ports_0_cacheLine_allowUser = MmuPlugin_ports_0_cache_3_allowUser;
			end
		endcase
	always @(_zz_MmuPlugin_ports_1_cacheLine_valid_3 or MmuPlugin_ports_1_cache_0_valid or MmuPlugin_ports_1_cache_0_exception or MmuPlugin_ports_1_cache_0_superPage or MmuPlugin_ports_1_cache_0_virtualAddress_0 or MmuPlugin_ports_1_cache_0_virtualAddress_1 or MmuPlugin_ports_1_cache_0_physicalAddress_0 or MmuPlugin_ports_1_cache_0_physicalAddress_1 or MmuPlugin_ports_1_cache_0_allowRead or MmuPlugin_ports_1_cache_0_allowWrite or MmuPlugin_ports_1_cache_0_allowExecute or MmuPlugin_ports_1_cache_0_allowUser or MmuPlugin_ports_1_cache_1_valid or MmuPlugin_ports_1_cache_1_exception or MmuPlugin_ports_1_cache_1_superPage or MmuPlugin_ports_1_cache_1_virtualAddress_0 or MmuPlugin_ports_1_cache_1_virtualAddress_1 or MmuPlugin_ports_1_cache_1_physicalAddress_0 or MmuPlugin_ports_1_cache_1_physicalAddress_1 or MmuPlugin_ports_1_cache_1_allowRead or MmuPlugin_ports_1_cache_1_allowWrite or MmuPlugin_ports_1_cache_1_allowExecute or MmuPlugin_ports_1_cache_1_allowUser or MmuPlugin_ports_1_cache_2_valid or MmuPlugin_ports_1_cache_2_exception or MmuPlugin_ports_1_cache_2_superPage or MmuPlugin_ports_1_cache_2_virtualAddress_0 or MmuPlugin_ports_1_cache_2_virtualAddress_1 or MmuPlugin_ports_1_cache_2_physicalAddress_0 or MmuPlugin_ports_1_cache_2_physicalAddress_1 or MmuPlugin_ports_1_cache_2_allowRead or MmuPlugin_ports_1_cache_2_allowWrite or MmuPlugin_ports_1_cache_2_allowExecute or MmuPlugin_ports_1_cache_2_allowUser or MmuPlugin_ports_1_cache_3_valid or MmuPlugin_ports_1_cache_3_exception or MmuPlugin_ports_1_cache_3_superPage or MmuPlugin_ports_1_cache_3_virtualAddress_0 or MmuPlugin_ports_1_cache_3_virtualAddress_1 or MmuPlugin_ports_1_cache_3_physicalAddress_0 or MmuPlugin_ports_1_cache_3_physicalAddress_1 or MmuPlugin_ports_1_cache_3_allowRead or MmuPlugin_ports_1_cache_3_allowWrite or MmuPlugin_ports_1_cache_3_allowExecute or MmuPlugin_ports_1_cache_3_allowUser)
		case (_zz_MmuPlugin_ports_1_cacheLine_valid_3)
			2'h0: begin
				_zz_MmuPlugin_ports_1_cacheLine_valid_4 = MmuPlugin_ports_1_cache_0_valid;
				_zz_MmuPlugin_ports_1_cacheLine_exception = MmuPlugin_ports_1_cache_0_exception;
				_zz_MmuPlugin_ports_1_cacheLine_superPage = MmuPlugin_ports_1_cache_0_superPage;
				_zz_MmuPlugin_ports_1_cacheLine_virtualAddress_0 = MmuPlugin_ports_1_cache_0_virtualAddress_0;
				_zz_MmuPlugin_ports_1_cacheLine_virtualAddress_1 = MmuPlugin_ports_1_cache_0_virtualAddress_1;
				_zz_MmuPlugin_ports_1_cacheLine_physicalAddress_0 = MmuPlugin_ports_1_cache_0_physicalAddress_0;
				_zz_MmuPlugin_ports_1_cacheLine_physicalAddress_1 = MmuPlugin_ports_1_cache_0_physicalAddress_1;
				_zz_MmuPlugin_ports_1_cacheLine_allowRead = MmuPlugin_ports_1_cache_0_allowRead;
				_zz_MmuPlugin_ports_1_cacheLine_allowWrite = MmuPlugin_ports_1_cache_0_allowWrite;
				_zz_MmuPlugin_ports_1_cacheLine_allowExecute = MmuPlugin_ports_1_cache_0_allowExecute;
				_zz_MmuPlugin_ports_1_cacheLine_allowUser = MmuPlugin_ports_1_cache_0_allowUser;
			end
			2'h1: begin
				_zz_MmuPlugin_ports_1_cacheLine_valid_4 = MmuPlugin_ports_1_cache_1_valid;
				_zz_MmuPlugin_ports_1_cacheLine_exception = MmuPlugin_ports_1_cache_1_exception;
				_zz_MmuPlugin_ports_1_cacheLine_superPage = MmuPlugin_ports_1_cache_1_superPage;
				_zz_MmuPlugin_ports_1_cacheLine_virtualAddress_0 = MmuPlugin_ports_1_cache_1_virtualAddress_0;
				_zz_MmuPlugin_ports_1_cacheLine_virtualAddress_1 = MmuPlugin_ports_1_cache_1_virtualAddress_1;
				_zz_MmuPlugin_ports_1_cacheLine_physicalAddress_0 = MmuPlugin_ports_1_cache_1_physicalAddress_0;
				_zz_MmuPlugin_ports_1_cacheLine_physicalAddress_1 = MmuPlugin_ports_1_cache_1_physicalAddress_1;
				_zz_MmuPlugin_ports_1_cacheLine_allowRead = MmuPlugin_ports_1_cache_1_allowRead;
				_zz_MmuPlugin_ports_1_cacheLine_allowWrite = MmuPlugin_ports_1_cache_1_allowWrite;
				_zz_MmuPlugin_ports_1_cacheLine_allowExecute = MmuPlugin_ports_1_cache_1_allowExecute;
				_zz_MmuPlugin_ports_1_cacheLine_allowUser = MmuPlugin_ports_1_cache_1_allowUser;
			end
			2'h2: begin
				_zz_MmuPlugin_ports_1_cacheLine_valid_4 = MmuPlugin_ports_1_cache_2_valid;
				_zz_MmuPlugin_ports_1_cacheLine_exception = MmuPlugin_ports_1_cache_2_exception;
				_zz_MmuPlugin_ports_1_cacheLine_superPage = MmuPlugin_ports_1_cache_2_superPage;
				_zz_MmuPlugin_ports_1_cacheLine_virtualAddress_0 = MmuPlugin_ports_1_cache_2_virtualAddress_0;
				_zz_MmuPlugin_ports_1_cacheLine_virtualAddress_1 = MmuPlugin_ports_1_cache_2_virtualAddress_1;
				_zz_MmuPlugin_ports_1_cacheLine_physicalAddress_0 = MmuPlugin_ports_1_cache_2_physicalAddress_0;
				_zz_MmuPlugin_ports_1_cacheLine_physicalAddress_1 = MmuPlugin_ports_1_cache_2_physicalAddress_1;
				_zz_MmuPlugin_ports_1_cacheLine_allowRead = MmuPlugin_ports_1_cache_2_allowRead;
				_zz_MmuPlugin_ports_1_cacheLine_allowWrite = MmuPlugin_ports_1_cache_2_allowWrite;
				_zz_MmuPlugin_ports_1_cacheLine_allowExecute = MmuPlugin_ports_1_cache_2_allowExecute;
				_zz_MmuPlugin_ports_1_cacheLine_allowUser = MmuPlugin_ports_1_cache_2_allowUser;
			end
			default: begin
				_zz_MmuPlugin_ports_1_cacheLine_valid_4 = MmuPlugin_ports_1_cache_3_valid;
				_zz_MmuPlugin_ports_1_cacheLine_exception = MmuPlugin_ports_1_cache_3_exception;
				_zz_MmuPlugin_ports_1_cacheLine_superPage = MmuPlugin_ports_1_cache_3_superPage;
				_zz_MmuPlugin_ports_1_cacheLine_virtualAddress_0 = MmuPlugin_ports_1_cache_3_virtualAddress_0;
				_zz_MmuPlugin_ports_1_cacheLine_virtualAddress_1 = MmuPlugin_ports_1_cache_3_virtualAddress_1;
				_zz_MmuPlugin_ports_1_cacheLine_physicalAddress_0 = MmuPlugin_ports_1_cache_3_physicalAddress_0;
				_zz_MmuPlugin_ports_1_cacheLine_physicalAddress_1 = MmuPlugin_ports_1_cache_3_physicalAddress_1;
				_zz_MmuPlugin_ports_1_cacheLine_allowRead = MmuPlugin_ports_1_cache_3_allowRead;
				_zz_MmuPlugin_ports_1_cacheLine_allowWrite = MmuPlugin_ports_1_cache_3_allowWrite;
				_zz_MmuPlugin_ports_1_cacheLine_allowExecute = MmuPlugin_ports_1_cache_3_allowExecute;
				_zz_MmuPlugin_ports_1_cacheLine_allowUser = MmuPlugin_ports_1_cache_3_allowUser;
			end
		endcase
	always @(execute_REGFILE_WRITE_DATA or when_CsrPlugin_l1587 or CsrPlugin_csrMapping_readDataSignal or DBusCachedPlugin_forceDatapath or MmuPlugin_dBusAccess_cmd_payload_address) begin
		_zz_decode_RS2 = execute_REGFILE_WRITE_DATA;
		if (when_CsrPlugin_l1587)
			_zz_decode_RS2 = CsrPlugin_csrMapping_readDataSignal;
		if (DBusCachedPlugin_forceDatapath)
			_zz_decode_RS2 = MmuPlugin_dBusAccess_cmd_payload_address;
	end
	always @(decode_RegFilePlugin_rs2Data or HazardSimplePlugin_writeBackBuffer_valid or HazardSimplePlugin_addr1Match or HazardSimplePlugin_writeBackBuffer_payload_data or when_HazardSimplePlugin_l45 or when_HazardSimplePlugin_l47 or when_HazardSimplePlugin_l51 or _zz_decode_RS2_2 or when_HazardSimplePlugin_l45_1 or memory_BYPASSABLE_MEMORY_STAGE or when_HazardSimplePlugin_l51_1 or _zz_decode_RS2_1 or when_HazardSimplePlugin_l45_2 or execute_BYPASSABLE_EXECUTE_STAGE or when_HazardSimplePlugin_l51_2 or _zz_decode_RS2) begin
		decode_RS2 = decode_RegFilePlugin_rs2Data;
		if (HazardSimplePlugin_writeBackBuffer_valid) begin
			if (HazardSimplePlugin_addr1Match)
				decode_RS2 = HazardSimplePlugin_writeBackBuffer_payload_data;
		end
		if (when_HazardSimplePlugin_l45) begin
			if (when_HazardSimplePlugin_l47) begin
				if (when_HazardSimplePlugin_l51)
					decode_RS2 = _zz_decode_RS2_2;
			end
		end
		if (when_HazardSimplePlugin_l45_1) begin
			if (memory_BYPASSABLE_MEMORY_STAGE) begin
				if (when_HazardSimplePlugin_l51_1)
					decode_RS2 = _zz_decode_RS2_1;
			end
		end
		if (when_HazardSimplePlugin_l45_2) begin
			if (execute_BYPASSABLE_EXECUTE_STAGE) begin
				if (when_HazardSimplePlugin_l51_2)
					decode_RS2 = _zz_decode_RS2;
			end
		end
	end
	always @(decode_RegFilePlugin_rs1Data or HazardSimplePlugin_writeBackBuffer_valid or HazardSimplePlugin_addr0Match or HazardSimplePlugin_writeBackBuffer_payload_data or when_HazardSimplePlugin_l45 or when_HazardSimplePlugin_l47 or when_HazardSimplePlugin_l48 or _zz_decode_RS2_2 or when_HazardSimplePlugin_l45_1 or memory_BYPASSABLE_MEMORY_STAGE or when_HazardSimplePlugin_l48_1 or _zz_decode_RS2_1 or when_HazardSimplePlugin_l45_2 or execute_BYPASSABLE_EXECUTE_STAGE or when_HazardSimplePlugin_l48_2 or _zz_decode_RS2) begin
		decode_RS1 = decode_RegFilePlugin_rs1Data;
		if (HazardSimplePlugin_writeBackBuffer_valid) begin
			if (HazardSimplePlugin_addr0Match)
				decode_RS1 = HazardSimplePlugin_writeBackBuffer_payload_data;
		end
		if (when_HazardSimplePlugin_l45) begin
			if (when_HazardSimplePlugin_l47) begin
				if (when_HazardSimplePlugin_l48)
					decode_RS1 = _zz_decode_RS2_2;
			end
		end
		if (when_HazardSimplePlugin_l45_1) begin
			if (memory_BYPASSABLE_MEMORY_STAGE) begin
				if (when_HazardSimplePlugin_l48_1)
					decode_RS1 = _zz_decode_RS2_1;
			end
		end
		if (when_HazardSimplePlugin_l45_2) begin
			if (execute_BYPASSABLE_EXECUTE_STAGE) begin
				if (when_HazardSimplePlugin_l48_2)
					decode_RS1 = _zz_decode_RS2;
			end
		end
	end
	always @(memory_REGFILE_WRITE_DATA or memory_arbitration_isValid or memory_SHIFT_CTRL or _zz_decode_RS2_3 or memory_SHIFT_RIGHT or when_MulDivIterativePlugin_l128 or memory_DivPlugin_div_result) begin
		_zz_decode_RS2_1 = memory_REGFILE_WRITE_DATA;
		if (memory_arbitration_isValid)
			case (memory_SHIFT_CTRL)
				ShiftCtrlEnum_SLL_1: _zz_decode_RS2_1 = _zz_decode_RS2_3;
				ShiftCtrlEnum_SRL_1: _zz_decode_RS2_1 = memory_SHIFT_RIGHT;
				ShiftCtrlEnum_SRA_1: _zz_decode_RS2_1 = memory_SHIFT_RIGHT;
				default:
					;
			endcase
		if (when_MulDivIterativePlugin_l128)
			_zz_decode_RS2_1 = memory_DivPlugin_div_result;
	end
	always @(lastStageRegFileWrite_valid) begin
		_zz_1 = 1'b0;
		if (lastStageRegFileWrite_valid)
			_zz_1 = 1'b1;
	end
	always @(_zz_decode_IS_CSR or when_RegFilePlugin_l63) begin
		decode_REGFILE_WRITE_VALID = _zz_decode_IS_CSR[11];
		if (when_RegFilePlugin_l63)
			decode_REGFILE_WRITE_VALID = 1'b0;
	end
	always @(memory_FPU_FORKED or memory_arbitration_isStuck) begin
		_zz_memory_to_writeBack_FPU_FORKED = memory_FPU_FORKED;
		if (memory_arbitration_isStuck)
			_zz_memory_to_writeBack_FPU_FORKED = 1'b0;
	end
	always @(execute_FPU_FORKED or execute_arbitration_isStuck) begin
		_zz_execute_to_memory_FPU_FORKED = execute_FPU_FORKED;
		if (execute_arbitration_isStuck)
			_zz_execute_to_memory_FPU_FORKED = 1'b0;
	end
	always @(decode_FPU_FORKED or decode_arbitration_isStuck) begin
		_zz_decode_to_execute_FPU_FORKED = decode_FPU_FORKED;
		if (decode_arbitration_isStuck)
			_zz_decode_to_execute_FPU_FORKED = 1'b0;
	end
	always @(writeBack_FpuPlugin_isRsp or writeBack_arbitration_isValid) begin
		DBusBypass0_cond = 1'b0;
		if (writeBack_FpuPlugin_isRsp) begin
			if (writeBack_arbitration_isValid)
				DBusBypass0_cond = 1'b1;
		end
	end
	always @(_zz_decode_FPU_ENABLE or when_FpuPlugin_l272) begin
		decode_FPU_ENABLE = _zz_decode_FPU_ENABLE;
		if (when_FpuPlugin_l272)
			decode_FPU_ENABLE = 1'b0;
	end
	always @(decode_INSTRUCTION or _zz_decode_LEGAL_INSTRUCTION or _zz_decode_LEGAL_INSTRUCTION_1 or _zz_decode_LEGAL_INSTRUCTION_2 or _zz_decode_LEGAL_INSTRUCTION_3 or _zz_decode_LEGAL_INSTRUCTION_4 or _zz_decode_LEGAL_INSTRUCTION_5 or decode_FpuPlugin_trap) begin
		decode_LEGAL_INSTRUCTION = |{(decode_INSTRUCTION & 32'h0000005f) == 32'h00000017, (decode_INSTRUCTION & 32'h04000073) == 32'h00000043, (decode_INSTRUCTION & 32'h0000007f) == 32'h0000006f, (decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION) == 32'h00001073, _zz_decode_LEGAL_INSTRUCTION_1 == _zz_decode_LEGAL_INSTRUCTION_2, _zz_decode_LEGAL_INSTRUCTION_3, _zz_decode_LEGAL_INSTRUCTION_4, _zz_decode_LEGAL_INSTRUCTION_5};
		if (decode_FpuPlugin_trap)
			decode_LEGAL_INSTRUCTION = 1'b0;
	end
	always @(writeBack_REGFILE_WRITE_DATA or when_DBusCachedPlugin_l568 or writeBack_DBusCachedPlugin_rspFormated or writeBack_FpuPlugin_isRsp or writeBack_arbitration_isValid or FpuPlugin_port_rsp_payload_value or when_MulPlugin_l147 or switch_MulPlugin_l148 or _zz__zz_decode_RS2_2 or _zz__zz_decode_RS2_2_1) begin
		_zz_decode_RS2_2 = writeBack_REGFILE_WRITE_DATA;
		if (when_DBusCachedPlugin_l568)
			_zz_decode_RS2_2 = writeBack_DBusCachedPlugin_rspFormated;
		if (writeBack_FpuPlugin_isRsp) begin
			if (writeBack_arbitration_isValid)
				_zz_decode_RS2_2 = FpuPlugin_port_rsp_payload_value[31:0];
		end
		if (when_MulPlugin_l147)
			case (switch_MulPlugin_l148)
				2'h0: _zz_decode_RS2_2 = _zz__zz_decode_RS2_2;
				default: _zz_decode_RS2_2 = _zz__zz_decode_RS2_2_1;
			endcase
	end
	always @(IBusCachedPlugin_rsp_issueDetected_3 or when_IBusCachedPlugin_l262) begin
		IBusCachedPlugin_rsp_issueDetected_4 = IBusCachedPlugin_rsp_issueDetected_3;
		if (when_IBusCachedPlugin_l262)
			IBusCachedPlugin_rsp_issueDetected_4 = 1'b1;
	end
	always @(IBusCachedPlugin_rsp_issueDetected_2 or when_IBusCachedPlugin_l256) begin
		IBusCachedPlugin_rsp_issueDetected_3 = IBusCachedPlugin_rsp_issueDetected_2;
		if (when_IBusCachedPlugin_l256)
			IBusCachedPlugin_rsp_issueDetected_3 = 1'b1;
	end
	always @(IBusCachedPlugin_rsp_issueDetected_1 or when_IBusCachedPlugin_l250) begin
		IBusCachedPlugin_rsp_issueDetected_2 = IBusCachedPlugin_rsp_issueDetected_1;
		if (when_IBusCachedPlugin_l250)
			IBusCachedPlugin_rsp_issueDetected_2 = 1'b1;
	end
	always @(IBusCachedPlugin_rsp_issueDetected or when_IBusCachedPlugin_l245) begin
		IBusCachedPlugin_rsp_issueDetected_1 = IBusCachedPlugin_rsp_issueDetected;
		if (when_IBusCachedPlugin_l245)
			IBusCachedPlugin_rsp_issueDetected_1 = 1'b1;
	end
	always @(execute_FORMAL_PC_NEXT or CsrPlugin_redoInterface_valid or CsrPlugin_redoInterface_payload) begin
		_zz_execute_to_memory_FORMAL_PC_NEXT = execute_FORMAL_PC_NEXT;
		if (CsrPlugin_redoInterface_valid)
			_zz_execute_to_memory_FORMAL_PC_NEXT = CsrPlugin_redoInterface_payload;
	end
	always @(memory_FORMAL_PC_NEXT or BranchPlugin_jumpInterface_valid or BranchPlugin_jumpInterface_payload) begin
		_zz_memory_to_writeBack_FORMAL_PC_NEXT = memory_FORMAL_PC_NEXT;
		if (BranchPlugin_jumpInterface_valid)
			_zz_memory_to_writeBack_FORMAL_PC_NEXT = BranchPlugin_jumpInterface_payload;
	end
	always @(decode_FORMAL_PC_NEXT or IBusCachedPlugin_predictionJumpInterface_valid or IBusCachedPlugin_predictionJumpInterface_payload) begin
		_zz_decode_to_execute_FORMAL_PC_NEXT = decode_FORMAL_PC_NEXT;
		if (IBusCachedPlugin_predictionJumpInterface_valid)
			_zz_decode_to_execute_FORMAL_PC_NEXT = IBusCachedPlugin_predictionJumpInterface_payload;
	end
	always @(when_DBusCachedPlugin_l341 or when_FpuPlugin_l273 or FpuPlugin_port_cmd_isStall) begin
		decode_arbitration_haltItself = 1'b0;
		if (when_DBusCachedPlugin_l341)
			decode_arbitration_haltItself = 1'b1;
		if (when_FpuPlugin_l273)
			decode_arbitration_haltItself = 1'b1;
		if (FpuPlugin_port_cmd_isStall)
			decode_arbitration_haltItself = 1'b1;
	end
	always @(MmuPlugin_dBusAccess_cmd_valid or when_HazardSimplePlugin_l113 or CsrPlugin_rescheduleLogic_rescheduleNext or CsrPlugin_pipelineLiberator_active or when_CsrPlugin_l1527) begin
		decode_arbitration_haltByOther = 1'b0;
		if (MmuPlugin_dBusAccess_cmd_valid)
			decode_arbitration_haltByOther = 1'b1;
		if (when_HazardSimplePlugin_l113)
			decode_arbitration_haltByOther = 1'b1;
		if (CsrPlugin_rescheduleLogic_rescheduleNext)
			decode_arbitration_haltByOther = 1'b1;
		if (CsrPlugin_pipelineLiberator_active)
			decode_arbitration_haltByOther = 1'b1;
		if (when_CsrPlugin_l1527)
			decode_arbitration_haltByOther = 1'b1;
	end
	always @(_zz_when or decode_arbitration_isFlushed) begin
		decode_arbitration_removeIt = 1'b0;
		if (_zz_when)
			decode_arbitration_removeIt = 1'b1;
		if (decode_arbitration_isFlushed)
			decode_arbitration_removeIt = 1'b1;
	end
	always @(IBusCachedPlugin_predictionJumpInterface_valid or _zz_when) begin
		decode_arbitration_flushNext = 1'b0;
		if (IBusCachedPlugin_predictionJumpInterface_valid)
			decode_arbitration_flushNext = 1'b1;
		if (_zz_when)
			decode_arbitration_flushNext = 1'b1;
	end
	always @(when_DBusCachedPlugin_l383 or when_CsrPlugin_l1519 or when_CsrPlugin_l1521 or when_CsrPlugin_l1591 or execute_CsrPlugin_blockedBySideEffects) begin
		execute_arbitration_haltItself = 1'b0;
		if (when_DBusCachedPlugin_l383)
			execute_arbitration_haltItself = 1'b1;
		if (when_CsrPlugin_l1519) begin
			if (when_CsrPlugin_l1521)
				execute_arbitration_haltItself = 1'b1;
		end
		if (when_CsrPlugin_l1591) begin
			if (execute_CsrPlugin_blockedBySideEffects)
				execute_arbitration_haltItself = 1'b1;
		end
	end
	always @(when_DBusCachedPlugin_l399 or when_FpuPlugin_l229) begin
		execute_arbitration_haltByOther = 1'b0;
		if (when_DBusCachedPlugin_l399)
			execute_arbitration_haltByOther = 1'b1;
		if (when_FpuPlugin_l229)
			execute_arbitration_haltByOther = 1'b1;
	end
	always @(CsrPlugin_selfException_valid or execute_arbitration_isFlushed) begin
		execute_arbitration_removeIt = 1'b0;
		if (CsrPlugin_selfException_valid)
			execute_arbitration_removeIt = 1'b1;
		if (execute_arbitration_isFlushed)
			execute_arbitration_removeIt = 1'b1;
	end
	always @(CsrPlugin_rescheduleLogic_rescheduleNext or CsrPlugin_selfException_valid) begin
		execute_arbitration_flushNext = 1'b0;
		if (CsrPlugin_rescheduleLogic_rescheduleNext)
			execute_arbitration_flushNext = 1'b1;
		if (CsrPlugin_selfException_valid)
			execute_arbitration_flushNext = 1'b1;
	end
	always @(when_MulDivIterativePlugin_l128 or when_MulDivIterativePlugin_l129) begin
		memory_arbitration_haltItself = 1'b0;
		if (when_MulDivIterativePlugin_l128) begin
			if (when_MulDivIterativePlugin_l129)
				memory_arbitration_haltItself = 1'b1;
		end
	end
	always @(BranchPlugin_branchExceptionPort_valid or memory_arbitration_isFlushed) begin
		memory_arbitration_removeIt = 1'b0;
		if (BranchPlugin_branchExceptionPort_valid)
			memory_arbitration_removeIt = 1'b1;
		if (memory_arbitration_isFlushed)
			memory_arbitration_removeIt = 1'b1;
	end
	always @(BranchPlugin_jumpInterface_valid or BranchPlugin_branchExceptionPort_valid) begin
		memory_arbitration_flushNext = 1'b0;
		if (BranchPlugin_jumpInterface_valid)
			memory_arbitration_flushNext = 1'b1;
		if (BranchPlugin_branchExceptionPort_valid)
			memory_arbitration_flushNext = 1'b1;
	end
	always @(when_DBusCachedPlugin_l541) begin
		writeBack_arbitration_haltItself = 1'b0;
		if (when_DBusCachedPlugin_l541)
			writeBack_arbitration_haltItself = 1'b1;
	end
	always @(writeBack_FpuPlugin_isRsp or when_FpuPlugin_l323 or when_FpuPlugin_l339) begin
		writeBack_arbitration_haltByOther = 1'b0;
		if (writeBack_FpuPlugin_isRsp) begin
			if (when_FpuPlugin_l323)
				writeBack_arbitration_haltByOther = 1'b1;
		end
		if (when_FpuPlugin_l339)
			writeBack_arbitration_haltByOther = 1'b1;
	end
	always @(DBusCachedPlugin_exceptionBus_valid or writeBack_arbitration_isFlushed) begin
		writeBack_arbitration_removeIt = 1'b0;
		if (DBusCachedPlugin_exceptionBus_valid)
			writeBack_arbitration_removeIt = 1'b1;
		if (writeBack_arbitration_isFlushed)
			writeBack_arbitration_removeIt = 1'b1;
	end
	always @(DBusCachedPlugin_redoBranch_valid) begin
		writeBack_arbitration_flushIt = 1'b0;
		if (DBusCachedPlugin_redoBranch_valid)
			writeBack_arbitration_flushIt = 1'b1;
	end
	always @(DBusCachedPlugin_redoBranch_valid or DBusCachedPlugin_exceptionBus_valid or when_CsrPlugin_l1390 or when_CsrPlugin_l1456) begin
		writeBack_arbitration_flushNext = 1'b0;
		if (DBusCachedPlugin_redoBranch_valid)
			writeBack_arbitration_flushNext = 1'b1;
		if (DBusCachedPlugin_exceptionBus_valid)
			writeBack_arbitration_flushNext = 1'b1;
		if (when_CsrPlugin_l1390)
			writeBack_arbitration_flushNext = 1'b1;
		if (when_CsrPlugin_l1456)
			writeBack_arbitration_flushNext = 1'b1;
	end
	always @(when_CsrPlugin_l1272 or when_CsrPlugin_l1390 or when_CsrPlugin_l1456) begin
		IBusCachedPlugin_fetcherHalt = 1'b0;
		if (when_CsrPlugin_l1272)
			IBusCachedPlugin_fetcherHalt = 1'b1;
		if (when_CsrPlugin_l1390)
			IBusCachedPlugin_fetcherHalt = 1'b1;
		if (when_CsrPlugin_l1456)
			IBusCachedPlugin_fetcherHalt = 1'b1;
	end
	always @(IBusCachedPlugin_iBusRsp_stages_1_input_valid or IBusCachedPlugin_injector_decodeInput_valid) begin
		IBusCachedPlugin_incomingInstruction = 1'b0;
		if (IBusCachedPlugin_iBusRsp_stages_1_input_valid)
			IBusCachedPlugin_incomingInstruction = 1'b1;
		if (IBusCachedPlugin_injector_decodeInput_valid)
			IBusCachedPlugin_incomingInstruction = 1'b1;
	end
	always @(when_CsrPlugin_l1702) begin
		CsrPlugin_csrMapping_allowCsrSignal = 1'b0;
		if (when_CsrPlugin_l1702)
			CsrPlugin_csrMapping_allowCsrSignal = 1'b1;
	end
	always @(when_FpuPlugin_l253 or execute_CsrPlugin_csr_3072 or when_CsrPlugin_l1076 or when_CsrPlugin_l1077 or execute_CsrPlugin_csr_3200 or when_CsrPlugin_l1076_1 or when_CsrPlugin_l1077_1 or execute_CsrPlugin_csr_3074 or when_CsrPlugin_l1076_2 or when_CsrPlugin_l1077_2 or execute_CsrPlugin_csr_3202 or when_CsrPlugin_l1076_3 or when_CsrPlugin_l1077_3) begin
		CsrPlugin_csrMapping_doForceFailCsr = 1'b0;
		if (when_FpuPlugin_l253)
			CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
		if (execute_CsrPlugin_csr_3072) begin
			if (when_CsrPlugin_l1076)
				CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
			if (when_CsrPlugin_l1077)
				CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
		end
		if (execute_CsrPlugin_csr_3200) begin
			if (when_CsrPlugin_l1076_1)
				CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
			if (when_CsrPlugin_l1077_1)
				CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
		end
		if (execute_CsrPlugin_csr_3074) begin
			if (when_CsrPlugin_l1076_2)
				CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
			if (when_CsrPlugin_l1077_2)
				CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
		end
		if (execute_CsrPlugin_csr_3202) begin
			if (when_CsrPlugin_l1076_3)
				CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
			if (when_CsrPlugin_l1077_3)
				CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
		end
	end
	always @(when_CsrPlugin_l1519) begin
		CsrPlugin_inWfi = 1'b0;
		if (when_CsrPlugin_l1519)
			CsrPlugin_inWfi = 1'b1;
	end
	always @(decode_FpuPlugin_forked) begin
		CsrPlugin_thirdPartyWake = 1'b0;
		if (decode_FpuPlugin_forked)
			CsrPlugin_thirdPartyWake = 1'b1;
	end
	always @(when_CsrPlugin_l1390 or when_CsrPlugin_l1456) begin
		CsrPlugin_jumpInterface_valid = 1'b0;
		if (when_CsrPlugin_l1390)
			CsrPlugin_jumpInterface_valid = 1'b1;
		if (when_CsrPlugin_l1456)
			CsrPlugin_jumpInterface_valid = 1'b1;
	end
	always @(when_CsrPlugin_l1390 or CsrPlugin_xtvec_base or when_CsrPlugin_l1456 or switch_CsrPlugin_l1460 or CsrPlugin_mepc or CsrPlugin_sepc) begin
		CsrPlugin_jumpInterface_payload = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		if (when_CsrPlugin_l1390)
			CsrPlugin_jumpInterface_payload = {CsrPlugin_xtvec_base, 2'h0};
		if (when_CsrPlugin_l1456)
			case (switch_CsrPlugin_l1460)
				2'h3: CsrPlugin_jumpInterface_payload = CsrPlugin_mepc;
				2'h1: CsrPlugin_jumpInterface_payload = CsrPlugin_sepc;
				default:
					;
			endcase
	end
	always @(when_CsrPlugin_l1456 or switch_CsrPlugin_l1460 or when_CsrPlugin_l1468) begin
		CsrPlugin_xretAwayFromMachine = 1'b0;
		if (when_CsrPlugin_l1456)
			case (switch_CsrPlugin_l1460)
				2'h3:
					if (when_CsrPlugin_l1468)
						CsrPlugin_xretAwayFromMachine = 1'b1;
				2'h1: CsrPlugin_xretAwayFromMachine = 1'b1;
				default:
					;
			endcase
	end
	always @(IBusCachedPlugin_fetchPc_redo_valid or IBusCachedPlugin_jump_pcLoad_valid) begin
		IBusCachedPlugin_fetchPc_correction = 1'b0;
		if (IBusCachedPlugin_fetchPc_redo_valid)
			IBusCachedPlugin_fetchPc_correction = 1'b1;
		if (IBusCachedPlugin_jump_pcLoad_valid)
			IBusCachedPlugin_fetchPc_correction = 1'b1;
	end
	always @(IBusCachedPlugin_iBusRsp_stages_1_input_ready) begin
		IBusCachedPlugin_fetchPc_pcRegPropagate = 1'b0;
		if (IBusCachedPlugin_iBusRsp_stages_1_input_ready)
			IBusCachedPlugin_fetchPc_pcRegPropagate = 1'b1;
	end
	always @(IBusCachedPlugin_fetchPc_pcReg or _zz_IBusCachedPlugin_fetchPc_pc or IBusCachedPlugin_fetchPc_redo_valid or IBusCachedPlugin_fetchPc_redo_payload or IBusCachedPlugin_jump_pcLoad_valid or IBusCachedPlugin_jump_pcLoad_payload) begin
		IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_fetchPc_pcReg + _zz_IBusCachedPlugin_fetchPc_pc;
		if (IBusCachedPlugin_fetchPc_redo_valid)
			IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_fetchPc_redo_payload;
		if (IBusCachedPlugin_jump_pcLoad_valid)
			IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_jump_pcLoad_payload;
		IBusCachedPlugin_fetchPc_pc[0] = 1'b0;
		IBusCachedPlugin_fetchPc_pc[1] = 1'b0;
	end
	always @(IBusCachedPlugin_fetchPc_redo_valid or IBusCachedPlugin_jump_pcLoad_valid) begin
		IBusCachedPlugin_fetchPc_flushed = 1'b0;
		if (IBusCachedPlugin_fetchPc_redo_valid)
			IBusCachedPlugin_fetchPc_flushed = 1'b1;
		if (IBusCachedPlugin_jump_pcLoad_valid)
			IBusCachedPlugin_fetchPc_flushed = 1'b1;
	end
	always @(IBusCachedPlugin_rsp_redoFetch) begin
		IBusCachedPlugin_iBusRsp_redoFetch = 1'b0;
		if (IBusCachedPlugin_rsp_redoFetch)
			IBusCachedPlugin_iBusRsp_redoFetch = 1'b1;
	end
	always @(IBusCachedPlugin_cache_io_cpu_prefetch_haltIt) begin
		IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b0;
		if (IBusCachedPlugin_cache_io_cpu_prefetch_haltIt)
			IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b1;
	end
	always @(IBusCachedPlugin_mmuBus_busy or when_IBusCachedPlugin_l273) begin
		IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b0;
		if (IBusCachedPlugin_mmuBus_busy)
			IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b1;
		if (when_IBusCachedPlugin_l273)
			IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b1;
	end
	always @(IBusCachedPlugin_injector_decodeInput_valid or when_Fetcher_l322) begin
		IBusCachedPlugin_iBusRsp_readyForError = 1'b1;
		if (IBusCachedPlugin_injector_decodeInput_valid)
			IBusCachedPlugin_iBusRsp_readyForError = 1'b0;
		if (when_Fetcher_l322)
			IBusCachedPlugin_iBusRsp_readyForError = 1'b0;
	end
	always @(IBusCachedPlugin_injector_decodeInput_valid or IBusCachedPlugin_forceNoDecodeCond) begin
		decode_arbitration_isValid = IBusCachedPlugin_injector_decodeInput_valid;
		if (IBusCachedPlugin_forceNoDecodeCond)
			decode_arbitration_isValid = 1'b0;
	end
	always @(_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch) begin
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[18] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[17] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[16] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[15] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[14] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[13] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[12] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[11] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[10] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[9] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[8] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[7] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[6] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[5] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[4] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[3] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[2] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[1] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
		_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[0] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
	end
	always @(decode_BRANCH_CTRL or _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_2 or _zz_6) begin
		IBusCachedPlugin_decodePrediction_cmd_hadBranch = (decode_BRANCH_CTRL == BranchCtrlEnum_JAL) || ((decode_BRANCH_CTRL == BranchCtrlEnum_B) && _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_2[31]);
		if (_zz_6)
			IBusCachedPlugin_decodePrediction_cmd_hadBranch = 1'b0;
	end
	always @(_zz_2) begin
		_zz_3[10] = _zz_2;
		_zz_3[9] = _zz_2;
		_zz_3[8] = _zz_2;
		_zz_3[7] = _zz_2;
		_zz_3[6] = _zz_2;
		_zz_3[5] = _zz_2;
		_zz_3[4] = _zz_2;
		_zz_3[3] = _zz_2;
		_zz_3[2] = _zz_2;
		_zz_3[1] = _zz_2;
		_zz_3[0] = _zz_2;
	end
	always @(_zz_4) begin
		_zz_5[18] = _zz_4;
		_zz_5[17] = _zz_4;
		_zz_5[16] = _zz_4;
		_zz_5[15] = _zz_4;
		_zz_5[14] = _zz_4;
		_zz_5[13] = _zz_4;
		_zz_5[12] = _zz_4;
		_zz_5[11] = _zz_4;
		_zz_5[10] = _zz_4;
		_zz_5[9] = _zz_4;
		_zz_5[8] = _zz_4;
		_zz_5[7] = _zz_4;
		_zz_5[6] = _zz_4;
		_zz_5[5] = _zz_4;
		_zz_5[4] = _zz_4;
		_zz_5[3] = _zz_4;
		_zz_5[2] = _zz_4;
		_zz_5[1] = _zz_4;
		_zz_5[0] = _zz_4;
	end
	always @(decode_BRANCH_CTRL or _zz__zz_6 or _zz__zz_6_1)
		case (decode_BRANCH_CTRL)
			BranchCtrlEnum_JAL: _zz_6 = _zz__zz_6[1];
			default: _zz_6 = _zz__zz_6_1[1];
		endcase
	always @(_zz_IBusCachedPlugin_predictionJumpInterface_payload) begin
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_1[10] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_1[9] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_1[8] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_1[7] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_1[6] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_1[5] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_1[4] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_1[3] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_1[2] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_1[1] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_1[0] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
	end
	always @(_zz_IBusCachedPlugin_predictionJumpInterface_payload_2) begin
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[18] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[17] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[16] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[15] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[14] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[13] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[12] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[11] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[10] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[9] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[8] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[7] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[6] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[5] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[4] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[3] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[2] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[1] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
		_zz_IBusCachedPlugin_predictionJumpInterface_payload_3[0] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
	end
	always @(IBusCachedPlugin_cache_io_mem_cmd_payload_address) begin
		iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address;
		iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address;
	end
	always @(when_IBusCachedPlugin_l245 or when_IBusCachedPlugin_l256) begin
		IBusCachedPlugin_rsp_redoFetch = 1'b0;
		if (when_IBusCachedPlugin_l245)
			IBusCachedPlugin_rsp_redoFetch = 1'b1;
		if (when_IBusCachedPlugin_l256)
			IBusCachedPlugin_rsp_redoFetch = 1'b1;
	end
	always @(IBusCachedPlugin_rsp_redoFetch or IBusCachedPlugin_cache_io_cpu_fetch_mmuRefilling or when_IBusCachedPlugin_l256) begin
		IBusCachedPlugin_cache_io_cpu_fill_valid = IBusCachedPlugin_rsp_redoFetch && !IBusCachedPlugin_cache_io_cpu_fetch_mmuRefilling;
		if (when_IBusCachedPlugin_l256)
			IBusCachedPlugin_cache_io_cpu_fill_valid = 1'b1;
	end
	always @(when_IBusCachedPlugin_l250 or IBusCachedPlugin_iBusRsp_readyForError or when_IBusCachedPlugin_l262) begin
		IBusCachedPlugin_decodeExceptionPort_valid = 1'b0;
		if (when_IBusCachedPlugin_l250)
			IBusCachedPlugin_decodeExceptionPort_valid = IBusCachedPlugin_iBusRsp_readyForError;
		if (when_IBusCachedPlugin_l262)
			IBusCachedPlugin_decodeExceptionPort_valid = IBusCachedPlugin_iBusRsp_readyForError;
	end
	always @(when_IBusCachedPlugin_l250 or when_IBusCachedPlugin_l262) begin
		IBusCachedPlugin_decodeExceptionPort_payload_code = 4'bxxxx;
		if (when_IBusCachedPlugin_l250)
			IBusCachedPlugin_decodeExceptionPort_payload_code = 4'hc;
		if (when_IBusCachedPlugin_l262)
			IBusCachedPlugin_decodeExceptionPort_payload_code = 4'h1;
	end
	always @(toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_ready or when_Stream_l368) begin
		toplevel_dataCache_1_io_mem_cmd_s2mPipe_ready = toplevel_dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_ready;
		if (when_Stream_l368)
			toplevel_dataCache_1_io_mem_cmd_s2mPipe_ready = 1'b1;
	end
	always @(execute_arbitration_isValid or execute_MEMORY_ENABLE or MmuPlugin_dBusAccess_cmd_valid or when_DBusCachedPlugin_l592 or when_DBusCachedPlugin_l593) begin
		dataCache_1_io_cpu_execute_isValid = execute_arbitration_isValid && execute_MEMORY_ENABLE;
		if (MmuPlugin_dBusAccess_cmd_valid) begin
			if (when_DBusCachedPlugin_l592) begin
				if (when_DBusCachedPlugin_l593)
					dataCache_1_io_cpu_execute_isValid = 1'b1;
			end
		end
	end
	always @(execute_SRC_ADD or MmuPlugin_dBusAccess_cmd_valid or when_DBusCachedPlugin_l592 or MmuPlugin_dBusAccess_cmd_payload_address) begin
		dataCache_1_io_cpu_execute_address = execute_SRC_ADD;
		if (MmuPlugin_dBusAccess_cmd_valid) begin
			if (when_DBusCachedPlugin_l592)
				dataCache_1_io_cpu_execute_address = MmuPlugin_dBusAccess_cmd_payload_address;
		end
	end
	always @(execute_MEMORY_WR or MmuPlugin_dBusAccess_cmd_valid or when_DBusCachedPlugin_l592) begin
		dataCache_1_io_cpu_execute_args_wr = execute_MEMORY_WR;
		if (MmuPlugin_dBusAccess_cmd_valid) begin
			if (when_DBusCachedPlugin_l592)
				dataCache_1_io_cpu_execute_args_wr = 1'b0;
		end
	end
	always @(execute_DBusCachedPlugin_size or execute_RS2)
		case (execute_DBusCachedPlugin_size)
			2'h0: _zz_execute_MEMORY_STORE_DATA_RF = {execute_RS2[7:0], execute_RS2[7:0], execute_RS2[7:0], execute_RS2[7:0]};
			2'h1: _zz_execute_MEMORY_STORE_DATA_RF = {execute_RS2[15:0], execute_RS2[15:0]};
			default: _zz_execute_MEMORY_STORE_DATA_RF = execute_RS2;
		endcase
	always @(execute_DBusCachedPlugin_size or MmuPlugin_dBusAccess_cmd_valid or when_DBusCachedPlugin_l592 or MmuPlugin_dBusAccess_cmd_payload_size) begin
		dataCache_1_io_cpu_execute_args_size = execute_DBusCachedPlugin_size;
		if (MmuPlugin_dBusAccess_cmd_valid) begin
			if (when_DBusCachedPlugin_l592)
				dataCache_1_io_cpu_execute_args_size = MmuPlugin_dBusAccess_cmd_payload_size;
		end
	end
	always @(memory_arbitration_isValid or memory_MEMORY_ENABLE or memory_IS_DBUS_SHARING) begin
		dataCache_1_io_cpu_memory_isValid = memory_arbitration_isValid && memory_MEMORY_ENABLE;
		if (memory_IS_DBUS_SHARING)
			dataCache_1_io_cpu_memory_isValid = 1'b1;
	end
	always @(memory_IS_DBUS_SHARING) begin
		DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation = 1'b0;
		if (memory_IS_DBUS_SHARING)
			DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation = 1'b1;
	end
	always @(DBusCachedPlugin_mmuBus_rsp_isIoAccess or when_DBusCachedPlugin_l460) begin
		dataCache_1_io_cpu_memory_mmuRsp_isIoAccess = DBusCachedPlugin_mmuBus_rsp_isIoAccess;
		if (when_DBusCachedPlugin_l460)
			dataCache_1_io_cpu_memory_mmuRsp_isIoAccess = 1'b1;
	end
	always @(writeBack_arbitration_isValid or writeBack_MEMORY_ENABLE or writeBack_IS_DBUS_SHARING or writeBack_arbitration_haltByOther) begin
		dataCache_1_io_cpu_writeBack_isValid = writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE;
		if (writeBack_IS_DBUS_SHARING)
			dataCache_1_io_cpu_writeBack_isValid = 1'b1;
		if (writeBack_arbitration_haltByOther)
			dataCache_1_io_cpu_writeBack_isValid = 1'b0;
	end
	always @(writeBack_MEMORY_STORE_DATA_RF or DBusBypass0_cond or DBusBypass0_value) begin
		dataCache_1_io_cpu_writeBack_storeData[31:0] = writeBack_MEMORY_STORE_DATA_RF;
		dataCache_1_io_cpu_writeBack_storeData[63:32] = writeBack_MEMORY_STORE_DATA_RF;
		if (DBusBypass0_cond)
			dataCache_1_io_cpu_writeBack_storeData = DBusBypass0_value;
	end
	always @(when_DBusCachedPlugin_l521 or dataCache_1_io_cpu_redo) begin
		DBusCachedPlugin_redoBranch_valid = 1'b0;
		if (when_DBusCachedPlugin_l521) begin
			if (dataCache_1_io_cpu_redo)
				DBusCachedPlugin_redoBranch_valid = 1'b1;
		end
	end
	always @(when_DBusCachedPlugin_l521 or dataCache_1_io_cpu_writeBack_accessError or dataCache_1_io_cpu_writeBack_mmuException or dataCache_1_io_cpu_writeBack_unalignedAccess or dataCache_1_io_cpu_redo) begin
		DBusCachedPlugin_exceptionBus_valid = 1'b0;
		if (when_DBusCachedPlugin_l521) begin
			if (dataCache_1_io_cpu_writeBack_accessError)
				DBusCachedPlugin_exceptionBus_valid = 1'b1;
			if (dataCache_1_io_cpu_writeBack_mmuException)
				DBusCachedPlugin_exceptionBus_valid = 1'b1;
			if (dataCache_1_io_cpu_writeBack_unalignedAccess)
				DBusCachedPlugin_exceptionBus_valid = 1'b1;
			if (dataCache_1_io_cpu_redo)
				DBusCachedPlugin_exceptionBus_valid = 1'b0;
		end
	end
	always @(when_DBusCachedPlugin_l521 or dataCache_1_io_cpu_writeBack_accessError or _zz_DBusCachedPlugin_exceptionBus_payload_code or dataCache_1_io_cpu_writeBack_mmuException or writeBack_MEMORY_WR or dataCache_1_io_cpu_writeBack_unalignedAccess or _zz_DBusCachedPlugin_exceptionBus_payload_code_1) begin
		DBusCachedPlugin_exceptionBus_payload_code = 4'bxxxx;
		if (when_DBusCachedPlugin_l521) begin
			if (dataCache_1_io_cpu_writeBack_accessError)
				DBusCachedPlugin_exceptionBus_payload_code = {1'b0, _zz_DBusCachedPlugin_exceptionBus_payload_code};
			if (dataCache_1_io_cpu_writeBack_mmuException)
				DBusCachedPlugin_exceptionBus_payload_code = (writeBack_MEMORY_WR ? 4'hf : 4'hd);
			if (dataCache_1_io_cpu_writeBack_unalignedAccess)
				DBusCachedPlugin_exceptionBus_payload_code = {1'b0, _zz_DBusCachedPlugin_exceptionBus_payload_code_1};
		end
	end
	always @(_zz_writeBack_DBusCachedPlugin_rspShifted or _zz_writeBack_DBusCachedPlugin_rspShifted_2 or _zz_writeBack_DBusCachedPlugin_rspShifted_4 or _zz_writeBack_DBusCachedPlugin_rspShifted_6 or writeBack_DBusCachedPlugin_rspSplits_4 or writeBack_DBusCachedPlugin_rspSplits_5 or writeBack_DBusCachedPlugin_rspSplits_6 or writeBack_DBusCachedPlugin_rspSplits_7) begin
		writeBack_DBusCachedPlugin_rspShifted[7:0] = _zz_writeBack_DBusCachedPlugin_rspShifted;
		writeBack_DBusCachedPlugin_rspShifted[15:8] = _zz_writeBack_DBusCachedPlugin_rspShifted_2;
		writeBack_DBusCachedPlugin_rspShifted[23:16] = _zz_writeBack_DBusCachedPlugin_rspShifted_4;
		writeBack_DBusCachedPlugin_rspShifted[31:24] = _zz_writeBack_DBusCachedPlugin_rspShifted_6;
		writeBack_DBusCachedPlugin_rspShifted[39:32] = writeBack_DBusCachedPlugin_rspSplits_4;
		writeBack_DBusCachedPlugin_rspShifted[47:40] = writeBack_DBusCachedPlugin_rspSplits_5;
		writeBack_DBusCachedPlugin_rspShifted[55:48] = writeBack_DBusCachedPlugin_rspSplits_6;
		writeBack_DBusCachedPlugin_rspShifted[63:56] = writeBack_DBusCachedPlugin_rspSplits_7;
	end
	always @(_zz_writeBack_DBusCachedPlugin_rspFormated or writeBack_DBusCachedPlugin_rspRf) begin
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[31] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[30] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[29] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[28] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[27] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[26] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[25] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[24] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[23] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[22] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[21] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[20] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[19] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[18] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[17] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[16] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[15] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[14] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[13] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[12] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[11] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[10] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[9] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[8] = _zz_writeBack_DBusCachedPlugin_rspFormated;
		_zz_writeBack_DBusCachedPlugin_rspFormated_1[7:0] = writeBack_DBusCachedPlugin_rspRf[7:0];
	end
	always @(_zz_writeBack_DBusCachedPlugin_rspFormated_2 or writeBack_DBusCachedPlugin_rspRf) begin
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[31] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[30] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[29] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[28] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[27] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[26] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[25] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[24] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[23] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[22] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[21] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[20] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[19] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[18] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[17] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[16] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
		_zz_writeBack_DBusCachedPlugin_rspFormated_3[15:0] = writeBack_DBusCachedPlugin_rspRf[15:0];
	end
	always @(switch_Misc_l226 or _zz_writeBack_DBusCachedPlugin_rspFormated_1 or _zz_writeBack_DBusCachedPlugin_rspFormated_3 or writeBack_DBusCachedPlugin_rspRf)
		case (switch_Misc_l226)
			2'h0: writeBack_DBusCachedPlugin_rspFormated = _zz_writeBack_DBusCachedPlugin_rspFormated_1;
			2'h1: writeBack_DBusCachedPlugin_rspFormated = _zz_writeBack_DBusCachedPlugin_rspFormated_3;
			default: writeBack_DBusCachedPlugin_rspFormated = writeBack_DBusCachedPlugin_rspRf;
		endcase
	always @(MmuPlugin_dBusAccess_cmd_valid or when_DBusCachedPlugin_l592 or when_DBusCachedPlugin_l593 or execute_arbitration_isStuck) begin
		MmuPlugin_dBusAccess_cmd_ready = 1'b0;
		if (MmuPlugin_dBusAccess_cmd_valid) begin
			if (when_DBusCachedPlugin_l592) begin
				if (when_DBusCachedPlugin_l593)
					MmuPlugin_dBusAccess_cmd_ready = !execute_arbitration_isStuck;
			end
		end
	end
	always @(MmuPlugin_dBusAccess_cmd_valid or when_DBusCachedPlugin_l592) begin
		DBusCachedPlugin_forceDatapath = 1'b0;
		if (MmuPlugin_dBusAccess_cmd_valid) begin
			if (when_DBusCachedPlugin_l592)
				DBusCachedPlugin_forceDatapath = 1'b1;
		end
	end
	always @(IBusCachedPlugin_mmuBus_cmd_0_virtualAddress or IBusCachedPlugin_mmuBus_cmd_0_bypassTranslation or MmuPlugin_satp_mode or when_MmuPlugin_l131 or when_MmuPlugin_l132) begin
		MmuPlugin_ports_0_requireMmuLockupCalc = ((IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31:28] == 4'hc) && !IBusCachedPlugin_mmuBus_cmd_0_bypassTranslation) && MmuPlugin_satp_mode;
		if (when_MmuPlugin_l131)
			MmuPlugin_ports_0_requireMmuLockupCalc = 1'b0;
		if (when_MmuPlugin_l132)
			MmuPlugin_ports_0_requireMmuLockupCalc = 1'b0;
	end
	always @(when_MmuPlugin_l279 or when_MmuPlugin_l281) begin
		MmuPlugin_ports_0_entryToReplace_willIncrement = 1'b0;
		if (when_MmuPlugin_l279) begin
			if (when_MmuPlugin_l281)
				MmuPlugin_ports_0_entryToReplace_willIncrement = 1'b1;
		end
	end
	always @(MmuPlugin_ports_0_entryToReplace_value or _zz_MmuPlugin_ports_0_entryToReplace_valueNext or MmuPlugin_ports_0_entryToReplace_willClear) begin
		MmuPlugin_ports_0_entryToReplace_valueNext = MmuPlugin_ports_0_entryToReplace_value + _zz_MmuPlugin_ports_0_entryToReplace_valueNext;
		if (MmuPlugin_ports_0_entryToReplace_willClear)
			MmuPlugin_ports_0_entryToReplace_valueNext = 2'h0;
	end
	always @(MmuPlugin_ports_0_requireMmuLockupCalc or MmuPlugin_ports_0_cacheLine_physicalAddress_1 or MmuPlugin_ports_0_cacheLine_superPage or IBusCachedPlugin_mmuBus_cmd_0_virtualAddress or MmuPlugin_ports_0_cacheLine_physicalAddress_0)
		if (MmuPlugin_ports_0_requireMmuLockupCalc)
			IBusCachedPlugin_mmuBus_rsp_physicalAddress = {MmuPlugin_ports_0_cacheLine_physicalAddress_1, (MmuPlugin_ports_0_cacheLine_superPage ? IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12] : MmuPlugin_ports_0_cacheLine_physicalAddress_0), IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[11:0]};
		else
			IBusCachedPlugin_mmuBus_rsp_physicalAddress = IBusCachedPlugin_mmuBus_cmd_0_virtualAddress;
	always @(MmuPlugin_ports_0_requireMmuLockupCalc or MmuPlugin_ports_0_cacheLine_allowRead or MmuPlugin_status_mxr or MmuPlugin_ports_0_cacheLine_allowExecute)
		if (MmuPlugin_ports_0_requireMmuLockupCalc)
			IBusCachedPlugin_mmuBus_rsp_allowRead = MmuPlugin_ports_0_cacheLine_allowRead || (MmuPlugin_status_mxr && MmuPlugin_ports_0_cacheLine_allowExecute);
		else
			IBusCachedPlugin_mmuBus_rsp_allowRead = 1'b1;
	always @(MmuPlugin_ports_0_requireMmuLockupCalc or MmuPlugin_ports_0_cacheLine_allowWrite)
		if (MmuPlugin_ports_0_requireMmuLockupCalc)
			IBusCachedPlugin_mmuBus_rsp_allowWrite = MmuPlugin_ports_0_cacheLine_allowWrite;
		else
			IBusCachedPlugin_mmuBus_rsp_allowWrite = 1'b1;
	always @(MmuPlugin_ports_0_requireMmuLockupCalc or MmuPlugin_ports_0_cacheLine_allowExecute)
		if (MmuPlugin_ports_0_requireMmuLockupCalc)
			IBusCachedPlugin_mmuBus_rsp_allowExecute = MmuPlugin_ports_0_cacheLine_allowExecute;
		else
			IBusCachedPlugin_mmuBus_rsp_allowExecute = 1'b1;
	always @(MmuPlugin_ports_0_requireMmuLockupCalc or MmuPlugin_ports_0_dirty or MmuPlugin_ports_0_cacheHit or MmuPlugin_ports_0_cacheLine_exception or MmuPlugin_ports_0_cacheLine_allowUser or CsrPlugin_privilege or MmuPlugin_status_sum)
		if (MmuPlugin_ports_0_requireMmuLockupCalc)
			IBusCachedPlugin_mmuBus_rsp_exception = (!MmuPlugin_ports_0_dirty && MmuPlugin_ports_0_cacheHit) && ((MmuPlugin_ports_0_cacheLine_exception || ((MmuPlugin_ports_0_cacheLine_allowUser && (CsrPlugin_privilege == 2'h1)) && !MmuPlugin_status_sum)) || (!MmuPlugin_ports_0_cacheLine_allowUser && (CsrPlugin_privilege == 2'h0)));
		else
			IBusCachedPlugin_mmuBus_rsp_exception = 1'b0;
	always @(MmuPlugin_ports_0_requireMmuLockupCalc or MmuPlugin_ports_0_dirty or MmuPlugin_ports_0_cacheHit)
		if (MmuPlugin_ports_0_requireMmuLockupCalc)
			IBusCachedPlugin_mmuBus_rsp_refilling = MmuPlugin_ports_0_dirty || !MmuPlugin_ports_0_cacheHit;
		else
			IBusCachedPlugin_mmuBus_rsp_refilling = 1'b0;
	always @(MmuPlugin_ports_0_requireMmuLockupCalc)
		if (MmuPlugin_ports_0_requireMmuLockupCalc)
			IBusCachedPlugin_mmuBus_rsp_isPaging = 1'b1;
		else
			IBusCachedPlugin_mmuBus_rsp_isPaging = 1'b0;
	always @(DBusCachedPlugin_mmuBus_cmd_0_virtualAddress or DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation or MmuPlugin_satp_mode or when_MmuPlugin_l131_1 or when_MmuPlugin_l132_1 or when_MmuPlugin_l134) begin
		MmuPlugin_ports_1_requireMmuLockupCalc = ((DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31:28] == 4'hc) && !DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation) && MmuPlugin_satp_mode;
		if (when_MmuPlugin_l131_1)
			MmuPlugin_ports_1_requireMmuLockupCalc = 1'b0;
		if (when_MmuPlugin_l132_1) begin
			if (when_MmuPlugin_l134)
				MmuPlugin_ports_1_requireMmuLockupCalc = 1'b0;
		end
	end
	always @(when_MmuPlugin_l279 or when_MmuPlugin_l281_1) begin
		MmuPlugin_ports_1_entryToReplace_willIncrement = 1'b0;
		if (when_MmuPlugin_l279) begin
			if (when_MmuPlugin_l281_1)
				MmuPlugin_ports_1_entryToReplace_willIncrement = 1'b1;
		end
	end
	always @(MmuPlugin_ports_1_entryToReplace_value or _zz_MmuPlugin_ports_1_entryToReplace_valueNext or MmuPlugin_ports_1_entryToReplace_willClear) begin
		MmuPlugin_ports_1_entryToReplace_valueNext = MmuPlugin_ports_1_entryToReplace_value + _zz_MmuPlugin_ports_1_entryToReplace_valueNext;
		if (MmuPlugin_ports_1_entryToReplace_willClear)
			MmuPlugin_ports_1_entryToReplace_valueNext = 2'h0;
	end
	always @(MmuPlugin_ports_1_requireMmuLockupCalc or MmuPlugin_ports_1_cacheLine_physicalAddress_1 or MmuPlugin_ports_1_cacheLine_superPage or DBusCachedPlugin_mmuBus_cmd_0_virtualAddress or MmuPlugin_ports_1_cacheLine_physicalAddress_0)
		if (MmuPlugin_ports_1_requireMmuLockupCalc)
			DBusCachedPlugin_mmuBus_rsp_physicalAddress = {MmuPlugin_ports_1_cacheLine_physicalAddress_1, (MmuPlugin_ports_1_cacheLine_superPage ? DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21:12] : MmuPlugin_ports_1_cacheLine_physicalAddress_0), DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[11:0]};
		else
			DBusCachedPlugin_mmuBus_rsp_physicalAddress = DBusCachedPlugin_mmuBus_cmd_0_virtualAddress;
	always @(MmuPlugin_ports_1_requireMmuLockupCalc or MmuPlugin_ports_1_cacheLine_allowRead or MmuPlugin_status_mxr or MmuPlugin_ports_1_cacheLine_allowExecute)
		if (MmuPlugin_ports_1_requireMmuLockupCalc)
			DBusCachedPlugin_mmuBus_rsp_allowRead = MmuPlugin_ports_1_cacheLine_allowRead || (MmuPlugin_status_mxr && MmuPlugin_ports_1_cacheLine_allowExecute);
		else
			DBusCachedPlugin_mmuBus_rsp_allowRead = 1'b1;
	always @(MmuPlugin_ports_1_requireMmuLockupCalc or MmuPlugin_ports_1_cacheLine_allowWrite)
		if (MmuPlugin_ports_1_requireMmuLockupCalc)
			DBusCachedPlugin_mmuBus_rsp_allowWrite = MmuPlugin_ports_1_cacheLine_allowWrite;
		else
			DBusCachedPlugin_mmuBus_rsp_allowWrite = 1'b1;
	always @(MmuPlugin_ports_1_requireMmuLockupCalc or MmuPlugin_ports_1_cacheLine_allowExecute)
		if (MmuPlugin_ports_1_requireMmuLockupCalc)
			DBusCachedPlugin_mmuBus_rsp_allowExecute = MmuPlugin_ports_1_cacheLine_allowExecute;
		else
			DBusCachedPlugin_mmuBus_rsp_allowExecute = 1'b1;
	always @(MmuPlugin_ports_1_requireMmuLockupCalc or MmuPlugin_ports_1_dirty or MmuPlugin_ports_1_cacheHit or MmuPlugin_ports_1_cacheLine_exception or MmuPlugin_ports_1_cacheLine_allowUser or CsrPlugin_privilege or MmuPlugin_status_sum)
		if (MmuPlugin_ports_1_requireMmuLockupCalc)
			DBusCachedPlugin_mmuBus_rsp_exception = (!MmuPlugin_ports_1_dirty && MmuPlugin_ports_1_cacheHit) && ((MmuPlugin_ports_1_cacheLine_exception || ((MmuPlugin_ports_1_cacheLine_allowUser && (CsrPlugin_privilege == 2'h1)) && !MmuPlugin_status_sum)) || (!MmuPlugin_ports_1_cacheLine_allowUser && (CsrPlugin_privilege == 2'h0)));
		else
			DBusCachedPlugin_mmuBus_rsp_exception = 1'b0;
	always @(MmuPlugin_ports_1_requireMmuLockupCalc or MmuPlugin_ports_1_dirty or MmuPlugin_ports_1_cacheHit)
		if (MmuPlugin_ports_1_requireMmuLockupCalc)
			DBusCachedPlugin_mmuBus_rsp_refilling = MmuPlugin_ports_1_dirty || !MmuPlugin_ports_1_cacheHit;
		else
			DBusCachedPlugin_mmuBus_rsp_refilling = 1'b0;
	always @(MmuPlugin_ports_1_requireMmuLockupCalc)
		if (MmuPlugin_ports_1_requireMmuLockupCalc)
			DBusCachedPlugin_mmuBus_rsp_isPaging = 1'b1;
		else
			DBusCachedPlugin_mmuBus_rsp_isPaging = 1'b0;
	always @(MmuPlugin_shared_state_1) begin
		MmuPlugin_dBusAccess_cmd_valid = 1'b0;
		case (MmuPlugin_shared_state_1)
			MmuPlugin_shared_State_IDLE:
				;
			MmuPlugin_shared_State_L1_CMD: MmuPlugin_dBusAccess_cmd_valid = 1'b1;
			MmuPlugin_shared_State_L1_RSP:
				;
			MmuPlugin_shared_State_L0_CMD: MmuPlugin_dBusAccess_cmd_valid = 1'b1;
			default:
				;
		endcase
	end
	always @(MmuPlugin_shared_state_1 or MmuPlugin_satp_ppn or MmuPlugin_shared_vpn_1 or MmuPlugin_shared_pteBuffer_PPN1 or MmuPlugin_shared_pteBuffer_PPN0 or MmuPlugin_shared_vpn_0) begin
		MmuPlugin_dBusAccess_cmd_payload_address = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		case (MmuPlugin_shared_state_1)
			MmuPlugin_shared_State_IDLE:
				;
			MmuPlugin_shared_State_L1_CMD: MmuPlugin_dBusAccess_cmd_payload_address = {MmuPlugin_satp_ppn[19:0], MmuPlugin_shared_vpn_1, 2'h0};
			MmuPlugin_shared_State_L1_RSP:
				;
			MmuPlugin_shared_State_L0_CMD: MmuPlugin_dBusAccess_cmd_payload_address = {MmuPlugin_shared_pteBuffer_PPN1[9:0], MmuPlugin_shared_pteBuffer_PPN0, MmuPlugin_shared_vpn_0, 2'h0};
			default:
				;
		endcase
	end
	always @(_zz_MmuPlugin_shared_refills) begin
		_zz_MmuPlugin_shared_refills_1[0] = _zz_MmuPlugin_shared_refills[1];
		_zz_MmuPlugin_shared_refills_1[1] = _zz_MmuPlugin_shared_refills[0];
	end
	always @(_zz_MmuPlugin_shared_refills_2) begin
		_zz_MmuPlugin_shared_refills_3[0] = _zz_MmuPlugin_shared_refills_2[1];
		_zz_MmuPlugin_shared_refills_3[1] = _zz_MmuPlugin_shared_refills_2[0];
	end
	always @(execute_CsrPlugin_csr_2 or execute_CsrPlugin_writeEnable) begin
		_zz_when_FpuPlugin_l237 = 1'b0;
		if (execute_CsrPlugin_csr_2) begin
			if (execute_CsrPlugin_writeEnable)
				_zz_when_FpuPlugin_l237 = 1'b1;
		end
	end
	always @(execute_CsrPlugin_csr_3 or execute_CsrPlugin_writeEnable) begin
		_zz_when_FpuPlugin_l237_1 = 1'b0;
		if (execute_CsrPlugin_csr_3) begin
			if (execute_CsrPlugin_writeEnable)
				_zz_when_FpuPlugin_l237_1 = 1'b1;
		end
	end
	always @(execute_CsrPlugin_csr_1 or execute_CsrPlugin_writeEnable) begin
		_zz_when_FpuPlugin_l237_2 = 1'b0;
		if (execute_CsrPlugin_csr_1) begin
			if (execute_CsrPlugin_writeEnable)
				_zz_when_FpuPlugin_l237_2 = 1'b1;
		end
	end
	always @(execute_CsrPlugin_csr_3 or execute_CsrPlugin_csr_2 or execute_CsrPlugin_csr_1) begin
		FpuPlugin_accessFpuCsr = 1'b0;
		if (execute_CsrPlugin_csr_3)
			FpuPlugin_accessFpuCsr = 1'b1;
		if (execute_CsrPlugin_csr_2)
			FpuPlugin_accessFpuCsr = 1'b1;
		if (execute_CsrPlugin_csr_1)
			FpuPlugin_accessFpuCsr = 1'b1;
	end
	always @(FpuPlugin_port_rsp_payload_value or when_FpuPlugin_l306) begin
		writeBack_FpuPlugin_storeFormated = FpuPlugin_port_rsp_payload_value;
		if (when_FpuPlugin_l306)
			writeBack_FpuPlugin_storeFormated[63:32] = FpuPlugin_port_rsp_payload_value[31:0];
	end
	always @(writeBack_FpuPlugin_isRsp or when_FpuPlugin_l323 or when_FpuPlugin_l325) begin
		FpuPlugin_port_rsp_ready = 1'b0;
		if (writeBack_FpuPlugin_isRsp) begin
			if (!when_FpuPlugin_l323) begin
				if (when_FpuPlugin_l325)
					FpuPlugin_port_rsp_ready = 1'b1;
			end
		end
	end
	always @(writeBack_FPU_COMMIT_LOAD or _zz_writeBack_FpuPlugin_commit_payload_value or writeBack_RS1) begin
		writeBack_FpuPlugin_commit_payload_value[31:0] = (writeBack_FPU_COMMIT_LOAD ? _zz_writeBack_FpuPlugin_commit_payload_value[31:0] : writeBack_RS1);
		writeBack_FpuPlugin_commit_payload_value[63:32] = _zz_writeBack_FpuPlugin_commit_payload_value[63:32];
	end
	always @(_zz_lastStageRegFileWrite_valid or writeBack_arbitration_isFiring or _zz_7) begin
		lastStageRegFileWrite_valid = _zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring;
		if (_zz_7)
			lastStageRegFileWrite_valid = 1'b1;
	end
	always @(_zz_lastStageRegFileWrite_payload_address or _zz_7) begin
		lastStageRegFileWrite_payload_address = _zz_lastStageRegFileWrite_payload_address[11:7];
		if (_zz_7)
			lastStageRegFileWrite_payload_address = 5'h00;
	end
	always @(_zz_decode_RS2_2 or _zz_7) begin
		lastStageRegFileWrite_payload_data = _zz_decode_RS2_2;
		if (_zz_7)
			lastStageRegFileWrite_payload_data = 32'h00000000;
	end
	always @(execute_ALU_BITWISE_CTRL or execute_SRC1 or execute_SRC2)
		case (execute_ALU_BITWISE_CTRL)
			AluBitwiseCtrlEnum_AND_1: execute_IntAluPlugin_bitwise = execute_SRC1 & execute_SRC2;
			AluBitwiseCtrlEnum_OR_1: execute_IntAluPlugin_bitwise = execute_SRC1 | execute_SRC2;
			default: execute_IntAluPlugin_bitwise = execute_SRC1 ^ execute_SRC2;
		endcase
	always @(execute_ALU_CTRL or execute_IntAluPlugin_bitwise or _zz__zz_execute_REGFILE_WRITE_DATA or execute_SRC_ADD_SUB)
		case (execute_ALU_CTRL)
			AluCtrlEnum_BITWISE: _zz_execute_REGFILE_WRITE_DATA = execute_IntAluPlugin_bitwise;
			AluCtrlEnum_SLT_SLTU: _zz_execute_REGFILE_WRITE_DATA = {31'h00000000, _zz__zz_execute_REGFILE_WRITE_DATA};
			default: _zz_execute_REGFILE_WRITE_DATA = execute_SRC_ADD_SUB;
		endcase
	always @(execute_SRC1_CTRL or _zz_execute_to_memory_RS1 or _zz__zz_execute_SRC1 or execute_INSTRUCTION or _zz__zz_execute_SRC1_1)
		case (execute_SRC1_CTRL)
			Src1CtrlEnum_RS: _zz_execute_SRC1 = _zz_execute_to_memory_RS1;
			Src1CtrlEnum_PC_INCREMENT: _zz_execute_SRC1 = {29'h00000000, _zz__zz_execute_SRC1};
			Src1CtrlEnum_IMU: _zz_execute_SRC1 = {execute_INSTRUCTION[31:12], 12'h000};
			default: _zz_execute_SRC1 = {27'h0000000, _zz__zz_execute_SRC1_1};
		endcase
	always @(_zz_execute_SRC2) begin
		_zz_execute_SRC2_1[19] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[18] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[17] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[16] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[15] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[14] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[13] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[12] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[11] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[10] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[9] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[8] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[7] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[6] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[5] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[4] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[3] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[2] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[1] = _zz_execute_SRC2;
		_zz_execute_SRC2_1[0] = _zz_execute_SRC2;
	end
	always @(_zz_execute_SRC2_2) begin
		_zz_execute_SRC2_3[19] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[18] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[17] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[16] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[15] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[14] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[13] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[12] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[11] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[10] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[9] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[8] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[7] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[6] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[5] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[4] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[3] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[2] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[1] = _zz_execute_SRC2_2;
		_zz_execute_SRC2_3[0] = _zz_execute_SRC2_2;
	end
	always @(execute_SRC2_CTRL or execute_RS2 or _zz_execute_SRC2_1 or execute_INSTRUCTION or _zz_execute_SRC2_3 or _zz_execute_to_memory_PC)
		case (execute_SRC2_CTRL)
			Src2CtrlEnum_RS: _zz_execute_SRC2_4 = execute_RS2;
			Src2CtrlEnum_IMI: _zz_execute_SRC2_4 = {_zz_execute_SRC2_1, execute_INSTRUCTION[31:20]};
			Src2CtrlEnum_IMS: _zz_execute_SRC2_4 = {_zz_execute_SRC2_3, execute_INSTRUCTION[31:25], execute_INSTRUCTION[11:7]};
			default: _zz_execute_SRC2_4 = _zz_execute_to_memory_PC;
		endcase
	always @(_zz_execute_SrcPlugin_addSub or execute_SRC2_FORCE_ZERO or execute_SRC1) begin
		execute_SrcPlugin_addSub = _zz_execute_SrcPlugin_addSub;
		if (execute_SRC2_FORCE_ZERO)
			execute_SrcPlugin_addSub = execute_SRC1;
	end
	always @(execute_SRC1) begin
		_zz_execute_FullBarrelShifterPlugin_reversed[0] = execute_SRC1[31];
		_zz_execute_FullBarrelShifterPlugin_reversed[1] = execute_SRC1[30];
		_zz_execute_FullBarrelShifterPlugin_reversed[2] = execute_SRC1[29];
		_zz_execute_FullBarrelShifterPlugin_reversed[3] = execute_SRC1[28];
		_zz_execute_FullBarrelShifterPlugin_reversed[4] = execute_SRC1[27];
		_zz_execute_FullBarrelShifterPlugin_reversed[5] = execute_SRC1[26];
		_zz_execute_FullBarrelShifterPlugin_reversed[6] = execute_SRC1[25];
		_zz_execute_FullBarrelShifterPlugin_reversed[7] = execute_SRC1[24];
		_zz_execute_FullBarrelShifterPlugin_reversed[8] = execute_SRC1[23];
		_zz_execute_FullBarrelShifterPlugin_reversed[9] = execute_SRC1[22];
		_zz_execute_FullBarrelShifterPlugin_reversed[10] = execute_SRC1[21];
		_zz_execute_FullBarrelShifterPlugin_reversed[11] = execute_SRC1[20];
		_zz_execute_FullBarrelShifterPlugin_reversed[12] = execute_SRC1[19];
		_zz_execute_FullBarrelShifterPlugin_reversed[13] = execute_SRC1[18];
		_zz_execute_FullBarrelShifterPlugin_reversed[14] = execute_SRC1[17];
		_zz_execute_FullBarrelShifterPlugin_reversed[15] = execute_SRC1[16];
		_zz_execute_FullBarrelShifterPlugin_reversed[16] = execute_SRC1[15];
		_zz_execute_FullBarrelShifterPlugin_reversed[17] = execute_SRC1[14];
		_zz_execute_FullBarrelShifterPlugin_reversed[18] = execute_SRC1[13];
		_zz_execute_FullBarrelShifterPlugin_reversed[19] = execute_SRC1[12];
		_zz_execute_FullBarrelShifterPlugin_reversed[20] = execute_SRC1[11];
		_zz_execute_FullBarrelShifterPlugin_reversed[21] = execute_SRC1[10];
		_zz_execute_FullBarrelShifterPlugin_reversed[22] = execute_SRC1[9];
		_zz_execute_FullBarrelShifterPlugin_reversed[23] = execute_SRC1[8];
		_zz_execute_FullBarrelShifterPlugin_reversed[24] = execute_SRC1[7];
		_zz_execute_FullBarrelShifterPlugin_reversed[25] = execute_SRC1[6];
		_zz_execute_FullBarrelShifterPlugin_reversed[26] = execute_SRC1[5];
		_zz_execute_FullBarrelShifterPlugin_reversed[27] = execute_SRC1[4];
		_zz_execute_FullBarrelShifterPlugin_reversed[28] = execute_SRC1[3];
		_zz_execute_FullBarrelShifterPlugin_reversed[29] = execute_SRC1[2];
		_zz_execute_FullBarrelShifterPlugin_reversed[30] = execute_SRC1[1];
		_zz_execute_FullBarrelShifterPlugin_reversed[31] = execute_SRC1[0];
	end
	always @(memory_SHIFT_RIGHT) begin
		_zz_decode_RS2_3[0] = memory_SHIFT_RIGHT[31];
		_zz_decode_RS2_3[1] = memory_SHIFT_RIGHT[30];
		_zz_decode_RS2_3[2] = memory_SHIFT_RIGHT[29];
		_zz_decode_RS2_3[3] = memory_SHIFT_RIGHT[28];
		_zz_decode_RS2_3[4] = memory_SHIFT_RIGHT[27];
		_zz_decode_RS2_3[5] = memory_SHIFT_RIGHT[26];
		_zz_decode_RS2_3[6] = memory_SHIFT_RIGHT[25];
		_zz_decode_RS2_3[7] = memory_SHIFT_RIGHT[24];
		_zz_decode_RS2_3[8] = memory_SHIFT_RIGHT[23];
		_zz_decode_RS2_3[9] = memory_SHIFT_RIGHT[22];
		_zz_decode_RS2_3[10] = memory_SHIFT_RIGHT[21];
		_zz_decode_RS2_3[11] = memory_SHIFT_RIGHT[20];
		_zz_decode_RS2_3[12] = memory_SHIFT_RIGHT[19];
		_zz_decode_RS2_3[13] = memory_SHIFT_RIGHT[18];
		_zz_decode_RS2_3[14] = memory_SHIFT_RIGHT[17];
		_zz_decode_RS2_3[15] = memory_SHIFT_RIGHT[16];
		_zz_decode_RS2_3[16] = memory_SHIFT_RIGHT[15];
		_zz_decode_RS2_3[17] = memory_SHIFT_RIGHT[14];
		_zz_decode_RS2_3[18] = memory_SHIFT_RIGHT[13];
		_zz_decode_RS2_3[19] = memory_SHIFT_RIGHT[12];
		_zz_decode_RS2_3[20] = memory_SHIFT_RIGHT[11];
		_zz_decode_RS2_3[21] = memory_SHIFT_RIGHT[10];
		_zz_decode_RS2_3[22] = memory_SHIFT_RIGHT[9];
		_zz_decode_RS2_3[23] = memory_SHIFT_RIGHT[8];
		_zz_decode_RS2_3[24] = memory_SHIFT_RIGHT[7];
		_zz_decode_RS2_3[25] = memory_SHIFT_RIGHT[6];
		_zz_decode_RS2_3[26] = memory_SHIFT_RIGHT[5];
		_zz_decode_RS2_3[27] = memory_SHIFT_RIGHT[4];
		_zz_decode_RS2_3[28] = memory_SHIFT_RIGHT[3];
		_zz_decode_RS2_3[29] = memory_SHIFT_RIGHT[2];
		_zz_decode_RS2_3[30] = memory_SHIFT_RIGHT[1];
		_zz_decode_RS2_3[31] = memory_SHIFT_RIGHT[0];
	end
	always @(switch_MulPlugin_l87)
		case (switch_MulPlugin_l87)
			2'h1: execute_MulPlugin_aSigned = 1'b1;
			2'h2: execute_MulPlugin_aSigned = 1'b1;
			default: execute_MulPlugin_aSigned = 1'b0;
		endcase
	always @(switch_MulPlugin_l87)
		case (switch_MulPlugin_l87)
			2'h1: execute_MulPlugin_bSigned = 1'b1;
			2'h2: execute_MulPlugin_bSigned = 1'b0;
			default: execute_MulPlugin_bSigned = 1'b0;
		endcase
	always @(when_MulDivIterativePlugin_l128 or when_MulDivIterativePlugin_l132) begin
		memory_DivPlugin_div_counter_willIncrement = 1'b0;
		if (when_MulDivIterativePlugin_l128) begin
			if (when_MulDivIterativePlugin_l132)
				memory_DivPlugin_div_counter_willIncrement = 1'b1;
		end
	end
	always @(when_MulDivIterativePlugin_l162) begin
		memory_DivPlugin_div_counter_willClear = 1'b0;
		if (when_MulDivIterativePlugin_l162)
			memory_DivPlugin_div_counter_willClear = 1'b1;
	end
	always @(memory_DivPlugin_div_counter_willOverflow or memory_DivPlugin_div_counter_value or _zz_memory_DivPlugin_div_counter_valueNext or memory_DivPlugin_div_counter_willClear) begin
		if (memory_DivPlugin_div_counter_willOverflow)
			memory_DivPlugin_div_counter_valueNext = 6'h00;
		else
			memory_DivPlugin_div_counter_valueNext = memory_DivPlugin_div_counter_value + _zz_memory_DivPlugin_div_counter_valueNext;
		if (memory_DivPlugin_div_counter_willClear)
			memory_DivPlugin_div_counter_valueNext = 6'h00;
	end
	always @(execute_IS_RS1_SIGNED or execute_RS1) begin
		_zz_memory_DivPlugin_rs1_1[32] = execute_IS_RS1_SIGNED && execute_RS1[31];
		_zz_memory_DivPlugin_rs1_1[31:0] = execute_RS1;
	end
	always @(when_HazardSimplePlugin_l57 or when_HazardSimplePlugin_l58 or when_HazardSimplePlugin_l48 or when_HazardSimplePlugin_l57_1 or when_HazardSimplePlugin_l58_1 or when_HazardSimplePlugin_l48_1 or when_HazardSimplePlugin_l57_2 or when_HazardSimplePlugin_l58_2 or when_HazardSimplePlugin_l48_2 or when_HazardSimplePlugin_l105) begin
		HazardSimplePlugin_src0Hazard = 1'b0;
		if (when_HazardSimplePlugin_l57) begin
			if (when_HazardSimplePlugin_l58) begin
				if (when_HazardSimplePlugin_l48)
					HazardSimplePlugin_src0Hazard = 1'b1;
			end
		end
		if (when_HazardSimplePlugin_l57_1) begin
			if (when_HazardSimplePlugin_l58_1) begin
				if (when_HazardSimplePlugin_l48_1)
					HazardSimplePlugin_src0Hazard = 1'b1;
			end
		end
		if (when_HazardSimplePlugin_l57_2) begin
			if (when_HazardSimplePlugin_l58_2) begin
				if (when_HazardSimplePlugin_l48_2)
					HazardSimplePlugin_src0Hazard = 1'b1;
			end
		end
		if (when_HazardSimplePlugin_l105)
			HazardSimplePlugin_src0Hazard = 1'b0;
	end
	always @(when_HazardSimplePlugin_l57 or when_HazardSimplePlugin_l58 or when_HazardSimplePlugin_l51 or when_HazardSimplePlugin_l57_1 or when_HazardSimplePlugin_l58_1 or when_HazardSimplePlugin_l51_1 or when_HazardSimplePlugin_l57_2 or when_HazardSimplePlugin_l58_2 or when_HazardSimplePlugin_l51_2 or when_HazardSimplePlugin_l108) begin
		HazardSimplePlugin_src1Hazard = 1'b0;
		if (when_HazardSimplePlugin_l57) begin
			if (when_HazardSimplePlugin_l58) begin
				if (when_HazardSimplePlugin_l51)
					HazardSimplePlugin_src1Hazard = 1'b1;
			end
		end
		if (when_HazardSimplePlugin_l57_1) begin
			if (when_HazardSimplePlugin_l58_1) begin
				if (when_HazardSimplePlugin_l51_1)
					HazardSimplePlugin_src1Hazard = 1'b1;
			end
		end
		if (when_HazardSimplePlugin_l57_2) begin
			if (when_HazardSimplePlugin_l58_2) begin
				if (when_HazardSimplePlugin_l51_2)
					HazardSimplePlugin_src1Hazard = 1'b1;
			end
		end
		if (when_HazardSimplePlugin_l108)
			HazardSimplePlugin_src1Hazard = 1'b0;
	end
	always @(switch_Misc_l226_1 or execute_BranchPlugin_eq or execute_SRC_LESS)
		case (switch_Misc_l226_1)
			3'h0: _zz_execute_BRANCH_COND_RESULT = execute_BranchPlugin_eq;
			3'h1: _zz_execute_BRANCH_COND_RESULT = !execute_BranchPlugin_eq;
			3'h5: _zz_execute_BRANCH_COND_RESULT = !execute_SRC_LESS;
			3'h7: _zz_execute_BRANCH_COND_RESULT = !execute_SRC_LESS;
			default: _zz_execute_BRANCH_COND_RESULT = execute_SRC_LESS;
		endcase
	always @(execute_BRANCH_CTRL or _zz_execute_BRANCH_COND_RESULT)
		case (execute_BRANCH_CTRL)
			BranchCtrlEnum_INC: _zz_execute_BRANCH_COND_RESULT_1 = 1'b0;
			BranchCtrlEnum_JAL: _zz_execute_BRANCH_COND_RESULT_1 = 1'b1;
			BranchCtrlEnum_JALR: _zz_execute_BRANCH_COND_RESULT_1 = 1'b1;
			default: _zz_execute_BRANCH_COND_RESULT_1 = _zz_execute_BRANCH_COND_RESULT;
		endcase
	always @(_zz_execute_BranchPlugin_missAlignedTarget) begin
		_zz_execute_BranchPlugin_missAlignedTarget_1[19] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[18] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[17] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[16] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[15] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[14] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[13] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[12] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[11] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[10] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[9] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[8] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[7] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[6] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[5] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[4] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[3] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[2] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[1] = _zz_execute_BranchPlugin_missAlignedTarget;
		_zz_execute_BranchPlugin_missAlignedTarget_1[0] = _zz_execute_BranchPlugin_missAlignedTarget;
	end
	always @(_zz_execute_BranchPlugin_missAlignedTarget_2) begin
		_zz_execute_BranchPlugin_missAlignedTarget_3[10] = _zz_execute_BranchPlugin_missAlignedTarget_2;
		_zz_execute_BranchPlugin_missAlignedTarget_3[9] = _zz_execute_BranchPlugin_missAlignedTarget_2;
		_zz_execute_BranchPlugin_missAlignedTarget_3[8] = _zz_execute_BranchPlugin_missAlignedTarget_2;
		_zz_execute_BranchPlugin_missAlignedTarget_3[7] = _zz_execute_BranchPlugin_missAlignedTarget_2;
		_zz_execute_BranchPlugin_missAlignedTarget_3[6] = _zz_execute_BranchPlugin_missAlignedTarget_2;
		_zz_execute_BranchPlugin_missAlignedTarget_3[5] = _zz_execute_BranchPlugin_missAlignedTarget_2;
		_zz_execute_BranchPlugin_missAlignedTarget_3[4] = _zz_execute_BranchPlugin_missAlignedTarget_2;
		_zz_execute_BranchPlugin_missAlignedTarget_3[3] = _zz_execute_BranchPlugin_missAlignedTarget_2;
		_zz_execute_BranchPlugin_missAlignedTarget_3[2] = _zz_execute_BranchPlugin_missAlignedTarget_2;
		_zz_execute_BranchPlugin_missAlignedTarget_3[1] = _zz_execute_BranchPlugin_missAlignedTarget_2;
		_zz_execute_BranchPlugin_missAlignedTarget_3[0] = _zz_execute_BranchPlugin_missAlignedTarget_2;
	end
	always @(_zz_execute_BranchPlugin_missAlignedTarget_4) begin
		_zz_execute_BranchPlugin_missAlignedTarget_5[18] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[17] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[16] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[15] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[14] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[13] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[12] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[11] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[10] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[9] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[8] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[7] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[6] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[5] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[4] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[3] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[2] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[1] = _zz_execute_BranchPlugin_missAlignedTarget_4;
		_zz_execute_BranchPlugin_missAlignedTarget_5[0] = _zz_execute_BranchPlugin_missAlignedTarget_4;
	end
	always @(execute_BRANCH_CTRL or _zz__zz_execute_BranchPlugin_missAlignedTarget_6 or execute_RS1 or _zz__zz_execute_BranchPlugin_missAlignedTarget_6_1 or _zz__zz_execute_BranchPlugin_missAlignedTarget_6_2)
		case (execute_BRANCH_CTRL)
			BranchCtrlEnum_JALR: _zz_execute_BranchPlugin_missAlignedTarget_6 = _zz__zz_execute_BranchPlugin_missAlignedTarget_6[1] ^ execute_RS1[1];
			BranchCtrlEnum_JAL: _zz_execute_BranchPlugin_missAlignedTarget_6 = _zz__zz_execute_BranchPlugin_missAlignedTarget_6_1[1];
			default: _zz_execute_BranchPlugin_missAlignedTarget_6 = _zz__zz_execute_BranchPlugin_missAlignedTarget_6_2[1];
		endcase
	always @(execute_BRANCH_CTRL or execute_RS1 or execute_PC)
		case (execute_BRANCH_CTRL)
			BranchCtrlEnum_JALR: execute_BranchPlugin_branch_src1 = execute_RS1;
			default: execute_BranchPlugin_branch_src1 = execute_PC;
		endcase
	always @(_zz_execute_BranchPlugin_branch_src2) begin
		_zz_execute_BranchPlugin_branch_src2_1[19] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[18] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[17] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[16] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[15] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[14] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[13] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[12] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[11] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[10] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[9] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[8] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[7] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[6] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[5] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[4] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[3] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[2] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[1] = _zz_execute_BranchPlugin_branch_src2;
		_zz_execute_BranchPlugin_branch_src2_1[0] = _zz_execute_BranchPlugin_branch_src2;
	end
	always @(execute_BRANCH_CTRL or _zz_execute_BranchPlugin_branch_src2_1 or execute_INSTRUCTION or _zz_execute_BranchPlugin_branch_src2_3 or _zz_execute_BranchPlugin_branch_src2_6 or _zz_execute_BranchPlugin_branch_src2_5 or _zz_execute_BranchPlugin_branch_src2_7 or _zz_execute_BranchPlugin_branch_src2_8 or execute_PREDICTION_HAD_BRANCHED2 or _zz_execute_BranchPlugin_branch_src2_9)
		case (execute_BRANCH_CTRL)
			BranchCtrlEnum_JALR: execute_BranchPlugin_branch_src2 = {_zz_execute_BranchPlugin_branch_src2_1, execute_INSTRUCTION[31:20]};
			default: begin
				execute_BranchPlugin_branch_src2 = (execute_BRANCH_CTRL == BranchCtrlEnum_JAL ? {_zz_execute_BranchPlugin_branch_src2_3, _zz_execute_BranchPlugin_branch_src2_6, execute_INSTRUCTION[19:12], execute_INSTRUCTION[20], execute_INSTRUCTION[30:21], 1'b0} : {_zz_execute_BranchPlugin_branch_src2_5, _zz_execute_BranchPlugin_branch_src2_7, _zz_execute_BranchPlugin_branch_src2_8, execute_INSTRUCTION[30:25], execute_INSTRUCTION[11:8], 1'b0});
				if (execute_PREDICTION_HAD_BRANCHED2)
					execute_BranchPlugin_branch_src2 = {29'h00000000, _zz_execute_BranchPlugin_branch_src2_9};
			end
		endcase
	always @(_zz_execute_BranchPlugin_branch_src2_2) begin
		_zz_execute_BranchPlugin_branch_src2_3[10] = _zz_execute_BranchPlugin_branch_src2_2;
		_zz_execute_BranchPlugin_branch_src2_3[9] = _zz_execute_BranchPlugin_branch_src2_2;
		_zz_execute_BranchPlugin_branch_src2_3[8] = _zz_execute_BranchPlugin_branch_src2_2;
		_zz_execute_BranchPlugin_branch_src2_3[7] = _zz_execute_BranchPlugin_branch_src2_2;
		_zz_execute_BranchPlugin_branch_src2_3[6] = _zz_execute_BranchPlugin_branch_src2_2;
		_zz_execute_BranchPlugin_branch_src2_3[5] = _zz_execute_BranchPlugin_branch_src2_2;
		_zz_execute_BranchPlugin_branch_src2_3[4] = _zz_execute_BranchPlugin_branch_src2_2;
		_zz_execute_BranchPlugin_branch_src2_3[3] = _zz_execute_BranchPlugin_branch_src2_2;
		_zz_execute_BranchPlugin_branch_src2_3[2] = _zz_execute_BranchPlugin_branch_src2_2;
		_zz_execute_BranchPlugin_branch_src2_3[1] = _zz_execute_BranchPlugin_branch_src2_2;
		_zz_execute_BranchPlugin_branch_src2_3[0] = _zz_execute_BranchPlugin_branch_src2_2;
	end
	always @(_zz_execute_BranchPlugin_branch_src2_4) begin
		_zz_execute_BranchPlugin_branch_src2_5[18] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[17] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[16] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[15] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[14] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[13] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[12] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[11] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[10] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[9] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[8] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[7] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[6] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[5] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[4] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[3] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[2] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[1] = _zz_execute_BranchPlugin_branch_src2_4;
		_zz_execute_BranchPlugin_branch_src2_5[0] = _zz_execute_BranchPlugin_branch_src2_4;
	end
	always @(_zz_CsrPlugin_privilege or CsrPlugin_forceMachineWire) begin
		CsrPlugin_privilege = _zz_CsrPlugin_privilege;
		if (CsrPlugin_forceMachineWire)
			CsrPlugin_privilege = 2'h3;
	end
	always @(CsrPlugin_rescheduleLogic_rescheduleNext) begin
		CsrPlugin_redoInterface_valid = 1'b0;
		if (CsrPlugin_rescheduleLogic_rescheduleNext)
			CsrPlugin_redoInterface_valid = 1'b1;
	end
	always @(when_CsrPlugin_l1153 or execute_CsrPlugin_csr_384 or execute_CsrPlugin_writeInstruction) begin
		CsrPlugin_rescheduleLogic_rescheduleNext = 1'b0;
		if (when_CsrPlugin_l1153)
			CsrPlugin_rescheduleLogic_rescheduleNext = 1'b1;
		if (execute_CsrPlugin_csr_384) begin
			if (execute_CsrPlugin_writeInstruction)
				CsrPlugin_rescheduleLogic_rescheduleNext = 1'b1;
		end
	end
	always @(CsrPlugin_exceptionPortCtrl_exceptionContext_code or when_CsrPlugin_l1216 or when_CsrPlugin_l1216_1 or when_CsrPlugin_l1216_2 or when_CsrPlugin_l1216_3 or when_CsrPlugin_l1216_4 or when_CsrPlugin_l1216_5 or when_CsrPlugin_l1216_6 or when_CsrPlugin_l1216_7 or when_CsrPlugin_l1216_8 or when_CsrPlugin_l1216_9 or when_CsrPlugin_l1216_10 or when_CsrPlugin_l1216_11) begin
		CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h3;
		case (CsrPlugin_exceptionPortCtrl_exceptionContext_code)
			4'h0:
				if (when_CsrPlugin_l1216)
					CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h1;
			4'h1:
				if (when_CsrPlugin_l1216_1)
					CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h1;
			4'h2:
				if (when_CsrPlugin_l1216_2)
					CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h1;
			4'h4:
				if (when_CsrPlugin_l1216_3)
					CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h1;
			4'h5:
				if (when_CsrPlugin_l1216_4)
					CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h1;
			4'h6:
				if (when_CsrPlugin_l1216_5)
					CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h1;
			4'h7:
				if (when_CsrPlugin_l1216_6)
					CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h1;
			4'h8:
				if (when_CsrPlugin_l1216_7)
					CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h1;
			4'h9:
				if (when_CsrPlugin_l1216_8)
					CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h1;
			4'hc:
				if (when_CsrPlugin_l1216_9)
					CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h1;
			4'hd:
				if (when_CsrPlugin_l1216_10)
					CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h1;
			4'hf:
				if (when_CsrPlugin_l1216_11)
					CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'h1;
			default:
				;
		endcase
	end
	always @(CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode or _zz_when or decode_arbitration_isFlushed) begin
		CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
		if (_zz_when)
			CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b1;
		if (decode_arbitration_isFlushed)
			CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b0;
	end
	always @(CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute or CsrPlugin_selfException_valid or execute_arbitration_isFlushed) begin
		CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
		if (CsrPlugin_selfException_valid)
			CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b1;
		if (execute_arbitration_isFlushed)
			CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
	end
	always @(CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory or BranchPlugin_branchExceptionPort_valid or memory_arbitration_isFlushed) begin
		CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
		if (BranchPlugin_branchExceptionPort_valid)
			CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b1;
		if (memory_arbitration_isFlushed)
			CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
	end
	always @(CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack or DBusCachedPlugin_exceptionBus_valid or writeBack_arbitration_isFlushed) begin
		CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
		if (DBusCachedPlugin_exceptionBus_valid)
			CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b1;
		if (writeBack_arbitration_isFlushed)
			CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b0;
	end
	always @(CsrPlugin_pipelineLiberator_pcValids_2 or when_CsrPlugin_l1346 or CsrPlugin_hadException) begin
		CsrPlugin_pipelineLiberator_done = CsrPlugin_pipelineLiberator_pcValids_2;
		if (when_CsrPlugin_l1346)
			CsrPlugin_pipelineLiberator_done = 1'b0;
		if (CsrPlugin_hadException)
			CsrPlugin_pipelineLiberator_done = 1'b0;
	end
	always @(CsrPlugin_interrupt_targetPrivilege or CsrPlugin_hadException or CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege) begin
		CsrPlugin_targetPrivilege = CsrPlugin_interrupt_targetPrivilege;
		if (CsrPlugin_hadException)
			CsrPlugin_targetPrivilege = CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
	end
	always @(CsrPlugin_interrupt_code or CsrPlugin_hadException or CsrPlugin_exceptionPortCtrl_exceptionContext_code) begin
		CsrPlugin_trapCause = CsrPlugin_interrupt_code;
		if (CsrPlugin_hadException)
			CsrPlugin_trapCause = CsrPlugin_exceptionPortCtrl_exceptionContext_code;
	end
	always @(CsrPlugin_targetPrivilege or CsrPlugin_stvec_mode or CsrPlugin_mtvec_mode) begin
		CsrPlugin_xtvec_mode = 2'bxx;
		case (CsrPlugin_targetPrivilege)
			2'h1: CsrPlugin_xtvec_mode = CsrPlugin_stvec_mode;
			2'h3: CsrPlugin_xtvec_mode = CsrPlugin_mtvec_mode;
			default:
				;
		endcase
	end
	always @(CsrPlugin_targetPrivilege or CsrPlugin_stvec_base or CsrPlugin_mtvec_base) begin
		CsrPlugin_xtvec_base = 30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		case (CsrPlugin_targetPrivilege)
			2'h1: CsrPlugin_xtvec_base = CsrPlugin_stvec_base;
			2'h3: CsrPlugin_xtvec_base = CsrPlugin_mtvec_base;
			default:
				;
		endcase
	end
	always @(execute_CsrPlugin_csr_768 or execute_CsrPlugin_csr_256 or execute_CsrPlugin_csr_384 or execute_CsrPlugin_csr_3 or execute_CsrPlugin_csr_2 or execute_CsrPlugin_csr_1 or execute_CsrPlugin_csr_3857 or execute_CSR_READ_OPCODE or execute_CsrPlugin_csr_3858 or execute_CsrPlugin_csr_3859 or execute_CsrPlugin_csr_3860 or execute_CsrPlugin_csr_769 or execute_CsrPlugin_csr_836 or execute_CsrPlugin_csr_772 or execute_CsrPlugin_csr_773 or execute_CsrPlugin_csr_833 or execute_CsrPlugin_csr_832 or execute_CsrPlugin_csr_834 or execute_CsrPlugin_csr_835 or execute_CsrPlugin_csr_2816 or execute_CsrPlugin_csr_2944 or execute_CsrPlugin_csr_2818 or execute_CsrPlugin_csr_2946 or execute_CsrPlugin_csr_770 or execute_CsrPlugin_csr_771 or execute_CsrPlugin_csr_3072 or execute_CsrPlugin_csr_3200 or execute_CsrPlugin_csr_3074 or execute_CsrPlugin_csr_3202 or execute_CsrPlugin_csr_774 or execute_CsrPlugin_csr_262 or execute_CsrPlugin_csr_324 or execute_CsrPlugin_csr_260 or execute_CsrPlugin_csr_261 or execute_CsrPlugin_csr_321 or execute_CsrPlugin_csr_320 or execute_CsrPlugin_csr_322 or execute_CsrPlugin_csr_323 or CsrPlugin_csrMapping_allowCsrSignal or when_CsrPlugin_l1712 or when_CsrPlugin_l1718) begin
		execute_CsrPlugin_illegalAccess = 1'b1;
		if (execute_CsrPlugin_csr_768)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_256)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_384)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_3)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_2)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_1)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_3857) begin
			if (execute_CSR_READ_OPCODE)
				execute_CsrPlugin_illegalAccess = 1'b0;
		end
		if (execute_CsrPlugin_csr_3858) begin
			if (execute_CSR_READ_OPCODE)
				execute_CsrPlugin_illegalAccess = 1'b0;
		end
		if (execute_CsrPlugin_csr_3859) begin
			if (execute_CSR_READ_OPCODE)
				execute_CsrPlugin_illegalAccess = 1'b0;
		end
		if (execute_CsrPlugin_csr_3860) begin
			if (execute_CSR_READ_OPCODE)
				execute_CsrPlugin_illegalAccess = 1'b0;
		end
		if (execute_CsrPlugin_csr_769)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_836)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_772)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_773)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_833)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_832)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_834)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_835)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_2816)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_2944)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_2818)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_2946)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_770)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_771)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_3072) begin
			if (execute_CSR_READ_OPCODE)
				execute_CsrPlugin_illegalAccess = 1'b0;
		end
		if (execute_CsrPlugin_csr_3200) begin
			if (execute_CSR_READ_OPCODE)
				execute_CsrPlugin_illegalAccess = 1'b0;
		end
		if (execute_CsrPlugin_csr_3074) begin
			if (execute_CSR_READ_OPCODE)
				execute_CsrPlugin_illegalAccess = 1'b0;
		end
		if (execute_CsrPlugin_csr_3202) begin
			if (execute_CSR_READ_OPCODE)
				execute_CsrPlugin_illegalAccess = 1'b0;
		end
		if (execute_CsrPlugin_csr_774)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_262)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_324)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_260)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_261)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_321)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_320)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_322)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (execute_CsrPlugin_csr_323)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (CsrPlugin_csrMapping_allowCsrSignal)
			execute_CsrPlugin_illegalAccess = 1'b0;
		if (when_CsrPlugin_l1712)
			execute_CsrPlugin_illegalAccess = 1'b1;
		if (when_CsrPlugin_l1718)
			execute_CsrPlugin_illegalAccess = 1'b0;
	end
	always @(when_CsrPlugin_l1547 or when_CsrPlugin_l1548) begin
		execute_CsrPlugin_illegalInstruction = 1'b0;
		if (when_CsrPlugin_l1547) begin
			if (when_CsrPlugin_l1548)
				execute_CsrPlugin_illegalInstruction = 1'b1;
		end
	end
	always @(when_CsrPlugin_l1540 or when_CsrPlugin_l1555 or when_CsrPlugin_l1565) begin
		CsrPlugin_selfException_valid = 1'b0;
		if (when_CsrPlugin_l1540)
			CsrPlugin_selfException_valid = 1'b1;
		if (when_CsrPlugin_l1555)
			CsrPlugin_selfException_valid = 1'b1;
		if (when_CsrPlugin_l1565)
			CsrPlugin_selfException_valid = 1'b1;
	end
	always @(when_CsrPlugin_l1540 or when_CsrPlugin_l1555 or CsrPlugin_privilege or when_CsrPlugin_l1565) begin
		CsrPlugin_selfException_payload_code = 4'bxxxx;
		if (when_CsrPlugin_l1540)
			CsrPlugin_selfException_payload_code = 4'h2;
		if (when_CsrPlugin_l1555)
			case (CsrPlugin_privilege)
				2'h0: CsrPlugin_selfException_payload_code = 4'h8;
				2'h1: CsrPlugin_selfException_payload_code = 4'h9;
				default: CsrPlugin_selfException_payload_code = 4'hb;
			endcase
		if (when_CsrPlugin_l1565)
			CsrPlugin_selfException_payload_code = 4'h3;
	end
	always @(execute_arbitration_isValid or execute_IS_CSR or execute_CSR_WRITE_OPCODE or when_CsrPlugin_l1712) begin
		execute_CsrPlugin_writeInstruction = (execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE;
		if (when_CsrPlugin_l1712)
			execute_CsrPlugin_writeInstruction = 1'b0;
	end
	always @(execute_arbitration_isValid or execute_IS_CSR or execute_CSR_READ_OPCODE or when_CsrPlugin_l1712) begin
		execute_CsrPlugin_readInstruction = (execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE;
		if (when_CsrPlugin_l1712)
			execute_CsrPlugin_readInstruction = 1'b0;
	end
	always @(CsrPlugin_csrMapping_readDataSignal or execute_CsrPlugin_csr_836 or CsrPlugin_sip_SEIP_SOFT or execute_CsrPlugin_csr_324) begin
		execute_CsrPlugin_readToWriteData = CsrPlugin_csrMapping_readDataSignal;
		if (execute_CsrPlugin_csr_836)
			execute_CsrPlugin_readToWriteData[9] = CsrPlugin_sip_SEIP_SOFT;
		if (execute_CsrPlugin_csr_324)
			execute_CsrPlugin_readToWriteData[9] = CsrPlugin_sip_SEIP_SOFT;
	end
	always @(switch_Misc_l226_2 or execute_SRC1 or execute_INSTRUCTION or execute_CsrPlugin_readToWriteData)
		case (switch_Misc_l226_2)
			1'b0: _zz_CsrPlugin_csrMapping_writeDataSignal = execute_SRC1;
			default: _zz_CsrPlugin_csrMapping_writeDataSignal = (execute_INSTRUCTION[12] ? execute_CsrPlugin_readToWriteData & ~execute_SRC1 : execute_CsrPlugin_readToWriteData | execute_SRC1);
		endcase
	always @(execute_CsrPlugin_csr_768 or MmuPlugin_status_mxr or MmuPlugin_status_sum or MmuPlugin_status_mprv or FpuPlugin_fs or FpuPlugin_sd or CsrPlugin_mstatus_MPIE or CsrPlugin_mstatus_MIE or CsrPlugin_mstatus_MPP or CsrPlugin_sstatus_SPP or CsrPlugin_sstatus_SPIE or CsrPlugin_sstatus_SIE) begin
		_zz_CsrPlugin_csrMapping_readDataInit = 32'h00000000;
		if (execute_CsrPlugin_csr_768) begin
			_zz_CsrPlugin_csrMapping_readDataInit[19] = MmuPlugin_status_mxr;
			_zz_CsrPlugin_csrMapping_readDataInit[18] = MmuPlugin_status_sum;
			_zz_CsrPlugin_csrMapping_readDataInit[17] = MmuPlugin_status_mprv;
			_zz_CsrPlugin_csrMapping_readDataInit[14:13] = FpuPlugin_fs;
			_zz_CsrPlugin_csrMapping_readDataInit[31] = FpuPlugin_sd;
			_zz_CsrPlugin_csrMapping_readDataInit[7] = CsrPlugin_mstatus_MPIE;
			_zz_CsrPlugin_csrMapping_readDataInit[3] = CsrPlugin_mstatus_MIE;
			_zz_CsrPlugin_csrMapping_readDataInit[12:11] = CsrPlugin_mstatus_MPP;
			_zz_CsrPlugin_csrMapping_readDataInit[8] = CsrPlugin_sstatus_SPP;
			_zz_CsrPlugin_csrMapping_readDataInit[5] = CsrPlugin_sstatus_SPIE;
			_zz_CsrPlugin_csrMapping_readDataInit[1] = CsrPlugin_sstatus_SIE;
		end
	end
	always @(execute_CsrPlugin_csr_256 or MmuPlugin_status_mxr or MmuPlugin_status_sum or MmuPlugin_status_mprv or FpuPlugin_fs or FpuPlugin_sd or CsrPlugin_sstatus_SPP or CsrPlugin_sstatus_SPIE or CsrPlugin_sstatus_SIE) begin
		_zz_CsrPlugin_csrMapping_readDataInit_1 = 32'h00000000;
		if (execute_CsrPlugin_csr_256) begin
			_zz_CsrPlugin_csrMapping_readDataInit_1[19] = MmuPlugin_status_mxr;
			_zz_CsrPlugin_csrMapping_readDataInit_1[18] = MmuPlugin_status_sum;
			_zz_CsrPlugin_csrMapping_readDataInit_1[17] = MmuPlugin_status_mprv;
			_zz_CsrPlugin_csrMapping_readDataInit_1[14:13] = FpuPlugin_fs;
			_zz_CsrPlugin_csrMapping_readDataInit_1[31] = FpuPlugin_sd;
			_zz_CsrPlugin_csrMapping_readDataInit_1[8] = CsrPlugin_sstatus_SPP;
			_zz_CsrPlugin_csrMapping_readDataInit_1[5] = CsrPlugin_sstatus_SPIE;
			_zz_CsrPlugin_csrMapping_readDataInit_1[1] = CsrPlugin_sstatus_SIE;
		end
	end
	always @(execute_CsrPlugin_csr_384 or MmuPlugin_satp_mode or MmuPlugin_satp_asid or MmuPlugin_satp_ppn or CsrPlugin_satp_MODE or CsrPlugin_satp_ASID or CsrPlugin_satp_PPN) begin
		_zz_CsrPlugin_csrMapping_readDataInit_2 = 32'h00000000;
		if (execute_CsrPlugin_csr_384) begin
			_zz_CsrPlugin_csrMapping_readDataInit_2[31] = MmuPlugin_satp_mode;
			_zz_CsrPlugin_csrMapping_readDataInit_2[30:22] = MmuPlugin_satp_asid;
			_zz_CsrPlugin_csrMapping_readDataInit_2[21:0] = MmuPlugin_satp_ppn;
			_zz_CsrPlugin_csrMapping_readDataInit_2[31] = CsrPlugin_satp_MODE;
			_zz_CsrPlugin_csrMapping_readDataInit_2[30:22] = CsrPlugin_satp_ASID;
			_zz_CsrPlugin_csrMapping_readDataInit_2[21:0] = CsrPlugin_satp_PPN;
		end
	end
	always @(execute_CsrPlugin_csr_3 or FpuPlugin_rm or FpuPlugin_flags_NV or FpuPlugin_flags_DZ or FpuPlugin_flags_OF or FpuPlugin_flags_UF or FpuPlugin_flags_NX) begin
		_zz_CsrPlugin_csrMapping_readDataInit_3 = 32'h00000000;
		if (execute_CsrPlugin_csr_3) begin
			_zz_CsrPlugin_csrMapping_readDataInit_3[7:5] = FpuPlugin_rm;
			_zz_CsrPlugin_csrMapping_readDataInit_3[4:0] = {FpuPlugin_flags_NV, FpuPlugin_flags_DZ, FpuPlugin_flags_OF, FpuPlugin_flags_UF, FpuPlugin_flags_NX};
		end
	end
	always @(execute_CsrPlugin_csr_2 or FpuPlugin_rm) begin
		_zz_CsrPlugin_csrMapping_readDataInit_4 = 32'h00000000;
		if (execute_CsrPlugin_csr_2)
			_zz_CsrPlugin_csrMapping_readDataInit_4[2:0] = FpuPlugin_rm;
	end
	always @(execute_CsrPlugin_csr_1 or FpuPlugin_flags_NV or FpuPlugin_flags_DZ or FpuPlugin_flags_OF or FpuPlugin_flags_UF or FpuPlugin_flags_NX) begin
		_zz_CsrPlugin_csrMapping_readDataInit_5 = 32'h00000000;
		if (execute_CsrPlugin_csr_1)
			_zz_CsrPlugin_csrMapping_readDataInit_5[4:0] = {FpuPlugin_flags_NV, FpuPlugin_flags_DZ, FpuPlugin_flags_OF, FpuPlugin_flags_UF, FpuPlugin_flags_NX};
	end
	always @(execute_CsrPlugin_csr_769 or CsrPlugin_misa_base or CsrPlugin_misa_extensions) begin
		_zz_CsrPlugin_csrMapping_readDataInit_6 = 32'h00000000;
		if (execute_CsrPlugin_csr_769) begin
			_zz_CsrPlugin_csrMapping_readDataInit_6[31:30] = CsrPlugin_misa_base;
			_zz_CsrPlugin_csrMapping_readDataInit_6[25:0] = CsrPlugin_misa_extensions;
		end
	end
	always @(execute_CsrPlugin_csr_836 or CsrPlugin_mip_MEIP or CsrPlugin_mip_MTIP or CsrPlugin_mip_MSIP or CsrPlugin_sip_STIP or CsrPlugin_sip_SSIP or CsrPlugin_sip_SEIP_OR) begin
		_zz_CsrPlugin_csrMapping_readDataInit_7 = 32'h00000000;
		if (execute_CsrPlugin_csr_836) begin
			_zz_CsrPlugin_csrMapping_readDataInit_7[11] = CsrPlugin_mip_MEIP;
			_zz_CsrPlugin_csrMapping_readDataInit_7[7] = CsrPlugin_mip_MTIP;
			_zz_CsrPlugin_csrMapping_readDataInit_7[3] = CsrPlugin_mip_MSIP;
			_zz_CsrPlugin_csrMapping_readDataInit_7[5] = CsrPlugin_sip_STIP;
			_zz_CsrPlugin_csrMapping_readDataInit_7[1] = CsrPlugin_sip_SSIP;
			_zz_CsrPlugin_csrMapping_readDataInit_7[9] = CsrPlugin_sip_SEIP_OR;
		end
	end
	always @(execute_CsrPlugin_csr_772 or CsrPlugin_mie_MEIE or CsrPlugin_mie_MTIE or CsrPlugin_mie_MSIE or CsrPlugin_sie_SEIE or CsrPlugin_sie_STIE or CsrPlugin_sie_SSIE) begin
		_zz_CsrPlugin_csrMapping_readDataInit_8 = 32'h00000000;
		if (execute_CsrPlugin_csr_772) begin
			_zz_CsrPlugin_csrMapping_readDataInit_8[11] = CsrPlugin_mie_MEIE;
			_zz_CsrPlugin_csrMapping_readDataInit_8[7] = CsrPlugin_mie_MTIE;
			_zz_CsrPlugin_csrMapping_readDataInit_8[3] = CsrPlugin_mie_MSIE;
			_zz_CsrPlugin_csrMapping_readDataInit_8[9] = CsrPlugin_sie_SEIE;
			_zz_CsrPlugin_csrMapping_readDataInit_8[5] = CsrPlugin_sie_STIE;
			_zz_CsrPlugin_csrMapping_readDataInit_8[1] = CsrPlugin_sie_SSIE;
		end
	end
	always @(execute_CsrPlugin_csr_773 or CsrPlugin_mtvec_base) begin
		_zz_CsrPlugin_csrMapping_readDataInit_9 = 32'h00000000;
		if (execute_CsrPlugin_csr_773)
			_zz_CsrPlugin_csrMapping_readDataInit_9[31:2] = CsrPlugin_mtvec_base;
	end
	always @(execute_CsrPlugin_csr_833 or CsrPlugin_mepc) begin
		_zz_CsrPlugin_csrMapping_readDataInit_10 = 32'h00000000;
		if (execute_CsrPlugin_csr_833)
			_zz_CsrPlugin_csrMapping_readDataInit_10 = CsrPlugin_mepc;
	end
	always @(execute_CsrPlugin_csr_832 or CsrPlugin_mscratch) begin
		_zz_CsrPlugin_csrMapping_readDataInit_11 = 32'h00000000;
		if (execute_CsrPlugin_csr_832)
			_zz_CsrPlugin_csrMapping_readDataInit_11 = CsrPlugin_mscratch;
	end
	always @(execute_CsrPlugin_csr_834 or CsrPlugin_mcause_interrupt or CsrPlugin_mcause_exceptionCode) begin
		_zz_CsrPlugin_csrMapping_readDataInit_12 = 32'h00000000;
		if (execute_CsrPlugin_csr_834) begin
			_zz_CsrPlugin_csrMapping_readDataInit_12[31] = CsrPlugin_mcause_interrupt;
			_zz_CsrPlugin_csrMapping_readDataInit_12[3:0] = CsrPlugin_mcause_exceptionCode;
		end
	end
	always @(execute_CsrPlugin_csr_835 or CsrPlugin_mtval) begin
		_zz_CsrPlugin_csrMapping_readDataInit_13 = 32'h00000000;
		if (execute_CsrPlugin_csr_835)
			_zz_CsrPlugin_csrMapping_readDataInit_13 = CsrPlugin_mtval;
	end
	always @(execute_CsrPlugin_csr_2816 or CsrPlugin_mcycle) begin
		_zz_CsrPlugin_csrMapping_readDataInit_14 = 32'h00000000;
		if (execute_CsrPlugin_csr_2816)
			_zz_CsrPlugin_csrMapping_readDataInit_14 = CsrPlugin_mcycle[31:0];
	end
	always @(execute_CsrPlugin_csr_2944 or CsrPlugin_mcycle) begin
		_zz_CsrPlugin_csrMapping_readDataInit_15 = 32'h00000000;
		if (execute_CsrPlugin_csr_2944)
			_zz_CsrPlugin_csrMapping_readDataInit_15 = CsrPlugin_mcycle[63:32];
	end
	always @(execute_CsrPlugin_csr_2818 or CsrPlugin_minstret) begin
		_zz_CsrPlugin_csrMapping_readDataInit_16 = 32'h00000000;
		if (execute_CsrPlugin_csr_2818)
			_zz_CsrPlugin_csrMapping_readDataInit_16 = CsrPlugin_minstret[31:0];
	end
	always @(execute_CsrPlugin_csr_2946 or CsrPlugin_minstret) begin
		_zz_CsrPlugin_csrMapping_readDataInit_17 = 32'h00000000;
		if (execute_CsrPlugin_csr_2946)
			_zz_CsrPlugin_csrMapping_readDataInit_17 = CsrPlugin_minstret[63:32];
	end
	always @(execute_CsrPlugin_csr_770 or CsrPlugin_medeleg_IAM or CsrPlugin_medeleg_IAF or CsrPlugin_medeleg_II or CsrPlugin_medeleg_LAM or CsrPlugin_medeleg_LAF or CsrPlugin_medeleg_SAM or CsrPlugin_medeleg_SAF or CsrPlugin_medeleg_EU or CsrPlugin_medeleg_ES or CsrPlugin_medeleg_IPF or CsrPlugin_medeleg_LPF or CsrPlugin_medeleg_SPF) begin
		_zz_CsrPlugin_csrMapping_readDataInit_18 = 32'h00000000;
		if (execute_CsrPlugin_csr_770) begin
			_zz_CsrPlugin_csrMapping_readDataInit_18[0] = CsrPlugin_medeleg_IAM;
			_zz_CsrPlugin_csrMapping_readDataInit_18[1] = CsrPlugin_medeleg_IAF;
			_zz_CsrPlugin_csrMapping_readDataInit_18[2] = CsrPlugin_medeleg_II;
			_zz_CsrPlugin_csrMapping_readDataInit_18[4] = CsrPlugin_medeleg_LAM;
			_zz_CsrPlugin_csrMapping_readDataInit_18[5] = CsrPlugin_medeleg_LAF;
			_zz_CsrPlugin_csrMapping_readDataInit_18[6] = CsrPlugin_medeleg_SAM;
			_zz_CsrPlugin_csrMapping_readDataInit_18[7] = CsrPlugin_medeleg_SAF;
			_zz_CsrPlugin_csrMapping_readDataInit_18[8] = CsrPlugin_medeleg_EU;
			_zz_CsrPlugin_csrMapping_readDataInit_18[9] = CsrPlugin_medeleg_ES;
			_zz_CsrPlugin_csrMapping_readDataInit_18[12] = CsrPlugin_medeleg_IPF;
			_zz_CsrPlugin_csrMapping_readDataInit_18[13] = CsrPlugin_medeleg_LPF;
			_zz_CsrPlugin_csrMapping_readDataInit_18[15] = CsrPlugin_medeleg_SPF;
		end
	end
	always @(execute_CsrPlugin_csr_771 or CsrPlugin_mideleg_SE or CsrPlugin_mideleg_ST or CsrPlugin_mideleg_SS) begin
		_zz_CsrPlugin_csrMapping_readDataInit_19 = 32'h00000000;
		if (execute_CsrPlugin_csr_771) begin
			_zz_CsrPlugin_csrMapping_readDataInit_19[9] = CsrPlugin_mideleg_SE;
			_zz_CsrPlugin_csrMapping_readDataInit_19[5] = CsrPlugin_mideleg_ST;
			_zz_CsrPlugin_csrMapping_readDataInit_19[1] = CsrPlugin_mideleg_SS;
		end
	end
	always @(execute_CsrPlugin_csr_3072 or CsrPlugin_mcycle) begin
		_zz_CsrPlugin_csrMapping_readDataInit_20 = 32'h00000000;
		if (execute_CsrPlugin_csr_3072)
			_zz_CsrPlugin_csrMapping_readDataInit_20 = CsrPlugin_mcycle[31:0];
	end
	always @(execute_CsrPlugin_csr_3200 or CsrPlugin_mcycle) begin
		_zz_CsrPlugin_csrMapping_readDataInit_21 = 32'h00000000;
		if (execute_CsrPlugin_csr_3200)
			_zz_CsrPlugin_csrMapping_readDataInit_21 = CsrPlugin_mcycle[63:32];
	end
	always @(execute_CsrPlugin_csr_3074 or CsrPlugin_minstret) begin
		_zz_CsrPlugin_csrMapping_readDataInit_22 = 32'h00000000;
		if (execute_CsrPlugin_csr_3074)
			_zz_CsrPlugin_csrMapping_readDataInit_22 = CsrPlugin_minstret[31:0];
	end
	always @(execute_CsrPlugin_csr_3202 or CsrPlugin_minstret) begin
		_zz_CsrPlugin_csrMapping_readDataInit_23 = 32'h00000000;
		if (execute_CsrPlugin_csr_3202)
			_zz_CsrPlugin_csrMapping_readDataInit_23 = CsrPlugin_minstret[63:32];
	end
	always @(execute_CsrPlugin_csr_774 or CsrPlugin_mcounteren_CY or CsrPlugin_mcounteren_IR) begin
		_zz_CsrPlugin_csrMapping_readDataInit_24 = 32'h00000000;
		if (execute_CsrPlugin_csr_774) begin
			_zz_CsrPlugin_csrMapping_readDataInit_24[0] = CsrPlugin_mcounteren_CY;
			_zz_CsrPlugin_csrMapping_readDataInit_24[2] = CsrPlugin_mcounteren_IR;
		end
	end
	always @(execute_CsrPlugin_csr_262 or CsrPlugin_scounteren_CY or CsrPlugin_scounteren_IR) begin
		_zz_CsrPlugin_csrMapping_readDataInit_25 = 32'h00000000;
		if (execute_CsrPlugin_csr_262) begin
			_zz_CsrPlugin_csrMapping_readDataInit_25[0] = CsrPlugin_scounteren_CY;
			_zz_CsrPlugin_csrMapping_readDataInit_25[2] = CsrPlugin_scounteren_IR;
		end
	end
	always @(execute_CsrPlugin_csr_324 or CsrPlugin_sip_STIP or CsrPlugin_sip_SSIP or CsrPlugin_sip_SEIP_OR) begin
		_zz_CsrPlugin_csrMapping_readDataInit_26 = 32'h00000000;
		if (execute_CsrPlugin_csr_324) begin
			_zz_CsrPlugin_csrMapping_readDataInit_26[5] = CsrPlugin_sip_STIP;
			_zz_CsrPlugin_csrMapping_readDataInit_26[1] = CsrPlugin_sip_SSIP;
			_zz_CsrPlugin_csrMapping_readDataInit_26[9] = CsrPlugin_sip_SEIP_OR;
		end
	end
	always @(execute_CsrPlugin_csr_260 or CsrPlugin_sie_SEIE or CsrPlugin_sie_STIE or CsrPlugin_sie_SSIE) begin
		_zz_CsrPlugin_csrMapping_readDataInit_27 = 32'h00000000;
		if (execute_CsrPlugin_csr_260) begin
			_zz_CsrPlugin_csrMapping_readDataInit_27[9] = CsrPlugin_sie_SEIE;
			_zz_CsrPlugin_csrMapping_readDataInit_27[5] = CsrPlugin_sie_STIE;
			_zz_CsrPlugin_csrMapping_readDataInit_27[1] = CsrPlugin_sie_SSIE;
		end
	end
	always @(execute_CsrPlugin_csr_261 or CsrPlugin_stvec_base) begin
		_zz_CsrPlugin_csrMapping_readDataInit_28 = 32'h00000000;
		if (execute_CsrPlugin_csr_261)
			_zz_CsrPlugin_csrMapping_readDataInit_28[31:2] = CsrPlugin_stvec_base;
	end
	always @(execute_CsrPlugin_csr_321 or CsrPlugin_sepc) begin
		_zz_CsrPlugin_csrMapping_readDataInit_29 = 32'h00000000;
		if (execute_CsrPlugin_csr_321)
			_zz_CsrPlugin_csrMapping_readDataInit_29 = CsrPlugin_sepc;
	end
	always @(execute_CsrPlugin_csr_320 or CsrPlugin_sscratch) begin
		_zz_CsrPlugin_csrMapping_readDataInit_30 = 32'h00000000;
		if (execute_CsrPlugin_csr_320)
			_zz_CsrPlugin_csrMapping_readDataInit_30 = CsrPlugin_sscratch;
	end
	always @(execute_CsrPlugin_csr_322 or CsrPlugin_scause_interrupt or CsrPlugin_scause_exceptionCode) begin
		_zz_CsrPlugin_csrMapping_readDataInit_31 = 32'h00000000;
		if (execute_CsrPlugin_csr_322) begin
			_zz_CsrPlugin_csrMapping_readDataInit_31[31] = CsrPlugin_scause_interrupt;
			_zz_CsrPlugin_csrMapping_readDataInit_31[3:0] = CsrPlugin_scause_exceptionCode;
		end
	end
	always @(execute_CsrPlugin_csr_323 or CsrPlugin_stval) begin
		_zz_CsrPlugin_csrMapping_readDataInit_32 = 32'h00000000;
		if (execute_CsrPlugin_csr_323)
			_zz_CsrPlugin_csrMapping_readDataInit_32 = CsrPlugin_stval;
	end
	always @(CsrPlugin_csrMapping_doForceFailCsr or when_CsrPlugin_l1710) begin
		when_CsrPlugin_l1712 = CsrPlugin_csrMapping_doForceFailCsr;
		if (when_CsrPlugin_l1710)
			when_CsrPlugin_l1712 = 1'b1;
	end
	always @(posedge reset or posedge clk)
		if (reset) begin
			IBusCachedPlugin_fetchPc_pcReg <= 32'h80000000;
			IBusCachedPlugin_fetchPc_correctionReg <= 1'b0;
			IBusCachedPlugin_fetchPc_booted <= 1'b0;
			IBusCachedPlugin_fetchPc_inc <= 1'b0;
			_zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid_1 <= 1'b0;
			_zz_IBusCachedPlugin_injector_decodeInput_valid <= 1'b0;
			IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
			IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
			IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
			IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
			IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
			IBusCachedPlugin_rspCounter <= 32'h00000000;
			toplevel_dataCache_1_io_mem_cmd_rValid <= 1'b0;
			toplevel_dataCache_1_io_mem_cmd_s2mPipe_rValid <= 1'b0;
			dBus_rsp_regNext_valid <= 1'b0;
			DBusCachedPlugin_rspCounter <= 32'h00000000;
			MmuPlugin_status_sum <= 1'b0;
			MmuPlugin_status_mxr <= 1'b0;
			MmuPlugin_status_mprv <= 1'b0;
			MmuPlugin_satp_mode <= 1'b0;
			MmuPlugin_ports_0_cache_0_valid <= 1'b0;
			MmuPlugin_ports_0_cache_1_valid <= 1'b0;
			MmuPlugin_ports_0_cache_2_valid <= 1'b0;
			MmuPlugin_ports_0_cache_3_valid <= 1'b0;
			MmuPlugin_ports_0_entryToReplace_value <= 2'h0;
			MmuPlugin_ports_1_cache_0_valid <= 1'b0;
			MmuPlugin_ports_1_cache_1_valid <= 1'b0;
			MmuPlugin_ports_1_cache_2_valid <= 1'b0;
			MmuPlugin_ports_1_cache_3_valid <= 1'b0;
			MmuPlugin_ports_1_entryToReplace_value <= 2'h0;
			MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_IDLE;
			MmuPlugin_shared_dBusRspStaged_valid <= 1'b0;
			FpuPlugin_pendings <= 6'h00;
			FpuPlugin_flags_NV <= 1'b0;
			FpuPlugin_flags_DZ <= 1'b0;
			FpuPlugin_flags_OF <= 1'b0;
			FpuPlugin_flags_UF <= 1'b0;
			FpuPlugin_flags_NX <= 1'b0;
			FpuPlugin_rm <= 3'h0;
			FpuPlugin_fs <= 2'h1;
			decode_FpuPlugin_forked <= 1'b0;
			writeBack_FpuPlugin_commit_rValid <= 1'b0;
			_zz_7 <= 1'b1;
			memory_DivPlugin_div_counter_value <= 6'h00;
			HazardSimplePlugin_writeBackBuffer_valid <= 1'b0;
			_zz_CsrPlugin_privilege <= 2'h3;
			CsrPlugin_mstatus_MIE <= 1'b0;
			CsrPlugin_mstatus_MPIE <= 1'b0;
			CsrPlugin_mstatus_MPP <= 2'h3;
			CsrPlugin_mie_MEIE <= 1'b0;
			CsrPlugin_mie_MTIE <= 1'b0;
			CsrPlugin_mie_MSIE <= 1'b0;
			CsrPlugin_mcycle <= 64'h0000000000000000;
			CsrPlugin_minstret <= 64'h0000000000000000;
			CsrPlugin_medeleg_IAM <= 1'b0;
			CsrPlugin_medeleg_IAF <= 1'b0;
			CsrPlugin_medeleg_II <= 1'b0;
			CsrPlugin_medeleg_LAM <= 1'b0;
			CsrPlugin_medeleg_LAF <= 1'b0;
			CsrPlugin_medeleg_SAM <= 1'b0;
			CsrPlugin_medeleg_SAF <= 1'b0;
			CsrPlugin_medeleg_EU <= 1'b0;
			CsrPlugin_medeleg_ES <= 1'b0;
			CsrPlugin_medeleg_IPF <= 1'b0;
			CsrPlugin_medeleg_LPF <= 1'b0;
			CsrPlugin_medeleg_SPF <= 1'b0;
			CsrPlugin_mideleg_ST <= 1'b0;
			CsrPlugin_mideleg_SE <= 1'b0;
			CsrPlugin_mideleg_SS <= 1'b0;
			CsrPlugin_mcounteren_IR <= 1'b1;
			CsrPlugin_mcounteren_CY <= 1'b1;
			CsrPlugin_scounteren_IR <= 1'b1;
			CsrPlugin_scounteren_CY <= 1'b1;
			CsrPlugin_sstatus_SIE <= 1'b0;
			CsrPlugin_sstatus_SPIE <= 1'b0;
			CsrPlugin_sstatus_SPP <= 1'b1;
			CsrPlugin_sip_SEIP_SOFT <= 1'b0;
			CsrPlugin_sip_STIP <= 1'b0;
			CsrPlugin_sip_SSIP <= 1'b0;
			CsrPlugin_sie_SEIE <= 1'b0;
			CsrPlugin_sie_STIE <= 1'b0;
			CsrPlugin_sie_SSIE <= 1'b0;
			CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
			CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
			CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
			CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
			CsrPlugin_interrupt_valid <= 1'b0;
			CsrPlugin_lastStageWasWfi <= 1'b0;
			CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
			CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
			CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
			CsrPlugin_hadException <= 1'b0;
			execute_CsrPlugin_wfiWake <= 1'b0;
			execute_arbitration_isValid <= 1'b0;
			memory_arbitration_isValid <= 1'b0;
			writeBack_arbitration_isValid <= 1'b0;
			execute_to_memory_IS_DBUS_SHARING <= 1'b0;
			memory_to_writeBack_IS_DBUS_SHARING <= 1'b0;
			decode_to_execute_FPU_FORKED <= 1'b0;
			execute_to_memory_FPU_FORKED <= 1'b0;
			memory_to_writeBack_FPU_FORKED <= 1'b0;
		end
		else begin
			if (IBusCachedPlugin_fetchPc_correction)
				IBusCachedPlugin_fetchPc_correctionReg <= 1'b1;
			if (IBusCachedPlugin_fetchPc_output_fire)
				IBusCachedPlugin_fetchPc_correctionReg <= 1'b0;
			IBusCachedPlugin_fetchPc_booted <= 1'b1;
			if (when_Fetcher_l133)
				IBusCachedPlugin_fetchPc_inc <= 1'b0;
			if (IBusCachedPlugin_fetchPc_output_fire_1)
				IBusCachedPlugin_fetchPc_inc <= 1'b1;
			if (when_Fetcher_l133_1)
				IBusCachedPlugin_fetchPc_inc <= 1'b0;
			if (when_Fetcher_l160)
				IBusCachedPlugin_fetchPc_pcReg <= IBusCachedPlugin_fetchPc_pc;
			if (IBusCachedPlugin_iBusRsp_flush)
				_zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid_1 <= 1'b0;
			if (_zz_IBusCachedPlugin_iBusRsp_stages_0_output_ready)
				_zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid_1 <= IBusCachedPlugin_iBusRsp_stages_0_output_valid && 1'b1;
			if (decode_arbitration_removeIt)
				_zz_IBusCachedPlugin_injector_decodeInput_valid <= 1'b0;
			if (IBusCachedPlugin_iBusRsp_output_ready)
				_zz_IBusCachedPlugin_injector_decodeInput_valid <= IBusCachedPlugin_iBusRsp_output_valid && !IBusCachedPlugin_externalFlush;
			if (IBusCachedPlugin_fetchPc_flushed)
				IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
			if (when_Fetcher_l331)
				IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b1;
			if (IBusCachedPlugin_fetchPc_flushed)
				IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
			if (when_Fetcher_l331_1)
				IBusCachedPlugin_injector_nextPcCalc_valids_1 <= IBusCachedPlugin_injector_nextPcCalc_valids_0;
			if (IBusCachedPlugin_fetchPc_flushed)
				IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
			if (IBusCachedPlugin_fetchPc_flushed)
				IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
			if (when_Fetcher_l331_2)
				IBusCachedPlugin_injector_nextPcCalc_valids_2 <= IBusCachedPlugin_injector_nextPcCalc_valids_1;
			if (IBusCachedPlugin_fetchPc_flushed)
				IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
			if (IBusCachedPlugin_fetchPc_flushed)
				IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
			if (when_Fetcher_l331_3)
				IBusCachedPlugin_injector_nextPcCalc_valids_3 <= IBusCachedPlugin_injector_nextPcCalc_valids_2;
			if (IBusCachedPlugin_fetchPc_flushed)
				IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
			if (IBusCachedPlugin_fetchPc_flushed)
				IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
			if (when_Fetcher_l331_4)
				IBusCachedPlugin_injector_nextPcCalc_valids_4 <= IBusCachedPlugin_injector_nextPcCalc_valids_3;
			if (IBusCachedPlugin_fetchPc_flushed)
				IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
			if (iBus_rsp_valid)
				IBusCachedPlugin_rspCounter <= IBusCachedPlugin_rspCounter + 32'h00000001;
			if (dataCache_1_io_mem_cmd_valid)
				toplevel_dataCache_1_io_mem_cmd_rValid <= 1'b1;
			if (toplevel_dataCache_1_io_mem_cmd_s2mPipe_ready)
				toplevel_dataCache_1_io_mem_cmd_rValid <= 1'b0;
			if (toplevel_dataCache_1_io_mem_cmd_s2mPipe_ready)
				toplevel_dataCache_1_io_mem_cmd_s2mPipe_rValid <= toplevel_dataCache_1_io_mem_cmd_s2mPipe_valid;
			dBus_rsp_regNext_valid <= dBus_rsp_valid;
			if (dBus_rsp_valid)
				DBusCachedPlugin_rspCounter <= DBusCachedPlugin_rspCounter + 32'h00000001;
			if (CsrPlugin_xretAwayFromMachine)
				MmuPlugin_status_mprv <= 1'b0;
			MmuPlugin_ports_0_entryToReplace_value <= MmuPlugin_ports_0_entryToReplace_valueNext;
			if (contextSwitching) begin
				if (MmuPlugin_ports_0_cache_0_exception)
					MmuPlugin_ports_0_cache_0_valid <= 1'b0;
				if (MmuPlugin_ports_0_cache_1_exception)
					MmuPlugin_ports_0_cache_1_valid <= 1'b0;
				if (MmuPlugin_ports_0_cache_2_exception)
					MmuPlugin_ports_0_cache_2_valid <= 1'b0;
				if (MmuPlugin_ports_0_cache_3_exception)
					MmuPlugin_ports_0_cache_3_valid <= 1'b0;
			end
			MmuPlugin_ports_1_entryToReplace_value <= MmuPlugin_ports_1_entryToReplace_valueNext;
			if (contextSwitching) begin
				if (MmuPlugin_ports_1_cache_0_exception)
					MmuPlugin_ports_1_cache_0_valid <= 1'b0;
				if (MmuPlugin_ports_1_cache_1_exception)
					MmuPlugin_ports_1_cache_1_valid <= 1'b0;
				if (MmuPlugin_ports_1_cache_2_exception)
					MmuPlugin_ports_1_cache_2_valid <= 1'b0;
				if (MmuPlugin_ports_1_cache_3_exception)
					MmuPlugin_ports_1_cache_3_valid <= 1'b0;
			end
			MmuPlugin_shared_dBusRspStaged_valid <= MmuPlugin_dBusAccess_rsp_valid;
			case (MmuPlugin_shared_state_1)
				MmuPlugin_shared_State_IDLE:
					if (when_MmuPlugin_l223)
						MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_L1_CMD;
				MmuPlugin_shared_State_L1_CMD:
					if (MmuPlugin_dBusAccess_cmd_ready)
						MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_L1_RSP;
				MmuPlugin_shared_State_L1_RSP:
					if (MmuPlugin_shared_dBusRspStaged_valid) begin
						MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_L0_CMD;
						if (when_MmuPlugin_l250)
							MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_IDLE;
						if (MmuPlugin_shared_dBusRspStaged_payload_redo)
							MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_L1_CMD;
					end
				MmuPlugin_shared_State_L0_CMD:
					if (MmuPlugin_dBusAccess_cmd_ready)
						MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_L0_RSP;
				default:
					if (MmuPlugin_shared_dBusRspStaged_valid) begin
						MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_IDLE;
						if (MmuPlugin_shared_dBusRspStaged_payload_redo)
							MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_L0_CMD;
					end
			endcase
			if (when_MmuPlugin_l279) begin
				if (when_MmuPlugin_l281) begin
					if (when_MmuPlugin_l287)
						MmuPlugin_ports_0_cache_0_valid <= 1'b1;
					if (when_MmuPlugin_l287_1)
						MmuPlugin_ports_0_cache_1_valid <= 1'b1;
					if (when_MmuPlugin_l287_2)
						MmuPlugin_ports_0_cache_2_valid <= 1'b1;
					if (when_MmuPlugin_l287_3)
						MmuPlugin_ports_0_cache_3_valid <= 1'b1;
				end
				if (when_MmuPlugin_l281_1) begin
					if (when_MmuPlugin_l287_4)
						MmuPlugin_ports_1_cache_0_valid <= 1'b1;
					if (when_MmuPlugin_l287_5)
						MmuPlugin_ports_1_cache_1_valid <= 1'b1;
					if (when_MmuPlugin_l287_6)
						MmuPlugin_ports_1_cache_2_valid <= 1'b1;
					if (when_MmuPlugin_l287_7)
						MmuPlugin_ports_1_cache_3_valid <= 1'b1;
				end
			end
			if (when_MmuPlugin_l311) begin
				MmuPlugin_ports_0_cache_0_valid <= 1'b0;
				MmuPlugin_ports_0_cache_1_valid <= 1'b0;
				MmuPlugin_ports_0_cache_2_valid <= 1'b0;
				MmuPlugin_ports_0_cache_3_valid <= 1'b0;
				MmuPlugin_ports_1_cache_0_valid <= 1'b0;
				MmuPlugin_ports_1_cache_1_valid <= 1'b0;
				MmuPlugin_ports_1_cache_2_valid <= 1'b0;
				MmuPlugin_ports_1_cache_3_valid <= 1'b0;
			end
			FpuPlugin_pendings <= _zz_FpuPlugin_pendings - _zz_FpuPlugin_pendings_6;
			if (when_FpuPlugin_l215)
				FpuPlugin_flags_NV <= 1'b1;
			if (when_FpuPlugin_l216)
				FpuPlugin_flags_DZ <= 1'b1;
			if (when_FpuPlugin_l217)
				FpuPlugin_flags_OF <= 1'b1;
			if (when_FpuPlugin_l218)
				FpuPlugin_flags_UF <= 1'b1;
			if (when_FpuPlugin_l219)
				FpuPlugin_flags_NX <= 1'b1;
			if (when_FpuPlugin_l234)
				FpuPlugin_fs <= 2'h3;
			if (when_FpuPlugin_l237)
				FpuPlugin_fs <= 2'h3;
			if (when_FpuPlugin_l268)
				decode_FpuPlugin_forked <= 1'b1;
			if (when_FpuPlugin_l268_1)
				decode_FpuPlugin_forked <= 1'b0;
			if (writeBack_FpuPlugin_isRsp) begin
				if (writeBack_arbitration_isValid) begin
					if (when_FpuPlugin_l315) begin
						if (FpuPlugin_port_rsp_payload_NV)
							FpuPlugin_flags_NV <= 1'b1;
						if (FpuPlugin_port_rsp_payload_NX)
							FpuPlugin_flags_NX <= 1'b1;
						if (when_FpuPlugin_l318)
							FpuPlugin_fs <= 2'h3;
					end
				end
			end
			if (writeBack_FpuPlugin_commit_valid)
				writeBack_FpuPlugin_commit_rValid <= 1'b1;
			if (writeBack_FpuPlugin_commit_s2mPipe_ready)
				writeBack_FpuPlugin_commit_rValid <= 1'b0;
			_zz_7 <= 1'b0;
			memory_DivPlugin_div_counter_value <= memory_DivPlugin_div_counter_valueNext;
			HazardSimplePlugin_writeBackBuffer_valid <= HazardSimplePlugin_writeBackWrites_valid;
			CsrPlugin_mcycle <= CsrPlugin_mcycle + 64'h0000000000000001;
			if (writeBack_arbitration_isFiring)
				CsrPlugin_minstret <= CsrPlugin_minstret + 64'h0000000000000001;
			if (when_CsrPlugin_l1259)
				CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
			else
				CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
			if (when_CsrPlugin_l1259_1)
				CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_decode && !decode_arbitration_isStuck;
			else
				CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
			if (when_CsrPlugin_l1259_2)
				CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute && !execute_arbitration_isStuck;
			else
				CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
			if (when_CsrPlugin_l1259_3)
				CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory && !memory_arbitration_isStuck;
			else
				CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
			CsrPlugin_interrupt_valid <= 1'b0;
			if (when_CsrPlugin_l1296) begin
				if (when_CsrPlugin_l1302)
					CsrPlugin_interrupt_valid <= 1'b1;
				if (when_CsrPlugin_l1302_1)
					CsrPlugin_interrupt_valid <= 1'b1;
				if (when_CsrPlugin_l1302_2)
					CsrPlugin_interrupt_valid <= 1'b1;
			end
			if (when_CsrPlugin_l1296_1) begin
				if (when_CsrPlugin_l1302_3)
					CsrPlugin_interrupt_valid <= 1'b1;
				if (when_CsrPlugin_l1302_4)
					CsrPlugin_interrupt_valid <= 1'b1;
				if (when_CsrPlugin_l1302_5)
					CsrPlugin_interrupt_valid <= 1'b1;
				if (when_CsrPlugin_l1302_6)
					CsrPlugin_interrupt_valid <= 1'b1;
				if (when_CsrPlugin_l1302_7)
					CsrPlugin_interrupt_valid <= 1'b1;
				if (when_CsrPlugin_l1302_8)
					CsrPlugin_interrupt_valid <= 1'b1;
			end
			CsrPlugin_lastStageWasWfi <= writeBack_arbitration_isFiring && (writeBack_ENV_CTRL == EnvCtrlEnum_WFI);
			if (CsrPlugin_pipelineLiberator_active) begin
				if (when_CsrPlugin_l1335)
					CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b1;
				if (when_CsrPlugin_l1335_1)
					CsrPlugin_pipelineLiberator_pcValids_1 <= CsrPlugin_pipelineLiberator_pcValids_0;
				if (when_CsrPlugin_l1335_2)
					CsrPlugin_pipelineLiberator_pcValids_2 <= CsrPlugin_pipelineLiberator_pcValids_1;
			end
			if (when_CsrPlugin_l1340) begin
				CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
				CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
				CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
			end
			if (CsrPlugin_interruptJump)
				CsrPlugin_interrupt_valid <= 1'b0;
			CsrPlugin_hadException <= CsrPlugin_exception;
			if (when_CsrPlugin_l1390) begin
				if (when_CsrPlugin_l1398) begin
					_zz_CsrPlugin_privilege <= CsrPlugin_targetPrivilege;
					case (CsrPlugin_targetPrivilege)
						2'h1: begin
							CsrPlugin_sstatus_SIE <= 1'b0;
							CsrPlugin_sstatus_SPIE <= CsrPlugin_sstatus_SIE;
							CsrPlugin_sstatus_SPP <= CsrPlugin_privilege[0];
						end
						2'h3: begin
							CsrPlugin_mstatus_MIE <= 1'b0;
							CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
							CsrPlugin_mstatus_MPP <= CsrPlugin_privilege;
						end
						default:
							;
					endcase
				end
			end
			if (when_CsrPlugin_l1456)
				case (switch_CsrPlugin_l1460)
					2'h3: begin
						CsrPlugin_mstatus_MPP <= 2'h0;
						CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
						CsrPlugin_mstatus_MPIE <= 1'b1;
						_zz_CsrPlugin_privilege <= CsrPlugin_mstatus_MPP;
					end
					2'h1: begin
						CsrPlugin_sstatus_SPP <= 1'b0;
						CsrPlugin_sstatus_SIE <= CsrPlugin_sstatus_SPIE;
						CsrPlugin_sstatus_SPIE <= 1'b1;
						_zz_CsrPlugin_privilege <= {1'b0, CsrPlugin_sstatus_SPP};
					end
					default:
						;
				endcase
			execute_CsrPlugin_wfiWake <= ({_zz_when_CsrPlugin_l1302_5, _zz_when_CsrPlugin_l1302_4, _zz_when_CsrPlugin_l1302_3, _zz_when_CsrPlugin_l1302_2, _zz_when_CsrPlugin_l1302_1, _zz_when_CsrPlugin_l1302} != 6'h00) || CsrPlugin_thirdPartyWake;
			if (when_Pipeline_l124_10)
				decode_to_execute_FPU_FORKED <= _zz_decode_to_execute_FPU_FORKED;
			if (when_Pipeline_l124_11)
				execute_to_memory_FPU_FORKED <= _zz_execute_to_memory_FPU_FORKED;
			if (when_Pipeline_l124_12)
				memory_to_writeBack_FPU_FORKED <= _zz_memory_to_writeBack_FPU_FORKED;
			if (when_Pipeline_l124_70)
				execute_to_memory_IS_DBUS_SHARING <= execute_IS_DBUS_SHARING;
			if (when_Pipeline_l124_71)
				memory_to_writeBack_IS_DBUS_SHARING <= memory_IS_DBUS_SHARING;
			if (when_Pipeline_l151)
				execute_arbitration_isValid <= 1'b0;
			if (when_Pipeline_l154)
				execute_arbitration_isValid <= decode_arbitration_isValid;
			if (when_Pipeline_l151_1)
				memory_arbitration_isValid <= 1'b0;
			if (when_Pipeline_l154_1)
				memory_arbitration_isValid <= execute_arbitration_isValid;
			if (when_Pipeline_l151_2)
				writeBack_arbitration_isValid <= 1'b0;
			if (when_Pipeline_l154_2)
				writeBack_arbitration_isValid <= memory_arbitration_isValid;
			if (MmuPlugin_dBusAccess_rsp_valid)
				memory_to_writeBack_IS_DBUS_SHARING <= 1'b0;
			if (MmuPlugin_dBusAccess_rsp_valid)
				memory_to_writeBack_IS_DBUS_SHARING <= 1'b0;
			if (execute_CsrPlugin_csr_768) begin
				if (execute_CsrPlugin_writeEnable) begin
					MmuPlugin_status_mxr <= CsrPlugin_csrMapping_writeDataSignal[19];
					MmuPlugin_status_sum <= CsrPlugin_csrMapping_writeDataSignal[18];
					MmuPlugin_status_mprv <= CsrPlugin_csrMapping_writeDataSignal[17];
					FpuPlugin_fs <= CsrPlugin_csrMapping_writeDataSignal[14:13];
					CsrPlugin_mstatus_MPIE <= CsrPlugin_csrMapping_writeDataSignal[7];
					CsrPlugin_mstatus_MIE <= CsrPlugin_csrMapping_writeDataSignal[3];
					case (switch_CsrPlugin_l1031)
						2'h3: CsrPlugin_mstatus_MPP <= 2'h3;
						2'h1: CsrPlugin_mstatus_MPP <= 2'h1;
						2'h0: CsrPlugin_mstatus_MPP <= 2'h0;
						default:
							;
					endcase
					CsrPlugin_sstatus_SPP <= CsrPlugin_csrMapping_writeDataSignal[8];
					CsrPlugin_sstatus_SPIE <= CsrPlugin_csrMapping_writeDataSignal[5];
					CsrPlugin_sstatus_SIE <= CsrPlugin_csrMapping_writeDataSignal[1];
				end
			end
			if (execute_CsrPlugin_csr_256) begin
				if (execute_CsrPlugin_writeEnable) begin
					MmuPlugin_status_mxr <= CsrPlugin_csrMapping_writeDataSignal[19];
					MmuPlugin_status_sum <= CsrPlugin_csrMapping_writeDataSignal[18];
					MmuPlugin_status_mprv <= CsrPlugin_csrMapping_writeDataSignal[17];
					FpuPlugin_fs <= CsrPlugin_csrMapping_writeDataSignal[14:13];
					CsrPlugin_sstatus_SPP <= CsrPlugin_csrMapping_writeDataSignal[8];
					CsrPlugin_sstatus_SPIE <= CsrPlugin_csrMapping_writeDataSignal[5];
					CsrPlugin_sstatus_SIE <= CsrPlugin_csrMapping_writeDataSignal[1];
				end
			end
			if (execute_CsrPlugin_csr_384) begin
				if (execute_CsrPlugin_writeEnable) begin
					MmuPlugin_satp_mode <= CsrPlugin_csrMapping_writeDataSignal[31];
					MmuPlugin_ports_0_cache_0_valid <= 1'b0;
					MmuPlugin_ports_0_cache_1_valid <= 1'b0;
					MmuPlugin_ports_0_cache_2_valid <= 1'b0;
					MmuPlugin_ports_0_cache_3_valid <= 1'b0;
					MmuPlugin_ports_1_cache_0_valid <= 1'b0;
					MmuPlugin_ports_1_cache_1_valid <= 1'b0;
					MmuPlugin_ports_1_cache_2_valid <= 1'b0;
					MmuPlugin_ports_1_cache_3_valid <= 1'b0;
				end
			end
			if (execute_CsrPlugin_csr_3) begin
				if (execute_CsrPlugin_writeEnable) begin
					FpuPlugin_rm <= CsrPlugin_csrMapping_writeDataSignal[7:5];
					FpuPlugin_flags_NX <= _zz_FpuPlugin_flags_NX[0];
					FpuPlugin_flags_UF <= _zz_FpuPlugin_flags_NX[1];
					FpuPlugin_flags_OF <= _zz_FpuPlugin_flags_NX[2];
					FpuPlugin_flags_DZ <= _zz_FpuPlugin_flags_NX[3];
					FpuPlugin_flags_NV <= _zz_FpuPlugin_flags_NX[4];
				end
			end
			if (execute_CsrPlugin_csr_2) begin
				if (execute_CsrPlugin_writeEnable)
					FpuPlugin_rm <= CsrPlugin_csrMapping_writeDataSignal[2:0];
			end
			if (execute_CsrPlugin_csr_1) begin
				if (execute_CsrPlugin_writeEnable) begin
					FpuPlugin_flags_NX <= _zz_FpuPlugin_flags_NX_1[0];
					FpuPlugin_flags_UF <= _zz_FpuPlugin_flags_NX_1[1];
					FpuPlugin_flags_OF <= _zz_FpuPlugin_flags_NX_1[2];
					FpuPlugin_flags_DZ <= _zz_FpuPlugin_flags_NX_1[3];
					FpuPlugin_flags_NV <= _zz_FpuPlugin_flags_NX_1[4];
				end
			end
			if (execute_CsrPlugin_csr_836) begin
				if (execute_CsrPlugin_writeEnable) begin
					CsrPlugin_sip_STIP <= CsrPlugin_csrMapping_writeDataSignal[5];
					CsrPlugin_sip_SSIP <= CsrPlugin_csrMapping_writeDataSignal[1];
					CsrPlugin_sip_SEIP_SOFT <= CsrPlugin_csrMapping_writeDataSignal[9];
				end
			end
			if (execute_CsrPlugin_csr_772) begin
				if (execute_CsrPlugin_writeEnable) begin
					CsrPlugin_mie_MEIE <= CsrPlugin_csrMapping_writeDataSignal[11];
					CsrPlugin_mie_MTIE <= CsrPlugin_csrMapping_writeDataSignal[7];
					CsrPlugin_mie_MSIE <= CsrPlugin_csrMapping_writeDataSignal[3];
					CsrPlugin_sie_SEIE <= CsrPlugin_csrMapping_writeDataSignal[9];
					CsrPlugin_sie_STIE <= CsrPlugin_csrMapping_writeDataSignal[5];
					CsrPlugin_sie_SSIE <= CsrPlugin_csrMapping_writeDataSignal[1];
				end
			end
			if (execute_CsrPlugin_csr_2816) begin
				if (execute_CsrPlugin_writeEnable)
					CsrPlugin_mcycle[31:0] <= CsrPlugin_csrMapping_writeDataSignal;
			end
			if (execute_CsrPlugin_csr_2944) begin
				if (execute_CsrPlugin_writeEnable)
					CsrPlugin_mcycle[63:32] <= CsrPlugin_csrMapping_writeDataSignal;
			end
			if (execute_CsrPlugin_csr_2818) begin
				if (execute_CsrPlugin_writeEnable)
					CsrPlugin_minstret[31:0] <= CsrPlugin_csrMapping_writeDataSignal;
			end
			if (execute_CsrPlugin_csr_2946) begin
				if (execute_CsrPlugin_writeEnable)
					CsrPlugin_minstret[63:32] <= CsrPlugin_csrMapping_writeDataSignal;
			end
			if (execute_CsrPlugin_csr_770) begin
				if (execute_CsrPlugin_writeEnable) begin
					CsrPlugin_medeleg_IAM <= CsrPlugin_csrMapping_writeDataSignal[0];
					CsrPlugin_medeleg_IAF <= CsrPlugin_csrMapping_writeDataSignal[1];
					CsrPlugin_medeleg_II <= CsrPlugin_csrMapping_writeDataSignal[2];
					CsrPlugin_medeleg_LAM <= CsrPlugin_csrMapping_writeDataSignal[4];
					CsrPlugin_medeleg_LAF <= CsrPlugin_csrMapping_writeDataSignal[5];
					CsrPlugin_medeleg_SAM <= CsrPlugin_csrMapping_writeDataSignal[6];
					CsrPlugin_medeleg_SAF <= CsrPlugin_csrMapping_writeDataSignal[7];
					CsrPlugin_medeleg_EU <= CsrPlugin_csrMapping_writeDataSignal[8];
					CsrPlugin_medeleg_ES <= CsrPlugin_csrMapping_writeDataSignal[9];
					CsrPlugin_medeleg_IPF <= CsrPlugin_csrMapping_writeDataSignal[12];
					CsrPlugin_medeleg_LPF <= CsrPlugin_csrMapping_writeDataSignal[13];
					CsrPlugin_medeleg_SPF <= CsrPlugin_csrMapping_writeDataSignal[15];
				end
			end
			if (execute_CsrPlugin_csr_771) begin
				if (execute_CsrPlugin_writeEnable) begin
					CsrPlugin_mideleg_SE <= CsrPlugin_csrMapping_writeDataSignal[9];
					CsrPlugin_mideleg_ST <= CsrPlugin_csrMapping_writeDataSignal[5];
					CsrPlugin_mideleg_SS <= CsrPlugin_csrMapping_writeDataSignal[1];
				end
			end
			if (execute_CsrPlugin_csr_774) begin
				if (execute_CsrPlugin_writeEnable) begin
					CsrPlugin_mcounteren_CY <= CsrPlugin_csrMapping_writeDataSignal[0];
					CsrPlugin_mcounteren_IR <= CsrPlugin_csrMapping_writeDataSignal[2];
				end
			end
			if (execute_CsrPlugin_csr_262) begin
				if (execute_CsrPlugin_writeEnable) begin
					CsrPlugin_scounteren_CY <= CsrPlugin_csrMapping_writeDataSignal[0];
					CsrPlugin_scounteren_IR <= CsrPlugin_csrMapping_writeDataSignal[2];
				end
			end
			if (execute_CsrPlugin_csr_324) begin
				if (execute_CsrPlugin_writeEnable) begin
					CsrPlugin_sip_STIP <= CsrPlugin_csrMapping_writeDataSignal[5];
					CsrPlugin_sip_SSIP <= CsrPlugin_csrMapping_writeDataSignal[1];
					CsrPlugin_sip_SEIP_SOFT <= CsrPlugin_csrMapping_writeDataSignal[9];
				end
			end
			if (execute_CsrPlugin_csr_260) begin
				if (execute_CsrPlugin_writeEnable) begin
					CsrPlugin_sie_SEIE <= CsrPlugin_csrMapping_writeDataSignal[9];
					CsrPlugin_sie_STIE <= CsrPlugin_csrMapping_writeDataSignal[5];
					CsrPlugin_sie_SSIE <= CsrPlugin_csrMapping_writeDataSignal[1];
				end
			end
		end
	always @(posedge clk) begin
		if (IBusCachedPlugin_iBusRsp_output_ready) begin
			_zz_IBusCachedPlugin_injector_decodeInput_payload_pc <= IBusCachedPlugin_iBusRsp_output_payload_pc;
			_zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_error <= IBusCachedPlugin_iBusRsp_output_payload_rsp_error;
			_zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_inst <= IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
			_zz_IBusCachedPlugin_injector_decodeInput_payload_isRvc <= IBusCachedPlugin_iBusRsp_output_payload_isRvc;
		end
		if (IBusCachedPlugin_injector_decodeInput_ready)
			IBusCachedPlugin_injector_formal_rawInDecode <= IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
		if (IBusCachedPlugin_iBusRsp_stages_1_input_ready)
			IBusCachedPlugin_s1_tightlyCoupledHit <= IBusCachedPlugin_s0_tightlyCoupledHit;
		if (dataCache_1_io_mem_cmd_ready) begin
			toplevel_dataCache_1_io_mem_cmd_rData_wr <= dataCache_1_io_mem_cmd_payload_wr;
			toplevel_dataCache_1_io_mem_cmd_rData_uncached <= dataCache_1_io_mem_cmd_payload_uncached;
			toplevel_dataCache_1_io_mem_cmd_rData_address <= dataCache_1_io_mem_cmd_payload_address;
			toplevel_dataCache_1_io_mem_cmd_rData_data <= dataCache_1_io_mem_cmd_payload_data;
			toplevel_dataCache_1_io_mem_cmd_rData_mask <= dataCache_1_io_mem_cmd_payload_mask;
			toplevel_dataCache_1_io_mem_cmd_rData_size <= dataCache_1_io_mem_cmd_payload_size;
			toplevel_dataCache_1_io_mem_cmd_rData_last <= dataCache_1_io_mem_cmd_payload_last;
		end
		if (toplevel_dataCache_1_io_mem_cmd_s2mPipe_ready) begin
			toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_wr <= toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_wr;
			toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_uncached <= toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_uncached;
			toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_address <= toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_address;
			toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_data <= toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_data;
			toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_mask <= toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_mask;
			toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_size <= toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_size;
			toplevel_dataCache_1_io_mem_cmd_s2mPipe_rData_last <= toplevel_dataCache_1_io_mem_cmd_s2mPipe_payload_last;
		end
		dBus_rsp_regNext_payload_last <= dBus_rsp_payload_last;
		dBus_rsp_regNext_payload_data <= dBus_rsp_payload_data;
		dBus_rsp_regNext_payload_error <= dBus_rsp_payload_error;
		MmuPlugin_shared_dBusRspStaged_payload_data <= MmuPlugin_dBusAccess_rsp_payload_data;
		MmuPlugin_shared_dBusRspStaged_payload_error <= MmuPlugin_dBusAccess_rsp_payload_error;
		MmuPlugin_shared_dBusRspStaged_payload_redo <= MmuPlugin_dBusAccess_rsp_payload_redo;
		if (when_MmuPlugin_l211) begin
			MmuPlugin_shared_pteBuffer_V <= MmuPlugin_shared_dBusRsp_pte_V;
			MmuPlugin_shared_pteBuffer_R <= MmuPlugin_shared_dBusRsp_pte_R;
			MmuPlugin_shared_pteBuffer_W <= MmuPlugin_shared_dBusRsp_pte_W;
			MmuPlugin_shared_pteBuffer_X <= MmuPlugin_shared_dBusRsp_pte_X;
			MmuPlugin_shared_pteBuffer_U <= MmuPlugin_shared_dBusRsp_pte_U;
			MmuPlugin_shared_pteBuffer_G <= MmuPlugin_shared_dBusRsp_pte_G;
			MmuPlugin_shared_pteBuffer_A <= MmuPlugin_shared_dBusRsp_pte_A;
			MmuPlugin_shared_pteBuffer_D <= MmuPlugin_shared_dBusRsp_pte_D;
			MmuPlugin_shared_pteBuffer_RSW <= MmuPlugin_shared_dBusRsp_pte_RSW;
			MmuPlugin_shared_pteBuffer_PPN0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
			MmuPlugin_shared_pteBuffer_PPN1 <= MmuPlugin_shared_dBusRsp_pte_PPN1;
		end
		case (MmuPlugin_shared_state_1)
			MmuPlugin_shared_State_IDLE:
				if (when_MmuPlugin_l223) begin
					MmuPlugin_shared_portSortedOh <= MmuPlugin_shared_refills;
					MmuPlugin_shared_vpn_1 <= _zz_MmuPlugin_shared_vpn_0[31:22];
					MmuPlugin_shared_vpn_0 <= _zz_MmuPlugin_shared_vpn_0[21:12];
				end
			MmuPlugin_shared_State_L1_CMD:
				;
			MmuPlugin_shared_State_L1_RSP:
				;
			MmuPlugin_shared_State_L0_CMD:
				;
			default:
				;
		endcase
		if (when_MmuPlugin_l279) begin
			if (when_MmuPlugin_l281) begin
				if (when_MmuPlugin_l287) begin
					MmuPlugin_ports_0_cache_0_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h000))) || !MmuPlugin_shared_dBusRsp_pte_A;
					MmuPlugin_ports_0_cache_0_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
					MmuPlugin_ports_0_cache_0_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
					MmuPlugin_ports_0_cache_0_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
					MmuPlugin_ports_0_cache_0_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9:0];
					MmuPlugin_ports_0_cache_0_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
					MmuPlugin_ports_0_cache_0_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D;
					MmuPlugin_ports_0_cache_0_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
					MmuPlugin_ports_0_cache_0_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
					MmuPlugin_ports_0_cache_0_superPage <= MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP;
				end
				if (when_MmuPlugin_l287_1) begin
					MmuPlugin_ports_0_cache_1_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h000))) || !MmuPlugin_shared_dBusRsp_pte_A;
					MmuPlugin_ports_0_cache_1_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
					MmuPlugin_ports_0_cache_1_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
					MmuPlugin_ports_0_cache_1_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
					MmuPlugin_ports_0_cache_1_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9:0];
					MmuPlugin_ports_0_cache_1_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
					MmuPlugin_ports_0_cache_1_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D;
					MmuPlugin_ports_0_cache_1_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
					MmuPlugin_ports_0_cache_1_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
					MmuPlugin_ports_0_cache_1_superPage <= MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP;
				end
				if (when_MmuPlugin_l287_2) begin
					MmuPlugin_ports_0_cache_2_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h000))) || !MmuPlugin_shared_dBusRsp_pte_A;
					MmuPlugin_ports_0_cache_2_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
					MmuPlugin_ports_0_cache_2_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
					MmuPlugin_ports_0_cache_2_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
					MmuPlugin_ports_0_cache_2_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9:0];
					MmuPlugin_ports_0_cache_2_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
					MmuPlugin_ports_0_cache_2_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D;
					MmuPlugin_ports_0_cache_2_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
					MmuPlugin_ports_0_cache_2_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
					MmuPlugin_ports_0_cache_2_superPage <= MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP;
				end
				if (when_MmuPlugin_l287_3) begin
					MmuPlugin_ports_0_cache_3_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h000))) || !MmuPlugin_shared_dBusRsp_pte_A;
					MmuPlugin_ports_0_cache_3_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
					MmuPlugin_ports_0_cache_3_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
					MmuPlugin_ports_0_cache_3_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
					MmuPlugin_ports_0_cache_3_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9:0];
					MmuPlugin_ports_0_cache_3_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
					MmuPlugin_ports_0_cache_3_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D;
					MmuPlugin_ports_0_cache_3_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
					MmuPlugin_ports_0_cache_3_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
					MmuPlugin_ports_0_cache_3_superPage <= MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP;
				end
			end
			if (when_MmuPlugin_l281_1) begin
				if (when_MmuPlugin_l287_4) begin
					MmuPlugin_ports_1_cache_0_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h000))) || !MmuPlugin_shared_dBusRsp_pte_A;
					MmuPlugin_ports_1_cache_0_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
					MmuPlugin_ports_1_cache_0_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
					MmuPlugin_ports_1_cache_0_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
					MmuPlugin_ports_1_cache_0_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9:0];
					MmuPlugin_ports_1_cache_0_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
					MmuPlugin_ports_1_cache_0_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D;
					MmuPlugin_ports_1_cache_0_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
					MmuPlugin_ports_1_cache_0_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
					MmuPlugin_ports_1_cache_0_superPage <= MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP;
				end
				if (when_MmuPlugin_l287_5) begin
					MmuPlugin_ports_1_cache_1_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h000))) || !MmuPlugin_shared_dBusRsp_pte_A;
					MmuPlugin_ports_1_cache_1_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
					MmuPlugin_ports_1_cache_1_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
					MmuPlugin_ports_1_cache_1_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
					MmuPlugin_ports_1_cache_1_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9:0];
					MmuPlugin_ports_1_cache_1_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
					MmuPlugin_ports_1_cache_1_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D;
					MmuPlugin_ports_1_cache_1_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
					MmuPlugin_ports_1_cache_1_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
					MmuPlugin_ports_1_cache_1_superPage <= MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP;
				end
				if (when_MmuPlugin_l287_6) begin
					MmuPlugin_ports_1_cache_2_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h000))) || !MmuPlugin_shared_dBusRsp_pte_A;
					MmuPlugin_ports_1_cache_2_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
					MmuPlugin_ports_1_cache_2_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
					MmuPlugin_ports_1_cache_2_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
					MmuPlugin_ports_1_cache_2_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9:0];
					MmuPlugin_ports_1_cache_2_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
					MmuPlugin_ports_1_cache_2_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D;
					MmuPlugin_ports_1_cache_2_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
					MmuPlugin_ports_1_cache_2_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
					MmuPlugin_ports_1_cache_2_superPage <= MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP;
				end
				if (when_MmuPlugin_l287_7) begin
					MmuPlugin_ports_1_cache_3_exception <= (MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h000))) || !MmuPlugin_shared_dBusRsp_pte_A;
					MmuPlugin_ports_1_cache_3_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
					MmuPlugin_ports_1_cache_3_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
					MmuPlugin_ports_1_cache_3_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
					MmuPlugin_ports_1_cache_3_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9:0];
					MmuPlugin_ports_1_cache_3_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
					MmuPlugin_ports_1_cache_3_allowWrite <= MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D;
					MmuPlugin_ports_1_cache_3_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
					MmuPlugin_ports_1_cache_3_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
					MmuPlugin_ports_1_cache_3_superPage <= MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP;
				end
			end
		end
		if (writeBack_FpuPlugin_commit_ready) begin
			writeBack_FpuPlugin_commit_rData_opcode <= writeBack_FpuPlugin_commit_payload_opcode;
			writeBack_FpuPlugin_commit_rData_rd <= writeBack_FpuPlugin_commit_payload_rd;
			writeBack_FpuPlugin_commit_rData_write <= writeBack_FpuPlugin_commit_payload_write;
			writeBack_FpuPlugin_commit_rData_value <= writeBack_FpuPlugin_commit_payload_value;
		end
		if (when_MulDivIterativePlugin_l126)
			memory_DivPlugin_div_done <= 1'b1;
		if (when_MulDivIterativePlugin_l126_1)
			memory_DivPlugin_div_done <= 1'b0;
		if (when_MulDivIterativePlugin_l128) begin
			if (when_MulDivIterativePlugin_l132) begin
				memory_DivPlugin_rs1[31:0] <= memory_DivPlugin_div_stage_0_outNumerator;
				memory_DivPlugin_accumulator[31:0] <= memory_DivPlugin_div_stage_0_outRemainder;
				if (when_MulDivIterativePlugin_l151)
					memory_DivPlugin_div_result <= _zz_memory_DivPlugin_div_result_1[31:0];
			end
		end
		if (when_MulDivIterativePlugin_l162) begin
			memory_DivPlugin_accumulator <= 65'h00000000000000000;
			memory_DivPlugin_rs1 <= (_zz_memory_DivPlugin_rs1 ? ~_zz_memory_DivPlugin_rs1_1 : _zz_memory_DivPlugin_rs1_1) + _zz_memory_DivPlugin_rs1_2;
			memory_DivPlugin_rs2 <= (_zz_memory_DivPlugin_rs2 ? ~execute_RS2 : execute_RS2) + _zz_memory_DivPlugin_rs2_1;
			memory_DivPlugin_div_needRevert <= (_zz_memory_DivPlugin_rs1 ^ (_zz_memory_DivPlugin_rs2 && !execute_INSTRUCTION[13])) && !(((execute_RS2 == 32'h00000000) && execute_IS_RS2_SIGNED) && !execute_INSTRUCTION[13]);
		end
		HazardSimplePlugin_writeBackBuffer_payload_address <= HazardSimplePlugin_writeBackWrites_payload_address;
		HazardSimplePlugin_writeBackBuffer_payload_data <= HazardSimplePlugin_writeBackWrites_payload_data;
		CsrPlugin_mip_MEIP <= externalInterrupt;
		CsrPlugin_mip_MTIP <= timerInterrupt;
		CsrPlugin_mip_MSIP <= softwareInterrupt;
		CsrPlugin_sip_SEIP_INPUT <= externalInterruptS;
		if (_zz_when) begin
			CsrPlugin_exceptionPortCtrl_exceptionContext_code <= (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 ? IBusCachedPlugin_decodeExceptionPort_payload_code : decodeExceptionPort_payload_code);
			CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 ? IBusCachedPlugin_decodeExceptionPort_payload_badAddr : decodeExceptionPort_payload_badAddr);
		end
		if (CsrPlugin_selfException_valid) begin
			CsrPlugin_exceptionPortCtrl_exceptionContext_code <= CsrPlugin_selfException_payload_code;
			CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= CsrPlugin_selfException_payload_badAddr;
		end
		if (BranchPlugin_branchExceptionPort_valid) begin
			CsrPlugin_exceptionPortCtrl_exceptionContext_code <= BranchPlugin_branchExceptionPort_payload_code;
			CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= BranchPlugin_branchExceptionPort_payload_badAddr;
		end
		if (DBusCachedPlugin_exceptionBus_valid) begin
			CsrPlugin_exceptionPortCtrl_exceptionContext_code <= DBusCachedPlugin_exceptionBus_payload_code;
			CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= DBusCachedPlugin_exceptionBus_payload_badAddr;
		end
		if (when_CsrPlugin_l1296) begin
			if (when_CsrPlugin_l1302) begin
				CsrPlugin_interrupt_code <= 4'h5;
				CsrPlugin_interrupt_targetPrivilege <= 2'h1;
			end
			if (when_CsrPlugin_l1302_1) begin
				CsrPlugin_interrupt_code <= 4'h1;
				CsrPlugin_interrupt_targetPrivilege <= 2'h1;
			end
			if (when_CsrPlugin_l1302_2) begin
				CsrPlugin_interrupt_code <= 4'h9;
				CsrPlugin_interrupt_targetPrivilege <= 2'h1;
			end
		end
		if (when_CsrPlugin_l1296_1) begin
			if (when_CsrPlugin_l1302_3) begin
				CsrPlugin_interrupt_code <= 4'h5;
				CsrPlugin_interrupt_targetPrivilege <= 2'h3;
			end
			if (when_CsrPlugin_l1302_4) begin
				CsrPlugin_interrupt_code <= 4'h1;
				CsrPlugin_interrupt_targetPrivilege <= 2'h3;
			end
			if (when_CsrPlugin_l1302_5) begin
				CsrPlugin_interrupt_code <= 4'h9;
				CsrPlugin_interrupt_targetPrivilege <= 2'h3;
			end
			if (when_CsrPlugin_l1302_6) begin
				CsrPlugin_interrupt_code <= 4'h7;
				CsrPlugin_interrupt_targetPrivilege <= 2'h3;
			end
			if (when_CsrPlugin_l1302_7) begin
				CsrPlugin_interrupt_code <= 4'h3;
				CsrPlugin_interrupt_targetPrivilege <= 2'h3;
			end
			if (when_CsrPlugin_l1302_8) begin
				CsrPlugin_interrupt_code <= 4'hb;
				CsrPlugin_interrupt_targetPrivilege <= 2'h3;
			end
		end
		if (when_CsrPlugin_l1390) begin
			if (when_CsrPlugin_l1398)
				case (CsrPlugin_targetPrivilege)
					2'h1: begin
						CsrPlugin_scause_interrupt <= !CsrPlugin_hadException;
						CsrPlugin_scause_exceptionCode <= CsrPlugin_trapCause;
						CsrPlugin_sepc <= writeBack_PC;
						if (CsrPlugin_hadException)
							CsrPlugin_stval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
					end
					2'h3: begin
						CsrPlugin_mcause_interrupt <= !CsrPlugin_hadException;
						CsrPlugin_mcause_exceptionCode <= CsrPlugin_trapCause;
						CsrPlugin_mepc <= writeBack_PC;
						if (CsrPlugin_hadException)
							CsrPlugin_mtval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
					end
					default:
						;
				endcase
		end
		if (when_Pipeline_l124)
			decode_to_execute_PC <= decode_PC;
		if (when_Pipeline_l124_1)
			execute_to_memory_PC <= _zz_execute_to_memory_PC;
		if (when_Pipeline_l124_2)
			memory_to_writeBack_PC <= memory_PC;
		if (when_Pipeline_l124_3)
			decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
		if (when_Pipeline_l124_4)
			execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
		if (when_Pipeline_l124_5)
			memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
		if (when_Pipeline_l124_6)
			decode_to_execute_FORMAL_PC_NEXT <= _zz_decode_to_execute_FORMAL_PC_NEXT;
		if (when_Pipeline_l124_7)
			execute_to_memory_FORMAL_PC_NEXT <= _zz_execute_to_memory_FORMAL_PC_NEXT;
		if (when_Pipeline_l124_8)
			memory_to_writeBack_FORMAL_PC_NEXT <= _zz_memory_to_writeBack_FORMAL_PC_NEXT;
		if (when_Pipeline_l124_9)
			decode_to_execute_MEMORY_FORCE_CONSTISTENCY <= decode_MEMORY_FORCE_CONSTISTENCY;
		if (when_Pipeline_l124_13)
			decode_to_execute_FPU_COMMIT_LOAD <= decode_FPU_COMMIT_LOAD;
		if (when_Pipeline_l124_14)
			execute_to_memory_FPU_COMMIT_LOAD <= execute_FPU_COMMIT_LOAD;
		if (when_Pipeline_l124_15)
			memory_to_writeBack_FPU_COMMIT_LOAD <= memory_FPU_COMMIT_LOAD;
		if (when_Pipeline_l124_16)
			decode_to_execute_RESCHEDULE_NEXT <= decode_RESCHEDULE_NEXT;
		if (when_Pipeline_l124_17)
			decode_to_execute_SRC1_CTRL <= _zz_decode_to_execute_SRC1_CTRL;
		if (when_Pipeline_l124_18)
			decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
		if (when_Pipeline_l124_19)
			decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
		if (when_Pipeline_l124_20)
			execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
		if (when_Pipeline_l124_21)
			memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
		if (when_Pipeline_l124_22)
			decode_to_execute_ALU_CTRL <= _zz_decode_to_execute_ALU_CTRL;
		if (when_Pipeline_l124_23)
			decode_to_execute_SRC2_CTRL <= _zz_decode_to_execute_SRC2_CTRL;
		if (when_Pipeline_l124_24)
			decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
		if (when_Pipeline_l124_25)
			execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
		if (when_Pipeline_l124_26)
			memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
		if (when_Pipeline_l124_27)
			decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
		if (when_Pipeline_l124_28)
			decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
		if (when_Pipeline_l124_29)
			execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
		if (when_Pipeline_l124_30)
			decode_to_execute_MEMORY_WR <= decode_MEMORY_WR;
		if (when_Pipeline_l124_31)
			execute_to_memory_MEMORY_WR <= execute_MEMORY_WR;
		if (when_Pipeline_l124_32)
			memory_to_writeBack_MEMORY_WR <= memory_MEMORY_WR;
		if (when_Pipeline_l124_33)
			decode_to_execute_MEMORY_MANAGMENT <= decode_MEMORY_MANAGMENT;
		if (when_Pipeline_l124_34)
			decode_to_execute_IS_SFENCE_VMA2 <= decode_IS_SFENCE_VMA2;
		if (when_Pipeline_l124_35)
			decode_to_execute_FPU_COMMIT <= decode_FPU_COMMIT;
		if (when_Pipeline_l124_36)
			execute_to_memory_FPU_COMMIT <= execute_FPU_COMMIT;
		if (when_Pipeline_l124_37)
			memory_to_writeBack_FPU_COMMIT <= memory_FPU_COMMIT;
		if (when_Pipeline_l124_38)
			decode_to_execute_FPU_RSP <= decode_FPU_RSP;
		if (when_Pipeline_l124_39)
			execute_to_memory_FPU_RSP <= execute_FPU_RSP;
		if (when_Pipeline_l124_40)
			memory_to_writeBack_FPU_RSP <= memory_FPU_RSP;
		if (when_Pipeline_l124_41)
			decode_to_execute_FPU_OPCODE <= _zz_decode_to_execute_FPU_OPCODE;
		if (when_Pipeline_l124_42)
			execute_to_memory_FPU_OPCODE <= _zz_execute_to_memory_FPU_OPCODE;
		if (when_Pipeline_l124_43)
			memory_to_writeBack_FPU_OPCODE <= _zz_memory_to_writeBack_FPU_OPCODE;
		if (when_Pipeline_l124_44)
			decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
		if (when_Pipeline_l124_45)
			decode_to_execute_ALU_BITWISE_CTRL <= _zz_decode_to_execute_ALU_BITWISE_CTRL;
		if (when_Pipeline_l124_46)
			decode_to_execute_SHIFT_CTRL <= _zz_decode_to_execute_SHIFT_CTRL;
		if (when_Pipeline_l124_47)
			execute_to_memory_SHIFT_CTRL <= _zz_execute_to_memory_SHIFT_CTRL;
		if (when_Pipeline_l124_48)
			decode_to_execute_IS_MUL <= decode_IS_MUL;
		if (when_Pipeline_l124_49)
			execute_to_memory_IS_MUL <= execute_IS_MUL;
		if (when_Pipeline_l124_50)
			memory_to_writeBack_IS_MUL <= memory_IS_MUL;
		if (when_Pipeline_l124_51)
			decode_to_execute_IS_DIV <= decode_IS_DIV;
		if (when_Pipeline_l124_52)
			execute_to_memory_IS_DIV <= execute_IS_DIV;
		if (when_Pipeline_l124_53)
			decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
		if (when_Pipeline_l124_54)
			decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
		if (when_Pipeline_l124_55)
			decode_to_execute_BRANCH_CTRL <= _zz_decode_to_execute_BRANCH_CTRL;
		if (when_Pipeline_l124_56)
			decode_to_execute_IS_CSR <= decode_IS_CSR;
		if (when_Pipeline_l124_57)
			decode_to_execute_ENV_CTRL <= _zz_decode_to_execute_ENV_CTRL;
		if (when_Pipeline_l124_58)
			execute_to_memory_ENV_CTRL <= _zz_execute_to_memory_ENV_CTRL;
		if (when_Pipeline_l124_59)
			memory_to_writeBack_ENV_CTRL <= _zz_memory_to_writeBack_ENV_CTRL;
		if (when_Pipeline_l124_60)
			decode_to_execute_RS1 <= decode_RS1;
		if (when_Pipeline_l124_61)
			execute_to_memory_RS1 <= _zz_execute_to_memory_RS1;
		if (when_Pipeline_l124_62)
			memory_to_writeBack_RS1 <= memory_RS1;
		if (when_Pipeline_l124_63)
			decode_to_execute_RS2 <= decode_RS2;
		if (when_Pipeline_l124_64)
			decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO;
		if (when_Pipeline_l124_65)
			decode_to_execute_PREDICTION_HAD_BRANCHED2 <= decode_PREDICTION_HAD_BRANCHED2;
		if (when_Pipeline_l124_66)
			decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
		if (when_Pipeline_l124_67)
			decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
		if (when_Pipeline_l124_68)
			execute_to_memory_MEMORY_STORE_DATA_RF <= execute_MEMORY_STORE_DATA_RF;
		if (when_Pipeline_l124_69)
			memory_to_writeBack_MEMORY_STORE_DATA_RF <= memory_MEMORY_STORE_DATA_RF;
		if (when_Pipeline_l124_72)
			execute_to_memory_REGFILE_WRITE_DATA <= _zz_decode_RS2;
		if (when_Pipeline_l124_73)
			memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_decode_RS2_1;
		if (when_Pipeline_l124_74)
			execute_to_memory_SHIFT_RIGHT <= execute_SHIFT_RIGHT;
		if (when_Pipeline_l124_75)
			execute_to_memory_MUL_LL <= execute_MUL_LL;
		if (when_Pipeline_l124_76)
			execute_to_memory_MUL_LH <= execute_MUL_LH;
		if (when_Pipeline_l124_77)
			execute_to_memory_MUL_HL <= execute_MUL_HL;
		if (when_Pipeline_l124_78)
			execute_to_memory_MUL_HH <= execute_MUL_HH;
		if (when_Pipeline_l124_79)
			memory_to_writeBack_MUL_HH <= memory_MUL_HH;
		if (when_Pipeline_l124_80)
			execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
		if (when_Pipeline_l124_81)
			execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
		if (when_Pipeline_l124_82)
			memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
		if (when_CsrPlugin_l1669)
			execute_CsrPlugin_csr_768 <= decode_INSTRUCTION[31:20] == 12'h300;
		if (when_CsrPlugin_l1669_1)
			execute_CsrPlugin_csr_256 <= decode_INSTRUCTION[31:20] == 12'h100;
		if (when_CsrPlugin_l1669_2)
			execute_CsrPlugin_csr_384 <= decode_INSTRUCTION[31:20] == 12'h180;
		if (when_CsrPlugin_l1669_3)
			execute_CsrPlugin_csr_3 <= decode_INSTRUCTION[31:20] == 12'h003;
		if (when_CsrPlugin_l1669_4)
			execute_CsrPlugin_csr_2 <= decode_INSTRUCTION[31:20] == 12'h002;
		if (when_CsrPlugin_l1669_5)
			execute_CsrPlugin_csr_1 <= decode_INSTRUCTION[31:20] == 12'h001;
		if (when_CsrPlugin_l1669_6)
			execute_CsrPlugin_csr_3857 <= decode_INSTRUCTION[31:20] == 12'hf11;
		if (when_CsrPlugin_l1669_7)
			execute_CsrPlugin_csr_3858 <= decode_INSTRUCTION[31:20] == 12'hf12;
		if (when_CsrPlugin_l1669_8)
			execute_CsrPlugin_csr_3859 <= decode_INSTRUCTION[31:20] == 12'hf13;
		if (when_CsrPlugin_l1669_9)
			execute_CsrPlugin_csr_3860 <= decode_INSTRUCTION[31:20] == 12'hf14;
		if (when_CsrPlugin_l1669_10)
			execute_CsrPlugin_csr_769 <= decode_INSTRUCTION[31:20] == 12'h301;
		if (when_CsrPlugin_l1669_11)
			execute_CsrPlugin_csr_836 <= decode_INSTRUCTION[31:20] == 12'h344;
		if (when_CsrPlugin_l1669_12)
			execute_CsrPlugin_csr_772 <= decode_INSTRUCTION[31:20] == 12'h304;
		if (when_CsrPlugin_l1669_13)
			execute_CsrPlugin_csr_773 <= decode_INSTRUCTION[31:20] == 12'h305;
		if (when_CsrPlugin_l1669_14)
			execute_CsrPlugin_csr_833 <= decode_INSTRUCTION[31:20] == 12'h341;
		if (when_CsrPlugin_l1669_15)
			execute_CsrPlugin_csr_832 <= decode_INSTRUCTION[31:20] == 12'h340;
		if (when_CsrPlugin_l1669_16)
			execute_CsrPlugin_csr_834 <= decode_INSTRUCTION[31:20] == 12'h342;
		if (when_CsrPlugin_l1669_17)
			execute_CsrPlugin_csr_835 <= decode_INSTRUCTION[31:20] == 12'h343;
		if (when_CsrPlugin_l1669_18)
			execute_CsrPlugin_csr_2816 <= decode_INSTRUCTION[31:20] == 12'hb00;
		if (when_CsrPlugin_l1669_19)
			execute_CsrPlugin_csr_2944 <= decode_INSTRUCTION[31:20] == 12'hb80;
		if (when_CsrPlugin_l1669_20)
			execute_CsrPlugin_csr_2818 <= decode_INSTRUCTION[31:20] == 12'hb02;
		if (when_CsrPlugin_l1669_21)
			execute_CsrPlugin_csr_2946 <= decode_INSTRUCTION[31:20] == 12'hb82;
		if (when_CsrPlugin_l1669_22)
			execute_CsrPlugin_csr_770 <= decode_INSTRUCTION[31:20] == 12'h302;
		if (when_CsrPlugin_l1669_23)
			execute_CsrPlugin_csr_771 <= decode_INSTRUCTION[31:20] == 12'h303;
		if (when_CsrPlugin_l1669_24)
			execute_CsrPlugin_csr_3072 <= decode_INSTRUCTION[31:20] == 12'hc00;
		if (when_CsrPlugin_l1669_25)
			execute_CsrPlugin_csr_3200 <= decode_INSTRUCTION[31:20] == 12'hc80;
		if (when_CsrPlugin_l1669_26)
			execute_CsrPlugin_csr_3074 <= decode_INSTRUCTION[31:20] == 12'hc02;
		if (when_CsrPlugin_l1669_27)
			execute_CsrPlugin_csr_3202 <= decode_INSTRUCTION[31:20] == 12'hc82;
		if (when_CsrPlugin_l1669_28)
			execute_CsrPlugin_csr_774 <= decode_INSTRUCTION[31:20] == 12'h306;
		if (when_CsrPlugin_l1669_29)
			execute_CsrPlugin_csr_262 <= decode_INSTRUCTION[31:20] == 12'h106;
		if (when_CsrPlugin_l1669_30)
			execute_CsrPlugin_csr_324 <= decode_INSTRUCTION[31:20] == 12'h144;
		if (when_CsrPlugin_l1669_31)
			execute_CsrPlugin_csr_260 <= decode_INSTRUCTION[31:20] == 12'h104;
		if (when_CsrPlugin_l1669_32)
			execute_CsrPlugin_csr_261 <= decode_INSTRUCTION[31:20] == 12'h105;
		if (when_CsrPlugin_l1669_33)
			execute_CsrPlugin_csr_321 <= decode_INSTRUCTION[31:20] == 12'h141;
		if (when_CsrPlugin_l1669_34)
			execute_CsrPlugin_csr_320 <= decode_INSTRUCTION[31:20] == 12'h140;
		if (when_CsrPlugin_l1669_35)
			execute_CsrPlugin_csr_322 <= decode_INSTRUCTION[31:20] == 12'h142;
		if (when_CsrPlugin_l1669_36)
			execute_CsrPlugin_csr_323 <= decode_INSTRUCTION[31:20] == 12'h143;
		if (execute_CsrPlugin_csr_384) begin
			if (execute_CsrPlugin_writeEnable) begin
				MmuPlugin_satp_asid <= CsrPlugin_csrMapping_writeDataSignal[30:22];
				MmuPlugin_satp_ppn <= CsrPlugin_csrMapping_writeDataSignal[21:0];
				CsrPlugin_satp_MODE <= CsrPlugin_csrMapping_writeDataSignal[31];
				CsrPlugin_satp_ASID <= CsrPlugin_csrMapping_writeDataSignal[30:22];
				CsrPlugin_satp_PPN <= CsrPlugin_csrMapping_writeDataSignal[21:0];
			end
		end
		if (execute_CsrPlugin_csr_836) begin
			if (execute_CsrPlugin_writeEnable)
				CsrPlugin_mip_MSIP <= CsrPlugin_csrMapping_writeDataSignal[3];
		end
		if (execute_CsrPlugin_csr_773) begin
			if (execute_CsrPlugin_writeEnable)
				CsrPlugin_mtvec_base <= CsrPlugin_csrMapping_writeDataSignal[31:2];
		end
		if (execute_CsrPlugin_csr_833) begin
			if (execute_CsrPlugin_writeEnable)
				CsrPlugin_mepc <= CsrPlugin_csrMapping_writeDataSignal;
		end
		if (execute_CsrPlugin_csr_832) begin
			if (execute_CsrPlugin_writeEnable)
				CsrPlugin_mscratch <= CsrPlugin_csrMapping_writeDataSignal;
		end
		if (execute_CsrPlugin_csr_834) begin
			if (execute_CsrPlugin_writeEnable) begin
				CsrPlugin_mcause_interrupt <= CsrPlugin_csrMapping_writeDataSignal[31];
				CsrPlugin_mcause_exceptionCode <= CsrPlugin_csrMapping_writeDataSignal[3:0];
			end
		end
		if (execute_CsrPlugin_csr_835) begin
			if (execute_CsrPlugin_writeEnable)
				CsrPlugin_mtval <= CsrPlugin_csrMapping_writeDataSignal;
		end
		if (execute_CsrPlugin_csr_261) begin
			if (execute_CsrPlugin_writeEnable)
				CsrPlugin_stvec_base <= CsrPlugin_csrMapping_writeDataSignal[31:2];
		end
		if (execute_CsrPlugin_csr_321) begin
			if (execute_CsrPlugin_writeEnable)
				CsrPlugin_sepc <= CsrPlugin_csrMapping_writeDataSignal;
		end
		if (execute_CsrPlugin_csr_320) begin
			if (execute_CsrPlugin_writeEnable)
				CsrPlugin_sscratch <= CsrPlugin_csrMapping_writeDataSignal;
		end
		if (execute_CsrPlugin_csr_322) begin
			if (execute_CsrPlugin_writeEnable) begin
				CsrPlugin_scause_interrupt <= CsrPlugin_csrMapping_writeDataSignal[31];
				CsrPlugin_scause_exceptionCode <= CsrPlugin_csrMapping_writeDataSignal[3:0];
			end
		end
		if (execute_CsrPlugin_csr_323) begin
			if (execute_CsrPlugin_writeEnable)
				CsrPlugin_stval <= CsrPlugin_csrMapping_writeDataSignal;
		end
	end
	FpuCore_VexRiscv_FpuPlugin_fpu  FpuPlugin_fpu(
		.io_port_0_cmd_valid(FpuPlugin_port_cmd_valid),
		.io_port_0_cmd_ready(FpuPlugin_fpu_io_port_0_cmd_ready),
		.io_port_0_cmd_payload_opcode(FpuPlugin_port_cmd_payload_opcode),
		.io_port_0_cmd_payload_arg(FpuPlugin_port_cmd_payload_arg),
		.io_port_0_cmd_payload_rs1(FpuPlugin_port_cmd_payload_rs1),
		.io_port_0_cmd_payload_rs2(FpuPlugin_port_cmd_payload_rs2),
		.io_port_0_cmd_payload_rs3(FpuPlugin_port_cmd_payload_rs3),
		.io_port_0_cmd_payload_rd(FpuPlugin_port_cmd_payload_rd),
		.io_port_0_cmd_payload_format(FpuPlugin_port_cmd_payload_format),
		.io_port_0_cmd_payload_roundMode(FpuPlugin_port_cmd_payload_roundMode),
		.io_port_0_commit_valid(FpuPlugin_port_commit_valid),
		.io_port_0_commit_ready(FpuPlugin_fpu_io_port_0_commit_ready),
		.io_port_0_commit_payload_opcode(FpuPlugin_port_commit_payload_opcode),
		.io_port_0_commit_payload_rd(FpuPlugin_port_commit_payload_rd),
		.io_port_0_commit_payload_write(FpuPlugin_port_commit_payload_write),
		.io_port_0_commit_payload_value(FpuPlugin_port_commit_payload_value),
		.io_port_0_rsp_valid(FpuPlugin_fpu_io_port_0_rsp_valid),
		.io_port_0_rsp_ready(FpuPlugin_port_rsp_ready),
		.io_port_0_rsp_payload_value(FpuPlugin_fpu_io_port_0_rsp_payload_value),
		.io_port_0_rsp_payload_NV(FpuPlugin_fpu_io_port_0_rsp_payload_NV),
		.io_port_0_rsp_payload_NX(FpuPlugin_fpu_io_port_0_rsp_payload_NX),
		.io_port_0_completion_valid(FpuPlugin_fpu_io_port_0_completion_valid),
		.io_port_0_completion_payload_flags_NX(FpuPlugin_fpu_io_port_0_completion_payload_flags_NX),
		.io_port_0_completion_payload_flags_UF(FpuPlugin_fpu_io_port_0_completion_payload_flags_UF),
		.io_port_0_completion_payload_flags_OF(FpuPlugin_fpu_io_port_0_completion_payload_flags_OF),
		.io_port_0_completion_payload_flags_DZ(FpuPlugin_fpu_io_port_0_completion_payload_flags_DZ),
		.io_port_0_completion_payload_flags_NV(FpuPlugin_fpu_io_port_0_completion_payload_flags_NV),
		.io_port_0_completion_payload_written(FpuPlugin_fpu_io_port_0_completion_payload_written),
		.clk(clk),
		.reset(reset)
	);
	InstructionCache IBusCachedPlugin_cache(
		.io_flush(IBusCachedPlugin_cache_io_flush),
		.io_cpu_prefetch_isValid(IBusCachedPlugin_cache_io_cpu_prefetch_isValid),
		.io_cpu_prefetch_haltIt(IBusCachedPlugin_cache_io_cpu_prefetch_haltIt),
		.io_cpu_prefetch_pc(IBusCachedPlugin_iBusRsp_stages_0_input_payload),
		.io_cpu_fetch_isValid(IBusCachedPlugin_cache_io_cpu_fetch_isValid),
		.io_cpu_fetch_isStuck(IBusCachedPlugin_cache_io_cpu_fetch_isStuck),
		.io_cpu_fetch_isRemoved(IBusCachedPlugin_cache_io_cpu_fetch_isRemoved),
		.io_cpu_fetch_pc(IBusCachedPlugin_iBusRsp_stages_1_input_payload),
		.io_cpu_fetch_data(IBusCachedPlugin_cache_io_cpu_fetch_data),
		.io_cpu_fetch_mmuRsp_physicalAddress(IBusCachedPlugin_mmuBus_rsp_physicalAddress),
		.io_cpu_fetch_mmuRsp_isIoAccess(IBusCachedPlugin_mmuBus_rsp_isIoAccess),
		.io_cpu_fetch_mmuRsp_isPaging(IBusCachedPlugin_mmuBus_rsp_isPaging),
		.io_cpu_fetch_mmuRsp_allowRead(IBusCachedPlugin_mmuBus_rsp_allowRead),
		.io_cpu_fetch_mmuRsp_allowWrite(IBusCachedPlugin_mmuBus_rsp_allowWrite),
		.io_cpu_fetch_mmuRsp_allowExecute(IBusCachedPlugin_mmuBus_rsp_allowExecute),
		.io_cpu_fetch_mmuRsp_exception(IBusCachedPlugin_mmuBus_rsp_exception),
		.io_cpu_fetch_mmuRsp_refilling(IBusCachedPlugin_mmuBus_rsp_refilling),
		.io_cpu_fetch_mmuRsp_bypassTranslation(IBusCachedPlugin_mmuBus_rsp_bypassTranslation),
		.io_cpu_fetch_mmuRsp_ways_0_sel(IBusCachedPlugin_mmuBus_rsp_ways_0_sel),
		.io_cpu_fetch_mmuRsp_ways_0_physical(IBusCachedPlugin_mmuBus_rsp_ways_0_physical),
		.io_cpu_fetch_mmuRsp_ways_1_sel(IBusCachedPlugin_mmuBus_rsp_ways_1_sel),
		.io_cpu_fetch_mmuRsp_ways_1_physical(IBusCachedPlugin_mmuBus_rsp_ways_1_physical),
		.io_cpu_fetch_mmuRsp_ways_2_sel(IBusCachedPlugin_mmuBus_rsp_ways_2_sel),
		.io_cpu_fetch_mmuRsp_ways_2_physical(IBusCachedPlugin_mmuBus_rsp_ways_2_physical),
		.io_cpu_fetch_mmuRsp_ways_3_sel(IBusCachedPlugin_mmuBus_rsp_ways_3_sel),
		.io_cpu_fetch_mmuRsp_ways_3_physical(IBusCachedPlugin_mmuBus_rsp_ways_3_physical),
		.io_cpu_fetch_physicalAddress(IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress),
		.io_cpu_fetch_cacheMiss(IBusCachedPlugin_cache_io_cpu_fetch_cacheMiss),
		.io_cpu_fetch_error(IBusCachedPlugin_cache_io_cpu_fetch_error),
		.io_cpu_fetch_mmuRefilling(IBusCachedPlugin_cache_io_cpu_fetch_mmuRefilling),
		.io_cpu_fetch_mmuException(IBusCachedPlugin_cache_io_cpu_fetch_mmuException),
		.io_cpu_fetch_isUser(IBusCachedPlugin_cache_io_cpu_fetch_isUser),
		.io_cpu_decode_isValid(IBusCachedPlugin_cache_io_cpu_decode_isValid),
		.io_cpu_decode_isStuck(IBusCachedPlugin_cache_io_cpu_decode_isStuck),
		.io_cpu_decode_pc(IBusCachedPlugin_cache_io_cpu_decode_pc),
		.io_cpu_decode_physicalAddress(IBusCachedPlugin_cache_io_cpu_decode_physicalAddress),
		.io_cpu_decode_data(IBusCachedPlugin_cache_io_cpu_decode_data),
		.io_cpu_fill_valid(IBusCachedPlugin_cache_io_cpu_fill_valid),
		.io_cpu_fill_payload(IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress),
		.io_mem_cmd_valid(IBusCachedPlugin_cache_io_mem_cmd_valid),
		.io_mem_cmd_ready(iBus_cmd_ready),
		.io_mem_cmd_payload_address(IBusCachedPlugin_cache_io_mem_cmd_payload_address),
		.io_mem_cmd_payload_size(IBusCachedPlugin_cache_io_mem_cmd_payload_size),
		.io_mem_rsp_valid(iBus_rsp_valid),
		.io_mem_rsp_payload_data(iBus_rsp_payload_data),
		.io_mem_rsp_payload_error(iBus_rsp_payload_error),
		.clk(clk),
		.reset(reset)
	);
	DataCache dataCache_1(
		.io_cpu_execute_isValid(dataCache_1_io_cpu_execute_isValid),
		.io_cpu_execute_address(dataCache_1_io_cpu_execute_address),
		.io_cpu_execute_haltIt(dataCache_1_io_cpu_execute_haltIt),
		.io_cpu_execute_args_wr(dataCache_1_io_cpu_execute_args_wr),
		.io_cpu_execute_args_size(dataCache_1_io_cpu_execute_args_size),
		.io_cpu_execute_args_totalyConsistent(execute_MEMORY_FORCE_CONSTISTENCY),
		.io_cpu_execute_refilling(dataCache_1_io_cpu_execute_refilling),
		.io_cpu_memory_isValid(dataCache_1_io_cpu_memory_isValid),
		.io_cpu_memory_isStuck(memory_arbitration_isStuck),
		.io_cpu_memory_isWrite(dataCache_1_io_cpu_memory_isWrite),
		.io_cpu_memory_address(dataCache_1_io_cpu_memory_address),
		.io_cpu_memory_mmuRsp_physicalAddress(DBusCachedPlugin_mmuBus_rsp_physicalAddress),
		.io_cpu_memory_mmuRsp_isIoAccess(dataCache_1_io_cpu_memory_mmuRsp_isIoAccess),
		.io_cpu_memory_mmuRsp_isPaging(DBusCachedPlugin_mmuBus_rsp_isPaging),
		.io_cpu_memory_mmuRsp_allowRead(DBusCachedPlugin_mmuBus_rsp_allowRead),
		.io_cpu_memory_mmuRsp_allowWrite(DBusCachedPlugin_mmuBus_rsp_allowWrite),
		.io_cpu_memory_mmuRsp_allowExecute(DBusCachedPlugin_mmuBus_rsp_allowExecute),
		.io_cpu_memory_mmuRsp_exception(DBusCachedPlugin_mmuBus_rsp_exception),
		.io_cpu_memory_mmuRsp_refilling(DBusCachedPlugin_mmuBus_rsp_refilling),
		.io_cpu_memory_mmuRsp_bypassTranslation(DBusCachedPlugin_mmuBus_rsp_bypassTranslation),
		.io_cpu_memory_mmuRsp_ways_0_sel(DBusCachedPlugin_mmuBus_rsp_ways_0_sel),
		.io_cpu_memory_mmuRsp_ways_0_physical(DBusCachedPlugin_mmuBus_rsp_ways_0_physical),
		.io_cpu_memory_mmuRsp_ways_1_sel(DBusCachedPlugin_mmuBus_rsp_ways_1_sel),
		.io_cpu_memory_mmuRsp_ways_1_physical(DBusCachedPlugin_mmuBus_rsp_ways_1_physical),
		.io_cpu_memory_mmuRsp_ways_2_sel(DBusCachedPlugin_mmuBus_rsp_ways_2_sel),
		.io_cpu_memory_mmuRsp_ways_2_physical(DBusCachedPlugin_mmuBus_rsp_ways_2_physical),
		.io_cpu_memory_mmuRsp_ways_3_sel(DBusCachedPlugin_mmuBus_rsp_ways_3_sel),
		.io_cpu_memory_mmuRsp_ways_3_physical(DBusCachedPlugin_mmuBus_rsp_ways_3_physical),
		.io_cpu_writeBack_isValid(dataCache_1_io_cpu_writeBack_isValid),
		.io_cpu_writeBack_isStuck(writeBack_arbitration_isStuck),
		.io_cpu_writeBack_isFiring(writeBack_arbitration_isFiring),
		.io_cpu_writeBack_isUser(dataCache_1_io_cpu_writeBack_isUser),
		.io_cpu_writeBack_haltIt(dataCache_1_io_cpu_writeBack_haltIt),
		.io_cpu_writeBack_isWrite(dataCache_1_io_cpu_writeBack_isWrite),
		.io_cpu_writeBack_storeData(dataCache_1_io_cpu_writeBack_storeData),
		.io_cpu_writeBack_data(dataCache_1_io_cpu_writeBack_data),
		.io_cpu_writeBack_address(dataCache_1_io_cpu_writeBack_address),
		.io_cpu_writeBack_mmuException(dataCache_1_io_cpu_writeBack_mmuException),
		.io_cpu_writeBack_unalignedAccess(dataCache_1_io_cpu_writeBack_unalignedAccess),
		.io_cpu_writeBack_accessError(dataCache_1_io_cpu_writeBack_accessError),
		.io_cpu_writeBack_keepMemRspData(dataCache_1_io_cpu_writeBack_keepMemRspData),
		.io_cpu_writeBack_fence_SW(dataCache_1_io_cpu_writeBack_fence_SW),
		.io_cpu_writeBack_fence_SR(dataCache_1_io_cpu_writeBack_fence_SR),
		.io_cpu_writeBack_fence_SO(dataCache_1_io_cpu_writeBack_fence_SO),
		.io_cpu_writeBack_fence_SI(dataCache_1_io_cpu_writeBack_fence_SI),
		.io_cpu_writeBack_fence_PW(dataCache_1_io_cpu_writeBack_fence_PW),
		.io_cpu_writeBack_fence_PR(dataCache_1_io_cpu_writeBack_fence_PR),
		.io_cpu_writeBack_fence_PO(dataCache_1_io_cpu_writeBack_fence_PO),
		.io_cpu_writeBack_fence_PI(dataCache_1_io_cpu_writeBack_fence_PI),
		.io_cpu_writeBack_fence_FM(dataCache_1_io_cpu_writeBack_fence_FM),
		.io_cpu_writeBack_exclusiveOk(dataCache_1_io_cpu_writeBack_exclusiveOk),
		.io_cpu_redo(dataCache_1_io_cpu_redo),
		.io_cpu_flush_valid(dataCache_1_io_cpu_flush_valid),
		.io_cpu_flush_ready(dataCache_1_io_cpu_flush_ready),
		.io_cpu_flush_payload_singleLine(dataCache_1_io_cpu_flush_payload_singleLine),
		.io_cpu_flush_payload_lineId(dataCache_1_io_cpu_flush_payload_lineId),
		.io_cpu_writesPending(dataCache_1_io_cpu_writesPending),
		.io_mem_cmd_valid(dataCache_1_io_mem_cmd_valid),
		.io_mem_cmd_ready(dataCache_1_io_mem_cmd_ready),
		.io_mem_cmd_payload_wr(dataCache_1_io_mem_cmd_payload_wr),
		.io_mem_cmd_payload_uncached(dataCache_1_io_mem_cmd_payload_uncached),
		.io_mem_cmd_payload_address(dataCache_1_io_mem_cmd_payload_address),
		.io_mem_cmd_payload_data(dataCache_1_io_mem_cmd_payload_data),
		.io_mem_cmd_payload_mask(dataCache_1_io_mem_cmd_payload_mask),
		.io_mem_cmd_payload_size(dataCache_1_io_mem_cmd_payload_size),
		.io_mem_cmd_payload_last(dataCache_1_io_mem_cmd_payload_last),
		.io_mem_rsp_valid(dBus_rsp_regNext_valid),
		.io_mem_rsp_payload_last(dBus_rsp_regNext_payload_last),
		.io_mem_rsp_payload_data(dBus_rsp_regNext_payload_data),
		.io_mem_rsp_payload_error(dBus_rsp_regNext_payload_error),
		.clk(clk),
		.reset(reset)
	);
endmodule
module FpuCore_VexRiscv_FpuPlugin_fpu  (
	io_port_0_cmd_valid,
	io_port_0_cmd_ready,
	io_port_0_cmd_payload_opcode,
	io_port_0_cmd_payload_arg,
	io_port_0_cmd_payload_rs1,
	io_port_0_cmd_payload_rs2,
	io_port_0_cmd_payload_rs3,
	io_port_0_cmd_payload_rd,
	io_port_0_cmd_payload_format,
	io_port_0_cmd_payload_roundMode,
	io_port_0_commit_valid,
	io_port_0_commit_ready,
	io_port_0_commit_payload_opcode,
	io_port_0_commit_payload_rd,
	io_port_0_commit_payload_write,
	io_port_0_commit_payload_value,
	io_port_0_rsp_valid,
	io_port_0_rsp_ready,
	io_port_0_rsp_payload_value,
	io_port_0_rsp_payload_NV,
	io_port_0_rsp_payload_NX,
	io_port_0_completion_valid,
	io_port_0_completion_payload_flags_NX,
	io_port_0_completion_payload_flags_UF,
	io_port_0_completion_payload_flags_OF,
	io_port_0_completion_payload_flags_DZ,
	io_port_0_completion_payload_flags_NV,
	io_port_0_completion_payload_written,
	clk,
	reset
);
	input io_port_0_cmd_valid;
	output io_port_0_cmd_ready;
	input [3:0] io_port_0_cmd_payload_opcode;
	input [1:0] io_port_0_cmd_payload_arg;
	input [4:0] io_port_0_cmd_payload_rs1;
	input [4:0] io_port_0_cmd_payload_rs2;
	input [4:0] io_port_0_cmd_payload_rs3;
	input [4:0] io_port_0_cmd_payload_rd;
	input io_port_0_cmd_payload_format;
	input [2:0] io_port_0_cmd_payload_roundMode;
	input io_port_0_commit_valid;
	output io_port_0_commit_ready;
	input [3:0] io_port_0_commit_payload_opcode;
	input [4:0] io_port_0_commit_payload_rd;
	input io_port_0_commit_payload_write;
	input [63:0] io_port_0_commit_payload_value;
	output io_port_0_rsp_valid;
	input io_port_0_rsp_ready;
	output [63:0] io_port_0_rsp_payload_value;
	output io_port_0_rsp_payload_NV;
	output io_port_0_rsp_payload_NX;
	output io_port_0_completion_valid;
	output io_port_0_completion_payload_flags_NX;
	output io_port_0_completion_payload_flags_UF;
	output io_port_0_completion_payload_flags_OF;
	output io_port_0_completion_payload_flags_DZ;
	output io_port_0_completion_payload_flags_NV;
	output io_port_0_completion_payload_written;
	input clk;
	input reset;
	parameter FpuFormat_DOUBLE = 1'b1;
	parameter FpuFormat_FLOAT = 1'b0;
	parameter FpuOpcode_ADD = 4'h3;
	parameter FpuOpcode_CMP = 4'h7;
	parameter FpuOpcode_DIV = 4'h8;
	parameter FpuOpcode_F2I = 4'h6;
	parameter FpuOpcode_FCLASS = 4'he;
	parameter FpuOpcode_FCVT_X_X = 4'hf;
	parameter FpuOpcode_FMA = 4'h4;
	parameter FpuOpcode_FMV_W_X = 4'hd;
	parameter FpuOpcode_FMV_X_W = 4'hc;
	parameter FpuOpcode_I2F = 4'h5;
	parameter FpuOpcode_LOAD = 4'h0;
	parameter FpuOpcode_MIN_MAX = 4'ha;
	parameter FpuOpcode_MUL = 4'h2;
	parameter FpuOpcode_SGNJ = 4'hb;
	parameter FpuOpcode_SQRT = 4'h9;
	parameter FpuOpcode_STORE = 4'h1;
	parameter FpuRoundMode_RDN = 3'h2;
	parameter FpuRoundMode_RMM = 3'h4;
	parameter FpuRoundMode_RNE = 3'h0;
	parameter FpuRoundMode_RTZ = 3'h1;
	parameter FpuRoundMode_RUP = 3'h3;
	wire FpuPlugin_fpu_div_divider_io_input_fire;
	wire FpuPlugin_fpu_sqrt_sqrt_io_input_fire;
	wire FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_DZ;
	wire FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_NV;
	wire FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_format;
	wire [4:0] FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_rd;
	wire [2:0] FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_roundMode;
	wire FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_scrap;
	wire [11:0] FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_value_exponent;
	wire [52:0] FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_value_mantissa;
	wire FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_value_sign;
	wire FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_value_special;
	wire FpuPlugin_fpu_streamArbiter_2_io_output_combStage_ready;
	wire FpuPlugin_fpu_streamArbiter_2_io_output_combStage_valid;
	reg [3:0] FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode;
	reg [4:0] FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_rd;
	reg [63:0] FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_value;
	reg FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_write;
	reg FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid;
	wire [3:0] FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode;
	wire [4:0] FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_rd;
	wire [63:0] FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_value;
	wire FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_write;
	wire FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_ready;
	wire FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_valid;
	reg _zz_1;
	reg _zz_2;
	reg _zz_3;
	reg _zz_4;
	wire _zz__zz_add_oh_shift;
	wire _zz__zz_add_oh_shift_1;
	wire _zz__zz_add_oh_shift_10;
	wire [11:0] _zz__zz_add_oh_shift_11;
	wire _zz__zz_add_oh_shift_12;
	wire _zz__zz_add_oh_shift_13;
	wire _zz__zz_add_oh_shift_14;
	wire [55:0] _zz__zz_add_oh_shift_1_1;
	wire [44:0] _zz__zz_add_oh_shift_2;
	wire _zz__zz_add_oh_shift_3;
	wire _zz__zz_add_oh_shift_4;
	wire [33:0] _zz__zz_add_oh_shift_5;
	wire _zz__zz_add_oh_shift_51;
	wire _zz__zz_add_oh_shift_52;
	wire _zz__zz_add_oh_shift_53;
	wire _zz__zz_add_oh_shift_54;
	wire _zz__zz_add_oh_shift_55;
	wire _zz__zz_add_oh_shift_56;
	wire _zz__zz_add_oh_shift_6;
	wire _zz__zz_add_oh_shift_7;
	wire [22:0] _zz__zz_add_oh_shift_8;
	wire _zz__zz_add_oh_shift_9;
	wire _zz__zz_load_s1_fsm_shift_by;
	wire _zz__zz_load_s1_fsm_shift_by_1;
	wire _zz__zz_load_s1_fsm_shift_by_10;
	wire [7:0] _zz__zz_load_s1_fsm_shift_by_11;
	wire [51:0] _zz__zz_load_s1_fsm_shift_by_1_1;
	wire [40:0] _zz__zz_load_s1_fsm_shift_by_2;
	wire _zz__zz_load_s1_fsm_shift_by_3;
	wire _zz__zz_load_s1_fsm_shift_by_4;
	wire _zz__zz_load_s1_fsm_shift_by_47;
	wire _zz__zz_load_s1_fsm_shift_by_48;
	wire _zz__zz_load_s1_fsm_shift_by_49;
	wire [29:0] _zz__zz_load_s1_fsm_shift_by_5;
	wire _zz__zz_load_s1_fsm_shift_by_50;
	wire _zz__zz_load_s1_fsm_shift_by_51;
	wire _zz__zz_load_s1_fsm_shift_by_52;
	wire _zz__zz_load_s1_fsm_shift_by_6;
	wire _zz__zz_load_s1_fsm_shift_by_7;
	wire [18:0] _zz__zz_load_s1_fsm_shift_by_8;
	wire _zz__zz_load_s1_fsm_shift_by_9;
	wire [53:0] _zz__zz_roundFront_mantissaIncrement;
	wire [51:0] _zz__zz_roundFront_mantissaIncrement_1;
	wire [56:0] _zz_add_math_output_payload_xyMantissa;
	wire [56:0] _zz_add_math_output_payload_xyMantissa_1;
	wire [56:0] _zz_add_math_output_payload_xyMantissa_2;
	wire [56:0] _zz_add_math_output_payload_xyMantissa_3;
	wire [55:0] _zz_add_math_xSigned;
	wire [55:0] _zz_add_math_xSigned_1;
	wire _zz_add_math_xSigned_2;
	wire [55:0] _zz_add_math_ySigned;
	wire [55:0] _zz_add_math_ySigned_1;
	wire _zz_add_math_ySigned_2;
	wire [12:0] _zz_add_norm_output_payload_exponent;
	wire [12:0] _zz_add_norm_output_payload_exponent_1;
	wire [6:0] _zz_add_norm_output_payload_exponent_2;
	wire _zz_add_oh_input_ready;
	wire [55:0] _zz_add_oh_shift;
	wire [55:0] _zz_add_oh_shift_1;
	wire _zz_add_oh_shift_10;
	wire _zz_add_oh_shift_11;
	wire _zz_add_oh_shift_12;
	wire _zz_add_oh_shift_13;
	wire _zz_add_oh_shift_14;
	wire _zz_add_oh_shift_15;
	wire _zz_add_oh_shift_16;
	wire _zz_add_oh_shift_17;
	wire _zz_add_oh_shift_18;
	wire _zz_add_oh_shift_19;
	wire _zz_add_oh_shift_2;
	wire _zz_add_oh_shift_20;
	wire _zz_add_oh_shift_21;
	wire _zz_add_oh_shift_22;
	wire _zz_add_oh_shift_23;
	wire _zz_add_oh_shift_24;
	wire _zz_add_oh_shift_25;
	wire _zz_add_oh_shift_26;
	wire _zz_add_oh_shift_27;
	wire _zz_add_oh_shift_28;
	wire _zz_add_oh_shift_29;
	wire _zz_add_oh_shift_3;
	wire _zz_add_oh_shift_30;
	wire _zz_add_oh_shift_31;
	wire _zz_add_oh_shift_32;
	wire _zz_add_oh_shift_33;
	wire _zz_add_oh_shift_34;
	wire _zz_add_oh_shift_35;
	wire _zz_add_oh_shift_36;
	wire _zz_add_oh_shift_37;
	wire _zz_add_oh_shift_38;
	wire _zz_add_oh_shift_39;
	wire _zz_add_oh_shift_4;
	wire _zz_add_oh_shift_40;
	wire _zz_add_oh_shift_41;
	wire _zz_add_oh_shift_42;
	wire _zz_add_oh_shift_43;
	wire _zz_add_oh_shift_44;
	wire _zz_add_oh_shift_45;
	wire _zz_add_oh_shift_46;
	wire _zz_add_oh_shift_47;
	wire _zz_add_oh_shift_48;
	wire _zz_add_oh_shift_49;
	wire _zz_add_oh_shift_5;
	wire _zz_add_oh_shift_50;
	wire _zz_add_oh_shift_51;
	wire _zz_add_oh_shift_52;
	wire _zz_add_oh_shift_53;
	wire _zz_add_oh_shift_54;
	wire _zz_add_oh_shift_55;
	wire _zz_add_oh_shift_56;
	wire _zz_add_oh_shift_6;
	wire _zz_add_oh_shift_7;
	wire _zz_add_oh_shift_8;
	wire _zz_add_oh_shift_9;
	wire [53:0] _zz_add_result_output_payload_value_mantissa;
	wire [12:0] _zz_add_shifter_shiftBy;
	wire [12:0] _zz_add_shifter_shiftBy_1;
	wire [12:0] _zz_add_shifter_shiftBy_2;
	wire [12:0] _zz_add_shifter_shiftBy_3;
	wire _zz_add_shifter_shiftBy_4;
	wire [54:0] _zz_add_shifter_yMantissa_1;
	wire [54:0] _zz_add_shifter_yMantissa_2;
	wire [54:0] _zz_add_shifter_yMantissa_3;
	wire [54:0] _zz_add_shifter_yMantissa_4;
	wire [54:0] _zz_add_shifter_yMantissa_5;
	wire [54:0] _zz_add_shifter_yMantissa_6;
	wire _zz_commitFork_commit_0_ready;
	wire [3:0] _zz_commitLogic_0_add_counter;
	wire [3:0] _zz_commitLogic_0_add_counter_1;
	wire _zz_commitLogic_0_add_counter_2;
	wire [3:0] _zz_commitLogic_0_add_counter_3;
	wire _zz_commitLogic_0_add_counter_4;
	wire [3:0] _zz_commitLogic_0_div_counter;
	wire [3:0] _zz_commitLogic_0_div_counter_1;
	wire _zz_commitLogic_0_div_counter_2;
	wire [3:0] _zz_commitLogic_0_div_counter_3;
	wire _zz_commitLogic_0_div_counter_4;
	wire [3:0] _zz_commitLogic_0_input_payload_opcode;
	wire [3:0] _zz_commitLogic_0_mul_counter;
	wire [3:0] _zz_commitLogic_0_mul_counter_1;
	wire _zz_commitLogic_0_mul_counter_2;
	wire [3:0] _zz_commitLogic_0_mul_counter_3;
	wire _zz_commitLogic_0_mul_counter_4;
	wire [3:0] _zz_commitLogic_0_pending_counter;
	wire [3:0] _zz_commitLogic_0_pending_counter_1;
	wire _zz_commitLogic_0_pending_counter_2;
	wire [3:0] _zz_commitLogic_0_pending_counter_3;
	wire _zz_commitLogic_0_pending_counter_4;
	wire [3:0] _zz_commitLogic_0_short_counter;
	wire [3:0] _zz_commitLogic_0_short_counter_1;
	wire _zz_commitLogic_0_short_counter_2;
	wire [3:0] _zz_commitLogic_0_short_counter_3;
	wire _zz_commitLogic_0_short_counter_4;
	wire [3:0] _zz_commitLogic_0_sqrt_counter;
	wire [3:0] _zz_commitLogic_0_sqrt_counter_1;
	wire _zz_commitLogic_0_sqrt_counter_2;
	wire [3:0] _zz_commitLogic_0_sqrt_counter_3;
	wire _zz_commitLogic_0_sqrt_counter_4;
	wire _zz_decode_load_s2mPipe_payload_format;
	wire [2:0] _zz_decode_load_s2mPipe_payload_roundMode;
	wire [3:0] _zz_decode_shortPipHit;
	wire _zz_decode_shortPipHit_1;
	wire _zz_decode_shortPipHit_2;
	wire _zz_decode_shortPipHit_3;
	wire [13:0] _zz_div_exponent;
	wire [13:0] _zz_div_exponent_1;
	wire [13:0] _zz_div_exponent_2;
	wire [13:0] _zz_div_exponent_3;
	wire [13:0] _zz_div_exponent_4;
	wire _zz_div_exponent_5;
	wire _zz_div_input_ready;
	wire _zz_io_inputs_0_payload_format;
	wire [3:0] _zz_io_inputs_0_payload_opcode;
	wire [2:0] _zz_io_inputs_0_payload_roundMode;
	wire _zz_load_s0_input_ready;
	wire [63:0] _zz_load_s0_output_rData_value;
	wire _zz_load_s0_output_rData_value_1;
	wire [31:0] _zz_load_s0_output_rData_value_2;
	wire [64:0] _zz_load_s0_output_rData_value_3;
	wire [64:0] _zz_load_s0_output_rData_value_4;
	wire [64:0] _zz_load_s0_output_rData_value_5;
	wire _zz_load_s0_output_rData_value_6;
	wire [51:0] _zz_load_s1_fsm_shift_by;
	wire [51:0] _zz_load_s1_fsm_shift_by_1;
	wire _zz_load_s1_fsm_shift_by_10;
	wire _zz_load_s1_fsm_shift_by_11;
	wire _zz_load_s1_fsm_shift_by_12;
	wire _zz_load_s1_fsm_shift_by_13;
	wire _zz_load_s1_fsm_shift_by_14;
	wire _zz_load_s1_fsm_shift_by_15;
	wire _zz_load_s1_fsm_shift_by_16;
	wire _zz_load_s1_fsm_shift_by_17;
	wire _zz_load_s1_fsm_shift_by_18;
	wire _zz_load_s1_fsm_shift_by_19;
	wire _zz_load_s1_fsm_shift_by_2;
	wire _zz_load_s1_fsm_shift_by_20;
	wire _zz_load_s1_fsm_shift_by_21;
	wire _zz_load_s1_fsm_shift_by_22;
	wire _zz_load_s1_fsm_shift_by_23;
	wire _zz_load_s1_fsm_shift_by_24;
	wire _zz_load_s1_fsm_shift_by_25;
	wire _zz_load_s1_fsm_shift_by_26;
	wire _zz_load_s1_fsm_shift_by_27;
	wire _zz_load_s1_fsm_shift_by_28;
	wire _zz_load_s1_fsm_shift_by_29;
	wire _zz_load_s1_fsm_shift_by_3;
	wire _zz_load_s1_fsm_shift_by_30;
	wire _zz_load_s1_fsm_shift_by_31;
	wire _zz_load_s1_fsm_shift_by_32;
	wire _zz_load_s1_fsm_shift_by_33;
	wire _zz_load_s1_fsm_shift_by_34;
	wire _zz_load_s1_fsm_shift_by_35;
	wire _zz_load_s1_fsm_shift_by_36;
	wire _zz_load_s1_fsm_shift_by_37;
	wire _zz_load_s1_fsm_shift_by_38;
	wire _zz_load_s1_fsm_shift_by_39;
	wire _zz_load_s1_fsm_shift_by_4;
	wire _zz_load_s1_fsm_shift_by_40;
	wire _zz_load_s1_fsm_shift_by_41;
	wire _zz_load_s1_fsm_shift_by_42;
	wire _zz_load_s1_fsm_shift_by_43;
	wire _zz_load_s1_fsm_shift_by_44;
	wire _zz_load_s1_fsm_shift_by_45;
	wire _zz_load_s1_fsm_shift_by_46;
	wire _zz_load_s1_fsm_shift_by_47;
	wire _zz_load_s1_fsm_shift_by_48;
	wire _zz_load_s1_fsm_shift_by_49;
	wire _zz_load_s1_fsm_shift_by_5;
	wire _zz_load_s1_fsm_shift_by_50;
	wire _zz_load_s1_fsm_shift_by_51;
	wire _zz_load_s1_fsm_shift_by_52;
	wire _zz_load_s1_fsm_shift_by_6;
	wire _zz_load_s1_fsm_shift_by_7;
	wire _zz_load_s1_fsm_shift_by_8;
	wire _zz_load_s1_fsm_shift_by_9;
	wire [51:0] _zz_load_s1_fsm_shift_input_1;
	wire [51:0] _zz_load_s1_fsm_shift_input_2;
	wire [51:0] _zz_load_s1_fsm_shift_input_3;
	wire [51:0] _zz_load_s1_fsm_shift_input_4;
	wire [51:0] _zz_load_s1_fsm_shift_input_5;
	wire [51:0] _zz_load_s1_fsm_shift_input_6;
	wire _zz_load_s1_input_ready;
	wire [11:0] _zz_load_s1_output_payload_value_exponent;
	wire [12:0] _zz_load_s1_recoded_exponent;
	wire [12:0] _zz_load_s1_recoded_exponent_1;
	wire [12:0] _zz_load_s1_recoded_exponent_2;
	wire [12:0] _zz_mul_norm_exp;
	wire _zz_mul_norm_exp_1;
	wire [12:0] _zz_mul_norm_forceUnderflow;
	wire [12:0] _zz_mul_norm_output_exponent;
	wire [105:0] _zz_mul_sum1_sum;
	wire [105:0] _zz_mul_sum1_sum_1;
	wire [105:0] _zz_mul_sum1_sum_2;
	wire [53:0] _zz_mul_sum1_sum_3;
	wire [105:0] _zz_mul_sum1_sum_4;
	wire [105:0] _zz_mul_sum1_sum_5;
	wire [53:0] _zz_mul_sum1_sum_6;
	wire [105:0] _zz_mul_sum1_sum_7;
	wire [70:0] _zz_mul_sum1_sum_8;
	wire _zz_mul_sum2_input_ready;
	wire [105:0] _zz_mul_sum2_sum;
	wire [105:0] _zz_mul_sum2_sum_1;
	wire [105:0] _zz_mul_sum2_sum_10;
	wire [88:0] _zz_mul_sum2_sum_11;
	wire [105:0] _zz_mul_sum2_sum_12;
	wire [105:0] _zz_mul_sum2_sum_13;
	wire [105:0] _zz_mul_sum2_sum_2;
	wire [105:0] _zz_mul_sum2_sum_3;
	wire [70:0] _zz_mul_sum2_sum_4;
	wire [105:0] _zz_mul_sum2_sum_5;
	wire [71:0] _zz_mul_sum2_sum_6;
	wire [105:0] _zz_mul_sum2_sum_7;
	wire [105:0] _zz_mul_sum2_sum_8;
	wire [88:0] _zz_mul_sum2_sum_9;
	wire [3:0] _zz_payload_opcode;
	wire _zz_read_output_payload_format;
	wire [4:0] _zz_read_rs_0_boxed;
	wire _zz_read_rs_0_boxed_1;
	wire [66:0] _zz_read_rs_0_boxed_2;
	wire [65:0] _zz_read_rs_0_value_mantissa;
	wire [4:0] _zz_read_rs_1_boxed;
	wire _zz_read_rs_1_boxed_1;
	wire [66:0] _zz_read_rs_1_boxed_2;
	wire [65:0] _zz_read_rs_1_value_mantissa;
	wire [4:0] _zz_read_rs_2_boxed;
	wire _zz_read_rs_2_boxed_1;
	wire [66:0] _zz_read_rs_2_boxed_2;
	wire [65:0] _zz_read_rs_2_value_mantissa;
	wire [66:0] _zz_rf_ram_port;
	reg [66:0] _zz_rf_ram_port0;
	reg [66:0] _zz_rf_ram_port1;
	reg [66:0] _zz_rf_ram_port2;
	wire _zz_rf_scoreboards_0_hit_port;
	wire _zz_rf_scoreboards_0_hit_port1;
	wire _zz_rf_scoreboards_0_hit_port2;
	wire _zz_rf_scoreboards_0_hit_port3;
	wire _zz_rf_scoreboards_0_hit_port4;
	wire _zz_rf_scoreboards_0_hit_port5;
	wire _zz_rf_scoreboards_0_target_port;
	wire _zz_rf_scoreboards_0_target_port1;
	wire _zz_rf_scoreboards_0_target_port2;
	wire _zz_rf_scoreboards_0_target_port3;
	wire _zz_rf_scoreboards_0_target_port4;
	wire _zz_rf_scoreboards_0_writes_port;
	wire _zz_rf_scoreboards_0_writes_port1;
	wire [63:0] _zz_roundBack_adder;
	wire [51:0] _zz_roundBack_adderMantissa;
	wire [52:0] _zz_roundBack_adderRightOp;
	wire [52:0] _zz_roundBack_adderRightOp_1;
	wire _zz_roundBack_adder_1;
	wire [63:0] _zz_roundBack_adder_2;
	wire [63:0] _zz_roundBack_adder_3;
	wire [63:0] _zz_roundBack_adder_4;
	wire [11:0] _zz_roundBack_borringCase;
	wire [63:0] _zz_roundBack_masked;
	wire [51:0] _zz_roundBack_masked_1;
	wire [52:0] _zz_roundBack_masked_2;
	wire [5:0] _zz_roundFront_discardCount;
	wire [5:0] _zz_roundFront_exactMask;
	wire _zz_roundFront_exactMask_1;
	wire _zz_roundFront_exactMask_10;
	wire [30:0] _zz_roundFront_exactMask_11;
	wire [5:0] _zz_roundFront_exactMask_12;
	wire _zz_roundFront_exactMask_13;
	wire _zz_roundFront_exactMask_14;
	wire [22:0] _zz_roundFront_exactMask_15;
	wire [5:0] _zz_roundFront_exactMask_16;
	wire _zz_roundFront_exactMask_17;
	wire _zz_roundFront_exactMask_18;
	wire [14:0] _zz_roundFront_exactMask_19;
	wire _zz_roundFront_exactMask_2;
	wire [5:0] _zz_roundFront_exactMask_20;
	wire _zz_roundFront_exactMask_21;
	wire _zz_roundFront_exactMask_22;
	wire [6:0] _zz_roundFront_exactMask_23;
	wire [46:0] _zz_roundFront_exactMask_3;
	wire [5:0] _zz_roundFront_exactMask_4;
	wire _zz_roundFront_exactMask_5;
	wire _zz_roundFront_exactMask_6;
	wire [38:0] _zz_roundFront_exactMask_7;
	wire [5:0] _zz_roundFront_exactMask_8;
	wire _zz_roundFront_exactMask_9;
	wire [12:0] _zz_roundFront_expDif;
	wire [11:0] _zz_roundFront_expDif_1;
	reg _zz_roundFront_mantissaIncrement;
	wire [53:0] _zz_roundFront_roundAdjusted;
	wire [52:0] _zz_roundFront_roundAdjusted_1;
	wire _zz_scheduler_0_input_payload_format;
	wire [3:0] _zz_scheduler_0_input_payload_opcode;
	wire [2:0] _zz_scheduler_0_input_payload_roundMode;
	wire _zz_scheduler_0_input_ready;
	wire [11:0] _zz_shortPip_expInSubnormalRange;
	wire [31:0] _zz_shortPip_f2i_result;
	wire _zz_shortPip_f2i_result_1;
	wire [11:0] _zz_shortPip_f32_exp;
	wire [11:0] _zz_shortPip_f64_exp;
	wire [11:0] _zz_shortPip_fsm_shift_by;
	wire [5:0] _zz_shortPip_fsm_shift_by_1;
	wire [11:0] _zz_shortPip_fsm_shift_by_2;
	wire [11:0] _zz_shortPip_fsm_shift_by_3;
	wire [11:0] _zz_shortPip_fsm_shift_by_4;
	wire [11:0] _zz_shortPip_fsm_shift_by_5;
	wire [11:0] _zz_shortPip_fsm_shift_by_6;
	wire [52:0] _zz_shortPip_fsm_shift_input_1;
	wire [52:0] _zz_shortPip_fsm_shift_input_2;
	wire [52:0] _zz_shortPip_fsm_shift_input_3;
	wire [52:0] _zz_shortPip_fsm_shift_input_4;
	wire [52:0] _zz_shortPip_fsm_shift_input_5;
	wire [52:0] _zz_shortPip_fsm_shift_input_6;
	wire _zz_shortPip_rfOutput_payload_format;
	wire _zz_shortPip_rfOutput_ready;
	wire [11:0] _zz_sqrt_exponent;
	wire [11:0] _zz_sqrt_exponent_1;
	wire [10:0] _zz_sqrt_exponent_2;
	wire [10:0] _zz_sqrt_exponent_3;
	wire [11:0] _zz_sqrt_exponent_4;
	wire _zz_sqrt_exponent_5;
	wire _zz_sqrt_input_ready;
	wire _zz_when;
	wire [11:0] _zz_when_FpuCore_l1609;
	wire [11:0] _zz_when_FpuCore_l1631;
	wire add_math_input_payload_format;
	wire add_math_input_payload_needCommit;
	wire [4:0] add_math_input_payload_rd;
	wire [2:0] add_math_input_payload_roundMode;
	wire add_math_input_payload_roundingScrap;
	wire [11:0] add_math_input_payload_rs1_exponent;
	wire [53:0] add_math_input_payload_rs1_mantissa;
	wire add_math_input_payload_rs1_sign;
	wire add_math_input_payload_rs1_special;
	wire [11:0] add_math_input_payload_rs2_exponent;
	wire [53:0] add_math_input_payload_rs2_mantissa;
	wire add_math_input_payload_rs2_sign;
	wire add_math_input_payload_rs2_special;
	wire [54:0] add_math_input_payload_xMantissa;
	wire add_math_input_payload_xSign;
	wire [11:0] add_math_input_payload_xyExponent;
	wire add_math_input_payload_xySign;
	wire [54:0] add_math_input_payload_yMantissa;
	wire add_math_input_payload_ySign;
	wire add_math_input_ready;
	wire add_math_input_valid;
	wire add_math_output_payload_format;
	wire add_math_output_payload_needCommit;
	wire [4:0] add_math_output_payload_rd;
	wire [2:0] add_math_output_payload_roundMode;
	wire add_math_output_payload_roundingScrap;
	wire [11:0] add_math_output_payload_rs1_exponent;
	wire [53:0] add_math_output_payload_rs1_mantissa;
	wire add_math_output_payload_rs1_sign;
	wire add_math_output_payload_rs1_special;
	wire [11:0] add_math_output_payload_rs2_exponent;
	wire [53:0] add_math_output_payload_rs2_mantissa;
	wire add_math_output_payload_rs2_sign;
	wire add_math_output_payload_rs2_special;
	wire [54:0] add_math_output_payload_xMantissa;
	wire add_math_output_payload_xSign;
	wire [11:0] add_math_output_payload_xyExponent;
	wire [55:0] add_math_output_payload_xyMantissa;
	wire add_math_output_payload_xySign;
	wire [54:0] add_math_output_payload_yMantissa;
	wire add_math_output_payload_ySign;
	reg add_math_output_rData_format;
	reg add_math_output_rData_needCommit;
	reg [4:0] add_math_output_rData_rd;
	reg [2:0] add_math_output_rData_roundMode;
	reg add_math_output_rData_roundingScrap;
	reg [11:0] add_math_output_rData_rs1_exponent;
	reg [53:0] add_math_output_rData_rs1_mantissa;
	reg add_math_output_rData_rs1_sign;
	reg add_math_output_rData_rs1_special;
	reg [11:0] add_math_output_rData_rs2_exponent;
	reg [53:0] add_math_output_rData_rs2_mantissa;
	reg add_math_output_rData_rs2_sign;
	reg add_math_output_rData_rs2_special;
	reg [54:0] add_math_output_rData_xMantissa;
	reg add_math_output_rData_xSign;
	reg [11:0] add_math_output_rData_xyExponent;
	reg [55:0] add_math_output_rData_xyMantissa;
	reg add_math_output_rData_xySign;
	reg [54:0] add_math_output_rData_yMantissa;
	reg add_math_output_rData_ySign;
	reg add_math_output_rValid;
	reg add_math_output_ready;
	wire add_math_output_valid;
	wire [55:0] add_math_xSigned;
	wire [55:0] add_math_ySigned;
	wire add_norm_input_payload_format;
	wire add_norm_input_payload_needCommit;
	wire [4:0] add_norm_input_payload_rd;
	wire [2:0] add_norm_input_payload_roundMode;
	wire add_norm_input_payload_roundingScrap;
	wire [11:0] add_norm_input_payload_rs1_exponent;
	wire [53:0] add_norm_input_payload_rs1_mantissa;
	wire add_norm_input_payload_rs1_sign;
	wire add_norm_input_payload_rs1_special;
	wire [11:0] add_norm_input_payload_rs2_exponent;
	wire [53:0] add_norm_input_payload_rs2_mantissa;
	wire add_norm_input_payload_rs2_sign;
	wire add_norm_input_payload_rs2_special;
	wire [5:0] add_norm_input_payload_shift;
	wire [54:0] add_norm_input_payload_xMantissa;
	wire add_norm_input_payload_xSign;
	wire [11:0] add_norm_input_payload_xyExponent;
	wire [55:0] add_norm_input_payload_xyMantissa;
	wire add_norm_input_payload_xySign;
	wire [54:0] add_norm_input_payload_yMantissa;
	wire add_norm_input_payload_ySign;
	wire add_norm_input_ready;
	wire add_norm_input_valid;
	wire [12:0] add_norm_output_payload_exponent;
	wire add_norm_output_payload_forceInfinity;
	wire add_norm_output_payload_forceNan;
	wire add_norm_output_payload_forceZero;
	wire add_norm_output_payload_format;
	wire add_norm_output_payload_infinityNan;
	wire [55:0] add_norm_output_payload_mantissa;
	wire add_norm_output_payload_needCommit;
	wire [4:0] add_norm_output_payload_rd;
	wire [2:0] add_norm_output_payload_roundMode;
	wire add_norm_output_payload_roundingScrap;
	wire [11:0] add_norm_output_payload_rs1_exponent;
	wire [53:0] add_norm_output_payload_rs1_mantissa;
	wire add_norm_output_payload_rs1_sign;
	wire add_norm_output_payload_rs1_special;
	wire [11:0] add_norm_output_payload_rs2_exponent;
	wire [53:0] add_norm_output_payload_rs2_mantissa;
	wire add_norm_output_payload_rs2_sign;
	wire add_norm_output_payload_rs2_special;
	wire add_norm_output_payload_xyMantissaZero;
	wire add_norm_output_payload_xySign;
	wire add_norm_output_ready;
	wire add_norm_output_valid;
	wire add_oh_input_fire;
	wire add_oh_input_payload_format;
	wire add_oh_input_payload_needCommit;
	wire [4:0] add_oh_input_payload_rd;
	wire [2:0] add_oh_input_payload_roundMode;
	wire add_oh_input_payload_roundingScrap;
	wire [11:0] add_oh_input_payload_rs1_exponent;
	wire [53:0] add_oh_input_payload_rs1_mantissa;
	wire add_oh_input_payload_rs1_sign;
	wire add_oh_input_payload_rs1_special;
	wire [11:0] add_oh_input_payload_rs2_exponent;
	wire [53:0] add_oh_input_payload_rs2_mantissa;
	wire add_oh_input_payload_rs2_sign;
	wire add_oh_input_payload_rs2_special;
	wire [54:0] add_oh_input_payload_xMantissa;
	wire add_oh_input_payload_xSign;
	wire [11:0] add_oh_input_payload_xyExponent;
	wire [55:0] add_oh_input_payload_xyMantissa;
	wire add_oh_input_payload_xySign;
	wire [54:0] add_oh_input_payload_yMantissa;
	wire add_oh_input_payload_ySign;
	wire add_oh_input_ready;
	wire add_oh_input_valid;
	wire add_oh_isCommited;
	wire add_oh_output_payload_format;
	wire add_oh_output_payload_needCommit;
	wire [4:0] add_oh_output_payload_rd;
	wire [2:0] add_oh_output_payload_roundMode;
	wire add_oh_output_payload_roundingScrap;
	wire [11:0] add_oh_output_payload_rs1_exponent;
	wire [53:0] add_oh_output_payload_rs1_mantissa;
	wire add_oh_output_payload_rs1_sign;
	wire add_oh_output_payload_rs1_special;
	wire [11:0] add_oh_output_payload_rs2_exponent;
	wire [53:0] add_oh_output_payload_rs2_mantissa;
	wire add_oh_output_payload_rs2_sign;
	wire add_oh_output_payload_rs2_special;
	wire [5:0] add_oh_output_payload_shift;
	wire [54:0] add_oh_output_payload_xMantissa;
	wire add_oh_output_payload_xSign;
	wire [11:0] add_oh_output_payload_xyExponent;
	wire [55:0] add_oh_output_payload_xyMantissa;
	wire add_oh_output_payload_xySign;
	wire [54:0] add_oh_output_payload_yMantissa;
	wire add_oh_output_payload_ySign;
	reg add_oh_output_rData_format;
	reg add_oh_output_rData_needCommit;
	reg [4:0] add_oh_output_rData_rd;
	reg [2:0] add_oh_output_rData_roundMode;
	reg add_oh_output_rData_roundingScrap;
	reg [11:0] add_oh_output_rData_rs1_exponent;
	reg [53:0] add_oh_output_rData_rs1_mantissa;
	reg add_oh_output_rData_rs1_sign;
	reg add_oh_output_rData_rs1_special;
	reg [11:0] add_oh_output_rData_rs2_exponent;
	reg [53:0] add_oh_output_rData_rs2_mantissa;
	reg add_oh_output_rData_rs2_sign;
	reg add_oh_output_rData_rs2_special;
	reg [5:0] add_oh_output_rData_shift;
	reg [54:0] add_oh_output_rData_xMantissa;
	reg add_oh_output_rData_xSign;
	reg [11:0] add_oh_output_rData_xyExponent;
	reg [55:0] add_oh_output_rData_xyMantissa;
	reg add_oh_output_rData_xySign;
	reg [54:0] add_oh_output_rData_yMantissa;
	reg add_oh_output_rData_ySign;
	reg add_oh_output_rValid;
	reg add_oh_output_ready;
	wire add_oh_output_valid;
	wire [5:0] add_oh_shift;
	wire add_preShifter_absRs1Bigger;
	wire [12:0] add_preShifter_exp21;
	wire add_preShifter_input_payload_format;
	wire add_preShifter_input_payload_needCommit;
	wire [4:0] add_preShifter_input_payload_rd;
	wire [2:0] add_preShifter_input_payload_roundMode;
	wire [11:0] add_preShifter_input_payload_rs1_exponent;
	wire [53:0] add_preShifter_input_payload_rs1_mantissa;
	wire add_preShifter_input_payload_rs1_sign;
	wire add_preShifter_input_payload_rs1_special;
	wire [11:0] add_preShifter_input_payload_rs2_exponent;
	wire [53:0] add_preShifter_input_payload_rs2_mantissa;
	wire add_preShifter_input_payload_rs2_sign;
	wire add_preShifter_input_payload_rs2_special;
	wire add_preShifter_input_ready;
	wire add_preShifter_input_valid;
	wire add_preShifter_output_payload_absRs1Bigger;
	wire add_preShifter_output_payload_format;
	wire add_preShifter_output_payload_needCommit;
	wire [4:0] add_preShifter_output_payload_rd;
	wire [2:0] add_preShifter_output_payload_roundMode;
	wire add_preShifter_output_payload_rs1ExponentBigger;
	wire [11:0] add_preShifter_output_payload_rs1_exponent;
	wire [53:0] add_preShifter_output_payload_rs1_mantissa;
	wire add_preShifter_output_payload_rs1_sign;
	wire add_preShifter_output_payload_rs1_special;
	wire [11:0] add_preShifter_output_payload_rs2_exponent;
	wire [53:0] add_preShifter_output_payload_rs2_mantissa;
	wire add_preShifter_output_payload_rs2_sign;
	wire add_preShifter_output_payload_rs2_special;
	reg add_preShifter_output_rData_absRs1Bigger;
	reg add_preShifter_output_rData_format;
	reg add_preShifter_output_rData_needCommit;
	reg [4:0] add_preShifter_output_rData_rd;
	reg [2:0] add_preShifter_output_rData_roundMode;
	reg add_preShifter_output_rData_rs1ExponentBigger;
	reg [11:0] add_preShifter_output_rData_rs1_exponent;
	reg [53:0] add_preShifter_output_rData_rs1_mantissa;
	reg add_preShifter_output_rData_rs1_sign;
	reg add_preShifter_output_rData_rs1_special;
	reg [11:0] add_preShifter_output_rData_rs2_exponent;
	reg [53:0] add_preShifter_output_rData_rs2_mantissa;
	reg add_preShifter_output_rData_rs2_sign;
	reg add_preShifter_output_rData_rs2_special;
	reg add_preShifter_output_rValid;
	reg add_preShifter_output_ready;
	wire add_preShifter_output_valid;
	wire add_preShifter_rs1ExponentBigger;
	wire add_preShifter_rs1ExponentEqual;
	wire add_preShifter_rs1MantissaBigger;
	wire [12:0] add_result_input_payload_exponent;
	wire add_result_input_payload_forceInfinity;
	wire add_result_input_payload_forceNan;
	wire add_result_input_payload_forceZero;
	wire add_result_input_payload_format;
	wire add_result_input_payload_infinityNan;
	wire [55:0] add_result_input_payload_mantissa;
	wire add_result_input_payload_needCommit;
	wire [4:0] add_result_input_payload_rd;
	wire [2:0] add_result_input_payload_roundMode;
	wire add_result_input_payload_roundingScrap;
	wire [11:0] add_result_input_payload_rs1_exponent;
	wire [53:0] add_result_input_payload_rs1_mantissa;
	wire add_result_input_payload_rs1_sign;
	wire add_result_input_payload_rs1_special;
	wire [11:0] add_result_input_payload_rs2_exponent;
	wire [53:0] add_result_input_payload_rs2_mantissa;
	wire add_result_input_payload_rs2_sign;
	wire add_result_input_payload_rs2_special;
	wire add_result_input_payload_xyMantissaZero;
	wire add_result_input_payload_xySign;
	wire add_result_input_ready;
	wire add_result_input_valid;
	wire add_result_output_payload_DZ;
	wire add_result_output_payload_NV;
	wire add_result_output_payload_format;
	wire [4:0] add_result_output_payload_rd;
	wire [2:0] add_result_output_payload_roundMode;
	wire add_result_output_payload_scrap;
	reg [11:0] add_result_output_payload_value_exponent;
	reg [52:0] add_result_output_payload_value_mantissa;
	reg add_result_output_payload_value_sign;
	reg add_result_output_payload_value_special;
	wire add_result_output_ready;
	wire add_result_output_valid;
	wire [12:0] add_shifter_exp21;
	wire add_shifter_input_payload_absRs1Bigger;
	wire add_shifter_input_payload_format;
	wire add_shifter_input_payload_needCommit;
	wire [4:0] add_shifter_input_payload_rd;
	wire [2:0] add_shifter_input_payload_roundMode;
	wire add_shifter_input_payload_rs1ExponentBigger;
	wire [11:0] add_shifter_input_payload_rs1_exponent;
	wire [53:0] add_shifter_input_payload_rs1_mantissa;
	wire add_shifter_input_payload_rs1_sign;
	wire add_shifter_input_payload_rs1_special;
	wire [11:0] add_shifter_input_payload_rs2_exponent;
	wire [53:0] add_shifter_input_payload_rs2_mantissa;
	wire add_shifter_input_payload_rs2_sign;
	wire add_shifter_input_payload_rs2_special;
	wire add_shifter_input_ready;
	wire add_shifter_input_valid;
	wire add_shifter_output_payload_format;
	wire add_shifter_output_payload_needCommit;
	wire [4:0] add_shifter_output_payload_rd;
	wire [2:0] add_shifter_output_payload_roundMode;
	wire add_shifter_output_payload_roundingScrap;
	wire [11:0] add_shifter_output_payload_rs1_exponent;
	wire [53:0] add_shifter_output_payload_rs1_mantissa;
	wire add_shifter_output_payload_rs1_sign;
	wire add_shifter_output_payload_rs1_special;
	wire [11:0] add_shifter_output_payload_rs2_exponent;
	wire [53:0] add_shifter_output_payload_rs2_mantissa;
	wire add_shifter_output_payload_rs2_sign;
	wire add_shifter_output_payload_rs2_special;
	wire [54:0] add_shifter_output_payload_xMantissa;
	wire add_shifter_output_payload_xSign;
	wire [11:0] add_shifter_output_payload_xyExponent;
	wire add_shifter_output_payload_xySign;
	wire [54:0] add_shifter_output_payload_yMantissa;
	wire add_shifter_output_payload_ySign;
	reg add_shifter_output_rData_format;
	reg add_shifter_output_rData_needCommit;
	reg [4:0] add_shifter_output_rData_rd;
	reg [2:0] add_shifter_output_rData_roundMode;
	reg add_shifter_output_rData_roundingScrap;
	reg [11:0] add_shifter_output_rData_rs1_exponent;
	reg [53:0] add_shifter_output_rData_rs1_mantissa;
	reg add_shifter_output_rData_rs1_sign;
	reg add_shifter_output_rData_rs1_special;
	reg [11:0] add_shifter_output_rData_rs2_exponent;
	reg [53:0] add_shifter_output_rData_rs2_mantissa;
	reg add_shifter_output_rData_rs2_sign;
	reg add_shifter_output_rData_rs2_special;
	reg [54:0] add_shifter_output_rData_xMantissa;
	reg add_shifter_output_rData_xSign;
	reg [11:0] add_shifter_output_rData_xyExponent;
	reg add_shifter_output_rData_xySign;
	reg [54:0] add_shifter_output_rData_yMantissa;
	reg add_shifter_output_rData_ySign;
	reg add_shifter_output_rValid;
	reg add_shifter_output_ready;
	wire add_shifter_output_valid;
	wire add_shifter_passThrough;
	reg add_shifter_roundingScrap;
	wire [12:0] add_shifter_shiftBy;
	wire add_shifter_shiftOverflow;
	wire [54:0] add_shifter_xMantissa;
	wire add_shifter_xySign;
	wire [54:0] add_shifter_yMantissa;
	wire [54:0] add_shifter_yMantissaUnshifted;
	reg [54:0] add_shifter_yMantissa_1;
	reg [54:0] add_shifter_yMantissa_2;
	reg [54:0] add_shifter_yMantissa_3;
	reg [54:0] add_shifter_yMantissa_4;
	reg [54:0] add_shifter_yMantissa_5;
	reg [54:0] add_shifter_yMantissa_6;
	wire cmdArbiter_arbiter_io_chosenOH;
	wire cmdArbiter_arbiter_io_inputs_0_ready;
	wire [1:0] cmdArbiter_arbiter_io_output_payload_arg;
	wire cmdArbiter_arbiter_io_output_payload_format;
	wire [3:0] cmdArbiter_arbiter_io_output_payload_opcode;
	wire [4:0] cmdArbiter_arbiter_io_output_payload_rd;
	wire [2:0] cmdArbiter_arbiter_io_output_payload_roundMode;
	wire [4:0] cmdArbiter_arbiter_io_output_payload_rs1;
	wire [4:0] cmdArbiter_arbiter_io_output_payload_rs2;
	wire [4:0] cmdArbiter_arbiter_io_output_payload_rs3;
	wire cmdArbiter_arbiter_io_output_valid;
	wire [1:0] cmdArbiter_output_payload_arg;
	wire cmdArbiter_output_payload_format;
	wire [3:0] cmdArbiter_output_payload_opcode;
	wire [4:0] cmdArbiter_output_payload_rd;
	wire [2:0] cmdArbiter_output_payload_roundMode;
	wire [4:0] cmdArbiter_output_payload_rs1;
	wire [4:0] cmdArbiter_output_payload_rs2;
	wire [4:0] cmdArbiter_output_payload_rs3;
	wire cmdArbiter_output_ready;
	wire cmdArbiter_output_valid;
	wire [3:0] commitFork_commit_0_payload_opcode;
	wire [4:0] commitFork_commit_0_payload_rd;
	wire [63:0] commitFork_commit_0_payload_value;
	wire commitFork_commit_0_payload_write;
	wire commitFork_commit_0_ready;
	wire commitFork_commit_0_valid;
	wire [3:0] commitFork_load_0_payload_opcode;
	wire [4:0] commitFork_load_0_payload_rd;
	wire [63:0] commitFork_load_0_payload_value;
	wire commitFork_load_0_payload_write;
	reg commitFork_load_0_ready;
	wire commitFork_load_0_valid;
	reg [3:0] commitLogic_0_add_counter;
	reg commitLogic_0_add_dec;
	wire commitLogic_0_add_full;
	reg commitLogic_0_add_inc;
	wire commitLogic_0_add_notEmpty;
	reg [3:0] commitLogic_0_div_counter;
	reg commitLogic_0_div_dec;
	wire commitLogic_0_div_full;
	reg commitLogic_0_div_inc;
	wire commitLogic_0_div_notEmpty;
	wire [3:0] commitLogic_0_input_payload_opcode;
	wire [4:0] commitLogic_0_input_payload_rd;
	wire [63:0] commitLogic_0_input_payload_value;
	wire commitLogic_0_input_payload_write;
	wire commitLogic_0_input_valid;
	reg [3:0] commitLogic_0_mul_counter;
	reg commitLogic_0_mul_dec;
	wire commitLogic_0_mul_full;
	reg commitLogic_0_mul_inc;
	wire commitLogic_0_mul_notEmpty;
	reg [3:0] commitLogic_0_pending_counter;
	reg commitLogic_0_pending_dec;
	wire commitLogic_0_pending_full;
	reg commitLogic_0_pending_inc;
	wire commitLogic_0_pending_notEmpty;
	reg [3:0] commitLogic_0_short_counter;
	reg commitLogic_0_short_dec;
	wire commitLogic_0_short_full;
	reg commitLogic_0_short_inc;
	wire commitLogic_0_short_notEmpty;
	reg [3:0] commitLogic_0_sqrt_counter;
	reg commitLogic_0_sqrt_dec;
	wire commitLogic_0_sqrt_full;
	reg commitLogic_0_sqrt_inc;
	wire commitLogic_0_sqrt_notEmpty;
	wire decode_addHit;
	reg decode_add_payload_format;
	reg decode_add_payload_needCommit;
	reg [4:0] decode_add_payload_rd;
	reg [2:0] decode_add_payload_roundMode;
	reg [11:0] decode_add_payload_rs1_exponent;
	reg [53:0] decode_add_payload_rs1_mantissa;
	reg decode_add_payload_rs1_sign;
	reg decode_add_payload_rs1_special;
	reg [11:0] decode_add_payload_rs2_exponent;
	reg [53:0] decode_add_payload_rs2_mantissa;
	reg decode_add_payload_rs2_sign;
	reg decode_add_payload_rs2_special;
	wire decode_add_ready;
	wire decode_add_valid;
	wire decode_divHit;
	wire decode_divSqrtHit;
	wire decode_divSqrtToMul_payload_add;
	wire decode_divSqrtToMul_payload_divSqrt;
	wire decode_divSqrtToMul_payload_format;
	wire decode_divSqrtToMul_payload_msb1;
	wire decode_divSqrtToMul_payload_msb2;
	wire [4:0] decode_divSqrtToMul_payload_rd;
	wire [2:0] decode_divSqrtToMul_payload_roundMode;
	wire [11:0] decode_divSqrtToMul_payload_rs1_exponent;
	wire [51:0] decode_divSqrtToMul_payload_rs1_mantissa;
	wire decode_divSqrtToMul_payload_rs1_sign;
	wire decode_divSqrtToMul_payload_rs1_special;
	wire [11:0] decode_divSqrtToMul_payload_rs2_exponent;
	wire [51:0] decode_divSqrtToMul_payload_rs2_mantissa;
	wire decode_divSqrtToMul_payload_rs2_sign;
	wire decode_divSqrtToMul_payload_rs2_special;
	wire [11:0] decode_divSqrtToMul_payload_rs3_exponent;
	wire [51:0] decode_divSqrtToMul_payload_rs3_mantissa;
	wire decode_divSqrtToMul_payload_rs3_sign;
	wire decode_divSqrtToMul_payload_rs3_special;
	wire decode_divSqrtToMul_ready;
	wire decode_divSqrtToMul_valid;
	wire decode_divSqrt_payload_div;
	wire decode_divSqrt_payload_format;
	wire [4:0] decode_divSqrt_payload_rd;
	wire [2:0] decode_divSqrt_payload_roundMode;
	wire [11:0] decode_divSqrt_payload_rs1_exponent;
	wire [51:0] decode_divSqrt_payload_rs1_mantissa;
	wire decode_divSqrt_payload_rs1_sign;
	wire decode_divSqrt_payload_rs1_special;
	wire [11:0] decode_divSqrt_payload_rs2_exponent;
	wire [51:0] decode_divSqrt_payload_rs2_mantissa;
	wire decode_divSqrt_payload_rs2_sign;
	wire decode_divSqrt_payload_rs2_special;
	wire decode_divSqrt_ready;
	wire decode_divSqrt_valid;
	wire decode_div_payload_format;
	wire [4:0] decode_div_payload_rd;
	wire [2:0] decode_div_payload_roundMode;
	wire [11:0] decode_div_payload_rs1_exponent;
	wire [51:0] decode_div_payload_rs1_mantissa;
	wire decode_div_payload_rs1_sign;
	wire decode_div_payload_rs1_special;
	wire [11:0] decode_div_payload_rs2_exponent;
	wire [51:0] decode_div_payload_rs2_mantissa;
	wire decode_div_payload_rs2_sign;
	wire decode_div_payload_rs2_special;
	reg decode_div_rData_format;
	reg [4:0] decode_div_rData_rd;
	reg [2:0] decode_div_rData_roundMode;
	reg [11:0] decode_div_rData_rs1_exponent;
	reg [51:0] decode_div_rData_rs1_mantissa;
	reg decode_div_rData_rs1_sign;
	reg decode_div_rData_rs1_special;
	reg [11:0] decode_div_rData_rs2_exponent;
	reg [51:0] decode_div_rData_rs2_mantissa;
	reg decode_div_rData_rs2_sign;
	reg decode_div_rData_rs2_special;
	reg decode_div_rValid;
	wire decode_div_ready;
	wire decode_div_valid;
	wire decode_fmaHit;
	wire [1:0] decode_input_payload_arg;
	wire decode_input_payload_format;
	wire [3:0] decode_input_payload_opcode;
	wire [4:0] decode_input_payload_rd;
	wire [2:0] decode_input_payload_roundMode;
	wire decode_input_payload_rs1Boxed;
	wire [11:0] decode_input_payload_rs1_exponent;
	wire [51:0] decode_input_payload_rs1_mantissa;
	wire decode_input_payload_rs1_sign;
	wire decode_input_payload_rs1_special;
	wire decode_input_payload_rs2Boxed;
	wire [11:0] decode_input_payload_rs2_exponent;
	wire [51:0] decode_input_payload_rs2_mantissa;
	wire decode_input_payload_rs2_sign;
	wire decode_input_payload_rs2_special;
	wire [11:0] decode_input_payload_rs3_exponent;
	wire [51:0] decode_input_payload_rs3_mantissa;
	wire decode_input_payload_rs3_sign;
	wire decode_input_payload_rs3_special;
	reg decode_input_ready;
	wire decode_input_valid;
	wire decode_loadHit;
	wire [1:0] decode_load_payload_arg;
	wire decode_load_payload_format;
	wire decode_load_payload_i2f;
	wire [4:0] decode_load_payload_rd;
	wire [2:0] decode_load_payload_roundMode;
	reg [1:0] decode_load_rData_arg;
	reg decode_load_rData_format;
	reg decode_load_rData_i2f;
	reg [4:0] decode_load_rData_rd;
	reg [2:0] decode_load_rData_roundMode;
	reg decode_load_rValid;
	wire decode_load_ready;
	wire [1:0] decode_load_s2mPipe_m2sPipe_payload_arg;
	wire decode_load_s2mPipe_m2sPipe_payload_format;
	wire decode_load_s2mPipe_m2sPipe_payload_i2f;
	wire [4:0] decode_load_s2mPipe_m2sPipe_payload_rd;
	wire [2:0] decode_load_s2mPipe_m2sPipe_payload_roundMode;
	reg [1:0] decode_load_s2mPipe_m2sPipe_rData_arg;
	reg decode_load_s2mPipe_m2sPipe_rData_format;
	reg decode_load_s2mPipe_m2sPipe_rData_i2f;
	reg [4:0] decode_load_s2mPipe_m2sPipe_rData_rd;
	reg [2:0] decode_load_s2mPipe_m2sPipe_rData_roundMode;
	reg decode_load_s2mPipe_m2sPipe_rValid;
	reg decode_load_s2mPipe_m2sPipe_ready;
	wire decode_load_s2mPipe_m2sPipe_valid;
	wire [1:0] decode_load_s2mPipe_payload_arg;
	wire decode_load_s2mPipe_payload_format;
	wire decode_load_s2mPipe_payload_i2f;
	wire [4:0] decode_load_s2mPipe_payload_rd;
	wire [2:0] decode_load_s2mPipe_payload_roundMode;
	reg [1:0] decode_load_s2mPipe_rData_arg;
	reg decode_load_s2mPipe_rData_format;
	reg decode_load_s2mPipe_rData_i2f;
	reg [4:0] decode_load_s2mPipe_rData_rd;
	reg [2:0] decode_load_s2mPipe_rData_roundMode;
	reg decode_load_s2mPipe_rValid;
	reg decode_load_s2mPipe_ready;
	wire decode_load_s2mPipe_valid;
	wire decode_load_valid;
	wire decode_mulHit;
	wire decode_mulToAdd_payload_format;
	wire decode_mulToAdd_payload_needCommit;
	wire [4:0] decode_mulToAdd_payload_rd;
	wire [2:0] decode_mulToAdd_payload_roundMode;
	wire [11:0] decode_mulToAdd_payload_rs1_exponent;
	wire [53:0] decode_mulToAdd_payload_rs1_mantissa;
	wire decode_mulToAdd_payload_rs1_sign;
	wire decode_mulToAdd_payload_rs1_special;
	wire [11:0] decode_mulToAdd_payload_rs2_exponent;
	wire [53:0] decode_mulToAdd_payload_rs2_mantissa;
	wire decode_mulToAdd_payload_rs2_sign;
	wire decode_mulToAdd_payload_rs2_special;
	wire decode_mulToAdd_ready;
	wire decode_mulToAdd_valid;
	reg decode_mul_payload_add;
	reg decode_mul_payload_divSqrt;
	reg decode_mul_payload_format;
	reg decode_mul_payload_msb1;
	reg decode_mul_payload_msb2;
	reg [4:0] decode_mul_payload_rd;
	reg [2:0] decode_mul_payload_roundMode;
	reg [11:0] decode_mul_payload_rs1_exponent;
	reg [51:0] decode_mul_payload_rs1_mantissa;
	reg decode_mul_payload_rs1_sign;
	reg decode_mul_payload_rs1_special;
	reg [11:0] decode_mul_payload_rs2_exponent;
	reg [51:0] decode_mul_payload_rs2_mantissa;
	reg decode_mul_payload_rs2_sign;
	reg decode_mul_payload_rs2_special;
	reg [11:0] decode_mul_payload_rs3_exponent;
	reg [51:0] decode_mul_payload_rs3_mantissa;
	reg decode_mul_payload_rs3_sign;
	reg decode_mul_payload_rs3_special;
	reg decode_mul_rData_add;
	reg decode_mul_rData_divSqrt;
	reg decode_mul_rData_format;
	reg decode_mul_rData_msb1;
	reg decode_mul_rData_msb2;
	reg [4:0] decode_mul_rData_rd;
	reg [2:0] decode_mul_rData_roundMode;
	reg [11:0] decode_mul_rData_rs1_exponent;
	reg [51:0] decode_mul_rData_rs1_mantissa;
	reg decode_mul_rData_rs1_sign;
	reg decode_mul_rData_rs1_special;
	reg [11:0] decode_mul_rData_rs2_exponent;
	reg [51:0] decode_mul_rData_rs2_mantissa;
	reg decode_mul_rData_rs2_sign;
	reg decode_mul_rData_rs2_special;
	reg [11:0] decode_mul_rData_rs3_exponent;
	reg [51:0] decode_mul_rData_rs3_mantissa;
	reg decode_mul_rData_rs3_sign;
	reg decode_mul_rData_rs3_special;
	reg decode_mul_rValid;
	reg decode_mul_ready;
	wire decode_mul_valid;
	wire decode_shortPipHit;
	wire [1:0] decode_shortPip_payload_arg;
	wire decode_shortPip_payload_format;
	wire [3:0] decode_shortPip_payload_opcode;
	wire [4:0] decode_shortPip_payload_rd;
	wire [2:0] decode_shortPip_payload_roundMode;
	wire decode_shortPip_payload_rs1Boxed;
	wire [11:0] decode_shortPip_payload_rs1_exponent;
	wire [51:0] decode_shortPip_payload_rs1_mantissa;
	wire decode_shortPip_payload_rs1_sign;
	wire decode_shortPip_payload_rs1_special;
	wire decode_shortPip_payload_rs2Boxed;
	wire [11:0] decode_shortPip_payload_rs2_exponent;
	wire [51:0] decode_shortPip_payload_rs2_mantissa;
	wire decode_shortPip_payload_rs2_sign;
	wire decode_shortPip_payload_rs2_special;
	wire [31:0] decode_shortPip_payload_value;
	reg [1:0] decode_shortPip_rData_arg;
	reg decode_shortPip_rData_format;
	reg [3:0] decode_shortPip_rData_opcode;
	reg [4:0] decode_shortPip_rData_rd;
	reg [2:0] decode_shortPip_rData_roundMode;
	reg decode_shortPip_rData_rs1Boxed;
	reg [11:0] decode_shortPip_rData_rs1_exponent;
	reg [51:0] decode_shortPip_rData_rs1_mantissa;
	reg decode_shortPip_rData_rs1_sign;
	reg decode_shortPip_rData_rs1_special;
	reg decode_shortPip_rData_rs2Boxed;
	reg [11:0] decode_shortPip_rData_rs2_exponent;
	reg [51:0] decode_shortPip_rData_rs2_mantissa;
	reg decode_shortPip_rData_rs2_sign;
	reg decode_shortPip_rData_rs2_special;
	reg [31:0] decode_shortPip_rData_value;
	reg decode_shortPip_rValid;
	reg decode_shortPip_ready;
	wire decode_shortPip_valid;
	wire decode_sqrtHit;
	wire decode_sqrt_payload_format;
	wire [4:0] decode_sqrt_payload_rd;
	wire [2:0] decode_sqrt_payload_roundMode;
	wire [11:0] decode_sqrt_payload_rs1_exponent;
	wire [51:0] decode_sqrt_payload_rs1_mantissa;
	wire decode_sqrt_payload_rs1_sign;
	wire decode_sqrt_payload_rs1_special;
	reg decode_sqrt_rData_format;
	reg [4:0] decode_sqrt_rData_rd;
	reg [2:0] decode_sqrt_rData_roundMode;
	reg [11:0] decode_sqrt_rData_rs1_exponent;
	reg [51:0] decode_sqrt_rData_rs1_mantissa;
	reg decode_sqrt_rData_rs1_sign;
	reg decode_sqrt_rData_rs1_special;
	reg decode_sqrt_rValid;
	wire decode_sqrt_ready;
	wire decode_sqrt_valid;
	reg div_cmdSent;
	wire [54:0] div_dividerResult;
	wire div_dividerScrap;
	wire div_divider_io_input_ready;
	wire div_divider_io_input_valid;
	wire [52:0] div_divider_io_output_payload_remain;
	wire [54:0] div_divider_io_output_payload_result;
	wire div_divider_io_output_valid;
	wire [13:0] div_exponent;
	wire div_forceNan;
	wire div_forceOverflow;
	wire div_forceUnderflow;
	wire div_forceZero;
	reg div_haltIt;
	wire div_infinitynan;
	wire div_input_fire;
	wire div_input_fire_1;
	wire div_input_payload_format;
	wire [4:0] div_input_payload_rd;
	wire [2:0] div_input_payload_roundMode;
	wire [11:0] div_input_payload_rs1_exponent;
	wire [51:0] div_input_payload_rs1_mantissa;
	wire div_input_payload_rs1_sign;
	wire div_input_payload_rs1_special;
	wire [11:0] div_input_payload_rs2_exponent;
	wire [51:0] div_input_payload_rs2_mantissa;
	wire div_input_payload_rs2_sign;
	wire div_input_payload_rs2_special;
	wire div_input_ready;
	wire div_input_valid;
	reg div_isCommited;
	wire [52:0] div_mantissa;
	wire div_needShift;
	wire div_output_payload_DZ;
	reg div_output_payload_NV;
	wire div_output_payload_format;
	wire [4:0] div_output_payload_rd;
	wire [2:0] div_output_payload_roundMode;
	wire div_output_payload_scrap;
	reg [11:0] div_output_payload_value_exponent;
	reg [52:0] div_output_payload_value_mantissa;
	wire div_output_payload_value_sign;
	reg div_output_payload_value_special;
	wire div_output_ready;
	wire div_output_valid;
	wire div_scrap;
	wire [13:0] div_underflowExp;
	wire [13:0] div_underflowThreshold;
	reg [1:0] io_port_0_cmd_rData_arg;
	reg io_port_0_cmd_rData_format;
	reg [3:0] io_port_0_cmd_rData_opcode;
	reg [4:0] io_port_0_cmd_rData_rd;
	reg [2:0] io_port_0_cmd_rData_roundMode;
	reg [4:0] io_port_0_cmd_rData_rs1;
	reg [4:0] io_port_0_cmd_rData_rs2;
	reg [4:0] io_port_0_cmd_rData_rs3;
	reg io_port_0_cmd_rValid;
	wire [3:0] load_s0_filtred_0_payload_opcode;
	wire [4:0] load_s0_filtred_0_payload_rd;
	wire [63:0] load_s0_filtred_0_payload_value;
	wire load_s0_filtred_0_payload_write;
	reg load_s0_filtred_0_ready;
	reg load_s0_filtred_0_valid;
	wire load_s0_hazard;
	wire [1:0] load_s0_input_payload_arg;
	wire load_s0_input_payload_format;
	wire load_s0_input_payload_i2f;
	wire [4:0] load_s0_input_payload_rd;
	wire [2:0] load_s0_input_payload_roundMode;
	wire load_s0_input_ready;
	wire load_s0_input_valid;
	wire [1:0] load_s0_output_payload_arg;
	reg load_s0_output_payload_format;
	wire load_s0_output_payload_i2f;
	wire [4:0] load_s0_output_payload_rd;
	wire [2:0] load_s0_output_payload_roundMode;
	wire [63:0] load_s0_output_payload_value;
	reg [1:0] load_s0_output_rData_arg;
	reg load_s0_output_rData_format;
	reg load_s0_output_rData_i2f;
	reg [4:0] load_s0_output_rData_rd;
	reg [2:0] load_s0_output_rData_roundMode;
	reg [63:0] load_s0_output_rData_value;
	reg load_s0_output_rValid;
	reg load_s0_output_ready;
	wire load_s0_output_valid;
	reg load_s1_busy;
	reg load_s1_expOne;
	reg load_s1_expZero;
	wire [7:0] load_s1_f32_exponent;
	wire [22:0] load_s1_f32_mantissa;
	wire load_s1_f32_sign;
	wire [10:0] load_s1_f64_exponent;
	wire [51:0] load_s1_f64_mantissa;
	wire load_s1_f64_sign;
	reg load_s1_fsm_boot;
	reg load_s1_fsm_done;
	reg [11:0] load_s1_fsm_expOffset;
	reg load_s1_fsm_i2fZero;
	reg [51:0] load_s1_fsm_ohInput;
	reg load_s1_fsm_patched;
	reg [5:0] load_s1_fsm_shift_by;
	reg [51:0] load_s1_fsm_shift_input;
	reg [51:0] load_s1_fsm_shift_input_1;
	reg [51:0] load_s1_fsm_shift_input_2;
	reg [51:0] load_s1_fsm_shift_input_3;
	reg [51:0] load_s1_fsm_shift_input_4;
	reg [51:0] load_s1_fsm_shift_input_5;
	reg [51:0] load_s1_fsm_shift_input_6;
	reg [51:0] load_s1_fsm_shift_output;
	wire [51:0] load_s1_i2fHigh;
	wire load_s1_input_isStall;
	wire [1:0] load_s1_input_payload_arg;
	wire load_s1_input_payload_format;
	wire load_s1_input_payload_i2f;
	wire [4:0] load_s1_input_payload_rd;
	wire [2:0] load_s1_input_payload_roundMode;
	wire [63:0] load_s1_input_payload_value;
	wire load_s1_input_ready;
	wire load_s1_input_valid;
	wire load_s1_isInfinity;
	wire load_s1_isNan;
	wire load_s1_isSubnormal;
	wire load_s1_isZero;
	wire load_s1_manZero;
	wire load_s1_output_m2sPipe_payload_DZ;
	wire load_s1_output_m2sPipe_payload_NV;
	wire load_s1_output_m2sPipe_payload_format;
	wire [4:0] load_s1_output_m2sPipe_payload_rd;
	wire [2:0] load_s1_output_m2sPipe_payload_roundMode;
	wire load_s1_output_m2sPipe_payload_scrap;
	wire [11:0] load_s1_output_m2sPipe_payload_value_exponent;
	wire [52:0] load_s1_output_m2sPipe_payload_value_mantissa;
	wire load_s1_output_m2sPipe_payload_value_sign;
	wire load_s1_output_m2sPipe_payload_value_special;
	wire load_s1_output_m2sPipe_ready;
	wire load_s1_output_m2sPipe_valid;
	wire load_s1_output_payload_DZ;
	wire load_s1_output_payload_NV;
	wire load_s1_output_payload_format;
	wire [4:0] load_s1_output_payload_rd;
	wire [2:0] load_s1_output_payload_roundMode;
	reg load_s1_output_payload_scrap;
	reg [11:0] load_s1_output_payload_value_exponent;
	reg [52:0] load_s1_output_payload_value_mantissa;
	reg load_s1_output_payload_value_sign;
	reg load_s1_output_payload_value_special;
	reg load_s1_output_rData_DZ;
	reg load_s1_output_rData_NV;
	reg load_s1_output_rData_format;
	reg [4:0] load_s1_output_rData_rd;
	reg [2:0] load_s1_output_rData_roundMode;
	reg load_s1_output_rData_scrap;
	reg [11:0] load_s1_output_rData_value_exponent;
	reg [52:0] load_s1_output_rData_value_mantissa;
	reg load_s1_output_rData_value_sign;
	reg load_s1_output_rData_value_special;
	reg load_s1_output_rValid;
	reg load_s1_output_ready;
	wire load_s1_output_valid;
	reg [11:0] load_s1_passThroughFloat_exponent;
	reg [51:0] load_s1_passThroughFloat_mantissa;
	reg load_s1_passThroughFloat_sign;
	wire load_s1_passThroughFloat_special;
	reg [11:0] load_s1_recodedExpOffset;
	reg [11:0] load_s1_recoded_exponent;
	wire [51:0] load_s1_recoded_mantissa;
	wire load_s1_recoded_sign;
	reg load_s1_recoded_special;
	wire load_s1_scrap;
	wire merge_arbitrated_payload_DZ;
	wire merge_arbitrated_payload_NV;
	wire merge_arbitrated_payload_format;
	wire [4:0] merge_arbitrated_payload_rd;
	wire [2:0] merge_arbitrated_payload_roundMode;
	wire merge_arbitrated_payload_scrap;
	wire [11:0] merge_arbitrated_payload_value_exponent;
	wire [52:0] merge_arbitrated_payload_value_mantissa;
	wire merge_arbitrated_payload_value_sign;
	wire merge_arbitrated_payload_value_special;
	wire merge_arbitrated_valid;
	wire mul_mul_input_payload_add;
	wire mul_mul_input_payload_divSqrt;
	wire [12:0] mul_mul_input_payload_exp;
	wire mul_mul_input_payload_format;
	wire mul_mul_input_payload_msb1;
	wire mul_mul_input_payload_msb2;
	wire [4:0] mul_mul_input_payload_rd;
	wire [2:0] mul_mul_input_payload_roundMode;
	wire [11:0] mul_mul_input_payload_rs1_exponent;
	wire [51:0] mul_mul_input_payload_rs1_mantissa;
	wire mul_mul_input_payload_rs1_sign;
	wire mul_mul_input_payload_rs1_special;
	wire [11:0] mul_mul_input_payload_rs2_exponent;
	wire [51:0] mul_mul_input_payload_rs2_mantissa;
	wire mul_mul_input_payload_rs2_sign;
	wire mul_mul_input_payload_rs2_special;
	wire [11:0] mul_mul_input_payload_rs3_exponent;
	wire [51:0] mul_mul_input_payload_rs3_mantissa;
	wire mul_mul_input_payload_rs3_sign;
	wire mul_mul_input_payload_rs3_special;
	wire mul_mul_input_ready;
	wire mul_mul_input_valid;
	wire [52:0] mul_mul_mulA;
	wire [52:0] mul_mul_mulB;
	wire mul_mul_output_payload_add;
	wire mul_mul_output_payload_divSqrt;
	wire [12:0] mul_mul_output_payload_exp;
	wire mul_mul_output_payload_format;
	wire mul_mul_output_payload_msb1;
	wire mul_mul_output_payload_msb2;
	wire [35:0] mul_mul_output_payload_muls_0;
	wire [35:0] mul_mul_output_payload_muls_1;
	wire [35:0] mul_mul_output_payload_muls_2;
	wire [34:0] mul_mul_output_payload_muls_3;
	wire [34:0] mul_mul_output_payload_muls_4;
	wire [35:0] mul_mul_output_payload_muls_5;
	wire [34:0] mul_mul_output_payload_muls_6;
	wire [34:0] mul_mul_output_payload_muls_7;
	wire [33:0] mul_mul_output_payload_muls_8;
	wire [4:0] mul_mul_output_payload_rd;
	wire [2:0] mul_mul_output_payload_roundMode;
	wire [11:0] mul_mul_output_payload_rs1_exponent;
	wire [51:0] mul_mul_output_payload_rs1_mantissa;
	wire mul_mul_output_payload_rs1_sign;
	wire mul_mul_output_payload_rs1_special;
	wire [11:0] mul_mul_output_payload_rs2_exponent;
	wire [51:0] mul_mul_output_payload_rs2_mantissa;
	wire mul_mul_output_payload_rs2_sign;
	wire mul_mul_output_payload_rs2_special;
	wire [11:0] mul_mul_output_payload_rs3_exponent;
	wire [51:0] mul_mul_output_payload_rs3_mantissa;
	wire mul_mul_output_payload_rs3_sign;
	wire mul_mul_output_payload_rs3_special;
	reg mul_mul_output_rData_add;
	reg mul_mul_output_rData_divSqrt;
	reg [12:0] mul_mul_output_rData_exp;
	reg mul_mul_output_rData_format;
	reg mul_mul_output_rData_msb1;
	reg mul_mul_output_rData_msb2;
	reg [35:0] mul_mul_output_rData_muls_0;
	reg [35:0] mul_mul_output_rData_muls_1;
	reg [35:0] mul_mul_output_rData_muls_2;
	reg [34:0] mul_mul_output_rData_muls_3;
	reg [34:0] mul_mul_output_rData_muls_4;
	reg [35:0] mul_mul_output_rData_muls_5;
	reg [34:0] mul_mul_output_rData_muls_6;
	reg [34:0] mul_mul_output_rData_muls_7;
	reg [33:0] mul_mul_output_rData_muls_8;
	reg [4:0] mul_mul_output_rData_rd;
	reg [2:0] mul_mul_output_rData_roundMode;
	reg [11:0] mul_mul_output_rData_rs1_exponent;
	reg [51:0] mul_mul_output_rData_rs1_mantissa;
	reg mul_mul_output_rData_rs1_sign;
	reg mul_mul_output_rData_rs1_special;
	reg [11:0] mul_mul_output_rData_rs2_exponent;
	reg [51:0] mul_mul_output_rData_rs2_mantissa;
	reg mul_mul_output_rData_rs2_sign;
	reg mul_mul_output_rData_rs2_special;
	reg [11:0] mul_mul_output_rData_rs3_exponent;
	reg [51:0] mul_mul_output_rData_rs3_mantissa;
	reg mul_mul_output_rData_rs3_sign;
	reg mul_mul_output_rData_rs3_special;
	reg mul_mul_output_rValid;
	reg mul_mul_output_ready;
	wire mul_mul_output_valid;
	reg mul_norm_NV;
	wire [12:0] mul_norm_exp;
	wire mul_norm_forceNan;
	wire mul_norm_forceOverflow;
	wire mul_norm_forceUnderflow;
	wire mul_norm_forceZero;
	wire mul_norm_infinitynan;
	wire mul_norm_input_payload_add;
	wire mul_norm_input_payload_divSqrt;
	wire [12:0] mul_norm_input_payload_exp;
	wire mul_norm_input_payload_format;
	wire mul_norm_input_payload_msb1;
	wire mul_norm_input_payload_msb2;
	wire [105:0] mul_norm_input_payload_mulC;
	wire [4:0] mul_norm_input_payload_rd;
	wire [2:0] mul_norm_input_payload_roundMode;
	wire [11:0] mul_norm_input_payload_rs1_exponent;
	wire [51:0] mul_norm_input_payload_rs1_mantissa;
	wire mul_norm_input_payload_rs1_sign;
	wire mul_norm_input_payload_rs1_special;
	wire [11:0] mul_norm_input_payload_rs2_exponent;
	wire [51:0] mul_norm_input_payload_rs2_mantissa;
	wire mul_norm_input_payload_rs2_sign;
	wire mul_norm_input_payload_rs2_special;
	wire [11:0] mul_norm_input_payload_rs3_exponent;
	wire [51:0] mul_norm_input_payload_rs3_mantissa;
	wire mul_norm_input_payload_rs3_sign;
	wire mul_norm_input_payload_rs3_special;
	wire mul_norm_input_ready;
	wire mul_norm_input_valid;
	wire [52:0] mul_norm_man;
	wire [54:0] mul_norm_mulHigh;
	wire [50:0] mul_norm_mulLow;
	wire mul_norm_needShift;
	reg [11:0] mul_norm_output_exponent;
	reg [52:0] mul_norm_output_mantissa;
	wire mul_norm_output_sign;
	reg mul_norm_output_special;
	reg mul_norm_scrap;
	wire [10:0] mul_norm_underflowExp;
	wire [11:0] mul_norm_underflowThreshold;
	wire mul_preMul_input_payload_add;
	wire mul_preMul_input_payload_divSqrt;
	wire mul_preMul_input_payload_format;
	wire mul_preMul_input_payload_msb1;
	wire mul_preMul_input_payload_msb2;
	wire [4:0] mul_preMul_input_payload_rd;
	wire [2:0] mul_preMul_input_payload_roundMode;
	wire [11:0] mul_preMul_input_payload_rs1_exponent;
	wire [51:0] mul_preMul_input_payload_rs1_mantissa;
	wire mul_preMul_input_payload_rs1_sign;
	wire mul_preMul_input_payload_rs1_special;
	wire [11:0] mul_preMul_input_payload_rs2_exponent;
	wire [51:0] mul_preMul_input_payload_rs2_mantissa;
	wire mul_preMul_input_payload_rs2_sign;
	wire mul_preMul_input_payload_rs2_special;
	wire [11:0] mul_preMul_input_payload_rs3_exponent;
	wire [51:0] mul_preMul_input_payload_rs3_mantissa;
	wire mul_preMul_input_payload_rs3_sign;
	wire mul_preMul_input_payload_rs3_special;
	wire mul_preMul_input_ready;
	wire mul_preMul_input_valid;
	wire mul_preMul_output_payload_add;
	wire mul_preMul_output_payload_divSqrt;
	wire [12:0] mul_preMul_output_payload_exp;
	wire mul_preMul_output_payload_format;
	wire mul_preMul_output_payload_msb1;
	wire mul_preMul_output_payload_msb2;
	wire [4:0] mul_preMul_output_payload_rd;
	wire [2:0] mul_preMul_output_payload_roundMode;
	wire [11:0] mul_preMul_output_payload_rs1_exponent;
	wire [51:0] mul_preMul_output_payload_rs1_mantissa;
	wire mul_preMul_output_payload_rs1_sign;
	wire mul_preMul_output_payload_rs1_special;
	wire [11:0] mul_preMul_output_payload_rs2_exponent;
	wire [51:0] mul_preMul_output_payload_rs2_mantissa;
	wire mul_preMul_output_payload_rs2_sign;
	wire mul_preMul_output_payload_rs2_special;
	wire [11:0] mul_preMul_output_payload_rs3_exponent;
	wire [51:0] mul_preMul_output_payload_rs3_mantissa;
	wire mul_preMul_output_payload_rs3_sign;
	wire mul_preMul_output_payload_rs3_special;
	reg mul_preMul_output_rData_add;
	reg mul_preMul_output_rData_divSqrt;
	reg [12:0] mul_preMul_output_rData_exp;
	reg mul_preMul_output_rData_format;
	reg mul_preMul_output_rData_msb1;
	reg mul_preMul_output_rData_msb2;
	reg [4:0] mul_preMul_output_rData_rd;
	reg [2:0] mul_preMul_output_rData_roundMode;
	reg [11:0] mul_preMul_output_rData_rs1_exponent;
	reg [51:0] mul_preMul_output_rData_rs1_mantissa;
	reg mul_preMul_output_rData_rs1_sign;
	reg mul_preMul_output_rData_rs1_special;
	reg [11:0] mul_preMul_output_rData_rs2_exponent;
	reg [51:0] mul_preMul_output_rData_rs2_mantissa;
	reg mul_preMul_output_rData_rs2_sign;
	reg mul_preMul_output_rData_rs2_special;
	reg [11:0] mul_preMul_output_rData_rs3_exponent;
	reg [51:0] mul_preMul_output_rData_rs3_mantissa;
	reg mul_preMul_output_rData_rs3_sign;
	reg mul_preMul_output_rData_rs3_special;
	reg mul_preMul_output_rValid;
	reg mul_preMul_output_ready;
	wire mul_preMul_output_valid;
	wire mul_result_mulToAdd_m2sPipe_payload_format;
	wire mul_result_mulToAdd_m2sPipe_payload_needCommit;
	wire [4:0] mul_result_mulToAdd_m2sPipe_payload_rd;
	wire [2:0] mul_result_mulToAdd_m2sPipe_payload_roundMode;
	wire [11:0] mul_result_mulToAdd_m2sPipe_payload_rs1_exponent;
	wire [53:0] mul_result_mulToAdd_m2sPipe_payload_rs1_mantissa;
	wire mul_result_mulToAdd_m2sPipe_payload_rs1_sign;
	wire mul_result_mulToAdd_m2sPipe_payload_rs1_special;
	wire [11:0] mul_result_mulToAdd_m2sPipe_payload_rs2_exponent;
	wire [53:0] mul_result_mulToAdd_m2sPipe_payload_rs2_mantissa;
	wire mul_result_mulToAdd_m2sPipe_payload_rs2_sign;
	wire mul_result_mulToAdd_m2sPipe_payload_rs2_special;
	wire mul_result_mulToAdd_m2sPipe_ready;
	wire mul_result_mulToAdd_m2sPipe_valid;
	wire mul_result_mulToAdd_payload_format;
	wire mul_result_mulToAdd_payload_needCommit;
	wire [4:0] mul_result_mulToAdd_payload_rd;
	wire [2:0] mul_result_mulToAdd_payload_roundMode;
	wire [11:0] mul_result_mulToAdd_payload_rs1_exponent;
	reg [53:0] mul_result_mulToAdd_payload_rs1_mantissa;
	wire mul_result_mulToAdd_payload_rs1_sign;
	wire mul_result_mulToAdd_payload_rs1_special;
	wire [11:0] mul_result_mulToAdd_payload_rs2_exponent;
	wire [53:0] mul_result_mulToAdd_payload_rs2_mantissa;
	wire mul_result_mulToAdd_payload_rs2_sign;
	wire mul_result_mulToAdd_payload_rs2_special;
	reg mul_result_mulToAdd_rData_format;
	reg mul_result_mulToAdd_rData_needCommit;
	reg [4:0] mul_result_mulToAdd_rData_rd;
	reg [2:0] mul_result_mulToAdd_rData_roundMode;
	reg [11:0] mul_result_mulToAdd_rData_rs1_exponent;
	reg [53:0] mul_result_mulToAdd_rData_rs1_mantissa;
	reg mul_result_mulToAdd_rData_rs1_sign;
	reg mul_result_mulToAdd_rData_rs1_special;
	reg [11:0] mul_result_mulToAdd_rData_rs2_exponent;
	reg [53:0] mul_result_mulToAdd_rData_rs2_mantissa;
	reg mul_result_mulToAdd_rData_rs2_sign;
	reg mul_result_mulToAdd_rData_rs2_special;
	reg mul_result_mulToAdd_rValid;
	reg mul_result_mulToAdd_ready;
	wire mul_result_mulToAdd_valid;
	wire [52:0] mul_result_notMul_output_payload;
	wire mul_result_notMul_output_valid;
	wire mul_result_output_payload_DZ;
	wire mul_result_output_payload_NV;
	wire mul_result_output_payload_format;
	wire [4:0] mul_result_output_payload_rd;
	wire [2:0] mul_result_output_payload_roundMode;
	wire mul_result_output_payload_scrap;
	wire [11:0] mul_result_output_payload_value_exponent;
	wire [52:0] mul_result_output_payload_value_mantissa;
	wire mul_result_output_payload_value_sign;
	wire mul_result_output_payload_value_special;
	wire mul_result_output_ready;
	wire mul_result_output_valid;
	wire mul_sum1_input_payload_add;
	wire mul_sum1_input_payload_divSqrt;
	wire [12:0] mul_sum1_input_payload_exp;
	wire mul_sum1_input_payload_format;
	wire mul_sum1_input_payload_msb1;
	wire mul_sum1_input_payload_msb2;
	wire [35:0] mul_sum1_input_payload_muls_0;
	wire [35:0] mul_sum1_input_payload_muls_1;
	wire [35:0] mul_sum1_input_payload_muls_2;
	wire [34:0] mul_sum1_input_payload_muls_3;
	wire [34:0] mul_sum1_input_payload_muls_4;
	wire [35:0] mul_sum1_input_payload_muls_5;
	wire [34:0] mul_sum1_input_payload_muls_6;
	wire [34:0] mul_sum1_input_payload_muls_7;
	wire [33:0] mul_sum1_input_payload_muls_8;
	wire [4:0] mul_sum1_input_payload_rd;
	wire [2:0] mul_sum1_input_payload_roundMode;
	wire [11:0] mul_sum1_input_payload_rs1_exponent;
	wire [51:0] mul_sum1_input_payload_rs1_mantissa;
	wire mul_sum1_input_payload_rs1_sign;
	wire mul_sum1_input_payload_rs1_special;
	wire [11:0] mul_sum1_input_payload_rs2_exponent;
	wire [51:0] mul_sum1_input_payload_rs2_mantissa;
	wire mul_sum1_input_payload_rs2_sign;
	wire mul_sum1_input_payload_rs2_special;
	wire [11:0] mul_sum1_input_payload_rs3_exponent;
	wire [51:0] mul_sum1_input_payload_rs3_mantissa;
	wire mul_sum1_input_payload_rs3_sign;
	wire mul_sum1_input_payload_rs3_special;
	wire mul_sum1_input_ready;
	wire mul_sum1_input_valid;
	wire mul_sum1_output_payload_add;
	wire mul_sum1_output_payload_divSqrt;
	wire [12:0] mul_sum1_output_payload_exp;
	wire mul_sum1_output_payload_format;
	wire mul_sum1_output_payload_msb1;
	wire mul_sum1_output_payload_msb2;
	wire [105:0] mul_sum1_output_payload_mulC2;
	wire [34:0] mul_sum1_output_payload_muls2_0;
	wire [35:0] mul_sum1_output_payload_muls2_1;
	wire [34:0] mul_sum1_output_payload_muls2_2;
	wire [34:0] mul_sum1_output_payload_muls2_3;
	wire [33:0] mul_sum1_output_payload_muls2_4;
	wire [4:0] mul_sum1_output_payload_rd;
	wire [2:0] mul_sum1_output_payload_roundMode;
	wire [11:0] mul_sum1_output_payload_rs1_exponent;
	wire [51:0] mul_sum1_output_payload_rs1_mantissa;
	wire mul_sum1_output_payload_rs1_sign;
	wire mul_sum1_output_payload_rs1_special;
	wire [11:0] mul_sum1_output_payload_rs2_exponent;
	wire [51:0] mul_sum1_output_payload_rs2_mantissa;
	wire mul_sum1_output_payload_rs2_sign;
	wire mul_sum1_output_payload_rs2_special;
	wire [11:0] mul_sum1_output_payload_rs3_exponent;
	wire [51:0] mul_sum1_output_payload_rs3_mantissa;
	wire mul_sum1_output_payload_rs3_sign;
	wire mul_sum1_output_payload_rs3_special;
	reg mul_sum1_output_rData_add;
	reg mul_sum1_output_rData_divSqrt;
	reg [12:0] mul_sum1_output_rData_exp;
	reg mul_sum1_output_rData_format;
	reg mul_sum1_output_rData_msb1;
	reg mul_sum1_output_rData_msb2;
	reg [105:0] mul_sum1_output_rData_mulC2;
	reg [34:0] mul_sum1_output_rData_muls2_0;
	reg [35:0] mul_sum1_output_rData_muls2_1;
	reg [34:0] mul_sum1_output_rData_muls2_2;
	reg [34:0] mul_sum1_output_rData_muls2_3;
	reg [33:0] mul_sum1_output_rData_muls2_4;
	reg [4:0] mul_sum1_output_rData_rd;
	reg [2:0] mul_sum1_output_rData_roundMode;
	reg [11:0] mul_sum1_output_rData_rs1_exponent;
	reg [51:0] mul_sum1_output_rData_rs1_mantissa;
	reg mul_sum1_output_rData_rs1_sign;
	reg mul_sum1_output_rData_rs1_special;
	reg [11:0] mul_sum1_output_rData_rs2_exponent;
	reg [51:0] mul_sum1_output_rData_rs2_mantissa;
	reg mul_sum1_output_rData_rs2_sign;
	reg mul_sum1_output_rData_rs2_special;
	reg [11:0] mul_sum1_output_rData_rs3_exponent;
	reg [51:0] mul_sum1_output_rData_rs3_mantissa;
	reg mul_sum1_output_rData_rs3_sign;
	reg mul_sum1_output_rData_rs3_special;
	reg mul_sum1_output_rValid;
	reg mul_sum1_output_ready;
	wire mul_sum1_output_valid;
	wire [105:0] mul_sum1_sum;
	wire mul_sum2_input_fire;
	wire mul_sum2_input_payload_add;
	wire mul_sum2_input_payload_divSqrt;
	wire [12:0] mul_sum2_input_payload_exp;
	wire mul_sum2_input_payload_format;
	wire mul_sum2_input_payload_msb1;
	wire mul_sum2_input_payload_msb2;
	wire [105:0] mul_sum2_input_payload_mulC2;
	wire [34:0] mul_sum2_input_payload_muls2_0;
	wire [35:0] mul_sum2_input_payload_muls2_1;
	wire [34:0] mul_sum2_input_payload_muls2_2;
	wire [34:0] mul_sum2_input_payload_muls2_3;
	wire [33:0] mul_sum2_input_payload_muls2_4;
	wire [4:0] mul_sum2_input_payload_rd;
	wire [2:0] mul_sum2_input_payload_roundMode;
	wire [11:0] mul_sum2_input_payload_rs1_exponent;
	wire [51:0] mul_sum2_input_payload_rs1_mantissa;
	wire mul_sum2_input_payload_rs1_sign;
	wire mul_sum2_input_payload_rs1_special;
	wire [11:0] mul_sum2_input_payload_rs2_exponent;
	wire [51:0] mul_sum2_input_payload_rs2_mantissa;
	wire mul_sum2_input_payload_rs2_sign;
	wire mul_sum2_input_payload_rs2_special;
	wire [11:0] mul_sum2_input_payload_rs3_exponent;
	wire [51:0] mul_sum2_input_payload_rs3_mantissa;
	wire mul_sum2_input_payload_rs3_sign;
	wire mul_sum2_input_payload_rs3_special;
	wire mul_sum2_input_ready;
	wire mul_sum2_input_valid;
	wire mul_sum2_isCommited;
	wire mul_sum2_output_payload_add;
	wire mul_sum2_output_payload_divSqrt;
	wire [12:0] mul_sum2_output_payload_exp;
	wire mul_sum2_output_payload_format;
	wire mul_sum2_output_payload_msb1;
	wire mul_sum2_output_payload_msb2;
	wire [105:0] mul_sum2_output_payload_mulC;
	wire [4:0] mul_sum2_output_payload_rd;
	wire [2:0] mul_sum2_output_payload_roundMode;
	wire [11:0] mul_sum2_output_payload_rs1_exponent;
	wire [51:0] mul_sum2_output_payload_rs1_mantissa;
	wire mul_sum2_output_payload_rs1_sign;
	wire mul_sum2_output_payload_rs1_special;
	wire [11:0] mul_sum2_output_payload_rs2_exponent;
	wire [51:0] mul_sum2_output_payload_rs2_mantissa;
	wire mul_sum2_output_payload_rs2_sign;
	wire mul_sum2_output_payload_rs2_special;
	wire [11:0] mul_sum2_output_payload_rs3_exponent;
	wire [51:0] mul_sum2_output_payload_rs3_mantissa;
	wire mul_sum2_output_payload_rs3_sign;
	wire mul_sum2_output_payload_rs3_special;
	reg mul_sum2_output_rData_add;
	reg mul_sum2_output_rData_divSqrt;
	reg [12:0] mul_sum2_output_rData_exp;
	reg mul_sum2_output_rData_format;
	reg mul_sum2_output_rData_msb1;
	reg mul_sum2_output_rData_msb2;
	reg [105:0] mul_sum2_output_rData_mulC;
	reg [4:0] mul_sum2_output_rData_rd;
	reg [2:0] mul_sum2_output_rData_roundMode;
	reg [11:0] mul_sum2_output_rData_rs1_exponent;
	reg [51:0] mul_sum2_output_rData_rs1_mantissa;
	reg mul_sum2_output_rData_rs1_sign;
	reg mul_sum2_output_rData_rs1_special;
	reg [11:0] mul_sum2_output_rData_rs2_exponent;
	reg [51:0] mul_sum2_output_rData_rs2_mantissa;
	reg mul_sum2_output_rData_rs2_sign;
	reg mul_sum2_output_rData_rs2_special;
	reg [11:0] mul_sum2_output_rData_rs3_exponent;
	reg [51:0] mul_sum2_output_rData_rs3_mantissa;
	reg mul_sum2_output_rData_rs3_sign;
	reg mul_sum2_output_rData_rs3_special;
	reg mul_sum2_output_rValid;
	reg mul_sum2_output_ready;
	wire mul_sum2_output_valid;
	wire [105:0] mul_sum2_sum;
	wire read_output_isStall;
	wire read_output_isStall_1;
	wire read_output_isStall_2;
	wire [1:0] read_output_payload_arg;
	reg read_output_payload_format;
	wire [3:0] read_output_payload_opcode;
	wire [4:0] read_output_payload_rd;
	wire [2:0] read_output_payload_roundMode;
	wire read_output_payload_rs1Boxed;
	reg [11:0] read_output_payload_rs1_exponent;
	reg [51:0] read_output_payload_rs1_mantissa;
	reg read_output_payload_rs1_sign;
	reg read_output_payload_rs1_special;
	wire read_output_payload_rs2Boxed;
	reg [11:0] read_output_payload_rs2_exponent;
	reg [51:0] read_output_payload_rs2_mantissa;
	reg read_output_payload_rs2_sign;
	reg read_output_payload_rs2_special;
	reg [11:0] read_output_payload_rs3_exponent;
	reg [51:0] read_output_payload_rs3_mantissa;
	wire read_output_payload_rs3_sign;
	reg read_output_payload_rs3_special;
	wire read_output_ready;
	wire read_output_valid;
	wire read_rs_0_boxed;
	wire [11:0] read_rs_0_value_exponent;
	wire [51:0] read_rs_0_value_mantissa;
	wire read_rs_0_value_sign;
	wire read_rs_0_value_special;
	wire read_rs_1_boxed;
	wire [11:0] read_rs_1_value_exponent;
	wire [51:0] read_rs_1_value_mantissa;
	wire read_rs_1_value_sign;
	wire read_rs_1_value_special;
	wire read_rs_2_boxed;
	wire [11:0] read_rs_2_value_exponent;
	wire [51:0] read_rs_2_value_mantissa;
	wire read_rs_2_value_sign;
	wire read_rs_2_value_special;
	wire [1:0] read_s0_payload_arg;
	wire read_s0_payload_format;
	wire [3:0] read_s0_payload_opcode;
	wire [4:0] read_s0_payload_rd;
	wire [2:0] read_s0_payload_roundMode;
	wire [4:0] read_s0_payload_rs1;
	wire [4:0] read_s0_payload_rs2;
	wire [4:0] read_s0_payload_rs3;
	reg [1:0] read_s0_rData_arg;
	reg read_s0_rData_format;
	reg [3:0] read_s0_rData_opcode;
	reg [4:0] read_s0_rData_rd;
	reg [2:0] read_s0_rData_roundMode;
	reg [4:0] read_s0_rData_rs1;
	reg [4:0] read_s0_rData_rs2;
	reg [4:0] read_s0_rData_rs3;
	reg read_s0_rValid;
	reg read_s0_ready;
	wire read_s0_valid;
	wire [1:0] read_s1_payload_arg;
	wire read_s1_payload_format;
	wire [3:0] read_s1_payload_opcode;
	wire [4:0] read_s1_payload_rd;
	wire [2:0] read_s1_payload_roundMode;
	wire [4:0] read_s1_payload_rs1;
	wire [4:0] read_s1_payload_rs2;
	wire [4:0] read_s1_payload_rs3;
	wire read_s1_ready;
	wire read_s1_valid;
	reg [5:0] rf_init_counter;
	wire rf_init_done;
	reg [66:0] rf_ram [0:31];
	reg rf_scoreboards_0_hit [0:31];
	reg [4:0] rf_scoreboards_0_hitWrite_payload_address;
	reg rf_scoreboards_0_hitWrite_payload_data;
	reg rf_scoreboards_0_hitWrite_valid;
	reg rf_scoreboards_0_target [0:31];
	reg [4:0] rf_scoreboards_0_targetWrite_payload_address;
	reg rf_scoreboards_0_targetWrite_payload_data;
	reg rf_scoreboards_0_targetWrite_valid;
	reg rf_scoreboards_0_writes [0:31];
	wire [63:0] roundBack_adder;
	wire [51:0] roundBack_adderMantissa;
	wire [51:0] roundBack_adderRightOp;
	wire roundBack_borringCase;
	reg [2:0] roundBack_borringRound;
	reg roundBack_input_payload_DZ;
	reg roundBack_input_payload_NV;
	reg [53:0] roundBack_input_payload_exactMask;
	reg roundBack_input_payload_format;
	reg roundBack_input_payload_mantissaIncrement;
	reg [4:0] roundBack_input_payload_rd;
	reg [1:0] roundBack_input_payload_roundAdjusted;
	reg [2:0] roundBack_input_payload_roundMode;
	reg roundBack_input_payload_scrap;
	reg [11:0] roundBack_input_payload_value_exponent;
	reg [52:0] roundBack_input_payload_value_mantissa;
	reg roundBack_input_payload_value_sign;
	reg roundBack_input_payload_value_special;
	reg roundBack_input_valid;
	wire [63:0] roundBack_masked;
	wire [11:0] roundBack_math_exponent;
	wire [51:0] roundBack_math_mantissa;
	wire roundBack_math_sign;
	wire roundBack_math_special;
	reg roundBack_nx;
	reg roundBack_of;
	wire [11:0] roundBack_ofThreshold;
	wire roundBack_output_payload_DZ;
	wire roundBack_output_payload_NV;
	wire roundBack_output_payload_NX;
	wire roundBack_output_payload_OF;
	wire roundBack_output_payload_UF;
	wire roundBack_output_payload_format;
	wire [4:0] roundBack_output_payload_rd;
	wire [11:0] roundBack_output_payload_value_exponent;
	wire [51:0] roundBack_output_payload_value_mantissa;
	wire roundBack_output_payload_value_sign;
	wire roundBack_output_payload_value_special;
	wire roundBack_output_payload_write;
	wire roundBack_output_valid;
	reg [11:0] roundBack_patched_exponent;
	reg [51:0] roundBack_patched_mantissa;
	wire roundBack_patched_sign;
	reg roundBack_patched_special;
	reg [2:0] roundBack_threshold;
	reg roundBack_uf;
	wire [10:0] roundBack_ufSubnormalThreshold;
	wire [10:0] roundBack_ufThreshold;
	wire roundBack_write;
	wire roundBack_writes_0;
	wire [5:0] roundFront_discardCount;
	reg [5:0] roundFront_discardCount_1;
	wire [53:0] roundFront_exactMask;
	wire [10:0] roundFront_expBase;
	wire [12:0] roundFront_expDif;
	wire roundFront_expSubnormal;
	reg roundFront_input_payload_DZ;
	reg roundFront_input_payload_NV;
	reg roundFront_input_payload_format;
	reg [4:0] roundFront_input_payload_rd;
	reg [2:0] roundFront_input_payload_roundMode;
	reg roundFront_input_payload_scrap;
	reg [11:0] roundFront_input_payload_value_exponent;
	reg [52:0] roundFront_input_payload_value_mantissa;
	reg roundFront_input_payload_value_sign;
	reg roundFront_input_payload_value_special;
	reg roundFront_input_valid;
	wire [53:0] roundFront_manAggregate;
	wire roundFront_mantissaIncrement;
	wire roundFront_output_payload_DZ;
	wire roundFront_output_payload_NV;
	wire [53:0] roundFront_output_payload_exactMask;
	wire roundFront_output_payload_format;
	wire roundFront_output_payload_mantissaIncrement;
	wire [4:0] roundFront_output_payload_rd;
	wire [1:0] roundFront_output_payload_roundAdjusted;
	wire [2:0] roundFront_output_payload_roundMode;
	wire roundFront_output_payload_scrap;
	wire [11:0] roundFront_output_payload_value_exponent;
	wire [52:0] roundFront_output_payload_value_mantissa;
	wire roundFront_output_payload_value_sign;
	wire roundFront_output_payload_value_special;
	wire roundFront_output_valid;
	wire [1:0] roundFront_roundAdjusted;
	wire scheduler_0_hazard;
	wire scheduler_0_hits_0;
	wire scheduler_0_hits_1;
	wire scheduler_0_hits_2;
	wire scheduler_0_hits_3;
	wire [1:0] scheduler_0_input_payload_arg;
	wire scheduler_0_input_payload_format;
	wire [3:0] scheduler_0_input_payload_opcode;
	wire [4:0] scheduler_0_input_payload_rd;
	wire [2:0] scheduler_0_input_payload_roundMode;
	wire [4:0] scheduler_0_input_payload_rs1;
	wire [4:0] scheduler_0_input_payload_rs2;
	wire [4:0] scheduler_0_input_payload_rs3;
	wire scheduler_0_input_ready;
	wire scheduler_0_input_valid;
	wire scheduler_0_output_fire;
	wire [1:0] scheduler_0_output_payload_arg;
	wire scheduler_0_output_payload_format;
	wire [3:0] scheduler_0_output_payload_opcode;
	wire [4:0] scheduler_0_output_payload_rd;
	wire [2:0] scheduler_0_output_payload_roundMode;
	reg [4:0] scheduler_0_output_payload_rs1;
	wire [4:0] scheduler_0_output_payload_rs2;
	wire [4:0] scheduler_0_output_payload_rs3;
	wire scheduler_0_output_ready;
	wire scheduler_0_output_valid;
	wire scheduler_0_rfBusy_0;
	wire scheduler_0_rfBusy_1;
	wire scheduler_0_rfBusy_2;
	wire scheduler_0_rfBusy_3;
	wire scheduler_0_rfHits_0;
	wire scheduler_0_rfHits_1;
	wire scheduler_0_rfHits_2;
	wire scheduler_0_rfHits_3;
	wire scheduler_0_rfTargets_0;
	wire scheduler_0_rfTargets_1;
	wire scheduler_0_rfTargets_2;
	wire scheduler_0_rfTargets_3;
	reg scheduler_0_useRd;
	reg scheduler_0_useRs1;
	reg scheduler_0_useRs2;
	reg scheduler_0_useRs3;
	wire shortPip_NV;
	wire shortPip_bothZero;
	reg shortPip_cmpResult;
	reg shortPip_cononicalForced;
	wire shortPip_decoded_isInfinity;
	wire shortPip_decoded_isNan;
	wire shortPip_decoded_isNormal;
	wire shortPip_decoded_isQuiet;
	wire shortPip_decoded_isSubnormal;
	wire shortPip_decoded_isZero;
	wire shortPip_expInSubnormalRange;
	wire [10:0] shortPip_expSubnormalThreshold;
	reg shortPip_exponentForced;
	reg shortPip_exponentForcedValue;
	reg shortPip_f2i_increment;
	wire shortPip_f2i_isZero;
	reg shortPip_f2i_overflow;
	wire shortPip_f2i_resign;
	reg [31:0] shortPip_f2i_result;
	wire [1:0] shortPip_f2i_round;
	wire shortPip_f2i_underflow;
	wire [31:0] shortPip_f2i_unsigned;
	wire [7:0] shortPip_f32_exp;
	wire [22:0] shortPip_f32_man;
	wire [10:0] shortPip_f64_exp;
	wire [51:0] shortPip_f64_man;
	reg [31:0] shortPip_fclassResult;
	reg shortPip_fsm_boot;
	reg shortPip_fsm_done;
	wire [11:0] shortPip_fsm_f2iShift;
	wire [10:0] shortPip_fsm_formatShiftOffset;
	wire shortPip_fsm_isF2i;
	wire shortPip_fsm_isZero;
	wire shortPip_fsm_needRecoding;
	reg [5:0] shortPip_fsm_shift_by;
	reg [52:0] shortPip_fsm_shift_input;
	reg [52:0] shortPip_fsm_shift_input_1;
	reg [52:0] shortPip_fsm_shift_input_2;
	reg [52:0] shortPip_fsm_shift_input_3;
	reg [52:0] shortPip_fsm_shift_input_4;
	reg [52:0] shortPip_fsm_shift_input_5;
	reg [52:0] shortPip_fsm_shift_input_6;
	reg [52:0] shortPip_fsm_shift_output;
	reg shortPip_fsm_shift_scrap;
	reg shortPip_halt;
	wire shortPip_input_fire;
	wire shortPip_input_isStall;
	wire [1:0] shortPip_input_payload_arg;
	wire shortPip_input_payload_format;
	wire [3:0] shortPip_input_payload_opcode;
	wire [4:0] shortPip_input_payload_rd;
	wire [2:0] shortPip_input_payload_roundMode;
	wire shortPip_input_payload_rs1Boxed;
	wire [11:0] shortPip_input_payload_rs1_exponent;
	wire [51:0] shortPip_input_payload_rs1_mantissa;
	wire shortPip_input_payload_rs1_sign;
	wire shortPip_input_payload_rs1_special;
	wire shortPip_input_payload_rs2Boxed;
	wire [11:0] shortPip_input_payload_rs2_exponent;
	wire [51:0] shortPip_input_payload_rs2_mantissa;
	wire shortPip_input_payload_rs2_sign;
	wire shortPip_input_payload_rs2_special;
	wire [31:0] shortPip_input_payload_value;
	wire shortPip_input_ready;
	wire shortPip_input_valid;
	wire shortPip_isCommited;
	wire shortPip_isNormal;
	wire shortPip_isSubnormal;
	reg shortPip_mantissaForced;
	reg shortPip_mantissaForcedValue;
	wire shortPip_minMaxSelectNanQuiet;
	wire shortPip_minMaxSelectRs2;
	wire shortPip_output_m2sPipe_payload_DZ;
	wire shortPip_output_m2sPipe_payload_NV;
	wire shortPip_output_m2sPipe_payload_format;
	wire [4:0] shortPip_output_m2sPipe_payload_rd;
	wire [2:0] shortPip_output_m2sPipe_payload_roundMode;
	wire shortPip_output_m2sPipe_payload_scrap;
	wire [11:0] shortPip_output_m2sPipe_payload_value_exponent;
	wire [52:0] shortPip_output_m2sPipe_payload_value_mantissa;
	wire shortPip_output_m2sPipe_payload_value_sign;
	wire shortPip_output_m2sPipe_payload_value_special;
	wire shortPip_output_m2sPipe_ready;
	wire shortPip_output_m2sPipe_valid;
	wire shortPip_output_payload_DZ;
	wire shortPip_output_payload_NV;
	wire shortPip_output_payload_format;
	wire [4:0] shortPip_output_payload_rd;
	wire [2:0] shortPip_output_payload_roundMode;
	wire shortPip_output_payload_scrap;
	wire [11:0] shortPip_output_payload_value_exponent;
	wire [52:0] shortPip_output_payload_value_mantissa;
	wire shortPip_output_payload_value_sign;
	wire shortPip_output_payload_value_special;
	reg shortPip_output_rData_DZ;
	reg shortPip_output_rData_NV;
	reg shortPip_output_rData_format;
	reg [4:0] shortPip_output_rData_rd;
	reg [2:0] shortPip_output_rData_roundMode;
	reg shortPip_output_rData_scrap;
	reg [11:0] shortPip_output_rData_value_exponent;
	reg [52:0] shortPip_output_rData_value_mantissa;
	reg shortPip_output_rData_value_sign;
	reg shortPip_output_rData_value_special;
	reg shortPip_output_rValid;
	reg shortPip_output_ready;
	wire shortPip_output_valid;
	reg [63:0] shortPip_recodedResult;
	reg [63:0] shortPip_result;
	wire shortPip_rfOutput_payload_DZ;
	wire shortPip_rfOutput_payload_NV;
	reg shortPip_rfOutput_payload_format;
	wire [4:0] shortPip_rfOutput_payload_rd;
	wire [2:0] shortPip_rfOutput_payload_roundMode;
	wire shortPip_rfOutput_payload_scrap;
	reg [11:0] shortPip_rfOutput_payload_value_exponent;
	reg [52:0] shortPip_rfOutput_payload_value_mantissa;
	reg shortPip_rfOutput_payload_value_sign;
	reg shortPip_rfOutput_payload_value_special;
	wire shortPip_rfOutput_ready;
	wire shortPip_rfOutput_valid;
	reg shortPip_rs1AbsSmaller;
	reg shortPip_rs1Equal;
	wire shortPip_rs1Nan;
	wire shortPip_rs1NanNv;
	reg shortPip_rs1Smaller;
	wire shortPip_rs2Nan;
	wire shortPip_rs2NanNv;
	reg shortPip_rspNv;
	reg shortPip_rspNx;
	wire shortPip_rspStreams_0_m2sPipe_payload_NV;
	wire shortPip_rspStreams_0_m2sPipe_payload_NX;
	wire [63:0] shortPip_rspStreams_0_m2sPipe_payload_value;
	wire shortPip_rspStreams_0_m2sPipe_ready;
	wire shortPip_rspStreams_0_m2sPipe_valid;
	wire shortPip_rspStreams_0_payload_NV;
	wire shortPip_rspStreams_0_payload_NX;
	wire [63:0] shortPip_rspStreams_0_payload_value;
	reg shortPip_rspStreams_0_rData_NV;
	reg shortPip_rspStreams_0_rData_NX;
	reg [63:0] shortPip_rspStreams_0_rData_value;
	reg shortPip_rspStreams_0_rValid;
	reg shortPip_rspStreams_0_ready;
	wire shortPip_rspStreams_0_valid;
	wire shortPip_sgnjResult;
	wire shortPip_sgnjRs1Sign;
	reg shortPip_sgnjRs2Sign;
	wire shortPip_signalQuiet;
	wire shortPip_toFpuRf;
	reg sqrt_cmdSent;
	reg [11:0] sqrt_exponent;
	reg sqrt_haltIt;
	wire sqrt_input_fire;
	wire sqrt_input_fire_1;
	wire sqrt_input_payload_format;
	wire [4:0] sqrt_input_payload_rd;
	wire [2:0] sqrt_input_payload_roundMode;
	wire [11:0] sqrt_input_payload_rs1_exponent;
	wire [51:0] sqrt_input_payload_rs1_mantissa;
	wire sqrt_input_payload_rs1_sign;
	wire sqrt_input_payload_rs1_special;
	wire sqrt_input_ready;
	wire sqrt_input_valid;
	reg sqrt_isCommited;
	wire sqrt_needShift;
	wire sqrt_negative;
	wire sqrt_output_payload_DZ;
	reg sqrt_output_payload_NV;
	wire sqrt_output_payload_format;
	wire [4:0] sqrt_output_payload_rd;
	wire [2:0] sqrt_output_payload_roundMode;
	wire sqrt_output_payload_scrap;
	reg [11:0] sqrt_output_payload_value_exponent;
	reg [52:0] sqrt_output_payload_value_mantissa;
	wire sqrt_output_payload_value_sign;
	reg sqrt_output_payload_value_special;
	wire sqrt_output_ready;
	wire sqrt_output_valid;
	wire sqrt_scrap;
	wire [53:0] sqrt_sqrt_io_input_payload_a;
	wire sqrt_sqrt_io_input_ready;
	wire sqrt_sqrt_io_input_valid;
	wire [56:0] sqrt_sqrt_io_output_payload_remain;
	wire [52:0] sqrt_sqrt_io_output_payload_result;
	wire sqrt_sqrt_io_output_valid;
	wire [2:0] streamArbiter_2_io_chosen;
	wire [5:0] streamArbiter_2_io_chosenOH;
	wire streamArbiter_2_io_inputs_0_ready;
	wire streamArbiter_2_io_inputs_1_ready;
	wire streamArbiter_2_io_inputs_2_ready;
	wire streamArbiter_2_io_inputs_3_ready;
	wire streamArbiter_2_io_inputs_4_ready;
	wire streamArbiter_2_io_inputs_5_ready;
	wire streamArbiter_2_io_output_payload_DZ;
	wire streamArbiter_2_io_output_payload_NV;
	wire streamArbiter_2_io_output_payload_format;
	wire [4:0] streamArbiter_2_io_output_payload_rd;
	wire [2:0] streamArbiter_2_io_output_payload_roundMode;
	wire streamArbiter_2_io_output_payload_scrap;
	wire [11:0] streamArbiter_2_io_output_payload_value_exponent;
	wire [52:0] streamArbiter_2_io_output_payload_value_mantissa;
	wire streamArbiter_2_io_output_payload_value_sign;
	wire streamArbiter_2_io_output_payload_value_special;
	wire streamArbiter_2_io_output_valid;
	wire streamFork_1_io_input_ready;
	wire [3:0] streamFork_1_io_outputs_0_payload_opcode;
	wire [4:0] streamFork_1_io_outputs_0_payload_rd;
	wire [63:0] streamFork_1_io_outputs_0_payload_value;
	wire streamFork_1_io_outputs_0_payload_write;
	wire streamFork_1_io_outputs_0_valid;
	wire [3:0] streamFork_1_io_outputs_1_payload_opcode;
	wire [4:0] streamFork_1_io_outputs_1_payload_rd;
	wire [63:0] streamFork_1_io_outputs_1_payload_value;
	wire streamFork_1_io_outputs_1_payload_write;
	wire streamFork_1_io_outputs_1_ready;
	wire streamFork_1_io_outputs_1_valid;
	wire [1:0] switch_FpuCore_l686;
	wire [1:0] switch_Misc_l226;
	wire when_FpuCore_l1056;
	wire when_FpuCore_l1072;
	wire when_FpuCore_l1089;
	wire when_FpuCore_l1093;
	wire when_FpuCore_l1118;
	wire when_FpuCore_l1137;
	wire when_FpuCore_l1144;
	wire when_FpuCore_l1148;
	wire when_FpuCore_l1419;
	wire when_FpuCore_l1419_1;
	wire when_FpuCore_l1419_2;
	wire when_FpuCore_l1419_3;
	wire when_FpuCore_l1419_4;
	wire when_FpuCore_l1419_5;
	wire when_FpuCore_l1424;
	wire when_FpuCore_l1513;
	wire when_FpuCore_l1516;
	wire when_FpuCore_l1551;
	wire when_FpuCore_l1606;
	wire when_FpuCore_l1609;
	wire when_FpuCore_l1612;
	reg when_FpuCore_l1622;
	wire when_FpuCore_l163;
	wire when_FpuCore_l1631;
	reg when_FpuCore_l1641;
	wire when_FpuCore_l1650;
	wire when_FpuCore_l1682;
	wire when_FpuCore_l208;
	wire when_FpuCore_l209;
	wire when_FpuCore_l210;
	wire when_FpuCore_l211;
	wire when_FpuCore_l212;
	wire when_FpuCore_l221;
	wire when_FpuCore_l221_1;
	wire when_FpuCore_l221_2;
	wire when_FpuCore_l221_3;
	wire when_FpuCore_l221_4;
	wire when_FpuCore_l258;
	wire when_FpuCore_l261;
	wire when_FpuCore_l265;
	wire when_FpuCore_l304;
	wire when_FpuCore_l305;
	wire when_FpuCore_l307;
	wire when_FpuCore_l31;
	wire when_FpuCore_l312;
	wire when_FpuCore_l316;
	wire when_FpuCore_l31_1;
	wire when_FpuCore_l31_2;
	wire when_FpuCore_l31_3;
	wire when_FpuCore_l31_4;
	wire when_FpuCore_l31_5;
	wire when_FpuCore_l329;
	wire when_FpuCore_l335;
	wire when_FpuCore_l351;
	wire when_FpuCore_l359;
	wire when_FpuCore_l375;
	wire when_FpuCore_l380;
	wire when_FpuCore_l399;
	wire when_FpuCore_l404;
	wire when_FpuCore_l452;
	wire when_FpuCore_l494;
	wire when_FpuCore_l495;
	wire when_FpuCore_l508;
	wire when_FpuCore_l525;
	wire when_FpuCore_l529;
	wire when_FpuCore_l532;
	wire when_FpuCore_l551;
	wire when_FpuCore_l594;
	wire when_FpuCore_l646;
	wire when_FpuCore_l646_1;
	wire when_FpuCore_l646_2;
	wire when_FpuCore_l646_3;
	wire when_FpuCore_l646_4;
	wire when_FpuCore_l646_5;
	wire when_FpuCore_l652;
	wire when_FpuCore_l658;
	wire when_FpuCore_l672;
	wire when_FpuCore_l702;
	wire when_FpuCore_l763;
	wire when_FpuCore_l767;
	wire when_FpuCore_l780;
	wire when_FpuCore_l781;
	wire when_FpuCore_l782;
	wire when_FpuCore_l783;
	wire when_FpuCore_l784;
	wire when_FpuCore_l796;
	wire when_FpuCore_l800;
	wire when_FpuCore_l850;
	wire when_FpuCore_l853;
	wire when_FpuCore_l860;
	wire when_FpuCore_l967;
	wire when_FpuCore_l983;
	wire when_FpuCore_l987;
	wire when_Stream_l368;
	wire when_Stream_l368_1;
	wire when_Stream_l368_10;
	wire when_Stream_l368_11;
	wire when_Stream_l368_12;
	wire when_Stream_l368_13;
	wire when_Stream_l368_14;
	wire when_Stream_l368_15;
	wire when_Stream_l368_16;
	wire when_Stream_l368_17;
	wire when_Stream_l368_2;
	wire when_Stream_l368_3;
	wire when_Stream_l368_4;
	wire when_Stream_l368_5;
	wire when_Stream_l368_6;
	wire when_Stream_l368_7;
	wire when_Stream_l368_8;
	wire when_Stream_l368_9;
	wire when_Stream_l438;
	reg writeback_input_payload_DZ;
	reg writeback_input_payload_NV;
	reg writeback_input_payload_NX;
	reg writeback_input_payload_OF;
	reg writeback_input_payload_UF;
	reg writeback_input_payload_format;
	reg [4:0] writeback_input_payload_rd;
	reg [11:0] writeback_input_payload_value_exponent;
	reg [51:0] writeback_input_payload_value_mantissa;
	reg writeback_input_payload_value_sign;
	reg writeback_input_payload_value_special;
	reg writeback_input_payload_write;
	reg writeback_input_valid;
	wire [4:0] writeback_port_payload_address;
	wire writeback_port_payload_data_boxed;
	wire [11:0] writeback_port_payload_data_value_exponent;
	reg [51:0] writeback_port_payload_data_value_mantissa;
	wire writeback_port_payload_data_value_sign;
	wire writeback_port_payload_data_value_special;
	wire writeback_port_valid;
	assign FpuPlugin_fpu_streamArbiter_2_io_output_combStage_ready = 1'b1;
	assign _zz_decode_shortPipHit = FpuOpcode_MIN_MAX;
	assign _zz_load_s0_output_rData_value_1 = 1'b1;
	assign _zz_roundFront_exactMask = 6'h30;
	assign _zz_roundFront_exactMask_12 = 6'h18;
	assign _zz_roundFront_exactMask_16 = 6'h10;
	assign _zz_roundFront_exactMask_20 = 6'h08;
	assign _zz_roundFront_exactMask_4 = 6'h28;
	assign _zz_roundFront_exactMask_8 = 6'h20;
	assign _zz_shortPip_fsm_shift_by_1 = 6'h21;
	assign _zz_sqrt_exponent_2 = 11'h3ff;
	assign _zz_when = 1'b1;
	assign add_result_output_payload_DZ = 1'b0;
	assign decode_divSqrtToMul_payload_add = 1'bx;
	assign decode_divSqrtToMul_payload_divSqrt = 1'bx;
	assign decode_divSqrtToMul_payload_format = 1'bx;
	assign decode_divSqrtToMul_payload_msb1 = 1'bx;
	assign decode_divSqrtToMul_payload_msb2 = 1'bx;
	assign decode_divSqrtToMul_payload_rd = 5'bxxxxx;
	assign decode_divSqrtToMul_payload_roundMode = 3'bxxx;
	assign decode_divSqrtToMul_payload_rs1_exponent = 12'bxxxxxxxxxxxx;
	assign decode_divSqrtToMul_payload_rs1_mantissa = 52'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
	assign decode_divSqrtToMul_payload_rs1_sign = 1'bx;
	assign decode_divSqrtToMul_payload_rs1_special = 1'bx;
	assign decode_divSqrtToMul_payload_rs2_exponent = 12'bxxxxxxxxxxxx;
	assign decode_divSqrtToMul_payload_rs2_mantissa = 52'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
	assign decode_divSqrtToMul_payload_rs2_sign = 1'bx;
	assign decode_divSqrtToMul_payload_rs2_special = 1'bx;
	assign decode_divSqrtToMul_payload_rs3_exponent = 12'bxxxxxxxxxxxx;
	assign decode_divSqrtToMul_payload_rs3_mantissa = 52'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
	assign decode_divSqrtToMul_payload_rs3_sign = 1'bx;
	assign decode_divSqrtToMul_payload_rs3_special = 1'bx;
	assign decode_divSqrtToMul_valid = 1'b0;
	assign load_s1_output_payload_DZ = 1'b0;
	assign load_s1_output_payload_NV = 1'b0;
	assign load_s1_passThroughFloat_special = 1'b0;
	assign load_s1_scrap = 1'b0;
	assign mul_result_mulToAdd_payload_needCommit = 1'b0;
	assign mul_result_output_payload_DZ = 1'b0;
	assign shortPip_rfOutput_payload_DZ = 1'b0;
	assign shortPip_rfOutput_payload_scrap = 1'b0;
	assign sqrt_output_payload_DZ = 1'b0;
	assign when_FpuCore_l1682 = 1'b1;
	assign _zz_commitLogic_0_pending_counter = commitLogic_0_pending_counter + _zz_commitLogic_0_pending_counter_1;
	assign _zz_commitLogic_0_pending_counter_1 = {3'h0, _zz_commitLogic_0_pending_counter_2};
	assign _zz_commitLogic_0_pending_counter_3 = {3'h0, _zz_commitLogic_0_pending_counter_4};
	assign _zz_commitLogic_0_add_counter = commitLogic_0_add_counter + _zz_commitLogic_0_add_counter_1;
	assign _zz_commitLogic_0_add_counter_1 = {3'h0, _zz_commitLogic_0_add_counter_2};
	assign _zz_commitLogic_0_add_counter_3 = {3'h0, _zz_commitLogic_0_add_counter_4};
	assign _zz_commitLogic_0_mul_counter = commitLogic_0_mul_counter + _zz_commitLogic_0_mul_counter_1;
	assign _zz_commitLogic_0_mul_counter_1 = {3'h0, _zz_commitLogic_0_mul_counter_2};
	assign _zz_commitLogic_0_mul_counter_3 = {3'h0, _zz_commitLogic_0_mul_counter_4};
	assign _zz_commitLogic_0_div_counter = commitLogic_0_div_counter + _zz_commitLogic_0_div_counter_1;
	assign _zz_commitLogic_0_div_counter_1 = {3'h0, _zz_commitLogic_0_div_counter_2};
	assign _zz_commitLogic_0_div_counter_3 = {3'h0, _zz_commitLogic_0_div_counter_4};
	assign _zz_commitLogic_0_sqrt_counter = commitLogic_0_sqrt_counter + _zz_commitLogic_0_sqrt_counter_1;
	assign _zz_commitLogic_0_sqrt_counter_1 = {3'h0, _zz_commitLogic_0_sqrt_counter_2};
	assign _zz_commitLogic_0_sqrt_counter_3 = {3'h0, _zz_commitLogic_0_sqrt_counter_4};
	assign _zz_commitLogic_0_short_counter = commitLogic_0_short_counter + _zz_commitLogic_0_short_counter_1;
	assign _zz_commitLogic_0_short_counter_1 = {3'h0, _zz_commitLogic_0_short_counter_2};
	assign _zz_commitLogic_0_short_counter_3 = {3'h0, _zz_commitLogic_0_short_counter_4};
	assign _zz_load_s1_fsm_shift_input_1 = {load_s1_fsm_shift_input[50:0], 1'b0};
	assign _zz_load_s1_fsm_shift_input_2 = {load_s1_fsm_shift_input_1[49:0], 2'h0};
	assign _zz_load_s1_fsm_shift_input_3 = {load_s1_fsm_shift_input_2[47:0], 4'h0};
	assign _zz_load_s1_fsm_shift_input_4 = {load_s1_fsm_shift_input_3[43:0], 8'h00};
	assign _zz_load_s1_fsm_shift_input_5 = {load_s1_fsm_shift_input_4[35:0], 16'h0000};
	assign _zz_load_s1_fsm_shift_input_6 = {load_s1_fsm_shift_input_5[19:0], 32'h00000000};
	assign _zz_load_s0_output_rData_value_2 = _zz_load_s0_output_rData_value_3[31:0];
	assign _zz_load_s0_output_rData_value_4 = {_zz_load_s0_output_rData_value_1, (_zz_load_s0_output_rData_value_1 ? ~_zz_load_s0_output_rData_value : _zz_load_s0_output_rData_value)} + _zz_load_s0_output_rData_value_5;
	assign _zz_load_s0_output_rData_value_5 = {64'h0000000000000000, _zz_load_s0_output_rData_value_6};
	assign _zz__zz_load_s1_fsm_shift_by_1_1 = _zz_load_s1_fsm_shift_by - 52'h0000000000001;
	assign _zz_load_s1_recoded_exponent = _zz_load_s1_recoded_exponent_1 + _zz_load_s1_recoded_exponent_2;
	assign _zz_load_s1_recoded_exponent_1 = {1'b0, load_s1_passThroughFloat_exponent} - {1'b0, load_s1_fsm_expOffset};
	assign _zz_load_s1_recoded_exponent_2 = {1'b0, load_s1_recodedExpOffset};
	assign _zz_load_s1_output_payload_value_exponent = {6'h00, load_s1_fsm_shift_by};
	assign _zz_shortPip_f32_exp = shortPip_input_payload_rs1_exponent - 12'h780;
	assign _zz_shortPip_f64_exp = shortPip_input_payload_rs1_exponent - 12'h400;
	assign _zz_shortPip_expInSubnormalRange = {1'b0, shortPip_expSubnormalThreshold};
	assign _zz_shortPip_fsm_shift_input_1 = {32'h00000000, shortPip_fsm_shift_input[52:32]};
	assign _zz_shortPip_fsm_shift_input_2 = {16'h0000, shortPip_fsm_shift_input_1[52:16]};
	assign _zz_shortPip_fsm_shift_input_3 = {8'h00, shortPip_fsm_shift_input_2[52:8]};
	assign _zz_shortPip_fsm_shift_input_4 = {4'h0, shortPip_fsm_shift_input_3[52:4]};
	assign _zz_shortPip_fsm_shift_input_5 = {2'h0, shortPip_fsm_shift_input_4[52:2]};
	assign _zz_shortPip_fsm_shift_input_6 = {1'b0, shortPip_fsm_shift_input_5[52:1]};
	assign _zz_shortPip_fsm_shift_by_2 = (_zz_shortPip_fsm_shift_by_3 > _zz_shortPip_fsm_shift_by ? _zz_shortPip_fsm_shift_by : _zz_shortPip_fsm_shift_by_4) + 12'h014;
	assign _zz_shortPip_fsm_shift_by_3 = {6'h00, _zz_shortPip_fsm_shift_by_1};
	assign _zz_shortPip_fsm_shift_by_4 = {6'h00, _zz_shortPip_fsm_shift_by_1};
	assign _zz_shortPip_fsm_shift_by_5 = _zz_shortPip_fsm_shift_by_6 - shortPip_input_payload_rs1_exponent;
	assign _zz_shortPip_fsm_shift_by_6 = {1'b0, shortPip_fsm_formatShiftOffset};
	assign _zz_shortPip_f2i_result = {31'h00000000, _zz_shortPip_f2i_result_1};
	assign _zz_mul_sum1_sum = _zz_mul_sum1_sum_1 + _zz_mul_sum1_sum_2;
	assign _zz_mul_sum1_sum_1 = {70'h000000000000000000, mul_sum1_input_payload_muls_0};
	assign _zz_mul_sum1_sum_3 = {18'h00000, mul_sum1_input_payload_muls_1, 18'h00000};
	assign _zz_mul_sum1_sum_2 = {52'h0000000000000, _zz_mul_sum1_sum_3};
	assign _zz_mul_sum1_sum_4 = _zz_mul_sum1_sum_5 + _zz_mul_sum1_sum_7;
	assign _zz_mul_sum1_sum_6 = {18'h00000, mul_sum1_input_payload_muls_2, 18'h00000};
	assign _zz_mul_sum1_sum_5 = {52'h0000000000000, _zz_mul_sum1_sum_6};
	assign _zz_mul_sum1_sum_8 = {36'h000000000, mul_sum1_input_payload_muls_3, 36'h000000000};
	assign _zz_mul_sum1_sum_7 = {35'h000000000, _zz_mul_sum1_sum_8};
	assign _zz_mul_sum2_sum = _zz_mul_sum2_sum_1 + _zz_mul_sum2_sum_12;
	assign _zz_mul_sum2_sum_1 = _zz_mul_sum2_sum_2 + _zz_mul_sum2_sum_7;
	assign _zz_mul_sum2_sum_2 = _zz_mul_sum2_sum_3 + _zz_mul_sum2_sum_5;
	assign _zz_mul_sum2_sum_4 = {36'h000000000, mul_sum2_input_payload_muls2_0, 36'h000000000};
	assign _zz_mul_sum2_sum_3 = {35'h000000000, _zz_mul_sum2_sum_4};
	assign _zz_mul_sum2_sum_6 = {36'h000000000, mul_sum2_input_payload_muls2_1, 36'h000000000};
	assign _zz_mul_sum2_sum_5 = {34'h000000000, _zz_mul_sum2_sum_6};
	assign _zz_mul_sum2_sum_7 = _zz_mul_sum2_sum_8 + _zz_mul_sum2_sum_10;
	assign _zz_mul_sum2_sum_9 = {54'h00000000000000, mul_sum2_input_payload_muls2_2, 54'h00000000000000};
	assign _zz_mul_sum2_sum_8 = {17'h00000, _zz_mul_sum2_sum_9};
	assign _zz_mul_sum2_sum_11 = {54'h00000000000000, mul_sum2_input_payload_muls2_3, 54'h00000000000000};
	assign _zz_mul_sum2_sum_10 = {17'h00000, _zz_mul_sum2_sum_11};
	assign _zz_mul_sum2_sum_13 = {72'h000000000000000000, mul_sum2_input_payload_muls2_4, 72'h000000000000000000};
	assign _zz_mul_norm_exp = {12'h000, _zz_mul_norm_exp_1};
	assign _zz_mul_norm_forceUnderflow = {1'b0, mul_norm_underflowThreshold};
	assign _zz_mul_norm_output_exponent = mul_norm_exp - 13'h07ff;
	assign _zz_div_exponent = _zz_div_exponent_1 - _zz_div_exponent_3;
	assign _zz_div_exponent_1 = _zz_div_exponent_2 + 14'h27ff;
	assign _zz_div_exponent_2 = {2'h0, div_input_payload_rs1_exponent};
	assign _zz_div_exponent_3 = {2'h0, div_input_payload_rs2_exponent};
	assign _zz_div_exponent_4 = {13'h0000, _zz_div_exponent_5};
	assign _zz_sqrt_exponent = _zz_sqrt_exponent_1 + {1'b0, _zz_sqrt_exponent_3};
	assign _zz_sqrt_exponent_1 = {1'b0, _zz_sqrt_exponent_2};
	assign _zz_sqrt_exponent_3 = {1'b0, sqrt_input_payload_rs1_exponent[11:1]};
	assign _zz_sqrt_exponent_5 = sqrt_input_payload_rs1_exponent[0];
	assign _zz_sqrt_exponent_4 = {11'h000, _zz_sqrt_exponent_5};
	assign _zz_add_shifter_shiftBy_1 = (_zz_add_shifter_shiftBy[12] ? _zz_add_shifter_shiftBy_2 : _zz_add_shifter_shiftBy);
	assign _zz_add_shifter_shiftBy_4 = _zz_add_shifter_shiftBy[12];
	assign _zz_add_shifter_shiftBy_3 = {12'h000, _zz_add_shifter_shiftBy_4};
	assign _zz_add_shifter_yMantissa_1 = {32'h00000000, add_shifter_yMantissa[54:32]};
	assign _zz_add_shifter_yMantissa_2 = {16'h0000, add_shifter_yMantissa_1[54:16]};
	assign _zz_add_shifter_yMantissa_3 = {8'h00, add_shifter_yMantissa_2[54:8]};
	assign _zz_add_shifter_yMantissa_4 = {4'h0, add_shifter_yMantissa_3[54:4]};
	assign _zz_add_shifter_yMantissa_5 = {2'h0, add_shifter_yMantissa_4[54:2]};
	assign _zz_add_shifter_yMantissa_6 = {1'b0, add_shifter_yMantissa_5[54:1]};
	assign _zz_add_math_xSigned = {add_math_input_payload_xSign, (add_math_input_payload_xSign ? ~add_math_input_payload_xMantissa : add_math_input_payload_xMantissa)} + _zz_add_math_xSigned_1;
	assign _zz_add_math_xSigned_1 = {55'h00000000000000, _zz_add_math_xSigned_2};
	assign _zz_add_math_ySigned = {add_math_input_payload_ySign, (add_math_input_payload_ySign ? ~add_math_input_payload_yMantissa : add_math_input_payload_yMantissa)} + _zz_add_math_ySigned_1;
	assign _zz_add_math_ySigned_1 = {55'h00000000000000, _zz_add_math_ySigned_2};
	assign _zz_add_math_output_payload_xyMantissa_1 = _zz_add_math_output_payload_xyMantissa_2 + _zz_add_math_output_payload_xyMantissa_3;
	assign _zz_add_math_output_payload_xyMantissa_2 = {add_math_xSigned[55], add_math_xSigned};
	assign _zz_add_math_output_payload_xyMantissa_3 = {add_math_ySigned[55], add_math_ySigned};
	assign _zz__zz_add_oh_shift_1_1 = _zz_add_oh_shift - 56'h00000000000001;
	assign _zz_add_norm_output_payload_exponent = {1'b0, add_norm_input_payload_xyExponent} - _zz_add_norm_output_payload_exponent_1;
	assign _zz_add_norm_output_payload_exponent_2 = {1'b0, add_norm_input_payload_shift};
	assign _zz_add_norm_output_payload_exponent_1 = {6'h00, _zz_add_norm_output_payload_exponent_2};
	assign _zz_add_result_output_payload_value_mantissa = {2'h0, add_result_input_payload_mantissa[55:2]};
	assign _zz_roundFront_expDif_1 = {1'b0, roundFront_expBase};
	assign _zz_roundFront_expDif = {1'b0, _zz_roundFront_expDif_1};
	assign _zz_roundFront_discardCount = roundFront_expDif[5:0];
	assign _zz_roundFront_roundAdjusted = {1'b1, _zz_roundFront_roundAdjusted_1};
	assign _zz_roundFront_roundAdjusted_1 = {1'b0, roundFront_manAggregate[53:1]};
	assign _zz__zz_roundFront_mantissaIncrement = {2'h1, _zz__zz_roundFront_mantissaIncrement_1};
	assign _zz__zz_roundFront_mantissaIncrement_1 = {2'h0, roundFront_manAggregate[53:2]};
	assign _zz_roundBack_adderMantissa = {1'b0, roundBack_input_payload_exactMask[52:1]};
	assign _zz_roundBack_adderRightOp = (roundBack_input_payload_mantissaIncrement ? _zz_roundBack_adderRightOp_1 : 53'h00000000000000);
	assign _zz_roundBack_adderRightOp_1 = {1'b0, roundBack_input_payload_exactMask[53:1]};
	assign _zz_roundBack_adder_2 = _zz_roundBack_adder + _zz_roundBack_adder_3;
	assign _zz_roundBack_adder_3 = {12'h000, roundBack_adderRightOp};
	assign _zz_roundBack_adder_4 = {63'h0000000000000000, _zz_roundBack_adder_1};
	assign _zz_roundBack_masked_1 = _zz_roundBack_masked_2[51:0];
	assign _zz_roundBack_masked = {12'h000, _zz_roundBack_masked_1};
	assign _zz_roundBack_masked_2 = {1'b0, roundBack_input_payload_exactMask[53:1]};
	assign _zz_roundBack_borringCase = {1'b0, roundBack_ufSubnormalThreshold};
	assign _zz_when_FpuCore_l1609 = {1'b0, roundBack_ufSubnormalThreshold};
	assign _zz_when_FpuCore_l1631 = {1'b0, roundBack_ufThreshold};
	assign _zz_rf_ram_port = {writeback_port_payload_data_boxed, writeback_port_payload_data_value_special, writeback_port_payload_data_value_sign, writeback_port_payload_data_value_exponent, writeback_port_payload_data_value_mantissa};
	assign _zz_decode_shortPipHit_1 = decode_input_payload_opcode == FpuOpcode_CMP;
	assign _zz_decode_shortPipHit_2 = decode_input_payload_opcode == FpuOpcode_F2I;
	assign _zz_decode_shortPipHit_3 = decode_input_payload_opcode == FpuOpcode_STORE;
	assign _zz__zz_load_s1_fsm_shift_by = load_s1_fsm_ohInput[9];
	assign _zz__zz_load_s1_fsm_shift_by_1 = load_s1_fsm_ohInput[10];
	assign _zz__zz_load_s1_fsm_shift_by_2 = {load_s1_fsm_ohInput[11], load_s1_fsm_ohInput[12], load_s1_fsm_ohInput[13], load_s1_fsm_ohInput[14], load_s1_fsm_ohInput[15], load_s1_fsm_ohInput[16], load_s1_fsm_ohInput[17], load_s1_fsm_ohInput[18], load_s1_fsm_ohInput[19], _zz__zz_load_s1_fsm_shift_by_3, _zz__zz_load_s1_fsm_shift_by_4, _zz__zz_load_s1_fsm_shift_by_5};
	assign _zz__zz_load_s1_fsm_shift_by_3 = load_s1_fsm_ohInput[20];
	assign _zz__zz_load_s1_fsm_shift_by_4 = load_s1_fsm_ohInput[21];
	assign _zz__zz_load_s1_fsm_shift_by_5 = {load_s1_fsm_ohInput[22], load_s1_fsm_ohInput[23], load_s1_fsm_ohInput[24], load_s1_fsm_ohInput[25], load_s1_fsm_ohInput[26], load_s1_fsm_ohInput[27], load_s1_fsm_ohInput[28], load_s1_fsm_ohInput[29], load_s1_fsm_ohInput[30], _zz__zz_load_s1_fsm_shift_by_6, _zz__zz_load_s1_fsm_shift_by_7, _zz__zz_load_s1_fsm_shift_by_8};
	assign _zz__zz_load_s1_fsm_shift_by_6 = load_s1_fsm_ohInput[31];
	assign _zz__zz_load_s1_fsm_shift_by_7 = load_s1_fsm_ohInput[32];
	assign _zz__zz_load_s1_fsm_shift_by_8 = {load_s1_fsm_ohInput[33], load_s1_fsm_ohInput[34], load_s1_fsm_ohInput[35], load_s1_fsm_ohInput[36], load_s1_fsm_ohInput[37], load_s1_fsm_ohInput[38], load_s1_fsm_ohInput[39], load_s1_fsm_ohInput[40], load_s1_fsm_ohInput[41], _zz__zz_load_s1_fsm_shift_by_9, _zz__zz_load_s1_fsm_shift_by_10, _zz__zz_load_s1_fsm_shift_by_11};
	assign _zz__zz_load_s1_fsm_shift_by_9 = load_s1_fsm_ohInput[42];
	assign _zz__zz_load_s1_fsm_shift_by_10 = load_s1_fsm_ohInput[43];
	assign _zz__zz_load_s1_fsm_shift_by_11 = {load_s1_fsm_ohInput[44], load_s1_fsm_ohInput[45], load_s1_fsm_ohInput[46], load_s1_fsm_ohInput[47], load_s1_fsm_ohInput[48], load_s1_fsm_ohInput[49], load_s1_fsm_ohInput[50], load_s1_fsm_ohInput[51]};
	assign _zz__zz_add_oh_shift = add_oh_output_payload_xyMantissa[9];
	assign _zz__zz_add_oh_shift_1 = add_oh_output_payload_xyMantissa[10];
	assign _zz__zz_add_oh_shift_2 = {add_oh_output_payload_xyMantissa[11], add_oh_output_payload_xyMantissa[12], add_oh_output_payload_xyMantissa[13], add_oh_output_payload_xyMantissa[14], add_oh_output_payload_xyMantissa[15], add_oh_output_payload_xyMantissa[16], add_oh_output_payload_xyMantissa[17], add_oh_output_payload_xyMantissa[18], add_oh_output_payload_xyMantissa[19], _zz__zz_add_oh_shift_3, _zz__zz_add_oh_shift_4, _zz__zz_add_oh_shift_5};
	assign _zz__zz_add_oh_shift_3 = add_oh_output_payload_xyMantissa[20];
	assign _zz__zz_add_oh_shift_4 = add_oh_output_payload_xyMantissa[21];
	assign _zz__zz_add_oh_shift_5 = {add_oh_output_payload_xyMantissa[22], add_oh_output_payload_xyMantissa[23], add_oh_output_payload_xyMantissa[24], add_oh_output_payload_xyMantissa[25], add_oh_output_payload_xyMantissa[26], add_oh_output_payload_xyMantissa[27], add_oh_output_payload_xyMantissa[28], add_oh_output_payload_xyMantissa[29], add_oh_output_payload_xyMantissa[30], _zz__zz_add_oh_shift_6, _zz__zz_add_oh_shift_7, _zz__zz_add_oh_shift_8};
	assign _zz__zz_add_oh_shift_6 = add_oh_output_payload_xyMantissa[31];
	assign _zz__zz_add_oh_shift_7 = add_oh_output_payload_xyMantissa[32];
	assign _zz__zz_add_oh_shift_8 = {add_oh_output_payload_xyMantissa[33], add_oh_output_payload_xyMantissa[34], add_oh_output_payload_xyMantissa[35], add_oh_output_payload_xyMantissa[36], add_oh_output_payload_xyMantissa[37], add_oh_output_payload_xyMantissa[38], add_oh_output_payload_xyMantissa[39], add_oh_output_payload_xyMantissa[40], add_oh_output_payload_xyMantissa[41], _zz__zz_add_oh_shift_9, _zz__zz_add_oh_shift_10, _zz__zz_add_oh_shift_11};
	assign _zz__zz_add_oh_shift_9 = add_oh_output_payload_xyMantissa[42];
	assign _zz__zz_add_oh_shift_10 = add_oh_output_payload_xyMantissa[43];
	assign _zz__zz_add_oh_shift_11 = {add_oh_output_payload_xyMantissa[44], add_oh_output_payload_xyMantissa[45], add_oh_output_payload_xyMantissa[46], add_oh_output_payload_xyMantissa[47], add_oh_output_payload_xyMantissa[48], add_oh_output_payload_xyMantissa[49], add_oh_output_payload_xyMantissa[50], add_oh_output_payload_xyMantissa[51], add_oh_output_payload_xyMantissa[52], _zz__zz_add_oh_shift_12, _zz__zz_add_oh_shift_13, _zz__zz_add_oh_shift_14};
	assign _zz__zz_add_oh_shift_12 = add_oh_output_payload_xyMantissa[53];
	assign _zz__zz_add_oh_shift_13 = add_oh_output_payload_xyMantissa[54];
	assign _zz__zz_add_oh_shift_14 = add_oh_output_payload_xyMantissa[55];
	assign _zz_roundFront_exactMask_1 = roundFront_discardCount_1 > 6'h2f;
	assign _zz_roundFront_exactMask_2 = roundFront_discardCount_1 > 6'h2e;
	assign _zz_roundFront_exactMask_3 = {roundFront_discardCount_1 > 6'h2d, roundFront_discardCount_1 > 6'h2c, roundFront_discardCount_1 > 6'h2b, roundFront_discardCount_1 > 6'h2a, roundFront_discardCount_1 > 6'h29, roundFront_discardCount_1 > _zz_roundFront_exactMask_4, _zz_roundFront_exactMask_5, _zz_roundFront_exactMask_6, _zz_roundFront_exactMask_7};
	assign _zz_roundFront_exactMask_5 = roundFront_discardCount_1 > 6'h27;
	assign _zz_roundFront_exactMask_6 = roundFront_discardCount_1 > 6'h26;
	assign _zz_roundFront_exactMask_7 = {roundFront_discardCount_1 > 6'h25, roundFront_discardCount_1 > 6'h24, roundFront_discardCount_1 > 6'h23, roundFront_discardCount_1 > 6'h22, roundFront_discardCount_1 > 6'h21, roundFront_discardCount_1 > _zz_roundFront_exactMask_8, _zz_roundFront_exactMask_9, _zz_roundFront_exactMask_10, _zz_roundFront_exactMask_11};
	assign _zz_roundFront_exactMask_9 = roundFront_discardCount_1 > 6'h1f;
	assign _zz_roundFront_exactMask_10 = roundFront_discardCount_1 > 6'h1e;
	assign _zz_roundFront_exactMask_11 = {roundFront_discardCount_1 > 6'h1d, roundFront_discardCount_1 > 6'h1c, roundFront_discardCount_1 > 6'h1b, roundFront_discardCount_1 > 6'h1a, roundFront_discardCount_1 > 6'h19, roundFront_discardCount_1 > _zz_roundFront_exactMask_12, _zz_roundFront_exactMask_13, _zz_roundFront_exactMask_14, _zz_roundFront_exactMask_15};
	assign _zz_roundFront_exactMask_13 = roundFront_discardCount_1 > 6'h17;
	assign _zz_roundFront_exactMask_14 = roundFront_discardCount_1 > 6'h16;
	assign _zz_roundFront_exactMask_15 = {roundFront_discardCount_1 > 6'h15, roundFront_discardCount_1 > 6'h14, roundFront_discardCount_1 > 6'h13, roundFront_discardCount_1 > 6'h12, roundFront_discardCount_1 > 6'h11, roundFront_discardCount_1 > _zz_roundFront_exactMask_16, _zz_roundFront_exactMask_17, _zz_roundFront_exactMask_18, _zz_roundFront_exactMask_19};
	assign _zz_roundFront_exactMask_17 = roundFront_discardCount_1 > 6'h0f;
	assign _zz_roundFront_exactMask_18 = roundFront_discardCount_1 > 6'h0e;
	assign _zz_roundFront_exactMask_19 = {roundFront_discardCount_1 > 6'h0d, roundFront_discardCount_1 > 6'h0c, roundFront_discardCount_1 > 6'h0b, roundFront_discardCount_1 > 6'h0a, roundFront_discardCount_1 > 6'h09, roundFront_discardCount_1 > _zz_roundFront_exactMask_20, _zz_roundFront_exactMask_21, _zz_roundFront_exactMask_22, _zz_roundFront_exactMask_23};
	assign _zz_roundFront_exactMask_21 = roundFront_discardCount_1 > 6'h07;
	assign _zz_roundFront_exactMask_22 = roundFront_discardCount_1 > 6'h06;
	assign _zz_roundFront_exactMask_23 = {roundFront_discardCount_1 > 6'h05, roundFront_discardCount_1 > 6'h04, roundFront_discardCount_1 > 6'h03, roundFront_discardCount_1 > 6'h02, roundFront_discardCount_1 > 6'h01, roundFront_discardCount_1 > 6'h00, 1'b1};
	assign rf_init_done = rf_init_counter[5];
	assign when_FpuCore_l163 = ~|rf_init_done;
	assign streamFork_1_io_outputs_1_ready = ~|FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid;
	assign _zz_payload_opcode = (FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid ? FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode : streamFork_1_io_outputs_1_payload_opcode);
	assign FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_rd = (FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid ? FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_rd : streamFork_1_io_outputs_1_payload_rd);
	assign FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_write = (FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid ? FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_write : streamFork_1_io_outputs_1_payload_write);
	assign FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_value = (FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid ? FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_value : streamFork_1_io_outputs_1_payload_value);
	assign commitLogic_0_pending_full = &commitLogic_0_pending_counter;
	assign commitLogic_0_pending_notEmpty = |commitLogic_0_pending_counter;
	assign commitLogic_0_add_full = &commitLogic_0_add_counter;
	assign commitLogic_0_add_notEmpty = |commitLogic_0_add_counter;
	assign commitLogic_0_mul_full = &commitLogic_0_mul_counter;
	assign commitLogic_0_mul_notEmpty = |commitLogic_0_mul_counter;
	assign commitLogic_0_div_full = &commitLogic_0_div_counter;
	assign commitLogic_0_div_notEmpty = |commitLogic_0_div_counter;
	assign commitLogic_0_sqrt_full = &commitLogic_0_sqrt_counter;
	assign commitLogic_0_sqrt_notEmpty = |commitLogic_0_sqrt_counter;
	assign commitLogic_0_short_full = &commitLogic_0_short_counter;
	assign commitLogic_0_short_notEmpty = |commitLogic_0_short_counter;
	assign _zz_commitFork_commit_0_ready = ~|(({commitLogic_0_short_full, commitLogic_0_sqrt_full, commitLogic_0_div_full, commitLogic_0_mul_full, commitLogic_0_add_full} != 5'h00) | ~|commitLogic_0_pending_notEmpty);
	assign when_FpuCore_l209 = {commitLogic_0_input_payload_opcode == FpuOpcode_FMA, commitLogic_0_input_payload_opcode == FpuOpcode_MUL} != 2'h0;
	assign when_FpuCore_l212 = {commitLogic_0_input_payload_opcode == FpuOpcode_FCVT_X_X, commitLogic_0_input_payload_opcode == FpuOpcode_MIN_MAX, commitLogic_0_input_payload_opcode == FpuOpcode_SGNJ} != 3'h0;
	assign io_port_0_cmd_ready = ~|io_port_0_cmd_rValid;
	assign _zz_scheduler_0_input_payload_opcode = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_opcode : io_port_0_cmd_payload_opcode);
	assign _zz_scheduler_0_input_payload_format = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_format : io_port_0_cmd_payload_format);
	assign _zz_scheduler_0_input_payload_roundMode = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_roundMode : io_port_0_cmd_payload_roundMode);
	assign scheduler_0_input_payload_arg = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_arg : io_port_0_cmd_payload_arg);
	assign scheduler_0_input_payload_rs1 = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_rs1 : io_port_0_cmd_payload_rs1);
	assign scheduler_0_input_payload_rs2 = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_rs2 : io_port_0_cmd_payload_rs2);
	assign scheduler_0_input_payload_rs3 = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_rs3 : io_port_0_cmd_payload_rs3);
	assign scheduler_0_input_payload_rd = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_rd : io_port_0_cmd_payload_rd);
	assign _zz_scheduler_0_input_ready = ~|scheduler_0_hazard;
	assign when_FpuCore_l258 = scheduler_0_input_payload_opcode == FpuOpcode_STORE;
	assign when_Stream_l368 = ~|read_s1_valid;
	assign _zz_read_rs_0_boxed_1 = ~|read_output_isStall;
	assign _zz_read_rs_0_value_mantissa = _zz_read_rs_0_boxed_2[65:0];
	assign read_rs_0_value_mantissa = _zz_read_rs_0_value_mantissa[51:0];
	assign read_rs_0_value_exponent = _zz_read_rs_0_value_mantissa[63:52];
	assign read_rs_0_value_sign = _zz_read_rs_0_value_mantissa[64];
	assign read_rs_0_value_special = _zz_read_rs_0_value_mantissa[65];
	assign read_rs_0_boxed = _zz_read_rs_0_boxed_2[66];
	assign _zz_read_rs_1_boxed_1 = ~|read_output_isStall_1;
	assign _zz_read_rs_1_value_mantissa = _zz_read_rs_1_boxed_2[65:0];
	assign read_rs_1_value_mantissa = _zz_read_rs_1_value_mantissa[51:0];
	assign read_rs_1_value_exponent = _zz_read_rs_1_value_mantissa[63:52];
	assign read_rs_1_value_sign = _zz_read_rs_1_value_mantissa[64];
	assign read_rs_1_value_special = _zz_read_rs_1_value_mantissa[65];
	assign read_rs_1_boxed = _zz_read_rs_1_boxed_2[66];
	assign _zz_read_rs_2_boxed_1 = ~|read_output_isStall_2;
	assign _zz_read_rs_2_value_mantissa = _zz_read_rs_2_boxed_2[65:0];
	assign read_rs_2_value_mantissa = _zz_read_rs_2_value_mantissa[51:0];
	assign read_rs_2_value_exponent = _zz_read_rs_2_value_mantissa[63:52];
	assign read_rs_2_value_sign = _zz_read_rs_2_value_mantissa[64];
	assign read_rs_2_value_special = _zz_read_rs_2_value_mantissa[65];
	assign read_rs_2_boxed = _zz_read_rs_2_boxed_2[66];
	assign when_FpuCore_l304 = ~|((read_s1_payload_opcode == FpuOpcode_SGNJ) & (read_s1_payload_format ~^ FpuFormat_DOUBLE));
	assign _zz_read_output_payload_format = (read_rs_0_boxed ? FpuFormat_FLOAT : FpuFormat_DOUBLE);
	assign decode_loadHit = {decode_input_payload_opcode == FpuOpcode_I2F, decode_input_payload_opcode == FpuOpcode_FMV_W_X, decode_input_payload_opcode == FpuOpcode_LOAD} != 3'h0;
	assign decode_load_payload_i2f = decode_input_payload_opcode == FpuOpcode_I2F;
	assign decode_shortPipHit = {decode_input_payload_opcode == FpuOpcode_FCVT_X_X, decode_input_payload_opcode == FpuOpcode_FCLASS, decode_input_payload_opcode == FpuOpcode_FMV_X_W, decode_input_payload_opcode == FpuOpcode_SGNJ, decode_input_payload_opcode == _zz_decode_shortPipHit, _zz_decode_shortPipHit_1, _zz_decode_shortPipHit_2, _zz_decode_shortPipHit_3} != 8'h00;
	assign decode_divHit = decode_input_payload_opcode == FpuOpcode_DIV;
	assign decode_sqrtHit = decode_input_payload_opcode == FpuOpcode_SQRT;
	assign decode_fmaHit = decode_input_payload_opcode == FpuOpcode_FMA;
	assign when_FpuCore_l380 = ~|decode_divSqrtToMul_valid;
	assign decode_addHit = decode_input_payload_opcode == FpuOpcode_ADD;
	assign when_FpuCore_l404 = ~|decode_mulToAdd_valid;
	assign decode_load_ready = ~|decode_load_rValid;
	assign _zz_decode_load_s2mPipe_payload_roundMode = (decode_load_rValid ? decode_load_rData_roundMode : decode_load_payload_roundMode);
	assign _zz_decode_load_s2mPipe_payload_format = (decode_load_rValid ? decode_load_rData_format : decode_load_payload_format);
	assign decode_load_s2mPipe_payload_rd = (decode_load_rValid ? decode_load_rData_rd : decode_load_payload_rd);
	assign decode_load_s2mPipe_payload_i2f = (decode_load_rValid ? decode_load_rData_i2f : decode_load_payload_i2f);
	assign decode_load_s2mPipe_payload_arg = (decode_load_rValid ? decode_load_rData_arg : decode_load_payload_arg);
	assign when_Stream_l368_1 = ~|decode_load_s2mPipe_m2sPipe_valid;
	assign when_Stream_l368_2 = ~|load_s0_input_valid;
	assign when_Stream_l438 = {commitFork_load_0_payload_opcode == FpuOpcode_I2F, commitFork_load_0_payload_opcode == FpuOpcode_FMV_W_X, commitFork_load_0_payload_opcode == FpuOpcode_LOAD} == 3'h0;
	assign load_s0_hazard = ~|load_s0_filtred_0_valid;
	assign _zz_load_s0_input_ready = ~|load_s0_hazard;
	assign when_Stream_l368_3 = ~|load_s1_input_valid;
	assign load_s1_f32_mantissa = load_s1_input_payload_value[22:0];
	assign load_s1_f32_exponent = load_s1_input_payload_value[30:23];
	assign load_s1_f32_sign = load_s1_input_payload_value[31];
	assign load_s1_f64_mantissa = load_s1_input_payload_value[51:0];
	assign load_s1_f64_exponent = load_s1_input_payload_value[62:52];
	assign load_s1_f64_sign = load_s1_input_payload_value[63];
	assign load_s1_manZero = load_s1_passThroughFloat_mantissa == 52'h0000000000000;
	assign when_FpuCore_l508 = ~|load_s1_input_payload_i2f;
	assign when_FpuCore_l525 = ~|load_s1_fsm_done;
	assign _zz_load_s1_fsm_shift_by = {load_s1_fsm_ohInput[0], load_s1_fsm_ohInput[1], load_s1_fsm_ohInput[2], load_s1_fsm_ohInput[3], load_s1_fsm_ohInput[4], load_s1_fsm_ohInput[5], load_s1_fsm_ohInput[6], load_s1_fsm_ohInput[7], load_s1_fsm_ohInput[8], _zz__zz_load_s1_fsm_shift_by, _zz__zz_load_s1_fsm_shift_by_1, _zz__zz_load_s1_fsm_shift_by_2};
	assign _zz_load_s1_fsm_shift_by_2 = _zz_load_s1_fsm_shift_by_1[3];
	assign _zz_load_s1_fsm_shift_by_3 = _zz_load_s1_fsm_shift_by_1[5];
	assign _zz_load_s1_fsm_shift_by_4 = _zz_load_s1_fsm_shift_by_1[6];
	assign _zz_load_s1_fsm_shift_by_5 = _zz_load_s1_fsm_shift_by_1[7];
	assign _zz_load_s1_fsm_shift_by_6 = _zz_load_s1_fsm_shift_by_1[9];
	assign _zz_load_s1_fsm_shift_by_7 = _zz_load_s1_fsm_shift_by_1[10];
	assign _zz_load_s1_fsm_shift_by_8 = _zz_load_s1_fsm_shift_by_1[11];
	assign _zz_load_s1_fsm_shift_by_9 = _zz_load_s1_fsm_shift_by_1[12];
	assign _zz_load_s1_fsm_shift_by_10 = _zz_load_s1_fsm_shift_by_1[13];
	assign _zz_load_s1_fsm_shift_by_11 = _zz_load_s1_fsm_shift_by_1[14];
	assign _zz_load_s1_fsm_shift_by_12 = _zz_load_s1_fsm_shift_by_1[15];
	assign _zz_load_s1_fsm_shift_by_13 = _zz_load_s1_fsm_shift_by_1[17];
	assign _zz_load_s1_fsm_shift_by_14 = _zz_load_s1_fsm_shift_by_1[18];
	assign _zz_load_s1_fsm_shift_by_15 = _zz_load_s1_fsm_shift_by_1[19];
	assign _zz_load_s1_fsm_shift_by_16 = _zz_load_s1_fsm_shift_by_1[20];
	assign _zz_load_s1_fsm_shift_by_17 = _zz_load_s1_fsm_shift_by_1[21];
	assign _zz_load_s1_fsm_shift_by_18 = _zz_load_s1_fsm_shift_by_1[22];
	assign _zz_load_s1_fsm_shift_by_19 = _zz_load_s1_fsm_shift_by_1[23];
	assign _zz_load_s1_fsm_shift_by_20 = _zz_load_s1_fsm_shift_by_1[24];
	assign _zz_load_s1_fsm_shift_by_21 = _zz_load_s1_fsm_shift_by_1[25];
	assign _zz_load_s1_fsm_shift_by_22 = _zz_load_s1_fsm_shift_by_1[26];
	assign _zz_load_s1_fsm_shift_by_23 = _zz_load_s1_fsm_shift_by_1[27];
	assign _zz_load_s1_fsm_shift_by_24 = _zz_load_s1_fsm_shift_by_1[28];
	assign _zz_load_s1_fsm_shift_by_25 = _zz_load_s1_fsm_shift_by_1[29];
	assign _zz_load_s1_fsm_shift_by_26 = _zz_load_s1_fsm_shift_by_1[30];
	assign _zz_load_s1_fsm_shift_by_27 = _zz_load_s1_fsm_shift_by_1[31];
	assign _zz_load_s1_fsm_shift_by_28 = _zz_load_s1_fsm_shift_by_1[33];
	assign _zz_load_s1_fsm_shift_by_29 = _zz_load_s1_fsm_shift_by_1[34];
	assign _zz_load_s1_fsm_shift_by_30 = _zz_load_s1_fsm_shift_by_1[35];
	assign _zz_load_s1_fsm_shift_by_31 = _zz_load_s1_fsm_shift_by_1[36];
	assign _zz_load_s1_fsm_shift_by_32 = _zz_load_s1_fsm_shift_by_1[37];
	assign _zz_load_s1_fsm_shift_by_33 = _zz_load_s1_fsm_shift_by_1[38];
	assign _zz_load_s1_fsm_shift_by_34 = _zz_load_s1_fsm_shift_by_1[39];
	assign _zz_load_s1_fsm_shift_by_35 = _zz_load_s1_fsm_shift_by_1[40];
	assign _zz_load_s1_fsm_shift_by_36 = _zz_load_s1_fsm_shift_by_1[41];
	assign _zz_load_s1_fsm_shift_by_37 = _zz_load_s1_fsm_shift_by_1[42];
	assign _zz_load_s1_fsm_shift_by_38 = _zz_load_s1_fsm_shift_by_1[43];
	assign _zz_load_s1_fsm_shift_by_39 = _zz_load_s1_fsm_shift_by_1[44];
	assign _zz_load_s1_fsm_shift_by_40 = _zz_load_s1_fsm_shift_by_1[45];
	assign _zz_load_s1_fsm_shift_by_41 = _zz_load_s1_fsm_shift_by_1[46];
	assign _zz_load_s1_fsm_shift_by_42 = _zz_load_s1_fsm_shift_by_1[47];
	assign _zz_load_s1_fsm_shift_by_43 = _zz_load_s1_fsm_shift_by_1[48];
	assign _zz_load_s1_fsm_shift_by_44 = _zz_load_s1_fsm_shift_by_1[49];
	assign _zz_load_s1_fsm_shift_by_45 = _zz_load_s1_fsm_shift_by_1[50];
	assign _zz_load_s1_fsm_shift_by_46 = _zz_load_s1_fsm_shift_by_1[51];
	assign when_FpuCore_l551 = ~|load_s1_input_isStall;
	assign _zz_load_s1_input_ready = ~|load_s1_busy;
	assign when_Stream_l368_4 = ~|shortPip_input_valid;
	assign shortPip_toFpuRf = {shortPip_input_payload_opcode == FpuOpcode_FCVT_X_X, shortPip_input_payload_opcode == FpuOpcode_SGNJ, shortPip_input_payload_opcode == FpuOpcode_MIN_MAX} != 3'h0;
	assign _zz_shortPip_rfOutput_ready = ~|(~|shortPip_isCommited);
	assign shortPip_f32_exp = _zz_shortPip_f32_exp[7:0];
	assign shortPip_f32_man = shortPip_input_payload_rs1_mantissa[51:29];
	assign shortPip_f64_exp = _zz_shortPip_f64_exp[10:0];
	assign shortPip_expSubnormalThreshold = (shortPip_input_payload_format ~^ FpuFormat_DOUBLE ? 11'h400 : 11'h780);
	assign shortPip_expInSubnormalRange = _zz_shortPip_expInSubnormalRange >= shortPip_input_payload_rs1_exponent;
	assign shortPip_fsm_f2iShift = shortPip_input_payload_rs1_exponent - 12'h7ff;
	assign shortPip_fsm_isF2i = shortPip_input_payload_opcode == FpuOpcode_F2I;
	assign when_FpuCore_l652 = ~|shortPip_fsm_done;
	assign shortPip_fsm_formatShiftOffset = (shortPip_input_payload_format ~^ FpuFormat_DOUBLE ? 11'h401 : 11'h75e);
	assign _zz_shortPip_fsm_shift_by = 12'h81e - shortPip_input_payload_rs1_exponent;
	assign when_FpuCore_l672 = ~|shortPip_input_isStall;
	assign switch_FpuCore_l686 = shortPip_input_payload_rs1_exponent[1:0];
	assign when_FpuCore_l702 = shortPip_input_payload_rs1_exponent[2];
	assign shortPip_f2i_unsigned = {1'b0, shortPip_fsm_shift_output[32:1]};
	assign shortPip_f2i_round = {shortPip_fsm_shift_output[0], shortPip_fsm_shift_scrap};
	assign switch_Misc_l226 = {shortPip_input_payload_rs1_sign, shortPip_input_payload_rs2_sign};
	assign shortPip_minMaxSelectRs2 = ~|(((shortPip_rs1Smaller ^ shortPip_input_payload_arg[0]) & ~|(shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h2))) | (shortPip_input_payload_rs2_special & (shortPip_input_payload_rs2_exponent[1:0] == 2'h2)));
	assign shortPip_decoded_isNormal = ~|shortPip_input_payload_rs1_special;
	assign shortPip_decoded_isQuiet = shortPip_input_payload_rs1_mantissa[51];
	assign when_FpuCore_l850 = ~|(shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h2));
	assign _zz_shortPip_rfOutput_payload_format = (shortPip_input_payload_format ~^ FpuFormat_FLOAT ? FpuFormat_DOUBLE : FpuFormat_FLOAT);
	assign when_Stream_l368_5 = ~|shortPip_rspStreams_0_m2sPipe_valid;
	assign when_Stream_l368_6 = ~|mul_preMul_input_valid;
	assign mul_preMul_output_payload_exp = {1'b0, mul_preMul_input_payload_rs1_exponent} + {1'b0, mul_preMul_input_payload_rs2_exponent};
	assign when_Stream_l368_7 = ~|mul_mul_input_valid;
	assign mul_mul_mulA = {mul_mul_input_payload_msb1, mul_mul_input_payload_rs1_mantissa};
	assign mul_mul_mulB = {mul_mul_input_payload_msb2, mul_mul_input_payload_rs2_mantissa};
	assign mul_mul_output_payload_muls_0 = {18'h00000, mul_mul_mulA[17:0]} * {18'h00000, mul_mul_mulB[17:0]};
	assign mul_mul_output_payload_muls_1 = {18'h00000, mul_mul_mulA[17:0]} * {18'h00000, mul_mul_mulB[35:18]};
	assign mul_mul_output_payload_muls_2 = {18'h00000, mul_mul_mulA[35:18]} * {18'h00000, mul_mul_mulB[17:0]};
	assign mul_mul_output_payload_muls_3 = {17'h00000, mul_mul_mulA[17:0]} * {18'h00000, mul_mul_mulB[52:36]};
	assign mul_mul_output_payload_muls_4 = {18'h00000, mul_mul_mulA[52:36]} * {17'h00000, mul_mul_mulB[17:0]};
	assign mul_mul_output_payload_muls_5 = {18'h00000, mul_mul_mulA[35:18]} * {18'h00000, mul_mul_mulB[35:18]};
	assign mul_mul_output_payload_muls_6 = {17'h00000, mul_mul_mulA[35:18]} * {18'h00000, mul_mul_mulB[52:36]};
	assign mul_mul_output_payload_muls_7 = {18'h00000, mul_mul_mulA[52:36]} * {17'h00000, mul_mul_mulB[35:18]};
	assign mul_mul_output_payload_muls_8 = {17'h00000, mul_mul_mulA[52:36]} * {17'h00000, mul_mul_mulB[52:36]};
	assign when_Stream_l368_8 = ~|mul_sum1_input_valid;
	assign mul_sum1_sum = _zz_mul_sum1_sum + _zz_mul_sum1_sum_4;
	assign when_Stream_l368_9 = ~|mul_sum2_input_valid;
	assign mul_sum2_sum = mul_sum2_input_payload_mulC2 + _zz_mul_sum2_sum;
	assign _zz_mul_sum2_input_ready = ~|(~|mul_sum2_isCommited);
	assign when_Stream_l368_10 = ~|mul_norm_input_valid;
	assign mul_norm_mulHigh = mul_norm_input_payload_mulC[105:51];
	assign mul_norm_mulLow = mul_norm_input_payload_mulC[50:0];
	assign mul_norm_needShift = mul_norm_mulHigh[54];
	assign mul_norm_exp = mul_norm_input_payload_exp + _zz_mul_norm_exp;
	assign mul_norm_man = (mul_norm_needShift ? mul_norm_mulHigh[53:1] : mul_norm_mulHigh[52:0]);
	assign mul_norm_underflowThreshold = (mul_norm_input_payload_format ~^ FpuFormat_DOUBLE ? 12'hbca : 12'hf67);
	assign mul_norm_underflowExp = (mul_norm_input_payload_format ~^ FpuFormat_DOUBLE ? 11'h3ca : 11'h767);
	assign mul_norm_forceUnderflow = _zz_mul_norm_forceUnderflow > mul_norm_exp;
	assign when_FpuCore_l983 = mul_norm_exp[12:10] >= 3'h5;
	assign mul_result_notMul_output_payload = mul_norm_input_payload_mulC[104:52];
	assign when_Stream_l368_11 = ~|mul_result_mulToAdd_m2sPipe_valid;
	assign mul_result_mulToAdd_payload_rs2_mantissa = {2'h0, mul_norm_input_payload_rs3_mantissa, 2'h0};
	assign decode_div_ready = ~|decode_div_rValid;
	assign _zz_div_input_ready = ~|(div_haltIt | ~|div_isCommited);
	assign when_FpuCore_l1056 = ~|div_haltIt;
	assign div_needShift = ~|div_dividerResult[54];
	assign div_mantissa = (div_needShift ? div_dividerResult[52:0] : div_dividerResult[53:1]);
	assign div_exponent = _zz_div_exponent - _zz_div_exponent_4;
	assign when_FpuCore_l1072 = div_exponent[13:12] == 2'h3;
	assign div_underflowThreshold = (div_input_payload_format ~^ FpuFormat_DOUBLE ? 14'h23cb : 14'h2768);
	assign div_underflowExp = (div_input_payload_format ~^ FpuFormat_DOUBLE ? 14'h23ca : 14'h2767);
	assign div_forceUnderflow = div_underflowThreshold > div_exponent;
	assign when_FpuCore_l1089 = div_exponent[13:11] == 3'h7;
	assign decode_sqrt_ready = ~|decode_sqrt_rValid;
	assign _zz_sqrt_input_ready = ~|(sqrt_haltIt | ~|sqrt_isCommited);
	assign sqrt_needShift = ~|sqrt_input_payload_rs1_exponent[0];
	assign sqrt_sqrt_io_input_payload_a = (sqrt_needShift ? {1'b1, sqrt_input_payload_rs1_mantissa, 1'b0} : {2'h1, sqrt_input_payload_rs1_mantissa});
	assign when_FpuCore_l1118 = ~|sqrt_haltIt;
	assign sqrt_scrap = sqrt_sqrt_io_output_payload_remain != 57'h000000000000000;
	assign add_preShifter_exp21 = {1'b0, add_preShifter_input_payload_rs2_exponent} - {1'b0, add_preShifter_input_payload_rs1_exponent};
	assign add_preShifter_rs1ExponentEqual = add_preShifter_input_payload_rs1_exponent == add_preShifter_input_payload_rs2_exponent;
	assign add_preShifter_rs1MantissaBigger = add_preShifter_input_payload_rs1_mantissa > add_preShifter_input_payload_rs2_mantissa;
	assign when_Stream_l368_12 = ~|add_shifter_input_valid;
	assign add_shifter_exp21 = {1'b0, add_shifter_input_payload_rs2_exponent} - {1'b0, add_shifter_input_payload_rs1_exponent};
	assign add_shifter_shiftBy = _zz_add_shifter_shiftBy_1 + _zz_add_shifter_shiftBy_3;
	assign add_shifter_shiftOverflow = add_shifter_shiftBy >= 13'h0037;
	assign add_shifter_xySign = (add_shifter_input_payload_absRs1Bigger ? add_shifter_input_payload_rs1_sign : add_shifter_input_payload_rs2_sign);
	assign add_shifter_xMantissa = {1'b1, (add_shifter_input_payload_rs1ExponentBigger ? add_shifter_input_payload_rs1_mantissa : add_shifter_input_payload_rs2_mantissa)};
	assign add_shifter_yMantissaUnshifted = {1'b1, (add_shifter_input_payload_rs1ExponentBigger ? add_shifter_input_payload_rs2_mantissa : add_shifter_input_payload_rs1_mantissa)};
	assign add_shifter_output_payload_xyExponent = (add_shifter_input_payload_rs1ExponentBigger ? add_shifter_input_payload_rs1_exponent : add_shifter_input_payload_rs2_exponent);
	assign when_Stream_l368_13 = ~|add_math_input_valid;
	assign add_math_output_payload_xyMantissa = _zz_add_math_output_payload_xyMantissa[55:0];
	assign when_Stream_l368_14 = ~|add_oh_input_valid;
	assign _zz_add_oh_input_ready = ~|(add_oh_input_payload_needCommit & ~|add_oh_isCommited);
	assign _zz_add_oh_shift = {add_oh_output_payload_xyMantissa[0], add_oh_output_payload_xyMantissa[1], add_oh_output_payload_xyMantissa[2], add_oh_output_payload_xyMantissa[3], add_oh_output_payload_xyMantissa[4], add_oh_output_payload_xyMantissa[5], add_oh_output_payload_xyMantissa[6], add_oh_output_payload_xyMantissa[7], add_oh_output_payload_xyMantissa[8], _zz__zz_add_oh_shift, _zz__zz_add_oh_shift_1, _zz__zz_add_oh_shift_2};
	assign _zz_add_oh_shift_2 = _zz_add_oh_shift_1[3];
	assign _zz_add_oh_shift_3 = _zz_add_oh_shift_1[5];
	assign _zz_add_oh_shift_4 = _zz_add_oh_shift_1[6];
	assign _zz_add_oh_shift_5 = _zz_add_oh_shift_1[7];
	assign _zz_add_oh_shift_6 = _zz_add_oh_shift_1[9];
	assign _zz_add_oh_shift_7 = _zz_add_oh_shift_1[10];
	assign _zz_add_oh_shift_8 = _zz_add_oh_shift_1[11];
	assign _zz_add_oh_shift_9 = _zz_add_oh_shift_1[12];
	assign _zz_add_oh_shift_10 = _zz_add_oh_shift_1[13];
	assign _zz_add_oh_shift_11 = _zz_add_oh_shift_1[14];
	assign _zz_add_oh_shift_12 = _zz_add_oh_shift_1[15];
	assign _zz_add_oh_shift_13 = _zz_add_oh_shift_1[17];
	assign _zz_add_oh_shift_14 = _zz_add_oh_shift_1[18];
	assign _zz_add_oh_shift_15 = _zz_add_oh_shift_1[19];
	assign _zz_add_oh_shift_16 = _zz_add_oh_shift_1[20];
	assign _zz_add_oh_shift_17 = _zz_add_oh_shift_1[21];
	assign _zz_add_oh_shift_18 = _zz_add_oh_shift_1[22];
	assign _zz_add_oh_shift_19 = _zz_add_oh_shift_1[23];
	assign _zz_add_oh_shift_20 = _zz_add_oh_shift_1[24];
	assign _zz_add_oh_shift_21 = _zz_add_oh_shift_1[25];
	assign _zz_add_oh_shift_22 = _zz_add_oh_shift_1[26];
	assign _zz_add_oh_shift_23 = _zz_add_oh_shift_1[27];
	assign _zz_add_oh_shift_24 = _zz_add_oh_shift_1[28];
	assign _zz_add_oh_shift_25 = _zz_add_oh_shift_1[29];
	assign _zz_add_oh_shift_26 = _zz_add_oh_shift_1[30];
	assign _zz_add_oh_shift_27 = _zz_add_oh_shift_1[31];
	assign _zz_add_oh_shift_28 = _zz_add_oh_shift_1[33];
	assign _zz_add_oh_shift_29 = _zz_add_oh_shift_1[34];
	assign _zz_add_oh_shift_30 = _zz_add_oh_shift_1[35];
	assign _zz_add_oh_shift_31 = _zz_add_oh_shift_1[36];
	assign _zz_add_oh_shift_32 = _zz_add_oh_shift_1[37];
	assign _zz_add_oh_shift_33 = _zz_add_oh_shift_1[38];
	assign _zz_add_oh_shift_34 = _zz_add_oh_shift_1[39];
	assign _zz_add_oh_shift_35 = _zz_add_oh_shift_1[40];
	assign _zz_add_oh_shift_36 = _zz_add_oh_shift_1[41];
	assign _zz_add_oh_shift_37 = _zz_add_oh_shift_1[42];
	assign _zz_add_oh_shift_38 = _zz_add_oh_shift_1[43];
	assign _zz_add_oh_shift_39 = _zz_add_oh_shift_1[44];
	assign _zz_add_oh_shift_40 = _zz_add_oh_shift_1[45];
	assign _zz_add_oh_shift_41 = _zz_add_oh_shift_1[46];
	assign _zz_add_oh_shift_42 = _zz_add_oh_shift_1[47];
	assign _zz_add_oh_shift_43 = _zz_add_oh_shift_1[48];
	assign _zz_add_oh_shift_44 = _zz_add_oh_shift_1[49];
	assign _zz_add_oh_shift_45 = _zz_add_oh_shift_1[50];
	assign _zz_add_oh_shift_46 = _zz_add_oh_shift_1[51];
	assign _zz_add_oh_shift_47 = _zz_add_oh_shift_1[52];
	assign _zz_add_oh_shift_48 = _zz_add_oh_shift_1[53];
	assign _zz_add_oh_shift_49 = _zz_add_oh_shift_1[54];
	assign _zz_add_oh_shift_50 = _zz_add_oh_shift_1[55];
	assign add_oh_shift = {_zz_add_oh_shift_56, _zz_add_oh_shift_55, _zz_add_oh_shift_54, _zz_add_oh_shift_53, _zz_add_oh_shift_52, _zz_add_oh_shift_51};
	assign when_Stream_l368_15 = ~|add_norm_input_valid;
	assign add_norm_output_payload_mantissa = add_norm_input_payload_xyMantissa << add_norm_input_payload_shift;
	assign add_norm_output_payload_exponent = _zz_add_norm_output_payload_exponent + 13'h0001;
	assign add_norm_output_payload_xyMantissaZero = add_norm_input_payload_xyMantissa == 56'h00000000000000;
	assign when_Stream_l368_16 = ~|load_s1_output_m2sPipe_valid;
	assign when_Stream_l368_17 = ~|shortPip_output_m2sPipe_valid;
	assign roundFront_manAggregate = {roundFront_input_payload_value_mantissa, roundFront_input_payload_scrap};
	assign roundFront_expBase = (roundFront_input_payload_format ~^ FpuFormat_DOUBLE ? 11'h401 : 11'h781);
	assign roundFront_expDif = _zz_roundFront_expDif - {1'b0, roundFront_input_payload_value_exponent};
	assign roundFront_discardCount = (roundFront_expSubnormal ? _zz_roundFront_discardCount : 6'h00);
	assign roundFront_exactMask = {roundFront_discardCount_1 > 6'h34, roundFront_discardCount_1 > 6'h33, roundFront_discardCount_1 > 6'h32, roundFront_discardCount_1 > 6'h31, roundFront_discardCount_1 > _zz_roundFront_exactMask, _zz_roundFront_exactMask_1, _zz_roundFront_exactMask_2, _zz_roundFront_exactMask_3};
	assign roundFront_roundAdjusted = {_zz_roundFront_roundAdjusted[roundFront_discardCount_1], (roundFront_manAggregate & roundFront_exactMask) != 54'h00000000000000};
	assign roundBack_adderRightOp = _zz_roundBack_adderRightOp[51:0];
	assign _zz_roundBack_adder = {roundBack_input_payload_value_exponent, roundBack_adderMantissa};
	assign roundBack_adder = _zz_roundBack_adder_2 + _zz_roundBack_adder_4;
	assign roundBack_math_exponent = roundBack_masked[63:52];
	assign roundBack_math_mantissa = roundBack_masked[51:0];
	assign roundBack_ufSubnormalThreshold = (roundBack_input_payload_format ~^ FpuFormat_DOUBLE ? 11'h400 : 11'h780);
	assign roundBack_ufThreshold = (roundBack_input_payload_format ~^ FpuFormat_DOUBLE ? 11'h3cd : 11'h76a);
	assign roundBack_ofThreshold = (roundBack_input_payload_format ~^ FpuFormat_DOUBLE ? 12'hbfe : 12'h87e);
	assign _zz_commitLogic_0_pending_counter_2 = commitLogic_0_pending_inc;
	assign _zz_commitLogic_0_pending_counter_4 = commitLogic_0_pending_dec;
	assign _zz_commitLogic_0_add_counter_2 = commitLogic_0_add_inc;
	assign _zz_commitLogic_0_add_counter_4 = commitLogic_0_add_dec;
	assign _zz_commitLogic_0_mul_counter_2 = commitLogic_0_mul_inc;
	assign _zz_commitLogic_0_mul_counter_4 = commitLogic_0_mul_dec;
	assign _zz_commitLogic_0_div_counter_2 = commitLogic_0_div_inc;
	assign _zz_commitLogic_0_div_counter_4 = commitLogic_0_div_dec;
	assign _zz_commitLogic_0_sqrt_counter_2 = commitLogic_0_sqrt_inc;
	assign _zz_commitLogic_0_sqrt_counter_4 = commitLogic_0_sqrt_dec;
	assign _zz_commitLogic_0_short_counter_2 = commitLogic_0_short_inc;
	assign _zz_commitLogic_0_short_counter_4 = commitLogic_0_short_dec;
	assign _zz_load_s0_output_rData_value_3 = _zz_load_s0_output_rData_value_4;
	assign _zz_load_s0_output_rData_value_6 = _zz_load_s0_output_rData_value_1;
	assign _zz_shortPip_f2i_result_1 = shortPip_f2i_resign ^ shortPip_f2i_increment;
	assign _zz_mul_sum2_sum_12 = _zz_mul_sum2_sum_13;
	assign _zz_mul_norm_exp_1 = mul_norm_needShift;
	assign _zz_div_exponent_5 = div_needShift;
	assign _zz_add_shifter_shiftBy_2 = ~_zz_add_shifter_shiftBy;
	assign _zz_add_math_xSigned_2 = add_math_input_payload_xSign;
	assign _zz_add_math_ySigned_2 = add_math_input_payload_ySign & ~|add_math_input_payload_roundingScrap;
	assign _zz_add_math_output_payload_xyMantissa = _zz_add_math_output_payload_xyMantissa_1;
	assign _zz_rf_scoreboards_0_target_port = rf_scoreboards_0_targetWrite_payload_data;
	assign _zz_rf_scoreboards_0_hit_port = rf_scoreboards_0_hitWrite_payload_data;
	assign _zz_rf_scoreboards_0_writes_port = commitLogic_0_input_payload_write;
	assign _zz__zz_load_s1_fsm_shift_by_47 = ((((((((_zz_load_s1_fsm_shift_by_1[1] | _zz_load_s1_fsm_shift_by_2) | _zz_load_s1_fsm_shift_by_3) | _zz_load_s1_fsm_shift_by_5) | _zz_load_s1_fsm_shift_by_6) | _zz_load_s1_fsm_shift_by_8) | _zz_load_s1_fsm_shift_by_10) | _zz_load_s1_fsm_shift_by_12) | _zz_load_s1_fsm_shift_by_13) | _zz_load_s1_fsm_shift_by_15;
	assign _zz__zz_load_s1_fsm_shift_by_48 = ((((((((_zz_load_s1_fsm_shift_by_1[2] | _zz_load_s1_fsm_shift_by_2) | _zz_load_s1_fsm_shift_by_4) | _zz_load_s1_fsm_shift_by_5) | _zz_load_s1_fsm_shift_by_7) | _zz_load_s1_fsm_shift_by_8) | _zz_load_s1_fsm_shift_by_11) | _zz_load_s1_fsm_shift_by_12) | _zz_load_s1_fsm_shift_by_14) | _zz_load_s1_fsm_shift_by_15;
	assign _zz__zz_load_s1_fsm_shift_by_49 = (((((_zz_load_s1_fsm_shift_by_1[4] | _zz_load_s1_fsm_shift_by_3) | _zz_load_s1_fsm_shift_by_4) | _zz_load_s1_fsm_shift_by_5) | _zz_load_s1_fsm_shift_by_9) | _zz_load_s1_fsm_shift_by_10) | _zz_load_s1_fsm_shift_by_11;
	assign _zz__zz_load_s1_fsm_shift_by_50 = ((((((_zz_load_s1_fsm_shift_by_1[8] | _zz_load_s1_fsm_shift_by_6) | _zz_load_s1_fsm_shift_by_7) | _zz_load_s1_fsm_shift_by_8) | _zz_load_s1_fsm_shift_by_9) | _zz_load_s1_fsm_shift_by_10) | _zz_load_s1_fsm_shift_by_11) | _zz_load_s1_fsm_shift_by_12;
	assign _zz__zz_load_s1_fsm_shift_by_51 = (_zz_load_s1_fsm_shift_by_1[16] | _zz_load_s1_fsm_shift_by_13) | _zz_load_s1_fsm_shift_by_14;
	assign _zz__zz_load_s1_fsm_shift_by_52 = ((_zz_load_s1_fsm_shift_by_1[32] | _zz_load_s1_fsm_shift_by_28) | _zz_load_s1_fsm_shift_by_29) | _zz_load_s1_fsm_shift_by_30;
	assign _zz__zz_add_oh_shift_51 = ((((((((((_zz_add_oh_shift_1[1] | _zz_add_oh_shift_2) | _zz_add_oh_shift_3) | _zz_add_oh_shift_5) | _zz_add_oh_shift_6) | _zz_add_oh_shift_8) | _zz_add_oh_shift_10) | _zz_add_oh_shift_12) | _zz_add_oh_shift_13) | _zz_add_oh_shift_15) | _zz_add_oh_shift_17) | _zz_add_oh_shift_19;
	assign _zz__zz_add_oh_shift_52 = ((((((((((_zz_add_oh_shift_1[2] | _zz_add_oh_shift_2) | _zz_add_oh_shift_4) | _zz_add_oh_shift_5) | _zz_add_oh_shift_7) | _zz_add_oh_shift_8) | _zz_add_oh_shift_11) | _zz_add_oh_shift_12) | _zz_add_oh_shift_14) | _zz_add_oh_shift_15) | _zz_add_oh_shift_18) | _zz_add_oh_shift_19;
	assign _zz__zz_add_oh_shift_53 = ((((((((((_zz_add_oh_shift_1[4] | _zz_add_oh_shift_3) | _zz_add_oh_shift_4) | _zz_add_oh_shift_5) | _zz_add_oh_shift_9) | _zz_add_oh_shift_10) | _zz_add_oh_shift_11) | _zz_add_oh_shift_12) | _zz_add_oh_shift_16) | _zz_add_oh_shift_17) | _zz_add_oh_shift_18) | _zz_add_oh_shift_19;
	assign _zz__zz_add_oh_shift_54 = (((((_zz_add_oh_shift_1[8] | _zz_add_oh_shift_6) | _zz_add_oh_shift_7) | _zz_add_oh_shift_8) | _zz_add_oh_shift_9) | _zz_add_oh_shift_10) | _zz_add_oh_shift_11;
	assign _zz__zz_add_oh_shift_55 = (((((_zz_add_oh_shift_1[16] | _zz_add_oh_shift_13) | _zz_add_oh_shift_14) | _zz_add_oh_shift_15) | _zz_add_oh_shift_16) | _zz_add_oh_shift_17) | _zz_add_oh_shift_18;
	assign _zz__zz_add_oh_shift_56 = ((((((_zz_add_oh_shift_1[32] | _zz_add_oh_shift_28) | _zz_add_oh_shift_29) | _zz_add_oh_shift_30) | _zz_add_oh_shift_31) | _zz_add_oh_shift_32) | _zz_add_oh_shift_33) | _zz_add_oh_shift_34;
	assign _zz_rf_scoreboards_0_target_port1 = rf_scoreboards_0_target[{2'h0, scheduler_0_input_payload_rs1} + 0];
	assign _zz_rf_scoreboards_0_target_port2 = rf_scoreboards_0_target[{2'h0, scheduler_0_input_payload_rs2} + 0];
	assign _zz_rf_scoreboards_0_target_port3 = rf_scoreboards_0_target[{2'h0, scheduler_0_input_payload_rs3} + 0];
	assign _zz_rf_scoreboards_0_target_port4 = rf_scoreboards_0_target[{2'h0, scheduler_0_input_payload_rd} + 0];
	assign _zz_rf_scoreboards_0_hit_port1 = rf_scoreboards_0_hit[{2'h0, scheduler_0_input_payload_rs1} + 0];
	assign _zz_rf_scoreboards_0_hit_port2 = rf_scoreboards_0_hit[{2'h0, scheduler_0_input_payload_rs2} + 0];
	assign _zz_rf_scoreboards_0_hit_port3 = rf_scoreboards_0_hit[{2'h0, scheduler_0_input_payload_rs3} + 0];
	assign _zz_rf_scoreboards_0_hit_port4 = rf_scoreboards_0_hit[{2'h0, scheduler_0_input_payload_rd} + 0];
	assign _zz_rf_scoreboards_0_hit_port5 = rf_scoreboards_0_hit[{2'h0, writeback_input_payload_rd} + 0];
	assign _zz_rf_scoreboards_0_writes_port1 = rf_scoreboards_0_writes[{2'h0, roundBack_input_payload_rd} + 0];
	assign io_port_0_commit_ready = streamFork_1_io_input_ready;
	assign commitFork_load_0_valid = streamFork_1_io_outputs_0_valid;
	assign commitFork_load_0_payload_opcode = streamFork_1_io_outputs_0_payload_opcode;
	assign commitFork_load_0_payload_rd = streamFork_1_io_outputs_0_payload_rd;
	assign commitFork_load_0_payload_write = streamFork_1_io_outputs_0_payload_write;
	assign commitFork_load_0_payload_value = streamFork_1_io_outputs_0_payload_value;
	assign FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_valid = streamFork_1_io_outputs_1_valid | FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid;
	assign FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode = _zz_payload_opcode;
	assign commitFork_commit_0_valid = FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_valid;
	assign FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_ready = commitFork_commit_0_ready;
	assign commitFork_commit_0_payload_opcode = FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode;
	assign commitFork_commit_0_payload_rd = FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_rd;
	assign commitFork_commit_0_payload_write = FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_write;
	assign commitFork_commit_0_payload_value = FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_value;
	assign commitFork_commit_0_ready = 1'b1 & _zz_commitFork_commit_0_ready;
	assign _zz_commitLogic_0_input_payload_opcode = commitFork_commit_0_payload_opcode;
	assign commitLogic_0_input_valid = commitFork_commit_0_valid & _zz_commitFork_commit_0_ready;
	assign commitLogic_0_input_payload_opcode = _zz_commitLogic_0_input_payload_opcode;
	assign commitLogic_0_input_payload_rd = commitFork_commit_0_payload_rd;
	assign commitLogic_0_input_payload_write = commitFork_commit_0_payload_write;
	assign commitLogic_0_input_payload_value = commitFork_commit_0_payload_value;
	assign when_FpuCore_l208 = (commitLogic_0_input_payload_opcode == FpuOpcode_ADD) ^ 1'b0;
	assign when_FpuCore_l210 = (commitLogic_0_input_payload_opcode == FpuOpcode_DIV) ^ 1'b0;
	assign when_FpuCore_l211 = (commitLogic_0_input_payload_opcode == FpuOpcode_SQRT) ^ 1'b0;
	assign scheduler_0_input_valid = io_port_0_cmd_valid | io_port_0_cmd_rValid;
	assign scheduler_0_input_payload_opcode = _zz_scheduler_0_input_payload_opcode;
	assign scheduler_0_input_payload_format = _zz_scheduler_0_input_payload_format;
	assign scheduler_0_input_payload_roundMode = _zz_scheduler_0_input_payload_roundMode;
	assign scheduler_0_rfHits_0 = _zz_rf_scoreboards_0_hit_port1;
	assign scheduler_0_rfHits_1 = _zz_rf_scoreboards_0_hit_port2;
	assign scheduler_0_rfHits_2 = _zz_rf_scoreboards_0_hit_port3;
	assign scheduler_0_rfHits_3 = _zz_rf_scoreboards_0_hit_port4;
	assign scheduler_0_rfTargets_0 = _zz_rf_scoreboards_0_target_port1;
	assign scheduler_0_rfTargets_1 = _zz_rf_scoreboards_0_target_port2;
	assign scheduler_0_rfTargets_2 = _zz_rf_scoreboards_0_target_port3;
	assign scheduler_0_rfTargets_3 = _zz_rf_scoreboards_0_target_port4;
	assign scheduler_0_rfBusy_0 = scheduler_0_rfHits_0 ^ scheduler_0_rfTargets_0;
	assign scheduler_0_rfBusy_1 = scheduler_0_rfHits_1 ^ scheduler_0_rfTargets_1;
	assign scheduler_0_rfBusy_2 = scheduler_0_rfHits_2 ^ scheduler_0_rfTargets_2;
	assign scheduler_0_rfBusy_3 = scheduler_0_rfHits_3 ^ scheduler_0_rfTargets_3;
	assign scheduler_0_hits_0 = scheduler_0_useRs1 & scheduler_0_rfBusy_0;
	assign scheduler_0_hits_1 = scheduler_0_useRs2 & scheduler_0_rfBusy_1;
	assign scheduler_0_hits_2 = scheduler_0_useRs3 & scheduler_0_rfBusy_2;
	assign scheduler_0_hits_3 = scheduler_0_useRd & scheduler_0_rfBusy_3;
	assign scheduler_0_hazard = (({scheduler_0_hits_3, scheduler_0_hits_2, scheduler_0_hits_1, scheduler_0_hits_0} != 4'h0) | ~|rf_init_done) | commitLogic_0_pending_full;
	assign scheduler_0_output_valid = scheduler_0_input_valid & _zz_scheduler_0_input_ready;
	assign scheduler_0_input_ready = scheduler_0_output_ready & _zz_scheduler_0_input_ready;
	assign scheduler_0_output_payload_opcode = scheduler_0_input_payload_opcode;
	assign scheduler_0_output_payload_arg = scheduler_0_input_payload_arg;
	assign scheduler_0_output_payload_rs2 = scheduler_0_input_payload_rs2;
	assign scheduler_0_output_payload_rs3 = scheduler_0_input_payload_rs3;
	assign scheduler_0_output_payload_rd = scheduler_0_input_payload_rd;
	assign scheduler_0_output_payload_format = scheduler_0_input_payload_format;
	assign scheduler_0_output_payload_roundMode = scheduler_0_input_payload_roundMode;
	assign when_FpuCore_l261 = scheduler_0_input_valid & rf_init_done;
	assign scheduler_0_output_fire = scheduler_0_output_valid & scheduler_0_output_ready;
	assign when_FpuCore_l265 = scheduler_0_output_fire & scheduler_0_useRd;
	assign scheduler_0_output_ready = cmdArbiter_arbiter_io_inputs_0_ready;
	assign _zz_io_inputs_0_payload_opcode = scheduler_0_output_payload_opcode;
	assign _zz_io_inputs_0_payload_format = scheduler_0_output_payload_format;
	assign _zz_io_inputs_0_payload_roundMode = scheduler_0_output_payload_roundMode;
	assign cmdArbiter_output_valid = cmdArbiter_arbiter_io_output_valid;
	assign cmdArbiter_output_payload_opcode = cmdArbiter_arbiter_io_output_payload_opcode;
	assign cmdArbiter_output_payload_rs1 = cmdArbiter_arbiter_io_output_payload_rs1;
	assign cmdArbiter_output_payload_rs2 = cmdArbiter_arbiter_io_output_payload_rs2;
	assign cmdArbiter_output_payload_rs3 = cmdArbiter_arbiter_io_output_payload_rs3;
	assign cmdArbiter_output_payload_rd = cmdArbiter_arbiter_io_output_payload_rd;
	assign cmdArbiter_output_payload_arg = cmdArbiter_arbiter_io_output_payload_arg;
	assign cmdArbiter_output_payload_roundMode = cmdArbiter_arbiter_io_output_payload_roundMode;
	assign cmdArbiter_output_payload_format = cmdArbiter_arbiter_io_output_payload_format;
	assign read_s0_valid = cmdArbiter_output_valid;
	assign cmdArbiter_output_ready = read_s0_ready;
	assign read_s0_payload_opcode = cmdArbiter_output_payload_opcode;
	assign read_s0_payload_rs1 = cmdArbiter_output_payload_rs1;
	assign read_s0_payload_rs2 = cmdArbiter_output_payload_rs2;
	assign read_s0_payload_rs3 = cmdArbiter_output_payload_rs3;
	assign read_s0_payload_rd = cmdArbiter_output_payload_rd;
	assign read_s0_payload_arg = cmdArbiter_output_payload_arg;
	assign read_s0_payload_roundMode = cmdArbiter_output_payload_roundMode;
	assign read_s0_payload_format = cmdArbiter_output_payload_format;
	assign read_s1_valid = read_s0_rValid;
	assign read_s1_payload_opcode = read_s0_rData_opcode;
	assign read_s1_payload_rs1 = read_s0_rData_rs1;
	assign read_s1_payload_rs2 = read_s0_rData_rs2;
	assign read_s1_payload_rs3 = read_s0_rData_rs3;
	assign read_s1_payload_rd = read_s0_rData_rd;
	assign read_s1_payload_arg = read_s0_rData_arg;
	assign read_s1_payload_roundMode = read_s0_rData_roundMode;
	assign read_s1_payload_format = read_s0_rData_format;
	assign read_output_valid = read_s1_valid;
	assign read_s1_ready = read_output_ready;
	assign _zz_read_rs_0_boxed = read_s0_payload_rs1;
	assign read_output_isStall = read_output_valid & ~|read_output_ready;
	assign _zz_read_rs_0_boxed_2 = _zz_rf_ram_port0;
	assign _zz_read_rs_1_boxed = read_s0_payload_rs2;
	assign read_output_isStall_1 = read_output_valid & ~|read_output_ready;
	assign _zz_read_rs_1_boxed_2 = _zz_rf_ram_port1;
	assign _zz_read_rs_2_boxed = read_s0_payload_rs3;
	assign read_output_isStall_2 = read_output_valid & ~|read_output_ready;
	assign _zz_read_rs_2_boxed_2 = _zz_rf_ram_port2;
	assign read_output_payload_opcode = read_s1_payload_opcode;
	assign read_output_payload_arg = read_s1_payload_arg;
	assign read_output_payload_roundMode = read_s1_payload_roundMode;
	assign read_output_payload_rd = read_s1_payload_rd;
	assign read_output_payload_rs3_sign = read_rs_2_value_sign;
	assign read_output_payload_rs1Boxed = read_rs_0_boxed;
	assign read_output_payload_rs2Boxed = read_rs_1_boxed;
	assign when_FpuCore_l305 = (read_s1_payload_opcode == FpuOpcode_STORE) | (read_s1_payload_opcode == FpuOpcode_FMV_X_W);
	assign when_FpuCore_l307 = (read_s1_payload_format ~^ FpuFormat_FLOAT) ^ read_rs_0_boxed;
	assign when_FpuCore_l312 = (read_s1_payload_format ~^ FpuFormat_FLOAT) ^ read_rs_1_boxed;
	assign when_FpuCore_l316 = (read_s1_payload_format ~^ FpuFormat_FLOAT) ^ read_rs_2_boxed;
	assign decode_input_valid = read_output_valid;
	assign read_output_ready = decode_input_ready;
	assign decode_input_payload_opcode = read_output_payload_opcode;
	assign decode_input_payload_rs1_mantissa = read_output_payload_rs1_mantissa;
	assign decode_input_payload_rs1_exponent = read_output_payload_rs1_exponent;
	assign decode_input_payload_rs1_sign = read_output_payload_rs1_sign;
	assign decode_input_payload_rs1_special = read_output_payload_rs1_special;
	assign decode_input_payload_rs2_mantissa = read_output_payload_rs2_mantissa;
	assign decode_input_payload_rs2_exponent = read_output_payload_rs2_exponent;
	assign decode_input_payload_rs2_sign = read_output_payload_rs2_sign;
	assign decode_input_payload_rs2_special = read_output_payload_rs2_special;
	assign decode_input_payload_rs3_mantissa = read_output_payload_rs3_mantissa;
	assign decode_input_payload_rs3_exponent = read_output_payload_rs3_exponent;
	assign decode_input_payload_rs3_sign = read_output_payload_rs3_sign;
	assign decode_input_payload_rs3_special = read_output_payload_rs3_special;
	assign decode_input_payload_rd = read_output_payload_rd;
	assign decode_input_payload_arg = read_output_payload_arg;
	assign decode_input_payload_roundMode = read_output_payload_roundMode;
	assign decode_input_payload_format = read_output_payload_format;
	assign decode_input_payload_rs1Boxed = read_output_payload_rs1Boxed;
	assign decode_input_payload_rs2Boxed = read_output_payload_rs2Boxed;
	assign decode_load_valid = decode_input_valid & decode_loadHit;
	assign when_FpuCore_l329 = decode_loadHit & decode_load_ready;
	assign decode_load_payload_rd = decode_input_payload_rd;
	assign decode_load_payload_arg = decode_input_payload_arg;
	assign decode_load_payload_roundMode = decode_input_payload_roundMode;
	assign decode_load_payload_format = decode_input_payload_format;
	assign when_FpuCore_l335 = decode_shortPipHit & decode_shortPip_ready;
	assign decode_shortPip_valid = decode_input_valid & decode_shortPipHit;
	assign decode_shortPip_payload_opcode = decode_input_payload_opcode;
	assign decode_shortPip_payload_rs1_mantissa = decode_input_payload_rs1_mantissa;
	assign decode_shortPip_payload_rs1_exponent = decode_input_payload_rs1_exponent;
	assign decode_shortPip_payload_rs1_sign = decode_input_payload_rs1_sign;
	assign decode_shortPip_payload_rs1_special = decode_input_payload_rs1_special;
	assign decode_shortPip_payload_rs2_mantissa = decode_input_payload_rs2_mantissa;
	assign decode_shortPip_payload_rs2_exponent = decode_input_payload_rs2_exponent;
	assign decode_shortPip_payload_rs2_sign = decode_input_payload_rs2_sign;
	assign decode_shortPip_payload_rs2_special = decode_input_payload_rs2_special;
	assign decode_shortPip_payload_rd = decode_input_payload_rd;
	assign decode_shortPip_payload_arg = decode_input_payload_arg;
	assign decode_shortPip_payload_roundMode = decode_input_payload_roundMode;
	assign decode_shortPip_payload_format = decode_input_payload_format;
	assign decode_shortPip_payload_rs1Boxed = decode_input_payload_rs1Boxed;
	assign decode_shortPip_payload_rs2Boxed = decode_input_payload_rs2Boxed;
	assign decode_divSqrtHit = (decode_input_payload_opcode == FpuOpcode_DIV) | (decode_input_payload_opcode == FpuOpcode_SQRT);
	assign when_FpuCore_l351 = decode_divHit & decode_div_ready;
	assign decode_div_valid = decode_input_valid & decode_divHit;
	assign decode_div_payload_rs1_mantissa = decode_input_payload_rs1_mantissa;
	assign decode_div_payload_rs1_exponent = decode_input_payload_rs1_exponent;
	assign decode_div_payload_rs1_sign = decode_input_payload_rs1_sign;
	assign decode_div_payload_rs1_special = decode_input_payload_rs1_special;
	assign decode_div_payload_rs2_mantissa = decode_input_payload_rs2_mantissa;
	assign decode_div_payload_rs2_exponent = decode_input_payload_rs2_exponent;
	assign decode_div_payload_rs2_sign = decode_input_payload_rs2_sign;
	assign decode_div_payload_rs2_special = decode_input_payload_rs2_special;
	assign decode_div_payload_rd = decode_input_payload_rd;
	assign decode_div_payload_roundMode = decode_input_payload_roundMode;
	assign decode_div_payload_format = decode_input_payload_format;
	assign when_FpuCore_l359 = decode_sqrtHit & decode_sqrt_ready;
	assign decode_sqrt_valid = decode_input_valid & decode_sqrtHit;
	assign decode_sqrt_payload_rs1_mantissa = decode_input_payload_rs1_mantissa;
	assign decode_sqrt_payload_rs1_exponent = decode_input_payload_rs1_exponent;
	assign decode_sqrt_payload_rs1_sign = decode_input_payload_rs1_sign;
	assign decode_sqrt_payload_rs1_special = decode_input_payload_rs1_special;
	assign decode_sqrt_payload_rd = decode_input_payload_rd;
	assign decode_sqrt_payload_roundMode = decode_input_payload_roundMode;
	assign decode_sqrt_payload_format = decode_input_payload_format;
	assign decode_mulHit = (decode_input_payload_opcode == FpuOpcode_MUL) | decode_fmaHit;
	assign when_FpuCore_l375 = (decode_mulHit & decode_mul_ready) & ~|decode_divSqrtToMul_valid;
	assign decode_mul_valid = (decode_input_valid & decode_mulHit) | decode_divSqrtToMul_valid;
	assign decode_divSqrtToMul_ready = decode_mul_ready;
	assign when_FpuCore_l399 = (decode_addHit & decode_add_ready) & ~|decode_mulToAdd_valid;
	assign decode_add_valid = (decode_input_valid & decode_addHit) | decode_mulToAdd_valid;
	assign decode_mulToAdd_ready = decode_add_ready;
	assign decode_load_s2mPipe_valid = decode_load_valid | decode_load_rValid;
	assign decode_load_s2mPipe_payload_roundMode = _zz_decode_load_s2mPipe_payload_roundMode;
	assign decode_load_s2mPipe_payload_format = _zz_decode_load_s2mPipe_payload_format;
	assign decode_load_s2mPipe_m2sPipe_valid = decode_load_s2mPipe_rValid;
	assign decode_load_s2mPipe_m2sPipe_payload_rd = decode_load_s2mPipe_rData_rd;
	assign decode_load_s2mPipe_m2sPipe_payload_i2f = decode_load_s2mPipe_rData_i2f;
	assign decode_load_s2mPipe_m2sPipe_payload_arg = decode_load_s2mPipe_rData_arg;
	assign decode_load_s2mPipe_m2sPipe_payload_roundMode = decode_load_s2mPipe_rData_roundMode;
	assign decode_load_s2mPipe_m2sPipe_payload_format = decode_load_s2mPipe_rData_format;
	assign load_s0_input_valid = decode_load_s2mPipe_m2sPipe_rValid;
	assign load_s0_input_payload_rd = decode_load_s2mPipe_m2sPipe_rData_rd;
	assign load_s0_input_payload_i2f = decode_load_s2mPipe_m2sPipe_rData_i2f;
	assign load_s0_input_payload_arg = decode_load_s2mPipe_m2sPipe_rData_arg;
	assign load_s0_input_payload_roundMode = decode_load_s2mPipe_m2sPipe_rData_roundMode;
	assign load_s0_input_payload_format = decode_load_s2mPipe_m2sPipe_rData_format;
	assign load_s0_filtred_0_payload_opcode = commitFork_load_0_payload_opcode;
	assign load_s0_filtred_0_payload_rd = commitFork_load_0_payload_rd;
	assign load_s0_filtred_0_payload_write = commitFork_load_0_payload_write;
	assign load_s0_filtred_0_payload_value = commitFork_load_0_payload_value;
	assign load_s0_input_ready = load_s0_output_ready & _zz_load_s0_input_ready;
	assign load_s0_output_valid = load_s0_input_valid & _zz_load_s0_input_ready;
	assign load_s0_output_payload_rd = load_s0_input_payload_rd;
	assign load_s0_output_payload_value = load_s0_filtred_0_payload_value;
	assign load_s0_output_payload_i2f = load_s0_input_payload_i2f;
	assign load_s0_output_payload_arg = load_s0_input_payload_arg;
	assign load_s0_output_payload_roundMode = load_s0_input_payload_roundMode;
	assign when_FpuCore_l452 = (~|load_s0_input_payload_i2f & (load_s0_input_payload_format ~^ FpuFormat_DOUBLE)) & &load_s0_output_payload_value[63:32];
	assign load_s1_input_valid = load_s0_output_rValid;
	assign load_s1_input_payload_rd = load_s0_output_rData_rd;
	assign load_s1_input_payload_value = load_s0_output_rData_value;
	assign load_s1_input_payload_i2f = load_s0_output_rData_i2f;
	assign load_s1_input_payload_arg = load_s0_output_rData_arg;
	assign load_s1_input_payload_roundMode = load_s0_output_rData_roundMode;
	assign load_s1_input_payload_format = load_s0_output_rData_format;
	assign when_FpuCore_l31 = load_s1_input_payload_format ~^ FpuFormat_DOUBLE;
	assign when_FpuCore_l494 = (load_s1_input_payload_format ~^ FpuFormat_DOUBLE) & (load_s1_input_payload_value[62:60] != 3'h0);
	assign when_FpuCore_l495 = (load_s1_input_payload_format ~^ FpuFormat_DOUBLE) & (load_s1_input_payload_value[62:60] != 3'h7);
	assign load_s1_isZero = load_s1_expZero & load_s1_manZero;
	assign load_s1_isSubnormal = load_s1_expZero & ~|load_s1_manZero;
	assign load_s1_isInfinity = load_s1_expOne & load_s1_manZero;
	assign load_s1_isNan = load_s1_expOne & ~|load_s1_manZero;
	assign when_FpuCore_l529 = (load_s1_input_valid & (load_s1_input_payload_i2f | load_s1_isSubnormal)) & ~|load_s1_fsm_done;
	assign when_FpuCore_l532 = ((load_s1_input_payload_i2f & ~|load_s1_fsm_patched) & load_s1_input_payload_value[31]) & load_s1_input_payload_arg[0];
	assign _zz_load_s0_output_rData_value = load_s1_input_payload_value;
	assign _zz_load_s1_fsm_shift_by_1 = _zz_load_s1_fsm_shift_by & ~_zz__zz_load_s1_fsm_shift_by_1_1;
	assign _zz_load_s1_fsm_shift_by_47 = (((((((((((((((_zz__zz_load_s1_fsm_shift_by_47 | _zz_load_s1_fsm_shift_by_17) | _zz_load_s1_fsm_shift_by_19) | _zz_load_s1_fsm_shift_by_21) | _zz_load_s1_fsm_shift_by_23) | _zz_load_s1_fsm_shift_by_25) | _zz_load_s1_fsm_shift_by_27) | _zz_load_s1_fsm_shift_by_28) | _zz_load_s1_fsm_shift_by_30) | _zz_load_s1_fsm_shift_by_32) | _zz_load_s1_fsm_shift_by_34) | _zz_load_s1_fsm_shift_by_36) | _zz_load_s1_fsm_shift_by_38) | _zz_load_s1_fsm_shift_by_40) | _zz_load_s1_fsm_shift_by_42) | _zz_load_s1_fsm_shift_by_44) | _zz_load_s1_fsm_shift_by_46;
	assign _zz_load_s1_fsm_shift_by_48 = (((((((((((((((_zz__zz_load_s1_fsm_shift_by_48 | _zz_load_s1_fsm_shift_by_18) | _zz_load_s1_fsm_shift_by_19) | _zz_load_s1_fsm_shift_by_22) | _zz_load_s1_fsm_shift_by_23) | _zz_load_s1_fsm_shift_by_26) | _zz_load_s1_fsm_shift_by_27) | _zz_load_s1_fsm_shift_by_29) | _zz_load_s1_fsm_shift_by_30) | _zz_load_s1_fsm_shift_by_33) | _zz_load_s1_fsm_shift_by_34) | _zz_load_s1_fsm_shift_by_37) | _zz_load_s1_fsm_shift_by_38) | _zz_load_s1_fsm_shift_by_41) | _zz_load_s1_fsm_shift_by_42) | _zz_load_s1_fsm_shift_by_45) | _zz_load_s1_fsm_shift_by_46;
	assign _zz_load_s1_fsm_shift_by_49 = ((((((((((((((((_zz__zz_load_s1_fsm_shift_by_49 | _zz_load_s1_fsm_shift_by_12) | _zz_load_s1_fsm_shift_by_16) | _zz_load_s1_fsm_shift_by_17) | _zz_load_s1_fsm_shift_by_18) | _zz_load_s1_fsm_shift_by_19) | _zz_load_s1_fsm_shift_by_24) | _zz_load_s1_fsm_shift_by_25) | _zz_load_s1_fsm_shift_by_26) | _zz_load_s1_fsm_shift_by_27) | _zz_load_s1_fsm_shift_by_31) | _zz_load_s1_fsm_shift_by_32) | _zz_load_s1_fsm_shift_by_33) | _zz_load_s1_fsm_shift_by_34) | _zz_load_s1_fsm_shift_by_39) | _zz_load_s1_fsm_shift_by_40) | _zz_load_s1_fsm_shift_by_41) | _zz_load_s1_fsm_shift_by_42;
	assign _zz_load_s1_fsm_shift_by_50 = (((((((((((((((_zz__zz_load_s1_fsm_shift_by_50 | _zz_load_s1_fsm_shift_by_20) | _zz_load_s1_fsm_shift_by_21) | _zz_load_s1_fsm_shift_by_22) | _zz_load_s1_fsm_shift_by_23) | _zz_load_s1_fsm_shift_by_24) | _zz_load_s1_fsm_shift_by_25) | _zz_load_s1_fsm_shift_by_26) | _zz_load_s1_fsm_shift_by_27) | _zz_load_s1_fsm_shift_by_35) | _zz_load_s1_fsm_shift_by_36) | _zz_load_s1_fsm_shift_by_37) | _zz_load_s1_fsm_shift_by_38) | _zz_load_s1_fsm_shift_by_39) | _zz_load_s1_fsm_shift_by_40) | _zz_load_s1_fsm_shift_by_41) | _zz_load_s1_fsm_shift_by_42;
	assign _zz_load_s1_fsm_shift_by_51 = ((((((((((((((((_zz__zz_load_s1_fsm_shift_by_51 | _zz_load_s1_fsm_shift_by_15) | _zz_load_s1_fsm_shift_by_16) | _zz_load_s1_fsm_shift_by_17) | _zz_load_s1_fsm_shift_by_18) | _zz_load_s1_fsm_shift_by_19) | _zz_load_s1_fsm_shift_by_20) | _zz_load_s1_fsm_shift_by_21) | _zz_load_s1_fsm_shift_by_22) | _zz_load_s1_fsm_shift_by_23) | _zz_load_s1_fsm_shift_by_24) | _zz_load_s1_fsm_shift_by_25) | _zz_load_s1_fsm_shift_by_26) | _zz_load_s1_fsm_shift_by_27) | _zz_load_s1_fsm_shift_by_43) | _zz_load_s1_fsm_shift_by_44) | _zz_load_s1_fsm_shift_by_45) | _zz_load_s1_fsm_shift_by_46;
	assign _zz_load_s1_fsm_shift_by_52 = (((((((((((((((_zz__zz_load_s1_fsm_shift_by_52 | _zz_load_s1_fsm_shift_by_31) | _zz_load_s1_fsm_shift_by_32) | _zz_load_s1_fsm_shift_by_33) | _zz_load_s1_fsm_shift_by_34) | _zz_load_s1_fsm_shift_by_35) | _zz_load_s1_fsm_shift_by_36) | _zz_load_s1_fsm_shift_by_37) | _zz_load_s1_fsm_shift_by_38) | _zz_load_s1_fsm_shift_by_39) | _zz_load_s1_fsm_shift_by_40) | _zz_load_s1_fsm_shift_by_41) | _zz_load_s1_fsm_shift_by_42) | _zz_load_s1_fsm_shift_by_43) | _zz_load_s1_fsm_shift_by_44) | _zz_load_s1_fsm_shift_by_45) | _zz_load_s1_fsm_shift_by_46;
	assign load_s1_input_isStall = load_s1_input_valid & ~|load_s1_input_ready;
	assign load_s1_i2fHigh = load_s1_fsm_shift_output;
	assign load_s1_recoded_mantissa = load_s1_passThroughFloat_mantissa;
	assign load_s1_recoded_sign = load_s1_passThroughFloat_sign;
	assign load_s1_input_ready = load_s1_output_ready & _zz_load_s1_input_ready;
	assign load_s1_output_valid = load_s1_input_valid & _zz_load_s1_input_ready;
	assign load_s1_output_payload_roundMode = load_s1_input_payload_roundMode;
	assign load_s1_output_payload_format = load_s1_input_payload_format;
	assign load_s1_output_payload_rd = load_s1_input_payload_rd;
	assign when_FpuCore_l594 = load_s1_input_payload_i2f | load_s1_isSubnormal;
	assign shortPip_input_valid = decode_shortPip_rValid;
	assign shortPip_input_payload_opcode = decode_shortPip_rData_opcode;
	assign shortPip_input_payload_rs1_mantissa = decode_shortPip_rData_rs1_mantissa;
	assign shortPip_input_payload_rs1_exponent = decode_shortPip_rData_rs1_exponent;
	assign shortPip_input_payload_rs1_sign = decode_shortPip_rData_rs1_sign;
	assign shortPip_input_payload_rs1_special = decode_shortPip_rData_rs1_special;
	assign shortPip_input_payload_rs2_mantissa = decode_shortPip_rData_rs2_mantissa;
	assign shortPip_input_payload_rs2_exponent = decode_shortPip_rData_rs2_exponent;
	assign shortPip_input_payload_rs2_sign = decode_shortPip_rData_rs2_sign;
	assign shortPip_input_payload_rs2_special = decode_shortPip_rData_rs2_special;
	assign shortPip_input_payload_rd = decode_shortPip_rData_rd;
	assign shortPip_input_payload_value = decode_shortPip_rData_value;
	assign shortPip_input_payload_arg = decode_shortPip_rData_arg;
	assign shortPip_input_payload_roundMode = decode_shortPip_rData_roundMode;
	assign shortPip_input_payload_format = decode_shortPip_rData_format;
	assign shortPip_input_payload_rs1Boxed = decode_shortPip_rData_rs1Boxed;
	assign shortPip_input_payload_rs2Boxed = decode_shortPip_rData_rs2Boxed;
	assign shortPip_input_fire = shortPip_input_valid & shortPip_input_ready;
	assign when_FpuCore_l221 = (shortPip_input_fire & shortPip_toFpuRf) & 1'b1;
	assign shortPip_isCommited = commitLogic_0_short_notEmpty;
	assign shortPip_output_valid = shortPip_rfOutput_valid & _zz_shortPip_rfOutput_ready;
	assign shortPip_rfOutput_ready = shortPip_output_ready & _zz_shortPip_rfOutput_ready;
	assign shortPip_output_payload_rd = shortPip_rfOutput_payload_rd;
	assign shortPip_output_payload_value_mantissa = shortPip_rfOutput_payload_value_mantissa;
	assign shortPip_output_payload_value_exponent = shortPip_rfOutput_payload_value_exponent;
	assign shortPip_output_payload_value_sign = shortPip_rfOutput_payload_value_sign;
	assign shortPip_output_payload_value_special = shortPip_rfOutput_payload_value_special;
	assign shortPip_output_payload_scrap = shortPip_rfOutput_payload_scrap;
	assign shortPip_output_payload_roundMode = shortPip_rfOutput_payload_roundMode;
	assign shortPip_output_payload_format = shortPip_rfOutput_payload_format;
	assign shortPip_output_payload_NV = shortPip_rfOutput_payload_NV;
	assign shortPip_output_payload_DZ = shortPip_rfOutput_payload_DZ;
	assign shortPip_f64_man = shortPip_input_payload_rs1_mantissa;
	assign when_FpuCore_l31_1 = shortPip_input_payload_format ~^ FpuFormat_DOUBLE;
	assign shortPip_isSubnormal = ~|shortPip_input_payload_rs1_special & shortPip_expInSubnormalRange;
	assign shortPip_isNormal = ~|shortPip_input_payload_rs1_special & ~|shortPip_expInSubnormalRange;
	assign shortPip_fsm_needRecoding = ({shortPip_input_payload_opcode == FpuOpcode_STORE, shortPip_input_payload_opcode == FpuOpcode_FMV_X_W} != 2'h0) & shortPip_isSubnormal;
	assign shortPip_fsm_isZero = shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h0);
	assign when_FpuCore_l646 = shortPip_fsm_shift_by[5] & (shortPip_fsm_shift_input[31:0] != 32'h00000000);
	assign when_FpuCore_l646_1 = shortPip_fsm_shift_by[4] & (shortPip_fsm_shift_input_1[15:0] != 16'h0000);
	assign when_FpuCore_l646_2 = shortPip_fsm_shift_by[3] & (shortPip_fsm_shift_input_2[7:0] != 8'h00);
	assign when_FpuCore_l646_3 = shortPip_fsm_shift_by[2] & (shortPip_fsm_shift_input_3[3:0] != 4'h0);
	assign when_FpuCore_l646_4 = shortPip_fsm_shift_by[1] & (shortPip_fsm_shift_input_4[1:0] != 2'h0);
	assign when_FpuCore_l646_5 = shortPip_fsm_shift_by[0] & (shortPip_fsm_shift_input_5[0] ^ 1'b0);
	assign when_FpuCore_l658 = (shortPip_input_valid & (shortPip_fsm_needRecoding | shortPip_fsm_isF2i)) & ~|shortPip_fsm_done;
	assign shortPip_input_isStall = shortPip_input_valid & ~|shortPip_input_ready;
	assign when_FpuCore_l31_2 = shortPip_input_payload_format ~^ FpuFormat_DOUBLE;
	assign when_FpuCore_l31_3 = shortPip_input_payload_format ~^ FpuFormat_DOUBLE;
	assign when_FpuCore_l31_4 = shortPip_input_payload_format ~^ FpuFormat_DOUBLE;
	assign when_FpuCore_l31_5 = shortPip_input_payload_format ~^ FpuFormat_DOUBLE;
	assign shortPip_f2i_resign = shortPip_input_payload_arg[0] & shortPip_input_payload_rs1_sign;
	assign shortPip_f2i_underflow = ((((shortPip_input_payload_rs1_exponent > 12'h81e) | ((shortPip_input_payload_arg[0] & shortPip_f2i_unsigned[31]) & ((shortPip_f2i_unsigned[30:0] != 31'h00000000) | shortPip_f2i_increment))) | (~|shortPip_input_payload_arg[0] & ((shortPip_f2i_unsigned != 32'h00000000) | shortPip_f2i_increment))) | (shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h1))) & shortPip_input_payload_rs1_sign;
	assign shortPip_f2i_isZero = shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h0);
	assign when_FpuCore_l763 = ((~|shortPip_input_payload_rs1_sign & shortPip_f2i_increment) & &shortPip_f2i_unsigned[30:0]) & (shortPip_input_payload_arg[0] | shortPip_f2i_unsigned[31]);
	assign when_FpuCore_l767 = shortPip_f2i_underflow | shortPip_f2i_overflow;
	assign shortPip_bothZero = (shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h0)) & (shortPip_input_payload_rs2_special & (shortPip_input_payload_rs2_exponent[1:0] == 2'h0));
	assign when_FpuCore_l780 = shortPip_input_payload_rs2_special & (shortPip_input_payload_rs2_exponent[1:0] == 2'h1);
	assign when_FpuCore_l781 = shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h0);
	assign when_FpuCore_l782 = shortPip_input_payload_rs2_special & (shortPip_input_payload_rs2_exponent[1:0] == 2'h0);
	assign when_FpuCore_l783 = shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h1);
	assign when_FpuCore_l784 = ((shortPip_input_payload_rs1_sign ~^ shortPip_input_payload_rs2_sign) & (shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h1))) & (shortPip_input_payload_rs2_special & (shortPip_input_payload_rs2_exponent[1:0] == 2'h1));
	assign shortPip_minMaxSelectNanQuiet = (shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h2)) & (shortPip_input_payload_rs2_special & (shortPip_input_payload_rs2_exponent[1:0] == 2'h2));
	assign when_FpuCore_l796 = (shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h2)) | (shortPip_input_payload_rs2_special & (shortPip_input_payload_rs2_exponent[1:0] == 2'h2));
	assign shortPip_sgnjRs1Sign = shortPip_input_payload_rs1_sign;
	assign when_FpuCore_l800 = shortPip_input_payload_rs2Boxed & (shortPip_input_payload_format ~^ FpuFormat_DOUBLE);
	assign shortPip_sgnjResult = ((shortPip_sgnjRs1Sign & shortPip_input_payload_arg[1]) ^ shortPip_sgnjRs2Sign) ^ shortPip_input_payload_arg[0];
	assign shortPip_decoded_isZero = shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h0);
	assign shortPip_decoded_isInfinity = shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h1);
	assign shortPip_decoded_isNan = shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h2);
	assign shortPip_rfOutput_valid = (shortPip_input_valid & shortPip_toFpuRf) & ~|shortPip_halt;
	assign shortPip_rfOutput_payload_rd = shortPip_input_payload_rd;
	assign shortPip_rfOutput_payload_roundMode = shortPip_input_payload_roundMode;
	assign when_FpuCore_l853 = shortPip_input_payload_rs1Boxed & (shortPip_input_payload_format ~^ FpuFormat_DOUBLE);
	assign when_FpuCore_l860 = shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h2);
	assign shortPip_signalQuiet = (shortPip_input_payload_opcode == FpuOpcode_CMP) & (shortPip_input_payload_arg != 2'h2);
	assign shortPip_rs1Nan = shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h2);
	assign shortPip_rs2Nan = shortPip_input_payload_rs2_special & (shortPip_input_payload_rs2_exponent[1:0] == 2'h2);
	assign shortPip_rs1NanNv = (shortPip_input_payload_rs1_special & (shortPip_input_payload_rs1_exponent[1:0] == 2'h2)) & (~|shortPip_input_payload_rs1_mantissa[51] | shortPip_signalQuiet);
	assign shortPip_rs2NanNv = (shortPip_input_payload_rs2_special & (shortPip_input_payload_rs2_exponent[1:0] == 2'h2)) & (~|shortPip_input_payload_rs2_mantissa[51] | shortPip_signalQuiet);
	assign shortPip_NV = (({shortPip_input_payload_opcode == FpuOpcode_FCVT_X_X, shortPip_input_payload_opcode == FpuOpcode_MIN_MAX, shortPip_input_payload_opcode == FpuOpcode_CMP} != 3'h0) & shortPip_rs1NanNv) | (({shortPip_input_payload_opcode == FpuOpcode_MIN_MAX, shortPip_input_payload_opcode == FpuOpcode_CMP} != 2'h0) & shortPip_rs2NanNv);
	assign shortPip_input_ready = ~|shortPip_halt & (shortPip_toFpuRf ? shortPip_rfOutput_ready : shortPip_rspStreams_0_ready);
	assign shortPip_rspStreams_0_valid = ((shortPip_input_valid & 1'b1) & ~|shortPip_toFpuRf) & ~|shortPip_halt;
	assign shortPip_rspStreams_0_payload_value = shortPip_result;
	assign shortPip_rspStreams_0_payload_NV = shortPip_rspNv;
	assign shortPip_rspStreams_0_payload_NX = shortPip_rspNx;
	assign shortPip_rspStreams_0_m2sPipe_valid = shortPip_rspStreams_0_rValid;
	assign shortPip_rspStreams_0_m2sPipe_payload_value = shortPip_rspStreams_0_rData_value;
	assign shortPip_rspStreams_0_m2sPipe_payload_NV = shortPip_rspStreams_0_rData_NV;
	assign shortPip_rspStreams_0_m2sPipe_payload_NX = shortPip_rspStreams_0_rData_NX;
	assign io_port_0_rsp_valid = shortPip_rspStreams_0_m2sPipe_valid;
	assign shortPip_rspStreams_0_m2sPipe_ready = io_port_0_rsp_ready;
	assign io_port_0_rsp_payload_value = shortPip_rspStreams_0_m2sPipe_payload_value;
	assign io_port_0_rsp_payload_NV = shortPip_rspStreams_0_m2sPipe_payload_NV;
	assign io_port_0_rsp_payload_NX = shortPip_rspStreams_0_m2sPipe_payload_NX;
	assign shortPip_rfOutput_payload_NV = shortPip_NV;
	assign mul_preMul_input_valid = decode_mul_rValid;
	assign mul_preMul_input_payload_rs1_mantissa = decode_mul_rData_rs1_mantissa;
	assign mul_preMul_input_payload_rs1_exponent = decode_mul_rData_rs1_exponent;
	assign mul_preMul_input_payload_rs1_sign = decode_mul_rData_rs1_sign;
	assign mul_preMul_input_payload_rs1_special = decode_mul_rData_rs1_special;
	assign mul_preMul_input_payload_rs2_mantissa = decode_mul_rData_rs2_mantissa;
	assign mul_preMul_input_payload_rs2_exponent = decode_mul_rData_rs2_exponent;
	assign mul_preMul_input_payload_rs2_sign = decode_mul_rData_rs2_sign;
	assign mul_preMul_input_payload_rs2_special = decode_mul_rData_rs2_special;
	assign mul_preMul_input_payload_rs3_mantissa = decode_mul_rData_rs3_mantissa;
	assign mul_preMul_input_payload_rs3_exponent = decode_mul_rData_rs3_exponent;
	assign mul_preMul_input_payload_rs3_sign = decode_mul_rData_rs3_sign;
	assign mul_preMul_input_payload_rs3_special = decode_mul_rData_rs3_special;
	assign mul_preMul_input_payload_rd = decode_mul_rData_rd;
	assign mul_preMul_input_payload_add = decode_mul_rData_add;
	assign mul_preMul_input_payload_divSqrt = decode_mul_rData_divSqrt;
	assign mul_preMul_input_payload_msb1 = decode_mul_rData_msb1;
	assign mul_preMul_input_payload_msb2 = decode_mul_rData_msb2;
	assign mul_preMul_input_payload_roundMode = decode_mul_rData_roundMode;
	assign mul_preMul_input_payload_format = decode_mul_rData_format;
	assign mul_preMul_output_valid = mul_preMul_input_valid;
	assign mul_preMul_input_ready = mul_preMul_output_ready;
	assign mul_preMul_output_payload_rs1_mantissa = mul_preMul_input_payload_rs1_mantissa;
	assign mul_preMul_output_payload_rs1_exponent = mul_preMul_input_payload_rs1_exponent;
	assign mul_preMul_output_payload_rs1_sign = mul_preMul_input_payload_rs1_sign;
	assign mul_preMul_output_payload_rs1_special = mul_preMul_input_payload_rs1_special;
	assign mul_preMul_output_payload_rs2_mantissa = mul_preMul_input_payload_rs2_mantissa;
	assign mul_preMul_output_payload_rs2_exponent = mul_preMul_input_payload_rs2_exponent;
	assign mul_preMul_output_payload_rs2_sign = mul_preMul_input_payload_rs2_sign;
	assign mul_preMul_output_payload_rs2_special = mul_preMul_input_payload_rs2_special;
	assign mul_preMul_output_payload_rs3_mantissa = mul_preMul_input_payload_rs3_mantissa;
	assign mul_preMul_output_payload_rs3_exponent = mul_preMul_input_payload_rs3_exponent;
	assign mul_preMul_output_payload_rs3_sign = mul_preMul_input_payload_rs3_sign;
	assign mul_preMul_output_payload_rs3_special = mul_preMul_input_payload_rs3_special;
	assign mul_preMul_output_payload_rd = mul_preMul_input_payload_rd;
	assign mul_preMul_output_payload_add = mul_preMul_input_payload_add;
	assign mul_preMul_output_payload_divSqrt = mul_preMul_input_payload_divSqrt;
	assign mul_preMul_output_payload_msb1 = mul_preMul_input_payload_msb1;
	assign mul_preMul_output_payload_msb2 = mul_preMul_input_payload_msb2;
	assign mul_preMul_output_payload_roundMode = mul_preMul_input_payload_roundMode;
	assign mul_preMul_output_payload_format = mul_preMul_input_payload_format;
	assign mul_mul_input_valid = mul_preMul_output_rValid;
	assign mul_mul_input_payload_rs1_mantissa = mul_preMul_output_rData_rs1_mantissa;
	assign mul_mul_input_payload_rs1_exponent = mul_preMul_output_rData_rs1_exponent;
	assign mul_mul_input_payload_rs1_sign = mul_preMul_output_rData_rs1_sign;
	assign mul_mul_input_payload_rs1_special = mul_preMul_output_rData_rs1_special;
	assign mul_mul_input_payload_rs2_mantissa = mul_preMul_output_rData_rs2_mantissa;
	assign mul_mul_input_payload_rs2_exponent = mul_preMul_output_rData_rs2_exponent;
	assign mul_mul_input_payload_rs2_sign = mul_preMul_output_rData_rs2_sign;
	assign mul_mul_input_payload_rs2_special = mul_preMul_output_rData_rs2_special;
	assign mul_mul_input_payload_rs3_mantissa = mul_preMul_output_rData_rs3_mantissa;
	assign mul_mul_input_payload_rs3_exponent = mul_preMul_output_rData_rs3_exponent;
	assign mul_mul_input_payload_rs3_sign = mul_preMul_output_rData_rs3_sign;
	assign mul_mul_input_payload_rs3_special = mul_preMul_output_rData_rs3_special;
	assign mul_mul_input_payload_rd = mul_preMul_output_rData_rd;
	assign mul_mul_input_payload_add = mul_preMul_output_rData_add;
	assign mul_mul_input_payload_divSqrt = mul_preMul_output_rData_divSqrt;
	assign mul_mul_input_payload_msb1 = mul_preMul_output_rData_msb1;
	assign mul_mul_input_payload_msb2 = mul_preMul_output_rData_msb2;
	assign mul_mul_input_payload_roundMode = mul_preMul_output_rData_roundMode;
	assign mul_mul_input_payload_format = mul_preMul_output_rData_format;
	assign mul_mul_input_payload_exp = mul_preMul_output_rData_exp;
	assign mul_mul_output_valid = mul_mul_input_valid;
	assign mul_mul_input_ready = mul_mul_output_ready;
	assign mul_mul_output_payload_rs1_mantissa = mul_mul_input_payload_rs1_mantissa;
	assign mul_mul_output_payload_rs1_exponent = mul_mul_input_payload_rs1_exponent;
	assign mul_mul_output_payload_rs1_sign = mul_mul_input_payload_rs1_sign;
	assign mul_mul_output_payload_rs1_special = mul_mul_input_payload_rs1_special;
	assign mul_mul_output_payload_rs2_mantissa = mul_mul_input_payload_rs2_mantissa;
	assign mul_mul_output_payload_rs2_exponent = mul_mul_input_payload_rs2_exponent;
	assign mul_mul_output_payload_rs2_sign = mul_mul_input_payload_rs2_sign;
	assign mul_mul_output_payload_rs2_special = mul_mul_input_payload_rs2_special;
	assign mul_mul_output_payload_rs3_mantissa = mul_mul_input_payload_rs3_mantissa;
	assign mul_mul_output_payload_rs3_exponent = mul_mul_input_payload_rs3_exponent;
	assign mul_mul_output_payload_rs3_sign = mul_mul_input_payload_rs3_sign;
	assign mul_mul_output_payload_rs3_special = mul_mul_input_payload_rs3_special;
	assign mul_mul_output_payload_rd = mul_mul_input_payload_rd;
	assign mul_mul_output_payload_add = mul_mul_input_payload_add;
	assign mul_mul_output_payload_divSqrt = mul_mul_input_payload_divSqrt;
	assign mul_mul_output_payload_msb1 = mul_mul_input_payload_msb1;
	assign mul_mul_output_payload_msb2 = mul_mul_input_payload_msb2;
	assign mul_mul_output_payload_roundMode = mul_mul_input_payload_roundMode;
	assign mul_mul_output_payload_format = mul_mul_input_payload_format;
	assign mul_mul_output_payload_exp = mul_mul_input_payload_exp;
	assign mul_sum1_input_valid = mul_mul_output_rValid;
	assign mul_sum1_input_payload_rs1_mantissa = mul_mul_output_rData_rs1_mantissa;
	assign mul_sum1_input_payload_rs1_exponent = mul_mul_output_rData_rs1_exponent;
	assign mul_sum1_input_payload_rs1_sign = mul_mul_output_rData_rs1_sign;
	assign mul_sum1_input_payload_rs1_special = mul_mul_output_rData_rs1_special;
	assign mul_sum1_input_payload_rs2_mantissa = mul_mul_output_rData_rs2_mantissa;
	assign mul_sum1_input_payload_rs2_exponent = mul_mul_output_rData_rs2_exponent;
	assign mul_sum1_input_payload_rs2_sign = mul_mul_output_rData_rs2_sign;
	assign mul_sum1_input_payload_rs2_special = mul_mul_output_rData_rs2_special;
	assign mul_sum1_input_payload_rs3_mantissa = mul_mul_output_rData_rs3_mantissa;
	assign mul_sum1_input_payload_rs3_exponent = mul_mul_output_rData_rs3_exponent;
	assign mul_sum1_input_payload_rs3_sign = mul_mul_output_rData_rs3_sign;
	assign mul_sum1_input_payload_rs3_special = mul_mul_output_rData_rs3_special;
	assign mul_sum1_input_payload_rd = mul_mul_output_rData_rd;
	assign mul_sum1_input_payload_add = mul_mul_output_rData_add;
	assign mul_sum1_input_payload_divSqrt = mul_mul_output_rData_divSqrt;
	assign mul_sum1_input_payload_msb1 = mul_mul_output_rData_msb1;
	assign mul_sum1_input_payload_msb2 = mul_mul_output_rData_msb2;
	assign mul_sum1_input_payload_roundMode = mul_mul_output_rData_roundMode;
	assign mul_sum1_input_payload_format = mul_mul_output_rData_format;
	assign mul_sum1_input_payload_exp = mul_mul_output_rData_exp;
	assign mul_sum1_input_payload_muls_0 = mul_mul_output_rData_muls_0;
	assign mul_sum1_input_payload_muls_1 = mul_mul_output_rData_muls_1;
	assign mul_sum1_input_payload_muls_2 = mul_mul_output_rData_muls_2;
	assign mul_sum1_input_payload_muls_3 = mul_mul_output_rData_muls_3;
	assign mul_sum1_input_payload_muls_4 = mul_mul_output_rData_muls_4;
	assign mul_sum1_input_payload_muls_5 = mul_mul_output_rData_muls_5;
	assign mul_sum1_input_payload_muls_6 = mul_mul_output_rData_muls_6;
	assign mul_sum1_input_payload_muls_7 = mul_mul_output_rData_muls_7;
	assign mul_sum1_input_payload_muls_8 = mul_mul_output_rData_muls_8;
	assign mul_sum1_output_valid = mul_sum1_input_valid;
	assign mul_sum1_input_ready = mul_sum1_output_ready;
	assign mul_sum1_output_payload_rs1_mantissa = mul_sum1_input_payload_rs1_mantissa;
	assign mul_sum1_output_payload_rs1_exponent = mul_sum1_input_payload_rs1_exponent;
	assign mul_sum1_output_payload_rs1_sign = mul_sum1_input_payload_rs1_sign;
	assign mul_sum1_output_payload_rs1_special = mul_sum1_input_payload_rs1_special;
	assign mul_sum1_output_payload_rs2_mantissa = mul_sum1_input_payload_rs2_mantissa;
	assign mul_sum1_output_payload_rs2_exponent = mul_sum1_input_payload_rs2_exponent;
	assign mul_sum1_output_payload_rs2_sign = mul_sum1_input_payload_rs2_sign;
	assign mul_sum1_output_payload_rs2_special = mul_sum1_input_payload_rs2_special;
	assign mul_sum1_output_payload_rs3_mantissa = mul_sum1_input_payload_rs3_mantissa;
	assign mul_sum1_output_payload_rs3_exponent = mul_sum1_input_payload_rs3_exponent;
	assign mul_sum1_output_payload_rs3_sign = mul_sum1_input_payload_rs3_sign;
	assign mul_sum1_output_payload_rs3_special = mul_sum1_input_payload_rs3_special;
	assign mul_sum1_output_payload_rd = mul_sum1_input_payload_rd;
	assign mul_sum1_output_payload_add = mul_sum1_input_payload_add;
	assign mul_sum1_output_payload_divSqrt = mul_sum1_input_payload_divSqrt;
	assign mul_sum1_output_payload_msb1 = mul_sum1_input_payload_msb1;
	assign mul_sum1_output_payload_msb2 = mul_sum1_input_payload_msb2;
	assign mul_sum1_output_payload_roundMode = mul_sum1_input_payload_roundMode;
	assign mul_sum1_output_payload_format = mul_sum1_input_payload_format;
	assign mul_sum1_output_payload_exp = mul_sum1_input_payload_exp;
	assign mul_sum1_output_payload_mulC2 = mul_sum1_sum;
	assign mul_sum1_output_payload_muls2_0 = mul_sum1_input_payload_muls_4;
	assign mul_sum1_output_payload_muls2_1 = mul_sum1_input_payload_muls_5;
	assign mul_sum1_output_payload_muls2_2 = mul_sum1_input_payload_muls_6;
	assign mul_sum1_output_payload_muls2_3 = mul_sum1_input_payload_muls_7;
	assign mul_sum1_output_payload_muls2_4 = mul_sum1_input_payload_muls_8;
	assign mul_sum2_input_valid = mul_sum1_output_rValid;
	assign mul_sum2_input_payload_rs1_mantissa = mul_sum1_output_rData_rs1_mantissa;
	assign mul_sum2_input_payload_rs1_exponent = mul_sum1_output_rData_rs1_exponent;
	assign mul_sum2_input_payload_rs1_sign = mul_sum1_output_rData_rs1_sign;
	assign mul_sum2_input_payload_rs1_special = mul_sum1_output_rData_rs1_special;
	assign mul_sum2_input_payload_rs2_mantissa = mul_sum1_output_rData_rs2_mantissa;
	assign mul_sum2_input_payload_rs2_exponent = mul_sum1_output_rData_rs2_exponent;
	assign mul_sum2_input_payload_rs2_sign = mul_sum1_output_rData_rs2_sign;
	assign mul_sum2_input_payload_rs2_special = mul_sum1_output_rData_rs2_special;
	assign mul_sum2_input_payload_rs3_mantissa = mul_sum1_output_rData_rs3_mantissa;
	assign mul_sum2_input_payload_rs3_exponent = mul_sum1_output_rData_rs3_exponent;
	assign mul_sum2_input_payload_rs3_sign = mul_sum1_output_rData_rs3_sign;
	assign mul_sum2_input_payload_rs3_special = mul_sum1_output_rData_rs3_special;
	assign mul_sum2_input_payload_rd = mul_sum1_output_rData_rd;
	assign mul_sum2_input_payload_add = mul_sum1_output_rData_add;
	assign mul_sum2_input_payload_divSqrt = mul_sum1_output_rData_divSqrt;
	assign mul_sum2_input_payload_msb1 = mul_sum1_output_rData_msb1;
	assign mul_sum2_input_payload_msb2 = mul_sum1_output_rData_msb2;
	assign mul_sum2_input_payload_roundMode = mul_sum1_output_rData_roundMode;
	assign mul_sum2_input_payload_format = mul_sum1_output_rData_format;
	assign mul_sum2_input_payload_exp = mul_sum1_output_rData_exp;
	assign mul_sum2_input_payload_muls2_0 = mul_sum1_output_rData_muls2_0;
	assign mul_sum2_input_payload_muls2_1 = mul_sum1_output_rData_muls2_1;
	assign mul_sum2_input_payload_muls2_2 = mul_sum1_output_rData_muls2_2;
	assign mul_sum2_input_payload_muls2_3 = mul_sum1_output_rData_muls2_3;
	assign mul_sum2_input_payload_muls2_4 = mul_sum1_output_rData_muls2_4;
	assign mul_sum2_input_payload_mulC2 = mul_sum1_output_rData_mulC2;
	assign mul_sum2_input_fire = mul_sum2_input_valid & mul_sum2_input_ready;
	assign when_FpuCore_l221_1 = mul_sum2_input_fire & 1'b1;
	assign mul_sum2_isCommited = commitLogic_0_mul_notEmpty;
	assign mul_sum2_input_ready = mul_sum2_output_ready & _zz_mul_sum2_input_ready;
	assign mul_sum2_output_valid = mul_sum2_input_valid & _zz_mul_sum2_input_ready;
	assign mul_sum2_output_payload_rs1_mantissa = mul_sum2_input_payload_rs1_mantissa;
	assign mul_sum2_output_payload_rs1_exponent = mul_sum2_input_payload_rs1_exponent;
	assign mul_sum2_output_payload_rs1_sign = mul_sum2_input_payload_rs1_sign;
	assign mul_sum2_output_payload_rs1_special = mul_sum2_input_payload_rs1_special;
	assign mul_sum2_output_payload_rs2_mantissa = mul_sum2_input_payload_rs2_mantissa;
	assign mul_sum2_output_payload_rs2_exponent = mul_sum2_input_payload_rs2_exponent;
	assign mul_sum2_output_payload_rs2_sign = mul_sum2_input_payload_rs2_sign;
	assign mul_sum2_output_payload_rs2_special = mul_sum2_input_payload_rs2_special;
	assign mul_sum2_output_payload_rs3_mantissa = mul_sum2_input_payload_rs3_mantissa;
	assign mul_sum2_output_payload_rs3_exponent = mul_sum2_input_payload_rs3_exponent;
	assign mul_sum2_output_payload_rs3_sign = mul_sum2_input_payload_rs3_sign;
	assign mul_sum2_output_payload_rs3_special = mul_sum2_input_payload_rs3_special;
	assign mul_sum2_output_payload_rd = mul_sum2_input_payload_rd;
	assign mul_sum2_output_payload_add = mul_sum2_input_payload_add;
	assign mul_sum2_output_payload_divSqrt = mul_sum2_input_payload_divSqrt;
	assign mul_sum2_output_payload_msb1 = mul_sum2_input_payload_msb1;
	assign mul_sum2_output_payload_msb2 = mul_sum2_input_payload_msb2;
	assign mul_sum2_output_payload_roundMode = mul_sum2_input_payload_roundMode;
	assign mul_sum2_output_payload_format = mul_sum2_input_payload_format;
	assign mul_sum2_output_payload_exp = mul_sum2_input_payload_exp;
	assign mul_sum2_output_payload_mulC = mul_sum2_sum;
	assign mul_norm_input_valid = mul_sum2_output_rValid;
	assign mul_norm_input_payload_rs1_mantissa = mul_sum2_output_rData_rs1_mantissa;
	assign mul_norm_input_payload_rs1_exponent = mul_sum2_output_rData_rs1_exponent;
	assign mul_norm_input_payload_rs1_sign = mul_sum2_output_rData_rs1_sign;
	assign mul_norm_input_payload_rs1_special = mul_sum2_output_rData_rs1_special;
	assign mul_norm_input_payload_rs2_mantissa = mul_sum2_output_rData_rs2_mantissa;
	assign mul_norm_input_payload_rs2_exponent = mul_sum2_output_rData_rs2_exponent;
	assign mul_norm_input_payload_rs2_sign = mul_sum2_output_rData_rs2_sign;
	assign mul_norm_input_payload_rs2_special = mul_sum2_output_rData_rs2_special;
	assign mul_norm_input_payload_rs3_mantissa = mul_sum2_output_rData_rs3_mantissa;
	assign mul_norm_input_payload_rs3_exponent = mul_sum2_output_rData_rs3_exponent;
	assign mul_norm_input_payload_rs3_sign = mul_sum2_output_rData_rs3_sign;
	assign mul_norm_input_payload_rs3_special = mul_sum2_output_rData_rs3_special;
	assign mul_norm_input_payload_rd = mul_sum2_output_rData_rd;
	assign mul_norm_input_payload_add = mul_sum2_output_rData_add;
	assign mul_norm_input_payload_divSqrt = mul_sum2_output_rData_divSqrt;
	assign mul_norm_input_payload_msb1 = mul_sum2_output_rData_msb1;
	assign mul_norm_input_payload_msb2 = mul_sum2_output_rData_msb2;
	assign mul_norm_input_payload_roundMode = mul_sum2_output_rData_roundMode;
	assign mul_norm_input_payload_format = mul_sum2_output_rData_format;
	assign mul_norm_input_payload_exp = mul_sum2_output_rData_exp;
	assign mul_norm_input_payload_mulC = mul_sum2_output_rData_mulC;
	assign when_FpuCore_l967 = mul_norm_needShift & mul_norm_mulHigh[0];
	assign mul_norm_forceZero = (mul_norm_input_payload_rs1_special & (mul_norm_input_payload_rs1_exponent[1:0] == 2'h0)) | (mul_norm_input_payload_rs2_special & (mul_norm_input_payload_rs2_exponent[1:0] == 2'h0));
	assign mul_norm_forceOverflow = (mul_norm_input_payload_rs1_special & (mul_norm_input_payload_rs1_exponent[1:0] == 2'h1)) | (mul_norm_input_payload_rs2_special & (mul_norm_input_payload_rs2_exponent[1:0] == 2'h1));
	assign mul_norm_infinitynan = ((mul_norm_input_payload_rs1_special & (mul_norm_input_payload_rs1_exponent[1:0] == 2'h1)) | (mul_norm_input_payload_rs2_special & (mul_norm_input_payload_rs2_exponent[1:0] == 2'h1))) & ((mul_norm_input_payload_rs1_special & (mul_norm_input_payload_rs1_exponent[1:0] == 2'h0)) | (mul_norm_input_payload_rs2_special & (mul_norm_input_payload_rs2_exponent[1:0] == 2'h0)));
	assign mul_norm_forceNan = ((mul_norm_input_payload_rs1_special & (mul_norm_input_payload_rs1_exponent[1:0] == 2'h2)) | (mul_norm_input_payload_rs2_special & (mul_norm_input_payload_rs2_exponent[1:0] == 2'h2))) | mul_norm_infinitynan;
	assign mul_norm_output_sign = mul_norm_input_payload_rs1_sign ^ mul_norm_input_payload_rs2_sign;
	assign when_FpuCore_l987 = (mul_norm_infinitynan | ((mul_norm_input_payload_rs1_special & (mul_norm_input_payload_rs1_exponent[1:0] == 2'h2)) & ~|mul_norm_input_payload_rs1_mantissa[51])) | ((mul_norm_input_payload_rs2_special & (mul_norm_input_payload_rs2_exponent[1:0] == 2'h2)) & ~|mul_norm_input_payload_rs2_mantissa[51]);
	assign mul_result_notMul_output_valid = mul_norm_input_valid & mul_norm_input_payload_divSqrt;
	assign mul_result_output_valid = (mul_norm_input_valid & ~|mul_norm_input_payload_add) & ~|mul_norm_input_payload_divSqrt;
	assign mul_result_output_payload_rd = mul_norm_input_payload_rd;
	assign mul_result_output_payload_format = mul_norm_input_payload_format;
	assign mul_result_output_payload_roundMode = mul_norm_input_payload_roundMode;
	assign mul_result_output_payload_scrap = mul_norm_scrap;
	assign mul_result_output_payload_value_mantissa = mul_norm_output_mantissa;
	assign mul_result_output_payload_value_exponent = mul_norm_output_exponent;
	assign mul_result_output_payload_value_sign = mul_norm_output_sign;
	assign mul_result_output_payload_value_special = mul_norm_output_special;
	assign mul_result_output_payload_NV = mul_norm_NV;
	assign mul_result_mulToAdd_m2sPipe_valid = mul_result_mulToAdd_rValid;
	assign mul_result_mulToAdd_m2sPipe_payload_rs1_mantissa = mul_result_mulToAdd_rData_rs1_mantissa;
	assign mul_result_mulToAdd_m2sPipe_payload_rs1_exponent = mul_result_mulToAdd_rData_rs1_exponent;
	assign mul_result_mulToAdd_m2sPipe_payload_rs1_sign = mul_result_mulToAdd_rData_rs1_sign;
	assign mul_result_mulToAdd_m2sPipe_payload_rs1_special = mul_result_mulToAdd_rData_rs1_special;
	assign mul_result_mulToAdd_m2sPipe_payload_rs2_mantissa = mul_result_mulToAdd_rData_rs2_mantissa;
	assign mul_result_mulToAdd_m2sPipe_payload_rs2_exponent = mul_result_mulToAdd_rData_rs2_exponent;
	assign mul_result_mulToAdd_m2sPipe_payload_rs2_sign = mul_result_mulToAdd_rData_rs2_sign;
	assign mul_result_mulToAdd_m2sPipe_payload_rs2_special = mul_result_mulToAdd_rData_rs2_special;
	assign mul_result_mulToAdd_m2sPipe_payload_rd = mul_result_mulToAdd_rData_rd;
	assign mul_result_mulToAdd_m2sPipe_payload_roundMode = mul_result_mulToAdd_rData_roundMode;
	assign mul_result_mulToAdd_m2sPipe_payload_format = mul_result_mulToAdd_rData_format;
	assign mul_result_mulToAdd_m2sPipe_payload_needCommit = mul_result_mulToAdd_rData_needCommit;
	assign decode_mulToAdd_valid = mul_result_mulToAdd_m2sPipe_valid;
	assign mul_result_mulToAdd_m2sPipe_ready = decode_mulToAdd_ready;
	assign decode_mulToAdd_payload_rs1_mantissa = mul_result_mulToAdd_m2sPipe_payload_rs1_mantissa;
	assign decode_mulToAdd_payload_rs1_exponent = mul_result_mulToAdd_m2sPipe_payload_rs1_exponent;
	assign decode_mulToAdd_payload_rs1_sign = mul_result_mulToAdd_m2sPipe_payload_rs1_sign;
	assign decode_mulToAdd_payload_rs1_special = mul_result_mulToAdd_m2sPipe_payload_rs1_special;
	assign decode_mulToAdd_payload_rs2_mantissa = mul_result_mulToAdd_m2sPipe_payload_rs2_mantissa;
	assign decode_mulToAdd_payload_rs2_exponent = mul_result_mulToAdd_m2sPipe_payload_rs2_exponent;
	assign decode_mulToAdd_payload_rs2_sign = mul_result_mulToAdd_m2sPipe_payload_rs2_sign;
	assign decode_mulToAdd_payload_rs2_special = mul_result_mulToAdd_m2sPipe_payload_rs2_special;
	assign decode_mulToAdd_payload_rd = mul_result_mulToAdd_m2sPipe_payload_rd;
	assign decode_mulToAdd_payload_roundMode = mul_result_mulToAdd_m2sPipe_payload_roundMode;
	assign decode_mulToAdd_payload_format = mul_result_mulToAdd_m2sPipe_payload_format;
	assign decode_mulToAdd_payload_needCommit = mul_result_mulToAdd_m2sPipe_payload_needCommit;
	assign mul_result_mulToAdd_valid = mul_norm_input_valid & mul_norm_input_payload_add;
	assign mul_result_mulToAdd_payload_rs1_exponent = mul_norm_output_exponent;
	assign mul_result_mulToAdd_payload_rs1_sign = mul_norm_output_sign;
	assign mul_result_mulToAdd_payload_rs1_special = mul_norm_output_special;
	assign mul_result_mulToAdd_payload_rs2_exponent = mul_norm_input_payload_rs3_exponent;
	assign mul_result_mulToAdd_payload_rs2_sign = mul_norm_input_payload_rs3_sign;
	assign mul_result_mulToAdd_payload_rs2_special = mul_norm_input_payload_rs3_special;
	assign mul_result_mulToAdd_payload_rd = mul_norm_input_payload_rd;
	assign mul_result_mulToAdd_payload_roundMode = mul_norm_input_payload_roundMode;
	assign mul_result_mulToAdd_payload_format = mul_norm_input_payload_format;
	assign mul_norm_input_ready = (mul_norm_input_payload_add ? mul_result_mulToAdd_ready : mul_result_output_ready) | mul_norm_input_payload_divSqrt;
	assign div_input_fire = div_input_valid & div_input_ready;
	assign div_input_valid = decode_div_rValid;
	assign div_input_payload_rs1_mantissa = decode_div_rData_rs1_mantissa;
	assign div_input_payload_rs1_exponent = decode_div_rData_rs1_exponent;
	assign div_input_payload_rs1_sign = decode_div_rData_rs1_sign;
	assign div_input_payload_rs1_special = decode_div_rData_rs1_special;
	assign div_input_payload_rs2_mantissa = decode_div_rData_rs2_mantissa;
	assign div_input_payload_rs2_exponent = decode_div_rData_rs2_exponent;
	assign div_input_payload_rs2_sign = decode_div_rData_rs2_sign;
	assign div_input_payload_rs2_special = decode_div_rData_rs2_special;
	assign div_input_payload_rd = decode_div_rData_rd;
	assign div_input_payload_roundMode = decode_div_rData_roundMode;
	assign div_input_payload_format = decode_div_rData_format;
	assign div_input_fire_1 = div_input_valid & div_input_ready;
	assign when_FpuCore_l221_2 = div_input_fire_1 & 1'b1;
	assign div_input_ready = div_output_ready & _zz_div_input_ready;
	assign div_output_valid = div_input_valid & _zz_div_input_ready;
	assign div_dividerResult = div_divider_io_output_payload_result;
	assign div_dividerScrap = (div_divider_io_output_payload_remain != 53'h00000000000000) | 1'b0;
	assign FpuPlugin_fpu_div_divider_io_input_fire = div_divider_io_input_valid & div_divider_io_input_ready;
	assign div_divider_io_input_valid = div_input_valid & ~|div_cmdSent;
	assign div_output_payload_rd = div_input_payload_rd;
	assign div_output_payload_roundMode = div_input_payload_roundMode;
	assign div_output_payload_format = div_input_payload_format;
	assign div_scrap = div_dividerScrap | (~|div_needShift & div_dividerResult[0]);
	assign div_output_payload_value_sign = div_input_payload_rs1_sign ^ div_input_payload_rs2_sign;
	assign div_output_payload_scrap = div_scrap;
	assign div_forceOverflow = (div_input_payload_rs1_special & (div_input_payload_rs1_exponent[1:0] == 2'h1)) | (div_input_payload_rs2_special & (div_input_payload_rs2_exponent[1:0] == 2'h0));
	assign div_infinitynan = ((div_input_payload_rs1_special & (div_input_payload_rs1_exponent[1:0] == 2'h0)) & (div_input_payload_rs2_special & (div_input_payload_rs2_exponent[1:0] == 2'h0))) | ((div_input_payload_rs1_special & (div_input_payload_rs1_exponent[1:0] == 2'h1)) & (div_input_payload_rs2_special & (div_input_payload_rs2_exponent[1:0] == 2'h1)));
	assign div_forceNan = ((div_input_payload_rs1_special & (div_input_payload_rs1_exponent[1:0] == 2'h2)) | (div_input_payload_rs2_special & (div_input_payload_rs2_exponent[1:0] == 2'h2))) | div_infinitynan;
	assign div_forceZero = (div_input_payload_rs1_special & (div_input_payload_rs1_exponent[1:0] == 2'h0)) | (div_input_payload_rs2_special & (div_input_payload_rs2_exponent[1:0] == 2'h1));
	assign div_output_payload_DZ = (~|div_forceNan & ~|(div_input_payload_rs1_special & (div_input_payload_rs1_exponent[1:0] == 2'h1))) & (div_input_payload_rs2_special & (div_input_payload_rs2_exponent[1:0] == 2'h0));
	assign when_FpuCore_l1093 = (div_infinitynan | ((div_input_payload_rs1_special & (div_input_payload_rs1_exponent[1:0] == 2'h2)) & ~|div_input_payload_rs1_mantissa[51])) | ((div_input_payload_rs2_special & (div_input_payload_rs2_exponent[1:0] == 2'h2)) & ~|div_input_payload_rs2_mantissa[51]);
	assign sqrt_input_fire = sqrt_input_valid & sqrt_input_ready;
	assign sqrt_input_valid = decode_sqrt_rValid;
	assign sqrt_input_payload_rs1_mantissa = decode_sqrt_rData_rs1_mantissa;
	assign sqrt_input_payload_rs1_exponent = decode_sqrt_rData_rs1_exponent;
	assign sqrt_input_payload_rs1_sign = decode_sqrt_rData_rs1_sign;
	assign sqrt_input_payload_rs1_special = decode_sqrt_rData_rs1_special;
	assign sqrt_input_payload_rd = decode_sqrt_rData_rd;
	assign sqrt_input_payload_roundMode = decode_sqrt_rData_roundMode;
	assign sqrt_input_payload_format = decode_sqrt_rData_format;
	assign sqrt_input_fire_1 = sqrt_input_valid & sqrt_input_ready;
	assign when_FpuCore_l221_3 = sqrt_input_fire_1 & 1'b1;
	assign sqrt_input_ready = sqrt_output_ready & _zz_sqrt_input_ready;
	assign sqrt_output_valid = sqrt_input_valid & _zz_sqrt_input_ready;
	assign FpuPlugin_fpu_sqrt_sqrt_io_input_fire = sqrt_sqrt_io_input_valid & sqrt_sqrt_io_input_ready;
	assign sqrt_sqrt_io_input_valid = sqrt_input_valid & ~|sqrt_cmdSent;
	assign sqrt_output_payload_rd = sqrt_input_payload_rd;
	assign sqrt_output_payload_roundMode = sqrt_input_payload_roundMode;
	assign sqrt_output_payload_format = sqrt_input_payload_format;
	assign sqrt_output_payload_value_sign = sqrt_input_payload_rs1_sign;
	assign sqrt_output_payload_scrap = sqrt_scrap;
	assign sqrt_negative = (~|(sqrt_input_payload_rs1_special & (sqrt_input_payload_rs1_exponent[1:0] == 2'h2)) & ~|(sqrt_input_payload_rs1_special & (sqrt_input_payload_rs1_exponent[1:0] == 2'h0))) & sqrt_input_payload_rs1_sign;
	assign when_FpuCore_l1137 = sqrt_input_payload_rs1_special & (sqrt_input_payload_rs1_exponent[1:0] == 2'h1);
	assign when_FpuCore_l1144 = sqrt_input_payload_rs1_special & (sqrt_input_payload_rs1_exponent[1:0] == 2'h2);
	assign when_FpuCore_l1148 = sqrt_input_payload_rs1_special & (sqrt_input_payload_rs1_exponent[1:0] == 2'h0);
	assign add_preShifter_input_valid = decode_add_valid;
	assign decode_add_ready = add_preShifter_input_ready;
	assign add_preShifter_input_payload_rs1_mantissa = decode_add_payload_rs1_mantissa;
	assign add_preShifter_input_payload_rs1_exponent = decode_add_payload_rs1_exponent;
	assign add_preShifter_input_payload_rs1_sign = decode_add_payload_rs1_sign;
	assign add_preShifter_input_payload_rs1_special = decode_add_payload_rs1_special;
	assign add_preShifter_input_payload_rs2_mantissa = decode_add_payload_rs2_mantissa;
	assign add_preShifter_input_payload_rs2_exponent = decode_add_payload_rs2_exponent;
	assign add_preShifter_input_payload_rs2_sign = decode_add_payload_rs2_sign;
	assign add_preShifter_input_payload_rs2_special = decode_add_payload_rs2_special;
	assign add_preShifter_input_payload_rd = decode_add_payload_rd;
	assign add_preShifter_input_payload_roundMode = decode_add_payload_roundMode;
	assign add_preShifter_input_payload_format = decode_add_payload_format;
	assign add_preShifter_input_payload_needCommit = decode_add_payload_needCommit;
	assign add_preShifter_output_valid = add_preShifter_input_valid;
	assign add_preShifter_input_ready = add_preShifter_output_ready;
	assign add_preShifter_rs1ExponentBigger = (add_preShifter_exp21[12] | (add_preShifter_input_payload_rs2_special & (add_preShifter_input_payload_rs2_exponent[1:0] == 2'h0))) & ~|(add_preShifter_input_payload_rs1_special & (add_preShifter_input_payload_rs1_exponent[1:0] == 2'h0));
	assign add_preShifter_absRs1Bigger = (((add_preShifter_rs1ExponentBigger | (add_preShifter_rs1ExponentEqual & add_preShifter_rs1MantissaBigger)) & ~|(add_preShifter_input_payload_rs1_special & (add_preShifter_input_payload_rs1_exponent[1:0] == 2'h0))) | (add_preShifter_input_payload_rs1_special & (add_preShifter_input_payload_rs1_exponent[1:0] == 2'h1))) & ~|(add_preShifter_input_payload_rs2_special & (add_preShifter_input_payload_rs2_exponent[1:0] == 2'h1));
	assign add_preShifter_output_payload_rs1_mantissa = add_preShifter_input_payload_rs1_mantissa;
	assign add_preShifter_output_payload_rs1_exponent = add_preShifter_input_payload_rs1_exponent;
	assign add_preShifter_output_payload_rs1_sign = add_preShifter_input_payload_rs1_sign;
	assign add_preShifter_output_payload_rs1_special = add_preShifter_input_payload_rs1_special;
	assign add_preShifter_output_payload_rs2_mantissa = add_preShifter_input_payload_rs2_mantissa;
	assign add_preShifter_output_payload_rs2_exponent = add_preShifter_input_payload_rs2_exponent;
	assign add_preShifter_output_payload_rs2_sign = add_preShifter_input_payload_rs2_sign;
	assign add_preShifter_output_payload_rs2_special = add_preShifter_input_payload_rs2_special;
	assign add_preShifter_output_payload_rd = add_preShifter_input_payload_rd;
	assign add_preShifter_output_payload_roundMode = add_preShifter_input_payload_roundMode;
	assign add_preShifter_output_payload_format = add_preShifter_input_payload_format;
	assign add_preShifter_output_payload_needCommit = add_preShifter_input_payload_needCommit;
	assign add_preShifter_output_payload_absRs1Bigger = add_preShifter_absRs1Bigger;
	assign add_preShifter_output_payload_rs1ExponentBigger = add_preShifter_rs1ExponentBigger;
	assign add_shifter_input_valid = add_preShifter_output_rValid;
	assign add_shifter_input_payload_rs1_mantissa = add_preShifter_output_rData_rs1_mantissa;
	assign add_shifter_input_payload_rs1_exponent = add_preShifter_output_rData_rs1_exponent;
	assign add_shifter_input_payload_rs1_sign = add_preShifter_output_rData_rs1_sign;
	assign add_shifter_input_payload_rs1_special = add_preShifter_output_rData_rs1_special;
	assign add_shifter_input_payload_rs2_mantissa = add_preShifter_output_rData_rs2_mantissa;
	assign add_shifter_input_payload_rs2_exponent = add_preShifter_output_rData_rs2_exponent;
	assign add_shifter_input_payload_rs2_sign = add_preShifter_output_rData_rs2_sign;
	assign add_shifter_input_payload_rs2_special = add_preShifter_output_rData_rs2_special;
	assign add_shifter_input_payload_rd = add_preShifter_output_rData_rd;
	assign add_shifter_input_payload_roundMode = add_preShifter_output_rData_roundMode;
	assign add_shifter_input_payload_format = add_preShifter_output_rData_format;
	assign add_shifter_input_payload_needCommit = add_preShifter_output_rData_needCommit;
	assign add_shifter_input_payload_absRs1Bigger = add_preShifter_output_rData_absRs1Bigger;
	assign add_shifter_input_payload_rs1ExponentBigger = add_preShifter_output_rData_rs1ExponentBigger;
	assign add_shifter_output_valid = add_shifter_input_valid;
	assign add_shifter_input_ready = add_shifter_output_ready;
	assign add_shifter_output_payload_rs1_mantissa = add_shifter_input_payload_rs1_mantissa;
	assign add_shifter_output_payload_rs1_exponent = add_shifter_input_payload_rs1_exponent;
	assign add_shifter_output_payload_rs1_sign = add_shifter_input_payload_rs1_sign;
	assign add_shifter_output_payload_rs1_special = add_shifter_input_payload_rs1_special;
	assign add_shifter_output_payload_rs2_mantissa = add_shifter_input_payload_rs2_mantissa;
	assign add_shifter_output_payload_rs2_exponent = add_shifter_input_payload_rs2_exponent;
	assign add_shifter_output_payload_rs2_sign = add_shifter_input_payload_rs2_sign;
	assign add_shifter_output_payload_rs2_special = add_shifter_input_payload_rs2_special;
	assign add_shifter_output_payload_rd = add_shifter_input_payload_rd;
	assign add_shifter_output_payload_roundMode = add_shifter_input_payload_roundMode;
	assign add_shifter_output_payload_format = add_shifter_input_payload_format;
	assign add_shifter_output_payload_needCommit = add_shifter_input_payload_needCommit;
	assign _zz_add_shifter_shiftBy = add_shifter_exp21;
	assign add_shifter_passThrough = (add_shifter_shiftOverflow | (add_shifter_input_payload_rs1_special & (add_shifter_input_payload_rs1_exponent[1:0] == 2'h0))) | (add_shifter_input_payload_rs2_special & (add_shifter_input_payload_rs2_exponent[1:0] == 2'h0));
	assign add_shifter_output_payload_xSign = add_shifter_xySign ^ (add_shifter_input_payload_rs1ExponentBigger ? add_shifter_input_payload_rs1_sign : add_shifter_input_payload_rs2_sign);
	assign add_shifter_output_payload_ySign = add_shifter_xySign ^ (add_shifter_input_payload_rs1ExponentBigger ? add_shifter_input_payload_rs2_sign : add_shifter_input_payload_rs1_sign);
	assign add_shifter_yMantissa = add_shifter_yMantissaUnshifted;
	assign when_FpuCore_l1419 = add_shifter_shiftBy[5] & (add_shifter_yMantissa[31:0] != 32'h00000000);
	assign when_FpuCore_l1419_1 = add_shifter_shiftBy[4] & (add_shifter_yMantissa_1[15:0] != 16'h0000);
	assign when_FpuCore_l1419_2 = add_shifter_shiftBy[3] & (add_shifter_yMantissa_2[7:0] != 8'h00);
	assign when_FpuCore_l1419_3 = add_shifter_shiftBy[2] & (add_shifter_yMantissa_3[3:0] != 4'h0);
	assign when_FpuCore_l1419_4 = add_shifter_shiftBy[1] & (add_shifter_yMantissa_4[1:0] != 2'h0);
	assign when_FpuCore_l1419_5 = add_shifter_shiftBy[0] & (add_shifter_yMantissa_5[0] ^ 1'b0);
	assign when_FpuCore_l1424 = add_shifter_input_payload_rs1_special | add_shifter_input_payload_rs2_special;
	assign add_shifter_output_payload_xMantissa = add_shifter_xMantissa;
	assign add_shifter_output_payload_yMantissa = add_shifter_yMantissa_6;
	assign add_shifter_output_payload_xySign = add_shifter_xySign;
	assign add_shifter_output_payload_roundingScrap = add_shifter_roundingScrap;
	assign add_math_input_valid = add_shifter_output_rValid;
	assign add_math_input_payload_rs1_mantissa = add_shifter_output_rData_rs1_mantissa;
	assign add_math_input_payload_rs1_exponent = add_shifter_output_rData_rs1_exponent;
	assign add_math_input_payload_rs1_sign = add_shifter_output_rData_rs1_sign;
	assign add_math_input_payload_rs1_special = add_shifter_output_rData_rs1_special;
	assign add_math_input_payload_rs2_mantissa = add_shifter_output_rData_rs2_mantissa;
	assign add_math_input_payload_rs2_exponent = add_shifter_output_rData_rs2_exponent;
	assign add_math_input_payload_rs2_sign = add_shifter_output_rData_rs2_sign;
	assign add_math_input_payload_rs2_special = add_shifter_output_rData_rs2_special;
	assign add_math_input_payload_rd = add_shifter_output_rData_rd;
	assign add_math_input_payload_roundMode = add_shifter_output_rData_roundMode;
	assign add_math_input_payload_format = add_shifter_output_rData_format;
	assign add_math_input_payload_needCommit = add_shifter_output_rData_needCommit;
	assign add_math_input_payload_xSign = add_shifter_output_rData_xSign;
	assign add_math_input_payload_ySign = add_shifter_output_rData_ySign;
	assign add_math_input_payload_xMantissa = add_shifter_output_rData_xMantissa;
	assign add_math_input_payload_yMantissa = add_shifter_output_rData_yMantissa;
	assign add_math_input_payload_xyExponent = add_shifter_output_rData_xyExponent;
	assign add_math_input_payload_xySign = add_shifter_output_rData_xySign;
	assign add_math_input_payload_roundingScrap = add_shifter_output_rData_roundingScrap;
	assign add_math_output_valid = add_math_input_valid;
	assign add_math_input_ready = add_math_output_ready;
	assign add_math_output_payload_rs1_mantissa = add_math_input_payload_rs1_mantissa;
	assign add_math_output_payload_rs1_exponent = add_math_input_payload_rs1_exponent;
	assign add_math_output_payload_rs1_sign = add_math_input_payload_rs1_sign;
	assign add_math_output_payload_rs1_special = add_math_input_payload_rs1_special;
	assign add_math_output_payload_rs2_mantissa = add_math_input_payload_rs2_mantissa;
	assign add_math_output_payload_rs2_exponent = add_math_input_payload_rs2_exponent;
	assign add_math_output_payload_rs2_sign = add_math_input_payload_rs2_sign;
	assign add_math_output_payload_rs2_special = add_math_input_payload_rs2_special;
	assign add_math_output_payload_rd = add_math_input_payload_rd;
	assign add_math_output_payload_roundMode = add_math_input_payload_roundMode;
	assign add_math_output_payload_format = add_math_input_payload_format;
	assign add_math_output_payload_needCommit = add_math_input_payload_needCommit;
	assign add_math_output_payload_xSign = add_math_input_payload_xSign;
	assign add_math_output_payload_ySign = add_math_input_payload_ySign;
	assign add_math_output_payload_xMantissa = add_math_input_payload_xMantissa;
	assign add_math_output_payload_yMantissa = add_math_input_payload_yMantissa;
	assign add_math_output_payload_xyExponent = add_math_input_payload_xyExponent;
	assign add_math_output_payload_xySign = add_math_input_payload_xySign;
	assign add_math_output_payload_roundingScrap = add_math_input_payload_roundingScrap;
	assign add_math_xSigned = _zz_add_math_xSigned;
	assign add_math_ySigned = _zz_add_math_ySigned;
	assign add_oh_input_valid = add_math_output_rValid;
	assign add_oh_input_payload_rs1_mantissa = add_math_output_rData_rs1_mantissa;
	assign add_oh_input_payload_rs1_exponent = add_math_output_rData_rs1_exponent;
	assign add_oh_input_payload_rs1_sign = add_math_output_rData_rs1_sign;
	assign add_oh_input_payload_rs1_special = add_math_output_rData_rs1_special;
	assign add_oh_input_payload_rs2_mantissa = add_math_output_rData_rs2_mantissa;
	assign add_oh_input_payload_rs2_exponent = add_math_output_rData_rs2_exponent;
	assign add_oh_input_payload_rs2_sign = add_math_output_rData_rs2_sign;
	assign add_oh_input_payload_rs2_special = add_math_output_rData_rs2_special;
	assign add_oh_input_payload_rd = add_math_output_rData_rd;
	assign add_oh_input_payload_roundMode = add_math_output_rData_roundMode;
	assign add_oh_input_payload_format = add_math_output_rData_format;
	assign add_oh_input_payload_needCommit = add_math_output_rData_needCommit;
	assign add_oh_input_payload_xSign = add_math_output_rData_xSign;
	assign add_oh_input_payload_ySign = add_math_output_rData_ySign;
	assign add_oh_input_payload_xMantissa = add_math_output_rData_xMantissa;
	assign add_oh_input_payload_yMantissa = add_math_output_rData_yMantissa;
	assign add_oh_input_payload_xyExponent = add_math_output_rData_xyExponent;
	assign add_oh_input_payload_xySign = add_math_output_rData_xySign;
	assign add_oh_input_payload_roundingScrap = add_math_output_rData_roundingScrap;
	assign add_oh_input_payload_xyMantissa = add_math_output_rData_xyMantissa;
	assign add_oh_input_fire = add_oh_input_valid & add_oh_input_ready;
	assign when_FpuCore_l221_4 = (add_oh_input_fire & add_oh_input_payload_needCommit) & 1'b1;
	assign add_oh_isCommited = commitLogic_0_add_notEmpty;
	assign add_oh_input_ready = add_oh_output_ready & _zz_add_oh_input_ready;
	assign add_oh_output_valid = add_oh_input_valid & _zz_add_oh_input_ready;
	assign add_oh_output_payload_rs1_mantissa = add_oh_input_payload_rs1_mantissa;
	assign add_oh_output_payload_rs1_exponent = add_oh_input_payload_rs1_exponent;
	assign add_oh_output_payload_rs1_sign = add_oh_input_payload_rs1_sign;
	assign add_oh_output_payload_rs1_special = add_oh_input_payload_rs1_special;
	assign add_oh_output_payload_rs2_mantissa = add_oh_input_payload_rs2_mantissa;
	assign add_oh_output_payload_rs2_exponent = add_oh_input_payload_rs2_exponent;
	assign add_oh_output_payload_rs2_sign = add_oh_input_payload_rs2_sign;
	assign add_oh_output_payload_rs2_special = add_oh_input_payload_rs2_special;
	assign add_oh_output_payload_rd = add_oh_input_payload_rd;
	assign add_oh_output_payload_roundMode = add_oh_input_payload_roundMode;
	assign add_oh_output_payload_format = add_oh_input_payload_format;
	assign add_oh_output_payload_needCommit = add_oh_input_payload_needCommit;
	assign add_oh_output_payload_xSign = add_oh_input_payload_xSign;
	assign add_oh_output_payload_ySign = add_oh_input_payload_ySign;
	assign add_oh_output_payload_xMantissa = add_oh_input_payload_xMantissa;
	assign add_oh_output_payload_yMantissa = add_oh_input_payload_yMantissa;
	assign add_oh_output_payload_xyExponent = add_oh_input_payload_xyExponent;
	assign add_oh_output_payload_xySign = add_oh_input_payload_xySign;
	assign add_oh_output_payload_roundingScrap = add_oh_input_payload_roundingScrap;
	assign add_oh_output_payload_xyMantissa = add_oh_input_payload_xyMantissa;
	assign _zz_add_oh_shift_1 = _zz_add_oh_shift & ~_zz__zz_add_oh_shift_1_1;
	assign _zz_add_oh_shift_51 = (((((((((((((((_zz__zz_add_oh_shift_51 | _zz_add_oh_shift_21) | _zz_add_oh_shift_23) | _zz_add_oh_shift_25) | _zz_add_oh_shift_27) | _zz_add_oh_shift_28) | _zz_add_oh_shift_30) | _zz_add_oh_shift_32) | _zz_add_oh_shift_34) | _zz_add_oh_shift_36) | _zz_add_oh_shift_38) | _zz_add_oh_shift_40) | _zz_add_oh_shift_42) | _zz_add_oh_shift_44) | _zz_add_oh_shift_46) | _zz_add_oh_shift_48) | _zz_add_oh_shift_50;
	assign _zz_add_oh_shift_52 = (((((((((((((((_zz__zz_add_oh_shift_52 | _zz_add_oh_shift_22) | _zz_add_oh_shift_23) | _zz_add_oh_shift_26) | _zz_add_oh_shift_27) | _zz_add_oh_shift_29) | _zz_add_oh_shift_30) | _zz_add_oh_shift_33) | _zz_add_oh_shift_34) | _zz_add_oh_shift_37) | _zz_add_oh_shift_38) | _zz_add_oh_shift_41) | _zz_add_oh_shift_42) | _zz_add_oh_shift_45) | _zz_add_oh_shift_46) | _zz_add_oh_shift_49) | _zz_add_oh_shift_50;
	assign _zz_add_oh_shift_53 = (((((((((((((((_zz__zz_add_oh_shift_53 | _zz_add_oh_shift_24) | _zz_add_oh_shift_25) | _zz_add_oh_shift_26) | _zz_add_oh_shift_27) | _zz_add_oh_shift_31) | _zz_add_oh_shift_32) | _zz_add_oh_shift_33) | _zz_add_oh_shift_34) | _zz_add_oh_shift_39) | _zz_add_oh_shift_40) | _zz_add_oh_shift_41) | _zz_add_oh_shift_42) | _zz_add_oh_shift_47) | _zz_add_oh_shift_48) | _zz_add_oh_shift_49) | _zz_add_oh_shift_50;
	assign _zz_add_oh_shift_54 = ((((((((((((((((_zz__zz_add_oh_shift_54 | _zz_add_oh_shift_12) | _zz_add_oh_shift_20) | _zz_add_oh_shift_21) | _zz_add_oh_shift_22) | _zz_add_oh_shift_23) | _zz_add_oh_shift_24) | _zz_add_oh_shift_25) | _zz_add_oh_shift_26) | _zz_add_oh_shift_27) | _zz_add_oh_shift_35) | _zz_add_oh_shift_36) | _zz_add_oh_shift_37) | _zz_add_oh_shift_38) | _zz_add_oh_shift_39) | _zz_add_oh_shift_40) | _zz_add_oh_shift_41) | _zz_add_oh_shift_42;
	assign _zz_add_oh_shift_55 = ((((((((((((((((_zz__zz_add_oh_shift_55 | _zz_add_oh_shift_19) | _zz_add_oh_shift_20) | _zz_add_oh_shift_21) | _zz_add_oh_shift_22) | _zz_add_oh_shift_23) | _zz_add_oh_shift_24) | _zz_add_oh_shift_25) | _zz_add_oh_shift_26) | _zz_add_oh_shift_27) | _zz_add_oh_shift_43) | _zz_add_oh_shift_44) | _zz_add_oh_shift_45) | _zz_add_oh_shift_46) | _zz_add_oh_shift_47) | _zz_add_oh_shift_48) | _zz_add_oh_shift_49) | _zz_add_oh_shift_50;
	assign _zz_add_oh_shift_56 = (((((((((((((((_zz__zz_add_oh_shift_56 | _zz_add_oh_shift_35) | _zz_add_oh_shift_36) | _zz_add_oh_shift_37) | _zz_add_oh_shift_38) | _zz_add_oh_shift_39) | _zz_add_oh_shift_40) | _zz_add_oh_shift_41) | _zz_add_oh_shift_42) | _zz_add_oh_shift_43) | _zz_add_oh_shift_44) | _zz_add_oh_shift_45) | _zz_add_oh_shift_46) | _zz_add_oh_shift_47) | _zz_add_oh_shift_48) | _zz_add_oh_shift_49) | _zz_add_oh_shift_50;
	assign add_oh_output_payload_shift = add_oh_shift;
	assign add_norm_input_valid = add_oh_output_rValid;
	assign add_norm_input_payload_rs1_mantissa = add_oh_output_rData_rs1_mantissa;
	assign add_norm_input_payload_rs1_exponent = add_oh_output_rData_rs1_exponent;
	assign add_norm_input_payload_rs1_sign = add_oh_output_rData_rs1_sign;
	assign add_norm_input_payload_rs1_special = add_oh_output_rData_rs1_special;
	assign add_norm_input_payload_rs2_mantissa = add_oh_output_rData_rs2_mantissa;
	assign add_norm_input_payload_rs2_exponent = add_oh_output_rData_rs2_exponent;
	assign add_norm_input_payload_rs2_sign = add_oh_output_rData_rs2_sign;
	assign add_norm_input_payload_rs2_special = add_oh_output_rData_rs2_special;
	assign add_norm_input_payload_rd = add_oh_output_rData_rd;
	assign add_norm_input_payload_roundMode = add_oh_output_rData_roundMode;
	assign add_norm_input_payload_format = add_oh_output_rData_format;
	assign add_norm_input_payload_needCommit = add_oh_output_rData_needCommit;
	assign add_norm_input_payload_xSign = add_oh_output_rData_xSign;
	assign add_norm_input_payload_ySign = add_oh_output_rData_ySign;
	assign add_norm_input_payload_xMantissa = add_oh_output_rData_xMantissa;
	assign add_norm_input_payload_yMantissa = add_oh_output_rData_yMantissa;
	assign add_norm_input_payload_xyExponent = add_oh_output_rData_xyExponent;
	assign add_norm_input_payload_xySign = add_oh_output_rData_xySign;
	assign add_norm_input_payload_roundingScrap = add_oh_output_rData_roundingScrap;
	assign add_norm_input_payload_xyMantissa = add_oh_output_rData_xyMantissa;
	assign add_norm_input_payload_shift = add_oh_output_rData_shift;
	assign add_norm_output_valid = add_norm_input_valid;
	assign add_norm_input_ready = add_norm_output_ready;
	assign add_norm_output_payload_rs1_mantissa = add_norm_input_payload_rs1_mantissa;
	assign add_norm_output_payload_rs1_exponent = add_norm_input_payload_rs1_exponent;
	assign add_norm_output_payload_rs1_sign = add_norm_input_payload_rs1_sign;
	assign add_norm_output_payload_rs1_special = add_norm_input_payload_rs1_special;
	assign add_norm_output_payload_rs2_mantissa = add_norm_input_payload_rs2_mantissa;
	assign add_norm_output_payload_rs2_exponent = add_norm_input_payload_rs2_exponent;
	assign add_norm_output_payload_rs2_sign = add_norm_input_payload_rs2_sign;
	assign add_norm_output_payload_rs2_special = add_norm_input_payload_rs2_special;
	assign add_norm_output_payload_rd = add_norm_input_payload_rd;
	assign add_norm_output_payload_roundMode = add_norm_input_payload_roundMode;
	assign add_norm_output_payload_format = add_norm_input_payload_format;
	assign add_norm_output_payload_needCommit = add_norm_input_payload_needCommit;
	assign add_norm_output_payload_xySign = add_norm_input_payload_xySign;
	assign add_norm_output_payload_roundingScrap = add_norm_input_payload_roundingScrap;
	assign add_norm_output_payload_forceInfinity = (add_norm_input_payload_rs1_special & (add_norm_input_payload_rs1_exponent[1:0] == 2'h1)) | (add_norm_input_payload_rs2_special & (add_norm_input_payload_rs2_exponent[1:0] == 2'h1));
	assign add_norm_output_payload_forceZero = (add_norm_input_payload_xyMantissa == 56'h00000000000000) | ((add_norm_input_payload_rs1_special & (add_norm_input_payload_rs1_exponent[1:0] == 2'h0)) & (add_norm_input_payload_rs2_special & (add_norm_input_payload_rs2_exponent[1:0] == 2'h0)));
	assign add_norm_output_payload_infinityNan = ((add_norm_input_payload_rs1_special & (add_norm_input_payload_rs1_exponent[1:0] == 2'h1)) & (add_norm_input_payload_rs2_special & (add_norm_input_payload_rs2_exponent[1:0] == 2'h1))) & (add_norm_input_payload_rs1_sign ^ add_norm_input_payload_rs2_sign);
	assign add_norm_output_payload_forceNan = ((add_norm_input_payload_rs1_special & (add_norm_input_payload_rs1_exponent[1:0] == 2'h2)) | (add_norm_input_payload_rs2_special & (add_norm_input_payload_rs2_exponent[1:0] == 2'h2))) | add_norm_output_payload_infinityNan;
	assign add_result_input_valid = add_norm_output_valid;
	assign add_norm_output_ready = add_result_input_ready;
	assign add_result_input_payload_rs1_mantissa = add_norm_output_payload_rs1_mantissa;
	assign add_result_input_payload_rs1_exponent = add_norm_output_payload_rs1_exponent;
	assign add_result_input_payload_rs1_sign = add_norm_output_payload_rs1_sign;
	assign add_result_input_payload_rs1_special = add_norm_output_payload_rs1_special;
	assign add_result_input_payload_rs2_mantissa = add_norm_output_payload_rs2_mantissa;
	assign add_result_input_payload_rs2_exponent = add_norm_output_payload_rs2_exponent;
	assign add_result_input_payload_rs2_sign = add_norm_output_payload_rs2_sign;
	assign add_result_input_payload_rs2_special = add_norm_output_payload_rs2_special;
	assign add_result_input_payload_rd = add_norm_output_payload_rd;
	assign add_result_input_payload_roundMode = add_norm_output_payload_roundMode;
	assign add_result_input_payload_format = add_norm_output_payload_format;
	assign add_result_input_payload_needCommit = add_norm_output_payload_needCommit;
	assign add_result_input_payload_mantissa = add_norm_output_payload_mantissa;
	assign add_result_input_payload_exponent = add_norm_output_payload_exponent;
	assign add_result_input_payload_infinityNan = add_norm_output_payload_infinityNan;
	assign add_result_input_payload_forceNan = add_norm_output_payload_forceNan;
	assign add_result_input_payload_forceZero = add_norm_output_payload_forceZero;
	assign add_result_input_payload_forceInfinity = add_norm_output_payload_forceInfinity;
	assign add_result_input_payload_xySign = add_norm_output_payload_xySign;
	assign add_result_input_payload_roundingScrap = add_norm_output_payload_roundingScrap;
	assign add_result_input_payload_xyMantissaZero = add_norm_output_payload_xyMantissaZero;
	assign add_result_output_valid = add_result_input_valid;
	assign add_result_input_ready = add_result_output_ready;
	assign add_result_output_payload_rd = add_result_input_payload_rd;
	assign add_result_output_payload_roundMode = add_result_input_payload_roundMode;
	assign add_result_output_payload_format = add_result_input_payload_format;
	assign add_result_output_payload_scrap = (add_result_input_payload_mantissa[1] | add_result_input_payload_mantissa[0]) | add_result_input_payload_roundingScrap;
	assign add_result_output_payload_NV = (add_result_input_payload_infinityNan | ((add_result_input_payload_rs1_special & (add_result_input_payload_rs1_exponent[1:0] == 2'h2)) & ~|add_result_input_payload_rs1_mantissa[53])) | ((add_result_input_payload_rs2_special & (add_result_input_payload_rs2_exponent[1:0] == 2'h2)) & ~|add_result_input_payload_rs2_mantissa[53]);
	assign when_FpuCore_l1513 = add_result_input_payload_xyMantissaZero | ((add_result_input_payload_rs1_special & (add_result_input_payload_rs1_exponent[1:0] == 2'h0)) & (add_result_input_payload_rs2_special & (add_result_input_payload_rs2_exponent[1:0] == 2'h0)));
	assign when_FpuCore_l1516 = (add_result_input_payload_rs1_sign | add_result_input_payload_rs2_sign) & (add_result_input_payload_roundMode == FpuRoundMode_RDN);
	assign load_s1_output_m2sPipe_valid = load_s1_output_rValid;
	assign load_s1_output_m2sPipe_payload_rd = load_s1_output_rData_rd;
	assign load_s1_output_m2sPipe_payload_value_mantissa = load_s1_output_rData_value_mantissa;
	assign load_s1_output_m2sPipe_payload_value_exponent = load_s1_output_rData_value_exponent;
	assign load_s1_output_m2sPipe_payload_value_sign = load_s1_output_rData_value_sign;
	assign load_s1_output_m2sPipe_payload_value_special = load_s1_output_rData_value_special;
	assign load_s1_output_m2sPipe_payload_scrap = load_s1_output_rData_scrap;
	assign load_s1_output_m2sPipe_payload_roundMode = load_s1_output_rData_roundMode;
	assign load_s1_output_m2sPipe_payload_format = load_s1_output_rData_format;
	assign load_s1_output_m2sPipe_payload_NV = load_s1_output_rData_NV;
	assign load_s1_output_m2sPipe_payload_DZ = load_s1_output_rData_DZ;
	assign shortPip_output_m2sPipe_valid = shortPip_output_rValid;
	assign shortPip_output_m2sPipe_payload_rd = shortPip_output_rData_rd;
	assign shortPip_output_m2sPipe_payload_value_mantissa = shortPip_output_rData_value_mantissa;
	assign shortPip_output_m2sPipe_payload_value_exponent = shortPip_output_rData_value_exponent;
	assign shortPip_output_m2sPipe_payload_value_sign = shortPip_output_rData_value_sign;
	assign shortPip_output_m2sPipe_payload_value_special = shortPip_output_rData_value_special;
	assign shortPip_output_m2sPipe_payload_scrap = shortPip_output_rData_scrap;
	assign shortPip_output_m2sPipe_payload_roundMode = shortPip_output_rData_roundMode;
	assign shortPip_output_m2sPipe_payload_format = shortPip_output_rData_format;
	assign shortPip_output_m2sPipe_payload_NV = shortPip_output_rData_NV;
	assign shortPip_output_m2sPipe_payload_DZ = shortPip_output_rData_DZ;
	assign load_s1_output_m2sPipe_ready = streamArbiter_2_io_inputs_0_ready;
	assign sqrt_output_ready = streamArbiter_2_io_inputs_1_ready;
	assign div_output_ready = streamArbiter_2_io_inputs_2_ready;
	assign add_result_output_ready = streamArbiter_2_io_inputs_3_ready;
	assign mul_result_output_ready = streamArbiter_2_io_inputs_4_ready;
	assign shortPip_output_m2sPipe_ready = streamArbiter_2_io_inputs_5_ready;
	assign FpuPlugin_fpu_streamArbiter_2_io_output_combStage_valid = streamArbiter_2_io_output_valid;
	assign FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_rd = streamArbiter_2_io_output_payload_rd;
	assign FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_value_mantissa = streamArbiter_2_io_output_payload_value_mantissa;
	assign FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_value_exponent = streamArbiter_2_io_output_payload_value_exponent;
	assign FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_value_sign = streamArbiter_2_io_output_payload_value_sign;
	assign FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_value_special = streamArbiter_2_io_output_payload_value_special;
	assign FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_scrap = streamArbiter_2_io_output_payload_scrap;
	assign FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_roundMode = streamArbiter_2_io_output_payload_roundMode;
	assign FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_format = streamArbiter_2_io_output_payload_format;
	assign FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_NV = streamArbiter_2_io_output_payload_NV;
	assign FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_DZ = streamArbiter_2_io_output_payload_DZ;
	assign merge_arbitrated_valid = FpuPlugin_fpu_streamArbiter_2_io_output_combStage_valid;
	assign merge_arbitrated_payload_rd = FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_rd;
	assign merge_arbitrated_payload_value_mantissa = FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_value_mantissa;
	assign merge_arbitrated_payload_value_exponent = FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_value_exponent;
	assign merge_arbitrated_payload_value_sign = FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_value_sign;
	assign merge_arbitrated_payload_value_special = FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_value_special;
	assign merge_arbitrated_payload_scrap = FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_scrap;
	assign merge_arbitrated_payload_roundMode = FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_roundMode;
	assign merge_arbitrated_payload_format = FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_format;
	assign merge_arbitrated_payload_NV = FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_NV;
	assign merge_arbitrated_payload_DZ = FpuPlugin_fpu_streamArbiter_2_io_output_combStage_payload_DZ;
	assign roundFront_output_valid = roundFront_input_valid;
	assign roundFront_output_payload_rd = roundFront_input_payload_rd;
	assign roundFront_output_payload_value_mantissa = roundFront_input_payload_value_mantissa;
	assign roundFront_output_payload_value_exponent = roundFront_input_payload_value_exponent;
	assign roundFront_output_payload_value_sign = roundFront_input_payload_value_sign;
	assign roundFront_output_payload_value_special = roundFront_input_payload_value_special;
	assign roundFront_output_payload_scrap = roundFront_input_payload_scrap;
	assign roundFront_output_payload_roundMode = roundFront_input_payload_roundMode;
	assign roundFront_output_payload_format = roundFront_input_payload_format;
	assign roundFront_output_payload_NV = roundFront_input_payload_NV;
	assign roundFront_output_payload_DZ = roundFront_input_payload_DZ;
	assign roundFront_expSubnormal = ~|roundFront_input_payload_value_special & ~|roundFront_expDif[12];
	assign when_FpuCore_l1551 = roundFront_input_payload_format ~^ FpuFormat_FLOAT;
	assign roundFront_mantissaIncrement = ~|roundFront_input_payload_value_special & _zz_roundFront_mantissaIncrement;
	assign roundFront_output_payload_mantissaIncrement = roundFront_mantissaIncrement;
	assign roundFront_output_payload_roundAdjusted = roundFront_roundAdjusted;
	assign roundFront_output_payload_exactMask = roundFront_exactMask;
	assign roundBack_output_valid = roundBack_input_valid;
	assign roundBack_adderMantissa = roundBack_input_payload_value_mantissa[52:1] & (roundBack_input_payload_mantissaIncrement ? ~_zz_roundBack_adderMantissa : 52'hfffffffffffff);
	assign _zz_roundBack_adder_1 = roundBack_input_payload_mantissaIncrement;
	assign roundBack_masked = roundBack_adder & ~_zz_roundBack_masked;
	assign roundBack_math_special = roundBack_input_payload_value_special;
	assign roundBack_math_sign = roundBack_input_payload_value_sign;
	assign roundBack_patched_sign = roundBack_math_sign;
	assign when_FpuCore_l1606 = roundBack_input_payload_format ~^ FpuFormat_FLOAT;
	assign roundBack_borringCase = (roundBack_input_payload_value_exponent == _zz_roundBack_borringCase) & (roundBack_threshold > roundBack_borringRound);
	assign when_FpuCore_l1609 = (~|roundBack_math_special & ((_zz_when_FpuCore_l1609 >= roundBack_math_exponent) | roundBack_borringCase)) & (roundBack_input_payload_roundAdjusted != 2'h0);
	assign when_FpuCore_l1612 = ~|roundBack_math_special & (roundBack_math_exponent > roundBack_ofThreshold);
	assign when_FpuCore_l1631 = ~|roundBack_math_special & (_zz_when_FpuCore_l1631 > roundBack_math_exponent);
	assign when_FpuCore_l1650 = ~|roundBack_input_payload_value_special & (roundBack_input_payload_roundAdjusted != 2'h0);
	assign roundBack_writes_0 = _zz_rf_scoreboards_0_writes_port1;
	assign roundBack_write = roundBack_writes_0;
	assign roundBack_output_payload_NX = roundBack_nx & roundBack_write;
	assign roundBack_output_payload_OF = roundBack_of & roundBack_write;
	assign roundBack_output_payload_UF = roundBack_uf & roundBack_write;
	assign roundBack_output_payload_NV = roundBack_input_payload_NV & roundBack_write;
	assign roundBack_output_payload_DZ = roundBack_input_payload_DZ & roundBack_write;
	assign roundBack_output_payload_rd = roundBack_input_payload_rd;
	assign roundBack_output_payload_write = roundBack_write;
	assign roundBack_output_payload_format = roundBack_input_payload_format;
	assign roundBack_output_payload_value_mantissa = roundBack_patched_mantissa;
	assign roundBack_output_payload_value_exponent = roundBack_patched_exponent;
	assign roundBack_output_payload_value_sign = roundBack_patched_sign;
	assign roundBack_output_payload_value_special = roundBack_patched_special;
	assign io_port_0_completion_valid = writeback_input_valid & 1'b1;
	assign io_port_0_completion_payload_flags_NX = writeback_input_payload_NX;
	assign io_port_0_completion_payload_flags_OF = writeback_input_payload_OF;
	assign io_port_0_completion_payload_flags_UF = writeback_input_payload_UF;
	assign io_port_0_completion_payload_flags_NV = writeback_input_payload_NV;
	assign io_port_0_completion_payload_flags_DZ = writeback_input_payload_DZ;
	assign io_port_0_completion_payload_written = writeback_input_payload_write;
	assign writeback_port_valid = writeback_input_valid & writeback_input_payload_write;
	assign writeback_port_payload_address = writeback_input_payload_rd;
	assign writeback_port_payload_data_value_exponent = writeback_input_payload_value_exponent;
	assign writeback_port_payload_data_value_sign = writeback_input_payload_value_sign;
	assign writeback_port_payload_data_value_special = writeback_input_payload_value_special;
	assign writeback_port_payload_data_boxed = writeback_input_payload_format ~^ FpuFormat_FLOAT;
	always @(posedge clk)
		if (_zz_read_rs_0_boxed_1)
			_zz_rf_ram_port0 <= rf_ram[_zz_read_rs_0_boxed];
	always @(posedge clk)
		if (_zz_read_rs_1_boxed_1)
			_zz_rf_ram_port1 <= rf_ram[_zz_read_rs_1_boxed];
	always @(posedge clk)
		if (_zz_read_rs_2_boxed_1)
			_zz_rf_ram_port2 <= rf_ram[_zz_read_rs_2_boxed];
	always @(posedge clk)
		if (_zz_1)
			rf_ram[writeback_port_payload_address] <= _zz_rf_ram_port;
	always @(posedge clk)
		if (_zz_4)
			rf_scoreboards_0_target[rf_scoreboards_0_targetWrite_payload_address] <= _zz_rf_scoreboards_0_target_port;
	always @(posedge clk)
		if (_zz_3)
			rf_scoreboards_0_hit[rf_scoreboards_0_hitWrite_payload_address] <= _zz_rf_scoreboards_0_hit_port;
	always @(posedge clk)
		if (_zz_2)
			rf_scoreboards_0_writes[commitLogic_0_input_payload_rd] <= _zz_rf_scoreboards_0_writes_port;
	always @(writeback_port_valid) begin
		_zz_1 = 1'b0;
		if (writeback_port_valid)
			_zz_1 = 1'b1;
	end
	always @(roundFront_discardCount or when_FpuCore_l1551) begin
		roundFront_discardCount_1 = roundFront_discardCount;
		if (when_FpuCore_l1551)
			roundFront_discardCount_1 = roundFront_discardCount + 6'h1d;
	end
	always @(add_shifter_yMantissa_5 or add_shifter_shiftBy or _zz_add_shifter_yMantissa_6 or add_shifter_passThrough) begin
		add_shifter_yMantissa_6 = add_shifter_yMantissa_5;
		add_shifter_yMantissa_6 = (add_shifter_shiftBy[0] ? _zz_add_shifter_yMantissa_6 : add_shifter_yMantissa_5);
		if (add_shifter_passThrough)
			add_shifter_yMantissa_6 = 55'h00000000000000;
	end
	always @(add_shifter_yMantissa_4 or add_shifter_shiftBy or _zz_add_shifter_yMantissa_5) begin
		add_shifter_yMantissa_5 = add_shifter_yMantissa_4;
		add_shifter_yMantissa_5 = (add_shifter_shiftBy[1] ? _zz_add_shifter_yMantissa_5 : add_shifter_yMantissa_4);
	end
	always @(add_shifter_yMantissa_3 or add_shifter_shiftBy or _zz_add_shifter_yMantissa_4) begin
		add_shifter_yMantissa_4 = add_shifter_yMantissa_3;
		add_shifter_yMantissa_4 = (add_shifter_shiftBy[2] ? _zz_add_shifter_yMantissa_4 : add_shifter_yMantissa_3);
	end
	always @(add_shifter_yMantissa_2 or add_shifter_shiftBy or _zz_add_shifter_yMantissa_3) begin
		add_shifter_yMantissa_3 = add_shifter_yMantissa_2;
		add_shifter_yMantissa_3 = (add_shifter_shiftBy[3] ? _zz_add_shifter_yMantissa_3 : add_shifter_yMantissa_2);
	end
	always @(add_shifter_yMantissa_1 or add_shifter_shiftBy or _zz_add_shifter_yMantissa_2) begin
		add_shifter_yMantissa_2 = add_shifter_yMantissa_1;
		add_shifter_yMantissa_2 = (add_shifter_shiftBy[4] ? _zz_add_shifter_yMantissa_2 : add_shifter_yMantissa_1);
	end
	always @(add_shifter_yMantissa or add_shifter_shiftBy or _zz_add_shifter_yMantissa_1) begin
		add_shifter_yMantissa_1 = add_shifter_yMantissa;
		add_shifter_yMantissa_1 = (add_shifter_shiftBy[5] ? _zz_add_shifter_yMantissa_1 : add_shifter_yMantissa);
	end
	always @(shortPip_fsm_shift_input_5 or shortPip_fsm_shift_by or _zz_shortPip_fsm_shift_input_6) begin
		shortPip_fsm_shift_input_6 = shortPip_fsm_shift_input_5;
		shortPip_fsm_shift_input_6 = (shortPip_fsm_shift_by[0] ? _zz_shortPip_fsm_shift_input_6 : shortPip_fsm_shift_input_5);
	end
	always @(shortPip_fsm_shift_input_4 or shortPip_fsm_shift_by or _zz_shortPip_fsm_shift_input_5) begin
		shortPip_fsm_shift_input_5 = shortPip_fsm_shift_input_4;
		shortPip_fsm_shift_input_5 = (shortPip_fsm_shift_by[1] ? _zz_shortPip_fsm_shift_input_5 : shortPip_fsm_shift_input_4);
	end
	always @(shortPip_fsm_shift_input_3 or shortPip_fsm_shift_by or _zz_shortPip_fsm_shift_input_4) begin
		shortPip_fsm_shift_input_4 = shortPip_fsm_shift_input_3;
		shortPip_fsm_shift_input_4 = (shortPip_fsm_shift_by[2] ? _zz_shortPip_fsm_shift_input_4 : shortPip_fsm_shift_input_3);
	end
	always @(shortPip_fsm_shift_input_2 or shortPip_fsm_shift_by or _zz_shortPip_fsm_shift_input_3) begin
		shortPip_fsm_shift_input_3 = shortPip_fsm_shift_input_2;
		shortPip_fsm_shift_input_3 = (shortPip_fsm_shift_by[3] ? _zz_shortPip_fsm_shift_input_3 : shortPip_fsm_shift_input_2);
	end
	always @(shortPip_fsm_shift_input_1 or shortPip_fsm_shift_by or _zz_shortPip_fsm_shift_input_2) begin
		shortPip_fsm_shift_input_2 = shortPip_fsm_shift_input_1;
		shortPip_fsm_shift_input_2 = (shortPip_fsm_shift_by[4] ? _zz_shortPip_fsm_shift_input_2 : shortPip_fsm_shift_input_1);
	end
	always @(shortPip_fsm_shift_input or shortPip_fsm_shift_by or _zz_shortPip_fsm_shift_input_1) begin
		shortPip_fsm_shift_input_1 = shortPip_fsm_shift_input;
		shortPip_fsm_shift_input_1 = (shortPip_fsm_shift_by[5] ? _zz_shortPip_fsm_shift_input_1 : shortPip_fsm_shift_input);
	end
	always @(load_s1_fsm_shift_input_5 or load_s1_fsm_shift_by or _zz_load_s1_fsm_shift_input_6) begin
		load_s1_fsm_shift_input_6 = load_s1_fsm_shift_input_5;
		load_s1_fsm_shift_input_6 = (load_s1_fsm_shift_by[5] ? _zz_load_s1_fsm_shift_input_6 : load_s1_fsm_shift_input_5);
	end
	always @(load_s1_fsm_shift_input_4 or load_s1_fsm_shift_by or _zz_load_s1_fsm_shift_input_5) begin
		load_s1_fsm_shift_input_5 = load_s1_fsm_shift_input_4;
		load_s1_fsm_shift_input_5 = (load_s1_fsm_shift_by[4] ? _zz_load_s1_fsm_shift_input_5 : load_s1_fsm_shift_input_4);
	end
	always @(load_s1_fsm_shift_input_3 or load_s1_fsm_shift_by or _zz_load_s1_fsm_shift_input_4) begin
		load_s1_fsm_shift_input_4 = load_s1_fsm_shift_input_3;
		load_s1_fsm_shift_input_4 = (load_s1_fsm_shift_by[3] ? _zz_load_s1_fsm_shift_input_4 : load_s1_fsm_shift_input_3);
	end
	always @(load_s1_fsm_shift_input_2 or load_s1_fsm_shift_by or _zz_load_s1_fsm_shift_input_3) begin
		load_s1_fsm_shift_input_3 = load_s1_fsm_shift_input_2;
		load_s1_fsm_shift_input_3 = (load_s1_fsm_shift_by[2] ? _zz_load_s1_fsm_shift_input_3 : load_s1_fsm_shift_input_2);
	end
	always @(load_s1_fsm_shift_input_1 or load_s1_fsm_shift_by or _zz_load_s1_fsm_shift_input_2) begin
		load_s1_fsm_shift_input_2 = load_s1_fsm_shift_input_1;
		load_s1_fsm_shift_input_2 = (load_s1_fsm_shift_by[1] ? _zz_load_s1_fsm_shift_input_2 : load_s1_fsm_shift_input_1);
	end
	always @(load_s1_fsm_shift_input or load_s1_fsm_shift_by or _zz_load_s1_fsm_shift_input_1) begin
		load_s1_fsm_shift_input_1 = load_s1_fsm_shift_input;
		load_s1_fsm_shift_input_1 = (load_s1_fsm_shift_by[0] ? _zz_load_s1_fsm_shift_input_1 : load_s1_fsm_shift_input);
	end
	always @(commitLogic_0_input_valid) begin
		_zz_2 = 1'b0;
		if (commitLogic_0_input_valid)
			_zz_2 = 1'b1;
	end
	always @(rf_scoreboards_0_hitWrite_valid) begin
		_zz_3 = 1'b0;
		if (rf_scoreboards_0_hitWrite_valid)
			_zz_3 = 1'b1;
	end
	always @(rf_scoreboards_0_targetWrite_valid) begin
		_zz_4 = 1'b0;
		if (rf_scoreboards_0_targetWrite_valid)
			_zz_4 = 1'b1;
	end
	always @(rf_init_done or when_FpuCore_l265) begin
		rf_scoreboards_0_targetWrite_valid = !rf_init_done;
		if (when_FpuCore_l265)
			rf_scoreboards_0_targetWrite_valid = 1'b1;
	end
	always @(rf_init_counter or when_FpuCore_l261 or scheduler_0_input_payload_rd) begin
		rf_scoreboards_0_targetWrite_payload_address = rf_init_counter[4:0];
		if (when_FpuCore_l261)
			rf_scoreboards_0_targetWrite_payload_address = scheduler_0_input_payload_rd;
	end
	always @(when_FpuCore_l261 or scheduler_0_rfTargets_3) begin
		rf_scoreboards_0_targetWrite_payload_data = 1'b0;
		if (when_FpuCore_l261)
			rf_scoreboards_0_targetWrite_payload_data = !scheduler_0_rfTargets_3;
	end
	always @(rf_init_done or writeback_input_valid or when_FpuCore_l1682) begin
		rf_scoreboards_0_hitWrite_valid = !rf_init_done;
		if (writeback_input_valid) begin
			if (when_FpuCore_l1682)
				rf_scoreboards_0_hitWrite_valid = 1'b1;
		end
	end
	always @(rf_init_counter or writeback_input_valid or writeback_input_payload_rd) begin
		rf_scoreboards_0_hitWrite_payload_address = rf_init_counter[4:0];
		if (writeback_input_valid)
			rf_scoreboards_0_hitWrite_payload_address = writeback_input_payload_rd;
	end
	always @(writeback_input_valid or _zz_rf_scoreboards_0_hit_port5) begin
		rf_scoreboards_0_hitWrite_payload_data = 1'b0;
		if (writeback_input_valid)
			rf_scoreboards_0_hitWrite_payload_data = !_zz_rf_scoreboards_0_hit_port5;
	end
	always @(when_FpuCore_l265) begin
		commitLogic_0_pending_inc = 1'b0;
		if (when_FpuCore_l265)
			commitLogic_0_pending_inc = 1'b1;
	end
	always @(commitLogic_0_input_valid) begin
		commitLogic_0_pending_dec = 1'b0;
		if (commitLogic_0_input_valid)
			commitLogic_0_pending_dec = 1'b1;
	end
	always @(commitLogic_0_input_valid or when_FpuCore_l208) begin
		commitLogic_0_add_inc = 1'b0;
		if (commitLogic_0_input_valid) begin
			if (when_FpuCore_l208)
				commitLogic_0_add_inc = 1'b1;
		end
	end
	always @(when_FpuCore_l221_4) begin
		commitLogic_0_add_dec = 1'b0;
		if (when_FpuCore_l221_4)
			commitLogic_0_add_dec = 1'b1;
	end
	always @(commitLogic_0_input_valid or when_FpuCore_l209) begin
		commitLogic_0_mul_inc = 1'b0;
		if (commitLogic_0_input_valid) begin
			if (when_FpuCore_l209)
				commitLogic_0_mul_inc = 1'b1;
		end
	end
	always @(when_FpuCore_l221_1) begin
		commitLogic_0_mul_dec = 1'b0;
		if (when_FpuCore_l221_1)
			commitLogic_0_mul_dec = 1'b1;
	end
	always @(commitLogic_0_input_valid or when_FpuCore_l210) begin
		commitLogic_0_div_inc = 1'b0;
		if (commitLogic_0_input_valid) begin
			if (when_FpuCore_l210)
				commitLogic_0_div_inc = 1'b1;
		end
	end
	always @(when_FpuCore_l221_2) begin
		commitLogic_0_div_dec = 1'b0;
		if (when_FpuCore_l221_2)
			commitLogic_0_div_dec = 1'b1;
	end
	always @(commitLogic_0_input_valid or when_FpuCore_l211) begin
		commitLogic_0_sqrt_inc = 1'b0;
		if (commitLogic_0_input_valid) begin
			if (when_FpuCore_l211)
				commitLogic_0_sqrt_inc = 1'b1;
		end
	end
	always @(when_FpuCore_l221_3) begin
		commitLogic_0_sqrt_dec = 1'b0;
		if (when_FpuCore_l221_3)
			commitLogic_0_sqrt_dec = 1'b1;
	end
	always @(commitLogic_0_input_valid or when_FpuCore_l212) begin
		commitLogic_0_short_inc = 1'b0;
		if (commitLogic_0_input_valid) begin
			if (when_FpuCore_l212)
				commitLogic_0_short_inc = 1'b1;
		end
	end
	always @(when_FpuCore_l221) begin
		commitLogic_0_short_dec = 1'b0;
		if (when_FpuCore_l221)
			commitLogic_0_short_dec = 1'b1;
	end
	always @(scheduler_0_input_payload_opcode) begin
		scheduler_0_useRs1 = 1'b0;
		case (scheduler_0_input_payload_opcode)
			FpuOpcode_LOAD:
				;
			FpuOpcode_STORE:
				;
			FpuOpcode_ADD: scheduler_0_useRs1 = 1'b1;
			FpuOpcode_MUL: scheduler_0_useRs1 = 1'b1;
			FpuOpcode_DIV: scheduler_0_useRs1 = 1'b1;
			FpuOpcode_SQRT: scheduler_0_useRs1 = 1'b1;
			FpuOpcode_FMA: scheduler_0_useRs1 = 1'b1;
			FpuOpcode_I2F:
				;
			FpuOpcode_F2I: scheduler_0_useRs1 = 1'b1;
			FpuOpcode_MIN_MAX: scheduler_0_useRs1 = 1'b1;
			FpuOpcode_CMP: scheduler_0_useRs1 = 1'b1;
			FpuOpcode_SGNJ: scheduler_0_useRs1 = 1'b1;
			FpuOpcode_FMV_X_W: scheduler_0_useRs1 = 1'b1;
			FpuOpcode_FMV_W_X:
				;
			FpuOpcode_FCLASS: scheduler_0_useRs1 = 1'b1;
			default: scheduler_0_useRs1 = 1'b1;
		endcase
	end
	always @(scheduler_0_input_payload_opcode) begin
		scheduler_0_useRs2 = 1'b0;
		case (scheduler_0_input_payload_opcode)
			FpuOpcode_LOAD:
				;
			FpuOpcode_STORE: scheduler_0_useRs2 = 1'b1;
			FpuOpcode_ADD: scheduler_0_useRs2 = 1'b1;
			FpuOpcode_MUL: scheduler_0_useRs2 = 1'b1;
			FpuOpcode_DIV: scheduler_0_useRs2 = 1'b1;
			FpuOpcode_SQRT:
				;
			FpuOpcode_FMA: scheduler_0_useRs2 = 1'b1;
			FpuOpcode_I2F:
				;
			FpuOpcode_F2I:
				;
			FpuOpcode_MIN_MAX: scheduler_0_useRs2 = 1'b1;
			FpuOpcode_CMP: scheduler_0_useRs2 = 1'b1;
			FpuOpcode_SGNJ: scheduler_0_useRs2 = 1'b1;
			FpuOpcode_FMV_X_W:
				;
			FpuOpcode_FMV_W_X:
				;
			FpuOpcode_FCLASS:
				;
			default:
				;
		endcase
	end
	always @(scheduler_0_input_payload_opcode) begin
		scheduler_0_useRs3 = 1'b0;
		case (scheduler_0_input_payload_opcode)
			FpuOpcode_LOAD:
				;
			FpuOpcode_STORE:
				;
			FpuOpcode_ADD:
				;
			FpuOpcode_MUL:
				;
			FpuOpcode_DIV:
				;
			FpuOpcode_SQRT:
				;
			FpuOpcode_FMA: scheduler_0_useRs3 = 1'b1;
			FpuOpcode_I2F:
				;
			FpuOpcode_F2I:
				;
			FpuOpcode_MIN_MAX:
				;
			FpuOpcode_CMP:
				;
			FpuOpcode_SGNJ:
				;
			FpuOpcode_FMV_X_W:
				;
			FpuOpcode_FMV_W_X:
				;
			FpuOpcode_FCLASS:
				;
			default:
				;
		endcase
	end
	always @(scheduler_0_input_payload_opcode) begin
		scheduler_0_useRd = 1'b0;
		case (scheduler_0_input_payload_opcode)
			FpuOpcode_LOAD: scheduler_0_useRd = 1'b1;
			FpuOpcode_STORE:
				;
			FpuOpcode_ADD: scheduler_0_useRd = 1'b1;
			FpuOpcode_MUL: scheduler_0_useRd = 1'b1;
			FpuOpcode_DIV: scheduler_0_useRd = 1'b1;
			FpuOpcode_SQRT: scheduler_0_useRd = 1'b1;
			FpuOpcode_FMA: scheduler_0_useRd = 1'b1;
			FpuOpcode_I2F: scheduler_0_useRd = 1'b1;
			FpuOpcode_F2I:
				;
			FpuOpcode_MIN_MAX: scheduler_0_useRd = 1'b1;
			FpuOpcode_CMP:
				;
			FpuOpcode_SGNJ: scheduler_0_useRd = 1'b1;
			FpuOpcode_FMV_X_W:
				;
			FpuOpcode_FMV_W_X: scheduler_0_useRd = 1'b1;
			FpuOpcode_FCLASS:
				;
			default: scheduler_0_useRd = 1'b1;
		endcase
	end
	always @(scheduler_0_input_payload_rs1 or when_FpuCore_l258 or scheduler_0_input_payload_rs2) begin
		scheduler_0_output_payload_rs1 = scheduler_0_input_payload_rs1;
		if (when_FpuCore_l258)
			scheduler_0_output_payload_rs1 = scheduler_0_input_payload_rs2;
	end
	always @(read_s1_ready or when_Stream_l368) begin
		read_s0_ready = read_s1_ready;
		if (when_Stream_l368)
			read_s0_ready = 1'b1;
	end
	always @(read_rs_0_value_mantissa or when_FpuCore_l304 or when_FpuCore_l305 or when_FpuCore_l307) begin
		read_output_payload_rs1_mantissa = read_rs_0_value_mantissa;
		if (when_FpuCore_l304) begin
			if (!when_FpuCore_l305) begin
				if (when_FpuCore_l307)
					read_output_payload_rs1_mantissa[51] = 1'b1;
			end
		end
	end
	always @(read_rs_0_value_exponent or when_FpuCore_l304 or when_FpuCore_l305 or when_FpuCore_l307) begin
		read_output_payload_rs1_exponent = read_rs_0_value_exponent;
		if (when_FpuCore_l304) begin
			if (!when_FpuCore_l305) begin
				if (when_FpuCore_l307) begin
					read_output_payload_rs1_exponent[1:0] = 2'h2;
					read_output_payload_rs1_exponent[2] = 1'b1;
				end
			end
		end
	end
	always @(read_rs_0_value_sign or when_FpuCore_l304 or when_FpuCore_l305 or when_FpuCore_l307) begin
		read_output_payload_rs1_sign = read_rs_0_value_sign;
		if (when_FpuCore_l304) begin
			if (!when_FpuCore_l305) begin
				if (when_FpuCore_l307)
					read_output_payload_rs1_sign = 1'b0;
			end
		end
	end
	always @(read_rs_0_value_special or when_FpuCore_l304 or when_FpuCore_l305 or when_FpuCore_l307) begin
		read_output_payload_rs1_special = read_rs_0_value_special;
		if (when_FpuCore_l304) begin
			if (!when_FpuCore_l305) begin
				if (when_FpuCore_l307)
					read_output_payload_rs1_special = 1'b1;
			end
		end
	end
	always @(read_rs_1_value_mantissa or when_FpuCore_l312) begin
		read_output_payload_rs2_mantissa = read_rs_1_value_mantissa;
		if (when_FpuCore_l312)
			read_output_payload_rs2_mantissa[51] = 1'b1;
	end
	always @(read_rs_1_value_exponent or when_FpuCore_l312) begin
		read_output_payload_rs2_exponent = read_rs_1_value_exponent;
		if (when_FpuCore_l312) begin
			read_output_payload_rs2_exponent[1:0] = 2'h2;
			read_output_payload_rs2_exponent[2] = 1'b1;
		end
	end
	always @(read_rs_1_value_sign or when_FpuCore_l312) begin
		read_output_payload_rs2_sign = read_rs_1_value_sign;
		if (when_FpuCore_l312)
			read_output_payload_rs2_sign = 1'b0;
	end
	always @(read_rs_1_value_special or when_FpuCore_l312) begin
		read_output_payload_rs2_special = read_rs_1_value_special;
		if (when_FpuCore_l312)
			read_output_payload_rs2_special = 1'b1;
	end
	always @(read_rs_2_value_mantissa or when_FpuCore_l316) begin
		read_output_payload_rs3_mantissa = read_rs_2_value_mantissa;
		if (when_FpuCore_l316)
			read_output_payload_rs3_mantissa[51] = 1'b1;
	end
	always @(read_rs_2_value_exponent or when_FpuCore_l316) begin
		read_output_payload_rs3_exponent = read_rs_2_value_exponent;
		if (when_FpuCore_l316) begin
			read_output_payload_rs3_exponent[1:0] = 2'h2;
			read_output_payload_rs3_exponent[2] = 1'b1;
		end
	end
	always @(read_rs_2_value_special or when_FpuCore_l316) begin
		read_output_payload_rs3_special = read_rs_2_value_special;
		if (when_FpuCore_l316)
			read_output_payload_rs3_special = 1'b1;
	end
	always @(read_s1_payload_format or when_FpuCore_l304 or when_FpuCore_l305 or _zz_read_output_payload_format) begin
		read_output_payload_format = read_s1_payload_format;
		if (when_FpuCore_l304) begin
			if (when_FpuCore_l305)
				read_output_payload_format = _zz_read_output_payload_format;
		end
	end
	always @(when_FpuCore_l329 or when_FpuCore_l335 or when_FpuCore_l351 or when_FpuCore_l359 or when_FpuCore_l375 or when_FpuCore_l399) begin
		decode_input_ready = 1'b0;
		if (when_FpuCore_l329)
			decode_input_ready = 1'b1;
		if (when_FpuCore_l335)
			decode_input_ready = 1'b1;
		if (when_FpuCore_l351)
			decode_input_ready = 1'b1;
		if (when_FpuCore_l359)
			decode_input_ready = 1'b1;
		if (when_FpuCore_l375)
			decode_input_ready = 1'b1;
		if (when_FpuCore_l399)
			decode_input_ready = 1'b1;
	end
	always @(decode_divSqrtToMul_payload_rs1_mantissa or when_FpuCore_l380 or decode_input_payload_rs1_mantissa) begin
		decode_mul_payload_rs1_mantissa = decode_divSqrtToMul_payload_rs1_mantissa;
		if (when_FpuCore_l380)
			decode_mul_payload_rs1_mantissa = decode_input_payload_rs1_mantissa;
	end
	always @(decode_divSqrtToMul_payload_rs1_exponent or when_FpuCore_l380 or decode_input_payload_rs1_exponent) begin
		decode_mul_payload_rs1_exponent = decode_divSqrtToMul_payload_rs1_exponent;
		if (when_FpuCore_l380)
			decode_mul_payload_rs1_exponent = decode_input_payload_rs1_exponent;
	end
	always @(decode_divSqrtToMul_payload_rs1_sign or when_FpuCore_l380 or decode_input_payload_rs1_sign) begin
		decode_mul_payload_rs1_sign = decode_divSqrtToMul_payload_rs1_sign;
		if (when_FpuCore_l380)
			decode_mul_payload_rs1_sign = decode_input_payload_rs1_sign;
	end
	always @(decode_divSqrtToMul_payload_rs1_special or when_FpuCore_l380 or decode_input_payload_rs1_special) begin
		decode_mul_payload_rs1_special = decode_divSqrtToMul_payload_rs1_special;
		if (when_FpuCore_l380)
			decode_mul_payload_rs1_special = decode_input_payload_rs1_special;
	end
	always @(decode_divSqrtToMul_payload_rs2_mantissa or when_FpuCore_l380 or decode_input_payload_rs2_mantissa) begin
		decode_mul_payload_rs2_mantissa = decode_divSqrtToMul_payload_rs2_mantissa;
		if (when_FpuCore_l380)
			decode_mul_payload_rs2_mantissa = decode_input_payload_rs2_mantissa;
	end
	always @(decode_divSqrtToMul_payload_rs2_exponent or when_FpuCore_l380 or decode_input_payload_rs2_exponent) begin
		decode_mul_payload_rs2_exponent = decode_divSqrtToMul_payload_rs2_exponent;
		if (when_FpuCore_l380)
			decode_mul_payload_rs2_exponent = decode_input_payload_rs2_exponent;
	end
	always @(decode_divSqrtToMul_payload_rs2_sign or when_FpuCore_l380 or decode_input_payload_rs2_sign or decode_input_payload_arg) begin
		decode_mul_payload_rs2_sign = decode_divSqrtToMul_payload_rs2_sign;
		if (when_FpuCore_l380) begin
			decode_mul_payload_rs2_sign = decode_input_payload_rs2_sign;
			decode_mul_payload_rs2_sign = decode_input_payload_rs2_sign ^ decode_input_payload_arg[0];
		end
	end
	always @(decode_divSqrtToMul_payload_rs2_special or when_FpuCore_l380 or decode_input_payload_rs2_special) begin
		decode_mul_payload_rs2_special = decode_divSqrtToMul_payload_rs2_special;
		if (when_FpuCore_l380)
			decode_mul_payload_rs2_special = decode_input_payload_rs2_special;
	end
	always @(decode_divSqrtToMul_payload_rs3_mantissa or when_FpuCore_l380 or decode_input_payload_rs3_mantissa) begin
		decode_mul_payload_rs3_mantissa = decode_divSqrtToMul_payload_rs3_mantissa;
		if (when_FpuCore_l380)
			decode_mul_payload_rs3_mantissa = decode_input_payload_rs3_mantissa;
	end
	always @(decode_divSqrtToMul_payload_rs3_exponent or when_FpuCore_l380 or decode_input_payload_rs3_exponent) begin
		decode_mul_payload_rs3_exponent = decode_divSqrtToMul_payload_rs3_exponent;
		if (when_FpuCore_l380)
			decode_mul_payload_rs3_exponent = decode_input_payload_rs3_exponent;
	end
	always @(decode_divSqrtToMul_payload_rs3_sign or when_FpuCore_l380 or decode_input_payload_rs3_sign or decode_input_payload_arg) begin
		decode_mul_payload_rs3_sign = decode_divSqrtToMul_payload_rs3_sign;
		if (when_FpuCore_l380) begin
			decode_mul_payload_rs3_sign = decode_input_payload_rs3_sign;
			decode_mul_payload_rs3_sign = decode_input_payload_rs3_sign ^ decode_input_payload_arg[1];
		end
	end
	always @(decode_divSqrtToMul_payload_rs3_special or when_FpuCore_l380 or decode_input_payload_rs3_special) begin
		decode_mul_payload_rs3_special = decode_divSqrtToMul_payload_rs3_special;
		if (when_FpuCore_l380)
			decode_mul_payload_rs3_special = decode_input_payload_rs3_special;
	end
	always @(decode_divSqrtToMul_payload_rd or when_FpuCore_l380 or decode_input_payload_rd) begin
		decode_mul_payload_rd = decode_divSqrtToMul_payload_rd;
		if (when_FpuCore_l380)
			decode_mul_payload_rd = decode_input_payload_rd;
	end
	always @(decode_divSqrtToMul_payload_add or when_FpuCore_l380 or decode_fmaHit) begin
		decode_mul_payload_add = decode_divSqrtToMul_payload_add;
		if (when_FpuCore_l380)
			decode_mul_payload_add = decode_fmaHit;
	end
	always @(decode_divSqrtToMul_payload_divSqrt or when_FpuCore_l380) begin
		decode_mul_payload_divSqrt = decode_divSqrtToMul_payload_divSqrt;
		if (when_FpuCore_l380)
			decode_mul_payload_divSqrt = 1'b0;
	end
	always @(decode_divSqrtToMul_payload_msb1 or when_FpuCore_l380) begin
		decode_mul_payload_msb1 = decode_divSqrtToMul_payload_msb1;
		if (when_FpuCore_l380)
			decode_mul_payload_msb1 = 1'b1;
	end
	always @(decode_divSqrtToMul_payload_msb2 or when_FpuCore_l380) begin
		decode_mul_payload_msb2 = decode_divSqrtToMul_payload_msb2;
		if (when_FpuCore_l380)
			decode_mul_payload_msb2 = 1'b1;
	end
	always @(decode_divSqrtToMul_payload_roundMode or when_FpuCore_l380 or decode_input_payload_roundMode) begin
		decode_mul_payload_roundMode = decode_divSqrtToMul_payload_roundMode;
		if (when_FpuCore_l380)
			decode_mul_payload_roundMode = decode_input_payload_roundMode;
	end
	always @(decode_divSqrtToMul_payload_format or when_FpuCore_l380 or decode_input_payload_format) begin
		decode_mul_payload_format = decode_divSqrtToMul_payload_format;
		if (when_FpuCore_l380)
			decode_mul_payload_format = decode_input_payload_format;
	end
	always @(decode_mulToAdd_payload_rs1_mantissa or when_FpuCore_l404 or decode_input_payload_rs1_mantissa) begin
		decode_add_payload_rs1_mantissa = decode_mulToAdd_payload_rs1_mantissa;
		if (when_FpuCore_l404)
			decode_add_payload_rs1_mantissa = {2'h0, decode_input_payload_rs1_mantissa} << 32'h00000002;
	end
	always @(decode_mulToAdd_payload_rs1_exponent or when_FpuCore_l404 or decode_input_payload_rs1_exponent) begin
		decode_add_payload_rs1_exponent = decode_mulToAdd_payload_rs1_exponent;
		if (when_FpuCore_l404)
			decode_add_payload_rs1_exponent = decode_input_payload_rs1_exponent;
	end
	always @(decode_mulToAdd_payload_rs1_sign or when_FpuCore_l404 or decode_input_payload_rs1_sign) begin
		decode_add_payload_rs1_sign = decode_mulToAdd_payload_rs1_sign;
		if (when_FpuCore_l404)
			decode_add_payload_rs1_sign = decode_input_payload_rs1_sign;
	end
	always @(decode_mulToAdd_payload_rs1_special or when_FpuCore_l404 or decode_input_payload_rs1_special) begin
		decode_add_payload_rs1_special = decode_mulToAdd_payload_rs1_special;
		if (when_FpuCore_l404)
			decode_add_payload_rs1_special = decode_input_payload_rs1_special;
	end
	always @(decode_mulToAdd_payload_rs2_mantissa or when_FpuCore_l404 or decode_input_payload_rs2_mantissa) begin
		decode_add_payload_rs2_mantissa = decode_mulToAdd_payload_rs2_mantissa;
		if (when_FpuCore_l404)
			decode_add_payload_rs2_mantissa = {2'h0, decode_input_payload_rs2_mantissa} << 32'h00000002;
	end
	always @(decode_mulToAdd_payload_rs2_exponent or when_FpuCore_l404 or decode_input_payload_rs2_exponent) begin
		decode_add_payload_rs2_exponent = decode_mulToAdd_payload_rs2_exponent;
		if (when_FpuCore_l404)
			decode_add_payload_rs2_exponent = decode_input_payload_rs2_exponent;
	end
	always @(decode_mulToAdd_payload_rs2_sign or when_FpuCore_l404 or decode_input_payload_rs2_sign or decode_input_payload_arg) begin
		decode_add_payload_rs2_sign = decode_mulToAdd_payload_rs2_sign;
		if (when_FpuCore_l404)
			decode_add_payload_rs2_sign = decode_input_payload_rs2_sign ^ decode_input_payload_arg[0];
	end
	always @(decode_mulToAdd_payload_rs2_special or when_FpuCore_l404 or decode_input_payload_rs2_special) begin
		decode_add_payload_rs2_special = decode_mulToAdd_payload_rs2_special;
		if (when_FpuCore_l404)
			decode_add_payload_rs2_special = decode_input_payload_rs2_special;
	end
	always @(decode_mulToAdd_payload_rd or when_FpuCore_l404 or decode_input_payload_rd) begin
		decode_add_payload_rd = decode_mulToAdd_payload_rd;
		if (when_FpuCore_l404)
			decode_add_payload_rd = decode_input_payload_rd;
	end
	always @(decode_mulToAdd_payload_roundMode or when_FpuCore_l404 or decode_input_payload_roundMode) begin
		decode_add_payload_roundMode = decode_mulToAdd_payload_roundMode;
		if (when_FpuCore_l404)
			decode_add_payload_roundMode = decode_input_payload_roundMode;
	end
	always @(decode_mulToAdd_payload_format or when_FpuCore_l404 or decode_input_payload_format) begin
		decode_add_payload_format = decode_mulToAdd_payload_format;
		if (when_FpuCore_l404)
			decode_add_payload_format = decode_input_payload_format;
	end
	always @(decode_mulToAdd_payload_needCommit or when_FpuCore_l404) begin
		decode_add_payload_needCommit = decode_mulToAdd_payload_needCommit;
		if (when_FpuCore_l404)
			decode_add_payload_needCommit = 1'b1;
	end
	always @(decode_load_s2mPipe_m2sPipe_ready or when_Stream_l368_1) begin
		decode_load_s2mPipe_ready = decode_load_s2mPipe_m2sPipe_ready;
		if (when_Stream_l368_1)
			decode_load_s2mPipe_ready = 1'b1;
	end
	always @(load_s0_input_ready or when_Stream_l368_2) begin
		decode_load_s2mPipe_m2sPipe_ready = load_s0_input_ready;
		if (when_Stream_l368_2)
			decode_load_s2mPipe_m2sPipe_ready = 1'b1;
	end
	always @(commitFork_load_0_valid or when_Stream_l438) begin
		load_s0_filtred_0_valid = commitFork_load_0_valid;
		if (when_Stream_l438)
			load_s0_filtred_0_valid = 1'b0;
	end
	always @(load_s0_filtred_0_ready or when_Stream_l438) begin
		commitFork_load_0_ready = load_s0_filtred_0_ready;
		if (when_Stream_l438)
			commitFork_load_0_ready = 1'b1;
	end
	always @(_zz_when or load_s0_input_valid or load_s0_output_ready) begin
		load_s0_filtred_0_ready = 1'b0;
		if (_zz_when)
			load_s0_filtred_0_ready = load_s0_input_valid && load_s0_output_ready;
	end
	always @(load_s0_input_payload_format or when_FpuCore_l452) begin
		load_s0_output_payload_format = load_s0_input_payload_format;
		if (when_FpuCore_l452)
			load_s0_output_payload_format = FpuFormat_FLOAT;
	end
	always @(load_s1_input_ready or when_Stream_l368_3) begin
		load_s0_output_ready = load_s1_input_ready;
		if (when_Stream_l368_3)
			load_s0_output_ready = 1'b1;
	end
	always @(when_FpuCore_l529) begin
		load_s1_busy = 1'b0;
		if (when_FpuCore_l529)
			load_s1_busy = 1'b1;
	end
	always @(when_FpuCore_l31 or load_s1_f64_sign or load_s1_f32_sign)
		if (when_FpuCore_l31)
			load_s1_passThroughFloat_sign = load_s1_f64_sign;
		else
			load_s1_passThroughFloat_sign = load_s1_f32_sign;
	always @(when_FpuCore_l31 or load_s1_f64_exponent or load_s1_f32_exponent)
		if (when_FpuCore_l31)
			load_s1_passThroughFloat_exponent = {1'b0, load_s1_f64_exponent};
		else
			load_s1_passThroughFloat_exponent = {4'h0, load_s1_f32_exponent};
	always @(when_FpuCore_l31 or load_s1_f64_mantissa or load_s1_f32_mantissa)
		if (when_FpuCore_l31)
			load_s1_passThroughFloat_mantissa = load_s1_f64_mantissa;
		else
			load_s1_passThroughFloat_mantissa = {29'h00000000, load_s1_f32_mantissa} << 32'h0000001d;
	always @(when_FpuCore_l31)
		if (when_FpuCore_l31)
			load_s1_recodedExpOffset = 12'h400;
		else
			load_s1_recodedExpOffset = 12'h780;
	always @(load_s1_passThroughFloat_exponent or when_FpuCore_l494) begin
		load_s1_expZero = load_s1_passThroughFloat_exponent == 12'h000;
		if (when_FpuCore_l494)
			load_s1_expZero = 1'b0;
	end
	always @(load_s1_passThroughFloat_exponent or when_FpuCore_l495) begin
		load_s1_expOne = &load_s1_passThroughFloat_exponent[7:0];
		if (when_FpuCore_l495)
			load_s1_expOne = 1'b0;
	end
	always @(when_FpuCore_l508 or load_s1_passThroughFloat_mantissa or load_s1_input_payload_value) begin
		load_s1_fsm_ohInput = 52'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		if (when_FpuCore_l508)
			load_s1_fsm_ohInput = load_s1_passThroughFloat_mantissa;
		else begin
			load_s1_fsm_ohInput[19:0] = 20'h00000;
			load_s1_fsm_ohInput[51:20] = load_s1_input_payload_value[31:0];
		end
	end
	always @(load_s1_fsm_ohInput) begin
		load_s1_fsm_shift_input = 52'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		load_s1_fsm_shift_input = load_s1_fsm_ohInput << 32'h00000001;
	end
	always @(load_s1_isSubnormal or load_s1_fsm_shift_by) begin
		load_s1_fsm_expOffset = 12'h000;
		if (load_s1_isSubnormal)
			load_s1_fsm_expOffset = {6'h00, load_s1_fsm_shift_by};
	end
	always @(_zz_load_s1_recoded_exponent or load_s1_isZero or load_s1_isInfinity or load_s1_isNan) begin
		load_s1_recoded_exponent = _zz_load_s1_recoded_exponent[11:0];
		if (load_s1_isZero)
			load_s1_recoded_exponent[1:0] = 2'h0;
		if (load_s1_isInfinity)
			load_s1_recoded_exponent[1:0] = 2'h1;
		if (load_s1_isNan) begin
			load_s1_recoded_exponent[1:0] = 2'h2;
			load_s1_recoded_exponent[2] = 1'b0;
		end
	end
	always @(load_s1_isZero or load_s1_isInfinity or load_s1_isNan) begin
		load_s1_recoded_special = 1'b0;
		if (load_s1_isZero)
			load_s1_recoded_special = 1'b1;
		if (load_s1_isInfinity)
			load_s1_recoded_special = 1'b1;
		if (load_s1_isNan)
			load_s1_recoded_special = 1'b1;
	end
	always @(load_s1_recoded_sign or load_s1_input_payload_i2f or load_s1_fsm_patched) begin
		load_s1_output_payload_value_sign = load_s1_recoded_sign;
		if (load_s1_input_payload_i2f)
			load_s1_output_payload_value_sign = load_s1_fsm_patched;
	end
	always @(load_s1_recoded_exponent or load_s1_input_payload_i2f or _zz_load_s1_output_payload_value_exponent or load_s1_fsm_i2fZero) begin
		load_s1_output_payload_value_exponent = load_s1_recoded_exponent;
		if (load_s1_input_payload_i2f) begin
			load_s1_output_payload_value_exponent = 12'h81e - _zz_load_s1_output_payload_value_exponent;
			if (load_s1_fsm_i2fZero)
				load_s1_output_payload_value_exponent[1:0] = 2'h0;
		end
	end
	always @(load_s1_recoded_mantissa or when_FpuCore_l594 or load_s1_i2fHigh) begin
		load_s1_output_payload_value_mantissa = {load_s1_recoded_mantissa, 1'b0};
		if (when_FpuCore_l594)
			load_s1_output_payload_value_mantissa = {load_s1_i2fHigh, 1'b0};
	end
	always @(load_s1_recoded_special or load_s1_input_payload_i2f or load_s1_fsm_i2fZero) begin
		load_s1_output_payload_value_special = load_s1_recoded_special;
		if (load_s1_input_payload_i2f) begin
			load_s1_output_payload_value_special = 1'b0;
			if (load_s1_fsm_i2fZero)
				load_s1_output_payload_value_special = 1'b1;
		end
	end
	always @(load_s1_input_payload_i2f or load_s1_scrap) begin
		load_s1_output_payload_scrap = 1'b0;
		if (load_s1_input_payload_i2f)
			load_s1_output_payload_scrap = load_s1_scrap;
	end
	always @(shortPip_input_ready or when_Stream_l368_4) begin
		decode_shortPip_ready = shortPip_input_ready;
		if (when_Stream_l368_4)
			decode_shortPip_ready = 1'b1;
	end
	always @(shortPip_input_payload_opcode or shortPip_recodedResult or shortPip_f2i_result or shortPip_cmpResult or shortPip_fclassResult) begin
		shortPip_result = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		case (shortPip_input_payload_opcode)
			FpuOpcode_STORE: shortPip_result = shortPip_recodedResult;
			FpuOpcode_FMV_X_W: shortPip_result = shortPip_recodedResult;
			FpuOpcode_F2I: shortPip_result[31:0] = shortPip_f2i_result;
			FpuOpcode_CMP: shortPip_result[31:0] = {31'h00000000, shortPip_cmpResult};
			FpuOpcode_FCLASS: shortPip_result[31:0] = shortPip_fclassResult;
			default:
				;
		endcase
	end
	always @(when_FpuCore_l658) begin
		shortPip_halt = 1'b0;
		if (when_FpuCore_l658)
			shortPip_halt = 1'b1;
	end
	always @(when_FpuCore_l31_1 or shortPip_input_payload_rs1_sign or shortPip_f64_exp or shortPip_f64_man or shortPip_f32_exp or shortPip_f32_man or shortPip_isSubnormal or shortPip_fsm_shift_output or when_FpuCore_l31_2 or shortPip_mantissaForced or shortPip_mantissaForcedValue or when_FpuCore_l31_3 or shortPip_exponentForced or when_FpuCore_l31_4 or shortPip_exponentForcedValue or shortPip_cononicalForced or when_FpuCore_l31_5) begin
		if (when_FpuCore_l31_1)
			shortPip_recodedResult = {shortPip_input_payload_rs1_sign, shortPip_f64_exp, shortPip_f64_man};
		else
			shortPip_recodedResult = {32'hffffffff, shortPip_input_payload_rs1_sign, shortPip_f32_exp, shortPip_f32_man};
		if (shortPip_isSubnormal) begin
			shortPip_recodedResult[22:0] = shortPip_fsm_shift_output[22:0];
			if (when_FpuCore_l31_2)
				shortPip_recodedResult[51:23] = shortPip_fsm_shift_output[51:23];
		end
		if (shortPip_mantissaForced) begin
			shortPip_recodedResult[22:0] = (shortPip_mantissaForcedValue ? 23'h7fffff : 23'h000000);
			if (when_FpuCore_l31_3)
				shortPip_recodedResult[51:23] = (shortPip_mantissaForcedValue ? 29'h1fffffff : 29'h00000000);
		end
		if (shortPip_exponentForced) begin
			if (when_FpuCore_l31_4)
				shortPip_recodedResult[62:52] = (shortPip_exponentForcedValue ? 11'h7ff : 11'h000);
			else
				shortPip_recodedResult[30:23] = (shortPip_exponentForcedValue ? 8'hff : 8'h00);
		end
		if (shortPip_cononicalForced) begin
			if (when_FpuCore_l31_5) begin
				shortPip_recodedResult[63] = 1'b0;
				shortPip_recodedResult[51] = 1'b1;
			end
			else begin
				shortPip_recodedResult[31] = 1'b0;
				shortPip_recodedResult[22] = 1'b1;
			end
		end
	end
	always @(shortPip_fsm_isZero or shortPip_input_payload_rs1_mantissa) begin
		shortPip_fsm_shift_input = 53'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		shortPip_fsm_shift_input = {!shortPip_fsm_isZero, shortPip_input_payload_rs1_mantissa};
	end
	always @(shortPip_input_payload_rs1_special or switch_FpuCore_l686 or when_FpuCore_l702) begin
		shortPip_mantissaForced = 1'b0;
		if (shortPip_input_payload_rs1_special)
			case (switch_FpuCore_l686)
				2'h0: shortPip_mantissaForced = 1'b1;
				2'h1: shortPip_mantissaForced = 1'b1;
				2'h2:
					if (when_FpuCore_l702)
						shortPip_mantissaForced = 1'b1;
				default:
					;
			endcase
	end
	always @(shortPip_input_payload_rs1_special or switch_FpuCore_l686 or shortPip_isSubnormal) begin
		shortPip_exponentForced = 1'b0;
		if (shortPip_input_payload_rs1_special)
			case (switch_FpuCore_l686)
				2'h0: shortPip_exponentForced = 1'b1;
				2'h1: shortPip_exponentForced = 1'b1;
				2'h2: shortPip_exponentForced = 1'b1;
				default:
					;
			endcase
		if (shortPip_isSubnormal)
			shortPip_exponentForced = 1'b1;
	end
	always @(shortPip_input_payload_rs1_special or switch_FpuCore_l686 or when_FpuCore_l702) begin
		shortPip_mantissaForcedValue = 1'bx;
		if (shortPip_input_payload_rs1_special)
			case (switch_FpuCore_l686)
				2'h0: shortPip_mantissaForcedValue = 1'b0;
				2'h1: shortPip_mantissaForcedValue = 1'b0;
				2'h2:
					if (when_FpuCore_l702)
						shortPip_mantissaForcedValue = 1'b0;
				default:
					;
			endcase
	end
	always @(shortPip_input_payload_rs1_special or switch_FpuCore_l686 or shortPip_isSubnormal) begin
		shortPip_exponentForcedValue = 1'bx;
		if (shortPip_input_payload_rs1_special)
			case (switch_FpuCore_l686)
				2'h0: shortPip_exponentForcedValue = 1'b0;
				2'h1: shortPip_exponentForcedValue = 1'b1;
				2'h2: shortPip_exponentForcedValue = 1'b1;
				default:
					;
			endcase
		if (shortPip_isSubnormal)
			shortPip_exponentForcedValue = 1'b0;
	end
	always @(shortPip_input_payload_rs1_special or switch_FpuCore_l686 or when_FpuCore_l702) begin
		shortPip_cononicalForced = 1'b0;
		if (shortPip_input_payload_rs1_special)
			case (switch_FpuCore_l686)
				2'h2:
					if (when_FpuCore_l702)
						shortPip_cononicalForced = 1'b1;
				default:
					;
			endcase
	end
	always @(shortPip_f2i_isZero or when_FpuCore_l767 or shortPip_input_valid or shortPip_input_payload_opcode or shortPip_fsm_done or shortPip_NV) begin
		shortPip_rspNv = 1'b0;
		if (!shortPip_f2i_isZero) begin
			if (when_FpuCore_l767)
				shortPip_rspNv = ((shortPip_input_valid && (shortPip_input_payload_opcode == FpuOpcode_F2I)) && shortPip_fsm_done) && !shortPip_f2i_isZero;
		end
		if (shortPip_NV)
			shortPip_rspNv = 1'b1;
	end
	always @(shortPip_f2i_isZero or when_FpuCore_l767 or shortPip_input_valid or shortPip_input_payload_opcode or shortPip_fsm_done or shortPip_f2i_round) begin
		shortPip_rspNx = 1'b0;
		if (!shortPip_f2i_isZero) begin
			if (!when_FpuCore_l767)
				shortPip_rspNx = ((shortPip_input_valid && (shortPip_input_payload_opcode == FpuOpcode_F2I)) && shortPip_fsm_done) && (shortPip_f2i_round != 2'h0);
		end
	end
	always @(shortPip_input_payload_roundMode or shortPip_f2i_round or shortPip_f2i_unsigned or shortPip_input_payload_rs1_sign)
		case (shortPip_input_payload_roundMode)
			FpuRoundMode_RNE: shortPip_f2i_increment = shortPip_f2i_round[1] && (shortPip_f2i_round[0] || shortPip_f2i_unsigned[0]);
			FpuRoundMode_RTZ: shortPip_f2i_increment = 1'b0;
			FpuRoundMode_RDN: shortPip_f2i_increment = (shortPip_f2i_round != 2'h0) && shortPip_input_payload_rs1_sign;
			FpuRoundMode_RUP: shortPip_f2i_increment = (shortPip_f2i_round != 2'h0) && !shortPip_input_payload_rs1_sign;
			default: shortPip_f2i_increment = shortPip_f2i_round[1];
		endcase
	always @(shortPip_f2i_resign or shortPip_f2i_unsigned or _zz_shortPip_f2i_result or shortPip_f2i_isZero or when_FpuCore_l767 or shortPip_f2i_overflow or shortPip_input_payload_arg) begin
		shortPip_f2i_result = (shortPip_f2i_resign ? ~shortPip_f2i_unsigned : shortPip_f2i_unsigned) + _zz_shortPip_f2i_result;
		if (shortPip_f2i_isZero)
			shortPip_f2i_result = 32'h00000000;
		else if (when_FpuCore_l767) begin
			shortPip_f2i_result = (shortPip_f2i_overflow ? 32'hffffffff : 32'h00000000);
			shortPip_f2i_result[31] = shortPip_input_payload_arg[0] ^ shortPip_f2i_overflow;
		end
	end
	always @(shortPip_input_payload_arg or shortPip_input_payload_rs1_exponent or shortPip_input_payload_rs1_special or shortPip_input_payload_rs1_sign or when_FpuCore_l763) begin
		shortPip_f2i_overflow = ((((shortPip_input_payload_arg[0] ? 12'h81d : 12'h81e) < shortPip_input_payload_rs1_exponent) || (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1:0] == 2'h1))) && !shortPip_input_payload_rs1_sign) || (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1:0] == 2'h2));
		if (when_FpuCore_l763)
			shortPip_f2i_overflow = 1'b1;
	end
	always @(shortPip_input_payload_rs1_mantissa or shortPip_input_payload_rs2_mantissa or shortPip_input_payload_rs1_exponent or shortPip_input_payload_rs2_exponent or shortPip_input_payload_rs1_sign or shortPip_input_payload_rs2_sign or shortPip_input_payload_rs1_special or shortPip_input_payload_rs2_special or when_FpuCore_l784) begin
		shortPip_rs1Equal = (((shortPip_input_payload_rs1_mantissa == shortPip_input_payload_rs2_mantissa) && (shortPip_input_payload_rs1_exponent == shortPip_input_payload_rs2_exponent)) && (shortPip_input_payload_rs1_sign == shortPip_input_payload_rs2_sign)) && (shortPip_input_payload_rs1_special == shortPip_input_payload_rs2_special);
		if (when_FpuCore_l784)
			shortPip_rs1Equal = 1'b1;
	end
	always @(shortPip_input_payload_rs1_exponent or shortPip_input_payload_rs1_mantissa or shortPip_input_payload_rs2_exponent or shortPip_input_payload_rs2_mantissa or when_FpuCore_l780 or when_FpuCore_l781 or when_FpuCore_l782 or when_FpuCore_l783) begin
		shortPip_rs1AbsSmaller = {shortPip_input_payload_rs1_exponent, shortPip_input_payload_rs1_mantissa} < {shortPip_input_payload_rs2_exponent, shortPip_input_payload_rs2_mantissa};
		if (when_FpuCore_l780)
			shortPip_rs1AbsSmaller = 1'b1;
		if (when_FpuCore_l781)
			shortPip_rs1AbsSmaller = 1'b1;
		if (when_FpuCore_l782)
			shortPip_rs1AbsSmaller = 1'b0;
		if (when_FpuCore_l783)
			shortPip_rs1AbsSmaller = 1'b0;
	end
	always @(switch_Misc_l226 or shortPip_rs1AbsSmaller or shortPip_rs1Equal)
		case (switch_Misc_l226)
			2'h0: shortPip_rs1Smaller = shortPip_rs1AbsSmaller;
			2'h1: shortPip_rs1Smaller = 1'b0;
			2'h2: shortPip_rs1Smaller = 1'b1;
			default: shortPip_rs1Smaller = !shortPip_rs1AbsSmaller && !shortPip_rs1Equal;
		endcase
	always @(shortPip_rs1Smaller or shortPip_bothZero or shortPip_input_payload_arg or shortPip_rs1Equal or when_FpuCore_l796) begin
		shortPip_cmpResult = ((shortPip_rs1Smaller && !shortPip_bothZero) && !shortPip_input_payload_arg[1]) || ((shortPip_rs1Equal || shortPip_bothZero) && !shortPip_input_payload_arg[0]);
		if (when_FpuCore_l796)
			shortPip_cmpResult = 1'b0;
	end
	always @(shortPip_input_payload_rs2_sign or when_FpuCore_l800) begin
		shortPip_sgnjRs2Sign = shortPip_input_payload_rs2_sign;
		if (when_FpuCore_l800)
			shortPip_sgnjRs2Sign = 1'b1;
	end
	always @(shortPip_input_payload_rs1_sign or shortPip_decoded_isInfinity or shortPip_isNormal or shortPip_isSubnormal or shortPip_decoded_isZero or shortPip_decoded_isNan or shortPip_decoded_isQuiet) begin
		shortPip_fclassResult = 32'h00000000;
		shortPip_fclassResult[0] = shortPip_input_payload_rs1_sign && shortPip_decoded_isInfinity;
		shortPip_fclassResult[1] = shortPip_input_payload_rs1_sign && shortPip_isNormal;
		shortPip_fclassResult[2] = shortPip_input_payload_rs1_sign && shortPip_isSubnormal;
		shortPip_fclassResult[3] = shortPip_input_payload_rs1_sign && shortPip_decoded_isZero;
		shortPip_fclassResult[4] = !shortPip_input_payload_rs1_sign && shortPip_decoded_isZero;
		shortPip_fclassResult[5] = !shortPip_input_payload_rs1_sign && shortPip_isSubnormal;
		shortPip_fclassResult[6] = !shortPip_input_payload_rs1_sign && shortPip_isNormal;
		shortPip_fclassResult[7] = !shortPip_input_payload_rs1_sign && shortPip_decoded_isInfinity;
		shortPip_fclassResult[8] = shortPip_decoded_isNan && !shortPip_decoded_isQuiet;
		shortPip_fclassResult[9] = shortPip_decoded_isNan && shortPip_decoded_isQuiet;
	end
	always @(shortPip_input_payload_format or shortPip_input_payload_opcode or when_FpuCore_l853 or _zz_shortPip_rfOutput_payload_format) begin
		shortPip_rfOutput_payload_format = shortPip_input_payload_format;
		case (shortPip_input_payload_opcode)
			FpuOpcode_SGNJ:
				if (when_FpuCore_l853)
					shortPip_rfOutput_payload_format = FpuFormat_FLOAT;
			FpuOpcode_FCVT_X_X: shortPip_rfOutput_payload_format = _zz_shortPip_rfOutput_payload_format;
			default:
				;
		endcase
	end
	always @(shortPip_input_payload_rs1_sign or shortPip_input_payload_opcode or shortPip_minMaxSelectRs2 or shortPip_input_payload_rs2_sign or when_FpuCore_l850 or shortPip_sgnjResult or when_FpuCore_l853) begin
		shortPip_rfOutput_payload_value_sign = shortPip_input_payload_rs1_sign;
		case (shortPip_input_payload_opcode)
			FpuOpcode_MIN_MAX:
				if (shortPip_minMaxSelectRs2)
					shortPip_rfOutput_payload_value_sign = shortPip_input_payload_rs2_sign;
			FpuOpcode_SGNJ: begin
				if (when_FpuCore_l850)
					shortPip_rfOutput_payload_value_sign = shortPip_sgnjResult;
				if (when_FpuCore_l853)
					shortPip_rfOutput_payload_value_sign = shortPip_input_payload_rs1_sign;
			end
			default:
				;
		endcase
	end
	always @(shortPip_input_payload_rs1_exponent or shortPip_input_payload_opcode or shortPip_minMaxSelectRs2 or shortPip_input_payload_rs2_exponent or shortPip_minMaxSelectNanQuiet or when_FpuCore_l860) begin
		shortPip_rfOutput_payload_value_exponent = shortPip_input_payload_rs1_exponent;
		case (shortPip_input_payload_opcode)
			FpuOpcode_MIN_MAX: begin
				if (shortPip_minMaxSelectRs2)
					shortPip_rfOutput_payload_value_exponent = shortPip_input_payload_rs2_exponent;
				if (shortPip_minMaxSelectNanQuiet) begin
					shortPip_rfOutput_payload_value_exponent[1:0] = 2'h2;
					shortPip_rfOutput_payload_value_exponent[2] = 1'b1;
				end
			end
			FpuOpcode_FCVT_X_X:
				if (when_FpuCore_l860) begin
					shortPip_rfOutput_payload_value_exponent[1:0] = 2'h2;
					shortPip_rfOutput_payload_value_exponent[2] = 1'b1;
				end
			default:
				;
		endcase
	end
	always @(shortPip_input_payload_rs1_mantissa or shortPip_input_payload_opcode or shortPip_minMaxSelectRs2 or shortPip_input_payload_rs2_mantissa or shortPip_minMaxSelectNanQuiet or when_FpuCore_l860) begin
		shortPip_rfOutput_payload_value_mantissa = {shortPip_input_payload_rs1_mantissa, 1'b0};
		case (shortPip_input_payload_opcode)
			FpuOpcode_MIN_MAX: begin
				if (shortPip_minMaxSelectRs2)
					shortPip_rfOutput_payload_value_mantissa = {shortPip_input_payload_rs2_mantissa, 1'b0};
				if (shortPip_minMaxSelectNanQuiet)
					shortPip_rfOutput_payload_value_mantissa[52] = 1'b1;
			end
			FpuOpcode_FCVT_X_X:
				if (when_FpuCore_l860)
					shortPip_rfOutput_payload_value_mantissa[52] = 1'b1;
			default:
				;
		endcase
	end
	always @(shortPip_input_payload_rs1_special or shortPip_input_payload_opcode or shortPip_minMaxSelectRs2 or shortPip_input_payload_rs2_special or shortPip_minMaxSelectNanQuiet or when_FpuCore_l860) begin
		shortPip_rfOutput_payload_value_special = shortPip_input_payload_rs1_special;
		case (shortPip_input_payload_opcode)
			FpuOpcode_MIN_MAX: begin
				if (shortPip_minMaxSelectRs2)
					shortPip_rfOutput_payload_value_special = shortPip_input_payload_rs2_special;
				if (shortPip_minMaxSelectNanQuiet)
					shortPip_rfOutput_payload_value_special = 1'b1;
			end
			FpuOpcode_FCVT_X_X:
				if (when_FpuCore_l860)
					shortPip_rfOutput_payload_value_special = 1'b1;
			default:
				;
		endcase
	end
	always @(shortPip_rspStreams_0_m2sPipe_ready or when_Stream_l368_5) begin
		shortPip_rspStreams_0_ready = shortPip_rspStreams_0_m2sPipe_ready;
		if (when_Stream_l368_5)
			shortPip_rspStreams_0_ready = 1'b1;
	end
	always @(mul_preMul_input_ready or when_Stream_l368_6) begin
		decode_mul_ready = mul_preMul_input_ready;
		if (when_Stream_l368_6)
			decode_mul_ready = 1'b1;
	end
	always @(mul_mul_input_ready or when_Stream_l368_7) begin
		mul_preMul_output_ready = mul_mul_input_ready;
		if (when_Stream_l368_7)
			mul_preMul_output_ready = 1'b1;
	end
	always @(mul_sum1_input_ready or when_Stream_l368_8) begin
		mul_mul_output_ready = mul_sum1_input_ready;
		if (when_Stream_l368_8)
			mul_mul_output_ready = 1'b1;
	end
	always @(mul_sum2_input_ready or when_Stream_l368_9) begin
		mul_sum1_output_ready = mul_sum2_input_ready;
		if (when_Stream_l368_9)
			mul_sum1_output_ready = 1'b1;
	end
	always @(mul_norm_input_ready or when_Stream_l368_10) begin
		mul_sum2_output_ready = mul_norm_input_ready;
		if (when_Stream_l368_10)
			mul_sum2_output_ready = 1'b1;
	end
	always @(mul_norm_mulLow or when_FpuCore_l967) begin
		mul_norm_scrap = mul_norm_mulLow != 51'h0000000000000;
		if (when_FpuCore_l967)
			mul_norm_scrap = 1'b1;
	end
	always @(_zz_mul_norm_output_exponent or when_FpuCore_l983 or mul_norm_forceNan or mul_norm_forceOverflow or mul_norm_forceZero or mul_norm_forceUnderflow or mul_norm_underflowExp) begin
		mul_norm_output_exponent = _zz_mul_norm_output_exponent[11:0];
		if (when_FpuCore_l983)
			mul_norm_output_exponent[11:10] = 2'h3;
		if (mul_norm_forceNan) begin
			mul_norm_output_exponent[1:0] = 2'h2;
			mul_norm_output_exponent[2] = 1'b1;
		end
		else if (mul_norm_forceOverflow)
			mul_norm_output_exponent[1:0] = 2'h1;
		else if (mul_norm_forceZero)
			mul_norm_output_exponent[1:0] = 2'h0;
		else if (mul_norm_forceUnderflow)
			mul_norm_output_exponent = {1'b0, mul_norm_underflowExp};
	end
	always @(mul_norm_man or mul_norm_forceNan) begin
		mul_norm_output_mantissa = mul_norm_man;
		if (mul_norm_forceNan)
			mul_norm_output_mantissa[52] = 1'b1;
	end
	always @(mul_norm_forceNan or mul_norm_forceOverflow or mul_norm_forceZero) begin
		mul_norm_output_special = 1'b0;
		if (mul_norm_forceNan)
			mul_norm_output_special = 1'b1;
		else if (mul_norm_forceOverflow)
			mul_norm_output_special = 1'b1;
		else if (mul_norm_forceZero)
			mul_norm_output_special = 1'b1;
	end
	always @(mul_norm_forceNan or when_FpuCore_l987) begin
		mul_norm_NV = 1'b0;
		if (mul_norm_forceNan) begin
			if (when_FpuCore_l987)
				mul_norm_NV = 1'b1;
		end
	end
	always @(mul_result_mulToAdd_m2sPipe_ready or when_Stream_l368_11) begin
		mul_result_mulToAdd_ready = mul_result_mulToAdd_m2sPipe_ready;
		if (when_Stream_l368_11)
			mul_result_mulToAdd_ready = 1'b1;
	end
	always @(mul_norm_output_mantissa or mul_norm_scrap or mul_norm_NV) begin
		mul_result_mulToAdd_payload_rs1_mantissa = {mul_norm_output_mantissa, mul_norm_scrap};
		if (mul_norm_NV)
			mul_result_mulToAdd_payload_rs1_mantissa[53] = 1'b0;
	end
	always @(div_divider_io_output_valid) begin
		div_haltIt = 1'b1;
		if (div_divider_io_output_valid)
			div_haltIt = 1'b0;
	end
	always @(div_forceNan or div_forceOverflow or div_forceZero) begin
		div_output_payload_value_special = 1'b0;
		if (div_forceNan)
			div_output_payload_value_special = 1'b1;
		else if (div_forceOverflow)
			div_output_payload_value_special = 1'b1;
		else if (div_forceZero)
			div_output_payload_value_special = 1'b1;
	end
	always @(div_exponent or when_FpuCore_l1072 or when_FpuCore_l1089 or div_forceNan or div_forceOverflow or div_forceZero or div_forceUnderflow or div_underflowExp) begin
		div_output_payload_value_exponent = div_exponent[11:0];
		if (when_FpuCore_l1072)
			div_output_payload_value_exponent[11:9] = 3'h7;
		if (when_FpuCore_l1089)
			div_output_payload_value_exponent[11:10] = 2'h3;
		if (div_forceNan) begin
			div_output_payload_value_exponent[1:0] = 2'h2;
			div_output_payload_value_exponent[2] = 1'b1;
		end
		else if (div_forceOverflow)
			div_output_payload_value_exponent[1:0] = 2'h1;
		else if (div_forceZero)
			div_output_payload_value_exponent[1:0] = 2'h0;
		else if (div_forceUnderflow)
			div_output_payload_value_exponent = div_underflowExp[11:0];
	end
	always @(div_mantissa or div_forceNan) begin
		div_output_payload_value_mantissa = div_mantissa;
		if (div_forceNan)
			div_output_payload_value_mantissa[52] = 1'b1;
	end
	always @(div_forceNan or when_FpuCore_l1093) begin
		div_output_payload_NV = 1'b0;
		if (div_forceNan) begin
			if (when_FpuCore_l1093)
				div_output_payload_NV = 1'b1;
		end
	end
	always @(sqrt_sqrt_io_output_valid) begin
		sqrt_haltIt = 1'b1;
		if (sqrt_sqrt_io_output_valid)
			sqrt_haltIt = 1'b0;
	end
	always @(when_FpuCore_l1137 or sqrt_negative or when_FpuCore_l1144 or when_FpuCore_l1148) begin
		sqrt_output_payload_value_special = 1'b0;
		if (when_FpuCore_l1137)
			sqrt_output_payload_value_special = 1'b1;
		if (sqrt_negative)
			sqrt_output_payload_value_special = 1'b1;
		if (when_FpuCore_l1144)
			sqrt_output_payload_value_special = 1'b1;
		if (when_FpuCore_l1148)
			sqrt_output_payload_value_special = 1'b1;
	end
	always @(sqrt_exponent or when_FpuCore_l1137 or sqrt_negative or when_FpuCore_l1144 or when_FpuCore_l1148) begin
		sqrt_output_payload_value_exponent = sqrt_exponent;
		if (when_FpuCore_l1137)
			sqrt_output_payload_value_exponent[1:0] = 2'h1;
		if (sqrt_negative) begin
			sqrt_output_payload_value_exponent[1:0] = 2'h2;
			sqrt_output_payload_value_exponent[2] = 1'b1;
		end
		if (when_FpuCore_l1144) begin
			sqrt_output_payload_value_exponent[1:0] = 2'h2;
			sqrt_output_payload_value_exponent[2] = 1'b1;
		end
		if (when_FpuCore_l1148)
			sqrt_output_payload_value_exponent[1:0] = 2'h0;
	end
	always @(sqrt_sqrt_io_output_payload_result or sqrt_negative or when_FpuCore_l1144) begin
		sqrt_output_payload_value_mantissa = sqrt_sqrt_io_output_payload_result;
		if (sqrt_negative)
			sqrt_output_payload_value_mantissa[52] = 1'b1;
		if (when_FpuCore_l1144)
			sqrt_output_payload_value_mantissa[52] = 1'b1;
	end
	always @(sqrt_negative or when_FpuCore_l1144 or sqrt_input_payload_rs1_mantissa) begin
		sqrt_output_payload_NV = 1'b0;
		if (sqrt_negative)
			sqrt_output_payload_NV = 1'b1;
		if (when_FpuCore_l1144)
			sqrt_output_payload_NV = !sqrt_input_payload_rs1_mantissa[51];
	end
	always @(add_shifter_input_ready or when_Stream_l368_12) begin
		add_preShifter_output_ready = add_shifter_input_ready;
		if (when_Stream_l368_12)
			add_preShifter_output_ready = 1'b1;
	end
	always @(when_FpuCore_l1419 or when_FpuCore_l1419_1 or when_FpuCore_l1419_2 or when_FpuCore_l1419_3 or when_FpuCore_l1419_4 or when_FpuCore_l1419_5 or add_shifter_shiftOverflow or when_FpuCore_l1424) begin
		add_shifter_roundingScrap = 1'b0;
		if (when_FpuCore_l1419)
			add_shifter_roundingScrap = 1'b1;
		if (when_FpuCore_l1419_1)
			add_shifter_roundingScrap = 1'b1;
		if (when_FpuCore_l1419_2)
			add_shifter_roundingScrap = 1'b1;
		if (when_FpuCore_l1419_3)
			add_shifter_roundingScrap = 1'b1;
		if (when_FpuCore_l1419_4)
			add_shifter_roundingScrap = 1'b1;
		if (when_FpuCore_l1419_5)
			add_shifter_roundingScrap = 1'b1;
		if (add_shifter_shiftOverflow)
			add_shifter_roundingScrap = 1'b1;
		if (when_FpuCore_l1424)
			add_shifter_roundingScrap = 1'b0;
	end
	always @(add_math_input_ready or when_Stream_l368_13) begin
		add_shifter_output_ready = add_math_input_ready;
		if (when_Stream_l368_13)
			add_shifter_output_ready = 1'b1;
	end
	always @(add_oh_input_ready or when_Stream_l368_14) begin
		add_math_output_ready = add_oh_input_ready;
		if (when_Stream_l368_14)
			add_math_output_ready = 1'b1;
	end
	always @(add_norm_input_ready or when_Stream_l368_15) begin
		add_oh_output_ready = add_norm_input_ready;
		if (when_Stream_l368_15)
			add_oh_output_ready = 1'b1;
	end
	always @(add_result_input_payload_xySign or add_result_input_payload_forceNan or add_result_input_payload_forceInfinity or add_result_input_payload_forceZero or when_FpuCore_l1513 or add_result_input_payload_rs1_sign or add_result_input_payload_rs2_sign or when_FpuCore_l1516) begin
		add_result_output_payload_value_sign = add_result_input_payload_xySign;
		if (!add_result_input_payload_forceNan) begin
			if (!add_result_input_payload_forceInfinity) begin
				if (add_result_input_payload_forceZero) begin
					if (when_FpuCore_l1513)
						add_result_output_payload_value_sign = add_result_input_payload_rs1_sign && add_result_input_payload_rs2_sign;
					if (when_FpuCore_l1516)
						add_result_output_payload_value_sign = 1'b1;
				end
			end
		end
	end
	always @(_zz_add_result_output_payload_value_mantissa or add_result_input_payload_forceNan) begin
		add_result_output_payload_value_mantissa = _zz_add_result_output_payload_value_mantissa[52:0];
		if (add_result_input_payload_forceNan)
			add_result_output_payload_value_mantissa[52] = 1'b1;
	end
	always @(add_result_input_payload_exponent or add_result_input_payload_forceNan or add_result_input_payload_forceInfinity or add_result_input_payload_forceZero) begin
		add_result_output_payload_value_exponent = add_result_input_payload_exponent[11:0];
		if (add_result_input_payload_forceNan) begin
			add_result_output_payload_value_exponent[1:0] = 2'h2;
			add_result_output_payload_value_exponent[2] = 1'b1;
		end
		else if (add_result_input_payload_forceInfinity)
			add_result_output_payload_value_exponent[1:0] = 2'h1;
		else if (add_result_input_payload_forceZero)
			add_result_output_payload_value_exponent[1:0] = 2'h0;
	end
	always @(add_result_input_payload_forceNan or add_result_input_payload_forceInfinity or add_result_input_payload_forceZero) begin
		add_result_output_payload_value_special = 1'b0;
		if (add_result_input_payload_forceNan)
			add_result_output_payload_value_special = 1'b1;
		else if (add_result_input_payload_forceInfinity)
			add_result_output_payload_value_special = 1'b1;
		else if (add_result_input_payload_forceZero)
			add_result_output_payload_value_special = 1'b1;
	end
	always @(load_s1_output_m2sPipe_ready or when_Stream_l368_16) begin
		load_s1_output_ready = load_s1_output_m2sPipe_ready;
		if (when_Stream_l368_16)
			load_s1_output_ready = 1'b1;
	end
	always @(shortPip_output_m2sPipe_ready or when_Stream_l368_17) begin
		shortPip_output_ready = shortPip_output_m2sPipe_ready;
		if (when_Stream_l368_17)
			shortPip_output_ready = 1'b1;
	end
	always @(roundFront_input_payload_roundMode or roundFront_roundAdjusted or roundFront_discardCount_1 or _zz__zz_roundFront_mantissaIncrement or roundFront_input_payload_value_sign)
		case (roundFront_input_payload_roundMode)
			FpuRoundMode_RNE: _zz_roundFront_mantissaIncrement = roundFront_roundAdjusted[1] && (roundFront_roundAdjusted[0] || _zz__zz_roundFront_mantissaIncrement[roundFront_discardCount_1]);
			FpuRoundMode_RTZ: _zz_roundFront_mantissaIncrement = 1'b0;
			FpuRoundMode_RDN: _zz_roundFront_mantissaIncrement = (roundFront_roundAdjusted != 2'h0) && roundFront_input_payload_value_sign;
			FpuRoundMode_RUP: _zz_roundFront_mantissaIncrement = (roundFront_roundAdjusted != 2'h0) && !roundFront_input_payload_value_sign;
			default: _zz_roundFront_mantissaIncrement = roundFront_roundAdjusted[1];
		endcase
	always @(roundBack_math_mantissa or when_FpuCore_l1612 or when_FpuCore_l1622 or when_FpuCore_l1631 or when_FpuCore_l1641) begin
		roundBack_patched_mantissa = roundBack_math_mantissa;
		if (when_FpuCore_l1612) begin
			if (when_FpuCore_l1622)
				roundBack_patched_mantissa = 52'hfffffffffffff;
		end
		if (when_FpuCore_l1631) begin
			if (when_FpuCore_l1641)
				roundBack_patched_mantissa = 52'h0000000000000;
		end
	end
	always @(roundBack_math_exponent or when_FpuCore_l1612 or when_FpuCore_l1622 or roundBack_ofThreshold or when_FpuCore_l1631 or when_FpuCore_l1641 or roundBack_ufThreshold) begin
		roundBack_patched_exponent = roundBack_math_exponent;
		if (when_FpuCore_l1612) begin
			if (when_FpuCore_l1622)
				roundBack_patched_exponent = roundBack_ofThreshold;
			else
				roundBack_patched_exponent[1:0] = 2'h1;
		end
		if (when_FpuCore_l1631) begin
			if (when_FpuCore_l1641)
				roundBack_patched_exponent = {1'b0, roundBack_ufThreshold};
			else
				roundBack_patched_exponent[1:0] = 2'h0;
		end
	end
	always @(roundBack_math_special or when_FpuCore_l1612 or when_FpuCore_l1622 or when_FpuCore_l1631 or when_FpuCore_l1641) begin
		roundBack_patched_special = roundBack_math_special;
		if (when_FpuCore_l1612) begin
			if (!when_FpuCore_l1622)
				roundBack_patched_special = 1'b1;
		end
		if (when_FpuCore_l1631) begin
			if (!when_FpuCore_l1641)
				roundBack_patched_special = 1'b1;
		end
	end
	always @(when_FpuCore_l1612 or when_FpuCore_l1631 or when_FpuCore_l1650) begin
		roundBack_nx = 1'b0;
		if (when_FpuCore_l1612)
			roundBack_nx = 1'b1;
		if (when_FpuCore_l1631)
			roundBack_nx = 1'b1;
		if (when_FpuCore_l1650)
			roundBack_nx = 1'b1;
	end
	always @(when_FpuCore_l1612) begin
		roundBack_of = 1'b0;
		if (when_FpuCore_l1612)
			roundBack_of = 1'b1;
	end
	always @(when_FpuCore_l1609 or when_FpuCore_l1631) begin
		roundBack_uf = 1'b0;
		if (when_FpuCore_l1609)
			roundBack_uf = 1'b1;
		if (when_FpuCore_l1631)
			roundBack_uf = 1'b1;
	end
	always @(roundBack_input_payload_roundMode or roundBack_input_payload_value_sign)
		case (roundBack_input_payload_roundMode)
			FpuRoundMode_RNE: roundBack_threshold = 3'h6;
			FpuRoundMode_RTZ: roundBack_threshold = 3'h6;
			FpuRoundMode_RDN: roundBack_threshold = (roundBack_input_payload_value_sign ? 3'h5 : 3'h7);
			FpuRoundMode_RUP: roundBack_threshold = (roundBack_input_payload_value_sign ? 3'h7 : 3'h5);
			default: roundBack_threshold = 3'h6;
		endcase
	always @(roundBack_input_payload_value_mantissa or roundBack_input_payload_scrap or when_FpuCore_l1606) begin
		roundBack_borringRound = {roundBack_input_payload_value_mantissa[1:0], roundBack_input_payload_scrap};
		if (when_FpuCore_l1606)
			roundBack_borringRound = {roundBack_input_payload_value_mantissa[30:29], |roundBack_input_payload_value_mantissa[28:0]};
	end
	always @(roundBack_input_payload_roundMode or roundBack_math_sign)
		case (roundBack_input_payload_roundMode)
			FpuRoundMode_RNE: when_FpuCore_l1622 = 1'b0;
			FpuRoundMode_RTZ: when_FpuCore_l1622 = 1'b1;
			FpuRoundMode_RDN: when_FpuCore_l1622 = !roundBack_math_sign;
			FpuRoundMode_RUP: when_FpuCore_l1622 = roundBack_math_sign;
			default: when_FpuCore_l1622 = 1'b0;
		endcase
	always @(roundBack_input_payload_roundMode or roundBack_math_sign)
		case (roundBack_input_payload_roundMode)
			FpuRoundMode_RNE: when_FpuCore_l1641 = 1'b0;
			FpuRoundMode_RTZ: when_FpuCore_l1641 = 1'b0;
			FpuRoundMode_RDN: when_FpuCore_l1641 = roundBack_math_sign;
			FpuRoundMode_RUP: when_FpuCore_l1641 = !roundBack_math_sign;
			default: when_FpuCore_l1641 = 1'b0;
		endcase
	always @(writeback_input_payload_value_mantissa or writeback_port_payload_data_boxed) begin
		writeback_port_payload_data_value_mantissa = writeback_input_payload_value_mantissa;
		if (writeback_port_payload_data_boxed)
			writeback_port_payload_data_value_mantissa[28:0] = 29'h00000000;
	end
	always @(posedge reset or posedge clk)
		if (reset) begin
			rf_init_counter <= 6'h00;
			FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid <= 1'b0;
			commitLogic_0_pending_counter <= 4'h0;
			commitLogic_0_add_counter <= 4'h0;
			commitLogic_0_mul_counter <= 4'h0;
			commitLogic_0_div_counter <= 4'h0;
			commitLogic_0_sqrt_counter <= 4'h0;
			commitLogic_0_short_counter <= 4'h0;
			io_port_0_cmd_rValid <= 1'b0;
			read_s0_rValid <= 1'b0;
			decode_load_rValid <= 1'b0;
			decode_load_s2mPipe_rValid <= 1'b0;
			decode_load_s2mPipe_m2sPipe_rValid <= 1'b0;
			load_s0_output_rValid <= 1'b0;
			decode_shortPip_rValid <= 1'b0;
			shortPip_rspStreams_0_rValid <= 1'b0;
			decode_mul_rValid <= 1'b0;
			mul_preMul_output_rValid <= 1'b0;
			mul_mul_output_rValid <= 1'b0;
			mul_sum1_output_rValid <= 1'b0;
			mul_sum2_output_rValid <= 1'b0;
			mul_result_mulToAdd_rValid <= 1'b0;
			decode_div_rValid <= 1'b0;
			div_cmdSent <= 1'b0;
			decode_sqrt_rValid <= 1'b0;
			sqrt_cmdSent <= 1'b0;
			add_preShifter_output_rValid <= 1'b0;
			add_shifter_output_rValid <= 1'b0;
			add_math_output_rValid <= 1'b0;
			add_oh_output_rValid <= 1'b0;
			load_s1_output_rValid <= 1'b0;
			shortPip_output_rValid <= 1'b0;
			roundFront_input_valid <= 1'b0;
			roundBack_input_valid <= 1'b0;
			writeback_input_valid <= 1'b0;
		end
		else begin
			if (when_FpuCore_l163)
				rf_init_counter <= rf_init_counter + 6'h01;
			if (streamFork_1_io_outputs_1_valid)
				FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid <= 1'b1;
			if (FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_ready)
				FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid <= 1'b0;
			commitLogic_0_pending_counter <= _zz_commitLogic_0_pending_counter - _zz_commitLogic_0_pending_counter_3;
			commitLogic_0_add_counter <= _zz_commitLogic_0_add_counter - _zz_commitLogic_0_add_counter_3;
			commitLogic_0_mul_counter <= _zz_commitLogic_0_mul_counter - _zz_commitLogic_0_mul_counter_3;
			commitLogic_0_div_counter <= _zz_commitLogic_0_div_counter - _zz_commitLogic_0_div_counter_3;
			commitLogic_0_sqrt_counter <= _zz_commitLogic_0_sqrt_counter - _zz_commitLogic_0_sqrt_counter_3;
			commitLogic_0_short_counter <= _zz_commitLogic_0_short_counter - _zz_commitLogic_0_short_counter_3;
			if (io_port_0_cmd_valid)
				io_port_0_cmd_rValid <= 1'b1;
			if (scheduler_0_input_ready)
				io_port_0_cmd_rValid <= 1'b0;
			if (read_s0_ready)
				read_s0_rValid <= read_s0_valid;
			if (decode_load_valid)
				decode_load_rValid <= 1'b1;
			if (decode_load_s2mPipe_ready)
				decode_load_rValid <= 1'b0;
			if (decode_load_s2mPipe_ready)
				decode_load_s2mPipe_rValid <= decode_load_s2mPipe_valid;
			if (decode_load_s2mPipe_m2sPipe_ready)
				decode_load_s2mPipe_m2sPipe_rValid <= decode_load_s2mPipe_m2sPipe_valid;
			if (load_s0_output_ready)
				load_s0_output_rValid <= load_s0_output_valid;
			if (decode_shortPip_ready)
				decode_shortPip_rValid <= decode_shortPip_valid;
			if (shortPip_rspStreams_0_ready)
				shortPip_rspStreams_0_rValid <= shortPip_rspStreams_0_valid;
			if (decode_mul_ready)
				decode_mul_rValid <= decode_mul_valid;
			if (mul_preMul_output_ready)
				mul_preMul_output_rValid <= mul_preMul_output_valid;
			if (mul_mul_output_ready)
				mul_mul_output_rValid <= mul_mul_output_valid;
			if (mul_sum1_output_ready)
				mul_sum1_output_rValid <= mul_sum1_output_valid;
			if (mul_sum2_output_ready)
				mul_sum2_output_rValid <= mul_sum2_output_valid;
			if (mul_result_mulToAdd_ready)
				mul_result_mulToAdd_rValid <= mul_result_mulToAdd_valid;
			if (decode_div_valid)
				decode_div_rValid <= 1'b1;
			if (div_input_fire)
				decode_div_rValid <= 1'b0;
			if (FpuPlugin_fpu_div_divider_io_input_fire)
				div_cmdSent <= 1'b1;
			if (when_FpuCore_l1056)
				div_cmdSent <= 1'b0;
			if (decode_sqrt_valid)
				decode_sqrt_rValid <= 1'b1;
			if (sqrt_input_fire)
				decode_sqrt_rValid <= 1'b0;
			if (FpuPlugin_fpu_sqrt_sqrt_io_input_fire)
				sqrt_cmdSent <= 1'b1;
			if (when_FpuCore_l1118)
				sqrt_cmdSent <= 1'b0;
			if (add_preShifter_output_ready)
				add_preShifter_output_rValid <= add_preShifter_output_valid;
			if (add_shifter_output_ready)
				add_shifter_output_rValid <= add_shifter_output_valid;
			if (add_math_output_ready)
				add_math_output_rValid <= add_math_output_valid;
			if (add_oh_output_ready)
				add_oh_output_rValid <= add_oh_output_valid;
			if (load_s1_output_ready)
				load_s1_output_rValid <= load_s1_output_valid;
			if (shortPip_output_ready)
				shortPip_output_rValid <= shortPip_output_valid;
			roundFront_input_valid <= merge_arbitrated_valid;
			roundBack_input_valid <= roundFront_output_valid;
			writeback_input_valid <= roundBack_output_valid;
			if (writeback_port_valid)
				;
		end
	always @(posedge clk) begin
		if (streamFork_1_io_outputs_1_ready) begin
			FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode <= streamFork_1_io_outputs_1_payload_opcode;
			FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_rd <= streamFork_1_io_outputs_1_payload_rd;
			FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_write <= streamFork_1_io_outputs_1_payload_write;
			FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_value <= streamFork_1_io_outputs_1_payload_value;
		end
		if (io_port_0_cmd_ready) begin
			io_port_0_cmd_rData_opcode <= io_port_0_cmd_payload_opcode;
			io_port_0_cmd_rData_arg <= io_port_0_cmd_payload_arg;
			io_port_0_cmd_rData_rs1 <= io_port_0_cmd_payload_rs1;
			io_port_0_cmd_rData_rs2 <= io_port_0_cmd_payload_rs2;
			io_port_0_cmd_rData_rs3 <= io_port_0_cmd_payload_rs3;
			io_port_0_cmd_rData_rd <= io_port_0_cmd_payload_rd;
			io_port_0_cmd_rData_format <= io_port_0_cmd_payload_format;
			io_port_0_cmd_rData_roundMode <= io_port_0_cmd_payload_roundMode;
		end
		if (read_s0_ready) begin
			read_s0_rData_opcode <= read_s0_payload_opcode;
			read_s0_rData_rs1 <= read_s0_payload_rs1;
			read_s0_rData_rs2 <= read_s0_payload_rs2;
			read_s0_rData_rs3 <= read_s0_payload_rs3;
			read_s0_rData_rd <= read_s0_payload_rd;
			read_s0_rData_arg <= read_s0_payload_arg;
			read_s0_rData_roundMode <= read_s0_payload_roundMode;
			read_s0_rData_format <= read_s0_payload_format;
		end
		if (decode_load_ready) begin
			decode_load_rData_rd <= decode_load_payload_rd;
			decode_load_rData_i2f <= decode_load_payload_i2f;
			decode_load_rData_arg <= decode_load_payload_arg;
			decode_load_rData_roundMode <= decode_load_payload_roundMode;
			decode_load_rData_format <= decode_load_payload_format;
		end
		if (decode_load_s2mPipe_ready) begin
			decode_load_s2mPipe_rData_rd <= decode_load_s2mPipe_payload_rd;
			decode_load_s2mPipe_rData_i2f <= decode_load_s2mPipe_payload_i2f;
			decode_load_s2mPipe_rData_arg <= decode_load_s2mPipe_payload_arg;
			decode_load_s2mPipe_rData_roundMode <= decode_load_s2mPipe_payload_roundMode;
			decode_load_s2mPipe_rData_format <= decode_load_s2mPipe_payload_format;
		end
		if (decode_load_s2mPipe_m2sPipe_ready) begin
			decode_load_s2mPipe_m2sPipe_rData_rd <= decode_load_s2mPipe_m2sPipe_payload_rd;
			decode_load_s2mPipe_m2sPipe_rData_i2f <= decode_load_s2mPipe_m2sPipe_payload_i2f;
			decode_load_s2mPipe_m2sPipe_rData_arg <= decode_load_s2mPipe_m2sPipe_payload_arg;
			decode_load_s2mPipe_m2sPipe_rData_roundMode <= decode_load_s2mPipe_m2sPipe_payload_roundMode;
			decode_load_s2mPipe_m2sPipe_rData_format <= decode_load_s2mPipe_m2sPipe_payload_format;
		end
		if (load_s0_output_ready) begin
			load_s0_output_rData_rd <= load_s0_output_payload_rd;
			load_s0_output_rData_value <= load_s0_output_payload_value;
			load_s0_output_rData_i2f <= load_s0_output_payload_i2f;
			load_s0_output_rData_arg <= load_s0_output_payload_arg;
			load_s0_output_rData_roundMode <= load_s0_output_payload_roundMode;
			load_s0_output_rData_format <= load_s0_output_payload_format;
		end
		if (when_FpuCore_l525)
			load_s1_fsm_shift_output <= load_s1_fsm_shift_input_6;
		if (when_FpuCore_l529) begin
			if (load_s1_fsm_boot) begin
				if (when_FpuCore_l532) begin
					load_s0_output_rData_value[31:0] <= _zz_load_s0_output_rData_value_2;
					load_s1_fsm_patched <= 1'b1;
				end
				else begin
					load_s1_fsm_shift_by <= {_zz_load_s1_fsm_shift_by_52, _zz_load_s1_fsm_shift_by_51, _zz_load_s1_fsm_shift_by_50, _zz_load_s1_fsm_shift_by_49, _zz_load_s1_fsm_shift_by_48, _zz_load_s1_fsm_shift_by_47};
					load_s1_fsm_boot <= 1'b0;
					load_s1_fsm_i2fZero <= load_s1_input_payload_value[31:0] == 32'h00000000;
				end
			end
			else
				load_s1_fsm_done <= 1'b1;
		end
		if (when_FpuCore_l551) begin
			load_s1_fsm_done <= 1'b0;
			load_s1_fsm_boot <= 1'b1;
			load_s1_fsm_patched <= 1'b0;
		end
		if (decode_shortPip_ready) begin
			decode_shortPip_rData_opcode <= decode_shortPip_payload_opcode;
			decode_shortPip_rData_rs1_mantissa <= decode_shortPip_payload_rs1_mantissa;
			decode_shortPip_rData_rs1_exponent <= decode_shortPip_payload_rs1_exponent;
			decode_shortPip_rData_rs1_sign <= decode_shortPip_payload_rs1_sign;
			decode_shortPip_rData_rs1_special <= decode_shortPip_payload_rs1_special;
			decode_shortPip_rData_rs2_mantissa <= decode_shortPip_payload_rs2_mantissa;
			decode_shortPip_rData_rs2_exponent <= decode_shortPip_payload_rs2_exponent;
			decode_shortPip_rData_rs2_sign <= decode_shortPip_payload_rs2_sign;
			decode_shortPip_rData_rs2_special <= decode_shortPip_payload_rs2_special;
			decode_shortPip_rData_rd <= decode_shortPip_payload_rd;
			decode_shortPip_rData_value <= decode_shortPip_payload_value;
			decode_shortPip_rData_arg <= decode_shortPip_payload_arg;
			decode_shortPip_rData_roundMode <= decode_shortPip_payload_roundMode;
			decode_shortPip_rData_format <= decode_shortPip_payload_format;
			decode_shortPip_rData_rs1Boxed <= decode_shortPip_payload_rs1Boxed;
			decode_shortPip_rData_rs2Boxed <= decode_shortPip_payload_rs2Boxed;
		end
		if (when_FpuCore_l646)
			shortPip_fsm_shift_scrap <= 1'b1;
		if (when_FpuCore_l646_1)
			shortPip_fsm_shift_scrap <= 1'b1;
		if (when_FpuCore_l646_2)
			shortPip_fsm_shift_scrap <= 1'b1;
		if (when_FpuCore_l646_3)
			shortPip_fsm_shift_scrap <= 1'b1;
		if (when_FpuCore_l646_4)
			shortPip_fsm_shift_scrap <= 1'b1;
		if (when_FpuCore_l646_5)
			shortPip_fsm_shift_scrap <= 1'b1;
		if (shortPip_fsm_boot)
			shortPip_fsm_shift_scrap <= 1'b0;
		if (when_FpuCore_l652)
			shortPip_fsm_shift_output <= shortPip_fsm_shift_input_6;
		if (when_FpuCore_l658) begin
			if (shortPip_fsm_boot) begin
				if (shortPip_fsm_isF2i)
					shortPip_fsm_shift_by <= _zz_shortPip_fsm_shift_by_2[5:0];
				else
					shortPip_fsm_shift_by <= _zz_shortPip_fsm_shift_by_5[5:0];
				shortPip_fsm_boot <= 1'b0;
			end
			else
				shortPip_fsm_done <= 1'b1;
		end
		if (when_FpuCore_l672) begin
			shortPip_fsm_done <= 1'b0;
			shortPip_fsm_boot <= 1'b1;
		end
		if (shortPip_rspStreams_0_ready) begin
			shortPip_rspStreams_0_rData_value <= shortPip_rspStreams_0_payload_value;
			shortPip_rspStreams_0_rData_NV <= shortPip_rspStreams_0_payload_NV;
			shortPip_rspStreams_0_rData_NX <= shortPip_rspStreams_0_payload_NX;
		end
		if (decode_mul_ready) begin
			decode_mul_rData_rs1_mantissa <= decode_mul_payload_rs1_mantissa;
			decode_mul_rData_rs1_exponent <= decode_mul_payload_rs1_exponent;
			decode_mul_rData_rs1_sign <= decode_mul_payload_rs1_sign;
			decode_mul_rData_rs1_special <= decode_mul_payload_rs1_special;
			decode_mul_rData_rs2_mantissa <= decode_mul_payload_rs2_mantissa;
			decode_mul_rData_rs2_exponent <= decode_mul_payload_rs2_exponent;
			decode_mul_rData_rs2_sign <= decode_mul_payload_rs2_sign;
			decode_mul_rData_rs2_special <= decode_mul_payload_rs2_special;
			decode_mul_rData_rs3_mantissa <= decode_mul_payload_rs3_mantissa;
			decode_mul_rData_rs3_exponent <= decode_mul_payload_rs3_exponent;
			decode_mul_rData_rs3_sign <= decode_mul_payload_rs3_sign;
			decode_mul_rData_rs3_special <= decode_mul_payload_rs3_special;
			decode_mul_rData_rd <= decode_mul_payload_rd;
			decode_mul_rData_add <= decode_mul_payload_add;
			decode_mul_rData_divSqrt <= decode_mul_payload_divSqrt;
			decode_mul_rData_msb1 <= decode_mul_payload_msb1;
			decode_mul_rData_msb2 <= decode_mul_payload_msb2;
			decode_mul_rData_roundMode <= decode_mul_payload_roundMode;
			decode_mul_rData_format <= decode_mul_payload_format;
		end
		if (mul_preMul_output_ready) begin
			mul_preMul_output_rData_rs1_mantissa <= mul_preMul_output_payload_rs1_mantissa;
			mul_preMul_output_rData_rs1_exponent <= mul_preMul_output_payload_rs1_exponent;
			mul_preMul_output_rData_rs1_sign <= mul_preMul_output_payload_rs1_sign;
			mul_preMul_output_rData_rs1_special <= mul_preMul_output_payload_rs1_special;
			mul_preMul_output_rData_rs2_mantissa <= mul_preMul_output_payload_rs2_mantissa;
			mul_preMul_output_rData_rs2_exponent <= mul_preMul_output_payload_rs2_exponent;
			mul_preMul_output_rData_rs2_sign <= mul_preMul_output_payload_rs2_sign;
			mul_preMul_output_rData_rs2_special <= mul_preMul_output_payload_rs2_special;
			mul_preMul_output_rData_rs3_mantissa <= mul_preMul_output_payload_rs3_mantissa;
			mul_preMul_output_rData_rs3_exponent <= mul_preMul_output_payload_rs3_exponent;
			mul_preMul_output_rData_rs3_sign <= mul_preMul_output_payload_rs3_sign;
			mul_preMul_output_rData_rs3_special <= mul_preMul_output_payload_rs3_special;
			mul_preMul_output_rData_rd <= mul_preMul_output_payload_rd;
			mul_preMul_output_rData_add <= mul_preMul_output_payload_add;
			mul_preMul_output_rData_divSqrt <= mul_preMul_output_payload_divSqrt;
			mul_preMul_output_rData_msb1 <= mul_preMul_output_payload_msb1;
			mul_preMul_output_rData_msb2 <= mul_preMul_output_payload_msb2;
			mul_preMul_output_rData_roundMode <= mul_preMul_output_payload_roundMode;
			mul_preMul_output_rData_format <= mul_preMul_output_payload_format;
			mul_preMul_output_rData_exp <= mul_preMul_output_payload_exp;
		end
		if (mul_mul_output_ready) begin
			mul_mul_output_rData_rs1_mantissa <= mul_mul_output_payload_rs1_mantissa;
			mul_mul_output_rData_rs1_exponent <= mul_mul_output_payload_rs1_exponent;
			mul_mul_output_rData_rs1_sign <= mul_mul_output_payload_rs1_sign;
			mul_mul_output_rData_rs1_special <= mul_mul_output_payload_rs1_special;
			mul_mul_output_rData_rs2_mantissa <= mul_mul_output_payload_rs2_mantissa;
			mul_mul_output_rData_rs2_exponent <= mul_mul_output_payload_rs2_exponent;
			mul_mul_output_rData_rs2_sign <= mul_mul_output_payload_rs2_sign;
			mul_mul_output_rData_rs2_special <= mul_mul_output_payload_rs2_special;
			mul_mul_output_rData_rs3_mantissa <= mul_mul_output_payload_rs3_mantissa;
			mul_mul_output_rData_rs3_exponent <= mul_mul_output_payload_rs3_exponent;
			mul_mul_output_rData_rs3_sign <= mul_mul_output_payload_rs3_sign;
			mul_mul_output_rData_rs3_special <= mul_mul_output_payload_rs3_special;
			mul_mul_output_rData_rd <= mul_mul_output_payload_rd;
			mul_mul_output_rData_add <= mul_mul_output_payload_add;
			mul_mul_output_rData_divSqrt <= mul_mul_output_payload_divSqrt;
			mul_mul_output_rData_msb1 <= mul_mul_output_payload_msb1;
			mul_mul_output_rData_msb2 <= mul_mul_output_payload_msb2;
			mul_mul_output_rData_roundMode <= mul_mul_output_payload_roundMode;
			mul_mul_output_rData_format <= mul_mul_output_payload_format;
			mul_mul_output_rData_exp <= mul_mul_output_payload_exp;
			mul_mul_output_rData_muls_0 <= mul_mul_output_payload_muls_0;
			mul_mul_output_rData_muls_1 <= mul_mul_output_payload_muls_1;
			mul_mul_output_rData_muls_2 <= mul_mul_output_payload_muls_2;
			mul_mul_output_rData_muls_3 <= mul_mul_output_payload_muls_3;
			mul_mul_output_rData_muls_4 <= mul_mul_output_payload_muls_4;
			mul_mul_output_rData_muls_5 <= mul_mul_output_payload_muls_5;
			mul_mul_output_rData_muls_6 <= mul_mul_output_payload_muls_6;
			mul_mul_output_rData_muls_7 <= mul_mul_output_payload_muls_7;
			mul_mul_output_rData_muls_8 <= mul_mul_output_payload_muls_8;
		end
		if (mul_sum1_output_ready) begin
			mul_sum1_output_rData_rs1_mantissa <= mul_sum1_output_payload_rs1_mantissa;
			mul_sum1_output_rData_rs1_exponent <= mul_sum1_output_payload_rs1_exponent;
			mul_sum1_output_rData_rs1_sign <= mul_sum1_output_payload_rs1_sign;
			mul_sum1_output_rData_rs1_special <= mul_sum1_output_payload_rs1_special;
			mul_sum1_output_rData_rs2_mantissa <= mul_sum1_output_payload_rs2_mantissa;
			mul_sum1_output_rData_rs2_exponent <= mul_sum1_output_payload_rs2_exponent;
			mul_sum1_output_rData_rs2_sign <= mul_sum1_output_payload_rs2_sign;
			mul_sum1_output_rData_rs2_special <= mul_sum1_output_payload_rs2_special;
			mul_sum1_output_rData_rs3_mantissa <= mul_sum1_output_payload_rs3_mantissa;
			mul_sum1_output_rData_rs3_exponent <= mul_sum1_output_payload_rs3_exponent;
			mul_sum1_output_rData_rs3_sign <= mul_sum1_output_payload_rs3_sign;
			mul_sum1_output_rData_rs3_special <= mul_sum1_output_payload_rs3_special;
			mul_sum1_output_rData_rd <= mul_sum1_output_payload_rd;
			mul_sum1_output_rData_add <= mul_sum1_output_payload_add;
			mul_sum1_output_rData_divSqrt <= mul_sum1_output_payload_divSqrt;
			mul_sum1_output_rData_msb1 <= mul_sum1_output_payload_msb1;
			mul_sum1_output_rData_msb2 <= mul_sum1_output_payload_msb2;
			mul_sum1_output_rData_roundMode <= mul_sum1_output_payload_roundMode;
			mul_sum1_output_rData_format <= mul_sum1_output_payload_format;
			mul_sum1_output_rData_exp <= mul_sum1_output_payload_exp;
			mul_sum1_output_rData_muls2_0 <= mul_sum1_output_payload_muls2_0;
			mul_sum1_output_rData_muls2_1 <= mul_sum1_output_payload_muls2_1;
			mul_sum1_output_rData_muls2_2 <= mul_sum1_output_payload_muls2_2;
			mul_sum1_output_rData_muls2_3 <= mul_sum1_output_payload_muls2_3;
			mul_sum1_output_rData_muls2_4 <= mul_sum1_output_payload_muls2_4;
			mul_sum1_output_rData_mulC2 <= mul_sum1_output_payload_mulC2;
		end
		if (mul_sum2_output_ready) begin
			mul_sum2_output_rData_rs1_mantissa <= mul_sum2_output_payload_rs1_mantissa;
			mul_sum2_output_rData_rs1_exponent <= mul_sum2_output_payload_rs1_exponent;
			mul_sum2_output_rData_rs1_sign <= mul_sum2_output_payload_rs1_sign;
			mul_sum2_output_rData_rs1_special <= mul_sum2_output_payload_rs1_special;
			mul_sum2_output_rData_rs2_mantissa <= mul_sum2_output_payload_rs2_mantissa;
			mul_sum2_output_rData_rs2_exponent <= mul_sum2_output_payload_rs2_exponent;
			mul_sum2_output_rData_rs2_sign <= mul_sum2_output_payload_rs2_sign;
			mul_sum2_output_rData_rs2_special <= mul_sum2_output_payload_rs2_special;
			mul_sum2_output_rData_rs3_mantissa <= mul_sum2_output_payload_rs3_mantissa;
			mul_sum2_output_rData_rs3_exponent <= mul_sum2_output_payload_rs3_exponent;
			mul_sum2_output_rData_rs3_sign <= mul_sum2_output_payload_rs3_sign;
			mul_sum2_output_rData_rs3_special <= mul_sum2_output_payload_rs3_special;
			mul_sum2_output_rData_rd <= mul_sum2_output_payload_rd;
			mul_sum2_output_rData_add <= mul_sum2_output_payload_add;
			mul_sum2_output_rData_divSqrt <= mul_sum2_output_payload_divSqrt;
			mul_sum2_output_rData_msb1 <= mul_sum2_output_payload_msb1;
			mul_sum2_output_rData_msb2 <= mul_sum2_output_payload_msb2;
			mul_sum2_output_rData_roundMode <= mul_sum2_output_payload_roundMode;
			mul_sum2_output_rData_format <= mul_sum2_output_payload_format;
			mul_sum2_output_rData_exp <= mul_sum2_output_payload_exp;
			mul_sum2_output_rData_mulC <= mul_sum2_output_payload_mulC;
		end
		if (mul_result_mulToAdd_ready) begin
			mul_result_mulToAdd_rData_rs1_mantissa <= mul_result_mulToAdd_payload_rs1_mantissa;
			mul_result_mulToAdd_rData_rs1_exponent <= mul_result_mulToAdd_payload_rs1_exponent;
			mul_result_mulToAdd_rData_rs1_sign <= mul_result_mulToAdd_payload_rs1_sign;
			mul_result_mulToAdd_rData_rs1_special <= mul_result_mulToAdd_payload_rs1_special;
			mul_result_mulToAdd_rData_rs2_mantissa <= mul_result_mulToAdd_payload_rs2_mantissa;
			mul_result_mulToAdd_rData_rs2_exponent <= mul_result_mulToAdd_payload_rs2_exponent;
			mul_result_mulToAdd_rData_rs2_sign <= mul_result_mulToAdd_payload_rs2_sign;
			mul_result_mulToAdd_rData_rs2_special <= mul_result_mulToAdd_payload_rs2_special;
			mul_result_mulToAdd_rData_rd <= mul_result_mulToAdd_payload_rd;
			mul_result_mulToAdd_rData_roundMode <= mul_result_mulToAdd_payload_roundMode;
			mul_result_mulToAdd_rData_format <= mul_result_mulToAdd_payload_format;
			mul_result_mulToAdd_rData_needCommit <= mul_result_mulToAdd_payload_needCommit;
		end
		if (decode_div_ready) begin
			decode_div_rData_rs1_mantissa <= decode_div_payload_rs1_mantissa;
			decode_div_rData_rs1_exponent <= decode_div_payload_rs1_exponent;
			decode_div_rData_rs1_sign <= decode_div_payload_rs1_sign;
			decode_div_rData_rs1_special <= decode_div_payload_rs1_special;
			decode_div_rData_rs2_mantissa <= decode_div_payload_rs2_mantissa;
			decode_div_rData_rs2_exponent <= decode_div_payload_rs2_exponent;
			decode_div_rData_rs2_sign <= decode_div_payload_rs2_sign;
			decode_div_rData_rs2_special <= decode_div_payload_rs2_special;
			decode_div_rData_rd <= decode_div_payload_rd;
			decode_div_rData_roundMode <= decode_div_payload_roundMode;
			decode_div_rData_format <= decode_div_payload_format;
		end
		div_isCommited <= commitLogic_0_div_notEmpty;
		if (decode_sqrt_ready) begin
			decode_sqrt_rData_rs1_mantissa <= decode_sqrt_payload_rs1_mantissa;
			decode_sqrt_rData_rs1_exponent <= decode_sqrt_payload_rs1_exponent;
			decode_sqrt_rData_rs1_sign <= decode_sqrt_payload_rs1_sign;
			decode_sqrt_rData_rs1_special <= decode_sqrt_payload_rs1_special;
			decode_sqrt_rData_rd <= decode_sqrt_payload_rd;
			decode_sqrt_rData_roundMode <= decode_sqrt_payload_roundMode;
			decode_sqrt_rData_format <= decode_sqrt_payload_format;
		end
		sqrt_isCommited <= commitLogic_0_sqrt_notEmpty;
		sqrt_exponent <= _zz_sqrt_exponent + _zz_sqrt_exponent_4;
		if (add_preShifter_output_ready) begin
			add_preShifter_output_rData_rs1_mantissa <= add_preShifter_output_payload_rs1_mantissa;
			add_preShifter_output_rData_rs1_exponent <= add_preShifter_output_payload_rs1_exponent;
			add_preShifter_output_rData_rs1_sign <= add_preShifter_output_payload_rs1_sign;
			add_preShifter_output_rData_rs1_special <= add_preShifter_output_payload_rs1_special;
			add_preShifter_output_rData_rs2_mantissa <= add_preShifter_output_payload_rs2_mantissa;
			add_preShifter_output_rData_rs2_exponent <= add_preShifter_output_payload_rs2_exponent;
			add_preShifter_output_rData_rs2_sign <= add_preShifter_output_payload_rs2_sign;
			add_preShifter_output_rData_rs2_special <= add_preShifter_output_payload_rs2_special;
			add_preShifter_output_rData_rd <= add_preShifter_output_payload_rd;
			add_preShifter_output_rData_roundMode <= add_preShifter_output_payload_roundMode;
			add_preShifter_output_rData_format <= add_preShifter_output_payload_format;
			add_preShifter_output_rData_needCommit <= add_preShifter_output_payload_needCommit;
			add_preShifter_output_rData_absRs1Bigger <= add_preShifter_output_payload_absRs1Bigger;
			add_preShifter_output_rData_rs1ExponentBigger <= add_preShifter_output_payload_rs1ExponentBigger;
		end
		if (add_shifter_output_ready) begin
			add_shifter_output_rData_rs1_mantissa <= add_shifter_output_payload_rs1_mantissa;
			add_shifter_output_rData_rs1_exponent <= add_shifter_output_payload_rs1_exponent;
			add_shifter_output_rData_rs1_sign <= add_shifter_output_payload_rs1_sign;
			add_shifter_output_rData_rs1_special <= add_shifter_output_payload_rs1_special;
			add_shifter_output_rData_rs2_mantissa <= add_shifter_output_payload_rs2_mantissa;
			add_shifter_output_rData_rs2_exponent <= add_shifter_output_payload_rs2_exponent;
			add_shifter_output_rData_rs2_sign <= add_shifter_output_payload_rs2_sign;
			add_shifter_output_rData_rs2_special <= add_shifter_output_payload_rs2_special;
			add_shifter_output_rData_rd <= add_shifter_output_payload_rd;
			add_shifter_output_rData_roundMode <= add_shifter_output_payload_roundMode;
			add_shifter_output_rData_format <= add_shifter_output_payload_format;
			add_shifter_output_rData_needCommit <= add_shifter_output_payload_needCommit;
			add_shifter_output_rData_xSign <= add_shifter_output_payload_xSign;
			add_shifter_output_rData_ySign <= add_shifter_output_payload_ySign;
			add_shifter_output_rData_xMantissa <= add_shifter_output_payload_xMantissa;
			add_shifter_output_rData_yMantissa <= add_shifter_output_payload_yMantissa;
			add_shifter_output_rData_xyExponent <= add_shifter_output_payload_xyExponent;
			add_shifter_output_rData_xySign <= add_shifter_output_payload_xySign;
			add_shifter_output_rData_roundingScrap <= add_shifter_output_payload_roundingScrap;
		end
		if (add_math_output_ready) begin
			add_math_output_rData_rs1_mantissa <= add_math_output_payload_rs1_mantissa;
			add_math_output_rData_rs1_exponent <= add_math_output_payload_rs1_exponent;
			add_math_output_rData_rs1_sign <= add_math_output_payload_rs1_sign;
			add_math_output_rData_rs1_special <= add_math_output_payload_rs1_special;
			add_math_output_rData_rs2_mantissa <= add_math_output_payload_rs2_mantissa;
			add_math_output_rData_rs2_exponent <= add_math_output_payload_rs2_exponent;
			add_math_output_rData_rs2_sign <= add_math_output_payload_rs2_sign;
			add_math_output_rData_rs2_special <= add_math_output_payload_rs2_special;
			add_math_output_rData_rd <= add_math_output_payload_rd;
			add_math_output_rData_roundMode <= add_math_output_payload_roundMode;
			add_math_output_rData_format <= add_math_output_payload_format;
			add_math_output_rData_needCommit <= add_math_output_payload_needCommit;
			add_math_output_rData_xSign <= add_math_output_payload_xSign;
			add_math_output_rData_ySign <= add_math_output_payload_ySign;
			add_math_output_rData_xMantissa <= add_math_output_payload_xMantissa;
			add_math_output_rData_yMantissa <= add_math_output_payload_yMantissa;
			add_math_output_rData_xyExponent <= add_math_output_payload_xyExponent;
			add_math_output_rData_xySign <= add_math_output_payload_xySign;
			add_math_output_rData_roundingScrap <= add_math_output_payload_roundingScrap;
			add_math_output_rData_xyMantissa <= add_math_output_payload_xyMantissa;
		end
		if (add_oh_output_ready) begin
			add_oh_output_rData_rs1_mantissa <= add_oh_output_payload_rs1_mantissa;
			add_oh_output_rData_rs1_exponent <= add_oh_output_payload_rs1_exponent;
			add_oh_output_rData_rs1_sign <= add_oh_output_payload_rs1_sign;
			add_oh_output_rData_rs1_special <= add_oh_output_payload_rs1_special;
			add_oh_output_rData_rs2_mantissa <= add_oh_output_payload_rs2_mantissa;
			add_oh_output_rData_rs2_exponent <= add_oh_output_payload_rs2_exponent;
			add_oh_output_rData_rs2_sign <= add_oh_output_payload_rs2_sign;
			add_oh_output_rData_rs2_special <= add_oh_output_payload_rs2_special;
			add_oh_output_rData_rd <= add_oh_output_payload_rd;
			add_oh_output_rData_roundMode <= add_oh_output_payload_roundMode;
			add_oh_output_rData_format <= add_oh_output_payload_format;
			add_oh_output_rData_needCommit <= add_oh_output_payload_needCommit;
			add_oh_output_rData_xSign <= add_oh_output_payload_xSign;
			add_oh_output_rData_ySign <= add_oh_output_payload_ySign;
			add_oh_output_rData_xMantissa <= add_oh_output_payload_xMantissa;
			add_oh_output_rData_yMantissa <= add_oh_output_payload_yMantissa;
			add_oh_output_rData_xyExponent <= add_oh_output_payload_xyExponent;
			add_oh_output_rData_xySign <= add_oh_output_payload_xySign;
			add_oh_output_rData_roundingScrap <= add_oh_output_payload_roundingScrap;
			add_oh_output_rData_xyMantissa <= add_oh_output_payload_xyMantissa;
			add_oh_output_rData_shift <= add_oh_output_payload_shift;
		end
		if (load_s1_output_ready) begin
			load_s1_output_rData_rd <= load_s1_output_payload_rd;
			load_s1_output_rData_value_mantissa <= load_s1_output_payload_value_mantissa;
			load_s1_output_rData_value_exponent <= load_s1_output_payload_value_exponent;
			load_s1_output_rData_value_sign <= load_s1_output_payload_value_sign;
			load_s1_output_rData_value_special <= load_s1_output_payload_value_special;
			load_s1_output_rData_scrap <= load_s1_output_payload_scrap;
			load_s1_output_rData_roundMode <= load_s1_output_payload_roundMode;
			load_s1_output_rData_format <= load_s1_output_payload_format;
			load_s1_output_rData_NV <= load_s1_output_payload_NV;
			load_s1_output_rData_DZ <= load_s1_output_payload_DZ;
		end
		if (shortPip_output_ready) begin
			shortPip_output_rData_rd <= shortPip_output_payload_rd;
			shortPip_output_rData_value_mantissa <= shortPip_output_payload_value_mantissa;
			shortPip_output_rData_value_exponent <= shortPip_output_payload_value_exponent;
			shortPip_output_rData_value_sign <= shortPip_output_payload_value_sign;
			shortPip_output_rData_value_special <= shortPip_output_payload_value_special;
			shortPip_output_rData_scrap <= shortPip_output_payload_scrap;
			shortPip_output_rData_roundMode <= shortPip_output_payload_roundMode;
			shortPip_output_rData_format <= shortPip_output_payload_format;
			shortPip_output_rData_NV <= shortPip_output_payload_NV;
			shortPip_output_rData_DZ <= shortPip_output_payload_DZ;
		end
		roundFront_input_payload_rd <= merge_arbitrated_payload_rd;
		roundFront_input_payload_value_mantissa <= merge_arbitrated_payload_value_mantissa;
		roundFront_input_payload_value_exponent <= merge_arbitrated_payload_value_exponent;
		roundFront_input_payload_value_sign <= merge_arbitrated_payload_value_sign;
		roundFront_input_payload_value_special <= merge_arbitrated_payload_value_special;
		roundFront_input_payload_scrap <= merge_arbitrated_payload_scrap;
		roundFront_input_payload_roundMode <= merge_arbitrated_payload_roundMode;
		roundFront_input_payload_format <= merge_arbitrated_payload_format;
		roundFront_input_payload_NV <= merge_arbitrated_payload_NV;
		roundFront_input_payload_DZ <= merge_arbitrated_payload_DZ;
		roundBack_input_payload_rd <= roundFront_output_payload_rd;
		roundBack_input_payload_value_mantissa <= roundFront_output_payload_value_mantissa;
		roundBack_input_payload_value_exponent <= roundFront_output_payload_value_exponent;
		roundBack_input_payload_value_sign <= roundFront_output_payload_value_sign;
		roundBack_input_payload_value_special <= roundFront_output_payload_value_special;
		roundBack_input_payload_scrap <= roundFront_output_payload_scrap;
		roundBack_input_payload_roundMode <= roundFront_output_payload_roundMode;
		roundBack_input_payload_format <= roundFront_output_payload_format;
		roundBack_input_payload_NV <= roundFront_output_payload_NV;
		roundBack_input_payload_DZ <= roundFront_output_payload_DZ;
		roundBack_input_payload_mantissaIncrement <= roundFront_output_payload_mantissaIncrement;
		roundBack_input_payload_roundAdjusted <= roundFront_output_payload_roundAdjusted;
		roundBack_input_payload_exactMask <= roundFront_output_payload_exactMask;
		writeback_input_payload_rd <= roundBack_output_payload_rd;
		writeback_input_payload_value_mantissa <= roundBack_output_payload_value_mantissa;
		writeback_input_payload_value_exponent <= roundBack_output_payload_value_exponent;
		writeback_input_payload_value_sign <= roundBack_output_payload_value_sign;
		writeback_input_payload_value_special <= roundBack_output_payload_value_special;
		writeback_input_payload_format <= roundBack_output_payload_format;
		writeback_input_payload_NV <= roundBack_output_payload_NV;
		writeback_input_payload_NX <= roundBack_output_payload_NX;
		writeback_input_payload_OF <= roundBack_output_payload_OF;
		writeback_input_payload_UF <= roundBack_output_payload_UF;
		writeback_input_payload_DZ <= roundBack_output_payload_DZ;
		writeback_input_payload_write <= roundBack_output_payload_write;
	end
	StreamArbiter_VexRiscv_FpuPlugin_fpu_cmdArbiter_arbiter  cmdArbiter_arbiter(
		.io_inputs_0_valid(scheduler_0_output_valid),
		.io_inputs_0_ready(cmdArbiter_arbiter_io_inputs_0_ready),
		.io_inputs_0_payload_opcode(_zz_io_inputs_0_payload_opcode),
		.io_inputs_0_payload_arg(scheduler_0_output_payload_arg),
		.io_inputs_0_payload_rs1(scheduler_0_output_payload_rs1),
		.io_inputs_0_payload_rs2(scheduler_0_output_payload_rs2),
		.io_inputs_0_payload_rs3(scheduler_0_output_payload_rs3),
		.io_inputs_0_payload_rd(scheduler_0_output_payload_rd),
		.io_inputs_0_payload_format(_zz_io_inputs_0_payload_format),
		.io_inputs_0_payload_roundMode(_zz_io_inputs_0_payload_roundMode),
		.io_output_valid(cmdArbiter_arbiter_io_output_valid),
		.io_output_ready(cmdArbiter_output_ready),
		.io_output_payload_opcode(cmdArbiter_arbiter_io_output_payload_opcode),
		.io_output_payload_arg(cmdArbiter_arbiter_io_output_payload_arg),
		.io_output_payload_rs1(cmdArbiter_arbiter_io_output_payload_rs1),
		.io_output_payload_rs2(cmdArbiter_arbiter_io_output_payload_rs2),
		.io_output_payload_rs3(cmdArbiter_arbiter_io_output_payload_rs3),
		.io_output_payload_rd(cmdArbiter_arbiter_io_output_payload_rd),
		.io_output_payload_format(cmdArbiter_arbiter_io_output_payload_format),
		.io_output_payload_roundMode(cmdArbiter_arbiter_io_output_payload_roundMode),
		.io_chosenOH(cmdArbiter_arbiter_io_chosenOH),
		.clk(clk),
		.reset(reset)
	);
	FpuDiv div_divider(
		.io_input_valid(div_divider_io_input_valid),
		.io_input_ready(div_divider_io_input_ready),
		.io_input_payload_a(div_input_payload_rs1_mantissa),
		.io_input_payload_b(div_input_payload_rs2_mantissa),
		.io_output_valid(div_divider_io_output_valid),
		.io_output_ready(div_input_ready),
		.io_output_payload_result(div_divider_io_output_payload_result),
		.io_output_payload_remain(div_divider_io_output_payload_remain),
		.clk(clk),
		.reset(reset)
	);
	FpuSqrt sqrt_sqrt(
		.io_input_valid(sqrt_sqrt_io_input_valid),
		.io_input_ready(sqrt_sqrt_io_input_ready),
		.io_input_payload_a(sqrt_sqrt_io_input_payload_a),
		.io_output_valid(sqrt_sqrt_io_output_valid),
		.io_output_ready(sqrt_input_ready),
		.io_output_payload_result(sqrt_sqrt_io_output_payload_result),
		.io_output_payload_remain(sqrt_sqrt_io_output_payload_remain),
		.clk(clk),
		.reset(reset)
	);
	StreamArbiter_1_VexRiscv_FpuPlugin_fpu_streamArbiter_2  streamArbiter_2(
		.io_inputs_0_valid(load_s1_output_m2sPipe_valid),
		.io_inputs_0_ready(streamArbiter_2_io_inputs_0_ready),
		.io_inputs_0_payload_rd(load_s1_output_m2sPipe_payload_rd),
		.io_inputs_0_payload_value_mantissa(load_s1_output_m2sPipe_payload_value_mantissa),
		.io_inputs_0_payload_value_exponent(load_s1_output_m2sPipe_payload_value_exponent),
		.io_inputs_0_payload_value_sign(load_s1_output_m2sPipe_payload_value_sign),
		.io_inputs_0_payload_value_special(load_s1_output_m2sPipe_payload_value_special),
		.io_inputs_0_payload_scrap(load_s1_output_m2sPipe_payload_scrap),
		.io_inputs_0_payload_roundMode(load_s1_output_m2sPipe_payload_roundMode),
		.io_inputs_0_payload_format(load_s1_output_m2sPipe_payload_format),
		.io_inputs_0_payload_NV(load_s1_output_m2sPipe_payload_NV),
		.io_inputs_0_payload_DZ(load_s1_output_m2sPipe_payload_DZ),
		.io_inputs_1_valid(sqrt_output_valid),
		.io_inputs_1_ready(streamArbiter_2_io_inputs_1_ready),
		.io_inputs_1_payload_rd(sqrt_output_payload_rd),
		.io_inputs_1_payload_value_mantissa(sqrt_output_payload_value_mantissa),
		.io_inputs_1_payload_value_exponent(sqrt_output_payload_value_exponent),
		.io_inputs_1_payload_value_sign(sqrt_output_payload_value_sign),
		.io_inputs_1_payload_value_special(sqrt_output_payload_value_special),
		.io_inputs_1_payload_scrap(sqrt_output_payload_scrap),
		.io_inputs_1_payload_roundMode(sqrt_output_payload_roundMode),
		.io_inputs_1_payload_format(sqrt_output_payload_format),
		.io_inputs_1_payload_NV(sqrt_output_payload_NV),
		.io_inputs_1_payload_DZ(sqrt_output_payload_DZ),
		.io_inputs_2_valid(div_output_valid),
		.io_inputs_2_ready(streamArbiter_2_io_inputs_2_ready),
		.io_inputs_2_payload_rd(div_output_payload_rd),
		.io_inputs_2_payload_value_mantissa(div_output_payload_value_mantissa),
		.io_inputs_2_payload_value_exponent(div_output_payload_value_exponent),
		.io_inputs_2_payload_value_sign(div_output_payload_value_sign),
		.io_inputs_2_payload_value_special(div_output_payload_value_special),
		.io_inputs_2_payload_scrap(div_output_payload_scrap),
		.io_inputs_2_payload_roundMode(div_output_payload_roundMode),
		.io_inputs_2_payload_format(div_output_payload_format),
		.io_inputs_2_payload_NV(div_output_payload_NV),
		.io_inputs_2_payload_DZ(div_output_payload_DZ),
		.io_inputs_3_valid(add_result_output_valid),
		.io_inputs_3_ready(streamArbiter_2_io_inputs_3_ready),
		.io_inputs_3_payload_rd(add_result_output_payload_rd),
		.io_inputs_3_payload_value_mantissa(add_result_output_payload_value_mantissa),
		.io_inputs_3_payload_value_exponent(add_result_output_payload_value_exponent),
		.io_inputs_3_payload_value_sign(add_result_output_payload_value_sign),
		.io_inputs_3_payload_value_special(add_result_output_payload_value_special),
		.io_inputs_3_payload_scrap(add_result_output_payload_scrap),
		.io_inputs_3_payload_roundMode(add_result_output_payload_roundMode),
		.io_inputs_3_payload_format(add_result_output_payload_format),
		.io_inputs_3_payload_NV(add_result_output_payload_NV),
		.io_inputs_3_payload_DZ(add_result_output_payload_DZ),
		.io_inputs_4_valid(mul_result_output_valid),
		.io_inputs_4_ready(streamArbiter_2_io_inputs_4_ready),
		.io_inputs_4_payload_rd(mul_result_output_payload_rd),
		.io_inputs_4_payload_value_mantissa(mul_result_output_payload_value_mantissa),
		.io_inputs_4_payload_value_exponent(mul_result_output_payload_value_exponent),
		.io_inputs_4_payload_value_sign(mul_result_output_payload_value_sign),
		.io_inputs_4_payload_value_special(mul_result_output_payload_value_special),
		.io_inputs_4_payload_scrap(mul_result_output_payload_scrap),
		.io_inputs_4_payload_roundMode(mul_result_output_payload_roundMode),
		.io_inputs_4_payload_format(mul_result_output_payload_format),
		.io_inputs_4_payload_NV(mul_result_output_payload_NV),
		.io_inputs_4_payload_DZ(mul_result_output_payload_DZ),
		.io_inputs_5_valid(shortPip_output_m2sPipe_valid),
		.io_inputs_5_ready(streamArbiter_2_io_inputs_5_ready),
		.io_inputs_5_payload_rd(shortPip_output_m2sPipe_payload_rd),
		.io_inputs_5_payload_value_mantissa(shortPip_output_m2sPipe_payload_value_mantissa),
		.io_inputs_5_payload_value_exponent(shortPip_output_m2sPipe_payload_value_exponent),
		.io_inputs_5_payload_value_sign(shortPip_output_m2sPipe_payload_value_sign),
		.io_inputs_5_payload_value_special(shortPip_output_m2sPipe_payload_value_special),
		.io_inputs_5_payload_scrap(shortPip_output_m2sPipe_payload_scrap),
		.io_inputs_5_payload_roundMode(shortPip_output_m2sPipe_payload_roundMode),
		.io_inputs_5_payload_format(shortPip_output_m2sPipe_payload_format),
		.io_inputs_5_payload_NV(shortPip_output_m2sPipe_payload_NV),
		.io_inputs_5_payload_DZ(shortPip_output_m2sPipe_payload_DZ),
		.io_output_valid(streamArbiter_2_io_output_valid),
		.io_output_ready(FpuPlugin_fpu_streamArbiter_2_io_output_combStage_ready),
		.io_output_payload_rd(streamArbiter_2_io_output_payload_rd),
		.io_output_payload_value_mantissa(streamArbiter_2_io_output_payload_value_mantissa),
		.io_output_payload_value_exponent(streamArbiter_2_io_output_payload_value_exponent),
		.io_output_payload_value_sign(streamArbiter_2_io_output_payload_value_sign),
		.io_output_payload_value_special(streamArbiter_2_io_output_payload_value_special),
		.io_output_payload_scrap(streamArbiter_2_io_output_payload_scrap),
		.io_output_payload_roundMode(streamArbiter_2_io_output_payload_roundMode),
		.io_output_payload_format(streamArbiter_2_io_output_payload_format),
		.io_output_payload_NV(streamArbiter_2_io_output_payload_NV),
		.io_output_payload_DZ(streamArbiter_2_io_output_payload_DZ),
		.io_chosen(streamArbiter_2_io_chosen),
		.io_chosenOH(streamArbiter_2_io_chosenOH),
		.clk(clk),
		.reset(reset)
	);
	StreamFork_VexRiscv_FpuPlugin_fpu_streamFork_1  streamFork_1(
		.io_input_valid(io_port_0_commit_valid),
		.io_input_ready(streamFork_1_io_input_ready),
		.io_input_payload_opcode(io_port_0_commit_payload_opcode),
		.io_input_payload_rd(io_port_0_commit_payload_rd),
		.io_input_payload_write(io_port_0_commit_payload_write),
		.io_input_payload_value(io_port_0_commit_payload_value),
		.io_outputs_0_valid(streamFork_1_io_outputs_0_valid),
		.io_outputs_0_ready(commitFork_load_0_ready),
		.io_outputs_0_payload_opcode(streamFork_1_io_outputs_0_payload_opcode),
		.io_outputs_0_payload_rd(streamFork_1_io_outputs_0_payload_rd),
		.io_outputs_0_payload_write(streamFork_1_io_outputs_0_payload_write),
		.io_outputs_0_payload_value(streamFork_1_io_outputs_0_payload_value),
		.io_outputs_1_valid(streamFork_1_io_outputs_1_valid),
		.io_outputs_1_ready(streamFork_1_io_outputs_1_ready),
		.io_outputs_1_payload_opcode(streamFork_1_io_outputs_1_payload_opcode),
		.io_outputs_1_payload_rd(streamFork_1_io_outputs_1_payload_rd),
		.io_outputs_1_payload_write(streamFork_1_io_outputs_1_payload_write),
		.io_outputs_1_payload_value(streamFork_1_io_outputs_1_payload_value)
	);
endmodule
module InstructionCache (
	io_flush,
	io_cpu_prefetch_isValid,
	io_cpu_prefetch_haltIt,
	io_cpu_prefetch_pc,
	io_cpu_fetch_isValid,
	io_cpu_fetch_isStuck,
	io_cpu_fetch_isRemoved,
	io_cpu_fetch_pc,
	io_cpu_fetch_data,
	io_cpu_fetch_mmuRsp_physicalAddress,
	io_cpu_fetch_mmuRsp_isIoAccess,
	io_cpu_fetch_mmuRsp_isPaging,
	io_cpu_fetch_mmuRsp_allowRead,
	io_cpu_fetch_mmuRsp_allowWrite,
	io_cpu_fetch_mmuRsp_allowExecute,
	io_cpu_fetch_mmuRsp_exception,
	io_cpu_fetch_mmuRsp_refilling,
	io_cpu_fetch_mmuRsp_bypassTranslation,
	io_cpu_fetch_mmuRsp_ways_0_sel,
	io_cpu_fetch_mmuRsp_ways_0_physical,
	io_cpu_fetch_mmuRsp_ways_1_sel,
	io_cpu_fetch_mmuRsp_ways_1_physical,
	io_cpu_fetch_mmuRsp_ways_2_sel,
	io_cpu_fetch_mmuRsp_ways_2_physical,
	io_cpu_fetch_mmuRsp_ways_3_sel,
	io_cpu_fetch_mmuRsp_ways_3_physical,
	io_cpu_fetch_physicalAddress,
	io_cpu_fetch_cacheMiss,
	io_cpu_fetch_error,
	io_cpu_fetch_mmuRefilling,
	io_cpu_fetch_mmuException,
	io_cpu_fetch_isUser,
	io_cpu_decode_isValid,
	io_cpu_decode_isStuck,
	io_cpu_decode_pc,
	io_cpu_decode_physicalAddress,
	io_cpu_decode_data,
	io_cpu_fill_valid,
	io_cpu_fill_payload,
	io_mem_cmd_valid,
	io_mem_cmd_ready,
	io_mem_cmd_payload_address,
	io_mem_cmd_payload_size,
	io_mem_rsp_valid,
	io_mem_rsp_payload_data,
	io_mem_rsp_payload_error,
	clk,
	reset
);
	input io_flush;
	input io_cpu_prefetch_isValid;
	output reg io_cpu_prefetch_haltIt;
	input [31:0] io_cpu_prefetch_pc;
	input io_cpu_fetch_isValid;
	input io_cpu_fetch_isStuck;
	input io_cpu_fetch_isRemoved;
	input [31:0] io_cpu_fetch_pc;
	output [31:0] io_cpu_fetch_data;
	input [31:0] io_cpu_fetch_mmuRsp_physicalAddress;
	input io_cpu_fetch_mmuRsp_isIoAccess;
	input io_cpu_fetch_mmuRsp_isPaging;
	input io_cpu_fetch_mmuRsp_allowRead;
	input io_cpu_fetch_mmuRsp_allowWrite;
	input io_cpu_fetch_mmuRsp_allowExecute;
	input io_cpu_fetch_mmuRsp_exception;
	input io_cpu_fetch_mmuRsp_refilling;
	input io_cpu_fetch_mmuRsp_bypassTranslation;
	input io_cpu_fetch_mmuRsp_ways_0_sel;
	input [31:0] io_cpu_fetch_mmuRsp_ways_0_physical;
	input io_cpu_fetch_mmuRsp_ways_1_sel;
	input [31:0] io_cpu_fetch_mmuRsp_ways_1_physical;
	input io_cpu_fetch_mmuRsp_ways_2_sel;
	input [31:0] io_cpu_fetch_mmuRsp_ways_2_physical;
	input io_cpu_fetch_mmuRsp_ways_3_sel;
	input [31:0] io_cpu_fetch_mmuRsp_ways_3_physical;
	output [31:0] io_cpu_fetch_physicalAddress;
	output io_cpu_fetch_cacheMiss;
	output io_cpu_fetch_error;
	output io_cpu_fetch_mmuRefilling;
	output io_cpu_fetch_mmuException;
	input io_cpu_fetch_isUser;
	input io_cpu_decode_isValid;
	input io_cpu_decode_isStuck;
	input [31:0] io_cpu_decode_pc;
	output [31:0] io_cpu_decode_physicalAddress;
	output [31:0] io_cpu_decode_data;
	input io_cpu_fill_valid;
	input [31:0] io_cpu_fill_payload;
	output io_mem_cmd_valid;
	input io_mem_cmd_ready;
	output [31:0] io_mem_cmd_payload_address;
	output [1:0] io_mem_cmd_payload_size;
	input io_mem_rsp_valid;
	input [63:0] io_mem_rsp_payload_data;
	input io_mem_rsp_payload_error;
	input clk;
	input reset;
	reg _zz_1;
	reg _zz_2;
	reg _zz_3;
	reg _zz_4;
	reg [63:0] _zz_banks_0_port1;
	reg [63:0] _zz_banks_1_port1;
	reg [31:0] _zz_fetchStage_hit_data;
	reg _zz_fetchStage_hit_error;
	reg [31:0] _zz_fetchStage_read_banksValue_0_data;
	wire [7:0] _zz_fetchStage_read_banksValue_0_dataMem;
	wire _zz_fetchStage_read_banksValue_0_dataMem_1;
	wire _zz_fetchStage_read_banksValue_0_data_1;
	reg [31:0] _zz_fetchStage_read_banksValue_1_data;
	wire [7:0] _zz_fetchStage_read_banksValue_1_dataMem;
	wire _zz_fetchStage_read_banksValue_1_dataMem_1;
	wire _zz_fetchStage_read_banksValue_1_data_1;
	wire [7:0] _zz_fetchStage_read_waysValues_0_tag_valid;
	wire _zz_fetchStage_read_waysValues_0_tag_valid_1;
	wire [22:0] _zz_fetchStage_read_waysValues_0_tag_valid_2;
	wire [7:0] _zz_fetchStage_read_waysValues_1_tag_valid;
	wire _zz_fetchStage_read_waysValues_1_tag_valid_1;
	wire [22:0] _zz_fetchStage_read_waysValues_1_tag_valid_2;
	wire [22:0] _zz_ways_0_tags_port;
	reg [22:0] _zz_ways_0_tags_port1;
	wire [22:0] _zz_ways_1_tags_port;
	reg [22:0] _zz_ways_1_tags_port1;
	reg _zz_when_InstructionCache_l342;
	reg [63:0] banks_0 [0:255];
	reg [63:0] banks_1 [0:255];
	wire [31:0] fetchStage_hit_data;
	wire fetchStage_hit_error;
	wire fetchStage_hit_hits_0;
	wire fetchStage_hit_hits_1;
	wire fetchStage_hit_valid;
	wire fetchStage_hit_wayId;
	wire [31:0] fetchStage_hit_word;
	wire [31:0] fetchStage_read_banksValue_0_data;
	wire [63:0] fetchStage_read_banksValue_0_dataMem;
	wire [31:0] fetchStage_read_banksValue_1_data;
	wire [63:0] fetchStage_read_banksValue_1_dataMem;
	wire [20:0] fetchStage_read_waysValues_0_tag_address;
	wire fetchStage_read_waysValues_0_tag_error;
	wire fetchStage_read_waysValues_0_tag_valid;
	wire [20:0] fetchStage_read_waysValues_1_tag_address;
	wire fetchStage_read_waysValues_1_tag_error;
	wire fetchStage_read_waysValues_1_tag_valid;
	wire io_mem_cmd_fire;
	reg [31:0] lineLoader_address;
	reg lineLoader_cmdSent;
	reg lineLoader_fire;
	reg [8:0] lineLoader_flushCounter;
	reg lineLoader_flushPending;
	reg lineLoader_hadError;
	reg lineLoader_valid;
	reg lineLoader_wayToAllocate_value;
	reg lineLoader_wayToAllocate_valueNext;
	wire lineLoader_wayToAllocate_willClear;
	reg lineLoader_wayToAllocate_willIncrement;
	wire lineLoader_wayToAllocate_willOverflow;
	wire lineLoader_wayToAllocate_willOverflowIfInc;
	wire [7:0] lineLoader_write_data_0_payload_address;
	wire [63:0] lineLoader_write_data_0_payload_data;
	wire lineLoader_write_data_0_valid;
	wire [7:0] lineLoader_write_data_1_payload_address;
	wire [63:0] lineLoader_write_data_1_payload_data;
	wire lineLoader_write_data_1_valid;
	wire [7:0] lineLoader_write_tag_0_payload_address;
	wire [20:0] lineLoader_write_tag_0_payload_data_address;
	wire lineLoader_write_tag_0_payload_data_error;
	wire lineLoader_write_tag_0_payload_data_valid;
	wire lineLoader_write_tag_0_valid;
	wire [7:0] lineLoader_write_tag_1_payload_address;
	wire [20:0] lineLoader_write_tag_1_payload_data_address;
	wire lineLoader_write_tag_1_payload_data_error;
	wire lineLoader_write_tag_1_payload_data_valid;
	wire lineLoader_write_tag_1_valid;
	reg [22:0] ways_0_tags [0:255];
	reg [22:0] ways_1_tags [0:255];
	wire when_InstructionCache_l338;
	wire when_InstructionCache_l342;
	wire when_InstructionCache_l351;
	wire when_InstructionCache_l401;
	wire when_Utils_l520;
	assign io_mem_cmd_payload_size = 2'h3;
	assign lineLoader_wayToAllocate_willClear = 1'b0;
	assign when_InstructionCache_l401 = 1'b1;
	assign _zz_ways_0_tags_port = {lineLoader_write_tag_0_payload_data_address, lineLoader_write_tag_0_payload_data_error, lineLoader_write_tag_0_payload_data_valid};
	assign _zz_ways_1_tags_port = {lineLoader_write_tag_1_payload_data_address, lineLoader_write_tag_1_payload_data_error, lineLoader_write_tag_1_payload_data_valid};
	assign _zz_fetchStage_read_banksValue_0_data_1 = io_cpu_fetch_pc[2];
	assign _zz_fetchStage_read_banksValue_1_data_1 = io_cpu_fetch_pc[2];
	assign when_InstructionCache_l338 = ~|lineLoader_flushCounter[8];
	assign when_InstructionCache_l342 = ~|_zz_when_InstructionCache_l342;
	assign io_mem_cmd_payload_address = {lineLoader_address[31:3], 3'h0};
	assign when_Utils_l520 = ~|lineLoader_valid;
	assign lineLoader_write_tag_0_payload_address = (lineLoader_flushCounter[8] ? lineLoader_address[10:3] : lineLoader_flushCounter[7:0]);
	assign lineLoader_write_tag_0_payload_data_valid = lineLoader_flushCounter[8];
	assign lineLoader_write_tag_0_payload_data_address = lineLoader_address[31:11];
	assign lineLoader_write_tag_1_payload_address = (lineLoader_flushCounter[8] ? lineLoader_address[10:3] : lineLoader_flushCounter[7:0]);
	assign lineLoader_write_tag_1_payload_data_valid = lineLoader_flushCounter[8];
	assign lineLoader_write_tag_1_payload_data_address = lineLoader_address[31:11];
	assign lineLoader_write_data_0_payload_address = lineLoader_address[10:3];
	assign lineLoader_write_data_1_payload_address = lineLoader_address[10:3];
	assign _zz_fetchStage_read_banksValue_0_dataMem = io_cpu_prefetch_pc[10:3];
	assign _zz_fetchStage_read_banksValue_0_dataMem_1 = ~|io_cpu_fetch_isStuck;
	assign _zz_fetchStage_read_banksValue_1_dataMem = io_cpu_prefetch_pc[10:3];
	assign _zz_fetchStage_read_banksValue_1_dataMem_1 = ~|io_cpu_fetch_isStuck;
	assign _zz_fetchStage_read_waysValues_0_tag_valid = io_cpu_prefetch_pc[10:3];
	assign _zz_fetchStage_read_waysValues_0_tag_valid_1 = ~|io_cpu_fetch_isStuck;
	assign fetchStage_read_waysValues_0_tag_valid = _zz_fetchStage_read_waysValues_0_tag_valid_2[0];
	assign fetchStage_read_waysValues_0_tag_error = _zz_fetchStage_read_waysValues_0_tag_valid_2[1];
	assign fetchStage_read_waysValues_0_tag_address = _zz_fetchStage_read_waysValues_0_tag_valid_2[22:2];
	assign _zz_fetchStage_read_waysValues_1_tag_valid = io_cpu_prefetch_pc[10:3];
	assign _zz_fetchStage_read_waysValues_1_tag_valid_1 = ~|io_cpu_fetch_isStuck;
	assign fetchStage_read_waysValues_1_tag_valid = _zz_fetchStage_read_waysValues_1_tag_valid_2[0];
	assign fetchStage_read_waysValues_1_tag_error = _zz_fetchStage_read_waysValues_1_tag_valid_2[1];
	assign fetchStage_read_waysValues_1_tag_address = _zz_fetchStage_read_waysValues_1_tag_valid_2[22:2];
	assign fetchStage_hit_valid = |{fetchStage_hit_hits_1, fetchStage_hit_hits_0};
	assign io_cpu_fetch_cacheMiss = ~|fetchStage_hit_valid;
	assign when_InstructionCache_l351 = lineLoader_flushPending & ~|(lineLoader_valid | io_cpu_fetch_isValid);
	assign io_mem_cmd_fire = io_mem_cmd_valid & io_mem_cmd_ready;
	assign io_mem_cmd_valid = lineLoader_valid & ~|lineLoader_cmdSent;
	assign lineLoader_wayToAllocate_willOverflowIfInc = lineLoader_wayToAllocate_value ~^ 1'b1;
	assign lineLoader_wayToAllocate_willOverflow = lineLoader_wayToAllocate_willOverflowIfInc & lineLoader_wayToAllocate_willIncrement;
	assign lineLoader_write_tag_0_valid = ((lineLoader_wayToAllocate_value ~^ 1'b0) & lineLoader_fire) | ~|lineLoader_flushCounter[8];
	assign lineLoader_write_tag_0_payload_data_error = lineLoader_hadError | io_mem_rsp_payload_error;
	assign lineLoader_write_tag_1_valid = ((lineLoader_wayToAllocate_value ~^ 1'b1) & lineLoader_fire) | ~|lineLoader_flushCounter[8];
	assign lineLoader_write_tag_1_payload_data_error = lineLoader_hadError | io_mem_rsp_payload_error;
	assign lineLoader_write_data_0_valid = io_mem_rsp_valid & (lineLoader_wayToAllocate_value ~^ 1'b0);
	assign lineLoader_write_data_0_payload_data = io_mem_rsp_payload_data;
	assign lineLoader_write_data_1_valid = io_mem_rsp_valid & (lineLoader_wayToAllocate_value ~^ 1'b1);
	assign lineLoader_write_data_1_payload_data = io_mem_rsp_payload_data;
	assign fetchStage_read_banksValue_0_dataMem = _zz_banks_0_port1;
	assign fetchStage_read_banksValue_0_data = _zz_fetchStage_read_banksValue_0_data;
	assign fetchStage_read_banksValue_1_dataMem = _zz_banks_1_port1;
	assign fetchStage_read_banksValue_1_data = _zz_fetchStage_read_banksValue_1_data;
	assign _zz_fetchStage_read_waysValues_0_tag_valid_2 = _zz_ways_0_tags_port1;
	assign _zz_fetchStage_read_waysValues_1_tag_valid_2 = _zz_ways_1_tags_port1;
	assign fetchStage_hit_hits_0 = fetchStage_read_waysValues_0_tag_valid & (fetchStage_read_waysValues_0_tag_address == io_cpu_fetch_mmuRsp_physicalAddress[31:11]);
	assign fetchStage_hit_hits_1 = fetchStage_read_waysValues_1_tag_valid & (fetchStage_read_waysValues_1_tag_address == io_cpu_fetch_mmuRsp_physicalAddress[31:11]);
	assign fetchStage_hit_wayId = fetchStage_hit_hits_1;
	assign fetchStage_hit_error = _zz_fetchStage_hit_error;
	assign fetchStage_hit_data = _zz_fetchStage_hit_data;
	assign fetchStage_hit_word = fetchStage_hit_data;
	assign io_cpu_fetch_data = fetchStage_hit_word;
	assign io_cpu_fetch_physicalAddress = io_cpu_fetch_mmuRsp_physicalAddress;
	assign io_cpu_fetch_error = fetchStage_hit_error | (~|io_cpu_fetch_mmuRsp_isPaging & (io_cpu_fetch_mmuRsp_exception | ~|io_cpu_fetch_mmuRsp_allowExecute));
	assign io_cpu_fetch_mmuRefilling = io_cpu_fetch_mmuRsp_refilling;
	assign io_cpu_fetch_mmuException = (~|io_cpu_fetch_mmuRsp_refilling & io_cpu_fetch_mmuRsp_isPaging) & (io_cpu_fetch_mmuRsp_exception | ~|io_cpu_fetch_mmuRsp_allowExecute);
	always @(posedge clk)
		if (_zz_2)
			banks_0[lineLoader_write_data_0_payload_address] <= lineLoader_write_data_0_payload_data;
	always @(posedge clk)
		if (_zz_fetchStage_read_banksValue_0_dataMem_1)
			_zz_banks_0_port1 <= banks_0[_zz_fetchStage_read_banksValue_0_dataMem];
	always @(posedge clk)
		if (_zz_1)
			banks_1[lineLoader_write_data_1_payload_address] <= lineLoader_write_data_1_payload_data;
	always @(posedge clk)
		if (_zz_fetchStage_read_banksValue_1_dataMem_1)
			_zz_banks_1_port1 <= banks_1[_zz_fetchStage_read_banksValue_1_dataMem];
	always @(posedge clk)
		if (_zz_4)
			ways_0_tags[lineLoader_write_tag_0_payload_address] <= _zz_ways_0_tags_port;
	always @(posedge clk)
		if (_zz_fetchStage_read_waysValues_0_tag_valid_1)
			_zz_ways_0_tags_port1 <= ways_0_tags[_zz_fetchStage_read_waysValues_0_tag_valid];
	always @(posedge clk)
		if (_zz_3)
			ways_1_tags[lineLoader_write_tag_1_payload_address] <= _zz_ways_1_tags_port;
	always @(posedge clk)
		if (_zz_fetchStage_read_waysValues_1_tag_valid_1)
			_zz_ways_1_tags_port1 <= ways_1_tags[_zz_fetchStage_read_waysValues_1_tag_valid];
	always @(_zz_fetchStage_read_banksValue_0_data_1 or fetchStage_read_banksValue_0_dataMem)
		case (_zz_fetchStage_read_banksValue_0_data_1)
			1'b0: _zz_fetchStage_read_banksValue_0_data = fetchStage_read_banksValue_0_dataMem[31:0];
			default: _zz_fetchStage_read_banksValue_0_data = fetchStage_read_banksValue_0_dataMem[63:32];
		endcase
	always @(_zz_fetchStage_read_banksValue_1_data_1 or fetchStage_read_banksValue_1_dataMem)
		case (_zz_fetchStage_read_banksValue_1_data_1)
			1'b0: _zz_fetchStage_read_banksValue_1_data = fetchStage_read_banksValue_1_dataMem[31:0];
			default: _zz_fetchStage_read_banksValue_1_data = fetchStage_read_banksValue_1_dataMem[63:32];
		endcase
	always @(fetchStage_hit_wayId or fetchStage_read_waysValues_0_tag_error or fetchStage_read_banksValue_0_data or fetchStage_read_waysValues_1_tag_error or fetchStage_read_banksValue_1_data)
		case (fetchStage_hit_wayId)
			1'b0: begin
				_zz_fetchStage_hit_error = fetchStage_read_waysValues_0_tag_error;
				_zz_fetchStage_hit_data = fetchStage_read_banksValue_0_data;
			end
			default: begin
				_zz_fetchStage_hit_error = fetchStage_read_waysValues_1_tag_error;
				_zz_fetchStage_hit_data = fetchStage_read_banksValue_1_data;
			end
		endcase
	always @(lineLoader_write_data_1_valid) begin
		_zz_1 = 1'b0;
		if (lineLoader_write_data_1_valid)
			_zz_1 = 1'b1;
	end
	always @(lineLoader_write_data_0_valid) begin
		_zz_2 = 1'b0;
		if (lineLoader_write_data_0_valid)
			_zz_2 = 1'b1;
	end
	always @(lineLoader_write_tag_1_valid) begin
		_zz_3 = 1'b0;
		if (lineLoader_write_tag_1_valid)
			_zz_3 = 1'b1;
	end
	always @(lineLoader_write_tag_0_valid) begin
		_zz_4 = 1'b0;
		if (lineLoader_write_tag_0_valid)
			_zz_4 = 1'b1;
	end
	always @(io_mem_rsp_valid or when_InstructionCache_l401) begin
		lineLoader_fire = 1'b0;
		if (io_mem_rsp_valid) begin
			if (when_InstructionCache_l401)
				lineLoader_fire = 1'b1;
		end
	end
	always @(lineLoader_valid or lineLoader_flushPending or when_InstructionCache_l338 or when_InstructionCache_l342 or io_flush) begin
		io_cpu_prefetch_haltIt = lineLoader_valid || lineLoader_flushPending;
		if (when_InstructionCache_l338)
			io_cpu_prefetch_haltIt = 1'b1;
		if (when_InstructionCache_l342)
			io_cpu_prefetch_haltIt = 1'b1;
		if (io_flush)
			io_cpu_prefetch_haltIt = 1'b1;
	end
	always @(when_Utils_l520) begin
		lineLoader_wayToAllocate_willIncrement = 1'b0;
		if (when_Utils_l520)
			lineLoader_wayToAllocate_willIncrement = 1'b1;
	end
	always @(lineLoader_wayToAllocate_value or lineLoader_wayToAllocate_willIncrement or lineLoader_wayToAllocate_willClear) begin
		lineLoader_wayToAllocate_valueNext = lineLoader_wayToAllocate_value + lineLoader_wayToAllocate_willIncrement;
		if (lineLoader_wayToAllocate_willClear)
			lineLoader_wayToAllocate_valueNext = 1'b0;
	end
	always @(posedge reset or posedge clk)
		if (reset) begin
			lineLoader_valid <= 1'b0;
			lineLoader_hadError <= 1'b0;
			lineLoader_flushPending <= 1'b1;
			lineLoader_cmdSent <= 1'b0;
			lineLoader_wayToAllocate_value <= 1'b0;
		end
		else begin
			if (lineLoader_fire)
				lineLoader_valid <= 1'b0;
			if (lineLoader_fire)
				lineLoader_hadError <= 1'b0;
			if (io_cpu_fill_valid)
				lineLoader_valid <= 1'b1;
			if (io_flush)
				lineLoader_flushPending <= 1'b1;
			if (when_InstructionCache_l351)
				lineLoader_flushPending <= 1'b0;
			if (io_mem_cmd_fire)
				lineLoader_cmdSent <= 1'b1;
			if (lineLoader_fire)
				lineLoader_cmdSent <= 1'b0;
			lineLoader_wayToAllocate_value <= lineLoader_wayToAllocate_valueNext;
			if (io_mem_rsp_valid) begin
				if (io_mem_rsp_payload_error)
					lineLoader_hadError <= 1'b1;
			end
		end
	always @(posedge clk) begin
		if (io_cpu_fill_valid)
			lineLoader_address <= io_cpu_fill_payload;
		if (when_InstructionCache_l338)
			lineLoader_flushCounter <= lineLoader_flushCounter + 9'h001;
		_zz_when_InstructionCache_l342 <= lineLoader_flushCounter[8];
		if (when_InstructionCache_l351)
			lineLoader_flushCounter <= 9'h000;
	end
endmodule
module DataCache (
	io_cpu_execute_isValid,
	io_cpu_execute_address,
	io_cpu_execute_haltIt,
	io_cpu_execute_args_wr,
	io_cpu_execute_args_size,
	io_cpu_execute_args_totalyConsistent,
	io_cpu_execute_refilling,
	io_cpu_memory_isValid,
	io_cpu_memory_isStuck,
	io_cpu_memory_isWrite,
	io_cpu_memory_address,
	io_cpu_memory_mmuRsp_physicalAddress,
	io_cpu_memory_mmuRsp_isIoAccess,
	io_cpu_memory_mmuRsp_isPaging,
	io_cpu_memory_mmuRsp_allowRead,
	io_cpu_memory_mmuRsp_allowWrite,
	io_cpu_memory_mmuRsp_allowExecute,
	io_cpu_memory_mmuRsp_exception,
	io_cpu_memory_mmuRsp_refilling,
	io_cpu_memory_mmuRsp_bypassTranslation,
	io_cpu_memory_mmuRsp_ways_0_sel,
	io_cpu_memory_mmuRsp_ways_0_physical,
	io_cpu_memory_mmuRsp_ways_1_sel,
	io_cpu_memory_mmuRsp_ways_1_physical,
	io_cpu_memory_mmuRsp_ways_2_sel,
	io_cpu_memory_mmuRsp_ways_2_physical,
	io_cpu_memory_mmuRsp_ways_3_sel,
	io_cpu_memory_mmuRsp_ways_3_physical,
	io_cpu_writeBack_isValid,
	io_cpu_writeBack_isStuck,
	io_cpu_writeBack_isFiring,
	io_cpu_writeBack_isUser,
	io_cpu_writeBack_haltIt,
	io_cpu_writeBack_isWrite,
	io_cpu_writeBack_storeData,
	io_cpu_writeBack_data,
	io_cpu_writeBack_address,
	io_cpu_writeBack_mmuException,
	io_cpu_writeBack_unalignedAccess,
	io_cpu_writeBack_accessError,
	io_cpu_writeBack_keepMemRspData,
	io_cpu_writeBack_fence_SW,
	io_cpu_writeBack_fence_SR,
	io_cpu_writeBack_fence_SO,
	io_cpu_writeBack_fence_SI,
	io_cpu_writeBack_fence_PW,
	io_cpu_writeBack_fence_PR,
	io_cpu_writeBack_fence_PO,
	io_cpu_writeBack_fence_PI,
	io_cpu_writeBack_fence_FM,
	io_cpu_writeBack_exclusiveOk,
	io_cpu_redo,
	io_cpu_flush_valid,
	io_cpu_flush_ready,
	io_cpu_flush_payload_singleLine,
	io_cpu_flush_payload_lineId,
	io_cpu_writesPending,
	io_mem_cmd_valid,
	io_mem_cmd_ready,
	io_mem_cmd_payload_wr,
	io_mem_cmd_payload_uncached,
	io_mem_cmd_payload_address,
	io_mem_cmd_payload_data,
	io_mem_cmd_payload_mask,
	io_mem_cmd_payload_size,
	io_mem_cmd_payload_last,
	io_mem_rsp_valid,
	io_mem_rsp_payload_last,
	io_mem_rsp_payload_data,
	io_mem_rsp_payload_error,
	clk,
	reset
);
	input io_cpu_execute_isValid;
	input [31:0] io_cpu_execute_address;
	output reg io_cpu_execute_haltIt;
	input io_cpu_execute_args_wr;
	input [1:0] io_cpu_execute_args_size;
	input io_cpu_execute_args_totalyConsistent;
	output io_cpu_execute_refilling;
	input io_cpu_memory_isValid;
	input io_cpu_memory_isStuck;
	output io_cpu_memory_isWrite;
	input [31:0] io_cpu_memory_address;
	input [31:0] io_cpu_memory_mmuRsp_physicalAddress;
	input io_cpu_memory_mmuRsp_isIoAccess;
	input io_cpu_memory_mmuRsp_isPaging;
	input io_cpu_memory_mmuRsp_allowRead;
	input io_cpu_memory_mmuRsp_allowWrite;
	input io_cpu_memory_mmuRsp_allowExecute;
	input io_cpu_memory_mmuRsp_exception;
	input io_cpu_memory_mmuRsp_refilling;
	input io_cpu_memory_mmuRsp_bypassTranslation;
	input io_cpu_memory_mmuRsp_ways_0_sel;
	input [31:0] io_cpu_memory_mmuRsp_ways_0_physical;
	input io_cpu_memory_mmuRsp_ways_1_sel;
	input [31:0] io_cpu_memory_mmuRsp_ways_1_physical;
	input io_cpu_memory_mmuRsp_ways_2_sel;
	input [31:0] io_cpu_memory_mmuRsp_ways_2_physical;
	input io_cpu_memory_mmuRsp_ways_3_sel;
	input [31:0] io_cpu_memory_mmuRsp_ways_3_physical;
	input io_cpu_writeBack_isValid;
	input io_cpu_writeBack_isStuck;
	input io_cpu_writeBack_isFiring;
	input io_cpu_writeBack_isUser;
	output reg io_cpu_writeBack_haltIt;
	output io_cpu_writeBack_isWrite;
	input [63:0] io_cpu_writeBack_storeData;
	output reg [63:0] io_cpu_writeBack_data;
	input [31:0] io_cpu_writeBack_address;
	output io_cpu_writeBack_mmuException;
	output io_cpu_writeBack_unalignedAccess;
	output reg io_cpu_writeBack_accessError;
	output io_cpu_writeBack_keepMemRspData;
	input io_cpu_writeBack_fence_SW;
	input io_cpu_writeBack_fence_SR;
	input io_cpu_writeBack_fence_SO;
	input io_cpu_writeBack_fence_SI;
	input io_cpu_writeBack_fence_PW;
	input io_cpu_writeBack_fence_PR;
	input io_cpu_writeBack_fence_PO;
	input io_cpu_writeBack_fence_PI;
	input [3:0] io_cpu_writeBack_fence_FM;
	output io_cpu_writeBack_exclusiveOk;
	output reg io_cpu_redo;
	input io_cpu_flush_valid;
	output io_cpu_flush_ready;
	input io_cpu_flush_payload_singleLine;
	input [7:0] io_cpu_flush_payload_lineId;
	output io_cpu_writesPending;
	output reg io_mem_cmd_valid;
	input io_mem_cmd_ready;
	output reg io_mem_cmd_payload_wr;
	output io_mem_cmd_payload_uncached;
	output reg [31:0] io_mem_cmd_payload_address;
	output [63:0] io_mem_cmd_payload_data;
	output [7:0] io_mem_cmd_payload_mask;
	output reg [1:0] io_mem_cmd_payload_size;
	output io_mem_cmd_payload_last;
	input io_mem_rsp_valid;
	input io_mem_rsp_payload_last;
	input [63:0] io_mem_rsp_payload_data;
	input io_mem_rsp_payload_error;
	input clk;
	input reset;
	reg _zz_1;
	reg _zz_2;
	reg _zz_3;
	reg _zz_4;
	wire [2:0] _zz_loader_waysAllocator;
	wire [7:0] _zz_stage0_dataColisions;
	wire [7:0] _zz_stage0_dataColisions_1;
	reg [7:0] _zz_stage0_mask;
	reg [1:0] _zz_stageA_dataColisions;
	wire [7:0] _zz_stageA_dataColisions_1;
	wire [7:0] _zz_stageA_dataColisions_2;
	wire _zz_ways_0_dataReadRspMem;
	reg [63:0] _zz_ways_0_data_port0;
	reg [7:0] _zz_ways_0_datasymbol_read;
	reg [7:0] _zz_ways_0_datasymbol_read_1;
	reg [7:0] _zz_ways_0_datasymbol_read_2;
	reg [7:0] _zz_ways_0_datasymbol_read_3;
	reg [7:0] _zz_ways_0_datasymbol_read_4;
	reg [7:0] _zz_ways_0_datasymbol_read_5;
	reg [7:0] _zz_ways_0_datasymbol_read_6;
	reg [7:0] _zz_ways_0_datasymbol_read_7;
	wire _zz_ways_0_tagsReadRsp_valid;
	wire [22:0] _zz_ways_0_tagsReadRsp_valid_1;
	wire [22:0] _zz_ways_0_tags_port;
	reg [22:0] _zz_ways_0_tags_port0;
	wire _zz_ways_1_dataReadRspMem;
	reg [63:0] _zz_ways_1_data_port0;
	reg [7:0] _zz_ways_1_datasymbol_read;
	reg [7:0] _zz_ways_1_datasymbol_read_1;
	reg [7:0] _zz_ways_1_datasymbol_read_2;
	reg [7:0] _zz_ways_1_datasymbol_read_3;
	reg [7:0] _zz_ways_1_datasymbol_read_4;
	reg [7:0] _zz_ways_1_datasymbol_read_5;
	reg [7:0] _zz_ways_1_datasymbol_read_6;
	reg [7:0] _zz_ways_1_datasymbol_read_7;
	wire _zz_ways_1_tagsReadRsp_valid;
	wire [22:0] _zz_ways_1_tagsReadRsp_valid_1;
	wire [22:0] _zz_ways_1_tags_port;
	reg [22:0] _zz_ways_1_tags_port0;
	wire _zz_when;
	reg [7:0] dataReadCmd_payload;
	reg dataReadCmd_valid;
	reg [7:0] dataWriteCmd_payload_address;
	reg [63:0] dataWriteCmd_payload_data;
	reg [7:0] dataWriteCmd_payload_mask;
	reg [1:0] dataWriteCmd_payload_way;
	reg dataWriteCmd_valid;
	wire haltCpu;
	wire io_mem_cmd_fire;
	wire loader_counter_willClear;
	reg loader_counter_willIncrement;
	wire loader_counter_willOverflow;
	wire loader_counter_willOverflowIfInc;
	wire loader_done;
	reg loader_error;
	wire loader_kill;
	reg loader_killReg;
	reg loader_valid;
	reg loader_valid_regNext;
	reg [1:0] loader_waysAllocator;
	reg memCmdSent;
	wire rspLast;
	wire rspSync;
	reg [1:0] stage0_dataColisions;
	reg [1:0] stage0_dataColisions_regNextWhen;
	wire stage0_isAmo;
	wire [7:0] stage0_mask;
	wire [1:0] stage0_wayInvalidate;
	wire [1:0] stageA_dataColisions;
	wire stageA_isAmo;
	wire stageA_isLrsc;
	reg [7:0] stageA_mask;
	reg [1:0] stageA_request_size;
	reg stageA_request_totalyConsistent;
	reg stageA_request_wr;
	wire [1:0] stageA_wayHits;
	reg [1:0] stageA_wayInvalidate;
	wire stageB_badPermissions;
	wire stageB_bypassCache;
	wire stageB_consistancyHazard;
	reg stageB_cpuWriteToCache;
	reg [1:0] stageB_dataColisions;
	wire [63:0] stageB_dataMux;
	reg [63:0] stageB_dataReadRsp_0;
	reg [63:0] stageB_dataReadRsp_1;
	reg [8:0] stageB_flusher_counter;
	wire stageB_flusher_hold;
	reg stageB_flusher_start;
	reg stageB_flusher_waitDone;
	wire [63:0] stageB_ioMemRspMuxed;
	wire stageB_isAmo;
	wire stageB_isAmoCached;
	wire stageB_isExternalAmo;
	wire stageB_isExternalLsrc;
	wire stageB_loadStoreFault;
	reg stageB_loaderValid;
	reg [7:0] stageB_mask;
	reg stageB_mmuRspFreeze;
	reg stageB_mmuRsp_allowExecute;
	reg stageB_mmuRsp_allowRead;
	reg stageB_mmuRsp_allowWrite;
	reg stageB_mmuRsp_bypassTranslation;
	reg stageB_mmuRsp_exception;
	reg stageB_mmuRsp_isIoAccess;
	reg stageB_mmuRsp_isPaging;
	reg [31:0] stageB_mmuRsp_physicalAddress;
	reg stageB_mmuRsp_refilling;
	reg [31:0] stageB_mmuRsp_ways_0_physical;
	reg stageB_mmuRsp_ways_0_sel;
	reg [31:0] stageB_mmuRsp_ways_1_physical;
	reg stageB_mmuRsp_ways_1_sel;
	reg [31:0] stageB_mmuRsp_ways_2_physical;
	reg stageB_mmuRsp_ways_2_sel;
	reg [31:0] stageB_mmuRsp_ways_3_physical;
	reg stageB_mmuRsp_ways_3_sel;
	wire [63:0] stageB_requestDataBypass;
	reg [1:0] stageB_request_size;
	reg stageB_request_totalyConsistent;
	reg stageB_request_wr;
	reg [20:0] stageB_tagsReadRsp_0_address;
	reg stageB_tagsReadRsp_0_error;
	reg stageB_tagsReadRsp_0_valid;
	reg [20:0] stageB_tagsReadRsp_1_address;
	reg stageB_tagsReadRsp_1_error;
	reg stageB_tagsReadRsp_1_valid;
	reg stageB_unaligned;
	reg [1:0] stageB_wayInvalidate;
	wire stageB_waysHit;
	wire [1:0] stageB_waysHits;
	reg [1:0] stageB_waysHitsBeforeInvalidate;
	reg [7:0] tagsReadCmd_payload;
	reg tagsReadCmd_valid;
	reg [7:0] tagsWriteCmd_payload_address;
	reg [20:0] tagsWriteCmd_payload_data_address;
	reg tagsWriteCmd_payload_data_error;
	reg tagsWriteCmd_payload_data_valid;
	reg [1:0] tagsWriteCmd_payload_way;
	reg tagsWriteCmd_valid;
	reg [7:0] tagsWriteLastCmd_payload_address;
	reg [20:0] tagsWriteLastCmd_payload_data_address;
	reg tagsWriteLastCmd_payload_data_error;
	reg tagsWriteLastCmd_payload_data_valid;
	reg [1:0] tagsWriteLastCmd_payload_way;
	reg tagsWriteLastCmd_valid;
	wire [63:0] ways_0_dataReadRsp;
	wire [63:0] ways_0_dataReadRspMem;
	reg [7:0] ways_0_data_symbol0 [0:255];
	reg [7:0] ways_0_data_symbol1 [0:255];
	reg [7:0] ways_0_data_symbol2 [0:255];
	reg [7:0] ways_0_data_symbol3 [0:255];
	reg [7:0] ways_0_data_symbol4 [0:255];
	reg [7:0] ways_0_data_symbol5 [0:255];
	reg [7:0] ways_0_data_symbol6 [0:255];
	reg [7:0] ways_0_data_symbol7 [0:255];
	reg [22:0] ways_0_tags [0:255];
	wire [20:0] ways_0_tagsReadRsp_address;
	wire ways_0_tagsReadRsp_error;
	wire ways_0_tagsReadRsp_valid;
	wire [63:0] ways_1_dataReadRsp;
	wire [63:0] ways_1_dataReadRspMem;
	reg [7:0] ways_1_data_symbol0 [0:255];
	reg [7:0] ways_1_data_symbol1 [0:255];
	reg [7:0] ways_1_data_symbol2 [0:255];
	reg [7:0] ways_1_data_symbol3 [0:255];
	reg [7:0] ways_1_data_symbol4 [0:255];
	reg [7:0] ways_1_data_symbol5 [0:255];
	reg [7:0] ways_1_data_symbol6 [0:255];
	reg [7:0] ways_1_data_symbol7 [0:255];
	reg [22:0] ways_1_tags [0:255];
	wire [20:0] ways_1_tagsReadRsp_address;
	wire ways_1_tagsReadRsp_error;
	wire ways_1_tagsReadRsp_valid;
	wire when_DataCache_l1008;
	wire when_DataCache_l1013;
	wire when_DataCache_l1024;
	wire when_DataCache_l1036;
	wire when_DataCache_l1071;
	wire when_DataCache_l1080;
	wire when_DataCache_l1096;
	wire when_DataCache_l1124;
	wire when_DataCache_l1128;
	wire when_DataCache_l1131;
	wire when_DataCache_l644;
	wire when_DataCache_l644_1;
	wire when_DataCache_l647;
	wire when_DataCache_l647_1;
	wire when_DataCache_l666;
	wire when_DataCache_l688;
	wire when_DataCache_l775;
	wire when_DataCache_l775_1;
	wire when_DataCache_l775_2;
	wire when_DataCache_l775_3;
	wire when_DataCache_l824;
	wire when_DataCache_l824_1;
	wire when_DataCache_l824_2;
	wire when_DataCache_l824_3;
	wire when_DataCache_l824_4;
	wire when_DataCache_l825;
	wire when_DataCache_l825_1;
	wire when_DataCache_l825_2;
	wire when_DataCache_l825_3;
	wire when_DataCache_l826;
	wire when_DataCache_l828;
	wire when_DataCache_l854;
	wire when_DataCache_l860;
	wire when_DataCache_l862;
	wire when_DataCache_l876;
	wire when_DataCache_l930;
	wire when_DataCache_l995;
	wire when_DataCache_l999;
	assign _zz_when = 1'b1;
	assign haltCpu = 1'b0;
	assign io_cpu_writeBack_keepMemRspData = 1'b0;
	assign io_mem_cmd_payload_last = 1'b1;
	assign loader_counter_willClear = 1'b0;
	assign loader_counter_willOverflowIfInc = 1'b1;
	assign loader_kill = 1'b0;
	assign rspLast = 1'b1;
	assign rspSync = 1'b1;
	assign stage0_isAmo = 1'b0;
	assign stage0_wayInvalidate = 2'h0;
	assign stageA_isAmo = 1'b0;
	assign stageA_isLrsc = 1'b0;
	assign stageB_consistancyHazard = 1'b0;
	assign stageB_flusher_hold = 1'b0;
	assign stageB_isAmo = 1'b0;
	assign stageB_isAmoCached = 1'b0;
	assign stageB_isExternalAmo = 1'b0;
	assign stageB_isExternalLsrc = 1'b0;
	assign _zz_loader_waysAllocator = {loader_waysAllocator, loader_waysAllocator[1]};
	assign _zz_ways_0_tags_port = {tagsWriteCmd_payload_data_address, tagsWriteCmd_payload_data_error, tagsWriteCmd_payload_data_valid};
	assign _zz_ways_1_tags_port = {tagsWriteCmd_payload_data_address, tagsWriteCmd_payload_data_error, tagsWriteCmd_payload_data_valid};
	assign ways_0_tagsReadRsp_valid = _zz_ways_0_tagsReadRsp_valid_1[0];
	assign ways_0_tagsReadRsp_error = _zz_ways_0_tagsReadRsp_valid_1[1];
	assign ways_0_tagsReadRsp_address = _zz_ways_0_tagsReadRsp_valid_1[22:2];
	assign ways_1_tagsReadRsp_valid = _zz_ways_1_tagsReadRsp_valid_1[0];
	assign ways_1_tagsReadRsp_error = _zz_ways_1_tagsReadRsp_valid_1[1];
	assign ways_1_tagsReadRsp_address = _zz_ways_1_tagsReadRsp_valid_1[22:2];
	assign when_DataCache_l688 = ~|io_cpu_writeBack_isStuck;
	assign stage0_mask = _zz_stage0_mask << io_cpu_execute_address[2:0];
	assign _zz_stage0_dataColisions = io_cpu_execute_address[10:3];
	assign when_DataCache_l775 = ~|io_cpu_memory_isStuck;
	assign when_DataCache_l775_1 = ~|io_cpu_memory_isStuck;
	assign stageA_wayHits = {(io_cpu_memory_mmuRsp_physicalAddress[31:11] == ways_1_tagsReadRsp_address) & ways_1_tagsReadRsp_valid, (io_cpu_memory_mmuRsp_physicalAddress[31:11] == ways_0_tagsReadRsp_address) & ways_0_tagsReadRsp_valid};
	assign when_DataCache_l775_2 = ~|io_cpu_memory_isStuck;
	assign when_DataCache_l775_3 = ~|io_cpu_memory_isStuck;
	assign _zz_stageA_dataColisions_1 = io_cpu_memory_address[10:3];
	assign when_DataCache_l826 = ~|io_cpu_writeBack_isStuck;
	assign when_DataCache_l825 = ~|io_cpu_writeBack_isStuck;
	assign when_DataCache_l825_1 = ~|io_cpu_writeBack_isStuck;
	assign when_DataCache_l825_2 = ~|io_cpu_writeBack_isStuck;
	assign when_DataCache_l825_3 = ~|io_cpu_writeBack_isStuck;
	assign when_DataCache_l824 = ~|io_cpu_writeBack_isStuck;
	assign when_DataCache_l824_1 = ~|io_cpu_writeBack_isStuck;
	assign when_DataCache_l824_2 = ~|io_cpu_writeBack_isStuck;
	assign when_DataCache_l824_3 = ~|io_cpu_writeBack_isStuck;
	assign stageB_waysHit = |stageB_waysHits;
	assign stageB_dataMux = (stageB_waysHits[0] ? stageB_dataReadRsp_0 : stageB_dataReadRsp_1);
	assign when_DataCache_l824_4 = ~|io_cpu_writeBack_isStuck;
	assign when_DataCache_l854 = ~|stageB_flusher_counter[8];
	assign when_DataCache_l860 = ~|stageB_flusher_hold;
	assign when_DataCache_l999 = (~|stageB_request_wr ? io_mem_rsp_valid & rspSync : io_mem_cmd_ready);
	assign when_DataCache_l1036 = ~|memCmdSent;
	assign when_DataCache_l1124 = ~|loader_valid;
	assign _zz_ways_0_tagsReadRsp_valid = tagsReadCmd_valid & ~|io_cpu_memory_isStuck;
	assign _zz_ways_0_tagsReadRsp_valid_1 = _zz_ways_0_tags_port0;
	assign _zz_ways_0_dataReadRspMem = dataReadCmd_valid & ~|io_cpu_memory_isStuck;
	assign ways_0_dataReadRspMem = _zz_ways_0_data_port0;
	assign ways_0_dataReadRsp = ways_0_dataReadRspMem;
	assign when_DataCache_l644 = tagsWriteCmd_valid & tagsWriteCmd_payload_way[0];
	assign when_DataCache_l647 = dataWriteCmd_valid & dataWriteCmd_payload_way[0];
	assign _zz_ways_1_tagsReadRsp_valid = tagsReadCmd_valid & ~|io_cpu_memory_isStuck;
	assign _zz_ways_1_tagsReadRsp_valid_1 = _zz_ways_1_tags_port0;
	assign _zz_ways_1_dataReadRspMem = dataReadCmd_valid & ~|io_cpu_memory_isStuck;
	assign ways_1_dataReadRspMem = _zz_ways_1_data_port0;
	assign ways_1_dataReadRsp = ways_1_dataReadRspMem;
	assign when_DataCache_l644_1 = tagsWriteCmd_valid & tagsWriteCmd_payload_way[1];
	assign when_DataCache_l647_1 = dataWriteCmd_valid & dataWriteCmd_payload_way[1];
	assign when_DataCache_l666 = io_cpu_execute_isValid & ~|io_cpu_memory_isStuck;
	assign io_mem_cmd_fire = io_mem_cmd_valid & io_mem_cmd_ready;
	assign _zz_stage0_dataColisions_1 = dataWriteCmd_payload_mask;
	assign io_cpu_memory_isWrite = stageA_request_wr;
	assign _zz_stageA_dataColisions_2 = dataWriteCmd_payload_mask;
	assign stageA_dataColisions = stage0_dataColisions_regNextWhen | _zz_stageA_dataColisions;
	assign when_DataCache_l828 = ~|io_cpu_writeBack_isStuck & ~|stageB_mmuRspFreeze;
	assign stageB_waysHits = stageB_waysHitsBeforeInvalidate & ~stageB_wayInvalidate;
	assign stageB_ioMemRspMuxed = io_mem_rsp_payload_data;
	assign when_DataCache_l862 = io_cpu_flush_valid & io_cpu_flush_payload_singleLine;
	assign io_cpu_flush_ready = stageB_flusher_waitDone & stageB_flusher_counter[8];
	assign when_DataCache_l876 = io_cpu_flush_valid & io_cpu_flush_payload_singleLine;
	assign stageB_requestDataBypass = io_cpu_writeBack_storeData;
	assign when_DataCache_l930 = stageB_request_wr & stageB_waysHit;
	assign stageB_badPermissions = (~|stageB_mmuRsp_allowWrite & stageB_request_wr) | (~|stageB_mmuRsp_allowRead & (~|stageB_request_wr | stageB_isAmo));
	assign stageB_loadStoreFault = io_cpu_writeBack_isValid & (stageB_mmuRsp_exception | stageB_badPermissions);
	assign io_cpu_writeBack_mmuException = stageB_loadStoreFault & stageB_mmuRsp_isPaging;
	assign io_cpu_writeBack_unalignedAccess = io_cpu_writeBack_isValid & stageB_unaligned;
	assign io_cpu_writeBack_isWrite = stageB_request_wr;
	assign io_mem_cmd_payload_mask = stageB_mask;
	assign io_mem_cmd_payload_data = stageB_requestDataBypass;
	assign io_mem_cmd_payload_uncached = stageB_mmuRsp_isIoAccess;
	assign stageB_bypassCache = (stageB_mmuRsp_isIoAccess | stageB_isExternalLsrc) | stageB_isExternalAmo;
	assign when_DataCache_l1008 = stageB_waysHit | (stageB_request_wr & ~|stageB_isAmoCached);
	assign when_DataCache_l1013 = ~|stageB_request_wr | io_mem_cmd_ready;
	assign when_DataCache_l1024 = (~|stageB_request_wr | stageB_isAmoCached) & ((stageB_dataColisions & stageB_waysHits) != 2'h0);
	assign when_DataCache_l995 = stageB_mmuRsp_isIoAccess | stageB_isExternalLsrc;
	assign when_DataCache_l1071 = (((stageB_consistancyHazard | stageB_mmuRsp_refilling) | io_cpu_writeBack_accessError) | io_cpu_writeBack_mmuException) | io_cpu_writeBack_unalignedAccess;
	assign when_DataCache_l1080 = stageB_mmuRsp_refilling | stageB_consistancyHazard;
	assign loader_counter_willOverflow = loader_counter_willOverflowIfInc & loader_counter_willIncrement;
	assign when_DataCache_l1096 = (loader_valid & io_mem_rsp_valid) & rspLast;
	assign loader_done = loader_counter_willOverflow;
	assign when_DataCache_l1128 = loader_valid & ~|loader_valid_regNext;
	assign io_cpu_execute_refilling = loader_valid;
	assign when_DataCache_l1131 = stageB_loaderValid | loader_valid;
	always @(posedge clk)
		if (_zz_ways_0_tagsReadRsp_valid)
			_zz_ways_0_tags_port0 <= ways_0_tags[tagsReadCmd_payload];
	always @(posedge clk)
		if (_zz_4)
			ways_0_tags[tagsWriteCmd_payload_address] <= _zz_ways_0_tags_port;
	always @(_zz_ways_0_datasymbol_read_7 or _zz_ways_0_datasymbol_read_6 or _zz_ways_0_datasymbol_read_5 or _zz_ways_0_datasymbol_read_4 or _zz_ways_0_datasymbol_read_3 or _zz_ways_0_datasymbol_read_2 or _zz_ways_0_datasymbol_read_1 or _zz_ways_0_datasymbol_read) _zz_ways_0_data_port0 = {_zz_ways_0_datasymbol_read_7, _zz_ways_0_datasymbol_read_6, _zz_ways_0_datasymbol_read_5, _zz_ways_0_datasymbol_read_4, _zz_ways_0_datasymbol_read_3, _zz_ways_0_datasymbol_read_2, _zz_ways_0_datasymbol_read_1, _zz_ways_0_datasymbol_read};
	always @(posedge clk)
		if (_zz_ways_0_dataReadRspMem) begin
			_zz_ways_0_datasymbol_read <= ways_0_data_symbol0[dataReadCmd_payload];
			_zz_ways_0_datasymbol_read_1 <= ways_0_data_symbol1[dataReadCmd_payload];
			_zz_ways_0_datasymbol_read_2 <= ways_0_data_symbol2[dataReadCmd_payload];
			_zz_ways_0_datasymbol_read_3 <= ways_0_data_symbol3[dataReadCmd_payload];
			_zz_ways_0_datasymbol_read_4 <= ways_0_data_symbol4[dataReadCmd_payload];
			_zz_ways_0_datasymbol_read_5 <= ways_0_data_symbol5[dataReadCmd_payload];
			_zz_ways_0_datasymbol_read_6 <= ways_0_data_symbol6[dataReadCmd_payload];
			_zz_ways_0_datasymbol_read_7 <= ways_0_data_symbol7[dataReadCmd_payload];
		end
	always @(posedge clk) begin
		if (dataWriteCmd_payload_mask[0] && _zz_3)
			ways_0_data_symbol0[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[7:0];
		if (dataWriteCmd_payload_mask[1] && _zz_3)
			ways_0_data_symbol1[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[15:8];
		if (dataWriteCmd_payload_mask[2] && _zz_3)
			ways_0_data_symbol2[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[23:16];
		if (dataWriteCmd_payload_mask[3] && _zz_3)
			ways_0_data_symbol3[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[31:24];
		if (dataWriteCmd_payload_mask[4] && _zz_3)
			ways_0_data_symbol4[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[39:32];
		if (dataWriteCmd_payload_mask[5] && _zz_3)
			ways_0_data_symbol5[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[47:40];
		if (dataWriteCmd_payload_mask[6] && _zz_3)
			ways_0_data_symbol6[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[55:48];
		if (dataWriteCmd_payload_mask[7] && _zz_3)
			ways_0_data_symbol7[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[63:56];
	end
	always @(posedge clk)
		if (_zz_ways_1_tagsReadRsp_valid)
			_zz_ways_1_tags_port0 <= ways_1_tags[tagsReadCmd_payload];
	always @(posedge clk)
		if (_zz_2)
			ways_1_tags[tagsWriteCmd_payload_address] <= _zz_ways_1_tags_port;
	always @(_zz_ways_1_datasymbol_read_7 or _zz_ways_1_datasymbol_read_6 or _zz_ways_1_datasymbol_read_5 or _zz_ways_1_datasymbol_read_4 or _zz_ways_1_datasymbol_read_3 or _zz_ways_1_datasymbol_read_2 or _zz_ways_1_datasymbol_read_1 or _zz_ways_1_datasymbol_read) _zz_ways_1_data_port0 = {_zz_ways_1_datasymbol_read_7, _zz_ways_1_datasymbol_read_6, _zz_ways_1_datasymbol_read_5, _zz_ways_1_datasymbol_read_4, _zz_ways_1_datasymbol_read_3, _zz_ways_1_datasymbol_read_2, _zz_ways_1_datasymbol_read_1, _zz_ways_1_datasymbol_read};
	always @(posedge clk)
		if (_zz_ways_1_dataReadRspMem) begin
			_zz_ways_1_datasymbol_read <= ways_1_data_symbol0[dataReadCmd_payload];
			_zz_ways_1_datasymbol_read_1 <= ways_1_data_symbol1[dataReadCmd_payload];
			_zz_ways_1_datasymbol_read_2 <= ways_1_data_symbol2[dataReadCmd_payload];
			_zz_ways_1_datasymbol_read_3 <= ways_1_data_symbol3[dataReadCmd_payload];
			_zz_ways_1_datasymbol_read_4 <= ways_1_data_symbol4[dataReadCmd_payload];
			_zz_ways_1_datasymbol_read_5 <= ways_1_data_symbol5[dataReadCmd_payload];
			_zz_ways_1_datasymbol_read_6 <= ways_1_data_symbol6[dataReadCmd_payload];
			_zz_ways_1_datasymbol_read_7 <= ways_1_data_symbol7[dataReadCmd_payload];
		end
	always @(posedge clk) begin
		if (dataWriteCmd_payload_mask[0] && _zz_1)
			ways_1_data_symbol0[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[7:0];
		if (dataWriteCmd_payload_mask[1] && _zz_1)
			ways_1_data_symbol1[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[15:8];
		if (dataWriteCmd_payload_mask[2] && _zz_1)
			ways_1_data_symbol2[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[23:16];
		if (dataWriteCmd_payload_mask[3] && _zz_1)
			ways_1_data_symbol3[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[31:24];
		if (dataWriteCmd_payload_mask[4] && _zz_1)
			ways_1_data_symbol4[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[39:32];
		if (dataWriteCmd_payload_mask[5] && _zz_1)
			ways_1_data_symbol5[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[47:40];
		if (dataWriteCmd_payload_mask[6] && _zz_1)
			ways_1_data_symbol6[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[55:48];
		if (dataWriteCmd_payload_mask[7] && _zz_1)
			ways_1_data_symbol7[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[63:56];
	end
	always @(when_DataCache_l647_1) begin
		_zz_1 = 1'b0;
		if (when_DataCache_l647_1)
			_zz_1 = 1'b1;
	end
	always @(when_DataCache_l644_1) begin
		_zz_2 = 1'b0;
		if (when_DataCache_l644_1)
			_zz_2 = 1'b1;
	end
	always @(when_DataCache_l647) begin
		_zz_3 = 1'b0;
		if (when_DataCache_l647)
			_zz_3 = 1'b1;
	end
	always @(when_DataCache_l644) begin
		_zz_4 = 1'b0;
		if (when_DataCache_l644)
			_zz_4 = 1'b1;
	end
	always @(when_DataCache_l666) begin
		tagsReadCmd_valid = 1'b0;
		if (when_DataCache_l666)
			tagsReadCmd_valid = 1'b1;
	end
	always @(when_DataCache_l666 or io_cpu_execute_address) begin
		tagsReadCmd_payload = 8'bxxxxxxxx;
		if (when_DataCache_l666)
			tagsReadCmd_payload = io_cpu_execute_address[10:3];
	end
	always @(when_DataCache_l666) begin
		dataReadCmd_valid = 1'b0;
		if (when_DataCache_l666)
			dataReadCmd_valid = 1'b1;
	end
	always @(when_DataCache_l666 or io_cpu_execute_address) begin
		dataReadCmd_payload = 8'bxxxxxxxx;
		if (when_DataCache_l666)
			dataReadCmd_payload = io_cpu_execute_address[10:3];
	end
	always @(when_DataCache_l854 or io_cpu_writeBack_isValid or when_DataCache_l1071 or loader_done) begin
		tagsWriteCmd_valid = 1'b0;
		if (when_DataCache_l854)
			tagsWriteCmd_valid = 1'b1;
		if (io_cpu_writeBack_isValid) begin
			if (when_DataCache_l1071)
				tagsWriteCmd_valid = 1'b0;
		end
		if (loader_done)
			tagsWriteCmd_valid = 1'b1;
	end
	always @(when_DataCache_l854 or loader_done or loader_waysAllocator) begin
		tagsWriteCmd_payload_way = 2'bxx;
		if (when_DataCache_l854)
			tagsWriteCmd_payload_way = 2'h3;
		if (loader_done)
			tagsWriteCmd_payload_way = loader_waysAllocator;
	end
	always @(when_DataCache_l854 or stageB_flusher_counter or loader_done or stageB_mmuRsp_physicalAddress) begin
		tagsWriteCmd_payload_address = 8'bxxxxxxxx;
		if (when_DataCache_l854)
			tagsWriteCmd_payload_address = stageB_flusher_counter[7:0];
		if (loader_done)
			tagsWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[10:3];
	end
	always @(when_DataCache_l854 or loader_done or loader_kill or loader_killReg) begin
		tagsWriteCmd_payload_data_valid = 1'bx;
		if (when_DataCache_l854)
			tagsWriteCmd_payload_data_valid = 1'b0;
		if (loader_done)
			tagsWriteCmd_payload_data_valid = !(loader_kill || loader_killReg);
	end
	always @(loader_done or loader_error or io_mem_rsp_valid or io_mem_rsp_payload_error) begin
		tagsWriteCmd_payload_data_error = 1'bx;
		if (loader_done)
			tagsWriteCmd_payload_data_error = loader_error || (io_mem_rsp_valid && io_mem_rsp_payload_error);
	end
	always @(loader_done or stageB_mmuRsp_physicalAddress) begin
		tagsWriteCmd_payload_data_address = 21'bxxxxxxxxxxxxxxxxxxxxx;
		if (loader_done)
			tagsWriteCmd_payload_data_address = stageB_mmuRsp_physicalAddress[31:11];
	end
	always @(stageB_cpuWriteToCache or when_DataCache_l930 or io_cpu_writeBack_isValid or when_DataCache_l1071 or when_DataCache_l1096) begin
		dataWriteCmd_valid = 1'b0;
		if (stageB_cpuWriteToCache) begin
			if (when_DataCache_l930)
				dataWriteCmd_valid = 1'b1;
		end
		if (io_cpu_writeBack_isValid) begin
			if (when_DataCache_l1071)
				dataWriteCmd_valid = 1'b0;
		end
		if (when_DataCache_l1096)
			dataWriteCmd_valid = 1'b1;
	end
	always @(stageB_cpuWriteToCache or stageB_waysHits or when_DataCache_l1096 or loader_waysAllocator) begin
		dataWriteCmd_payload_way = 2'bxx;
		if (stageB_cpuWriteToCache)
			dataWriteCmd_payload_way = stageB_waysHits;
		if (when_DataCache_l1096)
			dataWriteCmd_payload_way = loader_waysAllocator;
	end
	always @(stageB_cpuWriteToCache or stageB_mmuRsp_physicalAddress or when_DataCache_l1096) begin
		dataWriteCmd_payload_address = 8'bxxxxxxxx;
		if (stageB_cpuWriteToCache)
			dataWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[10:3];
		if (when_DataCache_l1096)
			dataWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[10:3];
	end
	always @(stageB_cpuWriteToCache or stageB_requestDataBypass or when_DataCache_l1096 or io_mem_rsp_payload_data) begin
		dataWriteCmd_payload_data = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		if (stageB_cpuWriteToCache)
			dataWriteCmd_payload_data = stageB_requestDataBypass;
		if (when_DataCache_l1096)
			dataWriteCmd_payload_data = io_mem_rsp_payload_data;
	end
	always @(stageB_cpuWriteToCache or _zz_when or stageB_mask or when_DataCache_l1096) begin
		dataWriteCmd_payload_mask = 8'bxxxxxxxx;
		if (stageB_cpuWriteToCache) begin
			dataWriteCmd_payload_mask = 8'h00;
			if (_zz_when)
				dataWriteCmd_payload_mask = stageB_mask;
		end
		if (when_DataCache_l1096)
			dataWriteCmd_payload_mask = 8'hff;
	end
	always @(when_DataCache_l854) begin
		io_cpu_execute_haltIt = 1'b0;
		if (when_DataCache_l854)
			io_cpu_execute_haltIt = 1'b1;
	end
	always @(io_cpu_execute_args_size) begin
		_zz_stage0_mask = 8'bxxxxxxxx;
		case (io_cpu_execute_args_size)
			2'h0: _zz_stage0_mask = 8'h01;
			2'h1: _zz_stage0_mask = 8'h03;
			2'h2: _zz_stage0_mask = 8'h0f;
			default: _zz_stage0_mask = 8'hff;
		endcase
	end
	always @(dataWriteCmd_valid or dataWriteCmd_payload_way or dataWriteCmd_payload_address or _zz_stage0_dataColisions or stage0_mask or _zz_stage0_dataColisions_1) begin
		stage0_dataColisions[0] = ((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && (dataWriteCmd_payload_address == _zz_stage0_dataColisions)) && ((stage0_mask & _zz_stage0_dataColisions_1) != 8'h00);
		stage0_dataColisions[1] = ((dataWriteCmd_valid && dataWriteCmd_payload_way[1]) && (dataWriteCmd_payload_address == _zz_stage0_dataColisions)) && ((stage0_mask & _zz_stage0_dataColisions_1) != 8'h00);
	end
	always @(dataWriteCmd_valid or dataWriteCmd_payload_way or dataWriteCmd_payload_address or _zz_stageA_dataColisions_1 or stageA_mask or _zz_stageA_dataColisions_2) begin
		_zz_stageA_dataColisions[0] = ((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && (dataWriteCmd_payload_address == _zz_stageA_dataColisions_1)) && ((stageA_mask & _zz_stageA_dataColisions_2) != 8'h00);
		_zz_stageA_dataColisions[1] = ((dataWriteCmd_valid && dataWriteCmd_payload_way[1]) && (dataWriteCmd_payload_address == _zz_stageA_dataColisions_1)) && ((stageA_mask & _zz_stageA_dataColisions_2) != 8'h00);
	end
	always @(when_DataCache_l1131) begin
		stageB_mmuRspFreeze = 1'b0;
		if (when_DataCache_l1131)
			stageB_mmuRspFreeze = 1'b1;
	end
	always @(io_cpu_writeBack_isValid or stageB_isExternalAmo or when_DataCache_l995 or when_DataCache_l1008 or io_mem_cmd_ready or when_DataCache_l1071) begin
		stageB_loaderValid = 1'b0;
		if (io_cpu_writeBack_isValid) begin
			if (!stageB_isExternalAmo) begin
				if (!when_DataCache_l995) begin
					if (!when_DataCache_l1008) begin
						if (io_mem_cmd_ready)
							stageB_loaderValid = 1'b1;
					end
				end
			end
		end
		if (io_cpu_writeBack_isValid) begin
			if (when_DataCache_l1071)
				stageB_loaderValid = 1'b0;
		end
	end
	always @(io_cpu_writeBack_isValid or stageB_isExternalAmo or when_DataCache_l995 or when_DataCache_l999 or when_DataCache_l1008 or when_DataCache_l1013 or when_DataCache_l1071) begin
		io_cpu_writeBack_haltIt = 1'b1;
		if (io_cpu_writeBack_isValid) begin
			if (!stageB_isExternalAmo) begin
				if (when_DataCache_l995) begin
					if (when_DataCache_l999)
						io_cpu_writeBack_haltIt = 1'b0;
				end
				else if (when_DataCache_l1008) begin
					if (when_DataCache_l1013)
						io_cpu_writeBack_haltIt = 1'b0;
				end
			end
		end
		if (io_cpu_writeBack_isValid) begin
			if (when_DataCache_l1071)
				io_cpu_writeBack_haltIt = 1'b0;
		end
	end
	always @(io_cpu_writeBack_isValid or stageB_isExternalAmo or when_DataCache_l995 or when_DataCache_l1008) begin
		stageB_cpuWriteToCache = 1'b0;
		if (io_cpu_writeBack_isValid) begin
			if (!stageB_isExternalAmo) begin
				if (!when_DataCache_l995) begin
					if (when_DataCache_l1008)
						stageB_cpuWriteToCache = 1'b1;
				end
			end
		end
	end
	always @(io_cpu_writeBack_isValid or stageB_isExternalAmo or when_DataCache_l995 or when_DataCache_l1008 or when_DataCache_l1024 or when_DataCache_l1080 or when_DataCache_l1128) begin
		io_cpu_redo = 1'b0;
		if (io_cpu_writeBack_isValid) begin
			if (!stageB_isExternalAmo) begin
				if (!when_DataCache_l995) begin
					if (when_DataCache_l1008) begin
						if (when_DataCache_l1024)
							io_cpu_redo = 1'b1;
					end
				end
			end
		end
		if (io_cpu_writeBack_isValid) begin
			if (when_DataCache_l1080)
				io_cpu_redo = 1'b1;
		end
		if (when_DataCache_l1128)
			io_cpu_redo = 1'b1;
	end
	always @(stageB_bypassCache or stageB_request_wr or io_mem_rsp_valid or io_mem_rsp_payload_error or stageB_waysHits or stageB_tagsReadRsp_1_error or stageB_tagsReadRsp_0_error or stageB_loadStoreFault or stageB_mmuRsp_isPaging) begin
		io_cpu_writeBack_accessError = 1'b0;
		if (stageB_bypassCache)
			io_cpu_writeBack_accessError = ((!stageB_request_wr && 1'b1) && io_mem_rsp_valid) && io_mem_rsp_payload_error;
		else
			io_cpu_writeBack_accessError = ((stageB_waysHits & {stageB_tagsReadRsp_1_error, stageB_tagsReadRsp_0_error}) != 2'h0) || (stageB_loadStoreFault && !stageB_mmuRsp_isPaging);
	end
	always @(io_cpu_writeBack_isValid or stageB_isExternalAmo or when_DataCache_l995 or memCmdSent or when_DataCache_l1008 or stageB_request_wr or when_DataCache_l1036 or when_DataCache_l1071) begin
		io_mem_cmd_valid = 1'b0;
		if (io_cpu_writeBack_isValid) begin
			if (!stageB_isExternalAmo) begin
				if (when_DataCache_l995)
					io_mem_cmd_valid = !memCmdSent;
				else if (when_DataCache_l1008) begin
					if (stageB_request_wr)
						io_mem_cmd_valid = 1'b1;
				end
				else if (when_DataCache_l1036)
					io_mem_cmd_valid = 1'b1;
			end
		end
		if (io_cpu_writeBack_isValid) begin
			if (when_DataCache_l1071)
				io_mem_cmd_valid = 1'b0;
		end
	end
	always @(stageB_mmuRsp_physicalAddress or io_cpu_writeBack_isValid or stageB_isExternalAmo or when_DataCache_l995 or when_DataCache_l1008) begin
		io_mem_cmd_payload_address = stageB_mmuRsp_physicalAddress;
		if (io_cpu_writeBack_isValid) begin
			if (!stageB_isExternalAmo) begin
				if (!when_DataCache_l995) begin
					if (!when_DataCache_l1008)
						io_mem_cmd_payload_address[2:0] = 3'h0;
				end
			end
		end
	end
	always @(stageB_request_wr or io_cpu_writeBack_isValid or stageB_isExternalAmo or when_DataCache_l995 or when_DataCache_l1008) begin
		io_mem_cmd_payload_wr = stageB_request_wr;
		if (io_cpu_writeBack_isValid) begin
			if (!stageB_isExternalAmo) begin
				if (!when_DataCache_l995) begin
					if (!when_DataCache_l1008)
						io_mem_cmd_payload_wr = 1'b0;
				end
			end
		end
	end
	always @(stageB_request_size or io_cpu_writeBack_isValid or stageB_isExternalAmo or when_DataCache_l995 or when_DataCache_l1008) begin
		io_mem_cmd_payload_size = stageB_request_size;
		if (io_cpu_writeBack_isValid) begin
			if (!stageB_isExternalAmo) begin
				if (!when_DataCache_l995) begin
					if (!when_DataCache_l1008)
						io_mem_cmd_payload_size = 2'h3;
				end
			end
		end
	end
	always @(stageB_bypassCache or stageB_ioMemRspMuxed or stageB_dataMux)
		if (stageB_bypassCache)
			io_cpu_writeBack_data = stageB_ioMemRspMuxed;
		else
			io_cpu_writeBack_data = stageB_dataMux;
	always @(when_DataCache_l1096) begin
		loader_counter_willIncrement = 1'b0;
		if (when_DataCache_l1096)
			loader_counter_willIncrement = 1'b1;
	end
	always @(posedge clk) begin
		tagsWriteLastCmd_valid <= tagsWriteCmd_valid;
		tagsWriteLastCmd_payload_way <= tagsWriteCmd_payload_way;
		tagsWriteLastCmd_payload_address <= tagsWriteCmd_payload_address;
		tagsWriteLastCmd_payload_data_valid <= tagsWriteCmd_payload_data_valid;
		tagsWriteLastCmd_payload_data_error <= tagsWriteCmd_payload_data_error;
		tagsWriteLastCmd_payload_data_address <= tagsWriteCmd_payload_data_address;
		if (when_DataCache_l775) begin
			stageA_request_wr <= io_cpu_execute_args_wr;
			stageA_request_size <= io_cpu_execute_args_size;
			stageA_request_totalyConsistent <= io_cpu_execute_args_totalyConsistent;
		end
		if (when_DataCache_l775_1)
			stageA_mask <= stage0_mask;
		if (when_DataCache_l775_2)
			stageA_wayInvalidate <= stage0_wayInvalidate;
		if (when_DataCache_l775_3)
			stage0_dataColisions_regNextWhen <= stage0_dataColisions;
		if (when_DataCache_l826) begin
			stageB_request_wr <= stageA_request_wr;
			stageB_request_size <= stageA_request_size;
			stageB_request_totalyConsistent <= stageA_request_totalyConsistent;
		end
		if (when_DataCache_l828) begin
			stageB_mmuRsp_physicalAddress <= io_cpu_memory_mmuRsp_physicalAddress;
			stageB_mmuRsp_isIoAccess <= io_cpu_memory_mmuRsp_isIoAccess;
			stageB_mmuRsp_isPaging <= io_cpu_memory_mmuRsp_isPaging;
			stageB_mmuRsp_allowRead <= io_cpu_memory_mmuRsp_allowRead;
			stageB_mmuRsp_allowWrite <= io_cpu_memory_mmuRsp_allowWrite;
			stageB_mmuRsp_allowExecute <= io_cpu_memory_mmuRsp_allowExecute;
			stageB_mmuRsp_exception <= io_cpu_memory_mmuRsp_exception;
			stageB_mmuRsp_refilling <= io_cpu_memory_mmuRsp_refilling;
			stageB_mmuRsp_bypassTranslation <= io_cpu_memory_mmuRsp_bypassTranslation;
			stageB_mmuRsp_ways_0_sel <= io_cpu_memory_mmuRsp_ways_0_sel;
			stageB_mmuRsp_ways_0_physical <= io_cpu_memory_mmuRsp_ways_0_physical;
			stageB_mmuRsp_ways_1_sel <= io_cpu_memory_mmuRsp_ways_1_sel;
			stageB_mmuRsp_ways_1_physical <= io_cpu_memory_mmuRsp_ways_1_physical;
			stageB_mmuRsp_ways_2_sel <= io_cpu_memory_mmuRsp_ways_2_sel;
			stageB_mmuRsp_ways_2_physical <= io_cpu_memory_mmuRsp_ways_2_physical;
			stageB_mmuRsp_ways_3_sel <= io_cpu_memory_mmuRsp_ways_3_sel;
			stageB_mmuRsp_ways_3_physical <= io_cpu_memory_mmuRsp_ways_3_physical;
		end
		if (when_DataCache_l825) begin
			stageB_tagsReadRsp_0_valid <= ways_0_tagsReadRsp_valid;
			stageB_tagsReadRsp_0_error <= ways_0_tagsReadRsp_error;
			stageB_tagsReadRsp_0_address <= ways_0_tagsReadRsp_address;
		end
		if (when_DataCache_l825_1) begin
			stageB_tagsReadRsp_1_valid <= ways_1_tagsReadRsp_valid;
			stageB_tagsReadRsp_1_error <= ways_1_tagsReadRsp_error;
			stageB_tagsReadRsp_1_address <= ways_1_tagsReadRsp_address;
		end
		if (when_DataCache_l825_2)
			stageB_dataReadRsp_0 <= ways_0_dataReadRsp;
		if (when_DataCache_l825_3)
			stageB_dataReadRsp_1 <= ways_1_dataReadRsp;
		if (when_DataCache_l824)
			stageB_wayInvalidate <= stageA_wayInvalidate;
		if (when_DataCache_l824_1)
			stageB_dataColisions <= stageA_dataColisions;
		if (when_DataCache_l824_2)
			stageB_unaligned <= {(stageA_request_size == 2'h3) && (io_cpu_memory_address[2:0] != 3'h0), (stageA_request_size == 2'h2) && (io_cpu_memory_address[1:0] != 2'h0), (stageA_request_size == 2'h1) && (io_cpu_memory_address[0] != 1'b0)} != 3'h0;
		if (when_DataCache_l824_3)
			stageB_waysHitsBeforeInvalidate <= stageA_wayHits;
		if (when_DataCache_l824_4)
			stageB_mask <= stageA_mask;
		loader_valid_regNext <= loader_valid;
	end
	always @(posedge reset or posedge clk)
		if (reset) begin
			memCmdSent <= 1'b0;
			stageB_flusher_waitDone <= 1'b0;
			stageB_flusher_counter <= 9'h000;
			stageB_flusher_start <= 1'b1;
			loader_valid <= 1'b0;
			loader_waysAllocator <= 2'h1;
			loader_error <= 1'b0;
			loader_killReg <= 1'b0;
		end
		else begin
			if (io_mem_cmd_fire)
				memCmdSent <= 1'b1;
			if (when_DataCache_l688)
				memCmdSent <= 1'b0;
			if (io_cpu_flush_ready)
				stageB_flusher_waitDone <= 1'b0;
			if (when_DataCache_l854) begin
				if (when_DataCache_l860) begin
					stageB_flusher_counter <= stageB_flusher_counter + 9'h001;
					if (when_DataCache_l862)
						stageB_flusher_counter[8] <= 1'b1;
				end
			end
			stageB_flusher_start <= (((((!stageB_flusher_waitDone && !stageB_flusher_start) && io_cpu_flush_valid) && !io_cpu_execute_isValid) && !io_cpu_memory_isValid) && !io_cpu_writeBack_isValid) && !io_cpu_redo;
			if (stageB_flusher_start) begin
				stageB_flusher_waitDone <= 1'b1;
				stageB_flusher_counter <= 9'h000;
				if (when_DataCache_l876)
					stageB_flusher_counter <= {1'b0, io_cpu_flush_payload_lineId};
			end
			if (stageB_loaderValid)
				loader_valid <= 1'b1;
			if (loader_kill)
				loader_killReg <= 1'b1;
			if (when_DataCache_l1096)
				loader_error <= loader_error || io_mem_rsp_payload_error;
			if (loader_done) begin
				loader_valid <= 1'b0;
				loader_error <= 1'b0;
				loader_killReg <= 1'b0;
			end
			if (when_DataCache_l1124)
				loader_waysAllocator <= _zz_loader_waysAllocator[1:0];
		end
endmodule
module StreamArbiter_VexRiscv_FpuPlugin_fpu_cmdArbiter_arbiter  (
	io_inputs_0_valid,
	io_inputs_0_ready,
	io_inputs_0_payload_opcode,
	io_inputs_0_payload_arg,
	io_inputs_0_payload_rs1,
	io_inputs_0_payload_rs2,
	io_inputs_0_payload_rs3,
	io_inputs_0_payload_rd,
	io_inputs_0_payload_format,
	io_inputs_0_payload_roundMode,
	io_output_valid,
	io_output_ready,
	io_output_payload_opcode,
	io_output_payload_arg,
	io_output_payload_rs1,
	io_output_payload_rs2,
	io_output_payload_rs3,
	io_output_payload_rd,
	io_output_payload_format,
	io_output_payload_roundMode,
	io_chosenOH,
	clk,
	reset
);
	input io_inputs_0_valid;
	output io_inputs_0_ready;
	input [3:0] io_inputs_0_payload_opcode;
	input [1:0] io_inputs_0_payload_arg;
	input [4:0] io_inputs_0_payload_rs1;
	input [4:0] io_inputs_0_payload_rs2;
	input [4:0] io_inputs_0_payload_rs3;
	input [4:0] io_inputs_0_payload_rd;
	input io_inputs_0_payload_format;
	input [2:0] io_inputs_0_payload_roundMode;
	output io_output_valid;
	input io_output_ready;
	output [3:0] io_output_payload_opcode;
	output [1:0] io_output_payload_arg;
	output [4:0] io_output_payload_rs1;
	output [4:0] io_output_payload_rs2;
	output [4:0] io_output_payload_rs3;
	output [4:0] io_output_payload_rd;
	output io_output_payload_format;
	output [2:0] io_output_payload_roundMode;
	output io_chosenOH;
	input clk;
	input reset;
	parameter FpuFormat_DOUBLE = 1'b1;
	parameter FpuFormat_FLOAT = 1'b0;
	parameter FpuOpcode_ADD = 4'h3;
	parameter FpuOpcode_CMP = 4'h7;
	parameter FpuOpcode_DIV = 4'h8;
	parameter FpuOpcode_F2I = 4'h6;
	parameter FpuOpcode_FCLASS = 4'he;
	parameter FpuOpcode_FCVT_X_X = 4'hf;
	parameter FpuOpcode_FMA = 4'h4;
	parameter FpuOpcode_FMV_W_X = 4'hd;
	parameter FpuOpcode_FMV_X_W = 4'hc;
	parameter FpuOpcode_I2F = 4'h5;
	parameter FpuOpcode_LOAD = 4'h0;
	parameter FpuOpcode_MIN_MAX = 4'ha;
	parameter FpuOpcode_MUL = 4'h2;
	parameter FpuOpcode_SGNJ = 4'hb;
	parameter FpuOpcode_SQRT = 4'h9;
	parameter FpuOpcode_STORE = 4'h1;
	parameter FpuRoundMode_RDN = 3'h2;
	parameter FpuRoundMode_RMM = 3'h4;
	parameter FpuRoundMode_RNE = 3'h0;
	parameter FpuRoundMode_RTZ = 3'h1;
	parameter FpuRoundMode_RUP = 3'h3;
	wire [1:0] _zz__zz_maskProposal_0_2;
	wire [1:0] _zz__zz_maskProposal_0_2_1;
	wire _zz__zz_maskProposal_0_2_2;
	wire _zz_io_output_payload_format;
	wire [3:0] _zz_io_output_payload_opcode;
	wire [2:0] _zz_io_output_payload_roundMode;
	wire _zz_maskProposal_0;
	wire [1:0] _zz_maskProposal_0_1;
	wire [1:0] _zz_maskProposal_0_2;
	wire _zz_maskProposal_0_3;
	wire locked;
	reg maskLocked_0;
	wire maskProposal_0;
	wire maskRouted_0;
	assign locked = 1'b0;
	assign _zz__zz_maskProposal_0_2 = _zz_maskProposal_0_1 - _zz__zz_maskProposal_0_2_1;
	assign _zz__zz_maskProposal_0_2_1 = {1'b0, _zz__zz_maskProposal_0_2_2};
	assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
	assign _zz_maskProposal_0_1 = {2 {_zz_maskProposal_0}};
	assign _zz__zz_maskProposal_0_2_2 = maskLocked_0;
	assign _zz_maskProposal_0_3 = _zz_maskProposal_0_2[1] | _zz_maskProposal_0_2[0];
	assign _zz_maskProposal_0 = io_inputs_0_valid;
	assign _zz_maskProposal_0_2 = _zz_maskProposal_0_1 & ~_zz__zz_maskProposal_0_2;
	assign maskProposal_0 = _zz_maskProposal_0_3;
	assign io_output_valid = io_inputs_0_valid & maskRouted_0;
	assign _zz_io_output_payload_opcode = io_inputs_0_payload_opcode;
	assign _zz_io_output_payload_format = io_inputs_0_payload_format;
	assign _zz_io_output_payload_roundMode = io_inputs_0_payload_roundMode;
	assign io_output_payload_opcode = _zz_io_output_payload_opcode;
	assign io_output_payload_arg = io_inputs_0_payload_arg;
	assign io_output_payload_rs1 = io_inputs_0_payload_rs1;
	assign io_output_payload_rs2 = io_inputs_0_payload_rs2;
	assign io_output_payload_rs3 = io_inputs_0_payload_rs3;
	assign io_output_payload_rd = io_inputs_0_payload_rd;
	assign io_output_payload_format = _zz_io_output_payload_format;
	assign io_output_payload_roundMode = _zz_io_output_payload_roundMode;
	assign io_inputs_0_ready = maskRouted_0 & io_output_ready;
	assign io_chosenOH = maskRouted_0;
	always @(posedge reset or posedge clk)
		if (reset)
			maskLocked_0 <= 1'b1;
		else if (io_output_valid)
			maskLocked_0 <= maskRouted_0;
endmodule
module FpuDiv (
	io_input_valid,
	io_input_ready,
	io_input_payload_a,
	io_input_payload_b,
	io_output_valid,
	io_output_ready,
	io_output_payload_result,
	io_output_payload_remain,
	clk,
	reset
);
	input io_input_valid;
	output io_input_ready;
	input [51:0] io_input_payload_a;
	input [51:0] io_input_payload_b;
	output io_output_valid;
	input io_output_ready;
	output [54:0] io_output_payload_result;
	output [52:0] io_output_payload_remain;
	input clk;
	input reset;
	wire [52:0] _zz_div1;
	wire [54:0] _zz_div3;
	wire [53:0] _zz_div3_1;
	wire [53:0] _zz_div3_2;
	reg [54:0] _zz_shifter;
	wire [52:0] _zz_shifter_1;
	reg busy;
	reg [4:0] counter;
	reg [54:0] div1;
	wire [54:0] div2;
	reg [54:0] div3;
	reg done;
	wire io_output_fire;
	wire io_output_fire_1;
	reg [54:0] result;
	reg [54:0] shifter;
	wire [55:0] sub1;
	wire [55:0] sub2;
	wire [55:0] sub3;
	wire when_FpuDiv_l31;
	wire when_FpuDiv_l48;
	wire when_FpuDiv_l52;
	wire when_FpuDiv_l56;
	wire when_FpuDiv_l60;
	wire when_FpuDiv_l67;
	assign _zz_shifter_1 = {1'b1, io_input_payload_a};
	assign _zz_div1 = {1'b1, io_input_payload_b};
	assign _zz_div3_1 = {2'h1, io_input_payload_b};
	assign _zz_div3 = {1'b0, _zz_div3_1};
	assign _zz_div3_2 = {2'h1, io_input_payload_b, 1'b0};
	assign div2 = {div1[53:0], 1'b0};
	assign sub1 = {1'b0, shifter} - {1'b0, div1};
	assign sub2 = {1'b0, shifter} - {1'b0, div2};
	assign sub3 = {1'b0, shifter} - {1'b0, div3};
	assign io_output_payload_remain = {2'h0, shifter[54:2]};
	assign io_input_ready = ~|busy;
	assign when_FpuDiv_l48 = ~|done;
	assign when_FpuDiv_l52 = ~|sub1[55];
	assign when_FpuDiv_l56 = ~|sub2[55];
	assign when_FpuDiv_l60 = ~|sub3[55];
	assign when_FpuDiv_l67 = ~|busy;
	assign io_output_fire = io_output_valid & io_output_ready;
	assign when_FpuDiv_l31 = busy & (counter == 5'h1b);
	assign io_output_fire_1 = io_output_valid & io_output_ready;
	assign io_output_valid = done;
	assign io_output_payload_result = result;
	always @(shifter or when_FpuDiv_l52 or sub1 or when_FpuDiv_l56 or sub2 or when_FpuDiv_l60 or sub3) begin
		_zz_shifter = shifter;
		if (when_FpuDiv_l52)
			_zz_shifter = sub1[54:0];
		if (when_FpuDiv_l56)
			_zz_shifter = sub2[54:0];
		if (when_FpuDiv_l60)
			_zz_shifter = sub3[54:0];
	end
	always @(posedge reset or posedge clk)
		if (reset) begin
			busy <= 1'b0;
			done <= 1'b0;
		end
		else begin
			if (io_output_fire)
				busy <= 1'b0;
			if (when_FpuDiv_l31)
				done <= 1'b1;
			if (io_output_fire_1)
				done <= 1'b0;
			if (when_FpuDiv_l67)
				busy <= io_input_valid;
		end
	always @(posedge clk) begin
		if (when_FpuDiv_l48) begin
			counter <= counter + 5'h01;
			result <= result << 32'h00000002;
			if (when_FpuDiv_l52)
				result[1:0] <= 2'h1;
			if (when_FpuDiv_l56)
				result[1:0] <= 2'h2;
			if (when_FpuDiv_l60)
				result[1:0] <= 2'h3;
			shifter <= _zz_shifter << 32'h00000002;
		end
		if (when_FpuDiv_l67) begin
			counter <= 5'h00;
			shifter <= {2'h0, _zz_shifter_1};
			div1 <= {2'h0, _zz_div1};
			div3 <= _zz_div3 + {1'b0, _zz_div3_2};
		end
	end
endmodule
module FpuSqrt (
	io_input_valid,
	io_input_ready,
	io_input_payload_a,
	io_output_valid,
	io_output_ready,
	io_output_payload_result,
	io_output_payload_remain,
	clk,
	reset
);
	input io_input_valid;
	output io_input_ready;
	input [53:0] io_input_payload_a;
	output io_output_valid;
	input io_output_ready;
	output [52:0] io_output_payload_result;
	output [56:0] io_output_payload_remain;
	input clk;
	input reset;
	reg [56:0] _zz_a;
	wire [58:0] _zz_a_1;
	wire [1:0] _zz_a_2;
	wire [53:0] _zz_q;
	wire [56:0] _zz_t;
	wire [54:0] _zz_t_1;
	reg [56:0] a;
	reg busy;
	reg [5:0] counter;
	reg done;
	wire io_output_fire;
	wire io_output_fire_1;
	reg [52:0] q;
	wire [56:0] t;
	wire when_FpuSqrt_l28;
	wire when_FpuSqrt_l41;
	wire when_FpuSqrt_l44;
	wire when_FpuSqrt_l52;
	reg [51:0] x;
	assign _zz_t_1 = {q, 2'h1};
	assign _zz_t = {2'h0, _zz_t_1};
	assign _zz_q = {q, ~|t[56]};
	assign _zz_a_1 = {_zz_a, x[51:50]};
	assign _zz_a_2 = io_input_payload_a[53:52];
	assign t = a - _zz_t;
	assign io_input_ready = ~|busy;
	assign when_FpuSqrt_l41 = ~|done;
	assign when_FpuSqrt_l44 = ~|t[56];
	assign when_FpuSqrt_l52 = ~|busy;
	assign io_output_fire = io_output_valid & io_output_ready;
	assign when_FpuSqrt_l28 = busy & (counter == 6'h35);
	assign io_output_fire_1 = io_output_valid & io_output_ready;
	assign io_output_valid = done;
	assign io_output_payload_result = q;
	assign io_output_payload_remain = a;
	always @(a or when_FpuSqrt_l44 or t) begin
		_zz_a = a;
		if (when_FpuSqrt_l44)
			_zz_a = t;
	end
	always @(posedge reset or posedge clk)
		if (reset) begin
			busy <= 1'b0;
			done <= 1'b0;
		end
		else begin
			if (io_output_fire)
				busy <= 1'b0;
			if (when_FpuSqrt_l28)
				done <= 1'b1;
			if (io_output_fire_1)
				done <= 1'b0;
			if (when_FpuSqrt_l52) begin
				if (io_input_valid)
					busy <= 1'b1;
			end
		end
	always @(posedge clk) begin
		if (when_FpuSqrt_l41) begin
			counter <= counter + 6'h01;
			q <= _zz_q[52:0];
			a <= _zz_a_1[56:0];
			x <= x << 32'h00000002;
		end
		if (when_FpuSqrt_l52) begin
			q <= 53'h00000000000000;
			a <= {55'h00000000000000, _zz_a_2};
			x <= io_input_payload_a[51:0];
			counter <= 6'h00;
		end
	end
endmodule
module StreamArbiter_1_VexRiscv_FpuPlugin_fpu_streamArbiter_2  (
	io_inputs_0_valid,
	io_inputs_0_ready,
	io_inputs_0_payload_rd,
	io_inputs_0_payload_value_mantissa,
	io_inputs_0_payload_value_exponent,
	io_inputs_0_payload_value_sign,
	io_inputs_0_payload_value_special,
	io_inputs_0_payload_scrap,
	io_inputs_0_payload_roundMode,
	io_inputs_0_payload_format,
	io_inputs_0_payload_NV,
	io_inputs_0_payload_DZ,
	io_inputs_1_valid,
	io_inputs_1_ready,
	io_inputs_1_payload_rd,
	io_inputs_1_payload_value_mantissa,
	io_inputs_1_payload_value_exponent,
	io_inputs_1_payload_value_sign,
	io_inputs_1_payload_value_special,
	io_inputs_1_payload_scrap,
	io_inputs_1_payload_roundMode,
	io_inputs_1_payload_format,
	io_inputs_1_payload_NV,
	io_inputs_1_payload_DZ,
	io_inputs_2_valid,
	io_inputs_2_ready,
	io_inputs_2_payload_rd,
	io_inputs_2_payload_value_mantissa,
	io_inputs_2_payload_value_exponent,
	io_inputs_2_payload_value_sign,
	io_inputs_2_payload_value_special,
	io_inputs_2_payload_scrap,
	io_inputs_2_payload_roundMode,
	io_inputs_2_payload_format,
	io_inputs_2_payload_NV,
	io_inputs_2_payload_DZ,
	io_inputs_3_valid,
	io_inputs_3_ready,
	io_inputs_3_payload_rd,
	io_inputs_3_payload_value_mantissa,
	io_inputs_3_payload_value_exponent,
	io_inputs_3_payload_value_sign,
	io_inputs_3_payload_value_special,
	io_inputs_3_payload_scrap,
	io_inputs_3_payload_roundMode,
	io_inputs_3_payload_format,
	io_inputs_3_payload_NV,
	io_inputs_3_payload_DZ,
	io_inputs_4_valid,
	io_inputs_4_ready,
	io_inputs_4_payload_rd,
	io_inputs_4_payload_value_mantissa,
	io_inputs_4_payload_value_exponent,
	io_inputs_4_payload_value_sign,
	io_inputs_4_payload_value_special,
	io_inputs_4_payload_scrap,
	io_inputs_4_payload_roundMode,
	io_inputs_4_payload_format,
	io_inputs_4_payload_NV,
	io_inputs_4_payload_DZ,
	io_inputs_5_valid,
	io_inputs_5_ready,
	io_inputs_5_payload_rd,
	io_inputs_5_payload_value_mantissa,
	io_inputs_5_payload_value_exponent,
	io_inputs_5_payload_value_sign,
	io_inputs_5_payload_value_special,
	io_inputs_5_payload_scrap,
	io_inputs_5_payload_roundMode,
	io_inputs_5_payload_format,
	io_inputs_5_payload_NV,
	io_inputs_5_payload_DZ,
	io_output_valid,
	io_output_ready,
	io_output_payload_rd,
	io_output_payload_value_mantissa,
	io_output_payload_value_exponent,
	io_output_payload_value_sign,
	io_output_payload_value_special,
	io_output_payload_scrap,
	io_output_payload_roundMode,
	io_output_payload_format,
	io_output_payload_NV,
	io_output_payload_DZ,
	io_chosen,
	io_chosenOH,
	clk,
	reset
);
	input io_inputs_0_valid;
	output io_inputs_0_ready;
	input [4:0] io_inputs_0_payload_rd;
	input [52:0] io_inputs_0_payload_value_mantissa;
	input [11:0] io_inputs_0_payload_value_exponent;
	input io_inputs_0_payload_value_sign;
	input io_inputs_0_payload_value_special;
	input io_inputs_0_payload_scrap;
	input [2:0] io_inputs_0_payload_roundMode;
	input io_inputs_0_payload_format;
	input io_inputs_0_payload_NV;
	input io_inputs_0_payload_DZ;
	input io_inputs_1_valid;
	output io_inputs_1_ready;
	input [4:0] io_inputs_1_payload_rd;
	input [52:0] io_inputs_1_payload_value_mantissa;
	input [11:0] io_inputs_1_payload_value_exponent;
	input io_inputs_1_payload_value_sign;
	input io_inputs_1_payload_value_special;
	input io_inputs_1_payload_scrap;
	input [2:0] io_inputs_1_payload_roundMode;
	input io_inputs_1_payload_format;
	input io_inputs_1_payload_NV;
	input io_inputs_1_payload_DZ;
	input io_inputs_2_valid;
	output io_inputs_2_ready;
	input [4:0] io_inputs_2_payload_rd;
	input [52:0] io_inputs_2_payload_value_mantissa;
	input [11:0] io_inputs_2_payload_value_exponent;
	input io_inputs_2_payload_value_sign;
	input io_inputs_2_payload_value_special;
	input io_inputs_2_payload_scrap;
	input [2:0] io_inputs_2_payload_roundMode;
	input io_inputs_2_payload_format;
	input io_inputs_2_payload_NV;
	input io_inputs_2_payload_DZ;
	input io_inputs_3_valid;
	output io_inputs_3_ready;
	input [4:0] io_inputs_3_payload_rd;
	input [52:0] io_inputs_3_payload_value_mantissa;
	input [11:0] io_inputs_3_payload_value_exponent;
	input io_inputs_3_payload_value_sign;
	input io_inputs_3_payload_value_special;
	input io_inputs_3_payload_scrap;
	input [2:0] io_inputs_3_payload_roundMode;
	input io_inputs_3_payload_format;
	input io_inputs_3_payload_NV;
	input io_inputs_3_payload_DZ;
	input io_inputs_4_valid;
	output io_inputs_4_ready;
	input [4:0] io_inputs_4_payload_rd;
	input [52:0] io_inputs_4_payload_value_mantissa;
	input [11:0] io_inputs_4_payload_value_exponent;
	input io_inputs_4_payload_value_sign;
	input io_inputs_4_payload_value_special;
	input io_inputs_4_payload_scrap;
	input [2:0] io_inputs_4_payload_roundMode;
	input io_inputs_4_payload_format;
	input io_inputs_4_payload_NV;
	input io_inputs_4_payload_DZ;
	input io_inputs_5_valid;
	output io_inputs_5_ready;
	input [4:0] io_inputs_5_payload_rd;
	input [52:0] io_inputs_5_payload_value_mantissa;
	input [11:0] io_inputs_5_payload_value_exponent;
	input io_inputs_5_payload_value_sign;
	input io_inputs_5_payload_value_special;
	input io_inputs_5_payload_scrap;
	input [2:0] io_inputs_5_payload_roundMode;
	input io_inputs_5_payload_format;
	input io_inputs_5_payload_NV;
	input io_inputs_5_payload_DZ;
	output io_output_valid;
	input io_output_ready;
	output [4:0] io_output_payload_rd;
	output [52:0] io_output_payload_value_mantissa;
	output [11:0] io_output_payload_value_exponent;
	output io_output_payload_value_sign;
	output io_output_payload_value_special;
	output io_output_payload_scrap;
	output [2:0] io_output_payload_roundMode;
	output io_output_payload_format;
	output io_output_payload_NV;
	output io_output_payload_DZ;
	output [2:0] io_chosen;
	output [5:0] io_chosenOH;
	input clk;
	input reset;
	parameter FpuFormat_DOUBLE = 1'b1;
	parameter FpuFormat_FLOAT = 1'b0;
	parameter FpuRoundMode_RDN = 3'h2;
	parameter FpuRoundMode_RMM = 3'h4;
	parameter FpuRoundMode_RNE = 3'h0;
	parameter FpuRoundMode_RTZ = 3'h1;
	parameter FpuRoundMode_RUP = 3'h3;
	reg _zz__zz_io_output_payload_format;
	reg [2:0] _zz__zz_io_output_payload_roundMode;
	wire [5:0] _zz__zz_maskProposal_1_1;
	wire _zz_io_chosen;
	wire _zz_io_chosen_1;
	wire _zz_io_chosen_2;
	wire _zz_io_chosen_3;
	wire _zz_io_chosen_4;
	reg _zz_io_output_payload_DZ;
	reg _zz_io_output_payload_NV;
	wire _zz_io_output_payload_format;
	wire _zz_io_output_payload_rd;
	wire _zz_io_output_payload_rd_1;
	wire _zz_io_output_payload_rd_2;
	wire [2:0] _zz_io_output_payload_rd_3;
	reg [4:0] _zz_io_output_payload_rd_4;
	wire [2:0] _zz_io_output_payload_roundMode;
	reg _zz_io_output_payload_scrap;
	reg [11:0] _zz_io_output_payload_value_exponent;
	reg [52:0] _zz_io_output_payload_value_mantissa;
	reg _zz_io_output_payload_value_sign;
	reg _zz_io_output_payload_value_special;
	wire [5:0] _zz_maskProposal_1;
	wire [5:0] _zz_maskProposal_1_1;
	wire locked;
	reg maskLocked_0;
	reg maskLocked_1;
	reg maskLocked_2;
	reg maskLocked_3;
	reg maskLocked_4;
	reg maskLocked_5;
	wire maskProposal_0;
	wire maskProposal_1;
	wire maskProposal_2;
	wire maskProposal_3;
	wire maskProposal_4;
	wire maskProposal_5;
	wire maskRouted_0;
	wire maskRouted_1;
	wire maskRouted_2;
	wire maskRouted_3;
	wire maskRouted_4;
	wire maskRouted_5;
	assign locked = 1'b0;
	assign _zz__zz_maskProposal_1_1 = _zz_maskProposal_1 - 6'h01;
	assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
	assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1);
	assign maskRouted_2 = (locked ? maskLocked_2 : maskProposal_2);
	assign maskRouted_3 = (locked ? maskLocked_3 : maskProposal_3);
	assign maskRouted_4 = (locked ? maskLocked_4 : maskProposal_4);
	assign maskRouted_5 = (locked ? maskLocked_5 : maskProposal_5);
	assign _zz_maskProposal_1 = {io_inputs_5_valid, io_inputs_4_valid, io_inputs_3_valid, io_inputs_2_valid, io_inputs_1_valid, io_inputs_0_valid};
	assign maskProposal_1 = _zz_maskProposal_1_1[1];
	assign maskProposal_2 = _zz_maskProposal_1_1[2];
	assign maskProposal_3 = _zz_maskProposal_1_1[3];
	assign maskProposal_4 = _zz_maskProposal_1_1[4];
	assign maskProposal_5 = _zz_maskProposal_1_1[5];
	assign _zz_io_output_payload_rd_3 = {_zz_io_output_payload_rd_2, _zz_io_output_payload_rd_1, _zz_io_output_payload_rd};
	assign io_chosenOH = {maskRouted_5, maskRouted_4, maskRouted_3, maskRouted_2, maskRouted_1, maskRouted_0};
	assign _zz_io_chosen = io_chosenOH[3];
	assign _zz_io_chosen_1 = io_chosenOH[5];
	assign io_chosen = {_zz_io_chosen_4, _zz_io_chosen_3, _zz_io_chosen_2};
	assign _zz_maskProposal_1_1 = _zz_maskProposal_1 & ~_zz__zz_maskProposal_1_1;
	assign maskProposal_0 = io_inputs_0_valid;
	assign io_output_valid = (((((io_inputs_0_valid & maskRouted_0) | (io_inputs_1_valid & maskRouted_1)) | (io_inputs_2_valid & maskRouted_2)) | (io_inputs_3_valid & maskRouted_3)) | (io_inputs_4_valid & maskRouted_4)) | (io_inputs_5_valid & maskRouted_5);
	assign _zz_io_output_payload_rd = (maskRouted_1 | maskRouted_3) | maskRouted_5;
	assign _zz_io_output_payload_rd_1 = maskRouted_2 | maskRouted_3;
	assign _zz_io_output_payload_rd_2 = maskRouted_4 | maskRouted_5;
	assign _zz_io_output_payload_roundMode = _zz__zz_io_output_payload_roundMode;
	assign _zz_io_output_payload_format = _zz__zz_io_output_payload_format;
	assign io_output_payload_rd = _zz_io_output_payload_rd_4;
	assign io_output_payload_value_mantissa = _zz_io_output_payload_value_mantissa;
	assign io_output_payload_value_exponent = _zz_io_output_payload_value_exponent;
	assign io_output_payload_value_sign = _zz_io_output_payload_value_sign;
	assign io_output_payload_value_special = _zz_io_output_payload_value_special;
	assign io_output_payload_scrap = _zz_io_output_payload_scrap;
	assign io_output_payload_roundMode = _zz_io_output_payload_roundMode;
	assign io_output_payload_format = _zz_io_output_payload_format;
	assign io_output_payload_NV = _zz_io_output_payload_NV;
	assign io_output_payload_DZ = _zz_io_output_payload_DZ;
	assign io_inputs_0_ready = maskRouted_0 & io_output_ready;
	assign io_inputs_1_ready = maskRouted_1 & io_output_ready;
	assign io_inputs_2_ready = maskRouted_2 & io_output_ready;
	assign io_inputs_3_ready = maskRouted_3 & io_output_ready;
	assign io_inputs_4_ready = maskRouted_4 & io_output_ready;
	assign io_inputs_5_ready = maskRouted_5 & io_output_ready;
	assign _zz_io_chosen_2 = (io_chosenOH[1] | _zz_io_chosen) | _zz_io_chosen_1;
	assign _zz_io_chosen_3 = io_chosenOH[2] | _zz_io_chosen;
	assign _zz_io_chosen_4 = io_chosenOH[4] | _zz_io_chosen_1;
	always @(_zz_io_output_payload_rd_3 or io_inputs_0_payload_roundMode or io_inputs_0_payload_format or io_inputs_0_payload_rd or io_inputs_0_payload_value_mantissa or io_inputs_0_payload_value_exponent or io_inputs_0_payload_value_sign or io_inputs_0_payload_value_special or io_inputs_0_payload_scrap or io_inputs_0_payload_NV or io_inputs_0_payload_DZ or io_inputs_1_payload_roundMode or io_inputs_1_payload_format or io_inputs_1_payload_rd or io_inputs_1_payload_value_mantissa or io_inputs_1_payload_value_exponent or io_inputs_1_payload_value_sign or io_inputs_1_payload_value_special or io_inputs_1_payload_scrap or io_inputs_1_payload_NV or io_inputs_1_payload_DZ or io_inputs_2_payload_roundMode or io_inputs_2_payload_format or io_inputs_2_payload_rd or io_inputs_2_payload_value_mantissa or io_inputs_2_payload_value_exponent or io_inputs_2_payload_value_sign or io_inputs_2_payload_value_special or io_inputs_2_payload_scrap or io_inputs_2_payload_NV or io_inputs_2_payload_DZ or io_inputs_3_payload_roundMode or io_inputs_3_payload_format or io_inputs_3_payload_rd or io_inputs_3_payload_value_mantissa or io_inputs_3_payload_value_exponent or io_inputs_3_payload_value_sign or io_inputs_3_payload_value_special or io_inputs_3_payload_scrap or io_inputs_3_payload_NV or io_inputs_3_payload_DZ or io_inputs_4_payload_roundMode or io_inputs_4_payload_format or io_inputs_4_payload_rd or io_inputs_4_payload_value_mantissa or io_inputs_4_payload_value_exponent or io_inputs_4_payload_value_sign or io_inputs_4_payload_value_special or io_inputs_4_payload_scrap or io_inputs_4_payload_NV or io_inputs_4_payload_DZ or io_inputs_5_payload_roundMode or io_inputs_5_payload_format or io_inputs_5_payload_rd or io_inputs_5_payload_value_mantissa or io_inputs_5_payload_value_exponent or io_inputs_5_payload_value_sign or io_inputs_5_payload_value_special or io_inputs_5_payload_scrap or io_inputs_5_payload_NV or io_inputs_5_payload_DZ)
		case (_zz_io_output_payload_rd_3)
			3'h0: begin
				_zz__zz_io_output_payload_roundMode = io_inputs_0_payload_roundMode;
				_zz__zz_io_output_payload_format = io_inputs_0_payload_format;
				_zz_io_output_payload_rd_4 = io_inputs_0_payload_rd;
				_zz_io_output_payload_value_mantissa = io_inputs_0_payload_value_mantissa;
				_zz_io_output_payload_value_exponent = io_inputs_0_payload_value_exponent;
				_zz_io_output_payload_value_sign = io_inputs_0_payload_value_sign;
				_zz_io_output_payload_value_special = io_inputs_0_payload_value_special;
				_zz_io_output_payload_scrap = io_inputs_0_payload_scrap;
				_zz_io_output_payload_NV = io_inputs_0_payload_NV;
				_zz_io_output_payload_DZ = io_inputs_0_payload_DZ;
			end
			3'h1: begin
				_zz__zz_io_output_payload_roundMode = io_inputs_1_payload_roundMode;
				_zz__zz_io_output_payload_format = io_inputs_1_payload_format;
				_zz_io_output_payload_rd_4 = io_inputs_1_payload_rd;
				_zz_io_output_payload_value_mantissa = io_inputs_1_payload_value_mantissa;
				_zz_io_output_payload_value_exponent = io_inputs_1_payload_value_exponent;
				_zz_io_output_payload_value_sign = io_inputs_1_payload_value_sign;
				_zz_io_output_payload_value_special = io_inputs_1_payload_value_special;
				_zz_io_output_payload_scrap = io_inputs_1_payload_scrap;
				_zz_io_output_payload_NV = io_inputs_1_payload_NV;
				_zz_io_output_payload_DZ = io_inputs_1_payload_DZ;
			end
			3'h2: begin
				_zz__zz_io_output_payload_roundMode = io_inputs_2_payload_roundMode;
				_zz__zz_io_output_payload_format = io_inputs_2_payload_format;
				_zz_io_output_payload_rd_4 = io_inputs_2_payload_rd;
				_zz_io_output_payload_value_mantissa = io_inputs_2_payload_value_mantissa;
				_zz_io_output_payload_value_exponent = io_inputs_2_payload_value_exponent;
				_zz_io_output_payload_value_sign = io_inputs_2_payload_value_sign;
				_zz_io_output_payload_value_special = io_inputs_2_payload_value_special;
				_zz_io_output_payload_scrap = io_inputs_2_payload_scrap;
				_zz_io_output_payload_NV = io_inputs_2_payload_NV;
				_zz_io_output_payload_DZ = io_inputs_2_payload_DZ;
			end
			3'h3: begin
				_zz__zz_io_output_payload_roundMode = io_inputs_3_payload_roundMode;
				_zz__zz_io_output_payload_format = io_inputs_3_payload_format;
				_zz_io_output_payload_rd_4 = io_inputs_3_payload_rd;
				_zz_io_output_payload_value_mantissa = io_inputs_3_payload_value_mantissa;
				_zz_io_output_payload_value_exponent = io_inputs_3_payload_value_exponent;
				_zz_io_output_payload_value_sign = io_inputs_3_payload_value_sign;
				_zz_io_output_payload_value_special = io_inputs_3_payload_value_special;
				_zz_io_output_payload_scrap = io_inputs_3_payload_scrap;
				_zz_io_output_payload_NV = io_inputs_3_payload_NV;
				_zz_io_output_payload_DZ = io_inputs_3_payload_DZ;
			end
			3'h4: begin
				_zz__zz_io_output_payload_roundMode = io_inputs_4_payload_roundMode;
				_zz__zz_io_output_payload_format = io_inputs_4_payload_format;
				_zz_io_output_payload_rd_4 = io_inputs_4_payload_rd;
				_zz_io_output_payload_value_mantissa = io_inputs_4_payload_value_mantissa;
				_zz_io_output_payload_value_exponent = io_inputs_4_payload_value_exponent;
				_zz_io_output_payload_value_sign = io_inputs_4_payload_value_sign;
				_zz_io_output_payload_value_special = io_inputs_4_payload_value_special;
				_zz_io_output_payload_scrap = io_inputs_4_payload_scrap;
				_zz_io_output_payload_NV = io_inputs_4_payload_NV;
				_zz_io_output_payload_DZ = io_inputs_4_payload_DZ;
			end
			default: begin
				_zz__zz_io_output_payload_roundMode = io_inputs_5_payload_roundMode;
				_zz__zz_io_output_payload_format = io_inputs_5_payload_format;
				_zz_io_output_payload_rd_4 = io_inputs_5_payload_rd;
				_zz_io_output_payload_value_mantissa = io_inputs_5_payload_value_mantissa;
				_zz_io_output_payload_value_exponent = io_inputs_5_payload_value_exponent;
				_zz_io_output_payload_value_sign = io_inputs_5_payload_value_sign;
				_zz_io_output_payload_value_special = io_inputs_5_payload_value_special;
				_zz_io_output_payload_scrap = io_inputs_5_payload_scrap;
				_zz_io_output_payload_NV = io_inputs_5_payload_NV;
				_zz_io_output_payload_DZ = io_inputs_5_payload_DZ;
			end
		endcase
	always @(posedge clk)
		if (io_output_valid) begin
			maskLocked_0 <= maskRouted_0;
			maskLocked_1 <= maskRouted_1;
			maskLocked_2 <= maskRouted_2;
			maskLocked_3 <= maskRouted_3;
			maskLocked_4 <= maskRouted_4;
			maskLocked_5 <= maskRouted_5;
		end
endmodule
module StreamFork_VexRiscv_FpuPlugin_fpu_streamFork_1  (
	io_input_valid,
	io_input_ready,
	io_input_payload_opcode,
	io_input_payload_rd,
	io_input_payload_write,
	io_input_payload_value,
	io_outputs_0_valid,
	io_outputs_0_ready,
	io_outputs_0_payload_opcode,
	io_outputs_0_payload_rd,
	io_outputs_0_payload_write,
	io_outputs_0_payload_value,
	io_outputs_1_valid,
	io_outputs_1_ready,
	io_outputs_1_payload_opcode,
	io_outputs_1_payload_rd,
	io_outputs_1_payload_write,
	io_outputs_1_payload_value
);
	input io_input_valid;
	output io_input_ready;
	input [3:0] io_input_payload_opcode;
	input [4:0] io_input_payload_rd;
	input io_input_payload_write;
	input [63:0] io_input_payload_value;
	output io_outputs_0_valid;
	input io_outputs_0_ready;
	output [3:0] io_outputs_0_payload_opcode;
	output [4:0] io_outputs_0_payload_rd;
	output io_outputs_0_payload_write;
	output [63:0] io_outputs_0_payload_value;
	output io_outputs_1_valid;
	input io_outputs_1_ready;
	output [3:0] io_outputs_1_payload_opcode;
	output [4:0] io_outputs_1_payload_rd;
	output io_outputs_1_payload_write;
	output [63:0] io_outputs_1_payload_value;
	parameter FpuOpcode_ADD = 4'h3;
	parameter FpuOpcode_CMP = 4'h7;
	parameter FpuOpcode_DIV = 4'h8;
	parameter FpuOpcode_F2I = 4'h6;
	parameter FpuOpcode_FCLASS = 4'he;
	parameter FpuOpcode_FCVT_X_X = 4'hf;
	parameter FpuOpcode_FMA = 4'h4;
	parameter FpuOpcode_FMV_W_X = 4'hd;
	parameter FpuOpcode_FMV_X_W = 4'hc;
	parameter FpuOpcode_I2F = 4'h5;
	parameter FpuOpcode_LOAD = 4'h0;
	parameter FpuOpcode_MIN_MAX = 4'ha;
	parameter FpuOpcode_MUL = 4'h2;
	parameter FpuOpcode_SGNJ = 4'hb;
	parameter FpuOpcode_SQRT = 4'h9;
	parameter FpuOpcode_STORE = 4'h1;
	assign io_input_ready = io_outputs_0_ready & io_outputs_1_ready;
	assign io_outputs_0_valid = io_input_valid & io_input_ready;
	assign io_outputs_1_valid = io_input_valid & io_input_ready;
	assign io_outputs_0_payload_opcode = io_input_payload_opcode;
	assign io_outputs_0_payload_rd = io_input_payload_rd;
	assign io_outputs_0_payload_write = io_input_payload_write;
	assign io_outputs_0_payload_value = io_input_payload_value;
	assign io_outputs_1_payload_opcode = io_input_payload_opcode;
	assign io_outputs_1_payload_rd = io_input_payload_rd;
	assign io_outputs_1_payload_write = io_input_payload_write;
	assign io_outputs_1_payload_value = io_input_payload_value;
endmodule
