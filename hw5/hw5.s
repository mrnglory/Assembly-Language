R = 3
C = 3

.data
arr:	.word 11, 12, 13
	.word 21, 22, 23
	.word 31, 32, 33

str0:	.asciz "%3d "
str1:	.asciz "\n"
str2:	.asciz "Before:\n"
str3:	.asciz "After: \n"

	.text
	.align 4
	.global main, printf

main:	save %sp, -96, %sp
	mov %g0, %l0
	mov R-1, %l1
	mov %g0, %l2
	mov C-1, %l3
	set arr, %l6
	arr_s = R*C

/*************** Before ***************/
	set str2, %o0
	call printf
	nop

	mov %g0, %i0
	mov %g0, %i1
inner:	mov %i0, %o0
	mov C, %o1
	call .mul
	nop
	add %o0, %i1, %o0
	sll %o0, 2, %o0
	ld [%l6+%o0], %i2

	set str0, %o0
	mov %i2, %o1
	call printf
	nop

inc_j:	add %i1, 1, %i1
test_j:	cmp %i1, C
	bl inner
	nop

	set str1, %o0
	call printf
	nop

inc_i:	add %i0, 1, %i0
test_i:	cmp %i0, R
	bl test_j
	mov 0, %i1

	set str1, %o0
	call printf
	nop
/*************************************/

/************** Rotate ***************/
while:	cmp %l0, %l1
	bge escape
	nop

	cmp %l2, %l3
	bge escape
	nop

/* prev = arr[rmin+1][cmin]  */
	add %l0, 1, %o0
	mov C, %o1
	call .mul
	nop

	add %o0, %l2, %o0
	sll %o0, 2, %o0
	ld [%l6+%o0], %l4
	/*****************************/
	mov %l2, %i0
for_1:	mov %l0, %o0
	mov C, %o1
	call .mul
	nop
	add %o0, %i0, %o0
	sll %o0, 2, %o0
	ld [%l6+%o0], %l5
	st %l4, [%l6+%o0]
	mov %l5, %l4
inc_1:	inc %i0
test_1:	cmp %i0, %l3
	bl for_1
	nop

	mov %l0, %i0
for_2:	mov %i0, %o0
	mov C, %o1
	call .mul
	nop
	add %o0, %l3, %o0
	sll %o0, 2, %o0
	ld [%l6+%o0], %l5
	st %l4, [%l6+%o0]
	mov %l5, %l4
inc_2:	inc %i0
test_2:	cmp %i0, %l1
	bl for_2
	nop

	mov %l3, %i0
for_3:	mov %l1, %o0
	mov C, %o1
	call .mul
	nop
	add %o0, %i0, %o0

	sll %o0, 2, %o0
	ld [%l6+%o0], %l5
	st %l4, [%l6+%o0]
	mov %l5, %l4
inc_3:	dec %i0
test_3:	cmp %i0, %l2
	bg for_3
	nop

	mov %l1, %i0
for_4:	mov %i0, %o0
	mov C, %o1
	call .mul
	nop
	add %o0, %l2, %o0
	sll %o0, 2, %o0
	ld [%l6+%o0], %l5
	st %l4, [%l6+%o0]
	mov %l5, %l4
inc_4:	dec %i0
test_4:	cmp %i0, %l0
	bg for_4
	nop

	inc %l0
	dec %l1
	inc %l2
	dec %l3

	ba while
	nop
/*************************************/
escape:
/*************** After ***************/
	set str3, %o0
	call printf
	nop

	mov %g0, %i0
	mov %g0, %i1
print:	mov %i0, %o0
	mov C, %o1
	call .mul
	nop
	add %o0, %i1, %o0
	sll %o0, 2, %o0
	ld [%l6+%o0], %i2
	set str0, %o0
	mov %i2, %o1
	call printf
	nop

j_inc:	add %i1, 1, %i1
j_test:	cmp %i1, C
	bl print
	nop

	set str1, %o0
	call printf
	nop

i_inc:	add %i0, 1, %i0
i_test:	cmp %i0, R
	bl j_test
	mov 0, %i1

	set str1, %o0
	call printf
	nop
/*************************************/

exit:	ret
	restore
