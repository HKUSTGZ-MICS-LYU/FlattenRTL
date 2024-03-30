module main (clk) ; 
  input clk; 
   wire [0:4] aluOut ;  
   wire [0:4] memOut1 ;  
   wire [0:4] memOut2 ;  
   wire [0:2] readLoc1 ;  
   wire [0:2] readLoc2 ;  
   wire [0:11] instruction ;  
   wire [0:2] opcode ;  
   wire [0:2] writeLoc ;  
   wire [0:2] progCntr ;  
  memory M(clk,opcode,readLoc1,readLoc2,writeLoc,aluOut,memOut1,memOut2); 
  program P(clk,progCntr,instruction); 
  decodeOpcd Opcode(clk,instruction,opcode); 
  decodeLoc1 Loc1(clk,instruction,readLoc1); 
  decodeLoc2 Loc2(clk,instruction,readLoc2); 
  decodeLoc3 Loc3(clk,instruction,writeLoc); 
  alu ALU(clk,opcode,memOut1,memOut2,aluOut); 
  pc PC(clk,opcode,memOut1,memOut2,progCntr); 
endmodule
 
module memory (clk,opcode,readLoc1,readLoc2,writeLoc,data,memOut1,memOut2) ; 
  input clk; 
  input [0:2] opcode; 
  input [0:2] readLoc1; 
  input [0:2] readLoc2; 
  input [0:2] writeLoc; 
  input [0:4] data; 
  output [0:4] memOut1; 
  output [0:4] memOut2; 
   wire [0:4] memOut1 ;  
   wire [0:4] memOut2 ;  
   reg [0:4] m0 ;  
   reg [0:4] m1 ;  
   reg [0:4] m2 ;  
   reg [0:4] m3 ;  
   reg [0:4] m4 ;  
   reg [0:4] m5 ;  
   reg [0:4] m6 ;  
   reg [0:4] m7 ;  initial
    begin 
      m0 =1;
    end  initial
    begin 
      m1 =0;
    end  initial
    begin 
      m2 =0;
    end  initial
    begin 
      m3 =0;
    end  initial
    begin 
      m4 =0;
    end  initial
    begin 
      m5 =0;
    end  initial
    begin 
      m6 =0;
    end  initial
    begin 
      m7 =0;
    end  
  assign memOut1=(readLoc1==0)?m0:(readLoc1==1)?m1:(readLoc1==2)?m2:(readLoc1==3)?m3:(readLoc1==4)?m5:(readLoc1==5)?m5:(readLoc1==6)?m6:m7; 
  assign memOut2=(readLoc2==0)?m0:(readLoc2==1)?m1:(readLoc2==2)?m2:(readLoc2==3)?m3:(readLoc2==4)?m5:(readLoc2==5)?m5:(readLoc2==6)?m6:m7; 
  always @( posedge clk)
       begin 
         if (opcode!=1)
            begin 
              if (writeLoc==0)
                 begin 
                   m0 =data;
                 end 
              if (writeLoc==1)
                 begin 
                   m1 =data;
                 end 
              if (writeLoc==2)
                 begin 
                   m2 =data;
                 end 
              if (writeLoc==3)
                 begin 
                   m3 =data;
                 end 
              if (writeLoc==4)
                 begin 
                   m4 =data;
                 end 
              if (writeLoc==5)
                 begin 
                   m5 =data;
                 end 
              if (writeLoc==6)
                 begin 
                   m6 =data;
                 end 
              if (writeLoc==7)
                 begin 
                   m7 =data;
                 end 
            end 
       end
  
endmodule
 
module program (clk,progCntr,instruction) ; 
  input clk; 
  input [0:2] progCntr; 
  output [0:11] instruction; 
   wire [0:11] instr0 ;  
   wire [0:11] instr1 ;  
   wire [0:11] instr2 ;  
   wire [0:11] instr3 ;  
   wire [0:11] instr4 ;  
   wire [0:11] instr5 ;  
   wire [0:11] instr6 ;  
   wire [0:11] instr7 ;  
  assign instr0=576; 
  assign instr1=1152; 
  assign instr2=1728; 
  assign instr3=2304; 
  assign instr4=505; 
  assign instr5=0; 
  assign instr6=0; 
  assign instr7=0; 
  assign instruction=(progCntr==0)?instr0:(progCntr==1)?instr1:(progCntr==2)?instr2:(progCntr==3)?instr3:(progCntr==4)?instr4:(progCntr==5)?instr5:(progCntr==6)?instr6:instr7; 
endmodule
 
module decodeOpcd (clk,instruction,opcode) ; 
  input clk; 
  input [0:11] instruction; 
  output [0:2] opcode; 
  assign opcode=instruction[0:2]; 
endmodule
 
module decodeLoc1 (clk,instruction,readLoc1) ; 
  input clk; 
  input [0:11] instruction; 
  output [0:2] readLoc1; 
  assign readLoc1=instruction[3:5]; 
endmodule
 
module decodeLoc2 (clk,instruction,readLoc2) ; 
  input clk; 
  input [0:11] instruction; 
  output [0:2] readLoc2; 
  assign readLoc2=instruction[6:8]; 
endmodule
 
module decodeLoc3 (clk,instruction,writeLoc) ; 
  input clk; 
  input [0:11] instruction; 
  output [0:2] writeLoc; 
  assign writeLoc=instruction[9:11]; 
endmodule
 
module alu (clk,opcode,operand1,operand2,aluOut) ; 
  input clk; 
  input [0:2] opcode; 
  input [0:4] operand1; 
  input [0:4] operand2; 
  output [0:4] aluOut; 
  assign aluOut=(opcode==0)?(operand1+operand2):(opcode==3)?(operand1^operand2):(opcode==2)?(operand1&operand2):0; 
endmodule
 
module pc (clk,opcode,operand1,operand2,progCntr) ; 
  input clk; 
  input [0:2] opcode; 
  input [0:4] operand1; 
  input [0:4] operand2; 
  output [0:2] progCntr; 
   reg [0:2] progCntr ;  initial
    begin 
      progCntr =0;
    end  
  always @( posedge clk)
       begin 
         if ((opcode==1)&&(operand1==0))
            begin 
              progCntr =operand2[0:2];
            end 
          else 
            begin 
              progCntr =progCntr+1;
            end 
       end
  
endmodule
 
