ASSEMBLER_FLAGS = --target nes --verbose
LINKER_FLAGS = -C nes.cfg

all: main.nes

main.nes: main.o
	ld65 main.o -o main.nes $(LINKER_FLAGS)

main.o: main.asm
	ca65 main.asm -o main.o $(ASSEMBLER_FLAGS)
	
clean:
	rm main.nes main.o main.dbg
