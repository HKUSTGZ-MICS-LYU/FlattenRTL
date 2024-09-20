module mips_16_core_top
(
	input						clk,
	input						rst,

	output	[8-1:0]		pc
);
	wire 						pipeline_stall_n ;
	wire	[5:0]				branch_offset_imm;
	wire						branch_taken;
	wire	[15:0]				instruction;
	wire	[56:0]				ID_pipeline_reg_out;
	wire	[37:0]				EX_pipeline_reg_out;
	wire	[36:0]				MEM_pipeline_reg_out;
	
	wire	[2:0]				reg_read_addr_1;	// register file read port 1 address
	wire	[2:0]				reg_read_addr_2;	// register file read port 2 address
	wire	[15:0]				reg_read_data_1;	// register file read port 1 data
	wire	[15:0]				reg_read_data_2;	// register file read port 2 data
	wire	[2:0]				decoding_op_src1;		//source_1 register number
	wire	[2:0]				decoding_op_src2;		//source_2 register number
	wire	[2:0]				ex_op_dest;				//EX stage destinaton register number
	wire	[2:0]				mem_op_dest;			//MEM stage destinaton register number
	wire	[2:0]				wb_op_dest;				//WB stage destinaton register number
	wire						reg_write_en;
	wire	[2:0]				reg_write_dest;
	wire	[15:0]				reg_write_data;
	
	wire IF_stage_inst_clk;
    wire IF_stage_inst_rst;
    wire IF_stage_inst_instruction_fetch_en;
    wire[5:0] IF_stage_inst_branch_offset_imm;
    wire IF_stage_inst_branch_taken;
    reg IF_stage_inst_pc;
    wire[15:0] IF_stage_inst_instruction;

    always @(  posedge   IF_stage_inst_clk          or  posedge  IF_stage_inst_rst )
         begin 
             if ( IF_stage_inst_rst )
                 begin  
                     IF_stage_inst_pc  <=8'b0;
                 end 
              else 
                 begin 
                     if ( IF_stage_inst_instruction_fetch_en )
                         begin 
                             if ( IF_stage_inst_branch_taken ) 
                                 IF_stage_inst_pc  <= IF_stage_inst_pc +{{(8-6){ IF_stage_inst_branch_offset_imm [5]}}, IF_stage_inst_branch_offset_imm [5:0]};
                              else  
                                 IF_stage_inst_pc  <= IF_stage_inst_pc +8'd1;
                         end 
                 end 
         end
    wire imem_clk;
    wire[8-1:0] imem_pc;
    wire[15:0] imem_instruction;

    reg[15:0] imem_rom [2**8-1:0]; 
    wire[8-1:0] imem_rom_addr = imem_pc [8-1:0]; 
  assign  imem_instruction = imem_rom [ imem_rom_addr ];
    assign imem_clk = IF_stage_inst_clk;
    assign imem_pc = IF_stage_inst_pc;
    assign IF_stage_inst_instruction = imem_instruction;
    
    assign IF_stage_inst_clk = clk;
    assign IF_stage_inst_rst = rst;
    assign IF_stage_inst_instruction_fetch_en = pipeline_stall_n;
    assign IF_stage_inst_branch_offset_imm = branch_offset_imm;
    assign IF_stage_inst_branch_taken = branch_taken;
    assign pc = IF_stage_inst_pc;
    assign instruction = IF_stage_inst_instruction;
    
	
	wire ID_stage_inst_clk;
    wire ID_stage_inst_rst;
    wire ID_stage_inst_instruction_decode_en;
    reg ID_stage_inst_pipeline_reg_out;
    wire[15:0] ID_stage_inst_instruction;
    wire[5:0] ID_stage_inst_branch_offset_imm;
    reg ID_stage_inst_branch_taken;
    wire[2:0] ID_stage_inst_reg_read_addr_1;
    wire[2:0] ID_stage_inst_reg_read_addr_2;
    wire[15:0] ID_stage_inst_reg_read_data_1;
    wire[15:0] ID_stage_inst_reg_read_data_2;
    wire[2:0] ID_stage_inst_decoding_op_src1;
    wire[2:0] ID_stage_inst_decoding_op_src2;

    reg[15:0] ID_stage_inst_instruction_reg ; 
    wire[3:0] ID_stage_inst_ir_op_code ; 
    wire[2:0] ID_stage_inst_ir_dest ; 
    wire[2:0] ID_stage_inst_ir_src1 ; 
    wire[2:0] ID_stage_inst_ir_src2 ; 
    wire[5:0] ID_stage_inst_ir_imm ; 
    reg ID_stage_inst_write_back_en ; 
    wire[2:0] ID_stage_inst_write_back_dest ; 
    reg ID_stage_inst_write_back_result_mux ; 
    wire ID_stage_inst_mem_write_en ; 
    wire[15:0] ID_stage_inst_mem_write_data ; reg[2:0] ID_stage_inst_ex_alu_cmd ; 
    wire[15:0] ID_stage_inst_ex_alu_src1 ; 
    wire[15:0] ID_stage_inst_ex_alu_src2 ; 
    reg ID_stage_inst_alu_src2_mux ; 
    wire ID_stage_inst_decoding_op_is_branch ; 
    wire ID_stage_inst_decoding_op_is_store ; 
    wire[3:0] ID_stage_inst_ir_op_code_with_bubble ; 
    wire[2:0] ID_stage_inst_ir_dest_with_bubble ; 
  always @(  posedge   ID_stage_inst_clk          or  posedge  ID_stage_inst_rst )
         begin 
             if ( ID_stage_inst_rst )
                 begin  
                     ID_stage_inst_instruction_reg  <=0;
                 end 
              else 
                 begin 
                     if ( ID_stage_inst_instruction_decode_en )
                         begin  
                             ID_stage_inst_instruction_reg  <= ID_stage_inst_instruction ;
                         end 
                 end 
         end
  assign  ID_stage_inst_ir_op_code = ID_stage_inst_instruction_reg [15:12]; 
  assign  ID_stage_inst_ir_dest = ID_stage_inst_instruction_reg [11:9]; 
  assign  ID_stage_inst_ir_src1 = ID_stage_inst_instruction_reg [8:6]; 
  assign  ID_stage_inst_ir_src2 =( ID_stage_inst_decoding_op_is_store )? ID_stage_inst_instruction_reg [11:9]: ID_stage_inst_instruction_reg [5:3]; 
  assign  ID_stage_inst_ir_imm = ID_stage_inst_instruction_reg [5:0]; 
  assign  ID_stage_inst_ir_op_code_with_bubble =( ID_stage_inst_instruction_decode_en )? ID_stage_inst_ir_op_code :0; 
  assign  ID_stage_inst_ir_dest_with_bubble =( ID_stage_inst_instruction_decode_en )? ID_stage_inst_ir_dest :0; 
  always @(*)
         begin 
             if ( ID_stage_inst_rst )
                 begin  
                     ID_stage_inst_write_back_en  =0; 
                     ID_stage_inst_write_back_result_mux  =0; 
                     ID_stage_inst_ex_alu_cmd  =0; 
                     ID_stage_inst_alu_src2_mux  =0;
                 end 
              else 
                 begin 
                     case ( ID_stage_inst_ir_op_code_with_bubble )
                      4 'b0000:
                          begin  
                              ID_stage_inst_write_back_en  =0; 
                              ID_stage_inst_write_back_result_mux  =1'bx; 
                              ID_stage_inst_ex_alu_cmd  =3'bxxx; 
                              ID_stage_inst_alu_src2_mux  =1'bx;
                          end 
                      4 'b0001:
                          begin  
                              ID_stage_inst_write_back_en  =1; 
                              ID_stage_inst_write_back_result_mux  =0; 
                              ID_stage_inst_ex_alu_cmd  =3'b000; 
                              ID_stage_inst_alu_src2_mux  =0;
                          end 
                      4 'b0010:
                          begin  
                              ID_stage_inst_write_back_en  =1; 
                              ID_stage_inst_write_back_result_mux  =0; 
                              ID_stage_inst_ex_alu_cmd  =3'b001; 
                              ID_stage_inst_alu_src2_mux  =0;
                          end 
                      4 'b0011:
                          begin  
                              ID_stage_inst_write_back_en  =1; 
                              ID_stage_inst_write_back_result_mux  =0; 
                              ID_stage_inst_ex_alu_cmd  =3'b010; 
                              ID_stage_inst_alu_src2_mux  =0;
                          end 
                      4 'b0100:
                          begin  
                              ID_stage_inst_write_back_en  =1; 
                              ID_stage_inst_write_back_result_mux  =0; 
                              ID_stage_inst_ex_alu_cmd  =3'b011; 
                              ID_stage_inst_alu_src2_mux  =0;
                          end 
                      4 'b0101:
                          begin  
                              ID_stage_inst_write_back_en  =1; 
                              ID_stage_inst_write_back_result_mux  =0; 
                              ID_stage_inst_ex_alu_cmd  =3'b100; 
                              ID_stage_inst_alu_src2_mux  =1'bx;
                          end 
                      4 'b0110:
                          begin  
                              ID_stage_inst_write_back_en  =1; 
                              ID_stage_inst_write_back_result_mux  =0; 
                              ID_stage_inst_ex_alu_cmd  =3'b101; 
                              ID_stage_inst_alu_src2_mux  =0;
                          end 
                      4 'b0111:
                          begin  
                              ID_stage_inst_write_back_en  =1; 
                              ID_stage_inst_write_back_result_mux  =0; 
                              ID_stage_inst_ex_alu_cmd  =3'b110; 
                              ID_stage_inst_alu_src2_mux  =0;
                          end 
                      4 'b1000:
                          begin  
                              ID_stage_inst_write_back_en  =1; 
                              ID_stage_inst_write_back_result_mux  =0; 
                              ID_stage_inst_ex_alu_cmd  =3'b111; 
                              ID_stage_inst_alu_src2_mux  =0;
                          end 
                      4 'b1001:
                          begin  
                              ID_stage_inst_write_back_en  =1; 
                              ID_stage_inst_write_back_result_mux  =0; 
                              ID_stage_inst_ex_alu_cmd  =3'b000; 
                              ID_stage_inst_alu_src2_mux  =1;
                          end 
                      4 'b1010:
                          begin  
                              ID_stage_inst_write_back_en  =1; 
                              ID_stage_inst_write_back_result_mux  =1; 
                              ID_stage_inst_ex_alu_cmd  =3'b000; 
                              ID_stage_inst_alu_src2_mux  =1;
                          end 
                      4 'b1011:
                          begin  
                              ID_stage_inst_write_back_en  =0; 
                              ID_stage_inst_write_back_result_mux  =1'bx; 
                              ID_stage_inst_ex_alu_cmd  =3'b000; 
                              ID_stage_inst_alu_src2_mux  =1;
                          end 
                      4 'b1100:
                          begin  
                              ID_stage_inst_write_back_en  =0; 
                              ID_stage_inst_write_back_result_mux  =1'bx; 
                              ID_stage_inst_ex_alu_cmd  =3'bxxx; 
                              ID_stage_inst_alu_src2_mux  =1;
                          end 
                      default :
                          begin  
                              ID_stage_inst_write_back_en  =0; 
                              ID_stage_inst_write_back_result_mux  =1'bx; 
                              ID_stage_inst_ex_alu_cmd  =3'bxxx; 
                              ID_stage_inst_alu_src2_mux  =1'bx;$display("ERROR: Unknown Instruction: %b", ID_stage_inst_ir_op_code_with_bubble );
                          end endcase
                 end 
         end
  assign  ID_stage_inst_decoding_op_is_branch =( ID_stage_inst_ir_op_code ==4'b1100)?1:0; 
  assign  ID_stage_inst_decoding_op_is_store =( ID_stage_inst_ir_op_code ==4'b1011)?1:0; 
  assign  ID_stage_inst_mem_write_data = ID_stage_inst_reg_read_data_2 ; 
  assign  ID_stage_inst_mem_write_en = ID_stage_inst_decoding_op_is_store ; 
  assign  ID_stage_inst_write_back_dest = ID_stage_inst_ir_dest_with_bubble ; 
  assign  ID_stage_inst_ex_alu_src1 = ID_stage_inst_reg_read_data_1 ; 
  assign  ID_stage_inst_ex_alu_src2 =( ID_stage_inst_alu_src2_mux )?{{10{ ID_stage_inst_ir_imm [5]}}, ID_stage_inst_ir_imm }: ID_stage_inst_reg_read_data_2 ; 
  always @(  posedge   ID_stage_inst_clk          or  posedge  ID_stage_inst_rst )
         begin 
             if ( ID_stage_inst_rst )
                 begin  
                     ID_stage_inst_pipeline_reg_out  [56:0]<=0;
                 end 
              else 
                 begin  
                     ID_stage_inst_pipeline_reg_out  [56:0]<={ ID_stage_inst_ex_alu_cmd [2:0], ID_stage_inst_ex_alu_src1 [15:0], ID_stage_inst_ex_alu_src2 [15:0], ID_stage_inst_mem_write_en , ID_stage_inst_mem_write_data [15:0], ID_stage_inst_write_back_en , ID_stage_inst_write_back_dest [2:0], ID_stage_inst_write_back_result_mux };
                 end 
         end
  assign  ID_stage_inst_reg_read_addr_1 = ID_stage_inst_ir_src1 ; 
  assign  ID_stage_inst_reg_read_addr_2 = ID_stage_inst_ir_src2 ; 
  always @(*)
         begin 
             if ( ID_stage_inst_decoding_op_is_branch )
                 begin 
                     case ( ID_stage_inst_ir_dest_with_bubble )
                      3 'b000:
                          begin 
                              if ( ID_stage_inst_reg_read_data_1 ==0) 
                                  ID_stage_inst_branch_taken  =1;
                               else  
                                  ID_stage_inst_branch_taken  =0;
                          end 
                      default :
                          begin  
                              ID_stage_inst_branch_taken  =0;$display("ERROR: Unknown branch condition %b, in branch instruction %b \n", ID_stage_inst_ir_dest_with_bubble , ID_stage_inst_ir_op_code_with_bubble );
                          end endcase
                 end 
              else 
                 begin  
                     ID_stage_inst_branch_taken  =0;
                 end 
         end
  assign  ID_stage_inst_branch_offset_imm = ID_stage_inst_ir_imm ; 
  assign  ID_stage_inst_decoding_op_src1 = ID_stage_inst_ir_src1 ; 
  assign  ID_stage_inst_decoding_op_src2 =( ID_stage_inst_ir_op_code ==4'b0000|| ID_stage_inst_ir_op_code ==4'b1001|| ID_stage_inst_ir_op_code ==4'b1010|| ID_stage_inst_ir_op_code ==4'b1100)?3'b000: ID_stage_inst_ir_src2 ;
    assign ID_stage_inst_clk = clk;
    assign ID_stage_inst_rst = rst;
    assign ID_stage_inst_instruction_decode_en = pipeline_stall_n;
    assign ID_pipeline_reg_out = ID_stage_inst_pipeline_reg_out;
    assign ID_stage_inst_instruction = instruction;
    assign branch_offset_imm = ID_stage_inst_branch_offset_imm;
    assign branch_taken = ID_stage_inst_branch_taken;
    assign reg_read_addr_1 = ID_stage_inst_reg_read_addr_1;
    assign reg_read_addr_2 = ID_stage_inst_reg_read_addr_2;
    assign ID_stage_inst_reg_read_data_1 = reg_read_data_1;
    assign ID_stage_inst_reg_read_data_2 = reg_read_data_2;
    assign decoding_op_src1 = ID_stage_inst_decoding_op_src1;
    assign decoding_op_src2 = ID_stage_inst_decoding_op_src2;
    
	
	wire EX_stage_inst_clk;
    wire EX_stage_inst_rst;
    wire[56:0] EX_stage_inst_pipeline_reg_in;
    reg EX_stage_inst_pipeline_reg_out;
    wire[2:0] EX_stage_inst_ex_op_dest;

    wire[2:0] EX_stage_inst_alu_cmd = EX_stage_inst_pipeline_reg_in [56:54]; 
    wire[15:0] EX_stage_inst_alu_src1 = EX_stage_inst_pipeline_reg_in [53:38]; 
    wire[15:0] EX_stage_inst_alu_src2 = EX_stage_inst_pipeline_reg_in [37:22]; 
    wire[15:0] EX_stage_inst_ex_alu_result ;  
    wire[15:0] alu_inst_a;
    wire[15:0] alu_inst_b;
    wire[2:0] alu_inst_cmd;
    reg alu_inst_r;

    always @(*)
         begin 
             case ( alu_inst_cmd )
              3 'bxxx: 
                  alu_inst_r  =16'bx;
              3 'b000: 
                  alu_inst_r  = alu_inst_a + alu_inst_b ;
              3 'b001: 
                  alu_inst_r  = alu_inst_a - alu_inst_b ;
              3 'b010: 
                  alu_inst_r  = alu_inst_a & alu_inst_b ;
              3 'b011: 
                  alu_inst_r  = alu_inst_a | alu_inst_b ;
              3 'b100: 
                  alu_inst_r  = alu_inst_a ^ alu_inst_b ;
              3 'b101: 
                  alu_inst_r  = alu_inst_a << alu_inst_b ;
              3 'b110: 
                  alu_inst_r  ={{16{ alu_inst_a [15]}}, alu_inst_a }>> alu_inst_b ;
              3 'b111: 
                  alu_inst_r  ={16'b0, alu_inst_a }>> alu_inst_b ;
              default :
                  begin  
                      alu_inst_r  =0;$display("ERROR: Unknown alu cmd: %b \n", alu_inst_cmd );
                  end endcase
         end
 
    assign alu_inst_a = EX_stage_inst_alu_src1;
    assign alu_inst_b = EX_stage_inst_alu_src2;
    assign alu_inst_cmd = EX_stage_inst_alu_cmd;
    assign EX_stage_inst_ex_alu_result = alu_inst_r;
     
  always @( posedge  EX_stage_inst_clk )
         begin 
             if ( EX_stage_inst_rst )
                 begin  
                     EX_stage_inst_pipeline_reg_out  [37:0]<=0;
                 end 
              else 
                 begin  
                     EX_stage_inst_pipeline_reg_out  [37:22]<= EX_stage_inst_ex_alu_result ; 
                     EX_stage_inst_pipeline_reg_out  [21:0]<= EX_stage_inst_pipeline_reg_in [21:0];
                 end 
         end
  assign  EX_stage_inst_ex_op_dest = EX_stage_inst_pipeline_reg_in [3:1];
    assign EX_stage_inst_clk = clk;
    assign EX_stage_inst_rst = rst;
    assign EX_stage_inst_pipeline_reg_in = ID_pipeline_reg_out;
    assign EX_pipeline_reg_out = EX_stage_inst_pipeline_reg_out;
    assign ex_op_dest = EX_stage_inst_ex_op_dest;
    
	
	wire MEM_stage_inst_clk;
    wire MEM_stage_inst_rst;
    wire[37:0] MEM_stage_inst_pipeline_reg_in;
    reg MEM_stage_inst_pipeline_reg_out;
    wire[2:0] MEM_stage_inst_mem_op_dest;

    wire[15:0] MEM_stage_inst_ex_alu_result = MEM_stage_inst_pipeline_reg_in [37:22]; 
    wire MEM_stage_inst_mem_write_en = MEM_stage_inst_pipeline_reg_in [21]; 
    wire[15:0] MEM_stage_inst_mem_write_data = MEM_stage_inst_pipeline_reg_in [20:5]; 
    wire[15:0] MEM_stage_inst_mem_read_data ;  
    wire dmem_clk;
    wire[15:0] dmem_mem_access_addr;
    wire[15:0] dmem_mem_write_data;
    wire dmem_mem_write_en;
    wire[15:0] dmem_mem_read_data;

    reg[15:0] dmem_ram [(2**8)-1:0]; 
    wire[8-1:0] dmem_ram_addr = dmem_mem_access_addr [8-1:0]; 
  always @( posedge  dmem_clk )
         if ( dmem_mem_write_en ) 
             dmem_ram  [ dmem_ram_addr ]<= dmem_mem_write_data ;
  assign  dmem_mem_read_data = dmem_ram [ dmem_ram_addr ];
    assign dmem_clk = MEM_stage_inst_clk;
    assign dmem_mem_access_addr = MEM_stage_inst_ex_alu_result;
    assign dmem_mem_write_data = MEM_stage_inst_mem_write_data;
    assign dmem_mem_write_en = MEM_stage_inst_mem_write_en;
    assign MEM_stage_inst_mem_read_data = dmem_mem_read_data;
     
  always @( posedge  MEM_stage_inst_clk )
         begin 
             if ( MEM_stage_inst_rst )
                 begin  
                     MEM_stage_inst_pipeline_reg_out  [36:0]<=0;
                 end 
              else 
                 begin  
                     MEM_stage_inst_pipeline_reg_out  [36:21]<= MEM_stage_inst_ex_alu_result ; 
                     MEM_stage_inst_pipeline_reg_out  [20:5]<= MEM_stage_inst_mem_read_data ; 
                     MEM_stage_inst_pipeline_reg_out  [4:0]<= MEM_stage_inst_pipeline_reg_in [4:0];
                 end 
         end
  assign  MEM_stage_inst_mem_op_dest = MEM_stage_inst_pipeline_reg_in [3:1];
    assign MEM_stage_inst_clk = clk;
    assign MEM_stage_inst_rst = rst;
    assign MEM_stage_inst_pipeline_reg_in = EX_pipeline_reg_out;
    assign MEM_pipeline_reg_out = MEM_stage_inst_pipeline_reg_out;
    assign mem_op_dest = MEM_stage_inst_mem_op_dest;
    
	
	wire[36:0] WB_stage_inst_pipeline_reg_in;
    wire WB_stage_inst_reg_write_en;
    wire[2:0] WB_stage_inst_reg_write_dest;
    wire[15:0] WB_stage_inst_reg_write_data;
    wire[2:0] WB_stage_inst_wb_op_dest;

    wire[15:0] WB_stage_inst_ex_alu_result = WB_stage_inst_pipeline_reg_in [36:21]; 
    wire[15:0] WB_stage_inst_mem_read_data = WB_stage_inst_pipeline_reg_in [20:5]; 
    wire WB_stage_inst_write_back_en = WB_stage_inst_pipeline_reg_in [4]; 
    wire[2:0] WB_stage_inst_write_back_dest = WB_stage_inst_pipeline_reg_in [3:1]; 
    wire WB_stage_inst_write_back_result_mux = WB_stage_inst_pipeline_reg_in [0]; 
  assign  WB_stage_inst_reg_write_en = WB_stage_inst_write_back_en ; 
  assign  WB_stage_inst_reg_write_dest = WB_stage_inst_write_back_dest ; 
  assign  WB_stage_inst_reg_write_data =( WB_stage_inst_write_back_result_mux )? WB_stage_inst_mem_read_data : WB_stage_inst_ex_alu_result ; 
  assign  WB_stage_inst_wb_op_dest = WB_stage_inst_pipeline_reg_in [3:1];
    assign WB_stage_inst_pipeline_reg_in = MEM_pipeline_reg_out;
    assign reg_write_en = WB_stage_inst_reg_write_en;
    assign reg_write_dest = WB_stage_inst_reg_write_dest;
    assign reg_write_data = WB_stage_inst_reg_write_data;
    assign wb_op_dest = WB_stage_inst_wb_op_dest;
    
	
	wire register_file_inst_clk;
    wire register_file_inst_rst;
    wire register_file_inst_reg_write_en;
    wire[2:0] register_file_inst_reg_write_dest;
    wire[15:0] register_file_inst_reg_write_data;
    wire[2:0] register_file_inst_reg_read_addr_1;
    wire[15:0] register_file_inst_reg_read_data_1;
    wire[2:0] register_file_inst_reg_read_addr_2;
    wire[15:0] register_file_inst_reg_read_data_2;

    reg[15:0] register_file_inst_reg_array [7:0]; 
  always @(  posedge   register_file_inst_clk          or  posedge  register_file_inst_rst )
         begin 
             if ( register_file_inst_rst )
                 begin  
                     register_file_inst_reg_array  [0]<=15'b0; 
                     register_file_inst_reg_array  [1]<=15'b0; 
                     register_file_inst_reg_array  [2]<=15'b0; 
                     register_file_inst_reg_array  [3]<=15'b0; 
                     register_file_inst_reg_array  [4]<=15'b0; 
                     register_file_inst_reg_array  [5]<=15'b0; 
                     register_file_inst_reg_array  [6]<=15'b0; 
                     register_file_inst_reg_array  [7]<=15'b0;
                 end 
              else 
                 begin 
                     if ( register_file_inst_reg_write_en )
                         begin  
                             register_file_inst_reg_array  [ register_file_inst_reg_write_dest ]<= register_file_inst_reg_write_data ;
                         end 
                 end 
         end
  assign  register_file_inst_reg_read_data_1 =( register_file_inst_reg_read_addr_1 ==0)?15'b0: register_file_inst_reg_array [ register_file_inst_reg_read_addr_1 ]; 
  assign  register_file_inst_reg_read_data_2 =( register_file_inst_reg_read_addr_2 ==0)?15'b0: register_file_inst_reg_array [ register_file_inst_reg_read_addr_2 ];
    assign register_file_inst_clk = clk;
    assign register_file_inst_rst = rst;
    assign register_file_inst_reg_write_en = reg_write_en;
    assign register_file_inst_reg_write_dest = reg_write_dest;
    assign register_file_inst_reg_write_data = reg_write_data;
    assign register_file_inst_reg_read_addr_1 = reg_read_addr_1;
    assign reg_read_data_1 = register_file_inst_reg_read_data_1;
    assign register_file_inst_reg_read_addr_2 = reg_read_addr_2;
    assign reg_read_data_2 = register_file_inst_reg_read_data_2;
    
	
	wire[2:0] hazard_detection_unit_inst_decoding_op_src1;
    wire[2:0] hazard_detection_unit_inst_decoding_op_src2;
    wire[2:0] hazard_detection_unit_inst_ex_op_dest;
    wire[2:0] hazard_detection_unit_inst_mem_op_dest;
    wire[2:0] hazard_detection_unit_inst_wb_op_dest;
    reg hazard_detection_unit_inst_pipeline_stall_n;

    always @(*)
         begin  
             hazard_detection_unit_inst_pipeline_stall_n  =1;
             if ( hazard_detection_unit_inst_decoding_op_src1 !=0&&( hazard_detection_unit_inst_decoding_op_src1 == hazard_detection_unit_inst_ex_op_dest || hazard_detection_unit_inst_decoding_op_src1 == hazard_detection_unit_inst_mem_op_dest || hazard_detection_unit_inst_decoding_op_src1 == hazard_detection_unit_inst_wb_op_dest )) 
                 hazard_detection_unit_inst_pipeline_stall_n  =0;
             if ( hazard_detection_unit_inst_decoding_op_src2 !=0&&( hazard_detection_unit_inst_decoding_op_src2 == hazard_detection_unit_inst_ex_op_dest || hazard_detection_unit_inst_decoding_op_src2 == hazard_detection_unit_inst_mem_op_dest || hazard_detection_unit_inst_decoding_op_src2 == hazard_detection_unit_inst_wb_op_dest )) 
                 hazard_detection_unit_inst_pipeline_stall_n  =0;
         end
 
    assign hazard_detection_unit_inst_decoding_op_src1 = decoding_op_src1;
    assign hazard_detection_unit_inst_decoding_op_src2 = decoding_op_src2;
    assign hazard_detection_unit_inst_ex_op_dest = ex_op_dest;
    assign hazard_detection_unit_inst_mem_op_dest = mem_op_dest;
    assign hazard_detection_unit_inst_wb_op_dest = wb_op_dest;
    assign pipeline_stall_n = hazard_detection_unit_inst_pipeline_stall_n;
    
	
endmodule