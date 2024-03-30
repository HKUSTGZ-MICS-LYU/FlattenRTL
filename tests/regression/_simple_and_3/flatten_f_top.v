module simple_and_3 ( in1, in2, out1 );
parameter N1 = 4;
parameter N2 = N1 + 1;
input [N2:0]in1, in2;
output [0:N2]out1;

	
wire  inst1_a;
wire  inst1_b;
wire  inst1_z;
wire  inst2_a;
wire  inst2_b;
wire  inst2_z;
wire  inst3_a;
wire  inst3_b;
wire  inst3_z;
 
 input a; 
 input b; 
 output z; 
  
wire  inst1_inst1_i1,i2;
wire  inst1_inst1_o1;
wire  inst2_inst1_i1,i2;
wire  inst2_inst1_o1;
wire  inst3_inst1_i1,i2;
wire  inst3_inst1_o1;
wire  inst4_i1,i2;
wire  inst4_o1;
 
 input i1,i2; 
 output o1; 
   reg inst1_inst1_o1 ; 
   wire inst1_inst1_w1 =1'b1; 
  always @(   inst1_inst1_i1   or  inst1_inst1_i2  )
        inst1_inst1_o1  = inst1_inst1_i1 ? inst1_inst1_i1 : inst1_inst1_i2 ;



	
 
 input a; 
 input b; 
 output z; 
  
 
 input i1,i2; 
 output o1; 
   reg inst2_inst1_o1 ; 
   wire inst2_inst1_w1 =1'b1; 
  always @(   inst2_inst1_i1   or  inst2_inst1_i2  )
        inst2_inst1_o1  = inst2_inst1_i1 ? inst2_inst1_i1 : inst2_inst1_i2 ;



	
 
 input a; 
 input b; 
 output z; 
  
 
 input i1,i2; 
 output o1; 
   reg inst3_inst1_o1 ; 
   wire inst3_inst1_w1 =1'b1; 
  always @(   inst3_inst1_i1   or  inst3_inst1_i2  )
        inst3_inst1_o1  = inst3_inst1_i1 ? inst3_inst1_i1 : inst3_inst1_i2 ;


assign inst1_a = in1[0];
assign inst1_b = in2[0];
assign out1[0] = inst1_z;
assign inst2_a = in1[1];
assign inst2_b = in2[1];
assign out1[1] = inst2_z;
assign inst3_a = in1[2];
assign inst3_b = in2[2];
assign out1[2] = inst3_z;

	
 
 input i1,i2; 
 output o1; 
   reg inst4_o1 ; 
   wire inst4_w1 =1'b1; 
  always @(   inst4_i1   or  inst4_i2  )
        inst4_o1  = inst4_i1 ? inst4_i1 : inst4_i2 ;

assign inst1_inst1_i1,i2 = inst1_a;
assign inst1_b = inst1_inst1_o1;
assign inst2_inst1_i1,i2 = inst1_z;
assign inst2_a = inst2_inst1_o1;
assign inst3_inst1_i1,i2 = inst2_b;
assign inst2_z = inst3_inst1_o1;
assign inst4_i1,i2 = inst3_a;
assign inst3_b = inst4_o1;

	
wire [1:0] inst5_i1;
wire [0:1] inst5_o1;
 
 input [1:0]i1; 
 output [0:1]o1; 
   reg[0:1] inst5_o1 ; 
  always @( posedge  inst5_i1 )
       begin : inst5_l1 
10
             inst5_o1  =
20 inst5_i1 ;
       end
 
assign inst5_i1 = in1[5:4];
assign out1[4:5] = inst5_o1;

endmodule
