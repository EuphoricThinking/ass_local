global polynomial_degree

align 16
polynomial_degree:
	push rbx
	mov rbx, rdi
	mov rcx, rsi
	mov rax, -1

.check_zero_init:
	mov rdx, [rbx]
	test edx, edx
	jnz .before_first_iteration
	add rbx, 4
	loop .check_zero_init

	pop rbx
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
	movsxd rdx, edx

	sub rdx, [rbx]
	push rdx
	add rbx, 4
	loop .first_iteration

	dec rsi
	mov rcx, rsi
	mov rbx, rsp


.check_zero_stack:
	mov rdx, [rbx]
	test edx, edx
	jnz .check_single
	add rbx, 8
	loop .check_zero_stack

	lea rdx, [rsi*8]
	add rsp, rdx
	pop rbx
	ret

.check_single:
	cmp rsi, 0x1
	je .ret_single_element

.before_iterate:
	lea rdx, [rsp + 8*(rsi - 1)]
	mov rbx, rdx

	mov rcx, rsi
	dec rcx

.iterate:
	mov rdx, [rbx - 8]
	sub rdx, [rbx]
	mov qword [rbx], rdx
	sub rbx, 8
	loop .iterate

	inc rax
	dec rsi
	mov rcx, rsi
	add rsp, 8
	mov rbx, rsp
	jmp .check_zero_stack

.ret_single_element_before:
	pop rbx
	ret

.ret_single_element:
	add rsp, 8
	inc rax
	pop rbx
	ret
