module BRAM2 (
	CLKA,
	ENA,
	WEA,
	ADDRA,
	DIA,
	DOA,
	CLKB,
	ENB,
	WEB,
	ADDRB,
	DIB,
	DOB
);
	parameter PIPELINED = 0;
	parameter ADDR_WIDTH = 1;
	parameter DATA_WIDTH = 1;
	parameter MEMSIZE = 1;
	input CLKA;
	input ENA;
	input WEA;
	input [ADDR_WIDTH - 1:0] ADDRA;
	input [DATA_WIDTH - 1:0] DIA;
	output wire [DATA_WIDTH - 1:0] DOA;
	input CLKB;
	input ENB;
	input WEB;
	input [ADDR_WIDTH - 1:0] ADDRB;
	input [DATA_WIDTH - 1:0] DIB;
	output wire [DATA_WIDTH - 1:0] DOB;
	reg [DATA_WIDTH - 1:0] RAM [0:MEMSIZE - 1];
	reg [DATA_WIDTH - 1:0] DOA_R;
	reg [DATA_WIDTH - 1:0] DOB_R;
	reg [DATA_WIDTH - 1:0] DOA_R2;
	reg [DATA_WIDTH - 1:0] DOB_R2;
	integer i;
	initial begin : init_block
		for (i = 0; i < MEMSIZE; i = i + 1)
			RAM[i] = {(DATA_WIDTH + 1) / 2 {2'b10}};
		DOA_R = {(DATA_WIDTH + 1) / 2 {2'b10}};
		DOB_R = {(DATA_WIDTH + 1) / 2 {2'b10}};
		DOA_R2 = {(DATA_WIDTH + 1) / 2 {2'b10}};
		DOB_R2 = {(DATA_WIDTH + 1) / 2 {2'b10}};
	end
	always @(posedge CLKA) begin
		if (ENA) begin
			if (WEA) begin
				RAM[ADDRA] <= DIA;
				DOA_R <= DIA;
			end
			else
				DOA_R <= RAM[ADDRA];
		end
		DOA_R2 <= DOA_R;
	end
	always @(posedge CLKB) begin
		if (ENB) begin
			if (WEB) begin
				RAM[ADDRB] <= DIB;
				DOB_R <= DIB;
			end
			else
				DOB_R <= RAM[ADDRB];
		end
		DOB_R2 <= DOB_R;
	end
	assign DOA = (PIPELINED ? DOA_R2 : DOA_R);
	assign DOB = (PIPELINED ? DOB_R2 : DOB_R);
endmodule

module top (A);
	input A;
  BRAM2 #(.PIPELINED(1'd0),
	  .ADDR_WIDTH(32'd9),
	  .DATA_WIDTH(32'd54),
	  .MEMSIZE(10'd512)) btb_bramcore2(.CLKA(CLK),
					   .CLKB(CLK),
					   .ADDRA(btb_bramcore2$ADDRA),
					   .ADDRB(btb_bramcore2$ADDRB),
					   .DIA(btb_bramcore2$DIA),
					   .DIB(btb_bramcore2$DIB),
					   .WEA(btb_bramcore2$WEA),
					   .WEB(btb_bramcore2$WEB),
					   .ENA(btb_bramcore2$ENA),
					   .ENB(btb_bramcore2$ENB),
					   .DOA(btb_bramcore2$DOA),
					   .DOB());


endmodule
