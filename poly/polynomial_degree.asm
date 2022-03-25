global polynomial_degree


polynomial_degree:
	mov rbx, rdi
	mov rcx, rsi
	mov rax, 0xFFFFFFFF

.check_zero_poly:
	mov rdx, [rbx]
	test rdx, rdx
	jnz .ret_non_zero_poly
	mov rbx, [rbx + 4]
	loop .check_zero_poly

.ret_zero:
	mov rax, 0x1
	ret


.ret_non_zero_poly:
	ret
