module TopModule #(
    parameter adder1___WIDTH=8,
    parameter adder1___SHIFT=0,
    parameter adder2___WIDTH=16,
    parameter adder2___SHIFT=1) (
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
	
    // INSTANCE: [adder3]
    wire[1:0] adder3___a;
    wire[1:0] adder3___b;
    wire adder3___sum;
    assign adder3___a = a1[1:0];
    assign adder3___b = b1[1:0];
    assign sum1[1:0] = adder3___sum;

    assign  adder3___sum =( adder3___a + adder3___b )<< adder3___SHIFT ;

    // INSTANCE: [adder1]
    wire[adder1___WIDTH-1:0] adder1___a;
    wire[adder1___WIDTH-1:0] adder1___b;
    wire adder1___sum;
    assign adder1___a = a1;
    assign adder1___b = b1;
    assign sum1 = adder1___sum;
    assign  adder1___sum =( adder1___a + adder1___b )<< adder1___SHIFT ;

    // INSTANCE: [adder2]
    wire[adder2___WIDTH-1:0] adder2___a;
    wire[adder2___WIDTH-1:0] adder2___b;
    wire adder2___sum;
    assign adder2___a = a2;
    assign adder2___b = b2;
    assign sum2 = adder2___sum;
    assign  adder2___sum =( adder2___a + adder2___b )<< adder2___SHIFT ;
    
endmodule