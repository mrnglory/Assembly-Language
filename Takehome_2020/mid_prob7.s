.section ".text"
str1:	.asciz "Value?> "
str2:	.asciz "%d"
str3:	.asciz "Sum is %d\n"
.align	4
.global	main, scanf, printf

main:	save %sp, -96, %sp
		mov %g0, %i0		! int temp = 0
		mov %g0, %i1		! int sum = 0

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

		set str1, %o0		! print "Value?> " for b
		call printf
		nop

		set str2, %o0		! input b
		add %fp, -8, %o1
		call scanf
		nop

		ld [%fp-8], %l1		! return 0 if b <= 0
		subcc %l1, 0, %g0
		ble exit
		nop

		subcc %l0, %l1, %g0 ! if a > b
		bg swap				! jump to "swap" label
		nop

		subcc %l0, %l1, %g0	! if a <= b
		ble loop			! jump to "loop" label
		nop

swap:	mov %l1, %i0		! b -> temp (temp = b)
		mov %l0, %l1		! a -> b (b = a)
		mov %i0, %l0		! temp -> a (a = temp)

loop:	subcc %l0, %l1, %g0	! if a > b
		bg result			! 루프 이탈
		nop

		add %i1, %l0, %i1	! sum += a
		inc %l0				! a++
		ba loop				! 후방분기
		nop

result:	set str3, %o0		! printing the result
		mov %i1, %o1
		call printf
		nop

exit:	ret
		restore
