#Parameters that need to be changed depending on benchmark
IS_FLATTENED = false
TOP_MODULE 	= dma_axi64_core0_top
CLK_NAME 	= clk
RESET_NAME 	= reset
RESET_EDGE 	= 1
UNROLL_CYC	= 10
OBJ_SRC 	= ./src/dma_axi64_core0_top.v \
./src/dma_axi64_reg_params.v \
./src/prgen_fifo.v \
./src/prgen_scatter8_1.v \
./src/dma_axi64_core0_ch_offsets.v \
./src/prgen_stall.v \
./src/dma_axi64_reg.v \
./src/dma_axi64_core0_ch.v \
./src/dma_axi64_core0_ch_fifo_ctrl.v \
./src/dma_axi64_core0_ch_fifo_ptr.v \
./src/dma_axi64_core0_ch_empty.v \
./src/prgen_swap_64.v \
./src/dma_axi64_core0_ch_reg_size.v \
./src/dma_axi64_core0_channels_apb_mux.v \
./src/dma_axi64_core0_ctrl.v \
./src/dma_axi64_core0_ch_wr_slicer.v \
./src/dma_axi64_core0_axim_cmd.v \
./src/dma_axi64_core0_ch_remain.v \
./src/prgen_demux8.v \
./src/dma_axi64_core0_ch_calc_size.v \
./src/prgen_swap_32.v \
./src/dma_axi64_dual_core.v \
./src/dma_axi64_core0_ch_periph_mux.v \
./src/prgen_min3.v \
./src/dma_axi64_core0_ch_calc_joint.v \
./src/dma_axi64_ch_reg_params.v \
./src/prgen_delay.v \
./src/dma_axi64_core0_ch_outs.v \
./src/prgen_min2.v \
./src/dma_axi64_core0_axim_rd.v \
./src/dma_axi64_core0_channels.v \
./src/dma_axi64_core0_ch_reg.v \
./src/dma_axi64_apb_mux.v \
./src/dma_axi64_core0_arbiter.v \
./src/dma_axi64_core0_axim_resp.v \
./src/dma_axi64.v \
./src/dma_axi64_core0_ch_calc_addr.v \
./src/prgen_joint_stall.v \
./src/prgen_rawstat.v \
./src/dma_axi64_core0_channels_mux.v \
./src/dma_axi64_core0.v \
./src/dma_axi64_core0_axim_timeout.v \
./src/dma_axi64_core0_axim_wr.v \
./src/prgen_or8.v \
./src/dma_axi64_core0_ch_rd_slicer.v \
./src/dma_axi64_core0_ch_calc.v \
./src/dma_axi64_core0_wdt.v \
./src/dma_axi64_core0_ch_fifo.v \
./src/dma_axi64_core0_axim_wdata.v \
./src/dma_axi64_reg_core0.v \
./src/dma_axi64_core0_axim_rdata.v \
./src/prgen_mux8.v \
./src/dma_axi64_defines.v
