module kronos_tiny_soc #(
    parameter i_kronos_mem_top___i_kronos_core___BOOT_ADDR=32'h80000000,
    parameter i_kronos_mem_top___i_kronos_core___FAST_BRANCH=1,
    parameter i_kronos_mem_top___i_kronos_core___EN_COUNTERS=1,
    parameter i_kronos_mem_top___i_kronos_core___EN_COUNTERS64B=1,
    parameter i_kronos_mem_top___i_kronos_core___CATCH_ILLEGAL_INSTR=1,
    parameter i_kronos_mem_top___i_kronos_core___CATCH_MISALIGNED_JMP=1,
    parameter i_kronos_mem_top___i_kronos_core___CATCH_MISALIGNED_LDST=1,
parameter i_kronos_mem_top___i_kronos_core___u_if___BOOT_ADDR=i_kronos_mem_top___i_kronos_core___BOOT_ADDR,
parameter i_kronos_mem_top___i_kronos_core___u_if___FAST_BRANCH=i_kronos_mem_top___i_kronos_core___FAST_BRANCH,
parameter i_kronos_mem_top___i_kronos_core___u_id___CATCH_ILLEGAL_INSTR=i_kronos_mem_top___i_kronos_core___CATCH_ILLEGAL_INSTR,
parameter i_kronos_mem_top___i_kronos_core___u_id___CATCH_MISALIGNED_JMP=i_kronos_mem_top___i_kronos_core___CATCH_MISALIGNED_JMP,
parameter i_kronos_mem_top___i_kronos_core___u_id___CATCH_MISALIGNED_LDST=i_kronos_mem_top___i_kronos_core___CATCH_MISALIGNED_LDST,
parameter i_kronos_mem_top___i_kronos_core___u_ex___BOOT_ADDR=i_kronos_mem_top___i_kronos_core___BOOT_ADDR,
parameter i_kronos_mem_top___i_kronos_core___u_ex___EN_COUNTERS=i_kronos_mem_top___i_kronos_core___EN_COUNTERS,
parameter i_kronos_mem_top___i_kronos_core___u_ex___EN_COUNTERS64B=i_kronos_mem_top___i_kronos_core___EN_COUNTERS64B,
parameter i_kronos_mem_top___i_kronos_core___u_id___u_agu___CATCH_MISALIGNED_JMP=i_kronos_mem_top___i_kronos_core___u_id___CATCH_MISALIGNED_JMP,
parameter i_kronos_mem_top___i_kronos_core___u_id___u_agu___CATCH_MISALIGNED_LDST=i_kronos_mem_top___i_kronos_core___u_id___CATCH_MISALIGNED_LDST,
parameter i_kronos_mem_top___i_kronos_core___u_ex___u_csr___BOOT_ADDR=i_kronos_mem_top___i_kronos_core___u_ex___BOOT_ADDR,
parameter i_kronos_mem_top___i_kronos_core___u_ex___u_csr___EN_COUNTERS=i_kronos_mem_top___i_kronos_core___u_ex___EN_COUNTERS,
parameter i_kronos_mem_top___i_kronos_core___u_ex___u_csr___EN_COUNTERS64B=i_kronos_mem_top___i_kronos_core___u_ex___EN_COUNTERS64B,
parameter i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___EN_COUNTERS=i_kronos_mem_top___i_kronos_core___u_ex___u_csr___EN_COUNTERS,
parameter i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___EN_COUNTERS64B=i_kronos_mem_top___i_kronos_core___u_ex___u_csr___EN_COUNTERS64B,
parameter i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___EN_COUNTERS=i_kronos_mem_top___i_kronos_core___u_ex___u_csr___EN_COUNTERS,
parameter i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___EN_COUNTERS64B=i_kronos_mem_top___i_kronos_core___u_ex___u_csr___EN_COUNTERS64B) (
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
	
    // INSTANCE: [i_kronos_mem_top]
    wire i_kronos_mem_top___clk_i;
    wire i_kronos_mem_top___rst_ni;
    wire i_kronos_mem_top___data_mem_req;
    wire i_kronos_mem_top___data_mem_gnt;
    wire[19:0] i_kronos_mem_top___data_mem_addr;
    wire[31:0] i_kronos_mem_top___data_mem_wdata;
    wire[31:0] i_kronos_mem_top___data_mem_strb;
    wire i_kronos_mem_top___data_mem_we;
    wire[31:0] i_kronos_mem_top___data_mem_rdata;
    wire i_kronos_mem_top___instr_mem_req;
    wire i_kronos_mem_top___instr_mem_gnt;
    wire[19:0] i_kronos_mem_top___instr_mem_addr;
    wire[31:0] i_kronos_mem_top___instr_mem_wdata;
    wire[31:0] i_kronos_mem_top___instr_mem_strb;
    wire i_kronos_mem_top___instr_mem_we;
    wire[31:0] i_kronos_mem_top___instr_mem_rdata;
    wire i_kronos_mem_top___software_interrupt;
    wire i_kronos_mem_top___timer_interrupt;
    wire i_kronos_mem_top___external_interrupt;
    assign i_kronos_mem_top___clk_i = clk_i;
    assign i_kronos_mem_top___rst_ni = rst_ni;
    assign data_mem_req = i_kronos_mem_top___data_mem_req;
    assign i_kronos_mem_top___data_mem_gnt = data_mem_gnt;
    assign data_mem_addr = i_kronos_mem_top___data_mem_addr;
    assign data_mem_wdata = i_kronos_mem_top___data_mem_wdata;
    assign data_mem_strb = i_kronos_mem_top___data_mem_strb;
    assign data_mem_we = i_kronos_mem_top___data_mem_we;
    assign i_kronos_mem_top___data_mem_rdata = data_mem_rdata;
    assign instr_mem_req = i_kronos_mem_top___instr_mem_req;
    assign i_kronos_mem_top___instr_mem_gnt = instr_mem_gnt;
    assign instr_mem_addr = i_kronos_mem_top___instr_mem_addr;
    assign instr_mem_wdata = i_kronos_mem_top___instr_mem_wdata;
    assign instr_mem_strb = i_kronos_mem_top___instr_mem_strb;
    assign instr_mem_we = i_kronos_mem_top___instr_mem_we;
    assign i_kronos_mem_top___instr_mem_rdata = instr_mem_rdata;
    assign i_kronos_mem_top___software_interrupt = software_interrupt;
    assign i_kronos_mem_top___timer_interrupt = timer_interrupt;
    assign i_kronos_mem_top___external_interrupt = external_interrupt;

    wire[31:0] i_kronos_mem_top___instr_addr ; 
    wire[31:0] i_kronos_mem_top___instr_data ; 
    wire i_kronos_mem_top___instr_req ; 
    wire i_kronos_mem_top___instr_ack ; 
    wire[31:0] i_kronos_mem_top___data_addr ; 
    wire[31:0] i_kronos_mem_top___data_rd_data ; 
    wire[31:0] i_kronos_mem_top___data_wr_data ; 
    wire[3:0] i_kronos_mem_top___data_mask ; 
    wire i_kronos_mem_top___data_wr_en ; 
    wire i_kronos_mem_top___data_req ; 
    wire i_kronos_mem_top___data_ack ; 
    wire i_kronos_mem_top___instr_ack_d ; 
    reg i_kronos_mem_top___instr_ack_q ; 
    wire i_kronos_mem_top___data_ack_d ; 
    reg i_kronos_mem_top___data_ack_q ; 
  assign  i_kronos_mem_top___instr_ack_d = i_kronos_mem_top___instr_mem_req ; 
  assign  i_kronos_mem_top___data_ack_d = i_kronos_mem_top___data_mem_req ; 
  always @(  posedge   i_kronos_mem_top___clk_i          or  negedge  i_kronos_mem_top___rst_ni )
         if ( ~ i_kronos_mem_top___rst_ni )
             begin  
                 i_kronos_mem_top___instr_ack_q  <=1'sb0; 
                 i_kronos_mem_top___data_ack_q  <=1'sb0;
             end 
          else 
             begin  
                 i_kronos_mem_top___instr_ack_q  <= i_kronos_mem_top___instr_ack_d ; 
                 i_kronos_mem_top___data_ack_q  <= i_kronos_mem_top___data_ack_d ;
             end
  assign  i_kronos_mem_top___instr_mem_req = i_kronos_mem_top___instr_req ; 
  assign  i_kronos_mem_top___instr_ack = i_kronos_mem_top___instr_ack_q ; 
  assign  i_kronos_mem_top___instr_mem_addr = i_kronos_mem_top___instr_addr ; 
  assign  i_kronos_mem_top___instr_mem_wdata =1'sb0; 
  assign  i_kronos_mem_top___instr_mem_strb =1'sb0; 
  assign  i_kronos_mem_top___instr_mem_we =1'sb0; 
  assign  i_kronos_mem_top___instr_data = i_kronos_mem_top___instr_mem_rdata ; 
  assign  i_kronos_mem_top___data_mem_req = i_kronos_mem_top___data_req ; 
  assign  i_kronos_mem_top___data_ack = i_kronos_mem_top___data_ack_q ; 
  assign  i_kronos_mem_top___data_mem_addr = i_kronos_mem_top___data_addr ; 
  assign  i_kronos_mem_top___data_mem_wdata = i_kronos_mem_top___data_wr_data ; 
  assign  i_kronos_mem_top___data_mem_strb ={{8{ i_kronos_mem_top___data_mask [3]}},{8{ i_kronos_mem_top___data_mask [2]}},{8{ i_kronos_mem_top___data_mask [1]}},{8{ i_kronos_mem_top___data_mask [0]}}}; 
  assign  i_kronos_mem_top___data_mem_we = i_kronos_mem_top___data_wr_en ; 
  assign  i_kronos_mem_top___data_rd_data = i_kronos_mem_top___data_mem_rdata ;  
    
    // INSTANCE: [i_kronos_mem_top___i_kronos_core]
    wire i_kronos_mem_top___i_kronos_core___clk;
    wire i_kronos_mem_top___i_kronos_core___rstz;
    wire[31:0] i_kronos_mem_top___i_kronos_core___instr_addr;
    wire[31:0] i_kronos_mem_top___i_kronos_core___instr_data;
    wire i_kronos_mem_top___i_kronos_core___instr_req;
    wire i_kronos_mem_top___i_kronos_core___instr_ack;
    wire[31:0] i_kronos_mem_top___i_kronos_core___data_addr;
    wire[31:0] i_kronos_mem_top___i_kronos_core___data_rd_data;
    wire[31:0] i_kronos_mem_top___i_kronos_core___data_wr_data;
    wire[3:0] i_kronos_mem_top___i_kronos_core___data_mask;
    wire i_kronos_mem_top___i_kronos_core___data_wr_en;
    wire i_kronos_mem_top___i_kronos_core___data_req;
    wire i_kronos_mem_top___i_kronos_core___data_ack;
    wire i_kronos_mem_top___i_kronos_core___software_interrupt;
    wire i_kronos_mem_top___i_kronos_core___timer_interrupt;
    wire i_kronos_mem_top___i_kronos_core___external_interrupt;
    assign i_kronos_mem_top___i_kronos_core___clk = i_kronos_mem_top___clk_i;
    assign i_kronos_mem_top___i_kronos_core___rstz = i_kronos_mem_top___rst_ni;
    assign i_kronos_mem_top___instr_addr = i_kronos_mem_top___i_kronos_core___instr_addr;
    assign i_kronos_mem_top___i_kronos_core___instr_data = i_kronos_mem_top___instr_data;
    assign i_kronos_mem_top___instr_req = i_kronos_mem_top___i_kronos_core___instr_req;
    assign i_kronos_mem_top___i_kronos_core___instr_ack = i_kronos_mem_top___instr_ack;
    assign i_kronos_mem_top___data_addr = i_kronos_mem_top___i_kronos_core___data_addr;
    assign i_kronos_mem_top___i_kronos_core___data_rd_data = i_kronos_mem_top___data_rd_data;
    assign i_kronos_mem_top___data_wr_data = i_kronos_mem_top___i_kronos_core___data_wr_data;
    assign i_kronos_mem_top___data_mask = i_kronos_mem_top___i_kronos_core___data_mask;
    assign i_kronos_mem_top___data_wr_en = i_kronos_mem_top___i_kronos_core___data_wr_en;
    assign i_kronos_mem_top___data_req = i_kronos_mem_top___i_kronos_core___data_req;
    assign i_kronos_mem_top___i_kronos_core___data_ack = i_kronos_mem_top___data_ack;
    assign i_kronos_mem_top___i_kronos_core___software_interrupt = i_kronos_mem_top___software_interrupt;
    assign i_kronos_mem_top___i_kronos_core___timer_interrupt = i_kronos_mem_top___timer_interrupt;
    assign i_kronos_mem_top___i_kronos_core___external_interrupt = i_kronos_mem_top___external_interrupt;

    wire[31:0] i_kronos_mem_top___i_kronos_core___immediate ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___regrd_rs1 ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___regrd_rs2 ; 
    wire i_kronos_mem_top___i_kronos_core___regrd_rs1_en ; 
    wire i_kronos_mem_top___i_kronos_core___regrd_rs2_en ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___branch_target ; 
    wire i_kronos_mem_top___i_kronos_core___branch ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___regwr_data ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___regwr_sel ; 
    wire i_kronos_mem_top___i_kronos_core___regwr_en ; 
    wire i_kronos_mem_top___i_kronos_core___flush ; 
    wire[63:0] i_kronos_mem_top___i_kronos_core___fetch ; 
    wire[180:0] i_kronos_mem_top___i_kronos_core___decode ; 
    wire i_kronos_mem_top___i_kronos_core___fetch_vld ; 
    wire i_kronos_mem_top___i_kronos_core___fetch_rdy ; 
    wire i_kronos_mem_top___i_kronos_core___decode_vld ; 
    wire i_kronos_mem_top___i_kronos_core___decode_rdy ; 
    wire i_kronos_mem_top___i_kronos_core___regwr_pending ;  
    
    // INSTANCE: [i_kronos_mem_top___i_kronos_core___u_if]
    wire i_kronos_mem_top___i_kronos_core___u_if___clk;
    wire i_kronos_mem_top___i_kronos_core___u_if___rstz;
    reg[31:0] i_kronos_mem_top___i_kronos_core___u_if___instr_addr;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_if___instr_data;
    wire i_kronos_mem_top___i_kronos_core___u_if___instr_req;
    wire i_kronos_mem_top___i_kronos_core___u_if___instr_ack;
    reg[63:0] i_kronos_mem_top___i_kronos_core___u_if___fetch;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_if___immediate;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_if___regrd_rs1;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_if___regrd_rs2;
    wire i_kronos_mem_top___i_kronos_core___u_if___regrd_rs1_en;
    wire i_kronos_mem_top___i_kronos_core___u_if___regrd_rs2_en;
    reg i_kronos_mem_top___i_kronos_core___u_if___fetch_vld;
    wire i_kronos_mem_top___i_kronos_core___u_if___fetch_rdy;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_if___branch_target;
    wire i_kronos_mem_top___i_kronos_core___u_if___branch;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_if___regwr_data;
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_if___regwr_sel;
    wire i_kronos_mem_top___i_kronos_core___u_if___regwr_en;
    assign i_kronos_mem_top___i_kronos_core___u_if___clk = i_kronos_mem_top___i_kronos_core___clk;
    assign i_kronos_mem_top___i_kronos_core___u_if___rstz = i_kronos_mem_top___i_kronos_core___rstz;
    assign i_kronos_mem_top___i_kronos_core___instr_addr = i_kronos_mem_top___i_kronos_core___u_if___instr_addr;
    assign i_kronos_mem_top___i_kronos_core___u_if___instr_data = i_kronos_mem_top___i_kronos_core___instr_data;
    assign i_kronos_mem_top___i_kronos_core___instr_req = i_kronos_mem_top___i_kronos_core___u_if___instr_req;
    assign i_kronos_mem_top___i_kronos_core___u_if___instr_ack = i_kronos_mem_top___i_kronos_core___instr_ack;
    assign i_kronos_mem_top___i_kronos_core___fetch = i_kronos_mem_top___i_kronos_core___u_if___fetch;
    assign i_kronos_mem_top___i_kronos_core___immediate = i_kronos_mem_top___i_kronos_core___u_if___immediate;
    assign i_kronos_mem_top___i_kronos_core___regrd_rs1 = i_kronos_mem_top___i_kronos_core___u_if___regrd_rs1;
    assign i_kronos_mem_top___i_kronos_core___regrd_rs2 = i_kronos_mem_top___i_kronos_core___u_if___regrd_rs2;
    assign i_kronos_mem_top___i_kronos_core___regrd_rs1_en = i_kronos_mem_top___i_kronos_core___u_if___regrd_rs1_en;
    assign i_kronos_mem_top___i_kronos_core___regrd_rs2_en = i_kronos_mem_top___i_kronos_core___u_if___regrd_rs2_en;
    assign i_kronos_mem_top___i_kronos_core___fetch_vld = i_kronos_mem_top___i_kronos_core___u_if___fetch_vld;
    assign i_kronos_mem_top___i_kronos_core___u_if___fetch_rdy = i_kronos_mem_top___i_kronos_core___fetch_rdy;
    assign i_kronos_mem_top___i_kronos_core___u_if___branch_target = i_kronos_mem_top___i_kronos_core___branch_target;
    assign i_kronos_mem_top___i_kronos_core___u_if___branch = i_kronos_mem_top___i_kronos_core___branch;
    assign i_kronos_mem_top___i_kronos_core___u_if___regwr_data = i_kronos_mem_top___i_kronos_core___regwr_data;
    assign i_kronos_mem_top___i_kronos_core___u_if___regwr_sel = i_kronos_mem_top___i_kronos_core___regwr_sel;
    assign i_kronos_mem_top___i_kronos_core___u_if___regwr_en = i_kronos_mem_top___i_kronos_core___regwr_en;

    reg[31:0] i_kronos_mem_top___i_kronos_core___u_if___pc ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_if___pc_last ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_if___skid_buffer ; 
    wire i_kronos_mem_top___i_kronos_core___u_if___pipe_rdy ; 
    reg i_kronos_mem_top___i_kronos_core___u_if___instr_vld ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_if___next_instr ; reg[1:0] i_kronos_mem_top___i_kronos_core___u_if___state ; reg[1:0] i_kronos_mem_top___i_kronos_core___u_if___next_state ; 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_if___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_if___rstz )
             begin  
                 i_kronos_mem_top___i_kronos_core___u_if___pc  <= i_kronos_mem_top___i_kronos_core___u_if___BOOT_ADDR ; 
                 i_kronos_mem_top___i_kronos_core___u_if___pc_last  <=1'sb0;
             end 
          else 
             if ( i_kronos_mem_top___i_kronos_core___u_if___branch )
                 begin 
                     if ( i_kronos_mem_top___i_kronos_core___u_if___FAST_BRANCH )
                         begin  
                             i_kronos_mem_top___i_kronos_core___u_if___pc  <= i_kronos_mem_top___i_kronos_core___u_if___branch_target +32'h00000004; 
                             i_kronos_mem_top___i_kronos_core___u_if___pc_last  <= i_kronos_mem_top___i_kronos_core___u_if___branch_target ;
                         end 
                      else  
                         i_kronos_mem_top___i_kronos_core___u_if___pc  <= i_kronos_mem_top___i_kronos_core___u_if___branch_target ;
                 end 
              else 
                 if ( i_kronos_mem_top___i_kronos_core___u_if___next_state ==2'd1)
                     begin  
                         i_kronos_mem_top___i_kronos_core___u_if___pc  <= i_kronos_mem_top___i_kronos_core___u_if___pc +32'h00000004; 
                         i_kronos_mem_top___i_kronos_core___u_if___pc_last  <= i_kronos_mem_top___i_kronos_core___u_if___pc ;
                     end
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_if___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_if___rstz ) 
             i_kronos_mem_top___i_kronos_core___u_if___state  <=2'd0;
          else 
             if ( i_kronos_mem_top___i_kronos_core___u_if___branch ) 
                 i_kronos_mem_top___i_kronos_core___u_if___state  <=( i_kronos_mem_top___i_kronos_core___u_if___FAST_BRANCH  ? 2'd1:2'd0);
              else  
                 i_kronos_mem_top___i_kronos_core___u_if___state  <= i_kronos_mem_top___i_kronos_core___u_if___next_state ;
  always @(*)
         begin  
             i_kronos_mem_top___i_kronos_core___u_if___next_state  = i_kronos_mem_top___i_kronos_core___u_if___state ;
             case ( i_kronos_mem_top___i_kronos_core___u_if___state )
              2 'd0: 
                  i_kronos_mem_top___i_kronos_core___u_if___next_state  =2'd1;
              2 'd1:
                  if ( i_kronos_mem_top___i_kronos_core___u_if___instr_ack )
                      begin 
                          if ( i_kronos_mem_top___i_kronos_core___u_if___pipe_rdy ) 
                              i_kronos_mem_top___i_kronos_core___u_if___next_state  =2'd1;
                           else  
                              i_kronos_mem_top___i_kronos_core___u_if___next_state  =2'd3;
                      end 
                   else  
                      i_kronos_mem_top___i_kronos_core___u_if___next_state  =2'd2;
              2 'd2:
                  if ( i_kronos_mem_top___i_kronos_core___u_if___instr_ack )
                      begin 
                          if ( i_kronos_mem_top___i_kronos_core___u_if___pipe_rdy ) 
                              i_kronos_mem_top___i_kronos_core___u_if___next_state  =2'd1;
                           else  
                              i_kronos_mem_top___i_kronos_core___u_if___next_state  =2'd3;
                      end 
              2 'd3:
                  if ( i_kronos_mem_top___i_kronos_core___u_if___fetch_rdy ) 
                      i_kronos_mem_top___i_kronos_core___u_if___next_state  =2'd1;endcase
         end
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_if___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_if___rstz ) 
             i_kronos_mem_top___i_kronos_core___u_if___fetch_vld  <=1'sb0;
          else 
             if ( i_kronos_mem_top___i_kronos_core___u_if___branch ) 
                 i_kronos_mem_top___i_kronos_core___u_if___fetch_vld  <=1'b0;
              else 
                 if ((( i_kronos_mem_top___i_kronos_core___u_if___state ==2'd1)||( i_kronos_mem_top___i_kronos_core___u_if___state ==2'd2))&& i_kronos_mem_top___i_kronos_core___u_if___instr_ack )
                     begin 
                         if ( i_kronos_mem_top___i_kronos_core___u_if___pipe_rdy )
                             begin  
                                 i_kronos_mem_top___i_kronos_core___u_if___fetch  [63-:32]<= i_kronos_mem_top___i_kronos_core___u_if___pc_last ; 
                                 i_kronos_mem_top___i_kronos_core___u_if___fetch  [31-:32]<= i_kronos_mem_top___i_kronos_core___u_if___instr_data ; 
                                 i_kronos_mem_top___i_kronos_core___u_if___fetch_vld  <=1'b1;
                             end 
                          else  
                             i_kronos_mem_top___i_kronos_core___u_if___skid_buffer  <= i_kronos_mem_top___i_kronos_core___u_if___instr_data ;
                     end 
                  else 
                     if (( i_kronos_mem_top___i_kronos_core___u_if___state ==2'd3)&& i_kronos_mem_top___i_kronos_core___u_if___fetch_rdy )
                         begin  
                             i_kronos_mem_top___i_kronos_core___u_if___fetch  [63-:32]<= i_kronos_mem_top___i_kronos_core___u_if___pc_last ; 
                             i_kronos_mem_top___i_kronos_core___u_if___fetch  [31-:32]<= i_kronos_mem_top___i_kronos_core___u_if___skid_buffer ; 
                             i_kronos_mem_top___i_kronos_core___u_if___fetch_vld  <=1'b1;
                         end 
                      else 
                         if ( i_kronos_mem_top___i_kronos_core___u_if___fetch_vld && i_kronos_mem_top___i_kronos_core___u_if___fetch_rdy ) 
                             i_kronos_mem_top___i_kronos_core___u_if___fetch_vld  <=1'b0;
  assign  i_kronos_mem_top___i_kronos_core___u_if___pipe_rdy = ~ i_kronos_mem_top___i_kronos_core___u_if___fetch_vld || i_kronos_mem_top___i_kronos_core___u_if___fetch_rdy ; 
  always @(*)
         if ( i_kronos_mem_top___i_kronos_core___u_if___FAST_BRANCH & i_kronos_mem_top___i_kronos_core___u_if___branch ) 
             i_kronos_mem_top___i_kronos_core___u_if___instr_addr  = i_kronos_mem_top___i_kronos_core___u_if___branch_target ;
          else  
             i_kronos_mem_top___i_kronos_core___u_if___instr_addr  =((( i_kronos_mem_top___i_kronos_core___u_if___state ==2'd1)||( i_kronos_mem_top___i_kronos_core___u_if___state ==2'd2))&& ~ i_kronos_mem_top___i_kronos_core___u_if___instr_ack  ?  i_kronos_mem_top___i_kronos_core___u_if___pc_last : i_kronos_mem_top___i_kronos_core___u_if___pc );
  assign  i_kronos_mem_top___i_kronos_core___u_if___instr_req =1'b1; 
  always @(*)
         if (((( i_kronos_mem_top___i_kronos_core___u_if___state ==2'd1)||( i_kronos_mem_top___i_kronos_core___u_if___state ==2'd2))&& i_kronos_mem_top___i_kronos_core___u_if___instr_ack )&& i_kronos_mem_top___i_kronos_core___u_if___pipe_rdy )
             begin  
                 i_kronos_mem_top___i_kronos_core___u_if___instr_vld  =1'b1; 
                 i_kronos_mem_top___i_kronos_core___u_if___next_instr  = i_kronos_mem_top___i_kronos_core___u_if___instr_data ;
             end 
          else 
             if (( i_kronos_mem_top___i_kronos_core___u_if___state ==2'd3)&& i_kronos_mem_top___i_kronos_core___u_if___fetch_rdy )
                 begin  
                     i_kronos_mem_top___i_kronos_core___u_if___instr_vld  =1'b1; 
                     i_kronos_mem_top___i_kronos_core___u_if___next_instr  = i_kronos_mem_top___i_kronos_core___u_if___skid_buffer ;
                 end 
              else 
                 begin  
                     i_kronos_mem_top___i_kronos_core___u_if___instr_vld  =1'b0; 
                     i_kronos_mem_top___i_kronos_core___u_if___next_instr  = i_kronos_mem_top___i_kronos_core___u_if___instr_data ;
                 end
    
    // INSTANCE: [i_kronos_mem_top___i_kronos_core___u_if___u_rf]
    wire i_kronos_mem_top___i_kronos_core___u_if___u_rf___clk;
    wire i_kronos_mem_top___i_kronos_core___u_if___u_rf___rstz;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___instr_data;
    wire i_kronos_mem_top___i_kronos_core___u_if___u_rf___instr_vld;
    wire i_kronos_mem_top___i_kronos_core___u_if___u_rf___fetch_rdy;
    reg[31:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___immediate;
    reg[31:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs1;
    reg[31:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs2;
    reg i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs1_en;
    reg i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs2_en;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_data;
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_sel;
    wire i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_en;
    assign i_kronos_mem_top___i_kronos_core___u_if___u_rf___clk = i_kronos_mem_top___i_kronos_core___u_if___clk;
    assign i_kronos_mem_top___i_kronos_core___u_if___u_rf___rstz = i_kronos_mem_top___i_kronos_core___u_if___rstz;
    assign i_kronos_mem_top___i_kronos_core___u_if___u_rf___instr_data = i_kronos_mem_top___i_kronos_core___u_if___next_instr;
    assign i_kronos_mem_top___i_kronos_core___u_if___u_rf___instr_vld = i_kronos_mem_top___i_kronos_core___u_if___instr_vld;
    assign i_kronos_mem_top___i_kronos_core___u_if___u_rf___fetch_rdy = i_kronos_mem_top___i_kronos_core___u_if___fetch_rdy;
    assign i_kronos_mem_top___i_kronos_core___u_if___immediate = i_kronos_mem_top___i_kronos_core___u_if___u_rf___immediate;
    assign i_kronos_mem_top___i_kronos_core___u_if___regrd_rs1 = i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs1;
    assign i_kronos_mem_top___i_kronos_core___u_if___regrd_rs2 = i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs2;
    assign i_kronos_mem_top___i_kronos_core___u_if___regrd_rs1_en = i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs1_en;
    assign i_kronos_mem_top___i_kronos_core___u_if___regrd_rs2_en = i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs2_en;
    assign i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_data = i_kronos_mem_top___i_kronos_core___u_if___regwr_data;
    assign i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_sel = i_kronos_mem_top___i_kronos_core___u_if___regwr_sel;
    assign i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_en = i_kronos_mem_top___i_kronos_core___u_if___regwr_en;

    reg i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_vld ; 
    wire i_kronos_mem_top___i_kronos_core___u_if___u_rf___instr_rdy ; reg[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_rs1 ; reg[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_rs2 ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___rs1 ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___rs2 ; 
    wire[2:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___funct3 ; 
    reg i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmA ; reg[3:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmB ; reg[5:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmC ; 
    reg i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmD ; reg[7:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmE ; reg[11:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmF ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___Imm ; 
    wire i_kronos_mem_top___i_kronos_core___u_if___u_rf___sign ; 
    reg i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_I ; 
    reg i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_J ; 
    reg i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_S ; 
    reg i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_B ; 
    reg i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_U ; 
    wire i_kronos_mem_top___i_kronos_core___u_if___u_rf___csr_regrd ; 
    wire i_kronos_mem_top___i_kronos_core___u_if___u_rf___is_regrd_rs1_en ; 
    wire i_kronos_mem_top___i_kronos_core___u_if___u_rf___is_regrd_rs2_en ; 
  assign  i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR = i_kronos_mem_top___i_kronos_core___u_if___u_rf___instr_data ; 
  assign  i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [6:2]; 
  assign  i_kronos_mem_top___i_kronos_core___u_if___u_rf___rs1 = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [19:15]; 
  assign  i_kronos_mem_top___i_kronos_core___u_if___u_rf___rs2 = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [24:20]; 
  assign  i_kronos_mem_top___i_kronos_core___u_if___u_rf___funct3 = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [14:12]; 
  assign  i_kronos_mem_top___i_kronos_core___u_if___u_rf___sign = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [31]; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_AUIPC =5'b00101; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_BR =5'b11000; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_JAL =5'b11011; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_JALR =5'b11001; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_LOAD =5'b00000; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_LUI =5'b01101; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_OPIMM =5'b00100; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_STORE =5'b01000; 
  always @(*)
         begin  
             i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_I  =(( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_OPIMM )||( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_JALR ))||( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_LOAD ); 
             i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_J  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_JAL ; 
             i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_S  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_STORE ; 
             i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_B  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_BR ; 
             i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_U  =( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_LUI )||( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_AUIPC );
             if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_I ) 
                 i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmA  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [20];
              else 
                 if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_S ) 
                     i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmA  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [7];
                  else  
                     i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmA  =1'b0;
             if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_U ) 
                 i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmB  =4'b0000;
              else 
                 if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_I || i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_J ) 
                     i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmB  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [24:21];
                  else  
                     i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmB  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [11:8];
             if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_U ) 
                 i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmC  =6'b000000;
              else  
                 i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmC  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [30:25];
             if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_U ) 
                 i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmD  =1'b0;
              else 
                 if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_B ) 
                     i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmD  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [7];
                  else 
                     if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_J ) 
                         i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmD  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [20];
                      else  
                         i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmD  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___sign ;
             if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_U || i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_J ) 
                 i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmE  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [19:12];
              else  
                 i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmE  ={8{ i_kronos_mem_top___i_kronos_core___u_if___u_rf___sign }};
             if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___format_U ) 
                 i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmF  = i_kronos_mem_top___i_kronos_core___u_if___u_rf___IR [31:20];
              else  
                 i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmF  ={12{ i_kronos_mem_top___i_kronos_core___u_if___u_rf___sign }};
         end
  assign  i_kronos_mem_top___i_kronos_core___u_if___u_rf___Imm ={ i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmF , i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmE , i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmD , i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmC , i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmB , i_kronos_mem_top___i_kronos_core___u_if___u_rf___ImmA }; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_SYS =5'b11100; 
  assign  i_kronos_mem_top___i_kronos_core___u_if___u_rf___csr_regrd =( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_SYS )&&((( i_kronos_mem_top___i_kronos_core___u_if___u_rf___funct3 ==3'b001)||( i_kronos_mem_top___i_kronos_core___u_if___u_rf___funct3 ==3'b010))||( i_kronos_mem_top___i_kronos_core___u_if___u_rf___funct3 ==3'b011)); localparam[4:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_OP =5'b01100; 
  assign  i_kronos_mem_top___i_kronos_core___u_if___u_rf___is_regrd_rs1_en =(((((( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_OPIMM )||( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_OP ))||( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_JALR ))||( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_BR ))||( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_LOAD ))||( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_STORE ))|| i_kronos_mem_top___i_kronos_core___u_if___u_rf___csr_regrd ; 
  assign  i_kronos_mem_top___i_kronos_core___u_if___u_rf___is_regrd_rs2_en =(( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_OP )||( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_BR ))||( i_kronos_mem_top___i_kronos_core___u_if___u_rf___OP == i_kronos_mem_top___i_kronos_core___u_if___u_rf___kronos_types_INSTR_STORE ); reg[31:0] i_kronos_mem_top___i_kronos_core___u_if___u_rf___REG [0:31]; 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_if___u_rf___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_if___u_rf___rstz ) 
             i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_vld  <=1'b0;
          else 
             if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___instr_vld && i_kronos_mem_top___i_kronos_core___u_if___u_rf___instr_rdy )
                 begin  
                     i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_vld  <=1'b1; 
                     i_kronos_mem_top___i_kronos_core___u_if___u_rf___immediate  <= i_kronos_mem_top___i_kronos_core___u_if___u_rf___Imm ;
                     if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___rs1 ==0) 
                         i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs1  <=1'sb0;
                      else 
                         if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_en &&( i_kronos_mem_top___i_kronos_core___u_if___u_rf___rs1 == i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_sel )) 
                             i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs1  <= i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_data ;
                          else  
                             i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs1  <= i_kronos_mem_top___i_kronos_core___u_if___u_rf___REG [ i_kronos_mem_top___i_kronos_core___u_if___u_rf___rs1 ];
                     if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___rs2 ==0) 
                         i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs2  <=1'sb0;
                      else 
                         if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_en &&( i_kronos_mem_top___i_kronos_core___u_if___u_rf___rs2 == i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_sel )) 
                             i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs2  <= i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_data ;
                          else  
                             i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs2  <= i_kronos_mem_top___i_kronos_core___u_if___u_rf___REG [ i_kronos_mem_top___i_kronos_core___u_if___u_rf___rs2 ]; 
                     i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs1_en  <= i_kronos_mem_top___i_kronos_core___u_if___u_rf___is_regrd_rs1_en ; 
                     i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs2_en  <= i_kronos_mem_top___i_kronos_core___u_if___u_rf___is_regrd_rs2_en ; 
                     i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_rs1  <= i_kronos_mem_top___i_kronos_core___u_if___u_rf___rs1 ; 
                     i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_rs2  <= i_kronos_mem_top___i_kronos_core___u_if___u_rf___rs2 ;
                 end 
              else 
                 if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_vld && i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_en )
                     begin 
                         if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_rs1 == i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_sel ) 
                             i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs1  <= i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_data ;
                         if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_rs2 == i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_sel ) 
                             i_kronos_mem_top___i_kronos_core___u_if___u_rf___regrd_rs2  <= i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_data ;
                     end 
                  else 
                     if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_vld && i_kronos_mem_top___i_kronos_core___u_if___u_rf___fetch_rdy ) 
                         i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_vld  <=1'b0;
  assign  i_kronos_mem_top___i_kronos_core___u_if___u_rf___instr_rdy = ~ i_kronos_mem_top___i_kronos_core___u_if___u_rf___reg_vld | i_kronos_mem_top___i_kronos_core___u_if___u_rf___fetch_rdy ; 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_if___u_rf___clk )
         if ( i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_en ) 
             i_kronos_mem_top___i_kronos_core___u_if___u_rf___REG  [ i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_sel ]<= i_kronos_mem_top___i_kronos_core___u_if___u_rf___regwr_data ;

    

    // INSTANCE: [i_kronos_mem_top___i_kronos_core___u_id]
    wire i_kronos_mem_top___i_kronos_core___u_id___clk;
    wire i_kronos_mem_top___i_kronos_core___u_id___rstz;
    wire i_kronos_mem_top___i_kronos_core___u_id___flush;
    wire[63:0] i_kronos_mem_top___i_kronos_core___u_id___fetch;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___immediate;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___regrd_rs1;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___regrd_rs2;
    wire i_kronos_mem_top___i_kronos_core___u_id___regrd_rs1_en;
    wire i_kronos_mem_top___i_kronos_core___u_id___regrd_rs2_en;
    wire i_kronos_mem_top___i_kronos_core___u_id___fetch_vld;
    wire i_kronos_mem_top___i_kronos_core___u_id___fetch_rdy;
    reg[180:0] i_kronos_mem_top___i_kronos_core___u_id___decode;
    reg i_kronos_mem_top___i_kronos_core___u_id___decode_vld;
    wire i_kronos_mem_top___i_kronos_core___u_id___decode_rdy;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___regwr_data;
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_id___regwr_sel;
    wire i_kronos_mem_top___i_kronos_core___u_id___regwr_en;
    wire i_kronos_mem_top___i_kronos_core___u_id___regwr_pending;
    assign i_kronos_mem_top___i_kronos_core___u_id___clk = i_kronos_mem_top___i_kronos_core___clk;
    assign i_kronos_mem_top___i_kronos_core___u_id___rstz = i_kronos_mem_top___i_kronos_core___rstz;
    assign i_kronos_mem_top___i_kronos_core___u_id___flush = i_kronos_mem_top___i_kronos_core___flush;
    assign i_kronos_mem_top___i_kronos_core___u_id___fetch = i_kronos_mem_top___i_kronos_core___fetch;
    assign i_kronos_mem_top___i_kronos_core___u_id___immediate = i_kronos_mem_top___i_kronos_core___immediate;
    assign i_kronos_mem_top___i_kronos_core___u_id___regrd_rs1 = i_kronos_mem_top___i_kronos_core___regrd_rs1;
    assign i_kronos_mem_top___i_kronos_core___u_id___regrd_rs2 = i_kronos_mem_top___i_kronos_core___regrd_rs2;
    assign i_kronos_mem_top___i_kronos_core___u_id___regrd_rs1_en = i_kronos_mem_top___i_kronos_core___regrd_rs1_en;
    assign i_kronos_mem_top___i_kronos_core___u_id___regrd_rs2_en = i_kronos_mem_top___i_kronos_core___regrd_rs2_en;
    assign i_kronos_mem_top___i_kronos_core___u_id___fetch_vld = i_kronos_mem_top___i_kronos_core___fetch_vld;
    assign i_kronos_mem_top___i_kronos_core___fetch_rdy = i_kronos_mem_top___i_kronos_core___u_id___fetch_rdy;
    assign i_kronos_mem_top___i_kronos_core___decode = i_kronos_mem_top___i_kronos_core___u_id___decode;
    assign i_kronos_mem_top___i_kronos_core___decode_vld = i_kronos_mem_top___i_kronos_core___u_id___decode_vld;
    assign i_kronos_mem_top___i_kronos_core___u_id___decode_rdy = i_kronos_mem_top___i_kronos_core___decode_rdy;
    assign i_kronos_mem_top___i_kronos_core___u_id___regwr_data = i_kronos_mem_top___i_kronos_core___regwr_data;
    assign i_kronos_mem_top___i_kronos_core___u_id___regwr_sel = i_kronos_mem_top___i_kronos_core___regwr_sel;
    assign i_kronos_mem_top___i_kronos_core___u_id___regwr_en = i_kronos_mem_top___i_kronos_core___regwr_en;
    assign i_kronos_mem_top___i_kronos_core___u_id___regwr_pending = i_kronos_mem_top___i_kronos_core___regwr_pending;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___IR ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___PC ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_id___OP ; 
    wire[6:0] i_kronos_mem_top___i_kronos_core___u_id___opcode ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_id___rs1 ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_id___rs2 ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_id___rd ; 
    wire[2:0] i_kronos_mem_top___i_kronos_core___u_id___funct3 ; 
    wire[6:0] i_kronos_mem_top___i_kronos_core___u_id___funct7 ; 
    wire[1:0] i_kronos_mem_top___i_kronos_core___u_id___data_size ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_id___op1 ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_id___op2 ; reg[3:0] i_kronos_mem_top___i_kronos_core___u_id___aluop ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___regwr_alu ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___branch ; 
    reg i_kronos_mem_top___i_kronos_core___u_id___csr ; reg[1:0] i_kronos_mem_top___i_kronos_core___u_id___sysop ; 
    reg i_kronos_mem_top___i_kronos_core___u_id___is_fencei ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___illegal ; 
    reg i_kronos_mem_top___i_kronos_core___u_id___instr_valid ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___illegal_opcode ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___addr ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_id___base ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_id___offset ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___misaligned_jmp ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___misaligned_ldst ; reg[3:0] i_kronos_mem_top___i_kronos_core___u_id___mask ; reg[1:0] i_kronos_mem_top___i_kronos_core___u_id___byte_addr ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_id___sdata ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_id___store_data ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___rs1_forward ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___rs2_forward ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___rs1_data ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___rs2_data ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___stall ; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___IR = i_kronos_mem_top___i_kronos_core___u_id___fetch [31-:32]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___PC = i_kronos_mem_top___i_kronos_core___u_id___fetch [63-:32]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___opcode = i_kronos_mem_top___i_kronos_core___u_id___IR [6:0]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___OP = i_kronos_mem_top___i_kronos_core___u_id___opcode [6:2]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___rs1 = i_kronos_mem_top___i_kronos_core___u_id___IR [19:15]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___rs2 = i_kronos_mem_top___i_kronos_core___u_id___IR [24:20]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___rd = i_kronos_mem_top___i_kronos_core___u_id___IR [11:7]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___funct3 = i_kronos_mem_top___i_kronos_core___u_id___IR [14:12]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___funct7 = i_kronos_mem_top___i_kronos_core___u_id___IR [31:25]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___data_size = i_kronos_mem_top___i_kronos_core___u_id___funct3 [1:0]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___illegal_opcode = i_kronos_mem_top___i_kronos_core___u_id___opcode [1:0]!=2'b11; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_AUIPC =5'b00101; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_JAL =5'b11011; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_JALR =5'b11001; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_LUI =5'b01101; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_OP =5'b01100; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_OPIMM =5'b00100; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___regwr_alu =( i_kronos_mem_top___i_kronos_core___u_id___rd !={5{1'sb0}})&&(((((( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_LUI )||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_AUIPC ))||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_JAL ))||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_JALR ))||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_OPIMM ))||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_OP )); 
  assign  i_kronos_mem_top___i_kronos_core___u_id___rs1_forward = i_kronos_mem_top___i_kronos_core___u_id___regwr_en &( i_kronos_mem_top___i_kronos_core___u_id___regwr_sel == i_kronos_mem_top___i_kronos_core___u_id___rs1 ); 
  assign  i_kronos_mem_top___i_kronos_core___u_id___rs2_forward = i_kronos_mem_top___i_kronos_core___u_id___regwr_en &( i_kronos_mem_top___i_kronos_core___u_id___regwr_sel == i_kronos_mem_top___i_kronos_core___u_id___rs2 ); 
  assign  i_kronos_mem_top___i_kronos_core___u_id___rs1_data =( i_kronos_mem_top___i_kronos_core___u_id___rs1_forward  ?  i_kronos_mem_top___i_kronos_core___u_id___regwr_data : i_kronos_mem_top___i_kronos_core___u_id___regrd_rs1 ); 
  assign  i_kronos_mem_top___i_kronos_core___u_id___rs2_data =( i_kronos_mem_top___i_kronos_core___u_id___rs2_forward  ?  i_kronos_mem_top___i_kronos_core___u_id___regwr_data : i_kronos_mem_top___i_kronos_core___u_id___regrd_rs2 ); localparam[3:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_ADD =4'b0000; localparam[2:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BEQ =3'b000; localparam[2:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BGE =3'b101; localparam[2:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BGEU =3'b111; localparam[2:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BLT =3'b100; localparam[2:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BLTU =3'b110; localparam[2:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BNE =3'b001; localparam[1:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BYTE =2'b00; localparam[1:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_EBREAK =2'b01; localparam[1:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_ECALL =2'b00; localparam[31:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_FOUR =32'h00000004; localparam[1:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_HALF =2'b01; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_BR =5'b11000; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_LOAD =5'b00000; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_MISC =5'b00011; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_STORE =5'b01000; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_SYS =5'b11100; localparam[1:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_MRET =2'b10; localparam[1:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_WFI =2'b11; localparam[31:0] i_kronos_mem_top___i_kronos_core___u_id___kronos_types_ZERO =32'h00000000; 
  always @(*)
         begin  
             i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b0; 
             i_kronos_mem_top___i_kronos_core___u_id___is_fencei  =1'b0; 
             i_kronos_mem_top___i_kronos_core___u_id___sysop  =2'b00; 
             i_kronos_mem_top___i_kronos_core___u_id___csr  =1'b0; 
             i_kronos_mem_top___i_kronos_core___u_id___aluop  = i_kronos_mem_top___i_kronos_core___u_id___kronos_types_ADD ; 
             i_kronos_mem_top___i_kronos_core___u_id___op1  = i_kronos_mem_top___i_kronos_core___u_id___PC ; 
             i_kronos_mem_top___i_kronos_core___u_id___op2  = i_kronos_mem_top___i_kronos_core___u_id___kronos_types_FOUR ; 
             i_kronos_mem_top___i_kronos_core___u_id___base  = i_kronos_mem_top___i_kronos_core___u_id___PC ; 
             i_kronos_mem_top___i_kronos_core___u_id___offset  = i_kronos_mem_top___i_kronos_core___u_id___kronos_types_FOUR ; 
             i_kronos_mem_top___i_kronos_core___u_id___byte_addr  = i_kronos_mem_top___i_kronos_core___u_id___addr [1:0]; 
             i_kronos_mem_top___i_kronos_core___u_id___sdata  = i_kronos_mem_top___i_kronos_core___u_id___rs2_data ;
             case ( i_kronos_mem_top___i_kronos_core___u_id___byte_addr )
              2 'b00: 
                  i_kronos_mem_top___i_kronos_core___u_id___store_data  = i_kronos_mem_top___i_kronos_core___u_id___sdata ;
              2 'b01: 
                  i_kronos_mem_top___i_kronos_core___u_id___store_data  ={ i_kronos_mem_top___i_kronos_core___u_id___sdata [0+:24], i_kronos_mem_top___i_kronos_core___u_id___sdata [24+:8]};
              2 'b10: 
                  i_kronos_mem_top___i_kronos_core___u_id___store_data  ={ i_kronos_mem_top___i_kronos_core___u_id___sdata [0+:16], i_kronos_mem_top___i_kronos_core___u_id___sdata [16+:16]};
              2 'b11: 
                  i_kronos_mem_top___i_kronos_core___u_id___store_data  ={ i_kronos_mem_top___i_kronos_core___u_id___sdata [0+:8], i_kronos_mem_top___i_kronos_core___u_id___sdata [8+:24]};endcase
             if ( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_STORE )
                 begin 
                     if ( i_kronos_mem_top___i_kronos_core___u_id___data_size == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BYTE ) 
                         i_kronos_mem_top___i_kronos_core___u_id___mask  =4'h1<< i_kronos_mem_top___i_kronos_core___u_id___byte_addr ;
                      else 
                         if ( i_kronos_mem_top___i_kronos_core___u_id___data_size == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_HALF ) 
                             i_kronos_mem_top___i_kronos_core___u_id___mask  =( i_kronos_mem_top___i_kronos_core___u_id___byte_addr [1] ? 4'hc:4'h3);
                          else  
                             i_kronos_mem_top___i_kronos_core___u_id___mask  =4'hf;
                 end 
              else  
                 i_kronos_mem_top___i_kronos_core___u_id___mask  =4'hf;
             case ( i_kronos_mem_top___i_kronos_core___u_id___OP ) 
              i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_LUI  :
                  begin  
                      i_kronos_mem_top___i_kronos_core___u_id___op1  = i_kronos_mem_top___i_kronos_core___u_id___kronos_types_ZERO ; 
                      i_kronos_mem_top___i_kronos_core___u_id___op2  = i_kronos_mem_top___i_kronos_core___u_id___immediate ; 
                      i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                  end  
              i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_AUIPC  :
                  begin  
                      i_kronos_mem_top___i_kronos_core___u_id___op2  = i_kronos_mem_top___i_kronos_core___u_id___immediate ; 
                      i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                  end  
              i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_JAL  :
                  begin  
                      i_kronos_mem_top___i_kronos_core___u_id___op2  = i_kronos_mem_top___i_kronos_core___u_id___kronos_types_FOUR ; 
                      i_kronos_mem_top___i_kronos_core___u_id___offset  = i_kronos_mem_top___i_kronos_core___u_id___immediate ; 
                      i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                  end  
              i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_JALR  :
                  begin  
                      i_kronos_mem_top___i_kronos_core___u_id___op2  = i_kronos_mem_top___i_kronos_core___u_id___kronos_types_FOUR ; 
                      i_kronos_mem_top___i_kronos_core___u_id___base  = i_kronos_mem_top___i_kronos_core___u_id___rs1_data ; 
                      i_kronos_mem_top___i_kronos_core___u_id___offset  = i_kronos_mem_top___i_kronos_core___u_id___immediate ; 
                      i_kronos_mem_top___i_kronos_core___u_id___instr_valid  = i_kronos_mem_top___i_kronos_core___u_id___funct3 ==3'b000;
                  end  
              i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_BR  :
                  begin  
                      i_kronos_mem_top___i_kronos_core___u_id___offset  = i_kronos_mem_top___i_kronos_core___u_id___immediate ;
                      case ( i_kronos_mem_top___i_kronos_core___u_id___funct3 ) 
                       i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BEQ  , i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BNE , i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BLT , i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BGE , i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BLTU , i_kronos_mem_top___i_kronos_core___u_id___kronos_types_BGEU : 
                           i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;endcase
                  end  
              i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_LOAD  :
                  begin  
                      i_kronos_mem_top___i_kronos_core___u_id___base  = i_kronos_mem_top___i_kronos_core___u_id___rs1_data ; 
                      i_kronos_mem_top___i_kronos_core___u_id___offset  = i_kronos_mem_top___i_kronos_core___u_id___immediate ;
                      case ( i_kronos_mem_top___i_kronos_core___u_id___funct3 )
                       3 'b000,3'b001,3'b010,3'b100,3'b101: 
                           i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;endcase
                  end  
              i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_STORE  :
                  begin  
                      i_kronos_mem_top___i_kronos_core___u_id___op2  = i_kronos_mem_top___i_kronos_core___u_id___store_data ; 
                      i_kronos_mem_top___i_kronos_core___u_id___base  = i_kronos_mem_top___i_kronos_core___u_id___rs1_data ; 
                      i_kronos_mem_top___i_kronos_core___u_id___offset  = i_kronos_mem_top___i_kronos_core___u_id___immediate ;
                      case ( i_kronos_mem_top___i_kronos_core___u_id___funct3 )
                       3 'b000,3'b001,3'b010: 
                           i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;endcase
                  end  
              i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_OPIMM  :
                  begin 
                      if (( i_kronos_mem_top___i_kronos_core___u_id___funct3 ==3'b001)||( i_kronos_mem_top___i_kronos_core___u_id___funct3 ==3'b101)) 
                          i_kronos_mem_top___i_kronos_core___u_id___aluop  ={ i_kronos_mem_top___i_kronos_core___u_id___funct7 [5], i_kronos_mem_top___i_kronos_core___u_id___funct3 };
                       else  
                          i_kronos_mem_top___i_kronos_core___u_id___aluop  ={1'b0, i_kronos_mem_top___i_kronos_core___u_id___funct3 }; 
                      i_kronos_mem_top___i_kronos_core___u_id___op1  = i_kronos_mem_top___i_kronos_core___u_id___rs1_data ; 
                      i_kronos_mem_top___i_kronos_core___u_id___op2  = i_kronos_mem_top___i_kronos_core___u_id___immediate ;
                      case ( i_kronos_mem_top___i_kronos_core___u_id___funct3 )
                       3 'b000,3'b010,3'b011,3'b100,3'b110,3'b111: 
                           i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                       3 'b001:
                           if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd0) 
                               i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                       3 'b101:
                           if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd0) 
                               i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                            else 
                               if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd32) 
                                   i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;endcase
                  end  
              i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_OP  :
                  begin  
                      i_kronos_mem_top___i_kronos_core___u_id___aluop  ={ i_kronos_mem_top___i_kronos_core___u_id___funct7 [5], i_kronos_mem_top___i_kronos_core___u_id___funct3 }; 
                      i_kronos_mem_top___i_kronos_core___u_id___op1  = i_kronos_mem_top___i_kronos_core___u_id___rs1_data ; 
                      i_kronos_mem_top___i_kronos_core___u_id___op2  = i_kronos_mem_top___i_kronos_core___u_id___rs2_data ;
                      case ( i_kronos_mem_top___i_kronos_core___u_id___funct3 )
                       3 'b000:
                           if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd0) 
                               i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                            else 
                               if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd32) 
                                   i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                       3 'b001:
                           if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd0) 
                               i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                       3 'b010:
                           if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd0) 
                               i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                       3 'b011:
                           if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd0) 
                               i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                       3 'b100:
                           if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd0) 
                               i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                       3 'b101:
                           if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd0) 
                               i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                            else 
                               if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd32) 
                                   i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                       3 'b110:
                           if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd0) 
                               i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                       3 'b111:
                           if ( i_kronos_mem_top___i_kronos_core___u_id___funct7 ==7'd0) 
                               i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;endcase
                  end  
              i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_MISC  :
                  case ( i_kronos_mem_top___i_kronos_core___u_id___funct3 )
                   3 'b000:
                       if ((( i_kronos_mem_top___i_kronos_core___u_id___funct7 [6:3]=={4{1'sb0}})&&( i_kronos_mem_top___i_kronos_core___u_id___rs1 =={5{1'sb0}}))&&( i_kronos_mem_top___i_kronos_core___u_id___rd =={5{1'sb0}})) 
                           i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                   3 'b001:
                       if ((( i_kronos_mem_top___i_kronos_core___u_id___IR [31:20]==12'b000000000000)&&( i_kronos_mem_top___i_kronos_core___u_id___rs1 =={5{1'sb0}}))&&( i_kronos_mem_top___i_kronos_core___u_id___rd =={5{1'sb0}}))
                           begin  
                               i_kronos_mem_top___i_kronos_core___u_id___is_fencei  =1'b1; 
                               i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                           end endcase 
              i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_SYS  :
                  case ( i_kronos_mem_top___i_kronos_core___u_id___funct3 )
                   3 'b000:
                       if (( i_kronos_mem_top___i_kronos_core___u_id___rs1 =={5{1'sb0}})&&( i_kronos_mem_top___i_kronos_core___u_id___rd =={5{1'sb0}}))
                           begin 
                               if ( i_kronos_mem_top___i_kronos_core___u_id___IR [31:20]==12'h000)
                                   begin  
                                       i_kronos_mem_top___i_kronos_core___u_id___sysop  = i_kronos_mem_top___i_kronos_core___u_id___kronos_types_ECALL ; 
                                       i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                                   end 
                                else 
                                   if ( i_kronos_mem_top___i_kronos_core___u_id___IR [31:20]==12'h001)
                                       begin  
                                           i_kronos_mem_top___i_kronos_core___u_id___sysop  = i_kronos_mem_top___i_kronos_core___u_id___kronos_types_EBREAK ; 
                                           i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                                       end 
                                    else 
                                       if ( i_kronos_mem_top___i_kronos_core___u_id___IR [31:20]==12'h302)
                                           begin  
                                               i_kronos_mem_top___i_kronos_core___u_id___sysop  = i_kronos_mem_top___i_kronos_core___u_id___kronos_types_MRET ; 
                                               i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                                           end 
                                        else 
                                           if ( i_kronos_mem_top___i_kronos_core___u_id___IR [31:20]==12'h105)
                                               begin  
                                                   i_kronos_mem_top___i_kronos_core___u_id___sysop  = i_kronos_mem_top___i_kronos_core___u_id___kronos_types_WFI ; 
                                                   i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                                               end 
                           end 
                   3 'b001,3'b010,3'b011:
                       begin  
                           i_kronos_mem_top___i_kronos_core___u_id___op1  = i_kronos_mem_top___i_kronos_core___u_id___rs1_data ; 
                           i_kronos_mem_top___i_kronos_core___u_id___csr  =1'b1; 
                           i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                       end 
                   3 'b101,3'b110,3'b111:
                       begin  
                           i_kronos_mem_top___i_kronos_core___u_id___csr  =1'b1; 
                           i_kronos_mem_top___i_kronos_core___u_id___instr_valid  =1'b1;
                       end endcase
              default :;endcase
         end
  assign  i_kronos_mem_top___i_kronos_core___u_id___illegal =( i_kronos_mem_top___i_kronos_core___u_id___CATCH_ILLEGAL_INSTR  ?  ~ i_kronos_mem_top___i_kronos_core___u_id___instr_valid | i_kronos_mem_top___i_kronos_core___u_id___illegal_opcode :1'b0);  
    

    // INSTANCE: [i_kronos_mem_top___i_kronos_core___u_id___u_agu]
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___instr;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___base;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___offset;
    reg[31:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___addr;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_agu___misaligned_jmp;
    reg i_kronos_mem_top___i_kronos_core___u_id___u_agu___misaligned_ldst;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_agu___instr = i_kronos_mem_top___i_kronos_core___u_id___IR;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_agu___base = i_kronos_mem_top___i_kronos_core___u_id___base;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_agu___offset = i_kronos_mem_top___i_kronos_core___u_id___offset;
    assign i_kronos_mem_top___i_kronos_core___u_id___addr = i_kronos_mem_top___i_kronos_core___u_id___u_agu___addr;
    assign i_kronos_mem_top___i_kronos_core___u_id___misaligned_jmp = i_kronos_mem_top___i_kronos_core___u_id___u_agu___misaligned_jmp;
    assign i_kronos_mem_top___i_kronos_core___u_id___misaligned_ldst = i_kronos_mem_top___i_kronos_core___u_id___u_agu___misaligned_ldst;
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___OP ; 
    wire[1:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___data_size ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___u_agu___align ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___addr_raw ; 
    wire[1:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___byte_addr ; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_agu___OP = i_kronos_mem_top___i_kronos_core___u_id___u_agu___instr [6:2]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_agu___data_size = i_kronos_mem_top___i_kronos_core___u_id___u_agu___instr [13:12]; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_INSTR_JALR =5'b11001; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_agu___align = i_kronos_mem_top___i_kronos_core___u_id___u_agu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_INSTR_JALR ; 
  always @(*)
         begin  
             i_kronos_mem_top___i_kronos_core___u_id___u_agu___addr_raw  = i_kronos_mem_top___i_kronos_core___u_id___u_agu___base + i_kronos_mem_top___i_kronos_core___u_id___u_agu___offset ; 
             i_kronos_mem_top___i_kronos_core___u_id___u_agu___addr  [31:1]= i_kronos_mem_top___i_kronos_core___u_id___u_agu___addr_raw [31:1]; 
             i_kronos_mem_top___i_kronos_core___u_id___u_agu___addr  [0]= ~ i_kronos_mem_top___i_kronos_core___u_id___u_agu___align & i_kronos_mem_top___i_kronos_core___u_id___u_agu___addr_raw [0];
         end
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_agu___byte_addr = i_kronos_mem_top___i_kronos_core___u_id___u_agu___addr [1:0]; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_INSTR_BR =5'b11000; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_INSTR_JAL =5'b11011; 
  generate
    if( i_kronos_mem_top___i_kronos_core___u_id___u_agu___CATCH_MISALIGNED_JMP )begin: i_kronos_mem_top___i_kronos_core___u_id___u_agu___genblk1 
       assign  i_kronos_mem_top___i_kronos_core___u_id___u_agu___misaligned_jmp =((( i_kronos_mem_top___i_kronos_core___u_id___u_agu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_INSTR_JAL )||( i_kronos_mem_top___i_kronos_core___u_id___u_agu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_INSTR_JALR ))||( i_kronos_mem_top___i_kronos_core___u_id___u_agu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_INSTR_BR ))&&( i_kronos_mem_top___i_kronos_core___u_id___u_agu___byte_addr !=2'b00);end
     else begin: i_kronos_mem_top___i_kronos_core___u_id___u_agu___genblk1 
       assign  i_kronos_mem_top___i_kronos_core___u_id___u_agu___misaligned_jmp =1'b0;end
       endgenerate 

       localparam[1:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_HALF =2'b01; 
       localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_INSTR_LOAD =5'b00000; 
       localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_INSTR_STORE =5'b01000; 
       localparam[1:0] i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_WORD =2'b10; 
       generate
        if( i_kronos_mem_top___i_kronos_core___u_id___u_agu___CATCH_MISALIGNED_LDST )
        begin: i_kronos_mem_top___i_kronos_core___u_id___u_agu___genblk2 
       always @(*)
              if (( i_kronos_mem_top___i_kronos_core___u_id___u_agu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_INSTR_LOAD )||( i_kronos_mem_top___i_kronos_core___u_id___u_agu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_INSTR_STORE ))
                  begin 
                      if (( i_kronos_mem_top___i_kronos_core___u_id___u_agu___data_size == i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_WORD )&&( i_kronos_mem_top___i_kronos_core___u_id___u_agu___byte_addr !=2'b00)) 
                          i_kronos_mem_top___i_kronos_core___u_id___u_agu___misaligned_ldst  =1'b1;
                       else 
                          if (( i_kronos_mem_top___i_kronos_core___u_id___u_agu___data_size == i_kronos_mem_top___i_kronos_core___u_id___u_agu___kronos_types_HALF )&&( i_kronos_mem_top___i_kronos_core___u_id___u_agu___byte_addr [0]!=1'b0)) 
                              i_kronos_mem_top___i_kronos_core___u_id___u_agu___misaligned_ldst  =1'b1;
                           else  
                              i_kronos_mem_top___i_kronos_core___u_id___u_agu___misaligned_ldst  =1'b0;
                  end 
               else  
                  i_kronos_mem_top___i_kronos_core___u_id___u_agu___misaligned_ldst  =1'b0;
end
     else 
     begin: i_kronos_mem_top___i_kronos_core___u_id___u_agu___genblk2 
       wire[1:1] i_kronos_mem_top___i_kronos_core___u_id___u_agu___sv2v_tmp_6C1DA ;
       assign  i_kronos_mem_top___i_kronos_core___u_id___u_agu___sv2v_tmp_6C1DA =1'b0;
       always @(*) 
              i_kronos_mem_top___i_kronos_core___u_id___u_agu___misaligned_ldst  = i_kronos_mem_top___i_kronos_core___u_id___u_agu___sv2v_tmp_6C1DA ;
end
endgenerate

    // INSTANCE: [i_kronos_mem_top___i_kronos_core___u_id___u_branch]
    wire[2:0] i_kronos_mem_top___i_kronos_core___u_id___u_branch___op;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___u_branch___rs1;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___u_branch___rs2;
    reg i_kronos_mem_top___i_kronos_core___u_id___u_branch___branch;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_branch___op = i_kronos_mem_top___i_kronos_core___u_id___funct3;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_branch___rs1 = i_kronos_mem_top___i_kronos_core___u_id___rs1_data;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_branch___rs2 = i_kronos_mem_top___i_kronos_core___u_id___rs2_data;
    assign i_kronos_mem_top___i_kronos_core___u_id___branch = i_kronos_mem_top___i_kronos_core___u_id___u_branch___branch;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_branch___uns ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___u_branch___eq ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___u_branch___lt ; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_branch___uns = i_kronos_mem_top___i_kronos_core___u_id___u_branch___op [1]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_branch___eq = i_kronos_mem_top___i_kronos_core___u_id___u_branch___rs1 == i_kronos_mem_top___i_kronos_core___u_id___u_branch___rs2 ; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_branch___lt =( i_kronos_mem_top___i_kronos_core___u_id___u_branch___uns  ?  i_kronos_mem_top___i_kronos_core___u_id___u_branch___rs1 < i_kronos_mem_top___i_kronos_core___u_id___u_branch___rs2 :$signed( i_kronos_mem_top___i_kronos_core___u_id___u_branch___rs1 )<$signed( i_kronos_mem_top___i_kronos_core___u_id___u_branch___rs2 )); localparam[2:0] i_kronos_mem_top___i_kronos_core___u_id___u_branch___kronos_types_BEQ =3'b000; localparam[2:0] i_kronos_mem_top___i_kronos_core___u_id___u_branch___kronos_types_BGE =3'b101; localparam[2:0] i_kronos_mem_top___i_kronos_core___u_id___u_branch___kronos_types_BGEU =3'b111; localparam[2:0] i_kronos_mem_top___i_kronos_core___u_id___u_branch___kronos_types_BNE =3'b001; 
  always @(*)
         case ( i_kronos_mem_top___i_kronos_core___u_id___u_branch___op ) 
          i_kronos_mem_top___i_kronos_core___u_id___u_branch___kronos_types_BEQ  : 
              i_kronos_mem_top___i_kronos_core___u_id___u_branch___branch  = i_kronos_mem_top___i_kronos_core___u_id___u_branch___eq ; 
          i_kronos_mem_top___i_kronos_core___u_id___u_branch___kronos_types_BNE  : 
              i_kronos_mem_top___i_kronos_core___u_id___u_branch___branch  = ~ i_kronos_mem_top___i_kronos_core___u_id___u_branch___eq ; 
          i_kronos_mem_top___i_kronos_core___u_id___u_branch___kronos_types_BGE  , i_kronos_mem_top___i_kronos_core___u_id___u_branch___kronos_types_BGEU : 
              i_kronos_mem_top___i_kronos_core___u_id___u_branch___branch  = ~ i_kronos_mem_top___i_kronos_core___u_id___u_branch___lt ;
          default : 
              i_kronos_mem_top___i_kronos_core___u_id___u_branch___branch  = i_kronos_mem_top___i_kronos_core___u_id___u_branch___lt ;endcase


    // INSTANCE: [i_kronos_mem_top___i_kronos_core___u_id___u_hcu]
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___clk;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rstz;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___flush;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___instr;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regrd_rs1_en;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regrd_rs2_en;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___fetch_vld;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___fetch_rdy;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___decode_vld;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___decode_rdy;
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regwr_sel;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regwr_en;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regwr_pending;
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___stall;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___clk = i_kronos_mem_top___i_kronos_core___u_id___clk;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rstz = i_kronos_mem_top___i_kronos_core___u_id___rstz;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___flush = i_kronos_mem_top___i_kronos_core___u_id___flush;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___instr = i_kronos_mem_top___i_kronos_core___u_id___IR;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regrd_rs1_en = i_kronos_mem_top___i_kronos_core___u_id___regrd_rs1_en;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regrd_rs2_en = i_kronos_mem_top___i_kronos_core___u_id___regrd_rs2_en;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___fetch_vld = i_kronos_mem_top___i_kronos_core___u_id___fetch_vld;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___fetch_rdy = i_kronos_mem_top___i_kronos_core___u_id___fetch_rdy;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___decode_vld = i_kronos_mem_top___i_kronos_core___u_id___decode_vld;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___decode_rdy = i_kronos_mem_top___i_kronos_core___u_id___decode_rdy;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regwr_sel = i_kronos_mem_top___i_kronos_core___u_id___regwr_sel;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regwr_en = i_kronos_mem_top___i_kronos_core___u_id___regwr_en;
    assign i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regwr_pending = i_kronos_mem_top___i_kronos_core___u_id___regwr_pending;
    assign i_kronos_mem_top___i_kronos_core___u_id___stall = i_kronos_mem_top___i_kronos_core___u_id___u_hcu___stall;
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___OP ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rs1 ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rs2 ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rd ; 
    wire[2:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___funct3 ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___is_reg_write ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___csr_regwr ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rs1_hazard ; 
    wire i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rs2_hazard ; reg[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rpend ; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_hcu___OP = i_kronos_mem_top___i_kronos_core___u_id___u_hcu___instr [6:2]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rs1 = i_kronos_mem_top___i_kronos_core___u_id___u_hcu___instr [19:15]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rs2 = i_kronos_mem_top___i_kronos_core___u_id___u_hcu___instr [24:20]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rd = i_kronos_mem_top___i_kronos_core___u_id___u_hcu___instr [11:7]; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_hcu___funct3 = i_kronos_mem_top___i_kronos_core___u_id___u_hcu___instr [14:12]; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_AUIPC =5'b00101; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_JAL =5'b11011; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_JALR =5'b11001; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_LOAD =5'b00000; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_LUI =5'b01101; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_OP =5'b01100; localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_OPIMM =5'b00100; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_hcu___is_reg_write =( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rd !={5{1'sb0}})&&(((((((( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_LUI )||( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_AUIPC ))||( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_JAL ))||( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_JALR ))||( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_OPIMM ))||( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_OP ))||( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_LOAD ))|| i_kronos_mem_top___i_kronos_core___u_id___u_hcu___csr_regwr ); localparam[4:0] i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_SYS =5'b11100; 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_hcu___csr_regwr =( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___OP == i_kronos_mem_top___i_kronos_core___u_id___u_hcu___kronos_types_INSTR_SYS )&&(((((( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___funct3 ==3'b001)||( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___funct3 ==3'b010))||( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___funct3 ==3'b011))||( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___funct3 ==3'b101))||( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___funct3 ==3'b110))||( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___funct3 ==3'b111)); 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rs1_hazard =( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regrd_rs1_en & i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regwr_pending )&( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rpend == i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rs1 ); 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rs2_hazard =( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regrd_rs2_en & i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regwr_pending )&( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rpend == i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rs2 ); 
  assign  i_kronos_mem_top___i_kronos_core___u_id___u_hcu___stall =( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rs1_hazard | i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rs2_hazard )& ~( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___regwr_en & ~( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___decode_vld && i_kronos_mem_top___i_kronos_core___u_id___u_hcu___decode_rdy )); 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_id___u_hcu___clk )
         if ( i_kronos_mem_top___i_kronos_core___u_id___u_hcu___fetch_vld && i_kronos_mem_top___i_kronos_core___u_id___u_hcu___fetch_rdy ) 
             i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rpend  <= i_kronos_mem_top___i_kronos_core___u_id___u_hcu___rd ;

     
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_id___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_id___rstz ) 
             i_kronos_mem_top___i_kronos_core___u_id___decode_vld  <=1'b0;
          else 
             if ( i_kronos_mem_top___i_kronos_core___u_id___flush ) 
                 i_kronos_mem_top___i_kronos_core___u_id___decode_vld  <=1'b0;
              else 
                 if ( i_kronos_mem_top___i_kronos_core___u_id___fetch_vld && i_kronos_mem_top___i_kronos_core___u_id___fetch_rdy )
                     begin  
                         i_kronos_mem_top___i_kronos_core___u_id___decode_vld  <=1'b1; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [180-:32]<= i_kronos_mem_top___i_kronos_core___u_id___PC ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [148-:32]<= i_kronos_mem_top___i_kronos_core___u_id___IR ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [20]<=((((((( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_LUI )||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_AUIPC ))||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_OPIMM ))||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_OP ))||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_BR ))||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_JAL ))||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_JALR ))||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_MISC ); 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [19-:4]<= i_kronos_mem_top___i_kronos_core___u_id___aluop ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [15]<= i_kronos_mem_top___i_kronos_core___u_id___regwr_alu ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [116-:32]<= i_kronos_mem_top___i_kronos_core___u_id___op1 ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [84-:32]<= i_kronos_mem_top___i_kronos_core___u_id___op2 ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [52-:32]<= i_kronos_mem_top___i_kronos_core___u_id___addr ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [14]<=(( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_JAL )||( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_JALR ))|| i_kronos_mem_top___i_kronos_core___u_id___is_fencei ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [13]<= i_kronos_mem_top___i_kronos_core___u_id___branch &&( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_BR ); 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [12]<= i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_LOAD ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [11]<= i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_STORE ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [10-:4]<= i_kronos_mem_top___i_kronos_core___u_id___mask ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [6]<= i_kronos_mem_top___i_kronos_core___u_id___csr ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [5]<=( i_kronos_mem_top___i_kronos_core___u_id___OP == i_kronos_mem_top___i_kronos_core___u_id___kronos_types_INSTR_SYS )&& ~ i_kronos_mem_top___i_kronos_core___u_id___csr ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [4-:2]<= i_kronos_mem_top___i_kronos_core___u_id___sysop ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [2]<= i_kronos_mem_top___i_kronos_core___u_id___illegal ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [1]<= i_kronos_mem_top___i_kronos_core___u_id___misaligned_jmp ; 
                         i_kronos_mem_top___i_kronos_core___u_id___decode  [0]<= i_kronos_mem_top___i_kronos_core___u_id___misaligned_ldst ;
                     end 
                  else 
                     if ( i_kronos_mem_top___i_kronos_core___u_id___decode_vld && i_kronos_mem_top___i_kronos_core___u_id___decode_rdy ) 
                         i_kronos_mem_top___i_kronos_core___u_id___decode_vld  <=1'b0;
  assign  i_kronos_mem_top___i_kronos_core___u_id___fetch_rdy =( ~ i_kronos_mem_top___i_kronos_core___u_id___decode_vld | i_kronos_mem_top___i_kronos_core___u_id___decode_rdy )& ~ i_kronos_mem_top___i_kronos_core___u_id___stall ;

    // INSTANCE: [i_kronos_mem_top___i_kronos_core___u_ex]
    wire i_kronos_mem_top___i_kronos_core___u_ex___clk;
    wire i_kronos_mem_top___i_kronos_core___u_ex___rstz;
    wire[180:0] i_kronos_mem_top___i_kronos_core___u_ex___decode;
    wire i_kronos_mem_top___i_kronos_core___u_ex___decode_vld;
    wire i_kronos_mem_top___i_kronos_core___u_ex___decode_rdy;
    reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___regwr_data;
    reg[4:0] i_kronos_mem_top___i_kronos_core___u_ex___regwr_sel;
    reg i_kronos_mem_top___i_kronos_core___u_ex___regwr_en;
    wire i_kronos_mem_top___i_kronos_core___u_ex___regwr_pending;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___branch_target;
    wire i_kronos_mem_top___i_kronos_core___u_ex___branch;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___data_addr;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___data_rd_data;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___data_wr_data;
    wire[3:0] i_kronos_mem_top___i_kronos_core___u_ex___data_mask;
    wire i_kronos_mem_top___i_kronos_core___u_ex___data_wr_en;
    wire i_kronos_mem_top___i_kronos_core___u_ex___data_req;
    wire i_kronos_mem_top___i_kronos_core___u_ex___data_ack;
    wire i_kronos_mem_top___i_kronos_core___u_ex___software_interrupt;
    wire i_kronos_mem_top___i_kronos_core___u_ex___timer_interrupt;
    wire i_kronos_mem_top___i_kronos_core___u_ex___external_interrupt;
    assign i_kronos_mem_top___i_kronos_core___u_ex___clk = i_kronos_mem_top___i_kronos_core___clk;
    assign i_kronos_mem_top___i_kronos_core___u_ex___rstz = i_kronos_mem_top___i_kronos_core___rstz;
    assign i_kronos_mem_top___i_kronos_core___u_ex___decode = i_kronos_mem_top___i_kronos_core___decode;
    assign i_kronos_mem_top___i_kronos_core___u_ex___decode_vld = i_kronos_mem_top___i_kronos_core___decode_vld;
    assign i_kronos_mem_top___i_kronos_core___decode_rdy = i_kronos_mem_top___i_kronos_core___u_ex___decode_rdy;
    assign i_kronos_mem_top___i_kronos_core___regwr_data = i_kronos_mem_top___i_kronos_core___u_ex___regwr_data;
    assign i_kronos_mem_top___i_kronos_core___regwr_sel = i_kronos_mem_top___i_kronos_core___u_ex___regwr_sel;
    assign i_kronos_mem_top___i_kronos_core___regwr_en = i_kronos_mem_top___i_kronos_core___u_ex___regwr_en;
    assign i_kronos_mem_top___i_kronos_core___regwr_pending = i_kronos_mem_top___i_kronos_core___u_ex___regwr_pending;
    assign i_kronos_mem_top___i_kronos_core___branch_target = i_kronos_mem_top___i_kronos_core___u_ex___branch_target;
    assign i_kronos_mem_top___i_kronos_core___branch = i_kronos_mem_top___i_kronos_core___u_ex___branch;
    assign i_kronos_mem_top___i_kronos_core___data_addr = i_kronos_mem_top___i_kronos_core___u_ex___data_addr;
    assign i_kronos_mem_top___i_kronos_core___u_ex___data_rd_data = i_kronos_mem_top___i_kronos_core___data_rd_data;
    assign i_kronos_mem_top___i_kronos_core___data_wr_data = i_kronos_mem_top___i_kronos_core___u_ex___data_wr_data;
    assign i_kronos_mem_top___i_kronos_core___data_mask = i_kronos_mem_top___i_kronos_core___u_ex___data_mask;
    assign i_kronos_mem_top___i_kronos_core___data_wr_en = i_kronos_mem_top___i_kronos_core___u_ex___data_wr_en;
    assign i_kronos_mem_top___i_kronos_core___data_req = i_kronos_mem_top___i_kronos_core___u_ex___data_req;
    assign i_kronos_mem_top___i_kronos_core___u_ex___data_ack = i_kronos_mem_top___i_kronos_core___data_ack;
    assign i_kronos_mem_top___i_kronos_core___u_ex___software_interrupt = i_kronos_mem_top___i_kronos_core___software_interrupt;
    assign i_kronos_mem_top___i_kronos_core___u_ex___timer_interrupt = i_kronos_mem_top___i_kronos_core___timer_interrupt;
    assign i_kronos_mem_top___i_kronos_core___u_ex___external_interrupt = i_kronos_mem_top___i_kronos_core___external_interrupt;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___result ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_ex___rd ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___instr_vld ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___instr_jump ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___basic_rdy ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___lsu_vld ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___lsu_rdy ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___load_data ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___regwr_lsu ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___csr_vld ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___csr_rdy ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___csr_data ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___regwr_csr ; 
    reg i_kronos_mem_top___i_kronos_core___u_ex___instret ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___core_interrupt ; 
    wire[3:0] i_kronos_mem_top___i_kronos_core___u_ex___core_interrupt_cause ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___exception ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___activate_trap ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___return_trap ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___trap_cause ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___trap_handle ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___trap_value ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___trap_jump ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___regwr_pending_firstcycle ; 
    reg i_kronos_mem_top___i_kronos_core___u_ex___regwr_pending_later ; reg[2:0] i_kronos_mem_top___i_kronos_core___u_ex___state ; reg[2:0] i_kronos_mem_top___i_kronos_core___u_ex___next_state ; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___rd = i_kronos_mem_top___i_kronos_core___u_ex___decode [128:124]; 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_ex___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_ex___rstz ) 
             i_kronos_mem_top___i_kronos_core___u_ex___state  <=3'd0;
          else  
             i_kronos_mem_top___i_kronos_core___u_ex___state  <= i_kronos_mem_top___i_kronos_core___u_ex___next_state ;
 localparam[1:0] i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_EBREAK =2'b01; localparam[1:0] i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_ECALL =2'b00; localparam[1:0] i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_MRET =2'b10; localparam[1:0] i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_WFI =2'b11; 
  always @(*)
         begin  
             i_kronos_mem_top___i_kronos_core___u_ex___next_state  = i_kronos_mem_top___i_kronos_core___u_ex___state ;
             case ( i_kronos_mem_top___i_kronos_core___u_ex___state )
              3 'd0:
                  if ( i_kronos_mem_top___i_kronos_core___u_ex___decode_vld )
                      begin 
                          if ( i_kronos_mem_top___i_kronos_core___u_ex___core_interrupt ) 
                              i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd3;
                           else 
                              if ( i_kronos_mem_top___i_kronos_core___u_ex___exception ) 
                                  i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd3;
                               else 
                                  if ( i_kronos_mem_top___i_kronos_core___u_ex___decode [5])
                                      case ( i_kronos_mem_top___i_kronos_core___u_ex___decode [4-:2]) 
                                       i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_ECALL  , i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_EBREAK : 
                                           i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd3; 
                                       i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_MRET  : 
                                           i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd4; 
                                       i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_WFI  : 
                                           i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd5;endcase
                                   else 
                                      if ( i_kronos_mem_top___i_kronos_core___u_ex___decode [12]|| i_kronos_mem_top___i_kronos_core___u_ex___decode [11]) 
                                          i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd1;
                                       else 
                                          if ( i_kronos_mem_top___i_kronos_core___u_ex___decode [6]) 
                                              i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd2;
                      end 
              3 'd1:
                  if ( i_kronos_mem_top___i_kronos_core___u_ex___lsu_rdy ) 
                      i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd0;
              3 'd2:
                  if ( i_kronos_mem_top___i_kronos_core___u_ex___csr_rdy ) 
                      i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd0;
              3 'd5:
                  if ( i_kronos_mem_top___i_kronos_core___u_ex___core_interrupt ) 
                      i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd3;
              3 'd3: 
                  i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd6;
              3 'd4: 
                  i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd6;
              3 'd6:
                  if ( i_kronos_mem_top___i_kronos_core___u_ex___trap_jump ) 
                      i_kronos_mem_top___i_kronos_core___u_ex___next_state  =3'd0;endcase
         end
  assign  i_kronos_mem_top___i_kronos_core___u_ex___instr_vld =(( i_kronos_mem_top___i_kronos_core___u_ex___decode_vld &&( i_kronos_mem_top___i_kronos_core___u_ex___state ==3'd0))&& ~ i_kronos_mem_top___i_kronos_core___u_ex___exception )&& ~ i_kronos_mem_top___i_kronos_core___u_ex___core_interrupt ; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___basic_rdy = i_kronos_mem_top___i_kronos_core___u_ex___instr_vld && i_kronos_mem_top___i_kronos_core___u_ex___decode [20]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___decode_rdy = |{ i_kronos_mem_top___i_kronos_core___u_ex___basic_rdy , i_kronos_mem_top___i_kronos_core___u_ex___lsu_rdy , i_kronos_mem_top___i_kronos_core___u_ex___csr_rdy };  
    

    // INSTANCE: [i_kronos_mem_top___i_kronos_core___u_ex___u_alu]
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op1;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op2;
    wire[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___aluop;
    reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___result;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op1 = i_kronos_mem_top___i_kronos_core___u_ex___decode[116-:32];
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op2 = i_kronos_mem_top___i_kronos_core___u_ex___decode[84-:32];
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_alu___aluop = i_kronos_mem_top___i_kronos_core___u_ex___decode[19-:4];
    assign i_kronos_mem_top___i_kronos_core___u_ex___result = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___result;
    function automatic[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___reverse_bits ;input reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___value ;reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___reversed_value ;
        integer i_kronos_mem_top___i_kronos_core___u_ex___u_alu___i ;
          begin for( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___i =0; i_kronos_mem_top___i_kronos_core___u_ex___u_alu___i <32; i_kronos_mem_top___i_kronos_core___u_ex___u_alu___i = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___i +1) 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___reversed_value  [ i_kronos_mem_top___i_kronos_core___u_ex___u_alu___i ]= i_kronos_mem_top___i_kronos_core___u_ex___u_alu___value [31- i_kronos_mem_top___i_kronos_core___u_ex___u_alu___i ]; 
              i_kronos_mem_top___i_kronos_core___u_ex___u_alu___reverse_bits  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___reversed_value ;
          end endfunction 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_alu___cin ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_alu___rev ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_alu___uns ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_adder ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_and ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_or ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_xor ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_shift ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___adder_A ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___adder_B ; 
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_alu___cout ; 
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_alu___A_sign ; 
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_alu___B_sign ; 
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_alu___R_sign ; 
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_lt ; 
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_ltu ; 
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_comp ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___data ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shamt ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shift_in ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p0 ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p1 ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p2 ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p3 ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p4 ; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___cin = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___aluop [3]|| i_kronos_mem_top___i_kronos_core___u_ex___u_alu___aluop [1]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___rev = ~ i_kronos_mem_top___i_kronos_core___u_ex___u_alu___aluop [2]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___uns = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___aluop [0]; 
  always @(*)
         begin  
             i_kronos_mem_top___i_kronos_core___u_ex___u_alu___adder_A  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op1 ; 
             i_kronos_mem_top___i_kronos_core___u_ex___u_alu___adder_B  =( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___cin  ?  ~ i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op2 : i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op2 );
             {  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___cout , i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_adder }=({1'b0, i_kronos_mem_top___i_kronos_core___u_ex___u_alu___adder_A }+{1'b0, i_kronos_mem_top___i_kronos_core___u_ex___u_alu___adder_B })+ i_kronos_mem_top___i_kronos_core___u_ex___u_alu___cin ;
         end
  always @(*)
         begin  
             i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_and  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op1 & i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op2 ; 
             i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_or  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op1 | i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op2 ; 
             i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_xor  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op1 ^ i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op2 ;
         end
  always @(*)
         begin  
             i_kronos_mem_top___i_kronos_core___u_ex___u_alu___A_sign  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op1 [31]; 
             i_kronos_mem_top___i_kronos_core___u_ex___u_alu___B_sign  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op2 [31]; 
             i_kronos_mem_top___i_kronos_core___u_ex___u_alu___R_sign  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_adder [31];
             case ({ i_kronos_mem_top___i_kronos_core___u_ex___u_alu___A_sign , i_kronos_mem_top___i_kronos_core___u_ex___u_alu___B_sign })
              2 'b00: 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_lt  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___R_sign ;
              2 'b01: 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_lt  =1'b0;
              2 'b10: 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_lt  =1'b1;
              2 'b11: 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_lt  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___R_sign ;endcase 
             i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_ltu  = ~ i_kronos_mem_top___i_kronos_core___u_ex___u_alu___cout ; 
             i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_comp  =( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___uns  ?  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_ltu : i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_lt );
         end
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___data =( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___rev  ?  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___reverse_bits ( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op1 ): i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op1 ); 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shift_in = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___cin & i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op1 [31]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shamt = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___op2 [4:0]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p0 =( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shamt [0] ? { i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shift_in , i_kronos_mem_top___i_kronos_core___u_ex___u_alu___data [31:1]}: i_kronos_mem_top___i_kronos_core___u_ex___u_alu___data ); 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p1 =( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shamt [1] ? {{2{ i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shift_in }}, i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p0 [31:2]}: i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p0 ); 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p2 =( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shamt [2] ? {{4{ i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shift_in }}, i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p1 [31:4]}: i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p1 ); 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p3 =( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shamt [3] ? {{8{ i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shift_in }}, i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p2 [31:8]}: i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p2 ); 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p4 =( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shamt [4] ? {{16{ i_kronos_mem_top___i_kronos_core___u_ex___u_alu___shift_in }}, i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p3 [31:16]}: i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p3 ); 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_shift =( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___rev  ?  i_kronos_mem_top___i_kronos_core___u_ex___u_alu___reverse_bits ( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p4 ): i_kronos_mem_top___i_kronos_core___u_ex___u_alu___p4 ); localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_AND =4'b0111; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_OR =4'b0110; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_SLL =4'b0001; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_SLT =4'b0010; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_SLTU =4'b0011; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_SRA =4'b1101; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_SRL =4'b0101; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_XOR =4'b0100; 
  always @(*)
         case ( i_kronos_mem_top___i_kronos_core___u_ex___u_alu___aluop ) 
          i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_SLT  , i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_SLTU : 
              i_kronos_mem_top___i_kronos_core___u_ex___u_alu___result  ={31'b0000000000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_comp }; 
          i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_XOR  : 
              i_kronos_mem_top___i_kronos_core___u_ex___u_alu___result  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_xor ; 
          i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_OR  : 
              i_kronos_mem_top___i_kronos_core___u_ex___u_alu___result  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_or ; 
          i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_AND  : 
              i_kronos_mem_top___i_kronos_core___u_ex___u_alu___result  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_and ; 
          i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_SLL  , i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_SRL , i_kronos_mem_top___i_kronos_core___u_ex___u_alu___kronos_types_SRA : 
              i_kronos_mem_top___i_kronos_core___u_ex___u_alu___result  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_shift ;
          default : 
              i_kronos_mem_top___i_kronos_core___u_ex___u_alu___result  = i_kronos_mem_top___i_kronos_core___u_ex___u_alu___r_adder ;endcase

     
  assign  i_kronos_mem_top___i_kronos_core___u_ex___lsu_vld = i_kronos_mem_top___i_kronos_core___u_ex___instr_vld ||( i_kronos_mem_top___i_kronos_core___u_ex___state ==3'd1);  
    

    // INSTANCE: [i_kronos_mem_top___i_kronos_core___u_ex___u_lsu]
    wire[180:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___lsu_vld;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___lsu_rdy;
    reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___load_data;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___regwr_lsu;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_addr;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_rd_data;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_wr_data;
    wire[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_mask;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_wr_en;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_req;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_ack;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode = i_kronos_mem_top___i_kronos_core___u_ex___decode;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___lsu_vld = i_kronos_mem_top___i_kronos_core___u_ex___lsu_vld;
    assign i_kronos_mem_top___i_kronos_core___u_ex___lsu_rdy = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___lsu_rdy;
    assign i_kronos_mem_top___i_kronos_core___u_ex___load_data = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___load_data;
    assign i_kronos_mem_top___i_kronos_core___u_ex___regwr_lsu = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___regwr_lsu;
    assign i_kronos_mem_top___i_kronos_core___u_ex___data_addr = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_addr;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_rd_data = i_kronos_mem_top___i_kronos_core___u_ex___data_rd_data;
    assign i_kronos_mem_top___i_kronos_core___u_ex___data_wr_data = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_wr_data;
    assign i_kronos_mem_top___i_kronos_core___u_ex___data_mask = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_mask;
    assign i_kronos_mem_top___i_kronos_core___u_ex___data_wr_en = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_wr_en;
    assign i_kronos_mem_top___i_kronos_core___u_ex___data_req = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_req;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_ack = i_kronos_mem_top___i_kronos_core___u_ex___data_ack;
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___rd ; 
    wire[1:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___byte_addr ; 
    wire[1:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_size ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___load_uns ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___ldata ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___word_data ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___half_data ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___byte_data ; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___byte_addr = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode [22:21]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_size = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode [130:129]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___load_uns = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode [131]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___rd = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode [128:124]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_addr ={ i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode [52:23],2'b00}; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_wr_data = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode [84-:32]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_mask = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode [10-:4]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_wr_en =( i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___lsu_vld && i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode [11])&& ~ i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_ack ; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_req =( i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___lsu_vld &&( i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode [12]| i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode [11]))&& ~ i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_ack ; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___lsu_rdy = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_ack ; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___regwr_lsu = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___decode [12]&&( i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___rd !={5{1'sb0}}); 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___ldata = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_rd_data ; 
  always @(*)
         case ( i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___byte_addr )
          2 'b00: 
              i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___word_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___ldata ;
          2 'b01: 
              i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___word_data  ={ i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___ldata [0+:8], i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___ldata [8+:24]};
          2 'b10: 
              i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___word_data  ={ i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___ldata [0+:16], i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___ldata [16+:16]};
          2 'b11: 
              i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___word_data  ={ i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___ldata [0+:24], i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___ldata [24+:8]};endcase
  always @(*)
         begin 
             if ( i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___load_uns ) 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___byte_data  ={24'b000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___word_data [7:0]};
              else  
                 i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___byte_data  ={{24{ i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___word_data [7]}}, i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___word_data [7:0]};
             if ( i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___load_uns ) 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___half_data  ={16'b0000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___word_data [15:0]};
              else  
                 i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___half_data  ={{16{ i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___word_data [15]}}, i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___word_data [15:0]};
         end
  localparam[1:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___kronos_types_BYTE =2'b00; localparam[1:0] i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___kronos_types_HALF =2'b01; 
  always @(*)
         if ( i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_size == i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___kronos_types_BYTE ) 
             i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___load_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___byte_data ;
          else 
             if ( i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___data_size == i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___kronos_types_HALF ) 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___load_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___half_data ;
              else  
                 i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___load_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_lsu___word_data ;

     
  assign  i_kronos_mem_top___i_kronos_core___u_ex___regwr_pending_firstcycle =( i_kronos_mem_top___i_kronos_core___u_ex___decode_vld && i_kronos_mem_top___i_kronos_core___u_ex___decode_rdy )&(( i_kronos_mem_top___i_kronos_core___u_ex___decode [15]| i_kronos_mem_top___i_kronos_core___u_ex___regwr_lsu )| i_kronos_mem_top___i_kronos_core___u_ex___regwr_csr ); 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___regwr_pending = i_kronos_mem_top___i_kronos_core___u_ex___regwr_pending_firstcycle |( ~( i_kronos_mem_top___i_kronos_core___u_ex___decode_vld && i_kronos_mem_top___i_kronos_core___u_ex___decode_rdy )&& i_kronos_mem_top___i_kronos_core___u_ex___regwr_pending_later ); 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_ex___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_ex___rstz )
             begin  
                 i_kronos_mem_top___i_kronos_core___u_ex___regwr_en  <=1'b0; 
                 i_kronos_mem_top___i_kronos_core___u_ex___regwr_pending_later  <=1'b0;
             end 
          else 
             begin  
                 i_kronos_mem_top___i_kronos_core___u_ex___regwr_sel  <= i_kronos_mem_top___i_kronos_core___u_ex___rd ;
                 if ( i_kronos_mem_top___i_kronos_core___u_ex___decode_vld && i_kronos_mem_top___i_kronos_core___u_ex___decode_rdy ) 
                     i_kronos_mem_top___i_kronos_core___u_ex___regwr_pending_later  <=( i_kronos_mem_top___i_kronos_core___u_ex___regwr_lsu && ~ i_kronos_mem_top___i_kronos_core___u_ex___lsu_rdy )|( i_kronos_mem_top___i_kronos_core___u_ex___regwr_csr && ~ i_kronos_mem_top___i_kronos_core___u_ex___csr_rdy );
                 if ( i_kronos_mem_top___i_kronos_core___u_ex___instr_vld && i_kronos_mem_top___i_kronos_core___u_ex___decode [15])
                     begin  
                         i_kronos_mem_top___i_kronos_core___u_ex___regwr_en  <=1'b1; 
                         i_kronos_mem_top___i_kronos_core___u_ex___regwr_data  <= i_kronos_mem_top___i_kronos_core___u_ex___result ;
                     end 
                  else 
                     if ( i_kronos_mem_top___i_kronos_core___u_ex___lsu_rdy && i_kronos_mem_top___i_kronos_core___u_ex___regwr_lsu )
                         begin  
                             i_kronos_mem_top___i_kronos_core___u_ex___regwr_pending_later  <=1'b0; 
                             i_kronos_mem_top___i_kronos_core___u_ex___regwr_en  <=1'b1; 
                             i_kronos_mem_top___i_kronos_core___u_ex___regwr_data  <= i_kronos_mem_top___i_kronos_core___u_ex___load_data ;
                         end 
                      else 
                         if ( i_kronos_mem_top___i_kronos_core___u_ex___csr_rdy && i_kronos_mem_top___i_kronos_core___u_ex___regwr_csr )
                             begin  
                                 i_kronos_mem_top___i_kronos_core___u_ex___regwr_pending_later  <=1'b0; 
                                 i_kronos_mem_top___i_kronos_core___u_ex___regwr_en  <=1'b1; 
                                 i_kronos_mem_top___i_kronos_core___u_ex___regwr_data  <= i_kronos_mem_top___i_kronos_core___u_ex___csr_data ;
                             end 
                          else  
                             i_kronos_mem_top___i_kronos_core___u_ex___regwr_en  <=1'b0;
             end
  assign  i_kronos_mem_top___i_kronos_core___u_ex___branch_target =( i_kronos_mem_top___i_kronos_core___u_ex___trap_jump  ?  i_kronos_mem_top___i_kronos_core___u_ex___trap_handle : i_kronos_mem_top___i_kronos_core___u_ex___decode [52-:32]); 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___instr_jump = i_kronos_mem_top___i_kronos_core___u_ex___decode [14]|| i_kronos_mem_top___i_kronos_core___u_ex___decode [13]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___branch =( i_kronos_mem_top___i_kronos_core___u_ex___instr_vld && i_kronos_mem_top___i_kronos_core___u_ex___instr_jump )|| i_kronos_mem_top___i_kronos_core___u_ex___trap_jump ; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___exception =( i_kronos_mem_top___i_kronos_core___u_ex___decode [2]|| i_kronos_mem_top___i_kronos_core___u_ex___decode [0])||( i_kronos_mem_top___i_kronos_core___u_ex___instr_jump && i_kronos_mem_top___i_kronos_core___u_ex___decode [1]); localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_BREAKPOINT =4'd3; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_ECALL_MACHINE =4'd11; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_ILLEGAL_INSTR =4'd2; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_INSTR_ADDR_MISALIGNED =4'd0; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_LOAD_ADDR_MISALIGNED =4'd4; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_STORE_ADDR_MISALIGNED =4'd6; 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_ex___clk )
         if ( i_kronos_mem_top___i_kronos_core___u_ex___decode_vld &&( i_kronos_mem_top___i_kronos_core___u_ex___state ==3'd0))
             begin 
                 if ( i_kronos_mem_top___i_kronos_core___u_ex___core_interrupt )
                     begin  
                         i_kronos_mem_top___i_kronos_core___u_ex___trap_cause  <={28'b1000000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___core_interrupt_cause }; 
                         i_kronos_mem_top___i_kronos_core___u_ex___trap_value  <=1'sb0;
                     end 
                  else 
                     if ( i_kronos_mem_top___i_kronos_core___u_ex___decode [2])
                         begin  
                             i_kronos_mem_top___i_kronos_core___u_ex___trap_cause  <={28'b0000000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_ILLEGAL_INSTR }; 
                             i_kronos_mem_top___i_kronos_core___u_ex___trap_value  <= i_kronos_mem_top___i_kronos_core___u_ex___decode [148-:32];
                         end 
                      else 
                         if ( i_kronos_mem_top___i_kronos_core___u_ex___decode [1]&& i_kronos_mem_top___i_kronos_core___u_ex___instr_jump )
                             begin  
                                 i_kronos_mem_top___i_kronos_core___u_ex___trap_cause  <={28'b0000000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_INSTR_ADDR_MISALIGNED }; 
                                 i_kronos_mem_top___i_kronos_core___u_ex___trap_value  <= i_kronos_mem_top___i_kronos_core___u_ex___decode [52-:32];
                             end 
                          else 
                             if ( i_kronos_mem_top___i_kronos_core___u_ex___decode [0]&& i_kronos_mem_top___i_kronos_core___u_ex___decode [12])
                                 begin  
                                     i_kronos_mem_top___i_kronos_core___u_ex___trap_cause  <={28'b0000000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_LOAD_ADDR_MISALIGNED }; 
                                     i_kronos_mem_top___i_kronos_core___u_ex___trap_value  <= i_kronos_mem_top___i_kronos_core___u_ex___decode [52-:32];
                                 end 
                              else 
                                 if ( i_kronos_mem_top___i_kronos_core___u_ex___decode [0]&& i_kronos_mem_top___i_kronos_core___u_ex___decode [11])
                                     begin  
                                         i_kronos_mem_top___i_kronos_core___u_ex___trap_cause  <={28'b0000000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_STORE_ADDR_MISALIGNED }; 
                                         i_kronos_mem_top___i_kronos_core___u_ex___trap_value  <= i_kronos_mem_top___i_kronos_core___u_ex___decode [52-:32];
                                     end 
                                  else 
                                     if ( i_kronos_mem_top___i_kronos_core___u_ex___decode [4-:2]== i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_ECALL )
                                         begin  
                                             i_kronos_mem_top___i_kronos_core___u_ex___trap_cause  <={28'b0000000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_ECALL_MACHINE }; 
                                             i_kronos_mem_top___i_kronos_core___u_ex___trap_value  <=1'sb0;
                                         end 
                                      else 
                                         if ( i_kronos_mem_top___i_kronos_core___u_ex___decode [4-:2]== i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_EBREAK )
                                             begin  
                                                 i_kronos_mem_top___i_kronos_core___u_ex___trap_cause  <={28'b0000000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___kronos_types_BREAKPOINT }; 
                                                 i_kronos_mem_top___i_kronos_core___u_ex___trap_value  <= i_kronos_mem_top___i_kronos_core___u_ex___decode [180-:32];
                                             end 
             end 
          else 
             if ( i_kronos_mem_top___i_kronos_core___u_ex___state ==3'd5)
                 begin 
                     if ( i_kronos_mem_top___i_kronos_core___u_ex___core_interrupt )
                         begin  
                             i_kronos_mem_top___i_kronos_core___u_ex___trap_cause  <={28'b1000000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___core_interrupt_cause }; 
                             i_kronos_mem_top___i_kronos_core___u_ex___trap_value  <=1'sb0;
                         end 
                 end
  assign  i_kronos_mem_top___i_kronos_core___u_ex___csr_vld = i_kronos_mem_top___i_kronos_core___u_ex___instr_vld ||( i_kronos_mem_top___i_kronos_core___u_ex___state ==3'd2);  
    

    // INSTANCE: [i_kronos_mem_top___i_kronos_core___u_ex___u_csr]
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___clk;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___rstz;
    wire[180:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___decode;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_vld;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rdy;
    reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_data;
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_csr___regwr_csr;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___instret;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___activate_trap;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___return_trap;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_cause;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_value;
    reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_handle;
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_jump;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___software_interrupt;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___timer_interrupt;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___external_interrupt;
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_csr___core_interrupt;
    reg[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___core_interrupt_cause;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___clk = i_kronos_mem_top___i_kronos_core___u_ex___clk;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___rstz = i_kronos_mem_top___i_kronos_core___u_ex___rstz;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___decode = i_kronos_mem_top___i_kronos_core___u_ex___decode;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_vld = i_kronos_mem_top___i_kronos_core___u_ex___csr_vld;
    assign i_kronos_mem_top___i_kronos_core___u_ex___csr_rdy = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rdy;
    assign i_kronos_mem_top___i_kronos_core___u_ex___csr_data = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_data;
    assign i_kronos_mem_top___i_kronos_core___u_ex___regwr_csr = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___regwr_csr;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___instret = i_kronos_mem_top___i_kronos_core___u_ex___instret;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___activate_trap = i_kronos_mem_top___i_kronos_core___u_ex___activate_trap;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___return_trap = i_kronos_mem_top___i_kronos_core___u_ex___return_trap;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_cause = i_kronos_mem_top___i_kronos_core___u_ex___trap_cause;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_value = i_kronos_mem_top___i_kronos_core___u_ex___trap_value;
    assign i_kronos_mem_top___i_kronos_core___u_ex___trap_handle = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_handle;
    assign i_kronos_mem_top___i_kronos_core___u_ex___trap_jump = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_jump;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___software_interrupt = i_kronos_mem_top___i_kronos_core___u_ex___software_interrupt;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___timer_interrupt = i_kronos_mem_top___i_kronos_core___u_ex___timer_interrupt;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___external_interrupt = i_kronos_mem_top___i_kronos_core___u_ex___external_interrupt;
    assign i_kronos_mem_top___i_kronos_core___u_ex___core_interrupt = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___core_interrupt;
    assign i_kronos_mem_top___i_kronos_core___u_ex___core_interrupt_cause = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___core_interrupt_cause;
    wire[2:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___funct3 ; 
    wire[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___addr ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___zimm ; 
    wire[4:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___rd ; 
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___wr_data ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_vld ; 
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_vld ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_en ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_en ; reg[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus ; reg[2:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mie ; reg[2:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mip ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mtvec ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mscratch ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mepc ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcause ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mtval ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle_wrenl ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle_wrenh ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle_rd_vld ; 
    wire[63:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret_wrenl ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret_wrenh ; 
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret_rd_vld ; 
    wire[63:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret ; reg[1:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___state ; reg[1:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___next_state ; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___addr = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___decode [148-:12]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___funct3 = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___decode [131:129]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___rd = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___decode [128:124]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___zimm = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___decode [136:132]; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___wr_data =( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___funct3 [2] ? {27'b000000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___u_csr___zimm }: i_kronos_mem_top___i_kronos_core___u_ex___u_csr___decode [116-:32]); 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rdy = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___state ==2'd2; 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___rstz ) 
             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___state  <=2'd0;
          else  
             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___state  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___next_state ;
  always @(*)
         begin  
             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___next_state  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___state ;
             case ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___state )
              2 'd0:
                  if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_vld && i_kronos_mem_top___i_kronos_core___u_ex___u_csr___decode [6]) 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___next_state  =2'd1;
              2 'd1:
                  if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_vld ) 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___next_state  =2'd2;
              2 'd2: 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___next_state  =2'd0;endcase
         end
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___rstz )
             begin  
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_vld  <=1'b0; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___regwr_csr  <=1'b0;
             end 
          else 
             if ((( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___state ==2'd0)&& i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_vld )&& i_kronos_mem_top___i_kronos_core___u_ex___u_csr___decode [6])
                 begin  
                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_vld  <= ~((( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___funct3 ==3'b010)||( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___funct3 ==3'b011))&&( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___zimm =={5{1'sb0}})); 
                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___regwr_csr  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___rd !={5{1'sb0}};
                 end 
              else 
                 if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___state ==2'd2) 
                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___regwr_csr  <=1'b0;
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_vld = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle_rd_vld && i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret_rd_vld ; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_en =( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___state ==2'd1)&& i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_vld ; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_en =( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___state ==2'd2)&& i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_vld ; 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___clk )
         if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_en ) 
             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_data  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data ;
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___rstz ) 
             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_jump  <=1'b0;
          else 
             if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___activate_trap )
                 begin  
                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_jump  <=1'b1; 
                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_handle  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mtvec ;
                 end 
              else 
                 if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___return_trap )
                     begin  
                         i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_jump  <=1'b1; 
                         i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_handle  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mepc ;
                     end 
                  else  
                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_jump  <=1'b0;
 localparam[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MCAUSE =12'h342; localparam[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MCYCLE =12'hb00; localparam[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MCYCLEH =12'hb80; localparam[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MEPC =12'h341; localparam[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MIE =12'h304; localparam[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MINSTRET =12'hb02; localparam[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MINSTRETH =12'hb82; localparam[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MIP =12'h344; localparam[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MSCRATCH =12'h340; localparam[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MSTATUS =12'h300; localparam[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MTVAL =12'h343; localparam[11:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MTVEC =12'h305; 
  always @(*)
         begin  
             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  =1'sb0;
             case ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___addr ) 
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MSTATUS  :
                  begin  
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  [3]= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus [0]; 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  [7]= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus [1]; 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  [12:11]= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus [3-:2];
                  end  
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MIE  :
                  begin  
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  [3]= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mie [0]; 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  [7]= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mie [1]; 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  [11]= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mie [2];
                  end  
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MTVEC  : 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mtvec ; 
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MSCRATCH  : 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mscratch ; 
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MEPC  : 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mepc ; 
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MCAUSE  : 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcause ; 
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MTVAL  : 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mtval ; 
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MIP  :
                  begin  
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  [3]= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mip [0]; 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  [7]= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mip [1]; 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  [11]= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mip [2];
                  end  
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MCYCLE  : 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle [31:0]; 
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MINSTRET  : 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret [31:0]; 
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MCYCLEH  : 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle [63:32]; 
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MINSTRETH  : 
                  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_rd_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret [63:32];endcase
         end
  localparam[1:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_CSR_RC =2'b11; localparam[1:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_CSR_RS =2'b10; 
  always @(*)
         case ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___funct3 [1:0]) 
          i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_CSR_RS  : 
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_data | i_kronos_mem_top___i_kronos_core___u_ex___u_csr___wr_data ; 
          i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_CSR_RC  : 
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_data & ~ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___wr_data ;
          default : 
              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data  = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___wr_data ;endcase
 localparam[1:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_DIRECT_MODE =2'b00; localparam[1:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_PRIVILEGE_MACHINE =2'b11; 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___rstz )
             begin  
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus  [0]<=1'b0; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus  [1]<=1'b0; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus  [3-:2]<= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_PRIVILEGE_MACHINE ; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mip  <=1'sb0; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mie  <=1'sb0; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mtvec  [31-:30]<= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___BOOT_ADDR [31:2]; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mtvec  [1-:2]<= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_DIRECT_MODE ;
             end 
          else 
             begin 
                 if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_en )
                     case ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___addr ) 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MSTATUS  :
                          begin  
                              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus  [0]<= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data [3]; 
                              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus  [1]<= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data [7];
                          end  
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MIE  :
                          begin  
                              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mie  [0]<= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data [3]; 
                              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mie  [1]<= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data [7]; 
                              i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mie  [2]<= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data [11];
                          end  
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MTVEC  : 
                          i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mtvec  [31-:30]<= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data [31:2]; 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MSCRATCH  : 
                          i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mscratch  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data ; 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MEPC  : 
                          i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mepc  <={ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data [31:2],2'b00}; 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MCAUSE  : 
                          i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcause  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data ; 
                      i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MTVAL  : 
                          i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mtval  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data ;endcase
                  else 
                     if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___activate_trap )
                         begin  
                             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus  [0]<=1'b0; 
                             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus  [1]<= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus [0]; 
                             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mepc  <={ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___decode [180:151],2'b00}; 
                             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcause  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_cause ; 
                             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mtval  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___trap_value ;
                         end 
                      else 
                         if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___return_trap )
                             begin  
                                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus  [0]<= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus [1]; 
                                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus  [1]<=1'b1;
                             end  
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mip  [0]<=( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___software_interrupt & i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus [0])& i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mie [0]; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mip  [1]<=( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___timer_interrupt & i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus [0])& i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mie [1]; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mip  [2]<=( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___external_interrupt & i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mstatus [0])& i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mie [2];
             end
  localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_EXTERNAL_INTERRUPT =4'd11; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_SOFTWARE_INTERRUPT =4'd3; localparam[3:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_TIMER_INTERRUPT =4'd7; 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___rstz ) 
             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___core_interrupt  <=1'b0;
          else 
             begin  
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___core_interrupt  <= |{ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mip };
                 if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mip [2]) 
                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___core_interrupt_cause  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_EXTERNAL_INTERRUPT ;
                  else 
                     if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mip [0]) 
                         i_kronos_mem_top___i_kronos_core___u_ex___u_csr___core_interrupt_cause  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_SOFTWARE_INTERRUPT ;
                      else 
                         if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mip [1]) 
                             i_kronos_mem_top___i_kronos_core___u_ex___u_csr___core_interrupt_cause  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_TIMER_INTERRUPT ;
             end
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle_wrenl = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_en &&( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___addr == i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MCYCLE ); 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle_wrenh = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_en &&( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___addr == i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MCYCLEH );  
    
    // INSTANCE: [i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0]
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___clk;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___rstz;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___incr;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___load_data;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___load_low;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___load_high;
    wire[63:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_vld;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___clk = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___clk;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___rstz = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___rstz;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___incr = 1'b1;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___load_data = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___load_low = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle_wrenl;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___load_high = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle_wrenh;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___mcycle_rd_vld = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_vld;

    reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_low ; 
    reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_high ; 
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___incr_high ; 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___rstz )
             begin  
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_low  <=1'sb0; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_high  <=1'sb0; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___incr_high  <=1'b0;
             end 
          else 
             begin  
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___incr_high  <=1'b0;
                 if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___load_low ) 
                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_low  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___load_data ;
                  else 
                     if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___load_high ) 
                         i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_high  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___load_data ;
                      else 
                         begin 
                             if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___incr )
                                 begin  
                                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_low  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_low +1'b1; 
                                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___incr_high  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_low =={32{1'sb1}};
                                 end 
                             if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___incr_high ) 
                                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_high  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_high +1'b1;
                         end 
             end
  generate
if( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___EN_COUNTERS )begin: i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___genblk1 if( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___EN_COUNTERS64B )begin: i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___genblk1 
           assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count ={ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_high , i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_low };
           assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_vld = ~ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___incr_high ;end
         else begin: i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___genblk1 
           assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count ={32'b00000000000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_low };
           assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_vld =1'b1;end
end
     else begin: i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___genblk1 
       assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count =1'sb0;
       assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter0___count_vld =1'b1;end
endgenerate
     
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret_wrenl = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_en &&( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___addr == i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MINSTRET ); 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret_wrenh = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_en &&( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___addr == i_kronos_mem_top___i_kronos_core___u_ex___u_csr___kronos_types_MINSTRETH );  
    

    // INSTANCE: [i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1]
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___clk;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___rstz;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___incr;
    wire[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___load_data;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___load_low;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___load_high;
    wire[63:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count;
    wire i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_vld;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___clk = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___clk;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___rstz = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___rstz;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___incr = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___instret;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___load_data = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___csr_wr_data;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___load_low = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret_wrenl;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___load_high = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret_wrenh;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count;
    assign i_kronos_mem_top___i_kronos_core___u_ex___u_csr___minstret_rd_vld = i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_vld;
    reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_low ; reg[31:0] i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_high ; 
    reg i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___incr_high ; 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___rstz )
             begin  
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_low  <=1'sb0; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_high  <=1'sb0; 
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___incr_high  <=1'b0;
             end 
          else 
             begin  
                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___incr_high  <=1'b0;
                 if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___load_low ) 
                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_low  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___load_data ;
                  else 
                     if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___load_high ) 
                         i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_high  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___load_data ;
                      else 
                         begin 
                             if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___incr )
                                 begin  
                                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_low  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_low +1'b1; 
                                     i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___incr_high  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_low =={32{1'sb1}};
                                 end 
                             if ( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___incr_high ) 
                                 i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_high  <= i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_high +1'b1;
                         end 
             end
  generate
    if( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___EN_COUNTERS )
    begin: i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___genblk1 
    if( i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___EN_COUNTERS64B )
    begin: i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___genblk1 
           assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count ={ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_high , i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_low };
           assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_vld = ~ i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___incr_high ;end
         else 
         begin: i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___genblk1 
           assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count ={32'b00000000000000000000000000000000, i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_low };
           assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_vld =1'b1;
           end
           end
     else begin: i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___genblk1 
       assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count =1'sb0;
       assign  i_kronos_mem_top___i_kronos_core___u_ex___u_csr___u_hpmcounter1___count_vld =1'b1;
       end
    endgenerate
    
     
  assign  i_kronos_mem_top___i_kronos_core___u_ex___activate_trap = i_kronos_mem_top___i_kronos_core___u_ex___state ==3'd3; 
  assign  i_kronos_mem_top___i_kronos_core___u_ex___return_trap = i_kronos_mem_top___i_kronos_core___u_ex___state ==3'd4; 
  always @( posedge  i_kronos_mem_top___i_kronos_core___u_ex___clk )
         if ( ~ i_kronos_mem_top___i_kronos_core___u_ex___rstz ) 
             i_kronos_mem_top___i_kronos_core___u_ex___instret  <=1'b0;
          else  
             i_kronos_mem_top___i_kronos_core___u_ex___instret  <=( i_kronos_mem_top___i_kronos_core___u_ex___decode_vld && i_kronos_mem_top___i_kronos_core___u_ex___decode_rdy )||( i_kronos_mem_top___i_kronos_core___u_ex___decode [5]&& i_kronos_mem_top___i_kronos_core___u_ex___trap_jump );

     
  assign  i_kronos_mem_top___i_kronos_core___flush = i_kronos_mem_top___i_kronos_core___branch ;
    
    
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