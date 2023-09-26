;
; Print Hexadecimal Numbers
;

; Print a hex number from dx
print_hex:              ; The dx register is the argument
    pusha
    mov cx, 4           ; We will print 4 nibbles

char_loop:
    dec cx            ; Decrement the counter
    mov ax,dx         ; copy bx into ax so we can mask it for the last chars
    shr dx,4          ; shift bx 4 bits to the right
    and ax,0xf        ; mask ah to get the last 4 bits

    mov bx, HEX_OUT   ; set bx to the memory address of our string
    add bx, 2         ; skip the '0x'
    add bx, cx        ; add the current counter to the address

    cmp ax,0xa        ; Check to see if it's a letter or number
    jl set_letter     ; If it's a number, go straight to setting the value
    add byte [bx],7   ; If it's a letter, add 7
                        ; Why this magic number? ASCII letters start 17
                        ; characters after decimal numbers. We need to cover that
                        ; distance. If our value is a 'letter' it's already
                        ; over 10, so we need to add 7 more.
    jl set_letter

set_letter:
    add byte [bx],al  ; Add the value of the byte to the char at bx

    cmp cx,0          ; check the counter, compare with 0
    je print_hex_done ; if the counter is 0, finish
    jmp char_loop     ; otherwise, loop again

print_hex_done:
    mov bx, HEX_OUT   ; print the string pointed to by bx
    call print_string ; call the print_string function for HEX_OUT
    call reset_string ; reset the string to 0x0000
    popa              ; pop the initial register values back from the stack
    ret               ; return the function

;
; Resets the HEX_OUT string to 0x0000
;
reset_string:
    pusha
    mov bx , HEX_OUT 
    add bx , 2        ;Start after 0x

start:
    cmp byte [bx],0            ;  while not 0 
    jne set                 ; put 0 as ASCII string 
    jmp finish

set: 
    mov byte [bx] , 0x30  
    inc bx
    jmp start

finish:                      ;function ends
    popa
    ret

; Variables
HEX_OUT:
    db '0x0000', 0
