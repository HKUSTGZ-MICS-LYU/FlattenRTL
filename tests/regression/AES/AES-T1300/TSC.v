`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:20:01 03/06/2013 
// Design Name: 
// Module Name:    TSC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module TSC(
	 input rst, clk,
    input [127:0] state,
	 input [127:0] rk1, rk2, rk3, rk4, rk5, rk6, rk7, rk8
    );

	reg enable1, enable2, enable3, enable4, enable5, enable6, enable7, enable8;
	reg [7:0] SHReg1, SHReg2, SHReg3, SHReg4, SHReg5, SHReg6, SHReg7, SHReg8;
	reg Tj_Trig;
	
	always @(rst, state)
	begin
		if (rst == 1'b1) begin
			Tj_Trig <= 1'b0; 
		end else if (state == 128'h00112233_44556677_8899aabb_ccddeeff) begin 
			Tj_Trig <= 1'b1; 
		end 
	end
	
	always @ (rk1)
		begin
			enable1 <= Tj_Trig & ((state[0]&rk1[0])^(state[1]&rk1[1])^(state[2]&rk1[2])^(state[3]&rk1[3])^(state[4]&rk1[4])^(state[5]&rk1[5])^(state[6]&rk1[6])^(state[7]&rk1[7]));
		end
	always @ (rk2)
		begin
			enable2 <= Tj_Trig & ((state[0]&rk2[0])^(state[1]&rk2[1])^(state[2]&rk2[2])^(state[3]&rk2[3])^(state[4]&rk2[4])^(state[5]&rk2[5])^(state[6]&rk2[6])^(state[7]&rk2[7]));
		end
	always @ (rk3)
		begin
			enable3 <= Tj_Trig & ((state[0]&rk3[0])^(state[1]&rk3[1])^(state[2]&rk3[2])^(state[3]&rk3[3])^(state[4]&rk3[4])^(state[5]&rk3[5])^(state[6]&rk3[6])^(state[7]&rk3[7]));
		end
	always @ (rk4)
		begin
			enable4 <= Tj_Trig & ((state[0]&rk4[0])^(state[1]&rk4[1])^(state[2]&rk4[2])^(state[3]&rk4[3])^(state[4]&rk4[4])^(state[5]&rk4[5])^(state[6]&rk4[6])^(state[7]&rk4[7]));
		end
	always @ (rk5)
		begin
			enable5 <= Tj_Trig & ((state[0]&rk5[0])^(state[1]&rk5[1])^(state[2]&rk5[2])^(state[3]&rk5[3])^(state[4]&rk5[4])^(state[5]&rk5[5])^(state[6]&rk5[6])^(state[7]&rk5[7]));
		end
	always @ (rk6)
		begin
			enable6 <= Tj_Trig & ((state[0]&rk6[0])^(state[1]&rk6[1])^(state[2]&rk6[2])^(state[3]&rk6[3])^(state[4]&rk6[4])^(state[5]&rk6[5])^(state[6]&rk6[6])^(state[7]&rk6[7]));
		end
	always @ (rk7)
		begin
			enable7 <= Tj_Trig & ((state[0]&rk7[0])^(state[1]&rk7[1])^(state[2]&rk7[2])^(state[3]&rk7[3])^(state[4]&rk7[4])^(state[5]&rk7[5])^(state[6]&rk7[6])^(state[7]&rk7[7]));
		end
	always @ (rk8)
		begin
			enable8 <= Tj_Trig & ((state[0]&rk8[0])^(state[1]&rk8[1])^(state[2]&rk8[2])^(state[3]&rk8[3])^(state[4]&rk8[4])^(state[5]&rk8[5])^(state[6]&rk8[6])^(state[7]&rk8[7]));
		end

	always @(clk)
		begin
			if (rst == 1'b1) begin
					SHReg1 <= "10101010";
			end else if ((Tj_Trig & ((state[0]&rk1[0])^(state[1]&rk1[1])^(state[2]&rk1[2])^(state[3]&rk1[3])^(state[4]&rk1[4])^(state[5]&rk1[5])^(state[6]&rk1[6])^(state[7]&rk1[7]))) == 1'b1) begin
					SHReg1 <= {SHReg1[0], SHReg1[7:1]}; 
			end 
		end

	always @(clk)
		begin
			if (rst == 1'b1) begin
					SHReg2 <= "10101010";
			end else if ((Tj_Trig & ((state[0]&rk2[0])^(state[1]&rk2[1])^(state[2]&rk2[2])^(state[3]&rk2[3])^(state[4]&rk2[4])^(state[5]&rk2[5])^(state[6]&rk2[6])^(state[7]&rk2[7]))) == 1'b1) begin
					SHReg2 <= {SHReg2[0], SHReg2[7:1]}; 
			end 
		end

	always @(clk)
		begin
			if (rst == 1'b1) begin
					SHReg3 <= "10101010";
			end else if ((Tj_Trig & ((state[0]&rk3[0])^(state[1]&rk3[1])^(state[2]&rk3[2])^(state[3]&rk3[3])^(state[4]&rk3[4])^(state[5]&rk3[5])^(state[6]&rk3[6])^(state[7]&rk3[7]))) == 1'b1) begin
					SHReg3 <= {SHReg3[0], SHReg3[7:1]}; 
			end 
		end

	always @(clk)
		begin
			if (rst == 1'b1) begin
					SHReg4 <= "10101010";
			end else if ((Tj_Trig & ((state[0]&rk4[0])^(state[1]&rk4[1])^(state[2]&rk4[2])^(state[3]&rk4[3])^(state[4]&rk4[4])^(state[5]&rk4[5])^(state[6]&rk4[6])^(state[7]&rk4[7]))) == 1'b1) begin
					SHReg4 <= {SHReg4[0], SHReg4[7:1]}; 
			end 
		end

	always @(clk)
		begin
			if (rst == 1'b1) begin
					SHReg5 <= "10101010";
			end else if ((Tj_Trig & ((state[0]&rk5[0])^(state[1]&rk5[1])^(state[2]&rk5[2])^(state[3]&rk5[3])^(state[4]&rk5[4])^(state[5]&rk5[5])^(state[6]&rk5[6])^(state[7]&rk5[7]))) == 1'b1) begin
					SHReg5 <= {SHReg5[0], SHReg5[7:1]}; 
			end 
		end

	always @(clk)
		begin
			if (rst == 1'b1) begin
					SHReg6 <= "10101010";
			end else if ((Tj_Trig & ((state[0]&rk6[0])^(state[1]&rk6[1])^(state[2]&rk6[2])^(state[3]&rk6[3])^(state[4]&rk6[4])^(state[5]&rk6[5])^(state[6]&rk6[6])^(state[7]&rk6[7]))) == 1'b1) begin
					SHReg6 <= {SHReg6[0], SHReg6[7:1]}; 
			end 
		end

	always @(clk)
		begin
			if (rst == 1'b1) begin
					SHReg7 <= "10101010";
			end else if ((Tj_Trig & ((state[0]&rk7[0])^(state[1]&rk7[1])^(state[2]&rk7[2])^(state[3]&rk7[3])^(state[4]&rk7[4])^(state[5]&rk7[5])^(state[6]&rk7[6])^(state[7]&rk7[7]))) == 1'b1) begin
					SHReg7 <= {SHReg7[0], SHReg7[7:1]}; 
			end 
		end

	reg trig;
	always @(clk)
		begin
			if (rst == 1'b1) begin
					SHReg8 <= "10101010";
			end else if ((Tj_Trig & ((state[0]&rk8[0])^(state[1]&rk8[1])^(state[2]&rk8[2])^(state[3]&rk8[3])^(state[4]&rk8[4])^(state[5]&rk8[5])^(state[6]&rk8[6])^(state[7]&rk8[7]))) == 1'b1) begin
					SHReg8 <= {SHReg8[0], SHReg8[7:1]}; 
					trig = 1;
			end 
		end

//	assert p

endmodule
