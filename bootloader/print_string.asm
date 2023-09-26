;
; Print Strings in 16-bit Real Mode
;



; Print a string from bx
print_string:          ; The bx register is the argument
    mov ah, 0x0e        ; Tell BIOS we need to print one charater on the screen
cycle:
    cmp byte [bx], 0    ; Check if the charater is null
    je done             ; If it is, jump to done

    mov al, [bx]        ; Load the charater to print into al
    int 0x10            ; Call BIOS

    add bx, 1           ; Increment the pointer
    jmp cycle           ; Loop
done:
    ret                 ; Return to the code that called us
