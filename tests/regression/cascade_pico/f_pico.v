module picorv32_tiny_soc #(
    parameter i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS=1,
    parameter i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS64=1,
    parameter i_picorv32_mem_top___i_picorv32___ENABLE_REGS_16_31=1,
    parameter i_picorv32_mem_top___i_picorv32___ENABLE_REGS_DUALPORT=1,
    parameter i_picorv32_mem_top___i_picorv32___LATCHED_MEM_RDATA=0,
    parameter i_picorv32_mem_top___i_picorv32___TWO_STAGE_SHIFT=1,
    parameter i_picorv32_mem_top___i_picorv32___BARREL_SHIFTER=0,
    parameter i_picorv32_mem_top___i_picorv32___TWO_CYCLE_COMPARE=0,
    parameter i_picorv32_mem_top___i_picorv32___TWO_CYCLE_ALU=0,
    parameter i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA=1,
    parameter i_picorv32_mem_top___i_picorv32___CATCH_MISALIGN=1,
    parameter i_picorv32_mem_top___i_picorv32___CATCH_ILLINSN=1,
    parameter i_picorv32_mem_top___i_picorv32___ENABLE_PCPI=0,
    parameter i_picorv32_mem_top___i_picorv32___ENABLE_MUL=1,
    parameter i_picorv32_mem_top___i_picorv32___ENABLE_FAST_MUL=0,
    parameter i_picorv32_mem_top___i_picorv32___ENABLE_DIV=1,
    parameter i_picorv32_mem_top___i_picorv32___ENABLE_IRQ=0,
    parameter i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_QREGS=1,
    parameter i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_TIMER=1,
    parameter i_picorv32_mem_top___i_picorv32___ENABLE_TRACE=0,
    parameter i_picorv32_mem_top___i_picorv32___REGS_INIT_ZERO=0,
    parameter i_picorv32_mem_top___i_picorv32___MASKED_IRQ=32'h00000000,
    parameter i_picorv32_mem_top___i_picorv32___LATCHED_IRQ=32'hffffffff,
    parameter i_picorv32_mem_top___i_picorv32___PROGADDR_RESET=32'h80000000,
    parameter i_picorv32_mem_top___i_picorv32___PROGADDR_IRQ=32'h00000010,
    parameter i_picorv32_mem_top___i_picorv32___STACKADDR=32'hffffffff,
    parameter i_picorv32_mem_top___i_picorv32___irq_timer=0,
    parameter i_picorv32_mem_top___i_picorv32___irq_ebreak=1,
    parameter i_picorv32_mem_top___i_picorv32___irq_buserror=2,
    parameter i_picorv32_mem_top___i_picorv32___irqregs_offset=(ENABLE_REGS_16_31?32:16),
    parameter i_picorv32_mem_top___i_picorv32___regfile_size=(ENABLE_REGS_16_31?32:16)+((4*ENABLE_IRQ)*ENABLE_IRQ_QREGS),
    parameter i_picorv32_mem_top___i_picorv32___regindex_bits=(ENABLE_REGS_16_31?5:4)+(ENABLE_IRQ*ENABLE_IRQ_QREGS),
    parameter i_picorv32_mem_top___i_picorv32___WITH_PCPI=((ENABLE_PCPI||ENABLE_MUL)||ENABLE_FAST_MUL)||ENABLE_DIV,
    parameter i_picorv32_mem_top___i_picorv32___TRACE_BRANCH=36'b000100000000000000000000000000000000,
    parameter i_picorv32_mem_top___i_picorv32___TRACE_ADDR=36'b001000000000000000000000000000000000,
    parameter i_picorv32_mem_top___i_picorv32___TRACE_IRQ=36'b100000000000000000000000000000000000,
    parameter i_picorv32_mem_top___i_picorv32___cpu_state_trap=8'b10000000,
    parameter i_picorv32_mem_top___i_picorv32___cpu_state_fetch=8'b01000000,
    parameter i_picorv32_mem_top___i_picorv32___cpu_state_ld_rs1=8'b00100000,
    parameter i_picorv32_mem_top___i_picorv32___cpu_state_ld_rs2=8'b00010000,
    parameter i_picorv32_mem_top___i_picorv32___cpu_state_exec=8'b00001000,
    parameter i_picorv32_mem_top___i_picorv32___cpu_state_shift=8'b00000100,
    parameter i_picorv32_mem_top___i_picorv32___cpu_state_stmem=8'b00000010,
    parameter i_picorv32_mem_top___i_picorv32___cpu_state_ldmem=8'b00000001) (
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
	data_mem_rdata,
	irq_i,
	eoi_o
);
	parameter [31:0] InstrMemDepth = 1048576;
	parameter [31:0] DataMemDepth = 1048576;
	input wire clk_i;
	input wire rst_ni;
	output wire instr_mem_req;
	output wire instr_mem_gnt;
	output wire [31:0] instr_mem_addr;
	output wire [31:0] instr_mem_wdata;
	output wire [3:0] instr_mem_strb;
	output wire instr_mem_we;
	output wire [31:0] instr_mem_rdata;
	output wire data_mem_req;
	output wire data_mem_gnt;
	output wire [31:0] data_mem_addr;
	output wire [31:0] data_mem_wdata;
	output wire [3:0] data_mem_strb;
	output wire data_mem_we;
	output wire [31:0] data_mem_rdata;
	input wire [31:0] irq_i;
	output wire [31:0] eoi_o;
	wire trap;
	wire pcpi_valid;
	wire [31:0] pcpi_insn;
	wire [31:0] pcpi_rs1;
	wire [31:0] pcpi_rs2;
	wire pcpi_wr;
	wire [31:0] pcpi_rd;
	wire pcpi_wait;
	wire pcpi_ready;
	assign pcpi_wr = 1'sb0;
	assign pcpi_rd = 1'sb0;
	assign pcpi_wait = 1'sb0;
	assign pcpi_ready = 1'sb0;
	wire [31:0] irq;
	assign irq = 1'sb0;
	wire [31:0] eoi;
	assign eoi_o = eoi;
	wire trace_valid;
	wire [35:0] trace_data;
	
    // INSTANCE: [i_picorv32_mem_top]
    wire i_picorv32_mem_top___clk;
    wire i_picorv32_mem_top___resetn;
    reg i_picorv32_mem_top___trap;
    reg i_picorv32_mem_top___instr_mem_req;
    wire i_picorv32_mem_top___instr_mem_gnt;
    reg[31:0] i_picorv32_mem_top___instr_mem_addr;
    reg[31:0] i_picorv32_mem_top___instr_mem_wdata;
    reg[3:0] i_picorv32_mem_top___instr_mem_strb;
    reg i_picorv32_mem_top___instr_mem_we;
    wire i_picorv32_mem_top___instr_mem_rdata;
    reg i_picorv32_mem_top___data_mem_req;
    wire i_picorv32_mem_top___data_mem_gnt;
    reg[31:0] i_picorv32_mem_top___data_mem_addr;
    reg[31:0] i_picorv32_mem_top___data_mem_wdata;
    reg[3:0] i_picorv32_mem_top___data_mem_strb;
    reg i_picorv32_mem_top___data_mem_we;
    wire i_picorv32_mem_top___data_mem_rdata;
    wire i_picorv32_mem_top___mem_la_read;
    wire i_picorv32_mem_top___mem_la_write;
    wire i_picorv32_mem_top___mem_la_addr;
    reg[31:0] i_picorv32_mem_top___mem_la_wdata;
    reg[3:0] i_picorv32_mem_top___mem_la_wstrb;
    reg i_picorv32_mem_top___pcpi_valid;
    reg[31:0] i_picorv32_mem_top___pcpi_insn;
    wire i_picorv32_mem_top___pcpi_rs1;
    wire i_picorv32_mem_top___pcpi_rs2;
    wire i_picorv32_mem_top___pcpi_wr;
    wire[31:0] i_picorv32_mem_top___pcpi_rd;
    wire i_picorv32_mem_top___pcpi_wait;
    wire i_picorv32_mem_top___pcpi_ready;
    wire[31:0] i_picorv32_mem_top___irq;
    reg[31:0] i_picorv32_mem_top___eoi;
    reg i_picorv32_mem_top___trace_valid;
    reg[35:0] i_picorv32_mem_top___trace_data;
    assign i_picorv32_mem_top___clk = clk_i;
    assign i_picorv32_mem_top___resetn = rst_ni;
    assign trap = i_picorv32_mem_top___trap;
    assign instr_mem_req = i_picorv32_mem_top___instr_mem_req;
    assign i_picorv32_mem_top___instr_mem_gnt = instr_mem_gnt;
    assign instr_mem_addr = i_picorv32_mem_top___instr_mem_addr;
    assign instr_mem_wdata = i_picorv32_mem_top___instr_mem_wdata;
    assign instr_mem_strb = i_picorv32_mem_top___instr_mem_strb;
    assign instr_mem_we = i_picorv32_mem_top___instr_mem_we;
    assign i_picorv32_mem_top___instr_mem_rdata = instr_mem_rdata;
    assign data_mem_req = i_picorv32_mem_top___data_mem_req;
    assign i_picorv32_mem_top___data_mem_gnt = data_mem_gnt;
    assign data_mem_addr = i_picorv32_mem_top___data_mem_addr;
    assign data_mem_wdata = i_picorv32_mem_top___data_mem_wdata;
    assign data_mem_strb = i_picorv32_mem_top___data_mem_strb;
    assign data_mem_we = i_picorv32_mem_top___data_mem_we;
    assign i_picorv32_mem_top___data_mem_rdata = data_mem_rdata;
    assign pcpi_valid = i_picorv32_mem_top___pcpi_valid;
    assign pcpi_insn = i_picorv32_mem_top___pcpi_insn;
    assign pcpi_rs1 = i_picorv32_mem_top___pcpi_rs1;
    assign pcpi_rs2 = i_picorv32_mem_top___pcpi_rs2;
    assign i_picorv32_mem_top___pcpi_wr = pcpi_wr;
    assign i_picorv32_mem_top___pcpi_rd = pcpi_rd;
    assign i_picorv32_mem_top___pcpi_wait = pcpi_wait;
    assign i_picorv32_mem_top___pcpi_ready = pcpi_ready;
    assign i_picorv32_mem_top___irq = irq_i;
    assign eoi = i_picorv32_mem_top___eoi;
    assign trace_valid = i_picorv32_mem_top___trace_valid;
    assign trace_data = i_picorv32_mem_top___trace_data;

    wire i_picorv32_mem_top___mem_valid ; 
    wire i_picorv32_mem_top___mem_instr ; 
    wire i_picorv32_mem_top___mem_ready ; 
    wire[31:0] i_picorv32_mem_top___mem_addr ; 
    wire[31:0] i_picorv32_mem_top___mem_wdata ; 
    wire[3:0] i_picorv32_mem_top___mem_wstrb ; reg[31:0] i_picorv32_mem_top___mem_rdata ; 
    wire i_picorv32_mem_top___mem_ready_d ; 
    reg i_picorv32_mem_top___mem_ready_q ; 
  always @( posedge  i_picorv32_mem_top___clk )
         if ( ~ i_picorv32_mem_top___resetn ) 
             i_picorv32_mem_top___mem_ready_q  <=0;
          else  
             i_picorv32_mem_top___mem_ready_q  <= i_picorv32_mem_top___mem_ready_d ;
  assign  i_picorv32_mem_top___mem_ready_d = i_picorv32_mem_top___mem_valid ; 
  assign  i_picorv32_mem_top___mem_ready = i_picorv32_mem_top___mem_ready_q ; 
  always @(*)
         begin  
             i_picorv32_mem_top___instr_mem_req  =1'sb0; 
             i_picorv32_mem_top___instr_mem_addr  =1'sb0; 
             i_picorv32_mem_top___instr_mem_wdata  =1'sb0; 
             i_picorv32_mem_top___instr_mem_strb  =1'sb0; 
             i_picorv32_mem_top___instr_mem_we  =1'sb0; 
             i_picorv32_mem_top___data_mem_req  =1'sb0; 
             i_picorv32_mem_top___data_mem_addr  =1'sb0; 
             i_picorv32_mem_top___data_mem_wdata  =1'sb0; 
             i_picorv32_mem_top___data_mem_strb  =1'sb0; 
             i_picorv32_mem_top___data_mem_we  =1'sb0; 
             i_picorv32_mem_top___mem_rdata  =1'sb0;
             if ( i_picorv32_mem_top___mem_valid )
                 begin 
                     if ( i_picorv32_mem_top___mem_instr )
                         begin  
                             i_picorv32_mem_top___instr_mem_req  = i_picorv32_mem_top___mem_ready_d & ! i_picorv32_mem_top___mem_ready_q ; 
                             i_picorv32_mem_top___instr_mem_addr  = i_picorv32_mem_top___mem_addr ; 
                             i_picorv32_mem_top___instr_mem_wdata  = i_picorv32_mem_top___mem_wdata ; 
                             i_picorv32_mem_top___instr_mem_strb  = i_picorv32_mem_top___mem_wstrb ; 
                             i_picorv32_mem_top___instr_mem_we  = | i_picorv32_mem_top___mem_wstrb ; 
                             i_picorv32_mem_top___mem_rdata  = i_picorv32_mem_top___instr_mem_rdata ;
                         end 
                      else 
                         begin  
                             i_picorv32_mem_top___data_mem_req  = i_picorv32_mem_top___mem_ready_d & ! i_picorv32_mem_top___mem_ready_q ; 
                             i_picorv32_mem_top___data_mem_addr  = i_picorv32_mem_top___mem_addr ; 
                             i_picorv32_mem_top___data_mem_wdata  = i_picorv32_mem_top___mem_wdata ; 
                             i_picorv32_mem_top___data_mem_strb  = i_picorv32_mem_top___mem_wstrb ; 
                             i_picorv32_mem_top___data_mem_we  = | i_picorv32_mem_top___mem_wstrb ; 
                             i_picorv32_mem_top___mem_rdata  = i_picorv32_mem_top___data_mem_rdata ;
                         end 
                 end 
         end
    wire[1:1] i_picorv32_mem_top___sv2v_tmp_i_picorv32_trap ; 
  always @(*) 
         i_picorv32_mem_top___trap  = i_picorv32_mem_top___sv2v_tmp_i_picorv32_trap ;
    wire[32:1] i_picorv32_mem_top___sv2v_tmp_i_picorv32_mem_la_wdata ; 
  always @(*) 
         i_picorv32_mem_top___mem_la_wdata  = i_picorv32_mem_top___sv2v_tmp_i_picorv32_mem_la_wdata ;
    wire[4:1] i_picorv32_mem_top___sv2v_tmp_i_picorv32_mem_la_wstrb ; 
  always @(*) 
         i_picorv32_mem_top___mem_la_wstrb  = i_picorv32_mem_top___sv2v_tmp_i_picorv32_mem_la_wstrb ;
    wire[1:1] i_picorv32_mem_top___sv2v_tmp_i_picorv32_pcpi_valid ; 
  always @(*) 
         i_picorv32_mem_top___pcpi_valid  = i_picorv32_mem_top___sv2v_tmp_i_picorv32_pcpi_valid ;
    wire[32:1] i_picorv32_mem_top___sv2v_tmp_i_picorv32_pcpi_insn ; 
  always @(*) 
         i_picorv32_mem_top___pcpi_insn  = i_picorv32_mem_top___sv2v_tmp_i_picorv32_pcpi_insn ;
    wire[32:1] i_picorv32_mem_top___sv2v_tmp_i_picorv32_eoi ; 
  always @(*) 
         i_picorv32_mem_top___eoi  = i_picorv32_mem_top___sv2v_tmp_i_picorv32_eoi ;
    wire[1:1] i_picorv32_mem_top___sv2v_tmp_i_picorv32_trace_valid ; 
  always @(*) 
         i_picorv32_mem_top___trace_valid  = i_picorv32_mem_top___sv2v_tmp_i_picorv32_trace_valid ;
    wire[36:1] i_picorv32_mem_top___sv2v_tmp_i_picorv32_trace_data ; 
  always @(*) 
         i_picorv32_mem_top___trace_data  = i_picorv32_mem_top___sv2v_tmp_i_picorv32_trace_data ;
    
    // INSTANCE: [i_picorv32_mem_top___i_picorv32]
    wire i_picorv32_mem_top___i_picorv32___clk;
    wire i_picorv32_mem_top___i_picorv32___resetn;
    reg i_picorv32_mem_top___i_picorv32___trap;
    reg i_picorv32_mem_top___i_picorv32___mem_valid;
    reg i_picorv32_mem_top___i_picorv32___mem_instr;
    wire i_picorv32_mem_top___i_picorv32___mem_ready;
    reg[31:0] i_picorv32_mem_top___i_picorv32___mem_addr;
    reg[31:0] i_picorv32_mem_top___i_picorv32___mem_wdata;
    reg[3:0] i_picorv32_mem_top___i_picorv32___mem_wstrb;
    wire[31:0] i_picorv32_mem_top___i_picorv32___mem_rdata;
    wire i_picorv32_mem_top___i_picorv32___mem_la_read;
    wire i_picorv32_mem_top___i_picorv32___mem_la_write;
    wire i_picorv32_mem_top___i_picorv32___mem_la_addr;
    reg[31:0] i_picorv32_mem_top___i_picorv32___mem_la_wdata;
    reg[3:0] i_picorv32_mem_top___i_picorv32___mem_la_wstrb;
    reg i_picorv32_mem_top___i_picorv32___pcpi_valid;
    reg[31:0] i_picorv32_mem_top___i_picorv32___pcpi_insn;
    wire i_picorv32_mem_top___i_picorv32___pcpi_rs1;
    wire i_picorv32_mem_top___i_picorv32___pcpi_rs2;
    wire i_picorv32_mem_top___i_picorv32___pcpi_wr;
    wire[31:0] i_picorv32_mem_top___i_picorv32___pcpi_rd;
    wire i_picorv32_mem_top___i_picorv32___pcpi_wait;
    wire i_picorv32_mem_top___i_picorv32___pcpi_ready;
    wire[31:0] i_picorv32_mem_top___i_picorv32___irq;
    reg[31:0] i_picorv32_mem_top___i_picorv32___eoi;
    reg i_picorv32_mem_top___i_picorv32___trace_valid;
    reg[35:0] i_picorv32_mem_top___i_picorv32___trace_data;
    assign i_picorv32_mem_top___i_picorv32___clk = i_picorv32_mem_top___clk;
    assign i_picorv32_mem_top___i_picorv32___resetn = i_picorv32_mem_top___resetn;
    assign i_picorv32_mem_top___sv2v_tmp_i_picorv32_trap = i_picorv32_mem_top___i_picorv32___trap;
    assign i_picorv32_mem_top___mem_valid = i_picorv32_mem_top___i_picorv32___mem_valid;
    assign i_picorv32_mem_top___mem_instr = i_picorv32_mem_top___i_picorv32___mem_instr;
    assign i_picorv32_mem_top___i_picorv32___mem_ready = i_picorv32_mem_top___mem_ready;
    assign i_picorv32_mem_top___mem_addr = i_picorv32_mem_top___i_picorv32___mem_addr;
    assign i_picorv32_mem_top___mem_wdata = i_picorv32_mem_top___i_picorv32___mem_wdata;
    assign i_picorv32_mem_top___mem_wstrb = i_picorv32_mem_top___i_picorv32___mem_wstrb;
    assign i_picorv32_mem_top___i_picorv32___mem_rdata = i_picorv32_mem_top___mem_rdata;
    assign i_picorv32_mem_top___mem_la_read = i_picorv32_mem_top___i_picorv32___mem_la_read;
    assign i_picorv32_mem_top___mem_la_write = i_picorv32_mem_top___i_picorv32___mem_la_write;
    assign i_picorv32_mem_top___mem_la_addr = i_picorv32_mem_top___i_picorv32___mem_la_addr;
    assign i_picorv32_mem_top___sv2v_tmp_i_picorv32_mem_la_wdata = i_picorv32_mem_top___i_picorv32___mem_la_wdata;
    assign i_picorv32_mem_top___sv2v_tmp_i_picorv32_mem_la_wstrb = i_picorv32_mem_top___i_picorv32___mem_la_wstrb;
    assign i_picorv32_mem_top___sv2v_tmp_i_picorv32_pcpi_valid = i_picorv32_mem_top___i_picorv32___pcpi_valid;
    assign i_picorv32_mem_top___sv2v_tmp_i_picorv32_pcpi_insn = i_picorv32_mem_top___i_picorv32___pcpi_insn;
    assign i_picorv32_mem_top___pcpi_rs1 = i_picorv32_mem_top___i_picorv32___pcpi_rs1;
    assign i_picorv32_mem_top___pcpi_rs2 = i_picorv32_mem_top___i_picorv32___pcpi_rs2;
    assign i_picorv32_mem_top___i_picorv32___pcpi_wr = i_picorv32_mem_top___pcpi_wr;
    assign i_picorv32_mem_top___i_picorv32___pcpi_rd = i_picorv32_mem_top___pcpi_rd;
    assign i_picorv32_mem_top___i_picorv32___pcpi_wait = i_picorv32_mem_top___pcpi_wait;
    assign i_picorv32_mem_top___i_picorv32___pcpi_ready = i_picorv32_mem_top___pcpi_ready;
    assign i_picorv32_mem_top___i_picorv32___irq = i_picorv32_mem_top___irq;
    assign i_picorv32_mem_top___sv2v_tmp_i_picorv32_eoi = i_picorv32_mem_top___i_picorv32___eoi;
    assign i_picorv32_mem_top___sv2v_tmp_i_picorv32_trace_valid = i_picorv32_mem_top___i_picorv32___trace_valid;
    assign i_picorv32_mem_top___sv2v_tmp_i_picorv32_trace_data = i_picorv32_mem_top___i_picorv32___trace_data;

    reg[63:0] i_picorv32_mem_top___i_picorv32___count_cycle ; reg[63:0] i_picorv32_mem_top___i_picorv32___count_instr ; reg[31:0] i_picorv32_mem_top___i_picorv32___reg_pc ; reg[31:0] i_picorv32_mem_top___i_picorv32___reg_next_pc ; reg[31:0] i_picorv32_mem_top___i_picorv32___reg_op1 ; reg[31:0] i_picorv32_mem_top___i_picorv32___reg_op2 ; reg[31:0] i_picorv32_mem_top___i_picorv32___reg_out ; reg[4:0] i_picorv32_mem_top___i_picorv32___reg_sh ; reg[31:0] i_picorv32_mem_top___i_picorv32___next_insn_opcode ; reg[31:0] i_picorv32_mem_top___i_picorv32___dbg_insn_opcode ; reg[31:0] i_picorv32_mem_top___i_picorv32___dbg_insn_addr ; 
    wire i_picorv32_mem_top___i_picorv32___dbg_mem_valid = i_picorv32_mem_top___i_picorv32___mem_valid ; 
    wire i_picorv32_mem_top___i_picorv32___dbg_mem_instr = i_picorv32_mem_top___i_picorv32___mem_instr ; 
    wire i_picorv32_mem_top___i_picorv32___dbg_mem_ready = i_picorv32_mem_top___i_picorv32___mem_ready ; 
    wire[31:0] i_picorv32_mem_top___i_picorv32___dbg_mem_addr = i_picorv32_mem_top___i_picorv32___mem_addr ; 
    wire[31:0] i_picorv32_mem_top___i_picorv32___dbg_mem_wdata = i_picorv32_mem_top___i_picorv32___mem_wdata ; 
    wire[3:0] i_picorv32_mem_top___i_picorv32___dbg_mem_wstrb = i_picorv32_mem_top___i_picorv32___mem_wstrb ; 
    wire[31:0] i_picorv32_mem_top___i_picorv32___dbg_mem_rdata = i_picorv32_mem_top___i_picorv32___mem_rdata ; 
  assign  i_picorv32_mem_top___i_picorv32___pcpi_rs1 = i_picorv32_mem_top___i_picorv32___reg_op1 ; 
  assign  i_picorv32_mem_top___i_picorv32___pcpi_rs2 = i_picorv32_mem_top___i_picorv32___reg_op2 ; 
    wire[31:0] i_picorv32_mem_top___i_picorv32___next_pc ; 
    reg i_picorv32_mem_top___i_picorv32___irq_delay ; 
    reg i_picorv32_mem_top___i_picorv32___irq_active ; reg[31:0] i_picorv32_mem_top___i_picorv32___irq_mask ; reg[31:0] i_picorv32_mem_top___i_picorv32___irq_pending ; reg[31:0] i_picorv32_mem_top___i_picorv32___timer ; reg[31:0] i_picorv32_mem_top___i_picorv32___cpuregs [0: i_picorv32_mem_top___i_picorv32___regfile_size -1]; 
    integer i_picorv32_mem_top___i_picorv32___i ; 
    wire i_picorv32_mem_top___i_picorv32___pcpi_mul_wr ; 
    wire[31:0] i_picorv32_mem_top___i_picorv32___pcpi_mul_rd ; 
    wire i_picorv32_mem_top___i_picorv32___pcpi_mul_wait ; 
    wire i_picorv32_mem_top___i_picorv32___pcpi_mul_ready ; 
    wire i_picorv32_mem_top___i_picorv32___pcpi_div_wr ; 
    wire[31:0] i_picorv32_mem_top___i_picorv32___pcpi_div_rd ; 
    wire i_picorv32_mem_top___i_picorv32___pcpi_div_wait ; 
    wire i_picorv32_mem_top___i_picorv32___pcpi_div_ready ; 
    reg i_picorv32_mem_top___i_picorv32___pcpi_int_wr ; reg[31:0] i_picorv32_mem_top___i_picorv32___pcpi_int_rd ; 
    reg i_picorv32_mem_top___i_picorv32___pcpi_int_wait ; 
    reg i_picorv32_mem_top___i_picorv32___pcpi_int_ready ; 
  assign  i_picorv32_mem_top___i_picorv32___pcpi_mul_wr =0; 
  assign  i_picorv32_mem_top___i_picorv32___pcpi_mul_rd =32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; 
  assign  i_picorv32_mem_top___i_picorv32___pcpi_mul_wait =0; 
  assign  i_picorv32_mem_top___i_picorv32___pcpi_mul_ready =0; 
  assign  i_picorv32_mem_top___i_picorv32___pcpi_div_wr =0; 
  assign  i_picorv32_mem_top___i_picorv32___pcpi_div_rd =32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; 
  assign  i_picorv32_mem_top___i_picorv32___pcpi_div_wait =0; 
  assign  i_picorv32_mem_top___i_picorv32___pcpi_div_ready =0; 
  always @(*)
         begin  
             i_picorv32_mem_top___i_picorv32___pcpi_int_wr  =0; 
             i_picorv32_mem_top___i_picorv32___pcpi_int_rd  =32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; 
             i_picorv32_mem_top___i_picorv32___pcpi_int_wait  = |{ i_picorv32_mem_top___i_picorv32___ENABLE_PCPI && i_picorv32_mem_top___i_picorv32___pcpi_wait ,( i_picorv32_mem_top___i_picorv32___ENABLE_MUL || i_picorv32_mem_top___i_picorv32___ENABLE_FAST_MUL )&& i_picorv32_mem_top___i_picorv32___pcpi_mul_wait , i_picorv32_mem_top___i_picorv32___ENABLE_DIV && i_picorv32_mem_top___i_picorv32___pcpi_div_wait }; 
             i_picorv32_mem_top___i_picorv32___pcpi_int_ready  = |{ i_picorv32_mem_top___i_picorv32___ENABLE_PCPI && i_picorv32_mem_top___i_picorv32___pcpi_ready ,( i_picorv32_mem_top___i_picorv32___ENABLE_MUL || i_picorv32_mem_top___i_picorv32___ENABLE_FAST_MUL )&& i_picorv32_mem_top___i_picorv32___pcpi_mul_ready , i_picorv32_mem_top___i_picorv32___ENABLE_DIV && i_picorv32_mem_top___i_picorv32___pcpi_div_ready };(* i_picorv32_mem_top___i_picorv32___parallel_case *)
             case (1'b1) 
              i_picorv32_mem_top___i_picorv32___ENABLE_PCPI  && i_picorv32_mem_top___i_picorv32___pcpi_ready :
                  begin  
                      i_picorv32_mem_top___i_picorv32___pcpi_int_wr  =( i_picorv32_mem_top___i_picorv32___ENABLE_PCPI  ?  i_picorv32_mem_top___i_picorv32___pcpi_wr :0); 
                      i_picorv32_mem_top___i_picorv32___pcpi_int_rd  =( i_picorv32_mem_top___i_picorv32___ENABLE_PCPI  ?  i_picorv32_mem_top___i_picorv32___pcpi_rd :0);
                  end 
              (  i_picorv32_mem_top___i_picorv32___ENABLE_MUL || i_picorv32_mem_top___i_picorv32___ENABLE_FAST_MUL )&& i_picorv32_mem_top___i_picorv32___pcpi_mul_ready :
                  begin  
                      i_picorv32_mem_top___i_picorv32___pcpi_int_wr  = i_picorv32_mem_top___i_picorv32___pcpi_mul_wr ; 
                      i_picorv32_mem_top___i_picorv32___pcpi_int_rd  = i_picorv32_mem_top___i_picorv32___pcpi_mul_rd ;
                  end  
              i_picorv32_mem_top___i_picorv32___ENABLE_DIV  && i_picorv32_mem_top___i_picorv32___pcpi_div_ready :
                  begin  
                      i_picorv32_mem_top___i_picorv32___pcpi_int_wr  = i_picorv32_mem_top___i_picorv32___pcpi_div_wr ; 
                      i_picorv32_mem_top___i_picorv32___pcpi_int_rd  = i_picorv32_mem_top___i_picorv32___pcpi_div_rd ;
                  end 
             endcase
         end
  reg[1:0] i_picorv32_mem_top___i_picorv32___mem_state ; reg[1:0] i_picorv32_mem_top___i_picorv32___mem_wordsize ; reg[31:0] i_picorv32_mem_top___i_picorv32___mem_rdata_word ; reg[31:0] i_picorv32_mem_top___i_picorv32___mem_rdata_q ; 
    reg i_picorv32_mem_top___i_picorv32___mem_do_prefetch ; 
    reg i_picorv32_mem_top___i_picorv32___mem_do_rinst ; 
    reg i_picorv32_mem_top___i_picorv32___mem_do_rdata ; 
    reg i_picorv32_mem_top___i_picorv32___mem_do_wdata ; 
    wire i_picorv32_mem_top___i_picorv32___mem_xfer ; 
    reg i_picorv32_mem_top___i_picorv32___mem_la_secondword ; 
    reg i_picorv32_mem_top___i_picorv32___mem_la_firstword_reg ; 
    reg i_picorv32_mem_top___i_picorv32___last_mem_valid ; 
    wire i_picorv32_mem_top___i_picorv32___mem_la_firstword =(( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA &&( i_picorv32_mem_top___i_picorv32___mem_do_prefetch || i_picorv32_mem_top___i_picorv32___mem_do_rinst ))&& i_picorv32_mem_top___i_picorv32___next_pc [1])&& ! i_picorv32_mem_top___i_picorv32___mem_la_secondword ; 
    wire i_picorv32_mem_top___i_picorv32___mem_la_firstword_xfer =( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA && i_picorv32_mem_top___i_picorv32___mem_xfer )&&( ! i_picorv32_mem_top___i_picorv32___last_mem_valid  ?  i_picorv32_mem_top___i_picorv32___mem_la_firstword : i_picorv32_mem_top___i_picorv32___mem_la_firstword_reg ); 
    reg i_picorv32_mem_top___i_picorv32___prefetched_high_word ; 
    reg i_picorv32_mem_top___i_picorv32___clear_prefetched_high_word ; reg[15:0] i_picorv32_mem_top___i_picorv32___mem_16bit_buffer ; 
    wire[31:0] i_picorv32_mem_top___i_picorv32___mem_rdata_latched_noshuffle ; 
    wire[31:0] i_picorv32_mem_top___i_picorv32___mem_rdata_latched ; 
    wire i_picorv32_mem_top___i_picorv32___mem_la_use_prefetched_high_word =(( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA && i_picorv32_mem_top___i_picorv32___mem_la_firstword )&& i_picorv32_mem_top___i_picorv32___prefetched_high_word )&& ! i_picorv32_mem_top___i_picorv32___clear_prefetched_high_word ; 
  assign  i_picorv32_mem_top___i_picorv32___mem_xfer =( i_picorv32_mem_top___i_picorv32___mem_valid && i_picorv32_mem_top___i_picorv32___mem_ready )||( i_picorv32_mem_top___i_picorv32___mem_la_use_prefetched_high_word && i_picorv32_mem_top___i_picorv32___mem_do_rinst ); 
    wire i_picorv32_mem_top___i_picorv32___mem_busy = |{ i_picorv32_mem_top___i_picorv32___mem_do_prefetch , i_picorv32_mem_top___i_picorv32___mem_do_rinst , i_picorv32_mem_top___i_picorv32___mem_do_rdata , i_picorv32_mem_top___i_picorv32___mem_do_wdata }; 
    wire i_picorv32_mem_top___i_picorv32___mem_done =( i_picorv32_mem_top___i_picorv32___resetn &&((( i_picorv32_mem_top___i_picorv32___mem_xfer && | i_picorv32_mem_top___i_picorv32___mem_state )&&(( i_picorv32_mem_top___i_picorv32___mem_do_rinst || i_picorv32_mem_top___i_picorv32___mem_do_rdata )|| i_picorv32_mem_top___i_picorv32___mem_do_wdata ))||( & i_picorv32_mem_top___i_picorv32___mem_state && i_picorv32_mem_top___i_picorv32___mem_do_rinst )))&&( ! i_picorv32_mem_top___i_picorv32___mem_la_firstword ||( ~& i_picorv32_mem_top___i_picorv32___mem_rdata_latched [1:0]&& i_picorv32_mem_top___i_picorv32___mem_xfer )); 
  assign  i_picorv32_mem_top___i_picorv32___mem_la_write =( i_picorv32_mem_top___i_picorv32___resetn && ! i_picorv32_mem_top___i_picorv32___mem_state )&& i_picorv32_mem_top___i_picorv32___mem_do_wdata ; 
  assign  i_picorv32_mem_top___i_picorv32___mem_la_read = i_picorv32_mem_top___i_picorv32___resetn &&((( ! i_picorv32_mem_top___i_picorv32___mem_la_use_prefetched_high_word && ! i_picorv32_mem_top___i_picorv32___mem_state )&&(( i_picorv32_mem_top___i_picorv32___mem_do_rinst || i_picorv32_mem_top___i_picorv32___mem_do_prefetch )|| i_picorv32_mem_top___i_picorv32___mem_do_rdata ))||(((( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA && i_picorv32_mem_top___i_picorv32___mem_xfer )&&( ! i_picorv32_mem_top___i_picorv32___last_mem_valid  ?  i_picorv32_mem_top___i_picorv32___mem_la_firstword : i_picorv32_mem_top___i_picorv32___mem_la_firstword_reg ))&& ! i_picorv32_mem_top___i_picorv32___mem_la_secondword )&& & i_picorv32_mem_top___i_picorv32___mem_rdata_latched [1:0])); 
  assign  i_picorv32_mem_top___i_picorv32___mem_la_addr =( i_picorv32_mem_top___i_picorv32___mem_do_prefetch || i_picorv32_mem_top___i_picorv32___mem_do_rinst  ? { i_picorv32_mem_top___i_picorv32___next_pc [31:2]+ i_picorv32_mem_top___i_picorv32___mem_la_firstword_xfer ,2'b00}:{ i_picorv32_mem_top___i_picorv32___reg_op1 [31:2],2'b00}); 
  assign  i_picorv32_mem_top___i_picorv32___mem_rdata_latched_noshuffle =( i_picorv32_mem_top___i_picorv32___mem_xfer || i_picorv32_mem_top___i_picorv32___LATCHED_MEM_RDATA  ?  i_picorv32_mem_top___i_picorv32___mem_rdata : i_picorv32_mem_top___i_picorv32___mem_rdata_q ); 
  assign  i_picorv32_mem_top___i_picorv32___mem_rdata_latched =( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA && i_picorv32_mem_top___i_picorv32___mem_la_use_prefetched_high_word  ? {16'bxxxxxxxxxxxxxxxx, i_picorv32_mem_top___i_picorv32___mem_16bit_buffer }:( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA && i_picorv32_mem_top___i_picorv32___mem_la_secondword  ? { i_picorv32_mem_top___i_picorv32___mem_rdata_latched_noshuffle [15:0], i_picorv32_mem_top___i_picorv32___mem_16bit_buffer }:( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA && i_picorv32_mem_top___i_picorv32___mem_la_firstword  ? {16'bxxxxxxxxxxxxxxxx, i_picorv32_mem_top___i_picorv32___mem_rdata_latched_noshuffle [31:16]}: i_picorv32_mem_top___i_picorv32___mem_rdata_latched_noshuffle ))); 
  always @( posedge  i_picorv32_mem_top___i_picorv32___clk )
         if ( ! i_picorv32_mem_top___i_picorv32___resetn )
             begin  
                 i_picorv32_mem_top___i_picorv32___mem_la_firstword_reg  <=0; 
                 i_picorv32_mem_top___i_picorv32___last_mem_valid  <=0;
             end 
          else 
             begin 
                 if ( ! i_picorv32_mem_top___i_picorv32___last_mem_valid ) 
                     i_picorv32_mem_top___i_picorv32___mem_la_firstword_reg  <= i_picorv32_mem_top___i_picorv32___mem_la_firstword ; 
                 i_picorv32_mem_top___i_picorv32___last_mem_valid  <= i_picorv32_mem_top___i_picorv32___mem_valid && ! i_picorv32_mem_top___i_picorv32___mem_ready ;
             end
  always @(*)(* i_picorv32_mem_top___i_picorv32___full_case *)
         case ( i_picorv32_mem_top___i_picorv32___mem_wordsize )
          0 :
              begin  
                  i_picorv32_mem_top___i_picorv32___mem_la_wdata  = i_picorv32_mem_top___i_picorv32___reg_op2 ; 
                  i_picorv32_mem_top___i_picorv32___mem_la_wstrb  =4'b1111; 
                  i_picorv32_mem_top___i_picorv32___mem_rdata_word  = i_picorv32_mem_top___i_picorv32___mem_rdata ;
              end 
          1 :
              begin  
                  i_picorv32_mem_top___i_picorv32___mem_la_wdata  ={2{ i_picorv32_mem_top___i_picorv32___reg_op2 [15:0]}}; 
                  i_picorv32_mem_top___i_picorv32___mem_la_wstrb  =( i_picorv32_mem_top___i_picorv32___reg_op1 [1] ? 4'b1100:4'b0011);
                  case ( i_picorv32_mem_top___i_picorv32___reg_op1 [1])
                   1 'b0: 
                       i_picorv32_mem_top___i_picorv32___mem_rdata_word  ={16'b0000000000000000, i_picorv32_mem_top___i_picorv32___mem_rdata [15:0]};
                   1 'b1: 
                       i_picorv32_mem_top___i_picorv32___mem_rdata_word  ={16'b0000000000000000, i_picorv32_mem_top___i_picorv32___mem_rdata [31:16]};
                  endcase
              end 
          2 :
              begin  
                  i_picorv32_mem_top___i_picorv32___mem_la_wdata  ={4{ i_picorv32_mem_top___i_picorv32___reg_op2 [7:0]}}; 
                  i_picorv32_mem_top___i_picorv32___mem_la_wstrb  =4'b0001<< i_picorv32_mem_top___i_picorv32___reg_op1 [1:0];
                  case ( i_picorv32_mem_top___i_picorv32___reg_op1 [1:0])
                   2 'b00: 
                       i_picorv32_mem_top___i_picorv32___mem_rdata_word  ={24'b000000000000000000000000, i_picorv32_mem_top___i_picorv32___mem_rdata [7:0]};
                   2 'b01: 
                       i_picorv32_mem_top___i_picorv32___mem_rdata_word  ={24'b000000000000000000000000, i_picorv32_mem_top___i_picorv32___mem_rdata [15:8]};
                   2 'b10: 
                       i_picorv32_mem_top___i_picorv32___mem_rdata_word  ={24'b000000000000000000000000, i_picorv32_mem_top___i_picorv32___mem_rdata [23:16]};
                   2 'b11: 
                       i_picorv32_mem_top___i_picorv32___mem_rdata_word  ={24'b000000000000000000000000, i_picorv32_mem_top___i_picorv32___mem_rdata [31:24]};
                  endcase
              end endcase
  always @( posedge  i_picorv32_mem_top___i_picorv32___clk )
         begin 
             if ( i_picorv32_mem_top___i_picorv32___mem_xfer )
                 begin  
                     i_picorv32_mem_top___i_picorv32___mem_rdata_q  <=( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA  ?  i_picorv32_mem_top___i_picorv32___mem_rdata_latched : i_picorv32_mem_top___i_picorv32___mem_rdata ); 
                     i_picorv32_mem_top___i_picorv32___next_insn_opcode  <=( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA  ?  i_picorv32_mem_top___i_picorv32___mem_rdata_latched : i_picorv32_mem_top___i_picorv32___mem_rdata );
                 end 
             if (( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA && i_picorv32_mem_top___i_picorv32___mem_done )&&( i_picorv32_mem_top___i_picorv32___mem_do_prefetch || i_picorv32_mem_top___i_picorv32___mem_do_rinst ))
                 case ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [1:0])
                  2 'b00:
                      case ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [15:13])
                       3 'b000:
                           begin  
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b000; 
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:20]<={2'b00, i_picorv32_mem_top___i_picorv32___mem_rdata_latched [10:7], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12:11], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [5], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6],2'b00};
                           end 
                       3 'b010:
                           begin  
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:20]<={5'b00000, i_picorv32_mem_top___i_picorv32___mem_rdata_latched [5], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12:10], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6],2'b00}; 
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b010;
                           end 
                       3 'b110:
                           begin 
                               {  i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25], i_picorv32_mem_top___i_picorv32___mem_rdata_q [11:7]}<={5'b00000, i_picorv32_mem_top___i_picorv32___mem_rdata_latched [5], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12:10], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6],2'b00}; 
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b010;
                           end 
                      endcase
                  2 'b01:
                      case ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [15:13])
                       3 'b000:
                           begin  
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b000; 
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:20]<=$signed({ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]});
                           end 
                       3 'b010:
                           begin  
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b000; 
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:20]<=$signed({ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]});
                           end 
                       3 'b011:
                           if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]==2)
                               begin  
                                   i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b000; 
                                   i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:20]<=$signed({ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [4:3], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [5], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [2], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6],4'b0000});
                               end 
                            else  
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:12]<=$signed({ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]});
                       3 'b100:
                           begin 
                               if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:10]==2'b00)
                                   begin  
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:25]<=7'b0000000; 
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b101;
                                   end 
                               if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:10]==2'b01)
                                   begin  
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:25]<=7'b0100000; 
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b101;
                                   end 
                               if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:10]==2'b10)
                                   begin  
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b111; 
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:20]<=$signed({ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]});
                                   end 
                               if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12:10]==3'b011)
                                   begin 
                                       if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:5]==2'b00) 
                                           i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b000;
                                       if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:5]==2'b01) 
                                           i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b100;
                                       if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:5]==2'b10) 
                                           i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b110;
                                       if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:5]==2'b11) 
                                           i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b111; 
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:25]<=( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:5]==2'b00 ? 7'b0100000:7'b0000000);
                                   end 
                           end 
                       3 'b110:
                           begin  
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b000;
                               {  i_picorv32_mem_top___i_picorv32___mem_rdata_q [31], i_picorv32_mem_top___i_picorv32___mem_rdata_q [7], i_picorv32_mem_top___i_picorv32___mem_rdata_q [30:25], i_picorv32_mem_top___i_picorv32___mem_rdata_q [11:8]}<=$signed({ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:5], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [2], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:10], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [4:3]});
                           end 
                       3 'b111:
                           begin  
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b001;
                               {  i_picorv32_mem_top___i_picorv32___mem_rdata_q [31], i_picorv32_mem_top___i_picorv32___mem_rdata_q [7], i_picorv32_mem_top___i_picorv32___mem_rdata_q [30:25], i_picorv32_mem_top___i_picorv32___mem_rdata_q [11:8]}<=$signed({ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:5], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [2], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:10], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [4:3]});
                           end 
                      endcase
                  2 'b10:
                      case ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [15:13])
                       3 'b000:
                           begin  
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:25]<=7'b0000000; 
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b001;
                           end 
                       3 'b010:
                           begin  
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:20]<={4'b0000, i_picorv32_mem_top___i_picorv32___mem_rdata_latched [3:2], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:4],2'b00}; 
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b010;
                           end 
                       3 'b100:
                           begin 
                               if (( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12]==0)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]==0))
                                   begin  
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b000; 
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:20]<=12'b000000000000;
                                   end 
                               if (( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12]==0)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]!=0))
                                   begin  
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b000; 
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:25]<=7'b0000000;
                                   end 
                               if ((( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12]!=0)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]!=0))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]==0))
                                   begin  
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b000; 
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:20]<=12'b000000000000;
                                   end 
                               if (( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12]!=0)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]!=0))
                                   begin  
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b000; 
                                       i_picorv32_mem_top___i_picorv32___mem_rdata_q  [31:25]<=7'b0000000;
                                   end 
                           end 
                       3 'b110:
                           begin 
                               {  i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25], i_picorv32_mem_top___i_picorv32___mem_rdata_q [11:7]}<={4'b0000, i_picorv32_mem_top___i_picorv32___mem_rdata_latched [8:7], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12:9],2'b00}; 
                               i_picorv32_mem_top___i_picorv32___mem_rdata_q  [14:12]<=3'b010;
                           end 
                      endcase
                 endcase
         end
  always @( posedge  i_picorv32_mem_top___i_picorv32___clk )
         if ( i_picorv32_mem_top___i_picorv32___resetn && ! i_picorv32_mem_top___i_picorv32___trap )
             begin 
                 if (( i_picorv32_mem_top___i_picorv32___mem_do_prefetch || i_picorv32_mem_top___i_picorv32___mem_do_rinst )|| i_picorv32_mem_top___i_picorv32___mem_do_rdata ) i_picorv32_mem_top___i_picorv32___empty_statement ;
                 if ( i_picorv32_mem_top___i_picorv32___mem_do_prefetch || i_picorv32_mem_top___i_picorv32___mem_do_rinst ) i_picorv32_mem_top___i_picorv32___empty_statement ;
                 if ( i_picorv32_mem_top___i_picorv32___mem_do_rdata ) i_picorv32_mem_top___i_picorv32___empty_statement ;
                 if ( i_picorv32_mem_top___i_picorv32___mem_do_wdata ) i_picorv32_mem_top___i_picorv32___empty_statement ;
                 if (( i_picorv32_mem_top___i_picorv32___mem_state ==2)||( i_picorv32_mem_top___i_picorv32___mem_state ==3)) i_picorv32_mem_top___i_picorv32___empty_statement ;
             end
  always @( posedge  i_picorv32_mem_top___i_picorv32___clk )
         begin 
             if ( ! i_picorv32_mem_top___i_picorv32___resetn || i_picorv32_mem_top___i_picorv32___trap )
                 begin 
                     if ( ! i_picorv32_mem_top___i_picorv32___resetn ) 
                         i_picorv32_mem_top___i_picorv32___mem_state  <=0;
                     if ( ! i_picorv32_mem_top___i_picorv32___resetn || i_picorv32_mem_top___i_picorv32___mem_ready ) 
                         i_picorv32_mem_top___i_picorv32___mem_valid  <=0; 
                     i_picorv32_mem_top___i_picorv32___mem_la_secondword  <=0; 
                     i_picorv32_mem_top___i_picorv32___prefetched_high_word  <=0;
                 end 
              else 
                 begin 
                     if ( i_picorv32_mem_top___i_picorv32___mem_la_read || i_picorv32_mem_top___i_picorv32___mem_la_write )
                         begin  
                             i_picorv32_mem_top___i_picorv32___mem_addr  <= i_picorv32_mem_top___i_picorv32___mem_la_addr ; 
                             i_picorv32_mem_top___i_picorv32___mem_wstrb  <= i_picorv32_mem_top___i_picorv32___mem_la_wstrb &{4{ i_picorv32_mem_top___i_picorv32___mem_la_write }};
                         end 
                     if ( i_picorv32_mem_top___i_picorv32___mem_la_write ) 
                         i_picorv32_mem_top___i_picorv32___mem_wdata  <= i_picorv32_mem_top___i_picorv32___mem_la_wdata ;
                     case ( i_picorv32_mem_top___i_picorv32___mem_state )
                      0 :
                          begin 
                              if (( i_picorv32_mem_top___i_picorv32___mem_do_prefetch || i_picorv32_mem_top___i_picorv32___mem_do_rinst )|| i_picorv32_mem_top___i_picorv32___mem_do_rdata )
                                  begin  
                                      i_picorv32_mem_top___i_picorv32___mem_valid  <= ! i_picorv32_mem_top___i_picorv32___mem_la_use_prefetched_high_word ; 
                                      i_picorv32_mem_top___i_picorv32___mem_instr  <= i_picorv32_mem_top___i_picorv32___mem_do_prefetch || i_picorv32_mem_top___i_picorv32___mem_do_rinst ; 
                                      i_picorv32_mem_top___i_picorv32___mem_wstrb  <=0; 
                                      i_picorv32_mem_top___i_picorv32___mem_state  <=1;
                                  end 
                              if ( i_picorv32_mem_top___i_picorv32___mem_do_wdata )
                                  begin  
                                      i_picorv32_mem_top___i_picorv32___mem_valid  <=1; 
                                      i_picorv32_mem_top___i_picorv32___mem_instr  <=0; 
                                      i_picorv32_mem_top___i_picorv32___mem_state  <=2;
                                  end 
                          end 
                      1 :
                          begin  i_picorv32_mem_top___i_picorv32___empty_statement ; i_picorv32_mem_top___i_picorv32___empty_statement ; i_picorv32_mem_top___i_picorv32___empty_statement ; i_picorv32_mem_top___i_picorv32___empty_statement ;
                              if ( i_picorv32_mem_top___i_picorv32___mem_xfer )
                                  begin 
                                      if ( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA && i_picorv32_mem_top___i_picorv32___mem_la_read )
                                          begin  
                                              i_picorv32_mem_top___i_picorv32___mem_valid  <=1; 
                                              i_picorv32_mem_top___i_picorv32___mem_la_secondword  <=1;
                                              if ( ! i_picorv32_mem_top___i_picorv32___mem_la_use_prefetched_high_word ) 
                                                  i_picorv32_mem_top___i_picorv32___mem_16bit_buffer  <= i_picorv32_mem_top___i_picorv32___mem_rdata [31:16];
                                          end 
                                       else 
                                          begin  
                                              i_picorv32_mem_top___i_picorv32___mem_valid  <=0; 
                                              i_picorv32_mem_top___i_picorv32___mem_la_secondword  <=0;
                                              if ( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA && ! i_picorv32_mem_top___i_picorv32___mem_do_rdata )
                                                  begin 
                                                      if ( ~& i_picorv32_mem_top___i_picorv32___mem_rdata [1:0]|| i_picorv32_mem_top___i_picorv32___mem_la_secondword )
                                                          begin  
                                                              i_picorv32_mem_top___i_picorv32___mem_16bit_buffer  <= i_picorv32_mem_top___i_picorv32___mem_rdata [31:16]; 
                                                              i_picorv32_mem_top___i_picorv32___prefetched_high_word  <=1;
                                                          end 
                                                       else  
                                                          i_picorv32_mem_top___i_picorv32___prefetched_high_word  <=0;
                                                  end  
                                              i_picorv32_mem_top___i_picorv32___mem_state  <=( i_picorv32_mem_top___i_picorv32___mem_do_rinst || i_picorv32_mem_top___i_picorv32___mem_do_rdata  ? 0:3);
                                          end 
                                  end 
                          end 
                      2 :
                          begin  i_picorv32_mem_top___i_picorv32___empty_statement ; i_picorv32_mem_top___i_picorv32___empty_statement ;
                              if ( i_picorv32_mem_top___i_picorv32___mem_xfer )
                                  begin  
                                      i_picorv32_mem_top___i_picorv32___mem_valid  <=0; 
                                      i_picorv32_mem_top___i_picorv32___mem_state  <=0;
                                  end 
                          end 
                      3 :
                          begin  i_picorv32_mem_top___i_picorv32___empty_statement ; i_picorv32_mem_top___i_picorv32___empty_statement ;
                              if ( i_picorv32_mem_top___i_picorv32___mem_do_rinst ) 
                                  i_picorv32_mem_top___i_picorv32___mem_state  <=0;
                          end 
                     endcase
                 end 
             if ( i_picorv32_mem_top___i_picorv32___clear_prefetched_high_word ) 
                 i_picorv32_mem_top___i_picorv32___prefetched_high_word  <=0;
         end
    reg i_picorv32_mem_top___i_picorv32___instr_lui ; 
    reg i_picorv32_mem_top___i_picorv32___instr_auipc ; 
    reg i_picorv32_mem_top___i_picorv32___instr_jal ; 
    reg i_picorv32_mem_top___i_picorv32___instr_jalr ; 
    reg i_picorv32_mem_top___i_picorv32___instr_beq ; 
    reg i_picorv32_mem_top___i_picorv32___instr_bne ; 
    reg i_picorv32_mem_top___i_picorv32___instr_blt ; 
    reg i_picorv32_mem_top___i_picorv32___instr_bge ; 
    reg i_picorv32_mem_top___i_picorv32___instr_bltu ; 
    reg i_picorv32_mem_top___i_picorv32___instr_bgeu ; 
    reg i_picorv32_mem_top___i_picorv32___instr_lb ; 
    reg i_picorv32_mem_top___i_picorv32___instr_lh ; 
    reg i_picorv32_mem_top___i_picorv32___instr_lw ; 
    reg i_picorv32_mem_top___i_picorv32___instr_lbu ; 
    reg i_picorv32_mem_top___i_picorv32___instr_lhu ; 
    reg i_picorv32_mem_top___i_picorv32___instr_sb ; 
    reg i_picorv32_mem_top___i_picorv32___instr_sh ; 
    reg i_picorv32_mem_top___i_picorv32___instr_sw ; 
    reg i_picorv32_mem_top___i_picorv32___instr_addi ; 
    reg i_picorv32_mem_top___i_picorv32___instr_slti ; 
    reg i_picorv32_mem_top___i_picorv32___instr_sltiu ; 
    reg i_picorv32_mem_top___i_picorv32___instr_xori ; 
    reg i_picorv32_mem_top___i_picorv32___instr_ori ; 
    reg i_picorv32_mem_top___i_picorv32___instr_andi ; 
    reg i_picorv32_mem_top___i_picorv32___instr_slli ; 
    reg i_picorv32_mem_top___i_picorv32___instr_srli ; 
    reg i_picorv32_mem_top___i_picorv32___instr_srai ; 
    reg i_picorv32_mem_top___i_picorv32___instr_add ; 
    reg i_picorv32_mem_top___i_picorv32___instr_sub ; 
    reg i_picorv32_mem_top___i_picorv32___instr_sll ; 
    reg i_picorv32_mem_top___i_picorv32___instr_slt ; 
    reg i_picorv32_mem_top___i_picorv32___instr_sltu ; 
    reg i_picorv32_mem_top___i_picorv32___instr_xor ; 
    reg i_picorv32_mem_top___i_picorv32___instr_srl ; 
    reg i_picorv32_mem_top___i_picorv32___instr_sra ; 
    reg i_picorv32_mem_top___i_picorv32___instr_or ; 
    reg i_picorv32_mem_top___i_picorv32___instr_and ; 
    reg i_picorv32_mem_top___i_picorv32___instr_rdcycle ; 
    reg i_picorv32_mem_top___i_picorv32___instr_rdcycleh ; 
    reg i_picorv32_mem_top___i_picorv32___instr_rdinstr ; 
    reg i_picorv32_mem_top___i_picorv32___instr_rdinstrh ; 
    reg i_picorv32_mem_top___i_picorv32___instr_ecall_ebreak ; 
    reg i_picorv32_mem_top___i_picorv32___instr_fence ; 
    reg i_picorv32_mem_top___i_picorv32___instr_getq ; 
    reg i_picorv32_mem_top___i_picorv32___instr_setq ; 
    reg i_picorv32_mem_top___i_picorv32___instr_retirq ; 
    reg i_picorv32_mem_top___i_picorv32___instr_maskirq ; 
    reg i_picorv32_mem_top___i_picorv32___instr_waitirq ; 
    reg i_picorv32_mem_top___i_picorv32___instr_timer ; 
    wire i_picorv32_mem_top___i_picorv32___instr_trap ; reg[ i_picorv32_mem_top___i_picorv32___regindex_bits -1:0] i_picorv32_mem_top___i_picorv32___decoded_rd ; reg[ i_picorv32_mem_top___i_picorv32___regindex_bits -1:0] i_picorv32_mem_top___i_picorv32___decoded_rs1 ; reg[ i_picorv32_mem_top___i_picorv32___regindex_bits -1:0] i_picorv32_mem_top___i_picorv32___decoded_rs2 ; reg[31:0] i_picorv32_mem_top___i_picorv32___decoded_imm ; reg[31:0] i_picorv32_mem_top___i_picorv32___decoded_imm_j ; 
    reg i_picorv32_mem_top___i_picorv32___decoder_trigger ; 
    reg i_picorv32_mem_top___i_picorv32___decoder_trigger_q ; 
    reg i_picorv32_mem_top___i_picorv32___decoder_pseudo_trigger ; 
    reg i_picorv32_mem_top___i_picorv32___decoder_pseudo_trigger_q ; 
    reg i_picorv32_mem_top___i_picorv32___compressed_instr ; 
    reg i_picorv32_mem_top___i_picorv32___is_lui_auipc_jal ; 
    reg i_picorv32_mem_top___i_picorv32___is_lb_lh_lw_lbu_lhu ; 
    reg i_picorv32_mem_top___i_picorv32___is_slli_srli_srai ; 
    reg i_picorv32_mem_top___i_picorv32___is_jalr_addi_slti_sltiu_xori_ori_andi ; 
    reg i_picorv32_mem_top___i_picorv32___is_sb_sh_sw ; 
    reg i_picorv32_mem_top___i_picorv32___is_sll_srl_sra ; 
    reg i_picorv32_mem_top___i_picorv32___is_lui_auipc_jal_jalr_addi_add_sub ; 
    reg i_picorv32_mem_top___i_picorv32___is_slti_blt_slt ; 
    reg i_picorv32_mem_top___i_picorv32___is_sltiu_bltu_sltu ; 
    reg i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu ; 
    reg i_picorv32_mem_top___i_picorv32___is_lbu_lhu_lw ; 
    reg i_picorv32_mem_top___i_picorv32___is_alu_reg_imm ; 
    reg i_picorv32_mem_top___i_picorv32___is_alu_reg_reg ; 
    reg i_picorv32_mem_top___i_picorv32___is_compare ; 
  assign  i_picorv32_mem_top___i_picorv32___instr_trap =( i_picorv32_mem_top___i_picorv32___CATCH_ILLINSN || i_picorv32_mem_top___i_picorv32___WITH_PCPI )&& !{ i_picorv32_mem_top___i_picorv32___instr_lui , i_picorv32_mem_top___i_picorv32___instr_auipc , i_picorv32_mem_top___i_picorv32___instr_jal , i_picorv32_mem_top___i_picorv32___instr_jalr , i_picorv32_mem_top___i_picorv32___instr_beq , i_picorv32_mem_top___i_picorv32___instr_bne , i_picorv32_mem_top___i_picorv32___instr_blt , i_picorv32_mem_top___i_picorv32___instr_bge , i_picorv32_mem_top___i_picorv32___instr_bltu , i_picorv32_mem_top___i_picorv32___instr_bgeu , i_picorv32_mem_top___i_picorv32___instr_lb , i_picorv32_mem_top___i_picorv32___instr_lh , i_picorv32_mem_top___i_picorv32___instr_lw , i_picorv32_mem_top___i_picorv32___instr_lbu , i_picorv32_mem_top___i_picorv32___instr_lhu , i_picorv32_mem_top___i_picorv32___instr_sb , i_picorv32_mem_top___i_picorv32___instr_sh , i_picorv32_mem_top___i_picorv32___instr_sw , i_picorv32_mem_top___i_picorv32___instr_addi , i_picorv32_mem_top___i_picorv32___instr_slti , i_picorv32_mem_top___i_picorv32___instr_sltiu , i_picorv32_mem_top___i_picorv32___instr_xori , i_picorv32_mem_top___i_picorv32___instr_ori , i_picorv32_mem_top___i_picorv32___instr_andi , i_picorv32_mem_top___i_picorv32___instr_slli , i_picorv32_mem_top___i_picorv32___instr_srli , i_picorv32_mem_top___i_picorv32___instr_srai , i_picorv32_mem_top___i_picorv32___instr_add , i_picorv32_mem_top___i_picorv32___instr_sub , i_picorv32_mem_top___i_picorv32___instr_sll , i_picorv32_mem_top___i_picorv32___instr_slt , i_picorv32_mem_top___i_picorv32___instr_sltu , i_picorv32_mem_top___i_picorv32___instr_xor , i_picorv32_mem_top___i_picorv32___instr_srl , i_picorv32_mem_top___i_picorv32___instr_sra , i_picorv32_mem_top___i_picorv32___instr_or , i_picorv32_mem_top___i_picorv32___instr_and , i_picorv32_mem_top___i_picorv32___instr_rdcycle , i_picorv32_mem_top___i_picorv32___instr_rdcycleh , i_picorv32_mem_top___i_picorv32___instr_rdinstr , i_picorv32_mem_top___i_picorv32___instr_rdinstrh , i_picorv32_mem_top___i_picorv32___instr_fence , i_picorv32_mem_top___i_picorv32___instr_getq , i_picorv32_mem_top___i_picorv32___instr_setq , i_picorv32_mem_top___i_picorv32___instr_retirq , i_picorv32_mem_top___i_picorv32___instr_maskirq , i_picorv32_mem_top___i_picorv32___instr_waitirq , i_picorv32_mem_top___i_picorv32___instr_timer }; 
    wire i_picorv32_mem_top___i_picorv32___is_rdcycle_rdcycleh_rdinstr_rdinstrh ; 
  assign  i_picorv32_mem_top___i_picorv32___is_rdcycle_rdcycleh_rdinstr_rdinstrh = |{ i_picorv32_mem_top___i_picorv32___instr_rdcycle , i_picorv32_mem_top___i_picorv32___instr_rdcycleh , i_picorv32_mem_top___i_picorv32___instr_rdinstr , i_picorv32_mem_top___i_picorv32___instr_rdinstrh }; reg[63:0] i_picorv32_mem_top___i_picorv32___new_ascii_instr ; reg[63:0] i_picorv32_mem_top___i_picorv32___dbg_ascii_instr ; reg[31:0] i_picorv32_mem_top___i_picorv32___dbg_insn_imm ; reg[4:0] i_picorv32_mem_top___i_picorv32___dbg_insn_rs1 ; reg[4:0] i_picorv32_mem_top___i_picorv32___dbg_insn_rs2 ; reg[4:0] i_picorv32_mem_top___i_picorv32___dbg_insn_rd ; reg[31:0] i_picorv32_mem_top___i_picorv32___dbg_rs1val ; reg[31:0] i_picorv32_mem_top___i_picorv32___dbg_rs2val ; 
    reg i_picorv32_mem_top___i_picorv32___dbg_rs1val_valid ; 
    reg i_picorv32_mem_top___i_picorv32___dbg_rs2val_valid ; 
  always @(*)
         begin  
             i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="UNDEFINED";
             if ( i_picorv32_mem_top___i_picorv32___instr_lui ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="lui";
             if ( i_picorv32_mem_top___i_picorv32___instr_auipc ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="auipc";
             if ( i_picorv32_mem_top___i_picorv32___instr_jal ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="jal";
             if ( i_picorv32_mem_top___i_picorv32___instr_jalr ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="jalr";
             if ( i_picorv32_mem_top___i_picorv32___instr_beq ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="beq";
             if ( i_picorv32_mem_top___i_picorv32___instr_bne ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="bne";
             if ( i_picorv32_mem_top___i_picorv32___instr_blt ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="blt";
             if ( i_picorv32_mem_top___i_picorv32___instr_bge ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="bge";
             if ( i_picorv32_mem_top___i_picorv32___instr_bltu ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="bltu";
             if ( i_picorv32_mem_top___i_picorv32___instr_bgeu ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="bgeu";
             if ( i_picorv32_mem_top___i_picorv32___instr_lb ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="lb";
             if ( i_picorv32_mem_top___i_picorv32___instr_lh ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="lh";
             if ( i_picorv32_mem_top___i_picorv32___instr_lw ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="lw";
             if ( i_picorv32_mem_top___i_picorv32___instr_lbu ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="lbu";
             if ( i_picorv32_mem_top___i_picorv32___instr_lhu ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="lhu";
             if ( i_picorv32_mem_top___i_picorv32___instr_sb ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="sb";
             if ( i_picorv32_mem_top___i_picorv32___instr_sh ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="sh";
             if ( i_picorv32_mem_top___i_picorv32___instr_sw ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="sw";
             if ( i_picorv32_mem_top___i_picorv32___instr_addi ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="addi";
             if ( i_picorv32_mem_top___i_picorv32___instr_slti ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="slti";
             if ( i_picorv32_mem_top___i_picorv32___instr_sltiu ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="sltiu";
             if ( i_picorv32_mem_top___i_picorv32___instr_xori ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="xori";
             if ( i_picorv32_mem_top___i_picorv32___instr_ori ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="ori";
             if ( i_picorv32_mem_top___i_picorv32___instr_andi ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="andi";
             if ( i_picorv32_mem_top___i_picorv32___instr_slli ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="slli";
             if ( i_picorv32_mem_top___i_picorv32___instr_srli ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="srli";
             if ( i_picorv32_mem_top___i_picorv32___instr_srai ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="srai";
             if ( i_picorv32_mem_top___i_picorv32___instr_add ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="add";
             if ( i_picorv32_mem_top___i_picorv32___instr_sub ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="sub";
             if ( i_picorv32_mem_top___i_picorv32___instr_sll ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="sll";
             if ( i_picorv32_mem_top___i_picorv32___instr_slt ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="slt";
             if ( i_picorv32_mem_top___i_picorv32___instr_sltu ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="sltu";
             if ( i_picorv32_mem_top___i_picorv32___instr_xor ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="xor";
             if ( i_picorv32_mem_top___i_picorv32___instr_srl ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="srl";
             if ( i_picorv32_mem_top___i_picorv32___instr_sra ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="sra";
             if ( i_picorv32_mem_top___i_picorv32___instr_or ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="or";
             if ( i_picorv32_mem_top___i_picorv32___instr_and ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="and";
             if ( i_picorv32_mem_top___i_picorv32___instr_rdcycle ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="rdcycle";
             if ( i_picorv32_mem_top___i_picorv32___instr_rdcycleh ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="rdcycleh";
             if ( i_picorv32_mem_top___i_picorv32___instr_rdinstr ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="rdinstr";
             if ( i_picorv32_mem_top___i_picorv32___instr_rdinstrh ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="rdinstrh";
             if ( i_picorv32_mem_top___i_picorv32___instr_fence ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="fence";
             if ( i_picorv32_mem_top___i_picorv32___instr_getq ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="getq";
             if ( i_picorv32_mem_top___i_picorv32___instr_setq ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="setq";
             if ( i_picorv32_mem_top___i_picorv32___instr_retirq ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="retirq";
             if ( i_picorv32_mem_top___i_picorv32___instr_maskirq ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="maskirq";
             if ( i_picorv32_mem_top___i_picorv32___instr_waitirq ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="waitirq";
             if ( i_picorv32_mem_top___i_picorv32___instr_timer ) 
                 i_picorv32_mem_top___i_picorv32___new_ascii_instr  ="timer";
         end
  reg[63:0] i_picorv32_mem_top___i_picorv32___q_ascii_instr ; reg[31:0] i_picorv32_mem_top___i_picorv32___q_insn_imm ; reg[31:0] i_picorv32_mem_top___i_picorv32___q_insn_opcode ; reg[4:0] i_picorv32_mem_top___i_picorv32___q_insn_rs1 ; reg[4:0] i_picorv32_mem_top___i_picorv32___q_insn_rs2 ; reg[4:0] i_picorv32_mem_top___i_picorv32___q_insn_rd ; 
    reg i_picorv32_mem_top___i_picorv32___dbg_next ; 
    wire i_picorv32_mem_top___i_picorv32___launch_next_insn ; 
    reg i_picorv32_mem_top___i_picorv32___dbg_valid_insn ; reg[63:0] i_picorv32_mem_top___i_picorv32___cached_ascii_instr ; reg[31:0] i_picorv32_mem_top___i_picorv32___cached_insn_imm ; reg[31:0] i_picorv32_mem_top___i_picorv32___cached_insn_opcode ; reg[4:0] i_picorv32_mem_top___i_picorv32___cached_insn_rs1 ; reg[4:0] i_picorv32_mem_top___i_picorv32___cached_insn_rs2 ; reg[4:0] i_picorv32_mem_top___i_picorv32___cached_insn_rd ; 
  always @( posedge  i_picorv32_mem_top___i_picorv32___clk )
         begin  
             i_picorv32_mem_top___i_picorv32___q_ascii_instr  <= i_picorv32_mem_top___i_picorv32___dbg_ascii_instr ; 
             i_picorv32_mem_top___i_picorv32___q_insn_imm  <= i_picorv32_mem_top___i_picorv32___dbg_insn_imm ; 
             i_picorv32_mem_top___i_picorv32___q_insn_opcode  <= i_picorv32_mem_top___i_picorv32___dbg_insn_opcode ; 
             i_picorv32_mem_top___i_picorv32___q_insn_rs1  <= i_picorv32_mem_top___i_picorv32___dbg_insn_rs1 ; 
             i_picorv32_mem_top___i_picorv32___q_insn_rs2  <= i_picorv32_mem_top___i_picorv32___dbg_insn_rs2 ; 
             i_picorv32_mem_top___i_picorv32___q_insn_rd  <= i_picorv32_mem_top___i_picorv32___dbg_insn_rd ; 
             i_picorv32_mem_top___i_picorv32___dbg_next  <= i_picorv32_mem_top___i_picorv32___launch_next_insn ;
             if ( ! i_picorv32_mem_top___i_picorv32___resetn || i_picorv32_mem_top___i_picorv32___trap ) 
                 i_picorv32_mem_top___i_picorv32___dbg_valid_insn  <=0;
              else 
                 if ( i_picorv32_mem_top___i_picorv32___launch_next_insn ) 
                     i_picorv32_mem_top___i_picorv32___dbg_valid_insn  <=1;
             if ( i_picorv32_mem_top___i_picorv32___decoder_trigger_q )
                 begin  
                     i_picorv32_mem_top___i_picorv32___cached_ascii_instr  <= i_picorv32_mem_top___i_picorv32___new_ascii_instr ; 
                     i_picorv32_mem_top___i_picorv32___cached_insn_imm  <= i_picorv32_mem_top___i_picorv32___decoded_imm ;
                     if ( & i_picorv32_mem_top___i_picorv32___next_insn_opcode [1:0]) 
                         i_picorv32_mem_top___i_picorv32___cached_insn_opcode  <= i_picorv32_mem_top___i_picorv32___next_insn_opcode ;
                      else  
                         i_picorv32_mem_top___i_picorv32___cached_insn_opcode  <={16'b0000000000000000, i_picorv32_mem_top___i_picorv32___next_insn_opcode [15:0]}; 
                     i_picorv32_mem_top___i_picorv32___cached_insn_rs1  <= i_picorv32_mem_top___i_picorv32___decoded_rs1 ; 
                     i_picorv32_mem_top___i_picorv32___cached_insn_rs2  <= i_picorv32_mem_top___i_picorv32___decoded_rs2 ; 
                     i_picorv32_mem_top___i_picorv32___cached_insn_rd  <= i_picorv32_mem_top___i_picorv32___decoded_rd ;
                 end 
             if ( i_picorv32_mem_top___i_picorv32___launch_next_insn ) 
                 i_picorv32_mem_top___i_picorv32___dbg_insn_addr  <= i_picorv32_mem_top___i_picorv32___next_pc ;
         end
  always @(*)
         begin  
             i_picorv32_mem_top___i_picorv32___dbg_ascii_instr  = i_picorv32_mem_top___i_picorv32___q_ascii_instr ; 
             i_picorv32_mem_top___i_picorv32___dbg_insn_imm  = i_picorv32_mem_top___i_picorv32___q_insn_imm ; 
             i_picorv32_mem_top___i_picorv32___dbg_insn_opcode  = i_picorv32_mem_top___i_picorv32___q_insn_opcode ; 
             i_picorv32_mem_top___i_picorv32___dbg_insn_rs1  = i_picorv32_mem_top___i_picorv32___q_insn_rs1 ; 
             i_picorv32_mem_top___i_picorv32___dbg_insn_rs2  = i_picorv32_mem_top___i_picorv32___q_insn_rs2 ; 
             i_picorv32_mem_top___i_picorv32___dbg_insn_rd  = i_picorv32_mem_top___i_picorv32___q_insn_rd ;
             if ( i_picorv32_mem_top___i_picorv32___dbg_next )
                 begin 
                     if ( i_picorv32_mem_top___i_picorv32___decoder_pseudo_trigger_q )
                         begin  
                             i_picorv32_mem_top___i_picorv32___dbg_ascii_instr  = i_picorv32_mem_top___i_picorv32___cached_ascii_instr ; 
                             i_picorv32_mem_top___i_picorv32___dbg_insn_imm  = i_picorv32_mem_top___i_picorv32___cached_insn_imm ; 
                             i_picorv32_mem_top___i_picorv32___dbg_insn_opcode  = i_picorv32_mem_top___i_picorv32___cached_insn_opcode ; 
                             i_picorv32_mem_top___i_picorv32___dbg_insn_rs1  = i_picorv32_mem_top___i_picorv32___cached_insn_rs1 ; 
                             i_picorv32_mem_top___i_picorv32___dbg_insn_rs2  = i_picorv32_mem_top___i_picorv32___cached_insn_rs2 ; 
                             i_picorv32_mem_top___i_picorv32___dbg_insn_rd  = i_picorv32_mem_top___i_picorv32___cached_insn_rd ;
                         end 
                      else 
                         begin  
                             i_picorv32_mem_top___i_picorv32___dbg_ascii_instr  = i_picorv32_mem_top___i_picorv32___new_ascii_instr ;
                             if ( & i_picorv32_mem_top___i_picorv32___next_insn_opcode [1:0]) 
                                 i_picorv32_mem_top___i_picorv32___dbg_insn_opcode  = i_picorv32_mem_top___i_picorv32___next_insn_opcode ;
                              else  
                                 i_picorv32_mem_top___i_picorv32___dbg_insn_opcode  ={16'b0000000000000000, i_picorv32_mem_top___i_picorv32___next_insn_opcode [15:0]}; 
                             i_picorv32_mem_top___i_picorv32___dbg_insn_imm  = i_picorv32_mem_top___i_picorv32___decoded_imm ; 
                             i_picorv32_mem_top___i_picorv32___dbg_insn_rs1  = i_picorv32_mem_top___i_picorv32___decoded_rs1 ; 
                             i_picorv32_mem_top___i_picorv32___dbg_insn_rs2  = i_picorv32_mem_top___i_picorv32___decoded_rs2 ; 
                             i_picorv32_mem_top___i_picorv32___dbg_insn_rd  = i_picorv32_mem_top___i_picorv32___decoded_rd ;
                         end 
                 end 
         end
  always @( posedge  i_picorv32_mem_top___i_picorv32___clk )
         begin  
             i_picorv32_mem_top___i_picorv32___is_lui_auipc_jal  <= |{ i_picorv32_mem_top___i_picorv32___instr_lui , i_picorv32_mem_top___i_picorv32___instr_auipc , i_picorv32_mem_top___i_picorv32___instr_jal }; 
             i_picorv32_mem_top___i_picorv32___is_lui_auipc_jal_jalr_addi_add_sub  <= |{ i_picorv32_mem_top___i_picorv32___instr_lui , i_picorv32_mem_top___i_picorv32___instr_auipc , i_picorv32_mem_top___i_picorv32___instr_jal , i_picorv32_mem_top___i_picorv32___instr_jalr , i_picorv32_mem_top___i_picorv32___instr_addi , i_picorv32_mem_top___i_picorv32___instr_add , i_picorv32_mem_top___i_picorv32___instr_sub }; 
             i_picorv32_mem_top___i_picorv32___is_slti_blt_slt  <= |{ i_picorv32_mem_top___i_picorv32___instr_slti , i_picorv32_mem_top___i_picorv32___instr_blt , i_picorv32_mem_top___i_picorv32___instr_slt }; 
             i_picorv32_mem_top___i_picorv32___is_sltiu_bltu_sltu  <= |{ i_picorv32_mem_top___i_picorv32___instr_sltiu , i_picorv32_mem_top___i_picorv32___instr_bltu , i_picorv32_mem_top___i_picorv32___instr_sltu }; 
             i_picorv32_mem_top___i_picorv32___is_lbu_lhu_lw  <= |{ i_picorv32_mem_top___i_picorv32___instr_lbu , i_picorv32_mem_top___i_picorv32___instr_lhu , i_picorv32_mem_top___i_picorv32___instr_lw }; 
             i_picorv32_mem_top___i_picorv32___is_compare  <= |{ i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu , i_picorv32_mem_top___i_picorv32___instr_slti , i_picorv32_mem_top___i_picorv32___instr_slt , i_picorv32_mem_top___i_picorv32___instr_sltiu , i_picorv32_mem_top___i_picorv32___instr_sltu };
             if ( i_picorv32_mem_top___i_picorv32___mem_do_rinst && i_picorv32_mem_top___i_picorv32___mem_done )
                 begin  
                     i_picorv32_mem_top___i_picorv32___instr_lui  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b0110111; 
                     i_picorv32_mem_top___i_picorv32___instr_auipc  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b0010111; 
                     i_picorv32_mem_top___i_picorv32___instr_jal  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b1101111; 
                     i_picorv32_mem_top___i_picorv32___instr_jalr  <=( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b1100111)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [14:12]==3'b000); 
                     i_picorv32_mem_top___i_picorv32___instr_retirq  <=(( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b0001011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [31:25]==7'b0000010))&& i_picorv32_mem_top___i_picorv32___ENABLE_IRQ ; 
                     i_picorv32_mem_top___i_picorv32___instr_waitirq  <=(( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b0001011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [31:25]==7'b0000100))&& i_picorv32_mem_top___i_picorv32___ENABLE_IRQ ; 
                     i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b1100011; 
                     i_picorv32_mem_top___i_picorv32___is_lb_lh_lw_lbu_lhu  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b0000011; 
                     i_picorv32_mem_top___i_picorv32___is_sb_sh_sw  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b0100011; 
                     i_picorv32_mem_top___i_picorv32___is_alu_reg_imm  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b0010011; 
                     i_picorv32_mem_top___i_picorv32___is_alu_reg_reg  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b0110011;
                     {  i_picorv32_mem_top___i_picorv32___decoded_imm_j [31:20], i_picorv32_mem_top___i_picorv32___decoded_imm_j [10:1], i_picorv32_mem_top___i_picorv32___decoded_imm_j [11], i_picorv32_mem_top___i_picorv32___decoded_imm_j [19:12], i_picorv32_mem_top___i_picorv32___decoded_imm_j [0]}<=$signed({ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [31:12],1'b0}); 
                     i_picorv32_mem_top___i_picorv32___decoded_rd  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]; 
                     i_picorv32_mem_top___i_picorv32___decoded_rs1  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [19:15]; 
                     i_picorv32_mem_top___i_picorv32___decoded_rs2  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [24:20];
                     if (((( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b0001011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [31:25]==7'b0000000))&& i_picorv32_mem_top___i_picorv32___ENABLE_IRQ )&& i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_QREGS ) 
                         i_picorv32_mem_top___i_picorv32___decoded_rs1  [ i_picorv32_mem_top___i_picorv32___regindex_bits -1]<=1;
                     if ((( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:0]==7'b0001011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [31:25]==7'b0000010))&& i_picorv32_mem_top___i_picorv32___ENABLE_IRQ ) 
                         i_picorv32_mem_top___i_picorv32___decoded_rs1  <=( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_QREGS  ?  i_picorv32_mem_top___i_picorv32___irqregs_offset :3); 
                     i_picorv32_mem_top___i_picorv32___compressed_instr  <=0;
                     if ( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA &&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [1:0]!=2'b11))
                         begin  
                             i_picorv32_mem_top___i_picorv32___compressed_instr  <=1; 
                             i_picorv32_mem_top___i_picorv32___decoded_rd  <=0; 
                             i_picorv32_mem_top___i_picorv32___decoded_rs1  <=0; 
                             i_picorv32_mem_top___i_picorv32___decoded_rs2  <=0;
                             {  i_picorv32_mem_top___i_picorv32___decoded_imm_j [31:11], i_picorv32_mem_top___i_picorv32___decoded_imm_j [4], i_picorv32_mem_top___i_picorv32___decoded_imm_j [9:8], i_picorv32_mem_top___i_picorv32___decoded_imm_j [10], i_picorv32_mem_top___i_picorv32___decoded_imm_j [6], i_picorv32_mem_top___i_picorv32___decoded_imm_j [7], i_picorv32_mem_top___i_picorv32___decoded_imm_j [3:1], i_picorv32_mem_top___i_picorv32___decoded_imm_j [5], i_picorv32_mem_top___i_picorv32___decoded_imm_j [0]}<=$signed({ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12:2],1'b0});
                             case ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [1:0])
                              2 'b00:
                                  case ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [15:13])
                                   3 'b000:
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___is_alu_reg_imm  <= | i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12:5]; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rs1  <=2; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rd  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [4:2];
                                       end 
                                   3 'b010:
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___is_lb_lh_lw_lbu_lhu  <=1; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rs1  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [9:7]; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rd  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [4:2];
                                       end 
                                   3 'b110:
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___is_sb_sh_sw  <=1; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rs1  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [9:7]; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rs2  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [4:2];
                                       end 
                                  endcase
                              2 'b01:
                                  case ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [15:13])
                                   3 'b000:
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___is_alu_reg_imm  <=1; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rd  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rs1  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7];
                                       end 
                                   3 'b001:
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___instr_jal  <=1; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rd  <=1;
                                       end 
                                   3 'b010:
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___is_alu_reg_imm  <=1; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rd  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rs1  <=0;
                                       end 
                                   3 'b011:
                                       if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12]|| i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2])
                                           begin 
                                               if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]==2)
                                                   begin  
                                                       i_picorv32_mem_top___i_picorv32___is_alu_reg_imm  <=1; 
                                                       i_picorv32_mem_top___i_picorv32___decoded_rd  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]; 
                                                       i_picorv32_mem_top___i_picorv32___decoded_rs1  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7];
                                                   end 
                                                else 
                                                   begin  
                                                       i_picorv32_mem_top___i_picorv32___instr_lui  <=1; 
                                                       i_picorv32_mem_top___i_picorv32___decoded_rd  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]; 
                                                       i_picorv32_mem_top___i_picorv32___decoded_rs1  <=0;
                                                   end 
                                           end 
                                   3 'b100:
                                       begin 
                                           if ( ! i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11]&& ! i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12])
                                               begin  
                                                   i_picorv32_mem_top___i_picorv32___is_alu_reg_imm  <=1; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rd  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [9:7]; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rs1  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [9:7]; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rs2  <={ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]};
                                               end 
                                           if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:10]==2'b10)
                                               begin  
                                                   i_picorv32_mem_top___i_picorv32___is_alu_reg_imm  <=1; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rd  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [9:7]; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rs1  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [9:7];
                                               end 
                                           if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12:10]==3'b011)
                                               begin  
                                                   i_picorv32_mem_top___i_picorv32___is_alu_reg_reg  <=1; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rd  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [9:7]; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rs1  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [9:7]; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rs2  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [4:2];
                                               end 
                                       end 
                                   3 'b101: 
                                       i_picorv32_mem_top___i_picorv32___instr_jal  <=1;
                                   3 'b110:
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu  <=1; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rs1  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [9:7]; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rs2  <=0;
                                       end 
                                   3 'b111:
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu  <=1; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rs1  <=8+ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [9:7]; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rs2  <=0;
                                       end 
                                  endcase
                              2 'b10:
                                  case ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [15:13])
                                   3 'b000:
                                       if ( ! i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12])
                                           begin  
                                               i_picorv32_mem_top___i_picorv32___is_alu_reg_imm  <=1; 
                                               i_picorv32_mem_top___i_picorv32___decoded_rd  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]; 
                                               i_picorv32_mem_top___i_picorv32___decoded_rs1  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]; 
                                               i_picorv32_mem_top___i_picorv32___decoded_rs2  <={ i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12], i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]};
                                           end 
                                   3 'b010:
                                       if ( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7])
                                           begin  
                                               i_picorv32_mem_top___i_picorv32___is_lb_lh_lw_lbu_lhu  <=1; 
                                               i_picorv32_mem_top___i_picorv32___decoded_rd  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]; 
                                               i_picorv32_mem_top___i_picorv32___decoded_rs1  <=2;
                                           end 
                                   3 'b100:
                                       begin 
                                           if ((( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12]==0)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]!=0))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]==0))
                                               begin  
                                                   i_picorv32_mem_top___i_picorv32___instr_jalr  <=1; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rd  <=0; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rs1  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7];
                                               end 
                                           if (( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12]==0)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]!=0))
                                               begin  
                                                   i_picorv32_mem_top___i_picorv32___is_alu_reg_reg  <=1; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rd  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rs1  <=0; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rs2  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2];
                                               end 
                                           if ((( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12]!=0)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]!=0))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]==0))
                                               begin  
                                                   i_picorv32_mem_top___i_picorv32___instr_jalr  <=1; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rd  <=1; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rs1  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7];
                                               end 
                                           if (( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [12]!=0)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2]!=0))
                                               begin  
                                                   i_picorv32_mem_top___i_picorv32___is_alu_reg_reg  <=1; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rd  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rs1  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [11:7]; 
                                                   i_picorv32_mem_top___i_picorv32___decoded_rs2  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2];
                                               end 
                                       end 
                                   3 'b110:
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___is_sb_sh_sw  <=1; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rs1  <=2; 
                                           i_picorv32_mem_top___i_picorv32___decoded_rs2  <= i_picorv32_mem_top___i_picorv32___mem_rdata_latched [6:2];
                                       end 
                                  endcase
                             endcase
                         end 
                 end 
             if ( i_picorv32_mem_top___i_picorv32___decoder_trigger && ! i_picorv32_mem_top___i_picorv32___decoder_pseudo_trigger )
                 begin  
                     i_picorv32_mem_top___i_picorv32___pcpi_insn  <=( i_picorv32_mem_top___i_picorv32___WITH_PCPI  ?  i_picorv32_mem_top___i_picorv32___mem_rdata_q :'bx); 
                     i_picorv32_mem_top___i_picorv32___instr_beq  <= i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b000); 
                     i_picorv32_mem_top___i_picorv32___instr_bne  <= i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b001); 
                     i_picorv32_mem_top___i_picorv32___instr_blt  <= i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b100); 
                     i_picorv32_mem_top___i_picorv32___instr_bge  <= i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b101); 
                     i_picorv32_mem_top___i_picorv32___instr_bltu  <= i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b110); 
                     i_picorv32_mem_top___i_picorv32___instr_bgeu  <= i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b111); 
                     i_picorv32_mem_top___i_picorv32___instr_lb  <= i_picorv32_mem_top___i_picorv32___is_lb_lh_lw_lbu_lhu &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b000); 
                     i_picorv32_mem_top___i_picorv32___instr_lh  <= i_picorv32_mem_top___i_picorv32___is_lb_lh_lw_lbu_lhu &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b001); 
                     i_picorv32_mem_top___i_picorv32___instr_lw  <= i_picorv32_mem_top___i_picorv32___is_lb_lh_lw_lbu_lhu &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b010); 
                     i_picorv32_mem_top___i_picorv32___instr_lbu  <= i_picorv32_mem_top___i_picorv32___is_lb_lh_lw_lbu_lhu &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b100); 
                     i_picorv32_mem_top___i_picorv32___instr_lhu  <= i_picorv32_mem_top___i_picorv32___is_lb_lh_lw_lbu_lhu &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b101); 
                     i_picorv32_mem_top___i_picorv32___instr_sb  <= i_picorv32_mem_top___i_picorv32___is_sb_sh_sw &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b000); 
                     i_picorv32_mem_top___i_picorv32___instr_sh  <= i_picorv32_mem_top___i_picorv32___is_sb_sh_sw &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b001); 
                     i_picorv32_mem_top___i_picorv32___instr_sw  <= i_picorv32_mem_top___i_picorv32___is_sb_sh_sw &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b010); 
                     i_picorv32_mem_top___i_picorv32___instr_addi  <= i_picorv32_mem_top___i_picorv32___is_alu_reg_imm &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b000); 
                     i_picorv32_mem_top___i_picorv32___instr_slti  <= i_picorv32_mem_top___i_picorv32___is_alu_reg_imm &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b010); 
                     i_picorv32_mem_top___i_picorv32___instr_sltiu  <= i_picorv32_mem_top___i_picorv32___is_alu_reg_imm &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b011); 
                     i_picorv32_mem_top___i_picorv32___instr_xori  <= i_picorv32_mem_top___i_picorv32___is_alu_reg_imm &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b100); 
                     i_picorv32_mem_top___i_picorv32___instr_ori  <= i_picorv32_mem_top___i_picorv32___is_alu_reg_imm &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b110); 
                     i_picorv32_mem_top___i_picorv32___instr_andi  <= i_picorv32_mem_top___i_picorv32___is_alu_reg_imm &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b111); 
                     i_picorv32_mem_top___i_picorv32___instr_slli  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_imm &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b001))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000); 
                     i_picorv32_mem_top___i_picorv32___instr_srli  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_imm &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b101))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000); 
                     i_picorv32_mem_top___i_picorv32___instr_srai  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_imm &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b101))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0100000); 
                     i_picorv32_mem_top___i_picorv32___instr_add  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_reg &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b000))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000); 
                     i_picorv32_mem_top___i_picorv32___instr_sub  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_reg &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b000))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0100000); 
                     i_picorv32_mem_top___i_picorv32___instr_sll  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_reg &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b001))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000); 
                     i_picorv32_mem_top___i_picorv32___instr_slt  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_reg &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b010))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000); 
                     i_picorv32_mem_top___i_picorv32___instr_sltu  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_reg &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b011))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000); 
                     i_picorv32_mem_top___i_picorv32___instr_xor  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_reg &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b100))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000); 
                     i_picorv32_mem_top___i_picorv32___instr_srl  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_reg &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b101))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000); 
                     i_picorv32_mem_top___i_picorv32___instr_sra  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_reg &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b101))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0100000); 
                     i_picorv32_mem_top___i_picorv32___instr_or  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_reg &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b110))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000); 
                     i_picorv32_mem_top___i_picorv32___instr_and  <=( i_picorv32_mem_top___i_picorv32___is_alu_reg_reg &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b111))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000); 
                     i_picorv32_mem_top___i_picorv32___instr_rdcycle  <=(((( i_picorv32_mem_top___i_picorv32___mem_rdata_q [6:0]==7'b1110011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:20]=='b101100000000))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [13:12]!='b0))||((( i_picorv32_mem_top___i_picorv32___mem_rdata_q [6:0]==7'b1110011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:20]=='b101100000001))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [13:12]!='b0)))&& i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS ; 
                     i_picorv32_mem_top___i_picorv32___instr_rdcycleh  <=((((( i_picorv32_mem_top___i_picorv32___mem_rdata_q [6:0]==7'b1110011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:20]=='b101110000000))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [13:12]!='b0))||((( i_picorv32_mem_top___i_picorv32___mem_rdata_q [6:0]==7'b1110011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:20]=='b101110000001))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [13:12]!='b0)))&& i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS )&& i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS64 ; 
                     i_picorv32_mem_top___i_picorv32___instr_rdinstr  <=((( i_picorv32_mem_top___i_picorv32___mem_rdata_q [6:0]==7'b1110011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:20]=='b101100000010))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [13:12]!='b0))&& i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS ; 
                     i_picorv32_mem_top___i_picorv32___instr_rdinstrh  <=(((( i_picorv32_mem_top___i_picorv32___mem_rdata_q [6:0]==7'b1110011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:20]=='b101110000010))&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [13:12]!='b0))&& i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS )&& i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS64 ; 
                     i_picorv32_mem_top___i_picorv32___instr_ecall_ebreak  <=((( i_picorv32_mem_top___i_picorv32___mem_rdata_q [6:0]==7'b1110011)&& ! i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:21])&& ! i_picorv32_mem_top___i_picorv32___mem_rdata_q [19:7])||( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA &&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [15:0]==16'h9002)); 
                     i_picorv32_mem_top___i_picorv32___instr_fence  <=( i_picorv32_mem_top___i_picorv32___mem_rdata_q [6:0]==7'b0001111)&& ! i_picorv32_mem_top___i_picorv32___mem_rdata_q [15:12]; 
                     i_picorv32_mem_top___i_picorv32___instr_getq  <=((( i_picorv32_mem_top___i_picorv32___mem_rdata_q [6:0]==7'b0001011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000))&& i_picorv32_mem_top___i_picorv32___ENABLE_IRQ )&& i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_QREGS ; 
                     i_picorv32_mem_top___i_picorv32___instr_setq  <=((( i_picorv32_mem_top___i_picorv32___mem_rdata_q [6:0]==7'b0001011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000001))&& i_picorv32_mem_top___i_picorv32___ENABLE_IRQ )&& i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_QREGS ; 
                     i_picorv32_mem_top___i_picorv32___instr_maskirq  <=(( i_picorv32_mem_top___i_picorv32___mem_rdata_q [6:0]==7'b0001011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000011))&& i_picorv32_mem_top___i_picorv32___ENABLE_IRQ ; 
                     i_picorv32_mem_top___i_picorv32___instr_timer  <=((( i_picorv32_mem_top___i_picorv32___mem_rdata_q [6:0]==7'b0001011)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000101))&& i_picorv32_mem_top___i_picorv32___ENABLE_IRQ )&& i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_TIMER ; 
                     i_picorv32_mem_top___i_picorv32___is_slli_srli_srai  <= i_picorv32_mem_top___i_picorv32___is_alu_reg_imm && |{( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b001)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000),( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b101)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000),( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b101)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0100000)}; 
                     i_picorv32_mem_top___i_picorv32___is_jalr_addi_slti_sltiu_xori_ori_andi  <= i_picorv32_mem_top___i_picorv32___instr_jalr ||( i_picorv32_mem_top___i_picorv32___is_alu_reg_imm && |{ i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b000, i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b010, i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b011, i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b100, i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b110, i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b111}); 
                     i_picorv32_mem_top___i_picorv32___is_sll_srl_sra  <= i_picorv32_mem_top___i_picorv32___is_alu_reg_reg && |{( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b001)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000),( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b101)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0000000),( i_picorv32_mem_top___i_picorv32___mem_rdata_q [14:12]==3'b101)&&( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25]==7'b0100000)}; 
                     i_picorv32_mem_top___i_picorv32___is_lui_auipc_jal_jalr_addi_add_sub  <=0; 
                     i_picorv32_mem_top___i_picorv32___is_compare  <=0;(* i_picorv32_mem_top___i_picorv32___parallel_case *)
                     case (1'b1) 
                      i_picorv32_mem_top___i_picorv32___instr_jal  : 
                          i_picorv32_mem_top___i_picorv32___decoded_imm  <= i_picorv32_mem_top___i_picorv32___decoded_imm_j ; 
                      | { i_picorv32_mem_top___i_picorv32___instr_lui , i_picorv32_mem_top___i_picorv32___instr_auipc }: 
                          i_picorv32_mem_top___i_picorv32___decoded_imm  <= i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:12]<<12; 
                      | { i_picorv32_mem_top___i_picorv32___instr_jalr , i_picorv32_mem_top___i_picorv32___is_lb_lh_lw_lbu_lhu , i_picorv32_mem_top___i_picorv32___is_alu_reg_imm }: 
                          i_picorv32_mem_top___i_picorv32___decoded_imm  <=$signed( i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:20]); 
                      i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu  : 
                          i_picorv32_mem_top___i_picorv32___decoded_imm  <=$signed({ i_picorv32_mem_top___i_picorv32___mem_rdata_q [31], i_picorv32_mem_top___i_picorv32___mem_rdata_q [7], i_picorv32_mem_top___i_picorv32___mem_rdata_q [30:25], i_picorv32_mem_top___i_picorv32___mem_rdata_q [11:8],1'b0}); 
                      i_picorv32_mem_top___i_picorv32___is_sb_sh_sw  : 
                          i_picorv32_mem_top___i_picorv32___decoded_imm  <=$signed({ i_picorv32_mem_top___i_picorv32___mem_rdata_q [31:25], i_picorv32_mem_top___i_picorv32___mem_rdata_q [11:7]});
                      default : 
                          i_picorv32_mem_top___i_picorv32___decoded_imm  <=1'bx;
                     endcase
                 end 
             if ( ! i_picorv32_mem_top___i_picorv32___resetn )
                 begin  
                     i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu  <=0; 
                     i_picorv32_mem_top___i_picorv32___is_compare  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_beq  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_bne  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_blt  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_bge  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_bltu  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_bgeu  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_addi  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_slti  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_sltiu  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_xori  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_ori  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_andi  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_add  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_sub  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_sll  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_slt  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_sltu  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_xor  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_srl  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_sra  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_or  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_and  <=0; 
                     i_picorv32_mem_top___i_picorv32___instr_fence  <=0;
                 end 
         end
  localparam i_picorv32_mem_top___i_picorv32___cpu_state_trap =8'b10000000; localparam i_picorv32_mem_top___i_picorv32___cpu_state_fetch =8'b01000000; localparam i_picorv32_mem_top___i_picorv32___cpu_state_ld_rs1 =8'b00100000; localparam i_picorv32_mem_top___i_picorv32___cpu_state_ld_rs2 =8'b00010000; localparam i_picorv32_mem_top___i_picorv32___cpu_state_exec =8'b00001000; localparam i_picorv32_mem_top___i_picorv32___cpu_state_shift =8'b00000100; localparam i_picorv32_mem_top___i_picorv32___cpu_state_stmem =8'b00000010; localparam i_picorv32_mem_top___i_picorv32___cpu_state_ldmem =8'b00000001; reg[7:0] i_picorv32_mem_top___i_picorv32___cpu_state ; reg[1:0] i_picorv32_mem_top___i_picorv32___irq_state ; reg[127:0] i_picorv32_mem_top___i_picorv32___dbg_ascii_state ; 
  always @(*)
         begin  
             i_picorv32_mem_top___i_picorv32___dbg_ascii_state  ="";
             if ( i_picorv32_mem_top___i_picorv32___cpu_state == i_picorv32_mem_top___i_picorv32___cpu_state_trap ) 
                 i_picorv32_mem_top___i_picorv32___dbg_ascii_state  ="trap";
             if ( i_picorv32_mem_top___i_picorv32___cpu_state == i_picorv32_mem_top___i_picorv32___cpu_state_fetch ) 
                 i_picorv32_mem_top___i_picorv32___dbg_ascii_state  ="fetch";
             if ( i_picorv32_mem_top___i_picorv32___cpu_state == i_picorv32_mem_top___i_picorv32___cpu_state_ld_rs1 ) 
                 i_picorv32_mem_top___i_picorv32___dbg_ascii_state  ="ld_rs1";
             if ( i_picorv32_mem_top___i_picorv32___cpu_state == i_picorv32_mem_top___i_picorv32___cpu_state_ld_rs2 ) 
                 i_picorv32_mem_top___i_picorv32___dbg_ascii_state  ="ld_rs2";
             if ( i_picorv32_mem_top___i_picorv32___cpu_state == i_picorv32_mem_top___i_picorv32___cpu_state_exec ) 
                 i_picorv32_mem_top___i_picorv32___dbg_ascii_state  ="exec";
             if ( i_picorv32_mem_top___i_picorv32___cpu_state == i_picorv32_mem_top___i_picorv32___cpu_state_shift ) 
                 i_picorv32_mem_top___i_picorv32___dbg_ascii_state  ="shift";
             if ( i_picorv32_mem_top___i_picorv32___cpu_state == i_picorv32_mem_top___i_picorv32___cpu_state_stmem ) 
                 i_picorv32_mem_top___i_picorv32___dbg_ascii_state  ="stmem";
             if ( i_picorv32_mem_top___i_picorv32___cpu_state == i_picorv32_mem_top___i_picorv32___cpu_state_ldmem ) 
                 i_picorv32_mem_top___i_picorv32___dbg_ascii_state  ="ldmem";
         end
    reg i_picorv32_mem_top___i_picorv32___set_mem_do_rinst ; 
    reg i_picorv32_mem_top___i_picorv32___set_mem_do_rdata ; 
    reg i_picorv32_mem_top___i_picorv32___set_mem_do_wdata ; 
    reg i_picorv32_mem_top___i_picorv32___latched_store ; 
    reg i_picorv32_mem_top___i_picorv32___latched_stalu ; 
    reg i_picorv32_mem_top___i_picorv32___latched_branch ; 
    reg i_picorv32_mem_top___i_picorv32___latched_compr ; 
    reg i_picorv32_mem_top___i_picorv32___latched_trace ; 
    reg i_picorv32_mem_top___i_picorv32___latched_is_lu ; 
    reg i_picorv32_mem_top___i_picorv32___latched_is_lh ; 
    reg i_picorv32_mem_top___i_picorv32___latched_is_lb ; reg[ i_picorv32_mem_top___i_picorv32___regindex_bits -1:0] i_picorv32_mem_top___i_picorv32___latched_rd ; reg[31:0] i_picorv32_mem_top___i_picorv32___current_pc ; 
  assign  i_picorv32_mem_top___i_picorv32___next_pc =( i_picorv32_mem_top___i_picorv32___latched_store && i_picorv32_mem_top___i_picorv32___latched_branch  ?  i_picorv32_mem_top___i_picorv32___reg_out & ~1: i_picorv32_mem_top___i_picorv32___reg_next_pc ); reg[3:0] i_picorv32_mem_top___i_picorv32___pcpi_timeout_counter ; 
    reg i_picorv32_mem_top___i_picorv32___pcpi_timeout ; reg[31:0] i_picorv32_mem_top___i_picorv32___next_irq_pending ; 
    reg i_picorv32_mem_top___i_picorv32___do_waitirq ; reg[31:0] i_picorv32_mem_top___i_picorv32___alu_out ; reg[31:0] i_picorv32_mem_top___i_picorv32___alu_out_q ; 
    reg i_picorv32_mem_top___i_picorv32___alu_out_0 ; 
    reg i_picorv32_mem_top___i_picorv32___alu_out_0_q ; 
    reg i_picorv32_mem_top___i_picorv32___alu_wait ; 
    reg i_picorv32_mem_top___i_picorv32___alu_wait_2 ; reg[31:0] i_picorv32_mem_top___i_picorv32___alu_add_sub ; reg[31:0] i_picorv32_mem_top___i_picorv32___alu_shl ; reg[31:0] i_picorv32_mem_top___i_picorv32___alu_shr ; 
    reg i_picorv32_mem_top___i_picorv32___alu_eq ; 
    reg i_picorv32_mem_top___i_picorv32___alu_ltu ; 
    reg i_picorv32_mem_top___i_picorv32___alu_lts ; 
 generate 
    if ( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_ALU )begin: i_picorv32_mem_top___i_picorv32___genblk3 
       always @( posedge  i_picorv32_mem_top___i_picorv32___clk )
              begin  
                  i_picorv32_mem_top___i_picorv32___alu_add_sub  <=( i_picorv32_mem_top___i_picorv32___instr_sub  ?  i_picorv32_mem_top___i_picorv32___reg_op1 - i_picorv32_mem_top___i_picorv32___reg_op2 : i_picorv32_mem_top___i_picorv32___reg_op1 + i_picorv32_mem_top___i_picorv32___reg_op2 ); 
                  i_picorv32_mem_top___i_picorv32___alu_eq  <= i_picorv32_mem_top___i_picorv32___reg_op1 == i_picorv32_mem_top___i_picorv32___reg_op2 ; 
                  i_picorv32_mem_top___i_picorv32___alu_lts  <=$signed( i_picorv32_mem_top___i_picorv32___reg_op1 )<$signed( i_picorv32_mem_top___i_picorv32___reg_op2 ); 
                  i_picorv32_mem_top___i_picorv32___alu_ltu  <= i_picorv32_mem_top___i_picorv32___reg_op1 < i_picorv32_mem_top___i_picorv32___reg_op2 ; 
                  i_picorv32_mem_top___i_picorv32___alu_shl  <= i_picorv32_mem_top___i_picorv32___reg_op1 << i_picorv32_mem_top___i_picorv32___reg_op2 [4:0]; 
                  i_picorv32_mem_top___i_picorv32___alu_shr  <=$signed({( i_picorv32_mem_top___i_picorv32___instr_sra || i_picorv32_mem_top___i_picorv32___instr_srai  ?  i_picorv32_mem_top___i_picorv32___reg_op1 [31]:1'b0), i_picorv32_mem_top___i_picorv32___reg_op1 })>>> i_picorv32_mem_top___i_picorv32___reg_op2 [4:0];
              end
 end
     else begin: i_picorv32_mem_top___i_picorv32___genblk3 
       always @(*)
              begin  
                  i_picorv32_mem_top___i_picorv32___alu_add_sub  =( i_picorv32_mem_top___i_picorv32___instr_sub  ?  i_picorv32_mem_top___i_picorv32___reg_op1 - i_picorv32_mem_top___i_picorv32___reg_op2 : i_picorv32_mem_top___i_picorv32___reg_op1 + i_picorv32_mem_top___i_picorv32___reg_op2 ); 
                  i_picorv32_mem_top___i_picorv32___alu_eq  = i_picorv32_mem_top___i_picorv32___reg_op1 == i_picorv32_mem_top___i_picorv32___reg_op2 ; 
                  i_picorv32_mem_top___i_picorv32___alu_lts  =$signed( i_picorv32_mem_top___i_picorv32___reg_op1 )<$signed( i_picorv32_mem_top___i_picorv32___reg_op2 ); 
                  i_picorv32_mem_top___i_picorv32___alu_ltu  = i_picorv32_mem_top___i_picorv32___reg_op1 < i_picorv32_mem_top___i_picorv32___reg_op2 ; 
                  i_picorv32_mem_top___i_picorv32___alu_shl  = i_picorv32_mem_top___i_picorv32___reg_op1 << i_picorv32_mem_top___i_picorv32___reg_op2 [4:0]; 
                  i_picorv32_mem_top___i_picorv32___alu_shr  =$signed({( i_picorv32_mem_top___i_picorv32___instr_sra || i_picorv32_mem_top___i_picorv32___instr_srai  ?  i_picorv32_mem_top___i_picorv32___reg_op1 [31]:1'b0), i_picorv32_mem_top___i_picorv32___reg_op1 })>>> i_picorv32_mem_top___i_picorv32___reg_op2 [4:0];
              end
 end
 endgenerate
  always @(*)
         begin  
             i_picorv32_mem_top___i_picorv32___alu_out_0  ='bx;(* i_picorv32_mem_top___i_picorv32___parallel_case , i_picorv32_mem_top___i_picorv32___full_case *)
             case (1'b1) 
              i_picorv32_mem_top___i_picorv32___instr_beq  : 
                  i_picorv32_mem_top___i_picorv32___alu_out_0  = i_picorv32_mem_top___i_picorv32___alu_eq ; 
              i_picorv32_mem_top___i_picorv32___instr_bne  : 
                  i_picorv32_mem_top___i_picorv32___alu_out_0  = ! i_picorv32_mem_top___i_picorv32___alu_eq ; 
              i_picorv32_mem_top___i_picorv32___instr_bge  : 
                  i_picorv32_mem_top___i_picorv32___alu_out_0  = ! i_picorv32_mem_top___i_picorv32___alu_lts ; 
              i_picorv32_mem_top___i_picorv32___instr_bgeu  : 
                  i_picorv32_mem_top___i_picorv32___alu_out_0  = ! i_picorv32_mem_top___i_picorv32___alu_ltu ; 
              i_picorv32_mem_top___i_picorv32___is_slti_blt_slt  &&( ! i_picorv32_mem_top___i_picorv32___TWO_CYCLE_COMPARE || !{ i_picorv32_mem_top___i_picorv32___instr_beq , i_picorv32_mem_top___i_picorv32___instr_bne , i_picorv32_mem_top___i_picorv32___instr_bge , i_picorv32_mem_top___i_picorv32___instr_bgeu }): 
                  i_picorv32_mem_top___i_picorv32___alu_out_0  = i_picorv32_mem_top___i_picorv32___alu_lts ; 
              i_picorv32_mem_top___i_picorv32___is_sltiu_bltu_sltu  &&( ! i_picorv32_mem_top___i_picorv32___TWO_CYCLE_COMPARE || !{ i_picorv32_mem_top___i_picorv32___instr_beq , i_picorv32_mem_top___i_picorv32___instr_bne , i_picorv32_mem_top___i_picorv32___instr_bge , i_picorv32_mem_top___i_picorv32___instr_bgeu }): 
                  i_picorv32_mem_top___i_picorv32___alu_out_0  = i_picorv32_mem_top___i_picorv32___alu_ltu ;
             endcase
             i_picorv32_mem_top___i_picorv32___alu_out  ='bx;(* i_picorv32_mem_top___i_picorv32___parallel_case , i_picorv32_mem_top___i_picorv32___full_case *)
             case (1'b1) 
              i_picorv32_mem_top___i_picorv32___is_lui_auipc_jal_jalr_addi_add_sub  : 
                  i_picorv32_mem_top___i_picorv32___alu_out  = i_picorv32_mem_top___i_picorv32___alu_add_sub ; 
              i_picorv32_mem_top___i_picorv32___is_compare  : 
                  i_picorv32_mem_top___i_picorv32___alu_out  = i_picorv32_mem_top___i_picorv32___alu_out_0 ; 
              i_picorv32_mem_top___i_picorv32___instr_xori  || i_picorv32_mem_top___i_picorv32___instr_xor : 
                  i_picorv32_mem_top___i_picorv32___alu_out  = i_picorv32_mem_top___i_picorv32___reg_op1 ^ i_picorv32_mem_top___i_picorv32___reg_op2 ; 
              i_picorv32_mem_top___i_picorv32___instr_ori  || i_picorv32_mem_top___i_picorv32___instr_or : 
                  i_picorv32_mem_top___i_picorv32___alu_out  = i_picorv32_mem_top___i_picorv32___reg_op1 | i_picorv32_mem_top___i_picorv32___reg_op2 ; 
              i_picorv32_mem_top___i_picorv32___instr_andi  || i_picorv32_mem_top___i_picorv32___instr_and : 
                  i_picorv32_mem_top___i_picorv32___alu_out  = i_picorv32_mem_top___i_picorv32___reg_op1 & i_picorv32_mem_top___i_picorv32___reg_op2 ; 
              i_picorv32_mem_top___i_picorv32___BARREL_SHIFTER  &&( i_picorv32_mem_top___i_picorv32___instr_sll || i_picorv32_mem_top___i_picorv32___instr_slli ): 
                  i_picorv32_mem_top___i_picorv32___alu_out  = i_picorv32_mem_top___i_picorv32___alu_shl ; 
              i_picorv32_mem_top___i_picorv32___BARREL_SHIFTER  &&((( i_picorv32_mem_top___i_picorv32___instr_srl || i_picorv32_mem_top___i_picorv32___instr_srli )|| i_picorv32_mem_top___i_picorv32___instr_sra )|| i_picorv32_mem_top___i_picorv32___instr_srai ): 
                  i_picorv32_mem_top___i_picorv32___alu_out  = i_picorv32_mem_top___i_picorv32___alu_shr ;
             endcase
         end
    reg i_picorv32_mem_top___i_picorv32___clear_prefetched_high_word_q ; 
  always @( posedge  i_picorv32_mem_top___i_picorv32___clk ) 
         i_picorv32_mem_top___i_picorv32___clear_prefetched_high_word_q  <= i_picorv32_mem_top___i_picorv32___clear_prefetched_high_word ;
  always @(*)
         begin  
             i_picorv32_mem_top___i_picorv32___clear_prefetched_high_word  = i_picorv32_mem_top___i_picorv32___clear_prefetched_high_word_q ;
             if ( ! i_picorv32_mem_top___i_picorv32___prefetched_high_word ) 
                 i_picorv32_mem_top___i_picorv32___clear_prefetched_high_word  =0;
             if (( i_picorv32_mem_top___i_picorv32___latched_branch || i_picorv32_mem_top___i_picorv32___irq_state )|| ! i_picorv32_mem_top___i_picorv32___resetn ) 
                 i_picorv32_mem_top___i_picorv32___clear_prefetched_high_word  = i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA ;
         end
    reg i_picorv32_mem_top___i_picorv32___cpuregs_write ; reg[31:0] i_picorv32_mem_top___i_picorv32___cpuregs_wrdata ; reg[31:0] i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; reg[31:0] i_picorv32_mem_top___i_picorv32___cpuregs_rs2 ; reg[ i_picorv32_mem_top___i_picorv32___regindex_bits -1:0] i_picorv32_mem_top___i_picorv32___decoded_rs ; 
  always @(*)
         begin  
             i_picorv32_mem_top___i_picorv32___cpuregs_write  =0; 
             i_picorv32_mem_top___i_picorv32___cpuregs_wrdata  ='bx;
             if ( i_picorv32_mem_top___i_picorv32___cpu_state == i_picorv32_mem_top___i_picorv32___cpu_state_fetch )(* i_picorv32_mem_top___i_picorv32___parallel_case *)
                 case (1'b1) 
                  i_picorv32_mem_top___i_picorv32___latched_branch  :
                      begin  
                          i_picorv32_mem_top___i_picorv32___cpuregs_wrdata  = i_picorv32_mem_top___i_picorv32___reg_pc +( i_picorv32_mem_top___i_picorv32___latched_compr  ? 2:4); 
                          i_picorv32_mem_top___i_picorv32___cpuregs_write  =1;
                      end  
                  i_picorv32_mem_top___i_picorv32___latched_store  && ! i_picorv32_mem_top___i_picorv32___latched_branch :
                      begin  
                          i_picorv32_mem_top___i_picorv32___cpuregs_wrdata  =( i_picorv32_mem_top___i_picorv32___latched_stalu  ?  i_picorv32_mem_top___i_picorv32___alu_out_q : i_picorv32_mem_top___i_picorv32___reg_out ); 
                          i_picorv32_mem_top___i_picorv32___cpuregs_write  =1;
                      end  
                  i_picorv32_mem_top___i_picorv32___ENABLE_IRQ  && i_picorv32_mem_top___i_picorv32___irq_state [0]:
                      begin  
                          i_picorv32_mem_top___i_picorv32___cpuregs_wrdata  = i_picorv32_mem_top___i_picorv32___reg_next_pc | i_picorv32_mem_top___i_picorv32___latched_compr ; 
                          i_picorv32_mem_top___i_picorv32___cpuregs_write  =1;
                      end  
                  i_picorv32_mem_top___i_picorv32___ENABLE_IRQ  && i_picorv32_mem_top___i_picorv32___irq_state [1]:
                      begin  
                          i_picorv32_mem_top___i_picorv32___cpuregs_wrdata  = i_picorv32_mem_top___i_picorv32___irq_pending & ~ i_picorv32_mem_top___i_picorv32___irq_mask ; 
                          i_picorv32_mem_top___i_picorv32___cpuregs_write  =1;
                      end 
                 endcase
         end
  always @( posedge  i_picorv32_mem_top___i_picorv32___clk )
         if (( i_picorv32_mem_top___i_picorv32___resetn && i_picorv32_mem_top___i_picorv32___cpuregs_write )&& i_picorv32_mem_top___i_picorv32___latched_rd ) 
             i_picorv32_mem_top___i_picorv32___cpuregs  [ i_picorv32_mem_top___i_picorv32___latched_rd ]<= i_picorv32_mem_top___i_picorv32___cpuregs_wrdata ;
  always @(*)
         begin  
             i_picorv32_mem_top___i_picorv32___decoded_rs  ='bx;
             if ( i_picorv32_mem_top___i_picorv32___ENABLE_REGS_DUALPORT )
                 begin  
                     i_picorv32_mem_top___i_picorv32___cpuregs_rs1  =( i_picorv32_mem_top___i_picorv32___decoded_rs1  ?  i_picorv32_mem_top___i_picorv32___cpuregs [ i_picorv32_mem_top___i_picorv32___decoded_rs1 ]:0); 
                     i_picorv32_mem_top___i_picorv32___cpuregs_rs2  =( i_picorv32_mem_top___i_picorv32___decoded_rs2  ?  i_picorv32_mem_top___i_picorv32___cpuregs [ i_picorv32_mem_top___i_picorv32___decoded_rs2 ]:0);
                 end 
              else 
                 begin  
                     i_picorv32_mem_top___i_picorv32___decoded_rs  =( i_picorv32_mem_top___i_picorv32___cpu_state == i_picorv32_mem_top___i_picorv32___cpu_state_ld_rs2  ?  i_picorv32_mem_top___i_picorv32___decoded_rs2 : i_picorv32_mem_top___i_picorv32___decoded_rs1 ); 
                     i_picorv32_mem_top___i_picorv32___cpuregs_rs1  =( i_picorv32_mem_top___i_picorv32___decoded_rs  ?  i_picorv32_mem_top___i_picorv32___cpuregs [ i_picorv32_mem_top___i_picorv32___decoded_rs ]:0); 
                     i_picorv32_mem_top___i_picorv32___cpuregs_rs2  = i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ;
                 end 
         end
  assign  i_picorv32_mem_top___i_picorv32___launch_next_insn =(( i_picorv32_mem_top___i_picorv32___cpu_state == i_picorv32_mem_top___i_picorv32___cpu_state_fetch )&& i_picorv32_mem_top___i_picorv32___decoder_trigger )&&((( ! i_picorv32_mem_top___i_picorv32___ENABLE_IRQ || i_picorv32_mem_top___i_picorv32___irq_delay )|| i_picorv32_mem_top___i_picorv32___irq_active )|| !( i_picorv32_mem_top___i_picorv32___irq_pending & ~ i_picorv32_mem_top___i_picorv32___irq_mask )); 
  always @( posedge  i_picorv32_mem_top___i_picorv32___clk )
         begin  
             i_picorv32_mem_top___i_picorv32___trap  <=0; 
             i_picorv32_mem_top___i_picorv32___reg_sh  <='bx; 
             i_picorv32_mem_top___i_picorv32___reg_out  <='bx; 
             i_picorv32_mem_top___i_picorv32___set_mem_do_rinst  =0; 
             i_picorv32_mem_top___i_picorv32___set_mem_do_rdata  =0; 
             i_picorv32_mem_top___i_picorv32___set_mem_do_wdata  =0; 
             i_picorv32_mem_top___i_picorv32___alu_out_0_q  <= i_picorv32_mem_top___i_picorv32___alu_out_0 ; 
             i_picorv32_mem_top___i_picorv32___alu_out_q  <= i_picorv32_mem_top___i_picorv32___alu_out ; 
             i_picorv32_mem_top___i_picorv32___alu_wait  <=0; 
             i_picorv32_mem_top___i_picorv32___alu_wait_2  <=0;
             if ( i_picorv32_mem_top___i_picorv32___launch_next_insn )
                 begin  
                     i_picorv32_mem_top___i_picorv32___dbg_rs1val  <='bx; 
                     i_picorv32_mem_top___i_picorv32___dbg_rs2val  <='bx; 
                     i_picorv32_mem_top___i_picorv32___dbg_rs1val_valid  <=0; 
                     i_picorv32_mem_top___i_picorv32___dbg_rs2val_valid  <=0;
                 end 
             if ( i_picorv32_mem_top___i_picorv32___WITH_PCPI && i_picorv32_mem_top___i_picorv32___CATCH_ILLINSN )
                 begin 
                     if (( i_picorv32_mem_top___i_picorv32___resetn && i_picorv32_mem_top___i_picorv32___pcpi_valid )&& ! i_picorv32_mem_top___i_picorv32___pcpi_int_wait )
                         begin 
                             if ( i_picorv32_mem_top___i_picorv32___pcpi_timeout_counter ) 
                                 i_picorv32_mem_top___i_picorv32___pcpi_timeout_counter  <= i_picorv32_mem_top___i_picorv32___pcpi_timeout_counter -1;
                         end 
                      else  
                         i_picorv32_mem_top___i_picorv32___pcpi_timeout_counter  <= ~0; 
                     i_picorv32_mem_top___i_picorv32___pcpi_timeout  <= ! i_picorv32_mem_top___i_picorv32___pcpi_timeout_counter ;
                 end 
             if ( i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS )
                 begin  
                     i_picorv32_mem_top___i_picorv32___count_cycle  <=( i_picorv32_mem_top___i_picorv32___resetn  ?  i_picorv32_mem_top___i_picorv32___count_cycle +1:0);
                     if ( ! i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS64 ) 
                         i_picorv32_mem_top___i_picorv32___count_cycle  [63:32]<=0;
                 end 
              else 
                 begin  
                     i_picorv32_mem_top___i_picorv32___count_cycle  <='bx; 
                     i_picorv32_mem_top___i_picorv32___count_instr  <='bx;
                 end  
             i_picorv32_mem_top___i_picorv32___next_irq_pending  =( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ  ?  i_picorv32_mem_top___i_picorv32___irq_pending & i_picorv32_mem_top___i_picorv32___LATCHED_IRQ :'bx);
             if (( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ && i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_TIMER )&& i_picorv32_mem_top___i_picorv32___timer ) 
                 i_picorv32_mem_top___i_picorv32___timer  <= i_picorv32_mem_top___i_picorv32___timer -1; 
             i_picorv32_mem_top___i_picorv32___decoder_trigger  <= i_picorv32_mem_top___i_picorv32___mem_do_rinst && i_picorv32_mem_top___i_picorv32___mem_done ; 
             i_picorv32_mem_top___i_picorv32___decoder_trigger_q  <= i_picorv32_mem_top___i_picorv32___decoder_trigger ; 
             i_picorv32_mem_top___i_picorv32___decoder_pseudo_trigger  <=0; 
             i_picorv32_mem_top___i_picorv32___decoder_pseudo_trigger_q  <= i_picorv32_mem_top___i_picorv32___decoder_pseudo_trigger ; 
             i_picorv32_mem_top___i_picorv32___do_waitirq  <=0; 
             i_picorv32_mem_top___i_picorv32___trace_valid  <=0;
             if ( ! i_picorv32_mem_top___i_picorv32___ENABLE_TRACE ) 
                 i_picorv32_mem_top___i_picorv32___trace_data  <='bx;
             if ( ! i_picorv32_mem_top___i_picorv32___resetn )
                 begin  
                     i_picorv32_mem_top___i_picorv32___reg_pc  <= i_picorv32_mem_top___i_picorv32___PROGADDR_RESET ; 
                     i_picorv32_mem_top___i_picorv32___reg_next_pc  <= i_picorv32_mem_top___i_picorv32___PROGADDR_RESET ;
                     if ( i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS ) 
                         i_picorv32_mem_top___i_picorv32___count_instr  <=0; 
                     i_picorv32_mem_top___i_picorv32___latched_store  <=0; 
                     i_picorv32_mem_top___i_picorv32___latched_stalu  <=0; 
                     i_picorv32_mem_top___i_picorv32___latched_branch  <=0; 
                     i_picorv32_mem_top___i_picorv32___latched_trace  <=0; 
                     i_picorv32_mem_top___i_picorv32___latched_is_lu  <=0; 
                     i_picorv32_mem_top___i_picorv32___latched_is_lh  <=0; 
                     i_picorv32_mem_top___i_picorv32___latched_is_lb  <=0; 
                     i_picorv32_mem_top___i_picorv32___pcpi_valid  <=0; 
                     i_picorv32_mem_top___i_picorv32___pcpi_timeout  <=0; 
                     i_picorv32_mem_top___i_picorv32___irq_active  <=0; 
                     i_picorv32_mem_top___i_picorv32___irq_delay  <=0; 
                     i_picorv32_mem_top___i_picorv32___irq_mask  <= ~0; 
                     i_picorv32_mem_top___i_picorv32___next_irq_pending  =0; 
                     i_picorv32_mem_top___i_picorv32___irq_state  <=0; 
                     i_picorv32_mem_top___i_picorv32___eoi  <=0; 
                     i_picorv32_mem_top___i_picorv32___timer  <=0;
                     if ( ~ i_picorv32_mem_top___i_picorv32___STACKADDR )
                         begin  
                             i_picorv32_mem_top___i_picorv32___latched_store  <=1; 
                             i_picorv32_mem_top___i_picorv32___latched_rd  <=2; 
                             i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___STACKADDR ;
                         end  
                     i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                 end 
              else (* i_picorv32_mem_top___i_picorv32___parallel_case , i_picorv32_mem_top___i_picorv32___full_case *)
                 case ( i_picorv32_mem_top___i_picorv32___cpu_state ) 
                  i_picorv32_mem_top___i_picorv32___cpu_state_trap  : 
                      i_picorv32_mem_top___i_picorv32___trap  <=1; 
                  i_picorv32_mem_top___i_picorv32___cpu_state_fetch  :
                      begin  
                          i_picorv32_mem_top___i_picorv32___mem_do_rinst  <= ! i_picorv32_mem_top___i_picorv32___decoder_trigger && ! i_picorv32_mem_top___i_picorv32___do_waitirq ; 
                          i_picorv32_mem_top___i_picorv32___mem_wordsize  <=0; 
                          i_picorv32_mem_top___i_picorv32___current_pc  = i_picorv32_mem_top___i_picorv32___reg_next_pc ;(* i_picorv32_mem_top___i_picorv32___parallel_case *)
                          case (1'b1) 
                           i_picorv32_mem_top___i_picorv32___latched_branch  : 
                               i_picorv32_mem_top___i_picorv32___current_pc  =( i_picorv32_mem_top___i_picorv32___latched_store  ? ( i_picorv32_mem_top___i_picorv32___latched_stalu  ?  i_picorv32_mem_top___i_picorv32___alu_out_q : i_picorv32_mem_top___i_picorv32___reg_out )& ~1: i_picorv32_mem_top___i_picorv32___reg_next_pc ); 
                           i_picorv32_mem_top___i_picorv32___latched_store  && ! i_picorv32_mem_top___i_picorv32___latched_branch :; 
                           i_picorv32_mem_top___i_picorv32___ENABLE_IRQ  && i_picorv32_mem_top___i_picorv32___irq_state [0]:
                               begin  
                                   i_picorv32_mem_top___i_picorv32___current_pc  = i_picorv32_mem_top___i_picorv32___PROGADDR_IRQ ; 
                                   i_picorv32_mem_top___i_picorv32___irq_active  <=1; 
                                   i_picorv32_mem_top___i_picorv32___mem_do_rinst  <=1;
                               end  
                           i_picorv32_mem_top___i_picorv32___ENABLE_IRQ  && i_picorv32_mem_top___i_picorv32___irq_state [1]:
                               begin  
                                   i_picorv32_mem_top___i_picorv32___eoi  <= i_picorv32_mem_top___i_picorv32___irq_pending & ~ i_picorv32_mem_top___i_picorv32___irq_mask ; 
                                   i_picorv32_mem_top___i_picorv32___next_irq_pending  = i_picorv32_mem_top___i_picorv32___next_irq_pending & i_picorv32_mem_top___i_picorv32___irq_mask ;
                               end 
                          endcase
                          if ( i_picorv32_mem_top___i_picorv32___ENABLE_TRACE && i_picorv32_mem_top___i_picorv32___latched_trace )
                              begin  
                                  i_picorv32_mem_top___i_picorv32___latched_trace  <=0; 
                                  i_picorv32_mem_top___i_picorv32___trace_valid  <=1;
                                  if ( i_picorv32_mem_top___i_picorv32___latched_branch ) 
                                      i_picorv32_mem_top___i_picorv32___trace_data  <=(( i_picorv32_mem_top___i_picorv32___irq_active  ?  i_picorv32_mem_top___i_picorv32___TRACE_IRQ :0)| i_picorv32_mem_top___i_picorv32___TRACE_BRANCH )|( i_picorv32_mem_top___i_picorv32___current_pc &32'hfffffffe);
                                   else  
                                      i_picorv32_mem_top___i_picorv32___trace_data  <=( i_picorv32_mem_top___i_picorv32___irq_active  ?  i_picorv32_mem_top___i_picorv32___TRACE_IRQ :0)|( i_picorv32_mem_top___i_picorv32___latched_stalu  ?  i_picorv32_mem_top___i_picorv32___alu_out_q : i_picorv32_mem_top___i_picorv32___reg_out );
                              end  
                          i_picorv32_mem_top___i_picorv32___reg_pc  <= i_picorv32_mem_top___i_picorv32___current_pc ; 
                          i_picorv32_mem_top___i_picorv32___reg_next_pc  <= i_picorv32_mem_top___i_picorv32___current_pc ; 
                          i_picorv32_mem_top___i_picorv32___latched_store  <=0; 
                          i_picorv32_mem_top___i_picorv32___latched_stalu  <=0; 
                          i_picorv32_mem_top___i_picorv32___latched_branch  <=0; 
                          i_picorv32_mem_top___i_picorv32___latched_is_lu  <=0; 
                          i_picorv32_mem_top___i_picorv32___latched_is_lh  <=0; 
                          i_picorv32_mem_top___i_picorv32___latched_is_lb  <=0; 
                          i_picorv32_mem_top___i_picorv32___latched_rd  <= i_picorv32_mem_top___i_picorv32___decoded_rd ; 
                          i_picorv32_mem_top___i_picorv32___latched_compr  <= i_picorv32_mem_top___i_picorv32___compressed_instr ;
                          if ( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ &&(((( i_picorv32_mem_top___i_picorv32___decoder_trigger && ! i_picorv32_mem_top___i_picorv32___irq_active )&& ! i_picorv32_mem_top___i_picorv32___irq_delay )&& |( i_picorv32_mem_top___i_picorv32___irq_pending & ~ i_picorv32_mem_top___i_picorv32___irq_mask ))|| i_picorv32_mem_top___i_picorv32___irq_state ))
                              begin  
                                  i_picorv32_mem_top___i_picorv32___irq_state  <=( i_picorv32_mem_top___i_picorv32___irq_state ==2'b00 ? 2'b01:( i_picorv32_mem_top___i_picorv32___irq_state ==2'b01 ? 2'b10:2'b00)); 
                                  i_picorv32_mem_top___i_picorv32___latched_compr  <= i_picorv32_mem_top___i_picorv32___latched_compr ;
                                  if ( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_QREGS ) 
                                      i_picorv32_mem_top___i_picorv32___latched_rd  <= i_picorv32_mem_top___i_picorv32___irqregs_offset | i_picorv32_mem_top___i_picorv32___irq_state [0];
                                   else  
                                      i_picorv32_mem_top___i_picorv32___latched_rd  <=( i_picorv32_mem_top___i_picorv32___irq_state [0] ? 4:3);
                              end 
                           else 
                              if (( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ &&( i_picorv32_mem_top___i_picorv32___decoder_trigger || i_picorv32_mem_top___i_picorv32___do_waitirq ))&& i_picorv32_mem_top___i_picorv32___instr_waitirq )
                                  begin 
                                      if ( i_picorv32_mem_top___i_picorv32___irq_pending )
                                          begin  
                                              i_picorv32_mem_top___i_picorv32___latched_store  <=1; 
                                              i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___irq_pending ; 
                                              i_picorv32_mem_top___i_picorv32___reg_next_pc  <= i_picorv32_mem_top___i_picorv32___current_pc +( i_picorv32_mem_top___i_picorv32___compressed_instr  ? 2:4); 
                                              i_picorv32_mem_top___i_picorv32___mem_do_rinst  <=1;
                                          end 
                                       else  
                                          i_picorv32_mem_top___i_picorv32___do_waitirq  <=1;
                                  end 
                               else 
                                  if ( i_picorv32_mem_top___i_picorv32___decoder_trigger )
                                      begin  
                                          i_picorv32_mem_top___i_picorv32___irq_delay  <= i_picorv32_mem_top___i_picorv32___irq_active ; 
                                          i_picorv32_mem_top___i_picorv32___reg_next_pc  <= i_picorv32_mem_top___i_picorv32___current_pc +( i_picorv32_mem_top___i_picorv32___compressed_instr  ? 2:4);
                                          if ( i_picorv32_mem_top___i_picorv32___ENABLE_TRACE ) 
                                              i_picorv32_mem_top___i_picorv32___latched_trace  <=1;
                                          if ( i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS )
                                              begin  
                                                  i_picorv32_mem_top___i_picorv32___count_instr  <= i_picorv32_mem_top___i_picorv32___count_instr +1;
                                                  if ( ! i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS64 ) 
                                                      i_picorv32_mem_top___i_picorv32___count_instr  [63:32]<=0;
                                              end 
                                          if ( i_picorv32_mem_top___i_picorv32___instr_jal )
                                              begin  
                                                  i_picorv32_mem_top___i_picorv32___mem_do_rinst  <=1; 
                                                  i_picorv32_mem_top___i_picorv32___reg_next_pc  <= i_picorv32_mem_top___i_picorv32___current_pc + i_picorv32_mem_top___i_picorv32___decoded_imm_j ; 
                                                  i_picorv32_mem_top___i_picorv32___latched_branch  <=1;
                                              end 
                                           else 
                                              begin  
                                                  i_picorv32_mem_top___i_picorv32___mem_do_rinst  <=0; 
                                                  i_picorv32_mem_top___i_picorv32___mem_do_prefetch  <= ! i_picorv32_mem_top___i_picorv32___instr_jalr && ! i_picorv32_mem_top___i_picorv32___instr_retirq ; 
                                                  i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_ld_rs1 ;
                                              end 
                                      end 
                      end  
                  i_picorv32_mem_top___i_picorv32___cpu_state_ld_rs1  :
                      begin  
                          i_picorv32_mem_top___i_picorv32___reg_op1  <='bx; 
                          i_picorv32_mem_top___i_picorv32___reg_op2  <='bx;(* i_picorv32_mem_top___i_picorv32___parallel_case *)
                          case (1'b1)
                           (  i_picorv32_mem_top___i_picorv32___CATCH_ILLINSN || i_picorv32_mem_top___i_picorv32___WITH_PCPI )&& i_picorv32_mem_top___i_picorv32___instr_trap :
                               if ( i_picorv32_mem_top___i_picorv32___WITH_PCPI )
                                   begin  
                                       i_picorv32_mem_top___i_picorv32___reg_op1  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                       i_picorv32_mem_top___i_picorv32___dbg_rs1val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                       i_picorv32_mem_top___i_picorv32___dbg_rs1val_valid  <=1;
                                       if ( i_picorv32_mem_top___i_picorv32___ENABLE_REGS_DUALPORT )
                                           begin  
                                               i_picorv32_mem_top___i_picorv32___pcpi_valid  <=1; 
                                               i_picorv32_mem_top___i_picorv32___reg_sh  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs2 ; 
                                               i_picorv32_mem_top___i_picorv32___reg_op2  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs2 ; 
                                               i_picorv32_mem_top___i_picorv32___dbg_rs2val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs2 ; 
                                               i_picorv32_mem_top___i_picorv32___dbg_rs2val_valid  <=1;
                                               if ( i_picorv32_mem_top___i_picorv32___pcpi_int_ready )
                                                   begin  
                                                       i_picorv32_mem_top___i_picorv32___mem_do_rinst  <=1; 
                                                       i_picorv32_mem_top___i_picorv32___pcpi_valid  <=0; 
                                                       i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___pcpi_int_rd ; 
                                                       i_picorv32_mem_top___i_picorv32___latched_store  <= i_picorv32_mem_top___i_picorv32___pcpi_int_wr ; 
                                                       i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                                                   end 
                                                else 
                                                   if ( i_picorv32_mem_top___i_picorv32___CATCH_ILLINSN &&( i_picorv32_mem_top___i_picorv32___pcpi_timeout || i_picorv32_mem_top___i_picorv32___instr_ecall_ebreak ))
                                                       begin  
                                                           i_picorv32_mem_top___i_picorv32___pcpi_valid  <=0;
                                                           if (( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ && ! i_picorv32_mem_top___i_picorv32___irq_mask [ i_picorv32_mem_top___i_picorv32___irq_ebreak ])&& ! i_picorv32_mem_top___i_picorv32___irq_active )
                                                               begin  
                                                                   i_picorv32_mem_top___i_picorv32___next_irq_pending  [ i_picorv32_mem_top___i_picorv32___irq_ebreak ]=1; 
                                                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                                                               end 
                                                            else  
                                                               i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_trap ;
                                                       end 
                                           end 
                                        else  
                                           i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_ld_rs2 ;
                                   end 
                                else 
                                   if (( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ && ! i_picorv32_mem_top___i_picorv32___irq_mask [ i_picorv32_mem_top___i_picorv32___irq_ebreak ])&& ! i_picorv32_mem_top___i_picorv32___irq_active )
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___next_irq_pending  [ i_picorv32_mem_top___i_picorv32___irq_ebreak ]=1; 
                                           i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                                       end 
                                    else  
                                       i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_trap ; 
                           i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS  && i_picorv32_mem_top___i_picorv32___is_rdcycle_rdcycleh_rdinstr_rdinstrh :
                               begin (* i_picorv32_mem_top___i_picorv32___parallel_case , i_picorv32_mem_top___i_picorv32___full_case *)
                                   case (1'b1) 
                                    i_picorv32_mem_top___i_picorv32___instr_rdcycle  : 
                                        i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___count_cycle [31:0]; 
                                    i_picorv32_mem_top___i_picorv32___instr_rdcycleh  && i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS64 : 
                                        i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___count_cycle [63:32]; 
                                    i_picorv32_mem_top___i_picorv32___instr_rdinstr  : 
                                        i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___count_instr [31:0]; 
                                    i_picorv32_mem_top___i_picorv32___instr_rdinstrh  && i_picorv32_mem_top___i_picorv32___ENABLE_COUNTERS64 : 
                                        i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___count_instr [63:32];
                                   endcase
                                   i_picorv32_mem_top___i_picorv32___latched_store  <=1; 
                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                               end  
                           i_picorv32_mem_top___i_picorv32___is_lui_auipc_jal  :
                               begin  
                                   i_picorv32_mem_top___i_picorv32___reg_op1  <=( i_picorv32_mem_top___i_picorv32___instr_lui  ? 0: i_picorv32_mem_top___i_picorv32___reg_pc ); 
                                   i_picorv32_mem_top___i_picorv32___reg_op2  <= i_picorv32_mem_top___i_picorv32___decoded_imm ;
                                   if ( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_ALU ) 
                                       i_picorv32_mem_top___i_picorv32___alu_wait  <=1;
                                    else  
                                       i_picorv32_mem_top___i_picorv32___mem_do_rinst  <= i_picorv32_mem_top___i_picorv32___mem_do_prefetch ; 
                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_exec ;
                               end 
                           (  i_picorv32_mem_top___i_picorv32___ENABLE_IRQ && i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_QREGS )&& i_picorv32_mem_top___i_picorv32___instr_getq :
                               begin  
                                   i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val_valid  <=1; 
                                   i_picorv32_mem_top___i_picorv32___latched_store  <=1; 
                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                               end 
                           (  i_picorv32_mem_top___i_picorv32___ENABLE_IRQ && i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_QREGS )&& i_picorv32_mem_top___i_picorv32___instr_setq :
                               begin  
                                   i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val_valid  <=1; 
                                   i_picorv32_mem_top___i_picorv32___latched_rd  <= i_picorv32_mem_top___i_picorv32___latched_rd | i_picorv32_mem_top___i_picorv32___irqregs_offset ; 
                                   i_picorv32_mem_top___i_picorv32___latched_store  <=1; 
                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                               end  
                           i_picorv32_mem_top___i_picorv32___ENABLE_IRQ  && i_picorv32_mem_top___i_picorv32___instr_retirq :
                               begin  
                                   i_picorv32_mem_top___i_picorv32___eoi  <=0; 
                                   i_picorv32_mem_top___i_picorv32___irq_active  <=0; 
                                   i_picorv32_mem_top___i_picorv32___latched_branch  <=1; 
                                   i_picorv32_mem_top___i_picorv32___latched_store  <=1; 
                                   i_picorv32_mem_top___i_picorv32___reg_out  <=( i_picorv32_mem_top___i_picorv32___CATCH_MISALIGN  ?  i_picorv32_mem_top___i_picorv32___cpuregs_rs1 &32'hfffffffe: i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ); 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val_valid  <=1; 
                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                               end  
                           i_picorv32_mem_top___i_picorv32___ENABLE_IRQ  && i_picorv32_mem_top___i_picorv32___instr_maskirq :
                               begin  
                                   i_picorv32_mem_top___i_picorv32___latched_store  <=1; 
                                   i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___irq_mask ; 
                                   i_picorv32_mem_top___i_picorv32___irq_mask  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 | i_picorv32_mem_top___i_picorv32___MASKED_IRQ ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val_valid  <=1; 
                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                               end 
                           (  i_picorv32_mem_top___i_picorv32___ENABLE_IRQ && i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_TIMER )&& i_picorv32_mem_top___i_picorv32___instr_timer :
                               begin  
                                   i_picorv32_mem_top___i_picorv32___latched_store  <=1; 
                                   i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___timer ; 
                                   i_picorv32_mem_top___i_picorv32___timer  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val_valid  <=1; 
                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                               end  
                           i_picorv32_mem_top___i_picorv32___is_lb_lh_lw_lbu_lhu  && ! i_picorv32_mem_top___i_picorv32___instr_trap :
                               begin  
                                   i_picorv32_mem_top___i_picorv32___reg_op1  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val_valid  <=1; 
                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_ldmem ; 
                                   i_picorv32_mem_top___i_picorv32___mem_do_rinst  <=1;
                               end  
                           i_picorv32_mem_top___i_picorv32___is_slli_srli_srai  && ! i_picorv32_mem_top___i_picorv32___BARREL_SHIFTER :
                               begin  
                                   i_picorv32_mem_top___i_picorv32___reg_op1  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val_valid  <=1; 
                                   i_picorv32_mem_top___i_picorv32___reg_sh  <= i_picorv32_mem_top___i_picorv32___decoded_rs2 ; 
                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_shift ;
                               end  
                           i_picorv32_mem_top___i_picorv32___is_jalr_addi_slti_sltiu_xori_ori_andi  , i_picorv32_mem_top___i_picorv32___is_slli_srli_srai && i_picorv32_mem_top___i_picorv32___BARREL_SHIFTER :
                               begin  
                                   i_picorv32_mem_top___i_picorv32___reg_op1  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val_valid  <=1; 
                                   i_picorv32_mem_top___i_picorv32___reg_op2  <=( i_picorv32_mem_top___i_picorv32___is_slli_srli_srai && i_picorv32_mem_top___i_picorv32___BARREL_SHIFTER  ?  i_picorv32_mem_top___i_picorv32___decoded_rs2 : i_picorv32_mem_top___i_picorv32___decoded_imm );
                                   if ( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_ALU ) 
                                       i_picorv32_mem_top___i_picorv32___alu_wait  <=1;
                                    else  
                                       i_picorv32_mem_top___i_picorv32___mem_do_rinst  <= i_picorv32_mem_top___i_picorv32___mem_do_prefetch ; 
                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_exec ;
                               end 
                           default :
                               begin  
                                   i_picorv32_mem_top___i_picorv32___reg_op1  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs1 ; 
                                   i_picorv32_mem_top___i_picorv32___dbg_rs1val_valid  <=1;
                                   if ( i_picorv32_mem_top___i_picorv32___ENABLE_REGS_DUALPORT )
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___reg_sh  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs2 ; 
                                           i_picorv32_mem_top___i_picorv32___reg_op2  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs2 ; 
                                           i_picorv32_mem_top___i_picorv32___dbg_rs2val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs2 ; 
                                           i_picorv32_mem_top___i_picorv32___dbg_rs2val_valid  <=1;(* i_picorv32_mem_top___i_picorv32___parallel_case *)
                                           case (1'b1) 
                                            i_picorv32_mem_top___i_picorv32___is_sb_sh_sw  :
                                                begin  
                                                    i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_stmem ; 
                                                    i_picorv32_mem_top___i_picorv32___mem_do_rinst  <=1;
                                                end  
                                            i_picorv32_mem_top___i_picorv32___is_sll_srl_sra  && ! i_picorv32_mem_top___i_picorv32___BARREL_SHIFTER : 
                                                i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_shift ;
                                            default :
                                                begin 
                                                    if ( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_ALU ||( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_COMPARE && i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu ))
                                                        begin  
                                                            i_picorv32_mem_top___i_picorv32___alu_wait_2  <= i_picorv32_mem_top___i_picorv32___TWO_CYCLE_ALU &&( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_COMPARE && i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu ); 
                                                            i_picorv32_mem_top___i_picorv32___alu_wait  <=1;
                                                        end 
                                                     else  
                                                        i_picorv32_mem_top___i_picorv32___mem_do_rinst  <= i_picorv32_mem_top___i_picorv32___mem_do_prefetch ; 
                                                    i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_exec ;
                                                end 
                                           endcase
                                       end 
                                    else  
                                       i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_ld_rs2 ;
                               end 
                          endcase
                      end  
                  i_picorv32_mem_top___i_picorv32___cpu_state_ld_rs2  :
                      begin  
                          i_picorv32_mem_top___i_picorv32___reg_sh  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs2 ; 
                          i_picorv32_mem_top___i_picorv32___reg_op2  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs2 ; 
                          i_picorv32_mem_top___i_picorv32___dbg_rs2val  <= i_picorv32_mem_top___i_picorv32___cpuregs_rs2 ; 
                          i_picorv32_mem_top___i_picorv32___dbg_rs2val_valid  <=1;(* i_picorv32_mem_top___i_picorv32___parallel_case *)
                          case (1'b1) 
                           i_picorv32_mem_top___i_picorv32___WITH_PCPI  && i_picorv32_mem_top___i_picorv32___instr_trap :
                               begin  
                                   i_picorv32_mem_top___i_picorv32___pcpi_valid  <=1;
                                   if ( i_picorv32_mem_top___i_picorv32___pcpi_int_ready )
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___mem_do_rinst  <=1; 
                                           i_picorv32_mem_top___i_picorv32___pcpi_valid  <=0; 
                                           i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___pcpi_int_rd ; 
                                           i_picorv32_mem_top___i_picorv32___latched_store  <= i_picorv32_mem_top___i_picorv32___pcpi_int_wr ; 
                                           i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                                       end 
                                    else 
                                       if ( i_picorv32_mem_top___i_picorv32___CATCH_ILLINSN &&( i_picorv32_mem_top___i_picorv32___pcpi_timeout || i_picorv32_mem_top___i_picorv32___instr_ecall_ebreak ))
                                           begin  
                                               i_picorv32_mem_top___i_picorv32___pcpi_valid  <=0;
                                               if (( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ && ! i_picorv32_mem_top___i_picorv32___irq_mask [ i_picorv32_mem_top___i_picorv32___irq_ebreak ])&& ! i_picorv32_mem_top___i_picorv32___irq_active )
                                                   begin  
                                                       i_picorv32_mem_top___i_picorv32___next_irq_pending  [ i_picorv32_mem_top___i_picorv32___irq_ebreak ]=1; 
                                                       i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                                                   end 
                                                else  
                                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_trap ;
                                           end 
                               end  
                           i_picorv32_mem_top___i_picorv32___is_sb_sh_sw  :
                               begin  
                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_stmem ; 
                                   i_picorv32_mem_top___i_picorv32___mem_do_rinst  <=1;
                               end  
                           i_picorv32_mem_top___i_picorv32___is_sll_srl_sra  && ! i_picorv32_mem_top___i_picorv32___BARREL_SHIFTER : 
                               i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_shift ;
                           default :
                               begin 
                                   if ( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_ALU ||( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_COMPARE && i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu ))
                                       begin  
                                           i_picorv32_mem_top___i_picorv32___alu_wait_2  <= i_picorv32_mem_top___i_picorv32___TWO_CYCLE_ALU &&( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_COMPARE && i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu ); 
                                           i_picorv32_mem_top___i_picorv32___alu_wait  <=1;
                                       end 
                                    else  
                                       i_picorv32_mem_top___i_picorv32___mem_do_rinst  <= i_picorv32_mem_top___i_picorv32___mem_do_prefetch ; 
                                   i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_exec ;
                               end 
                          endcase
                      end  
                  i_picorv32_mem_top___i_picorv32___cpu_state_exec  :
                      begin  
                          i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___reg_pc + i_picorv32_mem_top___i_picorv32___decoded_imm ;
                          if (( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_ALU || i_picorv32_mem_top___i_picorv32___TWO_CYCLE_COMPARE )&&( i_picorv32_mem_top___i_picorv32___alu_wait || i_picorv32_mem_top___i_picorv32___alu_wait_2 ))
                              begin  
                                  i_picorv32_mem_top___i_picorv32___mem_do_rinst  <= i_picorv32_mem_top___i_picorv32___mem_do_prefetch && ! i_picorv32_mem_top___i_picorv32___alu_wait_2 ; 
                                  i_picorv32_mem_top___i_picorv32___alu_wait  <= i_picorv32_mem_top___i_picorv32___alu_wait_2 ;
                              end 
                           else 
                              if ( i_picorv32_mem_top___i_picorv32___is_beq_bne_blt_bge_bltu_bgeu )
                                  begin  
                                      i_picorv32_mem_top___i_picorv32___latched_rd  <=0; 
                                      i_picorv32_mem_top___i_picorv32___latched_store  <=( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_COMPARE  ?  i_picorv32_mem_top___i_picorv32___alu_out_0_q : i_picorv32_mem_top___i_picorv32___alu_out_0 ); 
                                      i_picorv32_mem_top___i_picorv32___latched_branch  <=( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_COMPARE  ?  i_picorv32_mem_top___i_picorv32___alu_out_0_q : i_picorv32_mem_top___i_picorv32___alu_out_0 );
                                      if ( i_picorv32_mem_top___i_picorv32___mem_done ) 
                                          i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                                      if (( i_picorv32_mem_top___i_picorv32___TWO_CYCLE_COMPARE  ?  i_picorv32_mem_top___i_picorv32___alu_out_0_q : i_picorv32_mem_top___i_picorv32___alu_out_0 ))
                                          begin  
                                              i_picorv32_mem_top___i_picorv32___decoder_trigger  <=0; 
                                              i_picorv32_mem_top___i_picorv32___set_mem_do_rinst  =1;
                                          end 
                                  end 
                               else 
                                  begin  
                                      i_picorv32_mem_top___i_picorv32___latched_branch  <= i_picorv32_mem_top___i_picorv32___instr_jalr ; 
                                      i_picorv32_mem_top___i_picorv32___latched_store  <=1; 
                                      i_picorv32_mem_top___i_picorv32___latched_stalu  <=1; 
                                      i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                                  end 
                      end  
                  i_picorv32_mem_top___i_picorv32___cpu_state_shift  :
                      begin  
                          i_picorv32_mem_top___i_picorv32___latched_store  <=1;
                          if ( i_picorv32_mem_top___i_picorv32___reg_sh ==0)
                              begin  
                                  i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___reg_op1 ; 
                                  i_picorv32_mem_top___i_picorv32___mem_do_rinst  <= i_picorv32_mem_top___i_picorv32___mem_do_prefetch ; 
                                  i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                              end 
                           else 
                              if ( i_picorv32_mem_top___i_picorv32___TWO_STAGE_SHIFT &&( i_picorv32_mem_top___i_picorv32___reg_sh >=4))
                                  begin (* i_picorv32_mem_top___i_picorv32___parallel_case , i_picorv32_mem_top___i_picorv32___full_case *)
                                      case (1'b1) 
                                       i_picorv32_mem_top___i_picorv32___instr_slli  || i_picorv32_mem_top___i_picorv32___instr_sll : 
                                           i_picorv32_mem_top___i_picorv32___reg_op1  <= i_picorv32_mem_top___i_picorv32___reg_op1 <<4; 
                                       i_picorv32_mem_top___i_picorv32___instr_srli  || i_picorv32_mem_top___i_picorv32___instr_srl : 
                                           i_picorv32_mem_top___i_picorv32___reg_op1  <= i_picorv32_mem_top___i_picorv32___reg_op1 >>4; 
                                       i_picorv32_mem_top___i_picorv32___instr_srai  || i_picorv32_mem_top___i_picorv32___instr_sra : 
                                           i_picorv32_mem_top___i_picorv32___reg_op1  <=$signed( i_picorv32_mem_top___i_picorv32___reg_op1 )>>>4;
                                      endcase
                                      i_picorv32_mem_top___i_picorv32___reg_sh  <= i_picorv32_mem_top___i_picorv32___reg_sh -4;
                                  end 
                               else 
                                  begin (* i_picorv32_mem_top___i_picorv32___parallel_case , i_picorv32_mem_top___i_picorv32___full_case *)
                                      case (1'b1) 
                                       i_picorv32_mem_top___i_picorv32___instr_slli  || i_picorv32_mem_top___i_picorv32___instr_sll : 
                                           i_picorv32_mem_top___i_picorv32___reg_op1  <= i_picorv32_mem_top___i_picorv32___reg_op1 <<1; 
                                       i_picorv32_mem_top___i_picorv32___instr_srli  || i_picorv32_mem_top___i_picorv32___instr_srl : 
                                           i_picorv32_mem_top___i_picorv32___reg_op1  <= i_picorv32_mem_top___i_picorv32___reg_op1 >>1; 
                                       i_picorv32_mem_top___i_picorv32___instr_srai  || i_picorv32_mem_top___i_picorv32___instr_sra : 
                                           i_picorv32_mem_top___i_picorv32___reg_op1  <=$signed( i_picorv32_mem_top___i_picorv32___reg_op1 )>>>1;
                                      endcase
                                      i_picorv32_mem_top___i_picorv32___reg_sh  <= i_picorv32_mem_top___i_picorv32___reg_sh -1;
                                  end 
                      end  
                  i_picorv32_mem_top___i_picorv32___cpu_state_stmem  :
                      begin 
                          if ( i_picorv32_mem_top___i_picorv32___ENABLE_TRACE ) 
                              i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___reg_op2 ;
                          if ( ! i_picorv32_mem_top___i_picorv32___mem_do_prefetch || i_picorv32_mem_top___i_picorv32___mem_done )
                              begin 
                                  if ( ! i_picorv32_mem_top___i_picorv32___mem_do_wdata )
                                      begin (* i_picorv32_mem_top___i_picorv32___parallel_case , i_picorv32_mem_top___i_picorv32___full_case *)
                                          case (1'b1) 
                                           i_picorv32_mem_top___i_picorv32___instr_sb  : 
                                               i_picorv32_mem_top___i_picorv32___mem_wordsize  <=2; 
                                           i_picorv32_mem_top___i_picorv32___instr_sh  : 
                                               i_picorv32_mem_top___i_picorv32___mem_wordsize  <=1; 
                                           i_picorv32_mem_top___i_picorv32___instr_sw  : 
                                               i_picorv32_mem_top___i_picorv32___mem_wordsize  <=0;
                                          endcase
                                          if ( i_picorv32_mem_top___i_picorv32___ENABLE_TRACE )
                                              begin  
                                                  i_picorv32_mem_top___i_picorv32___trace_valid  <=1; 
                                                  i_picorv32_mem_top___i_picorv32___trace_data  <=(( i_picorv32_mem_top___i_picorv32___irq_active  ?  i_picorv32_mem_top___i_picorv32___TRACE_IRQ :0)| i_picorv32_mem_top___i_picorv32___TRACE_ADDR )|(( i_picorv32_mem_top___i_picorv32___reg_op1 + i_picorv32_mem_top___i_picorv32___decoded_imm )&32'hffffffff);
                                              end  
                                          i_picorv32_mem_top___i_picorv32___reg_op1  <= i_picorv32_mem_top___i_picorv32___reg_op1 + i_picorv32_mem_top___i_picorv32___decoded_imm ; 
                                          i_picorv32_mem_top___i_picorv32___set_mem_do_wdata  =1;
                                      end 
                                  if ( ! i_picorv32_mem_top___i_picorv32___mem_do_prefetch && i_picorv32_mem_top___i_picorv32___mem_done )
                                      begin  
                                          i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ; 
                                          i_picorv32_mem_top___i_picorv32___decoder_trigger  <=1; 
                                          i_picorv32_mem_top___i_picorv32___decoder_pseudo_trigger  <=1;
                                      end 
                              end 
                      end  
                  i_picorv32_mem_top___i_picorv32___cpu_state_ldmem  :
                      begin  
                          i_picorv32_mem_top___i_picorv32___latched_store  <=1;
                          if ( ! i_picorv32_mem_top___i_picorv32___mem_do_prefetch || i_picorv32_mem_top___i_picorv32___mem_done )
                              begin 
                                  if ( ! i_picorv32_mem_top___i_picorv32___mem_do_rdata )
                                      begin (* i_picorv32_mem_top___i_picorv32___parallel_case , i_picorv32_mem_top___i_picorv32___full_case *)
                                          case (1'b1) 
                                           i_picorv32_mem_top___i_picorv32___instr_lb  || i_picorv32_mem_top___i_picorv32___instr_lbu : 
                                               i_picorv32_mem_top___i_picorv32___mem_wordsize  <=2; 
                                           i_picorv32_mem_top___i_picorv32___instr_lh  || i_picorv32_mem_top___i_picorv32___instr_lhu : 
                                               i_picorv32_mem_top___i_picorv32___mem_wordsize  <=1; 
                                           i_picorv32_mem_top___i_picorv32___instr_lw  : 
                                               i_picorv32_mem_top___i_picorv32___mem_wordsize  <=0;
                                          endcase
                                          i_picorv32_mem_top___i_picorv32___latched_is_lu  <= i_picorv32_mem_top___i_picorv32___is_lbu_lhu_lw ; 
                                          i_picorv32_mem_top___i_picorv32___latched_is_lh  <= i_picorv32_mem_top___i_picorv32___instr_lh ; 
                                          i_picorv32_mem_top___i_picorv32___latched_is_lb  <= i_picorv32_mem_top___i_picorv32___instr_lb ;
                                          if ( i_picorv32_mem_top___i_picorv32___ENABLE_TRACE )
                                              begin  
                                                  i_picorv32_mem_top___i_picorv32___trace_valid  <=1; 
                                                  i_picorv32_mem_top___i_picorv32___trace_data  <=(( i_picorv32_mem_top___i_picorv32___irq_active  ?  i_picorv32_mem_top___i_picorv32___TRACE_IRQ :0)| i_picorv32_mem_top___i_picorv32___TRACE_ADDR )|(( i_picorv32_mem_top___i_picorv32___reg_op1 + i_picorv32_mem_top___i_picorv32___decoded_imm )&32'hffffffff);
                                              end  
                                          i_picorv32_mem_top___i_picorv32___reg_op1  <= i_picorv32_mem_top___i_picorv32___reg_op1 + i_picorv32_mem_top___i_picorv32___decoded_imm ; 
                                          i_picorv32_mem_top___i_picorv32___set_mem_do_rdata  =1;
                                      end 
                                  if ( ! i_picorv32_mem_top___i_picorv32___mem_do_prefetch && i_picorv32_mem_top___i_picorv32___mem_done )
                                      begin (* i_picorv32_mem_top___i_picorv32___parallel_case , i_picorv32_mem_top___i_picorv32___full_case *)
                                          case (1'b1) 
                                           i_picorv32_mem_top___i_picorv32___latched_is_lu  : 
                                               i_picorv32_mem_top___i_picorv32___reg_out  <= i_picorv32_mem_top___i_picorv32___mem_rdata_word ; 
                                           i_picorv32_mem_top___i_picorv32___latched_is_lh  : 
                                               i_picorv32_mem_top___i_picorv32___reg_out  <=$signed( i_picorv32_mem_top___i_picorv32___mem_rdata_word [15:0]); 
                                           i_picorv32_mem_top___i_picorv32___latched_is_lb  : 
                                               i_picorv32_mem_top___i_picorv32___reg_out  <=$signed( i_picorv32_mem_top___i_picorv32___mem_rdata_word [7:0]);
                                          endcase
                                          i_picorv32_mem_top___i_picorv32___decoder_trigger  <=1; 
                                          i_picorv32_mem_top___i_picorv32___decoder_pseudo_trigger  <=1; 
                                          i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_fetch ;
                                      end 
                              end 
                      end 
                 endcase
             if ( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ )
                 begin  
                     i_picorv32_mem_top___i_picorv32___next_irq_pending  = i_picorv32_mem_top___i_picorv32___next_irq_pending | i_picorv32_mem_top___i_picorv32___irq ;
                     if ( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ_TIMER && i_picorv32_mem_top___i_picorv32___timer )
                         begin 
                             if (( i_picorv32_mem_top___i_picorv32___timer -1)==0) 
                                 i_picorv32_mem_top___i_picorv32___next_irq_pending  [ i_picorv32_mem_top___i_picorv32___irq_timer ]=1;
                         end 
                 end 
             if (( i_picorv32_mem_top___i_picorv32___CATCH_MISALIGN && i_picorv32_mem_top___i_picorv32___resetn )&&( i_picorv32_mem_top___i_picorv32___mem_do_rdata || i_picorv32_mem_top___i_picorv32___mem_do_wdata ))
                 begin 
                     if (( i_picorv32_mem_top___i_picorv32___mem_wordsize ==0)&&( i_picorv32_mem_top___i_picorv32___reg_op1 [1:0]!=0))
                         begin 
                             if (( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ && ! i_picorv32_mem_top___i_picorv32___irq_mask [ i_picorv32_mem_top___i_picorv32___irq_buserror ])&& ! i_picorv32_mem_top___i_picorv32___irq_active ) 
                                 i_picorv32_mem_top___i_picorv32___next_irq_pending  [ i_picorv32_mem_top___i_picorv32___irq_buserror ]=1;
                              else  
                                 i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_trap ;
                         end 
                     if (( i_picorv32_mem_top___i_picorv32___mem_wordsize ==1)&&( i_picorv32_mem_top___i_picorv32___reg_op1 [0]!=0))
                         begin 
                             if (( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ && ! i_picorv32_mem_top___i_picorv32___irq_mask [ i_picorv32_mem_top___i_picorv32___irq_buserror ])&& ! i_picorv32_mem_top___i_picorv32___irq_active ) 
                                 i_picorv32_mem_top___i_picorv32___next_irq_pending  [ i_picorv32_mem_top___i_picorv32___irq_buserror ]=1;
                              else  
                                 i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_trap ;
                         end 
                 end 
             if ((( i_picorv32_mem_top___i_picorv32___CATCH_MISALIGN && i_picorv32_mem_top___i_picorv32___resetn )&& i_picorv32_mem_top___i_picorv32___mem_do_rinst )&&( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA  ?  i_picorv32_mem_top___i_picorv32___reg_pc [0]: | i_picorv32_mem_top___i_picorv32___reg_pc [1:0]))
                 begin 
                     if (( i_picorv32_mem_top___i_picorv32___ENABLE_IRQ && ! i_picorv32_mem_top___i_picorv32___irq_mask [ i_picorv32_mem_top___i_picorv32___irq_buserror ])&& ! i_picorv32_mem_top___i_picorv32___irq_active ) 
                         i_picorv32_mem_top___i_picorv32___next_irq_pending  [ i_picorv32_mem_top___i_picorv32___irq_buserror ]=1;
                      else  
                         i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_trap ;
                 end 
             if ((( ! i_picorv32_mem_top___i_picorv32___CATCH_ILLINSN && i_picorv32_mem_top___i_picorv32___decoder_trigger_q )&& ! i_picorv32_mem_top___i_picorv32___decoder_pseudo_trigger_q )&& i_picorv32_mem_top___i_picorv32___instr_ecall_ebreak ) 
                 i_picorv32_mem_top___i_picorv32___cpu_state  <= i_picorv32_mem_top___i_picorv32___cpu_state_trap ;
             if ( ! i_picorv32_mem_top___i_picorv32___resetn || i_picorv32_mem_top___i_picorv32___mem_done )
                 begin  
                     i_picorv32_mem_top___i_picorv32___mem_do_prefetch  <=0; 
                     i_picorv32_mem_top___i_picorv32___mem_do_rinst  <=0; 
                     i_picorv32_mem_top___i_picorv32___mem_do_rdata  <=0; 
                     i_picorv32_mem_top___i_picorv32___mem_do_wdata  <=0;
                 end 
             if ( i_picorv32_mem_top___i_picorv32___set_mem_do_rinst ) 
                 i_picorv32_mem_top___i_picorv32___mem_do_rinst  <=1;
             if ( i_picorv32_mem_top___i_picorv32___set_mem_do_rdata ) 
                 i_picorv32_mem_top___i_picorv32___mem_do_rdata  <=1;
             if ( i_picorv32_mem_top___i_picorv32___set_mem_do_wdata ) 
                 i_picorv32_mem_top___i_picorv32___mem_do_wdata  <=1; 
             i_picorv32_mem_top___i_picorv32___irq_pending  <= i_picorv32_mem_top___i_picorv32___next_irq_pending & ~ i_picorv32_mem_top___i_picorv32___MASKED_IRQ ;
             if ( ! i_picorv32_mem_top___i_picorv32___CATCH_MISALIGN )
                 begin 
                     if ( i_picorv32_mem_top___i_picorv32___COMPRESSED_ISA )
                         begin  
                             i_picorv32_mem_top___i_picorv32___reg_pc  [0]<=0; 
                             i_picorv32_mem_top___i_picorv32___reg_next_pc  [0]<=0;
                         end 
                      else 
                         begin  
                             i_picorv32_mem_top___i_picorv32___reg_pc  [1:0]<=0; 
                             i_picorv32_mem_top___i_picorv32___reg_next_pc  [1:0]<=0;
                         end 
                 end  
             i_picorv32_mem_top___i_picorv32___current_pc  ='bx;
         end
 
    
    
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
	// 	.wmask_i({{8 {instr_mem_strb[3]}}, {8 {instr_mem_strb[2]}}, {8 {instr_mem_strb[1]}}, {8 {instr_mem_strb[0]}}}),
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
	// 	.wmask_i({{8 {data_mem_strb[3]}}, {8 {data_mem_strb[2]}}, {8 {data_mem_strb[1]}}, {8 {data_mem_strb[0]}}}),
	// 	.rdata_o(data_mem_rdata)
	// );
	assign data_mem_gnt = 1'sb1;
endmodule