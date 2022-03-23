global mac1
global mac2

mac1:
	mov rax, rdx
	mul rcx
	add rax, rdi
	adc rdx, rsi
	ret

mac2:
	mov r8, [rsi]
	mov r9, [rdx]

	imul r8, [rdx + 8]
	imul r9, [rsi + 8]
	mov rax, [rsi]
	mul qword [rdx]

	add rdx, r8
	add rdx, r9

	add [rdi], rax
	adc [rdi + 8], rdx
	ret
