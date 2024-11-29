/*
 * Copyright 2012, Homer Hsing <homer.hsing@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module aes_128(clk, key, out);
    input          clk;
    input  [127:0] key;
    output [127:0] out;
    wire   [127:0] k0, s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19,
    				s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s32, s33, s34;

    assign s0 = 128'hc2f45dfa_8acd3f4d_a3dcfe8a_93cefa0a;
	assign k0 = key ^ s0;
	
    one_round
        r1 (clk, s0, k0, s1),
        r2 (clk, s0, s1, s2),
        r3 (clk, s0, s2, s3),
        r4 (clk, s0, s3, s4),
        r5 (clk, s0, s4, s5),
        r6 (clk, s0, s5, s6),
        r7 (clk, s0, s6, s7),
        r8 (clk, s0, s7, s8),
        r9 (clk, s0, s8, s9),
        r10 (clk, s0, s9, s10),
        r11 (clk, s0, s10, s11),
        r12 (clk, s0, s11, s12),
        r13 (clk, s0, s12, s13),
        r14 (clk, s0, s13, s14),
        r15 (clk, s0, s14, s15),
        r16 (clk, s0, s15, s16),
        r17 (clk, s0, s16, s17),
        r18 (clk, s0, s17, s18),
        r19 (clk, s0, s18, s19),
        r20 (clk, s0, s19, s20),
        r21 (clk, s0, s20, s21),
        r22 (clk, s0, s21, s22),
        r23 (clk, s0, s22, s23),
        r24 (clk, s0, s23, s24),
        r25 (clk, s0, s24, s25),
        r26 (clk, s0, s25, s26),
        r27 (clk, s0, s26, s27),
        r28 (clk, s0, s27, s28),
        r29 (clk, s0, s28, s29),
        r30 (clk, s0, s29, s30),
        r31 (clk, s0, s30, s31),
        r32 (clk, s0, s31, s32),
        r33 (clk, s0, s32, s33),
        r34 (clk, s0, s33, s34),
        r35 (clk, s0, s34, out);

endmodule

