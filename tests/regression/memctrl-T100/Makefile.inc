#Parameters that need to be changed depending on benchmark
IS_FLATTENED = false
TOP_MODULE 	= mc_top
CLK_NAME 	= clk_i
RESET_NAME 	= rst_i
RESET_EDGE 	= 1
UNROLL_CYC	= 10
OBJ_SRC 	= ./src/mc_adr_sel.v \
	./src/mc_cs_rf.v \
	./src/mc_dp.v \
	./src/mc_incn_r.v \
	./src/mc_mem_if.v \
	./src/mc_obct.v \
	./src/mc_obct_top.v \
	./src/mc_rd_fifo.v \
	./src/mc_refresh.v \
	./src/mc_rf.v \
	./src/mc_timing.v \
	./src/mc_top.v \
	./src/mc_wb_if.v
