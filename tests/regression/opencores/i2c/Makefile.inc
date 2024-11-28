#Parameters that need to be changed depending on benchmark
IS_FLATTENED = false
TOP_MODULE 	= i2c_master_top
CLK_NAME 	= wb_clk_i
RESET_NAME 	= rst_i
RESET_EDGE 	= 0
UNROLL_CYC	= 20
OBJ_SRC 	= ./src/i2c_master_bit_ctrl.v	\
	./src/i2c_master_byte_ctrl.v		\
	./src/i2c_master_defines.v			\
	./src/i2c_master_top.v			\

