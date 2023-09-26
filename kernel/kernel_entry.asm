; Ensures that we jump straight into the kernel ’s entry function.
[bits 32]
					; We ’ re in protected mode by now , so use 32 - bit instructions.
[extern _start]		; Declate that we will be referencing the external symbol ’ main ’,
					; so the linker can substitute the final address

call _start			; Call our main() function in our C kernel
jmp $				; If, somehow, main() returns, loop forever.