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
	inc r8    ;counts the sum of needed cells
	neg r8

.check_zero_first:
	mov rdx, [rbx]
	test edx, edx
	jnz .preparation
	add rbx, 4
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

	push rbp
	mov rbp, rsp

.push_init:
	movsxd rdx, [rdi + 4]
	movsxd rbx, [rdi]

	sub rdx, rbx
	push rdx
	add rdi, 4

	inc r9
	jnz .push_fillers
	jz .push_init_after

.push_fillers:
	cmp rdx, 0
	jge .add_positive

.add_negative:
	mov rbx, -1
	jmp .push_fillers_after

.add_positive:
	mov rbx, 0

.push_fillers_after:
	push rbx

	inc r9
	jnz .push_fillers

.push_init_after:
	mov r9, r8
	loop .push_init

	dec rsi
	mov rcx, rsi

	lea rbx, [rbp - 8]

.check_zero_stack:
	mov rdx, [rbx]
	sub rbx, 8

	test rdx, rdx
	jnz .check_single

	test r8, r8
	jnz .check_inner_cells
	jz .check_after

.check_inner_cells:
	mov rdx, [rbx]
	sub rbx, 8
	test rdx, rdx
	jnz .check_single

	inc r9
	jnz .check_inner_cells

	mov r9, r8

.check_after:
	loop .check_zero_stack

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

	;mov dword [r10], edx; added
	;lea r10, [r10 + 4]
	;add r10, 4

	test r8, r8
	jz .after_subtract

.subtract_inner_cells:
	;mov rax, -3
	mov rdx, [rbx - 8 + 8*r8] ;the cell of a next number
	sbb rdx, [rbx]
	mov qword [rbx], rdx

;	sub rbx, 8
	lea rbx, [rbx - 8]

	inc r9
	jnz .subtract_inner_cells

	mov r9, r8

.after_subtract:
	loop .subtract_first_cell

	inc rax
	dec rsi
	mov rcx, rsi

;	lea rbx, [rbp]
;	mov dword [r10], eax
;	lea r10, [r10 + 4]

	;lea rbx, [8 + 8*r10]
	;add rsp, rbx

	lea rbx, [rbp - 8]

;	mov dword [r10], [rbx]
;	lea r10, [r10+4]

	jmp .check_zero_stack

.ret_single_input:
	pop rbx
	ret

.ret_single_stack:
	leave
	pop rbx
	inc rax
	ret
