// 8 bit adder
module adder_8bit(a, b, sum);
   input  [7:0] a;
   input  [7:0] b;
   output [7:0] sum;
   assign sum = a + b;
endmodule

// 16 bit adder
module adder_16bit(a, b, sum);
   input  [15:0] a;
   input  [15:0] b;
   output [15:0] sum;

   adder_8bit add_high (
       .a(a[15:8]),
       .b(b[15:8]), 
       .sum(sum[15:8])
   );

   adder_8bit add_low (
       .a(a[7:0]),
       .b(b[7:0]),
       .sum(sum[7:0]) 
   );
endmodule 

// 32 bit adder
module adder_32bit(a, b, sum);
   input  [31:0] a;
   input  [31:0] b;
   output [31:0] sum;

   adder_16bit add_high (
       .a(a[31:16]),
       .b(b[31:16]),
       .sum(sum[31:16])
   );  

   adder_16bit add_low (
       .a(a[15:0]),
       .b(b[15:0]), 
       .sum(sum[15:0])
   );
endmodule

