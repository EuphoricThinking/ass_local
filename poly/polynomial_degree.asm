global polynomial_degree

align 16
polynomial_degree:
	push rbx
	mov rbx, rdi
	mov rcx, rsi
	mov rax, -1

	mov r8, rcx ;additional storage - in bytes
	add r8, 7
	and r8, -8
	sub r8, 32 ;32 bits from 64-bit register
	jns .not_enough
	mov r10, 0 ;no more iterations than one
	mov r8, 0 ;if negative
	jmp .check_zero_init

.not_enough:
	mov r10, r8 ;how many iterations over registers we need
	add r10, 63
	and r10, -64

;odwróć kolejność dodawania elementów
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

.push_and_calculate:
	mov rdx, [rbx + 4]
	movsxd rdx, edx
	sub rdx, [rbx]
	push rdx
	add rbx, 4
	sub rsp, r8

	loop .push_and_calculate

	dec rsi
	mov r9, rsi
	mov rbx, rsp


.check_zero_stack:
	movsxd rdx, [rbx]
	test rdx, rdx
	jnz .check_single
	add rbx, 8
	loop .check_zero_stack

	lea rdx, [rsi*(8 + r8)]
	add rsp, [rdx] ;prawdopodobnie powinien występować tutaj adres
	pop rbx
	ret

.check_single:
	cmp rsi, 0x1
	je .ret_single_element

.before_iterate:
	lea rdx, [rsp + (8 + r8)*(rsi - 1)] ;od pierwszego elementu, żeby łatwiej dodawać na stos
	mov rbx, rdx

	mov r9, rsi ;licznik iteracji po liczbach - po ilu liczbach przeszliśmy
	dec r9

	mov rcx, r10 ;licznik, po ilu komórkach liczby przeszliśmy

.iterate:
	mov rdx, [rbx - 8 - r8] ;next number
	sub rdx, [rbx]
	mov qword [rbx], rdx
	sub rbx, 8
	test rcx, rcx ;czy musimy skoczyć dalej
	jnz .rest_of_a_number
	jz  .next_number

.rest_of_a_number:
	movsxd rdx, [rbx - 8 - r8] ;next number
	sbb rdx, [rbx]
	mov qword [rbx], rdx
	lea rbx, rdx
	dec rcx
	jrcxz .rest_of_a_number
	mov rcx, r10

.next_number:
	dec r9
	jnz .iterate


	inc rax
	dec rsi
	mov r9, rsi
	add rsp, 8
	add rsp, r8
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
