	.global main

	.text
main:
	mov $message, %rdi # 메시지의 포인터를 rdi 레지스터에 저장
	call puts # puts 함수
	ret # C로 리턴


.data
message:
	.asciz "Hello World" #asciz는 ascii와 달리 마지막 글자에 자동으로 \0(끝)을 넣어준다.