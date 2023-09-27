NAME=quark-os

# Terminal Colors
TCOLOR_RESET="\033[0m"
TCOLOR_GREEN="\033[32m"
TCOLOR_RED="\033[31m"
TCOLOR_YELLOW="\033[33m"
TCOLOR_BLUE="\033[34m"
TCOLOR_PURPLE="\033[35m"
TCOLOR_CYAN="\033[36m"
TCOLOR_WHITE="\033[37m"

# Automatically expand to a list of existing files that
# match the patterns
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# Create a list of object files to build, simple by replacing
# the ’.c ’ extension of filenames in C_SOURCES with ’.o’
OBJ = $(C_SOURCES:.c=.o)

all: $(NAME)

# Run qemu to simulate booting of our code
run: all
	@echo $(TCOLOR_PURPLE)Starting OS emulation ...$(TCOLOR_RESET)
	@qemu-system-x86_64 -drive format=raw,file=$(NAME)

# This is the actual disk image that the computer loads
# which is the combination of our compiled bootsector and kernel
$(NAME): boot/boot_sect.bin kernel.bin
	@echo $(TCOLOR_PURPLE)Building OS disk image ...$(TCOLOR_RESET)
	@cat $^ > $(NAME)
	@echo $(TCOLOR_GREEN)OS image built successfully$(TCOLOR_RESET)


# This builds the binary of our kernel from two object files:
# - the kernel_entry, which jumps to main() in our kernel
# - the compiled C kernel
kernel.bin: kernel/kernel_entry.o $(OBJ)
	@echo $(TCOLOR_PURPLE)Linking kernel ...$(TCOLOR_RESET)
	@ld -o $@ -Ttext 0x1000 $^ --oformat binary
	@echo $(TCOLOR_GREEN)Kernel linked successfully$(TCOLOR_RESET)

# Virtualize the OS image using qemu
# - Does not require the OS image to be built
virtualize:
	@echo $(TCOLOR_PURPLE)Starting OS emulation ...$(TCOLOR_RESET)
	@qemu-system-x86_64 -drive format=raw,file=$(NAME)

# Generic rule for compiling C code to an object file
%.o:%.c
	@gcc -ffreestanding -c $< -o $@

# Assemble the kernel_entry
%.o:%.asm
	@nasm $< -f elf64 -o $@

%.bin:%.asm
	@nasm $< -f bin -o $@

clean:
	@echo $(TCOLOR_PURPLE)Cleaning ...$(TCOLOR_RESET)
	@rm -rf *.bin *.dis *.o $(NAME)
	@rm -rf kernel/*.o boot/*.bin drivers/*.o