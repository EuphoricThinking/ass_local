global polynomial_degree

BIAS equ 63
AVAILABLE_HALF equ 32
REGISTER_EXPONENT equ 6

polynomial_degree:
	mov rax, -1
	mov rcx, rsi

	push rbx
	mov rbx, rdi

	mov r8, rsi
	sub r8, AVAILABLE_HALF ;część zmieści się w rejestrze ze zwykłym intem
	add r8, BIAS
	shr r8, REGISTER_EXPONENT
	neg r8

.check_zero_first:
	mov rdx, [rbx]
	add rbx, 4
	test edx, edx
	jnz .preparation
	loop .check_zero_first

	pop rbx
	ret

.preparation:
	inc rax

	cmp rsi, 1
	je .ret_single_input

	mov rcx, rsi ;iterujemy po wszystkich liczbach
	dec rcx   ;bez ostatniej

	mov r9, r8 ;iterujemy po komórkach

.push_init:
	movsxd rdx, [rdi + 4]
	sub rdx, [rdi]
	push rdx
	add rdi, 4

	test r8, r8
	jz .push_init_after

.push_zeros:
	xor rdx, rdx
	push rdx
	inc r9
	jnz .push_zeros

	mov r9, r8  ;restore counter for cells

.push_init_after:
	loop .push_init

	dec rsi
	mov rcx, rsi

	push rbp
	mov rbp, rsp
	lea rbx, [rbp - 8]

.check_zero_stack:
	mov rdx, [rbx]
	sub rbx, 8

	test rdx, rdx
	jnz .check_single

	dec rcx
	jz .check_zero_stack

	inc r9
	cmp r9, 0
	jl .check_zero_stack

	leave
	pop rbx
	ret

.check_single:
	cmp rsi, 1
	je .ret_single_stack

	mov rcx, rsi
	dec rcx ;how many iterations over numbers

	mov r9, r8 ;how many cell iterations
	lea rbx, [rbp - 8] ;first element

.subtract_first_cell:
	mov rdx, [rbx - 8 + 8*r8] ;next number
	sub rdx, [rbx]
	mov qword [rbx], rdx
	lea rbx, [rbx - 8]

	test r8, r8
	jz .after_subtract

.subtract_inner_cells:
	mov rdx, [rbx - 8 + 8*r8] ;the cell of a next number
	sbb rdx, [rbx]
	mov qword [rbx], rdx
	;sub rbx, 8
	lea rbx, [rbx - 8]

	inc r9
	jnz .subtract_inner_cells

	mov r9, r8

.after_subtract:
	loop .subtract_first_cell

	dec rsi
	mov rcx, rsi

	lea rbx, [rbp - 8]
	jmp .check_zero_stack

.ret_single_input:
	pop rbx
	ret

.ret_single_stack:
	leave
	pop rbx
	inc rax
	ret
