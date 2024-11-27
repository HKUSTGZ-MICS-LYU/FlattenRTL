IVERILOG_BIN = /home/alif/_tools/_developed/verilog-10.0/bin
CONC_TEST_DIR = tests

OBJ_FLAT = flattened.v
OBJ_INST = conquest_dut.v

FLATTEN_ROOT = /home/alif/_tools/DesignPlayer/08JAN2017


.PHONY: all clean

ifeq ($(IS_FLATTENED),true)
all:
	@rm -rf $(CONC_TEST_DIR)
	@mkdir -p $(CONC_TEST_DIR)
	@$(IVERILOG_BIN)/iverilog_dev -f files.f -o $(OBJ_INST) -t conquest \
		-ptb=conquest_tb.v -pclk=$(CLK_NAME) -preset=$(RESET_NAME) -preset_edge=$(RESET_EDGE) \
		-punroll=$(UNROLL_CYC) -pbid=$(TARGET)
	@rm -rf tmp_alif_concolic_debug.txt
	
else
all: $(OBJ_FLAT)
	@rm -rf $(CONC_TEST_DIR)
	@mkdir -p $(CONC_TEST_DIR)
	@$(IVERILOG_BIN)/iverilog_dev $(OBJ_FLAT) -o $(OBJ_INST) -t conquest \
		-ptb=conquest_tb.v -pclk=$(CLK_NAME) -preset=$(RESET_NAME) -preset_edge=$(RESET_EDGE) \
		-punroll=$(UNROLL_CYC) -pbid=$(TARGET)
	@rm -rf tmp_alif_concolic_debug.txt

$(OBJ_FLAT): $(OBJ_SRC)
	@flattenverilog -f files.f -top $(TOP_MODULE) -quiet -nobanner -out $(OBJ_FLAT) -disable_assignment_merge
	@rm -rf flattenverilog.log
endif


clean:
	@rm -rf $(CONC_TEST_DIR)
	@rm -rf *.ys
	@rm -rf *.v
	@rm -rf *.out
	@rm -rf data.mem
	@rm -rf data_raw.mem
	@rm -rf *.txt
	@rm -rf *.vvp
	@rm -rf *.log
	@echo "--------------CLEANED---------------"
