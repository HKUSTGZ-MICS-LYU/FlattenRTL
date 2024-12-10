
module usbf_device
(
    // Inputs
     input          clk_i
    ,input          rst_i
    ,input          cfg_awvalid_i
    ,input  [31:0]  cfg_awaddr_i
    ,input          cfg_wvalid_i
    ,input  [31:0]  cfg_wdata_i
    ,input  [3:0]   cfg_wstrb_i
    ,input          cfg_bready_i
    ,input          cfg_arvalid_i
    ,input  [31:0]  cfg_araddr_i
    ,input          cfg_rready_i
    ,input  [7:0]   utmi_data_in_i
    ,input          utmi_txready_i
    ,input          utmi_rxvalid_i
    ,input          utmi_rxactive_i
    ,input          utmi_rxerror_i
    ,input  [1:0]   utmi_linestate_i

    // Outputs
    ,output         cfg_awready_o
    ,output         cfg_wready_o
    ,output         cfg_bvalid_o
    ,output [1:0]   cfg_bresp_o
    ,output         cfg_arready_o
    ,output         cfg_rvalid_o
    ,output [31:0]  cfg_rdata_o
    ,output [1:0]   cfg_rresp_o
    ,output         intr_o
    ,output [7:0]   utmi_data_out_o
    ,output         utmi_txvalid_o
    ,output [1:0]   utmi_op_mode_o
    ,output [1:0]   utmi_xcvrselect_o
    ,output         utmi_termselect_o
    ,output         utmi_dppulldown_o
    ,output         utmi_dmpulldown_o
);

//-----------------------------------------------------------------
// Retime write data
//-----------------------------------------------------------------
reg [31:0] wr_data_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    wr_data_q <= 32'b0;
else
    wr_data_q <= cfg_wdata_i;

//-----------------------------------------------------------------
// Request Logic
//-----------------------------------------------------------------
wire read_en_w  = cfg_arvalid_i & cfg_arready_o;
wire write_en_w = cfg_awvalid_i & cfg_awready_o;

//-----------------------------------------------------------------
// Accept Logic
//-----------------------------------------------------------------
assign cfg_arready_o = ~cfg_rvalid_o;
assign cfg_awready_o = ~cfg_bvalid_o && ~cfg_arvalid_i; 
assign cfg_wready_o  = cfg_awready_o;


//-----------------------------------------------------------------
// Register usb_func_ctrl
//-----------------------------------------------------------------
reg usb_func_ctrl_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_func_ctrl_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h0))
    usb_func_ctrl_wr_q <= 1'b1;
else
    usb_func_ctrl_wr_q <= 1'b0;

// usb_func_ctrl_hs_chirp_en [internal]
reg        usb_func_ctrl_hs_chirp_en_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_func_ctrl_hs_chirp_en_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h0))
    usb_func_ctrl_hs_chirp_en_q <= cfg_wdata_i[8:8];

wire        usb_func_ctrl_hs_chirp_en_out_w = usb_func_ctrl_hs_chirp_en_q;


// usb_func_ctrl_phy_dmpulldown [internal]
reg        usb_func_ctrl_phy_dmpulldown_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_func_ctrl_phy_dmpulldown_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h0))
    usb_func_ctrl_phy_dmpulldown_q <= cfg_wdata_i[7:7];

wire        usb_func_ctrl_phy_dmpulldown_out_w = usb_func_ctrl_phy_dmpulldown_q;


// usb_func_ctrl_phy_dppulldown [internal]
reg        usb_func_ctrl_phy_dppulldown_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_func_ctrl_phy_dppulldown_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h0))
    usb_func_ctrl_phy_dppulldown_q <= cfg_wdata_i[6:6];

wire        usb_func_ctrl_phy_dppulldown_out_w = usb_func_ctrl_phy_dppulldown_q;


// usb_func_ctrl_phy_termselect [internal]
reg        usb_func_ctrl_phy_termselect_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_func_ctrl_phy_termselect_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h0))
    usb_func_ctrl_phy_termselect_q <= cfg_wdata_i[5:5];

wire        usb_func_ctrl_phy_termselect_out_w = usb_func_ctrl_phy_termselect_q;


// usb_func_ctrl_phy_xcvrselect [internal]
reg [1:0]  usb_func_ctrl_phy_xcvrselect_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_func_ctrl_phy_xcvrselect_q <= 2'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h0))
    usb_func_ctrl_phy_xcvrselect_q <= cfg_wdata_i[4:3];

wire [1:0]  usb_func_ctrl_phy_xcvrselect_out_w = usb_func_ctrl_phy_xcvrselect_q;


// usb_func_ctrl_phy_opmode [internal]
reg [1:0]  usb_func_ctrl_phy_opmode_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_func_ctrl_phy_opmode_q <= 2'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h0))
    usb_func_ctrl_phy_opmode_q <= cfg_wdata_i[2:1];

wire [1:0]  usb_func_ctrl_phy_opmode_out_w = usb_func_ctrl_phy_opmode_q;


// usb_func_ctrl_int_en_sof [internal]
reg        usb_func_ctrl_int_en_sof_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_func_ctrl_int_en_sof_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h0))
    usb_func_ctrl_int_en_sof_q <= cfg_wdata_i[0:0];

wire        usb_func_ctrl_int_en_sof_out_w = usb_func_ctrl_int_en_sof_q;


//-----------------------------------------------------------------
// Register usb_func_stat
//-----------------------------------------------------------------
reg usb_func_stat_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_func_stat_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h4))
    usb_func_stat_wr_q <= 1'b1;
else
    usb_func_stat_wr_q <= 1'b0;

// usb_func_stat_rst [external]
wire        usb_func_stat_rst_out_w = wr_data_q[13:13];


// usb_func_stat_linestate [external]
wire [1:0]  usb_func_stat_linestate_out_w = wr_data_q[12:11];


// usb_func_stat_frame [external]
wire [10:0]  usb_func_stat_frame_out_w = wr_data_q[10:0];


//-----------------------------------------------------------------
// Register usb_func_addr
//-----------------------------------------------------------------
reg usb_func_addr_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_func_addr_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h8))
    usb_func_addr_wr_q <= 1'b1;
else
    usb_func_addr_wr_q <= 1'b0;

// usb_func_addr_dev_addr [internal]
reg [6:0]  usb_func_addr_dev_addr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_func_addr_dev_addr_q <= 7'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h8))
    usb_func_addr_dev_addr_q <= cfg_wdata_i[6:0];

wire [6:0]  usb_func_addr_dev_addr_out_w = usb_func_addr_dev_addr_q;


//-----------------------------------------------------------------
// Register usb_ep0_cfg
//-----------------------------------------------------------------
reg usb_ep0_cfg_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_cfg_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'hc))
    usb_ep0_cfg_wr_q <= 1'b1;
else
    usb_ep0_cfg_wr_q <= 1'b0;

// usb_ep0_cfg_int_rx [internal]
reg        usb_ep0_cfg_int_rx_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_cfg_int_rx_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'hc))
    usb_ep0_cfg_int_rx_q <= cfg_wdata_i[3:3];

wire        usb_ep0_cfg_int_rx_out_w = usb_ep0_cfg_int_rx_q;


// usb_ep0_cfg_int_tx [internal]
reg        usb_ep0_cfg_int_tx_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_cfg_int_tx_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'hc))
    usb_ep0_cfg_int_tx_q <= cfg_wdata_i[2:2];

wire        usb_ep0_cfg_int_tx_out_w = usb_ep0_cfg_int_tx_q;


// usb_ep0_cfg_stall_ep [clearable]
reg        usb_ep0_cfg_stall_ep_q;

wire usb_ep0_cfg_stall_ep_ack_in_w;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_cfg_stall_ep_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'hc))
    usb_ep0_cfg_stall_ep_q <= cfg_wdata_i[1:1];
else if (usb_ep0_cfg_stall_ep_ack_in_w)
    usb_ep0_cfg_stall_ep_q <= 1'b0;

wire        usb_ep0_cfg_stall_ep_out_w = usb_ep0_cfg_stall_ep_q;


// usb_ep0_cfg_iso [internal]
reg        usb_ep0_cfg_iso_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_cfg_iso_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'hc))
    usb_ep0_cfg_iso_q <= cfg_wdata_i[0:0];

wire        usb_ep0_cfg_iso_out_w = usb_ep0_cfg_iso_q;


//-----------------------------------------------------------------
// Register usb_ep0_tx_ctrl
//-----------------------------------------------------------------
reg usb_ep0_tx_ctrl_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_tx_ctrl_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h10))
    usb_ep0_tx_ctrl_wr_q <= 1'b1;
else
    usb_ep0_tx_ctrl_wr_q <= 1'b0;

// usb_ep0_tx_ctrl_tx_flush [auto_clr]
reg        usb_ep0_tx_ctrl_tx_flush_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_tx_ctrl_tx_flush_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h10))
    usb_ep0_tx_ctrl_tx_flush_q <= cfg_wdata_i[17:17];
else
    usb_ep0_tx_ctrl_tx_flush_q <= 1'd0;

wire        usb_ep0_tx_ctrl_tx_flush_out_w = usb_ep0_tx_ctrl_tx_flush_q;


// usb_ep0_tx_ctrl_tx_start [auto_clr]
reg        usb_ep0_tx_ctrl_tx_start_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_tx_ctrl_tx_start_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h10))
    usb_ep0_tx_ctrl_tx_start_q <= cfg_wdata_i[16:16];
else
    usb_ep0_tx_ctrl_tx_start_q <= 1'd0;

wire        usb_ep0_tx_ctrl_tx_start_out_w = usb_ep0_tx_ctrl_tx_start_q;


// usb_ep0_tx_ctrl_tx_len [internal]
reg [10:0]  usb_ep0_tx_ctrl_tx_len_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_tx_ctrl_tx_len_q <= 11'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h10))
    usb_ep0_tx_ctrl_tx_len_q <= cfg_wdata_i[10:0];

wire [10:0]  usb_ep0_tx_ctrl_tx_len_out_w = usb_ep0_tx_ctrl_tx_len_q;


//-----------------------------------------------------------------
// Register usb_ep0_rx_ctrl
//-----------------------------------------------------------------
reg usb_ep0_rx_ctrl_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_rx_ctrl_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h14))
    usb_ep0_rx_ctrl_wr_q <= 1'b1;
else
    usb_ep0_rx_ctrl_wr_q <= 1'b0;

// usb_ep0_rx_ctrl_rx_flush [auto_clr]
reg        usb_ep0_rx_ctrl_rx_flush_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_rx_ctrl_rx_flush_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h14))
    usb_ep0_rx_ctrl_rx_flush_q <= cfg_wdata_i[1:1];
else
    usb_ep0_rx_ctrl_rx_flush_q <= 1'd0;

wire        usb_ep0_rx_ctrl_rx_flush_out_w = usb_ep0_rx_ctrl_rx_flush_q;


// usb_ep0_rx_ctrl_rx_accept [auto_clr]
reg        usb_ep0_rx_ctrl_rx_accept_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_rx_ctrl_rx_accept_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h14))
    usb_ep0_rx_ctrl_rx_accept_q <= cfg_wdata_i[0:0];
else
    usb_ep0_rx_ctrl_rx_accept_q <= 1'd0;

wire        usb_ep0_rx_ctrl_rx_accept_out_w = usb_ep0_rx_ctrl_rx_accept_q;


//-----------------------------------------------------------------
// Register usb_ep0_sts
//-----------------------------------------------------------------
reg usb_ep0_sts_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_sts_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h18))
    usb_ep0_sts_wr_q <= 1'b1;
else
    usb_ep0_sts_wr_q <= 1'b0;







//-----------------------------------------------------------------
// Register usb_ep0_data
//-----------------------------------------------------------------
reg usb_ep0_data_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep0_data_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h1c))
    usb_ep0_data_wr_q <= 1'b1;
else
    usb_ep0_data_wr_q <= 1'b0;

// usb_ep0_data_data [external]
wire [7:0]  usb_ep0_data_data_out_w = wr_data_q[7:0];


//-----------------------------------------------------------------
// Register usb_ep1_cfg
//-----------------------------------------------------------------
reg usb_ep1_cfg_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_cfg_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h20))
    usb_ep1_cfg_wr_q <= 1'b1;
else
    usb_ep1_cfg_wr_q <= 1'b0;

// usb_ep1_cfg_int_rx [internal]
reg        usb_ep1_cfg_int_rx_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_cfg_int_rx_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h20))
    usb_ep1_cfg_int_rx_q <= cfg_wdata_i[3:3];

wire        usb_ep1_cfg_int_rx_out_w = usb_ep1_cfg_int_rx_q;


// usb_ep1_cfg_int_tx [internal]
reg        usb_ep1_cfg_int_tx_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_cfg_int_tx_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h20))
    usb_ep1_cfg_int_tx_q <= cfg_wdata_i[2:2];

wire        usb_ep1_cfg_int_tx_out_w = usb_ep1_cfg_int_tx_q;


// usb_ep1_cfg_stall_ep [clearable]
reg        usb_ep1_cfg_stall_ep_q;

wire usb_ep1_cfg_stall_ep_ack_in_w;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_cfg_stall_ep_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h20))
    usb_ep1_cfg_stall_ep_q <= cfg_wdata_i[1:1];
else if (usb_ep1_cfg_stall_ep_ack_in_w)
    usb_ep1_cfg_stall_ep_q <= 1'b0;

wire        usb_ep1_cfg_stall_ep_out_w = usb_ep1_cfg_stall_ep_q;


// usb_ep1_cfg_iso [internal]
reg        usb_ep1_cfg_iso_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_cfg_iso_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h20))
    usb_ep1_cfg_iso_q <= cfg_wdata_i[0:0];

wire        usb_ep1_cfg_iso_out_w = usb_ep1_cfg_iso_q;


//-----------------------------------------------------------------
// Register usb_ep1_tx_ctrl
//-----------------------------------------------------------------
reg usb_ep1_tx_ctrl_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_tx_ctrl_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h24))
    usb_ep1_tx_ctrl_wr_q <= 1'b1;
else
    usb_ep1_tx_ctrl_wr_q <= 1'b0;

// usb_ep1_tx_ctrl_tx_flush [auto_clr]
reg        usb_ep1_tx_ctrl_tx_flush_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_tx_ctrl_tx_flush_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h24))
    usb_ep1_tx_ctrl_tx_flush_q <= cfg_wdata_i[17:17];
else
    usb_ep1_tx_ctrl_tx_flush_q <= 1'd0;

wire        usb_ep1_tx_ctrl_tx_flush_out_w = usb_ep1_tx_ctrl_tx_flush_q;


// usb_ep1_tx_ctrl_tx_start [auto_clr]
reg        usb_ep1_tx_ctrl_tx_start_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_tx_ctrl_tx_start_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h24))
    usb_ep1_tx_ctrl_tx_start_q <= cfg_wdata_i[16:16];
else
    usb_ep1_tx_ctrl_tx_start_q <= 1'd0;

wire        usb_ep1_tx_ctrl_tx_start_out_w = usb_ep1_tx_ctrl_tx_start_q;


// usb_ep1_tx_ctrl_tx_len [internal]
reg [10:0]  usb_ep1_tx_ctrl_tx_len_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_tx_ctrl_tx_len_q <= 11'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h24))
    usb_ep1_tx_ctrl_tx_len_q <= cfg_wdata_i[10:0];

wire [10:0]  usb_ep1_tx_ctrl_tx_len_out_w = usb_ep1_tx_ctrl_tx_len_q;


//-----------------------------------------------------------------
// Register usb_ep1_rx_ctrl
//-----------------------------------------------------------------
reg usb_ep1_rx_ctrl_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_rx_ctrl_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h28))
    usb_ep1_rx_ctrl_wr_q <= 1'b1;
else
    usb_ep1_rx_ctrl_wr_q <= 1'b0;

// usb_ep1_rx_ctrl_rx_flush [auto_clr]
reg        usb_ep1_rx_ctrl_rx_flush_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_rx_ctrl_rx_flush_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h28))
    usb_ep1_rx_ctrl_rx_flush_q <= cfg_wdata_i[1:1];
else
    usb_ep1_rx_ctrl_rx_flush_q <= 1'd0;

wire        usb_ep1_rx_ctrl_rx_flush_out_w = usb_ep1_rx_ctrl_rx_flush_q;


// usb_ep1_rx_ctrl_rx_accept [auto_clr]
reg        usb_ep1_rx_ctrl_rx_accept_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_rx_ctrl_rx_accept_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h28))
    usb_ep1_rx_ctrl_rx_accept_q <= cfg_wdata_i[0:0];
else
    usb_ep1_rx_ctrl_rx_accept_q <= 1'd0;

wire        usb_ep1_rx_ctrl_rx_accept_out_w = usb_ep1_rx_ctrl_rx_accept_q;


//-----------------------------------------------------------------
// Register usb_ep1_sts
//-----------------------------------------------------------------
reg usb_ep1_sts_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_sts_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h2c))
    usb_ep1_sts_wr_q <= 1'b1;
else
    usb_ep1_sts_wr_q <= 1'b0;







//-----------------------------------------------------------------
// Register usb_ep1_data
//-----------------------------------------------------------------
reg usb_ep1_data_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep1_data_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h30))
    usb_ep1_data_wr_q <= 1'b1;
else
    usb_ep1_data_wr_q <= 1'b0;

// usb_ep1_data_data [external]
wire [7:0]  usb_ep1_data_data_out_w = wr_data_q[7:0];


//-----------------------------------------------------------------
// Register usb_ep2_cfg
//-----------------------------------------------------------------
reg usb_ep2_cfg_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_cfg_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h34))
    usb_ep2_cfg_wr_q <= 1'b1;
else
    usb_ep2_cfg_wr_q <= 1'b0;

// usb_ep2_cfg_int_rx [internal]
reg        usb_ep2_cfg_int_rx_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_cfg_int_rx_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h34))
    usb_ep2_cfg_int_rx_q <= cfg_wdata_i[3:3];

wire        usb_ep2_cfg_int_rx_out_w = usb_ep2_cfg_int_rx_q;


// usb_ep2_cfg_int_tx [internal]
reg        usb_ep2_cfg_int_tx_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_cfg_int_tx_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h34))
    usb_ep2_cfg_int_tx_q <= cfg_wdata_i[2:2];

wire        usb_ep2_cfg_int_tx_out_w = usb_ep2_cfg_int_tx_q;


// usb_ep2_cfg_stall_ep [clearable]
reg        usb_ep2_cfg_stall_ep_q;

wire usb_ep2_cfg_stall_ep_ack_in_w;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_cfg_stall_ep_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h34))
    usb_ep2_cfg_stall_ep_q <= cfg_wdata_i[1:1];
else if (usb_ep2_cfg_stall_ep_ack_in_w)
    usb_ep2_cfg_stall_ep_q <= 1'b0;

wire        usb_ep2_cfg_stall_ep_out_w = usb_ep2_cfg_stall_ep_q;


// usb_ep2_cfg_iso [internal]
reg        usb_ep2_cfg_iso_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_cfg_iso_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h34))
    usb_ep2_cfg_iso_q <= cfg_wdata_i[0:0];

wire        usb_ep2_cfg_iso_out_w = usb_ep2_cfg_iso_q;


//-----------------------------------------------------------------
// Register usb_ep2_tx_ctrl
//-----------------------------------------------------------------
reg usb_ep2_tx_ctrl_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_tx_ctrl_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h38))
    usb_ep2_tx_ctrl_wr_q <= 1'b1;
else
    usb_ep2_tx_ctrl_wr_q <= 1'b0;

// usb_ep2_tx_ctrl_tx_flush [auto_clr]
reg        usb_ep2_tx_ctrl_tx_flush_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_tx_ctrl_tx_flush_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h38))
    usb_ep2_tx_ctrl_tx_flush_q <= cfg_wdata_i[17:17];
else
    usb_ep2_tx_ctrl_tx_flush_q <= 1'd0;

wire        usb_ep2_tx_ctrl_tx_flush_out_w = usb_ep2_tx_ctrl_tx_flush_q;


// usb_ep2_tx_ctrl_tx_start [auto_clr]
reg        usb_ep2_tx_ctrl_tx_start_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_tx_ctrl_tx_start_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h38))
    usb_ep2_tx_ctrl_tx_start_q <= cfg_wdata_i[16:16];
else
    usb_ep2_tx_ctrl_tx_start_q <= 1'd0;

wire        usb_ep2_tx_ctrl_tx_start_out_w = usb_ep2_tx_ctrl_tx_start_q;


// usb_ep2_tx_ctrl_tx_len [internal]
reg [10:0]  usb_ep2_tx_ctrl_tx_len_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_tx_ctrl_tx_len_q <= 11'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h38))
    usb_ep2_tx_ctrl_tx_len_q <= cfg_wdata_i[10:0];

wire [10:0]  usb_ep2_tx_ctrl_tx_len_out_w = usb_ep2_tx_ctrl_tx_len_q;


//-----------------------------------------------------------------
// Register usb_ep2_rx_ctrl
//-----------------------------------------------------------------
reg usb_ep2_rx_ctrl_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_rx_ctrl_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h3c))
    usb_ep2_rx_ctrl_wr_q <= 1'b1;
else
    usb_ep2_rx_ctrl_wr_q <= 1'b0;

// usb_ep2_rx_ctrl_rx_flush [auto_clr]
reg        usb_ep2_rx_ctrl_rx_flush_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_rx_ctrl_rx_flush_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h3c))
    usb_ep2_rx_ctrl_rx_flush_q <= cfg_wdata_i[1:1];
else
    usb_ep2_rx_ctrl_rx_flush_q <= 1'd0;

wire        usb_ep2_rx_ctrl_rx_flush_out_w = usb_ep2_rx_ctrl_rx_flush_q;


// usb_ep2_rx_ctrl_rx_accept [auto_clr]
reg        usb_ep2_rx_ctrl_rx_accept_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_rx_ctrl_rx_accept_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h3c))
    usb_ep2_rx_ctrl_rx_accept_q <= cfg_wdata_i[0:0];
else
    usb_ep2_rx_ctrl_rx_accept_q <= 1'd0;

wire        usb_ep2_rx_ctrl_rx_accept_out_w = usb_ep2_rx_ctrl_rx_accept_q;


//-----------------------------------------------------------------
// Register usb_ep2_sts
//-----------------------------------------------------------------
reg usb_ep2_sts_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_sts_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h40))
    usb_ep2_sts_wr_q <= 1'b1;
else
    usb_ep2_sts_wr_q <= 1'b0;







//-----------------------------------------------------------------
// Register usb_ep2_data
//-----------------------------------------------------------------
reg usb_ep2_data_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep2_data_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h44))
    usb_ep2_data_wr_q <= 1'b1;
else
    usb_ep2_data_wr_q <= 1'b0;

// usb_ep2_data_data [external]
wire [7:0]  usb_ep2_data_data_out_w = wr_data_q[7:0];


//-----------------------------------------------------------------
// Register usb_ep3_cfg
//-----------------------------------------------------------------
reg usb_ep3_cfg_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_cfg_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h48))
    usb_ep3_cfg_wr_q <= 1'b1;
else
    usb_ep3_cfg_wr_q <= 1'b0;

// usb_ep3_cfg_int_rx [internal]
reg        usb_ep3_cfg_int_rx_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_cfg_int_rx_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h48))
    usb_ep3_cfg_int_rx_q <= cfg_wdata_i[3:3];

wire        usb_ep3_cfg_int_rx_out_w = usb_ep3_cfg_int_rx_q;


// usb_ep3_cfg_int_tx [internal]
reg        usb_ep3_cfg_int_tx_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_cfg_int_tx_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h48))
    usb_ep3_cfg_int_tx_q <= cfg_wdata_i[2:2];

wire        usb_ep3_cfg_int_tx_out_w = usb_ep3_cfg_int_tx_q;


// usb_ep3_cfg_stall_ep [clearable]
reg        usb_ep3_cfg_stall_ep_q;

wire usb_ep3_cfg_stall_ep_ack_in_w;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_cfg_stall_ep_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h48))
    usb_ep3_cfg_stall_ep_q <= cfg_wdata_i[1:1];
else if (usb_ep3_cfg_stall_ep_ack_in_w)
    usb_ep3_cfg_stall_ep_q <= 1'b0;

wire        usb_ep3_cfg_stall_ep_out_w = usb_ep3_cfg_stall_ep_q;


// usb_ep3_cfg_iso [internal]
reg        usb_ep3_cfg_iso_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_cfg_iso_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h48))
    usb_ep3_cfg_iso_q <= cfg_wdata_i[0:0];

wire        usb_ep3_cfg_iso_out_w = usb_ep3_cfg_iso_q;


//-----------------------------------------------------------------
// Register usb_ep3_tx_ctrl
//-----------------------------------------------------------------
reg usb_ep3_tx_ctrl_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_tx_ctrl_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h4c))
    usb_ep3_tx_ctrl_wr_q <= 1'b1;
else
    usb_ep3_tx_ctrl_wr_q <= 1'b0;

// usb_ep3_tx_ctrl_tx_flush [auto_clr]
reg        usb_ep3_tx_ctrl_tx_flush_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_tx_ctrl_tx_flush_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h4c))
    usb_ep3_tx_ctrl_tx_flush_q <= cfg_wdata_i[17:17];
else
    usb_ep3_tx_ctrl_tx_flush_q <= 1'd0;

wire        usb_ep3_tx_ctrl_tx_flush_out_w = usb_ep3_tx_ctrl_tx_flush_q;


// usb_ep3_tx_ctrl_tx_start [auto_clr]
reg        usb_ep3_tx_ctrl_tx_start_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_tx_ctrl_tx_start_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h4c))
    usb_ep3_tx_ctrl_tx_start_q <= cfg_wdata_i[16:16];
else
    usb_ep3_tx_ctrl_tx_start_q <= 1'd0;

wire        usb_ep3_tx_ctrl_tx_start_out_w = usb_ep3_tx_ctrl_tx_start_q;


// usb_ep3_tx_ctrl_tx_len [internal]
reg [10:0]  usb_ep3_tx_ctrl_tx_len_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_tx_ctrl_tx_len_q <= 11'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h4c))
    usb_ep3_tx_ctrl_tx_len_q <= cfg_wdata_i[10:0];

wire [10:0]  usb_ep3_tx_ctrl_tx_len_out_w = usb_ep3_tx_ctrl_tx_len_q;


//-----------------------------------------------------------------
// Register usb_ep3_rx_ctrl
//-----------------------------------------------------------------
reg usb_ep3_rx_ctrl_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_rx_ctrl_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h50))
    usb_ep3_rx_ctrl_wr_q <= 1'b1;
else
    usb_ep3_rx_ctrl_wr_q <= 1'b0;

// usb_ep3_rx_ctrl_rx_flush [auto_clr]
reg        usb_ep3_rx_ctrl_rx_flush_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_rx_ctrl_rx_flush_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h50))
    usb_ep3_rx_ctrl_rx_flush_q <= cfg_wdata_i[1:1];
else
    usb_ep3_rx_ctrl_rx_flush_q <= 1'd0;

wire        usb_ep3_rx_ctrl_rx_flush_out_w = usb_ep3_rx_ctrl_rx_flush_q;


// usb_ep3_rx_ctrl_rx_accept [auto_clr]
reg        usb_ep3_rx_ctrl_rx_accept_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_rx_ctrl_rx_accept_q <= 1'd0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h50))
    usb_ep3_rx_ctrl_rx_accept_q <= cfg_wdata_i[0:0];
else
    usb_ep3_rx_ctrl_rx_accept_q <= 1'd0;

wire        usb_ep3_rx_ctrl_rx_accept_out_w = usb_ep3_rx_ctrl_rx_accept_q;


//-----------------------------------------------------------------
// Register usb_ep3_sts
//-----------------------------------------------------------------
reg usb_ep3_sts_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_sts_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h54))
    usb_ep3_sts_wr_q <= 1'b1;
else
    usb_ep3_sts_wr_q <= 1'b0;







//-----------------------------------------------------------------
// Register usb_ep3_data
//-----------------------------------------------------------------
reg usb_ep3_data_wr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    usb_ep3_data_wr_q <= 1'b0;
else if (write_en_w && (cfg_awaddr_i[7:0] == 8'h58))
    usb_ep3_data_wr_q <= 1'b1;
else
    usb_ep3_data_wr_q <= 1'b0;

// usb_ep3_data_data [external]
wire [7:0]  usb_ep3_data_data_out_w = wr_data_q[7:0];


wire        usb_func_stat_rst_in_w;
wire [1:0]  usb_func_stat_linestate_in_w;
wire [10:0]  usb_func_stat_frame_in_w;
wire        usb_ep0_sts_tx_err_in_w;
wire        usb_ep0_sts_tx_busy_in_w;
wire        usb_ep0_sts_rx_err_in_w;
wire        usb_ep0_sts_rx_setup_in_w;
wire        usb_ep0_sts_rx_ready_in_w;
wire [10:0]  usb_ep0_sts_rx_count_in_w;
wire [7:0]  usb_ep0_data_data_in_w;
wire        usb_ep1_sts_tx_err_in_w;
wire        usb_ep1_sts_tx_busy_in_w;
wire        usb_ep1_sts_rx_err_in_w;
wire        usb_ep1_sts_rx_setup_in_w;
wire        usb_ep1_sts_rx_ready_in_w;
wire [10:0]  usb_ep1_sts_rx_count_in_w;
wire [7:0]  usb_ep1_data_data_in_w;
wire        usb_ep2_sts_tx_err_in_w;
wire        usb_ep2_sts_tx_busy_in_w;
wire        usb_ep2_sts_rx_err_in_w;
wire        usb_ep2_sts_rx_setup_in_w;
wire        usb_ep2_sts_rx_ready_in_w;
wire [10:0]  usb_ep2_sts_rx_count_in_w;
wire [7:0]  usb_ep2_data_data_in_w;
wire        usb_ep3_sts_tx_err_in_w;
wire        usb_ep3_sts_tx_busy_in_w;
wire        usb_ep3_sts_rx_err_in_w;
wire        usb_ep3_sts_rx_setup_in_w;
wire        usb_ep3_sts_rx_ready_in_w;
wire [10:0]  usb_ep3_sts_rx_count_in_w;
wire [7:0]  usb_ep3_data_data_in_w;


//-----------------------------------------------------------------
// Read mux
//-----------------------------------------------------------------
reg [31:0] data_r;

always @ *
begin
    data_r = 32'b0;

    case (cfg_araddr_i[7:0])

    8'h0:
    begin
        data_r[8:8] = usb_func_ctrl_hs_chirp_en_q;
        data_r[7:7] = usb_func_ctrl_phy_dmpulldown_q;
        data_r[6:6] = usb_func_ctrl_phy_dppulldown_q;
        data_r[5:5] = usb_func_ctrl_phy_termselect_q;
        data_r[4:3] = usb_func_ctrl_phy_xcvrselect_q;
        data_r[2:1] = usb_func_ctrl_phy_opmode_q;
        data_r[0:0] = usb_func_ctrl_int_en_sof_q;
    end
    8'h4:
    begin
        data_r[13:13] = usb_func_stat_rst_in_w;
        data_r[12:11] = usb_func_stat_linestate_in_w;
        data_r[10:0] = usb_func_stat_frame_in_w;
    end
    8'h8:
    begin
        data_r[6:0] = usb_func_addr_dev_addr_q;
    end
    8'hc:
    begin
        data_r[3:3] = usb_ep0_cfg_int_rx_q;
        data_r[2:2] = usb_ep0_cfg_int_tx_q;
        data_r[0:0] = usb_ep0_cfg_iso_q;
    end
    8'h10:
    begin
        data_r[10:0] = usb_ep0_tx_ctrl_tx_len_q;
    end
    8'h18:
    begin
        data_r[20:20] = usb_ep0_sts_tx_err_in_w;
        data_r[19:19] = usb_ep0_sts_tx_busy_in_w;
        data_r[18:18] = usb_ep0_sts_rx_err_in_w;
        data_r[17:17] = usb_ep0_sts_rx_setup_in_w;
        data_r[16:16] = usb_ep0_sts_rx_ready_in_w;
        data_r[10:0] = usb_ep0_sts_rx_count_in_w;
    end
    8'h1c:
    begin
        data_r[7:0] = usb_ep0_data_data_in_w;
    end
    8'h20:
    begin
        data_r[3:3] = usb_ep1_cfg_int_rx_q;
        data_r[2:2] = usb_ep1_cfg_int_tx_q;
        data_r[0:0] = usb_ep1_cfg_iso_q;
    end
    8'h24:
    begin
        data_r[10:0] = usb_ep1_tx_ctrl_tx_len_q;
    end
    8'h2c:
    begin
        data_r[20:20] = usb_ep1_sts_tx_err_in_w;
        data_r[19:19] = usb_ep1_sts_tx_busy_in_w;
        data_r[18:18] = usb_ep1_sts_rx_err_in_w;
        data_r[17:17] = usb_ep1_sts_rx_setup_in_w;
        data_r[16:16] = usb_ep1_sts_rx_ready_in_w;
        data_r[10:0] = usb_ep1_sts_rx_count_in_w;
    end
    8'h30:
    begin
        data_r[7:0] = usb_ep1_data_data_in_w;
    end
    8'h34:
    begin
        data_r[3:3] = usb_ep2_cfg_int_rx_q;
        data_r[2:2] = usb_ep2_cfg_int_tx_q;
        data_r[0:0] = usb_ep2_cfg_iso_q;
    end
    8'h38:
    begin
        data_r[10:0] = usb_ep2_tx_ctrl_tx_len_q;
    end
    8'h40:
    begin
        data_r[20:20] = usb_ep2_sts_tx_err_in_w;
        data_r[19:19] = usb_ep2_sts_tx_busy_in_w;
        data_r[18:18] = usb_ep2_sts_rx_err_in_w;
        data_r[17:17] = usb_ep2_sts_rx_setup_in_w;
        data_r[16:16] = usb_ep2_sts_rx_ready_in_w;
        data_r[10:0] = usb_ep2_sts_rx_count_in_w;
    end
    8'h44:
    begin
        data_r[7:0] = usb_ep2_data_data_in_w;
    end
    8'h48:
    begin
        data_r[3:3] = usb_ep3_cfg_int_rx_q;
        data_r[2:2] = usb_ep3_cfg_int_tx_q;
        data_r[0:0] = usb_ep3_cfg_iso_q;
    end
    8'h4c:
    begin
        data_r[10:0] = usb_ep3_tx_ctrl_tx_len_q;
    end
    8'h54:
    begin
        data_r[20:20] = usb_ep3_sts_tx_err_in_w;
        data_r[19:19] = usb_ep3_sts_tx_busy_in_w;
        data_r[18:18] = usb_ep3_sts_rx_err_in_w;
        data_r[17:17] = usb_ep3_sts_rx_setup_in_w;
        data_r[16:16] = usb_ep3_sts_rx_ready_in_w;
        data_r[10:0] = usb_ep3_sts_rx_count_in_w;
    end
    8'h58:
    begin
        data_r[7:0] = usb_ep3_data_data_in_w;
    end
    default :
        data_r = 32'b0;
    endcase
end

//-----------------------------------------------------------------
// RVALID
//-----------------------------------------------------------------
reg rvalid_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rvalid_q <= 1'b0;
else if (read_en_w)
    rvalid_q <= 1'b1;
else if (cfg_rready_i)
    rvalid_q <= 1'b0;

assign cfg_rvalid_o = rvalid_q;

//-----------------------------------------------------------------
// Retime read response
//-----------------------------------------------------------------
reg [31:0] rd_data_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rd_data_q <= 32'b0;
else if (!cfg_rvalid_o || cfg_rready_i)
    rd_data_q <= data_r;

assign cfg_rdata_o = rd_data_q;
assign cfg_rresp_o = 2'b0;

//-----------------------------------------------------------------
// BVALID
//-----------------------------------------------------------------
reg bvalid_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    bvalid_q <= 1'b0;
else if (write_en_w)
    bvalid_q <= 1'b1;
else if (cfg_bready_i)
    bvalid_q <= 1'b0;

assign cfg_bvalid_o = bvalid_q;
assign cfg_bresp_o  = 2'b0;

wire usb_ep0_data_rd_req_w = read_en_w & (cfg_araddr_i[7:0] == 8'h1c);
wire usb_ep1_data_rd_req_w = read_en_w & (cfg_araddr_i[7:0] == 8'h30);
wire usb_ep2_data_rd_req_w = read_en_w & (cfg_araddr_i[7:0] == 8'h44);
wire usb_ep3_data_rd_req_w = read_en_w & (cfg_araddr_i[7:0] == 8'h58);

wire usb_func_stat_wr_req_w = usb_func_stat_wr_q;
wire usb_ep0_data_wr_req_w = usb_ep0_data_wr_q;
wire usb_ep1_data_wr_req_w = usb_ep1_data_wr_q;
wire usb_ep2_data_wr_req_w = usb_ep2_data_wr_q;
wire usb_ep3_data_wr_req_w = usb_ep3_data_wr_q;


//-----------------------------------------------------------------
// Wires
//-----------------------------------------------------------------
wire          stat_rst_w;
wire  [10:0]  stat_frame_w;
wire          stat_rst_clr_w = usb_func_stat_rst_out_w;
wire          stat_wr_req_w  = usb_func_stat_wr_req_w;

wire         usb_ep0_tx_rd_w;
wire [7:0]   usb_ep0_tx_data_w;
wire         usb_ep0_tx_empty_w;

wire         usb_ep0_rx_wr_w;
wire [7:0]   usb_ep0_rx_data_w;
wire         usb_ep0_rx_full_w;
wire         usb_ep1_tx_rd_w;
wire [7:0]   usb_ep1_tx_data_w;
wire         usb_ep1_tx_empty_w;

wire         usb_ep1_rx_wr_w;
wire [7:0]   usb_ep1_rx_data_w;
wire         usb_ep1_rx_full_w;
wire         usb_ep2_tx_rd_w;
wire [7:0]   usb_ep2_tx_data_w;
wire         usb_ep2_tx_empty_w;

wire         usb_ep2_rx_wr_w;
wire [7:0]   usb_ep2_rx_data_w;
wire         usb_ep2_rx_full_w;
wire         usb_ep3_tx_rd_w;
wire [7:0]   usb_ep3_tx_data_w;
wire         usb_ep3_tx_empty_w;

wire         usb_ep3_rx_wr_w;
wire [7:0]   usb_ep3_rx_data_w;
wire         usb_ep3_rx_full_w;

// Rx SIE Interface (shared)
wire        rx_strb_w;
wire [7:0]  rx_data_w;
wire        rx_last_w;
wire        rx_crc_err_w;

// EP0 Rx SIE Interface
wire        ep0_rx_space_w;
wire        ep0_rx_valid_w;
wire        ep0_rx_setup_w;

// EP0 Tx SIE Interface
wire        ep0_tx_ready_w;
wire        ep0_tx_data_valid_w;
wire        ep0_tx_data_strb_w;
wire [7:0]  ep0_tx_data_w;
wire        ep0_tx_data_last_w;
wire        ep0_tx_data_accept_w;
// EP1 Rx SIE Interface
wire        ep1_rx_space_w;
wire        ep1_rx_valid_w;
wire        ep1_rx_setup_w;

// EP1 Tx SIE Interface
wire        ep1_tx_ready_w;
wire        ep1_tx_data_valid_w;
wire        ep1_tx_data_strb_w;
wire [7:0]  ep1_tx_data_w;
wire        ep1_tx_data_last_w;
wire        ep1_tx_data_accept_w;
// EP2 Rx SIE Interface
wire        ep2_rx_space_w;
wire        ep2_rx_valid_w;
wire        ep2_rx_setup_w;

// EP2 Tx SIE Interface
wire        ep2_tx_ready_w;
wire        ep2_tx_data_valid_w;
wire        ep2_tx_data_strb_w;
wire [7:0]  ep2_tx_data_w;
wire        ep2_tx_data_last_w;
wire        ep2_tx_data_accept_w;
// EP3 Rx SIE Interface
wire        ep3_rx_space_w;
wire        ep3_rx_valid_w;
wire        ep3_rx_setup_w;

// EP3 Tx SIE Interface
wire        ep3_tx_ready_w;
wire        ep3_tx_data_valid_w;
wire        ep3_tx_data_strb_w;
wire [7:0]  ep3_tx_data_w;
wire        ep3_tx_data_last_w;
wire        ep3_tx_data_accept_w;

// Transceiver Control
assign utmi_dmpulldown_o            = usb_func_ctrl_phy_dmpulldown_out_w;
assign utmi_dppulldown_o            = usb_func_ctrl_phy_dppulldown_out_w;
assign utmi_termselect_o            = usb_func_ctrl_phy_termselect_out_w;
assign utmi_xcvrselect_o            = usb_func_ctrl_phy_xcvrselect_out_w;
assign utmi_op_mode_o               = usb_func_ctrl_phy_opmode_out_w;

// Status
assign usb_func_stat_rst_in_w       = stat_rst_w;
assign usb_func_stat_linestate_in_w = utmi_linestate_i;
assign usb_func_stat_frame_in_w     = stat_frame_w;

//-----------------------------------------------------------------
// Core
//-----------------------------------------------------------------
usbf_device_core
u_core
(
    .clk_i(clk_i),
    .rst_i(rst_i),

    .intr_o(intr_o),

    // UTMI interface
    .utmi_data_o(utmi_data_out_o),
    .utmi_data_i(utmi_data_in_i),
    .utmi_txvalid_o(utmi_txvalid_o),
    .utmi_txready_i(utmi_txready_i),
    .utmi_rxvalid_i(utmi_rxvalid_i),
    .utmi_rxactive_i(utmi_rxactive_i),
    .utmi_rxerror_i(utmi_rxerror_i),
    .utmi_linestate_i(utmi_linestate_i),

    .reg_chirp_en_i(usb_func_ctrl_hs_chirp_en_out_w),
    .reg_int_en_sof_i(usb_func_ctrl_int_en_sof_out_w),

    .reg_dev_addr_i(usb_func_addr_dev_addr_out_w),

    // Rx SIE Interface (shared)
    .rx_strb_o(rx_strb_w),
    .rx_data_o(rx_data_w),
    .rx_last_o(rx_last_w),
    .rx_crc_err_o(rx_crc_err_w),

    // EP0 Config
    .ep0_iso_i(usb_ep0_cfg_iso_out_w),
    .ep0_stall_i(usb_ep0_cfg_stall_ep_out_w),
    .ep0_cfg_int_rx_i(usb_ep0_cfg_int_rx_out_w),
    .ep0_cfg_int_tx_i(usb_ep0_cfg_int_tx_out_w),    

    // EP0 Rx SIE Interface
    .ep0_rx_setup_o(ep0_rx_setup_w),
    .ep0_rx_valid_o(ep0_rx_valid_w),
    .ep0_rx_space_i(ep0_rx_space_w),

    // EP0 Tx SIE Interface
    .ep0_tx_ready_i(ep0_tx_ready_w),
    .ep0_tx_data_valid_i(ep0_tx_data_valid_w),
    .ep0_tx_data_strb_i(ep0_tx_data_strb_w),
    .ep0_tx_data_i(ep0_tx_data_w),
    .ep0_tx_data_last_i(ep0_tx_data_last_w),
    .ep0_tx_data_accept_o(ep0_tx_data_accept_w),

    // EP1 Config
    .ep1_iso_i(usb_ep1_cfg_iso_out_w),
    .ep1_stall_i(usb_ep1_cfg_stall_ep_out_w),
    .ep1_cfg_int_rx_i(usb_ep1_cfg_int_rx_out_w),
    .ep1_cfg_int_tx_i(usb_ep1_cfg_int_tx_out_w),    

    // EP1 Rx SIE Interface
    .ep1_rx_setup_o(ep1_rx_setup_w),
    .ep1_rx_valid_o(ep1_rx_valid_w),
    .ep1_rx_space_i(ep1_rx_space_w),

    // EP1 Tx SIE Interface
    .ep1_tx_ready_i(ep1_tx_ready_w),
    .ep1_tx_data_valid_i(ep1_tx_data_valid_w),
    .ep1_tx_data_strb_i(ep1_tx_data_strb_w),
    .ep1_tx_data_i(ep1_tx_data_w),
    .ep1_tx_data_last_i(ep1_tx_data_last_w),
    .ep1_tx_data_accept_o(ep1_tx_data_accept_w),

    // EP2 Config
    .ep2_iso_i(usb_ep2_cfg_iso_out_w),
    .ep2_stall_i(usb_ep2_cfg_stall_ep_out_w),
    .ep2_cfg_int_rx_i(usb_ep2_cfg_int_rx_out_w),
    .ep2_cfg_int_tx_i(usb_ep2_cfg_int_tx_out_w),    

    // EP2 Rx SIE Interface
    .ep2_rx_setup_o(ep2_rx_setup_w),
    .ep2_rx_valid_o(ep2_rx_valid_w),
    .ep2_rx_space_i(ep2_rx_space_w),

    // EP2 Tx SIE Interface
    .ep2_tx_ready_i(ep2_tx_ready_w),
    .ep2_tx_data_valid_i(ep2_tx_data_valid_w),
    .ep2_tx_data_strb_i(ep2_tx_data_strb_w),
    .ep2_tx_data_i(ep2_tx_data_w),
    .ep2_tx_data_last_i(ep2_tx_data_last_w),
    .ep2_tx_data_accept_o(ep2_tx_data_accept_w),

    // EP3 Config
    .ep3_iso_i(usb_ep3_cfg_iso_out_w),
    .ep3_stall_i(usb_ep3_cfg_stall_ep_out_w),
    .ep3_cfg_int_rx_i(usb_ep3_cfg_int_rx_out_w),
    .ep3_cfg_int_tx_i(usb_ep3_cfg_int_tx_out_w),    

    // EP3 Rx SIE Interface
    .ep3_rx_setup_o(ep3_rx_setup_w),
    .ep3_rx_valid_o(ep3_rx_valid_w),
    .ep3_rx_space_i(ep3_rx_space_w),

    // EP3 Tx SIE Interface
    .ep3_tx_ready_i(ep3_tx_ready_w),
    .ep3_tx_data_valid_i(ep3_tx_data_valid_w),
    .ep3_tx_data_strb_i(ep3_tx_data_strb_w),
    .ep3_tx_data_i(ep3_tx_data_w),
    .ep3_tx_data_last_i(ep3_tx_data_last_w),
    .ep3_tx_data_accept_o(ep3_tx_data_accept_w),

    // Status
    .reg_sts_rst_clr_i(stat_rst_clr_w & stat_wr_req_w),
    .reg_sts_rst_o(stat_rst_w),
    .reg_sts_frame_num_o(stat_frame_w)
);

assign usb_ep0_cfg_stall_ep_ack_in_w = ep0_rx_setup_w;
assign usb_ep1_cfg_stall_ep_ack_in_w = ep1_rx_setup_w;
assign usb_ep2_cfg_stall_ep_ack_in_w = ep2_rx_setup_w;
assign usb_ep3_cfg_stall_ep_ack_in_w = ep3_rx_setup_w;

//-----------------------------------------------------------------
// FIFOs
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// Endpoint 0: Host -> Device
//-----------------------------------------------------------------
usbf_fifo
#(
    .WIDTH(8),
    .DEPTH(8),
    .ADDR_W(3)
)
u_fifo_rx_ep0
(
    .clk_i(clk_i),
    .rst_i(rst_i),

    .data_i(usb_ep0_rx_data_w),
    .push_i(usb_ep0_rx_wr_w),

    .flush_i(usb_ep0_rx_ctrl_rx_flush_out_w),

    .full_o(usb_ep0_rx_full_w),
    .empty_o(),

    // Output to register block
    .data_o(usb_ep0_data_data_in_w),
    .pop_i(usb_ep0_data_rd_req_w)
);

//-----------------------------------------------------------------
// Endpoint 0: Device -> Host
//-----------------------------------------------------------------
usbf_fifo
#(
    .WIDTH(8),
    .DEPTH(8),
    .ADDR_W(3)
)
u_fifo_tx_ep0
(
    .clk_i(clk_i),
    .rst_i(rst_i),

    // Input from register block
    .data_i(usb_ep0_data_data_out_w),
    .push_i(usb_ep0_data_wr_req_w),

    .flush_i(usb_ep0_tx_ctrl_tx_flush_out_w),

    .full_o(),
    .empty_o(usb_ep0_tx_empty_w),

    .data_o(usb_ep0_tx_data_w),
    .pop_i(usb_ep0_tx_rd_w)
);

//-----------------------------------------------------------------
// Endpoint 1: Host -> Device
//-----------------------------------------------------------------
usbf_fifo
#(
    .WIDTH(8),
    .DEPTH(64),
    .ADDR_W(6)
)
u_fifo_rx_ep1
(
    .clk_i(clk_i),
    .rst_i(rst_i),

    .data_i(usb_ep1_rx_data_w),
    .push_i(usb_ep1_rx_wr_w),

    .flush_i(usb_ep1_rx_ctrl_rx_flush_out_w),

    .full_o(usb_ep1_rx_full_w),
    .empty_o(),

    // Output to register block
    .data_o(usb_ep1_data_data_in_w),
    .pop_i(usb_ep1_data_rd_req_w)
);

//-----------------------------------------------------------------
// Endpoint 1: Device -> Host
//-----------------------------------------------------------------
usbf_fifo
#(
    .WIDTH(8),
    .DEPTH(64),
    .ADDR_W(6)
)
u_fifo_tx_ep1
(
    .clk_i(clk_i),
    .rst_i(rst_i),

    // Input from register block
    .data_i(usb_ep1_data_data_out_w),
    .push_i(usb_ep1_data_wr_req_w),

    .flush_i(usb_ep1_tx_ctrl_tx_flush_out_w),

    .full_o(),
    .empty_o(usb_ep1_tx_empty_w),

    .data_o(usb_ep1_tx_data_w),
    .pop_i(usb_ep1_tx_rd_w)
);

//-----------------------------------------------------------------
// Endpoint 2: Host -> Device
//-----------------------------------------------------------------
usbf_fifo
#(
    .WIDTH(8),
    .DEPTH(64),
    .ADDR_W(6)
)
u_fifo_rx_ep2
(
    .clk_i(clk_i),
    .rst_i(rst_i),

    .data_i(usb_ep2_rx_data_w),
    .push_i(usb_ep2_rx_wr_w),

    .flush_i(usb_ep2_rx_ctrl_rx_flush_out_w),

    .full_o(usb_ep2_rx_full_w),
    .empty_o(),

    // Output to register block
    .data_o(usb_ep2_data_data_in_w),
    .pop_i(usb_ep2_data_rd_req_w)
);

//-----------------------------------------------------------------
// Endpoint 2: Device -> Host
//-----------------------------------------------------------------
usbf_fifo
#(
    .WIDTH(8),
    .DEPTH(64),
    .ADDR_W(6)
)
u_fifo_tx_ep2
(
    .clk_i(clk_i),
    .rst_i(rst_i),

    // Input from register block
    .data_i(usb_ep2_data_data_out_w),
    .push_i(usb_ep2_data_wr_req_w),

    .flush_i(usb_ep2_tx_ctrl_tx_flush_out_w),

    .full_o(),
    .empty_o(usb_ep2_tx_empty_w),

    .data_o(usb_ep2_tx_data_w),
    .pop_i(usb_ep2_tx_rd_w)
);

//-----------------------------------------------------------------
// Endpoint 3: Host -> Device
//-----------------------------------------------------------------
usbf_fifo
#(
    .WIDTH(8),
    .DEPTH(64),
    .ADDR_W(6)
)
u_fifo_rx_ep3
(
    .clk_i(clk_i),
    .rst_i(rst_i),

    .data_i(usb_ep3_rx_data_w),
    .push_i(usb_ep3_rx_wr_w),

    .flush_i(usb_ep3_rx_ctrl_rx_flush_out_w),

    .full_o(usb_ep3_rx_full_w),
    .empty_o(),

    // Output to register block
    .data_o(usb_ep3_data_data_in_w),
    .pop_i(usb_ep3_data_rd_req_w)
);

//-----------------------------------------------------------------
// Endpoint 3: Device -> Host
//-----------------------------------------------------------------
usbf_fifo
#(
    .WIDTH(8),
    .DEPTH(64),
    .ADDR_W(6)
)
u_fifo_tx_ep3
(
    .clk_i(clk_i),
    .rst_i(rst_i),

    // Input from register block
    .data_i(usb_ep3_data_data_out_w),
    .push_i(usb_ep3_data_wr_req_w),

    .flush_i(usb_ep3_tx_ctrl_tx_flush_out_w),

    .full_o(),
    .empty_o(usb_ep3_tx_empty_w),

    .data_o(usb_ep3_tx_data_w),
    .pop_i(usb_ep3_tx_rd_w)
);


//-----------------------------------------------------------------
// Endpoint 0: Control
//-----------------------------------------------------------------
usbf_sie_ep
u_ep0
(
    .clk_i(clk_i),
    .rst_i(rst_i),   

    // Rx SIE Interface
    .rx_space_o(ep0_rx_space_w),
    .rx_valid_i(ep0_rx_valid_w),
    .rx_setup_i(ep0_rx_setup_w),
    .rx_strb_i(rx_strb_w),
    .rx_data_i(rx_data_w),
    .rx_last_i(rx_last_w),
    .rx_crc_err_i(rx_crc_err_w),

    // Rx FIFO Interface
    .rx_push_o(usb_ep0_rx_wr_w),
    .rx_data_o(usb_ep0_rx_data_w),
    .rx_full_i(usb_ep0_rx_full_w),

    // Rx Register Interface
    .rx_length_o(usb_ep0_sts_rx_count_in_w),
    .rx_ready_o(usb_ep0_sts_rx_ready_in_w),
    .rx_err_o(usb_ep0_sts_rx_err_in_w),
    .rx_setup_o(usb_ep0_sts_rx_setup_in_w),
    .rx_ack_i(usb_ep0_rx_ctrl_rx_accept_out_w),

    // Tx FIFO Interface
    .tx_pop_o(usb_ep0_tx_rd_w),
    .tx_data_i(usb_ep0_tx_data_w),
    .tx_empty_i(usb_ep0_tx_empty_w),

    // Tx Register Interface
    .tx_flush_i(usb_ep0_tx_ctrl_tx_flush_out_w),
    .tx_length_i(usb_ep0_tx_ctrl_tx_len_out_w),
    .tx_start_i(usb_ep0_tx_ctrl_tx_start_out_w),
    .tx_busy_o(usb_ep0_sts_tx_busy_in_w),
    .tx_err_o(usb_ep0_sts_tx_err_in_w),

    // Tx SIE Interface
    .tx_ready_o(ep0_tx_ready_w),
    .tx_data_valid_o(ep0_tx_data_valid_w),
    .tx_data_strb_o(ep0_tx_data_strb_w),
    .tx_data_o(ep0_tx_data_w),
    .tx_data_last_o(ep0_tx_data_last_w),
    .tx_data_accept_i(ep0_tx_data_accept_w)
);
//-----------------------------------------------------------------
// Endpoint 1: Control
//-----------------------------------------------------------------
usbf_sie_ep
u_ep1
(
    .clk_i(clk_i),
    .rst_i(rst_i),   

    // Rx SIE Interface
    .rx_space_o(ep1_rx_space_w),
    .rx_valid_i(ep1_rx_valid_w),
    .rx_setup_i(ep1_rx_setup_w),
    .rx_strb_i(rx_strb_w),
    .rx_data_i(rx_data_w),
    .rx_last_i(rx_last_w),
    .rx_crc_err_i(rx_crc_err_w),

    // Rx FIFO Interface
    .rx_push_o(usb_ep1_rx_wr_w),
    .rx_data_o(usb_ep1_rx_data_w),
    .rx_full_i(usb_ep1_rx_full_w),

    // Rx Register Interface
    .rx_length_o(usb_ep1_sts_rx_count_in_w),
    .rx_ready_o(usb_ep1_sts_rx_ready_in_w),
    .rx_err_o(usb_ep1_sts_rx_err_in_w),
    .rx_setup_o(usb_ep1_sts_rx_setup_in_w),
    .rx_ack_i(usb_ep1_rx_ctrl_rx_accept_out_w),

    // Tx FIFO Interface
    .tx_pop_o(usb_ep1_tx_rd_w),
    .tx_data_i(usb_ep1_tx_data_w),
    .tx_empty_i(usb_ep1_tx_empty_w),

    // Tx Register Interface
    .tx_flush_i(usb_ep1_tx_ctrl_tx_flush_out_w),
    .tx_length_i(usb_ep1_tx_ctrl_tx_len_out_w),
    .tx_start_i(usb_ep1_tx_ctrl_tx_start_out_w),
    .tx_busy_o(usb_ep1_sts_tx_busy_in_w),
    .tx_err_o(usb_ep1_sts_tx_err_in_w),

    // Tx SIE Interface
    .tx_ready_o(ep1_tx_ready_w),
    .tx_data_valid_o(ep1_tx_data_valid_w),
    .tx_data_strb_o(ep1_tx_data_strb_w),
    .tx_data_o(ep1_tx_data_w),
    .tx_data_last_o(ep1_tx_data_last_w),
    .tx_data_accept_i(ep1_tx_data_accept_w)
);
//-----------------------------------------------------------------
// Endpoint 2: Control
//-----------------------------------------------------------------
usbf_sie_ep
u_ep2
(
    .clk_i(clk_i),
    .rst_i(rst_i),   

    // Rx SIE Interface
    .rx_space_o(ep2_rx_space_w),
    .rx_valid_i(ep2_rx_valid_w),
    .rx_setup_i(ep2_rx_setup_w),
    .rx_strb_i(rx_strb_w),
    .rx_data_i(rx_data_w),
    .rx_last_i(rx_last_w),
    .rx_crc_err_i(rx_crc_err_w),

    // Rx FIFO Interface
    .rx_push_o(usb_ep2_rx_wr_w),
    .rx_data_o(usb_ep2_rx_data_w),
    .rx_full_i(usb_ep2_rx_full_w),

    // Rx Register Interface
    .rx_length_o(usb_ep2_sts_rx_count_in_w),
    .rx_ready_o(usb_ep2_sts_rx_ready_in_w),
    .rx_err_o(usb_ep2_sts_rx_err_in_w),
    .rx_setup_o(usb_ep2_sts_rx_setup_in_w),
    .rx_ack_i(usb_ep2_rx_ctrl_rx_accept_out_w),

    // Tx FIFO Interface
    .tx_pop_o(usb_ep2_tx_rd_w),
    .tx_data_i(usb_ep2_tx_data_w),
    .tx_empty_i(usb_ep2_tx_empty_w),

    // Tx Register Interface
    .tx_flush_i(usb_ep2_tx_ctrl_tx_flush_out_w),
    .tx_length_i(usb_ep2_tx_ctrl_tx_len_out_w),
    .tx_start_i(usb_ep2_tx_ctrl_tx_start_out_w),
    .tx_busy_o(usb_ep2_sts_tx_busy_in_w),
    .tx_err_o(usb_ep2_sts_tx_err_in_w),

    // Tx SIE Interface
    .tx_ready_o(ep2_tx_ready_w),
    .tx_data_valid_o(ep2_tx_data_valid_w),
    .tx_data_strb_o(ep2_tx_data_strb_w),
    .tx_data_o(ep2_tx_data_w),
    .tx_data_last_o(ep2_tx_data_last_w),
    .tx_data_accept_i(ep2_tx_data_accept_w)
);
//-----------------------------------------------------------------
// Endpoint 3: Control
//-----------------------------------------------------------------
usbf_sie_ep
u_ep3
(
    .clk_i(clk_i),
    .rst_i(rst_i),   

    // Rx SIE Interface
    .rx_space_o(ep3_rx_space_w),
    .rx_valid_i(ep3_rx_valid_w),
    .rx_setup_i(ep3_rx_setup_w),
    .rx_strb_i(rx_strb_w),
    .rx_data_i(rx_data_w),
    .rx_last_i(rx_last_w),
    .rx_crc_err_i(rx_crc_err_w),

    // Rx FIFO Interface
    .rx_push_o(usb_ep3_rx_wr_w),
    .rx_data_o(usb_ep3_rx_data_w),
    .rx_full_i(usb_ep3_rx_full_w),

    // Rx Register Interface
    .rx_length_o(usb_ep3_sts_rx_count_in_w),
    .rx_ready_o(usb_ep3_sts_rx_ready_in_w),
    .rx_err_o(usb_ep3_sts_rx_err_in_w),
    .rx_setup_o(usb_ep3_sts_rx_setup_in_w),
    .rx_ack_i(usb_ep3_rx_ctrl_rx_accept_out_w),

    // Tx FIFO Interface
    .tx_pop_o(usb_ep3_tx_rd_w),
    .tx_data_i(usb_ep3_tx_data_w),
    .tx_empty_i(usb_ep3_tx_empty_w),

    // Tx Register Interface
    .tx_flush_i(usb_ep3_tx_ctrl_tx_flush_out_w),
    .tx_length_i(usb_ep3_tx_ctrl_tx_len_out_w),
    .tx_start_i(usb_ep3_tx_ctrl_tx_start_out_w),
    .tx_busy_o(usb_ep3_sts_tx_busy_in_w),
    .tx_err_o(usb_ep3_sts_tx_err_in_w),

    // Tx SIE Interface
    .tx_ready_o(ep3_tx_ready_w),
    .tx_data_valid_o(ep3_tx_data_valid_w),
    .tx_data_strb_o(ep3_tx_data_strb_w),
    .tx_data_o(ep3_tx_data_w),
    .tx_data_last_o(ep3_tx_data_last_w),
    .tx_data_accept_i(ep3_tx_data_accept_w)
);


endmodule



module usbf_crc16
(
    // Inputs
     input  [ 15:0]  crc_in_i
    ,input  [  7:0]  din_i

    // Outputs
    ,output [ 15:0]  crc_out_o
);



//-----------------------------------------------------------------
// Logic
//-----------------------------------------------------------------
assign crc_out_o[15] =    din_i[0] ^ din_i[1] ^ din_i[2] ^ din_i[3] ^ din_i[4] ^ din_i[5] ^ din_i[6] ^ din_i[7] ^ 
                        crc_in_i[7] ^ crc_in_i[6] ^ crc_in_i[5] ^ crc_in_i[4] ^ crc_in_i[3] ^ crc_in_i[2] ^ crc_in_i[1] ^ crc_in_i[0];
assign crc_out_o[14] =    din_i[0] ^ din_i[1] ^ din_i[2] ^ din_i[3] ^ din_i[4] ^ din_i[5] ^ din_i[6] ^
                        crc_in_i[6] ^ crc_in_i[5] ^ crc_in_i[4] ^ crc_in_i[3] ^ crc_in_i[2] ^ crc_in_i[1] ^ crc_in_i[0];
assign crc_out_o[13] =    din_i[6] ^ din_i[7] ^ 
                        crc_in_i[7] ^ crc_in_i[6];
assign crc_out_o[12] =    din_i[5] ^ din_i[6] ^ 
                        crc_in_i[6] ^ crc_in_i[5];
assign crc_out_o[11] =    din_i[4] ^ din_i[5] ^ 
                        crc_in_i[5] ^ crc_in_i[4];
assign crc_out_o[10] =    din_i[3] ^ din_i[4] ^ 
                        crc_in_i[4] ^ crc_in_i[3];
assign crc_out_o[9] =     din_i[2] ^ din_i[3] ^ 
                        crc_in_i[3] ^ crc_in_i[2];
assign crc_out_o[8] =     din_i[1] ^ din_i[2] ^ 
                        crc_in_i[2] ^ crc_in_i[1];
assign crc_out_o[7] =     din_i[0] ^ din_i[1] ^ 
                        crc_in_i[15] ^ crc_in_i[1] ^ crc_in_i[0];
assign crc_out_o[6] =     din_i[0] ^ 
                        crc_in_i[14] ^ crc_in_i[0];
assign crc_out_o[5] =     crc_in_i[13];
assign crc_out_o[4] =     crc_in_i[12];
assign crc_out_o[3] =     crc_in_i[11];
assign crc_out_o[2] =     crc_in_i[10];
assign crc_out_o[1] =     crc_in_i[9];
assign crc_out_o[0] =     din_i[0] ^ din_i[1] ^ din_i[2] ^ din_i[3] ^ din_i[4] ^ din_i[5] ^ din_i[6] ^ din_i[7] ^
                        crc_in_i[8] ^ crc_in_i[7] ^ crc_in_i[6] ^ crc_in_i[5] ^ crc_in_i[4] ^ crc_in_i[3] ^ crc_in_i[2] ^ crc_in_i[1] ^ crc_in_i[0];


endmodule


module usbf_sie_tx
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           enable_i
    ,input           chirp_i
    ,input           utmi_txready_i
    ,input           tx_valid_i
    ,input  [  7:0]  tx_pid_i
    ,input           data_valid_i
    ,input           data_strb_i
    ,input  [  7:0]  data_i
    ,input           data_last_i

    // Outputs
    ,output [  7:0]  utmi_data_o
    ,output          utmi_txvalid_o
    ,output          tx_accept_o
    ,output          data_accept_o
);



//-----------------------------------------------------------------
// Defines:
//-----------------------------------------------------------------
//-----------------------------------------------------------------
//                       USB Device Core
//                           V1.0
//                     Ultra-Embedded.com
//                     Copyright 2014-2019
//
//                 Email: admin@ultra-embedded.com
//
//                         License: GPL
// If you would like a version with a more permissive license for
// use in closed source commercial applications please contact me
// for details.
//-----------------------------------------------------------------
//
// This file is open source HDL; you can redistribute it and/or 
// modify it under the terms of the GNU General Public License as 
// published by the Free Software Foundation; either version 2 of 
// the License, or (at your option) any later version.
//
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public 
// License along with this file; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
// USA
//-----------------------------------------------------------------

//-----------------------------------------------------------------
//                          Generated File
//-----------------------------------------------------------------
//-----------------------------------------------------------------
// Definitions
//-----------------------------------------------------------------

// Tokens





// Data





// Handshake





// Special





localparam STATE_W                       = 3;
localparam STATE_TX_IDLE                 = 3'd0;
localparam STATE_TX_PID                  = 3'd1;
localparam STATE_TX_DATA                 = 3'd2;
localparam STATE_TX_CRC1                 = 3'd3;
localparam STATE_TX_CRC2                 = 3'd4;
localparam STATE_TX_DONE                 = 3'd5;
localparam STATE_TX_CHIRP                = 3'd6;

reg [STATE_W-1:0] state_q;
reg [STATE_W-1:0] next_state_r;

//-----------------------------------------------------------------
// Wire / Regs
//-----------------------------------------------------------------
reg last_q;

//-----------------------------------------------------------------
// Request Type
//-----------------------------------------------------------------
reg data_pid_q;
reg data_zlp_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
begin
    data_pid_q <= 1'b0;
    data_zlp_q <= 1'b0;
end
else if (!enable_i)
begin
    data_pid_q <= 1'b0;
    data_zlp_q <= 1'b0;
end
else if (tx_valid_i && tx_accept_o)
begin
    case (tx_pid_i)

    8'h0F, 8'h87, 8'hC3, 8'h4B:
    begin
        data_pid_q <= 1'b1;
        data_zlp_q <= data_valid_i && (data_strb_i == 1'b0) && data_last_i;
    end

    default :
    begin
        data_pid_q <= 1'b0;
        data_zlp_q <= 1'b0;
    end
    endcase
end
else if (next_state_r == STATE_TX_CRC1)
begin
    data_pid_q <= 1'b0;
    data_zlp_q <= 1'b0;
end

assign tx_accept_o = (state_q == STATE_TX_IDLE);

//-----------------------------------------------------------------
// Next state
//-----------------------------------------------------------------
always @ *
begin
    next_state_r = state_q;

    //-----------------------------------------
    // State Machine
    //-----------------------------------------
    case (state_q)

    //-----------------------------------------
    // IDLE
    //-----------------------------------------
    STATE_TX_IDLE :
    begin
        if (chirp_i)
            next_state_r  = STATE_TX_CHIRP;
        else if (tx_valid_i)
            next_state_r  = STATE_TX_PID;
    end

    //-----------------------------------------
    // TX_PID
    //-----------------------------------------
    STATE_TX_PID :
    begin
        // Data accepted
        if (utmi_txready_i)
        begin
            if (data_zlp_q)
                next_state_r = STATE_TX_CRC1;
            else if (data_pid_q)
                next_state_r = STATE_TX_DATA;
            else
                next_state_r = STATE_TX_DONE;
        end
    end

    //-----------------------------------------
    // TX_DATA
    //-----------------------------------------
    STATE_TX_DATA :
    begin
        // Data accepted
        if (utmi_txready_i)
        begin
            // Generate CRC16 at end of packet
            if (data_last_i)
                next_state_r  = STATE_TX_CRC1;
        end
    end

    //-----------------------------------------
    // TX_CRC1 (first byte)
    //-----------------------------------------
    STATE_TX_CRC1 :
    begin
        // Data sent?
        if (utmi_txready_i)
            next_state_r  = STATE_TX_CRC2;
    end

    //-----------------------------------------
    // TX_CRC (second byte)
    //-----------------------------------------
    STATE_TX_CRC2 :
    begin
        // Data sent?
        if (utmi_txready_i)
            next_state_r  = STATE_TX_DONE;
    end

    //-----------------------------------------
    // TX_DONE
    //-----------------------------------------
    STATE_TX_DONE :
    begin
        // Data sent?
        if (!utmi_txvalid_o || utmi_txready_i)
            next_state_r  = STATE_TX_IDLE;
    end

    //-----------------------------------------
    // TX_CHIRP
    //-----------------------------------------
    STATE_TX_CHIRP :
    begin
        if (!chirp_i)
            next_state_r  = STATE_TX_IDLE;
    end

    default :
       ;

    endcase

    // USB reset but not chirping...
    if (!enable_i && !chirp_i)
        next_state_r  = STATE_TX_IDLE;
end

// Update state
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    state_q   <= STATE_TX_IDLE;
else
    state_q   <= next_state_r;

//-----------------------------------------------------------------
// Data Input
//-----------------------------------------------------------------
reg       input_valid_r;
reg [7:0] input_byte_r;
reg       input_last_r;
always @ *
begin
    input_valid_r = data_strb_i & data_pid_q;
    input_byte_r  = data_i;
    input_last_r  = data_last_i;
end

reg data_accept_r;
always @ *
begin
    if (state_q == STATE_TX_DATA)
        data_accept_r = utmi_txready_i;
    else if (state_q == STATE_TX_PID && data_zlp_q)
        data_accept_r = utmi_txready_i;
    else
        data_accept_r = 1'b0;
end

assign data_accept_o = data_accept_r;

//-----------------------------------------------------------------
// CRC16: Generate CRC16 on outgoing data
//-----------------------------------------------------------------
reg [15:0]  crc_sum_q;
wire [15:0] crc_out_w;
reg         crc_err_q;

usbf_crc16
u_crc16
(
    .crc_in_i(crc_sum_q),
    .din_i(utmi_data_o),
    .crc_out_o(crc_out_w)
);

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    crc_sum_q   <= 16'hFFFF;
else if (state_q == STATE_TX_IDLE)
    crc_sum_q   <= 16'hFFFF;
else if (state_q == STATE_TX_DATA && utmi_txvalid_o && utmi_txready_i)
    crc_sum_q   <= crc_out_w;

//-----------------------------------------------------------------
// Output
//-----------------------------------------------------------------
reg       valid_q;
reg [7:0] data_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
begin
    valid_q <= 1'b0;
    data_q  <= 8'b0;
    last_q  <= 1'b0;
end
else if (!enable_i)
begin
    valid_q <= 1'b0;
    data_q  <= 8'b0;
    last_q  <= 1'b0;
end
else if (tx_valid_i && tx_accept_o)
begin
    valid_q <= 1'b1;
    data_q  <= tx_pid_i;
    last_q  <= 1'b0;
end
else if (utmi_txready_i)
begin
    valid_q <= 1'b0;
    data_q  <= 8'b0;
    last_q  <= 1'b0;
end

reg       utmi_txvalid_r;
reg [7:0] utmi_data_r;

always @ *
begin
    if (state_q == STATE_TX_CHIRP)
    begin
        utmi_txvalid_r = 1'b1;
        utmi_data_r    = 8'b0;
    end
    else if (state_q == STATE_TX_CRC1)
    begin
        utmi_txvalid_r = 1'b1;
        utmi_data_r    = crc_sum_q[7:0] ^ 8'hFF;
    end
    else if (state_q == STATE_TX_CRC2)
    begin
        utmi_txvalid_r = 1'b1;
        utmi_data_r    = crc_sum_q[15:8] ^ 8'hFF;
    end
    else if (state_q == STATE_TX_DATA)
    begin
        utmi_txvalid_r = data_valid_i;
        utmi_data_r    = data_i;
    end
    else
    begin
        utmi_txvalid_r = valid_q;
        utmi_data_r    = data_q;
    end
end

assign utmi_txvalid_o = utmi_txvalid_r;
assign utmi_data_o    = utmi_data_r;


endmodule


module usbf_sie_rx
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           enable_i
    ,input  [  7:0]  utmi_data_i
    ,input           utmi_rxvalid_i
    ,input           utmi_rxactive_i
    ,input  [  6:0]  current_addr_i

    // Outputs
    ,output [  7:0]  pid_o
    ,output          frame_valid_o
    ,output [ 10:0]  frame_number_o
    ,output          token_valid_o
    ,output [  6:0]  token_addr_o
    ,output [  3:0]  token_ep_o
    ,output          token_crc_err_o
    ,output          handshake_valid_o
    ,output          data_valid_o
    ,output          data_strb_o
    ,output [  7:0]  data_o
    ,output          data_last_o
    ,output          data_crc_err_o
    ,output          data_complete_o
);



//-----------------------------------------------------------------
// Defines:
//-----------------------------------------------------------------
//-----------------------------------------------------------------
//                       USB Device Core
//                           V1.0
//                     Ultra-Embedded.com
//                     Copyright 2014-2019
//
//                 Email: admin@ultra-embedded.com
//
//                         License: GPL
// If you would like a version with a more permissive license for
// use in closed source commercial applications please contact me
// for details.
//-----------------------------------------------------------------
//
// This file is open source HDL; you can redistribute it and/or 
// modify it under the terms of the GNU General Public License as 
// published by the Free Software Foundation; either version 2 of 
// the License, or (at your option) any later version.
//
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public 
// License along with this file; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
// USA
//-----------------------------------------------------------------

//-----------------------------------------------------------------
//                          Generated File
//-----------------------------------------------------------------
//-----------------------------------------------------------------
// Definitions
//-----------------------------------------------------------------

// Tokens





// Data





// Handshake





// Special





localparam STATE_W                       = 4;
localparam STATE_RX_IDLE                 = 4'd0;
localparam STATE_RX_TOKEN2               = 4'd1;
localparam STATE_RX_TOKEN3               = 4'd2;
localparam STATE_RX_TOKEN_COMPLETE       = 4'd3;
localparam STATE_RX_SOF2                 = 4'd4;
localparam STATE_RX_SOF3                 = 4'd5;
localparam STATE_RX_DATA                 = 4'd6;
localparam STATE_RX_DATA_COMPLETE        = 4'd7;
localparam STATE_RX_IGNORED              = 4'd8;
reg [STATE_W-1:0] state_q;

//-----------------------------------------------------------------
// Wire / Regs
//-----------------------------------------------------------------

reg [11-1:0]      frame_num_q;


reg [7-1:0]        token_dev_q;


reg [4-1:0]         token_ep_q;


reg [8-1:0]        token_pid_q;

//-----------------------------------------------------------------
// Data delay (to strip the CRC16 trailing bytes)
//-----------------------------------------------------------------
reg [31:0] data_buffer_q;
reg [3:0]  data_valid_q;
reg [3:0]  rx_active_q;

wire shift_en_w = (utmi_rxvalid_i & utmi_rxactive_i) || !utmi_rxactive_i;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    data_buffer_q <= 32'b0;
else if (shift_en_w)
    data_buffer_q <= {utmi_data_i, data_buffer_q[31:8]};

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    data_valid_q <= 4'b0;
else if (shift_en_w)
    data_valid_q <= {(utmi_rxvalid_i & utmi_rxactive_i), data_valid_q[3:1]};
else
    data_valid_q <= {data_valid_q[3:1], 1'b0};

reg [1:0] data_crc_q;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    data_crc_q <= 2'b0;
else if (shift_en_w)
    data_crc_q <= {!utmi_rxactive_i, data_crc_q[1]};

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rx_active_q <= 4'b0;
else
    rx_active_q <= {utmi_rxactive_i, rx_active_q[3:1]};

wire [7:0] data_w       = data_buffer_q[7:0];
wire       data_ready_w = data_valid_q[0];
wire       crc_byte_w   = data_crc_q[0];
wire       rx_active_w  = rx_active_q[0];

wire       address_match_w = (token_dev_q == current_addr_i);

//-----------------------------------------------------------------
// Next state
//-----------------------------------------------------------------
reg [STATE_W-1:0] next_state_r;

always @ *
begin
    next_state_r = state_q;

    case (state_q)

    //-----------------------------------------
    // IDLE
    //-----------------------------------------
    STATE_RX_IDLE :
    begin
       if (data_ready_w)
       begin
           // Decode PID
           case (data_w)

              8'hE1, 8'h69, 8'h2D, 8'hB4:
                    next_state_r  = STATE_RX_TOKEN2;

              8'hA5:
                    next_state_r  = STATE_RX_SOF2;

              8'hC3, 8'h4B, 8'h87, 8'h0F:
              begin
                    next_state_r  = STATE_RX_DATA;
              end

              8'hD2, 8'h5A, 8'h1E, 8'h96:
                    next_state_r  = STATE_RX_IDLE;

              default : // SPLIT / ERR
                    next_state_r  = STATE_RX_IGNORED;
           endcase
       end
    end

    //-----------------------------------------
    // RX_IGNORED: Unknown / unsupported
    //-----------------------------------------
    STATE_RX_IGNORED :
    begin
        // Wait until the end of the packet
        if (!rx_active_w)
           next_state_r = STATE_RX_IDLE;
    end

    //-----------------------------------------
    // SOF (BYTE 2)
    //-----------------------------------------
    STATE_RX_SOF2 :
    begin
       if (data_ready_w)
           next_state_r = STATE_RX_SOF3;
       else if (!rx_active_w)
           next_state_r = STATE_RX_IDLE;
    end

    //-----------------------------------------
    // SOF (BYTE 3)
    //-----------------------------------------
    STATE_RX_SOF3 :
    begin
       if (data_ready_w || !rx_active_w)
           next_state_r = STATE_RX_IDLE;
    end

    //-----------------------------------------
    // TOKEN (IN/OUT/SETUP) (Address/Endpoint)
    //-----------------------------------------
    STATE_RX_TOKEN2 :
    begin
       if (data_ready_w)
           next_state_r = STATE_RX_TOKEN3;
       else if (!rx_active_w)
           next_state_r = STATE_RX_IDLE;
    end

    //-----------------------------------------
    // TOKEN (IN/OUT/SETUP) (Endpoint/CRC)
    //-----------------------------------------
    STATE_RX_TOKEN3 :
    begin
       if (data_ready_w)
           next_state_r = STATE_RX_TOKEN_COMPLETE;
       else if (!rx_active_w)
           next_state_r = STATE_RX_IDLE;
    end

    //-----------------------------------------
    // RX_TOKEN_COMPLETE
    //-----------------------------------------
    STATE_RX_TOKEN_COMPLETE :
    begin
        next_state_r  = STATE_RX_IDLE;
    end

    //-----------------------------------------
    // RX_DATA
    //-----------------------------------------
    STATE_RX_DATA :
    begin
       // Receive complete
       if (crc_byte_w)
            next_state_r = STATE_RX_DATA_COMPLETE;
    end

    //-----------------------------------------
    // RX_DATA_COMPLETE
    //-----------------------------------------
    STATE_RX_DATA_COMPLETE :
    begin
        if (!rx_active_w)
            next_state_r = STATE_RX_IDLE;
    end

    default :
       ;

    endcase
end

// Update state
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    state_q   <= STATE_RX_IDLE;
else if (!enable_i)
    state_q   <= STATE_RX_IDLE;
else
    state_q   <= next_state_r;

//-----------------------------------------------------------------
// Handshake:
//-----------------------------------------------------------------
reg handshake_valid_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    handshake_valid_q <= 1'b0;
else if (state_q == STATE_RX_IDLE && data_ready_w)
begin
    case (data_w)
    8'hD2, 8'h5A, 8'h1E, 8'h96:
        handshake_valid_q <= address_match_w;
    default :
        handshake_valid_q <= 1'b0;
    endcase
end
else
    handshake_valid_q <= 1'b0;

assign handshake_valid_o = handshake_valid_q;

//-----------------------------------------------------------------
// SOF: Frame number
//-----------------------------------------------------------------
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    frame_num_q         <= 11'b0;
else if (state_q == STATE_RX_SOF2 && data_ready_w)
    frame_num_q         <= {3'b0, data_w};
else if (state_q == STATE_RX_SOF3 && data_ready_w)
    frame_num_q         <= {data_w[2:0], frame_num_q[7:0]};
else if (!enable_i)
    frame_num_q         <= 11'b0;

assign frame_number_o = frame_num_q;

reg frame_valid_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    frame_valid_q <= 1'b0;
else
    frame_valid_q <= (state_q == STATE_RX_SOF3 && data_ready_w);

assign frame_valid_o = frame_valid_q;

//-----------------------------------------------------------------
// Token: PID
//-----------------------------------------------------------------
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    token_pid_q <= 8'b0;
else if (state_q == STATE_RX_IDLE && data_ready_w)
    token_pid_q <= data_w;
else if (!enable_i)
    token_pid_q <= 8'b0;

assign pid_o = token_pid_q;

reg token_valid_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    token_valid_q <= 1'b0;
else
    token_valid_q <= (state_q == STATE_RX_TOKEN_COMPLETE) && address_match_w;

assign token_valid_o = token_valid_q;

//-----------------------------------------------------------------
// Token: Device Address
//-----------------------------------------------------------------
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    token_dev_q <= 7'b0;
else if (state_q == STATE_RX_TOKEN2 && data_ready_w)
    token_dev_q <= data_w[6:0];
else if (!enable_i)
    token_dev_q <= 7'b0;

assign token_addr_o = token_dev_q;

//-----------------------------------------------------------------
// Token: Endpoint
//-----------------------------------------------------------------
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    token_ep_q      <= 4'b0;
else if (state_q == STATE_RX_TOKEN2 && data_ready_w)
    token_ep_q[0]   <= data_w[7];
else if (state_q == STATE_RX_TOKEN3 && data_ready_w)
    token_ep_q[3:1] <= data_w[2:0];
else if (!enable_i)
    token_ep_q      <= 4'b0;

assign token_ep_o = token_ep_q;
assign token_crc_err_o = 1'b0;

wire [7:0] input_data_w  = data_w;
wire       input_ready_w = state_q == STATE_RX_DATA && data_ready_w && !crc_byte_w;

//-----------------------------------------------------------------
// CRC16: Generate CRC16 on incoming data bytes
//-----------------------------------------------------------------
reg [15:0]  crc_sum_q;
wire [15:0] crc_out_w;
reg         crc_err_q;

usbf_crc16
u_crc16
(
    .crc_in_i(crc_sum_q),
    .din_i(data_w),
    .crc_out_o(crc_out_w)
);

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    crc_sum_q   <= 16'hFFFF;
else if (state_q == STATE_RX_IDLE)
    crc_sum_q   <= 16'hFFFF;
else if (data_ready_w)
    crc_sum_q   <= crc_out_w;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    crc_err_q   <= 1'b0;
else if (state_q == STATE_RX_IDLE)
    crc_err_q   <= 1'b0;
else if (state_q == STATE_RX_DATA_COMPLETE && next_state_r == STATE_RX_IDLE)
    crc_err_q   <= (crc_sum_q != 16'hB001);

assign data_crc_err_o = crc_err_q;

reg data_complete_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    data_complete_q   <= 1'b0;
else if (state_q == STATE_RX_DATA_COMPLETE && next_state_r == STATE_RX_IDLE)
    data_complete_q   <= 1'b1;
else
    data_complete_q   <= 1'b0;

assign data_complete_o = data_complete_q;

reg data_zlp_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    data_zlp_q   <= 1'b0;
else if (state_q == STATE_RX_IDLE && next_state_r == STATE_RX_DATA)
    data_zlp_q   <= 1'b1;
else if (input_ready_w)
    data_zlp_q   <= 1'b0;

//-----------------------------------------------------------------
// Data Output
//-----------------------------------------------------------------
reg        valid_q;
reg        last_q;
reg [7:0]  data_q;
reg        mask_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
begin
    valid_q  <= 1'b0;
    data_q   <= 8'b0;
    mask_q   <= 1'b0;
    last_q   <= 1'b0;
end
else
begin
    valid_q  <= input_ready_w || ((state_q == STATE_RX_DATA) && crc_byte_w && data_zlp_q);
    data_q   <= input_data_w;
    mask_q   <= input_ready_w;
    last_q   <= (state_q == STATE_RX_DATA) && crc_byte_w;
end

// Data
assign data_valid_o = valid_q;
assign data_strb_o  = mask_q;
assign data_o       = data_q;
assign data_last_o  = last_q | crc_byte_w;


endmodule


module usbf_sie_ep
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           rx_setup_i
    ,input           rx_valid_i
    ,input           rx_strb_i
    ,input  [  7:0]  rx_data_i
    ,input           rx_last_i
    ,input           rx_crc_err_i
    ,input           rx_full_i
    ,input           rx_ack_i
    ,input  [  7:0]  tx_data_i
    ,input           tx_empty_i
    ,input           tx_flush_i
    ,input  [ 10:0]  tx_length_i
    ,input           tx_start_i
    ,input           tx_data_accept_i

    // Outputs
    ,output          rx_space_o
    ,output          rx_push_o
    ,output [  7:0]  rx_data_o
    ,output [ 10:0]  rx_length_o
    ,output          rx_ready_o
    ,output          rx_err_o
    ,output          rx_setup_o
    ,output          tx_pop_o
    ,output          tx_busy_o
    ,output          tx_err_o
    ,output          tx_ready_o
    ,output          tx_data_valid_o
    ,output          tx_data_strb_o
    ,output [  7:0]  tx_data_o
    ,output          tx_data_last_o
);



//-----------------------------------------------------------------
// Rx
//-----------------------------------------------------------------
reg        rx_ready_q;
reg        rx_err_q;
reg [10:0] rx_len_q;
reg        rx_setup_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rx_ready_q <= 1'b0;
else if (rx_ack_i)
    rx_ready_q <= 1'b0;
else if (rx_valid_i && rx_last_i)
    rx_ready_q <= 1'b1;

assign rx_space_o = !rx_ready_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rx_len_q <= 11'b0;
else if (rx_ack_i)
    rx_len_q <= 11'b0;
else if (rx_valid_i && rx_strb_i)
    rx_len_q <= rx_len_q + 11'd1;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rx_err_q <= 1'b0;
else if (rx_ack_i)
    rx_err_q <= 1'b0;
else if (rx_valid_i && rx_last_i && rx_crc_err_i)
    rx_err_q <= 1'b1;
else if (rx_full_i && rx_push_o)
    rx_err_q <= 1'b1;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rx_setup_q <= 1'b0;
else if (rx_ack_i)
    rx_setup_q <= 1'b0;
else if (rx_setup_i)
    rx_setup_q <= 1'b1;

assign rx_length_o = rx_len_q;
assign rx_ready_o  = rx_ready_q;
assign rx_err_o    = rx_err_q;
assign rx_setup_o  = rx_setup_q;

assign rx_push_o   = rx_valid_i & rx_strb_i;
assign rx_data_o   = rx_data_i;

//-----------------------------------------------------------------
// Tx
//-----------------------------------------------------------------
reg        tx_active_q;
reg        tx_err_q;
reg        tx_zlp_q;
reg [10:0] tx_len_q;

// Tx active
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    tx_active_q <= 1'b0;
else if (tx_flush_i)
    tx_active_q <= 1'b0;
else if (tx_start_i)
    tx_active_q <= 1'b1;
else if (tx_data_valid_o && tx_data_last_o && tx_data_accept_i)
    tx_active_q <= 1'b0;

assign tx_ready_o = tx_active_q;

// Tx zero length packet
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    tx_zlp_q <= 1'b0;
else if (tx_flush_i)
    tx_zlp_q <= 1'b0;
else if (tx_start_i)
    tx_zlp_q <= (tx_length_i == 11'b0);

// Tx length
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    tx_len_q <= 11'b0;
else if (tx_flush_i)
    tx_len_q <= 11'b0;
else if (tx_start_i)
    tx_len_q <= tx_length_i;
else if (tx_data_valid_o && tx_data_accept_i && !tx_zlp_q)
    tx_len_q <= tx_len_q - 11'd1;

// Tx SIE Interface
assign tx_data_valid_o = tx_active_q;
assign tx_data_strb_o  = !tx_zlp_q;
assign tx_data_last_o  = tx_zlp_q || (tx_len_q == 11'd1);
assign tx_data_o       = tx_data_i;

// Error: Buffer underrun
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    tx_err_q <= 1'b0;
else if (tx_flush_i)
    tx_err_q <= 1'b0;
else if (tx_start_i)
    tx_err_q <= 1'b0;
else if (!tx_zlp_q && tx_empty_i && tx_data_valid_o)
    tx_err_q <= 1'b1;

// Tx Register Interface
assign tx_err_o      = tx_err_q;
assign tx_busy_o     = tx_active_q;

// Tx FIFO Interface
assign tx_pop_o      = tx_data_accept_i & tx_active_q;


endmodule


module usbf_fifo
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input  [  7:0]  data_i
    ,input           push_i
    ,input           pop_i
    ,input           flush_i

    // Outputs
    ,output          full_o
    ,output          empty_o
    ,output [  7:0]  data_o
);



parameter WIDTH   = 8;
parameter DEPTH   = 4;
parameter ADDR_W  = 2;

//-----------------------------------------------------------------
// Local Params
//-----------------------------------------------------------------
localparam COUNT_W = ADDR_W + 1;

//-----------------------------------------------------------------
// Registers
//-----------------------------------------------------------------
reg [WIDTH-1:0]         ram [DEPTH-1:0];
reg [ADDR_W-1:0]        rd_ptr;
reg [ADDR_W-1:0]        wr_ptr;
reg [COUNT_W-1:0]       count;

//-----------------------------------------------------------------
// Sequential
//-----------------------------------------------------------------
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
begin
    count   <= {(COUNT_W) {1'b0}};
    rd_ptr  <= {(ADDR_W) {1'b0}};
    wr_ptr  <= {(ADDR_W) {1'b0}};
end
else
begin

    if (flush_i)
    begin
        count   <= {(COUNT_W) {1'b0}};
        rd_ptr  <= {(ADDR_W) {1'b0}};
        wr_ptr  <= {(ADDR_W) {1'b0}};
    end

    // Push
    if (push_i & ~full_o)
    begin
        ram[wr_ptr] <= data_i;
        wr_ptr      <= wr_ptr + 1;
    end

    // Pop
    if (pop_i & ~empty_o)
    begin
        rd_ptr      <= rd_ptr + 1;
    end

    // Count up
    if ((push_i & ~full_o) & ~(pop_i & ~empty_o))
    begin
        count <= count + 1;
    end
    // Count down
    else if (~(push_i & ~full_o) & (pop_i & ~empty_o))
    begin
        count <= count - 1;
    end
end

//-------------------------------------------------------------------
// Combinatorial
//-------------------------------------------------------------------
/* verilator lint_off WIDTH */
assign full_o    = (count == DEPTH);
assign empty_o   = (count == 0);
/* verilator lint_on WIDTH */

assign data_o    = ram[rd_ptr];


endmodule



module usbf_device_core
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input  [  7:0]  utmi_data_i
    ,input           utmi_txready_i
    ,input           utmi_rxvalid_i
    ,input           utmi_rxactive_i
    ,input           utmi_rxerror_i
    ,input  [  1:0]  utmi_linestate_i
    ,input           ep0_stall_i
    ,input           ep0_iso_i
    ,input           ep0_cfg_int_rx_i
    ,input           ep0_cfg_int_tx_i
    ,input           ep0_rx_space_i
    ,input           ep0_tx_ready_i
    ,input           ep0_tx_data_valid_i
    ,input           ep0_tx_data_strb_i
    ,input  [  7:0]  ep0_tx_data_i
    ,input           ep0_tx_data_last_i
    ,input           ep1_stall_i
    ,input           ep1_iso_i
    ,input           ep1_cfg_int_rx_i
    ,input           ep1_cfg_int_tx_i
    ,input           ep1_rx_space_i
    ,input           ep1_tx_ready_i
    ,input           ep1_tx_data_valid_i
    ,input           ep1_tx_data_strb_i
    ,input  [  7:0]  ep1_tx_data_i
    ,input           ep1_tx_data_last_i
    ,input           ep2_stall_i
    ,input           ep2_iso_i
    ,input           ep2_cfg_int_rx_i
    ,input           ep2_cfg_int_tx_i
    ,input           ep2_rx_space_i
    ,input           ep2_tx_ready_i
    ,input           ep2_tx_data_valid_i
    ,input           ep2_tx_data_strb_i
    ,input  [  7:0]  ep2_tx_data_i
    ,input           ep2_tx_data_last_i
    ,input           ep3_stall_i
    ,input           ep3_iso_i
    ,input           ep3_cfg_int_rx_i
    ,input           ep3_cfg_int_tx_i
    ,input           ep3_rx_space_i
    ,input           ep3_tx_ready_i
    ,input           ep3_tx_data_valid_i
    ,input           ep3_tx_data_strb_i
    ,input  [  7:0]  ep3_tx_data_i
    ,input           ep3_tx_data_last_i
    ,input           reg_chirp_en_i
    ,input           reg_int_en_sof_i
    ,input           reg_sts_rst_clr_i
    ,input  [  6:0]  reg_dev_addr_i

    // Outputs
    ,output          intr_o
    ,output [  7:0]  utmi_data_o
    ,output          utmi_txvalid_o
    ,output          rx_strb_o
    ,output [  7:0]  rx_data_o
    ,output          rx_last_o
    ,output          rx_crc_err_o
    ,output          ep0_rx_setup_o
    ,output          ep0_rx_valid_o
    ,output          ep0_tx_data_accept_o
    ,output          ep1_rx_setup_o
    ,output          ep1_rx_valid_o
    ,output          ep1_tx_data_accept_o
    ,output          ep2_rx_setup_o
    ,output          ep2_rx_valid_o
    ,output          ep2_tx_data_accept_o
    ,output          ep3_rx_setup_o
    ,output          ep3_rx_valid_o
    ,output          ep3_tx_data_accept_o
    ,output          reg_sts_rst_o
    ,output [ 10:0]  reg_sts_frame_num_o
);



//-----------------------------------------------------------------
// Defines:
//-----------------------------------------------------------------
//-----------------------------------------------------------------
//                       USB Device Core
//                           V1.0
//                     Ultra-Embedded.com
//                     Copyright 2014-2019
//
//                 Email: admin@ultra-embedded.com
//
//                         License: GPL
// If you would like a version with a more permissive license for
// use in closed source commercial applications please contact me
// for details.
//-----------------------------------------------------------------
//
// This file is open source HDL; you can redistribute it and/or 
// modify it under the terms of the GNU General Public License as 
// published by the Free Software Foundation; either version 2 of 
// the License, or (at your option) any later version.
//
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public 
// License along with this file; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
// USA
//-----------------------------------------------------------------

//-----------------------------------------------------------------
//                          Generated File
//-----------------------------------------------------------------
//-----------------------------------------------------------------
// Definitions
//-----------------------------------------------------------------

// Tokens





// Data





// Handshake





// Special







localparam STATE_W                       = 3;
localparam STATE_RX_IDLE                 = 3'd0;
localparam STATE_RX_DATA                 = 3'd1;
localparam STATE_RX_DATA_READY           = 3'd2;
localparam STATE_RX_DATA_IGNORE          = 3'd3;
localparam STATE_TX_DATA                 = 3'd4;
localparam STATE_TX_DATA_COMPLETE        = 3'd5;
localparam STATE_TX_HANDSHAKE            = 3'd6;
localparam STATE_TX_CHIRP                = 3'd7;
reg [STATE_W-1:0] state_q;

//-----------------------------------------------------------------
// Reset detection
//-----------------------------------------------------------------
reg [15-1:0] se0_cnt_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    se0_cnt_q <= 15'b0;
else if (utmi_linestate_i == 2'b0)
begin
    if (!se0_cnt_q[15-1])
        se0_cnt_q <= se0_cnt_q + 15'd1;
end    
else
    se0_cnt_q <= 15'b0;

wire usb_rst_w = se0_cnt_q[15-1];

//-----------------------------------------------------------------
// Wire / Regs
//-----------------------------------------------------------------

wire [11-1:0] frame_num_w;

wire                    frame_valid_w;


wire [7-1:0]   token_dev_w;


wire [4-1:0]    token_ep_w;


wire [8-1:0]   token_pid_w;

wire                    token_valid_w;

wire                    rx_data_valid_w;
wire                    rx_data_complete_w;

wire                    rx_handshake_w;

reg                     tx_data_valid_r;
reg                     tx_data_strb_r;
reg  [7:0]              tx_data_r;
reg                     tx_data_last_r;
wire                    tx_data_accept_w;

reg                     tx_valid_q;
reg [7:0]               tx_pid_q;
wire                    tx_accept_w;

reg                     rx_space_q;
reg                     rx_space_r;
reg                     tx_ready_r;
reg                     ep_data_bit_r;

reg                     ep_stall_r;
reg                     ep_iso_r;

reg                     rx_enable_q;
reg                     rx_setup_q;

reg                     ep0_data_bit_q;
reg                     ep1_data_bit_q;
reg                     ep2_data_bit_q;
reg                     ep3_data_bit_q;

wire                    status_stage_w;

reg [7-1:0]    current_addr_q;

//-----------------------------------------------------------------
// SIE - TX
//-----------------------------------------------------------------
usbf_sie_tx
u_sie_tx
(
    .clk_i(clk_i),
    .rst_i(rst_i),
    
    .enable_i(~usb_rst_w),
    .chirp_i(reg_chirp_en_i),

    // UTMI Interface
    .utmi_data_o(utmi_data_o),
    .utmi_txvalid_o(utmi_txvalid_o),
    .utmi_txready_i(utmi_txready_i),

    // Request
    .tx_valid_i(tx_valid_q),
    .tx_pid_i(tx_pid_q),
    .tx_accept_o(tx_accept_w),

    // Data
    .data_valid_i(tx_data_valid_r),
    .data_strb_i(tx_data_strb_r),
    .data_i(tx_data_r),
    .data_last_i(tx_data_last_r),
    .data_accept_o(tx_data_accept_w)
);

always @ *
begin
    tx_data_valid_r = 1'b0;
    tx_data_strb_r  = 1'b0;
    tx_data_r       = 8'b0;
    tx_data_last_r  = 1'b0;

    case (token_ep_w)
    4'd0:
    begin
        tx_data_valid_r = ep0_tx_data_valid_i;
        tx_data_strb_r  = ep0_tx_data_strb_i;
        tx_data_r       = ep0_tx_data_i;
        tx_data_last_r  = ep0_tx_data_last_i;
    end
    4'd1:
    begin
        tx_data_valid_r = ep1_tx_data_valid_i;
        tx_data_strb_r  = ep1_tx_data_strb_i;
        tx_data_r       = ep1_tx_data_i;
        tx_data_last_r  = ep1_tx_data_last_i;
    end
    4'd2:
    begin
        tx_data_valid_r = ep2_tx_data_valid_i;
        tx_data_strb_r  = ep2_tx_data_strb_i;
        tx_data_r       = ep2_tx_data_i;
        tx_data_last_r  = ep2_tx_data_last_i;
    end
    4'd3:
    begin
        tx_data_valid_r = ep3_tx_data_valid_i;
        tx_data_strb_r  = ep3_tx_data_strb_i;
        tx_data_r       = ep3_tx_data_i;
        tx_data_last_r  = ep3_tx_data_last_i;
    end
    default:
        ;
    endcase    
end

assign ep0_tx_data_accept_o = tx_data_accept_w & (token_ep_w == 4'd0);
assign ep1_tx_data_accept_o = tx_data_accept_w & (token_ep_w == 4'd1);
assign ep2_tx_data_accept_o = tx_data_accept_w & (token_ep_w == 4'd2);
assign ep3_tx_data_accept_o = tx_data_accept_w & (token_ep_w == 4'd3);

always @ *
begin
    rx_space_r    = 1'b0;
    tx_ready_r    = 1'b0;
    ep_data_bit_r = 1'b0;

    ep_stall_r = 1'b0;
    ep_iso_r   = 1'b0;

    case (token_ep_w)
    4'd0:
    begin
        rx_space_r    = ep0_rx_space_i;
        tx_ready_r    = ep0_tx_ready_i;
        ep_data_bit_r = ep0_data_bit_q | status_stage_w;
        ep_stall_r    = ep0_stall_i;
        ep_iso_r      = ep0_iso_i;
    end
    4'd1:
    begin
        rx_space_r    = ep1_rx_space_i;
        tx_ready_r    = ep1_tx_ready_i;
        ep_data_bit_r = ep1_data_bit_q | status_stage_w;
        ep_stall_r    = ep1_stall_i;
        ep_iso_r      = ep1_iso_i;
    end
    4'd2:
    begin
        rx_space_r    = ep2_rx_space_i;
        tx_ready_r    = ep2_tx_ready_i;
        ep_data_bit_r = ep2_data_bit_q | status_stage_w;
        ep_stall_r    = ep2_stall_i;
        ep_iso_r      = ep2_iso_i;
    end
    4'd3:
    begin
        rx_space_r    = ep3_rx_space_i;
        tx_ready_r    = ep3_tx_ready_i;
        ep_data_bit_r = ep3_data_bit_q | status_stage_w;
        ep_stall_r    = ep3_stall_i;
        ep_iso_r      = ep3_iso_i;
    end
    default:
        ;
    endcase
end

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rx_space_q <= 1'b0;
else if (state_q == STATE_RX_IDLE)
    rx_space_q <= rx_space_r;

//-----------------------------------------------------------------
// SIE - RX
//-----------------------------------------------------------------
usbf_sie_rx
u_sie_rx
(
    .clk_i(clk_i),
    .rst_i(rst_i),
    
    .enable_i(~usb_rst_w && ~reg_chirp_en_i),

    // UTMI Interface
    .utmi_data_i(utmi_data_i),
    .utmi_rxvalid_i(utmi_rxvalid_i),
    .utmi_rxactive_i(utmi_rxactive_i),

    .current_addr_i(current_addr_q),

    .pid_o(token_pid_w),

    .frame_valid_o(frame_valid_w),
    .frame_number_o(reg_sts_frame_num_o),

    .token_valid_o(token_valid_w),
    .token_addr_o(token_dev_w),
    .token_ep_o(token_ep_w),
    .token_crc_err_o(),

    .handshake_valid_o(rx_handshake_w),

    .data_valid_o(rx_data_valid_w),
    .data_strb_o(rx_strb_o),
    .data_o(rx_data_o),
    .data_last_o(rx_last_o),

    .data_complete_o(rx_data_complete_w),
    .data_crc_err_o(rx_crc_err_o)
);

assign ep0_rx_valid_o = rx_enable_q & rx_data_valid_w & (token_ep_w == 4'd0);
assign ep0_rx_setup_o = rx_setup_q & (token_ep_w == 4'd0);
assign ep1_rx_valid_o = rx_enable_q & rx_data_valid_w & (token_ep_w == 4'd1);
assign ep1_rx_setup_o = rx_setup_q & (token_ep_w == 4'd0);
assign ep2_rx_valid_o = rx_enable_q & rx_data_valid_w & (token_ep_w == 4'd2);
assign ep2_rx_setup_o = rx_setup_q & (token_ep_w == 4'd0);
assign ep3_rx_valid_o = rx_enable_q & rx_data_valid_w & (token_ep_w == 4'd3);
assign ep3_rx_setup_o = rx_setup_q & (token_ep_w == 4'd0);

//-----------------------------------------------------------------
// Next state
//-----------------------------------------------------------------
reg [STATE_W-1:0] next_state_r;

always @ *
begin
    next_state_r = state_q;

    //-----------------------------------------
    // State Machine
    //-----------------------------------------
    case (state_q)

    //-----------------------------------------
    // IDLE
    //-----------------------------------------
    STATE_RX_IDLE :
    begin
        // Token received (OUT, IN, SETUP, PING)
        if (token_valid_w)
        begin
            //-------------------------------
            // IN transfer (device -> host)
            //-------------------------------
            if (token_pid_w == 8'h69)
            begin
                // Stalled endpoint?
                if (ep_stall_r)
                    next_state_r  = STATE_TX_HANDSHAKE;
                // Some data to TX?
                else if (tx_ready_r)
                    next_state_r  = STATE_TX_DATA;
                // No data to TX
                else
                    next_state_r  = STATE_TX_HANDSHAKE;
            end
            //-------------------------------
            // PING transfer (device -> host)
            //-------------------------------
            else if (token_pid_w == 8'hB4)
            begin
                next_state_r  = STATE_TX_HANDSHAKE;
            end
            //-------------------------------
            // OUT transfer (host -> device)
            //-------------------------------
            else if (token_pid_w == 8'hE1)
            begin
                // Stalled endpoint?
                if (ep_stall_r)
                    next_state_r  = STATE_RX_DATA_IGNORE;
                // Some space to rx
                else if (rx_space_r)
                    next_state_r  = STATE_RX_DATA;
                // No rx space, ignore receive
                else
                    next_state_r  = STATE_RX_DATA_IGNORE;
            end
            //-------------------------------
            // SETUP transfer (host -> device)
            //-------------------------------
            else if (token_pid_w == 8'h2D)
            begin
                // Some space to rx
                if (rx_space_r)
                    next_state_r  = STATE_RX_DATA;
                // No rx space, ignore receive
                else
                    next_state_r  = STATE_RX_DATA_IGNORE;
            end
        end
        else if (reg_chirp_en_i)
            next_state_r  = STATE_TX_CHIRP;
    end

    //-----------------------------------------
    // RX_DATA
    //-----------------------------------------
    STATE_RX_DATA :
    begin
        // TODO: Exit data state handling?

        // TODO: Sort out ISO data bit handling
        // Check for expected DATAx PID
        if ((token_pid_w == 8'hC3 &&  ep_data_bit_r && !ep_iso_r) ||
            (token_pid_w == 8'h4B && !ep_data_bit_r && !ep_iso_r))
            next_state_r  = STATE_RX_DATA_IGNORE;
        // Receive complete
        else if (rx_data_valid_w && rx_last_o)
            next_state_r  = STATE_RX_DATA_READY;
    end
    //-----------------------------------------
    // RX_DATA_IGNORE
    //-----------------------------------------
    STATE_RX_DATA_IGNORE :
    begin
        // Receive complete
        if (rx_data_valid_w && rx_last_o)
            next_state_r  = STATE_RX_DATA_READY;
    end
    //-----------------------------------------
    // RX_DATA_READY
    //-----------------------------------------
    STATE_RX_DATA_READY :
    begin
        if (rx_data_complete_w)
        begin
            // No response on CRC16 error
            if (rx_crc_err_o)
                next_state_r  = STATE_RX_IDLE;
            // ISO endpoint, no response?
            else if (ep_iso_r)
                next_state_r  = STATE_RX_IDLE;
            else
                next_state_r  = STATE_TX_HANDSHAKE;
        end
    end
    //-----------------------------------------
    // TX_DATA
    //-----------------------------------------
    STATE_TX_DATA :
    begin
        if (!tx_valid_q || tx_accept_w)
            if (tx_data_valid_r && tx_data_last_r && tx_data_accept_w)
                next_state_r  = STATE_TX_DATA_COMPLETE;
    end
    //-----------------------------------------
    // TX_HANDSHAKE
    //-----------------------------------------
    STATE_TX_DATA_COMPLETE :
    begin
        next_state_r  = STATE_RX_IDLE;
    end
    //-----------------------------------------
    // TX_HANDSHAKE
    //-----------------------------------------
    STATE_TX_HANDSHAKE :
    begin
        if (tx_accept_w)
            next_state_r  = STATE_RX_IDLE;
    end
    //-----------------------------------------
    // TX_CHIRP
    //-----------------------------------------
    STATE_TX_CHIRP :
    begin
        if (!reg_chirp_en_i)
            next_state_r  = STATE_RX_IDLE;
    end

    default :
       ;

    endcase

    //-----------------------------------------
    // USB Bus Reset (HOST->DEVICE)
    //----------------------------------------- 
    if (usb_rst_w && !reg_chirp_en_i)
        next_state_r  = STATE_RX_IDLE;
end

// Update state
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    state_q   <= STATE_RX_IDLE;
else
    state_q   <= next_state_r;

//-----------------------------------------------------------------
// Response
//-----------------------------------------------------------------
reg         tx_valid_r;
reg [7:0]   tx_pid_r;

always @ *
begin
    tx_valid_r = 1'b0;
    tx_pid_r   = 8'b0;

    case (state_q)
    //-----------------------------------------
    // IDLE
    //-----------------------------------------
    STATE_RX_IDLE :
    begin
        // Token received (OUT, IN, SETUP, PING)
        if (token_valid_w)
        begin
            //-------------------------------
            // IN transfer (device -> host)
            //-------------------------------
            if (token_pid_w == 8'h69)
            begin
                // Stalled endpoint?
                if (ep_stall_r)
                begin
                    tx_valid_r = 1'b1;
                    tx_pid_r   = 8'h1E;
                end
                // Some data to TX?
                else if (tx_ready_r)
                begin
                    tx_valid_r = 1'b1;
                    // TODO: Handle MDATA for ISOs
                    tx_pid_r   = ep_data_bit_r ? 8'h4B : 8'hC3;
                end
                // No data to TX
                else
                begin
                    tx_valid_r = 1'b1;
                    tx_pid_r   = 8'h5A;
                end
            end
            //-------------------------------
            // PING transfer (device -> host)
            //-------------------------------
            else if (token_pid_w == 8'hB4)
            begin
                // Stalled endpoint?
                if (ep_stall_r)
                begin
                    tx_valid_r = 1'b1;
                    tx_pid_r   = 8'h1E;
                end
                // Data ready to RX
                else if (rx_space_r)
                begin
                    tx_valid_r = 1'b1;
                    tx_pid_r   = 8'hD2;
                end
                // No data to TX
                else
                begin
                    tx_valid_r = 1'b1;
                    tx_pid_r   = 8'h5A;
                end
            end
        end
    end

    //-----------------------------------------
    // RX_DATA_READY
    //-----------------------------------------
    STATE_RX_DATA_READY :
    begin
       // Receive complete
       if (rx_data_complete_w)
       begin
            // No response on CRC16 error
            if (rx_crc_err_o)
                ;
            // ISO endpoint, no response?
            else if (ep_iso_r)
                ;
            // Send STALL?
            else if (ep_stall_r)
            begin
                tx_valid_r = 1'b1;
                tx_pid_r   = 8'h1E;
            end
            // DATAx bit mismatch
            else if ( (token_pid_w == 8'hC3 && ep_data_bit_r) ||
                      (token_pid_w == 8'h4B && !ep_data_bit_r) )
            begin
                // Ack transfer to resync
                tx_valid_r = 1'b1;
                tx_pid_r   = 8'hD2;
            end
            // Send NAK
            else if (!rx_space_q)
            begin
                tx_valid_r = 1'b1;
                tx_pid_r   = 8'h5A;
            end
            // TODO: USB 2.0, no more buffer space, return NYET
            else
            begin
                tx_valid_r = 1'b1;
                tx_pid_r   = 8'hD2;
            end
       end
    end

    //-----------------------------------------
    // TX_CHIRP
    //-----------------------------------------
    STATE_TX_CHIRP :
    begin
        tx_valid_r = 1'b1;
        tx_pid_r   = 8'b0;
    end

    default :
       ;

    endcase
end

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    tx_valid_q <= 1'b0;
else if (!tx_valid_q || tx_accept_w)
    tx_valid_q <= tx_valid_r;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    tx_pid_q <= 8'b0;
else if (!tx_valid_q || tx_accept_w)
    tx_pid_q <= tx_pid_r;

//-----------------------------------------------------------------
// Receive enable
//-----------------------------------------------------------------
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rx_enable_q <= 1'b0;
else if (usb_rst_w ||reg_chirp_en_i)
    rx_enable_q <= 1'b0;
else
    rx_enable_q <= (state_q == STATE_RX_DATA);

//-----------------------------------------------------------------
// Receive SETUP: Pulse on SETUP packet receive
//-----------------------------------------------------------------
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rx_setup_q <= 1'b0;
else if (usb_rst_w ||reg_chirp_en_i)
    rx_setup_q <= 1'b0;
else if ((state_q == STATE_RX_IDLE) && token_valid_w && (token_pid_w == 8'h2D) && (token_ep_w == 4'd0))
    rx_setup_q <= 1'b1;
else
    rx_setup_q <= 1'b0;

//-----------------------------------------------------------------
// Set Address
//-----------------------------------------------------------------
reg addr_update_pending_q;

wire ep0_tx_zlp_w = ep0_tx_data_valid_i && (ep0_tx_data_strb_i == 1'b0) && 
                    ep0_tx_data_last_i && ep0_tx_data_accept_o;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    addr_update_pending_q   <= 1'b0;
else if (ep0_tx_zlp_w || usb_rst_w)
    addr_update_pending_q   <= 1'b0;
// TODO: Use write strobe
else if (reg_dev_addr_i != current_addr_q)
    addr_update_pending_q   <= 1'b1;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    current_addr_q  <= 7'b0;
else if (usb_rst_w)
    current_addr_q  <= 7'b0;
else if (ep0_tx_zlp_w && addr_update_pending_q)
    current_addr_q  <= reg_dev_addr_i;

//-----------------------------------------------------------------
// SETUP request tracking
//-----------------------------------------------------------------
reg ep0_dir_in_q;
reg ep0_dir_out_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    ep0_dir_in_q <= 1'b0;
else if (usb_rst_w ||reg_chirp_en_i)
    ep0_dir_in_q <= 1'b0;
else if ((state_q == STATE_RX_IDLE) && token_valid_w && (token_pid_w == 8'h2D) && (token_ep_w == 4'd0))
    ep0_dir_in_q <= 1'b0;
else if ((state_q == STATE_RX_IDLE) && token_valid_w && (token_pid_w == 8'h69) && (token_ep_w == 4'd0))
    ep0_dir_in_q <= 1'b1;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    ep0_dir_out_q <= 1'b0;
else if (usb_rst_w ||reg_chirp_en_i)
    ep0_dir_out_q <= 1'b0;
else if ((state_q == STATE_RX_IDLE) && token_valid_w && (token_pid_w == 8'h2D) && (token_ep_w == 4'd0))
    ep0_dir_out_q <= 1'b0;
else if ((state_q == STATE_RX_IDLE) && token_valid_w && (token_pid_w == 8'hE1) && (token_ep_w == 4'd0))
    ep0_dir_out_q <= 1'b1;

assign status_stage_w = ep0_dir_in_q && ep0_dir_out_q && (token_ep_w == 4'd0);

//-----------------------------------------------------------------
// Endpoint data bit toggle
//-----------------------------------------------------------------
reg new_data_bit_r;
always @ *
begin
    new_data_bit_r = ep_data_bit_r;

    case (state_q)
    //-----------------------------------------
    // RX_DATA_READY
    //-----------------------------------------
    STATE_RX_DATA_READY :
    begin
       // Receive complete
       if (rx_data_complete_w)
       begin
            // No toggle on CRC16 error
            if (rx_crc_err_o)
                ;
            // ISO endpoint, no response?
            else if (ep_iso_r)
                ; // TODO: HS handling
            // STALL?
            else if (ep_stall_r)
                ;
            // DATAx bit mismatch
            else if ( (token_pid_w == 8'hC3 && ep_data_bit_r) ||
                      (token_pid_w == 8'h4B && !ep_data_bit_r) )
                ;
            // NAKd
            else if (!rx_space_q)
                ;
            // Data accepted - toggle data bit
            else
                new_data_bit_r = !ep_data_bit_r;
       end
    end
    //-----------------------------------------
    // RX_IDLE
    //-----------------------------------------
    STATE_RX_IDLE :
    begin
        // Token received (OUT, IN, SETUP, PING)
        if (token_valid_w)
        begin
            // SETUP packets always start with DATA0
            if (token_pid_w == 8'h2D)
                new_data_bit_r = 1'b0;
        end
        // ACK received
        else if (rx_handshake_w && token_pid_w == 8'hD2)
        begin
            new_data_bit_r = !ep_data_bit_r;
        end
    end
    default:
        ;
    endcase
end

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    ep0_data_bit_q <= 1'b0;
else if (usb_rst_w)
    ep0_data_bit_q <= 1'b0;
else if (token_ep_w == 4'd0)
    ep0_data_bit_q <= new_data_bit_r;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    ep1_data_bit_q <= 1'b0;
else if (usb_rst_w)
    ep1_data_bit_q <= 1'b0;
else if (token_ep_w == 4'd1)
    ep1_data_bit_q <= new_data_bit_r;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    ep2_data_bit_q <= 1'b0;
else if (usb_rst_w)
    ep2_data_bit_q <= 1'b0;
else if (token_ep_w == 4'd2)
    ep2_data_bit_q <= new_data_bit_r;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    ep3_data_bit_q <= 1'b0;
else if (usb_rst_w)
    ep3_data_bit_q <= 1'b0;
else if (token_ep_w == 4'd3)
    ep3_data_bit_q <= new_data_bit_r;

//-----------------------------------------------------------------
// Reset event
//-----------------------------------------------------------------
reg rst_event_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rst_event_q <= 1'b0;
else if (usb_rst_w)
    rst_event_q <= 1'b1;
else if (reg_sts_rst_clr_i)
    rst_event_q <= 1'b0;

assign reg_sts_rst_o = rst_event_q;

//-----------------------------------------------------------------
// Interrupts
//-----------------------------------------------------------------
reg intr_q;

reg cfg_int_rx_r;
reg cfg_int_tx_r;

always @ *
begin
    cfg_int_rx_r = 1'b0;
    cfg_int_tx_r = 1'b0;

    case (token_ep_w)
    4'd0:
    begin
        cfg_int_rx_r = ep0_cfg_int_rx_i;
        cfg_int_tx_r = ep0_cfg_int_tx_i;
    end
    4'd1:
    begin
        cfg_int_rx_r = ep1_cfg_int_rx_i;
        cfg_int_tx_r = ep1_cfg_int_tx_i;
    end
    4'd2:
    begin
        cfg_int_rx_r = ep2_cfg_int_rx_i;
        cfg_int_tx_r = ep2_cfg_int_tx_i;
    end
    4'd3:
    begin
        cfg_int_rx_r = ep3_cfg_int_rx_i;
        cfg_int_tx_r = ep3_cfg_int_tx_i;
    end
    default:
        ;
    endcase
end

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    intr_q <= 1'b0;
// SOF
else if (frame_valid_w && reg_int_en_sof_i)
    intr_q <= 1'b1;
// Reset event
else if (!rst_event_q && usb_rst_w)
    intr_q <= 1'b1;
// Rx ready
else if (state_q == STATE_RX_DATA_READY && rx_space_q && cfg_int_rx_r)
    intr_q <= 1'b1;
// Tx complete
else if (state_q == STATE_TX_DATA_COMPLETE && cfg_int_tx_r)
    intr_q <= 1'b1;    
else
    intr_q <= 1'b0;

assign intr_o = intr_q;

endmodule
