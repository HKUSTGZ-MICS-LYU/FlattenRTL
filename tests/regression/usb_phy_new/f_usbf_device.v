module usbf_device #(
parameter u_core__STATE_W=3,
parameter u_core__STATE_RX_IDLE=3'd0,
parameter u_core__STATE_RX_DATA=3'd1,
parameter u_core__STATE_RX_DATA_READY=3'd2,
parameter u_core__STATE_RX_DATA_IGNORE=3'd3,
parameter u_core__STATE_TX_DATA=3'd4,
parameter u_core__STATE_TX_DATA_COMPLETE=3'd5,
parameter u_core__STATE_TX_HANDSHAKE=3'd6,
parameter u_core__STATE_TX_CHIRP=3'd7,
parameter u_core__u_sie_tx__STATE_W=3,
parameter u_core__u_sie_tx__STATE_TX_IDLE=3'd0,
parameter u_core__u_sie_tx__STATE_TX_PID=3'd1,
parameter u_core__u_sie_tx__STATE_TX_DATA=3'd2,
parameter u_core__u_sie_tx__STATE_TX_CRC1=3'd3,
parameter u_core__u_sie_tx__STATE_TX_CRC2=3'd4,
parameter u_core__u_sie_tx__STATE_TX_DONE=3'd5,
parameter u_core__u_sie_tx__STATE_TX_CHIRP=3'd6,
parameter u_core__u_sie_rx__STATE_W=4,
parameter u_core__u_sie_rx__STATE_RX_IDLE=4'd0,
parameter u_core__u_sie_rx__STATE_RX_TOKEN2=4'd1,
parameter u_core__u_sie_rx__STATE_RX_TOKEN3=4'd2,
parameter u_core__u_sie_rx__STATE_RX_TOKEN_COMPLETE=4'd3,
parameter u_core__u_sie_rx__STATE_RX_SOF2=4'd4,
parameter u_core__u_sie_rx__STATE_RX_SOF3=4'd5,
parameter u_core__u_sie_rx__STATE_RX_DATA=4'd6,
parameter u_core__u_sie_rx__STATE_RX_DATA_COMPLETE=4'd7,
parameter u_core__u_sie_rx__STATE_RX_IGNORED=4'd8,
parameter u_fifo_rx_ep0__WIDTH=8,
parameter u_fifo_rx_ep0__DEPTH=8,
parameter u_fifo_rx_ep0__ADDR_W=3,
parameter u_fifo_rx_ep0__COUNT_W=ADDR_W+1,
parameter u_fifo_tx_ep0__WIDTH=8,
parameter u_fifo_tx_ep0__DEPTH=8,
parameter u_fifo_tx_ep0__ADDR_W=3,
parameter u_fifo_tx_ep0__COUNT_W=ADDR_W+1,
parameter u_fifo_rx_ep1__WIDTH=8,
parameter u_fifo_rx_ep1__DEPTH=64,
parameter u_fifo_rx_ep1__ADDR_W=6,
parameter u_fifo_rx_ep1__COUNT_W=ADDR_W+1,
parameter u_fifo_tx_ep1__WIDTH=8,
parameter u_fifo_tx_ep1__DEPTH=64,
parameter u_fifo_tx_ep1__ADDR_W=6,
parameter u_fifo_tx_ep1__COUNT_W=ADDR_W+1,
parameter u_fifo_rx_ep2__WIDTH=8,
parameter u_fifo_rx_ep2__DEPTH=64,
parameter u_fifo_rx_ep2__ADDR_W=6,
parameter u_fifo_rx_ep2__COUNT_W=ADDR_W+1,
parameter u_fifo_tx_ep2__WIDTH=8,
parameter u_fifo_tx_ep2__DEPTH=64,
parameter u_fifo_tx_ep2__ADDR_W=6,
parameter u_fifo_tx_ep2__COUNT_W=ADDR_W+1,
parameter u_fifo_rx_ep3__WIDTH=8,
parameter u_fifo_rx_ep3__DEPTH=64,
parameter u_fifo_rx_ep3__ADDR_W=6,
parameter u_fifo_rx_ep3__COUNT_W=ADDR_W+1,
parameter u_fifo_tx_ep3__WIDTH=8,
parameter u_fifo_tx_ep3__DEPTH=64,
parameter u_fifo_tx_ep3__ADDR_W=6,
parameter u_fifo_tx_ep3__COUNT_W=ADDR_W+1) (
  input clk_i,
  input rst_i,
  input cfg_awvalid_i,
  input [31:0] cfg_awaddr_i,
  input cfg_wvalid_i,
  input [31:0] cfg_wdata_i,
  input [3:0] cfg_wstrb_i,
  input cfg_bready_i,
  input cfg_arvalid_i,
  input [31:0] cfg_araddr_i,
  input cfg_rready_i,
  input [7:0] utmi_data_in_i,
  input utmi_txready_i,
  input utmi_rxvalid_i,
  input utmi_rxactive_i,
  input utmi_rxerror_i,
  input [1:0] utmi_linestate_i,
  output cfg_awready_o,
  output cfg_wready_o,
  output cfg_bvalid_o,
  output [1:0] cfg_bresp_o,
  output cfg_arready_o,
  output cfg_rvalid_o,
  output [31:0] cfg_rdata_o,
  output [1:0] cfg_rresp_o,
  output intr_o,
  output [7:0] utmi_data_out_o,
  output utmi_txvalid_o,
  output [1:0] utmi_op_mode_o,
  output [1:0] utmi_xcvrselect_o,
  output utmi_termselect_o,
  output utmi_dppulldown_o,
  output utmi_dmpulldown_o) ; 
   reg [31:0] wr_data_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          wr_data_q <=32'b0;
        else 
          wr_data_q <=cfg_wdata_i;
 
   wire read_en_w=cfg_arvalid_i&cfg_arready_o ;  
   wire write_en_w=cfg_awvalid_i&cfg_awready_o ;  
  assign cfg_arready_o=~cfg_rvalid_o; 
  assign cfg_awready_o=~cfg_bvalid_o&&~cfg_arvalid_i; 
  assign cfg_wready_o=cfg_awready_o; 
   reg usb_func_ctrl_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_func_ctrl_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h0))
             usb_func_ctrl_wr_q <=1'b1;
           else 
             usb_func_ctrl_wr_q <=1'b0;
 
   reg usb_func_ctrl_hs_chirp_en_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_func_ctrl_hs_chirp_en_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h0))
             usb_func_ctrl_hs_chirp_en_q <=cfg_wdata_i[8:8];
 
   wire usb_func_ctrl_hs_chirp_en_out_w=usb_func_ctrl_hs_chirp_en_q ;  
   reg usb_func_ctrl_phy_dmpulldown_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_func_ctrl_phy_dmpulldown_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h0))
             usb_func_ctrl_phy_dmpulldown_q <=cfg_wdata_i[7:7];
 
   wire usb_func_ctrl_phy_dmpulldown_out_w=usb_func_ctrl_phy_dmpulldown_q ;  
   reg usb_func_ctrl_phy_dppulldown_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_func_ctrl_phy_dppulldown_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h0))
             usb_func_ctrl_phy_dppulldown_q <=cfg_wdata_i[6:6];
 
   wire usb_func_ctrl_phy_dppulldown_out_w=usb_func_ctrl_phy_dppulldown_q ;  
   reg usb_func_ctrl_phy_termselect_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_func_ctrl_phy_termselect_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h0))
             usb_func_ctrl_phy_termselect_q <=cfg_wdata_i[5:5];
 
   wire usb_func_ctrl_phy_termselect_out_w=usb_func_ctrl_phy_termselect_q ;  
   reg [1:0] usb_func_ctrl_phy_xcvrselect_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_func_ctrl_phy_xcvrselect_q <=2'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h0))
             usb_func_ctrl_phy_xcvrselect_q <=cfg_wdata_i[4:3];
 
   wire [1:0] usb_func_ctrl_phy_xcvrselect_out_w=usb_func_ctrl_phy_xcvrselect_q ;  
   reg [1:0] usb_func_ctrl_phy_opmode_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_func_ctrl_phy_opmode_q <=2'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h0))
             usb_func_ctrl_phy_opmode_q <=cfg_wdata_i[2:1];
 
   wire [1:0] usb_func_ctrl_phy_opmode_out_w=usb_func_ctrl_phy_opmode_q ;  
   reg usb_func_ctrl_int_en_sof_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_func_ctrl_int_en_sof_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h0))
             usb_func_ctrl_int_en_sof_q <=cfg_wdata_i[0:0];
 
   wire usb_func_ctrl_int_en_sof_out_w=usb_func_ctrl_int_en_sof_q ;  
   reg usb_func_stat_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_func_stat_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h4))
             usb_func_stat_wr_q <=1'b1;
           else 
             usb_func_stat_wr_q <=1'b0;
 
   wire usb_func_stat_rst_out_w=wr_data_q[13:13] ;  
   wire [1:0] usb_func_stat_linestate_out_w=wr_data_q[12:11] ;  
   wire [10:0] usb_func_stat_frame_out_w=wr_data_q[10:0] ;  
   reg usb_func_addr_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_func_addr_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h8))
             usb_func_addr_wr_q <=1'b1;
           else 
             usb_func_addr_wr_q <=1'b0;
 
   reg [6:0] usb_func_addr_dev_addr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_func_addr_dev_addr_q <=7'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h8))
             usb_func_addr_dev_addr_q <=cfg_wdata_i[6:0];
 
   wire [6:0] usb_func_addr_dev_addr_out_w=usb_func_addr_dev_addr_q ;  
   reg usb_ep0_cfg_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_cfg_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'hc))
             usb_ep0_cfg_wr_q <=1'b1;
           else 
             usb_ep0_cfg_wr_q <=1'b0;
 
   reg usb_ep0_cfg_int_rx_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_cfg_int_rx_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'hc))
             usb_ep0_cfg_int_rx_q <=cfg_wdata_i[3:3];
 
   wire usb_ep0_cfg_int_rx_out_w=usb_ep0_cfg_int_rx_q ;  
   reg usb_ep0_cfg_int_tx_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_cfg_int_tx_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'hc))
             usb_ep0_cfg_int_tx_q <=cfg_wdata_i[2:2];
 
   wire usb_ep0_cfg_int_tx_out_w=usb_ep0_cfg_int_tx_q ;  
   reg usb_ep0_cfg_stall_ep_q ;  
   wire usb_ep0_cfg_stall_ep_ack_in_w ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_cfg_stall_ep_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'hc))
             usb_ep0_cfg_stall_ep_q <=cfg_wdata_i[1:1];
           else 
             if (usb_ep0_cfg_stall_ep_ack_in_w)
                usb_ep0_cfg_stall_ep_q <=1'b0;
 
   wire usb_ep0_cfg_stall_ep_out_w=usb_ep0_cfg_stall_ep_q ;  
   reg usb_ep0_cfg_iso_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_cfg_iso_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'hc))
             usb_ep0_cfg_iso_q <=cfg_wdata_i[0:0];
 
   wire usb_ep0_cfg_iso_out_w=usb_ep0_cfg_iso_q ;  
   reg usb_ep0_tx_ctrl_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_tx_ctrl_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h10))
             usb_ep0_tx_ctrl_wr_q <=1'b1;
           else 
             usb_ep0_tx_ctrl_wr_q <=1'b0;
 
   reg usb_ep0_tx_ctrl_tx_flush_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_tx_ctrl_tx_flush_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h10))
             usb_ep0_tx_ctrl_tx_flush_q <=cfg_wdata_i[17:17];
           else 
             usb_ep0_tx_ctrl_tx_flush_q <=1'd0;
 
   wire usb_ep0_tx_ctrl_tx_flush_out_w=usb_ep0_tx_ctrl_tx_flush_q ;  
   reg usb_ep0_tx_ctrl_tx_start_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_tx_ctrl_tx_start_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h10))
             usb_ep0_tx_ctrl_tx_start_q <=cfg_wdata_i[16:16];
           else 
             usb_ep0_tx_ctrl_tx_start_q <=1'd0;
 
   wire usb_ep0_tx_ctrl_tx_start_out_w=usb_ep0_tx_ctrl_tx_start_q ;  
   reg [10:0] usb_ep0_tx_ctrl_tx_len_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_tx_ctrl_tx_len_q <=11'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h10))
             usb_ep0_tx_ctrl_tx_len_q <=cfg_wdata_i[10:0];
 
   wire [10:0] usb_ep0_tx_ctrl_tx_len_out_w=usb_ep0_tx_ctrl_tx_len_q ;  
   reg usb_ep0_rx_ctrl_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_rx_ctrl_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h14))
             usb_ep0_rx_ctrl_wr_q <=1'b1;
           else 
             usb_ep0_rx_ctrl_wr_q <=1'b0;
 
   reg usb_ep0_rx_ctrl_rx_flush_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_rx_ctrl_rx_flush_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h14))
             usb_ep0_rx_ctrl_rx_flush_q <=cfg_wdata_i[1:1];
           else 
             usb_ep0_rx_ctrl_rx_flush_q <=1'd0;
 
   wire usb_ep0_rx_ctrl_rx_flush_out_w=usb_ep0_rx_ctrl_rx_flush_q ;  
   reg usb_ep0_rx_ctrl_rx_accept_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_rx_ctrl_rx_accept_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h14))
             usb_ep0_rx_ctrl_rx_accept_q <=cfg_wdata_i[0:0];
           else 
             usb_ep0_rx_ctrl_rx_accept_q <=1'd0;
 
   wire usb_ep0_rx_ctrl_rx_accept_out_w=usb_ep0_rx_ctrl_rx_accept_q ;  
   reg usb_ep0_sts_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_sts_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h18))
             usb_ep0_sts_wr_q <=1'b1;
           else 
             usb_ep0_sts_wr_q <=1'b0;
 
   reg usb_ep0_data_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep0_data_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h1c))
             usb_ep0_data_wr_q <=1'b1;
           else 
             usb_ep0_data_wr_q <=1'b0;
 
   wire [7:0] usb_ep0_data_data_out_w=wr_data_q[7:0] ;  
   reg usb_ep1_cfg_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_cfg_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h20))
             usb_ep1_cfg_wr_q <=1'b1;
           else 
             usb_ep1_cfg_wr_q <=1'b0;
 
   reg usb_ep1_cfg_int_rx_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_cfg_int_rx_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h20))
             usb_ep1_cfg_int_rx_q <=cfg_wdata_i[3:3];
 
   wire usb_ep1_cfg_int_rx_out_w=usb_ep1_cfg_int_rx_q ;  
   reg usb_ep1_cfg_int_tx_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_cfg_int_tx_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h20))
             usb_ep1_cfg_int_tx_q <=cfg_wdata_i[2:2];
 
   wire usb_ep1_cfg_int_tx_out_w=usb_ep1_cfg_int_tx_q ;  
   reg usb_ep1_cfg_stall_ep_q ;  
   wire usb_ep1_cfg_stall_ep_ack_in_w ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_cfg_stall_ep_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h20))
             usb_ep1_cfg_stall_ep_q <=cfg_wdata_i[1:1];
           else 
             if (usb_ep1_cfg_stall_ep_ack_in_w)
                usb_ep1_cfg_stall_ep_q <=1'b0;
 
   wire usb_ep1_cfg_stall_ep_out_w=usb_ep1_cfg_stall_ep_q ;  
   reg usb_ep1_cfg_iso_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_cfg_iso_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h20))
             usb_ep1_cfg_iso_q <=cfg_wdata_i[0:0];
 
   wire usb_ep1_cfg_iso_out_w=usb_ep1_cfg_iso_q ;  
   reg usb_ep1_tx_ctrl_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_tx_ctrl_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h24))
             usb_ep1_tx_ctrl_wr_q <=1'b1;
           else 
             usb_ep1_tx_ctrl_wr_q <=1'b0;
 
   reg usb_ep1_tx_ctrl_tx_flush_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_tx_ctrl_tx_flush_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h24))
             usb_ep1_tx_ctrl_tx_flush_q <=cfg_wdata_i[17:17];
           else 
             usb_ep1_tx_ctrl_tx_flush_q <=1'd0;
 
   wire usb_ep1_tx_ctrl_tx_flush_out_w=usb_ep1_tx_ctrl_tx_flush_q ;  
   reg usb_ep1_tx_ctrl_tx_start_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_tx_ctrl_tx_start_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h24))
             usb_ep1_tx_ctrl_tx_start_q <=cfg_wdata_i[16:16];
           else 
             usb_ep1_tx_ctrl_tx_start_q <=1'd0;
 
   wire usb_ep1_tx_ctrl_tx_start_out_w=usb_ep1_tx_ctrl_tx_start_q ;  
   reg [10:0] usb_ep1_tx_ctrl_tx_len_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_tx_ctrl_tx_len_q <=11'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h24))
             usb_ep1_tx_ctrl_tx_len_q <=cfg_wdata_i[10:0];
 
   wire [10:0] usb_ep1_tx_ctrl_tx_len_out_w=usb_ep1_tx_ctrl_tx_len_q ;  
   reg usb_ep1_rx_ctrl_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_rx_ctrl_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h28))
             usb_ep1_rx_ctrl_wr_q <=1'b1;
           else 
             usb_ep1_rx_ctrl_wr_q <=1'b0;
 
   reg usb_ep1_rx_ctrl_rx_flush_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_rx_ctrl_rx_flush_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h28))
             usb_ep1_rx_ctrl_rx_flush_q <=cfg_wdata_i[1:1];
           else 
             usb_ep1_rx_ctrl_rx_flush_q <=1'd0;
 
   wire usb_ep1_rx_ctrl_rx_flush_out_w=usb_ep1_rx_ctrl_rx_flush_q ;  
   reg usb_ep1_rx_ctrl_rx_accept_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_rx_ctrl_rx_accept_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h28))
             usb_ep1_rx_ctrl_rx_accept_q <=cfg_wdata_i[0:0];
           else 
             usb_ep1_rx_ctrl_rx_accept_q <=1'd0;
 
   wire usb_ep1_rx_ctrl_rx_accept_out_w=usb_ep1_rx_ctrl_rx_accept_q ;  
   reg usb_ep1_sts_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_sts_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h2c))
             usb_ep1_sts_wr_q <=1'b1;
           else 
             usb_ep1_sts_wr_q <=1'b0;
 
   reg usb_ep1_data_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep1_data_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h30))
             usb_ep1_data_wr_q <=1'b1;
           else 
             usb_ep1_data_wr_q <=1'b0;
 
   wire [7:0] usb_ep1_data_data_out_w=wr_data_q[7:0] ;  
   reg usb_ep2_cfg_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_cfg_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h34))
             usb_ep2_cfg_wr_q <=1'b1;
           else 
             usb_ep2_cfg_wr_q <=1'b0;
 
   reg usb_ep2_cfg_int_rx_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_cfg_int_rx_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h34))
             usb_ep2_cfg_int_rx_q <=cfg_wdata_i[3:3];
 
   wire usb_ep2_cfg_int_rx_out_w=usb_ep2_cfg_int_rx_q ;  
   reg usb_ep2_cfg_int_tx_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_cfg_int_tx_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h34))
             usb_ep2_cfg_int_tx_q <=cfg_wdata_i[2:2];
 
   wire usb_ep2_cfg_int_tx_out_w=usb_ep2_cfg_int_tx_q ;  
   reg usb_ep2_cfg_stall_ep_q ;  
   wire usb_ep2_cfg_stall_ep_ack_in_w ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_cfg_stall_ep_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h34))
             usb_ep2_cfg_stall_ep_q <=cfg_wdata_i[1:1];
           else 
             if (usb_ep2_cfg_stall_ep_ack_in_w)
                usb_ep2_cfg_stall_ep_q <=1'b0;
 
   wire usb_ep2_cfg_stall_ep_out_w=usb_ep2_cfg_stall_ep_q ;  
   reg usb_ep2_cfg_iso_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_cfg_iso_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h34))
             usb_ep2_cfg_iso_q <=cfg_wdata_i[0:0];
 
   wire usb_ep2_cfg_iso_out_w=usb_ep2_cfg_iso_q ;  
   reg usb_ep2_tx_ctrl_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_tx_ctrl_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h38))
             usb_ep2_tx_ctrl_wr_q <=1'b1;
           else 
             usb_ep2_tx_ctrl_wr_q <=1'b0;
 
   reg usb_ep2_tx_ctrl_tx_flush_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_tx_ctrl_tx_flush_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h38))
             usb_ep2_tx_ctrl_tx_flush_q <=cfg_wdata_i[17:17];
           else 
             usb_ep2_tx_ctrl_tx_flush_q <=1'd0;
 
   wire usb_ep2_tx_ctrl_tx_flush_out_w=usb_ep2_tx_ctrl_tx_flush_q ;  
   reg usb_ep2_tx_ctrl_tx_start_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_tx_ctrl_tx_start_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h38))
             usb_ep2_tx_ctrl_tx_start_q <=cfg_wdata_i[16:16];
           else 
             usb_ep2_tx_ctrl_tx_start_q <=1'd0;
 
   wire usb_ep2_tx_ctrl_tx_start_out_w=usb_ep2_tx_ctrl_tx_start_q ;  
   reg [10:0] usb_ep2_tx_ctrl_tx_len_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_tx_ctrl_tx_len_q <=11'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h38))
             usb_ep2_tx_ctrl_tx_len_q <=cfg_wdata_i[10:0];
 
   wire [10:0] usb_ep2_tx_ctrl_tx_len_out_w=usb_ep2_tx_ctrl_tx_len_q ;  
   reg usb_ep2_rx_ctrl_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_rx_ctrl_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h3c))
             usb_ep2_rx_ctrl_wr_q <=1'b1;
           else 
             usb_ep2_rx_ctrl_wr_q <=1'b0;
 
   reg usb_ep2_rx_ctrl_rx_flush_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_rx_ctrl_rx_flush_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h3c))
             usb_ep2_rx_ctrl_rx_flush_q <=cfg_wdata_i[1:1];
           else 
             usb_ep2_rx_ctrl_rx_flush_q <=1'd0;
 
   wire usb_ep2_rx_ctrl_rx_flush_out_w=usb_ep2_rx_ctrl_rx_flush_q ;  
   reg usb_ep2_rx_ctrl_rx_accept_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_rx_ctrl_rx_accept_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h3c))
             usb_ep2_rx_ctrl_rx_accept_q <=cfg_wdata_i[0:0];
           else 
             usb_ep2_rx_ctrl_rx_accept_q <=1'd0;
 
   wire usb_ep2_rx_ctrl_rx_accept_out_w=usb_ep2_rx_ctrl_rx_accept_q ;  
   reg usb_ep2_sts_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_sts_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h40))
             usb_ep2_sts_wr_q <=1'b1;
           else 
             usb_ep2_sts_wr_q <=1'b0;
 
   reg usb_ep2_data_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep2_data_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h44))
             usb_ep2_data_wr_q <=1'b1;
           else 
             usb_ep2_data_wr_q <=1'b0;
 
   wire [7:0] usb_ep2_data_data_out_w=wr_data_q[7:0] ;  
   reg usb_ep3_cfg_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_cfg_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h48))
             usb_ep3_cfg_wr_q <=1'b1;
           else 
             usb_ep3_cfg_wr_q <=1'b0;
 
   reg usb_ep3_cfg_int_rx_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_cfg_int_rx_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h48))
             usb_ep3_cfg_int_rx_q <=cfg_wdata_i[3:3];
 
   wire usb_ep3_cfg_int_rx_out_w=usb_ep3_cfg_int_rx_q ;  
   reg usb_ep3_cfg_int_tx_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_cfg_int_tx_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h48))
             usb_ep3_cfg_int_tx_q <=cfg_wdata_i[2:2];
 
   wire usb_ep3_cfg_int_tx_out_w=usb_ep3_cfg_int_tx_q ;  
   reg usb_ep3_cfg_stall_ep_q ;  
   wire usb_ep3_cfg_stall_ep_ack_in_w ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_cfg_stall_ep_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h48))
             usb_ep3_cfg_stall_ep_q <=cfg_wdata_i[1:1];
           else 
             if (usb_ep3_cfg_stall_ep_ack_in_w)
                usb_ep3_cfg_stall_ep_q <=1'b0;
 
   wire usb_ep3_cfg_stall_ep_out_w=usb_ep3_cfg_stall_ep_q ;  
   reg usb_ep3_cfg_iso_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_cfg_iso_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h48))
             usb_ep3_cfg_iso_q <=cfg_wdata_i[0:0];
 
   wire usb_ep3_cfg_iso_out_w=usb_ep3_cfg_iso_q ;  
   reg usb_ep3_tx_ctrl_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_tx_ctrl_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h4c))
             usb_ep3_tx_ctrl_wr_q <=1'b1;
           else 
             usb_ep3_tx_ctrl_wr_q <=1'b0;
 
   reg usb_ep3_tx_ctrl_tx_flush_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_tx_ctrl_tx_flush_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h4c))
             usb_ep3_tx_ctrl_tx_flush_q <=cfg_wdata_i[17:17];
           else 
             usb_ep3_tx_ctrl_tx_flush_q <=1'd0;
 
   wire usb_ep3_tx_ctrl_tx_flush_out_w=usb_ep3_tx_ctrl_tx_flush_q ;  
   reg usb_ep3_tx_ctrl_tx_start_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_tx_ctrl_tx_start_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h4c))
             usb_ep3_tx_ctrl_tx_start_q <=cfg_wdata_i[16:16];
           else 
             usb_ep3_tx_ctrl_tx_start_q <=1'd0;
 
   wire usb_ep3_tx_ctrl_tx_start_out_w=usb_ep3_tx_ctrl_tx_start_q ;  
   reg [10:0] usb_ep3_tx_ctrl_tx_len_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_tx_ctrl_tx_len_q <=11'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h4c))
             usb_ep3_tx_ctrl_tx_len_q <=cfg_wdata_i[10:0];
 
   wire [10:0] usb_ep3_tx_ctrl_tx_len_out_w=usb_ep3_tx_ctrl_tx_len_q ;  
   reg usb_ep3_rx_ctrl_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_rx_ctrl_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h50))
             usb_ep3_rx_ctrl_wr_q <=1'b1;
           else 
             usb_ep3_rx_ctrl_wr_q <=1'b0;
 
   reg usb_ep3_rx_ctrl_rx_flush_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_rx_ctrl_rx_flush_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h50))
             usb_ep3_rx_ctrl_rx_flush_q <=cfg_wdata_i[1:1];
           else 
             usb_ep3_rx_ctrl_rx_flush_q <=1'd0;
 
   wire usb_ep3_rx_ctrl_rx_flush_out_w=usb_ep3_rx_ctrl_rx_flush_q ;  
   reg usb_ep3_rx_ctrl_rx_accept_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_rx_ctrl_rx_accept_q <=1'd0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h50))
             usb_ep3_rx_ctrl_rx_accept_q <=cfg_wdata_i[0:0];
           else 
             usb_ep3_rx_ctrl_rx_accept_q <=1'd0;
 
   wire usb_ep3_rx_ctrl_rx_accept_out_w=usb_ep3_rx_ctrl_rx_accept_q ;  
   reg usb_ep3_sts_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_sts_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h54))
             usb_ep3_sts_wr_q <=1'b1;
           else 
             usb_ep3_sts_wr_q <=1'b0;
 
   reg usb_ep3_data_wr_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          usb_ep3_data_wr_q <=1'b0;
        else 
          if (write_en_w&&(cfg_awaddr_i[7:0]==8'h58))
             usb_ep3_data_wr_q <=1'b1;
           else 
             usb_ep3_data_wr_q <=1'b0;
 
   wire [7:0] usb_ep3_data_data_out_w=wr_data_q[7:0] ;  
   wire usb_func_stat_rst_in_w ;  
   wire [1:0] usb_func_stat_linestate_in_w ;  
   wire [10:0] usb_func_stat_frame_in_w ;  
   wire usb_ep0_sts_tx_err_in_w ;  
   wire usb_ep0_sts_tx_busy_in_w ;  
   wire usb_ep0_sts_rx_err_in_w ;  
   wire usb_ep0_sts_rx_setup_in_w ;  
   wire usb_ep0_sts_rx_ready_in_w ;  
   wire [10:0] usb_ep0_sts_rx_count_in_w ;  
   wire [7:0] usb_ep0_data_data_in_w ;  
   wire usb_ep1_sts_tx_err_in_w ;  
   wire usb_ep1_sts_tx_busy_in_w ;  
   wire usb_ep1_sts_rx_err_in_w ;  
   wire usb_ep1_sts_rx_setup_in_w ;  
   wire usb_ep1_sts_rx_ready_in_w ;  
   wire [10:0] usb_ep1_sts_rx_count_in_w ;  
   wire [7:0] usb_ep1_data_data_in_w ;  
   wire usb_ep2_sts_tx_err_in_w ;  
   wire usb_ep2_sts_tx_busy_in_w ;  
   wire usb_ep2_sts_rx_err_in_w ;  
   wire usb_ep2_sts_rx_setup_in_w ;  
   wire usb_ep2_sts_rx_ready_in_w ;  
   wire [10:0] usb_ep2_sts_rx_count_in_w ;  
   wire [7:0] usb_ep2_data_data_in_w ;  
   wire usb_ep3_sts_tx_err_in_w ;  
   wire usb_ep3_sts_tx_busy_in_w ;  
   wire usb_ep3_sts_rx_err_in_w ;  
   wire usb_ep3_sts_rx_setup_in_w ;  
   wire usb_ep3_sts_rx_ready_in_w ;  
   wire [10:0] usb_ep3_sts_rx_count_in_w ;  
   wire [7:0] usb_ep3_data_data_in_w ;  
   reg [31:0] data_r ;  
  always @*
       begin 
         data_r =32'b0;
         case (cfg_araddr_i[7:0])
          8 'h0:
             begin 
               data_r [8:8]=usb_func_ctrl_hs_chirp_en_q;
               data_r [7:7]=usb_func_ctrl_phy_dmpulldown_q;
               data_r [6:6]=usb_func_ctrl_phy_dppulldown_q;
               data_r [5:5]=usb_func_ctrl_phy_termselect_q;
               data_r [4:3]=usb_func_ctrl_phy_xcvrselect_q;
               data_r [2:1]=usb_func_ctrl_phy_opmode_q;
               data_r [0:0]=usb_func_ctrl_int_en_sof_q;
             end 
          8 'h4:
             begin 
               data_r [13:13]=usb_func_stat_rst_in_w;
               data_r [12:11]=usb_func_stat_linestate_in_w;
               data_r [10:0]=usb_func_stat_frame_in_w;
             end 
          8 'h8:
             begin 
               data_r [6:0]=usb_func_addr_dev_addr_q;
             end 
          8 'hc:
             begin 
               data_r [3:3]=usb_ep0_cfg_int_rx_q;
               data_r [2:2]=usb_ep0_cfg_int_tx_q;
               data_r [0:0]=usb_ep0_cfg_iso_q;
             end 
          8 'h10:
             begin 
               data_r [10:0]=usb_ep0_tx_ctrl_tx_len_q;
             end 
          8 'h18:
             begin 
               data_r [20:20]=usb_ep0_sts_tx_err_in_w;
               data_r [19:19]=usb_ep0_sts_tx_busy_in_w;
               data_r [18:18]=usb_ep0_sts_rx_err_in_w;
               data_r [17:17]=usb_ep0_sts_rx_setup_in_w;
               data_r [16:16]=usb_ep0_sts_rx_ready_in_w;
               data_r [10:0]=usb_ep0_sts_rx_count_in_w;
             end 
          8 'h1c:
             begin 
               data_r [7:0]=usb_ep0_data_data_in_w;
             end 
          8 'h20:
             begin 
               data_r [3:3]=usb_ep1_cfg_int_rx_q;
               data_r [2:2]=usb_ep1_cfg_int_tx_q;
               data_r [0:0]=usb_ep1_cfg_iso_q;
             end 
          8 'h24:
             begin 
               data_r [10:0]=usb_ep1_tx_ctrl_tx_len_q;
             end 
          8 'h2c:
             begin 
               data_r [20:20]=usb_ep1_sts_tx_err_in_w;
               data_r [19:19]=usb_ep1_sts_tx_busy_in_w;
               data_r [18:18]=usb_ep1_sts_rx_err_in_w;
               data_r [17:17]=usb_ep1_sts_rx_setup_in_w;
               data_r [16:16]=usb_ep1_sts_rx_ready_in_w;
               data_r [10:0]=usb_ep1_sts_rx_count_in_w;
             end 
          8 'h30:
             begin 
               data_r [7:0]=usb_ep1_data_data_in_w;
             end 
          8 'h34:
             begin 
               data_r [3:3]=usb_ep2_cfg_int_rx_q;
               data_r [2:2]=usb_ep2_cfg_int_tx_q;
               data_r [0:0]=usb_ep2_cfg_iso_q;
             end 
          8 'h38:
             begin 
               data_r [10:0]=usb_ep2_tx_ctrl_tx_len_q;
             end 
          8 'h40:
             begin 
               data_r [20:20]=usb_ep2_sts_tx_err_in_w;
               data_r [19:19]=usb_ep2_sts_tx_busy_in_w;
               data_r [18:18]=usb_ep2_sts_rx_err_in_w;
               data_r [17:17]=usb_ep2_sts_rx_setup_in_w;
               data_r [16:16]=usb_ep2_sts_rx_ready_in_w;
               data_r [10:0]=usb_ep2_sts_rx_count_in_w;
             end 
          8 'h44:
             begin 
               data_r [7:0]=usb_ep2_data_data_in_w;
             end 
          8 'h48:
             begin 
               data_r [3:3]=usb_ep3_cfg_int_rx_q;
               data_r [2:2]=usb_ep3_cfg_int_tx_q;
               data_r [0:0]=usb_ep3_cfg_iso_q;
             end 
          8 'h4c:
             begin 
               data_r [10:0]=usb_ep3_tx_ctrl_tx_len_q;
             end 
          8 'h54:
             begin 
               data_r [20:20]=usb_ep3_sts_tx_err_in_w;
               data_r [19:19]=usb_ep3_sts_tx_busy_in_w;
               data_r [18:18]=usb_ep3_sts_rx_err_in_w;
               data_r [17:17]=usb_ep3_sts_rx_setup_in_w;
               data_r [16:16]=usb_ep3_sts_rx_ready_in_w;
               data_r [10:0]=usb_ep3_sts_rx_count_in_w;
             end 
          8 'h58:
             begin 
               data_r [7:0]=usb_ep3_data_data_in_w;
             end 
          default :
             data_r =32'b0;
         endcase 
       end
  
   reg rvalid_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          rvalid_q <=1'b0;
        else 
          if (read_en_w)
             rvalid_q <=1'b1;
           else 
             if (cfg_rready_i)
                rvalid_q <=1'b0;
 
  assign cfg_rvalid_o=rvalid_q; 
   reg [31:0] rd_data_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          rd_data_q <=32'b0;
        else 
          if (!cfg_rvalid_o||cfg_rready_i)
             rd_data_q <=data_r;
 
  assign cfg_rdata_o=rd_data_q; 
  assign cfg_rresp_o=2'b0; 
   reg bvalid_q ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i)
          bvalid_q <=1'b0;
        else 
          if (write_en_w)
             bvalid_q <=1'b1;
           else 
             if (cfg_bready_i)
                bvalid_q <=1'b0;
 
  assign cfg_bvalid_o=bvalid_q; 
  assign cfg_bresp_o=2'b0; 
   wire usb_ep0_data_rd_req_w=read_en_w&(cfg_araddr_i[7:0]==8'h1c) ;  
   wire usb_ep1_data_rd_req_w=read_en_w&(cfg_araddr_i[7:0]==8'h30) ;  
   wire usb_ep2_data_rd_req_w=read_en_w&(cfg_araddr_i[7:0]==8'h44) ;  
   wire usb_ep3_data_rd_req_w=read_en_w&(cfg_araddr_i[7:0]==8'h58) ;  
   wire usb_func_stat_wr_req_w=usb_func_stat_wr_q ;  
   wire usb_ep0_data_wr_req_w=usb_ep0_data_wr_q ;  
   wire usb_ep1_data_wr_req_w=usb_ep1_data_wr_q ;  
   wire usb_ep2_data_wr_req_w=usb_ep2_data_wr_q ;  
   wire usb_ep3_data_wr_req_w=usb_ep3_data_wr_q ;  
   wire stat_rst_w ;  
   wire [10:0] stat_frame_w ;  
   wire stat_rst_clr_w=usb_func_stat_rst_out_w ;  
   wire stat_wr_req_w=usb_func_stat_wr_req_w ;  
   wire usb_ep0_tx_rd_w ;  
   wire [7:0] usb_ep0_tx_data_w ;  
   wire usb_ep0_tx_empty_w ;  
   wire usb_ep0_rx_wr_w ;  
   wire [7:0] usb_ep0_rx_data_w ;  
   wire usb_ep0_rx_full_w ;  
   wire usb_ep1_tx_rd_w ;  
   wire [7:0] usb_ep1_tx_data_w ;  
   wire usb_ep1_tx_empty_w ;  
   wire usb_ep1_rx_wr_w ;  
   wire [7:0] usb_ep1_rx_data_w ;  
   wire usb_ep1_rx_full_w ;  
   wire usb_ep2_tx_rd_w ;  
   wire [7:0] usb_ep2_tx_data_w ;  
   wire usb_ep2_tx_empty_w ;  
   wire usb_ep2_rx_wr_w ;  
   wire [7:0] usb_ep2_rx_data_w ;  
   wire usb_ep2_rx_full_w ;  
   wire usb_ep3_tx_rd_w ;  
   wire [7:0] usb_ep3_tx_data_w ;  
   wire usb_ep3_tx_empty_w ;  
   wire usb_ep3_rx_wr_w ;  
   wire [7:0] usb_ep3_rx_data_w ;  
   wire usb_ep3_rx_full_w ;  
   wire rx_strb_w ;  
   wire [7:0] rx_data_w ;  
   wire rx_last_w ;  
   wire rx_crc_err_w ;  
   wire ep0_rx_space_w ;  
   wire ep0_rx_valid_w ;  
   wire ep0_rx_setup_w ;  
   wire ep0_tx_ready_w ;  
   wire ep0_tx_data_valid_w ;  
   wire ep0_tx_data_strb_w ;  
   wire [7:0] ep0_tx_data_w ;  
   wire ep0_tx_data_last_w ;  
   wire ep0_tx_data_accept_w ;  
   wire ep1_rx_space_w ;  
   wire ep1_rx_valid_w ;  
   wire ep1_rx_setup_w ;  
   wire ep1_tx_ready_w ;  
   wire ep1_tx_data_valid_w ;  
   wire ep1_tx_data_strb_w ;  
   wire [7:0] ep1_tx_data_w ;  
   wire ep1_tx_data_last_w ;  
   wire ep1_tx_data_accept_w ;  
   wire ep2_rx_space_w ;  
   wire ep2_rx_valid_w ;  
   wire ep2_rx_setup_w ;  
   wire ep2_tx_ready_w ;  
   wire ep2_tx_data_valid_w ;  
   wire ep2_tx_data_strb_w ;  
   wire [7:0] ep2_tx_data_w ;  
   wire ep2_tx_data_last_w ;  
   wire ep2_tx_data_accept_w ;  
   wire ep3_rx_space_w ;  
   wire ep3_rx_valid_w ;  
   wire ep3_rx_setup_w ;  
   wire ep3_tx_ready_w ;  
   wire ep3_tx_data_valid_w ;  
   wire ep3_tx_data_strb_w ;  
   wire [7:0] ep3_tx_data_w ;  
   wire ep3_tx_data_last_w ;  
   wire ep3_tx_data_accept_w ;  
  assign utmi_dmpulldown_o=usb_func_ctrl_phy_dmpulldown_out_w; 
  assign utmi_dppulldown_o=usb_func_ctrl_phy_dppulldown_out_w; 
  assign utmi_termselect_o=usb_func_ctrl_phy_termselect_out_w; 
  assign utmi_xcvrselect_o=usb_func_ctrl_phy_xcvrselect_out_w; 
  assign utmi_op_mode_o=usb_func_ctrl_phy_opmode_out_w; 
  assign usb_func_stat_rst_in_w=stat_rst_w; 
  assign usb_func_stat_linestate_in_w=utmi_linestate_i; 
  assign usb_func_stat_frame_in_w=stat_frame_w; 
  
wire  u_core__clk_i;
wire  u_core__rst_i;
wire [7:0] u_core__utmi_data_i;
wire  u_core__utmi_txready_i;
wire  u_core__utmi_rxvalid_i;
wire  u_core__utmi_rxactive_i;
wire  u_core__utmi_rxerror_i;
wire [1:0] u_core__utmi_linestate_i;
wire  u_core__ep0_stall_i;
wire  u_core__ep0_iso_i;
wire  u_core__ep0_cfg_int_rx_i;
wire  u_core__ep0_cfg_int_tx_i;
wire  u_core__ep0_rx_space_i;
wire  u_core__ep0_tx_ready_i;
wire  u_core__ep0_tx_data_valid_i;
wire  u_core__ep0_tx_data_strb_i;
wire [7:0] u_core__ep0_tx_data_i;
wire  u_core__ep0_tx_data_last_i;
wire  u_core__ep1_stall_i;
wire  u_core__ep1_iso_i;
wire  u_core__ep1_cfg_int_rx_i;
wire  u_core__ep1_cfg_int_tx_i;
wire  u_core__ep1_rx_space_i;
wire  u_core__ep1_tx_ready_i;
wire  u_core__ep1_tx_data_valid_i;
wire  u_core__ep1_tx_data_strb_i;
wire [7:0] u_core__ep1_tx_data_i;
wire  u_core__ep1_tx_data_last_i;
wire  u_core__ep2_stall_i;
wire  u_core__ep2_iso_i;
wire  u_core__ep2_cfg_int_rx_i;
wire  u_core__ep2_cfg_int_tx_i;
wire  u_core__ep2_rx_space_i;
wire  u_core__ep2_tx_ready_i;
wire  u_core__ep2_tx_data_valid_i;
wire  u_core__ep2_tx_data_strb_i;
wire [7:0] u_core__ep2_tx_data_i;
wire  u_core__ep2_tx_data_last_i;
wire  u_core__ep3_stall_i;
wire  u_core__ep3_iso_i;
wire  u_core__ep3_cfg_int_rx_i;
wire  u_core__ep3_cfg_int_tx_i;
wire  u_core__ep3_rx_space_i;
wire  u_core__ep3_tx_ready_i;
wire  u_core__ep3_tx_data_valid_i;
wire  u_core__ep3_tx_data_strb_i;
wire [7:0] u_core__ep3_tx_data_i;
wire  u_core__ep3_tx_data_last_i;
wire  u_core__reg_chirp_en_i;
wire  u_core__reg_int_en_sof_i;
wire  u_core__reg_sts_rst_clr_i;
wire [6:0] u_core__reg_dev_addr_i;
wire  u_core__intr_o;
wire [7:0] u_core__utmi_data_o;
wire  u_core__utmi_txvalid_o;
wire  u_core__rx_strb_o;
wire [7:0] u_core__rx_data_o;
wire  u_core__rx_last_o;
wire  u_core__rx_crc_err_o;
wire  u_core__ep0_rx_setup_o;
wire  u_core__ep0_rx_valid_o;
wire  u_core__ep0_tx_data_accept_o;
wire  u_core__ep1_rx_setup_o;
wire  u_core__ep1_rx_valid_o;
wire  u_core__ep1_tx_data_accept_o;
wire  u_core__ep2_rx_setup_o;
wire  u_core__ep2_rx_valid_o;
wire  u_core__ep2_tx_data_accept_o;
wire  u_core__ep3_rx_setup_o;
wire  u_core__ep3_rx_valid_o;
wire  u_core__ep3_tx_data_accept_o;
wire  u_core__reg_sts_rst_o;
wire [10:0] u_core__reg_sts_frame_num_o;
 localparam  u_core__STATE_W  =3; localparam  u_core__STATE_RX_IDLE  =3'd0; localparam  u_core__STATE_RX_DATA  =3'd1; localparam  u_core__STATE_RX_DATA_READY  =3'd2; localparam  u_core__STATE_RX_DATA_IGNORE  =3'd3; localparam  u_core__STATE_TX_DATA  =3'd4; localparam  u_core__STATE_TX_DATA_COMPLETE  =3'd5; localparam  u_core__STATE_TX_HANDSHAKE  =3'd6; localparam  u_core__STATE_TX_CHIRP  =3'd7; 
   reg[  u_core__STATE_W  -1:0]  u_core__state_q  ; 
   reg[15-1:0]  u_core__se0_cnt_q  ; 
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__se0_cnt_q   <=15'b0;
        else 
          if (  u_core__utmi_linestate_i  ==2'b0)
             begin 
               if (!  u_core__se0_cnt_q  [15-1]) 
                   u_core__se0_cnt_q   <=  u_core__se0_cnt_q  +15'd1;
             end 
           else  
              u_core__se0_cnt_q   <=15'b0;
 
   wire  u_core__usb_rst_w  =  u_core__se0_cnt_q  [15-1]; 
   wire[11-1:0]  u_core__frame_num_w  ; 
   wire  u_core__frame_valid_w  ; 
   wire[7-1:0]  u_core__token_dev_w  ; 
   wire[4-1:0]  u_core__token_ep_w  ; 
   wire[8-1:0]  u_core__token_pid_w  ; 
   wire  u_core__token_valid_w  ; 
   wire  u_core__rx_data_valid_w  ; 
   wire  u_core__rx_data_complete_w  ; 
   wire  u_core__rx_handshake_w  ; 
   reg  u_core__tx_data_valid_r  ; 
   reg  u_core__tx_data_strb_r  ; 
   reg[7:0]  u_core__tx_data_r  ; 
   reg  u_core__tx_data_last_r  ; 
   wire  u_core__tx_data_accept_w  ; 
   reg  u_core__tx_valid_q  ; 
   reg[7:0]  u_core__tx_pid_q  ; 
   wire  u_core__tx_accept_w  ; 
   reg  u_core__rx_space_q  ; 
   reg  u_core__rx_space_r  ; 
   reg  u_core__tx_ready_r  ; 
   reg  u_core__ep_data_bit_r  ; 
   reg  u_core__ep_stall_r  ; 
   reg  u_core__ep_iso_r  ; 
   reg  u_core__rx_enable_q  ; 
   reg  u_core__rx_setup_q  ; 
   reg  u_core__ep0_data_bit_q  ; 
   reg  u_core__ep1_data_bit_q  ; 
   reg  u_core__ep2_data_bit_q  ; 
   reg  u_core__ep3_data_bit_q  ; 
   wire  u_core__status_stage_w  ; 
   reg[7-1:0]  u_core__current_addr_q  ;  
  
wire  u_core__u_sie_tx__clk_i;
wire  u_core__u_sie_tx__rst_i;
wire  u_core__u_sie_tx__enable_i;
wire  u_core__u_sie_tx__chirp_i;
wire  u_core__u_sie_tx__utmi_txready_i;
wire  u_core__u_sie_tx__tx_valid_i;
wire [7:0] u_core__u_sie_tx__tx_pid_i;
wire  u_core__u_sie_tx__data_valid_i;
wire  u_core__u_sie_tx__data_strb_i;
wire [7:0] u_core__u_sie_tx__data_i;
wire  u_core__u_sie_tx__data_last_i;
wire [7:0] u_core__u_sie_tx__utmi_data_o;
wire  u_core__u_sie_tx__utmi_txvalid_o;
wire  u_core__u_sie_tx__tx_accept_o;
wire  u_core__u_sie_tx__data_accept_o;
 localparam  u_core__u_sie_tx__STATE_W  =3; localparam  u_core__u_sie_tx__STATE_TX_IDLE  =3'd0; localparam  u_core__u_sie_tx__STATE_TX_PID  =3'd1; localparam  u_core__u_sie_tx__STATE_TX_DATA  =3'd2; localparam  u_core__u_sie_tx__STATE_TX_CRC1  =3'd3; localparam  u_core__u_sie_tx__STATE_TX_CRC2  =3'd4; localparam  u_core__u_sie_tx__STATE_TX_DONE  =3'd5; localparam  u_core__u_sie_tx__STATE_TX_CHIRP  =3'd6; 
   reg[  u_core__u_sie_tx__STATE_W  -1:0]  u_core__u_sie_tx__state_q  ; 
   reg[  u_core__u_sie_tx__STATE_W  -1:0]  u_core__u_sie_tx__next_state_r  ; 
   reg  u_core__u_sie_tx__last_q  ; 
   reg  u_core__u_sie_tx__data_pid_q  ; 
   reg  u_core__u_sie_tx__data_zlp_q  ; 
  always @(  posedge    u_core__u_sie_tx__clk_i          or  posedge   u_core__u_sie_tx__rst_i  )
       if (  u_core__u_sie_tx__rst_i  )
          begin  
             u_core__u_sie_tx__data_pid_q   <=1'b0; 
             u_core__u_sie_tx__data_zlp_q   <=1'b0;
          end 
        else 
          if (!  u_core__u_sie_tx__enable_i  )
             begin  
                u_core__u_sie_tx__data_pid_q   <=1'b0; 
                u_core__u_sie_tx__data_zlp_q   <=1'b0;
             end 
           else 
             if (  u_core__u_sie_tx__tx_valid_i  &&  u_core__u_sie_tx__tx_accept_o  )
                begin 
                  case (  u_core__u_sie_tx__tx_pid_i  )
                   8 'h0F,8'h87,8'hC3,8'h4B:
                      begin  
                         u_core__u_sie_tx__data_pid_q   <=1'b1; 
                         u_core__u_sie_tx__data_zlp_q   <=  u_core__u_sie_tx__data_valid_i  &&(  u_core__u_sie_tx__data_strb_i  ==1'b0)&&  u_core__u_sie_tx__data_last_i  ;
                      end 
                   default :
                      begin  
                         u_core__u_sie_tx__data_pid_q   <=1'b0; 
                         u_core__u_sie_tx__data_zlp_q   <=1'b0;
                      end 
                  endcase 
                end 
              else 
                if (  u_core__u_sie_tx__next_state_r  ==  u_core__u_sie_tx__STATE_TX_CRC1  )
                   begin  
                      u_core__u_sie_tx__data_pid_q   <=1'b0; 
                      u_core__u_sie_tx__data_zlp_q   <=1'b0;
                   end
  
  assign   u_core__u_sie_tx__tx_accept_o  =(  u_core__u_sie_tx__state_q  ==  u_core__u_sie_tx__STATE_TX_IDLE  ); 
  always @*
       begin  
          u_core__u_sie_tx__next_state_r   =  u_core__u_sie_tx__state_q  ;
         case (  u_core__u_sie_tx__state_q  ) 
           u_core__u_sie_tx__STATE_TX_IDLE   :
             begin 
               if (  u_core__u_sie_tx__chirp_i  ) 
                   u_core__u_sie_tx__next_state_r   =  u_core__u_sie_tx__STATE_TX_CHIRP  ;
                else 
                  if (  u_core__u_sie_tx__tx_valid_i  ) 
                      u_core__u_sie_tx__next_state_r   =  u_core__u_sie_tx__STATE_TX_PID  ;
             end  
           u_core__u_sie_tx__STATE_TX_PID   :
             begin 
               if (  u_core__u_sie_tx__utmi_txready_i  )
                  begin 
                    if (  u_core__u_sie_tx__data_zlp_q  ) 
                        u_core__u_sie_tx__next_state_r   =  u_core__u_sie_tx__STATE_TX_CRC1  ;
                     else 
                       if (  u_core__u_sie_tx__data_pid_q  ) 
                           u_core__u_sie_tx__next_state_r   =  u_core__u_sie_tx__STATE_TX_DATA  ;
                        else  
                           u_core__u_sie_tx__next_state_r   =  u_core__u_sie_tx__STATE_TX_DONE  ;
                  end 
             end  
           u_core__u_sie_tx__STATE_TX_DATA   :
             begin 
               if (  u_core__u_sie_tx__utmi_txready_i  )
                  begin 
                    if (  u_core__u_sie_tx__data_last_i  ) 
                        u_core__u_sie_tx__next_state_r   =  u_core__u_sie_tx__STATE_TX_CRC1  ;
                  end 
             end  
           u_core__u_sie_tx__STATE_TX_CRC1   :
             begin 
               if (  u_core__u_sie_tx__utmi_txready_i  ) 
                   u_core__u_sie_tx__next_state_r   =  u_core__u_sie_tx__STATE_TX_CRC2  ;
             end  
           u_core__u_sie_tx__STATE_TX_CRC2   :
             begin 
               if (  u_core__u_sie_tx__utmi_txready_i  ) 
                   u_core__u_sie_tx__next_state_r   =  u_core__u_sie_tx__STATE_TX_DONE  ;
             end  
           u_core__u_sie_tx__STATE_TX_DONE   :
             begin 
               if (!  u_core__u_sie_tx__utmi_txvalid_o  ||  u_core__u_sie_tx__utmi_txready_i  ) 
                   u_core__u_sie_tx__next_state_r   =  u_core__u_sie_tx__STATE_TX_IDLE  ;
             end  
           u_core__u_sie_tx__STATE_TX_CHIRP   :
             begin 
               if (!  u_core__u_sie_tx__chirp_i  ) 
                   u_core__u_sie_tx__next_state_r   =  u_core__u_sie_tx__STATE_TX_IDLE  ;
             end 
          default :;
         endcase 
         if (!  u_core__u_sie_tx__enable_i  &&!  u_core__u_sie_tx__chirp_i  ) 
             u_core__u_sie_tx__next_state_r   =  u_core__u_sie_tx__STATE_TX_IDLE  ;
       end
  
  always @(  posedge    u_core__u_sie_tx__clk_i          or  posedge   u_core__u_sie_tx__rst_i  )
       if (  u_core__u_sie_tx__rst_i  ) 
           u_core__u_sie_tx__state_q   <=  u_core__u_sie_tx__STATE_TX_IDLE  ;
        else  
           u_core__u_sie_tx__state_q   <=  u_core__u_sie_tx__next_state_r  ;
 
   reg  u_core__u_sie_tx__input_valid_r  ; 
   reg[7:0]  u_core__u_sie_tx__input_byte_r  ; 
   reg  u_core__u_sie_tx__input_last_r  ; 
  always @*
       begin  
          u_core__u_sie_tx__input_valid_r   =  u_core__u_sie_tx__data_strb_i  &  u_core__u_sie_tx__data_pid_q  ; 
          u_core__u_sie_tx__input_byte_r   =  u_core__u_sie_tx__data_i  ; 
          u_core__u_sie_tx__input_last_r   =  u_core__u_sie_tx__data_last_i  ;
       end
  
   reg  u_core__u_sie_tx__data_accept_r  ; 
  always @*
       begin 
         if (  u_core__u_sie_tx__state_q  ==  u_core__u_sie_tx__STATE_TX_DATA  ) 
             u_core__u_sie_tx__data_accept_r   =  u_core__u_sie_tx__utmi_txready_i  ;
          else 
            if (  u_core__u_sie_tx__state_q  ==  u_core__u_sie_tx__STATE_TX_PID  &&  u_core__u_sie_tx__data_zlp_q  ) 
                u_core__u_sie_tx__data_accept_r   =  u_core__u_sie_tx__utmi_txready_i  ;
             else  
                u_core__u_sie_tx__data_accept_r   =1'b0;
       end
  
  assign   u_core__u_sie_tx__data_accept_o  =  u_core__u_sie_tx__data_accept_r  ; 
   reg[15:0]  u_core__u_sie_tx__crc_sum_q  ; 
   wire[15:0]  u_core__u_sie_tx__crc_out_w  ; 
   reg  u_core__u_sie_tx__crc_err_q  ;  
  
wire [15:0] u_core__u_sie_tx__u_crc16__crc_in_i;
wire [7:0] u_core__u_sie_tx__u_crc16__din_i;
wire [15:0] u_core__u_sie_tx__u_crc16__crc_out_o;
 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [15]=  u_core__u_sie_tx__u_crc16__din_i  [0]^  u_core__u_sie_tx__u_crc16__din_i  [1]^  u_core__u_sie_tx__u_crc16__din_i  [2]^  u_core__u_sie_tx__u_crc16__din_i  [3]^  u_core__u_sie_tx__u_crc16__din_i  [4]^  u_core__u_sie_tx__u_crc16__din_i  [5]^  u_core__u_sie_tx__u_crc16__din_i  [6]^  u_core__u_sie_tx__u_crc16__din_i  [7]^  u_core__u_sie_tx__u_crc16__crc_in_i  [7]^  u_core__u_sie_tx__u_crc16__crc_in_i  [6]^  u_core__u_sie_tx__u_crc16__crc_in_i  [5]^  u_core__u_sie_tx__u_crc16__crc_in_i  [4]^  u_core__u_sie_tx__u_crc16__crc_in_i  [3]^  u_core__u_sie_tx__u_crc16__crc_in_i  [2]^  u_core__u_sie_tx__u_crc16__crc_in_i  [1]^  u_core__u_sie_tx__u_crc16__crc_in_i  [0]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [14]=  u_core__u_sie_tx__u_crc16__din_i  [0]^  u_core__u_sie_tx__u_crc16__din_i  [1]^  u_core__u_sie_tx__u_crc16__din_i  [2]^  u_core__u_sie_tx__u_crc16__din_i  [3]^  u_core__u_sie_tx__u_crc16__din_i  [4]^  u_core__u_sie_tx__u_crc16__din_i  [5]^  u_core__u_sie_tx__u_crc16__din_i  [6]^  u_core__u_sie_tx__u_crc16__crc_in_i  [6]^  u_core__u_sie_tx__u_crc16__crc_in_i  [5]^  u_core__u_sie_tx__u_crc16__crc_in_i  [4]^  u_core__u_sie_tx__u_crc16__crc_in_i  [3]^  u_core__u_sie_tx__u_crc16__crc_in_i  [2]^  u_core__u_sie_tx__u_crc16__crc_in_i  [1]^  u_core__u_sie_tx__u_crc16__crc_in_i  [0]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [13]=  u_core__u_sie_tx__u_crc16__din_i  [6]^  u_core__u_sie_tx__u_crc16__din_i  [7]^  u_core__u_sie_tx__u_crc16__crc_in_i  [7]^  u_core__u_sie_tx__u_crc16__crc_in_i  [6]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [12]=  u_core__u_sie_tx__u_crc16__din_i  [5]^  u_core__u_sie_tx__u_crc16__din_i  [6]^  u_core__u_sie_tx__u_crc16__crc_in_i  [6]^  u_core__u_sie_tx__u_crc16__crc_in_i  [5]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [11]=  u_core__u_sie_tx__u_crc16__din_i  [4]^  u_core__u_sie_tx__u_crc16__din_i  [5]^  u_core__u_sie_tx__u_crc16__crc_in_i  [5]^  u_core__u_sie_tx__u_crc16__crc_in_i  [4]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [10]=  u_core__u_sie_tx__u_crc16__din_i  [3]^  u_core__u_sie_tx__u_crc16__din_i  [4]^  u_core__u_sie_tx__u_crc16__crc_in_i  [4]^  u_core__u_sie_tx__u_crc16__crc_in_i  [3]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [9]=  u_core__u_sie_tx__u_crc16__din_i  [2]^  u_core__u_sie_tx__u_crc16__din_i  [3]^  u_core__u_sie_tx__u_crc16__crc_in_i  [3]^  u_core__u_sie_tx__u_crc16__crc_in_i  [2]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [8]=  u_core__u_sie_tx__u_crc16__din_i  [1]^  u_core__u_sie_tx__u_crc16__din_i  [2]^  u_core__u_sie_tx__u_crc16__crc_in_i  [2]^  u_core__u_sie_tx__u_crc16__crc_in_i  [1]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [7]=  u_core__u_sie_tx__u_crc16__din_i  [0]^  u_core__u_sie_tx__u_crc16__din_i  [1]^  u_core__u_sie_tx__u_crc16__crc_in_i  [15]^  u_core__u_sie_tx__u_crc16__crc_in_i  [1]^  u_core__u_sie_tx__u_crc16__crc_in_i  [0]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [6]=  u_core__u_sie_tx__u_crc16__din_i  [0]^  u_core__u_sie_tx__u_crc16__crc_in_i  [14]^  u_core__u_sie_tx__u_crc16__crc_in_i  [0]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [5]=  u_core__u_sie_tx__u_crc16__crc_in_i  [13]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [4]=  u_core__u_sie_tx__u_crc16__crc_in_i  [12]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [3]=  u_core__u_sie_tx__u_crc16__crc_in_i  [11]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [2]=  u_core__u_sie_tx__u_crc16__crc_in_i  [10]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [1]=  u_core__u_sie_tx__u_crc16__crc_in_i  [9]; 
  assign   u_core__u_sie_tx__u_crc16__crc_out_o  [0]=  u_core__u_sie_tx__u_crc16__din_i  [0]^  u_core__u_sie_tx__u_crc16__din_i  [1]^  u_core__u_sie_tx__u_crc16__din_i  [2]^  u_core__u_sie_tx__u_crc16__din_i  [3]^  u_core__u_sie_tx__u_crc16__din_i  [4]^  u_core__u_sie_tx__u_crc16__din_i  [5]^  u_core__u_sie_tx__u_crc16__din_i  [6]^  u_core__u_sie_tx__u_crc16__din_i  [7]^  u_core__u_sie_tx__u_crc16__crc_in_i  [8]^  u_core__u_sie_tx__u_crc16__crc_in_i  [7]^  u_core__u_sie_tx__u_crc16__crc_in_i  [6]^  u_core__u_sie_tx__u_crc16__crc_in_i  [5]^  u_core__u_sie_tx__u_crc16__crc_in_i  [4]^  u_core__u_sie_tx__u_crc16__crc_in_i  [3]^  u_core__u_sie_tx__u_crc16__crc_in_i  [2]^  u_core__u_sie_tx__u_crc16__crc_in_i  [1]^  u_core__u_sie_tx__u_crc16__crc_in_i  [0];
assign u_core__u_sie_tx__u_crc16__crc_in_i = u_core__u_sie_tx__crc_sum_q;
assign u_core__u_sie_tx__u_crc16__din_i = u_core__u_sie_tx__utmi_data_o;
assign u_core__u_sie_tx__crc_out_w = u_core__u_sie_tx__u_crc16__crc_out_o;
 
  always @(  posedge    u_core__u_sie_tx__clk_i          or  posedge   u_core__u_sie_tx__rst_i  )
       if (  u_core__u_sie_tx__rst_i  ) 
           u_core__u_sie_tx__crc_sum_q   <=16'hFFFF;
        else 
          if (  u_core__u_sie_tx__state_q  ==  u_core__u_sie_tx__STATE_TX_IDLE  ) 
              u_core__u_sie_tx__crc_sum_q   <=16'hFFFF;
           else 
             if (  u_core__u_sie_tx__state_q  ==  u_core__u_sie_tx__STATE_TX_DATA  &&  u_core__u_sie_tx__utmi_txvalid_o  &&  u_core__u_sie_tx__utmi_txready_i  ) 
                 u_core__u_sie_tx__crc_sum_q   <=  u_core__u_sie_tx__crc_out_w  ;
 
   reg  u_core__u_sie_tx__valid_q  ; 
   reg[7:0]  u_core__u_sie_tx__data_q  ; 
  always @(  posedge    u_core__u_sie_tx__clk_i          or  posedge   u_core__u_sie_tx__rst_i  )
       if (  u_core__u_sie_tx__rst_i  )
          begin  
             u_core__u_sie_tx__valid_q   <=1'b0; 
             u_core__u_sie_tx__data_q   <=8'b0; 
             u_core__u_sie_tx__last_q   <=1'b0;
          end 
        else 
          if (!  u_core__u_sie_tx__enable_i  )
             begin  
                u_core__u_sie_tx__valid_q   <=1'b0; 
                u_core__u_sie_tx__data_q   <=8'b0; 
                u_core__u_sie_tx__last_q   <=1'b0;
             end 
           else 
             if (  u_core__u_sie_tx__tx_valid_i  &&  u_core__u_sie_tx__tx_accept_o  )
                begin  
                   u_core__u_sie_tx__valid_q   <=1'b1; 
                   u_core__u_sie_tx__data_q   <=  u_core__u_sie_tx__tx_pid_i  ; 
                   u_core__u_sie_tx__last_q   <=1'b0;
                end 
              else 
                if (  u_core__u_sie_tx__utmi_txready_i  )
                   begin  
                      u_core__u_sie_tx__valid_q   <=1'b0; 
                      u_core__u_sie_tx__data_q   <=8'b0; 
                      u_core__u_sie_tx__last_q   <=1'b0;
                   end
  
   reg  u_core__u_sie_tx__utmi_txvalid_r  ; 
   reg[7:0]  u_core__u_sie_tx__utmi_data_r  ; 
  always @*
       begin 
         if (  u_core__u_sie_tx__state_q  ==  u_core__u_sie_tx__STATE_TX_CHIRP  )
            begin  
               u_core__u_sie_tx__utmi_txvalid_r   =1'b1; 
               u_core__u_sie_tx__utmi_data_r   =8'b0;
            end 
          else 
            if (  u_core__u_sie_tx__state_q  ==  u_core__u_sie_tx__STATE_TX_CRC1  )
               begin  
                  u_core__u_sie_tx__utmi_txvalid_r   =1'b1; 
                  u_core__u_sie_tx__utmi_data_r   =  u_core__u_sie_tx__crc_sum_q  [7:0]^8'hFF;
               end 
             else 
               if (  u_core__u_sie_tx__state_q  ==  u_core__u_sie_tx__STATE_TX_CRC2  )
                  begin  
                     u_core__u_sie_tx__utmi_txvalid_r   =1'b1; 
                     u_core__u_sie_tx__utmi_data_r   =  u_core__u_sie_tx__crc_sum_q  [15:8]^8'hFF;
                  end 
                else 
                  if (  u_core__u_sie_tx__state_q  ==  u_core__u_sie_tx__STATE_TX_DATA  )
                     begin  
                        u_core__u_sie_tx__utmi_txvalid_r   =  u_core__u_sie_tx__data_valid_i  ; 
                        u_core__u_sie_tx__utmi_data_r   =  u_core__u_sie_tx__data_i  ;
                     end 
                   else 
                     begin  
                        u_core__u_sie_tx__utmi_txvalid_r   =  u_core__u_sie_tx__valid_q  ; 
                        u_core__u_sie_tx__utmi_data_r   =  u_core__u_sie_tx__data_q  ;
                     end 
       end
  
  assign   u_core__u_sie_tx__utmi_txvalid_o  =  u_core__u_sie_tx__utmi_txvalid_r  ; 
  assign   u_core__u_sie_tx__utmi_data_o  =  u_core__u_sie_tx__utmi_data_r  ;
assign u_core__u_sie_tx__clk_i = u_core__clk_i;
assign u_core__u_sie_tx__rst_i = u_core__rst_i;
assign u_core__u_sie_tx__enable_i = ~u_core__usb_rst_w;
assign u_core__u_sie_tx__chirp_i = u_core__reg_chirp_en_i;
assign u_core__u_sie_tx__utmi_txready_i = u_core__utmi_txready_i;
assign u_core__u_sie_tx__tx_valid_i = u_core__tx_valid_q;
assign u_core__u_sie_tx__tx_pid_i = u_core__tx_pid_q;
assign u_core__u_sie_tx__data_valid_i = u_core__tx_data_valid_r;
assign u_core__u_sie_tx__data_strb_i = u_core__tx_data_strb_r;
assign u_core__u_sie_tx__data_i = u_core__tx_data_r;
assign u_core__u_sie_tx__data_last_i = u_core__tx_data_last_r;
assign u_core__utmi_data_o = u_core__u_sie_tx__utmi_data_o;
assign u_core__utmi_txvalid_o = u_core__u_sie_tx__utmi_txvalid_o;
assign u_core__tx_accept_w = u_core__u_sie_tx__tx_accept_o;
assign u_core__tx_data_accept_w = u_core__u_sie_tx__data_accept_o;
 
  always @*
       begin  
          u_core__tx_data_valid_r   =1'b0; 
          u_core__tx_data_strb_r   =1'b0; 
          u_core__tx_data_r   =8'b0; 
          u_core__tx_data_last_r   =1'b0;
         case (  u_core__token_ep_w  )
          4 'd0:
             begin  
                u_core__tx_data_valid_r   =  u_core__ep0_tx_data_valid_i  ; 
                u_core__tx_data_strb_r   =  u_core__ep0_tx_data_strb_i  ; 
                u_core__tx_data_r   =  u_core__ep0_tx_data_i  ; 
                u_core__tx_data_last_r   =  u_core__ep0_tx_data_last_i  ;
             end 
          4 'd1:
             begin  
                u_core__tx_data_valid_r   =  u_core__ep1_tx_data_valid_i  ; 
                u_core__tx_data_strb_r   =  u_core__ep1_tx_data_strb_i  ; 
                u_core__tx_data_r   =  u_core__ep1_tx_data_i  ; 
                u_core__tx_data_last_r   =  u_core__ep1_tx_data_last_i  ;
             end 
          4 'd2:
             begin  
                u_core__tx_data_valid_r   =  u_core__ep2_tx_data_valid_i  ; 
                u_core__tx_data_strb_r   =  u_core__ep2_tx_data_strb_i  ; 
                u_core__tx_data_r   =  u_core__ep2_tx_data_i  ; 
                u_core__tx_data_last_r   =  u_core__ep2_tx_data_last_i  ;
             end 
          4 'd3:
             begin  
                u_core__tx_data_valid_r   =  u_core__ep3_tx_data_valid_i  ; 
                u_core__tx_data_strb_r   =  u_core__ep3_tx_data_strb_i  ; 
                u_core__tx_data_r   =  u_core__ep3_tx_data_i  ; 
                u_core__tx_data_last_r   =  u_core__ep3_tx_data_last_i  ;
             end 
          default :;
         endcase 
       end
  
  assign   u_core__ep0_tx_data_accept_o  =  u_core__tx_data_accept_w  &(  u_core__token_ep_w  ==4'd0); 
  assign   u_core__ep1_tx_data_accept_o  =  u_core__tx_data_accept_w  &(  u_core__token_ep_w  ==4'd1); 
  assign   u_core__ep2_tx_data_accept_o  =  u_core__tx_data_accept_w  &(  u_core__token_ep_w  ==4'd2); 
  assign   u_core__ep3_tx_data_accept_o  =  u_core__tx_data_accept_w  &(  u_core__token_ep_w  ==4'd3); 
  always @*
       begin  
          u_core__rx_space_r   =1'b0; 
          u_core__tx_ready_r   =1'b0; 
          u_core__ep_data_bit_r   =1'b0; 
          u_core__ep_stall_r   =1'b0; 
          u_core__ep_iso_r   =1'b0;
         case (  u_core__token_ep_w  )
          4 'd0:
             begin  
                u_core__rx_space_r   =  u_core__ep0_rx_space_i  ; 
                u_core__tx_ready_r   =  u_core__ep0_tx_ready_i  ; 
                u_core__ep_data_bit_r   =  u_core__ep0_data_bit_q  |  u_core__status_stage_w  ; 
                u_core__ep_stall_r   =  u_core__ep0_stall_i  ; 
                u_core__ep_iso_r   =  u_core__ep0_iso_i  ;
             end 
          4 'd1:
             begin  
                u_core__rx_space_r   =  u_core__ep1_rx_space_i  ; 
                u_core__tx_ready_r   =  u_core__ep1_tx_ready_i  ; 
                u_core__ep_data_bit_r   =  u_core__ep1_data_bit_q  |  u_core__status_stage_w  ; 
                u_core__ep_stall_r   =  u_core__ep1_stall_i  ; 
                u_core__ep_iso_r   =  u_core__ep1_iso_i  ;
             end 
          4 'd2:
             begin  
                u_core__rx_space_r   =  u_core__ep2_rx_space_i  ; 
                u_core__tx_ready_r   =  u_core__ep2_tx_ready_i  ; 
                u_core__ep_data_bit_r   =  u_core__ep2_data_bit_q  |  u_core__status_stage_w  ; 
                u_core__ep_stall_r   =  u_core__ep2_stall_i  ; 
                u_core__ep_iso_r   =  u_core__ep2_iso_i  ;
             end 
          4 'd3:
             begin  
                u_core__rx_space_r   =  u_core__ep3_rx_space_i  ; 
                u_core__tx_ready_r   =  u_core__ep3_tx_ready_i  ; 
                u_core__ep_data_bit_r   =  u_core__ep3_data_bit_q  |  u_core__status_stage_w  ; 
                u_core__ep_stall_r   =  u_core__ep3_stall_i  ; 
                u_core__ep_iso_r   =  u_core__ep3_iso_i  ;
             end 
          default :;
         endcase 
       end
  
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__rx_space_q   <=1'b0;
        else 
          if (  u_core__state_q  ==  u_core__STATE_RX_IDLE  ) 
              u_core__rx_space_q   <=  u_core__rx_space_r  ;
  
  
wire  u_core__u_sie_rx__clk_i;
wire  u_core__u_sie_rx__rst_i;
wire  u_core__u_sie_rx__enable_i;
wire [7:0] u_core__u_sie_rx__utmi_data_i;
wire  u_core__u_sie_rx__utmi_rxvalid_i;
wire  u_core__u_sie_rx__utmi_rxactive_i;
wire [6:0] u_core__u_sie_rx__current_addr_i;
wire [7:0] u_core__u_sie_rx__pid_o;
wire  u_core__u_sie_rx__frame_valid_o;
wire [10:0] u_core__u_sie_rx__frame_number_o;
wire  u_core__u_sie_rx__token_valid_o;
wire [6:0] u_core__u_sie_rx__token_addr_o;
wire [3:0] u_core__u_sie_rx__token_ep_o;
wire  u_core__u_sie_rx__token_crc_err_o;
wire  u_core__u_sie_rx__handshake_valid_o;
wire  u_core__u_sie_rx__data_valid_o;
wire  u_core__u_sie_rx__data_strb_o;
wire [7:0] u_core__u_sie_rx__data_o;
wire  u_core__u_sie_rx__data_last_o;
wire  u_core__u_sie_rx__data_crc_err_o;
wire  u_core__u_sie_rx__data_complete_o;
 localparam  u_core__u_sie_rx__STATE_W  =4; localparam  u_core__u_sie_rx__STATE_RX_IDLE  =4'd0; localparam  u_core__u_sie_rx__STATE_RX_TOKEN2  =4'd1; localparam  u_core__u_sie_rx__STATE_RX_TOKEN3  =4'd2; localparam  u_core__u_sie_rx__STATE_RX_TOKEN_COMPLETE  =4'd3; localparam  u_core__u_sie_rx__STATE_RX_SOF2  =4'd4; localparam  u_core__u_sie_rx__STATE_RX_SOF3  =4'd5; localparam  u_core__u_sie_rx__STATE_RX_DATA  =4'd6; localparam  u_core__u_sie_rx__STATE_RX_DATA_COMPLETE  =4'd7; localparam  u_core__u_sie_rx__STATE_RX_IGNORED  =4'd8; 
   reg[  u_core__u_sie_rx__STATE_W  -1:0]  u_core__u_sie_rx__state_q  ; 
   reg[11-1:0]  u_core__u_sie_rx__frame_num_q  ; 
   reg[7-1:0]  u_core__u_sie_rx__token_dev_q  ; 
   reg[4-1:0]  u_core__u_sie_rx__token_ep_q  ; 
   reg[8-1:0]  u_core__u_sie_rx__token_pid_q  ; 
   reg[31:0]  u_core__u_sie_rx__data_buffer_q  ; 
   reg[3:0]  u_core__u_sie_rx__data_valid_q  ; 
   reg[3:0]  u_core__u_sie_rx__rx_active_q  ; 
   wire  u_core__u_sie_rx__shift_en_w  =(  u_core__u_sie_rx__utmi_rxvalid_i  &  u_core__u_sie_rx__utmi_rxactive_i  )||!  u_core__u_sie_rx__utmi_rxactive_i  ; 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__data_buffer_q   <=32'b0;
        else 
          if (  u_core__u_sie_rx__shift_en_w  ) 
              u_core__u_sie_rx__data_buffer_q   <={  u_core__u_sie_rx__utmi_data_i  ,  u_core__u_sie_rx__data_buffer_q  [31:8]};
 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__data_valid_q   <=4'b0;
        else 
          if (  u_core__u_sie_rx__shift_en_w  ) 
              u_core__u_sie_rx__data_valid_q   <={(  u_core__u_sie_rx__utmi_rxvalid_i  &  u_core__u_sie_rx__utmi_rxactive_i  ),  u_core__u_sie_rx__data_valid_q  [3:1]};
           else  
              u_core__u_sie_rx__data_valid_q   <={  u_core__u_sie_rx__data_valid_q  [3:1],1'b0};
 
   reg[1:0]  u_core__u_sie_rx__data_crc_q  ; 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__data_crc_q   <=2'b0;
        else 
          if (  u_core__u_sie_rx__shift_en_w  ) 
              u_core__u_sie_rx__data_crc_q   <={!  u_core__u_sie_rx__utmi_rxactive_i  ,  u_core__u_sie_rx__data_crc_q  [1]};
 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__rx_active_q   <=4'b0;
        else  
           u_core__u_sie_rx__rx_active_q   <={  u_core__u_sie_rx__utmi_rxactive_i  ,  u_core__u_sie_rx__rx_active_q  [3:1]};
 
   wire[7:0]  u_core__u_sie_rx__data_w  =  u_core__u_sie_rx__data_buffer_q  [7:0]; 
   wire  u_core__u_sie_rx__data_ready_w  =  u_core__u_sie_rx__data_valid_q  [0]; 
   wire  u_core__u_sie_rx__crc_byte_w  =  u_core__u_sie_rx__data_crc_q  [0]; 
   wire  u_core__u_sie_rx__rx_active_w  =  u_core__u_sie_rx__rx_active_q  [0]; 
   wire  u_core__u_sie_rx__address_match_w  =(  u_core__u_sie_rx__token_dev_q  ==  u_core__u_sie_rx__current_addr_i  ); 
   reg[  u_core__u_sie_rx__STATE_W  -1:0]  u_core__u_sie_rx__next_state_r  ; 
  always @*
       begin  
          u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__state_q  ;
         case (  u_core__u_sie_rx__state_q  ) 
           u_core__u_sie_rx__STATE_RX_IDLE   :
             begin 
               if (  u_core__u_sie_rx__data_ready_w  )
                  begin 
                    case (  u_core__u_sie_rx__data_w  )
                     8 'hE1,8'h69,8'h2D,8'hB4: 
                         u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_TOKEN2  ;
                     8 'hA5: 
                         u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_SOF2  ;
                     8 'hC3,8'h4B,8'h87,8'h0F:
                        begin  
                           u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_DATA  ;
                        end 
                     8 'hD2,8'h5A,8'h1E,8'h96: 
                         u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_IDLE  ;
                     default : 
                         u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_IGNORED  ;
                    endcase 
                  end 
             end  
           u_core__u_sie_rx__STATE_RX_IGNORED   :
             begin 
               if (!  u_core__u_sie_rx__rx_active_w  ) 
                   u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_IDLE  ;
             end  
           u_core__u_sie_rx__STATE_RX_SOF2   :
             begin 
               if (  u_core__u_sie_rx__data_ready_w  ) 
                   u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_SOF3  ;
                else 
                  if (!  u_core__u_sie_rx__rx_active_w  ) 
                      u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_IDLE  ;
             end  
           u_core__u_sie_rx__STATE_RX_SOF3   :
             begin 
               if (  u_core__u_sie_rx__data_ready_w  ||!  u_core__u_sie_rx__rx_active_w  ) 
                   u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_IDLE  ;
             end  
           u_core__u_sie_rx__STATE_RX_TOKEN2   :
             begin 
               if (  u_core__u_sie_rx__data_ready_w  ) 
                   u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_TOKEN3  ;
                else 
                  if (!  u_core__u_sie_rx__rx_active_w  ) 
                      u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_IDLE  ;
             end  
           u_core__u_sie_rx__STATE_RX_TOKEN3   :
             begin 
               if (  u_core__u_sie_rx__data_ready_w  ) 
                   u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_TOKEN_COMPLETE  ;
                else 
                  if (!  u_core__u_sie_rx__rx_active_w  ) 
                      u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_IDLE  ;
             end  
           u_core__u_sie_rx__STATE_RX_TOKEN_COMPLETE   :
             begin  
                u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_IDLE  ;
             end  
           u_core__u_sie_rx__STATE_RX_DATA   :
             begin 
               if (  u_core__u_sie_rx__crc_byte_w  ) 
                   u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_DATA_COMPLETE  ;
             end  
           u_core__u_sie_rx__STATE_RX_DATA_COMPLETE   :
             begin 
               if (!  u_core__u_sie_rx__rx_active_w  ) 
                   u_core__u_sie_rx__next_state_r   =  u_core__u_sie_rx__STATE_RX_IDLE  ;
             end 
          default :;
         endcase 
       end
  
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__state_q   <=  u_core__u_sie_rx__STATE_RX_IDLE  ;
        else 
          if (!  u_core__u_sie_rx__enable_i  ) 
              u_core__u_sie_rx__state_q   <=  u_core__u_sie_rx__STATE_RX_IDLE  ;
           else  
              u_core__u_sie_rx__state_q   <=  u_core__u_sie_rx__next_state_r  ;
 
   reg  u_core__u_sie_rx__handshake_valid_q  ; 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__handshake_valid_q   <=1'b0;
        else 
          if (  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_IDLE  &&  u_core__u_sie_rx__data_ready_w  )
             begin 
               case (  u_core__u_sie_rx__data_w  )
                8 'hD2,8'h5A,8'h1E,8'h96: 
                    u_core__u_sie_rx__handshake_valid_q   <=  u_core__u_sie_rx__address_match_w  ;
                default : 
                    u_core__u_sie_rx__handshake_valid_q   <=1'b0;
               endcase 
             end 
           else  
              u_core__u_sie_rx__handshake_valid_q   <=1'b0;
 
  assign   u_core__u_sie_rx__handshake_valid_o  =  u_core__u_sie_rx__handshake_valid_q  ; 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__frame_num_q   <=11'b0;
        else 
          if (  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_SOF2  &&  u_core__u_sie_rx__data_ready_w  ) 
              u_core__u_sie_rx__frame_num_q   <={3'b0,  u_core__u_sie_rx__data_w  };
           else 
             if (  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_SOF3  &&  u_core__u_sie_rx__data_ready_w  ) 
                 u_core__u_sie_rx__frame_num_q   <={  u_core__u_sie_rx__data_w  [2:0],  u_core__u_sie_rx__frame_num_q  [7:0]};
              else 
                if (!  u_core__u_sie_rx__enable_i  ) 
                    u_core__u_sie_rx__frame_num_q   <=11'b0;
 
  assign   u_core__u_sie_rx__frame_number_o  =  u_core__u_sie_rx__frame_num_q  ; 
   reg  u_core__u_sie_rx__frame_valid_q  ; 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__frame_valid_q   <=1'b0;
        else  
           u_core__u_sie_rx__frame_valid_q   <=(  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_SOF3  &&  u_core__u_sie_rx__data_ready_w  );
 
  assign   u_core__u_sie_rx__frame_valid_o  =  u_core__u_sie_rx__frame_valid_q  ; 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__token_pid_q   <=8'b0;
        else 
          if (  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_IDLE  &&  u_core__u_sie_rx__data_ready_w  ) 
              u_core__u_sie_rx__token_pid_q   <=  u_core__u_sie_rx__data_w  ;
           else 
             if (!  u_core__u_sie_rx__enable_i  ) 
                 u_core__u_sie_rx__token_pid_q   <=8'b0;
 
  assign   u_core__u_sie_rx__pid_o  =  u_core__u_sie_rx__token_pid_q  ; 
   reg  u_core__u_sie_rx__token_valid_q  ; 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__token_valid_q   <=1'b0;
        else  
           u_core__u_sie_rx__token_valid_q   <=(  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_TOKEN_COMPLETE  )&&  u_core__u_sie_rx__address_match_w  ;
 
  assign   u_core__u_sie_rx__token_valid_o  =  u_core__u_sie_rx__token_valid_q  ; 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__token_dev_q   <=7'b0;
        else 
          if (  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_TOKEN2  &&  u_core__u_sie_rx__data_ready_w  ) 
              u_core__u_sie_rx__token_dev_q   <=  u_core__u_sie_rx__data_w  [6:0];
           else 
             if (!  u_core__u_sie_rx__enable_i  ) 
                 u_core__u_sie_rx__token_dev_q   <=7'b0;
 
  assign   u_core__u_sie_rx__token_addr_o  =  u_core__u_sie_rx__token_dev_q  ; 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__token_ep_q   <=4'b0;
        else 
          if (  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_TOKEN2  &&  u_core__u_sie_rx__data_ready_w  ) 
              u_core__u_sie_rx__token_ep_q   [0]<=  u_core__u_sie_rx__data_w  [7];
           else 
             if (  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_TOKEN3  &&  u_core__u_sie_rx__data_ready_w  ) 
                 u_core__u_sie_rx__token_ep_q   [3:1]<=  u_core__u_sie_rx__data_w  [2:0];
              else 
                if (!  u_core__u_sie_rx__enable_i  ) 
                    u_core__u_sie_rx__token_ep_q   <=4'b0;
 
  assign   u_core__u_sie_rx__token_ep_o  =  u_core__u_sie_rx__token_ep_q  ; 
  assign   u_core__u_sie_rx__token_crc_err_o  =1'b0; 
   wire[7:0]  u_core__u_sie_rx__input_data_w  =  u_core__u_sie_rx__data_w  ; 
   wire  u_core__u_sie_rx__input_ready_w  =  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_DATA  &&  u_core__u_sie_rx__data_ready_w  &&!  u_core__u_sie_rx__crc_byte_w  ; 
   reg[15:0]  u_core__u_sie_rx__crc_sum_q  ; 
   wire[15:0]  u_core__u_sie_rx__crc_out_w  ; 
   reg  u_core__u_sie_rx__crc_err_q  ;  
  
wire [15:0] u_core__u_sie_rx__u_crc16__crc_in_i;
wire [7:0] u_core__u_sie_rx__u_crc16__din_i;
wire [15:0] u_core__u_sie_rx__u_crc16__crc_out_o;
 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [15]=  u_core__u_sie_rx__u_crc16__din_i  [0]^  u_core__u_sie_rx__u_crc16__din_i  [1]^  u_core__u_sie_rx__u_crc16__din_i  [2]^  u_core__u_sie_rx__u_crc16__din_i  [3]^  u_core__u_sie_rx__u_crc16__din_i  [4]^  u_core__u_sie_rx__u_crc16__din_i  [5]^  u_core__u_sie_rx__u_crc16__din_i  [6]^  u_core__u_sie_rx__u_crc16__din_i  [7]^  u_core__u_sie_rx__u_crc16__crc_in_i  [7]^  u_core__u_sie_rx__u_crc16__crc_in_i  [6]^  u_core__u_sie_rx__u_crc16__crc_in_i  [5]^  u_core__u_sie_rx__u_crc16__crc_in_i  [4]^  u_core__u_sie_rx__u_crc16__crc_in_i  [3]^  u_core__u_sie_rx__u_crc16__crc_in_i  [2]^  u_core__u_sie_rx__u_crc16__crc_in_i  [1]^  u_core__u_sie_rx__u_crc16__crc_in_i  [0]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [14]=  u_core__u_sie_rx__u_crc16__din_i  [0]^  u_core__u_sie_rx__u_crc16__din_i  [1]^  u_core__u_sie_rx__u_crc16__din_i  [2]^  u_core__u_sie_rx__u_crc16__din_i  [3]^  u_core__u_sie_rx__u_crc16__din_i  [4]^  u_core__u_sie_rx__u_crc16__din_i  [5]^  u_core__u_sie_rx__u_crc16__din_i  [6]^  u_core__u_sie_rx__u_crc16__crc_in_i  [6]^  u_core__u_sie_rx__u_crc16__crc_in_i  [5]^  u_core__u_sie_rx__u_crc16__crc_in_i  [4]^  u_core__u_sie_rx__u_crc16__crc_in_i  [3]^  u_core__u_sie_rx__u_crc16__crc_in_i  [2]^  u_core__u_sie_rx__u_crc16__crc_in_i  [1]^  u_core__u_sie_rx__u_crc16__crc_in_i  [0]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [13]=  u_core__u_sie_rx__u_crc16__din_i  [6]^  u_core__u_sie_rx__u_crc16__din_i  [7]^  u_core__u_sie_rx__u_crc16__crc_in_i  [7]^  u_core__u_sie_rx__u_crc16__crc_in_i  [6]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [12]=  u_core__u_sie_rx__u_crc16__din_i  [5]^  u_core__u_sie_rx__u_crc16__din_i  [6]^  u_core__u_sie_rx__u_crc16__crc_in_i  [6]^  u_core__u_sie_rx__u_crc16__crc_in_i  [5]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [11]=  u_core__u_sie_rx__u_crc16__din_i  [4]^  u_core__u_sie_rx__u_crc16__din_i  [5]^  u_core__u_sie_rx__u_crc16__crc_in_i  [5]^  u_core__u_sie_rx__u_crc16__crc_in_i  [4]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [10]=  u_core__u_sie_rx__u_crc16__din_i  [3]^  u_core__u_sie_rx__u_crc16__din_i  [4]^  u_core__u_sie_rx__u_crc16__crc_in_i  [4]^  u_core__u_sie_rx__u_crc16__crc_in_i  [3]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [9]=  u_core__u_sie_rx__u_crc16__din_i  [2]^  u_core__u_sie_rx__u_crc16__din_i  [3]^  u_core__u_sie_rx__u_crc16__crc_in_i  [3]^  u_core__u_sie_rx__u_crc16__crc_in_i  [2]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [8]=  u_core__u_sie_rx__u_crc16__din_i  [1]^  u_core__u_sie_rx__u_crc16__din_i  [2]^  u_core__u_sie_rx__u_crc16__crc_in_i  [2]^  u_core__u_sie_rx__u_crc16__crc_in_i  [1]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [7]=  u_core__u_sie_rx__u_crc16__din_i  [0]^  u_core__u_sie_rx__u_crc16__din_i  [1]^  u_core__u_sie_rx__u_crc16__crc_in_i  [15]^  u_core__u_sie_rx__u_crc16__crc_in_i  [1]^  u_core__u_sie_rx__u_crc16__crc_in_i  [0]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [6]=  u_core__u_sie_rx__u_crc16__din_i  [0]^  u_core__u_sie_rx__u_crc16__crc_in_i  [14]^  u_core__u_sie_rx__u_crc16__crc_in_i  [0]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [5]=  u_core__u_sie_rx__u_crc16__crc_in_i  [13]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [4]=  u_core__u_sie_rx__u_crc16__crc_in_i  [12]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [3]=  u_core__u_sie_rx__u_crc16__crc_in_i  [11]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [2]=  u_core__u_sie_rx__u_crc16__crc_in_i  [10]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [1]=  u_core__u_sie_rx__u_crc16__crc_in_i  [9]; 
  assign   u_core__u_sie_rx__u_crc16__crc_out_o  [0]=  u_core__u_sie_rx__u_crc16__din_i  [0]^  u_core__u_sie_rx__u_crc16__din_i  [1]^  u_core__u_sie_rx__u_crc16__din_i  [2]^  u_core__u_sie_rx__u_crc16__din_i  [3]^  u_core__u_sie_rx__u_crc16__din_i  [4]^  u_core__u_sie_rx__u_crc16__din_i  [5]^  u_core__u_sie_rx__u_crc16__din_i  [6]^  u_core__u_sie_rx__u_crc16__din_i  [7]^  u_core__u_sie_rx__u_crc16__crc_in_i  [8]^  u_core__u_sie_rx__u_crc16__crc_in_i  [7]^  u_core__u_sie_rx__u_crc16__crc_in_i  [6]^  u_core__u_sie_rx__u_crc16__crc_in_i  [5]^  u_core__u_sie_rx__u_crc16__crc_in_i  [4]^  u_core__u_sie_rx__u_crc16__crc_in_i  [3]^  u_core__u_sie_rx__u_crc16__crc_in_i  [2]^  u_core__u_sie_rx__u_crc16__crc_in_i  [1]^  u_core__u_sie_rx__u_crc16__crc_in_i  [0];
assign u_core__u_sie_rx__u_crc16__crc_in_i = u_core__u_sie_rx__crc_sum_q;
assign u_core__u_sie_rx__u_crc16__din_i = u_core__u_sie_rx__data_w;
assign u_core__u_sie_rx__crc_out_w = u_core__u_sie_rx__u_crc16__crc_out_o;
 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__crc_sum_q   <=16'hFFFF;
        else 
          if (  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_IDLE  ) 
              u_core__u_sie_rx__crc_sum_q   <=16'hFFFF;
           else 
             if (  u_core__u_sie_rx__data_ready_w  ) 
                 u_core__u_sie_rx__crc_sum_q   <=  u_core__u_sie_rx__crc_out_w  ;
 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__crc_err_q   <=1'b0;
        else 
          if (  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_IDLE  ) 
              u_core__u_sie_rx__crc_err_q   <=1'b0;
           else 
             if (  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_DATA_COMPLETE  &&  u_core__u_sie_rx__next_state_r  ==  u_core__u_sie_rx__STATE_RX_IDLE  ) 
                 u_core__u_sie_rx__crc_err_q   <=(  u_core__u_sie_rx__crc_sum_q  !=16'hB001);
 
  assign   u_core__u_sie_rx__data_crc_err_o  =  u_core__u_sie_rx__crc_err_q  ; 
   reg  u_core__u_sie_rx__data_complete_q  ; 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__data_complete_q   <=1'b0;
        else 
          if (  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_DATA_COMPLETE  &&  u_core__u_sie_rx__next_state_r  ==  u_core__u_sie_rx__STATE_RX_IDLE  ) 
              u_core__u_sie_rx__data_complete_q   <=1'b1;
           else  
              u_core__u_sie_rx__data_complete_q   <=1'b0;
 
  assign   u_core__u_sie_rx__data_complete_o  =  u_core__u_sie_rx__data_complete_q  ; 
   reg  u_core__u_sie_rx__data_zlp_q  ; 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  ) 
           u_core__u_sie_rx__data_zlp_q   <=1'b0;
        else 
          if (  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_IDLE  &&  u_core__u_sie_rx__next_state_r  ==  u_core__u_sie_rx__STATE_RX_DATA  ) 
              u_core__u_sie_rx__data_zlp_q   <=1'b1;
           else 
             if (  u_core__u_sie_rx__input_ready_w  ) 
                 u_core__u_sie_rx__data_zlp_q   <=1'b0;
 
   reg  u_core__u_sie_rx__valid_q  ; 
   reg  u_core__u_sie_rx__last_q  ; 
   reg[7:0]  u_core__u_sie_rx__data_q  ; 
   reg  u_core__u_sie_rx__mask_q  ; 
  always @(  posedge    u_core__u_sie_rx__clk_i          or  posedge   u_core__u_sie_rx__rst_i  )
       if (  u_core__u_sie_rx__rst_i  )
          begin  
             u_core__u_sie_rx__valid_q   <=1'b0; 
             u_core__u_sie_rx__data_q   <=8'b0; 
             u_core__u_sie_rx__mask_q   <=1'b0; 
             u_core__u_sie_rx__last_q   <=1'b0;
          end 
        else 
          begin  
             u_core__u_sie_rx__valid_q   <=  u_core__u_sie_rx__input_ready_w  ||((  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_DATA  )&&  u_core__u_sie_rx__crc_byte_w  &&  u_core__u_sie_rx__data_zlp_q  ); 
             u_core__u_sie_rx__data_q   <=  u_core__u_sie_rx__input_data_w  ; 
             u_core__u_sie_rx__mask_q   <=  u_core__u_sie_rx__input_ready_w  ; 
             u_core__u_sie_rx__last_q   <=(  u_core__u_sie_rx__state_q  ==  u_core__u_sie_rx__STATE_RX_DATA  )&&  u_core__u_sie_rx__crc_byte_w  ;
          end
  
  assign   u_core__u_sie_rx__data_valid_o  =  u_core__u_sie_rx__valid_q  ; 
  assign   u_core__u_sie_rx__data_strb_o  =  u_core__u_sie_rx__mask_q  ; 
  assign   u_core__u_sie_rx__data_o  =  u_core__u_sie_rx__data_q  ; 
  assign   u_core__u_sie_rx__data_last_o  =  u_core__u_sie_rx__last_q  |  u_core__u_sie_rx__crc_byte_w  ;
assign u_core__u_sie_rx__clk_i = u_core__clk_i;
assign u_core__u_sie_rx__rst_i = u_core__rst_i;
assign u_core__u_sie_rx__enable_i = ~u_core__usb_rst_w&&~u_core__reg_chirp_en_i;
assign u_core__u_sie_rx__utmi_data_i = u_core__utmi_data_i;
assign u_core__u_sie_rx__utmi_rxvalid_i = u_core__utmi_rxvalid_i;
assign u_core__u_sie_rx__utmi_rxactive_i = u_core__utmi_rxactive_i;
assign u_core__u_sie_rx__current_addr_i = u_core__current_addr_q;
assign u_core__token_pid_w = u_core__u_sie_rx__pid_o;
assign u_core__frame_valid_w = u_core__u_sie_rx__frame_valid_o;
assign u_core__reg_sts_frame_num_o = u_core__u_sie_rx__frame_number_o;
assign u_core__token_valid_w = u_core__u_sie_rx__token_valid_o;
assign u_core__token_dev_w = u_core__u_sie_rx__token_addr_o;
assign u_core__token_ep_w = u_core__u_sie_rx__token_ep_o;
assign u_core__rx_handshake_w = u_core__u_sie_rx__handshake_valid_o;
assign u_core__rx_data_valid_w = u_core__u_sie_rx__data_valid_o;
assign u_core__rx_strb_o = u_core__u_sie_rx__data_strb_o;
assign u_core__rx_data_o = u_core__u_sie_rx__data_o;
assign u_core__rx_last_o = u_core__u_sie_rx__data_last_o;
assign u_core__rx_crc_err_o = u_core__u_sie_rx__data_crc_err_o;
assign u_core__rx_data_complete_w = u_core__u_sie_rx__data_complete_o;
 
  assign   u_core__ep0_rx_valid_o  =  u_core__rx_enable_q  &  u_core__rx_data_valid_w  &(  u_core__token_ep_w  ==4'd0); 
  assign   u_core__ep0_rx_setup_o  =  u_core__rx_setup_q  &(  u_core__token_ep_w  ==4'd0); 
  assign   u_core__ep1_rx_valid_o  =  u_core__rx_enable_q  &  u_core__rx_data_valid_w  &(  u_core__token_ep_w  ==4'd1); 
  assign   u_core__ep1_rx_setup_o  =  u_core__rx_setup_q  &(  u_core__token_ep_w  ==4'd0); 
  assign   u_core__ep2_rx_valid_o  =  u_core__rx_enable_q  &  u_core__rx_data_valid_w  &(  u_core__token_ep_w  ==4'd2); 
  assign   u_core__ep2_rx_setup_o  =  u_core__rx_setup_q  &(  u_core__token_ep_w  ==4'd0); 
  assign   u_core__ep3_rx_valid_o  =  u_core__rx_enable_q  &  u_core__rx_data_valid_w  &(  u_core__token_ep_w  ==4'd3); 
  assign   u_core__ep3_rx_setup_o  =  u_core__rx_setup_q  &(  u_core__token_ep_w  ==4'd0); 
   reg[  u_core__STATE_W  -1:0]  u_core__next_state_r  ; 
  always @*
       begin  
          u_core__next_state_r   =  u_core__state_q  ;
         case (  u_core__state_q  ) 
           u_core__STATE_RX_IDLE   :
             begin 
               if (  u_core__token_valid_w  )
                  begin 
                    if (  u_core__token_pid_w  ==8'h69)
                       begin 
                         if (  u_core__ep_stall_r  ) 
                             u_core__next_state_r   =  u_core__STATE_TX_HANDSHAKE  ;
                          else 
                            if (  u_core__tx_ready_r  ) 
                                u_core__next_state_r   =  u_core__STATE_TX_DATA  ;
                             else  
                                u_core__next_state_r   =  u_core__STATE_TX_HANDSHAKE  ;
                       end 
                     else 
                       if (  u_core__token_pid_w  ==8'hB4)
                          begin  
                             u_core__next_state_r   =  u_core__STATE_TX_HANDSHAKE  ;
                          end 
                        else 
                          if (  u_core__token_pid_w  ==8'hE1)
                             begin 
                               if (  u_core__ep_stall_r  ) 
                                   u_core__next_state_r   =  u_core__STATE_RX_DATA_IGNORE  ;
                                else 
                                  if (  u_core__rx_space_r  ) 
                                      u_core__next_state_r   =  u_core__STATE_RX_DATA  ;
                                   else  
                                      u_core__next_state_r   =  u_core__STATE_RX_DATA_IGNORE  ;
                             end 
                           else 
                             if (  u_core__token_pid_w  ==8'h2D)
                                begin 
                                  if (  u_core__rx_space_r  ) 
                                      u_core__next_state_r   =  u_core__STATE_RX_DATA  ;
                                   else  
                                      u_core__next_state_r   =  u_core__STATE_RX_DATA_IGNORE  ;
                                end 
                  end 
                else 
                  if (  u_core__reg_chirp_en_i  ) 
                      u_core__next_state_r   =  u_core__STATE_TX_CHIRP  ;
             end  
           u_core__STATE_RX_DATA   :
             begin 
               if ((  u_core__token_pid_w  ==8'hC3&&  u_core__ep_data_bit_r  &&!  u_core__ep_iso_r  )||(  u_core__token_pid_w  ==8'h4B&&!  u_core__ep_data_bit_r  &&!  u_core__ep_iso_r  )) 
                   u_core__next_state_r   =  u_core__STATE_RX_DATA_IGNORE  ;
                else 
                  if (  u_core__rx_data_valid_w  &&  u_core__rx_last_o  ) 
                      u_core__next_state_r   =  u_core__STATE_RX_DATA_READY  ;
             end  
           u_core__STATE_RX_DATA_IGNORE   :
             begin 
               if (  u_core__rx_data_valid_w  &&  u_core__rx_last_o  ) 
                   u_core__next_state_r   =  u_core__STATE_RX_DATA_READY  ;
             end  
           u_core__STATE_RX_DATA_READY   :
             begin 
               if (  u_core__rx_data_complete_w  )
                  begin 
                    if (  u_core__rx_crc_err_o  ) 
                        u_core__next_state_r   =  u_core__STATE_RX_IDLE  ;
                     else 
                       if (  u_core__ep_iso_r  ) 
                           u_core__next_state_r   =  u_core__STATE_RX_IDLE  ;
                        else  
                           u_core__next_state_r   =  u_core__STATE_TX_HANDSHAKE  ;
                  end 
             end  
           u_core__STATE_TX_DATA   :
             begin 
               if (!  u_core__tx_valid_q  ||  u_core__tx_accept_w  )
                  if (  u_core__tx_data_valid_r  &&  u_core__tx_data_last_r  &&  u_core__tx_data_accept_w  ) 
                      u_core__next_state_r   =  u_core__STATE_TX_DATA_COMPLETE  ;
             end  
           u_core__STATE_TX_DATA_COMPLETE   :
             begin  
                u_core__next_state_r   =  u_core__STATE_RX_IDLE  ;
             end  
           u_core__STATE_TX_HANDSHAKE   :
             begin 
               if (  u_core__tx_accept_w  ) 
                   u_core__next_state_r   =  u_core__STATE_RX_IDLE  ;
             end  
           u_core__STATE_TX_CHIRP   :
             begin 
               if (!  u_core__reg_chirp_en_i  ) 
                   u_core__next_state_r   =  u_core__STATE_RX_IDLE  ;
             end 
          default :;
         endcase 
         if (  u_core__usb_rst_w  &&!  u_core__reg_chirp_en_i  ) 
             u_core__next_state_r   =  u_core__STATE_RX_IDLE  ;
       end
  
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__state_q   <=  u_core__STATE_RX_IDLE  ;
        else  
           u_core__state_q   <=  u_core__next_state_r  ;
 
   reg  u_core__tx_valid_r  ; 
   reg[7:0]  u_core__tx_pid_r  ; 
  always @*
       begin  
          u_core__tx_valid_r   =1'b0; 
          u_core__tx_pid_r   =8'b0;
         case (  u_core__state_q  ) 
           u_core__STATE_RX_IDLE   :
             begin 
               if (  u_core__token_valid_w  )
                  begin 
                    if (  u_core__token_pid_w  ==8'h69)
                       begin 
                         if (  u_core__ep_stall_r  )
                            begin  
                               u_core__tx_valid_r   =1'b1; 
                               u_core__tx_pid_r   =8'h1E;
                            end 
                          else 
                            if (  u_core__tx_ready_r  )
                               begin  
                                  u_core__tx_valid_r   =1'b1; 
                                  u_core__tx_pid_r   =  u_core__ep_data_bit_r   ? 8'h4B:8'hC3;
                               end 
                             else 
                               begin  
                                  u_core__tx_valid_r   =1'b1; 
                                  u_core__tx_pid_r   =8'h5A;
                               end 
                       end 
                     else 
                       if (  u_core__token_pid_w  ==8'hB4)
                          begin 
                            if (  u_core__ep_stall_r  )
                               begin  
                                  u_core__tx_valid_r   =1'b1; 
                                  u_core__tx_pid_r   =8'h1E;
                               end 
                             else 
                               if (  u_core__rx_space_r  )
                                  begin  
                                     u_core__tx_valid_r   =1'b1; 
                                     u_core__tx_pid_r   =8'hD2;
                                  end 
                                else 
                                  begin  
                                     u_core__tx_valid_r   =1'b1; 
                                     u_core__tx_pid_r   =8'h5A;
                                  end 
                          end 
                  end 
             end  
           u_core__STATE_RX_DATA_READY   :
             begin 
               if (  u_core__rx_data_complete_w  )
                  begin 
                    if (  u_core__rx_crc_err_o  );
                     else 
                       if (  u_core__ep_iso_r  );
                        else 
                          if (  u_core__ep_stall_r  )
                             begin  
                                u_core__tx_valid_r   =1'b1; 
                                u_core__tx_pid_r   =8'h1E;
                             end 
                           else 
                             if ((  u_core__token_pid_w  ==8'hC3&&  u_core__ep_data_bit_r  )||(  u_core__token_pid_w  ==8'h4B&&!  u_core__ep_data_bit_r  ))
                                begin  
                                   u_core__tx_valid_r   =1'b1; 
                                   u_core__tx_pid_r   =8'hD2;
                                end 
                              else 
                                if (!  u_core__rx_space_q  )
                                   begin  
                                      u_core__tx_valid_r   =1'b1; 
                                      u_core__tx_pid_r   =8'h5A;
                                   end 
                                 else 
                                   begin  
                                      u_core__tx_valid_r   =1'b1; 
                                      u_core__tx_pid_r   =8'hD2;
                                   end 
                  end 
             end  
           u_core__STATE_TX_CHIRP   :
             begin  
                u_core__tx_valid_r   =1'b1; 
                u_core__tx_pid_r   =8'b0;
             end 
          default :;
         endcase 
       end
  
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__tx_valid_q   <=1'b0;
        else 
          if (!  u_core__tx_valid_q  ||  u_core__tx_accept_w  ) 
              u_core__tx_valid_q   <=  u_core__tx_valid_r  ;
 
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__tx_pid_q   <=8'b0;
        else 
          if (!  u_core__tx_valid_q  ||  u_core__tx_accept_w  ) 
              u_core__tx_pid_q   <=  u_core__tx_pid_r  ;
 
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__rx_enable_q   <=1'b0;
        else 
          if (  u_core__usb_rst_w  ||  u_core__reg_chirp_en_i  ) 
              u_core__rx_enable_q   <=1'b0;
           else  
              u_core__rx_enable_q   <=(  u_core__state_q  ==  u_core__STATE_RX_DATA  );
 
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__rx_setup_q   <=1'b0;
        else 
          if (  u_core__usb_rst_w  ||  u_core__reg_chirp_en_i  ) 
              u_core__rx_setup_q   <=1'b0;
           else 
             if ((  u_core__state_q  ==  u_core__STATE_RX_IDLE  )&&  u_core__token_valid_w  &&(  u_core__token_pid_w  ==8'h2D)&&(  u_core__token_ep_w  ==4'd0)) 
                 u_core__rx_setup_q   <=1'b1;
              else  
                 u_core__rx_setup_q   <=1'b0;
 
   reg  u_core__addr_update_pending_q  ; 
   wire  u_core__ep0_tx_zlp_w  =  u_core__ep0_tx_data_valid_i  &&(  u_core__ep0_tx_data_strb_i  ==1'b0)&&  u_core__ep0_tx_data_last_i  &&  u_core__ep0_tx_data_accept_o  ; 
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__addr_update_pending_q   <=1'b0;
        else 
          if (  u_core__ep0_tx_zlp_w  ||  u_core__usb_rst_w  ) 
              u_core__addr_update_pending_q   <=1'b0;
           else 
             if (  u_core__reg_dev_addr_i  !=  u_core__current_addr_q  ) 
                 u_core__addr_update_pending_q   <=1'b1;
 
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__current_addr_q   <=7'b0;
        else 
          if (  u_core__usb_rst_w  ) 
              u_core__current_addr_q   <=7'b0;
           else 
             if (  u_core__ep0_tx_zlp_w  &&  u_core__addr_update_pending_q  ) 
                 u_core__current_addr_q   <=  u_core__reg_dev_addr_i  ;
 
   reg  u_core__ep0_dir_in_q  ; 
   reg  u_core__ep0_dir_out_q  ; 
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__ep0_dir_in_q   <=1'b0;
        else 
          if (  u_core__usb_rst_w  ||  u_core__reg_chirp_en_i  ) 
              u_core__ep0_dir_in_q   <=1'b0;
           else 
             if ((  u_core__state_q  ==  u_core__STATE_RX_IDLE  )&&  u_core__token_valid_w  &&(  u_core__token_pid_w  ==8'h2D)&&(  u_core__token_ep_w  ==4'd0)) 
                 u_core__ep0_dir_in_q   <=1'b0;
              else 
                if ((  u_core__state_q  ==  u_core__STATE_RX_IDLE  )&&  u_core__token_valid_w  &&(  u_core__token_pid_w  ==8'h69)&&(  u_core__token_ep_w  ==4'd0)) 
                    u_core__ep0_dir_in_q   <=1'b1;
 
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__ep0_dir_out_q   <=1'b0;
        else 
          if (  u_core__usb_rst_w  ||  u_core__reg_chirp_en_i  ) 
              u_core__ep0_dir_out_q   <=1'b0;
           else 
             if ((  u_core__state_q  ==  u_core__STATE_RX_IDLE  )&&  u_core__token_valid_w  &&(  u_core__token_pid_w  ==8'h2D)&&(  u_core__token_ep_w  ==4'd0)) 
                 u_core__ep0_dir_out_q   <=1'b0;
              else 
                if ((  u_core__state_q  ==  u_core__STATE_RX_IDLE  )&&  u_core__token_valid_w  &&(  u_core__token_pid_w  ==8'hE1)&&(  u_core__token_ep_w  ==4'd0)) 
                    u_core__ep0_dir_out_q   <=1'b1;
 
  assign   u_core__status_stage_w  =  u_core__ep0_dir_in_q  &&  u_core__ep0_dir_out_q  &&(  u_core__token_ep_w  ==4'd0); 
   reg  u_core__new_data_bit_r  ; 
  always @*
       begin  
          u_core__new_data_bit_r   =  u_core__ep_data_bit_r  ;
         case (  u_core__state_q  ) 
           u_core__STATE_RX_DATA_READY   :
             begin 
               if (  u_core__rx_data_complete_w  )
                  begin 
                    if (  u_core__rx_crc_err_o  );
                     else 
                       if (  u_core__ep_iso_r  );
                        else 
                          if (  u_core__ep_stall_r  );
                           else 
                             if ((  u_core__token_pid_w  ==8'hC3&&  u_core__ep_data_bit_r  )||(  u_core__token_pid_w  ==8'h4B&&!  u_core__ep_data_bit_r  ));
                              else 
                                if (!  u_core__rx_space_q  );
                                 else  
                                    u_core__new_data_bit_r   =!  u_core__ep_data_bit_r  ;
                  end 
             end  
           u_core__STATE_RX_IDLE   :
             begin 
               if (  u_core__token_valid_w  )
                  begin 
                    if (  u_core__token_pid_w  ==8'h2D) 
                        u_core__new_data_bit_r   =1'b0;
                  end 
                else 
                  if (  u_core__rx_handshake_w  &&  u_core__token_pid_w  ==8'hD2)
                     begin  
                        u_core__new_data_bit_r   =!  u_core__ep_data_bit_r  ;
                     end 
             end 
          default :;
         endcase 
       end
  
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__ep0_data_bit_q   <=1'b0;
        else 
          if (  u_core__usb_rst_w  ) 
              u_core__ep0_data_bit_q   <=1'b0;
           else 
             if (  u_core__token_ep_w  ==4'd0) 
                 u_core__ep0_data_bit_q   <=  u_core__new_data_bit_r  ;
 
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__ep1_data_bit_q   <=1'b0;
        else 
          if (  u_core__usb_rst_w  ) 
              u_core__ep1_data_bit_q   <=1'b0;
           else 
             if (  u_core__token_ep_w  ==4'd1) 
                 u_core__ep1_data_bit_q   <=  u_core__new_data_bit_r  ;
 
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__ep2_data_bit_q   <=1'b0;
        else 
          if (  u_core__usb_rst_w  ) 
              u_core__ep2_data_bit_q   <=1'b0;
           else 
             if (  u_core__token_ep_w  ==4'd2) 
                 u_core__ep2_data_bit_q   <=  u_core__new_data_bit_r  ;
 
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__ep3_data_bit_q   <=1'b0;
        else 
          if (  u_core__usb_rst_w  ) 
              u_core__ep3_data_bit_q   <=1'b0;
           else 
             if (  u_core__token_ep_w  ==4'd3) 
                 u_core__ep3_data_bit_q   <=  u_core__new_data_bit_r  ;
 
   reg  u_core__rst_event_q  ; 
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__rst_event_q   <=1'b0;
        else 
          if (  u_core__usb_rst_w  ) 
              u_core__rst_event_q   <=1'b1;
           else 
             if (  u_core__reg_sts_rst_clr_i  ) 
                 u_core__rst_event_q   <=1'b0;
 
  assign   u_core__reg_sts_rst_o  =  u_core__rst_event_q  ; 
   reg  u_core__intr_q  ; 
   reg  u_core__cfg_int_rx_r  ; 
   reg  u_core__cfg_int_tx_r  ; 
  always @*
       begin  
          u_core__cfg_int_rx_r   =1'b0; 
          u_core__cfg_int_tx_r   =1'b0;
         case (  u_core__token_ep_w  )
          4 'd0:
             begin  
                u_core__cfg_int_rx_r   =  u_core__ep0_cfg_int_rx_i  ; 
                u_core__cfg_int_tx_r   =  u_core__ep0_cfg_int_tx_i  ;
             end 
          4 'd1:
             begin  
                u_core__cfg_int_rx_r   =  u_core__ep1_cfg_int_rx_i  ; 
                u_core__cfg_int_tx_r   =  u_core__ep1_cfg_int_tx_i  ;
             end 
          4 'd2:
             begin  
                u_core__cfg_int_rx_r   =  u_core__ep2_cfg_int_rx_i  ; 
                u_core__cfg_int_tx_r   =  u_core__ep2_cfg_int_tx_i  ;
             end 
          4 'd3:
             begin  
                u_core__cfg_int_rx_r   =  u_core__ep3_cfg_int_rx_i  ; 
                u_core__cfg_int_tx_r   =  u_core__ep3_cfg_int_tx_i  ;
             end 
          default :;
         endcase 
       end
  
  always @(  posedge    u_core__clk_i          or  posedge   u_core__rst_i  )
       if (  u_core__rst_i  ) 
           u_core__intr_q   <=1'b0;
        else 
          if (  u_core__frame_valid_w  &&  u_core__reg_int_en_sof_i  ) 
              u_core__intr_q   <=1'b1;
           else 
             if (!  u_core__rst_event_q  &&  u_core__usb_rst_w  ) 
                 u_core__intr_q   <=1'b1;
              else 
                if (  u_core__state_q  ==  u_core__STATE_RX_DATA_READY  &&  u_core__rx_space_q  &&  u_core__cfg_int_rx_r  ) 
                    u_core__intr_q   <=1'b1;
                 else 
                   if (  u_core__state_q  ==  u_core__STATE_TX_DATA_COMPLETE  &&  u_core__cfg_int_tx_r  ) 
                       u_core__intr_q   <=1'b1;
                    else  
                       u_core__intr_q   <=1'b0;
 
  assign   u_core__intr_o  =  u_core__intr_q  ;
assign u_core__clk_i = clk_i;
assign u_core__rst_i = rst_i;
assign u_core__utmi_data_i = utmi_data_in_i;
assign u_core__utmi_txready_i = utmi_txready_i;
assign u_core__utmi_rxvalid_i = utmi_rxvalid_i;
assign u_core__utmi_rxactive_i = utmi_rxactive_i;
assign u_core__utmi_rxerror_i = utmi_rxerror_i;
assign u_core__utmi_linestate_i = utmi_linestate_i;
assign u_core__ep0_stall_i = usb_ep0_cfg_stall_ep_out_w;
assign u_core__ep0_iso_i = usb_ep0_cfg_iso_out_w;
assign u_core__ep0_cfg_int_rx_i = usb_ep0_cfg_int_rx_out_w;
assign u_core__ep0_cfg_int_tx_i = usb_ep0_cfg_int_tx_out_w;
assign u_core__ep0_rx_space_i = ep0_rx_space_w;
assign u_core__ep0_tx_ready_i = ep0_tx_ready_w;
assign u_core__ep0_tx_data_valid_i = ep0_tx_data_valid_w;
assign u_core__ep0_tx_data_strb_i = ep0_tx_data_strb_w;
assign u_core__ep0_tx_data_i = ep0_tx_data_w;
assign u_core__ep0_tx_data_last_i = ep0_tx_data_last_w;
assign u_core__ep1_stall_i = usb_ep1_cfg_stall_ep_out_w;
assign u_core__ep1_iso_i = usb_ep1_cfg_iso_out_w;
assign u_core__ep1_cfg_int_rx_i = usb_ep1_cfg_int_rx_out_w;
assign u_core__ep1_cfg_int_tx_i = usb_ep1_cfg_int_tx_out_w;
assign u_core__ep1_rx_space_i = ep1_rx_space_w;
assign u_core__ep1_tx_ready_i = ep1_tx_ready_w;
assign u_core__ep1_tx_data_valid_i = ep1_tx_data_valid_w;
assign u_core__ep1_tx_data_strb_i = ep1_tx_data_strb_w;
assign u_core__ep1_tx_data_i = ep1_tx_data_w;
assign u_core__ep1_tx_data_last_i = ep1_tx_data_last_w;
assign u_core__ep2_stall_i = usb_ep2_cfg_stall_ep_out_w;
assign u_core__ep2_iso_i = usb_ep2_cfg_iso_out_w;
assign u_core__ep2_cfg_int_rx_i = usb_ep2_cfg_int_rx_out_w;
assign u_core__ep2_cfg_int_tx_i = usb_ep2_cfg_int_tx_out_w;
assign u_core__ep2_rx_space_i = ep2_rx_space_w;
assign u_core__ep2_tx_ready_i = ep2_tx_ready_w;
assign u_core__ep2_tx_data_valid_i = ep2_tx_data_valid_w;
assign u_core__ep2_tx_data_strb_i = ep2_tx_data_strb_w;
assign u_core__ep2_tx_data_i = ep2_tx_data_w;
assign u_core__ep2_tx_data_last_i = ep2_tx_data_last_w;
assign u_core__ep3_stall_i = usb_ep3_cfg_stall_ep_out_w;
assign u_core__ep3_iso_i = usb_ep3_cfg_iso_out_w;
assign u_core__ep3_cfg_int_rx_i = usb_ep3_cfg_int_rx_out_w;
assign u_core__ep3_cfg_int_tx_i = usb_ep3_cfg_int_tx_out_w;
assign u_core__ep3_rx_space_i = ep3_rx_space_w;
assign u_core__ep3_tx_ready_i = ep3_tx_ready_w;
assign u_core__ep3_tx_data_valid_i = ep3_tx_data_valid_w;
assign u_core__ep3_tx_data_strb_i = ep3_tx_data_strb_w;
assign u_core__ep3_tx_data_i = ep3_tx_data_w;
assign u_core__ep3_tx_data_last_i = ep3_tx_data_last_w;
assign u_core__reg_chirp_en_i = usb_func_ctrl_hs_chirp_en_out_w;
assign u_core__reg_int_en_sof_i = usb_func_ctrl_int_en_sof_out_w;
assign u_core__reg_sts_rst_clr_i = stat_rst_clr_w&stat_wr_req_w;
assign u_core__reg_dev_addr_i = usb_func_addr_dev_addr_out_w;
assign intr_o = u_core__intr_o;
assign utmi_data_out_o = u_core__utmi_data_o;
assign utmi_txvalid_o = u_core__utmi_txvalid_o;
assign rx_strb_w = u_core__rx_strb_o;
assign rx_data_w = u_core__rx_data_o;
assign rx_last_w = u_core__rx_last_o;
assign rx_crc_err_w = u_core__rx_crc_err_o;
assign ep0_rx_setup_w = u_core__ep0_rx_setup_o;
assign ep0_rx_valid_w = u_core__ep0_rx_valid_o;
assign ep0_tx_data_accept_w = u_core__ep0_tx_data_accept_o;
assign ep1_rx_setup_w = u_core__ep1_rx_setup_o;
assign ep1_rx_valid_w = u_core__ep1_rx_valid_o;
assign ep1_tx_data_accept_w = u_core__ep1_tx_data_accept_o;
assign ep2_rx_setup_w = u_core__ep2_rx_setup_o;
assign ep2_rx_valid_w = u_core__ep2_rx_valid_o;
assign ep2_tx_data_accept_w = u_core__ep2_tx_data_accept_o;
assign ep3_rx_setup_w = u_core__ep3_rx_setup_o;
assign ep3_rx_valid_w = u_core__ep3_rx_valid_o;
assign ep3_tx_data_accept_w = u_core__ep3_tx_data_accept_o;
assign stat_rst_w = u_core__reg_sts_rst_o;
assign stat_frame_w = u_core__reg_sts_frame_num_o;
 
  assign usb_ep0_cfg_stall_ep_ack_in_w=ep0_rx_setup_w; 
  assign usb_ep1_cfg_stall_ep_ack_in_w=ep1_rx_setup_w; 
  assign usb_ep2_cfg_stall_ep_ack_in_w=ep2_rx_setup_w; 
  assign usb_ep3_cfg_stall_ep_ack_in_w=ep3_rx_setup_w; 
  
wire  u_fifo_rx_ep0__clk_i;
wire  u_fifo_rx_ep0__rst_i;
wire [7:0] u_fifo_rx_ep0__data_i;
wire  u_fifo_rx_ep0__push_i;
wire  u_fifo_rx_ep0__pop_i;
wire  u_fifo_rx_ep0__flush_i;
wire  u_fifo_rx_ep0__full_o;
wire  u_fifo_rx_ep0__empty_o;
wire [7:0] u_fifo_rx_ep0__data_o;
wire  u_fifo_tx_ep0__clk_i;
wire  u_fifo_tx_ep0__rst_i;
wire [7:0] u_fifo_tx_ep0__data_i;
wire  u_fifo_tx_ep0__push_i;
wire  u_fifo_tx_ep0__pop_i;
wire  u_fifo_tx_ep0__flush_i;
wire  u_fifo_tx_ep0__full_o;
wire  u_fifo_tx_ep0__empty_o;
wire [7:0] u_fifo_tx_ep0__data_o;
wire  u_fifo_rx_ep1__clk_i;
wire  u_fifo_rx_ep1__rst_i;
wire [7:0] u_fifo_rx_ep1__data_i;
wire  u_fifo_rx_ep1__push_i;
wire  u_fifo_rx_ep1__pop_i;
wire  u_fifo_rx_ep1__flush_i;
wire  u_fifo_rx_ep1__full_o;
wire  u_fifo_rx_ep1__empty_o;
wire [7:0] u_fifo_rx_ep1__data_o;
wire  u_fifo_tx_ep1__clk_i;
wire  u_fifo_tx_ep1__rst_i;
wire [7:0] u_fifo_tx_ep1__data_i;
wire  u_fifo_tx_ep1__push_i;
wire  u_fifo_tx_ep1__pop_i;
wire  u_fifo_tx_ep1__flush_i;
wire  u_fifo_tx_ep1__full_o;
wire  u_fifo_tx_ep1__empty_o;
wire [7:0] u_fifo_tx_ep1__data_o;
wire  u_fifo_rx_ep2__clk_i;
wire  u_fifo_rx_ep2__rst_i;
wire [7:0] u_fifo_rx_ep2__data_i;
wire  u_fifo_rx_ep2__push_i;
wire  u_fifo_rx_ep2__pop_i;
wire  u_fifo_rx_ep2__flush_i;
wire  u_fifo_rx_ep2__full_o;
wire  u_fifo_rx_ep2__empty_o;
wire [7:0] u_fifo_rx_ep2__data_o;
wire  u_fifo_tx_ep2__clk_i;
wire  u_fifo_tx_ep2__rst_i;
wire [7:0] u_fifo_tx_ep2__data_i;
wire  u_fifo_tx_ep2__push_i;
wire  u_fifo_tx_ep2__pop_i;
wire  u_fifo_tx_ep2__flush_i;
wire  u_fifo_tx_ep2__full_o;
wire  u_fifo_tx_ep2__empty_o;
wire [7:0] u_fifo_tx_ep2__data_o;
wire  u_fifo_rx_ep3__clk_i;
wire  u_fifo_rx_ep3__rst_i;
wire [7:0] u_fifo_rx_ep3__data_i;
wire  u_fifo_rx_ep3__push_i;
wire  u_fifo_rx_ep3__pop_i;
wire  u_fifo_rx_ep3__flush_i;
wire  u_fifo_rx_ep3__full_o;
wire  u_fifo_rx_ep3__empty_o;
wire [7:0] u_fifo_rx_ep3__data_o;
wire  u_fifo_tx_ep3__clk_i;
wire  u_fifo_tx_ep3__rst_i;
wire [7:0] u_fifo_tx_ep3__data_i;
wire  u_fifo_tx_ep3__push_i;
wire  u_fifo_tx_ep3__pop_i;
wire  u_fifo_tx_ep3__flush_i;
wire  u_fifo_tx_ep3__full_o;
wire  u_fifo_tx_ep3__empty_o;
wire [7:0] u_fifo_tx_ep3__data_o;
 localparam  u_fifo_rx_ep0__COUNT_W  =  u_fifo_rx_ep0__ADDR_W  +1; 
   reg[  u_fifo_rx_ep0__WIDTH  -1:0]  u_fifo_rx_ep0__ram  [  u_fifo_rx_ep0__DEPTH  -1:0]; 
   reg[  u_fifo_rx_ep0__ADDR_W  -1:0]  u_fifo_rx_ep0__rd_ptr  ; 
   reg[  u_fifo_rx_ep0__ADDR_W  -1:0]  u_fifo_rx_ep0__wr_ptr  ; 
   reg[  u_fifo_rx_ep0__COUNT_W  -1:0]  u_fifo_rx_ep0__count  ; 
  always @(  posedge    u_fifo_rx_ep0__clk_i          or  posedge   u_fifo_rx_ep0__rst_i  )
       if (  u_fifo_rx_ep0__rst_i  )
          begin  
             u_fifo_rx_ep0__count   <={(  u_fifo_rx_ep0__COUNT_W  ){1'b0}}; 
             u_fifo_rx_ep0__rd_ptr   <={(  u_fifo_rx_ep0__ADDR_W  ){1'b0}}; 
             u_fifo_rx_ep0__wr_ptr   <={(  u_fifo_rx_ep0__ADDR_W  ){1'b0}};
          end 
        else 
          begin 
            if (  u_fifo_rx_ep0__flush_i  )
               begin  
                  u_fifo_rx_ep0__count   <={(  u_fifo_rx_ep0__COUNT_W  ){1'b0}}; 
                  u_fifo_rx_ep0__rd_ptr   <={(  u_fifo_rx_ep0__ADDR_W  ){1'b0}}; 
                  u_fifo_rx_ep0__wr_ptr   <={(  u_fifo_rx_ep0__ADDR_W  ){1'b0}};
               end 
            if (  u_fifo_rx_ep0__push_i  &~  u_fifo_rx_ep0__full_o  )
               begin  
                  u_fifo_rx_ep0__ram   [  u_fifo_rx_ep0__wr_ptr  ]<=  u_fifo_rx_ep0__data_i  ; 
                  u_fifo_rx_ep0__wr_ptr   <=  u_fifo_rx_ep0__wr_ptr  +1;
               end 
            if (  u_fifo_rx_ep0__pop_i  &~  u_fifo_rx_ep0__empty_o  )
               begin  
                  u_fifo_rx_ep0__rd_ptr   <=  u_fifo_rx_ep0__rd_ptr  +1;
               end 
            if ((  u_fifo_rx_ep0__push_i  &~  u_fifo_rx_ep0__full_o  )&~(  u_fifo_rx_ep0__pop_i  &~  u_fifo_rx_ep0__empty_o  ))
               begin  
                  u_fifo_rx_ep0__count   <=  u_fifo_rx_ep0__count  +1;
               end 
             else 
               if (~(  u_fifo_rx_ep0__push_i  &~  u_fifo_rx_ep0__full_o  )&(  u_fifo_rx_ep0__pop_i  &~  u_fifo_rx_ep0__empty_o  ))
                  begin  
                     u_fifo_rx_ep0__count   <=  u_fifo_rx_ep0__count  -1;
                  end 
          end
  
  assign   u_fifo_rx_ep0__full_o  =(  u_fifo_rx_ep0__count  ==  u_fifo_rx_ep0__DEPTH  ); 
  assign   u_fifo_rx_ep0__empty_o  =(  u_fifo_rx_ep0__count  ==0); 
  assign   u_fifo_rx_ep0__data_o  =  u_fifo_rx_ep0__ram  [  u_fifo_rx_ep0__rd_ptr  ];
 
  
 localparam  u_fifo_tx_ep0__COUNT_W  =  u_fifo_tx_ep0__ADDR_W  +1; 
   reg[  u_fifo_tx_ep0__WIDTH  -1:0]  u_fifo_tx_ep0__ram  [  u_fifo_tx_ep0__DEPTH  -1:0]; 
   reg[  u_fifo_tx_ep0__ADDR_W  -1:0]  u_fifo_tx_ep0__rd_ptr  ; 
   reg[  u_fifo_tx_ep0__ADDR_W  -1:0]  u_fifo_tx_ep0__wr_ptr  ; 
   reg[  u_fifo_tx_ep0__COUNT_W  -1:0]  u_fifo_tx_ep0__count  ; 
  always @(  posedge    u_fifo_tx_ep0__clk_i          or  posedge   u_fifo_tx_ep0__rst_i  )
       if (  u_fifo_tx_ep0__rst_i  )
          begin  
             u_fifo_tx_ep0__count   <={(  u_fifo_tx_ep0__COUNT_W  ){1'b0}}; 
             u_fifo_tx_ep0__rd_ptr   <={(  u_fifo_tx_ep0__ADDR_W  ){1'b0}}; 
             u_fifo_tx_ep0__wr_ptr   <={(  u_fifo_tx_ep0__ADDR_W  ){1'b0}};
          end 
        else 
          begin 
            if (  u_fifo_tx_ep0__flush_i  )
               begin  
                  u_fifo_tx_ep0__count   <={(  u_fifo_tx_ep0__COUNT_W  ){1'b0}}; 
                  u_fifo_tx_ep0__rd_ptr   <={(  u_fifo_tx_ep0__ADDR_W  ){1'b0}}; 
                  u_fifo_tx_ep0__wr_ptr   <={(  u_fifo_tx_ep0__ADDR_W  ){1'b0}};
               end 
            if (  u_fifo_tx_ep0__push_i  &~  u_fifo_tx_ep0__full_o  )
               begin  
                  u_fifo_tx_ep0__ram   [  u_fifo_tx_ep0__wr_ptr  ]<=  u_fifo_tx_ep0__data_i  ; 
                  u_fifo_tx_ep0__wr_ptr   <=  u_fifo_tx_ep0__wr_ptr  +1;
               end 
            if (  u_fifo_tx_ep0__pop_i  &~  u_fifo_tx_ep0__empty_o  )
               begin  
                  u_fifo_tx_ep0__rd_ptr   <=  u_fifo_tx_ep0__rd_ptr  +1;
               end 
            if ((  u_fifo_tx_ep0__push_i  &~  u_fifo_tx_ep0__full_o  )&~(  u_fifo_tx_ep0__pop_i  &~  u_fifo_tx_ep0__empty_o  ))
               begin  
                  u_fifo_tx_ep0__count   <=  u_fifo_tx_ep0__count  +1;
               end 
             else 
               if (~(  u_fifo_tx_ep0__push_i  &~  u_fifo_tx_ep0__full_o  )&(  u_fifo_tx_ep0__pop_i  &~  u_fifo_tx_ep0__empty_o  ))
                  begin  
                     u_fifo_tx_ep0__count   <=  u_fifo_tx_ep0__count  -1;
                  end 
          end
  
  assign   u_fifo_tx_ep0__full_o  =(  u_fifo_tx_ep0__count  ==  u_fifo_tx_ep0__DEPTH  ); 
  assign   u_fifo_tx_ep0__empty_o  =(  u_fifo_tx_ep0__count  ==0); 
  assign   u_fifo_tx_ep0__data_o  =  u_fifo_tx_ep0__ram  [  u_fifo_tx_ep0__rd_ptr  ];
 
  
 localparam  u_fifo_rx_ep1__COUNT_W  =  u_fifo_rx_ep1__ADDR_W  +1; 
   reg[  u_fifo_rx_ep1__WIDTH  -1:0]  u_fifo_rx_ep1__ram  [  u_fifo_rx_ep1__DEPTH  -1:0]; 
   reg[  u_fifo_rx_ep1__ADDR_W  -1:0]  u_fifo_rx_ep1__rd_ptr  ; 
   reg[  u_fifo_rx_ep1__ADDR_W  -1:0]  u_fifo_rx_ep1__wr_ptr  ; 
   reg[  u_fifo_rx_ep1__COUNT_W  -1:0]  u_fifo_rx_ep1__count  ; 
  always @(  posedge    u_fifo_rx_ep1__clk_i          or  posedge   u_fifo_rx_ep1__rst_i  )
       if (  u_fifo_rx_ep1__rst_i  )
          begin  
             u_fifo_rx_ep1__count   <={(  u_fifo_rx_ep1__COUNT_W  ){1'b0}}; 
             u_fifo_rx_ep1__rd_ptr   <={(  u_fifo_rx_ep1__ADDR_W  ){1'b0}}; 
             u_fifo_rx_ep1__wr_ptr   <={(  u_fifo_rx_ep1__ADDR_W  ){1'b0}};
          end 
        else 
          begin 
            if (  u_fifo_rx_ep1__flush_i  )
               begin  
                  u_fifo_rx_ep1__count   <={(  u_fifo_rx_ep1__COUNT_W  ){1'b0}}; 
                  u_fifo_rx_ep1__rd_ptr   <={(  u_fifo_rx_ep1__ADDR_W  ){1'b0}}; 
                  u_fifo_rx_ep1__wr_ptr   <={(  u_fifo_rx_ep1__ADDR_W  ){1'b0}};
               end 
            if (  u_fifo_rx_ep1__push_i  &~  u_fifo_rx_ep1__full_o  )
               begin  
                  u_fifo_rx_ep1__ram   [  u_fifo_rx_ep1__wr_ptr  ]<=  u_fifo_rx_ep1__data_i  ; 
                  u_fifo_rx_ep1__wr_ptr   <=  u_fifo_rx_ep1__wr_ptr  +1;
               end 
            if (  u_fifo_rx_ep1__pop_i  &~  u_fifo_rx_ep1__empty_o  )
               begin  
                  u_fifo_rx_ep1__rd_ptr   <=  u_fifo_rx_ep1__rd_ptr  +1;
               end 
            if ((  u_fifo_rx_ep1__push_i  &~  u_fifo_rx_ep1__full_o  )&~(  u_fifo_rx_ep1__pop_i  &~  u_fifo_rx_ep1__empty_o  ))
               begin  
                  u_fifo_rx_ep1__count   <=  u_fifo_rx_ep1__count  +1;
               end 
             else 
               if (~(  u_fifo_rx_ep1__push_i  &~  u_fifo_rx_ep1__full_o  )&(  u_fifo_rx_ep1__pop_i  &~  u_fifo_rx_ep1__empty_o  ))
                  begin  
                     u_fifo_rx_ep1__count   <=  u_fifo_rx_ep1__count  -1;
                  end 
          end
  
  assign   u_fifo_rx_ep1__full_o  =(  u_fifo_rx_ep1__count  ==  u_fifo_rx_ep1__DEPTH  ); 
  assign   u_fifo_rx_ep1__empty_o  =(  u_fifo_rx_ep1__count  ==0); 
  assign   u_fifo_rx_ep1__data_o  =  u_fifo_rx_ep1__ram  [  u_fifo_rx_ep1__rd_ptr  ];
 
  
 localparam  u_fifo_tx_ep1__COUNT_W  =  u_fifo_tx_ep1__ADDR_W  +1; 
   reg[  u_fifo_tx_ep1__WIDTH  -1:0]  u_fifo_tx_ep1__ram  [  u_fifo_tx_ep1__DEPTH  -1:0]; 
   reg[  u_fifo_tx_ep1__ADDR_W  -1:0]  u_fifo_tx_ep1__rd_ptr  ; 
   reg[  u_fifo_tx_ep1__ADDR_W  -1:0]  u_fifo_tx_ep1__wr_ptr  ; 
   reg[  u_fifo_tx_ep1__COUNT_W  -1:0]  u_fifo_tx_ep1__count  ; 
  always @(  posedge    u_fifo_tx_ep1__clk_i          or  posedge   u_fifo_tx_ep1__rst_i  )
       if (  u_fifo_tx_ep1__rst_i  )
          begin  
             u_fifo_tx_ep1__count   <={(  u_fifo_tx_ep1__COUNT_W  ){1'b0}}; 
             u_fifo_tx_ep1__rd_ptr   <={(  u_fifo_tx_ep1__ADDR_W  ){1'b0}}; 
             u_fifo_tx_ep1__wr_ptr   <={(  u_fifo_tx_ep1__ADDR_W  ){1'b0}};
          end 
        else 
          begin 
            if (  u_fifo_tx_ep1__flush_i  )
               begin  
                  u_fifo_tx_ep1__count   <={(  u_fifo_tx_ep1__COUNT_W  ){1'b0}}; 
                  u_fifo_tx_ep1__rd_ptr   <={(  u_fifo_tx_ep1__ADDR_W  ){1'b0}}; 
                  u_fifo_tx_ep1__wr_ptr   <={(  u_fifo_tx_ep1__ADDR_W  ){1'b0}};
               end 
            if (  u_fifo_tx_ep1__push_i  &~  u_fifo_tx_ep1__full_o  )
               begin  
                  u_fifo_tx_ep1__ram   [  u_fifo_tx_ep1__wr_ptr  ]<=  u_fifo_tx_ep1__data_i  ; 
                  u_fifo_tx_ep1__wr_ptr   <=  u_fifo_tx_ep1__wr_ptr  +1;
               end 
            if (  u_fifo_tx_ep1__pop_i  &~  u_fifo_tx_ep1__empty_o  )
               begin  
                  u_fifo_tx_ep1__rd_ptr   <=  u_fifo_tx_ep1__rd_ptr  +1;
               end 
            if ((  u_fifo_tx_ep1__push_i  &~  u_fifo_tx_ep1__full_o  )&~(  u_fifo_tx_ep1__pop_i  &~  u_fifo_tx_ep1__empty_o  ))
               begin  
                  u_fifo_tx_ep1__count   <=  u_fifo_tx_ep1__count  +1;
               end 
             else 
               if (~(  u_fifo_tx_ep1__push_i  &~  u_fifo_tx_ep1__full_o  )&(  u_fifo_tx_ep1__pop_i  &~  u_fifo_tx_ep1__empty_o  ))
                  begin  
                     u_fifo_tx_ep1__count   <=  u_fifo_tx_ep1__count  -1;
                  end 
          end
  
  assign   u_fifo_tx_ep1__full_o  =(  u_fifo_tx_ep1__count  ==  u_fifo_tx_ep1__DEPTH  ); 
  assign   u_fifo_tx_ep1__empty_o  =(  u_fifo_tx_ep1__count  ==0); 
  assign   u_fifo_tx_ep1__data_o  =  u_fifo_tx_ep1__ram  [  u_fifo_tx_ep1__rd_ptr  ];
 
  
 localparam  u_fifo_rx_ep2__COUNT_W  =  u_fifo_rx_ep2__ADDR_W  +1; 
   reg[  u_fifo_rx_ep2__WIDTH  -1:0]  u_fifo_rx_ep2__ram  [  u_fifo_rx_ep2__DEPTH  -1:0]; 
   reg[  u_fifo_rx_ep2__ADDR_W  -1:0]  u_fifo_rx_ep2__rd_ptr  ; 
   reg[  u_fifo_rx_ep2__ADDR_W  -1:0]  u_fifo_rx_ep2__wr_ptr  ; 
   reg[  u_fifo_rx_ep2__COUNT_W  -1:0]  u_fifo_rx_ep2__count  ; 
  always @(  posedge    u_fifo_rx_ep2__clk_i          or  posedge   u_fifo_rx_ep2__rst_i  )
       if (  u_fifo_rx_ep2__rst_i  )
          begin  
             u_fifo_rx_ep2__count   <={(  u_fifo_rx_ep2__COUNT_W  ){1'b0}}; 
             u_fifo_rx_ep2__rd_ptr   <={(  u_fifo_rx_ep2__ADDR_W  ){1'b0}}; 
             u_fifo_rx_ep2__wr_ptr   <={(  u_fifo_rx_ep2__ADDR_W  ){1'b0}};
          end 
        else 
          begin 
            if (  u_fifo_rx_ep2__flush_i  )
               begin  
                  u_fifo_rx_ep2__count   <={(  u_fifo_rx_ep2__COUNT_W  ){1'b0}}; 
                  u_fifo_rx_ep2__rd_ptr   <={(  u_fifo_rx_ep2__ADDR_W  ){1'b0}}; 
                  u_fifo_rx_ep2__wr_ptr   <={(  u_fifo_rx_ep2__ADDR_W  ){1'b0}};
               end 
            if (  u_fifo_rx_ep2__push_i  &~  u_fifo_rx_ep2__full_o  )
               begin  
                  u_fifo_rx_ep2__ram   [  u_fifo_rx_ep2__wr_ptr  ]<=  u_fifo_rx_ep2__data_i  ; 
                  u_fifo_rx_ep2__wr_ptr   <=  u_fifo_rx_ep2__wr_ptr  +1;
               end 
            if (  u_fifo_rx_ep2__pop_i  &~  u_fifo_rx_ep2__empty_o  )
               begin  
                  u_fifo_rx_ep2__rd_ptr   <=  u_fifo_rx_ep2__rd_ptr  +1;
               end 
            if ((  u_fifo_rx_ep2__push_i  &~  u_fifo_rx_ep2__full_o  )&~(  u_fifo_rx_ep2__pop_i  &~  u_fifo_rx_ep2__empty_o  ))
               begin  
                  u_fifo_rx_ep2__count   <=  u_fifo_rx_ep2__count  +1;
               end 
             else 
               if (~(  u_fifo_rx_ep2__push_i  &~  u_fifo_rx_ep2__full_o  )&(  u_fifo_rx_ep2__pop_i  &~  u_fifo_rx_ep2__empty_o  ))
                  begin  
                     u_fifo_rx_ep2__count   <=  u_fifo_rx_ep2__count  -1;
                  end 
          end
  
  assign   u_fifo_rx_ep2__full_o  =(  u_fifo_rx_ep2__count  ==  u_fifo_rx_ep2__DEPTH  ); 
  assign   u_fifo_rx_ep2__empty_o  =(  u_fifo_rx_ep2__count  ==0); 
  assign   u_fifo_rx_ep2__data_o  =  u_fifo_rx_ep2__ram  [  u_fifo_rx_ep2__rd_ptr  ];
 
  
 localparam  u_fifo_tx_ep2__COUNT_W  =  u_fifo_tx_ep2__ADDR_W  +1; 
   reg[  u_fifo_tx_ep2__WIDTH  -1:0]  u_fifo_tx_ep2__ram  [  u_fifo_tx_ep2__DEPTH  -1:0]; 
   reg[  u_fifo_tx_ep2__ADDR_W  -1:0]  u_fifo_tx_ep2__rd_ptr  ; 
   reg[  u_fifo_tx_ep2__ADDR_W  -1:0]  u_fifo_tx_ep2__wr_ptr  ; 
   reg[  u_fifo_tx_ep2__COUNT_W  -1:0]  u_fifo_tx_ep2__count  ; 
  always @(  posedge    u_fifo_tx_ep2__clk_i          or  posedge   u_fifo_tx_ep2__rst_i  )
       if (  u_fifo_tx_ep2__rst_i  )
          begin  
             u_fifo_tx_ep2__count   <={(  u_fifo_tx_ep2__COUNT_W  ){1'b0}}; 
             u_fifo_tx_ep2__rd_ptr   <={(  u_fifo_tx_ep2__ADDR_W  ){1'b0}}; 
             u_fifo_tx_ep2__wr_ptr   <={(  u_fifo_tx_ep2__ADDR_W  ){1'b0}};
          end 
        else 
          begin 
            if (  u_fifo_tx_ep2__flush_i  )
               begin  
                  u_fifo_tx_ep2__count   <={(  u_fifo_tx_ep2__COUNT_W  ){1'b0}}; 
                  u_fifo_tx_ep2__rd_ptr   <={(  u_fifo_tx_ep2__ADDR_W  ){1'b0}}; 
                  u_fifo_tx_ep2__wr_ptr   <={(  u_fifo_tx_ep2__ADDR_W  ){1'b0}};
               end 
            if (  u_fifo_tx_ep2__push_i  &~  u_fifo_tx_ep2__full_o  )
               begin  
                  u_fifo_tx_ep2__ram   [  u_fifo_tx_ep2__wr_ptr  ]<=  u_fifo_tx_ep2__data_i  ; 
                  u_fifo_tx_ep2__wr_ptr   <=  u_fifo_tx_ep2__wr_ptr  +1;
               end 
            if (  u_fifo_tx_ep2__pop_i  &~  u_fifo_tx_ep2__empty_o  )
               begin  
                  u_fifo_tx_ep2__rd_ptr   <=  u_fifo_tx_ep2__rd_ptr  +1;
               end 
            if ((  u_fifo_tx_ep2__push_i  &~  u_fifo_tx_ep2__full_o  )&~(  u_fifo_tx_ep2__pop_i  &~  u_fifo_tx_ep2__empty_o  ))
               begin  
                  u_fifo_tx_ep2__count   <=  u_fifo_tx_ep2__count  +1;
               end 
             else 
               if (~(  u_fifo_tx_ep2__push_i  &~  u_fifo_tx_ep2__full_o  )&(  u_fifo_tx_ep2__pop_i  &~  u_fifo_tx_ep2__empty_o  ))
                  begin  
                     u_fifo_tx_ep2__count   <=  u_fifo_tx_ep2__count  -1;
                  end 
          end
  
  assign   u_fifo_tx_ep2__full_o  =(  u_fifo_tx_ep2__count  ==  u_fifo_tx_ep2__DEPTH  ); 
  assign   u_fifo_tx_ep2__empty_o  =(  u_fifo_tx_ep2__count  ==0); 
  assign   u_fifo_tx_ep2__data_o  =  u_fifo_tx_ep2__ram  [  u_fifo_tx_ep2__rd_ptr  ];
 
  
 localparam  u_fifo_rx_ep3__COUNT_W  =  u_fifo_rx_ep3__ADDR_W  +1; 
   reg[  u_fifo_rx_ep3__WIDTH  -1:0]  u_fifo_rx_ep3__ram  [  u_fifo_rx_ep3__DEPTH  -1:0]; 
   reg[  u_fifo_rx_ep3__ADDR_W  -1:0]  u_fifo_rx_ep3__rd_ptr  ; 
   reg[  u_fifo_rx_ep3__ADDR_W  -1:0]  u_fifo_rx_ep3__wr_ptr  ; 
   reg[  u_fifo_rx_ep3__COUNT_W  -1:0]  u_fifo_rx_ep3__count  ; 
  always @(  posedge    u_fifo_rx_ep3__clk_i          or  posedge   u_fifo_rx_ep3__rst_i  )
       if (  u_fifo_rx_ep3__rst_i  )
          begin  
             u_fifo_rx_ep3__count   <={(  u_fifo_rx_ep3__COUNT_W  ){1'b0}}; 
             u_fifo_rx_ep3__rd_ptr   <={(  u_fifo_rx_ep3__ADDR_W  ){1'b0}}; 
             u_fifo_rx_ep3__wr_ptr   <={(  u_fifo_rx_ep3__ADDR_W  ){1'b0}};
          end 
        else 
          begin 
            if (  u_fifo_rx_ep3__flush_i  )
               begin  
                  u_fifo_rx_ep3__count   <={(  u_fifo_rx_ep3__COUNT_W  ){1'b0}}; 
                  u_fifo_rx_ep3__rd_ptr   <={(  u_fifo_rx_ep3__ADDR_W  ){1'b0}}; 
                  u_fifo_rx_ep3__wr_ptr   <={(  u_fifo_rx_ep3__ADDR_W  ){1'b0}};
               end 
            if (  u_fifo_rx_ep3__push_i  &~  u_fifo_rx_ep3__full_o  )
               begin  
                  u_fifo_rx_ep3__ram   [  u_fifo_rx_ep3__wr_ptr  ]<=  u_fifo_rx_ep3__data_i  ; 
                  u_fifo_rx_ep3__wr_ptr   <=  u_fifo_rx_ep3__wr_ptr  +1;
               end 
            if (  u_fifo_rx_ep3__pop_i  &~  u_fifo_rx_ep3__empty_o  )
               begin  
                  u_fifo_rx_ep3__rd_ptr   <=  u_fifo_rx_ep3__rd_ptr  +1;
               end 
            if ((  u_fifo_rx_ep3__push_i  &~  u_fifo_rx_ep3__full_o  )&~(  u_fifo_rx_ep3__pop_i  &~  u_fifo_rx_ep3__empty_o  ))
               begin  
                  u_fifo_rx_ep3__count   <=  u_fifo_rx_ep3__count  +1;
               end 
             else 
               if (~(  u_fifo_rx_ep3__push_i  &~  u_fifo_rx_ep3__full_o  )&(  u_fifo_rx_ep3__pop_i  &~  u_fifo_rx_ep3__empty_o  ))
                  begin  
                     u_fifo_rx_ep3__count   <=  u_fifo_rx_ep3__count  -1;
                  end 
          end
  
  assign   u_fifo_rx_ep3__full_o  =(  u_fifo_rx_ep3__count  ==  u_fifo_rx_ep3__DEPTH  ); 
  assign   u_fifo_rx_ep3__empty_o  =(  u_fifo_rx_ep3__count  ==0); 
  assign   u_fifo_rx_ep3__data_o  =  u_fifo_rx_ep3__ram  [  u_fifo_rx_ep3__rd_ptr  ];
 
  
 localparam  u_fifo_tx_ep3__COUNT_W  =  u_fifo_tx_ep3__ADDR_W  +1; 
   reg[  u_fifo_tx_ep3__WIDTH  -1:0]  u_fifo_tx_ep3__ram  [  u_fifo_tx_ep3__DEPTH  -1:0]; 
   reg[  u_fifo_tx_ep3__ADDR_W  -1:0]  u_fifo_tx_ep3__rd_ptr  ; 
   reg[  u_fifo_tx_ep3__ADDR_W  -1:0]  u_fifo_tx_ep3__wr_ptr  ; 
   reg[  u_fifo_tx_ep3__COUNT_W  -1:0]  u_fifo_tx_ep3__count  ; 
  always @(  posedge    u_fifo_tx_ep3__clk_i          or  posedge   u_fifo_tx_ep3__rst_i  )
       if (  u_fifo_tx_ep3__rst_i  )
          begin  
             u_fifo_tx_ep3__count   <={(  u_fifo_tx_ep3__COUNT_W  ){1'b0}}; 
             u_fifo_tx_ep3__rd_ptr   <={(  u_fifo_tx_ep3__ADDR_W  ){1'b0}}; 
             u_fifo_tx_ep3__wr_ptr   <={(  u_fifo_tx_ep3__ADDR_W  ){1'b0}};
          end 
        else 
          begin 
            if (  u_fifo_tx_ep3__flush_i  )
               begin  
                  u_fifo_tx_ep3__count   <={(  u_fifo_tx_ep3__COUNT_W  ){1'b0}}; 
                  u_fifo_tx_ep3__rd_ptr   <={(  u_fifo_tx_ep3__ADDR_W  ){1'b0}}; 
                  u_fifo_tx_ep3__wr_ptr   <={(  u_fifo_tx_ep3__ADDR_W  ){1'b0}};
               end 
            if (  u_fifo_tx_ep3__push_i  &~  u_fifo_tx_ep3__full_o  )
               begin  
                  u_fifo_tx_ep3__ram   [  u_fifo_tx_ep3__wr_ptr  ]<=  u_fifo_tx_ep3__data_i  ; 
                  u_fifo_tx_ep3__wr_ptr   <=  u_fifo_tx_ep3__wr_ptr  +1;
               end 
            if (  u_fifo_tx_ep3__pop_i  &~  u_fifo_tx_ep3__empty_o  )
               begin  
                  u_fifo_tx_ep3__rd_ptr   <=  u_fifo_tx_ep3__rd_ptr  +1;
               end 
            if ((  u_fifo_tx_ep3__push_i  &~  u_fifo_tx_ep3__full_o  )&~(  u_fifo_tx_ep3__pop_i  &~  u_fifo_tx_ep3__empty_o  ))
               begin  
                  u_fifo_tx_ep3__count   <=  u_fifo_tx_ep3__count  +1;
               end 
             else 
               if (~(  u_fifo_tx_ep3__push_i  &~  u_fifo_tx_ep3__full_o  )&(  u_fifo_tx_ep3__pop_i  &~  u_fifo_tx_ep3__empty_o  ))
                  begin  
                     u_fifo_tx_ep3__count   <=  u_fifo_tx_ep3__count  -1;
                  end 
          end
  
  assign   u_fifo_tx_ep3__full_o  =(  u_fifo_tx_ep3__count  ==  u_fifo_tx_ep3__DEPTH  ); 
  assign   u_fifo_tx_ep3__empty_o  =(  u_fifo_tx_ep3__count  ==0); 
  assign   u_fifo_tx_ep3__data_o  =  u_fifo_tx_ep3__ram  [  u_fifo_tx_ep3__rd_ptr  ];
assign u_fifo_rx_ep0__clk_i = clk_i;
assign u_fifo_rx_ep0__rst_i = rst_i;
assign u_fifo_rx_ep0__data_i = usb_ep0_rx_data_w;
assign u_fifo_rx_ep0__push_i = usb_ep0_rx_wr_w;
assign u_fifo_rx_ep0__pop_i = usb_ep0_data_rd_req_w;
assign u_fifo_rx_ep0__flush_i = usb_ep0_rx_ctrl_rx_flush_out_w;
assign usb_ep0_rx_full_w = u_fifo_rx_ep0__full_o;
assign usb_ep0_data_data_in_w = u_fifo_rx_ep0__data_o;
assign u_fifo_tx_ep0__clk_i = clk_i;
assign u_fifo_tx_ep0__rst_i = rst_i;
assign u_fifo_tx_ep0__data_i = usb_ep0_data_data_out_w;
assign u_fifo_tx_ep0__push_i = usb_ep0_data_wr_req_w;
assign u_fifo_tx_ep0__pop_i = usb_ep0_tx_rd_w;
assign u_fifo_tx_ep0__flush_i = usb_ep0_tx_ctrl_tx_flush_out_w;
assign usb_ep0_tx_empty_w = u_fifo_tx_ep0__empty_o;
assign usb_ep0_tx_data_w = u_fifo_tx_ep0__data_o;
assign u_fifo_rx_ep1__clk_i = clk_i;
assign u_fifo_rx_ep1__rst_i = rst_i;
assign u_fifo_rx_ep1__data_i = usb_ep1_rx_data_w;
assign u_fifo_rx_ep1__push_i = usb_ep1_rx_wr_w;
assign u_fifo_rx_ep1__pop_i = usb_ep1_data_rd_req_w;
assign u_fifo_rx_ep1__flush_i = usb_ep1_rx_ctrl_rx_flush_out_w;
assign usb_ep1_rx_full_w = u_fifo_rx_ep1__full_o;
assign usb_ep1_data_data_in_w = u_fifo_rx_ep1__data_o;
assign u_fifo_tx_ep1__clk_i = clk_i;
assign u_fifo_tx_ep1__rst_i = rst_i;
assign u_fifo_tx_ep1__data_i = usb_ep1_data_data_out_w;
assign u_fifo_tx_ep1__push_i = usb_ep1_data_wr_req_w;
assign u_fifo_tx_ep1__pop_i = usb_ep1_tx_rd_w;
assign u_fifo_tx_ep1__flush_i = usb_ep1_tx_ctrl_tx_flush_out_w;
assign usb_ep1_tx_empty_w = u_fifo_tx_ep1__empty_o;
assign usb_ep1_tx_data_w = u_fifo_tx_ep1__data_o;
assign u_fifo_rx_ep2__clk_i = clk_i;
assign u_fifo_rx_ep2__rst_i = rst_i;
assign u_fifo_rx_ep2__data_i = usb_ep2_rx_data_w;
assign u_fifo_rx_ep2__push_i = usb_ep2_rx_wr_w;
assign u_fifo_rx_ep2__pop_i = usb_ep2_data_rd_req_w;
assign u_fifo_rx_ep2__flush_i = usb_ep2_rx_ctrl_rx_flush_out_w;
assign usb_ep2_rx_full_w = u_fifo_rx_ep2__full_o;
assign usb_ep2_data_data_in_w = u_fifo_rx_ep2__data_o;
assign u_fifo_tx_ep2__clk_i = clk_i;
assign u_fifo_tx_ep2__rst_i = rst_i;
assign u_fifo_tx_ep2__data_i = usb_ep2_data_data_out_w;
assign u_fifo_tx_ep2__push_i = usb_ep2_data_wr_req_w;
assign u_fifo_tx_ep2__pop_i = usb_ep2_tx_rd_w;
assign u_fifo_tx_ep2__flush_i = usb_ep2_tx_ctrl_tx_flush_out_w;
assign usb_ep2_tx_empty_w = u_fifo_tx_ep2__empty_o;
assign usb_ep2_tx_data_w = u_fifo_tx_ep2__data_o;
assign u_fifo_rx_ep3__clk_i = clk_i;
assign u_fifo_rx_ep3__rst_i = rst_i;
assign u_fifo_rx_ep3__data_i = usb_ep3_rx_data_w;
assign u_fifo_rx_ep3__push_i = usb_ep3_rx_wr_w;
assign u_fifo_rx_ep3__pop_i = usb_ep3_data_rd_req_w;
assign u_fifo_rx_ep3__flush_i = usb_ep3_rx_ctrl_rx_flush_out_w;
assign usb_ep3_rx_full_w = u_fifo_rx_ep3__full_o;
assign usb_ep3_data_data_in_w = u_fifo_rx_ep3__data_o;
assign u_fifo_tx_ep3__clk_i = clk_i;
assign u_fifo_tx_ep3__rst_i = rst_i;
assign u_fifo_tx_ep3__data_i = usb_ep3_data_data_out_w;
assign u_fifo_tx_ep3__push_i = usb_ep3_data_wr_req_w;
assign u_fifo_tx_ep3__pop_i = usb_ep3_tx_rd_w;
assign u_fifo_tx_ep3__flush_i = usb_ep3_tx_ctrl_tx_flush_out_w;
assign usb_ep3_tx_empty_w = u_fifo_tx_ep3__empty_o;
assign usb_ep3_tx_data_w = u_fifo_tx_ep3__data_o;
 
  
wire  u_ep0__clk_i;
wire  u_ep0__rst_i;
wire  u_ep0__rx_setup_i;
wire  u_ep0__rx_valid_i;
wire  u_ep0__rx_strb_i;
wire [7:0] u_ep0__rx_data_i;
wire  u_ep0__rx_last_i;
wire  u_ep0__rx_crc_err_i;
wire  u_ep0__rx_full_i;
wire  u_ep0__rx_ack_i;
wire [7:0] u_ep0__tx_data_i;
wire  u_ep0__tx_empty_i;
wire  u_ep0__tx_flush_i;
wire [10:0] u_ep0__tx_length_i;
wire  u_ep0__tx_start_i;
wire  u_ep0__tx_data_accept_i;
wire  u_ep0__rx_space_o;
wire  u_ep0__rx_push_o;
wire [7:0] u_ep0__rx_data_o;
wire [10:0] u_ep0__rx_length_o;
wire  u_ep0__rx_ready_o;
wire  u_ep0__rx_err_o;
wire  u_ep0__rx_setup_o;
wire  u_ep0__tx_pop_o;
wire  u_ep0__tx_busy_o;
wire  u_ep0__tx_err_o;
wire  u_ep0__tx_ready_o;
wire  u_ep0__tx_data_valid_o;
wire  u_ep0__tx_data_strb_o;
wire [7:0] u_ep0__tx_data_o;
wire  u_ep0__tx_data_last_o;
wire  u_ep1__clk_i;
wire  u_ep1__rst_i;
wire  u_ep1__rx_setup_i;
wire  u_ep1__rx_valid_i;
wire  u_ep1__rx_strb_i;
wire [7:0] u_ep1__rx_data_i;
wire  u_ep1__rx_last_i;
wire  u_ep1__rx_crc_err_i;
wire  u_ep1__rx_full_i;
wire  u_ep1__rx_ack_i;
wire [7:0] u_ep1__tx_data_i;
wire  u_ep1__tx_empty_i;
wire  u_ep1__tx_flush_i;
wire [10:0] u_ep1__tx_length_i;
wire  u_ep1__tx_start_i;
wire  u_ep1__tx_data_accept_i;
wire  u_ep1__rx_space_o;
wire  u_ep1__rx_push_o;
wire [7:0] u_ep1__rx_data_o;
wire [10:0] u_ep1__rx_length_o;
wire  u_ep1__rx_ready_o;
wire  u_ep1__rx_err_o;
wire  u_ep1__rx_setup_o;
wire  u_ep1__tx_pop_o;
wire  u_ep1__tx_busy_o;
wire  u_ep1__tx_err_o;
wire  u_ep1__tx_ready_o;
wire  u_ep1__tx_data_valid_o;
wire  u_ep1__tx_data_strb_o;
wire [7:0] u_ep1__tx_data_o;
wire  u_ep1__tx_data_last_o;
wire  u_ep2__clk_i;
wire  u_ep2__rst_i;
wire  u_ep2__rx_setup_i;
wire  u_ep2__rx_valid_i;
wire  u_ep2__rx_strb_i;
wire [7:0] u_ep2__rx_data_i;
wire  u_ep2__rx_last_i;
wire  u_ep2__rx_crc_err_i;
wire  u_ep2__rx_full_i;
wire  u_ep2__rx_ack_i;
wire [7:0] u_ep2__tx_data_i;
wire  u_ep2__tx_empty_i;
wire  u_ep2__tx_flush_i;
wire [10:0] u_ep2__tx_length_i;
wire  u_ep2__tx_start_i;
wire  u_ep2__tx_data_accept_i;
wire  u_ep2__rx_space_o;
wire  u_ep2__rx_push_o;
wire [7:0] u_ep2__rx_data_o;
wire [10:0] u_ep2__rx_length_o;
wire  u_ep2__rx_ready_o;
wire  u_ep2__rx_err_o;
wire  u_ep2__rx_setup_o;
wire  u_ep2__tx_pop_o;
wire  u_ep2__tx_busy_o;
wire  u_ep2__tx_err_o;
wire  u_ep2__tx_ready_o;
wire  u_ep2__tx_data_valid_o;
wire  u_ep2__tx_data_strb_o;
wire [7:0] u_ep2__tx_data_o;
wire  u_ep2__tx_data_last_o;
wire  u_ep3__clk_i;
wire  u_ep3__rst_i;
wire  u_ep3__rx_setup_i;
wire  u_ep3__rx_valid_i;
wire  u_ep3__rx_strb_i;
wire [7:0] u_ep3__rx_data_i;
wire  u_ep3__rx_last_i;
wire  u_ep3__rx_crc_err_i;
wire  u_ep3__rx_full_i;
wire  u_ep3__rx_ack_i;
wire [7:0] u_ep3__tx_data_i;
wire  u_ep3__tx_empty_i;
wire  u_ep3__tx_flush_i;
wire [10:0] u_ep3__tx_length_i;
wire  u_ep3__tx_start_i;
wire  u_ep3__tx_data_accept_i;
wire  u_ep3__rx_space_o;
wire  u_ep3__rx_push_o;
wire [7:0] u_ep3__rx_data_o;
wire [10:0] u_ep3__rx_length_o;
wire  u_ep3__rx_ready_o;
wire  u_ep3__rx_err_o;
wire  u_ep3__rx_setup_o;
wire  u_ep3__tx_pop_o;
wire  u_ep3__tx_busy_o;
wire  u_ep3__tx_err_o;
wire  u_ep3__tx_ready_o;
wire  u_ep3__tx_data_valid_o;
wire  u_ep3__tx_data_strb_o;
wire [7:0] u_ep3__tx_data_o;
wire  u_ep3__tx_data_last_o;
 
   reg  u_ep0__rx_ready_q  ; 
   reg  u_ep0__rx_err_q  ; 
   reg[10:0]  u_ep0__rx_len_q  ; 
   reg  u_ep0__rx_setup_q  ; 
  always @(  posedge    u_ep0__clk_i          or  posedge   u_ep0__rst_i  )
       if (  u_ep0__rst_i  ) 
           u_ep0__rx_ready_q   <=1'b0;
        else 
          if (  u_ep0__rx_ack_i  ) 
              u_ep0__rx_ready_q   <=1'b0;
           else 
             if (  u_ep0__rx_valid_i  &&  u_ep0__rx_last_i  ) 
                 u_ep0__rx_ready_q   <=1'b1;
 
  assign   u_ep0__rx_space_o  =!  u_ep0__rx_ready_q  ; 
  always @(  posedge    u_ep0__clk_i          or  posedge   u_ep0__rst_i  )
       if (  u_ep0__rst_i  ) 
           u_ep0__rx_len_q   <=11'b0;
        else 
          if (  u_ep0__rx_ack_i  ) 
              u_ep0__rx_len_q   <=11'b0;
           else 
             if (  u_ep0__rx_valid_i  &&  u_ep0__rx_strb_i  ) 
                 u_ep0__rx_len_q   <=  u_ep0__rx_len_q  +11'd1;
 
  always @(  posedge    u_ep0__clk_i          or  posedge   u_ep0__rst_i  )
       if (  u_ep0__rst_i  ) 
           u_ep0__rx_err_q   <=1'b0;
        else 
          if (  u_ep0__rx_ack_i  ) 
              u_ep0__rx_err_q   <=1'b0;
           else 
             if (  u_ep0__rx_valid_i  &&  u_ep0__rx_last_i  &&  u_ep0__rx_crc_err_i  ) 
                 u_ep0__rx_err_q   <=1'b1;
              else 
                if (  u_ep0__rx_full_i  &&  u_ep0__rx_push_o  ) 
                    u_ep0__rx_err_q   <=1'b1;
 
  always @(  posedge    u_ep0__clk_i          or  posedge   u_ep0__rst_i  )
       if (  u_ep0__rst_i  ) 
           u_ep0__rx_setup_q   <=1'b0;
        else 
          if (  u_ep0__rx_ack_i  ) 
              u_ep0__rx_setup_q   <=1'b0;
           else 
             if (  u_ep0__rx_setup_i  ) 
                 u_ep0__rx_setup_q   <=1'b1;
 
  assign   u_ep0__rx_length_o  =  u_ep0__rx_len_q  ; 
  assign   u_ep0__rx_ready_o  =  u_ep0__rx_ready_q  ; 
  assign   u_ep0__rx_err_o  =  u_ep0__rx_err_q  ; 
  assign   u_ep0__rx_setup_o  =  u_ep0__rx_setup_q  ; 
  assign   u_ep0__rx_push_o  =  u_ep0__rx_valid_i  &  u_ep0__rx_strb_i  ; 
  assign   u_ep0__rx_data_o  =  u_ep0__rx_data_i  ; 
   reg  u_ep0__tx_active_q  ; 
   reg  u_ep0__tx_err_q  ; 
   reg  u_ep0__tx_zlp_q  ; 
   reg[10:0]  u_ep0__tx_len_q  ; 
  always @(  posedge    u_ep0__clk_i          or  posedge   u_ep0__rst_i  )
       if (  u_ep0__rst_i  ) 
           u_ep0__tx_active_q   <=1'b0;
        else 
          if (  u_ep0__tx_flush_i  ) 
              u_ep0__tx_active_q   <=1'b0;
           else 
             if (  u_ep0__tx_start_i  ) 
                 u_ep0__tx_active_q   <=1'b1;
              else 
                if (  u_ep0__tx_data_valid_o  &&  u_ep0__tx_data_last_o  &&  u_ep0__tx_data_accept_i  ) 
                    u_ep0__tx_active_q   <=1'b0;
 
  assign   u_ep0__tx_ready_o  =  u_ep0__tx_active_q  ; 
  always @(  posedge    u_ep0__clk_i          or  posedge   u_ep0__rst_i  )
       if (  u_ep0__rst_i  ) 
           u_ep0__tx_zlp_q   <=1'b0;
        else 
          if (  u_ep0__tx_flush_i  ) 
              u_ep0__tx_zlp_q   <=1'b0;
           else 
             if (  u_ep0__tx_start_i  ) 
                 u_ep0__tx_zlp_q   <=(  u_ep0__tx_length_i  ==11'b0);
 
  always @(  posedge    u_ep0__clk_i          or  posedge   u_ep0__rst_i  )
       if (  u_ep0__rst_i  ) 
           u_ep0__tx_len_q   <=11'b0;
        else 
          if (  u_ep0__tx_flush_i  ) 
              u_ep0__tx_len_q   <=11'b0;
           else 
             if (  u_ep0__tx_start_i  ) 
                 u_ep0__tx_len_q   <=  u_ep0__tx_length_i  ;
              else 
                if (  u_ep0__tx_data_valid_o  &&  u_ep0__tx_data_accept_i  &&!  u_ep0__tx_zlp_q  ) 
                    u_ep0__tx_len_q   <=  u_ep0__tx_len_q  -11'd1;
 
  assign   u_ep0__tx_data_valid_o  =  u_ep0__tx_active_q  ; 
  assign   u_ep0__tx_data_strb_o  =!  u_ep0__tx_zlp_q  ; 
  assign   u_ep0__tx_data_last_o  =  u_ep0__tx_zlp_q  ||(  u_ep0__tx_len_q  ==11'd1); 
  assign   u_ep0__tx_data_o  =  u_ep0__tx_data_i  ; 
  always @(  posedge    u_ep0__clk_i          or  posedge   u_ep0__rst_i  )
       if (  u_ep0__rst_i  ) 
           u_ep0__tx_err_q   <=1'b0;
        else 
          if (  u_ep0__tx_flush_i  ) 
              u_ep0__tx_err_q   <=1'b0;
           else 
             if (  u_ep0__tx_start_i  ) 
                 u_ep0__tx_err_q   <=1'b0;
              else 
                if (!  u_ep0__tx_zlp_q  &&  u_ep0__tx_empty_i  &&  u_ep0__tx_data_valid_o  ) 
                    u_ep0__tx_err_q   <=1'b1;
 
  assign   u_ep0__tx_err_o  =  u_ep0__tx_err_q  ; 
  assign   u_ep0__tx_busy_o  =  u_ep0__tx_active_q  ; 
  assign   u_ep0__tx_pop_o  =  u_ep0__tx_data_accept_i  &  u_ep0__tx_active_q  ;
 
  
 
   reg  u_ep1__rx_ready_q  ; 
   reg  u_ep1__rx_err_q  ; 
   reg[10:0]  u_ep1__rx_len_q  ; 
   reg  u_ep1__rx_setup_q  ; 
  always @(  posedge    u_ep1__clk_i          or  posedge   u_ep1__rst_i  )
       if (  u_ep1__rst_i  ) 
           u_ep1__rx_ready_q   <=1'b0;
        else 
          if (  u_ep1__rx_ack_i  ) 
              u_ep1__rx_ready_q   <=1'b0;
           else 
             if (  u_ep1__rx_valid_i  &&  u_ep1__rx_last_i  ) 
                 u_ep1__rx_ready_q   <=1'b1;
 
  assign   u_ep1__rx_space_o  =!  u_ep1__rx_ready_q  ; 
  always @(  posedge    u_ep1__clk_i          or  posedge   u_ep1__rst_i  )
       if (  u_ep1__rst_i  ) 
           u_ep1__rx_len_q   <=11'b0;
        else 
          if (  u_ep1__rx_ack_i  ) 
              u_ep1__rx_len_q   <=11'b0;
           else 
             if (  u_ep1__rx_valid_i  &&  u_ep1__rx_strb_i  ) 
                 u_ep1__rx_len_q   <=  u_ep1__rx_len_q  +11'd1;
 
  always @(  posedge    u_ep1__clk_i          or  posedge   u_ep1__rst_i  )
       if (  u_ep1__rst_i  ) 
           u_ep1__rx_err_q   <=1'b0;
        else 
          if (  u_ep1__rx_ack_i  ) 
              u_ep1__rx_err_q   <=1'b0;
           else 
             if (  u_ep1__rx_valid_i  &&  u_ep1__rx_last_i  &&  u_ep1__rx_crc_err_i  ) 
                 u_ep1__rx_err_q   <=1'b1;
              else 
                if (  u_ep1__rx_full_i  &&  u_ep1__rx_push_o  ) 
                    u_ep1__rx_err_q   <=1'b1;
 
  always @(  posedge    u_ep1__clk_i          or  posedge   u_ep1__rst_i  )
       if (  u_ep1__rst_i  ) 
           u_ep1__rx_setup_q   <=1'b0;
        else 
          if (  u_ep1__rx_ack_i  ) 
              u_ep1__rx_setup_q   <=1'b0;
           else 
             if (  u_ep1__rx_setup_i  ) 
                 u_ep1__rx_setup_q   <=1'b1;
 
  assign   u_ep1__rx_length_o  =  u_ep1__rx_len_q  ; 
  assign   u_ep1__rx_ready_o  =  u_ep1__rx_ready_q  ; 
  assign   u_ep1__rx_err_o  =  u_ep1__rx_err_q  ; 
  assign   u_ep1__rx_setup_o  =  u_ep1__rx_setup_q  ; 
  assign   u_ep1__rx_push_o  =  u_ep1__rx_valid_i  &  u_ep1__rx_strb_i  ; 
  assign   u_ep1__rx_data_o  =  u_ep1__rx_data_i  ; 
   reg  u_ep1__tx_active_q  ; 
   reg  u_ep1__tx_err_q  ; 
   reg  u_ep1__tx_zlp_q  ; 
   reg[10:0]  u_ep1__tx_len_q  ; 
  always @(  posedge    u_ep1__clk_i          or  posedge   u_ep1__rst_i  )
       if (  u_ep1__rst_i  ) 
           u_ep1__tx_active_q   <=1'b0;
        else 
          if (  u_ep1__tx_flush_i  ) 
              u_ep1__tx_active_q   <=1'b0;
           else 
             if (  u_ep1__tx_start_i  ) 
                 u_ep1__tx_active_q   <=1'b1;
              else 
                if (  u_ep1__tx_data_valid_o  &&  u_ep1__tx_data_last_o  &&  u_ep1__tx_data_accept_i  ) 
                    u_ep1__tx_active_q   <=1'b0;
 
  assign   u_ep1__tx_ready_o  =  u_ep1__tx_active_q  ; 
  always @(  posedge    u_ep1__clk_i          or  posedge   u_ep1__rst_i  )
       if (  u_ep1__rst_i  ) 
           u_ep1__tx_zlp_q   <=1'b0;
        else 
          if (  u_ep1__tx_flush_i  ) 
              u_ep1__tx_zlp_q   <=1'b0;
           else 
             if (  u_ep1__tx_start_i  ) 
                 u_ep1__tx_zlp_q   <=(  u_ep1__tx_length_i  ==11'b0);
 
  always @(  posedge    u_ep1__clk_i          or  posedge   u_ep1__rst_i  )
       if (  u_ep1__rst_i  ) 
           u_ep1__tx_len_q   <=11'b0;
        else 
          if (  u_ep1__tx_flush_i  ) 
              u_ep1__tx_len_q   <=11'b0;
           else 
             if (  u_ep1__tx_start_i  ) 
                 u_ep1__tx_len_q   <=  u_ep1__tx_length_i  ;
              else 
                if (  u_ep1__tx_data_valid_o  &&  u_ep1__tx_data_accept_i  &&!  u_ep1__tx_zlp_q  ) 
                    u_ep1__tx_len_q   <=  u_ep1__tx_len_q  -11'd1;
 
  assign   u_ep1__tx_data_valid_o  =  u_ep1__tx_active_q  ; 
  assign   u_ep1__tx_data_strb_o  =!  u_ep1__tx_zlp_q  ; 
  assign   u_ep1__tx_data_last_o  =  u_ep1__tx_zlp_q  ||(  u_ep1__tx_len_q  ==11'd1); 
  assign   u_ep1__tx_data_o  =  u_ep1__tx_data_i  ; 
  always @(  posedge    u_ep1__clk_i          or  posedge   u_ep1__rst_i  )
       if (  u_ep1__rst_i  ) 
           u_ep1__tx_err_q   <=1'b0;
        else 
          if (  u_ep1__tx_flush_i  ) 
              u_ep1__tx_err_q   <=1'b0;
           else 
             if (  u_ep1__tx_start_i  ) 
                 u_ep1__tx_err_q   <=1'b0;
              else 
                if (!  u_ep1__tx_zlp_q  &&  u_ep1__tx_empty_i  &&  u_ep1__tx_data_valid_o  ) 
                    u_ep1__tx_err_q   <=1'b1;
 
  assign   u_ep1__tx_err_o  =  u_ep1__tx_err_q  ; 
  assign   u_ep1__tx_busy_o  =  u_ep1__tx_active_q  ; 
  assign   u_ep1__tx_pop_o  =  u_ep1__tx_data_accept_i  &  u_ep1__tx_active_q  ;
 
  
 
   reg  u_ep2__rx_ready_q  ; 
   reg  u_ep2__rx_err_q  ; 
   reg[10:0]  u_ep2__rx_len_q  ; 
   reg  u_ep2__rx_setup_q  ; 
  always @(  posedge    u_ep2__clk_i          or  posedge   u_ep2__rst_i  )
       if (  u_ep2__rst_i  ) 
           u_ep2__rx_ready_q   <=1'b0;
        else 
          if (  u_ep2__rx_ack_i  ) 
              u_ep2__rx_ready_q   <=1'b0;
           else 
             if (  u_ep2__rx_valid_i  &&  u_ep2__rx_last_i  ) 
                 u_ep2__rx_ready_q   <=1'b1;
 
  assign   u_ep2__rx_space_o  =!  u_ep2__rx_ready_q  ; 
  always @(  posedge    u_ep2__clk_i          or  posedge   u_ep2__rst_i  )
       if (  u_ep2__rst_i  ) 
           u_ep2__rx_len_q   <=11'b0;
        else 
          if (  u_ep2__rx_ack_i  ) 
              u_ep2__rx_len_q   <=11'b0;
           else 
             if (  u_ep2__rx_valid_i  &&  u_ep2__rx_strb_i  ) 
                 u_ep2__rx_len_q   <=  u_ep2__rx_len_q  +11'd1;
 
  always @(  posedge    u_ep2__clk_i          or  posedge   u_ep2__rst_i  )
       if (  u_ep2__rst_i  ) 
           u_ep2__rx_err_q   <=1'b0;
        else 
          if (  u_ep2__rx_ack_i  ) 
              u_ep2__rx_err_q   <=1'b0;
           else 
             if (  u_ep2__rx_valid_i  &&  u_ep2__rx_last_i  &&  u_ep2__rx_crc_err_i  ) 
                 u_ep2__rx_err_q   <=1'b1;
              else 
                if (  u_ep2__rx_full_i  &&  u_ep2__rx_push_o  ) 
                    u_ep2__rx_err_q   <=1'b1;
 
  always @(  posedge    u_ep2__clk_i          or  posedge   u_ep2__rst_i  )
       if (  u_ep2__rst_i  ) 
           u_ep2__rx_setup_q   <=1'b0;
        else 
          if (  u_ep2__rx_ack_i  ) 
              u_ep2__rx_setup_q   <=1'b0;
           else 
             if (  u_ep2__rx_setup_i  ) 
                 u_ep2__rx_setup_q   <=1'b1;
 
  assign   u_ep2__rx_length_o  =  u_ep2__rx_len_q  ; 
  assign   u_ep2__rx_ready_o  =  u_ep2__rx_ready_q  ; 
  assign   u_ep2__rx_err_o  =  u_ep2__rx_err_q  ; 
  assign   u_ep2__rx_setup_o  =  u_ep2__rx_setup_q  ; 
  assign   u_ep2__rx_push_o  =  u_ep2__rx_valid_i  &  u_ep2__rx_strb_i  ; 
  assign   u_ep2__rx_data_o  =  u_ep2__rx_data_i  ; 
   reg  u_ep2__tx_active_q  ; 
   reg  u_ep2__tx_err_q  ; 
   reg  u_ep2__tx_zlp_q  ; 
   reg[10:0]  u_ep2__tx_len_q  ; 
  always @(  posedge    u_ep2__clk_i          or  posedge   u_ep2__rst_i  )
       if (  u_ep2__rst_i  ) 
           u_ep2__tx_active_q   <=1'b0;
        else 
          if (  u_ep2__tx_flush_i  ) 
              u_ep2__tx_active_q   <=1'b0;
           else 
             if (  u_ep2__tx_start_i  ) 
                 u_ep2__tx_active_q   <=1'b1;
              else 
                if (  u_ep2__tx_data_valid_o  &&  u_ep2__tx_data_last_o  &&  u_ep2__tx_data_accept_i  ) 
                    u_ep2__tx_active_q   <=1'b0;
 
  assign   u_ep2__tx_ready_o  =  u_ep2__tx_active_q  ; 
  always @(  posedge    u_ep2__clk_i          or  posedge   u_ep2__rst_i  )
       if (  u_ep2__rst_i  ) 
           u_ep2__tx_zlp_q   <=1'b0;
        else 
          if (  u_ep2__tx_flush_i  ) 
              u_ep2__tx_zlp_q   <=1'b0;
           else 
             if (  u_ep2__tx_start_i  ) 
                 u_ep2__tx_zlp_q   <=(  u_ep2__tx_length_i  ==11'b0);
 
  always @(  posedge    u_ep2__clk_i          or  posedge   u_ep2__rst_i  )
       if (  u_ep2__rst_i  ) 
           u_ep2__tx_len_q   <=11'b0;
        else 
          if (  u_ep2__tx_flush_i  ) 
              u_ep2__tx_len_q   <=11'b0;
           else 
             if (  u_ep2__tx_start_i  ) 
                 u_ep2__tx_len_q   <=  u_ep2__tx_length_i  ;
              else 
                if (  u_ep2__tx_data_valid_o  &&  u_ep2__tx_data_accept_i  &&!  u_ep2__tx_zlp_q  ) 
                    u_ep2__tx_len_q   <=  u_ep2__tx_len_q  -11'd1;
 
  assign   u_ep2__tx_data_valid_o  =  u_ep2__tx_active_q  ; 
  assign   u_ep2__tx_data_strb_o  =!  u_ep2__tx_zlp_q  ; 
  assign   u_ep2__tx_data_last_o  =  u_ep2__tx_zlp_q  ||(  u_ep2__tx_len_q  ==11'd1); 
  assign   u_ep2__tx_data_o  =  u_ep2__tx_data_i  ; 
  always @(  posedge    u_ep2__clk_i          or  posedge   u_ep2__rst_i  )
       if (  u_ep2__rst_i  ) 
           u_ep2__tx_err_q   <=1'b0;
        else 
          if (  u_ep2__tx_flush_i  ) 
              u_ep2__tx_err_q   <=1'b0;
           else 
             if (  u_ep2__tx_start_i  ) 
                 u_ep2__tx_err_q   <=1'b0;
              else 
                if (!  u_ep2__tx_zlp_q  &&  u_ep2__tx_empty_i  &&  u_ep2__tx_data_valid_o  ) 
                    u_ep2__tx_err_q   <=1'b1;
 
  assign   u_ep2__tx_err_o  =  u_ep2__tx_err_q  ; 
  assign   u_ep2__tx_busy_o  =  u_ep2__tx_active_q  ; 
  assign   u_ep2__tx_pop_o  =  u_ep2__tx_data_accept_i  &  u_ep2__tx_active_q  ;
 
  
 
   reg  u_ep3__rx_ready_q  ; 
   reg  u_ep3__rx_err_q  ; 
   reg[10:0]  u_ep3__rx_len_q  ; 
   reg  u_ep3__rx_setup_q  ; 
  always @(  posedge    u_ep3__clk_i          or  posedge   u_ep3__rst_i  )
       if (  u_ep3__rst_i  ) 
           u_ep3__rx_ready_q   <=1'b0;
        else 
          if (  u_ep3__rx_ack_i  ) 
              u_ep3__rx_ready_q   <=1'b0;
           else 
             if (  u_ep3__rx_valid_i  &&  u_ep3__rx_last_i  ) 
                 u_ep3__rx_ready_q   <=1'b1;
 
  assign   u_ep3__rx_space_o  =!  u_ep3__rx_ready_q  ; 
  always @(  posedge    u_ep3__clk_i          or  posedge   u_ep3__rst_i  )
       if (  u_ep3__rst_i  ) 
           u_ep3__rx_len_q   <=11'b0;
        else 
          if (  u_ep3__rx_ack_i  ) 
              u_ep3__rx_len_q   <=11'b0;
           else 
             if (  u_ep3__rx_valid_i  &&  u_ep3__rx_strb_i  ) 
                 u_ep3__rx_len_q   <=  u_ep3__rx_len_q  +11'd1;
 
  always @(  posedge    u_ep3__clk_i          or  posedge   u_ep3__rst_i  )
       if (  u_ep3__rst_i  ) 
           u_ep3__rx_err_q   <=1'b0;
        else 
          if (  u_ep3__rx_ack_i  ) 
              u_ep3__rx_err_q   <=1'b0;
           else 
             if (  u_ep3__rx_valid_i  &&  u_ep3__rx_last_i  &&  u_ep3__rx_crc_err_i  ) 
                 u_ep3__rx_err_q   <=1'b1;
              else 
                if (  u_ep3__rx_full_i  &&  u_ep3__rx_push_o  ) 
                    u_ep3__rx_err_q   <=1'b1;
 
  always @(  posedge    u_ep3__clk_i          or  posedge   u_ep3__rst_i  )
       if (  u_ep3__rst_i  ) 
           u_ep3__rx_setup_q   <=1'b0;
        else 
          if (  u_ep3__rx_ack_i  ) 
              u_ep3__rx_setup_q   <=1'b0;
           else 
             if (  u_ep3__rx_setup_i  ) 
                 u_ep3__rx_setup_q   <=1'b1;
 
  assign   u_ep3__rx_length_o  =  u_ep3__rx_len_q  ; 
  assign   u_ep3__rx_ready_o  =  u_ep3__rx_ready_q  ; 
  assign   u_ep3__rx_err_o  =  u_ep3__rx_err_q  ; 
  assign   u_ep3__rx_setup_o  =  u_ep3__rx_setup_q  ; 
  assign   u_ep3__rx_push_o  =  u_ep3__rx_valid_i  &  u_ep3__rx_strb_i  ; 
  assign   u_ep3__rx_data_o  =  u_ep3__rx_data_i  ; 
   reg  u_ep3__tx_active_q  ; 
   reg  u_ep3__tx_err_q  ; 
   reg  u_ep3__tx_zlp_q  ; 
   reg[10:0]  u_ep3__tx_len_q  ; 
  always @(  posedge    u_ep3__clk_i          or  posedge   u_ep3__rst_i  )
       if (  u_ep3__rst_i  ) 
           u_ep3__tx_active_q   <=1'b0;
        else 
          if (  u_ep3__tx_flush_i  ) 
              u_ep3__tx_active_q   <=1'b0;
           else 
             if (  u_ep3__tx_start_i  ) 
                 u_ep3__tx_active_q   <=1'b1;
              else 
                if (  u_ep3__tx_data_valid_o  &&  u_ep3__tx_data_last_o  &&  u_ep3__tx_data_accept_i  ) 
                    u_ep3__tx_active_q   <=1'b0;
 
  assign   u_ep3__tx_ready_o  =  u_ep3__tx_active_q  ; 
  always @(  posedge    u_ep3__clk_i          or  posedge   u_ep3__rst_i  )
       if (  u_ep3__rst_i  ) 
           u_ep3__tx_zlp_q   <=1'b0;
        else 
          if (  u_ep3__tx_flush_i  ) 
              u_ep3__tx_zlp_q   <=1'b0;
           else 
             if (  u_ep3__tx_start_i  ) 
                 u_ep3__tx_zlp_q   <=(  u_ep3__tx_length_i  ==11'b0);
 
  always @(  posedge    u_ep3__clk_i          or  posedge   u_ep3__rst_i  )
       if (  u_ep3__rst_i  ) 
           u_ep3__tx_len_q   <=11'b0;
        else 
          if (  u_ep3__tx_flush_i  ) 
              u_ep3__tx_len_q   <=11'b0;
           else 
             if (  u_ep3__tx_start_i  ) 
                 u_ep3__tx_len_q   <=  u_ep3__tx_length_i  ;
              else 
                if (  u_ep3__tx_data_valid_o  &&  u_ep3__tx_data_accept_i  &&!  u_ep3__tx_zlp_q  ) 
                    u_ep3__tx_len_q   <=  u_ep3__tx_len_q  -11'd1;
 
  assign   u_ep3__tx_data_valid_o  =  u_ep3__tx_active_q  ; 
  assign   u_ep3__tx_data_strb_o  =!  u_ep3__tx_zlp_q  ; 
  assign   u_ep3__tx_data_last_o  =  u_ep3__tx_zlp_q  ||(  u_ep3__tx_len_q  ==11'd1); 
  assign   u_ep3__tx_data_o  =  u_ep3__tx_data_i  ; 
  always @(  posedge    u_ep3__clk_i          or  posedge   u_ep3__rst_i  )
       if (  u_ep3__rst_i  ) 
           u_ep3__tx_err_q   <=1'b0;
        else 
          if (  u_ep3__tx_flush_i  ) 
              u_ep3__tx_err_q   <=1'b0;
           else 
             if (  u_ep3__tx_start_i  ) 
                 u_ep3__tx_err_q   <=1'b0;
              else 
                if (!  u_ep3__tx_zlp_q  &&  u_ep3__tx_empty_i  &&  u_ep3__tx_data_valid_o  ) 
                    u_ep3__tx_err_q   <=1'b1;
 
  assign   u_ep3__tx_err_o  =  u_ep3__tx_err_q  ; 
  assign   u_ep3__tx_busy_o  =  u_ep3__tx_active_q  ; 
  assign   u_ep3__tx_pop_o  =  u_ep3__tx_data_accept_i  &  u_ep3__tx_active_q  ;
assign u_ep0__clk_i = clk_i;
assign u_ep0__rst_i = rst_i;
assign u_ep0__rx_setup_i = ep0_rx_setup_w;
assign u_ep0__rx_valid_i = ep0_rx_valid_w;
assign u_ep0__rx_strb_i = rx_strb_w;
assign u_ep0__rx_data_i = rx_data_w;
assign u_ep0__rx_last_i = rx_last_w;
assign u_ep0__rx_crc_err_i = rx_crc_err_w;
assign u_ep0__rx_full_i = usb_ep0_rx_full_w;
assign u_ep0__rx_ack_i = usb_ep0_rx_ctrl_rx_accept_out_w;
assign u_ep0__tx_data_i = usb_ep0_tx_data_w;
assign u_ep0__tx_empty_i = usb_ep0_tx_empty_w;
assign u_ep0__tx_flush_i = usb_ep0_tx_ctrl_tx_flush_out_w;
assign u_ep0__tx_length_i = usb_ep0_tx_ctrl_tx_len_out_w;
assign u_ep0__tx_start_i = usb_ep0_tx_ctrl_tx_start_out_w;
assign u_ep0__tx_data_accept_i = ep0_tx_data_accept_w;
assign ep0_rx_space_w = u_ep0__rx_space_o;
assign usb_ep0_rx_wr_w = u_ep0__rx_push_o;
assign usb_ep0_rx_data_w = u_ep0__rx_data_o;
assign usb_ep0_sts_rx_count_in_w = u_ep0__rx_length_o;
assign usb_ep0_sts_rx_ready_in_w = u_ep0__rx_ready_o;
assign usb_ep0_sts_rx_err_in_w = u_ep0__rx_err_o;
assign usb_ep0_sts_rx_setup_in_w = u_ep0__rx_setup_o;
assign usb_ep0_tx_rd_w = u_ep0__tx_pop_o;
assign usb_ep0_sts_tx_busy_in_w = u_ep0__tx_busy_o;
assign usb_ep0_sts_tx_err_in_w = u_ep0__tx_err_o;
assign ep0_tx_ready_w = u_ep0__tx_ready_o;
assign ep0_tx_data_valid_w = u_ep0__tx_data_valid_o;
assign ep0_tx_data_strb_w = u_ep0__tx_data_strb_o;
assign ep0_tx_data_w = u_ep0__tx_data_o;
assign ep0_tx_data_last_w = u_ep0__tx_data_last_o;
assign u_ep1__clk_i = clk_i;
assign u_ep1__rst_i = rst_i;
assign u_ep1__rx_setup_i = ep1_rx_setup_w;
assign u_ep1__rx_valid_i = ep1_rx_valid_w;
assign u_ep1__rx_strb_i = rx_strb_w;
assign u_ep1__rx_data_i = rx_data_w;
assign u_ep1__rx_last_i = rx_last_w;
assign u_ep1__rx_crc_err_i = rx_crc_err_w;
assign u_ep1__rx_full_i = usb_ep1_rx_full_w;
assign u_ep1__rx_ack_i = usb_ep1_rx_ctrl_rx_accept_out_w;
assign u_ep1__tx_data_i = usb_ep1_tx_data_w;
assign u_ep1__tx_empty_i = usb_ep1_tx_empty_w;
assign u_ep1__tx_flush_i = usb_ep1_tx_ctrl_tx_flush_out_w;
assign u_ep1__tx_length_i = usb_ep1_tx_ctrl_tx_len_out_w;
assign u_ep1__tx_start_i = usb_ep1_tx_ctrl_tx_start_out_w;
assign u_ep1__tx_data_accept_i = ep1_tx_data_accept_w;
assign ep1_rx_space_w = u_ep1__rx_space_o;
assign usb_ep1_rx_wr_w = u_ep1__rx_push_o;
assign usb_ep1_rx_data_w = u_ep1__rx_data_o;
assign usb_ep1_sts_rx_count_in_w = u_ep1__rx_length_o;
assign usb_ep1_sts_rx_ready_in_w = u_ep1__rx_ready_o;
assign usb_ep1_sts_rx_err_in_w = u_ep1__rx_err_o;
assign usb_ep1_sts_rx_setup_in_w = u_ep1__rx_setup_o;
assign usb_ep1_tx_rd_w = u_ep1__tx_pop_o;
assign usb_ep1_sts_tx_busy_in_w = u_ep1__tx_busy_o;
assign usb_ep1_sts_tx_err_in_w = u_ep1__tx_err_o;
assign ep1_tx_ready_w = u_ep1__tx_ready_o;
assign ep1_tx_data_valid_w = u_ep1__tx_data_valid_o;
assign ep1_tx_data_strb_w = u_ep1__tx_data_strb_o;
assign ep1_tx_data_w = u_ep1__tx_data_o;
assign ep1_tx_data_last_w = u_ep1__tx_data_last_o;
assign u_ep2__clk_i = clk_i;
assign u_ep2__rst_i = rst_i;
assign u_ep2__rx_setup_i = ep2_rx_setup_w;
assign u_ep2__rx_valid_i = ep2_rx_valid_w;
assign u_ep2__rx_strb_i = rx_strb_w;
assign u_ep2__rx_data_i = rx_data_w;
assign u_ep2__rx_last_i = rx_last_w;
assign u_ep2__rx_crc_err_i = rx_crc_err_w;
assign u_ep2__rx_full_i = usb_ep2_rx_full_w;
assign u_ep2__rx_ack_i = usb_ep2_rx_ctrl_rx_accept_out_w;
assign u_ep2__tx_data_i = usb_ep2_tx_data_w;
assign u_ep2__tx_empty_i = usb_ep2_tx_empty_w;
assign u_ep2__tx_flush_i = usb_ep2_tx_ctrl_tx_flush_out_w;
assign u_ep2__tx_length_i = usb_ep2_tx_ctrl_tx_len_out_w;
assign u_ep2__tx_start_i = usb_ep2_tx_ctrl_tx_start_out_w;
assign u_ep2__tx_data_accept_i = ep2_tx_data_accept_w;
assign ep2_rx_space_w = u_ep2__rx_space_o;
assign usb_ep2_rx_wr_w = u_ep2__rx_push_o;
assign usb_ep2_rx_data_w = u_ep2__rx_data_o;
assign usb_ep2_sts_rx_count_in_w = u_ep2__rx_length_o;
assign usb_ep2_sts_rx_ready_in_w = u_ep2__rx_ready_o;
assign usb_ep2_sts_rx_err_in_w = u_ep2__rx_err_o;
assign usb_ep2_sts_rx_setup_in_w = u_ep2__rx_setup_o;
assign usb_ep2_tx_rd_w = u_ep2__tx_pop_o;
assign usb_ep2_sts_tx_busy_in_w = u_ep2__tx_busy_o;
assign usb_ep2_sts_tx_err_in_w = u_ep2__tx_err_o;
assign ep2_tx_ready_w = u_ep2__tx_ready_o;
assign ep2_tx_data_valid_w = u_ep2__tx_data_valid_o;
assign ep2_tx_data_strb_w = u_ep2__tx_data_strb_o;
assign ep2_tx_data_w = u_ep2__tx_data_o;
assign ep2_tx_data_last_w = u_ep2__tx_data_last_o;
assign u_ep3__clk_i = clk_i;
assign u_ep3__rst_i = rst_i;
assign u_ep3__rx_setup_i = ep3_rx_setup_w;
assign u_ep3__rx_valid_i = ep3_rx_valid_w;
assign u_ep3__rx_strb_i = rx_strb_w;
assign u_ep3__rx_data_i = rx_data_w;
assign u_ep3__rx_last_i = rx_last_w;
assign u_ep3__rx_crc_err_i = rx_crc_err_w;
assign u_ep3__rx_full_i = usb_ep3_rx_full_w;
assign u_ep3__rx_ack_i = usb_ep3_rx_ctrl_rx_accept_out_w;
assign u_ep3__tx_data_i = usb_ep3_tx_data_w;
assign u_ep3__tx_empty_i = usb_ep3_tx_empty_w;
assign u_ep3__tx_flush_i = usb_ep3_tx_ctrl_tx_flush_out_w;
assign u_ep3__tx_length_i = usb_ep3_tx_ctrl_tx_len_out_w;
assign u_ep3__tx_start_i = usb_ep3_tx_ctrl_tx_start_out_w;
assign u_ep3__tx_data_accept_i = ep3_tx_data_accept_w;
assign ep3_rx_space_w = u_ep3__rx_space_o;
assign usb_ep3_rx_wr_w = u_ep3__rx_push_o;
assign usb_ep3_rx_data_w = u_ep3__rx_data_o;
assign usb_ep3_sts_rx_count_in_w = u_ep3__rx_length_o;
assign usb_ep3_sts_rx_ready_in_w = u_ep3__rx_ready_o;
assign usb_ep3_sts_rx_err_in_w = u_ep3__rx_err_o;
assign usb_ep3_sts_rx_setup_in_w = u_ep3__rx_setup_o;
assign usb_ep3_tx_rd_w = u_ep3__tx_pop_o;
assign usb_ep3_sts_tx_busy_in_w = u_ep3__tx_busy_o;
assign usb_ep3_sts_tx_err_in_w = u_ep3__tx_err_o;
assign ep3_tx_ready_w = u_ep3__tx_ready_o;
assign ep3_tx_data_valid_w = u_ep3__tx_data_valid_o;
assign ep3_tx_data_strb_w = u_ep3__tx_data_strb_o;
assign ep3_tx_data_w = u_ep3__tx_data_o;
assign ep3_tx_data_last_w = u_ep3__tx_data_last_o;
 
endmodule