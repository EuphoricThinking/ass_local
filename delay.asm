global delay

delay:
	cmp edi, 0x0
	jz .exit

.loop:
	sub rdi, 0x1
	jnz .loop

.exit:
	rdtsc
	shl rdx, 0x20
	or rax, rdx

	ret
