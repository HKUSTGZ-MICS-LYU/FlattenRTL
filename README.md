# Description

This is a project that flattens Verilog.

## Install

```bash
pip install antlr4-python3-runtime==4.13.1
```

## Run

```bash
usage: main.py [-h] [-f FILELIST] [-t TOP] [-o OUTPUT] [-g] dir

positional arguments:
  dir                   The working directory.

optional arguments:
  -h, --help            show this help message and exit
  -f FILELIST, --filelist FILELIST
                        The filelist of design.
  -t TOP, --top TOP     The name of the top module.
  -o OUTPUT, --output OUTPUT
                        The output file containing the flattened module. Default = flatten.v
  -g, --debug           Enable debug mode.
```

## Example

```bash
python main.py tests/regression/adder4bit -f filelist.f -t adder_4bit -o f_adder_4bit.v -g
```

### Example Input

```verilog
module adder_2bit ( 
    input [1:0] a,
    input [1:0] b,
    output [2:0] sum
);
    assign sum = a + b;
endmodule

module adder_4bit ( 
    input [3:0] a,
    input [3:0] b,
    output [4:0] sum
);
    wire [2:0] sum_lower;
    wire [2:0] sum_upper;

    adder_2bit adder_lower (
        .a(a[1:0]),
        .b(b[1:0]),
        .sum(sum_lower)
    );

    adder_2bit adder_upper (
        .a(a[3:2]),
        .b(b[3:2]),
        .sum(sum_upper)
    );

    assign sum = {sum_upper[2:0], sum_lower[1:0]};
endmodule
```

### Example Output

```verilog
module adder_4bit (
    input [3:0] a,
    input [3:0] b,
    output [4:0] sum
);
    wire [2:0] sum_lower;
    wire [2:0] sum_upper;

    wire[1:0] adder_lower_a;
    wire[1:0] adder_lower_b;
    wire[2:0] adder_lower_sum;
    wire[1:0] adder_upper_a;
    wire[1:0] adder_upper_b;
    wire[2:0] adder_upper_sum;

    assign  adder_lower_sum = adder_lower_a + adder_lower_b ;
    assign  adder_upper_sum = adder_upper_a + adder_upper_b ;
    assign adder_lower_a = a[1:0];
    assign adder_lower_b = b[1:0];
    assign sum_lower = adder_lower_sum;
    assign adder_upper_a = a[3:2];
    assign adder_upper_b = b[3:2];
    assign sum_upper = adder_upper_sum;

    assign sum = {sum_upper[2:0], sum_lower[1:0]};
endmodule
```

## Authors

- Ziyue Zheng ([MrWater98](https://github.com/MrWater98))
- Xiangchen Meng ([Muxucao0812](https://github.com/Muxucao0812))
- Yangdi Lyu ([lvyangdi](https://github.com/lvyangdi)) ([Personal Page](https://personal.hkust-gz.edu.cn/yangdilyu/index.html))

## Citation

If you use this repository in your work, please cite:

```bibtex
@inproceedings{flattenrtl2024,
    title={FlattenRTL: An Open Source Tool for Flattening Verilog Module at RTL Level},
    author={Meng, Xiangchen and Zheng, Ziyue and Lyu, Yangdi},
    booktitle={International Symposium of EDA},
    year={2024}
}
```

## Known Issues

1. Cannot handle macros; requires preprocessing with iverilog.
2. Bad support of `syscall` like `$display` or `$fwrite`.
3. Some syntax is unsupported.

## Verification

1. Currently, benchmarks such as adder, usb_phy, and Rocket-Chip have passed equivalence checking with Formality.