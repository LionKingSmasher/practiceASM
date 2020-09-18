.global sum
.text
sum:
	mov %rdi, %rax #첫번째로 입력받은 매개변수를 rax 레지스터에 넣기
	mov %rsi, %rcx #두번째로 입력받은 매개변수를 rcx 레지스터에 넣어 루프를 위한 시작
	dec %rcx # rcx에 -1을 빼준다
	jmp start

start:
	inc %rdi #rdi 레지스터를 1올린다.
	add %rdi, %rax # 그다음 rax레지스터에 rdi만큼 더하도록 한다.
	loop start #이를 rcx만큼 반복
	ret