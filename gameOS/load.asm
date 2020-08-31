org 0x8000

jmp start

draw_ball:
	mov cx, [BALL_X]
	mov dx, [BALL_Y]
	draw_ball_horizontal:
		mov ah, 0x0C
		mov al, 0x0F
		mov bh, 0x00
		int 0x10
		inc cx
		mov ax, cx
		sub ax, [BALL_X]
		cmp ax, [BALL_SIZE]
		jng draw_ball_horizontal
		mov cx, [BALL_X]
		inc dx
		mov ax, dx
		sub ax, [BALL_Y]
		cmp ax, [BALL_SIZE]
		jng draw_ball_horizontal


start:
	mov ah, 0x00
	mov al, 0x13
	int 0x10

	mov ah, 0x0B
	mov bh, 0x00
	mov bl, 0x00
	int 0x10

	mov dx, [BALL_X]
	add dx, 1
	mov [BALL_X], dx

	call draw_ball

jmp $

BALL_X dw 0x0A
BALL_Y dw 0x0A
BALL_SIZE dw 0x04

times 512-($-$$) db 0