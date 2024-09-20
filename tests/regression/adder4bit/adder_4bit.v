module adder_4bit ( // hello
    input [3:0] a,
    input [3:0] b,
    output [4:0] sum
);
    wire [2:0] sum_lower;
    wire [2:0] sum_upper;

    adder_2bit adder_lower (
        .a(a[1:0]),
        .b(b[1:0]),
        .sum(sum_lower)
    );

    adder_2bit adder_upper (
        .a(a[3:2]),
        .b(b[3:2]),
        .sum(sum_upper)
    );

    assign sum = {sum_upper[2:0], sum_lower[1:0]};
endmodule

