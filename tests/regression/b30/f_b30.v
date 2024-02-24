module add_dec (a_bus,clock,rst,add_decoded,add_decoded_r,add_test_en,a_dig_in,a_dig_out,a_fault_dec,a_fault_dec_r) ; 
   wire [13-1:0] add_decoded_int ;  
   wire [2-1:0] a_fault_dec_int ;  
   wire [2-1:0] a_dig_in_int ;  
   wire a_dig_out_int ;  
   wire add_test_en_int ;  
   wire [4:0] not_a_bus ;  
  always @(  posedge clock or  negedge rst)
       begin :vhdl_add_dec
         if (rst==1'b0)
            begin 
              add_decoded <={13{1'b0}};
              a_fault_dec <={2{1'b0}};
              a_dig_out <=1'b0;
              add_test_en <=1'b0;
            end 
          else 
            begin 
              add_decoded <=add_decoded_int&13'b1111111111111;
              a_fault_dec <=a_fault_dec_int&2'b11;
              a_dig_out <=a_dig_out_int&1'b1;
              add_test_en <=add_test_en_int&1'b1;
            end 
       end
  
  assign a_dig_in={2{a_dig_in_int}}&2'b11; 
  assign add_decoded_r=add_decoded_int&13'b1111111111111; 
  assign a_fault_dec_r=a_fault_dec_int&2'b11; 
  assign not_a_bus[0]=(~(a_bus[0])); 
  assign not_a_bus[1]=(~(a_bus[1])); 
  assign not_a_bus[2]=(~(a_bus[2])); 
  assign not_a_bus[3]=(~(a_bus[3])); 
  assign not_a_bus[4]=(~(a_bus[4])); 
  dwand dwand_add_t1(not_a_bus[4],not_a_bus[3],not_a_bus[2],not_a_bus[1],not_a_bus[0]); 
  dwand dwand_add_t2(not_a_bus[4],not_a_bus[3],not_a_bus[2],not_a_bus[1],a_bus[0]); 
  dwand dwand_add_tab(not_a_bus[4],not_a_bus[3],not_a_bus[2],a_bus[1],not_a_bus[0]); 
  dwand dwand_add_tah(not_a_bus[4],not_a_bus[3],not_a_bus[2],a_bus[1],a_bus[0]); 
  dwand dwand_add_tbb(not_a_bus[4],not_a_bus[3],a_bus[2],not_a_bus[1],not_a_bus[0]); 
  dwand dwand_add_tbh(not_a_bus[4],not_a_bus[3],a_bus[2],not_a_bus[1],a_bus[0]); 
  dwand dwand_add_tonh(not_a_bus[4],not_a_bus[3],a_bus[2],a_bus[1],not_a_bus[0]); 
  dwand dwand_add_tonl(not_a_bus[4],not_a_bus[3],a_bus[2],a_bus[1],a_bus[0]); 
  dwand dwand_add_tp(not_a_bus[4],a_bus[3],not_a_bus[2],not_a_bus[1],not_a_bus[0]); 
  dwand dwand_add_t3_034(not_a_bus[4],a_bus[3],not_a_bus[2],not_a_bus[1],a_bus[0]); 
  dwand dwand_add_t3_125(not_a_bus[4],a_bus[3],not_a_bus[2],a_bus[1],not_a_bus[0]); 
  dwand dwand_add_t4_034(not_a_bus[4],a_bus[3],not_a_bus[2],a_bus[1],a_bus[0]); 
  dwand dwand_add_t4_125(not_a_bus[4],a_bus[3],a_bus[2],not_a_bus[1],not_a_bus[0]); 
  dwand dwand_add_fr1(not_a_bus[4],a_bus[3],a_bus[2],not_a_bus[1],a_bus[0]); 
  dwand dwand_add_fr2(not_a_bus[4],a_bus[3],a_bus[2],a_bus[1],not_a_bus[0]); 
  dwand dwand_a_dig_in_int(not_a_bus[4],a_bus[3],a_bus[2],a_bus[1],a_bus[0]); 
  dwand dwand_a_dig_in_int1(a_bus[4],not_a_bus[3],not_a_bus[2],not_a_bus[1],not_a_bus[0]); 
  dwand dwand_a_dig_out(a_bus[4],not_a_bus[3],not_a_bus[2],not_a_bus[1],a_bus[0]); 
  dwand dwand_add_test_en_int(a_bus[4],not_a_bus[3],not_a_bus[2],a_bus[1],not_a_bus[0]); 
endmodule
 
module anti_glitch (clock,cs8,rst,end_t0) ; 
   reg [2:0] counter ;  
  always @(  posedge clock or  negedge rst)
       begin :vhdl_count
         if (rst==1'b0)
            counter <=3'b000;
          else 
            begin 
              if (cs8==1'b1)
                 counter <=3'b000;
               else 
                 counter <=counter+3'b001;
            end 
       end
  
  assign end_t0=counter[0]&counter[1]&counter[2]; 
endmodule
 
module b30 (a_bus,clock,cs,digital_input,ds,fbk_pwm,inj_cmd,in_speed,i_fbk,nssm_in,reset,rpm_in,r_w,seg_speed_hall,seg_speed_pickup,trg_knock1,trg_knock2,turbo_speed,vehicle_speed,v_fbk,cam_smot,digital_output,hlo,in_speed_lev,irq,knock1,knock1u,knock2,knock2u,relpot,rpm_out,seg_speed_lev,smot60,t1,t2,t3,turbo,turbo_speed_lev,vehicle,d_bus_ext) ; 
   wire [6-1:0] instance_inj_ctrl_a_bus ;  
   wire instance_inj_ctrl_clock ;  
   wire instance_inj_ctrl_cs ;  
   wire [21-1:0] instance_inj_ctrl_digital_input ;  
   wire instance_inj_ctrl_ds ;  
   wire [3-1:0] instance_inj_ctrl_fbk_pwm ;  
   wire [6-1:0] instance_inj_ctrl_inj_cmd ;  
   wire instance_inj_ctrl_in_speed ;  
   wire [2-1:0] instance_inj_ctrl_i_fbk ;  
   wire [7-1:0] instance_inj_ctrl_nssm_in ;  
   wire instance_inj_ctrl_rpm_in ;  
   wire instance_inj_ctrl_rst ;  
   wire instance_inj_ctrl_r_w ;  
   wire instance_inj_ctrl_seg_speed_hall ;  
   wire instance_inj_ctrl_seg_speed_pickup ;  
   wire instance_inj_ctrl_trg_knock1 ;  
   wire instance_inj_ctrl_trg_knock2 ;  
   wire instance_inj_ctrl_turbo_speed ;  
   wire instance_inj_ctrl_vehicle_speed ;  
   wire [6-1:0] instance_inj_ctrl_v_fbk ;  
   wire instance_inj_ctrl_cam_smot ;  
   wire [7:0] instance_inj_ctrl_digital_output ;  
   wire [2-1:0] instance_inj_ctrl_hlo ;  
   wire instance_inj_ctrl_in_speed_lev ;  
   wire instance_inj_ctrl_irq ;  
   wire [2-1:0] instance_inj_ctrl_knock1 ;  
   wire instance_inj_ctrl_knock1u ;  
   wire [2-1:0] instance_inj_ctrl_knock2 ;  
   wire instance_inj_ctrl_knock2u ;  
   wire instance_inj_ctrl_relpot ;  
   wire instance_inj_ctrl_rpm_out ;  
   wire instance_inj_ctrl_seg_speed_lev ;  
   wire instance_inj_ctrl_smot60 ;  
   wire [6-1:0] instance_inj_ctrl_t1 ;  
   wire [6-1:0] instance_inj_ctrl_t2 ;  
   wire [2-1:0] instance_inj_ctrl_t3 ;  
   wire instance_inj_ctrl_turbo ;  
   wire instance_inj_ctrl_turbo_speed_lev ;  
   wire instance_inj_ctrl_vehicle ;  
   wire [3-1:0] instance_inj_ctrl_inj_cmd_034 ;  
   wire instance_inj_ctrl_i_fbk_034 ;  
   wire [8-1:0] instance_inj_ctrl_r_t1 ;  
   wire [7-1:0] instance_inj_ctrl_r_t2 ;  
   wire [8-1:0] instance_inj_ctrl_r_t3_034 ;  
   wire [7-1:0] instance_inj_ctrl_r_t4_034 ;  
   wire [10-1:0] instance_inj_ctrl_r_tb_034 ;  
   wire [12-1:0] instance_inj_ctrl_r_th_034 ;  
   wire [7-1:0] instance_inj_ctrl_r_tonh ;  
   wire [7-1:0] instance_inj_ctrl_r_tonl ;  
   wire [7-1:0] instance_inj_ctrl_r_tp ;  
   wire [11-1:0] instance_inj_ctrl_status_reg_034 ;  
   wire [3-1:0] instance_inj_ctrl_test_en_034 ;  
   wire [3-1:0] instance_inj_ctrl_v_fbk_034 ;  
   wire instance_inj_ctrl_en_fbk_store_034 ;  
   wire instance_inj_ctrl_en_state_store_034 ;  
   wire instance_inj_ctrl_error1 ;  
   wire [7-1:0] instance_inj_ctrl_global_state_034 ;  
   wire instance_inj_ctrl_hl_034 ;  
   wire instance_inj_ctrl_relpot1 ;  
   wire instance_inj_ctrl_t1_0 ;  
   wire instance_inj_ctrl_t1_3 ;  
   wire instance_inj_ctrl_t1_4 ;  
   wire instance_inj_ctrl_t2_0 ;  
   wire instance_inj_ctrl_t2_3 ;  
   wire instance_inj_ctrl_t2_4 ;  
   wire instance_inj_ctrl_t3_034 ;  
   wire [3-1:0] instance_inj_ctrl_inj_cmd_125 ;  
   wire instance_inj_ctrl_i_fbk_125 ;  
   wire [8-1:0] instance_inj_ctrl_r_t3_125 ;  
   wire [7-1:0] instance_inj_ctrl_r_t4_125 ;  
   wire [10-1:0] instance_inj_ctrl_r_tb_125 ;  
   wire [12-1:0] instance_inj_ctrl_r_th_125 ;  
   wire [11-1:0] instance_inj_ctrl_status_reg_125 ;  
   wire [3-1:0] instance_inj_ctrl_test_en_125 ;  
   wire [3-1:0] instance_inj_ctrl_v_fbk_125 ;  
   wire instance_inj_ctrl_en_fbk_store_125 ;  
   wire instance_inj_ctrl_en_state_store_125 ;  
   wire instance_inj_ctrl_error2 ;  
   wire [7-1:0] instance_inj_ctrl_global_state_125 ;  
   wire instance_inj_ctrl_hl_125 ;  
   wire instance_inj_ctrl_relpot2 ;  
   wire instance_inj_ctrl_t1_1 ;  
   wire instance_inj_ctrl_t1_2 ;  
   wire instance_inj_ctrl_t1_5 ;  
   wire instance_inj_ctrl_t2_1 ;  
   wire instance_inj_ctrl_t2_2 ;  
   wire instance_inj_ctrl_t2_5 ;  
   wire instance_inj_ctrl_t3_125 ;  
   wire instance_inj_ctrl_rd_en ;  
   wire instance_inj_ctrl_wr_en ;  
   wire [16-1:0] instance_inj_ctrl_d_bus ;  
   wire [2-1:0] instance_inj_ctrl_i_fbk_f ;  
   wire [6-1:0] instance_inj_ctrl_v_fbk_f ;  
   wire instance_inj_ctrl_rel_pot_en ;  
   wire instance_inj_ctrl_pickup_hall ;  
   wire instance_inj_ctrl_smot_camme_en ;  
   wire instance_inj_ctrl_trg_knock_en ;  
   wire instance_inj_ctrl_clock_internal ;  
   wire instance_inj_ctrl_instance_block_034_clock ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_inj_cmd ;  
   wire instance_inj_ctrl_instance_block_034_i_fbk ;  
   wire instance_inj_ctrl_instance_block_034_rst ;  
   wire [8-1:0] instance_inj_ctrl_instance_block_034_r_t1 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_r_t2 ;  
   wire [8-1:0] instance_inj_ctrl_instance_block_034_r_t3 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_r_t4 ;  
   wire [10-1:0] instance_inj_ctrl_instance_block_034_r_tb ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_034_r_th ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_r_tonh ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_r_tonl ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_r_tp ;  
   wire [11-1:0] instance_inj_ctrl_instance_block_034_status_reg ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_test_en ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_v_fbk ;  
   wire instance_inj_ctrl_instance_block_034_en_fbk_store ;  
   wire instance_inj_ctrl_instance_block_034_en_state_store ;  
   wire instance_inj_ctrl_instance_block_034_error ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_global_state_store ;  
   wire instance_inj_ctrl_instance_block_034_hl ;  
   wire instance_inj_ctrl_instance_block_034_relpot ;  
   wire instance_inj_ctrl_instance_block_034_t1a ;  
   wire instance_inj_ctrl_instance_block_034_t1b ;  
   wire instance_inj_ctrl_instance_block_034_t1c ;  
   wire instance_inj_ctrl_instance_block_034_t2a ;  
   wire instance_inj_ctrl_instance_block_034_t2b ;  
   wire instance_inj_ctrl_instance_block_034_t2c ;  
   wire instance_inj_ctrl_instance_block_034_t3 ;  
   wire instance_inj_ctrl_instance_block_125_clock ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_inj_cmd ;  
   wire instance_inj_ctrl_instance_block_125_i_fbk ;  
   wire instance_inj_ctrl_instance_block_125_rst ;  
   wire [8-1:0] instance_inj_ctrl_instance_block_125_r_t1 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_r_t2 ;  
   wire [8-1:0] instance_inj_ctrl_instance_block_125_r_t3 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_r_t4 ;  
   wire [10-1:0] instance_inj_ctrl_instance_block_125_r_tb ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_125_r_th ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_r_tonh ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_r_tonl ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_r_tp ;  
   wire [11-1:0] instance_inj_ctrl_instance_block_125_status_reg ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_test_en ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_v_fbk ;  
   wire instance_inj_ctrl_instance_block_125_en_fbk_store ;  
   wire instance_inj_ctrl_instance_block_125_en_state_store ;  
   wire instance_inj_ctrl_instance_block_125_error ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_global_state_store ;  
   wire instance_inj_ctrl_instance_block_125_hl ;  
   wire instance_inj_ctrl_instance_block_125_relpot ;  
   wire instance_inj_ctrl_instance_block_125_t1a ;  
   wire instance_inj_ctrl_instance_block_125_t1b ;  
   wire instance_inj_ctrl_instance_block_125_t1c ;  
   wire instance_inj_ctrl_instance_block_125_t2a ;  
   wire instance_inj_ctrl_instance_block_125_t2b ;  
   wire instance_inj_ctrl_instance_block_125_t2c ;  
   wire instance_inj_ctrl_instance_block_125_t3 ;  
   wire instance_inj_ctrl_instance_block_034_cs8 ;  
   wire instance_inj_ctrl_instance_block_034_end_t0 ;  
   wire instance_inj_ctrl_instance_block_034_cs4 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_chop_count ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_034_count ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_034_stop_count_bus ;  
   wire instance_inj_ctrl_instance_block_034_comp ;  
   wire instance_inj_ctrl_instance_block_034_cs1 ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_cmd_stored ;  
   wire instance_inj_ctrl_instance_block_034_end_on ;  
   wire instance_inj_ctrl_instance_block_034_end_period ;  
   wire instance_inj_ctrl_instance_block_034_sh_mode ;  
   wire instance_inj_ctrl_instance_block_034_t4_0 ;  
   wire instance_inj_ctrl_instance_block_034_test_en_cur ;  
   wire instance_inj_ctrl_instance_block_034_th_0 ;  
   wire instance_inj_ctrl_instance_block_034_v_fbk_cur ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_v_fbk_mask ;  
   wire [4-1:0] instance_inj_ctrl_instance_block_034_cs0 ;  
   wire instance_inj_ctrl_instance_block_034_cs2 ;  
   wire instance_inj_ctrl_instance_block_034_t1 ;  
   wire instance_inj_ctrl_instance_block_034_t2 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_ton_reg ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_tp_reg ;  
   wire instance_inj_ctrl_instance_block_034_instance_anti_glitch_clock ;  
   wire instance_inj_ctrl_instance_block_034_instance_anti_glitch_cs8 ;  
   wire instance_inj_ctrl_instance_block_034_instance_anti_glitch_rst ;  
   wire instance_inj_ctrl_instance_block_034_instance_anti_glitch_end_t0 ;  
   wire instance_inj_ctrl_instance_block_125_instance_anti_glitch_clock ;  
   wire instance_inj_ctrl_instance_block_125_instance_anti_glitch_cs8 ;  
   wire instance_inj_ctrl_instance_block_125_instance_anti_glitch_rst ;  
   wire instance_inj_ctrl_instance_block_125_instance_anti_glitch_end_t0 ;  
   reg [2:0] instance_inj_ctrl_instance_block_034_instance_anti_glitch_counter ;  
  always @(  posedge instance_inj_ctrl_instance_block_034_instance_anti_glitch_clock or  negedge instance_inj_ctrl_instance_block_034_instance_anti_glitch_rst)
       begin :instance_inj_ctrl_instance_block_034_instance_anti_glitch_vhdl_count
         if (instance_inj_ctrl_instance_block_034_instance_anti_glitch_rst==1'b0)
            instance_inj_ctrl_instance_block_034_instance_anti_glitch_counter <=3'b000;
          else 
            begin 
              if (instance_inj_ctrl_instance_block_034_instance_anti_glitch_cs8==1'b1)
                 instance_inj_ctrl_instance_block_034_instance_anti_glitch_counter <=3'b000;
               else 
                 instance_inj_ctrl_instance_block_034_instance_anti_glitch_counter <=instance_inj_ctrl_instance_block_034_instance_anti_glitch_counter+3'b001;
            end 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_anti_glitch_end_t0=instance_inj_ctrl_instance_block_034_instance_anti_glitch_counter[0]&instance_inj_ctrl_instance_block_034_instance_anti_glitch_counter[1]&instance_inj_ctrl_instance_block_034_instance_anti_glitch_counter[2]; 
   wire instance_inj_ctrl_instance_block_034_instance_chopper_count_clock ;  
   wire instance_inj_ctrl_instance_block_034_instance_chopper_count_cs4 ;  
   wire instance_inj_ctrl_instance_block_034_instance_chopper_count_rst ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_chopper_count_chop_count ;  
   wire instance_inj_ctrl_instance_block_125_instance_chopper_count_clock ;  
   wire instance_inj_ctrl_instance_block_125_instance_chopper_count_cs4 ;  
   wire instance_inj_ctrl_instance_block_125_instance_chopper_count_rst ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_chopper_count_chop_count ;  
   reg [7-1:0] instance_inj_ctrl_instance_block_034_instance_chopper_count_int_counter ;  
  always @(  posedge instance_inj_ctrl_instance_block_034_instance_chopper_count_clock or  negedge instance_inj_ctrl_instance_block_034_instance_chopper_count_rst)
       begin :instance_inj_ctrl_instance_block_034_instance_chopper_count_vhdl_chopper_count
         if (instance_inj_ctrl_instance_block_034_instance_chopper_count_rst==1'b0)
            instance_inj_ctrl_instance_block_034_instance_chopper_count_int_counter <={7{1'b0}};
          else 
            begin 
              if (instance_inj_ctrl_instance_block_034_instance_chopper_count_cs4==1'b1)
                 instance_inj_ctrl_instance_block_034_instance_chopper_count_int_counter <={7{1'b0}};
               else 
                 instance_inj_ctrl_instance_block_034_instance_chopper_count_int_counter <=instance_inj_ctrl_instance_block_034_instance_chopper_count_int_counter+7'b0000001;
            end 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_chopper_count_chop_count=instance_inj_ctrl_instance_block_034_instance_chopper_count_int_counter; 
   wire [12-1:0] instance_inj_ctrl_instance_block_034_instance_comparator_count ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_034_instance_comparator_stop_count_bus ;  
   reg instance_inj_ctrl_instance_block_034_instance_comparator_comp ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_125_instance_comparator_count ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_125_instance_comparator_stop_count_bus ;  
   reg instance_inj_ctrl_instance_block_125_instance_comparator_comp ;  
  always @(  instance_inj_ctrl_instance_block_034_instance_comparator_count or  instance_inj_ctrl_instance_block_034_instance_comparator_stop_count_bus)
       begin :instance_inj_ctrl_instance_block_034_instance_comparator_vhdl_comparator
         if (instance_inj_ctrl_instance_block_034_instance_comparator_count==instance_inj_ctrl_instance_block_034_instance_comparator_stop_count_bus)
            instance_inj_ctrl_instance_block_034_instance_comparator_comp <=1'b1;
          else 
            instance_inj_ctrl_instance_block_034_instance_comparator_comp <=1'b0;
       end
  
   wire instance_inj_ctrl_instance_block_034_instance_counter_clock ;  
   wire instance_inj_ctrl_instance_block_034_instance_counter_cs1 ;  
   wire instance_inj_ctrl_instance_block_034_instance_counter_rst ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_034_instance_counter_count ;  
   wire instance_inj_ctrl_instance_block_125_instance_counter_clock ;  
   wire instance_inj_ctrl_instance_block_125_instance_counter_cs1 ;  
   wire instance_inj_ctrl_instance_block_125_instance_counter_rst ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_125_instance_counter_count ;  
   reg [12-1:0] instance_inj_ctrl_instance_block_034_instance_counter_int_counter ;  
  always @(  posedge instance_inj_ctrl_instance_block_034_instance_counter_clock or  negedge instance_inj_ctrl_instance_block_034_instance_counter_rst)
       begin :instance_inj_ctrl_instance_block_034_instance_counter_vhdl_counter
         if (instance_inj_ctrl_instance_block_034_instance_counter_rst==1'b0)
            instance_inj_ctrl_instance_block_034_instance_counter_int_counter <={12{1'b0}};
          else 
            begin 
              if (instance_inj_ctrl_instance_block_034_instance_counter_cs1==1'b1)
                 instance_inj_ctrl_instance_block_034_instance_counter_int_counter <={12{1'b0}};
               else 
                 instance_inj_ctrl_instance_block_034_instance_counter_int_counter <=instance_inj_ctrl_instance_block_034_instance_counter_int_counter+11'b00000000001;
            end 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_counter_count=instance_inj_ctrl_instance_block_034_instance_counter_int_counter; 
   wire instance_inj_ctrl_instance_block_034_instance_fsm_clock ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_cmd_stored ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_comp ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_end_on ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_end_period ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_end_t0 ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_inj_cmd ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_i_fbk ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_rst ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_sh_mode ;  
   wire [11-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_status_reg ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_t4_0 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_test_en_cur ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_th_0 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_v_fbk_cur ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_v_fbk_mask ;  
   wire [4-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_cs0 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_cs1 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_cs2 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_cs4 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_cs8 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_en_fbk_store ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_en_state_store ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_error ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_global_state_store ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_hl ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_relpot ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_t1 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_t2 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_t3 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_clock ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_cmd_stored ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_comp ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_end_on ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_end_period ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_end_t0 ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_inj_cmd ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_i_fbk ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_rst ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_sh_mode ;  
   wire [11-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_status_reg ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_t4_0 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_test_en_cur ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_th_0 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_v_fbk_cur ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_v_fbk_mask ;  
   wire [4-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_cs0 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_cs1 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_cs2 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_cs4 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_cs8 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_en_fbk_store ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_en_state_store ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_error ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_global_state_store ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_hl ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_relpot ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_t1 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_t2 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_t3 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_global_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_enable_check ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_cur_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_cs11 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_global1_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_cs111 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_t31 ;  
   wire [2-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_global2_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_cs42 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_t12 ;  
   wire [2-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_global4_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_cs44 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_t14 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_en_fbk_store_internal ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_clock ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_rst ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_test_en_cur ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_enable_check ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_en_fbk_store ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_en_state_store ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state_store ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_clock ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_rst ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_test_en_cur ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_enable_check ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_en_fbk_store ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_en_state_store ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state_store ;  
   reg [6:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state_store_int ;  
   reg [3-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_delay_counter ;  
  always @(  posedge instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_clock or  negedge instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_rst)
       if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_rst==1'b0)
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state_store_int <=7'b0000000;
        else 
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state_store_int <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state;
 
  always @(  posedge instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_clock or  negedge instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_rst)
       if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_rst==1'b0)
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_delay_counter <=3'b000;
        else 
          begin 
            if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state_store_int!=instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state)
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_delay_counter <=3'b000;
             else 
               if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_delay_counter[2]==1'b0)
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_delay_counter <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_delay_counter+3'b001;
          end
  
  always @(    instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_delay_counter[2] or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_test_en_cur or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state_store_int)
       begin 
         if ((instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_delay_counter[2]==1'b1)&(instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_test_en_cur==1'b1)&(instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state==instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state_store_int))
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_enable_check <=1'b1;
          else 
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_enable_check <=1'b0;
         if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state_store_int!=instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state)
            begin 
              if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state[6:5]!=2'b11)
                 begin 
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_en_state_store <=1'b1;
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_en_fbk_store <=1'b1;
                 end 
               else 
                 begin 
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_en_state_store <=1'b0;
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_en_fbk_store <=1'b1;
                 end 
            end 
          else 
            begin 
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_en_state_store <=1'b0;
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_en_fbk_store <=1'b0;
            end 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state_store=instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state; 
   wire [5-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cur_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_en_fbk_store ;  
   wire [4-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs0 ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs11 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_error ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_relpot ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cur_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_en_fbk_store ;  
   wire [4-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs0 ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs11 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_error ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_relpot ;  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_relpot=instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cur_state[4]&instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cur_state[3]&instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cur_state[2]&instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cur_state[0]; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs0=instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cur_state[4:1]; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_error=instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cur_state[4]&instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cur_state[3]&instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cur_state[2]&(~(instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_en_fbk_store)); 
  always @( instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cur_state)
       case (instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cur_state)
        5 'b00000:
           instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b00010:
           instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b00100:
           instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b00110:
           instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b01000:
           instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b01010:
           instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b01100:
           instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b01110:
           instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b11000:
           instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        default :
           instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs11 <=1'b0;
       endcase
  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_clock ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_cmd_stored ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_cur_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_end_t0 ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_inj_cmd ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_rst ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_global1_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_clock ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_cmd_stored ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_cur_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_end_t0 ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_inj_cmd ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_rst ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_global1_state ;  
 parameter[1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_1_state =0,instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_2_state=1; 
   reg [1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_current_state ;  
   reg [1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_next_state ;  
  always @(      posedge instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_clock or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_cmd_stored or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_cur_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_end_t0 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_inj_cmd or  negedge instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_rst)
       begin :instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_clocked
         if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_rst==1'b0)
            begin 
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_current_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_1_state;
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_global1_state <=1'b0;
            end 
          else 
            begin 
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_current_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_next_state;
              case (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_next_state)
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_1_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_global1_state <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_2_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_global1_state <=1'b1;
               default :;
              endcase 
            end 
       end
  
  always @(       instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_current_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_clock or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_cmd_stored or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_cur_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_end_t0 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_inj_cmd or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_rst)
       begin :instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_set_next_state
         instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_current_state;
         case (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_current_state)
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_1_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_end_t0==1'b1&(instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_inj_cmd==instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_cmd_stored)&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_cur_state==5'b00001)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_2_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_cur_state!=5'b00001)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_1_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_2_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_cur_state!=5'b00001)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_1_state;
          default :;
         endcase 
       end
  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_output_handle_global1_state ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_output_handle_cs111 ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_output_handle_t31 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_output_handle_global1_state ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_output_handle_cs111 ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_output_handle_t31 ;  
  always @( instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_output_handle_global1_state)
       if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_output_handle_global1_state==1'b1)
          begin 
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_output_handle_t31 <=1'b1;
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_output_handle_cs111 <=1'b0;
          end 
        else 
          begin 
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_output_handle_t31 <=1'b0;
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_output_handle_cs111 <=1'b1;
          end
  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_clock ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_cur_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_end_on ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_end_period ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_i_fbk ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_rst ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_sh_mode ;  
   reg [2-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_global2_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_clock ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_cur_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_end_on ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_end_period ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_i_fbk ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_rst ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_sh_mode ;  
   reg [2-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_global2_state ;  
 parameter[1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state =0,instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_2_state=1,instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_3_state=2,instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_4_state=3; 
   reg [1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_current_state ;  
   reg [1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_next_state ;  
  always @(       posedge instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_clock or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_cur_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_end_on or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_end_period or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_i_fbk or  negedge instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_rst or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_sh_mode)
       begin :instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_clocked
         if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_rst==1'b0)
            begin 
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_current_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state;
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_global2_state <=2'b01;
            end 
          else 
            begin 
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_current_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_next_state;
              case (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_next_state)
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_global2_state <=2'b01;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_2_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_global2_state <=2'b10;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_3_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_global2_state <=2'b11;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_4_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_global2_state <=2'b00;
               default :;
              endcase 
            end 
       end
  
  always @(        instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_current_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_clock or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_cur_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_end_on or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_end_period or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_i_fbk or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_rst or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_sh_mode)
       begin :instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_set_next_state
         instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_current_state;
         case (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_current_state)
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_cur_state==5'b00101&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_sh_mode==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_i_fbk==1'b1)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_sh_mode==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_end_on==1'b1)))
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_2_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_cur_state!=5'b00101)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_2_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_cur_state==5'b00101)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_3_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_cur_state!=5'b00101)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_3_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_cur_state==5'b00101&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_sh_mode==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_i_fbk==1'b0)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_sh_mode==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_end_period==1'b1)))
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_4_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_cur_state!=5'b00101)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_4_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state;
          default :;
         endcase 
       end
  
   wire [2-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_global2_state ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_cs42 ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_t12 ;  
   wire [2-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_global2_state ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_cs42 ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_t12 ;  
  always @( instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_global2_state)
       begin 
         if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_global2_state==2'b00)
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_cs42 <=1'b1;
          else 
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_cs42 <=1'b0;
         if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_global2_state[1]==1'b1)
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_t12 <=1'b0;
          else 
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_t12 <=1'b1;
       end
  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_clock ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_end_on ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_end_period ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_i_fbk ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_rst ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_sh_mode ;  
   reg [2-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_global4_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_clock ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_end_on ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_end_period ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_i_fbk ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_rst ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_sh_mode ;  
   reg [2-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_global4_state ;  
 parameter[1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state =0,instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_2_state=1,instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_3_state=2,instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_4_state=3; 
   reg [1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_current_state ;  
   reg [1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state ;  
  always @(       posedge instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_clock or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_end_on or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_end_period or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_i_fbk or  negedge instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_rst or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_sh_mode)
       begin :instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_clocked
         if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_rst==1'b0)
            begin 
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_current_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state;
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_global4_state <=2'b01;
            end 
          else 
            begin 
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_current_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state;
              case (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state)
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_global4_state <=2'b01;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_2_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_global4_state <=2'b10;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_3_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_global4_state <=2'b11;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_4_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_global4_state <=2'b00;
               default :;
              endcase 
            end 
       end
  
  always @(        instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_current_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_clock or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_end_on or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_end_period or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_i_fbk or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_rst or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_sh_mode)
       begin :instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_set_next_state
         instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_current_state;
         case (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_current_state)
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state==5'b01001&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_sh_mode==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_i_fbk==1'b1)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_sh_mode==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_end_on==1'b1)))
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_2_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state!=5'b01001&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state!=5'b11001)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state;
                 else 
                   if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state==5'b11001&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_sh_mode==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_i_fbk==1'b1)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_sh_mode==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_end_on==1'b1)))
                      instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_2_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_2_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state==5'b01001|instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state==5'b11001)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_3_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state!=5'b01001&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state!=5'b11001)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_3_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state==5'b01001&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_sh_mode==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_i_fbk==1'b0)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_sh_mode==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_end_period==1'b1)))
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_4_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state!=5'b01001&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state!=5'b11001)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state;
                 else 
                   if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state==5'b11001&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_sh_mode==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_i_fbk==1'b0)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_sh_mode==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_end_period==1'b1)))
                      instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_4_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_4_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state;
          default :;
         endcase 
       end
  
   wire [2-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_global4_state ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_cs44 ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_t14 ;  
   wire [2-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_global4_state ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_cs44 ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_t14 ;  
  always @( instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_global4_state)
       begin 
         if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_global4_state==2'b00)
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_cs44 <=1'b1;
          else 
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_cs44 <=1'b0;
         if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_global4_state[1]==1'b1)
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_t14 <=1'b0;
          else 
            instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_t14 <=1'b1;
       end
  
   wire [5-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_cur_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t12 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t14 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t31 ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_cur_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t12 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t14 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t31 ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 ;  
  always @(    instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t31 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t12 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t14 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_cur_state)
       begin :instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_vhdl_sel_actuator
         case (instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_cur_state)
          5 'b00000:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b00001:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t31;
             end 
          5 'b00010:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b1;
             end 
          5 'b00011:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b1;
             end 
          5 'b00100:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b00101:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t12;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b00110:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b00111:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01000:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01001:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t14;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01010:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01011:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01100:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01101:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01110:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01111:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b11000:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b11001:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t14;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b11100:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b11101:
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          default :
             begin 
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
         endcase 
       end
  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs42 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs44 ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cur_state ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs4 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs42 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs44 ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cur_state ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs4 ;  
  always @(   instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs42 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs44 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cur_state)
       begin :instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_vhdl_sel_chop_control
         case (instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cur_state)
          5 'b00101:
             instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs4 <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs42;
          5 'b01001:
             instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs4 <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs44;
          5 'b11001:
             instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs4 <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs44;
          default :
             instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs4 <=1'b1;
         endcase 
       end
  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs11 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs111 ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cur_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_global1_state ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs1 ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs2 ;  
   reg instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs8 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs11 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs111 ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cur_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_global1_state ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs1 ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs2 ;  
   reg instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs8 ;  
  always @(    instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs11 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs111 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cur_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_global1_state)
       begin :instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_vhdl_sel_glob_count_cs
         if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cur_state==5'b00001)
            begin 
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs1 <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs111;
              if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_global1_state==1'b0)
                 instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs2 <=1'b1;
               else 
                 instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs2 <=1'b0;
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs8 <=1'b0;
            end 
          else 
            if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cur_state==5'b00000)
               begin 
                 instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs1 <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs11;
                 instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs2 <=1'b1;
                 instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs8 <=1'b1;
               end 
             else 
               begin 
                 instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs1 <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs11;
                 instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs2 <=1'b0;
                 instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs8 <=1'b1;
               end 
       end
  
   wire [5-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_cur_state ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global1_state ;  
   wire [2-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global2_state ;  
   wire [2-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global4_state ;  
   reg [7-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global_state ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_cur_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global1_state ;  
   wire [2-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global2_state ;  
   wire [2-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global4_state ;  
   reg [7-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global_state ;  
  always @(    instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_cur_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global1_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global2_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global4_state)
       begin 
         instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global_state [6:2]<=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_cur_state;
         case (instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_cur_state)
          5 'b00001:
             instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global_state [1:0]<={1'b0,instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global1_state};
          5 'b00101:
             instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global_state [1:0]<=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global2_state;
          5 'b01001:
             instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global_state [1:0]<=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global4_state;
          5 'b11001:
             instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global_state [1:0]<=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global4_state;
          default :
             instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global_state [1:0]<=2'b00;
         endcase 
       end
  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_clock ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cmd_stored ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_end_t0 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_inj_cmd ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_i_fbk ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_rst ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_sh_mode ;  
   wire [11-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_status_reg ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_t4_0 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_th_0 ;  
   wire instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_mask ;  
   reg [5-1:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_clock ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cmd_stored ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_end_t0 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_inj_cmd ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_i_fbk ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_rst ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_sh_mode ;  
   wire [11-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_status_reg ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_t4_0 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_th_0 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_mask ;  
   reg [5-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state ;  
 parameter[4:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_start_state =0,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph1bis_state=1,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph2_state=2,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph3_state=3,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph4_state=4,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph5_state=5,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph1_state=6,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state=7,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state=8,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int1_state=9,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int_2_state=10,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int3_state=11,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int4_state=12,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int5_state=13,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int6_state=14,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph6_state=15,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int7_state=16,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph7_state=17,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int8_state=18,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph8_state=19,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int9_state=20,instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph9_state=21; 
   reg [4:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_current_state ;  
   reg [4:0] instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state ;  
  always @(               posedge instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_clock or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cmd_stored or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_end_t0 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_inj_cmd or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_i_fbk or  negedge instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_rst or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_sh_mode or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_status_reg or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_t4_0 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_th_0 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_mask)
       begin :instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_clocked
         if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_rst==1'b0)
            begin 
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_current_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_start_state;
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b00000;
            end 
          else 
            begin 
              instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_current_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state;
              case (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state)
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_start_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b00000;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph1bis_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b00011;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph2_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b00101;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph3_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b00111;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph4_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b01001;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph5_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b01011;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph1_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b00001;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b11100;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b11101;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int1_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b00010;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int_2_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b00100;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int3_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b00110;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int4_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b01000;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int5_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b01010;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int6_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b01100;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph6_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b01101;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int7_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b01110;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph7_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b01111;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int8_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b11000;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph8_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b11001;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int9_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b01010;
               instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph9_state :
                  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state <=5'b01011;
               default :;
              endcase 
            end 
       end
  
  always @(                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_current_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_clock or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cmd_stored or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_end_t0 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_inj_cmd or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_i_fbk or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_rst or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_sh_mode or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_status_reg or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_t4_0 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_th_0 or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur or  instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_mask)
       begin :instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_set_next_state
         instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_current_state;
         case (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_current_state)
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_start_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_inj_cmd!=3'b000&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_mask==3'b000)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph1_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_inj_cmd!=3'b000&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_mask!=3'b000&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b0)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph1_state;
                 else 
                   if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_inj_cmd!=3'b000&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_mask!=3'b000&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b1)
                      instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph1bis_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int_2_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b1)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
                 else 
                   if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b0)
                      instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int_2_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph2_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b11)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b10)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b00)))
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int3_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b1)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
                 else 
                   if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b11&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b1)
                      instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state;
                    else 
                      if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b11)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b10)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b00))&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b0)
                         instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int3_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph3_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_th_0==1'b0)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int4_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b1)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state;
                 else 
                   if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_th_0==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1)
                      instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int5_state;
                    else 
                      if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_th_0==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b0)
                         instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int4_state;
                       else 
                         if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_th_0==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b0)
                            instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int5_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph4_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b11)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b10)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b00)))
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int5_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b11&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b1)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state;
                 else 
                   if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b1)
                      instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
                    else 
                      if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b11)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b10)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b00))&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b0)
                         instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int5_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph5_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_t4_0==1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_start_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_t4_0==1'b0)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int6_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph1_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_i_fbk==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_sh_mode==1'b1)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_sh_mode==1'b0)))
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int1_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b1)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
                 else 
                   if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[0]==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_i_fbk==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_sh_mode==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b1)
                      instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
                    else 
                      if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_inj_cmd!=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cmd_stored&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[0]==1'b0)
                         instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_start_state;
                       else 
                         if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0|((instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_i_fbk==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_sh_mode==1'b1)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_sh_mode==1'b0)))&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b0)
                            instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int1_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_status_reg==11'b00000000000)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_start_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_status_reg==11'b00000000000)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_start_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int1_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph1bis_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int_2_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph2_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int3_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph3_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int4_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph4_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int5_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph5_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int6_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph6_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph6_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int7_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int7_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph7_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph7_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b0)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int8_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1)
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int8_state;
                 else 
                   if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b1)
                      instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int8_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph8_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph8_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b11)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b10)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b00))&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b0)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int9_state;
              else 
                if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1&((instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b11)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b10)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1)|(instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b00)))
                   instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int9_state;
                 else 
                   if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b11&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b1)
                      instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state;
                    else 
                      if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check==1'b1)
                         instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_int9_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph9_state;
          instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_ph9_state :
             if (instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp==1'b1)
                instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_state_progression_state_type_start_state;
          default :;
         endcase 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_en_fbk_store=instance_inj_ctrl_instance_block_034_instance_fsm_en_fbk_store_internal; 
   wire instance_inj_ctrl_instance_block_034_instance_internal_register_clock ;  
   wire [4-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_cs0 ;  
   wire instance_inj_ctrl_instance_block_034_instance_internal_register_cs2 ;  
   wire instance_inj_ctrl_instance_block_034_instance_internal_register_rst ;  
   wire [8-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_r_t1 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_r_t2 ;  
   wire [8-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_r_t3 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_r_t4 ;  
   wire [10-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_r_tb ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_r_th ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_r_tonh ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_r_tonl ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_r_tp ;  
   wire instance_inj_ctrl_instance_block_034_instance_internal_register_sh_mode ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_stop_count_bus ;  
   wire instance_inj_ctrl_instance_block_034_instance_internal_register_t4_0 ;  
   wire instance_inj_ctrl_instance_block_034_instance_internal_register_th_0 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_ton_reg ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_tp_reg ;  
   wire instance_inj_ctrl_instance_block_125_instance_internal_register_clock ;  
   wire [4-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_cs0 ;  
   wire instance_inj_ctrl_instance_block_125_instance_internal_register_cs2 ;  
   wire instance_inj_ctrl_instance_block_125_instance_internal_register_rst ;  
   wire [8-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_r_t1 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_r_t2 ;  
   wire [8-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_r_t3 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_r_t4 ;  
   wire [10-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_r_tb ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_r_th ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_r_tonh ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_r_tonl ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_r_tp ;  
   wire instance_inj_ctrl_instance_block_125_instance_internal_register_sh_mode ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_stop_count_bus ;  
   wire instance_inj_ctrl_instance_block_125_instance_internal_register_t4_0 ;  
   wire instance_inj_ctrl_instance_block_125_instance_internal_register_th_0 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_ton_reg ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_tp_reg ;  
   reg [12-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_th ;  
   reg [10-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_tb ;  
   reg [7-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_tonh ;  
   reg [7-1:0] instance_inj_ctrl_instance_block_034_instance_internal_register_tonl ;  
  always @(  posedge instance_inj_ctrl_instance_block_034_instance_internal_register_clock or  negedge instance_inj_ctrl_instance_block_034_instance_internal_register_rst)
       begin :instance_inj_ctrl_instance_block_034_instance_internal_register_vhdl_internal_register
         if (instance_inj_ctrl_instance_block_034_instance_internal_register_rst==1'b0)
            begin 
              instance_inj_ctrl_instance_block_034_instance_internal_register_tb <={10{1'b0}};
              instance_inj_ctrl_instance_block_034_instance_internal_register_th <={12{1'b0}};
              instance_inj_ctrl_instance_block_034_instance_internal_register_tonh <={7{1'b0}};
              instance_inj_ctrl_instance_block_034_instance_internal_register_tonl <={7{1'b0}};
            end 
          else 
            begin 
              if (instance_inj_ctrl_instance_block_034_instance_internal_register_cs2==1'b1)
                 begin 
                   instance_inj_ctrl_instance_block_034_instance_internal_register_tb <=instance_inj_ctrl_instance_block_034_instance_internal_register_r_tb;
                   instance_inj_ctrl_instance_block_034_instance_internal_register_th <=instance_inj_ctrl_instance_block_034_instance_internal_register_r_th;
                   instance_inj_ctrl_instance_block_034_instance_internal_register_tonh <=instance_inj_ctrl_instance_block_034_instance_internal_register_r_tonh;
                   instance_inj_ctrl_instance_block_034_instance_internal_register_tonl <=instance_inj_ctrl_instance_block_034_instance_internal_register_r_tonl;
                 end 
            end 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_tp_reg=instance_inj_ctrl_instance_block_034_instance_internal_register_r_tp; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_sh_mode=instance_inj_ctrl_instance_block_034_instance_internal_register_tb[9]; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_th_0=(~(instance_inj_ctrl_instance_block_034_instance_internal_register_th[0]|instance_inj_ctrl_instance_block_034_instance_internal_register_th[1]|instance_inj_ctrl_instance_block_034_instance_internal_register_th[2]|instance_inj_ctrl_instance_block_034_instance_internal_register_th[3]|instance_inj_ctrl_instance_block_034_instance_internal_register_th[4]|instance_inj_ctrl_instance_block_034_instance_internal_register_th[5]|instance_inj_ctrl_instance_block_034_instance_internal_register_th[6]|instance_inj_ctrl_instance_block_034_instance_internal_register_th[7]|instance_inj_ctrl_instance_block_034_instance_internal_register_th[8]|instance_inj_ctrl_instance_block_034_instance_internal_register_th[9]|instance_inj_ctrl_instance_block_034_instance_internal_register_th[10]|instance_inj_ctrl_instance_block_034_instance_internal_register_th[11])); 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_t4_0=(~(instance_inj_ctrl_instance_block_034_instance_internal_register_r_t4[6]|instance_inj_ctrl_instance_block_034_instance_internal_register_r_t4[5]|instance_inj_ctrl_instance_block_034_instance_internal_register_r_t4[4]|instance_inj_ctrl_instance_block_034_instance_internal_register_r_t4[3])); 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0000)?{5'b00000,instance_inj_ctrl_instance_block_034_instance_internal_register_r_t1[7:1]}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0000)?instance_inj_ctrl_instance_block_034_instance_internal_register_tonh:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0001)?{5'b00000,instance_inj_ctrl_instance_block_034_instance_internal_register_r_t1[7:1]}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0001)?instance_inj_ctrl_instance_block_034_instance_internal_register_tonh:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0010)?{3'b000,instance_inj_ctrl_instance_block_034_instance_internal_register_tb[8:0]}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0010)?instance_inj_ctrl_instance_block_034_instance_internal_register_tonh:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0011)?{5'b00000,instance_inj_ctrl_instance_block_034_instance_internal_register_r_t2}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0011)?instance_inj_ctrl_instance_block_034_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0100)?instance_inj_ctrl_instance_block_034_instance_internal_register_th:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0100)?instance_inj_ctrl_instance_block_034_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0101)?{5'b00000,instance_inj_ctrl_instance_block_034_instance_internal_register_r_t1[7:1]}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0101)?instance_inj_ctrl_instance_block_034_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0110)?{4'b0000,instance_inj_ctrl_instance_block_034_instance_internal_register_r_t3}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0110)?instance_inj_ctrl_instance_block_034_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0111)?{3'b000,instance_inj_ctrl_instance_block_034_instance_internal_register_r_t1,1'b0}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b0111)?instance_inj_ctrl_instance_block_034_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b1100)?{5'b00000,instance_inj_ctrl_instance_block_034_instance_internal_register_r_t4}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0==4'b1100)?instance_inj_ctrl_instance_block_034_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0[3:1]==3'b111)?{4'b0000,instance_inj_ctrl_instance_block_034_instance_internal_register_r_t1}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_034_instance_internal_register_cs0[3:1]==3'b111)?instance_inj_ctrl_instance_block_034_instance_internal_register_tonl:7'bZZZZZZZ; 
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_on_comp_chop_count ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_on_comp_ton_reg ;  
   reg instance_inj_ctrl_instance_block_034_instance_on_comp_end_on ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_on_comp_chop_count ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_on_comp_ton_reg ;  
   reg instance_inj_ctrl_instance_block_125_instance_on_comp_end_on ;  
  always @(  instance_inj_ctrl_instance_block_034_instance_on_comp_chop_count or  instance_inj_ctrl_instance_block_034_instance_on_comp_ton_reg)
       begin :instance_inj_ctrl_instance_block_034_instance_on_comp_vhdl_on_comp
         if (instance_inj_ctrl_instance_block_034_instance_on_comp_chop_count==instance_inj_ctrl_instance_block_034_instance_on_comp_ton_reg)
            instance_inj_ctrl_instance_block_034_instance_on_comp_end_on <=1'b1;
          else 
            instance_inj_ctrl_instance_block_034_instance_on_comp_end_on <=1'b0;
       end
  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_output_decoder_cmd_stored ;  
   wire instance_inj_ctrl_instance_block_034_instance_output_decoder_t1 ;  
   wire instance_inj_ctrl_instance_block_034_instance_output_decoder_t2 ;  
   reg instance_inj_ctrl_instance_block_034_instance_output_decoder_t1a ;  
   reg instance_inj_ctrl_instance_block_034_instance_output_decoder_t1b ;  
   reg instance_inj_ctrl_instance_block_034_instance_output_decoder_t1c ;  
   reg instance_inj_ctrl_instance_block_034_instance_output_decoder_t2a ;  
   reg instance_inj_ctrl_instance_block_034_instance_output_decoder_t2b ;  
   reg instance_inj_ctrl_instance_block_034_instance_output_decoder_t2c ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_output_decoder_cmd_stored ;  
   wire instance_inj_ctrl_instance_block_125_instance_output_decoder_t1 ;  
   wire instance_inj_ctrl_instance_block_125_instance_output_decoder_t2 ;  
   reg instance_inj_ctrl_instance_block_125_instance_output_decoder_t1a ;  
   reg instance_inj_ctrl_instance_block_125_instance_output_decoder_t1b ;  
   reg instance_inj_ctrl_instance_block_125_instance_output_decoder_t1c ;  
   reg instance_inj_ctrl_instance_block_125_instance_output_decoder_t2a ;  
   reg instance_inj_ctrl_instance_block_125_instance_output_decoder_t2b ;  
   reg instance_inj_ctrl_instance_block_125_instance_output_decoder_t2c ;  
  always @(   instance_inj_ctrl_instance_block_034_instance_output_decoder_cmd_stored or  instance_inj_ctrl_instance_block_034_instance_output_decoder_t1 or  instance_inj_ctrl_instance_block_034_instance_output_decoder_t2)
       begin :instance_inj_ctrl_instance_block_034_instance_output_decoder_vhdl_output_decoder
         case (instance_inj_ctrl_instance_block_034_instance_output_decoder_cmd_stored)
          3 'b001:
             begin 
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t1a <=instance_inj_ctrl_instance_block_034_instance_output_decoder_t1;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t2a <=instance_inj_ctrl_instance_block_034_instance_output_decoder_t2;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t1b <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t2b <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t1c <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t2c <=1'b0;
             end 
          3 'b010:
             begin 
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t1b <=instance_inj_ctrl_instance_block_034_instance_output_decoder_t1;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t2b <=instance_inj_ctrl_instance_block_034_instance_output_decoder_t2;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t1a <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t2a <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t1c <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t2c <=1'b0;
             end 
          3 'b100:
             begin 
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t1c <=instance_inj_ctrl_instance_block_034_instance_output_decoder_t1;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t2c <=instance_inj_ctrl_instance_block_034_instance_output_decoder_t2;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t1b <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t2b <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t1a <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t2a <=1'b0;
             end 
          default :
             begin 
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t1a <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t2a <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t1b <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t2b <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t1c <=1'b0;
               instance_inj_ctrl_instance_block_034_instance_output_decoder_t2c <=1'b0;
             end 
         endcase 
       end
  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_period_comp_chop_count ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_034_instance_period_comp_tp_reg ;  
   reg instance_inj_ctrl_instance_block_034_instance_period_comp_end_period ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_period_comp_chop_count ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_period_comp_tp_reg ;  
   reg instance_inj_ctrl_instance_block_125_instance_period_comp_end_period ;  
  always @(  instance_inj_ctrl_instance_block_034_instance_period_comp_chop_count or  instance_inj_ctrl_instance_block_034_instance_period_comp_tp_reg)
       begin :instance_inj_ctrl_instance_block_034_instance_period_comp_vhdl_period_comp
         if (instance_inj_ctrl_instance_block_034_instance_period_comp_chop_count==instance_inj_ctrl_instance_block_034_instance_period_comp_tp_reg)
            instance_inj_ctrl_instance_block_034_instance_period_comp_end_period <=1'b1;
          else 
            instance_inj_ctrl_instance_block_034_instance_period_comp_end_period <=1'b0;
       end
  
   wire instance_inj_ctrl_instance_block_034_instance_sel_cmd_clock ;  
   wire instance_inj_ctrl_instance_block_034_instance_sel_cmd_cs2 ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_sel_cmd_inj_cmd ;  
   wire instance_inj_ctrl_instance_block_034_instance_sel_cmd_rst ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_sel_cmd_cmd_stored ;  
   reg instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en_cur ;  
   reg instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk_cur ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk_mask ;  
   wire instance_inj_ctrl_instance_block_125_instance_sel_cmd_clock ;  
   wire instance_inj_ctrl_instance_block_125_instance_sel_cmd_cs2 ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_sel_cmd_inj_cmd ;  
   wire instance_inj_ctrl_instance_block_125_instance_sel_cmd_rst ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_sel_cmd_cmd_stored ;  
   reg instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en_cur ;  
   reg instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk_cur ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk_mask ;  
   reg [2:0] instance_inj_ctrl_instance_block_034_instance_sel_cmd_cmd_stored_int ;  
  always @(  posedge instance_inj_ctrl_instance_block_034_instance_sel_cmd_clock or  negedge instance_inj_ctrl_instance_block_034_instance_sel_cmd_rst)
       begin :instance_inj_ctrl_instance_block_034_instance_sel_cmd_vhdl_sel_cmd
         if (instance_inj_ctrl_instance_block_034_instance_sel_cmd_rst==1'b0)
            instance_inj_ctrl_instance_block_034_instance_sel_cmd_cmd_stored_int <=3'b000;
          else 
            begin 
              if (instance_inj_ctrl_instance_block_034_instance_sel_cmd_cs2==1'b1)
                 instance_inj_ctrl_instance_block_034_instance_sel_cmd_cmd_stored_int <=instance_inj_ctrl_instance_block_034_instance_sel_cmd_inj_cmd;
            end 
       end
  
  always @(   instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk or  instance_inj_ctrl_instance_block_034_instance_sel_cmd_cmd_stored_int or  instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en)
       case (instance_inj_ctrl_instance_block_034_instance_sel_cmd_cmd_stored_int)
        3 'b001:
           begin 
             instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk_cur <=instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk[0];
             instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en_cur <=instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en[0];
           end 
        3 'b010:
           begin 
             instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk_cur <=instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk[1];
             instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en_cur <=instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en[1];
           end 
        3 'b100:
           begin 
             instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk_cur <=instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk[2];
             instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en_cur <=instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en[2];
           end 
        default :
           begin 
             instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk_cur <=1'b0;
             instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en_cur <=1'b1;
           end 
       endcase
  
  assign instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk_mask[0]=instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk[0]&instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en[0]; 
  assign instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk_mask[1]=instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk[1]&instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en[1]; 
  assign instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk_mask[2]=instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk[2]&instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en[2]; 
  assign instance_inj_ctrl_instance_block_034_instance_sel_cmd_cmd_stored=instance_inj_ctrl_instance_block_034_instance_sel_cmd_cmd_stored_int; 
   wire instance_inj_ctrl_instance_block_125_cs8 ;  
   wire instance_inj_ctrl_instance_block_125_end_t0 ;  
   wire instance_inj_ctrl_instance_block_125_cs4 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_chop_count ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_125_count ;  
   wire [12-1:0] instance_inj_ctrl_instance_block_125_stop_count_bus ;  
   wire instance_inj_ctrl_instance_block_125_comp ;  
   wire instance_inj_ctrl_instance_block_125_cs1 ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_cmd_stored ;  
   wire instance_inj_ctrl_instance_block_125_end_on ;  
   wire instance_inj_ctrl_instance_block_125_end_period ;  
   wire instance_inj_ctrl_instance_block_125_sh_mode ;  
   wire instance_inj_ctrl_instance_block_125_t4_0 ;  
   wire instance_inj_ctrl_instance_block_125_test_en_cur ;  
   wire instance_inj_ctrl_instance_block_125_th_0 ;  
   wire instance_inj_ctrl_instance_block_125_v_fbk_cur ;  
   wire [3-1:0] instance_inj_ctrl_instance_block_125_v_fbk_mask ;  
   wire [4-1:0] instance_inj_ctrl_instance_block_125_cs0 ;  
   wire instance_inj_ctrl_instance_block_125_cs2 ;  
   wire instance_inj_ctrl_instance_block_125_t1 ;  
   wire instance_inj_ctrl_instance_block_125_t2 ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_ton_reg ;  
   wire [7-1:0] instance_inj_ctrl_instance_block_125_tp_reg ;  
   reg [2:0] instance_inj_ctrl_instance_block_125_instance_anti_glitch_counter ;  
  always @(  posedge instance_inj_ctrl_instance_block_125_instance_anti_glitch_clock or  negedge instance_inj_ctrl_instance_block_125_instance_anti_glitch_rst)
       begin :instance_inj_ctrl_instance_block_125_instance_anti_glitch_vhdl_count
         if (instance_inj_ctrl_instance_block_125_instance_anti_glitch_rst==1'b0)
            instance_inj_ctrl_instance_block_125_instance_anti_glitch_counter <=3'b000;
          else 
            begin 
              if (instance_inj_ctrl_instance_block_125_instance_anti_glitch_cs8==1'b1)
                 instance_inj_ctrl_instance_block_125_instance_anti_glitch_counter <=3'b000;
               else 
                 instance_inj_ctrl_instance_block_125_instance_anti_glitch_counter <=instance_inj_ctrl_instance_block_125_instance_anti_glitch_counter+3'b001;
            end 
       end
  
  assign instance_inj_ctrl_instance_block_125_instance_anti_glitch_end_t0=instance_inj_ctrl_instance_block_125_instance_anti_glitch_counter[0]&instance_inj_ctrl_instance_block_125_instance_anti_glitch_counter[1]&instance_inj_ctrl_instance_block_125_instance_anti_glitch_counter[2]; 
  assign instance_inj_ctrl_instance_block_034_instance_anti_glitch_clock=instance_inj_ctrl_instance_block_034_clock; 
  assign instance_inj_ctrl_instance_block_034_instance_anti_glitch_cs8=instance_inj_ctrl_instance_block_034_cs8; 
  assign instance_inj_ctrl_instance_block_034_instance_anti_glitch_rst=instance_inj_ctrl_instance_block_034_rst; 
  assign instance_inj_ctrl_instance_block_034_end_t0=instance_inj_ctrl_instance_block_034_instance_anti_glitch_end_t0; 
  assign instance_inj_ctrl_instance_block_125_instance_anti_glitch_clock=instance_inj_ctrl_instance_block_125_clock; 
  assign instance_inj_ctrl_instance_block_125_instance_anti_glitch_cs8=instance_inj_ctrl_instance_block_125_cs8; 
  assign instance_inj_ctrl_instance_block_125_instance_anti_glitch_rst=instance_inj_ctrl_instance_block_125_rst; 
  assign instance_inj_ctrl_instance_block_125_end_t0=instance_inj_ctrl_instance_block_125_instance_anti_glitch_end_t0; 
   reg [7-1:0] instance_inj_ctrl_instance_block_125_instance_chopper_count_int_counter ;  
  always @(  posedge instance_inj_ctrl_instance_block_125_instance_chopper_count_clock or  negedge instance_inj_ctrl_instance_block_125_instance_chopper_count_rst)
       begin :instance_inj_ctrl_instance_block_125_instance_chopper_count_vhdl_chopper_count
         if (instance_inj_ctrl_instance_block_125_instance_chopper_count_rst==1'b0)
            instance_inj_ctrl_instance_block_125_instance_chopper_count_int_counter <={7{1'b0}};
          else 
            begin 
              if (instance_inj_ctrl_instance_block_125_instance_chopper_count_cs4==1'b1)
                 instance_inj_ctrl_instance_block_125_instance_chopper_count_int_counter <={7{1'b0}};
               else 
                 instance_inj_ctrl_instance_block_125_instance_chopper_count_int_counter <=instance_inj_ctrl_instance_block_125_instance_chopper_count_int_counter+7'b0000001;
            end 
       end
  
  assign instance_inj_ctrl_instance_block_125_instance_chopper_count_chop_count=instance_inj_ctrl_instance_block_125_instance_chopper_count_int_counter; 
  assign instance_inj_ctrl_instance_block_034_instance_chopper_count_clock=instance_inj_ctrl_instance_block_034_clock; 
  assign instance_inj_ctrl_instance_block_034_instance_chopper_count_cs4=instance_inj_ctrl_instance_block_034_cs4; 
  assign instance_inj_ctrl_instance_block_034_instance_chopper_count_rst=instance_inj_ctrl_instance_block_034_rst; 
  assign instance_inj_ctrl_instance_block_034_chop_count=instance_inj_ctrl_instance_block_034_instance_chopper_count_chop_count; 
  assign instance_inj_ctrl_instance_block_125_instance_chopper_count_clock=instance_inj_ctrl_instance_block_125_clock; 
  assign instance_inj_ctrl_instance_block_125_instance_chopper_count_cs4=instance_inj_ctrl_instance_block_125_cs4; 
  assign instance_inj_ctrl_instance_block_125_instance_chopper_count_rst=instance_inj_ctrl_instance_block_125_rst; 
  assign instance_inj_ctrl_instance_block_125_chop_count=instance_inj_ctrl_instance_block_125_instance_chopper_count_chop_count; 
  always @(  instance_inj_ctrl_instance_block_125_instance_comparator_count or  instance_inj_ctrl_instance_block_125_instance_comparator_stop_count_bus)
       begin :instance_inj_ctrl_instance_block_125_instance_comparator_vhdl_comparator
         if (instance_inj_ctrl_instance_block_125_instance_comparator_count==instance_inj_ctrl_instance_block_125_instance_comparator_stop_count_bus)
            instance_inj_ctrl_instance_block_125_instance_comparator_comp <=1'b1;
          else 
            instance_inj_ctrl_instance_block_125_instance_comparator_comp <=1'b0;
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_comparator_count=instance_inj_ctrl_instance_block_034_count; 
  assign instance_inj_ctrl_instance_block_034_instance_comparator_stop_count_bus=instance_inj_ctrl_instance_block_034_stop_count_bus; 
  assign instance_inj_ctrl_instance_block_034_comp=instance_inj_ctrl_instance_block_034_instance_comparator_comp; 
  assign instance_inj_ctrl_instance_block_125_instance_comparator_count=instance_inj_ctrl_instance_block_125_count; 
  assign instance_inj_ctrl_instance_block_125_instance_comparator_stop_count_bus=instance_inj_ctrl_instance_block_125_stop_count_bus; 
  assign instance_inj_ctrl_instance_block_125_comp=instance_inj_ctrl_instance_block_125_instance_comparator_comp; 
   reg [12-1:0] instance_inj_ctrl_instance_block_125_instance_counter_int_counter ;  
  always @(  posedge instance_inj_ctrl_instance_block_125_instance_counter_clock or  negedge instance_inj_ctrl_instance_block_125_instance_counter_rst)
       begin :instance_inj_ctrl_instance_block_125_instance_counter_vhdl_counter
         if (instance_inj_ctrl_instance_block_125_instance_counter_rst==1'b0)
            instance_inj_ctrl_instance_block_125_instance_counter_int_counter <={12{1'b0}};
          else 
            begin 
              if (instance_inj_ctrl_instance_block_125_instance_counter_cs1==1'b1)
                 instance_inj_ctrl_instance_block_125_instance_counter_int_counter <={12{1'b0}};
               else 
                 instance_inj_ctrl_instance_block_125_instance_counter_int_counter <=instance_inj_ctrl_instance_block_125_instance_counter_int_counter+11'b00000000001;
            end 
       end
  
  assign instance_inj_ctrl_instance_block_125_instance_counter_count=instance_inj_ctrl_instance_block_125_instance_counter_int_counter; 
  assign instance_inj_ctrl_instance_block_034_instance_counter_clock=instance_inj_ctrl_instance_block_034_clock; 
  assign instance_inj_ctrl_instance_block_034_instance_counter_cs1=instance_inj_ctrl_instance_block_034_cs1; 
  assign instance_inj_ctrl_instance_block_034_instance_counter_rst=instance_inj_ctrl_instance_block_034_rst; 
  assign instance_inj_ctrl_instance_block_034_count=instance_inj_ctrl_instance_block_034_instance_counter_count; 
  assign instance_inj_ctrl_instance_block_125_instance_counter_clock=instance_inj_ctrl_instance_block_125_clock; 
  assign instance_inj_ctrl_instance_block_125_instance_counter_cs1=instance_inj_ctrl_instance_block_125_cs1; 
  assign instance_inj_ctrl_instance_block_125_instance_counter_rst=instance_inj_ctrl_instance_block_125_rst; 
  assign instance_inj_ctrl_instance_block_125_count=instance_inj_ctrl_instance_block_125_instance_counter_count; 
   wire [7-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_global_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_enable_check ;  
   wire [5-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_cur_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_cs11 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_global1_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_cs111 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_t31 ;  
   wire [2-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_global2_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_cs42 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_t12 ;  
   wire [2-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_global4_state ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_cs44 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_t14 ;  
   wire instance_inj_ctrl_instance_block_125_instance_fsm_en_fbk_store_internal ;  
   reg [6:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state_store_int ;  
   reg [3-1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_delay_counter ;  
  always @(  posedge instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_clock or  negedge instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_rst)
       if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_rst==1'b0)
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state_store_int <=7'b0000000;
        else 
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state_store_int <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state;
 
  always @(  posedge instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_clock or  negedge instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_rst)
       if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_rst==1'b0)
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_delay_counter <=3'b000;
        else 
          begin 
            if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state_store_int!=instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state)
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_delay_counter <=3'b000;
             else 
               if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_delay_counter[2]==1'b0)
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_delay_counter <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_delay_counter+3'b001;
          end
  
  always @(    instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_delay_counter[2] or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_test_en_cur or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state_store_int)
       begin 
         if ((instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_delay_counter[2]==1'b1)&(instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_test_en_cur==1'b1)&(instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state==instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state_store_int))
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_enable_check <=1'b1;
          else 
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_enable_check <=1'b0;
         if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state_store_int!=instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state)
            begin 
              if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state[6:5]!=2'b11)
                 begin 
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_en_state_store <=1'b1;
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_en_fbk_store <=1'b1;
                 end 
               else 
                 begin 
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_en_state_store <=1'b0;
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_en_fbk_store <=1'b1;
                 end 
            end 
          else 
            begin 
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_en_state_store <=1'b0;
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_en_fbk_store <=1'b0;
            end 
       end
  
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state_store=instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_clock=instance_inj_ctrl_instance_block_034_instance_fsm_clock; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state=instance_inj_ctrl_instance_block_034_instance_fsm_global_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_rst=instance_inj_ctrl_instance_block_034_instance_fsm_rst; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_test_en_cur=instance_inj_ctrl_instance_block_034_instance_fsm_test_en_cur; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_enable_check=instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_enable_check; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_en_fbk_store_internal=instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_en_fbk_store; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_en_state_store=instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_en_state_store; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_global_state_store=instance_inj_ctrl_instance_block_034_instance_fsm_instance_enable_fbk_chk_global_state_store; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_clock=instance_inj_ctrl_instance_block_125_instance_fsm_clock; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state=instance_inj_ctrl_instance_block_125_instance_fsm_global_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_rst=instance_inj_ctrl_instance_block_125_instance_fsm_rst; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_test_en_cur=instance_inj_ctrl_instance_block_125_instance_fsm_test_en_cur; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_enable_check=instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_enable_check; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_en_fbk_store_internal=instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_en_fbk_store; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_en_state_store=instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_en_state_store; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_global_state_store=instance_inj_ctrl_instance_block_125_instance_fsm_instance_enable_fbk_chk_global_state_store; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_relpot=instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cur_state[4]&instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cur_state[3]&instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cur_state[2]&instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cur_state[0]; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs0=instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cur_state[4:1]; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_error=instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cur_state[4]&instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cur_state[3]&instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cur_state[2]&(~(instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_en_fbk_store)); 
  always @( instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cur_state)
       case (instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cur_state)
        5 'b00000:
           instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b00010:
           instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b00100:
           instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b00110:
           instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b01000:
           instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b01010:
           instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b01100:
           instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b01110:
           instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        5 'b11000:
           instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs11 <=1'b1;
        default :
           instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs11 <=1'b0;
       endcase
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cur_state=instance_inj_ctrl_instance_block_034_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_en_fbk_store=instance_inj_ctrl_instance_block_034_instance_fsm_en_fbk_store_internal; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_cs0=instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs0; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_cs11=instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_cs11; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_error=instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_error; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_relpot=instance_inj_ctrl_instance_block_034_instance_fsm_instance_fsm_output_handle_relpot; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cur_state=instance_inj_ctrl_instance_block_125_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_en_fbk_store=instance_inj_ctrl_instance_block_125_instance_fsm_en_fbk_store_internal; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_cs0=instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs0; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_cs11=instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_cs11; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_error=instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_error; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_relpot=instance_inj_ctrl_instance_block_125_instance_fsm_instance_fsm_output_handle_relpot; 
 parameter[1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_1_state =0,instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_2_state=1; 
   reg [1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_current_state ;  
   reg [1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_next_state ;  
  always @(      posedge instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_clock or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_cmd_stored or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_cur_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_end_t0 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_inj_cmd or  negedge instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_rst)
       begin :instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_clocked
         if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_rst==1'b0)
            begin 
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_current_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_1_state;
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_global1_state <=1'b0;
            end 
          else 
            begin 
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_current_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_next_state;
              case (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_next_state)
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_1_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_global1_state <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_2_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_global1_state <=1'b1;
               default :;
              endcase 
            end 
       end
  
  always @(       instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_current_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_clock or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_cmd_stored or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_cur_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_end_t0 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_inj_cmd or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_rst)
       begin :instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_set_next_state
         instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_current_state;
         case (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_current_state)
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_1_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_end_t0==1'b1&(instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_inj_cmd==instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_cmd_stored)&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_cur_state==5'b00001)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_2_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_cur_state!=5'b00001)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_1_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_2_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_cur_state!=5'b00001)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_ph1_handle_state_type_ph1_1_state;
          default :;
         endcase 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_clock=instance_inj_ctrl_instance_block_034_instance_fsm_clock; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_cmd_stored=instance_inj_ctrl_instance_block_034_instance_fsm_cmd_stored; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_cur_state=instance_inj_ctrl_instance_block_034_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_end_t0=instance_inj_ctrl_instance_block_034_instance_fsm_end_t0; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_inj_cmd=instance_inj_ctrl_instance_block_034_instance_fsm_inj_cmd; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_rst=instance_inj_ctrl_instance_block_034_instance_fsm_rst; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_global1_state=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_handle_global1_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_clock=instance_inj_ctrl_instance_block_125_instance_fsm_clock; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_cmd_stored=instance_inj_ctrl_instance_block_125_instance_fsm_cmd_stored; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_cur_state=instance_inj_ctrl_instance_block_125_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_end_t0=instance_inj_ctrl_instance_block_125_instance_fsm_end_t0; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_inj_cmd=instance_inj_ctrl_instance_block_125_instance_fsm_inj_cmd; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_rst=instance_inj_ctrl_instance_block_125_instance_fsm_rst; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_global1_state=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_handle_global1_state; 
  always @( instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_output_handle_global1_state)
       if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_output_handle_global1_state==1'b1)
          begin 
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_output_handle_t31 <=1'b1;
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_output_handle_cs111 <=1'b0;
          end 
        else 
          begin 
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_output_handle_t31 <=1'b0;
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_output_handle_cs111 <=1'b1;
          end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_output_handle_global1_state=instance_inj_ctrl_instance_block_034_instance_fsm_global1_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_cs111=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_output_handle_cs111; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_t31=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph1_output_handle_t31; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_output_handle_global1_state=instance_inj_ctrl_instance_block_125_instance_fsm_global1_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_cs111=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_output_handle_cs111; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_t31=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph1_output_handle_t31; 
 parameter[1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state =0,instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_2_state=1,instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_3_state=2,instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_4_state=3; 
   reg [1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_current_state ;  
   reg [1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_next_state ;  
  always @(       posedge instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_clock or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_cur_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_end_on or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_end_period or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_i_fbk or  negedge instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_rst or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_sh_mode)
       begin :instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_clocked
         if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_rst==1'b0)
            begin 
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_current_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state;
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_global2_state <=2'b01;
            end 
          else 
            begin 
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_current_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_next_state;
              case (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_next_state)
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_global2_state <=2'b01;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_2_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_global2_state <=2'b10;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_3_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_global2_state <=2'b11;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_4_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_global2_state <=2'b00;
               default :;
              endcase 
            end 
       end
  
  always @(        instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_current_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_clock or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_cur_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_end_on or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_end_period or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_i_fbk or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_rst or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_sh_mode)
       begin :instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_set_next_state
         instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_current_state;
         case (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_current_state)
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_cur_state==5'b00101&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_sh_mode==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_i_fbk==1'b1)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_sh_mode==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_end_on==1'b1)))
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_2_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_cur_state!=5'b00101)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_2_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_cur_state==5'b00101)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_3_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_cur_state!=5'b00101)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_3_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_cur_state==5'b00101&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_sh_mode==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_i_fbk==1'b0)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_sh_mode==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_end_period==1'b1)))
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_4_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_cur_state!=5'b00101)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_4_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_ph2_handle_state_type_ph2_1_state;
          default :;
         endcase 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_clock=instance_inj_ctrl_instance_block_034_instance_fsm_clock; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_cur_state=instance_inj_ctrl_instance_block_034_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_end_on=instance_inj_ctrl_instance_block_034_instance_fsm_end_on; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_end_period=instance_inj_ctrl_instance_block_034_instance_fsm_end_period; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_i_fbk=instance_inj_ctrl_instance_block_034_instance_fsm_i_fbk; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_rst=instance_inj_ctrl_instance_block_034_instance_fsm_rst; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_sh_mode=instance_inj_ctrl_instance_block_034_instance_fsm_sh_mode; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_global2_state=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_handle_global2_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_clock=instance_inj_ctrl_instance_block_125_instance_fsm_clock; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_cur_state=instance_inj_ctrl_instance_block_125_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_end_on=instance_inj_ctrl_instance_block_125_instance_fsm_end_on; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_end_period=instance_inj_ctrl_instance_block_125_instance_fsm_end_period; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_i_fbk=instance_inj_ctrl_instance_block_125_instance_fsm_i_fbk; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_rst=instance_inj_ctrl_instance_block_125_instance_fsm_rst; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_sh_mode=instance_inj_ctrl_instance_block_125_instance_fsm_sh_mode; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_global2_state=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_handle_global2_state; 
  always @( instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_global2_state)
       begin 
         if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_global2_state==2'b00)
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_cs42 <=1'b1;
          else 
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_cs42 <=1'b0;
         if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_global2_state[1]==1'b1)
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_t12 <=1'b0;
          else 
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_t12 <=1'b1;
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_global2_state=instance_inj_ctrl_instance_block_034_instance_fsm_global2_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_cs42=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_cs42; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_t12=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph2_output_handle_t12; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_global2_state=instance_inj_ctrl_instance_block_125_instance_fsm_global2_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_cs42=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_cs42; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_t12=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph2_output_handle_t12; 
 parameter[1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state =0,instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_2_state=1,instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_3_state=2,instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_4_state=3; 
   reg [1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_current_state ;  
   reg [1:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state ;  
  always @(       posedge instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_clock or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_end_on or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_end_period or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_i_fbk or  negedge instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_rst or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_sh_mode)
       begin :instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_clocked
         if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_rst==1'b0)
            begin 
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_current_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state;
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_global4_state <=2'b01;
            end 
          else 
            begin 
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_current_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state;
              case (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state)
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_global4_state <=2'b01;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_2_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_global4_state <=2'b10;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_3_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_global4_state <=2'b11;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_4_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_global4_state <=2'b00;
               default :;
              endcase 
            end 
       end
  
  always @(        instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_current_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_clock or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_end_on or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_end_period or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_i_fbk or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_rst or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_sh_mode)
       begin :instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_set_next_state
         instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_current_state;
         case (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_current_state)
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state==5'b01001&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_sh_mode==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_i_fbk==1'b1)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_sh_mode==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_end_on==1'b1)))
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_2_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state!=5'b01001&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state!=5'b11001)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state;
                 else 
                   if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state==5'b11001&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_sh_mode==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_i_fbk==1'b1)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_sh_mode==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_end_on==1'b1)))
                      instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_2_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_2_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state==5'b01001|instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state==5'b11001)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_3_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state!=5'b01001&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state!=5'b11001)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_3_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state==5'b01001&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_sh_mode==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_i_fbk==1'b0)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_sh_mode==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_end_period==1'b1)))
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_4_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state!=5'b01001&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state!=5'b11001)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state;
                 else 
                   if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state==5'b11001&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_sh_mode==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_i_fbk==1'b0)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_sh_mode==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_end_period==1'b1)))
                      instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_4_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_4_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_ph4_handle_state_type_ph4_1_state;
          default :;
         endcase 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_clock=instance_inj_ctrl_instance_block_034_instance_fsm_clock; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_cur_state=instance_inj_ctrl_instance_block_034_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_end_on=instance_inj_ctrl_instance_block_034_instance_fsm_end_on; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_end_period=instance_inj_ctrl_instance_block_034_instance_fsm_end_period; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_i_fbk=instance_inj_ctrl_instance_block_034_instance_fsm_i_fbk; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_rst=instance_inj_ctrl_instance_block_034_instance_fsm_rst; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_sh_mode=instance_inj_ctrl_instance_block_034_instance_fsm_sh_mode; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_global4_state=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_handle_global4_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_clock=instance_inj_ctrl_instance_block_125_instance_fsm_clock; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_cur_state=instance_inj_ctrl_instance_block_125_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_end_on=instance_inj_ctrl_instance_block_125_instance_fsm_end_on; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_end_period=instance_inj_ctrl_instance_block_125_instance_fsm_end_period; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_i_fbk=instance_inj_ctrl_instance_block_125_instance_fsm_i_fbk; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_rst=instance_inj_ctrl_instance_block_125_instance_fsm_rst; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_sh_mode=instance_inj_ctrl_instance_block_125_instance_fsm_sh_mode; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_global4_state=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_handle_global4_state; 
  always @( instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_global4_state)
       begin 
         if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_global4_state==2'b00)
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_cs44 <=1'b1;
          else 
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_cs44 <=1'b0;
         if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_global4_state[1]==1'b1)
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_t14 <=1'b0;
          else 
            instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_t14 <=1'b1;
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_global4_state=instance_inj_ctrl_instance_block_034_instance_fsm_global4_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_cs44=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_cs44; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_t14=instance_inj_ctrl_instance_block_034_instance_fsm_instance_ph4_output_handle_t14; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_global4_state=instance_inj_ctrl_instance_block_125_instance_fsm_global4_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_cs44=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_cs44; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_t14=instance_inj_ctrl_instance_block_125_instance_fsm_instance_ph4_output_handle_t14; 
  always @(    instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t31 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t12 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t14 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_cur_state)
       begin :instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_vhdl_sel_actuator
         case (instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_cur_state)
          5 'b00000:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b00001:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t31;
             end 
          5 'b00010:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b1;
             end 
          5 'b00011:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b1;
             end 
          5 'b00100:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b00101:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t12;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b00110:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b00111:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01000:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01001:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t14;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01010:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01011:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01100:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01101:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01110:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b01111:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b11000:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b11001:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t14;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b1;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b11100:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          5 'b11101:
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
          default :
             begin 
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2 <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3 <=1'b0;
             end 
         endcase 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_cur_state=instance_inj_ctrl_instance_block_034_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t12=instance_inj_ctrl_instance_block_034_instance_fsm_t12; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t14=instance_inj_ctrl_instance_block_034_instance_fsm_t14; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t31=instance_inj_ctrl_instance_block_034_instance_fsm_t31; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_hl=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_hl; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_t1=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t1; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_t2=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t2; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_t3=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_actuator_t3; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_cur_state=instance_inj_ctrl_instance_block_125_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t12=instance_inj_ctrl_instance_block_125_instance_fsm_t12; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t14=instance_inj_ctrl_instance_block_125_instance_fsm_t14; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t31=instance_inj_ctrl_instance_block_125_instance_fsm_t31; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_hl=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_hl; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_t1=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t1; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_t2=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t2; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_t3=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_actuator_t3; 
  always @(   instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs42 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs44 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cur_state)
       begin :instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_vhdl_sel_chop_control
         case (instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cur_state)
          5 'b00101:
             instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs4 <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs42;
          5 'b01001:
             instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs4 <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs44;
          5 'b11001:
             instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs4 <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs44;
          default :
             instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs4 <=1'b1;
         endcase 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs42=instance_inj_ctrl_instance_block_034_instance_fsm_cs42; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs44=instance_inj_ctrl_instance_block_034_instance_fsm_cs44; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cur_state=instance_inj_ctrl_instance_block_034_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_cs4=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_chop_control_cs4; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs42=instance_inj_ctrl_instance_block_125_instance_fsm_cs42; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs44=instance_inj_ctrl_instance_block_125_instance_fsm_cs44; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cur_state=instance_inj_ctrl_instance_block_125_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_cs4=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_chop_control_cs4; 
  always @(    instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs11 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs111 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cur_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_global1_state)
       begin :instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_vhdl_sel_glob_count_cs
         if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cur_state==5'b00001)
            begin 
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs1 <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs111;
              if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_global1_state==1'b0)
                 instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs2 <=1'b1;
               else 
                 instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs2 <=1'b0;
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs8 <=1'b0;
            end 
          else 
            if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cur_state==5'b00000)
               begin 
                 instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs1 <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs11;
                 instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs2 <=1'b1;
                 instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs8 <=1'b1;
               end 
             else 
               begin 
                 instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs1 <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs11;
                 instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs2 <=1'b0;
                 instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs8 <=1'b1;
               end 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs11=instance_inj_ctrl_instance_block_034_instance_fsm_cs11; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs111=instance_inj_ctrl_instance_block_034_instance_fsm_cs111; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cur_state=instance_inj_ctrl_instance_block_034_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_global1_state=instance_inj_ctrl_instance_block_034_instance_fsm_global1_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_cs1=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs1; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_cs2=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs2; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_cs8=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_glob_count_cs_cs8; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs11=instance_inj_ctrl_instance_block_125_instance_fsm_cs11; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs111=instance_inj_ctrl_instance_block_125_instance_fsm_cs111; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cur_state=instance_inj_ctrl_instance_block_125_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_global1_state=instance_inj_ctrl_instance_block_125_instance_fsm_global1_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_cs1=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs1; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_cs2=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs2; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_cs8=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_glob_count_cs_cs8; 
  always @(    instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_cur_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global1_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global2_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global4_state)
       begin 
         instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global_state [6:2]<=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_cur_state;
         case (instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_cur_state)
          5 'b00001:
             instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global_state [1:0]<={1'b0,instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global1_state};
          5 'b00101:
             instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global_state [1:0]<=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global2_state;
          5 'b01001:
             instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global_state [1:0]<=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global4_state;
          5 'b11001:
             instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global_state [1:0]<=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global4_state;
          default :
             instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global_state [1:0]<=2'b00;
         endcase 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_cur_state=instance_inj_ctrl_instance_block_034_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global1_state=instance_inj_ctrl_instance_block_034_instance_fsm_global1_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global2_state=instance_inj_ctrl_instance_block_034_instance_fsm_global2_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global4_state=instance_inj_ctrl_instance_block_034_instance_fsm_global4_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_global_state=instance_inj_ctrl_instance_block_034_instance_fsm_instance_sel_global_state_global_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_cur_state=instance_inj_ctrl_instance_block_125_instance_fsm_cur_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global1_state=instance_inj_ctrl_instance_block_125_instance_fsm_global1_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global2_state=instance_inj_ctrl_instance_block_125_instance_fsm_global2_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global4_state=instance_inj_ctrl_instance_block_125_instance_fsm_global4_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_global_state=instance_inj_ctrl_instance_block_125_instance_fsm_instance_sel_global_state_global_state; 
 parameter[4:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_start_state =0,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph1bis_state=1,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph2_state=2,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph3_state=3,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph4_state=4,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph5_state=5,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph1_state=6,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state=7,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state=8,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int1_state=9,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int_2_state=10,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int3_state=11,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int4_state=12,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int5_state=13,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int6_state=14,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph6_state=15,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int7_state=16,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph7_state=17,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int8_state=18,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph8_state=19,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int9_state=20,instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph9_state=21; 
   reg [4:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_current_state ;  
   reg [4:0] instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state ;  
  always @(               posedge instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_clock or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cmd_stored or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_end_t0 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_inj_cmd or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_i_fbk or  negedge instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_rst or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_sh_mode or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_status_reg or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_t4_0 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_th_0 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_mask)
       begin :instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_clocked
         if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_rst==1'b0)
            begin 
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_current_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_start_state;
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b00000;
            end 
          else 
            begin 
              instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_current_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state;
              case (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state)
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_start_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b00000;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph1bis_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b00011;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph2_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b00101;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph3_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b00111;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph4_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b01001;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph5_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b01011;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph1_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b00001;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b11100;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b11101;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int1_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b00010;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int_2_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b00100;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int3_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b00110;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int4_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b01000;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int5_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b01010;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int6_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b01100;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph6_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b01101;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int7_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b01110;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph7_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b01111;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int8_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b11000;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph8_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b11001;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int9_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b01010;
               instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph9_state :
                  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state <=5'b01011;
               default :;
              endcase 
            end 
       end
  
  always @(                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_current_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_clock or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cmd_stored or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_end_t0 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_inj_cmd or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_i_fbk or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_rst or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_sh_mode or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_status_reg or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_t4_0 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_th_0 or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur or  instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_mask)
       begin :instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_set_next_state
         instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_current_state;
         case (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_current_state)
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_start_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_inj_cmd!=3'b000&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_mask==3'b000)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph1_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_inj_cmd!=3'b000&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_mask!=3'b000&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b0)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph1_state;
                 else 
                   if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_inj_cmd!=3'b000&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_mask!=3'b000&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b1)
                      instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph1bis_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int_2_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b1)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
                 else 
                   if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b0)
                      instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int_2_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph2_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b11)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b10)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b00)))
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int3_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b1)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
                 else 
                   if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b11&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b1)
                      instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state;
                    else 
                      if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b11)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b10)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b00))&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b0)
                         instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int3_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph3_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_th_0==1'b0)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int4_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b1)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state;
                 else 
                   if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_th_0==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1)
                      instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int5_state;
                    else 
                      if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_th_0==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b0)
                         instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int4_state;
                       else 
                         if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_th_0==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b0)
                            instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int5_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph4_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b11)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b10)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b00)))
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int5_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b11&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b1)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state;
                 else 
                   if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b1)
                      instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
                    else 
                      if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b11)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b10)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b00))&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b0)
                         instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int5_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph5_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_t4_0==1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_start_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_t4_0==1'b0)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int6_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph1_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_i_fbk==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_sh_mode==1'b1)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_sh_mode==1'b0)))
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int1_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b1)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
                 else 
                   if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[0]==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_i_fbk==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_sh_mode==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b1)
                      instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
                    else 
                      if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_inj_cmd!=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cmd_stored&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[0]==1'b0)
                         instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_start_state;
                       else 
                         if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0|((instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_i_fbk==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_sh_mode==1'b1)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_sh_mode==1'b0)))&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b0)
                            instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int1_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_status_reg==11'b00000000000)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_start_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_status_reg==11'b00000000000)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_start_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int1_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph1bis_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int_2_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph2_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int3_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph3_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int4_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph4_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int5_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph5_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int6_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph6_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph6_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int7_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int7_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph7_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph7_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b0)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int8_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1)
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int8_state;
                 else 
                   if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b1)
                      instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int8_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph8_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph8_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b11)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b10)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b00))&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b0)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int9_state;
              else 
                if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1&((instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b11)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b10)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1)|(instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b00)))
                   instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int9_state;
                 else 
                   if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b11&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b1&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b1)
                      instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_vcc_state;
                    else 
                      if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state[1:0]==2'b01&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur==1'b0&instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check==1'b1)
                         instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_cc_gnd_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_int9_state :
             if (1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph9_state;
          instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_ph9_state :
             if (instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp==1'b1)
                instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_next_state <=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_state_progression_state_type_start_state;
          default :;
         endcase 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_clock=instance_inj_ctrl_instance_block_034_instance_fsm_clock; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cmd_stored=instance_inj_ctrl_instance_block_034_instance_fsm_cmd_stored; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_comp=instance_inj_ctrl_instance_block_034_instance_fsm_comp; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_enable_check=instance_inj_ctrl_instance_block_034_instance_fsm_enable_check; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_end_t0=instance_inj_ctrl_instance_block_034_instance_fsm_end_t0; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_global_state=instance_inj_ctrl_instance_block_034_instance_fsm_global_state; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_inj_cmd=instance_inj_ctrl_instance_block_034_instance_fsm_inj_cmd; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_i_fbk=instance_inj_ctrl_instance_block_034_instance_fsm_i_fbk; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_rst=instance_inj_ctrl_instance_block_034_instance_fsm_rst; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_sh_mode=instance_inj_ctrl_instance_block_034_instance_fsm_sh_mode; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_status_reg=instance_inj_ctrl_instance_block_034_instance_fsm_status_reg; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_t4_0=instance_inj_ctrl_instance_block_034_instance_fsm_t4_0; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_th_0=instance_inj_ctrl_instance_block_034_instance_fsm_th_0; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_cur=instance_inj_ctrl_instance_block_034_instance_fsm_v_fbk_cur; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_v_fbk_mask=instance_inj_ctrl_instance_block_034_instance_fsm_v_fbk_mask; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_cur_state=instance_inj_ctrl_instance_block_034_instance_fsm_instance_state_progression_cur_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_clock=instance_inj_ctrl_instance_block_125_instance_fsm_clock; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cmd_stored=instance_inj_ctrl_instance_block_125_instance_fsm_cmd_stored; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_comp=instance_inj_ctrl_instance_block_125_instance_fsm_comp; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_enable_check=instance_inj_ctrl_instance_block_125_instance_fsm_enable_check; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_end_t0=instance_inj_ctrl_instance_block_125_instance_fsm_end_t0; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_global_state=instance_inj_ctrl_instance_block_125_instance_fsm_global_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_inj_cmd=instance_inj_ctrl_instance_block_125_instance_fsm_inj_cmd; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_i_fbk=instance_inj_ctrl_instance_block_125_instance_fsm_i_fbk; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_rst=instance_inj_ctrl_instance_block_125_instance_fsm_rst; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_sh_mode=instance_inj_ctrl_instance_block_125_instance_fsm_sh_mode; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_status_reg=instance_inj_ctrl_instance_block_125_instance_fsm_status_reg; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_t4_0=instance_inj_ctrl_instance_block_125_instance_fsm_t4_0; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_th_0=instance_inj_ctrl_instance_block_125_instance_fsm_th_0; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_cur=instance_inj_ctrl_instance_block_125_instance_fsm_v_fbk_cur; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_v_fbk_mask=instance_inj_ctrl_instance_block_125_instance_fsm_v_fbk_mask; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_cur_state=instance_inj_ctrl_instance_block_125_instance_fsm_instance_state_progression_cur_state; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_en_fbk_store=instance_inj_ctrl_instance_block_125_instance_fsm_en_fbk_store_internal; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_clock=instance_inj_ctrl_instance_block_034_clock; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_cmd_stored=instance_inj_ctrl_instance_block_034_cmd_stored; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_comp=instance_inj_ctrl_instance_block_034_comp; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_end_on=instance_inj_ctrl_instance_block_034_end_on; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_end_period=instance_inj_ctrl_instance_block_034_end_period; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_end_t0=instance_inj_ctrl_instance_block_034_end_t0; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_inj_cmd=instance_inj_ctrl_instance_block_034_inj_cmd; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_i_fbk=instance_inj_ctrl_instance_block_034_i_fbk; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_rst=instance_inj_ctrl_instance_block_034_rst; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_sh_mode=instance_inj_ctrl_instance_block_034_sh_mode; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_status_reg=instance_inj_ctrl_instance_block_034_status_reg; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_t4_0=instance_inj_ctrl_instance_block_034_t4_0; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_test_en_cur=instance_inj_ctrl_instance_block_034_test_en_cur; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_th_0=instance_inj_ctrl_instance_block_034_th_0; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_v_fbk_cur=instance_inj_ctrl_instance_block_034_v_fbk_cur; 
  assign instance_inj_ctrl_instance_block_034_instance_fsm_v_fbk_mask=instance_inj_ctrl_instance_block_034_v_fbk_mask; 
  assign instance_inj_ctrl_instance_block_034_cs0=instance_inj_ctrl_instance_block_034_instance_fsm_cs0; 
  assign instance_inj_ctrl_instance_block_034_cs1=instance_inj_ctrl_instance_block_034_instance_fsm_cs1; 
  assign instance_inj_ctrl_instance_block_034_cs2=instance_inj_ctrl_instance_block_034_instance_fsm_cs2; 
  assign instance_inj_ctrl_instance_block_034_cs4=instance_inj_ctrl_instance_block_034_instance_fsm_cs4; 
  assign instance_inj_ctrl_instance_block_034_cs8=instance_inj_ctrl_instance_block_034_instance_fsm_cs8; 
  assign instance_inj_ctrl_instance_block_034_en_fbk_store=instance_inj_ctrl_instance_block_034_instance_fsm_en_fbk_store; 
  assign instance_inj_ctrl_instance_block_034_en_state_store=instance_inj_ctrl_instance_block_034_instance_fsm_en_state_store; 
  assign instance_inj_ctrl_instance_block_034_error=instance_inj_ctrl_instance_block_034_instance_fsm_error; 
  assign instance_inj_ctrl_instance_block_034_global_state_store=instance_inj_ctrl_instance_block_034_instance_fsm_global_state_store; 
  assign instance_inj_ctrl_instance_block_034_hl=instance_inj_ctrl_instance_block_034_instance_fsm_hl; 
  assign instance_inj_ctrl_instance_block_034_relpot=instance_inj_ctrl_instance_block_034_instance_fsm_relpot; 
  assign instance_inj_ctrl_instance_block_034_t1=instance_inj_ctrl_instance_block_034_instance_fsm_t1; 
  assign instance_inj_ctrl_instance_block_034_t2=instance_inj_ctrl_instance_block_034_instance_fsm_t2; 
  assign instance_inj_ctrl_instance_block_034_t3=instance_inj_ctrl_instance_block_034_instance_fsm_t3; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_clock=instance_inj_ctrl_instance_block_125_clock; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_cmd_stored=instance_inj_ctrl_instance_block_125_cmd_stored; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_comp=instance_inj_ctrl_instance_block_125_comp; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_end_on=instance_inj_ctrl_instance_block_125_end_on; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_end_period=instance_inj_ctrl_instance_block_125_end_period; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_end_t0=instance_inj_ctrl_instance_block_125_end_t0; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_inj_cmd=instance_inj_ctrl_instance_block_125_inj_cmd; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_i_fbk=instance_inj_ctrl_instance_block_125_i_fbk; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_rst=instance_inj_ctrl_instance_block_125_rst; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_sh_mode=instance_inj_ctrl_instance_block_125_sh_mode; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_status_reg=instance_inj_ctrl_instance_block_125_status_reg; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_t4_0=instance_inj_ctrl_instance_block_125_t4_0; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_test_en_cur=instance_inj_ctrl_instance_block_125_test_en_cur; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_th_0=instance_inj_ctrl_instance_block_125_th_0; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_v_fbk_cur=instance_inj_ctrl_instance_block_125_v_fbk_cur; 
  assign instance_inj_ctrl_instance_block_125_instance_fsm_v_fbk_mask=instance_inj_ctrl_instance_block_125_v_fbk_mask; 
  assign instance_inj_ctrl_instance_block_125_cs0=instance_inj_ctrl_instance_block_125_instance_fsm_cs0; 
  assign instance_inj_ctrl_instance_block_125_cs1=instance_inj_ctrl_instance_block_125_instance_fsm_cs1; 
  assign instance_inj_ctrl_instance_block_125_cs2=instance_inj_ctrl_instance_block_125_instance_fsm_cs2; 
  assign instance_inj_ctrl_instance_block_125_cs4=instance_inj_ctrl_instance_block_125_instance_fsm_cs4; 
  assign instance_inj_ctrl_instance_block_125_cs8=instance_inj_ctrl_instance_block_125_instance_fsm_cs8; 
  assign instance_inj_ctrl_instance_block_125_en_fbk_store=instance_inj_ctrl_instance_block_125_instance_fsm_en_fbk_store; 
  assign instance_inj_ctrl_instance_block_125_en_state_store=instance_inj_ctrl_instance_block_125_instance_fsm_en_state_store; 
  assign instance_inj_ctrl_instance_block_125_error=instance_inj_ctrl_instance_block_125_instance_fsm_error; 
  assign instance_inj_ctrl_instance_block_125_global_state_store=instance_inj_ctrl_instance_block_125_instance_fsm_global_state_store; 
  assign instance_inj_ctrl_instance_block_125_hl=instance_inj_ctrl_instance_block_125_instance_fsm_hl; 
  assign instance_inj_ctrl_instance_block_125_relpot=instance_inj_ctrl_instance_block_125_instance_fsm_relpot; 
  assign instance_inj_ctrl_instance_block_125_t1=instance_inj_ctrl_instance_block_125_instance_fsm_t1; 
  assign instance_inj_ctrl_instance_block_125_t2=instance_inj_ctrl_instance_block_125_instance_fsm_t2; 
  assign instance_inj_ctrl_instance_block_125_t3=instance_inj_ctrl_instance_block_125_instance_fsm_t3; 
   reg [12-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_th ;  
   reg [10-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_tb ;  
   reg [7-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_tonh ;  
   reg [7-1:0] instance_inj_ctrl_instance_block_125_instance_internal_register_tonl ;  
  always @(  posedge instance_inj_ctrl_instance_block_125_instance_internal_register_clock or  negedge instance_inj_ctrl_instance_block_125_instance_internal_register_rst)
       begin :instance_inj_ctrl_instance_block_125_instance_internal_register_vhdl_internal_register
         if (instance_inj_ctrl_instance_block_125_instance_internal_register_rst==1'b0)
            begin 
              instance_inj_ctrl_instance_block_125_instance_internal_register_tb <={10{1'b0}};
              instance_inj_ctrl_instance_block_125_instance_internal_register_th <={12{1'b0}};
              instance_inj_ctrl_instance_block_125_instance_internal_register_tonh <={7{1'b0}};
              instance_inj_ctrl_instance_block_125_instance_internal_register_tonl <={7{1'b0}};
            end 
          else 
            begin 
              if (instance_inj_ctrl_instance_block_125_instance_internal_register_cs2==1'b1)
                 begin 
                   instance_inj_ctrl_instance_block_125_instance_internal_register_tb <=instance_inj_ctrl_instance_block_125_instance_internal_register_r_tb;
                   instance_inj_ctrl_instance_block_125_instance_internal_register_th <=instance_inj_ctrl_instance_block_125_instance_internal_register_r_th;
                   instance_inj_ctrl_instance_block_125_instance_internal_register_tonh <=instance_inj_ctrl_instance_block_125_instance_internal_register_r_tonh;
                   instance_inj_ctrl_instance_block_125_instance_internal_register_tonl <=instance_inj_ctrl_instance_block_125_instance_internal_register_r_tonl;
                 end 
            end 
       end
  
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_tp_reg=instance_inj_ctrl_instance_block_125_instance_internal_register_r_tp; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_sh_mode=instance_inj_ctrl_instance_block_125_instance_internal_register_tb[9]; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_th_0=(~(instance_inj_ctrl_instance_block_125_instance_internal_register_th[0]|instance_inj_ctrl_instance_block_125_instance_internal_register_th[1]|instance_inj_ctrl_instance_block_125_instance_internal_register_th[2]|instance_inj_ctrl_instance_block_125_instance_internal_register_th[3]|instance_inj_ctrl_instance_block_125_instance_internal_register_th[4]|instance_inj_ctrl_instance_block_125_instance_internal_register_th[5]|instance_inj_ctrl_instance_block_125_instance_internal_register_th[6]|instance_inj_ctrl_instance_block_125_instance_internal_register_th[7]|instance_inj_ctrl_instance_block_125_instance_internal_register_th[8]|instance_inj_ctrl_instance_block_125_instance_internal_register_th[9]|instance_inj_ctrl_instance_block_125_instance_internal_register_th[10]|instance_inj_ctrl_instance_block_125_instance_internal_register_th[11])); 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_t4_0=(~(instance_inj_ctrl_instance_block_125_instance_internal_register_r_t4[6]|instance_inj_ctrl_instance_block_125_instance_internal_register_r_t4[5]|instance_inj_ctrl_instance_block_125_instance_internal_register_r_t4[4]|instance_inj_ctrl_instance_block_125_instance_internal_register_r_t4[3])); 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0000)?{5'b00000,instance_inj_ctrl_instance_block_125_instance_internal_register_r_t1[7:1]}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0000)?instance_inj_ctrl_instance_block_125_instance_internal_register_tonh:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0001)?{5'b00000,instance_inj_ctrl_instance_block_125_instance_internal_register_r_t1[7:1]}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0001)?instance_inj_ctrl_instance_block_125_instance_internal_register_tonh:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0010)?{3'b000,instance_inj_ctrl_instance_block_125_instance_internal_register_tb[8:0]}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0010)?instance_inj_ctrl_instance_block_125_instance_internal_register_tonh:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0011)?{5'b00000,instance_inj_ctrl_instance_block_125_instance_internal_register_r_t2}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0011)?instance_inj_ctrl_instance_block_125_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0100)?instance_inj_ctrl_instance_block_125_instance_internal_register_th:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0100)?instance_inj_ctrl_instance_block_125_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0101)?{5'b00000,instance_inj_ctrl_instance_block_125_instance_internal_register_r_t1[7:1]}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0101)?instance_inj_ctrl_instance_block_125_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0110)?{4'b0000,instance_inj_ctrl_instance_block_125_instance_internal_register_r_t3}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0110)?instance_inj_ctrl_instance_block_125_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0111)?{3'b000,instance_inj_ctrl_instance_block_125_instance_internal_register_r_t1,1'b0}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b0111)?instance_inj_ctrl_instance_block_125_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b1100)?{5'b00000,instance_inj_ctrl_instance_block_125_instance_internal_register_r_t4}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0==4'b1100)?instance_inj_ctrl_instance_block_125_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_stop_count_bus=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0[3:1]==3'b111)?{4'b0000,instance_inj_ctrl_instance_block_125_instance_internal_register_r_t1}:12'bZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_ton_reg=(instance_inj_ctrl_instance_block_125_instance_internal_register_cs0[3:1]==3'b111)?instance_inj_ctrl_instance_block_125_instance_internal_register_tonl:7'bZZZZZZZ; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_clock=instance_inj_ctrl_instance_block_034_clock; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_cs0=instance_inj_ctrl_instance_block_034_cs0; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_cs2=instance_inj_ctrl_instance_block_034_cs2; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_rst=instance_inj_ctrl_instance_block_034_rst; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_r_t1=instance_inj_ctrl_instance_block_034_r_t1; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_r_t2=instance_inj_ctrl_instance_block_034_r_t2; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_r_t3=instance_inj_ctrl_instance_block_034_r_t3; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_r_t4=instance_inj_ctrl_instance_block_034_r_t4; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_r_tb=instance_inj_ctrl_instance_block_034_r_tb; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_r_th=instance_inj_ctrl_instance_block_034_r_th; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_r_tonh=instance_inj_ctrl_instance_block_034_r_tonh; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_r_tonl=instance_inj_ctrl_instance_block_034_r_tonl; 
  assign instance_inj_ctrl_instance_block_034_instance_internal_register_r_tp=instance_inj_ctrl_instance_block_034_r_tp; 
  assign instance_inj_ctrl_instance_block_034_sh_mode=instance_inj_ctrl_instance_block_034_instance_internal_register_sh_mode; 
  assign instance_inj_ctrl_instance_block_034_stop_count_bus=instance_inj_ctrl_instance_block_034_instance_internal_register_stop_count_bus; 
  assign instance_inj_ctrl_instance_block_034_t4_0=instance_inj_ctrl_instance_block_034_instance_internal_register_t4_0; 
  assign instance_inj_ctrl_instance_block_034_th_0=instance_inj_ctrl_instance_block_034_instance_internal_register_th_0; 
  assign instance_inj_ctrl_instance_block_034_ton_reg=instance_inj_ctrl_instance_block_034_instance_internal_register_ton_reg; 
  assign instance_inj_ctrl_instance_block_034_tp_reg=instance_inj_ctrl_instance_block_034_instance_internal_register_tp_reg; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_clock=instance_inj_ctrl_instance_block_125_clock; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_cs0=instance_inj_ctrl_instance_block_125_cs0; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_cs2=instance_inj_ctrl_instance_block_125_cs2; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_rst=instance_inj_ctrl_instance_block_125_rst; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_r_t1=instance_inj_ctrl_instance_block_125_r_t1; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_r_t2=instance_inj_ctrl_instance_block_125_r_t2; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_r_t3=instance_inj_ctrl_instance_block_125_r_t3; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_r_t4=instance_inj_ctrl_instance_block_125_r_t4; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_r_tb=instance_inj_ctrl_instance_block_125_r_tb; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_r_th=instance_inj_ctrl_instance_block_125_r_th; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_r_tonh=instance_inj_ctrl_instance_block_125_r_tonh; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_r_tonl=instance_inj_ctrl_instance_block_125_r_tonl; 
  assign instance_inj_ctrl_instance_block_125_instance_internal_register_r_tp=instance_inj_ctrl_instance_block_125_r_tp; 
  assign instance_inj_ctrl_instance_block_125_sh_mode=instance_inj_ctrl_instance_block_125_instance_internal_register_sh_mode; 
  assign instance_inj_ctrl_instance_block_125_stop_count_bus=instance_inj_ctrl_instance_block_125_instance_internal_register_stop_count_bus; 
  assign instance_inj_ctrl_instance_block_125_t4_0=instance_inj_ctrl_instance_block_125_instance_internal_register_t4_0; 
  assign instance_inj_ctrl_instance_block_125_th_0=instance_inj_ctrl_instance_block_125_instance_internal_register_th_0; 
  assign instance_inj_ctrl_instance_block_125_ton_reg=instance_inj_ctrl_instance_block_125_instance_internal_register_ton_reg; 
  assign instance_inj_ctrl_instance_block_125_tp_reg=instance_inj_ctrl_instance_block_125_instance_internal_register_tp_reg; 
  always @(  instance_inj_ctrl_instance_block_125_instance_on_comp_chop_count or  instance_inj_ctrl_instance_block_125_instance_on_comp_ton_reg)
       begin :instance_inj_ctrl_instance_block_125_instance_on_comp_vhdl_on_comp
         if (instance_inj_ctrl_instance_block_125_instance_on_comp_chop_count==instance_inj_ctrl_instance_block_125_instance_on_comp_ton_reg)
            instance_inj_ctrl_instance_block_125_instance_on_comp_end_on <=1'b1;
          else 
            instance_inj_ctrl_instance_block_125_instance_on_comp_end_on <=1'b0;
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_on_comp_chop_count=instance_inj_ctrl_instance_block_034_chop_count; 
  assign instance_inj_ctrl_instance_block_034_instance_on_comp_ton_reg=instance_inj_ctrl_instance_block_034_ton_reg; 
  assign instance_inj_ctrl_instance_block_034_end_on=instance_inj_ctrl_instance_block_034_instance_on_comp_end_on; 
  assign instance_inj_ctrl_instance_block_125_instance_on_comp_chop_count=instance_inj_ctrl_instance_block_125_chop_count; 
  assign instance_inj_ctrl_instance_block_125_instance_on_comp_ton_reg=instance_inj_ctrl_instance_block_125_ton_reg; 
  assign instance_inj_ctrl_instance_block_125_end_on=instance_inj_ctrl_instance_block_125_instance_on_comp_end_on; 
  always @(   instance_inj_ctrl_instance_block_125_instance_output_decoder_cmd_stored or  instance_inj_ctrl_instance_block_125_instance_output_decoder_t1 or  instance_inj_ctrl_instance_block_125_instance_output_decoder_t2)
       begin :instance_inj_ctrl_instance_block_125_instance_output_decoder_vhdl_output_decoder
         case (instance_inj_ctrl_instance_block_125_instance_output_decoder_cmd_stored)
          3 'b001:
             begin 
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t1a <=instance_inj_ctrl_instance_block_125_instance_output_decoder_t1;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t2a <=instance_inj_ctrl_instance_block_125_instance_output_decoder_t2;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t1b <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t2b <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t1c <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t2c <=1'b0;
             end 
          3 'b010:
             begin 
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t1b <=instance_inj_ctrl_instance_block_125_instance_output_decoder_t1;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t2b <=instance_inj_ctrl_instance_block_125_instance_output_decoder_t2;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t1a <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t2a <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t1c <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t2c <=1'b0;
             end 
          3 'b100:
             begin 
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t1c <=instance_inj_ctrl_instance_block_125_instance_output_decoder_t1;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t2c <=instance_inj_ctrl_instance_block_125_instance_output_decoder_t2;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t1b <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t2b <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t1a <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t2a <=1'b0;
             end 
          default :
             begin 
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t1a <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t2a <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t1b <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t2b <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t1c <=1'b0;
               instance_inj_ctrl_instance_block_125_instance_output_decoder_t2c <=1'b0;
             end 
         endcase 
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_output_decoder_cmd_stored=instance_inj_ctrl_instance_block_034_cmd_stored; 
  assign instance_inj_ctrl_instance_block_034_instance_output_decoder_t1=instance_inj_ctrl_instance_block_034_t1; 
  assign instance_inj_ctrl_instance_block_034_instance_output_decoder_t2=instance_inj_ctrl_instance_block_034_t2; 
  assign instance_inj_ctrl_instance_block_034_t1a=instance_inj_ctrl_instance_block_034_instance_output_decoder_t1a; 
  assign instance_inj_ctrl_instance_block_034_t1b=instance_inj_ctrl_instance_block_034_instance_output_decoder_t1b; 
  assign instance_inj_ctrl_instance_block_034_t1c=instance_inj_ctrl_instance_block_034_instance_output_decoder_t1c; 
  assign instance_inj_ctrl_instance_block_034_t2a=instance_inj_ctrl_instance_block_034_instance_output_decoder_t2a; 
  assign instance_inj_ctrl_instance_block_034_t2b=instance_inj_ctrl_instance_block_034_instance_output_decoder_t2b; 
  assign instance_inj_ctrl_instance_block_034_t2c=instance_inj_ctrl_instance_block_034_instance_output_decoder_t2c; 
  assign instance_inj_ctrl_instance_block_125_instance_output_decoder_cmd_stored=instance_inj_ctrl_instance_block_125_cmd_stored; 
  assign instance_inj_ctrl_instance_block_125_instance_output_decoder_t1=instance_inj_ctrl_instance_block_125_t1; 
  assign instance_inj_ctrl_instance_block_125_instance_output_decoder_t2=instance_inj_ctrl_instance_block_125_t2; 
  assign instance_inj_ctrl_instance_block_125_t1a=instance_inj_ctrl_instance_block_125_instance_output_decoder_t1a; 
  assign instance_inj_ctrl_instance_block_125_t1b=instance_inj_ctrl_instance_block_125_instance_output_decoder_t1b; 
  assign instance_inj_ctrl_instance_block_125_t1c=instance_inj_ctrl_instance_block_125_instance_output_decoder_t1c; 
  assign instance_inj_ctrl_instance_block_125_t2a=instance_inj_ctrl_instance_block_125_instance_output_decoder_t2a; 
  assign instance_inj_ctrl_instance_block_125_t2b=instance_inj_ctrl_instance_block_125_instance_output_decoder_t2b; 
  assign instance_inj_ctrl_instance_block_125_t2c=instance_inj_ctrl_instance_block_125_instance_output_decoder_t2c; 
  always @(  instance_inj_ctrl_instance_block_125_instance_period_comp_chop_count or  instance_inj_ctrl_instance_block_125_instance_period_comp_tp_reg)
       begin :instance_inj_ctrl_instance_block_125_instance_period_comp_vhdl_period_comp
         if (instance_inj_ctrl_instance_block_125_instance_period_comp_chop_count==instance_inj_ctrl_instance_block_125_instance_period_comp_tp_reg)
            instance_inj_ctrl_instance_block_125_instance_period_comp_end_period <=1'b1;
          else 
            instance_inj_ctrl_instance_block_125_instance_period_comp_end_period <=1'b0;
       end
  
  assign instance_inj_ctrl_instance_block_034_instance_period_comp_chop_count=instance_inj_ctrl_instance_block_034_chop_count; 
  assign instance_inj_ctrl_instance_block_034_instance_period_comp_tp_reg=instance_inj_ctrl_instance_block_034_tp_reg; 
  assign instance_inj_ctrl_instance_block_034_end_period=instance_inj_ctrl_instance_block_034_instance_period_comp_end_period; 
  assign instance_inj_ctrl_instance_block_125_instance_period_comp_chop_count=instance_inj_ctrl_instance_block_125_chop_count; 
  assign instance_inj_ctrl_instance_block_125_instance_period_comp_tp_reg=instance_inj_ctrl_instance_block_125_tp_reg; 
  assign instance_inj_ctrl_instance_block_125_end_period=instance_inj_ctrl_instance_block_125_instance_period_comp_end_period; 
   reg [2:0] instance_inj_ctrl_instance_block_125_instance_sel_cmd_cmd_stored_int ;  
  always @(  posedge instance_inj_ctrl_instance_block_125_instance_sel_cmd_clock or  negedge instance_inj_ctrl_instance_block_125_instance_sel_cmd_rst)
       begin :instance_inj_ctrl_instance_block_125_instance_sel_cmd_vhdl_sel_cmd
         if (instance_inj_ctrl_instance_block_125_instance_sel_cmd_rst==1'b0)
            instance_inj_ctrl_instance_block_125_instance_sel_cmd_cmd_stored_int <=3'b000;
          else 
            begin 
              if (instance_inj_ctrl_instance_block_125_instance_sel_cmd_cs2==1'b1)
                 instance_inj_ctrl_instance_block_125_instance_sel_cmd_cmd_stored_int <=instance_inj_ctrl_instance_block_125_instance_sel_cmd_inj_cmd;
            end 
       end
  
  always @(   instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk or  instance_inj_ctrl_instance_block_125_instance_sel_cmd_cmd_stored_int or  instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en)
       case (instance_inj_ctrl_instance_block_125_instance_sel_cmd_cmd_stored_int)
        3 'b001:
           begin 
             instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk_cur <=instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk[0];
             instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en_cur <=instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en[0];
           end 
        3 'b010:
           begin 
             instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk_cur <=instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk[1];
             instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en_cur <=instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en[1];
           end 
        3 'b100:
           begin 
             instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk_cur <=instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk[2];
             instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en_cur <=instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en[2];
           end 
        default :
           begin 
             instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk_cur <=1'b0;
             instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en_cur <=1'b1;
           end 
       endcase
  
  assign instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk_mask[0]=instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk[0]&instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en[0]; 
  assign instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk_mask[1]=instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk[1]&instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en[1]; 
  assign instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk_mask[2]=instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk[2]&instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en[2]; 
  assign instance_inj_ctrl_instance_block_125_instance_sel_cmd_cmd_stored=instance_inj_ctrl_instance_block_125_instance_sel_cmd_cmd_stored_int; 
  assign instance_inj_ctrl_instance_block_034_instance_sel_cmd_clock=instance_inj_ctrl_instance_block_034_clock; 
  assign instance_inj_ctrl_instance_block_034_instance_sel_cmd_cs2=instance_inj_ctrl_instance_block_034_cs2; 
  assign instance_inj_ctrl_instance_block_034_instance_sel_cmd_inj_cmd=instance_inj_ctrl_instance_block_034_inj_cmd; 
  assign instance_inj_ctrl_instance_block_034_instance_sel_cmd_rst=instance_inj_ctrl_instance_block_034_rst; 
  assign instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en=instance_inj_ctrl_instance_block_034_test_en; 
  assign instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk=instance_inj_ctrl_instance_block_034_v_fbk; 
  assign instance_inj_ctrl_instance_block_034_cmd_stored=instance_inj_ctrl_instance_block_034_instance_sel_cmd_cmd_stored; 
  assign instance_inj_ctrl_instance_block_034_test_en_cur=instance_inj_ctrl_instance_block_034_instance_sel_cmd_test_en_cur; 
  assign instance_inj_ctrl_instance_block_034_v_fbk_cur=instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk_cur; 
  assign instance_inj_ctrl_instance_block_034_v_fbk_mask=instance_inj_ctrl_instance_block_034_instance_sel_cmd_v_fbk_mask; 
  assign instance_inj_ctrl_instance_block_125_instance_sel_cmd_clock=instance_inj_ctrl_instance_block_125_clock; 
  assign instance_inj_ctrl_instance_block_125_instance_sel_cmd_cs2=instance_inj_ctrl_instance_block_125_cs2; 
  assign instance_inj_ctrl_instance_block_125_instance_sel_cmd_inj_cmd=instance_inj_ctrl_instance_block_125_inj_cmd; 
  assign instance_inj_ctrl_instance_block_125_instance_sel_cmd_rst=instance_inj_ctrl_instance_block_125_rst; 
  assign instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en=instance_inj_ctrl_instance_block_125_test_en; 
  assign instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk=instance_inj_ctrl_instance_block_125_v_fbk; 
  assign instance_inj_ctrl_instance_block_125_cmd_stored=instance_inj_ctrl_instance_block_125_instance_sel_cmd_cmd_stored; 
  assign instance_inj_ctrl_instance_block_125_test_en_cur=instance_inj_ctrl_instance_block_125_instance_sel_cmd_test_en_cur; 
  assign instance_inj_ctrl_instance_block_125_v_fbk_cur=instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk_cur; 
  assign instance_inj_ctrl_instance_block_125_v_fbk_mask=instance_inj_ctrl_instance_block_125_instance_sel_cmd_v_fbk_mask; 
  assign instance_inj_ctrl_instance_block_034_clock=instance_inj_ctrl_clock_internal; 
  assign instance_inj_ctrl_instance_block_034_inj_cmd=instance_inj_ctrl_inj_cmd_034; 
  assign instance_inj_ctrl_instance_block_034_i_fbk=instance_inj_ctrl_i_fbk_034; 
  assign instance_inj_ctrl_instance_block_034_rst=instance_inj_ctrl_rst; 
  assign instance_inj_ctrl_instance_block_034_r_t1=instance_inj_ctrl_r_t1; 
  assign instance_inj_ctrl_instance_block_034_r_t2=instance_inj_ctrl_r_t2; 
  assign instance_inj_ctrl_instance_block_034_r_t3=instance_inj_ctrl_r_t3_034; 
  assign instance_inj_ctrl_instance_block_034_r_t4=instance_inj_ctrl_r_t4_034; 
  assign instance_inj_ctrl_instance_block_034_r_tb=instance_inj_ctrl_r_tb_034; 
  assign instance_inj_ctrl_instance_block_034_r_th=instance_inj_ctrl_r_th_034; 
  assign instance_inj_ctrl_instance_block_034_r_tonh=instance_inj_ctrl_r_tonh; 
  assign instance_inj_ctrl_instance_block_034_r_tonl=instance_inj_ctrl_r_tonl; 
  assign instance_inj_ctrl_instance_block_034_r_tp=instance_inj_ctrl_r_tp; 
  assign instance_inj_ctrl_instance_block_034_status_reg=instance_inj_ctrl_status_reg_034; 
  assign instance_inj_ctrl_instance_block_034_test_en=instance_inj_ctrl_test_en_034; 
  assign instance_inj_ctrl_instance_block_034_v_fbk=instance_inj_ctrl_v_fbk_034; 
  assign instance_inj_ctrl_en_fbk_store_034=instance_inj_ctrl_instance_block_034_en_fbk_store; 
  assign instance_inj_ctrl_en_state_store_034=instance_inj_ctrl_instance_block_034_en_state_store; 
  assign instance_inj_ctrl_error1=instance_inj_ctrl_instance_block_034_error; 
  assign instance_inj_ctrl_global_state_034=instance_inj_ctrl_instance_block_034_global_state_store; 
  assign instance_inj_ctrl_hl_034=instance_inj_ctrl_instance_block_034_hl; 
  assign instance_inj_ctrl_relpot1=instance_inj_ctrl_instance_block_034_relpot; 
  assign instance_inj_ctrl_t1_0=instance_inj_ctrl_instance_block_034_t1a; 
  assign instance_inj_ctrl_t1_3=instance_inj_ctrl_instance_block_034_t1b; 
  assign instance_inj_ctrl_t1_4=instance_inj_ctrl_instance_block_034_t1c; 
  assign instance_inj_ctrl_t2_0=instance_inj_ctrl_instance_block_034_t2a; 
  assign instance_inj_ctrl_t2_3=instance_inj_ctrl_instance_block_034_t2b; 
  assign instance_inj_ctrl_t2_4=instance_inj_ctrl_instance_block_034_t2c; 
  assign instance_inj_ctrl_t3_034=instance_inj_ctrl_instance_block_034_t3; 
  assign instance_inj_ctrl_instance_block_125_clock=instance_inj_ctrl_clock_internal; 
  assign instance_inj_ctrl_instance_block_125_inj_cmd=instance_inj_ctrl_inj_cmd_125; 
  assign instance_inj_ctrl_instance_block_125_i_fbk=instance_inj_ctrl_i_fbk_125; 
  assign instance_inj_ctrl_instance_block_125_rst=instance_inj_ctrl_rst; 
  assign instance_inj_ctrl_instance_block_125_r_t1=instance_inj_ctrl_r_t1; 
  assign instance_inj_ctrl_instance_block_125_r_t2=instance_inj_ctrl_r_t2; 
  assign instance_inj_ctrl_instance_block_125_r_t3=instance_inj_ctrl_r_t3_125; 
  assign instance_inj_ctrl_instance_block_125_r_t4=instance_inj_ctrl_r_t4_125; 
  assign instance_inj_ctrl_instance_block_125_r_tb=instance_inj_ctrl_r_tb_125; 
  assign instance_inj_ctrl_instance_block_125_r_th=instance_inj_ctrl_r_th_125; 
  assign instance_inj_ctrl_instance_block_125_r_tonh=instance_inj_ctrl_r_tonh; 
  assign instance_inj_ctrl_instance_block_125_r_tonl=instance_inj_ctrl_r_tonl; 
  assign instance_inj_ctrl_instance_block_125_r_tp=instance_inj_ctrl_r_tp; 
  assign instance_inj_ctrl_instance_block_125_status_reg=instance_inj_ctrl_status_reg_125; 
  assign instance_inj_ctrl_instance_block_125_test_en=instance_inj_ctrl_test_en_125; 
  assign instance_inj_ctrl_instance_block_125_v_fbk=instance_inj_ctrl_v_fbk_125; 
  assign instance_inj_ctrl_en_fbk_store_125=instance_inj_ctrl_instance_block_125_en_fbk_store; 
  assign instance_inj_ctrl_en_state_store_125=instance_inj_ctrl_instance_block_125_en_state_store; 
  assign instance_inj_ctrl_error2=instance_inj_ctrl_instance_block_125_error; 
  assign instance_inj_ctrl_global_state_125=instance_inj_ctrl_instance_block_125_global_state_store; 
  assign instance_inj_ctrl_hl_125=instance_inj_ctrl_instance_block_125_hl; 
  assign instance_inj_ctrl_relpot2=instance_inj_ctrl_instance_block_125_relpot; 
  assign instance_inj_ctrl_t1_1=instance_inj_ctrl_instance_block_125_t1a; 
  assign instance_inj_ctrl_t1_2=instance_inj_ctrl_instance_block_125_t1b; 
  assign instance_inj_ctrl_t1_5=instance_inj_ctrl_instance_block_125_t1c; 
  assign instance_inj_ctrl_t2_1=instance_inj_ctrl_instance_block_125_t2a; 
  assign instance_inj_ctrl_t2_2=instance_inj_ctrl_instance_block_125_t2b; 
  assign instance_inj_ctrl_t2_5=instance_inj_ctrl_instance_block_125_t2c; 
  assign instance_inj_ctrl_t3_125=instance_inj_ctrl_instance_block_125_t3; 
   wire instance_inj_ctrl_instance_clock_gen_rst ;  
   wire instance_inj_ctrl_instance_clock_gen_clock_o ;  
   reg [3:0] instance_inj_ctrl_instance_clock_gen_counter ;  
   reg instance_inj_ctrl_instance_clock_gen_clock_int ;  
  always @(  posedge instance_inj_ctrl_instance_clock_gen_clock_i or  negedge instance_inj_ctrl_instance_clock_gen_rst)
       begin :instance_inj_ctrl_instance_clock_gen_vhdl_clock_gen
         if (instance_inj_ctrl_instance_clock_gen_rst==1'b0)
            begin 
              instance_inj_ctrl_instance_clock_gen_counter <={4{1'b0}};
              instance_inj_ctrl_instance_clock_gen_clock_int <=1'b0;
            end 
          else 
            begin 
              if (instance_inj_ctrl_instance_clock_gen_counter==4'b1001)
                 begin 
                   instance_inj_ctrl_instance_clock_gen_counter <=4'b0000;
                   instance_inj_ctrl_instance_clock_gen_clock_int <=(~instance_inj_ctrl_instance_clock_gen_clock_int);
                 end 
               else 
                 instance_inj_ctrl_instance_clock_gen_counter <=instance_inj_ctrl_instance_clock_gen_counter+4'b0001;
            end 
       end
  
  assign instance_inj_ctrl_instance_clock_gen_clock_o=instance_inj_ctrl_instance_clock_gen_clock_int; 
  assign instance_inj_ctrl_instance_clock_gen_rst=instance_inj_ctrl_clock; 
  assign instance_inj_ctrl_rst=instance_inj_ctrl_instance_clock_gen_clock_o; 
   wire instance_inj_ctrl_instance_d_bus_interface_clock ;  
   wire instance_inj_ctrl_instance_d_bus_interface_cs ;  
   wire instance_inj_ctrl_instance_d_bus_interface_ds ;  
   wire instance_inj_ctrl_instance_d_bus_interface_rst ;  
   wire instance_inj_ctrl_instance_d_bus_interface_r_w ;  
   wire instance_inj_ctrl_instance_d_bus_interface_rd_en ;  
   wire instance_inj_ctrl_instance_d_bus_interface_wr_en ;  
   wire instance_inj_ctrl_instance_d_bus_interface_rd_en_internal ;  
   wire instance_inj_ctrl_instance_d_bus_interface_wr_en_internal ;  
   wire instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_clock ;  
   wire instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_rd_en ;  
   wire instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_rst ;  
   wire instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_wr_en ;  
   reg [16-1:0] instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_d_bus_int ;  
  assign instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_d_bus=((instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_wr_en==1'b1))?instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_d_bus_int:16'bZZZZZZZZZZZZZZZZ; 
  assign instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_d_bus_ext=((instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_rd_en==1'b1))?instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_d_bus:16'bZZZZZZZZZZZZZZZZ; 
  always @(  posedge instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_clock or  negedge instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_rst)
       begin :instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_vhdl_d_bus_handle
         if (instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_rst==1'b0)
            instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_d_bus_int <={16{1'b0}};
          else 
            instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_d_bus_int <=instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_d_bus_ext;
       end
  
  assign instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_clock=instance_inj_ctrl_instance_d_bus_interface_clock; 
  assign instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_rd_en=instance_inj_ctrl_instance_d_bus_interface_rd_en_internal; 
  assign instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_rst=instance_inj_ctrl_instance_d_bus_interface_rst; 
  assign instance_inj_ctrl_instance_d_bus_interface_instance_d_bus_handle_wr_en=instance_inj_ctrl_instance_d_bus_interface_wr_en_internal; 
   wire instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_clock ;  
   wire instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_cs ;  
   wire instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_ds ;  
   wire instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_rst ;  
   wire instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_r_w ;  
   wire instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_rd_en ;  
   reg instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_wr_en ;  
   wire instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_wr_en_int ;  
  assign instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_rd_en=(~(instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_cs))&instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_r_w; 
  assign instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_wr_en_int=(~(instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_cs))&(~(instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_ds))&(~(instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_r_w)); 
  always @(  posedge instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_clock or  negedge instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_rst)
       begin :instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_vhdl_ds_handle
         if (instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_rst==1'b0)
            instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_wr_en <=1'b0;
          else 
            instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_wr_en <=instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_wr_en_int;
       end
  
  assign instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_clock=instance_inj_ctrl_instance_d_bus_interface_clock; 
  assign instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_cs=instance_inj_ctrl_instance_d_bus_interface_cs; 
  assign instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_ds=instance_inj_ctrl_instance_d_bus_interface_ds; 
  assign instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_rst=instance_inj_ctrl_instance_d_bus_interface_rst; 
  assign instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_r_w=instance_inj_ctrl_instance_d_bus_interface_r_w; 
  assign instance_inj_ctrl_instance_d_bus_interface_rd_en_internal=instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_rd_en; 
  assign instance_inj_ctrl_instance_d_bus_interface_wr_en_internal=instance_inj_ctrl_instance_d_bus_interface_instance_ds_handle_wr_en; 
  assign instance_inj_ctrl_instance_d_bus_interface_rd_en=instance_inj_ctrl_instance_d_bus_interface_rd_en_internal; 
  assign instance_inj_ctrl_instance_d_bus_interface_wr_en=instance_inj_ctrl_instance_d_bus_interface_wr_en_internal; 
  assign instance_inj_ctrl_instance_d_bus_interface_clock=instance_inj_ctrl_clock; 
  assign instance_inj_ctrl_instance_d_bus_interface_cs=instance_inj_ctrl_cs; 
  assign instance_inj_ctrl_instance_d_bus_interface_ds=instance_inj_ctrl_ds; 
  assign instance_inj_ctrl_instance_d_bus_interface_rst=instance_inj_ctrl_rst; 
  assign instance_inj_ctrl_instance_d_bus_interface_r_w=instance_inj_ctrl_r_w; 
  assign instance_inj_ctrl_rd_en=instance_inj_ctrl_instance_d_bus_interface_rd_en; 
  assign instance_inj_ctrl_wr_en=instance_inj_ctrl_instance_d_bus_interface_wr_en; 
   wire instance_inj_ctrl_instance_filter_feedback_clock ;  
   wire [2-1:0] instance_inj_ctrl_instance_filter_feedback_i_fbk ;  
   wire instance_inj_ctrl_instance_filter_feedback_rst ;  
   wire [6-1:0] instance_inj_ctrl_instance_filter_feedback_v_fbk ;  
   wire [2-1:0] instance_inj_ctrl_instance_filter_feedback_i_fbk_f ;  
   wire [6-1:0] instance_inj_ctrl_instance_filter_feedback_v_fbk_f ;  
   wire instance_inj_ctrl_instance_filter_feedback_v_fbk_0 ;  
   wire instance_inj_ctrl_instance_filter_feedback_v_fbk_f0 ;  
   wire instance_inj_ctrl_instance_filter_feedback_v_fbk_1 ;  
   wire instance_inj_ctrl_instance_filter_feedback_v_fbk_f1 ;  
   wire instance_inj_ctrl_instance_filter_feedback_v_fbk_2 ;  
   wire instance_inj_ctrl_instance_filter_feedback_v_fbk_f2 ;  
   wire instance_inj_ctrl_instance_filter_feedback_v_fbk_3 ;  
   wire instance_inj_ctrl_instance_filter_feedback_v_fbk_f3 ;  
   wire instance_inj_ctrl_instance_filter_feedback_v_fbk_4 ;  
   wire instance_inj_ctrl_instance_filter_feedback_v_fbk_f4 ;  
   wire instance_inj_ctrl_instance_filter_feedback_v_fbk_5 ;  
   wire instance_inj_ctrl_instance_filter_feedback_v_fbk_f5 ;  
   wire instance_inj_ctrl_instance_filter_feedback_i_fbk_0 ;  
   wire instance_inj_ctrl_instance_filter_feedback_i_fbk_f0 ;  
   wire instance_inj_ctrl_instance_filter_feedback_i_fbk_1 ;  
   wire instance_inj_ctrl_instance_filter_feedback_i_fbk_f1 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt0_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt0_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt0_rst ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt0_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt1_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt1_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt1_rst ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt1_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt2_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt2_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt2_rst ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt2_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt3_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt3_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt3_rst ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt3_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt4_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt4_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt4_rst ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt4_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt5_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt5_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt5_rst ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt5_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt6_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt6_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt6_rst ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt6_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt7_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt7_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt7_rst ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt7_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_rst ;  
   reg instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_rst ;  
   reg instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_rst ;  
   reg instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_rst ;  
   reg instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_rst ;  
   reg instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_rst ;  
   reg instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_rst ;  
   reg instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filtered_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_clock ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_rst ;  
   reg instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filtered_value ;  
 parameter[2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_start_state =0,instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_1=1,instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_2=2,instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_3=3,instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_0=4,instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_1=5,instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_2=6,instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_3=7; 
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_current_state ;  
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state ;  
  always @(   posedge instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value or  negedge instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_clocked
         if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_rst==1'b0)
            instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_start_state;
          else 
            instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state;
       end
  
  always @(    instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_current_state or  instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value or  instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_set_next_state
         instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_current_state;
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_start_state :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b0)
                instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_start_state;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b1)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_start_state;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_3;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_0 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_1;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_3;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_start_state;
          default :;
         endcase 
       end
  
  always @( instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_current_state)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_unclocked
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_start_state :
             instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_zero_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_0 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filter_state_type_one_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filtered_value <=1'b1;
          default :;
         endcase 
       end
  
 parameter[2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_start_state =0,instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_1=1,instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_2=2,instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_3=3,instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_0=4,instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_1=5,instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_2=6,instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_3=7; 
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_current_state ;  
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state ;  
  always @(   posedge instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value or  negedge instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_clocked
         if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_rst==1'b0)
            instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_start_state;
          else 
            instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state;
       end
  
  always @(    instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_current_state or  instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value or  instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_set_next_state
         instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_current_state;
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_start_state :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b0)
                instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_start_state;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b1)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_start_state;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_3;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_0 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_1;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_3;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_start_state;
          default :;
         endcase 
       end
  
  always @( instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_current_state)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_unclocked
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_start_state :
             instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_zero_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_0 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filter_state_type_one_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filtered_value <=1'b1;
          default :;
         endcase 
       end
  
 parameter[2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_start_state =0,instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_1=1,instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_2=2,instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_3=3,instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_0=4,instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_1=5,instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_2=6,instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_3=7; 
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_current_state ;  
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state ;  
  always @(   posedge instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value or  negedge instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_clocked
         if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_rst==1'b0)
            instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_start_state;
          else 
            instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state;
       end
  
  always @(    instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_current_state or  instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value or  instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_set_next_state
         instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_current_state;
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_start_state :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b0)
                instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_start_state;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b1)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_start_state;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_3;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_0 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_1;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_3;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_start_state;
          default :;
         endcase 
       end
  
  always @( instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_current_state)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_unclocked
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_start_state :
             instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_zero_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_0 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filter_state_type_one_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filtered_value <=1'b1;
          default :;
         endcase 
       end
  
 parameter[2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_start_state =0,instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_1=1,instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_2=2,instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_3=3,instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_0=4,instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_1=5,instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_2=6,instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_3=7; 
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_current_state ;  
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state ;  
  always @(   posedge instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value or  negedge instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_clocked
         if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_rst==1'b0)
            instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_start_state;
          else 
            instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state;
       end
  
  always @(    instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_current_state or  instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value or  instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_set_next_state
         instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_current_state;
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_start_state :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b0)
                instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_start_state;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b1)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_start_state;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_3;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_0 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_1;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_3;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_start_state;
          default :;
         endcase 
       end
  
  always @( instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_current_state)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_unclocked
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_start_state :
             instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_zero_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_0 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filter_state_type_one_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filtered_value <=1'b1;
          default :;
         endcase 
       end
  
 parameter[2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_start_state =0,instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_1=1,instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_2=2,instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_3=3,instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_0=4,instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_1=5,instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_2=6,instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_3=7; 
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_current_state ;  
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state ;  
  always @(   posedge instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value or  negedge instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_clocked
         if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_rst==1'b0)
            instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_start_state;
          else 
            instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state;
       end
  
  always @(    instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_current_state or  instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value or  instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_set_next_state
         instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_current_state;
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_start_state :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b0)
                instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_start_state;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b1)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_start_state;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_3;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_0 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_1;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_3;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_start_state;
          default :;
         endcase 
       end
  
  always @( instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_current_state)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_unclocked
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_start_state :
             instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_zero_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_0 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filter_state_type_one_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filtered_value <=1'b1;
          default :;
         endcase 
       end
  
 parameter[2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_start_state =0,instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_1=1,instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_2=2,instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_3=3,instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_0=4,instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_1=5,instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_2=6,instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_3=7; 
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_current_state ;  
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state ;  
  always @(   posedge instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value or  negedge instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_clocked
         if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_rst==1'b0)
            instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_start_state;
          else 
            instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state;
       end
  
  always @(    instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_current_state or  instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value or  instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_set_next_state
         instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_current_state;
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_start_state :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b0)
                instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_start_state;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b1)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_start_state;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_3;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_0 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_1;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_3;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_start_state;
          default :;
         endcase 
       end
  
  always @( instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_current_state)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_unclocked
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_start_state :
             instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_zero_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_0 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filter_state_type_one_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filtered_value <=1'b1;
          default :;
         endcase 
       end
  
 parameter[2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_start_state =0,instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_1=1,instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_2=2,instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_3=3,instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_0=4,instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_1=5,instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_2=6,instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_3=7; 
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_current_state ;  
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state ;  
  always @(   posedge instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value or  negedge instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_clocked
         if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_rst==1'b0)
            instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_start_state;
          else 
            instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state;
       end
  
  always @(    instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_current_state or  instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value or  instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_set_next_state
         instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_current_state;
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_start_state :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b0)
                instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_start_state;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b1)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_start_state;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_3;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_0 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_1;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_3;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_start_state;
          default :;
         endcase 
       end
  
  always @( instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_current_state)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_unclocked
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_start_state :
             instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_zero_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_0 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filter_state_type_one_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filtered_value <=1'b1;
          default :;
         endcase 
       end
  
 parameter[2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_start_state =0,instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_1=1,instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_2=2,instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_3=3,instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_0=4,instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_1=5,instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_2=6,instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_3=7; 
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_current_state ;  
   reg [2:0] instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state ;  
  always @(   posedge instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value or  negedge instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_clocked
         if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_rst==1'b0)
            instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_start_state;
          else 
            instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_current_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state;
       end
  
  always @(    instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_current_state or  instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_clock or  instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value or  instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_rst)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_set_next_state
         instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_current_state;
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_start_state :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b0)
                instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_start_state;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b1)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_start_state;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_3;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_0 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_1 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_0;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_2;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_2 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_1;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_3;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_3 :
             if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b1)
                instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_2;
              else 
                if (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value==1'b0)
                   instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_next_state <=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_start_state;
          default :;
         endcase 
       end
  
  always @( instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_current_state)
       begin :instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_unclocked
         case (instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_current_state)
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_start_state :
             instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_zero_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filtered_value <=1'b0;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_0 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_1 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_2 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filtered_value <=1'b1;
          instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filter_state_type_one_3 :
             instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filtered_value <=1'b1;
          default :;
         endcase 
       end
  
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_clock=instance_inj_ctrl_instance_filter_feedback_instance_filt0_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_new_value=instance_inj_ctrl_instance_filter_feedback_instance_filt0_new_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_rst=instance_inj_ctrl_instance_filter_feedback_instance_filt0_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt0_filtered_value=instance_inj_ctrl_instance_filter_feedback_instance_filt0_instance_filter_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_clock=instance_inj_ctrl_instance_filter_feedback_instance_filt1_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_new_value=instance_inj_ctrl_instance_filter_feedback_instance_filt1_new_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_rst=instance_inj_ctrl_instance_filter_feedback_instance_filt1_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt1_filtered_value=instance_inj_ctrl_instance_filter_feedback_instance_filt1_instance_filter_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_clock=instance_inj_ctrl_instance_filter_feedback_instance_filt2_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_new_value=instance_inj_ctrl_instance_filter_feedback_instance_filt2_new_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_rst=instance_inj_ctrl_instance_filter_feedback_instance_filt2_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt2_filtered_value=instance_inj_ctrl_instance_filter_feedback_instance_filt2_instance_filter_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_clock=instance_inj_ctrl_instance_filter_feedback_instance_filt3_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_new_value=instance_inj_ctrl_instance_filter_feedback_instance_filt3_new_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_rst=instance_inj_ctrl_instance_filter_feedback_instance_filt3_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt3_filtered_value=instance_inj_ctrl_instance_filter_feedback_instance_filt3_instance_filter_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_clock=instance_inj_ctrl_instance_filter_feedback_instance_filt4_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_new_value=instance_inj_ctrl_instance_filter_feedback_instance_filt4_new_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_rst=instance_inj_ctrl_instance_filter_feedback_instance_filt4_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt4_filtered_value=instance_inj_ctrl_instance_filter_feedback_instance_filt4_instance_filter_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_clock=instance_inj_ctrl_instance_filter_feedback_instance_filt5_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_new_value=instance_inj_ctrl_instance_filter_feedback_instance_filt5_new_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_rst=instance_inj_ctrl_instance_filter_feedback_instance_filt5_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt5_filtered_value=instance_inj_ctrl_instance_filter_feedback_instance_filt5_instance_filter_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_clock=instance_inj_ctrl_instance_filter_feedback_instance_filt6_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_new_value=instance_inj_ctrl_instance_filter_feedback_instance_filt6_new_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_rst=instance_inj_ctrl_instance_filter_feedback_instance_filt6_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt6_filtered_value=instance_inj_ctrl_instance_filter_feedback_instance_filt6_instance_filter_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_clock=instance_inj_ctrl_instance_filter_feedback_instance_filt7_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_new_value=instance_inj_ctrl_instance_filter_feedback_instance_filt7_new_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_rst=instance_inj_ctrl_instance_filter_feedback_instance_filt7_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt7_filtered_value=instance_inj_ctrl_instance_filter_feedback_instance_filt7_instance_filter_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt0_clock=instance_inj_ctrl_instance_filter_feedback_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt0_new_value=instance_inj_ctrl_instance_filter_feedback_v_fbk_0; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt0_rst=instance_inj_ctrl_instance_filter_feedback_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_f0=instance_inj_ctrl_instance_filter_feedback_instance_filt0_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt1_clock=instance_inj_ctrl_instance_filter_feedback_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt1_new_value=instance_inj_ctrl_instance_filter_feedback_v_fbk_1; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt1_rst=instance_inj_ctrl_instance_filter_feedback_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_f1=instance_inj_ctrl_instance_filter_feedback_instance_filt1_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt2_clock=instance_inj_ctrl_instance_filter_feedback_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt2_new_value=instance_inj_ctrl_instance_filter_feedback_v_fbk_2; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt2_rst=instance_inj_ctrl_instance_filter_feedback_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_f2=instance_inj_ctrl_instance_filter_feedback_instance_filt2_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt3_clock=instance_inj_ctrl_instance_filter_feedback_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt3_new_value=instance_inj_ctrl_instance_filter_feedback_v_fbk_3; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt3_rst=instance_inj_ctrl_instance_filter_feedback_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_f3=instance_inj_ctrl_instance_filter_feedback_instance_filt3_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt4_clock=instance_inj_ctrl_instance_filter_feedback_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt4_new_value=instance_inj_ctrl_instance_filter_feedback_v_fbk_4; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt4_rst=instance_inj_ctrl_instance_filter_feedback_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_f4=instance_inj_ctrl_instance_filter_feedback_instance_filt4_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt5_clock=instance_inj_ctrl_instance_filter_feedback_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt5_new_value=instance_inj_ctrl_instance_filter_feedback_v_fbk_5; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt5_rst=instance_inj_ctrl_instance_filter_feedback_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_f5=instance_inj_ctrl_instance_filter_feedback_instance_filt5_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt6_clock=instance_inj_ctrl_instance_filter_feedback_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt6_new_value=instance_inj_ctrl_instance_filter_feedback_i_fbk_0; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt6_rst=instance_inj_ctrl_instance_filter_feedback_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_i_fbk_f0=instance_inj_ctrl_instance_filter_feedback_instance_filt6_filtered_value; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt7_clock=instance_inj_ctrl_instance_filter_feedback_clock; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt7_new_value=instance_inj_ctrl_instance_filter_feedback_i_fbk_1; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_filt7_rst=instance_inj_ctrl_instance_filter_feedback_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_i_fbk_f1=instance_inj_ctrl_instance_filter_feedback_instance_filt7_filtered_value; 
   wire [2-1:0] instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_f0 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_f1 ;  
   wire [6-1:0] instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f0 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f1 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f2 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f3 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f4 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f5 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_0 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_1 ;  
   wire [2-1:0] instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_f ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_0 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_1 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_2 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_3 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_4 ;  
   wire instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_5 ;  
   wire [6-1:0] instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f ;  
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_0=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk[0]; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_1=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk[1]; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_2=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk[2]; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_3=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk[3]; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_4=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk[4]; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_5=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk[5]; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f[0]=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f0; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f[1]=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f1; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f[2]=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f2; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f[3]=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f3; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f[4]=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f4; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f[5]=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f5; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_0=(~(instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk[0])); 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_1=(~(instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk[1])); 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_f[0]=instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_f0; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_f[1]=instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_f1; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk=instance_inj_ctrl_instance_filter_feedback_i_fbk; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_f0=instance_inj_ctrl_instance_filter_feedback_i_fbk_f0; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_f1=instance_inj_ctrl_instance_filter_feedback_i_fbk_f1; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk=instance_inj_ctrl_instance_filter_feedback_v_fbk; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f0=instance_inj_ctrl_instance_filter_feedback_v_fbk_f0; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f1=instance_inj_ctrl_instance_filter_feedback_v_fbk_f1; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f2=instance_inj_ctrl_instance_filter_feedback_v_fbk_f2; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f3=instance_inj_ctrl_instance_filter_feedback_v_fbk_f3; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f4=instance_inj_ctrl_instance_filter_feedback_v_fbk_f4; 
  assign instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f5=instance_inj_ctrl_instance_filter_feedback_v_fbk_f5; 
  assign instance_inj_ctrl_instance_filter_feedback_i_fbk_0=instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_0; 
  assign instance_inj_ctrl_instance_filter_feedback_i_fbk_1=instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_1; 
  assign instance_inj_ctrl_instance_filter_feedback_i_fbk_f=instance_inj_ctrl_instance_filter_feedback_instance_interface_i_fbk_f; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_0=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_0; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_1=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_1; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_2=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_2; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_3=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_3; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_4=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_4; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_5=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_5; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk_f=instance_inj_ctrl_instance_filter_feedback_instance_interface_v_fbk_f; 
  assign instance_inj_ctrl_instance_filter_feedback_clock=instance_inj_ctrl_clock_internal; 
  assign instance_inj_ctrl_instance_filter_feedback_i_fbk=instance_inj_ctrl_i_fbk; 
  assign instance_inj_ctrl_instance_filter_feedback_rst=instance_inj_ctrl_rst; 
  assign instance_inj_ctrl_instance_filter_feedback_v_fbk=instance_inj_ctrl_v_fbk; 
  assign instance_inj_ctrl_i_fbk_f=instance_inj_ctrl_instance_filter_feedback_i_fbk_f; 
  assign instance_inj_ctrl_v_fbk_f=instance_inj_ctrl_instance_filter_feedback_v_fbk_f; 
   wire instance_inj_ctrl_instance_merge_error1 ;  
   wire instance_inj_ctrl_instance_merge_error2 ;  
   wire instance_inj_ctrl_instance_merge_hl_034 ;  
   wire instance_inj_ctrl_instance_merge_hl_125 ;  
   wire instance_inj_ctrl_instance_merge_relpot1 ;  
   wire instance_inj_ctrl_instance_merge_relpot2 ;  
   wire [2-1:0] instance_inj_ctrl_instance_merge_hlo ;  
   wire instance_inj_ctrl_instance_merge_irq ;  
   wire instance_inj_ctrl_instance_merge_rel_pot_en ;  
  assign instance_inj_ctrl_instance_merge_rel_pot_en=instance_inj_ctrl_instance_merge_relpot2|instance_inj_ctrl_instance_merge_relpot1; 
  assign instance_inj_ctrl_instance_merge_hlo[0]=(~(instance_inj_ctrl_instance_merge_hl_034)); 
  assign instance_inj_ctrl_instance_merge_hlo[1]=(~(instance_inj_ctrl_instance_merge_hl_125)); 
  assign instance_inj_ctrl_instance_merge_irq=(~(instance_inj_ctrl_instance_merge_error1|instance_inj_ctrl_instance_merge_error2)); 
  assign instance_inj_ctrl_instance_merge_error1=instance_inj_ctrl_error1; 
  assign instance_inj_ctrl_instance_merge_error2=instance_inj_ctrl_error2; 
  assign instance_inj_ctrl_instance_merge_hl_034=instance_inj_ctrl_hl_034; 
  assign instance_inj_ctrl_instance_merge_hl_125=instance_inj_ctrl_hl_125; 
  assign instance_inj_ctrl_instance_merge_relpot1=instance_inj_ctrl_relpot1; 
  assign instance_inj_ctrl_instance_merge_relpot2=instance_inj_ctrl_relpot2; 
  assign instance_inj_ctrl_hlo=instance_inj_ctrl_instance_merge_hlo; 
  assign instance_inj_ctrl_irq=instance_inj_ctrl_instance_merge_irq; 
  assign instance_inj_ctrl_rel_pot_en=instance_inj_ctrl_instance_merge_rel_pot_en; 
   wire instance_inj_ctrl_instance_merge_actuators_t1_0 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t1_1 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t1_2 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t1_3 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t1_4 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t1_5 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t2_0 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t2_1 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t2_2 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t2_3 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t2_4 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t2_5 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t3_034 ;  
   wire instance_inj_ctrl_instance_merge_actuators_t3_125 ;  
   wire [6-1:0] instance_inj_ctrl_instance_merge_actuators_t1 ;  
   wire [6-1:0] instance_inj_ctrl_instance_merge_actuators_t2 ;  
   wire [2-1:0] instance_inj_ctrl_instance_merge_actuators_t3 ;  
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_0 ;  
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_1 ;  
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_2 ;  
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_3 ;  
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_4 ;  
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_5 ;  
   reg [6-1:0] instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1 ;  
  always @(      instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_0 or  instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_1 or  instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_2 or  instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_3 or  instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_4 or  instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_5)
       begin :instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_vhdl_merge_t1
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1 [0]<=(~(instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_0));
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1 [1]<=(~(instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_1));
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1 [2]<=(~(instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_2));
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1 [3]<=(~(instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_3));
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1 [4]<=(~(instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_4));
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1 [5]<=(~(instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_5));
       end
  
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_0=instance_inj_ctrl_instance_merge_actuators_t1_0; 
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_1=instance_inj_ctrl_instance_merge_actuators_t1_1; 
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_2=instance_inj_ctrl_instance_merge_actuators_t1_2; 
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_3=instance_inj_ctrl_instance_merge_actuators_t1_3; 
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_4=instance_inj_ctrl_instance_merge_actuators_t1_4; 
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1_5=instance_inj_ctrl_instance_merge_actuators_t1_5; 
  assign instance_inj_ctrl_instance_merge_actuators_t1=instance_inj_ctrl_instance_merge_actuators_instance_merge_t1_t1; 
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_0 ;  
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_1 ;  
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_2 ;  
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_3 ;  
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_4 ;  
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_5 ;  
   reg [6-1:0] instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2 ;  
  always @(      instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_0 or  instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_1 or  instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_2 or  instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_3 or  instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_4 or  instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_5)
       begin :instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_vhdl_merge_t2
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2 [0]<=instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_0;
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2 [1]<=instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_1;
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2 [2]<=instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_2;
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2 [3]<=instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_3;
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2 [4]<=instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_4;
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2 [5]<=instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_5;
       end
  
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_0=instance_inj_ctrl_instance_merge_actuators_t2_0; 
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_1=instance_inj_ctrl_instance_merge_actuators_t2_1; 
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_2=instance_inj_ctrl_instance_merge_actuators_t2_2; 
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_3=instance_inj_ctrl_instance_merge_actuators_t2_3; 
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_4=instance_inj_ctrl_instance_merge_actuators_t2_4; 
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2_5=instance_inj_ctrl_instance_merge_actuators_t2_5; 
  assign instance_inj_ctrl_instance_merge_actuators_t2=instance_inj_ctrl_instance_merge_actuators_instance_merge_t2_t2; 
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_t3_034 ;  
   wire instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_t3_125 ;  
   reg [2-1:0] instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_t3 ;  
  always @(  instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_t3_034 or  instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_t3_125)
       begin :instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_vhdl_merge_t3
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_t3 [0]<=(~(instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_t3_034));
         instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_t3 [1]<=(~(instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_t3_125));
       end
  
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_t3_034=instance_inj_ctrl_instance_merge_actuators_t3_034; 
  assign instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_t3_125=instance_inj_ctrl_instance_merge_actuators_t3_125; 
  assign instance_inj_ctrl_instance_merge_actuators_t3=instance_inj_ctrl_instance_merge_actuators_instance_merge_t3_t3; 
  assign instance_inj_ctrl_instance_merge_actuators_t1_0=instance_inj_ctrl_t1_0; 
  assign instance_inj_ctrl_instance_merge_actuators_t1_1=instance_inj_ctrl_t1_1; 
  assign instance_inj_ctrl_instance_merge_actuators_t1_2=instance_inj_ctrl_t1_2; 
  assign instance_inj_ctrl_instance_merge_actuators_t1_3=instance_inj_ctrl_t1_3; 
  assign instance_inj_ctrl_instance_merge_actuators_t1_4=instance_inj_ctrl_t1_4; 
  assign instance_inj_ctrl_instance_merge_actuators_t1_5=instance_inj_ctrl_t1_5; 
  assign instance_inj_ctrl_instance_merge_actuators_t2_0=instance_inj_ctrl_t2_0; 
  assign instance_inj_ctrl_instance_merge_actuators_t2_1=instance_inj_ctrl_t2_1; 
  assign instance_inj_ctrl_instance_merge_actuators_t2_2=instance_inj_ctrl_t2_2; 
  assign instance_inj_ctrl_instance_merge_actuators_t2_3=instance_inj_ctrl_t2_3; 
  assign instance_inj_ctrl_instance_merge_actuators_t2_4=instance_inj_ctrl_t2_4; 
  assign instance_inj_ctrl_instance_merge_actuators_t2_5=instance_inj_ctrl_t2_5; 
  assign instance_inj_ctrl_instance_merge_actuators_t3_034=instance_inj_ctrl_t3_034; 
  assign instance_inj_ctrl_instance_merge_actuators_t3_125=instance_inj_ctrl_t3_125; 
  assign instance_inj_ctrl_t1=instance_inj_ctrl_instance_merge_actuators_t1; 
  assign instance_inj_ctrl_t2=instance_inj_ctrl_instance_merge_actuators_t2; 
  assign instance_inj_ctrl_t3=instance_inj_ctrl_instance_merge_actuators_t3; 
   wire [6-1:0] instance_inj_ctrl_instance_registers_a_bus ;  
   wire instance_inj_ctrl_instance_registers_clock ;  
   wire [21-1:0] instance_inj_ctrl_instance_registers_digital_input ;  
   wire instance_inj_ctrl_instance_registers_en_fbk_store_034 ;  
   wire instance_inj_ctrl_instance_registers_en_fbk_store_125 ;  
   wire instance_inj_ctrl_instance_registers_en_state_store_034 ;  
   wire instance_inj_ctrl_instance_registers_en_state_store_125 ;  
   wire [3-1:0] instance_inj_ctrl_instance_registers_fbk_pwm ;  
   wire [7-1:0] instance_inj_ctrl_instance_registers_global_state_034 ;  
   wire [7-1:0] instance_inj_ctrl_instance_registers_global_state_125 ;  
   wire [2-1:0] instance_inj_ctrl_instance_registers_i_fbk_f ;  
   wire [7-1:0] instance_inj_ctrl_instance_registers_nssm_in ;  
   wire instance_inj_ctrl_instance_registers_rd_en ;  
   wire instance_inj_ctrl_instance_registers_rel_pot_en ;  
   wire instance_inj_ctrl_instance_registers_rst ;  
   wire [6-1:0] instance_inj_ctrl_instance_registers_v_fbk_f ;  
   wire instance_inj_ctrl_instance_registers_wr_en ;  
   wire [7:0] instance_inj_ctrl_instance_registers_digital_output ;  
   wire instance_inj_ctrl_instance_registers_in_speed_lev ;  
   wire instance_inj_ctrl_instance_registers_knock1u ;  
   wire instance_inj_ctrl_instance_registers_knock2u ;  
   wire instance_inj_ctrl_instance_registers_pickup_hall ;  
   wire instance_inj_ctrl_instance_registers_relpot ;  
   wire [8-1:0] instance_inj_ctrl_instance_registers_r_t1 ;  
   wire [7-1:0] instance_inj_ctrl_instance_registers_r_t2 ;  
   wire [8-1:0] instance_inj_ctrl_instance_registers_r_t3_034 ;  
   wire [8-1:0] instance_inj_ctrl_instance_registers_r_t3_125 ;  
   wire [7-1:0] instance_inj_ctrl_instance_registers_r_t4_034 ;  
   wire [7-1:0] instance_inj_ctrl_instance_registers_r_t4_125 ;  
   wire [10-1:0] instance_inj_ctrl_instance_registers_r_tb_034 ;  
   wire [10-1:0] instance_inj_ctrl_instance_registers_r_tb_125 ;  
   wire [12-1:0] instance_inj_ctrl_instance_registers_r_th_034 ;  
   wire [12-1:0] instance_inj_ctrl_instance_registers_r_th_125 ;  
   wire [7-1:0] instance_inj_ctrl_instance_registers_r_tonh ;  
   wire [7-1:0] instance_inj_ctrl_instance_registers_r_tonl ;  
   wire [7-1:0] instance_inj_ctrl_instance_registers_r_tp ;  
   wire instance_inj_ctrl_instance_registers_seg_speed_lev ;  
   wire instance_inj_ctrl_instance_registers_smot_camme_en ;  
   wire [11-1:0] instance_inj_ctrl_instance_registers_status_reg_034 ;  
   wire [11-1:0] instance_inj_ctrl_instance_registers_status_reg_125 ;  
   wire [3-1:0] instance_inj_ctrl_instance_registers_test_en_034 ;  
   wire [3-1:0] instance_inj_ctrl_instance_registers_test_en_125 ;  
   wire instance_inj_ctrl_instance_registers_trg_knock_en ;  
   wire instance_inj_ctrl_instance_registers_turbo_speed_lev ;  
   wire [13-1:0] instance_inj_ctrl_instance_registers_add_decoded ;  
   wire [13-1:0] instance_inj_ctrl_instance_registers_add_decoded_r ;  
   wire instance_inj_ctrl_instance_registers_add_test_en ;  
   wire [2-1:0] instance_inj_ctrl_instance_registers_a_dig_in ;  
   wire instance_inj_ctrl_instance_registers_a_dig_out ;  
   wire [2-1:0] instance_inj_ctrl_instance_registers_a_fault_dec ;  
   wire [2-1:0] instance_inj_ctrl_instance_registers_a_fault_dec_r ;  
   wire [6-1:0] instance_inj_ctrl_instance_registers_instance_add_dec_a_bus ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_clock ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_rst ;  
   reg [13-1:0] instance_inj_ctrl_instance_registers_instance_add_dec_add_decoded ;  
   wire [13-1:0] instance_inj_ctrl_instance_registers_instance_add_dec_add_decoded_r ;  
   reg instance_inj_ctrl_instance_registers_instance_add_dec_add_test_en ;  
   wire [2-1:0] instance_inj_ctrl_instance_registers_instance_add_dec_a_dig_in ;  
   reg instance_inj_ctrl_instance_registers_instance_add_dec_a_dig_out ;  
   reg [2-1:0] instance_inj_ctrl_instance_registers_instance_add_dec_a_fault_dec ;  
   wire [2-1:0] instance_inj_ctrl_instance_registers_instance_add_dec_a_fault_dec_r ;  
   wire [13-1:0] instance_inj_ctrl_instance_registers_instance_add_dec_add_decoded_int ;  
   wire [2-1:0] instance_inj_ctrl_instance_registers_instance_add_dec_a_fault_dec_int ;  
   wire [2-1:0] instance_inj_ctrl_instance_registers_instance_add_dec_a_dig_in_int ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_a_dig_out_int ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_add_test_en_int ;  
   wire [4:0] instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus ;  
  always @(  posedge instance_inj_ctrl_instance_registers_instance_add_dec_clock or  negedge instance_inj_ctrl_instance_registers_instance_add_dec_rst)
       begin :instance_inj_ctrl_instance_registers_instance_add_dec_vhdl_add_dec
         if (instance_inj_ctrl_instance_registers_instance_add_dec_rst==1'b0)
            begin 
              instance_inj_ctrl_instance_registers_instance_add_dec_add_decoded <={13{1'b0}};
              instance_inj_ctrl_instance_registers_instance_add_dec_a_fault_dec <={2{1'b0}};
              instance_inj_ctrl_instance_registers_instance_add_dec_a_dig_out <=1'b0;
              instance_inj_ctrl_instance_registers_instance_add_dec_add_test_en <=1'b0;
            end 
          else 
            begin 
              instance_inj_ctrl_instance_registers_instance_add_dec_add_decoded <=instance_inj_ctrl_instance_registers_instance_add_dec_add_decoded_int&13'b1111111111111;
              instance_inj_ctrl_instance_registers_instance_add_dec_a_fault_dec <=instance_inj_ctrl_instance_registers_instance_add_dec_a_fault_dec_int&2'b11;
              instance_inj_ctrl_instance_registers_instance_add_dec_a_dig_out <=instance_inj_ctrl_instance_registers_instance_add_dec_a_dig_out_int&1'b1;
              instance_inj_ctrl_instance_registers_instance_add_dec_add_test_en <=instance_inj_ctrl_instance_registers_instance_add_dec_add_test_en_int&1'b1;
            end 
       end
  
  assign instance_inj_ctrl_instance_registers_instance_add_dec_a_dig_in={2{instance_inj_ctrl_instance_registers_instance_add_dec_a_dig_in_int}}&2'b11; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_add_decoded_r=instance_inj_ctrl_instance_registers_instance_add_dec_add_decoded_int&13'b1111111111111; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_a_fault_dec_r=instance_inj_ctrl_instance_registers_instance_add_dec_a_fault_dec_int&2'b11; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[0]=(~(instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[0])); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[1]=(~(instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[1])); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[2]=(~(instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[2])); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[3]=(~(instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[3])); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]=(~(instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[4])); 
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i4 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i0 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i1 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i2 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i3 ;  
   wire instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i4 ;  
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_o=(instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i0&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i1&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i2&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i3&instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i4); 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i1=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i2=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i3=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t1_i4=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i1=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i2=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i3=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t2_i4=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i1=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i2=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i3=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tab_i4=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i1=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i2=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i3=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tah_i4=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i1=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i2=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i3=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbb_i4=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i1=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i2=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i3=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tbh_i4=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i1=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i2=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i3=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonh_i4=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i1=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i2=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i3=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tonl_i4=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i1=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i2=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i3=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_tp_i4=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i1=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i2=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i3=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_034_i4=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i1=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i2=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i3=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t3_125_i4=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i1=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i2=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i3=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_034_i4=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i1=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i2=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i3=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_t4_125_i4=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i1=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i2=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i3=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr1_i4=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i1=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i2=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i3=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_fr2_i4=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i0=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i1=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i2=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i3=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int_i4=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i0=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i1=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i2=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i3=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_in_int1_i4=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i0=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i1=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i2=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i3=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_a_dig_out_i4=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i0=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[4]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i1=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[3]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i2=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[2]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i3=instance_inj_ctrl_instance_registers_instance_add_dec_a_bus[1]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_dwand_add_test_en_int_i4=instance_inj_ctrl_instance_registers_instance_add_dec_not_a_bus[0]; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_a_bus=instance_inj_ctrl_instance_registers_a_bus; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_clock=instance_inj_ctrl_instance_registers_clock; 
  assign instance_inj_ctrl_instance_registers_instance_add_dec_rst=instance_inj_ctrl_instance_registers_rst; 
  assign instance_inj_ctrl_instance_registers_add_decoded=instance_inj_ctrl_instance_registers_instance_add_dec_add_decoded; 
  assign instance_inj_ctrl_instance_registers_add_decoded_r=instance_inj_ctrl_instance_registers_instance_add_dec_add_decoded_r; 
  assign instance_inj_ctrl_instance_registers_add_test_en=instance_inj_ctrl_instance_registers_instance_add_dec_add_test_en; 
  assign instance_inj_ctrl_instance_registers_a_dig_in=instance_inj_ctrl_instance_registers_instance_add_dec_a_dig_in; 
  assign instance_inj_ctrl_instance_registers_a_dig_out=instance_inj_ctrl_instance_registers_instance_add_dec_a_dig_out; 
  assign instance_inj_ctrl_instance_registers_a_fault_dec=instance_inj_ctrl_instance_registers_instance_add_dec_a_fault_dec; 
  assign instance_inj_ctrl_instance_registers_a_fault_dec_r=instance_inj_ctrl_instance_registers_instance_add_dec_a_fault_dec_r; 
  digital_inputs_handle instance_inj_ctrl_instance_registers_instance_digital_inputs_handle(instance_inj_ctrl_instance_registers_a_dig_in,instance_inj_ctrl_instance_registers_clock,instance_inj_ctrl_instance_registers_digital_input,instance_inj_ctrl_instance_registers_fbk_pwm,instance_inj_ctrl_instance_registers_nssm_in,instance_inj_ctrl_instance_registers_rd_en,instance_inj_ctrl_instance_registers_rst,instance_inj_ctrl_instance_registers_d_bus); 
  digital_outputs_handle instance_inj_ctrl_instance_registers_instance_digital_outputs_handle(instance_inj_ctrl_instance_registers_a_dig_out,instance_inj_ctrl_instance_registers_clock,instance_inj_ctrl_instance_registers_d_bus,instance_inj_ctrl_instance_registers_rst,instance_inj_ctrl_instance_registers_wr_en,instance_inj_ctrl_instance_registers_digital_output,instance_inj_ctrl_instance_registers_in_speed_lev,instance_inj_ctrl_instance_registers_knock1u,instance_inj_ctrl_instance_registers_knock2u,instance_inj_ctrl_instance_registers_pickup_hall,instance_inj_ctrl_instance_registers_seg_speed_lev,instance_inj_ctrl_instance_registers_smot_camme_en,instance_inj_ctrl_instance_registers_trg_knock_en,instance_inj_ctrl_instance_registers_turbo_speed_lev); 
  error_handle instance_inj_ctrl_instance_registers_instance_error_handle(instance_inj_ctrl_instance_registers_a_fault_dec,instance_inj_ctrl_instance_registers_a_fault_dec_r,instance_inj_ctrl_instance_registers_clock,instance_inj_ctrl_instance_registers_en_fbk_store_034,instance_inj_ctrl_instance_registers_en_fbk_store_125,instance_inj_ctrl_instance_registers_en_state_store_034,instance_inj_ctrl_instance_registers_en_state_store_125,instance_inj_ctrl_instance_registers_global_state_034,instance_inj_ctrl_instance_registers_global_state_125,instance_inj_ctrl_instance_registers_i_fbk_f,instance_inj_ctrl_instance_registers_rd_en,instance_inj_ctrl_instance_registers_rel_pot_en,instance_inj_ctrl_instance_registers_rst,instance_inj_ctrl_instance_registers_v_fbk_f,instance_inj_ctrl_instance_registers_wr_en,instance_inj_ctrl_instance_registers_relpot,instance_inj_ctrl_instance_registers_status_reg_034,instance_inj_ctrl_instance_registers_status_reg_125,instance_inj_ctrl_instance_registers_d_bus); 
  in_reg instance_inj_ctrl_instance_registers_instance_in_reg(instance_inj_ctrl_instance_registers_add_decoded,instance_inj_ctrl_instance_registers_add_decoded_r,instance_inj_ctrl_instance_registers_clock,instance_inj_ctrl_instance_registers_rd_en,instance_inj_ctrl_instance_registers_rst,instance_inj_ctrl_instance_registers_wr_en,instance_inj_ctrl_instance_registers_r_t1,instance_inj_ctrl_instance_registers_r_t2,instance_inj_ctrl_instance_registers_r_t3_034,instance_inj_ctrl_instance_registers_r_t3_125,instance_inj_ctrl_instance_registers_r_t4_034,instance_inj_ctrl_instance_registers_r_t4_125,instance_inj_ctrl_instance_registers_r_tb_034,instance_inj_ctrl_instance_registers_r_tb_125,instance_inj_ctrl_instance_registers_r_th_034,instance_inj_ctrl_instance_registers_r_th_125,instance_inj_ctrl_instance_registers_r_tonh,instance_inj_ctrl_instance_registers_r_tonl,instance_inj_ctrl_instance_registers_r_tp,instance_inj_ctrl_instance_registers_d_bus); 
  test_en instance_inj_ctrl_instance_registers_instance_test_en(instance_inj_ctrl_instance_registers_add_test_en,instance_inj_ctrl_instance_registers_clock,instance_inj_ctrl_instance_registers_d_bus,instance_inj_ctrl_instance_registers_rd_en,instance_inj_ctrl_instance_registers_rst,instance_inj_ctrl_instance_registers_wr_en,instance_inj_ctrl_instance_registers_test_en_034,instance_inj_ctrl_instance_registers_test_en_125); 
  assign instance_inj_ctrl_instance_registers_a_bus=instance_inj_ctrl_a_bus; 
  assign instance_inj_ctrl_instance_registers_clock=instance_inj_ctrl_clock_internal; 
  assign instance_inj_ctrl_instance_registers_digital_input=instance_inj_ctrl_clock; 
  assign instance_inj_ctrl_instance_registers_en_fbk_store_034=instance_inj_ctrl_digital_input; 
  assign instance_inj_ctrl_instance_registers_en_fbk_store_125=instance_inj_ctrl_en_fbk_store_034; 
  assign instance_inj_ctrl_instance_registers_en_state_store_034=instance_inj_ctrl_en_fbk_store_125; 
  assign instance_inj_ctrl_instance_registers_en_state_store_125=instance_inj_ctrl_en_state_store_034; 
  assign instance_inj_ctrl_instance_registers_fbk_pwm=instance_inj_ctrl_en_state_store_125; 
  assign instance_inj_ctrl_instance_registers_global_state_034=instance_inj_ctrl_fbk_pwm; 
  assign instance_inj_ctrl_instance_registers_global_state_125=instance_inj_ctrl_global_state_034; 
  assign instance_inj_ctrl_instance_registers_i_fbk_f=instance_inj_ctrl_global_state_125; 
  assign instance_inj_ctrl_instance_registers_nssm_in=instance_inj_ctrl_i_fbk_f; 
  assign instance_inj_ctrl_instance_registers_rd_en=instance_inj_ctrl_nssm_in; 
  assign instance_inj_ctrl_instance_registers_rel_pot_en=instance_inj_ctrl_rd_en; 
  assign instance_inj_ctrl_instance_registers_rst=instance_inj_ctrl_rel_pot_en; 
  assign instance_inj_ctrl_instance_registers_v_fbk_f=instance_inj_ctrl_rst; 
  assign instance_inj_ctrl_instance_registers_wr_en=instance_inj_ctrl_v_fbk_f; 
  assign instance_inj_ctrl_wr_en=instance_inj_ctrl_instance_registers_digital_output; 
  assign instance_inj_ctrl_digital_output=instance_inj_ctrl_instance_registers_in_speed_lev; 
  assign instance_inj_ctrl_in_speed_lev=instance_inj_ctrl_instance_registers_knock1u; 
  assign instance_inj_ctrl_knock1u=instance_inj_ctrl_instance_registers_knock2u; 
  assign instance_inj_ctrl_knock2u=instance_inj_ctrl_instance_registers_pickup_hall; 
  assign instance_inj_ctrl_pickup_hall=instance_inj_ctrl_instance_registers_relpot; 
  assign instance_inj_ctrl_relpot=instance_inj_ctrl_instance_registers_r_t1; 
  assign instance_inj_ctrl_r_t1=instance_inj_ctrl_instance_registers_r_t2; 
  assign instance_inj_ctrl_r_t2=instance_inj_ctrl_instance_registers_r_t3_034; 
  assign instance_inj_ctrl_r_t3_034=instance_inj_ctrl_instance_registers_r_t3_125; 
  assign instance_inj_ctrl_r_t3_125=instance_inj_ctrl_instance_registers_r_t4_034; 
  assign instance_inj_ctrl_r_t4_034=instance_inj_ctrl_instance_registers_r_t4_125; 
  assign instance_inj_ctrl_r_t4_125=instance_inj_ctrl_instance_registers_r_tb_034; 
  assign instance_inj_ctrl_r_tb_034=instance_inj_ctrl_instance_registers_r_tb_125; 
  assign instance_inj_ctrl_r_tb_125=instance_inj_ctrl_instance_registers_r_th_034; 
  assign instance_inj_ctrl_r_th_034=instance_inj_ctrl_instance_registers_r_th_125; 
  assign instance_inj_ctrl_r_th_125=instance_inj_ctrl_instance_registers_r_tonh; 
  assign instance_inj_ctrl_r_tonh=instance_inj_ctrl_instance_registers_r_tonl; 
  assign instance_inj_ctrl_r_tonl=instance_inj_ctrl_instance_registers_r_tp; 
  assign instance_inj_ctrl_r_tp=instance_inj_ctrl_instance_registers_seg_speed_lev; 
  assign instance_inj_ctrl_seg_speed_lev=instance_inj_ctrl_instance_registers_smot_camme_en; 
  assign instance_inj_ctrl_smot_camme_en=instance_inj_ctrl_instance_registers_status_reg_034; 
  assign instance_inj_ctrl_status_reg_034=instance_inj_ctrl_instance_registers_status_reg_125; 
  assign instance_inj_ctrl_status_reg_125=instance_inj_ctrl_instance_registers_test_en_034; 
  assign instance_inj_ctrl_test_en_034=instance_inj_ctrl_instance_registers_test_en_125; 
  assign instance_inj_ctrl_test_en_125=instance_inj_ctrl_instance_registers_trg_knock_en; 
  assign instance_inj_ctrl_trg_knock_en=instance_inj_ctrl_instance_registers_turbo_speed_lev; 
  smot_knock_handle instance_inj_ctrl_instance_smot_knock_handle(instance_inj_ctrl_clock_internal,instance_inj_ctrl_in_speed,instance_inj_ctrl_pickup_hall,instance_inj_ctrl_rst,instance_inj_ctrl_seg_speed_hall,instance_inj_ctrl_seg_speed_pickup,instance_inj_ctrl_smot_camme_en,instance_inj_ctrl_trg_knock1,instance_inj_ctrl_trg_knock2,instance_inj_ctrl_trg_knock_en,instance_inj_ctrl_cam_smot,instance_inj_ctrl_knock1,instance_inj_ctrl_knock2,instance_inj_ctrl_smot60); 
  split instance_inj_ctrl_instance_split(instance_inj_ctrl_clock_internal,instance_inj_ctrl_rst,instance_inj_ctrl_inj_cmd,instance_inj_ctrl_i_fbk_f,instance_inj_ctrl_v_fbk_f,instance_inj_ctrl_inj_cmd_034,instance_inj_ctrl_inj_cmd_125,instance_inj_ctrl_i_fbk_034,instance_inj_ctrl_i_fbk_125,instance_inj_ctrl_v_fbk_034,instance_inj_ctrl_v_fbk_125); 
  turbo_vehicle_speed instance_inj_ctrl_instance_turbo_vehicle_speed(instance_inj_ctrl_rpm_in,instance_inj_ctrl_turbo_speed,instance_inj_ctrl_vehicle_speed,instance_inj_ctrl_rpm_out,instance_inj_ctrl_turbo,instance_inj_ctrl_vehicle); 
  assign instance_inj_ctrl_clock=instance_inj_ctrl_clock_internal; 
  assign instance_inj_ctrl_a_bus=a_bus; 
  assign instance_inj_ctrl_clock=clock; 
  assign instance_inj_ctrl_cs=cs; 
  assign instance_inj_ctrl_digital_input=digital_input; 
  assign instance_inj_ctrl_ds=ds; 
  assign instance_inj_ctrl_fbk_pwm=fbk_pwm; 
  assign instance_inj_ctrl_inj_cmd=inj_cmd; 
  assign instance_inj_ctrl_in_speed=in_speed; 
  assign instance_inj_ctrl_i_fbk=i_fbk; 
  assign instance_inj_ctrl_nssm_in=nssm_in; 
  assign instance_inj_ctrl_rpm_in=rpm_in; 
  assign instance_inj_ctrl_rst=reset; 
  assign instance_inj_ctrl_r_w=r_w; 
  assign instance_inj_ctrl_seg_speed_hall=seg_speed_hall; 
  assign instance_inj_ctrl_seg_speed_pickup=seg_speed_pickup; 
  assign instance_inj_ctrl_trg_knock1=trg_knock1; 
  assign instance_inj_ctrl_trg_knock2=trg_knock2; 
  assign instance_inj_ctrl_turbo_speed=turbo_speed; 
  assign instance_inj_ctrl_vehicle_speed=vehicle_speed; 
  assign instance_inj_ctrl_v_fbk=v_fbk; 
  assign cam_smot=instance_inj_ctrl_cam_smot; 
  assign clock=instance_inj_ctrl_digital_output; 
  assign digital_output=instance_inj_ctrl_hlo; 
  assign hlo=instance_inj_ctrl_in_speed_lev; 
  assign in_speed_lev=instance_inj_ctrl_irq; 
  assign irq=instance_inj_ctrl_knock1; 
  assign knock1=instance_inj_ctrl_knock1u; 
  assign knock1u=instance_inj_ctrl_knock2; 
  assign knock2=instance_inj_ctrl_knock2u; 
  assign knock2u=instance_inj_ctrl_relpot; 
  assign relpot=instance_inj_ctrl_rpm_out; 
  assign rpm_out=instance_inj_ctrl_seg_speed_lev; 
  assign seg_speed_lev=instance_inj_ctrl_smot60; 
  assign smot60=instance_inj_ctrl_t1; 
  assign t1=instance_inj_ctrl_t2; 
  assign t2=instance_inj_ctrl_t3; 
  assign t3=instance_inj_ctrl_turbo; 
  assign turbo=instance_inj_ctrl_turbo_speed_lev; 
  assign turbo_speed_lev=instance_inj_ctrl_vehicle; 
  rst_inv instance_rst_inv(reset); 
endmodule
 
module chopper_count (clock,cs4,rst,chop_count) ; 
   reg [7-1:0] int_counter ;  
  always @(  posedge clock or  negedge rst)
       begin :vhdl_chopper_count
         if (rst==1'b0)
            int_counter <={7{1'b0}};
          else 
            begin 
              if (cs4==1'b1)
                 int_counter <={7{1'b0}};
               else 
                 int_counter <=int_counter+7'b0000001;
            end 
       end
  
  assign chop_count=int_counter; 
endmodule
 
module clock_gen (clock_i,rst,clock_o) ; 
   reg [3:0] counter ;  
   reg clock_int ;  
  always @(  posedge clock_i or  negedge rst)
       begin :vhdl_clock_gen
         if (rst==1'b0)
            begin 
              counter <={4{1'b0}};
              clock_int <=1'b0;
            end 
          else 
            begin 
              if (counter==4'b1001)
                 begin 
                   counter <=4'b0000;
                   clock_int <=(~clock_int);
                 end 
               else 
                 counter <=counter+4'b0001;
            end 
       end
  
  assign clock_o=clock_int; 
endmodule
 
module comparator (count,stop_count_bus,comp) ; 
  always @(  count or  stop_count_bus)
       begin :vhdl_comparator
         if (count==stop_count_bus)
            comp <=1'b1;
          else 
            comp <=1'b0;
       end
  
endmodule
 
module counter (clock,cs1,rst,count) ; 
   reg [12-1:0] int_counter ;  
  always @(  posedge clock or  negedge rst)
       begin :vhdl_counter
         if (rst==1'b0)
            int_counter <={12{1'b0}};
          else 
            begin 
              if (cs1==1'b1)
                 int_counter <={12{1'b0}};
               else 
                 int_counter <=int_counter+11'b00000000001;
            end 
       end
  
  assign count=int_counter; 
endmodule
 
module d_bus_handle (clock,rd_en,rst,wr_en,d_bus,d_bus_ext) ; 
   reg [16-1:0] d_bus_int ;  
  assign d_bus=((wr_en==1'b1))?d_bus_int:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus_ext=((rd_en==1'b1))?d_bus:16'bZZZZZZZZZZZZZZZZ; 
  always @(  posedge clock or  negedge rst)
       begin :vhdl_d_bus_handle
         if (rst==1'b0)
            d_bus_int <={16{1'b0}};
          else 
            d_bus_int <=d_bus_ext;
       end
  
endmodule
 
module d_bus_interface (clock,cs,ds,rst,r_w,rd_en,wr_en,d_bus,d_bus_ext) ; 
   wire rd_en_internal ;  
   wire wr_en_internal ;  
  d_bus_handle instance_d_bus_handle(clock,rd_en_internal,rst,wr_en_internal,d_bus,d_bus_ext); 
  ds_handle instance_ds_handle(clock,cs,ds,rst,r_w,rd_en_internal,wr_en_internal); 
  assign rd_en=rd_en_internal; 
  assign wr_en=wr_en_internal; 
endmodule
 
module digital_inputs_handle (clock,rst,rd_en,digital_input,fbk_pwm,nssm_in,a_dig_in,d_bus) ; 
   reg [31:0] store_digital_input ;  
  always @(  posedge clock or  negedge rst)
       begin :vhdl_digital_inputs_handle
         if (rst==1'b0)
            store_digital_input <={32{1'b0}};
          else 
            begin 
              store_digital_input [20:0]<=digital_input;
              store_digital_input [23:21]<=fbk_pwm;
              store_digital_input [30:24]<=nssm_in;
            end 
       end
  
  assign d_bus=((a_dig_in[0]==1'b1&rd_en==1'b1))?store_digital_input[15:0]:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((a_dig_in[1]==1'b1&rd_en==1'b1))?{1'b0,store_digital_input[30:16]}:16'bZZZZZZZZZZZZZZZZ; 
endmodule
 
module digital_outputs_handle (a_dig_out,clock,d_bus,rst,wr_en,digital_output,in_speed_lev,knock1u,knock2u,pickup_hall,seg_speed_lev,smot_camme_en,trg_knock_en,turbo_speed_lev) ; 
   reg [7:0] digital_output_store ;  
   reg smot_camme_store ;  
   reg trg_knock_store ;  
   reg knock1_store ;  
   reg knock2_store ;  
   reg in_speed_lev_store ;  
   reg seg_speed_lev_store ;  
   reg turbo_speed_lev_store ;  
   reg pickup_hall_store ;  
  assign digital_output=digital_output_store; 
  assign smot_camme_en=smot_camme_store; 
  assign trg_knock_en=trg_knock_store; 
  assign pickup_hall=pickup_hall_store; 
  assign in_speed_lev=in_speed_lev_store; 
  assign seg_speed_lev=seg_speed_lev_store; 
  assign turbo_speed_lev=turbo_speed_lev_store; 
  assign knock1u=knock1_store; 
  assign knock2u=knock2_store; 
  always @(  posedge clock or  negedge rst)
       begin :vhdl_digital_outputs_handle
         if (rst==1'b0)
            begin 
              digital_output_store <={8{1'b0}};
              smot_camme_store <=1'b0;
              trg_knock_store <=1'b0;
              pickup_hall_store <=1'b0;
              in_speed_lev_store <=1'b0;
              seg_speed_lev_store <=1'b0;
              turbo_speed_lev_store <=1'b0;
              knock1_store <=1'b0;
              knock2_store <=1'b0;
            end 
          else 
            begin 
              if (a_dig_out==1'b1&wr_en==1'b1)
                 begin 
                   digital_output_store <=d_bus[7:0];
                   smot_camme_store <=d_bus[8];
                   trg_knock_store <=d_bus[9];
                   pickup_hall_store <=d_bus[10];
                   in_speed_lev_store <=d_bus[11];
                   seg_speed_lev_store <=d_bus[12];
                   turbo_speed_lev_store <=d_bus[13];
                   knock1_store <=d_bus[14];
                   knock2_store <=d_bus[15];
                 end 
            end 
       end
  
endmodule
 
module ds_handle (clock,cs,ds,rst,r_w,rd_en,wr_en) ; 
   wire wr_en_int ;  
  assign rd_en=(~(cs))&r_w; 
  assign wr_en_int=(~(cs))&(~(ds))&(~(r_w)); 
  always @(  posedge clock or  negedge rst)
       begin :vhdl_ds_handle
         if (rst==1'b0)
            wr_en <=1'b0;
          else 
            wr_en <=wr_en_int;
       end
  
endmodule
 
module dwand (i0,i1,i2,i3,i4,o) ; 
  assign o=(i0&i1&i2&i3&i4); 
endmodule
 
module enable_fbk_chk (clock,global_state,rst,test_en_cur,enable_check,en_fbk_store,en_state_store,global_state_store) ; 
   reg [6:0] global_state_store_int ;  
   reg [3-1:0] delay_counter ;  
  always @(  posedge clock or  negedge rst)
       if (rst==1'b0)
          global_state_store_int <=7'b0000000;
        else 
          global_state_store_int <=global_state;
 
  always @(  posedge clock or  negedge rst)
       if (rst==1'b0)
          delay_counter <=3'b000;
        else 
          begin 
            if (global_state_store_int!=global_state)
               delay_counter <=3'b000;
             else 
               if (delay_counter[2]==1'b0)
                  delay_counter <=delay_counter+3'b001;
          end
  
  always @(    delay_counter[2] or  test_en_cur or  global_state or  global_state_store_int)
       begin 
         if ((delay_counter[2]==1'b1)&(test_en_cur==1'b1)&(global_state==global_state_store_int))
            enable_check <=1'b1;
          else 
            enable_check <=1'b0;
         if (global_state_store_int!=global_state)
            begin 
              if (global_state[6:5]!=2'b11)
                 begin 
                   en_state_store <=1'b1;
                   en_fbk_store <=1'b1;
                 end 
               else 
                 begin 
                   en_state_store <=1'b0;
                   en_fbk_store <=1'b1;
                 end 
            end 
          else 
            begin 
              en_state_store <=1'b0;
              en_fbk_store <=1'b0;
            end 
       end
  
  assign global_state_store=global_state; 
endmodule
 
module error_handle (a_fault_dec,a_fault_dec_r,clock,en_fbk_store_034,en_fbk_store_125,en_state_store_034,en_state_store_125,global_state_034,global_state_125,i_fbk_f,rd_en,rel_pot_en,rst,v_fbk_f,wr_en,relpot,status_reg_034,status_reg_125,d_bus) ; 
   reg [10:0] sr_034 ;  
   reg [10:0] sr_125 ;  
  assign status_reg_034=sr_034[10:0]; 
  assign status_reg_125=sr_125[10:0]; 
  assign relpot=rel_pot_en; 
  always @(    posedge clock or  negedge rst or  a_fault_dec or  posedge wr_en)
       begin :vhdl_st_reg_wr_034
         if ((rst==1'b0)|(a_fault_dec[0]==1'b1&wr_en==1'b1))
            sr_034 <={11{1'b0}};
          else 
            begin 
              if (en_state_store_034==1'b1)
                 sr_034 [6:0]<=global_state_034;
              if (en_fbk_store_034==1'b1)
                 begin 
                   sr_034 [7]<=i_fbk_f[0];
                   sr_034 [8]<=v_fbk_f[0];
                   sr_034 [9]<=v_fbk_f[3];
                   sr_034 [10]<=v_fbk_f[4];
                 end 
            end 
       end
  
  always @(    posedge clock or  negedge rst or  a_fault_dec or  posedge wr_en)
       begin :vhdl_st_reg_wr_125
         if ((rst==1'b0)|(a_fault_dec[1]==1'b1&wr_en==1'b1))
            sr_125 <={11{1'b0}};
          else 
            begin 
              if (en_state_store_125==1'b1)
                 sr_125 [6:0]<=global_state_125;
              if (en_fbk_store_125==1'b1)
                 begin 
                   sr_125 [7]<=i_fbk_f[1];
                   sr_125 [8]<=v_fbk_f[1];
                   sr_125 [9]<=v_fbk_f[2];
                   sr_125 [10]<=v_fbk_f[5];
                 end 
            end 
       end
  
  assign d_bus=((a_fault_dec_r[0]==1'b1&rd_en==1'b1))?{5'b00000,sr_034}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((a_fault_dec_r[1]==1'b1&rd_en==1'b1))?{5'b00000,sr_125}:16'bZZZZZZZZZZZZZZZZ; 
endmodule
 
module filter (clock,new_value,rst,filtered_value) ; 
 parameter[2:0] filter_state_type_start_state =0,filter_state_type_zero_1=1,filter_state_type_zero_2=2,filter_state_type_zero_3=3,filter_state_type_one_0=4,filter_state_type_one_1=5,filter_state_type_one_2=6,filter_state_type_one_3=7; 
   reg [2:0] current_state ;  
   reg [2:0] next_state ;  
  always @(   posedge clock or  new_value or  negedge rst)
       begin :clocked
         if (rst==1'b0)
            current_state <=filter_state_type_start_state;
          else 
            current_state <=next_state;
       end
  
  always @(    current_state or  clock or  new_value or  rst)
       begin :set_next_state
         next_state <=current_state;
         case (current_state)
          filter_state_type_start_state :
             if (new_value==1'b0)
                next_state <=filter_state_type_start_state;
              else 
                if (new_value==1'b1)
                   next_state <=filter_state_type_zero_1;
          filter_state_type_zero_1 :
             if (new_value==1'b1)
                next_state <=filter_state_type_zero_2;
              else 
                if (new_value==1'b0)
                   next_state <=filter_state_type_start_state;
          filter_state_type_zero_2 :
             if (new_value==1'b1)
                next_state <=filter_state_type_zero_3;
              else 
                if (new_value==1'b0)
                   next_state <=filter_state_type_zero_1;
          filter_state_type_zero_3 :
             if (new_value==1'b1)
                next_state <=filter_state_type_one_0;
              else 
                if (new_value==1'b0)
                   next_state <=filter_state_type_zero_2;
          filter_state_type_one_0 :
             if (new_value==1'b1)
                next_state <=filter_state_type_one_0;
              else 
                if (new_value==1'b0)
                   next_state <=filter_state_type_one_1;
          filter_state_type_one_1 :
             if (new_value==1'b1)
                next_state <=filter_state_type_one_0;
              else 
                if (new_value==1'b0)
                   next_state <=filter_state_type_one_2;
          filter_state_type_one_2 :
             if (new_value==1'b1)
                next_state <=filter_state_type_one_1;
              else 
                if (new_value==1'b0)
                   next_state <=filter_state_type_one_3;
          filter_state_type_one_3 :
             if (new_value==1'b1)
                next_state <=filter_state_type_one_2;
              else 
                if (new_value==1'b0)
                   next_state <=filter_state_type_start_state;
          default :;
         endcase 
       end
  
  always @( current_state)
       begin :unclocked
         case (current_state)
          filter_state_type_start_state :
             filtered_value <=1'b0;
          filter_state_type_zero_1 :
             filtered_value <=1'b0;
          filter_state_type_zero_2 :
             filtered_value <=1'b0;
          filter_state_type_zero_3 :
             filtered_value <=1'b0;
          filter_state_type_one_0 :
             filtered_value <=1'b1;
          filter_state_type_one_1 :
             filtered_value <=1'b1;
          filter_state_type_one_2 :
             filtered_value <=1'b1;
          filter_state_type_one_3 :
             filtered_value <=1'b1;
          default :;
         endcase 
       end
  
endmodule
 
module filter_feedback (clock,i_fbk,rst,v_fbk,i_fbk_f,v_fbk_f) ; 
   wire v_fbk_0 ;  
   wire v_fbk_f0 ;  
   wire v_fbk_1 ;  
   wire v_fbk_f1 ;  
   wire v_fbk_2 ;  
   wire v_fbk_f2 ;  
   wire v_fbk_3 ;  
   wire v_fbk_f3 ;  
   wire v_fbk_4 ;  
   wire v_fbk_f4 ;  
   wire v_fbk_5 ;  
   wire v_fbk_f5 ;  
   wire i_fbk_0 ;  
   wire i_fbk_f0 ;  
   wire i_fbk_1 ;  
   wire i_fbk_f1 ;  
  filtering instance_filt0(clock,v_fbk_0,rst,v_fbk_f0); 
  filtering instance_filt1(clock,v_fbk_1,rst,v_fbk_f1); 
  filtering instance_filt2(clock,v_fbk_2,rst,v_fbk_f2); 
  filtering instance_filt3(clock,v_fbk_3,rst,v_fbk_f3); 
  filtering instance_filt4(clock,v_fbk_4,rst,v_fbk_f4); 
  filtering instance_filt5(clock,v_fbk_5,rst,v_fbk_f5); 
  filtering instance_filt6(clock,i_fbk_0,rst,i_fbk_f0); 
  filtering instance_filt7(clock,i_fbk_1,rst,i_fbk_f1); 
  interface instance_interface(i_fbk,i_fbk_f0,i_fbk_f1,v_fbk,v_fbk_f0,v_fbk_f1,v_fbk_f2,v_fbk_f3,v_fbk_f4,v_fbk_f5,i_fbk_0,i_fbk_1,i_fbk_f,v_fbk_0,v_fbk_1,v_fbk_2,v_fbk_3,v_fbk_4,v_fbk_5,v_fbk_f); 
endmodule
 
module filtering (clock,new_value,rst,filtered_value) ; 
  filter instance_filter(clock,new_value,rst,filtered_value); 
endmodule
 
module fsm (clock,cmd_stored,comp,end_on,end_period,end_t0,inj_cmd,i_fbk,rst,sh_mode,status_reg,t4_0,test_en_cur,th_0,v_fbk_cur,v_fbk_mask,cs0,cs1,cs2,cs4,cs8,en_fbk_store,en_state_store,error,global_state_store,hl,relpot,t1,t2,t3) ; 
   wire [7-1:0] global_state ;  
   wire enable_check ;  
   wire [5-1:0] cur_state ;  
   wire cs11 ;  
   wire global1_state ;  
   wire cs111 ;  
   wire t31 ;  
   wire [2-1:0] global2_state ;  
   wire cs42 ;  
   wire t12 ;  
   wire [2-1:0] global4_state ;  
   wire cs44 ;  
   wire t14 ;  
   wire en_fbk_store_internal ;  
  enable_fbk_chk instance_enable_fbk_chk(clock,global_state,rst,test_en_cur,enable_check,en_fbk_store_internal,en_state_store,global_state_store); 
  fsm_output_handle instance_fsm_output_handle(cur_state,en_fbk_store_internal,cs0,cs11,error,relpot); 
  ph1_handle instance_ph1_handle(clock,cmd_stored,cur_state,end_t0,inj_cmd,rst,global1_state); 
  ph1_output_handle instance_ph1_output_handle(global1_state,cs111,t31); 
  ph2_handle instance_ph2_handle(clock,cur_state,end_on,end_period,i_fbk,rst,sh_mode,global2_state); 
  ph2_output_handle instance_ph2_output_handle(global2_state,cs42,t12); 
  ph4_handle instance_ph4_handle(clock,cur_state,end_on,end_period,i_fbk,rst,sh_mode,global4_state); 
  ph4_output_handle instance_ph4_output_handle(global4_state,cs44,t14); 
  sel_actuator instance_sel_actuator(cur_state,t12,t14,t31,hl,t1,t2,t3); 
  sel_chop_control instance_sel_chop_control(cs42,cs44,cur_state,cs4); 
  sel_glob_count_cs instance_sel_glob_count_cs(cs11,cs111,cur_state,global1_state,cs1,cs2,cs8); 
  sel_global_state instance_sel_global_state(cur_state,global1_state,global2_state,global4_state,global_state); 
  state_progression instance_state_progression(clock,cmd_stored,comp,enable_check,end_t0,global_state,inj_cmd,i_fbk,rst,sh_mode,status_reg,t4_0,th_0,v_fbk_cur,v_fbk_mask,cur_state); 
  assign en_fbk_store=en_fbk_store_internal; 
endmodule
 
module fsm_output_handle (cur_state,en_fbk_store,cs0,cs11,error,relpot) ; 
  assign relpot=cur_state[4]&cur_state[3]&cur_state[2]&cur_state[0]; 
  assign cs0=cur_state[4:1]; 
  assign error=cur_state[4]&cur_state[3]&cur_state[2]&(~(en_fbk_store)); 
  always @( cur_state)
       case (cur_state)
        5 'b00000:
           cs11 <=1'b1;
        5 'b00010:
           cs11 <=1'b1;
        5 'b00100:
           cs11 <=1'b1;
        5 'b00110:
           cs11 <=1'b1;
        5 'b01000:
           cs11 <=1'b1;
        5 'b01010:
           cs11 <=1'b1;
        5 'b01100:
           cs11 <=1'b1;
        5 'b01110:
           cs11 <=1'b1;
        5 'b11000:
           cs11 <=1'b1;
        default :
           cs11 <=1'b0;
       endcase
  
endmodule
 
module in_reg (add_decoded,add_decoded_r,clock,rd_en,rst,wr_en,r_t1,r_t2,r_t3_034,r_t3_125,r_t4_034,r_t4_125,r_tb_034,r_tb_125,r_th_034,r_th_125,r_tonh,r_tonl,r_tp,d_bus) ; 
   reg [12-1:0] th_034 ;  
   reg [12-1:0] th_125 ;  
   reg [7-1:0] t2 ;  
   reg [7-1:0] tp ;  
   reg [7-1:0] t4_034 ;  
   reg [7-1:0] t4_125 ;  
   reg [7-1:0] tonh ;  
   reg [7-1:0] tonl ;  
   reg [8-1:0] t1 ;  
   reg [8-1:0] t3_034 ;  
   reg [8-1:0] t3_125 ;  
   reg [10-1:0] tb_034 ;  
   reg [10-1:0] tb_125 ;  
  assign r_t1=t1; 
  assign r_t2=t2; 
  assign r_tb_034=tb_034; 
  assign r_th_034=th_034; 
  assign r_tb_125=tb_125; 
  assign r_th_125=th_125; 
  assign r_tonh=tonh; 
  assign r_tonl=tonl; 
  assign r_tp=tp; 
  assign r_t3_034=t3_034; 
  assign r_t3_125=t3_125; 
  assign r_t4_034=t4_034; 
  assign r_t4_125=t4_125; 
  always @(  posedge clock or  negedge rst)
       begin :vhdl_in_reg
         if (rst==1'b0)
            begin 
              t1 <={8{1'b0}};
              t2 <={7{1'b0}};
              tb_034 <={10{1'b0}};
              th_034 <={12{1'b0}};
              tb_125 <={10{1'b0}};
              th_125 <={12{1'b0}};
              tonh <={7{1'b0}};
              tonl <={7{1'b0}};
              tp <={7{1'b0}};
              t3_034 <={8{1'b0}};
              t3_125 <={8{1'b0}};
              t4_034 <={7{1'b0}};
              t4_125 <={7{1'b0}};
            end 
          else 
            begin 
              if (wr_en==1'b1)
                 begin 
                   if (add_decoded[0]==1'b1)
                      t1 <=d_bus[7:0];
                   if (add_decoded[1]==1'b1)
                      t2 <=d_bus[6:0];
                   if (add_decoded[2]==1'b1)
                      tb_034 <=d_bus[9:0];
                   if (add_decoded[3]==1'b1)
                      th_034 <=d_bus[11:0];
                   if (add_decoded[4]==1'b1)
                      tb_125 <=d_bus[9:0];
                   if (add_decoded[5]==1'b1)
                      th_125 <=d_bus[11:0];
                   if (add_decoded[6]==1'b1)
                      tonh <=d_bus[6:0];
                   if (add_decoded[7]==1'b1)
                      tonl <=d_bus[6:0];
                   if (add_decoded[8]==1'b1)
                      tp <=d_bus[6:0];
                   if (add_decoded[9]==1'b1)
                      t3_034 <=d_bus[7:0];
                   if (add_decoded[10]==1'b1)
                      t3_125 <=d_bus[7:0];
                   if (add_decoded[11]==1'b1)
                      t4_034 <=d_bus[6:0];
                   if (add_decoded[12]==1'b1)
                      t4_125 <=d_bus[6:0];
                 end 
            end 
       end
  
  assign d_bus=((add_decoded_r[0]==1'b1&rd_en==1'b1))?{8'b00000000,t1}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((add_decoded_r[1]==1'b1&rd_en==1'b1))?{9'b000000000,t2}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((add_decoded_r[2]==1'b1&rd_en==1'b1))?{6'b000000,tb_034}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((add_decoded_r[3]==1'b1&rd_en==1'b1))?{4'b0000,th_034}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((add_decoded_r[4]==1'b1&rd_en==1'b1))?{6'b000000,tb_125}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((add_decoded_r[5]==1'b1&rd_en==1'b1))?{4'b0000,th_125}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((add_decoded_r[6]==1'b1&rd_en==1'b1))?{9'b000000000,tonh}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((add_decoded_r[7]==1'b1&rd_en==1'b1))?{9'b000000000,tonl}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((add_decoded_r[8]==1'b1&rd_en==1'b1))?{9'b000000000,tp}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((add_decoded_r[9]==1'b1&rd_en==1'b1))?{8'b00000000,t3_034}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((add_decoded_r[10]==1'b1&rd_en==1'b1))?{8'b00000000,t3_125}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((add_decoded_r[11]==1'b1&rd_en==1'b1))?{9'b000000000,t4_034}:16'bZZZZZZZZZZZZZZZZ; 
  assign d_bus=((add_decoded_r[12]==1'b1&rd_en==1'b1))?{9'b000000000,t4_125}:16'bZZZZZZZZZZZZZZZZ; 
endmodule
 
module inj_block (clock,inj_cmd,i_fbk,rst,r_t1,r_t2,r_t3,r_t4,r_tb,r_th,r_tonh,r_tonl,r_tp,status_reg,test_en,v_fbk,en_fbk_store,en_state_store,error,global_state_store,hl,relpot,t1a,t1b,t1c,t2a,t2b,t2c,t3) ; 
   wire cs8 ;  
   wire end_t0 ;  
   wire cs4 ;  
   wire [7-1:0] chop_count ;  
   wire [12-1:0] count ;  
   wire [12-1:0] stop_count_bus ;  
   wire comp ;  
   wire cs1 ;  
   wire [3-1:0] cmd_stored ;  
   wire end_on ;  
   wire end_period ;  
   wire sh_mode ;  
   wire t4_0 ;  
   wire test_en_cur ;  
   wire th_0 ;  
   wire v_fbk_cur ;  
   wire [3-1:0] v_fbk_mask ;  
   wire [4-1:0] cs0 ;  
   wire cs2 ;  
   wire t1 ;  
   wire t2 ;  
   wire [7-1:0] ton_reg ;  
   wire [7-1:0] tp_reg ;  
  anti_glitch instance_anti_glitch(clock,cs8,rst,end_t0); 
  chopper_count instance_chopper_count(clock,cs4,rst,chop_count); 
  comparator instance_comparator(count,stop_count_bus,comp); 
  counter instance_counter(clock,cs1,rst,count); 
  fsm instance_fsm(clock,cmd_stored,comp,end_on,end_period,end_t0,inj_cmd,i_fbk,rst,sh_mode,status_reg,t4_0,test_en_cur,th_0,v_fbk_cur,v_fbk_mask,cs0,cs1,cs2,cs4,cs8,en_fbk_store,en_state_store,error,global_state_store,hl,relpot,t1,t2,t3); 
  internal_register instance_internal_register(clock,cs0,cs2,rst,r_t1,r_t2,r_t3,r_t4,r_tb,r_th,r_tonh,r_tonl,r_tp,sh_mode,stop_count_bus,t4_0,th_0,ton_reg,tp_reg); 
  on_comp instance_on_comp(chop_count,ton_reg,end_on); 
  output_decoder instance_output_decoder(cmd_stored,t1,t2,t1a,t1b,t1c,t2a,t2b,t2c); 
  period_comp instance_period_comp(chop_count,tp_reg,end_period); 
  sel_cmd instance_sel_cmd(clock,cs2,inj_cmd,rst,test_en,v_fbk,cmd_stored,test_en_cur,v_fbk_cur,v_fbk_mask); 
endmodule
 
module inj_ctrl (a_bus,clock,cs,digital_input,ds,fbk_pwm,inj_cmd,in_speed,i_fbk,nssm_in,rpm_in,rst,r_w,seg_speed_hall,seg_speed_pickup,trg_knock1,trg_knock2,turbo_speed,vehicle_speed,v_fbk,cam_smot,digital_output,hlo,in_speed_lev,irq,knock1,knock1u,knock2,knock2u,relpot,rpm_out,seg_speed_lev,smot60,t1,t2,t3,turbo,turbo_speed_lev,vehicle,d_bus_ext) ; 
   wire [3-1:0] inj_cmd_034 ;  
   wire i_fbk_034 ;  
   wire [8-1:0] r_t1 ;  
   wire [7-1:0] r_t2 ;  
   wire [8-1:0] r_t3_034 ;  
   wire [7-1:0] r_t4_034 ;  
   wire [10-1:0] r_tb_034 ;  
   wire [12-1:0] r_th_034 ;  
   wire [7-1:0] r_tonh ;  
   wire [7-1:0] r_tonl ;  
   wire [7-1:0] r_tp ;  
   wire [11-1:0] status_reg_034 ;  
   wire [3-1:0] test_en_034 ;  
   wire [3-1:0] v_fbk_034 ;  
   wire en_fbk_store_034 ;  
   wire en_state_store_034 ;  
   wire error1 ;  
   wire [7-1:0] global_state_034 ;  
   wire hl_034 ;  
   wire relpot1 ;  
   wire t1_0 ;  
   wire t1_3 ;  
   wire t1_4 ;  
   wire t2_0 ;  
   wire t2_3 ;  
   wire t2_4 ;  
   wire t3_034 ;  
   wire [3-1:0] inj_cmd_125 ;  
   wire i_fbk_125 ;  
   wire [8-1:0] r_t3_125 ;  
   wire [7-1:0] r_t4_125 ;  
   wire [10-1:0] r_tb_125 ;  
   wire [12-1:0] r_th_125 ;  
   wire [11-1:0] status_reg_125 ;  
   wire [3-1:0] test_en_125 ;  
   wire [3-1:0] v_fbk_125 ;  
   wire en_fbk_store_125 ;  
   wire en_state_store_125 ;  
   wire error2 ;  
   wire [7-1:0] global_state_125 ;  
   wire hl_125 ;  
   wire relpot2 ;  
   wire t1_1 ;  
   wire t1_2 ;  
   wire t1_5 ;  
   wire t2_1 ;  
   wire t2_2 ;  
   wire t2_5 ;  
   wire t3_125 ;  
   wire rd_en ;  
   wire wr_en ;  
   wire [16-1:0] d_bus ;  
   wire [2-1:0] i_fbk_f ;  
   wire [6-1:0] v_fbk_f ;  
   wire rel_pot_en ;  
   wire pickup_hall ;  
   wire smot_camme_en ;  
   wire trg_knock_en ;  
   wire clock_internal ;  
  inj_block instance_block_034(clock_internal,inj_cmd_034,i_fbk_034,rst,r_t1,r_t2,r_t3_034,r_t4_034,r_tb_034,r_th_034,r_tonh,r_tonl,r_tp,status_reg_034,test_en_034,v_fbk_034,en_fbk_store_034,en_state_store_034,error1,global_state_034,hl_034,relpot1,t1_0,t1_3,t1_4,t2_0,t2_3,t2_4,t3_034); 
  inj_block instance_block_125(clock_internal,inj_cmd_125,i_fbk_125,rst,r_t1,r_t2,r_t3_125,r_t4_125,r_tb_125,r_th_125,r_tonh,r_tonl,r_tp,status_reg_125,test_en_125,v_fbk_125,en_fbk_store_125,en_state_store_125,error2,global_state_125,hl_125,relpot2,t1_1,t1_2,t1_5,t2_1,t2_2,t2_5,t3_125); 
  clock_gen instance_clock_gen(clock,rst,clock_internal); 
  d_bus_interface instance_d_bus_interface(clock,cs,ds,rst,r_w,rd_en,wr_en,d_bus,d_bus_ext); 
  filter_feedback instance_filter_feedback(clock_internal,i_fbk,rst,v_fbk,i_fbk_f,v_fbk_f); 
  merge instance_merge(error1,error2,hl_034,hl_125,relpot1,relpot2,hlo,irq,rel_pot_en); 
  merge_actuators instance_merge_actuators(t1_0,t1_1,t1_2,t1_3,t1_4,t1_5,t2_0,t2_1,t2_2,t2_3,t2_4,t2_5,t3_034,t3_125,t1,t2,t3); 
  registers instance_registers(a_bus,clock_internal,clock,digital_input,en_fbk_store_034,en_fbk_store_125,en_state_store_034,en_state_store_125,fbk_pwm,global_state_034,global_state_125,i_fbk_f,nssm_in,rd_en,rel_pot_en,rst,v_fbk_f,wr_en,digital_output,in_speed_lev,knock1u,knock2u,pickup_hall,relpot,r_t1,r_t2,r_t3_034,r_t3_125,r_t4_034,r_t4_125,r_tb_034,r_tb_125,r_th_034,r_th_125,r_tonh,r_tonl,r_tp,seg_speed_lev,smot_camme_en,status_reg_034,status_reg_125,test_en_034,test_en_125,trg_knock_en,turbo_speed_lev,d_bus); 
  smot_knock_handle instance_smot_knock_handle(clock_internal,in_speed,pickup_hall,rst,seg_speed_hall,seg_speed_pickup,smot_camme_en,trg_knock1,trg_knock2,trg_knock_en,cam_smot,knock1,knock2,smot60); 
  split instance_split(clock_internal,rst,inj_cmd,i_fbk_f,v_fbk_f,inj_cmd_034,inj_cmd_125,i_fbk_034,i_fbk_125,v_fbk_034,v_fbk_125); 
  turbo_vehicle_speed instance_turbo_vehicle_speed(rpm_in,turbo_speed,vehicle_speed,rpm_out,turbo,vehicle); 
  assign clock=clock_internal; 
endmodule
 
module interface (i_fbk,i_fbk_f0,i_fbk_f1,v_fbk,v_fbk_f0,v_fbk_f1,v_fbk_f2,v_fbk_f3,v_fbk_f4,v_fbk_f5,i_fbk_0,i_fbk_1,i_fbk_f,v_fbk_0,v_fbk_1,v_fbk_2,v_fbk_3,v_fbk_4,v_fbk_5,v_fbk_f) ; 
  assign v_fbk_0=v_fbk[0]; 
  assign v_fbk_1=v_fbk[1]; 
  assign v_fbk_2=v_fbk[2]; 
  assign v_fbk_3=v_fbk[3]; 
  assign v_fbk_4=v_fbk[4]; 
  assign v_fbk_5=v_fbk[5]; 
  assign v_fbk_f[0]=v_fbk_f0; 
  assign v_fbk_f[1]=v_fbk_f1; 
  assign v_fbk_f[2]=v_fbk_f2; 
  assign v_fbk_f[3]=v_fbk_f3; 
  assign v_fbk_f[4]=v_fbk_f4; 
  assign v_fbk_f[5]=v_fbk_f5; 
  assign i_fbk_0=(~(i_fbk[0])); 
  assign i_fbk_1=(~(i_fbk[1])); 
  assign i_fbk_f[0]=i_fbk_f0; 
  assign i_fbk_f[1]=i_fbk_f1; 
endmodule
 
module internal_register (clock,cs0,cs2,rst,r_t1,r_t2,r_t3,r_t4,r_tb,r_th,r_tonh,r_tonl,r_tp,sh_mode,stop_count_bus,t4_0,th_0,ton_reg,tp_reg) ; 
   reg [12-1:0] th ;  
   reg [10-1:0] tb ;  
   reg [7-1:0] tonh ;  
   reg [7-1:0] tonl ;  
  always @(  posedge clock or  negedge rst)
       begin :vhdl_internal_register
         if (rst==1'b0)
            begin 
              tb <={10{1'b0}};
              th <={12{1'b0}};
              tonh <={7{1'b0}};
              tonl <={7{1'b0}};
            end 
          else 
            begin 
              if (cs2==1'b1)
                 begin 
                   tb <=r_tb;
                   th <=r_th;
                   tonh <=r_tonh;
                   tonl <=r_tonl;
                 end 
            end 
       end
  
  assign tp_reg=r_tp; 
  assign sh_mode=tb[9]; 
  assign th_0=(~(th[0]|th[1]|th[2]|th[3]|th[4]|th[5]|th[6]|th[7]|th[8]|th[9]|th[10]|th[11])); 
  assign t4_0=(~(r_t4[6]|r_t4[5]|r_t4[4]|r_t4[3])); 
  assign stop_count_bus=(cs0==4'b0000)?{5'b00000,r_t1[7:1]}:12'bZZZZZZZZZZZZ; 
  assign ton_reg=(cs0==4'b0000)?tonh:7'bZZZZZZZ; 
  assign stop_count_bus=(cs0==4'b0001)?{5'b00000,r_t1[7:1]}:12'bZZZZZZZZZZZZ; 
  assign ton_reg=(cs0==4'b0001)?tonh:7'bZZZZZZZ; 
  assign stop_count_bus=(cs0==4'b0010)?{3'b000,tb[8:0]}:12'bZZZZZZZZZZZZ; 
  assign ton_reg=(cs0==4'b0010)?tonh:7'bZZZZZZZ; 
  assign stop_count_bus=(cs0==4'b0011)?{5'b00000,r_t2}:12'bZZZZZZZZZZZZ; 
  assign ton_reg=(cs0==4'b0011)?tonl:7'bZZZZZZZ; 
  assign stop_count_bus=(cs0==4'b0100)?th:12'bZZZZZZZZZZZZ; 
  assign ton_reg=(cs0==4'b0100)?tonl:7'bZZZZZZZ; 
  assign stop_count_bus=(cs0==4'b0101)?{5'b00000,r_t1[7:1]}:12'bZZZZZZZZZZZZ; 
  assign ton_reg=(cs0==4'b0101)?tonl:7'bZZZZZZZ; 
  assign stop_count_bus=(cs0==4'b0110)?{4'b0000,r_t3}:12'bZZZZZZZZZZZZ; 
  assign ton_reg=(cs0==4'b0110)?tonl:7'bZZZZZZZ; 
  assign stop_count_bus=(cs0==4'b0111)?{3'b000,r_t1,1'b0}:12'bZZZZZZZZZZZZ; 
  assign ton_reg=(cs0==4'b0111)?tonl:7'bZZZZZZZ; 
  assign stop_count_bus=(cs0==4'b1100)?{5'b00000,r_t4}:12'bZZZZZZZZZZZZ; 
  assign ton_reg=(cs0==4'b1100)?tonl:7'bZZZZZZZ; 
  assign stop_count_bus=(cs0[3:1]==3'b111)?{4'b0000,r_t1}:12'bZZZZZZZZZZZZ; 
  assign ton_reg=(cs0[3:1]==3'b111)?tonl:7'bZZZZZZZ; 
endmodule
 
module knock_comp1 (count1,en_comp1,impulse,long) ; 
  assign impulse=(count1[5]|count1[4]|count1[3])&(~(en_comp1)); 
  assign long=count1[0]&count1[1]&count1[2]&count1[3]&count1[4]&count1[5]; 
endmodule
 
module knock_comp2 (count2,en_comp2,impulse,long) ; 
  assign impulse=(count2[5]|count2[4]|count2[3])&(~(en_comp2)); 
  assign long=count2[0]&count2[1]&count2[2]&count2[3]&count2[4]&count2[5]; 
endmodule
 
module knock_count1 (clock,internal_trg_knock1,rst,count1,en_comp1) ; 
   reg store_trg_knock1 ;  
   reg store_reset_trg ;  
   wire rst_int ;  
   reg [6-1:0] int_counter1 ;  
  always @(  posedge clock or  negedge rst)
       begin :vhdl_knock_store
         if (rst==1'b0)
            begin 
              store_trg_knock1 <=1'b0;
              store_reset_trg <=1'b0;
            end 
          else 
            begin 
              store_trg_knock1 <=internal_trg_knock1;
              store_reset_trg <=(~(store_trg_knock1));
            end 
       end
  
  assign rst_int=rst&(~(store_reset_trg)); 
  assign en_comp1=store_trg_knock1; 
  always @(  posedge clock or  negedge rst_int)
       if (rst_int==1'b0)
          int_counter1 <={6{1'b0}};
        else 
          begin 
            if (store_trg_knock1==1'b1)
               int_counter1 <=int_counter1+6'b000001;
          end
  
  assign count1=int_counter1; 
endmodule
 
module knock_count2 (clock,rst,trg_knock2,count2,en_comp2) ; 
   reg store_trg_knock2 ;  
   reg store_reset_trg ;  
   wire rst_int ;  
   reg [6-1:0] int_counter2 ;  
  always @(  posedge clock or  negedge rst)
       begin :vhdl_knock_store
         if (rst==1'b0)
            begin 
              store_trg_knock2 <=1'b0;
              store_reset_trg <=1'b0;
            end 
          else 
            begin 
              store_trg_knock2 <=trg_knock2;
              store_reset_trg <=(~(store_trg_knock2));
            end 
       end
  
  assign rst_int=rst&(~(store_reset_trg)); 
  assign en_comp2=store_trg_knock2; 
  always @(  posedge clock or  negedge rst_int)
       if (rst_int==1'b0)
          int_counter2 <={6{1'b0}};
        else 
          begin 
            if (store_trg_knock2==1'b1)
               int_counter2 <=int_counter2+6'b000001;
          end
  
  assign count2=int_counter2; 
endmodule
 
module knock_detection_fsm1 (clock,internal_trg_knock1,rst,knock1) ; 
   wire [6-1:0] count1 ;  
   wire en_comp1 ;  
   wire impulse ;  
   wire long ;  
  knock_comp1 instance_knock_comp1(count1,en_comp1,impulse,long); 
  knock_count1 instance_knock_count1(clock,internal_trg_knock1,rst,count1,en_comp1); 
  knock_fsm1 instance_knock_fsm1(clock,impulse,long,rst,knock1); 
endmodule
 
module knock_detection_fsm2 (clock,rst,trg_knock2,knock2) ; 
   wire [6-1:0] count2 ;  
   wire en_comp2 ;  
   wire impulse ;  
   wire long ;  
  knock_comp2 instance_knock_comp2(count2,en_comp2,impulse,long); 
  knock_count2 instance_knock_count2(clock,rst,trg_knock2,count2,en_comp2); 
  knock_fsm2 instance_knock_fsm2(clock,impulse,long,rst,knock2); 
endmodule
 
module knock_fsm1 (clock,impulse,long,rst,knock1) ; 
 parameter[1:0] knock_fsm1_state_type_start_state =0,knock_fsm1_state_type_off1_state=1,knock_fsm1_state_type_sample_state=2,knock_fsm1_state_type_off2_state=3; 
   reg [1:0] current_state ;  
   reg [1:0] next_state ;  
  always @(    posedge clock or  impulse or  long or  negedge rst)
       begin :clocked
         if (rst==1'b0)
            begin 
              current_state <=knock_fsm1_state_type_start_state;
              knock1 <=2'b01;
            end 
          else 
            begin 
              current_state <=next_state;
              case (next_state)
               knock_fsm1_state_type_start_state :
                  knock1 <=2'b01;
               knock_fsm1_state_type_off1_state :
                  knock1 <=2'b00;
               knock_fsm1_state_type_sample_state :
                  knock1 <=2'b10;
               knock_fsm1_state_type_off2_state :
                  knock1 <=2'b00;
               default :;
              endcase 
            end 
       end
  
  always @(     current_state or  clock or  impulse or  long or  rst)
       begin :set_next_state
         next_state <=current_state;
         case (current_state)
          knock_fsm1_state_type_start_state :
             if (long==1'b1)
                next_state <=knock_fsm1_state_type_start_state;
              else 
                if (impulse==1'b1)
                   next_state <=knock_fsm1_state_type_off1_state;
          knock_fsm1_state_type_off1_state :
             if (impulse==1'b1)
                next_state <=knock_fsm1_state_type_sample_state;
              else 
                if (long==1'b1)
                   next_state <=knock_fsm1_state_type_start_state;
          knock_fsm1_state_type_sample_state :
             if (impulse==1'b1)
                next_state <=knock_fsm1_state_type_off2_state;
              else 
                if (long==1'b1)
                   next_state <=knock_fsm1_state_type_start_state;
          knock_fsm1_state_type_off2_state :
             if (long==1'b1)
                next_state <=knock_fsm1_state_type_start_state;
              else 
                if (impulse==1'b1)
                   next_state <=knock_fsm1_state_type_start_state;
          default :;
         endcase 
       end
  
endmodule
 
module knock_fsm2 (clock,impulse,long,rst,knock2) ; 
 parameter[1:0] knock_fsm2_state_type_start_state =0,knock_fsm2_state_type_off1_state=1,knock_fsm2_state_type_sample_state=2,knock_fsm2_state_type_off2_state=3; 
   reg [1:0] current_state ;  
   reg [1:0] next_state ;  
  always @(    posedge clock or  impulse or  long or  negedge rst)
       begin :clocked
         if (rst==1'b0)
            begin 
              current_state <=knock_fsm2_state_type_start_state;
              knock2 <=2'b01;
            end 
          else 
            begin 
              current_state <=next_state;
              case (next_state)
               knock_fsm2_state_type_start_state :
                  knock2 <=2'b01;
               knock_fsm2_state_type_off1_state :
                  knock2 <=2'b00;
               knock_fsm2_state_type_sample_state :
                  knock2 <=2'b10;
               knock_fsm2_state_type_off2_state :
                  knock2 <=2'b00;
               default :;
              endcase 
            end 
       end
  
  always @(     current_state or  clock or  impulse or  long or  rst)
       begin :set_next_state
         next_state <=current_state;
         case (current_state)
          knock_fsm2_state_type_start_state :
             if (long==1'b1)
                next_state <=knock_fsm2_state_type_start_state;
              else 
                if (impulse==1'b1)
                   next_state <=knock_fsm2_state_type_off1_state;
          knock_fsm2_state_type_off1_state :
             if (impulse==1'b1)
                next_state <=knock_fsm2_state_type_sample_state;
              else 
                if (long==1'b1)
                   next_state <=knock_fsm2_state_type_start_state;
          knock_fsm2_state_type_sample_state :
             if (impulse==1'b1)
                next_state <=knock_fsm2_state_type_off2_state;
              else 
                if (long==1'b1)
                   next_state <=knock_fsm2_state_type_start_state;
          knock_fsm2_state_type_off2_state :
             if (long==1'b1)
                next_state <=knock_fsm2_state_type_start_state;
              else 
                if (impulse==1'b1)
                   next_state <=knock_fsm2_state_type_start_state;
          default :;
         endcase 
       end
  
endmodule
 
module merge (error1,error2,hl_034,hl_125,relpot1,relpot2,hlo,irq,rel_pot_en) ; 
  assign rel_pot_en=relpot2|relpot1; 
  assign hlo[0]=(~(hl_034)); 
  assign hlo[1]=(~(hl_125)); 
  assign irq=(~(error1|error2)); 
endmodule
 
module merge_actuators (t1_0,t1_1,t1_2,t1_3,t1_4,t1_5,t2_0,t2_1,t2_2,t2_3,t2_4,t2_5,t3_034,t3_125,t1,t2,t3) ; 
  merge_t1 instance_merge_t1(t1_0,t1_1,t1_2,t1_3,t1_4,t1_5,t1); 
  merge_t2 instance_merge_t2(t2_0,t2_1,t2_2,t2_3,t2_4,t2_5,t2); 
  merge_t3 instance_merge_t3(t3_034,t3_125,t3); 
endmodule
 
module merge_t1 (t1_0,t1_1,t1_2,t1_3,t1_4,t1_5,t1) ; 
  always @(      t1_0 or  t1_1 or  t1_2 or  t1_3 or  t1_4 or  t1_5)
       begin :vhdl_merge_t1
         t1 [0]<=(~(t1_0));
         t1 [1]<=(~(t1_1));
         t1 [2]<=(~(t1_2));
         t1 [3]<=(~(t1_3));
         t1 [4]<=(~(t1_4));
         t1 [5]<=(~(t1_5));
       end
  
endmodule
 
module merge_t2 (t2_0,t2_1,t2_2,t2_3,t2_4,t2_5,t2) ; 
  always @(      t2_0 or  t2_1 or  t2_2 or  t2_3 or  t2_4 or  t2_5)
       begin :vhdl_merge_t2
         t2 [0]<=t2_0;
         t2 [1]<=t2_1;
         t2 [2]<=t2_2;
         t2 [3]<=t2_3;
         t2 [4]<=t2_4;
         t2 [5]<=t2_5;
       end
  
endmodule
 
module merge_t3 (t3_034,t3_125,t3) ; 
  always @(  t3_034 or  t3_125)
       begin :vhdl_merge_t3
         t3 [0]<=(~(t3_034));
         t3 [1]<=(~(t3_125));
       end
  
endmodule
 
module on_comp (chop_count,ton_reg,end_on) ; 
  always @(  chop_count or  ton_reg)
       begin :vhdl_on_comp
         if (chop_count==ton_reg)
            end_on <=1'b1;
          else 
            end_on <=1'b0;
       end
  
endmodule
 
module output_decoder (cmd_stored,t1,t2,t1a,t1b,t1c,t2a,t2b,t2c) ; 
  always @(   cmd_stored or  t1 or  t2)
       begin :vhdl_output_decoder
         case (cmd_stored)
          3 'b001:
             begin 
               t1a <=t1;
               t2a <=t2;
               t1b <=1'b0;
               t2b <=1'b0;
               t1c <=1'b0;
               t2c <=1'b0;
             end 
          3 'b010:
             begin 
               t1b <=t1;
               t2b <=t2;
               t1a <=1'b0;
               t2a <=1'b0;
               t1c <=1'b0;
               t2c <=1'b0;
             end 
          3 'b100:
             begin 
               t1c <=t1;
               t2c <=t2;
               t1b <=1'b0;
               t2b <=1'b0;
               t1a <=1'b0;
               t2a <=1'b0;
             end 
          default :
             begin 
               t1a <=1'b0;
               t2a <=1'b0;
               t1b <=1'b0;
               t2b <=1'b0;
               t1c <=1'b0;
               t2c <=1'b0;
             end 
         endcase 
       end
  
endmodule
 
module period_comp (chop_count,tp_reg,end_period) ; 
  always @(  chop_count or  tp_reg)
       begin :vhdl_period_comp
         if (chop_count==tp_reg)
            end_period <=1'b1;
          else 
            end_period <=1'b0;
       end
  
endmodule
 
module ph1_handle (clock,cmd_stored,cur_state,end_t0,inj_cmd,rst,global1_state) ; 
 parameter[1:0] ph1_handle_state_type_ph1_1_state =0,ph1_handle_state_type_ph1_2_state=1; 
   reg [1:0] current_state ;  
   reg [1:0] next_state ;  
  always @(      posedge clock or  cmd_stored or  cur_state or  end_t0 or  inj_cmd or  negedge rst)
       begin :clocked
         if (rst==1'b0)
            begin 
              current_state <=ph1_handle_state_type_ph1_1_state;
              global1_state <=1'b0;
            end 
          else 
            begin 
              current_state <=next_state;
              case (next_state)
               ph1_handle_state_type_ph1_1_state :
                  global1_state <=1'b0;
               ph1_handle_state_type_ph1_2_state :
                  global1_state <=1'b1;
               default :;
              endcase 
            end 
       end
  
  always @(       current_state or  clock or  cmd_stored or  cur_state or  end_t0 or  inj_cmd or  rst)
       begin :set_next_state
         next_state <=current_state;
         case (current_state)
          ph1_handle_state_type_ph1_1_state :
             if (end_t0==1'b1&(inj_cmd==cmd_stored)&cur_state==5'b00001)
                next_state <=ph1_handle_state_type_ph1_2_state;
              else 
                if (cur_state!=5'b00001)
                   next_state <=ph1_handle_state_type_ph1_1_state;
          ph1_handle_state_type_ph1_2_state :
             if (cur_state!=5'b00001)
                next_state <=ph1_handle_state_type_ph1_1_state;
          default :;
         endcase 
       end
  
endmodule
 
module ph1_output_handle (global1_state,cs111,t31) ; 
  always @( global1_state)
       if (global1_state==1'b1)
          begin 
            t31 <=1'b1;
            cs111 <=1'b0;
          end 
        else 
          begin 
            t31 <=1'b0;
            cs111 <=1'b1;
          end
  
endmodule
 
module ph2_handle (clock,cur_state,end_on,end_period,i_fbk,rst,sh_mode,global2_state) ; 
 parameter[1:0] ph2_handle_state_type_ph2_1_state =0,ph2_handle_state_type_ph2_2_state=1,ph2_handle_state_type_ph2_3_state=2,ph2_handle_state_type_ph2_4_state=3; 
   reg [1:0] current_state ;  
   reg [1:0] next_state ;  
  always @(       posedge clock or  cur_state or  end_on or  end_period or  i_fbk or  negedge rst or  sh_mode)
       begin :clocked
         if (rst==1'b0)
            begin 
              current_state <=ph2_handle_state_type_ph2_1_state;
              global2_state <=2'b01;
            end 
          else 
            begin 
              current_state <=next_state;
              case (next_state)
               ph2_handle_state_type_ph2_1_state :
                  global2_state <=2'b01;
               ph2_handle_state_type_ph2_2_state :
                  global2_state <=2'b10;
               ph2_handle_state_type_ph2_3_state :
                  global2_state <=2'b11;
               ph2_handle_state_type_ph2_4_state :
                  global2_state <=2'b00;
               default :;
              endcase 
            end 
       end
  
  always @(        current_state or  clock or  cur_state or  end_on or  end_period or  i_fbk or  rst or  sh_mode)
       begin :set_next_state
         next_state <=current_state;
         case (current_state)
          ph2_handle_state_type_ph2_1_state :
             if (cur_state==5'b00101&((sh_mode==1'b1&i_fbk==1'b1)|(sh_mode==1'b0&end_on==1'b1)))
                next_state <=ph2_handle_state_type_ph2_2_state;
              else 
                if (cur_state!=5'b00101)
                   next_state <=ph2_handle_state_type_ph2_1_state;
          ph2_handle_state_type_ph2_2_state :
             if (cur_state==5'b00101)
                next_state <=ph2_handle_state_type_ph2_3_state;
              else 
                if (cur_state!=5'b00101)
                   next_state <=ph2_handle_state_type_ph2_1_state;
          ph2_handle_state_type_ph2_3_state :
             if (cur_state==5'b00101&((sh_mode==1'b1&i_fbk==1'b0)|(sh_mode==1'b0&end_period==1'b1)))
                next_state <=ph2_handle_state_type_ph2_4_state;
              else 
                if (cur_state!=5'b00101)
                   next_state <=ph2_handle_state_type_ph2_1_state;
          ph2_handle_state_type_ph2_4_state :
             if (1'b1)
                next_state <=ph2_handle_state_type_ph2_1_state;
          default :;
         endcase 
       end
  
endmodule
 
module ph2_output_handle (global2_state,cs42,t12) ; 
  always @( global2_state)
       begin 
         if (global2_state==2'b00)
            cs42 <=1'b1;
          else 
            cs42 <=1'b0;
         if (global2_state[1]==1'b1)
            t12 <=1'b0;
          else 
            t12 <=1'b1;
       end
  
endmodule
 
module ph4_handle (clock,cur_state,end_on,end_period,i_fbk,rst,sh_mode,global4_state) ; 
 parameter[1:0] ph4_handle_state_type_ph4_1_state =0,ph4_handle_state_type_ph4_2_state=1,ph4_handle_state_type_ph4_3_state=2,ph4_handle_state_type_ph4_4_state=3; 
   reg [1:0] current_state ;  
   reg [1:0] next_state ;  
  always @(       posedge clock or  cur_state or  end_on or  end_period or  i_fbk or  negedge rst or  sh_mode)
       begin :clocked
         if (rst==1'b0)
            begin 
              current_state <=ph4_handle_state_type_ph4_1_state;
              global4_state <=2'b01;
            end 
          else 
            begin 
              current_state <=next_state;
              case (next_state)
               ph4_handle_state_type_ph4_1_state :
                  global4_state <=2'b01;
               ph4_handle_state_type_ph4_2_state :
                  global4_state <=2'b10;
               ph4_handle_state_type_ph4_3_state :
                  global4_state <=2'b11;
               ph4_handle_state_type_ph4_4_state :
                  global4_state <=2'b00;
               default :;
              endcase 
            end 
       end
  
  always @(        current_state or  clock or  cur_state or  end_on or  end_period or  i_fbk or  rst or  sh_mode)
       begin :set_next_state
         next_state <=current_state;
         case (current_state)
          ph4_handle_state_type_ph4_1_state :
             if (cur_state==5'b01001&((sh_mode==1'b1&i_fbk==1'b1)|(sh_mode==1'b0&end_on==1'b1)))
                next_state <=ph4_handle_state_type_ph4_2_state;
              else 
                if (cur_state!=5'b01001&cur_state!=5'b11001)
                   next_state <=ph4_handle_state_type_ph4_1_state;
                 else 
                   if (cur_state==5'b11001&((sh_mode==1'b1&i_fbk==1'b1)|(sh_mode==1'b0&end_on==1'b1)))
                      next_state <=ph4_handle_state_type_ph4_2_state;
          ph4_handle_state_type_ph4_2_state :
             if (cur_state==5'b01001|cur_state==5'b11001)
                next_state <=ph4_handle_state_type_ph4_3_state;
              else 
                if (cur_state!=5'b01001&cur_state!=5'b11001)
                   next_state <=ph4_handle_state_type_ph4_1_state;
          ph4_handle_state_type_ph4_3_state :
             if (cur_state==5'b01001&((sh_mode==1'b1&i_fbk==1'b0)|(sh_mode==1'b0&end_period==1'b1)))
                next_state <=ph4_handle_state_type_ph4_4_state;
              else 
                if (cur_state!=5'b01001&cur_state!=5'b11001)
                   next_state <=ph4_handle_state_type_ph4_1_state;
                 else 
                   if (cur_state==5'b11001&((sh_mode==1'b1&i_fbk==1'b0)|(sh_mode==1'b0&end_period==1'b1)))
                      next_state <=ph4_handle_state_type_ph4_4_state;
          ph4_handle_state_type_ph4_4_state :
             if (1'b1)
                next_state <=ph4_handle_state_type_ph4_1_state;
          default :;
         endcase 
       end
  
endmodule
 
module ph4_output_handle (global4_state,cs44,t14) ; 
  always @( global4_state)
       begin 
         if (global4_state==2'b00)
            cs44 <=1'b1;
          else 
            cs44 <=1'b0;
         if (global4_state[1]==1'b1)
            t14 <=1'b0;
          else 
            t14 <=1'b1;
       end
  
endmodule
 
module registers (a_bus,clock,digital_input,en_fbk_store_034,en_fbk_store_125,en_state_store_034,en_state_store_125,fbk_pwm,global_state_034,global_state_125,i_fbk_f,nssm_in,rd_en,rel_pot_en,rst,v_fbk_f,wr_en,digital_output,in_speed_lev,knock1u,knock2u,pickup_hall,relpot,r_t1,r_t2,r_t3_034,r_t3_125,r_t4_034,r_t4_125,r_tb_034,r_tb_125,r_th_034,r_th_125,r_tonh,r_tonl,r_tp,seg_speed_lev,smot_camme_en,status_reg_034,status_reg_125,test_en_034,test_en_125,trg_knock_en,turbo_speed_lev,d_bus) ; 
   wire [13-1:0] add_decoded ;  
   wire [13-1:0] add_decoded_r ;  
   wire add_test_en ;  
   wire [2-1:0] a_dig_in ;  
   wire a_dig_out ;  
   wire [2-1:0] a_fault_dec ;  
   wire [2-1:0] a_fault_dec_r ;  
  add_dec instance_add_dec(a_bus,clock,rst,add_decoded,add_decoded_r,add_test_en,a_dig_in,a_dig_out,a_fault_dec,a_fault_dec_r); 
  digital_inputs_handle instance_digital_inputs_handle(a_dig_in,clock,digital_input,fbk_pwm,nssm_in,rd_en,rst,d_bus); 
  digital_outputs_handle instance_digital_outputs_handle(a_dig_out,clock,d_bus,rst,wr_en,digital_output,in_speed_lev,knock1u,knock2u,pickup_hall,seg_speed_lev,smot_camme_en,trg_knock_en,turbo_speed_lev); 
  error_handle instance_error_handle(a_fault_dec,a_fault_dec_r,clock,en_fbk_store_034,en_fbk_store_125,en_state_store_034,en_state_store_125,global_state_034,global_state_125,i_fbk_f,rd_en,rel_pot_en,rst,v_fbk_f,wr_en,relpot,status_reg_034,status_reg_125,d_bus); 
  in_reg instance_in_reg(add_decoded,add_decoded_r,clock,rd_en,rst,wr_en,r_t1,r_t2,r_t3_034,r_t3_125,r_t4_034,r_t4_125,r_tb_034,r_tb_125,r_th_034,r_th_125,r_tonh,r_tonl,r_tp,d_bus); 
  test_en instance_test_en(add_test_en,clock,d_bus,rd_en,rst,wr_en,test_en_034,test_en_125); 
endmodule
 
module rst_inv (reset) ; 
   wire rst_neg ;  
  assign rst_neg=(~(reset)); 
  startup u0(.gsr(rst_neg)); 
endmodule
 
module sel_actuator (cur_state,t12,t14,t31,hl,t1,t2,t3) ; 
  always @(    t31 or  t12 or  t14 or  cur_state)
       begin :vhdl_sel_actuator
         case (cur_state)
          5 'b00000:
             begin 
               hl <=1'b0;
               t1 <=1'b0;
               t2 <=1'b0;
               t3 <=1'b0;
             end 
          5 'b00001:
             begin 
               hl <=1'b0;
               t1 <=1'b1;
               t2 <=1'b1;
               t3 <=t31;
             end 
          5 'b00010:
             begin 
               hl <=1'b1;
               t1 <=1'b1;
               t2 <=1'b1;
               t3 <=1'b1;
             end 
          5 'b00011:
             begin 
               hl <=1'b1;
               t1 <=1'b1;
               t2 <=1'b1;
               t3 <=1'b1;
             end 
          5 'b00100:
             begin 
               hl <=1'b1;
               t1 <=1'b1;
               t2 <=1'b1;
               t3 <=1'b0;
             end 
          5 'b00101:
             begin 
               hl <=1'b1;
               t1 <=t12;
               t2 <=1'b1;
               t3 <=1'b0;
             end 
          5 'b00110:
             begin 
               hl <=1'b0;
               t1 <=1'b0;
               t2 <=1'b0;
               t3 <=1'b0;
             end 
          5 'b00111:
             begin 
               hl <=1'b0;
               t1 <=1'b0;
               t2 <=1'b0;
               t3 <=1'b0;
             end 
          5 'b01000:
             begin 
               hl <=1'b0;
               t1 <=1'b1;
               t2 <=1'b1;
               t3 <=1'b0;
             end 
          5 'b01001:
             begin 
               hl <=1'b0;
               t1 <=t14;
               t2 <=1'b1;
               t3 <=1'b0;
             end 
          5 'b01010:
             begin 
               hl <=1'b0;
               t1 <=1'b0;
               t2 <=1'b0;
               t3 <=1'b0;
             end 
          5 'b01011:
             begin 
               hl <=1'b0;
               t1 <=1'b0;
               t2 <=1'b0;
               t3 <=1'b0;
             end 
          5 'b01100:
             begin 
               hl <=1'b0;
               t1 <=1'b0;
               t2 <=1'b0;
               t3 <=1'b0;
             end 
          5 'b01101:
             begin 
               hl <=1'b0;
               t1 <=1'b0;
               t2 <=1'b0;
               t3 <=1'b0;
             end 
          5 'b01110:
             begin 
               hl <=1'b0;
               t1 <=1'b1;
               t2 <=1'b1;
               t3 <=1'b0;
             end 
          5 'b01111:
             begin 
               hl <=1'b0;
               t1 <=1'b1;
               t2 <=1'b1;
               t3 <=1'b0;
             end 
          5 'b11000:
             begin 
               hl <=1'b0;
               t1 <=1'b1;
               t2 <=1'b1;
               t3 <=1'b0;
             end 
          5 'b11001:
             begin 
               hl <=1'b0;
               t1 <=t14;
               t2 <=1'b1;
               t3 <=1'b0;
             end 
          5 'b11100:
             begin 
               hl <=1'b0;
               t1 <=1'b0;
               t2 <=1'b0;
               t3 <=1'b0;
             end 
          5 'b11101:
             begin 
               hl <=1'b0;
               t1 <=1'b0;
               t2 <=1'b0;
               t3 <=1'b0;
             end 
          default :
             begin 
               hl <=1'b0;
               t1 <=1'b0;
               t2 <=1'b0;
               t3 <=1'b0;
             end 
         endcase 
       end
  
endmodule
 
module sel_chop_control (cs42,cs44,cur_state,cs4) ; 
  always @(   cs42 or  cs44 or  cur_state)
       begin :vhdl_sel_chop_control
         case (cur_state)
          5 'b00101:
             cs4 <=cs42;
          5 'b01001:
             cs4 <=cs44;
          5 'b11001:
             cs4 <=cs44;
          default :
             cs4 <=1'b1;
         endcase 
       end
  
endmodule
 
module sel_cmd (clock,cs2,inj_cmd,rst,test_en,v_fbk,cmd_stored,test_en_cur,v_fbk_cur,v_fbk_mask) ; 
   reg [2:0] cmd_stored_int ;  
  always @(  posedge clock or  negedge rst)
       begin :vhdl_sel_cmd
         if (rst==1'b0)
            cmd_stored_int <=3'b000;
          else 
            begin 
              if (cs2==1'b1)
                 cmd_stored_int <=inj_cmd;
            end 
       end
  
  always @(   v_fbk or  cmd_stored_int or  test_en)
       case (cmd_stored_int)
        3 'b001:
           begin 
             v_fbk_cur <=v_fbk[0];
             test_en_cur <=test_en[0];
           end 
        3 'b010:
           begin 
             v_fbk_cur <=v_fbk[1];
             test_en_cur <=test_en[1];
           end 
        3 'b100:
           begin 
             v_fbk_cur <=v_fbk[2];
             test_en_cur <=test_en[2];
           end 
        default :
           begin 
             v_fbk_cur <=1'b0;
             test_en_cur <=1'b1;
           end 
       endcase
  
  assign v_fbk_mask[0]=v_fbk[0]&test_en[0]; 
  assign v_fbk_mask[1]=v_fbk[1]&test_en[1]; 
  assign v_fbk_mask[2]=v_fbk[2]&test_en[2]; 
  assign cmd_stored=cmd_stored_int; 
endmodule
 
module sel_glob_count_cs (cs11,cs111,cur_state,global1_state,cs1,cs2,cs8) ; 
  always @(    cs11 or  cs111 or  cur_state or  global1_state)
       begin :vhdl_sel_glob_count_cs
         if (cur_state==5'b00001)
            begin 
              cs1 <=cs111;
              if (global1_state==1'b0)
                 cs2 <=1'b1;
               else 
                 cs2 <=1'b0;
              cs8 <=1'b0;
            end 
          else 
            if (cur_state==5'b00000)
               begin 
                 cs1 <=cs11;
                 cs2 <=1'b1;
                 cs8 <=1'b1;
               end 
             else 
               begin 
                 cs1 <=cs11;
                 cs2 <=1'b0;
                 cs8 <=1'b1;
               end 
       end
  
endmodule
 
module sel_global_state (cur_state,global1_state,global2_state,global4_state,global_state) ; 
  always @(    cur_state or  global1_state or  global2_state or  global4_state)
       begin 
         global_state [6:2]<=cur_state;
         case (cur_state)
          5 'b00001:
             global_state [1:0]<={1'b0,global1_state};
          5 'b00101:
             global_state [1:0]<=global2_state;
          5 'b01001:
             global_state [1:0]<=global4_state;
          5 'b11001:
             global_state [1:0]<=global4_state;
          default :
             global_state [1:0]<=2'b00;
         endcase 
       end
  
endmodule
 
module smot_camme_mux (in_speed,pickup_hall,seg_speed_hall,seg_speed_pickup,smot_camme_en,cam_smot) ; 
  always @(     seg_speed_pickup or  seg_speed_hall or  pickup_hall or  in_speed or  smot_camme_en)
       begin :vhdl_smot_camme_mux
         if (smot_camme_en==1'b0)
            cam_smot <=in_speed;
          else 
            if (pickup_hall==1'b1)
               cam_smot <=seg_speed_pickup;
             else 
               cam_smot <=seg_speed_hall;
       end
  
endmodule
 
module smot_knock_handle (clock,in_speed,pickup_hall,rst,seg_speed_hall,seg_speed_pickup,smot_camme_en,trg_knock1,trg_knock2,trg_knock_en,cam_smot,knock1,knock2,smot60) ; 
   wire internal_trg_knock1 ;  
  knock_detection_fsm1 instance_knock_detection_fsm1(clock,internal_trg_knock1,rst,knock1); 
  knock_detection_fsm2 instance_knock_detection_fsm2(clock,rst,trg_knock2,knock2); 
  smot_camme_mux instance_smot_camme_mux(in_speed,pickup_hall,seg_speed_hall,seg_speed_pickup,smot_camme_en,cam_smot); 
  trg_knock1_handle instance_trg_knock1_handle(in_speed,trg_knock1,trg_knock_en,internal_trg_knock1,smot60); 
endmodule
 
module split (clock,rst,inj_cmd,i_fbk_f,v_fbk_f,inj_cmd_034,inj_cmd_125,i_fbk_034,i_fbk_125,v_fbk_034,v_fbk_125) ; 
   reg [5:0] inj_cmd_int ;  
  always @(  posedge clock or  negedge rst)
       if (rst==1'b0)
          inj_cmd_int <={6{1'b0}};
        else 
          inj_cmd_int <=inj_cmd;
 
  always @(   i_fbk_f or  inj_cmd_int or  v_fbk_f)
       begin :vhdl_split
         i_fbk_034 <=i_fbk_f[0];
         i_fbk_125 <=i_fbk_f[1];
         inj_cmd_034 [0]<=inj_cmd_int[0];
         inj_cmd_034 [1]<=inj_cmd_int[3];
         inj_cmd_034 [2]<=inj_cmd_int[4];
         inj_cmd_125 [0]<=inj_cmd_int[1];
         inj_cmd_125 [1]<=inj_cmd_int[2];
         inj_cmd_125 [2]<=inj_cmd_int[5];
         v_fbk_034 [0]<=v_fbk_f[0];
         v_fbk_034 [1]<=v_fbk_f[3];
         v_fbk_034 [2]<=v_fbk_f[4];
         v_fbk_125 [0]<=v_fbk_f[1];
         v_fbk_125 [1]<=v_fbk_f[2];
         v_fbk_125 [2]<=v_fbk_f[5];
       end
  
endmodule
 
module startup (gsr) ; 
endmodule
 
module state_progression (clock,cmd_stored,comp,enable_check,end_t0,global_state,inj_cmd,i_fbk,rst,sh_mode,status_reg,t4_0,th_0,v_fbk_cur,v_fbk_mask,cur_state) ; 
 parameter[4:0] state_progression_state_type_start_state =0,state_progression_state_type_ph1bis_state=1,state_progression_state_type_ph2_state=2,state_progression_state_type_ph3_state=3,state_progression_state_type_ph4_state=4,state_progression_state_type_ph5_state=5,state_progression_state_type_ph1_state=6,state_progression_state_type_cc_vcc_state=7,state_progression_state_type_cc_gnd_state=8,state_progression_state_type_int1_state=9,state_progression_state_type_int_2_state=10,state_progression_state_type_int3_state=11,state_progression_state_type_int4_state=12,state_progression_state_type_int5_state=13,state_progression_state_type_int6_state=14,state_progression_state_type_ph6_state=15,state_progression_state_type_int7_state=16,state_progression_state_type_ph7_state=17,state_progression_state_type_int8_state=18,state_progression_state_type_ph8_state=19,state_progression_state_type_int9_state=20,state_progression_state_type_ph9_state=21; 
   reg [4:0] current_state ;  
   reg [4:0] next_state ;  
  always @(               posedge clock or  cmd_stored or  comp or  enable_check or  end_t0 or  global_state or  inj_cmd or  i_fbk or  negedge rst or  sh_mode or  status_reg or  t4_0 or  th_0 or  v_fbk_cur or  v_fbk_mask)
       begin :clocked
         if (rst==1'b0)
            begin 
              current_state <=state_progression_state_type_start_state;
              cur_state <=5'b00000;
            end 
          else 
            begin 
              current_state <=next_state;
              case (next_state)
               state_progression_state_type_start_state :
                  cur_state <=5'b00000;
               state_progression_state_type_ph1bis_state :
                  cur_state <=5'b00011;
               state_progression_state_type_ph2_state :
                  cur_state <=5'b00101;
               state_progression_state_type_ph3_state :
                  cur_state <=5'b00111;
               state_progression_state_type_ph4_state :
                  cur_state <=5'b01001;
               state_progression_state_type_ph5_state :
                  cur_state <=5'b01011;
               state_progression_state_type_ph1_state :
                  cur_state <=5'b00001;
               state_progression_state_type_cc_vcc_state :
                  cur_state <=5'b11100;
               state_progression_state_type_cc_gnd_state :
                  cur_state <=5'b11101;
               state_progression_state_type_int1_state :
                  cur_state <=5'b00010;
               state_progression_state_type_int_2_state :
                  cur_state <=5'b00100;
               state_progression_state_type_int3_state :
                  cur_state <=5'b00110;
               state_progression_state_type_int4_state :
                  cur_state <=5'b01000;
               state_progression_state_type_int5_state :
                  cur_state <=5'b01010;
               state_progression_state_type_int6_state :
                  cur_state <=5'b01100;
               state_progression_state_type_ph6_state :
                  cur_state <=5'b01101;
               state_progression_state_type_int7_state :
                  cur_state <=5'b01110;
               state_progression_state_type_ph7_state :
                  cur_state <=5'b01111;
               state_progression_state_type_int8_state :
                  cur_state <=5'b11000;
               state_progression_state_type_ph8_state :
                  cur_state <=5'b11001;
               state_progression_state_type_int9_state :
                  cur_state <=5'b01010;
               state_progression_state_type_ph9_state :
                  cur_state <=5'b01011;
               default :;
              endcase 
            end 
       end
  
  always @(                current_state or  clock or  cmd_stored or  comp or  enable_check or  end_t0 or  global_state or  inj_cmd or  i_fbk or  rst or  sh_mode or  status_reg or  t4_0 or  th_0 or  v_fbk_cur or  v_fbk_mask)
       begin :set_next_state
         next_state <=current_state;
         case (current_state)
          state_progression_state_type_start_state :
             if (inj_cmd!=3'b000&v_fbk_mask==3'b000)
                next_state <=state_progression_state_type_ph1_state;
              else 
                if (inj_cmd!=3'b000&v_fbk_mask!=3'b000&enable_check==1'b0)
                   next_state <=state_progression_state_type_ph1_state;
                 else 
                   if (inj_cmd!=3'b000&v_fbk_mask!=3'b000&enable_check==1'b1)
                      next_state <=state_progression_state_type_cc_gnd_state;
          state_progression_state_type_ph1bis_state :
             if (comp==1'b1&v_fbk_cur==1'b1)
                next_state <=state_progression_state_type_int_2_state;
              else 
                if (v_fbk_cur==1'b0&enable_check==1'b1)
                   next_state <=state_progression_state_type_cc_gnd_state;
                 else 
                   if (comp==1'b1&v_fbk_cur==1'b0&enable_check==1'b0)
                      next_state <=state_progression_state_type_int_2_state;
          state_progression_state_type_ph2_state :
             if (comp==1'b1&((v_fbk_cur==1'b0&global_state[1:0]==2'b11)|(global_state[1:0]==2'b10)|(global_state[1:0]==2'b01&v_fbk_cur==1'b1)|(global_state[1:0]==2'b00)))
                next_state <=state_progression_state_type_int3_state;
              else 
                if (global_state[1:0]==2'b01&v_fbk_cur==1'b0&enable_check==1'b1)
                   next_state <=state_progression_state_type_cc_gnd_state;
                 else 
                   if (global_state[1:0]==2'b11&v_fbk_cur==1'b1&enable_check==1'b1)
                      next_state <=state_progression_state_type_cc_vcc_state;
                    else 
                      if (comp==1'b1&((v_fbk_cur==1'b1&global_state[1:0]==2'b11)|(global_state[1:0]==2'b10)|(global_state[1:0]==2'b01&v_fbk_cur==1'b0)|(global_state[1:0]==2'b00))&enable_check==1'b0)
                         next_state <=state_progression_state_type_int3_state;
          state_progression_state_type_ph3_state :
             if (v_fbk_cur==1'b0&comp==1'b1&th_0==1'b0)
                next_state <=state_progression_state_type_int4_state;
              else 
                if (v_fbk_cur==1'b1&enable_check==1'b1)
                   next_state <=state_progression_state_type_cc_vcc_state;
                 else 
                   if (v_fbk_cur==1'b0&th_0==1'b1&comp==1'b1)
                      next_state <=state_progression_state_type_int5_state;
                    else 
                      if (v_fbk_cur==1'b1&comp==1'b1&th_0==1'b0&enable_check==1'b0)
                         next_state <=state_progression_state_type_int4_state;
                       else 
                         if (v_fbk_cur==1'b1&th_0==1'b1&comp==1'b1&enable_check==1'b0)
                            next_state <=state_progression_state_type_int5_state;
          state_progression_state_type_ph4_state :
             if (comp==1'b1&((v_fbk_cur==1'b0&global_state[1:0]==2'b11)|(global_state[1:0]==2'b10)|(global_state[1:0]==2'b01&v_fbk_cur==1'b1)|(global_state[1:0]==2'b00)))
                next_state <=state_progression_state_type_int5_state;
              else 
                if (global_state[1:0]==2'b11&v_fbk_cur==1'b1&enable_check==1'b1)
                   next_state <=state_progression_state_type_cc_vcc_state;
                 else 
                   if (global_state[1:0]==2'b01&v_fbk_cur==1'b0&enable_check==1'b1)
                      next_state <=state_progression_state_type_cc_gnd_state;
                    else 
                      if (comp==1'b1&((v_fbk_cur==1'b1&global_state[1:0]==2'b11)|(global_state[1:0]==2'b10)|(global_state[1:0]==2'b01&v_fbk_cur==1'b0)|(global_state[1:0]==2'b00))&enable_check==1'b0)
                         next_state <=state_progression_state_type_int5_state;
          state_progression_state_type_ph5_state :
             if (comp==1'b1&t4_0==1'b1)
                next_state <=state_progression_state_type_start_state;
              else 
                if (comp==1'b1&t4_0==1'b0)
                   next_state <=state_progression_state_type_int6_state;
          state_progression_state_type_ph1_state :
             if (comp==1'b1&v_fbk_cur==1'b1&((i_fbk==1'b1&sh_mode==1'b1)|(sh_mode==1'b0)))
                next_state <=state_progression_state_type_int1_state;
              else 
                if (v_fbk_cur==1'b0&enable_check==1'b1)
                   next_state <=state_progression_state_type_cc_gnd_state;
                 else 
                   if (global_state[0]==1'b1&comp==1'b1&v_fbk_cur==1'b1&i_fbk==1'b0&sh_mode==1'b1&enable_check==1'b1)
                      next_state <=state_progression_state_type_cc_gnd_state;
                    else 
                      if (inj_cmd!=cmd_stored&global_state[0]==1'b0)
                         next_state <=state_progression_state_type_start_state;
                       else 
                         if (comp==1'b1&(v_fbk_cur==1'b0|((i_fbk==1'b0&sh_mode==1'b1)|(sh_mode==1'b0)))&enable_check==1'b0)
                            next_state <=state_progression_state_type_int1_state;
          state_progression_state_type_cc_vcc_state :
             if (status_reg==11'b00000000000)
                next_state <=state_progression_state_type_start_state;
          state_progression_state_type_cc_gnd_state :
             if (status_reg==11'b00000000000)
                next_state <=state_progression_state_type_start_state;
          state_progression_state_type_int1_state :
             if (1'b1)
                next_state <=state_progression_state_type_ph1bis_state;
          state_progression_state_type_int_2_state :
             if (1'b1)
                next_state <=state_progression_state_type_ph2_state;
          state_progression_state_type_int3_state :
             if (1'b1)
                next_state <=state_progression_state_type_ph3_state;
          state_progression_state_type_int4_state :
             if (1'b1)
                next_state <=state_progression_state_type_ph4_state;
          state_progression_state_type_int5_state :
             if (1'b1)
                next_state <=state_progression_state_type_ph5_state;
          state_progression_state_type_int6_state :
             if (1'b1)
                next_state <=state_progression_state_type_ph6_state;
          state_progression_state_type_ph6_state :
             if (comp==1'b1)
                next_state <=state_progression_state_type_int7_state;
          state_progression_state_type_int7_state :
             if (1'b1)
                next_state <=state_progression_state_type_ph7_state;
          state_progression_state_type_ph7_state :
             if (comp==1'b1&v_fbk_cur==1'b0&enable_check==1'b0)
                next_state <=state_progression_state_type_int8_state;
              else 
                if (comp==1'b1&v_fbk_cur==1'b1)
                   next_state <=state_progression_state_type_int8_state;
                 else 
                   if (v_fbk_cur==1'b0&enable_check==1'b1)
                      next_state <=state_progression_state_type_cc_gnd_state;
          state_progression_state_type_int8_state :
             if (1'b1)
                next_state <=state_progression_state_type_ph8_state;
          state_progression_state_type_ph8_state :
             if (comp==1'b1&((v_fbk_cur==1'b1&global_state[1:0]==2'b11)|(global_state[1:0]==2'b10)|(global_state[1:0]==2'b01&v_fbk_cur==1'b0)|(global_state[1:0]==2'b00))&enable_check==1'b0)
                next_state <=state_progression_state_type_int9_state;
              else 
                if (comp==1'b1&((v_fbk_cur==1'b0&global_state[1:0]==2'b11)|(global_state[1:0]==2'b10)|(global_state[1:0]==2'b01&v_fbk_cur==1'b1)|(global_state[1:0]==2'b00)))
                   next_state <=state_progression_state_type_int9_state;
                 else 
                   if (global_state[1:0]==2'b11&v_fbk_cur==1'b1&enable_check==1'b1)
                      next_state <=state_progression_state_type_cc_vcc_state;
                    else 
                      if (global_state[1:0]==2'b01&v_fbk_cur==1'b0&enable_check==1'b1)
                         next_state <=state_progression_state_type_cc_gnd_state;
          state_progression_state_type_int9_state :
             if (1'b1)
                next_state <=state_progression_state_type_ph9_state;
          state_progression_state_type_ph9_state :
             if (comp==1'b1)
                next_state <=state_progression_state_type_start_state;
          default :;
         endcase 
       end
  
endmodule
 
module test_en (add_test_en,clock,d_bus,rd_en,rst,wr_en,test_en_034,test_en_125) ; 
  always @(  posedge clock or  negedge rst)
       begin :vhdl_test_en
         if (rst==1'b0)
            begin 
              test_en_034 <={3{1'b0}};
              test_en_125 <={3{1'b0}};
            end 
          else 
            begin 
              if (add_test_en==1'b1&wr_en==1'b1)
                 begin 
                   test_en_034 [0]<=d_bus[0];
                   test_en_034 [1]<=d_bus[3];
                   test_en_034 [2]<=d_bus[4];
                   test_en_125 [0]<=d_bus[1];
                   test_en_125 [1]<=d_bus[2];
                   test_en_125 [2]<=d_bus[5];
                 end 
            end 
       end
  
endmodule
 
module trg_knock1_handle (in_speed,trg_knock1,trg_knock_en,internal_trg_knock1,smot60) ; 
  always @(   in_speed or  trg_knock1 or  trg_knock_en)
       begin :vhdl_trg_knock1_handle
         if (trg_knock_en==1'b0)
            begin 
              smot60 <=in_speed|trg_knock1;
              internal_trg_knock1 <=1'b0;
            end 
          else 
            begin 
              smot60 <=in_speed;
              internal_trg_knock1 <=trg_knock1;
            end 
       end
  
endmodule
 
module turbo_vehicle_speed (rpm_in,turbo_speed,vehicle_speed,rpm_out,turbo,vehicle) ; 
  assign turbo=turbo_speed; 
  assign vehicle=vehicle_speed; 
  assign rpm_out=rpm_in; 
endmodule
 
