// Parameterized Adder Module
module Adder #(
    parameter WIDTH = 8  // Default bit width is 8 bits
)(
    input [WIDTH-1:0] a, b,  // Two inputs
    output [WIDTH-1:0] sum   // Output sum
);

// Compute the sum of the inputs
assign sum = a + b;

endmodule

// Top Level Module
module TopModule(
    input [7:0] a1, b1,  // Inputs for the first adder
    input [15:0] a2, b2, // Inputs for the second adder
    output [7:0] sum1,   // Output for the first adder
    output [15:0] sum2   // Output for the second adder
);

// Instantiate the first adder with a width of 8 bits
Adder #(
    .WIDTH(8)
) adder1 (
    .a(a1),
    .b(b1),
    .sum(sum1)
);

// Instantiate the second adder with a width of 16 bits
Adder #(
    .WIDTH(16)
) adder2 (
    .a(a2),
    .b(b2),
    .sum(sum2)
);

endmodule
