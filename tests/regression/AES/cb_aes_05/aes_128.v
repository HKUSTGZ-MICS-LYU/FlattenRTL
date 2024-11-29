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
    wire   [127:0] k0, s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19;

    assign s0 = 128'hc2f45dfa_8acd3f4d_a3dcfe8a_93cefa0a;
	assign k0 = key ^ s0;
	
    one_round
        r1 (clk, s0, k0, s1),
        r2 (clk, s0, s1, s2),
        r3 (clk, s0, s2, s3),
        r4 (clk, s0, s3, s4),
        r5 (clk, s0, s4, out);
endmodule

