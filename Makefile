ASSEMBLER_FLAGS = --target nes --verbose
LINKER_FLAGS = -C nes.cfg

SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := binary

BINARY_NAME := cartridge.nes
BINARY_PATH := $(BIN_DIR)/$(BINARY_NAME)

SRCS = $(wildcard $(SRC_DIR)/*.asm)
OBJS = $(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,$(SRCS:.asm=.o))

all: $(BINARY_PATH)

$(BINARY_PATH): $(OBJS) | $(BIN_DIR)
	ld65 $(OBJS) -o $(BINARY_PATH) $(LINKER_FLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm | $(OBJ_DIR)
	ca65 $< -o $@ $(ASSEMBLER_FLAGS)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

clean:
	rm -r $(BIN_DIR)
	rm -r $(OBJ_DIR)
