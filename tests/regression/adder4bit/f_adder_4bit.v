module adder_4bit (
    input [3:0] a,
    input [3:0] b,
    output [4:0] sum
);
    wire [2:0] sum_lower;
    wire [2:0] sum_upper;

    wire[1:0] adder_lower_a;
    wire[1:0] adder_lower_b;
    wire[2:0] adder_lower_sum;
    wire[1:0] adder_upper_a;
    wire[1:0] adder_upper_b;
    wire[2:0] adder_upper_sum;

    assign  adder_lower_sum = adder_lower_a + adder_lower_b ;
    assign  adder_upper_sum = adder_upper_a + adder_upper_b ;
    assign adder_lower_a = a[1:0];
    assign adder_lower_b = b[1:0];
    assign sum_lower = adder_lower_sum;
    assign adder_upper_a = a[3:2];
    assign adder_upper_b = b[3:2];
    assign sum_upper = adder_upper_sum;
    

    assign sum = {sum_upper[2:0], sum_lower[1:0]};
endmodule