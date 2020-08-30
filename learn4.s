
.section .data
	input: .space 20
	integer_print: .asciz "%d\n"

.section .bss
	.macro SCAN_TEXT input
		mov $0, %rax
		mov $0, %rdi
		mov \input\(), %rsi
		mov $20, %rdx
		syscallm
	.endm

	.macro PRINT input_string
		mov $1, %rax # write 함수 출력을 위한 rax 설정
		mov $1, %rdi # stdout으로 설정
		mov \input_string\(), %rsi # 출력할 것 설정
		mov $20, %rdx
		syscall # syscall과 동일
	.endm

	.macro EXIT
		mov $60, %rax # exit함수
		xor %rdi, %rdi # 0으로 변경
		syscall
	.endm

.section .text
.global start
start:
	SCAN_TEXT $input
	PRINT $input
	EXIT