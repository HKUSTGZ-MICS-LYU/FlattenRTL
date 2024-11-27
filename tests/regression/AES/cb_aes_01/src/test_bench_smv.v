`timescale 1ns/1ps

module test_dut;

	reg clk;
	reg rst;

	reg [127:0] key;
	wire [127:0] out;
	
	// Instantiate the Unit Under Test (UUT)
	top dut (
		.clk(clk),
		.rst(rst),
		.key(key),
		.out(out)
	);

	always 
	begin
		#4 clk = ~clk;  // 12.5 Mhz
	end
	always 
	begin
		#400	$finish;
	end	
	
	initial
	begin
		$monitor("%h", out);
		key = 128'hc2f45dfa_8acd3f4d_a3dcfe8a_93cefa0a;
	    clk = 1'b0;
	    rst = 1'b0;
	 #4 rst = 1'b1;
	 #1 rst = 1'b0;
    end

endmodule
