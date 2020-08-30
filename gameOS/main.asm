[org 0x7C00]
[bits 16]

read:
	mov ax, 0x1000
	mov es, ax
	mov bx, 0

	mov ah, 2
	mov al, 1
	mov ch, 0
	mov cl, 2
	mov dh, 0
	mov dl, 0
	int 13h

	jc read

jmp 0x1000:0

jmp $

times 510-($-$$) db 0
dw 0xAA55