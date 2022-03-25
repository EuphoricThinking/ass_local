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
	push rdx
	add rbx, 4
	loop .first_iteration

	dec rsi
	mov rcx, rsi
	dec rcx
	mov rbx, rbp


.check_single:
	cmp rsi, 0x1
	je .ret_single_element

.check_zero_stack:
	
	mov rax, [rsp]
	lea rdx, [rsi*8]
	add rsp, rdx
	ret	
	
	mov rdx, [rbx]
	test edx, edx
	jnz .before_iterate
	sub rbx, 8
 
	loop .check_zero_stack

	lea rdx, [rsi*8]
	add rsp, rdx
	ret

.before_iterate:
	mov rbx, rbp
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
	mov rbx, rbp
	add rsp, 8
	jmp .check_single

.ret_single_element_before:
	ret

.ret_single_element:
	add rsp, 8
	ret
