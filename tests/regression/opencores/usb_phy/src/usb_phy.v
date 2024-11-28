module usb_phy(clk, rst, phy_tx_mode, usb_rst,
	
		// Transciever Interface
		txdp, txdn, txoe,	
		rxd, rxdp, rxdn,

		// UTMI Interface
		DataOut_i, TxValid_i, TxReady_o, RxValid_o,
		RxActive_o, RxError_o, DataIn_o, LineState_o
		);

input		clk;
input		rst;
input		phy_tx_mode;
output		usb_rst;
output		txdp, txdn, txoe;
input		rxd, rxdp, rxdn;
input	[7:0]	DataOut_i;
input		TxValid_i;
output		TxReady_o;
output	[7:0]	DataIn_o;
output		RxValid_o;
output		RxActive_o;
output		RxError_o;
output	[1:0]	LineState_o;

///////////////////////////////////////////////////////////////////
//
// Local Wires and Registers
//

reg	[4:0]	rst_cnt;
reg		usb_rst;
wire		fs_ce;
wire		rst;

///////////////////////////////////////////////////////////////////
//
// Misc Logic
//

///////////////////////////////////////////////////////////////////
//
// TX Phy
//

usb_tx_phy i_tx_phy(
	.clk(		clk		),
	.rst(		rst		),
	.fs_ce(		fs_ce		),
	.phy_mode(	phy_tx_mode	),

	// Transciever Interface
	.txdp(		txdp		),
	.txdn(		txdn		),
	.txoe(		txoe		),

	// UTMI Interface
	.DataOut_i(	DataOut_i	),
	.TxValid_i(	TxValid_i	),
	.TxReady_o(	TxReady_o	)
	);

///////////////////////////////////////////////////////////////////
//
// RX Phy and DPLL
//

usb_rx_phy i_rx_phy(
	.clk(		clk		),
	.rst(		rst		),
	.fs_ce(		fs_ce		),

	// Transciever Interface
	.rxd(		rxd		),
	.rxdp(		rxdp		),
	.rxdn(		rxdn		),

	// UTMI Interface
	.DataIn_o(	DataIn_o	),
	.RxValid_o(	RxValid_o	),
	.RxActive_o(	RxActive_o	),
	.RxError_o(	RxError_o	),
	.RxEn_i(	txoe		),
	.LineState(	LineState_o	)
	);

///////////////////////////////////////////////////////////////////
//
// Generate an USB Reset is we see SE0 for at least 2.5uS
//

always @(posedge clk or negedge rst)
	if(!rst)			rst_cnt <= 5'h0;
	else
	if(LineState_o != 2'h0)		rst_cnt <= 5'h0;
	else	
	if(!usb_rst && fs_ce)		rst_cnt <= rst_cnt + 5'h1;

always @(posedge clk or negedge rst)
	if(!rst)	usb_rst <= 1'b0;
	else usb_rst <= (rst_cnt == 5'h1f);

endmodule

