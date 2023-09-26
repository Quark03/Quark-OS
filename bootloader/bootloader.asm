;
; Quark OS Boot Sector
;
[org 0x7c00]    ; Tell the asembler where the code will be loaded

KERNEL_OFFSET equ 0x1000    ; This is the memory offset to which we will load our kernel

mov [BOOT_DRIVE], dl ; BIOS stores our boot drive in DL, so it’s ; best to remember this for later.

mov bp, 0x9000  ; Set the stack
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call load_kernel

call switch_to_pm   ; Note that we never return from here.

jmp $

;
; Includes
;
%include "./bootloader/print/print_string.asm"
%include "./bootloader/disk/disk_load.asm"
%include "./bootloader/pm/gdt.asm"
%include "./bootloader/pm/print_string_pm.asm"
%include "./bootloader/pm/switch_to_pm.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL     ;  Print a message to say we are loading the kernel
    call print_string

    ; Set -up parameters for our disk_load routine , so
    ; that we load the first 15 sectors (excluding
    ; the boot sector) from the boot disk (i.e. our
    ; kernel code) to address KERNEL_OFFSET
    mov bx, KERNEL_OFFSET
    mov dh , 15
    mov dl, [BOOT_DRIVE]
    call disk_load

    ret

[bits 32]
; This is where we arrive after switching to and initialising protected mode

BEGIN_PM:
    mov ebx , MSG_PROT_MODE
    call print_string_pm        ; Use our 32-bit print routine. 

    call KERNEL_OFFSET          ; Now jump to the address of our loaded kernel code , assume the brace position , 
                                ; and cross your fingers. Here we go!

    jmp $                       ; Hang.

; Global variables
BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE  db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory.", 0

;
; Padding and magic BIOS number.
;
times 510-($-$$) db 0
dw 0xaa55