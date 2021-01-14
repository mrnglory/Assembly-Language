.section ".text"
str1:	.asciz "Hexadecimal value?> "
str2:	.asciz "%x"
str3:	.asciz "Result is %.8x %.8x"
.align	4
.global	main, scanf, printf

main:	save %sp, -96, %sp

		set str1, %o0
		call printf
		nop

		set str2, %o0
		add %fp, -4, %o1
		call scanf			! input 1st value
		nop
		ld [%fp-4], %l0

		set str1, %o0
		call printf
		nop

		set str2, %o0
		add %fp, -8, %o1
		call scanf			! input 2nd value
		nop
		ld [%fp-8], %l1

		mov %l0, %o0
		mov %l1, %o1
		call .umul			! multiplication 
		nop
		mov %o0, %i0		! $i0 = (1st val * 2nd val) 하위비트 
		mov %o1, %i1		! $i1 = (1st val * 2nd val) 상위비트

		set str1, %o0
		call printf
		nop

		set str2, %o0
		add %fp, -12, %o1
		call scanf			! input 3rd value
		nop
		ld [%fp-12], %l2

		set str1, %o0
		call printf
		nop

		set str2, %o0
		add %fp, -16, %o1
		call scanf			! input 4th value
		nop
		ld [%fp-16], %l3

		mov %l2, %o0
		mov %l3, %o1
		call .umul			! multiplication
		nop
		mov %o0, %i2		! $i2 = (3rd val * 4th val) 하위비트
		mov %o1, %i3		! $i3 = (3rd val * 4th val) 상위비트

		addcc %i0, %i2, %i0	! $i0 = 하위비트끼리 더한 값
		addx %i1, %i3, %i1	! $i1 = 상위비트끼리 더한 값

		set str3, %o0
		mov %i1, %o1
		mov %i0, %o2
		call printf
		nop

exit:	ret
		restore
