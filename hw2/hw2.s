.global	main

main:	save	%sp,	-96,	%sp
	mov	%i0,	%o0
	mov	%i1,	%o1
	call	.rem
	nop
	mov	%o0,	%i0

	sub	%i2,	%i3,	%l0
	add	%i0,	%l0,	%i0

	mov	%i0,	%o0
	mov	12,	%o1
	call	.mul
	nop
	mov	%o0, 	%i0

	add	%i4,	%i5,	%i1
	mov	%i0,	%o0
	mov	%i1,	%o1
	call	.div
	nop

	mov	%o0,	%i0

	ret
	restore
