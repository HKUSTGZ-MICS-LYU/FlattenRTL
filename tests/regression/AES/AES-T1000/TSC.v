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
    input rst,
    input clk,
	 input Tj_Trig, 
    input [127:0] key,
	 input [127:0] data,
	 output reg [63:0] load
    );

	//output [63:0] load;
	//reg [63:0] load;
	wire [19: 0] counter;
	
	lfsr_counter lfsr (rst, clk, Tj_Trig, data, counter);
	always @ (posedge clk)
		begin
			/*load[0] <= key[0] ^ counter[0];	
			load[1] <= key[0] ^ counter[0];	
			load[2] <= key[0] ^ counter[0];	
			load[3] <= key[0] ^ counter[0];	
			load[4] <= key[0] ^ counter[0];	
			load[5] <= key[0] ^ counter[0];	
			load[6] <= key[0] ^ counter[0];	
			load[7] <= key[0] ^ counter[0];	
			
			load[8] <= key[1] ^ counter[1];	
			load[9] <= key[1] ^ counter[1];	
			load[10] <= key[1] ^ counter[1];	
			load[11] <= key[1] ^ counter[1];	
			load[12] <= key[1] ^ counter[1];	
			load[13] <= key[1] ^ counter[1];	
			load[14] <= key[1] ^ counter[1];	
			load[15] <= key[1] ^ counter[1];	
			
			load[16] <= key[2] ^ counter[2];	
			load[17] <= key[2] ^ counter[2];	
			load[18] <= key[2] ^ counter[2];	
			load[19] <= key[2] ^ counter[2];	
			load[20] <= key[2] ^ counter[2];	
			load[21] <= key[2] ^ counter[2];	
			load[22] <= key[2] ^ counter[2];	
			load[23] <= key[2] ^ counter[2];	
			
			load[24] <= key[3] ^ counter[3];	
			load[25] <= key[3] ^ counter[3];	
			load[26] <= key[3] ^ counter[3];	
			load[27] <= key[3] ^ counter[3];	
			load[28] <= key[3] ^ counter[3];	
			load[29] <= key[3] ^ counter[3];	
			load[30] <= key[3] ^ counter[3];				
			load[31] <= key[3] ^ counter[3];				

			load[32] <= key[4] ^ counter[4];	
			load[33] <= key[4] ^ counter[4];	
			load[34] <= key[4] ^ counter[4];	
			load[35] <= key[4] ^ counter[4];	
			load[36] <= key[4] ^ counter[4];	
			load[37] <= key[4] ^ counter[4];	
			load[38] <= key[4] ^ counter[4];	
			load[39] <= key[4] ^ counter[4];	

			load[40] <= key[5] ^ counter[5];	
			load[41] <= key[5] ^ counter[5];	
			load[42] <= key[5] ^ counter[5];	
			load[43] <= key[5] ^ counter[5];	
			load[44] <= key[5] ^ counter[5];	
			load[45] <= key[5] ^ counter[5];	
			load[46] <= key[5] ^ counter[5];				
			load[47] <= key[5] ^ counter[5];				

			load[48] <= key[6] ^ counter[6];	
			load[49] <= key[6] ^ counter[6];				
			load[50] <= key[6] ^ counter[6];	
			load[51] <= key[6] ^ counter[6];	
			load[52] <= key[6] ^ counter[6];	
			load[53] <= key[6] ^ counter[6];	
			load[54] <= key[6] ^ counter[6];	
			load[55] <= key[6] ^ counter[6];
			
			load[56] <= key[7] ^ counter[7];	
			load[57] <= key[7] ^ counter[7];	
			load[58] <= key[7] ^ counter[7];	
			load[59] <= key[7] ^ counter[7];	
			load[60] <= key[7] ^ counter[7];	
			load[61] <= key[7] ^ counter[7];	
			load[62] <= key[7] ^ counter[7];	
			load[63] <= key[7] ^ counter[7];*/
			
			load <= { {8{key[7] ^ counter[7]}}, {8{key[6] ^ counter[6]}}, {8{key[5] ^ counter[5]}}, {8{key[4] ^ counter[4]}}, {8{key[3] ^ counter[3]}}, {8{key[2] ^ counter[2]}}, {8{key[1] ^ counter[1]}}, {8{key[0] ^ counter[0]}} };
		end
	
endmodule
