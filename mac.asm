global mac1
global mac2

mac1:
	mov rax, rdx
	mul rcx
	add rax, rdi
	adc rdx, rsi
	ret

mac2:
	imul [rdx + 8], rsi
	imul [rsi + 8], rdx
	mov rax, rdx
	mul rsi
	add rdx, [rdx + 8]
	add rdx, [rsi + 8]
	add rax, rdi
	adc rdx, [rdi + 8]
	ret
