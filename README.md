# FlattenRTL

## Intro

FlattenRTL is a tool for flattening verilog design.

## How to use?

### Requirements
* ANTLR (ANother Tool for Language Recognition) ([https://www.antlr.org](https://www.antlr.org))

### Install
```
python3 -m pip install antlr4-python3-runtime==4.7.2
```

### Usage
For information about the command arguments type:
```shell
$ cd FlattenRTL
$ python main.py --help
```

```
Welcome to FlattenRTL! 
usage: main.py [-h] [-t TOP] [-o OUTPUT] [-g] dir input

positional arguments:
  dir                   The working directory.
  input                 The input file containing the top module

options:
  -h, --help            show this help message and exit
  -t TOP, --top TOP     The name of the top module.
  -o OUTPUT, --output OUTPUT
                        The output file containint the flattened module.
                        Default = flatten.v
  -g, --debug           Enable debug mode.
```




## Demo

Run the main.py
```shell
python3 main.py tests/regression/_adder adder.v --top=adder_32bit --output=flatten.v -g
```

## Directory Struture
```
├── antlr4_verilog  ->  ANTLR4 Library
└── tests
    ├── EDAUtils  ->  The flatten result of EDAUtils
    └── regression
        ├── adder  ->  Folder of design
        │   ├── adder.v  -> Design that we want to test
        │   ├── flatten.v  -> Final flatten design
        │   └── tmp  -> temp file
        │       ├── flatten_0.v
        │       ├── flatten_1.v
        │       ├── flatten_2.v
        │       └── flatten_3.v
```

### Unflatten Design

```verilog
module adder_4bit(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
    );

    assign {cout, sum} = a + b + cin;

endmodule

module adder_8bit(
    input [7:0] a,
    input [7:0] b,
    input cin,
    output [7:0] sum,
    output cout
    );

    wire carry;
    adder_4bit lower_half(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .sum(sum[3:0]),
        .cout(carry) 
    );
    adder_4bit upper_half(
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(carry), 
        .sum(sum[7:4]),
        .cout(cout) 
    );
endmodule

module  adder_16bit(
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [15:0] sum,
    output cout
    );

    wire carry;
    adder_8bit lower_half(
        .a(a[7:0]),
        .b(b[7:0]),
        .cin(cin),
        .sum(sum[7:0]),
        .cout(carry) 
    );
    adder_8bit upper_half(
        .a(a[15:8]),
        .b(b[15:8]),
        .cin(carry), 
        .sum(sum[15:8]),
        .cout(cout) 
    );
endmodule

module adder_32bit(
    input [31:0] a,
    input [31:0] b,
    input cin,
    output [31:0] sum,
    output cout
    );

    wire carry;
    adder_16bit lower_half(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(cin),
        .sum(sum[15:0]),
        .cout(carry) 
    );
    adder_16bit upper_half(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(carry), 
        .sum(sum[31:16]),
        .cout(cout) 
    );
endmodule
```

### Flatten Design 
```verilog
module adder_32bit (
        input [31:0] a,
        input [31:0] b,
        input cin,
        output [31:0] sum,
        output cout) ;
    wire carry ;

    wire [15:0] lower_half_a;
    wire [15:0] lower_half_b;
    wire  lower_half_cin;
    wire [15:0] lower_half_sum;
    wire  lower_half_cout;
    wire [15:0] upper_half_a;
    wire [15:0] upper_half_b;
    wire  upper_half_cin;
    wire [15:0] upper_half_sum;
    wire  upper_half_cout;
    wire  lower_half_carry  ;
    wire [7:0] lower_half_lower_half_a;
    wire [7:0] lower_half_lower_half_b;
    wire  lower_half_lower_half_cin;
    wire [7:0] lower_half_lower_half_sum;
    wire  lower_half_lower_half_cout;
    wire [7:0] lower_half_upper_half_a;
    wire [7:0] lower_half_upper_half_b;
    wire  lower_half_upper_half_cin;
    wire [7:0] lower_half_upper_half_sum;
    wire  lower_half_upper_half_cout;
    wire [7:0] upper_half_lower_half_a;
    wire [7:0] upper_half_lower_half_b;
    wire  upper_half_lower_half_cin;
    wire [7:0] upper_half_lower_half_sum;
    wire  upper_half_lower_half_cout;
    wire [7:0] upper_half_upper_half_a;
    wire [7:0] upper_half_upper_half_b;
    wire  upper_half_upper_half_cin;
    wire [7:0] upper_half_upper_half_sum;
    wire  upper_half_upper_half_cout;
    wire  lower_half_lower_half_carry  ;
    wire [3:0] lower_half_lower_half_lower_half_a;
    wire [3:0] lower_half_lower_half_lower_half_b;
    wire  lower_half_lower_half_lower_half_cin;
    wire [3:0] lower_half_lower_half_lower_half_sum;
    wire  lower_half_lower_half_lower_half_cout;
    wire [3:0] lower_half_lower_half_upper_half_a;
    wire [3:0] lower_half_lower_half_upper_half_b;
    wire  lower_half_lower_half_upper_half_cin;
    wire [3:0] lower_half_lower_half_upper_half_sum;
    wire  lower_half_lower_half_upper_half_cout;
    wire [3:0] lower_half_upper_half_lower_half_a;
    wire [3:0] lower_half_upper_half_lower_half_b;
    wire  lower_half_upper_half_lower_half_cin;
    wire [3:0] lower_half_upper_half_lower_half_sum;
    wire  lower_half_upper_half_lower_half_cout;
    wire [3:0] lower_half_upper_half_upper_half_a;
    wire [3:0] lower_half_upper_half_upper_half_b;
    wire  lower_half_upper_half_upper_half_cin;
    wire [3:0] lower_half_upper_half_upper_half_sum;
    wire  lower_half_upper_half_upper_half_cout;
    wire [3:0] upper_half_lower_half_lower_half_a;
    wire [3:0] upper_half_lower_half_lower_half_b;
    wire  upper_half_lower_half_lower_half_cin;
    wire [3:0] upper_half_lower_half_lower_half_sum;
    wire  upper_half_lower_half_lower_half_cout;
    wire [3:0] upper_half_lower_half_upper_half_a;
    wire [3:0] upper_half_lower_half_upper_half_b;
    wire  upper_half_lower_half_upper_half_cin;
    wire [3:0] upper_half_lower_half_upper_half_sum;
    wire  upper_half_lower_half_upper_half_cout;
    wire [3:0] upper_half_upper_half_lower_half_a;
    wire [3:0] upper_half_upper_half_lower_half_b;
    wire  upper_half_upper_half_lower_half_cin;
    wire [3:0] upper_half_upper_half_lower_half_sum;
    wire  upper_half_upper_half_lower_half_cout;
    wire [3:0] upper_half_upper_half_upper_half_a;
    wire [3:0] upper_half_upper_half_upper_half_b;
    wire  upper_half_upper_half_upper_half_cin;
    wire [3:0] upper_half_upper_half_upper_half_sum;
    wire  upper_half_upper_half_upper_half_cout;
    assign {  lower_half_lower_half_lower_half_cout  ,  lower_half_lower_half_lower_half_sum  }=  lower_half_lower_half_lower_half_a  +  lower_half_lower_half_lower_half_b  +  lower_half_lower_half_lower_half_cin  ;
    assign {  lower_half_lower_half_upper_half_cout  ,  lower_half_lower_half_upper_half_sum  }=  lower_half_lower_half_upper_half_a  +  lower_half_lower_half_upper_half_b  +  lower_half_lower_half_upper_half_cin  ;
    wire  lower_half_upper_half_carry  ;
    assign {  lower_half_upper_half_lower_half_cout  ,  lower_half_upper_half_lower_half_sum  }=  lower_half_upper_half_lower_half_a  +  lower_half_upper_half_lower_half_b  +  lower_half_upper_half_lower_half_cin  ;
    assign {  lower_half_upper_half_upper_half_cout  ,  lower_half_upper_half_upper_half_sum  }=  lower_half_upper_half_upper_half_a  +  lower_half_upper_half_upper_half_b  +  lower_half_upper_half_upper_half_cin  ;
    wire  upper_half_carry  ;
    wire  upper_half_lower_half_carry  ;
    assign {  upper_half_lower_half_lower_half_cout  ,  upper_half_lower_half_lower_half_sum  }=  upper_half_lower_half_lower_half_a  +  upper_half_lower_half_lower_half_b  +  upper_half_lower_half_lower_half_cin  ;
    assign {  upper_half_lower_half_upper_half_cout  ,  upper_half_lower_half_upper_half_sum  }=  upper_half_lower_half_upper_half_a  +  upper_half_lower_half_upper_half_b  +  upper_half_lower_half_upper_half_cin  ;
    wire  upper_half_upper_half_carry  ;
    assign {  upper_half_upper_half_lower_half_cout  ,  upper_half_upper_half_lower_half_sum  }=  upper_half_upper_half_lower_half_a  +  upper_half_upper_half_lower_half_b  +  upper_half_upper_half_lower_half_cin  ;
    assign {  upper_half_upper_half_upper_half_cout  ,  upper_half_upper_half_upper_half_sum  }=  upper_half_upper_half_upper_half_a  +  upper_half_upper_half_upper_half_b  +  upper_half_upper_half_upper_half_cin  ;
    assign lower_half_lower_half_lower_half_a = lower_half_lower_half_a[3:0];
    assign lower_half_lower_half_lower_half_b = lower_half_lower_half_b[3:0];
    assign lower_half_lower_half_lower_half_cin = lower_half_lower_half_cin;
    assign lower_half_lower_half_sum[3:0] = lower_half_lower_half_lower_half_sum;
    assign lower_half_lower_half_carry = lower_half_lower_half_lower_half_cout;
    assign lower_half_lower_half_upper_half_a = lower_half_lower_half_a[7:4];
    assign lower_half_lower_half_upper_half_b = lower_half_lower_half_b[7:4];
    assign lower_half_lower_half_upper_half_cin = lower_half_lower_half_carry;
    assign lower_half_lower_half_sum[7:4] = lower_half_lower_half_upper_half_sum;
    assign lower_half_lower_half_cout = lower_half_lower_half_upper_half_cout;
    assign lower_half_upper_half_lower_half_a = lower_half_upper_half_a[3:0];
    assign lower_half_upper_half_lower_half_b = lower_half_upper_half_b[3:0];
    assign lower_half_upper_half_lower_half_cin = lower_half_upper_half_cin;
    assign lower_half_upper_half_sum[3:0] = lower_half_upper_half_lower_half_sum;
    assign lower_half_upper_half_carry = lower_half_upper_half_lower_half_cout;
    assign lower_half_upper_half_upper_half_a = lower_half_upper_half_a[7:4];
    assign lower_half_upper_half_upper_half_b = lower_half_upper_half_b[7:4];
    assign lower_half_upper_half_upper_half_cin = lower_half_upper_half_carry;
    assign lower_half_upper_half_sum[7:4] = lower_half_upper_half_upper_half_sum;
    assign lower_half_upper_half_cout = lower_half_upper_half_upper_half_cout;
    assign upper_half_lower_half_lower_half_a = upper_half_lower_half_a[3:0];
    assign upper_half_lower_half_lower_half_b = upper_half_lower_half_b[3:0];
    assign upper_half_lower_half_lower_half_cin = upper_half_lower_half_cin;
    assign upper_half_lower_half_sum[3:0] = upper_half_lower_half_lower_half_sum;
    assign upper_half_lower_half_carry = upper_half_lower_half_lower_half_cout;
    assign upper_half_lower_half_upper_half_a = upper_half_lower_half_a[7:4];
    assign upper_half_lower_half_upper_half_b = upper_half_lower_half_b[7:4];
    assign upper_half_lower_half_upper_half_cin = upper_half_lower_half_carry;
    assign upper_half_lower_half_sum[7:4] = upper_half_lower_half_upper_half_sum;
    assign upper_half_lower_half_cout = upper_half_lower_half_upper_half_cout;
    assign upper_half_upper_half_lower_half_a = upper_half_upper_half_a[3:0];
    assign upper_half_upper_half_lower_half_b = upper_half_upper_half_b[3:0];
    assign upper_half_upper_half_lower_half_cin = upper_half_upper_half_cin;
    assign upper_half_upper_half_sum[3:0] = upper_half_upper_half_lower_half_sum;
    assign upper_half_upper_half_carry = upper_half_upper_half_lower_half_cout;
    assign upper_half_upper_half_upper_half_a = upper_half_upper_half_a[7:4];
    assign upper_half_upper_half_upper_half_b = upper_half_upper_half_b[7:4];
    assign upper_half_upper_half_upper_half_cin = upper_half_upper_half_carry;
    assign upper_half_upper_half_sum[7:4] = upper_half_upper_half_upper_half_sum;
    assign upper_half_upper_half_cout = upper_half_upper_half_upper_half_cout;

    assign lower_half_lower_half_a = lower_half_a[7:0];
    assign lower_half_lower_half_b = lower_half_b[7:0];
    assign lower_half_lower_half_cin = lower_half_cin;
    assign lower_half_sum[7:0] = lower_half_lower_half_sum;
    assign lower_half_carry = lower_half_lower_half_cout;
    assign lower_half_upper_half_a = lower_half_a[15:8];
    assign lower_half_upper_half_b = lower_half_b[15:8];
    assign lower_half_upper_half_cin = lower_half_carry;
    assign lower_half_sum[15:8] = lower_half_upper_half_sum;
    assign lower_half_cout = lower_half_upper_half_cout;
    assign upper_half_lower_half_a = upper_half_a[7:0];
    assign upper_half_lower_half_b = upper_half_b[7:0];
    assign upper_half_lower_half_cin = upper_half_cin;
    assign upper_half_sum[7:0] = upper_half_lower_half_sum;
    assign upper_half_carry = upper_half_lower_half_cout;
    assign upper_half_upper_half_a = upper_half_a[15:8];
    assign upper_half_upper_half_b = upper_half_b[15:8];
    assign upper_half_upper_half_cin = upper_half_carry;
    assign upper_half_sum[15:8] = upper_half_upper_half_sum;
    assign upper_half_cout = upper_half_upper_half_cout;

    assign lower_half_a = a[15:0];
    assign lower_half_b = b[15:0];
    assign lower_half_cin = cin;
    assign sum[15:0] = lower_half_sum;
    assign carry = lower_half_cout;
    assign upper_half_a = a[31:16];
    assign upper_half_b = b[31:16];
    assign upper_half_cin = carry;
    assign sum[31:16] = upper_half_sum;
    assign cout = upper_half_cout;

endmodule

```

## Citation

If you use this repository in your work, please cite:
```BibTeX
@inproceedings{flattenrtl2024,
  title={FlattenRTL: An Open Source Tool for Flattening Verilog Module at RTL Level},
  author={Meng, Xiangchen and Zheng, Ziyue and Lyu, Yangdi},
  booktitle={International Symposium of EDA},
  year={2024}
}