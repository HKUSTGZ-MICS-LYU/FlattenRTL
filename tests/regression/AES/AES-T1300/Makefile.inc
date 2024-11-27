#Parameters that need to be changed depending on benchmark
IS_FLATTENED = false
TOP_MODULE 	= top
CLK_NAME 	= clk
RESET_NAME 	= rst
RESET_EDGE 	= 1
UNROLL_CYC	= 10
TARGET		= 178748
OBJ_SRC 	= 	./src/aes_128.v		\
				./src/round.v		\
				./src/table.v		\
				./src/top.v			\
				./src/TSC.v

