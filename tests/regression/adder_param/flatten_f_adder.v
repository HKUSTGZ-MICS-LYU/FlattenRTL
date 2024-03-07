module TopModule(a1, b1, a2, b2, sum1, sum2);
    input [7:0] a1, b1;         // Inputs for the first adder
    input [15:0] a2, b2;         // Inputs for the second adder
    output [7:0] sum1;           // Output for the first adder (no shift applied, acts as before)
    output [15+1:0] sum2;         // Output for the second adder with an extra bit to accommodate for shift

    // Instantiate the first adder with a width of 8 bits and no shift

    wire [8-1:0] adder1_a;
    wire [8-1:0] adder1_b;
    wire [8-1+0:0] adder1_sum;
    wire [8-1:0] adder2_a;
    wire [8-1:0] adder2_b;
    wire [8-1+0:0] adder2_sum;

    input [8-1:0]a;
    input [8-1:0]b;
    output [8-1+0:0]sum;
    assign  adder1_sum =( adder1_a + adder1_b )<<0;


    // Instantiate the second adder with a width of 16 bits and a shift of 1 bit


    input [16-1:0]a;
    input [16-1:0]b;
    output [16-1+1:0]sum;
    assign  adder2_sum =( adder2_a + adder2_b )<<1;
    assign adder1_a = a1;
    assign adder1_b = b1;
    assign sum1 = adder1_sum;
    assign adder2_a = a2;
    assign adder2_b = b2;
    assign sum2 = adder2_sum;


endmodule
