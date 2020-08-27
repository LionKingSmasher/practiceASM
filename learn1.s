.global _start

.text
_start:
	mov $1, %rax # 시스템 콜 1은 쓰기를 의미, 다른 의미로 C언어 상에서 write함수를 의미
	mov $1, %rdi # write함수 중에서 1은 출력(stdout)를 의미
	mov $message, %rsi # 문자열의 주소를 출력으로 옮긴다
	mov $13, %rdx # 바이트 크기
	syscall # OS로 쓰기 시작

	mov $60, %rax # 시스템 콜 60은 exit함수를 의미
	xor %rdi, %rdi # xor 연산 같은 경우 자기 자신과 xor할 경우 0이 된다.
	syscall

message:
	.ascii "Hell, World!\n"