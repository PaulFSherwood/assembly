# Specify the assembler and linker
ASM = nasm
LD = ld

# Flags for the assembler and linker
ASMFLAGS = -f elf
LDFLAGS = -m elf_i386

# The name of your output binary
TARGET = $(basename $(SRC))

# Rule to assemble and link
all: $(TARGET)

# Rule to build the target by linking object files
$(TARGET): $(TARGET).o
	$(LD) $(LDFLAGS) -o $(TARGET) $(TARGET).o

# Rule to assemble each .asm file into an .o file
%.o: %.s
	$(ASM) $(ASMFLAGS) -o $@ $<

# Clean rule to remove generated files 
clean:
	rm -f *.o $(TARGET)
