# Define the source and output directories
SRC_DIR = .
BIN_DIR = bin_out

# Define the source files
ASM_SOURCES := $(wildcard $(SRC_DIR)/*.asm $(SRC_DIR)/*.ASM)

# Define the output files (.com) that will be created locally
COM_OUTPUTS := $(patsubst %.asm, %.com, $(patsubst %.ASM, %.COM, $(notdir $(ASM_SOURCES))))

.PHONY: all clean

all: $(BIN_DIR) $(COM_OUTPUTS)
	mv $(COM_OUTPUTS) $(BIN_DIR)/

# Rule to assemble source files into .com in the current directory
%.com: %.asm
	fasm $<

%.COM: %.ASM
	fasm $<

# Rule to create the bin_out directory
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Rule to clean up generated files and directory
clean:
	rm -f $(COM_OUTPUTS) $(BIN_DIR)/*.{com,COM}
	rmdir --ignore-fail-on-non-empty $(BIN_DIR)
