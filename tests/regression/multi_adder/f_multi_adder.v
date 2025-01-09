module top_module #(
    parameter u_adder___OFFSET=10,
    parameter p_adder___OFFSET=8,
    parameter u_multiplier___MULTIPLIER=2) (
	in1,
	in2,
	sum_out,
	product_out
);
	input [3:0] in1;
	input [3:0] in2;
	output [4:0] sum_out;
	output [7:0] product_out;
	
    // INSTANCE: [u_adder]
    wire[3:0] u_adder___a;
    assign u_adder___a = in1;
    wire[3:0] u_adder___b;
    assign u_adder___b = in2;
    wire[4:0] u_adder___sum;
    assign sum_out = u_adder___sum;

    assign  u_adder___sum =( u_adder___a + u_adder___b )+ u_adder___OFFSET ;

    // INSTANCE: [p_adder]
    wire[3:0] p_adder___a;
    assign p_adder___a = in1;
    wire[3:0] p_adder___b;
    assign p_adder___b = in2;
    wire[4:0] p_adder___sum;
    assign sum_out = p_adder___sum;
    assign  p_adder___sum =( p_adder___a + p_adder___b )+ p_adder___OFFSET ;

    // INSTANCE: [u_multiplier]
    wire[3:0] u_multiplier___a;
    assign u_multiplier___a = in1;
    wire[3:0] u_multiplier___b;
    assign u_multiplier___b = in2;
    wire[7:0] u_multiplier___product;
    assign product_out = u_multiplier___product;
    assign  u_multiplier___product =( u_multiplier___a * u_multiplier___b )* u_multiplier___MULTIPLIER ;
    
endmodule