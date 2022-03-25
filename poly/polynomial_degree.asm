global polynomial_degree

align 16
polynomial_degree:
	mov rbx, rdi
	mov rcx, rsi
	mov rax, 0xFFFFFFFF

.check_zero_poly:
	mov rdx, [rbx]
	test edx, edx
	jnz .ret_non_zero_poly
	add rbx, 4
	loop .check_zero_poly

.ret_zero_poly:
	mov rax, 0x1
	ret


.ret_non_zero_poly:
	ret
