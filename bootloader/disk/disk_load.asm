;
; Disk Load
;

disk_load:
    push dx            ; Save DX to stack to remember how many sectors were requested to be read

    mov ah, 0x02       ; BIOS read sector function
    mov al, dh         ; Read DH sectors
    mov ch, 0x00       ; Cylinder 0
    mov dh, 0x00       ; Head 0
    mov cl, 0x02       ; Start reading from sector 2 (After the boot sector)

    int 0x13           ; Call BIOS interrupt to read the disk
    jc read_error      ; Jump to disk_error if there was an error (Carry flag set)
    
    pop dx             ; Restore DX from stack
    cmp dh, al         ; if AL (sectors read) != DH (sectors expected)
    jne disk_error     ;    display error message
    ret

read_error:
    mov bx, READ_ERROR_MSG
    call print_string
    jmp $

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

; Variables
READ_ERROR_MSG: db "Disk read error!", 0
DISK_ERROR_MSG: db "Disk error!", 0

