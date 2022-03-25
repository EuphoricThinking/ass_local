global polynomial_degree


polynomial_degree:
	mov rbx, rdi
	mov rcx, rsi
	mov rax, 0xFFFFFFFF
	ret

.check_zero_poly:
	test [rbx], [rbx]
	jnz .ret_zero_poly
	lea rbx, [rbx + 4]
	loop .check_zero_poly

.ret_zero:
	mov rax, 0x1
	ret


.ret_non_zero_poly:
	ret
