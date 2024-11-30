module mc_top #(
    parameter u0_u0_this_cs=3'h0,
    parameter u0_u0_reg_select=u0_u0_this_cs+2,
    parameter u0_u1_this_cs=3'h1,
    parameter u0_u1_reg_select=u0_u0_this_cs+2)(clk_i, rst_i,

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

    wire u0_clk;
    wire u0_rst;
    wire[31:0] u0_wb_data_i;
    wire[31:0] u0_rf_dout;
    wire[31:0] u0_wb_addr_i;
    wire u0_wb_we_i;
    wire u0_wb_cyc_i;
    wire u0_wb_stb_i;
    wire u0_wb_ack_o;
    wire u0_wp_err;
    wire[31:0] u0_csc;
    wire[31:0] u0_tms;
    wire[31:0] u0_poc;
    wire[31:0] u0_sp_csc;
    wire[31:0] u0_sp_tms;
    wire[7:0] u0_cs;
    wire[31:0] u0_mc_data_i;
    wire u0_mc_sts;
    wire u0_mc_vpen;
    wire u0_fs;
    wire u0_cs_le_d;
    wire u0_cs_le;
    wire[7:0] u0_cs_need_rfr;
    wire[2:0] u0_ref_int;
    wire[7:0] u0_rfr_ps_val;
    wire u0_init_req;
    wire u0_init_ack;
    wire u0_lmr_req;
    wire u0_lmr_ack;
    wire[7:0] u0_spec_req_cs;

    reg u0_wb_ack_o ; reg[31:0] u0_csc ; reg[31:0] u0_tms ; reg[31:0] u0_sp_csc ; reg[31:0] u0_sp_tms ; reg[31:0] u0_rf_dout ; reg[7:0] u0_cs ; 
    reg u0_rf_we ; 
    wire[31:0] u0_csr ; reg[10:0] u0_csr_r ; reg[7:0] u0_csr_r2 ; reg[7:0] u0_csr_tj_val ; reg[7:0] u0_csr_tj ; reg[31:0] u0_poc ; 
    wire[31:0] u0_csc_mask ; reg[10:0] u0_csc_mask_r ; 
    wire[31:0] u0_csc0 , u0_tms0 ; 
    wire[31:0] u0_csc1 , u0_tms1 ; 
    wire[31:0] u0_csc2 , u0_tms2 ; 
    wire[31:0] u0_csc3 , u0_tms3 ; 
    wire[31:0] u0_csc4 , u0_tms4 ; 
    wire[31:0] u0_csc5 , u0_tms5 ; 
    wire[31:0] u0_csc6 , u0_tms6 ; 
    wire[31:0] u0_csc7 , u0_tms7 ; 
    wire u0_cs0 , u0_cs1 , u0_cs2 , u0_cs3 ; 
    wire u0_cs4 , u0_cs5 , u0_cs6 , u0_cs7 ; 
    wire u0_wp_err0 , u0_wp_err1 , u0_wp_err2 , u0_wp_err3 ; 
    wire u0_wp_err4 , u0_wp_err5 , u0_wp_err6 , u0_wp_err7 ; 
    reg u0_wp_err ; 
    wire u0_lmr_req7 , u0_lmr_req6 , u0_lmr_req5 , u0_lmr_req4 ; 
    wire u0_lmr_req3 , u0_lmr_req2 , u0_lmr_req1 , u0_lmr_req0 ; 
    wire u0_lmr_ack7 , u0_lmr_ack6 , u0_lmr_ack5 , u0_lmr_ack4 ; 
    wire u0_lmr_ack3 , u0_lmr_ack2 , u0_lmr_ack1 , u0_lmr_ack0 ; 
    wire u0_init_req7 , u0_init_req6 , u0_init_req5 , u0_init_req4 ; 
    wire u0_init_req3 , u0_init_req2 , u0_init_req1 , u0_init_req0 ; 
    wire u0_init_ack7 , u0_init_ack6 , u0_init_ack5 , u0_init_ack4 ; 
    wire u0_init_ack3 , u0_init_ack2 , u0_init_ack1 , u0_init_ack0 ; 
    reg u0_init_ack_r ; 
    wire u0_init_ack_fe ; 
    reg u0_lmr_ack_r ; 
    wire u0_lmr_ack_fe ; 
    wire[7:0] u0_spec_req_cs_t ; 
    wire[7:0] u0_spec_req_cs_d ; reg[7:0] u0_spec_req_cs ; 
    reg u0_init_req , u0_lmr_req ; 
    reg u0_sreq_cs_le ; 
  assign  u0_csr ={ u0_csr_r2 ,8'h0,5'h0, u0_csr_r }; 
  assign  u0_csc_mask ={21'h0, u0_csc_mask_r }; 
  always @(                     u0_wb_addr_i                                                or   u0_csr                            or   u0_poc                           or   u0_csc_mask                          or   u0_csc0                         or   u0_tms0                        or   u0_csc1                       or   u0_tms1                      or   u0_csc2                     or   u0_tms2                    or   u0_csc3                   or   u0_tms3                  or   u0_csc4                 or   u0_tms4                or   u0_csc5               or   u0_tms5              or   u0_csc6             or   u0_tms6            or   u0_csc7           or   u0_tms7  )
         case ( u0_wb_addr_i [6:2])
          5 'h00: 
              u0_rf_dout  <= u0_csr ;
          5 'h01: 
              u0_rf_dout  <= u0_poc ;
          5 'h02: 
              u0_rf_dout  <= u0_csc_mask ;
          5 'h04: 
              u0_rf_dout  <= u0_csc0 ;
          5 'h05: 
              u0_rf_dout  <= u0_tms0 ;
          5 'h06: 
              u0_rf_dout  <= u0_csc1 ;
          5 'h07: 
              u0_rf_dout  <= u0_tms1 ;
          5 'h08: 
              u0_rf_dout  <= u0_csc2 ;
          5 'h09: 
              u0_rf_dout  <= u0_tms2 ;
          5 'h0a: 
              u0_rf_dout  <= u0_csc3 ;
          5 'h0b: 
              u0_rf_dout  <= u0_tms3 ;
          5 'h0c: 
              u0_rf_dout  <= u0_csc4 ;
          5 'h0d: 
              u0_rf_dout  <= u0_tms4 ;
          5 'h0e: 
              u0_rf_dout  <= u0_csc5 ;
          5 'h0f: 
              u0_rf_dout  <= u0_tms5 ;
          5 'h10: 
              u0_rf_dout  <= u0_csc6 ;
          5 'h11: 
              u0_rf_dout  <= u0_tms6 ;
          5 'h12: 
              u0_rf_dout  <= u0_csc7 ;
          5 'h13: 
              u0_rf_dout  <= u0_tms7 ;endcase
 reg[6:0] u0_wb_addr_r ; 
  always @( posedge  u0_clk ) 
         u0_wb_addr_r  <= u0_wb_addr_i [6:0];
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_rf_we  <=1'b0;
          else  
             u0_rf_we  <=( u0_wb_addr_i [31:29]==3'b011)& u0_wb_we_i & u0_wb_cyc_i & u0_wb_stb_i &! u0_rf_we ;
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_csr_r2  <=8'h0;
          else 
             if ( u0_rf_we &( u0_wb_addr_r [6:2]==5'h0)) 
                 u0_csr_r2  <= u0_wb_data_i [31:24];
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst )
             begin  
                 u0_csr_tj_val  <=8'h0;
             end 
          else 
             if ( u0_rf_we &( u0_wb_addr_r [6:2]==5'h0))
                 begin  
                     u0_csr_tj_val  <= u0_wb_data_i [23:16];
                 end
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_csr_r  <=11'h0;
          else 
             if ( u0_rf_we &( u0_wb_addr_r [6:2]==5'h0)) 
                 u0_csr_r  <={ u0_wb_data_i [10:1], u0_mc_sts };
    reg u0_trig ; 
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst )
             begin  
                 u0_trig  <=1'h0;
             end 
          else 
             if ( u0_csr_tj_val ==8'h77)
                 begin  
                     u0_trig  <=1'b1;
                 end
  assign  u0_mc_vpen = u0_csr_r [1]; 
  assign  u0_fs = u0_csr_r [2]| u0_trig ; 
  assign  u0_rfr_ps_val = u0_csr_r2 [7:0]; 
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_csc_mask_r  <=11'h7ff;
          else 
             if ( u0_rf_we &( u0_wb_addr_r [6:2]==5'h2)) 
                 u0_csc_mask_r  <= u0_wb_data_i [10:0];
    reg u0_rst_r1 , u0_rst_r2 , u0_rst_r3 ; 
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_rst_r1  <=1'b1;
          else  
             u0_rst_r1  <=1'b0;
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_rst_r2  <=1'b1;
          else  
             u0_rst_r2  <= u0_rst_r1 ;
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_rst_r3  <=1'b1;
          else  
             u0_rst_r3  <= u0_rst_r2 ;
  always @( posedge  u0_clk )
         if ( u0_rst_r3 ) 
             u0_poc  <= u0_mc_data_i ;
  always @( posedge  u0_clk ) 
         u0_wb_ack_o  <=( u0_wb_addr_i [31:29]==3'b011)& u0_wb_cyc_i & u0_wb_stb_i &! u0_wb_ack_o ;
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_cs  <=8'h0;
          else 
             if ( u0_cs_le ) 
                 u0_cs  <={ u0_cs7 , u0_cs6 , u0_cs5 , u0_cs4 , u0_cs3 , u0_cs2 , u0_cs1 , u0_cs0 };
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_wp_err  <=1'b0;
          else 
             if ( u0_cs_le & u0_wb_cyc_i & u0_wb_stb_i ) 
                 u0_wp_err  <=#1 u0_wp_err7 | u0_wp_err6 | u0_wp_err5 | u0_wp_err4 | u0_wp_err3 | u0_wp_err2 | u0_wp_err1 | u0_wp_err0 ;
              else 
                 if (! u0_wb_cyc_i ) 
                     u0_wp_err  <=1'b0;
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_csc  <=32'h0;
          else 
             if ( u0_cs_le_d & u0_wb_cyc_i & u0_wb_stb_i )
                 begin 
                     if ( u0_cs0 ) 
                         u0_csc  <= u0_csc0 ;
                      else 
                         if ( u0_cs1 ) 
                             u0_csc  <= u0_csc1 ;
                          else 
                             if ( u0_cs2 ) 
                                 u0_csc  <= u0_csc2 ;
                              else 
                                 if ( u0_cs3 ) 
                                     u0_csc  <= u0_csc3 ;
                                  else 
                                     if ( u0_cs4 ) 
                                         u0_csc  <= u0_csc4 ;
                                      else 
                                         if ( u0_cs5 ) 
                                             u0_csc  <= u0_csc5 ;
                                          else 
                                             if ( u0_cs6 ) 
                                                 u0_csc  <= u0_csc6 ;
                                              else  
                                                 u0_csc  <= u0_csc7 ;
                 end
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_tms  <=32'hffff_ffff;
          else 
             if (( u0_cs_le_d | u0_rf_we )& u0_wb_cyc_i & u0_wb_stb_i )
                 begin 
                     if ( u0_cs0 ) 
                         u0_tms  <= u0_tms0 ;
                      else 
                         if ( u0_cs1 ) 
                             u0_tms  <= u0_tms1 ;
                          else 
                             if ( u0_cs2 ) 
                                 u0_tms  <= u0_tms2 ;
                              else 
                                 if ( u0_cs3 ) 
                                     u0_tms  <= u0_tms3 ;
                                  else 
                                     if ( u0_cs4 ) 
                                         u0_tms  <= u0_tms4 ;
                                      else 
                                         if ( u0_cs5 ) 
                                             u0_tms  <= u0_tms5 ;
                                          else 
                                             if ( u0_cs6 ) 
                                                 u0_tms  <= u0_tms6 ;
                                              else  
                                                 u0_tms  <= u0_tms7 ;
                 end
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_sp_csc  <=32'h0;
          else 
             if ( u0_cs_le_d & u0_wb_cyc_i & u0_wb_stb_i )
                 begin 
                     if ( u0_spec_req_cs [0]) 
                         u0_sp_csc  <= u0_csc0 ;
                      else 
                         if ( u0_spec_req_cs [1]) 
                             u0_sp_csc  <= u0_csc1 ;
                          else 
                             if ( u0_spec_req_cs [2]) 
                                 u0_sp_csc  <= u0_csc2 ;
                              else 
                                 if ( u0_spec_req_cs [3]) 
                                     u0_sp_csc  <= u0_csc3 ;
                                  else 
                                     if ( u0_spec_req_cs [4]) 
                                         u0_sp_csc  <= u0_csc4 ;
                                      else 
                                         if ( u0_spec_req_cs [5]) 
                                             u0_sp_csc  <= u0_csc5 ;
                                          else 
                                             if ( u0_spec_req_cs [6]) 
                                                 u0_sp_csc  <= u0_csc6 ;
                                              else  
                                                 u0_sp_csc  <= u0_csc7 ;
                 end
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_sp_tms  <=32'hffff_ffff;
          else 
             if (( u0_cs_le_d | u0_rf_we )& u0_wb_cyc_i & u0_wb_stb_i )
                 begin 
                     if ( u0_spec_req_cs [0]) 
                         u0_sp_tms  <= u0_tms0 ;
                      else 
                         if ( u0_spec_req_cs [1]) 
                             u0_sp_tms  <= u0_tms1 ;
                          else 
                             if ( u0_spec_req_cs [2]) 
                                 u0_sp_tms  <= u0_tms2 ;
                              else 
                                 if ( u0_spec_req_cs [3]) 
                                     u0_sp_tms  <= u0_tms3 ;
                                  else 
                                     if ( u0_spec_req_cs [4]) 
                                         u0_sp_tms  <= u0_tms4 ;
                                      else 
                                         if ( u0_spec_req_cs [5]) 
                                             u0_sp_tms  <= u0_tms5 ;
                                          else 
                                             if ( u0_spec_req_cs [6]) 
                                                 u0_sp_tms  <= u0_tms6 ;
                                              else  
                                                 u0_sp_tms  <= u0_tms7 ;
                 end
  assign  u0_cs_need_rfr ={ u0_csc7 [0]&( u0_csc7 [3:1]==3'h0), u0_csc6 [0]&( u0_csc6 [3:1]==3'h0), u0_csc5 [0]&( u0_csc5 [3:1]==3'h0), u0_csc4 [0]&( u0_csc4 [3:1]==3'h0), u0_csc3 [0]&( u0_csc3 [3:1]==3'h0), u0_csc2 [0]&( u0_csc2 [3:1]==3'h0), u0_csc1 [0]&( u0_csc1 [3:1]==3'h0), u0_csc0 [0]&( u0_csc0 [3:1]==3'h0)}; 
  assign  u0_ref_int = u0_csr_r [10:8]; 
  always @( posedge  u0_clk ) 
         u0_init_ack_r  <= u0_init_ack ;
  assign  u0_init_ack_fe = u0_init_ack_r &! u0_init_ack ; 
  always @( posedge  u0_clk ) 
         u0_lmr_ack_r  <= u0_lmr_ack ;
  assign  u0_lmr_ack_fe = u0_lmr_ack_r &! u0_lmr_ack ; 
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_spec_req_cs  <=8'h0;
          else 
             if ( u0_sreq_cs_le ) 
                 u0_spec_req_cs  <= u0_spec_req_cs_d ;
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_sreq_cs_le  <=1'b0;
          else  
             u0_sreq_cs_le  <=(! u0_init_req &! u0_lmr_req )| u0_lmr_ack_fe | u0_init_ack_fe ;
  assign  u0_spec_req_cs_d ={ u0_spec_req_cs_t [7]&!(| u0_spec_req_cs_t [6:0]), u0_spec_req_cs_t [6]&!(| u0_spec_req_cs_t [5:0]), u0_spec_req_cs_t [5]&!(| u0_spec_req_cs_t [4:0]), u0_spec_req_cs_t [4]&!(| u0_spec_req_cs_t [3:0]), u0_spec_req_cs_t [3]&!(| u0_spec_req_cs_t [2:0]), u0_spec_req_cs_t [2]&!(| u0_spec_req_cs_t [1:0]), u0_spec_req_cs_t [1]&! u0_spec_req_cs_t [0], u0_spec_req_cs_t [0]}; 
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_init_req  <=1'b0;
          else  
             u0_init_req  <=#1 u0_init_req0 | u0_init_req1 | u0_init_req2 | u0_init_req3 | u0_init_req4 | u0_init_req5 | u0_init_req6 | u0_init_req7 ;
  always @(  posedge   u0_clk          or  posedge  u0_rst )
         if ( u0_rst ) 
             u0_lmr_req  <=1'b0;
          else  
             u0_lmr_req  <=#1 u0_lmr_req0 | u0_lmr_req1 | u0_lmr_req2 | u0_lmr_req3 | u0_lmr_req4 | u0_lmr_req5 | u0_lmr_req6 | u0_lmr_req7 ;
  assign  u0_spec_req_cs_t =! u0_init_req  ? { u0_lmr_req7 , u0_lmr_req6 , u0_lmr_req5 , u0_lmr_req4 , u0_lmr_req3 , u0_lmr_req2 , u0_lmr_req1 , u0_lmr_req0 }:{ u0_init_req7 , u0_init_req6 , u0_init_req5 , u0_init_req4 , u0_init_req3 , u0_init_req2 , u0_init_req1 , u0_init_req0 }; 
  assign  u0_lmr_ack0 = u0_spec_req_cs [0]& u0_lmr_ack_fe ; 
  assign  u0_lmr_ack1 = u0_spec_req_cs [1]& u0_lmr_ack_fe ; 
  assign  u0_lmr_ack2 = u0_spec_req_cs [2]& u0_lmr_ack_fe ; 
  assign  u0_lmr_ack3 = u0_spec_req_cs [3]& u0_lmr_ack_fe ; 
  assign  u0_lmr_ack4 = u0_spec_req_cs [4]& u0_lmr_ack_fe ; 
  assign  u0_lmr_ack5 = u0_spec_req_cs [5]& u0_lmr_ack_fe ; 
  assign  u0_lmr_ack6 = u0_spec_req_cs [6]& u0_lmr_ack_fe ; 
  assign  u0_lmr_ack7 = u0_spec_req_cs [7]& u0_lmr_ack_fe ; 
  assign  u0_init_ack0 = u0_spec_req_cs [0]& u0_init_ack_fe ; 
  assign  u0_init_ack1 = u0_spec_req_cs [1]& u0_init_ack_fe ; 
  assign  u0_init_ack2 = u0_spec_req_cs [2]& u0_init_ack_fe ; 
  assign  u0_init_ack3 = u0_spec_req_cs [3]& u0_init_ack_fe ; 
  assign  u0_init_ack4 = u0_spec_req_cs [4]& u0_init_ack_fe ; 
  assign  u0_init_ack5 = u0_spec_req_cs [5]& u0_init_ack_fe ; 
  assign  u0_init_ack6 = u0_spec_req_cs [6]& u0_init_ack_fe ; 
  assign  u0_init_ack7 = u0_spec_req_cs [7]& u0_init_ack_fe ;  
    wire u0_u0_clk;
    wire u0_u0_rst;
    wire u0_u0_wb_we_i;
    wire[31:0] u0_u0_din;
    wire u0_u0_rf_we;
    wire[31:0] u0_u0_addr;
    reg u0_u0_csc;
    reg u0_u0_tms;
    wire[31:0] u0_u0_poc;
    wire[31:0] u0_u0_csc_mask;
    wire u0_u0_cs;
    wire u0_u0_wp_err;
    reg u0_u0_lmr_req;
    wire u0_u0_lmr_ack;
    reg u0_u0_init_req;
    wire u0_u0_init_ack;
    wire u0_u1_clk;
    wire u0_u1_rst;
    wire u0_u1_wb_we_i;
    wire[31:0] u0_u1_din;
    wire u0_u1_rf_we;
    wire[31:0] u0_u1_addr;
    reg u0_u1_csc;
    reg u0_u1_tms;
    wire[31:0] u0_u1_poc;
    wire[31:0] u0_u1_csc_mask;
    wire u0_u1_cs;
    wire u0_u1_wp_err;
    reg u0_u1_lmr_req;
    wire u0_u1_lmr_ack;
    reg u0_u1_init_req;
    wire u0_u1_init_ack;

    wire u0_u0_sel ; 
    wire u0_u0_cs_d ; 
    wire u0_u0_wp ; 
    reg u0_u0_inited ; 
    reg u0_u0_init_req_we ; 
    reg u0_u0_lmr_req_we ; 
    reg u0_u0_rst_r1 , u0_u0_rst_r2 ; 
  always @(  posedge   u0_u0_clk          or  posedge  u0_u0_rst )
         if ( u0_u0_rst ) 
             u0_u0_rst_r1  <=1'b1;
          else  
             u0_u0_rst_r1  <=1'b0;
  always @(  posedge   u0_u0_clk          or  posedge  u0_u0_rst )
         if ( u0_u0_rst ) 
             u0_u0_rst_r2  <=1'b1;
          else  
             u0_u0_rst_r2  <= u0_u0_rst_r1 ;
 reg[6:0] u0_u0_addr_r ; 
  always @( posedge  u0_u0_clk ) 
         u0_u0_addr_r  <= u0_u0_addr [6:0];
  assign  u0_u0_sel = u0_u0_addr_r [6:3]== u0_u0_reg_select [3:0]; 
  always @( posedge  u0_u0_clk )
         if ( u0_u0_rst_r2 ) 
             u0_u0_csc  <=( u0_u0_this_cs [2:0]==3'h0) ? {26'h0, u0_u0_poc [1:0],1'b0, u0_u0_poc [3:2],( u0_u0_poc [3:2]!=2'b00)}:32'h0;
          else 
             if ( u0_u0_rf_we & u0_u0_sel &! u0_u0_addr_r [2]) 
                 u0_u0_csc  <= u0_u0_din ;
  always @( posedge  u0_u0_clk )
         if ( u0_u0_rst_r2 ) 
             u0_u0_tms  <=( u0_u0_this_cs [2:0]==3'h0) ? 32'hffff_ffff:32'h0;
          else 
             if ( u0_u0_rf_we & u0_u0_sel & u0_u0_addr_r [2]) 
                 u0_u0_tms  <= u0_u0_din ;
  always @(  posedge   u0_u0_clk          or  posedge  u0_u0_rst )
         if ( u0_u0_rst ) 
             u0_u0_lmr_req_we  <=1'b0;
          else  
             u0_u0_lmr_req_we  <= u0_u0_rf_we & u0_u0_sel & u0_u0_addr_r [2];
  always @(  posedge   u0_u0_clk          or  posedge  u0_u0_rst )
         if ( u0_u0_rst ) 
             u0_u0_lmr_req  <=1'b0;
          else 
             if ( u0_u0_lmr_req_we &( u0_u0_csc [3:1]==3'h0)) 
                 u0_u0_lmr_req  <= u0_u0_inited ;
              else 
                 if ( u0_u0_lmr_ack ) 
                     u0_u0_lmr_req  <=1'b0;
  always @(  posedge   u0_u0_clk          or  posedge  u0_u0_rst )
         if ( u0_u0_rst ) 
             u0_u0_init_req_we  <=1'b0;
          else  
             u0_u0_init_req_we  <= u0_u0_rf_we & u0_u0_sel &! u0_u0_addr_r [2];
  always @(  posedge   u0_u0_clk          or  posedge  u0_u0_rst )
         if ( u0_u0_rst ) 
             u0_u0_init_req  <=1'b0;
          else 
             if ( u0_u0_init_req_we &( u0_u0_csc [3:1]==3'h0)& u0_u0_csc [0]&! u0_u0_inited ) 
                 u0_u0_init_req  <=1'b1;
              else 
                 if ( u0_u0_init_ack ) 
                     u0_u0_init_req  <=1'b0;
  always @(  posedge   u0_u0_clk          or  posedge  u0_u0_rst )
         if ( u0_u0_rst ) 
             u0_u0_inited  <=1'b0;
          else 
             if ( u0_u0_init_ack ) 
                 u0_u0_inited  <=1'b1;
  assign  u0_u0_cs_d =(( u0_u0_csc [23:16]& u0_u0_csc_mask [7:0])==( u0_u0_addr [28:21]& u0_u0_csc_mask [7:0]))& u0_u0_csc [0]; 
  assign  u0_u0_wp = u0_u0_wb_we_i & u0_u0_csc [8]; 
  assign  u0_u0_wp_err = u0_u0_cs_d & u0_u0_wp ; 
  assign  u0_u0_cs = u0_u0_cs_d &! u0_u0_wp ;
    wire u0_u1_sel ; 
    wire u0_u1_cs_d ; 
    wire u0_u1_wp ; 
    reg u0_u1_inited ; 
    reg u0_u1_init_req_we ; 
    reg u0_u1_lmr_req_we ; 
    reg u0_u1_rst_r1 , u0_u1_rst_r2 ; 
  always @(  posedge   u0_u1_clk          or  posedge  u0_u1_rst )
         if ( u0_u1_rst ) 
             u0_u1_rst_r1  <=1'b1;
          else  
             u0_u1_rst_r1  <=1'b0;
  always @(  posedge   u0_u1_clk          or  posedge  u0_u1_rst )
         if ( u0_u1_rst ) 
             u0_u1_rst_r2  <=1'b1;
          else  
             u0_u1_rst_r2  <= u0_u1_rst_r1 ;
 reg[6:0] u0_u1_addr_r ; 
  always @( posedge  u0_u1_clk ) 
         u0_u1_addr_r  <= u0_u1_addr [6:0];
  assign  u0_u1_sel = u0_u1_addr_r [6:3]== u0_u1_reg_select [3:0]; 
  always @( posedge  u0_u1_clk )
         if ( u0_u1_rst_r2 ) 
             u0_u1_csc  <=( u0_u1_this_cs [2:0]==3'h0) ? {26'h0, u0_u1_poc [1:0],1'b0, u0_u1_poc [3:2],( u0_u1_poc [3:2]!=2'b00)}:32'h0;
          else 
             if ( u0_u1_rf_we & u0_u1_sel &! u0_u1_addr_r [2]) 
                 u0_u1_csc  <= u0_u1_din ;
  always @( posedge  u0_u1_clk )
         if ( u0_u1_rst_r2 ) 
             u0_u1_tms  <=( u0_u1_this_cs [2:0]==3'h0) ? 32'hffff_ffff:32'h0;
          else 
             if ( u0_u1_rf_we & u0_u1_sel & u0_u1_addr_r [2]) 
                 u0_u1_tms  <= u0_u1_din ;
  always @(  posedge   u0_u1_clk          or  posedge  u0_u1_rst )
         if ( u0_u1_rst ) 
             u0_u1_lmr_req_we  <=1'b0;
          else  
             u0_u1_lmr_req_we  <= u0_u1_rf_we & u0_u1_sel & u0_u1_addr_r [2];
  always @(  posedge   u0_u1_clk          or  posedge  u0_u1_rst )
         if ( u0_u1_rst ) 
             u0_u1_lmr_req  <=1'b0;
          else 
             if ( u0_u1_lmr_req_we &( u0_u1_csc [3:1]==3'h0)) 
                 u0_u1_lmr_req  <= u0_u1_inited ;
              else 
                 if ( u0_u1_lmr_ack ) 
                     u0_u1_lmr_req  <=1'b0;
  always @(  posedge   u0_u1_clk          or  posedge  u0_u1_rst )
         if ( u0_u1_rst ) 
             u0_u1_init_req_we  <=1'b0;
          else  
             u0_u1_init_req_we  <= u0_u1_rf_we & u0_u1_sel &! u0_u1_addr_r [2];
  always @(  posedge   u0_u1_clk          or  posedge  u0_u1_rst )
         if ( u0_u1_rst ) 
             u0_u1_init_req  <=1'b0;
          else 
             if ( u0_u1_init_req_we &( u0_u1_csc [3:1]==3'h0)& u0_u1_csc [0]&! u0_u1_inited ) 
                 u0_u1_init_req  <=1'b1;
              else 
                 if ( u0_u1_init_ack ) 
                     u0_u1_init_req  <=1'b0;
  always @(  posedge   u0_u1_clk          or  posedge  u0_u1_rst )
         if ( u0_u1_rst ) 
             u0_u1_inited  <=1'b0;
          else 
             if ( u0_u1_init_ack ) 
                 u0_u1_inited  <=1'b1;
  assign  u0_u1_cs_d =(( u0_u1_csc [23:16]& u0_u1_csc_mask [7:0])==( u0_u1_addr [28:21]& u0_u1_csc_mask [7:0]))& u0_u1_csc [0]; 
  assign  u0_u1_wp = u0_u1_wb_we_i & u0_u1_csc [8]; 
  assign  u0_u1_wp_err = u0_u1_cs_d & u0_u1_wp ; 
  assign  u0_u1_cs = u0_u1_cs_d &! u0_u1_wp ;
    assign u0_u0_clk = u0_clk;
    assign u0_u0_rst = u0_rst;
    assign u0_u0_wb_we_i = u0_wb_we_i;
    assign u0_u0_din = u0_wb_data_i;
    assign u0_u0_rf_we = u0_rf_we;
    assign u0_u0_addr = u0_wb_addr_i;
    assign u0_csc0 = u0_u0_csc;
    assign u0_tms0 = u0_u0_tms;
    assign u0_u0_poc = u0_poc;
    assign u0_u0_csc_mask = u0_csc_mask;
    assign u0_cs0 = u0_u0_cs;
    assign u0_wp_err0 = u0_u0_wp_err;
    assign u0_lmr_req0 = u0_u0_lmr_req;
    assign u0_u0_lmr_ack = u0_lmr_ack0;
    assign u0_init_req0 = u0_u0_init_req;
    assign u0_u0_init_ack = u0_init_ack0;
    assign u0_u1_clk = u0_clk;
    assign u0_u1_rst = u0_rst;
    assign u0_u1_wb_we_i = u0_wb_we_i;
    assign u0_u1_din = u0_wb_data_i;
    assign u0_u1_rf_we = u0_rf_we;
    assign u0_u1_addr = u0_wb_addr_i;
    assign u0_csc1 = u0_u1_csc;
    assign u0_tms1 = u0_u1_tms;
    assign u0_u1_poc = u0_poc;
    assign u0_u1_csc_mask = u0_csc_mask;
    assign u0_cs1 = u0_u1_cs;
    assign u0_wp_err1 = u0_u1_wp_err;
    assign u0_lmr_req1 = u0_u1_lmr_req;
    assign u0_u1_lmr_ack = u0_lmr_ack1;
    assign u0_init_req1 = u0_u1_init_req;
    assign u0_u1_init_ack = u0_init_ack1;
      
    wire u0_u2_clk;
    wire u0_u2_rst;
    wire u0_u2_wb_we_i;
    wire[31:0] u0_u2_din;
    wire u0_u2_rf_we;
    wire[31:0] u0_u2_addr;
    wire[31:0] u0_u2_csc;
    wire[31:0] u0_u2_tms;
    wire[31:0] u0_u2_poc;
    wire[31:0] u0_u2_csc_mask;
    wire u0_u2_cs;
    wire u0_u2_wp_err;
    wire u0_u2_lmr_req;
    wire u0_u2_lmr_ack;
    wire u0_u2_init_req;
    wire u0_u2_init_ack;
    wire u0_u3_clk;
    wire u0_u3_rst;
    wire u0_u3_wb_we_i;
    wire[31:0] u0_u3_din;
    wire u0_u3_rf_we;
    wire[31:0] u0_u3_addr;
    wire[31:0] u0_u3_csc;
    wire[31:0] u0_u3_tms;
    wire[31:0] u0_u3_poc;
    wire[31:0] u0_u3_csc_mask;
    wire u0_u3_cs;
    wire u0_u3_wp_err;
    wire u0_u3_lmr_req;
    wire u0_u3_lmr_ack;
    wire u0_u3_init_req;
    wire u0_u3_init_ack;
    wire u0_u4_clk;
    wire u0_u4_rst;
    wire u0_u4_wb_we_i;
    wire[31:0] u0_u4_din;
    wire u0_u4_rf_we;
    wire[31:0] u0_u4_addr;
    wire[31:0] u0_u4_csc;
    wire[31:0] u0_u4_tms;
    wire[31:0] u0_u4_poc;
    wire[31:0] u0_u4_csc_mask;
    wire u0_u4_cs;
    wire u0_u4_wp_err;
    wire u0_u4_lmr_req;
    wire u0_u4_lmr_ack;
    wire u0_u4_init_req;
    wire u0_u4_init_ack;
    wire u0_u5_clk;
    wire u0_u5_rst;
    wire u0_u5_wb_we_i;
    wire[31:0] u0_u5_din;
    wire u0_u5_rf_we;
    wire[31:0] u0_u5_addr;
    wire[31:0] u0_u5_csc;
    wire[31:0] u0_u5_tms;
    wire[31:0] u0_u5_poc;
    wire[31:0] u0_u5_csc_mask;
    wire u0_u5_cs;
    wire u0_u5_wp_err;
    wire u0_u5_lmr_req;
    wire u0_u5_lmr_ack;
    wire u0_u5_init_req;
    wire u0_u5_init_ack;
    wire u0_u6_clk;
    wire u0_u6_rst;
    wire u0_u6_wb_we_i;
    wire[31:0] u0_u6_din;
    wire u0_u6_rf_we;
    wire[31:0] u0_u6_addr;
    wire[31:0] u0_u6_csc;
    wire[31:0] u0_u6_tms;
    wire[31:0] u0_u6_poc;
    wire[31:0] u0_u6_csc_mask;
    wire u0_u6_cs;
    wire u0_u6_wp_err;
    wire u0_u6_lmr_req;
    wire u0_u6_lmr_ack;
    wire u0_u6_init_req;
    wire u0_u6_init_ack;
    wire u0_u7_clk;
    wire u0_u7_rst;
    wire u0_u7_wb_we_i;
    wire[31:0] u0_u7_din;
    wire u0_u7_rf_we;
    wire[31:0] u0_u7_addr;
    wire[31:0] u0_u7_csc;
    wire[31:0] u0_u7_tms;
    wire[31:0] u0_u7_poc;
    wire[31:0] u0_u7_csc_mask;
    wire u0_u7_cs;
    wire u0_u7_wp_err;
    wire u0_u7_lmr_req;
    wire u0_u7_lmr_ack;
    wire u0_u7_init_req;
    wire u0_u7_init_ack;

    parameter[2:0] u0_u2_this_cs =0; input clk , rst ; input wb_we_i ; input[31:0] din ; input rf_we ; input[31:0] addr ; output[31:0] csc ; output[31:0] tms ; input[31:0] poc ; input[31:0] csc_mask ; output cs ; output wp_err ; output lmr_req ; input lmr_ack ; output init_req ; input init_ack ; 
  assign  u0_u2_csc =32'h0; 
  assign  u0_u2_tms =32'h0; 
  assign  u0_u2_cs =1'b0; 
  assign  u0_u2_wp_err =1'b0; 
  assign  u0_u2_lmr_req =1'b0; 
  assign  u0_u2_init_req =1'b0;
    parameter[2:0] u0_u3_this_cs =0; input clk , rst ; input wb_we_i ; input[31:0] din ; input rf_we ; input[31:0] addr ; output[31:0] csc ; output[31:0] tms ; input[31:0] poc ; input[31:0] csc_mask ; output cs ; output wp_err ; output lmr_req ; input lmr_ack ; output init_req ; input init_ack ; 
  assign  u0_u3_csc =32'h0; 
  assign  u0_u3_tms =32'h0; 
  assign  u0_u3_cs =1'b0; 
  assign  u0_u3_wp_err =1'b0; 
  assign  u0_u3_lmr_req =1'b0; 
  assign  u0_u3_init_req =1'b0;
    parameter[2:0] u0_u4_this_cs =0; input clk , rst ; input wb_we_i ; input[31:0] din ; input rf_we ; input[31:0] addr ; output[31:0] csc ; output[31:0] tms ; input[31:0] poc ; input[31:0] csc_mask ; output cs ; output wp_err ; output lmr_req ; input lmr_ack ; output init_req ; input init_ack ; 
  assign  u0_u4_csc =32'h0; 
  assign  u0_u4_tms =32'h0; 
  assign  u0_u4_cs =1'b0; 
  assign  u0_u4_wp_err =1'b0; 
  assign  u0_u4_lmr_req =1'b0; 
  assign  u0_u4_init_req =1'b0;
    parameter[2:0] u0_u5_this_cs =0; input clk , rst ; input wb_we_i ; input[31:0] din ; input rf_we ; input[31:0] addr ; output[31:0] csc ; output[31:0] tms ; input[31:0] poc ; input[31:0] csc_mask ; output cs ; output wp_err ; output lmr_req ; input lmr_ack ; output init_req ; input init_ack ; 
  assign  u0_u5_csc =32'h0; 
  assign  u0_u5_tms =32'h0; 
  assign  u0_u5_cs =1'b0; 
  assign  u0_u5_wp_err =1'b0; 
  assign  u0_u5_lmr_req =1'b0; 
  assign  u0_u5_init_req =1'b0;
    parameter[2:0] u0_u6_this_cs =0; input clk , rst ; input wb_we_i ; input[31:0] din ; input rf_we ; input[31:0] addr ; output[31:0] csc ; output[31:0] tms ; input[31:0] poc ; input[31:0] csc_mask ; output cs ; output wp_err ; output lmr_req ; input lmr_ack ; output init_req ; input init_ack ; 
  assign  u0_u6_csc =32'h0; 
  assign  u0_u6_tms =32'h0; 
  assign  u0_u6_cs =1'b0; 
  assign  u0_u6_wp_err =1'b0; 
  assign  u0_u6_lmr_req =1'b0; 
  assign  u0_u6_init_req =1'b0;
    parameter[2:0] u0_u7_this_cs =0; input clk , rst ; input wb_we_i ; input[31:0] din ; input rf_we ; input[31:0] addr ; output[31:0] csc ; output[31:0] tms ; input[31:0] poc ; input[31:0] csc_mask ; output cs ; output wp_err ; output lmr_req ; input lmr_ack ; output init_req ; input init_ack ; 
  assign  u0_u7_csc =32'h0; 
  assign  u0_u7_tms =32'h0; 
  assign  u0_u7_cs =1'b0; 
  assign  u0_u7_wp_err =1'b0; 
  assign  u0_u7_lmr_req =1'b0; 
  assign  u0_u7_init_req =1'b0;
    assign u0_u2_clk = u0_clk;
    assign u0_u2_rst = u0_rst;
    assign u0_u2_wb_we_i = u0_wb_we_i;
    assign u0_u2_din = u0_wb_data_i;
    assign u0_u2_rf_we = u0_rf_we;
    assign u0_u2_addr = u0_wb_addr_i;
    assign u0_csc2 = u0_u2_csc;
    assign u0_tms2 = u0_u2_tms;
    assign u0_u2_poc = u0_poc;
    assign u0_u2_csc_mask = u0_csc_mask;
    assign u0_cs2 = u0_u2_cs;
    assign u0_wp_err2 = u0_u2_wp_err;
    assign u0_lmr_req2 = u0_u2_lmr_req;
    assign u0_u2_lmr_ack = u0_lmr_ack2;
    assign u0_init_req2 = u0_u2_init_req;
    assign u0_u2_init_ack = u0_init_ack2;
    assign u0_u3_clk = u0_clk;
    assign u0_u3_rst = u0_rst;
    assign u0_u3_wb_we_i = u0_wb_we_i;
    assign u0_u3_din = u0_wb_data_i;
    assign u0_u3_rf_we = u0_rf_we;
    assign u0_u3_addr = u0_wb_addr_i;
    assign u0_csc3 = u0_u3_csc;
    assign u0_tms3 = u0_u3_tms;
    assign u0_u3_poc = u0_poc;
    assign u0_u3_csc_mask = u0_csc_mask;
    assign u0_cs3 = u0_u3_cs;
    assign u0_wp_err3 = u0_u3_wp_err;
    assign u0_lmr_req3 = u0_u3_lmr_req;
    assign u0_u3_lmr_ack = u0_lmr_ack3;
    assign u0_init_req3 = u0_u3_init_req;
    assign u0_u3_init_ack = u0_init_ack3;
    assign u0_u4_clk = u0_clk;
    assign u0_u4_rst = u0_rst;
    assign u0_u4_wb_we_i = u0_wb_we_i;
    assign u0_u4_din = u0_wb_data_i;
    assign u0_u4_rf_we = u0_rf_we;
    assign u0_u4_addr = u0_wb_addr_i;
    assign u0_csc4 = u0_u4_csc;
    assign u0_tms4 = u0_u4_tms;
    assign u0_u4_poc = u0_poc;
    assign u0_u4_csc_mask = u0_csc_mask;
    assign u0_cs4 = u0_u4_cs;
    assign u0_wp_err4 = u0_u4_wp_err;
    assign u0_lmr_req4 = u0_u4_lmr_req;
    assign u0_u4_lmr_ack = u0_lmr_ack4;
    assign u0_init_req4 = u0_u4_init_req;
    assign u0_u4_init_ack = u0_init_ack4;
    assign u0_u5_clk = u0_clk;
    assign u0_u5_rst = u0_rst;
    assign u0_u5_wb_we_i = u0_wb_we_i;
    assign u0_u5_din = u0_wb_data_i;
    assign u0_u5_rf_we = u0_rf_we;
    assign u0_u5_addr = u0_wb_addr_i;
    assign u0_csc5 = u0_u5_csc;
    assign u0_tms5 = u0_u5_tms;
    assign u0_u5_poc = u0_poc;
    assign u0_u5_csc_mask = u0_csc_mask;
    assign u0_cs5 = u0_u5_cs;
    assign u0_wp_err5 = u0_u5_wp_err;
    assign u0_lmr_req5 = u0_u5_lmr_req;
    assign u0_u5_lmr_ack = u0_lmr_ack5;
    assign u0_init_req5 = u0_u5_init_req;
    assign u0_u5_init_ack = u0_init_ack5;
    assign u0_u6_clk = u0_clk;
    assign u0_u6_rst = u0_rst;
    assign u0_u6_wb_we_i = u0_wb_we_i;
    assign u0_u6_din = u0_wb_data_i;
    assign u0_u6_rf_we = u0_rf_we;
    assign u0_u6_addr = u0_wb_addr_i;
    assign u0_csc6 = u0_u6_csc;
    assign u0_tms6 = u0_u6_tms;
    assign u0_u6_poc = u0_poc;
    assign u0_u6_csc_mask = u0_csc_mask;
    assign u0_cs6 = u0_u6_cs;
    assign u0_wp_err6 = u0_u6_wp_err;
    assign u0_lmr_req6 = u0_u6_lmr_req;
    assign u0_u6_lmr_ack = u0_lmr_ack6;
    assign u0_init_req6 = u0_u6_init_req;
    assign u0_u6_init_ack = u0_init_ack6;
    assign u0_u7_clk = u0_clk;
    assign u0_u7_rst = u0_rst;
    assign u0_u7_wb_we_i = u0_wb_we_i;
    assign u0_u7_din = u0_wb_data_i;
    assign u0_u7_rf_we = u0_rf_we;
    assign u0_u7_addr = u0_wb_addr_i;
    assign u0_csc7 = u0_u7_csc;
    assign u0_tms7 = u0_u7_tms;
    assign u0_u7_poc = u0_poc;
    assign u0_u7_csc_mask = u0_csc_mask;
    assign u0_cs7 = u0_u7_cs;
    assign u0_wp_err7 = u0_u7_wp_err;
    assign u0_lmr_req7 = u0_u7_lmr_req;
    assign u0_u7_lmr_ack = u0_lmr_ack7;
    assign u0_init_req7 = u0_u7_init_req;
    assign u0_u7_init_ack = u0_init_ack7;
    
    assign u0_clk = clk_i;
    assign u0_rst = rst_i;
    assign u0_wb_data_i = wb_data_i;
    assign rf_dout = u0_rf_dout;
    assign u0_wb_addr_i = wb_addr_i;
    assign u0_wb_we_i = wb_we_i;
    assign u0_wb_cyc_i = wb_cyc_i;
    assign u0_wb_stb_i = wb_stb_i;
    assign wp_err = u0_wp_err;
    assign csc = u0_csc;
    assign tms = u0_tms;
    assign poc_o = u0_poc;
    assign sp_csc = u0_sp_csc;
    assign sp_tms = u0_sp_tms;
    assign cs = u0_cs;
    assign u0_mc_data_i = mc_data_ir[31:0];
    assign u0_mc_sts = mc_sts_ir;
    assign mc_vpen_pad_o = u0_mc_vpen;
    assign fs = u0_fs;
    assign u0_cs_le_d = cs_le_d;
    assign u0_cs_le = cs_le;
    assign cs_need_rfr = u0_cs_need_rfr;
    assign ref_int = u0_ref_int;
    assign rfr_ps_val = u0_rfr_ps_val;
    assign init_req = u0_init_req;
    assign u0_init_ack = init_ack;
    assign lmr_req = u0_lmr_req;
    assign u0_lmr_ack = lmr_ack;
    assign spec_req_cs = u0_spec_req_cs;
    

wire u1_clk;
    wire[31:0] u1_csc;
    wire[31:0] u1_tms;
    wire u1_wb_ack_o;
    wire u1_wb_stb_i;
    wire[31:0] u1_wb_addr_i;
    wire u1_wb_we_i;
    wire u1_wb_write_go;
    wire u1_wr_hold;
    wire u1_cas_;
    wire[23:0] u1_mc_addr;
    wire[12:0] u1_row_adr;
    wire[1:0] u1_bank_adr;
    wire u1_rfr_ack;
    wire u1_cs_le;
    wire u1_cmd_a10;
    wire u1_row_sel;
    wire u1_lmr_sel;
    wire u1_next_adr;
    wire u1_wr_cycle;
    wire[10:0] u1_page_size;

    reg[23:0] u1_mc_addr_d ; reg[23:0] u1_acs_addr ; 
    wire[23:0] u1_acs_addr_pl1 ; reg[23:0] u1_sram_addr ; 
    wire[14:0] u1_sdram_adr ; reg[12:0] u1_row_adr ; reg[9:0] u1_col_adr ; reg[1:0] u1_bank_adr ; reg[10:0] u1_page_size ; 
    wire[2:0] u1_mem_type ; 
    wire[1:0] u1_bus_width ; 
    wire[1:0] u1_mem_size ; 
    wire u1_bas ; 
  assign  u1_mem_type = u1_csc [3:1]; 
  assign  u1_bus_width = u1_csc [5:4]; 
  assign  u1_mem_size = u1_csc [7:6]; 
  assign  u1_bas = u1_csc [9]; 
  always @(       u1_mem_type                    or   u1_wr_hold              or   u1_sdram_adr             or   u1_acs_addr            or   u1_sram_addr           or   u1_wb_addr_i  )
         if ( u1_mem_type ==3'h0) 
             u1_mc_addr_d  ={9'h0, u1_sdram_adr };
          else 
             if ( u1_mem_type ==3'h2) 
                 u1_mc_addr_d  = u1_acs_addr ;
              else 
                 if (( u1_mem_type ==3'h1)& u1_wr_hold ) 
                     u1_mc_addr_d  = u1_sram_addr ;
                  else  
                     u1_mc_addr_d  = u1_wb_addr_i [25:2];
  assign  u1_mc_addr = u1_rfr_ack  ? { u1_mc_addr_d [23:11],1'b1, u1_mc_addr_d [9:0]}: u1_mc_addr_d ;  
    wire u1_u0_clk;
    wire[u1_u0_incN_width-1:0] u1_u0_inc_in;
    wire[u1_u0_incN_width-1:0] u1_u0_inc_out;

    parameter u1_u0_incN_width =32; input clk ; input[ u1_u0_incN_width -1:0] inc_in ; output[ u1_u0_incN_width -1:0] inc_out ; parameter u1_u0_incN_center = u1_u0_incN_width /2; reg[ u1_u0_incN_center :0] u1_u0_out_r ; 
    wire[31:0] u1_u0_tmp_zeros =32'h0; 
    wire[ u1_u0_incN_center -1:0] u1_u0_inc_next ; 
  always @( posedge  u1_u0_clk ) 
         u1_u0_out_r  <={1'b0, u1_u0_inc_in [ u1_u0_incN_center -1:0]}+{1'b0, u1_u0_tmp_zeros [ u1_u0_incN_center -2:0],1'h1};
  assign  u1_u0_inc_out ={ u1_u0_inc_in [ u1_u0_incN_width -1: u1_u0_incN_center ]+ u1_u0_inc_next , u1_u0_out_r }; 
  assign  u1_u0_inc_next = u1_u0_out_r [ u1_u0_incN_center ] ? { u1_u0_tmp_zeros [ u1_u0_incN_center -2:0],1'h1}: u1_u0_tmp_zeros [ u1_u0_incN_center -2:0];
    assign u1_u0_clk = u1_clk;
    assign u1_u0_inc_in = u1_acs_addr;
    assign u1_acs_addr_pl1 = u1_u0_inc_out;
     
  always @( posedge  u1_clk )
         if ( u1_wb_stb_i ) 
             u1_sram_addr  <= u1_wb_addr_i [25:2];
  always @( posedge  u1_clk )
         if ( u1_cs_le | u1_wb_we_i )
             case ( u1_bus_width )
              2 'h0: 
                  u1_acs_addr  <= u1_wb_addr_i [23:0];
              2 'h1: 
                  u1_acs_addr  <= u1_wb_addr_i [24:1];
              2 'h2: 
                  u1_acs_addr  <= u1_wb_addr_i [25:2];endcase
          else 
             if ( u1_next_adr ) 
                 u1_acs_addr  <= u1_acs_addr_pl1 ;
  assign  u1_sdram_adr ={ u1_bank_adr ,( u1_lmr_sel &! u1_cas_ ) ?  u1_tms [12:0]: u1_row_sel  ?  u1_row_adr :{2'h0, u1_cmd_a10 , u1_col_adr }}; 
  always @( posedge  u1_clk )
         if ( u1_wr_cycle  ?  u1_wb_ack_o : u1_wb_stb_i )
             casex ({ u1_bus_width , u1_mem_size })
              { 2'h0,2'h0}: 
                  u1_col_adr  <={1'h0, u1_wb_addr_i [10:2]};
              { 2'h0,2'h1}: 
                  u1_col_adr  <= u1_wb_addr_i [11:2];
              { 2'h0,2'h2}: 
                  u1_col_adr  <= u1_wb_addr_i [11:2];
              { 2'h1,2'h0}: 
                  u1_col_adr  <={2'h0, u1_wb_addr_i [09:2]};
              { 2'h1,2'h1}: 
                  u1_col_adr  <={1'h0, u1_wb_addr_i [10:2]};
              { 2'h1,2'h2}: 
                  u1_col_adr  <={1'h0, u1_wb_addr_i [10:2]};
              { 2'h2,2'h0}: 
                  u1_col_adr  <={2'h0, u1_wb_addr_i [09:2]};
              { 2'h2,2'h1}: 
                  u1_col_adr  <={2'h0, u1_wb_addr_i [09:2]};
              { 2'h2,2'h2}: 
                  u1_col_adr  <={2'h0, u1_wb_addr_i [09:2]};endcase
  always @( posedge  u1_clk )
         if ( u1_cs_le )
             begin 
                 if (! u1_bas )
                     casex ({ u1_bus_width , u1_mem_size })
                      { 2'h0,2'h0}: 
                          u1_row_adr  <={1'h0, u1_wb_addr_i [24:13]};
                      { 2'h0,2'h1}: 
                          u1_row_adr  <={1'h0, u1_wb_addr_i [25:14]};
                      { 2'h0,2'h2}: 
                          u1_row_adr  <= u1_wb_addr_i [26:14];
                      { 2'h1,2'h0}: 
                          u1_row_adr  <={1'h0, u1_wb_addr_i [23:12]};
                      { 2'h1,2'h1}: 
                          u1_row_adr  <={1'h0, u1_wb_addr_i [24:13]};
                      { 2'h1,2'h2}: 
                          u1_row_adr  <= u1_wb_addr_i [25:13];
                      { 2'h2,2'h0}: 
                          u1_row_adr  <={2'h0, u1_wb_addr_i [22:12]};
                      { 2'h2,2'h1}: 
                          u1_row_adr  <={1'h0, u1_wb_addr_i [23:12]};
                      { 2'h2,2'h2}: 
                          u1_row_adr  <= u1_wb_addr_i [24:12];endcase
                  else 
                     casex ({ u1_bus_width , u1_mem_size })
                      { 2'h0,2'h0}: 
                          u1_row_adr  <={1'h0, u1_wb_addr_i [22:11]};
                      { 2'h0,2'h1}: 
                          u1_row_adr  <={1'h0, u1_wb_addr_i [23:12]};
                      { 2'h0,2'h2}: 
                          u1_row_adr  <= u1_wb_addr_i [24:12];
                      { 2'h1,2'h0}: 
                          u1_row_adr  <={1'h0, u1_wb_addr_i [21:10]};
                      { 2'h1,2'h1}: 
                          u1_row_adr  <={1'h0, u1_wb_addr_i [22:11]};
                      { 2'h1,2'h2}: 
                          u1_row_adr  <= u1_wb_addr_i [23:11];
                      { 2'h2,2'h0}: 
                          u1_row_adr  <={2'h0, u1_wb_addr_i [20:10]};
                      { 2'h2,2'h1}: 
                          u1_row_adr  <={1'h0, u1_wb_addr_i [21:10]};
                      { 2'h2,2'h2}: 
                          u1_row_adr  <= u1_wb_addr_i [22:10];endcase
             end
  always @( posedge  u1_clk )
         if ( u1_cs_le )
             begin 
                 if (! u1_bas )
                     casex ({ u1_bus_width , u1_mem_size })
                      { 2'h0,2'h0}: 
                          u1_bank_adr  <= u1_wb_addr_i [12:11];
                      { 2'h0,2'h1}: 
                          u1_bank_adr  <= u1_wb_addr_i [13:12];
                      { 2'h0,2'h2}: 
                          u1_bank_adr  <= u1_wb_addr_i [13:12];
                      { 2'h1,2'h0}: 
                          u1_bank_adr  <= u1_wb_addr_i [11:10];
                      { 2'h1,2'h1}: 
                          u1_bank_adr  <= u1_wb_addr_i [12:11];
                      { 2'h1,2'h2}: 
                          u1_bank_adr  <= u1_wb_addr_i [12:11];
                      { 2'h2,2'h0}: 
                          u1_bank_adr  <= u1_wb_addr_i [11:10];
                      { 2'h2,2'h1}: 
                          u1_bank_adr  <= u1_wb_addr_i [11:10];
                      { 2'h2,2'h2}: 
                          u1_bank_adr  <= u1_wb_addr_i [11:10];endcase
                  else 
                     casex ({ u1_bus_width , u1_mem_size })
                      { 2'h0,2'h0}: 
                          u1_bank_adr  <= u1_wb_addr_i [24:23];
                      { 2'h0,2'h1}: 
                          u1_bank_adr  <= u1_wb_addr_i [25:24];
                      { 2'h0,2'h2}: 
                          u1_bank_adr  <= u1_wb_addr_i [26:25];
                      { 2'h1,2'h0}: 
                          u1_bank_adr  <= u1_wb_addr_i [23:22];
                      { 2'h1,2'h1}: 
                          u1_bank_adr  <= u1_wb_addr_i [24:23];
                      { 2'h1,2'h2}: 
                          u1_bank_adr  <= u1_wb_addr_i [25:24];
                      { 2'h2,2'h0}: 
                          u1_bank_adr  <= u1_wb_addr_i [22:21];
                      { 2'h2,2'h1}: 
                          u1_bank_adr  <= u1_wb_addr_i [23:22];
                      { 2'h2,2'h2}: 
                          u1_bank_adr  <= u1_wb_addr_i [24:23];endcase
             end
  always @(   u1_bus_width            or   u1_mem_size  )
         casex ({ u1_bus_width , u1_mem_size })
          { 2'h0,2'h0}: 
              u1_page_size  =11'd512;
          { 2'h0,2'h1}: 
              u1_page_size  =11'd1024;
          { 2'h0,2'h2}: 
              u1_page_size  =11'd1024;
          { 2'h1,2'h0}: 
              u1_page_size  =11'd256;
          { 2'h1,2'h1}: 
              u1_page_size  =11'd512;
          { 2'h1,2'h2}: 
              u1_page_size  =11'd512;
          { 2'h2,2'h0}: 
              u1_page_size  =11'd256;
          { 2'h2,2'h1}: 
              u1_page_size  =11'd256;
          { 2'h2,2'h2}: 
              u1_page_size  =11'd256;endcase

    assign u1_clk = clk_i;
    assign u1_csc = csc_s;
    assign u1_tms = tms_s;
    assign u1_wb_ack_o = mem_ack_r;
    assign u1_wb_stb_i = wb_stb_i;
    assign u1_wb_addr_i = wb_addr_i;
    assign u1_wb_we_i = wb_we_i;
    assign u1_wb_write_go = wb_write_go;
    assign u1_wr_hold = wr_hold;
    assign u1_cas_ = cas_;
    assign mc_addr_d = u1_mc_addr;
    assign row_adr = u1_row_adr;
    assign bank_adr = u1_bank_adr;
    assign u1_rfr_ack = rfr_ack;
    assign u1_cs_le = cs_le;
    assign u1_cmd_a10 = cmd_a10;
    assign u1_row_sel = row_sel;
    assign u1_lmr_sel = lmr_sel;
    assign u1_next_adr = next_adr;
    assign u1_wr_cycle = wr_cycle;
    assign page_size = u1_page_size;
    

wire u2_clk;
    wire u2_rst;
    wire[7:0] u2_cs;
    wire[12:0] u2_row_adr;
    wire[1:0] u2_bank_adr;
    wire u2_bank_set;
    wire u2_bank_clr;
    wire u2_bank_clr_all;
    wire u2_bank_open;
    wire u2_any_bank_open;
    wire u2_row_same;
    wire u2_rfr_ack;

    reg u2_bank_open ; 
    reg u2_row_same ; 
    reg u2_any_bank_open ; 
    wire u2_bank_set_0 ; 
    wire u2_bank_clr_0 ; 
    wire u2_bank_clr_all_0 ; 
    wire u2_bank_open_0 ; 
    wire u2_row_same_0 ; 
    wire u2_any_bank_open_0 ; 
    wire u2_bank_set_1 ; 
    wire u2_bank_clr_1 ; 
    wire u2_bank_clr_all_1 ; 
    wire u2_bank_open_1 ; 
    wire u2_row_same_1 ; 
    wire u2_any_bank_open_1 ; 
    wire u2_bank_set_2 ; 
    wire u2_bank_clr_2 ; 
    wire u2_bank_clr_all_2 ; 
    wire u2_bank_open_2 ; 
    wire u2_row_same_2 ; 
    wire u2_any_bank_open_2 ; 
    wire u2_bank_set_3 ; 
    wire u2_bank_clr_3 ; 
    wire u2_bank_clr_all_3 ; 
    wire u2_bank_open_3 ; 
    wire u2_row_same_3 ; 
    wire u2_any_bank_open_3 ; 
    wire u2_bank_set_4 ; 
    wire u2_bank_clr_4 ; 
    wire u2_bank_clr_all_4 ; 
    wire u2_bank_open_4 ; 
    wire u2_row_same_4 ; 
    wire u2_any_bank_open_4 ; 
    wire u2_bank_set_5 ; 
    wire u2_bank_clr_5 ; 
    wire u2_bank_clr_all_5 ; 
    wire u2_bank_open_5 ; 
    wire u2_row_same_5 ; 
    wire u2_any_bank_open_5 ; 
    wire u2_bank_set_6 ; 
    wire u2_bank_clr_6 ; 
    wire u2_bank_clr_all_6 ; 
    wire u2_bank_open_6 ; 
    wire u2_row_same_6 ; 
    wire u2_any_bank_open_6 ; 
    wire u2_bank_set_7 ; 
    wire u2_bank_clr_7 ; 
    wire u2_bank_clr_all_7 ; 
    wire u2_bank_open_7 ; 
    wire u2_row_same_7 ; 
    wire u2_any_bank_open_7 ; 
  assign  u2_bank_set_0 = u2_cs [0]& u2_bank_set ; 
  assign  u2_bank_set_1 = u2_cs [1]& u2_bank_set ; 
  assign  u2_bank_set_2 = u2_cs [2]& u2_bank_set ; 
  assign  u2_bank_set_3 = u2_cs [3]& u2_bank_set ; 
  assign  u2_bank_set_4 = u2_cs [4]& u2_bank_set ; 
  assign  u2_bank_set_5 = u2_cs [5]& u2_bank_set ; 
  assign  u2_bank_set_6 = u2_cs [6]& u2_bank_set ; 
  assign  u2_bank_set_7 = u2_cs [7]& u2_bank_set ; 
  assign  u2_bank_clr_0 = u2_cs [0]& u2_bank_clr ; 
  assign  u2_bank_clr_1 = u2_cs [1]& u2_bank_clr ; 
  assign  u2_bank_clr_2 = u2_cs [2]& u2_bank_clr ; 
  assign  u2_bank_clr_3 = u2_cs [3]& u2_bank_clr ; 
  assign  u2_bank_clr_4 = u2_cs [4]& u2_bank_clr ; 
  assign  u2_bank_clr_5 = u2_cs [5]& u2_bank_clr ; 
  assign  u2_bank_clr_6 = u2_cs [6]& u2_bank_clr ; 
  assign  u2_bank_clr_7 = u2_cs [7]& u2_bank_clr ; 
  assign  u2_bank_clr_all_0 =( u2_cs [0]& u2_bank_clr_all )| u2_rfr_ack ; 
  assign  u2_bank_clr_all_1 =( u2_cs [1]& u2_bank_clr_all )| u2_rfr_ack ; 
  assign  u2_bank_clr_all_2 =( u2_cs [2]& u2_bank_clr_all )| u2_rfr_ack ; 
  assign  u2_bank_clr_all_3 =( u2_cs [3]& u2_bank_clr_all )| u2_rfr_ack ; 
  assign  u2_bank_clr_all_4 =( u2_cs [4]& u2_bank_clr_all )| u2_rfr_ack ; 
  assign  u2_bank_clr_all_5 =( u2_cs [5]& u2_bank_clr_all )| u2_rfr_ack ; 
  assign  u2_bank_clr_all_6 =( u2_cs [6]& u2_bank_clr_all )| u2_rfr_ack ; 
  assign  u2_bank_clr_all_7 =( u2_cs [7]& u2_bank_clr_all )| u2_rfr_ack ; 
  always @( posedge  u2_clk ) 
         u2_bank_open  <=#1( u2_cs [0]& u2_bank_open_0 )|( u2_cs [1]& u2_bank_open_1 )|( u2_cs [2]& u2_bank_open_2 )|( u2_cs [3]& u2_bank_open_3 )|( u2_cs [4]& u2_bank_open_4 )|( u2_cs [5]& u2_bank_open_5 )|( u2_cs [6]& u2_bank_open_6 )|( u2_cs [7]& u2_bank_open_7 );
  always @( posedge  u2_clk ) 
         u2_row_same  <=#1( u2_cs [0]& u2_row_same_0 )|( u2_cs [1]& u2_row_same_1 )|( u2_cs [2]& u2_row_same_2 )|( u2_cs [3]& u2_row_same_3 )|( u2_cs [4]& u2_row_same_4 )|( u2_cs [5]& u2_row_same_5 )|( u2_cs [6]& u2_row_same_6 )|( u2_cs [7]& u2_row_same_7 );
  always @( posedge  u2_clk ) 
         u2_any_bank_open  <=#1( u2_cs [0]& u2_any_bank_open_0 )|( u2_cs [1]& u2_any_bank_open_1 )|( u2_cs [2]& u2_any_bank_open_2 )|( u2_cs [3]& u2_any_bank_open_3 )|( u2_cs [4]& u2_any_bank_open_4 )|( u2_cs [5]& u2_any_bank_open_5 )|( u2_cs [6]& u2_any_bank_open_6 )|( u2_cs [7]& u2_any_bank_open_7 );
    wire u2_u0_clk;
    wire u2_u0_rst;
    wire[12:0] u2_u0_row_adr;
    wire[1:0] u2_u0_bank_adr;
    wire u2_u0_bank_set;
    wire u2_u0_bank_clr;
    wire u2_u0_bank_clr_all;
    wire u2_u0_bank_open;
    wire u2_u0_any_bank_open;
    wire u2_u0_row_same;
    wire u2_u1_clk;
    wire u2_u1_rst;
    wire[12:0] u2_u1_row_adr;
    wire[1:0] u2_u1_bank_adr;
    wire u2_u1_bank_set;
    wire u2_u1_bank_clr;
    wire u2_u1_bank_clr_all;
    wire u2_u1_bank_open;
    wire u2_u1_any_bank_open;
    wire u2_u1_row_same;

    reg u2_u0_bank0_open , u2_u0_bank1_open , u2_u0_bank2_open , u2_u0_bank3_open ; 
    reg u2_u0_bank_open ; reg[12:0] u2_u0_b0_last_row ; reg[12:0] u2_u0_b1_last_row ; reg[12:0] u2_u0_b2_last_row ; reg[12:0] u2_u0_b3_last_row ; 
    wire u2_u0_row0_same , u2_u0_row1_same , u2_u0_row2_same , u2_u0_row3_same ; 
    reg u2_u0_row_same ; 
  always @(  posedge   u2_u0_clk          or  posedge  u2_u0_rst )
         if ( u2_u0_rst ) 
             u2_u0_bank0_open  <=1'b0;
          else 
             if (( u2_u0_bank_adr ==2'h0)& u2_u0_bank_set ) 
                 u2_u0_bank0_open  <=1'b1;
              else 
                 if (( u2_u0_bank_adr ==2'h0)& u2_u0_bank_clr ) 
                     u2_u0_bank0_open  <=1'b0;
                  else 
                     if ( u2_u0_bank_clr_all ) 
                         u2_u0_bank0_open  <=1'b0;
  always @(  posedge   u2_u0_clk          or  posedge  u2_u0_rst )
         if ( u2_u0_rst ) 
             u2_u0_bank1_open  <=1'b0;
          else 
             if (( u2_u0_bank_adr ==2'h1)& u2_u0_bank_set ) 
                 u2_u0_bank1_open  <=1'b1;
              else 
                 if (( u2_u0_bank_adr ==2'h1)& u2_u0_bank_clr ) 
                     u2_u0_bank1_open  <=1'b0;
                  else 
                     if ( u2_u0_bank_clr_all ) 
                         u2_u0_bank1_open  <=1'b0;
  always @(  posedge   u2_u0_clk          or  posedge  u2_u0_rst )
         if ( u2_u0_rst ) 
             u2_u0_bank2_open  <=1'b0;
          else 
             if (( u2_u0_bank_adr ==2'h2)& u2_u0_bank_set ) 
                 u2_u0_bank2_open  <=1'b1;
              else 
                 if (( u2_u0_bank_adr ==2'h2)& u2_u0_bank_clr ) 
                     u2_u0_bank2_open  <=1'b0;
                  else 
                     if ( u2_u0_bank_clr_all ) 
                         u2_u0_bank2_open  <=1'b0;
  always @(  posedge   u2_u0_clk          or  posedge  u2_u0_rst )
         if ( u2_u0_rst ) 
             u2_u0_bank3_open  <=1'b0;
          else 
             if (( u2_u0_bank_adr ==2'h3)& u2_u0_bank_set ) 
                 u2_u0_bank3_open  <=1'b1;
              else 
                 if (( u2_u0_bank_adr ==2'h3)& u2_u0_bank_clr ) 
                     u2_u0_bank3_open  <=1'b0;
                  else 
                     if ( u2_u0_bank_clr_all ) 
                         u2_u0_bank3_open  <=1'b0;
  always @(      u2_u0_bank_adr                  or   u2_u0_bank0_open             or   u2_u0_bank1_open            or   u2_u0_bank2_open           or   u2_u0_bank3_open  )
         case ( u2_u0_bank_adr )
          2 'h0: 
              u2_u0_bank_open  = u2_u0_bank0_open ;
          2 'h1: 
              u2_u0_bank_open  = u2_u0_bank1_open ;
          2 'h2: 
              u2_u0_bank_open  = u2_u0_bank2_open ;
          2 'h3: 
              u2_u0_bank_open  = u2_u0_bank3_open ;endcase
  assign  u2_u0_any_bank_open = u2_u0_bank0_open | u2_u0_bank1_open | u2_u0_bank2_open | u2_u0_bank3_open ; 
  always @( posedge  u2_u0_clk )
         if (( u2_u0_bank_adr ==2'h0)& u2_u0_bank_set ) 
             u2_u0_b0_last_row  <= u2_u0_row_adr ;
  always @( posedge  u2_u0_clk )
         if (( u2_u0_bank_adr ==2'h1)& u2_u0_bank_set ) 
             u2_u0_b1_last_row  <= u2_u0_row_adr ;
  always @( posedge  u2_u0_clk )
         if (( u2_u0_bank_adr ==2'h2)& u2_u0_bank_set ) 
             u2_u0_b2_last_row  <= u2_u0_row_adr ;
  always @( posedge  u2_u0_clk )
         if (( u2_u0_bank_adr ==2'h3)& u2_u0_bank_set ) 
             u2_u0_b3_last_row  <= u2_u0_row_adr ;
  assign  u2_u0_row0_same =( u2_u0_b0_last_row == u2_u0_row_adr ); 
  assign  u2_u0_row1_same =( u2_u0_b1_last_row == u2_u0_row_adr ); 
  assign  u2_u0_row2_same =( u2_u0_b2_last_row == u2_u0_row_adr ); 
  assign  u2_u0_row3_same =( u2_u0_b3_last_row == u2_u0_row_adr ); 
  always @(      u2_u0_bank_adr                  or   u2_u0_row0_same             or   u2_u0_row1_same            or   u2_u0_row2_same           or   u2_u0_row3_same  )
         case ( u2_u0_bank_adr )
          2 'h0: 
              u2_u0_row_same  = u2_u0_row0_same ;
          2 'h1: 
              u2_u0_row_same  = u2_u0_row1_same ;
          2 'h2: 
              u2_u0_row_same  = u2_u0_row2_same ;
          2 'h3: 
              u2_u0_row_same  = u2_u0_row3_same ;endcase

    reg u2_u1_bank0_open , u2_u1_bank1_open , u2_u1_bank2_open , u2_u1_bank3_open ; 
    reg u2_u1_bank_open ; reg[12:0] u2_u1_b0_last_row ; reg[12:0] u2_u1_b1_last_row ; reg[12:0] u2_u1_b2_last_row ; reg[12:0] u2_u1_b3_last_row ; 
    wire u2_u1_row0_same , u2_u1_row1_same , u2_u1_row2_same , u2_u1_row3_same ; 
    reg u2_u1_row_same ; 
  always @(  posedge   u2_u1_clk          or  posedge  u2_u1_rst )
         if ( u2_u1_rst ) 
             u2_u1_bank0_open  <=1'b0;
          else 
             if (( u2_u1_bank_adr ==2'h0)& u2_u1_bank_set ) 
                 u2_u1_bank0_open  <=1'b1;
              else 
                 if (( u2_u1_bank_adr ==2'h0)& u2_u1_bank_clr ) 
                     u2_u1_bank0_open  <=1'b0;
                  else 
                     if ( u2_u1_bank_clr_all ) 
                         u2_u1_bank0_open  <=1'b0;
  always @(  posedge   u2_u1_clk          or  posedge  u2_u1_rst )
         if ( u2_u1_rst ) 
             u2_u1_bank1_open  <=1'b0;
          else 
             if (( u2_u1_bank_adr ==2'h1)& u2_u1_bank_set ) 
                 u2_u1_bank1_open  <=1'b1;
              else 
                 if (( u2_u1_bank_adr ==2'h1)& u2_u1_bank_clr ) 
                     u2_u1_bank1_open  <=1'b0;
                  else 
                     if ( u2_u1_bank_clr_all ) 
                         u2_u1_bank1_open  <=1'b0;
  always @(  posedge   u2_u1_clk          or  posedge  u2_u1_rst )
         if ( u2_u1_rst ) 
             u2_u1_bank2_open  <=1'b0;
          else 
             if (( u2_u1_bank_adr ==2'h2)& u2_u1_bank_set ) 
                 u2_u1_bank2_open  <=1'b1;
              else 
                 if (( u2_u1_bank_adr ==2'h2)& u2_u1_bank_clr ) 
                     u2_u1_bank2_open  <=1'b0;
                  else 
                     if ( u2_u1_bank_clr_all ) 
                         u2_u1_bank2_open  <=1'b0;
  always @(  posedge   u2_u1_clk          or  posedge  u2_u1_rst )
         if ( u2_u1_rst ) 
             u2_u1_bank3_open  <=1'b0;
          else 
             if (( u2_u1_bank_adr ==2'h3)& u2_u1_bank_set ) 
                 u2_u1_bank3_open  <=1'b1;
              else 
                 if (( u2_u1_bank_adr ==2'h3)& u2_u1_bank_clr ) 
                     u2_u1_bank3_open  <=1'b0;
                  else 
                     if ( u2_u1_bank_clr_all ) 
                         u2_u1_bank3_open  <=1'b0;
  always @(      u2_u1_bank_adr                  or   u2_u1_bank0_open             or   u2_u1_bank1_open            or   u2_u1_bank2_open           or   u2_u1_bank3_open  )
         case ( u2_u1_bank_adr )
          2 'h0: 
              u2_u1_bank_open  = u2_u1_bank0_open ;
          2 'h1: 
              u2_u1_bank_open  = u2_u1_bank1_open ;
          2 'h2: 
              u2_u1_bank_open  = u2_u1_bank2_open ;
          2 'h3: 
              u2_u1_bank_open  = u2_u1_bank3_open ;endcase
  assign  u2_u1_any_bank_open = u2_u1_bank0_open | u2_u1_bank1_open | u2_u1_bank2_open | u2_u1_bank3_open ; 
  always @( posedge  u2_u1_clk )
         if (( u2_u1_bank_adr ==2'h0)& u2_u1_bank_set ) 
             u2_u1_b0_last_row  <= u2_u1_row_adr ;
  always @( posedge  u2_u1_clk )
         if (( u2_u1_bank_adr ==2'h1)& u2_u1_bank_set ) 
             u2_u1_b1_last_row  <= u2_u1_row_adr ;
  always @( posedge  u2_u1_clk )
         if (( u2_u1_bank_adr ==2'h2)& u2_u1_bank_set ) 
             u2_u1_b2_last_row  <= u2_u1_row_adr ;
  always @( posedge  u2_u1_clk )
         if (( u2_u1_bank_adr ==2'h3)& u2_u1_bank_set ) 
             u2_u1_b3_last_row  <= u2_u1_row_adr ;
  assign  u2_u1_row0_same =( u2_u1_b0_last_row == u2_u1_row_adr ); 
  assign  u2_u1_row1_same =( u2_u1_b1_last_row == u2_u1_row_adr ); 
  assign  u2_u1_row2_same =( u2_u1_b2_last_row == u2_u1_row_adr ); 
  assign  u2_u1_row3_same =( u2_u1_b3_last_row == u2_u1_row_adr ); 
  always @(      u2_u1_bank_adr                  or   u2_u1_row0_same             or   u2_u1_row1_same            or   u2_u1_row2_same           or   u2_u1_row3_same  )
         case ( u2_u1_bank_adr )
          2 'h0: 
              u2_u1_row_same  = u2_u1_row0_same ;
          2 'h1: 
              u2_u1_row_same  = u2_u1_row1_same ;
          2 'h2: 
              u2_u1_row_same  = u2_u1_row2_same ;
          2 'h3: 
              u2_u1_row_same  = u2_u1_row3_same ;endcase

    assign u2_u0_clk = u2_clk;
    assign u2_u0_rst = u2_rst;
    assign u2_u0_row_adr = u2_row_adr;
    assign u2_u0_bank_adr = u2_bank_adr;
    assign u2_u0_bank_set = u2_bank_set_0;
    assign u2_u0_bank_clr = u2_bank_clr_0;
    assign u2_u0_bank_clr_all = u2_bank_clr_all_0;
    assign u2_bank_open_0 = u2_u0_bank_open;
    assign u2_any_bank_open_0 = u2_u0_any_bank_open;
    assign u2_row_same_0 = u2_u0_row_same;
    assign u2_u1_clk = u2_clk;
    assign u2_u1_rst = u2_rst;
    assign u2_u1_row_adr = u2_row_adr;
    assign u2_u1_bank_adr = u2_bank_adr;
    assign u2_u1_bank_set = u2_bank_set_1;
    assign u2_u1_bank_clr = u2_bank_clr_1;
    assign u2_u1_bank_clr_all = u2_bank_clr_all_1;
    assign u2_bank_open_1 = u2_u1_bank_open;
    assign u2_any_bank_open_1 = u2_u1_any_bank_open;
    assign u2_row_same_1 = u2_u1_row_same;
      
    wire u2_u2_clk;
    wire u2_u2_rst;
    wire[12:0] u2_u2_row_adr;
    wire[1:0] u2_u2_bank_adr;
    wire u2_u2_bank_set;
    wire u2_u2_bank_clr;
    wire u2_u2_bank_clr_all;
    wire u2_u2_bank_open;
    wire u2_u2_any_bank_open;
    wire u2_u2_row_same;
    wire u2_u3_clk;
    wire u2_u3_rst;
    wire[12:0] u2_u3_row_adr;
    wire[1:0] u2_u3_bank_adr;
    wire u2_u3_bank_set;
    wire u2_u3_bank_clr;
    wire u2_u3_bank_clr_all;
    wire u2_u3_bank_open;
    wire u2_u3_any_bank_open;
    wire u2_u3_row_same;
    wire u2_u4_clk;
    wire u2_u4_rst;
    wire[12:0] u2_u4_row_adr;
    wire[1:0] u2_u4_bank_adr;
    wire u2_u4_bank_set;
    wire u2_u4_bank_clr;
    wire u2_u4_bank_clr_all;
    wire u2_u4_bank_open;
    wire u2_u4_any_bank_open;
    wire u2_u4_row_same;
    wire u2_u5_clk;
    wire u2_u5_rst;
    wire[12:0] u2_u5_row_adr;
    wire[1:0] u2_u5_bank_adr;
    wire u2_u5_bank_set;
    wire u2_u5_bank_clr;
    wire u2_u5_bank_clr_all;
    wire u2_u5_bank_open;
    wire u2_u5_any_bank_open;
    wire u2_u5_row_same;
    wire u2_u6_clk;
    wire u2_u6_rst;
    wire[12:0] u2_u6_row_adr;
    wire[1:0] u2_u6_bank_adr;
    wire u2_u6_bank_set;
    wire u2_u6_bank_clr;
    wire u2_u6_bank_clr_all;
    wire u2_u6_bank_open;
    wire u2_u6_any_bank_open;
    wire u2_u6_row_same;
    wire u2_u7_clk;
    wire u2_u7_rst;
    wire[12:0] u2_u7_row_adr;
    wire[1:0] u2_u7_bank_adr;
    wire u2_u7_bank_set;
    wire u2_u7_bank_clr;
    wire u2_u7_bank_clr_all;
    wire u2_u7_bank_open;
    wire u2_u7_any_bank_open;
    wire u2_u7_row_same;

    assign  u2_u2_bank_open =1'b0; 
  assign  u2_u2_any_bank_open =1'b0; 
  assign  u2_u2_row_same =1'b0;
    assign  u2_u3_bank_open =1'b0; 
  assign  u2_u3_any_bank_open =1'b0; 
  assign  u2_u3_row_same =1'b0;
    assign  u2_u4_bank_open =1'b0; 
  assign  u2_u4_any_bank_open =1'b0; 
  assign  u2_u4_row_same =1'b0;
    assign  u2_u5_bank_open =1'b0; 
  assign  u2_u5_any_bank_open =1'b0; 
  assign  u2_u5_row_same =1'b0;
    assign  u2_u6_bank_open =1'b0; 
  assign  u2_u6_any_bank_open =1'b0; 
  assign  u2_u6_row_same =1'b0;
    assign  u2_u7_bank_open =1'b0; 
  assign  u2_u7_any_bank_open =1'b0; 
  assign  u2_u7_row_same =1'b0;
    assign u2_u2_clk = u2_clk;
    assign u2_u2_rst = u2_rst;
    assign u2_u2_row_adr = u2_row_adr;
    assign u2_u2_bank_adr = u2_bank_adr;
    assign u2_u2_bank_set = u2_bank_set_2;
    assign u2_u2_bank_clr = u2_bank_clr_2;
    assign u2_u2_bank_clr_all = u2_bank_clr_all_2;
    assign u2_bank_open_2 = u2_u2_bank_open;
    assign u2_any_bank_open_2 = u2_u2_any_bank_open;
    assign u2_row_same_2 = u2_u2_row_same;
    assign u2_u3_clk = u2_clk;
    assign u2_u3_rst = u2_rst;
    assign u2_u3_row_adr = u2_row_adr;
    assign u2_u3_bank_adr = u2_bank_adr;
    assign u2_u3_bank_set = u2_bank_set_3;
    assign u2_u3_bank_clr = u2_bank_clr_3;
    assign u2_u3_bank_clr_all = u2_bank_clr_all_3;
    assign u2_bank_open_3 = u2_u3_bank_open;
    assign u2_any_bank_open_3 = u2_u3_any_bank_open;
    assign u2_row_same_3 = u2_u3_row_same;
    assign u2_u4_clk = u2_clk;
    assign u2_u4_rst = u2_rst;
    assign u2_u4_row_adr = u2_row_adr;
    assign u2_u4_bank_adr = u2_bank_adr;
    assign u2_u4_bank_set = u2_bank_set_4;
    assign u2_u4_bank_clr = u2_bank_clr_4;
    assign u2_u4_bank_clr_all = u2_bank_clr_all_4;
    assign u2_bank_open_4 = u2_u4_bank_open;
    assign u2_any_bank_open_4 = u2_u4_any_bank_open;
    assign u2_row_same_4 = u2_u4_row_same;
    assign u2_u5_clk = u2_clk;
    assign u2_u5_rst = u2_rst;
    assign u2_u5_row_adr = u2_row_adr;
    assign u2_u5_bank_adr = u2_bank_adr;
    assign u2_u5_bank_set = u2_bank_set_5;
    assign u2_u5_bank_clr = u2_bank_clr_5;
    assign u2_u5_bank_clr_all = u2_bank_clr_all_5;
    assign u2_bank_open_5 = u2_u5_bank_open;
    assign u2_any_bank_open_5 = u2_u5_any_bank_open;
    assign u2_row_same_5 = u2_u5_row_same;
    assign u2_u6_clk = u2_clk;
    assign u2_u6_rst = u2_rst;
    assign u2_u6_row_adr = u2_row_adr;
    assign u2_u6_bank_adr = u2_bank_adr;
    assign u2_u6_bank_set = u2_bank_set_6;
    assign u2_u6_bank_clr = u2_bank_clr_6;
    assign u2_u6_bank_clr_all = u2_bank_clr_all_6;
    assign u2_bank_open_6 = u2_u6_bank_open;
    assign u2_any_bank_open_6 = u2_u6_any_bank_open;
    assign u2_row_same_6 = u2_u6_row_same;
    assign u2_u7_clk = u2_clk;
    assign u2_u7_rst = u2_rst;
    assign u2_u7_row_adr = u2_row_adr;
    assign u2_u7_bank_adr = u2_bank_adr;
    assign u2_u7_bank_set = u2_bank_set_7;
    assign u2_u7_bank_clr = u2_bank_clr_7;
    assign u2_u7_bank_clr_all = u2_bank_clr_all_7;
    assign u2_bank_open_7 = u2_u7_bank_open;
    assign u2_any_bank_open_7 = u2_u7_any_bank_open;
    assign u2_row_same_7 = u2_u7_row_same;
    
    assign u2_clk = clk_i;
    assign u2_rst = rst_i;
    assign u2_cs = obct_cs;
    assign u2_row_adr = row_adr;
    assign u2_bank_adr = bank_adr;
    assign u2_bank_set = bank_set;
    assign u2_bank_clr = bank_clr;
    assign u2_bank_clr_all = bank_clr_all;
    assign bank_open = u2_bank_open;
    assign any_bank_open = u2_any_bank_open;
    assign row_same = u2_row_same;
    assign u2_rfr_ack = rfr_ack;
    

wire u3_clk;
    wire u3_rst;
    wire[31:0] u3_csc;
    wire u3_wb_cyc_i;
    wire u3_wb_stb_i;
    wire u3_mem_ack;
    wire u3_wb_ack_o;
    wire[31:0] u3_wb_data_i;
    wire[31:0] u3_wb_data_o;
    wire u3_wb_read_go;
    wire u3_wb_we_i;
    wire u3_mc_clk;
    wire[35:0] u3_mc_data_del;
    wire[3:0] u3_mc_dp_i;
    wire[31:0] u3_mc_data_o;
    wire[3:0] u3_mc_dp_o;
    wire u3_dv;
    wire u3_pack_le0;
    wire u3_pack_le1;
    wire u3_pack_le2;
    wire[3:0] u3_byte_en;
    wire u3_par_err;

    reg[31:0] u3_wb_data_o ; reg[31:0] u3_mc_data_o ; 
    wire[35:0] u3_rd_fifo_out ; 
    wire u3_rd_fifo_clr ; reg[3:0] u3_mc_dp_o ; 
    reg u3_par_err_r ; reg[7:0] u3_byte0 , u3_byte1 , u3_byte2 ; reg[31:0] u3_mc_data_d ; 
    wire[2:0] u3_mem_type ; 
    wire[1:0] u3_bus_width ; 
    wire u3_pen ; 
    wire u3_re ; 
  assign  u3_mem_type = u3_csc [3:1]; 
  assign  u3_bus_width = u3_csc [5:4]; 
  assign  u3_pen = u3_csc [11]; 
  always @(    u3_mem_type              or   u3_rd_fifo_out           or   u3_mc_data_d  )
         if (( u3_mem_type ==3'h0)|( u3_mem_type ==3'h1)) 
             u3_wb_data_o  = u3_rd_fifo_out [31:0];
          else  
             u3_wb_data_o  = u3_mc_data_d ;
  assign  u3_rd_fifo_clr =! u3_wb_cyc_i |( u3_wb_we_i & u3_wb_stb_i ); 
  assign  u3_re = u3_wb_ack_o & u3_wb_read_go ;  
    wire u3_u0_clk;
    wire u3_u0_rst;
    wire u3_u0_clr;
    wire[35:0] u3_u0_din;
    wire u3_u0_we;
    wire[35:0] u3_u0_dout;
    wire u3_u0_re;

    reg[3:0] u3_u0_rd_adr , u3_u0_wr_adr ; reg[35:0] u3_u0_r0 , u3_u0_r1 , u3_u0_r2 , u3_u0_r3 ; reg[35:0] u3_u0_dout ; 
  always @(  posedge   u3_u0_clk          or  posedge  u3_u0_rst )
         if ( u3_u0_rst ) 
             u3_u0_rd_adr  <=4'h1;
          else 
             if ( u3_u0_clr ) 
                 u3_u0_rd_adr  <=4'h1;
              else 
                 if ( u3_u0_re ) 
                     u3_u0_rd_adr  <={ u3_u0_rd_adr [2:0], u3_u0_rd_adr [3]};
  always @(  posedge   u3_u0_clk          or  posedge  u3_u0_rst )
         if ( u3_u0_rst ) 
             u3_u0_wr_adr  <=4'h1;
          else 
             if ( u3_u0_clr ) 
                 u3_u0_wr_adr  <=4'h1;
              else 
                 if ( u3_u0_we ) 
                     u3_u0_wr_adr  <={ u3_u0_wr_adr [2:0], u3_u0_wr_adr [3]};
  always @( posedge  u3_u0_clk )
         if ( u3_u0_we & u3_u0_wr_adr [0]) 
             u3_u0_r0  <= u3_u0_din ;
  always @( posedge  u3_u0_clk )
         if ( u3_u0_we & u3_u0_wr_adr [1]) 
             u3_u0_r1  <= u3_u0_din ;
  always @( posedge  u3_u0_clk )
         if ( u3_u0_we & u3_u0_wr_adr [2]) 
             u3_u0_r2  <= u3_u0_din ;
  always @( posedge  u3_u0_clk )
         if ( u3_u0_we & u3_u0_wr_adr [3]) 
             u3_u0_r3  <= u3_u0_din ;
  always @(         u3_u0_rd_adr                        or   u3_u0_r0                or   u3_u0_r1               or   u3_u0_r2              or   u3_u0_r3             or   u3_u0_re            or   u3_u0_we           or   u3_u0_din  )
         case ( u3_u0_rd_adr )
          4 'h1: 
              u3_u0_dout  = u3_u0_r0 ;
          4 'h2: 
              u3_u0_dout  = u3_u0_r1 ;
          4 'h4: 
              u3_u0_dout  = u3_u0_r2 ;
          4 'h8: 
              u3_u0_dout  = u3_u0_r3 ;endcase

    assign u3_u0_clk = u3_clk;
    assign u3_u0_rst = u3_rst;
    assign u3_u0_clr = u3_rd_fifo_clr;
    assign u3_u0_din = u3_mc_data_del;
    assign u3_u0_we = u3_dv;
    assign u3_rd_fifo_out = u3_u0_dout;
    assign u3_u0_re = u3_re;
     
  always @( posedge  u3_clk )
         if ( u3_wb_ack_o |( u3_mem_type !=3'h0)) 
             u3_mc_data_o  <= u3_wb_data_i ;
  always @( posedge  u3_clk )
         if ( u3_pack_le0 ) 
             u3_byte0  <= u3_mc_data_del [7:0];
  always @( posedge  u3_clk )
         if ( u3_pack_le1 &( u3_bus_width ==2'h0)) 
             u3_byte1  <= u3_mc_data_del [7:0];
          else 
             if ( u3_pack_le0 &( u3_bus_width ==2'h1)) 
                 u3_byte1  <= u3_mc_data_del [15:8];
  always @( posedge  u3_clk )
         if ( u3_pack_le2 ) 
             u3_byte2  <= u3_mc_data_del [7:0];
  always @(      u3_bus_width                  or   u3_mc_data_del             or   u3_byte0            or   u3_byte1           or   u3_byte2  )
         if ( u3_bus_width ==2'h0) 
             u3_mc_data_d  ={ u3_mc_data_del [7:0], u3_byte2 , u3_byte1 , u3_byte0 };
          else 
             if ( u3_bus_width ==2'h1) 
                 u3_mc_data_d  ={ u3_mc_data_del [15:0], u3_byte1 , u3_byte0 };
              else  
                 u3_mc_data_d  = u3_mc_data_del [31:0];
  always @( posedge  u3_clk )
         if ( u3_wb_ack_o |( u3_mem_type !=3'h0))
             begin  
                 u3_mc_dp_o  <=4'b1010;
             end
  assign  u3_par_err =! u3_wb_we_i & u3_mem_ack & u3_pen ;
    assign u3_clk = clk_i;
    assign u3_rst = rst_i;
    assign u3_csc = csc;
    assign u3_wb_cyc_i = wb_cyc_i;
    assign u3_wb_stb_i = wb_stb_i;
    assign u3_mem_ack = mem_ack;
    assign u3_wb_ack_o = mem_ack_r;
    assign u3_wb_data_i = wb_data_i;
    assign mem_dout = u3_wb_data_o;
    assign u3_wb_read_go = wb_read_go;
    assign u3_wb_we_i = wb_we_i;
    assign u3_mc_clk = mc_clk_i;
    assign u3_mc_data_del = mc_data_ir;
    assign u3_mc_dp_i = mc_dp_pad_i;
    assign mc_data_od = u3_mc_data_o;
    assign mc_dp_od = u3_mc_dp_o;
    assign u3_dv = dv;
    assign u3_pack_le0 = pack_le0;
    assign u3_pack_le1 = pack_le1;
    assign u3_pack_le2 = pack_le2;
    assign u3_byte_en = wb_sel_i;
    assign par_err = u3_par_err;
    

wire u4_clk;
    wire u4_rst;
    wire[7:0] u4_cs_need_rfr;
    wire[2:0] u4_ref_int;
    wire u4_rfr_req;
    wire u4_rfr_ack;
    wire[7:0] u4_rfr_ps_val;

    reg u4_rfr_en ; reg[7:0] u4_ps_cnt ; 
    wire u4_ps_cnt_clr ; 
    reg u4_rfr_ce ; reg[7:0] u4_rfr_cnt ; 
    reg u4_rfr_clr ; 
    reg u4_rfr_req ; 
    reg u4_rfr_early ; 
  always @(  posedge   u4_clk          or  posedge  u4_rst )
         if ( u4_rst ) 
             u4_rfr_en  <=1'b0;
          else  
             u4_rfr_en  <=| u4_cs_need_rfr ;
  always @(  posedge   u4_clk          or  posedge  u4_rst )
         if ( u4_rst ) 
             u4_ps_cnt  <=8'h0;
          else 
             if ( u4_ps_cnt_clr ) 
                 u4_ps_cnt  <=8'h0;
              else 
                 if ( u4_rfr_en ) 
                     u4_ps_cnt  <= u4_ps_cnt +8'h1;
  assign  u4_ps_cnt_clr =( u4_ps_cnt == u4_rfr_ps_val )&( u4_rfr_ps_val !=8'h0); 
  always @(  posedge   u4_clk          or  posedge  u4_rst )
         if ( u4_rst ) 
             u4_rfr_early  <=1'b0;
          else  
             u4_rfr_early  <=( u4_ps_cnt == u4_rfr_ps_val );
  always @(  posedge   u4_clk          or  posedge  u4_rst )
         if ( u4_rst ) 
             u4_rfr_ce  <=1'b0;
          else  
             u4_rfr_ce  <= u4_ps_cnt_clr ;
  always @(  posedge   u4_clk          or  posedge  u4_rst )
         if ( u4_rst ) 
             u4_rfr_cnt  <=8'h0;
          else 
             if ( u4_rfr_ack ) 
                 u4_rfr_cnt  <=8'h0;
              else 
                 if ( u4_rfr_ce ) 
                     u4_rfr_cnt  <= u4_rfr_cnt +8'h1;
  always @( posedge  u4_clk )
         case ( u4_ref_int )
          3 'h0: 
              u4_rfr_clr  <= u4_rfr_cnt [0]& u4_rfr_early ;
          3 'h1: 
              u4_rfr_clr  <=& u4_rfr_cnt [1:0]& u4_rfr_early ;
          3 'h2: 
              u4_rfr_clr  <=& u4_rfr_cnt [2:0]& u4_rfr_early ;
          3 'h3: 
              u4_rfr_clr  <=& u4_rfr_cnt [3:0]& u4_rfr_early ;
          3 'h4: 
              u4_rfr_clr  <=& u4_rfr_cnt [4:0]& u4_rfr_early ;
          3 'h5: 
              u4_rfr_clr  <=& u4_rfr_cnt [5:0]& u4_rfr_early ;
          3 'h6: 
              u4_rfr_clr  <=& u4_rfr_cnt [6:0]& u4_rfr_early ;
          3 'h7: 
              u4_rfr_clr  <=& u4_rfr_cnt [7:0]& u4_rfr_early ;endcase
  always @(  posedge   u4_clk          or  posedge  u4_rst )
         if ( u4_rst ) 
             u4_rfr_req  <=1'b0;
          else 
             if ( u4_rfr_ack ) 
                 u4_rfr_req  <=1'b0;
              else 
                 if ( u4_rfr_clr ) 
                     u4_rfr_req  <=1'b1;

    assign u4_clk = clk_i;
    assign u4_rst = rst_i;
    assign u4_cs_need_rfr = cs_need_rfr;
    assign u4_ref_int = ref_int;
    assign rfr_req = u4_rfr_req;
    assign u4_rfr_ack = rfr_ack;
    assign u4_rfr_ps_val = rfr_ps_val;
    
 
wire u5_clk;
    wire u5_rst;
    wire u5_wb_cyc_i;
    wire u5_wb_stb_i;
    wire u5_wb_we_i;
    wire u5_wb_read_go;
    wire u5_wb_write_go;
    wire u5_wb_first;
    wire u5_wb_wait;
    wire u5_mem_ack;
    wire u5_err;
    wire u5_susp_req;
    wire u5_resume_req;
    wire u5_suspended;
    wire u5_susp_sel;
    wire u5_mc_clk;
    wire u5_data_oe;
    wire u5_oe_;
    wire u5_we_;
    wire u5_cas_;
    wire u5_ras_;
    wire u5_cke_;
    wire u5_cs_en;
    wire u5_wb_cycle;
    wire u5_wr_cycle;
    wire u5_mc_br;
    wire u5_mc_bg;
    wire u5_mc_adsc;
    wire u5_mc_adv;
    wire u5_mc_c_oe;
    wire u5_mc_ack;
    wire u5_not_mem_cyc;
    wire[31:0] u5_csc;
    wire[31:0] u5_tms;
    wire[7:0] u5_cs;
    wire u5_lmr_req;
    wire u5_lmr_ack;
    wire u5_cs_le;
    wire u5_cs_le_d;
    wire[10:0] u5_page_size;
    wire u5_cmd_a10;
    wire u5_row_sel;
    wire u5_next_adr;
    wire u5_bank_set;
    wire u5_bank_clr;
    wire u5_bank_clr_all;
    wire u5_bank_open;
    wire u5_any_bank_open;
    wire u5_row_same;
    wire u5_dv;
    wire u5_pack_le0;
    wire u5_pack_le1;
    wire u5_pack_le2;
    wire u5_par_err;
    wire u5_rfr_req;
    wire u5_rfr_ack;
    wire u5_init_req;
    wire u5_init_ack;

    parameter[65:0] u5_POR =66'b000000000000000000000000000000000000000000000000000000000000000001, u5_IDLE =66'b000000000000000000000000000000000000000000000000000000000000000010, u5_IDLE_T =66'b000000000000000000000000000000000000000000000000000000000000000100, u5_IDLE_T2 =66'b000000000000000000000000000000000000000000000000000000000000001000, u5_PRECHARGE =66'b000000000000000000000000000000000000000000000000000000000000010000, u5_PRECHARGE_W =66'b000000000000000000000000000000000000000000000000000000000000100000, u5_ACTIVATE =66'b000000000000000000000000000000000000000000000000000000000001000000, u5_ACTIVATE_W =66'b000000000000000000000000000000000000000000000000000000000010000000, u5_SD_RD_WR =66'b000000000000000000000000000000000000000000000000000000000100000000, u5_SD_RD =66'b000000000000000000000000000000000000000000000000000000001000000000, u5_SD_RD_W =66'b000000000000000000000000000000000000000000000000000000010000000000, u5_SD_RD_LOOP =66'b000000000000000000000000000000000000000000000000000000100000000000, u5_SD_RD_W2 =66'b000000000000000000000000000000000000000000000000000001000000000000, u5_SD_WR =66'b000000000000000000000000000000000000000000000000000010000000000000, u5_SD_WR_W =66'b000000000000000000000000000000000000000000000000000100000000000000, u5_BT =66'b000000000000000000000000000000000000000000000000001000000000000000, u5_BT_W =66'b000000000000000000000000000000000000000000000000010000000000000000, u5_REFR =66'b000000000000000000000000000000000000000000000000100000000000000000, u5_LMR0 =66'b000000000000000000000000000000000000000000000001000000000000000000, u5_LMR1 =66'b000000000000000000000000000000000000000000000010000000000000000000, u5_LMR2 =66'b000000000000000000000000000000000000000000000100000000000000000000, u5_INIT0 =66'b000000000000000000000000000000000000000000001000000000000000000000, u5_INIT =66'b000000000000000000000000000000000000000000010000000000000000000000, u5_INIT_W =66'b000000000000000000000000000000000000000000100000000000000000000000, u5_INIT_REFR1 =66'b000000000000000000000000000000000000000001000000000000000000000000, u5_INIT_REFR1_W =66'b000000000000000000000000000000000000000010000000000000000000000000, u5_INIT_LMR =66'b000000000000000000000000000000000000000100000000000000000000000000, u5_SUSP1 =66'b000000000000000000000000000000000000001000000000000000000000000000, u5_SUSP2 =66'b000000000000000000000000000000000000010000000000000000000000000000, u5_SUSP3 =66'b000000000000000000000000000000000000100000000000000000000000000000, u5_SUSP4 =66'b000000000000000000000000000000000001000000000000000000000000000000, u5_RESUME1 =66'b000000000000000000000000000000000010000000000000000000000000000000, u5_RESUME2 =66'b000000000000000000000000000000000100000000000000000000000000000000, u5_BG0 =66'b000000000000000000000000000000001000000000000000000000000000000000, u5_BG1 =66'b000000000000000000000000000000010000000000000000000000000000000000, u5_BG2 =66'b000000000000000000000000000000100000000000000000000000000000000000, u5_ACS_RD =66'b000000000000000000000000000001000000000000000000000000000000000000, u5_ACS_RD1 =66'b000000000000000000000000000010000000000000000000000000000000000000, u5_ACS_RD2A =66'b000000000000000000000000000100000000000000000000000000000000000000, u5_ACS_RD2 =66'b000000000000000000000000001000000000000000000000000000000000000000, u5_ACS_RD3 =66'b000000000000000000000000010000000000000000000000000000000000000000, u5_ACS_RD_8_1 =66'b000000000000000000000000100000000000000000000000000000000000000000, u5_ACS_RD_8_2 =66'b000000000000000000000001000000000000000000000000000000000000000000, u5_ACS_RD_8_3 =66'b000000000000000000000010000000000000000000000000000000000000000000, u5_ACS_RD_8_4 =66'b000000000000000000000100000000000000000000000000000000000000000000, u5_ACS_RD_8_5 =66'b000000000000000000001000000000000000000000000000000000000000000000, u5_ACS_RD_8_6 =66'b000000000000000000010000000000000000000000000000000000000000000000, u5_ACS_WR =66'b000000000000000000100000000000000000000000000000000000000000000000, u5_ACS_WR1 =66'b000000000000000001000000000000000000000000000000000000000000000000, u5_ACS_WR2 =66'b000000000000000010000000000000000000000000000000000000000000000000, u5_ACS_WR3 =66'b000000000000000100000000000000000000000000000000000000000000000000, u5_ACS_WR4 =66'b000000000000001000000000000000000000000000000000000000000000000000, u5_SRAM_RD =66'b000000000000010000000000000000000000000000000000000000000000000000, u5_SRAM_RD0 =66'b000000000000100000000000000000000000000000000000000000000000000000, u5_SRAM_RD1 =66'b000000000001000000000000000000000000000000000000000000000000000000, u5_SRAM_RD2 =66'b000000000010000000000000000000000000000000000000000000000000000000, u5_SRAM_RD3 =66'b000000000100000000000000000000000000000000000000000000000000000000, u5_SRAM_RD4 =66'b000000001000000000000000000000000000000000000000000000000000000000, u5_SRAM_WR =66'b000000010000000000000000000000000000000000000000000000000000000000, u5_SRAM_WR0 =66'b000000100000000000000000000000000000000000000000000000000000000000, u5_SCS_RD =66'b000001000000000000000000000000000000000000000000000000000000000000, u5_SCS_RD1 =66'b000010000000000000000000000000000000000000000000000000000000000000, u5_SCS_RD2 =66'b000100000000000000000000000000000000000000000000000000000000000000, u5_SCS_WR =66'b001000000000000000000000000000000000000000000000000000000000000000, u5_SCS_WR1 =66'b010000000000000000000000000000000000000000000000000000000000000000, u5_SCS_ERR =66'b100000000000000000000000000000000000000000000000000000000000000000; reg[65:0] u5_state , u5_next_state ; 
    reg u5_mc_bg ; 
    wire[2:0] u5_mem_type ; 
    wire[1:0] u5_bus_width ; 
    wire u5_kro ; 
    wire u5_cs_a ; reg[3:0] u5_cmd ; 
    wire u5_mem_ack ; 
    wire u5_mem_ack_s ; 
    reg u5_mem_ack_d ; 
    reg u5_err_d ; 
    wire u5_err ; 
    reg u5_cmd_a10 ; 
    reg u5_lmr_ack ; 
    reg u5_lmr_ack_d ; 
    reg u5_row_sel ; 
    reg u5_oe_ ; 
    reg u5_oe_d ; 
    reg u5_data_oe ; 
    reg u5_data_oe_d ; 
    reg u5_cke_d ; 
    reg u5_cke_ ; 
    reg u5_init_ack ; 
    reg u5_dv ; 
    reg u5_rfr_ack_d ; 
    reg u5_mc_adsc ; 
    reg u5_mc_adv ; 
    reg u5_bank_set ; 
    reg u5_bank_clr ; 
    reg u5_bank_clr_all ; 
    reg u5_wr_set , u5_wr_clr ; 
    reg u5_wr_cycle ; 
    reg u5_cmd_asserted ; 
    reg u5_cmd_asserted2 ; reg[10:0] u5_burst_val ; reg[10:0] u5_burst_cnt ; 
    wire u5_burst_act ; 
    reg u5_burst_act_rd ; 
    wire u5_single_write ; 
    reg u5_cs_le_d ; 
    reg u5_cs_le ; 
    reg u5_cs_le_r ; 
    reg u5_susp_req_r ; 
    reg u5_resume_req_r ; 
    reg u5_suspended ; 
    reg u5_suspended_d ; 
    reg u5_susp_sel_set , u5_susp_sel_clr , u5_susp_sel_r ; reg[3:0] u5_cmd_del ; reg[3:0] u5_cmd_r ; 
    reg u5_data_oe_r ; 
    reg u5_data_oe_r2 ; 
    reg u5_cke_r ; 
    reg u5_cke_rd ; 
    reg u5_cke_o_del ; 
    reg u5_cke_o_r1 ; 
    reg u5_cke_o_r2 ; 
    reg u5_wb_cycle_set , u5_wb_cycle ; reg[3:0] u5_ack_cnt ; 
    wire u5_ack_cnt_is_0 ; 
    reg u5_cnt , u5_cnt_next ; reg[7:0] u5_timer ; 
    reg u5_tmr_ld_trp , u5_tmr_ld_trcd , u5_tmr_ld_tcl , u5_tmr_ld_trfc ; 
    reg u5_tmr_ld_twr , u5_tmr_ld_txsr ; 
    reg u5_tmr2_ld_tscsto ; 
    reg u5_tmr_ld_trdv ; 
    reg u5_tmr_ld_trdz ; 
    reg u5_tmr_ld_twr2 ; 
    wire u5_timer_is_zero ; 
    reg u5_tmr_done ; 
    reg u5_tmr2_ld_trdv , u5_tmr2_ld_trdz ; 
    reg u5_tmr2_ld_twpw , u5_tmr2_ld_twd , u5_tmr2_ld_twwd ; 
    reg u5_tmr2_ld_tsrdv ; reg[8:0] u5_timer2 ; 
    reg u5_tmr2_done ; 
    wire u5_timer2_is_zero ; reg[3:0] u5_ir_cnt ; 
    reg u5_ir_cnt_ld ; 
    reg u5_ir_cnt_dec ; 
    reg u5_ir_cnt_done ; 
    reg u5_rfr_ack_r ; 
    reg u5_burst_cnt_ld ; 
    reg u5_burst_fp ; 
    reg u5_wb_wait_r , u5_wb_wait_r2 ; 
    reg u5_lookup_ready1 , u5_lookup_ready2 ; 
    reg u5_burst_cnt_ld_4 ; 
    reg u5_dv_r ; 
    reg u5_mc_adv_r1 , u5_mc_adv_r ; 
    reg u5_next_adr ; 
    reg u5_pack_le0 , u5_pack_le1 , u5_pack_le2 ; 
    reg u5_pack_le0_d , u5_pack_le1_d , u5_pack_le2_d ; 
    wire u5_bw8 , u5_bw16 ; 
    reg u5_mc_c_oe_d ; 
    reg u5_mc_c_oe ; 
    reg u5_mc_le ; 
    reg u5_mem_ack_r ; 
    reg u5_rsts , u5_rsts1 ; 
    reg u5_no_wb_cycle ; 
    wire u5_bc_dec ; 
    reg u5_ap_en ; 
    reg u5_cmd_a10_r ; 
    reg u5_wb_stb_first ; 
    reg u5_tmr_ld_tavav ; 
  assign  u5_mem_type = u5_csc [3:1]; 
  assign  u5_bus_width = u5_csc [5:4]; 
  assign  u5_kro = u5_csc [10]; 
  assign  u5_single_write = u5_tms [9]|( u5_tms [2:0]==3'h0); 
    reg u5_cs_le_r1 ; 
  always @( posedge  u5_clk ) 
         u5_lmr_ack  <= u5_lmr_ack_d ;
  assign  u5_rfr_ack = u5_rfr_ack_r ; 
  always @( posedge  u5_clk ) 
         u5_cs_le_r  <= u5_cs_le_r1 ;
  always @( posedge  u5_clk ) 
         u5_cs_le_r1  <= u5_cs_le ;
  always @( posedge  u5_clk ) 
         u5_cs_le  <= u5_cs_le_d ;
  always @(  posedge   u5_mc_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_rsts1  <=1'b1;
          else  
             u5_rsts1  <=1'b0;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_rsts  <=1'b1;
          else  
             u5_rsts  <= u5_rsts1 ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_mc_c_oe  <=1'b0;
          else  
             u5_mc_c_oe  <= u5_mc_c_oe_d ;
  always @(  posedge   u5_clk          or  posedge  u5_rsts )
         if ( u5_rsts ) 
             u5_mc_le  <=1'b0;
          else  
             u5_mc_le  <=~ u5_mc_le ;
  always @( posedge  u5_clk ) 
         u5_pack_le0  <= u5_pack_le0_d ;
  always @( posedge  u5_clk ) 
         u5_pack_le1  <= u5_pack_le1_d ;
  always @( posedge  u5_clk ) 
         u5_pack_le2  <= u5_pack_le2_d ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_mc_adv_r1  <=1'b0;
          else 
             if (! u5_mc_le ) 
                 u5_mc_adv_r1  <= u5_mc_adv ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_mc_adv_r  <=1'b0;
          else 
             if (! u5_mc_le ) 
                 u5_mc_adv_r  <= u5_mc_adv_r1 ;
  assign  u5_bw8 =( u5_bus_width ==2'h0); 
  assign  u5_bw16 =( u5_bus_width ==2'h1); 
  assign  u5_cs_a =| u5_cs ; 
  assign  u5_mem_ack =( u5_mem_ack_d | u5_mem_ack_s )&( u5_wb_read_go | u5_wb_write_go ); 
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_mem_ack_r  <=1'b0;
          else  
             u5_mem_ack_r  <= u5_mem_ack ;
  assign  u5_err = u5_err_d ; 
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_cmd_r  <=4'b0111;
          else  
             u5_cmd_r  <= u5_cmd ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_cmd_del  <=4'b0111;
          else  
             u5_cmd_del  <= u5_cmd_r ;
    wire[3:0] u5_temp_cs = u5_wr_cycle  ?  u5_cmd_del : u5_cmd ; 
  assign  u5_cs_en = u5_temp_cs [3]; 
  assign  u5_ras_ = u5_temp_cs [2]; 
  assign  u5_cas_ = u5_temp_cs [1]; 
  assign  u5_we_ = u5_temp_cs [0]; 
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_cmd_asserted  <=1'b0;
          else 
             if (! u5_mc_le ) 
                 u5_cmd_asserted  <= u5_cmd [3];
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_cmd_asserted2  <=1'b0;
          else 
             if (! u5_mc_le ) 
                 u5_cmd_asserted2  <= u5_cmd_asserted ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_oe_  <=1'b1;
          else  
             u5_oe_  <=~ u5_oe_d ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_data_oe_r  <=1'b0;
          else  
             u5_data_oe_r  <= u5_data_oe_d ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_data_oe_r2  <=1'b0;
          else  
             u5_data_oe_r2  <= u5_data_oe_r ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_data_oe  <=1'b0;
          else  
             u5_data_oe  <= u5_wr_cycle  ?  u5_data_oe_r2 : u5_data_oe_d ;
  always @( posedge  u5_clk ) 
         u5_cke_r  <= u5_cke_d ;
  always @( posedge  u5_clk ) 
         u5_cke_  <= u5_cke_r & u5_cke_rd ;
  always @( posedge  u5_clk ) 
         u5_cke_o_r1  <= u5_cke_ ;
  always @( posedge  u5_clk ) 
         u5_cke_o_r2  <= u5_cke_o_r1 ;
  always @( posedge  u5_clk ) 
         u5_cke_o_del  <= u5_cke_o_r2 ;
  always @( posedge  u5_clk ) 
         u5_wb_wait_r2  <= u5_wb_wait ;
  always @( posedge  u5_clk ) 
         u5_wb_wait_r  <= u5_wb_wait_r2 ;
    reg u5_lookup_ready1a ; 
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_lookup_ready1  <=1'b0;
          else  
             u5_lookup_ready1  <= u5_cs_le & u5_wb_cyc_i & u5_wb_stb_i ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_lookup_ready2  <=1'b0;
          else  
             u5_lookup_ready2  <= u5_lookup_ready1 & u5_wb_cyc_i & u5_wb_stb_i ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_wr_cycle  <=1'b0;
          else 
             if ( u5_wr_set ) 
                 u5_wr_cycle  <=1'b1;
              else 
                 if ( u5_wr_clr ) 
                     u5_wr_cycle  <=1'b0;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_wb_cycle  <=1'b0;
          else 
             if ( u5_wb_cycle_set ) 
                 u5_wb_cycle  <=1'b1;
              else 
                 if (! u5_wb_cyc_i | u5_not_mem_cyc ) 
                     u5_wb_cycle  <=1'b0;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_no_wb_cycle  <=1'b0;
          else  
             u5_no_wb_cycle  <=! u5_wb_read_go &! u5_wb_write_go ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_ack_cnt  <=4'h0;
          else 
             if ( u5_no_wb_cycle ) 
                 u5_ack_cnt  <=4'h0;
              else 
                 if ( u5_dv &! u5_mem_ack_s ) 
                     u5_ack_cnt  <= u5_ack_cnt +4'h1;
                  else 
                     if (! u5_dv & u5_mem_ack_s ) 
                         u5_ack_cnt  <= u5_ack_cnt -4'h1;
  assign  u5_ack_cnt_is_0 =( u5_ack_cnt ==4'h0); 
  assign  u5_mem_ack_s =( u5_ack_cnt !=4'h0)&! u5_wb_wait &! u5_mem_ack_r & u5_wb_read_go &!( u5_wb_we_i & u5_wb_stb_i ); 
  always @( posedge  u5_clk ) 
         u5_cnt  <= u5_cnt_next ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_susp_req_r  <=1'b0;
          else  
             u5_susp_req_r  <= u5_susp_req ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_resume_req_r  <=1'b0;
          else  
             u5_resume_req_r  <= u5_resume_req ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_suspended  <=1'b0;
          else  
             u5_suspended  <= u5_suspended_d ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_rfr_ack_r  <=1'b0;
          else  
             u5_rfr_ack_r  <= u5_rfr_ack_d ;
  assign  u5_susp_sel = u5_susp_sel_r ; 
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_susp_sel_r  <=1'b0;
          else 
             if ( u5_susp_sel_set ) 
                 u5_susp_sel_r  <=1'b1;
              else 
                 if ( u5_susp_sel_clr ) 
                     u5_susp_sel_r  <=1'b0;
    wire[3:0] u5_twrp ; 
    wire u5_twd_is_zero ; 
    wire[31:0] u5_tms_x ; 
  assign  u5_tms_x =( u5_rfr_ack_d | u5_rfr_ack_r | u5_susp_sel |! u5_mc_c_oe ) ? 32'hffff_ffff: u5_tms ; 
  always @( posedge  u5_clk )
         if ( u5_tmr2_ld_tscsto ) 
             u5_timer2  <= u5_tms_x [24:16];
          else 
             if ( u5_tmr2_ld_tsrdv ) 
                 u5_timer2  <=9'd4;
              else 
                 if ( u5_tmr2_ld_twpw ) 
                     u5_timer2  <={5'h0, u5_tms_x [15:12]};
                  else 
                     if ( u5_tmr2_ld_twd ) 
                         u5_timer2  <={4'h0, u5_tms_x [19:16],1'b0};
                      else 
                         if ( u5_tmr2_ld_twwd ) 
                             u5_timer2  <={3'h0, u5_tms_x [25:20]};
                          else 
                             if ( u5_tmr2_ld_trdz ) 
                                 u5_timer2  <={4'h0, u5_tms_x [11:8],1'b1};
                              else 
                                 if ( u5_tmr2_ld_trdv ) 
                                     u5_timer2  <={ u5_tms_x [7:0],1'b1};
                                  else 
                                     if (! u5_timer2_is_zero ) 
                                         u5_timer2  <= u5_timer2 -9'b1;
  assign  u5_twd_is_zero =( u5_tms_x [19:16]==4'h0); 
  assign  u5_timer2_is_zero =( u5_timer2 ==9'h0); 
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_tmr2_done  <=1'b0;
          else  
             u5_tmr2_done  <= u5_timer2_is_zero &! u5_tmr2_ld_trdv &! u5_tmr2_ld_trdz &! u5_tmr2_ld_twpw &! u5_tmr2_ld_twd &! u5_tmr2_ld_twwd &! u5_tmr2_ld_tscsto ;
  assign  u5_twrp ={2'h0, u5_tms_x [16:15]}+ u5_tms_x [23:20]; 
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_timer  <=8'd250;
          else 
             if ( u5_tmr_ld_twr2 ) 
                 u5_timer  <={4'h0, u5_tms_x [15:12]};
              else 
                 if ( u5_tmr_ld_trdz ) 
                     u5_timer  <={4'h0, u5_tms_x [11:8]};
                  else 
                     if ( u5_tmr_ld_trdv ) 
                         u5_timer  <= u5_tms_x [7:0];
                      else 
                         if ( u5_tmr_ld_twr ) 
                             u5_timer  <={4'h0, u5_twrp };
                          else 
                             if ( u5_tmr_ld_trp ) 
                                 u5_timer  <={4'h0, u5_tms_x [23:20]};
                              else 
                                 if ( u5_tmr_ld_trcd ) 
                                     u5_timer  <={5'h0, u5_tms_x [19:17]};
                                  else 
                                     if ( u5_tmr_ld_tcl ) 
                                         u5_timer  <={6'h0, u5_tms_x [05:04]};
                                      else 
                                         if ( u5_tmr_ld_trfc ) 
                                             u5_timer  <={4'h0, u5_tms_x [27:24]};
                                          else 
                                             if ( u5_tmr_ld_tavav ) 
                                                 u5_timer  <=8'h3;
                                              else 
                                                 if ( u5_tmr_ld_txsr ) 
                                                     u5_timer  <=8'h7;
                                                  else 
                                                     if (! u5_timer_is_zero &! u5_mc_le ) 
                                                         u5_timer  <= u5_timer -8'b1;
  assign  u5_timer_is_zero =( u5_timer ==8'h0); 
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_tmr_done  <=1'b0;
          else  
             u5_tmr_done  <= u5_timer_is_zero ;
  always @( posedge  u5_clk )
         if ( u5_ir_cnt_ld ) 
             u5_ir_cnt  <=2;
          else 
             if ( u5_ir_cnt_dec ) 
                 u5_ir_cnt  <= u5_ir_cnt -4'b1;
  always @( posedge  u5_clk ) 
         u5_ir_cnt_done  <=( u5_ir_cnt ==4'h0);
  always @(   u5_tms_x            or   u5_page_size  )
         case ( u5_tms_x [2:0])
          3 'h0: 
              u5_burst_val  =11'h1;
          3 'h1: 
              u5_burst_val  =11'h2;
          3 'h2: 
              u5_burst_val  =11'h4;
          3 'h3: 
              u5_burst_val  =11'h8;
          3 'h7: 
              u5_burst_val  = u5_page_size ;endcase
  assign  u5_bc_dec = u5_wr_cycle  ?  u5_mem_ack_d : u5_dv ; 
  always @( posedge  u5_clk )
         if ( u5_burst_cnt_ld_4 ) 
             u5_burst_cnt  <=11'h4;
          else 
             if ( u5_burst_cnt_ld ) 
                 u5_burst_cnt  <= u5_burst_val ;
              else 
                 if ( u5_bc_dec ) 
                     u5_burst_cnt  <= u5_burst_cnt -11'h1;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_burst_fp  <=1'b0;
          else 
             if ( u5_burst_cnt_ld ) 
                 u5_burst_fp  <=( u5_tms_x [2:0]==3'h7);
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_ap_en  <=1'b0;
          else 
             if ( u5_burst_cnt_ld ) 
                 u5_ap_en  <=( u5_tms_x [2:0]==3'h0)&! u5_kro ;
  assign  u5_burst_act =| u5_burst_cnt &(| u5_tms_x [2:0]); 
  always @( posedge  u5_clk ) 
         u5_burst_act_rd  <=| u5_burst_cnt ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_dv_r  <=1'b0;
          else  
             u5_dv_r  <= u5_dv ;
  always @( posedge  u5_clk ) 
         u5_cmd_a10_r  <= u5_cmd_a10 ;
    reg u5_wb_write_go_r ; 
  always @( posedge  u5_clk ) 
         u5_wb_write_go_r  <= u5_wb_write_go ;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_wb_stb_first  <=1'b0;
          else 
             if ( u5_mem_ack ) 
                 u5_wb_stb_first  <=1'b0;
              else 
                 if ( u5_wb_first & u5_wb_stb_i ) 
                     u5_wb_stb_first  <=1'b1;
  always @(  posedge   u5_clk          or  posedge  u5_rst )
         if ( u5_rst ) 
             u5_state  <= u5_POR ;
          else  
             u5_state  <= u5_next_state ;
  always @(                                                   u5_state                                                                                                            or   u5_cs_a                                                          or   u5_cs_le                                                         or   u5_cs_le_r                                                        or   u5_twd_is_zero                                                       or   u5_wb_stb_i                                                      or   u5_wb_write_go_r                                                     or   u5_wb_first                                                    or   u5_wb_read_go                                                   or   u5_wb_write_go                                                  or   u5_wb_wait                                                 or   u5_mem_ack_r                                                or   u5_wb_we_i                                               or   u5_ack_cnt_is_0                                              or   u5_wb_wait_r                                             or   u5_cnt                                            or   u5_wb_cycle                                           or   u5_wr_cycle                                          or   u5_mem_type                                         or   u5_kro                                        or   u5_lookup_ready2                                       or   u5_row_same                                      or   u5_cmd_a10_r                                     or   u5_bank_open                                    or   u5_single_write                                   or   u5_cmd_asserted                                  or   u5_tmr_done                                 or   u5_tmr2_done                                or   u5_ir_cnt_done                               or   u5_cmd_asserted2                              or   u5_burst_act                             or   u5_burst_act_rd                            or   u5_burst_fp                           or   u5_cke_                          or   u5_cke_r                         or   u5_cke_o_del                        or   u5_rfr_req                       or   u5_lmr_req                      or   u5_init_req                     or   u5_rfr_ack_r                    or   u5_susp_req_r                   or   u5_resume_req_r                  or   u5_mc_br                 or   u5_bw8                or   u5_bw16               or   u5_dv_r              or   u5_mc_adv_r             or   u5_mc_ack            or   u5_wb_stb_first           or   u5_ap_en  )
         begin  
             u5_next_state  = u5_state ; 
             u5_cnt_next  =1'b0; 
             u5_cmd  =4'b0111; 
             u5_cmd_a10  = u5_ap_en ; 
             u5_oe_d  =1'b0; 
             u5_data_oe_d  =1'b0; 
             u5_cke_d  =1'b1; 
             u5_cke_rd  =1'b1; 
             u5_mc_adsc  =1'b0; 
             u5_mc_adv  =1'b0; 
             u5_bank_set  =1'b0; 
             u5_bank_clr  =1'b0; 
             u5_bank_clr_all  =1'b0; 
             u5_burst_cnt_ld  =1'b0; 
             u5_burst_cnt_ld_4  =1'b0; 
             u5_tmr_ld_trp  =1'b0; 
             u5_tmr_ld_trcd  =1'b0; 
             u5_tmr_ld_tcl  =1'b0; 
             u5_tmr_ld_trfc  =1'b0; 
             u5_tmr_ld_twr  =1'b0; 
             u5_tmr_ld_txsr  =1'b0; 
             u5_tmr_ld_trdv  =1'b0; 
             u5_tmr_ld_trdz  =1'b0; 
             u5_tmr_ld_twr2  =1'b0; 
             u5_tmr_ld_tavav  =1'b0; 
             u5_tmr2_ld_trdv  =1'b0; 
             u5_tmr2_ld_trdz  =1'b0; 
             u5_tmr2_ld_twpw  =1'b0; 
             u5_tmr2_ld_twd  =1'b0; 
             u5_tmr2_ld_twwd  =1'b0; 
             u5_tmr2_ld_tsrdv  =1'b0; 
             u5_tmr2_ld_tscsto  =1'b0; 
             u5_mem_ack_d  =1'b0; 
             u5_err_d  =1'b0; 
             u5_rfr_ack_d  =1'b0; 
             u5_lmr_ack_d  =1'b0; 
             u5_init_ack  =1'b0; 
             u5_ir_cnt_dec  =1'b0; 
             u5_ir_cnt_ld  =1'b0; 
             u5_row_sel  =1'b0; 
             u5_cs_le_d  =1'b0; 
             u5_wr_clr  =1'b0; 
             u5_wr_set  =1'b0; 
             u5_wb_cycle_set  =1'b0; 
             u5_dv  =1'b0; 
             u5_suspended_d  =1'b0; 
             u5_susp_sel_set  =1'b0; 
             u5_susp_sel_clr  =1'b0; 
             u5_mc_bg  =1'b0; 
             u5_next_adr  =1'b0; 
             u5_pack_le0_d  =1'b0; 
             u5_pack_le1_d  =1'b0; 
             u5_pack_le2_d  =1'b0; 
             u5_mc_c_oe_d  =1'b1;
             case ( u5_state ) 
              u5_POR  :
                  begin 
                      if ( u5_tmr_done ) 
                          u5_next_state  = u5_IDLE ;
                  end  
              u5_IDLE  :
                  begin  
                      u5_cs_le_d  = u5_wb_stb_first ; 
                      u5_burst_cnt_ld  =1'b1; 
                      u5_wr_clr  =1'b1;
                      if ( u5_mem_type ==3'h3) 
                          u5_tmr2_ld_tscsto  =1'b1;
                      if ( u5_mem_type ==3'h1) 
                          u5_tmr2_ld_tsrdv  =1'b1;
                      if ( u5_rfr_req )
                          begin  
                              u5_rfr_ack_d  =1'b1; 
                              u5_next_state  = u5_PRECHARGE ;
                          end 
                       else 
                          if ( u5_init_req )
                              begin  
                                  u5_cs_le_d  =1'b1; 
                                  u5_next_state  = u5_INIT0 ;
                              end 
                           else 
                              if ( u5_lmr_req & u5_lookup_ready2 )
                                  begin  
                                      u5_lmr_ack_d  =1'b1; 
                                      u5_cs_le_d  =1'b1; 
                                      u5_next_state  = u5_LMR0 ;
                                  end 
                               else 
                                  if ( u5_susp_req_r &! u5_wb_cycle )
                                      begin  
                                          u5_cs_le_d  =1'b1; 
                                          u5_susp_sel_set  =1'b1; 
                                          u5_next_state  = u5_SUSP1 ;
                                      end 
                                   else 
                                      if ( u5_cs_a &( u5_wb_read_go | u5_wb_write_go )& u5_lookup_ready2 )
                                          begin  
                                              u5_wb_cycle_set  =1'b1;
                                              case ( u5_mem_type )
                                               3 'h0:
                                                   if (( u5_lookup_ready2 )&! u5_wb_wait )
                                                       begin 
                                                           if ( u5_wb_write_go |( u5_wb_we_i & u5_wb_stb_i )) 
                                                               u5_wr_set  =1'b1;
                                                           if ( u5_kro & u5_bank_open & u5_row_same ) 
                                                               u5_next_state  = u5_SD_RD_WR ;
                                                            else 
                                                               if ( u5_kro & u5_bank_open ) 
                                                                   u5_next_state  = u5_PRECHARGE ;
                                                                else  
                                                                   u5_next_state  = u5_ACTIVATE ;
                                                       end 
                                               3 'h2:
                                                   begin 
                                                       if (! u5_wb_wait )
                                                           begin  
                                                               u5_cs_le_d  =1'b1;
                                                               if ( u5_wb_write_go )
                                                                   begin  
                                                                       u5_data_oe_d  =1'b1; 
                                                                       u5_next_state  = u5_ACS_WR ;
                                                                   end 
                                                                else  
                                                                   u5_next_state  = u5_ACS_RD ;
                                                           end 
                                                   end 
                                               3 'h3:
                                                   begin 
                                                       if (! u5_wb_wait )
                                                           begin  
                                                               u5_cs_le_d  =1'b1;
                                                               if ( u5_wb_write_go )
                                                                   begin  
                                                                       u5_cmd  =4'b1110; 
                                                                       u5_data_oe_d  =1'b1; 
                                                                       u5_tmr_ld_twr2  =1'b1; 
                                                                       u5_next_state  = u5_SCS_WR ;
                                                                   end 
                                                                else 
                                                                   begin  
                                                                       u5_cmd  =4'b1111; 
                                                                       u5_oe_d  =1'b1; 
                                                                       u5_tmr_ld_trdv  =1'b1; 
                                                                       u5_next_state  = u5_SCS_RD ;
                                                                   end 
                                                           end 
                                                   end 
                                               3 'h1:
                                                   begin 
                                                       if (! u5_wb_wait )
                                                           begin  
                                                               u5_cs_le_d  =1'b1;
                                                               if ( u5_wb_write_go )
                                                                   begin  
                                                                       u5_data_oe_d  =1'b1; 
                                                                       u5_mem_ack_d  =1'b1; 
                                                                       u5_next_state  = u5_SRAM_WR ;
                                                                   end 
                                                                else 
                                                                   begin  
                                                                       u5_cmd  =4'b1111; 
                                                                       u5_oe_d  =1'b1; 
                                                                       u5_mc_adsc  =1'b1; 
                                                                       u5_next_state  = u5_SRAM_RD ;
                                                                   end 
                                                           end 
                                                   end endcase
                                          end 
                                       else 
                                          if ( u5_mc_br )
                                              begin 
                                                  if (! u5_cmd_asserted2 )
                                                      begin  
                                                          u5_next_state  = u5_BG0 ; 
                                                          u5_mc_c_oe_d  =1'b0;
                                                      end 
                                              end 
                  end  
              u5_IDLE_T  :
                  begin  
                      u5_cmd_a10  = u5_cmd_a10_r ;
                      if ( u5_tmr_done & u5_wb_cycle &! u5_wb_wait ) 
                          u5_cs_le_d  =1'b1;
                      if ( u5_tmr_done ) 
                          u5_next_state  = u5_IDLE ;
                  end  
              u5_IDLE_T2  :
                  begin 
                      if ( u5_tmr2_done &(! u5_wb_wait |! u5_wb_cycle ))
                          begin  
                              u5_cs_le_d  = u5_wb_cycle ;
                              if ( u5_cs_le_r |! u5_wb_cycle ) 
                                  u5_next_state  = u5_IDLE ;
                          end 
                  end  
              u5_SCS_RD  :
                  begin  
                      u5_cmd  =4'b1111; 
                      u5_oe_d  =1'b1; 
                      u5_tmr_ld_trdv  =1'b1;
                      if ( u5_mc_ack ) 
                          u5_next_state  = u5_SCS_RD1 ;
                       else 
                          if ( u5_tmr2_done ) 
                              u5_next_state  = u5_SCS_ERR ;
                  end  
              u5_SCS_RD1  :
                  begin  
                      u5_cmd  =4'b1111; 
                      u5_oe_d  =1'b1;
                      if ( u5_tmr_done )
                          begin  
                              u5_mem_ack_d  =1'b1; 
                              u5_tmr_ld_trdz  =1'b1; 
                              u5_next_state  = u5_SCS_RD2 ;
                          end 
                  end  
              u5_SCS_RD2  :
                  begin  
                      u5_tmr_ld_trdz  =1'b1; 
                      u5_next_state  = u5_IDLE_T ;
                  end  
              u5_SCS_WR  :
                  begin  
                      u5_tmr_ld_twr2  =1'b1; 
                      u5_cmd  =4'b1110; 
                      u5_data_oe_d  =1'b1;
                      if ( u5_mc_ack ) 
                          u5_next_state  = u5_SCS_WR1 ;
                       else 
                          if ( u5_tmr2_done ) 
                              u5_next_state  = u5_SCS_ERR ;
                  end  
              u5_SCS_WR1  :
                  begin  
                      u5_data_oe_d  =1'b1;
                      if ( u5_tmr_done )
                          begin  
                              u5_mem_ack_d  =1'b1; 
                              u5_next_state  = u5_IDLE_T ;
                          end 
                       else  
                          u5_cmd  =4'b1110;
                  end  
              u5_SCS_ERR  :
                  begin  
                      u5_mem_ack_d  =1'b1; 
                      u5_err_d  =1'b1; 
                      u5_next_state  = u5_IDLE_T2 ;
                  end  
              u5_SRAM_RD  :
                  begin  
                      u5_cmd  =4'b1111; 
                      u5_oe_d  =1'b1; 
                      u5_mc_adsc  =1'b1; 
                      u5_tmr2_ld_tsrdv  =1'b1; 
                      u5_burst_cnt_ld_4  =1'b1;
                      if ( u5_cmd_asserted ) 
                          u5_next_state  = u5_SRAM_RD0 ;
                  end  
              u5_SRAM_RD0  :
                  begin  
                      u5_mc_adv  =1'b1; 
                      u5_oe_d  =1'b1;
                      if ( u5_tmr2_done )
                          begin  
                              u5_mc_adv  =! u5_wb_wait ; 
                              u5_next_state  = u5_SRAM_RD1 ;
                          end 
                  end  
              u5_SRAM_RD1  :
                  begin 
                      if ( u5_mc_adv_r ) 
                          u5_dv  =~ u5_dv_r ; 
                      u5_mc_adv  =! u5_wb_wait ;
                      if (! u5_burst_act |! u5_wb_read_go ) 
                          u5_next_state  = u5_SRAM_RD2 ;
                       else  
                          u5_oe_d  =1'b1;
                  end  
              u5_SRAM_RD2  :
                  begin 
                      if ( u5_ack_cnt_is_0 & u5_wb_read_go ) 
                          u5_next_state  = u5_SRAM_RD3 ;
                       else 
                          if (! u5_wb_read_go )
                              begin  
                                  u5_mc_adsc  =1'b1; 
                                  u5_next_state  = u5_SRAM_RD4 ;
                              end 
                  end  
              u5_SRAM_RD3  :
                  begin 
                      if (! u5_wb_read_go )
                          begin  
                              u5_mc_adsc  =1'b1; 
                              u5_next_state  = u5_SRAM_RD4 ;
                          end 
                       else 
                          if (! u5_wb_wait )
                              begin  
                                  u5_cs_le_d  =1'b1; 
                                  u5_next_state  = u5_SRAM_RD ;
                              end 
                  end  
              u5_SRAM_RD4  :
                  begin 
                      if ( u5_wb_cycle ) 
                          u5_cs_le_d  =1'b1; 
                      u5_mc_adsc  =1'b1; 
                      u5_next_state  = u5_IDLE ;
                  end  
              u5_SRAM_WR  :
                  begin  
                      u5_cmd  =4'b1110; 
                      u5_mc_adsc  =1'b1; 
                      u5_data_oe_d  =1'b1;
                      if ( u5_cmd_asserted )
                          begin 
                              if ( u5_wb_wait ) 
                                  u5_next_state  = u5_SRAM_WR0 ;
                               else 
                                  if (! u5_wb_write_go )
                                      begin  
                                          u5_mc_adsc  =1'b1; 
                                          u5_next_state  = u5_SRAM_RD4 ;
                                      end 
                                   else 
                                      begin  
                                          u5_data_oe_d  =1'b1; 
                                          u5_mem_ack_d  =~ u5_mem_ack_r ;
                                      end 
                          end 
                  end  
              u5_SRAM_WR0  :
                  begin 
                      if ( u5_wb_wait ) 
                          u5_next_state  = u5_SRAM_WR0 ;
                       else 
                          if (! u5_wb_write_go )
                              begin  
                                  u5_mc_adsc  =1'b1; 
                                  u5_next_state  = u5_SRAM_RD4 ;
                              end 
                           else 
                              begin  
                                  u5_data_oe_d  =1'b1; 
                                  u5_next_state  = u5_SRAM_WR ;
                              end 
                  end  
              u5_ACS_RD  :
                  begin  
                      u5_cmd  =4'b1111; 
                      u5_oe_d  =1'b1; 
                      u5_tmr2_ld_trdv  =1'b1; 
                      u5_next_state  = u5_ACS_RD1 ;
                  end  
              u5_ACS_RD1  :
                  begin  
                      u5_cmd  =4'b1111; 
                      u5_oe_d  =1'b1;
                      if ( u5_tmr2_done )
                          begin 
                              if ( u5_bw8 | u5_bw16 ) 
                                  u5_next_adr  =1'b1;
                              if ( u5_bw8 ) 
                                  u5_next_state  = u5_ACS_RD_8_1 ;
                               else 
                                  if ( u5_bw16 ) 
                                      u5_next_state  = u5_ACS_RD_8_5 ;
                                   else  
                                      u5_next_state  = u5_ACS_RD2A ;
                          end 
                  end  
              u5_ACS_RD_8_1  :
                  begin  
                      u5_pack_le0_d  =1'b1; 
                      u5_cmd  =4'b1111; 
                      u5_oe_d  =1'b1; 
                      u5_tmr2_ld_trdv  =1'b1; 
                      u5_next_state  = u5_ACS_RD_8_2 ;
                  end  
              u5_ACS_RD_8_2  :
                  begin  
                      u5_cmd  =4'b1111; 
                      u5_oe_d  =1'b1;
                      if ( u5_tmr2_done )
                          begin  
                              u5_next_adr  =1'b1; 
                              u5_next_state  = u5_ACS_RD_8_3 ;
                          end 
                  end  
              u5_ACS_RD_8_3  :
                  begin  
                      u5_pack_le1_d  =1'b1; 
                      u5_cmd  =4'b1111; 
                      u5_oe_d  =1'b1; 
                      u5_tmr2_ld_trdv  =1'b1; 
                      u5_next_state  = u5_ACS_RD_8_4 ;
                  end  
              u5_ACS_RD_8_4  :
                  begin  
                      u5_cmd  =4'b1111; 
                      u5_oe_d  =1'b1;
                      if ( u5_tmr2_done )
                          begin  
                              u5_next_adr  =1'b1; 
                              u5_next_state  = u5_ACS_RD_8_5 ;
                          end 
                  end  
              u5_ACS_RD_8_5  :
                  begin 
                      if ( u5_bw8 ) 
                          u5_pack_le2_d  =1'b1;
                      if ( u5_bw16 ) 
                          u5_pack_le0_d  =1'b1; 
                      u5_cmd  =4'b1111; 
                      u5_oe_d  =1'b1; 
                      u5_tmr2_ld_trdv  =1'b1; 
                      u5_next_state  = u5_ACS_RD_8_6 ;
                  end  
              u5_ACS_RD_8_6  :
                  begin  
                      u5_cmd  =4'b1111; 
                      u5_oe_d  =1'b1;
                      if ( u5_tmr2_done )
                          begin  
                              u5_next_state  = u5_ACS_RD2 ;
                          end 
                  end  
              u5_ACS_RD2A  :
                  begin  
                      u5_oe_d  =1'b1; 
                      u5_cmd  =4'b1111; 
                      u5_next_state  = u5_ACS_RD2 ;
                  end  
              u5_ACS_RD2  :
                  begin  
                      u5_cmd  =4'b1111; 
                      u5_next_state  = u5_ACS_RD3 ;
                  end  
              u5_ACS_RD3  :
                  begin  
                      u5_mem_ack_d  =1'b1; 
                      u5_tmr2_ld_trdz  =1'b1; 
                      u5_next_state  = u5_IDLE_T2 ;
                  end  
              u5_ACS_WR  :
                  begin  
                      u5_tmr2_ld_twpw  =1'b1; 
                      u5_cmd  =4'b1110; 
                      u5_data_oe_d  =1'b1; 
                      u5_next_state  = u5_ACS_WR1 ;
                  end  
              u5_ACS_WR1  :
                  begin 
                      if (! u5_cmd_asserted ) 
                          u5_tmr2_ld_twpw  =1'b1; 
                      u5_cmd  =4'b1110; 
                      u5_data_oe_d  =1'b1;
                      if ( u5_tmr2_done )
                          begin  
                              u5_tmr2_ld_twd  =1'b1; 
                              u5_next_state  = u5_ACS_WR2 ;
                          end 
                  end  
              u5_ACS_WR2  :
                  begin 
                      if ( u5_twd_is_zero ) 
                          u5_next_state  = u5_ACS_WR3 ;
                       else 
                          begin  
                              u5_cmd  =4'b1111; 
                              u5_data_oe_d  =1'b1; 
                              u5_next_state  = u5_ACS_WR3 ;
                          end 
                  end  
              u5_ACS_WR3  :
                  begin 
                      if ( u5_tmr2_done ) 
                          u5_next_state  = u5_ACS_WR4 ;
                       else  
                          u5_cmd  =4'b1111;
                  end  
              u5_ACS_WR4  :
                  begin  
                      u5_tmr2_ld_twwd  =1'b1; 
                      u5_mem_ack_d  =1'b1; 
                      u5_next_state  = u5_IDLE_T2 ;
                  end  
              u5_PRECHARGE  :
                  begin  
                      u5_cmd  =4'b1010;
                      if ( u5_rfr_ack_r )
                          begin  
                              u5_rfr_ack_d  =1'b1; 
                              u5_cmd_a10  =1'b1; 
                              u5_bank_clr_all  =1'b1;
                          end 
                       else 
                          begin  
                              u5_bank_clr  =1'b1; 
                              u5_cmd_a10  =1'b0;
                          end  
                      u5_tmr_ld_trp  =1'b1;
                      if ( u5_cmd_asserted ) 
                          u5_next_state  = u5_PRECHARGE_W ;
                  end  
              u5_PRECHARGE_W  :
                  begin  
                      u5_rfr_ack_d  = u5_rfr_ack_r ;
                      if ( u5_tmr_done )
                          begin 
                              if ( u5_rfr_ack_r ) 
                                  u5_next_state  = u5_REFR ;
                               else  
                                  u5_next_state  = u5_ACTIVATE ;
                          end 
                  end  
              u5_ACTIVATE  :
                  begin 
                      if (! u5_wb_wait_r )
                          begin  
                              u5_row_sel  =1'b1; 
                              u5_tmr_ld_trcd  =1'b1; 
                              u5_cmd  =4'b1011;
                          end 
                      if ( u5_cmd_asserted ) 
                          u5_next_state  = u5_ACTIVATE_W ;
                  end  
              u5_ACTIVATE_W  :
                  begin  
                      u5_row_sel  =1'b1;
                      if ( u5_wb_write_go |( u5_wb_we_i & u5_wb_stb_i )) 
                          u5_wr_set  =1'b1;
                      if ( u5_kro ) 
                          u5_bank_set  =1'b1;
                      if ( u5_tmr_done )
                          begin 
                              if ( u5_wb_write_go )
                                  begin  
                                      u5_mem_ack_d  =~ u5_mem_ack_r ; 
                                      u5_cmd_a10  = u5_ap_en |( u5_single_write &! u5_kro ); 
                                      u5_next_state  = u5_SD_WR ;
                                  end 
                               else 
                                  if (! u5_wb_wait_r ) 
                                      u5_next_state  = u5_SD_RD ;
                          end 
                  end  
              u5_SD_RD_WR  :
                  begin 
                      if ( u5_wb_write_go |( u5_wb_we_i & u5_wb_stb_i )) 
                          u5_wr_set  =1'b1;
                      if ( u5_wb_write_go &! u5_wb_wait )
                          begin  
                              u5_data_oe_d  =1'b1; 
                              u5_mem_ack_d  =~ u5_mem_ack_r ; 
                              u5_cmd_a10  = u5_ap_en |( u5_single_write &! u5_kro ); 
                              u5_next_state  = u5_SD_WR ;
                          end 
                       else 
                          if (! u5_wb_wait )
                              begin 
                                  if ( u5_kro )
                                      begin 
                                          if (! u5_wb_wait_r ) 
                                              u5_next_state  = u5_SD_RD ;
                                      end 
                                   else  
                                      u5_next_state  = u5_SD_RD ;
                              end 
                  end  
              u5_SD_WR  :
                  begin  
                      u5_data_oe_d  =1'b1; 
                      u5_tmr_ld_twr  =1'b1; 
                      u5_cnt_next  =~ u5_cnt ; 
                      u5_cmd  =4'b1100; 
                      u5_cmd_a10  = u5_ap_en |( u5_single_write &! u5_kro );
                      if (! u5_cnt & u5_wb_cycle & u5_burst_act ) 
                          u5_cke_d  =~ u5_wb_wait ;
                       else  
                          u5_cke_d  = u5_cke_r ;
                      if ( u5_cmd_asserted )
                          begin  
                              u5_mem_ack_d  =! u5_mem_ack_r & u5_wb_write_go &! u5_wb_wait & u5_wb_cycle & u5_burst_act ;
                              if ( u5_wb_cycle &! u5_burst_act ) 
                                  u5_next_state  = u5_IDLE_T ;
                               else 
                                  if ( u5_wb_write_go ) 
                                      u5_next_state  = u5_SD_WR_W ;
                                   else 
                                      if ( u5_burst_act &! u5_single_write ) 
                                          u5_next_state  = u5_BT ;
                                       else 
                                          if (! u5_ap_en ) 
                                              u5_next_state  = u5_BT_W ;
                                           else  
                                              u5_next_state  = u5_IDLE_T ;
                          end 
                  end  
              u5_SD_WR_W  :
                  begin  
                      u5_tmr_ld_twr  =1'b1; 
                      u5_cnt_next  =~ u5_cnt ;
                      if ( u5_single_write & u5_wb_cycle )
                          begin  
                              u5_cmd  =4'b1100;
                          end  
                      u5_cmd_a10  = u5_ap_en |( u5_single_write &! u5_kro ); 
                      u5_data_oe_d  =1'b1; 
                      u5_mem_ack_d  =! u5_mem_ack_r & u5_wb_write_go &! u5_wb_wait & u5_wr_cycle & u5_burst_act ;
                      if (! u5_cnt ) 
                          u5_cke_d  =~ u5_wb_wait ;
                       else  
                          u5_cke_d  = u5_cke_r ;
                      if (( u5_single_write & u5_cke_r )|(! u5_single_write &! u5_cnt &! u5_wb_wait )|(! u5_single_write & u5_cnt & u5_cke_r ))
                          begin 
                              if ( u5_single_write &! u5_wb_cycle ) 
                                  u5_next_state  = u5_IDLE_T ;
                               else 
                                  if ( u5_burst_act &! u5_single_write &! u5_wb_write_go_r )
                                      begin  
                                          u5_cmd  =4'b1110; 
                                          u5_next_state  = u5_BT ;
                                      end 
                                   else 
                                      if (! u5_burst_act &! u5_ap_en ) 
                                          u5_next_state  = u5_BT_W ;
                                       else 
                                          if (! u5_burst_act ) 
                                              u5_next_state  = u5_IDLE_T ;
                                           else 
                                              if (! u5_wb_write_go_r & u5_wb_read_go ) 
                                                  u5_next_state  = u5_IDLE_T ;
                          end 
                  end  
              u5_SD_RD  :
                  begin  
                      u5_cmd  =4'b1101; 
                      u5_cmd_a10  = u5_ap_en ; 
                      u5_tmr_ld_tcl  =1'b1;
                      if ( u5_cmd_asserted ) 
                          u5_next_state  = u5_SD_RD_W ;
                  end  
              u5_SD_RD_W  :
                  begin 
                      if ( u5_tmr_done ) 
                          u5_next_state  = u5_SD_RD_LOOP ;
                  end  
              u5_SD_RD_LOOP  :
                  begin  
                      u5_cnt_next  =~ u5_cnt ;
                      if ( u5_cnt &!( u5_burst_act &! u5_wb_cycle )& u5_burst_act ) 
                          u5_cke_rd  =! u5_wb_wait ;
                       else  
                          u5_cke_rd  = u5_cke_ ;
                      if ( u5_wb_cycle &! u5_cnt & u5_burst_act_rd & u5_cke_o_del ) 
                          u5_dv  =1'b1;
                      if ( u5_wb_cycle & u5_wb_write_go ) 
                          u5_next_state  = u5_BT ;
                       else 
                          if ( u5_burst_act &! u5_wb_cycle ) 
                              u5_next_state  = u5_BT ;
                           else 
                              if (! u5_burst_act ) 
                                  u5_next_state  = u5_SD_RD_W2 ;
                  end  
              u5_SD_RD_W2  :
                  begin 
                      if ( u5_wb_write_go | u5_ack_cnt_is_0 )
                          begin 
                              if (! u5_ap_en &! u5_kro ) 
                                  u5_next_state  = u5_BT_W ;
                               else 
                                  if (! u5_wb_wait &! u5_mem_ack_r ) 
                                      u5_next_state  = u5_IDLE_T ;
                          end 
                  end  
              u5_BT  :
                  begin  
                      u5_cmd  =4'b1110; 
                      u5_tmr_ld_trp  =1'b1;
                      if ( u5_cmd_asserted ) 
                          u5_next_state  = u5_BT_W ;
                  end  
              u5_BT_W  :
                  begin  
                      u5_cmd_a10  = u5_cmd_a10_r ;
                      if ( u5_kro & u5_tmr_done )
                          begin 
                              if ( u5_kro &! u5_wb_wait &( u5_wb_read_go | u5_wb_write_go )) 
                                  u5_cs_le_d  =1'b1; 
                              u5_next_state  = u5_IDLE ;
                          end 
                       else 
                          if (! u5_kro & u5_tmr_done )
                              begin  
                                  u5_bank_clr  =1'b1; 
                                  u5_cmd  =4'b1010; 
                                  u5_cmd_a10  =1'b0; 
                                  u5_tmr_ld_trp  =1'b1;
                                  if ( u5_cmd_asserted ) 
                                      u5_next_state  = u5_IDLE_T ;
                              end 
                  end  
              u5_REFR  :
                  begin  
                      u5_cs_le_d  =1'b1; 
                      u5_cmd  =4'b1001; 
                      u5_tmr_ld_trfc  =1'b1; 
                      u5_rfr_ack_d  =1'b1;
                      if ( u5_cmd_asserted )
                          begin  
                              u5_susp_sel_clr  =1'b1; 
                              u5_next_state  = u5_IDLE_T ;
                          end 
                  end  
              u5_LMR0  :
                  begin  
                      u5_lmr_ack_d  =1'b1; 
                      u5_cmd  =4'b1010; 
                      u5_cmd_a10  =1'b1; 
                      u5_bank_clr_all  =1'b1; 
                      u5_tmr_ld_trp  =1'b1;
                      if ( u5_cmd_asserted ) 
                          u5_next_state  = u5_LMR1 ;
                  end  
              u5_LMR1  :
                  begin  
                      u5_lmr_ack_d  =1'b1;
                      if ( u5_tmr_done ) 
                          u5_next_state  = u5_LMR2 ;
                  end  
              u5_LMR2  :
                  begin  
                      u5_bank_clr_all  =1'b1; 
                      u5_cmd  =4'b1000; 
                      u5_tmr_ld_trfc  =1'b1; 
                      u5_lmr_ack_d  =1'b1;
                      if ( u5_cmd_asserted ) 
                          u5_next_state  = u5_IDLE_T ;
                  end  
              u5_INIT0  :
                  begin  
                      u5_cs_le_d  =1'b1; 
                      u5_next_state  = u5_INIT ;
                  end  
              u5_INIT  :
                  begin  
                      u5_init_ack  =1'b1; 
                      u5_cmd  =4'b1010; 
                      u5_cmd_a10  =1'b1; 
                      u5_bank_clr_all  =1'b1; 
                      u5_tmr_ld_trp  =1'b1; 
                      u5_ir_cnt_ld  =1'b1;
                      if ( u5_cmd_asserted ) 
                          u5_next_state  = u5_INIT_W ;
                  end  
              u5_INIT_W  :
                  begin  
                      u5_init_ack  =1'b1;
                      if ( u5_tmr_done ) 
                          u5_next_state  = u5_INIT_REFR1 ;
                  end  
              u5_INIT_REFR1  :
                  begin  
                      u5_init_ack  =1'b1; 
                      u5_cmd  =4'b1001; 
                      u5_tmr_ld_trfc  =1'b1;
                      if ( u5_cmd_asserted )
                          begin  
                              u5_ir_cnt_dec  =1'b1; 
                              u5_next_state  = u5_INIT_REFR1_W ;
                          end 
                  end  
              u5_INIT_REFR1_W  :
                  begin  
                      u5_init_ack  =1'b1;
                      if ( u5_tmr_done )
                          begin 
                              if ( u5_ir_cnt_done ) 
                                  u5_next_state  = u5_INIT_LMR ;
                               else  
                                  u5_next_state  = u5_INIT_REFR1 ;
                          end 
                  end  
              u5_INIT_LMR  :
                  begin  
                      u5_init_ack  =1'b1; 
                      u5_cmd  =4'b1000; 
                      u5_bank_clr_all  =1'b1; 
                      u5_tmr_ld_trfc  =1'b1;
                      if ( u5_cmd_asserted ) 
                          u5_next_state  = u5_IDLE_T ;
                  end  
              u5_BG0  :
                  begin  
                      u5_mc_bg  =1'b1; 
                      u5_mc_c_oe_d  =1'b0; 
                      u5_next_state  = u5_BG1 ;
                  end  
              u5_BG1  :
                  begin  
                      u5_mc_bg  =1'b1; 
                      u5_cs_le_d  =1'b1; 
                      u5_mc_c_oe_d  =1'b0; 
                      u5_next_state  = u5_BG2 ;
                  end  
              u5_BG2  :
                  begin  
                      u5_cs_le_d  =1'b1; 
                      u5_mc_bg  =! u5_wb_read_go &! u5_wb_write_go &! u5_rfr_req &! u5_init_req &! u5_lmr_req &! u5_susp_req_r ; 
                      u5_tmr_ld_tavav  =1'b1; 
                      u5_mc_c_oe_d  = u5_mc_br ;
                      if (! u5_mc_br ) 
                          u5_next_state  = u5_IDLE_T ;
                  end  
              u5_SUSP1  :
                  begin  
                      u5_cmd  =4'b1010; 
                      u5_cmd_a10  =1'b1; 
                      u5_bank_clr_all  =1'b1; 
                      u5_tmr_ld_trp  =1'b1;
                      if ( u5_cmd_asserted ) 
                          u5_next_state  = u5_SUSP2 ;
                  end  
              u5_SUSP2  :
                  begin 
                      if ( u5_tmr_done ) 
                          u5_next_state  = u5_SUSP3 ;
                  end  
              u5_SUSP3  :
                  begin  
                      u5_cke_d  =1'b0; 
                      u5_cmd  =4'b1001; 
                      u5_rfr_ack_d  =1'b1;
                      if ( u5_cmd_asserted )
                          begin  
                              u5_next_state  = u5_SUSP4 ;
                          end 
                  end  
              u5_SUSP4  :
                  begin  
                      u5_cke_rd  =1'b0; 
                      u5_suspended_d  =1'b1; 
                      u5_tmr_ld_txsr  =1'b1;
                      if ( u5_resume_req_r ) 
                          u5_next_state  = u5_RESUME1 ;
                  end  
              u5_RESUME1  :
                  begin  
                      u5_suspended_d  =1'b1; 
                      u5_tmr_ld_txsr  =1'b1; 
                      u5_next_state  = u5_RESUME2 ;
                  end  
              u5_RESUME2  :
                  begin  
                      u5_suspended_d  =1'b1;
                      if ( u5_tmr_done ) 
                          u5_next_state  = u5_REFR ;
                  end endcase
         end
 
    assign u5_clk = clk_i;
    assign u5_rst = rst_i;
    assign u5_wb_cyc_i = wb_cyc_i;
    assign u5_wb_stb_i = wb_stb_i;
    assign u5_wb_we_i = wb_we_i;
    assign u5_wb_read_go = wb_read_go;
    assign u5_wb_write_go = wb_write_go;
    assign u5_wb_first = wb_first;
    assign u5_wb_wait = wb_wait;
    assign mem_ack = u5_mem_ack;
    assign err = u5_err;
    assign u5_susp_req = susp_req_i;
    assign u5_resume_req = resume_req_i;
    assign suspended_o = u5_suspended;
    assign susp_sel = u5_susp_sel;
    assign u5_mc_clk = mc_clk_i;
    assign data_oe = u5_data_oe;
    assign oe_ = u5_oe_;
    assign we_ = u5_we_;
    assign cas_ = u5_cas_;
    assign ras_ = u5_ras_;
    assign cke_ = u5_cke_;
    assign cs_en = u5_cs_en;
    assign wb_cycle = u5_wb_cycle;
    assign wr_cycle = u5_wr_cycle;
    assign u5_mc_br = mc_br_r;
    assign mc_bg_d = u5_mc_bg;
    assign mc_adsc_d = u5_mc_adsc;
    assign mc_adv_d = u5_mc_adv;
    assign mc_c_oe_d = u5_mc_c_oe;
    assign u5_mc_ack = mc_ack_r;
    assign u5_not_mem_cyc = not_mem_cyc;
    assign u5_csc = csc_s;
    assign u5_tms = tms_s;
    assign u5_cs = obct_cs;
    assign u5_lmr_req = lmr_req;
    assign lmr_ack = u5_lmr_ack;
    assign cs_le = u5_cs_le;
    assign cs_le_d = u5_cs_le_d;
    assign u5_page_size = page_size;
    assign cmd_a10 = u5_cmd_a10;
    assign row_sel = u5_row_sel;
    assign next_adr = u5_next_adr;
    assign bank_set = u5_bank_set;
    assign bank_clr = u5_bank_clr;
    assign bank_clr_all = u5_bank_clr_all;
    assign u5_bank_open = bank_open;
    assign u5_any_bank_open = any_bank_open;
    assign u5_row_same = row_same;
    assign dv = u5_dv;
    assign pack_le0 = u5_pack_le0;
    assign pack_le1 = u5_pack_le1;
    assign pack_le2 = u5_pack_le2;
    assign u5_par_err = par_err;
    assign u5_rfr_req = rfr_req;
    assign rfr_ack = u5_rfr_ack;
    assign u5_init_req = init_req;
    assign init_ack = u5_init_ack;
    

wire u6_clk;
    wire u6_rst;
    wire[31:0] u6_wb_addr_i;
    wire u6_wb_cyc_i;
    wire u6_wb_stb_i;
    wire u6_wb_we_i;
    wire u6_wb_err;
    wire u6_wb_ack_o;
    wire u6_wb_read_go;
    wire u6_wb_write_go;
    wire u6_wb_first;
    wire u6_wb_wait;
    wire u6_mem_ack;
    wire u6_wr_hold;
    wire u6_err;
    wire u6_par_err;
    wire u6_wp_err;
    wire[31:0] u6_wb_data_o;
    wire[31:0] u6_mem_dout;
    wire[31:0] u6_rf_dout;

    wire u6_mem_sel ; 
    reg u6_read_go_r ; 
    reg u6_read_go_r1 ; 
    reg u6_write_go_r ; 
    reg u6_write_go_r1 ; 
    reg u6_wb_first_r ; 
    wire u6_wb_first_set ; 
    reg u6_wr_hold ; 
    wire u6_rmw ; 
    reg u6_rmw_r ; 
    reg u6_rmw_en ; 
    reg u6_wb_ack_o ; 
    reg u6_wb_err ; reg[31:0] u6_wb_data_o ; 
  assign  u6_mem_sel =( u6_wb_addr_i [31:29]==3'h0); 
  always @(  posedge   u6_clk          or  posedge  u6_rst )
         if ( u6_rst ) 
             u6_rmw_en  <=1'b0;
          else 
             if ( u6_wb_ack_o ) 
                 u6_rmw_en  <=1'b1;
              else 
                 if (! u6_wb_cyc_i ) 
                     u6_rmw_en  <=1'b0;
  always @(  posedge   u6_clk          or  posedge  u6_rst )
         if ( u6_rst ) 
             u6_rmw_r  <=1'b0;
          else  
             u6_rmw_r  <=! u6_wr_hold & u6_wb_we_i & u6_wb_cyc_i & u6_wb_stb_i & u6_rmw_en ;
  assign  u6_rmw = u6_rmw_r |(! u6_wr_hold & u6_wb_we_i & u6_wb_cyc_i & u6_wb_stb_i & u6_rmw_en ); 
  always @(  posedge   u6_clk          or  posedge  u6_rst )
         if ( u6_rst ) 
             u6_read_go_r1  <=1'b0;
          else  
             u6_read_go_r1  <=! u6_rmw & u6_wb_cyc_i &(( u6_wb_stb_i & u6_mem_sel &! u6_wb_we_i )| u6_read_go_r );
  always @(  posedge   u6_clk          or  posedge  u6_rst )
         if ( u6_rst ) 
             u6_read_go_r  <=1'b0;
          else  
             u6_read_go_r  <= u6_read_go_r1 & u6_wb_cyc_i ;
  assign  u6_wb_read_go =! u6_rmw & u6_read_go_r1 & u6_wb_cyc_i ; 
  always @(  posedge   u6_clk          or  posedge  u6_rst )
         if ( u6_rst ) 
             u6_write_go_r1  <=1'b0;
          else  
             u6_write_go_r1  <= u6_wb_cyc_i &(( u6_wb_stb_i & u6_mem_sel & u6_wb_we_i )| u6_write_go_r );
  always @(  posedge   u6_clk          or  posedge  u6_rst )
         if ( u6_rst ) 
             u6_write_go_r  <=1'b0;
          else  
             u6_write_go_r  <= u6_write_go_r1 & u6_wb_cyc_i &(( u6_wb_we_i & u6_wb_stb_i )|! u6_wb_stb_i );
  assign  u6_wb_write_go =! u6_rmw & u6_write_go_r1 & u6_wb_cyc_i &(( u6_wb_we_i & u6_wb_stb_i )|! u6_wb_stb_i ); 
  assign  u6_wb_first_set = u6_mem_sel & u6_wb_cyc_i & u6_wb_stb_i &!( u6_read_go_r | u6_write_go_r ); 
  assign  u6_wb_first = u6_wb_first_set |( u6_wb_first_r &! u6_wb_ack_o &! u6_wb_err ); 
  always @(  posedge   u6_clk          or  posedge  u6_rst )
         if ( u6_rst ) 
             u6_wb_first_r  <=1'b0;
          else 
             if ( u6_wb_first_set ) 
                 u6_wb_first_r  <=1'b1;
              else 
                 if ( u6_wb_ack_o | u6_wb_err ) 
                     u6_wb_first_r  <=1'b0;
  always @(  posedge   u6_clk          or  posedge  u6_rst )
         if ( u6_rst ) 
             u6_wr_hold  <=1'b0;
          else 
             if ( u6_wb_cyc_i & u6_wb_stb_i ) 
                 u6_wr_hold  <= u6_wb_we_i ;
    wire u6_wb_err_d ; 
  always @(  posedge   u6_clk          or  posedge  u6_rst )
         if ( u6_rst ) 
             u6_wb_ack_o  <=1'b0;
          else  
             u6_wb_ack_o  <=( u6_wb_addr_i [31:29]==3'h0) ?  u6_mem_ack &! u6_wb_err_d :( u6_wb_addr_i [31:29]==3'b011)& u6_wb_cyc_i & u6_wb_stb_i &! u6_wb_ack_o ;
  assign  u6_wb_err_d = u6_wb_cyc_i & u6_wb_stb_i &( u6_par_err | u6_err | u6_wp_err ); 
  always @(  posedge   u6_clk          or  posedge  u6_rst )
         if ( u6_rst ) 
             u6_wb_err  <=1'b0;
          else  
             u6_wb_err  <=( u6_wb_addr_i [31:29]==3'h0)& u6_wb_err_d &! u6_wb_err ;
  assign  u6_wb_wait = u6_wb_cyc_i &! u6_wb_stb_i &( u6_wb_write_go | u6_wb_read_go ); 
  always @( posedge  u6_clk ) 
         u6_wb_data_o  <=( u6_wb_addr_i [31:29]==3'h0) ?  u6_mem_dout : u6_rf_dout ;

    assign u6_clk = clk_i;
    assign u6_rst = rst_i;
    assign u6_wb_addr_i = wb_addr_i;
    assign u6_wb_cyc_i = wb_cyc_i;
    assign u6_wb_stb_i = wb_stb_i;
    assign u6_wb_we_i = wb_we_i;
    assign wb_err_o = u6_wb_err;
    assign wb_ack_o = u6_wb_ack_o;
    assign wb_read_go = u6_wb_read_go;
    assign wb_write_go = u6_wb_write_go;
    assign wb_first = u6_wb_first;
    assign wb_wait = u6_wb_wait;
    assign u6_mem_ack = mem_ack;
    assign wr_hold = u6_wr_hold;
    assign u6_err = err;
    assign u6_par_err = par_err;
    assign u6_wp_err = wp_err;
    assign wb_data_o = u6_wb_data_o;
    assign u6_mem_dout = mem_dout;
    assign u6_rf_dout = rf_dout;
    

wire u7_clk;
    wire u7_rst;
    wire u7_mc_clk;
    wire u7_mc_br;
    wire u7_mc_bg;
    wire[23:0] u7_mc_addr;
    wire[31:0] u7_mc_data_o;
    wire[3:0] u7_mc_dp_o;
    wire u7_mc_data_oe;
    wire[3:0] u7_mc_dqm;
    wire u7_mc_oe_;
    wire u7_mc_we_;
    wire u7_mc_cas_;
    wire u7_mc_ras_;
    wire u7_mc_cke_;
    wire[7:0] u7_mc_cs_;
    wire u7_mc_adsc_;
    wire u7_mc_adv_;
    wire u7_mc_ack;
    wire u7_mc_rp;
    wire u7_mc_c_oe;
    wire[35:0] u7_mc_data_ir;
    wire u7_mc_sts_ir;
    wire u7_mc_zz_o;
    wire u7_mc_br_r;
    wire u7_mc_bg_d;
    wire u7_data_oe;
    wire u7_susp_sel;
    wire u7_suspended_o;
    wire[31:0] u7_mc_data_od;
    wire[3:0] u7_mc_dp_od;
    wire[23:0] u7_mc_addr_d;
    wire u7_mc_ack_r;
    wire u7_wb_cyc_i;
    wire u7_wb_stb_i;
    wire[3:0] u7_wb_sel_i;
    wire u7_wb_cycle;
    wire u7_wr_cycle;
    wire u7_oe_;
    wire u7_we_;
    wire u7_ras_;
    wire u7_cas_;
    wire u7_cke_;
    wire u7_cs_en;
    wire u7_rfr_ack;
    wire[7:0] u7_cs_need_rfr;
    wire u7_lmr_sel;
    wire[7:0] u7_spec_req_cs;
    wire[7:0] u7_cs;
    wire u7_fs;
    wire u7_mc_adsc_d;
    wire u7_mc_adv_d;
    wire u7_mc_c_oe_d;
    wire[31:0] u7_mc_data_i;
    wire[3:0] u7_mc_dp_i;
    wire u7_mc_sts_i;

    reg u7_mc_data_oe ; reg[31:0] u7_mc_data_o ; reg[3:0] u7_mc_dp_o ; reg[3:0] u7_mc_dqm ; reg[3:0] u7_mc_dqm_r ; reg[23:0] u7_mc_addr ; 
    reg u7_mc_oe_ ; 
    reg u7_mc_we_ ; 
    reg u7_mc_cas_ ; 
    reg u7_mc_ras_ ; 
    wire u7_mc_cke_ ; 
    reg u7_mc_bg ; 
    reg u7_mc_adsc_ ; 
    reg u7_mc_adv_ ; 
    reg u7_mc_br_r ; 
    reg u7_mc_ack_r ; 
    reg u7_mc_rp ; 
    reg u7_mc_c_oe ; 
    reg u7_mc_zz_o ; reg[35:0] u7_mc_data_ir ; 
    reg u7_mc_sts_ir ; 
  always @( posedge  u7_mc_clk ) 
         u7_mc_zz_o  <= u7_suspended_o ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_sts_ir  <= u7_mc_sts_i ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_data_ir  <={ u7_mc_dp_i , u7_mc_data_i };
  always @( posedge  u7_mc_clk ) 
         u7_mc_c_oe  <= u7_mc_c_oe_d ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_rp  <=! u7_suspended_o &! u7_fs ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_br_r  <= u7_mc_br ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_ack_r  <= u7_mc_ack ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_bg  <= u7_mc_bg_d ;
  always @(  posedge   u7_mc_clk          or  posedge  u7_rst )
         if ( u7_rst ) 
             u7_mc_data_oe  <=1'b0;
          else  
             u7_mc_data_oe  <= u7_data_oe &! u7_susp_sel & u7_mc_c_oe_d ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_data_o  <= u7_mc_data_od ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_dp_o  <= u7_mc_dp_od ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_addr  <= u7_mc_addr_d ;
  always @( posedge  u7_clk )
         if ( u7_wb_cyc_i & u7_wb_stb_i ) 
             u7_mc_dqm_r  <= u7_wb_sel_i ;
 reg[3:0] u7_mc_dqm_r2 ; 
  always @( posedge  u7_clk ) 
         u7_mc_dqm_r2  <= u7_mc_dqm_r ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_dqm  <=#1 u7_susp_sel  ? 4'hf: u7_data_oe  ? ~ u7_mc_dqm_r2 :( u7_wb_cycle &! u7_wr_cycle ) ? 4'h0:4'hf;
  always @(  posedge   u7_mc_clk          or  posedge  u7_rst )
         if ( u7_rst ) 
             u7_mc_oe_  <=1'b1;
          else  
             u7_mc_oe_  <= u7_oe_ | u7_susp_sel ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_we_  <= u7_we_ ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_cas_  <= u7_cas_ ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_ras_  <= u7_ras_ ;
  assign  u7_mc_cke_ = u7_cke_ ; 
    reg u7_mc_cs_0 , u7_mc_cs_1 , u7_mc_cs_2 , u7_mc_cs_3 , u7_mc_cs_4 , u7_mc_cs_5 , u7_mc_cs_6 , u7_mc_cs_7 ; 
  assign  u7_mc_cs_ ={ u7_mc_cs_7 , u7_mc_cs_6 , u7_mc_cs_5 , u7_mc_cs_4 , u7_mc_cs_3 , u7_mc_cs_2 , u7_mc_cs_1 , u7_mc_cs_0 }; 
  always @(  posedge   u7_mc_clk          or  posedge  u7_rst )
         if ( u7_rst ) 
             u7_mc_cs_0  <=1'b1;
          else  
             u7_mc_cs_0  <=~( u7_cs_en &(( u7_rfr_ack | u7_susp_sel ) ?  u7_cs_need_rfr [0]: u7_lmr_sel  ?  u7_spec_req_cs [0]: u7_cs [0]));
  always @(  posedge   u7_mc_clk          or  posedge  u7_rst )
         if ( u7_rst ) 
             u7_mc_cs_1  <=1'b1;
          else  
             u7_mc_cs_1  <=~( u7_cs_en &(( u7_rfr_ack | u7_susp_sel ) ?  u7_cs_need_rfr [1]: u7_lmr_sel  ?  u7_spec_req_cs [1]: u7_cs [1]));
  always @(  posedge   u7_mc_clk          or  posedge  u7_rst )
         if ( u7_rst ) 
             u7_mc_cs_2  <=1'b1;
          else  
             u7_mc_cs_2  <=~( u7_cs_en &(( u7_rfr_ack | u7_susp_sel ) ?  u7_cs_need_rfr [2]: u7_lmr_sel  ?  u7_spec_req_cs [2]: u7_cs [2]));
  always @(  posedge   u7_mc_clk          or  posedge  u7_rst )
         if ( u7_rst ) 
             u7_mc_cs_3  <=1'b1;
          else  
             u7_mc_cs_3  <=~( u7_cs_en &(( u7_rfr_ack | u7_susp_sel ) ?  u7_cs_need_rfr [3]: u7_lmr_sel  ?  u7_spec_req_cs [3]: u7_cs [3]));
  always @(  posedge   u7_mc_clk          or  posedge  u7_rst )
         if ( u7_rst ) 
             u7_mc_cs_4  <=1'b1;
          else  
             u7_mc_cs_4  <=~( u7_cs_en &(( u7_rfr_ack | u7_susp_sel ) ?  u7_cs_need_rfr [4]: u7_lmr_sel  ?  u7_spec_req_cs [4]: u7_cs [4]));
  always @(  posedge   u7_mc_clk          or  posedge  u7_rst )
         if ( u7_rst ) 
             u7_mc_cs_5  <=1'b1;
          else  
             u7_mc_cs_5  <=~( u7_cs_en &(( u7_rfr_ack | u7_susp_sel ) ?  u7_cs_need_rfr [5]: u7_lmr_sel  ?  u7_spec_req_cs [5]: u7_cs [5]));
  always @(  posedge   u7_mc_clk          or  posedge  u7_rst )
         if ( u7_rst ) 
             u7_mc_cs_6  <=1'b1;
          else  
             u7_mc_cs_6  <=~( u7_cs_en &(( u7_rfr_ack | u7_susp_sel ) ?  u7_cs_need_rfr [6]: u7_lmr_sel  ?  u7_spec_req_cs [6]: u7_cs [6]));
  always @(  posedge   u7_mc_clk          or  posedge  u7_rst )
         if ( u7_rst ) 
             u7_mc_cs_7  <=1'b1;
          else  
             u7_mc_cs_7  <=~( u7_cs_en &(( u7_rfr_ack | u7_susp_sel ) ?  u7_cs_need_rfr [7]: u7_lmr_sel  ?  u7_spec_req_cs [7]: u7_cs [7]));
  always @( posedge  u7_mc_clk ) 
         u7_mc_adsc_  <=~ u7_mc_adsc_d ;
  always @( posedge  u7_mc_clk ) 
         u7_mc_adv_  <=~ u7_mc_adv_d ;

    assign u7_clk = clk_i;
    assign u7_rst = rst_i;
    assign u7_mc_clk = mc_clk_i;
    assign u7_mc_br = mc_br_pad_i;
    assign mc_bg_pad_o = u7_mc_bg;
    assign mc_addr_pad_o = u7_mc_addr;
    assign mc_data_pad_o = u7_mc_data_o;
    assign mc_dp_pad_o = u7_mc_dp_o;
    assign mc_doe_pad_doe_o = u7_mc_data_oe;
    assign mc_dqm_pad_o = u7_mc_dqm;
    assign mc_oe_pad_o_ = u7_mc_oe_;
    assign mc_we_pad_o_ = u7_mc_we_;
    assign mc_cas_pad_o_ = u7_mc_cas_;
    assign mc_ras_pad_o_ = u7_mc_ras_;
    assign mc_cke_pad_o_ = u7_mc_cke_;
    assign mc_cs_pad_o_ = u7_mc_cs_;
    assign mc_adsc_pad_o_ = u7_mc_adsc_;
    assign mc_adv_pad_o_ = u7_mc_adv_;
    assign u7_mc_ack = mc_ack_pad_i;
    assign mc_rp_pad_o_ = u7_mc_rp;
    assign mc_coe_pad_coe_o = u7_mc_c_oe;
    assign mc_data_ir = u7_mc_data_ir;
    assign mc_sts_ir = u7_mc_sts_ir;
    assign mc_zz_pad_o = u7_mc_zz_o;
    assign mc_br_r = u7_mc_br_r;
    assign u7_mc_bg_d = mc_bg_d;
    assign u7_data_oe = data_oe;
    assign u7_susp_sel = susp_sel;
    assign u7_suspended_o = suspended_o;
    assign u7_mc_data_od = mc_data_od;
    assign u7_mc_dp_od = mc_dp_od;
    assign u7_mc_addr_d = mc_addr_d;
    assign mc_ack_r = u7_mc_ack_r;
    assign u7_wb_cyc_i = wb_cyc_i;
    assign u7_wb_stb_i = wb_stb_i;
    assign u7_wb_sel_i = wb_sel_i;
    assign u7_wb_cycle = wb_cycle;
    assign u7_wr_cycle = wr_cycle;
    assign u7_oe_ = oe_;
    assign u7_we_ = we_;
    assign u7_ras_ = ras_;
    assign u7_cas_ = cas_;
    assign u7_cke_ = cke_;
    assign u7_cs_en = cs_en;
    assign u7_rfr_ack = rfr_ack;
    assign u7_cs_need_rfr = cs_need_rfr;
    assign u7_lmr_sel = lmr_sel;
    assign u7_spec_req_cs = spec_req_cs;
    assign u7_cs = cs;
    assign u7_fs = fs;
    assign u7_mc_adsc_d = mc_adsc_d;
    assign u7_mc_adv_d = mc_adv_d;
    assign u7_mc_c_oe_d = mc_c_oe_d;
    assign u7_mc_data_i = mc_data_pad_i;
    assign u7_mc_dp_i = mc_dp_pad_i;
    assign u7_mc_sts_i = mc_sts_pad_i;
    

endmodule