! i		%l0
! max	%l1
! min	%l2
! n		%l3
! value	%l4
nums_s = -20

.data
str1:	.asciz "Value?> "
str2:	.asciz "%d"
str3:	.asciz "Max: %d\n"
str4:	.asciz "Min: %d\n"
str5:	.asciz "{%d, %d, %d, %d, %d}\n"
.align	4
.global	main, scanf, printf

main:	save %sp, -128, %sp
		mov 5, %l3					! n = 5
		mov %g0, %l5

arr:	mov 10, %o0
		st %o0, [%fp+nums_s+0]

		mov 20, %o0
		st %o0, [%fp+nums_s+4]

		mov 30, %o0
		st %o0, [%fp+nums_s+8]

		mov 40, %o0
		st %o0, [%fp+nums_s+12]

		mov 50, %o0
		st %o0, [%fp+nums_s+16]

value:	set str1, %o0
		call printf
		nop

		set str2, %o0
		add %fp, -24, %o1
		call scanf
		nop
		ld [%fp-24], %l4

		subcc %l4, 1, %g0
		bne show
		nop

seed:	call time
		mov 0, %o0
		call srand
		nop

		add %fp, nums_s, %l5
		mov 1, %l0				! i = 1	

r_for:	call rand
		nop
		mov %o0, %o0
		mov 100, %o1
		call .rem
		nop
		st %o0, [%l5]
		add %l5, 4, %l5

r_inc:	inc %l0

f_test_r:cmp %l0, %l3
		bl r_for
		nop

show:	set str5, %o0
		ld [%fp+nums_s+0], %o1
		ld [%fp+nums_s+4], %o2
		ld [%fp+nums_s+8], %o3
		ld [%fp+nums_s+12], %o4
		ld [%fp+nums_s+16], %o5
		call printf
		nop

		add %fp, nums_s, %l5	! 포인터
		ld [%l5], %l1			! max = nums[0]
		ld [%l5], %l2			! min = nums[0]

		ba f_test_1
		mov 1, %l0				! i = 1

max_for:add %l5, 4, %l5			! %l5 = %l5 + 4
		ld [%l5], %o0			! load nums[i] to %o0

		cmp %o0, %l1
		ble max_inc
		nop
		mov %o0, %l1

max_inc:inc %l0

f_test_1:cmp %l0, %l3
		bl max_for
		nop

		add %fp, nums_s, %l5
		ba f_test_2
		mov 1, %l0

min_for:add %l5, 4, %l5
		ld [%l5], %o0

		cmp %o0, %l2
		bge min_inc
		nop
		mov %o0, %l2		

min_inc:inc %l0					! i++

f_test_2:cmp %l0, %l3
		bl min_for
		nop

result:	set str3, %o0
		mov %l1, %o1
		call printf
		nop

		set str4, %o0
		mov %l2, %o1
		call printf
		nop

exit:	ret
		restore
