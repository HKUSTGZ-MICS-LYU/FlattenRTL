module top #(
    parameter ram_state_and_ctag_cset___PIPELINED=1'd0,
    parameter ram_state_and_ctag_cset___ADDR_WIDTH=32'd7,
    parameter ram_state_and_ctag_cset___DATA_WIDTH=32'd23,
    parameter ram_state_and_ctag_cset___MEMSIZE=8'd128,
    parameter ram_word64_set___PIPELINED=1'd0,
    parameter ram_word64_set___ADDR_WIDTH=32'd9,
    parameter ram_word64_set___DATA_WIDTH=32'd64,
    parameter ram_word64_set___MEMSIZE=10'd512)(input A);
  wire ram_state_and_ctag_cset___CLKA;
    wire ram_state_and_ctag_cset___ENA;
    wire ram_state_and_ctag_cset___WEA;
    wire[ram_state_and_ctag_cset___ADDR_WIDTH-1:0] ram_state_and_ctag_cset___ADDRA;
    wire[ram_state_and_ctag_cset___DATA_WIDTH-1:0] ram_state_and_ctag_cset___DIA;
    wire[ram_state_and_ctag_cset___DATA_WIDTH-1:0] ram_state_and_ctag_cset___DOA;
    wire ram_state_and_ctag_cset___CLKB;
    wire ram_state_and_ctag_cset___ENB;
    wire ram_state_and_ctag_cset___WEB;
    wire[ram_state_and_ctag_cset___ADDR_WIDTH-1:0] ram_state_and_ctag_cset___ADDRB;
    wire[ram_state_and_ctag_cset___DATA_WIDTH-1:0] ram_state_and_ctag_cset___DIB;
    wire[ram_state_and_ctag_cset___DATA_WIDTH-1:0] ram_state_and_ctag_cset___DOB;
    wire ram_word64_set___CLKA;
    wire ram_word64_set___ENA;
    wire ram_word64_set___WEA;
    wire[ram_word64_set___ADDR_WIDTH-1:0] ram_word64_set___ADDRA;
    wire[ram_word64_set___DATA_WIDTH-1:0] ram_word64_set___DIA;
    wire[ram_word64_set___DATA_WIDTH-1:0] ram_word64_set___DOA;
    wire ram_word64_set___CLKB;
    wire ram_word64_set___ENB;
    wire ram_word64_set___WEB;
    wire[ram_word64_set___ADDR_WIDTH-1:0] ram_word64_set___ADDRB;
    wire[ram_word64_set___DATA_WIDTH-1:0] ram_word64_set___DIB;
    wire[ram_word64_set___DATA_WIDTH-1:0] ram_word64_set___DOB;

    reg[ ram_state_and_ctag_cset___DATA_WIDTH -1:0] ram_state_and_ctag_cset___DOA_R ; reg[ ram_state_and_ctag_cset___DATA_WIDTH -1:0] ram_state_and_ctag_cset___DOB_R ; reg[ ram_state_and_ctag_cset___DATA_WIDTH -1:0] ram_state_and_ctag_cset___DOA_R2 ; reg[ ram_state_and_ctag_cset___DATA_WIDTH -1:0] ram_state_and_ctag_cset___DOB_R2 ; (* ram_state_and_ctag_cset___keep *)
    wire[ ram_state_and_ctag_cset___DATA_WIDTH -1:0] ram_state_and_ctag_cset___arb1 ; (* ram_state_and_ctag_cset___keep *)
    wire[ ram_state_and_ctag_cset___DATA_WIDTH -1:0] ram_state_and_ctag_cset___arb2 ; 
  always @( posedge  ram_state_and_ctag_cset___CLKA )
         begin 
             if ( ram_state_and_ctag_cset___ENA )
                 begin 
                     if ( ram_state_and_ctag_cset___WEA )
                         begin  
                             ram_state_and_ctag_cset___DOA_R  <= ram_state_and_ctag_cset___DIA ;
                         end 
                      else 
                         begin  
                             ram_state_and_ctag_cset___DOA_R  <= ram_state_and_ctag_cset___arb1 ;
                         end 
                 end  
             ram_state_and_ctag_cset___DOA_R2  <= ram_state_and_ctag_cset___DOA_R ;
         end
  always @( posedge  ram_state_and_ctag_cset___CLKB )
         begin 
             if ( ram_state_and_ctag_cset___ENB )
                 begin 
                     if ( ram_state_and_ctag_cset___WEB )
                         begin  
                             ram_state_and_ctag_cset___DOB_R  <= ram_state_and_ctag_cset___DIB ;
                         end 
                      else 
                         begin  
                             ram_state_and_ctag_cset___DOB_R  <= ram_state_and_ctag_cset___arb2 ;
                         end 
                 end  
             ram_state_and_ctag_cset___DOB_R2  <= ram_state_and_ctag_cset___DOB_R ;
         end
  assign  ram_state_and_ctag_cset___DOA =( ram_state_and_ctag_cset___PIPELINED ) ?  ram_state_and_ctag_cset___DOA_R2 : ram_state_and_ctag_cset___DOA_R ; 
  assign  ram_state_and_ctag_cset___DOB =( ram_state_and_ctag_cset___PIPELINED ) ?  ram_state_and_ctag_cset___DOB_R2 : ram_state_and_ctag_cset___DOB_R ;
    

  // submodule ram_word64_set
  
    reg[ ram_word64_set___DATA_WIDTH -1:0] ram_word64_set___DOA_R ; reg[ ram_word64_set___DATA_WIDTH -1:0] ram_word64_set___DOB_R ; reg[ ram_word64_set___DATA_WIDTH -1:0] ram_word64_set___DOA_R2 ; reg[ ram_word64_set___DATA_WIDTH -1:0] ram_word64_set___DOB_R2 ; (* ram_word64_set___keep *)
    wire[ ram_word64_set___DATA_WIDTH -1:0] ram_word64_set___arb1 ; (* ram_word64_set___keep *)
    wire[ ram_word64_set___DATA_WIDTH -1:0] ram_word64_set___arb2 ; 
  always @( posedge  ram_word64_set___CLKA )
         begin 
             if ( ram_word64_set___ENA )
                 begin 
                     if ( ram_word64_set___WEA )
                         begin  
                             ram_word64_set___DOA_R  <= ram_word64_set___DIA ;
                         end 
                      else 
                         begin  
                             ram_word64_set___DOA_R  <= ram_word64_set___arb1 ;
                         end 
                 end  
             ram_word64_set___DOA_R2  <= ram_word64_set___DOA_R ;
         end
  always @( posedge  ram_word64_set___CLKB )
         begin 
             if ( ram_word64_set___ENB )
                 begin 
                     if ( ram_word64_set___WEB )
                         begin  
                             ram_word64_set___DOB_R  <= ram_word64_set___DIB ;
                         end 
                      else 
                         begin  
                             ram_word64_set___DOB_R  <= ram_word64_set___arb2 ;
                         end 
                 end  
             ram_word64_set___DOB_R2  <= ram_word64_set___DOB_R ;
         end
  assign  ram_word64_set___DOA =( ram_word64_set___PIPELINED ) ?  ram_word64_set___DOA_R2 : ram_word64_set___DOA_R ; 
  assign  ram_word64_set___DOB =( ram_word64_set___PIPELINED ) ?  ram_word64_set___DOB_R2 : ram_word64_set___DOB_R ;
    assign ram_state_and_ctag_cset___CLKA = CLK;
    assign ram_state_and_ctag_cset___ENA = ram_state_and_ctag_cset$ENA;
    assign ram_state_and_ctag_cset___WEA = ram_state_and_ctag_cset$WEA;
    assign ram_state_and_ctag_cset___ADDRA = ram_state_and_ctag_cset$ADDRA;
    assign ram_state_and_ctag_cset___DIA = ram_state_and_ctag_cset$DIA;
    assign ram_state_and_ctag_cset___CLKB = CLK;
    assign ram_state_and_ctag_cset___ENB = ram_state_and_ctag_cset$ENB;
    assign ram_state_and_ctag_cset___WEB = ram_state_and_ctag_cset$WEB;
    assign ram_state_and_ctag_cset___ADDRB = ram_state_and_ctag_cset$ADDRB;
    assign ram_state_and_ctag_cset___DIB = ram_state_and_ctag_cset$DIB;
    assign ram_state_and_ctag_cset$DOB = ram_state_and_ctag_cset___DOB;
    assign ram_word64_set___CLKA = CLK;
    assign ram_word64_set___ENA = ram_word64_set$ENA;
    assign ram_word64_set___WEA = ram_word64_set$WEA;
    assign ram_word64_set___ADDRA = ram_word64_set$ADDRA;
    assign ram_word64_set___DIA = ram_word64_set$DIA;
    assign ram_word64_set___CLKB = CLK;
    assign ram_word64_set___ENB = ram_word64_set$ENB;
    assign ram_word64_set___WEB = ram_word64_set$WEB;
    assign ram_word64_set___ADDRB = ram_word64_set$ADDRB;
    assign ram_word64_set___DIB = ram_word64_set$DIB;
    assign ram_word64_set$DOB = ram_word64_set___DOB;
    
endmodule