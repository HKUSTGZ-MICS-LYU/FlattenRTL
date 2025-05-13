module Adder (
	a,
	b,
	sum
);
	parameter WIDTH = 8;
	parameter SHIFT = 0;
	input [WIDTH - 1:0] a;
	input [WIDTH - 1:0] b;
	output wire [(WIDTH - 1) + SHIFT:0] sum;
	assign sum = (a + b) << SHIFT;
endmodule
module Adder2 (
	a,
	b,
	sum
);
	input [1:0] a;
	input [1:0] b;
	output wire [1:0] sum;
	assign sum = (a + b) << SHIFT;
endmodule
module TopModule (
	a1,
	b1,
	a2,
	b2,
	sum1,
	sum2
);
	input [7:0] a1;
	input [7:0] b1;
	input [15:0] a2;
	input [15:0] b2;
	output wire [7:0] sum1;
	output wire [16:0] sum2;
	Adder2 adder3(
		.a(a1[1:0]),
		.b(b1[1:0]),
		.sum(sum1[1:0])
	);
	Adder #(
		.WIDTH(8),
		.SHIFT(0)
	) adder1(
		.a(a1),
		.b(b1),
		.sum(sum1)
	);
	Adder #(
		.WIDTH(16),
		.SHIFT(1)
	) adder2(
		.a(a2),
		.b(b2),
		.sum(sum2)
	);
endmodule
