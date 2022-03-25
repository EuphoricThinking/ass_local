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

	mov rbx, rbp
	dec rsi
	mov rcx, rsi

.check_single:
	cmp rsi, 0x1
	je .ret_single_element

.check_zero_stack:
	mov rdx, [rbx]
	test edx, edx
	jnz .before_iterate
	add rbx, 4
	loop .check_zero_stack

	ret

.before_iterate:
	mov rbx, rbp
	mov rcx, rsi

.iterate:
	mov rdx, [rbx + 4]
	sub edx, [ebx]
	mov dword [ebx], edx
	add rbx, 4
	dec rcx
	jnz .iterate

	dec rsi
	mov rcx rsi
	add esp, 4
	jmp .check_single

.ret_single_element:
	ret

