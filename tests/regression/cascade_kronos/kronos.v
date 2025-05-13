module kronos_tiny_soc (
	clk_i,
	rst_ni,
	instr_mem_req,
	instr_mem_gnt,
	instr_mem_addr,
	instr_mem_wdata,
	instr_mem_strb,
	instr_mem_we,
	instr_mem_rdata,
	data_mem_req,
	data_mem_gnt,
	data_mem_addr,
	data_mem_wdata,
	data_mem_strb,
	data_mem_we,
	data_mem_rdata
);
	parameter [31:0] InstrMemDepth = 1048576;
	parameter [31:0] DataMemDepth = 1048576;
	input clk_i;
	input rst_ni;
	output instr_mem_req;
	output instr_mem_gnt;
	output [31:0] instr_mem_addr;
	output [31:0] instr_mem_wdata;
	output [31:0] instr_mem_strb;
	output instr_mem_we;
	output [31:0] instr_mem_rdata;
	output data_mem_req;
	output data_mem_gnt;
	output [31:0] data_mem_addr;
	output [31:0] data_mem_wdata;
	output [31:0] data_mem_strb;
	output data_mem_we;
	output [31:0] data_mem_rdata;
	wire software_interrupt;
	wire timer_interrupt;
	wire external_interrupt;
	kronos_mem_top i_kronos_mem_top(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.data_mem_req(data_mem_req),
		.data_mem_gnt(data_mem_gnt),
		.data_mem_addr(data_mem_addr),
		.data_mem_wdata(data_mem_wdata),
		.data_mem_strb(data_mem_strb),
		.data_mem_we(data_mem_we),
		.data_mem_rdata(data_mem_rdata),
		.instr_mem_req(instr_mem_req),
		.instr_mem_gnt(instr_mem_gnt),
		.instr_mem_addr(instr_mem_addr),
		.instr_mem_wdata(instr_mem_wdata),
		.instr_mem_strb(instr_mem_strb),
		.instr_mem_we(instr_mem_we),
		.instr_mem_rdata(instr_mem_rdata),
		.software_interrupt(software_interrupt),
		.timer_interrupt(timer_interrupt),
		.external_interrupt(external_interrupt)
	);
	// sram_mem #(
	// 	.Width(32),
	// 	.Depth(InstrMemDepth),
	// 	.RelocateRequestUp(64'h0000000010000000)
	// ) i_instr_rom(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.req_i(instr_mem_req),
	// 	.write_i(instr_mem_we),
	// 	.addr_i(instr_mem_addr >> 2),
	// 	.wdata_i(instr_mem_wdata),
	// 	.wmask_i(instr_mem_strb),
	// 	.rdata_o(instr_mem_rdata)
	// );
	assign instr_mem_gnt = 1'sb1;
	// sram_mem #(
	// 	.Width(32),
	// 	.Depth(DataMemDepth),
	// 	.RelocateRequestUp(64'h0000000010000000)
	// ) i_data_sram(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.req_i(data_mem_req),
	// 	.write_i(data_mem_we),
	// 	.addr_i(data_mem_addr >> 2),
	// 	.wdata_i(data_mem_wdata),
	// 	.wmask_i(data_mem_strb),
	// 	.rdata_o(data_mem_rdata)
	// );
	assign data_mem_gnt = 1'sb1;
	assign external_interrupt = 1'sb0;
	assign software_interrupt = 1'sb0;
	assign timer_interrupt = 1'sb0;
endmodule


module kronos_alu (
	op1,
	op2,
	aluop,
	result
);
	input [31:0] op1;
	input [31:0] op2;
	input [3:0] aluop;
	output reg [31:0] result;
	function automatic [31:0] reverse_bits;
		input reg [31:0] value;
		reg [31:0] reversed_value;
		integer i;
		begin
			for (i = 0; i < 32; i = i + 1)
				reversed_value[i] = value[31 - i];
			reverse_bits = reversed_value;
		end
	endfunction
	wire cin;
	wire rev;
	wire uns;
	reg [31:0] r_adder;
	reg [31:0] r_and;
	reg [31:0] r_or;
	reg [31:0] r_xor;
	wire [31:0] r_shift;
	reg [31:0] adder_A;
	reg [31:0] adder_B;
	reg cout;
	reg A_sign;
	reg B_sign;
	reg R_sign;
	reg r_lt;
	reg r_ltu;
	reg r_comp;
	wire [31:0] data;
	wire [4:0] shamt;
	wire shift_in;
	wire [31:0] p0;
	wire [31:0] p1;
	wire [31:0] p2;
	wire [31:0] p3;
	wire [31:0] p4;
	assign cin = aluop[3] || aluop[1];
	assign rev = ~aluop[2];
	assign uns = aluop[0];
	always @(*) begin
		adder_A = op1;
		adder_B = (cin ? ~op2 : op2);
		{cout, r_adder} = ({1'b0, adder_A} + {1'b0, adder_B}) + cin;
	end
	always @(*) begin
		r_and = op1 & op2;
		r_or = op1 | op2;
		r_xor = op1 ^ op2;
	end
	always @(*) begin
		A_sign = op1[31];
		B_sign = op2[31];
		R_sign = r_adder[31];
		case ({A_sign, B_sign})
			2'b00: r_lt = R_sign;
			2'b01: r_lt = 1'b0;
			2'b10: r_lt = 1'b1;
			2'b11: r_lt = R_sign;
		endcase
		r_ltu = ~cout;
		r_comp = (uns ? r_ltu : r_lt);
	end
	assign data = (rev ? reverse_bits(op1) : op1);
	assign shift_in = cin & op1[31];
	assign shamt = op2[4:0];
	assign p0 = (shamt[0] ? {shift_in, data[31:1]} : data);
	assign p1 = (shamt[1] ? {{2 {shift_in}}, p0[31:2]} : p0);
	assign p2 = (shamt[2] ? {{4 {shift_in}}, p1[31:4]} : p1);
	assign p3 = (shamt[3] ? {{8 {shift_in}}, p2[31:8]} : p2);
	assign p4 = (shamt[4] ? {{16 {shift_in}}, p3[31:16]} : p3);
	assign r_shift = (rev ? reverse_bits(p4) : p4);
	localparam [3:0] kronos_types_AND = 4'b0111;
	localparam [3:0] kronos_types_OR = 4'b0110;
	localparam [3:0] kronos_types_SLL = 4'b0001;
	localparam [3:0] kronos_types_SLT = 4'b0010;
	localparam [3:0] kronos_types_SLTU = 4'b0011;
	localparam [3:0] kronos_types_SRA = 4'b1101;
	localparam [3:0] kronos_types_SRL = 4'b0101;
	localparam [3:0] kronos_types_XOR = 4'b0100;
	always @(*)
		case (aluop)
			kronos_types_SLT, kronos_types_SLTU: result = {31'b0000000000000000000000000000000, r_comp};
			kronos_types_XOR: result = r_xor;
			kronos_types_OR: result = r_or;
			kronos_types_AND: result = r_and;
			kronos_types_SLL, kronos_types_SRL, kronos_types_SRA: result = r_shift;
			default: result = r_adder;
		endcase
endmodule
module kronos_branch (
	op,
	rs1,
	rs2,
	branch
);
	input [2:0] op;
	input [31:0] rs1;
	input [31:0] rs2;
	output reg branch;
	wire uns;
	wire eq;
	wire lt;
	assign uns = op[1];
	assign eq = rs1 == rs2;
	assign lt = (uns ? rs1 < rs2 : $signed(rs1) < $signed(rs2));
	localparam [2:0] kronos_types_BEQ = 3'b000;
	localparam [2:0] kronos_types_BGE = 3'b101;
	localparam [2:0] kronos_types_BGEU = 3'b111;
	localparam [2:0] kronos_types_BNE = 3'b001;
	always @(*)
		case (op)
			kronos_types_BEQ: branch = eq;
			kronos_types_BNE: branch = ~eq;
			kronos_types_BGE, kronos_types_BGEU: branch = ~lt;
			default: branch = lt;
		endcase
endmodule
module kronos_core (
	clk,
	rstz,
	instr_addr,
	instr_data,
	instr_req,
	instr_ack,
	data_addr,
	data_rd_data,
	data_wr_data,
	data_mask,
	data_wr_en,
	data_req,
	data_ack,
	software_interrupt,
	timer_interrupt,
	external_interrupt
);
	parameter [31:0] BOOT_ADDR = 32'h00000000;
	parameter FAST_BRANCH = 1;
	parameter EN_COUNTERS = 1;
	parameter EN_COUNTERS64B = 1;
	parameter CATCH_ILLEGAL_INSTR = 1;
	parameter CATCH_MISALIGNED_JMP = 1;
	parameter CATCH_MISALIGNED_LDST = 1;
	input clk;
	input rstz;
	output [31:0] instr_addr;
	input [31:0] instr_data;
	output instr_req;
	input instr_ack;
	output [31:0] data_addr;
	input [31:0] data_rd_data;
	output [31:0] data_wr_data;
	output [3:0] data_mask;
	output data_wr_en;
	output data_req;
	input data_ack;
	input software_interrupt;
	input timer_interrupt;
	input external_interrupt;
	wire [31:0] immediate;
	wire [31:0] regrd_rs1;
	wire [31:0] regrd_rs2;
	wire regrd_rs1_en;
	wire regrd_rs2_en;
	wire [31:0] branch_target;
	wire branch;
	wire [31:0] regwr_data;
	wire [4:0] regwr_sel;
	wire regwr_en;
	wire flush;
	wire [63:0] fetch;
	wire [180:0] decode;
	wire fetch_vld;
	wire fetch_rdy;
	wire decode_vld;
	wire decode_rdy;
	wire regwr_pending;
	kronos_IF #(
		.BOOT_ADDR(BOOT_ADDR),
		.FAST_BRANCH(FAST_BRANCH)
	) u_if(
		.clk(clk),
		.rstz(rstz),
		.instr_addr(instr_addr),
		.instr_data(instr_data),
		.instr_req(instr_req),
		.instr_ack(instr_ack),
		.fetch(fetch),
		.immediate(immediate),
		.regrd_rs1(regrd_rs1),
		.regrd_rs2(regrd_rs2),
		.regrd_rs1_en(regrd_rs1_en),
		.regrd_rs2_en(regrd_rs2_en),
		.fetch_vld(fetch_vld),
		.fetch_rdy(fetch_rdy),
		.branch_target(branch_target),
		.branch(branch),
		.regwr_data(regwr_data),
		.regwr_sel(regwr_sel),
		.regwr_en(regwr_en)
	);
	kronos_ID #(
		.CATCH_ILLEGAL_INSTR(CATCH_ILLEGAL_INSTR),
		.CATCH_MISALIGNED_JMP(CATCH_MISALIGNED_JMP),
		.CATCH_MISALIGNED_LDST(CATCH_MISALIGNED_LDST)
	) u_id(
		.clk(clk),
		.rstz(rstz),
		.flush(flush),
		.fetch(fetch),
		.immediate(immediate),
		.regrd_rs1(regrd_rs1),
		.regrd_rs2(regrd_rs2),
		.regrd_rs1_en(regrd_rs1_en),
		.regrd_rs2_en(regrd_rs2_en),
		.fetch_vld(fetch_vld),
		.fetch_rdy(fetch_rdy),
		.decode(decode),
		.decode_vld(decode_vld),
		.decode_rdy(decode_rdy),
		.regwr_data(regwr_data),
		.regwr_sel(regwr_sel),
		.regwr_en(regwr_en),
		.regwr_pending(regwr_pending)
	);
	kronos_EX #(
		.BOOT_ADDR(BOOT_ADDR),
		.EN_COUNTERS(EN_COUNTERS),
		.EN_COUNTERS64B(EN_COUNTERS64B)
	) u_ex(
		.clk(clk),
		.rstz(rstz),
		.decode(decode),
		.decode_vld(decode_vld),
		.decode_rdy(decode_rdy),
		.regwr_data(regwr_data),
		.regwr_sel(regwr_sel),
		.regwr_en(regwr_en),
		.regwr_pending(regwr_pending),
		.branch_target(branch_target),
		.branch(branch),
		.data_addr(data_addr),
		.data_rd_data(data_rd_data),
		.data_wr_data(data_wr_data),
		.data_mask(data_mask),
		.data_wr_en(data_wr_en),
		.data_req(data_req),
		.data_ack(data_ack),
		.software_interrupt(software_interrupt),
		.timer_interrupt(timer_interrupt),
		.external_interrupt(external_interrupt)
	);
	assign flush = branch;
endmodule
module kronos_counter64 (
	clk,
	rstz,
	incr,
	load_data,
	load_low,
	load_high,
	count,
	count_vld
);
	parameter EN_COUNTERS = 1;
	parameter EN_COUNTERS64B = 1;
	input clk;
	input rstz;
	input incr;
	input [31:0] load_data;
	input load_low;
	input load_high;
	output [63:0] count;
	output count_vld;
	reg [31:0] count_low;
	reg [31:0] count_high;
	reg incr_high;
	always @(posedge clk)
		if (~rstz) begin
			count_low <= 1'sb0;
			count_high <= 1'sb0;
			incr_high <= 1'b0;
		end
		else begin
			incr_high <= 1'b0;
			if (load_low)
				count_low <= load_data;
			else if (load_high)
				count_high <= load_data;
			else begin
				if (incr) begin
					count_low <= count_low + 1'b1;
					incr_high <= count_low == {32 {1'sb1}};
				end
				if (incr_high)
					count_high <= count_high + 1'b1;
			end
		end
	generate
		if (EN_COUNTERS) begin : genblk1
			if (EN_COUNTERS64B) begin : genblk1
				assign count = {count_high, count_low};
				assign count_vld = ~incr_high;
			end
			else begin : genblk1
				assign count = {32'b00000000000000000000000000000000, count_low};
				assign count_vld = 1'b1;
			end
		end
		else begin : genblk1
			assign count = 1'sb0;
			assign count_vld = 1'b1;
		end
	endgenerate
endmodule
module kronos_csr (
	clk,
	rstz,
	decode,
	csr_vld,
	csr_rdy,
	csr_data,
	regwr_csr,
	instret,
	activate_trap,
	return_trap,
	trap_cause,
	trap_value,
	trap_handle,
	trap_jump,
	software_interrupt,
	timer_interrupt,
	external_interrupt,
	core_interrupt,
	core_interrupt_cause
);
	parameter [31:0] BOOT_ADDR = 32'h00000000;
	parameter EN_COUNTERS = 1;
	parameter EN_COUNTERS64B = 1;
	input clk;
	input rstz;
	input [180:0] decode;
	input csr_vld;
	output csr_rdy;
	output reg [31:0] csr_data;
	output reg regwr_csr;
	input instret;
	input activate_trap;
	input return_trap;
	input [31:0] trap_cause;
	input [31:0] trap_value;
	output reg [31:0] trap_handle;
	output reg trap_jump;
	input software_interrupt;
	input timer_interrupt;
	input external_interrupt;
	output reg core_interrupt;
	output reg [3:0] core_interrupt_cause;
	wire [2:0] funct3;
	wire [11:0] addr;
	wire [4:0] zimm;
	wire [4:0] rd;
	wire [31:0] wr_data;
	reg [31:0] csr_rd_data;
	reg [31:0] csr_wr_data;
	wire csr_rd_vld;
	reg csr_wr_vld;
	wire csr_rd_en;
	wire csr_wr_en;
	reg [3:0] mstatus;
	reg [2:0] mie;
	reg [2:0] mip;
	reg [31:0] mtvec;
	reg [31:0] mscratch;
	reg [31:0] mepc;
	reg [31:0] mcause;
	reg [31:0] mtval;
	wire mcycle_wrenl;
	wire mcycle_wrenh;
	wire mcycle_rd_vld;
	wire [63:0] mcycle;
	wire minstret_wrenl;
	wire minstret_wrenh;
	wire minstret_rd_vld;
	wire [63:0] minstret;
	reg [1:0] state;
	reg [1:0] next_state;
	assign addr = decode[148-:12];
	assign funct3 = decode[131:129];
	assign rd = decode[128:124];
	assign zimm = decode[136:132];
	assign wr_data = (funct3[2] ? {27'b000000000000000000000000000, zimm} : decode[116-:32]);
	assign csr_rdy = state == 2'd2;
	always @(posedge clk)
		if (~rstz)
			state <= 2'd0;
		else
			state <= next_state;
	always @(*) begin
		next_state = state;
		case (state)
			2'd0:
				if (csr_vld && decode[6])
					next_state = 2'd1;
			2'd1:
				if (csr_rd_vld)
					next_state = 2'd2;
			2'd2: next_state = 2'd0;
		endcase
	end
	always @(posedge clk)
		if (~rstz) begin
			csr_wr_vld <= 1'b0;
			regwr_csr <= 1'b0;
		end
		else if (((state == 2'd0) && csr_vld) && decode[6]) begin
			csr_wr_vld <= ~(((funct3 == 3'b010) || (funct3 == 3'b011)) && (zimm == {5 {1'sb0}}));
			regwr_csr <= rd != {5 {1'sb0}};
		end
		else if (state == 2'd2)
			regwr_csr <= 1'b0;
	assign csr_rd_vld = mcycle_rd_vld && minstret_rd_vld;
	assign csr_rd_en = (state == 2'd1) && csr_rd_vld;
	assign csr_wr_en = (state == 2'd2) && csr_wr_vld;
	always @(posedge clk)
		if (csr_rd_en)
			csr_data <= csr_rd_data;
	always @(posedge clk)
		if (~rstz)
			trap_jump <= 1'b0;
		else if (activate_trap) begin
			trap_jump <= 1'b1;
			trap_handle <= mtvec;
		end
		else if (return_trap) begin
			trap_jump <= 1'b1;
			trap_handle <= mepc;
		end
		else
			trap_jump <= 1'b0;
	localparam [11:0] kronos_types_MCAUSE = 12'h342;
	localparam [11:0] kronos_types_MCYCLE = 12'hb00;
	localparam [11:0] kronos_types_MCYCLEH = 12'hb80;
	localparam [11:0] kronos_types_MEPC = 12'h341;
	localparam [11:0] kronos_types_MIE = 12'h304;
	localparam [11:0] kronos_types_MINSTRET = 12'hb02;
	localparam [11:0] kronos_types_MINSTRETH = 12'hb82;
	localparam [11:0] kronos_types_MIP = 12'h344;
	localparam [11:0] kronos_types_MSCRATCH = 12'h340;
	localparam [11:0] kronos_types_MSTATUS = 12'h300;
	localparam [11:0] kronos_types_MTVAL = 12'h343;
	localparam [11:0] kronos_types_MTVEC = 12'h305;
	always @(*) begin
		csr_rd_data = 1'sb0;
		case (addr)
			kronos_types_MSTATUS: begin
				csr_rd_data[3] = mstatus[0];
				csr_rd_data[7] = mstatus[1];
				csr_rd_data[12:11] = mstatus[3-:2];
			end
			kronos_types_MIE: begin
				csr_rd_data[3] = mie[0];
				csr_rd_data[7] = mie[1];
				csr_rd_data[11] = mie[2];
			end
			kronos_types_MTVEC: csr_rd_data = mtvec;
			kronos_types_MSCRATCH: csr_rd_data = mscratch;
			kronos_types_MEPC: csr_rd_data = mepc;
			kronos_types_MCAUSE: csr_rd_data = mcause;
			kronos_types_MTVAL: csr_rd_data = mtval;
			kronos_types_MIP: begin
				csr_rd_data[3] = mip[0];
				csr_rd_data[7] = mip[1];
				csr_rd_data[11] = mip[2];
			end
			kronos_types_MCYCLE: csr_rd_data = mcycle[31:0];
			kronos_types_MINSTRET: csr_rd_data = minstret[31:0];
			kronos_types_MCYCLEH: csr_rd_data = mcycle[63:32];
			kronos_types_MINSTRETH: csr_rd_data = minstret[63:32];
		endcase
	end
	localparam [1:0] kronos_types_CSR_RC = 2'b11;
	localparam [1:0] kronos_types_CSR_RS = 2'b10;
	always @(*)
		case (funct3[1:0])
			kronos_types_CSR_RS: csr_wr_data = csr_data | wr_data;
			kronos_types_CSR_RC: csr_wr_data = csr_data & ~wr_data;
			default: csr_wr_data = wr_data;
		endcase
	localparam [1:0] kronos_types_DIRECT_MODE = 2'b00;
	localparam [1:0] kronos_types_PRIVILEGE_MACHINE = 2'b11;
	always @(posedge clk)
		if (~rstz) begin
			mstatus[0] <= 1'b0;
			mstatus[1] <= 1'b0;
			mstatus[3-:2] <= kronos_types_PRIVILEGE_MACHINE;
			mip <= 1'sb0;
			mie <= 1'sb0;
			mtvec[31-:30] <= BOOT_ADDR[31:2];
			mtvec[1-:2] <= kronos_types_DIRECT_MODE;
		end
		else begin
			if (csr_wr_en)
				case (addr)
					kronos_types_MSTATUS: begin
						mstatus[0] <= csr_wr_data[3];
						mstatus[1] <= csr_wr_data[7];
					end
					kronos_types_MIE: begin
						mie[0] <= csr_wr_data[3];
						mie[1] <= csr_wr_data[7];
						mie[2] <= csr_wr_data[11];
					end
					kronos_types_MTVEC: mtvec[31-:30] <= csr_wr_data[31:2];
					kronos_types_MSCRATCH: mscratch <= csr_wr_data;
					kronos_types_MEPC: mepc <= {csr_wr_data[31:2], 2'b00};
					kronos_types_MCAUSE: mcause <= csr_wr_data;
					kronos_types_MTVAL: mtval <= csr_wr_data;
				endcase
			else if (activate_trap) begin
				mstatus[0] <= 1'b0;
				mstatus[1] <= mstatus[0];
				mepc <= {decode[180:151], 2'b00};
				mcause <= trap_cause;
				mtval <= trap_value;
			end
			else if (return_trap) begin
				mstatus[0] <= mstatus[1];
				mstatus[1] <= 1'b1;
			end
			mip[0] <= (software_interrupt & mstatus[0]) & mie[0];
			mip[1] <= (timer_interrupt & mstatus[0]) & mie[1];
			mip[2] <= (external_interrupt & mstatus[0]) & mie[2];
		end
	localparam [3:0] kronos_types_EXTERNAL_INTERRUPT = 4'd11;
	localparam [3:0] kronos_types_SOFTWARE_INTERRUPT = 4'd3;
	localparam [3:0] kronos_types_TIMER_INTERRUPT = 4'd7;
	always @(posedge clk)
		if (~rstz)
			core_interrupt <= 1'b0;
		else begin
			core_interrupt <= |{mip};
			if (mip[2])
				core_interrupt_cause <= kronos_types_EXTERNAL_INTERRUPT;
			else if (mip[0])
				core_interrupt_cause <= kronos_types_SOFTWARE_INTERRUPT;
			else if (mip[1])
				core_interrupt_cause <= kronos_types_TIMER_INTERRUPT;
		end
	assign mcycle_wrenl = csr_wr_en && (addr == kronos_types_MCYCLE);
	assign mcycle_wrenh = csr_wr_en && (addr == kronos_types_MCYCLEH);
	kronos_counter64 #(
		.EN_COUNTERS(EN_COUNTERS),
		.EN_COUNTERS64B(EN_COUNTERS64B)
	) u_hpmcounter0(
		.clk(clk),
		.rstz(rstz),
		.incr(1'b1),
		.load_data(csr_wr_data),
		.load_low(mcycle_wrenl),
		.load_high(mcycle_wrenh),
		.count(mcycle),
		.count_vld(mcycle_rd_vld)
	);
	assign minstret_wrenl = csr_wr_en && (addr == kronos_types_MINSTRET);
	assign minstret_wrenh = csr_wr_en && (addr == kronos_types_MINSTRETH);
	kronos_counter64 #(
		.EN_COUNTERS(EN_COUNTERS),
		.EN_COUNTERS64B(EN_COUNTERS64B)
	) u_hpmcounter1(
		.clk(clk),
		.rstz(rstz),
		.incr(instret),
		.load_data(csr_wr_data),
		.load_low(minstret_wrenl),
		.load_high(minstret_wrenh),
		.count(minstret),
		.count_vld(minstret_rd_vld)
	);
endmodule
module kronos_EX (
	clk,
	rstz,
	decode,
	decode_vld,
	decode_rdy,
	regwr_data,
	regwr_sel,
	regwr_en,
	regwr_pending,
	branch_target,
	branch,
	data_addr,
	data_rd_data,
	data_wr_data,
	data_mask,
	data_wr_en,
	data_req,
	data_ack,
	software_interrupt,
	timer_interrupt,
	external_interrupt
);
	parameter [31:0] BOOT_ADDR = 32'h00000000;
	parameter EN_COUNTERS = 1;
	parameter EN_COUNTERS64B = 1;
	input clk;
	input rstz;
	input [180:0] decode;
	input decode_vld;
	output decode_rdy;
	output reg [31:0] regwr_data;
	output reg [4:0] regwr_sel;
	output reg regwr_en;
	output regwr_pending;
	output [31:0] branch_target;
	output branch;
	output [31:0] data_addr;
	input [31:0] data_rd_data;
	output [31:0] data_wr_data;
	output [3:0] data_mask;
	output data_wr_en;
	output data_req;
	input data_ack;
	input software_interrupt;
	input timer_interrupt;
	input external_interrupt;
	wire [31:0] result;
	wire [4:0] rd;
	wire instr_vld;
	wire instr_jump;
	wire basic_rdy;
	wire lsu_vld;
	wire lsu_rdy;
	wire [31:0] load_data;
	wire regwr_lsu;
	wire csr_vld;
	wire csr_rdy;
	wire [31:0] csr_data;
	wire regwr_csr;
	reg instret;
	wire core_interrupt;
	wire [3:0] core_interrupt_cause;
	wire exception;
	wire activate_trap;
	wire return_trap;
	reg [31:0] trap_cause;
	wire [31:0] trap_handle;
	reg [31:0] trap_value;
	wire trap_jump;
	wire regwr_pending_firstcycle;
	reg regwr_pending_later;
	reg [2:0] state;
	reg [2:0] next_state;
	assign rd = decode[128:124];
	always @(posedge clk)
		if (~rstz)
			state <= 3'd0;
		else
			state <= next_state;
	localparam [1:0] kronos_types_EBREAK = 2'b01;
	localparam [1:0] kronos_types_ECALL = 2'b00;
	localparam [1:0] kronos_types_MRET = 2'b10;
	localparam [1:0] kronos_types_WFI = 2'b11;
	always @(*) begin
		next_state = state;
		case (state)
			3'd0:
				if (decode_vld) begin
					if (core_interrupt)
						next_state = 3'd3;
					else if (exception)
						next_state = 3'd3;
					else if (decode[5])
						case (decode[4-:2])
							kronos_types_ECALL, kronos_types_EBREAK: next_state = 3'd3;
							kronos_types_MRET: next_state = 3'd4;
							kronos_types_WFI: next_state = 3'd5;
						endcase
					else if (decode[12] || decode[11])
						next_state = 3'd1;
					else if (decode[6])
						next_state = 3'd2;
				end
			3'd1:
				if (lsu_rdy)
					next_state = 3'd0;
			3'd2:
				if (csr_rdy)
					next_state = 3'd0;
			3'd5:
				if (core_interrupt)
					next_state = 3'd3;
			3'd3: next_state = 3'd6;
			3'd4: next_state = 3'd6;
			3'd6:
				if (trap_jump)
					next_state = 3'd0;
		endcase
	end
	assign instr_vld = ((decode_vld && (state == 3'd0)) && ~exception) && ~core_interrupt;
	assign basic_rdy = instr_vld && decode[20];
	assign decode_rdy = |{basic_rdy, lsu_rdy, csr_rdy};
	kronos_alu u_alu(
		.op1(decode[116-:32]),
		.op2(decode[84-:32]),
		.aluop(decode[19-:4]),
		.result(result)
	);
	assign lsu_vld = instr_vld || (state == 3'd1);
	kronos_lsu u_lsu(
		.decode(decode),
		.lsu_vld(lsu_vld),
		.lsu_rdy(lsu_rdy),
		.load_data(load_data),
		.regwr_lsu(regwr_lsu),
		.data_addr(data_addr),
		.data_rd_data(data_rd_data),
		.data_wr_data(data_wr_data),
		.data_mask(data_mask),
		.data_wr_en(data_wr_en),
		.data_req(data_req),
		.data_ack(data_ack)
	);
	assign regwr_pending_firstcycle = (decode_vld && decode_rdy) & ((decode[15] | regwr_lsu) | regwr_csr);
	assign regwr_pending = regwr_pending_firstcycle | (~(decode_vld && decode_rdy) && regwr_pending_later);
	always @(posedge clk)
		if (~rstz) begin
			regwr_en <= 1'b0;
			regwr_pending_later <= 1'b0;
		end
		else begin
			regwr_sel <= rd;
			if (decode_vld && decode_rdy)
				regwr_pending_later <= (regwr_lsu && ~lsu_rdy) | (regwr_csr && ~csr_rdy);
			if (instr_vld && decode[15]) begin
				regwr_en <= 1'b1;
				regwr_data <= result;
			end
			else if (lsu_rdy && regwr_lsu) begin
				regwr_pending_later <= 1'b0;
				regwr_en <= 1'b1;
				regwr_data <= load_data;
			end
			else if (csr_rdy && regwr_csr) begin
				regwr_pending_later <= 1'b0;
				regwr_en <= 1'b1;
				regwr_data <= csr_data;
			end
			else
				regwr_en <= 1'b0;
		end
	assign branch_target = (trap_jump ? trap_handle : decode[52-:32]);
	assign instr_jump = decode[14] || decode[13];
	assign branch = (instr_vld && instr_jump) || trap_jump;
	assign exception = (decode[2] || decode[0]) || (instr_jump && decode[1]);
	localparam [3:0] kronos_types_BREAKPOINT = 4'd3;
	localparam [3:0] kronos_types_ECALL_MACHINE = 4'd11;
	localparam [3:0] kronos_types_ILLEGAL_INSTR = 4'd2;
	localparam [3:0] kronos_types_INSTR_ADDR_MISALIGNED = 4'd0;
	localparam [3:0] kronos_types_LOAD_ADDR_MISALIGNED = 4'd4;
	localparam [3:0] kronos_types_STORE_ADDR_MISALIGNED = 4'd6;
	always @(posedge clk)
		if (decode_vld && (state == 3'd0)) begin
			if (core_interrupt) begin
				trap_cause <= {28'b1000000000000000000000000000, core_interrupt_cause};
				trap_value <= 1'sb0;
			end
			else if (decode[2]) begin
				trap_cause <= {28'b0000000000000000000000000000, kronos_types_ILLEGAL_INSTR};
				trap_value <= decode[148-:32];
			end
			else if (decode[1] && instr_jump) begin
				trap_cause <= {28'b0000000000000000000000000000, kronos_types_INSTR_ADDR_MISALIGNED};
				trap_value <= decode[52-:32];
			end
			else if (decode[0] && decode[12]) begin
				trap_cause <= {28'b0000000000000000000000000000, kronos_types_LOAD_ADDR_MISALIGNED};
				trap_value <= decode[52-:32];
			end
			else if (decode[0] && decode[11]) begin
				trap_cause <= {28'b0000000000000000000000000000, kronos_types_STORE_ADDR_MISALIGNED};
				trap_value <= decode[52-:32];
			end
			else if (decode[4-:2] == kronos_types_ECALL) begin
				trap_cause <= {28'b0000000000000000000000000000, kronos_types_ECALL_MACHINE};
				trap_value <= 1'sb0;
			end
			else if (decode[4-:2] == kronos_types_EBREAK) begin
				trap_cause <= {28'b0000000000000000000000000000, kronos_types_BREAKPOINT};
				trap_value <= decode[180-:32];
			end
		end
		else if (state == 3'd5) begin
			if (core_interrupt) begin
				trap_cause <= {28'b1000000000000000000000000000, core_interrupt_cause};
				trap_value <= 1'sb0;
			end
		end
	assign csr_vld = instr_vld || (state == 3'd2);
	kronos_csr #(
		.BOOT_ADDR(BOOT_ADDR),
		.EN_COUNTERS(EN_COUNTERS),
		.EN_COUNTERS64B(EN_COUNTERS64B)
	) u_csr(
		.clk(clk),
		.rstz(rstz),
		.decode(decode),
		.csr_vld(csr_vld),
		.csr_rdy(csr_rdy),
		.csr_data(csr_data),
		.regwr_csr(regwr_csr),
		.instret(instret),
		.activate_trap(activate_trap),
		.return_trap(return_trap),
		.trap_cause(trap_cause),
		.trap_value(trap_value),
		.trap_handle(trap_handle),
		.trap_jump(trap_jump),
		.software_interrupt(software_interrupt),
		.timer_interrupt(timer_interrupt),
		.external_interrupt(external_interrupt),
		.core_interrupt(core_interrupt),
		.core_interrupt_cause(core_interrupt_cause)
	);
	assign activate_trap = state == 3'd3;
	assign return_trap = state == 3'd4;
	always @(posedge clk)
		if (~rstz)
			instret <= 1'b0;
		else
			instret <= (decode_vld && decode_rdy) || (decode[5] && trap_jump);
endmodule
module kronos_hcu (
	clk,
	rstz,
	flush,
	instr,
	regrd_rs1_en,
	regrd_rs2_en,
	fetch_vld,
	fetch_rdy,
	decode_vld,
	decode_rdy,
	regwr_sel,
	regwr_en,
	regwr_pending,
	stall
);
	input clk;
	input rstz;
	input flush;
	input [31:0] instr;
	input regrd_rs1_en;
	input regrd_rs2_en;
	input fetch_vld;
	input fetch_rdy;
	input decode_vld;
	input decode_rdy;
	input [4:0] regwr_sel;
	input regwr_en;
	input regwr_pending;
	output stall;
	wire [4:0] OP;
	wire [4:0] rs1;
	wire [4:0] rs2;
	wire [4:0] rd;
	wire [2:0] funct3;
	wire is_reg_write;
	wire csr_regwr;
	wire rs1_hazard;
	wire rs2_hazard;
	reg [4:0] rpend;
	assign OP = instr[6:2];
	assign rs1 = instr[19:15];
	assign rs2 = instr[24:20];
	assign rd = instr[11:7];
	assign funct3 = instr[14:12];
	localparam [4:0] kronos_types_INSTR_AUIPC = 5'b00101;
	localparam [4:0] kronos_types_INSTR_JAL = 5'b11011;
	localparam [4:0] kronos_types_INSTR_JALR = 5'b11001;
	localparam [4:0] kronos_types_INSTR_LOAD = 5'b00000;
	localparam [4:0] kronos_types_INSTR_LUI = 5'b01101;
	localparam [4:0] kronos_types_INSTR_OP = 5'b01100;
	localparam [4:0] kronos_types_INSTR_OPIMM = 5'b00100;
	assign is_reg_write = (rd != {5 {1'sb0}}) && ((((((((OP == kronos_types_INSTR_LUI) || (OP == kronos_types_INSTR_AUIPC)) || (OP == kronos_types_INSTR_JAL)) || (OP == kronos_types_INSTR_JALR)) || (OP == kronos_types_INSTR_OPIMM)) || (OP == kronos_types_INSTR_OP)) || (OP == kronos_types_INSTR_LOAD)) || csr_regwr);
	localparam [4:0] kronos_types_INSTR_SYS = 5'b11100;
	assign csr_regwr = (OP == kronos_types_INSTR_SYS) && ((((((funct3 == 3'b001) || (funct3 == 3'b010)) || (funct3 == 3'b011)) || (funct3 == 3'b101)) || (funct3 == 3'b110)) || (funct3 == 3'b111));
	assign rs1_hazard = (regrd_rs1_en & regwr_pending) & (rpend == rs1);
	assign rs2_hazard = (regrd_rs2_en & regwr_pending) & (rpend == rs2);
	assign stall = (rs1_hazard | rs2_hazard) & ~(regwr_en & ~(decode_vld && decode_rdy));
	always @(posedge clk)
		if (fetch_vld && fetch_rdy)
			rpend <= rd;
endmodule
module kronos_ID (
	clk,
	rstz,
	flush,
	fetch,
	immediate,
	regrd_rs1,
	regrd_rs2,
	regrd_rs1_en,
	regrd_rs2_en,
	fetch_vld,
	fetch_rdy,
	decode,
	decode_vld,
	decode_rdy,
	regwr_data,
	regwr_sel,
	regwr_en,
	regwr_pending
);
	parameter CATCH_ILLEGAL_INSTR = 1;
	parameter CATCH_MISALIGNED_JMP = 1;
	parameter CATCH_MISALIGNED_LDST = 1;
	input clk;
	input rstz;
	input flush;
	input [63:0] fetch;
	input [31:0] immediate;
	input [31:0] regrd_rs1;
	input [31:0] regrd_rs2;
	input regrd_rs1_en;
	input regrd_rs2_en;
	input fetch_vld;
	output fetch_rdy;
	output reg [180:0] decode;
	output reg decode_vld;
	input decode_rdy;
	input [31:0] regwr_data;
	input [4:0] regwr_sel;
	input regwr_en;
	input regwr_pending;
	wire [31:0] IR;
	wire [31:0] PC;
	wire [4:0] OP;
	wire [6:0] opcode;
	wire [4:0] rs1;
	wire [4:0] rs2;
	wire [4:0] rd;
	wire [2:0] funct3;
	wire [6:0] funct7;
	wire [1:0] data_size;
	reg [31:0] op1;
	reg [31:0] op2;
	reg [3:0] aluop;
	wire regwr_alu;
	wire branch;
	reg csr;
	reg [1:0] sysop;
	reg is_fencei;
	wire illegal;
	reg instr_valid;
	wire illegal_opcode;
	wire [31:0] addr;
	reg [31:0] base;
	reg [31:0] offset;
	wire misaligned_jmp;
	wire misaligned_ldst;
	reg [3:0] mask;
	reg [1:0] byte_addr;
	reg [31:0] sdata;
	reg [31:0] store_data;
	wire rs1_forward;
	wire rs2_forward;
	wire [31:0] rs1_data;
	wire [31:0] rs2_data;
	wire stall;
	assign IR = fetch[31-:32];
	assign PC = fetch[63-:32];
	assign opcode = IR[6:0];
	assign OP = opcode[6:2];
	assign rs1 = IR[19:15];
	assign rs2 = IR[24:20];
	assign rd = IR[11:7];
	assign funct3 = IR[14:12];
	assign funct7 = IR[31:25];
	assign data_size = funct3[1:0];
	assign illegal_opcode = opcode[1:0] != 2'b11;
	localparam [4:0] kronos_types_INSTR_AUIPC = 5'b00101;
	localparam [4:0] kronos_types_INSTR_JAL = 5'b11011;
	localparam [4:0] kronos_types_INSTR_JALR = 5'b11001;
	localparam [4:0] kronos_types_INSTR_LUI = 5'b01101;
	localparam [4:0] kronos_types_INSTR_OP = 5'b01100;
	localparam [4:0] kronos_types_INSTR_OPIMM = 5'b00100;
	assign regwr_alu = (rd != {5 {1'sb0}}) && ((((((OP == kronos_types_INSTR_LUI) || (OP == kronos_types_INSTR_AUIPC)) || (OP == kronos_types_INSTR_JAL)) || (OP == kronos_types_INSTR_JALR)) || (OP == kronos_types_INSTR_OPIMM)) || (OP == kronos_types_INSTR_OP));
	assign rs1_forward = regwr_en & (regwr_sel == rs1);
	assign rs2_forward = regwr_en & (regwr_sel == rs2);
	assign rs1_data = (rs1_forward ? regwr_data : regrd_rs1);
	assign rs2_data = (rs2_forward ? regwr_data : regrd_rs2);
	localparam [3:0] kronos_types_ADD = 4'b0000;
	localparam [2:0] kronos_types_BEQ = 3'b000;
	localparam [2:0] kronos_types_BGE = 3'b101;
	localparam [2:0] kronos_types_BGEU = 3'b111;
	localparam [2:0] kronos_types_BLT = 3'b100;
	localparam [2:0] kronos_types_BLTU = 3'b110;
	localparam [2:0] kronos_types_BNE = 3'b001;
	localparam [1:0] kronos_types_BYTE = 2'b00;
	localparam [1:0] kronos_types_EBREAK = 2'b01;
	localparam [1:0] kronos_types_ECALL = 2'b00;
	localparam [31:0] kronos_types_FOUR = 32'h00000004;
	localparam [1:0] kronos_types_HALF = 2'b01;
	localparam [4:0] kronos_types_INSTR_BR = 5'b11000;
	localparam [4:0] kronos_types_INSTR_LOAD = 5'b00000;
	localparam [4:0] kronos_types_INSTR_MISC = 5'b00011;
	localparam [4:0] kronos_types_INSTR_STORE = 5'b01000;
	localparam [4:0] kronos_types_INSTR_SYS = 5'b11100;
	localparam [1:0] kronos_types_MRET = 2'b10;
	localparam [1:0] kronos_types_WFI = 2'b11;
	localparam [31:0] kronos_types_ZERO = 32'h00000000;
	always @(*) begin
		instr_valid = 1'b0;
		is_fencei = 1'b0;
		sysop = 2'b00;
		csr = 1'b0;
		aluop = kronos_types_ADD;
		op1 = PC;
		op2 = kronos_types_FOUR;
		base = PC;
		offset = kronos_types_FOUR;
		byte_addr = addr[1:0];
		sdata = rs2_data;
		case (byte_addr)
			2'b00: store_data = sdata;
			2'b01: store_data = {sdata[0+:24], sdata[24+:8]};
			2'b10: store_data = {sdata[0+:16], sdata[16+:16]};
			2'b11: store_data = {sdata[0+:8], sdata[8+:24]};
		endcase
		if (OP == kronos_types_INSTR_STORE) begin
			if (data_size == kronos_types_BYTE)
				mask = 4'h1 << byte_addr;
			else if (data_size == kronos_types_HALF)
				mask = (byte_addr[1] ? 4'hc : 4'h3);
			else
				mask = 4'hf;
		end
		else
			mask = 4'hf;
		case (OP)
			kronos_types_INSTR_LUI: begin
				op1 = kronos_types_ZERO;
				op2 = immediate;
				instr_valid = 1'b1;
			end
			kronos_types_INSTR_AUIPC: begin
				op2 = immediate;
				instr_valid = 1'b1;
			end
			kronos_types_INSTR_JAL: begin
				op2 = kronos_types_FOUR;
				offset = immediate;
				instr_valid = 1'b1;
			end
			kronos_types_INSTR_JALR: begin
				op2 = kronos_types_FOUR;
				base = rs1_data;
				offset = immediate;
				instr_valid = funct3 == 3'b000;
			end
			kronos_types_INSTR_BR: begin
				offset = immediate;
				case (funct3)
					kronos_types_BEQ, kronos_types_BNE, kronos_types_BLT, kronos_types_BGE, kronos_types_BLTU, kronos_types_BGEU: instr_valid = 1'b1;
				endcase
			end
			kronos_types_INSTR_LOAD: begin
				base = rs1_data;
				offset = immediate;
				case (funct3)
					3'b000, 3'b001, 3'b010, 3'b100, 3'b101: instr_valid = 1'b1;
				endcase
			end
			kronos_types_INSTR_STORE: begin
				op2 = store_data;
				base = rs1_data;
				offset = immediate;
				case (funct3)
					3'b000, 3'b001, 3'b010: instr_valid = 1'b1;
				endcase
			end
			kronos_types_INSTR_OPIMM: begin
				if ((funct3 == 3'b001) || (funct3 == 3'b101))
					aluop = {funct7[5], funct3};
				else
					aluop = {1'b0, funct3};
				op1 = rs1_data;
				op2 = immediate;
				case (funct3)
					3'b000, 3'b010, 3'b011, 3'b100, 3'b110, 3'b111: instr_valid = 1'b1;
					3'b001:
						if (funct7 == 7'd0)
							instr_valid = 1'b1;
					3'b101:
						if (funct7 == 7'd0)
							instr_valid = 1'b1;
						else if (funct7 == 7'd32)
							instr_valid = 1'b1;
				endcase
			end
			kronos_types_INSTR_OP: begin
				aluop = {funct7[5], funct3};
				op1 = rs1_data;
				op2 = rs2_data;
				case (funct3)
					3'b000:
						if (funct7 == 7'd0)
							instr_valid = 1'b1;
						else if (funct7 == 7'd32)
							instr_valid = 1'b1;
					3'b001:
						if (funct7 == 7'd0)
							instr_valid = 1'b1;
					3'b010:
						if (funct7 == 7'd0)
							instr_valid = 1'b1;
					3'b011:
						if (funct7 == 7'd0)
							instr_valid = 1'b1;
					3'b100:
						if (funct7 == 7'd0)
							instr_valid = 1'b1;
					3'b101:
						if (funct7 == 7'd0)
							instr_valid = 1'b1;
						else if (funct7 == 7'd32)
							instr_valid = 1'b1;
					3'b110:
						if (funct7 == 7'd0)
							instr_valid = 1'b1;
					3'b111:
						if (funct7 == 7'd0)
							instr_valid = 1'b1;
				endcase
			end
			kronos_types_INSTR_MISC:
				case (funct3)
					3'b000:
						if (((funct7[6:3] == {4 {1'sb0}}) && (rs1 == {5 {1'sb0}})) && (rd == {5 {1'sb0}}))
							instr_valid = 1'b1;
					3'b001:
						if (((IR[31:20] == 12'b000000000000) && (rs1 == {5 {1'sb0}})) && (rd == {5 {1'sb0}})) begin
							is_fencei = 1'b1;
							instr_valid = 1'b1;
						end
				endcase
			kronos_types_INSTR_SYS:
				case (funct3)
					3'b000:
						if ((rs1 == {5 {1'sb0}}) && (rd == {5 {1'sb0}})) begin
							if (IR[31:20] == 12'h000) begin
								sysop = kronos_types_ECALL;
								instr_valid = 1'b1;
							end
							else if (IR[31:20] == 12'h001) begin
								sysop = kronos_types_EBREAK;
								instr_valid = 1'b1;
							end
							else if (IR[31:20] == 12'h302) begin
								sysop = kronos_types_MRET;
								instr_valid = 1'b1;
							end
							else if (IR[31:20] == 12'h105) begin
								sysop = kronos_types_WFI;
								instr_valid = 1'b1;
							end
						end
					3'b001, 3'b010, 3'b011: begin
						op1 = rs1_data;
						csr = 1'b1;
						instr_valid = 1'b1;
					end
					3'b101, 3'b110, 3'b111: begin
						csr = 1'b1;
						instr_valid = 1'b1;
					end
				endcase
			default:
				;
		endcase
	end
	assign illegal = (CATCH_ILLEGAL_INSTR ? ~instr_valid | illegal_opcode : 1'b0);
	kronos_agu #(
		.CATCH_MISALIGNED_JMP(CATCH_MISALIGNED_JMP),
		.CATCH_MISALIGNED_LDST(CATCH_MISALIGNED_LDST)
	) u_agu(
		.instr(IR),
		.base(base),
		.offset(offset),
		.addr(addr),
		.misaligned_jmp(misaligned_jmp),
		.misaligned_ldst(misaligned_ldst)
	);
	kronos_branch u_branch(
		.op(funct3),
		.rs1(rs1_data),
		.rs2(rs2_data),
		.branch(branch)
	);
	kronos_hcu u_hcu(
		.clk(clk),
		.rstz(rstz),
		.flush(flush),
		.instr(IR),
		.regrd_rs1_en(regrd_rs1_en),
		.regrd_rs2_en(regrd_rs2_en),
		.fetch_vld(fetch_vld),
		.fetch_rdy(fetch_rdy),
		.decode_vld(decode_vld),
		.decode_rdy(decode_rdy),
		.regwr_sel(regwr_sel),
		.regwr_en(regwr_en),
		.regwr_pending(regwr_pending),
		.stall(stall)
	);
	always @(posedge clk)
		if (~rstz)
			decode_vld <= 1'b0;
		else if (flush)
			decode_vld <= 1'b0;
		else if (fetch_vld && fetch_rdy) begin
			decode_vld <= 1'b1;
			decode[180-:32] <= PC;
			decode[148-:32] <= IR;
			decode[20] <= (((((((OP == kronos_types_INSTR_LUI) || (OP == kronos_types_INSTR_AUIPC)) || (OP == kronos_types_INSTR_OPIMM)) || (OP == kronos_types_INSTR_OP)) || (OP == kronos_types_INSTR_BR)) || (OP == kronos_types_INSTR_JAL)) || (OP == kronos_types_INSTR_JALR)) || (OP == kronos_types_INSTR_MISC);
			decode[19-:4] <= aluop;
			decode[15] <= regwr_alu;
			decode[116-:32] <= op1;
			decode[84-:32] <= op2;
			decode[52-:32] <= addr;
			decode[14] <= ((OP == kronos_types_INSTR_JAL) || (OP == kronos_types_INSTR_JALR)) || is_fencei;
			decode[13] <= branch && (OP == kronos_types_INSTR_BR);
			decode[12] <= OP == kronos_types_INSTR_LOAD;
			decode[11] <= OP == kronos_types_INSTR_STORE;
			decode[10-:4] <= mask;
			decode[6] <= csr;
			decode[5] <= (OP == kronos_types_INSTR_SYS) && ~csr;
			decode[4-:2] <= sysop;
			decode[2] <= illegal;
			decode[1] <= misaligned_jmp;
			decode[0] <= misaligned_ldst;
		end
		else if (decode_vld && decode_rdy)
			decode_vld <= 1'b0;
	assign fetch_rdy = (~decode_vld | decode_rdy) & ~stall;
endmodule
module kronos_IF (
	clk,
	rstz,
	instr_addr,
	instr_data,
	instr_req,
	instr_ack,
	fetch,
	immediate,
	regrd_rs1,
	regrd_rs2,
	regrd_rs1_en,
	regrd_rs2_en,
	fetch_vld,
	fetch_rdy,
	branch_target,
	branch,
	regwr_data,
	regwr_sel,
	regwr_en
);
	parameter [31:0] BOOT_ADDR = 32'h00000000;
	parameter FAST_BRANCH = 0;
	input clk;
	input rstz;
	output reg [31:0] instr_addr;
	input [31:0] instr_data;
	output instr_req;
	input instr_ack;
	output reg [63:0] fetch;
	output [31:0] immediate;
	output [31:0] regrd_rs1;
	output [31:0] regrd_rs2;
	output regrd_rs1_en;
	output regrd_rs2_en;
	output reg fetch_vld;
	input fetch_rdy;
	input [31:0] branch_target;
	input branch;
	input [31:0] regwr_data;
	input [4:0] regwr_sel;
	input regwr_en;
	reg [31:0] pc;
	reg [31:0] pc_last;
	reg [31:0] skid_buffer;
	wire pipe_rdy;
	reg instr_vld;
	reg [31:0] next_instr;
	reg [1:0] state;
	reg [1:0] next_state;
	always @(posedge clk)
		if (~rstz) begin
			pc <= BOOT_ADDR;
			pc_last <= 1'sb0;
		end
		else if (branch) begin
			if (FAST_BRANCH) begin
				pc <= branch_target + 32'h00000004;
				pc_last <= branch_target;
			end
			else
				pc <= branch_target;
		end
		else if (next_state == 2'd1) begin
			pc <= pc + 32'h00000004;
			pc_last <= pc;
		end
	always @(posedge clk)
		if (~rstz)
			state <= 2'd0;
		else if (branch)
			state <= (FAST_BRANCH ? 2'd1 : 2'd0);
		else
			state <= next_state;
	always @(*) begin
		next_state = state;
		case (state)
			2'd0: next_state = 2'd1;
			2'd1:
				if (instr_ack) begin
					if (pipe_rdy)
						next_state = 2'd1;
					else
						next_state = 2'd3;
				end
				else
					next_state = 2'd2;
			2'd2:
				if (instr_ack) begin
					if (pipe_rdy)
						next_state = 2'd1;
					else
						next_state = 2'd3;
				end
			2'd3:
				if (fetch_rdy)
					next_state = 2'd1;
		endcase
	end
	always @(posedge clk)
		if (~rstz)
			fetch_vld <= 1'sb0;
		else if (branch)
			fetch_vld <= 1'b0;
		else if (((state == 2'd1) || (state == 2'd2)) && instr_ack) begin
			if (pipe_rdy) begin
				fetch[63-:32] <= pc_last;
				fetch[31-:32] <= instr_data;
				fetch_vld <= 1'b1;
			end
			else
				skid_buffer <= instr_data;
		end
		else if ((state == 2'd3) && fetch_rdy) begin
			fetch[63-:32] <= pc_last;
			fetch[31-:32] <= skid_buffer;
			fetch_vld <= 1'b1;
		end
		else if (fetch_vld && fetch_rdy)
			fetch_vld <= 1'b0;
	assign pipe_rdy = ~fetch_vld || fetch_rdy;
	always @(*)
		if (FAST_BRANCH & branch)
			instr_addr = branch_target;
		else
			instr_addr = (((state == 2'd1) || (state == 2'd2)) && ~instr_ack ? pc_last : pc);
	assign instr_req = 1'b1;
	always @(*)
		if ((((state == 2'd1) || (state == 2'd2)) && instr_ack) && pipe_rdy) begin
			instr_vld = 1'b1;
			next_instr = instr_data;
		end
		else if ((state == 2'd3) && fetch_rdy) begin
			instr_vld = 1'b1;
			next_instr = skid_buffer;
		end
		else begin
			instr_vld = 1'b0;
			next_instr = instr_data;
		end
	kronos_RF u_rf(
		.clk(clk),
		.rstz(rstz),
		.instr_data(next_instr),
		.instr_vld(instr_vld),
		.fetch_rdy(fetch_rdy),
		.immediate(immediate),
		.regrd_rs1(regrd_rs1),
		.regrd_rs2(regrd_rs2),
		.regrd_rs1_en(regrd_rs1_en),
		.regrd_rs2_en(regrd_rs2_en),
		.regwr_data(regwr_data),
		.regwr_sel(regwr_sel),
		.regwr_en(regwr_en)
	);
endmodule
module kronos_lsu (
	decode,
	lsu_vld,
	lsu_rdy,
	load_data,
	regwr_lsu,
	data_addr,
	data_rd_data,
	data_wr_data,
	data_mask,
	data_wr_en,
	data_req,
	data_ack
);
	input [180:0] decode;
	input lsu_vld;
	output lsu_rdy;
	output reg [31:0] load_data;
	output regwr_lsu;
	output [31:0] data_addr;
	input [31:0] data_rd_data;
	output [31:0] data_wr_data;
	output [3:0] data_mask;
	output data_wr_en;
	output data_req;
	input data_ack;
	wire [4:0] rd;
	wire [1:0] byte_addr;
	wire [1:0] data_size;
	wire load_uns;
	wire [31:0] ldata;
	reg [31:0] word_data;
	reg [31:0] half_data;
	reg [31:0] byte_data;
	assign byte_addr = decode[22:21];
	assign data_size = decode[130:129];
	assign load_uns = decode[131];
	assign rd = decode[128:124];
	assign data_addr = {decode[52:23], 2'b00};
	assign data_wr_data = decode[84-:32];
	assign data_mask = decode[10-:4];
	assign data_wr_en = (lsu_vld && decode[11]) && ~data_ack;
	assign data_req = (lsu_vld && (decode[12] | decode[11])) && ~data_ack;
	assign lsu_rdy = data_ack;
	assign regwr_lsu = decode[12] && (rd != {5 {1'sb0}});
	assign ldata = data_rd_data;
	always @(*)
		case (byte_addr)
			2'b00: word_data = ldata;
			2'b01: word_data = {ldata[0+:8], ldata[8+:24]};
			2'b10: word_data = {ldata[0+:16], ldata[16+:16]};
			2'b11: word_data = {ldata[0+:24], ldata[24+:8]};
		endcase
	always @(*) begin
		if (load_uns)
			byte_data = {24'b000000000000000000000000, word_data[7:0]};
		else
			byte_data = {{24 {word_data[7]}}, word_data[7:0]};
		if (load_uns)
			half_data = {16'b0000000000000000, word_data[15:0]};
		else
			half_data = {{16 {word_data[15]}}, word_data[15:0]};
	end
	localparam [1:0] kronos_types_BYTE = 2'b00;
	localparam [1:0] kronos_types_HALF = 2'b01;
	always @(*)
		if (data_size == kronos_types_BYTE)
			load_data = byte_data;
		else if (data_size == kronos_types_HALF)
			load_data = half_data;
		else
			load_data = word_data;
endmodule
module kronos_RF (
	clk,
	rstz,
	instr_data,
	instr_vld,
	fetch_rdy,
	immediate,
	regrd_rs1,
	regrd_rs2,
	regrd_rs1_en,
	regrd_rs2_en,
	regwr_data,
	regwr_sel,
	regwr_en
);
	input clk;
	input rstz;
	input [31:0] instr_data;
	input instr_vld;
	input fetch_rdy;
	output reg [31:0] immediate;
	output reg [31:0] regrd_rs1;
	output reg [31:0] regrd_rs2;
	output reg regrd_rs1_en;
	output reg regrd_rs2_en;
	input [31:0] regwr_data;
	input [4:0] regwr_sel;
	input regwr_en;
	reg reg_vld;
	wire instr_rdy;
	reg [4:0] reg_rs1;
	reg [4:0] reg_rs2;
	wire [31:0] IR;
	wire [4:0] OP;
	wire [4:0] rs1;
	wire [4:0] rs2;
	wire [2:0] funct3;
	reg ImmA;
	reg [3:0] ImmB;
	reg [5:0] ImmC;
	reg ImmD;
	reg [7:0] ImmE;
	reg [11:0] ImmF;
	wire [31:0] Imm;
	wire sign;
	reg format_I;
	reg format_J;
	reg format_S;
	reg format_B;
	reg format_U;
	wire csr_regrd;
	wire is_regrd_rs1_en;
	wire is_regrd_rs2_en;
	assign IR = instr_data;
	assign OP = IR[6:2];
	assign rs1 = IR[19:15];
	assign rs2 = IR[24:20];
	assign funct3 = IR[14:12];
	assign sign = IR[31];
	localparam [4:0] kronos_types_INSTR_AUIPC = 5'b00101;
	localparam [4:0] kronos_types_INSTR_BR = 5'b11000;
	localparam [4:0] kronos_types_INSTR_JAL = 5'b11011;
	localparam [4:0] kronos_types_INSTR_JALR = 5'b11001;
	localparam [4:0] kronos_types_INSTR_LOAD = 5'b00000;
	localparam [4:0] kronos_types_INSTR_LUI = 5'b01101;
	localparam [4:0] kronos_types_INSTR_OPIMM = 5'b00100;
	localparam [4:0] kronos_types_INSTR_STORE = 5'b01000;
	always @(*) begin
		format_I = ((OP == kronos_types_INSTR_OPIMM) || (OP == kronos_types_INSTR_JALR)) || (OP == kronos_types_INSTR_LOAD);
		format_J = OP == kronos_types_INSTR_JAL;
		format_S = OP == kronos_types_INSTR_STORE;
		format_B = OP == kronos_types_INSTR_BR;
		format_U = (OP == kronos_types_INSTR_LUI) || (OP == kronos_types_INSTR_AUIPC);
		if (format_I)
			ImmA = IR[20];
		else if (format_S)
			ImmA = IR[7];
		else
			ImmA = 1'b0;
		if (format_U)
			ImmB = 4'b0000;
		else if (format_I || format_J)
			ImmB = IR[24:21];
		else
			ImmB = IR[11:8];
		if (format_U)
			ImmC = 6'b000000;
		else
			ImmC = IR[30:25];
		if (format_U)
			ImmD = 1'b0;
		else if (format_B)
			ImmD = IR[7];
		else if (format_J)
			ImmD = IR[20];
		else
			ImmD = sign;
		if (format_U || format_J)
			ImmE = IR[19:12];
		else
			ImmE = {8 {sign}};
		if (format_U)
			ImmF = IR[31:20];
		else
			ImmF = {12 {sign}};
	end
	assign Imm = {ImmF, ImmE, ImmD, ImmC, ImmB, ImmA};
	localparam [4:0] kronos_types_INSTR_SYS = 5'b11100;
	assign csr_regrd = (OP == kronos_types_INSTR_SYS) && (((funct3 == 3'b001) || (funct3 == 3'b010)) || (funct3 == 3'b011));
	localparam [4:0] kronos_types_INSTR_OP = 5'b01100;
	assign is_regrd_rs1_en = ((((((OP == kronos_types_INSTR_OPIMM) || (OP == kronos_types_INSTR_OP)) || (OP == kronos_types_INSTR_JALR)) || (OP == kronos_types_INSTR_BR)) || (OP == kronos_types_INSTR_LOAD)) || (OP == kronos_types_INSTR_STORE)) || csr_regrd;
	assign is_regrd_rs2_en = ((OP == kronos_types_INSTR_OP) || (OP == kronos_types_INSTR_BR)) || (OP == kronos_types_INSTR_STORE);
	reg [31:0] REG [0:31];
	always @(posedge clk)
		if (~rstz)
			reg_vld <= 1'b0;
		else if (instr_vld && instr_rdy) begin
			reg_vld <= 1'b1;
			immediate <= Imm;
			if (rs1 == 0)
				regrd_rs1 <= 1'sb0;
			else if (regwr_en && (rs1 == regwr_sel))
				regrd_rs1 <= regwr_data;
			else
				regrd_rs1 <= REG[rs1];
			if (rs2 == 0)
				regrd_rs2 <= 1'sb0;
			else if (regwr_en && (rs2 == regwr_sel))
				regrd_rs2 <= regwr_data;
			else
				regrd_rs2 <= REG[rs2];
			regrd_rs1_en <= is_regrd_rs1_en;
			regrd_rs2_en <= is_regrd_rs2_en;
			reg_rs1 <= rs1;
			reg_rs2 <= rs2;
		end
		else if (reg_vld && regwr_en) begin
			if (reg_rs1 == regwr_sel)
				regrd_rs1 <= regwr_data;
			if (reg_rs2 == regwr_sel)
				regrd_rs2 <= regwr_data;
		end
		else if (reg_vld && fetch_rdy)
			reg_vld <= 1'b0;
	assign instr_rdy = ~reg_vld | fetch_rdy;
	always @(posedge clk)
		if (regwr_en)
			REG[regwr_sel] <= regwr_data;
endmodule
module kronos_agu (
	instr,
	base,
	offset,
	addr,
	misaligned_jmp,
	misaligned_ldst
);
	parameter CATCH_MISALIGNED_JMP = 1;
	parameter CATCH_MISALIGNED_LDST = 1;
	input [31:0] instr;
	input [31:0] base;
	input [31:0] offset;
	output reg [31:0] addr;
	output misaligned_jmp;
	output reg misaligned_ldst;
	wire [4:0] OP;
	wire [1:0] data_size;
	wire align;
	reg [31:0] addr_raw;
	wire [1:0] byte_addr;
	assign OP = instr[6:2];
	assign data_size = instr[13:12];
	localparam [4:0] kronos_types_INSTR_JALR = 5'b11001;
	assign align = OP == kronos_types_INSTR_JALR;
	always @(*) begin
		addr_raw = base + offset;
		addr[31:1] = addr_raw[31:1];
		addr[0] = ~align & addr_raw[0];
	end
	assign byte_addr = addr[1:0];
	localparam [4:0] kronos_types_INSTR_BR = 5'b11000;
	localparam [4:0] kronos_types_INSTR_JAL = 5'b11011;
	generate
		if (CATCH_MISALIGNED_JMP) begin : genblk1
			assign misaligned_jmp = (((OP == kronos_types_INSTR_JAL) || (OP == kronos_types_INSTR_JALR)) || (OP == kronos_types_INSTR_BR)) && (byte_addr != 2'b00);
		end
		else begin : genblk1
			assign misaligned_jmp = 1'b0;
		end
	endgenerate
	localparam [1:0] kronos_types_HALF = 2'b01;
	localparam [4:0] kronos_types_INSTR_LOAD = 5'b00000;
	localparam [4:0] kronos_types_INSTR_STORE = 5'b01000;
	localparam [1:0] kronos_types_WORD = 2'b10;
	generate
		if (CATCH_MISALIGNED_LDST) begin : genblk2
			always @(*)
				if ((OP == kronos_types_INSTR_LOAD) || (OP == kronos_types_INSTR_STORE)) begin
					if ((data_size == kronos_types_WORD) && (byte_addr != 2'b00))
						misaligned_ldst = 1'b1;
					else if ((data_size == kronos_types_HALF) && (byte_addr[0] != 1'b0))
						misaligned_ldst = 1'b1;
					else
						misaligned_ldst = 1'b0;
				end
				else
					misaligned_ldst = 1'b0;
		end
		else begin : genblk2
			wire [1:1] sv2v_tmp_6C1DA;
			assign sv2v_tmp_6C1DA = 1'b0;
			always @(*) misaligned_ldst = sv2v_tmp_6C1DA;
		end
	endgenerate
endmodule
module kronos_mem_top (
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
	software_interrupt,
	timer_interrupt,
	external_interrupt
);
	localparam [31:0] InstrMemAw = 20;
	localparam [31:0] DataMemAw = 20;
	input clk_i;
	input rst_ni;
	output data_mem_req;
	input data_mem_gnt;
	output [19:0] data_mem_addr;
	output [31:0] data_mem_wdata;
	output [31:0] data_mem_strb;
	output data_mem_we;
	input [31:0] data_mem_rdata;
	output instr_mem_req;
	input instr_mem_gnt;
	output [19:0] instr_mem_addr;
	output [31:0] instr_mem_wdata;
	output [31:0] instr_mem_strb;
	output instr_mem_we;
	input [31:0] instr_mem_rdata;
	input software_interrupt;
	input timer_interrupt;
	input external_interrupt;
	wire [31:0] instr_addr;
	wire [31:0] instr_data;
	wire instr_req;
	wire instr_ack;
	wire [31:0] data_addr;
	wire [31:0] data_rd_data;
	wire [31:0] data_wr_data;
	wire [3:0] data_mask;
	wire data_wr_en;
	wire data_req;
	wire data_ack;
	wire instr_ack_d;
	reg instr_ack_q;
	wire data_ack_d;
	reg data_ack_q;
	assign instr_ack_d = instr_mem_req;
	assign data_ack_d = data_mem_req;
	always @(posedge clk_i or negedge rst_ni)
		if (~rst_ni) begin
			instr_ack_q <= 1'sb0;
			data_ack_q <= 1'sb0;
		end
		else begin
			instr_ack_q <= instr_ack_d;
			data_ack_q <= data_ack_d;
		end
	assign instr_mem_req = instr_req;
	assign instr_ack = instr_ack_q;
	assign instr_mem_addr = instr_addr;
	assign instr_mem_wdata = 1'sb0;
	assign instr_mem_strb = 1'sb0;
	assign instr_mem_we = 1'sb0;
	assign instr_data = instr_mem_rdata;
	assign data_mem_req = data_req;
	assign data_ack = data_ack_q;
	assign data_mem_addr = data_addr;
	assign data_mem_wdata = data_wr_data;
	assign data_mem_strb = {{8 {data_mask[3]}}, {8 {data_mask[2]}}, {8 {data_mask[1]}}, {8 {data_mask[0]}}};
	assign data_mem_we = data_wr_en;
	assign data_rd_data = data_mem_rdata;
	kronos_core #(
		.BOOT_ADDR(32'h80000000),
		.FAST_BRANCH(1),
		.EN_COUNTERS(1),
		.EN_COUNTERS64B(1),
		.CATCH_ILLEGAL_INSTR(1),
		.CATCH_MISALIGNED_JMP(1),
		.CATCH_MISALIGNED_LDST(1)
	) i_kronos_core(
		.clk(clk_i),
		.rstz(rst_ni),
		.instr_addr(instr_addr),
		.instr_data(instr_data),
		.instr_req(instr_req),
		.instr_ack(instr_ack),
		.data_addr(data_addr),
		.data_rd_data(data_rd_data),
		.data_wr_data(data_wr_data),
		.data_mask(data_mask),
		.data_wr_en(data_wr_en),
		.data_req(data_req),
		.data_ack(data_ack),
		.software_interrupt(software_interrupt),
		.timer_interrupt(timer_interrupt),
		.external_interrupt(external_interrupt)
	);
endmodule
