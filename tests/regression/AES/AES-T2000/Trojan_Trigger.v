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

	reg State0, State1, State2, State3; 
//	reg Tj_Trig;
	
	always @(rst, state)
	begin
		if (rst == 1'b1) begin
			State0 <= 1'b0;
			State1 <= 1'b0;
			State2 <= 1'b0;
			State3 <= 1'b0; 
		end else if (state == 128'h3243f6a8_885a308d_313198a2_e0370734) begin
			State0 <= 1'b1;
		end else if ((state == 128'h00112233_44556677_8899aabb_ccddeeff) && (State0 == 1'b1)) begin
			State1 <= 1'b1;
		end else if ((state == 128'h0) && (State1 == 1'b1)) begin
			State2 <= 1'b1;
		end else if ((state == 128'h1) && (State2 == 1'b1)) begin
			State3 <= 1'b1;
		end
	end

	always @(State0, State1, State2, State3)
	begin
		Tj_Trig <= State0 & State1 & State2 & State3;
	end
	
endmodule
