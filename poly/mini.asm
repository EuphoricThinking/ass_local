global polynomial_degree

polynomial_degree:
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
