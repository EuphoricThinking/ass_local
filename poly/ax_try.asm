global polynomial_degree

polynomial_degree:
	;We have to push 64-bite register at first
	xor ax, ax
	mov dx, 1
	push ax
	pop ax
	sub ax, dx
	ret
	js .left
	jns .right

.left:
	mov rax, 2
	jmp .here

.right:
	mov rax, 8

.here:
	ret


	xor ax, ax
	mov dx, 1
	push ax
	pop ax
	sub ax, dx
	ret
