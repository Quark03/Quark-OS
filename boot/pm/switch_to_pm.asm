;
; Switch to Protected Mode
;

[bits 16]

switch_to_pm:
; We must switch of interrupts until we have 
; set-up the protected mode interrupt vector
; otherwise interrupts will run riot.
    cli                     ; Disable interrupts

    lgdt [gdt_descriptor]   ; Load our global descriptor table, which defines the protected mode segments (e.g. for code and data)

    mov eax , cr0           ; To make the switch to protected mode, we set 
    or eax, 0x1             ; the first bit of CR0, a control register
    mov cr0 , eax

    jmp CODE_SEG:init_pm

[bits 32]
; Initialize registers and set the stack once in PM

init_pm:
; Now in PM , our old segments are meaningless , 
; so we point our segment registers to the
; data selector we defined in our GDT

    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000 ; Update our stack position so it is right at the top of our free space
    mov esp , ebp

    jmp BEGIN_PM