.section ".text"
str1:	.asciz "Value?> "
str2:	.asciz "%d"
str3:	.asciz "GCD is %d\n"
.align	4
.global	main, scanf, printf

main:	save %sp, -96, %sp
	mov %g0, %i0		! int t = 0

input:	set str1, %o0
	call printf		! print "Value?> " for a
	nop

	set str2, %o0
	add %fp, -4, %o1
	call scanf		! input a
	nop

	ld [%fp-4], %l0
	subcc %l0, 0, %g0	! return 0 if a <= 0
	ble exit
	nop

	set str1, %o0
	call printf		! print "Value?> " for b
	nop

	set str2, %o0
	add %fp, -8, %o1
	call scanf		! input b
	nop

	ld [%fp-8], %l1
	subcc %l1, 0, %g0	! return 0 if b <= 0
	ble exit
	nop

loop:	subcc %l0, %l1, %g0	! while (a != b)
	be result
	nop

swap:	subcc %l0, %l1, %g0
	bg gcd			! jump to "gcd" label else if a > b
	nop

	mov %l0, %i0		! swap a and b if a < b
	mov %l1, %l0
	mov %i0, %l1

gcd:	sub %l0, %l1, %i0	! t = a - b
	mov %l1, %l0		! a = b
	mov %i0, %l1		! b = t

	ba loop			! 후방분기
	nop

result:	set str3, %o0
	mov %l0, %o1
	call printf		! printing the result
	nop

exit:	ret
	restore
