global mac1

mac1:
	mul rdx, rcx
	mov rax, 0x0
	adc rax, rax

	add rdx, rsi
	adc rax, rdi
	ret
