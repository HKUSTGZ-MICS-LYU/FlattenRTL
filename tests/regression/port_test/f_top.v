module top(input x);
    reg a, b;
    wire c;

    wire u1___a;
    wire u1___b;
    wire u1___c;
    wire u1___d;
    wire u2___a;
    wire u2___b;
    wire u2___c;
    wire u2___d;

    assign  u1___c = u1___a & u1___b ; 
  assign  u1___d = u1___a | u1___b ;
    assign  u2___c = u2___a & u2___b ; 
  assign  u2___d = u2___a | u2___b ;
    assign u1___a = a;
    assign u1___b = b;
    assign c = u1___c;
    assign u2___a = a;
    assign u2___b = b;
    assign c = u2___d;
    

endmodule