;
; Quark OS Boot Sector
;
[org 0x7c00]    ; Tell the asembler where the code will be loaded

mov bp, 0x9000  ; Set the stack
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call switch_to_pm   ; Note that we never return from here.

jmp $

;
; Includes
;
%include "./bootloader/print_string.asm"
%include "./bootloader/gdt.asm"
%include "./bootloader/print_string_pm.asm"
%include "./bootloader/switch_to_pm.asm"

[bits 32]
; This is where we arrive after switching to and initialising protected mode

BEGIN_PM:
    mov ebx , MSG_PROT_MODE
    call print_string_pm        ; Use our 32-bit print routine. 
    jmp $                       ; Hang.

; Global variables
MSG_REAL_MODE: db 'Started in 16-bit Real Mode', 0
MSG_PROT_MODE: db 'Successfully landed in 32-bit Protected Mode', 0

;
; Padding and magic BIOS number.
;
times 510-($-$$) db 0
dw 0xaa55


; We know that BIOS will load only the first 512-byte sector from the disk, 
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers, we can prove to ourselfs that we actually loaded those 
; additional two sectors from the disk we booted from.
; times 256 dw 0xdada 
; times 256 dw 0xface