// 子模块1: 一个简单的加法器模块
module adder (
    input  wire [3:0] a,  // 4位输入 a
    input  wire [3:0] b,  // 4位输入 b
    output wire [4:0] sum // 5位输出 sum (因为需要考虑进位)
);
    assign sum = a + b; // 实现加法
endmodule

// 子模块2: 一个简单的乘法器模块
module multiplier (
    input  wire [3:0] a,  // 4位输入 a
    input  wire [3:0] b,  // 4位输入 b
    output wire [7:0] product // 8位输出 product
);
    assign product = a * b; // 实现乘法
endmodule

// 顶层模块: 实例化 adder 和 multiplier
module top_module (
    input  wire [3:0] in1,  // 4位输入 in1
    input  wire [3:0] in2,  // 4位输入 in2
    output wire [4:0] sum_out,  // 加法结果输出
    output wire [7:0] product_out // 乘法结果输出
);
    // 实例化 adder 模块
    adder u_adder (
        .a(in1),        // 连接 in1 到加法器输入
        .b(in2),        // 连接 in2 到加法器输入
        .sum(sum_out)   // 加法器的输出连接到顶层输出
    );

    // 实例化 multiplier 模块
    multiplier u_multiplier (
        .a(in1),        // 连接 in1 到乘法器输入
        .b(in2),        // 连接 in2 到乘法器输入
        .product(product_out) // 乘法器的输出连接到顶层输出
    );
endmodule