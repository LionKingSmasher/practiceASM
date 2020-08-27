              on          equ      1
              beep        equ      7
              lf          equ     10
              cr          equ     13
              dir_size    equ     20h
              abs_read    equ     25h
              abs_write   equ     26h
              dos_call    equ     21h
              max_dir     equ     112
              fat_id      equ    0fdh

code          segment
              assume cs:code,ds:code

              org 100h
       start:
              jmp ram_kill
              brain_sw    db       1   dup(0)
              brain_off   dw       1   dup(0)
              brain_seg   dw       1   dup(0)
              bad_clust   dw       1   dup(0)
              drive       db       1   dup(0)
              msg         db       1   dup(0)
              buffer      db  512*12   dup(0)

ram_kill      proc near
              mov  ah,9
              mov  dx,offset message1
              int  dos_call
              mov  bx,cs
              shr  bx,1
next_segment: shl  bx,1
              mov  es,bx
              mov  di,0
              mov  cx,8020h
    next_ram: mov  dl,es:[di]
              cmp  dl,0c6h
              jne  check2
              push si
              push cx
              push di
              inc  di
              mov  si,offset brain_m
              mov  cx,30
  next_check: mov  dl,es:[di]
              cmp  dl,cs:[si]
              jne  check1
              inc  di
              inc  si
              loop next_check
              dec  di
              mov  ax,es
              mov  cs:brain_sw,on
              mov  cs:brain_seg,ax
              mov  cs:brain_off,di
              mov  byte ptr es:[di],0ceh
              add  di,53h
              mov  byte ptr es:[di],0ebh
              mov  ah,9
              mov  dx,offset message2
              int  dos_call
              jmp  disk_kill

      check1: pop  di
              pop  cx
              pop  si
      check2: inc  di
              loop next_ram
              push bx
              mov  ah,2
              mov  dl,'.'
              int  dos_call
              add  bx,800h
              shr  bx,1
              cmp  bx,7800h
              jl   next_segment
              mov  ah,9
              mov  dx,offset message3
              int  dos_call
ram_kill      endp

disk_kill     proc near
              mov  ah,9
              mov  dx,offset message4
              int  dos_call
              mov  ah,1
              int  dos_call
              cmp  al,'A'
              je   keya
              cmp  al,'a'
              je   keya
              cmp  al,'B'
              je   keyb
              cmp  al,'b'
              je   keyb
              cmp  al,' '
              jne  disk_kill
              mov  al,cs:drive
              inc  al
              and  al,1
              mov  cs:drive,al
              jmp  disk_reading
        keyb: mov  byte ptr cs:drive,1
              jmp  disk_reading
        keya: mov  byte ptr cs:drive,0

disk_reading: mov  al,cs:drive
              mov  bx,offset buffer
              mov  cx,12
              mov  dx,0
              int  abs_read
              jnc  id_checking
              mov  ah,9
              mov  dx,offset message8
              int  dos_call
              jmp  disk_kill

 id_checking: mov  dl,buffer[200h]
              cmp  dl,fat_id
              jne  disk_kill

erase_volume: mov  bx,0a00h
              mov  cx,max_dir
              mov  di,0
    next_dir: mov  dl,cs:buffer[bx]
              cmp  dl,cs:volume[di]
              jne  dir4
              push bx
              push cx
              push di
              mov  cx,12
        dir1: mov  dl,cs:buffer[bx]
              cmp  dl,cs:volume[di]
              jne  dir3
              inc  bx
              inc  di
              loop dir1
              pop  di
              pop  cx
              pop  bx
              mov  di,0
              mov  cx,12
        dir2: mov  dl,cs:doctor[di]
              mov  cs:buffer[bx],dl
              inc  bx
              inc  di
              loop dir2
              jmp  brain_check
        dir3: pop  di
              pop  cx
              pop  bx
        dir4: add  bx,dir_size
              loop next_dir

 brain_check: mov  si,0
              mov  cx,10
   next_char: mov  dl,cs:buffer[si+150h]
              cmp  dl,cs:brain_d[si]
              jne  no_brain
              inc  si
              loop next_char
              jmp  fat_recover
    no_brain: mov  byte ptr cs:msg,1
              jmp  protect

 fat_recover: mov  bh,cs:buffer[8]
              mov  cl,9
              mov  ah,0
              mov  al,bh
              mul  cl
              mov  bh,0
              mov  bl,cs:buffer[7]
              mov  bl,cs:sector[bx]
              add  ax,bx
              mov  cs:bad_clust,ax
              and  al,11111110b
              sub  ax,4
              mov  cx,2
              mov  dx,0
              div  cx
              mov  cx,3
              mul  cx
              mov  bx,offset buffer+200h
              add  bx,ax
              mov  cx,cs:bad_clust
              and  cx,1
              cmp  cx,1
              jnz  n_even
       n_odd: mov  ax,cs:[bx+4]
              cmp  ax,0ff7fh
              jne  ipl_recover
              mov  ax,cs:[bx+2]
              cmp  ax,0f7ffh
              jne  ipl_recover
              mov  al,cs:[bx+1]
              mov  ah,al
              and  al,0f0h
              cmp  al,70h
              jne  ipl_recover
              and  ah,0fh
              mov  cs:[bx+1],ah
              mov  cs:[bx+401h],ah
              mov  ax,0
              mov  cs:[bx+2],ax
              mov  cs:[bx+402h],ax
              mov  cs:[bx+4],ax
              mov  cs:[bx+404h],ax
              jmp  ipl_recover
      n_even: mov  ax,cs:[bx]
              cmp  ax,7ff7h
              jne  ipl_recover
              mov  ax,cs:[bx+2]
              cmp  ax,0f7ffh
              jne  ipl_recover
              mov  al,cs:[bx+4]
              mov  ah,al
              and  al,0fh
              cmp  al,0fh
              jne  ipl_recover
              and  ah,0f0h
              mov  cs:[bx+4],ah
              mov  cs:[bx+404h],ah
              mov  ax,0
              mov  cs:[bx+2],ax
              mov  cs:[bx+402h],ax
              mov  cs:[bx],ax
              mov  cs:[bx+400h],ax

 ipl_recover: mov  al,cs:brain_sw
              cmp  al,on
              jne  ipl
              mov  ax,cs:brain_seg
              mov  es,ax
              mov  di,cs:brain_off
              mov  byte ptr es:[di],0beh
              add  di,53h
              mov  byte ptr es:[di],075h

              mov  al,cs:drive
              mov  bx,offset buffer
              mov  cx,1
              mov  dx,0
              int  abs_read

              mov  byte ptr es:[di],0ebh
              sub  di,53h
              mov  byte ptr es:[di],0ceh
              jmp  protect

         ipl: mov  al,cs:drive
              mov  bx,offset buffer
              mov  cx,1
              mov  dx,cs:bad_clust
              add  dx,dx
              int  abs_read

     protect: mov  si,0
              mov  cx,8
next_protect: mov  dl,cs:prote_d[si]
              mov  cs:buffer[si+3],dl
              inc  si
              loop next_protect

disk_writing: mov  al,cs:drive
              mov  bx,offset buffer
              mov  cx,12
              mov  dx,0
              int  abs_write
              jc   wr_error
              mov  ah,9
              mov  dx,offset message7
              cmp  byte ptr cs:msg,1
              jne  ch_msg
              mov  dx,offset message5
              mov  byte ptr cs:msg,0
      ch_msg: int  dos_call
              jmp  disk_kill
    wr_error: mov  ah,9
              mov  dx,offset message6
              int  dos_call
              jmp  disk_kill
disk_kill     endp

              brain_m  db 006h,025h,002h,004h,050h,053h,051h,052h,02eh,088h
                       db 016h,026h,002h,0b9h,004h,000h,051h,0b4h,000h,0cdh
                       db 06dh,072h,015h,0b6h,000h,0b9h,001h,000h,0bbh,0beh
              brain_d  db 08eh,0d8h,08eh,0d0h,0bch,000h,0f0h,0fbh,0a0h,006h
              prote_d  db 001h,034h,012h,000h,005h,008h,000h,001h
              sector   db 0,0,5,1,6,2,7,3,8,4
              volume   db ' (c) Brain ',8
              doctor   db ' Doctor    ',8
              message1 db 'Youil computer  Choi C.L  88/06/14',cr,lf
                       db '(c) Brain Killer Program   ',cr,lf,'$'
              message2 db ' Deleted Brain',cr,lf,'$'
              message3 db ' No Brain',cr,lf,'$'
              message4 db cr,lf,lf,'Insert Diskette in Drive',cr,lf
                       db 'Press enter Drive [ A or B ] : $'
              message5 db cr,lf,'Protected',cr,lf,'$'
              message6 db cr,lf,'Writing error',cr,lf,beep,'$'
              message7 db cr,lf,'Recovered',cr,lf,'$'
              message8 db cr,lf,'Reading error',cr,lf,beep,'$'
code         ends
             end  start
