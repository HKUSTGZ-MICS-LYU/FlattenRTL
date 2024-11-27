module conquest_tb();

    // Generated top module signals
    reg  clk;
    reg  rst;
    reg  [127:0] state = 128'b0;
    reg  [127:0] key = 128'b0;
    wire [127:0] out = 128'b0;

    // Generated top module instance
    top _conc_top_inst(
            .clk       ( clk ),
            .rst       ( rst ),
            .state     ( state ),
            .key       ( key ),
            .out       ( out ));

    // Generated internal use signals
    reg  [31:0] _conc_pc;
    reg  [255:0] _conc_opcode;
    reg  [255:0] _conc_ram[0:10];


    // Generated clock pulse
    always begin
        #5 clk = ~clk;
    end

    // Generated program counter
    always @(posedge clk) begin
        _conc_pc = _conc_pc + 32'b1;
        _conc_opcode = _conc_ram[_conc_pc];
        key <= #1 _conc_opcode[255:128];
        state <= #1 _conc_opcode[127:0];
        $strobe(";_C %d", _conc_pc);
    end

    // Generated initial block
    initial begin
        $display(";_C 1");
        clk = 1'b0;
        rst = 1'b0;
        _conc_pc = 32'b1;
        $readmemb("data.mem", _conc_ram);
        _conc_opcode = _conc_ram[1];
        key <= #1 _conc_opcode[255:128];
        state <= #1 _conc_opcode[127:0];
        #2 clk = 1'b1;
        rst = 1'b1;
        #5 rst = 1'b0;
        #100 $finish;
    end

endmodule
