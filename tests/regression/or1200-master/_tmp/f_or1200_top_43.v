module or1200_mem2reg #(
 parameter width =32) (
  input [1:0] addr,
  input [4-1:0] lsu_op,
  input [width-1:0] memdata,
  output reg  [width-1:0] regdata) ; 
    
   reg [width-1:0] aligned ;  
  always @(  addr or  memdata)
       begin 
         case (addr)
          2 'b00:
             aligned =memdata;
          2 'b01:
             aligned ={memdata[23:0],8'b0};
          2 'b10:
             aligned ={memdata[15:0],16'b0};
          2 'b11:
             aligned ={memdata[7:0],24'b0};
         endcase 
       end
  
  always @(  lsu_op or  aligned)
       begin 
         case (lsu_op)
          4 'b0010:
             begin 
               regdata [7:0]=aligned[31:24];
               regdata [31:8]=24'b0;
             end 
          4 'b0011:
             begin 
               regdata [7:0]=aligned[31:24];
               regdata [31:8]={24{aligned[31]}};
             end 
          4 'b0100:
             begin 
               regdata [15:0]=aligned[31:16];
               regdata [31:16]=16'b0;
             end 
          4 'b0101:
             begin 
               regdata [15:0]=aligned[31:16];
               regdata [31:16]={16{aligned[31]}};
             end 
          default :
             regdata =aligned;
         endcase 
       end
  
endmodule
 
module or1200_if (
  input clk,
  input rst,
  input [31:0] icpu_dat_i,
  input icpu_ack_i,
  input icpu_err_i,
  input [31:0] icpu_adr_i,
  input [3:0] icpu_tag_i,
  input if_freeze,
  output [31:0] if_insn,
  output [31:0] if_pc,
  input if_flushpipe,
  output saving_if_insn,
  output if_stall,
  input no_more_dslot,
  output genpc_refetch,
  input rfe,
  output except_itlbmiss,
  output except_immufault,
  output except_ibuserr) ; 
   wire save_insn ;  
   wire if_bypass ;  
   reg if_bypass_reg ;  
   reg [31:0] insn_saved ;  
   reg [31:0] addr_saved ;  
   reg [2:0] err_saved ;  
   reg saved ;  
  assign save_insn=(icpu_ack_i|icpu_err_i)&if_freeze&!saved; 
  assign saving_if_insn=!if_flushpipe&save_insn; 
  assign if_bypass=icpu_adr_i[0] ? 1'b0:if_bypass_reg|if_flushpipe; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          if_bypass_reg <=1'b0;
        else 
          if_bypass_reg <=if_bypass;
 
  assign if_insn=no_more_dslot|rfe|if_bypass ? {6'b000101,26'h041_0000}:saved ? insn_saved:icpu_ack_i ? icpu_dat_i:{6'b000101,26'h061_0000}; 
  assign if_pc=saved ? addr_saved:{icpu_adr_i[31:2],2'h0}; 
  assign if_stall=!icpu_err_i&!icpu_ack_i&!saved; 
  assign genpc_refetch=saved&icpu_ack_i; 
  assign except_itlbmiss=no_more_dslot ? 1'b0:saved ? err_saved[0]:icpu_err_i&(icpu_tag_i==4'hd); 
  assign except_immufault=no_more_dslot ? 1'b0:saved ? err_saved[1]:icpu_err_i&(icpu_tag_i==4'hc); 
  assign except_ibuserr=no_more_dslot ? 1'b0:saved ? err_saved[2]:icpu_err_i&(icpu_tag_i==4'hb); 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          saved <=1'b0;
        else 
          if (if_flushpipe)
             saved <=1'b0;
           else 
             if (save_insn)
                saved <=1'b1;
              else 
                if (!if_freeze)
                   saved <=1'b0;
 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          insn_saved <={6'b000101,26'h041_0000};
        else 
          if (if_flushpipe)
             insn_saved <={6'b000101,26'h041_0000};
           else 
             if (save_insn)
                insn_saved <=icpu_err_i ? {6'b000101,26'h041_0000}:icpu_dat_i;
              else 
                if (!if_freeze)
                   insn_saved <={6'b000101,26'h041_0000};
 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_saved <=32'h00000000;
        else 
          if (if_flushpipe)
             addr_saved <=32'h00000000;
           else 
             if (save_insn)
                addr_saved <={icpu_adr_i[31:2],2'b00};
              else 
                if (!if_freeze)
                   addr_saved <={icpu_adr_i[31:2],2'b00};
 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          err_saved <=3'b000;
        else 
          if (if_flushpipe)
             err_saved <=3'b000;
           else 
             if (save_insn)
                begin 
                  err_saved [0]<=icpu_err_i&(icpu_tag_i==4'hd);
                  err_saved [1]<=icpu_err_i&(icpu_tag_i==4'hc);
                  err_saved [2]<=icpu_err_i&(icpu_tag_i==4'hb);
                end 
              else 
                if (!if_freeze)
                   err_saved <=3'b000;
 
endmodule
 
module or1200_spram_1024x8 #(
 parameter aw =10,
 parameter dw =8) (
  input clk,
  input rst,
  input ce,
  input we,
  input oe,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq=(oe) ? mem[addr_reg]:{dw{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <={aw{1'b0}};
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we)
          mem [addr]<=di;
 
endmodule
 
module or1200_dc_fsm (
  input clk,
  input rst,
  input dc_en,
  input dcqmem_cycstb_i,
  input dcqmem_ci_i,
  input dcqmem_we_i,
  input [3:0] dcqmem_sel_i,
  input tagcomp_miss,
  input biudata_valid,
  input biudata_error,
  input [31:0] lsu_addr,
  output [3:0] dcram_we,
  output biu_read,
  output biu_write,
  output biu_do_sel,
  output dcram_di_sel,
  output first_hit_ack,
  output first_miss_ack,
  output first_miss_err,
  output burst,
  output tag_we,
  output tag_valid,
  output [31:0] dc_addr,
  input dc_no_writethrough,
  output tag_dirty,
  input dirty,
  input [20-2:0] tag,
  input tag_v,
  input dc_block_flush,
  input dc_block_writeback,
  input [31:0] spr_dat_i,
  output mtspr_dc_done,
  input spr_cswe) ; 
   reg [31:0] addr_r ;  
   reg [2:0] state ;  
   reg [4-1:0] cnt ;  
   reg hitmiss_eval ;  
   reg store ;  
   reg load ;  
   reg cache_inhibit ;  
   reg cache_miss ;  
   reg cache_dirty_needs_writeback ;  
   reg did_early_load_ack ;  
   reg cache_spr_block_flush ;  
   reg cache_spr_block_writeback ;  
   reg cache_wb ;  
   wire load_hit_ack ;  
   wire load_miss_ack ;  
   wire load_inhibit_ack ;  
   wire store_hit_ack ;  
   wire store_hit_writethrough_ack ;  
   wire store_miss_writethrough_ack ;  
   wire store_inhibit_ack ;  
   wire store_miss_ack ;  
   wire dcram_we_after_line_load ;  
   wire dcram_we_during_line_load ;  
   wire tagram_we_end_of_loadstore_loop ;  
   wire tagram_dirty_bit_set ;  
   wire writethrough ;  
   wire cache_inhibit_with_eval ;  
   wire [(4-1)-2:0] next_addr_word ;  
  assign cache_inhibit_with_eval=(hitmiss_eval&dcqmem_ci_i)|(!hitmiss_eval&cache_inhibit); 
  assign dcram_we_after_line_load=(state==3'd3)&dcqmem_we_i&!cache_dirty_needs_writeback&!did_early_load_ack; 
  assign dcram_we_during_line_load=(state==3'd2)&load&biudata_valid; 
  assign dcram_we=(({4{store_hit_ack|store_hit_writethrough_ack}}|{4{dcram_we_after_line_load}})&dcqmem_sel_i)|{4{dcram_we_during_line_load}}; 
  assign tagram_we_end_of_loadstore_loop=((state==3'd2)&biudata_valid&!(|cnt)); 
  assign tagram_dirty_bit_set=0; 
  assign mtspr_dc_done=1'b1; 
  assign tag_dirty=tagram_dirty_bit_set; 
  assign tag_we=tagram_we_end_of_loadstore_loop|tagram_dirty_bit_set|(state==3'd6); 
  assign tag_valid=(tagram_we_end_of_loadstore_loop&(load|(store&cache_spr_block_writeback)))|tagram_dirty_bit_set; 
  assign biu_read=((state==3'd1)&(((hitmiss_eval&tagcomp_miss&!dirty&!(store&writethrough))|(load&cache_inhibit_with_eval))&dcqmem_cycstb_i))|((state==3'd2)&load); 
  assign biu_write=((state==3'd1)&(((hitmiss_eval&tagcomp_miss&dirty)|(store&writethrough))|(store&cache_inhibit_with_eval))&dcqmem_cycstb_i)|((state==3'd2)&store); 
  assign dcram_di_sel=load; 
  assign biu_do_sel=(state==3'd2)&store; 
  assign next_addr_word=addr_r[4-1:2]+1; 
  assign dc_addr=((dc_block_flush&!cache_spr_block_flush)|(dc_block_writeback&!cache_spr_block_writeback)) ? spr_dat_i:(state==3'd5) ? addr_r:(state==3'd0|hitmiss_eval) ? lsu_addr:(state==3'd2&biudata_valid&store) ? {addr_r[31:4],next_addr_word,2'b00}:addr_r; 
  assign writethrough=1; 
  assign first_hit_ack=load_hit_ack|store_hit_ack|store_hit_writethrough_ack|store_miss_writethrough_ack|store_inhibit_ack|store_miss_ack; 
  assign first_miss_ack=~first_hit_ack&(load_miss_ack|load_inhibit_ack); 
  assign load_hit_ack=(state==3'd1)&hitmiss_eval&!tagcomp_miss&!dcqmem_ci_i&load; 
  assign store_hit_ack=(state==3'd1)&hitmiss_eval&!tagcomp_miss&!dcqmem_ci_i&store&!writethrough; 
  assign store_hit_writethrough_ack=(state==3'd1)&!cache_miss&!cache_inhibit&store&writethrough&biudata_valid; 
  assign store_miss_writethrough_ack=(state==3'd1)&cache_miss&!cache_inhibit&store&writethrough&biudata_valid; 
  assign store_inhibit_ack=(state==3'd1)&store&cache_inhibit&biudata_valid; 
  assign load_miss_ack=((state==3'd2)&load&(cnt==((1<<4)-4))&biudata_valid&!(dcqmem_we_i&!writethrough)); 
  assign load_inhibit_ack=(state==3'd1)&load&cache_inhibit&biudata_valid; 
  assign store_miss_ack=dcram_we_after_line_load; 
  assign first_miss_err=biudata_error&dcqmem_cycstb_i; 
  assign burst=(state==3'd2); 
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              state <=3'd0;
              addr_r <=32'd0;
              hitmiss_eval <=1'b0;
              store <=1'b0;
              load <=1'b0;
              cnt <=4'd0;
              cache_miss <=1'b0;
              cache_dirty_needs_writeback <=1'b0;
              cache_inhibit <=1'b0;
              did_early_load_ack <=1'b0;
              cache_spr_block_flush <=1'b0;
              cache_spr_block_writeback <=1'b0;
            end 
          else 
            case (state)
             3 'd0:
                begin 
                  if (dc_en&(dc_block_flush|dc_block_writeback))
                     begin 
                       cache_spr_block_flush <=dc_block_flush;
                       cache_spr_block_writeback <=dc_block_writeback;
                       hitmiss_eval <=1'b1;
                       state <=3'd5;
                       addr_r <=spr_dat_i;
                     end 
                   else 
                     if (dc_en&dcqmem_cycstb_i)
                        begin 
                          state <=3'd1;
                          hitmiss_eval <=1'b1;
                          store <=dcqmem_we_i;
                          load <=!dcqmem_we_i;
                        end 
                end 
             3 'd1:
                begin 
                  hitmiss_eval <=1'b0;
                  if (hitmiss_eval)
                     begin 
                       cache_inhibit <=dcqmem_ci_i;
                       cache_miss <=tagcomp_miss;
                       cache_dirty_needs_writeback <=dirty;
                       addr_r <=lsu_addr;
                     end 
                  if (hitmiss_eval&tagcomp_miss&!(store&writethrough)&!dcqmem_ci_i)
                     begin 
                       if (dirty)
                          begin 
                            addr_r <={tag,lsu_addr[13-1:2],2'd0};
                            load <=1'b0;
                            store <=1'b1;
                          end 
                        else 
                          begin 
                            addr_r <=lsu_addr;
                            load <=1'b1;
                            store <=1'b0;
                          end 
                       state <=3'd2;
                       cnt <=((1<<4)-4);
                     end 
                   else 
                     if (!dcqmem_cycstb_i|(!hitmiss_eval&(biudata_valid|biudata_error))|(hitmiss_eval&!tagcomp_miss&!dcqmem_ci_i&!(store&writethrough)))
                        begin 
                          state <=3'd0;
                          load <=1'b0;
                          store <=1'b0;
                          cache_inhibit <=1'b0;
                          cache_dirty_needs_writeback <=1'b0;
                        end 
                end 
             3 'd2:
                begin 
                  if (!dc_en|biudata_error)
                     begin 
                       state <=3'd0;
                       load <=1'b0;
                       store <=1'b0;
                       cnt <=4'd0;
                     end 
                  if (biudata_valid&(|cnt))
                     begin 
                       cnt <=cnt-4;
                       addr_r [4-1:2]<=addr_r[4-1:2]+1;
                     end 
                   else 
                     if (biudata_valid&!(|cnt))
                        begin 
                          state <=3'd3;
                          addr_r <=lsu_addr;
                          load <=1'b0;
                          store <=1'b0;
                        end 
                  if (load_miss_ack)
                     did_early_load_ack <=1'b1;
                end 
             3 'd3:
                begin 
                  if (cache_dirty_needs_writeback)
                     begin 
                       load <=1'b1;
                       cnt <=((1<<4)-4);
                       addr_r <=lsu_addr;
                       cache_dirty_needs_writeback <=1'b0;
                       state <=3'd2;
                     end 
                   else 
                     if (cache_spr_block_flush|cache_spr_block_writeback)
                        begin 
                          cache_spr_block_flush <=1'b0;
                          cache_spr_block_writeback <=1'b0;
                          state <=3'd7;
                        end 
                      else 
                        begin 
                          did_early_load_ack <=1'b0;
                          state <=3'd4;
                        end 
                end 
             3 'd4:
                begin 
                  state <=3'd0;
                end 
             3 'd5:
                begin 
                  hitmiss_eval <=1'b0;
                  if (hitmiss_eval&!tag_v)
                     begin 
                       cache_spr_block_flush <=1'b0;
                       cache_spr_block_writeback <=1'b0;
                       state <=3'd7;
                     end 
                   else 
                     if (hitmiss_eval&tag_v)
                        begin 
                          if ((cache_spr_block_flush|cache_spr_block_writeback)&dirty)
                             begin 
                               addr_r <={tag,addr_r[13-1:2],2'd0};
                               load <=1'b0;
                               store <=1'b1;
                               state <=3'd2;
                               cnt <=((1<<4)-4);
                             end 
                           else 
                             if (cache_spr_block_flush&!dirty)
                                begin 
                                  state <=3'd6;
                                end 
                              else 
                                if (cache_spr_block_writeback&!dirty)
                                   begin 
                                     cache_spr_block_writeback <=1'b0;
                                     state <=3'd7;
                                   end 
                        end 
                end 
             3 'd6:
                begin 
                  cache_spr_block_flush <=1'b0;
                  if (!spr_cswe)
                     state <=3'd0;
                end 
             3 'd7:
                begin 
                  if (!spr_cswe)
                     state <=3'd0;
                end 
            endcase 
       end
  
endmodule
 
module or1200_dpram_256x32 #(
 parameter aw =8,
 parameter dw =32) (
  input clk_a,
  input rst_a,
  input ce_a,
  input oe_a,
  input [aw-1:0] addr_a,
  output [dw-1:0] do_a,
  input clk_b,
  input rst_b,
  input ce_b,
  input we_b,
  input [aw-1:0] addr_b,
  input [dw-1:0] di_b) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_a_reg ;  
  assign do_a=(oe_a) ? mem[addr_a_reg]:{dw{1'b0}}; 
  always @(  posedge clk_a or  posedge rst_a)
       if (rst_a==(1'b1))
          addr_a_reg <={aw{1'b0}};
        else 
          if (ce_a)
             addr_a_reg <=addr_a;
 
  always @( posedge clk_b)
       if (ce_b&&we_b)
          mem [addr_b]<=di_b;
 
endmodule
 
module or1200_sprs #(
 parameter width =32) (
  input clk,
  input rst,
  input flagforw,
  input flag_we,
  output flag,
  input cyforw,
  input cy_we,
  output carry,
  input ovforw,
  input ov_we,
  input dsx,
  input [width-1:0] addrbase,
  input [15:0] addrofs,
  input [width-1:0] dat_i,
  input [3-1:0] branch_op,
  input ex_spr_read,
  input ex_spr_write,
  input [width-1:0] epcr,
  input [width-1:0] eear,
  input [17-1:0] esr,
  input except_started,
  output reg  [width-1:0] to_wbmux,
  output epcr_we,
  output eear_we,
  output esr_we,
  output pc_we,
  output sr_we,
  output [17-1:0] to_sr,
  output reg  [17-1:0] sr,
  input [31:0] spr_dat_cfgr,
  input [31:0] spr_dat_rf,
  input [31:0] spr_dat_npc,
  input [31:0] spr_dat_ppc,
  input [31:0] spr_dat_mac,
  input boot_adr_sel_i,
  input [12-1:0] fpcsr,
  output fpcsr_we,
  input [31:0] spr_dat_fpu,
  input [31:0] spr_dat_pic,
  input [31:0] spr_dat_tt,
  input [31:0] spr_dat_pm,
  input [31:0] spr_dat_dmmu,
  input [31:0] spr_dat_immu,
  input [31:0] spr_dat_du,
  output [31:0] spr_addr,
  output [31:0] spr_dat_o,
  output [31:0] spr_cs,
  output spr_we,
  input [width-1:0] du_addr,
  input [width-1:0] du_dat_du,
  input du_read,
  input du_write,
  output [width-1:0] du_dat_cpu) ; 
    
   reg [17-1:0] sr_reg ;  
   reg sr_reg_bit_eph ;  
   reg sr_reg_bit_eph_select ;  
   wire sr_reg_bit_eph_muxed ;  
   wire cfgr_sel ;  
   wire rf_sel ;  
   wire npc_sel ;  
   wire ppc_sel ;  
   wire sr_sel ;  
   wire epcr_sel ;  
   wire eear_sel ;  
   wire esr_sel ;  
   wire fpcsr_sel ;  
   wire [31:0] sys_data ;  
   wire du_access ;  
   reg [31:0] unqualified_cs ;  
  assign du_access=du_read|du_write; 
  assign spr_addr=du_access ? du_addr:(addrbase|{16'h0000,addrofs}); 
  assign spr_dat_o=du_write ? du_dat_du:dat_i; 
  assign du_dat_cpu=du_read ? to_wbmux:du_write ? du_dat_du:dat_i; 
  assign spr_we=du_write|(ex_spr_write&!du_access); 
  assign spr_cs=unqualified_cs&{32{du_read|du_write|ex_spr_read|(ex_spr_write&sr[0])}}; 
  always @( spr_addr)
       case (spr_addr[15:11])
        5 'd00:
           unqualified_cs =32'b00000000_00000000_00000000_00000001;
        5 'd01:
           unqualified_cs =32'b00000000_00000000_00000000_00000010;
        5 'd02:
           unqualified_cs =32'b00000000_00000000_00000000_00000100;
        5 'd03:
           unqualified_cs =32'b00000000_00000000_00000000_00001000;
        5 'd04:
           unqualified_cs =32'b00000000_00000000_00000000_00010000;
        5 'd05:
           unqualified_cs =32'b00000000_00000000_00000000_00100000;
        5 'd06:
           unqualified_cs =32'b00000000_00000000_00000000_01000000;
        5 'd07:
           unqualified_cs =32'b00000000_00000000_00000000_10000000;
        5 'd08:
           unqualified_cs =32'b00000000_00000000_00000001_00000000;
        5 'd09:
           unqualified_cs =32'b00000000_00000000_00000010_00000000;
        5 'd10:
           unqualified_cs =32'b00000000_00000000_00000100_00000000;
        5 'd11:
           unqualified_cs =32'b00000000_00000000_00001000_00000000;
        5 'd12:
           unqualified_cs =32'b00000000_00000000_00010000_00000000;
        5 'd13:
           unqualified_cs =32'b00000000_00000000_00100000_00000000;
        5 'd14:
           unqualified_cs =32'b00000000_00000000_01000000_00000000;
        5 'd15:
           unqualified_cs =32'b00000000_00000000_10000000_00000000;
        5 'd16:
           unqualified_cs =32'b00000000_00000001_00000000_00000000;
        5 'd17:
           unqualified_cs =32'b00000000_00000010_00000000_00000000;
        5 'd18:
           unqualified_cs =32'b00000000_00000100_00000000_00000000;
        5 'd19:
           unqualified_cs =32'b00000000_00001000_00000000_00000000;
        5 'd20:
           unqualified_cs =32'b00000000_00010000_00000000_00000000;
        5 'd21:
           unqualified_cs =32'b00000000_00100000_00000000_00000000;
        5 'd22:
           unqualified_cs =32'b00000000_01000000_00000000_00000000;
        5 'd23:
           unqualified_cs =32'b00000000_10000000_00000000_00000000;
        5 'd24:
           unqualified_cs =32'b00000001_00000000_00000000_00000000;
        5 'd25:
           unqualified_cs =32'b00000010_00000000_00000000_00000000;
        5 'd26:
           unqualified_cs =32'b00000100_00000000_00000000_00000000;
        5 'd27:
           unqualified_cs =32'b00001000_00000000_00000000_00000000;
        5 'd28:
           unqualified_cs =32'b00010000_00000000_00000000_00000000;
        5 'd29:
           unqualified_cs =32'b00100000_00000000_00000000_00000000;
        5 'd30:
           unqualified_cs =32'b01000000_00000000_00000000_00000000;
        5 'd31:
           unqualified_cs =32'b10000000_00000000_00000000_00000000;
       endcase
  
  assign to_sr[15:12]=(except_started) ? {sr[15:14],dsx,1'b0}:(branch_op==3'd6) ? esr[15:12]:(spr_we&&sr_sel) ? {1'b1,spr_dat_o[15-1:12]}:sr[15:12]; 
  assign to_sr[16]=(except_started) ? 1'b1:(branch_op==3'd6) ? esr[16]:(spr_we&&sr_sel) ? spr_dat_o[16]:sr[16]; 
  assign to_sr[11]=(except_started) ? sr[11]:(branch_op==3'd6) ? esr[11]:ov_we ? ovforw:(spr_we&&sr_sel) ? spr_dat_o[11]:sr[11]; 
  assign to_sr[10]=(except_started) ? sr[10]:(branch_op==3'd6) ? esr[10]:cy_we ? cyforw:(spr_we&&sr_sel) ? spr_dat_o[10]:sr[10]; 
  assign to_sr[9]=(except_started) ? sr[9]:(branch_op==3'd6) ? esr[9]:flag_we ? flagforw:(spr_we&&sr_sel) ? spr_dat_o[9]:sr[9]; 
  assign to_sr[8:0]=(except_started) ? {sr[8:7],2'b00,sr[4:3],3'b001}:(branch_op==3'd6) ? esr[8:0]:(spr_we&&sr_sel) ? spr_dat_o[8:0]:sr[8:0]; 
  assign cfgr_sel=(spr_cs[5'd00]&&(spr_addr[10:4]==7'd0)); 
  assign rf_sel=(spr_cs[5'd00]&&(spr_addr[10:5]==6'd32)); 
  assign npc_sel=(spr_cs[5'd00]&&(spr_addr[10:0]==11'd16)); 
  assign ppc_sel=(spr_cs[5'd00]&&(spr_addr[10:0]==11'd18)); 
  assign sr_sel=(spr_cs[5'd00]&&(spr_addr[10:0]==11'd17)); 
  assign epcr_sel=(spr_cs[5'd00]&&(spr_addr[10:0]==11'd32)); 
  assign eear_sel=(spr_cs[5'd00]&&(spr_addr[10:0]==11'd48)); 
  assign esr_sel=(spr_cs[5'd00]&&(spr_addr[10:0]==11'd64)); 
  assign fpcsr_sel=(spr_cs[5'd00]&&(spr_addr[10:0]==11'd20)); 
  assign sr_we=(spr_we&&sr_sel)|(branch_op==3'd6)|flag_we|cy_we|ov_we; 
  assign pc_we=(du_write&&(npc_sel|ppc_sel)); 
  assign epcr_we=(spr_we&&epcr_sel); 
  assign eear_we=(spr_we&&eear_sel); 
  assign esr_we=(spr_we&&esr_sel); 
  assign fpcsr_we=(spr_we&&fpcsr_sel); 
  assign sys_data=(spr_dat_cfgr&{32{cfgr_sel}})|(spr_dat_rf&{32{rf_sel}})|(spr_dat_npc&{32{npc_sel}})|(spr_dat_ppc&{32{ppc_sel}})|({{32-17{1'b0}},sr}&{32{sr_sel}})|(epcr&{32{epcr_sel}})|(eear&{32{eear_sel}})|({{32-12{1'b0}},fpcsr}&{32{fpcsr_sel}})|({{32-17{1'b0}},esr}&{32{esr_sel}}); 
  assign flag=sr[9]; 
  assign carry=sr[10]; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          sr_reg <={2'b01,1'b0,{17-4{1'b0}},1'b1};
        else 
          if (except_started)
             sr_reg <=to_sr[17-1:0];
           else 
             if (sr_we)
                sr_reg <=to_sr[17-1:0];
 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          begin 
            sr_reg_bit_eph <=1'b0;
            sr_reg_bit_eph_select <=1'b1;
          end 
        else 
          if (sr_reg_bit_eph_select)
             begin 
               sr_reg_bit_eph <=boot_adr_sel_i;
               sr_reg_bit_eph_select <=1'b0;
             end 
           else 
             if (sr_we)
                begin 
                  sr_reg_bit_eph <=to_sr[14];
                end
  
  assign sr_reg_bit_eph_muxed=(sr_reg_bit_eph_select) ? boot_adr_sel_i:sr_reg_bit_eph; 
  always @(  sr_reg or  sr_reg_bit_eph_muxed)
       sr ={sr_reg[17-1:17-2],sr_reg_bit_eph_muxed,sr_reg[17-4:0]};
 
  always @(          spr_addr or  sys_data or  spr_dat_mac or  spr_dat_pic or  spr_dat_pm or  spr_dat_fpu or  spr_dat_dmmu or  spr_dat_immu or  spr_dat_du or  spr_dat_tt)
       begin 
         casez (spr_addr[15:11])
          5 'd00:
             to_wbmux =sys_data;
          5 'd10:
             to_wbmux =spr_dat_tt;
          5 'd09:
             to_wbmux =spr_dat_pic;
          5 'd08:
             to_wbmux =spr_dat_pm;
          5 'd01:
             to_wbmux =spr_dat_dmmu;
          5 'd02:
             to_wbmux =spr_dat_immu;
          5 'd05:
             to_wbmux =spr_dat_mac;
          5 'd11:
             to_wbmux =spr_dat_fpu;
          default :
             to_wbmux =spr_dat_du;
         endcase 
       end
  
endmodule
 
module or1200_dpram #(
 parameter aw =5,
 parameter dw =32) (
  input clk_a,
  input ce_a,
  input [aw-1:0] addr_a,
  output [dw-1:0] do_a,
  input clk_b,
  input ce_b,
  input we_b,
  input [aw-1:0] addr_b,
  input [dw-1:0] di_b) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_a_reg ;  function[31:0]get_gpr;input[aw-1:0]gpr_no;
      get_gpr =mem[gpr_no];endfunction function[31:0]set_gpr;input[aw-1:0]gpr_no;input[dw-1:0]value;
      begin 
        mem [gpr_no]=value;
        set_gpr =0;
      end endfunction 
  assign do_a=mem[addr_a_reg]; 
  always @( posedge clk_a)
       if (ce_a)
          addr_a_reg <=addr_a;
 
  always @( posedge clk_b)
       if (ce_b&we_b)
          mem [addr_b]<=di_b;
 
endmodule
 
module or1200_dmmu_tlb #(
 parameter dw =32,
 parameter aw =32) (
  input clk,
  input rst,
  input tlb_en,
  input [aw-1:0] vaddr,
  output hit,
  output [31:13] ppn,
  output uwe,
  output ure,
  output swe,
  output sre,
  output ci,
  input spr_cs,
  input spr_write,
  input [31:0] spr_addr,
  input [31:0] spr_dat_i,
  output [31:0] spr_dat_o) ; 
    
    
   wire [31:13+6-1+1] vpn ;  
   wire v ;  
   wire [6-1:0] tlb_index ;  
   wire tlb_mr_en ;  
   wire tlb_mr_we ;  
   wire [32-6-13+1-1:0] tlb_mr_ram_in ;  
   wire [32-6-13+1-1:0] tlb_mr_ram_out ;  
   wire tlb_tr_en ;  
   wire tlb_tr_we ;  
   wire [32-13+5-1:0] tlb_tr_ram_in ;  
   wire [32-13+5-1:0] tlb_tr_ram_out ;  
  assign tlb_mr_en=tlb_en|(spr_cs&!spr_addr[7]); 
  assign tlb_mr_we=spr_cs&spr_write&!spr_addr[7]; 
  assign tlb_tr_en=tlb_en|(spr_cs&spr_addr[7]); 
  assign tlb_tr_we=spr_cs&spr_write&spr_addr[7]; 
  assign spr_dat_o=(spr_cs&!spr_write&!spr_addr[7]) ? {vpn,tlb_index,{32-6-13-7{1'b0}},1'b0,5'b00000,v}:(spr_cs&!spr_write&spr_addr[7]) ? {ppn,{13-10{1'b0}},swe,sre,uwe,ure,{4{1'b0}},ci,1'b0}:32'h00000000; 
  assign {vpn,v}=tlb_mr_ram_out; 
  assign tlb_mr_ram_in={spr_dat_i[31:13+6-1+1],spr_dat_i[0]}; 
  assign {ppn,swe,sre,uwe,ure,ci}=tlb_tr_ram_out; 
  assign tlb_tr_ram_in={spr_dat_i[31:13],spr_dat_i[9],spr_dat_i[8],spr_dat_i[7],spr_dat_i[6],spr_dat_i[1]}; 
  assign hit=(vpn==vaddr[31:13+6-1+1])&v; 
  assign tlb_index=spr_cs ? spr_addr[6-1:0]:vaddr[13+6-1:13]; 
  or1200_spram #(.aw(6),.dw(14))dtlb_ram(.clk(clk),.ce(tlb_mr_en),.we(tlb_mr_we),.addr(tlb_index),.di(tlb_mr_ram_in),.doq(tlb_mr_ram_out)); 
  or1200_spram #(.aw(6),.dw(24))dtlb_tr_ram(.clk(clk),.ce(tlb_tr_en),.we(tlb_tr_we),.addr(tlb_index),.di(tlb_tr_ram_in),.doq(tlb_tr_ram_out)); 
endmodule
 
module or1200_spram_1024x32_bw (
  input clk,
  input rst,
  input ce,
  input [3:0] we,
  input oe,
  input [9:0] addr,
  input [31:0] di,
  output [31:0] doq) ; 
   reg [7:0] mem_0[1023:0] ;  
   reg [7:0] mem_1[1023:0] ;  
   reg [7:0] mem_2[1023:0] ;  
   reg [7:0] mem_3[1023:0] ;  
   reg [9:0] addr_reg ;  
  assign doq=(oe) ? {mem_3[addr_reg],mem_2[addr_reg],mem_1[addr_reg],mem_0[addr_reg]}:{32{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <=10'h000;
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we[0])
          mem_0 [addr]<=di[7:0];
 
  always @( posedge clk)
       if (ce&&we[1])
          mem_1 [addr]<=di[15:8];
 
  always @( posedge clk)
       if (ce&&we[2])
          mem_2 [addr]<=di[23:16];
 
  always @( posedge clk)
       if (ce&&we[3])
          mem_3 [addr]<=di[31:24];
 
endmodule
 
module or1200_mult_mac #(
 parameter width =32) (
  input clk,
  input rst,
  input ex_freeze,
  input id_macrc_op,
  input macrc_op,
  input [width-1:0] a,
  input [width-1:0] b,
  input [3-1:0] mac_op,
  input [5-1:0] alu_op,
  output reg  [width-1:0] result,
  output mult_mac_stall,
  output reg  ovforw,
  output reg  ov_we,
  input spr_cs,
  input spr_write,
  input [31:0] spr_addr,
  input [31:0] spr_dat_i,
  output [31:0] spr_dat_o) ; 
    
   reg ex_freeze_r ;  
   wire alu_op_mul ;  
   wire alu_op_smul ;  
   reg [2*width-1:0] mul_prod_r ;  
   wire alu_op_umul ;  
   wire [2*width-1:0] mul_prod ;  
   wire mul_stall ;  
   reg [1:0] mul_stall_count ;  
   wire [3-1:0] mac_op_r1 ;  
   wire [3-1:0] mac_op_r2 ;  
   wire [3-1:0] mac_op_r3 ;  
   wire mac_stall_r ;  
   wire [63:0] mac_r ;  
   wire [width-1:0] x ;  
   wire [width-1:0] y ;  
   wire spr_maclo_we ;  
   wire spr_machi_we ;  
   wire alu_op_div ;  
   wire alu_op_udiv ;  
   wire alu_op_sdiv ;  
   reg div_free ;  
   wire div_stall ;  
   reg [2*width-1:0] div_quot_r ;  
   wire [width-1:0] div_tmp ;  
   reg [5:0] div_cntr ;  
   wire div_by_zero ;  
  assign alu_op_smul=(alu_op==5'b0_0110); 
  assign alu_op_umul=(alu_op==5'b0_1011); 
  assign alu_op_mul=alu_op_smul|alu_op_umul; 
  assign spr_maclo_we=1'b0; 
  assign spr_machi_we=1'b0; 
  assign spr_dat_o=32'h0000_0000; 
  assign alu_op_sdiv=(alu_op==5'b0_1001); 
  assign alu_op_udiv=(alu_op==5'b0_1010); 
  assign alu_op_div=alu_op_sdiv|alu_op_udiv; 
  assign x=(alu_op_sdiv|alu_op_smul)&a[31] ? ~a+32'b1:alu_op_div|alu_op_mul|(|mac_op) ? a:32'd0; 
  assign y=(alu_op_sdiv|alu_op_smul)&b[31] ? ~b+32'b1:alu_op_div|alu_op_mul|(|mac_op) ? b:32'd0; 
  assign div_by_zero=!(|b)&alu_op_div; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          ex_freeze_r <=1'b1;
        else 
          ex_freeze_r <=ex_freeze;
 
  always @*
       casez (alu_op)
        5 'b0_1001:
           begin 
             result =a[31]^b[31] ? ~div_quot_r[31:0]+32'd1:div_quot_r[31:0];
           end 
        5 'b0_1010:
           begin 
             result =div_quot_r[31:0];
           end 
        5 'b0_0110:
           begin 
             result =a[31]^b[31] ? ~mul_prod_r[31:0]+32'd1:mul_prod_r[31:0];
           end 
        5 'b0_1011:
           begin 
             result =mul_prod_r[31:0];
           end 
        default :
           result ={width{1'b0}};
       endcase
  
  always @*
       casez (alu_op)
        5 'b0_0110:
           begin 
             ovforw =(mul_prod_r[width-1]&&!((a[width-1]^b[width-1])&&~|mul_prod_r[width-2:0]))|||mul_prod_r[2*width-1:32];
             ov_we =1;
           end 
        5 'b0_1011:
           begin 
             ovforw =|mul_prod_r[2*width-1:32];
             ov_we =1;
           end 
        5 'b0_1010,5'b0_1001:
           begin 
             ovforw =div_by_zero||(a==32'h8000_0000&&b==32'hffff_ffff);
             ov_we =1;
           end 
        default :
           begin 
             ovforw =0;
             ov_we =0;
           end 
       endcase
  
  or1200_gmultp2_32x32 or1200_gmultp2_32x32(.X(x),.Y(y),.RST(rst),.CLK(clk),.P(mul_prod)); 
  always @(  posedge rst or  posedge clk)
       if (rst==(1'b1))
          begin 
            mul_prod_r <=64'h0000_0000_0000_0000;
          end 
        else 
          begin 
            mul_prod_r <=mul_prod[63:0];
          end
  
  always @(  posedge rst or  posedge clk)
       if (rst==(1'b1))
          mul_stall_count <=0;
        else 
          if (!(|mul_stall_count))
             mul_stall_count <={mul_stall_count[0],alu_op_mul&!ex_freeze_r};
           else 
             mul_stall_count <={mul_stall_count[0],1'b0};
 
  assign mul_stall=(|mul_stall_count)|(!(|mul_stall_count)&alu_op_mul&!ex_freeze_r); 
  assign mac_stall_r=1'b0; 
  assign mac_r={2*width{1'b0}}; 
  assign mac_op_r1=3'b0; 
  assign mac_op_r2=3'b0; 
  assign mac_op_r3=3'b0; 
  assign div_tmp=div_quot_r[63:32]-y; 
  always @(  posedge rst or  posedge clk)
       if (rst==(1'b1))
          begin 
            div_quot_r <=64'h0000_0000_0000_0000;
            div_free <=1'b1;
            div_cntr <=6'b00_0000;
          end 
        else 
          if (div_by_zero)
             begin 
               div_quot_r <=64'h0000_0000_0000_0000;
               div_free <=1'b1;
               div_cntr <=6'b00_0000;
             end 
           else 
             if (|div_cntr)
                begin 
                  if (div_tmp[31])
                     div_quot_r <={div_quot_r[62:0],1'b0};
                   else 
                     div_quot_r <={div_tmp[30:0],div_quot_r[31:0],1'b1};
                  div_cntr <=div_cntr-6'd1;
                end 
              else 
                if (alu_op_div&&div_free)
                   begin 
                     div_quot_r <={31'b0,x[31:0],1'b0};
                     div_cntr <=6'b10_0000;
                     div_free <=1'b0;
                   end 
                 else 
                   if (div_free|!ex_freeze)
                      begin 
                        div_free <=1'b1;
                      end
  
  assign div_stall=(|div_cntr)|(!ex_freeze_r&alu_op_div); 
  assign mult_mac_stall=mac_stall_r|div_stall|mul_stall; 
endmodule
 
module or1200_fpu_pre_norm_div #(
 parameter FP_WIDTH =32,
 parameter MUL_SERIAL =0,
 parameter MUL_COUNT =11,
 parameter FRAC_WIDTH =23,
 parameter EXP_WIDTH =8,
 parameter ZERO_VECTOR =31'd0,
 parameter INF =31'b1111111100000000000000000000000,
 parameter QNAN =31'b1111111110000000000000000000000,
 parameter SNAN =31'b1111111100000000000000000000001) (
  input clk_i,
  input [FP_WIDTH-1:0] opa_i,
  input [FP_WIDTH-1:0] opb_i,
  output reg  [EXP_WIDTH+1:0] exp_10_o,
  output [2*(FRAC_WIDTH+2)-1:0] dvdnd_50_o,
  output [FRAC_WIDTH+3:0] dvsor_27_o) ; 
    
    
    
    
    
    
    
    
    
   wire [EXP_WIDTH-1:0] s_expa ;  
   wire [EXP_WIDTH-1:0] s_expb ;  
   wire [FRAC_WIDTH-1:0] s_fracta ;  
   wire [FRAC_WIDTH-1:0] s_fractb ;  
   wire [2*(FRAC_WIDTH+2)-1:0] s_dvdnd_50_o ;  
   wire [FRAC_WIDTH+3:0] s_dvsor_27_o ;  
   reg [5:0] s_dvd_zeros ;  
   reg [5:0] s_div_zeros ;  
   reg [EXP_WIDTH+1:0] s_exp_10_o ;  
   reg [EXP_WIDTH+1:0] s_expa_in ;  
   reg [EXP_WIDTH+1:0] s_expb_in ;  
   wire s_opa_dn,s_opb_dn ;  
   wire [FRAC_WIDTH:0] s_fracta_24 ;  
   wire [FRAC_WIDTH:0] s_fractb_24 ;  
  assign s_expa=opa_i[30:23]; 
  assign s_expb=opb_i[30:23]; 
  assign s_fracta=opa_i[22:0]; 
  assign s_fractb=opb_i[22:0]; 
  assign dvdnd_50_o=s_dvdnd_50_o; 
  assign dvsor_27_o=s_dvsor_27_o; 
  always @( posedge clk_i)
       exp_10_o <=s_exp_10_o;
 
  assign s_opa_dn=!(|s_expa); 
  assign s_opb_dn=!(|s_expb); 
  assign s_fracta_24={!s_opa_dn,s_fracta}; 
  assign s_fractb_24={!s_opb_dn,s_fractb}; 
  always @( s_fracta_24)
       casez (s_fracta_24)
        24 'b1???????????????????????:
           s_dvd_zeros =0;
        24 'b01??????????????????????:
           s_dvd_zeros =1;
        24 'b001?????????????????????:
           s_dvd_zeros =2;
        24 'b0001????????????????????:
           s_dvd_zeros =3;
        24 'b00001???????????????????:
           s_dvd_zeros =4;
        24 'b000001??????????????????:
           s_dvd_zeros =5;
        24 'b0000001?????????????????:
           s_dvd_zeros =6;
        24 'b00000001????????????????:
           s_dvd_zeros =7;
        24 'b000000001???????????????:
           s_dvd_zeros =8;
        24 'b0000000001??????????????:
           s_dvd_zeros =9;
        24 'b00000000001?????????????:
           s_dvd_zeros =10;
        24 'b000000000001????????????:
           s_dvd_zeros =11;
        24 'b0000000000001???????????:
           s_dvd_zeros =12;
        24 'b00000000000001??????????:
           s_dvd_zeros =13;
        24 'b000000000000001?????????:
           s_dvd_zeros =14;
        24 'b0000000000000001????????:
           s_dvd_zeros =15;
        24 'b00000000000000001???????:
           s_dvd_zeros =16;
        24 'b000000000000000001??????:
           s_dvd_zeros =17;
        24 'b0000000000000000001?????:
           s_dvd_zeros =18;
        24 'b00000000000000000001????:
           s_dvd_zeros =19;
        24 'b000000000000000000001???:
           s_dvd_zeros =20;
        24 'b0000000000000000000001??:
           s_dvd_zeros =21;
        24 'b00000000000000000000001?:
           s_dvd_zeros =22;
        24 'b000000000000000000000001:
           s_dvd_zeros =23;
        24 'b000000000000000000000000:
           s_dvd_zeros =24;
       endcase
  
  always @( s_fractb_24)
       casez (s_fractb_24)
        24 'b1???????????????????????:
           s_div_zeros =0;
        24 'b01??????????????????????:
           s_div_zeros =1;
        24 'b001?????????????????????:
           s_div_zeros =2;
        24 'b0001????????????????????:
           s_div_zeros =3;
        24 'b00001???????????????????:
           s_div_zeros =4;
        24 'b000001??????????????????:
           s_div_zeros =5;
        24 'b0000001?????????????????:
           s_div_zeros =6;
        24 'b00000001????????????????:
           s_div_zeros =7;
        24 'b000000001???????????????:
           s_div_zeros =8;
        24 'b0000000001??????????????:
           s_div_zeros =9;
        24 'b00000000001?????????????:
           s_div_zeros =10;
        24 'b000000000001????????????:
           s_div_zeros =11;
        24 'b0000000000001???????????:
           s_div_zeros =12;
        24 'b00000000000001??????????:
           s_div_zeros =13;
        24 'b000000000000001?????????:
           s_div_zeros =14;
        24 'b0000000000000001????????:
           s_div_zeros =15;
        24 'b00000000000000001???????:
           s_div_zeros =16;
        24 'b000000000000000001??????:
           s_div_zeros =17;
        24 'b0000000000000000001?????:
           s_div_zeros =18;
        24 'b00000000000000000001????:
           s_div_zeros =19;
        24 'b000000000000000000001???:
           s_div_zeros =20;
        24 'b0000000000000000000001??:
           s_div_zeros =21;
        24 'b00000000000000000000001?:
           s_div_zeros =22;
        24 'b000000000000000000000001:
           s_div_zeros =23;
        24 'b000000000000000000000000:
           s_div_zeros =24;
       endcase
  
   wire [FRAC_WIDTH:0] fracta_lshift_intermediate ;  
   wire [FRAC_WIDTH:0] fractb_lshift_intermediate ;  
  assign fracta_lshift_intermediate=s_fracta_24<<s_dvd_zeros; 
  assign fractb_lshift_intermediate=s_fractb_24<<s_div_zeros; 
  assign s_dvdnd_50_o={fracta_lshift_intermediate,26'd0}; 
  assign s_dvsor_27_o={3'd0,fractb_lshift_intermediate}; 
  always @( posedge clk_i)
       begin 
         s_expa_in <={2'd0,s_expa}+{9'd0,s_opa_dn};
         s_expb_in <={2'd0,s_expb}+{9'd0,s_opb_dn};
         s_exp_10_o <=s_expa_in-s_expb_in+10'b0001111111-{4'd0,s_dvd_zeros}+{4'd0,s_div_zeros};
       end
  
endmodule
 
module or1200_lsu #(
 parameter dw =32,
 parameter aw =5) (
  input clk,
  input rst,
  input [31:0] id_addrbase,
  input [31:0] ex_addrbase,
  input [31:0] id_addrofs,
  input [31:0] ex_addrofs,
  input [4-1:0] id_lsu_op,
  input [dw-1:0] lsu_datain,
  output [dw-1:0] lsu_dataout,
  output lsu_stall,
  output lsu_unstall,
  input du_stall,
  output reg  except_align,
  output except_dtlbmiss,
  output except_dmmufault,
  output except_dbuserr,
  input id_freeze,
  input ex_freeze,
  input flushpipe,
  output [31:0] dcpu_adr_o,
  output dcpu_cycstb_o,
  output dcpu_we_o,
  output reg  [3:0] dcpu_sel_o,
  output [3:0] dcpu_tag_o,
  output [31:0] dcpu_dat_o,
  input [31:0] dcpu_dat_i,
  input dcpu_ack_i,
  input dcpu_rty_i,
  input dcpu_err_i,
  input [3:0] dcpu_tag_i) ; 
    
    
   reg [4-1:0] ex_lsu_op ;  
   wire [2:0] id_precalc_sum ;  
   reg [2:0] dcpu_adr_r ;  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            ex_lsu_op <=4'b0000;
          else 
            if (!ex_freeze&id_freeze|flushpipe)
               ex_lsu_op <=4'b0000;
             else 
               if (!ex_freeze)
                  ex_lsu_op <=id_lsu_op;
       end
  
  assign id_precalc_sum=id_addrbase[2-1:0]+id_addrofs[2-1:0]; 
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            dcpu_adr_r <={2+1{1'b0}};
          else 
            if (!ex_freeze)
               dcpu_adr_r <=id_precalc_sum;
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            except_align <=1'b0;
          else 
            if (!ex_freeze&id_freeze|flushpipe)
               except_align <=1'b0;
             else 
               if (!ex_freeze)
                  except_align <=((id_lsu_op==4'b1100)|(id_lsu_op==4'b0100)|(id_lsu_op==4'b0101))&id_precalc_sum[0]|((id_lsu_op==4'b1110)|(id_lsu_op==4'b0110)|(id_lsu_op==4'b0111))&|id_precalc_sum[1:0];
       end
  
  assign lsu_stall=dcpu_rty_i&dcpu_cycstb_o; 
  assign lsu_unstall=dcpu_ack_i; 
  assign except_dtlbmiss=dcpu_err_i&(dcpu_tag_i==4'hd); 
  assign except_dmmufault=dcpu_err_i&(dcpu_tag_i==4'hc); 
  assign except_dbuserr=dcpu_err_i&(dcpu_tag_i==4'hb); 
  assign dcpu_adr_o[31:2]=ex_addrbase[31:2]+(ex_addrofs[31:2]+{{(32-2)-1{1'b0}},dcpu_adr_r[2]}); 
  assign dcpu_adr_o[2-1:0]=dcpu_adr_r[2-1:0]; 
  assign dcpu_cycstb_o=du_stall|lsu_unstall|except_align ? 1'b0:|ex_lsu_op; 
  assign dcpu_we_o=ex_lsu_op[3]; 
  assign dcpu_tag_o=dcpu_cycstb_o ? 4'h1:4'h0; 
  always @(  ex_lsu_op or  dcpu_adr_o)
       casez ({ex_lsu_op,dcpu_adr_o[1:0]})
        { 4'b1010,2'b00}:
           dcpu_sel_o =4'b1000;
        { 4'b1010,2'b01}:
           dcpu_sel_o =4'b0100;
        { 4'b1010,2'b10}:
           dcpu_sel_o =4'b0010;
        { 4'b1010,2'b11}:
           dcpu_sel_o =4'b0001;
        { 4'b1100,2'b00}:
           dcpu_sel_o =4'b1100;
        { 4'b1100,2'b10}:
           dcpu_sel_o =4'b0011;
        { 4'b1110,2'b00}:
           dcpu_sel_o =4'b1111;
        { 4'b0010,2'b00},{4'b0011,2'b00}:
           dcpu_sel_o =4'b1000;
        { 4'b0010,2'b01},{4'b0011,2'b01}:
           dcpu_sel_o =4'b0100;
        { 4'b0010,2'b10},{4'b0011,2'b10}:
           dcpu_sel_o =4'b0010;
        { 4'b0010,2'b11},{4'b0011,2'b11}:
           dcpu_sel_o =4'b0001;
        { 4'b0100,2'b00},{4'b0101,2'b00}:
           dcpu_sel_o =4'b1100;
        { 4'b0100,2'b10},{4'b0101,2'b10}:
           dcpu_sel_o =4'b0011;
        { 4'b0110,2'b00},{4'b0111,2'b00}:
           dcpu_sel_o =4'b1111;
        default :
           dcpu_sel_o =4'b0000;
       endcase
  
  or1200_mem2reg or1200_mem2reg(.addr(dcpu_adr_o[1:0]),.lsu_op(ex_lsu_op),.memdata(dcpu_dat_i),.regdata(lsu_dataout)); 
  or1200_reg2mem or1200_reg2mem(.addr(dcpu_adr_o[1:0]),.lsu_op(ex_lsu_op),.regdata(lsu_datain),.memdata(dcpu_dat_o)); 
endmodule
 
module or1200_cfgr (
  input [31:0] spr_addr,
  output reg  [31:0] spr_dat_o) ; 
  always @( spr_addr)
       if (~|spr_addr[31:4])
          case (spr_addr[3:0])
           4 'h0:
              begin 
                spr_dat_o [5:0]=6'h08;
                spr_dat_o [15:6]=10'h000;
                spr_dat_o [23:16]=8'h00;
                spr_dat_o [31:24]=8'h13;
              end 
           4 'h1:
              begin 
                spr_dat_o [0]=1'b1;
                spr_dat_o [1]=1'b1;
                spr_dat_o [2]=1'b1;
                spr_dat_o [3]=1'b1;
                spr_dat_o [4]=1'b1;
                spr_dat_o [5]=1'b0;
                spr_dat_o [6]=1'b1;
                spr_dat_o [7]=1'b0;
                spr_dat_o [8]=1'b0;
                spr_dat_o [9]=1'b1;
                spr_dat_o [10]=1'b1;
                spr_dat_o [11]=1'b0;
                spr_dat_o [23:12]=12'h000;
                spr_dat_o [31:24]=8'h00;
              end 
           4 'h2:
              begin 
                spr_dat_o [3:0]=4'h0;
                spr_dat_o [4]=1'b0;
                spr_dat_o [5]=1'b1;
                spr_dat_o [6]=1'b0;
                spr_dat_o [7]=1'b0;
                spr_dat_o [8]=1'b0;
                spr_dat_o [9]=1'b0;
                spr_dat_o [31:10]=22'h000000;
              end 
           4 'h3:
              begin 
                spr_dat_o [1:0]=2'h0;
                spr_dat_o [4:2]=3'h6;
                spr_dat_o [7:5]=3'h0;
                spr_dat_o [8]=1'b0;
                spr_dat_o [9]=1'b0;
                spr_dat_o [10]=1'b0;
                spr_dat_o [11]=1'b0;
                spr_dat_o [31:12]=20'h00000;
              end 
           4 'h4:
              begin 
                spr_dat_o [1:0]=2'h0;
                spr_dat_o [4:2]=3'h6;
                spr_dat_o [7:5]=3'h0;
                spr_dat_o [8]=1'b0;
                spr_dat_o [9]=1'b0;
                spr_dat_o [10]=1'b0;
                spr_dat_o [11]=1'b0;
                spr_dat_o [31:12]=20'h00000;
              end 
           4 'h5:
              begin 
                spr_dat_o [2:0]=3'h0;
                spr_dat_o [6:3]=(13-4);
                spr_dat_o [7]=4==4 ? 1'b0:1'b1;
                spr_dat_o [8]=1'b0;
                spr_dat_o [9]=1'b1;
                spr_dat_o [10]=1'b1;
                spr_dat_o [11]=1'b0;
                spr_dat_o [12]=1'b0;
                spr_dat_o [13]=1'b1;
                spr_dat_o [14]=1'b0;
                spr_dat_o [31:15]=17'h00000;
              end 
           4 'h6:
              begin 
                spr_dat_o [2:0]=3'h0;
                spr_dat_o [6:3]=(13-4);
                spr_dat_o [7]=4==4 ? 1'b0:1'b1;
                spr_dat_o [8]=1'b0;
                spr_dat_o [9]=1'b1;
                spr_dat_o [10]=1'b1;
                spr_dat_o [11]=1'b0;
                spr_dat_o [12]=1'b0;
                spr_dat_o [13]=1'b1;
                spr_dat_o [14]=1'b0;
                spr_dat_o [31:15]=17'h00000;
              end 
           4 'h7:
              begin 
                spr_dat_o [3:0]=4'h0;
                spr_dat_o [4]=1'b0;
                spr_dat_o [31:5]=27'd0;
              end 
           default :
              spr_dat_o =32'h0000_0000;
          endcase 
        else 
          spr_dat_o =32'h0000_0000;
 
endmodule
 
module or1200_spram_128x32 #(
 parameter aw =7,
 parameter dw =32) (
  input clk,
  input rst,
  input ce,
  input we,
  input oe,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq=(oe) ? mem[addr_reg]:{dw{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <={aw{1'b0}};
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we)
          mem [addr]<=di;
 
endmodule
 
module or1200_ic_top #(
 parameter dw =32) (
  input clk,
  input rst,
  output [dw-1:0] icbiu_dat_o,
  output [31:0] icbiu_adr_o,
  output icbiu_cyc_o,
  output icbiu_stb_o,
  output icbiu_we_o,
  output [3:0] icbiu_sel_o,
  output icbiu_cab_o,
  input [dw-1:0] icbiu_dat_i,
  input icbiu_ack_i,
  input icbiu_err_i,
  input ic_en,
  input [31:0] icqmem_adr_i,
  input icqmem_cycstb_i,
  input icqmem_ci_i,
  input [3:0] icqmem_sel_i,
  input [3:0] icqmem_tag_i,
  output [dw-1:0] icqmem_dat_o,
  output icqmem_ack_o,
  output icqmem_rty_o,
  output icqmem_err_o,
  output [3:0] icqmem_tag_o,
  input spr_cs,
  input spr_write,
  input [31:0] spr_dat_i) ; 
    
   wire tag_v ;  
   wire [20-2:0] tag ;  
   wire [dw-1:0] to_icram ;  
   wire [dw-1:0] from_icram ;  
   wire [31:0] saved_addr ;  
   wire [3:0] icram_we ;  
   wire ictag_we ;  
   wire [31:0] ic_addr ;  
   wire icfsm_biu_read ;  
   reg tagcomp_miss ;  
   wire [13-1:4] ictag_addr ;  
   wire ictag_en ;  
   wire ictag_v ;  
   wire ic_inv ;  
   wire icfsm_first_hit_ack ;  
   wire icfsm_first_miss_ack ;  
   wire icfsm_first_miss_err ;  
   wire icfsm_burst ;  
   wire icfsm_tag_we ;  
   reg ic_inv_q ;  
  assign icbiu_adr_o=ic_addr; 
  assign ic_inv=spr_cs&spr_write; 
  assign ictag_we=icfsm_tag_we|ic_inv; 
  assign ictag_addr=ic_inv ? spr_dat_i[13-1:4]:ic_addr[13-1:4]; 
  assign ictag_en=ic_inv|ic_en; 
  assign ictag_v=~ic_inv; 
  assign icbiu_dat_o=32'h00000000; 
  assign icbiu_cyc_o=(ic_en) ? icfsm_biu_read:icqmem_cycstb_i; 
  assign icbiu_stb_o=(ic_en) ? icfsm_biu_read:icqmem_cycstb_i; 
  assign icbiu_we_o=1'b0; 
  assign icbiu_sel_o=(ic_en&icfsm_biu_read) ? 4'b1111:icqmem_sel_i; 
  assign icbiu_cab_o=(ic_en) ? icfsm_burst:1'b0; 
  assign icqmem_rty_o=~icqmem_ack_o&~icqmem_err_o; 
  assign icqmem_tag_o=icqmem_err_o ? 4'hb:icqmem_tag_i; 
  assign icqmem_ack_o=ic_en ? (icfsm_first_hit_ack|icfsm_first_miss_ack):icbiu_ack_i; 
  assign icqmem_err_o=ic_en ? icfsm_first_miss_err:icbiu_err_i; 
  assign ic_addr=(icfsm_biu_read) ? saved_addr:icqmem_adr_i; 
  assign to_icram=icbiu_dat_i; 
  assign icqmem_dat_o=icfsm_first_miss_ack|!ic_en ? icbiu_dat_i:from_icram; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          ic_inv_q <=1'b0;
        else 
          ic_inv_q <=ic_inv;
 
  always @(   tag or  saved_addr or  tag_v)
       begin 
         if ((tag!=saved_addr[31:13-1+1])|!tag_v)
            tagcomp_miss =1'b1;
          else 
            tagcomp_miss =1'b0;
       end
  
  or1200_ic_fsm or1200_ic_fsm(.clk(clk),.rst(rst),.ic_en(ic_en),.icqmem_cycstb_i(icqmem_cycstb_i),.icqmem_ci_i(icqmem_ci_i),.tagcomp_miss(tagcomp_miss),.biudata_valid(icbiu_ack_i),.biudata_error(icbiu_err_i),.start_addr(icqmem_adr_i),.saved_addr(saved_addr),.icram_we(icram_we),.biu_read(icfsm_biu_read),.first_hit_ack(icfsm_first_hit_ack),.first_miss_ack(icfsm_first_miss_ack),.first_miss_err(icfsm_first_miss_err),.burst(icfsm_burst),.tag_we(icfsm_tag_we)); 
  or1200_ic_ram or1200_ic_ram(.clk(clk),.rst(rst),.addr(ic_addr[13-1:2]),.en(ic_en),.we(icram_we),.datain(to_icram),.dataout(from_icram)); 
  or1200_ic_tag or1200_ic_tag(.clk(clk),.rst(rst),.addr(ictag_addr),.en(ictag_en),.we(ictag_we),.datain({ic_addr[31:13-1+1],ictag_v}),.tag_v(tag_v),.tag(tag)); 
endmodule
 
module or1200_alu (
  input [32-1:0] a,
  input [32-1:0] b,
  input [32-1:0] mult_mac_result,
  input macrc_op,
  input [5-1:0] alu_op,
  input [4-1:0] alu_op2,
  input [4-1:0] comp_op,
  input [4:0] cust5_op,
  input [5:0] cust5_limm,
  output reg  [32-1:0] result,
  output reg  flagforw,
  output reg  flag_we,
  output reg  ovforw,
  output reg  ov_we,
  output reg  cyforw,
  output reg  cy_we,
  input carry,
  input flag) ; 
   reg [32-1:0] shifted_rotated ;  
   reg [32-1:0] extended ;  
   reg flagcomp ;  
   wire [32-1:0] comp_a ;  
   wire [32-1:0] comp_b ;  
   wire a_eq_b ;  
   wire a_lt_b ;  
   wire [32-1:0] result_sum ;  
   wire [32-1:0] result_and ;  
   wire cy_sum ;  
   wire cy_sub ;  
   wire ov_sum ;  
   wire [32-1:0] carry_in ;  
   wire [32-1:0] b_mux ;  
  assign comp_a={a[32-1]^comp_op[3],a[32-2:0]}; 
  assign comp_b={b[32-1]^comp_op[3],b[32-2:0]}; 
  assign a_eq_b=!(|result_sum); 
  assign a_lt_b=comp_op[3] ? ((a[32-1]&!b[32-1])|(!a[32-1]&!b[32-1]&result_sum[32-1])|(a[32-1]&b[32-1]&result_sum[32-1])):(a<b); 
  assign cy_sub=a_lt_b; 
  assign carry_in=(alu_op==5'b0_0001) ? {{32-1{1'b0}},carry}:{32{1'b0}}; 
  assign b_mux=((alu_op==5'b0_0010)|(alu_op==5'b1_0000)) ? (~b)+1:b; 
  assign {cy_sum,result_sum}=(a+b_mux)+carry_in; 
  assign ov_sum=((!a[32-1]&!b_mux[32-1])&result_sum[32-1])|((!a[32-1]&b_mux[32-1])&result_sum[32-1]&alu_op==5'b0_0010)|((a[32-1]&b_mux[32-1])&!result_sum[32-1]); 
  assign result_and=a&b; 
  always @(            alu_op or  alu_op2 or  a or  b or  result_sum or  result_and or  macrc_op or  shifted_rotated or  mult_mac_result or  flag or  carry or  extended)
       begin 
         casez (alu_op)
          5 'b0_1111:
             begin 
               casez (alu_op2)
                0 :
                   begin 
                     result =a[0] ? 1:a[1] ? 2:a[2] ? 3:a[3] ? 4:a[4] ? 5:a[5] ? 6:a[6] ? 7:a[7] ? 8:a[8] ? 9:a[9] ? 10:a[10] ? 11:a[11] ? 12:a[12] ? 13:a[13] ? 14:a[14] ? 15:a[15] ? 16:a[16] ? 17:a[17] ? 18:a[18] ? 19:a[19] ? 20:a[20] ? 21:a[21] ? 22:a[22] ? 23:a[23] ? 24:a[24] ? 25:a[25] ? 26:a[26] ? 27:a[27] ? 28:a[28] ? 29:a[29] ? 30:a[30] ? 31:a[31] ? 32:0;
                   end 
                default :
                   begin 
                     result =a[31] ? 32:a[30] ? 31:a[29] ? 30:a[28] ? 29:a[27] ? 28:a[26] ? 27:a[25] ? 26:a[24] ? 25:a[23] ? 24:a[22] ? 23:a[21] ? 22:a[20] ? 21:a[19] ? 20:a[18] ? 19:a[17] ? 18:a[16] ? 17:a[15] ? 16:a[14] ? 15:a[13] ? 14:a[12] ? 13:a[11] ? 12:a[10] ? 11:a[9] ? 10:a[8] ? 9:a[7] ? 8:a[6] ? 7:a[5] ? 6:a[4] ? 5:a[3] ? 4:a[2] ? 3:a[1] ? 2:a[0] ? 1:0;
                   end 
               endcase 
             end 
          5 'b0_1000:
             begin 
               result =shifted_rotated;
             end 
          5 'b0_0001,5'b0_0010,5'b0_0000:
             begin 
               result =result_sum;
             end 
          5 'b0_0101:
             begin 
               result =a^b;
             end 
          5 'b0_0100:
             begin 
               result =a|b;
             end 
          5 'b0_1100:
             begin 
               result =extended;
             end 
          5 'b0_1101:
             begin 
               result =a;
             end 
          5 'b1_0001:
             begin 
               if (macrc_op)
                  begin 
                    result =mult_mac_result;
                  end 
                else 
                  begin 
                    result =b<<16;
                  end 
             end 
          5 'b0_1001,5'b0_1010,5'b0_0110,5'b0_1011:
             begin 
               result =mult_mac_result;
             end 
          5 'b0_1110:
             begin 
               result =flag ? a:b;
             end 
          default :
             begin 
               result =result_and;
             end 
         endcase 
       end
  
  always @(    alu_op or  result_sum or  result_and or  flagcomp)
       begin 
         casez (alu_op)
          5 'b1_0000:
             begin 
               flagforw =flagcomp;
               flag_we =1'b1;
             end 
          default :
             begin 
               flagforw =flagcomp;
               flag_we =1'b0;
             end 
         endcase 
       end
  
  always @(   alu_op or  cy_sum or  cy_sub)
       begin 
         casez (alu_op)
          5 'b0_0001,5'b0_0000:
             begin 
               cyforw =cy_sum;
               cy_we =1'b1;
             end 
          5 'b0_0010:
             begin 
               cyforw =cy_sub;
               cy_we =1'b1;
             end 
          default :
             begin 
               cyforw =1'b0;
               cy_we =1'b0;
             end 
         endcase 
       end
  
  always @(  alu_op or  ov_sum)
       begin 
         casez (alu_op)
          5 'b0_0001,5'b0_0010,5'b0_0000:
             begin 
               ovforw =ov_sum;
               ov_we =1'b1;
             end 
          default :
             begin 
               ovforw =1'b0;
               ov_we =1'b0;
             end 
         endcase 
       end
  
  always @(   alu_op2 or  a or  b)
       begin 
         case (alu_op2)
          4 'd0:
             shifted_rotated =(a<<b[4:0]);
          4 'd1:
             shifted_rotated =(a>>b[4:0]);
          default :
             shifted_rotated =({32{a[31]}}<<(6'd32-{1'b0,b[4:0]}))|a>>b[4:0];
         endcase 
       end
  
  always @(   comp_op or  a_eq_b or  a_lt_b)
       begin 
         case (comp_op[2:0])
          3 'b000:
             flagcomp =a_eq_b;
          3 'b001:
             flagcomp =~a_eq_b;
          3 'b010:
             flagcomp =~(a_eq_b|a_lt_b);
          3 'b011:
             flagcomp =~a_lt_b;
          3 'b100:
             flagcomp =a_lt_b;
          3 'b101:
             flagcomp =a_eq_b|a_lt_b;
          default :
             flagcomp =1'b0;
         endcase 
       end
  
  always @(   alu_op or  alu_op2 or  a)
       begin 
         casez (alu_op2)
          4 'h0:
             extended ={{16{a[15]}},a[15:0]};
          4 'h1:
             extended ={{24{a[7]}},a[7:0]};
          4 'h2:
             extended ={16'd0,a[15:0]};
          4 'h3:
             extended ={24'd0,a[7:0]};
          default :
             extended =a;
         endcase 
       end
  
endmodule
 
module or1200_spram_2048x32 #(
 parameter aw =11,
 parameter dw =32) (
  input clk,
  input rst,
  input ce,
  input we,
  input oe,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq=(oe) ? mem[addr_reg]:{dw{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <={aw{1'b0}};
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we)
          mem [addr]<=di;
 
endmodule
 
module or1200_fpu_mul #(
 parameter FP_WIDTH =32,
 parameter MUL_SERIAL =0,
 parameter MUL_COUNT =11,
 parameter FRAC_WIDTH =23,
 parameter EXP_WIDTH =8,
 parameter ZERO_VECTOR =31'd0,
 parameter INF =31'b1111111100000000000000000000000,
 parameter QNAN =31'b1111111110000000000000000000000,
 parameter SNAN =31'b1111111100000000000000000000001,
 parameter t_state_waiting =1'b0,
 parameter t_state_busy =1'b1) (
  input clk_i,
  input [FRAC_WIDTH:0] fracta_i,
  input [FRAC_WIDTH:0] fractb_i,
  input signa_i,
  input signb_i,
  input start_i,
  output reg  [2*FRAC_WIDTH+1:0] fract_o,
  output reg  sign_o,
  output reg  ready_o) ; 
    
    
    
    
    
    
    
    
    
    
    
   reg [47:0] s_fract_o ;  
   reg [23:0] s_fracta_i ;  
   reg [23:0] s_fractb_i ;  
   reg s_signa_i,s_signb_i ;  
   wire s_sign_o ;  
   reg s_start_i ;  
   reg s_ready_o ;  
   reg s_state ;  
   reg [4:0] s_count ;  
   wire [23:0] s_tem_prod ;  
  always @( posedge clk_i)
       begin 
         s_fracta_i <=fracta_i;
         s_fractb_i <=fractb_i;
         s_signa_i <=signa_i;
         s_signb_i <=signb_i;
         s_start_i <=start_i;
       end
  
  always @( posedge clk_i)
       begin 
         fract_o <=s_fract_o;
         sign_o <=s_sign_o;
         ready_o <=s_ready_o;
       end
  
  assign s_sign_o=signa_i^signb_i; 
  always @( posedge clk_i)
       if (s_start_i)
          begin 
            s_state <=t_state_busy;
            s_count <=0;
          end 
        else 
          if (s_count==23)
             begin 
               s_state <=t_state_waiting;
               s_ready_o <=1;
               s_count <=0;
             end 
           else 
             if (s_state==t_state_busy)
                s_count <=s_count+1;
              else 
                begin 
                  s_state <=t_state_waiting;
                  s_ready_o <=0;
                end
  
  assign s_tem_prod[0]=s_fracta_i[0]&s_fractb_i[s_count]; 
  assign s_tem_prod[1]=s_fracta_i[1]&s_fractb_i[s_count]; 
  assign s_tem_prod[2]=s_fracta_i[2]&s_fractb_i[s_count]; 
  assign s_tem_prod[3]=s_fracta_i[3]&s_fractb_i[s_count]; 
  assign s_tem_prod[4]=s_fracta_i[4]&s_fractb_i[s_count]; 
  assign s_tem_prod[5]=s_fracta_i[5]&s_fractb_i[s_count]; 
  assign s_tem_prod[6]=s_fracta_i[6]&s_fractb_i[s_count]; 
  assign s_tem_prod[7]=s_fracta_i[7]&s_fractb_i[s_count]; 
  assign s_tem_prod[8]=s_fracta_i[8]&s_fractb_i[s_count]; 
  assign s_tem_prod[9]=s_fracta_i[9]&s_fractb_i[s_count]; 
  assign s_tem_prod[10]=s_fracta_i[10]&s_fractb_i[s_count]; 
  assign s_tem_prod[11]=s_fracta_i[11]&s_fractb_i[s_count]; 
  assign s_tem_prod[12]=s_fracta_i[12]&s_fractb_i[s_count]; 
  assign s_tem_prod[13]=s_fracta_i[13]&s_fractb_i[s_count]; 
  assign s_tem_prod[14]=s_fracta_i[14]&s_fractb_i[s_count]; 
  assign s_tem_prod[15]=s_fracta_i[15]&s_fractb_i[s_count]; 
  assign s_tem_prod[16]=s_fracta_i[16]&s_fractb_i[s_count]; 
  assign s_tem_prod[17]=s_fracta_i[17]&s_fractb_i[s_count]; 
  assign s_tem_prod[18]=s_fracta_i[18]&s_fractb_i[s_count]; 
  assign s_tem_prod[19]=s_fracta_i[19]&s_fractb_i[s_count]; 
  assign s_tem_prod[20]=s_fracta_i[20]&s_fractb_i[s_count]; 
  assign s_tem_prod[21]=s_fracta_i[21]&s_fractb_i[s_count]; 
  assign s_tem_prod[22]=s_fracta_i[22]&s_fractb_i[s_count]; 
  assign s_tem_prod[23]=s_fracta_i[23]&s_fractb_i[s_count]; 
   wire [47:0] v_prod_shl ;  
  assign v_prod_shl={24'd0,s_tem_prod}<<s_count[4:0]; 
  always @( posedge clk_i)
       if (s_state==t_state_busy)
          begin 
            if (|s_count)
               s_fract_o <=v_prod_shl+s_fract_o;
             else 
               s_fract_o <=v_prod_shl;
          end
  
endmodule
 
module or1200_tpram_32x32 #(
 parameter aw =5,
 parameter dw =32) (
  input clk_a,
  input rst_a,
  input ce_a,
  input we_a,
  input oe_a,
  input [aw-1:0] addr_a,
  input [dw-1:0] di_a,
  output [dw-1:0] do_a,
  input clk_b,
  input rst_b,
  input ce_b,
  input we_b,
  input oe_b,
  input [aw-1:0] addr_b,
  input [dw-1:0] di_b,
  output [dw-1:0] do_b) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_a_reg ;  
   reg [aw-1:0] addr_b_reg ;  
  assign do_a=(oe_a) ? mem[addr_a_reg]:{dw{1'b0}}; 
  assign do_b=(oe_b) ? mem[addr_b_reg]:{dw{1'b0}}; 
  always @( posedge clk_a)
       if (ce_a&&we_a)
          mem [addr_a]<=di_a;
 
  always @( posedge clk_b)
       if (ce_b&&we_b)
          mem [addr_b]<=di_b;
 
  always @(  posedge clk_a or  posedge rst_a)
       if (rst_a==(1'b1))
          addr_a_reg <={aw{1'b0}};
        else 
          if (ce_a)
             addr_a_reg <=addr_a;
 
  always @(  posedge clk_b or  posedge rst_b)
       if (rst_b==(1'b1))
          addr_b_reg <={aw{1'b0}};
        else 
          if (ce_b)
             addr_b_reg <=addr_b;
 
endmodule
 
module or1200_ic_ram #(
 parameter dw =32,
 parameter aw =13-2) (
  input clk,
  input rst,
  input [aw-1:0] addr,
  input en,
  input [3:0] we,
  input [dw-1:0] datain,
  output [dw-1:0] dataout) ; 
    
    
  or1200_spram #(.aw(13-2),.dw(32))ic_ram0(.clk(clk),.ce(en),.we(we[0]),.addr(addr),.di(datain),.doq(dataout)); 
endmodule
 
module or1200_spram_512x20 #(
 parameter aw =9,
 parameter dw =20) (
  input clk,
  input rst,
  input ce,
  input we,
  input oe,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq=(oe) ? mem[addr_reg]:{dw{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <={aw{1'b0}};
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we)
          mem [addr]<=di;
 
endmodule
 
module or1200_fpu_intfloat_conv #(
 parameter INF =31'h7f800000,
 parameter QNAN =31'h7fc00001,
 parameter SNAN =31'h7f800001) (
  input clk,
  input [1:0] rmode,
  input [2:0] fpu_op,
  input [31:0] opa,
  output reg  [31:0] out,
  output reg  snan,
  output reg  ine,
  output inv,
  output overflow,
  output underflow,
  output reg  zero) ; 
    
    
    
   reg [31:0] opa_r ;  
   reg div_by_zero ;  
   wire [7:0] exp_fasu ;  
   reg [7:0] exp_r ;  
   wire co ;  
   wire [30:0] out_d ;  
   wire overflow_d ;  
   wire underflow_d ;  
   reg inf ;  
   reg qnan ;  
   reg [1:0] rmode_r1 ;  
   reg [1:0] rmode_r2 ;  
   reg [1:0] rmode_r3 ;  
   reg [2:0] fpu_op_r1 ;  
   reg [2:0] fpu_op_r2 ;  
   reg [2:0] fpu_op_r3 ;  
  always @( posedge clk)
       opa_r <=opa;
 
  always @( posedge clk)
       rmode_r1 <=rmode;
 
  always @( posedge clk)
       rmode_r2 <=rmode_r1;
 
  always @( posedge clk)
       rmode_r3 <=rmode_r2;
 
  always @( posedge clk)
       fpu_op_r1 <=fpu_op;
 
  always @( posedge clk)
       fpu_op_r2 <=fpu_op_r1;
 
  always @( posedge clk)
       fpu_op_r3 <=fpu_op_r2;
 
   wire inf_d,ind_d,qnan_d,snan_d,opa_nan ;  
   wire opa_00 ;  
   wire opa_inf ;  
   wire opa_dn ;  
  or1200_fpu_intfloat_conv_except u0(.clk(clk),.opa(opa_r),.opb(),.inf(inf_d),.ind(ind_d),.qnan(qnan_d),.snan(snan_d),.opa_nan(opa_nan),.opb_nan(),.opa_00(opa_00),.opb_00(),.opa_inf(opa_inf),.opb_inf(),.opa_dn(opa_dn),.opb_dn()); 
   wire nan_sign_d,result_zero_sign_d ;  
   reg sign_fasu_r ;  
   wire [1:0] exp_ovf ;  
   reg [1:0] exp_ovf_r ;  
   reg opa_sign_r ;  
  always @( posedge clk)
       opa_sign_r <=opa_r[31];
 
  always @( posedge clk)
       sign_fasu_r <=opa_sign_r;
 
   wire ine_d ;  
   wire inv_d ;  
   wire sign_d ;  
   reg sign ;  
   reg [30:0] opa_r1 ;  
   reg [47:0] fract_i2f ;  
   reg opas_r1,opas_r2 ;  
   wire f2i_out_sign ;  
   wire [47:0] fract_denorm ;  
  always @( posedge clk)
       case (fpu_op_r2)
        5 :
           exp_r <=opa_r1[30:23];
        default :
           exp_r <=0;
       endcase
  
  always @( posedge clk)
       opa_r1 <=opa_r[30:0];
 
  always @( posedge clk)
       fract_i2f <=(fpu_op_r2==5) ? (sign_d ? 1-{24'h00,(|opa_r1[30:23]),opa_r1[22:0]}-1:{24'h0,(|opa_r1[30:23]),opa_r1[22:0]}):(sign_d ? 1-{opa_r1,17'h01}:{opa_r1,17'h0});
 
  assign fract_denorm=fract_i2f; 
  always @( posedge clk)
       opas_r1 <=opa_r[31];
 
  always @( posedge clk)
       opas_r2 <=opas_r1;
 
  assign sign_d=opa_sign_r; 
  always @( posedge clk)
       sign <=(rmode_r2==2'h3) ? !sign_d:sign_d;
 
   wire f2i_special_case_no_inv ;  
  assign f2i_special_case_no_inv=(opa==32'hcf000000); 
  or1200_fpu_post_norm_intfloat_conv u4(.clk(clk),.fpu_op(fpu_op_r3),.opas(opas_r2),.sign(sign),.rmode(rmode_r3),.fract_in(fract_denorm),.exp_in(exp_r),.opa_dn(opa_dn),.opa_nan(opa_nan),.opa_inf(opa_inf),.opb_dn(),.out(out_d),.ine(ine_d),.inv(inv_d),.overflow(overflow_d),.underflow(underflow_d),.f2i_out_sign(f2i_out_sign)); 
   reg fasu_op_r1,fasu_op_r2 ;  
   wire [30:0] out_fixed ;  
   wire output_zero_fasu ;  
   wire overflow_fasu ;  
   wire out_d_00 ;  
   wire ine_fasu ;  
   wire underflow_fasu ;  
  assign out_fixed=((qnan_d|snan_d)|(ind_d)) ? QNAN:INF; 
  always @( posedge clk)
       out [30:0]<=out_d;
 
  assign out_d_00=!(|out_d); 
  always @( posedge clk)
       out [31]<=(fpu_op_r3==3'b101) ? f2i_out_sign:sign_fasu_r;
 
  assign ine_fasu=(ine_d|overflow_d|underflow_d)&!(snan_d|qnan_d|inf_d); 
  always @( posedge clk)
       ine <=fpu_op_r3[2] ? ine_d:ine_fasu;
 
  assign overflow=overflow_d&!(snan_d|qnan_d|inf_d); 
  assign underflow=underflow_d&!(inf_d|snan_d|qnan_d); 
  always @( posedge clk)
       snan <=snan_d&(fpu_op_r3==3'b101);
 
  assign output_zero_fasu=out_d_00&!(inf_d|snan_d|qnan_d); 
  always @( posedge clk)
       zero <=fpu_op_r3==3'b101 ? out_d_00&!(snan_d|qnan_d):output_zero_fasu;
 
  assign inv=inv_d&!f2i_special_case_no_inv; 
endmodule
 
module or1200_fpu_div #(
 parameter FP_WIDTH =32,
 parameter MUL_SERIAL =0,
 parameter MUL_COUNT =11,
 parameter FRAC_WIDTH =23,
 parameter EXP_WIDTH =8,
 parameter ZERO_VECTOR =31'd0,
 parameter INF =31'b1111111100000000000000000000000,
 parameter QNAN =31'b1111111110000000000000000000000,
 parameter SNAN =31'b1111111100000000000000000000001,
 parameter t_state_waiting =1'b0,
 parameter t_state_busy =1'b1) (
  input clk_i,
  input [2*(FRAC_WIDTH+2)-1:0] dvdnd_i,
  input [FRAC_WIDTH+3:0] dvsor_i,
  input sign_dvd_i,
  input sign_div_i,
  input start_i,
  output ready_o,
  output [FRAC_WIDTH+3:0] qutnt_o,
  output [FRAC_WIDTH+3:0] rmndr_o,
  output sign_o,
  output div_zero_o) ; 
    
    
    
    
    
    
    
    
    
    
    
   reg [FRAC_WIDTH+3:0] s_qutnt_o ;  
   reg [FRAC_WIDTH+3:0] s_rmndr_o ;  
   reg [2*(FRAC_WIDTH+2)-1:0] s_dvdnd_i ;  
   reg [FRAC_WIDTH+3:0] s_dvsor_i ;  
   reg s_sign_dvd_i,s_sign_div_i ;  
   wire s_sign_o ;  
   wire s_div_zero_o ;  
   reg s_start_i ;  
   reg s_ready_o ;  
   reg s_state ;  
   reg [4:0] s_count ;  
   reg [FRAC_WIDTH+3:0] s_dvd ;  
  always @( posedge clk_i)
       begin 
         s_dvdnd_i <=dvdnd_i;
         s_dvsor_i <=dvsor_i;
         s_sign_dvd_i <=sign_dvd_i;
         s_sign_div_i <=sign_div_i;
         s_start_i <=start_i;
       end
  
  assign qutnt_o=s_qutnt_o; 
  assign rmndr_o=s_rmndr_o; 
  assign sign_o=s_sign_o; 
  assign ready_o=s_ready_o; 
  assign div_zero_o=s_div_zero_o; 
  assign s_sign_o=sign_dvd_i^sign_div_i; 
  assign s_div_zero_o=!(|s_dvsor_i)&(|s_dvdnd_i); 
  always @( posedge clk_i)
       if (s_start_i)
          begin 
            s_state <=t_state_busy;
            s_count <=26;
          end 
        else 
          if (!(|s_count)&s_state==t_state_busy)
             begin 
               s_state <=t_state_waiting;
               s_ready_o <=1;
               s_count <=26;
             end 
           else 
             if (s_state==t_state_busy)
                s_count <=s_count-1;
              else 
                begin 
                  s_state <=t_state_waiting;
                  s_ready_o <=0;
                end
  
   wire [26:0] v_div ;  
  assign v_div=(s_count==26) ? {3'd0,s_dvdnd_i[49:26]}:s_dvd; 
   wire [26:0] v_div_minus_s_dvsor_i ;  
  assign v_div_minus_s_dvsor_i=v_div-s_dvsor_i; 
  always @( posedge clk_i)
       begin 
         if (s_start_i)
            begin 
              s_qutnt_o <=0;
              s_rmndr_o <=0;
            end 
          else 
            if (s_state==t_state_busy)
               begin 
                 if (v_div<s_dvsor_i)
                    begin 
                      s_qutnt_o [s_count]<=1'b0;
                      s_dvd <={v_div[25:0],1'b0};
                    end 
                  else 
                    begin 
                      s_qutnt_o [s_count]<=1'b1;
                      s_dvd <={v_div_minus_s_dvsor_i[25:0],1'b0};
                    end 
                 s_rmndr_o <=v_div;
               end 
       end
  
endmodule
 
module or1200_dc_tag #(
 parameter dw =20+1,
 parameter aw =13-4) (
  input clk,
  input rst,
  input [aw-1:0] addr,
  input en,
  input we,
  input [dw-1:0] datain,
  output tag_v,
  output [dw-3:0] tag,
  output dirty) ; 
    
    
  or1200_spram #(.aw(13-4),.dw(20+1))dc_tag0(.clk(clk),.ce(en),.we(we),.addr(addr),.di(datain),.doq({tag,tag_v,dirty})); 
endmodule
 
module or1200_dmmu_top #(
 parameter dw =32,
 parameter aw =32) (
  input clk,
  input rst,
  input dc_en,
  input dmmu_en,
  input supv,
  input [aw-1:0] dcpu_adr_i,
  input dcpu_cycstb_i,
  input dcpu_we_i,
  output [3:0] dcpu_tag_o,
  output dcpu_err_o,
  input spr_cs,
  input spr_write,
  input [aw-1:0] spr_addr,
  input [31:0] spr_dat_i,
  output [31:0] spr_dat_o,
  input qmemdmmu_err_i,
  input [3:0] qmemdmmu_tag_i,
  output [aw-1:0] qmemdmmu_adr_o,
  output qmemdmmu_cycstb_o,
  output qmemdmmu_ci_o) ; 
    
    
   wire dtlb_spr_access ;  
   wire [31:13] dtlb_ppn ;  
   wire dtlb_hit ;  
   wire dtlb_uwe ;  
   wire dtlb_ure ;  
   wire dtlb_swe ;  
   wire dtlb_sre ;  
   wire [31:0] dtlb_dat_o ;  
   wire dtlb_en ;  
   wire dtlb_ci ;  
   wire fault ;  
   wire miss ;  
   reg dtlb_done ;  
   reg [31:13] dcpu_vpn_r ;  
  assign dtlb_spr_access=spr_cs; 
  assign dcpu_tag_o=miss ? 4'hd:fault ? 4'hc:qmemdmmu_tag_i; 
  assign dcpu_err_o=miss|fault|qmemdmmu_err_i; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          dtlb_done <=1'b0;
        else 
          if (dtlb_en)
             dtlb_done <=dcpu_cycstb_i;
           else 
             dtlb_done <=1'b0;
 
  assign qmemdmmu_cycstb_o=(dc_en&dmmu_en) ? !(miss|fault)&dtlb_done&dcpu_cycstb_i:!(miss|fault)&dcpu_cycstb_i; 
  assign qmemdmmu_ci_o=dmmu_en ? dtlb_ci:dcpu_adr_i[31]; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          dcpu_vpn_r <={32-13{1'b0}};
        else 
          dcpu_vpn_r <=dcpu_adr_i[31:13];
 
  assign qmemdmmu_adr_o=dmmu_en ? {dtlb_ppn,dcpu_adr_i[13-1:0]}:dcpu_adr_i; 
  assign spr_dat_o=dtlb_spr_access ? dtlb_dat_o:32'h00000000; 
  assign fault=dtlb_done&((!dcpu_we_i&!supv&!dtlb_ure)||(!dcpu_we_i&supv&!dtlb_sre)||(dcpu_we_i&!supv&!dtlb_uwe)||(dcpu_we_i&supv&!dtlb_swe)); 
  assign miss=dtlb_done&!dtlb_hit; 
  assign dtlb_en=dmmu_en&dcpu_cycstb_i; 
  or1200_dmmu_tlb or1200_dmmu_tlb(.clk(clk),.rst(rst),.tlb_en(dtlb_en),.vaddr(dcpu_adr_i),.hit(dtlb_hit),.ppn(dtlb_ppn),.uwe(dtlb_uwe),.ure(dtlb_ure),.swe(dtlb_swe),.sre(dtlb_sre),.ci(dtlb_ci),.spr_cs(dtlb_spr_access),.spr_write(spr_write),.spr_addr(spr_addr),.spr_dat_i(spr_dat_i),.spr_dat_o(dtlb_dat_o)); 
endmodule
 
module or1200_fpu_post_norm_mul #(
 parameter FP_WIDTH =32,
 parameter MUL_SERIAL =0,
 parameter MUL_COUNT =11,
 parameter FRAC_WIDTH =23,
 parameter EXP_WIDTH =8,
 parameter ZERO_VECTOR =31'd0,
 parameter INF =31'b1111111100000000000000000000000,
 parameter QNAN =31'b1111111110000000000000000000000,
 parameter SNAN =31'b1111111100000000000000000000001) (
  input clk_i,
  input [FP_WIDTH-1:0] opa_i,
  input [FP_WIDTH-1:0] opb_i,
  input [EXP_WIDTH+1:0] exp_10_i,
  input [2*FRAC_WIDTH+1:0] fract_48_i,
  input sign_i,
  input [1:0] rmode_i,
  output reg  [FP_WIDTH-1:0] output_o,
  output reg  ine_o) ; 
    
    
    
    
    
    
    
    
    
   reg [EXP_WIDTH-1:0] s_expa ;  
   reg [EXP_WIDTH-1:0] s_expb ;  
   reg [EXP_WIDTH+1:0] s_exp_10_i ;  
   reg [2*FRAC_WIDTH+1:0] s_fract_48_i ;  
   reg s_sign_i ;  
   wire [FP_WIDTH-1:0] s_output_o ;  
   wire s_ine_o ;  
   wire s_overflow ;  
   reg [FP_WIDTH-1:0] s_opa_i ;  
   reg [FP_WIDTH-1:0] s_opb_i ;  
   reg [1:0] s_rmode_i ;  
   reg [5:0] s_zeros ;  
   wire s_carry ;  
   reg [5:0] s_shr2 ;  
   reg [5:0] s_shl2 ;  
   reg [8:0] s_expo1 ;  
   wire [8:0] s_expo2b ;  
   wire [9:0] s_exp_10a ;  
   wire [9:0] s_exp_10b ;  
   reg [47:0] s_frac2a ;  
   wire s_sticky,s_guard,s_round ;  
   wire s_roundup ;  
   reg [24:0] s_frac_rnd ;  
   wire [24:0] s_frac3 ;  
   wire s_shr3 ;  
   reg [5:0] s_r_zeros ;  
   wire s_lost ;  
   wire s_op_0 ;  
   wire [8:0] s_expo3 ;  
   wire s_infa,s_infb ;  
   wire s_nan_in,s_nan_op,s_nan_a,s_nan_b ;  
  always @( posedge clk_i)
       begin 
         s_opa_i <=opa_i;
         s_opb_i <=opb_i;
         s_expa <=opa_i[30:23];
         s_expb <=opb_i[30:23];
         s_exp_10_i <=exp_10_i;
         s_fract_48_i <=fract_48_i;
         s_sign_i <=sign_i;
         s_rmode_i <=rmode_i;
       end
  
  always @( posedge clk_i)
       begin 
         output_o <=s_output_o;
         ine_o <=s_ine_o;
       end
  
  assign s_carry=s_fract_48_i[47]; 
  always @( posedge clk_i)
       if (!s_fract_48_i[47])
          casez (s_fract_48_i[46:1])
           46 'b1?????????????????????????????????????????????:
              s_zeros <=0;
           46 'b01????????????????????????????????????????????:
              s_zeros <=1;
           46 'b001???????????????????????????????????????????:
              s_zeros <=2;
           46 'b0001??????????????????????????????????????????:
              s_zeros <=3;
           46 'b00001?????????????????????????????????????????:
              s_zeros <=4;
           46 'b000001????????????????????????????????????????:
              s_zeros <=5;
           46 'b0000001???????????????????????????????????????:
              s_zeros <=6;
           46 'b00000001??????????????????????????????????????:
              s_zeros <=7;
           46 'b000000001?????????????????????????????????????:
              s_zeros <=8;
           46 'b0000000001????????????????????????????????????:
              s_zeros <=9;
           46 'b00000000001???????????????????????????????????:
              s_zeros <=10;
           46 'b000000000001??????????????????????????????????:
              s_zeros <=11;
           46 'b0000000000001?????????????????????????????????:
              s_zeros <=12;
           46 'b00000000000001????????????????????????????????:
              s_zeros <=13;
           46 'b000000000000001???????????????????????????????:
              s_zeros <=14;
           46 'b0000000000000001??????????????????????????????:
              s_zeros <=15;
           46 'b00000000000000001?????????????????????????????:
              s_zeros <=16;
           46 'b000000000000000001????????????????????????????:
              s_zeros <=17;
           46 'b0000000000000000001???????????????????????????:
              s_zeros <=18;
           46 'b00000000000000000001??????????????????????????:
              s_zeros <=19;
           46 'b000000000000000000001?????????????????????????:
              s_zeros <=20;
           46 'b0000000000000000000001????????????????????????:
              s_zeros <=21;
           46 'b00000000000000000000001???????????????????????:
              s_zeros <=22;
           46 'b000000000000000000000001??????????????????????:
              s_zeros <=23;
           46 'b0000000000000000000000001?????????????????????:
              s_zeros <=24;
           46 'b00000000000000000000000001????????????????????:
              s_zeros <=25;
           46 'b000000000000000000000000001???????????????????:
              s_zeros <=26;
           46 'b0000000000000000000000000001??????????????????:
              s_zeros <=27;
           46 'b00000000000000000000000000001?????????????????:
              s_zeros <=28;
           46 'b000000000000000000000000000001????????????????:
              s_zeros <=29;
           46 'b0000000000000000000000000000001???????????????:
              s_zeros <=30;
           46 'b00000000000000000000000000000001??????????????:
              s_zeros <=31;
           46 'b000000000000000000000000000000001?????????????:
              s_zeros <=32;
           46 'b0000000000000000000000000000000001????????????:
              s_zeros <=33;
           46 'b00000000000000000000000000000000001???????????:
              s_zeros <=34;
           46 'b000000000000000000000000000000000001??????????:
              s_zeros <=35;
           46 'b0000000000000000000000000000000000001?????????:
              s_zeros <=36;
           46 'b00000000000000000000000000000000000001????????:
              s_zeros <=37;
           46 'b000000000000000000000000000000000000001???????:
              s_zeros <=38;
           46 'b0000000000000000000000000000000000000001??????:
              s_zeros <=39;
           46 'b00000000000000000000000000000000000000001?????:
              s_zeros <=40;
           46 'b000000000000000000000000000000000000000001????:
              s_zeros <=41;
           46 'b0000000000000000000000000000000000000000001???:
              s_zeros <=42;
           46 'b00000000000000000000000000000000000000000001??:
              s_zeros <=43;
           46 'b000000000000000000000000000000000000000000001?:
              s_zeros <=44;
           46 'b0000000000000000000000000000000000000000000001:
              s_zeros <=45;
           46 'b0000000000000000000000000000000000000000000000:
              s_zeros <=46;
          endcase 
        else 
          s_zeros <=0;
 
  always @( posedge clk_i)
       casez (s_fract_48_i)
        48 'b???????????????????????????????????????????????1:
           s_r_zeros <=0;
        48 'b??????????????????????????????????????????????10:
           s_r_zeros <=1;
        48 'b?????????????????????????????????????????????100:
           s_r_zeros <=2;
        48 'b????????????????????????????????????????????1000:
           s_r_zeros <=3;
        48 'b???????????????????????????????????????????10000:
           s_r_zeros <=4;
        48 'b??????????????????????????????????????????100000:
           s_r_zeros <=5;
        48 'b?????????????????????????????????????????1000000:
           s_r_zeros <=6;
        48 'b????????????????????????????????????????10000000:
           s_r_zeros <=7;
        48 'b???????????????????????????????????????100000000:
           s_r_zeros <=8;
        48 'b??????????????????????????????????????1000000000:
           s_r_zeros <=9;
        48 'b?????????????????????????????????????10000000000:
           s_r_zeros <=10;
        48 'b????????????????????????????????????100000000000:
           s_r_zeros <=11;
        48 'b???????????????????????????????????1000000000000:
           s_r_zeros <=12;
        48 'b??????????????????????????????????10000000000000:
           s_r_zeros <=13;
        48 'b?????????????????????????????????100000000000000:
           s_r_zeros <=14;
        48 'b????????????????????????????????1000000000000000:
           s_r_zeros <=15;
        48 'b???????????????????????????????10000000000000000:
           s_r_zeros <=16;
        48 'b??????????????????????????????100000000000000000:
           s_r_zeros <=17;
        48 'b?????????????????????????????1000000000000000000:
           s_r_zeros <=18;
        48 'b????????????????????????????10000000000000000000:
           s_r_zeros <=19;
        48 'b???????????????????????????100000000000000000000:
           s_r_zeros <=20;
        48 'b??????????????????????????1000000000000000000000:
           s_r_zeros <=21;
        48 'b?????????????????????????10000000000000000000000:
           s_r_zeros <=22;
        48 'b????????????????????????100000000000000000000000:
           s_r_zeros <=23;
        48 'b???????????????????????1000000000000000000000000:
           s_r_zeros <=24;
        48 'b??????????????????????10000000000000000000000000:
           s_r_zeros <=25;
        48 'b?????????????????????100000000000000000000000000:
           s_r_zeros <=26;
        48 'b????????????????????1000000000000000000000000000:
           s_r_zeros <=27;
        48 'b???????????????????10000000000000000000000000000:
           s_r_zeros <=28;
        48 'b??????????????????100000000000000000000000000000:
           s_r_zeros <=29;
        48 'b?????????????????1000000000000000000000000000000:
           s_r_zeros <=30;
        48 'b????????????????10000000000000000000000000000000:
           s_r_zeros <=31;
        48 'b???????????????100000000000000000000000000000000:
           s_r_zeros <=32;
        48 'b??????????????1000000000000000000000000000000000:
           s_r_zeros <=33;
        48 'b?????????????10000000000000000000000000000000000:
           s_r_zeros <=34;
        48 'b????????????100000000000000000000000000000000000:
           s_r_zeros <=35;
        48 'b???????????1000000000000000000000000000000000000:
           s_r_zeros <=36;
        48 'b??????????10000000000000000000000000000000000000:
           s_r_zeros <=37;
        48 'b?????????100000000000000000000000000000000000000:
           s_r_zeros <=38;
        48 'b????????1000000000000000000000000000000000000000:
           s_r_zeros <=39;
        48 'b???????10000000000000000000000000000000000000000:
           s_r_zeros <=40;
        48 'b??????100000000000000000000000000000000000000000:
           s_r_zeros <=41;
        48 'b?????1000000000000000000000000000000000000000000:
           s_r_zeros <=42;
        48 'b????10000000000000000000000000000000000000000000:
           s_r_zeros <=43;
        48 'b???100000000000000000000000000000000000000000000:
           s_r_zeros <=44;
        48 'b??1000000000000000000000000000000000000000000000:
           s_r_zeros <=45;
        48 'b?10000000000000000000000000000000000000000000000:
           s_r_zeros <=46;
        48 'b100000000000000000000000000000000000000000000000:
           s_r_zeros <=47;
        48 'b000000000000000000000000000000000000000000000000:
           s_r_zeros <=48;
       endcase
  
  assign s_exp_10a=s_exp_10_i+{9'd0,s_carry}; 
  assign s_exp_10b=s_exp_10a-{4'd0,s_zeros}; 
   wire [9:0] v_shr1 ;  
   wire [9:0] v_shl1 ;  
  assign v_shr1=(s_exp_10a[9]|!(|s_exp_10a)) ? 10'd1-s_exp_10a+{9'd0,s_carry}:(s_exp_10b[9]|!(|s_exp_10b)) ? 0:s_exp_10b[8] ? 0:{9'd0,s_carry}; 
  assign v_shl1=(s_exp_10a[9]|!(|s_exp_10a)) ? 0:(s_exp_10b[9]|!(|s_exp_10b)) ? {4'd0,s_zeros}-s_exp_10a:s_exp_10b[8] ? 0:{4'd0,s_zeros}; 
  always @( posedge clk_i)
       begin 
         if ((s_exp_10a[9]|!(|s_exp_10a)))
            s_expo1 <=9'd1;
          else 
            if (s_exp_10b[9]|!(|s_exp_10b))
               s_expo1 <=9'd1;
             else 
               if (s_exp_10b[8])
                  s_expo1 <=9'b011111111;
                else 
                  s_expo1 <=s_exp_10b[8:0];
         if (v_shr1[6])
            s_shr2 <={6{1'b1}};
          else 
            s_shr2 <=v_shr1[5:0];
         s_shl2 <=v_shl1[5:0];
       end
  
  always @( posedge clk_i)
       if (|s_shr2)
          s_frac2a <=s_fract_48_i>>s_shr2;
        else 
          s_frac2a <=s_fract_48_i<<s_shl2;
 
  assign s_expo2b=s_frac2a[46] ? s_expo1:s_expo1-9'd1; 
  assign s_lost=(s_shr2+{5'd0,s_shr3})>s_r_zeros; 
  assign s_guard=s_frac2a[22]; 
  assign s_round=s_frac2a[21]; 
  assign s_sticky=(|s_frac2a[20:0])|s_lost; 
  assign s_roundup=s_rmode_i==2'b00 ? s_guard&((s_round|s_sticky)|s_frac2a[23]):s_rmode_i==2'b10 ? (s_guard|s_round|s_sticky)&!s_sign_i:s_rmode_i==2'b11 ? (s_guard|s_round|s_sticky)&s_sign_i:0; 
  always @( posedge clk_i)
       if (s_roundup)
          s_frac_rnd <=s_frac2a[47:23]+1;
        else 
          s_frac_rnd <=s_frac2a[47:23];
 
  assign s_shr3=s_frac_rnd[24]; 
  assign s_expo3=(s_shr3&(s_expo2b!=9'b011111111)) ? s_expo2b+1:s_expo2b; 
  assign s_frac3=(s_shr3&(s_expo2b!=9'b011111111)) ? {1'b0,s_frac_rnd[24:1]}:s_frac_rnd; 
  assign s_op_0=!((|s_opa_i[30:0])&(|s_opb_i[30:0])); 
  assign s_infa=&s_expa; 
  assign s_infb=&s_expb; 
  assign s_nan_a=s_infa&(|s_opa_i[22:0]); 
  assign s_nan_b=s_infb&(|s_opb_i[22:0]); 
  assign s_nan_in=s_nan_a|s_nan_b; 
  assign s_nan_op=(s_infa|s_infb)&s_op_0; 
  assign s_overflow=(s_expo3==9'b011111111)&!(s_infa|s_infb); 
  assign s_ine_o=!s_op_0&(s_lost|(|s_frac2a[22:0])|s_overflow); 
  assign s_output_o=(s_nan_in|s_nan_op) ? {s_sign_i,QNAN}:(s_infa|s_infb)|s_overflow ? {s_sign_i,INF}:s_r_zeros==48 ? {s_sign_i,ZERO_VECTOR}:{s_sign_i,s_expo3[7:0],s_frac3[22:0]}; 
endmodule
 
module or1200_spram_2048x32_bw (
  input clk,
  input rst,
  input ce,
  input [3:0] we,
  input oe,
  input [10:0] addr,
  input [31:0] di,
  output [31:0] doq) ; 
   reg [7:0] mem_0[2047:0] ;  
   reg [7:0] mem_1[2047:0] ;  
   reg [7:0] mem_2[2047:0] ;  
   reg [7:0] mem_3[2047:0] ;  
   reg [10:0] addr_reg ;  
  assign doq=(oe) ? {mem_3[addr_reg],mem_2[addr_reg],mem_1[addr_reg],mem_0[addr_reg]}:{32{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <=11'h000;
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we[0])
          mem_0 [addr]<=di[7:0];
 
  always @( posedge clk)
       if (ce&&we[1])
          mem_1 [addr]<=di[15:8];
 
  always @( posedge clk)
       if (ce&&we[2])
          mem_2 [addr]<=di[23:16];
 
  always @( posedge clk)
       if (ce&&we[3])
          mem_3 [addr]<=di[31:24];
 
endmodule
 
module or1200_spram_256x21 #(
 parameter aw =8,
 parameter dw =21) (
  input clk,
  input rst,
  input ce,
  input we,
  input oe,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq=(oe) ? mem[addr_reg]:{dw{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <={aw{1'b0}};
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we)
          mem [addr]<=di;
 
endmodule
 
module or1200_except (
  input clk,
  input rst,
  input sig_ibuserr,
  input sig_dbuserr,
  input sig_illegal,
  input sig_align,
  input sig_range,
  input sig_dtlbmiss,
  input sig_dmmufault,
  input sig_int,
  input sig_syscall,
  input sig_trap,
  input sig_itlbmiss,
  input sig_immufault,
  input sig_tick,
  input ex_branch_taken,
  input genpc_freeze,
  input id_freeze,
  input ex_freeze,
  input wb_freeze,
  input if_stall,
  input [31:0] if_pc,
  output reg  [31:0] id_pc,
  output reg  [31:0] ex_pc,
  output reg  [31:0] wb_pc,
  input id_flushpipe,
  input ex_flushpipe,
  output reg  extend_flush,
  output except_flushpipe,
  output reg  [4-1:0] except_type,
  output except_start,
  output except_started,
  output [13:0] except_stop,
  output [13:0] except_trig,
  input ex_void,
  output abort_mvspr,
  input [3-1:0] branch_op,
  output [31:0] spr_dat_ppc,
  output [31:0] spr_dat_npc,
  input [31:0] datain,
  input [14-1:0] du_dsr,
  input epcr_we,
  input eear_we,
  input esr_we,
  input pc_we,
  output reg  [31:0] epcr,
  output reg  [31:0] eear,
  input [24:0] du_dmr1,
  input du_hwbkpt,
  input du_hwbkpt_ls_r,
  output reg  [17-1:0] esr,
  input sr_we,
  input [17-1:0] to_sr,
  input [17-1:0] sr,
  input [31:0] lsu_addr,
  output abort_ex,
  input icpu_ack_i,
  input icpu_err_i,
  input dcpu_ack_i,
  input dcpu_err_i,
  input sig_fp,
  input fpcsr_fpee,
  output reg  dsx) ; 
   reg id_pc_val ;  
   reg ex_pc_val ;  
   reg [31:0] dl_pc ;  
   reg [2:0] id_exceptflags ;  
   reg [2:0] ex_exceptflags ;  
   reg [3-1:0] state ;  
   reg extend_flush_last ;  
   reg ex_dslot ;  
   reg delayed1_ex_dslot ;  
   reg delayed2_ex_dslot ;  
   reg [2:0] delayed_iee ;  
   reg [2:0] delayed_tee ;  
   wire int_pending ;  
   wire tick_pending ;  
   wire fp_pending ;  
   wire range_pending ;  
   reg trace_trap ;  
   reg ex_freeze_prev ;  
   reg sr_ted_prev ;  
   reg dsr_te_prev ;  
   reg dmr1_st_prev ;  
   reg dmr1_bt_prev ;  
   wire dsr_te=ex_freeze_prev ? dsr_te_prev:du_dsr[13] ;  
   wire sr_ted=ex_freeze_prev ? sr_ted_prev:sr[16] ;  
   wire dmr1_st=ex_freeze_prev ? dmr1_st_prev:du_dmr1[22] ;  
   wire dmr1_bt=ex_freeze_prev ? dmr1_bt_prev:du_dmr1[23] ;  
  assign except_started=extend_flush&except_start; 
  assign except_start=(except_type!=4'h0)&extend_flush; 
  assign int_pending=sig_int&(sr[2]|(sr_we&to_sr[2]))&id_pc_val&delayed_iee[2]&~ex_freeze&~ex_branch_taken&~ex_dslot&~(sr_we&~to_sr[2]); 
  assign tick_pending=sig_tick&(sr[1]|(sr_we&to_sr[1]))&id_pc_val&delayed_tee[2]&~ex_freeze&~ex_branch_taken&~ex_dslot&~(sr_we&~to_sr[1]); 
  assign fp_pending=sig_fp&fpcsr_fpee&~ex_freeze&~ex_branch_taken&~ex_dslot; 
  assign range_pending=sig_range&sr[12]&~ex_freeze&~ex_branch_taken&~ex_dslot; 
  assign abort_ex=sig_dbuserr|sig_dmmufault|sig_dtlbmiss|sig_align|sig_illegal|((du_hwbkpt|trace_trap)&ex_pc_val&!sr_ted&!dsr_te); 
  assign abort_mvspr=sig_illegal|((du_hwbkpt|trace_trap)&ex_pc_val&!sr_ted&!dsr_te); 
  assign spr_dat_ppc=wb_pc; 
  assign spr_dat_npc=ex_void ? id_pc:ex_pc; 
  assign except_trig={ex_exceptflags[1]&~du_dsr[9],ex_exceptflags[0]&~du_dsr[3],ex_exceptflags[2]&~du_dsr[1],sig_illegal&~du_dsr[6],sig_align&~du_dsr[5],sig_dtlbmiss&~du_dsr[8],sig_trap&~du_dsr[13],sig_syscall&~du_dsr[11]&~ex_freeze,sig_dmmufault&~du_dsr[2],sig_dbuserr&~du_dsr[1],range_pending&~du_dsr[10],fp_pending&~du_dsr[12],int_pending&~du_dsr[7],tick_pending&~du_dsr[4]}; 
   wire trace_cond=!ex_freeze&&!ex_void&&(1'b0||dmr1_st||((branch_op!=3'd0)&&(branch_op!=3'd6)&&dmr1_bt)) ;  
  assign except_stop={tick_pending&du_dsr[4],int_pending&du_dsr[7],ex_exceptflags[1]&du_dsr[9],ex_exceptflags[0]&du_dsr[3],ex_exceptflags[2]&du_dsr[1],sig_illegal&du_dsr[6],sig_align&du_dsr[5],sig_dtlbmiss&du_dsr[8],sig_dmmufault&du_dsr[2],sig_dbuserr&du_dsr[1],range_pending&du_dsr[10],sig_trap&du_dsr[13],fp_pending&du_dsr[12],sig_syscall&du_dsr[11]&~ex_freeze}; 
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              trace_trap <=1'b0;
            end 
          else 
            if (!(trace_trap&&!ex_pc_val))
               begin 
                 trace_trap <=trace_cond&!dsr_te&!sr_ted;
               end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              ex_freeze_prev <=1'b0;
              sr_ted_prev <=1'b0;
              dsr_te_prev <=1'b0;
              dmr1_st_prev <=1'b0;
              dmr1_bt_prev <=1'b0;
            end 
          else 
            begin 
              ex_freeze_prev <=ex_freeze;
              if (!ex_freeze_prev||ex_void)
                 begin 
                   sr_ted_prev <=sr[16];
                   dsr_te_prev <=du_dsr[13];
                   dmr1_st_prev <=du_dmr1[22];
                   dmr1_bt_prev <=du_dmr1[23];
                 end 
            end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              id_pc <=32'd0;
              id_pc_val <=1'b0;
              id_exceptflags <=3'b000;
            end 
          else 
            if (id_flushpipe)
               begin 
                 id_pc_val <=1'b0;
                 id_exceptflags <=3'b000;
               end 
             else 
               if (!id_freeze)
                  begin 
                    id_pc <=if_pc;
                    id_pc_val <=1'b1;
                    id_exceptflags <={sig_ibuserr,sig_itlbmiss,sig_immufault};
                  end 
       end
  
  always @(  posedge rst or  posedge clk)
       if (rst==(1'b1))
          delayed_iee <=3'b000;
        else 
          if (!sr[2])
             delayed_iee <=3'b000;
           else 
             delayed_iee <={delayed_iee[1:0],1'b1};
 
  always @(  posedge rst or  posedge clk)
       if (rst==(1'b1))
          delayed_tee <=3'b000;
        else 
          if (!sr[1])
             delayed_tee <=3'b000;
           else 
             delayed_tee <={delayed_tee[1:0],1'b1};
 
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              ex_dslot <=1'b0;
              ex_pc <=32'd0;
              ex_pc_val <=1'b0;
              ex_exceptflags <=3'b000;
              delayed1_ex_dslot <=1'b0;
              delayed2_ex_dslot <=1'b0;
            end 
          else 
            if (ex_flushpipe)
               begin 
                 ex_dslot <=1'b0;
                 ex_pc_val <=1'b0;
                 ex_exceptflags <=3'b000;
                 delayed1_ex_dslot <=1'b0;
                 delayed2_ex_dslot <=1'b0;
               end 
             else 
               if (!ex_freeze&id_freeze)
                  begin 
                    ex_dslot <=1'b0;
                    ex_pc <=id_pc;
                    ex_pc_val <=id_pc_val;
                    ex_exceptflags <=3'b000;
                    delayed1_ex_dslot <=ex_dslot;
                    delayed2_ex_dslot <=delayed1_ex_dslot;
                  end 
                else 
                  if (!ex_freeze)
                     begin 
                       ex_dslot <=ex_branch_taken;
                       ex_pc <=id_pc;
                       ex_pc_val <=id_pc_val;
                       ex_exceptflags <=id_exceptflags;
                       delayed1_ex_dslot <=ex_dslot;
                       delayed2_ex_dslot <=delayed1_ex_dslot;
                     end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              wb_pc <=32'd0;
              dl_pc <=32'd0;
            end 
          else 
            if (!wb_freeze)
               begin 
                 wb_pc <=ex_pc;
                 dl_pc <=wb_pc;
               end 
       end
  
  assign except_flushpipe=|except_trig&~|state; 
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              state <=3'd0;
              except_type <=4'h0;
              extend_flush <=1'b0;
              epcr <=32'b0;
              eear <=32'b0;
              esr <={2'h1,{17-3{1'b0}},1'b1};
              extend_flush_last <=1'b0;
              dsx <=1'b0;
            end 
          else 
            begin 
              case (state)
               3 'd0:
                  if (except_flushpipe)
                     begin 
                       state <=3'd1;
                       extend_flush <=1'b1;
                       esr <=sr_we ? to_sr:sr;
                       casez (except_trig)
                        14 'b1?_????_????_????:
                           begin 
                             except_type <=4'ha;
                             eear <=ex_dslot ? ex_pc:ex_pc;
                             epcr <=ex_dslot ? wb_pc:ex_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b01_????_????_????:
                           begin 
                             except_type <=4'h4;
                             eear <=ex_dslot ? ex_pc:delayed1_ex_dslot ? id_pc:delayed2_ex_dslot ? id_pc:id_pc;
                             epcr <=ex_dslot ? wb_pc:delayed1_ex_dslot ? id_pc:delayed2_ex_dslot ? id_pc:id_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b00_1???_????_????:
                           begin 
                             except_type <=4'h2;
                             eear <=ex_dslot ? wb_pc:ex_pc;
                             epcr <=ex_dslot ? wb_pc:ex_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b00_01??_????_????:
                           begin 
                             except_type <=4'h7;
                             eear <=ex_pc;
                             epcr <=ex_dslot ? wb_pc:ex_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b00_001?_????_????:
                           begin 
                             except_type <=4'h6;
                             eear <=lsu_addr;
                             epcr <=ex_dslot ? wb_pc:ex_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b00_0001_????_????:
                           begin 
                             except_type <=4'h9;
                             eear <=lsu_addr;
                             epcr <=ex_dslot ? wb_pc:delayed1_ex_dslot ? dl_pc:ex_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b00_0000_1???_????:
                           begin 
                             except_type <=4'he;
                             epcr <=ex_dslot ? wb_pc:delayed1_ex_dslot ? id_pc:ex_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b00_0000_01??_????:
                           begin 
                             except_type <=4'hc;
                             epcr <=ex_dslot ? wb_pc:delayed1_ex_dslot ? id_pc:delayed2_ex_dslot ? id_pc:id_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b00_0000_001?_????:
                           begin 
                             except_type <=4'h3;
                             eear <=lsu_addr;
                             epcr <=ex_dslot ? wb_pc:delayed1_ex_dslot ? dl_pc:ex_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b00_0000_0001_????:
                           begin 
                             except_type <=4'h2;
                             eear <=lsu_addr;
                             epcr <=ex_dslot ? wb_pc:delayed1_ex_dslot ? dl_pc:ex_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b00_0000_0000_1???:
                           begin 
                             except_type <=4'hb;
                             epcr <=ex_dslot ? wb_pc:delayed1_ex_dslot ? dl_pc:delayed2_ex_dslot ? id_pc:ex_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b00_0000_0000_01??:
                           begin 
                             except_type <=4'hd;
                             epcr <=id_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b00_0000_0000_001?:
                           begin 
                             except_type <=4'h8;
                             epcr <=id_pc;
                             dsx <=ex_dslot;
                           end 
                        14 'b00_0000_0000_0001:
                           begin 
                             except_type <=4'h5;
                             epcr <=id_pc;
                             dsx <=ex_dslot;
                           end 
                        default :
                           except_type <=4'h0;
                       endcase 
                     end 
                   else 
                     if (pc_we)
                        begin 
                          state <=3'd1;
                          extend_flush <=1'b1;
                        end 
                      else 
                        begin 
                          if (epcr_we)
                             epcr <=datain;
                          if (eear_we)
                             eear <=datain;
                          if (esr_we)
                             esr <={datain[17-1],1'b1,datain[17-3:0]};
                        end 
               3 'd1:
                  if (icpu_ack_i|icpu_err_i|genpc_freeze)
                     state <=3'd2;
               3 'd2:
                  if (except_type==4'he)
                     begin 
                       state <=3'd0;
                       extend_flush <=1'b0;
                       extend_flush_last <=1'b0;
                       except_type <=4'h0;
                     end 
                   else 
                     state <=3'd3;
               3 'd3:
                  begin 
                    state <=3'd4;
                  end 
               3 'd4:
                  begin 
                    state <=3'd5;
                    extend_flush <=1'b0;
                    extend_flush_last <=1'b0;
                  end 
               default :
                  begin 
                    if (!if_stall&&!id_freeze)
                       begin 
                         state <=3'd0;
                         except_type <=4'h0;
                         extend_flush_last <=1'b0;
                       end 
                  end 
              endcase 
            end 
       end
  
endmodule
 
module or1200_gmultp2_32x32 (
  input [32-1:0] X,
  input [32-1:0] Y,
  input CLK,
  input RST,
  output [64-1:0] P) ; 
   reg [32-1:0] X_saved ;  
   reg [32-1:0] Y_saved ;  
   reg [64-1:0] p1 ;  
   integer xi ;  
   integer yi ;  
  always @( X_saved)
       xi =X_saved;
 
  always @( Y_saved)
       yi =Y_saved;
 
  always @(  posedge CLK or  posedge RST)
       if (RST==(1'b1))
          begin 
            X_saved <=32'b0;
            Y_saved <=32'b0;
          end 
        else 
          begin 
            X_saved <=X;
            Y_saved <=Y;
          end
  
  always @(  posedge CLK or  posedge RST)
       if (RST==(1'b1))
          p1 <=64'b0;
        else 
          p1 <=xi*yi;
 
  assign P=p1; 
endmodule
 
module or1200_ctrl (
  input clk,
  input rst,
  input except_flushpipe,
  input extend_flush,
  output if_flushpipe,
  output id_flushpipe,
  output ex_flushpipe,
  output wb_flushpipe,
  input id_freeze,
  input ex_freeze,
  input wb_freeze,
  input [31:0] if_insn,
  output reg  [31:0] id_insn,
  output reg  [31:0] ex_insn,
  input abort_mvspr,
  output reg  [3-1:0] id_branch_op,
  output reg  [3-1:0] ex_branch_op,
  input ex_branch_taken,
  input pc_we,
  output [5-1:0] rf_addra,
  output [5-1:0] rf_addrb,
  output rf_rda,
  output rf_rdb,
  output reg  [5-1:0] alu_op,
  output reg  [4-1:0] alu_op2,
  output [3-1:0] mac_op,
  output reg  [4-1:0] comp_op,
  output reg  [5-1:0] rf_addrw,
  output reg  [4-1:0] rfwb_op,
  output [8-1:0] fpu_op,
  output reg  [31:0] wb_insn,
  output reg  [31:0] id_simm,
  output reg  [31:0] ex_simm,
  output [31:2] id_branch_addrtarget,
  output reg  [31:2] ex_branch_addrtarget,
  output reg  [2-1:0] sel_a,
  output reg  [2-1:0] sel_b,
  output reg  [4-1:0] id_lsu_op,
  output [4:0] cust5_op,
  output [5:0] cust5_limm,
  input [31:0] id_pc,
  input [31:0] ex_pc,
  input du_hwbkpt,
  output reg  [3-1:0] multicycle,
  output reg  [2-1:0] wait_on,
  input wbforw_valid,
  output reg  sig_syscall,
  output reg  sig_trap,
  output force_dslot_fetch,
  output no_more_dslot,
  output id_void,
  output ex_void,
  output ex_spr_read,
  output ex_spr_write,
  input du_flush_pipe,
  output [3-1:0] id_mac_op,
  output id_macrc_op,
  output ex_macrc_op,
  output rfe,
  output reg  except_illegal,
  output dc_no_writethrough) ; 
   wire if_maci_op ;  
   reg [5-1:0] wb_rfaddrw ;  
   reg sel_imm ;  
   wire wb_void ;  
   reg ex_delayslot_dsi ;  
   reg ex_delayslot_nop ;  
   reg spr_read ;  
   reg spr_write ;  
  assign rf_addra=if_insn[20:16]; 
  assign rf_addrb=if_insn[15:11]; 
  assign rf_rda=if_insn[31]||if_maci_op; 
  assign rf_rdb=if_insn[30]; 
  assign force_dslot_fetch=1'b0; 
  assign no_more_dslot=(|ex_branch_op&!id_void&ex_branch_taken)|(ex_branch_op==3'd6); 
  assign id_void=(id_insn[31:26]==6'b000101)&id_insn[16]; 
  assign ex_void=(ex_insn[31:26]==6'b000101)&ex_insn[16]; 
  assign wb_void=(wb_insn[31:26]==6'b000101)&wb_insn[16]; 
  assign ex_spr_write=spr_write&&!abort_mvspr; 
  assign ex_spr_read=spr_read&&!abort_mvspr; 
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              ex_delayslot_nop <=1'b0;
              ex_delayslot_dsi <=1'b0;
            end 
          else 
            if (!ex_freeze&!ex_delayslot_dsi&ex_delayslot_nop)
               begin 
                 ex_delayslot_nop <=id_void;
                 ex_delayslot_dsi <=!id_void;
               end 
             else 
               if (!ex_freeze&ex_delayslot_dsi&!ex_delayslot_nop)
                  begin 
                    ex_delayslot_nop <=1'b0;
                    ex_delayslot_dsi <=1'b0;
                  end 
                else 
                  if (!ex_freeze)
                     begin 
                       ex_delayslot_nop <=id_void&&ex_branch_taken&&(ex_branch_op!=3'd0)&&(ex_branch_op!=3'd6);
                       ex_delayslot_dsi <=!id_void&&ex_branch_taken&&(ex_branch_op!=3'd0)&&(ex_branch_op!=3'd6);
                     end 
       end
  
  assign if_flushpipe=except_flushpipe|pc_we|extend_flush|du_flush_pipe; 
  assign id_flushpipe=except_flushpipe|pc_we|extend_flush|du_flush_pipe; 
  assign ex_flushpipe=except_flushpipe|pc_we|extend_flush|du_flush_pipe; 
  assign wb_flushpipe=except_flushpipe|pc_we|extend_flush|du_flush_pipe; 
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            ex_simm <=32'h0000_0000;
          else 
            if (!ex_freeze)
               begin 
                 ex_simm <=id_simm;
               end 
       end
  
  always @( id_insn)
       begin 
         case (id_insn[31:26])
          6 'b100111:
             id_simm ={{16{id_insn[15]}},id_insn[15:0]};
          6 'b101000:
             id_simm ={{16{id_insn[15]}},id_insn[15:0]};
          6 'b100001,6'b100010,6'b100011,6'b100100,6'b100101,6'b100110:
             id_simm ={{16{id_insn[15]}},id_insn[15:0]};
          6 'b101100:
             id_simm ={{16{id_insn[15]}},id_insn[15:0]};
          6 'b110000:
             id_simm ={16'b0,id_insn[25:21],id_insn[10:0]};
          6 'b110101,6'b110111,6'b110110:
             id_simm ={{16{id_insn[25]}},id_insn[25:21],id_insn[10:0]};
          6 'b101011:
             id_simm ={{16{id_insn[15]}},id_insn[15:0]};
          6 'b101111:
             id_simm ={{16{id_insn[15]}},id_insn[15:0]};
          default :
             id_simm ={{16'b0},id_insn[15:0]};
         endcase 
       end
  
  assign id_branch_addrtarget={{4{id_insn[25]}},id_insn[25:0]}+id_pc[31:2]; 
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            ex_branch_addrtarget <=0;
          else 
            if (!ex_freeze)
               ex_branch_addrtarget <=id_branch_addrtarget;
       end
  
  assign if_maci_op=1'b0; 
  assign id_macrc_op=1'b0; 
  assign ex_macrc_op=1'b0; 
  assign cust5_op=ex_insn[4:0]; 
  assign cust5_limm=ex_insn[10:5]; 
  assign rfe=(id_branch_op==3'd6)|(ex_branch_op==3'd6); 
  always @(     rf_addrw or  id_insn or  rfwb_op or  wbforw_valid or  wb_rfaddrw)
       if ((id_insn[20:16]==rf_addrw)&&rfwb_op[0])
          sel_a =2'd2;
        else 
          if ((id_insn[20:16]==wb_rfaddrw)&&wbforw_valid)
             sel_a =2'd3;
           else 
             sel_a =2'd0;
 
  always @(      rf_addrw or  sel_imm or  id_insn or  rfwb_op or  wbforw_valid or  wb_rfaddrw)
       if (sel_imm)
          sel_b =2'd1;
        else 
          if ((id_insn[15:11]==rf_addrw)&&rfwb_op[0])
             sel_b =2'd2;
           else 
             if ((id_insn[15:11]==wb_rfaddrw)&&wbforw_valid)
                sel_b =2'd3;
              else 
                sel_b =2'd0;
 
  always @( id_insn)
       begin 
         case (id_insn[31:26])
          6 'b001001,6'b101101:
             multicycle =3'd1;
          default :
             begin 
               multicycle =3'd0;
             end 
         endcase 
       end
  
  always @( id_insn)
       begin 
         case (id_insn[31:26])
          6 'b111000:
             wait_on =(1'b0|(id_insn[4:0]==5'b0_1001)|(id_insn[4:0]==5'b0_1010)|(id_insn[4:0]==5'b0_0110)|(id_insn[4:0]==5'b0_1011)) ? 2'd1:2'd0;
          6 'b101100:
             wait_on =2'd1;
          6 'b110000:
             begin 
               wait_on =2'd3;
             end 
          default :
             begin 
               wait_on =2'd0;
             end 
         endcase 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            rf_addrw <=5'd0;
          else 
            if (!ex_freeze&id_freeze)
               rf_addrw <=5'd00;
             else 
               if (!ex_freeze)
                  case (id_insn[31:26])
                   6 'b000001,6'b010010:
                      rf_addrw <=5'd09;
                   default :
                      rf_addrw <=id_insn[25:21];
                  endcase 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            wb_rfaddrw <=5'd0;
          else 
            if (!wb_freeze)
               wb_rfaddrw <=rf_addrw;
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            id_insn <={6'b000101,26'h041_0000};
          else 
            if (id_flushpipe)
               id_insn <={6'b000101,26'h041_0000};
             else 
               if (!id_freeze)
                  begin 
                    id_insn <=if_insn;
                  end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            ex_insn <={6'b000101,26'h041_0000};
          else 
            if (!ex_freeze&id_freeze|ex_flushpipe)
               ex_insn <={6'b000101,26'h041_0000};
             else 
               if (!ex_freeze)
                  begin 
                    ex_insn <=id_insn;
                  end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            wb_insn <={6'b000101,26'h041_0000};
          else 
            if (!wb_freeze)
               begin 
                 wb_insn <=ex_insn;
               end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            sel_imm <=1'b0;
          else 
            if (!id_freeze)
               begin 
                 case (if_insn[31:26])
                  6 'b010010:
                     sel_imm <=1'b0;
                  6 'b010001:
                     sel_imm <=1'b0;
                  6 'b001001:
                     sel_imm <=1'b0;
                  6 'b101101:
                     sel_imm <=1'b0;
                  6 'b110000:
                     sel_imm <=1'b0;
                  6 'b001000:
                     sel_imm <=1'b0;
                  6 'b110101:
                     sel_imm <=1'b0;
                  6 'b110110:
                     sel_imm <=1'b0;
                  6 'b110111:
                     sel_imm <=1'b0;
                  6 'b111000:
                     sel_imm <=1'b0;
                  6 'b111001:
                     sel_imm <=1'b0;
                  6 'b000101:
                     sel_imm <=1'b0;
                  default :
                     begin 
                       sel_imm <=1'b1;
                     end 
                 endcase 
               end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            except_illegal <=1'b0;
          else 
            if (!ex_freeze&id_freeze|ex_flushpipe)
               except_illegal <=1'b0;
             else 
               if (!ex_freeze)
                  begin 
                    case (id_insn[31:26])
                     6 'b000000,6'b000001,6'b010010,6'b010001,6'b000011,6'b000100,6'b001001,6'b000110,6'b101101,6'b001000,6'b100001,6'b100010,6'b100011,6'b100100,6'b100101,6'b100110,6'b100111,6'b101000,6'b101001,6'b101010,6'b101011,6'b101100,6'b101111,6'b110000,6'b110101,6'b110110,6'b110111,6'b111001,6'b000101:
                        except_illegal <=1'b0;
                     6 'b111000:
                        except_illegal <=1'b0|((id_insn[4:0]==5'b0_1000)&(id_insn[9:6]==4'd3));
                     default :
                        except_illegal <=1'b1;
                    endcase 
                  end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            alu_op <=5'b0_0100;
          else 
            if (!ex_freeze&id_freeze|ex_flushpipe)
               alu_op <=5'b0_0100;
             else 
               if (!ex_freeze)
                  begin 
                    case (id_insn[31:26])
                     6 'b000110:
                        alu_op <=5'b1_0001;
                     6 'b100111:
                        alu_op <=5'b0_0000;
                     6 'b101000:
                        alu_op <=5'b0_0001;
                     6 'b101001:
                        alu_op <=5'b0_0011;
                     6 'b101010:
                        alu_op <=5'b0_0100;
                     6 'b101011:
                        alu_op <=5'b0_0101;
                     6 'b101100:
                        alu_op <=5'b0_0110;
                     6 'b101111:
                        alu_op <=5'b1_0000;
                     6 'b111000:
                        alu_op <={1'b0,id_insn[3:0]};
                     6 'b111001:
                        alu_op <=5'b1_0000;
                     default :
                        begin 
                          alu_op <=5'b0_0100;
                        end 
                    endcase 
                  end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            alu_op2 <=0;
          else 
            if (!ex_freeze&id_freeze|ex_flushpipe)
               alu_op2 <=0;
             else 
               if (!ex_freeze)
                  begin 
                    alu_op2 <=id_insn[9:6];
                  end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              spr_read <=1'b0;
              spr_write <=1'b0;
            end 
          else 
            if (!ex_freeze&id_freeze|ex_flushpipe)
               begin 
                 spr_read <=1'b0;
                 spr_write <=1'b0;
               end 
             else 
               if (!ex_freeze)
                  begin 
                    case (id_insn[31:26])
                     6 'b101101:
                        begin 
                          spr_read <=1'b1;
                          spr_write <=1'b0;
                        end 
                     6 'b110000:
                        begin 
                          spr_read <=1'b0;
                          spr_write <=1'b1;
                        end 
                     default :
                        begin 
                          spr_read <=1'b0;
                          spr_write <=1'b0;
                        end 
                    endcase 
                  end 
       end
  
  assign id_mac_op=3'b000; 
  assign mac_op=3'b000; 
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            rfwb_op <=4'b0000;
          else 
            if (!ex_freeze&id_freeze|ex_flushpipe)
               rfwb_op <=4'b0000;
             else 
               if (!ex_freeze)
                  begin 
                    case (id_insn[31:26])
                     6 'b000001:
                        rfwb_op <={3'b011,1'b1};
                     6 'b010010:
                        rfwb_op <={3'b011,1'b1};
                     6 'b000110:
                        rfwb_op <={3'b000,1'b1};
                     6 'b101101:
                        rfwb_op <={3'b010,1'b1};
                     6 'b100001:
                        rfwb_op <={3'b001,1'b1};
                     6 'b100010:
                        rfwb_op <={3'b001,1'b1};
                     6 'b100011:
                        rfwb_op <={3'b001,1'b1};
                     6 'b100100:
                        rfwb_op <={3'b001,1'b1};
                     6 'b100101:
                        rfwb_op <={3'b001,1'b1};
                     6 'b100110:
                        rfwb_op <={3'b001,1'b1};
                     6 'b100111:
                        rfwb_op <={3'b000,1'b1};
                     6 'b101000:
                        rfwb_op <={3'b000,1'b1};
                     6 'b101001:
                        rfwb_op <={3'b000,1'b1};
                     6 'b101010:
                        rfwb_op <={3'b000,1'b1};
                     6 'b101011:
                        rfwb_op <={3'b000,1'b1};
                     6 'b101100:
                        rfwb_op <={3'b000,1'b1};
                     6 'b111000:
                        rfwb_op <={3'b000,1'b1};
                     default :
                        rfwb_op <=4'b0000;
                    endcase 
                  end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            id_branch_op <=3'd0;
          else 
            if (id_flushpipe)
               id_branch_op <=3'd0;
             else 
               if (!id_freeze)
                  begin 
                    case (if_insn[31:26])
                     6 'b000000:
                        id_branch_op <=3'd1;
                     6 'b000001:
                        id_branch_op <=3'd1;
                     6 'b010010:
                        id_branch_op <=3'd2;
                     6 'b010001:
                        id_branch_op <=3'd2;
                     6 'b000011:
                        id_branch_op <=3'd5;
                     6 'b000100:
                        id_branch_op <=3'd4;
                     6 'b001001:
                        id_branch_op <=3'd6;
                     default :
                        id_branch_op <=3'd0;
                    endcase 
                  end 
       end
  
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          ex_branch_op <=3'd0;
        else 
          if (!ex_freeze&id_freeze|ex_flushpipe)
             ex_branch_op <=3'd0;
           else 
             if (!ex_freeze)
                ex_branch_op <=id_branch_op;
 
  always @( id_insn)
       begin 
         case (id_insn[31:26])
          6 'b100001:
             id_lsu_op =4'b0110;
          6 'b100010:
             id_lsu_op =4'b0111;
          6 'b100011:
             id_lsu_op =4'b0010;
          6 'b100100:
             id_lsu_op =4'b0011;
          6 'b100101:
             id_lsu_op =4'b0100;
          6 'b100110:
             id_lsu_op =4'b0101;
          6 'b110101:
             id_lsu_op =4'b1110;
          6 'b110110:
             id_lsu_op =4'b1010;
          6 'b110111:
             id_lsu_op =4'b1100;
          default :
             id_lsu_op =4'b0000;
         endcase 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              comp_op <=4'd0;
            end 
          else 
            if (!ex_freeze&id_freeze|ex_flushpipe)
               comp_op <=4'd0;
             else 
               if (!ex_freeze)
                  comp_op <=id_insn[24:21];
       end
  
  assign fpu_op={8{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            sig_syscall <=1'b0;
          else 
            if (!ex_freeze&id_freeze|ex_flushpipe)
               sig_syscall <=1'b0;
             else 
               if (!ex_freeze)
                  begin 
                    sig_syscall <=(id_insn[31:23]=={6'b001000,3'b000});
                  end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            sig_trap <=1'b0;
          else 
            if (!ex_freeze&id_freeze|ex_flushpipe)
               sig_trap <=1'b0;
             else 
               if (!ex_freeze)
                  begin 
                    sig_trap <=(id_insn[31:23]=={6'b001000,3'b010})|du_hwbkpt;
                  end 
       end
  
  assign dc_no_writethrough=0; 
endmodule
 
module or1200_dc_ram #(
 parameter dw =32,
 parameter aw =13-2) (
  input clk,
  input rst,
  input [aw-1:0] addr,
  input en,
  input [3:0] we,
  input [dw-1:0] datain,
  output [dw-1:0] dataout) ; 
    
    
  or1200_spram_32_bw #(.aw(13-2),.dw(dw))dc_ram(.clk(clk),.ce(en),.we(we),.addr(addr),.di(datain),.doq(dataout)); 
endmodule
 
module or1200_spram_64x24 #(
 parameter aw =6,
 parameter dw =24) (
  input clk,
  input rst,
  input ce,
  input we,
  input oe,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq=(oe) ? mem[addr_reg]:{dw{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <={aw{1'b0}};
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we)
          mem [addr]<=di;
 
endmodule
 
module or1200_rfram_generic #(
 parameter dw =32,
 parameter aw =5) (
  input clk,
  input rst,
  input ce_a,
  input [aw-1:0] addr_a,
  output reg  [dw-1:0] do_a,
  input ce_b,
  input [aw-1:0] addr_b,
  output reg  [dw-1:0] do_b,
  input ce_w,
  input we_w,
  input [aw-1:0] addr_w,
  input [dw-1:0] di_w) ; 
    
    
   reg [aw-1:0] intaddr_a ;  
   reg [aw-1:0] intaddr_b ;  
   reg [32*dw-1:0] mem ;  
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          begin 
            mem <={512'h0,512'h0};
          end 
        else 
          if (ce_w&we_w)
             case (addr_w)
              5 'd01:
                 mem [32*1+31:32*1]<=di_w;
              5 'd02:
                 mem [32*2+31:32*2]<=di_w;
              5 'd03:
                 mem [32*3+31:32*3]<=di_w;
              5 'd04:
                 mem [32*4+31:32*4]<=di_w;
              5 'd05:
                 mem [32*5+31:32*5]<=di_w;
              5 'd06:
                 mem [32*6+31:32*6]<=di_w;
              5 'd07:
                 mem [32*7+31:32*7]<=di_w;
              5 'd08:
                 mem [32*8+31:32*8]<=di_w;
              5 'd09:
                 mem [32*9+31:32*9]<=di_w;
              5 'd10:
                 mem [32*10+31:32*10]<=di_w;
              5 'd11:
                 mem [32*11+31:32*11]<=di_w;
              5 'd12:
                 mem [32*12+31:32*12]<=di_w;
              5 'd13:
                 mem [32*13+31:32*13]<=di_w;
              5 'd14:
                 mem [32*14+31:32*14]<=di_w;
              5 'd15:
                 mem [32*15+31:32*15]<=di_w;
              5 'd16:
                 mem [32*16+31:32*16]<=di_w;
              5 'd17:
                 mem [32*17+31:32*17]<=di_w;
              5 'd18:
                 mem [32*18+31:32*18]<=di_w;
              5 'd19:
                 mem [32*19+31:32*19]<=di_w;
              5 'd20:
                 mem [32*20+31:32*20]<=di_w;
              5 'd21:
                 mem [32*21+31:32*21]<=di_w;
              5 'd22:
                 mem [32*22+31:32*22]<=di_w;
              5 'd23:
                 mem [32*23+31:32*23]<=di_w;
              5 'd24:
                 mem [32*24+31:32*24]<=di_w;
              5 'd25:
                 mem [32*25+31:32*25]<=di_w;
              5 'd26:
                 mem [32*26+31:32*26]<=di_w;
              5 'd27:
                 mem [32*27+31:32*27]<=di_w;
              5 'd28:
                 mem [32*28+31:32*28]<=di_w;
              5 'd29:
                 mem [32*29+31:32*29]<=di_w;
              5 'd30:
                 mem [32*30+31:32*30]<=di_w;
              5 'd31:
                 mem [32*31+31:32*31]<=di_w;
              default :
                 mem [32*0+31:32*0]<=32'h0000_0000;
             endcase
  
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          begin 
            intaddr_a <=5'h00;
          end 
        else 
          if (ce_a)
             intaddr_a <=addr_a;
 
  always @(  mem or  intaddr_a)
       case (intaddr_a)
        5 'd01:
           do_a =mem[32*1+31:32*1];
        5 'd02:
           do_a =mem[32*2+31:32*2];
        5 'd03:
           do_a =mem[32*3+31:32*3];
        5 'd04:
           do_a =mem[32*4+31:32*4];
        5 'd05:
           do_a =mem[32*5+31:32*5];
        5 'd06:
           do_a =mem[32*6+31:32*6];
        5 'd07:
           do_a =mem[32*7+31:32*7];
        5 'd08:
           do_a =mem[32*8+31:32*8];
        5 'd09:
           do_a =mem[32*9+31:32*9];
        5 'd10:
           do_a =mem[32*10+31:32*10];
        5 'd11:
           do_a =mem[32*11+31:32*11];
        5 'd12:
           do_a =mem[32*12+31:32*12];
        5 'd13:
           do_a =mem[32*13+31:32*13];
        5 'd14:
           do_a =mem[32*14+31:32*14];
        5 'd15:
           do_a =mem[32*15+31:32*15];
        5 'd16:
           do_a =mem[32*16+31:32*16];
        5 'd17:
           do_a =mem[32*17+31:32*17];
        5 'd18:
           do_a =mem[32*18+31:32*18];
        5 'd19:
           do_a =mem[32*19+31:32*19];
        5 'd20:
           do_a =mem[32*20+31:32*20];
        5 'd21:
           do_a =mem[32*21+31:32*21];
        5 'd22:
           do_a =mem[32*22+31:32*22];
        5 'd23:
           do_a =mem[32*23+31:32*23];
        5 'd24:
           do_a =mem[32*24+31:32*24];
        5 'd25:
           do_a =mem[32*25+31:32*25];
        5 'd26:
           do_a =mem[32*26+31:32*26];
        5 'd27:
           do_a =mem[32*27+31:32*27];
        5 'd28:
           do_a =mem[32*28+31:32*28];
        5 'd29:
           do_a =mem[32*29+31:32*29];
        5 'd30:
           do_a =mem[32*30+31:32*30];
        5 'd31:
           do_a =mem[32*31+31:32*31];
        default :
           do_a =32'h0000_0000;
       endcase
  
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          begin 
            intaddr_b <=5'h00;
          end 
        else 
          if (ce_b)
             intaddr_b <=addr_b;
 
  always @(  mem or  intaddr_b)
       case (intaddr_b)
        5 'd01:
           do_b =mem[32*1+31:32*1];
        5 'd02:
           do_b =mem[32*2+31:32*2];
        5 'd03:
           do_b =mem[32*3+31:32*3];
        5 'd04:
           do_b =mem[32*4+31:32*4];
        5 'd05:
           do_b =mem[32*5+31:32*5];
        5 'd06:
           do_b =mem[32*6+31:32*6];
        5 'd07:
           do_b =mem[32*7+31:32*7];
        5 'd08:
           do_b =mem[32*8+31:32*8];
        5 'd09:
           do_b =mem[32*9+31:32*9];
        5 'd10:
           do_b =mem[32*10+31:32*10];
        5 'd11:
           do_b =mem[32*11+31:32*11];
        5 'd12:
           do_b =mem[32*12+31:32*12];
        5 'd13:
           do_b =mem[32*13+31:32*13];
        5 'd14:
           do_b =mem[32*14+31:32*14];
        5 'd15:
           do_b =mem[32*15+31:32*15];
        5 'd16:
           do_b =mem[32*16+31:32*16];
        5 'd17:
           do_b =mem[32*17+31:32*17];
        5 'd18:
           do_b =mem[32*18+31:32*18];
        5 'd19:
           do_b =mem[32*19+31:32*19];
        5 'd20:
           do_b =mem[32*20+31:32*20];
        5 'd21:
           do_b =mem[32*21+31:32*21];
        5 'd22:
           do_b =mem[32*22+31:32*22];
        5 'd23:
           do_b =mem[32*23+31:32*23];
        5 'd24:
           do_b =mem[32*24+31:32*24];
        5 'd25:
           do_b =mem[32*25+31:32*25];
        5 'd26:
           do_b =mem[32*26+31:32*26];
        5 'd27:
           do_b =mem[32*27+31:32*27];
        5 'd28:
           do_b =mem[32*28+31:32*28];
        5 'd29:
           do_b =mem[32*29+31:32*29];
        5 'd30:
           do_b =mem[32*30+31:32*30];
        5 'd31:
           do_b =mem[32*31+31:32*31];
        default :
           do_b =32'h0000_0000;
       endcase
  
endmodule
 
module or1200_pm (
  input clk,
  input rst,
  input pic_wakeup,
  input spr_write,
  input [31:0] spr_addr,
  input [31:0] spr_dat_i,
  output [31:0] spr_dat_o,
  output [3:0] pm_clksd,
  input pm_cpustall,
  output pm_dc_gate,
  output pm_ic_gate,
  output pm_dmmu_gate,
  output pm_immu_gate,
  output pm_tt_gate,
  output pm_cpu_gate,
  output pm_wakeup,
  output pm_lvolt) ; 
  assign pm_clksd=4'b0; 
  assign pm_cpu_gate=1'b0; 
  assign pm_dc_gate=1'b0; 
  assign pm_ic_gate=1'b0; 
  assign pm_dmmu_gate=1'b0; 
  assign pm_immu_gate=1'b0; 
  assign pm_tt_gate=1'b0; 
  assign pm_wakeup=1'b1; 
  assign pm_lvolt=1'b0; 
  assign spr_dat_o[3:0]=4'b0; 
  assign spr_dat_o[4]=1'b0; 
  assign spr_dat_o[5]=1'b0; 
  assign spr_dat_o[6]=1'b0; 
  assign spr_dat_o[31:7]=25'b0; 
endmodule
 
module or1200_reg2mem #(
 parameter width =32) (
  input [1:0] addr,
  input [4-1:0] lsu_op,
  input [width-1:0] regdata,
  output [width-1:0] memdata) ; 
    
   reg [7:0] memdata_hh ;  
   reg [7:0] memdata_hl ;  
   reg [7:0] memdata_lh ;  
   reg [7:0] memdata_ll ;  
  assign memdata={memdata_hh,memdata_hl,memdata_lh,memdata_ll}; 
  always @(   lsu_op or  addr or  regdata)
       begin 
         casez ({lsu_op,addr[1:0]})
          { 4'b1010,2'b00}:
             memdata_hh =regdata[7:0];
          { 4'b1100,2'b00}:
             memdata_hh =regdata[15:8];
          default :
             memdata_hh =regdata[31:24];
         endcase 
       end
  
  always @(   lsu_op or  addr or  regdata)
       begin 
         casez ({lsu_op,addr[1:0]})
          { 4'b1110,2'b00}:
             memdata_hl =regdata[23:16];
          default :
             memdata_hl =regdata[7:0];
         endcase 
       end
  
  always @(   lsu_op or  addr or  regdata)
       begin 
         casez ({lsu_op,addr[1:0]})
          { 4'b1010,2'b10}:
             memdata_lh =regdata[7:0];
          default :
             memdata_lh =regdata[15:8];
         endcase 
       end
  
  always @( regdata)
       memdata_ll =regdata[7:0];
 
endmodule
 
module or1200_cpu #(
 parameter dw =32,
 parameter aw =5,
 parameter boot_adr =32'h00000100) (
  input clk,
  input rst,
  output ic_en,
  output [31:0] icpu_adr_o,
  output icpu_cycstb_o,
  output [3:0] icpu_sel_o,
  output [3:0] icpu_tag_o,
  input [31:0] icpu_dat_i,
  input icpu_ack_i,
  input icpu_rty_i,
  input icpu_err_i,
  input [31:0] icpu_adr_i,
  input [3:0] icpu_tag_i,
  output immu_en,
  output id_void,
  output [31:0] id_insn,
  output ex_void,
  output [31:0] ex_insn,
  output ex_freeze,
  output [31:0] wb_insn,
  output wb_freeze,
  output [31:0] id_pc,
  output [31:0] ex_pc,
  output [31:0] wb_pc,
  output [3-1:0] branch_op,
  output [dw-1:0] spr_dat_npc,
  output [dw-1:0] rf_dataw,
  output ex_flushpipe,
  input du_stall,
  input [dw-1:0] du_addr,
  input [dw-1:0] du_dat_du,
  input du_read,
  input du_write,
  output [13:0] du_except_stop,
  input du_flush_pipe,
  output [13:0] du_except_trig,
  input [14-1:0] du_dsr,
  input [24:0] du_dmr1,
  input du_hwbkpt,
  input du_hwbkpt_ls_r,
  output [dw-1:0] du_dat_cpu,
  output [dw-1:0] du_lsu_store_dat,
  output [dw-1:0] du_lsu_load_dat,
  output abort_mvspr,
  output abort_ex,
  output dc_en,
  output [31:0] dcpu_adr_o,
  output dcpu_cycstb_o,
  output dcpu_we_o,
  output [3:0] dcpu_sel_o,
  output [3:0] dcpu_tag_o,
  output [31:0] dcpu_dat_o,
  input [31:0] dcpu_dat_i,
  input dcpu_ack_i,
  input dcpu_rty_i,
  input dcpu_err_i,
  input [3:0] dcpu_tag_i,
  output sb_en,
  output dmmu_en,
  output dc_no_writethrough,
  input boot_adr_sel_i,
  input sig_int,
  input sig_tick,
  output supv,
  output [dw-1:0] spr_addr,
  output [dw-1:0] spr_dat_cpu,
  input [dw-1:0] spr_dat_pic,
  input [dw-1:0] spr_dat_tt,
  input [dw-1:0] spr_dat_pm,
  input [dw-1:0] spr_dat_dmmu,
  input [dw-1:0] spr_dat_immu,
  input [dw-1:0] spr_dat_du,
  output [31:0] spr_cs,
  output spr_we,
  input mtspr_dc_done) ; 
    
    
    
   wire [31:0] if_insn ;  
   wire saving_if_insn ;  
   wire [31:0] if_pc ;  
   wire [aw-1:0] rf_addrw ;  
   wire [aw-1:0] rf_addra ;  
   wire [aw-1:0] rf_addrb ;  
   wire rf_rda ;  
   wire rf_rdb ;  
   wire [dw-1:0] id_simm ;  
   wire [dw-1:2] id_branch_addrtarget ;  
   wire [dw-1:2] ex_branch_addrtarget ;  
   wire [5-1:0] alu_op ;  
   wire [4-1:0] alu_op2 ;  
   wire [4-1:0] comp_op ;  
   wire [3-1:0] pre_branch_op ;  
   wire [4-1:0] id_lsu_op ;  
   wire genpc_freeze ;  
   wire if_freeze ;  
   wire id_freeze ;  
   wire [2-1:0] sel_a ;  
   wire [2-1:0] sel_b ;  
   wire [4-1:0] rfwb_op ;  
   wire [8-1:0] fpu_op ;  
   wire [dw-1:0] rf_dataa ;  
   wire [dw-1:0] rf_datab ;  
   wire [dw-1:0] muxed_a ;  
   wire [dw-1:0] muxed_b ;  
   wire [dw-1:0] wb_forw ;  
   wire wbforw_valid ;  
   wire [dw-1:0] operand_a ;  
   wire [dw-1:0] operand_b ;  
   wire [dw-1:0] alu_dataout ;  
   wire [dw-1:0] lsu_dataout ;  
   wire [dw-1:0] sprs_dataout ;  
   wire [dw-1:0] fpu_dataout ;  
   wire fpu_done ;  
   wire [31:0] ex_simm ;  
   wire [3-1:0] multicycle ;  
   wire [2-1:0] wait_on ;  
   wire [4-1:0] except_type ;  
   wire [4:0] cust5_op ;  
   wire [5:0] cust5_limm ;  
   wire if_flushpipe ;  
   wire id_flushpipe ;  
   wire wb_flushpipe ;  
   wire extend_flush ;  
   wire ex_branch_taken ;  
   wire flag ;  
   wire flagforw ;  
   wire flag_we ;  
   wire flagforw_alu ;  
   wire flag_we_alu ;  
   wire flagforw_fpu ;  
   wire flag_we_fpu ;  
   wire carry ;  
   wire cyforw ;  
   wire cy_we_alu ;  
   wire ovforw ;  
   wire ov_we_alu ;  
   wire ovforw_mult_mac ;  
   wire ov_we_mult_mac ;  
   wire cy_we_rf ;  
   wire lsu_stall ;  
   wire epcr_we ;  
   wire eear_we ;  
   wire esr_we ;  
   wire pc_we ;  
   wire [31:0] epcr ;  
   wire [31:0] eear ;  
   wire [17-1:0] esr ;  
   wire [12-1:0] fpcsr ;  
   wire fpcsr_we ;  
   wire sr_we ;  
   wire [17-1:0] to_sr ;  
   wire [17-1:0] sr ;  
   wire dsx ;  
   wire except_flushpipe ;  
   wire except_start ;  
   wire except_started ;  
   wire fpu_except_started ;  
   wire sig_syscall ;  
   wire sig_trap ;  
   wire sig_range ;  
   wire sig_fp ;  
   wire [31:0] spr_dat_cfgr ;  
   wire [31:0] spr_dat_rf ;  
   wire [31:0] spr_dat_ppc ;  
   wire [31:0] spr_dat_mac ;  
   wire [31:0] spr_dat_fpu ;  
   wire mtspr_done ;  
   wire force_dslot_fetch ;  
   wire no_more_dslot ;  
   wire ex_spr_read ;  
   wire ex_spr_write ;  
   wire if_stall ;  
   wire id_macrc_op ;  
   wire ex_macrc_op ;  
   wire [3-1:0] id_mac_op ;  
   wire [3-1:0] mac_op ;  
   wire [31:0] mult_mac_result ;  
   wire mult_mac_stall ;  
   wire [13:0] except_trig ;  
   wire [13:0] except_stop ;  
   wire genpc_refetch ;  
   wire rfe ;  
   wire lsu_unstall ;  
   wire except_align ;  
   wire except_dtlbmiss ;  
   wire except_dmmufault ;  
   wire except_illegal ;  
   wire except_itlbmiss ;  
   wire except_immufault ;  
   wire except_ibuserr ;  
   wire except_dbuserr ;  
  assign du_except_trig=except_trig; 
  assign du_except_stop=except_stop; 
  assign du_lsu_store_dat=operand_b; 
  assign du_lsu_load_dat=lsu_dataout; 
  assign dc_en=sr[3]; 
  assign ic_en=sr[4]; 
  assign sb_en=1'b0; 
  assign dmmu_en=sr[5]; 
  assign immu_en=sr[6]&~except_started; 
  assign supv=sr[0]; 
  assign flagforw=(flag_we_alu&flagforw_alu)|(flagforw_fpu&flag_we_fpu); 
  assign flag_we=(flag_we_alu|flag_we_fpu)&~abort_mvspr; 
  assign mtspr_done=mtspr_dc_done; 
  assign sig_range=sr[11]; 
  or1200_genpc #(.boot_adr(boot_adr))or1200_genpc(.clk(clk),.rst(rst),.icpu_adr_o(icpu_adr_o),.icpu_cycstb_o(icpu_cycstb_o),.icpu_sel_o(icpu_sel_o),.icpu_tag_o(icpu_tag_o),.icpu_rty_i(icpu_rty_i),.icpu_adr_i(icpu_adr_i),.pre_branch_op(pre_branch_op),.branch_op(branch_op),.except_type(except_type),.except_start(except_start),.except_prefix(sr[14]),.id_branch_addrtarget(id_branch_addrtarget),.ex_branch_addrtarget(ex_branch_addrtarget),.muxed_b(muxed_b),.operand_b(operand_b),.flag(flag),.flagforw(flagforw),.ex_branch_taken(ex_branch_taken),.epcr(epcr),.spr_dat_i(spr_dat_cpu),.spr_pc_we(pc_we),.genpc_refetch(genpc_refetch),.genpc_freeze(genpc_freeze),.no_more_dslot(no_more_dslot),.lsu_stall(lsu_stall),.du_flush_pipe(du_flush_pipe),.spr_dat_npc(spr_dat_npc)); 
  or1200_if or1200_if(.clk(clk),.rst(rst),.icpu_dat_i(icpu_dat_i),.icpu_ack_i(icpu_ack_i),.icpu_err_i(icpu_err_i),.icpu_adr_i(icpu_adr_i),.icpu_tag_i(icpu_tag_i),.if_freeze(if_freeze),.if_insn(if_insn),.if_pc(if_pc),.saving_if_insn(saving_if_insn),.if_flushpipe(if_flushpipe),.if_stall(if_stall),.no_more_dslot(no_more_dslot),.genpc_refetch(genpc_refetch),.rfe(rfe),.except_itlbmiss(except_itlbmiss),.except_immufault(except_immufault),.except_ibuserr(except_ibuserr)); 
  or1200_ctrl or1200_ctrl(.clk(clk),.rst(rst),.id_freeze(id_freeze),.ex_freeze(ex_freeze),.wb_freeze(wb_freeze),.if_flushpipe(if_flushpipe),.id_flushpipe(id_flushpipe),.ex_flushpipe(ex_flushpipe),.wb_flushpipe(wb_flushpipe),.extend_flush(extend_flush),.except_flushpipe(except_flushpipe),.abort_mvspr(abort_mvspr),.if_insn(if_insn),.id_insn(id_insn),.ex_insn(ex_insn),.id_branch_op(pre_branch_op),.ex_branch_op(branch_op),.ex_branch_taken(ex_branch_taken),.rf_addra(rf_addra),.rf_addrb(rf_addrb),.rf_rda(rf_rda),.rf_rdb(rf_rdb),.alu_op(alu_op),.alu_op2(alu_op2),.mac_op(mac_op),.comp_op(comp_op),.rf_addrw(rf_addrw),.rfwb_op(rfwb_op),.fpu_op(fpu_op),.pc_we(pc_we),.wb_insn(wb_insn),.id_simm(id_simm),.id_branch_addrtarget(id_branch_addrtarget),.ex_branch_addrtarget(ex_branch_addrtarget),.ex_simm(ex_simm),.sel_a(sel_a),.sel_b(sel_b),.id_lsu_op(id_lsu_op),.cust5_op(cust5_op),.cust5_limm(cust5_limm),.id_pc(id_pc),.ex_pc(ex_pc),.multicycle(multicycle),.wait_on(wait_on),.wbforw_valid(wbforw_valid),.sig_syscall(sig_syscall),.sig_trap(sig_trap),.force_dslot_fetch(force_dslot_fetch),.no_more_dslot(no_more_dslot),.id_void(id_void),.ex_void(ex_void),.ex_spr_read(ex_spr_read),.ex_spr_write(ex_spr_write),.id_mac_op(id_mac_op),.id_macrc_op(id_macrc_op),.ex_macrc_op(ex_macrc_op),.rfe(rfe),.du_hwbkpt(du_hwbkpt),.except_illegal(except_illegal),.dc_no_writethrough(dc_no_writethrough),.du_flush_pipe(du_flush_pipe)); 
  or1200_rf or1200_rf(.clk(clk),.rst(rst),.cy_we_i(cy_we_alu),.cy_we_o(cy_we_rf),.supv(sr[0]),.wb_freeze(wb_freeze),.addrw(rf_addrw),.dataw(rf_dataw),.id_freeze(id_freeze),.we(rfwb_op[0]),.flushpipe(wb_flushpipe),.addra(rf_addra),.rda(rf_rda),.dataa(rf_dataa),.addrb(rf_addrb),.rdb(rf_rdb),.datab(rf_datab),.spr_cs(spr_cs[5'd00]),.spr_write(spr_we),.spr_addr(spr_addr),.spr_dat_i(spr_dat_cpu),.spr_dat_o(spr_dat_rf),.du_read(du_read)); 
  or1200_operandmuxes or1200_operandmuxes(.clk(clk),.rst(rst),.id_freeze(id_freeze),.ex_freeze(ex_freeze),.rf_dataa(rf_dataa),.rf_datab(rf_datab),.ex_forw(rf_dataw),.wb_forw(wb_forw),.simm(id_simm),.sel_a(sel_a),.sel_b(sel_b),.operand_a(operand_a),.operand_b(operand_b),.muxed_a(muxed_a),.muxed_b(muxed_b)); 
  or1200_alu or1200_alu(.a(operand_a),.b(operand_b),.mult_mac_result(mult_mac_result),.macrc_op(ex_macrc_op),.alu_op(alu_op),.alu_op2(alu_op2),.comp_op(comp_op),.cust5_op(cust5_op),.cust5_limm(cust5_limm),.result(alu_dataout),.flagforw(flagforw_alu),.flag_we(flag_we_alu),.cyforw(cyforw),.cy_we(cy_we_alu),.ovforw(ovforw),.ov_we(ov_we_alu),.flag(flag),.carry(carry)); 
  assign fpu_except_started=except_started&&(except_type==4'hd); 
  or1200_fpu or1200_fpu(.clk(clk),.rst(rst),.ex_freeze(ex_freeze),.a(operand_a),.b(operand_b),.fpu_op(fpu_op),.result(fpu_dataout),.done(fpu_done),.flagforw(flagforw_fpu),.flag_we(flag_we_fpu),.sig_fp(sig_fp),.except_started(fpu_except_started),.fpcsr_we(fpcsr_we),.fpcsr(fpcsr),.spr_cs(spr_cs[5'd11]),.spr_write(spr_we),.spr_addr(spr_addr),.spr_dat_i(spr_dat_cpu),.spr_dat_o(spr_dat_fpu)); 
  or1200_mult_mac or1200_mult_mac(.clk(clk),.rst(rst),.ex_freeze(ex_freeze),.id_macrc_op(id_macrc_op),.macrc_op(ex_macrc_op),.a(operand_a),.b(operand_b),.mac_op(mac_op),.alu_op(alu_op),.result(mult_mac_result),.ovforw(ovforw_mult_mac),.ov_we(ov_we_mult_mac),.mult_mac_stall(mult_mac_stall),.spr_cs(spr_cs[5'd05]),.spr_write(spr_we),.spr_addr(spr_addr),.spr_dat_i(spr_dat_cpu),.spr_dat_o(spr_dat_mac)); 
  or1200_sprs or1200_sprs(.clk(clk),.rst(rst),.addrbase(operand_a),.addrofs(ex_simm[15:0]),.dat_i(operand_b),.ex_spr_read(ex_spr_read),.ex_spr_write(ex_spr_write),.flagforw(flagforw),.flag_we(flag_we),.flag(flag),.cyforw(cyforw),.cy_we(cy_we_rf),.carry(carry),.ovforw(ovforw|ovforw_mult_mac),.ov_we(ov_we_alu|ov_we_mult_mac),.to_wbmux(sprs_dataout),.du_addr(du_addr),.du_dat_du(du_dat_du),.du_read(du_read),.du_write(du_write),.du_dat_cpu(du_dat_cpu),.boot_adr_sel_i(boot_adr_sel_i),.spr_addr(spr_addr),.spr_dat_pic(spr_dat_pic),.spr_dat_tt(spr_dat_tt),.spr_dat_pm(spr_dat_pm),.spr_dat_cfgr(spr_dat_cfgr),.spr_dat_rf(spr_dat_rf),.spr_dat_npc(spr_dat_npc),.spr_dat_ppc(spr_dat_ppc),.spr_dat_mac(spr_dat_mac),.spr_dat_dmmu(spr_dat_dmmu),.spr_dat_immu(spr_dat_immu),.spr_dat_du(spr_dat_du),.spr_dat_o(spr_dat_cpu),.spr_cs(spr_cs),.spr_we(spr_we),.epcr_we(epcr_we),.eear_we(eear_we),.esr_we(esr_we),.pc_we(pc_we),.epcr(epcr),.eear(eear),.esr(esr),.except_started(except_started),.fpcsr(fpcsr),.fpcsr_we(fpcsr_we),.spr_dat_fpu(spr_dat_fpu),.sr_we(sr_we),.to_sr(to_sr),.sr(sr),.branch_op(branch_op),.dsx(dsx)); 
  or1200_lsu or1200_lsu(.clk(clk),.rst(rst),.id_addrbase(muxed_a),.id_addrofs(id_simm),.ex_addrbase(operand_a),.ex_addrofs(ex_simm),.id_lsu_op(id_lsu_op),.lsu_datain(operand_b),.lsu_dataout(lsu_dataout),.lsu_stall(lsu_stall),.lsu_unstall(lsu_unstall),.du_stall(du_stall),.except_align(except_align),.except_dtlbmiss(except_dtlbmiss),.except_dmmufault(except_dmmufault),.except_dbuserr(except_dbuserr),.id_freeze(id_freeze),.ex_freeze(ex_freeze),.flushpipe(ex_flushpipe),.dcpu_adr_o(dcpu_adr_o),.dcpu_cycstb_o(dcpu_cycstb_o),.dcpu_we_o(dcpu_we_o),.dcpu_sel_o(dcpu_sel_o),.dcpu_tag_o(dcpu_tag_o),.dcpu_dat_o(dcpu_dat_o),.dcpu_dat_i(dcpu_dat_i),.dcpu_ack_i(dcpu_ack_i),.dcpu_rty_i(dcpu_rty_i),.dcpu_err_i(dcpu_err_i),.dcpu_tag_i(dcpu_tag_i)); 
  or1200_wbmux or1200_wbmux(.clk(clk),.rst(rst),.wb_freeze(wb_freeze),.rfwb_op(rfwb_op),.muxin_a(alu_dataout),.muxin_b(lsu_dataout),.muxin_c(sprs_dataout),.muxin_d(ex_pc),.muxin_e(fpu_dataout),.muxout(rf_dataw),.muxreg(wb_forw),.muxreg_valid(wbforw_valid)); 
  or1200_freeze or1200_freeze(.clk(clk),.rst(rst),.multicycle(multicycle),.wait_on(wait_on),.fpu_done(fpu_done),.mtspr_done(mtspr_done),.flushpipe(wb_flushpipe),.extend_flush(extend_flush),.lsu_stall(lsu_stall),.if_stall(if_stall),.lsu_unstall(lsu_unstall),.force_dslot_fetch(force_dslot_fetch),.abort_ex(abort_ex),.du_stall(du_stall),.mac_stall(mult_mac_stall),.saving_if_insn(saving_if_insn),.genpc_freeze(genpc_freeze),.if_freeze(if_freeze),.id_freeze(id_freeze),.ex_freeze(ex_freeze),.wb_freeze(wb_freeze),.icpu_ack_i(icpu_ack_i),.icpu_err_i(icpu_err_i)); 
  or1200_except or1200_except(.clk(clk),.rst(rst),.sig_ibuserr(except_ibuserr),.sig_dbuserr(except_dbuserr),.sig_illegal(except_illegal),.sig_align(except_align),.sig_range(sig_range),.sig_dtlbmiss(except_dtlbmiss),.sig_dmmufault(except_dmmufault),.sig_int(sig_int),.sig_syscall(sig_syscall),.sig_trap(sig_trap),.sig_itlbmiss(except_itlbmiss),.sig_immufault(except_immufault),.sig_tick(sig_tick),.sig_fp(sig_fp),.fpcsr_fpee(fpcsr[0]),.ex_branch_taken(ex_branch_taken),.icpu_ack_i(icpu_ack_i),.icpu_err_i(icpu_err_i),.dcpu_ack_i(dcpu_ack_i),.dcpu_err_i(dcpu_err_i),.genpc_freeze(genpc_freeze),.id_freeze(id_freeze),.ex_freeze(ex_freeze),.wb_freeze(wb_freeze),.if_stall(if_stall),.if_pc(if_pc),.id_pc(id_pc),.ex_pc(ex_pc),.wb_pc(wb_pc),.id_flushpipe(id_flushpipe),.ex_flushpipe(ex_flushpipe),.extend_flush(extend_flush),.except_flushpipe(except_flushpipe),.abort_mvspr(abort_mvspr),.except_type(except_type),.except_start(except_start),.except_started(except_started),.except_stop(except_stop),.except_trig(except_trig),.ex_void(ex_void),.spr_dat_ppc(spr_dat_ppc),.spr_dat_npc(spr_dat_npc),.datain(spr_dat_cpu),.branch_op(branch_op),.du_dsr(du_dsr),.du_dmr1(du_dmr1),.du_hwbkpt(du_hwbkpt),.du_hwbkpt_ls_r(du_hwbkpt_ls_r),.epcr_we(epcr_we),.eear_we(eear_we),.esr_we(esr_we),.pc_we(pc_we),.epcr(epcr),.eear(eear),.esr(esr),.lsu_addr(dcpu_adr_o),.sr_we(sr_we),.to_sr(to_sr),.sr(sr),.abort_ex(abort_ex),.dsx(dsx)); 
  or1200_cfgr or1200_cfgr(.spr_addr(spr_addr),.spr_dat_o(spr_dat_cfgr)); 
endmodule
 
module or1200_spram_64x22 #(
 parameter aw =6,
 parameter dw =22) (
  input clk,
  input rst,
  input ce,
  input we,
  input oe,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq=(oe) ? mem[addr_reg]:{dw{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <={aw{1'b0}};
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we)
          mem [addr]<=di;
 
endmodule
 
module or1200_ic_fsm (
  input clk,
  input rst,
  input ic_en,
  input icqmem_cycstb_i,
  input icqmem_ci_i,
  input tagcomp_miss,
  input biudata_valid,
  input biudata_error,
  input [31:0] start_addr,
  output [31:0] saved_addr,
  output [3:0] icram_we,
  output tag_we,
  output biu_read,
  output first_hit_ack,
  output first_miss_ack,
  output first_miss_err,
  output burst) ; 
   reg [31:0] saved_addr_r ;  
   reg [1:0] state ;  
   reg [4-1:0] cnt ;  
   reg hitmiss_eval ;  
   reg load ;  
   reg cache_inhibit ;  
   reg last_eval_miss ;  
  assign icram_we={4{biu_read&biudata_valid&!cache_inhibit}}; 
  assign tag_we=biu_read&biudata_valid&!cache_inhibit; 
  assign biu_read=(hitmiss_eval&tagcomp_miss)|(!hitmiss_eval&load); 
  assign saved_addr=saved_addr_r; 
  assign first_hit_ack=(state==2'd1)&hitmiss_eval&!tagcomp_miss&!cache_inhibit; 
  assign first_miss_ack=(state==2'd1)&biudata_valid&~first_hit_ack; 
  assign first_miss_err=(state==2'd1)&biudata_error; 
  assign burst=(state==2'd1)&tagcomp_miss&!cache_inhibit|(state==2'd2); 
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              state <=2'd0;
              saved_addr_r <=32'b0;
              hitmiss_eval <=1'b0;
              load <=1'b0;
              cnt <=4'd0;
              cache_inhibit <=1'b0;
              last_eval_miss <=0;
            end 
          else 
            case (state)
             2 'd0:
                if (ic_en&icqmem_cycstb_i)
                   begin 
                     state <=2'd1;
                     saved_addr_r <=start_addr;
                     hitmiss_eval <=1'b1;
                     load <=1'b1;
                     cache_inhibit <=icqmem_ci_i;
                     last_eval_miss <=0;
                   end 
                 else 
                   begin 
                     hitmiss_eval <=1'b0;
                     load <=1'b0;
                     cache_inhibit <=1'b0;
                   end 
             2 'd1:
                begin 
                  if (icqmem_cycstb_i&icqmem_ci_i)
                     cache_inhibit <=1'b1;
                  if (hitmiss_eval)
                     saved_addr_r [31:13-1+1]<=start_addr[31:13-1+1];
                  if ((!ic_en)||(hitmiss_eval&!icqmem_cycstb_i)||(biudata_error)||(cache_inhibit&biudata_valid))
                     begin 
                       state <=2'd0;
                       hitmiss_eval <=1'b0;
                       load <=1'b0;
                       cache_inhibit <=1'b0;
                     end 
                   else 
                     if (tagcomp_miss&biudata_valid)
                        begin 
                          state <=2'd2;
                          saved_addr_r [4-1:2]<=saved_addr_r[4-1:2]+1;
                          hitmiss_eval <=1'b0;
                          cnt <=((1<<4)-(2*4));
                          cache_inhibit <=1'b0;
                        end 
                      else 
                        if (!icqmem_cycstb_i&!last_eval_miss)
                           begin 
                             state <=2'd0;
                             hitmiss_eval <=1'b0;
                             load <=1'b0;
                             cache_inhibit <=1'b0;
                           end 
                         else 
                           if (!tagcomp_miss&!icqmem_ci_i)
                              begin 
                                saved_addr_r <=start_addr;
                                cache_inhibit <=1'b0;
                              end 
                            else 
                              hitmiss_eval <=1'b0;
                  if (hitmiss_eval&!tagcomp_miss)
                     last_eval_miss <=1;
                end 
             2 'd2:
                begin 
                  if (!ic_en)
                     begin 
                       state <=2'd0;
                       saved_addr_r <=start_addr;
                       hitmiss_eval <=1'b0;
                       load <=1'b0;
                     end 
                   else 
                     if (biudata_valid&&(|cnt))
                        begin 
                          cnt <=cnt-4'd4;
                          saved_addr_r [4-1:2]<=saved_addr_r[4-1:2]+1;
                        end 
                      else 
                        if (biudata_valid)
                           begin 
                             state <=2'd0;
                             saved_addr_r <=start_addr;
                             hitmiss_eval <=1'b0;
                             load <=1'b0;
                           end 
                end 
             default :
                state <=2'd0;
            endcase 
       end
  
endmodule
 
module or1200_sb #(
 parameter dw =32,
 parameter aw =32) (
  input clk,
  input rst,
  input sb_en,
  input [dw-1:0] dcsb_dat_i,
  input [aw-1:0] dcsb_adr_i,
  input dcsb_cyc_i,
  input dcsb_stb_i,
  input dcsb_we_i,
  input [3:0] dcsb_sel_i,
  input dcsb_cab_i,
  output [dw-1:0] dcsb_dat_o,
  output dcsb_ack_o,
  output dcsb_err_o,
  output [dw-1:0] sbbiu_dat_o,
  output [aw-1:0] sbbiu_adr_o,
  output sbbiu_cyc_o,
  output sbbiu_stb_o,
  output sbbiu_we_o,
  output [3:0] sbbiu_sel_o,
  output sbbiu_cab_o,
  input [dw-1:0] sbbiu_dat_i,
  input sbbiu_ack_i,
  input sbbiu_err_i) ; 
    
    
  assign sbbiu_dat_o=dcsb_dat_i; 
  assign sbbiu_adr_o=dcsb_adr_i; 
  assign sbbiu_cyc_o=dcsb_cyc_i; 
  assign sbbiu_stb_o=dcsb_stb_i; 
  assign sbbiu_we_o=dcsb_we_i; 
  assign sbbiu_cab_o=dcsb_cab_i; 
  assign sbbiu_sel_o=dcsb_sel_i; 
  assign dcsb_dat_o=sbbiu_dat_i; 
  assign dcsb_ack_o=sbbiu_ack_i; 
  assign dcsb_err_o=sbbiu_err_i; 
endmodule
 
module or1200_fpu_pre_norm_mul #(
 parameter FP_WIDTH =32,
 parameter MUL_SERIAL =0,
 parameter MUL_COUNT =11,
 parameter FRAC_WIDTH =23,
 parameter EXP_WIDTH =8,
 parameter ZERO_VECTOR =31'd0,
 parameter INF =31'b1111111100000000000000000000000,
 parameter QNAN =31'b1111111110000000000000000000000,
 parameter SNAN =31'b1111111100000000000000000000001) (
  input clk_i,
  input [FP_WIDTH-1:0] opa_i,
  input [FP_WIDTH-1:0] opb_i,
  output reg  [EXP_WIDTH+1:0] exp_10_o,
  output [FRAC_WIDTH:0] fracta_24_o,
  output [FRAC_WIDTH:0] fractb_24_o) ; 
    
    
    
    
    
    
    
    
    
   wire [EXP_WIDTH-1:0] s_expa ;  
   wire [EXP_WIDTH-1:0] s_expb ;  
   wire [FRAC_WIDTH-1:0] s_fracta ;  
   wire [FRAC_WIDTH-1:0] s_fractb ;  
   wire [EXP_WIDTH+1:0] s_exp_10_o ;  
   wire [EXP_WIDTH+1:0] s_expa_in ;  
   wire [EXP_WIDTH+1:0] s_expb_in ;  
   wire s_opa_dn,s_opb_dn ;  
  assign s_expa=opa_i[30:23]; 
  assign s_expb=opb_i[30:23]; 
  assign s_fracta=opa_i[22:0]; 
  assign s_fractb=opb_i[22:0]; 
  always @( posedge clk_i)
       exp_10_o <=s_exp_10_o;
 
  assign s_opa_dn=!(|s_expa); 
  assign s_opb_dn=!(|s_expb); 
  assign fracta_24_o={!s_opa_dn,s_fracta}; 
  assign fractb_24_o={!s_opb_dn,s_fractb}; 
  assign s_expa_in={2'd0,s_expa}+{9'd0,s_opa_dn}; 
  assign s_expb_in={2'd0,s_expb}+{9'd0,s_opb_dn}; 
  assign s_exp_10_o=s_expa_in+s_expb_in-10'b0001111111; 
endmodule
 
module or1200_rf #(
 parameter dw =32,
 parameter aw =5) (
  input clk,
  input rst,
  input cy_we_i,
  output cy_we_o,
  input supv,
  input wb_freeze,
  input [aw-1:0] addrw,
  input [dw-1:0] dataw,
  input we,
  input flushpipe,
  input id_freeze,
  input [aw-1:0] addra,
  input [aw-1:0] addrb,
  output [dw-1:0] dataa,
  output [dw-1:0] datab,
  input rda,
  input rdb,
  input spr_cs,
  input spr_write,
  input [31:0] spr_addr,
  input [31:0] spr_dat_i,
  output [31:0] spr_dat_o,
  input du_read) ; 
    
    
   wire [dw-1:0] from_rfa ;  
   wire [dw-1:0] from_rfb ;  
   wire [aw-1:0] rf_addra ;  
   wire [aw-1:0] rf_addrw ;  
   wire [dw-1:0] rf_dataw ;  
   wire rf_we ;  
   wire spr_valid ;  
   wire rf_ena ;  
   wire rf_enb ;  
   reg rf_we_allow ;  
   reg spr_du_cs ;  
   wire spr_cs_fe ;  
   reg [aw-1:0] addra_last ;  
  always @( posedge clk)
       if (rf_ena&!(spr_cs_fe|(du_read&spr_cs)))
          addra_last <=addra;
 
  always @( posedge clk)
       spr_du_cs <=spr_cs&du_read;
 
  assign spr_cs_fe=spr_du_cs&!(spr_cs&du_read); 
  assign spr_valid=spr_cs&(spr_addr[10:5]==6'd32); 
  assign spr_dat_o=from_rfa; 
  assign dataa=from_rfa; 
  assign datab=from_rfb; 
  assign rf_addra=(spr_valid&!spr_write) ? spr_addr[4:0]:spr_cs_fe ? addra_last:addra; 
  assign rf_addrw=(spr_valid&spr_write) ? spr_addr[4:0]:addrw; 
  assign rf_dataw=(spr_valid&spr_write) ? spr_dat_i:dataw; 
  always @(  posedge rst or  posedge clk)
       if (rst==(1'b1))
          rf_we_allow <=1'b1;
        else 
          if (~wb_freeze)
             rf_we_allow <=~flushpipe;
 
  assign rf_we=((spr_valid&spr_write)|(we&~wb_freeze))&rf_we_allow; 
  assign cy_we_o=cy_we_i&&~wb_freeze&&rf_we_allow; 
  assign rf_ena=(rda&~id_freeze)|(spr_valid&!spr_write)|spr_cs_fe; 
  assign rf_enb=rdb&~id_freeze; 
  or1200_dpram #(.aw(5),.dw(32))rf_a(.clk_a(clk),.ce_a(rf_ena),.addr_a(rf_addra),.do_a(from_rfa),.clk_b(clk),.ce_b(rf_we),.we_b(rf_we),.addr_b(rf_addrw),.di_b(rf_dataw)); 
  or1200_dpram #(.aw(5),.dw(32))rf_b(.clk_a(clk),.ce_a(rf_enb),.addr_a(addrb),.do_a(from_rfb),.clk_b(clk),.ce_b(rf_we),.we_b(rf_we),.addr_b(rf_addrw),.di_b(rf_dataw)); 
endmodule
 
module or1200_fpu_post_norm_addsub #(
 parameter FP_WIDTH =32,
 parameter MUL_SERIAL =0,
 parameter MUL_COUNT =11,
 parameter FRAC_WIDTH =23,
 parameter EXP_WIDTH =8,
 parameter ZERO_VECTOR =31'd0,
 parameter INF =31'b1111111100000000000000000000000,
 parameter QNAN =31'b1111111110000000000000000000000,
 parameter SNAN =31'b1111111100000000000000000000001) (
  input clk_i,
  input [FP_WIDTH-1:0] opa_i,
  input [FP_WIDTH-1:0] opb_i,
  input [FRAC_WIDTH+4:0] fract_28_i,
  input [EXP_WIDTH-1:0] exp_i,
  input sign_i,
  input fpu_op_i,
  input [1:0] rmode_i,
  output reg  [FP_WIDTH-1:0] output_o,
  output reg  ine_o) ; 
    
    
    
    
    
    
    
    
    
   wire [FP_WIDTH-1:0] s_opa_i ;  
   wire [FP_WIDTH-1:0] s_opb_i ;  
   wire [FRAC_WIDTH+4:0] s_fract_28_i ;  
   wire [EXP_WIDTH-1:0] s_exp_i ;  
   wire s_sign_i ;  
   wire s_fpu_op_i ;  
   wire [1:0] s_rmode_i ;  
   wire [FP_WIDTH-1:0] s_output_o ;  
   wire s_ine_o ;  
   wire s_overflow ;  
   wire [5:0] s_zeros ;  
   reg [5:0] s_shr1 ;  
   reg [5:0] s_shl1 ;  
   wire s_shr2,s_carry ;  
   wire [9:0] s_exp10 ;  
   reg [EXP_WIDTH:0] s_expo9_1 ;  
   wire [EXP_WIDTH:0] s_expo9_2 ;  
   wire [EXP_WIDTH:0] s_expo9_3 ;  
   reg [FRAC_WIDTH+4:0] s_fracto28_1 ;  
   wire [FRAC_WIDTH+4:0] s_fracto28_2 ;  
   wire [FRAC_WIDTH+4:0] s_fracto28_rnd ;  
   wire s_roundup ;  
   wire s_sticky ;  
   wire s_zero_fract ;  
   wire s_lost ;  
   wire s_infa,s_infb ;  
   wire s_nan_in,s_nan_op,s_nan_a,s_nan_b,s_nan_sign ;  
  assign s_opa_i=opa_i; 
  assign s_opb_i=opb_i; 
  assign s_fract_28_i=fract_28_i; 
  assign s_exp_i=exp_i; 
  assign s_sign_i=sign_i; 
  assign s_fpu_op_i=fpu_op_i; 
  assign s_rmode_i=rmode_i; 
  always @( posedge clk_i)
       begin 
         output_o <=s_output_o;
         ine_o <=s_ine_o;
       end
  
  assign s_carry=s_fract_28_i[27]; 
   reg [5:0] lzeroes ;  
  always @( s_fract_28_i)
       casez (s_fract_28_i[26:0])
        27 'b1??????????????????????????:
           lzeroes =0;
        27 'b01?????????????????????????:
           lzeroes =1;
        27 'b001????????????????????????:
           lzeroes =2;
        27 'b0001???????????????????????:
           lzeroes =3;
        27 'b00001??????????????????????:
           lzeroes =4;
        27 'b000001?????????????????????:
           lzeroes =5;
        27 'b0000001????????????????????:
           lzeroes =6;
        27 'b00000001???????????????????:
           lzeroes =7;
        27 'b000000001??????????????????:
           lzeroes =8;
        27 'b0000000001?????????????????:
           lzeroes =9;
        27 'b00000000001????????????????:
           lzeroes =10;
        27 'b000000000001???????????????:
           lzeroes =11;
        27 'b0000000000001??????????????:
           lzeroes =12;
        27 'b00000000000001?????????????:
           lzeroes =13;
        27 'b000000000000001????????????:
           lzeroes =14;
        27 'b0000000000000001???????????:
           lzeroes =15;
        27 'b00000000000000001??????????:
           lzeroes =16;
        27 'b000000000000000001?????????:
           lzeroes =17;
        27 'b0000000000000000001????????:
           lzeroes =18;
        27 'b00000000000000000001???????:
           lzeroes =19;
        27 'b000000000000000000001??????:
           lzeroes =20;
        27 'b0000000000000000000001?????:
           lzeroes =21;
        27 'b00000000000000000000001????:
           lzeroes =22;
        27 'b000000000000000000000001???:
           lzeroes =23;
        27 'b0000000000000000000000001??:
           lzeroes =24;
        27 'b00000000000000000000000001?:
           lzeroes =25;
        27 'b000000000000000000000000001:
           lzeroes =26;
        27 'b000000000000000000000000000:
           lzeroes =27;
       endcase
  
  assign s_zeros=s_fract_28_i[27] ? 0:lzeroes; 
  assign s_exp10={2'd0,s_exp_i}+{9'd0,s_carry}-{4'd0,s_zeros}; 
  always @( posedge clk_i)
       begin 
         if (s_exp10[9]|!(|s_exp10))
            begin 
              s_shr1 <=0;
              s_expo9_1 <=9'd1;
              if (|s_exp_i)
                 s_shl1 <=s_exp_i[5:0]-6'd1;
               else 
                 s_shl1 <=0;
            end 
          else 
            if (s_exp10[8])
               begin 
                 s_shr1 <=0;
                 s_shl1 <=0;
                 s_expo9_1 <=9'b011111111;
               end 
             else 
               begin 
                 s_shr1 <={5'd0,s_carry};
                 s_shl1 <=s_zeros;
                 s_expo9_1 <=s_exp10[8:0];
               end 
       end
  
  always @( posedge clk_i)
       if (|s_shr1)
          s_fracto28_1 <=s_fract_28_i>>s_shr1;
        else 
          s_fracto28_1 <=s_fract_28_i<<s_shl1;
 
  assign s_expo9_2=(s_fracto28_1[27:26]==2'b00) ? s_expo9_1-9'd1:s_expo9_1; 
  assign s_sticky=s_fracto28_1[0]|(s_fract_28_i[0]&s_fract_28_i[27]); 
  assign s_roundup=s_rmode_i==2'b00 ? s_fracto28_1[2]&((s_fracto28_1[1]|s_sticky)|s_fracto28_1[3]):s_rmode_i==2'b10 ? (s_fracto28_1[2]|s_fracto28_1[1]|s_sticky)&!s_sign_i:s_rmode_i==2'b11 ? (s_fracto28_1[2]|s_fracto28_1[1]|s_sticky)&s_sign_i:0; 
  assign s_fracto28_rnd=s_roundup ? s_fracto28_1+28'b0000_0000_0000_0000_0000_0000_1000:s_fracto28_1; 
  assign s_shr2=s_fracto28_rnd[27]; 
  assign s_expo9_3=(s_shr2&s_expo9_2!=9'b011111111) ? s_expo9_2+9'b000000001:s_expo9_2; 
  assign s_fracto28_2=s_shr2 ? {1'b0,s_fracto28_rnd[27:1]}:s_fracto28_rnd; 
  assign s_infa=&s_opa_i[30:23]; 
  assign s_infb=&s_opb_i[30:23]; 
  assign s_nan_a=s_infa&(|s_opa_i[22:0]); 
  assign s_nan_b=s_infb&(|s_opb_i[22:0]); 
  assign s_nan_in=s_nan_a|s_nan_b; 
  assign s_nan_op=(s_infa&s_infb)&(s_opa_i[31]^(s_fpu_op_i^s_opb_i[31])); 
  assign s_nan_sign=(s_nan_a&s_nan_b) ? s_sign_i:s_nan_a ? s_opa_i[31]:s_opb_i[31]; 
  assign s_lost=(s_shr1[0]&s_fract_28_i[0])|(s_shr2&s_fracto28_rnd[0])|(|s_fracto28_2[2:0]); 
  assign s_ine_o=(s_lost|s_overflow)&!(s_infa|s_infb); 
  assign s_overflow=s_expo9_3==9'b011111111&!(s_infa|s_infb); 
  assign s_zero_fract=s_zeros==27&!s_fract_28_i[27]; 
  assign s_output_o=(s_nan_in|s_nan_op) ? {s_nan_sign,QNAN}:(s_infa|s_infb)|s_overflow ? {s_sign_i,INF}:s_zero_fract ? {s_sign_i,ZERO_VECTOR}:{s_sign_i,s_expo9_3[7:0],s_fracto28_2[25:3]}; 
endmodule
 
module or1200_qmem_top #(
 parameter dw =32) (
  input clk,
  input rst,
  input [31:0] qmemimmu_adr_i,
  input qmemimmu_cycstb_i,
  input qmemimmu_ci_i,
  input [3:0] qmemicpu_sel_i,
  input [3:0] qmemicpu_tag_i,
  output [31:0] qmemicpu_dat_o,
  output qmemicpu_ack_o,
  output qmemimmu_rty_o,
  output qmemimmu_err_o,
  output [3:0] qmemimmu_tag_o,
  output [31:0] icqmem_adr_o,
  output icqmem_cycstb_o,
  output icqmem_ci_o,
  output [3:0] icqmem_sel_o,
  output [3:0] icqmem_tag_o,
  input [31:0] icqmem_dat_i,
  input icqmem_ack_i,
  input icqmem_rty_i,
  input icqmem_err_i,
  input [3:0] icqmem_tag_i,
  input [31:0] qmemdmmu_adr_i,
  input qmemdmmu_cycstb_i,
  input qmemdmmu_ci_i,
  input qmemdcpu_we_i,
  input [3:0] qmemdcpu_sel_i,
  input [3:0] qmemdcpu_tag_i,
  input [31:0] qmemdcpu_dat_i,
  output [31:0] qmemdcpu_dat_o,
  output qmemdcpu_ack_o,
  output qmemdcpu_rty_o,
  output qmemdmmu_err_o,
  output [3:0] qmemdmmu_tag_o,
  output [31:0] dcqmem_adr_o,
  output dcqmem_cycstb_o,
  output dcqmem_ci_o,
  output dcqmem_we_o,
  output [3:0] dcqmem_sel_o,
  output [3:0] dcqmem_tag_o,
  output [dw-1:0] dcqmem_dat_o,
  input [dw-1:0] dcqmem_dat_i,
  input dcqmem_ack_i,
  input dcqmem_rty_i,
  input dcqmem_err_i,
  input [3:0] dcqmem_tag_i) ; 
    
  assign qmemicpu_dat_o=icqmem_dat_i; 
  assign qmemicpu_ack_o=icqmem_ack_i; 
  assign qmemimmu_rty_o=icqmem_rty_i; 
  assign qmemimmu_err_o=icqmem_err_i; 
  assign qmemimmu_tag_o=icqmem_tag_i; 
  assign icqmem_adr_o=qmemimmu_adr_i; 
  assign icqmem_cycstb_o=qmemimmu_cycstb_i; 
  assign icqmem_ci_o=qmemimmu_ci_i; 
  assign icqmem_sel_o=qmemicpu_sel_i; 
  assign icqmem_tag_o=qmemicpu_tag_i; 
  assign qmemdcpu_dat_o=dcqmem_dat_i; 
  assign qmemdcpu_ack_o=dcqmem_ack_i; 
  assign qmemdcpu_rty_o=dcqmem_rty_i; 
  assign qmemdmmu_err_o=dcqmem_err_i; 
  assign qmemdmmu_tag_o=dcqmem_tag_i; 
  assign dcqmem_adr_o=qmemdmmu_adr_i; 
  assign dcqmem_cycstb_o=qmemdmmu_cycstb_i; 
  assign dcqmem_ci_o=qmemdmmu_ci_i; 
  assign dcqmem_we_o=qmemdcpu_we_i; 
  assign dcqmem_sel_o=qmemdcpu_sel_i; 
  assign dcqmem_tag_o=qmemdcpu_tag_i; 
  assign dcqmem_dat_o=qmemdcpu_dat_i; 
endmodule
 
module or1200_du #(
 parameter dw =32,
 parameter aw =32) (
  input clk,
  input rst,
  input dcpu_cycstb_i,
  input dcpu_we_i,
  input [31:0] dcpu_adr_i,
  input [31:0] dcpu_dat_lsu,
  input [31:0] dcpu_dat_dc,
  input [1-1:0] icpu_cycstb_i,
  input ex_freeze,
  input [3-1:0] branch_op,
  input [dw-1:0] ex_insn,
  input [31:0] id_pc,
  input [31:0] spr_dat_npc,
  input [31:0] rf_dataw,
  output [14-1:0] du_dsr,
  output [24:0] du_dmr1,
  output du_stall,
  output [aw-1:0] du_addr,
  input [dw-1:0] du_dat_i,
  output [dw-1:0] du_dat_o,
  output du_read,
  output du_write,
  input [13:0] du_except_stop,
  output du_hwbkpt,
  output du_flush_pipe,
  input spr_cs,
  input spr_write,
  input [aw-1:0] spr_addr,
  input [dw-1:0] spr_dat_i,
  output reg  [dw-1:0] spr_dat_o,
  input dbg_stall_i,
  input dbg_ewt_i,
  output [3:0] dbg_lss_o,
  output reg  [1:0] dbg_is_o,
  output [10:0] dbg_wp_o,
  output dbg_bp_o,
  input dbg_stb_i,
  input dbg_we_i,
  input [aw-1:0] dbg_adr_i,
  input [dw-1:0] dbg_dat_i,
  output reg  [dw-1:0] dbg_dat_o,
  output reg  dbg_ack_o) ; 
    
    
  assign dbg_lss_o=4'b0000; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          dbg_is_o <=2'b00;
        else 
          if (!ex_freeze&~((ex_insn[31:26]==6'b000101)&ex_insn[16]))
             dbg_is_o <=~dbg_is_o;
 
  assign dbg_wp_o=11'b000_0000_0000; 
  assign du_stall=dbg_stall_i; 
  assign du_addr=dbg_adr_i; 
  assign du_dat_o=dbg_dat_i; 
  assign du_read=dbg_stb_i&&!dbg_we_i; 
  assign du_write=dbg_stb_i&&dbg_we_i; 
   reg du_flush_pipe_r ;  
   reg dbg_stall_i_r ;  
  assign du_flush_pipe=du_flush_pipe_r; 
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              du_flush_pipe_r <=1'b0;
            end 
          else 
            begin 
              du_flush_pipe_r <=(dbg_stall_i_r&&!dbg_stall_i&&|du_except_stop);
            end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              dbg_stall_i_r <=1'b0;
            end 
          else 
            begin 
              dbg_stall_i_r <=dbg_stall_i;
            end 
       end
  
   reg dbg_ack ;  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              dbg_ack <=1'b0;
              dbg_ack_o <=1'b0;
            end 
          else 
            begin 
              dbg_ack <=dbg_stb_i;
              dbg_ack_o <=dbg_ack&dbg_stb_i;
            end 
       end
  
  always @( posedge clk)
       dbg_dat_o <=du_dat_i;
 
   reg [24:0] dmr1 ;  
  assign du_dmr1=dmr1; 
   wire [23:0] dmr2 ;  
   reg [14-1:0] dsr ;  
   reg [13:0] drr ;  
   wire [31:0] dvr0 ;  
   wire [31:0] dvr1 ;  
   wire [31:0] dvr2 ;  
   wire [31:0] dvr3 ;  
   wire [31:0] dvr4 ;  
   wire [31:0] dvr5 ;  
   wire [31:0] dvr6 ;  
   wire [31:0] dvr7 ;  
   wire [7:0] dcr0 ;  
   wire [7:0] dcr1 ;  
   wire [7:0] dcr2 ;  
   wire [7:0] dcr3 ;  
   wire [7:0] dcr4 ;  
   wire [7:0] dcr5 ;  
   wire [7:0] dcr6 ;  
   wire [7:0] dcr7 ;  
   wire [31:0] dwcr0 ;  
   wire [31:0] dwcr1 ;  
   wire dmr1_sel ;  
   wire dmr2_sel ;  
   wire dsr_sel ;  
   wire drr_sel ;  
   wire dvr0_sel,dvr1_sel,dvr2_sel,dvr3_sel,dvr4_sel,dvr5_sel,dvr6_sel,dvr7_sel ;  
   wire dcr0_sel,dcr1_sel,dcr2_sel,dcr3_sel,dcr4_sel,dcr5_sel,dcr6_sel,dcr7_sel ;  
   wire dwcr0_sel,dwcr1_sel ;  
   reg dbg_bp_r ;  
   reg ex_freeze_q ;  
   reg du_hwbkpt_hold ;  
   reg [13:0] except_stop ;  
   wire [31:0] tbia_dat_o ;  
   wire [31:0] tbim_dat_o ;  
   wire [31:0] tbar_dat_o ;  
   wire [31:0] tbts_dat_o ;  
  assign dmr1_sel=(spr_cs&&(spr_addr[10:0]==11'd16)); 
  assign dsr_sel=(spr_cs&&(spr_addr[10:0]==11'd20)); 
  assign drr_sel=(spr_cs&&(spr_addr[10:0]==11'd21)); 
  always @( posedge clk)
       ex_freeze_q <=ex_freeze;
 
  always @(  du_except_stop or  ex_freeze_q)
       begin 
         except_stop =14'b00_0000_0000_0000;
         casez (du_except_stop)
          14 'b1?_????_????_????:
             except_stop [4]=1'b1;
          14 'b01_????_????_????:
             begin 
               except_stop [7]=1'b1;
             end 
          14 'b00_1???_????_????:
             begin 
               except_stop [9]=1'b1;
             end 
          14 'b00_01??_????_????:
             except_stop [3]=1'b1;
          14 'b00_001?_????_????:
             begin 
               except_stop [1]=1'b1;
             end 
          14 'b00_0001_????_????:
             except_stop [6]=1'b1;
          14 'b00_0000_1???_????:
             begin 
               except_stop [5]=1'b1;
             end 
          14 'b00_0000_01??_????:
             begin 
               except_stop [8]=1'b1;
             end 
          14 'b00_0000_001?_????:
             except_stop [2]=1'b1;
          14 'b00_0000_0001_????:
             except_stop [1]=1'b1;
          14 'b00_0000_0000_1???:
             begin 
               except_stop [10]=1'b1;
             end 
          14 'b00_0000_0000_01??:
             begin 
               except_stop [13]=1'b1&~ex_freeze_q;
             end 
          14 'b00_0000_0000_001?:
             begin 
               except_stop [12]=1'b1;
             end 
          14 'b00_0000_0000_0001:
             except_stop [11]=1'b1&~ex_freeze_q;
          default :
             except_stop =14'b00_0000_0000_0000;
         endcase 
       end
  
  assign dbg_bp_o=dbg_bp_r; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          dbg_bp_r <=1'b0;
        else 
          if (!ex_freeze)
             dbg_bp_r <=|except_stop|~((ex_insn[31:26]==6'b000101)&ex_insn[16])&dmr1[22]|(branch_op!=3'd0)&(branch_op!=3'd6)&dmr1[23];
           else 
             dbg_bp_r <=|except_stop;
 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          dmr1 <=25'h000_0000;
        else 
          if (dmr1_sel&&spr_write)
             dmr1 <={1'b0,spr_dat_i[23:22],22'h00_0000};
 
  assign dmr2=24'h00_0000; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          dsr <={14{1'b0}};
        else 
          if (dsr_sel&&spr_write)
             dsr <=spr_dat_i[14-1:0];
 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          drr <=14'b0;
        else 
          if (drr_sel&&spr_write)
             drr <=spr_dat_i[13:0];
           else 
             drr <=drr|except_stop;
 
  assign dvr0=32'h0000_0000; 
  assign dvr1=32'h0000_0000; 
  assign dvr2=32'h0000_0000; 
  assign dvr3=32'h0000_0000; 
  assign dvr4=32'h0000_0000; 
  assign dvr5=32'h0000_0000; 
  assign dvr6=32'h0000_0000; 
  assign dvr7=32'h0000_0000; 
  assign dcr0=8'h00; 
  assign dcr1=8'h00; 
  assign dcr2=8'h00; 
  assign dcr3=8'h00; 
  assign dcr4=8'h00; 
  assign dcr5=8'h00; 
  assign dcr6=8'h00; 
  assign dcr7=8'h00; 
  assign dwcr0=32'h0000_0000; 
  assign dwcr1=32'h0000_0000; 
  always @(                       spr_addr or  dsr or  drr or  dmr1 or  dmr2 or  dvr0 or  dvr1 or  dvr2 or  dvr3 or  dvr4 or  dvr5 or  dvr6 or  dvr7 or  dcr0 or  dcr1 or  dcr2 or  dcr3 or  dcr4 or  dcr5 or  dcr6 or  dcr7 or  dwcr0 or  dwcr1)
       casez (spr_addr[10:0])
        11 'd16:
           spr_dat_o ={7'h00,dmr1};
        11 'd20:
           spr_dat_o ={18'b0,dsr};
        11 'd21:
           spr_dat_o ={18'b0,drr};
        default :
           spr_dat_o =32'h0000_0000;
       endcase
  
  assign du_dsr=dsr; 
  assign du_hwbkpt=1'b0; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          du_hwbkpt_hold <=1'b0;
        else 
          if (du_hwbkpt&ex_freeze)
             du_hwbkpt_hold <=1'b1;
           else 
             if (!ex_freeze)
                du_hwbkpt_hold <=1'b0;
 
  assign tbia_dat_o=32'h0000_0000; 
  assign tbim_dat_o=32'h0000_0000; 
  assign tbar_dat_o=32'h0000_0000; 
  assign tbts_dat_o=32'h0000_0000; 
endmodule
 
module or1200_fpu_arith #(
 parameter FP_WIDTH =32,
 parameter MUL_SERIAL =1,
 parameter MUL_COUNT =34,
 parameter FRAC_WIDTH =23,
 parameter EXP_WIDTH =8,
 parameter ZERO_VECTOR =31'd0,
 parameter INF =31'b1111111100000000000000000000000,
 parameter QNAN =31'b11111111_10000000000000000000000,
 parameter SNAN =31'b11111111_00000000000000000000001,
 parameter t_state_waiting =0,
 parameter t_state_busy =1) (
  input clk_i,
  input [FP_WIDTH-1:0] opa_i,
  input [FP_WIDTH-1:0] opb_i,
  input [2:0] fpu_op_i,
  input [1:0] rmode_i,
  output reg  [FP_WIDTH-1:0] output_o,
  input start_i,
  output reg  ready_o,
  output reg  ine_o,
  output reg  overflow_o,
  output reg  underflow_o,
  output reg  div_zero_o,
  output reg  inf_o,
  output reg  zero_o,
  output reg  qnan_o,
  output reg  snan_o) ; 
    
    
    
    
    
    
    
    
    
   reg [FP_WIDTH-1:0] s_opa_i ;  
   reg [FP_WIDTH-1:0] s_opb_i ;  
   reg [2:0] s_fpu_op_i ;  
   reg [1:0] s_rmode_i ;  
   reg s_start_i ;  
   reg [5:0] s_count ;  
   reg [FP_WIDTH-1:0] s_output1 ;  
   reg [FP_WIDTH-1:0] s_output_o ;  
   reg s_ine_o ;  
   wire s_overflow_o,s_underflow_o,s_div_zero_o,s_inf_o,s_zero_o,s_qnan_o,s_snan_o ;  
   wire s_infa,s_infb ;  
    
    
   reg s_state ;  
   wire [27:0] prenorm_addsub_fracta_28_o ;  
   wire [27:0] prenorm_addsub_fractb_28_o ;  
   wire [7:0] prenorm_addsub_exp_o ;  
   wire [27:0] addsub_fract_o ;  
   wire addsub_sign_o ;  
   wire [31:0] postnorm_addsub_output_o ;  
   wire postnorm_addsub_ine_o ;  
   wire [9:0] pre_norm_mul_exp_10 ;  
   wire [23:0] pre_norm_mul_fracta_24 ;  
   wire [23:0] pre_norm_mul_fractb_24 ;  
   wire [47:0] mul_fract_48 ;  
   wire [47:0] mul_24_fract_48 ;  
   wire mul_24_sign ;  
   wire [47:0] serial_mul_fract_48 ;  
   wire serial_mul_sign ;  
   wire mul_sign ;  
   wire [31:0] post_norm_mul_output ;  
   wire post_norm_mul_ine ;  
   wire [49:0] pre_norm_div_dvdnd ;  
   wire [26:0] pre_norm_div_dvsor ;  
   wire [EXP_WIDTH+1:0] pre_norm_div_exp ;  
   wire [26:0] serial_div_qutnt ;  
   wire [26:0] serial_div_rmndr ;  
   wire serial_div_sign ;  
   wire serial_div_div_zero ;  
   wire [31:0] post_norm_div_output ;  
   wire post_norm_div_ine ;  
   wire [51:0] pre_norm_sqrt_fracta_o ;  
   wire [7:0] pre_norm_sqrt_exp_o ;  
   wire [25:0] sqrt_sqr_o ;  
   wire sqrt_ine_o ;  
   wire [31:0] post_norm_sqrt_output ;  
   wire post_norm_sqrt_ine_o ;  
  or1200_fpu_pre_norm_addsub fpu_prenorm_addsub(.clk_i(clk_i),.opa_i(s_opa_i),.opb_i(s_opb_i),.fracta_28_o(prenorm_addsub_fracta_28_o),.fractb_28_o(prenorm_addsub_fractb_28_o),.exp_o(prenorm_addsub_exp_o)); 
  or1200_fpu_addsub fpu_addsub(.clk_i(clk_i),.fpu_op_i(s_fpu_op_i[0]),.fracta_i(prenorm_addsub_fracta_28_o),.fractb_i(prenorm_addsub_fractb_28_o),.signa_i(s_opa_i[31]),.signb_i(s_opb_i[31]),.fract_o(addsub_fract_o),.sign_o(addsub_sign_o)); 
  or1200_fpu_post_norm_addsub fpu_postnorm_addsub(.clk_i(clk_i),.opa_i(s_opa_i),.opb_i(s_opb_i),.fract_28_i(addsub_fract_o),.exp_i(prenorm_addsub_exp_o),.sign_i(addsub_sign_o),.fpu_op_i(s_fpu_op_i[0]),.rmode_i(s_rmode_i),.output_o(postnorm_addsub_output_o),.ine_o(postnorm_addsub_ine_o)); 
  or1200_fpu_pre_norm_mul fpu_pre_norm_mul(.clk_i(clk_i),.opa_i(s_opa_i),.opb_i(s_opb_i),.exp_10_o(pre_norm_mul_exp_10),.fracta_24_o(pre_norm_mul_fracta_24),.fractb_24_o(pre_norm_mul_fractb_24)); 
  or1200_fpu_mul fpu_mul(.clk_i(clk_i),.fracta_i(pre_norm_mul_fracta_24),.fractb_i(pre_norm_mul_fractb_24),.signa_i(s_opa_i[31]),.signb_i(s_opb_i[31]),.start_i(s_start_i),.fract_o(serial_mul_fract_48),.sign_o(serial_mul_sign),.ready_o()); 
  assign mul_fract_48=MUL_SERIAL ? serial_mul_fract_48:mul_24_fract_48; 
  assign mul_sign=MUL_SERIAL ? serial_mul_sign:mul_24_sign; 
  or1200_fpu_post_norm_mul fpu_post_norm_mul(.clk_i(clk_i),.opa_i(s_opa_i),.opb_i(s_opb_i),.exp_10_i(pre_norm_mul_exp_10),.fract_48_i(mul_fract_48),.sign_i(mul_sign),.rmode_i(s_rmode_i),.output_o(post_norm_mul_output),.ine_o(post_norm_mul_ine)); 
  or1200_fpu_pre_norm_div fpu_pre_norm_div(.clk_i(clk_i),.opa_i(s_opa_i),.opb_i(s_opb_i),.exp_10_o(pre_norm_div_exp),.dvdnd_50_o(pre_norm_div_dvdnd),.dvsor_27_o(pre_norm_div_dvsor)); 
  or1200_fpu_div fpu_div(.clk_i(clk_i),.dvdnd_i(pre_norm_div_dvdnd),.dvsor_i(pre_norm_div_dvsor),.sign_dvd_i(s_opa_i[31]),.sign_div_i(s_opb_i[31]),.start_i(s_start_i),.ready_o(),.qutnt_o(serial_div_qutnt),.rmndr_o(serial_div_rmndr),.sign_o(serial_div_sign),.div_zero_o(serial_div_div_zero)); 
  or1200_fpu_post_norm_div fpu_post_norm_div(.clk_i(clk_i),.opa_i(s_opa_i),.opb_i(s_opb_i),.qutnt_i(serial_div_qutnt),.rmndr_i(serial_div_rmndr),.exp_10_i(pre_norm_div_exp),.sign_i(serial_div_sign),.rmode_i(s_rmode_i),.output_o(post_norm_div_output),.ine_o(post_norm_div_ine)); 
  always @( posedge clk_i)
       begin 
         s_opa_i <=opa_i;
         s_opb_i <=opb_i;
         s_fpu_op_i <=fpu_op_i;
         s_rmode_i <=rmode_i;
         s_start_i <=start_i;
       end
  
  always @( posedge clk_i)
       begin 
         output_o <=s_output_o;
         ine_o <=s_ine_o;
         overflow_o <=s_overflow_o;
         underflow_o <=s_underflow_o;
         div_zero_o <=s_div_zero_o&!s_infa;
         inf_o <=s_inf_o;
         zero_o <=s_zero_o;
         qnan_o <=s_qnan_o;
         snan_o <=s_snan_o;
       end
  
  always @( posedge clk_i)
       begin 
         if (s_start_i)
            begin 
              s_state <=t_state_busy;
              s_count <=0;
            end 
          else 
            if (s_state==t_state_busy)
               begin 
                 if (((s_count==6)&((fpu_op_i==3'd0)|(fpu_op_i==3'd1)))|((s_count==MUL_COUNT)&(fpu_op_i==3'd2))|((s_count==33)&(fpu_op_i==3'd3)))
                    begin 
                      s_state <=t_state_waiting;
                      ready_o <=1;
                      s_count <=0;
                    end 
                  else 
                    s_count <=s_count+1;
               end 
             else 
               begin 
                 s_state <=t_state_waiting;
                 ready_o <=0;
               end 
       end
  
  always @( posedge clk_i)
       begin 
         case (fpu_op_i)
          3 'd0,3'd1:
             begin 
               s_output1 <=postnorm_addsub_output_o;
               s_ine_o <=postnorm_addsub_ine_o;
             end 
          3 'd2:
             begin 
               s_output1 <=post_norm_mul_output;
               s_ine_o <=post_norm_mul_ine;
             end 
          3 'd3:
             begin 
               s_output1 <=post_norm_div_output;
               s_ine_o <=post_norm_div_ine;
             end 
          default :
             begin 
               s_output1 <=0;
               s_ine_o <=0;
             end 
         endcase 
       end
  
  assign s_infa=&s_opa_i[30:23]; 
  assign s_infb=&s_opb_i[30:23]; 
  always @*
       begin 
         if (s_rmode_i==2'd0|s_div_zero_o|s_infa|s_infb|s_qnan_o|s_qnan_o)
            s_output_o =s_output1;
          else 
            if (s_rmode_i==2'd1&(&s_output1[30:23]))
               s_output_o ={s_output1[31],31'b1111111_01111111_11111111_11111111};
             else 
               if (s_rmode_i==2'd2&(&s_output1[31:23]))
                  s_output_o ={32'b11111111_01111111_11111111_11111111};
                else 
                  if (s_rmode_i==2'd3)
                     begin 
                       if (((s_fpu_op_i==3'd0)|(s_fpu_op_i==3'd1))&s_zero_o&(s_opa_i[31]|(s_fpu_op_i[0]^s_opb_i[31])))
                          s_output_o ={1'b1,s_output1[30:0]};
                        else 
                          if (s_output1[31:23]==9'b0_11111111)
                             s_output_o =32'b01111111011111111111111111111111;
                           else 
                             s_output_o =s_output1;
                     end 
                   else 
                     s_output_o =s_output1;
       end
  
  assign s_underflow_o=(s_output1[30:23]==8'h00)&s_ine_o; 
  assign s_overflow_o=(s_output1[30:23]==8'hff)&s_ine_o; 
  assign s_div_zero_o=serial_div_div_zero&fpu_op_i==3'd3; 
  assign s_inf_o=s_output1[30:23]==8'hff&!(s_qnan_o|s_snan_o); 
  assign s_zero_o=!(|s_output1[30:0]); 
  assign s_qnan_o=s_output1[30:0]==QNAN; 
  assign s_snan_o=s_output1[30:0]==SNAN; 
endmodule
 
module or1200_dc_top #(
 parameter dw =32,
 parameter aw =32) (
  input clk,
  input rst,
  output [dw-1:0] dcsb_dat_o,
  output [31:0] dcsb_adr_o,
  output dcsb_cyc_o,
  output dcsb_stb_o,
  output dcsb_we_o,
  output [3:0] dcsb_sel_o,
  output dcsb_cab_o,
  input [dw-1:0] dcsb_dat_i,
  input dcsb_ack_i,
  input dcsb_err_i,
  input dc_en,
  input [31:0] dcqmem_adr_i,
  input dcqmem_cycstb_i,
  input dcqmem_ci_i,
  input dcqmem_we_i,
  input [3:0] dcqmem_sel_i,
  input [3:0] dcqmem_tag_i,
  input [dw-1:0] dcqmem_dat_i,
  output [dw-1:0] dcqmem_dat_o,
  output dcqmem_ack_o,
  output dcqmem_rty_o,
  output dcqmem_err_o,
  output [3:0] dcqmem_tag_o,
  input dc_no_writethrough,
  input spr_cs,
  input spr_write,
  input [31:0] spr_dat_i,
  input [aw-1:0] spr_addr,
  output mtspr_dc_done) ; 
    
    
   wire tag_v ;  
   wire [20-2:0] tag ;  
   wire dirty ;  
   wire [dw-1:0] to_dcram ;  
   wire [dw-1:0] from_dcram ;  
   wire [3:0] dcram_we ;  
   wire dctag_we ;  
   wire [31:0] dc_addr ;  
   wire dcfsm_biu_read ;  
   wire dcfsm_biu_write ;  
   wire dcfsm_dcram_di_sel ;  
   wire dcfsm_biu_do_sel ;  
   reg tagcomp_miss ;  
   wire [13-1:4] dctag_addr ;  
   wire dctag_en ;  
   wire dctag_v ;  
   wire dctag_dirty ;  
   wire dc_block_invalidate ;  
   wire dc_block_flush ;  
   wire dc_block_writeback ;  
   wire dcfsm_first_hit_ack ;  
   wire dcfsm_first_miss_ack ;  
   wire dcfsm_first_miss_err ;  
   wire dcfsm_burst ;  
   wire dcfsm_tag_we ;  
   wire dcfsm_tag_valid ;  
   wire dcfsm_tag_dirty ;  
  assign dcsb_adr_o=dc_addr; 
  assign dc_block_invalidate=spr_cs&spr_write&((spr_addr[3-1:0]==3'd3)|(spr_addr[3-1:0]==3'd2)); 
  assign dc_block_flush=0; 
  assign dc_block_writeback=0; 
  assign dctag_we=dcfsm_tag_we|dc_block_invalidate; 
  assign dctag_addr=dc_block_invalidate ? spr_dat_i[13-1:4]:dc_addr[13-1:4]; 
  assign dctag_en=dc_block_invalidate|dc_en; 
  assign dctag_v=dc_block_invalidate ? 1'b0:dcfsm_tag_valid; 
  assign dctag_dirty=dc_block_invalidate ? 1'b0:dcfsm_tag_dirty; 
  assign dcsb_dat_o=dcfsm_biu_do_sel ? from_dcram:dcqmem_dat_i; 
  assign dcsb_cyc_o=(dc_en) ? dcfsm_biu_read|dcfsm_biu_write:dcqmem_cycstb_i; 
  assign dcsb_stb_o=(dc_en) ? dcfsm_biu_read|dcfsm_biu_write:dcqmem_cycstb_i; 
  assign dcsb_we_o=(dc_en) ? dcfsm_biu_write:dcqmem_we_i; 
  assign dcsb_sel_o=(dc_en&dcfsm_burst) ? 4'b1111:dcqmem_sel_i; 
  assign dcsb_cab_o=dc_en&dcfsm_burst&dcsb_cyc_o; 
  assign dcqmem_rty_o=~dcqmem_ack_o; 
  assign dcqmem_tag_o=dcqmem_err_o ? 4'hb:dcqmem_tag_i; 
  assign dcqmem_ack_o=dc_en ? dcfsm_first_hit_ack|dcfsm_first_miss_ack:dcsb_ack_i; 
  assign dcqmem_err_o=dc_en ? dcfsm_first_miss_err:dcsb_err_i; 
  assign to_dcram=(dcfsm_dcram_di_sel) ? dcsb_dat_i:dcqmem_dat_i; 
  assign dcqmem_dat_o=dcfsm_first_miss_ack|!dc_en ? dcsb_dat_i:from_dcram; 
   wire [31:13-1+1] dcqmem_adr_i_tag ;  
  assign dcqmem_adr_i_tag=dcqmem_adr_i[31:13-1+1]; 
  always @(   tag or  dcqmem_adr_i_tag or  tag_v)
       begin 
         if ((tag!=dcqmem_adr_i_tag)||!tag_v)
            tagcomp_miss =1'b1;
          else 
            tagcomp_miss =1'b0;
       end
  
  or1200_dc_fsm or1200_dc_fsm(.clk(clk),.rst(rst),.dc_en(dc_en),.dcqmem_cycstb_i(dcqmem_cycstb_i),.dcqmem_ci_i(dcqmem_ci_i),.dcqmem_we_i(dcqmem_we_i),.dcqmem_sel_i(dcqmem_sel_i),.tagcomp_miss(tagcomp_miss),.tag(tag),.tag_v(tag_v),.dirty(dirty),.biudata_valid(dcsb_ack_i),.biudata_error(dcsb_err_i),.lsu_addr(dcqmem_adr_i),.dcram_we(dcram_we),.biu_read(dcfsm_biu_read),.biu_write(dcfsm_biu_write),.dcram_di_sel(dcfsm_dcram_di_sel),.biu_do_sel(dcfsm_biu_do_sel),.first_hit_ack(dcfsm_first_hit_ack),.first_miss_ack(dcfsm_first_miss_ack),.first_miss_err(dcfsm_first_miss_err),.burst(dcfsm_burst),.tag_we(dcfsm_tag_we),.tag_valid(dcfsm_tag_valid),.tag_dirty(dcfsm_tag_dirty),.dc_addr(dc_addr),.dc_no_writethrough(dc_no_writethrough),.dc_block_flush(dc_block_flush),.dc_block_writeback(dc_block_writeback),.spr_dat_i(spr_dat_i),.mtspr_dc_done(mtspr_dc_done),.spr_cswe(spr_cs&spr_write)); 
  or1200_dc_ram or1200_dc_ram(.clk(clk),.rst(rst),.addr(dc_addr[13-1:2]),.en(dc_en),.we(dcram_we),.datain(to_dcram),.dataout(from_dcram)); 
  or1200_dc_tag or1200_dc_tag(.clk(clk),.rst(rst),.addr(dctag_addr),.en(dctag_en),.we(dctag_we),.datain({dc_addr[31:13-1+1],dctag_v,dctag_dirty}),.tag_v(tag_v),.tag(tag),.dirty(dirty)); 
endmodule
 
module or1200_immu_top #(
 parameter dw =32,
 parameter aw =32,
 parameter boot_adr =32'h00000100) (
  input clk,
  input rst,
  input ic_en,
  input immu_en,
  input supv,
  input [aw-1:0] icpu_adr_i,
  input icpu_cycstb_i,
  output reg  [aw-1:0] icpu_adr_o,
  output [3:0] icpu_tag_o,
  output icpu_rty_o,
  output icpu_err_o,
  input boot_adr_sel_i,
  input spr_cs,
  input spr_write,
  input [aw-1:0] spr_addr,
  input [31:0] spr_dat_i,
  output [31:0] spr_dat_o,
  input qmemimmu_rty_i,
  input qmemimmu_err_i,
  input [3:0] qmemimmu_tag_i,
  output [aw-1:0] qmemimmu_adr_o,
  output qmemimmu_cycstb_o,
  output qmemimmu_ci_o) ; 
    
    
    
   wire itlb_spr_access ;  
   wire [31:13] itlb_ppn ;  
   wire itlb_hit ;  
   wire itlb_uxe ;  
   wire itlb_sxe ;  
   wire [31:0] itlb_dat_o ;  
   wire itlb_en ;  
   wire itlb_ci ;  
   wire itlb_done ;  
   wire fault ;  
   wire miss ;  
   wire page_cross ;  
   reg [31:0] icpu_adr_default ;  
   reg icpu_adr_select ;  
   reg [31:13] icpu_vpn_r ;  
   reg itlb_en_r ;  
   reg dis_spr_access_frst_clk ;  
   reg dis_spr_access_scnd_clk ;  
   wire [31:0] icpu_adr_boot=boot_adr ;  
  always @(  posedge rst or  posedge clk)
       if (rst==(1'b1))
          begin 
            icpu_adr_default <=32'h0000_0100;
            icpu_adr_select <=1'b1;
          end 
        else 
          if (icpu_adr_select)
             begin 
               icpu_adr_default <=icpu_adr_boot;
               icpu_adr_select <=1'b0;
             end 
           else 
             begin 
               icpu_adr_default <=icpu_adr_i;
             end
  
  always @(   icpu_adr_boot or  icpu_adr_default or  icpu_adr_select)
       if (icpu_adr_select)
          icpu_adr_o =icpu_adr_boot;
        else 
          icpu_adr_o =icpu_adr_default;
 
  assign page_cross=icpu_adr_i[31:13]!=icpu_vpn_r; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          icpu_vpn_r <={32-13{1'b0}};
        else 
          icpu_vpn_r <=icpu_adr_i[31:13];
 
  assign itlb_spr_access=spr_cs&~dis_spr_access_scnd_clk; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          dis_spr_access_frst_clk <=1'b0;
        else 
          if (!icpu_rty_o)
             dis_spr_access_frst_clk <=1'b0;
           else 
             if (spr_cs)
                dis_spr_access_frst_clk <=1'b1;
 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          dis_spr_access_scnd_clk <=1'b0;
        else 
          if (!icpu_rty_o)
             dis_spr_access_scnd_clk <=1'b0;
           else 
             if (dis_spr_access_frst_clk)
                dis_spr_access_scnd_clk <=1'b1;
 
  assign icpu_tag_o=miss ? 4'hd:fault ? 4'hc:qmemimmu_tag_i; 
  assign icpu_rty_o=qmemimmu_rty_i; 
  assign icpu_err_o=miss|fault|qmemimmu_err_i; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          itlb_en_r <=1'b0;
        else 
          itlb_en_r <=itlb_en&~itlb_spr_access;
 
  assign itlb_done=itlb_en_r&~page_cross; 
  assign qmemimmu_cycstb_o=immu_en ? ~(miss|fault)&icpu_cycstb_i&~page_cross&itlb_done&~itlb_spr_access:icpu_cycstb_i&~page_cross; 
  assign qmemimmu_ci_o=immu_en ? itlb_ci:1'b0; 
  assign qmemimmu_adr_o=immu_en&itlb_done ? {itlb_ppn,icpu_adr_i[13-1:2],2'h0}:{icpu_vpn_r,icpu_adr_i[13-1:2],2'h0}; 
   reg [31:0] spr_dat_reg ;  
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          spr_dat_reg <=32'h0000_0000;
        else 
          if (spr_cs&!dis_spr_access_scnd_clk)
             spr_dat_reg <=itlb_dat_o;
 
  assign spr_dat_o=itlb_spr_access ? itlb_dat_o:spr_dat_reg; 
  assign fault=itlb_done&((!supv&!itlb_uxe)||(supv&!itlb_sxe)); 
  assign miss=itlb_done&!itlb_hit; 
  assign itlb_en=immu_en&icpu_cycstb_i; 
  or1200_immu_tlb or1200_immu_tlb(.clk(clk),.rst(rst),.tlb_en(itlb_en),.vaddr(icpu_adr_i),.hit(itlb_hit),.ppn(itlb_ppn),.uxe(itlb_uxe),.sxe(itlb_sxe),.ci(itlb_ci),.spr_cs(itlb_spr_access),.spr_write(spr_write),.spr_addr(spr_addr),.spr_dat_i(spr_dat_i),.spr_dat_o(itlb_dat_o)); 
endmodule
 
module or1200_spram_64x14 #(
 parameter aw =6,
 parameter dw =14) (
  input clk,
  input rst,
  input ce,
  input we,
  input oe,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq=(oe) ? mem[addr_reg]:{dw{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <={aw{1'b0}};
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we)
          mem [addr]<=di;
 
endmodule
 
module or1200_freeze (
  input clk,
  input rst,
  input [3-1:0] multicycle,
  input [2-1:0] wait_on,
  input flushpipe,
  input extend_flush,
  input lsu_stall,
  input if_stall,
  input lsu_unstall,
  input du_stall,
  input mac_stall,
  input force_dslot_fetch,
  input abort_ex,
  output genpc_freeze,
  output if_freeze,
  output id_freeze,
  output ex_freeze,
  output wb_freeze,
  input saving_if_insn,
  input fpu_done,
  input mtspr_done,
  input icpu_ack_i,
  input icpu_err_i) ; 
   wire multicycle_freeze ;  
   reg [3-1:0] multicycle_cnt ;  
   reg flushpipe_r ;  
   reg [2-1:0] waiting_on ;  
  assign genpc_freeze=(du_stall&!saving_if_insn)|flushpipe_r; 
  assign if_freeze=id_freeze|extend_flush; 
  assign id_freeze=(lsu_stall|(~lsu_unstall&if_stall)|multicycle_freeze|(|waiting_on)|force_dslot_fetch)|du_stall; 
  assign ex_freeze=wb_freeze; 
  assign wb_freeze=(lsu_stall|(~lsu_unstall&if_stall)|multicycle_freeze|(|waiting_on))|du_stall|abort_ex; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          flushpipe_r <=1'b0;
        else 
          if (icpu_ack_i|icpu_err_i)
             flushpipe_r <=flushpipe;
           else 
             if (!flushpipe)
                flushpipe_r <=1'b0;
 
  assign multicycle_freeze=|multicycle_cnt; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          multicycle_cnt <=3'd0;
        else 
          if (|multicycle_cnt)
             multicycle_cnt <=multicycle_cnt-3'd1;
           else 
             if (|multicycle&!ex_freeze)
                multicycle_cnt <=multicycle;
 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          waiting_on <=0;
        else 
          if ((waiting_on==2'd1)&!mac_stall)
             waiting_on <=0;
           else 
             if ((waiting_on==2'd2)&fpu_done)
                waiting_on <=0;
              else 
                if ((waiting_on==2'd3)&mtspr_done)
                   waiting_on <=0;
                 else 
                   if (!ex_freeze)
                      waiting_on <=wait_on;
 
endmodule
 
module or1200_spram_1024x32 #(
 parameter aw =10,
 parameter dw =32) (
  input clk,
  input rst,
  input ce,
  input we,
  input oe,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq=(oe) ? mem[addr_reg]:{dw{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <={aw{1'b0}};
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we)
          mem [addr]<=di;
 
endmodule
 
module or1200_genpc #(
 parameter boot_adr =32'h00000100) (
  input clk,
  input rst,
  output [31:0] icpu_adr_o,
  output icpu_cycstb_o,
  output [3:0] icpu_sel_o,
  output [3:0] icpu_tag_o,
  input icpu_rty_i,
  input [31:0] icpu_adr_i,
  input [3-1:0] pre_branch_op,
  input [3-1:0] branch_op,
  input [4-1:0] except_type,
  input except_prefix,
  input [31:2] id_branch_addrtarget,
  input [31:2] ex_branch_addrtarget,
  input [31:0] muxed_b,
  input [31:0] operand_b,
  input flag,
  input flagforw,
  output reg  ex_branch_taken,
  input except_start,
  input [31:0] epcr,
  input [31:0] spr_dat_i,
  input spr_pc_we,
  input genpc_refetch,
  input genpc_freeze,
  input no_more_dslot,
  input lsu_stall,
  input du_flush_pipe,
  input [31:0] spr_dat_npc) ; 
    
   reg [31:2] pcreg_default ;  
   reg pcreg_select ;  
   reg [31:2] pcreg ;  
   reg [31:0] pc ;  
   reg genpc_refetch_r ;  
   reg wait_lsu ;  
  assign icpu_adr_o=!no_more_dslot&!except_start&!spr_pc_we&!du_flush_pipe&(icpu_rty_i|genpc_refetch) ? icpu_adr_i:{pc[31:2],1'b0,ex_branch_taken|spr_pc_we}; 
  assign icpu_cycstb_o=~(genpc_freeze|(|pre_branch_op&&!icpu_rty_i)|wait_lsu); 
  assign icpu_sel_o=4'b1111; 
  assign icpu_tag_o=4'h1; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          wait_lsu <=1'b0;
        else 
          if (!wait_lsu&|pre_branch_op&lsu_stall)
             wait_lsu <=1'b1;
           else 
             if (wait_lsu&~|pre_branch_op)
                wait_lsu <=1'b0;
 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          genpc_refetch_r <=1'b0;
        else 
          if (genpc_refetch)
             genpc_refetch_r <=1'b1;
           else 
             genpc_refetch_r <=1'b0;
 
  always @(            pcreg or  ex_branch_addrtarget or  flag or  branch_op or  except_type or  except_start or  operand_b or  epcr or  spr_pc_we or  spr_dat_i or  except_prefix or  du_flush_pipe)
       begin 
         casez ({du_flush_pipe,spr_pc_we,except_start,branch_op})
          { 3'b000,3'd0}:
             begin 
               pc ={pcreg+30'd1,2'b0};
               ex_branch_taken =1'b0;
             end 
          { 3'b000,3'd1}:
             begin 
               pc ={ex_branch_addrtarget,2'b00};
               ex_branch_taken =1'b1;
             end 
          { 3'b000,3'd2}:
             begin 
               pc =operand_b;
               ex_branch_taken =1'b1;
             end 
          { 3'b000,3'd4}:
             if (flag)
                begin 
                  pc ={ex_branch_addrtarget,2'b00};
                  ex_branch_taken =1'b1;
                end 
              else 
                begin 
                  pc ={pcreg+30'd1,2'b0};
                  ex_branch_taken =1'b0;
                end 
          { 3'b000,3'd5}:
             if (flag)
                begin 
                  pc ={pcreg+30'd1,2'b0};
                  ex_branch_taken =1'b0;
                end 
              else 
                begin 
                  pc ={ex_branch_addrtarget,2'b00};
                  ex_branch_taken =1'b1;
                end 
          { 3'b000,3'd6}:
             begin 
               pc =epcr;
               ex_branch_taken =1'b1;
             end 
          { 3'b100,3'b???}:
             begin 
               pc =spr_dat_npc;
               ex_branch_taken =1'b1;
             end 
          { 3'b001,3'b???}:
             begin 
               pc ={(except_prefix ? 20'hF0000:20'h00000),except_type,8'h00};
               ex_branch_taken =1'b1;
             end 
          default :
             begin 
               pc =spr_dat_i;
               ex_branch_taken =1'b0;
             end 
         endcase 
       end
  
   wire [31:0] pcreg_boot=boot_adr ;  
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          begin 
            pcreg_default <=(boot_adr>>2)-4;
            pcreg_select <=1'b1;
          end 
        else 
          if (pcreg_select)
             begin 
               pcreg_default <=pcreg_boot[31:2];
               pcreg_select <=1'b0;
             end 
           else 
             if (spr_pc_we)
                begin 
                  pcreg_default <=spr_dat_i[31:2];
                end 
              else 
                if (du_flush_pipe|no_more_dslot|except_start|!genpc_freeze&!icpu_rty_i&!genpc_refetch)
                   begin 
                     pcreg_default <=pc[31:2];
                   end
  
  always @(   pcreg_boot or  pcreg_default or  pcreg_select)
       if (pcreg_select)
          pcreg =pcreg_boot[31:2];
        else 
          pcreg =pcreg_default;
 
endmodule
 
module or1200_spram_32x24 #(
 parameter aw =5,
 parameter dw =24) (
  input clk,
  input rst,
  input ce,
  input we,
  input oe,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq=(oe) ? mem[addr_reg]:{dw{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <={aw{1'b0}};
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we)
          mem [addr]<=di;
 
endmodule
 
module or1200_spram_2048x8 #(
 parameter aw =11,
 parameter dw =8) (
  input clk,
  input rst,
  input ce,
  input we,
  input oe,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq=(oe) ? mem[addr_reg]:{dw{1'b0}}; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          addr_reg <={aw{1'b0}};
        else 
          if (ce)
             addr_reg <=addr;
 
  always @( posedge clk)
       if (ce&&we)
          mem [addr]<=di;
 
endmodule
 
module or1200_fpu #(
 parameter width =32) (
  input clk,
  input rst,
  input ex_freeze,
  input [width-1:0] a,
  input [width-1:0] b,
  input [8-1:0] fpu_op,
  output [width-1:0] result,
  output done,
  output flagforw,
  output flag_we,
  output sig_fp,
  input except_started,
  input fpcsr_we,
  output [12-1:0] fpcsr,
  input spr_cs,
  input spr_write,
  input [31:0] spr_addr,
  input [31:0] spr_dat_i,
  output [31:0] spr_dat_o) ; 
    
  assign result=0; 
  assign flagforw=0; 
  assign flag_we=0; 
  assign sig_fp=0; 
  assign spr_dat_o=0; 
  assign fpcsr=0; 
  assign done=1; 
endmodule
 
module or1200_spram #(
 parameter aw =10,
 parameter dw =32) (
  input clk,
  input ce,
  input we,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq=mem[addr_reg]; 
  always @( posedge clk)
       if (ce)
          addr_reg <=addr;
 
  always @( posedge clk)
       if (we&&ce)
          mem [addr]<=di;
 
endmodule
 
module or1200_ic_tag #(
 parameter dw =20,
 parameter aw =13-4) (
  input clk,
  input rst,
  input [aw-1:0] addr,
  input en,
  input we,
  input [dw-1:0] datain,
  output tag_v,
  output [dw-2:0] tag) ; 
    
    
  or1200_spram #(.aw(13-4),.dw(20))ic_tag0(.clk(clk),.ce(en),.we(we),.addr(addr),.di(datain),.doq({tag,tag_v})); 
endmodule
 
module or1200_dpram_32x32 #(
 parameter aw =5,
 parameter dw =32) (
  input clk_a,
  input rst_a,
  input ce_a,
  input oe_a,
  input [aw-1:0] addr_a,
  output [dw-1:0] do_a,
  input clk_b,
  input rst_b,
  input ce_b,
  input we_b,
  input [aw-1:0] addr_b,
  input [dw-1:0] di_b) ; 
    
    
   reg [dw-1:0] mem[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_a_reg ;  
  assign do_a=(oe_a) ? mem[addr_a_reg]:{dw{1'b0}}; 
  always @(  posedge clk_a or  posedge rst_a)
       if (rst_a==(1'b1))
          addr_a_reg <={aw{1'b0}};
        else 
          if (ce_a)
             addr_a_reg <=addr_a;
 
  always @( posedge clk_b)
       if (ce_b&&we_b)
          mem [addr_b]<=di_b;
 
endmodule
 
module or1200_pic (
  input clk,
  input rst,
  input spr_cs,
  input spr_write,
  input [31:0] spr_addr,
  input [31:0] spr_dat_i,
  output reg  [31:0] spr_dat_o,
  output pic_wakeup,
  output intr,
  input [20-1:0] pic_int) ; 
   reg [20-1:2] picmr ;  
   reg [20-1:0] picsr ;  
   wire picmr_sel ;  
   wire picsr_sel ;  
   wire [20-1:0] um_ints ;  
  assign picmr_sel=(spr_cs&&(spr_addr[1:0]==2'd0)) ? 1'b1:1'b0; 
  assign picsr_sel=(spr_cs&&(spr_addr[1:0]==2'd2)) ? 1'b1:1'b0; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          picmr <={1'b1,{20-3{1'b0}}};
        else 
          if (picmr_sel&&spr_write)
             begin 
               picmr <=spr_dat_i[20-1:2];
             end
  
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          picsr <={20{1'b0}};
        else 
          if (picsr_sel&&spr_write)
             begin 
               picsr <=spr_dat_i[20-1:0]|um_ints;
             end 
           else 
             picsr <=picsr|um_ints;
 
  always @(   spr_addr or  picmr or  picsr)
       case (spr_addr[1:0])
        2 'd0:
           begin 
             spr_dat_o [20-1:0]={picmr,2'b11};
             spr_dat_o [31:20]={32-20{1'b0}};
           end 
        default :
           begin 
             spr_dat_o [20-1:0]=picsr;
             spr_dat_o [31:20]={32-20{1'b0}};
           end 
       endcase
  
  assign um_ints=pic_int&{picmr,2'b11}; 
  assign intr=|um_ints; 
  assign pic_wakeup=intr; 
endmodule
 
module or1200_wbmux #(
 parameter width =32) (
  input clk,
  input rst,
  input wb_freeze,
  input [4-1:0] rfwb_op,
  input [width-1:0] muxin_a,
  input [width-1:0] muxin_b,
  input [width-1:0] muxin_c,
  input [width-1:0] muxin_d,
  input [width-1:0] muxin_e,
  output reg  [width-1:0] muxout,
  output reg  [width-1:0] muxreg,
  output reg  muxreg_valid) ; 
    
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              muxreg <=32'd0;
              muxreg_valid <=1'b0;
            end 
          else 
            if (!wb_freeze)
               begin 
                 muxreg <=muxout;
                 muxreg_valid <=rfwb_op[0];
               end 
       end
  
  always @(      muxin_a or  muxin_b or  muxin_c or  muxin_d or  muxin_e or  rfwb_op)
       begin 
         casez (rfwb_op[4-1:1])
          3 'b000:
             muxout =muxin_a;
          3 'b001:
             begin 
               muxout =muxin_b;
             end 
          3 'b010:
             begin 
               muxout =muxin_c;
             end 
          3 'b011:
             begin 
               muxout =muxin_d+32'h8;
             end 
          default :
             begin 
               muxout =0;
             end 
         endcase 
       end
  
endmodule
 
module or1200_operandmuxes #(
 parameter width =32) (
  input clk,
  input rst,
  input id_freeze,
  input ex_freeze,
  input [width-1:0] rf_dataa,
  input [width-1:0] rf_datab,
  input [width-1:0] ex_forw,
  input [width-1:0] wb_forw,
  input [width-1:0] simm,
  input [2-1:0] sel_a,
  input [2-1:0] sel_b,
  output reg  [width-1:0] operand_a,
  output reg  [width-1:0] operand_b,
  output reg  [width-1:0] muxed_a,
  output reg  [width-1:0] muxed_b) ; 
    
   reg saved_a ;  
   reg saved_b ;  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              operand_a <=32'd0;
              saved_a <=1'b0;
            end 
          else 
            if (!ex_freeze&&id_freeze&&!saved_a)
               begin 
                 operand_a <=muxed_a;
                 saved_a <=1'b1;
               end 
             else 
               if (!ex_freeze&&!saved_a)
                  begin 
                    operand_a <=muxed_a;
                  end 
                else 
                  if (!ex_freeze&&!id_freeze)
                     saved_a <=1'b0;
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              operand_b <=32'd0;
              saved_b <=1'b0;
            end 
          else 
            if (!ex_freeze&&id_freeze&&!saved_b)
               begin 
                 operand_b <=muxed_b;
                 saved_b <=1'b1;
               end 
             else 
               if (!ex_freeze&&!saved_b)
                  begin 
                    operand_b <=muxed_b;
                  end 
                else 
                  if (!ex_freeze&&!id_freeze)
                     saved_b <=1'b0;
       end
  
  always @(    ex_forw or  wb_forw or  rf_dataa or  sel_a)
       begin 
         casez (sel_a)
          2 'd2:
             muxed_a =ex_forw;
          2 'd3:
             muxed_a =wb_forw;
          default :
             muxed_a =rf_dataa;
         endcase 
       end
  
  always @(     simm or  ex_forw or  wb_forw or  rf_datab or  sel_b)
       begin 
         casez (sel_b)
          2 'd1:
             muxed_b =simm;
          2 'd2:
             muxed_b =ex_forw;
          2 'd3:
             muxed_b =wb_forw;
          default :
             muxed_b =rf_datab;
         endcase 
       end
  
endmodule
 
module or1200_tt (
  input clk,
  input rst,
  input du_stall,
  input spr_cs,
  input spr_write,
  input [31:0] spr_addr,
  input [31:0] spr_dat_i,
  output reg  [31:0] spr_dat_o,
  output intr) ; 
   reg [31:0] ttmr ;  
   reg [31:0] ttcr ;  
   wire ttmr_sel ;  
   wire ttcr_sel ;  
   wire match ;  
   wire restart ;  
   wire stop ;  
  assign ttmr_sel=(spr_cs&&(spr_addr[0]==1'd0)) ? 1'b1:1'b0; 
  assign ttcr_sel=(spr_cs&&(spr_addr[0]==1'd1)) ? 1'b1:1'b0; 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          ttmr <=32'b0;
        else 
          if (ttmr_sel&&spr_write)
             ttmr <=spr_dat_i;
           else 
             if (ttmr[29])
                ttmr [28]<=ttmr[28]|(match&ttmr[29]);
 
  always @(  posedge clk or  posedge rst)
       if (rst==(1'b1))
          ttcr <=32'b0;
        else 
          if (restart)
             ttcr <=32'b0;
           else 
             if (ttcr_sel&&spr_write)
                ttcr <=spr_dat_i;
              else 
                if (!stop)
                   ttcr <=ttcr+32'd1;
 
  always @(   spr_addr or  ttmr or  ttcr)
       case (spr_addr[0])
        1 'd0:
           spr_dat_o =ttmr;
        default :
           spr_dat_o =ttcr;
       endcase
  
  assign match=(ttmr[27:0]==ttcr[27:0]) ? 1'b1:1'b0; 
  assign restart=match&&(ttmr[31:30]==2'b01); 
  assign stop=match&(ttmr[31:30]==2'b10)|(ttmr[31:30]==2'b00)|du_stall; 
  assign intr=ttmr[28]; 
endmodule
 
module or1200_fpu_post_norm_intfloat_conv #(
 parameter f2i_emax =8'h9d) (
  input clk,
  input [2:0] fpu_op,
  input opas,
  input sign,
  input [1:0] rmode,
  input [47:0] fract_in,
  input [7:0] exp_in,
  input opa_dn,
  input opa_nan,
  input opa_inf,
  input opb_dn,
  output [30:0] out,
  output ine,
  output inv,
  output overflow,
  output underflow,
  output f2i_out_sign) ; 
   reg [22:0] fract_out ;  
   reg [7:0] exp_out ;  
   wire [30:0] out ;  
   wire exp_out1_co,overflow,underflow ;  
   wire [22:0] fract_out_final ;  
   reg [22:0] fract_out_rnd ;  
   wire [8:0] exp_next_mi ;  
   wire dn ;  
   wire exp_rnd_adj ;  
   wire [7:0] exp_out_final ;  
   reg [7:0] exp_out_rnd ;  
   wire op_dn=opa_dn|opb_dn ;  
   wire op_mul=fpu_op[2:0]==3'b010 ;  
   wire op_div=fpu_op[2:0]==3'b011 ;  
   wire op_i2f=fpu_op[2:0]==3'b100 ;  
   wire op_f2i=fpu_op[2:0]==3'b101 ;  
   reg [5:0] fi_ldz ;  
   wire g,r,s ;  
   wire round,round2,round2a,round2_fasu,round2_fmul ;  
   wire [7:0] exp_out_rnd0,exp_out_rnd1,exp_out_rnd2,exp_out_rnd2a ;  
   wire [22:0] fract_out_rnd0,fract_out_rnd1,fract_out_rnd2,fract_out_rnd2a ;  
   wire exp_rnd_adj0,exp_rnd_adj2a ;  
   wire r_sign ;  
   wire ovf0,ovf1 ;  
   wire [23:0] fract_out_pl1 ;  
   wire [7:0] exp_out_pl1,exp_out_mi1 ;  
   wire exp_out_00,exp_out_fe,exp_out_ff,exp_in_00,exp_in_ff ;  
   wire exp_out_final_ff,fract_out_7fffff ;  
   reg [24:0] fract_trunc ;  
   wire [7:0] exp_out1 ;  
   wire grs_sel ;  
   wire fract_out_00 ;  
   reg fract_in_00 ;  
   wire shft_co ;  
   wire [8:0] exp_in_pl1,exp_in_mi1 ;  
   wire [47:0] fract_in_shftr ;  
   wire [47:0] fract_in_shftl ;  
   wire [7:0] shft2 ;  
   wire [7:0] exp_out1_mi1 ;  
   wire [6:0] fi_ldz_2a ;  
   wire [7:0] fi_ldz_2 ;  
   wire left_right ;  
   wire [7:0] shift_right ;  
   wire [7:0] shift_left ;  
   wire [7:0] fasu_shift ;  
   wire [5:0] fi_ldz_mi1 ;  
   wire [5:0] fi_ldz_mi22 ;  
   wire [6:0] ldz_all ;  
   wire [7:0] f2i_shft ;  
   wire [55:0] exp_f2i_1 ;  
   wire f2i_zero,f2i_max ;  
   wire [7:0] f2i_emin ;  
   wire f2i_exp_gt_max,f2i_exp_lt_min ;  
   wire [7:0] conv_shft ;  
   wire [7:0] exp_i2f,exp_f2i,conv_exp ;  
   wire round2_f2i ;  
  always @( posedge clk)
       casez (fract_in)
        48 'b1???????????????????????????????????????????????:
           fi_ldz <=1;
        48 'b01??????????????????????????????????????????????:
           fi_ldz <=2;
        48 'b001?????????????????????????????????????????????:
           fi_ldz <=3;
        48 'b0001????????????????????????????????????????????:
           fi_ldz <=4;
        48 'b00001???????????????????????????????????????????:
           fi_ldz <=5;
        48 'b000001??????????????????????????????????????????:
           fi_ldz <=6;
        48 'b0000001?????????????????????????????????????????:
           fi_ldz <=7;
        48 'b00000001????????????????????????????????????????:
           fi_ldz <=8;
        48 'b000000001???????????????????????????????????????:
           fi_ldz <=9;
        48 'b0000000001??????????????????????????????????????:
           fi_ldz <=10;
        48 'b00000000001?????????????????????????????????????:
           fi_ldz <=11;
        48 'b000000000001????????????????????????????????????:
           fi_ldz <=12;
        48 'b0000000000001???????????????????????????????????:
           fi_ldz <=13;
        48 'b00000000000001??????????????????????????????????:
           fi_ldz <=14;
        48 'b000000000000001?????????????????????????????????:
           fi_ldz <=15;
        48 'b0000000000000001????????????????????????????????:
           fi_ldz <=16;
        48 'b00000000000000001???????????????????????????????:
           fi_ldz <=17;
        48 'b000000000000000001??????????????????????????????:
           fi_ldz <=18;
        48 'b0000000000000000001?????????????????????????????:
           fi_ldz <=19;
        48 'b00000000000000000001????????????????????????????:
           fi_ldz <=20;
        48 'b000000000000000000001???????????????????????????:
           fi_ldz <=21;
        48 'b0000000000000000000001??????????????????????????:
           fi_ldz <=22;
        48 'b00000000000000000000001?????????????????????????:
           fi_ldz <=23;
        48 'b000000000000000000000001????????????????????????:
           fi_ldz <=24;
        48 'b0000000000000000000000001???????????????????????:
           fi_ldz <=25;
        48 'b00000000000000000000000001??????????????????????:
           fi_ldz <=26;
        48 'b000000000000000000000000001?????????????????????:
           fi_ldz <=27;
        48 'b0000000000000000000000000001????????????????????:
           fi_ldz <=28;
        48 'b00000000000000000000000000001???????????????????:
           fi_ldz <=29;
        48 'b000000000000000000000000000001??????????????????:
           fi_ldz <=30;
        48 'b0000000000000000000000000000001?????????????????:
           fi_ldz <=31;
        48 'b00000000000000000000000000000001????????????????:
           fi_ldz <=32;
        48 'b000000000000000000000000000000001???????????????:
           fi_ldz <=33;
        48 'b0000000000000000000000000000000001??????????????:
           fi_ldz <=34;
        48 'b00000000000000000000000000000000001?????????????:
           fi_ldz <=35;
        48 'b000000000000000000000000000000000001????????????:
           fi_ldz <=36;
        48 'b0000000000000000000000000000000000001???????????:
           fi_ldz <=37;
        48 'b00000000000000000000000000000000000001??????????:
           fi_ldz <=38;
        48 'b000000000000000000000000000000000000001?????????:
           fi_ldz <=39;
        48 'b0000000000000000000000000000000000000001????????:
           fi_ldz <=40;
        48 'b00000000000000000000000000000000000000001???????:
           fi_ldz <=41;
        48 'b000000000000000000000000000000000000000001??????:
           fi_ldz <=42;
        48 'b0000000000000000000000000000000000000000001?????:
           fi_ldz <=43;
        48 'b00000000000000000000000000000000000000000001????:
           fi_ldz <=44;
        48 'b000000000000000000000000000000000000000000001???:
           fi_ldz <=45;
        48 'b0000000000000000000000000000000000000000000001??:
           fi_ldz <=46;
        48 'b00000000000000000000000000000000000000000000001?:
           fi_ldz <=47;
        48 'b00000000000000000000000000000000000000000000000?:
           fi_ldz <=48;
       endcase
  
   wire exp_in_80 ;  
   wire rmode_00,rmode_01,rmode_10,rmode_11 ;  
  assign exp_in_ff=&exp_in; 
  assign exp_in_00=!(|exp_in); 
  assign exp_in_80=exp_in[7]&!(|exp_in[6:0]); 
  assign exp_out_ff=&exp_out; 
  assign exp_out_00=!(|exp_out); 
  assign exp_out_fe=&exp_out[7:1]&!exp_out[0]; 
  assign exp_out_final_ff=&exp_out_final; 
  assign fract_out_7fffff=&fract_out; 
  assign fract_out_00=!(|fract_out); 
  always @( posedge clk)
       fract_in_00 <=!(|fract_in);
 
  assign rmode_00=(rmode==2'b00); 
  assign rmode_01=(rmode==2'b01); 
  assign rmode_10=(rmode==2'b10); 
  assign rmode_11=(rmode==2'b11); 
  assign dn=!op_mul&!op_div&(exp_in_00|(exp_next_mi[8]&!fract_in[47])); 
    
  assign f2i_emin=rmode_00 ? 8'h7e:8'h7f; 
  assign f2i_exp_gt_max=(exp_in>f2i_emax); 
  assign f2i_exp_lt_min=(exp_in<f2i_emin); 
  assign fract_out_pl1=fract_out+1; 
  assign f2i_zero=(((f2i_exp_lt_min&(opas&(!rmode_11|fract_in_00)))|(f2i_exp_lt_min&!opas)|(f2i_exp_gt_max&opas))&!(&exp_in))|(opa_inf&opas)|(fract_in_00&exp_in_00); 
  assign f2i_max=((((!opas&f2i_exp_gt_max)|(f2i_exp_lt_min&!fract_in_00&rmode_11&opas))&!(&exp_in))|(opa_nan|(opa_inf&!opas)))&!(opas&fract_in_00&exp_in_00); 
  assign f2i_shft=exp_in-8'h7d; 
  assign conv_shft=op_f2i ? f2i_shft:{2'h0,fi_ldz}; 
  assign fract_in_shftl=(|conv_shft[7:6]|(f2i_zero&op_f2i)) ? 0:fract_in<<conv_shft[5:0]; 
  always @( posedge clk)
       { fract_out,fract_trunc}<=fract_in_shftl;
 
  assign fi_ldz_mi1=fi_ldz-1; 
  assign fi_ldz_mi22=fi_ldz-22; 
  assign exp_out_pl1=exp_out+1; 
  assign exp_out_mi1=exp_out-1; 
  assign exp_in_pl1=exp_in+1; 
  assign exp_in_mi1=exp_in-1; 
  assign exp_out1_mi1=exp_out1-1; 
  assign exp_next_mi=exp_in_pl1-{3'd0,fi_ldz_mi1}; 
  assign {exp_out1_co,exp_out1}=fract_in[47] ? exp_in_pl1:exp_next_mi; 
  assign f2i_out_sign=(opas&(exp_in>f2i_emax)&f2i_zero) ? 1:opa_nan|(f2i_zero&!f2i_max&!(opa_inf&opas))|(!(|out)&!f2i_zero) ? 0:opas; 
  assign exp_i2f=fract_in_00 ? (opas ? 8'h9e:0):(8'h9e-{2'd0,fi_ldz}); 
  assign exp_f2i_1={{8{fract_in[47]}},fract_in}<<f2i_shft; 
  assign exp_f2i=f2i_zero ? 0:f2i_max ? 8'hff:exp_f2i_1[55:48]; 
  assign conv_exp=op_f2i ? exp_f2i:exp_i2f; 
  always @( posedge clk)
       exp_out <=conv_exp;
 
  assign ldz_all={1'b0,fi_ldz}; 
  assign fi_ldz_2a=6'd23-fi_ldz; 
  assign fi_ldz_2={fi_ldz_2a[6],fi_ldz_2a[6:0]}; 
  assign g=fract_out[0]; 
  assign r=fract_trunc[24]; 
  assign s=|fract_trunc[23:0]; 
  assign round=(g&r)|(r&s); 
  assign {exp_rnd_adj0,fract_out_rnd0}=round ? fract_out_pl1:{1'b0,fract_out}; 
  assign exp_out_rnd0=exp_rnd_adj0 ? exp_out_pl1:exp_out; 
  assign ovf0=exp_out_final_ff&!rmode_01&!op_f2i; 
  assign fract_out_rnd1=(exp_out_ff&!dn&!op_f2i) ? 23'h7fffff:(op_f2i&(|fract_trunc)&opas) ? fract_out_pl1[22:0]:fract_out; 
  assign exp_out_rnd1=(g&r&s&exp_in_ff) ? exp_next_mi[7:0]:(exp_out_ff&!op_f2i) ? exp_in:(op_f2i&opas&(|fract_trunc)&fract_out_pl1[23]) ? exp_out_pl1:exp_out; 
  assign ovf1=exp_out_ff&!dn; 
  assign r_sign=sign; 
  assign round2a=!exp_out_fe|!fract_out_7fffff|(exp_out_fe&fract_out_7fffff); 
  assign round2_fasu=((r|s)&!r_sign)&(!exp_out[7]|(exp_out[7]&round2a)); 
  assign round2_f2i=rmode_10&((|fract_in[23:0]&!opas&(exp_in<8'h80))|(|fract_trunc)); 
  assign round2=op_f2i ? round2_f2i:round2_fasu; 
  assign {exp_rnd_adj2a,fract_out_rnd2a}=round2 ? fract_out_pl1:{1'b0,fract_out}; 
  assign exp_out_rnd2a=exp_rnd_adj2a ? exp_out_pl1:exp_out; 
  assign fract_out_rnd2=(r_sign&exp_out_ff&!op_div&!dn&!op_f2i) ? 23'h7fffff:fract_out_rnd2a; 
  assign exp_out_rnd2=(r_sign&exp_out_ff&!op_f2i) ? 8'hfe:exp_out_rnd2a; 
  always @(    rmode or  exp_out_rnd0 or  exp_out_rnd1 or  exp_out_rnd2)
       case (rmode)
        0 :
           exp_out_rnd =exp_out_rnd0;
        1 :
           exp_out_rnd =exp_out_rnd1;
        2 ,3:
           exp_out_rnd =exp_out_rnd2;
       endcase
  
  always @(    rmode or  fract_out_rnd0 or  fract_out_rnd1 or  fract_out_rnd2)
       case (rmode)
        0 :
           fract_out_rnd =fract_out_rnd0;
        1 :
           fract_out_rnd =fract_out_rnd1;
        2 ,3:
           fract_out_rnd =fract_out_rnd2;
       endcase
  
  assign fract_out_final=ovf0 ? 23'h0:(f2i_max&op_f2i) ? 23'h7fffff:fract_out_rnd; 
  assign exp_out_final=(f2i_max&op_f2i) ? 8'hff:exp_out_rnd; 
  assign out={exp_out_final,fract_out_final}; 
  assign underflow=(!fract_in[47]&exp_out1_co)&!dn; 
  assign overflow=ovf0|ovf1; 
   wire f2i_ine ;  
   wire exp_in_lt_half=(exp_in<8'h80) ;  
  assign f2i_ine=(f2i_zero&!fract_in_00&!opas)|(|fract_trunc)|(f2i_zero&exp_in_lt_half&opas&!fract_in_00)|(f2i_max&rmode_11&(exp_in<8'h80)); 
  assign ine=op_f2i ? f2i_ine:op_i2f ? (|fract_trunc):((r&!dn)|(s&!dn)); 
  assign inv=op_f2i&(exp_in>f2i_emax); 
endmodule
 
module or1200_spram_32_bw #(
 parameter aw =10,
 parameter dw =32) (
  input clk,
  input ce,
  input [3:0] we,
  input [aw-1:0] addr,
  input [dw-1:0] di,
  output [dw-1:0] doq) ; 
    
    
   reg [7:0] mem0[(1<<aw)-1:0] ;  
   reg [7:0] mem1[(1<<aw)-1:0] ;  
   reg [7:0] mem2[(1<<aw)-1:0] ;  
   reg [7:0] mem3[(1<<aw)-1:0] ;  
   reg [aw-1:0] addr_reg ;  
  assign doq={mem0[addr_reg],mem1[addr_reg],mem2[addr_reg],mem3[addr_reg]}; 
  always @( posedge clk)
       if (ce)
          addr_reg <=addr;
 
  always @( posedge clk)
       if (ce)
          begin 
            if (we[3])
               mem0 [addr]<=di[31:24];
            if (we[2])
               mem1 [addr]<=di[23:16];
            if (we[1])
               mem2 [addr]<=di[15:08];
            if (we[0])
               mem3 [addr]<=di[07:00];
          end
  
endmodule
 
module or1200_fpu_intfloat_conv_except (
  input clk,
  input [31:0] opa,
  input [31:0] opb,
  output reg  inf,
  output reg  ind,
  output reg  qnan,
  output reg  snan,
  output reg  opa_nan,
  output reg  opb_nan,
  output reg  opa_00,
  output reg  opb_00,
  output reg  opa_inf,
  output reg  opb_inf,
  output reg  opa_dn,
  output reg  opb_dn) ; 
   wire [7:0] expa,expb ;  
   wire [22:0] fracta,fractb ;  
   reg expa_ff,infa_f_r,qnan_r_a,snan_r_a ;  
   reg expb_ff,infb_f_r,qnan_r_b,snan_r_b ;  
   reg expa_00,expb_00,fracta_00,fractb_00 ;  
  assign expa=opa[30:23]; 
  assign expb=opb[30:23]; 
  assign fracta=opa[22:0]; 
  assign fractb=opb[22:0]; 
  always @( posedge clk)
       expa_ff <=&expa;
 
  always @( posedge clk)
       expb_ff <=&expb;
 
  always @( posedge clk)
       infa_f_r <=!(|fracta);
 
  always @( posedge clk)
       infb_f_r <=!(|fractb);
 
  always @( posedge clk)
       qnan_r_a <=fracta[22];
 
  always @( posedge clk)
       snan_r_a <=!fracta[22]&|fracta[21:0];
 
  always @( posedge clk)
       qnan_r_b <=fractb[22];
 
  always @( posedge clk)
       snan_r_b <=!fractb[22];
 
  always @( posedge clk)
       ind <=(expa_ff&infa_f_r);
 
  always @( posedge clk)
       inf <=(expa_ff&infa_f_r);
 
  always @( posedge clk)
       qnan <=(expa_ff&qnan_r_a);
 
  always @( posedge clk)
       snan <=(expa_ff&snan_r_a);
 
  always @( posedge clk)
       opa_nan <=&expa&(|fracta[22:0]);
 
  always @( posedge clk)
       opb_nan <=&expb&(|fractb[22:0]);
 
  always @( posedge clk)
       opa_inf <=(expa_ff&infa_f_r);
 
  always @( posedge clk)
       opb_inf <=(expb_ff&infb_f_r);
 
  always @( posedge clk)
       expa_00 <=!(|expa);
 
  always @( posedge clk)
       expb_00 <=!(|expb);
 
  always @( posedge clk)
       fracta_00 <=!(|fracta);
 
  always @( posedge clk)
       fractb_00 <=!(|fractb);
 
  always @( posedge clk)
       opa_00 <=expa_00&fracta_00;
 
  always @( posedge clk)
       opb_00 <=expb_00&fractb_00;
 
  always @( posedge clk)
       opa_dn <=expa_00;
 
  always @( posedge clk)
       opb_dn <=expb_00;
 
endmodule
 
module or1200_wb_biu #(
 parameter dw =32,
 parameter aw =32,
 parameter bl =4) (
  input clk,
  input rst,
  input [1:0] clmode,
  input wb_clk_i,
  input wb_rst_i,
  input wb_ack_i,
  input wb_err_i,
  input wb_rty_i,
  input [dw-1:0] wb_dat_i,
  output reg  wb_cyc_o,
  output reg  [aw-1:0] wb_adr_o,
  output reg  wb_stb_o,
  output reg  wb_we_o,
  output reg  [3:0] wb_sel_o,
  output [dw-1:0] wb_dat_o,
  output reg  [2:0] wb_cti_o,
  output reg  [1:0] wb_bte_o,
  input [dw-1:0] biu_dat_i,
  input [aw-1:0] biu_adr_i,
  input biu_cyc_i,
  input biu_stb_i,
  input biu_we_i,
  input [3:0] biu_sel_i,
  input biu_cab_i,
  output [31:0] biu_dat_o,
  output biu_ack_o,
  output biu_err_o) ; 
    
    
    
   wire wb_ack ;  
  assign wb_dat_o=biu_dat_i; 
   wire retry_cnt ;  
  assign retry_cnt=1'b0; 
   reg [3:0] burst_len ;  
   reg biu_stb_reg ;  
   wire biu_stb ;  
   reg wb_cyc_nxt ;  
   reg wb_stb_nxt ;  
   reg [2:0] wb_cti_nxt ;  
   reg wb_ack_cnt ;  
   reg wb_err_cnt ;  
   reg wb_rty_cnt ;  
   reg biu_ack_cnt ;  
   reg biu_err_cnt ;  
   reg biu_rty_cnt ;  
   wire biu_rty ;  
   reg [1:0] wb_fsm_state_cur ;  
   reg [1:0] wb_fsm_state_nxt ;  
   wire [1:0] wb_fsm_idle=2'h0 ;  
   wire [1:0] wb_fsm_trans=2'h1 ;  
   wire [1:0] wb_fsm_last=2'h2 ;  
  assign wb_ack=wb_ack_i&!wb_err_i&!wb_rty_i; 
  always @(  posedge wb_clk_i or  posedge wb_rst_i)
       begin 
         if (wb_rst_i==(1'b1))
            wb_fsm_state_cur <=wb_fsm_idle;
          else 
            wb_fsm_state_cur <=wb_fsm_state_nxt;
       end
  
  always @(  posedge wb_clk_i or  posedge wb_rst_i)
       begin 
         if (wb_rst_i==(1'b1))
            begin 
              burst_len <=0;
            end 
          else 
            begin 
              if (wb_fsm_state_cur==wb_fsm_idle)
                 burst_len <=bl[3:0]-2;
               else 
                 if (wb_stb_o&wb_ack)
                    burst_len <=burst_len-1;
            end 
       end
  
  always @(              wb_fsm_state_cur or  burst_len or  wb_err_i or  wb_rty_i or  wb_ack or  wb_cti_o or  wb_sel_o or  wb_stb_o or  wb_we_o or  biu_cyc_i or  biu_stb or  biu_cab_i or  biu_sel_i or  biu_we_i)
       begin 
         case (wb_fsm_state_cur)
          wb_fsm_idle :
             begin 
               wb_cyc_nxt =biu_cyc_i&biu_stb;
               wb_stb_nxt =biu_cyc_i&biu_stb;
               wb_cti_nxt ={!biu_cab_i,1'b1,!biu_cab_i};
               if (biu_cyc_i&biu_stb)
                  wb_fsm_state_nxt =wb_fsm_trans;
                else 
                  wb_fsm_state_nxt =wb_fsm_idle;
             end 
          wb_fsm_trans :
             begin 
               wb_cyc_nxt =!wb_stb_o|!wb_err_i&!wb_rty_i&!(wb_ack&wb_cti_o==3'b111);
               wb_stb_nxt =!wb_stb_o|!wb_err_i&!wb_rty_i&!wb_ack|!wb_err_i&!wb_rty_i&wb_cti_o==3'b010;
               wb_cti_nxt [2]=wb_stb_o&wb_ack&burst_len=='h0|wb_cti_o[2];
               wb_cti_nxt [1]=1'b1;
               wb_cti_nxt [0]=wb_stb_o&wb_ack&burst_len=='h0|wb_cti_o[0];
               if ((!biu_cyc_i|!biu_stb|!biu_cab_i|biu_sel_i!=wb_sel_o|biu_we_i!=wb_we_o)&wb_cti_o==3'b010)
                  wb_fsm_state_nxt =wb_fsm_last;
                else 
                  if ((wb_err_i|wb_rty_i|wb_ack&wb_cti_o==3'b111)&wb_stb_o)
                     wb_fsm_state_nxt =wb_fsm_idle;
                   else 
                     wb_fsm_state_nxt =wb_fsm_trans;
             end 
          wb_fsm_last :
             begin 
               wb_cyc_nxt =!wb_stb_o|!wb_err_i&!wb_rty_i&!(wb_ack&wb_cti_o==3'b111);
               wb_stb_nxt =!wb_stb_o|!wb_err_i&!wb_rty_i&!(wb_ack&wb_cti_o==3'b111);
               wb_cti_nxt [2]=wb_ack&wb_stb_o|wb_cti_o[2];
               wb_cti_nxt [1]=1'b1;
               wb_cti_nxt [0]=wb_ack&wb_stb_o|wb_cti_o[0];
               if ((wb_err_i|wb_rty_i|wb_ack&wb_cti_o==3'b111)&wb_stb_o)
                  wb_fsm_state_nxt =wb_fsm_idle;
                else 
                  wb_fsm_state_nxt =wb_fsm_last;
             end 
          default :
             begin 
               wb_cyc_nxt =1'bx;
               wb_stb_nxt =1'bx;
               wb_cti_nxt =3'bxxx;
               wb_fsm_state_nxt =2'bxx;
             end 
         endcase 
       end
  
  always @(  posedge wb_clk_i or  posedge wb_rst_i)
       begin 
         if (wb_rst_i==(1'b1))
            begin 
              wb_cyc_o <=1'b0;
              wb_stb_o <=1'b0;
              wb_cti_o <=3'b111;
              wb_bte_o <=(bl==8) ? 2'b10:(bl==4) ? 2'b01:2'b00;
              wb_we_o <=1'b0;
              wb_sel_o <=4'hf;
              wb_adr_o <={aw{1'b0}};
            end 
          else 
            begin 
              wb_cyc_o <=wb_cyc_nxt;
              if (wb_ack&wb_cti_o==3'b111)
                 wb_stb_o <=1'b0;
               else 
                 wb_stb_o <=wb_stb_nxt;
              wb_cti_o <=wb_cti_nxt;
              wb_bte_o <=(bl==8) ? 2'b10:(bl==4) ? 2'b01:2'b00;
              if (wb_fsm_state_cur==wb_fsm_idle)
                 begin 
                   wb_we_o <=biu_we_i;
                   wb_sel_o <=biu_sel_i;
                 end 
              if (wb_fsm_state_cur==wb_fsm_idle)
                 begin 
                   wb_adr_o <=biu_adr_i;
                 end 
               else 
                 if (wb_stb_o&wb_ack)
                    begin 
                      if (bl==4)
                         begin 
                           wb_adr_o [3:2]<=wb_adr_o[3:2]+1;
                         end 
                      if (bl==8)
                         begin 
                           wb_adr_o [4:2]<=wb_adr_o[4:2]+1;
                         end 
                    end 
            end 
       end
  
  always @(  posedge wb_clk_i or  posedge wb_rst_i)
       begin 
         if (wb_rst_i==(1'b1))
            begin 
              wb_ack_cnt <=1'b0;
              wb_err_cnt <=1'b0;
              wb_rty_cnt <=1'b0;
            end 
          else 
            begin 
              if (wb_fsm_state_cur==wb_fsm_idle|!(|clmode))
                 wb_ack_cnt <=1'b0;
               else 
                 if (wb_stb_o&wb_ack)
                    wb_ack_cnt <=!wb_ack_cnt;
              if (wb_fsm_state_cur==wb_fsm_idle|!(|clmode))
                 wb_err_cnt <=1'b0;
               else 
                 if (wb_stb_o&wb_err_i)
                    wb_err_cnt <=!wb_err_cnt;
              if (wb_fsm_state_cur==wb_fsm_idle|!(|clmode))
                 wb_rty_cnt <=1'b0;
               else 
                 if (wb_stb_o&wb_rty_i)
                    wb_rty_cnt <=!wb_rty_cnt;
            end 
       end
  
  always @(  posedge clk or  posedge rst)
       begin 
         if (rst==(1'b1))
            begin 
              biu_stb_reg <=1'b0;
              biu_ack_cnt <=1'b0;
              biu_err_cnt <=1'b0;
              biu_rty_cnt <=1'b0;
            end 
          else 
            begin 
              if (biu_stb_i&!biu_cab_i&biu_ack_o)
                 biu_stb_reg <=1'b0;
               else 
                 biu_stb_reg <=biu_stb_i;
              if (wb_fsm_state_cur==wb_fsm_idle|!(|clmode))
                 biu_ack_cnt <=1'b0;
               else 
                 if (biu_ack_o)
                    biu_ack_cnt <=!biu_ack_cnt;
              if (wb_fsm_state_cur==wb_fsm_idle|!(|clmode))
                 biu_err_cnt <=1'b0;
               else 
                 if (wb_err_i&biu_err_o)
                    biu_err_cnt <=!biu_err_cnt;
              if (wb_fsm_state_cur==wb_fsm_idle|!(|clmode))
                 biu_rty_cnt <=1'b0;
               else 
                 if (biu_rty)
                    biu_rty_cnt <=!biu_rty_cnt;
            end 
       end
  
  assign biu_stb=biu_stb_i&biu_stb_reg; 
  assign biu_dat_o=wb_dat_i; 
  assign biu_rty=(wb_fsm_state_cur==wb_fsm_trans)&wb_rty_i&wb_stb_o&(wb_rty_cnt~^biu_rty_cnt); 
  assign biu_ack_o=(wb_fsm_state_cur==wb_fsm_trans)&wb_ack&wb_stb_o&(wb_ack_cnt~^biu_ack_cnt); 
  assign biu_err_o=(wb_fsm_state_cur==wb_fsm_trans)&wb_err_i&wb_stb_o&(wb_err_cnt~^biu_err_cnt); 
endmodule
 
module or1200_top #(
 parameter dw =32,
 parameter aw =32,
 parameter ppic_ints =20,
 parameter boot_adr =32'h00000100,
parameter iwb_biu_bl=(1<<(4-2)),
parameter iwb_biu_dw=32,
parameter iwb_biu_aw=32,
parameter dwb_biu_bl=(1<<(4-2)),
parameter dwb_biu_dw=32,
parameter dwb_biu_aw=32,
parameter or1200_immu_top_boot_adr=boot_adr,
parameter or1200_immu_top_dw=32,
parameter or1200_immu_top_aw=32,
parameter or1200_immu_top_or1200_immu_tlb_dw=32,
parameter or1200_immu_top_or1200_immu_tlb_aw=32,
parameter or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_aw=6,
parameter or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_dw=14,
parameter or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_aw=6,
parameter or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_dw=22,
parameter or1200_ic_top_dw=32,
parameter or1200_ic_top_or1200_ic_ram_dw=32,
parameter or1200_ic_top_or1200_ic_ram_aw=13-2,
parameter or1200_ic_top_or1200_ic_ram_ic_ram0_aw=13-2,
parameter or1200_ic_top_or1200_ic_ram_ic_ram0_dw=32,
parameter or1200_ic_top_or1200_ic_tag_dw=20,
parameter or1200_ic_top_or1200_ic_tag_aw=13-4,
parameter or1200_ic_top_or1200_ic_tag_ic_tag0_aw=13-4,
parameter or1200_ic_top_or1200_ic_tag_ic_tag0_dw=20,
parameter or1200_cpu_boot_adr=boot_adr,
parameter or1200_cpu_dw=32,
parameter or1200_cpu_aw=5,
parameter or1200_cpu_or1200_genpc_boot_adr=or1200_cpu_boot_adr,
parameter or1200_cpu_or1200_rf_dw=32,
parameter or1200_cpu_or1200_rf_aw=5,
parameter or1200_cpu_or1200_rf_rf_a_aw=5,
parameter or1200_cpu_or1200_rf_rf_a_dw=32,
parameter or1200_cpu_or1200_rf_rf_b_aw=5,
parameter or1200_cpu_or1200_rf_rf_b_dw=32,
parameter or1200_cpu_or1200_operandmuxes_width=32,
parameter or1200_cpu_or1200_fpu_width=32,
parameter or1200_cpu_or1200_mult_mac_width=32,
parameter or1200_cpu_or1200_sprs_width=32,
parameter or1200_cpu_or1200_lsu_dw=32,
parameter or1200_cpu_or1200_lsu_aw=5,
parameter or1200_cpu_or1200_lsu_or1200_mem2reg_width=32,
parameter or1200_cpu_or1200_lsu_or1200_reg2mem_width=32,
parameter or1200_cpu_or1200_wbmux_width=32,
parameter or1200_dmmu_top_dw=32,
parameter or1200_dmmu_top_aw=32,
parameter or1200_dmmu_top_or1200_dmmu_tlb_dw=32,
parameter or1200_dmmu_top_or1200_dmmu_tlb_aw=32,
parameter or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_aw=6,
parameter or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_dw=14,
parameter or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_aw=6,
parameter or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_dw=24,
parameter or1200_dc_top_dw=32,
parameter or1200_dc_top_aw=32,
parameter or1200_dc_top_or1200_dc_ram_dw=32,
parameter or1200_dc_top_or1200_dc_ram_aw=13-2,
parameter or1200_dc_top_or1200_dc_ram_dc_ram_aw=13-2,
parameter or1200_dc_top_or1200_dc_ram_dc_ram_dw=or1200_dc_top_or1200_dc_ram_dw,
parameter or1200_dc_top_or1200_dc_tag_dw=20+1,
parameter or1200_dc_top_or1200_dc_tag_aw=13-4,
parameter or1200_dc_top_or1200_dc_tag_dc_tag0_aw=13-4,
parameter or1200_dc_top_or1200_dc_tag_dc_tag0_dw=20+1,
parameter or1200_qmem_top_dw=32,
parameter or1200_sb_dw=32,
parameter or1200_sb_aw=32,
parameter or1200_du_dw=32,
parameter or1200_du_aw=32) (
  input clk_i,
  input rst_i,
  input [ppic_ints-1:0] pic_ints_i,
  input [1:0] clmode_i,
  input iwb_clk_i,
  input iwb_rst_i,
  input iwb_ack_i,
  input iwb_err_i,
  input iwb_rty_i,
  input [dw-1:0] iwb_dat_i,
  output iwb_cyc_o,
  output [aw-1:0] iwb_adr_o,
  output iwb_stb_o,
  output iwb_we_o,
  output [3:0] iwb_sel_o,
  output [dw-1:0] iwb_dat_o,
  output [2:0] iwb_cti_o,
  output [1:0] iwb_bte_o,
  input dwb_clk_i,
  input dwb_rst_i,
  input dwb_ack_i,
  input dwb_err_i,
  input dwb_rty_i,
  input [dw-1:0] dwb_dat_i,
  output dwb_cyc_o,
  output [aw-1:0] dwb_adr_o,
  output dwb_stb_o,
  output dwb_we_o,
  output [3:0] dwb_sel_o,
  output [dw-1:0] dwb_dat_o,
  output [2:0] dwb_cti_o,
  output [1:0] dwb_bte_o,
  input dbg_stall_i,
  input dbg_ewt_i,
  output [3:0] dbg_lss_o,
  output [1:0] dbg_is_o,
  output [10:0] dbg_wp_o,
  output dbg_bp_o,
  input dbg_stb_i,
  input dbg_we_i,
  input [aw-1:0] dbg_adr_i,
  input [dw-1:0] dbg_dat_i,
  output [dw-1:0] dbg_dat_o,
  output dbg_ack_o,
  input pm_cpustall_i,
  output [3:0] pm_clksd_o,
  output pm_dc_gate_o,
  output pm_ic_gate_o,
  output pm_dmmu_gate_o,
  output pm_immu_gate_o,
  output pm_tt_gate_o,
  output pm_cpu_gate_o,
  output pm_wakeup_o,
  output pm_lvolt_o,
  output sig_tick) ; 
    
    
    
    
   wire [dw-1:0] dcsb_dat_dc ;  
   wire [aw-1:0] dcsb_adr_dc ;  
   wire dcsb_cyc_dc ;  
   wire dcsb_stb_dc ;  
   wire dcsb_we_dc ;  
   wire [3:0] dcsb_sel_dc ;  
   wire dcsb_cab_dc ;  
   wire [dw-1:0] dcsb_dat_sb ;  
   wire dcsb_ack_sb ;  
   wire dcsb_err_sb ;  
   wire [dw-1:0] sbbiu_dat_sb ;  
   wire [aw-1:0] sbbiu_adr_sb ;  
   wire sbbiu_cyc_sb ;  
   wire sbbiu_stb_sb ;  
   wire sbbiu_we_sb ;  
   wire [3:0] sbbiu_sel_sb ;  
   wire sbbiu_cab_sb ;  
   wire [dw-1:0] sbbiu_dat_biu ;  
   wire sbbiu_ack_biu ;  
   wire sbbiu_err_biu ;  
   wire [dw-1:0] icbiu_dat_ic ;  
   wire [aw-1:0] icbiu_adr_ic ;  
   wire [aw-1:0] icbiu_adr_ic_word ;  
   wire icbiu_cyc_ic ;  
   wire icbiu_stb_ic ;  
   wire icbiu_we_ic ;  
   wire [3:0] icbiu_sel_ic ;  
   wire [3:0] icbiu_tag_ic ;  
   wire icbiu_cab_ic ;  
   wire [dw-1:0] icbiu_dat_biu ;  
   wire icbiu_ack_biu ;  
   wire icbiu_err_biu ;  
   wire [3:0] icbiu_tag_biu ;  
   wire boot_adr_sel=1'b0 ;  
   wire supv ;  
   wire [aw-1:0] spr_addr ;  
   wire [dw-1:0] spr_dat_cpu ;  
   wire [31:0] spr_cs ;  
   wire spr_we ;  
   wire mtspr_dc_done ;  
   wire sb_en ;  
   wire dmmu_en ;  
   wire [31:0] spr_dat_dmmu ;  
   wire qmemdmmu_err_qmem ;  
   wire [3:0] qmemdmmu_tag_qmem ;  
   wire [aw-1:0] qmemdmmu_adr_dmmu ;  
   wire qmemdmmu_cycstb_dmmu ;  
   wire qmemdmmu_ci_dmmu ;  
   wire dc_en ;  
   wire [31:0] dcpu_adr_cpu ;  
   wire dcpu_cycstb_cpu ;  
   wire dcpu_we_cpu ;  
   wire [3:0] dcpu_sel_cpu ;  
   wire [3:0] dcpu_tag_cpu ;  
   wire [31:0] dcpu_dat_cpu ;  
   wire [31:0] dcpu_dat_qmem ;  
   wire dcpu_ack_qmem ;  
   wire dcpu_rty_qmem ;  
   wire dcpu_err_dmmu ;  
   wire [3:0] dcpu_tag_dmmu ;  
   wire dc_no_writethrough ;  
   wire immu_en ;  
   wire [31:0] spr_dat_immu ;  
   wire ic_en ;  
   wire [31:0] icpu_adr_cpu ;  
   wire icpu_cycstb_cpu ;  
   wire [3:0] icpu_sel_cpu ;  
   wire [3:0] icpu_tag_cpu ;  
   wire [31:0] icpu_dat_qmem ;  
   wire icpu_ack_qmem ;  
   wire [31:0] icpu_adr_immu ;  
   wire icpu_err_immu ;  
   wire [3:0] icpu_tag_immu ;  
   wire icpu_rty_immu ;  
   wire [aw-1:0] qmemimmu_adr_immu ;  
   wire qmemimmu_rty_qmem ;  
   wire qmemimmu_err_qmem ;  
   wire [3:0] qmemimmu_tag_qmem ;  
   wire qmemimmu_cycstb_immu ;  
   wire qmemimmu_ci_immu ;  
   wire [aw-1:0] icqmem_adr_qmem ;  
   wire icqmem_rty_ic ;  
   wire icqmem_err_ic ;  
   wire [3:0] icqmem_tag_ic ;  
   wire icqmem_cycstb_qmem ;  
   wire icqmem_ci_qmem ;  
   wire [31:0] icqmem_dat_ic ;  
   wire icqmem_ack_ic ;  
   wire [aw-1:0] dcqmem_adr_qmem ;  
   wire dcqmem_rty_dc ;  
   wire dcqmem_err_dc ;  
   wire [3:0] dcqmem_tag_dc ;  
   wire dcqmem_cycstb_qmem ;  
   wire dcqmem_ci_qmem ;  
   wire [31:0] dcqmem_dat_dc ;  
   wire [31:0] dcqmem_dat_qmem ;  
   wire dcqmem_we_qmem ;  
   wire [3:0] dcqmem_sel_qmem ;  
   wire dcqmem_ack_dc ;  
   wire [dw-1:0] spr_dat_pic ;  
   wire pic_wakeup ;  
   wire sig_int ;  
   wire [dw-1:0] spr_dat_pm ;  
   wire [dw-1:0] spr_dat_tt ;  
   wire [dw-1:0] spr_dat_du ;  
   wire du_stall ;  
   wire [dw-1:0] du_addr ;  
   wire [dw-1:0] du_dat_du ;  
   wire du_read ;  
   wire du_write ;  
   wire [13:0] du_except_trig ;  
   wire [13:0] du_except_stop ;  
   wire [14-1:0] du_dsr ;  
   wire [24:0] du_dmr1 ;  
   wire [dw-1:0] du_dat_cpu ;  
   wire [dw-1:0] du_lsu_store_dat ;  
   wire [dw-1:0] du_lsu_load_dat ;  
   wire du_hwbkpt ;  
   wire du_hwbkpt_ls_r=1'b0 ;  
   wire du_flush_pipe ;  
   wire flushpipe ;  
   wire ex_freeze ;  
   wire wb_freeze ;  
   wire id_void ;  
   wire ex_void ;  
   wire [31:0] id_insn ;  
   wire [31:0] ex_insn ;  
   wire [31:0] wb_insn ;  
   wire [31:0] id_pc ;  
   wire [31:0] ex_pc ;  
   wire [31:0] wb_pc ;  
   wire [3-1:0] branch_op ;  
   wire [31:0] spr_dat_npc ;  
   wire [31:0] rf_dataw ;  
   wire abort_ex ;  
   wire abort_mvspr ;  
   wire [3:0] icqmem_sel_qmem ;  
   wire [3:0] icqmem_tag_qmem ;  
   wire [3:0] dcqmem_tag_qmem ;  
  
wire  iwb_biu_clk;
wire  iwb_biu_rst;
wire [1:0] iwb_biu_clmode;
wire  iwb_biu_wb_clk_i;
wire  iwb_biu_wb_rst_i;
wire  iwb_biu_wb_ack_i;
wire  iwb_biu_wb_err_i;
wire  iwb_biu_wb_rty_i;
wire [ iwb_biu_dw -1:0] iwb_biu_wb_dat_i;
reg  iwb_biu_wb_cyc_o;
reg [ iwb_biu_aw -1:0] iwb_biu_wb_adr_o;
reg  iwb_biu_wb_stb_o;
reg  iwb_biu_wb_we_o;
reg [3:0] iwb_biu_wb_sel_o;
wire [ iwb_biu_dw -1:0] iwb_biu_wb_dat_o;
reg [2:0] iwb_biu_wb_cti_o;
reg [1:0] iwb_biu_wb_bte_o;
wire [ iwb_biu_dw -1:0] iwb_biu_biu_dat_i;
wire [ iwb_biu_aw -1:0] iwb_biu_biu_adr_i;
wire  iwb_biu_biu_cyc_i;
wire  iwb_biu_biu_stb_i;
wire  iwb_biu_biu_we_i;
wire [3:0] iwb_biu_biu_sel_i;
wire  iwb_biu_biu_cab_i;
wire [31:0] iwb_biu_biu_dat_o;
wire  iwb_biu_biu_ack_o;
wire  iwb_biu_biu_err_o;
wire  dwb_biu_clk;
wire  dwb_biu_rst;
wire [1:0] dwb_biu_clmode;
wire  dwb_biu_wb_clk_i;
wire  dwb_biu_wb_rst_i;
wire  dwb_biu_wb_ack_i;
wire  dwb_biu_wb_err_i;
wire  dwb_biu_wb_rty_i;
wire [ dwb_biu_dw -1:0] dwb_biu_wb_dat_i;
reg  dwb_biu_wb_cyc_o;
reg [ dwb_biu_aw -1:0] dwb_biu_wb_adr_o;
reg  dwb_biu_wb_stb_o;
reg  dwb_biu_wb_we_o;
reg [3:0] dwb_biu_wb_sel_o;
wire [ dwb_biu_dw -1:0] dwb_biu_wb_dat_o;
reg [2:0] dwb_biu_wb_cti_o;
reg [1:0] dwb_biu_wb_bte_o;
wire [ dwb_biu_dw -1:0] dwb_biu_biu_dat_i;
wire [ dwb_biu_aw -1:0] dwb_biu_biu_adr_i;
wire  dwb_biu_biu_cyc_i;
wire  dwb_biu_biu_stb_i;
wire  dwb_biu_biu_we_i;
wire [3:0] dwb_biu_biu_sel_i;
wire  dwb_biu_biu_cab_i;
wire [31:0] dwb_biu_biu_dat_o;
wire  dwb_biu_biu_ack_o;
wire  dwb_biu_biu_err_o;
 
   wire  iwb_biu_wb_ack  ; 
  assign   iwb_biu_wb_dat_o  =  iwb_biu_biu_dat_i  ; 
   wire  iwb_biu_retry_cnt  ; 
  assign   iwb_biu_retry_cnt  =1'b0; 
   reg[3:0]  iwb_biu_burst_len  ; 
   reg  iwb_biu_biu_stb_reg  ; 
   wire  iwb_biu_biu_stb  ; 
   reg  iwb_biu_wb_cyc_nxt  ; 
   reg  iwb_biu_wb_stb_nxt  ; 
   reg[2:0]  iwb_biu_wb_cti_nxt  ; 
   reg  iwb_biu_wb_ack_cnt  ; 
   reg  iwb_biu_wb_err_cnt  ; 
   reg  iwb_biu_wb_rty_cnt  ; 
   reg  iwb_biu_biu_ack_cnt  ; 
   reg  iwb_biu_biu_err_cnt  ; 
   reg  iwb_biu_biu_rty_cnt  ; 
   wire  iwb_biu_biu_rty  ; 
   reg[1:0]  iwb_biu_wb_fsm_state_cur  ; 
   reg[1:0]  iwb_biu_wb_fsm_state_nxt  ; 
   wire[1:0]  iwb_biu_wb_fsm_idle  =2'h0; 
   wire[1:0]  iwb_biu_wb_fsm_trans  =2'h1; 
   wire[1:0]  iwb_biu_wb_fsm_last  =2'h2; 
  assign   iwb_biu_wb_ack  =  iwb_biu_wb_ack_i  &!  iwb_biu_wb_err_i  &!  iwb_biu_wb_rty_i  ; 
  always @(  posedge    iwb_biu_wb_clk_i          or  posedge   iwb_biu_wb_rst_i  )
       begin 
         if (  iwb_biu_wb_rst_i  ==(1'b1)) 
             iwb_biu_wb_fsm_state_cur   <=  iwb_biu_wb_fsm_idle  ;
          else  
             iwb_biu_wb_fsm_state_cur   <=  iwb_biu_wb_fsm_state_nxt  ;
       end
  
  always @(  posedge    iwb_biu_wb_clk_i          or  posedge   iwb_biu_wb_rst_i  )
       begin 
         if (  iwb_biu_wb_rst_i  ==(1'b1))
            begin  
               iwb_biu_burst_len   <=0;
            end 
          else 
            begin 
              if (  iwb_biu_wb_fsm_state_cur  ==  iwb_biu_wb_fsm_idle  ) 
                  iwb_biu_burst_len   <=  iwb_biu_bl  [3:0]-2;
               else 
                 if (  iwb_biu_wb_stb_o  &  iwb_biu_wb_ack  ) 
                     iwb_biu_burst_len   <=  iwb_biu_burst_len  -1;
            end 
       end
  
  always @(                iwb_biu_wb_fsm_state_cur                                    or    iwb_biu_burst_len                      or    iwb_biu_wb_err_i                     or    iwb_biu_wb_rty_i                    or    iwb_biu_wb_ack                   or    iwb_biu_wb_cti_o                  or    iwb_biu_wb_sel_o                 or    iwb_biu_wb_stb_o                or    iwb_biu_wb_we_o               or    iwb_biu_biu_cyc_i              or    iwb_biu_biu_stb             or    iwb_biu_biu_cab_i            or    iwb_biu_biu_sel_i           or    iwb_biu_biu_we_i   )
       begin 
         case (  iwb_biu_wb_fsm_state_cur  ) 
           iwb_biu_wb_fsm_idle   :
             begin  
                iwb_biu_wb_cyc_nxt   =  iwb_biu_biu_cyc_i  &  iwb_biu_biu_stb  ; 
                iwb_biu_wb_stb_nxt   =  iwb_biu_biu_cyc_i  &  iwb_biu_biu_stb  ; 
                iwb_biu_wb_cti_nxt   ={!  iwb_biu_biu_cab_i  ,1'b1,!  iwb_biu_biu_cab_i  };
               if (  iwb_biu_biu_cyc_i  &  iwb_biu_biu_stb  ) 
                   iwb_biu_wb_fsm_state_nxt   =  iwb_biu_wb_fsm_trans  ;
                else  
                   iwb_biu_wb_fsm_state_nxt   =  iwb_biu_wb_fsm_idle  ;
             end  
           iwb_biu_wb_fsm_trans   :
             begin  
                iwb_biu_wb_cyc_nxt   =!  iwb_biu_wb_stb_o  |!  iwb_biu_wb_err_i  &!  iwb_biu_wb_rty_i  &!(  iwb_biu_wb_ack  &  iwb_biu_wb_cti_o  ==3'b111); 
                iwb_biu_wb_stb_nxt   =!  iwb_biu_wb_stb_o  |!  iwb_biu_wb_err_i  &!  iwb_biu_wb_rty_i  &!  iwb_biu_wb_ack  |!  iwb_biu_wb_err_i  &!  iwb_biu_wb_rty_i  &  iwb_biu_wb_cti_o  ==3'b010; 
                iwb_biu_wb_cti_nxt   [2]=  iwb_biu_wb_stb_o  &  iwb_biu_wb_ack  &  iwb_biu_burst_len  =='h0|  iwb_biu_wb_cti_o  [2]; 
                iwb_biu_wb_cti_nxt   [1]=1'b1; 
                iwb_biu_wb_cti_nxt   [0]=  iwb_biu_wb_stb_o  &  iwb_biu_wb_ack  &  iwb_biu_burst_len  =='h0|  iwb_biu_wb_cti_o  [0];
               if ((!  iwb_biu_biu_cyc_i  |!  iwb_biu_biu_stb  |!  iwb_biu_biu_cab_i  |  iwb_biu_biu_sel_i  !=  iwb_biu_wb_sel_o  |  iwb_biu_biu_we_i  !=  iwb_biu_wb_we_o  )&  iwb_biu_wb_cti_o  ==3'b010) 
                   iwb_biu_wb_fsm_state_nxt   =  iwb_biu_wb_fsm_last  ;
                else 
                  if ((  iwb_biu_wb_err_i  |  iwb_biu_wb_rty_i  |  iwb_biu_wb_ack  &  iwb_biu_wb_cti_o  ==3'b111)&  iwb_biu_wb_stb_o  ) 
                      iwb_biu_wb_fsm_state_nxt   =  iwb_biu_wb_fsm_idle  ;
                   else  
                      iwb_biu_wb_fsm_state_nxt   =  iwb_biu_wb_fsm_trans  ;
             end  
           iwb_biu_wb_fsm_last   :
             begin  
                iwb_biu_wb_cyc_nxt   =!  iwb_biu_wb_stb_o  |!  iwb_biu_wb_err_i  &!  iwb_biu_wb_rty_i  &!(  iwb_biu_wb_ack  &  iwb_biu_wb_cti_o  ==3'b111); 
                iwb_biu_wb_stb_nxt   =!  iwb_biu_wb_stb_o  |!  iwb_biu_wb_err_i  &!  iwb_biu_wb_rty_i  &!(  iwb_biu_wb_ack  &  iwb_biu_wb_cti_o  ==3'b111); 
                iwb_biu_wb_cti_nxt   [2]=  iwb_biu_wb_ack  &  iwb_biu_wb_stb_o  |  iwb_biu_wb_cti_o  [2]; 
                iwb_biu_wb_cti_nxt   [1]=1'b1; 
                iwb_biu_wb_cti_nxt   [0]=  iwb_biu_wb_ack  &  iwb_biu_wb_stb_o  |  iwb_biu_wb_cti_o  [0];
               if ((  iwb_biu_wb_err_i  |  iwb_biu_wb_rty_i  |  iwb_biu_wb_ack  &  iwb_biu_wb_cti_o  ==3'b111)&  iwb_biu_wb_stb_o  ) 
                   iwb_biu_wb_fsm_state_nxt   =  iwb_biu_wb_fsm_idle  ;
                else  
                   iwb_biu_wb_fsm_state_nxt   =  iwb_biu_wb_fsm_last  ;
             end 
          default :
             begin  
                iwb_biu_wb_cyc_nxt   =1'bx; 
                iwb_biu_wb_stb_nxt   =1'bx; 
                iwb_biu_wb_cti_nxt   =3'bxxx; 
                iwb_biu_wb_fsm_state_nxt   =2'bxx;
             end 
         endcase 
       end
  
  always @(  posedge    iwb_biu_wb_clk_i          or  posedge   iwb_biu_wb_rst_i  )
       begin 
         if (  iwb_biu_wb_rst_i  ==(1'b1))
            begin  
               iwb_biu_wb_cyc_o   <=1'b0; 
               iwb_biu_wb_stb_o   <=1'b0; 
               iwb_biu_wb_cti_o   <=3'b111; 
               iwb_biu_wb_bte_o   <=(  iwb_biu_bl  ==8)?2'b10:(  iwb_biu_bl  ==4)?2'b01:2'b00; 
               iwb_biu_wb_we_o   <=1'b0; 
               iwb_biu_wb_sel_o   <=4'hf; 
               iwb_biu_wb_adr_o   <={  iwb_biu_aw  {1'b0}};
            end 
          else 
            begin  
               iwb_biu_wb_cyc_o   <=  iwb_biu_wb_cyc_nxt  ;
              if (  iwb_biu_wb_ack  &  iwb_biu_wb_cti_o  ==3'b111) 
                  iwb_biu_wb_stb_o   <=1'b0;
               else  
                  iwb_biu_wb_stb_o   <=  iwb_biu_wb_stb_nxt  ; 
               iwb_biu_wb_cti_o   <=  iwb_biu_wb_cti_nxt  ; 
               iwb_biu_wb_bte_o   <=(  iwb_biu_bl  ==8)?2'b10:(  iwb_biu_bl  ==4)?2'b01:2'b00;
              if (  iwb_biu_wb_fsm_state_cur  ==  iwb_biu_wb_fsm_idle  )
                 begin  
                    iwb_biu_wb_we_o   <=  iwb_biu_biu_we_i  ; 
                    iwb_biu_wb_sel_o   <=  iwb_biu_biu_sel_i  ;
                 end 
              if (  iwb_biu_wb_fsm_state_cur  ==  iwb_biu_wb_fsm_idle  )
                 begin  
                    iwb_biu_wb_adr_o   <=  iwb_biu_biu_adr_i  ;
                 end 
               else 
                 if (  iwb_biu_wb_stb_o  &  iwb_biu_wb_ack  )
                    begin 
                      if (  iwb_biu_bl  ==4)
                         begin  
                            iwb_biu_wb_adr_o   [3:2]<=  iwb_biu_wb_adr_o  [3:2]+1;
                         end 
                      if (  iwb_biu_bl  ==8)
                         begin  
                            iwb_biu_wb_adr_o   [4:2]<=  iwb_biu_wb_adr_o  [4:2]+1;
                         end 
                    end 
            end 
       end
  
  always @(  posedge    iwb_biu_wb_clk_i          or  posedge   iwb_biu_wb_rst_i  )
       begin 
         if (  iwb_biu_wb_rst_i  ==(1'b1))
            begin  
               iwb_biu_wb_ack_cnt   <=1'b0; 
               iwb_biu_wb_err_cnt   <=1'b0; 
               iwb_biu_wb_rty_cnt   <=1'b0;
            end 
          else 
            begin 
              if (  iwb_biu_wb_fsm_state_cur  ==  iwb_biu_wb_fsm_idle  |!(|  iwb_biu_clmode  )) 
                  iwb_biu_wb_ack_cnt   <=1'b0;
               else 
                 if (  iwb_biu_wb_stb_o  &  iwb_biu_wb_ack  ) 
                     iwb_biu_wb_ack_cnt   <=!  iwb_biu_wb_ack_cnt  ;
              if (  iwb_biu_wb_fsm_state_cur  ==  iwb_biu_wb_fsm_idle  |!(|  iwb_biu_clmode  )) 
                  iwb_biu_wb_err_cnt   <=1'b0;
               else 
                 if (  iwb_biu_wb_stb_o  &  iwb_biu_wb_err_i  ) 
                     iwb_biu_wb_err_cnt   <=!  iwb_biu_wb_err_cnt  ;
              if (  iwb_biu_wb_fsm_state_cur  ==  iwb_biu_wb_fsm_idle  |!(|  iwb_biu_clmode  )) 
                  iwb_biu_wb_rty_cnt   <=1'b0;
               else 
                 if (  iwb_biu_wb_stb_o  &  iwb_biu_wb_rty_i  ) 
                     iwb_biu_wb_rty_cnt   <=!  iwb_biu_wb_rty_cnt  ;
            end 
       end
  
  always @(  posedge    iwb_biu_clk          or  posedge   iwb_biu_rst  )
       begin 
         if (  iwb_biu_rst  ==(1'b1))
            begin  
               iwb_biu_biu_stb_reg   <=1'b0; 
               iwb_biu_biu_ack_cnt   <=1'b0; 
               iwb_biu_biu_err_cnt   <=1'b0; 
               iwb_biu_biu_rty_cnt   <=1'b0;
            end 
          else 
            begin 
              if (  iwb_biu_biu_stb_i  &!  iwb_biu_biu_cab_i  &  iwb_biu_biu_ack_o  ) 
                  iwb_biu_biu_stb_reg   <=1'b0;
               else  
                  iwb_biu_biu_stb_reg   <=  iwb_biu_biu_stb_i  ;
              if (  iwb_biu_wb_fsm_state_cur  ==  iwb_biu_wb_fsm_idle  |!(|  iwb_biu_clmode  )) 
                  iwb_biu_biu_ack_cnt   <=1'b0;
               else 
                 if (  iwb_biu_biu_ack_o  ) 
                     iwb_biu_biu_ack_cnt   <=!  iwb_biu_biu_ack_cnt  ;
              if (  iwb_biu_wb_fsm_state_cur  ==  iwb_biu_wb_fsm_idle  |!(|  iwb_biu_clmode  )) 
                  iwb_biu_biu_err_cnt   <=1'b0;
               else 
                 if (  iwb_biu_wb_err_i  &  iwb_biu_biu_err_o  ) 
                     iwb_biu_biu_err_cnt   <=!  iwb_biu_biu_err_cnt  ;
              if (  iwb_biu_wb_fsm_state_cur  ==  iwb_biu_wb_fsm_idle  |!(|  iwb_biu_clmode  )) 
                  iwb_biu_biu_rty_cnt   <=1'b0;
               else 
                 if (  iwb_biu_biu_rty  ) 
                     iwb_biu_biu_rty_cnt   <=!  iwb_biu_biu_rty_cnt  ;
            end 
       end
  
  assign   iwb_biu_biu_stb  =  iwb_biu_biu_stb_i  &  iwb_biu_biu_stb_reg  ; 
  assign   iwb_biu_biu_dat_o  =  iwb_biu_wb_dat_i  ; 
  assign   iwb_biu_biu_rty  =(  iwb_biu_wb_fsm_state_cur  ==  iwb_biu_wb_fsm_trans  )&  iwb_biu_wb_rty_i  &  iwb_biu_wb_stb_o  &(  iwb_biu_wb_rty_cnt  ~^  iwb_biu_biu_rty_cnt  ); 
  assign   iwb_biu_biu_ack_o  =(  iwb_biu_wb_fsm_state_cur  ==  iwb_biu_wb_fsm_trans  )&  iwb_biu_wb_ack  &  iwb_biu_wb_stb_o  &(  iwb_biu_wb_ack_cnt  ~^  iwb_biu_biu_ack_cnt  ); 
  assign   iwb_biu_biu_err_o  =(  iwb_biu_wb_fsm_state_cur  ==  iwb_biu_wb_fsm_trans  )&  iwb_biu_wb_err_i  &  iwb_biu_wb_stb_o  &(  iwb_biu_wb_err_cnt  ~^  iwb_biu_biu_err_cnt  );
 
  assign icbiu_adr_ic_word={icbiu_adr_ic[31:2],2'h0}; 
  
 
   wire  dwb_biu_wb_ack  ; 
  assign   dwb_biu_wb_dat_o  =  dwb_biu_biu_dat_i  ; 
   wire  dwb_biu_retry_cnt  ; 
  assign   dwb_biu_retry_cnt  =1'b0; 
   reg[3:0]  dwb_biu_burst_len  ; 
   reg  dwb_biu_biu_stb_reg  ; 
   wire  dwb_biu_biu_stb  ; 
   reg  dwb_biu_wb_cyc_nxt  ; 
   reg  dwb_biu_wb_stb_nxt  ; 
   reg[2:0]  dwb_biu_wb_cti_nxt  ; 
   reg  dwb_biu_wb_ack_cnt  ; 
   reg  dwb_biu_wb_err_cnt  ; 
   reg  dwb_biu_wb_rty_cnt  ; 
   reg  dwb_biu_biu_ack_cnt  ; 
   reg  dwb_biu_biu_err_cnt  ; 
   reg  dwb_biu_biu_rty_cnt  ; 
   wire  dwb_biu_biu_rty  ; 
   reg[1:0]  dwb_biu_wb_fsm_state_cur  ; 
   reg[1:0]  dwb_biu_wb_fsm_state_nxt  ; 
   wire[1:0]  dwb_biu_wb_fsm_idle  =2'h0; 
   wire[1:0]  dwb_biu_wb_fsm_trans  =2'h1; 
   wire[1:0]  dwb_biu_wb_fsm_last  =2'h2; 
  assign   dwb_biu_wb_ack  =  dwb_biu_wb_ack_i  &!  dwb_biu_wb_err_i  &!  dwb_biu_wb_rty_i  ; 
  always @(  posedge    dwb_biu_wb_clk_i          or  posedge   dwb_biu_wb_rst_i  )
       begin 
         if (  dwb_biu_wb_rst_i  ==(1'b1)) 
             dwb_biu_wb_fsm_state_cur   <=  dwb_biu_wb_fsm_idle  ;
          else  
             dwb_biu_wb_fsm_state_cur   <=  dwb_biu_wb_fsm_state_nxt  ;
       end
  
  always @(  posedge    dwb_biu_wb_clk_i          or  posedge   dwb_biu_wb_rst_i  )
       begin 
         if (  dwb_biu_wb_rst_i  ==(1'b1))
            begin  
               dwb_biu_burst_len   <=0;
            end 
          else 
            begin 
              if (  dwb_biu_wb_fsm_state_cur  ==  dwb_biu_wb_fsm_idle  ) 
                  dwb_biu_burst_len   <=  dwb_biu_bl  [3:0]-2;
               else 
                 if (  dwb_biu_wb_stb_o  &  dwb_biu_wb_ack  ) 
                     dwb_biu_burst_len   <=  dwb_biu_burst_len  -1;
            end 
       end
  
  always @(                dwb_biu_wb_fsm_state_cur                                    or    dwb_biu_burst_len                      or    dwb_biu_wb_err_i                     or    dwb_biu_wb_rty_i                    or    dwb_biu_wb_ack                   or    dwb_biu_wb_cti_o                  or    dwb_biu_wb_sel_o                 or    dwb_biu_wb_stb_o                or    dwb_biu_wb_we_o               or    dwb_biu_biu_cyc_i              or    dwb_biu_biu_stb             or    dwb_biu_biu_cab_i            or    dwb_biu_biu_sel_i           or    dwb_biu_biu_we_i   )
       begin 
         case (  dwb_biu_wb_fsm_state_cur  ) 
           dwb_biu_wb_fsm_idle   :
             begin  
                dwb_biu_wb_cyc_nxt   =  dwb_biu_biu_cyc_i  &  dwb_biu_biu_stb  ; 
                dwb_biu_wb_stb_nxt   =  dwb_biu_biu_cyc_i  &  dwb_biu_biu_stb  ; 
                dwb_biu_wb_cti_nxt   ={!  dwb_biu_biu_cab_i  ,1'b1,!  dwb_biu_biu_cab_i  };
               if (  dwb_biu_biu_cyc_i  &  dwb_biu_biu_stb  ) 
                   dwb_biu_wb_fsm_state_nxt   =  dwb_biu_wb_fsm_trans  ;
                else  
                   dwb_biu_wb_fsm_state_nxt   =  dwb_biu_wb_fsm_idle  ;
             end  
           dwb_biu_wb_fsm_trans   :
             begin  
                dwb_biu_wb_cyc_nxt   =!  dwb_biu_wb_stb_o  |!  dwb_biu_wb_err_i  &!  dwb_biu_wb_rty_i  &!(  dwb_biu_wb_ack  &  dwb_biu_wb_cti_o  ==3'b111); 
                dwb_biu_wb_stb_nxt   =!  dwb_biu_wb_stb_o  |!  dwb_biu_wb_err_i  &!  dwb_biu_wb_rty_i  &!  dwb_biu_wb_ack  |!  dwb_biu_wb_err_i  &!  dwb_biu_wb_rty_i  &  dwb_biu_wb_cti_o  ==3'b010; 
                dwb_biu_wb_cti_nxt   [2]=  dwb_biu_wb_stb_o  &  dwb_biu_wb_ack  &  dwb_biu_burst_len  =='h0|  dwb_biu_wb_cti_o  [2]; 
                dwb_biu_wb_cti_nxt   [1]=1'b1; 
                dwb_biu_wb_cti_nxt   [0]=  dwb_biu_wb_stb_o  &  dwb_biu_wb_ack  &  dwb_biu_burst_len  =='h0|  dwb_biu_wb_cti_o  [0];
               if ((!  dwb_biu_biu_cyc_i  |!  dwb_biu_biu_stb  |!  dwb_biu_biu_cab_i  |  dwb_biu_biu_sel_i  !=  dwb_biu_wb_sel_o  |  dwb_biu_biu_we_i  !=  dwb_biu_wb_we_o  )&  dwb_biu_wb_cti_o  ==3'b010) 
                   dwb_biu_wb_fsm_state_nxt   =  dwb_biu_wb_fsm_last  ;
                else 
                  if ((  dwb_biu_wb_err_i  |  dwb_biu_wb_rty_i  |  dwb_biu_wb_ack  &  dwb_biu_wb_cti_o  ==3'b111)&  dwb_biu_wb_stb_o  ) 
                      dwb_biu_wb_fsm_state_nxt   =  dwb_biu_wb_fsm_idle  ;
                   else  
                      dwb_biu_wb_fsm_state_nxt   =  dwb_biu_wb_fsm_trans  ;
             end  
           dwb_biu_wb_fsm_last   :
             begin  
                dwb_biu_wb_cyc_nxt   =!  dwb_biu_wb_stb_o  |!  dwb_biu_wb_err_i  &!  dwb_biu_wb_rty_i  &!(  dwb_biu_wb_ack  &  dwb_biu_wb_cti_o  ==3'b111); 
                dwb_biu_wb_stb_nxt   =!  dwb_biu_wb_stb_o  |!  dwb_biu_wb_err_i  &!  dwb_biu_wb_rty_i  &!(  dwb_biu_wb_ack  &  dwb_biu_wb_cti_o  ==3'b111); 
                dwb_biu_wb_cti_nxt   [2]=  dwb_biu_wb_ack  &  dwb_biu_wb_stb_o  |  dwb_biu_wb_cti_o  [2]; 
                dwb_biu_wb_cti_nxt   [1]=1'b1; 
                dwb_biu_wb_cti_nxt   [0]=  dwb_biu_wb_ack  &  dwb_biu_wb_stb_o  |  dwb_biu_wb_cti_o  [0];
               if ((  dwb_biu_wb_err_i  |  dwb_biu_wb_rty_i  |  dwb_biu_wb_ack  &  dwb_biu_wb_cti_o  ==3'b111)&  dwb_biu_wb_stb_o  ) 
                   dwb_biu_wb_fsm_state_nxt   =  dwb_biu_wb_fsm_idle  ;
                else  
                   dwb_biu_wb_fsm_state_nxt   =  dwb_biu_wb_fsm_last  ;
             end 
          default :
             begin  
                dwb_biu_wb_cyc_nxt   =1'bx; 
                dwb_biu_wb_stb_nxt   =1'bx; 
                dwb_biu_wb_cti_nxt   =3'bxxx; 
                dwb_biu_wb_fsm_state_nxt   =2'bxx;
             end 
         endcase 
       end
  
  always @(  posedge    dwb_biu_wb_clk_i          or  posedge   dwb_biu_wb_rst_i  )
       begin 
         if (  dwb_biu_wb_rst_i  ==(1'b1))
            begin  
               dwb_biu_wb_cyc_o   <=1'b0; 
               dwb_biu_wb_stb_o   <=1'b0; 
               dwb_biu_wb_cti_o   <=3'b111; 
               dwb_biu_wb_bte_o   <=(  dwb_biu_bl  ==8)?2'b10:(  dwb_biu_bl  ==4)?2'b01:2'b00; 
               dwb_biu_wb_we_o   <=1'b0; 
               dwb_biu_wb_sel_o   <=4'hf; 
               dwb_biu_wb_adr_o   <={  dwb_biu_aw  {1'b0}};
            end 
          else 
            begin  
               dwb_biu_wb_cyc_o   <=  dwb_biu_wb_cyc_nxt  ;
              if (  dwb_biu_wb_ack  &  dwb_biu_wb_cti_o  ==3'b111) 
                  dwb_biu_wb_stb_o   <=1'b0;
               else  
                  dwb_biu_wb_stb_o   <=  dwb_biu_wb_stb_nxt  ; 
               dwb_biu_wb_cti_o   <=  dwb_biu_wb_cti_nxt  ; 
               dwb_biu_wb_bte_o   <=(  dwb_biu_bl  ==8)?2'b10:(  dwb_biu_bl  ==4)?2'b01:2'b00;
              if (  dwb_biu_wb_fsm_state_cur  ==  dwb_biu_wb_fsm_idle  )
                 begin  
                    dwb_biu_wb_we_o   <=  dwb_biu_biu_we_i  ; 
                    dwb_biu_wb_sel_o   <=  dwb_biu_biu_sel_i  ;
                 end 
              if (  dwb_biu_wb_fsm_state_cur  ==  dwb_biu_wb_fsm_idle  )
                 begin  
                    dwb_biu_wb_adr_o   <=  dwb_biu_biu_adr_i  ;
                 end 
               else 
                 if (  dwb_biu_wb_stb_o  &  dwb_biu_wb_ack  )
                    begin 
                      if (  dwb_biu_bl  ==4)
                         begin  
                            dwb_biu_wb_adr_o   [3:2]<=  dwb_biu_wb_adr_o  [3:2]+1;
                         end 
                      if (  dwb_biu_bl  ==8)
                         begin  
                            dwb_biu_wb_adr_o   [4:2]<=  dwb_biu_wb_adr_o  [4:2]+1;
                         end 
                    end 
            end 
       end
  
  always @(  posedge    dwb_biu_wb_clk_i          or  posedge   dwb_biu_wb_rst_i  )
       begin 
         if (  dwb_biu_wb_rst_i  ==(1'b1))
            begin  
               dwb_biu_wb_ack_cnt   <=1'b0; 
               dwb_biu_wb_err_cnt   <=1'b0; 
               dwb_biu_wb_rty_cnt   <=1'b0;
            end 
          else 
            begin 
              if (  dwb_biu_wb_fsm_state_cur  ==  dwb_biu_wb_fsm_idle  |!(|  dwb_biu_clmode  )) 
                  dwb_biu_wb_ack_cnt   <=1'b0;
               else 
                 if (  dwb_biu_wb_stb_o  &  dwb_biu_wb_ack  ) 
                     dwb_biu_wb_ack_cnt   <=!  dwb_biu_wb_ack_cnt  ;
              if (  dwb_biu_wb_fsm_state_cur  ==  dwb_biu_wb_fsm_idle  |!(|  dwb_biu_clmode  )) 
                  dwb_biu_wb_err_cnt   <=1'b0;
               else 
                 if (  dwb_biu_wb_stb_o  &  dwb_biu_wb_err_i  ) 
                     dwb_biu_wb_err_cnt   <=!  dwb_biu_wb_err_cnt  ;
              if (  dwb_biu_wb_fsm_state_cur  ==  dwb_biu_wb_fsm_idle  |!(|  dwb_biu_clmode  )) 
                  dwb_biu_wb_rty_cnt   <=1'b0;
               else 
                 if (  dwb_biu_wb_stb_o  &  dwb_biu_wb_rty_i  ) 
                     dwb_biu_wb_rty_cnt   <=!  dwb_biu_wb_rty_cnt  ;
            end 
       end
  
  always @(  posedge    dwb_biu_clk          or  posedge   dwb_biu_rst  )
       begin 
         if (  dwb_biu_rst  ==(1'b1))
            begin  
               dwb_biu_biu_stb_reg   <=1'b0; 
               dwb_biu_biu_ack_cnt   <=1'b0; 
               dwb_biu_biu_err_cnt   <=1'b0; 
               dwb_biu_biu_rty_cnt   <=1'b0;
            end 
          else 
            begin 
              if (  dwb_biu_biu_stb_i  &!  dwb_biu_biu_cab_i  &  dwb_biu_biu_ack_o  ) 
                  dwb_biu_biu_stb_reg   <=1'b0;
               else  
                  dwb_biu_biu_stb_reg   <=  dwb_biu_biu_stb_i  ;
              if (  dwb_biu_wb_fsm_state_cur  ==  dwb_biu_wb_fsm_idle  |!(|  dwb_biu_clmode  )) 
                  dwb_biu_biu_ack_cnt   <=1'b0;
               else 
                 if (  dwb_biu_biu_ack_o  ) 
                     dwb_biu_biu_ack_cnt   <=!  dwb_biu_biu_ack_cnt  ;
              if (  dwb_biu_wb_fsm_state_cur  ==  dwb_biu_wb_fsm_idle  |!(|  dwb_biu_clmode  )) 
                  dwb_biu_biu_err_cnt   <=1'b0;
               else 
                 if (  dwb_biu_wb_err_i  &  dwb_biu_biu_err_o  ) 
                     dwb_biu_biu_err_cnt   <=!  dwb_biu_biu_err_cnt  ;
              if (  dwb_biu_wb_fsm_state_cur  ==  dwb_biu_wb_fsm_idle  |!(|  dwb_biu_clmode  )) 
                  dwb_biu_biu_rty_cnt   <=1'b0;
               else 
                 if (  dwb_biu_biu_rty  ) 
                     dwb_biu_biu_rty_cnt   <=!  dwb_biu_biu_rty_cnt  ;
            end 
       end
  
  assign   dwb_biu_biu_stb  =  dwb_biu_biu_stb_i  &  dwb_biu_biu_stb_reg  ; 
  assign   dwb_biu_biu_dat_o  =  dwb_biu_wb_dat_i  ; 
  assign   dwb_biu_biu_rty  =(  dwb_biu_wb_fsm_state_cur  ==  dwb_biu_wb_fsm_trans  )&  dwb_biu_wb_rty_i  &  dwb_biu_wb_stb_o  &(  dwb_biu_wb_rty_cnt  ~^  dwb_biu_biu_rty_cnt  ); 
  assign   dwb_biu_biu_ack_o  =(  dwb_biu_wb_fsm_state_cur  ==  dwb_biu_wb_fsm_trans  )&  dwb_biu_wb_ack  &  dwb_biu_wb_stb_o  &(  dwb_biu_wb_ack_cnt  ~^  dwb_biu_biu_ack_cnt  ); 
  assign   dwb_biu_biu_err_o  =(  dwb_biu_wb_fsm_state_cur  ==  dwb_biu_wb_fsm_trans  )&  dwb_biu_wb_err_i  &  dwb_biu_wb_stb_o  &(  dwb_biu_wb_err_cnt  ~^  dwb_biu_biu_err_cnt  );
assign iwb_biu_clk = clk_i;
assign iwb_biu_rst = rst_i;
assign iwb_biu_clmode = clmode_i;
assign iwb_biu_wb_clk_i = dwb_clk_i;
assign iwb_biu_wb_rst_i = dwb_rst_i;
assign iwb_biu_wb_ack_i = dwb_ack_i;
assign iwb_biu_wb_err_i = dwb_err_i;
assign iwb_biu_wb_rty_i = dwb_rty_i;
assign iwb_biu_wb_dat_i = dwb_dat_i;
assign dwb_cyc_o = iwb_biu_wb_cyc_o;
assign dwb_adr_o = iwb_biu_wb_adr_o;
assign dwb_stb_o = iwb_biu_wb_stb_o;
assign dwb_we_o = iwb_biu_wb_we_o;
assign dwb_sel_o = iwb_biu_wb_sel_o;
assign dwb_dat_o = iwb_biu_wb_dat_o;
assign dwb_cti_o = iwb_biu_wb_cti_o;
assign dwb_bte_o = iwb_biu_wb_bte_o;
assign iwb_biu_biu_dat_i = sbbiu_dat_sb;
assign iwb_biu_biu_adr_i = sbbiu_adr_sb;
assign iwb_biu_biu_cyc_i = sbbiu_cyc_sb;
assign iwb_biu_biu_stb_i = sbbiu_stb_sb;
assign iwb_biu_biu_we_i = sbbiu_we_sb;
assign iwb_biu_biu_sel_i = sbbiu_sel_sb;
assign iwb_biu_biu_cab_i = sbbiu_cab_sb;
assign sbbiu_dat_biu = iwb_biu_biu_dat_o;
assign sbbiu_ack_biu = iwb_biu_biu_ack_o;
assign sbbiu_err_biu = iwb_biu_biu_err_o;
assign dwb_biu_clk = clk_i;
assign dwb_biu_rst = rst_i;
assign dwb_biu_clmode = clmode_i;
assign dwb_biu_wb_clk_i = dwb_clk_i;
assign dwb_biu_wb_rst_i = dwb_rst_i;
assign dwb_biu_wb_ack_i = dwb_ack_i;
assign dwb_biu_wb_err_i = dwb_err_i;
assign dwb_biu_wb_rty_i = dwb_rty_i;
assign dwb_biu_wb_dat_i = dwb_dat_i;
assign dwb_cyc_o = dwb_biu_wb_cyc_o;
assign dwb_adr_o = dwb_biu_wb_adr_o;
assign dwb_stb_o = dwb_biu_wb_stb_o;
assign dwb_we_o = dwb_biu_wb_we_o;
assign dwb_sel_o = dwb_biu_wb_sel_o;
assign dwb_dat_o = dwb_biu_wb_dat_o;
assign dwb_cti_o = dwb_biu_wb_cti_o;
assign dwb_bte_o = dwb_biu_wb_bte_o;
assign dwb_biu_biu_dat_i = sbbiu_dat_sb;
assign dwb_biu_biu_adr_i = sbbiu_adr_sb;
assign dwb_biu_biu_cyc_i = sbbiu_cyc_sb;
assign dwb_biu_biu_stb_i = sbbiu_stb_sb;
assign dwb_biu_biu_we_i = sbbiu_we_sb;
assign dwb_biu_biu_sel_i = sbbiu_sel_sb;
assign dwb_biu_biu_cab_i = sbbiu_cab_sb;
assign sbbiu_dat_biu = dwb_biu_biu_dat_o;
assign sbbiu_ack_biu = dwb_biu_biu_ack_o;
assign sbbiu_err_biu = dwb_biu_biu_err_o;
 
  
wire  or1200_immu_top_clk;
wire  or1200_immu_top_rst;
wire  or1200_immu_top_ic_en;
wire  or1200_immu_top_immu_en;
wire  or1200_immu_top_supv;
wire [ or1200_immu_top_aw -1:0] or1200_immu_top_icpu_adr_i;
wire  or1200_immu_top_icpu_cycstb_i;
reg [ or1200_immu_top_aw -1:0] or1200_immu_top_icpu_adr_o;
wire [3:0] or1200_immu_top_icpu_tag_o;
wire  or1200_immu_top_icpu_rty_o;
wire  or1200_immu_top_icpu_err_o;
wire  or1200_immu_top_boot_adr_sel_i;
wire  or1200_immu_top_spr_cs;
wire  or1200_immu_top_spr_write;
wire [ or1200_immu_top_aw -1:0] or1200_immu_top_spr_addr;
wire [31:0] or1200_immu_top_spr_dat_i;
wire [31:0] or1200_immu_top_spr_dat_o;
wire  or1200_immu_top_qmemimmu_rty_i;
wire  or1200_immu_top_qmemimmu_err_i;
wire [3:0] or1200_immu_top_qmemimmu_tag_i;
wire [ or1200_immu_top_aw -1:0] or1200_immu_top_qmemimmu_adr_o;
wire  or1200_immu_top_qmemimmu_cycstb_o;
wire  or1200_immu_top_qmemimmu_ci_o;
 
   wire  or1200_immu_top_itlb_spr_access  ; 
   wire[31:13]  or1200_immu_top_itlb_ppn  ; 
   wire  or1200_immu_top_itlb_hit  ; 
   wire  or1200_immu_top_itlb_uxe  ; 
   wire  or1200_immu_top_itlb_sxe  ; 
   wire[31:0]  or1200_immu_top_itlb_dat_o  ; 
   wire  or1200_immu_top_itlb_en  ; 
   wire  or1200_immu_top_itlb_ci  ; 
   wire  or1200_immu_top_itlb_done  ; 
   wire  or1200_immu_top_fault  ; 
   wire  or1200_immu_top_miss  ; 
   wire  or1200_immu_top_page_cross  ; 
   reg[31:0]  or1200_immu_top_icpu_adr_default  ; 
   reg  or1200_immu_top_icpu_adr_select  ; 
   reg[31:13]  or1200_immu_top_icpu_vpn_r  ; 
   reg  or1200_immu_top_itlb_en_r  ; 
   reg  or1200_immu_top_dis_spr_access_frst_clk  ; 
   reg  or1200_immu_top_dis_spr_access_scnd_clk  ; 
   wire[31:0]  or1200_immu_top_icpu_adr_boot  =  or1200_immu_top_boot_adr  ; 
  always @(  posedge    or1200_immu_top_rst          or  posedge   or1200_immu_top_clk  )
       if (  or1200_immu_top_rst  ==(1'b1))
          begin  
             or1200_immu_top_icpu_adr_default   <=32'h0000_0100; 
             or1200_immu_top_icpu_adr_select   <=1'b1;
          end 
        else 
          if (  or1200_immu_top_icpu_adr_select  )
             begin  
                or1200_immu_top_icpu_adr_default   <=  or1200_immu_top_icpu_adr_boot  ; 
                or1200_immu_top_icpu_adr_select   <=1'b0;
             end 
           else 
             begin  
                or1200_immu_top_icpu_adr_default   <=  or1200_immu_top_icpu_adr_i  ;
             end
  
  always @(     or1200_immu_top_icpu_adr_boot              or    or1200_immu_top_icpu_adr_default           or    or1200_immu_top_icpu_adr_select   )
       if (  or1200_immu_top_icpu_adr_select  ) 
           or1200_immu_top_icpu_adr_o   =  or1200_immu_top_icpu_adr_boot  ;
        else  
           or1200_immu_top_icpu_adr_o   =  or1200_immu_top_icpu_adr_default  ;
 
  assign   or1200_immu_top_page_cross  =  or1200_immu_top_icpu_adr_i  [31:13]!=  or1200_immu_top_icpu_vpn_r  ; 
  always @(  posedge    or1200_immu_top_clk          or  posedge   or1200_immu_top_rst  )
       if (  or1200_immu_top_rst  ==(1'b1)) 
           or1200_immu_top_icpu_vpn_r   <={32-13{1'b0}};
        else  
           or1200_immu_top_icpu_vpn_r   <=  or1200_immu_top_icpu_adr_i  [31:13];
 
  assign   or1200_immu_top_itlb_spr_access  =  or1200_immu_top_spr_cs  &~  or1200_immu_top_dis_spr_access_scnd_clk  ; 
  always @(  posedge    or1200_immu_top_clk          or  posedge   or1200_immu_top_rst  )
       if (  or1200_immu_top_rst  ==(1'b1)) 
           or1200_immu_top_dis_spr_access_frst_clk   <=1'b0;
        else 
          if (!  or1200_immu_top_icpu_rty_o  ) 
              or1200_immu_top_dis_spr_access_frst_clk   <=1'b0;
           else 
             if (  or1200_immu_top_spr_cs  ) 
                 or1200_immu_top_dis_spr_access_frst_clk   <=1'b1;
 
  always @(  posedge    or1200_immu_top_clk          or  posedge   or1200_immu_top_rst  )
       if (  or1200_immu_top_rst  ==(1'b1)) 
           or1200_immu_top_dis_spr_access_scnd_clk   <=1'b0;
        else 
          if (!  or1200_immu_top_icpu_rty_o  ) 
              or1200_immu_top_dis_spr_access_scnd_clk   <=1'b0;
           else 
             if (  or1200_immu_top_dis_spr_access_frst_clk  ) 
                 or1200_immu_top_dis_spr_access_scnd_clk   <=1'b1;
 
  assign   or1200_immu_top_icpu_tag_o  =  or1200_immu_top_miss  ?4'hd:  or1200_immu_top_fault  ?4'hc:  or1200_immu_top_qmemimmu_tag_i  ; 
  assign   or1200_immu_top_icpu_rty_o  =  or1200_immu_top_qmemimmu_rty_i  ; 
  assign   or1200_immu_top_icpu_err_o  =  or1200_immu_top_miss  |  or1200_immu_top_fault  |  or1200_immu_top_qmemimmu_err_i  ; 
  always @(  posedge    or1200_immu_top_clk          or  posedge   or1200_immu_top_rst  )
       if (  or1200_immu_top_rst  ==(1'b1)) 
           or1200_immu_top_itlb_en_r   <=1'b0;
        else  
           or1200_immu_top_itlb_en_r   <=  or1200_immu_top_itlb_en  &~  or1200_immu_top_itlb_spr_access  ;
 
  assign   or1200_immu_top_itlb_done  =  or1200_immu_top_itlb_en_r  &~  or1200_immu_top_page_cross  ; 
  assign   or1200_immu_top_qmemimmu_cycstb_o  =  or1200_immu_top_immu_en  ?~(  or1200_immu_top_miss  |  or1200_immu_top_fault  )&  or1200_immu_top_icpu_cycstb_i  &~  or1200_immu_top_page_cross  &  or1200_immu_top_itlb_done  &~  or1200_immu_top_itlb_spr_access  :  or1200_immu_top_icpu_cycstb_i  &~  or1200_immu_top_page_cross  ; 
  assign   or1200_immu_top_qmemimmu_ci_o  =  or1200_immu_top_immu_en  ?  or1200_immu_top_itlb_ci  :1'b0; 
  assign   or1200_immu_top_qmemimmu_adr_o  =  or1200_immu_top_immu_en  &  or1200_immu_top_itlb_done  ?{  or1200_immu_top_itlb_ppn  ,  or1200_immu_top_icpu_adr_i  [13-1:2],2'h0}:{  or1200_immu_top_icpu_vpn_r  ,  or1200_immu_top_icpu_adr_i  [13-1:2],2'h0}; 
   reg[31:0]  or1200_immu_top_spr_dat_reg  ; 
  always @(  posedge    or1200_immu_top_clk          or  posedge   or1200_immu_top_rst  )
       if (  or1200_immu_top_rst  ==(1'b1)) 
           or1200_immu_top_spr_dat_reg   <=32'h0000_0000;
        else 
          if (  or1200_immu_top_spr_cs  &!  or1200_immu_top_dis_spr_access_scnd_clk  ) 
              or1200_immu_top_spr_dat_reg   <=  or1200_immu_top_itlb_dat_o  ;
 
  assign   or1200_immu_top_spr_dat_o  =  or1200_immu_top_itlb_spr_access  ?  or1200_immu_top_itlb_dat_o  :  or1200_immu_top_spr_dat_reg  ; 
  assign   or1200_immu_top_fault  =  or1200_immu_top_itlb_done  &((!  or1200_immu_top_supv  &!  or1200_immu_top_itlb_uxe  )||(  or1200_immu_top_supv  &!  or1200_immu_top_itlb_sxe  )); 
  assign   or1200_immu_top_miss  =  or1200_immu_top_itlb_done  &!  or1200_immu_top_itlb_hit  ; 
  assign   or1200_immu_top_itlb_en  =  or1200_immu_top_immu_en  &  or1200_immu_top_icpu_cycstb_i  ;  
  
wire  or1200_immu_top_or1200_immu_tlb_clk;
wire  or1200_immu_top_or1200_immu_tlb_rst;
wire  or1200_immu_top_or1200_immu_tlb_tlb_en;
wire [ or1200_immu_top_or1200_immu_tlb_aw -1:0] or1200_immu_top_or1200_immu_tlb_vaddr;
wire  or1200_immu_top_or1200_immu_tlb_hit;
wire [31:13] or1200_immu_top_or1200_immu_tlb_ppn;
wire  or1200_immu_top_or1200_immu_tlb_uxe;
wire  or1200_immu_top_or1200_immu_tlb_sxe;
wire  or1200_immu_top_or1200_immu_tlb_ci;
wire  or1200_immu_top_or1200_immu_tlb_spr_cs;
wire  or1200_immu_top_or1200_immu_tlb_spr_write;
wire [31:0] or1200_immu_top_or1200_immu_tlb_spr_addr;
wire [31:0] or1200_immu_top_or1200_immu_tlb_spr_dat_i;
wire [31:0] or1200_immu_top_or1200_immu_tlb_spr_dat_o;
 
   wire[31:13+6-1+1]  or1200_immu_top_or1200_immu_tlb_vpn  ; 
   wire  or1200_immu_top_or1200_immu_tlb_v  ; 
   wire[6-1:0]  or1200_immu_top_or1200_immu_tlb_tlb_index  ; 
   wire  or1200_immu_top_or1200_immu_tlb_tlb_mr_en  ; 
   wire  or1200_immu_top_or1200_immu_tlb_tlb_mr_we  ; 
   wire[32-6-13+1-1:0]  or1200_immu_top_or1200_immu_tlb_tlb_mr_ram_in  ; 
   wire[32-6-13+1-1:0]  or1200_immu_top_or1200_immu_tlb_tlb_mr_ram_out  ; 
   wire  or1200_immu_top_or1200_immu_tlb_tlb_tr_en  ; 
   wire  or1200_immu_top_or1200_immu_tlb_tlb_tr_we  ; 
   wire[32-13+3-1:0]  or1200_immu_top_or1200_immu_tlb_tlb_tr_ram_in  ; 
   wire[32-13+3-1:0]  or1200_immu_top_or1200_immu_tlb_tlb_tr_ram_out  ; 
  assign   or1200_immu_top_or1200_immu_tlb_tlb_mr_en  =  or1200_immu_top_or1200_immu_tlb_tlb_en  |(  or1200_immu_top_or1200_immu_tlb_spr_cs  &!  or1200_immu_top_or1200_immu_tlb_spr_addr  [7]); 
  assign   or1200_immu_top_or1200_immu_tlb_tlb_mr_we  =  or1200_immu_top_or1200_immu_tlb_spr_cs  &  or1200_immu_top_or1200_immu_tlb_spr_write  &!  or1200_immu_top_or1200_immu_tlb_spr_addr  [7]; 
  assign   or1200_immu_top_or1200_immu_tlb_tlb_tr_en  =  or1200_immu_top_or1200_immu_tlb_tlb_en  |(  or1200_immu_top_or1200_immu_tlb_spr_cs  &  or1200_immu_top_or1200_immu_tlb_spr_addr  [7]); 
  assign   or1200_immu_top_or1200_immu_tlb_tlb_tr_we  =  or1200_immu_top_or1200_immu_tlb_spr_cs  &  or1200_immu_top_or1200_immu_tlb_spr_write  &  or1200_immu_top_or1200_immu_tlb_spr_addr  [7]; 
  assign   or1200_immu_top_or1200_immu_tlb_spr_dat_o  =(!  or1200_immu_top_or1200_immu_tlb_spr_write  &!  or1200_immu_top_or1200_immu_tlb_spr_addr  [7])?{  or1200_immu_top_or1200_immu_tlb_vpn  ,  or1200_immu_top_or1200_immu_tlb_tlb_index  ,{32-6-13-7{1'b0}},1'b0,5'b00000,  or1200_immu_top_or1200_immu_tlb_v  }:(!  or1200_immu_top_or1200_immu_tlb_spr_write  &  or1200_immu_top_or1200_immu_tlb_spr_addr  [7])?{  or1200_immu_top_or1200_immu_tlb_ppn  ,{13-8{1'b0}},  or1200_immu_top_or1200_immu_tlb_uxe  ,  or1200_immu_top_or1200_immu_tlb_sxe  ,{4{1'b0}},  or1200_immu_top_or1200_immu_tlb_ci  ,1'b0}:32'h00000000; 
  assign {  or1200_immu_top_or1200_immu_tlb_vpn  ,  or1200_immu_top_or1200_immu_tlb_v  }=  or1200_immu_top_or1200_immu_tlb_tlb_mr_ram_out  ; 
  assign   or1200_immu_top_or1200_immu_tlb_tlb_mr_ram_in  ={  or1200_immu_top_or1200_immu_tlb_spr_dat_i  [31:13+6-1+1],  or1200_immu_top_or1200_immu_tlb_spr_dat_i  [0]}; 
  assign {  or1200_immu_top_or1200_immu_tlb_ppn  ,  or1200_immu_top_or1200_immu_tlb_uxe  ,  or1200_immu_top_or1200_immu_tlb_sxe  ,  or1200_immu_top_or1200_immu_tlb_ci  }=  or1200_immu_top_or1200_immu_tlb_tlb_tr_ram_out  ; 
  assign   or1200_immu_top_or1200_immu_tlb_tlb_tr_ram_in  ={  or1200_immu_top_or1200_immu_tlb_spr_dat_i  [31:13],  or1200_immu_top_or1200_immu_tlb_spr_dat_i  [7],  or1200_immu_top_or1200_immu_tlb_spr_dat_i  [6],  or1200_immu_top_or1200_immu_tlb_spr_dat_i  [1]}; 
  assign   or1200_immu_top_or1200_immu_tlb_hit  =(  or1200_immu_top_or1200_immu_tlb_vpn  ==  or1200_immu_top_or1200_immu_tlb_vaddr  [31:13+6-1+1])&  or1200_immu_top_or1200_immu_tlb_v  ; 
  assign   or1200_immu_top_or1200_immu_tlb_tlb_index  =  or1200_immu_top_or1200_immu_tlb_spr_cs  ?  or1200_immu_top_or1200_immu_tlb_spr_addr  [6-1:0]:  or1200_immu_top_or1200_immu_tlb_vaddr  [13+6-1:13];  
  
wire  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_clk;
wire  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_ce;
wire  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_we;
wire [ or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_aw -1:0] or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_addr;
wire [ or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_dw -1:0] or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_di;
wire [ or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_dw -1:0] or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_doq;
wire  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_clk;
wire  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_ce;
wire  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_we;
wire [ or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_aw -1:0] or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_addr;
wire [ or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_dw -1:0] or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_di;
wire [ or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_dw -1:0] or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_doq;
 
   reg[  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_dw  -1:0]  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_mem  [(1<<  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_aw  )-1:0]; 
   reg[  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_aw  -1:0]  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_addr_reg  ; 
  assign   or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_doq  =  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_mem  [  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_addr_reg  ]; 
  always @( posedge   or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_clk  )
       if (  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_ce  ) 
           or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_addr_reg   <=  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_addr  ;
 
  always @( posedge   or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_clk  )
       if (  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_we  &&  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_ce  ) 
           or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_mem   [  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_addr  ]<=  or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_di  ;

  
  
 
   reg[  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_dw  -1:0]  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_mem  [(1<<  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_aw  )-1:0]; 
   reg[  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_aw  -1:0]  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_addr_reg  ; 
  assign   or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_doq  =  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_mem  [  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_addr_reg  ]; 
  always @( posedge   or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_clk  )
       if (  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_ce  ) 
           or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_addr_reg   <=  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_addr  ;
 
  always @( posedge   or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_clk  )
       if (  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_we  &&  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_ce  ) 
           or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_mem   [  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_addr  ]<=  or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_di  ;

assign or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_clk = or1200_immu_top_or1200_immu_tlb_clk;
assign or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_ce = or1200_immu_top_or1200_immu_tlb_tlb_tr_en;
assign or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_we = or1200_immu_top_or1200_immu_tlb_tlb_tr_we;
assign or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_addr = or1200_immu_top_or1200_immu_tlb_tlb_index;
assign or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_di = or1200_immu_top_or1200_immu_tlb_tlb_tr_ram_in;
assign or1200_immu_top_or1200_immu_tlb_tlb_tr_ram_out = or1200_immu_top_or1200_immu_tlb_itlb_mr_ram_doq;
assign or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_clk = or1200_immu_top_or1200_immu_tlb_clk;
assign or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_ce = or1200_immu_top_or1200_immu_tlb_tlb_tr_en;
assign or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_we = or1200_immu_top_or1200_immu_tlb_tlb_tr_we;
assign or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_addr = or1200_immu_top_or1200_immu_tlb_tlb_index;
assign or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_di = or1200_immu_top_or1200_immu_tlb_tlb_tr_ram_in;
assign or1200_immu_top_or1200_immu_tlb_tlb_tr_ram_out = or1200_immu_top_or1200_immu_tlb_itlb_tr_ram_doq;

assign or1200_immu_top_or1200_immu_tlb_clk = or1200_immu_top_clk;
assign or1200_immu_top_or1200_immu_tlb_rst = or1200_immu_top_rst;
assign or1200_immu_top_or1200_immu_tlb_tlb_en = or1200_immu_top_itlb_en;
assign or1200_immu_top_or1200_immu_tlb_vaddr = or1200_immu_top_icpu_adr_i;
assign or1200_immu_top_itlb_hit = or1200_immu_top_or1200_immu_tlb_hit;
assign or1200_immu_top_itlb_ppn = or1200_immu_top_or1200_immu_tlb_ppn;
assign or1200_immu_top_itlb_uxe = or1200_immu_top_or1200_immu_tlb_uxe;
assign or1200_immu_top_itlb_sxe = or1200_immu_top_or1200_immu_tlb_sxe;
assign or1200_immu_top_itlb_ci = or1200_immu_top_or1200_immu_tlb_ci;
assign or1200_immu_top_or1200_immu_tlb_spr_cs = or1200_immu_top_itlb_spr_access;
assign or1200_immu_top_or1200_immu_tlb_spr_write = or1200_immu_top_spr_write;
assign or1200_immu_top_or1200_immu_tlb_spr_addr = or1200_immu_top_spr_addr;
assign or1200_immu_top_or1200_immu_tlb_spr_dat_i = or1200_immu_top_spr_dat_i;
assign or1200_immu_top_itlb_dat_o = or1200_immu_top_or1200_immu_tlb_spr_dat_o;

assign or1200_immu_top_clk = clk_i;
assign or1200_immu_top_rst = rst_i;
assign or1200_immu_top_ic_en = ic_en;
assign or1200_immu_top_immu_en = immu_en;
assign or1200_immu_top_supv = supv;
assign or1200_immu_top_icpu_adr_i = icpu_adr_cpu;
assign or1200_immu_top_icpu_cycstb_i = icpu_cycstb_cpu;
assign icpu_adr_immu = or1200_immu_top_icpu_adr_o;
assign icpu_tag_immu = or1200_immu_top_icpu_tag_o;
assign icpu_rty_immu = or1200_immu_top_icpu_rty_o;
assign icpu_err_immu = or1200_immu_top_icpu_err_o;
assign or1200_immu_top_boot_adr_sel_i = boot_adr_sel;
assign or1200_immu_top_spr_cs = spr_cs[5'd02];
assign or1200_immu_top_spr_write = spr_we;
assign or1200_immu_top_spr_addr = spr_addr;
assign or1200_immu_top_spr_dat_i = spr_dat_cpu;
assign spr_dat_immu = or1200_immu_top_spr_dat_o;
assign or1200_immu_top_qmemimmu_rty_i = qmemimmu_rty_qmem;
assign or1200_immu_top_qmemimmu_err_i = qmemimmu_err_qmem;
assign or1200_immu_top_qmemimmu_tag_i = qmemimmu_tag_qmem;
assign qmemimmu_adr_immu = or1200_immu_top_qmemimmu_adr_o;
assign qmemimmu_cycstb_immu = or1200_immu_top_qmemimmu_cycstb_o;
assign qmemimmu_ci_immu = or1200_immu_top_qmemimmu_ci_o;
 
  
wire  or1200_ic_top_clk;
wire  or1200_ic_top_rst;
wire [ or1200_ic_top_dw -1:0] or1200_ic_top_icbiu_dat_o;
wire [31:0] or1200_ic_top_icbiu_adr_o;
wire  or1200_ic_top_icbiu_cyc_o;
wire  or1200_ic_top_icbiu_stb_o;
wire  or1200_ic_top_icbiu_we_o;
wire [3:0] or1200_ic_top_icbiu_sel_o;
wire  or1200_ic_top_icbiu_cab_o;
wire [ or1200_ic_top_dw -1:0] or1200_ic_top_icbiu_dat_i;
wire  or1200_ic_top_icbiu_ack_i;
wire  or1200_ic_top_icbiu_err_i;
wire  or1200_ic_top_ic_en;
wire [31:0] or1200_ic_top_icqmem_adr_i;
wire  or1200_ic_top_icqmem_cycstb_i;
wire  or1200_ic_top_icqmem_ci_i;
wire [3:0] or1200_ic_top_icqmem_sel_i;
wire [3:0] or1200_ic_top_icqmem_tag_i;
wire [ or1200_ic_top_dw -1:0] or1200_ic_top_icqmem_dat_o;
wire  or1200_ic_top_icqmem_ack_o;
wire  or1200_ic_top_icqmem_rty_o;
wire  or1200_ic_top_icqmem_err_o;
wire [3:0] or1200_ic_top_icqmem_tag_o;
wire  or1200_ic_top_spr_cs;
wire  or1200_ic_top_spr_write;
wire [31:0] or1200_ic_top_spr_dat_i;
 
   wire  or1200_ic_top_tag_v  ; 
   wire[20-2:0]  or1200_ic_top_tag  ; 
   wire[  or1200_ic_top_dw  -1:0]  or1200_ic_top_to_icram  ; 
   wire[  or1200_ic_top_dw  -1:0]  or1200_ic_top_from_icram  ; 
   wire[31:0]  or1200_ic_top_saved_addr  ; 
   wire[3:0]  or1200_ic_top_icram_we  ; 
   wire  or1200_ic_top_ictag_we  ; 
   wire[31:0]  or1200_ic_top_ic_addr  ; 
   wire  or1200_ic_top_icfsm_biu_read  ; 
   reg  or1200_ic_top_tagcomp_miss  ; 
   wire[13-1:4]  or1200_ic_top_ictag_addr  ; 
   wire  or1200_ic_top_ictag_en  ; 
   wire  or1200_ic_top_ictag_v  ; 
   wire  or1200_ic_top_ic_inv  ; 
   wire  or1200_ic_top_icfsm_first_hit_ack  ; 
   wire  or1200_ic_top_icfsm_first_miss_ack  ; 
   wire  or1200_ic_top_icfsm_first_miss_err  ; 
   wire  or1200_ic_top_icfsm_burst  ; 
   wire  or1200_ic_top_icfsm_tag_we  ; 
   reg  or1200_ic_top_ic_inv_q  ; 
  assign   or1200_ic_top_icbiu_adr_o  =  or1200_ic_top_ic_addr  ; 
  assign   or1200_ic_top_ic_inv  =  or1200_ic_top_spr_cs  &  or1200_ic_top_spr_write  ; 
  assign   or1200_ic_top_ictag_we  =  or1200_ic_top_icfsm_tag_we  |  or1200_ic_top_ic_inv  ; 
  assign   or1200_ic_top_ictag_addr  =  or1200_ic_top_ic_inv  ?  or1200_ic_top_spr_dat_i  [13-1:4]:  or1200_ic_top_ic_addr  [13-1:4]; 
  assign   or1200_ic_top_ictag_en  =  or1200_ic_top_ic_inv  |  or1200_ic_top_ic_en  ; 
  assign   or1200_ic_top_ictag_v  =~  or1200_ic_top_ic_inv  ; 
  assign   or1200_ic_top_icbiu_dat_o  =32'h00000000; 
  assign   or1200_ic_top_icbiu_cyc_o  =(  or1200_ic_top_ic_en  )?  or1200_ic_top_icfsm_biu_read  :  or1200_ic_top_icqmem_cycstb_i  ; 
  assign   or1200_ic_top_icbiu_stb_o  =(  or1200_ic_top_ic_en  )?  or1200_ic_top_icfsm_biu_read  :  or1200_ic_top_icqmem_cycstb_i  ; 
  assign   or1200_ic_top_icbiu_we_o  =1'b0; 
  assign   or1200_ic_top_icbiu_sel_o  =(  or1200_ic_top_ic_en  &  or1200_ic_top_icfsm_biu_read  )?4'b1111:  or1200_ic_top_icqmem_sel_i  ; 
  assign   or1200_ic_top_icbiu_cab_o  =(  or1200_ic_top_ic_en  )?  or1200_ic_top_icfsm_burst  :1'b0; 
  assign   or1200_ic_top_icqmem_rty_o  =~  or1200_ic_top_icqmem_ack_o  &~  or1200_ic_top_icqmem_err_o  ; 
  assign   or1200_ic_top_icqmem_tag_o  =  or1200_ic_top_icqmem_err_o  ?4'hb:  or1200_ic_top_icqmem_tag_i  ; 
  assign   or1200_ic_top_icqmem_ack_o  =  or1200_ic_top_ic_en  ?(  or1200_ic_top_icfsm_first_hit_ack  |  or1200_ic_top_icfsm_first_miss_ack  ):  or1200_ic_top_icbiu_ack_i  ; 
  assign   or1200_ic_top_icqmem_err_o  =  or1200_ic_top_ic_en  ?  or1200_ic_top_icfsm_first_miss_err  :  or1200_ic_top_icbiu_err_i  ; 
  assign   or1200_ic_top_ic_addr  =(  or1200_ic_top_icfsm_biu_read  )?  or1200_ic_top_saved_addr  :  or1200_ic_top_icqmem_adr_i  ; 
  assign   or1200_ic_top_to_icram  =  or1200_ic_top_icbiu_dat_i  ; 
  assign   or1200_ic_top_icqmem_dat_o  =  or1200_ic_top_icfsm_first_miss_ack  |!  or1200_ic_top_ic_en  ?  or1200_ic_top_icbiu_dat_i  :  or1200_ic_top_from_icram  ; 
  always @(  posedge    or1200_ic_top_clk          or  posedge   or1200_ic_top_rst  )
       if (  or1200_ic_top_rst  ==(1'b1)) 
           or1200_ic_top_ic_inv_q   <=1'b0;
        else  
           or1200_ic_top_ic_inv_q   <=  or1200_ic_top_ic_inv  ;
 
  always @(     or1200_ic_top_tag              or    or1200_ic_top_saved_addr           or    or1200_ic_top_tag_v   )
       begin 
         if ((  or1200_ic_top_tag  !=  or1200_ic_top_saved_addr  [31:13-1+1])|!  or1200_ic_top_tag_v  ) 
             or1200_ic_top_tagcomp_miss   =1'b1;
          else  
             or1200_ic_top_tagcomp_miss   =1'b0;
       end
   
  
wire  or1200_ic_top_or1200_ic_fsm_clk;
wire  or1200_ic_top_or1200_ic_fsm_rst;
wire  or1200_ic_top_or1200_ic_fsm_ic_en;
wire  or1200_ic_top_or1200_ic_fsm_icqmem_cycstb_i;
wire  or1200_ic_top_or1200_ic_fsm_icqmem_ci_i;
wire  or1200_ic_top_or1200_ic_fsm_tagcomp_miss;
wire  or1200_ic_top_or1200_ic_fsm_biudata_valid;
wire  or1200_ic_top_or1200_ic_fsm_biudata_error;
wire [31:0] or1200_ic_top_or1200_ic_fsm_start_addr;
wire [31:0] or1200_ic_top_or1200_ic_fsm_saved_addr;
wire [3:0] or1200_ic_top_or1200_ic_fsm_icram_we;
wire  or1200_ic_top_or1200_ic_fsm_tag_we;
wire  or1200_ic_top_or1200_ic_fsm_biu_read;
wire  or1200_ic_top_or1200_ic_fsm_first_hit_ack;
wire  or1200_ic_top_or1200_ic_fsm_first_miss_ack;
wire  or1200_ic_top_or1200_ic_fsm_first_miss_err;
wire  or1200_ic_top_or1200_ic_fsm_burst;
 
   reg[31:0]  or1200_ic_top_or1200_ic_fsm_saved_addr_r  ; 
   reg[1:0]  or1200_ic_top_or1200_ic_fsm_state  ; 
   reg[4-1:0]  or1200_ic_top_or1200_ic_fsm_cnt  ; 
   reg  or1200_ic_top_or1200_ic_fsm_hitmiss_eval  ; 
   reg  or1200_ic_top_or1200_ic_fsm_load  ; 
   reg  or1200_ic_top_or1200_ic_fsm_cache_inhibit  ; 
   reg  or1200_ic_top_or1200_ic_fsm_last_eval_miss  ; 
  assign   or1200_ic_top_or1200_ic_fsm_icram_we  ={4{  or1200_ic_top_or1200_ic_fsm_biu_read  &  or1200_ic_top_or1200_ic_fsm_biudata_valid  &!  or1200_ic_top_or1200_ic_fsm_cache_inhibit  }}; 
  assign   or1200_ic_top_or1200_ic_fsm_tag_we  =  or1200_ic_top_or1200_ic_fsm_biu_read  &  or1200_ic_top_or1200_ic_fsm_biudata_valid  &!  or1200_ic_top_or1200_ic_fsm_cache_inhibit  ; 
  assign   or1200_ic_top_or1200_ic_fsm_biu_read  =(  or1200_ic_top_or1200_ic_fsm_hitmiss_eval  &  or1200_ic_top_or1200_ic_fsm_tagcomp_miss  )|(!  or1200_ic_top_or1200_ic_fsm_hitmiss_eval  &  or1200_ic_top_or1200_ic_fsm_load  ); 
  assign   or1200_ic_top_or1200_ic_fsm_saved_addr  =  or1200_ic_top_or1200_ic_fsm_saved_addr_r  ; 
  assign   or1200_ic_top_or1200_ic_fsm_first_hit_ack  =(  or1200_ic_top_or1200_ic_fsm_state  ==2'd1)&  or1200_ic_top_or1200_ic_fsm_hitmiss_eval  &!  or1200_ic_top_or1200_ic_fsm_tagcomp_miss  &!  or1200_ic_top_or1200_ic_fsm_cache_inhibit  ; 
  assign   or1200_ic_top_or1200_ic_fsm_first_miss_ack  =(  or1200_ic_top_or1200_ic_fsm_state  ==2'd1)&  or1200_ic_top_or1200_ic_fsm_biudata_valid  &~  or1200_ic_top_or1200_ic_fsm_first_hit_ack  ; 
  assign   or1200_ic_top_or1200_ic_fsm_first_miss_err  =(  or1200_ic_top_or1200_ic_fsm_state  ==2'd1)&  or1200_ic_top_or1200_ic_fsm_biudata_error  ; 
  assign   or1200_ic_top_or1200_ic_fsm_burst  =(  or1200_ic_top_or1200_ic_fsm_state  ==2'd1)&  or1200_ic_top_or1200_ic_fsm_tagcomp_miss  &!  or1200_ic_top_or1200_ic_fsm_cache_inhibit  |(  or1200_ic_top_or1200_ic_fsm_state  ==2'd2); 
  always @(  posedge    or1200_ic_top_or1200_ic_fsm_clk          or  posedge   or1200_ic_top_or1200_ic_fsm_rst  )
       begin 
         if (  or1200_ic_top_or1200_ic_fsm_rst  ==(1'b1))
            begin  
               or1200_ic_top_or1200_ic_fsm_state   <=2'd0; 
               or1200_ic_top_or1200_ic_fsm_saved_addr_r   <=32'b0; 
               or1200_ic_top_or1200_ic_fsm_hitmiss_eval   <=1'b0; 
               or1200_ic_top_or1200_ic_fsm_load   <=1'b0; 
               or1200_ic_top_or1200_ic_fsm_cnt   <=4'd0; 
               or1200_ic_top_or1200_ic_fsm_cache_inhibit   <=1'b0; 
               or1200_ic_top_or1200_ic_fsm_last_eval_miss   <=0;
            end 
          else 
            case (  or1200_ic_top_or1200_ic_fsm_state  )
             2 'd0:
                if (  or1200_ic_top_or1200_ic_fsm_ic_en  &  or1200_ic_top_or1200_ic_fsm_icqmem_cycstb_i  )
                   begin  
                      or1200_ic_top_or1200_ic_fsm_state   <=2'd1; 
                      or1200_ic_top_or1200_ic_fsm_saved_addr_r   <=  or1200_ic_top_or1200_ic_fsm_start_addr  ; 
                      or1200_ic_top_or1200_ic_fsm_hitmiss_eval   <=1'b1; 
                      or1200_ic_top_or1200_ic_fsm_load   <=1'b1; 
                      or1200_ic_top_or1200_ic_fsm_cache_inhibit   <=  or1200_ic_top_or1200_ic_fsm_icqmem_ci_i  ; 
                      or1200_ic_top_or1200_ic_fsm_last_eval_miss   <=0;
                   end 
                 else 
                   begin  
                      or1200_ic_top_or1200_ic_fsm_hitmiss_eval   <=1'b0; 
                      or1200_ic_top_or1200_ic_fsm_load   <=1'b0; 
                      or1200_ic_top_or1200_ic_fsm_cache_inhibit   <=1'b0;
                   end 
             2 'd1:
                begin 
                  if (  or1200_ic_top_or1200_ic_fsm_icqmem_cycstb_i  &  or1200_ic_top_or1200_ic_fsm_icqmem_ci_i  ) 
                      or1200_ic_top_or1200_ic_fsm_cache_inhibit   <=1'b1;
                  if (  or1200_ic_top_or1200_ic_fsm_hitmiss_eval  ) 
                      or1200_ic_top_or1200_ic_fsm_saved_addr_r   [31:13-1+1]<=  or1200_ic_top_or1200_ic_fsm_start_addr  [31:13-1+1];
                  if ((!  or1200_ic_top_or1200_ic_fsm_ic_en  )||(  or1200_ic_top_or1200_ic_fsm_hitmiss_eval  &!  or1200_ic_top_or1200_ic_fsm_icqmem_cycstb_i  )||(  or1200_ic_top_or1200_ic_fsm_biudata_error  )||(  or1200_ic_top_or1200_ic_fsm_cache_inhibit  &  or1200_ic_top_or1200_ic_fsm_biudata_valid  ))
                     begin  
                        or1200_ic_top_or1200_ic_fsm_state   <=2'd0; 
                        or1200_ic_top_or1200_ic_fsm_hitmiss_eval   <=1'b0; 
                        or1200_ic_top_or1200_ic_fsm_load   <=1'b0; 
                        or1200_ic_top_or1200_ic_fsm_cache_inhibit   <=1'b0;
                     end 
                   else 
                     if (  or1200_ic_top_or1200_ic_fsm_tagcomp_miss  &  or1200_ic_top_or1200_ic_fsm_biudata_valid  )
                        begin  
                           or1200_ic_top_or1200_ic_fsm_state   <=2'd2; 
                           or1200_ic_top_or1200_ic_fsm_saved_addr_r   [4-1:2]<=  or1200_ic_top_or1200_ic_fsm_saved_addr_r  [4-1:2]+1; 
                           or1200_ic_top_or1200_ic_fsm_hitmiss_eval   <=1'b0; 
                           or1200_ic_top_or1200_ic_fsm_cnt   <=((1<<4)-(2*4)); 
                           or1200_ic_top_or1200_ic_fsm_cache_inhibit   <=1'b0;
                        end 
                      else 
                        if (!  or1200_ic_top_or1200_ic_fsm_icqmem_cycstb_i  &!  or1200_ic_top_or1200_ic_fsm_last_eval_miss  )
                           begin  
                              or1200_ic_top_or1200_ic_fsm_state   <=2'd0; 
                              or1200_ic_top_or1200_ic_fsm_hitmiss_eval   <=1'b0; 
                              or1200_ic_top_or1200_ic_fsm_load   <=1'b0; 
                              or1200_ic_top_or1200_ic_fsm_cache_inhibit   <=1'b0;
                           end 
                         else 
                           if (!  or1200_ic_top_or1200_ic_fsm_tagcomp_miss  &!  or1200_ic_top_or1200_ic_fsm_icqmem_ci_i  )
                              begin  
                                 or1200_ic_top_or1200_ic_fsm_saved_addr_r   <=  or1200_ic_top_or1200_ic_fsm_start_addr  ; 
                                 or1200_ic_top_or1200_ic_fsm_cache_inhibit   <=1'b0;
                              end 
                            else  
                               or1200_ic_top_or1200_ic_fsm_hitmiss_eval   <=1'b0;
                  if (  or1200_ic_top_or1200_ic_fsm_hitmiss_eval  &!  or1200_ic_top_or1200_ic_fsm_tagcomp_miss  ) 
                      or1200_ic_top_or1200_ic_fsm_last_eval_miss   <=1;
                end 
             2 'd2:
                begin 
                  if (!  or1200_ic_top_or1200_ic_fsm_ic_en  )
                     begin  
                        or1200_ic_top_or1200_ic_fsm_state   <=2'd0; 
                        or1200_ic_top_or1200_ic_fsm_saved_addr_r   <=  or1200_ic_top_or1200_ic_fsm_start_addr  ; 
                        or1200_ic_top_or1200_ic_fsm_hitmiss_eval   <=1'b0; 
                        or1200_ic_top_or1200_ic_fsm_load   <=1'b0;
                     end 
                   else 
                     if (  or1200_ic_top_or1200_ic_fsm_biudata_valid  &&(|  or1200_ic_top_or1200_ic_fsm_cnt  ))
                        begin  
                           or1200_ic_top_or1200_ic_fsm_cnt   <=  or1200_ic_top_or1200_ic_fsm_cnt  -4'd4; 
                           or1200_ic_top_or1200_ic_fsm_saved_addr_r   [4-1:2]<=  or1200_ic_top_or1200_ic_fsm_saved_addr_r  [4-1:2]+1;
                        end 
                      else 
                        if (  or1200_ic_top_or1200_ic_fsm_biudata_valid  )
                           begin  
                              or1200_ic_top_or1200_ic_fsm_state   <=2'd0; 
                              or1200_ic_top_or1200_ic_fsm_saved_addr_r   <=  or1200_ic_top_or1200_ic_fsm_start_addr  ; 
                              or1200_ic_top_or1200_ic_fsm_hitmiss_eval   <=1'b0; 
                              or1200_ic_top_or1200_ic_fsm_load   <=1'b0;
                           end 
                end 
             default : 
                 or1200_ic_top_or1200_ic_fsm_state   <=2'd0;
            endcase 
       end
 
assign or1200_ic_top_or1200_ic_fsm_clk = or1200_ic_top_clk;
assign or1200_ic_top_or1200_ic_fsm_rst = or1200_ic_top_rst;
assign or1200_ic_top_or1200_ic_fsm_ic_en = or1200_ic_top_ic_en;
assign or1200_ic_top_or1200_ic_fsm_icqmem_cycstb_i = or1200_ic_top_icqmem_cycstb_i;
assign or1200_ic_top_or1200_ic_fsm_icqmem_ci_i = or1200_ic_top_icqmem_ci_i;
assign or1200_ic_top_or1200_ic_fsm_tagcomp_miss = or1200_ic_top_tagcomp_miss;
assign or1200_ic_top_or1200_ic_fsm_biudata_valid = or1200_ic_top_icbiu_ack_i;
assign or1200_ic_top_or1200_ic_fsm_biudata_error = or1200_ic_top_icbiu_err_i;
assign or1200_ic_top_or1200_ic_fsm_start_addr = or1200_ic_top_icqmem_adr_i;
assign or1200_ic_top_saved_addr = or1200_ic_top_or1200_ic_fsm_saved_addr;
assign or1200_ic_top_icram_we = or1200_ic_top_or1200_ic_fsm_icram_we;
assign or1200_ic_top_icfsm_tag_we = or1200_ic_top_or1200_ic_fsm_tag_we;
assign or1200_ic_top_icfsm_biu_read = or1200_ic_top_or1200_ic_fsm_biu_read;
assign or1200_ic_top_icfsm_first_hit_ack = or1200_ic_top_or1200_ic_fsm_first_hit_ack;
assign or1200_ic_top_icfsm_first_miss_ack = or1200_ic_top_or1200_ic_fsm_first_miss_ack;
assign or1200_ic_top_icfsm_first_miss_err = or1200_ic_top_or1200_ic_fsm_first_miss_err;
assign or1200_ic_top_icfsm_burst = or1200_ic_top_or1200_ic_fsm_burst;
  
  
wire  or1200_ic_top_or1200_ic_ram_clk;
wire  or1200_ic_top_or1200_ic_ram_rst;
wire [ or1200_ic_top_or1200_ic_ram_aw -1:0] or1200_ic_top_or1200_ic_ram_addr;
wire  or1200_ic_top_or1200_ic_ram_en;
wire [3:0] or1200_ic_top_or1200_ic_ram_we;
wire [ or1200_ic_top_or1200_ic_ram_dw -1:0] or1200_ic_top_or1200_ic_ram_datain;
wire [ or1200_ic_top_or1200_ic_ram_dw -1:0] or1200_ic_top_or1200_ic_ram_dataout;
  
  
wire  or1200_ic_top_or1200_ic_ram_ic_ram0_clk;
wire  or1200_ic_top_or1200_ic_ram_ic_ram0_ce;
wire  or1200_ic_top_or1200_ic_ram_ic_ram0_we;
wire [ or1200_ic_top_or1200_ic_ram_ic_ram0_aw -1:0] or1200_ic_top_or1200_ic_ram_ic_ram0_addr;
wire [ or1200_ic_top_or1200_ic_ram_ic_ram0_dw -1:0] or1200_ic_top_or1200_ic_ram_ic_ram0_di;
wire [ or1200_ic_top_or1200_ic_ram_ic_ram0_dw -1:0] or1200_ic_top_or1200_ic_ram_ic_ram0_doq;
 
   reg[  or1200_ic_top_or1200_ic_ram_ic_ram0_dw  -1:0]  or1200_ic_top_or1200_ic_ram_ic_ram0_mem  [(1<<  or1200_ic_top_or1200_ic_ram_ic_ram0_aw  )-1:0]; 
   reg[  or1200_ic_top_or1200_ic_ram_ic_ram0_aw  -1:0]  or1200_ic_top_or1200_ic_ram_ic_ram0_addr_reg  ; 
  assign   or1200_ic_top_or1200_ic_ram_ic_ram0_doq  =  or1200_ic_top_or1200_ic_ram_ic_ram0_mem  [  or1200_ic_top_or1200_ic_ram_ic_ram0_addr_reg  ]; 
  always @( posedge   or1200_ic_top_or1200_ic_ram_ic_ram0_clk  )
       if (  or1200_ic_top_or1200_ic_ram_ic_ram0_ce  ) 
           or1200_ic_top_or1200_ic_ram_ic_ram0_addr_reg   <=  or1200_ic_top_or1200_ic_ram_ic_ram0_addr  ;
 
  always @( posedge   or1200_ic_top_or1200_ic_ram_ic_ram0_clk  )
       if (  or1200_ic_top_or1200_ic_ram_ic_ram0_we  &&  or1200_ic_top_or1200_ic_ram_ic_ram0_ce  ) 
           or1200_ic_top_or1200_ic_ram_ic_ram0_mem   [  or1200_ic_top_or1200_ic_ram_ic_ram0_addr  ]<=  or1200_ic_top_or1200_ic_ram_ic_ram0_di  ;

assign or1200_ic_top_or1200_ic_ram_ic_ram0_clk = or1200_ic_top_or1200_ic_ram_clk;
assign or1200_ic_top_or1200_ic_ram_ic_ram0_ce = or1200_ic_top_or1200_ic_ram_en;
assign or1200_ic_top_or1200_ic_ram_ic_ram0_we = or1200_ic_top_or1200_ic_ram_we[0];
assign or1200_ic_top_or1200_ic_ram_ic_ram0_addr = or1200_ic_top_or1200_ic_ram_addr;
assign or1200_ic_top_or1200_ic_ram_ic_ram0_di = or1200_ic_top_or1200_ic_ram_datain;
assign or1200_ic_top_or1200_ic_ram_dataout = or1200_ic_top_or1200_ic_ram_ic_ram0_doq;

assign or1200_ic_top_or1200_ic_ram_clk = or1200_ic_top_clk;
assign or1200_ic_top_or1200_ic_ram_rst = or1200_ic_top_rst;
assign or1200_ic_top_or1200_ic_ram_addr = or1200_ic_top_ic_addr[13-1:2];
assign or1200_ic_top_or1200_ic_ram_en = or1200_ic_top_ic_en;
assign or1200_ic_top_or1200_ic_ram_we = or1200_ic_top_icram_we;
assign or1200_ic_top_or1200_ic_ram_datain = or1200_ic_top_to_icram;
assign or1200_ic_top_from_icram = or1200_ic_top_or1200_ic_ram_dataout;
  
  
wire  or1200_ic_top_or1200_ic_tag_clk;
wire  or1200_ic_top_or1200_ic_tag_rst;
wire [ or1200_ic_top_or1200_ic_tag_aw -1:0] or1200_ic_top_or1200_ic_tag_addr;
wire  or1200_ic_top_or1200_ic_tag_en;
wire  or1200_ic_top_or1200_ic_tag_we;
wire [ or1200_ic_top_or1200_ic_tag_dw -1:0] or1200_ic_top_or1200_ic_tag_datain;
wire  or1200_ic_top_or1200_ic_tag_tag_v;
wire [ or1200_ic_top_or1200_ic_tag_dw -2:0] or1200_ic_top_or1200_ic_tag_tag;
  
  
wire  or1200_ic_top_or1200_ic_tag_ic_tag0_clk;
wire  or1200_ic_top_or1200_ic_tag_ic_tag0_ce;
wire  or1200_ic_top_or1200_ic_tag_ic_tag0_we;
wire [ or1200_ic_top_or1200_ic_tag_ic_tag0_aw -1:0] or1200_ic_top_or1200_ic_tag_ic_tag0_addr;
wire [ or1200_ic_top_or1200_ic_tag_ic_tag0_dw -1:0] or1200_ic_top_or1200_ic_tag_ic_tag0_di;
wire [ or1200_ic_top_or1200_ic_tag_ic_tag0_dw -1:0] or1200_ic_top_or1200_ic_tag_ic_tag0_doq;
 
   reg[  or1200_ic_top_or1200_ic_tag_ic_tag0_dw  -1:0]  or1200_ic_top_or1200_ic_tag_ic_tag0_mem  [(1<<  or1200_ic_top_or1200_ic_tag_ic_tag0_aw  )-1:0]; 
   reg[  or1200_ic_top_or1200_ic_tag_ic_tag0_aw  -1:0]  or1200_ic_top_or1200_ic_tag_ic_tag0_addr_reg  ; 
  assign   or1200_ic_top_or1200_ic_tag_ic_tag0_doq  =  or1200_ic_top_or1200_ic_tag_ic_tag0_mem  [  or1200_ic_top_or1200_ic_tag_ic_tag0_addr_reg  ]; 
  always @( posedge   or1200_ic_top_or1200_ic_tag_ic_tag0_clk  )
       if (  or1200_ic_top_or1200_ic_tag_ic_tag0_ce  ) 
           or1200_ic_top_or1200_ic_tag_ic_tag0_addr_reg   <=  or1200_ic_top_or1200_ic_tag_ic_tag0_addr  ;
 
  always @( posedge   or1200_ic_top_or1200_ic_tag_ic_tag0_clk  )
       if (  or1200_ic_top_or1200_ic_tag_ic_tag0_we  &&  or1200_ic_top_or1200_ic_tag_ic_tag0_ce  ) 
           or1200_ic_top_or1200_ic_tag_ic_tag0_mem   [  or1200_ic_top_or1200_ic_tag_ic_tag0_addr  ]<=  or1200_ic_top_or1200_ic_tag_ic_tag0_di  ;

assign or1200_ic_top_or1200_ic_tag_ic_tag0_clk = or1200_ic_top_or1200_ic_tag_clk;
assign or1200_ic_top_or1200_ic_tag_ic_tag0_ce = or1200_ic_top_or1200_ic_tag_en;
assign or1200_ic_top_or1200_ic_tag_ic_tag0_we = or1200_ic_top_or1200_ic_tag_we;
assign or1200_ic_top_or1200_ic_tag_ic_tag0_addr = or1200_ic_top_or1200_ic_tag_addr;
assign or1200_ic_top_or1200_ic_tag_ic_tag0_di = or1200_ic_top_or1200_ic_tag_datain;
assign {or1200_ic_top_or1200_ic_tag_tag,or1200_ic_top_or1200_ic_tag_tag_v} = or1200_ic_top_or1200_ic_tag_ic_tag0_doq;

assign or1200_ic_top_or1200_ic_tag_clk = or1200_ic_top_clk;
assign or1200_ic_top_or1200_ic_tag_rst = or1200_ic_top_rst;
assign or1200_ic_top_or1200_ic_tag_addr = or1200_ic_top_ictag_addr;
assign or1200_ic_top_or1200_ic_tag_en = or1200_ic_top_ictag_en;
assign or1200_ic_top_or1200_ic_tag_we = or1200_ic_top_ictag_we;
assign or1200_ic_top_or1200_ic_tag_datain = {or1200_ic_top_ic_addr[31:13-1+1],or1200_ic_top_ictag_v};
assign or1200_ic_top_tag_v = or1200_ic_top_or1200_ic_tag_tag_v;
assign or1200_ic_top_tag = or1200_ic_top_or1200_ic_tag_tag;

assign or1200_ic_top_clk = clk_i;
assign or1200_ic_top_rst = rst_i;
assign icbiu_dat_ic = or1200_ic_top_icbiu_dat_o;
assign icbiu_adr_ic = or1200_ic_top_icbiu_adr_o;
assign icbiu_cyc_ic = or1200_ic_top_icbiu_cyc_o;
assign icbiu_stb_ic = or1200_ic_top_icbiu_stb_o;
assign icbiu_we_ic = or1200_ic_top_icbiu_we_o;
assign icbiu_sel_ic = or1200_ic_top_icbiu_sel_o;
assign icbiu_cab_ic = or1200_ic_top_icbiu_cab_o;
assign or1200_ic_top_icbiu_dat_i = icbiu_dat_biu;
assign or1200_ic_top_icbiu_ack_i = icbiu_ack_biu;
assign or1200_ic_top_icbiu_err_i = icbiu_err_biu;
assign or1200_ic_top_ic_en = ic_en;
assign or1200_ic_top_icqmem_adr_i = icqmem_adr_qmem;
assign or1200_ic_top_icqmem_cycstb_i = icqmem_cycstb_qmem;
assign or1200_ic_top_icqmem_ci_i = icqmem_ci_qmem;
assign or1200_ic_top_icqmem_sel_i = icqmem_sel_qmem;
assign or1200_ic_top_icqmem_tag_i = icqmem_tag_qmem;
assign icqmem_dat_ic = or1200_ic_top_icqmem_dat_o;
assign icqmem_ack_ic = or1200_ic_top_icqmem_ack_o;
assign icqmem_rty_ic = or1200_ic_top_icqmem_rty_o;
assign icqmem_err_ic = or1200_ic_top_icqmem_err_o;
assign icqmem_tag_ic = or1200_ic_top_icqmem_tag_o;
assign or1200_ic_top_spr_cs = spr_cs[5'd04];
assign or1200_ic_top_spr_write = spr_we;
assign or1200_ic_top_spr_dat_i = spr_dat_cpu;
 
  
wire  or1200_cpu_clk;
wire  or1200_cpu_rst;
wire  or1200_cpu_ic_en;
wire [31:0] or1200_cpu_icpu_adr_o;
wire  or1200_cpu_icpu_cycstb_o;
wire [3:0] or1200_cpu_icpu_sel_o;
wire [3:0] or1200_cpu_icpu_tag_o;
wire [31:0] or1200_cpu_icpu_dat_i;
wire  or1200_cpu_icpu_ack_i;
wire  or1200_cpu_icpu_rty_i;
wire  or1200_cpu_icpu_err_i;
wire [31:0] or1200_cpu_icpu_adr_i;
wire [3:0] or1200_cpu_icpu_tag_i;
wire  or1200_cpu_immu_en;
wire  or1200_cpu_id_void;
wire [31:0] or1200_cpu_id_insn;
wire  or1200_cpu_ex_void;
wire [31:0] or1200_cpu_ex_insn;
wire  or1200_cpu_ex_freeze;
wire [31:0] or1200_cpu_wb_insn;
wire  or1200_cpu_wb_freeze;
wire [31:0] or1200_cpu_id_pc;
wire [31:0] or1200_cpu_ex_pc;
wire [31:0] or1200_cpu_wb_pc;
wire [3-1:0] or1200_cpu_branch_op;
wire [ or1200_cpu_dw -1:0] or1200_cpu_spr_dat_npc;
wire [ or1200_cpu_dw -1:0] or1200_cpu_rf_dataw;
wire  or1200_cpu_ex_flushpipe;
wire  or1200_cpu_du_stall;
wire [ or1200_cpu_dw -1:0] or1200_cpu_du_addr;
wire [ or1200_cpu_dw -1:0] or1200_cpu_du_dat_du;
wire  or1200_cpu_du_read;
wire  or1200_cpu_du_write;
wire [13:0] or1200_cpu_du_except_stop;
wire  or1200_cpu_du_flush_pipe;
wire [13:0] or1200_cpu_du_except_trig;
wire [14-1:0] or1200_cpu_du_dsr;
wire [24:0] or1200_cpu_du_dmr1;
wire  or1200_cpu_du_hwbkpt;
wire  or1200_cpu_du_hwbkpt_ls_r;
wire [ or1200_cpu_dw -1:0] or1200_cpu_du_dat_cpu;
wire [ or1200_cpu_dw -1:0] or1200_cpu_du_lsu_store_dat;
wire [ or1200_cpu_dw -1:0] or1200_cpu_du_lsu_load_dat;
wire  or1200_cpu_abort_mvspr;
wire  or1200_cpu_abort_ex;
wire  or1200_cpu_dc_en;
wire [31:0] or1200_cpu_dcpu_adr_o;
wire  or1200_cpu_dcpu_cycstb_o;
wire  or1200_cpu_dcpu_we_o;
wire [3:0] or1200_cpu_dcpu_sel_o;
wire [3:0] or1200_cpu_dcpu_tag_o;
wire [31:0] or1200_cpu_dcpu_dat_o;
wire [31:0] or1200_cpu_dcpu_dat_i;
wire  or1200_cpu_dcpu_ack_i;
wire  or1200_cpu_dcpu_rty_i;
wire  or1200_cpu_dcpu_err_i;
wire [3:0] or1200_cpu_dcpu_tag_i;
wire  or1200_cpu_sb_en;
wire  or1200_cpu_dmmu_en;
wire  or1200_cpu_dc_no_writethrough;
wire  or1200_cpu_boot_adr_sel_i;
wire  or1200_cpu_sig_int;
wire  or1200_cpu_sig_tick;
wire  or1200_cpu_supv;
wire [ or1200_cpu_dw -1:0] or1200_cpu_spr_addr;
wire [ or1200_cpu_dw -1:0] or1200_cpu_spr_dat_cpu;
wire [ or1200_cpu_dw -1:0] or1200_cpu_spr_dat_pic;
wire [ or1200_cpu_dw -1:0] or1200_cpu_spr_dat_tt;
wire [ or1200_cpu_dw -1:0] or1200_cpu_spr_dat_pm;
wire [ or1200_cpu_dw -1:0] or1200_cpu_spr_dat_dmmu;
wire [ or1200_cpu_dw -1:0] or1200_cpu_spr_dat_immu;
wire [ or1200_cpu_dw -1:0] or1200_cpu_spr_dat_du;
wire [31:0] or1200_cpu_spr_cs;
wire  or1200_cpu_spr_we;
wire  or1200_cpu_mtspr_dc_done;
 
   wire[31:0]  or1200_cpu_if_insn  ; 
   wire  or1200_cpu_saving_if_insn  ; 
   wire[31:0]  or1200_cpu_if_pc  ; 
   wire[  or1200_cpu_aw  -1:0]  or1200_cpu_rf_addrw  ; 
   wire[  or1200_cpu_aw  -1:0]  or1200_cpu_rf_addra  ; 
   wire[  or1200_cpu_aw  -1:0]  or1200_cpu_rf_addrb  ; 
   wire  or1200_cpu_rf_rda  ; 
   wire  or1200_cpu_rf_rdb  ; 
   wire[  or1200_cpu_dw  -1:0]  or1200_cpu_id_simm  ; 
   wire[  or1200_cpu_dw  -1:2]  or1200_cpu_id_branch_addrtarget  ; 
   wire[  or1200_cpu_dw  -1:2]  or1200_cpu_ex_branch_addrtarget  ; 
   wire[5-1:0]  or1200_cpu_alu_op  ; 
   wire[4-1:0]  or1200_cpu_alu_op2  ; 
   wire[4-1:0]  or1200_cpu_comp_op  ; 
   wire[3-1:0]  or1200_cpu_pre_branch_op  ; 
   wire[4-1:0]  or1200_cpu_id_lsu_op  ; 
   wire  or1200_cpu_genpc_freeze  ; 
   wire  or1200_cpu_if_freeze  ; 
   wire  or1200_cpu_id_freeze  ; 
   wire[2-1:0]  or1200_cpu_sel_a  ; 
   wire[2-1:0]  or1200_cpu_sel_b  ; 
   wire[4-1:0]  or1200_cpu_rfwb_op  ; 
   wire[8-1:0]  or1200_cpu_fpu_op  ; 
   wire[  or1200_cpu_dw  -1:0]  or1200_cpu_rf_dataa  ; 
   wire[  or1200_cpu_dw  -1:0]  or1200_cpu_rf_datab  ; 
   wire[  or1200_cpu_dw  -1:0]  or1200_cpu_muxed_a  ; 
   wire[  or1200_cpu_dw  -1:0]  or1200_cpu_muxed_b  ; 
   wire[  or1200_cpu_dw  -1:0]  or1200_cpu_wb_forw  ; 
   wire  or1200_cpu_wbforw_valid  ; 
   wire[  or1200_cpu_dw  -1:0]  or1200_cpu_operand_a  ; 
   wire[  or1200_cpu_dw  -1:0]  or1200_cpu_operand_b  ; 
   wire[  or1200_cpu_dw  -1:0]  or1200_cpu_alu_dataout  ; 
   wire[  or1200_cpu_dw  -1:0]  or1200_cpu_lsu_dataout  ; 
   wire[  or1200_cpu_dw  -1:0]  or1200_cpu_sprs_dataout  ; 
   wire[  or1200_cpu_dw  -1:0]  or1200_cpu_fpu_dataout  ; 
   wire  or1200_cpu_fpu_done  ; 
   wire[31:0]  or1200_cpu_ex_simm  ; 
   wire[3-1:0]  or1200_cpu_multicycle  ; 
   wire[2-1:0]  or1200_cpu_wait_on  ; 
   wire[4-1:0]  or1200_cpu_except_type  ; 
   wire[4:0]  or1200_cpu_cust5_op  ; 
   wire[5:0]  or1200_cpu_cust5_limm  ; 
   wire  or1200_cpu_if_flushpipe  ; 
   wire  or1200_cpu_id_flushpipe  ; 
   wire  or1200_cpu_wb_flushpipe  ; 
   wire  or1200_cpu_extend_flush  ; 
   wire  or1200_cpu_ex_branch_taken  ; 
   wire  or1200_cpu_flag  ; 
   wire  or1200_cpu_flagforw  ; 
   wire  or1200_cpu_flag_we  ; 
   wire  or1200_cpu_flagforw_alu  ; 
   wire  or1200_cpu_flag_we_alu  ; 
   wire  or1200_cpu_flagforw_fpu  ; 
   wire  or1200_cpu_flag_we_fpu  ; 
   wire  or1200_cpu_carry  ; 
   wire  or1200_cpu_cyforw  ; 
   wire  or1200_cpu_cy_we_alu  ; 
   wire  or1200_cpu_ovforw  ; 
   wire  or1200_cpu_ov_we_alu  ; 
   wire  or1200_cpu_ovforw_mult_mac  ; 
   wire  or1200_cpu_ov_we_mult_mac  ; 
   wire  or1200_cpu_cy_we_rf  ; 
   wire  or1200_cpu_lsu_stall  ; 
   wire  or1200_cpu_epcr_we  ; 
   wire  or1200_cpu_eear_we  ; 
   wire  or1200_cpu_esr_we  ; 
   wire  or1200_cpu_pc_we  ; 
   wire[31:0]  or1200_cpu_epcr  ; 
   wire[31:0]  or1200_cpu_eear  ; 
   wire[17-1:0]  or1200_cpu_esr  ; 
   wire[12-1:0]  or1200_cpu_fpcsr  ; 
   wire  or1200_cpu_fpcsr_we  ; 
   wire  or1200_cpu_sr_we  ; 
   wire[17-1:0]  or1200_cpu_to_sr  ; 
   wire[17-1:0]  or1200_cpu_sr  ; 
   wire  or1200_cpu_dsx  ; 
   wire  or1200_cpu_except_flushpipe  ; 
   wire  or1200_cpu_except_start  ; 
   wire  or1200_cpu_except_started  ; 
   wire  or1200_cpu_fpu_except_started  ; 
   wire  or1200_cpu_sig_syscall  ; 
   wire  or1200_cpu_sig_trap  ; 
   wire  or1200_cpu_sig_range  ; 
   wire  or1200_cpu_sig_fp  ; 
   wire[31:0]  or1200_cpu_spr_dat_cfgr  ; 
   wire[31:0]  or1200_cpu_spr_dat_rf  ; 
   wire[31:0]  or1200_cpu_spr_dat_ppc  ; 
   wire[31:0]  or1200_cpu_spr_dat_mac  ; 
   wire[31:0]  or1200_cpu_spr_dat_fpu  ; 
   wire  or1200_cpu_mtspr_done  ; 
   wire  or1200_cpu_force_dslot_fetch  ; 
   wire  or1200_cpu_no_more_dslot  ; 
   wire  or1200_cpu_ex_spr_read  ; 
   wire  or1200_cpu_ex_spr_write  ; 
   wire  or1200_cpu_if_stall  ; 
   wire  or1200_cpu_id_macrc_op  ; 
   wire  or1200_cpu_ex_macrc_op  ; 
   wire[3-1:0]  or1200_cpu_id_mac_op  ; 
   wire[3-1:0]  or1200_cpu_mac_op  ; 
   wire[31:0]  or1200_cpu_mult_mac_result  ; 
   wire  or1200_cpu_mult_mac_stall  ; 
   wire[13:0]  or1200_cpu_except_trig  ; 
   wire[13:0]  or1200_cpu_except_stop  ; 
   wire  or1200_cpu_genpc_refetch  ; 
   wire  or1200_cpu_rfe  ; 
   wire  or1200_cpu_lsu_unstall  ; 
   wire  or1200_cpu_except_align  ; 
   wire  or1200_cpu_except_dtlbmiss  ; 
   wire  or1200_cpu_except_dmmufault  ; 
   wire  or1200_cpu_except_illegal  ; 
   wire  or1200_cpu_except_itlbmiss  ; 
   wire  or1200_cpu_except_immufault  ; 
   wire  or1200_cpu_except_ibuserr  ; 
   wire  or1200_cpu_except_dbuserr  ; 
  assign   or1200_cpu_du_except_trig  =  or1200_cpu_except_trig  ; 
  assign   or1200_cpu_du_except_stop  =  or1200_cpu_except_stop  ; 
  assign   or1200_cpu_du_lsu_store_dat  =  or1200_cpu_operand_b  ; 
  assign   or1200_cpu_du_lsu_load_dat  =  or1200_cpu_lsu_dataout  ; 
  assign   or1200_cpu_dc_en  =  or1200_cpu_sr  [3]; 
  assign   or1200_cpu_ic_en  =  or1200_cpu_sr  [4]; 
  assign   or1200_cpu_sb_en  =1'b0; 
  assign   or1200_cpu_dmmu_en  =  or1200_cpu_sr  [5]; 
  assign   or1200_cpu_immu_en  =  or1200_cpu_sr  [6]&~  or1200_cpu_except_started  ; 
  assign   or1200_cpu_supv  =  or1200_cpu_sr  [0]; 
  assign   or1200_cpu_flagforw  =(  or1200_cpu_flag_we_alu  &  or1200_cpu_flagforw_alu  )|(  or1200_cpu_flagforw_fpu  &  or1200_cpu_flag_we_fpu  ); 
  assign   or1200_cpu_flag_we  =(  or1200_cpu_flag_we_alu  |  or1200_cpu_flag_we_fpu  )&~  or1200_cpu_abort_mvspr  ; 
  assign   or1200_cpu_mtspr_done  =  or1200_cpu_mtspr_dc_done  ; 
  assign   or1200_cpu_sig_range  =  or1200_cpu_sr  [11];  
  
wire  or1200_cpu_or1200_genpc_clk;
wire  or1200_cpu_or1200_genpc_rst;
wire [31:0] or1200_cpu_or1200_genpc_icpu_adr_o;
wire  or1200_cpu_or1200_genpc_icpu_cycstb_o;
wire [3:0] or1200_cpu_or1200_genpc_icpu_sel_o;
wire [3:0] or1200_cpu_or1200_genpc_icpu_tag_o;
wire  or1200_cpu_or1200_genpc_icpu_rty_i;
wire [31:0] or1200_cpu_or1200_genpc_icpu_adr_i;
wire [3-1:0] or1200_cpu_or1200_genpc_pre_branch_op;
wire [3-1:0] or1200_cpu_or1200_genpc_branch_op;
wire [4-1:0] or1200_cpu_or1200_genpc_except_type;
wire  or1200_cpu_or1200_genpc_except_prefix;
wire [31:2] or1200_cpu_or1200_genpc_id_branch_addrtarget;
wire [31:2] or1200_cpu_or1200_genpc_ex_branch_addrtarget;
wire [31:0] or1200_cpu_or1200_genpc_muxed_b;
wire [31:0] or1200_cpu_or1200_genpc_operand_b;
wire  or1200_cpu_or1200_genpc_flag;
wire  or1200_cpu_or1200_genpc_flagforw;
reg  or1200_cpu_or1200_genpc_ex_branch_taken;
wire  or1200_cpu_or1200_genpc_except_start;
wire [31:0] or1200_cpu_or1200_genpc_epcr;
wire [31:0] or1200_cpu_or1200_genpc_spr_dat_i;
wire  or1200_cpu_or1200_genpc_spr_pc_we;
wire  or1200_cpu_or1200_genpc_genpc_refetch;
wire  or1200_cpu_or1200_genpc_genpc_freeze;
wire  or1200_cpu_or1200_genpc_no_more_dslot;
wire  or1200_cpu_or1200_genpc_lsu_stall;
wire  or1200_cpu_or1200_genpc_du_flush_pipe;
wire [31:0] or1200_cpu_or1200_genpc_spr_dat_npc;
 
   reg[31:2]  or1200_cpu_or1200_genpc_pcreg_default  ; 
   reg  or1200_cpu_or1200_genpc_pcreg_select  ; 
   reg[31:2]  or1200_cpu_or1200_genpc_pcreg  ; 
   reg[31:0]  or1200_cpu_or1200_genpc_pc  ; 
   reg  or1200_cpu_or1200_genpc_genpc_refetch_r  ; 
   reg  or1200_cpu_or1200_genpc_wait_lsu  ; 
  assign   or1200_cpu_or1200_genpc_icpu_adr_o  =!  or1200_cpu_or1200_genpc_no_more_dslot  &!  or1200_cpu_or1200_genpc_except_start  &!  or1200_cpu_or1200_genpc_spr_pc_we  &!  or1200_cpu_or1200_genpc_du_flush_pipe  &(  or1200_cpu_or1200_genpc_icpu_rty_i  |  or1200_cpu_or1200_genpc_genpc_refetch  )?  or1200_cpu_or1200_genpc_icpu_adr_i  :{  or1200_cpu_or1200_genpc_pc  [31:2],1'b0,  or1200_cpu_or1200_genpc_ex_branch_taken  |  or1200_cpu_or1200_genpc_spr_pc_we  }; 
  assign   or1200_cpu_or1200_genpc_icpu_cycstb_o  =~(  or1200_cpu_or1200_genpc_genpc_freeze  |(|  or1200_cpu_or1200_genpc_pre_branch_op  &&!  or1200_cpu_or1200_genpc_icpu_rty_i  )|  or1200_cpu_or1200_genpc_wait_lsu  ); 
  assign   or1200_cpu_or1200_genpc_icpu_sel_o  =4'b1111; 
  assign   or1200_cpu_or1200_genpc_icpu_tag_o  =4'h1; 
  always @(  posedge    or1200_cpu_or1200_genpc_clk          or  posedge   or1200_cpu_or1200_genpc_rst  )
       if (  or1200_cpu_or1200_genpc_rst  ==(1'b1)) 
           or1200_cpu_or1200_genpc_wait_lsu   <=1'b0;
        else 
          if (!  or1200_cpu_or1200_genpc_wait_lsu  &|  or1200_cpu_or1200_genpc_pre_branch_op  &  or1200_cpu_or1200_genpc_lsu_stall  ) 
              or1200_cpu_or1200_genpc_wait_lsu   <=1'b1;
           else 
             if (  or1200_cpu_or1200_genpc_wait_lsu  &~|  or1200_cpu_or1200_genpc_pre_branch_op  ) 
                 or1200_cpu_or1200_genpc_wait_lsu   <=1'b0;
 
  always @(  posedge    or1200_cpu_or1200_genpc_clk          or  posedge   or1200_cpu_or1200_genpc_rst  )
       if (  or1200_cpu_or1200_genpc_rst  ==(1'b1)) 
           or1200_cpu_or1200_genpc_genpc_refetch_r   <=1'b0;
        else 
          if (  or1200_cpu_or1200_genpc_genpc_refetch  ) 
              or1200_cpu_or1200_genpc_genpc_refetch_r   <=1'b1;
           else  
              or1200_cpu_or1200_genpc_genpc_refetch_r   <=1'b0;
 
  always @(              or1200_cpu_or1200_genpc_pcreg                                or    or1200_cpu_or1200_genpc_ex_branch_addrtarget                    or    or1200_cpu_or1200_genpc_flag                   or    or1200_cpu_or1200_genpc_branch_op                  or    or1200_cpu_or1200_genpc_except_type                 or    or1200_cpu_or1200_genpc_except_start                or    or1200_cpu_or1200_genpc_operand_b               or    or1200_cpu_or1200_genpc_epcr              or    or1200_cpu_or1200_genpc_spr_pc_we             or    or1200_cpu_or1200_genpc_spr_dat_i            or    or1200_cpu_or1200_genpc_except_prefix           or    or1200_cpu_or1200_genpc_du_flush_pipe   )
       begin 
         casez ({  or1200_cpu_or1200_genpc_du_flush_pipe  ,  or1200_cpu_or1200_genpc_spr_pc_we  ,  or1200_cpu_or1200_genpc_except_start  ,  or1200_cpu_or1200_genpc_branch_op  })
          { 3'b000,3'd0}:
             begin  
                or1200_cpu_or1200_genpc_pc   ={  or1200_cpu_or1200_genpc_pcreg  +30'd1,2'b0}; 
                or1200_cpu_or1200_genpc_ex_branch_taken   =1'b0;
             end 
          { 3'b000,3'd1}:
             begin  
                or1200_cpu_or1200_genpc_pc   ={  or1200_cpu_or1200_genpc_ex_branch_addrtarget  ,2'b00}; 
                or1200_cpu_or1200_genpc_ex_branch_taken   =1'b1;
             end 
          { 3'b000,3'd2}:
             begin  
                or1200_cpu_or1200_genpc_pc   =  or1200_cpu_or1200_genpc_operand_b  ; 
                or1200_cpu_or1200_genpc_ex_branch_taken   =1'b1;
             end 
          { 3'b000,3'd4}:
             if (  or1200_cpu_or1200_genpc_flag  )
                begin  
                   or1200_cpu_or1200_genpc_pc   ={  or1200_cpu_or1200_genpc_ex_branch_addrtarget  ,2'b00}; 
                   or1200_cpu_or1200_genpc_ex_branch_taken   =1'b1;
                end 
              else 
                begin  
                   or1200_cpu_or1200_genpc_pc   ={  or1200_cpu_or1200_genpc_pcreg  +30'd1,2'b0}; 
                   or1200_cpu_or1200_genpc_ex_branch_taken   =1'b0;
                end 
          { 3'b000,3'd5}:
             if (  or1200_cpu_or1200_genpc_flag  )
                begin  
                   or1200_cpu_or1200_genpc_pc   ={  or1200_cpu_or1200_genpc_pcreg  +30'd1,2'b0}; 
                   or1200_cpu_or1200_genpc_ex_branch_taken   =1'b0;
                end 
              else 
                begin  
                   or1200_cpu_or1200_genpc_pc   ={  or1200_cpu_or1200_genpc_ex_branch_addrtarget  ,2'b00}; 
                   or1200_cpu_or1200_genpc_ex_branch_taken   =1'b1;
                end 
          { 3'b000,3'd6}:
             begin  
                or1200_cpu_or1200_genpc_pc   =  or1200_cpu_or1200_genpc_epcr  ; 
                or1200_cpu_or1200_genpc_ex_branch_taken   =1'b1;
             end 
          { 3'b100,3'b???}:
             begin  
                or1200_cpu_or1200_genpc_pc   =  or1200_cpu_or1200_genpc_spr_dat_npc  ; 
                or1200_cpu_or1200_genpc_ex_branch_taken   =1'b1;
             end 
          { 3'b001,3'b???}:
             begin  
                or1200_cpu_or1200_genpc_pc   ={(  or1200_cpu_or1200_genpc_except_prefix  ?20'hF0000:20'h00000),  or1200_cpu_or1200_genpc_except_type  ,8'h00}; 
                or1200_cpu_or1200_genpc_ex_branch_taken   =1'b1;
             end 
          default :
             begin  
                or1200_cpu_or1200_genpc_pc   =  or1200_cpu_or1200_genpc_spr_dat_i  ; 
                or1200_cpu_or1200_genpc_ex_branch_taken   =1'b0;
             end 
         endcase 
       end
  
   wire[31:0]  or1200_cpu_or1200_genpc_pcreg_boot  =  or1200_cpu_or1200_genpc_boot_adr  ; 
  always @(  posedge    or1200_cpu_or1200_genpc_clk          or  posedge   or1200_cpu_or1200_genpc_rst  )
       if (  or1200_cpu_or1200_genpc_rst  ==(1'b1))
          begin  
             or1200_cpu_or1200_genpc_pcreg_default   <=(  or1200_cpu_or1200_genpc_boot_adr  >>2)-4; 
             or1200_cpu_or1200_genpc_pcreg_select   <=1'b1;
          end 
        else 
          if (  or1200_cpu_or1200_genpc_pcreg_select  )
             begin  
                or1200_cpu_or1200_genpc_pcreg_default   <=  or1200_cpu_or1200_genpc_pcreg_boot  [31:2]; 
                or1200_cpu_or1200_genpc_pcreg_select   <=1'b0;
             end 
           else 
             if (  or1200_cpu_or1200_genpc_spr_pc_we  )
                begin  
                   or1200_cpu_or1200_genpc_pcreg_default   <=  or1200_cpu_or1200_genpc_spr_dat_i  [31:2];
                end 
              else 
                if (  or1200_cpu_or1200_genpc_du_flush_pipe  |  or1200_cpu_or1200_genpc_no_more_dslot  |  or1200_cpu_or1200_genpc_except_start  |!  or1200_cpu_or1200_genpc_genpc_freeze  &!  or1200_cpu_or1200_genpc_icpu_rty_i  &!  or1200_cpu_or1200_genpc_genpc_refetch  )
                   begin  
                      or1200_cpu_or1200_genpc_pcreg_default   <=  or1200_cpu_or1200_genpc_pc  [31:2];
                   end
  
  always @(     or1200_cpu_or1200_genpc_pcreg_boot              or    or1200_cpu_or1200_genpc_pcreg_default           or    or1200_cpu_or1200_genpc_pcreg_select   )
       if (  or1200_cpu_or1200_genpc_pcreg_select  ) 
           or1200_cpu_or1200_genpc_pcreg   =  or1200_cpu_or1200_genpc_pcreg_boot  [31:2];
        else  
           or1200_cpu_or1200_genpc_pcreg   =  or1200_cpu_or1200_genpc_pcreg_default  ;

assign or1200_cpu_or1200_genpc_clk = or1200_cpu_clk;
assign or1200_cpu_or1200_genpc_rst = or1200_cpu_rst;
assign or1200_cpu_icpu_adr_o = or1200_cpu_or1200_genpc_icpu_adr_o;
assign or1200_cpu_icpu_cycstb_o = or1200_cpu_or1200_genpc_icpu_cycstb_o;
assign or1200_cpu_icpu_sel_o = or1200_cpu_or1200_genpc_icpu_sel_o;
assign or1200_cpu_icpu_tag_o = or1200_cpu_or1200_genpc_icpu_tag_o;
assign or1200_cpu_or1200_genpc_icpu_rty_i = or1200_cpu_icpu_rty_i;
assign or1200_cpu_or1200_genpc_icpu_adr_i = or1200_cpu_icpu_adr_i;
assign or1200_cpu_or1200_genpc_pre_branch_op = or1200_cpu_pre_branch_op;
assign or1200_cpu_or1200_genpc_branch_op = or1200_cpu_branch_op;
assign or1200_cpu_or1200_genpc_except_type = or1200_cpu_except_type;
assign or1200_cpu_or1200_genpc_except_prefix = or1200_cpu_sr[14];
assign or1200_cpu_or1200_genpc_id_branch_addrtarget = or1200_cpu_id_branch_addrtarget;
assign or1200_cpu_or1200_genpc_ex_branch_addrtarget = or1200_cpu_ex_branch_addrtarget;
assign or1200_cpu_or1200_genpc_muxed_b = or1200_cpu_muxed_b;
assign or1200_cpu_or1200_genpc_operand_b = or1200_cpu_operand_b;
assign or1200_cpu_or1200_genpc_flag = or1200_cpu_flag;
assign or1200_cpu_or1200_genpc_flagforw = or1200_cpu_flagforw;
assign or1200_cpu_ex_branch_taken = or1200_cpu_or1200_genpc_ex_branch_taken;
assign or1200_cpu_or1200_genpc_except_start = or1200_cpu_except_start;
assign or1200_cpu_or1200_genpc_epcr = or1200_cpu_epcr;
assign or1200_cpu_or1200_genpc_spr_dat_i = or1200_cpu_spr_dat_cpu;
assign or1200_cpu_or1200_genpc_spr_pc_we = or1200_cpu_pc_we;
assign or1200_cpu_or1200_genpc_genpc_refetch = or1200_cpu_genpc_refetch;
assign or1200_cpu_or1200_genpc_genpc_freeze = or1200_cpu_genpc_freeze;
assign or1200_cpu_or1200_genpc_no_more_dslot = or1200_cpu_no_more_dslot;
assign or1200_cpu_or1200_genpc_lsu_stall = or1200_cpu_lsu_stall;
assign or1200_cpu_or1200_genpc_du_flush_pipe = or1200_cpu_du_flush_pipe;
assign or1200_cpu_or1200_genpc_spr_dat_npc = or1200_cpu_spr_dat_npc;
  
  
wire  or1200_cpu_or1200_if_clk;
wire  or1200_cpu_or1200_if_rst;
wire [31:0] or1200_cpu_or1200_if_icpu_dat_i;
wire  or1200_cpu_or1200_if_icpu_ack_i;
wire  or1200_cpu_or1200_if_icpu_err_i;
wire [31:0] or1200_cpu_or1200_if_icpu_adr_i;
wire [3:0] or1200_cpu_or1200_if_icpu_tag_i;
wire  or1200_cpu_or1200_if_if_freeze;
wire [31:0] or1200_cpu_or1200_if_if_insn;
wire [31:0] or1200_cpu_or1200_if_if_pc;
wire  or1200_cpu_or1200_if_if_flushpipe;
wire  or1200_cpu_or1200_if_saving_if_insn;
wire  or1200_cpu_or1200_if_if_stall;
wire  or1200_cpu_or1200_if_no_more_dslot;
wire  or1200_cpu_or1200_if_genpc_refetch;
wire  or1200_cpu_or1200_if_rfe;
wire  or1200_cpu_or1200_if_except_itlbmiss;
wire  or1200_cpu_or1200_if_except_immufault;
wire  or1200_cpu_or1200_if_except_ibuserr;
 
   wire  or1200_cpu_or1200_if_save_insn  ; 
   wire  or1200_cpu_or1200_if_if_bypass  ; 
   reg  or1200_cpu_or1200_if_if_bypass_reg  ; 
   reg[31:0]  or1200_cpu_or1200_if_insn_saved  ; 
   reg[31:0]  or1200_cpu_or1200_if_addr_saved  ; 
   reg[2:0]  or1200_cpu_or1200_if_err_saved  ; 
   reg  or1200_cpu_or1200_if_saved  ; 
  assign   or1200_cpu_or1200_if_save_insn  =(  or1200_cpu_or1200_if_icpu_ack_i  |  or1200_cpu_or1200_if_icpu_err_i  )&  or1200_cpu_or1200_if_if_freeze  &!  or1200_cpu_or1200_if_saved  ; 
  assign   or1200_cpu_or1200_if_saving_if_insn  =!  or1200_cpu_or1200_if_if_flushpipe  &  or1200_cpu_or1200_if_save_insn  ; 
  assign   or1200_cpu_or1200_if_if_bypass  =  or1200_cpu_or1200_if_icpu_adr_i  [0]?1'b0:  or1200_cpu_or1200_if_if_bypass_reg  |  or1200_cpu_or1200_if_if_flushpipe  ; 
  always @(  posedge    or1200_cpu_or1200_if_clk          or  posedge   or1200_cpu_or1200_if_rst  )
       if (  or1200_cpu_or1200_if_rst  ==(1'b1)) 
           or1200_cpu_or1200_if_if_bypass_reg   <=1'b0;
        else  
           or1200_cpu_or1200_if_if_bypass_reg   <=  or1200_cpu_or1200_if_if_bypass  ;
 
  assign   or1200_cpu_or1200_if_if_insn  =  or1200_cpu_or1200_if_no_more_dslot  |  or1200_cpu_or1200_if_rfe  |  or1200_cpu_or1200_if_if_bypass  ?{6'b000101,26'h041_0000}:  or1200_cpu_or1200_if_saved  ?  or1200_cpu_or1200_if_insn_saved  :  or1200_cpu_or1200_if_icpu_ack_i  ?  or1200_cpu_or1200_if_icpu_dat_i  :{6'b000101,26'h061_0000}; 
  assign   or1200_cpu_or1200_if_if_pc  =  or1200_cpu_or1200_if_saved  ?  or1200_cpu_or1200_if_addr_saved  :{  or1200_cpu_or1200_if_icpu_adr_i  [31:2],2'h0}; 
  assign   or1200_cpu_or1200_if_if_stall  =!  or1200_cpu_or1200_if_icpu_err_i  &!  or1200_cpu_or1200_if_icpu_ack_i  &!  or1200_cpu_or1200_if_saved  ; 
  assign   or1200_cpu_or1200_if_genpc_refetch  =  or1200_cpu_or1200_if_saved  &  or1200_cpu_or1200_if_icpu_ack_i  ; 
  assign   or1200_cpu_or1200_if_except_itlbmiss  =  or1200_cpu_or1200_if_no_more_dslot  ?1'b0:  or1200_cpu_or1200_if_saved  ?  or1200_cpu_or1200_if_err_saved  [0]:  or1200_cpu_or1200_if_icpu_err_i  &(  or1200_cpu_or1200_if_icpu_tag_i  ==4'hd); 
  assign   or1200_cpu_or1200_if_except_immufault  =  or1200_cpu_or1200_if_no_more_dslot  ?1'b0:  or1200_cpu_or1200_if_saved  ?  or1200_cpu_or1200_if_err_saved  [1]:  or1200_cpu_or1200_if_icpu_err_i  &(  or1200_cpu_or1200_if_icpu_tag_i  ==4'hc); 
  assign   or1200_cpu_or1200_if_except_ibuserr  =  or1200_cpu_or1200_if_no_more_dslot  ?1'b0:  or1200_cpu_or1200_if_saved  ?  or1200_cpu_or1200_if_err_saved  [2]:  or1200_cpu_or1200_if_icpu_err_i  &(  or1200_cpu_or1200_if_icpu_tag_i  ==4'hb); 
  always @(  posedge    or1200_cpu_or1200_if_clk          or  posedge   or1200_cpu_or1200_if_rst  )
       if (  or1200_cpu_or1200_if_rst  ==(1'b1)) 
           or1200_cpu_or1200_if_saved   <=1'b0;
        else 
          if (  or1200_cpu_or1200_if_if_flushpipe  ) 
              or1200_cpu_or1200_if_saved   <=1'b0;
           else 
             if (  or1200_cpu_or1200_if_save_insn  ) 
                 or1200_cpu_or1200_if_saved   <=1'b1;
              else 
                if (!  or1200_cpu_or1200_if_if_freeze  ) 
                    or1200_cpu_or1200_if_saved   <=1'b0;
 
  always @(  posedge    or1200_cpu_or1200_if_clk          or  posedge   or1200_cpu_or1200_if_rst  )
       if (  or1200_cpu_or1200_if_rst  ==(1'b1)) 
           or1200_cpu_or1200_if_insn_saved   <={6'b000101,26'h041_0000};
        else 
          if (  or1200_cpu_or1200_if_if_flushpipe  ) 
              or1200_cpu_or1200_if_insn_saved   <={6'b000101,26'h041_0000};
           else 
             if (  or1200_cpu_or1200_if_save_insn  ) 
                 or1200_cpu_or1200_if_insn_saved   <=  or1200_cpu_or1200_if_icpu_err_i  ?{6'b000101,26'h041_0000}:  or1200_cpu_or1200_if_icpu_dat_i  ;
              else 
                if (!  or1200_cpu_or1200_if_if_freeze  ) 
                    or1200_cpu_or1200_if_insn_saved   <={6'b000101,26'h041_0000};
 
  always @(  posedge    or1200_cpu_or1200_if_clk          or  posedge   or1200_cpu_or1200_if_rst  )
       if (  or1200_cpu_or1200_if_rst  ==(1'b1)) 
           or1200_cpu_or1200_if_addr_saved   <=32'h00000000;
        else 
          if (  or1200_cpu_or1200_if_if_flushpipe  ) 
              or1200_cpu_or1200_if_addr_saved   <=32'h00000000;
           else 
             if (  or1200_cpu_or1200_if_save_insn  ) 
                 or1200_cpu_or1200_if_addr_saved   <={  or1200_cpu_or1200_if_icpu_adr_i  [31:2],2'b00};
              else 
                if (!  or1200_cpu_or1200_if_if_freeze  ) 
                    or1200_cpu_or1200_if_addr_saved   <={  or1200_cpu_or1200_if_icpu_adr_i  [31:2],2'b00};
 
  always @(  posedge    or1200_cpu_or1200_if_clk          or  posedge   or1200_cpu_or1200_if_rst  )
       if (  or1200_cpu_or1200_if_rst  ==(1'b1)) 
           or1200_cpu_or1200_if_err_saved   <=3'b000;
        else 
          if (  or1200_cpu_or1200_if_if_flushpipe  ) 
              or1200_cpu_or1200_if_err_saved   <=3'b000;
           else 
             if (  or1200_cpu_or1200_if_save_insn  )
                begin  
                   or1200_cpu_or1200_if_err_saved   [0]<=  or1200_cpu_or1200_if_icpu_err_i  &(  or1200_cpu_or1200_if_icpu_tag_i  ==4'hd); 
                   or1200_cpu_or1200_if_err_saved   [1]<=  or1200_cpu_or1200_if_icpu_err_i  &(  or1200_cpu_or1200_if_icpu_tag_i  ==4'hc); 
                   or1200_cpu_or1200_if_err_saved   [2]<=  or1200_cpu_or1200_if_icpu_err_i  &(  or1200_cpu_or1200_if_icpu_tag_i  ==4'hb);
                end 
              else 
                if (!  or1200_cpu_or1200_if_if_freeze  ) 
                    or1200_cpu_or1200_if_err_saved   <=3'b000;

assign or1200_cpu_or1200_if_clk = or1200_cpu_clk;
assign or1200_cpu_or1200_if_rst = or1200_cpu_rst;
assign or1200_cpu_or1200_if_icpu_dat_i = or1200_cpu_icpu_dat_i;
assign or1200_cpu_or1200_if_icpu_ack_i = or1200_cpu_icpu_ack_i;
assign or1200_cpu_or1200_if_icpu_err_i = or1200_cpu_icpu_err_i;
assign or1200_cpu_or1200_if_icpu_adr_i = or1200_cpu_icpu_adr_i;
assign or1200_cpu_or1200_if_icpu_tag_i = or1200_cpu_icpu_tag_i;
assign or1200_cpu_or1200_if_if_freeze = or1200_cpu_if_freeze;
assign or1200_cpu_if_insn = or1200_cpu_or1200_if_if_insn;
assign or1200_cpu_if_pc = or1200_cpu_or1200_if_if_pc;
assign or1200_cpu_or1200_if_if_flushpipe = or1200_cpu_if_flushpipe;
assign or1200_cpu_saving_if_insn = or1200_cpu_or1200_if_saving_if_insn;
assign or1200_cpu_if_stall = or1200_cpu_or1200_if_if_stall;
assign or1200_cpu_or1200_if_no_more_dslot = or1200_cpu_no_more_dslot;
assign or1200_cpu_genpc_refetch = or1200_cpu_or1200_if_genpc_refetch;
assign or1200_cpu_or1200_if_rfe = or1200_cpu_rfe;
assign or1200_cpu_except_itlbmiss = or1200_cpu_or1200_if_except_itlbmiss;
assign or1200_cpu_except_immufault = or1200_cpu_or1200_if_except_immufault;
assign or1200_cpu_except_ibuserr = or1200_cpu_or1200_if_except_ibuserr;
  
  
wire  or1200_cpu_or1200_ctrl_clk;
wire  or1200_cpu_or1200_ctrl_rst;
wire  or1200_cpu_or1200_ctrl_except_flushpipe;
wire  or1200_cpu_or1200_ctrl_extend_flush;
wire  or1200_cpu_or1200_ctrl_if_flushpipe;
wire  or1200_cpu_or1200_ctrl_id_flushpipe;
wire  or1200_cpu_or1200_ctrl_ex_flushpipe;
wire  or1200_cpu_or1200_ctrl_wb_flushpipe;
wire  or1200_cpu_or1200_ctrl_id_freeze;
wire  or1200_cpu_or1200_ctrl_ex_freeze;
wire  or1200_cpu_or1200_ctrl_wb_freeze;
wire [31:0] or1200_cpu_or1200_ctrl_if_insn;
reg [31:0] or1200_cpu_or1200_ctrl_id_insn;
reg [31:0] or1200_cpu_or1200_ctrl_ex_insn;
wire  or1200_cpu_or1200_ctrl_abort_mvspr;
reg [3-1:0] or1200_cpu_or1200_ctrl_id_branch_op;
reg [3-1:0] or1200_cpu_or1200_ctrl_ex_branch_op;
wire  or1200_cpu_or1200_ctrl_ex_branch_taken;
wire  or1200_cpu_or1200_ctrl_pc_we;
wire [5-1:0] or1200_cpu_or1200_ctrl_rf_addra;
wire [5-1:0] or1200_cpu_or1200_ctrl_rf_addrb;
wire  or1200_cpu_or1200_ctrl_rf_rda;
wire  or1200_cpu_or1200_ctrl_rf_rdb;
reg [5-1:0] or1200_cpu_or1200_ctrl_alu_op;
reg [4-1:0] or1200_cpu_or1200_ctrl_alu_op2;
wire [3-1:0] or1200_cpu_or1200_ctrl_mac_op;
reg [4-1:0] or1200_cpu_or1200_ctrl_comp_op;
reg [5-1:0] or1200_cpu_or1200_ctrl_rf_addrw;
reg [4-1:0] or1200_cpu_or1200_ctrl_rfwb_op;
wire [8-1:0] or1200_cpu_or1200_ctrl_fpu_op;
reg [31:0] or1200_cpu_or1200_ctrl_wb_insn;
reg [31:0] or1200_cpu_or1200_ctrl_id_simm;
reg [31:0] or1200_cpu_or1200_ctrl_ex_simm;
wire [31:2] or1200_cpu_or1200_ctrl_id_branch_addrtarget;
reg [31:2] or1200_cpu_or1200_ctrl_ex_branch_addrtarget;
reg [2-1:0] or1200_cpu_or1200_ctrl_sel_a;
reg [2-1:0] or1200_cpu_or1200_ctrl_sel_b;
reg [4-1:0] or1200_cpu_or1200_ctrl_id_lsu_op;
wire [4:0] or1200_cpu_or1200_ctrl_cust5_op;
wire [5:0] or1200_cpu_or1200_ctrl_cust5_limm;
wire [31:0] or1200_cpu_or1200_ctrl_id_pc;
wire [31:0] or1200_cpu_or1200_ctrl_ex_pc;
wire  or1200_cpu_or1200_ctrl_du_hwbkpt;
reg [3-1:0] or1200_cpu_or1200_ctrl_multicycle;
reg [2-1:0] or1200_cpu_or1200_ctrl_wait_on;
wire  or1200_cpu_or1200_ctrl_wbforw_valid;
reg  or1200_cpu_or1200_ctrl_sig_syscall;
reg  or1200_cpu_or1200_ctrl_sig_trap;
wire  or1200_cpu_or1200_ctrl_force_dslot_fetch;
wire  or1200_cpu_or1200_ctrl_no_more_dslot;
wire  or1200_cpu_or1200_ctrl_id_void;
wire  or1200_cpu_or1200_ctrl_ex_void;
wire  or1200_cpu_or1200_ctrl_ex_spr_read;
wire  or1200_cpu_or1200_ctrl_ex_spr_write;
wire  or1200_cpu_or1200_ctrl_du_flush_pipe;
wire [3-1:0] or1200_cpu_or1200_ctrl_id_mac_op;
wire  or1200_cpu_or1200_ctrl_id_macrc_op;
wire  or1200_cpu_or1200_ctrl_ex_macrc_op;
wire  or1200_cpu_or1200_ctrl_rfe;
reg  or1200_cpu_or1200_ctrl_except_illegal;
wire  or1200_cpu_or1200_ctrl_dc_no_writethrough;
 
   wire  or1200_cpu_or1200_ctrl_if_maci_op  ; 
   reg[5-1:0]  or1200_cpu_or1200_ctrl_wb_rfaddrw  ; 
   reg  or1200_cpu_or1200_ctrl_sel_imm  ; 
   wire  or1200_cpu_or1200_ctrl_wb_void  ; 
   reg  or1200_cpu_or1200_ctrl_ex_delayslot_dsi  ; 
   reg  or1200_cpu_or1200_ctrl_ex_delayslot_nop  ; 
   reg  or1200_cpu_or1200_ctrl_spr_read  ; 
   reg  or1200_cpu_or1200_ctrl_spr_write  ; 
  assign   or1200_cpu_or1200_ctrl_rf_addra  =  or1200_cpu_or1200_ctrl_if_insn  [20:16]; 
  assign   or1200_cpu_or1200_ctrl_rf_addrb  =  or1200_cpu_or1200_ctrl_if_insn  [15:11]; 
  assign   or1200_cpu_or1200_ctrl_rf_rda  =  or1200_cpu_or1200_ctrl_if_insn  [31]||  or1200_cpu_or1200_ctrl_if_maci_op  ; 
  assign   or1200_cpu_or1200_ctrl_rf_rdb  =  or1200_cpu_or1200_ctrl_if_insn  [30]; 
  assign   or1200_cpu_or1200_ctrl_force_dslot_fetch  =1'b0; 
  assign   or1200_cpu_or1200_ctrl_no_more_dslot  =(|  or1200_cpu_or1200_ctrl_ex_branch_op  &!  or1200_cpu_or1200_ctrl_id_void  &  or1200_cpu_or1200_ctrl_ex_branch_taken  )|(  or1200_cpu_or1200_ctrl_ex_branch_op  ==3'd6); 
  assign   or1200_cpu_or1200_ctrl_id_void  =(  or1200_cpu_or1200_ctrl_id_insn  [31:26]==6'b000101)&  or1200_cpu_or1200_ctrl_id_insn  [16]; 
  assign   or1200_cpu_or1200_ctrl_ex_void  =(  or1200_cpu_or1200_ctrl_ex_insn  [31:26]==6'b000101)&  or1200_cpu_or1200_ctrl_ex_insn  [16]; 
  assign   or1200_cpu_or1200_ctrl_wb_void  =(  or1200_cpu_or1200_ctrl_wb_insn  [31:26]==6'b000101)&  or1200_cpu_or1200_ctrl_wb_insn  [16]; 
  assign   or1200_cpu_or1200_ctrl_ex_spr_write  =  or1200_cpu_or1200_ctrl_spr_write  &&!  or1200_cpu_or1200_ctrl_abort_mvspr  ; 
  assign   or1200_cpu_or1200_ctrl_ex_spr_read  =  or1200_cpu_or1200_ctrl_spr_read  &&!  or1200_cpu_or1200_ctrl_abort_mvspr  ; 
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1))
            begin  
               or1200_cpu_or1200_ctrl_ex_delayslot_nop   <=1'b0; 
               or1200_cpu_or1200_ctrl_ex_delayslot_dsi   <=1'b0;
            end 
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  &!  or1200_cpu_or1200_ctrl_ex_delayslot_dsi  &  or1200_cpu_or1200_ctrl_ex_delayslot_nop  )
               begin  
                  or1200_cpu_or1200_ctrl_ex_delayslot_nop   <=  or1200_cpu_or1200_ctrl_id_void  ; 
                  or1200_cpu_or1200_ctrl_ex_delayslot_dsi   <=!  or1200_cpu_or1200_ctrl_id_void  ;
               end 
             else 
               if (!  or1200_cpu_or1200_ctrl_ex_freeze  &  or1200_cpu_or1200_ctrl_ex_delayslot_dsi  &!  or1200_cpu_or1200_ctrl_ex_delayslot_nop  )
                  begin  
                     or1200_cpu_or1200_ctrl_ex_delayslot_nop   <=1'b0; 
                     or1200_cpu_or1200_ctrl_ex_delayslot_dsi   <=1'b0;
                  end 
                else 
                  if (!  or1200_cpu_or1200_ctrl_ex_freeze  )
                     begin  
                        or1200_cpu_or1200_ctrl_ex_delayslot_nop   <=  or1200_cpu_or1200_ctrl_id_void  &&  or1200_cpu_or1200_ctrl_ex_branch_taken  &&(  or1200_cpu_or1200_ctrl_ex_branch_op  !=3'd0)&&(  or1200_cpu_or1200_ctrl_ex_branch_op  !=3'd6); 
                        or1200_cpu_or1200_ctrl_ex_delayslot_dsi   <=!  or1200_cpu_or1200_ctrl_id_void  &&  or1200_cpu_or1200_ctrl_ex_branch_taken  &&(  or1200_cpu_or1200_ctrl_ex_branch_op  !=3'd0)&&(  or1200_cpu_or1200_ctrl_ex_branch_op  !=3'd6);
                     end 
       end
  
  assign   or1200_cpu_or1200_ctrl_if_flushpipe  =  or1200_cpu_or1200_ctrl_except_flushpipe  |  or1200_cpu_or1200_ctrl_pc_we  |  or1200_cpu_or1200_ctrl_extend_flush  |  or1200_cpu_or1200_ctrl_du_flush_pipe  ; 
  assign   or1200_cpu_or1200_ctrl_id_flushpipe  =  or1200_cpu_or1200_ctrl_except_flushpipe  |  or1200_cpu_or1200_ctrl_pc_we  |  or1200_cpu_or1200_ctrl_extend_flush  |  or1200_cpu_or1200_ctrl_du_flush_pipe  ; 
  assign   or1200_cpu_or1200_ctrl_ex_flushpipe  =  or1200_cpu_or1200_ctrl_except_flushpipe  |  or1200_cpu_or1200_ctrl_pc_we  |  or1200_cpu_or1200_ctrl_extend_flush  |  or1200_cpu_or1200_ctrl_du_flush_pipe  ; 
  assign   or1200_cpu_or1200_ctrl_wb_flushpipe  =  or1200_cpu_or1200_ctrl_except_flushpipe  |  or1200_cpu_or1200_ctrl_pc_we  |  or1200_cpu_or1200_ctrl_extend_flush  |  or1200_cpu_or1200_ctrl_du_flush_pipe  ; 
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_ex_simm   <=32'h0000_0000;
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  )
               begin  
                  or1200_cpu_or1200_ctrl_ex_simm   <=  or1200_cpu_or1200_ctrl_id_simm  ;
               end 
       end
  
  always @(   or1200_cpu_or1200_ctrl_id_insn   )
       begin 
         case (  or1200_cpu_or1200_ctrl_id_insn  [31:26])
          6 'b100111: 
              or1200_cpu_or1200_ctrl_id_simm   ={{16{  or1200_cpu_or1200_ctrl_id_insn  [15]}},  or1200_cpu_or1200_ctrl_id_insn  [15:0]};
          6 'b101000: 
              or1200_cpu_or1200_ctrl_id_simm   ={{16{  or1200_cpu_or1200_ctrl_id_insn  [15]}},  or1200_cpu_or1200_ctrl_id_insn  [15:0]};
          6 'b100001,6'b100010,6'b100011,6'b100100,6'b100101,6'b100110: 
              or1200_cpu_or1200_ctrl_id_simm   ={{16{  or1200_cpu_or1200_ctrl_id_insn  [15]}},  or1200_cpu_or1200_ctrl_id_insn  [15:0]};
          6 'b101100: 
              or1200_cpu_or1200_ctrl_id_simm   ={{16{  or1200_cpu_or1200_ctrl_id_insn  [15]}},  or1200_cpu_or1200_ctrl_id_insn  [15:0]};
          6 'b110000: 
              or1200_cpu_or1200_ctrl_id_simm   ={16'b0,  or1200_cpu_or1200_ctrl_id_insn  [25:21],  or1200_cpu_or1200_ctrl_id_insn  [10:0]};
          6 'b110101,6'b110111,6'b110110: 
              or1200_cpu_or1200_ctrl_id_simm   ={{16{  or1200_cpu_or1200_ctrl_id_insn  [25]}},  or1200_cpu_or1200_ctrl_id_insn  [25:21],  or1200_cpu_or1200_ctrl_id_insn  [10:0]};
          6 'b101011: 
              or1200_cpu_or1200_ctrl_id_simm   ={{16{  or1200_cpu_or1200_ctrl_id_insn  [15]}},  or1200_cpu_or1200_ctrl_id_insn  [15:0]};
          6 'b101111: 
              or1200_cpu_or1200_ctrl_id_simm   ={{16{  or1200_cpu_or1200_ctrl_id_insn  [15]}},  or1200_cpu_or1200_ctrl_id_insn  [15:0]};
          default : 
              or1200_cpu_or1200_ctrl_id_simm   ={{16'b0},  or1200_cpu_or1200_ctrl_id_insn  [15:0]};
         endcase 
       end
  
  assign   or1200_cpu_or1200_ctrl_id_branch_addrtarget  ={{4{  or1200_cpu_or1200_ctrl_id_insn  [25]}},  or1200_cpu_or1200_ctrl_id_insn  [25:0]}+  or1200_cpu_or1200_ctrl_id_pc  [31:2]; 
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_ex_branch_addrtarget   <=0;
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  ) 
                or1200_cpu_or1200_ctrl_ex_branch_addrtarget   <=  or1200_cpu_or1200_ctrl_id_branch_addrtarget  ;
       end
  
  assign   or1200_cpu_or1200_ctrl_if_maci_op  =1'b0; 
  assign   or1200_cpu_or1200_ctrl_id_macrc_op  =1'b0; 
  assign   or1200_cpu_or1200_ctrl_ex_macrc_op  =1'b0; 
  assign   or1200_cpu_or1200_ctrl_cust5_op  =  or1200_cpu_or1200_ctrl_ex_insn  [4:0]; 
  assign   or1200_cpu_or1200_ctrl_cust5_limm  =  or1200_cpu_or1200_ctrl_ex_insn  [10:5]; 
  assign   or1200_cpu_or1200_ctrl_rfe  =(  or1200_cpu_or1200_ctrl_id_branch_op  ==3'd6)|(  or1200_cpu_or1200_ctrl_ex_branch_op  ==3'd6); 
  always @(       or1200_cpu_or1200_ctrl_rf_addrw                  or    or1200_cpu_or1200_ctrl_id_insn             or    or1200_cpu_or1200_ctrl_rfwb_op            or    or1200_cpu_or1200_ctrl_wbforw_valid           or    or1200_cpu_or1200_ctrl_wb_rfaddrw   )
       if ((  or1200_cpu_or1200_ctrl_id_insn  [20:16]==  or1200_cpu_or1200_ctrl_rf_addrw  )&&  or1200_cpu_or1200_ctrl_rfwb_op  [0]) 
           or1200_cpu_or1200_ctrl_sel_a   =2'd2;
        else 
          if ((  or1200_cpu_or1200_ctrl_id_insn  [20:16]==  or1200_cpu_or1200_ctrl_wb_rfaddrw  )&&  or1200_cpu_or1200_ctrl_wbforw_valid  ) 
              or1200_cpu_or1200_ctrl_sel_a   =2'd3;
           else  
              or1200_cpu_or1200_ctrl_sel_a   =2'd0;
 
  always @(        or1200_cpu_or1200_ctrl_rf_addrw                    or    or1200_cpu_or1200_ctrl_sel_imm              or    or1200_cpu_or1200_ctrl_id_insn             or    or1200_cpu_or1200_ctrl_rfwb_op            or    or1200_cpu_or1200_ctrl_wbforw_valid           or    or1200_cpu_or1200_ctrl_wb_rfaddrw   )
       if (  or1200_cpu_or1200_ctrl_sel_imm  ) 
           or1200_cpu_or1200_ctrl_sel_b   =2'd1;
        else 
          if ((  or1200_cpu_or1200_ctrl_id_insn  [15:11]==  or1200_cpu_or1200_ctrl_rf_addrw  )&&  or1200_cpu_or1200_ctrl_rfwb_op  [0]) 
              or1200_cpu_or1200_ctrl_sel_b   =2'd2;
           else 
             if ((  or1200_cpu_or1200_ctrl_id_insn  [15:11]==  or1200_cpu_or1200_ctrl_wb_rfaddrw  )&&  or1200_cpu_or1200_ctrl_wbforw_valid  ) 
                 or1200_cpu_or1200_ctrl_sel_b   =2'd3;
              else  
                 or1200_cpu_or1200_ctrl_sel_b   =2'd0;
 
  always @(   or1200_cpu_or1200_ctrl_id_insn   )
       begin 
         case (  or1200_cpu_or1200_ctrl_id_insn  [31:26])
          6 'b001001,6'b101101: 
              or1200_cpu_or1200_ctrl_multicycle   =3'd1;
          default :
             begin  
                or1200_cpu_or1200_ctrl_multicycle   =3'd0;
             end 
         endcase 
       end
  
  always @(   or1200_cpu_or1200_ctrl_id_insn   )
       begin 
         case (  or1200_cpu_or1200_ctrl_id_insn  [31:26])
          6 'b111000: 
              or1200_cpu_or1200_ctrl_wait_on   =(1'b0|(  or1200_cpu_or1200_ctrl_id_insn  [4:0]==5'b0_1001)|(  or1200_cpu_or1200_ctrl_id_insn  [4:0]==5'b0_1010)|(  or1200_cpu_or1200_ctrl_id_insn  [4:0]==5'b0_0110)|(  or1200_cpu_or1200_ctrl_id_insn  [4:0]==5'b0_1011))?2'd1:2'd0;
          6 'b101100: 
              or1200_cpu_or1200_ctrl_wait_on   =2'd1;
          6 'b110000:
             begin  
                or1200_cpu_or1200_ctrl_wait_on   =2'd3;
             end 
          default :
             begin  
                or1200_cpu_or1200_ctrl_wait_on   =2'd0;
             end 
         endcase 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_rf_addrw   <=5'd0;
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  &  or1200_cpu_or1200_ctrl_id_freeze  ) 
                or1200_cpu_or1200_ctrl_rf_addrw   <=5'd00;
             else 
               if (!  or1200_cpu_or1200_ctrl_ex_freeze  )
                  case (  or1200_cpu_or1200_ctrl_id_insn  [31:26])
                   6 'b000001,6'b010010: 
                       or1200_cpu_or1200_ctrl_rf_addrw   <=5'd09;
                   default : 
                       or1200_cpu_or1200_ctrl_rf_addrw   <=  or1200_cpu_or1200_ctrl_id_insn  [25:21];
                  endcase 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_wb_rfaddrw   <=5'd0;
          else 
            if (!  or1200_cpu_or1200_ctrl_wb_freeze  ) 
                or1200_cpu_or1200_ctrl_wb_rfaddrw   <=  or1200_cpu_or1200_ctrl_rf_addrw  ;
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_id_insn   <={6'b000101,26'h041_0000};
          else 
            if (  or1200_cpu_or1200_ctrl_id_flushpipe  ) 
                or1200_cpu_or1200_ctrl_id_insn   <={6'b000101,26'h041_0000};
             else 
               if (!  or1200_cpu_or1200_ctrl_id_freeze  )
                  begin  
                     or1200_cpu_or1200_ctrl_id_insn   <=  or1200_cpu_or1200_ctrl_if_insn  ;
                  end 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_ex_insn   <={6'b000101,26'h041_0000};
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  &  or1200_cpu_or1200_ctrl_id_freeze  |  or1200_cpu_or1200_ctrl_ex_flushpipe  ) 
                or1200_cpu_or1200_ctrl_ex_insn   <={6'b000101,26'h041_0000};
             else 
               if (!  or1200_cpu_or1200_ctrl_ex_freeze  )
                  begin  
                     or1200_cpu_or1200_ctrl_ex_insn   <=  or1200_cpu_or1200_ctrl_id_insn  ;
                  end 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_wb_insn   <={6'b000101,26'h041_0000};
          else 
            if (!  or1200_cpu_or1200_ctrl_wb_freeze  )
               begin  
                  or1200_cpu_or1200_ctrl_wb_insn   <=  or1200_cpu_or1200_ctrl_ex_insn  ;
               end 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
          else 
            if (!  or1200_cpu_or1200_ctrl_id_freeze  )
               begin 
                 case (  or1200_cpu_or1200_ctrl_if_insn  [31:26])
                  6 'b010010: 
                      or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
                  6 'b010001: 
                      or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
                  6 'b001001: 
                      or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
                  6 'b101101: 
                      or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
                  6 'b110000: 
                      or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
                  6 'b001000: 
                      or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
                  6 'b110101: 
                      or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
                  6 'b110110: 
                      or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
                  6 'b110111: 
                      or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
                  6 'b111000: 
                      or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
                  6 'b111001: 
                      or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
                  6 'b000101: 
                      or1200_cpu_or1200_ctrl_sel_imm   <=1'b0;
                  default :
                     begin  
                        or1200_cpu_or1200_ctrl_sel_imm   <=1'b1;
                     end 
                 endcase 
               end 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_except_illegal   <=1'b0;
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  &  or1200_cpu_or1200_ctrl_id_freeze  |  or1200_cpu_or1200_ctrl_ex_flushpipe  ) 
                or1200_cpu_or1200_ctrl_except_illegal   <=1'b0;
             else 
               if (!  or1200_cpu_or1200_ctrl_ex_freeze  )
                  begin 
                    case (  or1200_cpu_or1200_ctrl_id_insn  [31:26])
                     6 'b000000,6'b000001,6'b010010,6'b010001,6'b000011,6'b000100,6'b001001,6'b000110,6'b101101,6'b001000,6'b100001,6'b100010,6'b100011,6'b100100,6'b100101,6'b100110,6'b100111,6'b101000,6'b101001,6'b101010,6'b101011,6'b101100,6'b101111,6'b110000,6'b110101,6'b110110,6'b110111,6'b111001,6'b000101: 
                         or1200_cpu_or1200_ctrl_except_illegal   <=1'b0;
                     6 'b111000: 
                         or1200_cpu_or1200_ctrl_except_illegal   <=1'b0|((  or1200_cpu_or1200_ctrl_id_insn  [4:0]==5'b0_1000)&(  or1200_cpu_or1200_ctrl_id_insn  [9:6]==4'd3));
                     default : 
                         or1200_cpu_or1200_ctrl_except_illegal   <=1'b1;
                    endcase 
                  end 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_alu_op   <=5'b0_0100;
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  &  or1200_cpu_or1200_ctrl_id_freeze  |  or1200_cpu_or1200_ctrl_ex_flushpipe  ) 
                or1200_cpu_or1200_ctrl_alu_op   <=5'b0_0100;
             else 
               if (!  or1200_cpu_or1200_ctrl_ex_freeze  )
                  begin 
                    case (  or1200_cpu_or1200_ctrl_id_insn  [31:26])
                     6 'b000110: 
                         or1200_cpu_or1200_ctrl_alu_op   <=5'b1_0001;
                     6 'b100111: 
                         or1200_cpu_or1200_ctrl_alu_op   <=5'b0_0000;
                     6 'b101000: 
                         or1200_cpu_or1200_ctrl_alu_op   <=5'b0_0001;
                     6 'b101001: 
                         or1200_cpu_or1200_ctrl_alu_op   <=5'b0_0011;
                     6 'b101010: 
                         or1200_cpu_or1200_ctrl_alu_op   <=5'b0_0100;
                     6 'b101011: 
                         or1200_cpu_or1200_ctrl_alu_op   <=5'b0_0101;
                     6 'b101100: 
                         or1200_cpu_or1200_ctrl_alu_op   <=5'b0_0110;
                     6 'b101111: 
                         or1200_cpu_or1200_ctrl_alu_op   <=5'b1_0000;
                     6 'b111000: 
                         or1200_cpu_or1200_ctrl_alu_op   <={1'b0,  or1200_cpu_or1200_ctrl_id_insn  [3:0]};
                     6 'b111001: 
                         or1200_cpu_or1200_ctrl_alu_op   <=5'b1_0000;
                     default :
                        begin  
                           or1200_cpu_or1200_ctrl_alu_op   <=5'b0_0100;
                        end 
                    endcase 
                  end 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_alu_op2   <=0;
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  &  or1200_cpu_or1200_ctrl_id_freeze  |  or1200_cpu_or1200_ctrl_ex_flushpipe  ) 
                or1200_cpu_or1200_ctrl_alu_op2   <=0;
             else 
               if (!  or1200_cpu_or1200_ctrl_ex_freeze  )
                  begin  
                     or1200_cpu_or1200_ctrl_alu_op2   <=  or1200_cpu_or1200_ctrl_id_insn  [9:6];
                  end 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1))
            begin  
               or1200_cpu_or1200_ctrl_spr_read   <=1'b0; 
               or1200_cpu_or1200_ctrl_spr_write   <=1'b0;
            end 
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  &  or1200_cpu_or1200_ctrl_id_freeze  |  or1200_cpu_or1200_ctrl_ex_flushpipe  )
               begin  
                  or1200_cpu_or1200_ctrl_spr_read   <=1'b0; 
                  or1200_cpu_or1200_ctrl_spr_write   <=1'b0;
               end 
             else 
               if (!  or1200_cpu_or1200_ctrl_ex_freeze  )
                  begin 
                    case (  or1200_cpu_or1200_ctrl_id_insn  [31:26])
                     6 'b101101:
                        begin  
                           or1200_cpu_or1200_ctrl_spr_read   <=1'b1; 
                           or1200_cpu_or1200_ctrl_spr_write   <=1'b0;
                        end 
                     6 'b110000:
                        begin  
                           or1200_cpu_or1200_ctrl_spr_read   <=1'b0; 
                           or1200_cpu_or1200_ctrl_spr_write   <=1'b1;
                        end 
                     default :
                        begin  
                           or1200_cpu_or1200_ctrl_spr_read   <=1'b0; 
                           or1200_cpu_or1200_ctrl_spr_write   <=1'b0;
                        end 
                    endcase 
                  end 
       end
  
  assign   or1200_cpu_or1200_ctrl_id_mac_op  =3'b000; 
  assign   or1200_cpu_or1200_ctrl_mac_op  =3'b000; 
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_rfwb_op   <=4'b0000;
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  &  or1200_cpu_or1200_ctrl_id_freeze  |  or1200_cpu_or1200_ctrl_ex_flushpipe  ) 
                or1200_cpu_or1200_ctrl_rfwb_op   <=4'b0000;
             else 
               if (!  or1200_cpu_or1200_ctrl_ex_freeze  )
                  begin 
                    case (  or1200_cpu_or1200_ctrl_id_insn  [31:26])
                     6 'b000001: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b011,1'b1};
                     6 'b010010: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b011,1'b1};
                     6 'b000110: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b000,1'b1};
                     6 'b101101: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b010,1'b1};
                     6 'b100001: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b001,1'b1};
                     6 'b100010: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b001,1'b1};
                     6 'b100011: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b001,1'b1};
                     6 'b100100: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b001,1'b1};
                     6 'b100101: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b001,1'b1};
                     6 'b100110: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b001,1'b1};
                     6 'b100111: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b000,1'b1};
                     6 'b101000: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b000,1'b1};
                     6 'b101001: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b000,1'b1};
                     6 'b101010: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b000,1'b1};
                     6 'b101011: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b000,1'b1};
                     6 'b101100: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b000,1'b1};
                     6 'b111000: 
                         or1200_cpu_or1200_ctrl_rfwb_op   <={3'b000,1'b1};
                     default : 
                         or1200_cpu_or1200_ctrl_rfwb_op   <=4'b0000;
                    endcase 
                  end 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_id_branch_op   <=3'd0;
          else 
            if (  or1200_cpu_or1200_ctrl_id_flushpipe  ) 
                or1200_cpu_or1200_ctrl_id_branch_op   <=3'd0;
             else 
               if (!  or1200_cpu_or1200_ctrl_id_freeze  )
                  begin 
                    case (  or1200_cpu_or1200_ctrl_if_insn  [31:26])
                     6 'b000000: 
                         or1200_cpu_or1200_ctrl_id_branch_op   <=3'd1;
                     6 'b000001: 
                         or1200_cpu_or1200_ctrl_id_branch_op   <=3'd1;
                     6 'b010010: 
                         or1200_cpu_or1200_ctrl_id_branch_op   <=3'd2;
                     6 'b010001: 
                         or1200_cpu_or1200_ctrl_id_branch_op   <=3'd2;
                     6 'b000011: 
                         or1200_cpu_or1200_ctrl_id_branch_op   <=3'd5;
                     6 'b000100: 
                         or1200_cpu_or1200_ctrl_id_branch_op   <=3'd4;
                     6 'b001001: 
                         or1200_cpu_or1200_ctrl_id_branch_op   <=3'd6;
                     default : 
                         or1200_cpu_or1200_ctrl_id_branch_op   <=3'd0;
                    endcase 
                  end 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
           or1200_cpu_or1200_ctrl_ex_branch_op   <=3'd0;
        else 
          if (!  or1200_cpu_or1200_ctrl_ex_freeze  &  or1200_cpu_or1200_ctrl_id_freeze  |  or1200_cpu_or1200_ctrl_ex_flushpipe  ) 
              or1200_cpu_or1200_ctrl_ex_branch_op   <=3'd0;
           else 
             if (!  or1200_cpu_or1200_ctrl_ex_freeze  ) 
                 or1200_cpu_or1200_ctrl_ex_branch_op   <=  or1200_cpu_or1200_ctrl_id_branch_op  ;
 
  always @(   or1200_cpu_or1200_ctrl_id_insn   )
       begin 
         case (  or1200_cpu_or1200_ctrl_id_insn  [31:26])
          6 'b100001: 
              or1200_cpu_or1200_ctrl_id_lsu_op   =4'b0110;
          6 'b100010: 
              or1200_cpu_or1200_ctrl_id_lsu_op   =4'b0111;
          6 'b100011: 
              or1200_cpu_or1200_ctrl_id_lsu_op   =4'b0010;
          6 'b100100: 
              or1200_cpu_or1200_ctrl_id_lsu_op   =4'b0011;
          6 'b100101: 
              or1200_cpu_or1200_ctrl_id_lsu_op   =4'b0100;
          6 'b100110: 
              or1200_cpu_or1200_ctrl_id_lsu_op   =4'b0101;
          6 'b110101: 
              or1200_cpu_or1200_ctrl_id_lsu_op   =4'b1110;
          6 'b110110: 
              or1200_cpu_or1200_ctrl_id_lsu_op   =4'b1010;
          6 'b110111: 
              or1200_cpu_or1200_ctrl_id_lsu_op   =4'b1100;
          default : 
              or1200_cpu_or1200_ctrl_id_lsu_op   =4'b0000;
         endcase 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1))
            begin  
               or1200_cpu_or1200_ctrl_comp_op   <=4'd0;
            end 
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  &  or1200_cpu_or1200_ctrl_id_freeze  |  or1200_cpu_or1200_ctrl_ex_flushpipe  ) 
                or1200_cpu_or1200_ctrl_comp_op   <=4'd0;
             else 
               if (!  or1200_cpu_or1200_ctrl_ex_freeze  ) 
                   or1200_cpu_or1200_ctrl_comp_op   <=  or1200_cpu_or1200_ctrl_id_insn  [24:21];
       end
  
  assign   or1200_cpu_or1200_ctrl_fpu_op  ={8{1'b0}}; 
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_sig_syscall   <=1'b0;
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  &  or1200_cpu_or1200_ctrl_id_freeze  |  or1200_cpu_or1200_ctrl_ex_flushpipe  ) 
                or1200_cpu_or1200_ctrl_sig_syscall   <=1'b0;
             else 
               if (!  or1200_cpu_or1200_ctrl_ex_freeze  )
                  begin  
                     or1200_cpu_or1200_ctrl_sig_syscall   <=(  or1200_cpu_or1200_ctrl_id_insn  [31:23]=={6'b001000,3'b000});
                  end 
       end
  
  always @(  posedge    or1200_cpu_or1200_ctrl_clk          or  posedge   or1200_cpu_or1200_ctrl_rst  )
       begin 
         if (  or1200_cpu_or1200_ctrl_rst  ==(1'b1)) 
             or1200_cpu_or1200_ctrl_sig_trap   <=1'b0;
          else 
            if (!  or1200_cpu_or1200_ctrl_ex_freeze  &  or1200_cpu_or1200_ctrl_id_freeze  |  or1200_cpu_or1200_ctrl_ex_flushpipe  ) 
                or1200_cpu_or1200_ctrl_sig_trap   <=1'b0;
             else 
               if (!  or1200_cpu_or1200_ctrl_ex_freeze  )
                  begin  
                     or1200_cpu_or1200_ctrl_sig_trap   <=(  or1200_cpu_or1200_ctrl_id_insn  [31:23]=={6'b001000,3'b010})|  or1200_cpu_or1200_ctrl_du_hwbkpt  ;
                  end 
       end
  
  assign   or1200_cpu_or1200_ctrl_dc_no_writethrough  =0;
assign or1200_cpu_or1200_ctrl_clk = or1200_cpu_clk;
assign or1200_cpu_or1200_ctrl_rst = or1200_cpu_rst;
assign or1200_cpu_or1200_ctrl_except_flushpipe = or1200_cpu_except_flushpipe;
assign or1200_cpu_or1200_ctrl_extend_flush = or1200_cpu_extend_flush;
assign or1200_cpu_if_flushpipe = or1200_cpu_or1200_ctrl_if_flushpipe;
assign or1200_cpu_id_flushpipe = or1200_cpu_or1200_ctrl_id_flushpipe;
assign or1200_cpu_ex_flushpipe = or1200_cpu_or1200_ctrl_ex_flushpipe;
assign or1200_cpu_wb_flushpipe = or1200_cpu_or1200_ctrl_wb_flushpipe;
assign or1200_cpu_or1200_ctrl_id_freeze = or1200_cpu_id_freeze;
assign or1200_cpu_or1200_ctrl_ex_freeze = or1200_cpu_ex_freeze;
assign or1200_cpu_or1200_ctrl_wb_freeze = or1200_cpu_wb_freeze;
assign or1200_cpu_or1200_ctrl_if_insn = or1200_cpu_if_insn;
assign or1200_cpu_id_insn = or1200_cpu_or1200_ctrl_id_insn;
assign or1200_cpu_ex_insn = or1200_cpu_or1200_ctrl_ex_insn;
assign or1200_cpu_or1200_ctrl_abort_mvspr = or1200_cpu_abort_mvspr;
assign or1200_cpu_pre_branch_op = or1200_cpu_or1200_ctrl_id_branch_op;
assign or1200_cpu_branch_op = or1200_cpu_or1200_ctrl_ex_branch_op;
assign or1200_cpu_or1200_ctrl_ex_branch_taken = or1200_cpu_ex_branch_taken;
assign or1200_cpu_or1200_ctrl_pc_we = or1200_cpu_pc_we;
assign or1200_cpu_rf_addra = or1200_cpu_or1200_ctrl_rf_addra;
assign or1200_cpu_rf_addrb = or1200_cpu_or1200_ctrl_rf_addrb;
assign or1200_cpu_rf_rda = or1200_cpu_or1200_ctrl_rf_rda;
assign or1200_cpu_rf_rdb = or1200_cpu_or1200_ctrl_rf_rdb;
assign or1200_cpu_alu_op = or1200_cpu_or1200_ctrl_alu_op;
assign or1200_cpu_alu_op2 = or1200_cpu_or1200_ctrl_alu_op2;
assign or1200_cpu_mac_op = or1200_cpu_or1200_ctrl_mac_op;
assign or1200_cpu_comp_op = or1200_cpu_or1200_ctrl_comp_op;
assign or1200_cpu_rf_addrw = or1200_cpu_or1200_ctrl_rf_addrw;
assign or1200_cpu_rfwb_op = or1200_cpu_or1200_ctrl_rfwb_op;
assign or1200_cpu_fpu_op = or1200_cpu_or1200_ctrl_fpu_op;
assign or1200_cpu_wb_insn = or1200_cpu_or1200_ctrl_wb_insn;
assign or1200_cpu_id_simm = or1200_cpu_or1200_ctrl_id_simm;
assign or1200_cpu_ex_simm = or1200_cpu_or1200_ctrl_ex_simm;
assign or1200_cpu_id_branch_addrtarget = or1200_cpu_or1200_ctrl_id_branch_addrtarget;
assign or1200_cpu_ex_branch_addrtarget = or1200_cpu_or1200_ctrl_ex_branch_addrtarget;
assign or1200_cpu_sel_a = or1200_cpu_or1200_ctrl_sel_a;
assign or1200_cpu_sel_b = or1200_cpu_or1200_ctrl_sel_b;
assign or1200_cpu_id_lsu_op = or1200_cpu_or1200_ctrl_id_lsu_op;
assign or1200_cpu_cust5_op = or1200_cpu_or1200_ctrl_cust5_op;
assign or1200_cpu_cust5_limm = or1200_cpu_or1200_ctrl_cust5_limm;
assign or1200_cpu_or1200_ctrl_id_pc = or1200_cpu_id_pc;
assign or1200_cpu_or1200_ctrl_ex_pc = or1200_cpu_ex_pc;
assign or1200_cpu_or1200_ctrl_du_hwbkpt = or1200_cpu_du_hwbkpt;
assign or1200_cpu_multicycle = or1200_cpu_or1200_ctrl_multicycle;
assign or1200_cpu_wait_on = or1200_cpu_or1200_ctrl_wait_on;
assign or1200_cpu_or1200_ctrl_wbforw_valid = or1200_cpu_wbforw_valid;
assign or1200_cpu_sig_syscall = or1200_cpu_or1200_ctrl_sig_syscall;
assign or1200_cpu_sig_trap = or1200_cpu_or1200_ctrl_sig_trap;
assign or1200_cpu_force_dslot_fetch = or1200_cpu_or1200_ctrl_force_dslot_fetch;
assign or1200_cpu_no_more_dslot = or1200_cpu_or1200_ctrl_no_more_dslot;
assign or1200_cpu_id_void = or1200_cpu_or1200_ctrl_id_void;
assign or1200_cpu_ex_void = or1200_cpu_or1200_ctrl_ex_void;
assign or1200_cpu_ex_spr_read = or1200_cpu_or1200_ctrl_ex_spr_read;
assign or1200_cpu_ex_spr_write = or1200_cpu_or1200_ctrl_ex_spr_write;
assign or1200_cpu_or1200_ctrl_du_flush_pipe = or1200_cpu_du_flush_pipe;
assign or1200_cpu_id_mac_op = or1200_cpu_or1200_ctrl_id_mac_op;
assign or1200_cpu_id_macrc_op = or1200_cpu_or1200_ctrl_id_macrc_op;
assign or1200_cpu_ex_macrc_op = or1200_cpu_or1200_ctrl_ex_macrc_op;
assign or1200_cpu_rfe = or1200_cpu_or1200_ctrl_rfe;
assign or1200_cpu_except_illegal = or1200_cpu_or1200_ctrl_except_illegal;
assign or1200_cpu_dc_no_writethrough = or1200_cpu_or1200_ctrl_dc_no_writethrough;
  
  
wire  or1200_cpu_or1200_rf_clk;
wire  or1200_cpu_or1200_rf_rst;
wire  or1200_cpu_or1200_rf_cy_we_i;
wire  or1200_cpu_or1200_rf_cy_we_o;
wire  or1200_cpu_or1200_rf_supv;
wire  or1200_cpu_or1200_rf_wb_freeze;
wire [ or1200_cpu_or1200_rf_aw -1:0] or1200_cpu_or1200_rf_addrw;
wire [ or1200_cpu_or1200_rf_dw -1:0] or1200_cpu_or1200_rf_dataw;
wire  or1200_cpu_or1200_rf_we;
wire  or1200_cpu_or1200_rf_flushpipe;
wire  or1200_cpu_or1200_rf_id_freeze;
wire [ or1200_cpu_or1200_rf_aw -1:0] or1200_cpu_or1200_rf_addra;
wire [ or1200_cpu_or1200_rf_aw -1:0] or1200_cpu_or1200_rf_addrb;
wire [ or1200_cpu_or1200_rf_dw -1:0] or1200_cpu_or1200_rf_dataa;
wire [ or1200_cpu_or1200_rf_dw -1:0] or1200_cpu_or1200_rf_datab;
wire  or1200_cpu_or1200_rf_rda;
wire  or1200_cpu_or1200_rf_rdb;
wire  or1200_cpu_or1200_rf_spr_cs;
wire  or1200_cpu_or1200_rf_spr_write;
wire [31:0] or1200_cpu_or1200_rf_spr_addr;
wire [31:0] or1200_cpu_or1200_rf_spr_dat_i;
wire [31:0] or1200_cpu_or1200_rf_spr_dat_o;
wire  or1200_cpu_or1200_rf_du_read;
 
   wire[  or1200_cpu_or1200_rf_dw  -1:0]  or1200_cpu_or1200_rf_from_rfa  ; 
   wire[  or1200_cpu_or1200_rf_dw  -1:0]  or1200_cpu_or1200_rf_from_rfb  ; 
   wire[  or1200_cpu_or1200_rf_aw  -1:0]  or1200_cpu_or1200_rf_rf_addra  ; 
   wire[  or1200_cpu_or1200_rf_aw  -1:0]  or1200_cpu_or1200_rf_rf_addrw  ; 
   wire[  or1200_cpu_or1200_rf_dw  -1:0]  or1200_cpu_or1200_rf_rf_dataw  ; 
   wire  or1200_cpu_or1200_rf_rf_we  ; 
   wire  or1200_cpu_or1200_rf_spr_valid  ; 
   wire  or1200_cpu_or1200_rf_rf_ena  ; 
   wire  or1200_cpu_or1200_rf_rf_enb  ; 
   reg  or1200_cpu_or1200_rf_rf_we_allow  ; 
   reg  or1200_cpu_or1200_rf_spr_du_cs  ; 
   wire  or1200_cpu_or1200_rf_spr_cs_fe  ; 
   reg[  or1200_cpu_or1200_rf_aw  -1:0]  or1200_cpu_or1200_rf_addra_last  ; 
  always @( posedge   or1200_cpu_or1200_rf_clk  )
       if (  or1200_cpu_or1200_rf_rf_ena  &!(  or1200_cpu_or1200_rf_spr_cs_fe  |(  or1200_cpu_or1200_rf_du_read  &  or1200_cpu_or1200_rf_spr_cs  ))) 
           or1200_cpu_or1200_rf_addra_last   <=  or1200_cpu_or1200_rf_addra  ;
 
  always @( posedge   or1200_cpu_or1200_rf_clk  ) 
        or1200_cpu_or1200_rf_spr_du_cs   <=  or1200_cpu_or1200_rf_spr_cs  &  or1200_cpu_or1200_rf_du_read  ;
 
  assign   or1200_cpu_or1200_rf_spr_cs_fe  =  or1200_cpu_or1200_rf_spr_du_cs  &!(  or1200_cpu_or1200_rf_spr_cs  &  or1200_cpu_or1200_rf_du_read  ); 
  assign   or1200_cpu_or1200_rf_spr_valid  =  or1200_cpu_or1200_rf_spr_cs  &(  or1200_cpu_or1200_rf_spr_addr  [10:5]==6'd32); 
  assign   or1200_cpu_or1200_rf_spr_dat_o  =  or1200_cpu_or1200_rf_from_rfa  ; 
  assign   or1200_cpu_or1200_rf_dataa  =  or1200_cpu_or1200_rf_from_rfa  ; 
  assign   or1200_cpu_or1200_rf_datab  =  or1200_cpu_or1200_rf_from_rfb  ; 
  assign   or1200_cpu_or1200_rf_rf_addra  =(  or1200_cpu_or1200_rf_spr_valid  &!  or1200_cpu_or1200_rf_spr_write  )?  or1200_cpu_or1200_rf_spr_addr  [4:0]:  or1200_cpu_or1200_rf_spr_cs_fe  ?  or1200_cpu_or1200_rf_addra_last  :  or1200_cpu_or1200_rf_addra  ; 
  assign   or1200_cpu_or1200_rf_rf_addrw  =(  or1200_cpu_or1200_rf_spr_valid  &  or1200_cpu_or1200_rf_spr_write  )?  or1200_cpu_or1200_rf_spr_addr  [4:0]:  or1200_cpu_or1200_rf_addrw  ; 
  assign   or1200_cpu_or1200_rf_rf_dataw  =(  or1200_cpu_or1200_rf_spr_valid  &  or1200_cpu_or1200_rf_spr_write  )?  or1200_cpu_or1200_rf_spr_dat_i  :  or1200_cpu_or1200_rf_dataw  ; 
  always @(  posedge    or1200_cpu_or1200_rf_rst          or  posedge   or1200_cpu_or1200_rf_clk  )
       if (  or1200_cpu_or1200_rf_rst  ==(1'b1)) 
           or1200_cpu_or1200_rf_rf_we_allow   <=1'b1;
        else 
          if (~  or1200_cpu_or1200_rf_wb_freeze  ) 
              or1200_cpu_or1200_rf_rf_we_allow   <=~  or1200_cpu_or1200_rf_flushpipe  ;
 
  assign   or1200_cpu_or1200_rf_rf_we  =((  or1200_cpu_or1200_rf_spr_valid  &  or1200_cpu_or1200_rf_spr_write  )|(  or1200_cpu_or1200_rf_we  &~  or1200_cpu_or1200_rf_wb_freeze  ))&  or1200_cpu_or1200_rf_rf_we_allow  ; 
  assign   or1200_cpu_or1200_rf_cy_we_o  =  or1200_cpu_or1200_rf_cy_we_i  &&~  or1200_cpu_or1200_rf_wb_freeze  &&  or1200_cpu_or1200_rf_rf_we_allow  ; 
  assign   or1200_cpu_or1200_rf_rf_ena  =(  or1200_cpu_or1200_rf_rda  &~  or1200_cpu_or1200_rf_id_freeze  )|(  or1200_cpu_or1200_rf_spr_valid  &!  or1200_cpu_or1200_rf_spr_write  )|  or1200_cpu_or1200_rf_spr_cs_fe  ; 
  assign   or1200_cpu_or1200_rf_rf_enb  =  or1200_cpu_or1200_rf_rdb  &~  or1200_cpu_or1200_rf_id_freeze  ;  
  
wire  or1200_cpu_or1200_rf_rf_a_clk_a;
wire  or1200_cpu_or1200_rf_rf_a_ce_a;
wire [ or1200_cpu_or1200_rf_rf_a_aw -1:0] or1200_cpu_or1200_rf_rf_a_addr_a;
wire [ or1200_cpu_or1200_rf_rf_a_dw -1:0] or1200_cpu_or1200_rf_rf_a_do_a;
wire  or1200_cpu_or1200_rf_rf_a_clk_b;
wire  or1200_cpu_or1200_rf_rf_a_ce_b;
wire  or1200_cpu_or1200_rf_rf_a_we_b;
wire [ or1200_cpu_or1200_rf_rf_a_aw -1:0] or1200_cpu_or1200_rf_rf_a_addr_b;
wire [ or1200_cpu_or1200_rf_rf_a_dw -1:0] or1200_cpu_or1200_rf_rf_a_di_b;
wire  or1200_cpu_or1200_rf_rf_b_clk_a;
wire  or1200_cpu_or1200_rf_rf_b_ce_a;
wire [ or1200_cpu_or1200_rf_rf_b_aw -1:0] or1200_cpu_or1200_rf_rf_b_addr_a;
wire [ or1200_cpu_or1200_rf_rf_b_dw -1:0] or1200_cpu_or1200_rf_rf_b_do_a;
wire  or1200_cpu_or1200_rf_rf_b_clk_b;
wire  or1200_cpu_or1200_rf_rf_b_ce_b;
wire  or1200_cpu_or1200_rf_rf_b_we_b;
wire [ or1200_cpu_or1200_rf_rf_b_aw -1:0] or1200_cpu_or1200_rf_rf_b_addr_b;
wire [ or1200_cpu_or1200_rf_rf_b_dw -1:0] or1200_cpu_or1200_rf_rf_b_di_b;
 
   reg[  or1200_cpu_or1200_rf_rf_a_dw  -1:0]  or1200_cpu_or1200_rf_rf_a_mem  [(1<<  or1200_cpu_or1200_rf_rf_a_aw  )-1:0]; 
   reg[  or1200_cpu_or1200_rf_rf_a_aw  -1:0]  or1200_cpu_or1200_rf_rf_a_addr_a_reg  ; function[31:0]  or1200_cpu_or1200_rf_rf_a_get_gpr  ;input[  or1200_cpu_or1200_rf_rf_a_aw  -1:0]  or1200_cpu_or1200_rf_rf_a_gpr_no  ; 
       or1200_cpu_or1200_rf_rf_a_get_gpr   =  or1200_cpu_or1200_rf_rf_a_mem  [  or1200_cpu_or1200_rf_rf_a_gpr_no  ];endfunction function[31:0]  or1200_cpu_or1200_rf_rf_a_set_gpr  ;input[  or1200_cpu_or1200_rf_rf_a_aw  -1:0]  or1200_cpu_or1200_rf_rf_a_gpr_no  ;input[  or1200_cpu_or1200_rf_rf_a_dw  -1:0]  or1200_cpu_or1200_rf_rf_a_value  ;
      begin  
         or1200_cpu_or1200_rf_rf_a_mem   [  or1200_cpu_or1200_rf_rf_a_gpr_no  ]=  or1200_cpu_or1200_rf_rf_a_value  ; 
         or1200_cpu_or1200_rf_rf_a_set_gpr   =0;
      end endfunction 
  assign   or1200_cpu_or1200_rf_rf_a_do_a  =  or1200_cpu_or1200_rf_rf_a_mem  [  or1200_cpu_or1200_rf_rf_a_addr_a_reg  ]; 
  always @( posedge   or1200_cpu_or1200_rf_rf_a_clk_a  )
       if (  or1200_cpu_or1200_rf_rf_a_ce_a  ) 
           or1200_cpu_or1200_rf_rf_a_addr_a_reg   <=  or1200_cpu_or1200_rf_rf_a_addr_a  ;
 
  always @( posedge   or1200_cpu_or1200_rf_rf_a_clk_b  )
       if (  or1200_cpu_or1200_rf_rf_a_ce_b  &  or1200_cpu_or1200_rf_rf_a_we_b  ) 
           or1200_cpu_or1200_rf_rf_a_mem   [  or1200_cpu_or1200_rf_rf_a_addr_b  ]<=  or1200_cpu_or1200_rf_rf_a_di_b  ;

  
  
 
   reg[  or1200_cpu_or1200_rf_rf_b_dw  -1:0]  or1200_cpu_or1200_rf_rf_b_mem  [(1<<  or1200_cpu_or1200_rf_rf_b_aw  )-1:0]; 
   reg[  or1200_cpu_or1200_rf_rf_b_aw  -1:0]  or1200_cpu_or1200_rf_rf_b_addr_a_reg  ; function[31:0]  or1200_cpu_or1200_rf_rf_b_get_gpr  ;input[  or1200_cpu_or1200_rf_rf_b_aw  -1:0]  or1200_cpu_or1200_rf_rf_b_gpr_no  ; 
       or1200_cpu_or1200_rf_rf_b_get_gpr   =  or1200_cpu_or1200_rf_rf_b_mem  [  or1200_cpu_or1200_rf_rf_b_gpr_no  ];endfunction function[31:0]  or1200_cpu_or1200_rf_rf_b_set_gpr  ;input[  or1200_cpu_or1200_rf_rf_b_aw  -1:0]  or1200_cpu_or1200_rf_rf_b_gpr_no  ;input[  or1200_cpu_or1200_rf_rf_b_dw  -1:0]  or1200_cpu_or1200_rf_rf_b_value  ;
      begin  
         or1200_cpu_or1200_rf_rf_b_mem   [  or1200_cpu_or1200_rf_rf_b_gpr_no  ]=  or1200_cpu_or1200_rf_rf_b_value  ; 
         or1200_cpu_or1200_rf_rf_b_set_gpr   =0;
      end endfunction 
  assign   or1200_cpu_or1200_rf_rf_b_do_a  =  or1200_cpu_or1200_rf_rf_b_mem  [  or1200_cpu_or1200_rf_rf_b_addr_a_reg  ]; 
  always @( posedge   or1200_cpu_or1200_rf_rf_b_clk_a  )
       if (  or1200_cpu_or1200_rf_rf_b_ce_a  ) 
           or1200_cpu_or1200_rf_rf_b_addr_a_reg   <=  or1200_cpu_or1200_rf_rf_b_addr_a  ;
 
  always @( posedge   or1200_cpu_or1200_rf_rf_b_clk_b  )
       if (  or1200_cpu_or1200_rf_rf_b_ce_b  &  or1200_cpu_or1200_rf_rf_b_we_b  ) 
           or1200_cpu_or1200_rf_rf_b_mem   [  or1200_cpu_or1200_rf_rf_b_addr_b  ]<=  or1200_cpu_or1200_rf_rf_b_di_b  ;

assign or1200_cpu_or1200_rf_rf_a_clk_a = or1200_cpu_or1200_rf_clk;
assign or1200_cpu_or1200_rf_rf_a_ce_a = or1200_cpu_or1200_rf_rf_enb;
assign or1200_cpu_or1200_rf_rf_a_addr_a = or1200_cpu_or1200_rf_addrb;
assign or1200_cpu_or1200_rf_from_rfb = or1200_cpu_or1200_rf_rf_a_do_a;
assign or1200_cpu_or1200_rf_rf_a_clk_b = or1200_cpu_or1200_rf_clk;
assign or1200_cpu_or1200_rf_rf_a_ce_b = or1200_cpu_or1200_rf_rf_we;
assign or1200_cpu_or1200_rf_rf_a_we_b = or1200_cpu_or1200_rf_rf_we;
assign or1200_cpu_or1200_rf_rf_a_addr_b = or1200_cpu_or1200_rf_rf_addrw;
assign or1200_cpu_or1200_rf_rf_a_di_b = or1200_cpu_or1200_rf_rf_dataw;
assign or1200_cpu_or1200_rf_rf_b_clk_a = or1200_cpu_or1200_rf_clk;
assign or1200_cpu_or1200_rf_rf_b_ce_a = or1200_cpu_or1200_rf_rf_enb;
assign or1200_cpu_or1200_rf_rf_b_addr_a = or1200_cpu_or1200_rf_addrb;
assign or1200_cpu_or1200_rf_from_rfb = or1200_cpu_or1200_rf_rf_b_do_a;
assign or1200_cpu_or1200_rf_rf_b_clk_b = or1200_cpu_or1200_rf_clk;
assign or1200_cpu_or1200_rf_rf_b_ce_b = or1200_cpu_or1200_rf_rf_we;
assign or1200_cpu_or1200_rf_rf_b_we_b = or1200_cpu_or1200_rf_rf_we;
assign or1200_cpu_or1200_rf_rf_b_addr_b = or1200_cpu_or1200_rf_rf_addrw;
assign or1200_cpu_or1200_rf_rf_b_di_b = or1200_cpu_or1200_rf_rf_dataw;

assign or1200_cpu_or1200_rf_clk = or1200_cpu_clk;
assign or1200_cpu_or1200_rf_rst = or1200_cpu_rst;
assign or1200_cpu_or1200_rf_cy_we_i = or1200_cpu_cy_we_alu;
assign or1200_cpu_cy_we_rf = or1200_cpu_or1200_rf_cy_we_o;
assign or1200_cpu_or1200_rf_supv = or1200_cpu_sr[0];
assign or1200_cpu_or1200_rf_wb_freeze = or1200_cpu_wb_freeze;
assign or1200_cpu_or1200_rf_addrw = or1200_cpu_rf_addrw;
assign or1200_cpu_or1200_rf_dataw = or1200_cpu_rf_dataw;
assign or1200_cpu_or1200_rf_we = or1200_cpu_rfwb_op[0];
assign or1200_cpu_or1200_rf_flushpipe = or1200_cpu_wb_flushpipe;
assign or1200_cpu_or1200_rf_id_freeze = or1200_cpu_id_freeze;
assign or1200_cpu_or1200_rf_addra = or1200_cpu_rf_addra;
assign or1200_cpu_or1200_rf_addrb = or1200_cpu_rf_addrb;
assign or1200_cpu_rf_dataa = or1200_cpu_or1200_rf_dataa;
assign or1200_cpu_rf_datab = or1200_cpu_or1200_rf_datab;
assign or1200_cpu_or1200_rf_rda = or1200_cpu_rf_rda;
assign or1200_cpu_or1200_rf_rdb = or1200_cpu_rf_rdb;
assign or1200_cpu_or1200_rf_spr_cs = or1200_cpu_spr_cs[5'd00];
assign or1200_cpu_or1200_rf_spr_write = or1200_cpu_spr_we;
assign or1200_cpu_or1200_rf_spr_addr = or1200_cpu_spr_addr;
assign or1200_cpu_or1200_rf_spr_dat_i = or1200_cpu_spr_dat_cpu;
assign or1200_cpu_spr_dat_rf = or1200_cpu_or1200_rf_spr_dat_o;
assign or1200_cpu_or1200_rf_du_read = or1200_cpu_du_read;
  
  
wire  or1200_cpu_or1200_operandmuxes_clk;
wire  or1200_cpu_or1200_operandmuxes_rst;
wire  or1200_cpu_or1200_operandmuxes_id_freeze;
wire  or1200_cpu_or1200_operandmuxes_ex_freeze;
wire [ or1200_cpu_or1200_operandmuxes_width -1:0] or1200_cpu_or1200_operandmuxes_rf_dataa;
wire [ or1200_cpu_or1200_operandmuxes_width -1:0] or1200_cpu_or1200_operandmuxes_rf_datab;
wire [ or1200_cpu_or1200_operandmuxes_width -1:0] or1200_cpu_or1200_operandmuxes_ex_forw;
wire [ or1200_cpu_or1200_operandmuxes_width -1:0] or1200_cpu_or1200_operandmuxes_wb_forw;
wire [ or1200_cpu_or1200_operandmuxes_width -1:0] or1200_cpu_or1200_operandmuxes_simm;
wire [2-1:0] or1200_cpu_or1200_operandmuxes_sel_a;
wire [2-1:0] or1200_cpu_or1200_operandmuxes_sel_b;
reg [ or1200_cpu_or1200_operandmuxes_width -1:0] or1200_cpu_or1200_operandmuxes_operand_a;
reg [ or1200_cpu_or1200_operandmuxes_width -1:0] or1200_cpu_or1200_operandmuxes_operand_b;
reg [ or1200_cpu_or1200_operandmuxes_width -1:0] or1200_cpu_or1200_operandmuxes_muxed_a;
reg [ or1200_cpu_or1200_operandmuxes_width -1:0] or1200_cpu_or1200_operandmuxes_muxed_b;
 
   reg  or1200_cpu_or1200_operandmuxes_saved_a  ; 
   reg  or1200_cpu_or1200_operandmuxes_saved_b  ; 
  always @(  posedge    or1200_cpu_or1200_operandmuxes_clk          or  posedge   or1200_cpu_or1200_operandmuxes_rst  )
       begin 
         if (  or1200_cpu_or1200_operandmuxes_rst  ==(1'b1))
            begin  
               or1200_cpu_or1200_operandmuxes_operand_a   <=32'd0; 
               or1200_cpu_or1200_operandmuxes_saved_a   <=1'b0;
            end 
          else 
            if (!  or1200_cpu_or1200_operandmuxes_ex_freeze  &&  or1200_cpu_or1200_operandmuxes_id_freeze  &&!  or1200_cpu_or1200_operandmuxes_saved_a  )
               begin  
                  or1200_cpu_or1200_operandmuxes_operand_a   <=  or1200_cpu_or1200_operandmuxes_muxed_a  ; 
                  or1200_cpu_or1200_operandmuxes_saved_a   <=1'b1;
               end 
             else 
               if (!  or1200_cpu_or1200_operandmuxes_ex_freeze  &&!  or1200_cpu_or1200_operandmuxes_saved_a  )
                  begin  
                     or1200_cpu_or1200_operandmuxes_operand_a   <=  or1200_cpu_or1200_operandmuxes_muxed_a  ;
                  end 
                else 
                  if (!  or1200_cpu_or1200_operandmuxes_ex_freeze  &&!  or1200_cpu_or1200_operandmuxes_id_freeze  ) 
                      or1200_cpu_or1200_operandmuxes_saved_a   <=1'b0;
       end
  
  always @(  posedge    or1200_cpu_or1200_operandmuxes_clk          or  posedge   or1200_cpu_or1200_operandmuxes_rst  )
       begin 
         if (  or1200_cpu_or1200_operandmuxes_rst  ==(1'b1))
            begin  
               or1200_cpu_or1200_operandmuxes_operand_b   <=32'd0; 
               or1200_cpu_or1200_operandmuxes_saved_b   <=1'b0;
            end 
          else 
            if (!  or1200_cpu_or1200_operandmuxes_ex_freeze  &&  or1200_cpu_or1200_operandmuxes_id_freeze  &&!  or1200_cpu_or1200_operandmuxes_saved_b  )
               begin  
                  or1200_cpu_or1200_operandmuxes_operand_b   <=  or1200_cpu_or1200_operandmuxes_muxed_b  ; 
                  or1200_cpu_or1200_operandmuxes_saved_b   <=1'b1;
               end 
             else 
               if (!  or1200_cpu_or1200_operandmuxes_ex_freeze  &&!  or1200_cpu_or1200_operandmuxes_saved_b  )
                  begin  
                     or1200_cpu_or1200_operandmuxes_operand_b   <=  or1200_cpu_or1200_operandmuxes_muxed_b  ;
                  end 
                else 
                  if (!  or1200_cpu_or1200_operandmuxes_ex_freeze  &&!  or1200_cpu_or1200_operandmuxes_id_freeze  ) 
                      or1200_cpu_or1200_operandmuxes_saved_b   <=1'b0;
       end
  
  always @(      or1200_cpu_or1200_operandmuxes_ex_forw                or    or1200_cpu_or1200_operandmuxes_wb_forw            or    or1200_cpu_or1200_operandmuxes_rf_dataa           or    or1200_cpu_or1200_operandmuxes_sel_a   )
       begin 
         casez (  or1200_cpu_or1200_operandmuxes_sel_a  )
          2 'd2: 
              or1200_cpu_or1200_operandmuxes_muxed_a   =  or1200_cpu_or1200_operandmuxes_ex_forw  ;
          2 'd3: 
              or1200_cpu_or1200_operandmuxes_muxed_a   =  or1200_cpu_or1200_operandmuxes_wb_forw  ;
          default : 
              or1200_cpu_or1200_operandmuxes_muxed_a   =  or1200_cpu_or1200_operandmuxes_rf_dataa  ;
         endcase 
       end
  
  always @(       or1200_cpu_or1200_operandmuxes_simm                  or    or1200_cpu_or1200_operandmuxes_ex_forw             or    or1200_cpu_or1200_operandmuxes_wb_forw            or    or1200_cpu_or1200_operandmuxes_rf_datab           or    or1200_cpu_or1200_operandmuxes_sel_b   )
       begin 
         casez (  or1200_cpu_or1200_operandmuxes_sel_b  )
          2 'd1: 
              or1200_cpu_or1200_operandmuxes_muxed_b   =  or1200_cpu_or1200_operandmuxes_simm  ;
          2 'd2: 
              or1200_cpu_or1200_operandmuxes_muxed_b   =  or1200_cpu_or1200_operandmuxes_ex_forw  ;
          2 'd3: 
              or1200_cpu_or1200_operandmuxes_muxed_b   =  or1200_cpu_or1200_operandmuxes_wb_forw  ;
          default : 
              or1200_cpu_or1200_operandmuxes_muxed_b   =  or1200_cpu_or1200_operandmuxes_rf_datab  ;
         endcase 
       end
 
assign or1200_cpu_or1200_operandmuxes_clk = or1200_cpu_clk;
assign or1200_cpu_or1200_operandmuxes_rst = or1200_cpu_rst;
assign or1200_cpu_or1200_operandmuxes_id_freeze = or1200_cpu_id_freeze;
assign or1200_cpu_or1200_operandmuxes_ex_freeze = or1200_cpu_ex_freeze;
assign or1200_cpu_or1200_operandmuxes_rf_dataa = or1200_cpu_rf_dataa;
assign or1200_cpu_or1200_operandmuxes_rf_datab = or1200_cpu_rf_datab;
assign or1200_cpu_or1200_operandmuxes_ex_forw = or1200_cpu_rf_dataw;
assign or1200_cpu_or1200_operandmuxes_wb_forw = or1200_cpu_wb_forw;
assign or1200_cpu_or1200_operandmuxes_simm = or1200_cpu_id_simm;
assign or1200_cpu_or1200_operandmuxes_sel_a = or1200_cpu_sel_a;
assign or1200_cpu_or1200_operandmuxes_sel_b = or1200_cpu_sel_b;
assign or1200_cpu_operand_a = or1200_cpu_or1200_operandmuxes_operand_a;
assign or1200_cpu_operand_b = or1200_cpu_or1200_operandmuxes_operand_b;
assign or1200_cpu_muxed_a = or1200_cpu_or1200_operandmuxes_muxed_a;
assign or1200_cpu_muxed_b = or1200_cpu_or1200_operandmuxes_muxed_b;
  
  
wire [32-1:0] or1200_cpu_or1200_alu_a;
wire [32-1:0] or1200_cpu_or1200_alu_b;
wire [32-1:0] or1200_cpu_or1200_alu_mult_mac_result;
wire  or1200_cpu_or1200_alu_macrc_op;
wire [5-1:0] or1200_cpu_or1200_alu_alu_op;
wire [4-1:0] or1200_cpu_or1200_alu_alu_op2;
wire [4-1:0] or1200_cpu_or1200_alu_comp_op;
wire [4:0] or1200_cpu_or1200_alu_cust5_op;
wire [5:0] or1200_cpu_or1200_alu_cust5_limm;
reg [32-1:0] or1200_cpu_or1200_alu_result;
reg  or1200_cpu_or1200_alu_flagforw;
reg  or1200_cpu_or1200_alu_flag_we;
reg  or1200_cpu_or1200_alu_ovforw;
reg  or1200_cpu_or1200_alu_ov_we;
reg  or1200_cpu_or1200_alu_cyforw;
reg  or1200_cpu_or1200_alu_cy_we;
wire  or1200_cpu_or1200_alu_carry;
wire  or1200_cpu_or1200_alu_flag;
 
   reg[32-1:0]  or1200_cpu_or1200_alu_shifted_rotated  ; 
   reg[32-1:0]  or1200_cpu_or1200_alu_extended  ; 
   reg  or1200_cpu_or1200_alu_flagcomp  ; 
   wire[32-1:0]  or1200_cpu_or1200_alu_comp_a  ; 
   wire[32-1:0]  or1200_cpu_or1200_alu_comp_b  ; 
   wire  or1200_cpu_or1200_alu_a_eq_b  ; 
   wire  or1200_cpu_or1200_alu_a_lt_b  ; 
   wire[32-1:0]  or1200_cpu_or1200_alu_result_sum  ; 
   wire[32-1:0]  or1200_cpu_or1200_alu_result_and  ; 
   wire  or1200_cpu_or1200_alu_cy_sum  ; 
   wire  or1200_cpu_or1200_alu_cy_sub  ; 
   wire  or1200_cpu_or1200_alu_ov_sum  ; 
   wire[32-1:0]  or1200_cpu_or1200_alu_carry_in  ; 
   wire[32-1:0]  or1200_cpu_or1200_alu_b_mux  ; 
  assign   or1200_cpu_or1200_alu_comp_a  ={  or1200_cpu_or1200_alu_a  [32-1]^  or1200_cpu_or1200_alu_comp_op  [3],  or1200_cpu_or1200_alu_a  [32-2:0]}; 
  assign   or1200_cpu_or1200_alu_comp_b  ={  or1200_cpu_or1200_alu_b  [32-1]^  or1200_cpu_or1200_alu_comp_op  [3],  or1200_cpu_or1200_alu_b  [32-2:0]}; 
  assign   or1200_cpu_or1200_alu_a_eq_b  =!(|  or1200_cpu_or1200_alu_result_sum  ); 
  assign   or1200_cpu_or1200_alu_a_lt_b  =  or1200_cpu_or1200_alu_comp_op  [3]?((  or1200_cpu_or1200_alu_a  [32-1]&!  or1200_cpu_or1200_alu_b  [32-1])|(!  or1200_cpu_or1200_alu_a  [32-1]&!  or1200_cpu_or1200_alu_b  [32-1]&  or1200_cpu_or1200_alu_result_sum  [32-1])|(  or1200_cpu_or1200_alu_a  [32-1]&  or1200_cpu_or1200_alu_b  [32-1]&  or1200_cpu_or1200_alu_result_sum  [32-1])):(  or1200_cpu_or1200_alu_a  <  or1200_cpu_or1200_alu_b  ); 
  assign   or1200_cpu_or1200_alu_cy_sub  =  or1200_cpu_or1200_alu_a_lt_b  ; 
  assign   or1200_cpu_or1200_alu_carry_in  =(  or1200_cpu_or1200_alu_alu_op  ==5'b0_0001)?{{32-1{1'b0}},  or1200_cpu_or1200_alu_carry  }:{32{1'b0}}; 
  assign   or1200_cpu_or1200_alu_b_mux  =((  or1200_cpu_or1200_alu_alu_op  ==5'b0_0010)|(  or1200_cpu_or1200_alu_alu_op  ==5'b1_0000))?(~  or1200_cpu_or1200_alu_b  )+1:  or1200_cpu_or1200_alu_b  ; 
  assign {  or1200_cpu_or1200_alu_cy_sum  ,  or1200_cpu_or1200_alu_result_sum  }=(  or1200_cpu_or1200_alu_a  +  or1200_cpu_or1200_alu_b_mux  )+  or1200_cpu_or1200_alu_carry_in  ; 
  assign   or1200_cpu_or1200_alu_ov_sum  =((!  or1200_cpu_or1200_alu_a  [32-1]&!  or1200_cpu_or1200_alu_b_mux  [32-1])&  or1200_cpu_or1200_alu_result_sum  [32-1])|((!  or1200_cpu_or1200_alu_a  [32-1]&  or1200_cpu_or1200_alu_b_mux  [32-1])&  or1200_cpu_or1200_alu_result_sum  [32-1]&  or1200_cpu_or1200_alu_alu_op  ==5'b0_0010)|((  or1200_cpu_or1200_alu_a  [32-1]&  or1200_cpu_or1200_alu_b_mux  [32-1])&!  or1200_cpu_or1200_alu_result_sum  [32-1]); 
  assign   or1200_cpu_or1200_alu_result_and  =  or1200_cpu_or1200_alu_a  &  or1200_cpu_or1200_alu_b  ; 
  always @(              or1200_cpu_or1200_alu_alu_op                                or    or1200_cpu_or1200_alu_alu_op2                    or    or1200_cpu_or1200_alu_a                   or    or1200_cpu_or1200_alu_b                  or    or1200_cpu_or1200_alu_result_sum                 or    or1200_cpu_or1200_alu_result_and                or    or1200_cpu_or1200_alu_macrc_op               or    or1200_cpu_or1200_alu_shifted_rotated              or    or1200_cpu_or1200_alu_mult_mac_result             or    or1200_cpu_or1200_alu_flag            or    or1200_cpu_or1200_alu_carry           or    or1200_cpu_or1200_alu_extended   )
       begin 
         casez (  or1200_cpu_or1200_alu_alu_op  )
          5 'b0_1111:
             begin 
               casez (  or1200_cpu_or1200_alu_alu_op2  )
                0 :
                   begin  
                      or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_a  [0]?1:  or1200_cpu_or1200_alu_a  [1]?2:  or1200_cpu_or1200_alu_a  [2]?3:  or1200_cpu_or1200_alu_a  [3]?4:  or1200_cpu_or1200_alu_a  [4]?5:  or1200_cpu_or1200_alu_a  [5]?6:  or1200_cpu_or1200_alu_a  [6]?7:  or1200_cpu_or1200_alu_a  [7]?8:  or1200_cpu_or1200_alu_a  [8]?9:  or1200_cpu_or1200_alu_a  [9]?10:  or1200_cpu_or1200_alu_a  [10]?11:  or1200_cpu_or1200_alu_a  [11]?12:  or1200_cpu_or1200_alu_a  [12]?13:  or1200_cpu_or1200_alu_a  [13]?14:  or1200_cpu_or1200_alu_a  [14]?15:  or1200_cpu_or1200_alu_a  [15]?16:  or1200_cpu_or1200_alu_a  [16]?17:  or1200_cpu_or1200_alu_a  [17]?18:  or1200_cpu_or1200_alu_a  [18]?19:  or1200_cpu_or1200_alu_a  [19]?20:  or1200_cpu_or1200_alu_a  [20]?21:  or1200_cpu_or1200_alu_a  [21]?22:  or1200_cpu_or1200_alu_a  [22]?23:  or1200_cpu_or1200_alu_a  [23]?24:  or1200_cpu_or1200_alu_a  [24]?25:  or1200_cpu_or1200_alu_a  [25]?26:  or1200_cpu_or1200_alu_a  [26]?27:  or1200_cpu_or1200_alu_a  [27]?28:  or1200_cpu_or1200_alu_a  [28]?29:  or1200_cpu_or1200_alu_a  [29]?30:  or1200_cpu_or1200_alu_a  [30]?31:  or1200_cpu_or1200_alu_a  [31]?32:0;
                   end 
                default :
                   begin  
                      or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_a  [31]?32:  or1200_cpu_or1200_alu_a  [30]?31:  or1200_cpu_or1200_alu_a  [29]?30:  or1200_cpu_or1200_alu_a  [28]?29:  or1200_cpu_or1200_alu_a  [27]?28:  or1200_cpu_or1200_alu_a  [26]?27:  or1200_cpu_or1200_alu_a  [25]?26:  or1200_cpu_or1200_alu_a  [24]?25:  or1200_cpu_or1200_alu_a  [23]?24:  or1200_cpu_or1200_alu_a  [22]?23:  or1200_cpu_or1200_alu_a  [21]?22:  or1200_cpu_or1200_alu_a  [20]?21:  or1200_cpu_or1200_alu_a  [19]?20:  or1200_cpu_or1200_alu_a  [18]?19:  or1200_cpu_or1200_alu_a  [17]?18:  or1200_cpu_or1200_alu_a  [16]?17:  or1200_cpu_or1200_alu_a  [15]?16:  or1200_cpu_or1200_alu_a  [14]?15:  or1200_cpu_or1200_alu_a  [13]?14:  or1200_cpu_or1200_alu_a  [12]?13:  or1200_cpu_or1200_alu_a  [11]?12:  or1200_cpu_or1200_alu_a  [10]?11:  or1200_cpu_or1200_alu_a  [9]?10:  or1200_cpu_or1200_alu_a  [8]?9:  or1200_cpu_or1200_alu_a  [7]?8:  or1200_cpu_or1200_alu_a  [6]?7:  or1200_cpu_or1200_alu_a  [5]?6:  or1200_cpu_or1200_alu_a  [4]?5:  or1200_cpu_or1200_alu_a  [3]?4:  or1200_cpu_or1200_alu_a  [2]?3:  or1200_cpu_or1200_alu_a  [1]?2:  or1200_cpu_or1200_alu_a  [0]?1:0;
                   end 
               endcase 
             end 
          5 'b0_1000:
             begin  
                or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_shifted_rotated  ;
             end 
          5 'b0_0001,5'b0_0010,5'b0_0000:
             begin  
                or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_result_sum  ;
             end 
          5 'b0_0101:
             begin  
                or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_a  ^  or1200_cpu_or1200_alu_b  ;
             end 
          5 'b0_0100:
             begin  
                or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_a  |  or1200_cpu_or1200_alu_b  ;
             end 
          5 'b0_1100:
             begin  
                or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_extended  ;
             end 
          5 'b0_1101:
             begin  
                or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_a  ;
             end 
          5 'b1_0001:
             begin 
               if (  or1200_cpu_or1200_alu_macrc_op  )
                  begin  
                     or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_mult_mac_result  ;
                  end 
                else 
                  begin  
                     or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_b  <<16;
                  end 
             end 
          5 'b0_1001,5'b0_1010,5'b0_0110,5'b0_1011:
             begin  
                or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_mult_mac_result  ;
             end 
          5 'b0_1110:
             begin  
                or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_flag  ?  or1200_cpu_or1200_alu_a  :  or1200_cpu_or1200_alu_b  ;
             end 
          default :
             begin  
                or1200_cpu_or1200_alu_result   =  or1200_cpu_or1200_alu_result_and  ;
             end 
         endcase 
       end
  
  always @(      or1200_cpu_or1200_alu_alu_op                or    or1200_cpu_or1200_alu_result_sum            or    or1200_cpu_or1200_alu_result_and           or    or1200_cpu_or1200_alu_flagcomp   )
       begin 
         casez (  or1200_cpu_or1200_alu_alu_op  )
          5 'b1_0000:
             begin  
                or1200_cpu_or1200_alu_flagforw   =  or1200_cpu_or1200_alu_flagcomp  ; 
                or1200_cpu_or1200_alu_flag_we   =1'b1;
             end 
          default :
             begin  
                or1200_cpu_or1200_alu_flagforw   =  or1200_cpu_or1200_alu_flagcomp  ; 
                or1200_cpu_or1200_alu_flag_we   =1'b0;
             end 
         endcase 
       end
  
  always @(     or1200_cpu_or1200_alu_alu_op              or    or1200_cpu_or1200_alu_cy_sum           or    or1200_cpu_or1200_alu_cy_sub   )
       begin 
         casez (  or1200_cpu_or1200_alu_alu_op  )
          5 'b0_0001,5'b0_0000:
             begin  
                or1200_cpu_or1200_alu_cyforw   =  or1200_cpu_or1200_alu_cy_sum  ; 
                or1200_cpu_or1200_alu_cy_we   =1'b1;
             end 
          5 'b0_0010:
             begin  
                or1200_cpu_or1200_alu_cyforw   =  or1200_cpu_or1200_alu_cy_sub  ; 
                or1200_cpu_or1200_alu_cy_we   =1'b1;
             end 
          default :
             begin  
                or1200_cpu_or1200_alu_cyforw   =1'b0; 
                or1200_cpu_or1200_alu_cy_we   =1'b0;
             end 
         endcase 
       end
  
  always @(    or1200_cpu_or1200_alu_alu_op            or    or1200_cpu_or1200_alu_ov_sum   )
       begin 
         casez (  or1200_cpu_or1200_alu_alu_op  )
          5 'b0_0001,5'b0_0010,5'b0_0000:
             begin  
                or1200_cpu_or1200_alu_ovforw   =  or1200_cpu_or1200_alu_ov_sum  ; 
                or1200_cpu_or1200_alu_ov_we   =1'b1;
             end 
          default :
             begin  
                or1200_cpu_or1200_alu_ovforw   =1'b0; 
                or1200_cpu_or1200_alu_ov_we   =1'b0;
             end 
         endcase 
       end
  
  always @(     or1200_cpu_or1200_alu_alu_op2              or    or1200_cpu_or1200_alu_a           or    or1200_cpu_or1200_alu_b   )
       begin 
         case (  or1200_cpu_or1200_alu_alu_op2  )
          4 'd0: 
              or1200_cpu_or1200_alu_shifted_rotated   =(  or1200_cpu_or1200_alu_a  <<  or1200_cpu_or1200_alu_b  [4:0]);
          4 'd1: 
              or1200_cpu_or1200_alu_shifted_rotated   =(  or1200_cpu_or1200_alu_a  >>  or1200_cpu_or1200_alu_b  [4:0]);
          default : 
              or1200_cpu_or1200_alu_shifted_rotated   =({32{  or1200_cpu_or1200_alu_a  [31]}}<<(6'd32-{1'b0,  or1200_cpu_or1200_alu_b  [4:0]}))|  or1200_cpu_or1200_alu_a  >>  or1200_cpu_or1200_alu_b  [4:0];
         endcase 
       end
  
  always @(     or1200_cpu_or1200_alu_comp_op              or    or1200_cpu_or1200_alu_a_eq_b           or    or1200_cpu_or1200_alu_a_lt_b   )
       begin 
         case (  or1200_cpu_or1200_alu_comp_op  [2:0])
          3 'b000: 
              or1200_cpu_or1200_alu_flagcomp   =  or1200_cpu_or1200_alu_a_eq_b  ;
          3 'b001: 
              or1200_cpu_or1200_alu_flagcomp   =~  or1200_cpu_or1200_alu_a_eq_b  ;
          3 'b010: 
              or1200_cpu_or1200_alu_flagcomp   =~(  or1200_cpu_or1200_alu_a_eq_b  |  or1200_cpu_or1200_alu_a_lt_b  );
          3 'b011: 
              or1200_cpu_or1200_alu_flagcomp   =~  or1200_cpu_or1200_alu_a_lt_b  ;
          3 'b100: 
              or1200_cpu_or1200_alu_flagcomp   =  or1200_cpu_or1200_alu_a_lt_b  ;
          3 'b101: 
              or1200_cpu_or1200_alu_flagcomp   =  or1200_cpu_or1200_alu_a_eq_b  |  or1200_cpu_or1200_alu_a_lt_b  ;
          default : 
              or1200_cpu_or1200_alu_flagcomp   =1'b0;
         endcase 
       end
  
  always @(     or1200_cpu_or1200_alu_alu_op              or    or1200_cpu_or1200_alu_alu_op2           or    or1200_cpu_or1200_alu_a   )
       begin 
         casez (  or1200_cpu_or1200_alu_alu_op2  )
          4 'h0: 
              or1200_cpu_or1200_alu_extended   ={{16{  or1200_cpu_or1200_alu_a  [15]}},  or1200_cpu_or1200_alu_a  [15:0]};
          4 'h1: 
              or1200_cpu_or1200_alu_extended   ={{24{  or1200_cpu_or1200_alu_a  [7]}},  or1200_cpu_or1200_alu_a  [7:0]};
          4 'h2: 
              or1200_cpu_or1200_alu_extended   ={16'd0,  or1200_cpu_or1200_alu_a  [15:0]};
          4 'h3: 
              or1200_cpu_or1200_alu_extended   ={24'd0,  or1200_cpu_or1200_alu_a  [7:0]};
          default : 
              or1200_cpu_or1200_alu_extended   =  or1200_cpu_or1200_alu_a  ;
         endcase 
       end
 
assign or1200_cpu_or1200_alu_a = or1200_cpu_operand_a;
assign or1200_cpu_or1200_alu_b = or1200_cpu_operand_b;
assign or1200_cpu_or1200_alu_mult_mac_result = or1200_cpu_mult_mac_result;
assign or1200_cpu_or1200_alu_macrc_op = or1200_cpu_ex_macrc_op;
assign or1200_cpu_or1200_alu_alu_op = or1200_cpu_alu_op;
assign or1200_cpu_or1200_alu_alu_op2 = or1200_cpu_alu_op2;
assign or1200_cpu_or1200_alu_comp_op = or1200_cpu_comp_op;
assign or1200_cpu_or1200_alu_cust5_op = or1200_cpu_cust5_op;
assign or1200_cpu_or1200_alu_cust5_limm = or1200_cpu_cust5_limm;
assign or1200_cpu_alu_dataout = or1200_cpu_or1200_alu_result;
assign or1200_cpu_flagforw_alu = or1200_cpu_or1200_alu_flagforw;
assign or1200_cpu_flag_we_alu = or1200_cpu_or1200_alu_flag_we;
assign or1200_cpu_ovforw = or1200_cpu_or1200_alu_ovforw;
assign or1200_cpu_ov_we_alu = or1200_cpu_or1200_alu_ov_we;
assign or1200_cpu_cyforw = or1200_cpu_or1200_alu_cyforw;
assign or1200_cpu_cy_we_alu = or1200_cpu_or1200_alu_cy_we;
assign or1200_cpu_or1200_alu_carry = or1200_cpu_carry;
assign or1200_cpu_or1200_alu_flag = or1200_cpu_flag;
 
  assign   or1200_cpu_fpu_except_started  =  or1200_cpu_except_started  &&(  or1200_cpu_except_type  ==4'hd);  
  
wire  or1200_cpu_or1200_fpu_clk;
wire  or1200_cpu_or1200_fpu_rst;
wire  or1200_cpu_or1200_fpu_ex_freeze;
wire [ or1200_cpu_or1200_fpu_width -1:0] or1200_cpu_or1200_fpu_a;
wire [ or1200_cpu_or1200_fpu_width -1:0] or1200_cpu_or1200_fpu_b;
wire [8-1:0] or1200_cpu_or1200_fpu_fpu_op;
wire [ or1200_cpu_or1200_fpu_width -1:0] or1200_cpu_or1200_fpu_result;
wire  or1200_cpu_or1200_fpu_done;
wire  or1200_cpu_or1200_fpu_flagforw;
wire  or1200_cpu_or1200_fpu_flag_we;
wire  or1200_cpu_or1200_fpu_sig_fp;
wire  or1200_cpu_or1200_fpu_except_started;
wire  or1200_cpu_or1200_fpu_fpcsr_we;
wire [12-1:0] or1200_cpu_or1200_fpu_fpcsr;
wire  or1200_cpu_or1200_fpu_spr_cs;
wire  or1200_cpu_or1200_fpu_spr_write;
wire [31:0] or1200_cpu_or1200_fpu_spr_addr;
wire [31:0] or1200_cpu_or1200_fpu_spr_dat_i;
wire [31:0] or1200_cpu_or1200_fpu_spr_dat_o;
 
  assign   or1200_cpu_or1200_fpu_result  =0; 
  assign   or1200_cpu_or1200_fpu_flagforw  =0; 
  assign   or1200_cpu_or1200_fpu_flag_we  =0; 
  assign   or1200_cpu_or1200_fpu_sig_fp  =0; 
  assign   or1200_cpu_or1200_fpu_spr_dat_o  =0; 
  assign   or1200_cpu_or1200_fpu_fpcsr  =0; 
  assign   or1200_cpu_or1200_fpu_done  =1;
assign or1200_cpu_or1200_fpu_clk = or1200_cpu_clk;
assign or1200_cpu_or1200_fpu_rst = or1200_cpu_rst;
assign or1200_cpu_or1200_fpu_ex_freeze = or1200_cpu_ex_freeze;
assign or1200_cpu_or1200_fpu_a = or1200_cpu_operand_a;
assign or1200_cpu_or1200_fpu_b = or1200_cpu_operand_b;
assign or1200_cpu_or1200_fpu_fpu_op = or1200_cpu_fpu_op;
assign or1200_cpu_fpu_dataout = or1200_cpu_or1200_fpu_result;
assign or1200_cpu_fpu_done = or1200_cpu_or1200_fpu_done;
assign or1200_cpu_flagforw_fpu = or1200_cpu_or1200_fpu_flagforw;
assign or1200_cpu_flag_we_fpu = or1200_cpu_or1200_fpu_flag_we;
assign or1200_cpu_sig_fp = or1200_cpu_or1200_fpu_sig_fp;
assign or1200_cpu_or1200_fpu_except_started = or1200_cpu_fpu_except_started;
assign or1200_cpu_or1200_fpu_fpcsr_we = or1200_cpu_fpcsr_we;
assign or1200_cpu_fpcsr = or1200_cpu_or1200_fpu_fpcsr;
assign or1200_cpu_or1200_fpu_spr_cs = or1200_cpu_spr_cs[5'd11];
assign or1200_cpu_or1200_fpu_spr_write = or1200_cpu_spr_we;
assign or1200_cpu_or1200_fpu_spr_addr = or1200_cpu_spr_addr;
assign or1200_cpu_or1200_fpu_spr_dat_i = or1200_cpu_spr_dat_cpu;
assign or1200_cpu_spr_dat_fpu = or1200_cpu_or1200_fpu_spr_dat_o;
  
  
wire  or1200_cpu_or1200_mult_mac_clk;
wire  or1200_cpu_or1200_mult_mac_rst;
wire  or1200_cpu_or1200_mult_mac_ex_freeze;
wire  or1200_cpu_or1200_mult_mac_id_macrc_op;
wire  or1200_cpu_or1200_mult_mac_macrc_op;
wire [ or1200_cpu_or1200_mult_mac_width -1:0] or1200_cpu_or1200_mult_mac_a;
wire [ or1200_cpu_or1200_mult_mac_width -1:0] or1200_cpu_or1200_mult_mac_b;
wire [3-1:0] or1200_cpu_or1200_mult_mac_mac_op;
wire [5-1:0] or1200_cpu_or1200_mult_mac_alu_op;
reg [ or1200_cpu_or1200_mult_mac_width -1:0] or1200_cpu_or1200_mult_mac_result;
wire  or1200_cpu_or1200_mult_mac_mult_mac_stall;
reg  or1200_cpu_or1200_mult_mac_ovforw;
reg  or1200_cpu_or1200_mult_mac_ov_we;
wire  or1200_cpu_or1200_mult_mac_spr_cs;
wire  or1200_cpu_or1200_mult_mac_spr_write;
wire [31:0] or1200_cpu_or1200_mult_mac_spr_addr;
wire [31:0] or1200_cpu_or1200_mult_mac_spr_dat_i;
wire [31:0] or1200_cpu_or1200_mult_mac_spr_dat_o;
 
   reg  or1200_cpu_or1200_mult_mac_ex_freeze_r  ; 
   wire  or1200_cpu_or1200_mult_mac_alu_op_mul  ; 
   wire  or1200_cpu_or1200_mult_mac_alu_op_smul  ; 
   reg[2*  or1200_cpu_or1200_mult_mac_width  -1:0]  or1200_cpu_or1200_mult_mac_mul_prod_r  ; 
   wire  or1200_cpu_or1200_mult_mac_alu_op_umul  ; 
   wire[2*  or1200_cpu_or1200_mult_mac_width  -1:0]  or1200_cpu_or1200_mult_mac_mul_prod  ; 
   wire  or1200_cpu_or1200_mult_mac_mul_stall  ; 
   reg[1:0]  or1200_cpu_or1200_mult_mac_mul_stall_count  ; 
   wire[3-1:0]  or1200_cpu_or1200_mult_mac_mac_op_r1  ; 
   wire[3-1:0]  or1200_cpu_or1200_mult_mac_mac_op_r2  ; 
   wire[3-1:0]  or1200_cpu_or1200_mult_mac_mac_op_r3  ; 
   wire  or1200_cpu_or1200_mult_mac_mac_stall_r  ; 
   wire[63:0]  or1200_cpu_or1200_mult_mac_mac_r  ; 
   wire[  or1200_cpu_or1200_mult_mac_width  -1:0]  or1200_cpu_or1200_mult_mac_x  ; 
   wire[  or1200_cpu_or1200_mult_mac_width  -1:0]  or1200_cpu_or1200_mult_mac_y  ; 
   wire  or1200_cpu_or1200_mult_mac_spr_maclo_we  ; 
   wire  or1200_cpu_or1200_mult_mac_spr_machi_we  ; 
   wire  or1200_cpu_or1200_mult_mac_alu_op_div  ; 
   wire  or1200_cpu_or1200_mult_mac_alu_op_udiv  ; 
   wire  or1200_cpu_or1200_mult_mac_alu_op_sdiv  ; 
   reg  or1200_cpu_or1200_mult_mac_div_free  ; 
   wire  or1200_cpu_or1200_mult_mac_div_stall  ; 
   reg[2*  or1200_cpu_or1200_mult_mac_width  -1:0]  or1200_cpu_or1200_mult_mac_div_quot_r  ; 
   wire[  or1200_cpu_or1200_mult_mac_width  -1:0]  or1200_cpu_or1200_mult_mac_div_tmp  ; 
   reg[5:0]  or1200_cpu_or1200_mult_mac_div_cntr  ; 
   wire  or1200_cpu_or1200_mult_mac_div_by_zero  ; 
  assign   or1200_cpu_or1200_mult_mac_alu_op_smul  =(  or1200_cpu_or1200_mult_mac_alu_op  ==5'b0_0110); 
  assign   or1200_cpu_or1200_mult_mac_alu_op_umul  =(  or1200_cpu_or1200_mult_mac_alu_op  ==5'b0_1011); 
  assign   or1200_cpu_or1200_mult_mac_alu_op_mul  =  or1200_cpu_or1200_mult_mac_alu_op_smul  |  or1200_cpu_or1200_mult_mac_alu_op_umul  ; 
  assign   or1200_cpu_or1200_mult_mac_spr_maclo_we  =1'b0; 
  assign   or1200_cpu_or1200_mult_mac_spr_machi_we  =1'b0; 
  assign   or1200_cpu_or1200_mult_mac_spr_dat_o  =32'h0000_0000; 
  assign   or1200_cpu_or1200_mult_mac_alu_op_sdiv  =(  or1200_cpu_or1200_mult_mac_alu_op  ==5'b0_1001); 
  assign   or1200_cpu_or1200_mult_mac_alu_op_udiv  =(  or1200_cpu_or1200_mult_mac_alu_op  ==5'b0_1010); 
  assign   or1200_cpu_or1200_mult_mac_alu_op_div  =  or1200_cpu_or1200_mult_mac_alu_op_sdiv  |  or1200_cpu_or1200_mult_mac_alu_op_udiv  ; 
  assign   or1200_cpu_or1200_mult_mac_x  =(  or1200_cpu_or1200_mult_mac_alu_op_sdiv  |  or1200_cpu_or1200_mult_mac_alu_op_smul  )&  or1200_cpu_or1200_mult_mac_a  [31]?~  or1200_cpu_or1200_mult_mac_a  +32'b1:  or1200_cpu_or1200_mult_mac_alu_op_div  |  or1200_cpu_or1200_mult_mac_alu_op_mul  |(|  or1200_cpu_or1200_mult_mac_mac_op  )?  or1200_cpu_or1200_mult_mac_a  :32'd0; 
  assign   or1200_cpu_or1200_mult_mac_y  =(  or1200_cpu_or1200_mult_mac_alu_op_sdiv  |  or1200_cpu_or1200_mult_mac_alu_op_smul  )&  or1200_cpu_or1200_mult_mac_b  [31]?~  or1200_cpu_or1200_mult_mac_b  +32'b1:  or1200_cpu_or1200_mult_mac_alu_op_div  |  or1200_cpu_or1200_mult_mac_alu_op_mul  |(|  or1200_cpu_or1200_mult_mac_mac_op  )?  or1200_cpu_or1200_mult_mac_b  :32'd0; 
  assign   or1200_cpu_or1200_mult_mac_div_by_zero  =!(|  or1200_cpu_or1200_mult_mac_b  )&  or1200_cpu_or1200_mult_mac_alu_op_div  ; 
  always @(  posedge    or1200_cpu_or1200_mult_mac_clk          or  posedge   or1200_cpu_or1200_mult_mac_rst  )
       if (  or1200_cpu_or1200_mult_mac_rst  ==(1'b1)) 
           or1200_cpu_or1200_mult_mac_ex_freeze_r   <=1'b1;
        else  
           or1200_cpu_or1200_mult_mac_ex_freeze_r   <=  or1200_cpu_or1200_mult_mac_ex_freeze  ;
 
  always @*
       casez (  or1200_cpu_or1200_mult_mac_alu_op  )
        5 'b0_1001:
           begin  
              or1200_cpu_or1200_mult_mac_result   =  or1200_cpu_or1200_mult_mac_a  [31]^  or1200_cpu_or1200_mult_mac_b  [31]?~  or1200_cpu_or1200_mult_mac_div_quot_r  [31:0]+32'd1:  or1200_cpu_or1200_mult_mac_div_quot_r  [31:0];
           end 
        5 'b0_1010:
           begin  
              or1200_cpu_or1200_mult_mac_result   =  or1200_cpu_or1200_mult_mac_div_quot_r  [31:0];
           end 
        5 'b0_0110:
           begin  
              or1200_cpu_or1200_mult_mac_result   =  or1200_cpu_or1200_mult_mac_a  [31]^  or1200_cpu_or1200_mult_mac_b  [31]?~  or1200_cpu_or1200_mult_mac_mul_prod_r  [31:0]+32'd1:  or1200_cpu_or1200_mult_mac_mul_prod_r  [31:0];
           end 
        5 'b0_1011:
           begin  
              or1200_cpu_or1200_mult_mac_result   =  or1200_cpu_or1200_mult_mac_mul_prod_r  [31:0];
           end 
        default : 
            or1200_cpu_or1200_mult_mac_result   ={  or1200_cpu_or1200_mult_mac_width  {1'b0}};
       endcase
  
  always @*
       casez (  or1200_cpu_or1200_mult_mac_alu_op  )
        5 'b0_0110:
           begin  
              or1200_cpu_or1200_mult_mac_ovforw   =(  or1200_cpu_or1200_mult_mac_mul_prod_r  [  or1200_cpu_or1200_mult_mac_width  -1]&&!((  or1200_cpu_or1200_mult_mac_a  [  or1200_cpu_or1200_mult_mac_width  -1]^  or1200_cpu_or1200_mult_mac_b  [  or1200_cpu_or1200_mult_mac_width  -1])&&~|  or1200_cpu_or1200_mult_mac_mul_prod_r  [  or1200_cpu_or1200_mult_mac_width  -2:0]))|||  or1200_cpu_or1200_mult_mac_mul_prod_r  [2*  or1200_cpu_or1200_mult_mac_width  -1:32]; 
              or1200_cpu_or1200_mult_mac_ov_we   =1;
           end 
        5 'b0_1011:
           begin  
              or1200_cpu_or1200_mult_mac_ovforw   =|  or1200_cpu_or1200_mult_mac_mul_prod_r  [2*  or1200_cpu_or1200_mult_mac_width  -1:32]; 
              or1200_cpu_or1200_mult_mac_ov_we   =1;
           end 
        5 'b0_1010,5'b0_1001:
           begin  
              or1200_cpu_or1200_mult_mac_ovforw   =  or1200_cpu_or1200_mult_mac_div_by_zero  ||(  or1200_cpu_or1200_mult_mac_a  ==32'h8000_0000&&  or1200_cpu_or1200_mult_mac_b  ==32'hffff_ffff); 
              or1200_cpu_or1200_mult_mac_ov_we   =1;
           end 
        default :
           begin  
              or1200_cpu_or1200_mult_mac_ovforw   =0; 
              or1200_cpu_or1200_mult_mac_ov_we   =0;
           end 
       endcase
   
  
wire [32-1:0] or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_X;
wire [32-1:0] or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_Y;
wire  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_CLK;
wire  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_RST;
wire [64-1:0] or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_P;
 
   reg[32-1:0]  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_X_saved  ; 
   reg[32-1:0]  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_Y_saved  ; 
   reg[64-1:0]  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_p1  ; 
   integer  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_xi  ; 
   integer  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_yi  ; 
  always @(   or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_X_saved   ) 
        or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_xi   =  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_X_saved  ;
 
  always @(   or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_Y_saved   ) 
        or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_yi   =  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_Y_saved  ;
 
  always @(  posedge    or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_CLK          or  posedge   or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_RST  )
       if (  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_RST  ==(1'b1))
          begin  
             or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_X_saved   <=32'b0; 
             or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_Y_saved   <=32'b0;
          end 
        else 
          begin  
             or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_X_saved   <=  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_X  ; 
             or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_Y_saved   <=  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_Y  ;
          end
  
  always @(  posedge    or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_CLK          or  posedge   or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_RST  )
       if (  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_RST  ==(1'b1)) 
           or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_p1   <=64'b0;
        else  
           or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_p1   <=  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_xi  *  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_yi  ;
 
  assign   or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_P  =  or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_p1  ;
assign or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_X = or1200_cpu_or1200_mult_mac_x;
assign or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_Y = or1200_cpu_or1200_mult_mac_y;
assign or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_CLK = or1200_cpu_or1200_mult_mac_clk;
assign or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_RST = or1200_cpu_or1200_mult_mac_rst;
assign or1200_cpu_or1200_mult_mac_mul_prod = or1200_cpu_or1200_mult_mac_or1200_gmultp2_32x32_P;
 
  always @(  posedge    or1200_cpu_or1200_mult_mac_rst          or  posedge   or1200_cpu_or1200_mult_mac_clk  )
       if (  or1200_cpu_or1200_mult_mac_rst  ==(1'b1))
          begin  
             or1200_cpu_or1200_mult_mac_mul_prod_r   <=64'h0000_0000_0000_0000;
          end 
        else 
          begin  
             or1200_cpu_or1200_mult_mac_mul_prod_r   <=  or1200_cpu_or1200_mult_mac_mul_prod  [63:0];
          end
  
  always @(  posedge    or1200_cpu_or1200_mult_mac_rst          or  posedge   or1200_cpu_or1200_mult_mac_clk  )
       if (  or1200_cpu_or1200_mult_mac_rst  ==(1'b1)) 
           or1200_cpu_or1200_mult_mac_mul_stall_count   <=0;
        else 
          if (!(|  or1200_cpu_or1200_mult_mac_mul_stall_count  )) 
              or1200_cpu_or1200_mult_mac_mul_stall_count   <={  or1200_cpu_or1200_mult_mac_mul_stall_count  [0],  or1200_cpu_or1200_mult_mac_alu_op_mul  &!  or1200_cpu_or1200_mult_mac_ex_freeze_r  };
           else  
              or1200_cpu_or1200_mult_mac_mul_stall_count   <={  or1200_cpu_or1200_mult_mac_mul_stall_count  [0],1'b0};
 
  assign   or1200_cpu_or1200_mult_mac_mul_stall  =(|  or1200_cpu_or1200_mult_mac_mul_stall_count  )|(!(|  or1200_cpu_or1200_mult_mac_mul_stall_count  )&  or1200_cpu_or1200_mult_mac_alu_op_mul  &!  or1200_cpu_or1200_mult_mac_ex_freeze_r  ); 
  assign   or1200_cpu_or1200_mult_mac_mac_stall_r  =1'b0; 
  assign   or1200_cpu_or1200_mult_mac_mac_r  ={2*  or1200_cpu_or1200_mult_mac_width  {1'b0}}; 
  assign   or1200_cpu_or1200_mult_mac_mac_op_r1  =3'b0; 
  assign   or1200_cpu_or1200_mult_mac_mac_op_r2  =3'b0; 
  assign   or1200_cpu_or1200_mult_mac_mac_op_r3  =3'b0; 
  assign   or1200_cpu_or1200_mult_mac_div_tmp  =  or1200_cpu_or1200_mult_mac_div_quot_r  [63:32]-  or1200_cpu_or1200_mult_mac_y  ; 
  always @(  posedge    or1200_cpu_or1200_mult_mac_rst          or  posedge   or1200_cpu_or1200_mult_mac_clk  )
       if (  or1200_cpu_or1200_mult_mac_rst  ==(1'b1))
          begin  
             or1200_cpu_or1200_mult_mac_div_quot_r   <=64'h0000_0000_0000_0000; 
             or1200_cpu_or1200_mult_mac_div_free   <=1'b1; 
             or1200_cpu_or1200_mult_mac_div_cntr   <=6'b00_0000;
          end 
        else 
          if (  or1200_cpu_or1200_mult_mac_div_by_zero  )
             begin  
                or1200_cpu_or1200_mult_mac_div_quot_r   <=64'h0000_0000_0000_0000; 
                or1200_cpu_or1200_mult_mac_div_free   <=1'b1; 
                or1200_cpu_or1200_mult_mac_div_cntr   <=6'b00_0000;
             end 
           else 
             if (|  or1200_cpu_or1200_mult_mac_div_cntr  )
                begin 
                  if (  or1200_cpu_or1200_mult_mac_div_tmp  [31]) 
                      or1200_cpu_or1200_mult_mac_div_quot_r   <={  or1200_cpu_or1200_mult_mac_div_quot_r  [62:0],1'b0};
                   else  
                      or1200_cpu_or1200_mult_mac_div_quot_r   <={  or1200_cpu_or1200_mult_mac_div_tmp  [30:0],  or1200_cpu_or1200_mult_mac_div_quot_r  [31:0],1'b1}; 
                   or1200_cpu_or1200_mult_mac_div_cntr   <=  or1200_cpu_or1200_mult_mac_div_cntr  -6'd1;
                end 
              else 
                if (  or1200_cpu_or1200_mult_mac_alu_op_div  &&  or1200_cpu_or1200_mult_mac_div_free  )
                   begin  
                      or1200_cpu_or1200_mult_mac_div_quot_r   <={31'b0,  or1200_cpu_or1200_mult_mac_x  [31:0],1'b0}; 
                      or1200_cpu_or1200_mult_mac_div_cntr   <=6'b10_0000; 
                      or1200_cpu_or1200_mult_mac_div_free   <=1'b0;
                   end 
                 else 
                   if (  or1200_cpu_or1200_mult_mac_div_free  |!  or1200_cpu_or1200_mult_mac_ex_freeze  )
                      begin  
                         or1200_cpu_or1200_mult_mac_div_free   <=1'b1;
                      end
  
  assign   or1200_cpu_or1200_mult_mac_div_stall  =(|  or1200_cpu_or1200_mult_mac_div_cntr  )|(!  or1200_cpu_or1200_mult_mac_ex_freeze_r  &  or1200_cpu_or1200_mult_mac_alu_op_div  ); 
  assign   or1200_cpu_or1200_mult_mac_mult_mac_stall  =  or1200_cpu_or1200_mult_mac_mac_stall_r  |  or1200_cpu_or1200_mult_mac_div_stall  |  or1200_cpu_or1200_mult_mac_mul_stall  ;
assign or1200_cpu_or1200_mult_mac_clk = or1200_cpu_clk;
assign or1200_cpu_or1200_mult_mac_rst = or1200_cpu_rst;
assign or1200_cpu_or1200_mult_mac_ex_freeze = or1200_cpu_ex_freeze;
assign or1200_cpu_or1200_mult_mac_id_macrc_op = or1200_cpu_id_macrc_op;
assign or1200_cpu_or1200_mult_mac_macrc_op = or1200_cpu_ex_macrc_op;
assign or1200_cpu_or1200_mult_mac_a = or1200_cpu_operand_a;
assign or1200_cpu_or1200_mult_mac_b = or1200_cpu_operand_b;
assign or1200_cpu_or1200_mult_mac_mac_op = or1200_cpu_mac_op;
assign or1200_cpu_or1200_mult_mac_alu_op = or1200_cpu_alu_op;
assign or1200_cpu_mult_mac_result = or1200_cpu_or1200_mult_mac_result;
assign or1200_cpu_mult_mac_stall = or1200_cpu_or1200_mult_mac_mult_mac_stall;
assign or1200_cpu_ovforw_mult_mac = or1200_cpu_or1200_mult_mac_ovforw;
assign or1200_cpu_ov_we_mult_mac = or1200_cpu_or1200_mult_mac_ov_we;
assign or1200_cpu_or1200_mult_mac_spr_cs = or1200_cpu_spr_cs[5'd05];
assign or1200_cpu_or1200_mult_mac_spr_write = or1200_cpu_spr_we;
assign or1200_cpu_or1200_mult_mac_spr_addr = or1200_cpu_spr_addr;
assign or1200_cpu_or1200_mult_mac_spr_dat_i = or1200_cpu_spr_dat_cpu;
assign or1200_cpu_spr_dat_mac = or1200_cpu_or1200_mult_mac_spr_dat_o;
  
  
wire  or1200_cpu_or1200_sprs_clk;
wire  or1200_cpu_or1200_sprs_rst;
wire  or1200_cpu_or1200_sprs_flagforw;
wire  or1200_cpu_or1200_sprs_flag_we;
wire  or1200_cpu_or1200_sprs_flag;
wire  or1200_cpu_or1200_sprs_cyforw;
wire  or1200_cpu_or1200_sprs_cy_we;
wire  or1200_cpu_or1200_sprs_carry;
wire  or1200_cpu_or1200_sprs_ovforw;
wire  or1200_cpu_or1200_sprs_ov_we;
wire  or1200_cpu_or1200_sprs_dsx;
wire [ or1200_cpu_or1200_sprs_width -1:0] or1200_cpu_or1200_sprs_addrbase;
wire [15:0] or1200_cpu_or1200_sprs_addrofs;
wire [ or1200_cpu_or1200_sprs_width -1:0] or1200_cpu_or1200_sprs_dat_i;
wire [3-1:0] or1200_cpu_or1200_sprs_branch_op;
wire  or1200_cpu_or1200_sprs_ex_spr_read;
wire  or1200_cpu_or1200_sprs_ex_spr_write;
wire [ or1200_cpu_or1200_sprs_width -1:0] or1200_cpu_or1200_sprs_epcr;
wire [ or1200_cpu_or1200_sprs_width -1:0] or1200_cpu_or1200_sprs_eear;
wire [17-1:0] or1200_cpu_or1200_sprs_esr;
wire  or1200_cpu_or1200_sprs_except_started;
reg [ or1200_cpu_or1200_sprs_width -1:0] or1200_cpu_or1200_sprs_to_wbmux;
wire  or1200_cpu_or1200_sprs_epcr_we;
wire  or1200_cpu_or1200_sprs_eear_we;
wire  or1200_cpu_or1200_sprs_esr_we;
wire  or1200_cpu_or1200_sprs_pc_we;
wire  or1200_cpu_or1200_sprs_sr_we;
wire [17-1:0] or1200_cpu_or1200_sprs_to_sr;
reg [17-1:0] or1200_cpu_or1200_sprs_sr;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_cfgr;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_rf;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_npc;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_ppc;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_mac;
wire  or1200_cpu_or1200_sprs_boot_adr_sel_i;
wire [12-1:0] or1200_cpu_or1200_sprs_fpcsr;
wire  or1200_cpu_or1200_sprs_fpcsr_we;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_fpu;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_pic;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_tt;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_pm;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_dmmu;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_immu;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_du;
wire [31:0] or1200_cpu_or1200_sprs_spr_addr;
wire [31:0] or1200_cpu_or1200_sprs_spr_dat_o;
wire [31:0] or1200_cpu_or1200_sprs_spr_cs;
wire  or1200_cpu_or1200_sprs_spr_we;
wire [ or1200_cpu_or1200_sprs_width -1:0] or1200_cpu_or1200_sprs_du_addr;
wire [ or1200_cpu_or1200_sprs_width -1:0] or1200_cpu_or1200_sprs_du_dat_du;
wire  or1200_cpu_or1200_sprs_du_read;
wire  or1200_cpu_or1200_sprs_du_write;
wire [ or1200_cpu_or1200_sprs_width -1:0] or1200_cpu_or1200_sprs_du_dat_cpu;
 
   reg[17-1:0]  or1200_cpu_or1200_sprs_sr_reg  ; 
   reg  or1200_cpu_or1200_sprs_sr_reg_bit_eph  ; 
   reg  or1200_cpu_or1200_sprs_sr_reg_bit_eph_select  ; 
   wire  or1200_cpu_or1200_sprs_sr_reg_bit_eph_muxed  ; 
   wire  or1200_cpu_or1200_sprs_cfgr_sel  ; 
   wire  or1200_cpu_or1200_sprs_rf_sel  ; 
   wire  or1200_cpu_or1200_sprs_npc_sel  ; 
   wire  or1200_cpu_or1200_sprs_ppc_sel  ; 
   wire  or1200_cpu_or1200_sprs_sr_sel  ; 
   wire  or1200_cpu_or1200_sprs_epcr_sel  ; 
   wire  or1200_cpu_or1200_sprs_eear_sel  ; 
   wire  or1200_cpu_or1200_sprs_esr_sel  ; 
   wire  or1200_cpu_or1200_sprs_fpcsr_sel  ; 
   wire[31:0]  or1200_cpu_or1200_sprs_sys_data  ; 
   wire  or1200_cpu_or1200_sprs_du_access  ; 
   reg[31:0]  or1200_cpu_or1200_sprs_unqualified_cs  ; 
  assign   or1200_cpu_or1200_sprs_du_access  =  or1200_cpu_or1200_sprs_du_read  |  or1200_cpu_or1200_sprs_du_write  ; 
  assign   or1200_cpu_or1200_sprs_spr_addr  =  or1200_cpu_or1200_sprs_du_access  ?  or1200_cpu_or1200_sprs_du_addr  :(  or1200_cpu_or1200_sprs_addrbase  |{16'h0000,  or1200_cpu_or1200_sprs_addrofs  }); 
  assign   or1200_cpu_or1200_sprs_spr_dat_o  =  or1200_cpu_or1200_sprs_du_write  ?  or1200_cpu_or1200_sprs_du_dat_du  :  or1200_cpu_or1200_sprs_dat_i  ; 
  assign   or1200_cpu_or1200_sprs_du_dat_cpu  =  or1200_cpu_or1200_sprs_du_read  ?  or1200_cpu_or1200_sprs_to_wbmux  :  or1200_cpu_or1200_sprs_du_write  ?  or1200_cpu_or1200_sprs_du_dat_du  :  or1200_cpu_or1200_sprs_dat_i  ; 
  assign   or1200_cpu_or1200_sprs_spr_we  =  or1200_cpu_or1200_sprs_du_write  |(  or1200_cpu_or1200_sprs_ex_spr_write  &!  or1200_cpu_or1200_sprs_du_access  ); 
  assign   or1200_cpu_or1200_sprs_spr_cs  =  or1200_cpu_or1200_sprs_unqualified_cs  &{32{  or1200_cpu_or1200_sprs_du_read  |  or1200_cpu_or1200_sprs_du_write  |  or1200_cpu_or1200_sprs_ex_spr_read  |(  or1200_cpu_or1200_sprs_ex_spr_write  &  or1200_cpu_or1200_sprs_sr  [0])}}; 
  always @(   or1200_cpu_or1200_sprs_spr_addr   )
       case (  or1200_cpu_or1200_sprs_spr_addr  [15:11])
        5 'd00: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00000000_00000001;
        5 'd01: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00000000_00000010;
        5 'd02: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00000000_00000100;
        5 'd03: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00000000_00001000;
        5 'd04: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00000000_00010000;
        5 'd05: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00000000_00100000;
        5 'd06: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00000000_01000000;
        5 'd07: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00000000_10000000;
        5 'd08: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00000001_00000000;
        5 'd09: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00000010_00000000;
        5 'd10: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00000100_00000000;
        5 'd11: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00001000_00000000;
        5 'd12: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00010000_00000000;
        5 'd13: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_00100000_00000000;
        5 'd14: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_01000000_00000000;
        5 'd15: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000000_10000000_00000000;
        5 'd16: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000001_00000000_00000000;
        5 'd17: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000010_00000000_00000000;
        5 'd18: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00000100_00000000_00000000;
        5 'd19: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00001000_00000000_00000000;
        5 'd20: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00010000_00000000_00000000;
        5 'd21: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_00100000_00000000_00000000;
        5 'd22: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_01000000_00000000_00000000;
        5 'd23: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000000_10000000_00000000_00000000;
        5 'd24: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000001_00000000_00000000_00000000;
        5 'd25: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000010_00000000_00000000_00000000;
        5 'd26: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00000100_00000000_00000000_00000000;
        5 'd27: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00001000_00000000_00000000_00000000;
        5 'd28: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00010000_00000000_00000000_00000000;
        5 'd29: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b00100000_00000000_00000000_00000000;
        5 'd30: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b01000000_00000000_00000000_00000000;
        5 'd31: 
            or1200_cpu_or1200_sprs_unqualified_cs   =32'b10000000_00000000_00000000_00000000;
       endcase
  
  assign   or1200_cpu_or1200_sprs_to_sr  [15:12]=(  or1200_cpu_or1200_sprs_except_started  )?{  or1200_cpu_or1200_sprs_sr  [15:14],  or1200_cpu_or1200_sprs_dsx  ,1'b0}:(  or1200_cpu_or1200_sprs_branch_op  ==3'd6)?  or1200_cpu_or1200_sprs_esr  [15:12]:(  or1200_cpu_or1200_sprs_spr_we  &&  or1200_cpu_or1200_sprs_sr_sel  )?{1'b1,  or1200_cpu_or1200_sprs_spr_dat_o  [15-1:12]}:  or1200_cpu_or1200_sprs_sr  [15:12]; 
  assign   or1200_cpu_or1200_sprs_to_sr  [16]=(  or1200_cpu_or1200_sprs_except_started  )?1'b1:(  or1200_cpu_or1200_sprs_branch_op  ==3'd6)?  or1200_cpu_or1200_sprs_esr  [16]:(  or1200_cpu_or1200_sprs_spr_we  &&  or1200_cpu_or1200_sprs_sr_sel  )?  or1200_cpu_or1200_sprs_spr_dat_o  [16]:  or1200_cpu_or1200_sprs_sr  [16]; 
  assign   or1200_cpu_or1200_sprs_to_sr  [11]=(  or1200_cpu_or1200_sprs_except_started  )?  or1200_cpu_or1200_sprs_sr  [11]:(  or1200_cpu_or1200_sprs_branch_op  ==3'd6)?  or1200_cpu_or1200_sprs_esr  [11]:  or1200_cpu_or1200_sprs_ov_we  ?  or1200_cpu_or1200_sprs_ovforw  :(  or1200_cpu_or1200_sprs_spr_we  &&  or1200_cpu_or1200_sprs_sr_sel  )?  or1200_cpu_or1200_sprs_spr_dat_o  [11]:  or1200_cpu_or1200_sprs_sr  [11]; 
  assign   or1200_cpu_or1200_sprs_to_sr  [10]=(  or1200_cpu_or1200_sprs_except_started  )?  or1200_cpu_or1200_sprs_sr  [10]:(  or1200_cpu_or1200_sprs_branch_op  ==3'd6)?  or1200_cpu_or1200_sprs_esr  [10]:  or1200_cpu_or1200_sprs_cy_we  ?  or1200_cpu_or1200_sprs_cyforw  :(  or1200_cpu_or1200_sprs_spr_we  &&  or1200_cpu_or1200_sprs_sr_sel  )?  or1200_cpu_or1200_sprs_spr_dat_o  [10]:  or1200_cpu_or1200_sprs_sr  [10]; 
  assign   or1200_cpu_or1200_sprs_to_sr  [9]=(  or1200_cpu_or1200_sprs_except_started  )?  or1200_cpu_or1200_sprs_sr  [9]:(  or1200_cpu_or1200_sprs_branch_op  ==3'd6)?  or1200_cpu_or1200_sprs_esr  [9]:  or1200_cpu_or1200_sprs_flag_we  ?  or1200_cpu_or1200_sprs_flagforw  :(  or1200_cpu_or1200_sprs_spr_we  &&  or1200_cpu_or1200_sprs_sr_sel  )?  or1200_cpu_or1200_sprs_spr_dat_o  [9]:  or1200_cpu_or1200_sprs_sr  [9]; 
  assign   or1200_cpu_or1200_sprs_to_sr  [8:0]=(  or1200_cpu_or1200_sprs_except_started  )?{  or1200_cpu_or1200_sprs_sr  [8:7],2'b00,  or1200_cpu_or1200_sprs_sr  [4:3],3'b001}:(  or1200_cpu_or1200_sprs_branch_op  ==3'd6)?  or1200_cpu_or1200_sprs_esr  [8:0]:(  or1200_cpu_or1200_sprs_spr_we  &&  or1200_cpu_or1200_sprs_sr_sel  )?  or1200_cpu_or1200_sprs_spr_dat_o  [8:0]:  or1200_cpu_or1200_sprs_sr  [8:0]; 
  assign   or1200_cpu_or1200_sprs_cfgr_sel  =(  or1200_cpu_or1200_sprs_spr_cs  [5'd00]&&(  or1200_cpu_or1200_sprs_spr_addr  [10:4]==7'd0)); 
  assign   or1200_cpu_or1200_sprs_rf_sel  =(  or1200_cpu_or1200_sprs_spr_cs  [5'd00]&&(  or1200_cpu_or1200_sprs_spr_addr  [10:5]==6'd32)); 
  assign   or1200_cpu_or1200_sprs_npc_sel  =(  or1200_cpu_or1200_sprs_spr_cs  [5'd00]&&(  or1200_cpu_or1200_sprs_spr_addr  [10:0]==11'd16)); 
  assign   or1200_cpu_or1200_sprs_ppc_sel  =(  or1200_cpu_or1200_sprs_spr_cs  [5'd00]&&(  or1200_cpu_or1200_sprs_spr_addr  [10:0]==11'd18)); 
  assign   or1200_cpu_or1200_sprs_sr_sel  =(  or1200_cpu_or1200_sprs_spr_cs  [5'd00]&&(  or1200_cpu_or1200_sprs_spr_addr  [10:0]==11'd17)); 
  assign   or1200_cpu_or1200_sprs_epcr_sel  =(  or1200_cpu_or1200_sprs_spr_cs  [5'd00]&&(  or1200_cpu_or1200_sprs_spr_addr  [10:0]==11'd32)); 
  assign   or1200_cpu_or1200_sprs_eear_sel  =(  or1200_cpu_or1200_sprs_spr_cs  [5'd00]&&(  or1200_cpu_or1200_sprs_spr_addr  [10:0]==11'd48)); 
  assign   or1200_cpu_or1200_sprs_esr_sel  =(  or1200_cpu_or1200_sprs_spr_cs  [5'd00]&&(  or1200_cpu_or1200_sprs_spr_addr  [10:0]==11'd64)); 
  assign   or1200_cpu_or1200_sprs_fpcsr_sel  =(  or1200_cpu_or1200_sprs_spr_cs  [5'd00]&&(  or1200_cpu_or1200_sprs_spr_addr  [10:0]==11'd20)); 
  assign   or1200_cpu_or1200_sprs_sr_we  =(  or1200_cpu_or1200_sprs_spr_we  &&  or1200_cpu_or1200_sprs_sr_sel  )|(  or1200_cpu_or1200_sprs_branch_op  ==3'd6)|  or1200_cpu_or1200_sprs_flag_we  |  or1200_cpu_or1200_sprs_cy_we  |  or1200_cpu_or1200_sprs_ov_we  ; 
  assign   or1200_cpu_or1200_sprs_pc_we  =(  or1200_cpu_or1200_sprs_du_write  &&(  or1200_cpu_or1200_sprs_npc_sel  |  or1200_cpu_or1200_sprs_ppc_sel  )); 
  assign   or1200_cpu_or1200_sprs_epcr_we  =(  or1200_cpu_or1200_sprs_spr_we  &&  or1200_cpu_or1200_sprs_epcr_sel  ); 
  assign   or1200_cpu_or1200_sprs_eear_we  =(  or1200_cpu_or1200_sprs_spr_we  &&  or1200_cpu_or1200_sprs_eear_sel  ); 
  assign   or1200_cpu_or1200_sprs_esr_we  =(  or1200_cpu_or1200_sprs_spr_we  &&  or1200_cpu_or1200_sprs_esr_sel  ); 
  assign   or1200_cpu_or1200_sprs_fpcsr_we  =(  or1200_cpu_or1200_sprs_spr_we  &&  or1200_cpu_or1200_sprs_fpcsr_sel  ); 
  assign   or1200_cpu_or1200_sprs_sys_data  =(  or1200_cpu_or1200_sprs_spr_dat_cfgr  &{32{  or1200_cpu_or1200_sprs_cfgr_sel  }})|(  or1200_cpu_or1200_sprs_spr_dat_rf  &{32{  or1200_cpu_or1200_sprs_rf_sel  }})|(  or1200_cpu_or1200_sprs_spr_dat_npc  &{32{  or1200_cpu_or1200_sprs_npc_sel  }})|(  or1200_cpu_or1200_sprs_spr_dat_ppc  &{32{  or1200_cpu_or1200_sprs_ppc_sel  }})|({{32-17{1'b0}},  or1200_cpu_or1200_sprs_sr  }&{32{  or1200_cpu_or1200_sprs_sr_sel  }})|(  or1200_cpu_or1200_sprs_epcr  &{32{  or1200_cpu_or1200_sprs_epcr_sel  }})|(  or1200_cpu_or1200_sprs_eear  &{32{  or1200_cpu_or1200_sprs_eear_sel  }})|({{32-12{1'b0}},  or1200_cpu_or1200_sprs_fpcsr  }&{32{  or1200_cpu_or1200_sprs_fpcsr_sel  }})|({{32-17{1'b0}},  or1200_cpu_or1200_sprs_esr  }&{32{  or1200_cpu_or1200_sprs_esr_sel  }}); 
  assign   or1200_cpu_or1200_sprs_flag  =  or1200_cpu_or1200_sprs_sr  [9]; 
  assign   or1200_cpu_or1200_sprs_carry  =  or1200_cpu_or1200_sprs_sr  [10]; 
  always @(  posedge    or1200_cpu_or1200_sprs_clk          or  posedge   or1200_cpu_or1200_sprs_rst  )
       if (  or1200_cpu_or1200_sprs_rst  ==(1'b1)) 
           or1200_cpu_or1200_sprs_sr_reg   <={2'b01,1'b0,{17-4{1'b0}},1'b1};
        else 
          if (  or1200_cpu_or1200_sprs_except_started  ) 
              or1200_cpu_or1200_sprs_sr_reg   <=  or1200_cpu_or1200_sprs_to_sr  [17-1:0];
           else 
             if (  or1200_cpu_or1200_sprs_sr_we  ) 
                 or1200_cpu_or1200_sprs_sr_reg   <=  or1200_cpu_or1200_sprs_to_sr  [17-1:0];
 
  always @(  posedge    or1200_cpu_or1200_sprs_clk          or  posedge   or1200_cpu_or1200_sprs_rst  )
       if (  or1200_cpu_or1200_sprs_rst  ==(1'b1))
          begin  
             or1200_cpu_or1200_sprs_sr_reg_bit_eph   <=1'b0; 
             or1200_cpu_or1200_sprs_sr_reg_bit_eph_select   <=1'b1;
          end 
        else 
          if (  or1200_cpu_or1200_sprs_sr_reg_bit_eph_select  )
             begin  
                or1200_cpu_or1200_sprs_sr_reg_bit_eph   <=  or1200_cpu_or1200_sprs_boot_adr_sel_i  ; 
                or1200_cpu_or1200_sprs_sr_reg_bit_eph_select   <=1'b0;
             end 
           else 
             if (  or1200_cpu_or1200_sprs_sr_we  )
                begin  
                   or1200_cpu_or1200_sprs_sr_reg_bit_eph   <=  or1200_cpu_or1200_sprs_to_sr  [14];
                end
  
  assign   or1200_cpu_or1200_sprs_sr_reg_bit_eph_muxed  =(  or1200_cpu_or1200_sprs_sr_reg_bit_eph_select  )?  or1200_cpu_or1200_sprs_boot_adr_sel_i  :  or1200_cpu_or1200_sprs_sr_reg_bit_eph  ; 
  always @(    or1200_cpu_or1200_sprs_sr_reg            or    or1200_cpu_or1200_sprs_sr_reg_bit_eph_muxed   ) 
        or1200_cpu_or1200_sprs_sr   ={  or1200_cpu_or1200_sprs_sr_reg  [17-1:17-2],  or1200_cpu_or1200_sprs_sr_reg_bit_eph_muxed  ,  or1200_cpu_or1200_sprs_sr_reg  [17-4:0]};
 
  always @(            or1200_cpu_or1200_sprs_spr_addr                            or    or1200_cpu_or1200_sprs_sys_data                  or    or1200_cpu_or1200_sprs_spr_dat_mac                 or    or1200_cpu_or1200_sprs_spr_dat_pic                or    or1200_cpu_or1200_sprs_spr_dat_pm               or    or1200_cpu_or1200_sprs_spr_dat_fpu              or    or1200_cpu_or1200_sprs_spr_dat_dmmu             or    or1200_cpu_or1200_sprs_spr_dat_immu            or    or1200_cpu_or1200_sprs_spr_dat_du           or    or1200_cpu_or1200_sprs_spr_dat_tt   )
       begin 
         casez (  or1200_cpu_or1200_sprs_spr_addr  [15:11])
          5 'd00: 
              or1200_cpu_or1200_sprs_to_wbmux   =  or1200_cpu_or1200_sprs_sys_data  ;
          5 'd10: 
              or1200_cpu_or1200_sprs_to_wbmux   =  or1200_cpu_or1200_sprs_spr_dat_tt  ;
          5 'd09: 
              or1200_cpu_or1200_sprs_to_wbmux   =  or1200_cpu_or1200_sprs_spr_dat_pic  ;
          5 'd08: 
              or1200_cpu_or1200_sprs_to_wbmux   =  or1200_cpu_or1200_sprs_spr_dat_pm  ;
          5 'd01: 
              or1200_cpu_or1200_sprs_to_wbmux   =  or1200_cpu_or1200_sprs_spr_dat_dmmu  ;
          5 'd02: 
              or1200_cpu_or1200_sprs_to_wbmux   =  or1200_cpu_or1200_sprs_spr_dat_immu  ;
          5 'd05: 
              or1200_cpu_or1200_sprs_to_wbmux   =  or1200_cpu_or1200_sprs_spr_dat_mac  ;
          5 'd11: 
              or1200_cpu_or1200_sprs_to_wbmux   =  or1200_cpu_or1200_sprs_spr_dat_fpu  ;
          default : 
              or1200_cpu_or1200_sprs_to_wbmux   =  or1200_cpu_or1200_sprs_spr_dat_du  ;
         endcase 
       end
 
assign or1200_cpu_or1200_sprs_clk = or1200_cpu_clk;
assign or1200_cpu_or1200_sprs_rst = or1200_cpu_rst;
assign or1200_cpu_or1200_sprs_flagforw = or1200_cpu_flagforw;
assign or1200_cpu_or1200_sprs_flag_we = or1200_cpu_flag_we;
assign or1200_cpu_flag = or1200_cpu_or1200_sprs_flag;
assign or1200_cpu_or1200_sprs_cyforw = or1200_cpu_cyforw;
assign or1200_cpu_or1200_sprs_cy_we = or1200_cpu_cy_we_rf;
assign or1200_cpu_carry = or1200_cpu_or1200_sprs_carry;
assign or1200_cpu_or1200_sprs_ovforw = or1200_cpu_ovforw|or1200_cpu_ovforw_mult_mac;
assign or1200_cpu_or1200_sprs_ov_we = or1200_cpu_ov_we_alu|or1200_cpu_ov_we_mult_mac;
assign or1200_cpu_or1200_sprs_dsx = or1200_cpu_dsx;
assign or1200_cpu_or1200_sprs_addrbase = or1200_cpu_operand_a;
assign or1200_cpu_or1200_sprs_addrofs = or1200_cpu_ex_simm[15:0];
assign or1200_cpu_or1200_sprs_dat_i = or1200_cpu_operand_b;
assign or1200_cpu_or1200_sprs_branch_op = or1200_cpu_branch_op;
assign or1200_cpu_or1200_sprs_ex_spr_read = or1200_cpu_ex_spr_read;
assign or1200_cpu_or1200_sprs_ex_spr_write = or1200_cpu_ex_spr_write;
assign or1200_cpu_or1200_sprs_epcr = or1200_cpu_epcr;
assign or1200_cpu_or1200_sprs_eear = or1200_cpu_eear;
assign or1200_cpu_or1200_sprs_esr = or1200_cpu_esr;
assign or1200_cpu_or1200_sprs_except_started = or1200_cpu_except_started;
assign or1200_cpu_sprs_dataout = or1200_cpu_or1200_sprs_to_wbmux;
assign or1200_cpu_epcr_we = or1200_cpu_or1200_sprs_epcr_we;
assign or1200_cpu_eear_we = or1200_cpu_or1200_sprs_eear_we;
assign or1200_cpu_esr_we = or1200_cpu_or1200_sprs_esr_we;
assign or1200_cpu_pc_we = or1200_cpu_or1200_sprs_pc_we;
assign or1200_cpu_sr_we = or1200_cpu_or1200_sprs_sr_we;
assign or1200_cpu_to_sr = or1200_cpu_or1200_sprs_to_sr;
assign or1200_cpu_sr = or1200_cpu_or1200_sprs_sr;
assign or1200_cpu_or1200_sprs_spr_dat_cfgr = or1200_cpu_spr_dat_cfgr;
assign or1200_cpu_or1200_sprs_spr_dat_rf = or1200_cpu_spr_dat_rf;
assign or1200_cpu_or1200_sprs_spr_dat_npc = or1200_cpu_spr_dat_npc;
assign or1200_cpu_or1200_sprs_spr_dat_ppc = or1200_cpu_spr_dat_ppc;
assign or1200_cpu_or1200_sprs_spr_dat_mac = or1200_cpu_spr_dat_mac;
assign or1200_cpu_or1200_sprs_boot_adr_sel_i = or1200_cpu_boot_adr_sel_i;
assign or1200_cpu_or1200_sprs_fpcsr = or1200_cpu_fpcsr;
assign or1200_cpu_fpcsr_we = or1200_cpu_or1200_sprs_fpcsr_we;
assign or1200_cpu_or1200_sprs_spr_dat_fpu = or1200_cpu_spr_dat_fpu;
assign or1200_cpu_or1200_sprs_spr_dat_pic = or1200_cpu_spr_dat_pic;
assign or1200_cpu_or1200_sprs_spr_dat_tt = or1200_cpu_spr_dat_tt;
assign or1200_cpu_or1200_sprs_spr_dat_pm = or1200_cpu_spr_dat_pm;
assign or1200_cpu_or1200_sprs_spr_dat_dmmu = or1200_cpu_spr_dat_dmmu;
assign or1200_cpu_or1200_sprs_spr_dat_immu = or1200_cpu_spr_dat_immu;
assign or1200_cpu_or1200_sprs_spr_dat_du = or1200_cpu_spr_dat_du;
assign or1200_cpu_spr_addr = or1200_cpu_or1200_sprs_spr_addr;
assign or1200_cpu_spr_dat_cpu = or1200_cpu_or1200_sprs_spr_dat_o;
assign or1200_cpu_spr_cs = or1200_cpu_or1200_sprs_spr_cs;
assign or1200_cpu_spr_we = or1200_cpu_or1200_sprs_spr_we;
assign or1200_cpu_or1200_sprs_du_addr = or1200_cpu_du_addr;
assign or1200_cpu_or1200_sprs_du_dat_du = or1200_cpu_du_dat_du;
assign or1200_cpu_or1200_sprs_du_read = or1200_cpu_du_read;
assign or1200_cpu_or1200_sprs_du_write = or1200_cpu_du_write;
assign or1200_cpu_du_dat_cpu = or1200_cpu_or1200_sprs_du_dat_cpu;
  
  
wire  or1200_cpu_or1200_lsu_clk;
wire  or1200_cpu_or1200_lsu_rst;
wire [31:0] or1200_cpu_or1200_lsu_id_addrbase;
wire [31:0] or1200_cpu_or1200_lsu_ex_addrbase;
wire [31:0] or1200_cpu_or1200_lsu_id_addrofs;
wire [31:0] or1200_cpu_or1200_lsu_ex_addrofs;
wire [4-1:0] or1200_cpu_or1200_lsu_id_lsu_op;
wire [ or1200_cpu_or1200_lsu_dw -1:0] or1200_cpu_or1200_lsu_lsu_datain;
wire [ or1200_cpu_or1200_lsu_dw -1:0] or1200_cpu_or1200_lsu_lsu_dataout;
wire  or1200_cpu_or1200_lsu_lsu_stall;
wire  or1200_cpu_or1200_lsu_lsu_unstall;
wire  or1200_cpu_or1200_lsu_du_stall;
reg  or1200_cpu_or1200_lsu_except_align;
wire  or1200_cpu_or1200_lsu_except_dtlbmiss;
wire  or1200_cpu_or1200_lsu_except_dmmufault;
wire  or1200_cpu_or1200_lsu_except_dbuserr;
wire  or1200_cpu_or1200_lsu_id_freeze;
wire  or1200_cpu_or1200_lsu_ex_freeze;
wire  or1200_cpu_or1200_lsu_flushpipe;
wire [31:0] or1200_cpu_or1200_lsu_dcpu_adr_o;
wire  or1200_cpu_or1200_lsu_dcpu_cycstb_o;
wire  or1200_cpu_or1200_lsu_dcpu_we_o;
reg [3:0] or1200_cpu_or1200_lsu_dcpu_sel_o;
wire [3:0] or1200_cpu_or1200_lsu_dcpu_tag_o;
wire [31:0] or1200_cpu_or1200_lsu_dcpu_dat_o;
wire [31:0] or1200_cpu_or1200_lsu_dcpu_dat_i;
wire  or1200_cpu_or1200_lsu_dcpu_ack_i;
wire  or1200_cpu_or1200_lsu_dcpu_rty_i;
wire  or1200_cpu_or1200_lsu_dcpu_err_i;
wire [3:0] or1200_cpu_or1200_lsu_dcpu_tag_i;
 
   reg[4-1:0]  or1200_cpu_or1200_lsu_ex_lsu_op  ; 
   wire[2:0]  or1200_cpu_or1200_lsu_id_precalc_sum  ; 
   reg[2:0]  or1200_cpu_or1200_lsu_dcpu_adr_r  ; 
  always @(  posedge    or1200_cpu_or1200_lsu_clk          or  posedge   or1200_cpu_or1200_lsu_rst  )
       begin 
         if (  or1200_cpu_or1200_lsu_rst  ==(1'b1)) 
             or1200_cpu_or1200_lsu_ex_lsu_op   <=4'b0000;
          else 
            if (!  or1200_cpu_or1200_lsu_ex_freeze  &  or1200_cpu_or1200_lsu_id_freeze  |  or1200_cpu_or1200_lsu_flushpipe  ) 
                or1200_cpu_or1200_lsu_ex_lsu_op   <=4'b0000;
             else 
               if (!  or1200_cpu_or1200_lsu_ex_freeze  ) 
                   or1200_cpu_or1200_lsu_ex_lsu_op   <=  or1200_cpu_or1200_lsu_id_lsu_op  ;
       end
  
  assign   or1200_cpu_or1200_lsu_id_precalc_sum  =  or1200_cpu_or1200_lsu_id_addrbase  [2-1:0]+  or1200_cpu_or1200_lsu_id_addrofs  [2-1:0]; 
  always @(  posedge    or1200_cpu_or1200_lsu_clk          or  posedge   or1200_cpu_or1200_lsu_rst  )
       begin 
         if (  or1200_cpu_or1200_lsu_rst  ==(1'b1)) 
             or1200_cpu_or1200_lsu_dcpu_adr_r   <={2+1{1'b0}};
          else 
            if (!  or1200_cpu_or1200_lsu_ex_freeze  ) 
                or1200_cpu_or1200_lsu_dcpu_adr_r   <=  or1200_cpu_or1200_lsu_id_precalc_sum  ;
       end
  
  always @(  posedge    or1200_cpu_or1200_lsu_clk          or  posedge   or1200_cpu_or1200_lsu_rst  )
       begin 
         if (  or1200_cpu_or1200_lsu_rst  ==(1'b1)) 
             or1200_cpu_or1200_lsu_except_align   <=1'b0;
          else 
            if (!  or1200_cpu_or1200_lsu_ex_freeze  &  or1200_cpu_or1200_lsu_id_freeze  |  or1200_cpu_or1200_lsu_flushpipe  ) 
                or1200_cpu_or1200_lsu_except_align   <=1'b0;
             else 
               if (!  or1200_cpu_or1200_lsu_ex_freeze  ) 
                   or1200_cpu_or1200_lsu_except_align   <=((  or1200_cpu_or1200_lsu_id_lsu_op  ==4'b1100)|(  or1200_cpu_or1200_lsu_id_lsu_op  ==4'b0100)|(  or1200_cpu_or1200_lsu_id_lsu_op  ==4'b0101))&  or1200_cpu_or1200_lsu_id_precalc_sum  [0]|((  or1200_cpu_or1200_lsu_id_lsu_op  ==4'b1110)|(  or1200_cpu_or1200_lsu_id_lsu_op  ==4'b0110)|(  or1200_cpu_or1200_lsu_id_lsu_op  ==4'b0111))&|  or1200_cpu_or1200_lsu_id_precalc_sum  [1:0];
       end
  
  assign   or1200_cpu_or1200_lsu_lsu_stall  =  or1200_cpu_or1200_lsu_dcpu_rty_i  &  or1200_cpu_or1200_lsu_dcpu_cycstb_o  ; 
  assign   or1200_cpu_or1200_lsu_lsu_unstall  =  or1200_cpu_or1200_lsu_dcpu_ack_i  ; 
  assign   or1200_cpu_or1200_lsu_except_dtlbmiss  =  or1200_cpu_or1200_lsu_dcpu_err_i  &(  or1200_cpu_or1200_lsu_dcpu_tag_i  ==4'hd); 
  assign   or1200_cpu_or1200_lsu_except_dmmufault  =  or1200_cpu_or1200_lsu_dcpu_err_i  &(  or1200_cpu_or1200_lsu_dcpu_tag_i  ==4'hc); 
  assign   or1200_cpu_or1200_lsu_except_dbuserr  =  or1200_cpu_or1200_lsu_dcpu_err_i  &(  or1200_cpu_or1200_lsu_dcpu_tag_i  ==4'hb); 
  assign   or1200_cpu_or1200_lsu_dcpu_adr_o  [31:2]=  or1200_cpu_or1200_lsu_ex_addrbase  [31:2]+(  or1200_cpu_or1200_lsu_ex_addrofs  [31:2]+{{(32-2)-1{1'b0}},  or1200_cpu_or1200_lsu_dcpu_adr_r  [2]}); 
  assign   or1200_cpu_or1200_lsu_dcpu_adr_o  [2-1:0]=  or1200_cpu_or1200_lsu_dcpu_adr_r  [2-1:0]; 
  assign   or1200_cpu_or1200_lsu_dcpu_cycstb_o  =  or1200_cpu_or1200_lsu_du_stall  |  or1200_cpu_or1200_lsu_lsu_unstall  |  or1200_cpu_or1200_lsu_except_align  ?1'b0:|  or1200_cpu_or1200_lsu_ex_lsu_op  ; 
  assign   or1200_cpu_or1200_lsu_dcpu_we_o  =  or1200_cpu_or1200_lsu_ex_lsu_op  [3]; 
  assign   or1200_cpu_or1200_lsu_dcpu_tag_o  =  or1200_cpu_or1200_lsu_dcpu_cycstb_o  ?4'h1:4'h0; 
  always @(    or1200_cpu_or1200_lsu_ex_lsu_op            or    or1200_cpu_or1200_lsu_dcpu_adr_o   )
       casez ({  or1200_cpu_or1200_lsu_ex_lsu_op  ,  or1200_cpu_or1200_lsu_dcpu_adr_o  [1:0]})
        { 4'b1010,2'b00}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b1000;
        { 4'b1010,2'b01}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b0100;
        { 4'b1010,2'b10}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b0010;
        { 4'b1010,2'b11}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b0001;
        { 4'b1100,2'b00}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b1100;
        { 4'b1100,2'b10}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b0011;
        { 4'b1110,2'b00}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b1111;
        { 4'b0010,2'b00},{4'b0011,2'b00}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b1000;
        { 4'b0010,2'b01},{4'b0011,2'b01}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b0100;
        { 4'b0010,2'b10},{4'b0011,2'b10}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b0010;
        { 4'b0010,2'b11},{4'b0011,2'b11}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b0001;
        { 4'b0100,2'b00},{4'b0101,2'b00}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b1100;
        { 4'b0100,2'b10},{4'b0101,2'b10}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b0011;
        { 4'b0110,2'b00},{4'b0111,2'b00}: 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b1111;
        default : 
            or1200_cpu_or1200_lsu_dcpu_sel_o   =4'b0000;
       endcase
   
  
wire [1:0] or1200_cpu_or1200_lsu_or1200_mem2reg_addr;
wire [4-1:0] or1200_cpu_or1200_lsu_or1200_mem2reg_lsu_op;
wire [ or1200_cpu_or1200_lsu_or1200_mem2reg_width -1:0] or1200_cpu_or1200_lsu_or1200_mem2reg_memdata;
reg [ or1200_cpu_or1200_lsu_or1200_mem2reg_width -1:0] or1200_cpu_or1200_lsu_or1200_mem2reg_regdata;
 
   reg[  or1200_cpu_or1200_lsu_or1200_mem2reg_width  -1:0]  or1200_cpu_or1200_lsu_or1200_mem2reg_aligned  ; 
  always @(    or1200_cpu_or1200_lsu_or1200_mem2reg_addr            or    or1200_cpu_or1200_lsu_or1200_mem2reg_memdata   )
       begin 
         case (  or1200_cpu_or1200_lsu_or1200_mem2reg_addr  )
          2 'b00: 
              or1200_cpu_or1200_lsu_or1200_mem2reg_aligned   =  or1200_cpu_or1200_lsu_or1200_mem2reg_memdata  ;
          2 'b01: 
              or1200_cpu_or1200_lsu_or1200_mem2reg_aligned   ={  or1200_cpu_or1200_lsu_or1200_mem2reg_memdata  [23:0],8'b0};
          2 'b10: 
              or1200_cpu_or1200_lsu_or1200_mem2reg_aligned   ={  or1200_cpu_or1200_lsu_or1200_mem2reg_memdata  [15:0],16'b0};
          2 'b11: 
              or1200_cpu_or1200_lsu_or1200_mem2reg_aligned   ={  or1200_cpu_or1200_lsu_or1200_mem2reg_memdata  [7:0],24'b0};
         endcase 
       end
  
  always @(    or1200_cpu_or1200_lsu_or1200_mem2reg_lsu_op            or    or1200_cpu_or1200_lsu_or1200_mem2reg_aligned   )
       begin 
         case (  or1200_cpu_or1200_lsu_or1200_mem2reg_lsu_op  )
          4 'b0010:
             begin  
                or1200_cpu_or1200_lsu_or1200_mem2reg_regdata   [7:0]=  or1200_cpu_or1200_lsu_or1200_mem2reg_aligned  [31:24]; 
                or1200_cpu_or1200_lsu_or1200_mem2reg_regdata   [31:8]=24'b0;
             end 
          4 'b0011:
             begin  
                or1200_cpu_or1200_lsu_or1200_mem2reg_regdata   [7:0]=  or1200_cpu_or1200_lsu_or1200_mem2reg_aligned  [31:24]; 
                or1200_cpu_or1200_lsu_or1200_mem2reg_regdata   [31:8]={24{  or1200_cpu_or1200_lsu_or1200_mem2reg_aligned  [31]}};
             end 
          4 'b0100:
             begin  
                or1200_cpu_or1200_lsu_or1200_mem2reg_regdata   [15:0]=  or1200_cpu_or1200_lsu_or1200_mem2reg_aligned  [31:16]; 
                or1200_cpu_or1200_lsu_or1200_mem2reg_regdata   [31:16]=16'b0;
             end 
          4 'b0101:
             begin  
                or1200_cpu_or1200_lsu_or1200_mem2reg_regdata   [15:0]=  or1200_cpu_or1200_lsu_or1200_mem2reg_aligned  [31:16]; 
                or1200_cpu_or1200_lsu_or1200_mem2reg_regdata   [31:16]={16{  or1200_cpu_or1200_lsu_or1200_mem2reg_aligned  [31]}};
             end 
          default : 
              or1200_cpu_or1200_lsu_or1200_mem2reg_regdata   =  or1200_cpu_or1200_lsu_or1200_mem2reg_aligned  ;
         endcase 
       end
 
assign or1200_cpu_or1200_lsu_or1200_mem2reg_addr = or1200_cpu_or1200_lsu_dcpu_adr_o[1:0];
assign or1200_cpu_or1200_lsu_or1200_mem2reg_lsu_op = or1200_cpu_or1200_lsu_ex_lsu_op;
assign or1200_cpu_or1200_lsu_or1200_mem2reg_memdata = or1200_cpu_or1200_lsu_dcpu_dat_i;
assign or1200_cpu_or1200_lsu_lsu_dataout = or1200_cpu_or1200_lsu_or1200_mem2reg_regdata;
  
  
wire [1:0] or1200_cpu_or1200_lsu_or1200_reg2mem_addr;
wire [4-1:0] or1200_cpu_or1200_lsu_or1200_reg2mem_lsu_op;
wire [ or1200_cpu_or1200_lsu_or1200_reg2mem_width -1:0] or1200_cpu_or1200_lsu_or1200_reg2mem_regdata;
wire [ or1200_cpu_or1200_lsu_or1200_reg2mem_width -1:0] or1200_cpu_or1200_lsu_or1200_reg2mem_memdata;
 
   reg[7:0]  or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_hh  ; 
   reg[7:0]  or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_hl  ; 
   reg[7:0]  or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_lh  ; 
   reg[7:0]  or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_ll  ; 
  assign   or1200_cpu_or1200_lsu_or1200_reg2mem_memdata  ={  or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_hh  ,  or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_hl  ,  or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_lh  ,  or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_ll  }; 
  always @(     or1200_cpu_or1200_lsu_or1200_reg2mem_lsu_op              or    or1200_cpu_or1200_lsu_or1200_reg2mem_addr           or    or1200_cpu_or1200_lsu_or1200_reg2mem_regdata   )
       begin 
         casez ({  or1200_cpu_or1200_lsu_or1200_reg2mem_lsu_op  ,  or1200_cpu_or1200_lsu_or1200_reg2mem_addr  [1:0]})
          { 4'b1010,2'b00}: 
              or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_hh   =  or1200_cpu_or1200_lsu_or1200_reg2mem_regdata  [7:0];
          { 4'b1100,2'b00}: 
              or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_hh   =  or1200_cpu_or1200_lsu_or1200_reg2mem_regdata  [15:8];
          default : 
              or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_hh   =  or1200_cpu_or1200_lsu_or1200_reg2mem_regdata  [31:24];
         endcase 
       end
  
  always @(     or1200_cpu_or1200_lsu_or1200_reg2mem_lsu_op              or    or1200_cpu_or1200_lsu_or1200_reg2mem_addr           or    or1200_cpu_or1200_lsu_or1200_reg2mem_regdata   )
       begin 
         casez ({  or1200_cpu_or1200_lsu_or1200_reg2mem_lsu_op  ,  or1200_cpu_or1200_lsu_or1200_reg2mem_addr  [1:0]})
          { 4'b1110,2'b00}: 
              or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_hl   =  or1200_cpu_or1200_lsu_or1200_reg2mem_regdata  [23:16];
          default : 
              or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_hl   =  or1200_cpu_or1200_lsu_or1200_reg2mem_regdata  [7:0];
         endcase 
       end
  
  always @(     or1200_cpu_or1200_lsu_or1200_reg2mem_lsu_op              or    or1200_cpu_or1200_lsu_or1200_reg2mem_addr           or    or1200_cpu_or1200_lsu_or1200_reg2mem_regdata   )
       begin 
         casez ({  or1200_cpu_or1200_lsu_or1200_reg2mem_lsu_op  ,  or1200_cpu_or1200_lsu_or1200_reg2mem_addr  [1:0]})
          { 4'b1010,2'b10}: 
              or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_lh   =  or1200_cpu_or1200_lsu_or1200_reg2mem_regdata  [7:0];
          default : 
              or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_lh   =  or1200_cpu_or1200_lsu_or1200_reg2mem_regdata  [15:8];
         endcase 
       end
  
  always @(   or1200_cpu_or1200_lsu_or1200_reg2mem_regdata   ) 
        or1200_cpu_or1200_lsu_or1200_reg2mem_memdata_ll   =  or1200_cpu_or1200_lsu_or1200_reg2mem_regdata  [7:0];

assign or1200_cpu_or1200_lsu_or1200_reg2mem_addr = or1200_cpu_or1200_lsu_dcpu_adr_o[1:0];
assign or1200_cpu_or1200_lsu_or1200_reg2mem_lsu_op = or1200_cpu_or1200_lsu_ex_lsu_op;
assign or1200_cpu_or1200_lsu_or1200_reg2mem_regdata = or1200_cpu_or1200_lsu_lsu_datain;
assign or1200_cpu_or1200_lsu_dcpu_dat_o = or1200_cpu_or1200_lsu_or1200_reg2mem_memdata;

assign or1200_cpu_or1200_lsu_clk = or1200_cpu_clk;
assign or1200_cpu_or1200_lsu_rst = or1200_cpu_rst;
assign or1200_cpu_or1200_lsu_id_addrbase = or1200_cpu_muxed_a;
assign or1200_cpu_or1200_lsu_ex_addrbase = or1200_cpu_operand_a;
assign or1200_cpu_or1200_lsu_id_addrofs = or1200_cpu_id_simm;
assign or1200_cpu_or1200_lsu_ex_addrofs = or1200_cpu_ex_simm;
assign or1200_cpu_or1200_lsu_id_lsu_op = or1200_cpu_id_lsu_op;
assign or1200_cpu_or1200_lsu_lsu_datain = or1200_cpu_operand_b;
assign or1200_cpu_lsu_dataout = or1200_cpu_or1200_lsu_lsu_dataout;
assign or1200_cpu_lsu_stall = or1200_cpu_or1200_lsu_lsu_stall;
assign or1200_cpu_lsu_unstall = or1200_cpu_or1200_lsu_lsu_unstall;
assign or1200_cpu_or1200_lsu_du_stall = or1200_cpu_du_stall;
assign or1200_cpu_except_align = or1200_cpu_or1200_lsu_except_align;
assign or1200_cpu_except_dtlbmiss = or1200_cpu_or1200_lsu_except_dtlbmiss;
assign or1200_cpu_except_dmmufault = or1200_cpu_or1200_lsu_except_dmmufault;
assign or1200_cpu_except_dbuserr = or1200_cpu_or1200_lsu_except_dbuserr;
assign or1200_cpu_or1200_lsu_id_freeze = or1200_cpu_id_freeze;
assign or1200_cpu_or1200_lsu_ex_freeze = or1200_cpu_ex_freeze;
assign or1200_cpu_or1200_lsu_flushpipe = or1200_cpu_ex_flushpipe;
assign or1200_cpu_dcpu_adr_o = or1200_cpu_or1200_lsu_dcpu_adr_o;
assign or1200_cpu_dcpu_cycstb_o = or1200_cpu_or1200_lsu_dcpu_cycstb_o;
assign or1200_cpu_dcpu_we_o = or1200_cpu_or1200_lsu_dcpu_we_o;
assign or1200_cpu_dcpu_sel_o = or1200_cpu_or1200_lsu_dcpu_sel_o;
assign or1200_cpu_dcpu_tag_o = or1200_cpu_or1200_lsu_dcpu_tag_o;
assign or1200_cpu_dcpu_dat_o = or1200_cpu_or1200_lsu_dcpu_dat_o;
assign or1200_cpu_or1200_lsu_dcpu_dat_i = or1200_cpu_dcpu_dat_i;
assign or1200_cpu_or1200_lsu_dcpu_ack_i = or1200_cpu_dcpu_ack_i;
assign or1200_cpu_or1200_lsu_dcpu_rty_i = or1200_cpu_dcpu_rty_i;
assign or1200_cpu_or1200_lsu_dcpu_err_i = or1200_cpu_dcpu_err_i;
assign or1200_cpu_or1200_lsu_dcpu_tag_i = or1200_cpu_dcpu_tag_i;
  
  
wire  or1200_cpu_or1200_wbmux_clk;
wire  or1200_cpu_or1200_wbmux_rst;
wire  or1200_cpu_or1200_wbmux_wb_freeze;
wire [4-1:0] or1200_cpu_or1200_wbmux_rfwb_op;
wire [ or1200_cpu_or1200_wbmux_width -1:0] or1200_cpu_or1200_wbmux_muxin_a;
wire [ or1200_cpu_or1200_wbmux_width -1:0] or1200_cpu_or1200_wbmux_muxin_b;
wire [ or1200_cpu_or1200_wbmux_width -1:0] or1200_cpu_or1200_wbmux_muxin_c;
wire [ or1200_cpu_or1200_wbmux_width -1:0] or1200_cpu_or1200_wbmux_muxin_d;
wire [ or1200_cpu_or1200_wbmux_width -1:0] or1200_cpu_or1200_wbmux_muxin_e;
reg [ or1200_cpu_or1200_wbmux_width -1:0] or1200_cpu_or1200_wbmux_muxout;
reg [ or1200_cpu_or1200_wbmux_width -1:0] or1200_cpu_or1200_wbmux_muxreg;
reg  or1200_cpu_or1200_wbmux_muxreg_valid;
 
  always @(  posedge    or1200_cpu_or1200_wbmux_clk          or  posedge   or1200_cpu_or1200_wbmux_rst  )
       begin 
         if (  or1200_cpu_or1200_wbmux_rst  ==(1'b1))
            begin  
               or1200_cpu_or1200_wbmux_muxreg   <=32'd0; 
               or1200_cpu_or1200_wbmux_muxreg_valid   <=1'b0;
            end 
          else 
            if (!  or1200_cpu_or1200_wbmux_wb_freeze  )
               begin  
                  or1200_cpu_or1200_wbmux_muxreg   <=  or1200_cpu_or1200_wbmux_muxout  ; 
                  or1200_cpu_or1200_wbmux_muxreg_valid   <=  or1200_cpu_or1200_wbmux_rfwb_op  [0];
               end 
       end
  
  always @(        or1200_cpu_or1200_wbmux_muxin_a                    or    or1200_cpu_or1200_wbmux_muxin_b              or    or1200_cpu_or1200_wbmux_muxin_c             or    or1200_cpu_or1200_wbmux_muxin_d            or    or1200_cpu_or1200_wbmux_muxin_e           or    or1200_cpu_or1200_wbmux_rfwb_op   )
       begin 
         casez (  or1200_cpu_or1200_wbmux_rfwb_op  [4-1:1])
          3 'b000: 
              or1200_cpu_or1200_wbmux_muxout   =  or1200_cpu_or1200_wbmux_muxin_a  ;
          3 'b001:
             begin  
                or1200_cpu_or1200_wbmux_muxout   =  or1200_cpu_or1200_wbmux_muxin_b  ;
             end 
          3 'b010:
             begin  
                or1200_cpu_or1200_wbmux_muxout   =  or1200_cpu_or1200_wbmux_muxin_c  ;
             end 
          3 'b011:
             begin  
                or1200_cpu_or1200_wbmux_muxout   =  or1200_cpu_or1200_wbmux_muxin_d  +32'h8;
             end 
          default :
             begin  
                or1200_cpu_or1200_wbmux_muxout   =0;
             end 
         endcase 
       end
 
assign or1200_cpu_or1200_wbmux_clk = or1200_cpu_clk;
assign or1200_cpu_or1200_wbmux_rst = or1200_cpu_rst;
assign or1200_cpu_or1200_wbmux_wb_freeze = or1200_cpu_wb_freeze;
assign or1200_cpu_or1200_wbmux_rfwb_op = or1200_cpu_rfwb_op;
assign or1200_cpu_or1200_wbmux_muxin_a = or1200_cpu_alu_dataout;
assign or1200_cpu_or1200_wbmux_muxin_b = or1200_cpu_lsu_dataout;
assign or1200_cpu_or1200_wbmux_muxin_c = or1200_cpu_sprs_dataout;
assign or1200_cpu_or1200_wbmux_muxin_d = or1200_cpu_ex_pc;
assign or1200_cpu_or1200_wbmux_muxin_e = or1200_cpu_fpu_dataout;
assign or1200_cpu_rf_dataw = or1200_cpu_or1200_wbmux_muxout;
assign or1200_cpu_wb_forw = or1200_cpu_or1200_wbmux_muxreg;
assign or1200_cpu_wbforw_valid = or1200_cpu_or1200_wbmux_muxreg_valid;
  
  
wire  or1200_cpu_or1200_freeze_clk;
wire  or1200_cpu_or1200_freeze_rst;
wire [3-1:0] or1200_cpu_or1200_freeze_multicycle;
wire [2-1:0] or1200_cpu_or1200_freeze_wait_on;
wire  or1200_cpu_or1200_freeze_flushpipe;
wire  or1200_cpu_or1200_freeze_extend_flush;
wire  or1200_cpu_or1200_freeze_lsu_stall;
wire  or1200_cpu_or1200_freeze_if_stall;
wire  or1200_cpu_or1200_freeze_lsu_unstall;
wire  or1200_cpu_or1200_freeze_du_stall;
wire  or1200_cpu_or1200_freeze_mac_stall;
wire  or1200_cpu_or1200_freeze_force_dslot_fetch;
wire  or1200_cpu_or1200_freeze_abort_ex;
wire  or1200_cpu_or1200_freeze_genpc_freeze;
wire  or1200_cpu_or1200_freeze_if_freeze;
wire  or1200_cpu_or1200_freeze_id_freeze;
wire  or1200_cpu_or1200_freeze_ex_freeze;
wire  or1200_cpu_or1200_freeze_wb_freeze;
wire  or1200_cpu_or1200_freeze_saving_if_insn;
wire  or1200_cpu_or1200_freeze_fpu_done;
wire  or1200_cpu_or1200_freeze_mtspr_done;
wire  or1200_cpu_or1200_freeze_icpu_ack_i;
wire  or1200_cpu_or1200_freeze_icpu_err_i;
 
   wire  or1200_cpu_or1200_freeze_multicycle_freeze  ; 
   reg[3-1:0]  or1200_cpu_or1200_freeze_multicycle_cnt  ; 
   reg  or1200_cpu_or1200_freeze_flushpipe_r  ; 
   reg[2-1:0]  or1200_cpu_or1200_freeze_waiting_on  ; 
  assign   or1200_cpu_or1200_freeze_genpc_freeze  =(  or1200_cpu_or1200_freeze_du_stall  &!  or1200_cpu_or1200_freeze_saving_if_insn  )|  or1200_cpu_or1200_freeze_flushpipe_r  ; 
  assign   or1200_cpu_or1200_freeze_if_freeze  =  or1200_cpu_or1200_freeze_id_freeze  |  or1200_cpu_or1200_freeze_extend_flush  ; 
  assign   or1200_cpu_or1200_freeze_id_freeze  =(  or1200_cpu_or1200_freeze_lsu_stall  |(~  or1200_cpu_or1200_freeze_lsu_unstall  &  or1200_cpu_or1200_freeze_if_stall  )|  or1200_cpu_or1200_freeze_multicycle_freeze  |(|  or1200_cpu_or1200_freeze_waiting_on  )|  or1200_cpu_or1200_freeze_force_dslot_fetch  )|  or1200_cpu_or1200_freeze_du_stall  ; 
  assign   or1200_cpu_or1200_freeze_ex_freeze  =  or1200_cpu_or1200_freeze_wb_freeze  ; 
  assign   or1200_cpu_or1200_freeze_wb_freeze  =(  or1200_cpu_or1200_freeze_lsu_stall  |(~  or1200_cpu_or1200_freeze_lsu_unstall  &  or1200_cpu_or1200_freeze_if_stall  )|  or1200_cpu_or1200_freeze_multicycle_freeze  |(|  or1200_cpu_or1200_freeze_waiting_on  ))|  or1200_cpu_or1200_freeze_du_stall  |  or1200_cpu_or1200_freeze_abort_ex  ; 
  always @(  posedge    or1200_cpu_or1200_freeze_clk          or  posedge   or1200_cpu_or1200_freeze_rst  )
       if (  or1200_cpu_or1200_freeze_rst  ==(1'b1)) 
           or1200_cpu_or1200_freeze_flushpipe_r   <=1'b0;
        else 
          if (  or1200_cpu_or1200_freeze_icpu_ack_i  |  or1200_cpu_or1200_freeze_icpu_err_i  ) 
              or1200_cpu_or1200_freeze_flushpipe_r   <=  or1200_cpu_or1200_freeze_flushpipe  ;
           else 
             if (!  or1200_cpu_or1200_freeze_flushpipe  ) 
                 or1200_cpu_or1200_freeze_flushpipe_r   <=1'b0;
 
  assign   or1200_cpu_or1200_freeze_multicycle_freeze  =|  or1200_cpu_or1200_freeze_multicycle_cnt  ; 
  always @(  posedge    or1200_cpu_or1200_freeze_clk          or  posedge   or1200_cpu_or1200_freeze_rst  )
       if (  or1200_cpu_or1200_freeze_rst  ==(1'b1)) 
           or1200_cpu_or1200_freeze_multicycle_cnt   <=3'd0;
        else 
          if (|  or1200_cpu_or1200_freeze_multicycle_cnt  ) 
              or1200_cpu_or1200_freeze_multicycle_cnt   <=  or1200_cpu_or1200_freeze_multicycle_cnt  -3'd1;
           else 
             if (|  or1200_cpu_or1200_freeze_multicycle  &!  or1200_cpu_or1200_freeze_ex_freeze  ) 
                 or1200_cpu_or1200_freeze_multicycle_cnt   <=  or1200_cpu_or1200_freeze_multicycle  ;
 
  always @(  posedge    or1200_cpu_or1200_freeze_clk          or  posedge   or1200_cpu_or1200_freeze_rst  )
       if (  or1200_cpu_or1200_freeze_rst  ==(1'b1)) 
           or1200_cpu_or1200_freeze_waiting_on   <=0;
        else 
          if ((  or1200_cpu_or1200_freeze_waiting_on  ==2'd1)&!  or1200_cpu_or1200_freeze_mac_stall  ) 
              or1200_cpu_or1200_freeze_waiting_on   <=0;
           else 
             if ((  or1200_cpu_or1200_freeze_waiting_on  ==2'd2)&  or1200_cpu_or1200_freeze_fpu_done  ) 
                 or1200_cpu_or1200_freeze_waiting_on   <=0;
              else 
                if ((  or1200_cpu_or1200_freeze_waiting_on  ==2'd3)&  or1200_cpu_or1200_freeze_mtspr_done  ) 
                    or1200_cpu_or1200_freeze_waiting_on   <=0;
                 else 
                   if (!  or1200_cpu_or1200_freeze_ex_freeze  ) 
                       or1200_cpu_or1200_freeze_waiting_on   <=  or1200_cpu_or1200_freeze_wait_on  ;

assign or1200_cpu_or1200_freeze_clk = or1200_cpu_clk;
assign or1200_cpu_or1200_freeze_rst = or1200_cpu_rst;
assign or1200_cpu_or1200_freeze_multicycle = or1200_cpu_multicycle;
assign or1200_cpu_or1200_freeze_wait_on = or1200_cpu_wait_on;
assign or1200_cpu_or1200_freeze_flushpipe = or1200_cpu_wb_flushpipe;
assign or1200_cpu_or1200_freeze_extend_flush = or1200_cpu_extend_flush;
assign or1200_cpu_or1200_freeze_lsu_stall = or1200_cpu_lsu_stall;
assign or1200_cpu_or1200_freeze_if_stall = or1200_cpu_if_stall;
assign or1200_cpu_or1200_freeze_lsu_unstall = or1200_cpu_lsu_unstall;
assign or1200_cpu_or1200_freeze_du_stall = or1200_cpu_du_stall;
assign or1200_cpu_or1200_freeze_mac_stall = or1200_cpu_mult_mac_stall;
assign or1200_cpu_or1200_freeze_force_dslot_fetch = or1200_cpu_force_dslot_fetch;
assign or1200_cpu_or1200_freeze_abort_ex = or1200_cpu_abort_ex;
assign or1200_cpu_genpc_freeze = or1200_cpu_or1200_freeze_genpc_freeze;
assign or1200_cpu_if_freeze = or1200_cpu_or1200_freeze_if_freeze;
assign or1200_cpu_id_freeze = or1200_cpu_or1200_freeze_id_freeze;
assign or1200_cpu_ex_freeze = or1200_cpu_or1200_freeze_ex_freeze;
assign or1200_cpu_wb_freeze = or1200_cpu_or1200_freeze_wb_freeze;
assign or1200_cpu_or1200_freeze_saving_if_insn = or1200_cpu_saving_if_insn;
assign or1200_cpu_or1200_freeze_fpu_done = or1200_cpu_fpu_done;
assign or1200_cpu_or1200_freeze_mtspr_done = or1200_cpu_mtspr_done;
assign or1200_cpu_or1200_freeze_icpu_ack_i = or1200_cpu_icpu_ack_i;
assign or1200_cpu_or1200_freeze_icpu_err_i = or1200_cpu_icpu_err_i;
  
  
wire  or1200_cpu_or1200_except_clk;
wire  or1200_cpu_or1200_except_rst;
wire  or1200_cpu_or1200_except_sig_ibuserr;
wire  or1200_cpu_or1200_except_sig_dbuserr;
wire  or1200_cpu_or1200_except_sig_illegal;
wire  or1200_cpu_or1200_except_sig_align;
wire  or1200_cpu_or1200_except_sig_range;
wire  or1200_cpu_or1200_except_sig_dtlbmiss;
wire  or1200_cpu_or1200_except_sig_dmmufault;
wire  or1200_cpu_or1200_except_sig_int;
wire  or1200_cpu_or1200_except_sig_syscall;
wire  or1200_cpu_or1200_except_sig_trap;
wire  or1200_cpu_or1200_except_sig_itlbmiss;
wire  or1200_cpu_or1200_except_sig_immufault;
wire  or1200_cpu_or1200_except_sig_tick;
wire  or1200_cpu_or1200_except_ex_branch_taken;
wire  or1200_cpu_or1200_except_genpc_freeze;
wire  or1200_cpu_or1200_except_id_freeze;
wire  or1200_cpu_or1200_except_ex_freeze;
wire  or1200_cpu_or1200_except_wb_freeze;
wire  or1200_cpu_or1200_except_if_stall;
wire [31:0] or1200_cpu_or1200_except_if_pc;
reg [31:0] or1200_cpu_or1200_except_id_pc;
reg [31:0] or1200_cpu_or1200_except_ex_pc;
reg [31:0] or1200_cpu_or1200_except_wb_pc;
wire  or1200_cpu_or1200_except_id_flushpipe;
wire  or1200_cpu_or1200_except_ex_flushpipe;
reg  or1200_cpu_or1200_except_extend_flush;
wire  or1200_cpu_or1200_except_except_flushpipe;
reg [4-1:0] or1200_cpu_or1200_except_except_type;
wire  or1200_cpu_or1200_except_except_start;
wire  or1200_cpu_or1200_except_except_started;
wire [13:0] or1200_cpu_or1200_except_except_stop;
wire [13:0] or1200_cpu_or1200_except_except_trig;
wire  or1200_cpu_or1200_except_ex_void;
wire  or1200_cpu_or1200_except_abort_mvspr;
wire [3-1:0] or1200_cpu_or1200_except_branch_op;
wire [31:0] or1200_cpu_or1200_except_spr_dat_ppc;
wire [31:0] or1200_cpu_or1200_except_spr_dat_npc;
wire [31:0] or1200_cpu_or1200_except_datain;
wire [14-1:0] or1200_cpu_or1200_except_du_dsr;
wire  or1200_cpu_or1200_except_epcr_we;
wire  or1200_cpu_or1200_except_eear_we;
wire  or1200_cpu_or1200_except_esr_we;
wire  or1200_cpu_or1200_except_pc_we;
reg [31:0] or1200_cpu_or1200_except_epcr;
reg [31:0] or1200_cpu_or1200_except_eear;
wire [24:0] or1200_cpu_or1200_except_du_dmr1;
wire  or1200_cpu_or1200_except_du_hwbkpt;
wire  or1200_cpu_or1200_except_du_hwbkpt_ls_r;
reg [17-1:0] or1200_cpu_or1200_except_esr;
wire  or1200_cpu_or1200_except_sr_we;
wire [17-1:0] or1200_cpu_or1200_except_to_sr;
wire [17-1:0] or1200_cpu_or1200_except_sr;
wire [31:0] or1200_cpu_or1200_except_lsu_addr;
wire  or1200_cpu_or1200_except_abort_ex;
wire  or1200_cpu_or1200_except_icpu_ack_i;
wire  or1200_cpu_or1200_except_icpu_err_i;
wire  or1200_cpu_or1200_except_dcpu_ack_i;
wire  or1200_cpu_or1200_except_dcpu_err_i;
wire  or1200_cpu_or1200_except_sig_fp;
wire  or1200_cpu_or1200_except_fpcsr_fpee;
reg  or1200_cpu_or1200_except_dsx;
 
   reg  or1200_cpu_or1200_except_id_pc_val  ; 
   reg  or1200_cpu_or1200_except_ex_pc_val  ; 
   reg[31:0]  or1200_cpu_or1200_except_dl_pc  ; 
   reg[2:0]  or1200_cpu_or1200_except_id_exceptflags  ; 
   reg[2:0]  or1200_cpu_or1200_except_ex_exceptflags  ; 
   reg[3-1:0]  or1200_cpu_or1200_except_state  ; 
   reg  or1200_cpu_or1200_except_extend_flush_last  ; 
   reg  or1200_cpu_or1200_except_ex_dslot  ; 
   reg  or1200_cpu_or1200_except_delayed1_ex_dslot  ; 
   reg  or1200_cpu_or1200_except_delayed2_ex_dslot  ; 
   reg[2:0]  or1200_cpu_or1200_except_delayed_iee  ; 
   reg[2:0]  or1200_cpu_or1200_except_delayed_tee  ; 
   wire  or1200_cpu_or1200_except_int_pending  ; 
   wire  or1200_cpu_or1200_except_tick_pending  ; 
   wire  or1200_cpu_or1200_except_fp_pending  ; 
   wire  or1200_cpu_or1200_except_range_pending  ; 
   reg  or1200_cpu_or1200_except_trace_trap  ; 
   reg  or1200_cpu_or1200_except_ex_freeze_prev  ; 
   reg  or1200_cpu_or1200_except_sr_ted_prev  ; 
   reg  or1200_cpu_or1200_except_dsr_te_prev  ; 
   reg  or1200_cpu_or1200_except_dmr1_st_prev  ; 
   reg  or1200_cpu_or1200_except_dmr1_bt_prev  ; 
   wire  or1200_cpu_or1200_except_dsr_te  =  or1200_cpu_or1200_except_ex_freeze_prev  ?  or1200_cpu_or1200_except_dsr_te_prev  :  or1200_cpu_or1200_except_du_dsr  [13]; 
   wire  or1200_cpu_or1200_except_sr_ted  =  or1200_cpu_or1200_except_ex_freeze_prev  ?  or1200_cpu_or1200_except_sr_ted_prev  :  or1200_cpu_or1200_except_sr  [16]; 
   wire  or1200_cpu_or1200_except_dmr1_st  =  or1200_cpu_or1200_except_ex_freeze_prev  ?  or1200_cpu_or1200_except_dmr1_st_prev  :  or1200_cpu_or1200_except_du_dmr1  [22]; 
   wire  or1200_cpu_or1200_except_dmr1_bt  =  or1200_cpu_or1200_except_ex_freeze_prev  ?  or1200_cpu_or1200_except_dmr1_bt_prev  :  or1200_cpu_or1200_except_du_dmr1  [23]; 
  assign   or1200_cpu_or1200_except_except_started  =  or1200_cpu_or1200_except_extend_flush  &  or1200_cpu_or1200_except_except_start  ; 
  assign   or1200_cpu_or1200_except_except_start  =(  or1200_cpu_or1200_except_except_type  !=4'h0)&  or1200_cpu_or1200_except_extend_flush  ; 
  assign   or1200_cpu_or1200_except_int_pending  =  or1200_cpu_or1200_except_sig_int  &(  or1200_cpu_or1200_except_sr  [2]|(  or1200_cpu_or1200_except_sr_we  &  or1200_cpu_or1200_except_to_sr  [2]))&  or1200_cpu_or1200_except_id_pc_val  &  or1200_cpu_or1200_except_delayed_iee  [2]&~  or1200_cpu_or1200_except_ex_freeze  &~  or1200_cpu_or1200_except_ex_branch_taken  &~  or1200_cpu_or1200_except_ex_dslot  &~(  or1200_cpu_or1200_except_sr_we  &~  or1200_cpu_or1200_except_to_sr  [2]); 
  assign   or1200_cpu_or1200_except_tick_pending  =  or1200_cpu_or1200_except_sig_tick  &(  or1200_cpu_or1200_except_sr  [1]|(  or1200_cpu_or1200_except_sr_we  &  or1200_cpu_or1200_except_to_sr  [1]))&  or1200_cpu_or1200_except_id_pc_val  &  or1200_cpu_or1200_except_delayed_tee  [2]&~  or1200_cpu_or1200_except_ex_freeze  &~  or1200_cpu_or1200_except_ex_branch_taken  &~  or1200_cpu_or1200_except_ex_dslot  &~(  or1200_cpu_or1200_except_sr_we  &~  or1200_cpu_or1200_except_to_sr  [1]); 
  assign   or1200_cpu_or1200_except_fp_pending  =  or1200_cpu_or1200_except_sig_fp  &  or1200_cpu_or1200_except_fpcsr_fpee  &~  or1200_cpu_or1200_except_ex_freeze  &~  or1200_cpu_or1200_except_ex_branch_taken  &~  or1200_cpu_or1200_except_ex_dslot  ; 
  assign   or1200_cpu_or1200_except_range_pending  =  or1200_cpu_or1200_except_sig_range  &  or1200_cpu_or1200_except_sr  [12]&~  or1200_cpu_or1200_except_ex_freeze  &~  or1200_cpu_or1200_except_ex_branch_taken  &~  or1200_cpu_or1200_except_ex_dslot  ; 
  assign   or1200_cpu_or1200_except_abort_ex  =  or1200_cpu_or1200_except_sig_dbuserr  |  or1200_cpu_or1200_except_sig_dmmufault  |  or1200_cpu_or1200_except_sig_dtlbmiss  |  or1200_cpu_or1200_except_sig_align  |  or1200_cpu_or1200_except_sig_illegal  |((  or1200_cpu_or1200_except_du_hwbkpt  |  or1200_cpu_or1200_except_trace_trap  )&  or1200_cpu_or1200_except_ex_pc_val  &!  or1200_cpu_or1200_except_sr_ted  &!  or1200_cpu_or1200_except_dsr_te  ); 
  assign   or1200_cpu_or1200_except_abort_mvspr  =  or1200_cpu_or1200_except_sig_illegal  |((  or1200_cpu_or1200_except_du_hwbkpt  |  or1200_cpu_or1200_except_trace_trap  )&  or1200_cpu_or1200_except_ex_pc_val  &!  or1200_cpu_or1200_except_sr_ted  &!  or1200_cpu_or1200_except_dsr_te  ); 
  assign   or1200_cpu_or1200_except_spr_dat_ppc  =  or1200_cpu_or1200_except_wb_pc  ; 
  assign   or1200_cpu_or1200_except_spr_dat_npc  =  or1200_cpu_or1200_except_ex_void  ?  or1200_cpu_or1200_except_id_pc  :  or1200_cpu_or1200_except_ex_pc  ; 
  assign   or1200_cpu_or1200_except_except_trig  ={  or1200_cpu_or1200_except_ex_exceptflags  [1]&~  or1200_cpu_or1200_except_du_dsr  [9],  or1200_cpu_or1200_except_ex_exceptflags  [0]&~  or1200_cpu_or1200_except_du_dsr  [3],  or1200_cpu_or1200_except_ex_exceptflags  [2]&~  or1200_cpu_or1200_except_du_dsr  [1],  or1200_cpu_or1200_except_sig_illegal  &~  or1200_cpu_or1200_except_du_dsr  [6],  or1200_cpu_or1200_except_sig_align  &~  or1200_cpu_or1200_except_du_dsr  [5],  or1200_cpu_or1200_except_sig_dtlbmiss  &~  or1200_cpu_or1200_except_du_dsr  [8],  or1200_cpu_or1200_except_sig_trap  &~  or1200_cpu_or1200_except_du_dsr  [13],  or1200_cpu_or1200_except_sig_syscall  &~  or1200_cpu_or1200_except_du_dsr  [11]&~  or1200_cpu_or1200_except_ex_freeze  ,  or1200_cpu_or1200_except_sig_dmmufault  &~  or1200_cpu_or1200_except_du_dsr  [2],  or1200_cpu_or1200_except_sig_dbuserr  &~  or1200_cpu_or1200_except_du_dsr  [1],  or1200_cpu_or1200_except_range_pending  &~  or1200_cpu_or1200_except_du_dsr  [10],  or1200_cpu_or1200_except_fp_pending  &~  or1200_cpu_or1200_except_du_dsr  [12],  or1200_cpu_or1200_except_int_pending  &~  or1200_cpu_or1200_except_du_dsr  [7],  or1200_cpu_or1200_except_tick_pending  &~  or1200_cpu_or1200_except_du_dsr  [4]}; 
   wire  or1200_cpu_or1200_except_trace_cond  =!  or1200_cpu_or1200_except_ex_freeze  &&!  or1200_cpu_or1200_except_ex_void  &&(1'b0||  or1200_cpu_or1200_except_dmr1_st  ||((  or1200_cpu_or1200_except_branch_op  !=3'd0)&&(  or1200_cpu_or1200_except_branch_op  !=3'd6)&&  or1200_cpu_or1200_except_dmr1_bt  )); 
  assign   or1200_cpu_or1200_except_except_stop  ={  or1200_cpu_or1200_except_tick_pending  &  or1200_cpu_or1200_except_du_dsr  [4],  or1200_cpu_or1200_except_int_pending  &  or1200_cpu_or1200_except_du_dsr  [7],  or1200_cpu_or1200_except_ex_exceptflags  [1]&  or1200_cpu_or1200_except_du_dsr  [9],  or1200_cpu_or1200_except_ex_exceptflags  [0]&  or1200_cpu_or1200_except_du_dsr  [3],  or1200_cpu_or1200_except_ex_exceptflags  [2]&  or1200_cpu_or1200_except_du_dsr  [1],  or1200_cpu_or1200_except_sig_illegal  &  or1200_cpu_or1200_except_du_dsr  [6],  or1200_cpu_or1200_except_sig_align  &  or1200_cpu_or1200_except_du_dsr  [5],  or1200_cpu_or1200_except_sig_dtlbmiss  &  or1200_cpu_or1200_except_du_dsr  [8],  or1200_cpu_or1200_except_sig_dmmufault  &  or1200_cpu_or1200_except_du_dsr  [2],  or1200_cpu_or1200_except_sig_dbuserr  &  or1200_cpu_or1200_except_du_dsr  [1],  or1200_cpu_or1200_except_range_pending  &  or1200_cpu_or1200_except_du_dsr  [10],  or1200_cpu_or1200_except_sig_trap  &  or1200_cpu_or1200_except_du_dsr  [13],  or1200_cpu_or1200_except_fp_pending  &  or1200_cpu_or1200_except_du_dsr  [12],  or1200_cpu_or1200_except_sig_syscall  &  or1200_cpu_or1200_except_du_dsr  [11]&~  or1200_cpu_or1200_except_ex_freeze  }; 
  always @(  posedge    or1200_cpu_or1200_except_clk          or  posedge   or1200_cpu_or1200_except_rst  )
       begin 
         if (  or1200_cpu_or1200_except_rst  ==(1'b1))
            begin  
               or1200_cpu_or1200_except_trace_trap   <=1'b0;
            end 
          else 
            if (!(  or1200_cpu_or1200_except_trace_trap  &&!  or1200_cpu_or1200_except_ex_pc_val  ))
               begin  
                  or1200_cpu_or1200_except_trace_trap   <=  or1200_cpu_or1200_except_trace_cond  &!  or1200_cpu_or1200_except_dsr_te  &!  or1200_cpu_or1200_except_sr_ted  ;
               end 
       end
  
  always @(  posedge    or1200_cpu_or1200_except_clk          or  posedge   or1200_cpu_or1200_except_rst  )
       begin 
         if (  or1200_cpu_or1200_except_rst  ==(1'b1))
            begin  
               or1200_cpu_or1200_except_ex_freeze_prev   <=1'b0; 
               or1200_cpu_or1200_except_sr_ted_prev   <=1'b0; 
               or1200_cpu_or1200_except_dsr_te_prev   <=1'b0; 
               or1200_cpu_or1200_except_dmr1_st_prev   <=1'b0; 
               or1200_cpu_or1200_except_dmr1_bt_prev   <=1'b0;
            end 
          else 
            begin  
               or1200_cpu_or1200_except_ex_freeze_prev   <=  or1200_cpu_or1200_except_ex_freeze  ;
              if (!  or1200_cpu_or1200_except_ex_freeze_prev  ||  or1200_cpu_or1200_except_ex_void  )
                 begin  
                    or1200_cpu_or1200_except_sr_ted_prev   <=  or1200_cpu_or1200_except_sr  [16]; 
                    or1200_cpu_or1200_except_dsr_te_prev   <=  or1200_cpu_or1200_except_du_dsr  [13]; 
                    or1200_cpu_or1200_except_dmr1_st_prev   <=  or1200_cpu_or1200_except_du_dmr1  [22]; 
                    or1200_cpu_or1200_except_dmr1_bt_prev   <=  or1200_cpu_or1200_except_du_dmr1  [23];
                 end 
            end 
       end
  
  always @(  posedge    or1200_cpu_or1200_except_clk          or  posedge   or1200_cpu_or1200_except_rst  )
       begin 
         if (  or1200_cpu_or1200_except_rst  ==(1'b1))
            begin  
               or1200_cpu_or1200_except_id_pc   <=32'd0; 
               or1200_cpu_or1200_except_id_pc_val   <=1'b0; 
               or1200_cpu_or1200_except_id_exceptflags   <=3'b000;
            end 
          else 
            if (  or1200_cpu_or1200_except_id_flushpipe  )
               begin  
                  or1200_cpu_or1200_except_id_pc_val   <=1'b0; 
                  or1200_cpu_or1200_except_id_exceptflags   <=3'b000;
               end 
             else 
               if (!  or1200_cpu_or1200_except_id_freeze  )
                  begin  
                     or1200_cpu_or1200_except_id_pc   <=  or1200_cpu_or1200_except_if_pc  ; 
                     or1200_cpu_or1200_except_id_pc_val   <=1'b1; 
                     or1200_cpu_or1200_except_id_exceptflags   <={  or1200_cpu_or1200_except_sig_ibuserr  ,  or1200_cpu_or1200_except_sig_itlbmiss  ,  or1200_cpu_or1200_except_sig_immufault  };
                  end 
       end
  
  always @(  posedge    or1200_cpu_or1200_except_rst          or  posedge   or1200_cpu_or1200_except_clk  )
       if (  or1200_cpu_or1200_except_rst  ==(1'b1)) 
           or1200_cpu_or1200_except_delayed_iee   <=3'b000;
        else 
          if (!  or1200_cpu_or1200_except_sr  [2]) 
              or1200_cpu_or1200_except_delayed_iee   <=3'b000;
           else  
              or1200_cpu_or1200_except_delayed_iee   <={  or1200_cpu_or1200_except_delayed_iee  [1:0],1'b1};
 
  always @(  posedge    or1200_cpu_or1200_except_rst          or  posedge   or1200_cpu_or1200_except_clk  )
       if (  or1200_cpu_or1200_except_rst  ==(1'b1)) 
           or1200_cpu_or1200_except_delayed_tee   <=3'b000;
        else 
          if (!  or1200_cpu_or1200_except_sr  [1]) 
              or1200_cpu_or1200_except_delayed_tee   <=3'b000;
           else  
              or1200_cpu_or1200_except_delayed_tee   <={  or1200_cpu_or1200_except_delayed_tee  [1:0],1'b1};
 
  always @(  posedge    or1200_cpu_or1200_except_clk          or  posedge   or1200_cpu_or1200_except_rst  )
       begin 
         if (  or1200_cpu_or1200_except_rst  ==(1'b1))
            begin  
               or1200_cpu_or1200_except_ex_dslot   <=1'b0; 
               or1200_cpu_or1200_except_ex_pc   <=32'd0; 
               or1200_cpu_or1200_except_ex_pc_val   <=1'b0; 
               or1200_cpu_or1200_except_ex_exceptflags   <=3'b000; 
               or1200_cpu_or1200_except_delayed1_ex_dslot   <=1'b0; 
               or1200_cpu_or1200_except_delayed2_ex_dslot   <=1'b0;
            end 
          else 
            if (  or1200_cpu_or1200_except_ex_flushpipe  )
               begin  
                  or1200_cpu_or1200_except_ex_dslot   <=1'b0; 
                  or1200_cpu_or1200_except_ex_pc_val   <=1'b0; 
                  or1200_cpu_or1200_except_ex_exceptflags   <=3'b000; 
                  or1200_cpu_or1200_except_delayed1_ex_dslot   <=1'b0; 
                  or1200_cpu_or1200_except_delayed2_ex_dslot   <=1'b0;
               end 
             else 
               if (!  or1200_cpu_or1200_except_ex_freeze  &  or1200_cpu_or1200_except_id_freeze  )
                  begin  
                     or1200_cpu_or1200_except_ex_dslot   <=1'b0; 
                     or1200_cpu_or1200_except_ex_pc   <=  or1200_cpu_or1200_except_id_pc  ; 
                     or1200_cpu_or1200_except_ex_pc_val   <=  or1200_cpu_or1200_except_id_pc_val  ; 
                     or1200_cpu_or1200_except_ex_exceptflags   <=3'b000; 
                     or1200_cpu_or1200_except_delayed1_ex_dslot   <=  or1200_cpu_or1200_except_ex_dslot  ; 
                     or1200_cpu_or1200_except_delayed2_ex_dslot   <=  or1200_cpu_or1200_except_delayed1_ex_dslot  ;
                  end 
                else 
                  if (!  or1200_cpu_or1200_except_ex_freeze  )
                     begin  
                        or1200_cpu_or1200_except_ex_dslot   <=  or1200_cpu_or1200_except_ex_branch_taken  ; 
                        or1200_cpu_or1200_except_ex_pc   <=  or1200_cpu_or1200_except_id_pc  ; 
                        or1200_cpu_or1200_except_ex_pc_val   <=  or1200_cpu_or1200_except_id_pc_val  ; 
                        or1200_cpu_or1200_except_ex_exceptflags   <=  or1200_cpu_or1200_except_id_exceptflags  ; 
                        or1200_cpu_or1200_except_delayed1_ex_dslot   <=  or1200_cpu_or1200_except_ex_dslot  ; 
                        or1200_cpu_or1200_except_delayed2_ex_dslot   <=  or1200_cpu_or1200_except_delayed1_ex_dslot  ;
                     end 
       end
  
  always @(  posedge    or1200_cpu_or1200_except_clk          or  posedge   or1200_cpu_or1200_except_rst  )
       begin 
         if (  or1200_cpu_or1200_except_rst  ==(1'b1))
            begin  
               or1200_cpu_or1200_except_wb_pc   <=32'd0; 
               or1200_cpu_or1200_except_dl_pc   <=32'd0;
            end 
          else 
            if (!  or1200_cpu_or1200_except_wb_freeze  )
               begin  
                  or1200_cpu_or1200_except_wb_pc   <=  or1200_cpu_or1200_except_ex_pc  ; 
                  or1200_cpu_or1200_except_dl_pc   <=  or1200_cpu_or1200_except_wb_pc  ;
               end 
       end
  
  assign   or1200_cpu_or1200_except_except_flushpipe  =|  or1200_cpu_or1200_except_except_trig  &~|  or1200_cpu_or1200_except_state  ; 
  always @(  posedge    or1200_cpu_or1200_except_clk          or  posedge   or1200_cpu_or1200_except_rst  )
       begin 
         if (  or1200_cpu_or1200_except_rst  ==(1'b1))
            begin  
               or1200_cpu_or1200_except_state   <=3'd0; 
               or1200_cpu_or1200_except_except_type   <=4'h0; 
               or1200_cpu_or1200_except_extend_flush   <=1'b0; 
               or1200_cpu_or1200_except_epcr   <=32'b0; 
               or1200_cpu_or1200_except_eear   <=32'b0; 
               or1200_cpu_or1200_except_esr   <={2'h1,{17-3{1'b0}},1'b1}; 
               or1200_cpu_or1200_except_extend_flush_last   <=1'b0; 
               or1200_cpu_or1200_except_dsx   <=1'b0;
            end 
          else 
            begin 
              case (  or1200_cpu_or1200_except_state  )
               3 'd0:
                  if (  or1200_cpu_or1200_except_except_flushpipe  )
                     begin  
                        or1200_cpu_or1200_except_state   <=3'd1; 
                        or1200_cpu_or1200_except_extend_flush   <=1'b1; 
                        or1200_cpu_or1200_except_esr   <=  or1200_cpu_or1200_except_sr_we  ?  or1200_cpu_or1200_except_to_sr  :  or1200_cpu_or1200_except_sr  ;
                       casez (  or1200_cpu_or1200_except_except_trig  )
                        14 'b1?_????_????_????:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'ha; 
                              or1200_cpu_or1200_except_eear   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_ex_pc  :  or1200_cpu_or1200_except_ex_pc  ; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_wb_pc  :  or1200_cpu_or1200_except_ex_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b01_????_????_????:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'h4; 
                              or1200_cpu_or1200_except_eear   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_ex_pc  :  or1200_cpu_or1200_except_delayed1_ex_dslot  ?  or1200_cpu_or1200_except_id_pc  :  or1200_cpu_or1200_except_delayed2_ex_dslot  ?  or1200_cpu_or1200_except_id_pc  :  or1200_cpu_or1200_except_id_pc  ; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_wb_pc  :  or1200_cpu_or1200_except_delayed1_ex_dslot  ?  or1200_cpu_or1200_except_id_pc  :  or1200_cpu_or1200_except_delayed2_ex_dslot  ?  or1200_cpu_or1200_except_id_pc  :  or1200_cpu_or1200_except_id_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b00_1???_????_????:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'h2; 
                              or1200_cpu_or1200_except_eear   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_wb_pc  :  or1200_cpu_or1200_except_ex_pc  ; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_wb_pc  :  or1200_cpu_or1200_except_ex_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b00_01??_????_????:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'h7; 
                              or1200_cpu_or1200_except_eear   <=  or1200_cpu_or1200_except_ex_pc  ; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_wb_pc  :  or1200_cpu_or1200_except_ex_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b00_001?_????_????:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'h6; 
                              or1200_cpu_or1200_except_eear   <=  or1200_cpu_or1200_except_lsu_addr  ; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_wb_pc  :  or1200_cpu_or1200_except_ex_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b00_0001_????_????:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'h9; 
                              or1200_cpu_or1200_except_eear   <=  or1200_cpu_or1200_except_lsu_addr  ; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_wb_pc  :  or1200_cpu_or1200_except_delayed1_ex_dslot  ?  or1200_cpu_or1200_except_dl_pc  :  or1200_cpu_or1200_except_ex_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b00_0000_1???_????:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'he; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_wb_pc  :  or1200_cpu_or1200_except_delayed1_ex_dslot  ?  or1200_cpu_or1200_except_id_pc  :  or1200_cpu_or1200_except_ex_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b00_0000_01??_????:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'hc; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_wb_pc  :  or1200_cpu_or1200_except_delayed1_ex_dslot  ?  or1200_cpu_or1200_except_id_pc  :  or1200_cpu_or1200_except_delayed2_ex_dslot  ?  or1200_cpu_or1200_except_id_pc  :  or1200_cpu_or1200_except_id_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b00_0000_001?_????:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'h3; 
                              or1200_cpu_or1200_except_eear   <=  or1200_cpu_or1200_except_lsu_addr  ; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_wb_pc  :  or1200_cpu_or1200_except_delayed1_ex_dslot  ?  or1200_cpu_or1200_except_dl_pc  :  or1200_cpu_or1200_except_ex_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b00_0000_0001_????:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'h2; 
                              or1200_cpu_or1200_except_eear   <=  or1200_cpu_or1200_except_lsu_addr  ; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_wb_pc  :  or1200_cpu_or1200_except_delayed1_ex_dslot  ?  or1200_cpu_or1200_except_dl_pc  :  or1200_cpu_or1200_except_ex_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b00_0000_0000_1???:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'hb; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_ex_dslot  ?  or1200_cpu_or1200_except_wb_pc  :  or1200_cpu_or1200_except_delayed1_ex_dslot  ?  or1200_cpu_or1200_except_dl_pc  :  or1200_cpu_or1200_except_delayed2_ex_dslot  ?  or1200_cpu_or1200_except_id_pc  :  or1200_cpu_or1200_except_ex_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b00_0000_0000_01??:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'hd; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_id_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b00_0000_0000_001?:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'h8; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_id_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        14 'b00_0000_0000_0001:
                           begin  
                              or1200_cpu_or1200_except_except_type   <=4'h5; 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_id_pc  ; 
                              or1200_cpu_or1200_except_dsx   <=  or1200_cpu_or1200_except_ex_dslot  ;
                           end 
                        default : 
                            or1200_cpu_or1200_except_except_type   <=4'h0;
                       endcase 
                     end 
                   else 
                     if (  or1200_cpu_or1200_except_pc_we  )
                        begin  
                           or1200_cpu_or1200_except_state   <=3'd1; 
                           or1200_cpu_or1200_except_extend_flush   <=1'b1;
                        end 
                      else 
                        begin 
                          if (  or1200_cpu_or1200_except_epcr_we  ) 
                              or1200_cpu_or1200_except_epcr   <=  or1200_cpu_or1200_except_datain  ;
                          if (  or1200_cpu_or1200_except_eear_we  ) 
                              or1200_cpu_or1200_except_eear   <=  or1200_cpu_or1200_except_datain  ;
                          if (  or1200_cpu_or1200_except_esr_we  ) 
                              or1200_cpu_or1200_except_esr   <={  or1200_cpu_or1200_except_datain  [17-1],1'b1,  or1200_cpu_or1200_except_datain  [17-3:0]};
                        end 
               3 'd1:
                  if (  or1200_cpu_or1200_except_icpu_ack_i  |  or1200_cpu_or1200_except_icpu_err_i  |  or1200_cpu_or1200_except_genpc_freeze  ) 
                      or1200_cpu_or1200_except_state   <=3'd2;
               3 'd2:
                  if (  or1200_cpu_or1200_except_except_type  ==4'he)
                     begin  
                        or1200_cpu_or1200_except_state   <=3'd0; 
                        or1200_cpu_or1200_except_extend_flush   <=1'b0; 
                        or1200_cpu_or1200_except_extend_flush_last   <=1'b0; 
                        or1200_cpu_or1200_except_except_type   <=4'h0;
                     end 
                   else  
                      or1200_cpu_or1200_except_state   <=3'd3;
               3 'd3:
                  begin  
                     or1200_cpu_or1200_except_state   <=3'd4;
                  end 
               3 'd4:
                  begin  
                     or1200_cpu_or1200_except_state   <=3'd5; 
                     or1200_cpu_or1200_except_extend_flush   <=1'b0; 
                     or1200_cpu_or1200_except_extend_flush_last   <=1'b0;
                  end 
               default :
                  begin 
                    if (!  or1200_cpu_or1200_except_if_stall  &&!  or1200_cpu_or1200_except_id_freeze  )
                       begin  
                          or1200_cpu_or1200_except_state   <=3'd0; 
                          or1200_cpu_or1200_except_except_type   <=4'h0; 
                          or1200_cpu_or1200_except_extend_flush_last   <=1'b0;
                       end 
                  end 
              endcase 
            end 
       end
 
assign or1200_cpu_or1200_except_clk = or1200_cpu_clk;
assign or1200_cpu_or1200_except_rst = or1200_cpu_rst;
assign or1200_cpu_or1200_except_sig_ibuserr = or1200_cpu_except_ibuserr;
assign or1200_cpu_or1200_except_sig_dbuserr = or1200_cpu_except_dbuserr;
assign or1200_cpu_or1200_except_sig_illegal = or1200_cpu_except_illegal;
assign or1200_cpu_or1200_except_sig_align = or1200_cpu_except_align;
assign or1200_cpu_or1200_except_sig_range = or1200_cpu_sig_range;
assign or1200_cpu_or1200_except_sig_dtlbmiss = or1200_cpu_except_dtlbmiss;
assign or1200_cpu_or1200_except_sig_dmmufault = or1200_cpu_except_dmmufault;
assign or1200_cpu_or1200_except_sig_int = or1200_cpu_sig_int;
assign or1200_cpu_or1200_except_sig_syscall = or1200_cpu_sig_syscall;
assign or1200_cpu_or1200_except_sig_trap = or1200_cpu_sig_trap;
assign or1200_cpu_or1200_except_sig_itlbmiss = or1200_cpu_except_itlbmiss;
assign or1200_cpu_or1200_except_sig_immufault = or1200_cpu_except_immufault;
assign or1200_cpu_or1200_except_sig_tick = or1200_cpu_sig_tick;
assign or1200_cpu_or1200_except_ex_branch_taken = or1200_cpu_ex_branch_taken;
assign or1200_cpu_or1200_except_genpc_freeze = or1200_cpu_genpc_freeze;
assign or1200_cpu_or1200_except_id_freeze = or1200_cpu_id_freeze;
assign or1200_cpu_or1200_except_ex_freeze = or1200_cpu_ex_freeze;
assign or1200_cpu_or1200_except_wb_freeze = or1200_cpu_wb_freeze;
assign or1200_cpu_or1200_except_if_stall = or1200_cpu_if_stall;
assign or1200_cpu_or1200_except_if_pc = or1200_cpu_if_pc;
assign or1200_cpu_id_pc = or1200_cpu_or1200_except_id_pc;
assign or1200_cpu_ex_pc = or1200_cpu_or1200_except_ex_pc;
assign or1200_cpu_wb_pc = or1200_cpu_or1200_except_wb_pc;
assign or1200_cpu_or1200_except_id_flushpipe = or1200_cpu_id_flushpipe;
assign or1200_cpu_or1200_except_ex_flushpipe = or1200_cpu_ex_flushpipe;
assign or1200_cpu_extend_flush = or1200_cpu_or1200_except_extend_flush;
assign or1200_cpu_except_flushpipe = or1200_cpu_or1200_except_except_flushpipe;
assign or1200_cpu_except_type = or1200_cpu_or1200_except_except_type;
assign or1200_cpu_except_start = or1200_cpu_or1200_except_except_start;
assign or1200_cpu_except_started = or1200_cpu_or1200_except_except_started;
assign or1200_cpu_except_stop = or1200_cpu_or1200_except_except_stop;
assign or1200_cpu_except_trig = or1200_cpu_or1200_except_except_trig;
assign or1200_cpu_or1200_except_ex_void = or1200_cpu_ex_void;
assign or1200_cpu_abort_mvspr = or1200_cpu_or1200_except_abort_mvspr;
assign or1200_cpu_or1200_except_branch_op = or1200_cpu_branch_op;
assign or1200_cpu_spr_dat_ppc = or1200_cpu_or1200_except_spr_dat_ppc;
assign or1200_cpu_spr_dat_npc = or1200_cpu_or1200_except_spr_dat_npc;
assign or1200_cpu_or1200_except_datain = or1200_cpu_spr_dat_cpu;
assign or1200_cpu_or1200_except_du_dsr = or1200_cpu_du_dsr;
assign or1200_cpu_or1200_except_epcr_we = or1200_cpu_epcr_we;
assign or1200_cpu_or1200_except_eear_we = or1200_cpu_eear_we;
assign or1200_cpu_or1200_except_esr_we = or1200_cpu_esr_we;
assign or1200_cpu_or1200_except_pc_we = or1200_cpu_pc_we;
assign or1200_cpu_epcr = or1200_cpu_or1200_except_epcr;
assign or1200_cpu_eear = or1200_cpu_or1200_except_eear;
assign or1200_cpu_or1200_except_du_dmr1 = or1200_cpu_du_dmr1;
assign or1200_cpu_or1200_except_du_hwbkpt = or1200_cpu_du_hwbkpt;
assign or1200_cpu_or1200_except_du_hwbkpt_ls_r = or1200_cpu_du_hwbkpt_ls_r;
assign or1200_cpu_esr = or1200_cpu_or1200_except_esr;
assign or1200_cpu_or1200_except_sr_we = or1200_cpu_sr_we;
assign or1200_cpu_or1200_except_to_sr = or1200_cpu_to_sr;
assign or1200_cpu_or1200_except_sr = or1200_cpu_sr;
assign or1200_cpu_or1200_except_lsu_addr = or1200_cpu_dcpu_adr_o;
assign or1200_cpu_abort_ex = or1200_cpu_or1200_except_abort_ex;
assign or1200_cpu_or1200_except_icpu_ack_i = or1200_cpu_icpu_ack_i;
assign or1200_cpu_or1200_except_icpu_err_i = or1200_cpu_icpu_err_i;
assign or1200_cpu_or1200_except_dcpu_ack_i = or1200_cpu_dcpu_ack_i;
assign or1200_cpu_or1200_except_dcpu_err_i = or1200_cpu_dcpu_err_i;
assign or1200_cpu_or1200_except_sig_fp = or1200_cpu_sig_fp;
assign or1200_cpu_or1200_except_fpcsr_fpee = or1200_cpu_fpcsr[0];
assign or1200_cpu_dsx = or1200_cpu_or1200_except_dsx;
  
  
wire [31:0] or1200_cpu_or1200_cfgr_spr_addr;
reg [31:0] or1200_cpu_or1200_cfgr_spr_dat_o;
 
  always @(   or1200_cpu_or1200_cfgr_spr_addr   )
       if (~|  or1200_cpu_or1200_cfgr_spr_addr  [31:4])
          case (  or1200_cpu_or1200_cfgr_spr_addr  [3:0])
           4 'h0:
              begin  
                 or1200_cpu_or1200_cfgr_spr_dat_o   [5:0]=6'h08; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [15:6]=10'h000; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [23:16]=8'h00; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [31:24]=8'h13;
              end 
           4 'h1:
              begin  
                 or1200_cpu_or1200_cfgr_spr_dat_o   [0]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [1]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [2]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [3]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [4]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [5]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [6]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [7]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [8]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [9]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [10]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [11]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [23:12]=12'h000; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [31:24]=8'h00;
              end 
           4 'h2:
              begin  
                 or1200_cpu_or1200_cfgr_spr_dat_o   [3:0]=4'h0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [4]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [5]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [6]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [7]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [8]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [9]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [31:10]=22'h000000;
              end 
           4 'h3:
              begin  
                 or1200_cpu_or1200_cfgr_spr_dat_o   [1:0]=2'h0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [4:2]=3'h6; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [7:5]=3'h0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [8]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [9]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [10]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [11]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [31:12]=20'h00000;
              end 
           4 'h4:
              begin  
                 or1200_cpu_or1200_cfgr_spr_dat_o   [1:0]=2'h0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [4:2]=3'h6; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [7:5]=3'h0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [8]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [9]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [10]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [11]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [31:12]=20'h00000;
              end 
           4 'h5:
              begin  
                 or1200_cpu_or1200_cfgr_spr_dat_o   [2:0]=3'h0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [6:3]=(13-4); 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [7]=4==4?1'b0:1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [8]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [9]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [10]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [11]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [12]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [13]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [14]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [31:15]=17'h00000;
              end 
           4 'h6:
              begin  
                 or1200_cpu_or1200_cfgr_spr_dat_o   [2:0]=3'h0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [6:3]=(13-4); 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [7]=4==4?1'b0:1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [8]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [9]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [10]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [11]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [12]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [13]=1'b1; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [14]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [31:15]=17'h00000;
              end 
           4 'h7:
              begin  
                 or1200_cpu_or1200_cfgr_spr_dat_o   [3:0]=4'h0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [4]=1'b0; 
                 or1200_cpu_or1200_cfgr_spr_dat_o   [31:5]=27'd0;
              end 
           default : 
               or1200_cpu_or1200_cfgr_spr_dat_o   =32'h0000_0000;
          endcase 
        else  
           or1200_cpu_or1200_cfgr_spr_dat_o   =32'h0000_0000;

assign or1200_cpu_or1200_cfgr_spr_addr = or1200_cpu_spr_addr;
assign or1200_cpu_spr_dat_cfgr = or1200_cpu_or1200_cfgr_spr_dat_o;

assign or1200_cpu_clk = clk_i;
assign or1200_cpu_rst = rst_i;
assign ic_en = or1200_cpu_ic_en;
assign icpu_adr_cpu = or1200_cpu_icpu_adr_o;
assign icpu_cycstb_cpu = or1200_cpu_icpu_cycstb_o;
assign icpu_sel_cpu = or1200_cpu_icpu_sel_o;
assign icpu_tag_cpu = or1200_cpu_icpu_tag_o;
assign or1200_cpu_icpu_dat_i = icpu_dat_qmem;
assign or1200_cpu_icpu_ack_i = icpu_ack_qmem;
assign or1200_cpu_icpu_rty_i = icpu_rty_immu;
assign or1200_cpu_icpu_err_i = icpu_err_immu;
assign or1200_cpu_icpu_adr_i = icpu_adr_immu;
assign or1200_cpu_icpu_tag_i = icpu_tag_immu;
assign immu_en = or1200_cpu_immu_en;
assign id_void = or1200_cpu_id_void;
assign id_insn = or1200_cpu_id_insn;
assign ex_void = or1200_cpu_ex_void;
assign ex_insn = or1200_cpu_ex_insn;
assign ex_freeze = or1200_cpu_ex_freeze;
assign wb_insn = or1200_cpu_wb_insn;
assign wb_freeze = or1200_cpu_wb_freeze;
assign id_pc = or1200_cpu_id_pc;
assign ex_pc = or1200_cpu_ex_pc;
assign wb_pc = or1200_cpu_wb_pc;
assign branch_op = or1200_cpu_branch_op;
assign spr_dat_npc = or1200_cpu_spr_dat_npc;
assign rf_dataw = or1200_cpu_rf_dataw;
assign flushpipe = or1200_cpu_ex_flushpipe;
assign or1200_cpu_du_stall = du_stall;
assign or1200_cpu_du_addr = du_addr;
assign or1200_cpu_du_dat_du = du_dat_du;
assign or1200_cpu_du_read = du_read;
assign or1200_cpu_du_write = du_write;
assign du_except_stop = or1200_cpu_du_except_stop;
assign or1200_cpu_du_flush_pipe = du_flush_pipe;
assign du_except_trig = or1200_cpu_du_except_trig;
assign or1200_cpu_du_dsr = du_dsr;
assign or1200_cpu_du_dmr1 = du_dmr1;
assign or1200_cpu_du_hwbkpt = du_hwbkpt;
assign or1200_cpu_du_hwbkpt_ls_r = du_hwbkpt_ls_r;
assign du_dat_cpu = or1200_cpu_du_dat_cpu;
assign du_lsu_store_dat = or1200_cpu_du_lsu_store_dat;
assign du_lsu_load_dat = or1200_cpu_du_lsu_load_dat;
assign abort_mvspr = or1200_cpu_abort_mvspr;
assign abort_ex = or1200_cpu_abort_ex;
assign dc_en = or1200_cpu_dc_en;
assign dcpu_adr_cpu = or1200_cpu_dcpu_adr_o;
assign dcpu_cycstb_cpu = or1200_cpu_dcpu_cycstb_o;
assign dcpu_we_cpu = or1200_cpu_dcpu_we_o;
assign dcpu_sel_cpu = or1200_cpu_dcpu_sel_o;
assign dcpu_tag_cpu = or1200_cpu_dcpu_tag_o;
assign dcpu_dat_cpu = or1200_cpu_dcpu_dat_o;
assign or1200_cpu_dcpu_dat_i = dcpu_dat_qmem;
assign or1200_cpu_dcpu_ack_i = dcpu_ack_qmem;
assign or1200_cpu_dcpu_rty_i = dcpu_rty_qmem;
assign or1200_cpu_dcpu_err_i = dcpu_err_dmmu;
assign or1200_cpu_dcpu_tag_i = dcpu_tag_dmmu;
assign sb_en = or1200_cpu_sb_en;
assign dmmu_en = or1200_cpu_dmmu_en;
assign dc_no_writethrough = or1200_cpu_dc_no_writethrough;
assign or1200_cpu_boot_adr_sel_i = boot_adr_sel;
assign or1200_cpu_sig_int = sig_int;
assign or1200_cpu_sig_tick = sig_tick;
assign supv = or1200_cpu_supv;
assign spr_addr = or1200_cpu_spr_addr;
assign spr_dat_cpu = or1200_cpu_spr_dat_cpu;
assign or1200_cpu_spr_dat_pic = spr_dat_pic;
assign or1200_cpu_spr_dat_tt = spr_dat_tt;
assign or1200_cpu_spr_dat_pm = spr_dat_pm;
assign or1200_cpu_spr_dat_dmmu = spr_dat_dmmu;
assign or1200_cpu_spr_dat_immu = spr_dat_immu;
assign or1200_cpu_spr_dat_du = spr_dat_du;
assign spr_cs = or1200_cpu_spr_cs;
assign spr_we = or1200_cpu_spr_we;
assign or1200_cpu_mtspr_dc_done = mtspr_dc_done;
 
  
wire  or1200_dmmu_top_clk;
wire  or1200_dmmu_top_rst;
wire  or1200_dmmu_top_dc_en;
wire  or1200_dmmu_top_dmmu_en;
wire  or1200_dmmu_top_supv;
wire [ or1200_dmmu_top_aw -1:0] or1200_dmmu_top_dcpu_adr_i;
wire  or1200_dmmu_top_dcpu_cycstb_i;
wire  or1200_dmmu_top_dcpu_we_i;
wire [3:0] or1200_dmmu_top_dcpu_tag_o;
wire  or1200_dmmu_top_dcpu_err_o;
wire  or1200_dmmu_top_spr_cs;
wire  or1200_dmmu_top_spr_write;
wire [ or1200_dmmu_top_aw -1:0] or1200_dmmu_top_spr_addr;
wire [31:0] or1200_dmmu_top_spr_dat_i;
wire [31:0] or1200_dmmu_top_spr_dat_o;
wire  or1200_dmmu_top_qmemdmmu_err_i;
wire [3:0] or1200_dmmu_top_qmemdmmu_tag_i;
wire [ or1200_dmmu_top_aw -1:0] or1200_dmmu_top_qmemdmmu_adr_o;
wire  or1200_dmmu_top_qmemdmmu_cycstb_o;
wire  or1200_dmmu_top_qmemdmmu_ci_o;
 
   wire  or1200_dmmu_top_dtlb_spr_access  ; 
   wire[31:13]  or1200_dmmu_top_dtlb_ppn  ; 
   wire  or1200_dmmu_top_dtlb_hit  ; 
   wire  or1200_dmmu_top_dtlb_uwe  ; 
   wire  or1200_dmmu_top_dtlb_ure  ; 
   wire  or1200_dmmu_top_dtlb_swe  ; 
   wire  or1200_dmmu_top_dtlb_sre  ; 
   wire[31:0]  or1200_dmmu_top_dtlb_dat_o  ; 
   wire  or1200_dmmu_top_dtlb_en  ; 
   wire  or1200_dmmu_top_dtlb_ci  ; 
   wire  or1200_dmmu_top_fault  ; 
   wire  or1200_dmmu_top_miss  ; 
   reg  or1200_dmmu_top_dtlb_done  ; 
   reg[31:13]  or1200_dmmu_top_dcpu_vpn_r  ; 
  assign   or1200_dmmu_top_dtlb_spr_access  =  or1200_dmmu_top_spr_cs  ; 
  assign   or1200_dmmu_top_dcpu_tag_o  =  or1200_dmmu_top_miss  ?4'hd:  or1200_dmmu_top_fault  ?4'hc:  or1200_dmmu_top_qmemdmmu_tag_i  ; 
  assign   or1200_dmmu_top_dcpu_err_o  =  or1200_dmmu_top_miss  |  or1200_dmmu_top_fault  |  or1200_dmmu_top_qmemdmmu_err_i  ; 
  always @(  posedge    or1200_dmmu_top_clk          or  posedge   or1200_dmmu_top_rst  )
       if (  or1200_dmmu_top_rst  ==(1'b1)) 
           or1200_dmmu_top_dtlb_done   <=1'b0;
        else 
          if (  or1200_dmmu_top_dtlb_en  ) 
              or1200_dmmu_top_dtlb_done   <=  or1200_dmmu_top_dcpu_cycstb_i  ;
           else  
              or1200_dmmu_top_dtlb_done   <=1'b0;
 
  assign   or1200_dmmu_top_qmemdmmu_cycstb_o  =(  or1200_dmmu_top_dc_en  &  or1200_dmmu_top_dmmu_en  )?!(  or1200_dmmu_top_miss  |  or1200_dmmu_top_fault  )&  or1200_dmmu_top_dtlb_done  &  or1200_dmmu_top_dcpu_cycstb_i  :!(  or1200_dmmu_top_miss  |  or1200_dmmu_top_fault  )&  or1200_dmmu_top_dcpu_cycstb_i  ; 
  assign   or1200_dmmu_top_qmemdmmu_ci_o  =  or1200_dmmu_top_dmmu_en  ?  or1200_dmmu_top_dtlb_ci  :  or1200_dmmu_top_dcpu_adr_i  [31]; 
  always @(  posedge    or1200_dmmu_top_clk          or  posedge   or1200_dmmu_top_rst  )
       if (  or1200_dmmu_top_rst  ==(1'b1)) 
           or1200_dmmu_top_dcpu_vpn_r   <={32-13{1'b0}};
        else  
           or1200_dmmu_top_dcpu_vpn_r   <=  or1200_dmmu_top_dcpu_adr_i  [31:13];
 
  assign   or1200_dmmu_top_qmemdmmu_adr_o  =  or1200_dmmu_top_dmmu_en  ?{  or1200_dmmu_top_dtlb_ppn  ,  or1200_dmmu_top_dcpu_adr_i  [13-1:0]}:  or1200_dmmu_top_dcpu_adr_i  ; 
  assign   or1200_dmmu_top_spr_dat_o  =  or1200_dmmu_top_dtlb_spr_access  ?  or1200_dmmu_top_dtlb_dat_o  :32'h00000000; 
  assign   or1200_dmmu_top_fault  =  or1200_dmmu_top_dtlb_done  &((!  or1200_dmmu_top_dcpu_we_i  &!  or1200_dmmu_top_supv  &!  or1200_dmmu_top_dtlb_ure  )||(!  or1200_dmmu_top_dcpu_we_i  &  or1200_dmmu_top_supv  &!  or1200_dmmu_top_dtlb_sre  )||(  or1200_dmmu_top_dcpu_we_i  &!  or1200_dmmu_top_supv  &!  or1200_dmmu_top_dtlb_uwe  )||(  or1200_dmmu_top_dcpu_we_i  &  or1200_dmmu_top_supv  &!  or1200_dmmu_top_dtlb_swe  )); 
  assign   or1200_dmmu_top_miss  =  or1200_dmmu_top_dtlb_done  &!  or1200_dmmu_top_dtlb_hit  ; 
  assign   or1200_dmmu_top_dtlb_en  =  or1200_dmmu_top_dmmu_en  &  or1200_dmmu_top_dcpu_cycstb_i  ;  
  
wire  or1200_dmmu_top_or1200_dmmu_tlb_clk;
wire  or1200_dmmu_top_or1200_dmmu_tlb_rst;
wire  or1200_dmmu_top_or1200_dmmu_tlb_tlb_en;
wire [ or1200_dmmu_top_or1200_dmmu_tlb_aw -1:0] or1200_dmmu_top_or1200_dmmu_tlb_vaddr;
wire  or1200_dmmu_top_or1200_dmmu_tlb_hit;
wire [31:13] or1200_dmmu_top_or1200_dmmu_tlb_ppn;
wire  or1200_dmmu_top_or1200_dmmu_tlb_uwe;
wire  or1200_dmmu_top_or1200_dmmu_tlb_ure;
wire  or1200_dmmu_top_or1200_dmmu_tlb_swe;
wire  or1200_dmmu_top_or1200_dmmu_tlb_sre;
wire  or1200_dmmu_top_or1200_dmmu_tlb_ci;
wire  or1200_dmmu_top_or1200_dmmu_tlb_spr_cs;
wire  or1200_dmmu_top_or1200_dmmu_tlb_spr_write;
wire [31:0] or1200_dmmu_top_or1200_dmmu_tlb_spr_addr;
wire [31:0] or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_i;
wire [31:0] or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_o;
 
   wire[31:13+6-1+1]  or1200_dmmu_top_or1200_dmmu_tlb_vpn  ; 
   wire  or1200_dmmu_top_or1200_dmmu_tlb_v  ; 
   wire[6-1:0]  or1200_dmmu_top_or1200_dmmu_tlb_tlb_index  ; 
   wire  or1200_dmmu_top_or1200_dmmu_tlb_tlb_mr_en  ; 
   wire  or1200_dmmu_top_or1200_dmmu_tlb_tlb_mr_we  ; 
   wire[32-6-13+1-1:0]  or1200_dmmu_top_or1200_dmmu_tlb_tlb_mr_ram_in  ; 
   wire[32-6-13+1-1:0]  or1200_dmmu_top_or1200_dmmu_tlb_tlb_mr_ram_out  ; 
   wire  or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_en  ; 
   wire  or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_we  ; 
   wire[32-13+5-1:0]  or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_ram_in  ; 
   wire[32-13+5-1:0]  or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_ram_out  ; 
  assign   or1200_dmmu_top_or1200_dmmu_tlb_tlb_mr_en  =  or1200_dmmu_top_or1200_dmmu_tlb_tlb_en  |(  or1200_dmmu_top_or1200_dmmu_tlb_spr_cs  &!  or1200_dmmu_top_or1200_dmmu_tlb_spr_addr  [7]); 
  assign   or1200_dmmu_top_or1200_dmmu_tlb_tlb_mr_we  =  or1200_dmmu_top_or1200_dmmu_tlb_spr_cs  &  or1200_dmmu_top_or1200_dmmu_tlb_spr_write  &!  or1200_dmmu_top_or1200_dmmu_tlb_spr_addr  [7]; 
  assign   or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_en  =  or1200_dmmu_top_or1200_dmmu_tlb_tlb_en  |(  or1200_dmmu_top_or1200_dmmu_tlb_spr_cs  &  or1200_dmmu_top_or1200_dmmu_tlb_spr_addr  [7]); 
  assign   or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_we  =  or1200_dmmu_top_or1200_dmmu_tlb_spr_cs  &  or1200_dmmu_top_or1200_dmmu_tlb_spr_write  &  or1200_dmmu_top_or1200_dmmu_tlb_spr_addr  [7]; 
  assign   or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_o  =(  or1200_dmmu_top_or1200_dmmu_tlb_spr_cs  &!  or1200_dmmu_top_or1200_dmmu_tlb_spr_write  &!  or1200_dmmu_top_or1200_dmmu_tlb_spr_addr  [7])?{  or1200_dmmu_top_or1200_dmmu_tlb_vpn  ,  or1200_dmmu_top_or1200_dmmu_tlb_tlb_index  ,{32-6-13-7{1'b0}},1'b0,5'b00000,  or1200_dmmu_top_or1200_dmmu_tlb_v  }:(  or1200_dmmu_top_or1200_dmmu_tlb_spr_cs  &!  or1200_dmmu_top_or1200_dmmu_tlb_spr_write  &  or1200_dmmu_top_or1200_dmmu_tlb_spr_addr  [7])?{  or1200_dmmu_top_or1200_dmmu_tlb_ppn  ,{13-10{1'b0}},  or1200_dmmu_top_or1200_dmmu_tlb_swe  ,  or1200_dmmu_top_or1200_dmmu_tlb_sre  ,  or1200_dmmu_top_or1200_dmmu_tlb_uwe  ,  or1200_dmmu_top_or1200_dmmu_tlb_ure  ,{4{1'b0}},  or1200_dmmu_top_or1200_dmmu_tlb_ci  ,1'b0}:32'h00000000; 
  assign {  or1200_dmmu_top_or1200_dmmu_tlb_vpn  ,  or1200_dmmu_top_or1200_dmmu_tlb_v  }=  or1200_dmmu_top_or1200_dmmu_tlb_tlb_mr_ram_out  ; 
  assign   or1200_dmmu_top_or1200_dmmu_tlb_tlb_mr_ram_in  ={  or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_i  [31:13+6-1+1],  or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_i  [0]}; 
  assign {  or1200_dmmu_top_or1200_dmmu_tlb_ppn  ,  or1200_dmmu_top_or1200_dmmu_tlb_swe  ,  or1200_dmmu_top_or1200_dmmu_tlb_sre  ,  or1200_dmmu_top_or1200_dmmu_tlb_uwe  ,  or1200_dmmu_top_or1200_dmmu_tlb_ure  ,  or1200_dmmu_top_or1200_dmmu_tlb_ci  }=  or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_ram_out  ; 
  assign   or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_ram_in  ={  or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_i  [31:13],  or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_i  [9],  or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_i  [8],  or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_i  [7],  or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_i  [6],  or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_i  [1]}; 
  assign   or1200_dmmu_top_or1200_dmmu_tlb_hit  =(  or1200_dmmu_top_or1200_dmmu_tlb_vpn  ==  or1200_dmmu_top_or1200_dmmu_tlb_vaddr  [31:13+6-1+1])&  or1200_dmmu_top_or1200_dmmu_tlb_v  ; 
  assign   or1200_dmmu_top_or1200_dmmu_tlb_tlb_index  =  or1200_dmmu_top_or1200_dmmu_tlb_spr_cs  ?  or1200_dmmu_top_or1200_dmmu_tlb_spr_addr  [6-1:0]:  or1200_dmmu_top_or1200_dmmu_tlb_vaddr  [13+6-1:13];  
  
wire  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_clk;
wire  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_ce;
wire  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_we;
wire [ or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_aw -1:0] or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_addr;
wire [ or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_dw -1:0] or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_di;
wire [ or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_dw -1:0] or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_doq;
wire  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_clk;
wire  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_ce;
wire  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_we;
wire [ or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_aw -1:0] or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_addr;
wire [ or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_dw -1:0] or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_di;
wire [ or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_dw -1:0] or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_doq;
 
   reg[  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_dw  -1:0]  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_mem  [(1<<  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_aw  )-1:0]; 
   reg[  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_aw  -1:0]  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_addr_reg  ; 
  assign   or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_doq  =  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_mem  [  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_addr_reg  ]; 
  always @( posedge   or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_clk  )
       if (  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_ce  ) 
           or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_addr_reg   <=  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_addr  ;
 
  always @( posedge   or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_clk  )
       if (  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_we  &&  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_ce  ) 
           or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_mem   [  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_addr  ]<=  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_di  ;

  
  
 
   reg[  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_dw  -1:0]  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_mem  [(1<<  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_aw  )-1:0]; 
   reg[  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_aw  -1:0]  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_addr_reg  ; 
  assign   or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_doq  =  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_mem  [  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_addr_reg  ]; 
  always @( posedge   or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_clk  )
       if (  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_ce  ) 
           or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_addr_reg   <=  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_addr  ;
 
  always @( posedge   or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_clk  )
       if (  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_we  &&  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_ce  ) 
           or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_mem   [  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_addr  ]<=  or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_di  ;

assign or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_clk = or1200_dmmu_top_or1200_dmmu_tlb_clk;
assign or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_ce = or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_en;
assign or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_we = or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_we;
assign or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_addr = or1200_dmmu_top_or1200_dmmu_tlb_tlb_index;
assign or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_di = or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_ram_in;
assign or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_ram_out = or1200_dmmu_top_or1200_dmmu_tlb_dtlb_ram_doq;
assign or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_clk = or1200_dmmu_top_or1200_dmmu_tlb_clk;
assign or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_ce = or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_en;
assign or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_we = or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_we;
assign or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_addr = or1200_dmmu_top_or1200_dmmu_tlb_tlb_index;
assign or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_di = or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_ram_in;
assign or1200_dmmu_top_or1200_dmmu_tlb_tlb_tr_ram_out = or1200_dmmu_top_or1200_dmmu_tlb_dtlb_tr_ram_doq;

assign or1200_dmmu_top_or1200_dmmu_tlb_clk = or1200_dmmu_top_clk;
assign or1200_dmmu_top_or1200_dmmu_tlb_rst = or1200_dmmu_top_rst;
assign or1200_dmmu_top_or1200_dmmu_tlb_tlb_en = or1200_dmmu_top_dtlb_en;
assign or1200_dmmu_top_or1200_dmmu_tlb_vaddr = or1200_dmmu_top_dcpu_adr_i;
assign or1200_dmmu_top_dtlb_hit = or1200_dmmu_top_or1200_dmmu_tlb_hit;
assign or1200_dmmu_top_dtlb_ppn = or1200_dmmu_top_or1200_dmmu_tlb_ppn;
assign or1200_dmmu_top_dtlb_uwe = or1200_dmmu_top_or1200_dmmu_tlb_uwe;
assign or1200_dmmu_top_dtlb_ure = or1200_dmmu_top_or1200_dmmu_tlb_ure;
assign or1200_dmmu_top_dtlb_swe = or1200_dmmu_top_or1200_dmmu_tlb_swe;
assign or1200_dmmu_top_dtlb_sre = or1200_dmmu_top_or1200_dmmu_tlb_sre;
assign or1200_dmmu_top_dtlb_ci = or1200_dmmu_top_or1200_dmmu_tlb_ci;
assign or1200_dmmu_top_or1200_dmmu_tlb_spr_cs = or1200_dmmu_top_dtlb_spr_access;
assign or1200_dmmu_top_or1200_dmmu_tlb_spr_write = or1200_dmmu_top_spr_write;
assign or1200_dmmu_top_or1200_dmmu_tlb_spr_addr = or1200_dmmu_top_spr_addr;
assign or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_i = or1200_dmmu_top_spr_dat_i;
assign or1200_dmmu_top_dtlb_dat_o = or1200_dmmu_top_or1200_dmmu_tlb_spr_dat_o;

assign or1200_dmmu_top_clk = clk_i;
assign or1200_dmmu_top_rst = rst_i;
assign or1200_dmmu_top_dc_en = dc_en;
assign or1200_dmmu_top_dmmu_en = dmmu_en;
assign or1200_dmmu_top_supv = supv;
assign or1200_dmmu_top_dcpu_adr_i = dcpu_adr_cpu;
assign or1200_dmmu_top_dcpu_cycstb_i = dcpu_cycstb_cpu;
assign or1200_dmmu_top_dcpu_we_i = dcpu_we_cpu;
assign dcpu_tag_dmmu = or1200_dmmu_top_dcpu_tag_o;
assign dcpu_err_dmmu = or1200_dmmu_top_dcpu_err_o;
assign or1200_dmmu_top_spr_cs = spr_cs[5'd01];
assign or1200_dmmu_top_spr_write = spr_we;
assign or1200_dmmu_top_spr_addr = spr_addr;
assign or1200_dmmu_top_spr_dat_i = spr_dat_cpu;
assign spr_dat_dmmu = or1200_dmmu_top_spr_dat_o;
assign or1200_dmmu_top_qmemdmmu_err_i = qmemdmmu_err_qmem;
assign or1200_dmmu_top_qmemdmmu_tag_i = qmemdmmu_tag_qmem;
assign qmemdmmu_adr_dmmu = or1200_dmmu_top_qmemdmmu_adr_o;
assign qmemdmmu_cycstb_dmmu = or1200_dmmu_top_qmemdmmu_cycstb_o;
assign qmemdmmu_ci_dmmu = or1200_dmmu_top_qmemdmmu_ci_o;
 
  
wire  or1200_dc_top_clk;
wire  or1200_dc_top_rst;
wire [ or1200_dc_top_dw -1:0] or1200_dc_top_dcsb_dat_o;
wire [31:0] or1200_dc_top_dcsb_adr_o;
wire  or1200_dc_top_dcsb_cyc_o;
wire  or1200_dc_top_dcsb_stb_o;
wire  or1200_dc_top_dcsb_we_o;
wire [3:0] or1200_dc_top_dcsb_sel_o;
wire  or1200_dc_top_dcsb_cab_o;
wire [ or1200_dc_top_dw -1:0] or1200_dc_top_dcsb_dat_i;
wire  or1200_dc_top_dcsb_ack_i;
wire  or1200_dc_top_dcsb_err_i;
wire  or1200_dc_top_dc_en;
wire [31:0] or1200_dc_top_dcqmem_adr_i;
wire  or1200_dc_top_dcqmem_cycstb_i;
wire  or1200_dc_top_dcqmem_ci_i;
wire  or1200_dc_top_dcqmem_we_i;
wire [3:0] or1200_dc_top_dcqmem_sel_i;
wire [3:0] or1200_dc_top_dcqmem_tag_i;
wire [ or1200_dc_top_dw -1:0] or1200_dc_top_dcqmem_dat_i;
wire [ or1200_dc_top_dw -1:0] or1200_dc_top_dcqmem_dat_o;
wire  or1200_dc_top_dcqmem_ack_o;
wire  or1200_dc_top_dcqmem_rty_o;
wire  or1200_dc_top_dcqmem_err_o;
wire [3:0] or1200_dc_top_dcqmem_tag_o;
wire  or1200_dc_top_dc_no_writethrough;
wire  or1200_dc_top_spr_cs;
wire  or1200_dc_top_spr_write;
wire [31:0] or1200_dc_top_spr_dat_i;
wire [ or1200_dc_top_aw -1:0] or1200_dc_top_spr_addr;
wire  or1200_dc_top_mtspr_dc_done;
 
   wire  or1200_dc_top_tag_v  ; 
   wire[20-2:0]  or1200_dc_top_tag  ; 
   wire  or1200_dc_top_dirty  ; 
   wire[  or1200_dc_top_dw  -1:0]  or1200_dc_top_to_dcram  ; 
   wire[  or1200_dc_top_dw  -1:0]  or1200_dc_top_from_dcram  ; 
   wire[3:0]  or1200_dc_top_dcram_we  ; 
   wire  or1200_dc_top_dctag_we  ; 
   wire[31:0]  or1200_dc_top_dc_addr  ; 
   wire  or1200_dc_top_dcfsm_biu_read  ; 
   wire  or1200_dc_top_dcfsm_biu_write  ; 
   wire  or1200_dc_top_dcfsm_dcram_di_sel  ; 
   wire  or1200_dc_top_dcfsm_biu_do_sel  ; 
   reg  or1200_dc_top_tagcomp_miss  ; 
   wire[13-1:4]  or1200_dc_top_dctag_addr  ; 
   wire  or1200_dc_top_dctag_en  ; 
   wire  or1200_dc_top_dctag_v  ; 
   wire  or1200_dc_top_dctag_dirty  ; 
   wire  or1200_dc_top_dc_block_invalidate  ; 
   wire  or1200_dc_top_dc_block_flush  ; 
   wire  or1200_dc_top_dc_block_writeback  ; 
   wire  or1200_dc_top_dcfsm_first_hit_ack  ; 
   wire  or1200_dc_top_dcfsm_first_miss_ack  ; 
   wire  or1200_dc_top_dcfsm_first_miss_err  ; 
   wire  or1200_dc_top_dcfsm_burst  ; 
   wire  or1200_dc_top_dcfsm_tag_we  ; 
   wire  or1200_dc_top_dcfsm_tag_valid  ; 
   wire  or1200_dc_top_dcfsm_tag_dirty  ; 
  assign   or1200_dc_top_dcsb_adr_o  =  or1200_dc_top_dc_addr  ; 
  assign   or1200_dc_top_dc_block_invalidate  =  or1200_dc_top_spr_cs  &  or1200_dc_top_spr_write  &((  or1200_dc_top_spr_addr  [3-1:0]==3'd3)|(  or1200_dc_top_spr_addr  [3-1:0]==3'd2)); 
  assign   or1200_dc_top_dc_block_flush  =0; 
  assign   or1200_dc_top_dc_block_writeback  =0; 
  assign   or1200_dc_top_dctag_we  =  or1200_dc_top_dcfsm_tag_we  |  or1200_dc_top_dc_block_invalidate  ; 
  assign   or1200_dc_top_dctag_addr  =  or1200_dc_top_dc_block_invalidate  ?  or1200_dc_top_spr_dat_i  [13-1:4]:  or1200_dc_top_dc_addr  [13-1:4]; 
  assign   or1200_dc_top_dctag_en  =  or1200_dc_top_dc_block_invalidate  |  or1200_dc_top_dc_en  ; 
  assign   or1200_dc_top_dctag_v  =  or1200_dc_top_dc_block_invalidate  ?1'b0:  or1200_dc_top_dcfsm_tag_valid  ; 
  assign   or1200_dc_top_dctag_dirty  =  or1200_dc_top_dc_block_invalidate  ?1'b0:  or1200_dc_top_dcfsm_tag_dirty  ; 
  assign   or1200_dc_top_dcsb_dat_o  =  or1200_dc_top_dcfsm_biu_do_sel  ?  or1200_dc_top_from_dcram  :  or1200_dc_top_dcqmem_dat_i  ; 
  assign   or1200_dc_top_dcsb_cyc_o  =(  or1200_dc_top_dc_en  )?  or1200_dc_top_dcfsm_biu_read  |  or1200_dc_top_dcfsm_biu_write  :  or1200_dc_top_dcqmem_cycstb_i  ; 
  assign   or1200_dc_top_dcsb_stb_o  =(  or1200_dc_top_dc_en  )?  or1200_dc_top_dcfsm_biu_read  |  or1200_dc_top_dcfsm_biu_write  :  or1200_dc_top_dcqmem_cycstb_i  ; 
  assign   or1200_dc_top_dcsb_we_o  =(  or1200_dc_top_dc_en  )?  or1200_dc_top_dcfsm_biu_write  :  or1200_dc_top_dcqmem_we_i  ; 
  assign   or1200_dc_top_dcsb_sel_o  =(  or1200_dc_top_dc_en  &  or1200_dc_top_dcfsm_burst  )?4'b1111:  or1200_dc_top_dcqmem_sel_i  ; 
  assign   or1200_dc_top_dcsb_cab_o  =  or1200_dc_top_dc_en  &  or1200_dc_top_dcfsm_burst  &  or1200_dc_top_dcsb_cyc_o  ; 
  assign   or1200_dc_top_dcqmem_rty_o  =~  or1200_dc_top_dcqmem_ack_o  ; 
  assign   or1200_dc_top_dcqmem_tag_o  =  or1200_dc_top_dcqmem_err_o  ?4'hb:  or1200_dc_top_dcqmem_tag_i  ; 
  assign   or1200_dc_top_dcqmem_ack_o  =  or1200_dc_top_dc_en  ?  or1200_dc_top_dcfsm_first_hit_ack  |  or1200_dc_top_dcfsm_first_miss_ack  :  or1200_dc_top_dcsb_ack_i  ; 
  assign   or1200_dc_top_dcqmem_err_o  =  or1200_dc_top_dc_en  ?  or1200_dc_top_dcfsm_first_miss_err  :  or1200_dc_top_dcsb_err_i  ; 
  assign   or1200_dc_top_to_dcram  =(  or1200_dc_top_dcfsm_dcram_di_sel  )?  or1200_dc_top_dcsb_dat_i  :  or1200_dc_top_dcqmem_dat_i  ; 
  assign   or1200_dc_top_dcqmem_dat_o  =  or1200_dc_top_dcfsm_first_miss_ack  |!  or1200_dc_top_dc_en  ?  or1200_dc_top_dcsb_dat_i  :  or1200_dc_top_from_dcram  ; 
   wire[31:13-1+1]  or1200_dc_top_dcqmem_adr_i_tag  ; 
  assign   or1200_dc_top_dcqmem_adr_i_tag  =  or1200_dc_top_dcqmem_adr_i  [31:13-1+1]; 
  always @(     or1200_dc_top_tag              or    or1200_dc_top_dcqmem_adr_i_tag           or    or1200_dc_top_tag_v   )
       begin 
         if ((  or1200_dc_top_tag  !=  or1200_dc_top_dcqmem_adr_i_tag  )||!  or1200_dc_top_tag_v  ) 
             or1200_dc_top_tagcomp_miss   =1'b1;
          else  
             or1200_dc_top_tagcomp_miss   =1'b0;
       end
   
  
wire  or1200_dc_top_or1200_dc_fsm_clk;
wire  or1200_dc_top_or1200_dc_fsm_rst;
wire  or1200_dc_top_or1200_dc_fsm_dc_en;
wire  or1200_dc_top_or1200_dc_fsm_dcqmem_cycstb_i;
wire  or1200_dc_top_or1200_dc_fsm_dcqmem_ci_i;
wire  or1200_dc_top_or1200_dc_fsm_dcqmem_we_i;
wire [3:0] or1200_dc_top_or1200_dc_fsm_dcqmem_sel_i;
wire  or1200_dc_top_or1200_dc_fsm_tagcomp_miss;
wire  or1200_dc_top_or1200_dc_fsm_biudata_valid;
wire  or1200_dc_top_or1200_dc_fsm_biudata_error;
wire [31:0] or1200_dc_top_or1200_dc_fsm_lsu_addr;
wire [3:0] or1200_dc_top_or1200_dc_fsm_dcram_we;
wire  or1200_dc_top_or1200_dc_fsm_biu_read;
wire  or1200_dc_top_or1200_dc_fsm_biu_write;
wire  or1200_dc_top_or1200_dc_fsm_biu_do_sel;
wire  or1200_dc_top_or1200_dc_fsm_dcram_di_sel;
wire  or1200_dc_top_or1200_dc_fsm_first_hit_ack;
wire  or1200_dc_top_or1200_dc_fsm_first_miss_ack;
wire  or1200_dc_top_or1200_dc_fsm_first_miss_err;
wire  or1200_dc_top_or1200_dc_fsm_burst;
wire  or1200_dc_top_or1200_dc_fsm_tag_we;
wire  or1200_dc_top_or1200_dc_fsm_tag_valid;
wire [31:0] or1200_dc_top_or1200_dc_fsm_dc_addr;
wire  or1200_dc_top_or1200_dc_fsm_dc_no_writethrough;
wire  or1200_dc_top_or1200_dc_fsm_tag_dirty;
wire  or1200_dc_top_or1200_dc_fsm_dirty;
wire [20-2:0] or1200_dc_top_or1200_dc_fsm_tag;
wire  or1200_dc_top_or1200_dc_fsm_tag_v;
wire  or1200_dc_top_or1200_dc_fsm_dc_block_flush;
wire  or1200_dc_top_or1200_dc_fsm_dc_block_writeback;
wire [31:0] or1200_dc_top_or1200_dc_fsm_spr_dat_i;
wire  or1200_dc_top_or1200_dc_fsm_mtspr_dc_done;
wire  or1200_dc_top_or1200_dc_fsm_spr_cswe;
 
   reg[31:0]  or1200_dc_top_or1200_dc_fsm_addr_r  ; 
   reg[2:0]  or1200_dc_top_or1200_dc_fsm_state  ; 
   reg[4-1:0]  or1200_dc_top_or1200_dc_fsm_cnt  ; 
   reg  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  ; 
   reg  or1200_dc_top_or1200_dc_fsm_store  ; 
   reg  or1200_dc_top_or1200_dc_fsm_load  ; 
   reg  or1200_dc_top_or1200_dc_fsm_cache_inhibit  ; 
   reg  or1200_dc_top_or1200_dc_fsm_cache_miss  ; 
   reg  or1200_dc_top_or1200_dc_fsm_cache_dirty_needs_writeback  ; 
   reg  or1200_dc_top_or1200_dc_fsm_did_early_load_ack  ; 
   reg  or1200_dc_top_or1200_dc_fsm_cache_spr_block_flush  ; 
   reg  or1200_dc_top_or1200_dc_fsm_cache_spr_block_writeback  ; 
   reg  or1200_dc_top_or1200_dc_fsm_cache_wb  ; 
   wire  or1200_dc_top_or1200_dc_fsm_load_hit_ack  ; 
   wire  or1200_dc_top_or1200_dc_fsm_load_miss_ack  ; 
   wire  or1200_dc_top_or1200_dc_fsm_load_inhibit_ack  ; 
   wire  or1200_dc_top_or1200_dc_fsm_store_hit_ack  ; 
   wire  or1200_dc_top_or1200_dc_fsm_store_hit_writethrough_ack  ; 
   wire  or1200_dc_top_or1200_dc_fsm_store_miss_writethrough_ack  ; 
   wire  or1200_dc_top_or1200_dc_fsm_store_inhibit_ack  ; 
   wire  or1200_dc_top_or1200_dc_fsm_store_miss_ack  ; 
   wire  or1200_dc_top_or1200_dc_fsm_dcram_we_after_line_load  ; 
   wire  or1200_dc_top_or1200_dc_fsm_dcram_we_during_line_load  ; 
   wire  or1200_dc_top_or1200_dc_fsm_tagram_we_end_of_loadstore_loop  ; 
   wire  or1200_dc_top_or1200_dc_fsm_tagram_dirty_bit_set  ; 
   wire  or1200_dc_top_or1200_dc_fsm_writethrough  ; 
   wire  or1200_dc_top_or1200_dc_fsm_cache_inhibit_with_eval  ; 
   wire[(4-1)-2:0]  or1200_dc_top_or1200_dc_fsm_next_addr_word  ; 
  assign   or1200_dc_top_or1200_dc_fsm_cache_inhibit_with_eval  =(  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  &  or1200_dc_top_or1200_dc_fsm_dcqmem_ci_i  )|(!  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  &  or1200_dc_top_or1200_dc_fsm_cache_inhibit  ); 
  assign   or1200_dc_top_or1200_dc_fsm_dcram_we_after_line_load  =(  or1200_dc_top_or1200_dc_fsm_state  ==3'd3)&  or1200_dc_top_or1200_dc_fsm_dcqmem_we_i  &!  or1200_dc_top_or1200_dc_fsm_cache_dirty_needs_writeback  &!  or1200_dc_top_or1200_dc_fsm_did_early_load_ack  ; 
  assign   or1200_dc_top_or1200_dc_fsm_dcram_we_during_line_load  =(  or1200_dc_top_or1200_dc_fsm_state  ==3'd2)&  or1200_dc_top_or1200_dc_fsm_load  &  or1200_dc_top_or1200_dc_fsm_biudata_valid  ; 
  assign   or1200_dc_top_or1200_dc_fsm_dcram_we  =(({4{  or1200_dc_top_or1200_dc_fsm_store_hit_ack  |  or1200_dc_top_or1200_dc_fsm_store_hit_writethrough_ack  }}|{4{  or1200_dc_top_or1200_dc_fsm_dcram_we_after_line_load  }})&  or1200_dc_top_or1200_dc_fsm_dcqmem_sel_i  )|{4{  or1200_dc_top_or1200_dc_fsm_dcram_we_during_line_load  }}; 
  assign   or1200_dc_top_or1200_dc_fsm_tagram_we_end_of_loadstore_loop  =((  or1200_dc_top_or1200_dc_fsm_state  ==3'd2)&  or1200_dc_top_or1200_dc_fsm_biudata_valid  &!(|  or1200_dc_top_or1200_dc_fsm_cnt  )); 
  assign   or1200_dc_top_or1200_dc_fsm_tagram_dirty_bit_set  =0; 
  assign   or1200_dc_top_or1200_dc_fsm_mtspr_dc_done  =1'b1; 
  assign   or1200_dc_top_or1200_dc_fsm_tag_dirty  =  or1200_dc_top_or1200_dc_fsm_tagram_dirty_bit_set  ; 
  assign   or1200_dc_top_or1200_dc_fsm_tag_we  =  or1200_dc_top_or1200_dc_fsm_tagram_we_end_of_loadstore_loop  |  or1200_dc_top_or1200_dc_fsm_tagram_dirty_bit_set  |(  or1200_dc_top_or1200_dc_fsm_state  ==3'd6); 
  assign   or1200_dc_top_or1200_dc_fsm_tag_valid  =(  or1200_dc_top_or1200_dc_fsm_tagram_we_end_of_loadstore_loop  &(  or1200_dc_top_or1200_dc_fsm_load  |(  or1200_dc_top_or1200_dc_fsm_store  &  or1200_dc_top_or1200_dc_fsm_cache_spr_block_writeback  )))|  or1200_dc_top_or1200_dc_fsm_tagram_dirty_bit_set  ; 
  assign   or1200_dc_top_or1200_dc_fsm_biu_read  =((  or1200_dc_top_or1200_dc_fsm_state  ==3'd1)&(((  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  &  or1200_dc_top_or1200_dc_fsm_tagcomp_miss  &!  or1200_dc_top_or1200_dc_fsm_dirty  &!(  or1200_dc_top_or1200_dc_fsm_store  &  or1200_dc_top_or1200_dc_fsm_writethrough  ))|(  or1200_dc_top_or1200_dc_fsm_load  &  or1200_dc_top_or1200_dc_fsm_cache_inhibit_with_eval  ))&  or1200_dc_top_or1200_dc_fsm_dcqmem_cycstb_i  ))|((  or1200_dc_top_or1200_dc_fsm_state  ==3'd2)&  or1200_dc_top_or1200_dc_fsm_load  ); 
  assign   or1200_dc_top_or1200_dc_fsm_biu_write  =((  or1200_dc_top_or1200_dc_fsm_state  ==3'd1)&(((  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  &  or1200_dc_top_or1200_dc_fsm_tagcomp_miss  &  or1200_dc_top_or1200_dc_fsm_dirty  )|(  or1200_dc_top_or1200_dc_fsm_store  &  or1200_dc_top_or1200_dc_fsm_writethrough  ))|(  or1200_dc_top_or1200_dc_fsm_store  &  or1200_dc_top_or1200_dc_fsm_cache_inhibit_with_eval  ))&  or1200_dc_top_or1200_dc_fsm_dcqmem_cycstb_i  )|((  or1200_dc_top_or1200_dc_fsm_state  ==3'd2)&  or1200_dc_top_or1200_dc_fsm_store  ); 
  assign   or1200_dc_top_or1200_dc_fsm_dcram_di_sel  =  or1200_dc_top_or1200_dc_fsm_load  ; 
  assign   or1200_dc_top_or1200_dc_fsm_biu_do_sel  =(  or1200_dc_top_or1200_dc_fsm_state  ==3'd2)&  or1200_dc_top_or1200_dc_fsm_store  ; 
  assign   or1200_dc_top_or1200_dc_fsm_next_addr_word  =  or1200_dc_top_or1200_dc_fsm_addr_r  [4-1:2]+1; 
  assign   or1200_dc_top_or1200_dc_fsm_dc_addr  =((  or1200_dc_top_or1200_dc_fsm_dc_block_flush  &!  or1200_dc_top_or1200_dc_fsm_cache_spr_block_flush  )|(  or1200_dc_top_or1200_dc_fsm_dc_block_writeback  &!  or1200_dc_top_or1200_dc_fsm_cache_spr_block_writeback  ))?  or1200_dc_top_or1200_dc_fsm_spr_dat_i  :(  or1200_dc_top_or1200_dc_fsm_state  ==3'd5)?  or1200_dc_top_or1200_dc_fsm_addr_r  :(  or1200_dc_top_or1200_dc_fsm_state  ==3'd0|  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  )?  or1200_dc_top_or1200_dc_fsm_lsu_addr  :(  or1200_dc_top_or1200_dc_fsm_state  ==3'd2&  or1200_dc_top_or1200_dc_fsm_biudata_valid  &  or1200_dc_top_or1200_dc_fsm_store  )?{  or1200_dc_top_or1200_dc_fsm_addr_r  [31:4],  or1200_dc_top_or1200_dc_fsm_next_addr_word  ,2'b00}:  or1200_dc_top_or1200_dc_fsm_addr_r  ; 
  assign   or1200_dc_top_or1200_dc_fsm_writethrough  =1; 
  assign   or1200_dc_top_or1200_dc_fsm_first_hit_ack  =  or1200_dc_top_or1200_dc_fsm_load_hit_ack  |  or1200_dc_top_or1200_dc_fsm_store_hit_ack  |  or1200_dc_top_or1200_dc_fsm_store_hit_writethrough_ack  |  or1200_dc_top_or1200_dc_fsm_store_miss_writethrough_ack  |  or1200_dc_top_or1200_dc_fsm_store_inhibit_ack  |  or1200_dc_top_or1200_dc_fsm_store_miss_ack  ; 
  assign   or1200_dc_top_or1200_dc_fsm_first_miss_ack  =~  or1200_dc_top_or1200_dc_fsm_first_hit_ack  &(  or1200_dc_top_or1200_dc_fsm_load_miss_ack  |  or1200_dc_top_or1200_dc_fsm_load_inhibit_ack  ); 
  assign   or1200_dc_top_or1200_dc_fsm_load_hit_ack  =(  or1200_dc_top_or1200_dc_fsm_state  ==3'd1)&  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  &!  or1200_dc_top_or1200_dc_fsm_tagcomp_miss  &!  or1200_dc_top_or1200_dc_fsm_dcqmem_ci_i  &  or1200_dc_top_or1200_dc_fsm_load  ; 
  assign   or1200_dc_top_or1200_dc_fsm_store_hit_ack  =(  or1200_dc_top_or1200_dc_fsm_state  ==3'd1)&  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  &!  or1200_dc_top_or1200_dc_fsm_tagcomp_miss  &!  or1200_dc_top_or1200_dc_fsm_dcqmem_ci_i  &  or1200_dc_top_or1200_dc_fsm_store  &!  or1200_dc_top_or1200_dc_fsm_writethrough  ; 
  assign   or1200_dc_top_or1200_dc_fsm_store_hit_writethrough_ack  =(  or1200_dc_top_or1200_dc_fsm_state  ==3'd1)&!  or1200_dc_top_or1200_dc_fsm_cache_miss  &!  or1200_dc_top_or1200_dc_fsm_cache_inhibit  &  or1200_dc_top_or1200_dc_fsm_store  &  or1200_dc_top_or1200_dc_fsm_writethrough  &  or1200_dc_top_or1200_dc_fsm_biudata_valid  ; 
  assign   or1200_dc_top_or1200_dc_fsm_store_miss_writethrough_ack  =(  or1200_dc_top_or1200_dc_fsm_state  ==3'd1)&  or1200_dc_top_or1200_dc_fsm_cache_miss  &!  or1200_dc_top_or1200_dc_fsm_cache_inhibit  &  or1200_dc_top_or1200_dc_fsm_store  &  or1200_dc_top_or1200_dc_fsm_writethrough  &  or1200_dc_top_or1200_dc_fsm_biudata_valid  ; 
  assign   or1200_dc_top_or1200_dc_fsm_store_inhibit_ack  =(  or1200_dc_top_or1200_dc_fsm_state  ==3'd1)&  or1200_dc_top_or1200_dc_fsm_store  &  or1200_dc_top_or1200_dc_fsm_cache_inhibit  &  or1200_dc_top_or1200_dc_fsm_biudata_valid  ; 
  assign   or1200_dc_top_or1200_dc_fsm_load_miss_ack  =((  or1200_dc_top_or1200_dc_fsm_state  ==3'd2)&  or1200_dc_top_or1200_dc_fsm_load  &(  or1200_dc_top_or1200_dc_fsm_cnt  ==((1<<4)-4))&  or1200_dc_top_or1200_dc_fsm_biudata_valid  &!(  or1200_dc_top_or1200_dc_fsm_dcqmem_we_i  &!  or1200_dc_top_or1200_dc_fsm_writethrough  )); 
  assign   or1200_dc_top_or1200_dc_fsm_load_inhibit_ack  =(  or1200_dc_top_or1200_dc_fsm_state  ==3'd1)&  or1200_dc_top_or1200_dc_fsm_load  &  or1200_dc_top_or1200_dc_fsm_cache_inhibit  &  or1200_dc_top_or1200_dc_fsm_biudata_valid  ; 
  assign   or1200_dc_top_or1200_dc_fsm_store_miss_ack  =  or1200_dc_top_or1200_dc_fsm_dcram_we_after_line_load  ; 
  assign   or1200_dc_top_or1200_dc_fsm_first_miss_err  =  or1200_dc_top_or1200_dc_fsm_biudata_error  &  or1200_dc_top_or1200_dc_fsm_dcqmem_cycstb_i  ; 
  assign   or1200_dc_top_or1200_dc_fsm_burst  =(  or1200_dc_top_or1200_dc_fsm_state  ==3'd2); 
  always @(  posedge    or1200_dc_top_or1200_dc_fsm_clk          or  posedge   or1200_dc_top_or1200_dc_fsm_rst  )
       begin 
         if (  or1200_dc_top_or1200_dc_fsm_rst  ==(1'b1))
            begin  
               or1200_dc_top_or1200_dc_fsm_state   <=3'd0; 
               or1200_dc_top_or1200_dc_fsm_addr_r   <=32'd0; 
               or1200_dc_top_or1200_dc_fsm_hitmiss_eval   <=1'b0; 
               or1200_dc_top_or1200_dc_fsm_store   <=1'b0; 
               or1200_dc_top_or1200_dc_fsm_load   <=1'b0; 
               or1200_dc_top_or1200_dc_fsm_cnt   <=4'd0; 
               or1200_dc_top_or1200_dc_fsm_cache_miss   <=1'b0; 
               or1200_dc_top_or1200_dc_fsm_cache_dirty_needs_writeback   <=1'b0; 
               or1200_dc_top_or1200_dc_fsm_cache_inhibit   <=1'b0; 
               or1200_dc_top_or1200_dc_fsm_did_early_load_ack   <=1'b0; 
               or1200_dc_top_or1200_dc_fsm_cache_spr_block_flush   <=1'b0; 
               or1200_dc_top_or1200_dc_fsm_cache_spr_block_writeback   <=1'b0;
            end 
          else 
            case (  or1200_dc_top_or1200_dc_fsm_state  )
             3 'd0:
                begin 
                  if (  or1200_dc_top_or1200_dc_fsm_dc_en  &(  or1200_dc_top_or1200_dc_fsm_dc_block_flush  |  or1200_dc_top_or1200_dc_fsm_dc_block_writeback  ))
                     begin  
                        or1200_dc_top_or1200_dc_fsm_cache_spr_block_flush   <=  or1200_dc_top_or1200_dc_fsm_dc_block_flush  ; 
                        or1200_dc_top_or1200_dc_fsm_cache_spr_block_writeback   <=  or1200_dc_top_or1200_dc_fsm_dc_block_writeback  ; 
                        or1200_dc_top_or1200_dc_fsm_hitmiss_eval   <=1'b1; 
                        or1200_dc_top_or1200_dc_fsm_state   <=3'd5; 
                        or1200_dc_top_or1200_dc_fsm_addr_r   <=  or1200_dc_top_or1200_dc_fsm_spr_dat_i  ;
                     end 
                   else 
                     if (  or1200_dc_top_or1200_dc_fsm_dc_en  &  or1200_dc_top_or1200_dc_fsm_dcqmem_cycstb_i  )
                        begin  
                           or1200_dc_top_or1200_dc_fsm_state   <=3'd1; 
                           or1200_dc_top_or1200_dc_fsm_hitmiss_eval   <=1'b1; 
                           or1200_dc_top_or1200_dc_fsm_store   <=  or1200_dc_top_or1200_dc_fsm_dcqmem_we_i  ; 
                           or1200_dc_top_or1200_dc_fsm_load   <=!  or1200_dc_top_or1200_dc_fsm_dcqmem_we_i  ;
                        end 
                end 
             3 'd1:
                begin  
                   or1200_dc_top_or1200_dc_fsm_hitmiss_eval   <=1'b0;
                  if (  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  )
                     begin  
                        or1200_dc_top_or1200_dc_fsm_cache_inhibit   <=  or1200_dc_top_or1200_dc_fsm_dcqmem_ci_i  ; 
                        or1200_dc_top_or1200_dc_fsm_cache_miss   <=  or1200_dc_top_or1200_dc_fsm_tagcomp_miss  ; 
                        or1200_dc_top_or1200_dc_fsm_cache_dirty_needs_writeback   <=  or1200_dc_top_or1200_dc_fsm_dirty  ; 
                        or1200_dc_top_or1200_dc_fsm_addr_r   <=  or1200_dc_top_or1200_dc_fsm_lsu_addr  ;
                     end 
                  if (  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  &  or1200_dc_top_or1200_dc_fsm_tagcomp_miss  &!(  or1200_dc_top_or1200_dc_fsm_store  &  or1200_dc_top_or1200_dc_fsm_writethrough  )&!  or1200_dc_top_or1200_dc_fsm_dcqmem_ci_i  )
                     begin 
                       if (  or1200_dc_top_or1200_dc_fsm_dirty  )
                          begin  
                             or1200_dc_top_or1200_dc_fsm_addr_r   <={  or1200_dc_top_or1200_dc_fsm_tag  ,  or1200_dc_top_or1200_dc_fsm_lsu_addr  [13-1:2],2'd0}; 
                             or1200_dc_top_or1200_dc_fsm_load   <=1'b0; 
                             or1200_dc_top_or1200_dc_fsm_store   <=1'b1;
                          end 
                        else 
                          begin  
                             or1200_dc_top_or1200_dc_fsm_addr_r   <=  or1200_dc_top_or1200_dc_fsm_lsu_addr  ; 
                             or1200_dc_top_or1200_dc_fsm_load   <=1'b1; 
                             or1200_dc_top_or1200_dc_fsm_store   <=1'b0;
                          end  
                        or1200_dc_top_or1200_dc_fsm_state   <=3'd2; 
                        or1200_dc_top_or1200_dc_fsm_cnt   <=((1<<4)-4);
                     end 
                   else 
                     if (!  or1200_dc_top_or1200_dc_fsm_dcqmem_cycstb_i  |(!  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  &(  or1200_dc_top_or1200_dc_fsm_biudata_valid  |  or1200_dc_top_or1200_dc_fsm_biudata_error  ))|(  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  &!  or1200_dc_top_or1200_dc_fsm_tagcomp_miss  &!  or1200_dc_top_or1200_dc_fsm_dcqmem_ci_i  &!(  or1200_dc_top_or1200_dc_fsm_store  &  or1200_dc_top_or1200_dc_fsm_writethrough  )))
                        begin  
                           or1200_dc_top_or1200_dc_fsm_state   <=3'd0; 
                           or1200_dc_top_or1200_dc_fsm_load   <=1'b0; 
                           or1200_dc_top_or1200_dc_fsm_store   <=1'b0; 
                           or1200_dc_top_or1200_dc_fsm_cache_inhibit   <=1'b0; 
                           or1200_dc_top_or1200_dc_fsm_cache_dirty_needs_writeback   <=1'b0;
                        end 
                end 
             3 'd2:
                begin 
                  if (!  or1200_dc_top_or1200_dc_fsm_dc_en  |  or1200_dc_top_or1200_dc_fsm_biudata_error  )
                     begin  
                        or1200_dc_top_or1200_dc_fsm_state   <=3'd0; 
                        or1200_dc_top_or1200_dc_fsm_load   <=1'b0; 
                        or1200_dc_top_or1200_dc_fsm_store   <=1'b0; 
                        or1200_dc_top_or1200_dc_fsm_cnt   <=4'd0;
                     end 
                  if (  or1200_dc_top_or1200_dc_fsm_biudata_valid  &(|  or1200_dc_top_or1200_dc_fsm_cnt  ))
                     begin  
                        or1200_dc_top_or1200_dc_fsm_cnt   <=  or1200_dc_top_or1200_dc_fsm_cnt  -4; 
                        or1200_dc_top_or1200_dc_fsm_addr_r   [4-1:2]<=  or1200_dc_top_or1200_dc_fsm_addr_r  [4-1:2]+1;
                     end 
                   else 
                     if (  or1200_dc_top_or1200_dc_fsm_biudata_valid  &!(|  or1200_dc_top_or1200_dc_fsm_cnt  ))
                        begin  
                           or1200_dc_top_or1200_dc_fsm_state   <=3'd3; 
                           or1200_dc_top_or1200_dc_fsm_addr_r   <=  or1200_dc_top_or1200_dc_fsm_lsu_addr  ; 
                           or1200_dc_top_or1200_dc_fsm_load   <=1'b0; 
                           or1200_dc_top_or1200_dc_fsm_store   <=1'b0;
                        end 
                  if (  or1200_dc_top_or1200_dc_fsm_load_miss_ack  ) 
                      or1200_dc_top_or1200_dc_fsm_did_early_load_ack   <=1'b1;
                end 
             3 'd3:
                begin 
                  if (  or1200_dc_top_or1200_dc_fsm_cache_dirty_needs_writeback  )
                     begin  
                        or1200_dc_top_or1200_dc_fsm_load   <=1'b1; 
                        or1200_dc_top_or1200_dc_fsm_cnt   <=((1<<4)-4); 
                        or1200_dc_top_or1200_dc_fsm_addr_r   <=  or1200_dc_top_or1200_dc_fsm_lsu_addr  ; 
                        or1200_dc_top_or1200_dc_fsm_cache_dirty_needs_writeback   <=1'b0; 
                        or1200_dc_top_or1200_dc_fsm_state   <=3'd2;
                     end 
                   else 
                     if (  or1200_dc_top_or1200_dc_fsm_cache_spr_block_flush  |  or1200_dc_top_or1200_dc_fsm_cache_spr_block_writeback  )
                        begin  
                           or1200_dc_top_or1200_dc_fsm_cache_spr_block_flush   <=1'b0; 
                           or1200_dc_top_or1200_dc_fsm_cache_spr_block_writeback   <=1'b0; 
                           or1200_dc_top_or1200_dc_fsm_state   <=3'd7;
                        end 
                      else 
                        begin  
                           or1200_dc_top_or1200_dc_fsm_did_early_load_ack   <=1'b0; 
                           or1200_dc_top_or1200_dc_fsm_state   <=3'd4;
                        end 
                end 
             3 'd4:
                begin  
                   or1200_dc_top_or1200_dc_fsm_state   <=3'd0;
                end 
             3 'd5:
                begin  
                   or1200_dc_top_or1200_dc_fsm_hitmiss_eval   <=1'b0;
                  if (  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  &!  or1200_dc_top_or1200_dc_fsm_tag_v  )
                     begin  
                        or1200_dc_top_or1200_dc_fsm_cache_spr_block_flush   <=1'b0; 
                        or1200_dc_top_or1200_dc_fsm_cache_spr_block_writeback   <=1'b0; 
                        or1200_dc_top_or1200_dc_fsm_state   <=3'd7;
                     end 
                   else 
                     if (  or1200_dc_top_or1200_dc_fsm_hitmiss_eval  &  or1200_dc_top_or1200_dc_fsm_tag_v  )
                        begin 
                          if ((  or1200_dc_top_or1200_dc_fsm_cache_spr_block_flush  |  or1200_dc_top_or1200_dc_fsm_cache_spr_block_writeback  )&  or1200_dc_top_or1200_dc_fsm_dirty  )
                             begin  
                                or1200_dc_top_or1200_dc_fsm_addr_r   <={  or1200_dc_top_or1200_dc_fsm_tag  ,  or1200_dc_top_or1200_dc_fsm_addr_r  [13-1:2],2'd0}; 
                                or1200_dc_top_or1200_dc_fsm_load   <=1'b0; 
                                or1200_dc_top_or1200_dc_fsm_store   <=1'b1; 
                                or1200_dc_top_or1200_dc_fsm_state   <=3'd2; 
                                or1200_dc_top_or1200_dc_fsm_cnt   <=((1<<4)-4);
                             end 
                           else 
                             if (  or1200_dc_top_or1200_dc_fsm_cache_spr_block_flush  &!  or1200_dc_top_or1200_dc_fsm_dirty  )
                                begin  
                                   or1200_dc_top_or1200_dc_fsm_state   <=3'd6;
                                end 
                              else 
                                if (  or1200_dc_top_or1200_dc_fsm_cache_spr_block_writeback  &!  or1200_dc_top_or1200_dc_fsm_dirty  )
                                   begin  
                                      or1200_dc_top_or1200_dc_fsm_cache_spr_block_writeback   <=1'b0; 
                                      or1200_dc_top_or1200_dc_fsm_state   <=3'd7;
                                   end 
                        end 
                end 
             3 'd6:
                begin  
                   or1200_dc_top_or1200_dc_fsm_cache_spr_block_flush   <=1'b0;
                  if (!  or1200_dc_top_or1200_dc_fsm_spr_cswe  ) 
                      or1200_dc_top_or1200_dc_fsm_state   <=3'd0;
                end 
             3 'd7:
                begin 
                  if (!  or1200_dc_top_or1200_dc_fsm_spr_cswe  ) 
                      or1200_dc_top_or1200_dc_fsm_state   <=3'd0;
                end 
            endcase 
       end
 
assign or1200_dc_top_or1200_dc_fsm_clk = or1200_dc_top_clk;
assign or1200_dc_top_or1200_dc_fsm_rst = or1200_dc_top_rst;
assign or1200_dc_top_or1200_dc_fsm_dc_en = or1200_dc_top_dc_en;
assign or1200_dc_top_or1200_dc_fsm_dcqmem_cycstb_i = or1200_dc_top_dcqmem_cycstb_i;
assign or1200_dc_top_or1200_dc_fsm_dcqmem_ci_i = or1200_dc_top_dcqmem_ci_i;
assign or1200_dc_top_or1200_dc_fsm_dcqmem_we_i = or1200_dc_top_dcqmem_we_i;
assign or1200_dc_top_or1200_dc_fsm_dcqmem_sel_i = or1200_dc_top_dcqmem_sel_i;
assign or1200_dc_top_or1200_dc_fsm_tagcomp_miss = or1200_dc_top_tagcomp_miss;
assign or1200_dc_top_or1200_dc_fsm_biudata_valid = or1200_dc_top_dcsb_ack_i;
assign or1200_dc_top_or1200_dc_fsm_biudata_error = or1200_dc_top_dcsb_err_i;
assign or1200_dc_top_or1200_dc_fsm_lsu_addr = or1200_dc_top_dcqmem_adr_i;
assign or1200_dc_top_dcram_we = or1200_dc_top_or1200_dc_fsm_dcram_we;
assign or1200_dc_top_dcfsm_biu_read = or1200_dc_top_or1200_dc_fsm_biu_read;
assign or1200_dc_top_dcfsm_biu_write = or1200_dc_top_or1200_dc_fsm_biu_write;
assign or1200_dc_top_dcfsm_biu_do_sel = or1200_dc_top_or1200_dc_fsm_biu_do_sel;
assign or1200_dc_top_dcfsm_dcram_di_sel = or1200_dc_top_or1200_dc_fsm_dcram_di_sel;
assign or1200_dc_top_dcfsm_first_hit_ack = or1200_dc_top_or1200_dc_fsm_first_hit_ack;
assign or1200_dc_top_dcfsm_first_miss_ack = or1200_dc_top_or1200_dc_fsm_first_miss_ack;
assign or1200_dc_top_dcfsm_first_miss_err = or1200_dc_top_or1200_dc_fsm_first_miss_err;
assign or1200_dc_top_dcfsm_burst = or1200_dc_top_or1200_dc_fsm_burst;
assign or1200_dc_top_dcfsm_tag_we = or1200_dc_top_or1200_dc_fsm_tag_we;
assign or1200_dc_top_dcfsm_tag_valid = or1200_dc_top_or1200_dc_fsm_tag_valid;
assign or1200_dc_top_dc_addr = or1200_dc_top_or1200_dc_fsm_dc_addr;
assign or1200_dc_top_or1200_dc_fsm_dc_no_writethrough = or1200_dc_top_dc_no_writethrough;
assign or1200_dc_top_dcfsm_tag_dirty = or1200_dc_top_or1200_dc_fsm_tag_dirty;
assign or1200_dc_top_or1200_dc_fsm_dirty = or1200_dc_top_dirty;
assign or1200_dc_top_or1200_dc_fsm_tag = or1200_dc_top_tag;
assign or1200_dc_top_or1200_dc_fsm_tag_v = or1200_dc_top_tag_v;
assign or1200_dc_top_or1200_dc_fsm_dc_block_flush = or1200_dc_top_dc_block_flush;
assign or1200_dc_top_or1200_dc_fsm_dc_block_writeback = or1200_dc_top_dc_block_writeback;
assign or1200_dc_top_or1200_dc_fsm_spr_dat_i = or1200_dc_top_spr_dat_i;
assign or1200_dc_top_mtspr_dc_done = or1200_dc_top_or1200_dc_fsm_mtspr_dc_done;
assign or1200_dc_top_or1200_dc_fsm_spr_cswe = or1200_dc_top_spr_cs&or1200_dc_top_spr_write;
  
  
wire  or1200_dc_top_or1200_dc_ram_clk;
wire  or1200_dc_top_or1200_dc_ram_rst;
wire [ or1200_dc_top_or1200_dc_ram_aw -1:0] or1200_dc_top_or1200_dc_ram_addr;
wire  or1200_dc_top_or1200_dc_ram_en;
wire [3:0] or1200_dc_top_or1200_dc_ram_we;
wire [ or1200_dc_top_or1200_dc_ram_dw -1:0] or1200_dc_top_or1200_dc_ram_datain;
wire [ or1200_dc_top_or1200_dc_ram_dw -1:0] or1200_dc_top_or1200_dc_ram_dataout;
  
  
wire  or1200_dc_top_or1200_dc_ram_dc_ram_clk;
wire  or1200_dc_top_or1200_dc_ram_dc_ram_ce;
wire [3:0] or1200_dc_top_or1200_dc_ram_dc_ram_we;
wire [ or1200_dc_top_or1200_dc_ram_dc_ram_aw -1:0] or1200_dc_top_or1200_dc_ram_dc_ram_addr;
wire [ or1200_dc_top_or1200_dc_ram_dc_ram_dw -1:0] or1200_dc_top_or1200_dc_ram_dc_ram_di;
wire [ or1200_dc_top_or1200_dc_ram_dc_ram_dw -1:0] or1200_dc_top_or1200_dc_ram_dc_ram_doq;
 
   reg[7:0]  or1200_dc_top_or1200_dc_ram_dc_ram_mem0  [(1<<  or1200_dc_top_or1200_dc_ram_dc_ram_aw  )-1:0]; 
   reg[7:0]  or1200_dc_top_or1200_dc_ram_dc_ram_mem1  [(1<<  or1200_dc_top_or1200_dc_ram_dc_ram_aw  )-1:0]; 
   reg[7:0]  or1200_dc_top_or1200_dc_ram_dc_ram_mem2  [(1<<  or1200_dc_top_or1200_dc_ram_dc_ram_aw  )-1:0]; 
   reg[7:0]  or1200_dc_top_or1200_dc_ram_dc_ram_mem3  [(1<<  or1200_dc_top_or1200_dc_ram_dc_ram_aw  )-1:0]; 
   reg[  or1200_dc_top_or1200_dc_ram_dc_ram_aw  -1:0]  or1200_dc_top_or1200_dc_ram_dc_ram_addr_reg  ; 
  assign   or1200_dc_top_or1200_dc_ram_dc_ram_doq  ={  or1200_dc_top_or1200_dc_ram_dc_ram_mem0  [  or1200_dc_top_or1200_dc_ram_dc_ram_addr_reg  ],  or1200_dc_top_or1200_dc_ram_dc_ram_mem1  [  or1200_dc_top_or1200_dc_ram_dc_ram_addr_reg  ],  or1200_dc_top_or1200_dc_ram_dc_ram_mem2  [  or1200_dc_top_or1200_dc_ram_dc_ram_addr_reg  ],  or1200_dc_top_or1200_dc_ram_dc_ram_mem3  [  or1200_dc_top_or1200_dc_ram_dc_ram_addr_reg  ]}; 
  always @( posedge   or1200_dc_top_or1200_dc_ram_dc_ram_clk  )
       if (  or1200_dc_top_or1200_dc_ram_dc_ram_ce  ) 
           or1200_dc_top_or1200_dc_ram_dc_ram_addr_reg   <=  or1200_dc_top_or1200_dc_ram_dc_ram_addr  ;
 
  always @( posedge   or1200_dc_top_or1200_dc_ram_dc_ram_clk  )
       if (  or1200_dc_top_or1200_dc_ram_dc_ram_ce  )
          begin 
            if (  or1200_dc_top_or1200_dc_ram_dc_ram_we  [3]) 
                or1200_dc_top_or1200_dc_ram_dc_ram_mem0   [  or1200_dc_top_or1200_dc_ram_dc_ram_addr  ]<=  or1200_dc_top_or1200_dc_ram_dc_ram_di  [31:24];
            if (  or1200_dc_top_or1200_dc_ram_dc_ram_we  [2]) 
                or1200_dc_top_or1200_dc_ram_dc_ram_mem1   [  or1200_dc_top_or1200_dc_ram_dc_ram_addr  ]<=  or1200_dc_top_or1200_dc_ram_dc_ram_di  [23:16];
            if (  or1200_dc_top_or1200_dc_ram_dc_ram_we  [1]) 
                or1200_dc_top_or1200_dc_ram_dc_ram_mem2   [  or1200_dc_top_or1200_dc_ram_dc_ram_addr  ]<=  or1200_dc_top_or1200_dc_ram_dc_ram_di  [15:08];
            if (  or1200_dc_top_or1200_dc_ram_dc_ram_we  [0]) 
                or1200_dc_top_or1200_dc_ram_dc_ram_mem3   [  or1200_dc_top_or1200_dc_ram_dc_ram_addr  ]<=  or1200_dc_top_or1200_dc_ram_dc_ram_di  [07:00];
          end
 
assign or1200_dc_top_or1200_dc_ram_dc_ram_clk = or1200_dc_top_or1200_dc_ram_clk;
assign or1200_dc_top_or1200_dc_ram_dc_ram_ce = or1200_dc_top_or1200_dc_ram_en;
assign or1200_dc_top_or1200_dc_ram_dc_ram_we = or1200_dc_top_or1200_dc_ram_we;
assign or1200_dc_top_or1200_dc_ram_dc_ram_addr = or1200_dc_top_or1200_dc_ram_addr;
assign or1200_dc_top_or1200_dc_ram_dc_ram_di = or1200_dc_top_or1200_dc_ram_datain;
assign or1200_dc_top_or1200_dc_ram_dataout = or1200_dc_top_or1200_dc_ram_dc_ram_doq;

assign or1200_dc_top_or1200_dc_ram_clk = or1200_dc_top_clk;
assign or1200_dc_top_or1200_dc_ram_rst = or1200_dc_top_rst;
assign or1200_dc_top_or1200_dc_ram_addr = or1200_dc_top_dc_addr[13-1:2];
assign or1200_dc_top_or1200_dc_ram_en = or1200_dc_top_dc_en;
assign or1200_dc_top_or1200_dc_ram_we = or1200_dc_top_dcram_we;
assign or1200_dc_top_or1200_dc_ram_datain = or1200_dc_top_to_dcram;
assign or1200_dc_top_from_dcram = or1200_dc_top_or1200_dc_ram_dataout;
  
  
wire  or1200_dc_top_or1200_dc_tag_clk;
wire  or1200_dc_top_or1200_dc_tag_rst;
wire [ or1200_dc_top_or1200_dc_tag_aw -1:0] or1200_dc_top_or1200_dc_tag_addr;
wire  or1200_dc_top_or1200_dc_tag_en;
wire  or1200_dc_top_or1200_dc_tag_we;
wire [ or1200_dc_top_or1200_dc_tag_dw -1:0] or1200_dc_top_or1200_dc_tag_datain;
wire  or1200_dc_top_or1200_dc_tag_tag_v;
wire [ or1200_dc_top_or1200_dc_tag_dw -3:0] or1200_dc_top_or1200_dc_tag_tag;
wire  or1200_dc_top_or1200_dc_tag_dirty;
  
  
wire  or1200_dc_top_or1200_dc_tag_dc_tag0_clk;
wire  or1200_dc_top_or1200_dc_tag_dc_tag0_ce;
wire  or1200_dc_top_or1200_dc_tag_dc_tag0_we;
wire [ or1200_dc_top_or1200_dc_tag_dc_tag0_aw -1:0] or1200_dc_top_or1200_dc_tag_dc_tag0_addr;
wire [ or1200_dc_top_or1200_dc_tag_dc_tag0_dw -1:0] or1200_dc_top_or1200_dc_tag_dc_tag0_di;
wire [ or1200_dc_top_or1200_dc_tag_dc_tag0_dw -1:0] or1200_dc_top_or1200_dc_tag_dc_tag0_doq;
 
   reg[  or1200_dc_top_or1200_dc_tag_dc_tag0_dw  -1:0]  or1200_dc_top_or1200_dc_tag_dc_tag0_mem  [(1<<  or1200_dc_top_or1200_dc_tag_dc_tag0_aw  )-1:0]; 
   reg[  or1200_dc_top_or1200_dc_tag_dc_tag0_aw  -1:0]  or1200_dc_top_or1200_dc_tag_dc_tag0_addr_reg  ; 
  assign   or1200_dc_top_or1200_dc_tag_dc_tag0_doq  =  or1200_dc_top_or1200_dc_tag_dc_tag0_mem  [  or1200_dc_top_or1200_dc_tag_dc_tag0_addr_reg  ]; 
  always @( posedge   or1200_dc_top_or1200_dc_tag_dc_tag0_clk  )
       if (  or1200_dc_top_or1200_dc_tag_dc_tag0_ce  ) 
           or1200_dc_top_or1200_dc_tag_dc_tag0_addr_reg   <=  or1200_dc_top_or1200_dc_tag_dc_tag0_addr  ;
 
  always @( posedge   or1200_dc_top_or1200_dc_tag_dc_tag0_clk  )
       if (  or1200_dc_top_or1200_dc_tag_dc_tag0_we  &&  or1200_dc_top_or1200_dc_tag_dc_tag0_ce  ) 
           or1200_dc_top_or1200_dc_tag_dc_tag0_mem   [  or1200_dc_top_or1200_dc_tag_dc_tag0_addr  ]<=  or1200_dc_top_or1200_dc_tag_dc_tag0_di  ;

assign or1200_dc_top_or1200_dc_tag_dc_tag0_clk = or1200_dc_top_or1200_dc_tag_clk;
assign or1200_dc_top_or1200_dc_tag_dc_tag0_ce = or1200_dc_top_or1200_dc_tag_en;
assign or1200_dc_top_or1200_dc_tag_dc_tag0_we = or1200_dc_top_or1200_dc_tag_we;
assign or1200_dc_top_or1200_dc_tag_dc_tag0_addr = or1200_dc_top_or1200_dc_tag_addr;
assign or1200_dc_top_or1200_dc_tag_dc_tag0_di = or1200_dc_top_or1200_dc_tag_datain;
assign {or1200_dc_top_or1200_dc_tag_tag,or1200_dc_top_or1200_dc_tag_tag_v,or1200_dc_top_or1200_dc_tag_dirty} = or1200_dc_top_or1200_dc_tag_dc_tag0_doq;

assign or1200_dc_top_or1200_dc_tag_clk = or1200_dc_top_clk;
assign or1200_dc_top_or1200_dc_tag_rst = or1200_dc_top_rst;
assign or1200_dc_top_or1200_dc_tag_addr = or1200_dc_top_dctag_addr;
assign or1200_dc_top_or1200_dc_tag_en = or1200_dc_top_dctag_en;
assign or1200_dc_top_or1200_dc_tag_we = or1200_dc_top_dctag_we;
assign or1200_dc_top_or1200_dc_tag_datain = {or1200_dc_top_dc_addr[31:13-1+1],or1200_dc_top_dctag_v,or1200_dc_top_dctag_dirty};
assign or1200_dc_top_tag_v = or1200_dc_top_or1200_dc_tag_tag_v;
assign or1200_dc_top_tag = or1200_dc_top_or1200_dc_tag_tag;
assign or1200_dc_top_dirty = or1200_dc_top_or1200_dc_tag_dirty;

assign or1200_dc_top_clk = clk_i;
assign or1200_dc_top_rst = rst_i;
assign dcsb_dat_dc = or1200_dc_top_dcsb_dat_o;
assign dcsb_adr_dc = or1200_dc_top_dcsb_adr_o;
assign dcsb_cyc_dc = or1200_dc_top_dcsb_cyc_o;
assign dcsb_stb_dc = or1200_dc_top_dcsb_stb_o;
assign dcsb_we_dc = or1200_dc_top_dcsb_we_o;
assign dcsb_sel_dc = or1200_dc_top_dcsb_sel_o;
assign dcsb_cab_dc = or1200_dc_top_dcsb_cab_o;
assign or1200_dc_top_dcsb_dat_i = dcsb_dat_sb;
assign or1200_dc_top_dcsb_ack_i = dcsb_ack_sb;
assign or1200_dc_top_dcsb_err_i = dcsb_err_sb;
assign or1200_dc_top_dc_en = dc_en;
assign or1200_dc_top_dcqmem_adr_i = dcqmem_adr_qmem;
assign or1200_dc_top_dcqmem_cycstb_i = dcqmem_cycstb_qmem;
assign or1200_dc_top_dcqmem_ci_i = dcqmem_ci_qmem;
assign or1200_dc_top_dcqmem_we_i = dcqmem_we_qmem;
assign or1200_dc_top_dcqmem_sel_i = dcqmem_sel_qmem;
assign or1200_dc_top_dcqmem_tag_i = dcqmem_tag_qmem;
assign or1200_dc_top_dcqmem_dat_i = dcqmem_dat_qmem;
assign dcqmem_dat_dc = or1200_dc_top_dcqmem_dat_o;
assign dcqmem_ack_dc = or1200_dc_top_dcqmem_ack_o;
assign dcqmem_rty_dc = or1200_dc_top_dcqmem_rty_o;
assign dcqmem_err_dc = or1200_dc_top_dcqmem_err_o;
assign dcqmem_tag_dc = or1200_dc_top_dcqmem_tag_o;
assign or1200_dc_top_dc_no_writethrough = dc_no_writethrough;
assign or1200_dc_top_spr_cs = spr_cs[5'd03];
assign or1200_dc_top_spr_write = spr_we;
assign or1200_dc_top_spr_dat_i = spr_dat_cpu;
assign or1200_dc_top_spr_addr = spr_addr;
assign mtspr_dc_done = or1200_dc_top_mtspr_dc_done;
 
  
wire  or1200_qmem_top_clk;
wire  or1200_qmem_top_rst;
wire [31:0] or1200_qmem_top_qmemimmu_adr_i;
wire  or1200_qmem_top_qmemimmu_cycstb_i;
wire  or1200_qmem_top_qmemimmu_ci_i;
wire [3:0] or1200_qmem_top_qmemicpu_sel_i;
wire [3:0] or1200_qmem_top_qmemicpu_tag_i;
wire [31:0] or1200_qmem_top_qmemicpu_dat_o;
wire  or1200_qmem_top_qmemicpu_ack_o;
wire  or1200_qmem_top_qmemimmu_rty_o;
wire  or1200_qmem_top_qmemimmu_err_o;
wire [3:0] or1200_qmem_top_qmemimmu_tag_o;
wire [31:0] or1200_qmem_top_icqmem_adr_o;
wire  or1200_qmem_top_icqmem_cycstb_o;
wire  or1200_qmem_top_icqmem_ci_o;
wire [3:0] or1200_qmem_top_icqmem_sel_o;
wire [3:0] or1200_qmem_top_icqmem_tag_o;
wire [31:0] or1200_qmem_top_icqmem_dat_i;
wire  or1200_qmem_top_icqmem_ack_i;
wire  or1200_qmem_top_icqmem_rty_i;
wire  or1200_qmem_top_icqmem_err_i;
wire [3:0] or1200_qmem_top_icqmem_tag_i;
wire [31:0] or1200_qmem_top_qmemdmmu_adr_i;
wire  or1200_qmem_top_qmemdmmu_cycstb_i;
wire  or1200_qmem_top_qmemdmmu_ci_i;
wire  or1200_qmem_top_qmemdcpu_we_i;
wire [3:0] or1200_qmem_top_qmemdcpu_sel_i;
wire [3:0] or1200_qmem_top_qmemdcpu_tag_i;
wire [31:0] or1200_qmem_top_qmemdcpu_dat_i;
wire [31:0] or1200_qmem_top_qmemdcpu_dat_o;
wire  or1200_qmem_top_qmemdcpu_ack_o;
wire  or1200_qmem_top_qmemdcpu_rty_o;
wire  or1200_qmem_top_qmemdmmu_err_o;
wire [3:0] or1200_qmem_top_qmemdmmu_tag_o;
wire [31:0] or1200_qmem_top_dcqmem_adr_o;
wire  or1200_qmem_top_dcqmem_cycstb_o;
wire  or1200_qmem_top_dcqmem_ci_o;
wire  or1200_qmem_top_dcqmem_we_o;
wire [3:0] or1200_qmem_top_dcqmem_sel_o;
wire [3:0] or1200_qmem_top_dcqmem_tag_o;
wire [ or1200_qmem_top_dw -1:0] or1200_qmem_top_dcqmem_dat_o;
wire [ or1200_qmem_top_dw -1:0] or1200_qmem_top_dcqmem_dat_i;
wire  or1200_qmem_top_dcqmem_ack_i;
wire  or1200_qmem_top_dcqmem_rty_i;
wire  or1200_qmem_top_dcqmem_err_i;
wire [3:0] or1200_qmem_top_dcqmem_tag_i;
 
  assign   or1200_qmem_top_qmemicpu_dat_o  =  or1200_qmem_top_icqmem_dat_i  ; 
  assign   or1200_qmem_top_qmemicpu_ack_o  =  or1200_qmem_top_icqmem_ack_i  ; 
  assign   or1200_qmem_top_qmemimmu_rty_o  =  or1200_qmem_top_icqmem_rty_i  ; 
  assign   or1200_qmem_top_qmemimmu_err_o  =  or1200_qmem_top_icqmem_err_i  ; 
  assign   or1200_qmem_top_qmemimmu_tag_o  =  or1200_qmem_top_icqmem_tag_i  ; 
  assign   or1200_qmem_top_icqmem_adr_o  =  or1200_qmem_top_qmemimmu_adr_i  ; 
  assign   or1200_qmem_top_icqmem_cycstb_o  =  or1200_qmem_top_qmemimmu_cycstb_i  ; 
  assign   or1200_qmem_top_icqmem_ci_o  =  or1200_qmem_top_qmemimmu_ci_i  ; 
  assign   or1200_qmem_top_icqmem_sel_o  =  or1200_qmem_top_qmemicpu_sel_i  ; 
  assign   or1200_qmem_top_icqmem_tag_o  =  or1200_qmem_top_qmemicpu_tag_i  ; 
  assign   or1200_qmem_top_qmemdcpu_dat_o  =  or1200_qmem_top_dcqmem_dat_i  ; 
  assign   or1200_qmem_top_qmemdcpu_ack_o  =  or1200_qmem_top_dcqmem_ack_i  ; 
  assign   or1200_qmem_top_qmemdcpu_rty_o  =  or1200_qmem_top_dcqmem_rty_i  ; 
  assign   or1200_qmem_top_qmemdmmu_err_o  =  or1200_qmem_top_dcqmem_err_i  ; 
  assign   or1200_qmem_top_qmemdmmu_tag_o  =  or1200_qmem_top_dcqmem_tag_i  ; 
  assign   or1200_qmem_top_dcqmem_adr_o  =  or1200_qmem_top_qmemdmmu_adr_i  ; 
  assign   or1200_qmem_top_dcqmem_cycstb_o  =  or1200_qmem_top_qmemdmmu_cycstb_i  ; 
  assign   or1200_qmem_top_dcqmem_ci_o  =  or1200_qmem_top_qmemdmmu_ci_i  ; 
  assign   or1200_qmem_top_dcqmem_we_o  =  or1200_qmem_top_qmemdcpu_we_i  ; 
  assign   or1200_qmem_top_dcqmem_sel_o  =  or1200_qmem_top_qmemdcpu_sel_i  ; 
  assign   or1200_qmem_top_dcqmem_tag_o  =  or1200_qmem_top_qmemdcpu_tag_i  ; 
  assign   or1200_qmem_top_dcqmem_dat_o  =  or1200_qmem_top_qmemdcpu_dat_i  ;
assign or1200_qmem_top_clk = clk_i;
assign or1200_qmem_top_rst = rst_i;
assign or1200_qmem_top_qmemimmu_adr_i = qmemimmu_adr_immu;
assign or1200_qmem_top_qmemimmu_cycstb_i = qmemimmu_cycstb_immu;
assign or1200_qmem_top_qmemimmu_ci_i = qmemimmu_ci_immu;
assign or1200_qmem_top_qmemicpu_sel_i = icpu_sel_cpu;
assign or1200_qmem_top_qmemicpu_tag_i = icpu_tag_cpu;
assign icpu_dat_qmem = or1200_qmem_top_qmemicpu_dat_o;
assign icpu_ack_qmem = or1200_qmem_top_qmemicpu_ack_o;
assign qmemimmu_rty_qmem = or1200_qmem_top_qmemimmu_rty_o;
assign qmemimmu_err_qmem = or1200_qmem_top_qmemimmu_err_o;
assign qmemimmu_tag_qmem = or1200_qmem_top_qmemimmu_tag_o;
assign icqmem_adr_qmem = or1200_qmem_top_icqmem_adr_o;
assign icqmem_cycstb_qmem = or1200_qmem_top_icqmem_cycstb_o;
assign icqmem_ci_qmem = or1200_qmem_top_icqmem_ci_o;
assign icqmem_sel_qmem = or1200_qmem_top_icqmem_sel_o;
assign icqmem_tag_qmem = or1200_qmem_top_icqmem_tag_o;
assign or1200_qmem_top_icqmem_dat_i = icqmem_dat_ic;
assign or1200_qmem_top_icqmem_ack_i = icqmem_ack_ic;
assign or1200_qmem_top_icqmem_rty_i = icqmem_rty_ic;
assign or1200_qmem_top_icqmem_err_i = icqmem_err_ic;
assign or1200_qmem_top_icqmem_tag_i = icqmem_tag_ic;
assign or1200_qmem_top_qmemdmmu_adr_i = qmemdmmu_adr_dmmu;
assign or1200_qmem_top_qmemdmmu_cycstb_i = qmemdmmu_cycstb_dmmu;
assign or1200_qmem_top_qmemdmmu_ci_i = qmemdmmu_ci_dmmu;
assign or1200_qmem_top_qmemdcpu_we_i = dcpu_we_cpu;
assign or1200_qmem_top_qmemdcpu_sel_i = dcpu_sel_cpu;
assign or1200_qmem_top_qmemdcpu_tag_i = dcpu_tag_cpu;
assign or1200_qmem_top_qmemdcpu_dat_i = dcpu_dat_cpu;
assign dcpu_dat_qmem = or1200_qmem_top_qmemdcpu_dat_o;
assign dcpu_ack_qmem = or1200_qmem_top_qmemdcpu_ack_o;
assign dcpu_rty_qmem = or1200_qmem_top_qmemdcpu_rty_o;
assign qmemdmmu_err_qmem = or1200_qmem_top_qmemdmmu_err_o;
assign qmemdmmu_tag_qmem = or1200_qmem_top_qmemdmmu_tag_o;
assign dcqmem_adr_qmem = or1200_qmem_top_dcqmem_adr_o;
assign dcqmem_cycstb_qmem = or1200_qmem_top_dcqmem_cycstb_o;
assign dcqmem_ci_qmem = or1200_qmem_top_dcqmem_ci_o;
assign dcqmem_we_qmem = or1200_qmem_top_dcqmem_we_o;
assign dcqmem_sel_qmem = or1200_qmem_top_dcqmem_sel_o;
assign dcqmem_tag_qmem = or1200_qmem_top_dcqmem_tag_o;
assign dcqmem_dat_qmem = or1200_qmem_top_dcqmem_dat_o;
assign or1200_qmem_top_dcqmem_dat_i = dcqmem_dat_dc;
assign or1200_qmem_top_dcqmem_ack_i = dcqmem_ack_dc;
assign or1200_qmem_top_dcqmem_rty_i = dcqmem_rty_dc;
assign or1200_qmem_top_dcqmem_err_i = dcqmem_err_dc;
assign or1200_qmem_top_dcqmem_tag_i = dcqmem_tag_dc;
 
  
wire  or1200_sb_clk;
wire  or1200_sb_rst;
wire  or1200_sb_sb_en;
wire [ or1200_sb_dw -1:0] or1200_sb_dcsb_dat_i;
wire [ or1200_sb_aw -1:0] or1200_sb_dcsb_adr_i;
wire  or1200_sb_dcsb_cyc_i;
wire  or1200_sb_dcsb_stb_i;
wire  or1200_sb_dcsb_we_i;
wire [3:0] or1200_sb_dcsb_sel_i;
wire  or1200_sb_dcsb_cab_i;
wire [ or1200_sb_dw -1:0] or1200_sb_dcsb_dat_o;
wire  or1200_sb_dcsb_ack_o;
wire  or1200_sb_dcsb_err_o;
wire [ or1200_sb_dw -1:0] or1200_sb_sbbiu_dat_o;
wire [ or1200_sb_aw -1:0] or1200_sb_sbbiu_adr_o;
wire  or1200_sb_sbbiu_cyc_o;
wire  or1200_sb_sbbiu_stb_o;
wire  or1200_sb_sbbiu_we_o;
wire [3:0] or1200_sb_sbbiu_sel_o;
wire  or1200_sb_sbbiu_cab_o;
wire [ or1200_sb_dw -1:0] or1200_sb_sbbiu_dat_i;
wire  or1200_sb_sbbiu_ack_i;
wire  or1200_sb_sbbiu_err_i;
 
  assign   or1200_sb_sbbiu_dat_o  =  or1200_sb_dcsb_dat_i  ; 
  assign   or1200_sb_sbbiu_adr_o  =  or1200_sb_dcsb_adr_i  ; 
  assign   or1200_sb_sbbiu_cyc_o  =  or1200_sb_dcsb_cyc_i  ; 
  assign   or1200_sb_sbbiu_stb_o  =  or1200_sb_dcsb_stb_i  ; 
  assign   or1200_sb_sbbiu_we_o  =  or1200_sb_dcsb_we_i  ; 
  assign   or1200_sb_sbbiu_cab_o  =  or1200_sb_dcsb_cab_i  ; 
  assign   or1200_sb_sbbiu_sel_o  =  or1200_sb_dcsb_sel_i  ; 
  assign   or1200_sb_dcsb_dat_o  =  or1200_sb_sbbiu_dat_i  ; 
  assign   or1200_sb_dcsb_ack_o  =  or1200_sb_sbbiu_ack_i  ; 
  assign   or1200_sb_dcsb_err_o  =  or1200_sb_sbbiu_err_i  ;
assign or1200_sb_clk = clk_i;
assign or1200_sb_rst = rst_i;
assign or1200_sb_sb_en = sb_en;
assign or1200_sb_dcsb_dat_i = dcsb_dat_dc;
assign or1200_sb_dcsb_adr_i = dcsb_adr_dc;
assign or1200_sb_dcsb_cyc_i = dcsb_cyc_dc;
assign or1200_sb_dcsb_stb_i = dcsb_stb_dc;
assign or1200_sb_dcsb_we_i = dcsb_we_dc;
assign or1200_sb_dcsb_sel_i = dcsb_sel_dc;
assign or1200_sb_dcsb_cab_i = dcsb_cab_dc;
assign dcsb_dat_sb = or1200_sb_dcsb_dat_o;
assign dcsb_ack_sb = or1200_sb_dcsb_ack_o;
assign dcsb_err_sb = or1200_sb_dcsb_err_o;
assign sbbiu_dat_sb = or1200_sb_sbbiu_dat_o;
assign sbbiu_adr_sb = or1200_sb_sbbiu_adr_o;
assign sbbiu_cyc_sb = or1200_sb_sbbiu_cyc_o;
assign sbbiu_stb_sb = or1200_sb_sbbiu_stb_o;
assign sbbiu_we_sb = or1200_sb_sbbiu_we_o;
assign sbbiu_sel_sb = or1200_sb_sbbiu_sel_o;
assign sbbiu_cab_sb = or1200_sb_sbbiu_cab_o;
assign or1200_sb_sbbiu_dat_i = sbbiu_dat_biu;
assign or1200_sb_sbbiu_ack_i = sbbiu_ack_biu;
assign or1200_sb_sbbiu_err_i = sbbiu_err_biu;
 
  
wire  or1200_du_clk;
wire  or1200_du_rst;
wire  or1200_du_dcpu_cycstb_i;
wire  or1200_du_dcpu_we_i;
wire [31:0] or1200_du_dcpu_adr_i;
wire [31:0] or1200_du_dcpu_dat_lsu;
wire [31:0] or1200_du_dcpu_dat_dc;
wire [1-1:0] or1200_du_icpu_cycstb_i;
wire  or1200_du_ex_freeze;
wire [3-1:0] or1200_du_branch_op;
wire [ or1200_du_dw -1:0] or1200_du_ex_insn;
wire [31:0] or1200_du_id_pc;
wire [31:0] or1200_du_spr_dat_npc;
wire [31:0] or1200_du_rf_dataw;
wire [14-1:0] or1200_du_du_dsr;
wire [24:0] or1200_du_du_dmr1;
wire  or1200_du_du_stall;
wire [ or1200_du_aw -1:0] or1200_du_du_addr;
wire [ or1200_du_dw -1:0] or1200_du_du_dat_i;
wire [ or1200_du_dw -1:0] or1200_du_du_dat_o;
wire  or1200_du_du_read;
wire  or1200_du_du_write;
wire [13:0] or1200_du_du_except_stop;
wire  or1200_du_du_hwbkpt;
wire  or1200_du_du_flush_pipe;
wire  or1200_du_spr_cs;
wire  or1200_du_spr_write;
wire [ or1200_du_aw -1:0] or1200_du_spr_addr;
wire [ or1200_du_dw -1:0] or1200_du_spr_dat_i;
reg [ or1200_du_dw -1:0] or1200_du_spr_dat_o;
wire  or1200_du_dbg_stall_i;
wire  or1200_du_dbg_ewt_i;
wire [3:0] or1200_du_dbg_lss_o;
reg [1:0] or1200_du_dbg_is_o;
wire [10:0] or1200_du_dbg_wp_o;
wire  or1200_du_dbg_bp_o;
wire  or1200_du_dbg_stb_i;
wire  or1200_du_dbg_we_i;
wire [ or1200_du_aw -1:0] or1200_du_dbg_adr_i;
wire [ or1200_du_dw -1:0] or1200_du_dbg_dat_i;
reg [ or1200_du_dw -1:0] or1200_du_dbg_dat_o;
reg  or1200_du_dbg_ack_o;
 
  assign   or1200_du_dbg_lss_o  =4'b0000; 
  always @(  posedge    or1200_du_clk          or  posedge   or1200_du_rst  )
       if (  or1200_du_rst  ==(1'b1)) 
           or1200_du_dbg_is_o   <=2'b00;
        else 
          if (!  or1200_du_ex_freeze  &~((  or1200_du_ex_insn  [31:26]==6'b000101)&  or1200_du_ex_insn  [16])) 
              or1200_du_dbg_is_o   <=~  or1200_du_dbg_is_o  ;
 
  assign   or1200_du_dbg_wp_o  =11'b000_0000_0000; 
  assign   or1200_du_du_stall  =  or1200_du_dbg_stall_i  ; 
  assign   or1200_du_du_addr  =  or1200_du_dbg_adr_i  ; 
  assign   or1200_du_du_dat_o  =  or1200_du_dbg_dat_i  ; 
  assign   or1200_du_du_read  =  or1200_du_dbg_stb_i  &&!  or1200_du_dbg_we_i  ; 
  assign   or1200_du_du_write  =  or1200_du_dbg_stb_i  &&  or1200_du_dbg_we_i  ; 
   reg  or1200_du_du_flush_pipe_r  ; 
   reg  or1200_du_dbg_stall_i_r  ; 
  assign   or1200_du_du_flush_pipe  =  or1200_du_du_flush_pipe_r  ; 
  always @(  posedge    or1200_du_clk          or  posedge   or1200_du_rst  )
       begin 
         if (  or1200_du_rst  ==(1'b1))
            begin  
               or1200_du_du_flush_pipe_r   <=1'b0;
            end 
          else 
            begin  
               or1200_du_du_flush_pipe_r   <=(  or1200_du_dbg_stall_i_r  &&!  or1200_du_dbg_stall_i  &&|  or1200_du_du_except_stop  );
            end 
       end
  
  always @(  posedge    or1200_du_clk          or  posedge   or1200_du_rst  )
       begin 
         if (  or1200_du_rst  ==(1'b1))
            begin  
               or1200_du_dbg_stall_i_r   <=1'b0;
            end 
          else 
            begin  
               or1200_du_dbg_stall_i_r   <=  or1200_du_dbg_stall_i  ;
            end 
       end
  
   reg  or1200_du_dbg_ack  ; 
  always @(  posedge    or1200_du_clk          or  posedge   or1200_du_rst  )
       begin 
         if (  or1200_du_rst  ==(1'b1))
            begin  
               or1200_du_dbg_ack   <=1'b0; 
               or1200_du_dbg_ack_o   <=1'b0;
            end 
          else 
            begin  
               or1200_du_dbg_ack   <=  or1200_du_dbg_stb_i  ; 
               or1200_du_dbg_ack_o   <=  or1200_du_dbg_ack  &  or1200_du_dbg_stb_i  ;
            end 
       end
  
  always @( posedge   or1200_du_clk  ) 
        or1200_du_dbg_dat_o   <=  or1200_du_du_dat_i  ;
 
   reg[24:0]  or1200_du_dmr1  ; 
  assign   or1200_du_du_dmr1  =  or1200_du_dmr1  ; 
   wire[23:0]  or1200_du_dmr2  ; 
   reg[14-1:0]  or1200_du_dsr  ; 
   reg[13:0]  or1200_du_drr  ; 
   wire[31:0]  or1200_du_dvr0  ; 
   wire[31:0]  or1200_du_dvr1  ; 
   wire[31:0]  or1200_du_dvr2  ; 
   wire[31:0]  or1200_du_dvr3  ; 
   wire[31:0]  or1200_du_dvr4  ; 
   wire[31:0]  or1200_du_dvr5  ; 
   wire[31:0]  or1200_du_dvr6  ; 
   wire[31:0]  or1200_du_dvr7  ; 
   wire[7:0]  or1200_du_dcr0  ; 
   wire[7:0]  or1200_du_dcr1  ; 
   wire[7:0]  or1200_du_dcr2  ; 
   wire[7:0]  or1200_du_dcr3  ; 
   wire[7:0]  or1200_du_dcr4  ; 
   wire[7:0]  or1200_du_dcr5  ; 
   wire[7:0]  or1200_du_dcr6  ; 
   wire[7:0]  or1200_du_dcr7  ; 
   wire[31:0]  or1200_du_dwcr0  ; 
   wire[31:0]  or1200_du_dwcr1  ; 
   wire  or1200_du_dmr1_sel  ; 
   wire  or1200_du_dmr2_sel  ; 
   wire  or1200_du_dsr_sel  ; 
   wire  or1200_du_drr_sel  ; 
   wire  or1200_du_dvr0_sel  ,  or1200_du_dvr1_sel  ,  or1200_du_dvr2_sel  ,  or1200_du_dvr3_sel  ,  or1200_du_dvr4_sel  ,  or1200_du_dvr5_sel  ,  or1200_du_dvr6_sel  ,  or1200_du_dvr7_sel  ; 
   wire  or1200_du_dcr0_sel  ,  or1200_du_dcr1_sel  ,  or1200_du_dcr2_sel  ,  or1200_du_dcr3_sel  ,  or1200_du_dcr4_sel  ,  or1200_du_dcr5_sel  ,  or1200_du_dcr6_sel  ,  or1200_du_dcr7_sel  ; 
   wire  or1200_du_dwcr0_sel  ,  or1200_du_dwcr1_sel  ; 
   reg  or1200_du_dbg_bp_r  ; 
   reg  or1200_du_ex_freeze_q  ; 
   reg  or1200_du_du_hwbkpt_hold  ; 
   reg[13:0]  or1200_du_except_stop  ; 
   wire[31:0]  or1200_du_tbia_dat_o  ; 
   wire[31:0]  or1200_du_tbim_dat_o  ; 
   wire[31:0]  or1200_du_tbar_dat_o  ; 
   wire[31:0]  or1200_du_tbts_dat_o  ; 
  assign   or1200_du_dmr1_sel  =(  or1200_du_spr_cs  &&(  or1200_du_spr_addr  [10:0]==11'd16)); 
  assign   or1200_du_dsr_sel  =(  or1200_du_spr_cs  &&(  or1200_du_spr_addr  [10:0]==11'd20)); 
  assign   or1200_du_drr_sel  =(  or1200_du_spr_cs  &&(  or1200_du_spr_addr  [10:0]==11'd21)); 
  always @( posedge   or1200_du_clk  ) 
        or1200_du_ex_freeze_q   <=  or1200_du_ex_freeze  ;
 
  always @(    or1200_du_du_except_stop            or    or1200_du_ex_freeze_q   )
       begin  
          or1200_du_except_stop   =14'b00_0000_0000_0000;
         casez (  or1200_du_du_except_stop  )
          14 'b1?_????_????_????: 
              or1200_du_except_stop   [4]=1'b1;
          14 'b01_????_????_????:
             begin  
                or1200_du_except_stop   [7]=1'b1;
             end 
          14 'b00_1???_????_????:
             begin  
                or1200_du_except_stop   [9]=1'b1;
             end 
          14 'b00_01??_????_????: 
              or1200_du_except_stop   [3]=1'b1;
          14 'b00_001?_????_????:
             begin  
                or1200_du_except_stop   [1]=1'b1;
             end 
          14 'b00_0001_????_????: 
              or1200_du_except_stop   [6]=1'b1;
          14 'b00_0000_1???_????:
             begin  
                or1200_du_except_stop   [5]=1'b1;
             end 
          14 'b00_0000_01??_????:
             begin  
                or1200_du_except_stop   [8]=1'b1;
             end 
          14 'b00_0000_001?_????: 
              or1200_du_except_stop   [2]=1'b1;
          14 'b00_0000_0001_????: 
              or1200_du_except_stop   [1]=1'b1;
          14 'b00_0000_0000_1???:
             begin  
                or1200_du_except_stop   [10]=1'b1;
             end 
          14 'b00_0000_0000_01??:
             begin  
                or1200_du_except_stop   [13]=1'b1&~  or1200_du_ex_freeze_q  ;
             end 
          14 'b00_0000_0000_001?:
             begin  
                or1200_du_except_stop   [12]=1'b1;
             end 
          14 'b00_0000_0000_0001: 
              or1200_du_except_stop   [11]=1'b1&~  or1200_du_ex_freeze_q  ;
          default : 
              or1200_du_except_stop   =14'b00_0000_0000_0000;
         endcase 
       end
  
  assign   or1200_du_dbg_bp_o  =  or1200_du_dbg_bp_r  ; 
  always @(  posedge    or1200_du_clk          or  posedge   or1200_du_rst  )
       if (  or1200_du_rst  ==(1'b1)) 
           or1200_du_dbg_bp_r   <=1'b0;
        else 
          if (!  or1200_du_ex_freeze  ) 
              or1200_du_dbg_bp_r   <=|  or1200_du_except_stop  |~((  or1200_du_ex_insn  [31:26]==6'b000101)&  or1200_du_ex_insn  [16])&  or1200_du_dmr1  [22]|(  or1200_du_branch_op  !=3'd0)&(  or1200_du_branch_op  !=3'd6)&  or1200_du_dmr1  [23];
           else  
              or1200_du_dbg_bp_r   <=|  or1200_du_except_stop  ;
 
  always @(  posedge    or1200_du_clk          or  posedge   or1200_du_rst  )
       if (  or1200_du_rst  ==(1'b1)) 
           or1200_du_dmr1   <=25'h000_0000;
        else 
          if (  or1200_du_dmr1_sel  &&  or1200_du_spr_write  ) 
              or1200_du_dmr1   <={1'b0,  or1200_du_spr_dat_i  [23:22],22'h00_0000};
 
  assign   or1200_du_dmr2  =24'h00_0000; 
  always @(  posedge    or1200_du_clk          or  posedge   or1200_du_rst  )
       if (  or1200_du_rst  ==(1'b1)) 
           or1200_du_dsr   <={14{1'b0}};
        else 
          if (  or1200_du_dsr_sel  &&  or1200_du_spr_write  ) 
              or1200_du_dsr   <=  or1200_du_spr_dat_i  [14-1:0];
 
  always @(  posedge    or1200_du_clk          or  posedge   or1200_du_rst  )
       if (  or1200_du_rst  ==(1'b1)) 
           or1200_du_drr   <=14'b0;
        else 
          if (  or1200_du_drr_sel  &&  or1200_du_spr_write  ) 
              or1200_du_drr   <=  or1200_du_spr_dat_i  [13:0];
           else  
              or1200_du_drr   <=  or1200_du_drr  |  or1200_du_except_stop  ;
 
  assign   or1200_du_dvr0  =32'h0000_0000; 
  assign   or1200_du_dvr1  =32'h0000_0000; 
  assign   or1200_du_dvr2  =32'h0000_0000; 
  assign   or1200_du_dvr3  =32'h0000_0000; 
  assign   or1200_du_dvr4  =32'h0000_0000; 
  assign   or1200_du_dvr5  =32'h0000_0000; 
  assign   or1200_du_dvr6  =32'h0000_0000; 
  assign   or1200_du_dvr7  =32'h0000_0000; 
  assign   or1200_du_dcr0  =8'h00; 
  assign   or1200_du_dcr1  =8'h00; 
  assign   or1200_du_dcr2  =8'h00; 
  assign   or1200_du_dcr3  =8'h00; 
  assign   or1200_du_dcr4  =8'h00; 
  assign   or1200_du_dcr5  =8'h00; 
  assign   or1200_du_dcr6  =8'h00; 
  assign   or1200_du_dcr7  =8'h00; 
  assign   or1200_du_dwcr0  =32'h0000_0000; 
  assign   or1200_du_dwcr1  =32'h0000_0000; 
  always @(                         or1200_du_spr_addr                                                      or    or1200_du_dsr                               or    or1200_du_drr                              or    or1200_du_dmr1                             or    or1200_du_dmr2                            or    or1200_du_dvr0                           or    or1200_du_dvr1                          or    or1200_du_dvr2                         or    or1200_du_dvr3                        or    or1200_du_dvr4                       or    or1200_du_dvr5                      or    or1200_du_dvr6                     or    or1200_du_dvr7                    or    or1200_du_dcr0                   or    or1200_du_dcr1                  or    or1200_du_dcr2                 or    or1200_du_dcr3                or    or1200_du_dcr4               or    or1200_du_dcr5              or    or1200_du_dcr6             or    or1200_du_dcr7            or    or1200_du_dwcr0           or    or1200_du_dwcr1   )
       casez (  or1200_du_spr_addr  [10:0])
        11 'd16: 
            or1200_du_spr_dat_o   ={7'h00,  or1200_du_dmr1  };
        11 'd20: 
            or1200_du_spr_dat_o   ={18'b0,  or1200_du_dsr  };
        11 'd21: 
            or1200_du_spr_dat_o   ={18'b0,  or1200_du_drr  };
        default : 
            or1200_du_spr_dat_o   =32'h0000_0000;
       endcase
  
  assign   or1200_du_du_dsr  =  or1200_du_dsr  ; 
  assign   or1200_du_du_hwbkpt  =1'b0; 
  always @(  posedge    or1200_du_clk          or  posedge   or1200_du_rst  )
       if (  or1200_du_rst  ==(1'b1)) 
           or1200_du_du_hwbkpt_hold   <=1'b0;
        else 
          if (  or1200_du_du_hwbkpt  &  or1200_du_ex_freeze  ) 
              or1200_du_du_hwbkpt_hold   <=1'b1;
           else 
             if (!  or1200_du_ex_freeze  ) 
                 or1200_du_du_hwbkpt_hold   <=1'b0;
 
  assign   or1200_du_tbia_dat_o  =32'h0000_0000; 
  assign   or1200_du_tbim_dat_o  =32'h0000_0000; 
  assign   or1200_du_tbar_dat_o  =32'h0000_0000; 
  assign   or1200_du_tbts_dat_o  =32'h0000_0000;
assign or1200_du_clk = clk_i;
assign or1200_du_rst = rst_i;
assign or1200_du_dcpu_cycstb_i = dcpu_cycstb_cpu;
assign or1200_du_dcpu_we_i = dcpu_we_cpu;
assign or1200_du_dcpu_adr_i = dcpu_adr_cpu;
assign or1200_du_dcpu_dat_lsu = dcpu_dat_cpu;
assign or1200_du_dcpu_dat_dc = dcpu_dat_qmem;
assign or1200_du_icpu_cycstb_i = icpu_cycstb_cpu;
assign or1200_du_ex_freeze = ex_freeze;
assign or1200_du_branch_op = branch_op;
assign or1200_du_ex_insn = ex_insn;
assign or1200_du_id_pc = id_pc;
assign or1200_du_spr_dat_npc = spr_dat_npc;
assign or1200_du_rf_dataw = rf_dataw;
assign du_dsr = or1200_du_du_dsr;
assign du_dmr1 = or1200_du_du_dmr1;
assign du_stall = or1200_du_du_stall;
assign du_addr = or1200_du_du_addr;
assign or1200_du_du_dat_i = du_dat_cpu;
assign du_dat_du = or1200_du_du_dat_o;
assign du_read = or1200_du_du_read;
assign du_write = or1200_du_du_write;
assign or1200_du_du_except_stop = du_except_stop;
assign du_hwbkpt = or1200_du_du_hwbkpt;
assign du_flush_pipe = or1200_du_du_flush_pipe;
assign or1200_du_spr_cs = spr_cs[5'd06];
assign or1200_du_spr_write = spr_we;
assign or1200_du_spr_addr = spr_addr;
assign or1200_du_spr_dat_i = spr_dat_cpu;
assign spr_dat_du = or1200_du_spr_dat_o;
assign or1200_du_dbg_stall_i = dbg_stall_i;
assign or1200_du_dbg_ewt_i = dbg_ewt_i;
assign dbg_lss_o = or1200_du_dbg_lss_o;
assign dbg_is_o = or1200_du_dbg_is_o;
assign dbg_wp_o = or1200_du_dbg_wp_o;
assign dbg_bp_o = or1200_du_dbg_bp_o;
assign or1200_du_dbg_stb_i = dbg_stb_i;
assign or1200_du_dbg_we_i = dbg_we_i;
assign or1200_du_dbg_adr_i = dbg_adr_i;
assign or1200_du_dbg_dat_i = dbg_dat_i;
assign dbg_dat_o = or1200_du_dbg_dat_o;
assign dbg_ack_o = or1200_du_dbg_ack_o;
 
  
wire  or1200_pic_clk;
wire  or1200_pic_rst;
wire  or1200_pic_spr_cs;
wire  or1200_pic_spr_write;
wire [31:0] or1200_pic_spr_addr;
wire [31:0] or1200_pic_spr_dat_i;
reg [31:0] or1200_pic_spr_dat_o;
wire  or1200_pic_pic_wakeup;
wire  or1200_pic_intr;
wire [20-1:0] or1200_pic_pic_int;
 
   reg[20-1:2]  or1200_pic_picmr  ; 
   reg[20-1:0]  or1200_pic_picsr  ; 
   wire  or1200_pic_picmr_sel  ; 
   wire  or1200_pic_picsr_sel  ; 
   wire[20-1:0]  or1200_pic_um_ints  ; 
  assign   or1200_pic_picmr_sel  =(  or1200_pic_spr_cs  &&(  or1200_pic_spr_addr  [1:0]==2'd0))?1'b1:1'b0; 
  assign   or1200_pic_picsr_sel  =(  or1200_pic_spr_cs  &&(  or1200_pic_spr_addr  [1:0]==2'd2))?1'b1:1'b0; 
  always @(  posedge    or1200_pic_clk          or  posedge   or1200_pic_rst  )
       if (  or1200_pic_rst  ==(1'b1)) 
           or1200_pic_picmr   <={1'b1,{20-3{1'b0}}};
        else 
          if (  or1200_pic_picmr_sel  &&  or1200_pic_spr_write  )
             begin  
                or1200_pic_picmr   <=  or1200_pic_spr_dat_i  [20-1:2];
             end
  
  always @(  posedge    or1200_pic_clk          or  posedge   or1200_pic_rst  )
       if (  or1200_pic_rst  ==(1'b1)) 
           or1200_pic_picsr   <={20{1'b0}};
        else 
          if (  or1200_pic_picsr_sel  &&  or1200_pic_spr_write  )
             begin  
                or1200_pic_picsr   <=  or1200_pic_spr_dat_i  [20-1:0]|  or1200_pic_um_ints  ;
             end 
           else  
              or1200_pic_picsr   <=  or1200_pic_picsr  |  or1200_pic_um_ints  ;
 
  always @(     or1200_pic_spr_addr              or    or1200_pic_picmr           or    or1200_pic_picsr   )
       case (  or1200_pic_spr_addr  [1:0])
        2 'd0:
           begin  
              or1200_pic_spr_dat_o   [20-1:0]={  or1200_pic_picmr  ,2'b11}; 
              or1200_pic_spr_dat_o   [31:20]={32-20{1'b0}};
           end 
        default :
           begin  
              or1200_pic_spr_dat_o   [20-1:0]=  or1200_pic_picsr  ; 
              or1200_pic_spr_dat_o   [31:20]={32-20{1'b0}};
           end 
       endcase
  
  assign   or1200_pic_um_ints  =  or1200_pic_pic_int  &{  or1200_pic_picmr  ,2'b11}; 
  assign   or1200_pic_intr  =|  or1200_pic_um_ints  ; 
  assign   or1200_pic_pic_wakeup  =  or1200_pic_intr  ;
assign or1200_pic_clk = clk_i;
assign or1200_pic_rst = rst_i;
assign or1200_pic_spr_cs = spr_cs[5'd09];
assign or1200_pic_spr_write = spr_we;
assign or1200_pic_spr_addr = spr_addr;
assign or1200_pic_spr_dat_i = spr_dat_cpu;
assign spr_dat_pic = or1200_pic_spr_dat_o;
assign pic_wakeup = or1200_pic_pic_wakeup;
assign sig_int = or1200_pic_intr;
assign or1200_pic_pic_int = pic_ints_i;
 
  
wire  or1200_tt_clk;
wire  or1200_tt_rst;
wire  or1200_tt_du_stall;
wire  or1200_tt_spr_cs;
wire  or1200_tt_spr_write;
wire [31:0] or1200_tt_spr_addr;
wire [31:0] or1200_tt_spr_dat_i;
reg [31:0] or1200_tt_spr_dat_o;
wire  or1200_tt_intr;
 
   reg[31:0]  or1200_tt_ttmr  ; 
   reg[31:0]  or1200_tt_ttcr  ; 
   wire  or1200_tt_ttmr_sel  ; 
   wire  or1200_tt_ttcr_sel  ; 
   wire  or1200_tt_match  ; 
   wire  or1200_tt_restart  ; 
   wire  or1200_tt_stop  ; 
  assign   or1200_tt_ttmr_sel  =(  or1200_tt_spr_cs  &&(  or1200_tt_spr_addr  [0]==1'd0))?1'b1:1'b0; 
  assign   or1200_tt_ttcr_sel  =(  or1200_tt_spr_cs  &&(  or1200_tt_spr_addr  [0]==1'd1))?1'b1:1'b0; 
  always @(  posedge    or1200_tt_clk          or  posedge   or1200_tt_rst  )
       if (  or1200_tt_rst  ==(1'b1)) 
           or1200_tt_ttmr   <=32'b0;
        else 
          if (  or1200_tt_ttmr_sel  &&  or1200_tt_spr_write  ) 
              or1200_tt_ttmr   <=  or1200_tt_spr_dat_i  ;
           else 
             if (  or1200_tt_ttmr  [29]) 
                 or1200_tt_ttmr   [28]<=  or1200_tt_ttmr  [28]|(  or1200_tt_match  &  or1200_tt_ttmr  [29]);
 
  always @(  posedge    or1200_tt_clk          or  posedge   or1200_tt_rst  )
       if (  or1200_tt_rst  ==(1'b1)) 
           or1200_tt_ttcr   <=32'b0;
        else 
          if (  or1200_tt_restart  ) 
              or1200_tt_ttcr   <=32'b0;
           else 
             if (  or1200_tt_ttcr_sel  &&  or1200_tt_spr_write  ) 
                 or1200_tt_ttcr   <=  or1200_tt_spr_dat_i  ;
              else 
                if (!  or1200_tt_stop  ) 
                    or1200_tt_ttcr   <=  or1200_tt_ttcr  +32'd1;
 
  always @(     or1200_tt_spr_addr              or    or1200_tt_ttmr           or    or1200_tt_ttcr   )
       case (  or1200_tt_spr_addr  [0])
        1 'd0: 
            or1200_tt_spr_dat_o   =  or1200_tt_ttmr  ;
        default : 
            or1200_tt_spr_dat_o   =  or1200_tt_ttcr  ;
       endcase
  
  assign   or1200_tt_match  =(  or1200_tt_ttmr  [27:0]==  or1200_tt_ttcr  [27:0])?1'b1:1'b0; 
  assign   or1200_tt_restart  =  or1200_tt_match  &&(  or1200_tt_ttmr  [31:30]==2'b01); 
  assign   or1200_tt_stop  =  or1200_tt_match  &(  or1200_tt_ttmr  [31:30]==2'b10)|(  or1200_tt_ttmr  [31:30]==2'b00)|  or1200_tt_du_stall  ; 
  assign   or1200_tt_intr  =  or1200_tt_ttmr  [28];
assign or1200_tt_clk = clk_i;
assign or1200_tt_rst = rst_i;
assign or1200_tt_du_stall = du_stall;
assign or1200_tt_spr_cs = spr_cs[5'd10];
assign or1200_tt_spr_write = spr_we;
assign or1200_tt_spr_addr = spr_addr;
assign or1200_tt_spr_dat_i = spr_dat_cpu;
assign spr_dat_tt = or1200_tt_spr_dat_o;
assign sig_tick = or1200_tt_intr;
 
  
wire  or1200_pm_clk;
wire  or1200_pm_rst;
wire  or1200_pm_pic_wakeup;
wire  or1200_pm_spr_write;
wire [31:0] or1200_pm_spr_addr;
wire [31:0] or1200_pm_spr_dat_i;
wire [31:0] or1200_pm_spr_dat_o;
wire [3:0] or1200_pm_pm_clksd;
wire  or1200_pm_pm_cpustall;
wire  or1200_pm_pm_dc_gate;
wire  or1200_pm_pm_ic_gate;
wire  or1200_pm_pm_dmmu_gate;
wire  or1200_pm_pm_immu_gate;
wire  or1200_pm_pm_tt_gate;
wire  or1200_pm_pm_cpu_gate;
wire  or1200_pm_pm_wakeup;
wire  or1200_pm_pm_lvolt;
 
  assign   or1200_pm_pm_clksd  =4'b0; 
  assign   or1200_pm_pm_cpu_gate  =1'b0; 
  assign   or1200_pm_pm_dc_gate  =1'b0; 
  assign   or1200_pm_pm_ic_gate  =1'b0; 
  assign   or1200_pm_pm_dmmu_gate  =1'b0; 
  assign   or1200_pm_pm_immu_gate  =1'b0; 
  assign   or1200_pm_pm_tt_gate  =1'b0; 
  assign   or1200_pm_pm_wakeup  =1'b1; 
  assign   or1200_pm_pm_lvolt  =1'b0; 
  assign   or1200_pm_spr_dat_o  [3:0]=4'b0; 
  assign   or1200_pm_spr_dat_o  [4]=1'b0; 
  assign   or1200_pm_spr_dat_o  [5]=1'b0; 
  assign   or1200_pm_spr_dat_o  [6]=1'b0; 
  assign   or1200_pm_spr_dat_o  [31:7]=25'b0;
assign or1200_pm_clk = clk_i;
assign or1200_pm_rst = rst_i;
assign or1200_pm_pic_wakeup = pic_wakeup;
assign or1200_pm_spr_write = spr_we;
assign or1200_pm_spr_addr = spr_addr;
assign or1200_pm_spr_dat_i = spr_dat_cpu;
assign spr_dat_pm = or1200_pm_spr_dat_o;
assign pm_clksd_o = or1200_pm_pm_clksd;
assign or1200_pm_pm_cpustall = pm_cpustall_i;
assign pm_dc_gate_o = or1200_pm_pm_dc_gate;
assign pm_ic_gate_o = or1200_pm_pm_ic_gate;
assign pm_dmmu_gate_o = or1200_pm_pm_dmmu_gate;
assign pm_immu_gate_o = or1200_pm_pm_immu_gate;
assign pm_tt_gate_o = or1200_pm_pm_tt_gate;
assign pm_cpu_gate_o = or1200_pm_pm_cpu_gate;
assign pm_wakeup_o = or1200_pm_pm_wakeup;
assign pm_lvolt_o = or1200_pm_pm_lvolt;
 
endmodule
 
module or1200_fpu_pre_norm_addsub #(
 parameter FP_WIDTH =32,
 parameter MUL_SERIAL =0,
 parameter MUL_COUNT =11,
 parameter FRAC_WIDTH =23,
 parameter EXP_WIDTH =8,
 parameter ZERO_VECTOR =31'd0,
 parameter INF =31'b1111111100000000000000000000000,
 parameter QNAN =31'b1111111110000000000000000000000,
 parameter SNAN =31'b1111111100000000000000000000001) (
  input clk_i,
  input [FP_WIDTH-1:0] opa_i,
  input [FP_WIDTH-1:0] opb_i,
  output reg  [FRAC_WIDTH+4:0] fracta_28_o,
  output reg  [FRAC_WIDTH+4:0] fractb_28_o,
  output reg  [EXP_WIDTH-1:0] exp_o) ; 
    
    
    
    
    
    
    
    
    
   reg [EXP_WIDTH-1:0] s_exp_o ;  
   wire [FRAC_WIDTH+4:0] s_fracta_28_o,s_fractb_28_o ;  
   wire [EXP_WIDTH-1:0] s_expa ;  
   wire [EXP_WIDTH-1:0] s_expb ;  
   wire [FRAC_WIDTH-1:0] s_fracta ;  
   wire [FRAC_WIDTH-1:0] s_fractb ;  
   wire [FRAC_WIDTH+4:0] s_fracta_28 ;  
   wire [FRAC_WIDTH+4:0] s_fractb_28 ;  
   wire [FRAC_WIDTH+4:0] s_fract_sm_28 ;  
   wire [FRAC_WIDTH+4:0] s_fract_shr_28 ;  
   reg [EXP_WIDTH-1:0] s_exp_diff ;  
   reg [5:0] s_rzeros ;  
   wire s_expa_eq_expb ;  
   wire s_expa_gt_expb ;  
   wire s_fracta_1 ;  
   wire s_fractb_1 ;  
   wire s_op_dn,s_opa_dn,s_opb_dn ;  
   wire [1:0] s_mux_diff ;  
   wire s_mux_exp ;  
   wire s_sticky ;  
  assign s_expa=opa_i[30:23]; 
  assign s_expb=opb_i[30:23]; 
  assign s_fracta=opa_i[22:0]; 
  assign s_fractb=opb_i[22:0]; 
  always @( posedge clk_i)
       begin 
         exp_o <=s_exp_o;
         fracta_28_o <=s_fracta_28_o;
         fractb_28_o <=s_fractb_28_o;
       end
  
  assign s_expa_eq_expb=(s_expa==s_expb); 
  assign s_expa_gt_expb=(s_expa>s_expb); 
  assign s_fracta_1=|s_fracta; 
  assign s_fractb_1=|s_fractb; 
  assign s_opa_dn=!(|s_expa); 
  assign s_opb_dn=!(|s_expb); 
  assign s_op_dn=s_opa_dn|s_opb_dn; 
  assign s_mux_exp=s_expa_gt_expb; 
  always @( posedge clk_i)
       s_exp_o <=s_mux_exp ? s_expa:s_expb;
 
  assign s_fracta_28=s_opa_dn ? {2'b00,s_fracta,3'b000}:{2'b01,s_fracta,3'b000}; 
  assign s_fractb_28=s_opb_dn ? {2'b00,s_fractb,3'b000}:{2'b01,s_fractb,3'b000}; 
  assign s_mux_diff={s_expa_gt_expb,s_opa_dn^s_opb_dn}; 
  always @( posedge clk_i)
       begin 
         case (s_mux_diff)
          2 'b00:
             s_exp_diff <=s_expb-s_expa;
          2 'b01:
             s_exp_diff <=s_expb-(s_expa+8'd1);
          2 'b10:
             s_exp_diff <=s_expa-s_expb;
          2 'b11:
             s_exp_diff <=s_expa-(s_expb+8'd1);
         endcase 
       end
  
  assign s_fract_sm_28=s_expa_gt_expb ? s_fractb_28:s_fracta_28; 
  assign s_fract_shr_28=s_fract_sm_28>>s_exp_diff; 
  always @( s_fract_sm_28)
       casez (s_fract_sm_28)
        28 'b???????????????????????????1:
           s_rzeros =0;
        28 'b??????????????????????????10:
           s_rzeros =1;
        28 'b?????????????????????????100:
           s_rzeros =2;
        28 'b????????????????????????1000:
           s_rzeros =3;
        28 'b???????????????????????10000:
           s_rzeros =4;
        28 'b??????????????????????100000:
           s_rzeros =5;
        28 'b?????????????????????1000000:
           s_rzeros =6;
        28 'b????????????????????10000000:
           s_rzeros =7;
        28 'b???????????????????100000000:
           s_rzeros =8;
        28 'b??????????????????1000000000:
           s_rzeros =9;
        28 'b?????????????????10000000000:
           s_rzeros =10;
        28 'b????????????????100000000000:
           s_rzeros =11;
        28 'b???????????????1000000000000:
           s_rzeros =12;
        28 'b??????????????10000000000000:
           s_rzeros =13;
        28 'b?????????????100000000000000:
           s_rzeros =14;
        28 'b????????????1000000000000000:
           s_rzeros =15;
        28 'b???????????10000000000000000:
           s_rzeros =16;
        28 'b??????????100000000000000000:
           s_rzeros =17;
        28 'b?????????1000000000000000000:
           s_rzeros =18;
        28 'b????????10000000000000000000:
           s_rzeros =19;
        28 'b???????100000000000000000000:
           s_rzeros =20;
        28 'b??????1000000000000000000000:
           s_rzeros =21;
        28 'b?????10000000000000000000000:
           s_rzeros =22;
        28 'b????100000000000000000000000:
           s_rzeros =23;
        28 'b???1000000000000000000000000:
           s_rzeros =24;
        28 'b??10000000000000000000000000:
           s_rzeros =25;
        28 'b?100000000000000000000000000:
           s_rzeros =26;
        28 'b1000000000000000000000000000:
           s_rzeros =27;
        28 'b0000000000000000000000000000:
           s_rzeros =28;
       endcase
  
  assign s_sticky=(s_exp_diff>{2'b00,s_rzeros})&(|s_fract_sm_28); 
  assign s_fracta_28_o=s_expa_gt_expb ? s_fracta_28:{s_fract_shr_28[27:1],(s_sticky|s_fract_shr_28[0])}; 
  assign s_fractb_28_o=s_expa_gt_expb ? {s_fract_shr_28[27:1],(s_sticky|s_fract_shr_28[0])}:s_fractb_28; 
endmodule
 
module or1200_sb_fifo #(
 parameter dw =68,
 parameter fw =2,
 parameter fl =4) (
  input clk_i,
  input rst_i,
  input [dw-1:0] dat_i,
  input wr_i,
  input rd_i,
  output reg  [dw-1:0] dat_o,
  output reg  full_o,
  output reg  empty_o) ; 
    
    
    
   reg [dw-1:0] mem[fl-1:0] ;  
   reg [fw+1:0] cntr ;  
   reg [fw-1:0] wr_pntr ;  
   reg [fw-1:0] rd_pntr ;  
  always @(  posedge clk_i or  posedge rst_i)
       if (rst_i==(1'b1))
          begin 
            full_o <=1'b0;
            empty_o <=1'b1;
            wr_pntr <={fw{1'b0}};
            rd_pntr <={fw{1'b0}};
            cntr <={fw+2{1'b0}};
            dat_o <={dw{1'b0}};
          end 
        else 
          if (wr_i&&rd_i)
             begin 
               mem [wr_pntr]<=dat_i;
               if (wr_pntr>=fl-1)
                  wr_pntr <={fw{1'b0}};
                else 
                  wr_pntr <=wr_pntr+1'b1;
               if (empty_o)
                  begin 
                    dat_o <=dat_i;
                  end 
                else 
                  begin 
                    dat_o <=mem[rd_pntr];
                  end 
               if (rd_pntr>=fl-1)
                  rd_pntr <={fw{1'b0}};
                else 
                  rd_pntr <=rd_pntr+1'b1;
             end 
           else 
             if (wr_i&&!full_o)
                begin 
                  mem [wr_pntr]<=dat_i;
                  cntr <=cntr+1'b1;
                  empty_o <=1'b0;
                  if (cntr>=(fl-1))
                     begin 
                       full_o <=1'b1;
                       cntr <=fl;
                     end 
                  if (wr_pntr>=fl-1)
                     wr_pntr <={fw{1'b0}};
                   else 
                     wr_pntr <=wr_pntr+1'b1;
                end 
              else 
                if (rd_i&&!empty_o)
                   begin 
                     dat_o <=mem[rd_pntr];
                     cntr <=cntr-1'b1;
                     full_o <=1'b0;
                     if (cntr<=1)
                        begin 
                          empty_o <=1'b1;
                          cntr <={fw+2{1'b0}};
                        end 
                     if (rd_pntr>=fl-1)
                        rd_pntr <={fw{1'b0}};
                      else 
                        rd_pntr <=rd_pntr+1'b1;
                   end
  
endmodule
 
module or1200_immu_tlb #(
 parameter dw =32,
 parameter aw =32) (
  input clk,
  input rst,
  input tlb_en,
  input [aw-1:0] vaddr,
  output hit,
  output [31:13] ppn,
  output uxe,
  output sxe,
  output ci,
  input spr_cs,
  input spr_write,
  input [31:0] spr_addr,
  input [31:0] spr_dat_i,
  output [31:0] spr_dat_o) ; 
    
    
   wire [31:13+6-1+1] vpn ;  
   wire v ;  
   wire [6-1:0] tlb_index ;  
   wire tlb_mr_en ;  
   wire tlb_mr_we ;  
   wire [32-6-13+1-1:0] tlb_mr_ram_in ;  
   wire [32-6-13+1-1:0] tlb_mr_ram_out ;  
   wire tlb_tr_en ;  
   wire tlb_tr_we ;  
   wire [32-13+3-1:0] tlb_tr_ram_in ;  
   wire [32-13+3-1:0] tlb_tr_ram_out ;  
  assign tlb_mr_en=tlb_en|(spr_cs&!spr_addr[7]); 
  assign tlb_mr_we=spr_cs&spr_write&!spr_addr[7]; 
  assign tlb_tr_en=tlb_en|(spr_cs&spr_addr[7]); 
  assign tlb_tr_we=spr_cs&spr_write&spr_addr[7]; 
  assign spr_dat_o=(!spr_write&!spr_addr[7]) ? {vpn,tlb_index,{32-6-13-7{1'b0}},1'b0,5'b00000,v}:(!spr_write&spr_addr[7]) ? {ppn,{13-8{1'b0}},uxe,sxe,{4{1'b0}},ci,1'b0}:32'h00000000; 
  assign {vpn,v}=tlb_mr_ram_out; 
  assign tlb_mr_ram_in={spr_dat_i[31:13+6-1+1],spr_dat_i[0]}; 
  assign {ppn,uxe,sxe,ci}=tlb_tr_ram_out; 
  assign tlb_tr_ram_in={spr_dat_i[31:13],spr_dat_i[7],spr_dat_i[6],spr_dat_i[1]}; 
  assign hit=(vpn==vaddr[31:13+6-1+1])&v; 
  assign tlb_index=spr_cs ? spr_addr[6-1:0]:vaddr[13+6-1:13]; 
  or1200_spram #(.aw(6),.dw(14))itlb_mr_ram(.clk(clk),.ce(tlb_mr_en),.we(tlb_mr_we),.addr(tlb_index),.di(tlb_mr_ram_in),.doq(tlb_mr_ram_out)); 
  or1200_spram #(.aw(6),.dw(22))itlb_tr_ram(.clk(clk),.ce(tlb_tr_en),.we(tlb_tr_we),.addr(tlb_index),.di(tlb_tr_ram_in),.doq(tlb_tr_ram_out)); 
endmodule
 
module or1200_fpu_addsub #(
 parameter FP_WIDTH =32,
 parameter MUL_SERIAL =0,
 parameter MUL_COUNT =11,
 parameter FRAC_WIDTH =23,
 parameter EXP_WIDTH =8,
 parameter ZERO_VECTOR =31'd0,
 parameter INF =31'b1111111100000000000000000000000,
 parameter QNAN =31'b1111111110000000000000000000000,
 parameter SNAN =31'b1111111100000000000000000000001) (
  input clk_i,
  input fpu_op_i,
  input [FRAC_WIDTH+4:0] fracta_i,
  input [FRAC_WIDTH+4:0] fractb_i,
  input signa_i,
  input signb_i,
  output reg  [FRAC_WIDTH+4:0] fract_o,
  output reg  sign_o) ; 
    
    
    
    
    
    
    
    
    
   wire [FRAC_WIDTH+4:0] s_fracta_i ;  
   wire [FRAC_WIDTH+4:0] s_fractb_i ;  
   wire [FRAC_WIDTH+4:0] s_fract_o ;  
   wire s_signa_i,s_signb_i,s_sign_o ;  
   wire s_fpu_op_i ;  
   wire fracta_gt_fractb ;  
   wire s_addop ;  
  assign s_fracta_i=fracta_i; 
  assign s_fractb_i=fractb_i; 
  assign s_signa_i=signa_i; 
  assign s_signb_i=signb_i; 
  assign s_fpu_op_i=fpu_op_i; 
  always @( posedge clk_i)
       begin 
         fract_o <=s_fract_o;
         sign_o <=s_sign_o;
       end
  
  assign fracta_gt_fractb=s_fracta_i>s_fractb_i; 
  assign s_addop=((s_signa_i^s_signb_i)&!s_fpu_op_i)|((s_signa_i^~s_signb_i)&s_fpu_op_i); 
  assign s_sign_o=((s_fract_o==28'd0)&!(s_signa_i&s_signb_i)) ? 0:(!s_signa_i&(!fracta_gt_fractb&(fpu_op_i^s_signb_i)))|(s_signa_i&(fracta_gt_fractb|(fpu_op_i^s_signb_i))); 
  assign s_fract_o=s_addop ? (fracta_gt_fractb ? s_fracta_i-s_fractb_i:s_fractb_i-s_fracta_i):s_fracta_i+s_fractb_i; 
endmodule
 
module or1200_fpu_fcmp (
  input [31:0] opa,
  input [31:0] opb,
  output unordered,
  output reg  altb,
  output reg  blta,
  output reg  aeqb,
  output inf,
  output zero) ; 
   wire signa,signb ;  
   wire [7:0] expa,expb ;  
   wire [22:0] fracta,fractb ;  
   wire expa_ff,expb_ff,fracta_00,fractb_00 ;  
   wire qnan_a,snan_a,qnan_b,snan_b,opa_inf,opb_inf,inf ;  
   wire qnan,snan,opa_zero,opb_zero ;  
   wire exp_eq,exp_gt,exp_lt ;  
   wire fract_eq,fract_gt,fract_lt ;  
   wire all_zero ;  
  assign signa=opa[31]; 
  assign signb=opb[31]; 
  assign expa=opa[30:23]; 
  assign expb=opb[30:23]; 
  assign fracta=opa[22:0]; 
  assign fractb=opb[22:0]; 
  assign expa_ff=&expa; 
  assign expb_ff=&expb; 
  assign fracta_00=!(|fracta); 
  assign fractb_00=!(|fractb); 
  assign qnan_a=fracta[22]; 
  assign snan_a=!fracta[22]&|fracta[21:0]; 
  assign qnan_b=fractb[22]; 
  assign snan_b=!fractb[22]&|fractb[21:0]; 
  assign opa_inf=(expa_ff&fracta_00); 
  assign opb_inf=(expb_ff&fractb_00); 
  assign inf=opa_inf|opb_inf; 
  assign qnan=(expa_ff&qnan_a)|(expb_ff&qnan_b); 
  assign snan=(expa_ff&snan_a)|(expb_ff&snan_b); 
  assign unordered=qnan|snan; 
  assign opa_zero=!(|expa)&fracta_00; 
  assign opb_zero=!(|expb)&fractb_00; 
  assign zero=opa_zero; 
  assign exp_eq=expa==expb; 
  assign exp_gt=expa>expb; 
  assign exp_lt=expa<expb; 
  assign fract_eq=fracta==fractb; 
  assign fract_gt=fracta>fractb; 
  assign fract_lt=fracta<fractb; 
  assign all_zero=opa_zero&opb_zero; 
  always @(             qnan or  snan or  opa_inf or  opb_inf or  signa or  signb or  exp_eq or  exp_gt or  exp_lt or  fract_eq or  fract_gt or  fract_lt or  all_zero)
       casez ({qnan,snan,opa_inf,opb_inf,signa,signb,exp_eq,exp_gt,exp_lt,fract_eq,fract_gt,fract_lt,all_zero})
        13 'b1?_??_??_???_???_?:
           { altb,blta,aeqb}=3'b000;
        13 'b?1_??_??_???_???_?:
           { altb,blta,aeqb}=3'b000;
        13 'b00_11_00_???_???_?:
           { altb,blta,aeqb}=3'b001;
        13 'b00_11_01_???_???_?:
           { altb,blta,aeqb}=3'b100;
        13 'b00_11_10_???_???_?:
           { altb,blta,aeqb}=3'b010;
        13 'b00_11_11_???_???_?:
           { altb,blta,aeqb}=3'b001;
        13 'b00_10_00_???_???_?:
           { altb,blta,aeqb}=3'b100;
        13 'b00_10_01_???_???_?:
           { altb,blta,aeqb}=3'b100;
        13 'b00_10_10_???_???_?:
           { altb,blta,aeqb}=3'b010;
        13 'b00_10_11_???_???_?:
           { altb,blta,aeqb}=3'b010;
        13 'b00_01_00_???_???_?:
           { altb,blta,aeqb}=3'b010;
        13 'b00_01_01_???_???_?:
           { altb,blta,aeqb}=3'b100;
        13 'b00_01_10_???_???_?:
           { altb,blta,aeqb}=3'b010;
        13 'b00_01_11_???_???_?:
           { altb,blta,aeqb}=3'b100;
        13 'b00_00_10_???_???_0:
           { altb,blta,aeqb}=3'b010;
        13 'b00_00_01_???_???_0:
           { altb,blta,aeqb}=3'b100;
        13 'b00_00_??_???_???_1:
           { altb,blta,aeqb}=3'b001;
        13 'b00_00_00_010_???_?:
           { altb,blta,aeqb}=3'b100;
        13 'b00_00_00_001_???_?:
           { altb,blta,aeqb}=3'b010;
        13 'b00_00_11_010_???_?:
           { altb,blta,aeqb}=3'b010;
        13 'b00_00_11_001_???_?:
           { altb,blta,aeqb}=3'b100;
        13 'b00_00_00_100_010_?:
           { altb,blta,aeqb}=3'b100;
        13 'b00_00_00_100_001_?:
           { altb,blta,aeqb}=3'b010;
        13 'b00_00_11_100_010_?:
           { altb,blta,aeqb}=3'b010;
        13 'b00_00_11_100_001_?:
           { altb,blta,aeqb}=3'b100;
        13 'b00_00_00_100_100_?:
           { altb,blta,aeqb}=3'b001;
        13 'b00_00_11_100_100_?:
           { altb,blta,aeqb}=3'b001;
        default :
           { altb,blta,aeqb}=3'bxxx;
       endcase
  
endmodule
 
module or1200_fpu_post_norm_div #(
 parameter FP_WIDTH =32,
 parameter MUL_SERIAL =0,
 parameter MUL_COUNT =11,
 parameter FRAC_WIDTH =23,
 parameter EXP_WIDTH =8,
 parameter ZERO_VECTOR =31'd0,
 parameter INF =31'b1111111100000000000000000000000,
 parameter QNAN =31'b1111111110000000000000000000000,
 parameter SNAN =31'b1111111100000000000000000000001) (
  input clk_i,
  input [FP_WIDTH-1:0] opa_i,
  input [FP_WIDTH-1:0] opb_i,
  input [FRAC_WIDTH+3:0] qutnt_i,
  input [FRAC_WIDTH+3:0] rmndr_i,
  input [EXP_WIDTH+1:0] exp_10_i,
  input sign_i,
  input [1:0] rmode_i,
  output reg  [FP_WIDTH-1:0] output_o,
  output reg  ine_o) ; 
    
    
    
    
    
    
    
    
    
   reg [FP_WIDTH-1:0] s_opa_i ;  
   reg [FP_WIDTH-1:0] s_opb_i ;  
   reg [EXP_WIDTH-1:0] s_expa ;  
   reg [EXP_WIDTH-1:0] s_expb ;  
   reg [FRAC_WIDTH+3:0] s_qutnt_i ;  
   reg [FRAC_WIDTH+3:0] s_rmndr_i ;  
   reg [5:0] s_r_zeros ;  
   reg [EXP_WIDTH+1:0] s_exp_10_i ;  
   reg s_sign_i ;  
   reg [1:0] s_rmode_i ;  
   wire [FP_WIDTH-1:0] s_output_o ;  
   wire s_ine_o,s_overflow ;  
   wire s_opa_dn,s_opb_dn ;  
   wire s_qutdn ;  
   wire [9:0] s_exp_10b ;  
   reg [5:0] s_shr1 ;  
   reg [5:0] s_shl1 ;  
   wire s_shr2 ;  
   reg [8:0] s_expo1 ;  
   wire [8:0] s_expo2 ;  
   reg [8:0] s_expo3 ;  
   reg [26:0] s_fraco1 ;  
   wire [24:0] s_frac_rnd ;  
   reg [24:0] s_fraco2 ;  
   wire s_guard,s_round,s_sticky,s_roundup ;  
   wire s_lost ;  
   wire s_op_0,s_opab_0,s_opb_0 ;  
   wire s_infa,s_infb ;  
   wire s_nan_in,s_nan_op,s_nan_a,s_nan_b ;  
   wire s_inf_result ;  
  always @( posedge clk_i)
       begin 
         s_opa_i <=opa_i;
         s_opb_i <=opb_i;
         s_expa <=opa_i[30:23];
         s_expb <=opb_i[30:23];
         s_qutnt_i <=qutnt_i;
         s_rmndr_i <=rmndr_i;
         s_exp_10_i <=exp_10_i;
         s_sign_i <=sign_i;
         s_rmode_i <=rmode_i;
       end
  
  always @( posedge clk_i)
       begin 
         output_o <=s_output_o;
         ine_o <=s_ine_o;
       end
  
  assign s_opa_dn=!(|s_expa)&(|opa_i[22:0]); 
  assign s_opb_dn=!(|s_expb)&(|opb_i[22:0]); 
  assign s_qutdn=!s_qutnt_i[26]; 
  assign s_exp_10b=s_exp_10_i-{9'd0,s_qutdn}; 
   wire [9:0] v_shr ;  
   wire [9:0] v_shl ;  
  assign v_shr=(s_exp_10b[9]|!(|s_exp_10b)) ? (10'd1-s_exp_10b)-{9'd0,s_qutdn}:0; 
  assign v_shl=(s_exp_10b[9]|!(|s_exp_10b)) ? 0:s_exp_10b[8] ? 0:{9'd0,s_qutdn}; 
  always @( posedge clk_i)
       if (s_exp_10b[9]|!(|s_exp_10b))
          s_expo1 <=9'd1;
        else 
          s_expo1 <=s_exp_10b[8:0];
 
  always @( posedge clk_i)
       s_shr1 <=v_shr[6] ? 6'b111111:v_shr[5:0];
 
  always @( posedge clk_i)
       s_shl1 <=v_shl[5:0];
 
  always @( posedge clk_i)
       if (|s_shr1)
          s_fraco1 <=s_qutnt_i>>s_shr1;
        else 
          s_fraco1 <=s_qutnt_i<<s_shl1;
 
  assign s_expo2=s_fraco1[26] ? s_expo1:s_expo1-9'd1; 
  always @( s_qutnt_i)
       casez (s_qutnt_i)
        27 'b??????????????????????????1:
           s_r_zeros =0;
        27 'b?????????????????????????10:
           s_r_zeros =1;
        27 'b????????????????????????100:
           s_r_zeros =2;
        27 'b???????????????????????1000:
           s_r_zeros =3;
        27 'b??????????????????????10000:
           s_r_zeros =4;
        27 'b?????????????????????100000:
           s_r_zeros =5;
        27 'b????????????????????1000000:
           s_r_zeros =6;
        27 'b???????????????????10000000:
           s_r_zeros =7;
        27 'b??????????????????100000000:
           s_r_zeros =8;
        27 'b?????????????????1000000000:
           s_r_zeros =9;
        27 'b????????????????10000000000:
           s_r_zeros =10;
        27 'b???????????????100000000000:
           s_r_zeros =11;
        27 'b??????????????1000000000000:
           s_r_zeros =12;
        27 'b?????????????10000000000000:
           s_r_zeros =13;
        27 'b????????????100000000000000:
           s_r_zeros =14;
        27 'b???????????1000000000000000:
           s_r_zeros =15;
        27 'b??????????10000000000000000:
           s_r_zeros =16;
        27 'b?????????100000000000000000:
           s_r_zeros =17;
        27 'b????????1000000000000000000:
           s_r_zeros =18;
        27 'b???????10000000000000000000:
           s_r_zeros =19;
        27 'b??????100000000000000000000:
           s_r_zeros =20;
        27 'b?????1000000000000000000000:
           s_r_zeros =21;
        27 'b????10000000000000000000000:
           s_r_zeros =22;
        27 'b???100000000000000000000000:
           s_r_zeros =23;
        27 'b??1000000000000000000000000:
           s_r_zeros =24;
        27 'b?10000000000000000000000000:
           s_r_zeros =25;
        27 'b100000000000000000000000000:
           s_r_zeros =26;
        27 'b000000000000000000000000000:
           s_r_zeros =27;
       endcase
  
  assign s_lost=(s_shr1+{5'd0,s_shr2})>s_r_zeros; 
  assign s_guard=s_fraco1[2]; 
  assign s_round=s_fraco1[1]; 
  assign s_sticky=s_fraco1[0]|(|s_rmndr_i); 
  assign s_roundup=s_rmode_i==2'b00 ? s_guard&((s_round|s_sticky)|s_fraco1[3]):s_rmode_i==2'b10 ? (s_guard|s_round|s_sticky)&!s_sign_i:s_rmode_i==2'b11 ? (s_guard|s_round|s_sticky)&s_sign_i:0; 
  assign s_frac_rnd=s_roundup ? {1'b0,s_fraco1[26:3]}+1:{1'b0,s_fraco1[26:3]}; 
  assign s_shr2=s_frac_rnd[24]; 
  always @( posedge clk_i)
       begin 
         s_expo3 <=s_shr2 ? s_expo2+"1":s_expo2;
         s_fraco2 <=s_shr2 ? {1'b0,s_frac_rnd[24:1]}:s_frac_rnd;
       end
  
  assign s_op_0=!((|s_opa_i[30:0])&(|s_opb_i[30:0])); 
  assign s_opab_0=!((|s_opa_i[30:0])|(|s_opb_i[30:0])); 
  assign s_opb_0=!(|s_opb_i[30:0]); 
  assign s_infa=&s_expa; 
  assign s_infb=&s_expb; 
  assign s_nan_a=s_infa&(|s_opa_i[22:0]); 
  assign s_nan_b=s_infb&(|s_opb_i[22:0]); 
  assign s_nan_in=s_nan_a|s_nan_b; 
  assign s_nan_op=(s_infa&s_infb)|s_opab_0; 
  assign s_inf_result=(&s_expo3[7:0])|s_expo3[8]|s_opb_0; 
  assign s_overflow=s_inf_result&!(s_infa)&!s_opb_0; 
  assign s_ine_o=!s_op_0&(s_lost|(|s_fraco1[2:0])|s_overflow|(|s_rmndr_i)); 
  assign s_output_o=(s_nan_in|s_nan_op) ? {s_sign_i,QNAN}:s_infa|s_overflow|s_inf_result ? {s_sign_i,INF}:s_op_0|s_infb ? {s_sign_i,ZERO_VECTOR}:{s_sign_i,s_expo3[7:0],s_fraco2[22:0]}; 
endmodule
 












































