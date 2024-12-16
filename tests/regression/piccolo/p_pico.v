/* PREHEADER */







/* END OF PREHEADER */
module wrapper(
__ILA_I_inst,
__ISSUE__,
__VLG_I_EN_hart0_server_reset_request_put,
__VLG_I_EN_hart0_server_reset_response_get,
__VLG_I_EN_set_verbosity,
__VLG_I_dmem_master_arready,
__VLG_I_dmem_master_awready,
__VLG_I_dmem_master_bid,
__VLG_I_dmem_master_bresp,
__VLG_I_dmem_master_bvalid,
__VLG_I_dmem_master_rdata,
__VLG_I_dmem_master_rid,
__VLG_I_dmem_master_rlast,
__VLG_I_dmem_master_rresp,
__VLG_I_dmem_master_rvalid,
__VLG_I_dmem_master_wready,
__VLG_I_hart0_server_reset_request_put,
__VLG_I_imem_master_arready,
__VLG_I_imem_master_awready,
__VLG_I_imem_master_bid,
__VLG_I_imem_master_bresp,
__VLG_I_imem_master_bvalid,
__VLG_I_imem_master_rdata,
__VLG_I_imem_master_rid,
__VLG_I_imem_master_rlast,
__VLG_I_imem_master_rresp,
__VLG_I_imem_master_rvalid,
__VLG_I_imem_master_wready,
__VLG_I_set_verbosity_logdelay,
__VLG_I_set_verbosity_verbosity,
____auxvar10__recorder_init__,
____auxvar11__recorder_init__,
____auxvar12__recorder_init__,
____auxvar13__recorder_init__,
____auxvar14__recorder_init__,
____auxvar15__recorder_init__,
____auxvar16__recorder_init__,
____auxvar17__recorder_init__,
____auxvar18__recorder_init__,
____auxvar19__recorder_init__,
____auxvar1__recorder_init__,
____auxvar20__recorder_init__,
____auxvar21__recorder_init__,
____auxvar22__recorder_init__,
____auxvar23__recorder_init__,
____auxvar24__recorder_init__,
____auxvar25__recorder_init__,
____auxvar26__recorder_init__,
____auxvar27__recorder_init__,
____auxvar28__recorder_init__,
____auxvar29__recorder_init__,
____auxvar2__recorder_init__,
____auxvar30__recorder_init__,
____auxvar31__recorder_init__,
____auxvar32__recorder_init__,
____auxvar33__recorder_init__,
____auxvar34__recorder_init__,
____auxvar35__recorder_init__,
____auxvar36__recorder_init__,
____auxvar37__recorder_init__,
____auxvar38__recorder_init__,
____auxvar3__recorder_init__,
____auxvar4__recorder_init__,
____auxvar5__recorder_init__,
____auxvar6__recorder_init__,
____auxvar7__recorder_init__,
____auxvar8__recorder_init__,
____auxvar9__recorder_init__,
clk,
dummy_reset,
rst,
RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg,
RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg,
RTL__DOT__csr_regfile__DOT__rg_nmi,
RTL__DOT__csr_regfile__DOT__rg_state,
RTL__DOT__f_reset_reqs__DOT__empty_reg,
RTL__DOT__f_reset_reqs__DOT__full_reg,
RTL__DOT__f_reset_rsps__DOT__empty_reg,
RTL__DOT__f_reset_rsps__DOT__full_reg,
RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg,
RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_,
RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_,
RTL__DOT__near_mem$EN_dmem_req,
RTL__DOT__near_mem$dmem_exc,
RTL__DOT__near_mem$dmem_req_addr,
RTL__DOT__near_mem$dmem_req_f3,
RTL__DOT__near_mem$dmem_req_op,
RTL__DOT__near_mem$dmem_req_store_value,
RTL__DOT__near_mem$dmem_word64,
RTL__DOT__near_mem$imem_instr,
RTL__DOT__near_mem$imem_pc,
RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg,
RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr,
RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa,
RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg,
RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg,
RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg,
RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg,
RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg,
RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg,
RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg,
RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg,
RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg,
RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg,
RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg,
RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg,
RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg,
RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg,
RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg,
RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg,
RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg,
RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg,
RTL__DOT__rg_cur_priv,
RTL__DOT__rg_retiring$EN,
RTL__DOT__rg_run_on_reset,
RTL__DOT__rg_state,
RTL__DOT__rg_trap_instr,
RTL__DOT__s1_to_s2$D_IN,
RTL__DOT__s1_to_s2$EN,
RTL__DOT__s2_to_s3$D_IN,
RTL__DOT__s2_to_s3$EN,
RTL__DOT__s3_deq$D_IN,
RTL__DOT__s3_deq$EN,
RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg,
RTL__DOT__stage1_f_reset_reqs__DOT__full_reg,
RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg,
RTL__DOT__stage1_f_reset_rsps__DOT__full_reg,
RTL__DOT__stage1_rg_full,
RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg,
RTL__DOT__stage2_f_reset_reqs__DOT__full_reg,
RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg,
RTL__DOT__stage2_f_reset_rsps__DOT__full_reg,
RTL__DOT__stage2_rg_full,
RTL__DOT__stage2_rg_stage2,
RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg,
RTL__DOT__stage3_f_reset_reqs__DOT__full_reg,
RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg,
RTL__DOT__stage3_f_reset_rsps__DOT__full_reg,
RTL__DOT__stage3_rg_full,
__EDCOND__,
__IEND__,
__ILA_SO_load_addr,
__ILA_SO_load_data,
__ILA_SO_load_en,
__ILA_SO_load_size,
__ILA_SO_pc,
__ILA_SO_store_addr,
__ILA_SO_store_data,
__ILA_SO_store_en,
__ILA_SO_store_size,
__ILA_SO_x0,
__ILA_SO_x1,
__ILA_SO_x10,
__ILA_SO_x11,
__ILA_SO_x12,
__ILA_SO_x13,
__ILA_SO_x14,
__ILA_SO_x15,
__ILA_SO_x16,
__ILA_SO_x17,
__ILA_SO_x18,
__ILA_SO_x19,
__ILA_SO_x2,
__ILA_SO_x20,
__ILA_SO_x21,
__ILA_SO_x22,
__ILA_SO_x23,
__ILA_SO_x24,
__ILA_SO_x25,
__ILA_SO_x26,
__ILA_SO_x27,
__ILA_SO_x28,
__ILA_SO_x29,
__ILA_SO_x3,
__ILA_SO_x30,
__ILA_SO_x31,
__ILA_SO_x4,
__ILA_SO_x5,
__ILA_SO_x6,
__ILA_SO_x7,
__ILA_SO_x8,
__ILA_SO_x9,
__VLG_II_m_external_interrupt_req_set_not_clear,
__VLG_II_nmi_req_set_not_clear,
__VLG_II_s_external_interrupt_req_set_not_clear,
__VLG_II_software_interrupt_req_set_not_clear,
__VLG_II_timer_interrupt_req_set_not_clear,
__VLG_O_RDY_hart0_server_reset_request_put,
__VLG_O_RDY_hart0_server_reset_response_get,
__VLG_O_RDY_set_verbosity,
__VLG_O_dmem_master_araddr,
__VLG_O_dmem_master_arburst,
__VLG_O_dmem_master_arcache,
__VLG_O_dmem_master_arid,
__VLG_O_dmem_master_arlen,
__VLG_O_dmem_master_arlock,
__VLG_O_dmem_master_arprot,
__VLG_O_dmem_master_arqos,
__VLG_O_dmem_master_arregion,
__VLG_O_dmem_master_arsize,
__VLG_O_dmem_master_arvalid,
__VLG_O_dmem_master_awaddr,
__VLG_O_dmem_master_awburst,
__VLG_O_dmem_master_awcache,
__VLG_O_dmem_master_awid,
__VLG_O_dmem_master_awlen,
__VLG_O_dmem_master_awlock,
__VLG_O_dmem_master_awprot,
__VLG_O_dmem_master_awqos,
__VLG_O_dmem_master_awregion,
__VLG_O_dmem_master_awsize,
__VLG_O_dmem_master_awvalid,
__VLG_O_dmem_master_bready,
__VLG_O_dmem_master_rready,
__VLG_O_dmem_master_wdata,
__VLG_O_dmem_master_wlast,
__VLG_O_dmem_master_wstrb,
__VLG_O_dmem_master_wvalid,
__VLG_O_hart0_server_reset_response_get,
__VLG_O_imem_master_araddr,
__VLG_O_imem_master_arburst,
__VLG_O_imem_master_arcache,
__VLG_O_imem_master_arid,
__VLG_O_imem_master_arlen,
__VLG_O_imem_master_arlock,
__VLG_O_imem_master_arprot,
__VLG_O_imem_master_arqos,
__VLG_O_imem_master_arregion,
__VLG_O_imem_master_arsize,
__VLG_O_imem_master_arvalid,
__VLG_O_imem_master_awaddr,
__VLG_O_imem_master_awburst,
__VLG_O_imem_master_awcache,
__VLG_O_imem_master_awid,
__VLG_O_imem_master_awlen,
__VLG_O_imem_master_awlock,
__VLG_O_imem_master_awprot,
__VLG_O_imem_master_awqos,
__VLG_O_imem_master_awregion,
__VLG_O_imem_master_awsize,
__VLG_O_imem_master_awvalid,
__VLG_O_imem_master_bready,
__VLG_O_imem_master_rready,
__VLG_O_imem_master_wdata,
__VLG_O_imem_master_wlast,
__VLG_O_imem_master_wstrb,
__VLG_O_imem_master_wvalid,
__all_assert_wire__,
__all_assume_wire__,
__auxvar0__delay_d_0,
__sanitycheck_wire__,
end_of_pipeline,
input_map_assume___p0__,
invariant_assume__p10__,
invariant_assume__p11__,
invariant_assume__p12__,
invariant_assume__p13__,
invariant_assume__p14__,
invariant_assume__p15__,
invariant_assume__p16__,
invariant_assume__p17__,
invariant_assume__p18__,
invariant_assume__p19__,
invariant_assume__p1__,
invariant_assume__p20__,
invariant_assume__p21__,
invariant_assume__p22__,
invariant_assume__p23__,
invariant_assume__p24__,
invariant_assume__p25__,
invariant_assume__p26__,
invariant_assume__p27__,
invariant_assume__p28__,
invariant_assume__p29__,
invariant_assume__p2__,
invariant_assume__p30__,
invariant_assume__p31__,
invariant_assume__p32__,
invariant_assume__p3__,
invariant_assume__p4__,
invariant_assume__p5__,
invariant_assume__p6__,
invariant_assume__p7__,
invariant_assume__p8__,
invariant_assume__p9__,
issue_decode__p33__,
issue_valid__p34__,
mem_req_addr,
mem_req_en,
mem_req_funct3,
mem_req_op,
mem_req_rd_data,
mem_req_wd_data,
monitor_s1,
monitor_s1_already_enter_cond,
monitor_s1_already_exit_cond,
monitor_s2_enter_cond,
monitor_s2_exit_cond,
monitor_s3_enter_cond,
monitor_s3_exit_cond,
monitor_s4_enter_cond,
monitor_s4_exit_cond,
noreset__p35__,
post_value_holder__p36__,
post_value_holder__p37__,
post_value_holder__p38__,
post_value_holder__p39__,
post_value_holder__p40__,
post_value_holder__p41__,
post_value_holder__p42__,
post_value_holder__p43__,
post_value_holder__p44__,
post_value_holder__p45__,
post_value_holder__p46__,
post_value_holder__p47__,
post_value_holder__p48__,
post_value_holder__p49__,
post_value_holder__p50__,
post_value_holder__p51__,
post_value_holder__p52__,
post_value_holder__p53__,
post_value_holder__p54__,
post_value_holder__p55__,
post_value_holder__p56__,
post_value_holder__p57__,
post_value_holder__p58__,
post_value_holder__p59__,
post_value_holder__p60__,
post_value_holder__p61__,
post_value_holder__p62__,
post_value_holder__p63__,
post_value_holder__p64__,
post_value_holder__p65__,
post_value_holder__p66__,
post_value_holder__p67__,
post_value_holder__p68__,
post_value_holder__p69__,
post_value_holder__p70__,
post_value_holder__p71__,
post_value_holder__p72__,
post_value_holder__p73__,
post_value_holder_overly_constrained__p153__,
post_value_holder_overly_constrained__p154__,
post_value_holder_overly_constrained__p155__,
post_value_holder_overly_constrained__p156__,
post_value_holder_overly_constrained__p157__,
post_value_holder_overly_constrained__p158__,
post_value_holder_overly_constrained__p159__,
post_value_holder_overly_constrained__p160__,
post_value_holder_overly_constrained__p161__,
post_value_holder_overly_constrained__p162__,
post_value_holder_overly_constrained__p163__,
post_value_holder_overly_constrained__p164__,
post_value_holder_overly_constrained__p165__,
post_value_holder_overly_constrained__p166__,
post_value_holder_overly_constrained__p167__,
post_value_holder_overly_constrained__p168__,
post_value_holder_overly_constrained__p169__,
post_value_holder_overly_constrained__p170__,
post_value_holder_overly_constrained__p171__,
post_value_holder_overly_constrained__p172__,
post_value_holder_overly_constrained__p173__,
post_value_holder_overly_constrained__p174__,
post_value_holder_overly_constrained__p175__,
post_value_holder_overly_constrained__p176__,
post_value_holder_overly_constrained__p177__,
post_value_holder_overly_constrained__p178__,
post_value_holder_overly_constrained__p179__,
post_value_holder_overly_constrained__p180__,
post_value_holder_overly_constrained__p181__,
post_value_holder_overly_constrained__p182__,
post_value_holder_overly_constrained__p183__,
post_value_holder_overly_constrained__p184__,
post_value_holder_overly_constrained__p185__,
post_value_holder_overly_constrained__p186__,
post_value_holder_overly_constrained__p187__,
post_value_holder_overly_constrained__p188__,
post_value_holder_overly_constrained__p189__,
post_value_holder_overly_constrained__p190__,
post_value_holder_triggered__p191__,
post_value_holder_triggered__p192__,
post_value_holder_triggered__p193__,
post_value_holder_triggered__p194__,
post_value_holder_triggered__p195__,
post_value_holder_triggered__p196__,
post_value_holder_triggered__p197__,
post_value_holder_triggered__p198__,
post_value_holder_triggered__p199__,
post_value_holder_triggered__p200__,
post_value_holder_triggered__p201__,
post_value_holder_triggered__p202__,
post_value_holder_triggered__p203__,
post_value_holder_triggered__p204__,
post_value_holder_triggered__p205__,
post_value_holder_triggered__p206__,
post_value_holder_triggered__p207__,
post_value_holder_triggered__p208__,
post_value_holder_triggered__p209__,
post_value_holder_triggered__p210__,
post_value_holder_triggered__p211__,
post_value_holder_triggered__p212__,
post_value_holder_triggered__p213__,
post_value_holder_triggered__p214__,
post_value_holder_triggered__p215__,
post_value_holder_triggered__p216__,
post_value_holder_triggered__p217__,
post_value_holder_triggered__p218__,
post_value_holder_triggered__p219__,
post_value_holder_triggered__p220__,
post_value_holder_triggered__p221__,
post_value_holder_triggered__p222__,
post_value_holder_triggered__p223__,
post_value_holder_triggered__p224__,
post_value_holder_triggered__p225__,
post_value_holder_triggered__p226__,
post_value_holder_triggered__p227__,
post_value_holder_triggered__p228__,
rfassumptions__p74__,
rfassumptions__p75__,
rfassumptions__p76__,
s2_enter,
s2_exit,
s3_enter,
s3_exit,
s4_enter,
variable_map_assert__p118__,
variable_map_assert__p119__,
variable_map_assert__p120__,
variable_map_assert__p121__,
variable_map_assert__p122__,
variable_map_assert__p123__,
variable_map_assert__p124__,
variable_map_assert__p125__,
variable_map_assert__p126__,
variable_map_assert__p127__,
variable_map_assert__p128__,
variable_map_assert__p129__,
variable_map_assert__p130__,
variable_map_assert__p131__,
variable_map_assert__p132__,
variable_map_assert__p133__,
variable_map_assert__p134__,
variable_map_assert__p135__,
variable_map_assert__p136__,
variable_map_assert__p137__,
variable_map_assert__p138__,
variable_map_assert__p139__,
variable_map_assert__p140__,
variable_map_assert__p141__,
variable_map_assert__p142__,
variable_map_assert__p143__,
variable_map_assert__p144__,
variable_map_assert__p145__,
variable_map_assert__p146__,
variable_map_assert__p147__,
variable_map_assert__p148__,
variable_map_assert__p149__,
variable_map_assert__p150__,
variable_map_assert__p151__,
variable_map_assert__p152__,
variable_map_assume___p100__,
variable_map_assume___p101__,
variable_map_assume___p102__,
variable_map_assume___p103__,
variable_map_assume___p104__,
variable_map_assume___p105__,
variable_map_assume___p106__,
variable_map_assume___p107__,
variable_map_assume___p108__,
variable_map_assume___p109__,
variable_map_assume___p110__,
variable_map_assume___p111__,
variable_map_assume___p112__,
variable_map_assume___p113__,
variable_map_assume___p114__,
variable_map_assume___p115__,
variable_map_assume___p116__,
variable_map_assume___p117__,
variable_map_assume___p77__,
variable_map_assume___p78__,
variable_map_assume___p79__,
variable_map_assume___p80__,
variable_map_assume___p81__,
variable_map_assume___p82__,
variable_map_assume___p83__,
variable_map_assume___p84__,
variable_map_assume___p85__,
variable_map_assume___p86__,
variable_map_assume___p87__,
variable_map_assume___p88__,
variable_map_assume___p89__,
variable_map_assume___p90__,
variable_map_assume___p91__,
variable_map_assume___p92__,
variable_map_assume___p93__,
variable_map_assume___p94__,
variable_map_assume___p95__,
variable_map_assume___p96__,
variable_map_assume___p97__,
variable_map_assume___p98__,
variable_map_assume___p99__,
__CYCLE_CNT__,
__START__,
__STARTED__,
__ENDED__,
__2ndENDED__,
__RESETED__,
__auxvar10__recorder,
__auxvar10__recorder_sn_vhold,
__auxvar10__recorder_sn_condmet,
__auxvar11__recorder,
__auxvar11__recorder_sn_vhold,
__auxvar11__recorder_sn_condmet,
__auxvar12__recorder,
__auxvar12__recorder_sn_vhold,
__auxvar12__recorder_sn_condmet,
__auxvar13__recorder,
__auxvar13__recorder_sn_vhold,
__auxvar13__recorder_sn_condmet,
__auxvar14__recorder,
__auxvar14__recorder_sn_vhold,
__auxvar14__recorder_sn_condmet,
__auxvar15__recorder,
__auxvar15__recorder_sn_vhold,
__auxvar15__recorder_sn_condmet,
__auxvar16__recorder,
__auxvar16__recorder_sn_vhold,
__auxvar16__recorder_sn_condmet,
__auxvar17__recorder,
__auxvar17__recorder_sn_vhold,
__auxvar17__recorder_sn_condmet,
__auxvar18__recorder,
__auxvar18__recorder_sn_vhold,
__auxvar18__recorder_sn_condmet,
__auxvar19__recorder,
__auxvar19__recorder_sn_vhold,
__auxvar19__recorder_sn_condmet,
__auxvar1__recorder,
__auxvar1__recorder_sn_vhold,
__auxvar1__recorder_sn_condmet,
__auxvar20__recorder,
__auxvar20__recorder_sn_vhold,
__auxvar20__recorder_sn_condmet,
__auxvar21__recorder,
__auxvar21__recorder_sn_vhold,
__auxvar21__recorder_sn_condmet,
__auxvar22__recorder,
__auxvar22__recorder_sn_vhold,
__auxvar22__recorder_sn_condmet,
__auxvar23__recorder,
__auxvar23__recorder_sn_vhold,
__auxvar23__recorder_sn_condmet,
__auxvar24__recorder,
__auxvar24__recorder_sn_vhold,
__auxvar24__recorder_sn_condmet,
__auxvar25__recorder,
__auxvar25__recorder_sn_vhold,
__auxvar25__recorder_sn_condmet,
__auxvar26__recorder,
__auxvar26__recorder_sn_vhold,
__auxvar26__recorder_sn_condmet,
__auxvar27__recorder,
__auxvar27__recorder_sn_vhold,
__auxvar27__recorder_sn_condmet,
__auxvar28__recorder,
__auxvar28__recorder_sn_vhold,
__auxvar28__recorder_sn_condmet,
__auxvar29__recorder,
__auxvar29__recorder_sn_vhold,
__auxvar29__recorder_sn_condmet,
__auxvar2__recorder,
__auxvar2__recorder_sn_vhold,
__auxvar2__recorder_sn_condmet,
__auxvar30__recorder,
__auxvar30__recorder_sn_vhold,
__auxvar30__recorder_sn_condmet,
__auxvar31__recorder,
__auxvar31__recorder_sn_vhold,
__auxvar31__recorder_sn_condmet,
__auxvar32__recorder,
__auxvar32__recorder_sn_vhold,
__auxvar32__recorder_sn_condmet,
__auxvar33__recorder,
__auxvar33__recorder_sn_vhold,
__auxvar33__recorder_sn_condmet,
__auxvar34__recorder,
__auxvar34__recorder_sn_vhold,
__auxvar34__recorder_sn_condmet,
__auxvar35__recorder,
__auxvar35__recorder_sn_vhold,
__auxvar35__recorder_sn_condmet,
__auxvar36__recorder,
__auxvar36__recorder_sn_vhold,
__auxvar36__recorder_sn_condmet,
__auxvar37__recorder,
__auxvar37__recorder_sn_vhold,
__auxvar37__recorder_sn_condmet,
__auxvar38__recorder,
__auxvar38__recorder_sn_vhold,
__auxvar38__recorder_sn_condmet,
__auxvar3__recorder,
__auxvar3__recorder_sn_vhold,
__auxvar3__recorder_sn_condmet,
__auxvar4__recorder,
__auxvar4__recorder_sn_vhold,
__auxvar4__recorder_sn_condmet,
__auxvar5__recorder,
__auxvar5__recorder_sn_vhold,
__auxvar5__recorder_sn_condmet,
__auxvar6__recorder,
__auxvar6__recorder_sn_vhold,
__auxvar6__recorder_sn_condmet,
__auxvar7__recorder,
__auxvar7__recorder_sn_vhold,
__auxvar7__recorder_sn_condmet,
__auxvar8__recorder,
__auxvar8__recorder_sn_vhold,
__auxvar8__recorder_sn_condmet,
__auxvar9__recorder,
__auxvar9__recorder_sn_vhold,
__auxvar9__recorder_sn_condmet,
__auxvar0__delay_d_1,
monitor_s1_already,
monitor_s2,
monitor_s3,
monitor_s4
);
input     [31:0] __ILA_I_inst;
input            __ISSUE__;
input            __VLG_I_EN_hart0_server_reset_request_put;
input            __VLG_I_EN_hart0_server_reset_response_get;
input            __VLG_I_EN_set_verbosity;
input            __VLG_I_dmem_master_arready;
input            __VLG_I_dmem_master_awready;
input      [3:0] __VLG_I_dmem_master_bid;
input      [1:0] __VLG_I_dmem_master_bresp;
input            __VLG_I_dmem_master_bvalid;
input     [63:0] __VLG_I_dmem_master_rdata;
input      [3:0] __VLG_I_dmem_master_rid;
input            __VLG_I_dmem_master_rlast;
input      [1:0] __VLG_I_dmem_master_rresp;
input            __VLG_I_dmem_master_rvalid;
input            __VLG_I_dmem_master_wready;
input            __VLG_I_hart0_server_reset_request_put;
input            __VLG_I_imem_master_arready;
input            __VLG_I_imem_master_awready;
input      [3:0] __VLG_I_imem_master_bid;
input      [1:0] __VLG_I_imem_master_bresp;
input            __VLG_I_imem_master_bvalid;
input     [63:0] __VLG_I_imem_master_rdata;
input      [3:0] __VLG_I_imem_master_rid;
input            __VLG_I_imem_master_rlast;
input      [1:0] __VLG_I_imem_master_rresp;
input            __VLG_I_imem_master_rvalid;
input            __VLG_I_imem_master_wready;
input     [63:0] __VLG_I_set_verbosity_logdelay;
input      [3:0] __VLG_I_set_verbosity_verbosity;
input     [31:0] ____auxvar10__recorder_init__;
input     [31:0] ____auxvar11__recorder_init__;
input     [31:0] ____auxvar12__recorder_init__;
input     [31:0] ____auxvar13__recorder_init__;
input     [31:0] ____auxvar14__recorder_init__;
input     [31:0] ____auxvar15__recorder_init__;
input     [31:0] ____auxvar16__recorder_init__;
input     [31:0] ____auxvar17__recorder_init__;
input     [31:0] ____auxvar18__recorder_init__;
input     [31:0] ____auxvar19__recorder_init__;
input     [31:0] ____auxvar1__recorder_init__;
input     [31:0] ____auxvar20__recorder_init__;
input     [31:0] ____auxvar21__recorder_init__;
input     [31:0] ____auxvar22__recorder_init__;
input     [31:0] ____auxvar23__recorder_init__;
input     [31:0] ____auxvar24__recorder_init__;
input     [31:0] ____auxvar25__recorder_init__;
input     [31:0] ____auxvar26__recorder_init__;
input     [31:0] ____auxvar27__recorder_init__;
input     [31:0] ____auxvar28__recorder_init__;
input     [31:0] ____auxvar29__recorder_init__;
input     [31:0] ____auxvar2__recorder_init__;
input     [31:0] ____auxvar30__recorder_init__;
input     [31:0] ____auxvar31__recorder_init__;
input     [31:0] ____auxvar32__recorder_init__;
input     [31:0] ____auxvar33__recorder_init__;
input            ____auxvar34__recorder_init__;
input      [2:0] ____auxvar35__recorder_init__;
input            ____auxvar36__recorder_init__;
input     [31:0] ____auxvar37__recorder_init__;
input     [31:0] ____auxvar38__recorder_init__;
input     [31:0] ____auxvar3__recorder_init__;
input     [31:0] ____auxvar4__recorder_init__;
input     [31:0] ____auxvar5__recorder_init__;
input     [31:0] ____auxvar6__recorder_init__;
input     [31:0] ____auxvar7__recorder_init__;
input     [31:0] ____auxvar8__recorder_init__;
input     [31:0] ____auxvar9__recorder_init__;
input            clk;
input            dummy_reset;
input            rst;
output            RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg;
output            RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg;
output            RTL__DOT__csr_regfile__DOT__rg_nmi;
output            RTL__DOT__csr_regfile__DOT__rg_state;
output            RTL__DOT__f_reset_reqs__DOT__empty_reg;
output            RTL__DOT__f_reset_reqs__DOT__full_reg;
output            RTL__DOT__f_reset_rsps__DOT__empty_reg;
output            RTL__DOT__f_reset_rsps__DOT__full_reg;
output            RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg;
output            RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_;
output     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_;
output            RTL__DOT__near_mem$EN_dmem_req;
output            RTL__DOT__near_mem$dmem_exc;
output     [31:0] RTL__DOT__near_mem$dmem_req_addr;
output      [2:0] RTL__DOT__near_mem$dmem_req_f3;
output            RTL__DOT__near_mem$dmem_req_op;
output     [63:0] RTL__DOT__near_mem$dmem_req_store_value;
output     [63:0] RTL__DOT__near_mem$dmem_word64;
output     [31:0] RTL__DOT__near_mem$imem_instr;
output     [31:0] RTL__DOT__near_mem$imem_pc;
output            RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg;
output     [31:0] RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr;
output     [31:0] RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa;
output            RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg;
output            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg;
output      [1:0] RTL__DOT__rg_cur_priv;
output            RTL__DOT__rg_retiring$EN;
output            RTL__DOT__rg_run_on_reset;
output      [3:0] RTL__DOT__rg_state;
output     [31:0] RTL__DOT__rg_trap_instr;
output            RTL__DOT__s1_to_s2$D_IN;
output            RTL__DOT__s1_to_s2$EN;
output            RTL__DOT__s2_to_s3$D_IN;
output            RTL__DOT__s2_to_s3$EN;
output            RTL__DOT__s3_deq$D_IN;
output            RTL__DOT__s3_deq$EN;
output            RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg;
output            RTL__DOT__stage1_f_reset_reqs__DOT__full_reg;
output            RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg;
output            RTL__DOT__stage1_f_reset_rsps__DOT__full_reg;
output            RTL__DOT__stage1_rg_full;
output            RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg;
output            RTL__DOT__stage2_f_reset_reqs__DOT__full_reg;
output            RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg;
output            RTL__DOT__stage2_f_reset_rsps__DOT__full_reg;
output            RTL__DOT__stage2_rg_full;
output    [168:0] RTL__DOT__stage2_rg_stage2;
output            RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg;
output            RTL__DOT__stage3_f_reset_reqs__DOT__full_reg;
output            RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg;
output            RTL__DOT__stage3_f_reset_rsps__DOT__full_reg;
output            RTL__DOT__stage3_rg_full;
output            __EDCOND__;
output            __IEND__;
output     [31:0] __ILA_SO_load_addr;
output     [31:0] __ILA_SO_load_data;
output            __ILA_SO_load_en;
output      [2:0] __ILA_SO_load_size;
output     [31:0] __ILA_SO_pc;
output     [31:0] __ILA_SO_store_addr;
output     [31:0] __ILA_SO_store_data;
output            __ILA_SO_store_en;
output      [2:0] __ILA_SO_store_size;
output     [31:0] __ILA_SO_x0;
output     [31:0] __ILA_SO_x1;
output     [31:0] __ILA_SO_x10;
output     [31:0] __ILA_SO_x11;
output     [31:0] __ILA_SO_x12;
output     [31:0] __ILA_SO_x13;
output     [31:0] __ILA_SO_x14;
output     [31:0] __ILA_SO_x15;
output     [31:0] __ILA_SO_x16;
output     [31:0] __ILA_SO_x17;
output     [31:0] __ILA_SO_x18;
output     [31:0] __ILA_SO_x19;
output     [31:0] __ILA_SO_x2;
output     [31:0] __ILA_SO_x20;
output     [31:0] __ILA_SO_x21;
output     [31:0] __ILA_SO_x22;
output     [31:0] __ILA_SO_x23;
output     [31:0] __ILA_SO_x24;
output     [31:0] __ILA_SO_x25;
output     [31:0] __ILA_SO_x26;
output     [31:0] __ILA_SO_x27;
output     [31:0] __ILA_SO_x28;
output     [31:0] __ILA_SO_x29;
output     [31:0] __ILA_SO_x3;
output     [31:0] __ILA_SO_x30;
output     [31:0] __ILA_SO_x31;
output     [31:0] __ILA_SO_x4;
output     [31:0] __ILA_SO_x5;
output     [31:0] __ILA_SO_x6;
output     [31:0] __ILA_SO_x7;
output     [31:0] __ILA_SO_x8;
output     [31:0] __ILA_SO_x9;
output            __VLG_II_m_external_interrupt_req_set_not_clear;
output            __VLG_II_nmi_req_set_not_clear;
output            __VLG_II_s_external_interrupt_req_set_not_clear;
output            __VLG_II_software_interrupt_req_set_not_clear;
output            __VLG_II_timer_interrupt_req_set_not_clear;
output            __VLG_O_RDY_hart0_server_reset_request_put;
output            __VLG_O_RDY_hart0_server_reset_response_get;
output            __VLG_O_RDY_set_verbosity;
output     [63:0] __VLG_O_dmem_master_araddr;
output      [1:0] __VLG_O_dmem_master_arburst;
output      [3:0] __VLG_O_dmem_master_arcache;
output      [3:0] __VLG_O_dmem_master_arid;
output      [7:0] __VLG_O_dmem_master_arlen;
output            __VLG_O_dmem_master_arlock;
output      [2:0] __VLG_O_dmem_master_arprot;
output      [3:0] __VLG_O_dmem_master_arqos;
output      [3:0] __VLG_O_dmem_master_arregion;
output      [2:0] __VLG_O_dmem_master_arsize;
output            __VLG_O_dmem_master_arvalid;
output     [63:0] __VLG_O_dmem_master_awaddr;
output      [1:0] __VLG_O_dmem_master_awburst;
output      [3:0] __VLG_O_dmem_master_awcache;
output      [3:0] __VLG_O_dmem_master_awid;
output      [7:0] __VLG_O_dmem_master_awlen;
output            __VLG_O_dmem_master_awlock;
output      [2:0] __VLG_O_dmem_master_awprot;
output      [3:0] __VLG_O_dmem_master_awqos;
output      [3:0] __VLG_O_dmem_master_awregion;
output      [2:0] __VLG_O_dmem_master_awsize;
output            __VLG_O_dmem_master_awvalid;
output            __VLG_O_dmem_master_bready;
output            __VLG_O_dmem_master_rready;
output     [63:0] __VLG_O_dmem_master_wdata;
output            __VLG_O_dmem_master_wlast;
output      [7:0] __VLG_O_dmem_master_wstrb;
output            __VLG_O_dmem_master_wvalid;
output            __VLG_O_hart0_server_reset_response_get;
output     [63:0] __VLG_O_imem_master_araddr;
output      [1:0] __VLG_O_imem_master_arburst;
output      [3:0] __VLG_O_imem_master_arcache;
output      [3:0] __VLG_O_imem_master_arid;
output      [7:0] __VLG_O_imem_master_arlen;
output            __VLG_O_imem_master_arlock;
output      [2:0] __VLG_O_imem_master_arprot;
output      [3:0] __VLG_O_imem_master_arqos;
output      [3:0] __VLG_O_imem_master_arregion;
output      [2:0] __VLG_O_imem_master_arsize;
output            __VLG_O_imem_master_arvalid;
output     [63:0] __VLG_O_imem_master_awaddr;
output      [1:0] __VLG_O_imem_master_awburst;
output      [3:0] __VLG_O_imem_master_awcache;
output      [3:0] __VLG_O_imem_master_awid;
output      [7:0] __VLG_O_imem_master_awlen;
output            __VLG_O_imem_master_awlock;
output      [2:0] __VLG_O_imem_master_awprot;
output      [3:0] __VLG_O_imem_master_awqos;
output      [3:0] __VLG_O_imem_master_awregion;
output      [2:0] __VLG_O_imem_master_awsize;
output            __VLG_O_imem_master_awvalid;
output            __VLG_O_imem_master_bready;
output            __VLG_O_imem_master_rready;
output     [63:0] __VLG_O_imem_master_wdata;
output            __VLG_O_imem_master_wlast;
output      [7:0] __VLG_O_imem_master_wstrb;
output            __VLG_O_imem_master_wvalid;
output            __all_assert_wire__;
output            __all_assume_wire__;
output            __auxvar0__delay_d_0;
output            __sanitycheck_wire__;
output            end_of_pipeline;
output            input_map_assume___p0__;
output            invariant_assume__p10__;
output            invariant_assume__p11__;
output            invariant_assume__p12__;
output            invariant_assume__p13__;
output            invariant_assume__p14__;
output            invariant_assume__p15__;
output            invariant_assume__p16__;
output            invariant_assume__p17__;
output            invariant_assume__p18__;
output            invariant_assume__p19__;
output            invariant_assume__p1__;
output            invariant_assume__p20__;
output            invariant_assume__p21__;
output            invariant_assume__p22__;
output            invariant_assume__p23__;
output            invariant_assume__p24__;
output            invariant_assume__p25__;
output            invariant_assume__p26__;
output            invariant_assume__p27__;
output            invariant_assume__p28__;
output            invariant_assume__p29__;
output            invariant_assume__p2__;
output            invariant_assume__p30__;
output            invariant_assume__p31__;
output            invariant_assume__p32__;
output            invariant_assume__p3__;
output            invariant_assume__p4__;
output            invariant_assume__p5__;
output            invariant_assume__p6__;
output            invariant_assume__p7__;
output            invariant_assume__p8__;
output            invariant_assume__p9__;
output            issue_decode__p33__;
output            issue_valid__p34__;
output     [31:0] mem_req_addr;
output            mem_req_en;
output      [2:0] mem_req_funct3;
output            mem_req_op;
output     [31:0] mem_req_rd_data;
output     [31:0] mem_req_wd_data;
output            monitor_s1;
output            monitor_s1_already_enter_cond;
output            monitor_s1_already_exit_cond;
output            monitor_s2_enter_cond;
output            monitor_s2_exit_cond;
output            monitor_s3_enter_cond;
output            monitor_s3_exit_cond;
output            monitor_s4_enter_cond;
output            monitor_s4_exit_cond;
output            noreset__p35__;
output            post_value_holder__p36__;
output            post_value_holder__p37__;
output            post_value_holder__p38__;
output            post_value_holder__p39__;
output            post_value_holder__p40__;
output            post_value_holder__p41__;
output            post_value_holder__p42__;
output            post_value_holder__p43__;
output            post_value_holder__p44__;
output            post_value_holder__p45__;
output            post_value_holder__p46__;
output            post_value_holder__p47__;
output            post_value_holder__p48__;
output            post_value_holder__p49__;
output            post_value_holder__p50__;
output            post_value_holder__p51__;
output            post_value_holder__p52__;
output            post_value_holder__p53__;
output            post_value_holder__p54__;
output            post_value_holder__p55__;
output            post_value_holder__p56__;
output            post_value_holder__p57__;
output            post_value_holder__p58__;
output            post_value_holder__p59__;
output            post_value_holder__p60__;
output            post_value_holder__p61__;
output            post_value_holder__p62__;
output            post_value_holder__p63__;
output            post_value_holder__p64__;
output            post_value_holder__p65__;
output            post_value_holder__p66__;
output            post_value_holder__p67__;
output            post_value_holder__p68__;
output            post_value_holder__p69__;
output            post_value_holder__p70__;
output            post_value_holder__p71__;
output            post_value_holder__p72__;
output            post_value_holder__p73__;
output            post_value_holder_overly_constrained__p153__;
output            post_value_holder_overly_constrained__p154__;
output            post_value_holder_overly_constrained__p155__;
output            post_value_holder_overly_constrained__p156__;
output            post_value_holder_overly_constrained__p157__;
output            post_value_holder_overly_constrained__p158__;
output            post_value_holder_overly_constrained__p159__;
output            post_value_holder_overly_constrained__p160__;
output            post_value_holder_overly_constrained__p161__;
output            post_value_holder_overly_constrained__p162__;
output            post_value_holder_overly_constrained__p163__;
output            post_value_holder_overly_constrained__p164__;
output            post_value_holder_overly_constrained__p165__;
output            post_value_holder_overly_constrained__p166__;
output            post_value_holder_overly_constrained__p167__;
output            post_value_holder_overly_constrained__p168__;
output            post_value_holder_overly_constrained__p169__;
output            post_value_holder_overly_constrained__p170__;
output            post_value_holder_overly_constrained__p171__;
output            post_value_holder_overly_constrained__p172__;
output            post_value_holder_overly_constrained__p173__;
output            post_value_holder_overly_constrained__p174__;
output            post_value_holder_overly_constrained__p175__;
output            post_value_holder_overly_constrained__p176__;
output            post_value_holder_overly_constrained__p177__;
output            post_value_holder_overly_constrained__p178__;
output            post_value_holder_overly_constrained__p179__;
output            post_value_holder_overly_constrained__p180__;
output            post_value_holder_overly_constrained__p181__;
output            post_value_holder_overly_constrained__p182__;
output            post_value_holder_overly_constrained__p183__;
output            post_value_holder_overly_constrained__p184__;
output            post_value_holder_overly_constrained__p185__;
output            post_value_holder_overly_constrained__p186__;
output            post_value_holder_overly_constrained__p187__;
output            post_value_holder_overly_constrained__p188__;
output            post_value_holder_overly_constrained__p189__;
output            post_value_holder_overly_constrained__p190__;
output            post_value_holder_triggered__p191__;
output            post_value_holder_triggered__p192__;
output            post_value_holder_triggered__p193__;
output            post_value_holder_triggered__p194__;
output            post_value_holder_triggered__p195__;
output            post_value_holder_triggered__p196__;
output            post_value_holder_triggered__p197__;
output            post_value_holder_triggered__p198__;
output            post_value_holder_triggered__p199__;
output            post_value_holder_triggered__p200__;
output            post_value_holder_triggered__p201__;
output            post_value_holder_triggered__p202__;
output            post_value_holder_triggered__p203__;
output            post_value_holder_triggered__p204__;
output            post_value_holder_triggered__p205__;
output            post_value_holder_triggered__p206__;
output            post_value_holder_triggered__p207__;
output            post_value_holder_triggered__p208__;
output            post_value_holder_triggered__p209__;
output            post_value_holder_triggered__p210__;
output            post_value_holder_triggered__p211__;
output            post_value_holder_triggered__p212__;
output            post_value_holder_triggered__p213__;
output            post_value_holder_triggered__p214__;
output            post_value_holder_triggered__p215__;
output            post_value_holder_triggered__p216__;
output            post_value_holder_triggered__p217__;
output            post_value_holder_triggered__p218__;
output            post_value_holder_triggered__p219__;
output            post_value_holder_triggered__p220__;
output            post_value_holder_triggered__p221__;
output            post_value_holder_triggered__p222__;
output            post_value_holder_triggered__p223__;
output            post_value_holder_triggered__p224__;
output            post_value_holder_triggered__p225__;
output            post_value_holder_triggered__p226__;
output            post_value_holder_triggered__p227__;
output            post_value_holder_triggered__p228__;
output            rfassumptions__p74__;
output            rfassumptions__p75__;
output            rfassumptions__p76__;
output            s2_enter;
output            s2_exit;
output            s3_enter;
output            s3_exit;
output            s4_enter;
output            variable_map_assert__p118__;
output            variable_map_assert__p119__;
output            variable_map_assert__p120__;
output            variable_map_assert__p121__;
output            variable_map_assert__p122__;
output            variable_map_assert__p123__;
output            variable_map_assert__p124__;
output            variable_map_assert__p125__;
output            variable_map_assert__p126__;
output            variable_map_assert__p127__;
output            variable_map_assert__p128__;
output            variable_map_assert__p129__;
output            variable_map_assert__p130__;
output            variable_map_assert__p131__;
output            variable_map_assert__p132__;
output            variable_map_assert__p133__;
output            variable_map_assert__p134__;
output            variable_map_assert__p135__;
output            variable_map_assert__p136__;
output            variable_map_assert__p137__;
output            variable_map_assert__p138__;
output            variable_map_assert__p139__;
output            variable_map_assert__p140__;
output            variable_map_assert__p141__;
output            variable_map_assert__p142__;
output            variable_map_assert__p143__;
output            variable_map_assert__p144__;
output            variable_map_assert__p145__;
output            variable_map_assert__p146__;
output            variable_map_assert__p147__;
output            variable_map_assert__p148__;
output            variable_map_assert__p149__;
output            variable_map_assert__p150__;
output            variable_map_assert__p151__;
output            variable_map_assert__p152__;
output            variable_map_assume___p100__;
output            variable_map_assume___p101__;
output            variable_map_assume___p102__;
output            variable_map_assume___p103__;
output            variable_map_assume___p104__;
output            variable_map_assume___p105__;
output            variable_map_assume___p106__;
output            variable_map_assume___p107__;
output            variable_map_assume___p108__;
output            variable_map_assume___p109__;
output            variable_map_assume___p110__;
output            variable_map_assume___p111__;
output            variable_map_assume___p112__;
output            variable_map_assume___p113__;
output            variable_map_assume___p114__;
output            variable_map_assume___p115__;
output            variable_map_assume___p116__;
output            variable_map_assume___p117__;
output            variable_map_assume___p77__;
output            variable_map_assume___p78__;
output            variable_map_assume___p79__;
output            variable_map_assume___p80__;
output            variable_map_assume___p81__;
output            variable_map_assume___p82__;
output            variable_map_assume___p83__;
output            variable_map_assume___p84__;
output            variable_map_assume___p85__;
output            variable_map_assume___p86__;
output            variable_map_assume___p87__;
output            variable_map_assume___p88__;
output            variable_map_assume___p89__;
output            variable_map_assume___p90__;
output            variable_map_assume___p91__;
output            variable_map_assume___p92__;
output            variable_map_assume___p93__;
output            variable_map_assume___p94__;
output            variable_map_assume___p95__;
output            variable_map_assume___p96__;
output            variable_map_assume___p97__;
output            variable_map_assume___p98__;
output            variable_map_assume___p99__;
output reg      [7:0] __CYCLE_CNT__;
output reg            __START__;
output reg            __STARTED__;
output reg            __ENDED__;
output reg            __2ndENDED__;
output reg            __RESETED__;
output reg     [31:0] __auxvar10__recorder;
output reg     [31:0] __auxvar10__recorder_sn_vhold;
output reg            __auxvar10__recorder_sn_condmet;
output reg     [31:0] __auxvar11__recorder;
output reg     [31:0] __auxvar11__recorder_sn_vhold;
output reg            __auxvar11__recorder_sn_condmet;
output reg     [31:0] __auxvar12__recorder;
output reg     [31:0] __auxvar12__recorder_sn_vhold;
output reg            __auxvar12__recorder_sn_condmet;
output reg     [31:0] __auxvar13__recorder;
output reg     [31:0] __auxvar13__recorder_sn_vhold;
output reg            __auxvar13__recorder_sn_condmet;
output reg     [31:0] __auxvar14__recorder;
output reg     [31:0] __auxvar14__recorder_sn_vhold;
output reg            __auxvar14__recorder_sn_condmet;
output reg     [31:0] __auxvar15__recorder;
output reg     [31:0] __auxvar15__recorder_sn_vhold;
output reg            __auxvar15__recorder_sn_condmet;
output reg     [31:0] __auxvar16__recorder;
output reg     [31:0] __auxvar16__recorder_sn_vhold;
output reg            __auxvar16__recorder_sn_condmet;
output reg     [31:0] __auxvar17__recorder;
output reg     [31:0] __auxvar17__recorder_sn_vhold;
output reg            __auxvar17__recorder_sn_condmet;
output reg     [31:0] __auxvar18__recorder;
output reg     [31:0] __auxvar18__recorder_sn_vhold;
output reg            __auxvar18__recorder_sn_condmet;
output reg     [31:0] __auxvar19__recorder;
output reg     [31:0] __auxvar19__recorder_sn_vhold;
output reg            __auxvar19__recorder_sn_condmet;
output reg     [31:0] __auxvar1__recorder;
output reg     [31:0] __auxvar1__recorder_sn_vhold;
output reg            __auxvar1__recorder_sn_condmet;
output reg     [31:0] __auxvar20__recorder;
output reg     [31:0] __auxvar20__recorder_sn_vhold;
output reg            __auxvar20__recorder_sn_condmet;
output reg     [31:0] __auxvar21__recorder;
output reg     [31:0] __auxvar21__recorder_sn_vhold;
output reg            __auxvar21__recorder_sn_condmet;
output reg     [31:0] __auxvar22__recorder;
output reg     [31:0] __auxvar22__recorder_sn_vhold;
output reg            __auxvar22__recorder_sn_condmet;
output reg     [31:0] __auxvar23__recorder;
output reg     [31:0] __auxvar23__recorder_sn_vhold;
output reg            __auxvar23__recorder_sn_condmet;
output reg     [31:0] __auxvar24__recorder;
output reg     [31:0] __auxvar24__recorder_sn_vhold;
output reg            __auxvar24__recorder_sn_condmet;
output reg     [31:0] __auxvar25__recorder;
output reg     [31:0] __auxvar25__recorder_sn_vhold;
output reg            __auxvar25__recorder_sn_condmet;
output reg     [31:0] __auxvar26__recorder;
output reg     [31:0] __auxvar26__recorder_sn_vhold;
output reg            __auxvar26__recorder_sn_condmet;
output reg     [31:0] __auxvar27__recorder;
output reg     [31:0] __auxvar27__recorder_sn_vhold;
output reg            __auxvar27__recorder_sn_condmet;
output reg     [31:0] __auxvar28__recorder;
output reg     [31:0] __auxvar28__recorder_sn_vhold;
output reg            __auxvar28__recorder_sn_condmet;
output reg     [31:0] __auxvar29__recorder;
output reg     [31:0] __auxvar29__recorder_sn_vhold;
output reg            __auxvar29__recorder_sn_condmet;
output reg     [31:0] __auxvar2__recorder;
output reg     [31:0] __auxvar2__recorder_sn_vhold;
output reg            __auxvar2__recorder_sn_condmet;
output reg     [31:0] __auxvar30__recorder;
output reg     [31:0] __auxvar30__recorder_sn_vhold;
output reg            __auxvar30__recorder_sn_condmet;
output reg     [31:0] __auxvar31__recorder;
output reg     [31:0] __auxvar31__recorder_sn_vhold;
output reg            __auxvar31__recorder_sn_condmet;
output reg     [31:0] __auxvar32__recorder;
output reg     [31:0] __auxvar32__recorder_sn_vhold;
output reg            __auxvar32__recorder_sn_condmet;
output reg     [31:0] __auxvar33__recorder;
output reg     [31:0] __auxvar33__recorder_sn_vhold;
output reg            __auxvar33__recorder_sn_condmet;
output reg            __auxvar34__recorder;
output reg            __auxvar34__recorder_sn_vhold;
output reg            __auxvar34__recorder_sn_condmet;
output reg      [2:0] __auxvar35__recorder;
output reg      [2:0] __auxvar35__recorder_sn_vhold;
output reg            __auxvar35__recorder_sn_condmet;
output reg            __auxvar36__recorder;
output reg            __auxvar36__recorder_sn_vhold;
output reg            __auxvar36__recorder_sn_condmet;
output reg     [31:0] __auxvar37__recorder;
output reg     [31:0] __auxvar37__recorder_sn_vhold;
output reg            __auxvar37__recorder_sn_condmet;
output reg     [31:0] __auxvar38__recorder;
output reg     [31:0] __auxvar38__recorder_sn_vhold;
output reg            __auxvar38__recorder_sn_condmet;
output reg     [31:0] __auxvar3__recorder;
output reg     [31:0] __auxvar3__recorder_sn_vhold;
output reg            __auxvar3__recorder_sn_condmet;
output reg     [31:0] __auxvar4__recorder;
output reg     [31:0] __auxvar4__recorder_sn_vhold;
output reg            __auxvar4__recorder_sn_condmet;
output reg     [31:0] __auxvar5__recorder;
output reg     [31:0] __auxvar5__recorder_sn_vhold;
output reg            __auxvar5__recorder_sn_condmet;
output reg     [31:0] __auxvar6__recorder;
output reg     [31:0] __auxvar6__recorder_sn_vhold;
output reg            __auxvar6__recorder_sn_condmet;
output reg     [31:0] __auxvar7__recorder;
output reg     [31:0] __auxvar7__recorder_sn_vhold;
output reg            __auxvar7__recorder_sn_condmet;
output reg     [31:0] __auxvar8__recorder;
output reg     [31:0] __auxvar8__recorder_sn_vhold;
output reg            __auxvar8__recorder_sn_condmet;
output reg     [31:0] __auxvar9__recorder;
output reg     [31:0] __auxvar9__recorder_sn_vhold;
output reg            __auxvar9__recorder_sn_condmet;
output reg            __auxvar0__delay_d_1;
output reg            monitor_s1_already;
output reg            monitor_s2;
output reg            monitor_s3;
output reg            monitor_s4;
 wire            RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg;
 wire            RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg;
 wire            RTL__DOT__csr_regfile__DOT__rg_nmi;
 wire            RTL__DOT__csr_regfile__DOT__rg_state;
 wire            RTL__DOT__f_reset_reqs__DOT__empty_reg;
 wire            RTL__DOT__f_reset_reqs__DOT__full_reg;
 wire            RTL__DOT__f_reset_rsps__DOT__empty_reg;
 wire            RTL__DOT__f_reset_rsps__DOT__full_reg;
 wire            RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg;
 wire            RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_;
 wire     [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_;
 wire            RTL__DOT__near_mem$EN_dmem_req;
 wire            RTL__DOT__near_mem$dmem_exc;
 wire     [31:0] RTL__DOT__near_mem$dmem_req_addr;
 wire      [2:0] RTL__DOT__near_mem$dmem_req_f3;
 wire            RTL__DOT__near_mem$dmem_req_op;
 wire     [63:0] RTL__DOT__near_mem$dmem_req_store_value;
 wire     [63:0] RTL__DOT__near_mem$dmem_word64;
 wire     [31:0] RTL__DOT__near_mem$imem_instr;
 wire     [31:0] RTL__DOT__near_mem$imem_pc;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg;
 wire     [31:0] RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr;
 wire     [31:0] RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa;
 wire            RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg;
 wire            RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg;
 wire      [1:0] RTL__DOT__rg_cur_priv;
 wire            RTL__DOT__rg_retiring$EN;
 wire            RTL__DOT__rg_run_on_reset;
 wire      [3:0] RTL__DOT__rg_state;
 wire     [31:0] RTL__DOT__rg_trap_instr;
 wire            RTL__DOT__s1_to_s2$D_IN;
 wire            RTL__DOT__s1_to_s2$EN;
 wire            RTL__DOT__s2_to_s3$D_IN;
 wire            RTL__DOT__s2_to_s3$EN;
 wire            RTL__DOT__s3_deq$D_IN;
 wire            RTL__DOT__s3_deq$EN;
 wire            RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg;
 wire            RTL__DOT__stage1_f_reset_reqs__DOT__full_reg;
 wire            RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg;
 wire            RTL__DOT__stage1_f_reset_rsps__DOT__full_reg;
 wire            RTL__DOT__stage1_rg_full;
 wire            RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg;
 wire            RTL__DOT__stage2_f_reset_reqs__DOT__full_reg;
 wire            RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg;
 wire            RTL__DOT__stage2_f_reset_rsps__DOT__full_reg;
 wire            RTL__DOT__stage2_rg_full;
 wire    [168:0] RTL__DOT__stage2_rg_stage2;
 wire            RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg;
 wire            RTL__DOT__stage3_f_reset_reqs__DOT__full_reg;
 wire            RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg;
 wire            RTL__DOT__stage3_f_reset_rsps__DOT__full_reg;
 wire            RTL__DOT__stage3_rg_full;
wire            __2ndIEND__;
 wire            __EDCOND__;
 wire            __IEND__;
 wire     [31:0] __ILA_I_inst;
 wire     [31:0] __ILA_SO_load_addr;
 wire     [31:0] __ILA_SO_load_data;
 wire            __ILA_SO_load_en;
 wire      [2:0] __ILA_SO_load_size;
 wire     [31:0] __ILA_SO_pc;
 wire     [31:0] __ILA_SO_store_addr;
 wire     [31:0] __ILA_SO_store_data;
 wire            __ILA_SO_store_en;
 wire      [2:0] __ILA_SO_store_size;
 wire     [31:0] __ILA_SO_x0;
 wire     [31:0] __ILA_SO_x1;
 wire     [31:0] __ILA_SO_x10;
 wire     [31:0] __ILA_SO_x11;
 wire     [31:0] __ILA_SO_x12;
 wire     [31:0] __ILA_SO_x13;
 wire     [31:0] __ILA_SO_x14;
 wire     [31:0] __ILA_SO_x15;
 wire     [31:0] __ILA_SO_x16;
 wire     [31:0] __ILA_SO_x17;
 wire     [31:0] __ILA_SO_x18;
 wire     [31:0] __ILA_SO_x19;
 wire     [31:0] __ILA_SO_x2;
 wire     [31:0] __ILA_SO_x20;
 wire     [31:0] __ILA_SO_x21;
 wire     [31:0] __ILA_SO_x22;
 wire     [31:0] __ILA_SO_x23;
 wire     [31:0] __ILA_SO_x24;
 wire     [31:0] __ILA_SO_x25;
 wire     [31:0] __ILA_SO_x26;
 wire     [31:0] __ILA_SO_x27;
 wire     [31:0] __ILA_SO_x28;
 wire     [31:0] __ILA_SO_x29;
 wire     [31:0] __ILA_SO_x3;
 wire     [31:0] __ILA_SO_x30;
 wire     [31:0] __ILA_SO_x31;
 wire     [31:0] __ILA_SO_x4;
 wire     [31:0] __ILA_SO_x5;
 wire     [31:0] __ILA_SO_x6;
 wire     [31:0] __ILA_SO_x7;
 wire     [31:0] __ILA_SO_x8;
 wire     [31:0] __ILA_SO_x9;
 wire            __ILA_riscv_decode_of_ADD__;
 wire            __ILA_riscv_valid__;
 wire            __ISSUE__;
 wire            __VLG_II_m_external_interrupt_req_set_not_clear;
 wire            __VLG_II_nmi_req_set_not_clear;
 wire            __VLG_II_s_external_interrupt_req_set_not_clear;
 wire            __VLG_II_software_interrupt_req_set_not_clear;
 wire            __VLG_II_timer_interrupt_req_set_not_clear;
 wire            __VLG_I_EN_hart0_server_reset_request_put;
 wire            __VLG_I_EN_hart0_server_reset_response_get;
 wire            __VLG_I_EN_set_verbosity;
 wire            __VLG_I_dmem_master_arready;
 wire            __VLG_I_dmem_master_awready;
 wire      [3:0] __VLG_I_dmem_master_bid;
 wire      [1:0] __VLG_I_dmem_master_bresp;
 wire            __VLG_I_dmem_master_bvalid;
 wire     [63:0] __VLG_I_dmem_master_rdata;
 wire      [3:0] __VLG_I_dmem_master_rid;
 wire            __VLG_I_dmem_master_rlast;
 wire      [1:0] __VLG_I_dmem_master_rresp;
 wire            __VLG_I_dmem_master_rvalid;
 wire            __VLG_I_dmem_master_wready;
 wire            __VLG_I_hart0_server_reset_request_put;
 wire            __VLG_I_imem_master_arready;
 wire            __VLG_I_imem_master_awready;
 wire      [3:0] __VLG_I_imem_master_bid;
 wire      [1:0] __VLG_I_imem_master_bresp;
 wire            __VLG_I_imem_master_bvalid;
 wire     [63:0] __VLG_I_imem_master_rdata;
 wire      [3:0] __VLG_I_imem_master_rid;
 wire            __VLG_I_imem_master_rlast;
 wire      [1:0] __VLG_I_imem_master_rresp;
 wire            __VLG_I_imem_master_rvalid;
 wire            __VLG_I_imem_master_wready;
 wire     [63:0] __VLG_I_set_verbosity_logdelay;
 wire      [3:0] __VLG_I_set_verbosity_verbosity;
 wire            __VLG_O_RDY_hart0_server_reset_request_put;
 wire            __VLG_O_RDY_hart0_server_reset_response_get;
 wire            __VLG_O_RDY_set_verbosity;
 wire     [63:0] __VLG_O_dmem_master_araddr;
 wire      [1:0] __VLG_O_dmem_master_arburst;
 wire      [3:0] __VLG_O_dmem_master_arcache;
 wire      [3:0] __VLG_O_dmem_master_arid;
 wire      [7:0] __VLG_O_dmem_master_arlen;
 wire            __VLG_O_dmem_master_arlock;
 wire      [2:0] __VLG_O_dmem_master_arprot;
 wire      [3:0] __VLG_O_dmem_master_arqos;
 wire      [3:0] __VLG_O_dmem_master_arregion;
 wire      [2:0] __VLG_O_dmem_master_arsize;
 wire            __VLG_O_dmem_master_arvalid;
 wire     [63:0] __VLG_O_dmem_master_awaddr;
 wire      [1:0] __VLG_O_dmem_master_awburst;
 wire      [3:0] __VLG_O_dmem_master_awcache;
 wire      [3:0] __VLG_O_dmem_master_awid;
 wire      [7:0] __VLG_O_dmem_master_awlen;
 wire            __VLG_O_dmem_master_awlock;
 wire      [2:0] __VLG_O_dmem_master_awprot;
 wire      [3:0] __VLG_O_dmem_master_awqos;
 wire      [3:0] __VLG_O_dmem_master_awregion;
 wire      [2:0] __VLG_O_dmem_master_awsize;
 wire            __VLG_O_dmem_master_awvalid;
 wire            __VLG_O_dmem_master_bready;
 wire            __VLG_O_dmem_master_rready;
 wire     [63:0] __VLG_O_dmem_master_wdata;
 wire            __VLG_O_dmem_master_wlast;
 wire      [7:0] __VLG_O_dmem_master_wstrb;
 wire            __VLG_O_dmem_master_wvalid;
 wire            __VLG_O_hart0_server_reset_response_get;
 wire     [63:0] __VLG_O_imem_master_araddr;
 wire      [1:0] __VLG_O_imem_master_arburst;
 wire      [3:0] __VLG_O_imem_master_arcache;
 wire      [3:0] __VLG_O_imem_master_arid;
 wire      [7:0] __VLG_O_imem_master_arlen;
 wire            __VLG_O_imem_master_arlock;
 wire      [2:0] __VLG_O_imem_master_arprot;
 wire      [3:0] __VLG_O_imem_master_arqos;
 wire      [3:0] __VLG_O_imem_master_arregion;
 wire      [2:0] __VLG_O_imem_master_arsize;
 wire            __VLG_O_imem_master_arvalid;
 wire     [63:0] __VLG_O_imem_master_awaddr;
 wire      [1:0] __VLG_O_imem_master_awburst;
 wire      [3:0] __VLG_O_imem_master_awcache;
 wire      [3:0] __VLG_O_imem_master_awid;
 wire      [7:0] __VLG_O_imem_master_awlen;
 wire            __VLG_O_imem_master_awlock;
 wire      [2:0] __VLG_O_imem_master_awprot;
 wire      [3:0] __VLG_O_imem_master_awqos;
 wire      [3:0] __VLG_O_imem_master_awregion;
 wire      [2:0] __VLG_O_imem_master_awsize;
 wire            __VLG_O_imem_master_awvalid;
 wire            __VLG_O_imem_master_bready;
 wire            __VLG_O_imem_master_rready;
 wire     [63:0] __VLG_O_imem_master_wdata;
 wire            __VLG_O_imem_master_wlast;
 wire      [7:0] __VLG_O_imem_master_wstrb;
 wire            __VLG_O_imem_master_wvalid;
wire     [31:0] ____auxvar10__recorder_init__;
wire     [31:0] ____auxvar11__recorder_init__;
wire     [31:0] ____auxvar12__recorder_init__;
wire     [31:0] ____auxvar13__recorder_init__;
wire     [31:0] ____auxvar14__recorder_init__;
wire     [31:0] ____auxvar15__recorder_init__;
wire     [31:0] ____auxvar16__recorder_init__;
wire     [31:0] ____auxvar17__recorder_init__;
wire     [31:0] ____auxvar18__recorder_init__;
wire     [31:0] ____auxvar19__recorder_init__;
wire     [31:0] ____auxvar1__recorder_init__;
wire     [31:0] ____auxvar20__recorder_init__;
wire     [31:0] ____auxvar21__recorder_init__;
wire     [31:0] ____auxvar22__recorder_init__;
wire     [31:0] ____auxvar23__recorder_init__;
wire     [31:0] ____auxvar24__recorder_init__;
wire     [31:0] ____auxvar25__recorder_init__;
wire     [31:0] ____auxvar26__recorder_init__;
wire     [31:0] ____auxvar27__recorder_init__;
wire     [31:0] ____auxvar28__recorder_init__;
wire     [31:0] ____auxvar29__recorder_init__;
wire     [31:0] ____auxvar2__recorder_init__;
wire     [31:0] ____auxvar30__recorder_init__;
wire     [31:0] ____auxvar31__recorder_init__;
wire     [31:0] ____auxvar32__recorder_init__;
wire     [31:0] ____auxvar33__recorder_init__;
wire            ____auxvar34__recorder_init__;
wire      [2:0] ____auxvar35__recorder_init__;
wire            ____auxvar36__recorder_init__;
wire     [31:0] ____auxvar37__recorder_init__;
wire     [31:0] ____auxvar38__recorder_init__;
wire     [31:0] ____auxvar3__recorder_init__;
wire     [31:0] ____auxvar4__recorder_init__;
wire     [31:0] ____auxvar5__recorder_init__;
wire     [31:0] ____auxvar6__recorder_init__;
wire     [31:0] ____auxvar7__recorder_init__;
wire     [31:0] ____auxvar8__recorder_init__;
wire     [31:0] ____auxvar9__recorder_init__;
 wire            __all_assert_wire__;
 wire            __all_assume_wire__;
wire            __auxvar0__delay;
 wire            __auxvar0__delay_d_0;
wire            __auxvar10__recorder_sn_cond;
wire     [31:0] __auxvar10__recorder_sn_value;
wire            __auxvar11__recorder_sn_cond;
wire     [31:0] __auxvar11__recorder_sn_value;
wire            __auxvar12__recorder_sn_cond;
wire     [31:0] __auxvar12__recorder_sn_value;
wire            __auxvar13__recorder_sn_cond;
wire     [31:0] __auxvar13__recorder_sn_value;
wire            __auxvar14__recorder_sn_cond;
wire     [31:0] __auxvar14__recorder_sn_value;
wire            __auxvar15__recorder_sn_cond;
wire     [31:0] __auxvar15__recorder_sn_value;
wire            __auxvar16__recorder_sn_cond;
wire     [31:0] __auxvar16__recorder_sn_value;
wire            __auxvar17__recorder_sn_cond;
wire     [31:0] __auxvar17__recorder_sn_value;
wire            __auxvar18__recorder_sn_cond;
wire     [31:0] __auxvar18__recorder_sn_value;
wire            __auxvar19__recorder_sn_cond;
wire     [31:0] __auxvar19__recorder_sn_value;
wire            __auxvar1__recorder_sn_cond;
wire     [31:0] __auxvar1__recorder_sn_value;
wire            __auxvar20__recorder_sn_cond;
wire     [31:0] __auxvar20__recorder_sn_value;
wire            __auxvar21__recorder_sn_cond;
wire     [31:0] __auxvar21__recorder_sn_value;
wire            __auxvar22__recorder_sn_cond;
wire     [31:0] __auxvar22__recorder_sn_value;
wire            __auxvar23__recorder_sn_cond;
wire     [31:0] __auxvar23__recorder_sn_value;
wire            __auxvar24__recorder_sn_cond;
wire     [31:0] __auxvar24__recorder_sn_value;
wire            __auxvar25__recorder_sn_cond;
wire     [31:0] __auxvar25__recorder_sn_value;
wire            __auxvar26__recorder_sn_cond;
wire     [31:0] __auxvar26__recorder_sn_value;
wire            __auxvar27__recorder_sn_cond;
wire     [31:0] __auxvar27__recorder_sn_value;
wire            __auxvar28__recorder_sn_cond;
wire     [31:0] __auxvar28__recorder_sn_value;
wire            __auxvar29__recorder_sn_cond;
wire     [31:0] __auxvar29__recorder_sn_value;
wire            __auxvar2__recorder_sn_cond;
wire     [31:0] __auxvar2__recorder_sn_value;
wire            __auxvar30__recorder_sn_cond;
wire     [31:0] __auxvar30__recorder_sn_value;
wire            __auxvar31__recorder_sn_cond;
wire     [31:0] __auxvar31__recorder_sn_value;
wire            __auxvar32__recorder_sn_cond;
wire     [31:0] __auxvar32__recorder_sn_value;
wire            __auxvar33__recorder_sn_cond;
wire     [31:0] __auxvar33__recorder_sn_value;
wire            __auxvar34__recorder_sn_cond;
wire            __auxvar34__recorder_sn_value;
wire            __auxvar35__recorder_sn_cond;
wire      [2:0] __auxvar35__recorder_sn_value;
wire            __auxvar36__recorder_sn_cond;
wire            __auxvar36__recorder_sn_value;
wire            __auxvar37__recorder_sn_cond;
wire     [31:0] __auxvar37__recorder_sn_value;
wire            __auxvar38__recorder_sn_cond;
wire     [31:0] __auxvar38__recorder_sn_value;
wire            __auxvar3__recorder_sn_cond;
wire     [31:0] __auxvar3__recorder_sn_value;
wire            __auxvar4__recorder_sn_cond;
wire     [31:0] __auxvar4__recorder_sn_value;
wire            __auxvar5__recorder_sn_cond;
wire     [31:0] __auxvar5__recorder_sn_value;
wire            __auxvar6__recorder_sn_cond;
wire     [31:0] __auxvar6__recorder_sn_value;
wire            __auxvar7__recorder_sn_cond;
wire     [31:0] __auxvar7__recorder_sn_value;
wire            __auxvar8__recorder_sn_cond;
wire     [31:0] __auxvar8__recorder_sn_value;
wire            __auxvar9__recorder_sn_cond;
wire     [31:0] __auxvar9__recorder_sn_value;
 wire            __sanitycheck_wire__;
wire            clk;
 wire            dummy_reset;
wire            end_of_pipeline;
wire            input_map_assume___p0__;
wire            invariant_assume__p10__;
wire            invariant_assume__p11__;
wire            invariant_assume__p12__;
wire            invariant_assume__p13__;
wire            invariant_assume__p14__;
wire            invariant_assume__p15__;
wire            invariant_assume__p16__;
wire            invariant_assume__p17__;
wire            invariant_assume__p18__;
wire            invariant_assume__p19__;
wire            invariant_assume__p1__;
wire            invariant_assume__p20__;
wire            invariant_assume__p21__;
wire            invariant_assume__p22__;
wire            invariant_assume__p23__;
wire            invariant_assume__p24__;
wire            invariant_assume__p25__;
wire            invariant_assume__p26__;
wire            invariant_assume__p27__;
wire            invariant_assume__p28__;
wire            invariant_assume__p29__;
wire            invariant_assume__p2__;
wire            invariant_assume__p30__;
wire            invariant_assume__p31__;
wire            invariant_assume__p32__;
wire            invariant_assume__p3__;
wire            invariant_assume__p4__;
wire            invariant_assume__p5__;
wire            invariant_assume__p6__;
wire            invariant_assume__p7__;
wire            invariant_assume__p8__;
wire            invariant_assume__p9__;
wire            issue_decode__p33__;
wire            issue_valid__p34__;
 wire     [31:0] mem_req_addr;
 wire            mem_req_en;
 wire      [2:0] mem_req_funct3;
 wire            mem_req_op;
 wire     [31:0] mem_req_rd_data;
 wire     [31:0] mem_req_wd_data;
wire            monitor_s1;
 wire            monitor_s1_already_enter_cond;
 wire            monitor_s1_already_exit_cond;
 wire            monitor_s2_enter_cond;
 wire            monitor_s2_exit_cond;
 wire            monitor_s3_enter_cond;
 wire            monitor_s3_exit_cond;
 wire            monitor_s4_enter_cond;
 wire            monitor_s4_exit_cond;
wire            noreset__p35__;
wire            post_value_holder__p36__;
wire            post_value_holder__p37__;
wire            post_value_holder__p38__;
wire            post_value_holder__p39__;
wire            post_value_holder__p40__;
wire            post_value_holder__p41__;
wire            post_value_holder__p42__;
wire            post_value_holder__p43__;
wire            post_value_holder__p44__;
wire            post_value_holder__p45__;
wire            post_value_holder__p46__;
wire            post_value_holder__p47__;
wire            post_value_holder__p48__;
wire            post_value_holder__p49__;
wire            post_value_holder__p50__;
wire            post_value_holder__p51__;
wire            post_value_holder__p52__;
wire            post_value_holder__p53__;
wire            post_value_holder__p54__;
wire            post_value_holder__p55__;
wire            post_value_holder__p56__;
wire            post_value_holder__p57__;
wire            post_value_holder__p58__;
wire            post_value_holder__p59__;
wire            post_value_holder__p60__;
wire            post_value_holder__p61__;
wire            post_value_holder__p62__;
wire            post_value_holder__p63__;
wire            post_value_holder__p64__;
wire            post_value_holder__p65__;
wire            post_value_holder__p66__;
wire            post_value_holder__p67__;
wire            post_value_holder__p68__;
wire            post_value_holder__p69__;
wire            post_value_holder__p70__;
wire            post_value_holder__p71__;
wire            post_value_holder__p72__;
wire            post_value_holder__p73__;
wire            post_value_holder_overly_constrained__p153__;
wire            post_value_holder_overly_constrained__p154__;
wire            post_value_holder_overly_constrained__p155__;
wire            post_value_holder_overly_constrained__p156__;
wire            post_value_holder_overly_constrained__p157__;
wire            post_value_holder_overly_constrained__p158__;
wire            post_value_holder_overly_constrained__p159__;
wire            post_value_holder_overly_constrained__p160__;
wire            post_value_holder_overly_constrained__p161__;
wire            post_value_holder_overly_constrained__p162__;
wire            post_value_holder_overly_constrained__p163__;
wire            post_value_holder_overly_constrained__p164__;
wire            post_value_holder_overly_constrained__p165__;
wire            post_value_holder_overly_constrained__p166__;
wire            post_value_holder_overly_constrained__p167__;
wire            post_value_holder_overly_constrained__p168__;
wire            post_value_holder_overly_constrained__p169__;
wire            post_value_holder_overly_constrained__p170__;
wire            post_value_holder_overly_constrained__p171__;
wire            post_value_holder_overly_constrained__p172__;
wire            post_value_holder_overly_constrained__p173__;
wire            post_value_holder_overly_constrained__p174__;
wire            post_value_holder_overly_constrained__p175__;
wire            post_value_holder_overly_constrained__p176__;
wire            post_value_holder_overly_constrained__p177__;
wire            post_value_holder_overly_constrained__p178__;
wire            post_value_holder_overly_constrained__p179__;
wire            post_value_holder_overly_constrained__p180__;
wire            post_value_holder_overly_constrained__p181__;
wire            post_value_holder_overly_constrained__p182__;
wire            post_value_holder_overly_constrained__p183__;
wire            post_value_holder_overly_constrained__p184__;
wire            post_value_holder_overly_constrained__p185__;
wire            post_value_holder_overly_constrained__p186__;
wire            post_value_holder_overly_constrained__p187__;
wire            post_value_holder_overly_constrained__p188__;
wire            post_value_holder_overly_constrained__p189__;
wire            post_value_holder_overly_constrained__p190__;
wire            post_value_holder_triggered__p191__;
wire            post_value_holder_triggered__p192__;
wire            post_value_holder_triggered__p193__;
wire            post_value_holder_triggered__p194__;
wire            post_value_holder_triggered__p195__;
wire            post_value_holder_triggered__p196__;
wire            post_value_holder_triggered__p197__;
wire            post_value_holder_triggered__p198__;
wire            post_value_holder_triggered__p199__;
wire            post_value_holder_triggered__p200__;
wire            post_value_holder_triggered__p201__;
wire            post_value_holder_triggered__p202__;
wire            post_value_holder_triggered__p203__;
wire            post_value_holder_triggered__p204__;
wire            post_value_holder_triggered__p205__;
wire            post_value_holder_triggered__p206__;
wire            post_value_holder_triggered__p207__;
wire            post_value_holder_triggered__p208__;
wire            post_value_holder_triggered__p209__;
wire            post_value_holder_triggered__p210__;
wire            post_value_holder_triggered__p211__;
wire            post_value_holder_triggered__p212__;
wire            post_value_holder_triggered__p213__;
wire            post_value_holder_triggered__p214__;
wire            post_value_holder_triggered__p215__;
wire            post_value_holder_triggered__p216__;
wire            post_value_holder_triggered__p217__;
wire            post_value_holder_triggered__p218__;
wire            post_value_holder_triggered__p219__;
wire            post_value_holder_triggered__p220__;
wire            post_value_holder_triggered__p221__;
wire            post_value_holder_triggered__p222__;
wire            post_value_holder_triggered__p223__;
wire            post_value_holder_triggered__p224__;
wire            post_value_holder_triggered__p225__;
wire            post_value_holder_triggered__p226__;
wire            post_value_holder_triggered__p227__;
wire            post_value_holder_triggered__p228__;
wire            rfassumptions__p74__;
wire            rfassumptions__p75__;
wire            rfassumptions__p76__;
wire            rst;
wire            s2_enter;
wire            s2_exit;
wire            s3_enter;
wire            s3_exit;
wire            s4_enter;
wire            variable_map_assert__p118__;
wire            variable_map_assert__p119__;
wire            variable_map_assert__p120__;
wire            variable_map_assert__p121__;
wire            variable_map_assert__p122__;
wire            variable_map_assert__p123__;
wire            variable_map_assert__p124__;
wire            variable_map_assert__p125__;
wire            variable_map_assert__p126__;
wire            variable_map_assert__p127__;
wire            variable_map_assert__p128__;
wire            variable_map_assert__p129__;
wire            variable_map_assert__p130__;
wire            variable_map_assert__p131__;
wire            variable_map_assert__p132__;
wire            variable_map_assert__p133__;
wire            variable_map_assert__p134__;
wire            variable_map_assert__p135__;
wire            variable_map_assert__p136__;
wire            variable_map_assert__p137__;
wire            variable_map_assert__p138__;
wire            variable_map_assert__p139__;
wire            variable_map_assert__p140__;
wire            variable_map_assert__p141__;
wire            variable_map_assert__p142__;
wire            variable_map_assert__p143__;
wire            variable_map_assert__p144__;
wire            variable_map_assert__p145__;
wire            variable_map_assert__p146__;
wire            variable_map_assert__p147__;
wire            variable_map_assert__p148__;
wire            variable_map_assert__p149__;
wire            variable_map_assert__p150__;
wire            variable_map_assert__p151__;
wire            variable_map_assert__p152__;
wire            variable_map_assume___p100__;
wire            variable_map_assume___p101__;
wire            variable_map_assume___p102__;
wire            variable_map_assume___p103__;
wire            variable_map_assume___p104__;
wire            variable_map_assume___p105__;
wire            variable_map_assume___p106__;
wire            variable_map_assume___p107__;
wire            variable_map_assume___p108__;
wire            variable_map_assume___p109__;
wire            variable_map_assume___p110__;
wire            variable_map_assume___p111__;
wire            variable_map_assume___p112__;
wire            variable_map_assume___p113__;
wire            variable_map_assume___p114__;
wire            variable_map_assume___p115__;
wire            variable_map_assume___p116__;
wire            variable_map_assume___p117__;
wire            variable_map_assume___p77__;
wire            variable_map_assume___p78__;
wire            variable_map_assume___p79__;
wire            variable_map_assume___p80__;
wire            variable_map_assume___p81__;
wire            variable_map_assume___p82__;
wire            variable_map_assume___p83__;
wire            variable_map_assume___p84__;
wire            variable_map_assume___p85__;
wire            variable_map_assume___p86__;
wire            variable_map_assume___p87__;
wire            variable_map_assume___p88__;
wire            variable_map_assume___p89__;
wire            variable_map_assume___p90__;
wire            variable_map_assume___p91__;
wire            variable_map_assume___p92__;
wire            variable_map_assume___p93__;
wire            variable_map_assume___p94__;
wire            variable_map_assume___p95__;
wire            variable_map_assume___p96__;
wire            variable_map_assume___p97__;
wire            variable_map_assume___p98__;
wire            variable_map_assume___p99__;
always @(posedge clk) begin
if (rst) __CYCLE_CNT__ <= 0;
else if ( ( __START__ || __STARTED__ ) &&  __CYCLE_CNT__ < 137) __CYCLE_CNT__ <= __CYCLE_CNT__ + 1;
end
always @(posedge clk) begin
if (__ISSUE__ && !__START__ && !__STARTED__) __START__ <= 1;
else if (__START__ || __STARTED__) __START__ <= 0;
end
always @(posedge clk) begin
if (rst) __STARTED__ <= 0;
else if (__START__) __STARTED__ <= 1;
end
always @(posedge clk) begin
if (rst) __ENDED__ <= 0;
else if (__IEND__) __ENDED__ <= 1;
end
always @(posedge clk) begin
if (rst) __2ndENDED__ <= 1'b0;
else if (__ENDED__ && __EDCOND__ && ~__2ndENDED__)  __2ndENDED__ <= 1'b1; end
assign __2ndIEND__ = __ENDED__ && __EDCOND__ && ~__2ndENDED__ ;
always @(posedge clk) begin
if (rst) __RESETED__ <= 1;
end
assign __auxvar0__delay = __auxvar0__delay_d_1 ;
assign monitor_s1_already_exit_cond = 1'b0 ;
assign monitor_s4_exit_cond = 1'b0 ;
riscv__DOT__ADD ILA (
   .__START__(__START__),
   .clk(clk),
   .inst(__ILA_I_inst),
   .rst(rst),
   .__ILA_riscv_decode_of_ADD__(__ILA_riscv_decode_of_ADD__),
   .__ILA_riscv_valid__(__ILA_riscv_valid__),
   .pc(__ILA_SO_pc),
   .load_en(__ILA_SO_load_en),
   .load_addr(__ILA_SO_load_addr),
   .load_size(__ILA_SO_load_size),
   .load_data(__ILA_SO_load_data),
   .store_en(__ILA_SO_store_en),
   .store_addr(__ILA_SO_store_addr),
   .store_size(__ILA_SO_store_size),
   .store_data(__ILA_SO_store_data),
   .x0(__ILA_SO_x0),
   .x1(__ILA_SO_x1),
   .x2(__ILA_SO_x2),
   .x3(__ILA_SO_x3),
   .x4(__ILA_SO_x4),
   .x5(__ILA_SO_x5),
   .x6(__ILA_SO_x6),
   .x7(__ILA_SO_x7),
   .x8(__ILA_SO_x8),
   .x9(__ILA_SO_x9),
   .x10(__ILA_SO_x10),
   .x11(__ILA_SO_x11),
   .x12(__ILA_SO_x12),
   .x13(__ILA_SO_x13),
   .x14(__ILA_SO_x14),
   .x15(__ILA_SO_x15),
   .x16(__ILA_SO_x16),
   .x17(__ILA_SO_x17),
   .x18(__ILA_SO_x18),
   .x19(__ILA_SO_x19),
   .x20(__ILA_SO_x20),
   .x21(__ILA_SO_x21),
   .x22(__ILA_SO_x22),
   .x23(__ILA_SO_x23),
   .x24(__ILA_SO_x24),
   .x25(__ILA_SO_x25),
   .x26(__ILA_SO_x26),
   .x27(__ILA_SO_x27),
   .x28(__ILA_SO_x28),
   .x29(__ILA_SO_x29),
   .x30(__ILA_SO_x30),
   .x31(__ILA_SO_x31),
   .__COUNTER_start__n11()
);
assign __EDCOND__ = (end_of_pipeline)&&(__STARTED__) ;
assign __IEND__ = ((((end_of_pipeline)&&(__STARTED__))&&(__RESETED__))&&(!(__ENDED__)))&&(1'b1) ;
assign __VLG_II_m_external_interrupt_req_set_not_clear = 1'b0 ;
assign __VLG_II_nmi_req_set_not_clear = 1'b0 ;
assign __VLG_II_s_external_interrupt_req_set_not_clear = 1'b0 ;
assign __VLG_II_software_interrupt_req_set_not_clear = 1'b0 ;
assign __VLG_II_timer_interrupt_req_set_not_clear = 1'b0 ;
assign __auxvar10__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar10__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_ ;
assign __auxvar11__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar11__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_ ;
assign __auxvar12__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar12__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_ ;
assign __auxvar13__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar13__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_ ;
assign __auxvar14__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar14__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_ ;
assign __auxvar15__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar15__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_ ;
assign __auxvar16__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar16__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_ ;
assign __auxvar17__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar17__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_ ;
assign __auxvar18__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar18__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_ ;
assign __auxvar19__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar19__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_ ;
assign __auxvar1__recorder_sn_cond = ((monitor_s2)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar1__recorder_sn_value = RTL__DOT__near_mem$imem_pc ;
assign __auxvar20__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar20__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_ ;
assign __auxvar21__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar21__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_ ;
assign __auxvar22__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar22__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_ ;
assign __auxvar23__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar23__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_ ;
assign __auxvar24__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar24__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_ ;
assign __auxvar25__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar25__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_ ;
assign __auxvar26__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar26__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_ ;
assign __auxvar27__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar27__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_ ;
assign __auxvar28__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar28__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_ ;
assign __auxvar29__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar29__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_ ;
assign __auxvar2__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar2__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_ ;
assign __auxvar30__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar30__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_ ;
assign __auxvar31__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar31__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_ ;
assign __auxvar32__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar32__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_ ;
assign __auxvar33__recorder_sn_cond = ((monitor_s1)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar33__recorder_sn_value = RTL__DOT__near_mem$dmem_req_addr ;
assign __auxvar34__recorder_sn_cond = ((monitor_s1)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar34__recorder_sn_value = RTL__DOT__near_mem$EN_dmem_req ;
assign __auxvar35__recorder_sn_cond = ((monitor_s1)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar35__recorder_sn_value = RTL__DOT__near_mem$dmem_req_f3 ;
assign __auxvar36__recorder_sn_cond = ((monitor_s1)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar36__recorder_sn_value = RTL__DOT__near_mem$dmem_req_op ;
assign __auxvar37__recorder_sn_cond = ((monitor_s2)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar37__recorder_sn_value = RTL__DOT__near_mem$dmem_word64[31:0] ;
assign __auxvar38__recorder_sn_cond = ((monitor_s1)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar38__recorder_sn_value = RTL__DOT__near_mem$dmem_req_store_value[31:0] ;
assign __auxvar3__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar3__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_ ;
assign __auxvar4__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar4__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_ ;
assign __auxvar5__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar5__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_ ;
assign __auxvar6__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar6__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_ ;
assign __auxvar7__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar7__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_ ;
assign __auxvar8__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar8__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_ ;
assign __auxvar9__recorder_sn_cond = ((monitor_s3)&&((__START__)||(__STARTED__)))&&(!(__ENDED__)) ;
assign __auxvar9__recorder_sn_value = RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_ ;
assign __auxvar0__delay_d_0 = monitor_s4 ;
assign end_of_pipeline = (monitor_s4)&&(~(__auxvar0__delay)) ;
assign monitor_s1 = ((RTL__DOT__stage1_rg_full)&(~(monitor_s1_already)))&(__START__) ;
assign s2_enter = ((RTL__DOT__s1_to_s2$D_IN)&(RTL__DOT__s1_to_s2$EN))&(monitor_s1) ;
assign s2_exit = (RTL__DOT__s2_to_s3$D_IN)&(RTL__DOT__s2_to_s3$EN) ;
assign s3_enter = ((RTL__DOT__s2_to_s3$D_IN)&(RTL__DOT__s2_to_s3$EN))&(monitor_s2) ;
assign s3_exit = (RTL__DOT__s3_deq$EN)&(RTL__DOT__s3_deq$D_IN) ;
assign s4_enter = (monitor_s3)&&(RTL__DOT__rg_retiring$EN) ;
assign monitor_s1_already_enter_cond = (monitor_s1)&&(s2_enter) ;
assign monitor_s2_enter_cond = s2_enter ;
assign monitor_s2_exit_cond = s2_exit ;
assign monitor_s3_enter_cond = s3_enter ;
assign monitor_s3_exit_cond = s3_exit ;
assign monitor_s4_enter_cond = s4_enter ;
assign mem_req_addr = __auxvar33__recorder ;
assign mem_req_en = __auxvar34__recorder ;
assign mem_req_funct3 = __auxvar35__recorder ;
assign mem_req_op = __auxvar36__recorder ;
assign mem_req_rd_data = __auxvar37__recorder ;
assign mem_req_wd_data = __auxvar38__recorder ;
assign input_map_assume___p0__ = (!(__START__))||((__ILA_I_inst)==(RTL__DOT__near_mem$imem_instr)) ;
assign invariant_assume__p1__ = !(((RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg)==(0))&&((RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg)==(0))) ;
assign invariant_assume__p2__ = !(((RTL__DOT__f_reset_reqs__DOT__empty_reg)==(0))&&((RTL__DOT__f_reset_reqs__DOT__full_reg)==(0))) ;
assign invariant_assume__p3__ = !(((RTL__DOT__f_reset_rsps__DOT__empty_reg)==(0))&&((RTL__DOT__f_reset_rsps__DOT__full_reg)==(0))) ;
assign invariant_assume__p4__ = !(((RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg)==(0))&&((RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg)==(0))) ;
assign invariant_assume__p5__ = !(((RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg)==(0))) ;
assign invariant_assume__p6__ = !(((RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg)==(0))) ;
assign invariant_assume__p7__ = !(((RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg)==(0))) ;
assign invariant_assume__p8__ = !(((RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg)==(0))) ;
assign invariant_assume__p9__ = !(((RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg)==(0))) ;
assign invariant_assume__p10__ = !(((RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg)==(0))) ;
assign invariant_assume__p11__ = !(((RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg)==(0))) ;
assign invariant_assume__p12__ = !(((RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg)==(0))) ;
assign invariant_assume__p13__ = !(((RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg)==(0))) ;
assign invariant_assume__p14__ = !(((RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg)==(0))) ;
assign invariant_assume__p15__ = !(((RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg)==(0))) ;
assign invariant_assume__p16__ = !(((RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg)==(0))) ;
assign invariant_assume__p17__ = !(((RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg)==(0))&&((RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg)==(0))) ;
assign invariant_assume__p18__ = !(((RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg)==(0))) ;
assign invariant_assume__p19__ = !(((RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg)==(0))) ;
assign invariant_assume__p20__ = !(((RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg)==(0))) ;
assign invariant_assume__p21__ = !(((RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg)==(0))&&((RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg)==(0))) ;
assign invariant_assume__p22__ = !(((RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg)==(0))&&((RTL__DOT__stage1_f_reset_reqs__DOT__full_reg)==(0))) ;
assign invariant_assume__p23__ = !(((RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg)==(0))&&((RTL__DOT__stage1_f_reset_rsps__DOT__full_reg)==(0))) ;
assign invariant_assume__p24__ = !(((RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg)==(0))&&((RTL__DOT__stage2_f_reset_reqs__DOT__full_reg)==(0))) ;
assign invariant_assume__p25__ = !(((RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg)==(0))&&((RTL__DOT__stage2_f_reset_rsps__DOT__full_reg)==(0))) ;
assign invariant_assume__p26__ = !(((RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg)==(0))&&((RTL__DOT__stage3_f_reset_reqs__DOT__full_reg)==(0))) ;
assign invariant_assume__p27__ = !(((RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg)==(0))&&((RTL__DOT__stage3_f_reset_rsps__DOT__full_reg)==(0))) ;
assign invariant_assume__p28__ = ((((!((RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg)==(1'b1)))||(!((RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg)==(1'b0))))||(!((RTL__DOT__stage3_rg_full)==(1'b1))))&&((((!((RTL__DOT__stage2_rg_full)==(1'b1)))||(!((RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg)==(1'b1))))||(!((RTL__DOT__f_reset_reqs__DOT__empty_reg)==(1'b0))))||(!((RTL__DOT__f_reset_reqs__DOT__full_reg)==(1'b0)))))&&(((!((RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg)==(1'b1)))||(!((RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg)==(1'b0))))||(!((RTL__DOT__stage2_rg_full)==(1'b1)))) ;
assign invariant_assume__p29__ = ((!((RTL__DOT__csr_regfile__DOT__rg_state)==(1'b1)))||(!((RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg)==(1'b1))))&&((RTL__DOT__stage2_f_reset_reqs__DOT__full_reg)==(1'b1)) ;
assign invariant_assume__p30__ = (((!((RTL__DOT__stage3_f_reset_rsps__DOT__full_reg)==(1'b1)))||(!((RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg)==(1'b0))))||(!((RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg)==(1'b0))))&&((((!((RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg)==(1'b1)))||(!((RTL__DOT__stage3_f_reset_rsps__DOT__full_reg)==(1'b1))))||(!((RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg)==(1'b0))))||(!((RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg)==(1'b0)))) ;
assign invariant_assume__p31__ = (((((((((((!((RTL__DOT__stage2_rg_full)==(1'b1)))||(!((RTL__DOT__csr_regfile__DOT__rg_state)==(1'b1))))||(!((RTL__DOT__rg_run_on_reset)==(1'b1))))||(!((RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg)==(1'b1))))||(!((RTL__DOT__stage3_f_reset_rsps__DOT__full_reg)==(1'b1))))||(!(RTL__DOT__stage2_rg_stage2[101:101])))||((RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr[4:4])==(1'b1)))||(!((RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa[4:4])==(1'b1))))&&(!((RTL__DOT__csr_regfile__DOT__rg_nmi)==(1'b1))))&&(((!((RTL__DOT__rg_state[0:0])==(1'b1)))||(!((RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg)==(1'b0))))||(!((RTL__DOT__csr_regfile__DOT__rg_state)==(1'b0)))))&&(((((((RTL__DOT__stage3_f_reset_reqs__DOT__full_reg)==(1'b1))||(!(RTL__DOT__rg_trap_instr[22:22])))||(!(RTL__DOT__rg_trap_instr[20:20])))||(!(RTL__DOT__rg_trap_instr[26:26])))||(!((RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg)==(1'b0))))||(!((RTL__DOT__csr_regfile__DOT__rg_state)==(1'b0)))))&&(((((!((RTL__DOT__stage2_rg_full)==(1'b1)))||(!((RTL__DOT__rg_run_on_reset)==(1'b1))))||(!((RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg)==(1'b1))))||(!((RTL__DOT__stage3_f_reset_rsps__DOT__full_reg)==(1'b1))))||(!((RTL__DOT__stage3_f_reset_reqs__DOT__full_reg)==(1'b0)))) ;
assign invariant_assume__p32__ = (((((!((RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg)==(1'b0)))||(!((RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg)==(1'b1))))||(!((RTL__DOT__stage3_f_reset_rsps__DOT__full_reg)==(1'b1))))||(!((RTL__DOT__stage3_f_reset_reqs__DOT__full_reg)==(1'b0))))&&(((((!((RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg)==(1'b0)))||(!((RTL__DOT__rg_state[0:0])==(1'b1))))||(!((RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg)==(1'b1))))||(!((RTL__DOT__stage3_f_reset_rsps__DOT__full_reg)==(1'b1))))||(RTL__DOT__rg_run_on_reset)))&&(((((((!((RTL__DOT__stage2_rg_full)==(1'b1)))||(!((RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg)==(1'b0))))||(!((RTL__DOT__rg_state[0:0])==(1'b1))))||(!((RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg)==(1'b1))))||(!((RTL__DOT__stage3_f_reset_rsps__DOT__full_reg)==(1'b1))))||(RTL__DOT__stage2_rg_stage2[168:168]))||(!(RTL__DOT__rg_cur_priv[1:1]))) ;
assign issue_decode__p33__ = (!(__START__))||(__ILA_riscv_decode_of_ADD__) ;
assign issue_valid__p34__ = (!(__START__))||(__ILA_riscv_valid__) ;
assign noreset__p35__ = (!(__RESETED__))||(!(dummy_reset)) ;
assign post_value_holder__p36__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar10__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar10__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_)) ;
assign post_value_holder__p37__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar11__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar11__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_)) ;
assign post_value_holder__p38__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar12__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar12__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_)) ;
assign post_value_holder__p39__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar13__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar13__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_)) ;
assign post_value_holder__p40__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar14__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar14__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_)) ;
assign post_value_holder__p41__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar15__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar15__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_)) ;
assign post_value_holder__p42__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar16__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar16__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_)) ;
assign post_value_holder__p43__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar17__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar17__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_)) ;
assign post_value_holder__p44__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar18__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar18__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_)) ;
assign post_value_holder__p45__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar19__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar19__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_)) ;
assign post_value_holder__p46__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar1__recorder_sn_condmet)))&&(monitor_s2)))||((__auxvar1__recorder)==(RTL__DOT__near_mem$imem_pc)) ;
assign post_value_holder__p47__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar20__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar20__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_)) ;
assign post_value_holder__p48__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar21__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar21__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_)) ;
assign post_value_holder__p49__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar22__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar22__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_)) ;
assign post_value_holder__p50__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar23__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar23__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_)) ;
assign post_value_holder__p51__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar24__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar24__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_)) ;
assign post_value_holder__p52__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar25__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar25__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_)) ;
assign post_value_holder__p53__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar26__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar26__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_)) ;
assign post_value_holder__p54__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar27__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar27__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_)) ;
assign post_value_holder__p55__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar28__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar28__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_)) ;
assign post_value_holder__p56__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar29__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar29__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_)) ;
assign post_value_holder__p57__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar2__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar2__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_)) ;
assign post_value_holder__p58__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar30__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar30__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_)) ;
assign post_value_holder__p59__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar31__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar31__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_)) ;
assign post_value_holder__p60__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar32__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar32__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_)) ;
assign post_value_holder__p61__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar33__recorder_sn_condmet)))&&(monitor_s1)))||((__auxvar33__recorder)==(RTL__DOT__near_mem$dmem_req_addr)) ;
assign post_value_holder__p62__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar34__recorder_sn_condmet)))&&(monitor_s1)))||((__auxvar34__recorder)==(RTL__DOT__near_mem$EN_dmem_req)) ;
assign post_value_holder__p63__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar35__recorder_sn_condmet)))&&(monitor_s1)))||((__auxvar35__recorder)==(RTL__DOT__near_mem$dmem_req_f3)) ;
assign post_value_holder__p64__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar36__recorder_sn_condmet)))&&(monitor_s1)))||((__auxvar36__recorder)==(RTL__DOT__near_mem$dmem_req_op)) ;
assign post_value_holder__p65__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar37__recorder_sn_condmet)))&&(monitor_s2)))||((__auxvar37__recorder)==(RTL__DOT__near_mem$dmem_word64[31:0])) ;
assign post_value_holder__p66__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar38__recorder_sn_condmet)))&&(monitor_s1)))||((__auxvar38__recorder)==(RTL__DOT__near_mem$dmem_req_store_value[31:0])) ;
assign post_value_holder__p67__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar3__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar3__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_)) ;
assign post_value_holder__p68__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar4__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar4__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_)) ;
assign post_value_holder__p69__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar5__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar5__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_)) ;
assign post_value_holder__p70__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar6__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar6__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_)) ;
assign post_value_holder__p71__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar7__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar7__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_)) ;
assign post_value_holder__p72__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar8__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar8__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_)) ;
assign post_value_holder__p73__ = (!((((__START__)||(__STARTED__))&&(!(__auxvar9__recorder_sn_condmet)))&&(monitor_s3)))||((__auxvar9__recorder)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_)) ;
assign rfassumptions__p74__ = (__ILA_SO_pc[1:0])==(2'b00) ;
assign rfassumptions__p75__ = (RTL__DOT__near_mem$imem_pc[1:0])==(2'b00) ;
assign rfassumptions__p76__ = (!(monitor_s2))||((RTL__DOT__near_mem$dmem_exc)==(0)) ;
assign variable_map_assume___p77__ = (!(__START__))||((!((__IEND__)&&(__ILA_SO_load_en)))||((__ILA_SO_load_addr)==(mem_req_addr))) ;
assign variable_map_assume___p78__ = (!(__START__))||((!((__START__)&&(((mem_req_en)==(1'b1))&&((mem_req_op)==(1'b0)))))||((__ILA_SO_load_data)==(mem_req_rd_data))) ;
assign variable_map_assume___p79__ = (!(__START__))||((!(__IEND__))||((__ILA_SO_load_en)==(((mem_req_en)==(1'b1))&&((mem_req_op)==(1'b0))))) ;
assign variable_map_assume___p80__ = (!(__START__))||(((((!(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(1))))||(((mem_req_funct3)==(0))||((mem_req_funct3)==(4))))&&((!((!(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(1))))&&(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(2)))))||(((mem_req_funct3)==(1))||((mem_req_funct3)==(5)))))&&((!(((!(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(1))))&&(!((!(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(1))))&&(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(2))))))&&(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(4)))))||(((mem_req_funct3)==(2))||((mem_req_funct3)==(6)))))&&((!((((!(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(1))))&&(!((!(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(1))))&&(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(2))))))&&(!(((!(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(1))))&&(!((!(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(1))))&&(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(2))))))&&(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(4))))))&&(((__IEND__)&&(__ILA_SO_load_en))&&((__ILA_SO_load_size)==(8)))))||((mem_req_funct3)==(3)))) ;
assign variable_map_assume___p81__ = (!(__START__))||(((!(__START__))||((__ILA_SO_pc)==(RTL__DOT__near_mem$imem_pc)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_pc)==(__auxvar1__recorder)))) ;
assign variable_map_assume___p82__ = (!(__START__))||((!((__IEND__)&&(__ILA_SO_store_en)))||((__ILA_SO_store_addr)==(mem_req_addr))) ;
assign variable_map_assume___p83__ = (!(__START__))||((!((__IEND__)&&(__ILA_SO_store_en)))||((__ILA_SO_store_data)==(mem_req_wd_data))) ;
assign variable_map_assume___p84__ = (!(__START__))||((!(__IEND__))||((__ILA_SO_store_en)==(((mem_req_en)==(1'b1))&&((mem_req_op)==(1'b1))))) ;
assign variable_map_assume___p85__ = (!(__START__))||(((((!(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(1))))||(((mem_req_funct3)==(0))||((mem_req_funct3)==(4))))&&((!((!(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(1))))&&(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(2)))))||(((mem_req_funct3)==(1))||((mem_req_funct3)==(5)))))&&((!(((!(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(1))))&&(!((!(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(1))))&&(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(2))))))&&(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(4)))))||(((mem_req_funct3)==(2))||((mem_req_funct3)==(6)))))&&((!((((!(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(1))))&&(!((!(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(1))))&&(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(2))))))&&(!(((!(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(1))))&&(!((!(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(1))))&&(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(2))))))&&(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(4))))))&&(((__IEND__)&&(__ILA_SO_store_en))&&((__ILA_SO_store_size)==(8)))))||((mem_req_funct3)==(3)))) ;
assign variable_map_assume___p86__ = (!(__START__))||((__ILA_SO_x0)==(0)) ;
assign variable_map_assume___p87__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x1)==(__auxvar2__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x1)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_)))) ;
assign variable_map_assume___p88__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x10)==(__auxvar3__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x10)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_)))) ;
assign variable_map_assume___p89__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x11)==(__auxvar4__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x11)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_)))) ;
assign variable_map_assume___p90__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x12)==(__auxvar5__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x12)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_)))) ;
assign variable_map_assume___p91__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x13)==(__auxvar6__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x13)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_)))) ;
assign variable_map_assume___p92__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x14)==(__auxvar7__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x14)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_)))) ;
assign variable_map_assume___p93__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x15)==(__auxvar8__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x15)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_)))) ;
assign variable_map_assume___p94__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x16)==(__auxvar9__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x16)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_)))) ;
assign variable_map_assume___p95__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x17)==(__auxvar10__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x17)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_)))) ;
assign variable_map_assume___p96__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x18)==(__auxvar11__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x18)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_)))) ;
assign variable_map_assume___p97__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x19)==(__auxvar12__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x19)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_)))) ;
assign variable_map_assume___p98__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x2)==(__auxvar13__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x2)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_)))) ;
assign variable_map_assume___p99__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x20)==(__auxvar14__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x20)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_)))) ;
assign variable_map_assume___p100__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x21)==(__auxvar15__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x21)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_)))) ;
assign variable_map_assume___p101__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x22)==(__auxvar16__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x22)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_)))) ;
assign variable_map_assume___p102__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x23)==(__auxvar17__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x23)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_)))) ;
assign variable_map_assume___p103__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x24)==(__auxvar18__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x24)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_)))) ;
assign variable_map_assume___p104__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x25)==(__auxvar19__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x25)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_)))) ;
assign variable_map_assume___p105__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x26)==(__auxvar20__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x26)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_)))) ;
assign variable_map_assume___p106__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x27)==(__auxvar21__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x27)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_)))) ;
assign variable_map_assume___p107__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x28)==(__auxvar22__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x28)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_)))) ;
assign variable_map_assume___p108__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x29)==(__auxvar23__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x29)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_)))) ;
assign variable_map_assume___p109__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x3)==(__auxvar24__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x3)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_)))) ;
assign variable_map_assume___p110__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x30)==(__auxvar25__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x30)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_)))) ;
assign variable_map_assume___p111__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x31)==(__auxvar26__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x31)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_)))) ;
assign variable_map_assume___p112__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x4)==(__auxvar27__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x4)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_)))) ;
assign variable_map_assume___p113__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x5)==(__auxvar28__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x5)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_)))) ;
assign variable_map_assume___p114__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x6)==(__auxvar29__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x6)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_)))) ;
assign variable_map_assume___p115__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x7)==(__auxvar30__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x7)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_)))) ;
assign variable_map_assume___p116__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x8)==(__auxvar31__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x8)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_)))) ;
assign variable_map_assume___p117__ = (!(__START__))||(((!(__START__))||((__ILA_SO_x9)==(__auxvar32__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x9)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_)))) ;
assign variable_map_assert__p118__ = (!(__IEND__))||((!(__IEND__))||((__ILA_SO_load_en)==(((mem_req_en)==(1'b1))&&((mem_req_op)==(1'b0))))) ;
assign variable_map_assert__p119__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_pc)==(RTL__DOT__near_mem$imem_pc)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_pc)==(__auxvar1__recorder)))) ;
assign variable_map_assert__p120__ = (!(__IEND__))||((!(__IEND__))||((__ILA_SO_store_en)==(((mem_req_en)==(1'b1))&&((mem_req_op)==(1'b1))))) ;
assign variable_map_assert__p121__ = (!(__IEND__))||((__ILA_SO_x0)==(0)) ;
assign variable_map_assert__p122__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x1)==(__auxvar2__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x1)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_)))) ;
assign variable_map_assert__p123__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x10)==(__auxvar3__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x10)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_)))) ;
assign variable_map_assert__p124__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x11)==(__auxvar4__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x11)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_)))) ;
assign variable_map_assert__p125__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x12)==(__auxvar5__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x12)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_)))) ;
assign variable_map_assert__p126__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x13)==(__auxvar6__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x13)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_)))) ;
assign variable_map_assert__p127__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x14)==(__auxvar7__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x14)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_)))) ;
assign variable_map_assert__p128__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x15)==(__auxvar8__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x15)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_)))) ;
assign variable_map_assert__p129__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x16)==(__auxvar9__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x16)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_)))) ;
assign variable_map_assert__p130__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x17)==(__auxvar10__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x17)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_)))) ;
assign variable_map_assert__p131__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x18)==(__auxvar11__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x18)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_)))) ;
assign variable_map_assert__p132__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x19)==(__auxvar12__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x19)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_)))) ;
assign variable_map_assert__p133__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x2)==(__auxvar13__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x2)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_)))) ;
assign variable_map_assert__p134__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x20)==(__auxvar14__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x20)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_)))) ;
assign variable_map_assert__p135__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x21)==(__auxvar15__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x21)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_)))) ;
assign variable_map_assert__p136__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x22)==(__auxvar16__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x22)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_)))) ;
assign variable_map_assert__p137__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x23)==(__auxvar17__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x23)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_)))) ;
assign variable_map_assert__p138__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x24)==(__auxvar18__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x24)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_)))) ;
assign variable_map_assert__p139__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x25)==(__auxvar19__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x25)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_)))) ;
assign variable_map_assert__p140__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x26)==(__auxvar20__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x26)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_)))) ;
assign variable_map_assert__p141__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x27)==(__auxvar21__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x27)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_)))) ;
assign variable_map_assert__p142__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x28)==(__auxvar22__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x28)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_)))) ;
assign variable_map_assert__p143__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x29)==(__auxvar23__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x29)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_)))) ;
assign variable_map_assert__p144__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x3)==(__auxvar24__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x3)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_)))) ;
assign variable_map_assert__p145__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x30)==(__auxvar25__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x30)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_)))) ;
assign variable_map_assert__p146__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x31)==(__auxvar26__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x31)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_)))) ;
assign variable_map_assert__p147__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x4)==(__auxvar27__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x4)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_)))) ;
assign variable_map_assert__p148__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x5)==(__auxvar28__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x5)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_)))) ;
assign variable_map_assert__p149__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x6)==(__auxvar29__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x6)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_)))) ;
assign variable_map_assert__p150__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x7)==(__auxvar30__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x7)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_)))) ;
assign variable_map_assert__p151__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x8)==(__auxvar31__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x8)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_)))) ;
assign variable_map_assert__p152__ = (!(__IEND__))||(((!(__START__))||((__ILA_SO_x9)==(__auxvar32__recorder)))&&((!((!(__START__))&&(__IEND__)))||((__ILA_SO_x9)==(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_)))) ;
assign post_value_holder_overly_constrained__p153__ = (!((__auxvar10__recorder_sn_condmet)&&(__auxvar10__recorder_sn_cond)))||((__auxvar10__recorder_sn_value)==(__auxvar10__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p154__ = (!((__auxvar11__recorder_sn_condmet)&&(__auxvar11__recorder_sn_cond)))||((__auxvar11__recorder_sn_value)==(__auxvar11__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p155__ = (!((__auxvar12__recorder_sn_condmet)&&(__auxvar12__recorder_sn_cond)))||((__auxvar12__recorder_sn_value)==(__auxvar12__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p156__ = (!((__auxvar13__recorder_sn_condmet)&&(__auxvar13__recorder_sn_cond)))||((__auxvar13__recorder_sn_value)==(__auxvar13__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p157__ = (!((__auxvar14__recorder_sn_condmet)&&(__auxvar14__recorder_sn_cond)))||((__auxvar14__recorder_sn_value)==(__auxvar14__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p158__ = (!((__auxvar15__recorder_sn_condmet)&&(__auxvar15__recorder_sn_cond)))||((__auxvar15__recorder_sn_value)==(__auxvar15__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p159__ = (!((__auxvar16__recorder_sn_condmet)&&(__auxvar16__recorder_sn_cond)))||((__auxvar16__recorder_sn_value)==(__auxvar16__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p160__ = (!((__auxvar17__recorder_sn_condmet)&&(__auxvar17__recorder_sn_cond)))||((__auxvar17__recorder_sn_value)==(__auxvar17__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p161__ = (!((__auxvar18__recorder_sn_condmet)&&(__auxvar18__recorder_sn_cond)))||((__auxvar18__recorder_sn_value)==(__auxvar18__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p162__ = (!((__auxvar19__recorder_sn_condmet)&&(__auxvar19__recorder_sn_cond)))||((__auxvar19__recorder_sn_value)==(__auxvar19__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p163__ = (!((__auxvar1__recorder_sn_condmet)&&(__auxvar1__recorder_sn_cond)))||((__auxvar1__recorder_sn_value)==(__auxvar1__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p164__ = (!((__auxvar20__recorder_sn_condmet)&&(__auxvar20__recorder_sn_cond)))||((__auxvar20__recorder_sn_value)==(__auxvar20__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p165__ = (!((__auxvar21__recorder_sn_condmet)&&(__auxvar21__recorder_sn_cond)))||((__auxvar21__recorder_sn_value)==(__auxvar21__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p166__ = (!((__auxvar22__recorder_sn_condmet)&&(__auxvar22__recorder_sn_cond)))||((__auxvar22__recorder_sn_value)==(__auxvar22__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p167__ = (!((__auxvar23__recorder_sn_condmet)&&(__auxvar23__recorder_sn_cond)))||((__auxvar23__recorder_sn_value)==(__auxvar23__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p168__ = (!((__auxvar24__recorder_sn_condmet)&&(__auxvar24__recorder_sn_cond)))||((__auxvar24__recorder_sn_value)==(__auxvar24__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p169__ = (!((__auxvar25__recorder_sn_condmet)&&(__auxvar25__recorder_sn_cond)))||((__auxvar25__recorder_sn_value)==(__auxvar25__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p170__ = (!((__auxvar26__recorder_sn_condmet)&&(__auxvar26__recorder_sn_cond)))||((__auxvar26__recorder_sn_value)==(__auxvar26__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p171__ = (!((__auxvar27__recorder_sn_condmet)&&(__auxvar27__recorder_sn_cond)))||((__auxvar27__recorder_sn_value)==(__auxvar27__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p172__ = (!((__auxvar28__recorder_sn_condmet)&&(__auxvar28__recorder_sn_cond)))||((__auxvar28__recorder_sn_value)==(__auxvar28__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p173__ = (!((__auxvar29__recorder_sn_condmet)&&(__auxvar29__recorder_sn_cond)))||((__auxvar29__recorder_sn_value)==(__auxvar29__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p174__ = (!((__auxvar2__recorder_sn_condmet)&&(__auxvar2__recorder_sn_cond)))||((__auxvar2__recorder_sn_value)==(__auxvar2__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p175__ = (!((__auxvar30__recorder_sn_condmet)&&(__auxvar30__recorder_sn_cond)))||((__auxvar30__recorder_sn_value)==(__auxvar30__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p176__ = (!((__auxvar31__recorder_sn_condmet)&&(__auxvar31__recorder_sn_cond)))||((__auxvar31__recorder_sn_value)==(__auxvar31__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p177__ = (!((__auxvar32__recorder_sn_condmet)&&(__auxvar32__recorder_sn_cond)))||((__auxvar32__recorder_sn_value)==(__auxvar32__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p178__ = (!((__auxvar33__recorder_sn_condmet)&&(__auxvar33__recorder_sn_cond)))||((__auxvar33__recorder_sn_value)==(__auxvar33__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p179__ = (!((__auxvar34__recorder_sn_condmet)&&(__auxvar34__recorder_sn_cond)))||((__auxvar34__recorder_sn_value)==(__auxvar34__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p180__ = (!((__auxvar35__recorder_sn_condmet)&&(__auxvar35__recorder_sn_cond)))||((__auxvar35__recorder_sn_value)==(__auxvar35__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p181__ = (!((__auxvar36__recorder_sn_condmet)&&(__auxvar36__recorder_sn_cond)))||((__auxvar36__recorder_sn_value)==(__auxvar36__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p182__ = (!((__auxvar37__recorder_sn_condmet)&&(__auxvar37__recorder_sn_cond)))||((__auxvar37__recorder_sn_value)==(__auxvar37__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p183__ = (!((__auxvar38__recorder_sn_condmet)&&(__auxvar38__recorder_sn_cond)))||((__auxvar38__recorder_sn_value)==(__auxvar38__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p184__ = (!((__auxvar3__recorder_sn_condmet)&&(__auxvar3__recorder_sn_cond)))||((__auxvar3__recorder_sn_value)==(__auxvar3__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p185__ = (!((__auxvar4__recorder_sn_condmet)&&(__auxvar4__recorder_sn_cond)))||((__auxvar4__recorder_sn_value)==(__auxvar4__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p186__ = (!((__auxvar5__recorder_sn_condmet)&&(__auxvar5__recorder_sn_cond)))||((__auxvar5__recorder_sn_value)==(__auxvar5__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p187__ = (!((__auxvar6__recorder_sn_condmet)&&(__auxvar6__recorder_sn_cond)))||((__auxvar6__recorder_sn_value)==(__auxvar6__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p188__ = (!((__auxvar7__recorder_sn_condmet)&&(__auxvar7__recorder_sn_cond)))||((__auxvar7__recorder_sn_value)==(__auxvar7__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p189__ = (!((__auxvar8__recorder_sn_condmet)&&(__auxvar8__recorder_sn_cond)))||((__auxvar8__recorder_sn_value)==(__auxvar8__recorder_sn_vhold)) ;
assign post_value_holder_overly_constrained__p190__ = (!((__auxvar9__recorder_sn_condmet)&&(__auxvar9__recorder_sn_cond)))||((__auxvar9__recorder_sn_value)==(__auxvar9__recorder_sn_vhold)) ;
assign post_value_holder_triggered__p191__ = (!(__IEND__))||((__auxvar10__recorder_sn_condmet)||(__auxvar10__recorder_sn_cond)) ;
assign post_value_holder_triggered__p192__ = (!(__IEND__))||((__auxvar11__recorder_sn_condmet)||(__auxvar11__recorder_sn_cond)) ;
assign post_value_holder_triggered__p193__ = (!(__IEND__))||((__auxvar12__recorder_sn_condmet)||(__auxvar12__recorder_sn_cond)) ;
assign post_value_holder_triggered__p194__ = (!(__IEND__))||((__auxvar13__recorder_sn_condmet)||(__auxvar13__recorder_sn_cond)) ;
assign post_value_holder_triggered__p195__ = (!(__IEND__))||((__auxvar14__recorder_sn_condmet)||(__auxvar14__recorder_sn_cond)) ;
assign post_value_holder_triggered__p196__ = (!(__IEND__))||((__auxvar15__recorder_sn_condmet)||(__auxvar15__recorder_sn_cond)) ;
assign post_value_holder_triggered__p197__ = (!(__IEND__))||((__auxvar16__recorder_sn_condmet)||(__auxvar16__recorder_sn_cond)) ;
assign post_value_holder_triggered__p198__ = (!(__IEND__))||((__auxvar17__recorder_sn_condmet)||(__auxvar17__recorder_sn_cond)) ;
assign post_value_holder_triggered__p199__ = (!(__IEND__))||((__auxvar18__recorder_sn_condmet)||(__auxvar18__recorder_sn_cond)) ;
assign post_value_holder_triggered__p200__ = (!(__IEND__))||((__auxvar19__recorder_sn_condmet)||(__auxvar19__recorder_sn_cond)) ;
assign post_value_holder_triggered__p201__ = (!(__IEND__))||((__auxvar1__recorder_sn_condmet)||(__auxvar1__recorder_sn_cond)) ;
assign post_value_holder_triggered__p202__ = (!(__IEND__))||((__auxvar20__recorder_sn_condmet)||(__auxvar20__recorder_sn_cond)) ;
assign post_value_holder_triggered__p203__ = (!(__IEND__))||((__auxvar21__recorder_sn_condmet)||(__auxvar21__recorder_sn_cond)) ;
assign post_value_holder_triggered__p204__ = (!(__IEND__))||((__auxvar22__recorder_sn_condmet)||(__auxvar22__recorder_sn_cond)) ;
assign post_value_holder_triggered__p205__ = (!(__IEND__))||((__auxvar23__recorder_sn_condmet)||(__auxvar23__recorder_sn_cond)) ;
assign post_value_holder_triggered__p206__ = (!(__IEND__))||((__auxvar24__recorder_sn_condmet)||(__auxvar24__recorder_sn_cond)) ;
assign post_value_holder_triggered__p207__ = (!(__IEND__))||((__auxvar25__recorder_sn_condmet)||(__auxvar25__recorder_sn_cond)) ;
assign post_value_holder_triggered__p208__ = (!(__IEND__))||((__auxvar26__recorder_sn_condmet)||(__auxvar26__recorder_sn_cond)) ;
assign post_value_holder_triggered__p209__ = (!(__IEND__))||((__auxvar27__recorder_sn_condmet)||(__auxvar27__recorder_sn_cond)) ;
assign post_value_holder_triggered__p210__ = (!(__IEND__))||((__auxvar28__recorder_sn_condmet)||(__auxvar28__recorder_sn_cond)) ;
assign post_value_holder_triggered__p211__ = (!(__IEND__))||((__auxvar29__recorder_sn_condmet)||(__auxvar29__recorder_sn_cond)) ;
assign post_value_holder_triggered__p212__ = (!(__IEND__))||((__auxvar2__recorder_sn_condmet)||(__auxvar2__recorder_sn_cond)) ;
assign post_value_holder_triggered__p213__ = (!(__IEND__))||((__auxvar30__recorder_sn_condmet)||(__auxvar30__recorder_sn_cond)) ;
assign post_value_holder_triggered__p214__ = (!(__IEND__))||((__auxvar31__recorder_sn_condmet)||(__auxvar31__recorder_sn_cond)) ;
assign post_value_holder_triggered__p215__ = (!(__IEND__))||((__auxvar32__recorder_sn_condmet)||(__auxvar32__recorder_sn_cond)) ;
assign post_value_holder_triggered__p216__ = (!(__IEND__))||((__auxvar33__recorder_sn_condmet)||(__auxvar33__recorder_sn_cond)) ;
assign post_value_holder_triggered__p217__ = (!(__IEND__))||((__auxvar34__recorder_sn_condmet)||(__auxvar34__recorder_sn_cond)) ;
assign post_value_holder_triggered__p218__ = (!(__IEND__))||((__auxvar35__recorder_sn_condmet)||(__auxvar35__recorder_sn_cond)) ;
assign post_value_holder_triggered__p219__ = (!(__IEND__))||((__auxvar36__recorder_sn_condmet)||(__auxvar36__recorder_sn_cond)) ;
assign post_value_holder_triggered__p220__ = (!(__IEND__))||((__auxvar37__recorder_sn_condmet)||(__auxvar37__recorder_sn_cond)) ;
assign post_value_holder_triggered__p221__ = (!(__IEND__))||((__auxvar38__recorder_sn_condmet)||(__auxvar38__recorder_sn_cond)) ;
assign post_value_holder_triggered__p222__ = (!(__IEND__))||((__auxvar3__recorder_sn_condmet)||(__auxvar3__recorder_sn_cond)) ;
assign post_value_holder_triggered__p223__ = (!(__IEND__))||((__auxvar4__recorder_sn_condmet)||(__auxvar4__recorder_sn_cond)) ;
assign post_value_holder_triggered__p224__ = (!(__IEND__))||((__auxvar5__recorder_sn_condmet)||(__auxvar5__recorder_sn_cond)) ;
assign post_value_holder_triggered__p225__ = (!(__IEND__))||((__auxvar6__recorder_sn_condmet)||(__auxvar6__recorder_sn_cond)) ;
assign post_value_holder_triggered__p226__ = (!(__IEND__))||((__auxvar7__recorder_sn_condmet)||(__auxvar7__recorder_sn_cond)) ;
assign post_value_holder_triggered__p227__ = (!(__IEND__))||((__auxvar8__recorder_sn_condmet)||(__auxvar8__recorder_sn_cond)) ;
assign post_value_holder_triggered__p228__ = (!(__IEND__))||((__auxvar9__recorder_sn_condmet)||(__auxvar9__recorder_sn_cond)) ;
mkCPU RTL(
    .CLK(clk),
    .EN_hart0_server_reset_request_put(__VLG_I_EN_hart0_server_reset_request_put),
    .EN_hart0_server_reset_response_get(__VLG_I_EN_hart0_server_reset_response_get),
    .EN_set_verbosity(__VLG_I_EN_set_verbosity),
    .RDY_hart0_server_reset_request_put(__VLG_O_RDY_hart0_server_reset_request_put),
    .RDY_hart0_server_reset_response_get(__VLG_O_RDY_hart0_server_reset_response_get),
    .RDY_set_verbosity(__VLG_O_RDY_set_verbosity),
    .RST_N(~rst),
    .RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg),
    .RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg),
    .RTL__DOT__csr_regfile__DOT__rg_nmi(RTL__DOT__csr_regfile__DOT__rg_nmi),
    .RTL__DOT__csr_regfile__DOT__rg_state(RTL__DOT__csr_regfile__DOT__rg_state),
    .RTL__DOT__f_reset_reqs__DOT__empty_reg(RTL__DOT__f_reset_reqs__DOT__empty_reg),
    .RTL__DOT__f_reset_reqs__DOT__full_reg(RTL__DOT__f_reset_reqs__DOT__full_reg),
    .RTL__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__f_reset_rsps__DOT__empty_reg),
    .RTL__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__f_reset_rsps__DOT__full_reg),
    .RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg),
    .RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_),
    .RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_),
    .RTL__DOT__near_mem$EN_dmem_req(RTL__DOT__near_mem$EN_dmem_req),
    .RTL__DOT__near_mem$dmem_exc(RTL__DOT__near_mem$dmem_exc),
    .RTL__DOT__near_mem$dmem_req_addr(RTL__DOT__near_mem$dmem_req_addr),
    .RTL__DOT__near_mem$dmem_req_f3(RTL__DOT__near_mem$dmem_req_f3),
    .RTL__DOT__near_mem$dmem_req_op(RTL__DOT__near_mem$dmem_req_op),
    .RTL__DOT__near_mem$dmem_req_store_value(RTL__DOT__near_mem$dmem_req_store_value),
    .RTL__DOT__near_mem$dmem_word64(RTL__DOT__near_mem$dmem_word64),
    .RTL__DOT__near_mem$imem_instr(RTL__DOT__near_mem$imem_instr),
    .RTL__DOT__near_mem$imem_pc(RTL__DOT__near_mem$imem_pc),
    .RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr(RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr),
    .RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa(RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa),
    .RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg),
    .RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg),
    .RTL__DOT__rg_cur_priv(RTL__DOT__rg_cur_priv),
    .RTL__DOT__rg_retiring$EN(RTL__DOT__rg_retiring$EN),
    .RTL__DOT__rg_run_on_reset(RTL__DOT__rg_run_on_reset),
    .RTL__DOT__rg_state(RTL__DOT__rg_state),
    .RTL__DOT__rg_trap_instr(RTL__DOT__rg_trap_instr),
    .RTL__DOT__s1_to_s2$D_IN(RTL__DOT__s1_to_s2$D_IN),
    .RTL__DOT__s1_to_s2$EN(RTL__DOT__s1_to_s2$EN),
    .RTL__DOT__s2_to_s3$D_IN(RTL__DOT__s2_to_s3$D_IN),
    .RTL__DOT__s2_to_s3$EN(RTL__DOT__s2_to_s3$EN),
    .RTL__DOT__s3_deq$D_IN(RTL__DOT__s3_deq$D_IN),
    .RTL__DOT__s3_deq$EN(RTL__DOT__s3_deq$EN),
    .RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg(RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg),
    .RTL__DOT__stage1_f_reset_reqs__DOT__full_reg(RTL__DOT__stage1_f_reset_reqs__DOT__full_reg),
    .RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg(RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg),
    .RTL__DOT__stage1_f_reset_rsps__DOT__full_reg(RTL__DOT__stage1_f_reset_rsps__DOT__full_reg),
    .RTL__DOT__stage1_rg_full(RTL__DOT__stage1_rg_full),
    .RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg(RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg),
    .RTL__DOT__stage2_f_reset_reqs__DOT__full_reg(RTL__DOT__stage2_f_reset_reqs__DOT__full_reg),
    .RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg(RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg),
    .RTL__DOT__stage2_f_reset_rsps__DOT__full_reg(RTL__DOT__stage2_f_reset_rsps__DOT__full_reg),
    .RTL__DOT__stage2_rg_full(RTL__DOT__stage2_rg_full),
    .RTL__DOT__stage2_rg_stage2(RTL__DOT__stage2_rg_stage2),
    .RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg(RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg),
    .RTL__DOT__stage3_f_reset_reqs__DOT__full_reg(RTL__DOT__stage3_f_reset_reqs__DOT__full_reg),
    .RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg(RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg),
    .RTL__DOT__stage3_f_reset_rsps__DOT__full_reg(RTL__DOT__stage3_f_reset_rsps__DOT__full_reg),
    .RTL__DOT__stage3_rg_full(RTL__DOT__stage3_rg_full),
    .dmem_master_araddr(__VLG_O_dmem_master_araddr),
    .dmem_master_arburst(__VLG_O_dmem_master_arburst),
    .dmem_master_arcache(__VLG_O_dmem_master_arcache),
    .dmem_master_arid(__VLG_O_dmem_master_arid),
    .dmem_master_arlen(__VLG_O_dmem_master_arlen),
    .dmem_master_arlock(__VLG_O_dmem_master_arlock),
    .dmem_master_arprot(__VLG_O_dmem_master_arprot),
    .dmem_master_arqos(__VLG_O_dmem_master_arqos),
    .dmem_master_arready(__VLG_I_dmem_master_arready),
    .dmem_master_arregion(__VLG_O_dmem_master_arregion),
    .dmem_master_arsize(__VLG_O_dmem_master_arsize),
    .dmem_master_arvalid(__VLG_O_dmem_master_arvalid),
    .dmem_master_awaddr(__VLG_O_dmem_master_awaddr),
    .dmem_master_awburst(__VLG_O_dmem_master_awburst),
    .dmem_master_awcache(__VLG_O_dmem_master_awcache),
    .dmem_master_awid(__VLG_O_dmem_master_awid),
    .dmem_master_awlen(__VLG_O_dmem_master_awlen),
    .dmem_master_awlock(__VLG_O_dmem_master_awlock),
    .dmem_master_awprot(__VLG_O_dmem_master_awprot),
    .dmem_master_awqos(__VLG_O_dmem_master_awqos),
    .dmem_master_awready(__VLG_I_dmem_master_awready),
    .dmem_master_awregion(__VLG_O_dmem_master_awregion),
    .dmem_master_awsize(__VLG_O_dmem_master_awsize),
    .dmem_master_awvalid(__VLG_O_dmem_master_awvalid),
    .dmem_master_bid(__VLG_I_dmem_master_bid),
    .dmem_master_bready(__VLG_O_dmem_master_bready),
    .dmem_master_bresp(__VLG_I_dmem_master_bresp),
    .dmem_master_bvalid(__VLG_I_dmem_master_bvalid),
    .dmem_master_rdata(__VLG_I_dmem_master_rdata),
    .dmem_master_rid(__VLG_I_dmem_master_rid),
    .dmem_master_rlast(__VLG_I_dmem_master_rlast),
    .dmem_master_rready(__VLG_O_dmem_master_rready),
    .dmem_master_rresp(__VLG_I_dmem_master_rresp),
    .dmem_master_rvalid(__VLG_I_dmem_master_rvalid),
    .dmem_master_wdata(__VLG_O_dmem_master_wdata),
    .dmem_master_wlast(__VLG_O_dmem_master_wlast),
    .dmem_master_wready(__VLG_I_dmem_master_wready),
    .dmem_master_wstrb(__VLG_O_dmem_master_wstrb),
    .dmem_master_wvalid(__VLG_O_dmem_master_wvalid),
    .hart0_server_reset_request_put(__VLG_I_hart0_server_reset_request_put),
    .hart0_server_reset_response_get(__VLG_O_hart0_server_reset_response_get),
    .imem_master_araddr(__VLG_O_imem_master_araddr),
    .imem_master_arburst(__VLG_O_imem_master_arburst),
    .imem_master_arcache(__VLG_O_imem_master_arcache),
    .imem_master_arid(__VLG_O_imem_master_arid),
    .imem_master_arlen(__VLG_O_imem_master_arlen),
    .imem_master_arlock(__VLG_O_imem_master_arlock),
    .imem_master_arprot(__VLG_O_imem_master_arprot),
    .imem_master_arqos(__VLG_O_imem_master_arqos),
    .imem_master_arready(__VLG_I_imem_master_arready),
    .imem_master_arregion(__VLG_O_imem_master_arregion),
    .imem_master_arsize(__VLG_O_imem_master_arsize),
    .imem_master_arvalid(__VLG_O_imem_master_arvalid),
    .imem_master_awaddr(__VLG_O_imem_master_awaddr),
    .imem_master_awburst(__VLG_O_imem_master_awburst),
    .imem_master_awcache(__VLG_O_imem_master_awcache),
    .imem_master_awid(__VLG_O_imem_master_awid),
    .imem_master_awlen(__VLG_O_imem_master_awlen),
    .imem_master_awlock(__VLG_O_imem_master_awlock),
    .imem_master_awprot(__VLG_O_imem_master_awprot),
    .imem_master_awqos(__VLG_O_imem_master_awqos),
    .imem_master_awready(__VLG_I_imem_master_awready),
    .imem_master_awregion(__VLG_O_imem_master_awregion),
    .imem_master_awsize(__VLG_O_imem_master_awsize),
    .imem_master_awvalid(__VLG_O_imem_master_awvalid),
    .imem_master_bid(__VLG_I_imem_master_bid),
    .imem_master_bready(__VLG_O_imem_master_bready),
    .imem_master_bresp(__VLG_I_imem_master_bresp),
    .imem_master_bvalid(__VLG_I_imem_master_bvalid),
    .imem_master_rdata(__VLG_I_imem_master_rdata),
    .imem_master_rid(__VLG_I_imem_master_rid),
    .imem_master_rlast(__VLG_I_imem_master_rlast),
    .imem_master_rready(__VLG_O_imem_master_rready),
    .imem_master_rresp(__VLG_I_imem_master_rresp),
    .imem_master_rvalid(__VLG_I_imem_master_rvalid),
    .imem_master_wdata(__VLG_O_imem_master_wdata),
    .imem_master_wlast(__VLG_O_imem_master_wlast),
    .imem_master_wready(__VLG_I_imem_master_wready),
    .imem_master_wstrb(__VLG_O_imem_master_wstrb),
    .imem_master_wvalid(__VLG_O_imem_master_wvalid),
    .m_external_interrupt_req_set_not_clear(__VLG_II_m_external_interrupt_req_set_not_clear),
    .nmi_req_set_not_clear(__VLG_II_nmi_req_set_not_clear),
    .s_external_interrupt_req_set_not_clear(__VLG_II_s_external_interrupt_req_set_not_clear),
    .set_verbosity_logdelay(__VLG_I_set_verbosity_logdelay),
    .set_verbosity_verbosity(__VLG_I_set_verbosity_verbosity),
    .software_interrupt_req_set_not_clear(__VLG_II_software_interrupt_req_set_not_clear),
    .timer_interrupt_req_set_not_clear(__VLG_II_timer_interrupt_req_set_not_clear)
);
assign __all_assert_wire__ = (variable_map_assert__p118__) && (variable_map_assert__p119__) && (variable_map_assert__p120__) && (variable_map_assert__p121__) && (variable_map_assert__p122__) && (variable_map_assert__p123__) && (variable_map_assert__p124__) && (variable_map_assert__p125__) && (variable_map_assert__p126__) && (variable_map_assert__p127__) && (variable_map_assert__p128__) && (variable_map_assert__p129__) && (variable_map_assert__p130__) && (variable_map_assert__p131__) && (variable_map_assert__p132__) && (variable_map_assert__p133__) && (variable_map_assert__p134__) && (variable_map_assert__p135__) && (variable_map_assert__p136__) && (variable_map_assert__p137__) && (variable_map_assert__p138__) && (variable_map_assert__p139__) && (variable_map_assert__p140__) && (variable_map_assert__p141__) && (variable_map_assert__p142__) && (variable_map_assert__p143__) && (variable_map_assert__p144__) && (variable_map_assert__p145__) && (variable_map_assert__p146__) && (variable_map_assert__p147__) && (variable_map_assert__p148__) && (variable_map_assert__p149__) && (variable_map_assert__p150__) && (variable_map_assert__p151__) && (variable_map_assert__p152__) ;
normalassert: assert property ( __all_assert_wire__ ); // the only assertion 

assign __all_assume_wire__ = (input_map_assume___p0__)&& (invariant_assume__p1__)&& (invariant_assume__p2__)&& (invariant_assume__p3__)&& (invariant_assume__p4__)&& (invariant_assume__p5__)&& (invariant_assume__p6__)&& (invariant_assume__p7__)&& (invariant_assume__p8__)&& (invariant_assume__p9__)&& (invariant_assume__p10__)&& (invariant_assume__p11__)&& (invariant_assume__p12__)&& (invariant_assume__p13__)&& (invariant_assume__p14__)&& (invariant_assume__p15__)&& (invariant_assume__p16__)&& (invariant_assume__p17__)&& (invariant_assume__p18__)&& (invariant_assume__p19__)&& (invariant_assume__p20__)&& (invariant_assume__p21__)&& (invariant_assume__p22__)&& (invariant_assume__p23__)&& (invariant_assume__p24__)&& (invariant_assume__p25__)&& (invariant_assume__p26__)&& (invariant_assume__p27__)&& (invariant_assume__p28__)&& (invariant_assume__p29__)&& (invariant_assume__p30__)&& (invariant_assume__p31__)&& (invariant_assume__p32__)&& (issue_decode__p33__)&& (issue_valid__p34__)&& (noreset__p35__)&& (post_value_holder__p36__)&& (post_value_holder__p37__)&& (post_value_holder__p38__)&& (post_value_holder__p39__)&& (post_value_holder__p40__)&& (post_value_holder__p41__)&& (post_value_holder__p42__)&& (post_value_holder__p43__)&& (post_value_holder__p44__)&& (post_value_holder__p45__)&& (post_value_holder__p46__)&& (post_value_holder__p47__)&& (post_value_holder__p48__)&& (post_value_holder__p49__)&& (post_value_holder__p50__)&& (post_value_holder__p51__)&& (post_value_holder__p52__)&& (post_value_holder__p53__)&& (post_value_holder__p54__)&& (post_value_holder__p55__)&& (post_value_holder__p56__)&& (post_value_holder__p57__)&& (post_value_holder__p58__)&& (post_value_holder__p59__)&& (post_value_holder__p60__)&& (post_value_holder__p61__)&& (post_value_holder__p62__)&& (post_value_holder__p63__)&& (post_value_holder__p64__)&& (post_value_holder__p65__)&& (post_value_holder__p66__)&& (post_value_holder__p67__)&& (post_value_holder__p68__)&& (post_value_holder__p69__)&& (post_value_holder__p70__)&& (post_value_holder__p71__)&& (post_value_holder__p72__)&& (post_value_holder__p73__)&& (rfassumptions__p74__)&& (rfassumptions__p75__)&& (rfassumptions__p76__)&& (variable_map_assume___p77__)&& (variable_map_assume___p78__)&& (variable_map_assume___p79__)&& (variable_map_assume___p80__)&& (variable_map_assume___p81__)&& (variable_map_assume___p82__)&& (variable_map_assume___p83__)&& (variable_map_assume___p84__)&& (variable_map_assume___p85__)&& (variable_map_assume___p86__)&& (variable_map_assume___p87__)&& (variable_map_assume___p88__)&& (variable_map_assume___p89__)&& (variable_map_assume___p90__)&& (variable_map_assume___p91__)&& (variable_map_assume___p92__)&& (variable_map_assume___p93__)&& (variable_map_assume___p94__)&& (variable_map_assume___p95__)&& (variable_map_assume___p96__)&& (variable_map_assume___p97__)&& (variable_map_assume___p98__)&& (variable_map_assume___p99__)&& (variable_map_assume___p100__)&& (variable_map_assume___p101__)&& (variable_map_assume___p102__)&& (variable_map_assume___p103__)&& (variable_map_assume___p104__)&& (variable_map_assume___p105__)&& (variable_map_assume___p106__)&& (variable_map_assume___p107__)&& (variable_map_assume___p108__)&& (variable_map_assume___p109__)&& (variable_map_assume___p110__)&& (variable_map_assume___p111__)&& (variable_map_assume___p112__)&& (variable_map_assume___p113__)&& (variable_map_assume___p114__)&& (variable_map_assume___p115__)&& (variable_map_assume___p116__)&& (variable_map_assume___p117__) ;
all_assume: assume property ( __all_assume_wire__ ); // the only sanity assertion 

assign __sanitycheck_wire__ = (post_value_holder_overly_constrained__p153__) && (post_value_holder_overly_constrained__p154__) && (post_value_holder_overly_constrained__p155__) && (post_value_holder_overly_constrained__p156__) && (post_value_holder_overly_constrained__p157__) && (post_value_holder_overly_constrained__p158__) && (post_value_holder_overly_constrained__p159__) && (post_value_holder_overly_constrained__p160__) && (post_value_holder_overly_constrained__p161__) && (post_value_holder_overly_constrained__p162__) && (post_value_holder_overly_constrained__p163__) && (post_value_holder_overly_constrained__p164__) && (post_value_holder_overly_constrained__p165__) && (post_value_holder_overly_constrained__p166__) && (post_value_holder_overly_constrained__p167__) && (post_value_holder_overly_constrained__p168__) && (post_value_holder_overly_constrained__p169__) && (post_value_holder_overly_constrained__p170__) && (post_value_holder_overly_constrained__p171__) && (post_value_holder_overly_constrained__p172__) && (post_value_holder_overly_constrained__p173__) && (post_value_holder_overly_constrained__p174__) && (post_value_holder_overly_constrained__p175__) && (post_value_holder_overly_constrained__p176__) && (post_value_holder_overly_constrained__p177__) && (post_value_holder_overly_constrained__p178__) && (post_value_holder_overly_constrained__p179__) && (post_value_holder_overly_constrained__p180__) && (post_value_holder_overly_constrained__p181__) && (post_value_holder_overly_constrained__p182__) && (post_value_holder_overly_constrained__p183__) && (post_value_holder_overly_constrained__p184__) && (post_value_holder_overly_constrained__p185__) && (post_value_holder_overly_constrained__p186__) && (post_value_holder_overly_constrained__p187__) && (post_value_holder_overly_constrained__p188__) && (post_value_holder_overly_constrained__p189__) && (post_value_holder_overly_constrained__p190__) && (post_value_holder_triggered__p191__) && (post_value_holder_triggered__p192__) && (post_value_holder_triggered__p193__) && (post_value_holder_triggered__p194__) && (post_value_holder_triggered__p195__) && (post_value_holder_triggered__p196__) && (post_value_holder_triggered__p197__) && (post_value_holder_triggered__p198__) && (post_value_holder_triggered__p199__) && (post_value_holder_triggered__p200__) && (post_value_holder_triggered__p201__) && (post_value_holder_triggered__p202__) && (post_value_holder_triggered__p203__) && (post_value_holder_triggered__p204__) && (post_value_holder_triggered__p205__) && (post_value_holder_triggered__p206__) && (post_value_holder_triggered__p207__) && (post_value_holder_triggered__p208__) && (post_value_holder_triggered__p209__) && (post_value_holder_triggered__p210__) && (post_value_holder_triggered__p211__) && (post_value_holder_triggered__p212__) && (post_value_holder_triggered__p213__) && (post_value_holder_triggered__p214__) && (post_value_holder_triggered__p215__) && (post_value_holder_triggered__p216__) && (post_value_holder_triggered__p217__) && (post_value_holder_triggered__p218__) && (post_value_holder_triggered__p219__) && (post_value_holder_triggered__p220__) && (post_value_holder_triggered__p221__) && (post_value_holder_triggered__p222__) && (post_value_holder_triggered__p223__) && (post_value_holder_triggered__p224__) && (post_value_holder_triggered__p225__) && (post_value_holder_triggered__p226__) && (post_value_holder_triggered__p227__) && (post_value_holder_triggered__p228__) ;
sanitycheck: assert property ( __sanitycheck_wire__ ); // the only assumption 

always @(posedge clk) begin
   if(rst) begin
       __auxvar10__recorder <= ____auxvar10__recorder_init__;
       __auxvar10__recorder_sn_condmet <= 1'b0;
       __auxvar11__recorder <= ____auxvar11__recorder_init__;
       __auxvar11__recorder_sn_condmet <= 1'b0;
       __auxvar12__recorder <= ____auxvar12__recorder_init__;
       __auxvar12__recorder_sn_condmet <= 1'b0;
       __auxvar13__recorder <= ____auxvar13__recorder_init__;
       __auxvar13__recorder_sn_condmet <= 1'b0;
       __auxvar14__recorder <= ____auxvar14__recorder_init__;
       __auxvar14__recorder_sn_condmet <= 1'b0;
       __auxvar15__recorder <= ____auxvar15__recorder_init__;
       __auxvar15__recorder_sn_condmet <= 1'b0;
       __auxvar16__recorder <= ____auxvar16__recorder_init__;
       __auxvar16__recorder_sn_condmet <= 1'b0;
       __auxvar17__recorder <= ____auxvar17__recorder_init__;
       __auxvar17__recorder_sn_condmet <= 1'b0;
       __auxvar18__recorder <= ____auxvar18__recorder_init__;
       __auxvar18__recorder_sn_condmet <= 1'b0;
       __auxvar19__recorder <= ____auxvar19__recorder_init__;
       __auxvar19__recorder_sn_condmet <= 1'b0;
       __auxvar1__recorder <= ____auxvar1__recorder_init__;
       __auxvar1__recorder_sn_condmet <= 1'b0;
       __auxvar20__recorder <= ____auxvar20__recorder_init__;
       __auxvar20__recorder_sn_condmet <= 1'b0;
       __auxvar21__recorder <= ____auxvar21__recorder_init__;
       __auxvar21__recorder_sn_condmet <= 1'b0;
       __auxvar22__recorder <= ____auxvar22__recorder_init__;
       __auxvar22__recorder_sn_condmet <= 1'b0;
       __auxvar23__recorder <= ____auxvar23__recorder_init__;
       __auxvar23__recorder_sn_condmet <= 1'b0;
       __auxvar24__recorder <= ____auxvar24__recorder_init__;
       __auxvar24__recorder_sn_condmet <= 1'b0;
       __auxvar25__recorder <= ____auxvar25__recorder_init__;
       __auxvar25__recorder_sn_condmet <= 1'b0;
       __auxvar26__recorder <= ____auxvar26__recorder_init__;
       __auxvar26__recorder_sn_condmet <= 1'b0;
       __auxvar27__recorder <= ____auxvar27__recorder_init__;
       __auxvar27__recorder_sn_condmet <= 1'b0;
       __auxvar28__recorder <= ____auxvar28__recorder_init__;
       __auxvar28__recorder_sn_condmet <= 1'b0;
       __auxvar29__recorder <= ____auxvar29__recorder_init__;
       __auxvar29__recorder_sn_condmet <= 1'b0;
       __auxvar2__recorder <= ____auxvar2__recorder_init__;
       __auxvar2__recorder_sn_condmet <= 1'b0;
       __auxvar30__recorder <= ____auxvar30__recorder_init__;
       __auxvar30__recorder_sn_condmet <= 1'b0;
       __auxvar31__recorder <= ____auxvar31__recorder_init__;
       __auxvar31__recorder_sn_condmet <= 1'b0;
       __auxvar32__recorder <= ____auxvar32__recorder_init__;
       __auxvar32__recorder_sn_condmet <= 1'b0;
       __auxvar33__recorder <= ____auxvar33__recorder_init__;
       __auxvar33__recorder_sn_condmet <= 1'b0;
       __auxvar34__recorder <= ____auxvar34__recorder_init__;
       __auxvar34__recorder_sn_condmet <= 1'b0;
       __auxvar35__recorder <= ____auxvar35__recorder_init__;
       __auxvar35__recorder_sn_condmet <= 1'b0;
       __auxvar36__recorder <= ____auxvar36__recorder_init__;
       __auxvar36__recorder_sn_condmet <= 1'b0;
       __auxvar37__recorder <= ____auxvar37__recorder_init__;
       __auxvar37__recorder_sn_condmet <= 1'b0;
       __auxvar38__recorder <= ____auxvar38__recorder_init__;
       __auxvar38__recorder_sn_condmet <= 1'b0;
       __auxvar3__recorder <= ____auxvar3__recorder_init__;
       __auxvar3__recorder_sn_condmet <= 1'b0;
       __auxvar4__recorder <= ____auxvar4__recorder_init__;
       __auxvar4__recorder_sn_condmet <= 1'b0;
       __auxvar5__recorder <= ____auxvar5__recorder_init__;
       __auxvar5__recorder_sn_condmet <= 1'b0;
       __auxvar6__recorder <= ____auxvar6__recorder_init__;
       __auxvar6__recorder_sn_condmet <= 1'b0;
       __auxvar7__recorder <= ____auxvar7__recorder_init__;
       __auxvar7__recorder_sn_condmet <= 1'b0;
       __auxvar8__recorder <= ____auxvar8__recorder_init__;
       __auxvar8__recorder_sn_condmet <= 1'b0;
       __auxvar9__recorder <= ____auxvar9__recorder_init__;
       __auxvar9__recorder_sn_condmet <= 1'b0;
       __auxvar0__delay_d_1<= 0;
       monitor_s1_already<= 1'b0;
       monitor_s2<= 1'b0;
       monitor_s3<= 1'b0;
       monitor_s4<= 1'b0;
   end
   else if(1) begin
       __auxvar10__recorder <= __auxvar10__recorder;
       if (__auxvar10__recorder_sn_cond ) begin __auxvar10__recorder_sn_condmet <= 1'b1; __auxvar10__recorder_sn_vhold <= __auxvar10__recorder_sn_value; end
       __auxvar11__recorder <= __auxvar11__recorder;
       if (__auxvar11__recorder_sn_cond ) begin __auxvar11__recorder_sn_condmet <= 1'b1; __auxvar11__recorder_sn_vhold <= __auxvar11__recorder_sn_value; end
       __auxvar12__recorder <= __auxvar12__recorder;
       if (__auxvar12__recorder_sn_cond ) begin __auxvar12__recorder_sn_condmet <= 1'b1; __auxvar12__recorder_sn_vhold <= __auxvar12__recorder_sn_value; end
       __auxvar13__recorder <= __auxvar13__recorder;
       if (__auxvar13__recorder_sn_cond ) begin __auxvar13__recorder_sn_condmet <= 1'b1; __auxvar13__recorder_sn_vhold <= __auxvar13__recorder_sn_value; end
       __auxvar14__recorder <= __auxvar14__recorder;
       if (__auxvar14__recorder_sn_cond ) begin __auxvar14__recorder_sn_condmet <= 1'b1; __auxvar14__recorder_sn_vhold <= __auxvar14__recorder_sn_value; end
       __auxvar15__recorder <= __auxvar15__recorder;
       if (__auxvar15__recorder_sn_cond ) begin __auxvar15__recorder_sn_condmet <= 1'b1; __auxvar15__recorder_sn_vhold <= __auxvar15__recorder_sn_value; end
       __auxvar16__recorder <= __auxvar16__recorder;
       if (__auxvar16__recorder_sn_cond ) begin __auxvar16__recorder_sn_condmet <= 1'b1; __auxvar16__recorder_sn_vhold <= __auxvar16__recorder_sn_value; end
       __auxvar17__recorder <= __auxvar17__recorder;
       if (__auxvar17__recorder_sn_cond ) begin __auxvar17__recorder_sn_condmet <= 1'b1; __auxvar17__recorder_sn_vhold <= __auxvar17__recorder_sn_value; end
       __auxvar18__recorder <= __auxvar18__recorder;
       if (__auxvar18__recorder_sn_cond ) begin __auxvar18__recorder_sn_condmet <= 1'b1; __auxvar18__recorder_sn_vhold <= __auxvar18__recorder_sn_value; end
       __auxvar19__recorder <= __auxvar19__recorder;
       if (__auxvar19__recorder_sn_cond ) begin __auxvar19__recorder_sn_condmet <= 1'b1; __auxvar19__recorder_sn_vhold <= __auxvar19__recorder_sn_value; end
       __auxvar1__recorder <= __auxvar1__recorder;
       if (__auxvar1__recorder_sn_cond ) begin __auxvar1__recorder_sn_condmet <= 1'b1; __auxvar1__recorder_sn_vhold <= __auxvar1__recorder_sn_value; end
       __auxvar20__recorder <= __auxvar20__recorder;
       if (__auxvar20__recorder_sn_cond ) begin __auxvar20__recorder_sn_condmet <= 1'b1; __auxvar20__recorder_sn_vhold <= __auxvar20__recorder_sn_value; end
       __auxvar21__recorder <= __auxvar21__recorder;
       if (__auxvar21__recorder_sn_cond ) begin __auxvar21__recorder_sn_condmet <= 1'b1; __auxvar21__recorder_sn_vhold <= __auxvar21__recorder_sn_value; end
       __auxvar22__recorder <= __auxvar22__recorder;
       if (__auxvar22__recorder_sn_cond ) begin __auxvar22__recorder_sn_condmet <= 1'b1; __auxvar22__recorder_sn_vhold <= __auxvar22__recorder_sn_value; end
       __auxvar23__recorder <= __auxvar23__recorder;
       if (__auxvar23__recorder_sn_cond ) begin __auxvar23__recorder_sn_condmet <= 1'b1; __auxvar23__recorder_sn_vhold <= __auxvar23__recorder_sn_value; end
       __auxvar24__recorder <= __auxvar24__recorder;
       if (__auxvar24__recorder_sn_cond ) begin __auxvar24__recorder_sn_condmet <= 1'b1; __auxvar24__recorder_sn_vhold <= __auxvar24__recorder_sn_value; end
       __auxvar25__recorder <= __auxvar25__recorder;
       if (__auxvar25__recorder_sn_cond ) begin __auxvar25__recorder_sn_condmet <= 1'b1; __auxvar25__recorder_sn_vhold <= __auxvar25__recorder_sn_value; end
       __auxvar26__recorder <= __auxvar26__recorder;
       if (__auxvar26__recorder_sn_cond ) begin __auxvar26__recorder_sn_condmet <= 1'b1; __auxvar26__recorder_sn_vhold <= __auxvar26__recorder_sn_value; end
       __auxvar27__recorder <= __auxvar27__recorder;
       if (__auxvar27__recorder_sn_cond ) begin __auxvar27__recorder_sn_condmet <= 1'b1; __auxvar27__recorder_sn_vhold <= __auxvar27__recorder_sn_value; end
       __auxvar28__recorder <= __auxvar28__recorder;
       if (__auxvar28__recorder_sn_cond ) begin __auxvar28__recorder_sn_condmet <= 1'b1; __auxvar28__recorder_sn_vhold <= __auxvar28__recorder_sn_value; end
       __auxvar29__recorder <= __auxvar29__recorder;
       if (__auxvar29__recorder_sn_cond ) begin __auxvar29__recorder_sn_condmet <= 1'b1; __auxvar29__recorder_sn_vhold <= __auxvar29__recorder_sn_value; end
       __auxvar2__recorder <= __auxvar2__recorder;
       if (__auxvar2__recorder_sn_cond ) begin __auxvar2__recorder_sn_condmet <= 1'b1; __auxvar2__recorder_sn_vhold <= __auxvar2__recorder_sn_value; end
       __auxvar30__recorder <= __auxvar30__recorder;
       if (__auxvar30__recorder_sn_cond ) begin __auxvar30__recorder_sn_condmet <= 1'b1; __auxvar30__recorder_sn_vhold <= __auxvar30__recorder_sn_value; end
       __auxvar31__recorder <= __auxvar31__recorder;
       if (__auxvar31__recorder_sn_cond ) begin __auxvar31__recorder_sn_condmet <= 1'b1; __auxvar31__recorder_sn_vhold <= __auxvar31__recorder_sn_value; end
       __auxvar32__recorder <= __auxvar32__recorder;
       if (__auxvar32__recorder_sn_cond ) begin __auxvar32__recorder_sn_condmet <= 1'b1; __auxvar32__recorder_sn_vhold <= __auxvar32__recorder_sn_value; end
       __auxvar33__recorder <= __auxvar33__recorder;
       if (__auxvar33__recorder_sn_cond ) begin __auxvar33__recorder_sn_condmet <= 1'b1; __auxvar33__recorder_sn_vhold <= __auxvar33__recorder_sn_value; end
       __auxvar34__recorder <= __auxvar34__recorder;
       if (__auxvar34__recorder_sn_cond ) begin __auxvar34__recorder_sn_condmet <= 1'b1; __auxvar34__recorder_sn_vhold <= __auxvar34__recorder_sn_value; end
       __auxvar35__recorder <= __auxvar35__recorder;
       if (__auxvar35__recorder_sn_cond ) begin __auxvar35__recorder_sn_condmet <= 1'b1; __auxvar35__recorder_sn_vhold <= __auxvar35__recorder_sn_value; end
       __auxvar36__recorder <= __auxvar36__recorder;
       if (__auxvar36__recorder_sn_cond ) begin __auxvar36__recorder_sn_condmet <= 1'b1; __auxvar36__recorder_sn_vhold <= __auxvar36__recorder_sn_value; end
       __auxvar37__recorder <= __auxvar37__recorder;
       if (__auxvar37__recorder_sn_cond ) begin __auxvar37__recorder_sn_condmet <= 1'b1; __auxvar37__recorder_sn_vhold <= __auxvar37__recorder_sn_value; end
       __auxvar38__recorder <= __auxvar38__recorder;
       if (__auxvar38__recorder_sn_cond ) begin __auxvar38__recorder_sn_condmet <= 1'b1; __auxvar38__recorder_sn_vhold <= __auxvar38__recorder_sn_value; end
       __auxvar3__recorder <= __auxvar3__recorder;
       if (__auxvar3__recorder_sn_cond ) begin __auxvar3__recorder_sn_condmet <= 1'b1; __auxvar3__recorder_sn_vhold <= __auxvar3__recorder_sn_value; end
       __auxvar4__recorder <= __auxvar4__recorder;
       if (__auxvar4__recorder_sn_cond ) begin __auxvar4__recorder_sn_condmet <= 1'b1; __auxvar4__recorder_sn_vhold <= __auxvar4__recorder_sn_value; end
       __auxvar5__recorder <= __auxvar5__recorder;
       if (__auxvar5__recorder_sn_cond ) begin __auxvar5__recorder_sn_condmet <= 1'b1; __auxvar5__recorder_sn_vhold <= __auxvar5__recorder_sn_value; end
       __auxvar6__recorder <= __auxvar6__recorder;
       if (__auxvar6__recorder_sn_cond ) begin __auxvar6__recorder_sn_condmet <= 1'b1; __auxvar6__recorder_sn_vhold <= __auxvar6__recorder_sn_value; end
       __auxvar7__recorder <= __auxvar7__recorder;
       if (__auxvar7__recorder_sn_cond ) begin __auxvar7__recorder_sn_condmet <= 1'b1; __auxvar7__recorder_sn_vhold <= __auxvar7__recorder_sn_value; end
       __auxvar8__recorder <= __auxvar8__recorder;
       if (__auxvar8__recorder_sn_cond ) begin __auxvar8__recorder_sn_condmet <= 1'b1; __auxvar8__recorder_sn_vhold <= __auxvar8__recorder_sn_value; end
       __auxvar9__recorder <= __auxvar9__recorder;
       if (__auxvar9__recorder_sn_cond ) begin __auxvar9__recorder_sn_condmet <= 1'b1; __auxvar9__recorder_sn_vhold <= __auxvar9__recorder_sn_value; end
       __auxvar0__delay_d_1 <= __auxvar0__delay_d_0 ;
       if(monitor_s1_already_enter_cond) begin monitor_s1_already <= 1'b1;
       end
       else if(monitor_s1_already_exit_cond) begin monitor_s1_already <= 1'b0;
       end
       if(monitor_s2_enter_cond) begin monitor_s2 <= 1'b1;
       end
       else if(monitor_s2_exit_cond) begin monitor_s2 <= 1'b0;
       end
       if(monitor_s3_enter_cond) begin monitor_s3 <= 1'b1;
       end
       else if(monitor_s3_exit_cond) begin monitor_s3 <= 1'b0;
       end
       if(monitor_s4_enter_cond) begin monitor_s4 <= 1'b1;
       end
       else if(monitor_s4_exit_cond) begin monitor_s4 <= 1'b0;
       end
   end
end
endmodule
module riscv__DOT__ADD(
__START__,
clk,
inst,
rst,
__ILA_riscv_decode_of_ADD__,
__ILA_riscv_valid__,
pc,
load_en,
load_addr,
load_size,
load_data,
store_en,
store_addr,
store_size,
store_data,
x0,
x1,
x2,
x3,
x4,
x5,
x6,
x7,
x8,
x9,
x10,
x11,
x12,
x13,
x14,
x15,
x16,
x17,
x18,
x19,
x20,
x21,
x22,
x23,
x24,
x25,
x26,
x27,
x28,
x29,
x30,
x31,
__COUNTER_start__n11
);
input            __START__;
input            clk;
input     [31:0] inst;
input            rst;
output            __ILA_riscv_decode_of_ADD__;
output            __ILA_riscv_valid__;
output reg     [31:0] pc;
output reg            load_en;
output reg     [31:0] load_addr;
output reg      [2:0] load_size;
output reg     [31:0] load_data;
output reg            store_en;
output reg     [31:0] store_addr;
output reg      [2:0] store_size;
output reg     [31:0] store_data;
output reg     [31:0] x0;
output reg     [31:0] x1;
output reg     [31:0] x2;
output reg     [31:0] x3;
output reg     [31:0] x4;
output reg     [31:0] x5;
output reg     [31:0] x6;
output reg     [31:0] x7;
output reg     [31:0] x8;
output reg     [31:0] x9;
output reg     [31:0] x10;
output reg     [31:0] x11;
output reg     [31:0] x12;
output reg     [31:0] x13;
output reg     [31:0] x14;
output reg     [31:0] x15;
output reg     [31:0] x16;
output reg     [31:0] x17;
output reg     [31:0] x18;
output reg     [31:0] x19;
output reg     [31:0] x20;
output reg     [31:0] x21;
output reg     [31:0] x22;
output reg     [31:0] x23;
output reg     [31:0] x24;
output reg     [31:0] x25;
output reg     [31:0] x26;
output reg     [31:0] x27;
output reg     [31:0] x28;
output reg     [31:0] x29;
output reg     [31:0] x30;
output reg     [31:0] x31;
output reg      [7:0] __COUNTER_start__n11;
wire            __ILA_riscv_decode_of_ADD__;
wire            __ILA_riscv_valid__;
wire            __START__;
wire            bv_1_0_n14;
wire     [31:0] bv_32_0_n15;
wire     [31:0] bv_32_4_n12;
wire      [2:0] bv_3_0_n4;
wire      [4:0] bv_5_10_n62;
wire      [4:0] bv_5_11_n60;
wire      [4:0] bv_5_12_n58;
wire      [4:0] bv_5_13_n56;
wire      [4:0] bv_5_14_n54;
wire      [4:0] bv_5_15_n52;
wire      [4:0] bv_5_16_n50;
wire      [4:0] bv_5_17_n48;
wire      [4:0] bv_5_18_n46;
wire      [4:0] bv_5_19_n44;
wire      [4:0] bv_5_1_n17;
wire      [4:0] bv_5_20_n42;
wire      [4:0] bv_5_21_n40;
wire      [4:0] bv_5_22_n38;
wire      [4:0] bv_5_23_n36;
wire      [4:0] bv_5_24_n34;
wire      [4:0] bv_5_25_n32;
wire      [4:0] bv_5_26_n30;
wire      [4:0] bv_5_27_n28;
wire      [4:0] bv_5_28_n26;
wire      [4:0] bv_5_29_n24;
wire      [4:0] bv_5_2_n78;
wire      [4:0] bv_5_30_n22;
wire      [4:0] bv_5_31_n20;
wire      [4:0] bv_5_3_n76;
wire      [4:0] bv_5_4_n74;
wire      [4:0] bv_5_5_n72;
wire      [4:0] bv_5_6_n70;
wire      [4:0] bv_5_7_n68;
wire      [4:0] bv_5_8_n66;
wire      [4:0] bv_5_9_n64;
wire      [6:0] bv_7_0_n8;
wire      [6:0] bv_7_51_n1;
wire            clk;
wire     [31:0] inst;
 wire     [31:0] load_addr_randinit;
 wire     [31:0] load_data_randinit;
 wire            load_en_randinit;
 wire      [2:0] load_size_randinit;
wire      [6:0] n0;
wire            n10;
wire     [31:0] n100;
wire     [31:0] n101;
wire     [31:0] n102;
wire     [31:0] n103;
wire     [31:0] n104;
wire     [31:0] n105;
wire     [31:0] n106;
wire     [31:0] n107;
wire     [31:0] n108;
wire     [31:0] n109;
wire     [31:0] n110;
wire     [31:0] n111;
wire      [4:0] n112;
wire            n113;
wire            n114;
wire            n115;
wire            n116;
wire            n117;
wire            n118;
wire            n119;
wire            n120;
wire            n121;
wire            n122;
wire            n123;
wire            n124;
wire            n125;
wire            n126;
wire            n127;
wire            n128;
wire            n129;
wire     [31:0] n13;
wire            n130;
wire            n131;
wire            n132;
wire            n133;
wire            n134;
wire            n135;
wire            n136;
wire            n137;
wire            n138;
wire            n139;
wire            n140;
wire            n141;
wire            n142;
wire            n143;
wire     [31:0] n144;
wire     [31:0] n145;
wire     [31:0] n146;
wire     [31:0] n147;
wire     [31:0] n148;
wire     [31:0] n149;
wire     [31:0] n150;
wire     [31:0] n151;
wire     [31:0] n152;
wire     [31:0] n153;
wire     [31:0] n154;
wire     [31:0] n155;
wire     [31:0] n156;
wire     [31:0] n157;
wire     [31:0] n158;
wire     [31:0] n159;
wire      [4:0] n16;
wire     [31:0] n160;
wire     [31:0] n161;
wire     [31:0] n162;
wire     [31:0] n163;
wire     [31:0] n164;
wire     [31:0] n165;
wire     [31:0] n166;
wire     [31:0] n167;
wire     [31:0] n168;
wire     [31:0] n169;
wire     [31:0] n170;
wire     [31:0] n171;
wire     [31:0] n172;
wire     [31:0] n173;
wire     [31:0] n174;
wire     [31:0] n175;
wire     [31:0] n176;
wire            n177;
wire     [31:0] n178;
wire            n179;
wire            n18;
wire     [31:0] n180;
wire            n181;
wire     [31:0] n182;
wire            n183;
wire     [31:0] n184;
wire            n185;
wire     [31:0] n186;
wire            n187;
wire     [31:0] n188;
wire            n189;
wire      [4:0] n19;
wire     [31:0] n190;
wire            n191;
wire     [31:0] n192;
wire            n193;
wire     [31:0] n194;
wire            n195;
wire     [31:0] n196;
wire            n197;
wire     [31:0] n198;
wire            n199;
wire            n2;
wire     [31:0] n200;
wire            n201;
wire     [31:0] n202;
wire            n203;
wire     [31:0] n204;
wire            n205;
wire     [31:0] n206;
wire            n207;
wire     [31:0] n208;
wire            n209;
wire            n21;
wire     [31:0] n210;
wire            n211;
wire     [31:0] n212;
wire            n213;
wire     [31:0] n214;
wire            n215;
wire     [31:0] n216;
wire            n217;
wire     [31:0] n218;
wire            n219;
wire     [31:0] n220;
wire            n221;
wire     [31:0] n222;
wire            n223;
wire     [31:0] n224;
wire            n225;
wire     [31:0] n226;
wire            n227;
wire     [31:0] n228;
wire            n229;
wire            n23;
wire     [31:0] n230;
wire            n231;
wire     [31:0] n232;
wire            n233;
wire     [31:0] n234;
wire            n235;
wire     [31:0] n236;
wire            n25;
wire            n27;
wire            n29;
wire      [2:0] n3;
wire            n31;
wire            n33;
wire            n35;
wire            n37;
wire            n39;
wire            n41;
wire            n43;
wire            n45;
wire            n47;
wire            n49;
wire            n5;
wire            n51;
wire            n53;
wire            n55;
wire            n57;
wire            n59;
wire            n6;
wire            n61;
wire            n63;
wire            n65;
wire            n67;
wire            n69;
wire      [6:0] n7;
wire            n71;
wire            n73;
wire            n75;
wire            n77;
wire            n79;
wire            n80;
wire     [31:0] n81;
wire     [31:0] n82;
wire     [31:0] n83;
wire     [31:0] n84;
wire     [31:0] n85;
wire     [31:0] n86;
wire     [31:0] n87;
wire     [31:0] n88;
wire     [31:0] n89;
wire            n9;
wire     [31:0] n90;
wire     [31:0] n91;
wire     [31:0] n92;
wire     [31:0] n93;
wire     [31:0] n94;
wire     [31:0] n95;
wire     [31:0] n96;
wire     [31:0] n97;
wire     [31:0] n98;
wire     [31:0] n99;
 wire     [31:0] pc_randinit;
wire            rst;
 wire     [31:0] store_addr_randinit;
 wire     [31:0] store_data_randinit;
 wire            store_en_randinit;
 wire      [2:0] store_size_randinit;
 wire     [31:0] x0_randinit;
 wire     [31:0] x10_randinit;
 wire     [31:0] x11_randinit;
 wire     [31:0] x12_randinit;
 wire     [31:0] x13_randinit;
 wire     [31:0] x14_randinit;
 wire     [31:0] x15_randinit;
 wire     [31:0] x16_randinit;
 wire     [31:0] x17_randinit;
 wire     [31:0] x18_randinit;
 wire     [31:0] x19_randinit;
 wire     [31:0] x1_randinit;
 wire     [31:0] x20_randinit;
 wire     [31:0] x21_randinit;
 wire     [31:0] x22_randinit;
 wire     [31:0] x23_randinit;
 wire     [31:0] x24_randinit;
 wire     [31:0] x25_randinit;
 wire     [31:0] x26_randinit;
 wire     [31:0] x27_randinit;
 wire     [31:0] x28_randinit;
 wire     [31:0] x29_randinit;
 wire     [31:0] x2_randinit;
 wire     [31:0] x30_randinit;
 wire     [31:0] x31_randinit;
 wire     [31:0] x3_randinit;
 wire     [31:0] x4_randinit;
 wire     [31:0] x5_randinit;
 wire     [31:0] x6_randinit;
 wire     [31:0] x7_randinit;
 wire     [31:0] x8_randinit;
 wire     [31:0] x9_randinit;
assign __ILA_riscv_valid__ = 1'b1 ;
assign n0 = inst[6:0] ;
assign bv_7_51_n1 = 7'h33 ;
assign n2 =  ( n0 ) == ( bv_7_51_n1 )  ;
assign n3 = inst[14:12] ;
assign bv_3_0_n4 = 3'h0 ;
assign n5 =  ( n3 ) == ( bv_3_0_n4 )  ;
assign n6 =  ( n2 ) & (n5 )  ;
assign n7 = inst[31:25] ;
assign bv_7_0_n8 = 7'h0 ;
assign n9 =  ( n7 ) == ( bv_7_0_n8 )  ;
assign n10 =  ( n6 ) & (n9 )  ;
assign __ILA_riscv_decode_of_ADD__ = n10 ;
assign bv_32_4_n12 = 32'h4 ;
assign n13 =  ( pc ) + ( bv_32_4_n12 )  ;
assign bv_1_0_n14 = 1'h0 ;
assign bv_32_0_n15 = 32'h0 ;
assign n16 = inst[11:7] ;
assign bv_5_1_n17 = 5'h1 ;
assign n18 =  ( n16 ) == ( bv_5_1_n17 )  ;
assign n19 = inst[19:15] ;
assign bv_5_31_n20 = 5'h1f ;
assign n21 =  ( n19 ) == ( bv_5_31_n20 )  ;
assign bv_5_30_n22 = 5'h1e ;
assign n23 =  ( n19 ) == ( bv_5_30_n22 )  ;
assign bv_5_29_n24 = 5'h1d ;
assign n25 =  ( n19 ) == ( bv_5_29_n24 )  ;
assign bv_5_28_n26 = 5'h1c ;
assign n27 =  ( n19 ) == ( bv_5_28_n26 )  ;
assign bv_5_27_n28 = 5'h1b ;
assign n29 =  ( n19 ) == ( bv_5_27_n28 )  ;
assign bv_5_26_n30 = 5'h1a ;
assign n31 =  ( n19 ) == ( bv_5_26_n30 )  ;
assign bv_5_25_n32 = 5'h19 ;
assign n33 =  ( n19 ) == ( bv_5_25_n32 )  ;
assign bv_5_24_n34 = 5'h18 ;
assign n35 =  ( n19 ) == ( bv_5_24_n34 )  ;
assign bv_5_23_n36 = 5'h17 ;
assign n37 =  ( n19 ) == ( bv_5_23_n36 )  ;
assign bv_5_22_n38 = 5'h16 ;
assign n39 =  ( n19 ) == ( bv_5_22_n38 )  ;
assign bv_5_21_n40 = 5'h15 ;
assign n41 =  ( n19 ) == ( bv_5_21_n40 )  ;
assign bv_5_20_n42 = 5'h14 ;
assign n43 =  ( n19 ) == ( bv_5_20_n42 )  ;
assign bv_5_19_n44 = 5'h13 ;
assign n45 =  ( n19 ) == ( bv_5_19_n44 )  ;
assign bv_5_18_n46 = 5'h12 ;
assign n47 =  ( n19 ) == ( bv_5_18_n46 )  ;
assign bv_5_17_n48 = 5'h11 ;
assign n49 =  ( n19 ) == ( bv_5_17_n48 )  ;
assign bv_5_16_n50 = 5'h10 ;
assign n51 =  ( n19 ) == ( bv_5_16_n50 )  ;
assign bv_5_15_n52 = 5'hf ;
assign n53 =  ( n19 ) == ( bv_5_15_n52 )  ;
assign bv_5_14_n54 = 5'he ;
assign n55 =  ( n19 ) == ( bv_5_14_n54 )  ;
assign bv_5_13_n56 = 5'hd ;
assign n57 =  ( n19 ) == ( bv_5_13_n56 )  ;
assign bv_5_12_n58 = 5'hc ;
assign n59 =  ( n19 ) == ( bv_5_12_n58 )  ;
assign bv_5_11_n60 = 5'hb ;
assign n61 =  ( n19 ) == ( bv_5_11_n60 )  ;
assign bv_5_10_n62 = 5'ha ;
assign n63 =  ( n19 ) == ( bv_5_10_n62 )  ;
assign bv_5_9_n64 = 5'h9 ;
assign n65 =  ( n19 ) == ( bv_5_9_n64 )  ;
assign bv_5_8_n66 = 5'h8 ;
assign n67 =  ( n19 ) == ( bv_5_8_n66 )  ;
assign bv_5_7_n68 = 5'h7 ;
assign n69 =  ( n19 ) == ( bv_5_7_n68 )  ;
assign bv_5_6_n70 = 5'h6 ;
assign n71 =  ( n19 ) == ( bv_5_6_n70 )  ;
assign bv_5_5_n72 = 5'h5 ;
assign n73 =  ( n19 ) == ( bv_5_5_n72 )  ;
assign bv_5_4_n74 = 5'h4 ;
assign n75 =  ( n19 ) == ( bv_5_4_n74 )  ;
assign bv_5_3_n76 = 5'h3 ;
assign n77 =  ( n19 ) == ( bv_5_3_n76 )  ;
assign bv_5_2_n78 = 5'h2 ;
assign n79 =  ( n19 ) == ( bv_5_2_n78 )  ;
assign n80 =  ( n19 ) == ( bv_5_1_n17 )  ;
assign n81 =  ( n80 ) ? ( x1 ) : ( bv_32_0_n15 ) ;
assign n82 =  ( n79 ) ? ( x2 ) : ( n81 ) ;
assign n83 =  ( n77 ) ? ( x3 ) : ( n82 ) ;
assign n84 =  ( n75 ) ? ( x4 ) : ( n83 ) ;
assign n85 =  ( n73 ) ? ( x5 ) : ( n84 ) ;
assign n86 =  ( n71 ) ? ( x6 ) : ( n85 ) ;
assign n87 =  ( n69 ) ? ( x7 ) : ( n86 ) ;
assign n88 =  ( n67 ) ? ( x8 ) : ( n87 ) ;
assign n89 =  ( n65 ) ? ( x9 ) : ( n88 ) ;
assign n90 =  ( n63 ) ? ( x10 ) : ( n89 ) ;
assign n91 =  ( n61 ) ? ( x11 ) : ( n90 ) ;
assign n92 =  ( n59 ) ? ( x12 ) : ( n91 ) ;
assign n93 =  ( n57 ) ? ( x13 ) : ( n92 ) ;
assign n94 =  ( n55 ) ? ( x14 ) : ( n93 ) ;
assign n95 =  ( n53 ) ? ( x15 ) : ( n94 ) ;
assign n96 =  ( n51 ) ? ( x16 ) : ( n95 ) ;
assign n97 =  ( n49 ) ? ( x17 ) : ( n96 ) ;
assign n98 =  ( n47 ) ? ( x18 ) : ( n97 ) ;
assign n99 =  ( n45 ) ? ( x19 ) : ( n98 ) ;
assign n100 =  ( n43 ) ? ( x20 ) : ( n99 ) ;
assign n101 =  ( n41 ) ? ( x21 ) : ( n100 ) ;
assign n102 =  ( n39 ) ? ( x22 ) : ( n101 ) ;
assign n103 =  ( n37 ) ? ( x23 ) : ( n102 ) ;
assign n104 =  ( n35 ) ? ( x24 ) : ( n103 ) ;
assign n105 =  ( n33 ) ? ( x25 ) : ( n104 ) ;
assign n106 =  ( n31 ) ? ( x26 ) : ( n105 ) ;
assign n107 =  ( n29 ) ? ( x27 ) : ( n106 ) ;
assign n108 =  ( n27 ) ? ( x28 ) : ( n107 ) ;
assign n109 =  ( n25 ) ? ( x29 ) : ( n108 ) ;
assign n110 =  ( n23 ) ? ( x30 ) : ( n109 ) ;
assign n111 =  ( n21 ) ? ( x31 ) : ( n110 ) ;
assign n112 = inst[24:20] ;
assign n113 =  ( n112 ) == ( bv_5_31_n20 )  ;
assign n114 =  ( n112 ) == ( bv_5_30_n22 )  ;
assign n115 =  ( n112 ) == ( bv_5_29_n24 )  ;
assign n116 =  ( n112 ) == ( bv_5_28_n26 )  ;
assign n117 =  ( n112 ) == ( bv_5_27_n28 )  ;
assign n118 =  ( n112 ) == ( bv_5_26_n30 )  ;
assign n119 =  ( n112 ) == ( bv_5_25_n32 )  ;
assign n120 =  ( n112 ) == ( bv_5_24_n34 )  ;
assign n121 =  ( n112 ) == ( bv_5_23_n36 )  ;
assign n122 =  ( n112 ) == ( bv_5_22_n38 )  ;
assign n123 =  ( n112 ) == ( bv_5_21_n40 )  ;
assign n124 =  ( n112 ) == ( bv_5_20_n42 )  ;
assign n125 =  ( n112 ) == ( bv_5_19_n44 )  ;
assign n126 =  ( n112 ) == ( bv_5_18_n46 )  ;
assign n127 =  ( n112 ) == ( bv_5_17_n48 )  ;
assign n128 =  ( n112 ) == ( bv_5_16_n50 )  ;
assign n129 =  ( n112 ) == ( bv_5_15_n52 )  ;
assign n130 =  ( n112 ) == ( bv_5_14_n54 )  ;
assign n131 =  ( n112 ) == ( bv_5_13_n56 )  ;
assign n132 =  ( n112 ) == ( bv_5_12_n58 )  ;
assign n133 =  ( n112 ) == ( bv_5_11_n60 )  ;
assign n134 =  ( n112 ) == ( bv_5_10_n62 )  ;
assign n135 =  ( n112 ) == ( bv_5_9_n64 )  ;
assign n136 =  ( n112 ) == ( bv_5_8_n66 )  ;
assign n137 =  ( n112 ) == ( bv_5_7_n68 )  ;
assign n138 =  ( n112 ) == ( bv_5_6_n70 )  ;
assign n139 =  ( n112 ) == ( bv_5_5_n72 )  ;
assign n140 =  ( n112 ) == ( bv_5_4_n74 )  ;
assign n141 =  ( n112 ) == ( bv_5_3_n76 )  ;
assign n142 =  ( n112 ) == ( bv_5_2_n78 )  ;
assign n143 =  ( n112 ) == ( bv_5_1_n17 )  ;
assign n144 =  ( n143 ) ? ( x1 ) : ( bv_32_0_n15 ) ;
assign n145 =  ( n142 ) ? ( x2 ) : ( n144 ) ;
assign n146 =  ( n141 ) ? ( x3 ) : ( n145 ) ;
assign n147 =  ( n140 ) ? ( x4 ) : ( n146 ) ;
assign n148 =  ( n139 ) ? ( x5 ) : ( n147 ) ;
assign n149 =  ( n138 ) ? ( x6 ) : ( n148 ) ;
assign n150 =  ( n137 ) ? ( x7 ) : ( n149 ) ;
assign n151 =  ( n136 ) ? ( x8 ) : ( n150 ) ;
assign n152 =  ( n135 ) ? ( x9 ) : ( n151 ) ;
assign n153 =  ( n134 ) ? ( x10 ) : ( n152 ) ;
assign n154 =  ( n133 ) ? ( x11 ) : ( n153 ) ;
assign n155 =  ( n132 ) ? ( x12 ) : ( n154 ) ;
assign n156 =  ( n131 ) ? ( x13 ) : ( n155 ) ;
assign n157 =  ( n130 ) ? ( x14 ) : ( n156 ) ;
assign n158 =  ( n129 ) ? ( x15 ) : ( n157 ) ;
assign n159 =  ( n128 ) ? ( x16 ) : ( n158 ) ;
assign n160 =  ( n127 ) ? ( x17 ) : ( n159 ) ;
assign n161 =  ( n126 ) ? ( x18 ) : ( n160 ) ;
assign n162 =  ( n125 ) ? ( x19 ) : ( n161 ) ;
assign n163 =  ( n124 ) ? ( x20 ) : ( n162 ) ;
assign n164 =  ( n123 ) ? ( x21 ) : ( n163 ) ;
assign n165 =  ( n122 ) ? ( x22 ) : ( n164 ) ;
assign n166 =  ( n121 ) ? ( x23 ) : ( n165 ) ;
assign n167 =  ( n120 ) ? ( x24 ) : ( n166 ) ;
assign n168 =  ( n119 ) ? ( x25 ) : ( n167 ) ;
assign n169 =  ( n118 ) ? ( x26 ) : ( n168 ) ;
assign n170 =  ( n117 ) ? ( x27 ) : ( n169 ) ;
assign n171 =  ( n116 ) ? ( x28 ) : ( n170 ) ;
assign n172 =  ( n115 ) ? ( x29 ) : ( n171 ) ;
assign n173 =  ( n114 ) ? ( x30 ) : ( n172 ) ;
assign n174 =  ( n113 ) ? ( x31 ) : ( n173 ) ;
assign n175 =  ( n111 ) + ( n174 )  ;
assign n176 =  ( n18 ) ? ( n175 ) : ( x1 ) ;
assign n177 =  ( n16 ) == ( bv_5_2_n78 )  ;
assign n178 =  ( n177 ) ? ( n175 ) : ( x2 ) ;
assign n179 =  ( n16 ) == ( bv_5_3_n76 )  ;
assign n180 =  ( n179 ) ? ( n175 ) : ( x3 ) ;
assign n181 =  ( n16 ) == ( bv_5_4_n74 )  ;
assign n182 =  ( n181 ) ? ( n175 ) : ( x4 ) ;
assign n183 =  ( n16 ) == ( bv_5_5_n72 )  ;
assign n184 =  ( n183 ) ? ( n175 ) : ( x5 ) ;
assign n185 =  ( n16 ) == ( bv_5_6_n70 )  ;
assign n186 =  ( n185 ) ? ( n175 ) : ( x6 ) ;
assign n187 =  ( n16 ) == ( bv_5_7_n68 )  ;
assign n188 =  ( n187 ) ? ( n175 ) : ( x7 ) ;
assign n189 =  ( n16 ) == ( bv_5_8_n66 )  ;
assign n190 =  ( n189 ) ? ( n175 ) : ( x8 ) ;
assign n191 =  ( n16 ) == ( bv_5_9_n64 )  ;
assign n192 =  ( n191 ) ? ( n175 ) : ( x9 ) ;
assign n193 =  ( n16 ) == ( bv_5_10_n62 )  ;
assign n194 =  ( n193 ) ? ( n175 ) : ( x10 ) ;
assign n195 =  ( n16 ) == ( bv_5_11_n60 )  ;
assign n196 =  ( n195 ) ? ( n175 ) : ( x11 ) ;
assign n197 =  ( n16 ) == ( bv_5_12_n58 )  ;
assign n198 =  ( n197 ) ? ( n175 ) : ( x12 ) ;
assign n199 =  ( n16 ) == ( bv_5_13_n56 )  ;
assign n200 =  ( n199 ) ? ( n175 ) : ( x13 ) ;
assign n201 =  ( n16 ) == ( bv_5_14_n54 )  ;
assign n202 =  ( n201 ) ? ( n175 ) : ( x14 ) ;
assign n203 =  ( n16 ) == ( bv_5_15_n52 )  ;
assign n204 =  ( n203 ) ? ( n175 ) : ( x15 ) ;
assign n205 =  ( n16 ) == ( bv_5_16_n50 )  ;
assign n206 =  ( n205 ) ? ( n175 ) : ( x16 ) ;
assign n207 =  ( n16 ) == ( bv_5_17_n48 )  ;
assign n208 =  ( n207 ) ? ( n175 ) : ( x17 ) ;
assign n209 =  ( n16 ) == ( bv_5_18_n46 )  ;
assign n210 =  ( n209 ) ? ( n175 ) : ( x18 ) ;
assign n211 =  ( n16 ) == ( bv_5_19_n44 )  ;
assign n212 =  ( n211 ) ? ( n175 ) : ( x19 ) ;
assign n213 =  ( n16 ) == ( bv_5_20_n42 )  ;
assign n214 =  ( n213 ) ? ( n175 ) : ( x20 ) ;
assign n215 =  ( n16 ) == ( bv_5_21_n40 )  ;
assign n216 =  ( n215 ) ? ( n175 ) : ( x21 ) ;
assign n217 =  ( n16 ) == ( bv_5_22_n38 )  ;
assign n218 =  ( n217 ) ? ( n175 ) : ( x22 ) ;
assign n219 =  ( n16 ) == ( bv_5_23_n36 )  ;
assign n220 =  ( n219 ) ? ( n175 ) : ( x23 ) ;
assign n221 =  ( n16 ) == ( bv_5_24_n34 )  ;
assign n222 =  ( n221 ) ? ( n175 ) : ( x24 ) ;
assign n223 =  ( n16 ) == ( bv_5_25_n32 )  ;
assign n224 =  ( n223 ) ? ( n175 ) : ( x25 ) ;
assign n225 =  ( n16 ) == ( bv_5_26_n30 )  ;
assign n226 =  ( n225 ) ? ( n175 ) : ( x26 ) ;
assign n227 =  ( n16 ) == ( bv_5_27_n28 )  ;
assign n228 =  ( n227 ) ? ( n175 ) : ( x27 ) ;
assign n229 =  ( n16 ) == ( bv_5_28_n26 )  ;
assign n230 =  ( n229 ) ? ( n175 ) : ( x28 ) ;
assign n231 =  ( n16 ) == ( bv_5_29_n24 )  ;
assign n232 =  ( n231 ) ? ( n175 ) : ( x29 ) ;
assign n233 =  ( n16 ) == ( bv_5_30_n22 )  ;
assign n234 =  ( n233 ) ? ( n175 ) : ( x30 ) ;
assign n235 =  ( n16 ) == ( bv_5_31_n20 )  ;
assign n236 =  ( n235 ) ? ( n175 ) : ( x31 ) ;
always @(posedge clk) begin
   if(rst) begin
       pc <= pc_randinit ;
       load_en <= load_en_randinit ;
       load_addr <= load_addr_randinit ;
       load_size <= load_size_randinit ;
       load_data <= load_data_randinit ;
       store_en <= store_en_randinit ;
       store_addr <= store_addr_randinit ;
       store_size <= store_size_randinit ;
       store_data <= store_data_randinit ;
       x0 <= x0_randinit ;
       x1 <= x1_randinit ;
       x2 <= x2_randinit ;
       x3 <= x3_randinit ;
       x4 <= x4_randinit ;
       x5 <= x5_randinit ;
       x6 <= x6_randinit ;
       x7 <= x7_randinit ;
       x8 <= x8_randinit ;
       x9 <= x9_randinit ;
       x10 <= x10_randinit ;
       x11 <= x11_randinit ;
       x12 <= x12_randinit ;
       x13 <= x13_randinit ;
       x14 <= x14_randinit ;
       x15 <= x15_randinit ;
       x16 <= x16_randinit ;
       x17 <= x17_randinit ;
       x18 <= x18_randinit ;
       x19 <= x19_randinit ;
       x20 <= x20_randinit ;
       x21 <= x21_randinit ;
       x22 <= x22_randinit ;
       x23 <= x23_randinit ;
       x24 <= x24_randinit ;
       x25 <= x25_randinit ;
       x26 <= x26_randinit ;
       x27 <= x27_randinit ;
       x28 <= x28_randinit ;
       x29 <= x29_randinit ;
       x30 <= x30_randinit ;
       x31 <= x31_randinit ;
       __COUNTER_start__n11 <= 0;
   end
   else if(__START__ && __ILA_riscv_valid__) begin
       if ( __ILA_riscv_decode_of_ADD__ ) begin 
           __COUNTER_start__n11 <= 1; end
       else if( (__COUNTER_start__n11 >= 1 ) && ( __COUNTER_start__n11 < 255 )) begin
           __COUNTER_start__n11 <= __COUNTER_start__n11 + 1; end
       if (__ILA_riscv_decode_of_ADD__) begin
           pc <= n13 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           load_en <= bv_1_0_n14 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           load_addr <= load_addr ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           load_size <= load_size ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           load_data <= load_data ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           store_en <= bv_1_0_n14 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           store_addr <= store_addr ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           store_size <= store_size ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           store_data <= store_data ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x0 <= bv_32_0_n15 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x1 <= n176 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x2 <= n178 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x3 <= n180 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x4 <= n182 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x5 <= n184 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x6 <= n186 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x7 <= n188 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x8 <= n190 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x9 <= n192 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x10 <= n194 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x11 <= n196 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x12 <= n198 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x13 <= n200 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x14 <= n202 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x15 <= n204 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x16 <= n206 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x17 <= n208 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x18 <= n210 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x19 <= n212 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x20 <= n214 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x21 <= n216 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x22 <= n218 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x23 <= n220 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x24 <= n222 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x25 <= n224 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x26 <= n226 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x27 <= n228 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x28 <= n230 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x29 <= n232 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x30 <= n234 ;
       end
       if (__ILA_riscv_decode_of_ADD__) begin
           x31 <= n236 ;
       end
   end
end
endmodule

// Copyright (c) 2000-2012 Bluespec, Inc.

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// $Revision$
// $Date$



  






  
  






 



// Depth 2 FIFO  Data width 0
module FIFO20 #(parameter guarded = 1)(CLK,
              RST,
              ENQ,
              FULL_N,
              DEQ,
              EMPTY_N,
              CLR
              , RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__stage1_f_reset_rsps__DOT__full_reg, RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg, RTL__DOT__stage1_f_reset_reqs__DOT__full_reg, RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg, RTL__DOT__stage3_f_reset_reqs__DOT__full_reg, RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg, RTL__DOT__stage3_f_reset_rsps__DOT__full_reg, RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg, RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__stage2_f_reset_reqs__DOT__full_reg, RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg, RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg, RTL__DOT__stage2_f_reset_rsps__DOT__full_reg);
 input  RST;
   input  CLK;
   input  ENQ;
   input  CLR;
   input  DEQ;
 output  RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__stage1_f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__stage1_f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__stage3_f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__stage3_f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__stage2_f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__stage2_f_reset_rsps__DOT__full_reg;
 output FULL_N;
   output EMPTY_N;


   reg    empty_reg;
   reg    full_reg;

   assign FULL_N  = full_reg ;
   assign EMPTY_N = empty_reg ;










 // BSV_NO_INITIAL_BLOCKS

   always@(posedge CLK )
      begin
         if (RST == 1'b0)
           begin
              empty_reg <=  1'b0;
              full_reg  <=  1'b1;
           end // if (RST == `BSV_RESET_VALUE)
         else
           begin
              if (CLR)
                begin
                   empty_reg <=  1'b0;
                   full_reg  <=  1'b1;
                end
              else if (ENQ && !DEQ)
                begin
                   empty_reg <=  1'b1;
                   full_reg  <=  ! empty_reg;
                end // if (ENQ && !DEQ)
              else if (!ENQ && DEQ)
                begin
                   full_reg  <=  1'b1;
                   empty_reg <=  ! full_reg;
                end // if (!ENQ && DEQ)
           end // else: !if(RST == `BSV_RESET_VALUE)
      end // always@ (posedge CLK or `BSV_RESET_EDGE RST)

   // synopsys translate_off
   always@(posedge CLK)
     begin: error_checks
        reg deqerror, enqerror ;

        deqerror =  0;
        enqerror = 0;
        if (RST == ! 1'b0)
          begin
             if ( ! empty_reg && DEQ )
               begin
                  deqerror = 1 ;
                  $display( "Warning: FIFO20: %m -- Dequeuing from empty fifo" ) ;
               end
             if ( ! full_reg && ENQ && (!DEQ || guarded) )
               begin
                  enqerror =  1 ;
                  $display( "Warning: FIFO20: %m -- Enqueuing to a full fifo" ) ;
               end
          end // if (RST == ! `BSV_RESET_VALUE)
     end
   // synopsys translate_on

 assign RTL__DOT__stage2_f_reset_rsps__DOT__full_reg = full_reg;
 assign RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg = empty_reg;
 assign RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg = empty_reg;
 assign RTL__DOT__stage2_f_reset_reqs__DOT__full_reg = full_reg;
 assign RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg = full_reg;
 assign RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg = empty_reg;
 assign RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg = full_reg;
 assign RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg = empty_reg;
 assign RTL__DOT__stage3_f_reset_rsps__DOT__full_reg = full_reg;
 assign RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg = full_reg;
 assign RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg = empty_reg;
 assign RTL__DOT__stage3_f_reset_reqs__DOT__full_reg = full_reg;
 assign RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg = empty_reg;
 assign RTL__DOT__stage1_f_reset_reqs__DOT__full_reg = full_reg;
 assign RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg = empty_reg;
 assign RTL__DOT__stage1_f_reset_rsps__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg = empty_reg;
endmodule

// Copyright (c) 2000-2012 Bluespec, Inc.

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// $Revision$
// $Date$










  
  





 





 


// Depth 2 FIFO
module FIFO2 #(parameter width = 1,
   parameter guarded = 1)(CLK,
             RST,
             D_IN,
             ENQ,
             FULL_N,
             D_OUT,
             DEQ,
             EMPTY_N,
             CLR, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__f_reset_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg, RTL__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__f_reset_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg, RTL__DOT__f_reset_rsps__DOT__full_reg);
    input     CLK ;
   input     RST ;
   input [width - 1 : 0] D_IN;
   input                 ENQ;
   input                 DEQ;
   input                 CLR ;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__f_reset_rsps__DOT__full_reg;

   



   output                FULL_N;
   output                EMPTY_N;
   output [width - 1 : 0] D_OUT;


   reg                    full_reg;
   reg                    empty_reg;
   reg [width - 1 : 0]    data0_reg;
   reg [width - 1 : 0]    data1_reg;

   assign                 FULL_N = full_reg ;
   assign                 EMPTY_N = empty_reg ;
   assign                 D_OUT = data0_reg ;


   // Optimize the loading logic since state encoding is not power of 2!
   wire                   d0di = (ENQ && ! empty_reg ) || ( ENQ && DEQ && full_reg ) ;
   wire                   d0d1 = DEQ && ! full_reg ;
   wire                   d0h = ((! DEQ) && (! ENQ )) || (!DEQ && empty_reg ) || ( ! ENQ &&full_reg) ;
   wire                   d1di = ENQ & empty_reg ;












 // BSV_NO_INITIAL_BLOCKS

   always@(posedge CLK )
     begin
        if (RST == 1'b0)
          begin
             empty_reg <=  1'b0;
             full_reg  <=  1'b1;
          end // if (RST == `BSV_RESET_VALUE)
        else
          begin
             if (CLR)
               begin
                  empty_reg <=  1'b0;
                  full_reg  <=  1'b1;
               end // if (CLR)
             else if ( ENQ && ! DEQ ) // just enq
               begin
                  empty_reg <=  1'b1;
                  full_reg <=  ! empty_reg ;
               end
             else if ( DEQ && ! ENQ )
               begin
                  full_reg  <=  1'b1;
                  empty_reg <=  ! full_reg;
               end // if ( DEQ && ! ENQ )
          end // else: !if(RST == `BSV_RESET_VALUE)

     end // always@ (posedge CLK or `BSV_RESET_EDGE RST)


   always@(posedge CLK )
     begin








          begin
             data0_reg  <= 
                           {width{d0di}} & D_IN | {width{d0d1}} & data1_reg | {width{d0h}} & data0_reg ;
             data1_reg <= 
                          d1di ? D_IN : data1_reg ;
          end // else: !if(RST == `BSV_RESET_VALUE)
     end // always@ (posedge CLK or `BSV_RESET_EDGE RST)



   // synopsys translate_off
   always@(posedge CLK)
     begin: error_checks
        reg deqerror, enqerror ;

        deqerror =  0;
        enqerror = 0;
        if (RST == ! 1'b0)
          begin
             if ( ! empty_reg && DEQ )
               begin
                  deqerror =  1;
                  $display( "Warning: FIFO2: %m -- Dequeuing from empty fifo" ) ;
               end
             if ( ! full_reg && ENQ && (!DEQ || guarded) )
               begin
                  enqerror = 1;
                  $display( "Warning: FIFO2: %m -- Enqueuing to a full fifo" ) ;
               end
          end
     end // always@ (posedge CLK)
   // synopsys translate_on

 assign RTL__DOT__f_reset_rsps__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg = full_reg;
 assign RTL__DOT__f_reset_reqs__DOT__empty_reg = empty_reg;
 assign RTL__DOT__f_reset_rsps__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg = full_reg;
 assign RTL__DOT__f_reset_reqs__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg = empty_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg = full_reg;
 assign RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg = empty_reg;
endmodule
//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
//
//
//
// Ports:
// Name                         I/O  size props
// RDY_hart0_server_reset_request_put  O     1 reg
// hart0_server_reset_response_get  O     1 reg
// RDY_hart0_server_reset_response_get  O     1 reg
// imem_master_awvalid            O     1 reg
// imem_master_awid               O     4 reg
// imem_master_awaddr             O    64 reg
// imem_master_awlen              O     8 reg
// imem_master_awsize             O     3 reg
// imem_master_awburst            O     2 reg
// imem_master_awlock             O     1 reg
// imem_master_awcache            O     4 reg
// imem_master_awprot             O     3 reg
// imem_master_awqos              O     4 reg
// imem_master_awregion           O     4 reg
// imem_master_wvalid             O     1 reg
// imem_master_wdata              O    64 reg
// imem_master_wstrb              O     8 reg
// imem_master_wlast              O     1 reg
// imem_master_bready             O     1 reg
// imem_master_arvalid            O     1 reg
// imem_master_arid               O     4 reg
// imem_master_araddr             O    64 reg
// imem_master_arlen              O     8 reg
// imem_master_arsize             O     3 reg
// imem_master_arburst            O     2 reg
// imem_master_arlock             O     1 reg
// imem_master_arcache            O     4 reg
// imem_master_arprot             O     3 reg
// imem_master_arqos              O     4 reg
// imem_master_arregion           O     4 reg
// imem_master_rready             O     1 reg
// dmem_master_awvalid            O     1 reg
// dmem_master_awid               O     4 reg
// dmem_master_awaddr             O    64 reg
// dmem_master_awlen              O     8 reg
// dmem_master_awsize             O     3 reg
// dmem_master_awburst            O     2 reg
// dmem_master_awlock             O     1 reg
// dmem_master_awcache            O     4 reg
// dmem_master_awprot             O     3 reg
// dmem_master_awqos              O     4 reg
// dmem_master_awregion           O     4 reg
// dmem_master_wvalid             O     1 reg
// dmem_master_wdata              O    64 reg
// dmem_master_wstrb              O     8 reg
// dmem_master_wlast              O     1 reg
// dmem_master_bready             O     1 reg
// dmem_master_arvalid            O     1 reg
// dmem_master_arid               O     4 reg
// dmem_master_araddr             O    64 reg
// dmem_master_arlen              O     8 reg
// dmem_master_arsize             O     3 reg
// dmem_master_arburst            O     2 reg
// dmem_master_arlock             O     1 reg
// dmem_master_arcache            O     4 reg
// dmem_master_arprot             O     3 reg
// dmem_master_arqos              O     4 reg
// dmem_master_arregion           O     4 reg
// dmem_master_rready             O     1 reg
// RDY_set_verbosity              O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// hart0_server_reset_request_put  I     1 reg
// imem_master_awready            I     1
// imem_master_wready             I     1
// imem_master_bvalid             I     1
// imem_master_bid                I     4 reg
// imem_master_bresp              I     2 reg
// imem_master_arready            I     1
// imem_master_rvalid             I     1
// imem_master_rid                I     4 reg
// imem_master_rdata              I    64 reg
// imem_master_rresp              I     2 reg
// imem_master_rlast              I     1 reg
// dmem_master_awready            I     1
// dmem_master_wready             I     1
// dmem_master_bvalid             I     1
// dmem_master_bid                I     4 reg
// dmem_master_bresp              I     2 reg
// dmem_master_arready            I     1
// dmem_master_rvalid             I     1
// dmem_master_rid                I     4 reg
// dmem_master_rdata              I    64 reg
// dmem_master_rresp              I     2 reg
// dmem_master_rlast              I     1 reg
// m_external_interrupt_req_set_not_clear  I     1 reg
// s_external_interrupt_req_set_not_clear  I     1 reg
// software_interrupt_req_set_not_clear  I     1 reg
// timer_interrupt_req_set_not_clear  I     1 reg
// nmi_req_set_not_clear          I     1
// set_verbosity_verbosity        I     4 reg
// set_verbosity_logdelay         I    64 reg
// EN_hart0_server_reset_request_put  I     1
// EN_set_verbosity               I     1
// EN_hart0_server_reset_response_get  I     1
//
// No combinational paths from inputs to outputs
//
//










  
  


module mkCPU(CLK,
	     RST_N,

	     hart0_server_reset_request_put,
	     EN_hart0_server_reset_request_put,
	     RDY_hart0_server_reset_request_put,

	     EN_hart0_server_reset_response_get,
	     hart0_server_reset_response_get,
	     RDY_hart0_server_reset_response_get,

	     imem_master_awvalid,

	     imem_master_awid,

	     imem_master_awaddr,

	     imem_master_awlen,

	     imem_master_awsize,

	     imem_master_awburst,

	     imem_master_awlock,

	     imem_master_awcache,

	     imem_master_awprot,

	     imem_master_awqos,

	     imem_master_awregion,

	     imem_master_awready,

	     imem_master_wvalid,

	     imem_master_wdata,

	     imem_master_wstrb,

	     imem_master_wlast,

	     imem_master_wready,

	     imem_master_bvalid,
	     imem_master_bid,
	     imem_master_bresp,

	     imem_master_bready,

	     imem_master_arvalid,

	     imem_master_arid,

	     imem_master_araddr,

	     imem_master_arlen,

	     imem_master_arsize,

	     imem_master_arburst,

	     imem_master_arlock,

	     imem_master_arcache,

	     imem_master_arprot,

	     imem_master_arqos,

	     imem_master_arregion,

	     imem_master_arready,

	     imem_master_rvalid,
	     imem_master_rid,
	     imem_master_rdata,
	     imem_master_rresp,
	     imem_master_rlast,

	     imem_master_rready,

	     dmem_master_awvalid,

	     dmem_master_awid,

	     dmem_master_awaddr,

	     dmem_master_awlen,

	     dmem_master_awsize,

	     dmem_master_awburst,

	     dmem_master_awlock,

	     dmem_master_awcache,

	     dmem_master_awprot,

	     dmem_master_awqos,

	     dmem_master_awregion,

	     dmem_master_awready,

	     dmem_master_wvalid,

	     dmem_master_wdata,

	     dmem_master_wstrb,

	     dmem_master_wlast,

	     dmem_master_wready,

	     dmem_master_bvalid,
	     dmem_master_bid,
	     dmem_master_bresp,

	     dmem_master_bready,

	     dmem_master_arvalid,

	     dmem_master_arid,

	     dmem_master_araddr,

	     dmem_master_arlen,

	     dmem_master_arsize,

	     dmem_master_arburst,

	     dmem_master_arlock,

	     dmem_master_arcache,

	     dmem_master_arprot,

	     dmem_master_arqos,

	     dmem_master_arregion,

	     dmem_master_arready,

	     dmem_master_rvalid,
	     dmem_master_rid,
	     dmem_master_rdata,
	     dmem_master_rresp,
	     dmem_master_rlast,

	     dmem_master_rready,

	     m_external_interrupt_req_set_not_clear,

	     s_external_interrupt_req_set_not_clear,

	     software_interrupt_req_set_not_clear,

	     timer_interrupt_req_set_not_clear,

	     nmi_req_set_not_clear,

	     set_verbosity_verbosity,
	     set_verbosity_logdelay,
	     EN_set_verbosity,
	     RDY_set_verbosity, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg, RTL__DOT__near_mem$dmem_req_op, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__rg_trap_instr, RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg, RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__near_mem$dmem_req_store_value, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg, RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg, RTL__DOT__near_mem$dmem_word64, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_, RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg, RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg, RTL__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg, RTL__DOT__s1_to_s2$D_IN, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_, RTL__DOT__stage2_rg_full, RTL__DOT__csr_regfile__DOT__rg_state, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg, RTL__DOT__stage1_rg_full, RTL__DOT__stage1_f_reset_rsps__DOT__full_reg, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_, RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg, RTL__DOT__stage1_f_reset_reqs__DOT__full_reg, RTL__DOT__rg_run_on_reset, RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg, RTL__DOT__stage3_f_reset_reqs__DOT__full_reg, RTL__DOT__s2_to_s3$EN, RTL__DOT__near_mem$dmem_req_f3, RTL__DOT__s1_to_s2$EN, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_, RTL__DOT__s3_deq$EN, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__rg_state, RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__rg_retiring$EN, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg, RTL__DOT__s2_to_s3$D_IN, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_, RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg, RTL__DOT__stage2_f_reset_rsps__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg, RTL__DOT__stage3_f_reset_rsps__DOT__full_reg, RTL__DOT__stage3_rg_full, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_, RTL__DOT__stage2_rg_stage2, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_, RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__csr_regfile__DOT__rg_nmi, RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa, RTL__DOT__near_mem$EN_dmem_req, RTL__DOT__stage2_f_reset_reqs__DOT__full_reg, RTL__DOT__rg_cur_priv, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_, RTL__DOT__f_reset_reqs__DOT__empty_reg, RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg, RTL__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg, RTL__DOT__near_mem$dmem_req_addr, RTL__DOT__near_mem$imem_instr, RTL__DOT__f_reset_reqs__DOT__full_reg, RTL__DOT__near_mem$imem_pc, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__near_mem$dmem_exc, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg, RTL__DOT__s3_deq$D_IN);
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg;
 output  RTL__DOT__near_mem$dmem_req_op;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg;
 output [31:0] RTL__DOT__rg_trap_instr;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg;
 output  RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg;
 output [63:0] RTL__DOT__near_mem$dmem_req_store_value;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg;
 output [63:0] RTL__DOT__near_mem$dmem_word64;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_;
 output [31:0] RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg;
 output  RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__s1_to_s2$D_IN;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_;
 output  RTL__DOT__stage2_rg_full;
 output  RTL__DOT__csr_regfile__DOT__rg_state;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg;
 output  RTL__DOT__stage1_rg_full;
 output  RTL__DOT__stage1_f_reset_rsps__DOT__full_reg;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_;
 output  RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg;
 output  RTL__DOT__stage1_f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__rg_run_on_reset;
 output  RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__stage3_f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__s2_to_s3$EN;
 output [2:0] RTL__DOT__near_mem$dmem_req_f3;
 output  RTL__DOT__s1_to_s2$EN;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_;
 output  RTL__DOT__s3_deq$EN;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg;
 output [3:0] RTL__DOT__rg_state;
 output  RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__rg_retiring$EN;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg;
 output  RTL__DOT__s2_to_s3$D_IN;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_;
 output  RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg;
 output  RTL__DOT__stage2_f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg;
 output  RTL__DOT__stage3_f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__stage3_rg_full;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_;
 output [168:0] RTL__DOT__stage2_rg_stage2;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_;
 output  RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__csr_regfile__DOT__rg_nmi;
 output [31:0] RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa;
 output  RTL__DOT__near_mem$EN_dmem_req;
 output  RTL__DOT__stage2_f_reset_reqs__DOT__full_reg;
 output [1:0] RTL__DOT__rg_cur_priv;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_;
 output  RTL__DOT__f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__f_reset_rsps__DOT__empty_reg;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg;
 output [31:0] RTL__DOT__near_mem$dmem_req_addr;
 output [31:0] RTL__DOT__near_mem$imem_instr;
 output  RTL__DOT__f_reset_reqs__DOT__full_reg;
 output [31:0] RTL__DOT__near_mem$imem_pc;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__near_mem$dmem_exc;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg;
 output  RTL__DOT__s3_deq$D_IN;
  input  CLK;
  input  RST_N;

  // action method hart0_server_reset_request_put
  input  hart0_server_reset_request_put;
  input  EN_hart0_server_reset_request_put;
  output RDY_hart0_server_reset_request_put;

  // actionvalue method hart0_server_reset_response_get
  input  EN_hart0_server_reset_response_get;
  output hart0_server_reset_response_get;
  output RDY_hart0_server_reset_response_get;

  // value method imem_master_m_awvalid
  output imem_master_awvalid;

  // value method imem_master_m_awid
  output [3 : 0] imem_master_awid;

  // value method imem_master_m_awaddr
  output [63 : 0] imem_master_awaddr;

  // value method imem_master_m_awlen
  output [7 : 0] imem_master_awlen;

  // value method imem_master_m_awsize
  output [2 : 0] imem_master_awsize;

  // value method imem_master_m_awburst
  output [1 : 0] imem_master_awburst;

  // value method imem_master_m_awlock
  output imem_master_awlock;

  // value method imem_master_m_awcache
  output [3 : 0] imem_master_awcache;

  // value method imem_master_m_awprot
  output [2 : 0] imem_master_awprot;

  // value method imem_master_m_awqos
  output [3 : 0] imem_master_awqos;

  // value method imem_master_m_awregion
  output [3 : 0] imem_master_awregion;

  // value method imem_master_m_awuser

  // action method imem_master_m_awready
  input  imem_master_awready;

  // value method imem_master_m_wvalid
  output imem_master_wvalid;

  // value method imem_master_m_wdata
  output [63 : 0] imem_master_wdata;

  // value method imem_master_m_wstrb
  output [7 : 0] imem_master_wstrb;

  // value method imem_master_m_wlast
  output imem_master_wlast;

  // value method imem_master_m_wuser

  // action method imem_master_m_wready
  input  imem_master_wready;

  // action method imem_master_m_bvalid
  input  imem_master_bvalid;
  input  [3 : 0] imem_master_bid;
  input  [1 : 0] imem_master_bresp;

  // value method imem_master_m_bready
  output imem_master_bready;

  // value method imem_master_m_arvalid
  output imem_master_arvalid;

  // value method imem_master_m_arid
  output [3 : 0] imem_master_arid;

  // value method imem_master_m_araddr
  output [63 : 0] imem_master_araddr;

  // value method imem_master_m_arlen
  output [7 : 0] imem_master_arlen;

  // value method imem_master_m_arsize
  output [2 : 0] imem_master_arsize;

  // value method imem_master_m_arburst
  output [1 : 0] imem_master_arburst;

  // value method imem_master_m_arlock
  output imem_master_arlock;

  // value method imem_master_m_arcache
  output [3 : 0] imem_master_arcache;

  // value method imem_master_m_arprot
  output [2 : 0] imem_master_arprot;

  // value method imem_master_m_arqos
  output [3 : 0] imem_master_arqos;

  // value method imem_master_m_arregion
  output [3 : 0] imem_master_arregion;

  // value method imem_master_m_aruser

  // action method imem_master_m_arready
  input  imem_master_arready;

  // action method imem_master_m_rvalid
  input  imem_master_rvalid;
  input  [3 : 0] imem_master_rid;
  input  [63 : 0] imem_master_rdata;
  input  [1 : 0] imem_master_rresp;
  input  imem_master_rlast;

  // value method imem_master_m_rready
  output imem_master_rready;

  // value method dmem_master_m_awvalid
  output dmem_master_awvalid;

  // value method dmem_master_m_awid
  output [3 : 0] dmem_master_awid;

  // value method dmem_master_m_awaddr
  output [63 : 0] dmem_master_awaddr;

  // value method dmem_master_m_awlen
  output [7 : 0] dmem_master_awlen;

  // value method dmem_master_m_awsize
  output [2 : 0] dmem_master_awsize;

  // value method dmem_master_m_awburst
  output [1 : 0] dmem_master_awburst;

  // value method dmem_master_m_awlock
  output dmem_master_awlock;

  // value method dmem_master_m_awcache
  output [3 : 0] dmem_master_awcache;

  // value method dmem_master_m_awprot
  output [2 : 0] dmem_master_awprot;

  // value method dmem_master_m_awqos
  output [3 : 0] dmem_master_awqos;

  // value method dmem_master_m_awregion
  output [3 : 0] dmem_master_awregion;

  // value method dmem_master_m_awuser

  // action method dmem_master_m_awready
  input  dmem_master_awready;

  // value method dmem_master_m_wvalid
  output dmem_master_wvalid;

  // value method dmem_master_m_wdata
  output [63 : 0] dmem_master_wdata;

  // value method dmem_master_m_wstrb
  output [7 : 0] dmem_master_wstrb;

  // value method dmem_master_m_wlast
  output dmem_master_wlast;

  // value method dmem_master_m_wuser

  // action method dmem_master_m_wready
  input  dmem_master_wready;

  // action method dmem_master_m_bvalid
  input  dmem_master_bvalid;
  input  [3 : 0] dmem_master_bid;
  input  [1 : 0] dmem_master_bresp;

  // value method dmem_master_m_bready
  output dmem_master_bready;

  // value method dmem_master_m_arvalid
  output dmem_master_arvalid;

  // value method dmem_master_m_arid
  output [3 : 0] dmem_master_arid;

  // value method dmem_master_m_araddr
  output [63 : 0] dmem_master_araddr;

  // value method dmem_master_m_arlen
  output [7 : 0] dmem_master_arlen;

  // value method dmem_master_m_arsize
  output [2 : 0] dmem_master_arsize;

  // value method dmem_master_m_arburst
  output [1 : 0] dmem_master_arburst;

  // value method dmem_master_m_arlock
  output dmem_master_arlock;

  // value method dmem_master_m_arcache
  output [3 : 0] dmem_master_arcache;

  // value method dmem_master_m_arprot
  output [2 : 0] dmem_master_arprot;

  // value method dmem_master_m_arqos
  output [3 : 0] dmem_master_arqos;

  // value method dmem_master_m_arregion
  output [3 : 0] dmem_master_arregion;

  // value method dmem_master_m_aruser

  // action method dmem_master_m_arready
  input  dmem_master_arready;

  // action method dmem_master_m_rvalid
  input  dmem_master_rvalid;
  input  [3 : 0] dmem_master_rid;
  input  [63 : 0] dmem_master_rdata;
  input  [1 : 0] dmem_master_rresp;
  input  dmem_master_rlast;

  // value method dmem_master_m_rready
  output dmem_master_rready;

  // action method m_external_interrupt_req
  input  m_external_interrupt_req_set_not_clear;

  // action method s_external_interrupt_req
  input  s_external_interrupt_req_set_not_clear;

  // action method software_interrupt_req
  input  software_interrupt_req_set_not_clear;

  // action method timer_interrupt_req
  input  timer_interrupt_req_set_not_clear;

  // action method nmi_req
  input  nmi_req_set_not_clear;

  // action method set_verbosity
  input  [3 : 0] set_verbosity_verbosity;
  input  [63 : 0] set_verbosity_logdelay;
  input  EN_set_verbosity;
  output RDY_set_verbosity;

  // signals for module outputs
  wire [63 : 0] dmem_master_araddr,
		dmem_master_awaddr,
		dmem_master_wdata,
		imem_master_araddr,
		imem_master_awaddr,
		imem_master_wdata;
  wire [7 : 0] dmem_master_arlen,
	       dmem_master_awlen,
	       dmem_master_wstrb,
	       imem_master_arlen,
	       imem_master_awlen,
	       imem_master_wstrb;
  wire [3 : 0] dmem_master_arcache,
	       dmem_master_arid,
	       dmem_master_arqos,
	       dmem_master_arregion,
	       dmem_master_awcache,
	       dmem_master_awid,
	       dmem_master_awqos,
	       dmem_master_awregion,
	       imem_master_arcache,
	       imem_master_arid,
	       imem_master_arqos,
	       imem_master_arregion,
	       imem_master_awcache,
	       imem_master_awid,
	       imem_master_awqos,
	       imem_master_awregion;
  wire [2 : 0] dmem_master_arprot,
	       dmem_master_arsize,
	       dmem_master_awprot,
	       dmem_master_awsize,
	       imem_master_arprot,
	       imem_master_arsize,
	       imem_master_awprot,
	       imem_master_awsize;
  wire [1 : 0] dmem_master_arburst,
	       dmem_master_awburst,
	       imem_master_arburst,
	       imem_master_awburst;
  wire RDY_hart0_server_reset_request_put,
       RDY_hart0_server_reset_response_get,
       RDY_set_verbosity,
       dmem_master_arlock,
       dmem_master_arvalid,
       dmem_master_awlock,
       dmem_master_awvalid,
       dmem_master_bready,
       dmem_master_rready,
       dmem_master_wlast,
       dmem_master_wvalid,
       hart0_server_reset_response_get,
       imem_master_arlock,
       imem_master_arvalid,
       imem_master_awlock,
       imem_master_awvalid,
       imem_master_bready,
       imem_master_rready,
       imem_master_wlast,
       imem_master_wvalid;

  // register cfg_logdelay
  reg [63 : 0] cfg_logdelay;
  wire [63 : 0] cfg_logdelay$D_IN;
  wire cfg_logdelay$EN;

  // register cfg_verbosity
  reg [3 : 0] cfg_verbosity;
  wire [3 : 0] cfg_verbosity$D_IN;
  wire cfg_verbosity$EN;

  // register rg_csr_pc
  reg [31 : 0] rg_csr_pc;
  wire [31 : 0] rg_csr_pc$D_IN;
  wire rg_csr_pc$EN;

  // register rg_csr_val1
  reg [31 : 0] rg_csr_val1;
  wire [31 : 0] rg_csr_val1$D_IN;
  wire rg_csr_val1$EN;

  // register rg_cur_priv
  reg [1 : 0] rg_cur_priv;
  reg [1 : 0] rg_cur_priv$D_IN;
  wire rg_cur_priv$EN;

  // register rg_mstatus_MXR
  reg rg_mstatus_MXR;
  wire rg_mstatus_MXR$D_IN, rg_mstatus_MXR$EN;

  // register rg_next_pc
  reg [31 : 0] rg_next_pc;
  reg [31 : 0] rg_next_pc$D_IN;
  wire rg_next_pc$EN;

  // register rg_retiring
  reg rg_retiring;
  wire rg_retiring$D_IN, rg_retiring$EN;

  // register rg_run_on_reset
  reg rg_run_on_reset;
  wire rg_run_on_reset$D_IN, rg_run_on_reset$EN;

  // register rg_sstatus_SUM
  reg rg_sstatus_SUM;
  wire rg_sstatus_SUM$D_IN, rg_sstatus_SUM$EN;

  // register rg_start_CPI_cycles
  reg [63 : 0] rg_start_CPI_cycles;
  wire [63 : 0] rg_start_CPI_cycles$D_IN;
  wire rg_start_CPI_cycles$EN;

  // register rg_start_CPI_instrs
  reg [63 : 0] rg_start_CPI_instrs;
  wire [63 : 0] rg_start_CPI_instrs$D_IN;
  wire rg_start_CPI_instrs$EN;

  // register rg_state
  reg [3 : 0] rg_state;
  reg [3 : 0] rg_state$D_IN;
  wire rg_state$EN;

  // register rg_trap_info
  reg [67 : 0] rg_trap_info;
  reg [67 : 0] rg_trap_info$D_IN;
  wire rg_trap_info$EN;

  // register rg_trap_instr
  reg [31 : 0] rg_trap_instr;
  wire [31 : 0] rg_trap_instr$D_IN;
  wire rg_trap_instr$EN;

  // register rg_trap_interrupt
  reg rg_trap_interrupt;
  wire rg_trap_interrupt$D_IN, rg_trap_interrupt$EN;

  // register s1_to_s2
  reg s1_to_s2;
  wire s1_to_s2$D_IN, s1_to_s2$EN;

  // register s2_to_s3
  reg s2_to_s3;
  wire s2_to_s3$D_IN, s2_to_s3$EN;

  // register s3_deq
  reg s3_deq;
  wire s3_deq$D_IN, s3_deq$EN;

  // register stage1_rg_full
  reg stage1_rg_full;
  reg stage1_rg_full$D_IN;
  wire stage1_rg_full$EN;

  // register stage2_rg_full
  reg stage2_rg_full;
  reg stage2_rg_full$D_IN;
  wire stage2_rg_full$EN;

  // register stage2_rg_resetting
  reg stage2_rg_resetting;
  wire stage2_rg_resetting$D_IN, stage2_rg_resetting$EN;

  // register stage2_rg_stage2
  reg [168 : 0] stage2_rg_stage2;
  wire [168 : 0] stage2_rg_stage2$D_IN;
  wire stage2_rg_stage2$EN;

  // register stage3_rg_full
  reg stage3_rg_full;
  reg stage3_rg_full$D_IN;
  wire stage3_rg_full$EN;

  // register stage3_rg_stage3
  reg [103 : 0] stage3_rg_stage3;
  wire [103 : 0] stage3_rg_stage3$D_IN;
  wire stage3_rg_stage3$EN;

  // ports of submodule csr_regfile
  reg [1 : 0] csr_regfile$csr_ret_actions_from_priv;
  wire [97 : 0] csr_regfile$csr_trap_actions;
  wire [65 : 0] csr_regfile$csr_ret_actions;
  wire [63 : 0] csr_regfile$read_csr_mcycle, csr_regfile$read_csr_minstret;
  wire [32 : 0] csr_regfile$read_csr;
  wire [31 : 0] csr_regfile$csr_trap_actions_pc,
		csr_regfile$csr_trap_actions_xtval,
		csr_regfile$mav_csr_write_word,
		csr_regfile$read_mstatus,
		csr_regfile$read_satp;
  wire [27 : 0] csr_regfile$read_misa;
  wire [11 : 0] csr_regfile$access_permitted_1_csr_addr,
		csr_regfile$access_permitted_2_csr_addr,
		csr_regfile$csr_counter_read_fault_csr_addr,
		csr_regfile$mav_csr_write_csr_addr,
		csr_regfile$mav_read_csr_csr_addr,
		csr_regfile$read_csr_csr_addr,
		csr_regfile$read_csr_port2_csr_addr;
  wire [4 : 0] csr_regfile$interrupt_pending;
  wire [3 : 0] csr_regfile$csr_trap_actions_exc_code;
  wire [1 : 0] csr_regfile$access_permitted_1_priv,
	       csr_regfile$access_permitted_2_priv,
	       csr_regfile$csr_counter_read_fault_priv,
	       csr_regfile$csr_trap_actions_from_priv,
	       csr_regfile$interrupt_pending_cur_priv;
  wire csr_regfile$EN_csr_minstret_incr,
       csr_regfile$EN_csr_ret_actions,
       csr_regfile$EN_csr_trap_actions,
       csr_regfile$EN_debug,
       csr_regfile$EN_mav_csr_write,
       csr_regfile$EN_mav_read_csr,
       csr_regfile$EN_server_reset_request_put,
       csr_regfile$EN_server_reset_response_get,
       csr_regfile$RDY_server_reset_request_put,
       csr_regfile$RDY_server_reset_response_get,
       csr_regfile$access_permitted_1,
       csr_regfile$access_permitted_1_read_not_write,
       csr_regfile$access_permitted_2,
       csr_regfile$access_permitted_2_read_not_write,
       csr_regfile$csr_trap_actions_interrupt,
       csr_regfile$csr_trap_actions_nmi,
       csr_regfile$m_external_interrupt_req_set_not_clear,
       csr_regfile$nmi_pending,
       csr_regfile$nmi_req_set_not_clear,
       csr_regfile$s_external_interrupt_req_set_not_clear,
       csr_regfile$software_interrupt_req_set_not_clear,
       csr_regfile$timer_interrupt_req_set_not_clear,
       csr_regfile$wfi_resume;

  // ports of submodule f_reset_reqs
  wire f_reset_reqs$CLR,
       f_reset_reqs$DEQ,
       f_reset_reqs$D_IN,
       f_reset_reqs$D_OUT,
       f_reset_reqs$EMPTY_N,
       f_reset_reqs$ENQ,
       f_reset_reqs$FULL_N;

  // ports of submodule f_reset_rsps
  wire f_reset_rsps$CLR,
       f_reset_rsps$DEQ,
       f_reset_rsps$D_IN,
       f_reset_rsps$D_OUT,
       f_reset_rsps$EMPTY_N,
       f_reset_rsps$ENQ,
       f_reset_rsps$FULL_N;

  // ports of submodule gpr_regfile
  wire [31 : 0] gpr_regfile$read_rs1,
		gpr_regfile$read_rs2,
		gpr_regfile$write_rd_rd_val;
  wire [4 : 0] gpr_regfile$read_rs1_port2_rs1,
	       gpr_regfile$read_rs1_rs1,
	       gpr_regfile$read_rs2_rs2,
	       gpr_regfile$write_rd_rd;
  wire gpr_regfile$EN_server_reset_request_put,
       gpr_regfile$EN_server_reset_response_get,
       gpr_regfile$EN_write_rd,
       gpr_regfile$RDY_server_reset_request_put,
       gpr_regfile$RDY_server_reset_response_get;

  // ports of submodule near_mem
  reg [31 : 0] near_mem$imem_req_addr;
  wire [63 : 0] near_mem$dmem_master_araddr,
		near_mem$dmem_master_awaddr,
		near_mem$dmem_master_rdata,
		near_mem$dmem_master_wdata,
		near_mem$dmem_req_store_value,
		near_mem$dmem_word64,
		near_mem$imem_master_araddr,
		near_mem$imem_master_awaddr,
		near_mem$imem_master_rdata,
		near_mem$imem_master_wdata;
  wire [31 : 0] near_mem$dmem_req_addr,
		near_mem$dmem_req_satp,
		near_mem$imem_instr,
		near_mem$imem_pc,
		near_mem$imem_req_satp,
		near_mem$imem_tval;
  wire [7 : 0] near_mem$dmem_master_arlen,
	       near_mem$dmem_master_awlen,
	       near_mem$dmem_master_wstrb,
	       near_mem$imem_master_arlen,
	       near_mem$imem_master_awlen,
	       near_mem$imem_master_wstrb,
	       near_mem$server_fence_request_put;
  wire [3 : 0] near_mem$dmem_exc_code,
	       near_mem$dmem_master_arcache,
	       near_mem$dmem_master_arid,
	       near_mem$dmem_master_arqos,
	       near_mem$dmem_master_arregion,
	       near_mem$dmem_master_awcache,
	       near_mem$dmem_master_awid,
	       near_mem$dmem_master_awqos,
	       near_mem$dmem_master_awregion,
	       near_mem$dmem_master_bid,
	       near_mem$dmem_master_rid,
	       near_mem$imem_exc_code,
	       near_mem$imem_master_arcache,
	       near_mem$imem_master_arid,
	       near_mem$imem_master_arqos,
	       near_mem$imem_master_arregion,
	       near_mem$imem_master_awcache,
	       near_mem$imem_master_awid,
	       near_mem$imem_master_awqos,
	       near_mem$imem_master_awregion,
	       near_mem$imem_master_bid,
	       near_mem$imem_master_rid;
  wire [2 : 0] near_mem$dmem_master_arprot,
	       near_mem$dmem_master_arsize,
	       near_mem$dmem_master_awprot,
	       near_mem$dmem_master_awsize,
	       near_mem$dmem_req_f3,
	       near_mem$imem_master_arprot,
	       near_mem$imem_master_arsize,
	       near_mem$imem_master_awprot,
	       near_mem$imem_master_awsize,
	       near_mem$imem_req_f3;
  wire [1 : 0] near_mem$dmem_master_arburst,
	       near_mem$dmem_master_awburst,
	       near_mem$dmem_master_bresp,
	       near_mem$dmem_master_rresp,
	       near_mem$dmem_req_priv,
	       near_mem$imem_master_arburst,
	       near_mem$imem_master_awburst,
	       near_mem$imem_master_bresp,
	       near_mem$imem_master_rresp,
	       near_mem$imem_req_priv;
  wire near_mem$EN_dmem_req,
       near_mem$EN_imem_req,
       near_mem$EN_server_fence_i_request_put,
       near_mem$EN_server_fence_i_response_get,
       near_mem$EN_server_fence_request_put,
       near_mem$EN_server_fence_response_get,
       near_mem$EN_server_reset_request_put,
       near_mem$EN_server_reset_response_get,
       near_mem$EN_sfence_vma,
       near_mem$RDY_server_fence_i_request_put,
       near_mem$RDY_server_fence_i_response_get,
       near_mem$RDY_server_fence_request_put,
       near_mem$RDY_server_fence_response_get,
       near_mem$RDY_server_reset_request_put,
       near_mem$RDY_server_reset_response_get,
       near_mem$dmem_exc,
       near_mem$dmem_master_arlock,
       near_mem$dmem_master_arready,
       near_mem$dmem_master_arvalid,
       near_mem$dmem_master_awlock,
       near_mem$dmem_master_awready,
       near_mem$dmem_master_awvalid,
       near_mem$dmem_master_bready,
       near_mem$dmem_master_bvalid,
       near_mem$dmem_master_rlast,
       near_mem$dmem_master_rready,
       near_mem$dmem_master_rvalid,
       near_mem$dmem_master_wlast,
       near_mem$dmem_master_wready,
       near_mem$dmem_master_wvalid,
       near_mem$dmem_req_mstatus_MXR,
       near_mem$dmem_req_op,
       near_mem$dmem_req_sstatus_SUM,
       near_mem$dmem_valid,
       near_mem$imem_exc,
       near_mem$imem_is_i32_not_i16,
       near_mem$imem_master_arlock,
       near_mem$imem_master_arready,
       near_mem$imem_master_arvalid,
       near_mem$imem_master_awlock,
       near_mem$imem_master_awready,
       near_mem$imem_master_awvalid,
       near_mem$imem_master_bready,
       near_mem$imem_master_bvalid,
       near_mem$imem_master_rlast,
       near_mem$imem_master_rready,
       near_mem$imem_master_rvalid,
       near_mem$imem_master_wlast,
       near_mem$imem_master_wready,
       near_mem$imem_master_wvalid,
       near_mem$imem_req_mstatus_MXR,
       near_mem$imem_req_sstatus_SUM,
       near_mem$imem_valid;

  // ports of submodule soc_map
  wire [63 : 0] soc_map$m_is_IO_addr_addr,
		soc_map$m_is_mem_addr_addr,
		soc_map$m_is_near_mem_IO_addr_addr,
		soc_map$m_pc_reset_value;

  // ports of submodule stage1_f_reset_reqs
  wire stage1_f_reset_reqs$CLR,
       stage1_f_reset_reqs$DEQ,
       stage1_f_reset_reqs$EMPTY_N,
       stage1_f_reset_reqs$ENQ,
       stage1_f_reset_reqs$FULL_N;

  // ports of submodule stage1_f_reset_rsps
  wire stage1_f_reset_rsps$CLR,
       stage1_f_reset_rsps$DEQ,
       stage1_f_reset_rsps$EMPTY_N,
       stage1_f_reset_rsps$ENQ,
       stage1_f_reset_rsps$FULL_N;

  // ports of submodule stage2_f_reset_reqs
  wire stage2_f_reset_reqs$CLR,
       stage2_f_reset_reqs$DEQ,
       stage2_f_reset_reqs$EMPTY_N,
       stage2_f_reset_reqs$ENQ,
       stage2_f_reset_reqs$FULL_N;

  // ports of submodule stage2_f_reset_rsps
  wire stage2_f_reset_rsps$CLR,
       stage2_f_reset_rsps$DEQ,
       stage2_f_reset_rsps$EMPTY_N,
       stage2_f_reset_rsps$ENQ,
       stage2_f_reset_rsps$FULL_N;

  // ports of submodule stage3_f_reset_reqs
  wire stage3_f_reset_reqs$CLR,
       stage3_f_reset_reqs$DEQ,
       stage3_f_reset_reqs$EMPTY_N,
       stage3_f_reset_reqs$ENQ,
       stage3_f_reset_reqs$FULL_N;

  // ports of submodule stage3_f_reset_rsps
  wire stage3_f_reset_rsps$CLR,
       stage3_f_reset_rsps$DEQ,
       stage3_f_reset_rsps$EMPTY_N,
       stage3_f_reset_rsps$ENQ,
       stage3_f_reset_rsps$FULL_N;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_WFI_resume,
       CAN_FIRE_RL_rl_finish_FENCE,
       CAN_FIRE_RL_rl_finish_FENCE_I,
       CAN_FIRE_RL_rl_finish_SFENCE_VMA,
       CAN_FIRE_RL_rl_pipe,
       CAN_FIRE_RL_rl_reset_complete,
       CAN_FIRE_RL_rl_reset_from_WFI,
       CAN_FIRE_RL_rl_reset_start,
       CAN_FIRE_RL_rl_show_pipe,
       CAN_FIRE_RL_rl_stage1_CSRR_S_or_C,
       CAN_FIRE_RL_rl_stage1_CSRR_S_or_C_2,
       CAN_FIRE_RL_rl_stage1_CSRR_W,
       CAN_FIRE_RL_rl_stage1_CSRR_W_2,
       CAN_FIRE_RL_rl_stage1_FENCE,
       CAN_FIRE_RL_rl_stage1_FENCE_I,
       CAN_FIRE_RL_rl_stage1_SFENCE_VMA,
       CAN_FIRE_RL_rl_stage1_WFI,
       CAN_FIRE_RL_rl_stage1_interrupt,
       CAN_FIRE_RL_rl_stage1_restart_after_csrrx,
       CAN_FIRE_RL_rl_stage1_trap,
       CAN_FIRE_RL_rl_stage1_xRET,
       CAN_FIRE_RL_rl_stage2_nonpipe,
       CAN_FIRE_RL_rl_trap,
       CAN_FIRE_RL_rl_trap_fetch,
       CAN_FIRE_RL_stage1_rl_reset,
       CAN_FIRE_RL_stage2_rl_reset_begin,
       CAN_FIRE_RL_stage2_rl_reset_end,
       CAN_FIRE_RL_stage3_rl_reset,
       CAN_FIRE_dmem_master_m_arready,
       CAN_FIRE_dmem_master_m_awready,
       CAN_FIRE_dmem_master_m_bvalid,
       CAN_FIRE_dmem_master_m_rvalid,
       CAN_FIRE_dmem_master_m_wready,
       CAN_FIRE_hart0_server_reset_request_put,
       CAN_FIRE_hart0_server_reset_response_get,
       CAN_FIRE_imem_master_m_arready,
       CAN_FIRE_imem_master_m_awready,
       CAN_FIRE_imem_master_m_bvalid,
       CAN_FIRE_imem_master_m_rvalid,
       CAN_FIRE_imem_master_m_wready,
       CAN_FIRE_m_external_interrupt_req,
       CAN_FIRE_nmi_req,
       CAN_FIRE_s_external_interrupt_req,
       CAN_FIRE_set_verbosity,
       CAN_FIRE_software_interrupt_req,
       CAN_FIRE_timer_interrupt_req,
       WILL_FIRE_RL_rl_WFI_resume,
       WILL_FIRE_RL_rl_finish_FENCE,
       WILL_FIRE_RL_rl_finish_FENCE_I,
       WILL_FIRE_RL_rl_finish_SFENCE_VMA,
       WILL_FIRE_RL_rl_pipe,
       WILL_FIRE_RL_rl_reset_complete,
       WILL_FIRE_RL_rl_reset_from_WFI,
       WILL_FIRE_RL_rl_reset_start,
       WILL_FIRE_RL_rl_show_pipe,
       WILL_FIRE_RL_rl_stage1_CSRR_S_or_C,
       WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2,
       WILL_FIRE_RL_rl_stage1_CSRR_W,
       WILL_FIRE_RL_rl_stage1_CSRR_W_2,
       WILL_FIRE_RL_rl_stage1_FENCE,
       WILL_FIRE_RL_rl_stage1_FENCE_I,
       WILL_FIRE_RL_rl_stage1_SFENCE_VMA,
       WILL_FIRE_RL_rl_stage1_WFI,
       WILL_FIRE_RL_rl_stage1_interrupt,
       WILL_FIRE_RL_rl_stage1_restart_after_csrrx,
       WILL_FIRE_RL_rl_stage1_trap,
       WILL_FIRE_RL_rl_stage1_xRET,
       WILL_FIRE_RL_rl_stage2_nonpipe,
       WILL_FIRE_RL_rl_trap,
       WILL_FIRE_RL_rl_trap_fetch,
       WILL_FIRE_RL_stage1_rl_reset,
       WILL_FIRE_RL_stage2_rl_reset_begin,
       WILL_FIRE_RL_stage2_rl_reset_end,
       WILL_FIRE_RL_stage3_rl_reset,
       WILL_FIRE_dmem_master_m_arready,
       WILL_FIRE_dmem_master_m_awready,
       WILL_FIRE_dmem_master_m_bvalid,
       WILL_FIRE_dmem_master_m_rvalid,
       WILL_FIRE_dmem_master_m_wready,
       WILL_FIRE_hart0_server_reset_request_put,
       WILL_FIRE_hart0_server_reset_response_get,
       WILL_FIRE_imem_master_m_arready,
       WILL_FIRE_imem_master_m_awready,
       WILL_FIRE_imem_master_m_bvalid,
       WILL_FIRE_imem_master_m_rvalid,
       WILL_FIRE_imem_master_m_wready,
       WILL_FIRE_m_external_interrupt_req,
       WILL_FIRE_nmi_req,
       WILL_FIRE_s_external_interrupt_req,
       WILL_FIRE_set_verbosity,
       WILL_FIRE_software_interrupt_req,
       WILL_FIRE_timer_interrupt_req;

  // inputs to muxes for submodule ports
  reg [31 : 0] MUX_csr_regfile$mav_csr_write_2__VAL_2;
  wire [67 : 0] MUX_rg_trap_info$write_1__VAL_1,
		MUX_rg_trap_info$write_1__VAL_2,
		MUX_rg_trap_info$write_1__VAL_3,
		MUX_rg_trap_info$write_1__VAL_4;
  wire [3 : 0] MUX_rg_state$write_1__VAL_1,
	       MUX_rg_state$write_1__VAL_2,
	       MUX_rg_state$write_1__VAL_3;
  wire MUX_csr_regfile$mav_csr_write_1__SEL_1,
       MUX_gpr_regfile$write_rd_1__SEL_3,
       MUX_near_mem$imem_req_1__SEL_1,
       MUX_near_mem$imem_req_1__SEL_2,
       MUX_near_mem$imem_req_1__SEL_5,
       MUX_rg_next_pc$write_1__SEL_1,
       MUX_rg_retiring$write_1__SEL_1,
       MUX_rg_state$write_1__SEL_1,
       MUX_rg_state$write_1__SEL_10,
       MUX_rg_state$write_1__SEL_4,
       MUX_rg_state$write_1__SEL_6,
       MUX_rg_state$write_1__SEL_7,
       MUX_rg_state$write_1__SEL_8,
       MUX_rg_state$write_1__SEL_9,
       MUX_rg_trap_info$write_1__SEL_1,
       MUX_rg_trap_instr$write_1__SEL_1,
       MUX_rg_trap_interrupt$write_1__SEL_1,
       MUX_s1_to_s2$write_1__VAL_1,
       MUX_stage1_rg_full$write_1__VAL_10,
       MUX_stage2_rg_full$write_1__VAL_3;

  // remaining internal signals
  reg [31 : 0] IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d570,
	       _theResult_____1_fst__h6569,
	       rs1_val__h11920,
	       x_out_data_to_stage2_addr__h5223,
	       x_out_data_to_stage2_val1__h5224,
	       x_out_data_to_stage3_rd_val__h4668;
  reg [4 : 0] x_out_data_to_stage3_rd__h4667;
  reg [3 : 0] CASE_near_memimem_instr_BITS_14_TO_12_0b0_0_0_ETC__q10,
	      CASE_near_memimem_instr_BITS_14_TO_12_0b0_0_0_ETC__q12,
	      CASE_near_memimem_instr_BITS_14_TO_12_0b0_4_0_ETC__q11,
	      CASE_near_memimem_instr_BITS_14_TO_12_0b0_IF__ETC__q13,
	      CASE_near_memimem_instr_BITS_31_TO_20_0b0_CAS_ETC__q4,
	      CASE_rg_cur_priv_0b0_8_0b1_9_11__q3,
	      IF_near_mem_imem_instr__59_BITS_31_TO_20_02_EQ_ETC___d396,
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d409,
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d413,
	      alu_outputs_exc_code__h5862;
  reg [1 : 0] CASE_stage2_rg_stage2_BITS_102_TO_101_0_2_1_IF_ETC__q5,
	      IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491;
  reg CASE_near_memimem_instr_BITS_6_TO_0_0b10011_N_ETC__q8,
      CASE_near_memimem_instr_BITS_6_TO_0_0b10011_n_ETC__q9,
      IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227,
      IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291,
      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308,
      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352;
  wire [127 : 0] csr_regfile_read_csr_mcycle__8_MINUS_rg_start__ETC___d818;
  wire [63 : 0] _theResult____h10743,
		cpi__h10745,
		cpifrac__h10746,
		delta_CPI_cycles__h10741,
		delta_CPI_instrs___1__h10778,
		delta_CPI_instrs__h10742,
		x__h10744;
  wire [35 : 0] IF_near_mem_imem_exc__78_THEN_near_mem_imem_ex_ETC___d799;
  wire [31 : 0] IF_IF_near_mem_imem_instr__59_BITS_6_TO_0_79_E_ETC___d655,
		IF_csr_regfile_read_csr_rg_trap_instr_15_BITS__ETC___d868,
		IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d571,
		SEXT_near_mem_imem_instr__59_BITS_31_TO_20_02___d303,
		_theResult_____1_fst__h6562,
		_theResult_____1_fst__h6597,
		_theResult___snd__h7382,
		alu_outputs___1_addr__h5365,
		alu_outputs___1_addr__h5385,
		alu_outputs___1_addr__h5410,
		alu_outputs___1_addr__h5583,
		alu_outputs___1_val1__h5386,
		alu_outputs___1_val1__h5480,
		alu_outputs___1_val1__h5516,
		alu_outputs___1_val1__h5847,
		alu_outputs___1_val2__h5367,
		data_to_stage2_addr__h5215,
		eaddr__h5553,
		fall_through_pc__h5175,
		output_stage2___1_bypass_rd_val__h4960,
		rd_val___1__h6550,
		rd_val___1__h6558,
		rd_val___1__h6565,
		rd_val___1__h6572,
		rd_val___1__h6579,
		rd_val___1__h6586,
		rd_val__h5072,
		rd_val__h5132,
		rd_val__h5523,
		rd_val__h5537,
		rd_val__h7278,
		rd_val__h7330,
		rd_val__h7352,
		rs1_val__h11213,
		rs1_val_bypassed__h3337,
		rs2_val__h5339,
		trap_info_tval__h6925,
		val__h5074,
		val__h5134,
		value__h6967,
		x_out_bypass_rd_val__h4969,
		x_out_data_to_stage2_val2__h5225,
		x_out_next_pc__h5189,
		y__h12191;
  wire [20 : 0] near_memimem_instr_BIT_31_CONCAT_near_memime_ETC__q2;
  wire [12 : 0] near_memimem_instr_BIT_31_CONCAT_near_memime_ETC__q1;
  wire [11 : 0] near_memimem_instr_BITS_31_TO_20__q7,
		near_memimem_instr_BITS_31_TO_25_CONCAT_near__ETC__q6;
  wire [4 : 0] shamt__h5467, x_out_data_to_stage2_rd__h5222;
  wire [3 : 0] IF_NOT_near_mem_imem_instr__59_BITS_14_TO_12_8_ETC___d362,
	       IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415,
	       IF_rg_cur_priv_9_EQ_0b11_75_OR_rg_cur_priv_9_E_ETC___d394,
	       alu_outputs___1_exc_code__h5362,
	       alu_outputs___1_exc_code__h5843,
	       cur_verbosity__h1827,
	       x_exc_code__h15410,
	       x_out_trap_info_exc_code__h6928;
  wire [1 : 0] IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d142,
	       IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86,
	       IF_stage2_rg_stage2_4_BITS_100_TO_96_13_EQ_0_3_ETC___d137,
	       IF_stage2_rg_stage2_4_BITS_102_TO_101_5_EQ_0_6_ETC___d85;
  wire IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d285,
       IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d216,
       IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d218,
       IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d220,
       IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274,
       IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343,
       IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d649,
       IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d910,
       IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d161,
       IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d163,
       NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17,
       NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d730,
       NOT_IF_stage2_rg_full_3_THEN_IF_stage2_rg_stag_ETC___d109,
       NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d716,
       NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d734,
       NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737,
       NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d756,
       NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d769,
       NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d773,
       NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d776,
       NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d790,
       NOT_near_mem_imem_exc__78_13_AND_IF_near_mem_i_ETC___d481,
       NOT_near_mem_imem_instr__59_BITS_14_TO_12_81_E_ETC___d252,
       NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166,
       NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d702,
       NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d713,
       _0_OR_0_OR_near_mem_imem_exc__78_OR_IF_near_mem_ETC___d767,
       csr_regfile_interrupt_pending_rg_cur_priv_9_07_ETC___d779,
       gpr_regfile_RDY_server_reset_request_put__59_A_ETC___d671,
       gpr_regfile_RDY_server_reset_response_get__76__ETC___d688,
       near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d578,
       near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d581,
       near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d584,
       near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d587,
       near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d590,
       near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d593,
       near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d596,
       near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d599,
       near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d602,
       near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d605,
       near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d608,
       near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d611,
       near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_0b_ETC___d328,
       near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_0b_ETC___d616,
       near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177,
       near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311,
       near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355,
       rg_cur_priv_9_EQ_0b11_75_OR_rg_cur_priv_9_EQ_0_ETC___d392,
       rg_state_8_EQ_3_97_AND_NOT_csr_regfile_interru_ETC___d793,
       rg_trap_info_04_BITS_67_TO_36_05_EQ_csr_regfil_ETC___d814;

  // action method hart0_server_reset_request_put
  assign RDY_hart0_server_reset_request_put = f_reset_reqs$FULL_N ;
  assign CAN_FIRE_hart0_server_reset_request_put = f_reset_reqs$FULL_N ;
  assign WILL_FIRE_hart0_server_reset_request_put =
	     EN_hart0_server_reset_request_put ;

  // actionvalue method hart0_server_reset_response_get
  assign hart0_server_reset_response_get = f_reset_rsps$D_OUT ;
  assign RDY_hart0_server_reset_response_get = f_reset_rsps$EMPTY_N ;
  assign CAN_FIRE_hart0_server_reset_response_get = f_reset_rsps$EMPTY_N ;
  assign WILL_FIRE_hart0_server_reset_response_get =
	     EN_hart0_server_reset_response_get ;

  // value method imem_master_m_awvalid
  assign imem_master_awvalid = near_mem$imem_master_awvalid ;

  // value method imem_master_m_awid
  assign imem_master_awid = near_mem$imem_master_awid ;

  // value method imem_master_m_awaddr
  assign imem_master_awaddr = near_mem$imem_master_awaddr ;

  // value method imem_master_m_awlen
  assign imem_master_awlen = near_mem$imem_master_awlen ;

  // value method imem_master_m_awsize
  assign imem_master_awsize = near_mem$imem_master_awsize ;

  // value method imem_master_m_awburst
  assign imem_master_awburst = near_mem$imem_master_awburst ;

  // value method imem_master_m_awlock
  assign imem_master_awlock = near_mem$imem_master_awlock ;

  // value method imem_master_m_awcache
  assign imem_master_awcache = near_mem$imem_master_awcache ;

  // value method imem_master_m_awprot
  assign imem_master_awprot = near_mem$imem_master_awprot ;

  // value method imem_master_m_awqos
  assign imem_master_awqos = near_mem$imem_master_awqos ;

  // value method imem_master_m_awregion
  assign imem_master_awregion = near_mem$imem_master_awregion ;

  // action method imem_master_m_awready
  assign CAN_FIRE_imem_master_m_awready = 1'd1 ;
  assign WILL_FIRE_imem_master_m_awready = 1'd1 ;

  // value method imem_master_m_wvalid
  assign imem_master_wvalid = near_mem$imem_master_wvalid ;

  // value method imem_master_m_wdata
  assign imem_master_wdata = near_mem$imem_master_wdata ;

  // value method imem_master_m_wstrb
  assign imem_master_wstrb = near_mem$imem_master_wstrb ;

  // value method imem_master_m_wlast
  assign imem_master_wlast = near_mem$imem_master_wlast ;

  // action method imem_master_m_wready
  assign CAN_FIRE_imem_master_m_wready = 1'd1 ;
  assign WILL_FIRE_imem_master_m_wready = 1'd1 ;

  // action method imem_master_m_bvalid
  assign CAN_FIRE_imem_master_m_bvalid = 1'd1 ;
  assign WILL_FIRE_imem_master_m_bvalid = 1'd1 ;

  // value method imem_master_m_bready
  assign imem_master_bready = near_mem$imem_master_bready ;

  // value method imem_master_m_arvalid
  assign imem_master_arvalid = near_mem$imem_master_arvalid ;

  // value method imem_master_m_arid
  assign imem_master_arid = near_mem$imem_master_arid ;

  // value method imem_master_m_araddr
  assign imem_master_araddr = near_mem$imem_master_araddr ;

  // value method imem_master_m_arlen
  assign imem_master_arlen = near_mem$imem_master_arlen ;

  // value method imem_master_m_arsize
  assign imem_master_arsize = near_mem$imem_master_arsize ;

  // value method imem_master_m_arburst
  assign imem_master_arburst = near_mem$imem_master_arburst ;

  // value method imem_master_m_arlock
  assign imem_master_arlock = near_mem$imem_master_arlock ;

  // value method imem_master_m_arcache
  assign imem_master_arcache = near_mem$imem_master_arcache ;

  // value method imem_master_m_arprot
  assign imem_master_arprot = near_mem$imem_master_arprot ;

  // value method imem_master_m_arqos
  assign imem_master_arqos = near_mem$imem_master_arqos ;

  // value method imem_master_m_arregion
  assign imem_master_arregion = near_mem$imem_master_arregion ;

  // action method imem_master_m_arready
  assign CAN_FIRE_imem_master_m_arready = 1'd1 ;
  assign WILL_FIRE_imem_master_m_arready = 1'd1 ;

  // action method imem_master_m_rvalid
  assign CAN_FIRE_imem_master_m_rvalid = 1'd1 ;
  assign WILL_FIRE_imem_master_m_rvalid = 1'd1 ;

  // value method imem_master_m_rready
  assign imem_master_rready = near_mem$imem_master_rready ;

  // value method dmem_master_m_awvalid
  assign dmem_master_awvalid = near_mem$dmem_master_awvalid ;

  // value method dmem_master_m_awid
  assign dmem_master_awid = near_mem$dmem_master_awid ;

  // value method dmem_master_m_awaddr
  assign dmem_master_awaddr = near_mem$dmem_master_awaddr ;

  // value method dmem_master_m_awlen
  assign dmem_master_awlen = near_mem$dmem_master_awlen ;

  // value method dmem_master_m_awsize
  assign dmem_master_awsize = near_mem$dmem_master_awsize ;

  // value method dmem_master_m_awburst
  assign dmem_master_awburst = near_mem$dmem_master_awburst ;

  // value method dmem_master_m_awlock
  assign dmem_master_awlock = near_mem$dmem_master_awlock ;

  // value method dmem_master_m_awcache
  assign dmem_master_awcache = near_mem$dmem_master_awcache ;

  // value method dmem_master_m_awprot
  assign dmem_master_awprot = near_mem$dmem_master_awprot ;

  // value method dmem_master_m_awqos
  assign dmem_master_awqos = near_mem$dmem_master_awqos ;

  // value method dmem_master_m_awregion
  assign dmem_master_awregion = near_mem$dmem_master_awregion ;

  // action method dmem_master_m_awready
  assign CAN_FIRE_dmem_master_m_awready = 1'd1 ;
  assign WILL_FIRE_dmem_master_m_awready = 1'd1 ;

  // value method dmem_master_m_wvalid
  assign dmem_master_wvalid = near_mem$dmem_master_wvalid ;

  // value method dmem_master_m_wdata
  assign dmem_master_wdata = near_mem$dmem_master_wdata ;

  // value method dmem_master_m_wstrb
  assign dmem_master_wstrb = near_mem$dmem_master_wstrb ;

  // value method dmem_master_m_wlast
  assign dmem_master_wlast = near_mem$dmem_master_wlast ;

  // action method dmem_master_m_wready
  assign CAN_FIRE_dmem_master_m_wready = 1'd1 ;
  assign WILL_FIRE_dmem_master_m_wready = 1'd1 ;

  // action method dmem_master_m_bvalid
  assign CAN_FIRE_dmem_master_m_bvalid = 1'd1 ;
  assign WILL_FIRE_dmem_master_m_bvalid = 1'd1 ;

  // value method dmem_master_m_bready
  assign dmem_master_bready = near_mem$dmem_master_bready ;

  // value method dmem_master_m_arvalid
  assign dmem_master_arvalid = near_mem$dmem_master_arvalid ;

  // value method dmem_master_m_arid
  assign dmem_master_arid = near_mem$dmem_master_arid ;

  // value method dmem_master_m_araddr
  assign dmem_master_araddr = near_mem$dmem_master_araddr ;

  // value method dmem_master_m_arlen
  assign dmem_master_arlen = near_mem$dmem_master_arlen ;

  // value method dmem_master_m_arsize
  assign dmem_master_arsize = near_mem$dmem_master_arsize ;

  // value method dmem_master_m_arburst
  assign dmem_master_arburst = near_mem$dmem_master_arburst ;

  // value method dmem_master_m_arlock
  assign dmem_master_arlock = near_mem$dmem_master_arlock ;

  // value method dmem_master_m_arcache
  assign dmem_master_arcache = near_mem$dmem_master_arcache ;

  // value method dmem_master_m_arprot
  assign dmem_master_arprot = near_mem$dmem_master_arprot ;

  // value method dmem_master_m_arqos
  assign dmem_master_arqos = near_mem$dmem_master_arqos ;

  // value method dmem_master_m_arregion
  assign dmem_master_arregion = near_mem$dmem_master_arregion ;

  // action method dmem_master_m_arready
  assign CAN_FIRE_dmem_master_m_arready = 1'd1 ;
  assign WILL_FIRE_dmem_master_m_arready = 1'd1 ;

  // action method dmem_master_m_rvalid
  assign CAN_FIRE_dmem_master_m_rvalid = 1'd1 ;
  assign WILL_FIRE_dmem_master_m_rvalid = 1'd1 ;

  // value method dmem_master_m_rready
  assign dmem_master_rready = near_mem$dmem_master_rready ;

  // action method m_external_interrupt_req
  assign CAN_FIRE_m_external_interrupt_req = 1'd1 ;
  assign WILL_FIRE_m_external_interrupt_req = 1'd1 ;

  // action method s_external_interrupt_req
  assign CAN_FIRE_s_external_interrupt_req = 1'd1 ;
  assign WILL_FIRE_s_external_interrupt_req = 1'd1 ;

  // action method software_interrupt_req
  assign CAN_FIRE_software_interrupt_req = 1'd1 ;
  assign WILL_FIRE_software_interrupt_req = 1'd1 ;

  // action method timer_interrupt_req
  assign CAN_FIRE_timer_interrupt_req = 1'd1 ;
  assign WILL_FIRE_timer_interrupt_req = 1'd1 ;

  // action method nmi_req
  assign CAN_FIRE_nmi_req = 1'd1 ;
  assign WILL_FIRE_nmi_req = 1'd1 ;

  // action method set_verbosity
  assign RDY_set_verbosity = 1'd1 ;
  assign CAN_FIRE_set_verbosity = 1'd1 ;
  assign WILL_FIRE_set_verbosity = EN_set_verbosity ;

  // submodule csr_regfile
  mkCSR_RegFile csr_regfile(.CLK(CLK),
			    .RST_N(RST_N),
			    .access_permitted_1_csr_addr(csr_regfile$access_permitted_1_csr_addr),
			    .access_permitted_1_priv(csr_regfile$access_permitted_1_priv),
			    .access_permitted_1_read_not_write(csr_regfile$access_permitted_1_read_not_write),
			    .access_permitted_2_csr_addr(csr_regfile$access_permitted_2_csr_addr),
			    .access_permitted_2_priv(csr_regfile$access_permitted_2_priv),
			    .access_permitted_2_read_not_write(csr_regfile$access_permitted_2_read_not_write),
			    .csr_counter_read_fault_csr_addr(csr_regfile$csr_counter_read_fault_csr_addr),
			    .csr_counter_read_fault_priv(csr_regfile$csr_counter_read_fault_priv),
			    .csr_ret_actions_from_priv(csr_regfile$csr_ret_actions_from_priv),
			    .csr_trap_actions_exc_code(csr_regfile$csr_trap_actions_exc_code),
			    .csr_trap_actions_from_priv(csr_regfile$csr_trap_actions_from_priv),
			    .csr_trap_actions_interrupt(csr_regfile$csr_trap_actions_interrupt),
			    .csr_trap_actions_nmi(csr_regfile$csr_trap_actions_nmi),
			    .csr_trap_actions_pc(csr_regfile$csr_trap_actions_pc),
			    .csr_trap_actions_xtval(csr_regfile$csr_trap_actions_xtval),
			    .interrupt_pending_cur_priv(csr_regfile$interrupt_pending_cur_priv),
			    .m_external_interrupt_req_set_not_clear(csr_regfile$m_external_interrupt_req_set_not_clear),
			    .mav_csr_write_csr_addr(csr_regfile$mav_csr_write_csr_addr),
			    .mav_csr_write_word(csr_regfile$mav_csr_write_word),
			    .mav_read_csr_csr_addr(csr_regfile$mav_read_csr_csr_addr),
			    .nmi_req_set_not_clear(csr_regfile$nmi_req_set_not_clear),
			    .read_csr_csr_addr(csr_regfile$read_csr_csr_addr),
			    .read_csr_port2_csr_addr(csr_regfile$read_csr_port2_csr_addr),
			    .s_external_interrupt_req_set_not_clear(csr_regfile$s_external_interrupt_req_set_not_clear),
			    .software_interrupt_req_set_not_clear(csr_regfile$software_interrupt_req_set_not_clear),
			    .timer_interrupt_req_set_not_clear(csr_regfile$timer_interrupt_req_set_not_clear),
			    .EN_server_reset_request_put(csr_regfile$EN_server_reset_request_put),
			    .EN_server_reset_response_get(csr_regfile$EN_server_reset_response_get),
			    .EN_mav_read_csr(csr_regfile$EN_mav_read_csr),
			    .EN_mav_csr_write(csr_regfile$EN_mav_csr_write),
			    .EN_csr_trap_actions(csr_regfile$EN_csr_trap_actions),
			    .EN_csr_ret_actions(csr_regfile$EN_csr_ret_actions),
			    .EN_csr_minstret_incr(csr_regfile$EN_csr_minstret_incr),
			    .EN_debug(csr_regfile$EN_debug),
			    .RDY_server_reset_request_put(csr_regfile$RDY_server_reset_request_put),
			    .RDY_server_reset_response_get(csr_regfile$RDY_server_reset_response_get),
			    .read_csr(csr_regfile$read_csr),
			    .read_csr_port2(),
			    .mav_read_csr(),
			    .mav_csr_write(),
			    .read_misa(csr_regfile$read_misa),
			    .read_mstatus(csr_regfile$read_mstatus),
			    .read_ustatus(),
			    .read_satp(csr_regfile$read_satp),
			    .csr_trap_actions(csr_regfile$csr_trap_actions),
			    .RDY_csr_trap_actions(),
			    .csr_ret_actions(csr_regfile$csr_ret_actions),
			    .RDY_csr_ret_actions(),
			    .read_csr_minstret(csr_regfile$read_csr_minstret),
			    .read_csr_mcycle(csr_regfile$read_csr_mcycle),
			    .read_csr_mtime(),
			    .access_permitted_1(csr_regfile$access_permitted_1),
			    .access_permitted_2(csr_regfile$access_permitted_2),
			    .csr_counter_read_fault(),
			    .csr_mip_read(),
			    .interrupt_pending(csr_regfile$interrupt_pending),
			    .wfi_resume(csr_regfile$wfi_resume),
			    .nmi_pending(csr_regfile$nmi_pending),
			    .RDY_debug() ,.RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg) ,.RTL__DOT__csr_regfile__DOT__rg_state(RTL__DOT__csr_regfile__DOT__rg_state) ,.RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg) ,.RTL__DOT__csr_regfile__DOT__rg_nmi(RTL__DOT__csr_regfile__DOT__rg_nmi));

  // submodule f_reset_reqs
  FIFO2 #(.width(32'd1), .guarded(32'd1)) f_reset_reqs(.RST(RST_N),
						       .CLK(CLK),
						       .D_IN(f_reset_reqs$D_IN),
						       .ENQ(f_reset_reqs$ENQ),
						       .DEQ(f_reset_reqs$DEQ),
						       .CLR(f_reset_reqs$CLR),
						       .D_OUT(f_reset_reqs$D_OUT),
						       .FULL_N(f_reset_reqs$FULL_N),
						       .EMPTY_N(f_reset_reqs$EMPTY_N) ,.RTL__DOT__f_reset_reqs__DOT__full_reg(RTL__DOT__f_reset_reqs__DOT__full_reg) ,.RTL__DOT__f_reset_reqs__DOT__empty_reg(RTL__DOT__f_reset_reqs__DOT__empty_reg));

  // submodule f_reset_rsps
  FIFO2 #(.width(32'd1), .guarded(32'd1)) f_reset_rsps(.RST(RST_N),
						       .CLK(CLK),
						       .D_IN(f_reset_rsps$D_IN),
						       .ENQ(f_reset_rsps$ENQ),
						       .DEQ(f_reset_rsps$DEQ),
						       .CLR(f_reset_rsps$CLR),
						       .D_OUT(f_reset_rsps$D_OUT),
						       .FULL_N(f_reset_rsps$FULL_N),
						       .EMPTY_N(f_reset_rsps$EMPTY_N) ,.RTL__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__f_reset_rsps__DOT__empty_reg) ,.RTL__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__f_reset_rsps__DOT__full_reg));

  // submodule gpr_regfile
  mkGPR_RegFile gpr_regfile(.CLK(CLK),
			    .RST_N(RST_N),
			    .read_rs1_port2_rs1(gpr_regfile$read_rs1_port2_rs1),
			    .read_rs1_rs1(gpr_regfile$read_rs1_rs1),
			    .read_rs2_rs2(gpr_regfile$read_rs2_rs2),
			    .write_rd_rd(gpr_regfile$write_rd_rd),
			    .write_rd_rd_val(gpr_regfile$write_rd_rd_val),
			    .EN_server_reset_request_put(gpr_regfile$EN_server_reset_request_put),
			    .EN_server_reset_response_get(gpr_regfile$EN_server_reset_response_get),
			    .EN_write_rd(gpr_regfile$EN_write_rd),
			    .RDY_server_reset_request_put(gpr_regfile$RDY_server_reset_request_put),
			    .RDY_server_reset_response_get(gpr_regfile$RDY_server_reset_response_get),
			    .read_rs1(gpr_regfile$read_rs1),
			    .read_rs1_port2(),
			    .read_rs2(gpr_regfile$read_rs2) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_) ,.RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_) ,.RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_));

  // submodule near_mem
  mkNear_Mem near_mem(.CLK(CLK),
		      .RST_N(RST_N),
		      .dmem_master_arready(near_mem$dmem_master_arready),
		      .dmem_master_awready(near_mem$dmem_master_awready),
		      .dmem_master_bid(near_mem$dmem_master_bid),
		      .dmem_master_bresp(near_mem$dmem_master_bresp),
		      .dmem_master_bvalid(near_mem$dmem_master_bvalid),
		      .dmem_master_rdata(near_mem$dmem_master_rdata),
		      .dmem_master_rid(near_mem$dmem_master_rid),
		      .dmem_master_rlast(near_mem$dmem_master_rlast),
		      .dmem_master_rresp(near_mem$dmem_master_rresp),
		      .dmem_master_rvalid(near_mem$dmem_master_rvalid),
		      .dmem_master_wready(near_mem$dmem_master_wready),
		      .dmem_req_addr(near_mem$dmem_req_addr),
		      .dmem_req_f3(near_mem$dmem_req_f3),
		      .dmem_req_mstatus_MXR(near_mem$dmem_req_mstatus_MXR),
		      .dmem_req_op(near_mem$dmem_req_op),
		      .dmem_req_priv(near_mem$dmem_req_priv),
		      .dmem_req_satp(near_mem$dmem_req_satp),
		      .dmem_req_sstatus_SUM(near_mem$dmem_req_sstatus_SUM),
		      .dmem_req_store_value(near_mem$dmem_req_store_value),
		      .imem_master_arready(near_mem$imem_master_arready),
		      .imem_master_awready(near_mem$imem_master_awready),
		      .imem_master_bid(near_mem$imem_master_bid),
		      .imem_master_bresp(near_mem$imem_master_bresp),
		      .imem_master_bvalid(near_mem$imem_master_bvalid),
		      .imem_master_rdata(near_mem$imem_master_rdata),
		      .imem_master_rid(near_mem$imem_master_rid),
		      .imem_master_rlast(near_mem$imem_master_rlast),
		      .imem_master_rresp(near_mem$imem_master_rresp),
		      .imem_master_rvalid(near_mem$imem_master_rvalid),
		      .imem_master_wready(near_mem$imem_master_wready),
		      .imem_req_addr(near_mem$imem_req_addr),
		      .imem_req_f3(near_mem$imem_req_f3),
		      .imem_req_mstatus_MXR(near_mem$imem_req_mstatus_MXR),
		      .imem_req_priv(near_mem$imem_req_priv),
		      .imem_req_satp(near_mem$imem_req_satp),
		      .imem_req_sstatus_SUM(near_mem$imem_req_sstatus_SUM),
		      .server_fence_request_put(near_mem$server_fence_request_put),
		      .EN_server_reset_request_put(near_mem$EN_server_reset_request_put),
		      .EN_server_reset_response_get(near_mem$EN_server_reset_response_get),
		      .EN_imem_req(near_mem$EN_imem_req),
		      .EN_dmem_req(near_mem$EN_dmem_req),
		      .EN_server_fence_i_request_put(near_mem$EN_server_fence_i_request_put),
		      .EN_server_fence_i_response_get(near_mem$EN_server_fence_i_response_get),
		      .EN_server_fence_request_put(near_mem$EN_server_fence_request_put),
		      .EN_server_fence_response_get(near_mem$EN_server_fence_response_get),
		      .EN_sfence_vma(near_mem$EN_sfence_vma),
		      .RDY_server_reset_request_put(near_mem$RDY_server_reset_request_put),
		      .RDY_server_reset_response_get(near_mem$RDY_server_reset_response_get),
		      .imem_valid(near_mem$imem_valid),
		      .imem_is_i32_not_i16(near_mem$imem_is_i32_not_i16),
		      .imem_pc(near_mem$imem_pc),
		      .imem_instr(near_mem$imem_instr),
		      .imem_exc(near_mem$imem_exc),
		      .imem_exc_code(near_mem$imem_exc_code),
		      .imem_tval(near_mem$imem_tval),
		      .imem_master_awvalid(near_mem$imem_master_awvalid),
		      .imem_master_awid(near_mem$imem_master_awid),
		      .imem_master_awaddr(near_mem$imem_master_awaddr),
		      .imem_master_awlen(near_mem$imem_master_awlen),
		      .imem_master_awsize(near_mem$imem_master_awsize),
		      .imem_master_awburst(near_mem$imem_master_awburst),
		      .imem_master_awlock(near_mem$imem_master_awlock),
		      .imem_master_awcache(near_mem$imem_master_awcache),
		      .imem_master_awprot(near_mem$imem_master_awprot),
		      .imem_master_awqos(near_mem$imem_master_awqos),
		      .imem_master_awregion(near_mem$imem_master_awregion),
		      .imem_master_wvalid(near_mem$imem_master_wvalid),
		      .imem_master_wdata(near_mem$imem_master_wdata),
		      .imem_master_wstrb(near_mem$imem_master_wstrb),
		      .imem_master_wlast(near_mem$imem_master_wlast),
		      .imem_master_bready(near_mem$imem_master_bready),
		      .imem_master_arvalid(near_mem$imem_master_arvalid),
		      .imem_master_arid(near_mem$imem_master_arid),
		      .imem_master_araddr(near_mem$imem_master_araddr),
		      .imem_master_arlen(near_mem$imem_master_arlen),
		      .imem_master_arsize(near_mem$imem_master_arsize),
		      .imem_master_arburst(near_mem$imem_master_arburst),
		      .imem_master_arlock(near_mem$imem_master_arlock),
		      .imem_master_arcache(near_mem$imem_master_arcache),
		      .imem_master_arprot(near_mem$imem_master_arprot),
		      .imem_master_arqos(near_mem$imem_master_arqos),
		      .imem_master_arregion(near_mem$imem_master_arregion),
		      .imem_master_rready(near_mem$imem_master_rready),
		      .dmem_valid(near_mem$dmem_valid),
		      .dmem_word64(near_mem$dmem_word64),
		      .dmem_st_amo_val(),
		      .dmem_exc(near_mem$dmem_exc),
		      .dmem_exc_code(near_mem$dmem_exc_code),
		      .dmem_master_awvalid(near_mem$dmem_master_awvalid),
		      .dmem_master_awid(near_mem$dmem_master_awid),
		      .dmem_master_awaddr(near_mem$dmem_master_awaddr),
		      .dmem_master_awlen(near_mem$dmem_master_awlen),
		      .dmem_master_awsize(near_mem$dmem_master_awsize),
		      .dmem_master_awburst(near_mem$dmem_master_awburst),
		      .dmem_master_awlock(near_mem$dmem_master_awlock),
		      .dmem_master_awcache(near_mem$dmem_master_awcache),
		      .dmem_master_awprot(near_mem$dmem_master_awprot),
		      .dmem_master_awqos(near_mem$dmem_master_awqos),
		      .dmem_master_awregion(near_mem$dmem_master_awregion),
		      .dmem_master_wvalid(near_mem$dmem_master_wvalid),
		      .dmem_master_wdata(near_mem$dmem_master_wdata),
		      .dmem_master_wstrb(near_mem$dmem_master_wstrb),
		      .dmem_master_wlast(near_mem$dmem_master_wlast),
		      .dmem_master_bready(near_mem$dmem_master_bready),
		      .dmem_master_arvalid(near_mem$dmem_master_arvalid),
		      .dmem_master_arid(near_mem$dmem_master_arid),
		      .dmem_master_araddr(near_mem$dmem_master_araddr),
		      .dmem_master_arlen(near_mem$dmem_master_arlen),
		      .dmem_master_arsize(near_mem$dmem_master_arsize),
		      .dmem_master_arburst(near_mem$dmem_master_arburst),
		      .dmem_master_arlock(near_mem$dmem_master_arlock),
		      .dmem_master_arcache(near_mem$dmem_master_arcache),
		      .dmem_master_arprot(near_mem$dmem_master_arprot),
		      .dmem_master_arqos(near_mem$dmem_master_arqos),
		      .dmem_master_arregion(near_mem$dmem_master_arregion),
		      .dmem_master_rready(near_mem$dmem_master_rready),
		      .RDY_server_fence_i_request_put(near_mem$RDY_server_fence_i_request_put),
		      .RDY_server_fence_i_response_get(near_mem$RDY_server_fence_i_response_get),
		      .RDY_server_fence_request_put(near_mem$RDY_server_fence_request_put),
		      .RDY_server_fence_response_get(near_mem$RDY_server_fence_response_get),
		      .RDY_sfence_vma() ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa(RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr(RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg));

  // submodule soc_map
  mkSoC_Map soc_map(.CLK(CLK),
		    .RST_N(RST_N),
		    .m_is_IO_addr_addr(soc_map$m_is_IO_addr_addr),
		    .m_is_mem_addr_addr(soc_map$m_is_mem_addr_addr),
		    .m_is_near_mem_IO_addr_addr(soc_map$m_is_near_mem_IO_addr_addr),
		    .m_near_mem_io_addr_base(),
		    .m_near_mem_io_addr_size(),
		    .m_near_mem_io_addr_lim(),
		    .m_plic_addr_base(),
		    .m_plic_addr_size(),
		    .m_plic_addr_lim(),
		    .m_uart0_addr_base(),
		    .m_uart0_addr_size(),
		    .m_uart0_addr_lim(),
		    .m_boot_rom_addr_base(),
		    .m_boot_rom_addr_size(),
		    .m_boot_rom_addr_lim(),
		    .m_mem0_controller_addr_base(),
		    .m_mem0_controller_addr_size(),
		    .m_mem0_controller_addr_lim(),
		    .m_tcm_addr_base(),
		    .m_tcm_addr_size(),
		    .m_tcm_addr_lim(),
		    .m_is_mem_addr(),
		    .m_is_IO_addr(),
		    .m_is_near_mem_IO_addr(),
		    .m_pc_reset_value(soc_map$m_pc_reset_value),
		    .m_mtvec_reset_value(),
		    .m_nmivec_reset_value());

  // submodule stage1_f_reset_reqs
  FIFO20 #(.guarded(32'd1)) stage1_f_reset_reqs(.RST(RST_N),
						.CLK(CLK),
						.ENQ(stage1_f_reset_reqs$ENQ),
						.DEQ(stage1_f_reset_reqs$DEQ),
						.CLR(stage1_f_reset_reqs$CLR),
						.FULL_N(stage1_f_reset_reqs$FULL_N),
						.EMPTY_N(stage1_f_reset_reqs$EMPTY_N) ,.RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg(RTL__DOT__stage1_f_reset_reqs__DOT__empty_reg) ,.RTL__DOT__stage1_f_reset_reqs__DOT__full_reg(RTL__DOT__stage1_f_reset_reqs__DOT__full_reg));

  // submodule stage1_f_reset_rsps
  FIFO20 #(.guarded(32'd1)) stage1_f_reset_rsps(.RST(RST_N),
						.CLK(CLK),
						.ENQ(stage1_f_reset_rsps$ENQ),
						.DEQ(stage1_f_reset_rsps$DEQ),
						.CLR(stage1_f_reset_rsps$CLR),
						.FULL_N(stage1_f_reset_rsps$FULL_N),
						.EMPTY_N(stage1_f_reset_rsps$EMPTY_N) ,.RTL__DOT__stage1_f_reset_rsps__DOT__full_reg(RTL__DOT__stage1_f_reset_rsps__DOT__full_reg) ,.RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg(RTL__DOT__stage1_f_reset_rsps__DOT__empty_reg));

  // submodule stage2_f_reset_reqs
  FIFO20 #(.guarded(32'd1)) stage2_f_reset_reqs(.RST(RST_N),
						.CLK(CLK),
						.ENQ(stage2_f_reset_reqs$ENQ),
						.DEQ(stage2_f_reset_reqs$DEQ),
						.CLR(stage2_f_reset_reqs$CLR),
						.FULL_N(stage2_f_reset_reqs$FULL_N),
						.EMPTY_N(stage2_f_reset_reqs$EMPTY_N) ,.RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg(RTL__DOT__stage2_f_reset_reqs__DOT__empty_reg) ,.RTL__DOT__stage2_f_reset_reqs__DOT__full_reg(RTL__DOT__stage2_f_reset_reqs__DOT__full_reg));

  // submodule stage2_f_reset_rsps
  FIFO20 #(.guarded(32'd1)) stage2_f_reset_rsps(.RST(RST_N),
						.CLK(CLK),
						.ENQ(stage2_f_reset_rsps$ENQ),
						.DEQ(stage2_f_reset_rsps$DEQ),
						.CLR(stage2_f_reset_rsps$CLR),
						.FULL_N(stage2_f_reset_rsps$FULL_N),
						.EMPTY_N(stage2_f_reset_rsps$EMPTY_N) ,.RTL__DOT__stage2_f_reset_rsps__DOT__full_reg(RTL__DOT__stage2_f_reset_rsps__DOT__full_reg) ,.RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg(RTL__DOT__stage2_f_reset_rsps__DOT__empty_reg));

  // submodule stage3_f_reset_reqs
  FIFO20 #(.guarded(32'd1)) stage3_f_reset_reqs(.RST(RST_N),
						.CLK(CLK),
						.ENQ(stage3_f_reset_reqs$ENQ),
						.DEQ(stage3_f_reset_reqs$DEQ),
						.CLR(stage3_f_reset_reqs$CLR),
						.FULL_N(stage3_f_reset_reqs$FULL_N),
						.EMPTY_N(stage3_f_reset_reqs$EMPTY_N) ,.RTL__DOT__stage3_f_reset_reqs__DOT__full_reg(RTL__DOT__stage3_f_reset_reqs__DOT__full_reg) ,.RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg(RTL__DOT__stage3_f_reset_reqs__DOT__empty_reg));

  // submodule stage3_f_reset_rsps
  FIFO20 #(.guarded(32'd1)) stage3_f_reset_rsps(.RST(RST_N),
						.CLK(CLK),
						.ENQ(stage3_f_reset_rsps$ENQ),
						.DEQ(stage3_f_reset_rsps$DEQ),
						.CLR(stage3_f_reset_rsps$CLR),
						.FULL_N(stage3_f_reset_rsps$FULL_N),
						.EMPTY_N(stage3_f_reset_rsps$EMPTY_N) ,.RTL__DOT__stage3_f_reset_rsps__DOT__full_reg(RTL__DOT__stage3_f_reset_rsps__DOT__full_reg) ,.RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg(RTL__DOT__stage3_f_reset_rsps__DOT__empty_reg));

  // rule RL_rl_show_pipe
  assign CAN_FIRE_RL_rl_show_pipe =
	     NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17 &&
	     rg_state != 4'd0 &&
	     rg_state != 4'd1 &&
	     rg_state != 4'd12 ;
  assign WILL_FIRE_RL_rl_show_pipe = CAN_FIRE_RL_rl_show_pipe ;

  // rule RL_rl_reset_complete
  assign CAN_FIRE_RL_rl_reset_complete = MUX_rg_state$write_1__SEL_1 ;
  assign WILL_FIRE_RL_rl_reset_complete = MUX_rg_state$write_1__SEL_1 ;

  // rule RL_rl_pipe
  assign CAN_FIRE_RL_rl_pipe =
	     rg_state == 4'd3 &&
	     (stage3_rg_full ||
	      IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 !=
	      2'd0 ||
	      stage1_rg_full) &&
	     (stage3_rg_full ||
	      IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 !=
	      2'd3) &&
	     (stage3_rg_full ||
	      IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 !=
	      2'd0 ||
	      !stage1_rg_full ||
	      NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d702) &&
	     (NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d716 ||
	      IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 !=
	      2'd0 ||
	      stage3_rg_full) ;
  assign WILL_FIRE_RL_rl_pipe = CAN_FIRE_RL_rl_pipe ;

  // rule RL_rl_stage2_nonpipe
  assign CAN_FIRE_RL_rl_stage2_nonpipe =
	     rg_state == 4'd3 && !stage3_rg_full &&
	     IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 ==
	     2'd3 ;
  assign WILL_FIRE_RL_rl_stage2_nonpipe = CAN_FIRE_RL_rl_stage2_nonpipe ;

  // rule RL_rl_stage1_trap
  assign CAN_FIRE_RL_rl_stage1_trap =
	     rg_state_8_EQ_3_97_AND_NOT_csr_regfile_interru_ETC___d793 &&
	     stage1_rg_full &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd11 ;
  assign WILL_FIRE_RL_rl_stage1_trap = CAN_FIRE_RL_rl_stage1_trap ;

  // rule RL_rl_trap
  assign CAN_FIRE_RL_rl_trap =
	     rg_state == 4'd4 &&
	     (!stage1_rg_full ||
	      near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177) ;
  assign WILL_FIRE_RL_rl_trap = CAN_FIRE_RL_rl_trap ;

  // rule RL_rl_stage1_CSRR_W
  assign CAN_FIRE_RL_rl_stage1_CSRR_W = MUX_rg_state$write_1__SEL_9 ;
  assign WILL_FIRE_RL_rl_stage1_CSRR_W = MUX_rg_state$write_1__SEL_9 ;

  // rule RL_rl_stage1_CSRR_W_2
  assign CAN_FIRE_RL_rl_stage1_CSRR_W_2 = rg_state == 4'd6 ;
  assign WILL_FIRE_RL_rl_stage1_CSRR_W_2 = rg_state == 4'd6 ;

  // rule RL_rl_stage1_CSRR_S_or_C
  assign CAN_FIRE_RL_rl_stage1_CSRR_S_or_C = MUX_rg_state$write_1__SEL_10 ;
  assign WILL_FIRE_RL_rl_stage1_CSRR_S_or_C = MUX_rg_state$write_1__SEL_10 ;

  // rule RL_rl_stage1_CSRR_S_or_C_2
  assign CAN_FIRE_RL_rl_stage1_CSRR_S_or_C_2 = rg_state == 4'd7 ;
  assign WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2 = rg_state == 4'd7 ;

  // rule RL_rl_stage1_restart_after_csrrx
  assign CAN_FIRE_RL_rl_stage1_restart_after_csrrx = rg_state == 4'd8 ;
  assign WILL_FIRE_RL_rl_stage1_restart_after_csrrx =
	     CAN_FIRE_RL_rl_stage1_restart_after_csrrx ;

  // rule RL_rl_stage1_xRET
  assign CAN_FIRE_RL_rl_stage1_xRET =
	     rg_state_8_EQ_3_97_AND_NOT_csr_regfile_interru_ETC___d793 &&
	     stage1_rg_full &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311 &&
	     (IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	      4'd7 ||
	      IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	      4'd8 ||
	      IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	      4'd9) ;
  assign WILL_FIRE_RL_rl_stage1_xRET = CAN_FIRE_RL_rl_stage1_xRET ;

  // rule RL_rl_stage1_FENCE_I
  assign CAN_FIRE_RL_rl_stage1_FENCE_I =
	     near_mem$RDY_server_fence_i_request_put &&
	     rg_state_8_EQ_3_97_AND_NOT_csr_regfile_interru_ETC___d793 &&
	     stage1_rg_full &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd5 ;
  assign WILL_FIRE_RL_rl_stage1_FENCE_I = CAN_FIRE_RL_rl_stage1_FENCE_I ;

  // rule RL_rl_finish_FENCE_I
  assign CAN_FIRE_RL_rl_finish_FENCE_I =
	     near_mem$RDY_server_fence_i_response_get && rg_state == 4'd9 ;
  assign WILL_FIRE_RL_rl_finish_FENCE_I = CAN_FIRE_RL_rl_finish_FENCE_I ;

  // rule RL_rl_stage1_FENCE
  assign CAN_FIRE_RL_rl_stage1_FENCE =
	     near_mem$RDY_server_fence_request_put &&
	     rg_state_8_EQ_3_97_AND_NOT_csr_regfile_interru_ETC___d793 &&
	     stage1_rg_full &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd4 ;
  assign WILL_FIRE_RL_rl_stage1_FENCE = CAN_FIRE_RL_rl_stage1_FENCE ;

  // rule RL_rl_finish_FENCE
  assign CAN_FIRE_RL_rl_finish_FENCE =
	     near_mem$RDY_server_fence_response_get && rg_state == 4'd10 ;
  assign WILL_FIRE_RL_rl_finish_FENCE = CAN_FIRE_RL_rl_finish_FENCE ;

  // rule RL_rl_stage1_SFENCE_VMA
  assign CAN_FIRE_RL_rl_stage1_SFENCE_VMA =
	     rg_state_8_EQ_3_97_AND_NOT_csr_regfile_interru_ETC___d793 &&
	     stage1_rg_full &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd6 ;
  assign WILL_FIRE_RL_rl_stage1_SFENCE_VMA =
	     CAN_FIRE_RL_rl_stage1_SFENCE_VMA ;

  // rule RL_rl_finish_SFENCE_VMA
  assign CAN_FIRE_RL_rl_finish_SFENCE_VMA = rg_state == 4'd11 ;
  assign WILL_FIRE_RL_rl_finish_SFENCE_VMA =
	     CAN_FIRE_RL_rl_finish_SFENCE_VMA ;

  // rule RL_rl_stage1_WFI
  assign CAN_FIRE_RL_rl_stage1_WFI =
	     rg_state_8_EQ_3_97_AND_NOT_csr_regfile_interru_ETC___d793 &&
	     stage1_rg_full &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd10 ;
  assign WILL_FIRE_RL_rl_stage1_WFI = CAN_FIRE_RL_rl_stage1_WFI ;

  // rule RL_rl_WFI_resume
  assign CAN_FIRE_RL_rl_WFI_resume =
	     rg_state == 4'd12 && csr_regfile$wfi_resume ;
  assign WILL_FIRE_RL_rl_WFI_resume = CAN_FIRE_RL_rl_WFI_resume ;

  // rule RL_rl_reset_from_WFI
  assign CAN_FIRE_RL_rl_reset_from_WFI =
	     rg_state == 4'd12 && f_reset_reqs$EMPTY_N ;
  assign WILL_FIRE_RL_rl_reset_from_WFI = MUX_rg_state$write_1__SEL_4 ;

  // rule RL_rl_trap_fetch
  assign CAN_FIRE_RL_rl_trap_fetch = rg_state == 4'd5 ;
  assign WILL_FIRE_RL_rl_trap_fetch = CAN_FIRE_RL_rl_trap_fetch ;

  // rule RL_rl_stage1_interrupt
  assign CAN_FIRE_RL_rl_stage1_interrupt =
	     (csr_regfile$interrupt_pending[4] || csr_regfile$nmi_pending) &&
	     rg_state == 4'd3 &&
	     stage1_rg_full &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d910 &&
	     IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 ==
	     2'd0 &&
	     !stage3_rg_full ;
  assign WILL_FIRE_RL_rl_stage1_interrupt = CAN_FIRE_RL_rl_stage1_interrupt ;

  // rule RL_rl_reset_start
  assign CAN_FIRE_RL_rl_reset_start =
	     gpr_regfile_RDY_server_reset_request_put__59_A_ETC___d671 &&
	     rg_state == 4'd0 ;
  assign WILL_FIRE_RL_rl_reset_start = CAN_FIRE_RL_rl_reset_start ;

  // rule RL_stage3_rl_reset
  assign CAN_FIRE_RL_stage3_rl_reset =
	     stage3_f_reset_reqs$EMPTY_N && stage3_f_reset_rsps$FULL_N ;
  assign WILL_FIRE_RL_stage3_rl_reset = CAN_FIRE_RL_stage3_rl_reset ;

  // rule RL_stage2_rl_reset_end
  assign CAN_FIRE_RL_stage2_rl_reset_end =
	     stage2_f_reset_rsps$FULL_N && stage2_rg_resetting ;
  assign WILL_FIRE_RL_stage2_rl_reset_end = CAN_FIRE_RL_stage2_rl_reset_end ;

  // rule RL_stage2_rl_reset_begin
  assign CAN_FIRE_RL_stage2_rl_reset_begin = stage2_f_reset_reqs$EMPTY_N ;
  assign WILL_FIRE_RL_stage2_rl_reset_begin = stage2_f_reset_reqs$EMPTY_N ;

  // rule RL_stage1_rl_reset
  assign CAN_FIRE_RL_stage1_rl_reset =
	     stage1_f_reset_reqs$EMPTY_N && stage1_f_reset_rsps$FULL_N ;
  assign WILL_FIRE_RL_stage1_rl_reset = CAN_FIRE_RL_stage1_rl_reset ;

  // inputs to muxes for submodule ports
  assign MUX_csr_regfile$mav_csr_write_1__SEL_1 =
	     WILL_FIRE_RL_rl_stage1_CSRR_W_2 &&
	     csr_regfile$access_permitted_1 ;
  assign MUX_gpr_regfile$write_rd_1__SEL_3 =
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2 &&
	     csr_regfile$access_permitted_2 ;
  assign MUX_near_mem$imem_req_1__SEL_1 =
	     WILL_FIRE_RL_rl_reset_complete && rg_run_on_reset ;
  assign MUX_near_mem$imem_req_1__SEL_2 =
	     WILL_FIRE_RL_rl_pipe &&
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d716 &&
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d756 ;
  assign MUX_near_mem$imem_req_1__SEL_5 =
	     WILL_FIRE_RL_rl_WFI_resume ||
	     WILL_FIRE_RL_rl_finish_SFENCE_VMA ||
	     WILL_FIRE_RL_rl_finish_FENCE ||
	     WILL_FIRE_RL_rl_finish_FENCE_I ;
  assign MUX_rg_next_pc$write_1__SEL_1 =
	     WILL_FIRE_RL_rl_stage1_WFI ||
	     WILL_FIRE_RL_rl_stage1_SFENCE_VMA ||
	     WILL_FIRE_RL_rl_stage1_FENCE ||
	     WILL_FIRE_RL_rl_stage1_FENCE_I ||
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W ;
  assign MUX_rg_retiring$write_1__SEL_1 =
	     WILL_FIRE_RL_rl_pipe &&
	     IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 ==
	     2'd2 ;
  assign MUX_rg_state$write_1__SEL_1 =
	     gpr_regfile_RDY_server_reset_response_get__76__ETC___d688 &&
	     rg_state == 4'd1 ;
  assign MUX_rg_state$write_1__SEL_4 =
	     CAN_FIRE_RL_rl_reset_from_WFI && !WILL_FIRE_RL_rl_WFI_resume ;
  assign MUX_rg_state$write_1__SEL_6 =
	     WILL_FIRE_RL_rl_trap_fetch || WILL_FIRE_RL_rl_WFI_resume ||
	     WILL_FIRE_RL_rl_finish_SFENCE_VMA ||
	     WILL_FIRE_RL_rl_finish_FENCE ||
	     WILL_FIRE_RL_rl_finish_FENCE_I ||
	     WILL_FIRE_RL_rl_stage1_restart_after_csrrx ;
  assign MUX_rg_state$write_1__SEL_7 =
	     WILL_FIRE_RL_rl_stage1_interrupt ||
	     WILL_FIRE_RL_rl_stage1_trap ||
	     WILL_FIRE_RL_rl_stage2_nonpipe ;
  assign MUX_rg_state$write_1__SEL_8 =
	     WILL_FIRE_RL_rl_stage1_xRET || WILL_FIRE_RL_rl_trap ;
  assign MUX_rg_state$write_1__SEL_9 =
	     rg_state_8_EQ_3_97_AND_NOT_csr_regfile_interru_ETC___d793 &&
	     stage1_rg_full &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd2 ;
  assign MUX_rg_state$write_1__SEL_10 =
	     rg_state_8_EQ_3_97_AND_NOT_csr_regfile_interru_ETC___d793 &&
	     stage1_rg_full &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd3 ;
  assign MUX_rg_trap_info$write_1__SEL_1 =
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W ;
  assign MUX_rg_trap_instr$write_1__SEL_1 =
	     WILL_FIRE_RL_rl_stage1_interrupt ||
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W ||
	     WILL_FIRE_RL_rl_stage1_trap ;
  assign MUX_rg_trap_interrupt$write_1__SEL_1 =
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W ||
	     WILL_FIRE_RL_rl_stage1_trap ||
	     WILL_FIRE_RL_rl_stage2_nonpipe ;
  always@(rg_trap_instr or
	  csr_regfile$read_csr or
	  y__h12191 or
	  IF_csr_regfile_read_csr_rg_trap_instr_15_BITS__ETC___d868)
  begin
    case (rg_trap_instr[14:12])
      3'b010, 3'b110:
	  MUX_csr_regfile$mav_csr_write_2__VAL_2 =
	      IF_csr_regfile_read_csr_rg_trap_instr_15_BITS__ETC___d868;
      default: MUX_csr_regfile$mav_csr_write_2__VAL_2 =
		   csr_regfile$read_csr[31:0] & y__h12191;
    endcase
  end
  assign MUX_rg_state$write_1__VAL_1 = rg_run_on_reset ? 4'd3 : 4'd2 ;
  assign MUX_rg_state$write_1__VAL_2 =
	     csr_regfile$access_permitted_1 ? 4'd8 : 4'd4 ;
  assign MUX_rg_state$write_1__VAL_3 =
	     csr_regfile$access_permitted_2 ? 4'd8 : 4'd4 ;
  assign MUX_rg_trap_info$write_1__VAL_1 =
	     { near_mem$imem_pc, 4'd2, value__h6967 } ;
  assign MUX_rg_trap_info$write_1__VAL_2 =
	     { stage2_rg_stage2[166:135],
	       near_mem$dmem_exc_code,
	       stage2_rg_stage2[95:64] } ;
  assign MUX_rg_trap_info$write_1__VAL_3 =
	     { near_mem$imem_pc,
	       IF_near_mem_imem_exc__78_THEN_near_mem_imem_ex_ETC___d799 } ;
  assign MUX_rg_trap_info$write_1__VAL_4 =
	     { near_mem$imem_pc, x_exc_code__h15410, 32'd0 } ;
  assign MUX_s1_to_s2$write_1__VAL_1 =
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d773 &&
	     stage1_rg_full &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355 ;
  assign MUX_stage1_rg_full$write_1__VAL_10 =
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d776 ||
	     (csr_regfile_interrupt_pending_rg_cur_priv_9_07_ETC___d779 ||
	      NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d713) &&
	     stage1_rg_full ;
  assign MUX_stage2_rg_full$write_1__VAL_3 =
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d769 ||
	     IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 !=
	     2'd2 &&
	     IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 !=
	     2'd0 ;

  // register cfg_logdelay
  assign cfg_logdelay$D_IN = set_verbosity_logdelay ;
  assign cfg_logdelay$EN = EN_set_verbosity ;

  // register cfg_verbosity
  assign cfg_verbosity$D_IN = set_verbosity_verbosity ;
  assign cfg_verbosity$EN = EN_set_verbosity ;

  // register rg_csr_pc
  assign rg_csr_pc$D_IN = near_mem$imem_pc ;
  assign rg_csr_pc$EN = MUX_rg_trap_info$write_1__SEL_1 ;

  // register rg_csr_val1
  assign rg_csr_val1$D_IN = x_out_data_to_stage2_val1__h5224 ;
  assign rg_csr_val1$EN = MUX_rg_trap_info$write_1__SEL_1 ;

  // register rg_cur_priv
  always@(WILL_FIRE_RL_rl_trap or
	  csr_regfile$csr_trap_actions or
	  WILL_FIRE_RL_rl_stage1_xRET or
	  csr_regfile$csr_ret_actions or WILL_FIRE_RL_rl_reset_start)
  begin
    case (1'b1) // synopsys parallel_case
      WILL_FIRE_RL_rl_trap:
	  rg_cur_priv$D_IN = csr_regfile$csr_trap_actions[1:0];
      WILL_FIRE_RL_rl_stage1_xRET:
	  rg_cur_priv$D_IN = csr_regfile$csr_ret_actions[33:32];
      WILL_FIRE_RL_rl_reset_start: rg_cur_priv$D_IN = 2'b11;
      default: rg_cur_priv$D_IN = 2'b10 /* unspecified value */ ;
    endcase
  end
  assign rg_cur_priv$EN =
	     WILL_FIRE_RL_rl_trap || WILL_FIRE_RL_rl_stage1_xRET ||
	     WILL_FIRE_RL_rl_reset_start ;

  // register rg_mstatus_MXR
  assign rg_mstatus_MXR$D_IN = csr_regfile$read_mstatus[19] ;
  assign rg_mstatus_MXR$EN = MUX_rg_state$write_1__SEL_8 ;

  // register rg_next_pc
  always@(MUX_rg_next_pc$write_1__SEL_1 or
	  x_out_next_pc__h5189 or
	  WILL_FIRE_RL_rl_trap or
	  csr_regfile$csr_trap_actions or
	  WILL_FIRE_RL_rl_stage1_xRET or csr_regfile$csr_ret_actions)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_rg_next_pc$write_1__SEL_1: rg_next_pc$D_IN = x_out_next_pc__h5189;
      WILL_FIRE_RL_rl_trap:
	  rg_next_pc$D_IN = csr_regfile$csr_trap_actions[97:66];
      WILL_FIRE_RL_rl_stage1_xRET:
	  rg_next_pc$D_IN = csr_regfile$csr_ret_actions[65:34];
      default: rg_next_pc$D_IN = 32'hAAAAAAAA /* unspecified value */ ;
    endcase
  end
  assign rg_next_pc$EN =
	     WILL_FIRE_RL_rl_stage1_WFI ||
	     WILL_FIRE_RL_rl_stage1_SFENCE_VMA ||
	     WILL_FIRE_RL_rl_stage1_FENCE ||
	     WILL_FIRE_RL_rl_stage1_FENCE_I ||
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W ||
	     WILL_FIRE_RL_rl_trap ||
	     WILL_FIRE_RL_rl_stage1_xRET ;

  // register rg_retiring
  assign rg_retiring$D_IN = 1'd1 ;
  assign rg_retiring$EN =
	     WILL_FIRE_RL_rl_pipe &&
	     IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 ==
	     2'd2 ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W_2 &&
	     csr_regfile$access_permitted_1 ||
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2 &&
	     csr_regfile$access_permitted_2 ||
	     WILL_FIRE_RL_rl_stage1_WFI ||
	     WILL_FIRE_RL_rl_stage1_SFENCE_VMA ||
	     WILL_FIRE_RL_rl_stage1_FENCE ||
	     WILL_FIRE_RL_rl_stage1_FENCE_I ||
	     WILL_FIRE_RL_rl_stage1_xRET ||
	     WILL_FIRE_RL_rl_trap ||
	     WILL_FIRE_RL_rl_reset_start ;

  // register rg_run_on_reset
  assign rg_run_on_reset$D_IN = f_reset_reqs$D_OUT ;
  assign rg_run_on_reset$EN = CAN_FIRE_RL_rl_reset_start ;

  // register rg_sstatus_SUM
  assign rg_sstatus_SUM$D_IN = 1'd0 ;
  assign rg_sstatus_SUM$EN = MUX_rg_state$write_1__SEL_8 ;

  // register rg_start_CPI_cycles
  assign rg_start_CPI_cycles$D_IN = csr_regfile$read_csr_mcycle ;
  assign rg_start_CPI_cycles$EN = MUX_near_mem$imem_req_1__SEL_1 ;

  // register rg_start_CPI_instrs
  assign rg_start_CPI_instrs$D_IN = csr_regfile$read_csr_minstret ;
  assign rg_start_CPI_instrs$EN = MUX_near_mem$imem_req_1__SEL_1 ;

  // register rg_state
  always@(WILL_FIRE_RL_rl_reset_complete or
	  MUX_rg_state$write_1__VAL_1 or
	  WILL_FIRE_RL_rl_stage1_CSRR_W_2 or
	  MUX_rg_state$write_1__VAL_2 or
	  WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2 or
	  MUX_rg_state$write_1__VAL_3 or
	  WILL_FIRE_RL_rl_reset_from_WFI or
	  WILL_FIRE_RL_rl_reset_start or
	  MUX_rg_state$write_1__SEL_6 or
	  MUX_rg_state$write_1__SEL_7 or
	  MUX_rg_state$write_1__SEL_8 or
	  WILL_FIRE_RL_rl_stage1_CSRR_W or
	  WILL_FIRE_RL_rl_stage1_CSRR_S_or_C or
	  WILL_FIRE_RL_rl_stage1_FENCE_I or
	  WILL_FIRE_RL_rl_stage1_FENCE or
	  WILL_FIRE_RL_rl_stage1_SFENCE_VMA or WILL_FIRE_RL_rl_stage1_WFI)
  begin
    case (1'b1) // synopsys parallel_case
      WILL_FIRE_RL_rl_reset_complete:
	  rg_state$D_IN = MUX_rg_state$write_1__VAL_1;
      WILL_FIRE_RL_rl_stage1_CSRR_W_2:
	  rg_state$D_IN = MUX_rg_state$write_1__VAL_2;
      WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2:
	  rg_state$D_IN = MUX_rg_state$write_1__VAL_3;
      WILL_FIRE_RL_rl_reset_from_WFI: rg_state$D_IN = 4'd0;
      WILL_FIRE_RL_rl_reset_start: rg_state$D_IN = 4'd1;
      MUX_rg_state$write_1__SEL_6: rg_state$D_IN = 4'd3;
      MUX_rg_state$write_1__SEL_7: rg_state$D_IN = 4'd4;
      MUX_rg_state$write_1__SEL_8: rg_state$D_IN = 4'd5;
      WILL_FIRE_RL_rl_stage1_CSRR_W: rg_state$D_IN = 4'd6;
      WILL_FIRE_RL_rl_stage1_CSRR_S_or_C: rg_state$D_IN = 4'd7;
      WILL_FIRE_RL_rl_stage1_FENCE_I: rg_state$D_IN = 4'd9;
      WILL_FIRE_RL_rl_stage1_FENCE: rg_state$D_IN = 4'd10;
      WILL_FIRE_RL_rl_stage1_SFENCE_VMA: rg_state$D_IN = 4'd11;
      WILL_FIRE_RL_rl_stage1_WFI: rg_state$D_IN = 4'd12;
      default: rg_state$D_IN = 4'b1010 /* unspecified value */ ;
    endcase
  end
  assign rg_state$EN =
	     WILL_FIRE_RL_rl_reset_complete ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W_2 ||
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2 ||
	     WILL_FIRE_RL_rl_reset_from_WFI ||
	     WILL_FIRE_RL_rl_reset_start ||
	     WILL_FIRE_RL_rl_trap_fetch ||
	     WILL_FIRE_RL_rl_WFI_resume ||
	     WILL_FIRE_RL_rl_finish_SFENCE_VMA ||
	     WILL_FIRE_RL_rl_finish_FENCE ||
	     WILL_FIRE_RL_rl_finish_FENCE_I ||
	     WILL_FIRE_RL_rl_stage1_restart_after_csrrx ||
	     WILL_FIRE_RL_rl_stage1_interrupt ||
	     WILL_FIRE_RL_rl_stage1_trap ||
	     WILL_FIRE_RL_rl_stage2_nonpipe ||
	     WILL_FIRE_RL_rl_stage1_xRET ||
	     WILL_FIRE_RL_rl_trap ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W ||
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C ||
	     WILL_FIRE_RL_rl_stage1_FENCE_I ||
	     WILL_FIRE_RL_rl_stage1_FENCE ||
	     WILL_FIRE_RL_rl_stage1_SFENCE_VMA ||
	     WILL_FIRE_RL_rl_stage1_WFI ;

  // register rg_trap_info
  always@(MUX_rg_trap_info$write_1__SEL_1 or
	  MUX_rg_trap_info$write_1__VAL_1 or
	  WILL_FIRE_RL_rl_stage2_nonpipe or
	  MUX_rg_trap_info$write_1__VAL_2 or
	  WILL_FIRE_RL_rl_stage1_trap or
	  MUX_rg_trap_info$write_1__VAL_3 or
	  WILL_FIRE_RL_rl_stage1_interrupt or MUX_rg_trap_info$write_1__VAL_4)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_rg_trap_info$write_1__SEL_1:
	  rg_trap_info$D_IN = MUX_rg_trap_info$write_1__VAL_1;
      WILL_FIRE_RL_rl_stage2_nonpipe:
	  rg_trap_info$D_IN = MUX_rg_trap_info$write_1__VAL_2;
      WILL_FIRE_RL_rl_stage1_trap:
	  rg_trap_info$D_IN = MUX_rg_trap_info$write_1__VAL_3;
      WILL_FIRE_RL_rl_stage1_interrupt:
	  rg_trap_info$D_IN = MUX_rg_trap_info$write_1__VAL_4;
      default: rg_trap_info$D_IN =
		   68'hAAAAAAAAAAAAAAAAA /* unspecified value */ ;
    endcase
  end
  assign rg_trap_info$EN =
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W ||
	     WILL_FIRE_RL_rl_stage2_nonpipe ||
	     WILL_FIRE_RL_rl_stage1_trap ||
	     WILL_FIRE_RL_rl_stage1_interrupt ;

  // register rg_trap_instr
  assign rg_trap_instr$D_IN =
	     MUX_rg_trap_instr$write_1__SEL_1 ?
	       near_mem$imem_instr :
	       stage2_rg_stage2[134:103] ;
  assign rg_trap_instr$EN =
	     WILL_FIRE_RL_rl_stage1_interrupt ||
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W ||
	     WILL_FIRE_RL_rl_stage1_trap ||
	     WILL_FIRE_RL_rl_stage2_nonpipe ;

  // register rg_trap_interrupt
  assign rg_trap_interrupt$D_IN = !MUX_rg_trap_interrupt$write_1__SEL_1 ;
  assign rg_trap_interrupt$EN =
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W ||
	     WILL_FIRE_RL_rl_stage1_trap ||
	     WILL_FIRE_RL_rl_stage2_nonpipe ||
	     WILL_FIRE_RL_rl_stage1_interrupt ;

  // register s1_to_s2
  assign s1_to_s2$D_IN = WILL_FIRE_RL_rl_pipe && MUX_s1_to_s2$write_1__VAL_1 ;
  assign s1_to_s2$EN = WILL_FIRE_RL_rl_pipe || WILL_FIRE_RL_rl_reset_start ;

  // register s2_to_s3
  assign s2_to_s3$D_IN = MUX_rg_retiring$write_1__SEL_1 ;
  assign s2_to_s3$EN = WILL_FIRE_RL_rl_pipe || WILL_FIRE_RL_rl_reset_start ;

  // register s3_deq
  assign s3_deq$D_IN = WILL_FIRE_RL_rl_pipe && stage3_rg_full ;
  assign s3_deq$EN = WILL_FIRE_RL_rl_pipe || WILL_FIRE_RL_rl_reset_start ;

  // register stage1_rg_full
  always@(WILL_FIRE_RL_stage1_rl_reset or
	  WILL_FIRE_RL_rl_trap_fetch or
	  WILL_FIRE_RL_rl_WFI_resume or
	  WILL_FIRE_RL_rl_finish_SFENCE_VMA or
	  WILL_FIRE_RL_rl_finish_FENCE or
	  WILL_FIRE_RL_rl_finish_FENCE_I or
	  WILL_FIRE_RL_rl_stage1_xRET or
	  WILL_FIRE_RL_rl_stage1_restart_after_csrrx or
	  WILL_FIRE_RL_rl_trap or
	  WILL_FIRE_RL_rl_pipe or
	  MUX_stage1_rg_full$write_1__VAL_10 or
	  MUX_near_mem$imem_req_1__SEL_1)
  case (1'b1)
    WILL_FIRE_RL_stage1_rl_reset: stage1_rg_full$D_IN = 1'd0;
    WILL_FIRE_RL_rl_trap_fetch || WILL_FIRE_RL_rl_WFI_resume ||
    WILL_FIRE_RL_rl_finish_SFENCE_VMA ||
    WILL_FIRE_RL_rl_finish_FENCE ||
    WILL_FIRE_RL_rl_finish_FENCE_I:
	stage1_rg_full$D_IN = 1'd1;
    WILL_FIRE_RL_rl_stage1_xRET: stage1_rg_full$D_IN = 1'd0;
    WILL_FIRE_RL_rl_stage1_restart_after_csrrx: stage1_rg_full$D_IN = 1'd1;
    WILL_FIRE_RL_rl_trap: stage1_rg_full$D_IN = 1'd0;
    WILL_FIRE_RL_rl_pipe:
	stage1_rg_full$D_IN = MUX_stage1_rg_full$write_1__VAL_10;
    MUX_near_mem$imem_req_1__SEL_1: stage1_rg_full$D_IN = 1'd1;
    default: stage1_rg_full$D_IN = 1'b0 /* unspecified value */ ;
  endcase
  assign stage1_rg_full$EN =
	     WILL_FIRE_RL_rl_reset_complete && rg_run_on_reset ||
	     WILL_FIRE_RL_rl_pipe ||
	     WILL_FIRE_RL_rl_stage1_xRET ||
	     WILL_FIRE_RL_rl_trap ||
	     WILL_FIRE_RL_stage1_rl_reset ||
	     WILL_FIRE_RL_rl_trap_fetch ||
	     WILL_FIRE_RL_rl_WFI_resume ||
	     WILL_FIRE_RL_rl_finish_SFENCE_VMA ||
	     WILL_FIRE_RL_rl_finish_FENCE ||
	     WILL_FIRE_RL_rl_finish_FENCE_I ||
	     WILL_FIRE_RL_rl_stage1_restart_after_csrrx ;

  // register stage2_rg_full
  always@(stage2_f_reset_reqs$EMPTY_N or
	  WILL_FIRE_RL_rl_trap or
	  WILL_FIRE_RL_rl_pipe or
	  MUX_stage2_rg_full$write_1__VAL_3 or MUX_near_mem$imem_req_1__SEL_1)
  case (1'b1)
    stage2_f_reset_reqs$EMPTY_N || WILL_FIRE_RL_rl_trap:
	stage2_rg_full$D_IN = 1'd0;
    WILL_FIRE_RL_rl_pipe:
	stage2_rg_full$D_IN = MUX_stage2_rg_full$write_1__VAL_3;
    MUX_near_mem$imem_req_1__SEL_1: stage2_rg_full$D_IN = 1'd0;
    default: stage2_rg_full$D_IN = 1'b0 /* unspecified value */ ;
  endcase
  assign stage2_rg_full$EN =
	     WILL_FIRE_RL_rl_reset_complete && rg_run_on_reset ||
	     WILL_FIRE_RL_rl_pipe ||
	     WILL_FIRE_RL_rl_trap ||
	     stage2_f_reset_reqs$EMPTY_N ;

  // register stage2_rg_resetting
  assign stage2_rg_resetting$D_IN = stage2_f_reset_reqs$EMPTY_N ;
  assign stage2_rg_resetting$EN =
	     WILL_FIRE_RL_stage2_rl_reset_end || stage2_f_reset_reqs$EMPTY_N ;

  // register stage2_rg_stage2
  assign stage2_rg_stage2$D_IN =
	     { rg_cur_priv,
	       near_mem$imem_pc,
	       near_mem$imem_instr,
	       IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491,
	       x_out_data_to_stage2_rd__h5222,
	       x_out_data_to_stage2_addr__h5223,
	       x_out_data_to_stage2_val1__h5224,
	       x_out_data_to_stage2_val2__h5225 } ;
  assign stage2_rg_stage2$EN =
	     WILL_FIRE_RL_rl_pipe &&
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737 ;

  // register stage3_rg_full
  always@(WILL_FIRE_RL_stage3_rl_reset or
	  WILL_FIRE_RL_rl_pipe or
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 or
	  MUX_near_mem$imem_req_1__SEL_1)
  case (1'b1)
    WILL_FIRE_RL_stage3_rl_reset: stage3_rg_full$D_IN = 1'd0;
    WILL_FIRE_RL_rl_pipe:
	stage3_rg_full$D_IN =
	    IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd2;
    MUX_near_mem$imem_req_1__SEL_1: stage3_rg_full$D_IN = 1'd0;
    default: stage3_rg_full$D_IN = 1'b0 /* unspecified value */ ;
  endcase
  assign stage3_rg_full$EN =
	     WILL_FIRE_RL_rl_reset_complete && rg_run_on_reset ||
	     WILL_FIRE_RL_rl_pipe ||
	     WILL_FIRE_RL_stage3_rl_reset ;

  // register stage3_rg_stage3
  assign stage3_rg_stage3$D_IN =
	     { stage2_rg_stage2[166:103],
	       stage2_rg_stage2[168:167],
	       stage2_rg_stage2[102:101] == 2'd0 ||
	       near_mem$dmem_valid && !near_mem$dmem_exc,
	       x_out_data_to_stage3_rd__h4667,
	       x_out_data_to_stage3_rd_val__h4668 } ;
  assign stage3_rg_stage3$EN = MUX_rg_retiring$write_1__SEL_1 ;

  // submodule csr_regfile
  assign csr_regfile$access_permitted_1_csr_addr = rg_trap_instr[31:20] ;
  assign csr_regfile$access_permitted_1_priv = rg_cur_priv ;
  assign csr_regfile$access_permitted_1_read_not_write = 1'd0 ;
  assign csr_regfile$access_permitted_2_csr_addr = rg_trap_instr[31:20] ;
  assign csr_regfile$access_permitted_2_priv = rg_cur_priv ;
  assign csr_regfile$access_permitted_2_read_not_write =
	     rs1_val__h11920 == 32'd0 ;
  assign csr_regfile$csr_counter_read_fault_csr_addr = 12'h0 ;
  assign csr_regfile$csr_counter_read_fault_priv = 2'h0 ;
  always@(IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415)
  begin
    case (IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415)
      4'd7: csr_regfile$csr_ret_actions_from_priv = 2'b11;
      4'd8: csr_regfile$csr_ret_actions_from_priv = 2'b01;
      default: csr_regfile$csr_ret_actions_from_priv = 2'b0;
    endcase
  end
  assign csr_regfile$csr_trap_actions_exc_code = rg_trap_info[35:32] ;
  assign csr_regfile$csr_trap_actions_from_priv = rg_cur_priv ;
  assign csr_regfile$csr_trap_actions_interrupt =
	     rg_trap_interrupt && !csr_regfile$nmi_pending ;
  assign csr_regfile$csr_trap_actions_nmi =
	     rg_trap_interrupt && csr_regfile$nmi_pending ;
  assign csr_regfile$csr_trap_actions_pc = rg_trap_info[67:36] ;
  assign csr_regfile$csr_trap_actions_xtval = rg_trap_info[31:0] ;
  assign csr_regfile$interrupt_pending_cur_priv = rg_cur_priv ;
  assign csr_regfile$m_external_interrupt_req_set_not_clear =
	     m_external_interrupt_req_set_not_clear ;
  assign csr_regfile$mav_csr_write_csr_addr = rg_trap_instr[31:20] ;
  assign csr_regfile$mav_csr_write_word =
	     MUX_csr_regfile$mav_csr_write_1__SEL_1 ?
	       rs1_val__h11213 :
	       MUX_csr_regfile$mav_csr_write_2__VAL_2 ;
  assign csr_regfile$mav_read_csr_csr_addr = 12'h0 ;
  assign csr_regfile$nmi_req_set_not_clear = nmi_req_set_not_clear ;
  assign csr_regfile$read_csr_csr_addr = rg_trap_instr[31:20] ;
  assign csr_regfile$read_csr_port2_csr_addr = 12'h0 ;
  assign csr_regfile$s_external_interrupt_req_set_not_clear =
	     s_external_interrupt_req_set_not_clear ;
  assign csr_regfile$software_interrupt_req_set_not_clear =
	     software_interrupt_req_set_not_clear ;
  assign csr_regfile$timer_interrupt_req_set_not_clear =
	     timer_interrupt_req_set_not_clear ;
  assign csr_regfile$EN_server_reset_request_put =
	     CAN_FIRE_RL_rl_reset_start ;
  assign csr_regfile$EN_server_reset_response_get =
	     MUX_rg_state$write_1__SEL_1 ;
  assign csr_regfile$EN_mav_read_csr = 1'b0 ;
  assign csr_regfile$EN_mav_csr_write =
	     WILL_FIRE_RL_rl_stage1_CSRR_W_2 &&
	     csr_regfile$access_permitted_1 ||
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2 &&
	     csr_regfile$access_permitted_2 &&
	     rg_trap_instr[19:15] != 5'd0 ;
  assign csr_regfile$EN_csr_trap_actions = CAN_FIRE_RL_rl_trap ;
  assign csr_regfile$EN_csr_ret_actions = CAN_FIRE_RL_rl_stage1_xRET ;
  assign csr_regfile$EN_csr_minstret_incr =
	     WILL_FIRE_RL_rl_pipe &&
	     IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 ==
	     2'd2 ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W_2 &&
	     csr_regfile$access_permitted_1 ||
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2 &&
	     csr_regfile$access_permitted_2 ||
	     WILL_FIRE_RL_rl_stage1_WFI ||
	     WILL_FIRE_RL_rl_stage1_SFENCE_VMA ||
	     WILL_FIRE_RL_rl_stage1_FENCE ||
	     WILL_FIRE_RL_rl_stage1_FENCE_I ||
	     WILL_FIRE_RL_rl_stage1_xRET ;
  assign csr_regfile$EN_debug = 1'b0 ;

  // submodule f_reset_reqs
  assign f_reset_reqs$D_IN = hart0_server_reset_request_put ;
  assign f_reset_reqs$ENQ = EN_hart0_server_reset_request_put ;
  assign f_reset_reqs$DEQ =
	     gpr_regfile_RDY_server_reset_request_put__59_A_ETC___d671 &&
	     rg_state == 4'd0 ;
  assign f_reset_reqs$CLR = 1'b0 ;

  // submodule f_reset_rsps
  assign f_reset_rsps$D_IN = rg_run_on_reset ;
  assign f_reset_rsps$ENQ = MUX_rg_state$write_1__SEL_1 ;
  assign f_reset_rsps$DEQ = EN_hart0_server_reset_response_get ;
  assign f_reset_rsps$CLR = 1'b0 ;

  // submodule gpr_regfile
  assign gpr_regfile$read_rs1_port2_rs1 = 5'h0 ;
  assign gpr_regfile$read_rs1_rs1 = near_mem$imem_instr[19:15] ;
  assign gpr_regfile$read_rs2_rs2 = near_mem$imem_instr[24:20] ;
  assign gpr_regfile$write_rd_rd =
	     (MUX_csr_regfile$mav_csr_write_1__SEL_1 ||
	      MUX_gpr_regfile$write_rd_1__SEL_3) ?
	       rg_trap_instr[11:7] :
	       stage3_rg_stage3[36:32] ;
  assign gpr_regfile$write_rd_rd_val =
	     (MUX_csr_regfile$mav_csr_write_1__SEL_1 ||
	      MUX_gpr_regfile$write_rd_1__SEL_3) ?
	       csr_regfile$read_csr[31:0] :
	       stage3_rg_stage3[31:0] ;
  assign gpr_regfile$EN_server_reset_request_put =
	     CAN_FIRE_RL_rl_reset_start ;
  assign gpr_regfile$EN_server_reset_response_get =
	     MUX_rg_state$write_1__SEL_1 ;
  assign gpr_regfile$EN_write_rd =
	     WILL_FIRE_RL_rl_pipe && stage3_rg_full && stage3_rg_stage3[37] ||
	     WILL_FIRE_RL_rl_stage1_CSRR_W_2 &&
	     csr_regfile$access_permitted_1 ||
	     WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2 &&
	     csr_regfile$access_permitted_2 ;

  // submodule near_mem
  assign near_mem$dmem_master_arready = dmem_master_arready ;
  assign near_mem$dmem_master_awready = dmem_master_awready ;
  assign near_mem$dmem_master_bid = dmem_master_bid ;
  assign near_mem$dmem_master_bresp = dmem_master_bresp ;
  assign near_mem$dmem_master_bvalid = dmem_master_bvalid ;
  assign near_mem$dmem_master_rdata = dmem_master_rdata ;
  assign near_mem$dmem_master_rid = dmem_master_rid ;
  assign near_mem$dmem_master_rlast = dmem_master_rlast ;
  assign near_mem$dmem_master_rresp = dmem_master_rresp ;
  assign near_mem$dmem_master_rvalid = dmem_master_rvalid ;
  assign near_mem$dmem_master_wready = dmem_master_wready ;
  assign near_mem$dmem_req_addr = x_out_data_to_stage2_addr__h5223 ;
  assign near_mem$dmem_req_f3 = near_mem$imem_instr[14:12] ;
  assign near_mem$dmem_req_mstatus_MXR = csr_regfile$read_mstatus[19] ;
  assign near_mem$dmem_req_op =
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 !=
	     2'd1 ;
  assign near_mem$dmem_req_priv =
	     csr_regfile$read_mstatus[17] ?
	       csr_regfile$read_mstatus[12:11] :
	       rg_cur_priv ;
  assign near_mem$dmem_req_satp = csr_regfile$read_satp ;
  assign near_mem$dmem_req_sstatus_SUM = 1'd0 ;
  assign near_mem$dmem_req_store_value =
	     { 32'd0, x_out_data_to_stage2_val2__h5225 } ;
  assign near_mem$imem_master_arready = imem_master_arready ;
  assign near_mem$imem_master_awready = imem_master_awready ;
  assign near_mem$imem_master_bid = imem_master_bid ;
  assign near_mem$imem_master_bresp = imem_master_bresp ;
  assign near_mem$imem_master_bvalid = imem_master_bvalid ;
  assign near_mem$imem_master_rdata = imem_master_rdata ;
  assign near_mem$imem_master_rid = imem_master_rid ;
  assign near_mem$imem_master_rlast = imem_master_rlast ;
  assign near_mem$imem_master_rresp = imem_master_rresp ;
  assign near_mem$imem_master_rvalid = imem_master_rvalid ;
  assign near_mem$imem_master_wready = imem_master_wready ;
  always@(MUX_near_mem$imem_req_1__SEL_1 or
	  soc_map$m_pc_reset_value or
	  WILL_FIRE_RL_rl_trap_fetch or
	  MUX_near_mem$imem_req_1__SEL_5 or
	  rg_next_pc or
	  MUX_near_mem$imem_req_1__SEL_2 or
	  x_out_next_pc__h5189 or WILL_FIRE_RL_rl_stage1_restart_after_csrrx)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_near_mem$imem_req_1__SEL_1:
	  near_mem$imem_req_addr = soc_map$m_pc_reset_value[31:0];
      WILL_FIRE_RL_rl_trap_fetch || MUX_near_mem$imem_req_1__SEL_5:
	  near_mem$imem_req_addr = rg_next_pc;
      MUX_near_mem$imem_req_1__SEL_2:
	  near_mem$imem_req_addr = x_out_next_pc__h5189;
      WILL_FIRE_RL_rl_stage1_restart_after_csrrx:
	  near_mem$imem_req_addr = x_out_next_pc__h5189;
      default: near_mem$imem_req_addr = 32'hAAAAAAAA /* unspecified value */ ;
    endcase
  end
  assign near_mem$imem_req_f3 = 3'b010 ;
  assign near_mem$imem_req_mstatus_MXR =
	     (MUX_near_mem$imem_req_1__SEL_1 ||
	      MUX_near_mem$imem_req_1__SEL_2 ||
	      WILL_FIRE_RL_rl_stage1_restart_after_csrrx ||
	      MUX_near_mem$imem_req_1__SEL_5) ?
	       csr_regfile$read_mstatus[19] :
	       rg_mstatus_MXR ;
  assign near_mem$imem_req_priv = rg_cur_priv ;
  assign near_mem$imem_req_satp = csr_regfile$read_satp ;
  assign near_mem$imem_req_sstatus_SUM =
	     WILL_FIRE_RL_rl_trap_fetch && rg_sstatus_SUM ;
  assign near_mem$server_fence_request_put =
	     8'b10101010 /* unspecified value */  ;
  assign near_mem$EN_server_reset_request_put = CAN_FIRE_RL_rl_reset_start ;
  assign near_mem$EN_server_reset_response_get = MUX_rg_state$write_1__SEL_1 ;
  assign near_mem$EN_imem_req =
	     WILL_FIRE_RL_rl_reset_complete && rg_run_on_reset ||
	     WILL_FIRE_RL_rl_pipe &&
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d716 &&
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d756 ||
	     WILL_FIRE_RL_rl_stage1_restart_after_csrrx ||
	     WILL_FIRE_RL_rl_trap_fetch ||
	     WILL_FIRE_RL_rl_WFI_resume ||
	     WILL_FIRE_RL_rl_finish_SFENCE_VMA ||
	     WILL_FIRE_RL_rl_finish_FENCE ||
	     WILL_FIRE_RL_rl_finish_FENCE_I ;
  assign near_mem$EN_dmem_req =
	     WILL_FIRE_RL_rl_pipe &&
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737 &&
	     (IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 ==
	      2'd1 ||
	      IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 ==
	      2'd2) ;
  assign near_mem$EN_server_fence_i_request_put =
	     CAN_FIRE_RL_rl_stage1_FENCE_I ;
  assign near_mem$EN_server_fence_i_response_get =
	     CAN_FIRE_RL_rl_finish_FENCE_I ;
  assign near_mem$EN_server_fence_request_put = CAN_FIRE_RL_rl_stage1_FENCE ;
  assign near_mem$EN_server_fence_response_get = CAN_FIRE_RL_rl_finish_FENCE ;
  assign near_mem$EN_sfence_vma = CAN_FIRE_RL_rl_stage1_SFENCE_VMA ;

  // submodule soc_map
  assign soc_map$m_is_IO_addr_addr = 64'h0 ;
  assign soc_map$m_is_mem_addr_addr = 64'h0 ;
  assign soc_map$m_is_near_mem_IO_addr_addr = 64'h0 ;

  // submodule stage1_f_reset_reqs
  assign stage1_f_reset_reqs$ENQ = CAN_FIRE_RL_rl_reset_start ;
  assign stage1_f_reset_reqs$DEQ = CAN_FIRE_RL_stage1_rl_reset ;
  assign stage1_f_reset_reqs$CLR = 1'b0 ;

  // submodule stage1_f_reset_rsps
  assign stage1_f_reset_rsps$ENQ = CAN_FIRE_RL_stage1_rl_reset ;
  assign stage1_f_reset_rsps$DEQ = MUX_rg_state$write_1__SEL_1 ;
  assign stage1_f_reset_rsps$CLR = 1'b0 ;

  // submodule stage2_f_reset_reqs
  assign stage2_f_reset_reqs$ENQ = CAN_FIRE_RL_rl_reset_start ;
  assign stage2_f_reset_reqs$DEQ = stage2_f_reset_reqs$EMPTY_N ;
  assign stage2_f_reset_reqs$CLR = 1'b0 ;

  // submodule stage2_f_reset_rsps
  assign stage2_f_reset_rsps$ENQ = CAN_FIRE_RL_stage2_rl_reset_end ;
  assign stage2_f_reset_rsps$DEQ = MUX_rg_state$write_1__SEL_1 ;
  assign stage2_f_reset_rsps$CLR = 1'b0 ;

  // submodule stage3_f_reset_reqs
  assign stage3_f_reset_reqs$ENQ = CAN_FIRE_RL_rl_reset_start ;
  assign stage3_f_reset_reqs$DEQ = CAN_FIRE_RL_stage3_rl_reset ;
  assign stage3_f_reset_reqs$CLR = 1'b0 ;

  // submodule stage3_f_reset_rsps
  assign stage3_f_reset_rsps$ENQ = CAN_FIRE_RL_stage3_rl_reset ;
  assign stage3_f_reset_rsps$DEQ = MUX_rg_state$write_1__SEL_1 ;
  assign stage3_f_reset_rsps$CLR = 1'b0 ;

  // remaining internal signals
  assign IF_IF_near_mem_imem_instr__59_BITS_6_TO_0_79_E_ETC___d655 =
	     ((near_mem$imem_instr[6:0] == 7'b1100011) ?
		near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_0b_ETC___d616 :
		near_mem$imem_instr[6:0] == 7'b1101111 ||
		near_mem$imem_instr[6:0] == 7'b1100111) ?
	       data_to_stage2_addr__h5215 :
	       ((near_mem$imem_instr[6:0] == 7'b1110011 &&
		 near_mem$imem_instr[14:12] == 3'b0 &&
		 near_mem$imem_instr[11:7] == 5'd0 &&
		 near_mem$imem_instr[19:15] == 5'd0 &&
		 near_mem$imem_instr[31:20] == 12'b000000000001) ?
		  near_mem$imem_pc :
		  32'd0) ;
  assign IF_NOT_near_mem_imem_instr__59_BITS_14_TO_12_8_ETC___d362 =
	     NOT_near_mem_imem_instr__59_BITS_14_TO_12_81_E_ETC___d252 ?
	       4'd11 :
	       4'd0 ;
  assign IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 =
	     near_mem$imem_exc ?
	       4'd11 :
	       IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d413 ;
  assign IF_csr_regfile_read_csr_rg_trap_instr_15_BITS__ETC___d868 =
	     csr_regfile$read_csr[31:0] | rs1_val__h11920 ;
  assign IF_near_mem_imem_exc__78_THEN_near_mem_imem_ex_ETC___d799 =
	     near_mem$imem_exc ?
	       { near_mem$imem_exc_code, near_mem$imem_tval } :
	       { alu_outputs_exc_code__h5862, trap_info_tval__h6925 } ;
  assign IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d285 =
	     IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 &&
	     alu_outputs___1_val2__h5367[1] ||
	     near_mem$imem_instr[14:12] != 3'b0 &&
	     near_mem$imem_instr[14:12] != 3'b001 &&
	     near_mem$imem_instr[14:12] != 3'b100 &&
	     near_mem$imem_instr[14:12] != 3'b101 &&
	     near_mem$imem_instr[14:12] != 3'b110 &&
	     near_mem$imem_instr[14:12] != 3'b111 ;
  assign IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d216 =
	     rs1_val_bypassed__h3337 == rs2_val__h5339 ;
  assign IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d218 =
	     (rs1_val_bypassed__h3337 ^ 32'h80000000) <
	     (rs2_val__h5339 ^ 32'h80000000) ;
  assign IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d220 =
	     rs1_val_bypassed__h3337 < rs2_val__h5339 ;
  assign IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 =
	     (near_mem$imem_instr[6:0] == 7'b1100011) ?
	       near_mem$imem_instr[14:12] != 3'b0 &&
	       near_mem$imem_instr[14:12] != 3'b001 &&
	       near_mem$imem_instr[14:12] != 3'b100 &&
	       near_mem$imem_instr[14:12] != 3'b101 &&
	       near_mem$imem_instr[14:12] != 3'b110 &&
	       near_mem$imem_instr[14:12] != 3'b111 ||
	       IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 :
	       (((near_mem$imem_instr[6:0] == 7'b0010011 ||
		  near_mem$imem_instr[6:0] == 7'b0110011) &&
		 (near_mem$imem_instr[14:12] == 3'b001 ||
		  near_mem$imem_instr[14:12] == 3'b101)) ?
		  near_mem$imem_instr[25] :
		  CASE_near_memimem_instr_BITS_6_TO_0_0b10011_N_ETC__q8) ;
  assign IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 =
	     (near_mem$imem_instr[6:0] == 7'b1100011) ?
	       (near_mem$imem_instr[14:12] == 3'b0 ||
		near_mem$imem_instr[14:12] == 3'b001 ||
		near_mem$imem_instr[14:12] == 3'b100 ||
		near_mem$imem_instr[14:12] == 3'b101 ||
		near_mem$imem_instr[14:12] == 3'b110 ||
		near_mem$imem_instr[14:12] == 3'b111) &&
	       IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291 :
	       (((near_mem$imem_instr[6:0] == 7'b0010011 ||
		  near_mem$imem_instr[6:0] == 7'b0110011) &&
		 (near_mem$imem_instr[14:12] == 3'b001 ||
		  near_mem$imem_instr[14:12] == 3'b101)) ?
		  !near_mem$imem_instr[25] :
		  CASE_near_memimem_instr_BITS_6_TO_0_0b10011_n_ETC__q9) ;
  assign IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d571 =
	     ((near_mem$imem_instr[6:0] == 7'b0010011 ||
	       near_mem$imem_instr[6:0] == 7'b0110011) &&
	      (near_mem$imem_instr[14:12] == 3'b001 ||
	       near_mem$imem_instr[14:12] == 3'b101)) ?
	       alu_outputs___1_val1__h5480 :
	       IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d570 ;
  assign IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d649 =
	     (near_mem$imem_instr[6:0] == 7'b1100011) ?
	       near_mem$imem_instr[14:12] != 3'b0 &&
	       near_mem$imem_instr[14:12] != 3'b001 &&
	       near_mem$imem_instr[14:12] != 3'b100 &&
	       near_mem$imem_instr[14:12] != 3'b101 &&
	       near_mem$imem_instr[14:12] != 3'b110 &&
	       near_mem$imem_instr[14:12] != 3'b111 ||
	       IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291 ||
	       !alu_outputs___1_val2__h5367[1] :
	       near_mem$imem_instr[6:0] != 7'b1101111 &&
	       near_mem$imem_instr[6:0] != 7'b1100111 &&
	       (near_mem$imem_instr[6:0] != 7'b1110011 ||
		near_mem$imem_instr[14:12] != 3'b0 ||
		near_mem$imem_instr[11:7] != 5'd0 ||
		near_mem$imem_instr[19:15] != 5'd0 ||
		near_mem$imem_instr[31:20] != 12'b0 &&
		near_mem$imem_instr[31:20] != 12'b000000000001) ;
  assign IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d910 =
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352 ||
	     near_mem$imem_exc ||
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308 ;
  assign IF_rg_cur_priv_9_EQ_0b11_75_OR_rg_cur_priv_9_E_ETC___d394 =
	     ((rg_cur_priv == 2'b11 ||
	       rg_cur_priv == 2'b01 && !csr_regfile$read_mstatus[22]) &&
	      near_mem$imem_instr[31:20] == 12'b000100000010) ?
	       4'd8 :
	       (rg_cur_priv_9_EQ_0b11_75_OR_rg_cur_priv_9_EQ_0_ETC___d392 ?
		  4'd10 :
		  4'd11) ;
  assign IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d142 =
	     stage2_rg_full ?
	       CASE_stage2_rg_stage2_BITS_102_TO_101_0_2_1_IF_ETC__q5 :
	       2'd0 ;
  assign IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d161 =
	     stage2_rg_stage2[100:96] == near_mem$imem_instr[19:15] ;
  assign IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d163 =
	     stage2_rg_stage2[100:96] == near_mem$imem_instr[24:20] ;
  assign IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 =
	     stage2_rg_full ?
	       IF_stage2_rg_stage2_4_BITS_102_TO_101_5_EQ_0_6_ETC___d85 :
	       2'd0 ;
  assign IF_stage2_rg_stage2_4_BITS_100_TO_96_13_EQ_0_3_ETC___d137 =
	     (stage2_rg_stage2[100:96] == 5'd0) ?
	       2'd0 :
	       ((near_mem$dmem_valid && !near_mem$dmem_exc) ? 2'd2 : 2'd1) ;
  assign IF_stage2_rg_stage2_4_BITS_102_TO_101_5_EQ_0_6_ETC___d85 =
	     (stage2_rg_stage2[102:101] == 2'd0) ?
	       2'd2 :
	       (near_mem$dmem_valid ?
		  (near_mem$dmem_exc ? 2'd3 : 2'd2) :
		  2'd1) ;
  assign NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17 =
	     cur_verbosity__h1827 > 4'd1 ;
  assign NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d730 =
	     NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17 &&
	     (stage2_rg_stage2[102:101] == 2'd0 ||
	      near_mem$dmem_valid && !near_mem$dmem_exc) ;
  assign NOT_IF_stage2_rg_full_3_THEN_IF_stage2_rg_stag_ETC___d109 =
	     IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 !=
	     2'd3 &&
	     (stage2_rg_stage2[102:101] == 2'd0 ||
	      near_mem$dmem_valid && !near_mem$dmem_exc) ;
  assign NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d716 =
	     !csr_regfile$interrupt_pending[4] && !csr_regfile$nmi_pending ||
	     (!stage1_rg_full ||
	      NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d713) &&
	     (!stage1_rg_full ||
	      NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d702) ;
  assign NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d734 =
	     !csr_regfile$interrupt_pending[4] && !csr_regfile$nmi_pending ||
	     near_mem$imem_exc ||
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308 ;
  assign NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737 =
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d734 &&
	     (IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 ==
	      2'd2 ||
	      IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 ==
	      2'd0) &&
	     stage1_rg_full &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355 ;
  assign NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d756 =
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d734 &&
	     (IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 ==
	      2'd2 ||
	      IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 ==
	      2'd0) &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355 ||
	     !stage1_rg_full ;
  assign NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d769 =
	     (!csr_regfile$interrupt_pending[4] && !csr_regfile$nmi_pending ||
	      _0_OR_0_OR_near_mem_imem_exc__78_OR_IF_near_mem_ETC___d767) &&
	     stage1_rg_full &&
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355 ;
  assign NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d773 =
	     (!csr_regfile$interrupt_pending[4] && !csr_regfile$nmi_pending ||
	      _0_OR_0_OR_near_mem_imem_exc__78_OR_IF_near_mem_ETC___d767) &&
	     (IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 ==
	      2'd2 ||
	      IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 ==
	      2'd0) ;
  assign NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d776 =
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d716 &&
	     (NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d773 &&
	      near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355 ||
	      !stage1_rg_full) ;
  assign NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d790 =
	     !csr_regfile$interrupt_pending[4] && !csr_regfile$nmi_pending ||
	     !near_mem$imem_exc &&
	     (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) ;
  assign NOT_near_mem_imem_exc__78_13_AND_IF_near_mem_i_ETC___d481 =
	     !near_mem$imem_exc &&
	     (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd0 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd1 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd2 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd3 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd4 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd5 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd6 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd7 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd8 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd9 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd10 ;
  assign NOT_near_mem_imem_instr__59_BITS_14_TO_12_81_E_ETC___d252 =
	     (near_mem$imem_instr[14:12] != 3'b0 ||
	      near_mem$imem_instr[6:0] == 7'b0110011 &&
	      near_mem$imem_instr[30]) &&
	     (near_mem$imem_instr[14:12] != 3'b0 ||
	      near_mem$imem_instr[6:0] != 7'b0110011 ||
	      !near_mem$imem_instr[30]) &&
	     near_mem$imem_instr[14:12] != 3'b010 &&
	     near_mem$imem_instr[14:12] != 3'b011 &&
	     near_mem$imem_instr[14:12] != 3'b100 &&
	     near_mem$imem_instr[14:12] != 3'b110 &&
	     near_mem$imem_instr[14:12] != 3'b111 ;
  assign NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166 =
	     !near_mem$imem_valid ||
	     IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d142 ==
	     2'd1 &&
	     (IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d161 ||
	      IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d163) ;
  assign NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d702 =
	     NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166 ||
	     !near_mem$imem_exc &&
	     (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) ;
  assign NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d713 =
	     NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166 ||
	     near_mem$imem_exc ||
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308 ;
  assign SEXT_near_mem_imem_instr__59_BITS_31_TO_20_02___d303 =
	     { {20{near_memimem_instr_BITS_31_TO_20__q7[11]}},
	       near_memimem_instr_BITS_31_TO_20__q7 } ;
  assign _0_OR_0_OR_near_mem_imem_exc__78_OR_IF_near_mem_ETC___d767 =
	     near_mem$imem_exc ||
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308 ;
  assign _theResult_____1_fst__h6562 =
	     (near_mem$imem_instr[14:12] == 3'b0 &&
	      near_mem$imem_instr[6:0] == 7'b0110011 &&
	      near_mem$imem_instr[30]) ?
	       rd_val___1__h6558 :
	       _theResult_____1_fst__h6569 ;
  assign _theResult_____1_fst__h6597 =
	     rs1_val_bypassed__h3337 & _theResult___snd__h7382 ;
  assign _theResult____h10743 =
	     (delta_CPI_instrs__h10742 == 64'd0) ?
	       delta_CPI_instrs___1__h10778 :
	       delta_CPI_instrs__h10742 ;
  assign _theResult___snd__h7382 =
	     (near_mem$imem_instr[6:0] == 7'b0010011) ?
	       SEXT_near_mem_imem_instr__59_BITS_31_TO_20_02___d303 :
	       rs2_val__h5339 ;
  assign alu_outputs___1_addr__h5365 =
	     IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 ?
	       alu_outputs___1_val2__h5367 :
	       alu_outputs___1_val1__h5386 ;
  assign alu_outputs___1_addr__h5385 =
	     near_mem$imem_pc +
	     { {11{near_memimem_instr_BIT_31_CONCAT_near_memime_ETC__q2[20]}},
	       near_memimem_instr_BIT_31_CONCAT_near_memime_ETC__q2 } ;
  assign alu_outputs___1_addr__h5410 = { eaddr__h5553[31:1], 1'd0 } ;
  assign alu_outputs___1_addr__h5583 =
	     rs1_val_bypassed__h3337 +
	     { {20{near_memimem_instr_BITS_31_TO_25_CONCAT_near__ETC__q6[11]}},
	       near_memimem_instr_BITS_31_TO_25_CONCAT_near__ETC__q6 } ;
  assign alu_outputs___1_exc_code__h5362 =
	     near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_0b_ETC___d616 ?
	       4'd0 :
	       4'd2 ;
  assign alu_outputs___1_exc_code__h5843 =
	     (near_mem$imem_instr[14:12] == 3'b0) ?
	       ((near_mem$imem_instr[11:7] == 5'd0 &&
		 near_mem$imem_instr[19:15] == 5'd0) ?
		  CASE_near_memimem_instr_BITS_31_TO_20_0b0_CAS_ETC__q4 :
		  4'd2) :
	       4'd2 ;
  assign alu_outputs___1_val1__h5386 = near_mem$imem_pc + 32'd4 ;
  assign alu_outputs___1_val1__h5480 =
	     (near_mem$imem_instr[14:12] == 3'b001) ?
	       rd_val__h7278 :
	       (near_mem$imem_instr[30] ? rd_val__h7352 : rd_val__h7330) ;
  assign alu_outputs___1_val1__h5516 =
	     (near_mem$imem_instr[14:12] == 3'b0 &&
	      (near_mem$imem_instr[6:0] != 7'b0110011 ||
	       !near_mem$imem_instr[30])) ?
	       rd_val___1__h6550 :
	       _theResult_____1_fst__h6562 ;
  assign alu_outputs___1_val1__h5847 =
	     near_mem$imem_instr[14] ?
	       { 27'd0, near_mem$imem_instr[19:15] } :
	       rs1_val_bypassed__h3337 ;
  assign alu_outputs___1_val2__h5367 =
	     near_mem$imem_pc +
	     { {19{near_memimem_instr_BIT_31_CONCAT_near_memime_ETC__q1[12]}},
	       near_memimem_instr_BIT_31_CONCAT_near_memime_ETC__q1 } ;
  assign cpi__h10745 = x__h10744 / 64'd10 ;
  assign cpifrac__h10746 = x__h10744 % 64'd10 ;
  assign csr_regfile_interrupt_pending_rg_cur_priv_9_07_ETC___d779 =
	     (csr_regfile$interrupt_pending[4] || csr_regfile$nmi_pending) &&
	     (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) ||
	     IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 !=
	     2'd2 &&
	     IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 !=
	     2'd0 ;
  assign csr_regfile_read_csr_mcycle__8_MINUS_rg_start__ETC___d818 =
	     delta_CPI_cycles__h10741 * 64'd10 ;
  assign cur_verbosity__h1827 =
	     (csr_regfile$read_csr_minstret < cfg_logdelay) ?
	       4'd0 :
	       cfg_verbosity ;
  assign data_to_stage2_addr__h5215 = x_out_data_to_stage2_addr__h5223 ;
  assign delta_CPI_cycles__h10741 =
	     csr_regfile$read_csr_mcycle - rg_start_CPI_cycles ;
  assign delta_CPI_instrs___1__h10778 = delta_CPI_instrs__h10742 + 64'd1 ;
  assign delta_CPI_instrs__h10742 =
	     csr_regfile$read_csr_minstret - rg_start_CPI_instrs ;
  assign eaddr__h5553 =
	     rs1_val_bypassed__h3337 +
	     SEXT_near_mem_imem_instr__59_BITS_31_TO_20_02___d303 ;
  assign fall_through_pc__h5175 =
	     near_mem$imem_pc +
	     (near_mem$imem_is_i32_not_i16 ? 32'd4 : 32'd2) ;
  assign gpr_regfile_RDY_server_reset_request_put__59_A_ETC___d671 =
	     gpr_regfile$RDY_server_reset_request_put &&
	     near_mem$RDY_server_reset_request_put &&
	     csr_regfile$RDY_server_reset_request_put &&
	     f_reset_reqs$EMPTY_N &&
	     stage1_f_reset_reqs$FULL_N &&
	     stage2_f_reset_reqs$FULL_N &&
	     stage3_f_reset_reqs$FULL_N ;
  assign gpr_regfile_RDY_server_reset_response_get__76__ETC___d688 =
	     gpr_regfile$RDY_server_reset_response_get &&
	     near_mem$RDY_server_reset_response_get &&
	     csr_regfile$RDY_server_reset_response_get &&
	     stage1_f_reset_rsps$EMPTY_N &&
	     stage2_f_reset_rsps$EMPTY_N &&
	     stage3_f_reset_rsps$EMPTY_N &&
	     f_reset_rsps$FULL_N ;
  assign near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d578 =
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd0 ;
  assign near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d581 =
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd1 ;
  assign near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d584 =
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd2 ;
  assign near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d587 =
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd3 ;
  assign near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d590 =
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd4 ;
  assign near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d593 =
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd5 ;
  assign near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d596 =
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd6 ;
  assign near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d599 =
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd7 ;
  assign near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d602 =
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd8 ;
  assign near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d605 =
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd9 ;
  assign near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d608 =
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 ==
	     4'd10 ;
  assign near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d611 =
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd0 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd1 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd2 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd3 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd4 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd5 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd6 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd7 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd8 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd9 &&
	     IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 !=
	     4'd10 ;
  assign near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_0b_ETC___d328 =
	     near_mem$imem_instr[14:12] == 3'b0 &&
	     (near_mem$imem_instr[6:0] != 7'b0110011 ||
	      !near_mem$imem_instr[30]) ||
	     near_mem$imem_instr[14:12] == 3'b0 &&
	     near_mem$imem_instr[6:0] == 7'b0110011 &&
	     near_mem$imem_instr[30] ||
	     near_mem$imem_instr[14:12] == 3'b010 ||
	     near_mem$imem_instr[14:12] == 3'b011 ||
	     near_mem$imem_instr[14:12] == 3'b100 ||
	     near_mem$imem_instr[14:12] == 3'b110 ||
	     near_mem$imem_instr[14:12] == 3'b111 ;
  assign near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_0b_ETC___d616 =
	     (near_mem$imem_instr[14:12] == 3'b0 ||
	      near_mem$imem_instr[14:12] == 3'b001 ||
	      near_mem$imem_instr[14:12] == 3'b100 ||
	      near_mem$imem_instr[14:12] == 3'b101 ||
	      near_mem$imem_instr[14:12] == 3'b110 ||
	      near_mem$imem_instr[14:12] == 3'b111) &&
	     IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 &&
	     alu_outputs___1_val2__h5367[1] ;
  assign near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 =
	     near_mem$imem_valid &&
	     (IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d142 !=
	      2'd1 ||
	      !IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d161 &&
	      !IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d163) ;
  assign near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311 =
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	     (near_mem$imem_exc ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d274 &&
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308) ;
  assign near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355 =
	     near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	     !near_mem$imem_exc &&
	     (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	      IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) ;
  assign near_memimem_instr_BITS_31_TO_20__q7 = near_mem$imem_instr[31:20] ;
  assign near_memimem_instr_BITS_31_TO_25_CONCAT_near__ETC__q6 =
	     { near_mem$imem_instr[31:25], near_mem$imem_instr[11:7] } ;
  assign near_memimem_instr_BIT_31_CONCAT_near_memime_ETC__q1 =
	     { near_mem$imem_instr[31],
	       near_mem$imem_instr[7],
	       near_mem$imem_instr[30:25],
	       near_mem$imem_instr[11:8],
	       1'b0 } ;
  assign near_memimem_instr_BIT_31_CONCAT_near_memime_ETC__q2 =
	     { near_mem$imem_instr[31],
	       near_mem$imem_instr[19:12],
	       near_mem$imem_instr[20],
	       near_mem$imem_instr[30:21],
	       1'b0 } ;
  assign output_stage2___1_bypass_rd_val__h4960 =
	     (!near_mem$dmem_valid || !near_mem$dmem_exc) ?
	       ((stage2_rg_stage2[100:96] == 5'd0) ?
		  stage2_rg_stage2[63:32] :
		  near_mem$dmem_word64[31:0]) :
	       stage2_rg_stage2[63:32] ;
  assign rd_val___1__h6550 =
	     rs1_val_bypassed__h3337 + _theResult___snd__h7382 ;
  assign rd_val___1__h6558 =
	     rs1_val_bypassed__h3337 - _theResult___snd__h7382 ;
  assign rd_val___1__h6565 =
	     ((rs1_val_bypassed__h3337 ^ 32'h80000000) <
	      (_theResult___snd__h7382 ^ 32'h80000000)) ?
	       32'd1 :
	       32'd0 ;
  assign rd_val___1__h6572 =
	     (rs1_val_bypassed__h3337 < _theResult___snd__h7382) ?
	       32'd1 :
	       32'd0 ;
  assign rd_val___1__h6579 =
	     rs1_val_bypassed__h3337 ^ _theResult___snd__h7382 ;
  assign rd_val___1__h6586 =
	     rs1_val_bypassed__h3337 | _theResult___snd__h7382 ;
  assign rd_val__h5072 =
	     (stage3_rg_full && stage3_rg_stage3[37] &&
	      stage3_rg_stage3[36:32] == near_mem$imem_instr[19:15]) ?
	       stage3_rg_stage3[31:0] :
	       gpr_regfile$read_rs1 ;
  assign rd_val__h5132 =
	     (stage3_rg_full && stage3_rg_stage3[37] &&
	      stage3_rg_stage3[36:32] == near_mem$imem_instr[24:20]) ?
	       stage3_rg_stage3[31:0] :
	       gpr_regfile$read_rs2 ;
  assign rd_val__h5523 = { near_mem$imem_instr[31:12], 12'h0 } ;
  assign rd_val__h5537 = near_mem$imem_pc + rd_val__h5523 ;
  assign rd_val__h7278 = rs1_val_bypassed__h3337 << shamt__h5467 ;
  assign rd_val__h7330 = rs1_val_bypassed__h3337 >> shamt__h5467 ;
  assign rd_val__h7352 =
	     rs1_val_bypassed__h3337 >> shamt__h5467 |
	     ~(32'hFFFFFFFF >> shamt__h5467) &
	     {32{rs1_val_bypassed__h3337[31]}} ;
  assign rg_cur_priv_9_EQ_0b11_75_OR_rg_cur_priv_9_EQ_0_ETC___d392 =
	     (rg_cur_priv == 2'b11 ||
	      rg_cur_priv == 2'b01 && !csr_regfile$read_mstatus[21] ||
	      rg_cur_priv == 2'b0 && csr_regfile$read_misa[13]) &&
	     near_mem$imem_instr[31:20] == 12'b000100000101 ;
  assign rg_state_8_EQ_3_97_AND_NOT_csr_regfile_interru_ETC___d793 =
	     rg_state == 4'd3 &&
	     NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d790 &&
	     !stage3_rg_full &&
	     IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 ==
	     2'd0 ;
  assign rg_trap_info_04_BITS_67_TO_36_05_EQ_csr_regfil_ETC___d814 =
	     rg_trap_info[67:36] == csr_regfile$csr_trap_actions[97:66] ;
  assign rs1_val__h11213 =
	     (rg_trap_instr[14:12] == 3'b001) ?
	       rg_csr_val1 :
	       { 27'd0, rg_trap_instr[19:15] } ;
  assign rs1_val_bypassed__h3337 =
	     (near_mem$imem_instr[19:15] == 5'd0) ? 32'd0 : val__h5074 ;
  assign rs2_val__h5339 =
	     (near_mem$imem_instr[24:20] == 5'd0) ? 32'd0 : val__h5134 ;
  assign shamt__h5467 =
	     (near_mem$imem_instr[6:0] == 7'b0010011) ?
	       near_mem$imem_instr[24:20] :
	       rs2_val__h5339[4:0] ;
  assign trap_info_tval__h6925 =
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d649 ?
	       near_mem$imem_instr :
	       IF_IF_near_mem_imem_instr__59_BITS_6_TO_0_79_E_ETC___d655 ;
  assign val__h5074 =
	     (IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d142 ==
	      2'd2 &&
	      IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d161) ?
	       x_out_bypass_rd_val__h4969 :
	       rd_val__h5072 ;
  assign val__h5134 =
	     (IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d142 ==
	      2'd2 &&
	      IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d163) ?
	       x_out_bypass_rd_val__h4969 :
	       rd_val__h5132 ;
  assign value__h6967 =
	     near_mem$imem_exc ? near_mem$imem_tval : trap_info_tval__h6925 ;
  assign x__h10744 =
	     csr_regfile_read_csr_mcycle__8_MINUS_rg_start__ETC___d818[63:0] /
	     _theResult____h10743 ;
  assign x_exc_code__h15410 =
	     (csr_regfile$interrupt_pending[4] && !csr_regfile$nmi_pending) ?
	       csr_regfile$interrupt_pending[3:0] :
	       4'd0 ;
  assign x_out_bypass_rd_val__h4969 =
	     (stage2_rg_stage2[102:101] == 2'd0) ?
	       stage2_rg_stage2[63:32] :
	       output_stage2___1_bypass_rd_val__h4960 ;
  assign x_out_data_to_stage2_rd__h5222 =
	     (near_mem$imem_instr[6:0] == 7'b1100011) ?
	       5'd0 :
	       near_mem$imem_instr[11:7] ;
  assign x_out_data_to_stage2_val2__h5225 =
	     (near_mem$imem_instr[6:0] == 7'b1100011) ?
	       alu_outputs___1_val2__h5367 :
	       rs2_val__h5339 ;
  assign x_out_next_pc__h5189 =
	     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352 ?
	       data_to_stage2_addr__h5215 :
	       fall_through_pc__h5175 ;
  assign x_out_trap_info_exc_code__h6928 =
	     near_mem$imem_exc ?
	       near_mem$imem_exc_code :
	       alu_outputs_exc_code__h5862 ;
  assign y__h12191 = ~rs1_val__h11920 ;
  always@(stage2_rg_stage2)
  begin
    case (stage2_rg_stage2[102:101])
      2'd0, 2'd1: x_out_data_to_stage3_rd__h4667 = stage2_rg_stage2[100:96];
      default: x_out_data_to_stage3_rd__h4667 = 5'd0;
    endcase
  end
  always@(stage2_rg_stage2 or near_mem$dmem_word64)
  begin
    case (stage2_rg_stage2[102:101])
      2'd0: x_out_data_to_stage3_rd_val__h4668 = stage2_rg_stage2[63:32];
      2'd1: x_out_data_to_stage3_rd_val__h4668 = near_mem$dmem_word64[31:0];
      default: x_out_data_to_stage3_rd_val__h4668 = stage2_rg_stage2[63:32];
    endcase
  end
  always@(rg_trap_instr or rg_csr_val1)
  begin
    case (rg_trap_instr[14:12])
      3'b010, 3'b011: rs1_val__h11920 = rg_csr_val1;
      default: rs1_val__h11920 = { 27'd0, rg_trap_instr[19:15] };
    endcase
  end
  always@(rg_cur_priv)
  begin
    case (rg_cur_priv)
      2'b0: CASE_rg_cur_priv_0b0_8_0b1_9_11__q3 = 4'd8;
      2'b01: CASE_rg_cur_priv_0b0_8_0b1_9_11__q3 = 4'd9;
      default: CASE_rg_cur_priv_0b0_8_0b1_9_11__q3 = 4'd11;
    endcase
  end
  always@(near_mem$imem_instr or CASE_rg_cur_priv_0b0_8_0b1_9_11__q3)
  begin
    case (near_mem$imem_instr[31:20])
      12'b0:
	  CASE_near_memimem_instr_BITS_31_TO_20_0b0_CAS_ETC__q4 =
	      CASE_rg_cur_priv_0b0_8_0b1_9_11__q3;
      12'b000000000001:
	  CASE_near_memimem_instr_BITS_31_TO_20_0b0_CAS_ETC__q4 = 4'd3;
      default: CASE_near_memimem_instr_BITS_31_TO_20_0b0_CAS_ETC__q4 = 4'd2;
    endcase
  end
  always@(stage2_rg_stage2 or
	  near_mem$dmem_valid or
	  near_mem$dmem_exc or
	  IF_stage2_rg_stage2_4_BITS_100_TO_96_13_EQ_0_3_ETC___d137)
  begin
    case (stage2_rg_stage2[102:101])
      2'd0: CASE_stage2_rg_stage2_BITS_102_TO_101_0_2_1_IF_ETC__q5 = 2'd2;
      2'd1:
	  CASE_stage2_rg_stage2_BITS_102_TO_101_0_2_1_IF_ETC__q5 =
	      (!near_mem$dmem_valid || !near_mem$dmem_exc) ?
		IF_stage2_rg_stage2_4_BITS_100_TO_96_13_EQ_0_3_ETC___d137 :
		2'd0;
      default: CASE_stage2_rg_stage2_BITS_102_TO_101_0_2_1_IF_ETC__q5 = 2'd0;
    endcase
  end
  always@(near_mem$imem_instr or
	  IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d220 or
	  IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d216 or
	  IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d218)
  begin
    case (near_mem$imem_instr[14:12])
      3'b0:
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 =
	      IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d216;
      3'b001:
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 =
	      !IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d216;
      3'b100:
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 =
	      IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d218;
      3'b101:
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 =
	      !IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d218;
      3'b110:
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 =
	      IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d220;
      default: IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 =
		   near_mem$imem_instr[14:12] == 3'b111 &&
		   !IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d220;
    endcase
  end
  always@(near_mem$imem_instr or
	  alu_outputs___1_addr__h5583 or
	  eaddr__h5553 or
	  alu_outputs___1_addr__h5365 or
	  alu_outputs___1_addr__h5410 or alu_outputs___1_addr__h5385)
  begin
    case (near_mem$imem_instr[6:0])
      7'b0000011: x_out_data_to_stage2_addr__h5223 = eaddr__h5553;
      7'b1100011:
	  x_out_data_to_stage2_addr__h5223 = alu_outputs___1_addr__h5365;
      7'b1100111:
	  x_out_data_to_stage2_addr__h5223 = alu_outputs___1_addr__h5410;
      7'b1101111:
	  x_out_data_to_stage2_addr__h5223 = alu_outputs___1_addr__h5385;
      default: x_out_data_to_stage2_addr__h5223 = alu_outputs___1_addr__h5583;
    endcase
  end
  always@(near_mem$imem_instr or
	  _theResult_____1_fst__h6597 or
	  rd_val___1__h6565 or
	  rd_val___1__h6572 or rd_val___1__h6579 or rd_val___1__h6586)
  begin
    case (near_mem$imem_instr[14:12])
      3'b010: _theResult_____1_fst__h6569 = rd_val___1__h6565;
      3'b011: _theResult_____1_fst__h6569 = rd_val___1__h6572;
      3'b100: _theResult_____1_fst__h6569 = rd_val___1__h6579;
      3'b110: _theResult_____1_fst__h6569 = rd_val___1__h6586;
      default: _theResult_____1_fst__h6569 = _theResult_____1_fst__h6597;
    endcase
  end
  always@(near_mem$imem_instr or
	  IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d220 or
	  IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d216 or
	  IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d218)
  begin
    case (near_mem$imem_instr[14:12])
      3'b0:
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291 =
	      !IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d216;
      3'b001:
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291 =
	      IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d216;
      3'b100:
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291 =
	      !IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d218;
      3'b101:
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291 =
	      IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d218;
      3'b110:
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291 =
	      !IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d220;
      default: IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291 =
		   near_mem$imem_instr[14:12] != 3'b111 ||
		   IF_near_mem_imem_instr__59_BITS_19_TO_15_60_EQ_ETC___d220;
    endcase
  end
  always@(near_mem$imem_instr or
	  NOT_near_mem_imem_instr__59_BITS_14_TO_12_81_E_ETC___d252)
  begin
    case (near_mem$imem_instr[6:0])
      7'b0010011, 7'b0110011:
	  CASE_near_memimem_instr_BITS_6_TO_0_0b10011_N_ETC__q8 =
	      NOT_near_mem_imem_instr__59_BITS_14_TO_12_81_E_ETC___d252;
      default: CASE_near_memimem_instr_BITS_6_TO_0_0b10011_N_ETC__q8 =
		   near_mem$imem_instr[6:0] != 7'b0110111 &&
		   near_mem$imem_instr[6:0] != 7'b0010111 &&
		   ((near_mem$imem_instr[6:0] == 7'b0000011) ?
		      near_mem$imem_instr[14:12] != 3'b0 &&
		      near_mem$imem_instr[14:12] != 3'b100 &&
		      near_mem$imem_instr[14:12] != 3'b001 &&
		      near_mem$imem_instr[14:12] != 3'b101 &&
		      near_mem$imem_instr[14:12] != 3'b010 :
		      near_mem$imem_instr[6:0] != 7'b0100011 ||
		      near_mem$imem_instr[14:12] != 3'b0 &&
		      near_mem$imem_instr[14:12] != 3'b001 &&
		      near_mem$imem_instr[14:12] != 3'b010);
    endcase
  end
  always@(near_mem$imem_instr or
	  eaddr__h5553 or
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d285 or
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291 or
	  alu_outputs___1_addr__h5385)
  begin
    case (near_mem$imem_instr[6:0])
      7'b1100011:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308 =
	      IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d285 ||
	      IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291;
      7'b1101111:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308 =
	      alu_outputs___1_addr__h5385[1];
      default: IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d308 =
		   near_mem$imem_instr[6:0] != 7'b1100111 || eaddr__h5553[1];
    endcase
  end
  always@(near_mem$imem_instr or
	  near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_0b_ETC___d328)
  begin
    case (near_mem$imem_instr[6:0])
      7'b0010011, 7'b0110011:
	  CASE_near_memimem_instr_BITS_6_TO_0_0b10011_n_ETC__q9 =
	      near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_0b_ETC___d328;
      default: CASE_near_memimem_instr_BITS_6_TO_0_0b10011_n_ETC__q9 =
		   near_mem$imem_instr[6:0] == 7'b0110111 ||
		   near_mem$imem_instr[6:0] == 7'b0010111 ||
		   ((near_mem$imem_instr[6:0] == 7'b0000011) ?
		      near_mem$imem_instr[14:12] == 3'b0 ||
		      near_mem$imem_instr[14:12] == 3'b100 ||
		      near_mem$imem_instr[14:12] == 3'b001 ||
		      near_mem$imem_instr[14:12] == 3'b101 ||
		      near_mem$imem_instr[14:12] == 3'b010 :
		      near_mem$imem_instr[6:0] == 7'b0100011 &&
		      (near_mem$imem_instr[14:12] == 3'b0 ||
		       near_mem$imem_instr[14:12] == 3'b001 ||
		       near_mem$imem_instr[14:12] == 3'b010));
    endcase
  end
  always@(near_mem$imem_instr or
	  eaddr__h5553 or
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291 or
	  alu_outputs___1_val2__h5367 or
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 or
	  alu_outputs___1_addr__h5385)
  begin
    case (near_mem$imem_instr[6:0])
      7'b1100011:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352 =
	      (IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d291 ||
	       !alu_outputs___1_val2__h5367[1]) &&
	      (near_mem$imem_instr[14:12] == 3'b0 ||
	       near_mem$imem_instr[14:12] == 3'b001 ||
	       near_mem$imem_instr[14:12] == 3'b100 ||
	       near_mem$imem_instr[14:12] == 3'b101 ||
	       near_mem$imem_instr[14:12] == 3'b110 ||
	       near_mem$imem_instr[14:12] == 3'b111) &&
	      IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227;
      7'b1101111:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352 =
	      !alu_outputs___1_addr__h5385[1];
      default: IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352 =
		   near_mem$imem_instr[6:0] == 7'b1100111 && !eaddr__h5553[1];
    endcase
  end
  always@(near_mem$imem_instr or
	  rg_cur_priv or
	  IF_rg_cur_priv_9_EQ_0b11_75_OR_rg_cur_priv_9_E_ETC___d394)
  begin
    case (near_mem$imem_instr[31:20])
      12'b0, 12'b000000000001:
	  IF_near_mem_imem_instr__59_BITS_31_TO_20_02_EQ_ETC___d396 = 4'd11;
      default: IF_near_mem_imem_instr__59_BITS_31_TO_20_02_EQ_ETC___d396 =
		   (rg_cur_priv == 2'b11 &&
		    near_mem$imem_instr[31:20] == 12'b001100000010) ?
		     4'd7 :
		     IF_rg_cur_priv_9_EQ_0b11_75_OR_rg_cur_priv_9_E_ETC___d394;
    endcase
  end
  always@(near_mem$imem_instr)
  begin
    case (near_mem$imem_instr[14:12])
      3'b0, 3'b001, 3'b010, 3'b100, 3'b101:
	  CASE_near_memimem_instr_BITS_14_TO_12_0b0_0_0_ETC__q10 = 4'd0;
      default: CASE_near_memimem_instr_BITS_14_TO_12_0b0_0_0_ETC__q10 = 4'd11;
    endcase
  end
  always@(near_mem$imem_instr)
  begin
    case (near_mem$imem_instr[14:12])
      3'b0: CASE_near_memimem_instr_BITS_14_TO_12_0b0_4_0_ETC__q11 = 4'd4;
      3'b001: CASE_near_memimem_instr_BITS_14_TO_12_0b0_4_0_ETC__q11 = 4'd5;
      default: CASE_near_memimem_instr_BITS_14_TO_12_0b0_4_0_ETC__q11 = 4'd11;
    endcase
  end
  always@(near_mem$imem_instr)
  begin
    case (near_mem$imem_instr[14:12])
      3'b0, 3'b001, 3'b010:
	  CASE_near_memimem_instr_BITS_14_TO_12_0b0_0_0_ETC__q12 = 4'd0;
      default: CASE_near_memimem_instr_BITS_14_TO_12_0b0_0_0_ETC__q12 = 4'd11;
    endcase
  end
  always@(near_mem$imem_instr or
	  IF_near_mem_imem_instr__59_BITS_31_TO_20_02_EQ_ETC___d396)
  begin
    case (near_mem$imem_instr[14:12])
      3'b0:
	  CASE_near_memimem_instr_BITS_14_TO_12_0b0_IF__ETC__q13 =
	      (near_mem$imem_instr[11:7] == 5'd0 &&
	       near_mem$imem_instr[19:15] == 5'd0) ?
		IF_near_mem_imem_instr__59_BITS_31_TO_20_02_EQ_ETC___d396 :
		4'd11;
      3'b001, 3'b101:
	  CASE_near_memimem_instr_BITS_14_TO_12_0b0_IF__ETC__q13 = 4'd2;
      3'b010, 3'b011, 3'b110, 3'b111:
	  CASE_near_memimem_instr_BITS_14_TO_12_0b0_IF__ETC__q13 = 4'd3;
      3'd4: CASE_near_memimem_instr_BITS_14_TO_12_0b0_IF__ETC__q13 = 4'd11;
    endcase
  end
  always@(near_mem$imem_instr or
	  CASE_near_memimem_instr_BITS_14_TO_12_0b0_0_0_ETC__q10 or
	  CASE_near_memimem_instr_BITS_14_TO_12_0b0_4_0_ETC__q11 or
	  IF_NOT_near_mem_imem_instr__59_BITS_14_TO_12_8_ETC___d362 or
	  CASE_near_memimem_instr_BITS_14_TO_12_0b0_0_0_ETC__q12 or
	  CASE_near_memimem_instr_BITS_14_TO_12_0b0_IF__ETC__q13)
  begin
    case (near_mem$imem_instr[6:0])
      7'b0000011:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d409 =
	      CASE_near_memimem_instr_BITS_14_TO_12_0b0_0_0_ETC__q10;
      7'b0001111:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d409 =
	      CASE_near_memimem_instr_BITS_14_TO_12_0b0_4_0_ETC__q11;
      7'b0010011, 7'b0110011:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d409 =
	      IF_NOT_near_mem_imem_instr__59_BITS_14_TO_12_8_ETC___d362;
      7'b0010111, 7'b0110111:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d409 = 4'd0;
      7'b0100011:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d409 =
	      CASE_near_memimem_instr_BITS_14_TO_12_0b0_0_0_ETC__q12;
      7'b1110011:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d409 =
	      CASE_near_memimem_instr_BITS_14_TO_12_0b0_IF__ETC__q13;
      default: IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d409 =
		   4'd11;
    endcase
  end
  always@(near_mem$imem_instr or
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d409 or
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d285 or
	  IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 or
	  eaddr__h5553 or alu_outputs___1_addr__h5385)
  begin
    case (near_mem$imem_instr[6:0])
      7'b1100011:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d413 =
	      IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d285 ?
		4'd11 :
		(IF_near_mem_imem_instr__59_BITS_14_TO_12_81_EQ_ETC___d227 ?
		   4'd1 :
		   4'd0);
      7'b1100111:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d413 =
	      eaddr__h5553[1] ? 4'd11 : 4'd1;
      7'b1101111:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d413 =
	      alu_outputs___1_addr__h5385[1] ? 4'd11 : 4'd1;
      default: IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d413 =
		   ((near_mem$imem_instr[6:0] == 7'b0010011 ||
		     near_mem$imem_instr[6:0] == 7'b0110011) &&
		    (near_mem$imem_instr[14:12] == 3'b001 ||
		     near_mem$imem_instr[14:12] == 3'b101)) ?
		     (near_mem$imem_instr[25] ? 4'd11 : 4'd0) :
		     IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d409;
    endcase
  end
  always@(near_mem$imem_instr)
  begin
    case (near_mem$imem_instr[6:0])
      7'b0000011:
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 = 2'd1;
      7'b0010011,
      7'b0010111,
      7'b0110011,
      7'b0110111,
      7'b1100011,
      7'b1100111,
      7'b1101111:
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 = 2'd0;
      default: IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 =
		   2'd2;
    endcase
  end
  always@(near_mem$imem_instr or
	  alu_outputs___1_exc_code__h5362 or alu_outputs___1_exc_code__h5843)
  begin
    case (near_mem$imem_instr[6:0])
      7'b0000011,
      7'b0001111,
      7'b0010011,
      7'b0010111,
      7'b0100011,
      7'b0110011,
      7'b0110111:
	  alu_outputs_exc_code__h5862 = 4'd2;
      7'b1100011:
	  alu_outputs_exc_code__h5862 = alu_outputs___1_exc_code__h5362;
      7'b1100111, 7'b1101111: alu_outputs_exc_code__h5862 = 4'd0;
      7'b1110011:
	  alu_outputs_exc_code__h5862 = alu_outputs___1_exc_code__h5843;
      default: alu_outputs_exc_code__h5862 = 4'd2;
    endcase
  end
  always@(near_mem$imem_instr or
	  alu_outputs___1_val1__h5847 or
	  alu_outputs___1_val1__h5516 or rd_val__h5537 or rd_val__h5523)
  begin
    case (near_mem$imem_instr[6:0])
      7'b0010011, 7'b0110011:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d570 =
	      alu_outputs___1_val1__h5516;
      7'b0010111:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d570 =
	      rd_val__h5537;
      7'b0110111:
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d570 =
	      rd_val__h5523;
      default: IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d570 =
		   alu_outputs___1_val1__h5847;
    endcase
  end
  always@(near_mem$imem_instr or
	  IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d571 or
	  alu_outputs___1_val1__h5386)
  begin
    case (near_mem$imem_instr[6:0])
      7'b1100111, 7'b1101111:
	  x_out_data_to_stage2_val1__h5224 = alu_outputs___1_val1__h5386;
      default: x_out_data_to_stage2_val1__h5224 =
		   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d571;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == 1'b0)
      begin
        cfg_logdelay <=  64'd0;
	cfg_verbosity <=  4'd0;
	rg_cur_priv <=  2'b11;
	rg_retiring <=  1'd0;
	rg_run_on_reset <=  1'd0;
	rg_state <=  4'd0;
	s1_to_s2 <=  1'd0;
	s2_to_s3 <=  1'd0;
	s3_deq <=  1'd0;
	stage1_rg_full <=  1'd0;
	stage2_rg_full <=  1'd0;
	stage2_rg_resetting <=  1'd0;
	stage3_rg_full <=  1'd0;
      end
    else
      begin
        if (cfg_logdelay$EN)
	  cfg_logdelay <=  cfg_logdelay$D_IN;
	if (cfg_verbosity$EN)
	  cfg_verbosity <=  cfg_verbosity$D_IN;
	if (rg_cur_priv$EN)
	  rg_cur_priv <=  rg_cur_priv$D_IN;
	if (rg_retiring$EN)
	  rg_retiring <=  rg_retiring$D_IN;
	if (rg_run_on_reset$EN)
	  rg_run_on_reset <=  rg_run_on_reset$D_IN;
	if (rg_state$EN) rg_state <=  rg_state$D_IN;
	if (s1_to_s2$EN) s1_to_s2 <=  s1_to_s2$D_IN;
	if (s2_to_s3$EN) s2_to_s3 <=  s2_to_s3$D_IN;
	if (s3_deq$EN) s3_deq <=  s3_deq$D_IN;
	if (stage1_rg_full$EN)
	  stage1_rg_full <=  stage1_rg_full$D_IN;
	if (stage2_rg_full$EN)
	  stage2_rg_full <=  stage2_rg_full$D_IN;
	if (stage2_rg_resetting$EN)
	  stage2_rg_resetting <= 
	      stage2_rg_resetting$D_IN;
	if (stage3_rg_full$EN)
	  stage3_rg_full <=  stage3_rg_full$D_IN;
      end
    if (rg_csr_pc$EN) rg_csr_pc <=  rg_csr_pc$D_IN;
    if (rg_csr_val1$EN) rg_csr_val1 <=  rg_csr_val1$D_IN;
    if (rg_mstatus_MXR$EN)
      rg_mstatus_MXR <=  rg_mstatus_MXR$D_IN;
    if (rg_next_pc$EN) rg_next_pc <=  rg_next_pc$D_IN;
    if (rg_sstatus_SUM$EN)
      rg_sstatus_SUM <=  rg_sstatus_SUM$D_IN;
    if (rg_start_CPI_cycles$EN)
      rg_start_CPI_cycles <=  rg_start_CPI_cycles$D_IN;
    if (rg_start_CPI_instrs$EN)
      rg_start_CPI_instrs <=  rg_start_CPI_instrs$D_IN;
    if (rg_trap_info$EN)
      rg_trap_info <=  rg_trap_info$D_IN;
    if (rg_trap_instr$EN)
      rg_trap_instr <=  rg_trap_instr$D_IN;
    if (rg_trap_interrupt$EN)
      rg_trap_interrupt <=  rg_trap_interrupt$D_IN;
    if (stage2_rg_stage2$EN)
      stage2_rg_stage2 <=  stage2_rg_stage2$D_IN;
    if (stage3_rg_stage3$EN)
      stage3_rg_stage3 <=  stage3_rg_stage3$D_IN;
  end

  // synopsys translate_off
  
  




























 // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$display("================================================================");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$display("%0d: Pipeline State:  minstret:%0d  cur_priv:%0d  mstatus:%0x",
		 csr_regfile$read_csr_mcycle,
		 csr_regfile$read_csr_minstret,
		 rg_cur_priv,
		 csr_regfile$read_mstatus);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("    ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write("MStatus{",
	       "sd:%0d",
	       csr_regfile$read_mstatus[14:13] == 2'h3 ||
	       csr_regfile$read_mstatus[16:15] == 2'h3);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && csr_regfile$read_misa[27:26] == 2'd2)
	$write(" sxl:%0d uxl:%0d", 2'd0, 2'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && csr_regfile$read_misa[27:26] != 2'd2)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write(" tsr:%0d", csr_regfile$read_mstatus[22]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write(" tw:%0d", csr_regfile$read_mstatus[21]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write(" tvm:%0d", csr_regfile$read_mstatus[20]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write(" mxr:%0d", csr_regfile$read_mstatus[19]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write(" sum:%0d", csr_regfile$read_mstatus[18]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write(" mprv:%0d", csr_regfile$read_mstatus[17]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write(" xs:%0d", csr_regfile$read_mstatus[16:15]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write(" fs:%0d", csr_regfile$read_mstatus[14:13]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write(" mpp:%0d", csr_regfile$read_mstatus[12:11]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write(" spp:%0d", csr_regfile$read_mstatus[8]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write(" pies:%0d_%0d%0d",
	       csr_regfile$read_mstatus[7],
	       csr_regfile$read_mstatus[5],
	       csr_regfile$read_mstatus[4]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$write(" ies:%0d_%0d%0d",
	       csr_regfile$read_mstatus[3],
	       csr_regfile$read_mstatus[1],
	       csr_regfile$read_mstatus[0]);
    if (RST_N != 1'b0) if (WILL_FIRE_RL_rl_show_pipe) $write("}");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("    Stage3: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("Output_Stage3");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage3_rg_full) $write(" PIPE");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage3_rg_full) $write(" EMPTY");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("        Bypass  to Stage1: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("Bypass {");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  (!stage3_rg_full || !stage3_rg_stage3[37]))
	$write("Rd -");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage3_rg_full && stage3_rg_stage3[37])
	$write("Rd %0d ",
	       stage3_rg_stage3[36:32],
	       "rd_val:%h",
	       stage3_rg_stage3[31:0]);
    if (RST_N != 1'b0) if (WILL_FIRE_RL_rl_show_pipe) $write("}");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$display("    Stage2: pc 0x%08h instr 0x%08h priv %0d",
		 stage2_rg_stage2[166:135],
		 stage2_rg_stage2[134:103],
		 stage2_rg_stage2[168:167]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("        ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("Output_Stage2", " EMPTY");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("Output_Stage2", " BUSY: pc:%0h", stage2_rg_stage2[166:135]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("Output_Stage2", " NONPIPE: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("Output_Stage2", " PIPE: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("data_to_Stage3 {pc:%h  instr:%h  priv:%0d\n",
	       stage2_rg_stage2[166:135],
	       stage2_rg_stage2[134:103],
	       stage2_rg_stage2[168:167]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("        rd_valid:");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3 &&
	  stage2_rg_stage2[102:101] != 2'd0 &&
	  (!near_mem$dmem_valid || near_mem$dmem_exc))
	$write("False");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  NOT_IF_stage2_rg_full_3_THEN_IF_stage2_rg_stag_ETC___d109)
	$write("True");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("  grd:%0d  rd_val:%h\n",
	       x_out_data_to_stage3_rd__h4667,
	       x_out_data_to_stage3_rd_val__h4668);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("Trap_Info { ", "epc: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("'h%h", stage2_rg_stage2[166:135]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write(", ", "exc_code: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("'h%h", near_mem$dmem_exc_code);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write(", ", "tval: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("'h%h", stage2_rg_stage2[95:64], " }");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write(" ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("Trap_Info { ", "epc: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("'h%h", stage2_rg_stage2[166:135]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write(", ", "exc_code: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("'h%h", near_mem$dmem_exc_code);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write(", ", "tval: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd1)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd3)
	$write("'h%h", stage2_rg_stage2[95:64], " }");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd1 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 != 2'd3)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("        Bypass  to Stage1: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("Bypass {");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d142 == 2'd0)
	$write("Rd -");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d142 != 2'd0)
	$write("Rd %0d ", stage2_rg_stage2[100:96]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d142 == 2'd0)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d142 == 2'd1)
	$write("-");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d142 != 2'd0 &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d142 != 2'd1)
	$write("rd_val:%h", x_out_bypass_rd_val__h4969);
    if (RST_N != 1'b0) if (WILL_FIRE_RL_rl_show_pipe) $write("}");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe)
	$display("    Stage1: pc 0x%08h instr 0x%08h priv %0d",
		 near_mem$imem_pc,
		 near_mem$imem_instr,
		 rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("        ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("Output_Stage1", " BUSY pc:%h", near_mem$imem_pc);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("Output_Stage1", " NONPIPE: pc:%h", near_mem$imem_pc);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("Output_Stage1");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full)
	$write("Output_Stage1", " EMPTY");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write(" PIPE: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 == 4'd0)
	$write("CONTROL_STRAIGHT");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 == 4'd1)
	$write("CONTROL_BRANCH");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 == 4'd2)
	$write("CONTROL_CSRR_W");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 == 4'd3)
	$write("CONTROL_CSRR_S_or_C");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 == 4'd4)
	$write("CONTROL_FENCE");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 == 4'd5)
	$write("CONTROL_FENCE_I");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 == 4'd6)
	$write("CONTROL_SFENCE_VMA");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 == 4'd7)
	$write("CONTROL_MRET");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 == 4'd8)
	$write("CONTROL_SRET");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 == 4'd9)
	$write("CONTROL_URET");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d415 == 4'd10)
	$write("CONTROL_WFI");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  NOT_near_mem_imem_exc__78_13_AND_IF_near_mem_i_ETC___d481)
	$write("CONTROL_TRAP");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write(" ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("}");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("data_to_Stage 2 {pc:%h  instr:%h  priv:%0d\n",
	       near_mem$imem_pc,
	       near_mem$imem_instr,
	       rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("            op_stage2:");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 == 2'd0)
	$write("OP_Stage2_ALU");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 == 2'd1)
	$write("OP_Stage2_LD");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  !near_mem$imem_exc &&
	  (IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d343 ||
	   IF_near_mem_imem_instr__59_BITS_6_TO_0_79_EQ_0_ETC___d352) &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 != 2'd0 &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 != 2'd1)
	$write("OP_Stage2_ST");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("  rd:%0d\n", x_out_data_to_stage2_rd__h5222);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("            addr:%h  val1:%h  val2:%h}",
	       x_out_data_to_stage2_addr__h5223,
	       x_out_data_to_stage2_val1__h5224,
	       x_out_data_to_stage2_val2__h5225);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write(" ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d578)
	$write("CONTROL_STRAIGHT");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d581)
	$write("CONTROL_BRANCH");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d584)
	$write("CONTROL_CSRR_W");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d587)
	$write("CONTROL_CSRR_S_or_C");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d590)
	$write("CONTROL_FENCE");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d593)
	$write("CONTROL_FENCE_I");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d596)
	$write("CONTROL_SFENCE_VMA");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d599)
	$write("CONTROL_MRET");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d602)
	$write("CONTROL_SRET");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d605)
	$write("CONTROL_URET");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d608)
	$write("CONTROL_WFI");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d177 &&
	  near_mem_imem_exc__78_OR_IF_near_mem_imem_inst_ETC___d611)
	$write("CONTROL_TRAP");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write(" ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("Trap_Info { ", "epc: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("'h%h", near_mem$imem_pc);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write(", ", "exc_code: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("'h%h", x_out_trap_info_exc_code__h6928);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write(", ", "tval: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d311)
	$write("'h%h", value__h6967, " }");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  near_mem_imem_valid__57_AND_NOT_IF_stage2_rg_f_ETC___d355)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && stage1_rg_full &&
	  NOT_near_mem_imem_valid__57_58_OR_IF_stage2_rg_ETC___d166)
	$write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe && !stage1_rg_full) $write("");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_show_pipe) $display("----------------");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset_complete && rg_run_on_reset &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    CPU_Stage1.enq: 0x%08h",
		 soc_map$m_pc_reset_value[31:0]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset_complete && rg_run_on_reset)
	$display("%0d: %m.rl_reset_complete: restart at PC = 0x%0h",
		 csr_regfile$read_csr_mcycle,
		 soc_map$m_pc_reset_value[31:0]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset_complete && !rg_run_on_reset)
	$display("%0d: %m.rl_reset_complete: entering DEBUG_MODE",
		 csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_pipe", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe && stage3_rg_full && stage3_rg_stage3[37] &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    S3.fa_deq: write GRd 0x%0h, rd_val 0x%0h",
		 stage3_rg_stage3[36:32],
		 stage3_rg_stage3[31:0]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd2 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$write("    S3.enq: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd2 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$write("data_to_Stage3 {pc:%h  instr:%h  priv:%0d\n",
	       stage2_rg_stage2[166:135],
	       stage2_rg_stage2[134:103],
	       stage2_rg_stage2[168:167]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd2 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$write("        rd_valid:");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd2 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17 &&
	  stage2_rg_stage2[102:101] != 2'd0 &&
	  (!near_mem$dmem_valid || near_mem$dmem_exc))
	$write("False");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd2 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d730)
	$write("True");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd2 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$write("  grd:%0d  rd_val:%h\n",
	       x_out_data_to_stage3_rd__h4667,
	       x_out_data_to_stage3_rd_val__h4668);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd2 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  IF_stage2_rg_full_3_THEN_IF_stage2_rg_stage2_4_ETC___d86 == 2'd2 &&
	  cur_verbosity__h1827 == 4'd1)
	$display("instret:%0d  PC:0x%0h  instr:0x%0h  priv:%0d",
		 csr_regfile$read_csr_minstret,
		 stage2_rg_stage2[166:135],
		 stage2_rg_stage2[134:103],
		 rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$write("    CPU_Stage2.enq (Data_Stage1_to_Stage2) ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$write("data_to_Stage 2 {pc:%h  instr:%h  priv:%0d\n",
	       near_mem$imem_pc,
	       near_mem$imem_instr,
	       rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$write("            op_stage2:");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17 &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 == 2'd0)
	$write("OP_Stage2_ALU");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17 &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 == 2'd1)
	$write("OP_Stage2_LD");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17 &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 != 2'd0 &&
	  IF_NOT_stage1_rg_full_55_56_OR_NOT_near_mem_im_ETC___d491 != 2'd1)
	$write("OP_Stage2_ST");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$write("  rd:%0d\n", x_out_data_to_stage2_rd__h5222);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$write("            addr:%h  val1:%h  val2:%h}",
	       x_out_data_to_stage2_addr__h5223,
	       x_out_data_to_stage2_val1__h5224,
	       x_out_data_to_stage2_val2__h5225);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d737 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_pipe &&
	  NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d716 &&
	  NOT_csr_regfile_interrupt_pending_rg_cur_priv__ETC___d756 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    CPU_Stage1.enq: 0x%08h", x_out_next_pc__h5189);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage2_nonpipe &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage2_nonpipe", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_trap &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_trap", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_trap &&
	  rg_trap_info_04_BITS_67_TO_36_05_EQ_csr_regfil_ETC___d814)
	$display("%0d: %m.rl_stage1_trap: Tight infinite trap loop: pc 0x%0x instr 0x%08x",
		 csr_regfile$read_csr_mcycle,
		 csr_regfile$csr_trap_actions[97:66],
		 rg_trap_instr);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_trap &&
	  rg_trap_info_04_BITS_67_TO_36_05_EQ_csr_regfil_ETC___d814)
	$display("CPI: %0d.%0d = (%0d/%0d) since last 'continue'",
		 cpi__h10745,
		 cpifrac__h10746,
		 delta_CPI_cycles__h10741,
		 _theResult____h10743);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_trap &&
	  rg_trap_info_04_BITS_67_TO_36_05_EQ_csr_regfil_ETC___d814)
	$finish(32'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_trap && cur_verbosity__h1827 == 4'd1)
	$display("instret:%0d  PC:0x%0h  instr:0x%0h  priv:%0d",
		 csr_regfile$read_csr_minstret,
		 rg_trap_info[67:36],
		 rg_trap_instr,
		 rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_trap && cur_verbosity__h1827 != 4'd0)
	$display("    mcause:0x%0h  epc 0x%0h  tval:0x%0h  next_pc 0x%0h, new_priv %0d new_mstatus 0x%0h",
		 csr_regfile$csr_trap_actions[33:2],
		 rg_trap_info[67:36],
		 rg_trap_info[31:0],
		 csr_regfile$csr_trap_actions[97:66],
		 csr_regfile$csr_trap_actions[1:0],
		 csr_regfile$csr_trap_actions[65:34]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_CSRR_W &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_CSRR_W", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_CSRR_W_2 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_CSRR_W_2", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_CSRR_W_2 && csr_regfile$access_permitted_1 &&
	  cur_verbosity__h1827 == 4'd1)
	$display("instret:%0d  PC:0x%0h  instr:0x%0h  priv:%0d",
		 csr_regfile$read_csr_minstret,
		 rg_csr_pc,
		 rg_trap_instr,
		 rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_CSRR_W_2 && csr_regfile$access_permitted_1 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    S1: write CSRRW/CSRRWI Rs1 %0d Rs1_val 0x%0h csr 0x%0h csr_val 0x%0h Rd %0d",
		 rg_trap_instr[19:15],
		 rs1_val__h11213,
		 rg_trap_instr[31:20],
		 csr_regfile$read_csr[31:0],
		 rg_trap_instr[11:7]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_CSRR_W_2 &&
	  !csr_regfile$access_permitted_1 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    rl_stage1_CSRR_W: Trap on CSR permissions: Rs1 %0d Rs1_val 0x%0h csr 0x%0h Rd %0d",
		 rg_trap_instr[19:15],
		 rs1_val__h11213,
		 rg_trap_instr[31:20],
		 rg_trap_instr[11:7]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_CSRR_S_or_C &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_CSRR_S_or_C",
		 csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_CSRR_S_or_C_2",
		 csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2 &&
	  csr_regfile$access_permitted_2 &&
	  cur_verbosity__h1827 == 4'd1)
	$display("instret:%0d  PC:0x%0h  instr:0x%0h  priv:%0d",
		 csr_regfile$read_csr_minstret,
		 rg_csr_pc,
		 rg_trap_instr,
		 rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2 &&
	  csr_regfile$access_permitted_2 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    S1: write CSRR_S_or_C: Rs1 %0d Rs1_val 0x%0h csr 0x%0h csr_val 0x%0h Rd %0d",
		 rg_trap_instr[19:15],
		 rs1_val__h11920,
		 rg_trap_instr[31:20],
		 csr_regfile$read_csr[31:0],
		 rg_trap_instr[11:7]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_CSRR_S_or_C_2 &&
	  !csr_regfile$access_permitted_2 &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    rl_stage1_CSRR_S_or_C: Trap on CSR permissions: Rs1 %0d Rs1_val 0x%0h csr 0x%0h Rd %0d",
		 rg_trap_instr[19:15],
		 rs1_val__h11920,
		 rg_trap_instr[31:20],
		 rg_trap_instr[11:7]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_restart_after_csrrx &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    CPU_Stage1.enq: 0x%08h", x_out_next_pc__h5189);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_restart_after_csrrx &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: rl_stage1_restart_after_csrrx: minstret:%0d  pc:%0x  cur_priv:%0d",
		 csr_regfile$read_csr_mcycle,
		 csr_regfile$read_csr_minstret,
		 x_out_next_pc__h5189,
		 rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_xRET &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_xRET", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_xRET && cur_verbosity__h1827 == 4'd1)
	$display("instret:%0d  PC:0x%0h  instr:0x%0h  priv:%0d",
		 csr_regfile$read_csr_minstret,
		 near_mem$imem_pc,
		 near_mem$imem_instr,
		 rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_xRET && cur_verbosity__h1827 != 4'd0)
	$display("    xRET: next_pc:0x%0h  new mstatus:0x%0h  new priv:%0d",
		 csr_regfile$csr_ret_actions[65:34],
		 csr_regfile$csr_ret_actions[31:0],
		 csr_regfile$csr_ret_actions[33:32]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_FENCE_I &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_FENCE_I", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_FENCE_I && cur_verbosity__h1827 == 4'd1)
	$display("instret:%0d  PC:0x%0h  instr:0x%0h  priv:%0d",
		 csr_regfile$read_csr_minstret,
		 near_mem$imem_pc,
		 near_mem$imem_instr,
		 rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_FENCE_I &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_FENCE_I", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_finish_FENCE_I &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_finish_FENCE_I", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_finish_FENCE_I &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    CPU_Stage1.enq: 0x%08h", rg_next_pc);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_finish_FENCE_I &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    CPU.rl_finish_FENCE_I");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_FENCE &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_FENCE", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_FENCE && cur_verbosity__h1827 == 4'd1)
	$display("instret:%0d  PC:0x%0h  instr:0x%0h  priv:%0d",
		 csr_regfile$read_csr_minstret,
		 near_mem$imem_pc,
		 near_mem$imem_instr,
		 rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_FENCE &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_FENCE", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_finish_FENCE &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_finish_FENCE", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_finish_FENCE &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    CPU_Stage1.enq: 0x%08h", rg_next_pc);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_finish_FENCE &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    CPU.rl_finish_FENCE");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_SFENCE_VMA &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_SFENCE_VMA", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_SFENCE_VMA && cur_verbosity__h1827 == 4'd1)
	$display("instret:%0d  PC:0x%0h  instr:0x%0h  priv:%0d",
		 csr_regfile$read_csr_minstret,
		 near_mem$imem_pc,
		 near_mem$imem_instr,
		 rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_SFENCE_VMA &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_SFENCE_VMA", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_finish_SFENCE_VMA &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_finish_SFENCE_VMA", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_finish_SFENCE_VMA &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    CPU_Stage1.enq: 0x%08h", rg_next_pc);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_finish_SFENCE_VMA &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    CPU.rl_finish_SFENCE_VMA");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_WFI &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_WFI", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_WFI && cur_verbosity__h1827 == 4'd1)
	$display("instret:%0d  PC:0x%0h  instr:0x%0h  priv:%0d",
		 csr_regfile$read_csr_minstret,
		 near_mem$imem_pc,
		 near_mem$imem_instr,
		 rg_cur_priv);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_WFI &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    CPU.rl_stage1_WFI");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_WFI_resume &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_WFI_resume", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_WFI_resume && cur_verbosity__h1827 != 4'd0)
	$display("    WFI resume");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_WFI_resume &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    CPU_Stage1.enq: 0x%08h", rg_next_pc);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset_from_WFI &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_reset_from_WFI", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_trap_fetch &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("    CPU_Stage1.enq: 0x%08h", rg_next_pc);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_stage1_interrupt &&
	  NOT_IF_csr_regfile_read_csr_minstret__1_ULT_cf_ETC___d17)
	$display("%0d: %m.rl_stage1_interrupt", csr_regfile$read_csr_mcycle);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset_start)
	$display("================================================================");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset_start)
	$write("CPU: Bluespec  RISC-V  Piccolo  v3.0");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset_start) $display(" (RV32)");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset_start)
	$display("Copyright (c) 2016-2019 Bluespec, Inc. All Rights Reserved.");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset_start)
	$display("================================================================");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset_start && cur_verbosity__h1827 != 4'd0)
	$display("%0d: %m.rl_reset_start", csr_regfile$read_csr_mcycle);
  end
  // synopsys translate_on
 assign RTL__DOT__s3_deq$D_IN = s3_deq$D_IN;
 assign RTL__DOT__near_mem$dmem_exc = near_mem$dmem_exc;
 assign RTL__DOT__near_mem$imem_pc = near_mem$imem_pc;
 assign RTL__DOT__near_mem$imem_instr = near_mem$imem_instr;
 assign RTL__DOT__near_mem$dmem_req_addr = near_mem$dmem_req_addr;
 assign RTL__DOT__stage2_rg_stage2 = stage2_rg_stage2;
 assign RTL__DOT__rg_cur_priv = rg_cur_priv;
 assign RTL__DOT__near_mem$EN_dmem_req = near_mem$EN_dmem_req;
 assign RTL__DOT__near_mem$dmem_req_f3 = near_mem$dmem_req_f3;
 assign RTL__DOT__s1_to_s2$D_IN = s1_to_s2$D_IN;
 assign RTL__DOT__near_mem$dmem_word64 = near_mem$dmem_word64;
 assign RTL__DOT__stage3_rg_full = stage3_rg_full;
 assign RTL__DOT__rg_trap_instr = rg_trap_instr;
 assign RTL__DOT__near_mem$dmem_req_op = near_mem$dmem_req_op;
 assign RTL__DOT__s2_to_s3$D_IN = s2_to_s3$D_IN;
 assign RTL__DOT__rg_retiring$EN = rg_retiring$EN;
 assign RTL__DOT__rg_state = rg_state;
 assign RTL__DOT__s3_deq$EN = s3_deq$EN;
 assign RTL__DOT__s1_to_s2$EN = s1_to_s2$EN;
 assign RTL__DOT__s2_to_s3$EN = s2_to_s3$EN;
 assign RTL__DOT__rg_run_on_reset = rg_run_on_reset;
 assign RTL__DOT__stage1_rg_full = stage1_rg_full;
 assign RTL__DOT__stage2_rg_full = stage2_rg_full;
 assign RTL__DOT__near_mem$dmem_req_store_value = near_mem$dmem_req_store_value;
endmodule  // mkCPU

//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
//
//
//
// Ports:
// Name                         I/O  size props
// fv_read                        O    32
// fav_write                      O    32
// CLK                            I     1 clock
// RST_N                          I     1 reset
// fav_write_misa                 I    28
// fav_write_wordxl               I    32
// EN_reset                       I     1
// EN_fav_write                   I     1
//
// Combinational paths from inputs to outputs:
//   (fav_write_misa, fav_write_wordxl) -> fav_write
//
//










  
  


module mkCSR_MIE(CLK,
		 RST_N,

		 EN_reset,

		 fv_read,

		 fav_write_misa,
		 fav_write_wordxl,
		 EN_fav_write,
		 fav_write);
  input  CLK;
  input  RST_N;

  // action method reset
  input  EN_reset;

  // value method fv_read
  output [31 : 0] fv_read;

  // actionvalue method fav_write
  input  [27 : 0] fav_write_misa;
  input  [31 : 0] fav_write_wordxl;
  input  EN_fav_write;
  output [31 : 0] fav_write;

  // signals for module outputs
  wire [31 : 0] fav_write, fv_read;

  // register rg_mie
  reg [11 : 0] rg_mie;
  wire [11 : 0] rg_mie$D_IN;
  wire rg_mie$EN;

  // rule scheduling signals
  wire CAN_FIRE_fav_write,
       CAN_FIRE_reset,
       WILL_FIRE_fav_write,
       WILL_FIRE_reset;

  // remaining internal signals
  wire [11 : 0] mie__h88;
  wire seie__h119, ssie__h113, stie__h116, ueie__h118, usie__h112, utie__h115;

  // action method reset
  assign CAN_FIRE_reset = 1'd1 ;
  assign WILL_FIRE_reset = EN_reset ;

  // value method fv_read
  assign fv_read = { 20'd0, rg_mie } ;

  // actionvalue method fav_write
  assign fav_write = { 20'd0, mie__h88 } ;
  assign CAN_FIRE_fav_write = 1'd1 ;
  assign WILL_FIRE_fav_write = EN_fav_write ;

  // register rg_mie
  assign rg_mie$D_IN = EN_fav_write ? mie__h88 : 12'd0 ;
  assign rg_mie$EN = EN_fav_write || EN_reset ;

  // remaining internal signals
  assign mie__h88 =
	     { fav_write_wordxl[11],
	       1'b0,
	       seie__h119,
	       ueie__h118,
	       fav_write_wordxl[7],
	       1'b0,
	       stie__h116,
	       utie__h115,
	       fav_write_wordxl[3],
	       1'b0,
	       ssie__h113,
	       usie__h112 } ;
  assign seie__h119 = fav_write_misa[18] && fav_write_wordxl[9] ;
  assign ssie__h113 = fav_write_misa[18] && fav_write_wordxl[1] ;
  assign stie__h116 = fav_write_misa[18] && fav_write_wordxl[5] ;
  assign ueie__h118 = fav_write_misa[13] && fav_write_wordxl[8] ;
  assign usie__h112 = fav_write_misa[13] && fav_write_wordxl[0] ;
  assign utie__h115 = fav_write_misa[13] && fav_write_wordxl[4] ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == 1'b0)
      begin
        rg_mie <=  12'd0;
      end
    else
      begin
        if (rg_mie$EN) rg_mie <=  rg_mie$D_IN;
      end
  end

  // synopsys translate_off
  
  




 // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkCSR_MIE

//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
//
//
//
// Ports:
// Name                         I/O  size props
// fv_read                        O    32
// fav_write                      O    32
// CLK                            I     1 clock
// RST_N                          I     1 reset
// fav_write_misa                 I    28
// fav_write_wordxl               I    32
// m_external_interrupt_req_req   I     1 reg
// s_external_interrupt_req_req   I     1 reg
// software_interrupt_req_req     I     1 reg
// timer_interrupt_req_req        I     1 reg
// EN_reset                       I     1
// EN_fav_write                   I     1
//
// Combinational paths from inputs to outputs:
//   (fav_write_misa, fav_write_wordxl) -> fav_write
//
//










  
  


module mkCSR_MIP(CLK,
		 RST_N,

		 EN_reset,

		 fv_read,

		 fav_write_misa,
		 fav_write_wordxl,
		 EN_fav_write,
		 fav_write,

		 m_external_interrupt_req_req,

		 s_external_interrupt_req_req,

		 software_interrupt_req_req,

		 timer_interrupt_req_req);
  input  CLK;
  input  RST_N;

  // action method reset
  input  EN_reset;

  // value method fv_read
  output [31 : 0] fv_read;

  // actionvalue method fav_write
  input  [27 : 0] fav_write_misa;
  input  [31 : 0] fav_write_wordxl;
  input  EN_fav_write;
  output [31 : 0] fav_write;

  // action method m_external_interrupt_req
  input  m_external_interrupt_req_req;

  // action method s_external_interrupt_req
  input  s_external_interrupt_req_req;

  // action method software_interrupt_req
  input  software_interrupt_req_req;

  // action method timer_interrupt_req
  input  timer_interrupt_req_req;

  // signals for module outputs
  wire [31 : 0] fav_write, fv_read;

  // register rg_meip
  reg rg_meip;
  wire rg_meip$D_IN, rg_meip$EN;

  // register rg_msip
  reg rg_msip;
  wire rg_msip$D_IN, rg_msip$EN;

  // register rg_mtip
  reg rg_mtip;
  wire rg_mtip$D_IN, rg_mtip$EN;

  // register rg_seip
  reg rg_seip;
  wire rg_seip$D_IN, rg_seip$EN;

  // register rg_ssip
  reg rg_ssip;
  wire rg_ssip$D_IN, rg_ssip$EN;

  // register rg_stip
  reg rg_stip;
  wire rg_stip$D_IN, rg_stip$EN;

  // register rg_ueip
  reg rg_ueip;
  wire rg_ueip$D_IN, rg_ueip$EN;

  // register rg_usip
  reg rg_usip;
  wire rg_usip$D_IN, rg_usip$EN;

  // register rg_utip
  reg rg_utip;
  wire rg_utip$D_IN, rg_utip$EN;

  // rule scheduling signals
  wire CAN_FIRE_fav_write,
       CAN_FIRE_m_external_interrupt_req,
       CAN_FIRE_reset,
       CAN_FIRE_s_external_interrupt_req,
       CAN_FIRE_software_interrupt_req,
       CAN_FIRE_timer_interrupt_req,
       WILL_FIRE_fav_write,
       WILL_FIRE_m_external_interrupt_req,
       WILL_FIRE_reset,
       WILL_FIRE_s_external_interrupt_req,
       WILL_FIRE_software_interrupt_req,
       WILL_FIRE_timer_interrupt_req;

  // remaining internal signals
  wire [11 : 0] new_mip__h524, new_mip__h942;
  wire seip__h558, ssip__h562, stip__h560, ueip__h559, usip__h563, utip__h561;

  // action method reset
  assign CAN_FIRE_reset = 1'd1 ;
  assign WILL_FIRE_reset = EN_reset ;

  // value method fv_read
  assign fv_read = { 20'd0, new_mip__h524 } ;

  // actionvalue method fav_write
  assign fav_write = { 20'd0, new_mip__h942 } ;
  assign CAN_FIRE_fav_write = 1'd1 ;
  assign WILL_FIRE_fav_write = EN_fav_write ;

  // action method m_external_interrupt_req
  assign CAN_FIRE_m_external_interrupt_req = 1'd1 ;
  assign WILL_FIRE_m_external_interrupt_req = 1'd1 ;

  // action method s_external_interrupt_req
  assign CAN_FIRE_s_external_interrupt_req = 1'd1 ;
  assign WILL_FIRE_s_external_interrupt_req = 1'd1 ;

  // action method software_interrupt_req
  assign CAN_FIRE_software_interrupt_req = 1'd1 ;
  assign WILL_FIRE_software_interrupt_req = 1'd1 ;

  // action method timer_interrupt_req
  assign CAN_FIRE_timer_interrupt_req = 1'd1 ;
  assign WILL_FIRE_timer_interrupt_req = 1'd1 ;

  // register rg_meip
  assign rg_meip$D_IN = m_external_interrupt_req_req ;
  assign rg_meip$EN = 1'b1 ;

  // register rg_msip
  assign rg_msip$D_IN = software_interrupt_req_req ;
  assign rg_msip$EN = 1'b1 ;

  // register rg_mtip
  assign rg_mtip$D_IN = timer_interrupt_req_req ;
  assign rg_mtip$EN = 1'b1 ;

  // register rg_seip
  assign rg_seip$D_IN = s_external_interrupt_req_req ;
  assign rg_seip$EN = 1'b1 ;

  // register rg_ssip
  assign rg_ssip$D_IN = !EN_reset && ssip__h562 ;
  assign rg_ssip$EN = EN_fav_write || EN_reset ;

  // register rg_stip
  assign rg_stip$D_IN = !EN_reset && stip__h560 ;
  assign rg_stip$EN = EN_fav_write || EN_reset ;

  // register rg_ueip
  assign rg_ueip$D_IN = !EN_reset && ueip__h559 ;
  assign rg_ueip$EN = EN_fav_write || EN_reset ;

  // register rg_usip
  assign rg_usip$D_IN = !EN_reset && usip__h563 ;
  assign rg_usip$EN = EN_fav_write || EN_reset ;

  // register rg_utip
  assign rg_utip$D_IN = !EN_reset && utip__h561 ;
  assign rg_utip$EN = EN_fav_write || EN_reset ;

  // remaining internal signals
  assign new_mip__h524 =
	     { rg_meip,
	       1'b0,
	       rg_seip,
	       rg_ueip,
	       rg_mtip,
	       1'b0,
	       rg_stip,
	       rg_utip,
	       rg_msip,
	       1'b0,
	       rg_ssip,
	       rg_usip } ;
  assign new_mip__h942 =
	     { rg_meip,
	       1'b0,
	       seip__h558,
	       ueip__h559,
	       rg_mtip,
	       1'b0,
	       stip__h560,
	       utip__h561,
	       rg_msip,
	       1'b0,
	       ssip__h562,
	       usip__h563 } ;
  assign seip__h558 = fav_write_misa[18] && fav_write_wordxl[9] ;
  assign ssip__h562 = fav_write_misa[18] && fav_write_wordxl[1] ;
  assign stip__h560 = fav_write_misa[18] && fav_write_wordxl[5] ;
  assign ueip__h559 = fav_write_misa[13] && fav_write_wordxl[8] ;
  assign usip__h563 = fav_write_misa[13] && fav_write_wordxl[0] ;
  assign utip__h561 = fav_write_misa[13] && fav_write_wordxl[4] ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == 1'b0)
      begin
        rg_meip <=  1'd0;
	rg_msip <=  1'd0;
	rg_mtip <=  1'd0;
	rg_seip <=  1'd0;
	rg_ssip <=  1'd0;
	rg_stip <=  1'd0;
	rg_ueip <=  1'd0;
	rg_usip <=  1'd0;
	rg_utip <=  1'd0;
      end
    else
      begin
        if (rg_meip$EN) rg_meip <=  rg_meip$D_IN;
	if (rg_msip$EN) rg_msip <=  rg_msip$D_IN;
	if (rg_mtip$EN) rg_mtip <=  rg_mtip$D_IN;
	if (rg_seip$EN) rg_seip <=  rg_seip$D_IN;
	if (rg_ssip$EN) rg_ssip <=  rg_ssip$D_IN;
	if (rg_stip$EN) rg_stip <=  rg_stip$D_IN;
	if (rg_ueip$EN) rg_ueip <=  rg_ueip$D_IN;
	if (rg_usip$EN) rg_usip <=  rg_usip$D_IN;
	if (rg_utip$EN) rg_utip <=  rg_utip$D_IN;
      end
  end

  // synopsys translate_off
  
  












 // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkCSR_MIP

//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
//
//
//
// Ports:
// Name                         I/O  size props
// RDY_server_reset_request_put   O     1 reg
// RDY_server_reset_response_get  O     1
// read_csr                       O    33
// read_csr_port2                 O    33
// mav_read_csr                   O    33
// mav_csr_write                  O    32
// read_misa                      O    28 const
// read_mstatus                   O    32 reg
// read_ustatus                   O    32
// read_satp                      O    32 const
// csr_trap_actions               O    98
// RDY_csr_trap_actions           O     1 const
// csr_ret_actions                O    66
// RDY_csr_ret_actions            O     1 const
// read_csr_minstret              O    64 reg
// read_csr_mcycle                O    64 reg
// read_csr_mtime                 O    64 reg
// access_permitted_1             O     1
// access_permitted_2             O     1
// csr_counter_read_fault         O     1
// csr_mip_read                   O    32
// interrupt_pending              O     5
// wfi_resume                     O     1
// nmi_pending                    O     1 reg
// RDY_debug                      O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// read_csr_csr_addr              I    12
// read_csr_port2_csr_addr        I    12
// mav_read_csr_csr_addr          I    12
// mav_csr_write_csr_addr         I    12
// mav_csr_write_word             I    32
// csr_trap_actions_from_priv     I     2
// csr_trap_actions_pc            I    32
// csr_trap_actions_nmi           I     1
// csr_trap_actions_interrupt     I     1
// csr_trap_actions_exc_code      I     4
// csr_trap_actions_xtval         I    32
// csr_ret_actions_from_priv      I     2
// access_permitted_1_priv        I     2
// access_permitted_1_csr_addr    I    12
// access_permitted_1_read_not_write  I     1
// access_permitted_2_priv        I     2
// access_permitted_2_csr_addr    I    12
// access_permitted_2_read_not_write  I     1
// csr_counter_read_fault_priv    I     2
// csr_counter_read_fault_csr_addr  I    12
// m_external_interrupt_req_set_not_clear  I     1 reg
// s_external_interrupt_req_set_not_clear  I     1 reg
// timer_interrupt_req_set_not_clear  I     1 reg
// software_interrupt_req_set_not_clear  I     1 reg
// interrupt_pending_cur_priv     I     2
// nmi_req_set_not_clear          I     1
// EN_server_reset_request_put    I     1
// EN_server_reset_response_get   I     1
// EN_csr_minstret_incr           I     1
// EN_debug                       I     1 unused
// EN_mav_read_csr                I     1 unused
// EN_mav_csr_write               I     1
// EN_csr_trap_actions            I     1
// EN_csr_ret_actions             I     1
//
// Combinational paths from inputs to outputs:
//   read_csr_csr_addr -> read_csr
//   read_csr_port2_csr_addr -> read_csr_port2
//   (access_permitted_1_priv,
//    access_permitted_1_csr_addr,
//    access_permitted_1_read_not_write) -> access_permitted_1
//   (access_permitted_2_priv,
//    access_permitted_2_csr_addr,
//    access_permitted_2_read_not_write) -> access_permitted_2
//   (csr_counter_read_fault_priv,
//    csr_counter_read_fault_csr_addr) -> csr_counter_read_fault
//   interrupt_pending_cur_priv -> interrupt_pending
//   mav_read_csr_csr_addr -> mav_read_csr
//   (mav_csr_write_csr_addr,
//    mav_csr_write_word,
//    EN_mav_csr_write) -> mav_csr_write
//   (csr_trap_actions_from_priv,
//    csr_trap_actions_nmi,
//    csr_trap_actions_interrupt,
//    csr_trap_actions_exc_code) -> csr_trap_actions
//   csr_ret_actions_from_priv -> csr_ret_actions
//
//










  
  


module mkCSR_RegFile(CLK,
		     RST_N,

		     EN_server_reset_request_put,
		     RDY_server_reset_request_put,

		     EN_server_reset_response_get,
		     RDY_server_reset_response_get,

		     read_csr_csr_addr,
		     read_csr,

		     read_csr_port2_csr_addr,
		     read_csr_port2,

		     mav_read_csr_csr_addr,
		     EN_mav_read_csr,
		     mav_read_csr,

		     mav_csr_write_csr_addr,
		     mav_csr_write_word,
		     EN_mav_csr_write,
		     mav_csr_write,

		     read_misa,

		     read_mstatus,

		     read_ustatus,

		     read_satp,

		     csr_trap_actions_from_priv,
		     csr_trap_actions_pc,
		     csr_trap_actions_nmi,
		     csr_trap_actions_interrupt,
		     csr_trap_actions_exc_code,
		     csr_trap_actions_xtval,
		     EN_csr_trap_actions,
		     csr_trap_actions,
		     RDY_csr_trap_actions,

		     csr_ret_actions_from_priv,
		     EN_csr_ret_actions,
		     csr_ret_actions,
		     RDY_csr_ret_actions,

		     read_csr_minstret,

		     EN_csr_minstret_incr,

		     read_csr_mcycle,

		     read_csr_mtime,

		     access_permitted_1_priv,
		     access_permitted_1_csr_addr,
		     access_permitted_1_read_not_write,
		     access_permitted_1,

		     access_permitted_2_priv,
		     access_permitted_2_csr_addr,
		     access_permitted_2_read_not_write,
		     access_permitted_2,

		     csr_counter_read_fault_priv,
		     csr_counter_read_fault_csr_addr,
		     csr_counter_read_fault,

		     csr_mip_read,

		     m_external_interrupt_req_set_not_clear,

		     s_external_interrupt_req_set_not_clear,

		     timer_interrupt_req_set_not_clear,

		     software_interrupt_req_set_not_clear,

		     interrupt_pending_cur_priv,
		     interrupt_pending,

		     wfi_resume,

		     nmi_req_set_not_clear,

		     nmi_pending,

		     EN_debug,
		     RDY_debug, RTL__DOT__csr_regfile__DOT__rg_nmi, RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__csr_regfile__DOT__rg_state);
 output  RTL__DOT__csr_regfile__DOT__rg_nmi;
 output  RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__csr_regfile__DOT__rg_state;
  input  CLK;
  input  RST_N;

  // action method server_reset_request_put
  input  EN_server_reset_request_put;
  output RDY_server_reset_request_put;

  // action method server_reset_response_get
  input  EN_server_reset_response_get;
  output RDY_server_reset_response_get;

  // value method read_csr
  input  [11 : 0] read_csr_csr_addr;
  output [32 : 0] read_csr;

  // value method read_csr_port2
  input  [11 : 0] read_csr_port2_csr_addr;
  output [32 : 0] read_csr_port2;

  // actionvalue method mav_read_csr
  input  [11 : 0] mav_read_csr_csr_addr;
  input  EN_mav_read_csr;
  output [32 : 0] mav_read_csr;

  // actionvalue method mav_csr_write
  input  [11 : 0] mav_csr_write_csr_addr;
  input  [31 : 0] mav_csr_write_word;
  input  EN_mav_csr_write;
  output [31 : 0] mav_csr_write;

  // value method read_misa
  output [27 : 0] read_misa;

  // value method read_mstatus
  output [31 : 0] read_mstatus;

  // value method read_ustatus
  output [31 : 0] read_ustatus;

  // value method read_satp
  output [31 : 0] read_satp;

  // actionvalue method csr_trap_actions
  input  [1 : 0] csr_trap_actions_from_priv;
  input  [31 : 0] csr_trap_actions_pc;
  input  csr_trap_actions_nmi;
  input  csr_trap_actions_interrupt;
  input  [3 : 0] csr_trap_actions_exc_code;
  input  [31 : 0] csr_trap_actions_xtval;
  input  EN_csr_trap_actions;
  output [97 : 0] csr_trap_actions;
  output RDY_csr_trap_actions;

  // actionvalue method csr_ret_actions
  input  [1 : 0] csr_ret_actions_from_priv;
  input  EN_csr_ret_actions;
  output [65 : 0] csr_ret_actions;
  output RDY_csr_ret_actions;

  // value method read_csr_minstret
  output [63 : 0] read_csr_minstret;

  // action method csr_minstret_incr
  input  EN_csr_minstret_incr;

  // value method read_csr_mcycle
  output [63 : 0] read_csr_mcycle;

  // value method read_csr_mtime
  output [63 : 0] read_csr_mtime;

  // value method access_permitted_1
  input  [1 : 0] access_permitted_1_priv;
  input  [11 : 0] access_permitted_1_csr_addr;
  input  access_permitted_1_read_not_write;
  output access_permitted_1;

  // value method access_permitted_2
  input  [1 : 0] access_permitted_2_priv;
  input  [11 : 0] access_permitted_2_csr_addr;
  input  access_permitted_2_read_not_write;
  output access_permitted_2;

  // value method csr_counter_read_fault
  input  [1 : 0] csr_counter_read_fault_priv;
  input  [11 : 0] csr_counter_read_fault_csr_addr;
  output csr_counter_read_fault;

  // value method csr_mip_read
  output [31 : 0] csr_mip_read;

  // action method m_external_interrupt_req
  input  m_external_interrupt_req_set_not_clear;

  // action method s_external_interrupt_req
  input  s_external_interrupt_req_set_not_clear;

  // action method timer_interrupt_req
  input  timer_interrupt_req_set_not_clear;

  // action method software_interrupt_req
  input  software_interrupt_req_set_not_clear;

  // value method interrupt_pending
  input  [1 : 0] interrupt_pending_cur_priv;
  output [4 : 0] interrupt_pending;

  // value method wfi_resume
  output wfi_resume;

  // action method nmi_req
  input  nmi_req_set_not_clear;

  // value method nmi_pending
  output nmi_pending;

  // action method debug
  input  EN_debug;
  output RDY_debug;

  // signals for module outputs
  wire [97 : 0] csr_trap_actions;
  wire [65 : 0] csr_ret_actions;
  wire [63 : 0] read_csr_mcycle, read_csr_minstret, read_csr_mtime;
  wire [32 : 0] mav_read_csr, read_csr, read_csr_port2;
  wire [31 : 0] csr_mip_read,
		mav_csr_write,
		read_mstatus,
		read_satp,
		read_ustatus;
  wire [27 : 0] read_misa;
  wire [4 : 0] interrupt_pending;
  wire RDY_csr_ret_actions,
       RDY_csr_trap_actions,
       RDY_debug,
       RDY_server_reset_request_put,
       RDY_server_reset_response_get,
       access_permitted_1,
       access_permitted_2,
       csr_counter_read_fault,
       nmi_pending,
       wfi_resume;

  // register cfg_verbosity
  reg [3 : 0] cfg_verbosity;
  wire [3 : 0] cfg_verbosity$D_IN;
  wire cfg_verbosity$EN;

  // register csr_mstatus_rg_mstatus
  reg [31 : 0] csr_mstatus_rg_mstatus;
  reg [31 : 0] csr_mstatus_rg_mstatus$D_IN;
  wire csr_mstatus_rg_mstatus$EN;

  // register rg_dcsr
  reg [31 : 0] rg_dcsr;
  wire [31 : 0] rg_dcsr$D_IN;
  wire rg_dcsr$EN;

  // register rg_dpc
  reg [31 : 0] rg_dpc;
  wire [31 : 0] rg_dpc$D_IN;
  wire rg_dpc$EN;

  // register rg_dscratch0
  reg [31 : 0] rg_dscratch0;
  wire [31 : 0] rg_dscratch0$D_IN;
  wire rg_dscratch0$EN;

  // register rg_dscratch1
  reg [31 : 0] rg_dscratch1;
  wire [31 : 0] rg_dscratch1$D_IN;
  wire rg_dscratch1$EN;

  // register rg_mcause
  reg [4 : 0] rg_mcause;
  reg [4 : 0] rg_mcause$D_IN;
  wire rg_mcause$EN;

  // register rg_mcounteren
  reg [2 : 0] rg_mcounteren;
  wire [2 : 0] rg_mcounteren$D_IN;
  wire rg_mcounteren$EN;

  // register rg_mcycle
  reg [63 : 0] rg_mcycle;
  wire [63 : 0] rg_mcycle$D_IN;
  wire rg_mcycle$EN;

  // register rg_mepc
  reg [31 : 0] rg_mepc;
  wire [31 : 0] rg_mepc$D_IN;
  wire rg_mepc$EN;

  // register rg_minstret
  reg [63 : 0] rg_minstret;
  wire [63 : 0] rg_minstret$D_IN;
  wire rg_minstret$EN;

  // register rg_mscratch
  reg [31 : 0] rg_mscratch;
  wire [31 : 0] rg_mscratch$D_IN;
  wire rg_mscratch$EN;

  // register rg_mtval
  reg [31 : 0] rg_mtval;
  wire [31 : 0] rg_mtval$D_IN;
  wire rg_mtval$EN;

  // register rg_mtvec
  reg [30 : 0] rg_mtvec;
  wire [30 : 0] rg_mtvec$D_IN;
  wire rg_mtvec$EN;

  // register rg_nmi
  reg rg_nmi;
  wire rg_nmi$D_IN, rg_nmi$EN;

  // register rg_nmi_vector
  reg [31 : 0] rg_nmi_vector;
  wire [31 : 0] rg_nmi_vector$D_IN;
  wire rg_nmi_vector$EN;

  // register rg_state
  reg rg_state;
  wire rg_state$D_IN, rg_state$EN;

  // register rg_tdata1
  reg [31 : 0] rg_tdata1;
  wire [31 : 0] rg_tdata1$D_IN;
  wire rg_tdata1$EN;

  // register rg_tdata2
  reg [31 : 0] rg_tdata2;
  wire [31 : 0] rg_tdata2$D_IN;
  wire rg_tdata2$EN;

  // register rg_tdata3
  reg [31 : 0] rg_tdata3;
  wire [31 : 0] rg_tdata3$D_IN;
  wire rg_tdata3$EN;

  // register rg_tselect
  reg [31 : 0] rg_tselect;
  wire [31 : 0] rg_tselect$D_IN;
  wire rg_tselect$EN;

  // ports of submodule csr_mie
  wire [31 : 0] csr_mie$fav_write, csr_mie$fav_write_wordxl, csr_mie$fv_read;
  wire [27 : 0] csr_mie$fav_write_misa;
  wire csr_mie$EN_fav_write, csr_mie$EN_reset;

  // ports of submodule csr_mip
  wire [31 : 0] csr_mip$fav_write, csr_mip$fav_write_wordxl, csr_mip$fv_read;
  wire [27 : 0] csr_mip$fav_write_misa;
  wire csr_mip$EN_fav_write,
       csr_mip$EN_reset,
       csr_mip$m_external_interrupt_req_req,
       csr_mip$s_external_interrupt_req_req,
       csr_mip$software_interrupt_req_req,
       csr_mip$timer_interrupt_req_req;

  // ports of submodule f_reset_rsps
  wire f_reset_rsps$CLR,
       f_reset_rsps$DEQ,
       f_reset_rsps$EMPTY_N,
       f_reset_rsps$ENQ,
       f_reset_rsps$FULL_N;

  // ports of submodule soc_map
  wire [63 : 0] soc_map$m_is_IO_addr_addr,
		soc_map$m_is_mem_addr_addr,
		soc_map$m_is_near_mem_IO_addr_addr,
		soc_map$m_mtvec_reset_value,
		soc_map$m_nmivec_reset_value;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_mcycle_incr,
       CAN_FIRE_RL_rl_reset_start,
       CAN_FIRE_RL_rl_upd_minstret_csrrx,
       CAN_FIRE_RL_rl_upd_minstret_incr,
       CAN_FIRE_csr_minstret_incr,
       CAN_FIRE_csr_ret_actions,
       CAN_FIRE_csr_trap_actions,
       CAN_FIRE_debug,
       CAN_FIRE_m_external_interrupt_req,
       CAN_FIRE_mav_csr_write,
       CAN_FIRE_mav_read_csr,
       CAN_FIRE_nmi_req,
       CAN_FIRE_s_external_interrupt_req,
       CAN_FIRE_server_reset_request_put,
       CAN_FIRE_server_reset_response_get,
       CAN_FIRE_software_interrupt_req,
       CAN_FIRE_timer_interrupt_req,
       WILL_FIRE_RL_rl_mcycle_incr,
       WILL_FIRE_RL_rl_reset_start,
       WILL_FIRE_RL_rl_upd_minstret_csrrx,
       WILL_FIRE_RL_rl_upd_minstret_incr,
       WILL_FIRE_csr_minstret_incr,
       WILL_FIRE_csr_ret_actions,
       WILL_FIRE_csr_trap_actions,
       WILL_FIRE_debug,
       WILL_FIRE_m_external_interrupt_req,
       WILL_FIRE_mav_csr_write,
       WILL_FIRE_mav_read_csr,
       WILL_FIRE_nmi_req,
       WILL_FIRE_s_external_interrupt_req,
       WILL_FIRE_server_reset_request_put,
       WILL_FIRE_server_reset_response_get,
       WILL_FIRE_software_interrupt_req,
       WILL_FIRE_timer_interrupt_req;

  // inputs to muxes for submodule ports
  wire [63 : 0] MUX_rg_minstret$write_1__VAL_1,
		MUX_rg_minstret$write_1__VAL_2,
		MUX_rw_minstret$wset_1__VAL_1;
  wire [31 : 0] MUX_csr_mstatus_rg_mstatus$write_1__VAL_3;
  wire [30 : 0] MUX_rg_mtvec$write_1__VAL_1, MUX_rg_mtvec$write_1__VAL_2;
  wire [4 : 0] MUX_rg_mcause$write_1__VAL_2, MUX_rg_mcause$write_1__VAL_3;
  wire MUX_csr_mstatus_rg_mstatus$write_1__SEL_2,
       MUX_rg_mcause$write_1__SEL_2,
       MUX_rg_mcounteren$write_1__SEL_1,
       MUX_rg_mepc$write_1__SEL_1,
       MUX_rg_mtval$write_1__SEL_1,
       MUX_rg_mtvec$write_1__SEL_1,
       MUX_rg_state$write_1__SEL_2,
       MUX_rg_tdata1$write_1__SEL_1,
       MUX_rw_minstret$wset_1__SEL_1;

  // remaining internal signals
  reg [31 : 0] IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769,
	       IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574,
	       IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220,
	       IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397;
  wire [63 : 0] x__h5174, x__h5282;
  wire [33 : 0] IF_csr_ret_actions_from_priv_EQ_0b11_029_THEN__ETC___d1068;
  wire [31 : 0] IF_csr_ret_actions_from_priv_EQ_0b11_029_THEN__ETC___d1050,
		_theResult___fst__h8211,
		_theResult___fst__h8412,
		csr_mstatus_rg_mstatus_76_AND_INV_1_SL_0_CONCA_ETC___d1043,
		exc_pc___1__h7296,
		exc_pc__h7032,
		exc_pc__h7243,
		mask__h8232,
		mask__h8249,
		result__h4701,
		result__h5357,
		v__h4509,
		v__h4571,
		v__h4742,
		val__h8250,
		vector_offset__h7244,
		wordxl1__h4038,
		x__h5843,
		x__h8067,
		x__h8068,
		x__h8085,
		x__h8231,
		x__h8244,
		x__h8261,
		y__h8245,
		y__h8262;
  wire [22 : 0] fixed_up_val_23__h4079,
		fixed_up_val_23__h6471,
		fixed_up_val_23__h8130;
  wire [5 : 0] ie_from_x__h8195, pie_from_x__h8196;
  wire [3 : 0] IF_NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_N_ETC___d1370,
	       IF_NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_N_ETC___d1372,
	       IF_NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_N_ETC___d1374,
	       IF_NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_N_ETC___d1376,
	       exc_code__h7909;
  wire [1 : 0] mpp__h7337, to_y__h8411;
  wire NOT_access_permitted_1_csr_addr_ULT_0xC03_069__ETC___d1155,
       NOT_access_permitted_2_csr_addr_ULT_0xC03_160__ETC___d1245,
       NOT_cfg_verbosity_read__31_ULE_1_32___d733,
       NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1334,
       NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1339,
       NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1344,
       NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1349,
       NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1354,
       NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1359,
       NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1364,
       NOT_csr_trap_actions_nmi_97_AND_csr_trap_actio_ETC___d974,
       NOT_mav_csr_write_csr_addr_ULT_0xB03_77_35_AND_ETC___d746,
       b__h8248,
       csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1288,
       csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1293,
       csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1298,
       csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1303,
       csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1308,
       csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1313,
       csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1318,
       csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1323,
       csr_trap_actions_nmi_OR_NOT_csr_trap_actions_i_ETC___d1025,
       mav_csr_write_csr_addr_ULE_0x33F___d586,
       mav_csr_write_csr_addr_ULE_0xB1F___d578,
       mav_csr_write_csr_addr_ULE_0xB9F___d582,
       mav_csr_write_csr_addr_ULT_0x323_85_OR_NOT_mav_ETC___d728,
       mav_csr_write_csr_addr_ULT_0x323___d585,
       mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590,
       mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d642,
       mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d730,
       mav_csr_write_csr_addr_ULT_0xB03___d577,
       mav_csr_write_csr_addr_ULT_0xB83___d581;

  // action method server_reset_request_put
  assign RDY_server_reset_request_put = f_reset_rsps$FULL_N ;
  assign CAN_FIRE_server_reset_request_put = f_reset_rsps$FULL_N ;
  assign WILL_FIRE_server_reset_request_put = EN_server_reset_request_put ;

  // action method server_reset_response_get
  assign RDY_server_reset_response_get = rg_state && f_reset_rsps$EMPTY_N ;
  assign CAN_FIRE_server_reset_response_get =
	     rg_state && f_reset_rsps$EMPTY_N ;
  assign WILL_FIRE_server_reset_response_get = EN_server_reset_response_get ;

  // value method read_csr
  assign read_csr =
	     { read_csr_csr_addr >= 12'hC03 && read_csr_csr_addr <= 12'hC1F ||
	       read_csr_csr_addr >= 12'hC83 && read_csr_csr_addr <= 12'hC9F ||
	       read_csr_csr_addr >= 12'hB03 && read_csr_csr_addr <= 12'hB1F ||
	       read_csr_csr_addr >= 12'hB83 && read_csr_csr_addr <= 12'hB9F ||
	       read_csr_csr_addr >= 12'h323 && read_csr_csr_addr <= 12'h33F ||
	       read_csr_csr_addr == 12'hC00 ||
	       read_csr_csr_addr == 12'hC02 ||
	       read_csr_csr_addr == 12'hC80 ||
	       read_csr_csr_addr == 12'hC82 ||
	       read_csr_csr_addr == 12'hF11 ||
	       read_csr_csr_addr == 12'hF12 ||
	       read_csr_csr_addr == 12'hF13 ||
	       read_csr_csr_addr == 12'hF14 ||
	       read_csr_csr_addr == 12'h300 ||
	       read_csr_csr_addr == 12'h301 ||
	       read_csr_csr_addr == 12'h304 ||
	       read_csr_csr_addr == 12'h305 ||
	       read_csr_csr_addr == 12'h306 ||
	       read_csr_csr_addr == 12'h340 ||
	       read_csr_csr_addr == 12'h341 ||
	       read_csr_csr_addr == 12'h342 ||
	       read_csr_csr_addr == 12'h343 ||
	       read_csr_csr_addr == 12'h344 ||
	       read_csr_csr_addr == 12'hB00 ||
	       read_csr_csr_addr == 12'hB02 ||
	       read_csr_csr_addr == 12'hB80 ||
	       read_csr_csr_addr == 12'hB82 ||
	       read_csr_csr_addr == 12'h7A0 ||
	       read_csr_csr_addr == 12'h7A1 ||
	       read_csr_csr_addr == 12'h7A2 ||
	       read_csr_csr_addr == 12'h7A3,
	       (read_csr_csr_addr >= 12'hC03 &&
		read_csr_csr_addr <= 12'hC1F ||
		read_csr_csr_addr >= 12'hC83 &&
		read_csr_csr_addr <= 12'hC9F ||
		read_csr_csr_addr >= 12'hB03 &&
		read_csr_csr_addr <= 12'hB1F ||
		read_csr_csr_addr >= 12'hB83 &&
		read_csr_csr_addr <= 12'hB9F ||
		read_csr_csr_addr >= 12'h323 &&
		read_csr_csr_addr <= 12'h33F) ?
		 32'd0 :
		 IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 } ;

  // value method read_csr_port2
  assign read_csr_port2 =
	     { read_csr_port2_csr_addr >= 12'hC03 &&
	       read_csr_port2_csr_addr <= 12'hC1F ||
	       read_csr_port2_csr_addr >= 12'hC83 &&
	       read_csr_port2_csr_addr <= 12'hC9F ||
	       read_csr_port2_csr_addr >= 12'hB03 &&
	       read_csr_port2_csr_addr <= 12'hB1F ||
	       read_csr_port2_csr_addr >= 12'hB83 &&
	       read_csr_port2_csr_addr <= 12'hB9F ||
	       read_csr_port2_csr_addr >= 12'h323 &&
	       read_csr_port2_csr_addr <= 12'h33F ||
	       read_csr_port2_csr_addr == 12'hC00 ||
	       read_csr_port2_csr_addr == 12'hC02 ||
	       read_csr_port2_csr_addr == 12'hC80 ||
	       read_csr_port2_csr_addr == 12'hC82 ||
	       read_csr_port2_csr_addr == 12'hF11 ||
	       read_csr_port2_csr_addr == 12'hF12 ||
	       read_csr_port2_csr_addr == 12'hF13 ||
	       read_csr_port2_csr_addr == 12'hF14 ||
	       read_csr_port2_csr_addr == 12'h300 ||
	       read_csr_port2_csr_addr == 12'h301 ||
	       read_csr_port2_csr_addr == 12'h304 ||
	       read_csr_port2_csr_addr == 12'h305 ||
	       read_csr_port2_csr_addr == 12'h306 ||
	       read_csr_port2_csr_addr == 12'h340 ||
	       read_csr_port2_csr_addr == 12'h341 ||
	       read_csr_port2_csr_addr == 12'h342 ||
	       read_csr_port2_csr_addr == 12'h343 ||
	       read_csr_port2_csr_addr == 12'h344 ||
	       read_csr_port2_csr_addr == 12'hB00 ||
	       read_csr_port2_csr_addr == 12'hB02 ||
	       read_csr_port2_csr_addr == 12'hB80 ||
	       read_csr_port2_csr_addr == 12'hB82 ||
	       read_csr_port2_csr_addr == 12'h7A0 ||
	       read_csr_port2_csr_addr == 12'h7A1 ||
	       read_csr_port2_csr_addr == 12'h7A2 ||
	       read_csr_port2_csr_addr == 12'h7A3,
	       (read_csr_port2_csr_addr >= 12'hC03 &&
		read_csr_port2_csr_addr <= 12'hC1F ||
		read_csr_port2_csr_addr >= 12'hC83 &&
		read_csr_port2_csr_addr <= 12'hC9F ||
		read_csr_port2_csr_addr >= 12'hB03 &&
		read_csr_port2_csr_addr <= 12'hB1F ||
		read_csr_port2_csr_addr >= 12'hB83 &&
		read_csr_port2_csr_addr <= 12'hB9F ||
		read_csr_port2_csr_addr >= 12'h323 &&
		read_csr_port2_csr_addr <= 12'h33F) ?
		 32'd0 :
		 IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 } ;

  // actionvalue method mav_read_csr
  assign mav_read_csr =
	     { mav_read_csr_csr_addr >= 12'hC03 &&
	       mav_read_csr_csr_addr <= 12'hC1F ||
	       mav_read_csr_csr_addr >= 12'hC83 &&
	       mav_read_csr_csr_addr <= 12'hC9F ||
	       mav_read_csr_csr_addr >= 12'hB03 &&
	       mav_read_csr_csr_addr <= 12'hB1F ||
	       mav_read_csr_csr_addr >= 12'hB83 &&
	       mav_read_csr_csr_addr <= 12'hB9F ||
	       mav_read_csr_csr_addr >= 12'h323 &&
	       mav_read_csr_csr_addr <= 12'h33F ||
	       mav_read_csr_csr_addr == 12'hC00 ||
	       mav_read_csr_csr_addr == 12'hC02 ||
	       mav_read_csr_csr_addr == 12'hC80 ||
	       mav_read_csr_csr_addr == 12'hC82 ||
	       mav_read_csr_csr_addr == 12'hF11 ||
	       mav_read_csr_csr_addr == 12'hF12 ||
	       mav_read_csr_csr_addr == 12'hF13 ||
	       mav_read_csr_csr_addr == 12'hF14 ||
	       mav_read_csr_csr_addr == 12'h300 ||
	       mav_read_csr_csr_addr == 12'h301 ||
	       mav_read_csr_csr_addr == 12'h304 ||
	       mav_read_csr_csr_addr == 12'h305 ||
	       mav_read_csr_csr_addr == 12'h306 ||
	       mav_read_csr_csr_addr == 12'h340 ||
	       mav_read_csr_csr_addr == 12'h341 ||
	       mav_read_csr_csr_addr == 12'h342 ||
	       mav_read_csr_csr_addr == 12'h343 ||
	       mav_read_csr_csr_addr == 12'h344 ||
	       mav_read_csr_csr_addr == 12'hB00 ||
	       mav_read_csr_csr_addr == 12'hB02 ||
	       mav_read_csr_csr_addr == 12'hB80 ||
	       mav_read_csr_csr_addr == 12'hB82 ||
	       mav_read_csr_csr_addr == 12'h7A0 ||
	       mav_read_csr_csr_addr == 12'h7A1 ||
	       mav_read_csr_csr_addr == 12'h7A2 ||
	       mav_read_csr_csr_addr == 12'h7A3,
	       (mav_read_csr_csr_addr >= 12'hC03 &&
		mav_read_csr_csr_addr <= 12'hC1F ||
		mav_read_csr_csr_addr >= 12'hC83 &&
		mav_read_csr_csr_addr <= 12'hC9F ||
		mav_read_csr_csr_addr >= 12'hB03 &&
		mav_read_csr_csr_addr <= 12'hB1F ||
		mav_read_csr_csr_addr >= 12'hB83 &&
		mav_read_csr_csr_addr <= 12'hB9F ||
		mav_read_csr_csr_addr >= 12'h323 &&
		mav_read_csr_csr_addr <= 12'h33F) ?
		 32'd0 :
		 IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 } ;
  assign CAN_FIRE_mav_read_csr = 1'd1 ;
  assign WILL_FIRE_mav_read_csr = EN_mav_read_csr ;

  // actionvalue method mav_csr_write
  assign mav_csr_write =
	     NOT_mav_csr_write_csr_addr_ULT_0xB03_77_35_AND_ETC___d746 ?
	       32'd0 :
	       IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 ;
  assign CAN_FIRE_mav_csr_write = 1'd1 ;
  assign WILL_FIRE_mav_csr_write = EN_mav_csr_write ;

  // value method read_misa
  assign read_misa = 28'd68157696 ;

  // value method read_mstatus
  assign read_mstatus = csr_mstatus_rg_mstatus ;

  // value method read_ustatus
  assign read_ustatus =
	     { 27'd0,
	       csr_mstatus_rg_mstatus[4],
	       3'd0,
	       csr_mstatus_rg_mstatus[0] } ;

  // value method read_satp
  assign read_satp = 32'hAAAAAAAA ;

  // actionvalue method csr_trap_actions
  assign csr_trap_actions = { x__h5843, x__h8067, x__h8068, 2'b11 } ;
  assign RDY_csr_trap_actions = 1'd1 ;
  assign CAN_FIRE_csr_trap_actions = 1'd1 ;
  assign WILL_FIRE_csr_trap_actions = EN_csr_trap_actions ;

  // actionvalue method csr_ret_actions
  assign csr_ret_actions =
	     { x__h8085,
	       IF_csr_ret_actions_from_priv_EQ_0b11_029_THEN__ETC___d1068 } ;
  assign RDY_csr_ret_actions = 1'd1 ;
  assign CAN_FIRE_csr_ret_actions = 1'd1 ;
  assign WILL_FIRE_csr_ret_actions = EN_csr_ret_actions ;

  // value method read_csr_minstret
  assign read_csr_minstret = rg_minstret ;

  // action method csr_minstret_incr
  assign CAN_FIRE_csr_minstret_incr = 1'd1 ;
  assign WILL_FIRE_csr_minstret_incr = EN_csr_minstret_incr ;

  // value method read_csr_mcycle
  assign read_csr_mcycle = rg_mcycle ;

  // value method read_csr_mtime
  assign read_csr_mtime = rg_mcycle ;

  // value method access_permitted_1
  assign access_permitted_1 =
	     NOT_access_permitted_1_csr_addr_ULT_0xC03_069__ETC___d1155 &&
	     (access_permitted_1_read_not_write ||
	      access_permitted_1_csr_addr[11:10] != 2'b11) ;

  // value method access_permitted_2
  assign access_permitted_2 =
	     NOT_access_permitted_2_csr_addr_ULT_0xC03_160__ETC___d1245 &&
	     (access_permitted_2_read_not_write ||
	      access_permitted_2_csr_addr[11:10] != 2'b11) ;

  // value method csr_counter_read_fault
  assign csr_counter_read_fault =
	     (csr_counter_read_fault_priv == 2'b01 ||
	      csr_counter_read_fault_priv == 2'b0) &&
	     (csr_counter_read_fault_csr_addr == 12'hC00 &&
	      !rg_mcounteren[0] ||
	      csr_counter_read_fault_csr_addr == 12'hC01 &&
	      !rg_mcounteren[1] ||
	      csr_counter_read_fault_csr_addr == 12'hC02 &&
	      !rg_mcounteren[2] ||
	      csr_counter_read_fault_csr_addr >= 12'hC03 &&
	      csr_counter_read_fault_csr_addr <= 12'hC1F ||
	      csr_counter_read_fault_csr_addr >= 12'hC83 &&
	      csr_counter_read_fault_csr_addr <= 12'hC9F) ;

  // value method csr_mip_read
  assign csr_mip_read = csr_mip$fv_read ;

  // action method m_external_interrupt_req
  assign CAN_FIRE_m_external_interrupt_req = 1'd1 ;
  assign WILL_FIRE_m_external_interrupt_req = 1'd1 ;

  // action method s_external_interrupt_req
  assign CAN_FIRE_s_external_interrupt_req = 1'd1 ;
  assign WILL_FIRE_s_external_interrupt_req = 1'd1 ;

  // action method timer_interrupt_req
  assign CAN_FIRE_timer_interrupt_req = 1'd1 ;
  assign WILL_FIRE_timer_interrupt_req = 1'd1 ;

  // action method software_interrupt_req
  assign CAN_FIRE_software_interrupt_req = 1'd1 ;
  assign WILL_FIRE_software_interrupt_req = 1'd1 ;

  // value method interrupt_pending
  assign interrupt_pending =
	     { csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1323,
	       NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1364 ?
		 4'd4 :
		 IF_NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_N_ETC___d1376 } ;

  // value method wfi_resume
  assign wfi_resume = (csr_mip$fv_read & csr_mie$fv_read) != 32'd0 ;

  // action method nmi_req
  assign CAN_FIRE_nmi_req = 1'd1 ;
  assign WILL_FIRE_nmi_req = 1'd1 ;

  // value method nmi_pending
  assign nmi_pending = rg_nmi ;

  // action method debug
  assign RDY_debug = 1'd1 ;
  assign CAN_FIRE_debug = 1'd1 ;
  assign WILL_FIRE_debug = EN_debug ;

  // submodule csr_mie
  mkCSR_MIE csr_mie(.CLK(CLK),
		    .RST_N(RST_N),
		    .fav_write_misa(csr_mie$fav_write_misa),
		    .fav_write_wordxl(csr_mie$fav_write_wordxl),
		    .EN_reset(csr_mie$EN_reset),
		    .EN_fav_write(csr_mie$EN_fav_write),
		    .fv_read(csr_mie$fv_read),
		    .fav_write(csr_mie$fav_write));

  // submodule csr_mip
  mkCSR_MIP csr_mip(.CLK(CLK),
		    .RST_N(RST_N),
		    .fav_write_misa(csr_mip$fav_write_misa),
		    .fav_write_wordxl(csr_mip$fav_write_wordxl),
		    .m_external_interrupt_req_req(csr_mip$m_external_interrupt_req_req),
		    .s_external_interrupt_req_req(csr_mip$s_external_interrupt_req_req),
		    .software_interrupt_req_req(csr_mip$software_interrupt_req_req),
		    .timer_interrupt_req_req(csr_mip$timer_interrupt_req_req),
		    .EN_reset(csr_mip$EN_reset),
		    .EN_fav_write(csr_mip$EN_fav_write),
		    .fv_read(csr_mip$fv_read),
		    .fav_write(csr_mip$fav_write));

  // submodule f_reset_rsps
  FIFO20 #(.guarded(32'd1)) f_reset_rsps(.RST(RST_N),
					 .CLK(CLK),
					 .ENQ(f_reset_rsps$ENQ),
					 .DEQ(f_reset_rsps$DEQ),
					 .CLR(f_reset_rsps$CLR),
					 .FULL_N(f_reset_rsps$FULL_N),
					 .EMPTY_N(f_reset_rsps$EMPTY_N) ,.RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__full_reg) ,.RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__csr_regfile__DOT__f_reset_rsps__DOT__empty_reg));

  // submodule soc_map
  mkSoC_Map soc_map(.CLK(CLK),
		    .RST_N(RST_N),
		    .m_is_IO_addr_addr(soc_map$m_is_IO_addr_addr),
		    .m_is_mem_addr_addr(soc_map$m_is_mem_addr_addr),
		    .m_is_near_mem_IO_addr_addr(soc_map$m_is_near_mem_IO_addr_addr),
		    .m_near_mem_io_addr_base(),
		    .m_near_mem_io_addr_size(),
		    .m_near_mem_io_addr_lim(),
		    .m_plic_addr_base(),
		    .m_plic_addr_size(),
		    .m_plic_addr_lim(),
		    .m_uart0_addr_base(),
		    .m_uart0_addr_size(),
		    .m_uart0_addr_lim(),
		    .m_boot_rom_addr_base(),
		    .m_boot_rom_addr_size(),
		    .m_boot_rom_addr_lim(),
		    .m_mem0_controller_addr_base(),
		    .m_mem0_controller_addr_size(),
		    .m_mem0_controller_addr_lim(),
		    .m_tcm_addr_base(),
		    .m_tcm_addr_size(),
		    .m_tcm_addr_lim(),
		    .m_is_mem_addr(),
		    .m_is_IO_addr(),
		    .m_is_near_mem_IO_addr(),
		    .m_pc_reset_value(),
		    .m_mtvec_reset_value(soc_map$m_mtvec_reset_value),
		    .m_nmivec_reset_value(soc_map$m_nmivec_reset_value));

  // rule RL_rl_reset_start
  assign CAN_FIRE_RL_rl_reset_start = !rg_state ;
  assign WILL_FIRE_RL_rl_reset_start = MUX_rg_state$write_1__SEL_2 ;

  // rule RL_rl_mcycle_incr
  assign CAN_FIRE_RL_rl_mcycle_incr = 1'd1 ;
  assign WILL_FIRE_RL_rl_mcycle_incr = 1'd1 ;

  // rule RL_rl_upd_minstret_csrrx
  assign CAN_FIRE_RL_rl_upd_minstret_csrrx =
	     MUX_rw_minstret$wset_1__SEL_1 || WILL_FIRE_RL_rl_reset_start ;
  assign WILL_FIRE_RL_rl_upd_minstret_csrrx =
	     CAN_FIRE_RL_rl_upd_minstret_csrrx ;

  // rule RL_rl_upd_minstret_incr
  assign CAN_FIRE_RL_rl_upd_minstret_incr =
	     !CAN_FIRE_RL_rl_upd_minstret_csrrx && EN_csr_minstret_incr ;
  assign WILL_FIRE_RL_rl_upd_minstret_incr =
	     CAN_FIRE_RL_rl_upd_minstret_incr ;

  // inputs to muxes for submodule ports
  assign MUX_csr_mstatus_rg_mstatus$write_1__SEL_2 =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h300 ;
  assign MUX_rg_mcause$write_1__SEL_2 =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h342 ;
  assign MUX_rg_mcounteren$write_1__SEL_1 =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h306 ;
  assign MUX_rg_mepc$write_1__SEL_1 =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h341 ;
  assign MUX_rg_mtval$write_1__SEL_1 =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h343 ;
  assign MUX_rg_mtvec$write_1__SEL_1 =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h305 ;
  assign MUX_rg_state$write_1__SEL_2 =
	     CAN_FIRE_RL_rl_reset_start && !EN_mav_csr_write ;
  assign MUX_rg_tdata1$write_1__SEL_1 =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h7A1 ;
  assign MUX_rw_minstret$wset_1__SEL_1 =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d642 &&
	     (mav_csr_write_csr_addr == 12'hB02 ||
	      mav_csr_write_csr_addr == 12'hB82) ;
  assign MUX_csr_mstatus_rg_mstatus$write_1__VAL_3 =
	     { 9'd0, fixed_up_val_23__h8130 } ;
  assign MUX_rg_mcause$write_1__VAL_2 =
	     { mav_csr_write_word[31], mav_csr_write_word[3:0] } ;
  assign MUX_rg_mcause$write_1__VAL_3 =
	     { !csr_trap_actions_nmi && csr_trap_actions_interrupt,
	       exc_code__h7909 } ;
  assign MUX_rg_minstret$write_1__VAL_1 =
	     MUX_rw_minstret$wset_1__SEL_1 ?
	       MUX_rw_minstret$wset_1__VAL_1 :
	       64'd0 ;
  assign MUX_rg_minstret$write_1__VAL_2 = rg_minstret + 64'd1 ;
  assign MUX_rg_mtvec$write_1__VAL_1 =
	     { mav_csr_write_word[31:2], mav_csr_write_word[0] } ;
  assign MUX_rg_mtvec$write_1__VAL_2 =
	     { soc_map$m_mtvec_reset_value[31:2],
	       soc_map$m_mtvec_reset_value[0] } ;
  assign MUX_rw_minstret$wset_1__VAL_1 =
	     (mav_csr_write_csr_addr == 12'hB02) ? x__h5174 : x__h5282 ;

  // register cfg_verbosity
  assign cfg_verbosity$D_IN = 4'h0 ;
  assign cfg_verbosity$EN = 1'b0 ;

  // register csr_mstatus_rg_mstatus
  always@(WILL_FIRE_RL_rl_reset_start or
	  MUX_csr_mstatus_rg_mstatus$write_1__SEL_2 or
	  wordxl1__h4038 or
	  EN_csr_ret_actions or
	  MUX_csr_mstatus_rg_mstatus$write_1__VAL_3 or
	  EN_csr_trap_actions or x__h8067)
  case (1'b1)
    WILL_FIRE_RL_rl_reset_start: csr_mstatus_rg_mstatus$D_IN = 32'd0;
    MUX_csr_mstatus_rg_mstatus$write_1__SEL_2:
	csr_mstatus_rg_mstatus$D_IN = wordxl1__h4038;
    EN_csr_ret_actions:
	csr_mstatus_rg_mstatus$D_IN =
	    MUX_csr_mstatus_rg_mstatus$write_1__VAL_3;
    EN_csr_trap_actions: csr_mstatus_rg_mstatus$D_IN = x__h8067;
    default: csr_mstatus_rg_mstatus$D_IN =
		 32'hAAAAAAAA /* unspecified value */ ;
  endcase
  assign csr_mstatus_rg_mstatus$EN =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h300 ||
	     EN_csr_trap_actions ||
	     EN_csr_ret_actions ||
	     WILL_FIRE_RL_rl_reset_start ;

  // register rg_dcsr
  assign rg_dcsr$D_IN = 32'h0 ;
  assign rg_dcsr$EN = 1'b0 ;

  // register rg_dpc
  assign rg_dpc$D_IN = 32'h0 ;
  assign rg_dpc$EN = 1'b0 ;

  // register rg_dscratch0
  assign rg_dscratch0$D_IN = 32'h0 ;
  assign rg_dscratch0$EN = 1'b0 ;

  // register rg_dscratch1
  assign rg_dscratch1$D_IN = 32'h0 ;
  assign rg_dscratch1$EN = 1'b0 ;

  // register rg_mcause
  always@(WILL_FIRE_RL_rl_reset_start or
	  MUX_rg_mcause$write_1__SEL_2 or
	  MUX_rg_mcause$write_1__VAL_2 or
	  EN_csr_trap_actions or MUX_rg_mcause$write_1__VAL_3)
  case (1'b1)
    WILL_FIRE_RL_rl_reset_start: rg_mcause$D_IN = 5'd0;
    MUX_rg_mcause$write_1__SEL_2:
	rg_mcause$D_IN = MUX_rg_mcause$write_1__VAL_2;
    EN_csr_trap_actions: rg_mcause$D_IN = MUX_rg_mcause$write_1__VAL_3;
    default: rg_mcause$D_IN = 5'b01010 /* unspecified value */ ;
  endcase
  assign rg_mcause$EN =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h342 ||
	     EN_csr_trap_actions ||
	     WILL_FIRE_RL_rl_reset_start ;

  // register rg_mcounteren
  assign rg_mcounteren$D_IN =
	     MUX_rg_mcounteren$write_1__SEL_1 ?
	       mav_csr_write_word[2:0] :
	       3'd0 ;
  assign rg_mcounteren$EN =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h306 ||
	     WILL_FIRE_RL_rl_reset_start ;

  // register rg_mcycle
  assign rg_mcycle$D_IN = rg_mcycle + 64'd1 ;
  assign rg_mcycle$EN = 1'd1 ;

  // register rg_mepc
  assign rg_mepc$D_IN =
	     MUX_rg_mepc$write_1__SEL_1 ?
	       result__h4701 :
	       csr_trap_actions_pc ;
  assign rg_mepc$EN =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h341 ||
	     EN_csr_trap_actions ;

  // register rg_minstret
  assign rg_minstret$D_IN =
	     WILL_FIRE_RL_rl_upd_minstret_csrrx ?
	       MUX_rg_minstret$write_1__VAL_1 :
	       MUX_rg_minstret$write_1__VAL_2 ;
  assign rg_minstret$EN =
	     WILL_FIRE_RL_rl_upd_minstret_csrrx ||
	     WILL_FIRE_RL_rl_upd_minstret_incr ;

  // register rg_mscratch
  assign rg_mscratch$D_IN = mav_csr_write_word ;
  assign rg_mscratch$EN =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h340 ;

  // register rg_mtval
  assign rg_mtval$D_IN =
	     MUX_rg_mtval$write_1__SEL_1 ?
	       mav_csr_write_word :
	       csr_trap_actions_xtval ;
  assign rg_mtval$EN =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h343 ||
	     EN_csr_trap_actions ;

  // register rg_mtvec
  assign rg_mtvec$D_IN =
	     MUX_rg_mtvec$write_1__SEL_1 ?
	       MUX_rg_mtvec$write_1__VAL_1 :
	       MUX_rg_mtvec$write_1__VAL_2 ;
  assign rg_mtvec$EN =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h305 ||
	     WILL_FIRE_RL_rl_reset_start ;

  // register rg_nmi
  assign rg_nmi$D_IN = !WILL_FIRE_RL_rl_reset_start && nmi_req_set_not_clear ;
  assign rg_nmi$EN = 1'b1 ;

  // register rg_nmi_vector
  assign rg_nmi_vector$D_IN = soc_map$m_nmivec_reset_value[31:0] ;
  assign rg_nmi_vector$EN = MUX_rg_state$write_1__SEL_2 ;

  // register rg_state
  assign rg_state$D_IN = !EN_server_reset_request_put ;
  assign rg_state$EN =
	     EN_server_reset_request_put || WILL_FIRE_RL_rl_reset_start ;

  // register rg_tdata1
  assign rg_tdata1$D_IN =
	     MUX_rg_tdata1$write_1__SEL_1 ? result__h5357 : 32'd0 ;
  assign rg_tdata1$EN =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h7A1 ||
	     WILL_FIRE_RL_rl_reset_start ;

  // register rg_tdata2
  assign rg_tdata2$D_IN = mav_csr_write_word ;
  assign rg_tdata2$EN =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h7A2 ;

  // register rg_tdata3
  assign rg_tdata3$D_IN = mav_csr_write_word ;
  assign rg_tdata3$EN =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h7A3 ;

  // register rg_tselect
  assign rg_tselect$D_IN = 32'd0 ;
  assign rg_tselect$EN =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h7A0 ||
	     WILL_FIRE_RL_rl_reset_start ;

  // submodule csr_mie
  assign csr_mie$fav_write_misa = 28'd68157696 ;
  assign csr_mie$fav_write_wordxl = mav_csr_write_word ;
  assign csr_mie$EN_reset = MUX_rg_state$write_1__SEL_2 ;
  assign csr_mie$EN_fav_write =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h304 ;

  // submodule csr_mip
  assign csr_mip$fav_write_misa = 28'd68157696 ;
  assign csr_mip$fav_write_wordxl = mav_csr_write_word ;
  assign csr_mip$m_external_interrupt_req_req =
	     m_external_interrupt_req_set_not_clear ;
  assign csr_mip$s_external_interrupt_req_req =
	     s_external_interrupt_req_set_not_clear ;
  assign csr_mip$software_interrupt_req_req =
	     software_interrupt_req_set_not_clear ;
  assign csr_mip$timer_interrupt_req_req = timer_interrupt_req_set_not_clear ;
  assign csr_mip$EN_reset = MUX_rg_state$write_1__SEL_2 ;
  assign csr_mip$EN_fav_write =
	     EN_mav_csr_write &&
	     mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 &&
	     mav_csr_write_csr_addr == 12'h344 ;

  // submodule f_reset_rsps
  assign f_reset_rsps$ENQ = EN_server_reset_request_put ;
  assign f_reset_rsps$DEQ = EN_server_reset_response_get ;
  assign f_reset_rsps$CLR = 1'b0 ;

  // submodule soc_map
  assign soc_map$m_is_IO_addr_addr = 64'h0 ;
  assign soc_map$m_is_mem_addr_addr = 64'h0 ;
  assign soc_map$m_is_near_mem_IO_addr_addr = 64'h0 ;

  // remaining internal signals
  assign IF_NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_N_ETC___d1370 =
	     (!csr_mip$fv_read[11] || !csr_mie$fv_read[11] ||
	      interrupt_pending_cur_priv == 2'b11 &&
	      !csr_mstatus_rg_mstatus[3]) ?
	       4'd3 :
	       4'd11 ;
  assign IF_NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_N_ETC___d1372 =
	     NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1339 ?
	       4'd9 :
	       (NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1334 ?
		  4'd7 :
		  IF_NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_N_ETC___d1370) ;
  assign IF_NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_N_ETC___d1374 =
	     NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1349 ?
	       4'd5 :
	       (NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1344 ?
		  4'd1 :
		  IF_NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_N_ETC___d1372) ;
  assign IF_NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_N_ETC___d1376 =
	     NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1359 ?
	       4'd0 :
	       (NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1354 ?
		  4'd8 :
		  IF_NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_N_ETC___d1374) ;
  assign IF_csr_ret_actions_from_priv_EQ_0b11_029_THEN__ETC___d1050 =
	     (csr_ret_actions_from_priv == 2'b11) ?
	       _theResult___fst__h8211 :
	       _theResult___fst__h8412 ;
  assign IF_csr_ret_actions_from_priv_EQ_0b11_029_THEN__ETC___d1068 =
	     (csr_ret_actions_from_priv == 2'b11) ?
	       { csr_mstatus_rg_mstatus_76_AND_INV_1_SL_0_CONCA_ETC___d1043[12:11],
		 _theResult___fst__h8211 } :
	       { to_y__h8411, _theResult___fst__h8412 } ;
  assign NOT_access_permitted_1_csr_addr_ULT_0xC03_069__ETC___d1155 =
	     (access_permitted_1_csr_addr >= 12'hC03 &&
	      access_permitted_1_csr_addr <= 12'hC1F ||
	      access_permitted_1_csr_addr >= 12'hB03 &&
	      access_permitted_1_csr_addr <= 12'hB1F ||
	      access_permitted_1_csr_addr >= 12'hC83 &&
	      access_permitted_1_csr_addr <= 12'hC9F ||
	      access_permitted_1_csr_addr >= 12'hB83 &&
	      access_permitted_1_csr_addr <= 12'hB9F ||
	      access_permitted_1_csr_addr >= 12'h323 &&
	      access_permitted_1_csr_addr <= 12'h33F ||
	      access_permitted_1_csr_addr == 12'hC00 ||
	      access_permitted_1_csr_addr == 12'hC02 ||
	      access_permitted_1_csr_addr == 12'hC80 ||
	      access_permitted_1_csr_addr == 12'hC81 ||
	      access_permitted_1_csr_addr == 12'hC82 ||
	      access_permitted_1_csr_addr == 12'hF11 ||
	      access_permitted_1_csr_addr == 12'hF12 ||
	      access_permitted_1_csr_addr == 12'hF13 ||
	      access_permitted_1_csr_addr == 12'hF14 ||
	      access_permitted_1_csr_addr == 12'h300 ||
	      access_permitted_1_csr_addr == 12'h301 ||
	      access_permitted_1_csr_addr == 12'h304 ||
	      access_permitted_1_csr_addr == 12'h305 ||
	      access_permitted_1_csr_addr == 12'h306 ||
	      access_permitted_1_csr_addr == 12'h340 ||
	      access_permitted_1_csr_addr == 12'h341 ||
	      access_permitted_1_csr_addr == 12'h342 ||
	      access_permitted_1_csr_addr == 12'h343 ||
	      access_permitted_1_csr_addr == 12'h344 ||
	      access_permitted_1_csr_addr == 12'hB00 ||
	      access_permitted_1_csr_addr == 12'hB02 ||
	      access_permitted_1_csr_addr == 12'hB80 ||
	      access_permitted_1_csr_addr == 12'hB82 ||
	      access_permitted_1_csr_addr == 12'h7A0 ||
	      access_permitted_1_csr_addr == 12'h7A1 ||
	      access_permitted_1_csr_addr == 12'h7A2 ||
	      access_permitted_1_csr_addr == 12'h7A3) &&
	     access_permitted_1_priv >= access_permitted_1_csr_addr[9:8] &&
	     (access_permitted_1_csr_addr != 12'h180 ||
	      !csr_mstatus_rg_mstatus[20]) ;
  assign NOT_access_permitted_2_csr_addr_ULT_0xC03_160__ETC___d1245 =
	     (access_permitted_2_csr_addr >= 12'hC03 &&
	      access_permitted_2_csr_addr <= 12'hC1F ||
	      access_permitted_2_csr_addr >= 12'hB03 &&
	      access_permitted_2_csr_addr <= 12'hB1F ||
	      access_permitted_2_csr_addr >= 12'hC83 &&
	      access_permitted_2_csr_addr <= 12'hC9F ||
	      access_permitted_2_csr_addr >= 12'hB83 &&
	      access_permitted_2_csr_addr <= 12'hB9F ||
	      access_permitted_2_csr_addr >= 12'h323 &&
	      access_permitted_2_csr_addr <= 12'h33F ||
	      access_permitted_2_csr_addr == 12'hC00 ||
	      access_permitted_2_csr_addr == 12'hC02 ||
	      access_permitted_2_csr_addr == 12'hC80 ||
	      access_permitted_2_csr_addr == 12'hC81 ||
	      access_permitted_2_csr_addr == 12'hC82 ||
	      access_permitted_2_csr_addr == 12'hF11 ||
	      access_permitted_2_csr_addr == 12'hF12 ||
	      access_permitted_2_csr_addr == 12'hF13 ||
	      access_permitted_2_csr_addr == 12'hF14 ||
	      access_permitted_2_csr_addr == 12'h300 ||
	      access_permitted_2_csr_addr == 12'h301 ||
	      access_permitted_2_csr_addr == 12'h304 ||
	      access_permitted_2_csr_addr == 12'h305 ||
	      access_permitted_2_csr_addr == 12'h306 ||
	      access_permitted_2_csr_addr == 12'h340 ||
	      access_permitted_2_csr_addr == 12'h341 ||
	      access_permitted_2_csr_addr == 12'h342 ||
	      access_permitted_2_csr_addr == 12'h343 ||
	      access_permitted_2_csr_addr == 12'h344 ||
	      access_permitted_2_csr_addr == 12'hB00 ||
	      access_permitted_2_csr_addr == 12'hB02 ||
	      access_permitted_2_csr_addr == 12'hB80 ||
	      access_permitted_2_csr_addr == 12'hB82 ||
	      access_permitted_2_csr_addr == 12'h7A0 ||
	      access_permitted_2_csr_addr == 12'h7A1 ||
	      access_permitted_2_csr_addr == 12'h7A2 ||
	      access_permitted_2_csr_addr == 12'h7A3) &&
	     access_permitted_2_priv >= access_permitted_2_csr_addr[9:8] &&
	     (access_permitted_2_csr_addr != 12'h180 ||
	      !csr_mstatus_rg_mstatus[20]) ;
  assign NOT_cfg_verbosity_read__31_ULE_1_32___d733 = cfg_verbosity > 4'd1 ;
  assign NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1334 =
	     (!csr_mip$fv_read[11] || !csr_mie$fv_read[11] ||
	      interrupt_pending_cur_priv == 2'b11 &&
	      !csr_mstatus_rg_mstatus[3]) &&
	     (!csr_mip$fv_read[3] || !csr_mie$fv_read[3] ||
	      interrupt_pending_cur_priv == 2'b11 &&
	      !csr_mstatus_rg_mstatus[3]) ;
  assign NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1339 =
	     NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1334 &&
	     (!csr_mip$fv_read[7] || !csr_mie$fv_read[7] ||
	      interrupt_pending_cur_priv == 2'b11 &&
	      !csr_mstatus_rg_mstatus[3]) ;
  assign NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1344 =
	     NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1339 &&
	     (!csr_mip$fv_read[9] || !csr_mie$fv_read[9] ||
	      interrupt_pending_cur_priv == 2'b11 &&
	      !csr_mstatus_rg_mstatus[3]) ;
  assign NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1349 =
	     NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1344 &&
	     (!csr_mip$fv_read[1] || !csr_mie$fv_read[1] ||
	      interrupt_pending_cur_priv == 2'b11 &&
	      !csr_mstatus_rg_mstatus[3]) ;
  assign NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1354 =
	     NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1349 &&
	     (!csr_mip$fv_read[5] || !csr_mie$fv_read[5] ||
	      interrupt_pending_cur_priv == 2'b11 &&
	      !csr_mstatus_rg_mstatus[3]) ;
  assign NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1359 =
	     NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1354 &&
	     (!csr_mip$fv_read[8] || !csr_mie$fv_read[8] ||
	      interrupt_pending_cur_priv == 2'b11 &&
	      !csr_mstatus_rg_mstatus[3]) ;
  assign NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1364 =
	     NOT_csr_mip_fv_read__94_BIT_11_277_324_OR_NOT__ETC___d1359 &&
	     (!csr_mip$fv_read[0] || !csr_mie$fv_read[0] ||
	      interrupt_pending_cur_priv == 2'b11 &&
	      !csr_mstatus_rg_mstatus[3]) ;
  assign NOT_csr_trap_actions_nmi_97_AND_csr_trap_actio_ETC___d974 =
	     !csr_trap_actions_nmi && csr_trap_actions_interrupt &&
	     exc_code__h7909 != 4'd0 &&
	     exc_code__h7909 != 4'd1 &&
	     exc_code__h7909 != 4'd2 &&
	     exc_code__h7909 != 4'd3 &&
	     exc_code__h7909 != 4'd4 &&
	     exc_code__h7909 != 4'd5 &&
	     exc_code__h7909 != 4'd6 &&
	     exc_code__h7909 != 4'd7 &&
	     exc_code__h7909 != 4'd8 &&
	     exc_code__h7909 != 4'd9 &&
	     exc_code__h7909 != 4'd10 &&
	     exc_code__h7909 != 4'd11 ;
  assign NOT_mav_csr_write_csr_addr_ULT_0xB03_77_35_AND_ETC___d746 =
	     !mav_csr_write_csr_addr_ULT_0xB03___d577 &&
	     mav_csr_write_csr_addr_ULE_0xB1F___d578 ||
	     !mav_csr_write_csr_addr_ULT_0xB83___d581 &&
	     mav_csr_write_csr_addr_ULE_0xB9F___d582 ||
	     !mav_csr_write_csr_addr_ULT_0x323___d585 &&
	     mav_csr_write_csr_addr_ULE_0x33F___d586 ||
	     mav_csr_write_csr_addr == 12'hF11 ||
	     mav_csr_write_csr_addr == 12'hF12 ||
	     mav_csr_write_csr_addr == 12'hF13 ||
	     mav_csr_write_csr_addr == 12'hF14 ;
  assign _theResult___fst__h8211 =
	     { csr_mstatus_rg_mstatus_76_AND_INV_1_SL_0_CONCA_ETC___d1043[31:13],
	       2'd0,
	       csr_mstatus_rg_mstatus_76_AND_INV_1_SL_0_CONCA_ETC___d1043[10:0] } ;
  assign _theResult___fst__h8412 =
	     { csr_mstatus_rg_mstatus_76_AND_INV_1_SL_0_CONCA_ETC___d1043[31:9],
	       1'd0,
	       csr_mstatus_rg_mstatus_76_AND_INV_1_SL_0_CONCA_ETC___d1043[7:0] } ;
  assign b__h8248 =
	     csr_mstatus_rg_mstatus[{ 3'd1, csr_ret_actions_from_priv }] ;
  assign csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1288 =
	     csr_mip$fv_read[11] && csr_mie$fv_read[11] &&
	     (interrupt_pending_cur_priv != 2'b11 ||
	      csr_mstatus_rg_mstatus[3]) ||
	     csr_mip$fv_read[3] && csr_mie$fv_read[3] &&
	     (interrupt_pending_cur_priv != 2'b11 ||
	      csr_mstatus_rg_mstatus[3]) ;
  assign csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1293 =
	     csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1288 ||
	     csr_mip$fv_read[7] && csr_mie$fv_read[7] &&
	     (interrupt_pending_cur_priv != 2'b11 ||
	      csr_mstatus_rg_mstatus[3]) ;
  assign csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1298 =
	     csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1293 ||
	     csr_mip$fv_read[9] && csr_mie$fv_read[9] &&
	     (interrupt_pending_cur_priv != 2'b11 ||
	      csr_mstatus_rg_mstatus[3]) ;
  assign csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1303 =
	     csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1298 ||
	     csr_mip$fv_read[1] && csr_mie$fv_read[1] &&
	     (interrupt_pending_cur_priv != 2'b11 ||
	      csr_mstatus_rg_mstatus[3]) ;
  assign csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1308 =
	     csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1303 ||
	     csr_mip$fv_read[5] && csr_mie$fv_read[5] &&
	     (interrupt_pending_cur_priv != 2'b11 ||
	      csr_mstatus_rg_mstatus[3]) ;
  assign csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1313 =
	     csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1308 ||
	     csr_mip$fv_read[8] && csr_mie$fv_read[8] &&
	     (interrupt_pending_cur_priv != 2'b11 ||
	      csr_mstatus_rg_mstatus[3]) ;
  assign csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1318 =
	     csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1313 ||
	     csr_mip$fv_read[0] && csr_mie$fv_read[0] &&
	     (interrupt_pending_cur_priv != 2'b11 ||
	      csr_mstatus_rg_mstatus[3]) ;
  assign csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1323 =
	     csr_mip_fv_read__94_BIT_11_277_AND_csr_mie_fv__ETC___d1318 ||
	     csr_mip$fv_read[4] && csr_mie$fv_read[4] &&
	     (interrupt_pending_cur_priv != 2'b11 ||
	      csr_mstatus_rg_mstatus[3]) ;
  assign csr_mstatus_rg_mstatus_76_AND_INV_1_SL_0_CONCA_ETC___d1043 =
	     x__h8244 | mask__h8232 ;
  assign csr_trap_actions_nmi_OR_NOT_csr_trap_actions_i_ETC___d1025 =
	     (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	     exc_code__h7909 != 4'd0 &&
	     exc_code__h7909 != 4'd1 &&
	     exc_code__h7909 != 4'd2 &&
	     exc_code__h7909 != 4'd3 &&
	     exc_code__h7909 != 4'd4 &&
	     exc_code__h7909 != 4'd5 &&
	     exc_code__h7909 != 4'd6 &&
	     exc_code__h7909 != 4'd7 &&
	     exc_code__h7909 != 4'd8 &&
	     exc_code__h7909 != 4'd9 &&
	     exc_code__h7909 != 4'd11 &&
	     exc_code__h7909 != 4'd12 &&
	     exc_code__h7909 != 4'd13 &&
	     exc_code__h7909 != 4'd15 ;
  assign exc_code__h7909 =
	     csr_trap_actions_nmi ? 4'd0 : csr_trap_actions_exc_code ;
  assign exc_pc___1__h7296 = exc_pc__h7243 + vector_offset__h7244 ;
  assign exc_pc__h7032 = { rg_mtvec[30:1], 2'd0 } ;
  assign exc_pc__h7243 =
	     csr_trap_actions_nmi ? rg_nmi_vector : exc_pc__h7032 ;
  assign fixed_up_val_23__h4079 =
	     { mav_csr_write_word[22:17],
	       4'd0,
	       (mav_csr_write_word[12:11] == 2'b11) ?
		 mav_csr_write_word[12:11] :
		 2'b0,
	       mav_csr_write_word[10:9],
	       1'd0,
	       mav_csr_write_word[7:6],
	       2'd0,
	       mav_csr_write_word[3:2],
	       2'd0 } ;
  assign fixed_up_val_23__h6471 =
	     { csr_mstatus_rg_mstatus[22:17],
	       4'd0,
	       mpp__h7337,
	       csr_mstatus_rg_mstatus[10:9],
	       1'd0,
	       csr_mstatus_rg_mstatus[3],
	       csr_mstatus_rg_mstatus[6],
	       3'd0,
	       csr_mstatus_rg_mstatus[2],
	       2'd0 } ;
  assign fixed_up_val_23__h8130 =
	     { IF_csr_ret_actions_from_priv_EQ_0b11_029_THEN__ETC___d1050[22:17],
	       4'd0,
	       (IF_csr_ret_actions_from_priv_EQ_0b11_029_THEN__ETC___d1050[12:11] ==
		2'b11) ?
		 IF_csr_ret_actions_from_priv_EQ_0b11_029_THEN__ETC___d1050[12:11] :
		 2'b0,
	       IF_csr_ret_actions_from_priv_EQ_0b11_029_THEN__ETC___d1050[10:9],
	       1'd0,
	       IF_csr_ret_actions_from_priv_EQ_0b11_029_THEN__ETC___d1050[7:6],
	       2'd0,
	       IF_csr_ret_actions_from_priv_EQ_0b11_029_THEN__ETC___d1050[3:2],
	       2'd0 } ;
  assign ie_from_x__h8195 = { 4'd0, csr_ret_actions_from_priv } ;
  assign mask__h8232 = 32'd1 << pie_from_x__h8196 ;
  assign mask__h8249 = 32'd1 << ie_from_x__h8195 ;
  assign mav_csr_write_csr_addr_ULE_0x33F___d586 =
	     mav_csr_write_csr_addr <= 12'h33F ;
  assign mav_csr_write_csr_addr_ULE_0xB1F___d578 =
	     mav_csr_write_csr_addr <= 12'hB1F ;
  assign mav_csr_write_csr_addr_ULE_0xB9F___d582 =
	     mav_csr_write_csr_addr <= 12'hB9F ;
  assign mav_csr_write_csr_addr_ULT_0x323_85_OR_NOT_mav_ETC___d728 =
	     (mav_csr_write_csr_addr_ULT_0x323___d585 ||
	      !mav_csr_write_csr_addr_ULE_0x33F___d586) &&
	     mav_csr_write_csr_addr != 12'hF11 &&
	     mav_csr_write_csr_addr != 12'hF12 &&
	     mav_csr_write_csr_addr != 12'hF13 &&
	     mav_csr_write_csr_addr != 12'hF14 &&
	     mav_csr_write_csr_addr != 12'h300 &&
	     mav_csr_write_csr_addr != 12'h301 &&
	     mav_csr_write_csr_addr != 12'h304 &&
	     mav_csr_write_csr_addr != 12'h305 &&
	     mav_csr_write_csr_addr != 12'h306 &&
	     mav_csr_write_csr_addr != 12'h340 &&
	     mav_csr_write_csr_addr != 12'h341 &&
	     mav_csr_write_csr_addr != 12'h342 &&
	     mav_csr_write_csr_addr != 12'h343 &&
	     mav_csr_write_csr_addr != 12'h344 &&
	     mav_csr_write_csr_addr != 12'hB00 &&
	     mav_csr_write_csr_addr != 12'hB02 &&
	     mav_csr_write_csr_addr != 12'hB80 &&
	     mav_csr_write_csr_addr != 12'hB82 &&
	     mav_csr_write_csr_addr != 12'h7A0 &&
	     mav_csr_write_csr_addr != 12'h7A1 &&
	     mav_csr_write_csr_addr != 12'h7A2 &&
	     mav_csr_write_csr_addr != 12'h7A3 ;
  assign mav_csr_write_csr_addr_ULT_0x323___d585 =
	     mav_csr_write_csr_addr < 12'h323 ;
  assign mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d590 =
	     (mav_csr_write_csr_addr_ULT_0xB03___d577 ||
	      !mav_csr_write_csr_addr_ULE_0xB1F___d578) &&
	     (mav_csr_write_csr_addr_ULT_0xB83___d581 ||
	      !mav_csr_write_csr_addr_ULE_0xB9F___d582) &&
	     (mav_csr_write_csr_addr_ULT_0x323___d585 ||
	      !mav_csr_write_csr_addr_ULE_0x33F___d586) ;
  assign mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d642 =
	     (mav_csr_write_csr_addr_ULT_0xB03___d577 ||
	      !mav_csr_write_csr_addr_ULE_0xB1F___d578) &&
	     (mav_csr_write_csr_addr_ULT_0xB83___d581 ||
	      !mav_csr_write_csr_addr_ULE_0xB9F___d582) &&
	     (mav_csr_write_csr_addr_ULT_0x323___d585 ||
	      !mav_csr_write_csr_addr_ULE_0x33F___d586) &&
	     mav_csr_write_csr_addr != 12'hF11 &&
	     mav_csr_write_csr_addr != 12'hF12 &&
	     mav_csr_write_csr_addr != 12'hF13 &&
	     mav_csr_write_csr_addr != 12'hF14 ;
  assign mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d730 =
	     (mav_csr_write_csr_addr_ULT_0xB03___d577 ||
	      !mav_csr_write_csr_addr_ULE_0xB1F___d578) &&
	     (mav_csr_write_csr_addr_ULT_0xB83___d581 ||
	      !mav_csr_write_csr_addr_ULE_0xB9F___d582) &&
	     mav_csr_write_csr_addr_ULT_0x323_85_OR_NOT_mav_ETC___d728 ;
  assign mav_csr_write_csr_addr_ULT_0xB03___d577 =
	     mav_csr_write_csr_addr < 12'hB03 ;
  assign mav_csr_write_csr_addr_ULT_0xB83___d581 =
	     mav_csr_write_csr_addr < 12'hB83 ;
  assign mpp__h7337 =
	     (csr_trap_actions_from_priv == 2'b11) ?
	       csr_trap_actions_from_priv :
	       2'b0 ;
  assign pie_from_x__h8196 = { 4'd1, csr_ret_actions_from_priv } ;
  assign result__h4701 = { mav_csr_write_word[31:2], 2'd0 } ;
  assign result__h5357 = { 4'd0, mav_csr_write_word[27:0] } ;
  assign to_y__h8411 =
	     { 1'b0,
	       csr_mstatus_rg_mstatus_76_AND_INV_1_SL_0_CONCA_ETC___d1043[8] } ;
  assign v__h4509 =
	     { mav_csr_write_word[31:2], 1'b0, mav_csr_write_word[0] } ;
  assign v__h4571 = { 29'd0, mav_csr_write_word[2:0] } ;
  assign v__h4742 =
	     { mav_csr_write_word[31], 27'd0, mav_csr_write_word[3:0] } ;
  assign val__h8250 = { 31'd0, b__h8248 } << ie_from_x__h8195 ;
  assign vector_offset__h7244 = { 26'd0, csr_trap_actions_exc_code, 2'd0 } ;
  assign wordxl1__h4038 = { 9'd0, fixed_up_val_23__h4079 } ;
  assign x__h5174 = { rg_minstret[63:32], mav_csr_write_word } ;
  assign x__h5282 = { mav_csr_write_word, rg_minstret[31:0] } ;
  assign x__h5843 =
	     (csr_trap_actions_interrupt && !csr_trap_actions_nmi &&
	      rg_mtvec[0]) ?
	       exc_pc___1__h7296 :
	       exc_pc__h7243 ;
  assign x__h8067 = { 9'd0, fixed_up_val_23__h6471 } ;
  assign x__h8068 =
	     { !csr_trap_actions_nmi && csr_trap_actions_interrupt,
	       27'd0,
	       exc_code__h7909 } ;
  assign x__h8085 = { rg_mepc[31:2], 1'd0, rg_mepc[0] } ;
  assign x__h8231 = x__h8261 | val__h8250 ;
  assign x__h8244 = x__h8231 & y__h8245 ;
  assign x__h8261 = csr_mstatus_rg_mstatus & y__h8262 ;
  assign y__h8245 = ~mask__h8232 ;
  assign y__h8262 = ~mask__h8249 ;
  always@(read_csr_csr_addr or
	  rg_tdata3 or
	  csr_mstatus_rg_mstatus or
	  csr_mie$fv_read or
	  rg_mtvec or
	  rg_mcounteren or
	  rg_mscratch or
	  x__h8085 or
	  rg_mcause or
	  rg_mtval or
	  csr_mip$fv_read or
	  rg_tselect or rg_tdata1 or rg_tdata2 or rg_mcycle or rg_minstret)
  begin
    case (read_csr_csr_addr)
      12'h300:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      csr_mstatus_rg_mstatus;
      12'h301:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      32'd1074790656;
      12'h304:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      csr_mie$fv_read;
      12'h305:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      { rg_mtvec[30:1], 1'b0, rg_mtvec[0] };
      12'h306:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      { 29'd0, rg_mcounteren };
      12'h340:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      rg_mscratch;
      12'h341:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      x__h8085;
      12'h342:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      { rg_mcause[4], 27'd0, rg_mcause[3:0] };
      12'h343:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      rg_mtval;
      12'h344:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      csr_mip$fv_read;
      12'h7A0:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      rg_tselect;
      12'h7A1:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      rg_tdata1;
      12'h7A2:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      rg_tdata2;
      12'hB00, 12'hC00:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      rg_mcycle[31:0];
      12'hB02, 12'hC02:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      rg_minstret[31:0];
      12'hB80, 12'hC80:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      rg_mcycle[63:32];
      12'hB82, 12'hC82:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
	      rg_minstret[63:32];
      12'hF11, 12'hF12, 12'hF13, 12'hF14:
	  IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 = 32'd0;
      default: IF_read_csr_csr_addr_EQ_0xC00_9_THEN_rg_mcycle_ETC___d220 =
		   rg_tdata3;
    endcase
  end
  always@(read_csr_port2_csr_addr or
	  rg_tdata3 or
	  csr_mstatus_rg_mstatus or
	  csr_mie$fv_read or
	  rg_mtvec or
	  rg_mcounteren or
	  rg_mscratch or
	  x__h8085 or
	  rg_mcause or
	  rg_mtval or
	  csr_mip$fv_read or
	  rg_tselect or rg_tdata1 or rg_tdata2 or rg_mcycle or rg_minstret)
  begin
    case (read_csr_port2_csr_addr)
      12'h300:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      csr_mstatus_rg_mstatus;
      12'h301:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      32'd1074790656;
      12'h304:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      csr_mie$fv_read;
      12'h305:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      { rg_mtvec[30:1], 1'b0, rg_mtvec[0] };
      12'h306:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      { 29'd0, rg_mcounteren };
      12'h340:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      rg_mscratch;
      12'h341:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      x__h8085;
      12'h342:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      { rg_mcause[4], 27'd0, rg_mcause[3:0] };
      12'h343:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      rg_mtval;
      12'h344:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      csr_mip$fv_read;
      12'h7A0:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      rg_tselect;
      12'h7A1:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      rg_tdata1;
      12'h7A2:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      rg_tdata2;
      12'hB00, 12'hC00:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      rg_mcycle[31:0];
      12'hB02, 12'hC02:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      rg_minstret[31:0];
      12'hB80, 12'hC80:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      rg_mcycle[63:32];
      12'hB82, 12'hC82:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
	      rg_minstret[63:32];
      12'hF11, 12'hF12, 12'hF13, 12'hF14:
	  IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 = 32'd0;
      default: IF_read_csr_port2_csr_addr_EQ_0xC00_43_THEN_rg_ETC___d397 =
		   rg_tdata3;
    endcase
  end
  always@(mav_read_csr_csr_addr or
	  rg_tdata3 or
	  csr_mstatus_rg_mstatus or
	  csr_mie$fv_read or
	  rg_mtvec or
	  rg_mcounteren or
	  rg_mscratch or
	  x__h8085 or
	  rg_mcause or
	  rg_mtval or
	  csr_mip$fv_read or
	  rg_tselect or rg_tdata1 or rg_tdata2 or rg_mcycle or rg_minstret)
  begin
    case (mav_read_csr_csr_addr)
      12'h300:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      csr_mstatus_rg_mstatus;
      12'h301:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      32'd1074790656;
      12'h304:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      csr_mie$fv_read;
      12'h305:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      { rg_mtvec[30:1], 1'b0, rg_mtvec[0] };
      12'h306:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      { 29'd0, rg_mcounteren };
      12'h340:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      rg_mscratch;
      12'h341:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      x__h8085;
      12'h342:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      { rg_mcause[4], 27'd0, rg_mcause[3:0] };
      12'h343:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      rg_mtval;
      12'h344:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      csr_mip$fv_read;
      12'h7A0:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      rg_tselect;
      12'h7A1:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      rg_tdata1;
      12'h7A2:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      rg_tdata2;
      12'hB00, 12'hC00:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      rg_mcycle[31:0];
      12'hB02, 12'hC02:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      rg_minstret[31:0];
      12'hB80, 12'hC80:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      rg_mcycle[63:32];
      12'hB82, 12'hC82:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
	      rg_minstret[63:32];
      12'hF11, 12'hF12, 12'hF13, 12'hF14:
	  IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 = 32'd0;
      default: IF_mav_read_csr_csr_addr_EQ_0xC00_20_THEN_rg_m_ETC___d574 =
		   rg_tdata3;
    endcase
  end
  always@(mav_csr_write_csr_addr or
	  mav_csr_write_word or
	  wordxl1__h4038 or
	  csr_mie$fav_write or
	  v__h4509 or
	  v__h4571 or
	  result__h4701 or v__h4742 or csr_mip$fav_write or result__h5357)
  begin
    case (mav_csr_write_csr_addr)
      12'h300:
	  IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 =
	      wordxl1__h4038;
      12'h301:
	  IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 =
	      32'd1074790656;
      12'h304:
	  IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 =
	      csr_mie$fav_write;
      12'h305:
	  IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 =
	      v__h4509;
      12'h306:
	  IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 =
	      v__h4571;
      12'h340, 12'h343, 12'hB00, 12'hB02, 12'hB80, 12'hB82:
	  IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 =
	      mav_csr_write_word;
      12'h341:
	  IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 =
	      result__h4701;
      12'h342:
	  IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 =
	      v__h4742;
      12'h344:
	  IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 =
	      csr_mip$fav_write;
      12'h7A0:
	  IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 = 32'd0;
      12'h7A1:
	  IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 =
	      result__h5357;
      default: IF_mav_csr_write_csr_addr_EQ_0x300_91_THEN_0_C_ETC___d769 =
		   mav_csr_write_word;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == 1'b0)
      begin
        cfg_verbosity <=  4'd0;
	csr_mstatus_rg_mstatus <=  32'd0;
	rg_mcycle <=  64'd0;
	rg_minstret <=  64'd0;
	rg_nmi <=  1'd0;
	rg_state <=  1'd0;
      end
    else
      begin
        if (cfg_verbosity$EN)
	  cfg_verbosity <=  cfg_verbosity$D_IN;
	if (csr_mstatus_rg_mstatus$EN)
	  csr_mstatus_rg_mstatus <= 
	      csr_mstatus_rg_mstatus$D_IN;
	if (rg_mcycle$EN) rg_mcycle <=  rg_mcycle$D_IN;
	if (rg_minstret$EN)
	  rg_minstret <=  rg_minstret$D_IN;
	if (rg_nmi$EN) rg_nmi <=  rg_nmi$D_IN;
	if (rg_state$EN) rg_state <=  rg_state$D_IN;
      end
    if (rg_dcsr$EN) rg_dcsr <=  rg_dcsr$D_IN;
    if (rg_dpc$EN) rg_dpc <=  rg_dpc$D_IN;
    if (rg_dscratch0$EN)
      rg_dscratch0 <=  rg_dscratch0$D_IN;
    if (rg_dscratch1$EN)
      rg_dscratch1 <=  rg_dscratch1$D_IN;
    if (rg_mcause$EN) rg_mcause <=  rg_mcause$D_IN;
    if (rg_mcounteren$EN)
      rg_mcounteren <=  rg_mcounteren$D_IN;
    if (rg_mepc$EN) rg_mepc <=  rg_mepc$D_IN;
    if (rg_mscratch$EN) rg_mscratch <=  rg_mscratch$D_IN;
    if (rg_mtval$EN) rg_mtval <=  rg_mtval$D_IN;
    if (rg_mtvec$EN) rg_mtvec <=  rg_mtvec$D_IN;
    if (rg_nmi_vector$EN)
      rg_nmi_vector <=  rg_nmi_vector$D_IN;
    if (rg_tdata1$EN) rg_tdata1 <=  rg_tdata1$D_IN;
    if (rg_tdata2$EN) rg_tdata2 <=  rg_tdata2$D_IN;
    if (rg_tdata3$EN) rg_tdata3 <=  rg_tdata3$D_IN;
    if (rg_tselect$EN) rg_tselect <=  rg_tselect$D_IN;
  end

  // synopsys translate_off
  
  
























 // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != 1'b0)
      if (EN_debug) $display("mstatus = 0x%0h", csr_mstatus_rg_mstatus);
    if (RST_N != 1'b0)
      if (EN_debug) $display("mip     = 0x%0h", csr_mip$fv_read);
    if (RST_N != 1'b0)
      if (EN_debug) $display("mie     = 0x%0h", csr_mie$fv_read);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$display("%0d: CSR_Regfile.csr_trap_actions:", rg_mcycle);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$display("    from priv %0d  pc 0x%0h  interrupt %0d  exc_code %0d  xtval 0x%0h",
		 csr_trap_actions_from_priv,
		 csr_trap_actions_pc,
		 csr_trap_actions_interrupt,
		 csr_trap_actions_exc_code,
		 csr_trap_actions_xtval);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write("    priv %0d: ", 2'b11);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" ip: 0x%0h", csr_mip$fv_read);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" ie: 0x%0h", csr_mie$fv_read);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" edeleg: 0x%0h", 16'd0);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" ideleg: 0x%0h", 12'd0);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" cause:");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd0)
	$write("USER_SW_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd1)
	$write("SUPERVISOR_SW_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd2)
	$write("HYPERVISOR_SW_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd3)
	$write("MACHINE_SW_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd4)
	$write("USER_TIMER_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd5)
	$write("SUPERVISOR_TIMER_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd6)
	$write("HYPERVISOR_TIMER_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd7)
	$write("MACHINE_TIMER_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd8)
	$write("USER_EXTERNAL_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd9)
	$write("SUPERVISOR_EXTERNAL_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd10)
	$write("HYPERVISOR_EXTERNAL_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd11)
	$write("MACHINE_EXTERNAL_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  rg_mcause[4] &&
	  rg_mcause[3:0] != 4'd0 &&
	  rg_mcause[3:0] != 4'd1 &&
	  rg_mcause[3:0] != 4'd2 &&
	  rg_mcause[3:0] != 4'd3 &&
	  rg_mcause[3:0] != 4'd4 &&
	  rg_mcause[3:0] != 4'd5 &&
	  rg_mcause[3:0] != 4'd6 &&
	  rg_mcause[3:0] != 4'd7 &&
	  rg_mcause[3:0] != 4'd8 &&
	  rg_mcause[3:0] != 4'd9 &&
	  rg_mcause[3:0] != 4'd10 &&
	  rg_mcause[3:0] != 4'd11)
	$write("unknown interrupt Exc_Code %d", rg_mcause[3:0]);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd0)
	$write("INSTRUCTION_ADDR_MISALIGNED");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd1)
	$write("INSTRUCTION_ACCESS_FAULT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd2)
	$write("ILLEGAL_INSTRUCTION");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd3)
	$write("BREAKPOINT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd4)
	$write("LOAD_ADDR_MISALIGNED");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd5)
	$write("LOAD_ACCESS_FAULT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd6)
	$write("STORE_AMO_ADDR_MISALIGNED");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd7)
	$write("STORE_AMO_ACCESS_FAULT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd8)
	$write("ECALL_FROM_U");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd9)
	$write("ECALL_FROM_S");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd11)
	$write("ECALL_FROM_M");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd12)
	$write("INSTRUCTION_PAGE_FAULT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd13)
	$write("LOAD_PAGE_FAULT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] == 4'd15)
	$write("STORE_AMO_PAGE_FAULT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !rg_mcause[4] &&
	  rg_mcause[3:0] != 4'd0 &&
	  rg_mcause[3:0] != 4'd1 &&
	  rg_mcause[3:0] != 4'd2 &&
	  rg_mcause[3:0] != 4'd3 &&
	  rg_mcause[3:0] != 4'd4 &&
	  rg_mcause[3:0] != 4'd5 &&
	  rg_mcause[3:0] != 4'd6 &&
	  rg_mcause[3:0] != 4'd7 &&
	  rg_mcause[3:0] != 4'd8 &&
	  rg_mcause[3:0] != 4'd9 &&
	  rg_mcause[3:0] != 4'd11 &&
	  rg_mcause[3:0] != 4'd12 &&
	  rg_mcause[3:0] != 4'd13 &&
	  rg_mcause[3:0] != 4'd15)
	$write("unknown trap Exc_Code %d", rg_mcause[3:0]);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$display("");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write("        ");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" status: 0x%0h", csr_mstatus_rg_mstatus);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" tvec: 0x%0h", { rg_mtvec[30:1], 1'b0, rg_mtvec[0] });
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" epc: 0x%0h", rg_mepc);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" tval: 0x%0h", rg_mtval);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$display("");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write("    Return: new pc 0x%0h  ", x__h5843);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" new mstatus:");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write("MStatus{", "sd:%0d", 1'd0);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write("");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" tsr:%0d", csr_mstatus_rg_mstatus[22]);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" tw:%0d", csr_mstatus_rg_mstatus[21]);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" tvm:%0d", csr_mstatus_rg_mstatus[20]);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" mxr:%0d", csr_mstatus_rg_mstatus[19]);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" sum:%0d", csr_mstatus_rg_mstatus[18]);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" mprv:%0d", csr_mstatus_rg_mstatus[17]);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" xs:%0d", 2'd0);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" fs:%0d", 2'd0);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" mpp:%0d", mpp__h7337);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" spp:%0d", 1'd0);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" pies:%0d_%0d%0d", csr_mstatus_rg_mstatus[3], 1'd0, 1'd0);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" ies:%0d_%0d%0d", 1'd0, 1'd0, 1'd0);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write("}");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" new xcause:");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !csr_trap_actions_nmi &&
	  csr_trap_actions_interrupt &&
	  exc_code__h7909 == 4'd0)
	$write("USER_SW_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !csr_trap_actions_nmi &&
	  csr_trap_actions_interrupt &&
	  exc_code__h7909 == 4'd1)
	$write("SUPERVISOR_SW_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !csr_trap_actions_nmi &&
	  csr_trap_actions_interrupt &&
	  exc_code__h7909 == 4'd2)
	$write("HYPERVISOR_SW_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !csr_trap_actions_nmi &&
	  csr_trap_actions_interrupt &&
	  exc_code__h7909 == 4'd3)
	$write("MACHINE_SW_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !csr_trap_actions_nmi &&
	  csr_trap_actions_interrupt &&
	  exc_code__h7909 == 4'd4)
	$write("USER_TIMER_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !csr_trap_actions_nmi &&
	  csr_trap_actions_interrupt &&
	  exc_code__h7909 == 4'd5)
	$write("SUPERVISOR_TIMER_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !csr_trap_actions_nmi &&
	  csr_trap_actions_interrupt &&
	  exc_code__h7909 == 4'd6)
	$write("HYPERVISOR_TIMER_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !csr_trap_actions_nmi &&
	  csr_trap_actions_interrupt &&
	  exc_code__h7909 == 4'd7)
	$write("MACHINE_TIMER_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !csr_trap_actions_nmi &&
	  csr_trap_actions_interrupt &&
	  exc_code__h7909 == 4'd8)
	$write("USER_EXTERNAL_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !csr_trap_actions_nmi &&
	  csr_trap_actions_interrupt &&
	  exc_code__h7909 == 4'd9)
	$write("SUPERVISOR_EXTERNAL_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !csr_trap_actions_nmi &&
	  csr_trap_actions_interrupt &&
	  exc_code__h7909 == 4'd10)
	$write("HYPERVISOR_EXTERNAL_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  !csr_trap_actions_nmi &&
	  csr_trap_actions_interrupt &&
	  exc_code__h7909 == 4'd11)
	$write("MACHINE_EXTERNAL_INTERRUPT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  NOT_csr_trap_actions_nmi_97_AND_csr_trap_actio_ETC___d974)
	$write("unknown interrupt Exc_Code %d", exc_code__h7909);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd0)
	$write("INSTRUCTION_ADDR_MISALIGNED");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd1)
	$write("INSTRUCTION_ACCESS_FAULT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd2)
	$write("ILLEGAL_INSTRUCTION");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd3)
	$write("BREAKPOINT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd4)
	$write("LOAD_ADDR_MISALIGNED");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd5)
	$write("LOAD_ACCESS_FAULT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd6)
	$write("STORE_AMO_ADDR_MISALIGNED");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd7)
	$write("STORE_AMO_ACCESS_FAULT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd8)
	$write("ECALL_FROM_U");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd9)
	$write("ECALL_FROM_S");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd11)
	$write("ECALL_FROM_M");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd12)
	$write("INSTRUCTION_PAGE_FAULT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd13)
	$write("LOAD_PAGE_FAULT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  (csr_trap_actions_nmi || !csr_trap_actions_interrupt) &&
	  exc_code__h7909 == 4'd15)
	$write("STORE_AMO_PAGE_FAULT");
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733 &&
	  csr_trap_actions_nmi_OR_NOT_csr_trap_actions_i_ETC___d1025)
	$write("unknown trap Exc_Code %d", exc_code__h7909);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$write(" new priv %0d", 2'b11);
    if (RST_N != 1'b0)
      if (EN_csr_trap_actions && NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$display("");
    if (RST_N != 1'b0)
      if (EN_mav_csr_write &&
	  mav_csr_write_csr_addr_ULT_0xB03_77_OR_NOT_mav_ETC___d730 &&
	  NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$display("%0d: ERROR: CSR-write addr 0x%0h val 0x%0h not successful",
		 rg_mcycle,
		 mav_csr_write_csr_addr,
		 mav_csr_write_word);
    if (RST_N != 1'b0)
      if (NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$display("%0d: CSR_RegFile: m_external_interrupt_req: %x",
		 rg_mcycle,
		 m_external_interrupt_req_set_not_clear);
    if (RST_N != 1'b0)
      if (NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$display("%0d: CSR_RegFile: s_external_interrupt_req: %x",
		 rg_mcycle,
		 s_external_interrupt_req_set_not_clear);
    if (RST_N != 1'b0)
      if (NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$display("%0d: CSR_RegFile: software_interrupt_req: %x",
		 rg_mcycle,
		 software_interrupt_req_set_not_clear);
    if (RST_N != 1'b0)
      if (NOT_cfg_verbosity_read__31_ULE_1_32___d733)
	$display("%0d: CSR_RegFile: timer_interrupt_req: %x",
		 rg_mcycle,
		 timer_interrupt_req_set_not_clear);
  end
  // synopsys translate_on
 assign RTL__DOT__csr_regfile__DOT__rg_state = rg_state;
 assign RTL__DOT__csr_regfile__DOT__rg_nmi = rg_nmi;
endmodule  // mkCSR_RegFile

//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
//
//
//
// Ports:
// Name                         I/O  size props
// RDY_server_reset_request_put   O     1 reg
// RDY_server_reset_response_get  O     1
// read_rs1                       O    32
// read_rs1_port2                 O    32
// read_rs2                       O    32
// CLK                            I     1 clock
// RST_N                          I     1 reset
// read_rs1_rs1                   I     5
// read_rs1_port2_rs1             I     5
// read_rs2_rs2                   I     5
// write_rd_rd                    I     5
// write_rd_rd_val                I    32 reg
// EN_server_reset_request_put    I     1
// EN_server_reset_response_get   I     1
// EN_write_rd                    I     1
//
// Combinational paths from inputs to outputs:
//   read_rs1_rs1 -> read_rs1
//   read_rs1_port2_rs1 -> read_rs1_port2
//   read_rs2_rs2 -> read_rs2
//
//










  
  


module mkGPR_RegFile(CLK,
		     RST_N,

		     EN_server_reset_request_put,
		     RDY_server_reset_request_put,

		     EN_server_reset_response_get,
		     RDY_server_reset_response_get,

		     read_rs1_rs1,
		     read_rs1,

		     read_rs1_port2_rs1,
		     read_rs1_port2,

		     read_rs2_rs2,
		     read_rs2,

		     write_rd_rd,
		     write_rd_rd_val,
		     EN_write_rd, RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_, RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_);
 output  RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_;
 output  RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_;
  input  CLK;
  input  RST_N;

  // action method server_reset_request_put
  input  EN_server_reset_request_put;
  output RDY_server_reset_request_put;

  // action method server_reset_response_get
  input  EN_server_reset_response_get;
  output RDY_server_reset_response_get;

  // value method read_rs1
  input  [4 : 0] read_rs1_rs1;
  output [31 : 0] read_rs1;

  // value method read_rs1_port2
  input  [4 : 0] read_rs1_port2_rs1;
  output [31 : 0] read_rs1_port2;

  // value method read_rs2
  input  [4 : 0] read_rs2_rs2;
  output [31 : 0] read_rs2;

  // action method write_rd
  input  [4 : 0] write_rd_rd;
  input  [31 : 0] write_rd_rd_val;
  input  EN_write_rd;

  // signals for module outputs
  wire [31 : 0] read_rs1, read_rs1_port2, read_rs2;
  wire RDY_server_reset_request_put, RDY_server_reset_response_get;

  // register rg_state
  reg [1 : 0] rg_state;
  reg [1 : 0] rg_state$D_IN;
  wire rg_state$EN;

  // ports of submodule f_reset_rsps
  wire f_reset_rsps$CLR,
       f_reset_rsps$DEQ,
       f_reset_rsps$EMPTY_N,
       f_reset_rsps$ENQ,
       f_reset_rsps$FULL_N;

  // ports of submodule regfile
  wire [31 : 0] regfile$D_IN,
		regfile$D_OUT_1,
		regfile$D_OUT_2,
		regfile$D_OUT_3;
  wire [4 : 0] regfile$ADDR_1,
	       regfile$ADDR_2,
	       regfile$ADDR_3,
	       regfile$ADDR_4,
	       regfile$ADDR_5,
	       regfile$ADDR_IN;
  wire regfile$WE;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_reset_loop,
       CAN_FIRE_RL_rl_reset_start,
       CAN_FIRE_server_reset_request_put,
       CAN_FIRE_server_reset_response_get,
       CAN_FIRE_write_rd,
       WILL_FIRE_RL_rl_reset_loop,
       WILL_FIRE_RL_rl_reset_start,
       WILL_FIRE_server_reset_request_put,
       WILL_FIRE_server_reset_response_get,
       WILL_FIRE_write_rd;

  // action method server_reset_request_put
  assign RDY_server_reset_request_put = f_reset_rsps$FULL_N ;
  assign CAN_FIRE_server_reset_request_put = f_reset_rsps$FULL_N ;
  assign WILL_FIRE_server_reset_request_put = EN_server_reset_request_put ;

  // action method server_reset_response_get
  assign RDY_server_reset_response_get =
	     rg_state == 2'd2 && f_reset_rsps$EMPTY_N ;
  assign CAN_FIRE_server_reset_response_get =
	     rg_state == 2'd2 && f_reset_rsps$EMPTY_N ;
  assign WILL_FIRE_server_reset_response_get = EN_server_reset_response_get ;

  // value method read_rs1
  assign read_rs1 = (read_rs1_rs1 == 5'd0) ? 32'd0 : regfile$D_OUT_3 ;

  // value method read_rs1_port2
  assign read_rs1_port2 =
	     (read_rs1_port2_rs1 == 5'd0) ? 32'd0 : regfile$D_OUT_2 ;

  // value method read_rs2
  assign read_rs2 = (read_rs2_rs2 == 5'd0) ? 32'd0 : regfile$D_OUT_1 ;

  // action method write_rd
  assign CAN_FIRE_write_rd = 1'd1 ;
  assign WILL_FIRE_write_rd = EN_write_rd ;

  // submodule f_reset_rsps
  FIFO20 #(.guarded(32'd1)) f_reset_rsps(.RST(RST_N),
					 .CLK(CLK),
					 .ENQ(f_reset_rsps$ENQ),
					 .DEQ(f_reset_rsps$DEQ),
					 .CLR(f_reset_rsps$CLR),
					 .FULL_N(f_reset_rsps$FULL_N),
					 .EMPTY_N(f_reset_rsps$EMPTY_N) ,.RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__empty_reg) ,.RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__gpr_regfile__DOT__f_reset_rsps__DOT__full_reg));

  // submodule regfile
  RegFile #(.addr_width(32'd5),
	    .data_width(32'd32),
	    .lo(5'h0),
	    .hi(5'd31)) regfile(.CLK(CLK),
				.ADDR_1(regfile$ADDR_1),
				.ADDR_2(regfile$ADDR_2),
				.ADDR_3(regfile$ADDR_3),
				.ADDR_4(regfile$ADDR_4),
				.ADDR_5(regfile$ADDR_5),
				.ADDR_IN(regfile$ADDR_IN),
				.D_IN(regfile$D_IN),
				.WE(regfile$WE),
				.D_OUT_1(regfile$D_OUT_1),
				.D_OUT_2(regfile$D_OUT_2),
				.D_OUT_3(regfile$D_OUT_3),
				.D_OUT_4(),
				.D_OUT_5() ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_) ,.RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_(RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_));

  // rule RL_rl_reset_start
  assign CAN_FIRE_RL_rl_reset_start = rg_state == 2'd0 ;
  assign WILL_FIRE_RL_rl_reset_start = rg_state == 2'd0 ;

  // rule RL_rl_reset_loop
  assign CAN_FIRE_RL_rl_reset_loop = rg_state == 2'd1 ;
  assign WILL_FIRE_RL_rl_reset_loop = rg_state == 2'd1 ;

  // register rg_state
  always@(EN_server_reset_request_put or
	  WILL_FIRE_RL_rl_reset_loop or WILL_FIRE_RL_rl_reset_start)
  case (1'b1)
    EN_server_reset_request_put: rg_state$D_IN = 2'd0;
    WILL_FIRE_RL_rl_reset_loop: rg_state$D_IN = 2'd2;
    WILL_FIRE_RL_rl_reset_start: rg_state$D_IN = 2'd1;
    default: rg_state$D_IN = 2'b10 /* unspecified value */ ;
  endcase
  assign rg_state$EN =
	     EN_server_reset_request_put || WILL_FIRE_RL_rl_reset_start ||
	     WILL_FIRE_RL_rl_reset_loop ;

  // submodule f_reset_rsps
  assign f_reset_rsps$ENQ = EN_server_reset_request_put ;
  assign f_reset_rsps$DEQ = EN_server_reset_response_get ;
  assign f_reset_rsps$CLR = 1'b0 ;

  // submodule regfile
  assign regfile$ADDR_1 = read_rs2_rs2 ;
  assign regfile$ADDR_2 = read_rs1_port2_rs1 ;
  assign regfile$ADDR_3 = read_rs1_rs1 ;
  assign regfile$ADDR_4 = 5'h0 ;
  assign regfile$ADDR_5 = 5'h0 ;
  assign regfile$ADDR_IN = write_rd_rd ;
  assign regfile$D_IN = write_rd_rd_val ;
  assign regfile$WE = EN_write_rd && write_rd_rd != 5'd0 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == 1'b0)
      begin
        rg_state <=  2'd0;
      end
    else
      begin
        if (rg_state$EN) rg_state <=  rg_state$D_IN;
      end
  end

  // synopsys translate_off
  
  




 // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkGPR_RegFile

// Copyright (c) 2000-2011 Bluespec, Inc.

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// $Revision$
// $Date$






// Dual-Ported BRAM (WRITE FIRST)
module BRAM2 #(   parameter PIPELINED  = 0,
   parameter ADDR_WIDTH = 1,
   parameter DATA_WIDTH = 1,
   parameter MEMSIZE    = 1)(CLKA,
             ENA,
             WEA,
             ADDRA,
             DIA,
             DOA,
             CLKB,
             ENB,
             WEB,
             ADDRB,
             DIB,
             DOB
             );

   input                          CLKA;
   input                          ENA;
   input                          WEA;
   input [ADDR_WIDTH-1:0]         ADDRA;
   input [DATA_WIDTH-1:0]         DIA;
   output [DATA_WIDTH-1:0]        DOA;

   input                          CLKB;
   input                          ENB;
   input                          WEB;
   input [ADDR_WIDTH-1:0]         ADDRB;
   input [DATA_WIDTH-1:0]         DIB;
   output [DATA_WIDTH-1:0]        DOB;



   // reg [DATA_WIDTH-1:0]           RAM[0:MEMSIZE-1] /* synthesis syn_ramstyle="no_rw_check" */ ;
   reg [DATA_WIDTH-1:0]           DOA_R;
   reg [DATA_WIDTH-1:0]           DOB_R;
   reg [DATA_WIDTH-1:0]           DOA_R2;
   reg [DATA_WIDTH-1:0]           DOB_R2;

   wire [DATA_WIDTH-1:0]  arb1;
   wire [DATA_WIDTH-1:0]  arb2;
















 // !`ifdef BSV_NO_INITIAL_BLOCKS

   always @(posedge CLKA) begin
      if (ENA) begin
         if (WEA) begin
            // RAM[ADDRA] <= `BSV_ASSIGNMENT_DELAY DIA;
            DOA_R <=  DIA;
         end
         else begin
            DOA_R <= arb1; //`BSV_ASSIGNMENT_DELAY RAM[ADDRA];
         end
      end
      DOA_R2 <=  DOA_R;
   end

   always @(posedge CLKB) begin
      if (ENB) begin
         if (WEB) begin
            // RAM[ADDRB] <= `BSV_ASSIGNMENT_DELAY DIB;
            DOB_R <=  DIB;
         end
         else begin
            DOB_R <= arb2; // `BSV_ASSIGNMENT_DELAY RAM[ADDRB];
         end
      end
      DOB_R2 <=  DOB_R;
   end

   // Output drivers
   assign DOA = (PIPELINED) ? DOA_R2 : DOA_R;
   assign DOB = (PIPELINED) ? DOB_R2 : DOB_R;

endmodule // BRAM2
//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
//
//
//
// Ports:
// Name                         I/O  size props
// RDY_set_verbosity              O     1 const
// RDY_server_reset_request_put   O     1 reg
// RDY_server_reset_response_get  O     1
// valid                          O     1
// addr                           O    32 reg
// word64                         O    64
// st_amo_val                     O    64
// exc                            O     1
// exc_code                       O     4 reg
// RDY_server_flush_request_put   O     1 reg
// RDY_server_flush_response_get  O     1
// RDY_tlb_flush                  O     1 const
// mem_master_awvalid             O     1 reg
// mem_master_awid                O     4 reg
// mem_master_awaddr              O    64 reg
// mem_master_awlen               O     8 reg
// mem_master_awsize              O     3 reg
// mem_master_awburst             O     2 reg
// mem_master_awlock              O     1 reg
// mem_master_awcache             O     4 reg
// mem_master_awprot              O     3 reg
// mem_master_awqos               O     4 reg
// mem_master_awregion            O     4 reg
// mem_master_wvalid              O     1 reg
// mem_master_wdata               O    64 reg
// mem_master_wstrb               O     8 reg
// mem_master_wlast               O     1 reg
// mem_master_bready              O     1 reg
// mem_master_arvalid             O     1 reg
// mem_master_arid                O     4 reg
// mem_master_araddr              O    64 reg
// mem_master_arlen               O     8 reg
// mem_master_arsize              O     3 reg
// mem_master_arburst             O     2 reg
// mem_master_arlock              O     1 reg
// mem_master_arcache             O     4 reg
// mem_master_arprot              O     3 reg
// mem_master_arqos               O     4 reg
// mem_master_arregion            O     4 reg
// mem_master_rready              O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// set_verbosity_verbosity        I     4 reg
// req_op                         I     1
// req_f3                         I     3
// req_addr                       I    32
// req_st_value                   I    64 reg
// req_priv                       I     2 unused
// req_sstatus_SUM                I     1 unused
// req_mstatus_MXR                I     1 unused
// req_satp                       I    32 unused
// mem_master_awready             I     1
// mem_master_wready              I     1
// mem_master_bvalid              I     1
// mem_master_bid                 I     4 reg
// mem_master_bresp               I     2 reg
// mem_master_arready             I     1
// mem_master_rvalid              I     1
// mem_master_rid                 I     4 reg
// mem_master_rdata               I    64 reg
// mem_master_rresp               I     2 reg
// mem_master_rlast               I     1 reg
// EN_set_verbosity               I     1
// EN_server_reset_request_put    I     1
// EN_server_reset_response_get   I     1
// EN_req                         I     1
// EN_server_flush_request_put    I     1
// EN_server_flush_response_get   I     1
// EN_tlb_flush                   I     1 unused
//
// No combinational paths from inputs to outputs
//
//










  
  


module mkMMU_Cache #(parameter dmem_not_imem = 1'b0)(CLK,
		   RST_N,

		   set_verbosity_verbosity,
		   EN_set_verbosity,
		   RDY_set_verbosity,

		   EN_server_reset_request_put,
		   RDY_server_reset_request_put,

		   EN_server_reset_response_get,
		   RDY_server_reset_response_get,

		   req_op,
		   req_f3,
		   req_addr,
		   req_st_value,
		   req_priv,
		   req_sstatus_SUM,
		   req_mstatus_MXR,
		   req_satp,
		   EN_req,

		   valid,

		   addr,

		   word64,

		   st_amo_val,

		   exc,

		   exc_code,

		   EN_server_flush_request_put,
		   RDY_server_flush_request_put,

		   EN_server_flush_response_get,
		   RDY_server_flush_response_get,

		   EN_tlb_flush,
		   RDY_tlb_flush,

		   mem_master_awvalid,

		   mem_master_awid,

		   mem_master_awaddr,

		   mem_master_awlen,

		   mem_master_awsize,

		   mem_master_awburst,

		   mem_master_awlock,

		   mem_master_awcache,

		   mem_master_awprot,

		   mem_master_awqos,

		   mem_master_awregion,

		   mem_master_awready,

		   mem_master_wvalid,

		   mem_master_wdata,

		   mem_master_wstrb,

		   mem_master_wlast,

		   mem_master_wready,

		   mem_master_bvalid,
		   mem_master_bid,
		   mem_master_bresp,

		   mem_master_bready,

		   mem_master_arvalid,

		   mem_master_arid,

		   mem_master_araddr,

		   mem_master_arlen,

		   mem_master_arsize,

		   mem_master_arburst,

		   mem_master_arlock,

		   mem_master_arcache,

		   mem_master_arprot,

		   mem_master_arqos,

		   mem_master_arregion,

		   mem_master_arready,

		   mem_master_rvalid,
		   mem_master_rid,
		   mem_master_rdata,
		   mem_master_rresp,
		   mem_master_rlast,

		   mem_master_rready, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr);
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg;
 output [31:0] RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg;
 output [31:0] RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr;
  input  CLK;
  input  RST_N;

  // action method set_verbosity
  input  [3 : 0] set_verbosity_verbosity;
  input  EN_set_verbosity;
  output RDY_set_verbosity;

  // action method server_reset_request_put
  input  EN_server_reset_request_put;
  output RDY_server_reset_request_put;

  // action method server_reset_response_get
  input  EN_server_reset_response_get;
  output RDY_server_reset_response_get;

  // action method req
  input  req_op;
  input  [2 : 0] req_f3;
  input  [31 : 0] req_addr;
  input  [63 : 0] req_st_value;
  input  [1 : 0] req_priv;
  input  req_sstatus_SUM;
  input  req_mstatus_MXR;
  input  [31 : 0] req_satp;
  input  EN_req;

  // value method valid
  output valid;

  // value method addr
  output [31 : 0] addr;

  // value method word64
  output [63 : 0] word64;

  // value method st_amo_val
  output [63 : 0] st_amo_val;

  // value method exc
  output exc;

  // value method exc_code
  output [3 : 0] exc_code;

  // action method server_flush_request_put
  input  EN_server_flush_request_put;
  output RDY_server_flush_request_put;

  // action method server_flush_response_get
  input  EN_server_flush_response_get;
  output RDY_server_flush_response_get;

  // action method tlb_flush
  input  EN_tlb_flush;
  output RDY_tlb_flush;

  // value method mem_master_m_awvalid
  output mem_master_awvalid;

  // value method mem_master_m_awid
  output [3 : 0] mem_master_awid;

  // value method mem_master_m_awaddr
  output [63 : 0] mem_master_awaddr;

  // value method mem_master_m_awlen
  output [7 : 0] mem_master_awlen;

  // value method mem_master_m_awsize
  output [2 : 0] mem_master_awsize;

  // value method mem_master_m_awburst
  output [1 : 0] mem_master_awburst;

  // value method mem_master_m_awlock
  output mem_master_awlock;

  // value method mem_master_m_awcache
  output [3 : 0] mem_master_awcache;

  // value method mem_master_m_awprot
  output [2 : 0] mem_master_awprot;

  // value method mem_master_m_awqos
  output [3 : 0] mem_master_awqos;

  // value method mem_master_m_awregion
  output [3 : 0] mem_master_awregion;

  // value method mem_master_m_awuser

  // action method mem_master_m_awready
  input  mem_master_awready;

  // value method mem_master_m_wvalid
  output mem_master_wvalid;

  // value method mem_master_m_wdata
  output [63 : 0] mem_master_wdata;

  // value method mem_master_m_wstrb
  output [7 : 0] mem_master_wstrb;

  // value method mem_master_m_wlast
  output mem_master_wlast;

  // value method mem_master_m_wuser

  // action method mem_master_m_wready
  input  mem_master_wready;

  // action method mem_master_m_bvalid
  input  mem_master_bvalid;
  input  [3 : 0] mem_master_bid;
  input  [1 : 0] mem_master_bresp;

  // value method mem_master_m_bready
  output mem_master_bready;

  // value method mem_master_m_arvalid
  output mem_master_arvalid;

  // value method mem_master_m_arid
  output [3 : 0] mem_master_arid;

  // value method mem_master_m_araddr
  output [63 : 0] mem_master_araddr;

  // value method mem_master_m_arlen
  output [7 : 0] mem_master_arlen;

  // value method mem_master_m_arsize
  output [2 : 0] mem_master_arsize;

  // value method mem_master_m_arburst
  output [1 : 0] mem_master_arburst;

  // value method mem_master_m_arlock
  output mem_master_arlock;

  // value method mem_master_m_arcache
  output [3 : 0] mem_master_arcache;

  // value method mem_master_m_arprot
  output [2 : 0] mem_master_arprot;

  // value method mem_master_m_arqos
  output [3 : 0] mem_master_arqos;

  // value method mem_master_m_arregion
  output [3 : 0] mem_master_arregion;

  // value method mem_master_m_aruser

  // action method mem_master_m_arready
  input  mem_master_arready;

  // action method mem_master_m_rvalid
  input  mem_master_rvalid;
  input  [3 : 0] mem_master_rid;
  input  [63 : 0] mem_master_rdata;
  input  [1 : 0] mem_master_rresp;
  input  mem_master_rlast;

  // value method mem_master_m_rready
  output mem_master_rready;


  // signals for module outputs
  reg [63 : 0] word64;
  wire [63 : 0] mem_master_araddr,
		mem_master_awaddr,
		mem_master_wdata,
		st_amo_val;
  wire [31 : 0] addr;
  wire [7 : 0] mem_master_arlen, mem_master_awlen, mem_master_wstrb;
  wire [3 : 0] exc_code,
	       mem_master_arcache,
	       mem_master_arid,
	       mem_master_arqos,
	       mem_master_arregion,
	       mem_master_awcache,
	       mem_master_awid,
	       mem_master_awqos,
	       mem_master_awregion;
  wire [2 : 0] mem_master_arprot,
	       mem_master_arsize,
	       mem_master_awprot,
	       mem_master_awsize;
  wire [1 : 0] mem_master_arburst, mem_master_awburst;
  wire RDY_server_flush_request_put,
       RDY_server_flush_response_get,
       RDY_server_reset_request_put,
       RDY_server_reset_response_get,
       RDY_set_verbosity,
       RDY_tlb_flush,
       exc,
       mem_master_arlock,
       mem_master_arvalid,
       mem_master_awlock,
       mem_master_awvalid,
       mem_master_bready,
       mem_master_rready,
       mem_master_wlast,
       mem_master_wvalid,
       valid;

  // inlined wires
  wire [3 : 0] ctr_wr_rsps_pending_crg$port0__write_1,
	       ctr_wr_rsps_pending_crg$port1__write_1,
	       ctr_wr_rsps_pending_crg$port2__read,
	       ctr_wr_rsps_pending_crg$port3__read;
  wire ctr_wr_rsps_pending_crg$EN_port2__write, dw_valid$whas;

  // register cfg_verbosity
  reg [3 : 0] cfg_verbosity;
  wire [3 : 0] cfg_verbosity$D_IN;
  wire cfg_verbosity$EN;

  // register ctr_wr_rsps_pending_crg
  reg [3 : 0] ctr_wr_rsps_pending_crg;
  wire [3 : 0] ctr_wr_rsps_pending_crg$D_IN;
  wire ctr_wr_rsps_pending_crg$EN;

  // register rg_addr
  reg [31 : 0] rg_addr;
  wire [31 : 0] rg_addr$D_IN;
  wire rg_addr$EN;

  // register rg_cset_in_cache
  reg [6 : 0] rg_cset_in_cache;
  wire [6 : 0] rg_cset_in_cache$D_IN;
  wire rg_cset_in_cache$EN;

  // register rg_error_during_refill
  reg rg_error_during_refill;
  wire rg_error_during_refill$D_IN, rg_error_during_refill$EN;

  // register rg_exc_code
  reg [3 : 0] rg_exc_code;
  reg [3 : 0] rg_exc_code$D_IN;
  wire rg_exc_code$EN;

  // register rg_f3
  reg [2 : 0] rg_f3;
  wire [2 : 0] rg_f3$D_IN;
  wire rg_f3$EN;

  // register rg_ld_val
  reg [63 : 0] rg_ld_val;
  wire [63 : 0] rg_ld_val$D_IN;
  wire rg_ld_val$EN;

  // register rg_lower_word32
  reg [31 : 0] rg_lower_word32;
  wire [31 : 0] rg_lower_word32$D_IN;
  wire rg_lower_word32$EN;

  // register rg_lower_word32_full
  reg rg_lower_word32_full;
  wire rg_lower_word32_full$D_IN, rg_lower_word32_full$EN;

  // register rg_op
  reg rg_op;
  wire rg_op$D_IN, rg_op$EN;

  // register rg_pa
  reg [31 : 0] rg_pa;
  wire [31 : 0] rg_pa$D_IN;
  wire rg_pa$EN;

  // register rg_pte_pa
  reg [31 : 0] rg_pte_pa;
  wire [31 : 0] rg_pte_pa$D_IN;
  wire rg_pte_pa$EN;

  // register rg_st_amo_val
  reg [63 : 0] rg_st_amo_val;
  wire [63 : 0] rg_st_amo_val$D_IN;
  wire rg_st_amo_val$EN;

  // register rg_state
  reg [3 : 0] rg_state;
  reg [3 : 0] rg_state$D_IN;
  wire rg_state$EN;

  // register rg_word64_set_in_cache
  reg [8 : 0] rg_word64_set_in_cache;
  wire [8 : 0] rg_word64_set_in_cache$D_IN;
  wire rg_word64_set_in_cache$EN;

  // ports of submodule f_fabric_write_reqs
  wire [98 : 0] f_fabric_write_reqs$D_IN, f_fabric_write_reqs$D_OUT;
  wire f_fabric_write_reqs$CLR,
       f_fabric_write_reqs$DEQ,
       f_fabric_write_reqs$EMPTY_N,
       f_fabric_write_reqs$ENQ,
       f_fabric_write_reqs$FULL_N;

  // ports of submodule f_reset_reqs
  wire f_reset_reqs$CLR,
       f_reset_reqs$DEQ,
       f_reset_reqs$D_IN,
       f_reset_reqs$D_OUT,
       f_reset_reqs$EMPTY_N,
       f_reset_reqs$ENQ,
       f_reset_reqs$FULL_N;

  // ports of submodule f_reset_rsps
  wire f_reset_rsps$CLR,
       f_reset_rsps$DEQ,
       f_reset_rsps$D_IN,
       f_reset_rsps$D_OUT,
       f_reset_rsps$EMPTY_N,
       f_reset_rsps$ENQ,
       f_reset_rsps$FULL_N;

  // ports of submodule master_xactor_f_rd_addr
  wire [96 : 0] master_xactor_f_rd_addr$D_IN, master_xactor_f_rd_addr$D_OUT;
  wire master_xactor_f_rd_addr$CLR,
       master_xactor_f_rd_addr$DEQ,
       master_xactor_f_rd_addr$EMPTY_N,
       master_xactor_f_rd_addr$ENQ,
       master_xactor_f_rd_addr$FULL_N;

  // ports of submodule master_xactor_f_rd_data
  wire [70 : 0] master_xactor_f_rd_data$D_IN, master_xactor_f_rd_data$D_OUT;
  wire master_xactor_f_rd_data$CLR,
       master_xactor_f_rd_data$DEQ,
       master_xactor_f_rd_data$EMPTY_N,
       master_xactor_f_rd_data$ENQ,
       master_xactor_f_rd_data$FULL_N;

  // ports of submodule master_xactor_f_wr_addr
  wire [96 : 0] master_xactor_f_wr_addr$D_IN, master_xactor_f_wr_addr$D_OUT;
  wire master_xactor_f_wr_addr$CLR,
       master_xactor_f_wr_addr$DEQ,
       master_xactor_f_wr_addr$EMPTY_N,
       master_xactor_f_wr_addr$ENQ,
       master_xactor_f_wr_addr$FULL_N;

  // ports of submodule master_xactor_f_wr_data
  wire [72 : 0] master_xactor_f_wr_data$D_IN, master_xactor_f_wr_data$D_OUT;
  wire master_xactor_f_wr_data$CLR,
       master_xactor_f_wr_data$DEQ,
       master_xactor_f_wr_data$EMPTY_N,
       master_xactor_f_wr_data$ENQ,
       master_xactor_f_wr_data$FULL_N;

  // ports of submodule master_xactor_f_wr_resp
  wire [5 : 0] master_xactor_f_wr_resp$D_IN, master_xactor_f_wr_resp$D_OUT;
  wire master_xactor_f_wr_resp$CLR,
       master_xactor_f_wr_resp$DEQ,
       master_xactor_f_wr_resp$EMPTY_N,
       master_xactor_f_wr_resp$ENQ,
       master_xactor_f_wr_resp$FULL_N;

  // ports of submodule ram_state_and_ctag_cset
  wire [22 : 0] ram_state_and_ctag_cset$DIA,
		ram_state_and_ctag_cset$DIB,
		ram_state_and_ctag_cset$DOB;
  wire [6 : 0] ram_state_and_ctag_cset$ADDRA, ram_state_and_ctag_cset$ADDRB;
  wire ram_state_and_ctag_cset$ENA,
       ram_state_and_ctag_cset$ENB,
       ram_state_and_ctag_cset$WEA,
       ram_state_and_ctag_cset$WEB;

  // ports of submodule ram_word64_set
  reg [63 : 0] ram_word64_set$DIB;
  reg [8 : 0] ram_word64_set$ADDRB;
  wire [63 : 0] ram_word64_set$DIA, ram_word64_set$DOB;
  wire [8 : 0] ram_word64_set$ADDRA;
  wire ram_word64_set$ENA,
       ram_word64_set$ENB,
       ram_word64_set$WEA,
       ram_word64_set$WEB;

  // ports of submodule soc_map
  wire [63 : 0] soc_map$m_is_IO_addr_addr,
		soc_map$m_is_mem_addr_addr,
		soc_map$m_is_near_mem_IO_addr_addr;
  wire soc_map$m_is_mem_addr;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_ST_AMO_response,
       CAN_FIRE_RL_rl_cache_refill_rsps_loop,
       CAN_FIRE_RL_rl_discard_write_rsp,
       CAN_FIRE_RL_rl_drive_exception_rsp,
       CAN_FIRE_RL_rl_fabric_send_write_req,
       CAN_FIRE_RL_rl_io_read_req,
       CAN_FIRE_RL_rl_io_read_rsp,
       CAN_FIRE_RL_rl_io_write_req,
       CAN_FIRE_RL_rl_maintain_io_read_rsp,
       CAN_FIRE_RL_rl_probe_and_immed_rsp,
       CAN_FIRE_RL_rl_rereq,
       CAN_FIRE_RL_rl_reset,
       CAN_FIRE_RL_rl_start_cache_refill,
       CAN_FIRE_RL_rl_start_reset,
       CAN_FIRE_mem_master_m_arready,
       CAN_FIRE_mem_master_m_awready,
       CAN_FIRE_mem_master_m_bvalid,
       CAN_FIRE_mem_master_m_rvalid,
       CAN_FIRE_mem_master_m_wready,
       CAN_FIRE_req,
       CAN_FIRE_server_flush_request_put,
       CAN_FIRE_server_flush_response_get,
       CAN_FIRE_server_reset_request_put,
       CAN_FIRE_server_reset_response_get,
       CAN_FIRE_set_verbosity,
       CAN_FIRE_tlb_flush,
       WILL_FIRE_RL_rl_ST_AMO_response,
       WILL_FIRE_RL_rl_cache_refill_rsps_loop,
       WILL_FIRE_RL_rl_discard_write_rsp,
       WILL_FIRE_RL_rl_drive_exception_rsp,
       WILL_FIRE_RL_rl_fabric_send_write_req,
       WILL_FIRE_RL_rl_io_read_req,
       WILL_FIRE_RL_rl_io_read_rsp,
       WILL_FIRE_RL_rl_io_write_req,
       WILL_FIRE_RL_rl_maintain_io_read_rsp,
       WILL_FIRE_RL_rl_probe_and_immed_rsp,
       WILL_FIRE_RL_rl_rereq,
       WILL_FIRE_RL_rl_reset,
       WILL_FIRE_RL_rl_start_cache_refill,
       WILL_FIRE_RL_rl_start_reset,
       WILL_FIRE_mem_master_m_arready,
       WILL_FIRE_mem_master_m_awready,
       WILL_FIRE_mem_master_m_bvalid,
       WILL_FIRE_mem_master_m_rvalid,
       WILL_FIRE_mem_master_m_wready,
       WILL_FIRE_req,
       WILL_FIRE_server_flush_request_put,
       WILL_FIRE_server_flush_response_get,
       WILL_FIRE_server_reset_request_put,
       WILL_FIRE_server_reset_response_get,
       WILL_FIRE_set_verbosity,
       WILL_FIRE_tlb_flush;

  // inputs to muxes for submodule ports
  reg [63 : 0] MUX_dw_output_ld_val$wset_1__VAL_2;
  wire [98 : 0] MUX_f_fabric_write_reqs$enq_1__VAL_1,
		MUX_f_fabric_write_reqs$enq_1__VAL_2;
  wire [96 : 0] MUX_master_xactor_f_rd_addr$enq_1__VAL_1,
		MUX_master_xactor_f_rd_addr$enq_1__VAL_2;
  wire [22 : 0] MUX_ram_state_and_ctag_cset$a_put_3__VAL_1;
  wire [8 : 0] MUX_ram_word64_set$b_put_2__VAL_2,
	       MUX_ram_word64_set$b_put_2__VAL_4;
  wire [6 : 0] MUX_rg_cset_in_cache$write_1__VAL_1;
  wire [3 : 0] MUX_rg_exc_code$write_1__VAL_1,
	       MUX_rg_state$write_1__VAL_1,
	       MUX_rg_state$write_1__VAL_4,
	       MUX_rg_state$write_1__VAL_7,
	       MUX_rg_state$write_1__VAL_9;
  wire MUX_dw_output_ld_val$wset_1__SEL_1,
       MUX_dw_output_ld_val$wset_1__SEL_2,
       MUX_dw_output_ld_val$wset_1__SEL_3,
       MUX_f_fabric_write_reqs$enq_1__SEL_1,
       MUX_ram_state_and_ctag_cset$b_put_1__SEL_1,
       MUX_ram_word64_set$a_put_1__SEL_1,
       MUX_ram_word64_set$b_put_1__SEL_2,
       MUX_rg_error_during_refill$write_1__SEL_1,
       MUX_rg_exc_code$write_1__SEL_1,
       MUX_rg_exc_code$write_1__SEL_2,
       MUX_rg_state$write_1__SEL_10,
       MUX_rg_state$write_1__SEL_2,
       MUX_rg_state$write_1__SEL_3,
       MUX_rg_state$write_1__SEL_7,
       MUX_rg_state$write_1__SEL_9;

  // declarations used by system tasks
  // synopsys translate_off
  reg [31 : 0] v__h2948;
  reg [31 : 0] v__h3848;
  reg [31 : 0] v__h3949;
  reg [31 : 0] v__h4098;
  reg [31 : 0] v__h12540;
  reg [31 : 0] v__h14531;
  reg [31 : 0] v__h15336;
  reg [31 : 0] v__h15578;
  reg [31 : 0] v__h17191;
  reg [31 : 0] v__h17485;
  reg [31 : 0] v__h18585;
  reg [31 : 0] v__h18692;
  reg [31 : 0] v__h18797;
  reg [31 : 0] v__h18877;
  reg [31 : 0] v__h19505;
  reg [31 : 0] v__h19466;
  reg [31 : 0] v__h3483;
  reg [31 : 0] v__h19852;
  reg [31 : 0] v__h2942;
  reg [31 : 0] v__h3477;
  reg [31 : 0] v__h3842;
  reg [31 : 0] v__h3943;
  reg [31 : 0] v__h4092;
  reg [31 : 0] v__h12534;
  reg [31 : 0] v__h14525;
  reg [31 : 0] v__h15330;
  reg [31 : 0] v__h15572;
  reg [31 : 0] v__h17185;
  reg [31 : 0] v__h17479;
  reg [31 : 0] v__h18579;
  reg [31 : 0] v__h18686;
  reg [31 : 0] v__h18791;
  reg [31 : 0] v__h18871;
  reg [31 : 0] v__h19460;
  reg [31 : 0] v__h19499;
  reg [31 : 0] v__h19846;
  // synopsys translate_on

  // remaining internal signals
  reg [63 : 0] CASE_rg_addr_BITS_2_TO_0_0x0_ram_word64_setDO_ETC__q31,
	       CASE_rg_addr_BITS_2_TO_0_0x0_result2361_0x4_re_ETC__q32,
	       CASE_rg_addr_BITS_2_TO_0_0x0_result2428_0x4_re_ETC__q33,
	       CASE_rg_addr_BITS_2_TO_0_0x0_result8365_0x4_re_ETC__q29,
	       CASE_rg_addr_BITS_2_TO_0_0x0_result8430_0x4_re_ETC__q30,
	       IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d264,
	       IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d285,
	       IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d427,
	       IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d447,
	       IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d247,
	       IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d276,
	       IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d411,
	       IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d439,
	       IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d157,
	       IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d167,
	       IF_rg_f3_16_EQ_0b0_17_THEN_IF_rg_addr_6_BITS_2_ETC___d178,
	       ld_val__h17594,
	       mem_req_wr_data_wdata__h2699;
  reg [7 : 0] mem_req_wr_data_wstrb__h2700;
  reg [2 : 0] value__h17372, x__h2520;
  wire [63 : 0] _theResult___snd_fst__h2707,
		cline_fabric_addr__h14584,
		fabric_addr__h17243,
		mem_req_wr_addr_awaddr__h2473,
		result__h11657,
		result__h11685,
		result__h11713,
		result__h11741,
		result__h11769,
		result__h11797,
		result__h11825,
		result__h11870,
		result__h11898,
		result__h11926,
		result__h11954,
		result__h11982,
		result__h12010,
		result__h12038,
		result__h12066,
		result__h12111,
		result__h12139,
		result__h12167,
		result__h12195,
		result__h12236,
		result__h12264,
		result__h12292,
		result__h12320,
		result__h12361,
		result__h12389,
		result__h12428,
		result__h12456,
		result__h17654,
		result__h17684,
		result__h17711,
		result__h17738,
		result__h17765,
		result__h17792,
		result__h17819,
		result__h17846,
		result__h17890,
		result__h17917,
		result__h17944,
		result__h17971,
		result__h17998,
		result__h18025,
		result__h18052,
		result__h18079,
		result__h18123,
		result__h18150,
		result__h18177,
		result__h18204,
		result__h18244,
		result__h18271,
		result__h18298,
		result__h18325,
		result__h18365,
		result__h18392,
		result__h18430,
		result__h18457,
		result__h5301,
		word64__h5094,
		y__h5337;
  wire [31 : 0] cline_addr__h14583,
		master_xactor_f_rd_dataD_OUT_BITS_34_TO_3__q3,
		master_xactor_f_rd_dataD_OUT_BITS_66_TO_35__q10,
		word64094_BITS_31_TO_0__q17,
		word64094_BITS_63_TO_32__q24;
  wire [21 : 0] pa_ctag__h4952;
  wire [15 : 0] master_xactor_f_rd_dataD_OUT_BITS_18_TO_3__q2,
		master_xactor_f_rd_dataD_OUT_BITS_34_TO_19__q6,
		master_xactor_f_rd_dataD_OUT_BITS_50_TO_35__q9,
		master_xactor_f_rd_dataD_OUT_BITS_66_TO_51__q13,
		word64094_BITS_15_TO_0__q16,
		word64094_BITS_31_TO_16__q20,
		word64094_BITS_47_TO_32__q23,
		word64094_BITS_63_TO_48__q27;
  wire [7 : 0] master_xactor_f_rd_dataD_OUT_BITS_10_TO_3__q1,
	       master_xactor_f_rd_dataD_OUT_BITS_18_TO_11__q4,
	       master_xactor_f_rd_dataD_OUT_BITS_26_TO_19__q5,
	       master_xactor_f_rd_dataD_OUT_BITS_34_TO_27__q7,
	       master_xactor_f_rd_dataD_OUT_BITS_42_TO_35__q8,
	       master_xactor_f_rd_dataD_OUT_BITS_50_TO_43__q11,
	       master_xactor_f_rd_dataD_OUT_BITS_58_TO_51__q12,
	       master_xactor_f_rd_dataD_OUT_BITS_66_TO_59__q14,
	       strobe64__h2637,
	       strobe64__h2639,
	       strobe64__h2641,
	       word64094_BITS_15_TO_8__q18,
	       word64094_BITS_23_TO_16__q19,
	       word64094_BITS_31_TO_24__q21,
	       word64094_BITS_39_TO_32__q22,
	       word64094_BITS_47_TO_40__q25,
	       word64094_BITS_55_TO_48__q26,
	       word64094_BITS_63_TO_56__q28,
	       word64094_BITS_7_TO_0__q15;
  wire [5 : 0] shift_bits__h2487;
  wire [3 : 0] access_exc_code__h2256, b__h14485;
  wire NOT_cfg_verbosity_read__0_ULE_1_1___d42,
       NOT_cfg_verbosity_read__0_ULE_2_30___d331,
       NOT_dmem_not_imem_10_OR_soc_map_m_is_mem_addr__ETC___d114,
       NOT_dmem_not_imem_10_OR_soc_map_m_is_mem_addr__ETC___d190,
       NOT_req_f3_BITS_1_TO_0_18_EQ_0b0_19_20_AND_NOT_ETC___d539,
       NOT_rg_op_1_2_AND_ram_state_and_ctag_cset_b_re_ETC___d305,
       dmem_not_imem_AND_NOT_soc_map_m_is_mem_addr_0__ETC___d106,
       ram_state_and_ctag_cset_b_read__5_BITS_21_TO_0_ETC___d102,
       req_f3_BITS_1_TO_0_18_EQ_0b0_19_OR_req_f3_BITS_ETC___d548,
       rg_op_1_AND_ram_state_and_ctag_cset_b_read__5__ETC___d180;

  // action method set_verbosity
  assign RDY_set_verbosity = 1'd1 ;
  assign CAN_FIRE_set_verbosity = 1'd1 ;
  assign WILL_FIRE_set_verbosity = EN_set_verbosity ;

  // action method server_reset_request_put
  assign RDY_server_reset_request_put = f_reset_reqs$FULL_N ;
  assign CAN_FIRE_server_reset_request_put = f_reset_reqs$FULL_N ;
  assign WILL_FIRE_server_reset_request_put = EN_server_reset_request_put ;

  // action method server_reset_response_get
  assign RDY_server_reset_response_get =
	     !f_reset_rsps$D_OUT && f_reset_rsps$EMPTY_N ;
  assign CAN_FIRE_server_reset_response_get =
	     !f_reset_rsps$D_OUT && f_reset_rsps$EMPTY_N ;
  assign WILL_FIRE_server_reset_response_get = EN_server_reset_response_get ;

  // action method req
  assign CAN_FIRE_req = 1'd1 ;
  assign WILL_FIRE_req = EN_req ;

  // value method valid
  assign valid = dw_valid$whas ;

  // value method addr
  assign addr = rg_addr ;

  // value method word64
  always@(MUX_dw_output_ld_val$wset_1__SEL_1 or
	  ld_val__h17594 or
	  MUX_dw_output_ld_val$wset_1__SEL_2 or
	  MUX_dw_output_ld_val$wset_1__VAL_2 or
	  MUX_dw_output_ld_val$wset_1__SEL_3 or rg_ld_val)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_dw_output_ld_val$wset_1__SEL_1: word64 = ld_val__h17594;
      MUX_dw_output_ld_val$wset_1__SEL_2:
	  word64 = MUX_dw_output_ld_val$wset_1__VAL_2;
      MUX_dw_output_ld_val$wset_1__SEL_3: word64 = rg_ld_val;
      default: word64 = 64'hAAAAAAAAAAAAAAAA /* unspecified value */ ;
    endcase
  end

  // value method st_amo_val
  assign st_amo_val =
	     MUX_dw_output_ld_val$wset_1__SEL_2 ? 64'd0 : rg_st_amo_val ;

  // value method exc
  assign exc = rg_state == 4'd4 ;

  // value method exc_code
  assign exc_code = rg_exc_code ;

  // action method server_flush_request_put
  assign RDY_server_flush_request_put = f_reset_reqs$FULL_N ;
  assign CAN_FIRE_server_flush_request_put = f_reset_reqs$FULL_N ;
  assign WILL_FIRE_server_flush_request_put = EN_server_flush_request_put ;

  // action method server_flush_response_get
  assign RDY_server_flush_response_get =
	     f_reset_rsps$D_OUT && f_reset_rsps$EMPTY_N ;
  assign CAN_FIRE_server_flush_response_get =
	     f_reset_rsps$D_OUT && f_reset_rsps$EMPTY_N ;
  assign WILL_FIRE_server_flush_response_get = EN_server_flush_response_get ;

  // action method tlb_flush
  assign RDY_tlb_flush = 1'd1 ;
  assign CAN_FIRE_tlb_flush = 1'd1 ;
  assign WILL_FIRE_tlb_flush = EN_tlb_flush ;

  // value method mem_master_m_awvalid
  assign mem_master_awvalid = master_xactor_f_wr_addr$EMPTY_N ;

  // value method mem_master_m_awid
  assign mem_master_awid = master_xactor_f_wr_addr$D_OUT[96:93] ;

  // value method mem_master_m_awaddr
  assign mem_master_awaddr = master_xactor_f_wr_addr$D_OUT[92:29] ;

  // value method mem_master_m_awlen
  assign mem_master_awlen = master_xactor_f_wr_addr$D_OUT[28:21] ;

  // value method mem_master_m_awsize
  assign mem_master_awsize = master_xactor_f_wr_addr$D_OUT[20:18] ;

  // value method mem_master_m_awburst
  assign mem_master_awburst = master_xactor_f_wr_addr$D_OUT[17:16] ;

  // value method mem_master_m_awlock
  assign mem_master_awlock = master_xactor_f_wr_addr$D_OUT[15] ;

  // value method mem_master_m_awcache
  assign mem_master_awcache = master_xactor_f_wr_addr$D_OUT[14:11] ;

  // value method mem_master_m_awprot
  assign mem_master_awprot = master_xactor_f_wr_addr$D_OUT[10:8] ;

  // value method mem_master_m_awqos
  assign mem_master_awqos = master_xactor_f_wr_addr$D_OUT[7:4] ;

  // value method mem_master_m_awregion
  assign mem_master_awregion = master_xactor_f_wr_addr$D_OUT[3:0] ;

  // action method mem_master_m_awready
  assign CAN_FIRE_mem_master_m_awready = 1'd1 ;
  assign WILL_FIRE_mem_master_m_awready = 1'd1 ;

  // value method mem_master_m_wvalid
  assign mem_master_wvalid = master_xactor_f_wr_data$EMPTY_N ;

  // value method mem_master_m_wdata
  assign mem_master_wdata = master_xactor_f_wr_data$D_OUT[72:9] ;

  // value method mem_master_m_wstrb
  assign mem_master_wstrb = master_xactor_f_wr_data$D_OUT[8:1] ;

  // value method mem_master_m_wlast
  assign mem_master_wlast = master_xactor_f_wr_data$D_OUT[0] ;

  // action method mem_master_m_wready
  assign CAN_FIRE_mem_master_m_wready = 1'd1 ;
  assign WILL_FIRE_mem_master_m_wready = 1'd1 ;

  // action method mem_master_m_bvalid
  assign CAN_FIRE_mem_master_m_bvalid = 1'd1 ;
  assign WILL_FIRE_mem_master_m_bvalid = 1'd1 ;

  // value method mem_master_m_bready
  assign mem_master_bready = master_xactor_f_wr_resp$FULL_N ;

  // value method mem_master_m_arvalid
  assign mem_master_arvalid = master_xactor_f_rd_addr$EMPTY_N ;

  // value method mem_master_m_arid
  assign mem_master_arid = master_xactor_f_rd_addr$D_OUT[96:93] ;

  // value method mem_master_m_araddr
  assign mem_master_araddr = master_xactor_f_rd_addr$D_OUT[92:29] ;

  // value method mem_master_m_arlen
  assign mem_master_arlen = master_xactor_f_rd_addr$D_OUT[28:21] ;

  // value method mem_master_m_arsize
  assign mem_master_arsize = master_xactor_f_rd_addr$D_OUT[20:18] ;

  // value method mem_master_m_arburst
  assign mem_master_arburst = master_xactor_f_rd_addr$D_OUT[17:16] ;

  // value method mem_master_m_arlock
  assign mem_master_arlock = master_xactor_f_rd_addr$D_OUT[15] ;

  // value method mem_master_m_arcache
  assign mem_master_arcache = master_xactor_f_rd_addr$D_OUT[14:11] ;

  // value method mem_master_m_arprot
  assign mem_master_arprot = master_xactor_f_rd_addr$D_OUT[10:8] ;

  // value method mem_master_m_arqos
  assign mem_master_arqos = master_xactor_f_rd_addr$D_OUT[7:4] ;

  // value method mem_master_m_arregion
  assign mem_master_arregion = master_xactor_f_rd_addr$D_OUT[3:0] ;

  // action method mem_master_m_arready
  assign CAN_FIRE_mem_master_m_arready = 1'd1 ;
  assign WILL_FIRE_mem_master_m_arready = 1'd1 ;

  // action method mem_master_m_rvalid
  assign CAN_FIRE_mem_master_m_rvalid = 1'd1 ;
  assign WILL_FIRE_mem_master_m_rvalid = 1'd1 ;

  // value method mem_master_m_rready
  assign mem_master_rready = master_xactor_f_rd_data$FULL_N ;

  // submodule f_fabric_write_reqs
  FIFO2 #(.width(32'd99), .guarded(32'd1)) f_fabric_write_reqs(.RST(RST_N),
							       .CLK(CLK),
							       .D_IN(f_fabric_write_reqs$D_IN),
							       .ENQ(f_fabric_write_reqs$ENQ),
							       .DEQ(f_fabric_write_reqs$DEQ),
							       .CLR(f_fabric_write_reqs$CLR),
							       .D_OUT(f_fabric_write_reqs$D_OUT),
							       .FULL_N(f_fabric_write_reqs$FULL_N),
							       .EMPTY_N(f_fabric_write_reqs$EMPTY_N) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg));

  // submodule f_reset_reqs
  FIFO2 #(.width(32'd1), .guarded(32'd1)) f_reset_reqs(.RST(RST_N),
						       .CLK(CLK),
						       .D_IN(f_reset_reqs$D_IN),
						       .ENQ(f_reset_reqs$ENQ),
						       .DEQ(f_reset_reqs$DEQ),
						       .CLR(f_reset_reqs$CLR),
						       .D_OUT(f_reset_reqs$D_OUT),
						       .FULL_N(f_reset_reqs$FULL_N),
						       .EMPTY_N(f_reset_reqs$EMPTY_N) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg));

  // submodule f_reset_rsps
  FIFO2 #(.width(32'd1), .guarded(32'd1)) f_reset_rsps(.RST(RST_N),
						       .CLK(CLK),
						       .D_IN(f_reset_rsps$D_IN),
						       .ENQ(f_reset_rsps$ENQ),
						       .DEQ(f_reset_rsps$DEQ),
						       .CLR(f_reset_rsps$CLR),
						       .D_OUT(f_reset_rsps$D_OUT),
						       .FULL_N(f_reset_rsps$FULL_N),
						       .EMPTY_N(f_reset_rsps$EMPTY_N) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg));

  // submodule master_xactor_f_rd_addr
  FIFO2 #(.width(32'd97),
	  .guarded(32'd1)) master_xactor_f_rd_addr(.RST(RST_N),
						   .CLK(CLK),
						   .D_IN(master_xactor_f_rd_addr$D_IN),
						   .ENQ(master_xactor_f_rd_addr$ENQ),
						   .DEQ(master_xactor_f_rd_addr$DEQ),
						   .CLR(master_xactor_f_rd_addr$CLR),
						   .D_OUT(master_xactor_f_rd_addr$D_OUT),
						   .FULL_N(master_xactor_f_rd_addr$FULL_N),
						   .EMPTY_N(master_xactor_f_rd_addr$EMPTY_N) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg));

  // submodule master_xactor_f_rd_data
  FIFO2 #(.width(32'd71),
	  .guarded(32'd1)) master_xactor_f_rd_data(.RST(RST_N),
						   .CLK(CLK),
						   .D_IN(master_xactor_f_rd_data$D_IN),
						   .ENQ(master_xactor_f_rd_data$ENQ),
						   .DEQ(master_xactor_f_rd_data$DEQ),
						   .CLR(master_xactor_f_rd_data$CLR),
						   .D_OUT(master_xactor_f_rd_data$D_OUT),
						   .FULL_N(master_xactor_f_rd_data$FULL_N),
						   .EMPTY_N(master_xactor_f_rd_data$EMPTY_N) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg));

  // submodule master_xactor_f_wr_addr
  FIFO2 #(.width(32'd97),
	  .guarded(32'd1)) master_xactor_f_wr_addr(.RST(RST_N),
						   .CLK(CLK),
						   .D_IN(master_xactor_f_wr_addr$D_IN),
						   .ENQ(master_xactor_f_wr_addr$ENQ),
						   .DEQ(master_xactor_f_wr_addr$DEQ),
						   .CLR(master_xactor_f_wr_addr$CLR),
						   .D_OUT(master_xactor_f_wr_addr$D_OUT),
						   .FULL_N(master_xactor_f_wr_addr$FULL_N),
						   .EMPTY_N(master_xactor_f_wr_addr$EMPTY_N) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg));

  // submodule master_xactor_f_wr_data
  FIFO2 #(.width(32'd73),
	  .guarded(32'd1)) master_xactor_f_wr_data(.RST(RST_N),
						   .CLK(CLK),
						   .D_IN(master_xactor_f_wr_data$D_IN),
						   .ENQ(master_xactor_f_wr_data$ENQ),
						   .DEQ(master_xactor_f_wr_data$DEQ),
						   .CLR(master_xactor_f_wr_data$CLR),
						   .D_OUT(master_xactor_f_wr_data$D_OUT),
						   .FULL_N(master_xactor_f_wr_data$FULL_N),
						   .EMPTY_N(master_xactor_f_wr_data$EMPTY_N) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg));

  // submodule master_xactor_f_wr_resp
  FIFO2 #(.width(32'd6), .guarded(32'd1)) master_xactor_f_wr_resp(.RST(RST_N),
								  .CLK(CLK),
								  .D_IN(master_xactor_f_wr_resp$D_IN),
								  .ENQ(master_xactor_f_wr_resp$ENQ),
								  .DEQ(master_xactor_f_wr_resp$DEQ),
								  .CLR(master_xactor_f_wr_resp$CLR),
								  .D_OUT(master_xactor_f_wr_resp$D_OUT),
								  .FULL_N(master_xactor_f_wr_resp$FULL_N),
								  .EMPTY_N(master_xactor_f_wr_resp$EMPTY_N) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg));

  // submodule ram_state_and_ctag_cset
  BRAM2 #(.PIPELINED(1'd0),
	  .ADDR_WIDTH(32'd7),
	  .DATA_WIDTH(32'd23),
	  .MEMSIZE(8'd128)) ram_state_and_ctag_cset(.CLKA(CLK),
						    .CLKB(CLK),
						    .ADDRA(ram_state_and_ctag_cset$ADDRA),
						    .ADDRB(ram_state_and_ctag_cset$ADDRB),
						    .DIA(ram_state_and_ctag_cset$DIA),
						    .DIB(ram_state_and_ctag_cset$DIB),
						    .WEA(ram_state_and_ctag_cset$WEA),
						    .WEB(ram_state_and_ctag_cset$WEB),
						    .ENA(ram_state_and_ctag_cset$ENA),
						    .ENB(ram_state_and_ctag_cset$ENB),
						    .DOA(),
						    .DOB(ram_state_and_ctag_cset$DOB));

  // submodule ram_word64_set
  BRAM2 #(.PIPELINED(1'd0),
	  .ADDR_WIDTH(32'd9),
	  .DATA_WIDTH(32'd64),
	  .MEMSIZE(10'd512)) ram_word64_set(.CLKA(CLK),
					    .CLKB(CLK),
					    .ADDRA(ram_word64_set$ADDRA),
					    .ADDRB(ram_word64_set$ADDRB),
					    .DIA(ram_word64_set$DIA),
					    .DIB(ram_word64_set$DIB),
					    .WEA(ram_word64_set$WEA),
					    .WEB(ram_word64_set$WEB),
					    .ENA(ram_word64_set$ENA),
					    .ENB(ram_word64_set$ENB),
					    .DOA(),
					    .DOB(ram_word64_set$DOB));

  // submodule soc_map
  mkSoC_Map soc_map(.CLK(CLK),
		    .RST_N(RST_N),
		    .m_is_IO_addr_addr(soc_map$m_is_IO_addr_addr),
		    .m_is_mem_addr_addr(soc_map$m_is_mem_addr_addr),
		    .m_is_near_mem_IO_addr_addr(soc_map$m_is_near_mem_IO_addr_addr),
		    .m_near_mem_io_addr_base(),
		    .m_near_mem_io_addr_size(),
		    .m_near_mem_io_addr_lim(),
		    .m_plic_addr_base(),
		    .m_plic_addr_size(),
		    .m_plic_addr_lim(),
		    .m_uart0_addr_base(),
		    .m_uart0_addr_size(),
		    .m_uart0_addr_lim(),
		    .m_boot_rom_addr_base(),
		    .m_boot_rom_addr_size(),
		    .m_boot_rom_addr_lim(),
		    .m_mem0_controller_addr_base(),
		    .m_mem0_controller_addr_size(),
		    .m_mem0_controller_addr_lim(),
		    .m_tcm_addr_base(),
		    .m_tcm_addr_size(),
		    .m_tcm_addr_lim(),
		    .m_is_mem_addr(soc_map$m_is_mem_addr),
		    .m_is_IO_addr(),
		    .m_is_near_mem_IO_addr(),
		    .m_pc_reset_value(),
		    .m_mtvec_reset_value(),
		    .m_nmivec_reset_value());

  // rule RL_rl_fabric_send_write_req
  assign CAN_FIRE_RL_rl_fabric_send_write_req =
	     f_fabric_write_reqs$EMPTY_N && master_xactor_f_wr_addr$FULL_N &&
	     master_xactor_f_wr_data$FULL_N ;
  assign WILL_FIRE_RL_rl_fabric_send_write_req =
	     CAN_FIRE_RL_rl_fabric_send_write_req ;

  // rule RL_rl_reset
  assign CAN_FIRE_RL_rl_reset =
	     (rg_cset_in_cache != 7'd127 ||
	      f_reset_reqs$EMPTY_N && f_reset_rsps$FULL_N) &&
	     rg_state == 4'd1 ;
  assign WILL_FIRE_RL_rl_reset = CAN_FIRE_RL_rl_reset ;

  // rule RL_rl_probe_and_immed_rsp
  assign CAN_FIRE_RL_rl_probe_and_immed_rsp =
	     (dmem_not_imem && !soc_map$m_is_mem_addr || !rg_op ||
	      f_fabric_write_reqs$FULL_N) &&
	     rg_state == 4'd3 ;
  assign WILL_FIRE_RL_rl_probe_and_immed_rsp =
	     CAN_FIRE_RL_rl_probe_and_immed_rsp &&
	     !WILL_FIRE_RL_rl_start_reset ;

  // rule RL_rl_start_cache_refill
  assign CAN_FIRE_RL_rl_start_cache_refill =
	     master_xactor_f_rd_addr$FULL_N && rg_state == 4'd8 &&
	     b__h14485 == 4'd0 ;
  assign WILL_FIRE_RL_rl_start_cache_refill =
	     CAN_FIRE_RL_rl_start_cache_refill &&
	     !WILL_FIRE_RL_rl_start_reset &&
	     !EN_req ;

  // rule RL_rl_cache_refill_rsps_loop
  assign CAN_FIRE_RL_rl_cache_refill_rsps_loop =
	     master_xactor_f_rd_data$EMPTY_N && rg_state == 4'd9 ;
  assign WILL_FIRE_RL_rl_cache_refill_rsps_loop =
	     CAN_FIRE_RL_rl_cache_refill_rsps_loop &&
	     !WILL_FIRE_RL_rl_start_reset &&
	     !EN_req ;

  // rule RL_rl_rereq
  assign CAN_FIRE_RL_rl_rereq = rg_state == 4'd10 ;
  assign WILL_FIRE_RL_rl_rereq =
	     CAN_FIRE_RL_rl_rereq && !WILL_FIRE_RL_rl_start_reset && !EN_req ;

  // rule RL_rl_ST_AMO_response
  assign CAN_FIRE_RL_rl_ST_AMO_response = rg_state == 4'd11 ;
  assign WILL_FIRE_RL_rl_ST_AMO_response = CAN_FIRE_RL_rl_ST_AMO_response ;

  // rule RL_rl_io_read_req
  assign CAN_FIRE_RL_rl_io_read_req =
	     master_xactor_f_rd_addr$FULL_N && rg_state == 4'd12 && !rg_op &&
	     b__h14485 == 4'd0 ;
  assign WILL_FIRE_RL_rl_io_read_req =
	     CAN_FIRE_RL_rl_io_read_req && !WILL_FIRE_RL_rl_start_reset ;

  // rule RL_rl_io_read_rsp
  assign CAN_FIRE_RL_rl_io_read_rsp =
	     master_xactor_f_rd_data$EMPTY_N && rg_state == 4'd13 ;
  assign WILL_FIRE_RL_rl_io_read_rsp =
	     CAN_FIRE_RL_rl_io_read_rsp && !WILL_FIRE_RL_rl_start_reset ;

  // rule RL_rl_maintain_io_read_rsp
  assign CAN_FIRE_RL_rl_maintain_io_read_rsp = rg_state == 4'd14 ;
  assign WILL_FIRE_RL_rl_maintain_io_read_rsp =
	     CAN_FIRE_RL_rl_maintain_io_read_rsp ;

  // rule RL_rl_io_write_req
  assign CAN_FIRE_RL_rl_io_write_req =
	     f_fabric_write_reqs$FULL_N && rg_state == 4'd12 && rg_op ;
  assign WILL_FIRE_RL_rl_io_write_req = MUX_rg_state$write_1__SEL_3 ;

  // rule RL_rl_discard_write_rsp
  assign CAN_FIRE_RL_rl_discard_write_rsp =
	     b__h14485 != 4'd0 && master_xactor_f_wr_resp$EMPTY_N ;
  assign WILL_FIRE_RL_rl_discard_write_rsp =
	     CAN_FIRE_RL_rl_discard_write_rsp ;

  // rule RL_rl_drive_exception_rsp
  assign CAN_FIRE_RL_rl_drive_exception_rsp = rg_state == 4'd4 ;
  assign WILL_FIRE_RL_rl_drive_exception_rsp = rg_state == 4'd4 ;

  // rule RL_rl_start_reset
  assign CAN_FIRE_RL_rl_start_reset = MUX_rg_state$write_1__SEL_2 ;
  assign WILL_FIRE_RL_rl_start_reset = MUX_rg_state$write_1__SEL_2 ;

  // inputs to muxes for submodule ports
  assign MUX_dw_output_ld_val$wset_1__SEL_1 =
	     WILL_FIRE_RL_rl_io_read_rsp &&
	     master_xactor_f_rd_data$D_OUT[2:1] == 2'b0 ;
  assign MUX_dw_output_ld_val$wset_1__SEL_2 =
	     WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	     NOT_dmem_not_imem_10_OR_soc_map_m_is_mem_addr__ETC___d190 ;
  assign MUX_dw_output_ld_val$wset_1__SEL_3 =
	     WILL_FIRE_RL_rl_maintain_io_read_rsp ||
	     WILL_FIRE_RL_rl_ST_AMO_response ;
  assign MUX_f_fabric_write_reqs$enq_1__SEL_1 =
	     WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	     (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	     rg_op ;
  assign MUX_ram_state_and_ctag_cset$b_put_1__SEL_1 =
	     EN_req &&
	     req_f3_BITS_1_TO_0_18_EQ_0b0_19_OR_req_f3_BITS_ETC___d548 ;
  assign MUX_ram_word64_set$a_put_1__SEL_1 =
	     WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	     master_xactor_f_rd_data$D_OUT[2:1] == 2'b0 ;
  assign MUX_ram_word64_set$b_put_1__SEL_2 =
	     WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	     rg_word64_set_in_cache[1:0] != 2'd3 ;
  assign MUX_rg_error_during_refill$write_1__SEL_1 =
	     WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	     master_xactor_f_rd_data$D_OUT[2:1] != 2'b0 ;
  assign MUX_rg_exc_code$write_1__SEL_1 =
	     EN_req &&
	     NOT_req_f3_BITS_1_TO_0_18_EQ_0b0_19_20_AND_NOT_ETC___d539 ;
  assign MUX_rg_exc_code$write_1__SEL_2 =
	     WILL_FIRE_RL_rl_io_read_rsp &&
	     master_xactor_f_rd_data$D_OUT[2:1] != 2'b0 ;
  assign MUX_rg_state$write_1__SEL_2 =
	     f_reset_reqs$EMPTY_N && rg_state != 4'd1 ;
  assign MUX_rg_state$write_1__SEL_3 =
	     CAN_FIRE_RL_rl_io_write_req && !WILL_FIRE_RL_rl_start_reset ;
  assign MUX_rg_state$write_1__SEL_7 =
	     WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	     rg_word64_set_in_cache[1:0] == 2'd3 ;
  assign MUX_rg_state$write_1__SEL_9 =
	     WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	     dmem_not_imem_AND_NOT_soc_map_m_is_mem_addr_0__ETC___d106 ;
  assign MUX_rg_state$write_1__SEL_10 =
	     WILL_FIRE_RL_rl_reset && rg_cset_in_cache == 7'd127 ;
  always@(rg_f3 or
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d247 or
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d276 or
	  CASE_rg_addr_BITS_2_TO_0_0x0_result2361_0x4_re_ETC__q32 or
	  rg_addr or
	  word64__h5094 or
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d264 or
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d285 or
	  CASE_rg_addr_BITS_2_TO_0_0x0_result2428_0x4_re_ETC__q33)
  begin
    case (rg_f3)
      3'b0:
	  MUX_dw_output_ld_val$wset_1__VAL_2 =
	      IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d247;
      3'b001:
	  MUX_dw_output_ld_val$wset_1__VAL_2 =
	      IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d276;
      3'b010:
	  MUX_dw_output_ld_val$wset_1__VAL_2 =
	      CASE_rg_addr_BITS_2_TO_0_0x0_result2361_0x4_re_ETC__q32;
      3'b011:
	  MUX_dw_output_ld_val$wset_1__VAL_2 =
	      (rg_addr[2:0] == 3'h0) ? word64__h5094 : 64'd0;
      3'b100:
	  MUX_dw_output_ld_val$wset_1__VAL_2 =
	      IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d264;
      3'b101:
	  MUX_dw_output_ld_val$wset_1__VAL_2 =
	      IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d285;
      3'b110:
	  MUX_dw_output_ld_val$wset_1__VAL_2 =
	      CASE_rg_addr_BITS_2_TO_0_0x0_result2428_0x4_re_ETC__q33;
      3'd7: MUX_dw_output_ld_val$wset_1__VAL_2 = 64'd0;
    endcase
  end
  assign MUX_f_fabric_write_reqs$enq_1__VAL_1 =
	     { rg_f3, rg_addr, rg_st_amo_val } ;
  assign MUX_f_fabric_write_reqs$enq_1__VAL_2 =
	     { rg_f3, rg_pa, rg_st_amo_val } ;
  assign MUX_master_xactor_f_rd_addr$enq_1__VAL_1 =
	     { 4'd0, cline_fabric_addr__h14584, 29'd7143424 } ;
  assign MUX_master_xactor_f_rd_addr$enq_1__VAL_2 =
	     { 4'd0, fabric_addr__h17243, 8'd0, value__h17372, 18'd65536 } ;
  assign MUX_ram_state_and_ctag_cset$a_put_3__VAL_1 = { 3'd4, rg_pa[31:12] } ;
  assign MUX_ram_word64_set$b_put_2__VAL_2 = rg_word64_set_in_cache + 9'd1 ;
  assign MUX_ram_word64_set$b_put_2__VAL_4 = { rg_addr[11:5], 2'd0 } ;
  assign MUX_rg_cset_in_cache$write_1__VAL_1 = rg_cset_in_cache + 7'd1 ;
  assign MUX_rg_exc_code$write_1__VAL_1 = req_op ? 4'd6 : 4'd4 ;
  assign MUX_rg_state$write_1__VAL_1 =
	     NOT_req_f3_BITS_1_TO_0_18_EQ_0b0_19_20_AND_NOT_ETC___d539 ?
	       4'd4 :
	       4'd3 ;
  assign MUX_rg_state$write_1__VAL_4 =
	     (master_xactor_f_rd_data$D_OUT[2:1] == 2'b0) ? 4'd14 : 4'd4 ;
  assign MUX_rg_state$write_1__VAL_7 =
	     (master_xactor_f_rd_data$D_OUT[2:1] != 2'b0 ||
	      rg_error_during_refill) ?
	       4'd4 :
	       4'd10 ;
  assign MUX_rg_state$write_1__VAL_9 =
	     (dmem_not_imem && !soc_map$m_is_mem_addr) ?
	       4'd12 :
	       (rg_op ? 4'd11 : 4'd8) ;

  // inlined wires
  assign dw_valid$whas =
	     WILL_FIRE_RL_rl_io_read_rsp &&
	     master_xactor_f_rd_data$D_OUT[2:1] == 2'b0 ||
	     WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	     NOT_dmem_not_imem_10_OR_soc_map_m_is_mem_addr__ETC___d190 ||
	     WILL_FIRE_RL_rl_drive_exception_rsp ||
	     WILL_FIRE_RL_rl_maintain_io_read_rsp ||
	     WILL_FIRE_RL_rl_ST_AMO_response ;
  assign ctr_wr_rsps_pending_crg$port0__write_1 =
	     ctr_wr_rsps_pending_crg + 4'd1 ;
  assign ctr_wr_rsps_pending_crg$port1__write_1 = b__h14485 - 4'd1 ;
  assign ctr_wr_rsps_pending_crg$port2__read =
	     CAN_FIRE_RL_rl_discard_write_rsp ?
	       ctr_wr_rsps_pending_crg$port1__write_1 :
	       b__h14485 ;
  assign ctr_wr_rsps_pending_crg$EN_port2__write =
	     WILL_FIRE_RL_rl_start_reset && !f_reset_reqs$D_OUT ;
  assign ctr_wr_rsps_pending_crg$port3__read =
	     ctr_wr_rsps_pending_crg$EN_port2__write ?
	       4'd0 :
	       ctr_wr_rsps_pending_crg$port2__read ;

  // register cfg_verbosity
  assign cfg_verbosity$D_IN = set_verbosity_verbosity ;
  assign cfg_verbosity$EN = EN_set_verbosity ;

  // register ctr_wr_rsps_pending_crg
  assign ctr_wr_rsps_pending_crg$D_IN = ctr_wr_rsps_pending_crg$port3__read ;
  assign ctr_wr_rsps_pending_crg$EN = 1'b1 ;

  // register rg_addr
  assign rg_addr$D_IN = req_addr ;
  assign rg_addr$EN = EN_req ;

   wire [6:0] MUX_rg_cset_in_cache$write_1__VAL_1_any_val;
  
  // register rg_cset_in_cache
  assign rg_cset_in_cache$D_IN =
	     WILL_FIRE_RL_rl_reset ?
	       MUX_rg_cset_in_cache$write_1__VAL_1_any_val : // MUX_rg_cset_in_cache$write_1__VAL_1 :
	       7'd0 ;
  assign rg_cset_in_cache$EN =
	     WILL_FIRE_RL_rl_reset || WILL_FIRE_RL_rl_start_reset ;

  // register rg_error_during_refill
  assign rg_error_during_refill$D_IN =
	     MUX_rg_error_during_refill$write_1__SEL_1 ;
  assign rg_error_during_refill$EN =
	     WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	     master_xactor_f_rd_data$D_OUT[2:1] != 2'b0 ||
	     WILL_FIRE_RL_rl_start_cache_refill ;

  // register rg_exc_code
  always@(MUX_rg_exc_code$write_1__SEL_1 or
	  MUX_rg_exc_code$write_1__VAL_1 or
	  MUX_rg_exc_code$write_1__SEL_2 or
	  MUX_rg_error_during_refill$write_1__SEL_1 or access_exc_code__h2256)
  case (1'b1)
    MUX_rg_exc_code$write_1__SEL_1:
	rg_exc_code$D_IN = MUX_rg_exc_code$write_1__VAL_1;
    MUX_rg_exc_code$write_1__SEL_2: rg_exc_code$D_IN = 4'd5;
    MUX_rg_error_during_refill$write_1__SEL_1:
	rg_exc_code$D_IN = access_exc_code__h2256;
    default: rg_exc_code$D_IN = 4'b1010 /* unspecified value */ ;
  endcase
  assign rg_exc_code$EN =
	     WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	     master_xactor_f_rd_data$D_OUT[2:1] != 2'b0 ||
	     WILL_FIRE_RL_rl_io_read_rsp &&
	     master_xactor_f_rd_data$D_OUT[2:1] != 2'b0 ||
	     EN_req &&
	     NOT_req_f3_BITS_1_TO_0_18_EQ_0b0_19_20_AND_NOT_ETC___d539 ;

  // register rg_f3
  assign rg_f3$D_IN = req_f3 ;
  assign rg_f3$EN = EN_req ;

  // register rg_ld_val
  assign rg_ld_val$D_IN = ld_val__h17594 ;
  assign rg_ld_val$EN = WILL_FIRE_RL_rl_io_read_rsp ;

  // register rg_lower_word32
  assign rg_lower_word32$D_IN = 32'h0 ;
  assign rg_lower_word32$EN = 1'b0 ;

  // register rg_lower_word32_full
  assign rg_lower_word32_full$D_IN = 1'd0 ;
  assign rg_lower_word32_full$EN =
	     WILL_FIRE_RL_rl_start_cache_refill ||
	     WILL_FIRE_RL_rl_start_reset ;

  // register rg_op
  assign rg_op$D_IN = req_op ;
  assign rg_op$EN = EN_req ;

  // register rg_pa
  assign rg_pa$D_IN = EN_req ? req_addr : rg_addr ;
  assign rg_pa$EN = EN_req || WILL_FIRE_RL_rl_probe_and_immed_rsp ;

  // register rg_pte_pa
  assign rg_pte_pa$D_IN = 32'h0 ;
  assign rg_pte_pa$EN = 1'b0 ;

  // register rg_st_amo_val
  assign rg_st_amo_val$D_IN = req_st_value ;
  assign rg_st_amo_val$EN = EN_req ;

  // register rg_state
  always@(EN_req or
	  MUX_rg_state$write_1__VAL_1 or
	  WILL_FIRE_RL_rl_start_reset or
	  WILL_FIRE_RL_rl_io_write_req or
	  WILL_FIRE_RL_rl_io_read_rsp or
	  MUX_rg_state$write_1__VAL_4 or
	  WILL_FIRE_RL_rl_io_read_req or
	  WILL_FIRE_RL_rl_rereq or
	  MUX_rg_state$write_1__SEL_7 or
	  MUX_rg_state$write_1__VAL_7 or
	  WILL_FIRE_RL_rl_start_cache_refill or
	  MUX_rg_state$write_1__SEL_9 or
	  MUX_rg_state$write_1__VAL_9 or MUX_rg_state$write_1__SEL_10)
  case (1'b1)
    EN_req: rg_state$D_IN = MUX_rg_state$write_1__VAL_1;
    WILL_FIRE_RL_rl_start_reset: rg_state$D_IN = 4'd1;
    WILL_FIRE_RL_rl_io_write_req: rg_state$D_IN = 4'd11;
    WILL_FIRE_RL_rl_io_read_rsp: rg_state$D_IN = MUX_rg_state$write_1__VAL_4;
    WILL_FIRE_RL_rl_io_read_req: rg_state$D_IN = 4'd13;
    WILL_FIRE_RL_rl_rereq: rg_state$D_IN = 4'd3;
    MUX_rg_state$write_1__SEL_7: rg_state$D_IN = MUX_rg_state$write_1__VAL_7;
    WILL_FIRE_RL_rl_start_cache_refill: rg_state$D_IN = 4'd9;
    MUX_rg_state$write_1__SEL_9: rg_state$D_IN = MUX_rg_state$write_1__VAL_9;
    MUX_rg_state$write_1__SEL_10: rg_state$D_IN = 4'd2;
    default: rg_state$D_IN = 4'b1010 /* unspecified value */ ;
  endcase
  assign rg_state$EN =
	     WILL_FIRE_RL_rl_reset && rg_cset_in_cache == 7'd127 ||
	     WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	     rg_word64_set_in_cache[1:0] == 2'd3 ||
	     WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	     dmem_not_imem_AND_NOT_soc_map_m_is_mem_addr_0__ETC___d106 ||
	     WILL_FIRE_RL_rl_io_read_rsp ||
	     EN_req ||
	     WILL_FIRE_RL_rl_start_reset ||
	     WILL_FIRE_RL_rl_rereq ||
	     WILL_FIRE_RL_rl_start_cache_refill ||
	     WILL_FIRE_RL_rl_io_write_req ||
	     WILL_FIRE_RL_rl_io_read_req ;

  // register rg_word64_set_in_cache
  assign rg_word64_set_in_cache$D_IN =
	     MUX_ram_word64_set$b_put_1__SEL_2 ?
	       MUX_ram_word64_set$b_put_2__VAL_2 :
	       MUX_ram_word64_set$b_put_2__VAL_4 ;
  assign rg_word64_set_in_cache$EN =
	     WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	     rg_word64_set_in_cache[1:0] != 2'd3 ||
	     WILL_FIRE_RL_rl_start_cache_refill ;

  // submodule f_fabric_write_reqs
  assign f_fabric_write_reqs$D_IN =
	     MUX_f_fabric_write_reqs$enq_1__SEL_1 ?
	       MUX_f_fabric_write_reqs$enq_1__VAL_1 :
	       MUX_f_fabric_write_reqs$enq_1__VAL_2 ;
  assign f_fabric_write_reqs$ENQ =
	     WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	     (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	     rg_op ||
	     WILL_FIRE_RL_rl_io_write_req ;
  assign f_fabric_write_reqs$DEQ = CAN_FIRE_RL_rl_fabric_send_write_req ;
  assign f_fabric_write_reqs$CLR = 1'b0 ;

  // submodule f_reset_reqs
  assign f_reset_reqs$D_IN = !EN_server_reset_request_put ;
  assign f_reset_reqs$ENQ =
	     EN_server_reset_request_put || EN_server_flush_request_put ;
  assign f_reset_reqs$DEQ =
	     WILL_FIRE_RL_rl_reset && rg_cset_in_cache == 7'd127 ;
  assign f_reset_reqs$CLR = 1'b0 ;

  // submodule f_reset_rsps
  assign f_reset_rsps$D_IN = f_reset_reqs$D_OUT ;
  assign f_reset_rsps$ENQ =
	     WILL_FIRE_RL_rl_reset && rg_cset_in_cache == 7'd127 ;
  assign f_reset_rsps$DEQ =
	     EN_server_flush_response_get || EN_server_reset_response_get ;
  assign f_reset_rsps$CLR = 1'b0 ;

  // submodule master_xactor_f_rd_addr
  assign master_xactor_f_rd_addr$D_IN =
	     WILL_FIRE_RL_rl_start_cache_refill ?
	       MUX_master_xactor_f_rd_addr$enq_1__VAL_1 :
	       MUX_master_xactor_f_rd_addr$enq_1__VAL_2 ;
  assign master_xactor_f_rd_addr$ENQ =
	     WILL_FIRE_RL_rl_start_cache_refill ||
	     WILL_FIRE_RL_rl_io_read_req ;
  assign master_xactor_f_rd_addr$DEQ =
	     master_xactor_f_rd_addr$EMPTY_N && mem_master_arready ;
  assign master_xactor_f_rd_addr$CLR =
	     WILL_FIRE_RL_rl_start_reset && !f_reset_reqs$D_OUT ;

  // submodule master_xactor_f_rd_data
  assign master_xactor_f_rd_data$D_IN =
	     { mem_master_rid,
	       mem_master_rdata,
	       mem_master_rresp,
	       mem_master_rlast } ;
  assign master_xactor_f_rd_data$ENQ =
	     mem_master_rvalid && master_xactor_f_rd_data$FULL_N ;
  assign master_xactor_f_rd_data$DEQ =
	     WILL_FIRE_RL_rl_io_read_rsp ||
	     WILL_FIRE_RL_rl_cache_refill_rsps_loop ;
  assign master_xactor_f_rd_data$CLR =
	     WILL_FIRE_RL_rl_start_reset && !f_reset_reqs$D_OUT ;

  // submodule master_xactor_f_wr_addr
  assign master_xactor_f_wr_addr$D_IN =
	     { 4'd0,
	       mem_req_wr_addr_awaddr__h2473,
	       8'd0,
	       x__h2520,
	       18'd65536 } ;
  assign master_xactor_f_wr_addr$ENQ = CAN_FIRE_RL_rl_fabric_send_write_req ;
  assign master_xactor_f_wr_addr$DEQ =
	     master_xactor_f_wr_addr$EMPTY_N && mem_master_awready ;
  assign master_xactor_f_wr_addr$CLR =
	     WILL_FIRE_RL_rl_start_reset && !f_reset_reqs$D_OUT ;

  // submodule master_xactor_f_wr_data
  assign master_xactor_f_wr_data$D_IN =
	     { mem_req_wr_data_wdata__h2699,
	       mem_req_wr_data_wstrb__h2700,
	       1'd1 } ;
  assign master_xactor_f_wr_data$ENQ = CAN_FIRE_RL_rl_fabric_send_write_req ;
  assign master_xactor_f_wr_data$DEQ =
	     master_xactor_f_wr_data$EMPTY_N && mem_master_wready ;
  assign master_xactor_f_wr_data$CLR =
	     WILL_FIRE_RL_rl_start_reset && !f_reset_reqs$D_OUT ;

  // submodule master_xactor_f_wr_resp
  assign master_xactor_f_wr_resp$D_IN = { mem_master_bid, mem_master_bresp } ;
  assign master_xactor_f_wr_resp$ENQ =
	     mem_master_bvalid && master_xactor_f_wr_resp$FULL_N ;
  assign master_xactor_f_wr_resp$DEQ = CAN_FIRE_RL_rl_discard_write_rsp ;
  assign master_xactor_f_wr_resp$CLR =
	     WILL_FIRE_RL_rl_start_reset && !f_reset_reqs$D_OUT ;

  // submodule ram_state_and_ctag_cset
  assign ram_state_and_ctag_cset$ADDRA =
	     WILL_FIRE_RL_rl_start_cache_refill ?
	       rg_addr[11:5] :
	       rg_cset_in_cache ;
  assign ram_state_and_ctag_cset$ADDRB =
	     MUX_ram_state_and_ctag_cset$b_put_1__SEL_1 ?
	       req_addr[11:5] :
	       rg_addr[11:5] ;
  assign ram_state_and_ctag_cset$DIA =
	     WILL_FIRE_RL_rl_start_cache_refill ?
	       MUX_ram_state_and_ctag_cset$a_put_3__VAL_1 :
	       23'd2796202 ;
  assign ram_state_and_ctag_cset$DIB =
	     MUX_ram_state_and_ctag_cset$b_put_1__SEL_1 ?
	       23'b01010101010101010101010 /* unspecified value */  :
	       23'b01010101010101010101010 /* unspecified value */  ;
  assign ram_state_and_ctag_cset$WEA = 1'd1 ;
  assign ram_state_and_ctag_cset$WEB = 1'd0 ;
  assign ram_state_and_ctag_cset$ENA =
	     WILL_FIRE_RL_rl_start_cache_refill || WILL_FIRE_RL_rl_reset ;
  assign ram_state_and_ctag_cset$ENB =
	     EN_req &&
	     req_f3_BITS_1_TO_0_18_EQ_0b0_19_OR_req_f3_BITS_ETC___d548 ||
	     WILL_FIRE_RL_rl_rereq ;

  // submodule ram_word64_set
  assign ram_word64_set$ADDRA =
	     MUX_ram_word64_set$a_put_1__SEL_1 ?
	       rg_word64_set_in_cache :
	       rg_addr[11:3] ;
  always@(MUX_ram_state_and_ctag_cset$b_put_1__SEL_1 or
	  req_addr or
	  MUX_ram_word64_set$b_put_1__SEL_2 or
	  MUX_ram_word64_set$b_put_2__VAL_2 or
	  WILL_FIRE_RL_rl_rereq or
	  rg_addr or
	  WILL_FIRE_RL_rl_start_cache_refill or
	  MUX_ram_word64_set$b_put_2__VAL_4)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_ram_state_and_ctag_cset$b_put_1__SEL_1:
	  ram_word64_set$ADDRB = req_addr[11:3];
      MUX_ram_word64_set$b_put_1__SEL_2:
	  ram_word64_set$ADDRB = MUX_ram_word64_set$b_put_2__VAL_2;
      WILL_FIRE_RL_rl_rereq: ram_word64_set$ADDRB = rg_addr[11:3];
      WILL_FIRE_RL_rl_start_cache_refill:
	  ram_word64_set$ADDRB = MUX_ram_word64_set$b_put_2__VAL_4;
      default: ram_word64_set$ADDRB = 9'b010101010 /* unspecified value */ ;
    endcase
  end
  assign ram_word64_set$DIA =
	     MUX_ram_word64_set$a_put_1__SEL_1 ?
	       master_xactor_f_rd_data$D_OUT[66:3] :
	       IF_rg_f3_16_EQ_0b0_17_THEN_IF_rg_addr_6_BITS_2_ETC___d178 ;
  always@(MUX_ram_state_and_ctag_cset$b_put_1__SEL_1 or
	  MUX_ram_word64_set$b_put_1__SEL_2 or
	  WILL_FIRE_RL_rl_rereq or WILL_FIRE_RL_rl_start_cache_refill)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_ram_state_and_ctag_cset$b_put_1__SEL_1:
	  ram_word64_set$DIB = 64'hAAAAAAAAAAAAAAAA /* unspecified value */ ;
      MUX_ram_word64_set$b_put_1__SEL_2:
	  ram_word64_set$DIB = 64'hAAAAAAAAAAAAAAAA /* unspecified value */ ;
      WILL_FIRE_RL_rl_rereq:
	  ram_word64_set$DIB = 64'hAAAAAAAAAAAAAAAA /* unspecified value */ ;
      WILL_FIRE_RL_rl_start_cache_refill:
	  ram_word64_set$DIB = 64'hAAAAAAAAAAAAAAAA /* unspecified value */ ;
      default: ram_word64_set$DIB =
		   64'hAAAAAAAAAAAAAAAA /* unspecified value */ ;
    endcase
  end
  assign ram_word64_set$WEA = 1'd1 ;
  assign ram_word64_set$WEB = 1'd0 ;
  assign ram_word64_set$ENA =
	     WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	     master_xactor_f_rd_data$D_OUT[2:1] == 2'b0 ||
	     WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	     NOT_dmem_not_imem_10_OR_soc_map_m_is_mem_addr__ETC___d114 ;
  assign ram_word64_set$ENB =
	     EN_req &&
	     req_f3_BITS_1_TO_0_18_EQ_0b0_19_OR_req_f3_BITS_ETC___d548 ||
	     WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	     rg_word64_set_in_cache[1:0] != 2'd3 ||
	     WILL_FIRE_RL_rl_rereq ||
	     WILL_FIRE_RL_rl_start_cache_refill ;

  // submodule soc_map
  assign soc_map$m_is_IO_addr_addr = 64'h0 ;
  assign soc_map$m_is_mem_addr_addr = { 32'd0, rg_addr } ;
  assign soc_map$m_is_near_mem_IO_addr_addr = 64'h0 ;

  // remaining internal signals
  assign NOT_cfg_verbosity_read__0_ULE_1_1___d42 = cfg_verbosity > 4'd1 ;
  assign NOT_cfg_verbosity_read__0_ULE_2_30___d331 = cfg_verbosity > 4'd2 ;
  assign NOT_dmem_not_imem_10_OR_soc_map_m_is_mem_addr__ETC___d114 =
	     (!dmem_not_imem || soc_map$m_is_mem_addr) && rg_op &&
	     ram_state_and_ctag_cset$DOB[22] &&
	     ram_state_and_ctag_cset_b_read__5_BITS_21_TO_0_ETC___d102 ;
  assign NOT_dmem_not_imem_10_OR_soc_map_m_is_mem_addr__ETC___d190 =
	     (!dmem_not_imem || soc_map$m_is_mem_addr) && !rg_op &&
	     ram_state_and_ctag_cset$DOB[22] &&
	     ram_state_and_ctag_cset_b_read__5_BITS_21_TO_0_ETC___d102 ;
  assign NOT_req_f3_BITS_1_TO_0_18_EQ_0b0_19_20_AND_NOT_ETC___d539 =
	     req_f3[1:0] != 2'b0 && (req_f3[1:0] != 2'b01 || req_addr[0]) &&
	     (req_f3[1:0] != 2'b10 || req_addr[1:0] != 2'b0) &&
	     (req_f3[1:0] != 2'b11 || req_addr[2:0] != 3'b0) ;
  assign NOT_rg_op_1_2_AND_ram_state_and_ctag_cset_b_re_ETC___d305 =
	     !rg_op && ram_state_and_ctag_cset$DOB[22] &&
	     ram_state_and_ctag_cset_b_read__5_BITS_21_TO_0_ETC___d102 &&
	     NOT_cfg_verbosity_read__0_ULE_1_1___d42 ;
  assign _theResult___snd_fst__h2707 =
	     f_fabric_write_reqs$D_OUT[63:0] << shift_bits__h2487 ;
  assign access_exc_code__h2256 =
	     dmem_not_imem ? (rg_op ? 4'd7 : 4'd5) : 4'd1 ;
  assign b__h14485 =
	     CAN_FIRE_RL_rl_fabric_send_write_req ?
	       ctr_wr_rsps_pending_crg$port0__write_1 :
	       ctr_wr_rsps_pending_crg ;
  assign cline_addr__h14583 = { rg_pa[31:5], 5'd0 } ;
  assign cline_fabric_addr__h14584 = { 32'd0, cline_addr__h14583 } ;
  assign dmem_not_imem_AND_NOT_soc_map_m_is_mem_addr_0__ETC___d106 =
	     dmem_not_imem && !soc_map$m_is_mem_addr || rg_op ||
	     !ram_state_and_ctag_cset$DOB[22] ||
	     !ram_state_and_ctag_cset_b_read__5_BITS_21_TO_0_ETC___d102 ;
  assign fabric_addr__h17243 = { 32'd0, rg_pa } ;
  assign master_xactor_f_rd_dataD_OUT_BITS_10_TO_3__q1 =
	     master_xactor_f_rd_data$D_OUT[10:3] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_18_TO_11__q4 =
	     master_xactor_f_rd_data$D_OUT[18:11] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_18_TO_3__q2 =
	     master_xactor_f_rd_data$D_OUT[18:3] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_26_TO_19__q5 =
	     master_xactor_f_rd_data$D_OUT[26:19] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_34_TO_19__q6 =
	     master_xactor_f_rd_data$D_OUT[34:19] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_34_TO_27__q7 =
	     master_xactor_f_rd_data$D_OUT[34:27] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_34_TO_3__q3 =
	     master_xactor_f_rd_data$D_OUT[34:3] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_42_TO_35__q8 =
	     master_xactor_f_rd_data$D_OUT[42:35] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_50_TO_35__q9 =
	     master_xactor_f_rd_data$D_OUT[50:35] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_50_TO_43__q11 =
	     master_xactor_f_rd_data$D_OUT[50:43] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_58_TO_51__q12 =
	     master_xactor_f_rd_data$D_OUT[58:51] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_66_TO_35__q10 =
	     master_xactor_f_rd_data$D_OUT[66:35] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_66_TO_51__q13 =
	     master_xactor_f_rd_data$D_OUT[66:51] ;
  assign master_xactor_f_rd_dataD_OUT_BITS_66_TO_59__q14 =
	     master_xactor_f_rd_data$D_OUT[66:59] ;
  assign mem_req_wr_addr_awaddr__h2473 =
	     { 32'd0, f_fabric_write_reqs$D_OUT[95:64] } ;
  assign pa_ctag__h4952 = { 2'd0, rg_addr[31:12] } ;
  assign ram_state_and_ctag_cset_b_read__5_BITS_21_TO_0_ETC___d102 =
	     ram_state_and_ctag_cset$DOB[21:0] == pa_ctag__h4952 ;
  assign req_f3_BITS_1_TO_0_18_EQ_0b0_19_OR_req_f3_BITS_ETC___d548 =
	     req_f3[1:0] == 2'b0 || req_f3[1:0] == 2'b01 && !req_addr[0] ||
	     req_f3[1:0] == 2'b10 && req_addr[1:0] == 2'b0 ||
	     req_f3[1:0] == 2'b11 && req_addr[2:0] == 3'b0 ;
  assign result__h11657 =
	     { {56{word64094_BITS_15_TO_8__q18[7]}},
	       word64094_BITS_15_TO_8__q18 } ;
  assign result__h11685 =
	     { {56{word64094_BITS_23_TO_16__q19[7]}},
	       word64094_BITS_23_TO_16__q19 } ;
  assign result__h11713 =
	     { {56{word64094_BITS_31_TO_24__q21[7]}},
	       word64094_BITS_31_TO_24__q21 } ;
  assign result__h11741 =
	     { {56{word64094_BITS_39_TO_32__q22[7]}},
	       word64094_BITS_39_TO_32__q22 } ;
  assign result__h11769 =
	     { {56{word64094_BITS_47_TO_40__q25[7]}},
	       word64094_BITS_47_TO_40__q25 } ;
  assign result__h11797 =
	     { {56{word64094_BITS_55_TO_48__q26[7]}},
	       word64094_BITS_55_TO_48__q26 } ;
  assign result__h11825 =
	     { {56{word64094_BITS_63_TO_56__q28[7]}},
	       word64094_BITS_63_TO_56__q28 } ;
  assign result__h11870 = { 56'd0, word64__h5094[7:0] } ;
  assign result__h11898 = { 56'd0, word64__h5094[15:8] } ;
  assign result__h11926 = { 56'd0, word64__h5094[23:16] } ;
  assign result__h11954 = { 56'd0, word64__h5094[31:24] } ;
  assign result__h11982 = { 56'd0, word64__h5094[39:32] } ;
  assign result__h12010 = { 56'd0, word64__h5094[47:40] } ;
  assign result__h12038 = { 56'd0, word64__h5094[55:48] } ;
  assign result__h12066 = { 56'd0, word64__h5094[63:56] } ;
  assign result__h12111 =
	     { {48{word64094_BITS_15_TO_0__q16[15]}},
	       word64094_BITS_15_TO_0__q16 } ;
  assign result__h12139 =
	     { {48{word64094_BITS_31_TO_16__q20[15]}},
	       word64094_BITS_31_TO_16__q20 } ;
  assign result__h12167 =
	     { {48{word64094_BITS_47_TO_32__q23[15]}},
	       word64094_BITS_47_TO_32__q23 } ;
  assign result__h12195 =
	     { {48{word64094_BITS_63_TO_48__q27[15]}},
	       word64094_BITS_63_TO_48__q27 } ;
  assign result__h12236 = { 48'd0, word64__h5094[15:0] } ;
  assign result__h12264 = { 48'd0, word64__h5094[31:16] } ;
  assign result__h12292 = { 48'd0, word64__h5094[47:32] } ;
  assign result__h12320 = { 48'd0, word64__h5094[63:48] } ;
  assign result__h12361 =
	     { {32{word64094_BITS_31_TO_0__q17[31]}},
	       word64094_BITS_31_TO_0__q17 } ;
  assign result__h12389 =
	     { {32{word64094_BITS_63_TO_32__q24[31]}},
	       word64094_BITS_63_TO_32__q24 } ;
  assign result__h12428 = { 32'd0, word64__h5094[31:0] } ;
  assign result__h12456 = { 32'd0, word64__h5094[63:32] } ;
  assign result__h17654 =
	     { {56{master_xactor_f_rd_dataD_OUT_BITS_10_TO_3__q1[7]}},
	       master_xactor_f_rd_dataD_OUT_BITS_10_TO_3__q1 } ;
  assign result__h17684 =
	     { {56{master_xactor_f_rd_dataD_OUT_BITS_18_TO_11__q4[7]}},
	       master_xactor_f_rd_dataD_OUT_BITS_18_TO_11__q4 } ;
  assign result__h17711 =
	     { {56{master_xactor_f_rd_dataD_OUT_BITS_26_TO_19__q5[7]}},
	       master_xactor_f_rd_dataD_OUT_BITS_26_TO_19__q5 } ;
  assign result__h17738 =
	     { {56{master_xactor_f_rd_dataD_OUT_BITS_34_TO_27__q7[7]}},
	       master_xactor_f_rd_dataD_OUT_BITS_34_TO_27__q7 } ;
  assign result__h17765 =
	     { {56{master_xactor_f_rd_dataD_OUT_BITS_42_TO_35__q8[7]}},
	       master_xactor_f_rd_dataD_OUT_BITS_42_TO_35__q8 } ;
  assign result__h17792 =
	     { {56{master_xactor_f_rd_dataD_OUT_BITS_50_TO_43__q11[7]}},
	       master_xactor_f_rd_dataD_OUT_BITS_50_TO_43__q11 } ;
  assign result__h17819 =
	     { {56{master_xactor_f_rd_dataD_OUT_BITS_58_TO_51__q12[7]}},
	       master_xactor_f_rd_dataD_OUT_BITS_58_TO_51__q12 } ;
  assign result__h17846 =
	     { {56{master_xactor_f_rd_dataD_OUT_BITS_66_TO_59__q14[7]}},
	       master_xactor_f_rd_dataD_OUT_BITS_66_TO_59__q14 } ;
  assign result__h17890 = { 56'd0, master_xactor_f_rd_data$D_OUT[10:3] } ;
  assign result__h17917 = { 56'd0, master_xactor_f_rd_data$D_OUT[18:11] } ;
  assign result__h17944 = { 56'd0, master_xactor_f_rd_data$D_OUT[26:19] } ;
  assign result__h17971 = { 56'd0, master_xactor_f_rd_data$D_OUT[34:27] } ;
  assign result__h17998 = { 56'd0, master_xactor_f_rd_data$D_OUT[42:35] } ;
  assign result__h18025 = { 56'd0, master_xactor_f_rd_data$D_OUT[50:43] } ;
  assign result__h18052 = { 56'd0, master_xactor_f_rd_data$D_OUT[58:51] } ;
  assign result__h18079 = { 56'd0, master_xactor_f_rd_data$D_OUT[66:59] } ;
  assign result__h18123 =
	     { {48{master_xactor_f_rd_dataD_OUT_BITS_18_TO_3__q2[15]}},
	       master_xactor_f_rd_dataD_OUT_BITS_18_TO_3__q2 } ;
  assign result__h18150 =
	     { {48{master_xactor_f_rd_dataD_OUT_BITS_34_TO_19__q6[15]}},
	       master_xactor_f_rd_dataD_OUT_BITS_34_TO_19__q6 } ;
  assign result__h18177 =
	     { {48{master_xactor_f_rd_dataD_OUT_BITS_50_TO_35__q9[15]}},
	       master_xactor_f_rd_dataD_OUT_BITS_50_TO_35__q9 } ;
  assign result__h18204 =
	     { {48{master_xactor_f_rd_dataD_OUT_BITS_66_TO_51__q13[15]}},
	       master_xactor_f_rd_dataD_OUT_BITS_66_TO_51__q13 } ;
  assign result__h18244 = { 48'd0, master_xactor_f_rd_data$D_OUT[18:3] } ;
  assign result__h18271 = { 48'd0, master_xactor_f_rd_data$D_OUT[34:19] } ;
  assign result__h18298 = { 48'd0, master_xactor_f_rd_data$D_OUT[50:35] } ;
  assign result__h18325 = { 48'd0, master_xactor_f_rd_data$D_OUT[66:51] } ;
  assign result__h18365 =
	     { {32{master_xactor_f_rd_dataD_OUT_BITS_34_TO_3__q3[31]}},
	       master_xactor_f_rd_dataD_OUT_BITS_34_TO_3__q3 } ;
  assign result__h18392 =
	     { {32{master_xactor_f_rd_dataD_OUT_BITS_66_TO_35__q10[31]}},
	       master_xactor_f_rd_dataD_OUT_BITS_66_TO_35__q10 } ;
  assign result__h18430 = { 32'd0, master_xactor_f_rd_data$D_OUT[34:3] } ;
  assign result__h18457 = { 32'd0, master_xactor_f_rd_data$D_OUT[66:35] } ;
  assign result__h5301 =
	     { {56{word64094_BITS_7_TO_0__q15[7]}},
	       word64094_BITS_7_TO_0__q15 } ;
  assign rg_op_1_AND_ram_state_and_ctag_cset_b_read__5__ETC___d180 =
	     rg_op && ram_state_and_ctag_cset$DOB[22] &&
	     ram_state_and_ctag_cset_b_read__5_BITS_21_TO_0_ETC___d102 &&
	     NOT_cfg_verbosity_read__0_ULE_1_1___d42 ;
  assign shift_bits__h2487 = { f_fabric_write_reqs$D_OUT[66:64], 3'b0 } ;
  assign strobe64__h2637 = 8'b00000001 << f_fabric_write_reqs$D_OUT[66:64] ;
  assign strobe64__h2639 = 8'b00000011 << f_fabric_write_reqs$D_OUT[66:64] ;
  assign strobe64__h2641 = 8'b00001111 << f_fabric_write_reqs$D_OUT[66:64] ;
  assign word64094_BITS_15_TO_0__q16 = word64__h5094[15:0] ;
  assign word64094_BITS_15_TO_8__q18 = word64__h5094[15:8] ;
  assign word64094_BITS_23_TO_16__q19 = word64__h5094[23:16] ;
  assign word64094_BITS_31_TO_0__q17 = word64__h5094[31:0] ;
  assign word64094_BITS_31_TO_16__q20 = word64__h5094[31:16] ;
  assign word64094_BITS_31_TO_24__q21 = word64__h5094[31:24] ;
  assign word64094_BITS_39_TO_32__q22 = word64__h5094[39:32] ;
  assign word64094_BITS_47_TO_32__q23 = word64__h5094[47:32] ;
  assign word64094_BITS_47_TO_40__q25 = word64__h5094[47:40] ;
  assign word64094_BITS_55_TO_48__q26 = word64__h5094[55:48] ;
  assign word64094_BITS_63_TO_32__q24 = word64__h5094[63:32] ;
  assign word64094_BITS_63_TO_48__q27 = word64__h5094[63:48] ;
  assign word64094_BITS_63_TO_56__q28 = word64__h5094[63:56] ;
  assign word64094_BITS_7_TO_0__q15 = word64__h5094[7:0] ;
  assign word64__h5094 = ram_word64_set$DOB & y__h5337 ;
  assign y__h5337 =
	     {64{ram_state_and_ctag_cset$DOB[22] &&
		 ram_state_and_ctag_cset_b_read__5_BITS_21_TO_0_ETC___d102}} ;
  always@(f_fabric_write_reqs$D_OUT)
  begin
    case (f_fabric_write_reqs$D_OUT[97:96])
      2'b0: x__h2520 = 3'b0;
      2'b01: x__h2520 = 3'b001;
      2'b10: x__h2520 = 3'b010;
      2'b11: x__h2520 = 3'b011;
    endcase
  end
  always@(rg_f3)
  begin
    case (rg_f3[1:0])
      2'b0: value__h17372 = 3'b0;
      2'b01: value__h17372 = 3'b001;
      2'b10: value__h17372 = 3'b010;
      2'd3: value__h17372 = 3'b011;
    endcase
  end
  always@(f_fabric_write_reqs$D_OUT or
	  strobe64__h2637 or strobe64__h2639 or strobe64__h2641)
  begin
    case (f_fabric_write_reqs$D_OUT[97:96])
      2'b0: mem_req_wr_data_wstrb__h2700 = strobe64__h2637;
      2'b01: mem_req_wr_data_wstrb__h2700 = strobe64__h2639;
      2'b10: mem_req_wr_data_wstrb__h2700 = strobe64__h2641;
      2'b11: mem_req_wr_data_wstrb__h2700 = 8'b11111111;
    endcase
  end
  always@(f_fabric_write_reqs$D_OUT or _theResult___snd_fst__h2707)
  begin
    case (f_fabric_write_reqs$D_OUT[97:96])
      2'b0, 2'b01, 2'b10:
	  mem_req_wr_data_wdata__h2699 = _theResult___snd_fst__h2707;
      2'd3: mem_req_wr_data_wdata__h2699 = f_fabric_write_reqs$D_OUT[63:0];
    endcase
  end
  always@(rg_addr or
	  result__h12111 or
	  result__h12139 or result__h12167 or result__h12195)
  begin
    case (rg_addr[2:0])
      3'h0:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d276 =
	      result__h12111;
      3'h2:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d276 =
	      result__h12139;
      3'h4:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d276 =
	      result__h12167;
      3'h6:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d276 =
	      result__h12195;
      default: IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d276 =
		   64'd0;
    endcase
  end
  always@(rg_addr or ram_word64_set$DOB or rg_st_amo_val)
  begin
    case (rg_addr[2:0])
      3'h0:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d167 =
	      { ram_word64_set$DOB[63:16], rg_st_amo_val[15:0] };
      3'h2:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d167 =
	      { ram_word64_set$DOB[63:32],
		rg_st_amo_val[15:0],
		ram_word64_set$DOB[15:0] };
      3'h4:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d167 =
	      { ram_word64_set$DOB[63:48],
		rg_st_amo_val[15:0],
		ram_word64_set$DOB[31:0] };
      3'h6:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d167 =
	      { rg_st_amo_val[15:0], ram_word64_set$DOB[47:0] };
      default: IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d167 =
		   ram_word64_set$DOB;
    endcase
  end
  always@(rg_addr or
	  result__h5301 or
	  result__h11657 or
	  result__h11685 or
	  result__h11713 or
	  result__h11741 or
	  result__h11769 or result__h11797 or result__h11825)
  begin
    case (rg_addr[2:0])
      3'h0:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d247 =
	      result__h5301;
      3'h1:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d247 =
	      result__h11657;
      3'h2:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d247 =
	      result__h11685;
      3'h3:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d247 =
	      result__h11713;
      3'h4:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d247 =
	      result__h11741;
      3'h5:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d247 =
	      result__h11769;
      3'h6:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d247 =
	      result__h11797;
      3'h7:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d247 =
	      result__h11825;
    endcase
  end
  always@(rg_addr or ram_word64_set$DOB or rg_st_amo_val)
  begin
    case (rg_addr[2:0])
      3'h0:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d157 =
	      { ram_word64_set$DOB[63:8], rg_st_amo_val[7:0] };
      3'h1:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d157 =
	      { ram_word64_set$DOB[63:16],
		rg_st_amo_val[7:0],
		ram_word64_set$DOB[7:0] };
      3'h2:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d157 =
	      { ram_word64_set$DOB[63:24],
		rg_st_amo_val[7:0],
		ram_word64_set$DOB[15:0] };
      3'h3:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d157 =
	      { ram_word64_set$DOB[63:32],
		rg_st_amo_val[7:0],
		ram_word64_set$DOB[23:0] };
      3'h4:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d157 =
	      { ram_word64_set$DOB[63:40],
		rg_st_amo_val[7:0],
		ram_word64_set$DOB[31:0] };
      3'h5:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d157 =
	      { ram_word64_set$DOB[63:48],
		rg_st_amo_val[7:0],
		ram_word64_set$DOB[39:0] };
      3'h6:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d157 =
	      { ram_word64_set$DOB[63:56],
		rg_st_amo_val[7:0],
		ram_word64_set$DOB[47:0] };
      3'h7:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d157 =
	      { rg_st_amo_val[7:0], ram_word64_set$DOB[55:0] };
    endcase
  end
  always@(rg_addr or
	  result__h18244 or
	  result__h18271 or result__h18298 or result__h18325)
  begin
    case (rg_addr[2:0])
      3'h0:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d447 =
	      result__h18244;
      3'h2:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d447 =
	      result__h18271;
      3'h4:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d447 =
	      result__h18298;
      3'h6:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d447 =
	      result__h18325;
      default: IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d447 =
		   64'd0;
    endcase
  end
  always@(rg_addr or
	  result__h12236 or
	  result__h12264 or result__h12292 or result__h12320)
  begin
    case (rg_addr[2:0])
      3'h0:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d285 =
	      result__h12236;
      3'h2:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d285 =
	      result__h12264;
      3'h4:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d285 =
	      result__h12292;
      3'h6:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d285 =
	      result__h12320;
      default: IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d285 =
		   64'd0;
    endcase
  end
  always@(rg_addr or
	  result__h18123 or
	  result__h18150 or result__h18177 or result__h18204)
  begin
    case (rg_addr[2:0])
      3'h0:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d439 =
	      result__h18123;
      3'h2:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d439 =
	      result__h18150;
      3'h4:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d439 =
	      result__h18177;
      3'h6:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d439 =
	      result__h18204;
      default: IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d439 =
		   64'd0;
    endcase
  end
  always@(rg_addr or
	  result__h17890 or
	  result__h17917 or
	  result__h17944 or
	  result__h17971 or
	  result__h17998 or
	  result__h18025 or result__h18052 or result__h18079)
  begin
    case (rg_addr[2:0])
      3'h0:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d427 =
	      result__h17890;
      3'h1:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d427 =
	      result__h17917;
      3'h2:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d427 =
	      result__h17944;
      3'h3:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d427 =
	      result__h17971;
      3'h4:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d427 =
	      result__h17998;
      3'h5:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d427 =
	      result__h18025;
      3'h6:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d427 =
	      result__h18052;
      3'h7:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d427 =
	      result__h18079;
    endcase
  end
  always@(rg_addr or
	  result__h11870 or
	  result__h11898 or
	  result__h11926 or
	  result__h11954 or
	  result__h11982 or
	  result__h12010 or result__h12038 or result__h12066)
  begin
    case (rg_addr[2:0])
      3'h0:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d264 =
	      result__h11870;
      3'h1:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d264 =
	      result__h11898;
      3'h2:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d264 =
	      result__h11926;
      3'h3:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d264 =
	      result__h11954;
      3'h4:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d264 =
	      result__h11982;
      3'h5:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d264 =
	      result__h12010;
      3'h6:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d264 =
	      result__h12038;
      3'h7:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d264 =
	      result__h12066;
    endcase
  end
  always@(rg_addr or
	  result__h17654 or
	  result__h17684 or
	  result__h17711 or
	  result__h17738 or
	  result__h17765 or
	  result__h17792 or result__h17819 or result__h17846)
  begin
    case (rg_addr[2:0])
      3'h0:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d411 =
	      result__h17654;
      3'h1:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d411 =
	      result__h17684;
      3'h2:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d411 =
	      result__h17711;
      3'h3:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d411 =
	      result__h17738;
      3'h4:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d411 =
	      result__h17765;
      3'h5:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d411 =
	      result__h17792;
      3'h6:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d411 =
	      result__h17819;
      3'h7:
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d411 =
	      result__h17846;
    endcase
  end
  always@(rg_addr or result__h18365 or result__h18392)
  begin
    case (rg_addr[2:0])
      3'h0:
	  CASE_rg_addr_BITS_2_TO_0_0x0_result8365_0x4_re_ETC__q29 =
	      result__h18365;
      3'h4:
	  CASE_rg_addr_BITS_2_TO_0_0x0_result8365_0x4_re_ETC__q29 =
	      result__h18392;
      default: CASE_rg_addr_BITS_2_TO_0_0x0_result8365_0x4_re_ETC__q29 =
		   64'd0;
    endcase
  end
  always@(rg_addr or result__h18430 or result__h18457)
  begin
    case (rg_addr[2:0])
      3'h0:
	  CASE_rg_addr_BITS_2_TO_0_0x0_result8430_0x4_re_ETC__q30 =
	      result__h18430;
      3'h4:
	  CASE_rg_addr_BITS_2_TO_0_0x0_result8430_0x4_re_ETC__q30 =
	      result__h18457;
      default: CASE_rg_addr_BITS_2_TO_0_0x0_result8430_0x4_re_ETC__q30 =
		   64'd0;
    endcase
  end
  always@(rg_f3 or
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d411 or
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d439 or
	  CASE_rg_addr_BITS_2_TO_0_0x0_result8365_0x4_re_ETC__q29 or
	  rg_addr or
	  master_xactor_f_rd_data$D_OUT or
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d427 or
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d447 or
	  CASE_rg_addr_BITS_2_TO_0_0x0_result8430_0x4_re_ETC__q30)
  begin
    case (rg_f3)
      3'b0:
	  ld_val__h17594 =
	      IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d411;
      3'b001:
	  ld_val__h17594 =
	      IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_SEXT_ETC___d439;
      3'b010:
	  ld_val__h17594 =
	      CASE_rg_addr_BITS_2_TO_0_0x0_result8365_0x4_re_ETC__q29;
      3'b011:
	  ld_val__h17594 =
	      (rg_addr[2:0] == 3'h0) ?
		master_xactor_f_rd_data$D_OUT[66:3] :
		64'd0;
      3'b100:
	  ld_val__h17594 =
	      IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d427;
      3'b101:
	  ld_val__h17594 =
	      IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_0_CO_ETC___d447;
      3'b110:
	  ld_val__h17594 =
	      CASE_rg_addr_BITS_2_TO_0_0x0_result8430_0x4_re_ETC__q30;
      3'd7: ld_val__h17594 = 64'd0;
    endcase
  end
  always@(rg_addr or ram_word64_set$DOB or rg_st_amo_val)
  begin
    case (rg_addr[2:0])
      3'h0:
	  CASE_rg_addr_BITS_2_TO_0_0x0_ram_word64_setDO_ETC__q31 =
	      { ram_word64_set$DOB[63:32], rg_st_amo_val[31:0] };
      3'h4:
	  CASE_rg_addr_BITS_2_TO_0_0x0_ram_word64_setDO_ETC__q31 =
	      { rg_st_amo_val[31:0], ram_word64_set$DOB[31:0] };
      default: CASE_rg_addr_BITS_2_TO_0_0x0_ram_word64_setDO_ETC__q31 =
		   ram_word64_set$DOB;
    endcase
  end
  always@(rg_f3 or
	  ram_word64_set$DOB or
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d157 or
	  IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d167 or
	  CASE_rg_addr_BITS_2_TO_0_0x0_ram_word64_setDO_ETC__q31 or
	  rg_st_amo_val)
  begin
    case (rg_f3)
      3'b0:
	  IF_rg_f3_16_EQ_0b0_17_THEN_IF_rg_addr_6_BITS_2_ETC___d178 =
	      IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d157;
      3'b001:
	  IF_rg_f3_16_EQ_0b0_17_THEN_IF_rg_addr_6_BITS_2_ETC___d178 =
	      IF_rg_addr_6_BITS_2_TO_0_4_EQ_0x0_18_THEN_ram__ETC___d167;
      3'b010:
	  IF_rg_f3_16_EQ_0b0_17_THEN_IF_rg_addr_6_BITS_2_ETC___d178 =
	      CASE_rg_addr_BITS_2_TO_0_0x0_ram_word64_setDO_ETC__q31;
      3'b011:
	  IF_rg_f3_16_EQ_0b0_17_THEN_IF_rg_addr_6_BITS_2_ETC___d178 =
	      rg_st_amo_val;
      default: IF_rg_f3_16_EQ_0b0_17_THEN_IF_rg_addr_6_BITS_2_ETC___d178 =
		   ram_word64_set$DOB;
    endcase
  end
  always@(rg_addr or result__h12361 or result__h12389)
  begin
    case (rg_addr[2:0])
      3'h0:
	  CASE_rg_addr_BITS_2_TO_0_0x0_result2361_0x4_re_ETC__q32 =
	      result__h12361;
      3'h4:
	  CASE_rg_addr_BITS_2_TO_0_0x0_result2361_0x4_re_ETC__q32 =
	      result__h12389;
      default: CASE_rg_addr_BITS_2_TO_0_0x0_result2361_0x4_re_ETC__q32 =
		   64'd0;
    endcase
  end
  always@(rg_addr or result__h12428 or result__h12456)
  begin
    case (rg_addr[2:0])
      3'h0:
	  CASE_rg_addr_BITS_2_TO_0_0x0_result2428_0x4_re_ETC__q33 =
	      result__h12428;
      3'h4:
	  CASE_rg_addr_BITS_2_TO_0_0x0_result2428_0x4_re_ETC__q33 =
	      result__h12456;
      default: CASE_rg_addr_BITS_2_TO_0_0x0_result2428_0x4_re_ETC__q33 =
		   64'd0;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == 1'b0)
      begin
        cfg_verbosity <=  4'd0;
	ctr_wr_rsps_pending_crg <=  4'd0;
	rg_cset_in_cache <=  7'd0;
	rg_lower_word32_full <=  1'd0;
	rg_state <=  4'd0;
      end
    else
      begin
        if (cfg_verbosity$EN)
	  cfg_verbosity <=  cfg_verbosity$D_IN;
	if (ctr_wr_rsps_pending_crg$EN)
	  ctr_wr_rsps_pending_crg <= 
	      ctr_wr_rsps_pending_crg$D_IN;
	if (rg_cset_in_cache$EN)
	  rg_cset_in_cache <=  rg_cset_in_cache$D_IN;
	if (rg_lower_word32_full$EN)
	  rg_lower_word32_full <= 
	      rg_lower_word32_full$D_IN;
	if (rg_state$EN) rg_state <=  rg_state$D_IN;
      end
    if (rg_addr$EN) rg_addr <=  rg_addr$D_IN;
    if (rg_error_during_refill$EN)
      rg_error_during_refill <= 
	  rg_error_during_refill$D_IN;
    if (rg_exc_code$EN) rg_exc_code <=  rg_exc_code$D_IN;
    if (rg_f3$EN) rg_f3 <=  rg_f3$D_IN;
    if (rg_ld_val$EN) rg_ld_val <=  rg_ld_val$D_IN;
    if (rg_lower_word32$EN)
      rg_lower_word32 <=  rg_lower_word32$D_IN;
    if (rg_op$EN) rg_op <=  rg_op$D_IN;
    if (rg_pa$EN) rg_pa <=  rg_pa$D_IN;
    if (rg_pte_pa$EN) rg_pte_pa <=  rg_pte_pa$D_IN;
    if (rg_st_amo_val$EN)
      rg_st_amo_val <=  rg_st_amo_val$D_IN;
    if (rg_word64_set_in_cache$EN)
      rg_word64_set_in_cache <= 
	  rg_word64_set_in_cache$D_IN;
  end

  // synopsys translate_off
  
  



















 // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  ctr_wr_rsps_pending_crg == 4'd15)
	begin
	  v__h2948 = $stime;
	  #0;
	end
    v__h2942 = v__h2948 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  ctr_wr_rsps_pending_crg == 4'd15)
	$display("%0d: ERROR: CreditCounter: overflow", v__h2942);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  ctr_wr_rsps_pending_crg == 4'd15)
	$finish(32'd1);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("            To fabric: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("AXI4_Wr_Addr { ", "awid: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "awaddr: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", mem_req_wr_addr_awaddr__h2473);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "awlen: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 8'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "awsize: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", x__h2520);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "awburst: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 2'b01);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "awlock: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 1'b0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "awcache: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'b0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "awprot: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 3'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "awqos: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "awregion: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "awuser: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 1'h0, " }");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("                       ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("AXI4_Wr_Data { ", "wdata: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", mem_req_wr_data_wdata__h2699);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "wstrb: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", mem_req_wr_data_wstrb__h2700);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "wlast: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("True");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "wuser: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 1'h0, " }");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_fabric_send_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset && rg_cset_in_cache == 7'd127 &&
	  cfg_verbosity != 4'd0 &&
	  !f_reset_reqs$D_OUT)
	begin
	  v__h3848 = $stime;
	  #0;
	end
    v__h3842 = v__h3848 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset && rg_cset_in_cache == 7'd127 &&
	  cfg_verbosity != 4'd0 &&
	  !f_reset_reqs$D_OUT)
	if (dmem_not_imem)
	  $display("%0d: %s.rl_reset: %0d sets x %0d ways: all tag states reset to CTAG_EMPTY",
		   v__h3842,
		   "D_MMU_Cache",
		   $signed(32'd128),
		   $signed(32'd1));
	else
	  $display("%0d: %s.rl_reset: %0d sets x %0d ways: all tag states reset to CTAG_EMPTY",
		   v__h3842,
		   "I_MMU_Cache",
		   $signed(32'd128),
		   $signed(32'd1));
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset && rg_cset_in_cache == 7'd127 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42 &&
	  f_reset_reqs$D_OUT)
	begin
	  v__h3949 = $stime;
	  #0;
	end
    v__h3943 = v__h3949 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset && rg_cset_in_cache == 7'd127 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42 &&
	  f_reset_reqs$D_OUT)
	if (dmem_not_imem)
	  $display("%0d: %s.rl_reset: Flushed", v__h3943, "D_MMU_Cache");
	else
	  $display("%0d: %s.rl_reset: Flushed", v__h3943, "I_MMU_Cache");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	begin
	  v__h4098 = $stime;
	  #0;
	end
    v__h4092 = v__h4098 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	if (dmem_not_imem)
	  $display("%0d: %s: rl_probe_and_immed_rsp; eaddr %0h",
		   v__h4092,
		   "D_MMU_Cache",
		   rg_addr);
	else
	  $display("%0d: %s: rl_probe_and_immed_rsp; eaddr %0h",
		   v__h4092,
		   "I_MMU_Cache",
		   rg_addr);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$display("        eaddr = {CTag 0x%0h  CSet 0x%0h  Word64 0x%0h  Byte 0x%0h}",
		 pa_ctag__h4952,
		 rg_addr[11:5],
		 rg_addr[4:3],
		 rg_addr[2:0]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("        CSet 0x%0x: (state, tag):", rg_addr[11:5]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(" (");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42 &&
	  ram_state_and_ctag_cset$DOB[22])
	$write("CTAG_CLEAN");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42 &&
	  !ram_state_and_ctag_cset$DOB[22])
	$write("CTAG_EMPTY");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42 &&
	  ram_state_and_ctag_cset$DOB[22])
	$write(", 0x%0x", ram_state_and_ctag_cset$DOB[21:0]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42 &&
	  !ram_state_and_ctag_cset$DOB[22])
	$write(", --");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(")");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("        CSet 0x%0x, Word64 0x%0x: ",
	       rg_addr[11:5],
	       rg_addr[4:3]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(" 0x%0x", ram_word64_set$DOB);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("    TLB result: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("VM_Xlate_Result { ", "outcome: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("VM_XLATE_OK");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "pa: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", rg_addr);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "exc_code: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'hA, " }");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp && dmem_not_imem &&
	  !soc_map$m_is_mem_addr &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$display("    => IO_REQ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	  rg_op_1_AND_ram_state_and_ctag_cset_b_read__5__ETC___d180)
	$display("        Write-Cache-Hit: pa 0x%0h word64 0x%0h",
		 rg_addr,
		 rg_st_amo_val);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	  rg_op_1_AND_ram_state_and_ctag_cset_b_read__5__ETC___d180)
	$write("        New Word64_Set:");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	  rg_op_1_AND_ram_state_and_ctag_cset_b_read__5__ETC___d180)
	$write("        CSet 0x%0x, Word64 0x%0x: ",
	       rg_addr[11:5],
	       rg_addr[4:3]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	  rg_op_1_AND_ram_state_and_ctag_cset_b_read__5__ETC___d180)
	$write(" 0x%0x",
	       IF_rg_f3_16_EQ_0b0_17_THEN_IF_rg_addr_6_BITS_2_ETC___d178);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	  rg_op_1_AND_ram_state_and_ctag_cset_b_read__5__ETC___d180)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	  rg_op &&
	  (!ram_state_and_ctag_cset$DOB[22] ||
	   !ram_state_and_ctag_cset_b_read__5_BITS_21_TO_0_ETC___d102) &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$display("        Write-Cache-Miss: pa 0x%0h word64 0x%0h",
		 rg_addr,
		 rg_st_amo_val);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	  rg_op &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$display("        Write-Cache-Hit/Miss: eaddr 0x%0h word64 0x%0h",
		 rg_addr,
		 rg_st_amo_val);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	  rg_op &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$display("        => rl_write_response");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	  NOT_rg_op_1_2_AND_ram_state_and_ctag_cset_b_re_ETC___d305)
	begin
	  v__h12540 = $stime;
	  #0;
	end
    v__h12534 = v__h12540 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	  NOT_rg_op_1_2_AND_ram_state_and_ctag_cset_b_re_ETC___d305)
	if (dmem_not_imem)
	  $display("%0d: %s.drive_mem_rsp: addr 0x%0h ld_val 0x%0h st_amo_val 0x%0h",
		   v__h12534,
		   "D_MMU_Cache",
		   rg_addr,
		   word64__h5094,
		   64'd0);
	else
	  $display("%0d: %s.drive_mem_rsp: addr 0x%0h ld_val 0x%0h st_amo_val 0x%0h",
		   v__h12534,
		   "I_MMU_Cache",
		   rg_addr,
		   word64__h5094,
		   64'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	  NOT_rg_op_1_2_AND_ram_state_and_ctag_cset_b_re_ETC___d305)
	$display("        Read-hit: addr 0x%0h word64 0x%0h",
		 rg_addr,
		 word64__h5094);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_probe_and_immed_rsp &&
	  (!dmem_not_imem || soc_map$m_is_mem_addr) &&
	  !rg_op &&
	  (!ram_state_and_ctag_cset$DOB[22] ||
	   !ram_state_and_ctag_cset_b_read__5_BITS_21_TO_0_ETC___d102) &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$display("        Read Miss: -> CACHE_START_REFILL.");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	begin
	  v__h14531 = $stime;
	  #0;
	end
    v__h14525 = v__h14531 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	if (dmem_not_imem)
	  $display("%0d: %s.rl_start_cache_refill: ",
		   v__h14525,
		   "D_MMU_Cache");
	else
	  $display("%0d: %s.rl_start_cache_refill: ",
		   v__h14525,
		   "I_MMU_Cache");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("    To fabric: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("AXI4_Rd_Addr { ", "arid: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "araddr: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", cline_fabric_addr__h14584);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arlen: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 8'd3);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arsize: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 3'b011);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arburst: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 2'b01);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arlock: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 1'b0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arcache: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'b0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arprot: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 3'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arqos: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arregion: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "aruser: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 1'h0, " }");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_cache_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$display("    Victim way %0d; => CACHE_REFILL", 1'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	begin
	  v__h15336 = $stime;
	  #0;
	end
    v__h15330 = v__h15336 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	if (dmem_not_imem)
	  $display("%0d: %s.rl_cache_refill_rsps_loop:",
		   v__h15330,
		   "D_MMU_Cache");
	else
	  $display("%0d: %s.rl_cache_refill_rsps_loop:",
		   v__h15330,
		   "I_MMU_Cache");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write("        ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write("AXI4_Rd_Data { ", "rid: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write("'h%h", master_xactor_f_rd_data$D_OUT[70:67]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write(", ", "rdata: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write("'h%h", master_xactor_f_rd_data$D_OUT[66:3]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write(", ", "rresp: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write("'h%h", master_xactor_f_rd_data$D_OUT[2:1]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write(", ", "rlast: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331 &&
	  master_xactor_f_rd_data$D_OUT[0])
	$write("True");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331 &&
	  !master_xactor_f_rd_data$D_OUT[0])
	$write("False");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write(", ", "ruser: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write("'h%h", 1'd0, " }");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  master_xactor_f_rd_data$D_OUT[2:1] != 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	begin
	  v__h15578 = $stime;
	  #0;
	end
    v__h15572 = v__h15578 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  master_xactor_f_rd_data$D_OUT[2:1] != 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	if (dmem_not_imem)
	  $display("%0d: %s.rl_cache_refill_rsps_loop: FABRIC_RSP_ERR: raising access exception %0d",
		   v__h15572,
		   "D_MMU_Cache",
		   access_exc_code__h2256);
	else
	  $display("%0d: %s.rl_cache_refill_rsps_loop: FABRIC_RSP_ERR: raising access exception %0d",
		   v__h15572,
		   "I_MMU_Cache",
		   access_exc_code__h2256);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  rg_word64_set_in_cache[1:0] == 2'd3 &&
	  (master_xactor_f_rd_data$D_OUT[2:1] != 2'b0 ||
	   rg_error_during_refill) &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$display("    => MODULE_EXCEPTION_RSP");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  rg_word64_set_in_cache[1:0] == 2'd3 &&
	  master_xactor_f_rd_data$D_OUT[2:1] == 2'b0 &&
	  !rg_error_during_refill &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$display("    => CACHE_REREQ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$display("        Updating Cache word64_set 0x%0h, word64_in_cline %0d) old => new",
		 rg_word64_set_in_cache,
		 rg_word64_set_in_cache[1:0]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write("        CSet 0x%0x, Word64 0x%0x: ",
	       rg_addr[11:5],
	       rg_word64_set_in_cache[1:0]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write(" 0x%0x", ram_word64_set$DOB);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write("        CSet 0x%0x, Word64 0x%0x: ",
	       rg_addr[11:5],
	       rg_word64_set_in_cache[1:0]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write(" 0x%0x", master_xactor_f_rd_data$D_OUT[66:3]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_cache_refill_rsps_loop &&
	  NOT_cfg_verbosity_read__0_ULE_2_30___d331)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_rereq && NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$display("    fa_req_ram_B tagCSet [0x%0x] word64_set [0x%0d]",
		 rg_addr[11:5],
		 rg_addr[11:3]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	begin
	  v__h17191 = $stime;
	  #0;
	end
    v__h17185 = v__h17191 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	if (dmem_not_imem)
	  $display("%0d: %s.rl_io_read_req; f3 0x%0h vaddr %0h  paddr %0h",
		   v__h17185,
		   "D_MMU_Cache",
		   rg_f3,
		   rg_addr,
		   rg_pa);
	else
	  $display("%0d: %s.rl_io_read_req; f3 0x%0h vaddr %0h  paddr %0h",
		   v__h17185,
		   "I_MMU_Cache",
		   rg_f3,
		   rg_addr,
		   rg_pa);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("            To fabric: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("AXI4_Rd_Addr { ", "arid: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "araddr: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", fabric_addr__h17243);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arlen: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 8'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arsize: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", value__h17372);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arburst: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 2'b01);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arlock: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 1'b0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arcache: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'b0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arprot: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 3'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arqos: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "arregion: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 4'd0);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "aruser: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 1'h0, " }");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	begin
	  v__h17485 = $stime;
	  #0;
	end
    v__h17479 = v__h17485 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	if (dmem_not_imem)
	  $display("%0d: %s.rl_io_read_rsp: vaddr 0x%0h  paddr 0x%0h",
		   v__h17479,
		   "D_MMU_Cache",
		   rg_addr,
		   rg_pa);
	else
	  $display("%0d: %s.rl_io_read_rsp: vaddr 0x%0h  paddr 0x%0h",
		   v__h17479,
		   "I_MMU_Cache",
		   rg_addr,
		   rg_pa);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("    ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("AXI4_Rd_Data { ", "rid: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", master_xactor_f_rd_data$D_OUT[70:67]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "rdata: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", master_xactor_f_rd_data$D_OUT[66:3]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "rresp: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", master_xactor_f_rd_data$D_OUT[2:1]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "rlast: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42 &&
	  master_xactor_f_rd_data$D_OUT[0])
	$write("True");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42 &&
	  !master_xactor_f_rd_data$D_OUT[0])
	$write("False");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "ruser: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 1'd0, " }");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  master_xactor_f_rd_data$D_OUT[2:1] == 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	begin
	  v__h18585 = $stime;
	  #0;
	end
    v__h18579 = v__h18585 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  master_xactor_f_rd_data$D_OUT[2:1] == 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	if (dmem_not_imem)
	  $display("%0d: %s.drive_IO_read_rsp: addr 0x%0h ld_val 0x%0h",
		   v__h18579,
		   "D_MMU_Cache",
		   rg_addr,
		   ld_val__h17594);
	else
	  $display("%0d: %s.drive_IO_read_rsp: addr 0x%0h ld_val 0x%0h",
		   v__h18579,
		   "I_MMU_Cache",
		   rg_addr,
		   ld_val__h17594);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  master_xactor_f_rd_data$D_OUT[2:1] != 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	begin
	  v__h18692 = $stime;
	  #0;
	end
    v__h18686 = v__h18692 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_read_rsp &&
	  master_xactor_f_rd_data$D_OUT[2:1] != 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	if (dmem_not_imem)
	  $display("%0d: %s.rl_io_read_rsp: FABRIC_RSP_ERR: raising trap LOAD_ACCESS_FAULT",
		   v__h18686,
		   "D_MMU_Cache");
	else
	  $display("%0d: %s.rl_io_read_rsp: FABRIC_RSP_ERR: raising trap LOAD_ACCESS_FAULT",
		   v__h18686,
		   "I_MMU_Cache");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_maintain_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	begin
	  v__h18797 = $stime;
	  #0;
	end
    v__h18791 = v__h18797 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_maintain_io_read_rsp &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	if (dmem_not_imem)
	  $display("%0d: %s.drive_IO_read_rsp: addr 0x%0h ld_val 0x%0h",
		   v__h18791,
		   "D_MMU_Cache",
		   rg_addr,
		   rg_ld_val);
	else
	  $display("%0d: %s.drive_IO_read_rsp: addr 0x%0h ld_val 0x%0h",
		   v__h18791,
		   "I_MMU_Cache",
		   rg_addr,
		   rg_ld_val);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	begin
	  v__h18877 = $stime;
	  #0;
	end
    v__h18871 = v__h18877 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	if (dmem_not_imem)
	  $display("%0d: %s: rl_io_write_req; f3 0x%0h  vaddr %0h  paddr %0h  word64 0x%0h",
		   v__h18871,
		   "D_MMU_Cache",
		   rg_f3,
		   rg_addr,
		   rg_pa,
		   rg_st_amo_val);
	else
	  $display("%0d: %s: rl_io_write_req; f3 0x%0h  vaddr %0h  paddr %0h  word64 0x%0h",
		   v__h18871,
		   "I_MMU_Cache",
		   rg_f3,
		   rg_addr,
		   rg_pa,
		   rg_st_amo_val);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_io_write_req &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$display("    => rl_ST_AMO_response");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] == 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	begin
	  v__h19505 = $stime;
	  #0;
	end
    v__h19499 = v__h19505 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] == 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	if (dmem_not_imem)
	  $write("%0d: %s.rl_discard_write_rsp: pending %0d ",
		 v__h19499,
		 "D_MMU_Cache",
		 $unsigned(b__h14485));
	else
	  $write("%0d: %s.rl_discard_write_rsp: pending %0d ",
		 v__h19499,
		 "I_MMU_Cache",
		 $unsigned(b__h14485));
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] == 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("AXI4_Wr_Resp { ", "bid: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] == 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", master_xactor_f_wr_resp$D_OUT[5:2]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] == 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "bresp: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] == 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", master_xactor_f_wr_resp$D_OUT[1:0]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] == 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(", ", "buser: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] == 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("'h%h", 1'd0, " }");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] == 2'b0 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] != 2'b0)
	begin
	  v__h19466 = $stime;
	  #0;
	end
    v__h19460 = v__h19466 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] != 2'b0)
	if (dmem_not_imem)
	  $display("%0d: %s.rl_discard_write_rsp: fabric response error: exit",
		   v__h19460,
		   "D_MMU_Cache");
	else
	  $display("%0d: %s.rl_discard_write_rsp: fabric response error: exit",
		   v__h19460,
		   "I_MMU_Cache");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] != 2'b0)
	$write("    ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] != 2'b0)
	$write("AXI4_Wr_Resp { ", "bid: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] != 2'b0)
	$write("'h%h", master_xactor_f_wr_resp$D_OUT[5:2]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] != 2'b0)
	$write(", ", "bresp: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] != 2'b0)
	$write("'h%h", master_xactor_f_wr_resp$D_OUT[1:0]);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] != 2'b0)
	$write(", ", "buser: ");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] != 2'b0)
	$write("'h%h", 1'd0, " }");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_discard_write_rsp &&
	  master_xactor_f_wr_resp$D_OUT[1:0] != 2'b0)
	$write("\n");
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_reset &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	begin
	  v__h3483 = $stime;
	  #0;
	end
    v__h3477 = v__h3483 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_start_reset &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	if (dmem_not_imem)
	  $display("%0d: %s.rl_start_reset", v__h3477, "D_MMU_Cache");
	else
	  $display("%0d: %s.rl_start_reset", v__h3477, "I_MMU_Cache");
    if (RST_N != 1'b0)
      if (EN_req && NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	begin
	  v__h19852 = $stime;
	  #0;
	end
    v__h19846 = v__h19852 / 32'd10;
    if (RST_N != 1'b0)
      if (EN_req && NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("%0d: %m.req: op:", v__h19846);
    if (RST_N != 1'b0)
      if (EN_req && NOT_cfg_verbosity_read__0_ULE_1_1___d42 && req_op)
	$write("CACHE_ST");
    if (RST_N != 1'b0)
      if (EN_req && NOT_cfg_verbosity_read__0_ULE_1_1___d42 && !req_op)
	$write("CACHE_LD");
    if (RST_N != 1'b0)
      if (EN_req && NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(" f3:%0d addr:0x%0h st_value:0x%0h",
	       req_f3,
	       req_addr,
	       req_st_value,
	       "\n");
    if (RST_N != 1'b0)
      if (EN_req && NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write("    priv:");
    if (RST_N != 1'b0)
      if (EN_req && NOT_cfg_verbosity_read__0_ULE_1_1___d42 &&
	  req_priv == 2'b0)
	$write("U");
    if (RST_N != 1'b0)
      if (EN_req && NOT_cfg_verbosity_read__0_ULE_1_1___d42 &&
	  req_priv == 2'b01)
	$write("S");
    if (RST_N != 1'b0)
      if (EN_req && NOT_cfg_verbosity_read__0_ULE_1_1___d42 &&
	  req_priv == 2'b11)
	$write("M");
    if (RST_N != 1'b0)
      if (EN_req && NOT_cfg_verbosity_read__0_ULE_1_1___d42 &&
	  req_priv != 2'b0 &&
	  req_priv != 2'b01 &&
	  req_priv != 2'b11)
	$write("RESERVED");
    if (RST_N != 1'b0)
      if (EN_req && NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$write(" sstatus_SUM:%0d mstatus_MXR:%0d satp:0x%0h",
	       req_sstatus_SUM,
	       req_mstatus_MXR,
	       req_satp,
	       "\n");
    if (RST_N != 1'b0)
      if (EN_req &&
	  req_f3_BITS_1_TO_0_18_EQ_0b0_19_OR_req_f3_BITS_ETC___d548 &&
	  NOT_cfg_verbosity_read__0_ULE_1_1___d42)
	$display("    fa_req_ram_B tagCSet [0x%0x] word64_set [0x%0d]",
		 req_addr[11:5],
		 req_addr[11:3]);
  end
  // synopsys translate_on
 assign RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr = rg_addr;
 assign RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa = rg_pa;
endmodule  // mkMMU_Cache

//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
//
//
//
// Ports:
// Name                         I/O  size props
// RDY_server_reset_request_put   O     1
// RDY_server_reset_response_get  O     1 reg
// imem_valid                     O     1
// imem_is_i32_not_i16            O     1 const
// imem_pc                        O    32 reg
// imem_instr                     O    32
// imem_exc                       O     1
// imem_exc_code                  O     4 reg
// imem_tval                      O    32 reg
// imem_master_awvalid            O     1 reg
// imem_master_awid               O     4 reg
// imem_master_awaddr             O    64 reg
// imem_master_awlen              O     8 reg
// imem_master_awsize             O     3 reg
// imem_master_awburst            O     2 reg
// imem_master_awlock             O     1 reg
// imem_master_awcache            O     4 reg
// imem_master_awprot             O     3 reg
// imem_master_awqos              O     4 reg
// imem_master_awregion           O     4 reg
// imem_master_wvalid             O     1 reg
// imem_master_wdata              O    64 reg
// imem_master_wstrb              O     8 reg
// imem_master_wlast              O     1 reg
// imem_master_bready             O     1 reg
// imem_master_arvalid            O     1 reg
// imem_master_arid               O     4 reg
// imem_master_araddr             O    64 reg
// imem_master_arlen              O     8 reg
// imem_master_arsize             O     3 reg
// imem_master_arburst            O     2 reg
// imem_master_arlock             O     1 reg
// imem_master_arcache            O     4 reg
// imem_master_arprot             O     3 reg
// imem_master_arqos              O     4 reg
// imem_master_arregion           O     4 reg
// imem_master_rready             O     1 reg
// dmem_valid                     O     1
// dmem_word64                    O    64
// dmem_st_amo_val                O    64 const
// dmem_exc                       O     1
// dmem_exc_code                  O     4 reg
// dmem_master_awvalid            O     1 reg
// dmem_master_awid               O     4 reg
// dmem_master_awaddr             O    64 reg
// dmem_master_awlen              O     8 reg
// dmem_master_awsize             O     3 reg
// dmem_master_awburst            O     2 reg
// dmem_master_awlock             O     1 reg
// dmem_master_awcache            O     4 reg
// dmem_master_awprot             O     3 reg
// dmem_master_awqos              O     4 reg
// dmem_master_awregion           O     4 reg
// dmem_master_wvalid             O     1 reg
// dmem_master_wdata              O    64 reg
// dmem_master_wstrb              O     8 reg
// dmem_master_wlast              O     1 reg
// dmem_master_bready             O     1 reg
// dmem_master_arvalid            O     1 reg
// dmem_master_arid               O     4 reg
// dmem_master_araddr             O    64 reg
// dmem_master_arlen              O     8 reg
// dmem_master_arsize             O     3 reg
// dmem_master_arburst            O     2 reg
// dmem_master_arlock             O     1 reg
// dmem_master_arcache            O     4 reg
// dmem_master_arprot             O     3 reg
// dmem_master_arqos              O     4 reg
// dmem_master_arregion           O     4 reg
// dmem_master_rready             O     1 reg
// RDY_server_fence_i_request_put  O     1
// RDY_server_fence_i_response_get  O     1
// RDY_server_fence_request_put   O     1 reg
// RDY_server_fence_response_get  O     1
// RDY_sfence_vma                 O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// imem_req_f3                    I     3
// imem_req_addr                  I    32
// imem_req_priv                  I     2 unused
// imem_req_sstatus_SUM           I     1 unused
// imem_req_mstatus_MXR           I     1 unused
// imem_req_satp                  I    32 unused
// imem_master_awready            I     1
// imem_master_wready             I     1
// imem_master_bvalid             I     1
// imem_master_bid                I     4 reg
// imem_master_bresp              I     2 reg
// imem_master_arready            I     1
// imem_master_rvalid             I     1
// imem_master_rid                I     4 reg
// imem_master_rdata              I    64 reg
// imem_master_rresp              I     2 reg
// imem_master_rlast              I     1 reg
// dmem_req_op                    I     1
// dmem_req_f3                    I     3
// dmem_req_addr                  I    32
// dmem_req_store_value           I    64 reg
// dmem_req_priv                  I     2 unused
// dmem_req_sstatus_SUM           I     1 unused
// dmem_req_mstatus_MXR           I     1 unused
// dmem_req_satp                  I    32 unused
// dmem_master_awready            I     1
// dmem_master_wready             I     1
// dmem_master_bvalid             I     1
// dmem_master_bid                I     4 reg
// dmem_master_bresp              I     2 reg
// dmem_master_arready            I     1
// dmem_master_rvalid             I     1
// dmem_master_rid                I     4 reg
// dmem_master_rdata              I    64 reg
// dmem_master_rresp              I     2 reg
// dmem_master_rlast              I     1 reg
// server_fence_request_put       I     8 unused
// EN_server_reset_request_put    I     1
// EN_server_reset_response_get   I     1
// EN_imem_req                    I     1
// EN_dmem_req                    I     1
// EN_server_fence_i_request_put  I     1
// EN_server_fence_i_response_get  I     1
// EN_server_fence_request_put    I     1
// EN_server_fence_response_get   I     1
// EN_sfence_vma                  I     1 unused
//
// No combinational paths from inputs to outputs
//
//










  
  


module mkNear_Mem(CLK,
		  RST_N,

		  EN_server_reset_request_put,
		  RDY_server_reset_request_put,

		  EN_server_reset_response_get,
		  RDY_server_reset_response_get,

		  imem_req_f3,
		  imem_req_addr,
		  imem_req_priv,
		  imem_req_sstatus_SUM,
		  imem_req_mstatus_MXR,
		  imem_req_satp,
		  EN_imem_req,

		  imem_valid,

		  imem_is_i32_not_i16,

		  imem_pc,

		  imem_instr,

		  imem_exc,

		  imem_exc_code,

		  imem_tval,

		  imem_master_awvalid,

		  imem_master_awid,

		  imem_master_awaddr,

		  imem_master_awlen,

		  imem_master_awsize,

		  imem_master_awburst,

		  imem_master_awlock,

		  imem_master_awcache,

		  imem_master_awprot,

		  imem_master_awqos,

		  imem_master_awregion,

		  imem_master_awready,

		  imem_master_wvalid,

		  imem_master_wdata,

		  imem_master_wstrb,

		  imem_master_wlast,

		  imem_master_wready,

		  imem_master_bvalid,
		  imem_master_bid,
		  imem_master_bresp,

		  imem_master_bready,

		  imem_master_arvalid,

		  imem_master_arid,

		  imem_master_araddr,

		  imem_master_arlen,

		  imem_master_arsize,

		  imem_master_arburst,

		  imem_master_arlock,

		  imem_master_arcache,

		  imem_master_arprot,

		  imem_master_arqos,

		  imem_master_arregion,

		  imem_master_arready,

		  imem_master_rvalid,
		  imem_master_rid,
		  imem_master_rdata,
		  imem_master_rresp,
		  imem_master_rlast,

		  imem_master_rready,

		  dmem_req_op,
		  dmem_req_f3,
		  dmem_req_addr,
		  dmem_req_store_value,
		  dmem_req_priv,
		  dmem_req_sstatus_SUM,
		  dmem_req_mstatus_MXR,
		  dmem_req_satp,
		  EN_dmem_req,

		  dmem_valid,

		  dmem_word64,

		  dmem_st_amo_val,

		  dmem_exc,

		  dmem_exc_code,

		  dmem_master_awvalid,

		  dmem_master_awid,

		  dmem_master_awaddr,

		  dmem_master_awlen,

		  dmem_master_awsize,

		  dmem_master_awburst,

		  dmem_master_awlock,

		  dmem_master_awcache,

		  dmem_master_awprot,

		  dmem_master_awqos,

		  dmem_master_awregion,

		  dmem_master_awready,

		  dmem_master_wvalid,

		  dmem_master_wdata,

		  dmem_master_wstrb,

		  dmem_master_wlast,

		  dmem_master_wready,

		  dmem_master_bvalid,
		  dmem_master_bid,
		  dmem_master_bresp,

		  dmem_master_bready,

		  dmem_master_arvalid,

		  dmem_master_arid,

		  dmem_master_araddr,

		  dmem_master_arlen,

		  dmem_master_arsize,

		  dmem_master_arburst,

		  dmem_master_arlock,

		  dmem_master_arcache,

		  dmem_master_arprot,

		  dmem_master_arqos,

		  dmem_master_arregion,

		  dmem_master_arready,

		  dmem_master_rvalid,
		  dmem_master_rid,
		  dmem_master_rdata,
		  dmem_master_rresp,
		  dmem_master_rlast,

		  dmem_master_rready,

		  EN_server_fence_i_request_put,
		  RDY_server_fence_i_request_put,

		  EN_server_fence_i_response_get,
		  RDY_server_fence_i_response_get,

		  server_fence_request_put,
		  EN_server_fence_request_put,
		  RDY_server_fence_request_put,

		  EN_server_fence_response_get,
		  RDY_server_fence_response_get,

		  EN_sfence_vma,
		  RDY_sfence_vma, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa, RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg, RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr, RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg);
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg;
 output [31:0] RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa;
 output  RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg;
 output [31:0] RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr;
 output  RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg;
  input  CLK;
  input  RST_N;

  // action method server_reset_request_put
  input  EN_server_reset_request_put;
  output RDY_server_reset_request_put;

  // action method server_reset_response_get
  input  EN_server_reset_response_get;
  output RDY_server_reset_response_get;

  // action method imem_req
  input  [2 : 0] imem_req_f3;
  input  [31 : 0] imem_req_addr;
  input  [1 : 0] imem_req_priv;
  input  imem_req_sstatus_SUM;
  input  imem_req_mstatus_MXR;
  input  [31 : 0] imem_req_satp;
  input  EN_imem_req;

  // value method imem_valid
  output imem_valid;

  // value method imem_is_i32_not_i16
  output imem_is_i32_not_i16;

  // value method imem_pc
  output [31 : 0] imem_pc;

  // value method imem_instr
  output [31 : 0] imem_instr;

  // value method imem_exc
  output imem_exc;

  // value method imem_exc_code
  output [3 : 0] imem_exc_code;

  // value method imem_tval
  output [31 : 0] imem_tval;

  // value method imem_master_m_awvalid
  output imem_master_awvalid;

  // value method imem_master_m_awid
  output [3 : 0] imem_master_awid;

  // value method imem_master_m_awaddr
  output [63 : 0] imem_master_awaddr;

  // value method imem_master_m_awlen
  output [7 : 0] imem_master_awlen;

  // value method imem_master_m_awsize
  output [2 : 0] imem_master_awsize;

  // value method imem_master_m_awburst
  output [1 : 0] imem_master_awburst;

  // value method imem_master_m_awlock
  output imem_master_awlock;

  // value method imem_master_m_awcache
  output [3 : 0] imem_master_awcache;

  // value method imem_master_m_awprot
  output [2 : 0] imem_master_awprot;

  // value method imem_master_m_awqos
  output [3 : 0] imem_master_awqos;

  // value method imem_master_m_awregion
  output [3 : 0] imem_master_awregion;

  // value method imem_master_m_awuser

  // action method imem_master_m_awready
  input  imem_master_awready;

  // value method imem_master_m_wvalid
  output imem_master_wvalid;

  // value method imem_master_m_wdata
  output [63 : 0] imem_master_wdata;

  // value method imem_master_m_wstrb
  output [7 : 0] imem_master_wstrb;

  // value method imem_master_m_wlast
  output imem_master_wlast;

  // value method imem_master_m_wuser

  // action method imem_master_m_wready
  input  imem_master_wready;

  // action method imem_master_m_bvalid
  input  imem_master_bvalid;
  input  [3 : 0] imem_master_bid;
  input  [1 : 0] imem_master_bresp;

  // value method imem_master_m_bready
  output imem_master_bready;

  // value method imem_master_m_arvalid
  output imem_master_arvalid;

  // value method imem_master_m_arid
  output [3 : 0] imem_master_arid;

  // value method imem_master_m_araddr
  output [63 : 0] imem_master_araddr;

  // value method imem_master_m_arlen
  output [7 : 0] imem_master_arlen;

  // value method imem_master_m_arsize
  output [2 : 0] imem_master_arsize;

  // value method imem_master_m_arburst
  output [1 : 0] imem_master_arburst;

  // value method imem_master_m_arlock
  output imem_master_arlock;

  // value method imem_master_m_arcache
  output [3 : 0] imem_master_arcache;

  // value method imem_master_m_arprot
  output [2 : 0] imem_master_arprot;

  // value method imem_master_m_arqos
  output [3 : 0] imem_master_arqos;

  // value method imem_master_m_arregion
  output [3 : 0] imem_master_arregion;

  // value method imem_master_m_aruser

  // action method imem_master_m_arready
  input  imem_master_arready;

  // action method imem_master_m_rvalid
  input  imem_master_rvalid;
  input  [3 : 0] imem_master_rid;
  input  [63 : 0] imem_master_rdata;
  input  [1 : 0] imem_master_rresp;
  input  imem_master_rlast;

  // value method imem_master_m_rready
  output imem_master_rready;

  // action method dmem_req
  input  dmem_req_op;
  input  [2 : 0] dmem_req_f3;
  input  [31 : 0] dmem_req_addr;
  input  [63 : 0] dmem_req_store_value;
  input  [1 : 0] dmem_req_priv;
  input  dmem_req_sstatus_SUM;
  input  dmem_req_mstatus_MXR;
  input  [31 : 0] dmem_req_satp;
  input  EN_dmem_req;

  // value method dmem_valid
  output dmem_valid;

  // value method dmem_word64
  output [63 : 0] dmem_word64;

  // value method dmem_st_amo_val
  output [63 : 0] dmem_st_amo_val;

  // value method dmem_exc
  output dmem_exc;

  // value method dmem_exc_code
  output [3 : 0] dmem_exc_code;

  // value method dmem_master_m_awvalid
  output dmem_master_awvalid;

  // value method dmem_master_m_awid
  output [3 : 0] dmem_master_awid;

  // value method dmem_master_m_awaddr
  output [63 : 0] dmem_master_awaddr;

  // value method dmem_master_m_awlen
  output [7 : 0] dmem_master_awlen;

  // value method dmem_master_m_awsize
  output [2 : 0] dmem_master_awsize;

  // value method dmem_master_m_awburst
  output [1 : 0] dmem_master_awburst;

  // value method dmem_master_m_awlock
  output dmem_master_awlock;

  // value method dmem_master_m_awcache
  output [3 : 0] dmem_master_awcache;

  // value method dmem_master_m_awprot
  output [2 : 0] dmem_master_awprot;

  // value method dmem_master_m_awqos
  output [3 : 0] dmem_master_awqos;

  // value method dmem_master_m_awregion
  output [3 : 0] dmem_master_awregion;

  // value method dmem_master_m_awuser

  // action method dmem_master_m_awready
  input  dmem_master_awready;

  // value method dmem_master_m_wvalid
  output dmem_master_wvalid;

  // value method dmem_master_m_wdata
  output [63 : 0] dmem_master_wdata;

  // value method dmem_master_m_wstrb
  output [7 : 0] dmem_master_wstrb;

  // value method dmem_master_m_wlast
  output dmem_master_wlast;

  // value method dmem_master_m_wuser

  // action method dmem_master_m_wready
  input  dmem_master_wready;

  // action method dmem_master_m_bvalid
  input  dmem_master_bvalid;
  input  [3 : 0] dmem_master_bid;
  input  [1 : 0] dmem_master_bresp;

  // value method dmem_master_m_bready
  output dmem_master_bready;

  // value method dmem_master_m_arvalid
  output dmem_master_arvalid;

  // value method dmem_master_m_arid
  output [3 : 0] dmem_master_arid;

  // value method dmem_master_m_araddr
  output [63 : 0] dmem_master_araddr;

  // value method dmem_master_m_arlen
  output [7 : 0] dmem_master_arlen;

  // value method dmem_master_m_arsize
  output [2 : 0] dmem_master_arsize;

  // value method dmem_master_m_arburst
  output [1 : 0] dmem_master_arburst;

  // value method dmem_master_m_arlock
  output dmem_master_arlock;

  // value method dmem_master_m_arcache
  output [3 : 0] dmem_master_arcache;

  // value method dmem_master_m_arprot
  output [2 : 0] dmem_master_arprot;

  // value method dmem_master_m_arqos
  output [3 : 0] dmem_master_arqos;

  // value method dmem_master_m_arregion
  output [3 : 0] dmem_master_arregion;

  // value method dmem_master_m_aruser

  // action method dmem_master_m_arready
  input  dmem_master_arready;

  // action method dmem_master_m_rvalid
  input  dmem_master_rvalid;
  input  [3 : 0] dmem_master_rid;
  input  [63 : 0] dmem_master_rdata;
  input  [1 : 0] dmem_master_rresp;
  input  dmem_master_rlast;

  // value method dmem_master_m_rready
  output dmem_master_rready;

  // action method server_fence_i_request_put
  input  EN_server_fence_i_request_put;
  output RDY_server_fence_i_request_put;

  // action method server_fence_i_response_get
  input  EN_server_fence_i_response_get;
  output RDY_server_fence_i_response_get;

  // action method server_fence_request_put
  input  [7 : 0] server_fence_request_put;
  input  EN_server_fence_request_put;
  output RDY_server_fence_request_put;

  // action method server_fence_response_get
  input  EN_server_fence_response_get;
  output RDY_server_fence_response_get;

  // action method sfence_vma
  input  EN_sfence_vma;
  output RDY_sfence_vma;

  // signals for module outputs
  wire [63 : 0] dmem_master_araddr,
		dmem_master_awaddr,
		dmem_master_wdata,
		dmem_st_amo_val,
		dmem_word64,
		imem_master_araddr,
		imem_master_awaddr,
		imem_master_wdata;
  wire [31 : 0] imem_instr, imem_pc, imem_tval;
  wire [7 : 0] dmem_master_arlen,
	       dmem_master_awlen,
	       dmem_master_wstrb,
	       imem_master_arlen,
	       imem_master_awlen,
	       imem_master_wstrb;
  wire [3 : 0] dmem_exc_code,
	       dmem_master_arcache,
	       dmem_master_arid,
	       dmem_master_arqos,
	       dmem_master_arregion,
	       dmem_master_awcache,
	       dmem_master_awid,
	       dmem_master_awqos,
	       dmem_master_awregion,
	       imem_exc_code,
	       imem_master_arcache,
	       imem_master_arid,
	       imem_master_arqos,
	       imem_master_arregion,
	       imem_master_awcache,
	       imem_master_awid,
	       imem_master_awqos,
	       imem_master_awregion;
  wire [2 : 0] dmem_master_arprot,
	       dmem_master_arsize,
	       dmem_master_awprot,
	       dmem_master_awsize,
	       imem_master_arprot,
	       imem_master_arsize,
	       imem_master_awprot,
	       imem_master_awsize;
  wire [1 : 0] dmem_master_arburst,
	       dmem_master_awburst,
	       imem_master_arburst,
	       imem_master_awburst;
  wire RDY_server_fence_i_request_put,
       RDY_server_fence_i_response_get,
       RDY_server_fence_request_put,
       RDY_server_fence_response_get,
       RDY_server_reset_request_put,
       RDY_server_reset_response_get,
       RDY_sfence_vma,
       dmem_exc,
       dmem_master_arlock,
       dmem_master_arvalid,
       dmem_master_awlock,
       dmem_master_awvalid,
       dmem_master_bready,
       dmem_master_rready,
       dmem_master_wlast,
       dmem_master_wvalid,
       dmem_valid,
       imem_exc,
       imem_is_i32_not_i16,
       imem_master_arlock,
       imem_master_arvalid,
       imem_master_awlock,
       imem_master_awvalid,
       imem_master_bready,
       imem_master_rready,
       imem_master_wlast,
       imem_master_wvalid,
       imem_valid;

  // register cfg_verbosity
  reg [3 : 0] cfg_verbosity;
  wire [3 : 0] cfg_verbosity$D_IN;
  wire cfg_verbosity$EN;

  // register rg_state
  reg [1 : 0] rg_state;
  reg [1 : 0] rg_state$D_IN;
  wire rg_state$EN;

  // ports of submodule dcache
  wire [63 : 0] dcache$mem_master_araddr,
		dcache$mem_master_awaddr,
		dcache$mem_master_rdata,
		dcache$mem_master_wdata,
		dcache$req_st_value,
		dcache$word64;
  wire [31 : 0] dcache$req_addr, dcache$req_satp;
  wire [7 : 0] dcache$mem_master_arlen,
	       dcache$mem_master_awlen,
	       dcache$mem_master_wstrb;
  wire [3 : 0] dcache$exc_code,
	       dcache$mem_master_arcache,
	       dcache$mem_master_arid,
	       dcache$mem_master_arqos,
	       dcache$mem_master_arregion,
	       dcache$mem_master_awcache,
	       dcache$mem_master_awid,
	       dcache$mem_master_awqos,
	       dcache$mem_master_awregion,
	       dcache$mem_master_bid,
	       dcache$mem_master_rid,
	       dcache$set_verbosity_verbosity;
  wire [2 : 0] dcache$mem_master_arprot,
	       dcache$mem_master_arsize,
	       dcache$mem_master_awprot,
	       dcache$mem_master_awsize,
	       dcache$req_f3;
  wire [1 : 0] dcache$mem_master_arburst,
	       dcache$mem_master_awburst,
	       dcache$mem_master_bresp,
	       dcache$mem_master_rresp,
	       dcache$req_priv;
  wire dcache$EN_req,
       dcache$EN_server_flush_request_put,
       dcache$EN_server_flush_response_get,
       dcache$EN_server_reset_request_put,
       dcache$EN_server_reset_response_get,
       dcache$EN_set_verbosity,
       dcache$EN_tlb_flush,
       dcache$RDY_server_flush_request_put,
       dcache$RDY_server_flush_response_get,
       dcache$RDY_server_reset_request_put,
       dcache$RDY_server_reset_response_get,
       dcache$exc,
       dcache$mem_master_arlock,
       dcache$mem_master_arready,
       dcache$mem_master_arvalid,
       dcache$mem_master_awlock,
       dcache$mem_master_awready,
       dcache$mem_master_awvalid,
       dcache$mem_master_bready,
       dcache$mem_master_bvalid,
       dcache$mem_master_rlast,
       dcache$mem_master_rready,
       dcache$mem_master_rvalid,
       dcache$mem_master_wlast,
       dcache$mem_master_wready,
       dcache$mem_master_wvalid,
       dcache$req_mstatus_MXR,
       dcache$req_op,
       dcache$req_sstatus_SUM,
       dcache$valid;

  // ports of submodule f_reset_rsps
  wire f_reset_rsps$CLR,
       f_reset_rsps$DEQ,
       f_reset_rsps$EMPTY_N,
       f_reset_rsps$ENQ,
       f_reset_rsps$FULL_N;

  // ports of submodule icache
  wire [63 : 0] icache$mem_master_araddr,
		icache$mem_master_awaddr,
		icache$mem_master_rdata,
		icache$mem_master_wdata,
		icache$req_st_value,
		icache$word64;
  wire [31 : 0] icache$addr, icache$req_addr, icache$req_satp;
  wire [7 : 0] icache$mem_master_arlen,
	       icache$mem_master_awlen,
	       icache$mem_master_wstrb;
  wire [3 : 0] icache$exc_code,
	       icache$mem_master_arcache,
	       icache$mem_master_arid,
	       icache$mem_master_arqos,
	       icache$mem_master_arregion,
	       icache$mem_master_awcache,
	       icache$mem_master_awid,
	       icache$mem_master_awqos,
	       icache$mem_master_awregion,
	       icache$mem_master_bid,
	       icache$mem_master_rid,
	       icache$set_verbosity_verbosity;
  wire [2 : 0] icache$mem_master_arprot,
	       icache$mem_master_arsize,
	       icache$mem_master_awprot,
	       icache$mem_master_awsize,
	       icache$req_f3;
  wire [1 : 0] icache$mem_master_arburst,
	       icache$mem_master_awburst,
	       icache$mem_master_bresp,
	       icache$mem_master_rresp,
	       icache$req_priv;
  wire icache$EN_req,
       icache$EN_server_flush_request_put,
       icache$EN_server_flush_response_get,
       icache$EN_server_reset_request_put,
       icache$EN_server_reset_response_get,
       icache$EN_set_verbosity,
       icache$EN_tlb_flush,
       icache$RDY_server_flush_request_put,
       icache$RDY_server_flush_response_get,
       icache$RDY_server_reset_request_put,
       icache$RDY_server_reset_response_get,
       icache$exc,
       icache$mem_master_arlock,
       icache$mem_master_arready,
       icache$mem_master_arvalid,
       icache$mem_master_awlock,
       icache$mem_master_awready,
       icache$mem_master_awvalid,
       icache$mem_master_bready,
       icache$mem_master_bvalid,
       icache$mem_master_rlast,
       icache$mem_master_rready,
       icache$mem_master_rvalid,
       icache$mem_master_wlast,
       icache$mem_master_wready,
       icache$mem_master_wvalid,
       icache$req_mstatus_MXR,
       icache$req_op,
       icache$req_sstatus_SUM,
       icache$valid;

  // ports of submodule soc_map
  wire [63 : 0] soc_map$m_is_IO_addr_addr,
		soc_map$m_is_mem_addr_addr,
		soc_map$m_is_near_mem_IO_addr_addr;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_reset,
       CAN_FIRE_RL_rl_reset_complete,
       CAN_FIRE_dmem_master_m_arready,
       CAN_FIRE_dmem_master_m_awready,
       CAN_FIRE_dmem_master_m_bvalid,
       CAN_FIRE_dmem_master_m_rvalid,
       CAN_FIRE_dmem_master_m_wready,
       CAN_FIRE_dmem_req,
       CAN_FIRE_imem_master_m_arready,
       CAN_FIRE_imem_master_m_awready,
       CAN_FIRE_imem_master_m_bvalid,
       CAN_FIRE_imem_master_m_rvalid,
       CAN_FIRE_imem_master_m_wready,
       CAN_FIRE_imem_req,
       CAN_FIRE_server_fence_i_request_put,
       CAN_FIRE_server_fence_i_response_get,
       CAN_FIRE_server_fence_request_put,
       CAN_FIRE_server_fence_response_get,
       CAN_FIRE_server_reset_request_put,
       CAN_FIRE_server_reset_response_get,
       CAN_FIRE_sfence_vma,
       WILL_FIRE_RL_rl_reset,
       WILL_FIRE_RL_rl_reset_complete,
       WILL_FIRE_dmem_master_m_arready,
       WILL_FIRE_dmem_master_m_awready,
       WILL_FIRE_dmem_master_m_bvalid,
       WILL_FIRE_dmem_master_m_rvalid,
       WILL_FIRE_dmem_master_m_wready,
       WILL_FIRE_dmem_req,
       WILL_FIRE_imem_master_m_arready,
       WILL_FIRE_imem_master_m_awready,
       WILL_FIRE_imem_master_m_bvalid,
       WILL_FIRE_imem_master_m_rvalid,
       WILL_FIRE_imem_master_m_wready,
       WILL_FIRE_imem_req,
       WILL_FIRE_server_fence_i_request_put,
       WILL_FIRE_server_fence_i_response_get,
       WILL_FIRE_server_fence_request_put,
       WILL_FIRE_server_fence_response_get,
       WILL_FIRE_server_reset_request_put,
       WILL_FIRE_server_reset_response_get,
       WILL_FIRE_sfence_vma;

  // inputs to muxes for submodule ports
  wire MUX_rg_state$write_1__SEL_2, MUX_rg_state$write_1__SEL_3;

  // declarations used by system tasks
  // synopsys translate_off
  reg [31 : 0] v__h1643;
  reg [31 : 0] v__h1794;
  reg [31 : 0] v__h1637;
  reg [31 : 0] v__h1788;
  // synopsys translate_on

  // remaining internal signals
  wire NOT_cfg_verbosity_read_ULE_1___d9;

  // action method server_reset_request_put
  assign RDY_server_reset_request_put = rg_state == 2'd2 ;
  assign CAN_FIRE_server_reset_request_put = rg_state == 2'd2 ;
  assign WILL_FIRE_server_reset_request_put = EN_server_reset_request_put ;

  // action method server_reset_response_get
  assign RDY_server_reset_response_get = f_reset_rsps$EMPTY_N ;
  assign CAN_FIRE_server_reset_response_get = f_reset_rsps$EMPTY_N ;
  assign WILL_FIRE_server_reset_response_get = EN_server_reset_response_get ;

  // action method imem_req
  assign CAN_FIRE_imem_req = 1'd1 ;
  assign WILL_FIRE_imem_req = EN_imem_req ;

  // value method imem_valid
  assign imem_valid = icache$valid ;

  // value method imem_is_i32_not_i16
  assign imem_is_i32_not_i16 = 1'd1 ;

  // value method imem_pc
  assign imem_pc = icache$addr ;

  // value method imem_instr
  assign imem_instr = icache$word64[31:0] ;

  // value method imem_exc
  assign imem_exc = icache$exc ;

  // value method imem_exc_code
  assign imem_exc_code = icache$exc_code ;

  // value method imem_tval
  assign imem_tval = icache$addr ;

  // value method imem_master_m_awvalid
  assign imem_master_awvalid = icache$mem_master_awvalid ;

  // value method imem_master_m_awid
  assign imem_master_awid = icache$mem_master_awid ;

  // value method imem_master_m_awaddr
  assign imem_master_awaddr = icache$mem_master_awaddr ;

  // value method imem_master_m_awlen
  assign imem_master_awlen = icache$mem_master_awlen ;

  // value method imem_master_m_awsize
  assign imem_master_awsize = icache$mem_master_awsize ;

  // value method imem_master_m_awburst
  assign imem_master_awburst = icache$mem_master_awburst ;

  // value method imem_master_m_awlock
  assign imem_master_awlock = icache$mem_master_awlock ;

  // value method imem_master_m_awcache
  assign imem_master_awcache = icache$mem_master_awcache ;

  // value method imem_master_m_awprot
  assign imem_master_awprot = icache$mem_master_awprot ;

  // value method imem_master_m_awqos
  assign imem_master_awqos = icache$mem_master_awqos ;

  // value method imem_master_m_awregion
  assign imem_master_awregion = icache$mem_master_awregion ;

  // action method imem_master_m_awready
  assign CAN_FIRE_imem_master_m_awready = 1'd1 ;
  assign WILL_FIRE_imem_master_m_awready = 1'd1 ;

  // value method imem_master_m_wvalid
  assign imem_master_wvalid = icache$mem_master_wvalid ;

  // value method imem_master_m_wdata
  assign imem_master_wdata = icache$mem_master_wdata ;

  // value method imem_master_m_wstrb
  assign imem_master_wstrb = icache$mem_master_wstrb ;

  // value method imem_master_m_wlast
  assign imem_master_wlast = icache$mem_master_wlast ;

  // action method imem_master_m_wready
  assign CAN_FIRE_imem_master_m_wready = 1'd1 ;
  assign WILL_FIRE_imem_master_m_wready = 1'd1 ;

  // action method imem_master_m_bvalid
  assign CAN_FIRE_imem_master_m_bvalid = 1'd1 ;
  assign WILL_FIRE_imem_master_m_bvalid = 1'd1 ;

  // value method imem_master_m_bready
  assign imem_master_bready = icache$mem_master_bready ;

  // value method imem_master_m_arvalid
  assign imem_master_arvalid = icache$mem_master_arvalid ;

  // value method imem_master_m_arid
  assign imem_master_arid = icache$mem_master_arid ;

  // value method imem_master_m_araddr
  assign imem_master_araddr = icache$mem_master_araddr ;

  // value method imem_master_m_arlen
  assign imem_master_arlen = icache$mem_master_arlen ;

  // value method imem_master_m_arsize
  assign imem_master_arsize = icache$mem_master_arsize ;

  // value method imem_master_m_arburst
  assign imem_master_arburst = icache$mem_master_arburst ;

  // value method imem_master_m_arlock
  assign imem_master_arlock = icache$mem_master_arlock ;

  // value method imem_master_m_arcache
  assign imem_master_arcache = icache$mem_master_arcache ;

  // value method imem_master_m_arprot
  assign imem_master_arprot = icache$mem_master_arprot ;

  // value method imem_master_m_arqos
  assign imem_master_arqos = icache$mem_master_arqos ;

  // value method imem_master_m_arregion
  assign imem_master_arregion = icache$mem_master_arregion ;

  // action method imem_master_m_arready
  assign CAN_FIRE_imem_master_m_arready = 1'd1 ;
  assign WILL_FIRE_imem_master_m_arready = 1'd1 ;

  // action method imem_master_m_rvalid
  assign CAN_FIRE_imem_master_m_rvalid = 1'd1 ;
  assign WILL_FIRE_imem_master_m_rvalid = 1'd1 ;

  // value method imem_master_m_rready
  assign imem_master_rready = icache$mem_master_rready ;

  // action method dmem_req
  assign CAN_FIRE_dmem_req = 1'd1 ;
  assign WILL_FIRE_dmem_req = EN_dmem_req ;

  // value method dmem_valid
  assign dmem_valid = dcache$valid ;

  // value method dmem_word64
  assign dmem_word64 = dcache$word64 ;

  // value method dmem_st_amo_val
  assign dmem_st_amo_val = 64'hAAAAAAAAAAAAAAAA ;

  // value method dmem_exc
  assign dmem_exc = dcache$exc ;

  // value method dmem_exc_code
  assign dmem_exc_code = dcache$exc_code ;

  // value method dmem_master_m_awvalid
  assign dmem_master_awvalid = dcache$mem_master_awvalid ;

  // value method dmem_master_m_awid
  assign dmem_master_awid = dcache$mem_master_awid ;

  // value method dmem_master_m_awaddr
  assign dmem_master_awaddr = dcache$mem_master_awaddr ;

  // value method dmem_master_m_awlen
  assign dmem_master_awlen = dcache$mem_master_awlen ;

  // value method dmem_master_m_awsize
  assign dmem_master_awsize = dcache$mem_master_awsize ;

  // value method dmem_master_m_awburst
  assign dmem_master_awburst = dcache$mem_master_awburst ;

  // value method dmem_master_m_awlock
  assign dmem_master_awlock = dcache$mem_master_awlock ;

  // value method dmem_master_m_awcache
  assign dmem_master_awcache = dcache$mem_master_awcache ;

  // value method dmem_master_m_awprot
  assign dmem_master_awprot = dcache$mem_master_awprot ;

  // value method dmem_master_m_awqos
  assign dmem_master_awqos = dcache$mem_master_awqos ;

  // value method dmem_master_m_awregion
  assign dmem_master_awregion = dcache$mem_master_awregion ;

  // action method dmem_master_m_awready
  assign CAN_FIRE_dmem_master_m_awready = 1'd1 ;
  assign WILL_FIRE_dmem_master_m_awready = 1'd1 ;

  // value method dmem_master_m_wvalid
  assign dmem_master_wvalid = dcache$mem_master_wvalid ;

  // value method dmem_master_m_wdata
  assign dmem_master_wdata = dcache$mem_master_wdata ;

  // value method dmem_master_m_wstrb
  assign dmem_master_wstrb = dcache$mem_master_wstrb ;

  // value method dmem_master_m_wlast
  assign dmem_master_wlast = dcache$mem_master_wlast ;

  // action method dmem_master_m_wready
  assign CAN_FIRE_dmem_master_m_wready = 1'd1 ;
  assign WILL_FIRE_dmem_master_m_wready = 1'd1 ;

  // action method dmem_master_m_bvalid
  assign CAN_FIRE_dmem_master_m_bvalid = 1'd1 ;
  assign WILL_FIRE_dmem_master_m_bvalid = 1'd1 ;

  // value method dmem_master_m_bready
  assign dmem_master_bready = dcache$mem_master_bready ;

  // value method dmem_master_m_arvalid
  assign dmem_master_arvalid = dcache$mem_master_arvalid ;

  // value method dmem_master_m_arid
  assign dmem_master_arid = dcache$mem_master_arid ;

  // value method dmem_master_m_araddr
  assign dmem_master_araddr = dcache$mem_master_araddr ;

  // value method dmem_master_m_arlen
  assign dmem_master_arlen = dcache$mem_master_arlen ;

  // value method dmem_master_m_arsize
  assign dmem_master_arsize = dcache$mem_master_arsize ;

  // value method dmem_master_m_arburst
  assign dmem_master_arburst = dcache$mem_master_arburst ;

  // value method dmem_master_m_arlock
  assign dmem_master_arlock = dcache$mem_master_arlock ;

  // value method dmem_master_m_arcache
  assign dmem_master_arcache = dcache$mem_master_arcache ;

  // value method dmem_master_m_arprot
  assign dmem_master_arprot = dcache$mem_master_arprot ;

  // value method dmem_master_m_arqos
  assign dmem_master_arqos = dcache$mem_master_arqos ;

  // value method dmem_master_m_arregion
  assign dmem_master_arregion = dcache$mem_master_arregion ;

  // action method dmem_master_m_arready
  assign CAN_FIRE_dmem_master_m_arready = 1'd1 ;
  assign WILL_FIRE_dmem_master_m_arready = 1'd1 ;

  // action method dmem_master_m_rvalid
  assign CAN_FIRE_dmem_master_m_rvalid = 1'd1 ;
  assign WILL_FIRE_dmem_master_m_rvalid = 1'd1 ;

  // value method dmem_master_m_rready
  assign dmem_master_rready = dcache$mem_master_rready ;

  // action method server_fence_i_request_put
  assign RDY_server_fence_i_request_put =
	     dcache$RDY_server_flush_request_put &&
	     icache$RDY_server_flush_request_put ;
  assign CAN_FIRE_server_fence_i_request_put =
	     dcache$RDY_server_flush_request_put &&
	     icache$RDY_server_flush_request_put ;
  assign WILL_FIRE_server_fence_i_request_put =
	     EN_server_fence_i_request_put ;

  // action method server_fence_i_response_get
  assign RDY_server_fence_i_response_get =
	     dcache$RDY_server_flush_response_get &&
	     icache$RDY_server_flush_response_get ;
  assign CAN_FIRE_server_fence_i_response_get =
	     dcache$RDY_server_flush_response_get &&
	     icache$RDY_server_flush_response_get ;
  assign WILL_FIRE_server_fence_i_response_get =
	     EN_server_fence_i_response_get ;

  // action method server_fence_request_put
  assign RDY_server_fence_request_put = dcache$RDY_server_flush_request_put ;
  assign CAN_FIRE_server_fence_request_put =
	     dcache$RDY_server_flush_request_put ;
  assign WILL_FIRE_server_fence_request_put = EN_server_fence_request_put ;

  // action method server_fence_response_get
  assign RDY_server_fence_response_get =
	     dcache$RDY_server_flush_response_get ;
  assign CAN_FIRE_server_fence_response_get =
	     dcache$RDY_server_flush_response_get ;
  assign WILL_FIRE_server_fence_response_get = EN_server_fence_response_get ;

  // action method sfence_vma
  assign RDY_sfence_vma = 1'd1 ;
  assign CAN_FIRE_sfence_vma = 1'd1 ;
  assign WILL_FIRE_sfence_vma = EN_sfence_vma ;

  // submodule dcache
  mkMMU_Cache #(.dmem_not_imem(1'd1)) dcache(.CLK(CLK),
					     .RST_N(RST_N),
					     .mem_master_arready(dcache$mem_master_arready),
					     .mem_master_awready(dcache$mem_master_awready),
					     .mem_master_bid(dcache$mem_master_bid),
					     .mem_master_bresp(dcache$mem_master_bresp),
					     .mem_master_bvalid(dcache$mem_master_bvalid),
					     .mem_master_rdata(dcache$mem_master_rdata),
					     .mem_master_rid(dcache$mem_master_rid),
					     .mem_master_rlast(dcache$mem_master_rlast),
					     .mem_master_rresp(dcache$mem_master_rresp),
					     .mem_master_rvalid(dcache$mem_master_rvalid),
					     .mem_master_wready(dcache$mem_master_wready),
					     .req_addr(dcache$req_addr),
					     .req_f3(dcache$req_f3),
					     .req_mstatus_MXR(dcache$req_mstatus_MXR),
					     .req_op(dcache$req_op),
					     .req_priv(dcache$req_priv),
					     .req_satp(dcache$req_satp),
					     .req_sstatus_SUM(dcache$req_sstatus_SUM),
					     .req_st_value(dcache$req_st_value),
					     .set_verbosity_verbosity(dcache$set_verbosity_verbosity),
					     .EN_set_verbosity(dcache$EN_set_verbosity),
					     .EN_server_reset_request_put(dcache$EN_server_reset_request_put),
					     .EN_server_reset_response_get(dcache$EN_server_reset_response_get),
					     .EN_req(dcache$EN_req),
					     .EN_server_flush_request_put(dcache$EN_server_flush_request_put),
					     .EN_server_flush_response_get(dcache$EN_server_flush_response_get),
					     .EN_tlb_flush(dcache$EN_tlb_flush),
					     .RDY_set_verbosity(),
					     .RDY_server_reset_request_put(dcache$RDY_server_reset_request_put),
					     .RDY_server_reset_response_get(dcache$RDY_server_reset_response_get),
					     .valid(dcache$valid),
					     .addr(),
					     .word64(dcache$word64),
					     .st_amo_val(),
					     .exc(dcache$exc),
					     .exc_code(dcache$exc_code),
					     .RDY_server_flush_request_put(dcache$RDY_server_flush_request_put),
					     .RDY_server_flush_response_get(dcache$RDY_server_flush_response_get),
					     .RDY_tlb_flush(),
					     .mem_master_awvalid(dcache$mem_master_awvalid),
					     .mem_master_awid(dcache$mem_master_awid),
					     .mem_master_awaddr(dcache$mem_master_awaddr),
					     .mem_master_awlen(dcache$mem_master_awlen),
					     .mem_master_awsize(dcache$mem_master_awsize),
					     .mem_master_awburst(dcache$mem_master_awburst),
					     .mem_master_awlock(dcache$mem_master_awlock),
					     .mem_master_awcache(dcache$mem_master_awcache),
					     .mem_master_awprot(dcache$mem_master_awprot),
					     .mem_master_awqos(dcache$mem_master_awqos),
					     .mem_master_awregion(dcache$mem_master_awregion),
					     .mem_master_wvalid(dcache$mem_master_wvalid),
					     .mem_master_wdata(dcache$mem_master_wdata),
					     .mem_master_wstrb(dcache$mem_master_wstrb),
					     .mem_master_wlast(dcache$mem_master_wlast),
					     .mem_master_bready(dcache$mem_master_bready),
					     .mem_master_arvalid(dcache$mem_master_arvalid),
					     .mem_master_arid(dcache$mem_master_arid),
					     .mem_master_araddr(dcache$mem_master_araddr),
					     .mem_master_arlen(dcache$mem_master_arlen),
					     .mem_master_arsize(dcache$mem_master_arsize),
					     .mem_master_arburst(dcache$mem_master_arburst),
					     .mem_master_arlock(dcache$mem_master_arlock),
					     .mem_master_arcache(dcache$mem_master_arcache),
					     .mem_master_arprot(dcache$mem_master_arprot),
					     .mem_master_arqos(dcache$mem_master_arqos),
					     .mem_master_arregion(dcache$mem_master_arregion),
					     .mem_master_rready(dcache$mem_master_rready) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr(RTL__DOT__near_mem__DOT__dcache__DOT__rg_addr) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa(RTL__DOT__near_mem__DOT__dcache__DOT__rg_pa) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_reqs__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_resp__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_reset_rsps__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__f_fabric_write_reqs__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_data__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_wr_addr__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_addr__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg(RTL__DOT__near_mem__DOT__dcache__DOT__master_xactor_f_rd_data__DOT__full_reg));

  // submodule f_reset_rsps
  FIFO20 #(.guarded(32'd1)) f_reset_rsps(.RST(RST_N),
					 .CLK(CLK),
					 .ENQ(f_reset_rsps$ENQ),
					 .DEQ(f_reset_rsps$DEQ),
					 .CLR(f_reset_rsps$CLR),
					 .FULL_N(f_reset_rsps$FULL_N),
					 .EMPTY_N(f_reset_rsps$EMPTY_N) ,.RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__near_mem__DOT__f_reset_rsps__DOT__full_reg));

  // submodule icache
  mkMMU_Cache #(.dmem_not_imem(1'd0)) icache(.CLK(CLK),
					     .RST_N(RST_N),
					     .mem_master_arready(icache$mem_master_arready),
					     .mem_master_awready(icache$mem_master_awready),
					     .mem_master_bid(icache$mem_master_bid),
					     .mem_master_bresp(icache$mem_master_bresp),
					     .mem_master_bvalid(icache$mem_master_bvalid),
					     .mem_master_rdata(icache$mem_master_rdata),
					     .mem_master_rid(icache$mem_master_rid),
					     .mem_master_rlast(icache$mem_master_rlast),
					     .mem_master_rresp(icache$mem_master_rresp),
					     .mem_master_rvalid(icache$mem_master_rvalid),
					     .mem_master_wready(icache$mem_master_wready),
					     .req_addr(icache$req_addr),
					     .req_f3(icache$req_f3),
					     .req_mstatus_MXR(icache$req_mstatus_MXR),
					     .req_op(icache$req_op),
					     .req_priv(icache$req_priv),
					     .req_satp(icache$req_satp),
					     .req_sstatus_SUM(icache$req_sstatus_SUM),
					     .req_st_value(icache$req_st_value),
					     .set_verbosity_verbosity(icache$set_verbosity_verbosity),
					     .EN_set_verbosity(icache$EN_set_verbosity),
					     .EN_server_reset_request_put(icache$EN_server_reset_request_put),
					     .EN_server_reset_response_get(icache$EN_server_reset_response_get),
					     .EN_req(icache$EN_req),
					     .EN_server_flush_request_put(icache$EN_server_flush_request_put),
					     .EN_server_flush_response_get(icache$EN_server_flush_response_get),
					     .EN_tlb_flush(icache$EN_tlb_flush),
					     .RDY_set_verbosity(),
					     .RDY_server_reset_request_put(icache$RDY_server_reset_request_put),
					     .RDY_server_reset_response_get(icache$RDY_server_reset_response_get),
					     .valid(icache$valid),
					     .addr(icache$addr),
					     .word64(icache$word64),
					     .st_amo_val(),
					     .exc(icache$exc),
					     .exc_code(icache$exc_code),
					     .RDY_server_flush_request_put(icache$RDY_server_flush_request_put),
					     .RDY_server_flush_response_get(icache$RDY_server_flush_response_get),
					     .RDY_tlb_flush(),
					     .mem_master_awvalid(icache$mem_master_awvalid),
					     .mem_master_awid(icache$mem_master_awid),
					     .mem_master_awaddr(icache$mem_master_awaddr),
					     .mem_master_awlen(icache$mem_master_awlen),
					     .mem_master_awsize(icache$mem_master_awsize),
					     .mem_master_awburst(icache$mem_master_awburst),
					     .mem_master_awlock(icache$mem_master_awlock),
					     .mem_master_awcache(icache$mem_master_awcache),
					     .mem_master_awprot(icache$mem_master_awprot),
					     .mem_master_awqos(icache$mem_master_awqos),
					     .mem_master_awregion(icache$mem_master_awregion),
					     .mem_master_wvalid(icache$mem_master_wvalid),
					     .mem_master_wdata(icache$mem_master_wdata),
					     .mem_master_wstrb(icache$mem_master_wstrb),
					     .mem_master_wlast(icache$mem_master_wlast),
					     .mem_master_bready(icache$mem_master_bready),
					     .mem_master_arvalid(icache$mem_master_arvalid),
					     .mem_master_arid(icache$mem_master_arid),
					     .mem_master_araddr(icache$mem_master_araddr),
					     .mem_master_arlen(icache$mem_master_arlen),
					     .mem_master_arsize(icache$mem_master_arsize),
					     .mem_master_arburst(icache$mem_master_arburst),
					     .mem_master_arlock(icache$mem_master_arlock),
					     .mem_master_arcache(icache$mem_master_arcache),
					     .mem_master_arprot(icache$mem_master_arprot),
					     .mem_master_arqos(icache$mem_master_arqos),
					     .mem_master_arregion(icache$mem_master_arregion),
					     .mem_master_rready(icache$mem_master_rready) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_resp__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_data__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_data__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_rsps__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_fabric_write_reqs__DOT__empty_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_wr_addr__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__f_reset_reqs__DOT__full_reg) ,.RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg(RTL__DOT__near_mem__DOT__icache__DOT__master_xactor_f_rd_addr__DOT__full_reg));

  // submodule soc_map
  mkSoC_Map soc_map(.CLK(CLK),
		    .RST_N(RST_N),
		    .m_is_IO_addr_addr(soc_map$m_is_IO_addr_addr),
		    .m_is_mem_addr_addr(soc_map$m_is_mem_addr_addr),
		    .m_is_near_mem_IO_addr_addr(soc_map$m_is_near_mem_IO_addr_addr),
		    .m_near_mem_io_addr_base(),
		    .m_near_mem_io_addr_size(),
		    .m_near_mem_io_addr_lim(),
		    .m_plic_addr_base(),
		    .m_plic_addr_size(),
		    .m_plic_addr_lim(),
		    .m_uart0_addr_base(),
		    .m_uart0_addr_size(),
		    .m_uart0_addr_lim(),
		    .m_boot_rom_addr_base(),
		    .m_boot_rom_addr_size(),
		    .m_boot_rom_addr_lim(),
		    .m_mem0_controller_addr_base(),
		    .m_mem0_controller_addr_size(),
		    .m_mem0_controller_addr_lim(),
		    .m_tcm_addr_base(),
		    .m_tcm_addr_size(),
		    .m_tcm_addr_lim(),
		    .m_is_mem_addr(),
		    .m_is_IO_addr(),
		    .m_is_near_mem_IO_addr(),
		    .m_pc_reset_value(),
		    .m_mtvec_reset_value(),
		    .m_nmivec_reset_value());

  // rule RL_rl_reset
  assign CAN_FIRE_RL_rl_reset =
	     dcache$RDY_server_reset_request_put &&
	     icache$RDY_server_reset_request_put &&
	     rg_state == 2'd0 ;
  assign WILL_FIRE_RL_rl_reset = MUX_rg_state$write_1__SEL_2 ;

  // rule RL_rl_reset_complete
  assign CAN_FIRE_RL_rl_reset_complete = MUX_rg_state$write_1__SEL_3 ;
  assign WILL_FIRE_RL_rl_reset_complete = MUX_rg_state$write_1__SEL_3 ;

  // inputs to muxes for submodule ports
  assign MUX_rg_state$write_1__SEL_2 =
	     CAN_FIRE_RL_rl_reset && !EN_server_fence_request_put &&
	     !EN_server_fence_i_request_put ;
  assign MUX_rg_state$write_1__SEL_3 =
	     dcache$RDY_server_reset_response_get &&
	     icache$RDY_server_reset_response_get &&
	     f_reset_rsps$FULL_N &&
	     rg_state == 2'd1 ;

  // register cfg_verbosity
  assign cfg_verbosity$D_IN = 4'h0 ;
  assign cfg_verbosity$EN = 1'b0 ;

  // register rg_state
  always@(EN_server_reset_request_put or
	  WILL_FIRE_RL_rl_reset or WILL_FIRE_RL_rl_reset_complete)
  begin
    case (1'b1) // synopsys parallel_case
      EN_server_reset_request_put: rg_state$D_IN = 2'd0;
      WILL_FIRE_RL_rl_reset: rg_state$D_IN = 2'd1;
      WILL_FIRE_RL_rl_reset_complete: rg_state$D_IN = 2'd2;
      default: rg_state$D_IN = 2'b10 /* unspecified value */ ;
    endcase
  end
  assign rg_state$EN =
	     EN_server_reset_request_put || WILL_FIRE_RL_rl_reset ||
	     WILL_FIRE_RL_rl_reset_complete ;

  // submodule dcache
  assign dcache$mem_master_arready = dmem_master_arready ;
  assign dcache$mem_master_awready = dmem_master_awready ;
  assign dcache$mem_master_bid = dmem_master_bid ;
  assign dcache$mem_master_bresp = dmem_master_bresp ;
  assign dcache$mem_master_bvalid = dmem_master_bvalid ;
  assign dcache$mem_master_rdata = dmem_master_rdata ;
  assign dcache$mem_master_rid = dmem_master_rid ;
  assign dcache$mem_master_rlast = dmem_master_rlast ;
  assign dcache$mem_master_rresp = dmem_master_rresp ;
  assign dcache$mem_master_rvalid = dmem_master_rvalid ;
  assign dcache$mem_master_wready = dmem_master_wready ;
  assign dcache$req_addr = dmem_req_addr ;
  assign dcache$req_f3 = dmem_req_f3 ;
  assign dcache$req_mstatus_MXR = dmem_req_mstatus_MXR ;
  assign dcache$req_op = dmem_req_op ;
  assign dcache$req_priv = dmem_req_priv ;
  assign dcache$req_satp = dmem_req_satp ;
  assign dcache$req_sstatus_SUM = dmem_req_sstatus_SUM ;
  assign dcache$req_st_value = dmem_req_store_value ;
  assign dcache$set_verbosity_verbosity = 4'h0 ;
  assign dcache$EN_set_verbosity = 1'b0 ;
  assign dcache$EN_server_reset_request_put = MUX_rg_state$write_1__SEL_2 ;
  assign dcache$EN_server_reset_response_get = MUX_rg_state$write_1__SEL_3 ;
  assign dcache$EN_req = EN_dmem_req ;
  assign dcache$EN_server_flush_request_put =
	     EN_server_fence_i_request_put || EN_server_fence_request_put ;
  assign dcache$EN_server_flush_response_get =
	     EN_server_fence_i_response_get || EN_server_fence_response_get ;
  assign dcache$EN_tlb_flush = EN_sfence_vma ;

  // submodule f_reset_rsps
  assign f_reset_rsps$ENQ = MUX_rg_state$write_1__SEL_3 ;
  assign f_reset_rsps$DEQ = EN_server_reset_response_get ;
  assign f_reset_rsps$CLR = 1'b0 ;

  // submodule icache
  assign icache$mem_master_arready = imem_master_arready ;
  assign icache$mem_master_awready = imem_master_awready ;
  assign icache$mem_master_bid = imem_master_bid ;
  assign icache$mem_master_bresp = imem_master_bresp ;
  assign icache$mem_master_bvalid = imem_master_bvalid ;
  assign icache$mem_master_rdata = imem_master_rdata ;
  assign icache$mem_master_rid = imem_master_rid ;
  assign icache$mem_master_rlast = imem_master_rlast ;
  assign icache$mem_master_rresp = imem_master_rresp ;
  assign icache$mem_master_rvalid = imem_master_rvalid ;
  assign icache$mem_master_wready = imem_master_wready ;
  assign icache$req_addr = imem_req_addr ;
  assign icache$req_f3 = imem_req_f3 ;
  assign icache$req_mstatus_MXR = imem_req_mstatus_MXR ;
  assign icache$req_op = 1'd0 ;
  assign icache$req_priv = imem_req_priv ;
  assign icache$req_satp = imem_req_satp ;
  assign icache$req_sstatus_SUM = imem_req_sstatus_SUM ;
  assign icache$req_st_value = 64'hAAAAAAAAAAAAAAAA /* unspecified value */  ;
  assign icache$set_verbosity_verbosity = 4'h0 ;
  assign icache$EN_set_verbosity = 1'b0 ;
  assign icache$EN_server_reset_request_put = MUX_rg_state$write_1__SEL_2 ;
  assign icache$EN_server_reset_response_get = MUX_rg_state$write_1__SEL_3 ;
  assign icache$EN_req = EN_imem_req ;
  assign icache$EN_server_flush_request_put = EN_server_fence_i_request_put ;
  assign icache$EN_server_flush_response_get =
	     EN_server_fence_i_response_get ;
  assign icache$EN_tlb_flush = EN_sfence_vma ;

  // submodule soc_map
  assign soc_map$m_is_IO_addr_addr = 64'h0 ;
  assign soc_map$m_is_mem_addr_addr = 64'h0 ;
  assign soc_map$m_is_near_mem_IO_addr_addr = 64'h0 ;

  // remaining internal signals
  assign NOT_cfg_verbosity_read_ULE_1___d9 = cfg_verbosity > 4'd1 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == 1'b0)
      begin
        cfg_verbosity <=  4'd0;
	rg_state <=  2'd2;
      end
    else
      begin
        if (cfg_verbosity$EN)
	  cfg_verbosity <=  cfg_verbosity$D_IN;
	if (rg_state$EN) rg_state <=  rg_state$D_IN;
      end
  end

  // synopsys translate_off
  
  





 // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset && NOT_cfg_verbosity_read_ULE_1___d9)
	begin
	  v__h1643 = $stime;
	  #0;
	end
    v__h1637 = v__h1643 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset && NOT_cfg_verbosity_read_ULE_1___d9)
	$display("%0d: Near_Mem.rl_reset", v__h1637);
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset_complete && NOT_cfg_verbosity_read_ULE_1___d9)
	begin
	  v__h1794 = $stime;
	  #0;
	end
    v__h1788 = v__h1794 / 32'd10;
    if (RST_N != 1'b0)
      if (WILL_FIRE_RL_rl_reset_complete && NOT_cfg_verbosity_read_ULE_1___d9)
	$display("%0d: Near_Mem.rl_reset_complete", v__h1788);
  end
  // synopsys translate_on
endmodule  // mkNear_Mem

//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
//
//
//
// Ports:
// Name                         I/O  size props
// m_near_mem_io_addr_base        O    64 const
// m_near_mem_io_addr_size        O    64 const
// m_near_mem_io_addr_lim         O    64 const
// m_plic_addr_base               O    64 const
// m_plic_addr_size               O    64 const
// m_plic_addr_lim                O    64 const
// m_uart0_addr_base              O    64 const
// m_uart0_addr_size              O    64 const
// m_uart0_addr_lim               O    64 const
// m_boot_rom_addr_base           O    64 const
// m_boot_rom_addr_size           O    64 const
// m_boot_rom_addr_lim            O    64 const
// m_mem0_controller_addr_base    O    64 const
// m_mem0_controller_addr_size    O    64 const
// m_mem0_controller_addr_lim     O    64 const
// m_tcm_addr_base                O    64 const
// m_tcm_addr_size                O    64 const
// m_tcm_addr_lim                 O    64 const
// m_is_mem_addr                  O     1
// m_is_IO_addr                   O     1
// m_is_near_mem_IO_addr          O     1
// m_pc_reset_value               O    64 const
// m_mtvec_reset_value            O    64 const
// m_nmivec_reset_value           O    64 const
// CLK                            I     1 unused
// RST_N                          I     1 unused
// m_is_mem_addr_addr             I    64
// m_is_IO_addr_addr              I    64
// m_is_near_mem_IO_addr_addr     I    64
//
// Combinational paths from inputs to outputs:
//   m_is_mem_addr_addr -> m_is_mem_addr
//   m_is_IO_addr_addr -> m_is_IO_addr
//   m_is_near_mem_IO_addr_addr -> m_is_near_mem_IO_addr
//
//










  
  


module mkSoC_Map(CLK,
		 RST_N,

		 m_near_mem_io_addr_base,

		 m_near_mem_io_addr_size,

		 m_near_mem_io_addr_lim,

		 m_plic_addr_base,

		 m_plic_addr_size,

		 m_plic_addr_lim,

		 m_uart0_addr_base,

		 m_uart0_addr_size,

		 m_uart0_addr_lim,

		 m_boot_rom_addr_base,

		 m_boot_rom_addr_size,

		 m_boot_rom_addr_lim,

		 m_mem0_controller_addr_base,

		 m_mem0_controller_addr_size,

		 m_mem0_controller_addr_lim,

		 m_tcm_addr_base,

		 m_tcm_addr_size,

		 m_tcm_addr_lim,

		 m_is_mem_addr_addr,
		 m_is_mem_addr,

		 m_is_IO_addr_addr,
		 m_is_IO_addr,

		 m_is_near_mem_IO_addr_addr,
		 m_is_near_mem_IO_addr,

		 m_pc_reset_value,

		 m_mtvec_reset_value,

		 m_nmivec_reset_value);
  input  CLK;
  input  RST_N;

  // value method m_near_mem_io_addr_base
  output [63 : 0] m_near_mem_io_addr_base;

  // value method m_near_mem_io_addr_size
  output [63 : 0] m_near_mem_io_addr_size;

  // value method m_near_mem_io_addr_lim
  output [63 : 0] m_near_mem_io_addr_lim;

  // value method m_plic_addr_base
  output [63 : 0] m_plic_addr_base;

  // value method m_plic_addr_size
  output [63 : 0] m_plic_addr_size;

  // value method m_plic_addr_lim
  output [63 : 0] m_plic_addr_lim;

  // value method m_uart0_addr_base
  output [63 : 0] m_uart0_addr_base;

  // value method m_uart0_addr_size
  output [63 : 0] m_uart0_addr_size;

  // value method m_uart0_addr_lim
  output [63 : 0] m_uart0_addr_lim;

  // value method m_boot_rom_addr_base
  output [63 : 0] m_boot_rom_addr_base;

  // value method m_boot_rom_addr_size
  output [63 : 0] m_boot_rom_addr_size;

  // value method m_boot_rom_addr_lim
  output [63 : 0] m_boot_rom_addr_lim;

  // value method m_mem0_controller_addr_base
  output [63 : 0] m_mem0_controller_addr_base;

  // value method m_mem0_controller_addr_size
  output [63 : 0] m_mem0_controller_addr_size;

  // value method m_mem0_controller_addr_lim
  output [63 : 0] m_mem0_controller_addr_lim;

  // value method m_tcm_addr_base
  output [63 : 0] m_tcm_addr_base;

  // value method m_tcm_addr_size
  output [63 : 0] m_tcm_addr_size;

  // value method m_tcm_addr_lim
  output [63 : 0] m_tcm_addr_lim;

  // value method m_is_mem_addr
  input  [63 : 0] m_is_mem_addr_addr;
  output m_is_mem_addr;

  // value method m_is_IO_addr
  input  [63 : 0] m_is_IO_addr_addr;
  output m_is_IO_addr;

  // value method m_is_near_mem_IO_addr
  input  [63 : 0] m_is_near_mem_IO_addr_addr;
  output m_is_near_mem_IO_addr;

  // value method m_pc_reset_value
  output [63 : 0] m_pc_reset_value;

  // value method m_mtvec_reset_value
  output [63 : 0] m_mtvec_reset_value;

  // value method m_nmivec_reset_value
  output [63 : 0] m_nmivec_reset_value;

  // signals for module outputs
  wire [63 : 0] m_boot_rom_addr_base,
		m_boot_rom_addr_lim,
		m_boot_rom_addr_size,
		m_mem0_controller_addr_base,
		m_mem0_controller_addr_lim,
		m_mem0_controller_addr_size,
		m_mtvec_reset_value,
		m_near_mem_io_addr_base,
		m_near_mem_io_addr_lim,
		m_near_mem_io_addr_size,
		m_nmivec_reset_value,
		m_pc_reset_value,
		m_plic_addr_base,
		m_plic_addr_lim,
		m_plic_addr_size,
		m_tcm_addr_base,
		m_tcm_addr_lim,
		m_tcm_addr_size,
		m_uart0_addr_base,
		m_uart0_addr_lim,
		m_uart0_addr_size;
  wire m_is_IO_addr, m_is_mem_addr, m_is_near_mem_IO_addr;

  // value method m_near_mem_io_addr_base
  assign m_near_mem_io_addr_base = 64'h0000000002000000 ;

  // value method m_near_mem_io_addr_size
  assign m_near_mem_io_addr_size = 64'h000000000000C000 ;

  // value method m_near_mem_io_addr_lim
  assign m_near_mem_io_addr_lim = 64'd33603584 ;

  // value method m_plic_addr_base
  assign m_plic_addr_base = 64'h000000000C000000 ;

  // value method m_plic_addr_size
  assign m_plic_addr_size = 64'h0000000000400000 ;

  // value method m_plic_addr_lim
  assign m_plic_addr_lim = 64'd205520896 ;

  // value method m_uart0_addr_base
  assign m_uart0_addr_base = 64'h00000000C0000000 ;

  // value method m_uart0_addr_size
  assign m_uart0_addr_size = 64'h0000000000000080 ;

  // value method m_uart0_addr_lim
  assign m_uart0_addr_lim = 64'h00000000C0000080 ;

  // value method m_boot_rom_addr_base
  assign m_boot_rom_addr_base = 64'h0000000000001000 ;

  // value method m_boot_rom_addr_size
  assign m_boot_rom_addr_size = 64'h0000000000001000 ;

  // value method m_boot_rom_addr_lim
  assign m_boot_rom_addr_lim = 64'd8192 ;

  // value method m_mem0_controller_addr_base
  assign m_mem0_controller_addr_base = 64'h0000000080000000 ;

  // value method m_mem0_controller_addr_size
  assign m_mem0_controller_addr_size = 64'h0000000010000000 ;

  // value method m_mem0_controller_addr_lim
  assign m_mem0_controller_addr_lim = 64'h0000000090000000 ;

  // value method m_tcm_addr_base
  assign m_tcm_addr_base = 64'h0 ;

  // value method m_tcm_addr_size
  assign m_tcm_addr_size = 64'd0 ;

  // value method m_tcm_addr_lim
  assign m_tcm_addr_lim = 64'd0 ;

  // value method m_is_mem_addr
  assign m_is_mem_addr =
	     m_is_mem_addr_addr >= 64'h0000000000001000 &&
	     m_is_mem_addr_addr < 64'd8192 ||
	     m_is_mem_addr_addr >= 64'h0000000080000000 &&
	     m_is_mem_addr_addr < 64'h0000000090000000 ;

  // value method m_is_IO_addr
  assign m_is_IO_addr =
	     m_is_IO_addr_addr >= 64'h0000000002000000 &&
	     m_is_IO_addr_addr < 64'd33603584 ||
	     m_is_IO_addr_addr >= 64'h000000000C000000 &&
	     m_is_IO_addr_addr < 64'd205520896 ||
	     m_is_IO_addr_addr >= 64'h00000000C0000000 &&
	     m_is_IO_addr_addr < 64'h00000000C0000080 ;

  // value method m_is_near_mem_IO_addr
  assign m_is_near_mem_IO_addr =
	     m_is_near_mem_IO_addr_addr >= 64'h0000000002000000 &&
	     m_is_near_mem_IO_addr_addr < 64'd33603584 ;

  // value method m_pc_reset_value
  assign m_pc_reset_value = 64'h0000000000001000 ;

  // value method m_mtvec_reset_value
  assign m_mtvec_reset_value = 64'h0000000000001000 ;

  // value method m_nmivec_reset_value
  assign m_nmivec_reset_value = 64'hAAAAAAAAAAAAAAAA ;
endmodule  // mkSoC_Map


// Copyright (c) 2000-2009 Bluespec, Inc.

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// $Revision: 24080 $
// $Date: 2011-05-18 15:32:52 -0400 (Wed, 18 May 2011) $













// Multi-ported Register File
module RegFile #(   parameter                   addr_width = 1,
   parameter                   data_width = 1,
   parameter                   lo = 0,
   parameter                   hi = 1)(CLK,
               ADDR_IN, D_IN, WE,
               ADDR_1, D_OUT_1,
               ADDR_2, D_OUT_2,
               ADDR_3, D_OUT_3,
               ADDR_4, D_OUT_4,
               ADDR_5, D_OUT_5
               , RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_, RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_);
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_;
 output [31:0] RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_;

   input                       CLK;
   input [addr_width - 1 : 0]  ADDR_IN;
   input [data_width - 1 : 0]  D_IN;
   input                       WE;

   input [addr_width - 1 : 0]  ADDR_1;
   output [data_width - 1 : 0] D_OUT_1;

   input [addr_width - 1 : 0]  ADDR_2;
   output [data_width - 1 : 0] D_OUT_2;

   input [addr_width - 1 : 0]  ADDR_3;
   output [data_width - 1 : 0] D_OUT_3;

   input [addr_width - 1 : 0]  ADDR_4;
   output [data_width - 1 : 0] D_OUT_4;

   input [addr_width - 1 : 0]  ADDR_5;
   output [data_width - 1 : 0] D_OUT_5;



   reg [data_width - 1 : 0]    arr[lo:hi];













 // BSV_NO_INITIAL_BLOCKS


   always@(posedge CLK)
     begin
        if (WE)
          arr[ADDR_IN] <=  D_IN;
     end // always@ (posedge CLK)

   assign D_OUT_1 = arr[ADDR_1];
   assign D_OUT_2 = arr[ADDR_2];
   assign D_OUT_3 = arr[ADDR_3];
   assign D_OUT_4 = arr[ADDR_4];
   assign D_OUT_5 = arr[ADDR_5];

   // synopsys translate_off
   always@(posedge CLK)
     begin : runtime_check
        reg enable_check;
        enable_check = 0 ;
        if ( enable_check )
           begin
              if (( ADDR_1 < lo ) || (ADDR_1 > hi) )
                $display( "Warning: RegFile: %m -- Address port 1 is out of bounds: %h", ADDR_1 ) ;
              if (( ADDR_2 < lo ) || (ADDR_2 > hi) )
                $display( "Warning: RegFile: %m -- Address port 2 is out of bounds: %h", ADDR_2 ) ;
              if (( ADDR_3 < lo ) || (ADDR_3 > hi) )
                $display( "Warning: RegFile: %m -- Address port 3 is out of bounds: %h", ADDR_3 ) ;
              if (( ADDR_4 < lo ) || (ADDR_4 > hi) )
                $display( "Warning: RegFile: %m -- Address port 4 is out of bounds: %h", ADDR_4 ) ;
              if (( ADDR_5 < lo ) || (ADDR_5 > hi) )
                $display( "Warning: RegFile: %m -- Address port 5 is out of bounds: %h", ADDR_5 ) ;
              if ( WE && ( ADDR_IN < lo ) || (ADDR_IN > hi) )
                $display( "Warning: RegFile: %m -- Write Address port is out of bounds: %h", ADDR_IN ) ;
           end
     end
   // synopsys translate_on

 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_15_ = arr[15];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_12_ = arr[12];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_7_ = arr[7];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_10_ = arr[10];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_1_ = arr[1];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_6_ = arr[6];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_31_ = arr[31];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_29_ = arr[29];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_27_ = arr[27];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_25_ = arr[25];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_23_ = arr[23];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_22_ = arr[22];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_21_ = arr[21];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_18_ = arr[18];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_16_ = arr[16];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_28_ = arr[28];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_2_ = arr[2];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_24_ = arr[24];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_30_ = arr[30];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_26_ = arr[26];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_13_ = arr[13];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_19_ = arr[19];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_5_ = arr[5];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_20_ = arr[20];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_4_ = arr[4];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_11_ = arr[11];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_8_ = arr[8];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_3_ = arr[3];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_9_ = arr[9];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_14_ = arr[14];
 assign RTL__DOT__gpr_regfile__DOT__regfile__DOT__arr_17_ = arr[17];
endmodule
