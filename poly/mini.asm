global polynomial_degree

polynomial_degree:
	mov rax, 3
	sub rax, 32
	add rax, 63
	shr rax, 6
	neg rax
	ret

	mov rsi, 64
	neg rsi
	mov rax, 2
	lea rbx, [8 + 2*rsi]
	mov rax, rbx
	ret

	movsxd rdx, [rdi]
	xor rdx, rdx
	mov rax, rdx
	push ax
	pop ax
	ret


	mov rax, [rdi]
	ret
	mov eax, [edi]
	ret
	sub rsp, 4
	mov esp, [edi]
	mov eax, [esp]
	add rsp, 4
	ret
