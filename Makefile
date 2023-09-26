# OS Name
NAME=quark_os.bin

# Terminal Colors
TCOLOR_RESET="\033[0m"
TCOLOR_GREEN="\033[32m"
TCOLOR_RED="\033[31m"
TCOLOR_YELLOW="\033[33m"
TCOLOR_BLUE="\033[34m"
TCOLOR_PURPLE="\033[35m"
TCOLOR_CYAN="\033[36m"
TCOLOR_WHITE="\033[37m"

BOOTLOADER_SRC=bootloader/bootloader.asm
KERNEL_SRC=kernel/kernel.c

all:	group
	@echo $(TCOLOR_PURPLE)Starting os emulation ...$(TCOLOR_RESET)
	@qemu-system-x86_64 -drive format=raw,file=$(NAME)

group: bootloader kernel
	@echo $(TCOLOR_CYAN)Building OS image ...$(TCOLOR_RESET)
	@cat bootloader.bin kernel.bin > $(NAME)
	@echo $(TCOLOR_GREEN)OS Image built successfully$(TCOLOR_RESET)

bootloader: $(BOOTLOADER_SRC)
	@clear
	@echo $(TCOLOR_CYAN)Assembling bootloader ...$(TCOLOR_RESET)
	@nasm $(BOOTLOADER_SRC) -f bin -o bootloader.bin
	@echo $(TCOLOR_GREEN)Bootloader assembled$(TCOLOR_RESET)


# ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary
# @arch -x86_64 objcopy -O binary -j .text kernel-ld kernel.bin
kernel:
	@echo $(TCOLOR_CYAN)Compiling kernel ...$(TCOLOR_RESET)
	@gcc -arch x86_64 -ffreestanding -c $(KERNEL_SRC) -o kernel.o
	@ld -arch x86_64 -o kernel.bin -image_base 0x1000 -static kernel.o
	@echo $(TCOLOR_GREEN)Kernel compiled successfully$(TCOLOR_RESET)

clean:
	rm -f $(NAME)

re: clean all

.PHONY: bootloader kernel group clean re