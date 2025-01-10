module top #(
    parameter btb_bramcore2___PIPELINED=1'd0,
    parameter btb_bramcore2___ADDR_WIDTH=32'd9,
    parameter btb_bramcore2___DATA_WIDTH=32'd54,
    parameter btb_bramcore2___MEMSIZE=10'd512) (A);
	input A;
  
    // INSTANCE: [btb_bramcore2]
    wire btb_bramcore2___CLKA;
    wire btb_bramcore2___ENA;
    wire btb_bramcore2___WEA;
    wire[btb_bramcore2___ADDR_WIDTH-1:0] btb_bramcore2___ADDRA;
    wire[btb_bramcore2___DATA_WIDTH-1:0] btb_bramcore2___DIA;
    wire btb_bramcore2___DOA;
    wire btb_bramcore2___CLKB;
    wire btb_bramcore2___ENB;
    wire btb_bramcore2___WEB;
    wire[btb_bramcore2___ADDR_WIDTH-1:0] btb_bramcore2___ADDRB;
    wire[btb_bramcore2___DATA_WIDTH-1:0] btb_bramcore2___DIB;
    wire btb_bramcore2___DOB;
    assign btb_bramcore2___CLKA = CLK;
    assign btb_bramcore2___ENA = btb_bramcore2$ENA;
    assign btb_bramcore2___WEA = btb_bramcore2$WEA;
    assign btb_bramcore2___ADDRA = btb_bramcore2$ADDRA;
    assign btb_bramcore2___DIA = btb_bramcore2$DIA;
    assign btb_bramcore2$DOA = btb_bramcore2___DOA;
    assign btb_bramcore2___CLKB = CLK;
    assign btb_bramcore2___ENB = btb_bramcore2$ENB;
    assign btb_bramcore2___WEB = btb_bramcore2$WEB;
    assign btb_bramcore2___ADDRB = btb_bramcore2$ADDRB;
    assign btb_bramcore2___DIB = btb_bramcore2$DIB;

    reg[ btb_bramcore2___DATA_WIDTH -1:0] btb_bramcore2___RAM [0: btb_bramcore2___MEMSIZE -1]; reg[ btb_bramcore2___DATA_WIDTH -1:0] btb_bramcore2___DOA_R ; reg[ btb_bramcore2___DATA_WIDTH -1:0] btb_bramcore2___DOB_R ; reg[ btb_bramcore2___DATA_WIDTH -1:0] btb_bramcore2___DOA_R2 ; reg[ btb_bramcore2___DATA_WIDTH -1:0] btb_bramcore2___DOB_R2 ; 
    integer btb_bramcore2___i ; initial
      begin : btb_bramcore2___init_block for( btb_bramcore2___i =0; btb_bramcore2___i < btb_bramcore2___MEMSIZE ; btb_bramcore2___i = btb_bramcore2___i +1) 
              btb_bramcore2___RAM  [ btb_bramcore2___i ]={( btb_bramcore2___DATA_WIDTH +1)/2{2'b10}}; 
          btb_bramcore2___DOA_R  ={( btb_bramcore2___DATA_WIDTH +1)/2{2'b10}}; 
          btb_bramcore2___DOB_R  ={( btb_bramcore2___DATA_WIDTH +1)/2{2'b10}}; 
          btb_bramcore2___DOA_R2  ={( btb_bramcore2___DATA_WIDTH +1)/2{2'b10}}; 
          btb_bramcore2___DOB_R2  ={( btb_bramcore2___DATA_WIDTH +1)/2{2'b10}};
      end  
  always @( posedge  btb_bramcore2___CLKA )
         begin 
             if ( btb_bramcore2___ENA )
                 begin 
                     if ( btb_bramcore2___WEA )
                         begin  
                             btb_bramcore2___RAM  [ btb_bramcore2___ADDRA ]<= btb_bramcore2___DIA ; 
                             btb_bramcore2___DOA_R  <= btb_bramcore2___DIA ;
                         end 
                      else  
                         btb_bramcore2___DOA_R  <= btb_bramcore2___RAM [ btb_bramcore2___ADDRA ];
                 end  
             btb_bramcore2___DOA_R2  <= btb_bramcore2___DOA_R ;
         end
  always @( posedge  btb_bramcore2___CLKB )
         begin 
             if ( btb_bramcore2___ENB )
                 begin 
                     if ( btb_bramcore2___WEB )
                         begin  
                             btb_bramcore2___RAM  [ btb_bramcore2___ADDRB ]<= btb_bramcore2___DIB ; 
                             btb_bramcore2___DOB_R  <= btb_bramcore2___DIB ;
                         end 
                      else  
                         btb_bramcore2___DOB_R  <= btb_bramcore2___RAM [ btb_bramcore2___ADDRB ];
                 end  
             btb_bramcore2___DOB_R2  <= btb_bramcore2___DOB_R ;
         end
  assign  btb_bramcore2___DOA =( btb_bramcore2___PIPELINED  ?  btb_bramcore2___DOA_R2 : btb_bramcore2___DOA_R ); 
  assign  btb_bramcore2___DOB =( btb_bramcore2___PIPELINED  ?  btb_bramcore2___DOB_R2 : btb_bramcore2___DOB_R );
    


endmodule