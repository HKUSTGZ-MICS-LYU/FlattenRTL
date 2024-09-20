# Algorithm of flattening a verilog design.

## Step 1: Find the Top-Level Module Node

For example: Our top-level module is adder_4bit. We need to find the module_declaration node, and the found part is shown as follows:

```verilog
module adder_2bit (
    input [1:0] a,
    input [1:0] b,
    output [2:0] sum
);
    assign sum = a + b;
endmodule

/*-- START: Part that we want to find --*/
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
/*-- END: Part that we want to find --*/
```

The found ANTLR4 node is roughly here:

![Untitled][]

**NOTE: In the code, the part responsible for collecting top-level information is `TopModuleNodeFinder`.**

### The code for Step 1 is:


```python
class TopModuleNodeFinder(SystemVerilogParserVisitor):
    def __init__(self, top_module):
        self.top_module_node = None # 2
        self.top_module = top_module   
        
    def visitModule_declaration(self, ctx: SystemVerilogParser.Module_declarationContext):
        module_name = ctx.module_header().module_identifier().getText()
        if module_name == self.top_module:
            self.top_module_node = ctx

# Step 1. Find the top module node of the design.
# top_module = "adder_4bit"
top_finder = TopModuleNodeFinder(top_module) # 1
top_finder.visit(tree)
top_node_tree = top_finder.top_module_node 

```
- The node of the top-level module is saved in the variable `top_node_tree`.

## Step 2: Collect Instantiation Information from the Top Node

The collected instantiation information should have the following characteristics:

1. The first module type instantiated from top to bottom. For example, in the following example, the type instantiated from top to bottom in adder_4bit is adder_2bit. (adder_3bit is not included)

```verilog
module adder_4bit (
    input [3:0] a,
    input [3:0] b,
    output [4:0] sum
);
    wire [2:0] sum_lower;
    wire [2:0] sum_upper;

    /*-- COLLECTION BEGIN: Instantiation 1 --*/
    adder_2bit adder_lower (
        .a(a[1:0]),
        .b(b[1:0]),
        .sum(sum_lower)
    );
    /*-- COLLECTION END: Instantiation 1 --*/

    /*-- COLLECTION BEGIN: Instantiation 2 --*/
    adder_2bit adder_upper (
        .a(a[3:2]),
        .b(b[3:2]),
        .sum(sum_upper)
    );
    /*-- COLLECTION BEGIN: Instantiation 2 --*/
    
    adder_3bit adder_example (
        .a(a[3:2]),
        .b(b[3:2]),
        .sum(sum_upper)
    );

    assign sum = {sum_upper[2:0], sum_lower[1:0]};
endmodule
```

2. Collect all the instantiation contents of adder_2bit, for example:
    1. cur_module_identifier:  `adder_2bit`
    2. cur_name_of_module_instances:  `['adder_lower', 'adder_upper']`
    3. cur_prefixs: `['adder_lower', 'adder_upper']`
    4. cur_list_of_ports_rhs: `['(a[1:0])', '(b[1:0])', '(sum_lower)', '(a[3:2])', '(b[3:2])', '(sum_upper)']`
    5. dict_of_lhs_to_rhs: `{'adder_lower': {'a': 'a[1:0]', 'b': 'b[1:0]', 'sum': 'sum_lower'}, 'adder_upper': {'a': 'a[3:2]', 'b': 'b[3:2]', 'sum': 'sum_upper'}}`
    6. inst_module_design:
        
        ```verilog
        module adder_2bit (
            input [1:0] a,
            input [1:0] b,
            output [2:0] sum
        );
            assign sum = a + b;
        endmodule
        ```

## Step 3: Rename and Replace Instantiation Parts

### 3.1 Replace Module Variables

Now we have inst_module_design, and we need to modify the non-port declaration parts, for example:

Original: assign sum = a + b;
Now: assign adder_lower_sum = adder_lower_a + adder_lower_b;

Add cur_prefixs before variables, similarly:

Now: assign adder_upper_sum = adder_upper_a + adder_upper_b;

The modified code is parsed into a tree and saved to inst_module_design_trees, inst_module_nodes

The code corresponding to adder_lower is:
```verilog
module adder_2bit (
    input [1:0] a,
    input [1:0] b,
    output [2:0] sum
);  adder_1bit adder1(.a(a));
    assign adder_lower_sum = adder_lower_a + adder_lower_b;
endmodule
```

### 3.2 Further Collect Information

The core of processing the instantiated module interface is to declare new wires to receive interface information. To declare new wires, we need information including `bit width`, `wire name`, `wire direction`, and `interface type`. The original text is:

```verilog
    adder_2bit adder_lower (
        .a(a[1:0]), // 00
        .b(b[1:0]), // 01
        .sum(sum_lower) // 001
    );
```

The corresponding interface a after modification is:

```verilog
wire [1:0] adder_lower_a;
assign adder_lower_a = a[1:0];
```
`[1:0]` is the bit width, `adder_lower_a` replaces the input interface a of the instantiated `adder_2bit`, so in the assign below, `adder_lower_a` is the receiving end.

Based on the content needed above, we collected the following variables:

```verilog
cur_list_of_ports_lhs = ['a', 'b', 'sum', 'a', 'b', 'sum] 
cur_list_of_ports_lhs_width = ['[1:0]', '[1:0]', '[2:0]', '[1:0]', '[1:0]', '[2:0]']
cur_list_of_ports_width = ['[1:0]', '[1:0]', '[2:0]', '[1:0]', '[1:0]', '[2:0]']
cur_list_of_ports_direction = ['input', 'input', 'output', 'input', 'input', 'output']
cur_list_of_ports_type = ['wire', 'wire', 'wire', 'wire', 'wire', 'wire']
cur_list_of_data_type = ['', '', '', '', '', '']
cur_dict_of_ports = {
'a': {'width': '[1:0]', 'direction': 'input', 'type': 'wire'}, 
'b': {'width': '[1:0]', 'direction': 'input', 'type': 'wire'}, 
'sum': {'width': '[2:0]', 'direction': 'output', 'type': 'wire'}
```

## 3.3 Combine Materials to be Replaced

We combine the information collected above into new variables and assignments, and save them in the following two variables. Later, we will fill these assignment statements into the original text.

```python   
cur_new_variable = [
    'wire[1:0] adder_lower_a;', 
    'wire[1:0] adder_lower_b;', 
    'wire[2:0] adder_lower_sum;', 
    'wire[1:0] adder_upper_a;', 
    'wire[1:0] adder_upper_b;', 
    'wire[2:0] adder_upper_sum;'
]   

cur_new_assign = [
    'assign adder_lower_a = a[1:0];',
    'assign adder_lower_b = b[1:0];', 
    'assign sum_lower = adder_lower_sum;', 
    'assign adder_upper_a = a[3:2];', 
    'assign adder_upper_b = b[3:2];', 
    'assign sum_upper = adder_upper_sum;'
]
```

## 3.4 Concatenate the Obtained Materials to Get the Final Data

The original text before processing is as follows:

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

    /* -- Part of Delete
    adder_2bit adder_lower (
        .a(a[1:0]), 
        .b(b[1:0]), 
        .sum(sum_lower) 
    );

    adder_2bit adder_upper (
        .a(a[3:2]), 
        .b(b[3:2]), 
        .sum(sum_upper)  
    )
    -- Part of Delete */

    //Paste the declared new wires:
    wire[1:0] adder_lower_a;
    wire[1:0] adder_lower_b;
    wire[2:0] adder_lower_sum;
    wire[1:0] adder_upper_a;
    wire[1:0] adder_upper_b;
    wire[2:0] adder_upper_sum;**   
    //Paste the processed inst_module_design:
    assign adder_lower_sum = adder_lower_a + adder_lower_b;
    assign adder_lower_sum = adder_lower_a + adder_lower_b;
    
    // Paste the assigned new wires:    
    assign adder_lower_a = a[1:0];
    assign adder_lower_b = b[1:0];
    assign sum_lower = adder_lower_sum;
    assign adder_upper_a = a[3:2];
    assign adder_upper_b = b[3:2];
    assign sum_upper = adder_upper_sum;
    
    
    assign sum = {sum_upper[2:0], sum_lower[1:0]}; 
endmodule
```

The final processing effect is as follows:
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

    wire[1:0] adder_lower_a;
    wire[1:0] adder_lower_b;
    wire[2:0] adder_lower_sum;
    wire[1:0] adder_upper_a;
    wire[1:0] adder_upper_b;
    wire[2:0] adder_upper_sum;

    assign adder_lower_sum = adder_lower_a + adder_lower_b ;
    assign adder_upper_sum = adder_upper_a + adder_upper_b ;
    assign adder_lower_a = a[1:0];
    assign adder_lower_b = b[1:0];
    assign sum_lower = adder_lower_sum;
    assign adder_upper_a = a[3:2];
    assign adder_upper_b = b[3:2];
    assign sum_upper = adder_upper_sum;
    assign sum = {sum_upper[2:0], sum_lower[1:0]};
endmodule
```
