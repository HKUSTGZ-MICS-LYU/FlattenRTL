module delimeter_dot ( a,b,z );
	input  a,b;
	output z;
	
wire  inst1_i1,i2;
wire  inst1_o1;
 
 input i1,i2; 
 output o1; 
  assign  inst1_o1 = inst1_i1 & inst1_i2 ;
assign inst1_i1,i2 = a;
assign b = inst1_o1;

endmodule
