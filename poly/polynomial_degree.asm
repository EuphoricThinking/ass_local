global polynomial_degree

align 16
polynomial_degree:
	mov rbx, rdi
	mov rcx, rsi
	mov rax, 0xFFFFFFFF

.check_zero_init:
	mov rdx, [rbx]
	test edx, edx
	jnz .before_first_iteration
	add rbx, 4
	loop .check_zero_poly

.ret_zero_poly:
	mov rax, 0x1
	ret


.before_first_iteration:
	inc rax
	cmp rsi, 0x1
	je .ret_single_element
	mov rcx, [rsi - 1]
	mov rbx, rdi

.first_iteration:
	mov rdx, [rbx + 4]
	sub edx, [ebx]
	push edx
	add rbx, 4
	dec rcx
	jnz .first_iteration

.ret_single_element:
	ret
