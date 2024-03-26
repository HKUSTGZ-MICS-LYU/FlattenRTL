# FlattenRTL

## Intro

FlattenRTL is a tool for flattening verilog design.

## Directory Struture
```
├── antlr4_verilog  ->  ANTLR4 Library
└── tests
    ├── EDAUtils  ->  The flatten result of EDAUtils
    └── regression
        ├── adder  ->  Folder of design
        │   ├── adder.v  -> Design that we want to test
        │   ├── f_adder.v  -> Format design that we want to test
        │   ├── flatten_f_adder.v  -> Final flatten design
        │   └── tmp  -> temp file
        │       ├── adder_0.v
        │       ├── adder_1.v
        │       ├── adder_2.v
        │       ├── adder_3.v
        │       ├── adder_4.v
        │       └── adder_5.v
```

## How to use?

### Install
```
python3 -m pip install antlr4-python3-runtime==4.7.2
```

### Step 1
Open file main.py, set the path and file that you want process.
```python
path = 'tests/regression/AES' # Folder
inputfile = '/top.v' # The file that you want to process
outputfile = '/f_top.v' # Output file
top_module = 'top' # Top module
```

### Step 2
Run the main.py at the root of this directory
```shell
python3 main.py
```


## Demo
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

## Limitations and Features
## Limitations and Features
### Module Declaration

The module declaration should be follow the standard style below without any parameters:

```verilog
module decl(a, b, c);
   input  [2:0] a;
   input  [2:0] b;
   output [2:0] c;
```

Currently we don't support definitions and parameters.

### Port Connection

Ordered port connection, named port connection and no info at the rhs(right hand side) are supported.

```verilog
//Ordered port connection

```

### Parameter Assignment

The parameter assignment should follow:

```verilog
parameter A;
parameter B;
```

The assignment below is not supported
```verilog
parameter A,B;
```

### Net Assignment

The net assignment should follow:

```verilog
wire a;
or
wire a,b;
```

The assignment below is not supported
```verilog
wire a = [exp], b = [exp];
```

### Reg Assignment

Same as net assignment

### Module Inistialization

The ordered parameter assignment(without identification of parameter) feature is supported:
```verilog
A a#(1,2)(x,y,z);
```

The two inistialization in one statement are supported:
```verilog
A a#(1,2)(x,y,z);
```


### Duplication Declration

The declration below is not supported
```verilog
module A(output X)
wire X;
```

### Bad Naming Problem

Assume you have a variable named `iq_a`, and there's an instance named `x`. After flattening, the variable name becomes `x_iq_a` to reflect its origin within the x instance.

However, consider a situation where a variable is named `a`, and there's an instance named `x_iq`. In the flattened naming convention, this variable would also end up with the name `x_iq_a`, which is identical to the previous example despite originating from a different hierarchical structure.