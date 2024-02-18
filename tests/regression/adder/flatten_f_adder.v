module adder_32bit (
  input [31:0] a,
  input [31:0] b,
  output [31:0] sum) ; 
  
wire [15:0] add_high_a;
wire [15:0] add_high_b;
wire [15:0] add_high_sum;
wire [15:0] add_low_a;
wire [15:0] add_low_b;
wire [15:0] add_low_sum;
assign add_high_a = a[31:16];
assign add_high_b = b[31:16];
assign sum[31:16] = add_high_sum;
assign add_low_a = a[31:16];
assign add_low_b = b[31:16];
assign sum[31:16] = add_low_sum;
 
  
wire [7:0] add_high_add_high_a;
wire [7:0] add_high_add_high_b;
wire [7:0] add_high_add_high_sum;
wire [7:0] add_high_add_low_a;
wire [7:0] add_high_add_low_b;
wire [7:0] add_high_add_low_sum;
wire [7:0] add_low_add_high_a;
wire [7:0] add_low_add_high_b;
wire [7:0] add_low_add_high_sum;
wire [7:0] add_low_add_low_a;
wire [7:0] add_low_add_low_b;
wire [7:0] add_low_add_low_sum;
assign add_high_add_high_a = add_high_a[15:8];
assign add_high_add_high_b = add_high_b[15:8];
assign add_high_sum[15:8] = add_high_add_high_sum;
assign add_high_add_low_a = add_high_a[15:8];
assign add_high_add_low_b = add_high_b[15:8];
assign add_high_sum[15:8] = add_high_add_low_sum;
assign add_low_add_high_a = add_high_a[15:8];
assign add_low_add_high_b = add_high_b[15:8];
assign add_high_sum[15:8] = add_low_add_high_sum;
assign add_low_add_low_a = add_high_a[15:8];
assign add_low_add_low_b = add_high_b[15:8];
assign add_high_sum[15:8] = add_low_add_low_sum;
 
  assign  add_high_add_high_sum = add_high_add_high_a + add_high_add_high_b ;
 
  
 
  assign  add_high_add_low_sum = add_high_add_low_a + add_high_add_low_b ;

 
  
 
  
 
  assign  add_low_add_high_sum = add_low_add_high_a + add_low_add_high_b ;
 
  
 
  assign  add_low_add_low_sum = add_low_add_low_a + add_low_add_low_b ;

 
endmodule
