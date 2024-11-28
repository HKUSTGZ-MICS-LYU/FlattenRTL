#Parameters that need to be changed depending on benchmark
IS_FLATTENED = false
TOP_MODULE 	= usb_phy
CLK_NAME 	= clk
RESET_NAME 	= rst
RESET_EDGE 	= 0
UNROLL_CYC	= 20
OBJ_SRC 	= ./src/usb_phy.v		\
		./src/usb_rx_phy.v			\
		./src/usb_tx_phy.v

