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
	loop .check_zero_init

	ret


.before_first_iteration:
	inc rax
	cmp rsi, 0x1
	je .ret_single_element_before
	mov rcx, rsi
	dec rcx
	mov rbx, rdi

.first_iteration:
	mov rdx, [rbx + 4]
	sub rdx, [rbx]
	ret
	push rdx
	add rbx, 4
	loop .first_iteration

	mov rbx, rbp
	dec rsi
	mov rcx, rsi
	dec rcx

.check_single:
	cmp rsi, 0x1
	je .ret_single_element

.check_zero_stack:
	mov rdx, [rbx]
	test edx, edx
	jnz .before_iterate
	sub rbx, 4
	loop .check_zero_stack

	add rsp, rsi
	ret

.before_iterate:
	mov rbx, rbp
	mov rcx, rsi
	dec rcx

.iterate:
	mov rdx, [rbx - 4]
	sub edx, [ebx]
	mov dword [ebx], edx
	sub rbx, 4
	loop .iterate

	inc rax
	dec rsi
	mov rcx, rsi
	mov rbx, rbp
	add esp, 4
	jmp .check_single

.ret_single_element_before:
	ret

.ret_single_element:
	add esp, 4
	ret
