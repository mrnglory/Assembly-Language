.text
.global main

main:	save	%sp,	-96,	%sp
	sethi	%hi(str),	%o0
	call	printf
	or	%o0,	%lo(str),	%o0
	ret
	restore

.data
str:	.asciz	"Hello!\n"
.align	4
