module main (
        input clk) ;
    wire [0:4] aluOut ;
    wire [0:4] memOut1 ;
    wire [0:4] memOut2 ;
    wire [0:2] readLoc1 ;
    wire [0:2] readLoc2 ;
    wire [0:11] instruction ;
    wire [0:2] opcode ;
    wire [0:2] writeLoc ;
    wire [0:2] progCntr ;

    wire  M_clk;
    wire [0:2] M_opcode;
    wire [0:2] M_readLoc1;
    wire [0:2] M_readLoc2;
    wire [0:2] M_writeLoc;
    wire [0:4] M_data;
    wire [0:4] M_memOut1;
    wire [0:4] M_memOut2;
    assign M_clk = clk;
    assign M_opcode = opcode;
    assign M_readLoc1 = readLoc1;
    assign M_readLoc2 = readLoc2;
    assign M_writeLoc = writeLoc;
    assign M_data = aluOut;
    assign memOut1 = M_memOut1;
    assign memOut2 = M_memOut2;

    wire[0:4] M_memOut1 ;
    wire[0:4] M_memOut2 ;
    reg[0:4] M_m0 ;
    reg[0:4] M_m1 ;
    reg[0:4] M_m2 ;
    reg[0:4] M_m3 ;
    reg[0:4] M_m4 ;
    reg[0:4] M_m5 ;
    reg[0:4] M_m6 ;
    reg[0:4] M_m7 ;
    initial
    begin
        M_m0  =1;
    end
    initial
    begin
        M_m1  =0;
    end
    initial
    begin
        M_m2  =0;
    end
    initial
    begin
        M_m3  =0;
    end
    initial
    begin
        M_m4  =0;
    end
    initial
    begin
        M_m5  =0;
    end
    initial
    begin
        M_m6  =0;
    end
    initial
    begin
        M_m7  =0;
    end
    assign  M_memOut1 =( M_readLoc1 ==0)? M_m0 :( M_readLoc1 ==1)? M_m1 :( M_readLoc1 ==2)? M_m2 :( M_readLoc1 ==3)? M_m3 :( M_readLoc1 ==4)? M_m5 :( M_readLoc1 ==5)? M_m5 :( M_readLoc1 ==6)? M_m6 : M_m7 ;
    assign  M_memOut2 =( M_readLoc2 ==0)? M_m0 :( M_readLoc2 ==1)? M_m1 :( M_readLoc2 ==2)? M_m2 :( M_readLoc2 ==3)? M_m3 :( M_readLoc2 ==4)? M_m5 :( M_readLoc2 ==5)? M_m5 :( M_readLoc2 ==6)? M_m6 : M_m7 ;
    always @( posedge  M_clk )
    begin
        if ( M_opcode !=1)
        begin
            if ( M_writeLoc ==0)
            begin
                M_m0  = M_data ;
            end
            if ( M_writeLoc ==1)
            begin
                M_m1  = M_data ;
            end
            if ( M_writeLoc ==2)
            begin
                M_m2  = M_data ;
            end
            if ( M_writeLoc ==3)
            begin
                M_m3  = M_data ;
            end
            if ( M_writeLoc ==4)
            begin
                M_m4  = M_data ;
            end
            if ( M_writeLoc ==5)
            begin
                M_m5  = M_data ;
            end
            if ( M_writeLoc ==6)
            begin
                M_m6  = M_data ;
            end
            if ( M_writeLoc ==7)
            begin
                M_m7  = M_data ;
            end
        end
    end



    wire  P_clk;
    wire [0:2] P_progCntr;
    wire [0:11] P_instruction;
    assign P_clk = clk;
    assign P_progCntr = progCntr;
    assign instruction = P_instruction;

    wire[0:11] P_instr0 ;
    wire[0:11] P_instr1 ;
    wire[0:11] P_instr2 ;
    wire[0:11] P_instr3 ;
    wire[0:11] P_instr4 ;
    wire[0:11] P_instr5 ;
    wire[0:11] P_instr6 ;
    wire[0:11] P_instr7 ;
    assign  P_instr0 =576;
    assign  P_instr1 =1152;
    assign  P_instr2 =1728;
    assign  P_instr3 =2304;
    assign  P_instr4 =505;
    assign  P_instr5 =0;
    assign  P_instr6 =0;
    assign  P_instr7 =0;
    assign  P_instruction =( P_progCntr ==0)? P_instr0 :( P_progCntr ==1)? P_instr1 :( P_progCntr ==2)? P_instr2 :( P_progCntr ==3)? P_instr3 :( P_progCntr ==4)? P_instr4 :( P_progCntr ==5)? P_instr5 :( P_progCntr ==6)? P_instr6 : P_instr7 ;


    wire  Opcode_clk;
    wire [0:11] Opcode_instruction;
    wire [0:2] Opcode_opcode;
    assign Opcode_clk = clk;
    assign Opcode_instruction = instruction;
    assign opcode = Opcode_opcode;

    assign  Opcode_opcode = Opcode_instruction [0:2];


    wire  Loc1_clk;
    wire [0:11] Loc1_instruction;
    wire [0:2] Loc1_readLoc1;
    assign Loc1_clk = clk;
    assign Loc1_instruction = instruction;
    assign readLoc1 = Loc1_readLoc1;

    assign  Loc1_readLoc1 = Loc1_instruction [3:5];


    wire  Loc2_clk;
    wire [0:11] Loc2_instruction;
    wire [0:2] Loc2_readLoc2;
    assign Loc2_clk = clk;
    assign Loc2_instruction = instruction;
    assign readLoc2 = Loc2_readLoc2;

    assign  Loc2_readLoc2 = Loc2_instruction [6:8];


    wire  Loc3_clk;
    wire [0:11] Loc3_instruction;
    wire [0:2] Loc3_writeLoc;
    assign Loc3_clk = clk;
    assign Loc3_instruction = instruction;
    assign writeLoc = Loc3_writeLoc;

    assign  Loc3_writeLoc = Loc3_instruction [9:11];


    wire  ALU_clk;
    wire [0:2] ALU_opcode;
    wire [0:4] ALU_operand1;
    wire [0:4] ALU_operand2;
    wire [0:4] ALU_aluOut;
    assign ALU_clk = clk;
    assign ALU_opcode = opcode;
    assign ALU_operand1 = memOut1;
    assign ALU_operand2 = memOut2;
    assign aluOut = ALU_aluOut;

    assign  ALU_aluOut =( ALU_opcode ==0)?( ALU_operand1 + ALU_operand2 ):( ALU_opcode ==3)?( ALU_operand1 ^ ALU_operand2 ):( ALU_opcode ==1)?( ALU_operand1 & ALU_operand2 ):0;


    wire  PC_clk;
    wire [0:2] PC_opcode;
    wire [0:4] PC_operand1;
    wire [0:4] PC_operand2;
    reg [0:2] PC_progCntr;
    assign PC_clk = clk;
    assign PC_opcode = opcode;
    assign PC_operand1 = memOut1;
    assign PC_operand2 = memOut2;
    assign progCntr = PC_progCntr;
    initial
    begin
        PC_progCntr  =0;
    end
    always @( posedge  PC_clk )
    begin
        if (( PC_opcode ==1)&&( PC_operand1 ==0))
        begin
            PC_progCntr  = PC_operand2 [0:2];
        end
        else
        begin
            PC_progCntr  = PC_progCntr +1;
        end
    end


endmodule
