global polynomial_degree

BIAS equ 63
REGISTER_SIZE equ -64
AVAILABLE_HALF equ 32

polynomial_degree:
	mov rax, -1
	mov rcx, rsi

	mov r8, rsi
	sub r8, AVAILABLE_HALF ;część zmieści się w rejestrze ze zwykłym intem
	jns .not_enough
	mov r8, 0
	jmp .check_zero_first

.not_enough:
	add r8, BIAS
	and r8, REGISTER_SIZE

.check_zero_first:
	mov rdx, [rdi]
	test edx, edx
	jnz .preparation
	loop .check_zero_first

	ret

.preparation:
	inc rax
	cmp rsi, 1
	je .ret_single_input

	mov rcx, rsi ;iterujemy po wszystkich liczbach
	dec rcx

	mov r9, r8 ;iterujemy po komórkach

	push rbx
	push rbp
	mov rbp, rsp

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
	dec r9
	jnz .push_zeros

	mov r9, r8  ;restore counter for cells

.push_init_after:
	loop .push_init

	dec rsi
	mov rcx, rsi

	lea rbx, [rbp - 8] ;the first value

.check_zero_stack:
	mov rdx, [rbx]
	sub rbx, 8

	test rdx, rdx
	jnz .check_single

	dec rcx
	jz .check_zero_stack

	dec r9
	cmp r9, 0
	jg .check_zero_stack

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
	mov rdx, [rbx - 8 - 8*r8] ;next number
	sub rdx, [rbx]
	mov qword [rbx], rdx
	sub rbx, 8

	test r8, r8
	jz .after_subtract

.subtract_inner_cells:
	mov rdx, [rbx - 8 - 8*r8] ;the cell of a next number
	sbb rdx, [rbx]
	mov qword [rbx], rdx
	sub rbx, 8

	dec r9
	jnz .subtract_inner_cells

.after_subtract:
	loop .subtract_first_cell

	dec rsi
	mov rcx, rsi

	lea rbx, [rbp - 8]
	jmp .check_zero_stack

.ret_single_input:
	ret

.ret_single_stack:
	leave
	pop rbx
	inc rax
	ret
