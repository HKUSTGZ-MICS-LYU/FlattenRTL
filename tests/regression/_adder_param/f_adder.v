module TopModule(a1, b1, a2, b2, sum1, sum2);
    input [7:0] a1, b1;         // Inputs for the first adder
    input [15:0] a2, b2;         // Inputs for the second adder
    output [7:0] sum1;           // Output for the first adder (no shift applied, acts as before)
    output [15+1:0] sum2;         // Output for the second adder with an extra bit to accommodate for shift

    wire[1:0] adder3_a;
    wire[1:0] adder3_b;
    wire[1:0] adder3_sum;

    assign  adder3_sum =( adder3_a + adder3_b )<< adder3_SHIFT ;
    assign adder3_a = a1[1:0];
    assign adder3_b = b1[1:0];
    assign sum1[1:0] = adder3_sum;
    

// Instantiate the first adder with a width of 8 bits and no shift
Adder #(
    .WIDTH(8),
    .SHIFT(0)
) adder1 (
    .a(a1),
    .b(b1),
    .sum(sum1)
);



// Instantiate the second adder with a width of 16 bits and a shift of 1 bit
Adder #(
    .WIDTH(16),
    .SHIFT(1)
) adder2 (
    .a(a2),
    .b(b2),
    .sum(sum2)
);

endmodule