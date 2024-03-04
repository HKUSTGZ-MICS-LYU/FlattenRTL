module Adder 
(
 parameter WIDTH =8) (WIDTH,a,b,sum) ; 
  assign sum=a+b; 
endmodule
 
module TopModule (a1,b1,a2,b2,sum1,sum2) ; 
  Adder 
(.WIDTH(8))adder1(.a(a1),.b(b1),.sum(sum1)); 
  Adder 
(.WIDTH(16))adder2(.a(a2),.b(b2),.sum(sum2)); 
endmodule
 
