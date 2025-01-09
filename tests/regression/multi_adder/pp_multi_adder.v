module adder (
	a,
	b,
	sum
);
	parameter OFFSET = 0;
	input wire [3:0] a;
	input wire [3:0] b;
	output wire [4:0] sum;
	assign sum = (a + b) + OFFSET;
endmodule
module multiplier (
	a,
	b,
	product
);
	parameter MULTIPLIER = 1;
	input wire [3:0] a;
	input wire [3:0] b;
	output wire [7:0] product;
	assign product = (a * b) * MULTIPLIER;
endmodule
module top_module (
	in1,
	in2,
	sum_out,
	product_out
);
	input wire [3:0] in1;
	input wire [3:0] in2;
	output wire [4:0] sum_out;
	output wire [7:0] product_out;
	adder #(.OFFSET(10)) u_adder(
		.a(in1),
		.b(in2),
		.sum(sum_out)
	);
	multiplier #(.MULTIPLIER(2)) u_multiplier(
		.a(in1),
		.b(in2),
		.product(product_out)
	);
endmodule
