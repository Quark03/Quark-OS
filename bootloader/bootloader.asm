;
; Quark OS Boot Sector
;
[org 0x7c00]    ; Tell the asembler where the code will be loaded

mov [BOOT_DRIVE], dl ; Save the boot drive number in the variable BOOT_DRIVE

mov bp, 0x8000       ; Set the stack at 0x8000 - Safely out of the way
mov sp, bp           ; Set the stack pointer

mov bx, 0x9000       ; Load 5 sectors to 0x0000(ES):0x9000(BX) from the boot drive
mov dh, 2
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]    ; Print the first loaded word that should be 0xdada stored at 0x9000
call print_hex

mov dx, [0x9000 + 512]  ; Print the first loaded word from the 2nd sector: should be 0xface
call print_hex

jmp $  ; Infinite loop to halt the CPU

;
; Includes
;
%include "./bootloader/print_string.asm"
%include "./bootloader/print_hex.asm"
%include "./bootloader/disk_load.asm"

; Global variables 
BOOT_DRIVE: db 0

;
; Padding and magic BIOS number.
;
times 510-($-$$) db 0
dw 0xaa55


; We know that BIOS will load only the first 512-byte sector from the disk, 
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers, we can prove to ourselfs that we actually loaded those 
; additional two sectors from the disk we booted from.
times 256 dw 0xdada 
times 256 dw 0xface