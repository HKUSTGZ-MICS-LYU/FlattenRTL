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
	    wire wbs__clk_i;
    wire wbs__rst_i;
    wire wbs__arst_i;
    wire[11:2] wbs__adr_i;
    wire[31:0] wbs__dat_i;
    reg[31:0] wbs__dat_o;
    wire[3:0] wbs__sel_i;
    wire wbs__we_i;
    wire wbs__stb_i;
    wire wbs__cyc_i;
    reg wbs__ack_o;
    reg wbs__rty_o;
    reg wbs__err_o;
    reg wbs__inta_o;
    wire wbs__wbm_busy;
    wire[1:0] wbs__dvi_odf;
    wire wbs__bl;
    wire wbs__csl;
    wire wbs__vsl;
    wire wbs__hsl;
    wire wbs__pc;
    wire[1:0] wbs__cd;
    wire[1:0] wbs__vbl;
    wire wbs__cbsw;
    wire wbs__vbsw;
    wire wbs__ven;
    wire wbs__cursor0_res;
    wire wbs__cursor0_en;
    reg[31:0] wbs__cursor0_xy;
    reg[31:11] wbs__cursor0_ba;
    reg wbs__cursor0_ld;
    wire[3:0] wbs__cc0_adr_i;
    wire[15:0] wbs__cc0_dat_o;
    wire wbs__cursor1_res;
    wire wbs__cursor1_en;
    reg[31:0] wbs__cursor1_xy;
    reg[31:11] wbs__cursor1_ba;
    reg wbs__cursor1_ld;
    wire[3:0] wbs__cc1_adr_i;
    wire[15:0] wbs__cc1_dat_o;
    wire wbs__avmp;
    wire wbs__acmp;
    wire wbs__vbsint_in;
    wire wbs__cbsint_in;
    wire wbs__hint_in;
    wire wbs__vint_in;
    wire wbs__luint_in;
    wire wbs__sint_in;
    wire[7:0] wbs__Thsync;
    wire[7:0] wbs__Thgdel;
    wire[15:0] wbs__Thgate;
    wire[15:0] wbs__Thlen;
    wire[7:0] wbs__Tvsync;
    wire[7:0] wbs__Tvgdel;
    wire[15:0] wbs__Tvgate;
    wire[15:0] wbs__Tvlen;
    reg[31:2] wbs__VBARa;
    reg[31:2] wbs__VBARb;
    wire wbs__clut_acc;
    wire wbs__clut_ack;
    wire[23:0] wbs__clut_q;

    parameter wbs__REG_ADR_HIBIT =7; 
    wire[ wbs__REG_ADR_HIBIT :0] wbs__REG_ADR = wbs__adr_i [ wbs__REG_ADR_HIBIT :2]; 
    wire wbs__CLUT_ADR = wbs__adr_i [11]; parameter[ wbs__REG_ADR_HIBIT :0] wbs__CTRL_ADR =6'b00_0000; parameter[ wbs__REG_ADR_HIBIT :0] wbs__STAT_ADR =6'b00_0001; parameter[ wbs__REG_ADR_HIBIT :0] wbs__HTIM_ADR =6'b00_0010; parameter[ wbs__REG_ADR_HIBIT :0] wbs__VTIM_ADR =6'b00_0011; parameter[ wbs__REG_ADR_HIBIT :0] wbs__HVLEN_ADR =6'b00_0100; parameter[ wbs__REG_ADR_HIBIT :0] wbs__VBARA_ADR =6'b00_0101; parameter[ wbs__REG_ADR_HIBIT :0] wbs__VBARB_ADR =6'b00_0110; parameter[ wbs__REG_ADR_HIBIT :0] wbs__C0XY_ADR =6'b00_1100; parameter[ wbs__REG_ADR_HIBIT :0] wbs__C0BAR_ADR =6'b00_1101; parameter[ wbs__REG_ADR_HIBIT :0] wbs__CCR0_ADR =6'b01_0???; parameter[ wbs__REG_ADR_HIBIT :0] wbs__C1XY_ADR =6'b01_1100; parameter[ wbs__REG_ADR_HIBIT :0] wbs__C1BAR_ADR =6'b01_1101; parameter[ wbs__REG_ADR_HIBIT :0] wbs__CCR1_ADR =6'b10_0???; reg[31:0] wbs__ctrl , wbs__stat , wbs__htim , wbs__vtim , wbs__hvlen ; 
    wire wbs__hint , wbs__vint , wbs__vbsint , wbs__cbsint , wbs__luint , wbs__sint ; 
    wire wbs__hie , wbs__vie , wbs__vbsie , wbs__cbsie ; 
    wire wbs__acc , wbs__acc32 , wbs__reg_acc , wbs__reg_wacc ; 
    wire wbs__cc0_acc , wbs__cc1_acc ; 
    wire[31:0] wbs__ccr0_dat_o , wbs__ccr1_dat_o ; reg[31:0] wbs__reg_dato ; 
  assign  wbs__acc = wbs__cyc_i & wbs__stb_i ; 
  assign  wbs__acc32 =( wbs__sel_i ==4'b1111); 
  assign  wbs__clut_acc = wbs__CLUT_ADR & wbs__acc & wbs__acc32 ; 
  assign  wbs__reg_acc =~ wbs__CLUT_ADR & wbs__acc & wbs__acc32 ; 
  assign  wbs__reg_wacc = wbs__reg_acc & wbs__we_i ; 
  assign  wbs__cc0_acc =( wbs__REG_ADR == wbs__CCR0_ADR )& wbs__acc & wbs__acc32 ; 
  assign  wbs__cc1_acc =( wbs__REG_ADR == wbs__CCR1_ADR )& wbs__acc & wbs__acc32 ; 
  always @( posedge  wbs__clk_i ) 
         wbs__ack_o  <=(( wbs__reg_acc & wbs__acc32 )| wbs__clut_ack )&~( wbs__wbm_busy & wbs__REG_ADR == wbs__CTRL_ADR )&~ wbs__ack_o ;
  always @( posedge  wbs__clk_i ) 
         wbs__rty_o  <=(( wbs__reg_acc & wbs__acc32 )| wbs__clut_ack )&( wbs__wbm_busy & wbs__REG_ADR == wbs__CTRL_ADR )&~ wbs__rty_o ;
  always @( posedge  wbs__clk_i ) 
         wbs__err_o  <= wbs__acc &~ wbs__acc32 &~ wbs__err_o ;
  always @(  posedge   wbs__clk_i          or  negedge  wbs__arst_i )
         begin : wbs__gen_regs 
             if (! wbs__arst_i )
                 begin  
                     wbs__htim  <=0; 
                     wbs__vtim  <=0; 
                     wbs__hvlen  <=0; 
                     wbs__VBARa  <=0; 
                     wbs__VBARb  <=0; 
                     wbs__cursor0_xy  <=0; 
                     wbs__cursor0_ba  <=0; 
                     wbs__cursor1_xy  <=0; 
                     wbs__cursor1_ba  <=0;
                 end 
              else 
                 if ( wbs__rst_i )
                     begin  
                         wbs__htim  <=0; 
                         wbs__vtim  <=0; 
                         wbs__hvlen  <=0; 
                         wbs__VBARa  <=0; 
                         wbs__VBARb  <=0; 
                         wbs__cursor0_xy  <=0; 
                         wbs__cursor0_ba  <=0; 
                         wbs__cursor1_xy  <=0; 
                         wbs__cursor1_ba  <=0;
                     end 
                  else 
                     if ( wbs__reg_wacc )
                         case ( wbs__adr_i ) 
                          wbs__HTIM_ADR  : 
                              wbs__htim  <= wbs__dat_i ; 
                          wbs__VTIM_ADR  : 
                              wbs__vtim  <= wbs__dat_i ; 
                          wbs__HVLEN_ADR  : 
                              wbs__hvlen  <= wbs__dat_i ; 
                          wbs__VBARA_ADR  : 
                              wbs__VBARa  <= wbs__dat_i [31:2]; 
                          wbs__VBARB_ADR  : 
                              wbs__VBARb  <= wbs__dat_i [31:2]; 
                          wbs__C0XY_ADR  : 
                              wbs__cursor0_xy  <= wbs__dat_i [31:0]; 
                          wbs__C0BAR_ADR  : 
                              wbs__cursor0_ba  <= wbs__dat_i [31:11]; 
                          wbs__C1XY_ADR  : 
                              wbs__cursor1_xy  <= wbs__dat_i [31:0]; 
                          wbs__C1BAR_ADR  : 
                              wbs__cursor1_ba  <= wbs__dat_i [31:11];endcase
         end
  always @( posedge  wbs__clk_i )
         begin  
             wbs__cursor0_ld  <= wbs__reg_wacc &&( wbs__adr_i == wbs__C0BAR_ADR ); 
             wbs__cursor1_ld  <= wbs__reg_wacc &&( wbs__adr_i == wbs__C1BAR_ADR );
         end
  always @(  posedge   wbs__clk_i          or  negedge  wbs__arst_i )
         if (! wbs__arst_i ) 
             wbs__ctrl  <=0;
          else 
             if ( wbs__rst_i ) 
                 wbs__ctrl  <=0;
              else 
                 if ( wbs__reg_wacc &( wbs__REG_ADR == wbs__CTRL_ADR )&~ wbs__wbm_busy ) 
                     wbs__ctrl  <= wbs__dat_i ;
                  else 
                     begin  
                         wbs__ctrl  [6]<= wbs__ctrl [6]&! wbs__cbsint_in ; 
                         wbs__ctrl  [5]<= wbs__ctrl [5]&! wbs__vbsint_in ;
                     end
  always @(  posedge   wbs__clk_i          or  negedge  wbs__arst_i )
         if (! wbs__arst_i ) 
             wbs__stat  <=0;
          else 
             if ( wbs__rst_i ) 
                 wbs__stat  <=0;
              else 
                 begin  
                     wbs__stat  [21]<=1'b0; 
                     wbs__stat  [20]<=1'b0; 
                     wbs__stat  [17]<= wbs__acmp ; 
                     wbs__stat  [16]<= wbs__avmp ;
                     if ( wbs__reg_wacc &( wbs__REG_ADR == wbs__STAT_ADR ))
                         begin  
                             wbs__stat  [7]<= wbs__cbsint_in |( wbs__stat [7]&! wbs__dat_i [7]); 
                             wbs__stat  [6]<= wbs__vbsint_in |( wbs__stat [6]&! wbs__dat_i [6]); 
                             wbs__stat  [5]<= wbs__hint_in |( wbs__stat [5]&! wbs__dat_i [5]); 
                             wbs__stat  [4]<= wbs__vint_in |( wbs__stat [4]&! wbs__dat_i [4]); 
                             wbs__stat  [1]<= wbs__luint_in |( wbs__stat [3]&! wbs__dat_i [1]); 
                             wbs__stat  [0]<= wbs__sint_in |( wbs__stat [0]&! wbs__dat_i [0]);
                         end 
                      else 
                         begin  
                             wbs__stat  [7]<= wbs__stat [7]| wbs__cbsint_in ; 
                             wbs__stat  [6]<= wbs__stat [6]| wbs__vbsint_in ; 
                             wbs__stat  [5]<= wbs__stat [5]| wbs__hint_in ; 
                             wbs__stat  [4]<= wbs__stat [4]| wbs__vint_in ; 
                             wbs__stat  [1]<= wbs__stat [1]| wbs__luint_in ; 
                             wbs__stat  [0]<= wbs__stat [0]| wbs__sint_in ;
                         end 
                 end
  assign  wbs__dvi_odf = wbs__ctrl [29:28]; 
  assign  wbs__cursor1_res = wbs__ctrl [25]; 
  assign  wbs__cursor1_en = wbs__ctrl [24]; 
  assign  wbs__cursor0_res = wbs__ctrl [23]; 
  assign  wbs__cursor0_en = wbs__ctrl [20]; 
  assign  wbs__bl = wbs__ctrl [15]; 
  assign  wbs__csl = wbs__ctrl [14]; 
  assign  wbs__vsl = wbs__ctrl [13]; 
  assign  wbs__hsl = wbs__ctrl [12]; 
  assign  wbs__pc = wbs__ctrl [11]; 
  assign  wbs__cd = wbs__ctrl [10:9]; 
  assign  wbs__vbl = wbs__ctrl [8:7]; 
  assign  wbs__cbsw = wbs__ctrl [6]; 
  assign  wbs__vbsw = wbs__ctrl [5]; 
  assign  wbs__cbsie = wbs__ctrl [4]; 
  assign  wbs__vbsie = wbs__ctrl [3]; 
  assign  wbs__hie = wbs__ctrl [2]; 
  assign  wbs__vie = wbs__ctrl [1]; 
  assign  wbs__ven = wbs__ctrl [0]; 
  assign  wbs__cbsint = wbs__stat [7]; 
  assign  wbs__vbsint = wbs__stat [6]; 
  assign  wbs__hint = wbs__stat [5]; 
  assign  wbs__vint = wbs__stat [4]; 
  assign  wbs__luint = wbs__stat [1]; 
  assign  wbs__sint = wbs__stat [0]; 
  assign  wbs__Thsync = wbs__htim [31:24]; 
  assign  wbs__Thgdel = wbs__htim [23:16]; 
  assign  wbs__Thgate = wbs__htim [15:0]; 
  assign  wbs__Thlen = wbs__hvlen [31:16]; 
  assign  wbs__Tvsync = wbs__vtim [31:24]; 
  assign  wbs__Tvgdel = wbs__vtim [23:16]; 
  assign  wbs__Tvgate = wbs__vtim [15:0]; 
  assign  wbs__Tvlen = wbs__hvlen [15:0]; 
  assign  wbs__ccr0_dat_o =32'h0; 
  assign  wbs__cc0_dat_o =32'h0; 
  assign  wbs__ccr1_dat_o =32'h0; 
  assign  wbs__cc1_dat_o =32'h0; 
  always @(                wbs__REG_ADR                                      or   wbs__ctrl                       or   wbs__stat                      or   wbs__htim                     or   wbs__vtim                    or   wbs__hvlen                   or   wbs__VBARa                  or   wbs__VBARb                 or   wbs__acmp                or   wbs__cursor0_xy               or   wbs__cursor0_ba              or   wbs__cursor1_xy             or   wbs__cursor1_ba            or   wbs__ccr0_dat_o           or   wbs__ccr1_dat_o  )
         casez ( wbs__REG_ADR ) 
          wbs__CTRL_ADR  : 
              wbs__reg_dato  = wbs__ctrl ; 
          wbs__STAT_ADR  : 
              wbs__reg_dato  = wbs__stat ; 
          wbs__HTIM_ADR  : 
              wbs__reg_dato  = wbs__htim ; 
          wbs__VTIM_ADR  : 
              wbs__reg_dato  = wbs__vtim ; 
          wbs__HVLEN_ADR  : 
              wbs__reg_dato  = wbs__hvlen ; 
          wbs__VBARA_ADR  : 
              wbs__reg_dato  ={ wbs__VBARa ,2'b0}; 
          wbs__VBARB_ADR  : 
              wbs__reg_dato  ={ wbs__VBARb ,2'b0}; 
          wbs__C0XY_ADR  : 
              wbs__reg_dato  = wbs__cursor0_xy ; 
          wbs__C0BAR_ADR  : 
              wbs__reg_dato  ={ wbs__cursor0_ba ,11'h0}; 
          wbs__CCR0_ADR  : 
              wbs__reg_dato  = wbs__ccr0_dat_o ; 
          wbs__C1XY_ADR  : 
              wbs__reg_dato  = wbs__cursor1_xy ; 
          wbs__C1BAR_ADR  : 
              wbs__reg_dato  ={ wbs__cursor1_ba ,11'h0}; 
          wbs__CCR1_ADR  : 
              wbs__reg_dato  = wbs__ccr1_dat_o ;
          default : 
              wbs__reg_dato  =32'h0000_0000;endcase
  always @( posedge  wbs__clk_i ) 
         wbs__dat_o  <= wbs__reg_acc  ?  wbs__reg_dato :{8'h0, wbs__clut_q };
  always @( posedge  wbs__clk_i ) 
         wbs__inta_o  <=( wbs__hint & wbs__hie )|( wbs__vint & wbs__vie )|( wbs__vbsint & wbs__vbsie )|( wbs__cbsint & wbs__cbsie )| wbs__luint | wbs__sint ;

    assign wbs__clk_i = wb_clk_i;
    assign wbs__rst_i = wb_rst_i;
    assign wbs__arst_i = arst;
    assign wbs__adr_i = wbs_adr_i[11:2];
    assign wbs__dat_i = wbs_dat_i;
    assign wbs_dat_o = wbs__dat_o;
    assign wbs__sel_i = wbs_sel_i;
    assign wbs__we_i = wbs_we_i;
    assign wbs__stb_i = wbs_stb_i;
    assign wbs__cyc_i = wbs_cyc_i;
    assign wbs_ack_o = wbs__ack_o;
    assign wbs_rty_o = wbs__rty_o;
    assign wbs_err_o = wbs__err_o;
    assign wb_inta_o = wbs__inta_o;
    assign wbs__wbm_busy = wbm_busy;
    assign ctrl_dvi_odf = wbs__dvi_odf;
    assign ctrl_bl = wbs__bl;
    assign ctrl_csl = wbs__csl;
    assign ctrl_vsl = wbs__vsl;
    assign ctrl_hsl = wbs__hsl;
    assign ctrl_pc = wbs__pc;
    assign ctrl_cd = wbs__cd;
    assign ctrl_vbl = wbs__vbl;
    assign ctrl_cbsw = wbs__cbsw;
    assign ctrl_vbsw = wbs__vbsw;
    assign ctrl_ven = wbs__ven;
    assign cursor0_res = wbs__cursor0_res;
    assign cursor0_en = wbs__cursor0_en;
    assign cursor0_xy = wbs__cursor0_xy;
    assign cursor0_ba = wbs__cursor0_ba;
    assign cursor0_ld = wbs__cursor0_ld;
    assign wbs__cc0_adr_i = cc0_adr_i;
    assign cc0_dat_o = wbs__cc0_dat_o;
    assign cursor1_res = wbs__cursor1_res;
    assign cursor1_en = wbs__cursor1_en;
    assign cursor1_xy = wbs__cursor1_xy;
    assign cursor1_ba = wbs__cursor1_ba;
    assign cursor1_ld = wbs__cursor1_ld;
    assign wbs__cc1_adr_i = cc1_adr_i;
    assign cc1_dat_o = wbs__cc1_dat_o;
    assign wbs__avmp = stat_avmp;
    assign wbs__acmp = stat_acmp;
    assign wbs__vbsint_in = vmem_swint;
    assign wbs__cbsint_in = clut_swint;
    assign wbs__hint_in = hint;
    assign wbs__vint_in = vint;
    assign wbs__luint_in = luint;
    assign wbs__sint_in = sint;
    assign Thsync = wbs__Thsync;
    assign Thgdel = wbs__Thgdel;
    assign Thgate = wbs__Thgate;
    assign Thlen = wbs__Thlen;
    assign Tvsync = wbs__Tvsync;
    assign Tvgdel = wbs__Tvgdel;
    assign Tvgate = wbs__Tvgate;
    assign Tvlen = wbs__Tvlen;
    assign VBARa = wbs__VBARa;
    assign VBARb = wbs__VBARb;
    assign ext_clut_req = wbs__clut_acc;
    assign wbs__clut_ack = ext_clut_ack;
    assign wbs__clut_q = ext_clut_q;
    

	// hookup wishbone master
	    wire wbm__clk_i;
    wire wbm__rst_i;
    wire wbm__nrst_i;
    reg wbm__cyc_o;
    reg wbm__stb_o;
    reg[2:0] wbm__cti_o;
    reg[1:0] wbm__bte_o;
    reg wbm__we_o;
    wire[31:0] wbm__adr_o;
    reg[3:0] wbm__sel_o;
    wire wbm__ack_i;
    wire wbm__err_i;
    wire[31:0] wbm__dat_i;
    wire wbm__sint;
    wire wbm__ctrl_ven;
    wire[1:0] wbm__ctrl_cd;
    wire[1:0] wbm__ctrl_vbl;
    wire wbm__ctrl_vbsw;
    wire wbm__busy;
    wire[31:2] wbm__VBAa;
    wire[31:2] wbm__VBAb;
    wire[15:0] wbm__Thgate;
    wire[15:0] wbm__Tvgate;
    wire wbm__stat_avmp;
    wire wbm__vmem_switch;
    wire wbm__ImDoneFifoQ;
    reg[8:0] wbm__cursor_adr;
    wire[31:11] wbm__cursor0_ba;
    wire[31:11] wbm__cursor1_ba;
    wire wbm__cursor0_ld;
    wire wbm__cursor1_ld;
    wire wbm__fb_data_fifo_rreq;
    wire[31:0] wbm__fb_data_fifo_q;
    wire wbm__fb_data_fifo_empty;

    reg wbm__vmem_acc ; 
    wire wbm__vmem_req , wbm__vmem_ack ; 
    wire wbm__ImDone ; 
    reg wbm__dImDone ; 
    wire wbm__ImDoneStrb ; 
    reg wbm__dImDoneStrb ; 
    reg wbm__sclr ; reg[31:11] wbm__cursor_ba ; 
    wire wbm__cursor0_we , wbm__cursor1_we ; 
    reg wbm__ld_cursor0 , wbm__ld_cursor1 ; 
    reg wbm__cur_acc ; 
    reg wbm__cur_acc_sel ; 
    wire wbm__cur_ack ; 
    wire wbm__cur_done ; 
  always @( posedge  wbm__clk_i ) 
         wbm__sclr  <=~ wbm__ctrl_ven ;
 reg[2:0] wbm__burst_cnt ; 
    wire wbm__burst_done ; 
    reg wbm__sel_VBA ; reg[31:2] wbm__vmemA ; 
  always @( posedge  wbm__clk_i )
         if ( wbm__sclr ) 
             wbm__vmem_acc  <=1'b0;
          else  
             wbm__vmem_acc  <=( wbm__vmem_req |( wbm__vmem_acc &!( wbm__burst_done & wbm__vmem_ack )))&! wbm__ImDone &! wbm__cur_acc ;
  always @( posedge  wbm__clk_i )
         if ( wbm__sclr ) 
             wbm__cur_acc  <=1'b0;
          else  
             wbm__cur_acc  <=( wbm__cur_acc | wbm__ImDone &( wbm__ld_cursor0 | wbm__ld_cursor1 ))&! wbm__cur_done ;
  assign  wbm__busy = wbm__vmem_acc | wbm__cur_acc ; 
  assign  wbm__vmem_ack = wbm__ack_i & wbm__stb_o & wbm__vmem_acc ; 
  assign  wbm__cur_ack = wbm__ack_i & wbm__stb_o & wbm__cur_acc ; 
  assign  wbm__sint = wbm__err_i ; 
  assign  wbm__vmem_switch = wbm__ImDoneStrb ; 
  always @( posedge  wbm__clk_i )
         if ( wbm__sclr ) 
             wbm__sel_VBA  <=1'b0;
          else 
             if ( wbm__ctrl_vbsw ) 
                 wbm__sel_VBA  <= wbm__sel_VBA ^ wbm__vmem_switch ;
  assign  wbm__stat_avmp = wbm__sel_VBA ;  
    wire wbm__clut_sw_fifo__clk;
    wire wbm__clut_sw_fifo__aclr;
    wire wbm__clut_sw_fifo__sclr;
    wire wbm__clut_sw_fifo__wreq;
    wire wbm__clut_sw_fifo__rreq;
    wire[8-1:0] wbm__clut_sw_fifo__d;
    wire[8-1:0] wbm__clut_sw_fifo__q;
    reg wbm__clut_sw_fifo__nword;
    reg wbm__clut_sw_fifo__empty;
    reg wbm__clut_sw_fifo__full;
    wire wbm__clut_sw_fifo__aempty;
    wire wbm__clut_sw_fifo__afull;

    reg[3-1:0] wbm__clut_sw_fifo__rp , wbm__clut_sw_fifo__wp ; 
    wire[8-1:0] wbm__clut_sw_fifo__ramq ; 
    wire wbm__clut_sw_fifo__fwreq , wbm__clut_sw_fifo__frreq ; 
  assign  wbm__clut_sw_fifo__fwreq = wbm__clut_sw_fifo__wreq ; 
  assign  wbm__clut_sw_fifo__frreq = wbm__clut_sw_fifo__rreq ; 
  always @(  posedge   wbm__clut_sw_fifo__clk          or  negedge  wbm__clut_sw_fifo__aclr )
         if (~ wbm__clut_sw_fifo__aclr ) 
             wbm__clut_sw_fifo__rp  <=0;
          else 
             if ( wbm__clut_sw_fifo__sclr ) 
                 wbm__clut_sw_fifo__rp  <=0;
              else 
                 if ( wbm__clut_sw_fifo__frreq ) 
                     wbm__clut_sw_fifo__rp  <={ wbm__clut_sw_fifo__rp [3-1:1], wbm__clut_sw_fifo__lsb ( wbm__clut_sw_fifo__rp )};
  always @(  posedge   wbm__clut_sw_fifo__clk          or  negedge  wbm__clut_sw_fifo__aclr )
         if (~ wbm__clut_sw_fifo__aclr ) 
             wbm__clut_sw_fifo__wp  <=0;
          else 
             if ( wbm__clut_sw_fifo__sclr ) 
                 wbm__clut_sw_fifo__wp  <=0;
              else 
                 if ( wbm__clut_sw_fifo__fwreq ) 
                     wbm__clut_sw_fifo__wp  <={ wbm__clut_sw_fifo__wp [3-1:1], wbm__clut_sw_fifo__lsb ( wbm__clut_sw_fifo__wp )};
 reg[8-1:0] wbm__clut_sw_fifo__mem [(1<<3)-1:0]; 
  always @( posedge  wbm__clut_sw_fifo__clk )
         if ( wbm__clut_sw_fifo__fwreq ) 
             wbm__clut_sw_fifo__mem  [ wbm__clut_sw_fifo__wp ]<= wbm__clut_sw_fifo__d ;
  assign  wbm__clut_sw_fifo__q = wbm__clut_sw_fifo__mem [ wbm__clut_sw_fifo__rp ]; 
  assign  wbm__clut_sw_fifo__aempty =( wbm__clut_sw_fifo__rp [3-1:1]== wbm__clut_sw_fifo__wp [3:2])&( wbm__clut_sw_fifo__lsb ( wbm__clut_sw_fifo__rp )== wbm__clut_sw_fifo__wp [1])& wbm__clut_sw_fifo__frreq &~ wbm__clut_sw_fifo__fwreq ; 
  always @(  posedge   wbm__clut_sw_fifo__clk          or  negedge  wbm__clut_sw_fifo__aclr )
         if (~ wbm__clut_sw_fifo__aclr ) 
             wbm__clut_sw_fifo__empty  <=1'b1;
          else 
             if ( wbm__clut_sw_fifo__sclr ) 
                 wbm__clut_sw_fifo__empty  <=1'b1;
              else  
                 wbm__clut_sw_fifo__empty  <= wbm__clut_sw_fifo__aempty |( wbm__clut_sw_fifo__empty &(~ wbm__clut_sw_fifo__fwreq + wbm__clut_sw_fifo__frreq ));
  assign  wbm__clut_sw_fifo__afull =( wbm__clut_sw_fifo__wp [3-1:1]== wbm__clut_sw_fifo__rp [3:2])&( wbm__clut_sw_fifo__lsb ( wbm__clut_sw_fifo__wp )== wbm__clut_sw_fifo__rp [1])& wbm__clut_sw_fifo__fwreq &~ wbm__clut_sw_fifo__frreq ; 
  always @(  posedge   wbm__clut_sw_fifo__clk          or  negedge  wbm__clut_sw_fifo__aclr )
         if (~ wbm__clut_sw_fifo__aclr ) 
             wbm__clut_sw_fifo__full  <=1'b0;
          else 
             if ( wbm__clut_sw_fifo__sclr ) 
                 wbm__clut_sw_fifo__full  <=1'b0;
              else  
                 wbm__clut_sw_fifo__full  <= wbm__clut_sw_fifo__afull |( wbm__clut_sw_fifo__full &(~ wbm__clut_sw_fifo__frreq + wbm__clut_sw_fifo__fwreq ));
  always @(  posedge   wbm__clut_sw_fifo__clk          or  negedge  wbm__clut_sw_fifo__aclr )
         if (~ wbm__clut_sw_fifo__aclr ) 
             wbm__clut_sw_fifo__nword  <=0;
          else 
             if ( wbm__clut_sw_fifo__sclr ) 
                 wbm__clut_sw_fifo__nword  <=0;
              else 
                 begin 
                     if ( wbm__clut_sw_fifo__wreq &! wbm__clut_sw_fifo__rreq ) 
                         wbm__clut_sw_fifo__nword  <= wbm__clut_sw_fifo__nword +1;
                      else 
                         if ( wbm__clut_sw_fifo__rreq &! wbm__clut_sw_fifo__wreq ) 
                             wbm__clut_sw_fifo__nword  <= wbm__clut_sw_fifo__nword -1;
                 end
 
    assign wbm__clut_sw_fifo__clk = wbm__clk_i;
    assign wbm__clut_sw_fifo__aclr = 1'b1;
    assign wbm__clut_sw_fifo__sclr = wbm__sclr;
    assign wbm__clut_sw_fifo__wreq = wbm__vmem_ack;
    assign wbm__clut_sw_fifo__rreq = wbm__fb_data_fifo_rreq;
    assign wbm__clut_sw_fifo__d = wbm__ImDone;
    assign wbm__ImDoneFifoQ = wbm__clut_sw_fifo__q;
     
    wire[3:0] wbm__burst_cnt_val ; 
  assign  wbm__burst_cnt_val ={1'b0, wbm__burst_cnt }-4'h1; 
  assign  wbm__burst_done = wbm__burst_cnt_val [3]; 
  always @( posedge  wbm__clk_i )
         if (( wbm__burst_done & wbm__vmem_ack )|! wbm__vmem_acc )
             case ( wbm__ctrl_vbl )
              2 'b00: 
                  wbm__burst_cnt  <=3'b000;
              2 'b01: 
                  wbm__burst_cnt  <=3'b001;
              2 'b10: 
                  wbm__burst_cnt  <=3'b011;
              2 'b11: 
                  wbm__burst_cnt  <=3'b111;endcase
          else 
             if ( wbm__vmem_ack ) 
                 wbm__burst_cnt  <= wbm__burst_cnt_val [2:0];
 reg[15:0] wbm__hgate_cnt ; reg[16:0] wbm__hgate_cnt_val ; reg[1:0] wbm__hgate_div_cnt ; reg[2:0] wbm__hgate_div_val ; 
    wire wbm__hdone = wbm__hgate_cnt_val [16]& wbm__vmem_ack ; 
  always @(    wbm__hgate_cnt              or   wbm__hgate_div_cnt           or   wbm__ctrl_cd  )
         begin  
             wbm__hgate_div_val  ={1'b0, wbm__hgate_div_cnt }-3'h1;
             if ( wbm__ctrl_cd !=2'b10) 
                 wbm__hgate_cnt_val  ={1'b0, wbm__hgate_cnt }-17'h1;
              else 
                 if ( wbm__hgate_div_val [2]) 
                     wbm__hgate_cnt_val  ={1'b0, wbm__hgate_cnt }-17'h1;
                  else  
                     wbm__hgate_cnt_val  ={1'b0, wbm__hgate_cnt };
         end
  always @( posedge  wbm__clk_i )
         if ( wbm__sclr )
             begin 
                 case ( wbm__ctrl_cd )
                  2 'b00: 
                      wbm__hgate_cnt  <= wbm__Thgate >>2;
                  2 'b01: 
                      wbm__hgate_cnt  <= wbm__Thgate >>1;
                  2 'b10: 
                      wbm__hgate_cnt  <= wbm__Thgate >>2;
                  2 'b11: 
                      wbm__hgate_cnt  <= wbm__Thgate ;endcase 
                 wbm__hgate_div_cnt  <=2'b10;
             end 
          else 
             if ( wbm__vmem_ack )
                 if ( wbm__hdone )
                     begin 
                         case ( wbm__ctrl_cd )
                          2 'b00: 
                              wbm__hgate_cnt  <= wbm__Thgate >>2;
                          2 'b01: 
                              wbm__hgate_cnt  <= wbm__Thgate >>1;
                          2 'b10: 
                              wbm__hgate_cnt  <= wbm__Thgate >>2;
                          2 'b11: 
                              wbm__hgate_cnt  <= wbm__Thgate ;endcase 
                         wbm__hgate_div_cnt  <=2'b10;
                     end 
                  else 
                     begin  
                         wbm__hgate_cnt  <= wbm__hgate_cnt_val [15:0];
                         if ( wbm__hgate_div_val [2]) 
                             wbm__hgate_div_cnt  <=2'b10;
                          else  
                             wbm__hgate_div_cnt  <= wbm__hgate_div_val [1:0];
                     end
  reg[15:0] wbm__vgate_cnt ; 
    wire[16:0] wbm__vgate_cnt_val ; 
    wire wbm__vdone ; 
  assign  wbm__vgate_cnt_val ={1'b0, wbm__vgate_cnt }-17'h1; 
  assign  wbm__vdone = wbm__vgate_cnt_val [16]; 
  always @( posedge  wbm__clk_i )
         if ( wbm__sclr | wbm__ImDoneStrb ) 
             wbm__vgate_cnt  <= wbm__Tvgate ;
          else 
             if ( wbm__hdone ) 
                 wbm__vgate_cnt  <= wbm__vgate_cnt_val [15:0];
  assign  wbm__ImDone = wbm__hdone & wbm__vdone ; 
  assign  wbm__ImDoneStrb = wbm__ImDone &! wbm__dImDone ; 
  always @( posedge  wbm__clk_i )
         begin  
             wbm__dImDone  <= wbm__ImDone ; 
             wbm__dImDoneStrb  <= wbm__ImDoneStrb ;
         end
  always @( posedge  wbm__clk_i )
         if ( wbm__sclr | wbm__dImDoneStrb )
             if (! wbm__sel_VBA ) 
                 wbm__vmemA  <= wbm__VBAa ;
              else  
                 wbm__vmemA  <= wbm__VBAb ;
          else 
             if ( wbm__vmem_ack ) 
                 wbm__vmemA  <= wbm__vmemA +30'h1;
  always @( posedge  wbm__clk_i )
         if ( wbm__ImDone ) 
             wbm__cur_acc_sel  <= wbm__ld_cursor0 ;
  always @( posedge  wbm__clk_i )
         if ( wbm__sclr )
             begin  
                 wbm__ld_cursor0  <=1'b0; 
                 wbm__ld_cursor1  <=1'b0;
             end 
          else 
             begin  
                 wbm__ld_cursor0  <= wbm__cursor0_ld |( wbm__ld_cursor0 &!( wbm__cur_done & wbm__cur_acc_sel )); 
                 wbm__ld_cursor1  <= wbm__cursor1_ld |( wbm__ld_cursor1 &!( wbm__cur_done &! wbm__cur_acc_sel ));
             end
  always @( posedge  wbm__clk_i )
         if (! wbm__cur_acc ) 
             wbm__cursor_ba  <= wbm__ld_cursor0  ?  wbm__cursor0_ba : wbm__cursor1_ba ;
    wire[9:0] wbm__next_cursor_adr ={1'b0, wbm__cursor_adr }+10'h1; 
  assign  wbm__cur_done = wbm__next_cursor_adr [9]& wbm__cur_ack ; 
  always @( posedge  wbm__clk_i )
         if (! wbm__cur_acc ) 
             wbm__cursor_adr  <=9'h0;
          else 
             if ( wbm__cur_ack ) 
                 wbm__cursor_adr  <= wbm__next_cursor_adr ;
  assign  wbm__cursor1_we = wbm__cur_ack &! wbm__cur_acc_sel ; 
  assign  wbm__cursor0_we = wbm__cur_ack & wbm__cur_acc_sel ; 
  assign  wbm__adr_o = wbm__cur_acc  ? { wbm__cursor_ba , wbm__cursor_adr ,2'b00}:{ wbm__vmemA ,2'b00}; 
    wire wbm__wb_cycle = wbm__vmem_acc &!( wbm__burst_done & wbm__vmem_ack &! wbm__vmem_req )&! wbm__ImDone || wbm__cur_acc &! wbm__cur_done ; 
  always @(  posedge   wbm__clk_i          or  negedge  wbm__nrst_i )
         if (! wbm__nrst_i )
             begin  
                 wbm__cyc_o  <=1'b0; 
                 wbm__stb_o  <=1'b0; 
                 wbm__sel_o  <=4'b1111; 
                 wbm__cti_o  <=3'b000; 
                 wbm__bte_o  <=2'b00; 
                 wbm__we_o  <=1'b0;
             end 
          else 
             if ( wbm__rst_i )
                 begin  
                     wbm__cyc_o  <=1'b0; 
                     wbm__stb_o  <=1'b0; 
                     wbm__sel_o  <=4'b1111; 
                     wbm__cti_o  <=3'b000; 
                     wbm__bte_o  <=2'b00; 
                     wbm__we_o  <=1'b0;
                 end 
              else 
                 begin  
                     wbm__cyc_o  <= wbm__wb_cycle ; 
                     wbm__stb_o  <= wbm__wb_cycle ; 
                     wbm__sel_o  <=4'b1111;
                     if ( wbm__wb_cycle )
                         begin 
                             if ( wbm__cur_acc ) 
                                 wbm__cti_o  <=& wbm__next_cursor_adr [8:0] ? 3'b111:3'b010;
                              else 
                                 if ( wbm__ctrl_vbl ==2'b00) 
                                     wbm__cti_o  <=3'b000;
                                  else 
                                     if ( wbm__vmem_ack ) 
                                         wbm__cti_o  <=( wbm__burst_cnt ==3'h1) ? 3'b111:3'b010;
                         end 
                      else  
                         wbm__cti_o  <=( wbm__ctrl_vbl ==2'b00) ? 3'b000:3'b010; 
                     wbm__bte_o  <=2'b00; 
                     wbm__we_o  <=1'b0;
                 end
    wire[4:0] wbm__fb_data_fifo_nword ;  
    wire wbm__data_fifo__clk;
    wire wbm__data_fifo__aclr;
    wire wbm__data_fifo__sclr;
    wire wbm__data_fifo__wreq;
    wire wbm__data_fifo__rreq;
    wire[32-1:0] wbm__data_fifo__d;
    wire[32-1:0] wbm__data_fifo__q;
    reg wbm__data_fifo__nword;
    reg wbm__data_fifo__empty;
    reg wbm__data_fifo__full;
    wire wbm__data_fifo__aempty;
    wire wbm__data_fifo__afull;

    reg[4-1:0] wbm__data_fifo__rp , wbm__data_fifo__wp ; 
    wire[32-1:0] wbm__data_fifo__ramq ; 
    wire wbm__data_fifo__fwreq , wbm__data_fifo__frreq ; 
  assign  wbm__data_fifo__fwreq = wbm__data_fifo__wreq ; 
  assign  wbm__data_fifo__frreq = wbm__data_fifo__rreq ; 
  always @(  posedge   wbm__data_fifo__clk          or  negedge  wbm__data_fifo__aclr )
         if (~ wbm__data_fifo__aclr ) 
             wbm__data_fifo__rp  <=0;
          else 
             if ( wbm__data_fifo__sclr ) 
                 wbm__data_fifo__rp  <=0;
              else 
                 if ( wbm__data_fifo__frreq ) 
                     wbm__data_fifo__rp  <={ wbm__data_fifo__rp [4-1:1], wbm__data_fifo__lsb ( wbm__data_fifo__rp )};
  always @(  posedge   wbm__data_fifo__clk          or  negedge  wbm__data_fifo__aclr )
         if (~ wbm__data_fifo__aclr ) 
             wbm__data_fifo__wp  <=0;
          else 
             if ( wbm__data_fifo__sclr ) 
                 wbm__data_fifo__wp  <=0;
              else 
                 if ( wbm__data_fifo__fwreq ) 
                     wbm__data_fifo__wp  <={ wbm__data_fifo__wp [4-1:1], wbm__data_fifo__lsb ( wbm__data_fifo__wp )};
 reg[32-1:0] wbm__data_fifo__mem [(1<<4)-1:0]; 
  always @( posedge  wbm__data_fifo__clk )
         if ( wbm__data_fifo__fwreq ) 
             wbm__data_fifo__mem  [ wbm__data_fifo__wp ]<= wbm__data_fifo__d ;
  assign  wbm__data_fifo__q = wbm__data_fifo__mem [ wbm__data_fifo__rp ]; 
  assign  wbm__data_fifo__aempty =( wbm__data_fifo__rp [4-1:1]== wbm__data_fifo__wp [4:2])&( wbm__data_fifo__lsb ( wbm__data_fifo__rp )== wbm__data_fifo__wp [1])& wbm__data_fifo__frreq &~ wbm__data_fifo__fwreq ; 
  always @(  posedge   wbm__data_fifo__clk          or  negedge  wbm__data_fifo__aclr )
         if (~ wbm__data_fifo__aclr ) 
             wbm__data_fifo__empty  <=1'b1;
          else 
             if ( wbm__data_fifo__sclr ) 
                 wbm__data_fifo__empty  <=1'b1;
              else  
                 wbm__data_fifo__empty  <= wbm__data_fifo__aempty |( wbm__data_fifo__empty &(~ wbm__data_fifo__fwreq + wbm__data_fifo__frreq ));
  assign  wbm__data_fifo__afull =( wbm__data_fifo__wp [4-1:1]== wbm__data_fifo__rp [4:2])&( wbm__data_fifo__lsb ( wbm__data_fifo__wp )== wbm__data_fifo__rp [1])& wbm__data_fifo__fwreq &~ wbm__data_fifo__frreq ; 
  always @(  posedge   wbm__data_fifo__clk          or  negedge  wbm__data_fifo__aclr )
         if (~ wbm__data_fifo__aclr ) 
             wbm__data_fifo__full  <=1'b0;
          else 
             if ( wbm__data_fifo__sclr ) 
                 wbm__data_fifo__full  <=1'b0;
              else  
                 wbm__data_fifo__full  <= wbm__data_fifo__afull |( wbm__data_fifo__full &(~ wbm__data_fifo__frreq + wbm__data_fifo__fwreq ));
  always @(  posedge   wbm__data_fifo__clk          or  negedge  wbm__data_fifo__aclr )
         if (~ wbm__data_fifo__aclr ) 
             wbm__data_fifo__nword  <=0;
          else 
             if ( wbm__data_fifo__sclr ) 
                 wbm__data_fifo__nword  <=0;
              else 
                 begin 
                     if ( wbm__data_fifo__wreq &! wbm__data_fifo__rreq ) 
                         wbm__data_fifo__nword  <= wbm__data_fifo__nword +1;
                      else 
                         if ( wbm__data_fifo__rreq &! wbm__data_fifo__wreq ) 
                             wbm__data_fifo__nword  <= wbm__data_fifo__nword -1;
                 end
 
    assign wbm__data_fifo__clk = wbm__clk_i;
    assign wbm__data_fifo__aclr = 1'b1;
    assign wbm__data_fifo__sclr = wbm__sclr;
    assign wbm__data_fifo__wreq = wbm__vmem_ack;
    assign wbm__data_fifo__rreq = wbm__fb_data_fifo_rreq;
    assign wbm__data_fifo__d = wbm__dat_i;
    assign wbm__fb_data_fifo_q = wbm__data_fifo__q;
    assign wbm__fb_data_fifo_nword = wbm__data_fifo__nword;
    assign wbm__fb_data_fifo_empty = wbm__data_fifo__empty;
     
  assign  wbm__vmem_req =~ wbm__fb_data_fifo_nword [4]&~ wbm__fb_data_fifo_nword [3];
    assign wbm__clk_i = wb_clk_i;
    assign wbm__rst_i = wb_rst_i;
    assign wbm__nrst_i = arst;
    assign wbm_cyc_o = wbm__cyc_o;
    assign wbm_stb_o = wbm__stb_o;
    assign wbm_cti_o = wbm__cti_o;
    assign wbm_bte_o = wbm__bte_o;
    assign wbm_we_o = wbm__we_o;
    assign wbm_adr_o = wbm__adr_o;
    assign wbm_sel_o = wbm__sel_o;
    assign wbm__ack_i = wbm_ack_i;
    assign wbm__err_i = wbm_err_i;
    assign wbm__dat_i = wbm_dat_i;
    assign sint = wbm__sint;
    assign wbm__ctrl_ven = ctrl_ven;
    assign wbm__ctrl_cd = ctrl_cd;
    assign wbm__ctrl_vbl = ctrl_vbl;
    assign wbm__ctrl_vbsw = ctrl_vbsw;
    assign wbm_busy = wbm__busy;
    assign wbm__VBAa = VBARa;
    assign wbm__VBAb = VBARb;
    assign wbm__Thgate = Thgate;
    assign wbm__Tvgate = Tvgate;
    assign stat_avmp = wbm__stat_avmp;
    assign vmem_swint = wbm__vmem_switch;
    assign ImDoneFifoQ = wbm__ImDoneFifoQ;
    assign cursor_adr = wbm__cursor_adr;
    assign wbm__cursor0_ba = cursor0_ba;
    assign wbm__cursor1_ba = cursor1_ba;
    assign wbm__cursor0_ld = cursor0_ld;
    assign wbm__cursor1_ld = cursor1_ld;
    assign wbm__fb_data_fifo_rreq = fb_data_fifo_rreq;
    assign fb_data_fifo_q = wbm__fb_data_fifo_q;
    assign fb_data_fifo_empty = wbm__fb_data_fifo_empty;
    

	// hookup CLUT <cycle shared memory>
	    wire clut_mem__clk_i;
    wire[8:0] clut_mem__adr0_i;
    wire[23:0] clut_mem__dat0_i;
    wire[23:0] clut_mem__dat0_o;
    wire clut_mem__we0_i;
    wire clut_mem__req0_i;
    wire clut_mem__ack0_o;
    wire[8:0] clut_mem__adr1_i;
    wire[23:0] clut_mem__dat1_i;
    wire[23:0] clut_mem__dat1_o;
    wire clut_mem__we1_i;
    wire clut_mem__req1_i;
    wire clut_mem__ack1_o;

    wire clut_mem__acc0 , clut_mem__acc1 ; 
    reg clut_mem__dacc0 , clut_mem__dacc1 ; 
    wire clut_mem__sel0 , clut_mem__sel1 ; 
    reg clut_mem__ack0 , clut_mem__ack1 ; 
    wire[24-1:0] clut_mem__mem_q ; 
  assign  clut_mem__acc0 = clut_mem__req0_i ; 
  assign  clut_mem__acc1 = clut_mem__req1_i &&! clut_mem__sel0 ; 
  always @( posedge  clut_mem__clk_i )
         begin  
             clut_mem__dacc0  <= clut_mem__acc0 &! clut_mem__ack0_o ; 
             clut_mem__dacc1  <= clut_mem__acc1 &! clut_mem__ack1_o ;
         end
  assign  clut_mem__sel0 = clut_mem__acc0 &&! clut_mem__dacc0 ; 
  assign  clut_mem__sel1 = clut_mem__acc1 &&! clut_mem__dacc1 ; 
  always @( posedge  clut_mem__clk_i )
         begin  
             clut_mem__ack0  <= clut_mem__sel0 &&! clut_mem__ack0_o ; 
             clut_mem__ack1  <= clut_mem__sel1 &&! clut_mem__ack1_o ;
         end
    wire[9-1:0] clut_mem__mem_adr = clut_mem__sel0  ?  clut_mem__adr0_i : clut_mem__adr1_i ; 
    wire[24-1:0] clut_mem__mem_d = clut_mem__sel0  ?  clut_mem__dat0_i : clut_mem__dat1_i ; 
    wire clut_mem__mem_we = clut_mem__sel0  ?  clut_mem__req0_i && clut_mem__we0_i : clut_mem__req1_i && clut_mem__we1_i ;  
    wire clut_mem__clut_mem__clk;
    wire clut_mem__clut_mem__rst;
    wire clut_mem__clut_mem__ce;
    wire clut_mem__clut_mem__we;
    wire clut_mem__clut_mem__oe;
    wire[9-1:0] clut_mem__clut_mem__addr;
    wire[24-1:0] clut_mem__clut_mem__di;
    wire[24-1:0] clut_mem__clut_mem__doo;

    reg[24-1:0] clut_mem__clut_mem__mem [(1<<9)-1:0]; reg[9-1:0] clut_mem__clut_mem__ra ; 
  always @( posedge  clut_mem__clut_mem__clk )
         if ( clut_mem__clut_mem__ce ) 
             clut_mem__clut_mem__ra  <= clut_mem__clut_mem__addr ;
  assign  clut_mem__clut_mem__doo = clut_mem__clut_mem__mem [ clut_mem__clut_mem__ra ]; 
  always @( posedge  clut_mem__clut_mem__clk )
         if ( clut_mem__clut_mem__we && clut_mem__clut_mem__ce ) 
             clut_mem__clut_mem__mem  [ clut_mem__clut_mem__addr ]<= clut_mem__clut_mem__di ;

    assign clut_mem__clut_mem__clk = clut_mem__clk_i;
    assign clut_mem__clut_mem__rst = 1'b0;
    assign clut_mem__clut_mem__ce = 1'b1;
    assign clut_mem__clut_mem__we = clut_mem__mem_we;
    assign clut_mem__clut_mem__oe = 1'b1;
    assign clut_mem__clut_mem__addr = clut_mem__mem_adr;
    assign clut_mem__clut_mem__di = clut_mem__mem_d;
    assign clut_mem__mem_q = clut_mem__clut_mem__doo;
     
  assign  clut_mem__dat0_o = clut_mem__mem_q ; 
  assign  clut_mem__dat1_o = clut_mem__mem_q ; 
  assign  clut_mem__ack0_o =(( clut_mem__sel0 && clut_mem__we0_i )|| clut_mem__ack0 ); 
  assign  clut_mem__ack1_o =(( clut_mem__sel1 && clut_mem__we1_i )|| clut_mem__ack1 );
    assign clut_mem__clk_i = wb_clk_i;
    assign clut_mem__adr0_i = cp_clut_adr;
    assign clut_mem__dat0_i = 24'h0;
    assign cp_clut_q = clut_mem__dat0_o;
    assign clut_mem__we0_i = 1'b0;
    assign clut_mem__req0_i = cp_clut_req;
    assign cp_clut_ack = clut_mem__ack0_o;
    assign clut_mem__adr1_i = wbs_adr_i[10:2];
    assign clut_mem__dat1_i = wbs_dat_i[23:0];
    assign ext_clut_q = clut_mem__dat1_o;
    assign clut_mem__we1_i = wbs_we_i;
    assign clut_mem__req1_i = ext_clut_req;
    assign ext_clut_ack = clut_mem__ack1_o;
    

	// hookup pixel and video timing generator
	    wire pixel_generator__clk_i;
    wire pixel_generator__ctrl_ven;
    wire pixel_generator__ctrl_HSyncL;
    wire[7:0] pixel_generator__Thsync;
    wire[7:0] pixel_generator__Thgdel;
    wire[15:0] pixel_generator__Thgate;
    wire[15:0] pixel_generator__Thlen;
    wire pixel_generator__ctrl_VSyncL;
    wire[7:0] pixel_generator__Tvsync;
    wire[7:0] pixel_generator__Tvgdel;
    wire[15:0] pixel_generator__Tvgate;
    wire[15:0] pixel_generator__Tvlen;
    wire pixel_generator__ctrl_CSyncL;
    wire pixel_generator__ctrl_BlankL;
    reg pixel_generator__eoh;
    reg pixel_generator__eov;
    wire[1:0] pixel_generator__ctrl_dvi_odf;
    wire[1:0] pixel_generator__ctrl_cd;
    wire pixel_generator__ctrl_pc;
    wire[31:0] pixel_generator__fb_data_fifo_q;
    wire pixel_generator__fb_data_fifo_empty;
    wire pixel_generator__fb_data_fifo_rreq;
    wire pixel_generator__ImDoneFifoQ;
    reg pixel_generator__stat_acmp;
    wire pixel_generator__clut_req;
    wire[8:0] pixel_generator__clut_adr;
    wire[23:0] pixel_generator__clut_q;
    wire pixel_generator__clut_ack;
    wire pixel_generator__ctrl_cbsw;
    wire pixel_generator__clut_switch;
    wire[8:0] pixel_generator__cursor_adr;
    wire pixel_generator__cursor0_en;
    wire pixel_generator__cursor0_res;
    wire[31:0] pixel_generator__cursor0_xy;
    wire[3:0] pixel_generator__cc0_adr_o;
    wire[15:0] pixel_generator__cc0_dat_i;
    wire pixel_generator__cursor1_en;
    wire pixel_generator__cursor1_res;
    wire[31:0] pixel_generator__cursor1_xy;
    wire[3:0] pixel_generator__cc1_adr_o;
    wire[15:0] pixel_generator__cc1_dat_i;
    wire pixel_generator__line_fifo_full;
    wire pixel_generator__line_fifo_wreq;
    wire[23:0] pixel_generator__line_fifo_d;
    wire pixel_generator__line_fifo_rreq;
    wire[23:0] pixel_generator__line_fifo_q;
    wire pixel_generator__pclk_i;
    wire pixel_generator__pclk_o;
    reg pixel_generator__hsync_o;
    reg pixel_generator__vsync_o;
    reg pixel_generator__csync_o;
    reg pixel_generator__blank_o;
    reg[7:0] pixel_generator__r_o;
    reg[7:0] pixel_generator__g_o;
    reg[7:0] pixel_generator__b_o;

    reg pixel_generator__nVen ; 
    wire pixel_generator__eol , pixel_generator__eof ; 
    wire pixel_generator__ihsync , pixel_generator__ivsync , pixel_generator__icsync , pixel_generator__iblank ; 
    wire pixel_generator__pclk_ena ; 
  always @( posedge  pixel_generator__pclk_i ) 
         pixel_generator__nVen  <=~ pixel_generator__ctrl_ven ;
    wire pixel_generator__clk_gen__pclk_i;
    wire pixel_generator__clk_gen__rst_i;
    wire pixel_generator__clk_gen__pclk_o;
    reg pixel_generator__clk_gen__dvi_pclk_p_o;
    reg pixel_generator__clk_gen__dvi_pclk_m_o;
    wire pixel_generator__clk_gen__pclk_ena_o;

    always @( posedge  pixel_generator__clk_gen__pclk_i )
         if ( pixel_generator__clk_gen__rst_i )
             begin  
                 pixel_generator__clk_gen__dvi_pclk_p_o  <=1'b0; 
                 pixel_generator__clk_gen__dvi_pclk_m_o  <=1'b0;
             end 
          else 
             begin  
                 pixel_generator__clk_gen__dvi_pclk_p_o  <=~ pixel_generator__clk_gen__dvi_pclk_p_o ; 
                 pixel_generator__clk_gen__dvi_pclk_m_o  <= pixel_generator__clk_gen__dvi_pclk_p_o ;
             end
  assign  pixel_generator__clk_gen__pclk_o = pixel_generator__clk_gen__pclk_i ; 
  assign  pixel_generator__clk_gen__pclk_ena_o =1'b1;
    assign pixel_generator__clk_gen__pclk_i = pixel_generator__pclk_i;
    assign pixel_generator__clk_gen__rst_i = pixel_generator__nVen;
    assign pixel_generator__pclk_o = pixel_generator__clk_gen__pclk_o;
    assign pixel_generator__dvi_pclk_p_o = pixel_generator__clk_gen__dvi_pclk_p_o;
    assign pixel_generator__dvi_pclk_m_o = pixel_generator__clk_gen__dvi_pclk_m_o;
    assign pixel_generator__pclk_ena = pixel_generator__clk_gen__pclk_ena_o;
      
    wire pixel_generator__vtgen__clk;
    wire pixel_generator__vtgen__clk_ena;
    wire pixel_generator__vtgen__rst;
    wire[7:0] pixel_generator__vtgen__Thsync;
    wire[7:0] pixel_generator__vtgen__Thgdel;
    wire[15:0] pixel_generator__vtgen__Thgate;
    wire[15:0] pixel_generator__vtgen__Thlen;
    wire[7:0] pixel_generator__vtgen__Tvsync;
    wire[7:0] pixel_generator__vtgen__Tvgdel;
    wire[15:0] pixel_generator__vtgen__Tvgate;
    wire[15:0] pixel_generator__vtgen__Tvlen;
    wire pixel_generator__vtgen__eol;
    wire pixel_generator__vtgen__eof;
    wire pixel_generator__vtgen__gate;
    wire pixel_generator__vtgen__hsync;
    wire pixel_generator__vtgen__vsync;
    wire pixel_generator__vtgen__csync;
    wire pixel_generator__vtgen__blank;

    wire pixel_generator__vtgen__Hgate , pixel_generator__vtgen__Vgate ; 
    wire pixel_generator__vtgen__Hdone ;  
    wire pixel_generator__vtgen__hor_gen__clk;
    wire pixel_generator__vtgen__hor_gen__ena;
    wire pixel_generator__vtgen__hor_gen__rst;
    wire[7:0] pixel_generator__vtgen__hor_gen__Tsync;
    wire[7:0] pixel_generator__vtgen__hor_gen__Tgdel;
    wire[15:0] pixel_generator__vtgen__hor_gen__Tgate;
    wire[15:0] pixel_generator__vtgen__hor_gen__Tlen;
    reg pixel_generator__vtgen__hor_gen__Sync;
    reg pixel_generator__vtgen__hor_gen__Gate;
    reg pixel_generator__vtgen__hor_gen__Done;
    wire pixel_generator__vtgen__ver_gen__clk;
    wire pixel_generator__vtgen__ver_gen__ena;
    wire pixel_generator__vtgen__ver_gen__rst;
    wire[7:0] pixel_generator__vtgen__ver_gen__Tsync;
    wire[7:0] pixel_generator__vtgen__ver_gen__Tgdel;
    wire[15:0] pixel_generator__vtgen__ver_gen__Tgate;
    wire[15:0] pixel_generator__vtgen__ver_gen__Tlen;
    reg pixel_generator__vtgen__ver_gen__Sync;
    reg pixel_generator__vtgen__ver_gen__Gate;
    reg pixel_generator__vtgen__ver_gen__Done;

    reg[15:0] pixel_generator__vtgen__hor_gen__cnt , pixel_generator__vtgen__hor_gen__cnt_len ; 
    wire[16:0] pixel_generator__vtgen__hor_gen__cnt_nxt , pixel_generator__vtgen__hor_gen__cnt_len_nxt ; 
    wire pixel_generator__vtgen__hor_gen__cnt_done , pixel_generator__vtgen__hor_gen__cnt_len_done ; 
  assign  pixel_generator__vtgen__hor_gen__cnt_nxt ={1'b0, pixel_generator__vtgen__hor_gen__cnt }-17'h1; 
  assign  pixel_generator__vtgen__hor_gen__cnt_done = pixel_generator__vtgen__hor_gen__cnt_nxt [16]; 
  assign  pixel_generator__vtgen__hor_gen__cnt_len_nxt ={1'b0, pixel_generator__vtgen__hor_gen__cnt_len }-17'h1; 
  assign  pixel_generator__vtgen__hor_gen__cnt_len_done = pixel_generator__vtgen__hor_gen__cnt_len_nxt [16]; reg[4:0] pixel_generator__vtgen__hor_gen__state ; parameter[4:0] pixel_generator__vtgen__hor_gen__idle_state =5'b00001; parameter[4:0] pixel_generator__vtgen__hor_gen__sync_state =5'b00010; parameter[4:0] pixel_generator__vtgen__hor_gen__gdel_state =5'b00100; parameter[4:0] pixel_generator__vtgen__hor_gen__gate_state =5'b01000; parameter[4:0] pixel_generator__vtgen__hor_gen__len_state =5'b10000; 
  always @( posedge  pixel_generator__vtgen__hor_gen__clk )
         if ( pixel_generator__vtgen__hor_gen__rst )
             begin  
                 pixel_generator__vtgen__hor_gen__state  <= pixel_generator__vtgen__hor_gen__idle_state ; 
                 pixel_generator__vtgen__hor_gen__cnt  <=16'h0; 
                 pixel_generator__vtgen__hor_gen__cnt_len  <=16'b0; 
                 pixel_generator__vtgen__hor_gen__Sync  <=1'b0; 
                 pixel_generator__vtgen__hor_gen__Gate  <=1'b0; 
                 pixel_generator__vtgen__hor_gen__Done  <=1'b0;
             end 
          else 
             if ( pixel_generator__vtgen__hor_gen__ena )
                 begin  
                     pixel_generator__vtgen__hor_gen__cnt  <= pixel_generator__vtgen__hor_gen__cnt_nxt [15:0]; 
                     pixel_generator__vtgen__hor_gen__cnt_len  <= pixel_generator__vtgen__hor_gen__cnt_len_nxt [15:0]; 
                     pixel_generator__vtgen__hor_gen__Done  <=1'b0;
                     case ( pixel_generator__vtgen__hor_gen__state ) 
                      pixel_generator__vtgen__hor_gen__idle_state  :
                          begin  
                              pixel_generator__vtgen__hor_gen__state  <= pixel_generator__vtgen__hor_gen__sync_state ; 
                              pixel_generator__vtgen__hor_gen__cnt  <= pixel_generator__vtgen__hor_gen__Tsync ; 
                              pixel_generator__vtgen__hor_gen__cnt_len  <= pixel_generator__vtgen__hor_gen__Tlen ; 
                              pixel_generator__vtgen__hor_gen__Sync  <=1'b1;
                          end  
                      pixel_generator__vtgen__hor_gen__sync_state  :
                          if ( pixel_generator__vtgen__hor_gen__cnt_done )
                              begin  
                                  pixel_generator__vtgen__hor_gen__state  <= pixel_generator__vtgen__hor_gen__gdel_state ; 
                                  pixel_generator__vtgen__hor_gen__cnt  <= pixel_generator__vtgen__hor_gen__Tgdel ; 
                                  pixel_generator__vtgen__hor_gen__Sync  <=1'b0;
                              end  
                      pixel_generator__vtgen__hor_gen__gdel_state  :
                          if ( pixel_generator__vtgen__hor_gen__cnt_done )
                              begin  
                                  pixel_generator__vtgen__hor_gen__state  <= pixel_generator__vtgen__hor_gen__gate_state ; 
                                  pixel_generator__vtgen__hor_gen__cnt  <= pixel_generator__vtgen__hor_gen__Tgate ; 
                                  pixel_generator__vtgen__hor_gen__Gate  <=1'b1;
                              end  
                      pixel_generator__vtgen__hor_gen__gate_state  :
                          if ( pixel_generator__vtgen__hor_gen__cnt_done )
                              begin  
                                  pixel_generator__vtgen__hor_gen__state  <= pixel_generator__vtgen__hor_gen__len_state ; 
                                  pixel_generator__vtgen__hor_gen__Gate  <=1'b0;
                              end  
                      pixel_generator__vtgen__hor_gen__len_state  :
                          if ( pixel_generator__vtgen__hor_gen__cnt_len_done )
                              begin  
                                  pixel_generator__vtgen__hor_gen__state  <= pixel_generator__vtgen__hor_gen__sync_state ; 
                                  pixel_generator__vtgen__hor_gen__cnt  <= pixel_generator__vtgen__hor_gen__Tsync ; 
                                  pixel_generator__vtgen__hor_gen__cnt_len  <= pixel_generator__vtgen__hor_gen__Tlen ; 
                                  pixel_generator__vtgen__hor_gen__Sync  <=1'b1; 
                                  pixel_generator__vtgen__hor_gen__Done  <=1'b1;
                              end endcase
                 end
 
     
    wire pixel_generator__vtgen__vclk_ena = pixel_generator__vtgen__Hdone & pixel_generator__vtgen__clk_ena ;  
    
    reg[15:0] pixel_generator__vtgen__ver_gen__cnt , pixel_generator__vtgen__ver_gen__cnt_len ; 
    wire[16:0] pixel_generator__vtgen__ver_gen__cnt_nxt , pixel_generator__vtgen__ver_gen__cnt_len_nxt ; 
    wire pixel_generator__vtgen__ver_gen__cnt_done , pixel_generator__vtgen__ver_gen__cnt_len_done ; 
  assign  pixel_generator__vtgen__ver_gen__cnt_nxt ={1'b0, pixel_generator__vtgen__ver_gen__cnt }-17'h1; 
  assign  pixel_generator__vtgen__ver_gen__cnt_done = pixel_generator__vtgen__ver_gen__cnt_nxt [16]; 
  assign  pixel_generator__vtgen__ver_gen__cnt_len_nxt ={1'b0, pixel_generator__vtgen__ver_gen__cnt_len }-17'h1; 
  assign  pixel_generator__vtgen__ver_gen__cnt_len_done = pixel_generator__vtgen__ver_gen__cnt_len_nxt [16]; reg[4:0] pixel_generator__vtgen__ver_gen__state ; parameter[4:0] pixel_generator__vtgen__ver_gen__idle_state =5'b00001; parameter[4:0] pixel_generator__vtgen__ver_gen__sync_state =5'b00010; parameter[4:0] pixel_generator__vtgen__ver_gen__gdel_state =5'b00100; parameter[4:0] pixel_generator__vtgen__ver_gen__gate_state =5'b01000; parameter[4:0] pixel_generator__vtgen__ver_gen__len_state =5'b10000; 
  always @( posedge  pixel_generator__vtgen__ver_gen__clk )
         if ( pixel_generator__vtgen__ver_gen__rst )
             begin  
                 pixel_generator__vtgen__ver_gen__state  <= pixel_generator__vtgen__ver_gen__idle_state ; 
                 pixel_generator__vtgen__ver_gen__cnt  <=16'h0; 
                 pixel_generator__vtgen__ver_gen__cnt_len  <=16'b0; 
                 pixel_generator__vtgen__ver_gen__Sync  <=1'b0; 
                 pixel_generator__vtgen__ver_gen__Gate  <=1'b0; 
                 pixel_generator__vtgen__ver_gen__Done  <=1'b0;
             end 
          else 
             if ( pixel_generator__vtgen__ver_gen__ena )
                 begin  
                     pixel_generator__vtgen__ver_gen__cnt  <= pixel_generator__vtgen__ver_gen__cnt_nxt [15:0]; 
                     pixel_generator__vtgen__ver_gen__cnt_len  <= pixel_generator__vtgen__ver_gen__cnt_len_nxt [15:0]; 
                     pixel_generator__vtgen__ver_gen__Done  <=1'b0;
                     case ( pixel_generator__vtgen__ver_gen__state ) 
                      pixel_generator__vtgen__ver_gen__idle_state  :
                          begin  
                              pixel_generator__vtgen__ver_gen__state  <= pixel_generator__vtgen__ver_gen__sync_state ; 
                              pixel_generator__vtgen__ver_gen__cnt  <= pixel_generator__vtgen__ver_gen__Tsync ; 
                              pixel_generator__vtgen__ver_gen__cnt_len  <= pixel_generator__vtgen__ver_gen__Tlen ; 
                              pixel_generator__vtgen__ver_gen__Sync  <=1'b1;
                          end  
                      pixel_generator__vtgen__ver_gen__sync_state  :
                          if ( pixel_generator__vtgen__ver_gen__cnt_done )
                              begin  
                                  pixel_generator__vtgen__ver_gen__state  <= pixel_generator__vtgen__ver_gen__gdel_state ; 
                                  pixel_generator__vtgen__ver_gen__cnt  <= pixel_generator__vtgen__ver_gen__Tgdel ; 
                                  pixel_generator__vtgen__ver_gen__Sync  <=1'b0;
                              end  
                      pixel_generator__vtgen__ver_gen__gdel_state  :
                          if ( pixel_generator__vtgen__ver_gen__cnt_done )
                              begin  
                                  pixel_generator__vtgen__ver_gen__state  <= pixel_generator__vtgen__ver_gen__gate_state ; 
                                  pixel_generator__vtgen__ver_gen__cnt  <= pixel_generator__vtgen__ver_gen__Tgate ; 
                                  pixel_generator__vtgen__ver_gen__Gate  <=1'b1;
                              end  
                      pixel_generator__vtgen__ver_gen__gate_state  :
                          if ( pixel_generator__vtgen__ver_gen__cnt_done )
                              begin  
                                  pixel_generator__vtgen__ver_gen__state  <= pixel_generator__vtgen__ver_gen__len_state ; 
                                  pixel_generator__vtgen__ver_gen__Gate  <=1'b0;
                              end  
                      pixel_generator__vtgen__ver_gen__len_state  :
                          if ( pixel_generator__vtgen__ver_gen__cnt_len_done )
                              begin  
                                  pixel_generator__vtgen__ver_gen__state  <= pixel_generator__vtgen__ver_gen__sync_state ; 
                                  pixel_generator__vtgen__ver_gen__cnt  <= pixel_generator__vtgen__ver_gen__Tsync ; 
                                  pixel_generator__vtgen__ver_gen__cnt_len  <= pixel_generator__vtgen__ver_gen__Tlen ; 
                                  pixel_generator__vtgen__ver_gen__Sync  <=1'b1; 
                                  pixel_generator__vtgen__ver_gen__Done  <=1'b1;
                              end endcase
                 end
 
    assign pixel_generator__vtgen__hor_gen__clk = pixel_generator__vtgen__clk;
    assign pixel_generator__vtgen__hor_gen__ena = pixel_generator__vtgen__clk_ena;
    assign pixel_generator__vtgen__hor_gen__rst = pixel_generator__vtgen__rst;
    assign pixel_generator__vtgen__hor_gen__Tsync = pixel_generator__vtgen__Thsync;
    assign pixel_generator__vtgen__hor_gen__Tgdel = pixel_generator__vtgen__Thgdel;
    assign pixel_generator__vtgen__hor_gen__Tgate = pixel_generator__vtgen__Thgate;
    assign pixel_generator__vtgen__hor_gen__Tlen = pixel_generator__vtgen__Thlen;
    assign pixel_generator__vtgen__hsync = pixel_generator__vtgen__hor_gen__Sync;
    assign pixel_generator__vtgen__Hgate = pixel_generator__vtgen__hor_gen__Gate;
    assign pixel_generator__vtgen__Hdone = pixel_generator__vtgen__hor_gen__Done;
    assign pixel_generator__vtgen__ver_gen__clk = pixel_generator__vtgen__clk;
    assign pixel_generator__vtgen__ver_gen__ena = pixel_generator__vtgen__vclk_ena;
    assign pixel_generator__vtgen__ver_gen__rst = pixel_generator__vtgen__rst;
    assign pixel_generator__vtgen__ver_gen__Tsync = pixel_generator__vtgen__Tvsync;
    assign pixel_generator__vtgen__ver_gen__Tgdel = pixel_generator__vtgen__Tvgdel;
    assign pixel_generator__vtgen__ver_gen__Tgate = pixel_generator__vtgen__Tvgate;
    assign pixel_generator__vtgen__ver_gen__Tlen = pixel_generator__vtgen__Tvlen;
    assign pixel_generator__vtgen__vsync = pixel_generator__vtgen__ver_gen__Sync;
    assign pixel_generator__vtgen__Vgate = pixel_generator__vtgen__ver_gen__Gate;
    assign pixel_generator__vtgen__eof = pixel_generator__vtgen__ver_gen__Done;
     
  assign  pixel_generator__vtgen__eol = pixel_generator__vtgen__Hdone ; 
  assign  pixel_generator__vtgen__gate = pixel_generator__vtgen__Hgate & pixel_generator__vtgen__Vgate ; 
  assign  pixel_generator__vtgen__csync = pixel_generator__vtgen__hsync | pixel_generator__vtgen__vsync ; 
  assign  pixel_generator__vtgen__blank =~ pixel_generator__vtgen__gate ;
    assign pixel_generator__vtgen__clk = pixel_generator__pclk_i;
    assign pixel_generator__vtgen__clk_ena = pixel_generator__pclk_ena;
    assign pixel_generator__vtgen__rst = pixel_generator__nVen;
    assign pixel_generator__vtgen__Thsync = pixel_generator__Thsync;
    assign pixel_generator__vtgen__Thgdel = pixel_generator__Thgdel;
    assign pixel_generator__vtgen__Thgate = pixel_generator__Thgate;
    assign pixel_generator__vtgen__Thlen = pixel_generator__Thlen;
    assign pixel_generator__vtgen__Tvsync = pixel_generator__Tvsync;
    assign pixel_generator__vtgen__Tvgdel = pixel_generator__Tvgdel;
    assign pixel_generator__vtgen__Tvgate = pixel_generator__Tvgate;
    assign pixel_generator__vtgen__Tvlen = pixel_generator__Tvlen;
    assign pixel_generator__eol = pixel_generator__vtgen__eol;
    assign pixel_generator__eof = pixel_generator__vtgen__eof;
    assign pixel_generator__gate = pixel_generator__vtgen__gate;
    assign pixel_generator__ihsync = pixel_generator__vtgen__hsync;
    assign pixel_generator__ivsync = pixel_generator__vtgen__vsync;
    assign pixel_generator__icsync = pixel_generator__vtgen__csync;
    assign pixel_generator__iblank = pixel_generator__vtgen__blank;
     
    reg pixel_generator__seol , pixel_generator__seof ; 
    reg pixel_generator__dseol , pixel_generator__dseof ; 
  always @( posedge  pixel_generator__clk_i )
         if (~ pixel_generator__ctrl_ven )
             begin  
                 pixel_generator__seol  <=1'b0; 
                 pixel_generator__dseol  <=1'b0; 
                 pixel_generator__seof  <=1'b0; 
                 pixel_generator__dseof  <=1'b0; 
                 pixel_generator__eoh  <=1'b0; 
                 pixel_generator__eov  <=1'b0;
             end 
          else 
             begin  
                 pixel_generator__seol  <= pixel_generator__eol ; 
                 pixel_generator__dseol  <= pixel_generator__seol ; 
                 pixel_generator__seof  <= pixel_generator__eof ; 
                 pixel_generator__dseof  <= pixel_generator__seof ; 
                 pixel_generator__eoh  <= pixel_generator__seol &! pixel_generator__dseol ; 
                 pixel_generator__eov  <= pixel_generator__seof &! pixel_generator__dseof ;
             end
    reg pixel_generator__hsync , pixel_generator__vsync , pixel_generator__csync , pixel_generator__blank ; 
  always @( posedge  pixel_generator__pclk_i )
         begin  
             pixel_generator__hsync  <= pixel_generator__ihsync ^ pixel_generator__ctrl_HSyncL ; 
             pixel_generator__vsync  <= pixel_generator__ivsync ^ pixel_generator__ctrl_VSyncL ; 
             pixel_generator__csync  <= pixel_generator__icsync ^ pixel_generator__ctrl_CSyncL ; 
             pixel_generator__blank  <= pixel_generator__iblank ^ pixel_generator__ctrl_BlankL ; 
             pixel_generator__hsync_o  <= pixel_generator__hsync ; 
             pixel_generator__vsync_o  <= pixel_generator__vsync ; 
             pixel_generator__csync_o  <= pixel_generator__csync ; 
             pixel_generator__blank_o  <= pixel_generator__blank ;
         end
    wire[23:0] pixel_generator__color_proc_q ; 
    wire pixel_generator__color_proc_wreq ; 
    wire[7:0] pixel_generator__clut_offs ; 
    reg pixel_generator__dImDoneFifoQ , pixel_generator__ddImDoneFifoQ ; 
    wire[23:0] pixel_generator__cur1_q ; 
    wire pixel_generator__cur1_wreq ; 
    wire[23:0] pixel_generator__rgb_fifo_d ; 
    wire pixel_generator__rgb_fifo_empty , pixel_generator__rgb_fifo_full , pixel_generator__rgb_fifo_rreq , pixel_generator__rgb_fifo_wreq ; 
    wire pixel_generator__sclr =~ pixel_generator__ctrl_ven ;  
    wire pixel_generator__color_proc__clk;
    wire pixel_generator__color_proc__srst;
    wire[31:0] pixel_generator__color_proc__vdat_buffer_di;
    wire[1:0] pixel_generator__color_proc__ColorDepth;
    wire pixel_generator__color_proc__PseudoColor;
    wire pixel_generator__color_proc__vdat_buffer_empty;
    reg pixel_generator__color_proc__vdat_buffer_rreq;
    wire pixel_generator__color_proc__rgb_fifo_full;
    reg pixel_generator__color_proc__rgb_fifo_wreq;
    reg[7:0] pixel_generator__color_proc__r;
    reg[7:0] pixel_generator__color_proc__g;
    reg[7:0] pixel_generator__color_proc__b;
    reg pixel_generator__color_proc__clut_req;
    wire pixel_generator__color_proc__clut_ack;
    reg[7:0] pixel_generator__color_proc__clut_offs;
    wire[23:0] pixel_generator__color_proc__clut_q;

    reg[31:0] pixel_generator__color_proc__DataBuffer ; reg[7:0] pixel_generator__color_proc__Ra , pixel_generator__color_proc__Ga , pixel_generator__color_proc__Ba ; reg[1:0] pixel_generator__color_proc__colcnt ; 
    reg pixel_generator__color_proc__RGBbuf_wreq ; 
  always @( posedge  pixel_generator__color_proc__clk )
         if ( pixel_generator__color_proc__vdat_buffer_rreq ) 
             pixel_generator__color_proc__DataBuffer  <= pixel_generator__color_proc__vdat_buffer_di ;
 parameter pixel_generator__color_proc__idle =7'b000_0000, pixel_generator__color_proc__fill_buf =7'b000_0001, pixel_generator__color_proc__bw_8bpp =7'b000_0010, pixel_generator__color_proc__col_8bpp =7'b000_0100, pixel_generator__color_proc__col_16bpp_a =7'b000_1000, pixel_generator__color_proc__col_16bpp_b =7'b001_0000, pixel_generator__color_proc__col_24bpp =7'b010_0000, pixel_generator__color_proc__col_32bpp =7'b100_0000; reg[6:0] pixel_generator__color_proc__c_state ; reg[6:0] pixel_generator__color_proc__nxt_state ; 
  always @(        pixel_generator__color_proc__c_state                      or   pixel_generator__color_proc__vdat_buffer_empty               or   pixel_generator__color_proc__ColorDepth              or   pixel_generator__color_proc__PseudoColor             or   pixel_generator__color_proc__rgb_fifo_full            or   pixel_generator__color_proc__colcnt           or   pixel_generator__color_proc__clut_ack  )
         begin : pixel_generator__color_proc__nxt_state_decoder  
             pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__c_state ;
             case ( pixel_generator__color_proc__c_state ) 
              pixel_generator__color_proc__idle  :
                  if (! pixel_generator__color_proc__vdat_buffer_empty &&! pixel_generator__color_proc__rgb_fifo_full ) 
                      pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__fill_buf ; 
              pixel_generator__color_proc__fill_buf  :
                  case ( pixel_generator__color_proc__ColorDepth )
                   2 'b00:
                       if ( pixel_generator__color_proc__PseudoColor ) 
                           pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__col_8bpp ;
                        else  
                           pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__bw_8bpp ;
                   2 'b01: 
                       pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__col_16bpp_a ;
                   2 'b10: 
                       pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__col_24bpp ;
                   2 'b11: 
                       pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__col_32bpp ;endcase 
              pixel_generator__color_proc__bw_8bpp  :
                  if (! pixel_generator__color_proc__rgb_fifo_full &&!(| pixel_generator__color_proc__colcnt ))
                      if (! pixel_generator__color_proc__vdat_buffer_empty ) 
                          pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__fill_buf ;
                       else  
                          pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__idle ; 
              pixel_generator__color_proc__col_8bpp  :
                  if (!(| pixel_generator__color_proc__colcnt ))
                      if (! pixel_generator__color_proc__vdat_buffer_empty &&! pixel_generator__color_proc__rgb_fifo_full ) 
                          pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__fill_buf ;
                       else  
                          pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__idle ; 
              pixel_generator__color_proc__col_16bpp_a  :
                  if (! pixel_generator__color_proc__rgb_fifo_full ) 
                      pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__col_16bpp_b ; 
              pixel_generator__color_proc__col_16bpp_b  :
                  if (! pixel_generator__color_proc__rgb_fifo_full )
                      if (! pixel_generator__color_proc__vdat_buffer_empty ) 
                          pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__fill_buf ;
                       else  
                          pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__idle ; 
              pixel_generator__color_proc__col_24bpp  :
                  if (! pixel_generator__color_proc__rgb_fifo_full )
                      if ( pixel_generator__color_proc__colcnt ==2'h1) 
                          pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__col_24bpp ;
                       else 
                          if (! pixel_generator__color_proc__vdat_buffer_empty ) 
                              pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__fill_buf ;
                           else  
                              pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__idle ; 
              pixel_generator__color_proc__col_32bpp  :
                  if (! pixel_generator__color_proc__rgb_fifo_full )
                      if (! pixel_generator__color_proc__vdat_buffer_empty ) 
                          pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__fill_buf ;
                       else  
                          pixel_generator__color_proc__nxt_state  = pixel_generator__color_proc__idle ;endcase
         end
  always @( posedge  pixel_generator__color_proc__clk )
         if ( pixel_generator__color_proc__srst ) 
             pixel_generator__color_proc__c_state  <= pixel_generator__color_proc__idle ;
          else  
             pixel_generator__color_proc__c_state  <= pixel_generator__color_proc__nxt_state ;
    reg pixel_generator__color_proc__iclut_req ; 
    reg pixel_generator__color_proc__ivdat_buf_rreq ; reg[7:0] pixel_generator__color_proc__iR , pixel_generator__color_proc__iG , pixel_generator__color_proc__iB , pixel_generator__color_proc__iRa , pixel_generator__color_proc__iGa , pixel_generator__color_proc__iBa ; 
  always @(           pixel_generator__color_proc__c_state                            or   pixel_generator__color_proc__vdat_buffer_empty                  or   pixel_generator__color_proc__colcnt                 or   pixel_generator__color_proc__DataBuffer                or   pixel_generator__color_proc__rgb_fifo_full               or   pixel_generator__color_proc__clut_ack              or   pixel_generator__color_proc__clut_q             or   pixel_generator__color_proc__Ba            or   pixel_generator__color_proc__Ga           or   pixel_generator__color_proc__Ra  )
         begin : pixel_generator__color_proc__output_decoder  
             pixel_generator__color_proc__ivdat_buf_rreq  =1'b0; 
             pixel_generator__color_proc__RGBbuf_wreq  =1'b0; 
             pixel_generator__color_proc__iclut_req  =1'b0; 
             pixel_generator__color_proc__iR  ='h0; 
             pixel_generator__color_proc__iG  ='h0; 
             pixel_generator__color_proc__iB  ='h0; 
             pixel_generator__color_proc__iRa  ='h0; 
             pixel_generator__color_proc__iGa  ='h0; 
             pixel_generator__color_proc__iBa  ='h0;
             case ( pixel_generator__color_proc__c_state ) 
              pixel_generator__color_proc__idle  :
                  begin 
                      if (! pixel_generator__color_proc__rgb_fifo_full )
                          if (! pixel_generator__color_proc__vdat_buffer_empty ) 
                              pixel_generator__color_proc__ivdat_buf_rreq  =1'b1; 
                      pixel_generator__color_proc__RGBbuf_wreq  = pixel_generator__color_proc__clut_ack ; 
                      pixel_generator__color_proc__iR  = pixel_generator__color_proc__clut_q [23:16]; 
                      pixel_generator__color_proc__iG  = pixel_generator__color_proc__clut_q [15:8]; 
                      pixel_generator__color_proc__iB  = pixel_generator__color_proc__clut_q [7:0];
                  end  
              pixel_generator__color_proc__fill_buf  :
                  begin  
                      pixel_generator__color_proc__RGBbuf_wreq  = pixel_generator__color_proc__clut_ack ; 
                      pixel_generator__color_proc__iR  = pixel_generator__color_proc__clut_q [23:16]; 
                      pixel_generator__color_proc__iG  = pixel_generator__color_proc__clut_q [15:8]; 
                      pixel_generator__color_proc__iB  = pixel_generator__color_proc__clut_q [7:0];
                  end  
              pixel_generator__color_proc__bw_8bpp  :
                  begin 
                      if (! pixel_generator__color_proc__rgb_fifo_full )
                          begin  
                              pixel_generator__color_proc__RGBbuf_wreq  =1'b1;
                              if ((! pixel_generator__color_proc__vdat_buffer_empty )&&!(| pixel_generator__color_proc__colcnt )) 
                                  pixel_generator__color_proc__ivdat_buf_rreq  =1'b1;
                          end 
                      case ( pixel_generator__color_proc__colcnt )
                       2 'b11:
                           begin  
                               pixel_generator__color_proc__iR  = pixel_generator__color_proc__DataBuffer [31:24]; 
                               pixel_generator__color_proc__iG  = pixel_generator__color_proc__DataBuffer [31:24]; 
                               pixel_generator__color_proc__iB  = pixel_generator__color_proc__DataBuffer [31:24];
                           end 
                       2 'b10:
                           begin  
                               pixel_generator__color_proc__iR  = pixel_generator__color_proc__DataBuffer [23:16]; 
                               pixel_generator__color_proc__iG  = pixel_generator__color_proc__DataBuffer [23:16]; 
                               pixel_generator__color_proc__iB  = pixel_generator__color_proc__DataBuffer [23:16];
                           end 
                       2 'b01:
                           begin  
                               pixel_generator__color_proc__iR  = pixel_generator__color_proc__DataBuffer [15:8]; 
                               pixel_generator__color_proc__iG  = pixel_generator__color_proc__DataBuffer [15:8]; 
                               pixel_generator__color_proc__iB  = pixel_generator__color_proc__DataBuffer [15:8];
                           end 
                       default :
                           begin  
                               pixel_generator__color_proc__iR  = pixel_generator__color_proc__DataBuffer [7:0]; 
                               pixel_generator__color_proc__iG  = pixel_generator__color_proc__DataBuffer [7:0]; 
                               pixel_generator__color_proc__iB  = pixel_generator__color_proc__DataBuffer [7:0];
                           end endcase
                  end  
              pixel_generator__color_proc__col_8bpp  :
                  begin 
                      if (!(| pixel_generator__color_proc__colcnt ))
                          if (! pixel_generator__color_proc__vdat_buffer_empty &&! pixel_generator__color_proc__rgb_fifo_full ) 
                              pixel_generator__color_proc__ivdat_buf_rreq  =1'b1; 
                      pixel_generator__color_proc__RGBbuf_wreq  = pixel_generator__color_proc__clut_ack ; 
                      pixel_generator__color_proc__iR  = pixel_generator__color_proc__clut_q [23:16]; 
                      pixel_generator__color_proc__iG  = pixel_generator__color_proc__clut_q [15:8]; 
                      pixel_generator__color_proc__iB  = pixel_generator__color_proc__clut_q [7:0]; 
                      pixel_generator__color_proc__iclut_req  =! pixel_generator__color_proc__rgb_fifo_full ||( pixel_generator__color_proc__colcnt [1]^ pixel_generator__color_proc__colcnt [0]);
                  end  
              pixel_generator__color_proc__col_16bpp_a  :
                  begin 
                      if (! pixel_generator__color_proc__rgb_fifo_full ) 
                          pixel_generator__color_proc__RGBbuf_wreq  =1'b1; 
                      pixel_generator__color_proc__iR  [7:3]= pixel_generator__color_proc__DataBuffer [31:27]; 
                      pixel_generator__color_proc__iG  [7:2]= pixel_generator__color_proc__DataBuffer [26:21]; 
                      pixel_generator__color_proc__iB  [7:3]= pixel_generator__color_proc__DataBuffer [20:16];
                  end  
              pixel_generator__color_proc__col_16bpp_b  :
                  begin 
                      if (! pixel_generator__color_proc__rgb_fifo_full )
                          begin  
                              pixel_generator__color_proc__RGBbuf_wreq  =1'b1;
                              if (! pixel_generator__color_proc__vdat_buffer_empty ) 
                                  pixel_generator__color_proc__ivdat_buf_rreq  =1'b1;
                          end  
                      pixel_generator__color_proc__iR  [7:3]= pixel_generator__color_proc__DataBuffer [15:11]; 
                      pixel_generator__color_proc__iG  [7:2]= pixel_generator__color_proc__DataBuffer [10:5]; 
                      pixel_generator__color_proc__iB  [7:3]= pixel_generator__color_proc__DataBuffer [4:0];
                  end  
              pixel_generator__color_proc__col_24bpp  :
                  begin 
                      if (! pixel_generator__color_proc__rgb_fifo_full )
                          begin  
                              pixel_generator__color_proc__RGBbuf_wreq  =1'b1;
                              if (( pixel_generator__color_proc__colcnt !=2'h1)&&! pixel_generator__color_proc__vdat_buffer_empty ) 
                                  pixel_generator__color_proc__ivdat_buf_rreq  =1'b1;
                          end 
                      case ( pixel_generator__color_proc__colcnt )
                       2 'b11:
                           begin  
                               pixel_generator__color_proc__iR  = pixel_generator__color_proc__DataBuffer [31:24]; 
                               pixel_generator__color_proc__iG  = pixel_generator__color_proc__DataBuffer [23:16]; 
                               pixel_generator__color_proc__iB  = pixel_generator__color_proc__DataBuffer [15:8]; 
                               pixel_generator__color_proc__iRa  = pixel_generator__color_proc__DataBuffer [7:0];
                           end 
                       2 'b10:
                           begin  
                               pixel_generator__color_proc__iR  = pixel_generator__color_proc__Ra ; 
                               pixel_generator__color_proc__iG  = pixel_generator__color_proc__DataBuffer [31:24]; 
                               pixel_generator__color_proc__iB  = pixel_generator__color_proc__DataBuffer [23:16]; 
                               pixel_generator__color_proc__iRa  = pixel_generator__color_proc__DataBuffer [15:8]; 
                               pixel_generator__color_proc__iGa  = pixel_generator__color_proc__DataBuffer [7:0];
                           end 
                       2 'b01:
                           begin  
                               pixel_generator__color_proc__iR  = pixel_generator__color_proc__Ra ; 
                               pixel_generator__color_proc__iG  = pixel_generator__color_proc__Ga ; 
                               pixel_generator__color_proc__iB  = pixel_generator__color_proc__DataBuffer [31:24]; 
                               pixel_generator__color_proc__iRa  = pixel_generator__color_proc__DataBuffer [23:16]; 
                               pixel_generator__color_proc__iGa  = pixel_generator__color_proc__DataBuffer [15:8]; 
                               pixel_generator__color_proc__iBa  = pixel_generator__color_proc__DataBuffer [7:0];
                           end 
                       default :
                           begin  
                               pixel_generator__color_proc__iR  = pixel_generator__color_proc__Ra ; 
                               pixel_generator__color_proc__iG  = pixel_generator__color_proc__Ga ; 
                               pixel_generator__color_proc__iB  = pixel_generator__color_proc__Ba ;
                           end endcase
                  end  
              pixel_generator__color_proc__col_32bpp  :
                  begin 
                      if (! pixel_generator__color_proc__rgb_fifo_full )
                          begin  
                              pixel_generator__color_proc__RGBbuf_wreq  =1'b1;
                              if (! pixel_generator__color_proc__vdat_buffer_empty ) 
                                  pixel_generator__color_proc__ivdat_buf_rreq  =1'b1;
                          end  
                      pixel_generator__color_proc__iR  [7:0]= pixel_generator__color_proc__DataBuffer [23:16]; 
                      pixel_generator__color_proc__iG  [7:0]= pixel_generator__color_proc__DataBuffer [15:8]; 
                      pixel_generator__color_proc__iB  [7:0]= pixel_generator__color_proc__DataBuffer [7:0];
                  end endcase
         end
  always @( posedge  pixel_generator__color_proc__clk )
         begin  
             pixel_generator__color_proc__r  <= pixel_generator__color_proc__iR ; 
             pixel_generator__color_proc__g  <= pixel_generator__color_proc__iG ; 
             pixel_generator__color_proc__b  <= pixel_generator__color_proc__iB ;
             if ( pixel_generator__color_proc__RGBbuf_wreq )
                 begin  
                     pixel_generator__color_proc__Ra  <= pixel_generator__color_proc__iRa ; 
                     pixel_generator__color_proc__Ba  <= pixel_generator__color_proc__iBa ; 
                     pixel_generator__color_proc__Ga  <= pixel_generator__color_proc__iGa ;
                 end 
             if ( pixel_generator__color_proc__srst )
                 begin  
                     pixel_generator__color_proc__vdat_buffer_rreq  <=1'b0; 
                     pixel_generator__color_proc__rgb_fifo_wreq  <=1'b0; 
                     pixel_generator__color_proc__clut_req  <=1'b0;
                 end 
              else 
                 begin  
                     pixel_generator__color_proc__vdat_buffer_rreq  <= pixel_generator__color_proc__ivdat_buf_rreq ; 
                     pixel_generator__color_proc__rgb_fifo_wreq  <= pixel_generator__color_proc__RGBbuf_wreq ; 
                     pixel_generator__color_proc__clut_req  <= pixel_generator__color_proc__iclut_req ;
                 end 
         end
  always @(   pixel_generator__color_proc__colcnt            or   pixel_generator__color_proc__DataBuffer  )
         case ( pixel_generator__color_proc__colcnt )
          2 'b11: 
              pixel_generator__color_proc__clut_offs  = pixel_generator__color_proc__DataBuffer [31:24];
          2 'b10: 
              pixel_generator__color_proc__clut_offs  = pixel_generator__color_proc__DataBuffer [23:16];
          2 'b01: 
              pixel_generator__color_proc__clut_offs  = pixel_generator__color_proc__DataBuffer [15:8];
          2 'b00: 
              pixel_generator__color_proc__clut_offs  = pixel_generator__color_proc__DataBuffer [7:0];endcase
  always @( posedge  pixel_generator__color_proc__clk )
         if ( pixel_generator__color_proc__srst ) 
             pixel_generator__color_proc__colcnt  <=2'b11;
          else 
             if ( pixel_generator__color_proc__RGBbuf_wreq ) 
                 pixel_generator__color_proc__colcnt  <= pixel_generator__color_proc__colcnt -2'h1;

    assign pixel_generator__color_proc__clk = pixel_generator__clk_i;
    assign pixel_generator__color_proc__srst = pixel_generator__sclr;
    assign pixel_generator__color_proc__vdat_buffer_di = pixel_generator__fb_data_fifo_q;
    assign pixel_generator__color_proc__ColorDepth = pixel_generator__ctrl_cd;
    assign pixel_generator__color_proc__PseudoColor = pixel_generator__ctrl_pc;
    assign pixel_generator__color_proc__vdat_buffer_empty = pixel_generator__fb_data_fifo_empty;
    assign pixel_generator__fb_data_fifo_rreq = pixel_generator__color_proc__vdat_buffer_rreq;
    assign pixel_generator__color_proc__rgb_fifo_full = pixel_generator__rgb_fifo_full;
    assign pixel_generator__color_proc_wreq = pixel_generator__color_proc__rgb_fifo_wreq;
    assign pixel_generator__color_proc_q[23:16] = pixel_generator__color_proc__r;
    assign pixel_generator__color_proc_q[15:8] = pixel_generator__color_proc__g;
    assign pixel_generator__color_proc_q[7:0] = pixel_generator__color_proc__b;
    assign pixel_generator__clut_req = pixel_generator__color_proc__clut_req;
    assign pixel_generator__color_proc__clut_ack = pixel_generator__clut_ack;
    assign pixel_generator__clut_offs = pixel_generator__color_proc__clut_offs;
    assign pixel_generator__color_proc__clut_q = pixel_generator__clut_q;
     
  always @( posedge  pixel_generator__clk_i )
         if ( pixel_generator__sclr ) 
             pixel_generator__dImDoneFifoQ  <=1'b0;
          else 
             if ( pixel_generator__fb_data_fifo_rreq ) 
                 pixel_generator__dImDoneFifoQ  <= pixel_generator__ImDoneFifoQ ;
  always @( posedge  pixel_generator__clk_i )
         if ( pixel_generator__sclr ) 
             pixel_generator__ddImDoneFifoQ  <=1'b0;
          else  
             pixel_generator__ddImDoneFifoQ  <= pixel_generator__dImDoneFifoQ ;
  assign  pixel_generator__clut_switch = pixel_generator__ddImDoneFifoQ &! pixel_generator__dImDoneFifoQ ; 
  always @( posedge  pixel_generator__clk_i )
         if ( pixel_generator__sclr ) 
             pixel_generator__stat_acmp  <=1'b0;
          else 
             if ( pixel_generator__ctrl_cbsw ) 
                 pixel_generator__stat_acmp  <= pixel_generator__stat_acmp ^ pixel_generator__clut_switch ;
  assign  pixel_generator__clut_adr ={ pixel_generator__stat_acmp , pixel_generator__clut_offs }; 
  assign  pixel_generator__cur1_wreq = pixel_generator__color_proc_wreq ; 
  assign  pixel_generator__cur1_q = pixel_generator__color_proc_q ; 
  assign  pixel_generator__cc1_adr_o =4'h0; 
  assign  pixel_generator__rgb_fifo_wreq = pixel_generator__cur1_wreq ; 
  assign  pixel_generator__rgb_fifo_d = pixel_generator__cur1_q ; 
  assign  pixel_generator__cc0_adr_o =4'h0; 
    wire[4:0] pixel_generator__rgb_fifo_nword ;  
    wire pixel_generator__rgb_fifo__clk;
    wire pixel_generator__rgb_fifo__aclr;
    wire pixel_generator__rgb_fifo__sclr;
    wire pixel_generator__rgb_fifo__wreq;
    wire pixel_generator__rgb_fifo__rreq;
    wire[24-1:0] pixel_generator__rgb_fifo__d;
    wire[24-1:0] pixel_generator__rgb_fifo__q;
    reg pixel_generator__rgb_fifo__nword;
    reg pixel_generator__rgb_fifo__empty;
    reg pixel_generator__rgb_fifo__full;
    wire pixel_generator__rgb_fifo__aempty;
    wire pixel_generator__rgb_fifo__afull;

    reg[4-1:0] pixel_generator__rgb_fifo__rp , pixel_generator__rgb_fifo__wp ; 
    wire[24-1:0] pixel_generator__rgb_fifo__ramq ; 
    wire pixel_generator__rgb_fifo__fwreq , pixel_generator__rgb_fifo__frreq ; 
  assign  pixel_generator__rgb_fifo__fwreq = pixel_generator__rgb_fifo__wreq ; 
  assign  pixel_generator__rgb_fifo__frreq = pixel_generator__rgb_fifo__rreq ; 
  always @(  posedge   pixel_generator__rgb_fifo__clk          or  negedge  pixel_generator__rgb_fifo__aclr )
         if (~ pixel_generator__rgb_fifo__aclr ) 
             pixel_generator__rgb_fifo__rp  <=0;
          else 
             if ( pixel_generator__rgb_fifo__sclr ) 
                 pixel_generator__rgb_fifo__rp  <=0;
              else 
                 if ( pixel_generator__rgb_fifo__frreq ) 
                     pixel_generator__rgb_fifo__rp  <={ pixel_generator__rgb_fifo__rp [4-1:1], pixel_generator__rgb_fifo__lsb ( pixel_generator__rgb_fifo__rp )};
  always @(  posedge   pixel_generator__rgb_fifo__clk          or  negedge  pixel_generator__rgb_fifo__aclr )
         if (~ pixel_generator__rgb_fifo__aclr ) 
             pixel_generator__rgb_fifo__wp  <=0;
          else 
             if ( pixel_generator__rgb_fifo__sclr ) 
                 pixel_generator__rgb_fifo__wp  <=0;
              else 
                 if ( pixel_generator__rgb_fifo__fwreq ) 
                     pixel_generator__rgb_fifo__wp  <={ pixel_generator__rgb_fifo__wp [4-1:1], pixel_generator__rgb_fifo__lsb ( pixel_generator__rgb_fifo__wp )};
 reg[24-1:0] pixel_generator__rgb_fifo__mem [(1<<4)-1:0]; 
  always @( posedge  pixel_generator__rgb_fifo__clk )
         if ( pixel_generator__rgb_fifo__fwreq ) 
             pixel_generator__rgb_fifo__mem  [ pixel_generator__rgb_fifo__wp ]<= pixel_generator__rgb_fifo__d ;
  assign  pixel_generator__rgb_fifo__q = pixel_generator__rgb_fifo__mem [ pixel_generator__rgb_fifo__rp ]; 
  assign  pixel_generator__rgb_fifo__aempty =( pixel_generator__rgb_fifo__rp [4-1:1]== pixel_generator__rgb_fifo__wp [4:2])&( pixel_generator__rgb_fifo__lsb ( pixel_generator__rgb_fifo__rp )== pixel_generator__rgb_fifo__wp [1])& pixel_generator__rgb_fifo__frreq &~ pixel_generator__rgb_fifo__fwreq ; 
  always @(  posedge   pixel_generator__rgb_fifo__clk          or  negedge  pixel_generator__rgb_fifo__aclr )
         if (~ pixel_generator__rgb_fifo__aclr ) 
             pixel_generator__rgb_fifo__empty  <=1'b1;
          else 
             if ( pixel_generator__rgb_fifo__sclr ) 
                 pixel_generator__rgb_fifo__empty  <=1'b1;
              else  
                 pixel_generator__rgb_fifo__empty  <= pixel_generator__rgb_fifo__aempty |( pixel_generator__rgb_fifo__empty &(~ pixel_generator__rgb_fifo__fwreq + pixel_generator__rgb_fifo__frreq ));
  assign  pixel_generator__rgb_fifo__afull =( pixel_generator__rgb_fifo__wp [4-1:1]== pixel_generator__rgb_fifo__rp [4:2])&( pixel_generator__rgb_fifo__lsb ( pixel_generator__rgb_fifo__wp )== pixel_generator__rgb_fifo__rp [1])& pixel_generator__rgb_fifo__fwreq &~ pixel_generator__rgb_fifo__frreq ; 
  always @(  posedge   pixel_generator__rgb_fifo__clk          or  negedge  pixel_generator__rgb_fifo__aclr )
         if (~ pixel_generator__rgb_fifo__aclr ) 
             pixel_generator__rgb_fifo__full  <=1'b0;
          else 
             if ( pixel_generator__rgb_fifo__sclr ) 
                 pixel_generator__rgb_fifo__full  <=1'b0;
              else  
                 pixel_generator__rgb_fifo__full  <= pixel_generator__rgb_fifo__afull |( pixel_generator__rgb_fifo__full &(~ pixel_generator__rgb_fifo__frreq + pixel_generator__rgb_fifo__fwreq ));
  always @(  posedge   pixel_generator__rgb_fifo__clk          or  negedge  pixel_generator__rgb_fifo__aclr )
         if (~ pixel_generator__rgb_fifo__aclr ) 
             pixel_generator__rgb_fifo__nword  <=0;
          else 
             if ( pixel_generator__rgb_fifo__sclr ) 
                 pixel_generator__rgb_fifo__nword  <=0;
              else 
                 begin 
                     if ( pixel_generator__rgb_fifo__wreq &! pixel_generator__rgb_fifo__rreq ) 
                         pixel_generator__rgb_fifo__nword  <= pixel_generator__rgb_fifo__nword +1;
                      else 
                         if ( pixel_generator__rgb_fifo__rreq &! pixel_generator__rgb_fifo__wreq ) 
                             pixel_generator__rgb_fifo__nword  <= pixel_generator__rgb_fifo__nword -1;
                 end
 
    assign pixel_generator__rgb_fifo__clk = pixel_generator__clk_i;
    assign pixel_generator__rgb_fifo__aclr = 1'b1;
    assign pixel_generator__rgb_fifo__sclr = pixel_generator__sclr;
    assign pixel_generator__rgb_fifo__wreq = pixel_generator__rgb_fifo_wreq;
    assign pixel_generator__rgb_fifo__rreq = pixel_generator__rgb_fifo_rreq;
    assign pixel_generator__rgb_fifo__d = pixel_generator__rgb_fifo_d;
    assign pixel_generator__line_fifo_d = pixel_generator__rgb_fifo__q;
    assign pixel_generator__rgb_fifo_nword = pixel_generator__rgb_fifo__nword;
    assign pixel_generator__rgb_fifo_empty = pixel_generator__rgb_fifo__empty;
     
  assign  pixel_generator__rgb_fifo_full = pixel_generator__rgb_fifo_nword [3]; 
  assign  pixel_generator__line_fifo_rreq = pixel_generator__gate & pixel_generator__pclk_ena ; 
  assign  pixel_generator__rgb_fifo_rreq =~ pixel_generator__line_fifo_full &~ pixel_generator__rgb_fifo_empty ; 
  assign  pixel_generator__line_fifo_wreq = pixel_generator__rgb_fifo_rreq ; 
    wire[7:0] pixel_generator__r = pixel_generator__line_fifo_q [23:16]; 
    wire[7:0] pixel_generator__g = pixel_generator__line_fifo_q [15:8]; 
    wire[7:0] pixel_generator__b = pixel_generator__line_fifo_q [7:0]; 
  always @( posedge  pixel_generator__pclk_i )
         if ( pixel_generator__pclk_ena )
             begin  
                 pixel_generator__r_o  <= pixel_generator__r ; 
                 pixel_generator__g_o  <= pixel_generator__g ; 
                 pixel_generator__b_o  <= pixel_generator__b ;
             end
 
    assign pixel_generator__clk_i = wb_clk_i;
    assign pixel_generator__ctrl_ven = ctrl_ven;
    assign pixel_generator__ctrl_HSyncL = ctrl_hsl;
    assign pixel_generator__Thsync = Thsync;
    assign pixel_generator__Thgdel = Thgdel;
    assign pixel_generator__Thgate = Thgate;
    assign pixel_generator__Thlen = Thlen;
    assign pixel_generator__ctrl_VSyncL = ctrl_vsl;
    assign pixel_generator__Tvsync = Tvsync;
    assign pixel_generator__Tvgdel = Tvgdel;
    assign pixel_generator__Tvgate = Tvgate;
    assign pixel_generator__Tvlen = Tvlen;
    assign pixel_generator__ctrl_CSyncL = ctrl_csl;
    assign pixel_generator__ctrl_BlankL = ctrl_bl;
    assign hint = pixel_generator__eoh;
    assign vint = pixel_generator__eov;
    assign pixel_generator__ctrl_dvi_odf = ctrl_dvi_odf;
    assign pixel_generator__ctrl_cd = ctrl_cd;
    assign pixel_generator__ctrl_pc = ctrl_pc;
    assign pixel_generator__fb_data_fifo_q = fb_data_fifo_q;
    assign pixel_generator__fb_data_fifo_empty = fb_data_fifo_empty;
    assign fb_data_fifo_rreq = pixel_generator__fb_data_fifo_rreq;
    assign pixel_generator__ImDoneFifoQ = ImDoneFifoQ;
    assign stat_acmp = pixel_generator__stat_acmp;
    assign cp_clut_req = pixel_generator__clut_req;
    assign cp_clut_adr = pixel_generator__clut_adr;
    assign pixel_generator__clut_q = cp_clut_q;
    assign pixel_generator__clut_ack = cp_clut_ack;
    assign pixel_generator__ctrl_cbsw = ctrl_cbsw;
    assign clut_swint = pixel_generator__clut_switch;
    assign pixel_generator__cursor_adr = cursor_adr;
    assign pixel_generator__cursor0_en = cursor0_en;
    assign pixel_generator__cursor0_res = cursor0_res;
    assign pixel_generator__cursor0_xy = cursor0_xy;
    assign cc0_adr_i = pixel_generator__cc0_adr_o;
    assign pixel_generator__cc0_dat_i = cc0_dat_o;
    assign pixel_generator__cursor1_en = cursor1_en;
    assign pixel_generator__cursor1_res = cursor1_res;
    assign pixel_generator__cursor1_xy = cursor1_xy;
    assign cc1_adr_i = pixel_generator__cc1_adr_o;
    assign pixel_generator__cc1_dat_i = cc1_dat_o;
    assign pixel_generator__line_fifo_full = line_fifo_full_wr;
    assign line_fifo_wreq = pixel_generator__line_fifo_wreq;
    assign line_fifo_d = pixel_generator__line_fifo_d;
    assign line_fifo_rreq = pixel_generator__line_fifo_rreq;
    assign pixel_generator__line_fifo_q = line_fifo_q;
    assign pixel_generator__pclk_i = clk_p_i;
    assign clk_p_o = pixel_generator__pclk_o;
    assign hsync_pad_o = pixel_generator__hsync_o;
    assign vsync_pad_o = pixel_generator__vsync_o;
    assign csync_pad_o = pixel_generator__csync_o;
    assign blank_pad_o = pixel_generator__blank_o;
    assign r_pad_o = pixel_generator__r_o;
    assign g_pad_o = pixel_generator__g_o;
    assign b_pad_o = pixel_generator__b_o;
    

	// hookup line-fifo
	wire ctrl_ven_not = ~ctrl_ven;
	    wire line_fifo__rclk;
    wire line_fifo__wclk;
    wire line_fifo__rclr;
    wire line_fifo__wclr;
    wire line_fifo__wreq;
    wire[24-1:0] line_fifo__d;
    wire line_fifo__rreq;
    wire[24-1:0] line_fifo__q;
    reg line_fifo__empty;
    reg line_fifo__full;

    reg line_fifo__rrst , line_fifo__wrst , line_fifo__srclr , line_fifo__ssrclr , line_fifo__swclr , line_fifo__sswclr ; reg[7-1:0] line_fifo__rptr , line_fifo__wptr , line_fifo__rptr_gray , line_fifo__wptr_gray ; function[7:1] line_fifo__bin2gray ;input[7:1] line_fifo__bin ;
        integer line_fifo__n ;
          begin for( line_fifo__n =1; line_fifo__n <7; line_fifo__n = line_fifo__n +1) 
                  line_fifo__bin2gray  [ line_fifo__n ]= line_fifo__bin [ line_fifo__n +1]^ line_fifo__bin [ line_fifo__n ]; 
              line_fifo__bin2gray  [7]= line_fifo__bin [7];
          end endfunction function[7:1] line_fifo__gray2bin ;input[7:1] line_fifo__gray ;
          begin  
              line_fifo__gray2bin  = line_fifo__bin2gray ( line_fifo__gray );
          end endfunction 
  always @( posedge  line_fifo__rclk )
         begin  
             line_fifo__swclr  <= line_fifo__wclr ; 
             line_fifo__sswclr  <= line_fifo__swclr ; 
             line_fifo__rrst  <= line_fifo__rclr | line_fifo__sswclr ;
         end
  always @( posedge  line_fifo__wclk )
         begin  
             line_fifo__srclr  <= line_fifo__rclr ; 
             line_fifo__ssrclr  <= line_fifo__srclr ; 
             line_fifo__wrst  <= line_fifo__wclr | line_fifo__ssrclr ;
         end
  always @( posedge  line_fifo__rclk )
         if ( line_fifo__rrst )
             begin  
                 line_fifo__rptr  <=0; 
                 line_fifo__rptr_gray  <=0;
             end 
          else 
             if ( line_fifo__rreq )
                 begin  
                     line_fifo__rptr  <= line_fifo__rptr +1'h1; 
                     line_fifo__rptr_gray  <= line_fifo__bin2gray ( line_fifo__rptr +1'h1);
                 end
  always @( posedge  line_fifo__wclk )
         if ( line_fifo__wrst )
             begin  
                 line_fifo__wptr  <=0; 
                 line_fifo__wptr_gray  <=0;
             end 
          else 
             if ( line_fifo__wreq )
                 begin  
                     line_fifo__wptr  <= line_fifo__wptr +1'h1; 
                     line_fifo__wptr_gray  <= line_fifo__bin2gray ( line_fifo__wptr +1'h1);
                 end
  reg[7-1:0] line_fifo__srptr_gray , line_fifo__ssrptr_gray ; reg[7-1:0] line_fifo__swptr_gray , line_fifo__sswptr_gray ; 
  always @( posedge  line_fifo__rclk )
         begin  
             line_fifo__swptr_gray  <= line_fifo__wptr_gray ; 
             line_fifo__sswptr_gray  <= line_fifo__swptr_gray ;
         end
  always @( posedge  line_fifo__wclk )
         begin  
             line_fifo__srptr_gray  <= line_fifo__rptr_gray ; 
             line_fifo__ssrptr_gray  <= line_fifo__srptr_gray ;
         end
  always @( posedge  line_fifo__rclk )
         if ( line_fifo__rrst ) 
             line_fifo__empty  <=1'b1;
          else 
             if ( line_fifo__rreq ) 
                 line_fifo__empty  <= line_fifo__bin2gray ( line_fifo__rptr +1'h1)== line_fifo__sswptr_gray ;
              else  
                 line_fifo__empty  <= line_fifo__empty &( line_fifo__rptr_gray == line_fifo__sswptr_gray );
  always @( posedge  line_fifo__wclk )
         if ( line_fifo__wrst ) 
             line_fifo__full  <=1'b0;
          else 
             if ( line_fifo__wreq ) 
                 line_fifo__full  <= line_fifo__bin2gray ( line_fifo__wptr +2'h2)== line_fifo__ssrptr_gray ;
              else  
                 line_fifo__full  <= line_fifo__full &( line_fifo__bin2gray ( line_fifo__wptr +2'h1)== line_fifo__ssrptr_gray );
    wire line_fifo__fifo_dc_mem__rclk;
    wire line_fifo__fifo_dc_mem__rrst;
    wire line_fifo__fifo_dc_mem__rce;
    wire line_fifo__fifo_dc_mem__oe;
    wire[7-1:0] line_fifo__fifo_dc_mem__raddr;
    wire[24-1:0] line_fifo__fifo_dc_mem__doo;
    wire line_fifo__fifo_dc_mem__wclk;
    wire line_fifo__fifo_dc_mem__wrst;
    wire line_fifo__fifo_dc_mem__wce;
    wire line_fifo__fifo_dc_mem__we;
    wire[7-1:0] line_fifo__fifo_dc_mem__waddr;
    wire[24-1:0] line_fifo__fifo_dc_mem__di;

    reg[24-1:0] line_fifo__fifo_dc_mem__mem [(1<<7)-1:0]; reg[7-1:0] line_fifo__fifo_dc_mem__ra ; 
  always @( posedge  line_fifo__fifo_dc_mem__rclk )
         if ( line_fifo__fifo_dc_mem__rce ) 
             line_fifo__fifo_dc_mem__ra  <= line_fifo__fifo_dc_mem__raddr ;
  assign  line_fifo__fifo_dc_mem__doo = line_fifo__fifo_dc_mem__mem [ line_fifo__fifo_dc_mem__ra ]; 
  always @( posedge  line_fifo__fifo_dc_mem__wclk )
         if ( line_fifo__fifo_dc_mem__we && line_fifo__fifo_dc_mem__wce ) 
             line_fifo__fifo_dc_mem__mem  [ line_fifo__fifo_dc_mem__waddr ]<= line_fifo__fifo_dc_mem__di ;

    assign line_fifo__fifo_dc_mem__rclk = line_fifo__rclk;
    assign line_fifo__fifo_dc_mem__rrst = 1'b0;
    assign line_fifo__fifo_dc_mem__rce = 1'b1;
    assign line_fifo__fifo_dc_mem__oe = 1'b1;
    assign line_fifo__fifo_dc_mem__raddr = line_fifo__rptr;
    assign line_fifo__q = line_fifo__fifo_dc_mem__doo;
    assign line_fifo__fifo_dc_mem__wclk = line_fifo__wclk;
    assign line_fifo__fifo_dc_mem__wrst = 1'b0;
    assign line_fifo__fifo_dc_mem__wce = 1'b1;
    assign line_fifo__fifo_dc_mem__we = line_fifo__wreq;
    assign line_fifo__fifo_dc_mem__waddr = line_fifo__wptr;
    assign line_fifo__fifo_dc_mem__di = line_fifo__d;
    
    assign line_fifo__rclk = clk_p_i;
    assign line_fifo__wclk = wb_clk_i;
    assign line_fifo__rclr = 1'b0;
    assign line_fifo__wclr = ctrl_ven_not;
    assign line_fifo__wreq = line_fifo_wreq;
    assign line_fifo__d = line_fifo_d;
    assign line_fifo__rreq = line_fifo_rreq;
    assign line_fifo_q = line_fifo__q;
    assign line_fifo_empty_rd = line_fifo__empty;
    assign line_fifo_full_wr = line_fifo__full;
    

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

    function pixel_generator__rgb_fifo__lsb;
	   input [4:1] q;
	   case (4)
	       2: pixel_generator__rgb_fifo__lsb = ~q[2];
	       3: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[3] ^ q[2]);
	       4: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[4] ^ q[3]);
	       5: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[5] ^ q[3]);
	       6: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[6] ^ q[5]);
	       7: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[7] ^ q[6]);
	       8: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[8] ^ q[6] ^ q[5] ^ q[4]);
	       9: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[9] ^ q[5]);
	      10: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[10] ^ q[7]);
	      11: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[11] ^ q[9]);
	      12: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[12] ^ q[6] ^ q[4] ^ q[1]);
	      13: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[13] ^ q[4] ^ q[3] ^ q[1]);
	      14: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[14] ^ q[5] ^ q[3] ^ q[1]);
	      15: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[15] ^ q[14]);
	      16: pixel_generator__rgb_fifo__lsb = &q[4-1:1] ^ ~(q[16] ^ q[15] ^ q[13] ^ q[4]);
	   endcase
	endfunction

    function wbm__data_fifo__lsb;
	   input [4:1] q;
	   case (4)
	       2: wbm__data_fifo__lsb = ~q[2];
	       3: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[3] ^ q[2]);
	       4: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[4] ^ q[3]);
	       5: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[5] ^ q[3]);
	       6: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[6] ^ q[5]);
	       7: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[7] ^ q[6]);
	       8: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[8] ^ q[6] ^ q[5] ^ q[4]);
	       9: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[9] ^ q[5]);
	      10: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[10] ^ q[7]);
	      11: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[11] ^ q[9]);
	      12: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[12] ^ q[6] ^ q[4] ^ q[1]);
	      13: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[13] ^ q[4] ^ q[3] ^ q[1]);
	      14: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[14] ^ q[5] ^ q[3] ^ q[1]);
	      15: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[15] ^ q[14]);
	      16: wbm__data_fifo__lsb = &q[4-1:1] ^ ~(q[16] ^ q[15] ^ q[13] ^ q[4]);
	   endcase
	endfunction

    function wbm__clut_sw_fifo__lsb;
	   input [3:1] q;
	   case (3)
	       2: wbm__clut_sw_fifo__lsb = ~q[2];
	       3: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[3] ^ q[2]);
	       4: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[4] ^ q[3]);
	       5: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[5] ^ q[3]);
	       6: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[6] ^ q[5]);
	       7: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[7] ^ q[6]);
	       8: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[8] ^ q[6] ^ q[5] ^ q[4]);
	       9: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[9] ^ q[5]);
	      10: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[10] ^ q[7]);
	      11: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[11] ^ q[9]);
	      12: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[12] ^ q[6] ^ q[4] ^ q[1]);
	      13: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[13] ^ q[4] ^ q[3] ^ q[1]);
	      14: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[14] ^ q[5] ^ q[3] ^ q[1]);
	      15: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[15] ^ q[14]);
	      16: wbm__clut_sw_fifo__lsb = &q[3-1:1] ^ ~(q[16] ^ q[15] ^ q[13] ^ q[4]);
	   endcase
	endfunction

endmodule