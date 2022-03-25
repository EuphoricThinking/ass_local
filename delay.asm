global delay

align 16
delay:
	mov rcx, rdi
	jrcxz .exit

.looptop:
	loop .looptop


.exit:
	rdtsc
	shl rdx, 0x20
	or rax, rdx

	ret
