global smax
global umax

smax:
	cmp 	edi, esi
	cmovg 	eax, edi
	cmovle 	eax, esi
	ret


umax:
	cmp 	edi, esi
	cmova 	eax, edi
	cmovbe 	eax, esi
	ret
