global mac1

mac1:
	mov rax, rdx
	mul rcx
	add rax, rdi
	adc rdx, rsi
	ret
