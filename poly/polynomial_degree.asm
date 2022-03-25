global polynomial_degree


polynomial_degree:
	mov rbx, [rdi]
	mov rcx, rsi
	mov rax, 0xFFFFFFFFFFFFFFFF
	ret
