section .data
	Msg db "Test\n"

global test
section .text
test:
	mov edx, 6 ;메시지 길이
	mov ecx, Msg
	mov ebx, 1 ;sys_write
	mov eax, 4 ;system call
	int 0x80
	jmp exit

exit:
	mov eax, 1 ;exit
	int 0x80
