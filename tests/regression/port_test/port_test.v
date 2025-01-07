module my_module (
    input wire a,
    input wire b,
    output wire c,
    output wire d
);
    assign c = a & b;
    assign d = a | b;
endmodule

module top(input x);
    reg a, b;
    wire c;

    my_module u1 (
        .a(a),  
        .b(b),   
        .c(c)  
    );
    my_module u2 (
        .a(a),  
        .b(b),   
        .d(c)  
    );

endmodule