.global fibo
.text
fibo:
	mov %rdi, %rcx #매개변수에 있는 값을 rcx레지스터로 이동
	mov $0, %rbx # 카운팅
	mov $0, %rdx # Fn_0
#	mov $0, %rax # Fn_2 -> return 값
	jmp start

start:
	inc %rbx
	cmp $1, %rbx #첫번째 루프 상황이라면
	je first #점프
	cmp $2, %rbx #두번째 루프 상황이라면
	je second #점프
	jmp other #그외 점프

first:
	mov $0, %rax
	jmp chk

second:
	mov $1, %r8
	mov $0, %rax
	add %r8, %rax
	mov %r8, %rdx #Fn_0 = Fn_1
#	mov %rdi, %rcx #카운트
	jmp chk

other:
	mov %rax, %r8
	mov $0, %rax
	add %rdx, %rax
	add %r8, %rax
	mov %r8, %rdx
#	mov %rdi, %rcx
	jmp chk

chk:
	loop start
	jmp done

done:
	ret


#.global fibo
#.text
#fibo:
#	mov %rdi, %rcx #매개변수에 있는 값을 rcx레지스터로 이동
#	mov $0, %rbx # 카운팅
#	mov $0, %rdx # Fn_0
#	rcx -> Fn_1 & 루프 변행
#	mov $0, %rax # Fn_2 -> return 값
#	jmp start

#start:
#	inc %rbx
#	cmp $1, %rbx #첫번째 루프 상황이라면
#	je first #점프
#	cmp $2, %rbx #두번째 루프 상황이라면
#	je second #점프
#	jmp other #그외 점프

#first:
#	mov $0, %rax
#	jmp chk

#second:
#	mov $1, %rcx
#	mov $0, %rax
#	add %rcx, %rax
#	mov %rcx, %rdx #Fn_0 = Fn_1
#	mov %rdi, %rcx #카운트
#	jmp chk

#other:
#	mov %rax, %rcx
#	mov $0, %rax
#	add %rdx, %rax
#	add %rcx, %rax
#	mov %rcx, %rdx
#	mov %rdi, %rcx
#	jmp chk

#chk:
#	cmp %rbx, %rcx
#	jne start
#	jmp done

#done:
#	ret
