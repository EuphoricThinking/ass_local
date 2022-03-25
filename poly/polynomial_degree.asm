global polynomial_degree

align 16
polynomial_degree:
	push rbx
	mov rbx, rdi
	mov rcx, rsi
	mov rax, 0xFFFFFFFF
	xor rdx, rdx
	mov rdx, [rbx + 4]

	cmp rdx, 0
	jz .ret_zero_poly
	jnz .ret_non_zero_poly

	je .ret_zero_poly
	jne .ret_non_zero_poly

	test rdx, rdx
	jnz .ret_zero_poly

.check_zero_poly:
	mov rdx, [rbx]
	test rdx, rdx
	jnz .ret_zero_poly
	add rbx, 4
	loop .check_zero_poly

.ret_zero_poly:
	pop rbx
	mov rax, 0x1
	ret


.ret_non_zero_poly:
	pop rbx
	ret
