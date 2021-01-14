.section ".text"
str1:	.asciz "Value?> "
str2:	.asciz "%d"
str3:	.asciz "mod 3 = %d"
.align	4
.global main, scanf, printf

main:	save %sp, -96, %sp
		mov %g0, %l0		! int a = 0

input:	set str1, %o0		! print "Value?> " for a
		call printf
		nop

		set str2, %o0		! input a
		add %fp, -4, %o1
		call scanf
		nop

		ld [%fp-4], %l0		! return 0 if a <= 0
		subcc %l0, 0, %g0
		ble exit
		nop

		mov %l0, %o0
		mov 3, %o1
		call .urem
		nop
		mov %o0, %l1		! b = a % 3

		subcc %l1, 0, %g0
		be result
		nop

		subcc %l1, 1, %g0
		be result
		nop

		subcc %l1, 2, %g0
		be result
		nop

result:	set str3, %o0
		mov %l1, %o1
		call printf
		nop

exit:	ret
		restore
