`timescale 1ns/1ps

module test_dut;

	reg	[15:0] ram[0:2**19-1];
	reg [19:0] pc1;
	reg [19:0] pc2;
	reg [19:0] pc3;
	reg [19:0] pc4;
	reg [19:0] pc5;
	reg [19:0] pc6;
	reg [19:0] pc7;
	reg [19:0] pc8;

	reg clk;
	reg rst;

	reg [7:0]   clk_cyclec; //current cycle count
	reg [7:0]   clk_cyclen; //clk_cyclec+1

	wire [127:0] key;
	wire [127:0] out;
	
	// Instantiate the Unit Under Test (UUT)
	top dut (
		.clk(clk),
		.rst(rst),
		.key(key),
		.out(out)
	);
	
	assign key[15:0] = ram[pc1] ;
	assign key[31:16] = ram[pc2] ;
	assign key[47:32] = ram[pc3] ;
	assign key[63:48] = ram[pc4] ;
	assign key[79:64] = ram[pc5] ;
	assign key[95:80] = ram[pc6] ;
	assign key[111:96] = ram[pc7] ;
	assign key[127:112] = ram[pc8] ;

	always 
	begin
		#4 clk = ~clk;  // 12.5 Mhz
		$strobe("#clk #kick %b ----------------------------------------------------------------------------------------------------", clk);
	end
	always 
	begin
		#500	$finish;
	end	
	always @(posedge clk)
	begin
		clk_cyclec <= clk_cyclec + 8'b1;
		clk_cyclen <= clk_cyclen + 8'b1;
		pc1 <= pc1 + 20'b1000;
		pc2 <= pc2 + 20'b1000;
		pc3 <= pc3 + 20'b1000;
		pc4 <= pc4 + 20'b1000;
		pc5 <= pc5 + 20'b1000;
		pc6 <= pc6 + 20'b1000;
		pc7 <= pc7 + 20'b1000;
		pc8 <= pc8 + 20'b1000;
	end
	
	initial
	begin
		clk_cyclec = 8'b1010;
		clk_cyclen = 8'b1011;
		
		pc1  = 20'h77ff8;
		pc2  = 20'h77ff9;
		pc3  = 20'h77ffa;
		pc4  = 20'h77ffb;
		pc5  = 20'h77ffc;
		pc6  = 20'h77ffd;
		pc7  = 20'h77ffe;
		pc8  = 20'h77fff;

	    clk = 1'b0;
	    rst = 1'b0;
	 #4 rst = 1'b1;
	 #1 rst = 1'b0;
    end
	initial
    begin
      $readmemh("data.mem", ram, 19'h78000);
    end



endmodule
