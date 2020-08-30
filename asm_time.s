.section .data
	integer_print: .asciz "%d\n"
	time_: .word ?
.section .bss
	.macro GET_TIME input
		mov $201, %rax
		mov \input, %rdi 
	.endm