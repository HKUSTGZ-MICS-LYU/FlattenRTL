module adder_8bit (
  input [7:0] a,
  input [7:0] b,
  output [7:0] sum) ; 
  assign sum=a+b; 
endmodule
 
module adder_16bit (
  input [15:0] a,
  input [15:0] b,
  output [15:0] sum) ; 
  adder_8bit add_high(.a(a[15:8]),.b(b[15:8]),.sum(sum[15:8])); 
  adder_8bit add_low(.a(a[7:0]),.b(b[7:0]),.sum(sum[7:0])); 
endmodule
 
module adder_32bit (
  input [31:0] a,
  input [31:0] b,
  output [31:0] sum) ; 
  adder_16bit add_high(.a(a[31:16]),.b(b[31:16]),.sum(sum[31:16])); 
  adder_16bit add_low(.a(a[15:0]),.b(b[15:0]),.sum(sum[15:0])); 
endmodule
 
