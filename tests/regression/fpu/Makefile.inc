#Parameters that need to be changed depending on benchmark
IS_FLATTENED = false
TOP_MODULE 	= fpu
CLK_NAME 	= clk
RESET_NAME 	= reset
RESET_EDGE 	= 1
UNROLL_CYC	= 10
OBJ_SRC 	= ./src/fpu.v \
./src/pre_norm.v \
./src/primitives.v \
./src/except.v \
./src/pre_norm_fmul.v \
./src/post_norm.v
