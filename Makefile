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

BOOTLOADER_DIR=bootloader
BOOTLOADER_SRC=$(BOOTLOADER_DIR)/bootloader.asm

all:	bootloader
	@echo $(TCOLOR_PURPLE)Starting os emulation ...$(TCOLOR_RESET)
	@qemu-system-x86_64 -drive format=raw,file=$(NAME)


bootloader: $(BOOTLOADER_SRC)
	@clear
	@echo $(TCOLOR_CYAN)Assembling bootloader ...$(TCOLOR_RESET)
	@nasm $(BOOTLOADER_SRC) -f bin -o $(NAME)
	@echo $(TCOLOR_GREEN)Bootloader assembled$(TCOLOR_RESET)

clean:
	rm -f $(NAME)

re: clean all

.PHONY: bootloader clear re