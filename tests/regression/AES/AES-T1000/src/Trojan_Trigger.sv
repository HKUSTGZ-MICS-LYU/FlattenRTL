`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:40:39 03/08/2013 
// Design Name: 
// Module Name:    Trojan_Trigger 
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
module Trojan_Trigger(
    input rst,
    input [127:0] state,
    output reg Tj_Trig
    );

//	output reg Tj_Trig;
	//reg Tj_Trig;

	always @(rst, state)
	begin
		if (rst == 1'b1) begin
			Tj_Trig <= 1'b0; 
		end else if (state == 128'h00112233_44556677_8899aabb_ccddeeff) begin 
			Tj_Trig <= 1'b1; 
		end 
	end

	assert property (~((Tj_Trig==1) && (rst==0)));
endmodule
