.section ".text"
str1:	.asciz "Value?> "
str2:	.asciz "%d"
str3:	.asciz "mod 3 = %d\n"
.align	4
.global	main, scanf, printf

main:	save %sp, -96, %sp
		mov %g0, %l0

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

mod_0:	subcc %l1, 0, %g0	! if b != 0
		bne mod_1			! jump to "mod_1" label
		nop

		ba result			! if b == 0, print result of it
		nop

mod_1:	subcc %l1, 1, %g0
		bne mod_2

		ba result
		nop

mod_2:	subcc %l1, 2, %g0
		bne result
		nop

result:	set str3, %o0
		mov %l1, %o1
		call printf
		nop

exit:	ret
		restore
