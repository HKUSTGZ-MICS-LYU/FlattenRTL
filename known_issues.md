# Known Issues
## Limitations and Features
### Module Declaration (Solved)

The module declaration should be follow the standard style below without any parameters:

```verilog
module decl(a, b, c);
   input  [2:0] a;
   input  [2:0] b;
   output [2:0] c;
```


### Port Connection (Solved)

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

### Bad Naming Problem (Solved by using "__")

Assume you have a variable named `iq_a`, and there's an instance named `x`. After flattening, the variable name becomes `x_iq_a` to reflect its origin within the x instance.

However, consider a situation where a variable is named `a`, and there's an instance named `x_iq`. In the flattened naming convention, this variable would also end up with the name `x_iq_a`, which is identical to the previous example despite originating from a different hierarchical structure.

### Marco Definition

The marco definition can be preprocessed by iverilog. Try `iverilog -E`. 