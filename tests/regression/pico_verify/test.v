
// Dual-Ported BRAM (WRITE FIRST)
module BRAM2(CLKA,
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

   parameter                      PIPELINED  = 0;
   parameter                      ADDR_WIDTH = 1;
   parameter                      DATA_WIDTH = 1;
   parameter                      MEMSIZE    = 1;

   input                          CLKA;
   input                          ENA;
   input                          WEA;
   input [ADDR_WIDTH-1:0]         ADDRA;
   input [DATA_WIDTH-1:0]         DIA;
   output [DATA_WIDTH-1:0]        DOA;

   input                          CLKB;
   input                          ENB;
   input                          WEB;
   input [ADDR_WIDTH-1:0]         ADDRB;
   input [DATA_WIDTH-1:0]         DIB;
   output [DATA_WIDTH-1:0]        DOB;

   reg [DATA_WIDTH-1:0]           RAM[0:MEMSIZE-1] /* synthesis syn_ramstyle="no_rw_check" */ ;
   reg [DATA_WIDTH-1:0]           DOA_R;
   reg [DATA_WIDTH-1:0]           DOB_R;
   reg [DATA_WIDTH-1:0]           DOA_R2;
   reg [DATA_WIDTH-1:0]           DOB_R2;

`ifdef BSV_NO_INITIAL_BLOCKS
`else
   // synopsys translate_off
   integer                        i;
   initial
   begin : init_block
      for (i = 0; i < MEMSIZE; i = i + 1) begin
         RAM[i] = { ((DATA_WIDTH+1)/2) { 2'b10 } };
      end
      DOA_R = { ((DATA_WIDTH+1)/2) { 2'b10 } };
      DOB_R = { ((DATA_WIDTH+1)/2) { 2'b10 } };
      DOA_R2 = { ((DATA_WIDTH+1)/2) { 2'b10 } };
      DOB_R2 = { ((DATA_WIDTH+1)/2) { 2'b10 } };
   end
   // synopsys translate_on
`endif // !`ifdef BSV_NO_INITIAL_BLOCKS

   always @(posedge CLKA) begin
      if (ENA) begin
         if (WEA) begin
            RAM[ADDRA] <= `BSV_ASSIGNMENT_DELAY DIA;
            DOA_R <= `BSV_ASSIGNMENT_DELAY DIA;
         end
         else begin
            DOA_R <= `BSV_ASSIGNMENT_DELAY RAM[ADDRA];
         end
      end
      DOA_R2 <= `BSV_ASSIGNMENT_DELAY DOA_R;
   end

   always @(posedge CLKB) begin
      if (ENB) begin
         if (WEB) begin
            RAM[ADDRB] <= `BSV_ASSIGNMENT_DELAY DIB;
            DOB_R <= `BSV_ASSIGNMENT_DELAY DIB;
         end
         else begin
            DOB_R <= `BSV_ASSIGNMENT_DELAY RAM[ADDRB];
         end
      end
      DOB_R2 <= `BSV_ASSIGNMENT_DELAY DOB_R;
   end

   // Output drivers
   assign DOA = (PIPELINED) ? DOA_R2 : DOA_R;
   assign DOB = (PIPELINED) ? DOB_R2 : DOB_R;

endmodule // BRAM2

// Dual-Ported BRAM (WRITE FIRST)
module BRAM2 #(parameter                      PIPELINED  = 0,
   parameter                      ADDR_WIDTH = 1,
   parameter                      DATA_WIDTH = 1,
   parameter                      MEMSIZE    = 1)(CLKA,
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

   input                          CLKA;
   input                          ENA;
   input                          WEA;
   input [ADDR_WIDTH-1:0]         ADDRA;
   input [DATA_WIDTH-1:0]         DIA;
   output [DATA_WIDTH-1:0]        DOA;

   input                          CLKB;
   input                          ENB;
   input                          WEB;
   input [ADDR_WIDTH-1:0]         ADDRB;
   input [DATA_WIDTH-1:0]         DIB;
   output [DATA_WIDTH-1:0]        DOB;

   // reg [DATA_WIDTH-1:0]           RAM[0:MEMSIZE-1] /* synthesis syn_ramstyle="no_rw_check" */ ;
   reg [DATA_WIDTH-1:0]           DOA_R;
   reg [DATA_WIDTH-1:0]           DOB_R;
   reg [DATA_WIDTH-1:0]           DOA_R2;
   reg [DATA_WIDTH-1:0]           DOB_R2;

   (* keep *)wire [DATA_WIDTH-1:0]  arb1;
   (* keep *)wire [DATA_WIDTH-1:0]  arb2;

`ifdef BSV_NO_INITIAL_BLOCKS
`else
   // synopsys translate_off
   integer                        i;
   initial
   begin : init_block
      //for (i = 0; i < MEMSIZE; i = i + 1) begin
      //   RAM[i] = { ((DATA_WIDTH+1)/2) { 2'b10 } };
      //end
      DOA_R = { ((DATA_WIDTH+1)/2) { 2'b10 } };
      DOB_R = { ((DATA_WIDTH+1)/2) { 2'b10 } };
      DOA_R2 = { ((DATA_WIDTH+1)/2) { 2'b10 } };
      DOB_R2 = { ((DATA_WIDTH+1)/2) { 2'b10 } };
   end
   // synopsys translate_on
`endif // !`ifdef BSV_NO_INITIAL_BLOCKS

   always @(posedge CLKA) begin
      if (ENA) begin
         if (WEA) begin
            // RAM[ADDRA] <=  DIA;
            DOA_R <=  DIA;
         end
         else begin
            DOA_R <= arb1; // RAM[ADDRA];
         end
      end
      DOA_R2 <=  DOA_R;
   end

   always @(posedge CLKB) begin
      if (ENB) begin
         if (WEB) begin
            // RAM[ADDRB] <=  DIB;
            DOB_R <=  DIB;
         end
         else begin
            DOB_R <= arb2; //  RAM[ADDRB];
         end
      end
      DOB_R2 <=  DOB_R;
   end

   // Output drivers
   assign DOA = (PIPELINED) ? DOA_R2 : DOA_R;
   assign DOB = (PIPELINED) ? DOB_R2 : DOB_R;

endmodule // BRAM2

module top(input A);
  // submodule ram_cword_set
  BRAM2 #(.PIPELINED(1'd0),
	  .ADDR_WIDTH(32'd9),
	  .DATA_WIDTH(32'd128),
	  .MEMSIZE(10'd512)) ram_cword_set(.CLKA(CLK),
					   .CLKB(CLK),
					   .ADDRA(ram_cword_set$ADDRA),
					   .ADDRB(ram_cword_set$ADDRB),
					   .DIA(ram_cword_set$DIA),
					   .DIB(ram_cword_set$DIB),
					   .WEA(ram_cword_set$WEA),
					   .WEB(ram_cword_set$WEB),
					   .ENA(ram_cword_set$ENA),
					   .ENB(ram_cword_set$ENB),
					   .DOA(),
					   .DOB(ram_cword_set$DOB));

  // submodule ram_state_and_ctag_cset
  BRAM2 #(.PIPELINED(1'd0),
	  .ADDR_WIDTH(32'd6),
	  .DATA_WIDTH(32'd42),
	  .MEMSIZE(7'd64)) ram_state_and_ctag_cset(.CLKA(CLK),
						   .CLKB(CLK),
						   .ADDRA(ram_state_and_ctag_cset$ADDRA),
						   .ADDRB(ram_state_and_ctag_cset$ADDRB),
						   .DIA(ram_state_and_ctag_cset$DIA),
						   .DIB(ram_state_and_ctag_cset$DIB),
						   .WEA(ram_state_and_ctag_cset$WEA),
						   .WEB(ram_state_and_ctag_cset$WEB),
						   .ENA(ram_state_and_ctag_cset$ENA),
						   .ENB(ram_state_and_ctag_cset$ENB),
						   .DOA(),
						   .DOB(ram_state_and_ctag_cset$DOB));
endmodule
;
