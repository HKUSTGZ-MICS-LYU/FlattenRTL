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
// 8 bit adder
module adder_8bit(a, b, sum);
   input  [7:0] a;
   input  [7:0] b;
   output [7:0] sum;
   assign sum = a + b;
endmodule



// 16 bit adder
module adder_16bit(a, b, sum);
   input  [15:0] a;
   input  [15:0] b;
   output [15:0] sum;

   adder_8bit add_high (
       .a(a[15:8]),
       .b(b[15:8]), 
       .sum(sum[15:8])
   );

   adder_8bit add_low (
       .a(a[7:0]),
       .b(b[7:0]),
       .sum(sum[7:0]) 
   );
endmodule 



endmodule 

// 32 bit adder
module adder_32bit(a, b, sum);
   input  [31:0] a;
   input  [31:0] b;
   output [31:0] sum;

   adder_16bit add_high (
       .a(a[31:16]),
       .b(b[31:16]),
       .sum(sum[31:16])
   );  

   adder_16bit add_low (
       .a(a[15:0]),
       .b(b[15:0]), 
       .sum(sum[15:0])
   );
endmodule


```

### Flatten Design 
```verilog
module adder_32bit (
        input [31:0] a,
        input [31:0] b,
        output [31:0] sum) ;
    wire [31:0] sum ;

    wire [15:0] add_high_a;
    wire [15:0] add_high_b;
    wire [15:0] add_high_sum;
    wire [15:0] add_low_a;
    wire [15:0] add_low_b;
    wire [15:0] add_low_sum;
    assign add_high_a = a[31:16];
    assign add_high_b = b[31:16];
    assign sum[31:16] = add_high_sum;
    assign add_low_a = a[31:16];
    assign add_low_b = b[31:16];
    assign sum[31:16] = add_low_sum;

    wire[15:0] add_high_sum ;

    wire [7:0] add_high_add_high_a;
    wire [7:0] add_high_add_high_b;
    wire [7:0] add_high_add_high_sum;
    wire [7:0] add_high_add_low_a;
    wire [7:0] add_high_add_low_b;
    wire [7:0] add_high_add_low_sum;
    wire [7:0] add_low_add_high_a;
    wire [7:0] add_low_add_high_b;
    wire [7:0] add_low_add_high_sum;
    wire [7:0] add_low_add_low_a;
    wire [7:0] add_low_add_low_b;
    wire [7:0] add_low_add_low_sum;
    assign add_high_add_high_a = add_high_a[15:8];
    assign add_high_add_high_b = add_high_b[15:8];
    assign add_high_sum[15:8] = add_high_add_high_sum;
    assign add_high_add_low_a = add_high_a[15:8];
    assign add_high_add_low_b = add_high_b[15:8];
    assign add_high_sum[15:8] = add_high_add_low_sum;
    assign add_low_add_high_a = add_high_a[15:8];
    assign add_low_add_high_b = add_high_b[15:8];
    assign add_high_sum[15:8] = add_low_add_high_sum;
    assign add_low_add_low_a = add_high_a[15:8];
    assign add_low_add_low_b = add_high_b[15:8];
    assign add_high_sum[15:8] = add_low_add_low_sum;

    wire[7:0] add_high_add_high_sum ;
    assign  add_high_add_high_sum = add_high_add_high_a + add_high_add_high_b ;
    wire[7:0] add_high_add_low_sum ;
    assign  add_high_add_low_sum = add_high_add_low_a + add_high_add_low_b ;
    wire[15:0] add_low_sum ;
    wire[7:0] add_low_add_high_sum ;
    assign  add_low_add_high_sum = add_low_add_high_a + add_low_add_high_b ;
    wire[7:0] add_low_add_low_sum ;
    assign  add_low_add_low_sum = add_low_add_low_a + add_low_add_low_b ;

endmodule

```

## Support Feature and Limitation

