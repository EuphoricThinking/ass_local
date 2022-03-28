global polynomial_degree

BIAS			equ 63 	; Excess of bits, applied for rounding up the number.
AVAILABLE_HALF 		equ 32 	; Ints defined in the given architecture consist of 32 bits, leaving empty 32-bit space in a 64-bit register.
				; The omitted bits can be used for spare bits reserved for a growing number.
REGISTER_EXPONENT 	equ 6 	; The number of bits in a 64-bit register can be rewritten as 2^6.

polynomial_degree:
         ; Preparation of the variables
	 mov     rax, -1        ; Initialisation of the result
	 mov     rcx, rsi       ; The amount of the given numbers is stored in a temporary counter.

	 push    rbx            ; The rbx register is qualified as callee-saved register, therefore should be stored on the stack.
	 mov     rbx, rdi       ; After saving its value, the rbx register can be used as a temporary pointer.

	 ; After saving 32-bit int in a 64-bit register, 32 bits are left, marked as AVAILABLE_HALF.
	 ; The solution assumes that r8 would contain the constant count of registers required per number,
	 ; therefore the BIAS is added in order to evaluate the number of reqisters resulting from
	 ; length_of_an_array - bits_left_in_a_register and one accounting for storing a number,
	 ; which can be rewritten in terms of bits as [63 + (63 + 1)] = [2*63 + 1]. Conversion
	 ; from bits to registers is performed using right shift by 6 positions, which substitutes
	 ; for the division by 2^6 = 64.
	 lea     r8, [rsi - AVAILABLE_HALF + 2*BIAS + 1]
	 shr     r8, REGISTER_EXPONENT

	 ;sub     r8, AVAILABLE_HALF ; After saving 32-bit int in a 64-bit register, 32 bits are left.
	 ;add     r8, BIAS
	 ;shr     r8, REGISTER_EXPONENT ; Right shift by an appropriate exponent substitutes for division by two raised to an appropriate power
	 ;inc     r8    ; Inclusion of the one register needed for storing an initial int

	 neg     r8             ; Addressing in NASM doesn't allow subtraction of registers, but adding the negation is acceptable.

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

	;mov rcx, rsi ;iterujemy po wszystkich liczbach
	;dec rcx   ;bez ostatniej

	lea rcx, [rsi - 1]

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

.prepare_after_subtraction:
	dec rsi
	mov rcx, rsi

	lea rbx, [rbp - 8]

.check_zero_stack:

.check_zero_cells:
	mov rdx, [rbx]
	sub rbx, 8

	test rdx, rdx
	jnz .check_single

	inc r9
	jnz .check_zero_cells

	mov r9, r8
	loop .check_zero_stack

	leave
	pop rbx
	ret

.check_single:
	cmp rsi, 1
	je .ret_single_stack

;	mov rcx, rsi
;	dec rcx ;how many iterations over numbers

	lea rcx, [rsi - 1]

	mov r9, r8 ;how many cell iterations
	lea rbx, [rbp - 8] ;first element

.subtract_first_cell:
	clc

.subtract_inner_cells:
	mov rdx, [rbx + 8*r8] ;the cell of a next number
	sbb rdx, [rbx]
	mov qword [rbx], rdx

	lea rbx, [rbx - 8]

	inc r9
	jnz .subtract_inner_cells

.after_subtract:
	mov r9, r8
	loop .subtract_first_cell

	inc rax

;	dec rsi
;	mov rcx, rsi

;	lea rbx, [rbp - 8]

;	jmp .check_zero_stack
	jmp .prepare_after_subtraction

.ret_single_input:
	pop rbx
	ret

.ret_single_stack:
	leave
	pop rbx
	inc rax
	ret
