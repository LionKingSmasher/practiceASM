.global func
.text
func:
	mov %rdi, %r9
	mov %rdi, %rdx
	mov $0, %rax
	add %rdx, %rax
	add %r9, %rax
	ret