;
;
;        VACCINE.ASM    vaccine program  for (c) Brain
;
;                       by    Ahn Cheolsoo
;
;                       computer : IBM - PC/XT/AT
;                       language : Microsoft Macro Assembler 5.0
;                       creation : 1988. 6. 10.
;

 drive   equ   0                    ; drive A
 read    equ   2                    ; function number of INT 13h
 write   equ   3                    ; function number of INT 13h
 boot    equ   1                    ; boot sector
 FAT     equ   2                    ; start of FAT
 dir1    equ   6                    ; start of root directory
 dir2    equ   1                    ; sector of side 1 dir

Print    MACRO  string              ; string print function
         mov  dx, offset string
         mov  ah, 9
         int  21h
         ENDM

Cr_Lf    MACRO                      ; carrage return & line feed
         mov  ah, 2
         mov  dl, 0dh
         int  21h
         mov  dl, 0ah
         int  21h
         int  21h
         ENDM

Input    MACRO                      ; character input => AL
         mov  ah, 0ch
         mov  al, 1
         int  21h
         ENDM

Diskio   MACRO  func, side, track, sector, num_sec, address
                                    ; BIOS INT 13h (disk I/O)
         mov  ah, func              ; read or write
         mov  al, num_sec           ; number of sectors
         mov  bx, offset address    ; offset address of buffer
         mov  ch, track             ; track
         mov  cl, sector            ; sector
         mov  dh, side              ; side
         mov  dl, drive             ; drive No (0 = A:,1 = B:)
         int  13h
         ENDM

Data     SEGMENT  AT  0h

         ORG  004ch                 ; original INT 13h vector
 old_off dw   ?                     ;    offset  address
 old_seg dw   ?                     ;    segment address

         ORG  01b4h                 ; interrupt vector of INT 6Dh
 new_off dw   ?
 new_seg dw   ?

         ORG  0413h                 ; BIOS data area
 mem_size dw  ?                     ; (system memory size in KB)

Data     ENDS


Code     SEGMENT

         ASSUME  cs:Code, ds:Code
         ORG  0100h

entry:   jmp  start

 header  db   'VACCINE program  for (c) Brain     '
         db   'by   Ahn Cheolsoo', 0dh, 0ah, 0ah, '$'
 mess1   db   '  System is infected with (c) Brain ---> cured'
         db    0dh, 0ah, '$'
 mess2   db   '  Insert a disk in drive A: and press <Enter>$'
 mess3   db   '  This disk is not infected.',0dh,0ah,0ah,'$'
 mess4   db   '  This disk is infected with (c) Brain',0dh,0ah
         db   '  Processing the infected disk ...'
         db    0dh, 0ah, 0ah, '$'
 mess5   db   '    Test another disk (Y/N) ? $'
 r_error db   '    ***  Disk read error  ***',0dh,0ah,0ah,'$'
 w_error db   '    ***  Disk write error  ***',0dh,0ah,0ah,'$'

 m_save  dw   ?                     ; system memory size save
 vlabel  db   ' (c) Brain '         ; virus volume label
 vside   db   ?                     ; physical sector of virus
 vsector db   ?
 vtrack  db   ?
 buffer1 db   4 * 512 dup(0)        ; disk I/O buffer area
 buffer2 db   3 * 512 dup(0)

start    PROC  NEAR

         mov  ax, cs                ; register setting
         mov  ds, ax
         mov  es, ax
         Print  header              ; print greeting message


         ;  SYSTEM MEMORY CHECK ( VERIFY MEMORY )

         push ds
         mov  ax, data              ; ds = 0000
         mov  ds, ax
         mov  ax, mem_size          ; system memory size in AX

         mov  m_save, ax            ; save AX
         mov  cl, 06                ; segment address
         shl  ax, cl                ;       = (size in KB) X 64
         mov  ds, ax
         mov  ax, ds:[0004]         ; Virus exist in memory ?
         cmp  ax, 1234h
         jnz  system_ok

 system_infected:

         pop  ds
         Print  mess1
         push ds
         xor  ax, ax                ; ds = 0000
         mov  ds, ax
         mov  ax, new_off           ; recover changed interrupt
         mov  old_off, ax           ;                    vector
         mov  ax, new_seg
         mov  old_seg, ax

         mov  ax, m_save            ; current memory size + 7 KB
         add  ax, 07
         mov  mem_size, ax          ; write the changed size

 system_ok:                         ; System is not infected.
         pop  ds


         ;  INVESTIGATION OF DISK

 restart:
         Print  mess2

 get_key:
         Input
         cmp  al, 0dh
         jnz  get_key
         Cr_Lf

         mov  cx, 4
 retry:  push cx
         Diskio  read, 0, 0, boot, 1, buffer1
                                    ; boot sector read
         jnb  read_ok               ; if error,
         mov  ah, 0                 ;  Reset Floppy Disk System
         int  13h
         pop  cx
         loop retry                 ; try 4 times
         Print  r_error
         jmp  restart

 read_ok:
         mov  ax, word ptr [buffer1 + 4]
         cmp  ax, 1234h             ; virus ID code
         jz   re_exam

 not_virus:
         Print  mess3
         jmp  end_of_job

 re_exam:
         mov  ax, word ptr [buffer1 + 10h]
         cmp  ax, 6557h             ; message area examination
         jnz  not_virus

 disk_infected:
         Print  mess4
         mov  al, buffer1[6]        ; location of original
         mov  vside, al             ;          boot sector
         mov  al, buffer1[7]
         mov  vsector, al
         mov  al, buffer1[8]
         mov  vtrack, al


         ;  REPAIR THE BOOT SECTOR

         Diskio  read, vside, vtrack, vsector, 1, buffer1
                                    ; read original boot sector
         jnc  boot_sector_repair    ; if no error, repair boot
         Print  r_error             ;                     sector
         jmp  restart

 boot_sector_repair:
         Diskio  write, 0, 0, boot, 1, buffer1
                                    ; write original boot sector
         jnc  FAT_read              ; if no error, read FAT
         Print  w_error
         jmp  restart


         ; REPAIR THE FAT (File Allocation Table)

 FAT_read:
         Diskio  read, 0, 0, FAT, 4, buffer1
                                    ; FAT read
         jnc  cluster_calc          ; if no error, calculate
         Print  r_error             ;         cluster number
         jmp  restart

 cluster_calc:
         ; convert physical sector to logical sector
         xor  ah, ah
         mov  al, vtrack            ; logical sector =
         shl  ax, 1                 ;  (track X 2 + side) X 9
         xor  dh, dh                ;             + sector -1
         mov  dl, vside
         add  ax, dx
         mov  cl, 9
         mul  cl
         xor  dh, dh
         mov  dl, vsector
         add  ax, dx
         sub  ax, 1

         ; convert logical sector to cluster number
         shr  ax, 1                 ; cluster =
         sub  ax, 4                 ;  (logical sector/2) - 4

         mov  si, offset buffer1
         mov  dl, 3

 FAT_repair:
         push ax
         push dx
         mov  cx, ax
         shl  ax, 1                 ; cluster No X 2
         add  ax, cx                ; cluster No X 3
         test ax, 1                 ; Is it a whole number ?
         pushf                      ; save flag
         shr  ax, 1                 ; cluster No X 1.5
         mov  bx, ax
         mov  ax, [bx + si]         ; location of cluster in FAT
         popf
         jnz  not_whole_no          ; if not whole number, jump

 whole_no:
         and  ax, 0f000h            ; make cluster staus 0
         jmp  repair

 not_whole_no:
         and  ax, 000fh             ; make cluster status 0

 repair:
         mov  [bx + si], ax         ; repair FAT
         mov  [bx + si + 400h], ax  ; repair the copy of FAT
         pop  dx
         pop  ax
         inc  ax                    ; next cluster
         dec  dl
         jnz  FAT_repair

         Diskio  write, 0, 0, FAT, 4, buffer1
                                    ; write the repaired FAT
         jnc  dir_read              ; if no error, repair label
         Print  w_error
         jmp  restart


         ;  REPAIR THE LABEL

 dir_read:
         Diskio  read, 0, 0, dir1, 4, buffer1
                                    ; read the first 4 directory
         jnc  read_dir1             ;                     sector
         Print  r_error
         jmp  restart

 read_dir1:
         Diskio  read, 1, 0, dir2, 3, buffer2
                                    ; read the 2nd 3 directory
         jnc  read_dir2             ;                   sector
         Print  r_error
         jmp  restart

 read_dir2:
         mov  cl, 6ch               ; number of directory entry
         mov  si, 40h               ; third directory entry

 next_entry:
         mov  al, buffer1 [si + 0bh] ; File attribute = 8 ?
         and  al, 8
         cmp  al, 8
         jz   vl_present            ; if label present, jump
         add  si, 20h               ; next directory entry
         dec  cl
         jnz  next_entry
         jmp  end_of_job

 vl_present:
         push si
         mov  cx, 11                ; string length
         add  si, offset buffer1
         mov  di, offset vlabel
         cld
         repe cmpsb                 ; compare volume label with
                                    ;                 (c) Brain
         jcxz match                 ; if match, jump
         pop  si
         jmp  end_of_job

 match:
         pop  si
         mov  buffer1[si], 0e5h     ; delete virus label

         Diskio  write, 0, 0, dir1, 4, buffer1
                                    ; write first 4 dir sector
         jnc  end_of_job
         Print  w_error
         jmp  restart

         Diskio  write, 1, 0, dir2, 3, buffer2
                                    ; write second 3 dir sector
         jnc  end_of_job
         Print  w_error
         jmp  restart


         ;  END OF JOB

 end_of_job:
         Print  mess5               ; examine another disk ?
         Input
         push ax
         Cr_Lf
         pop  ax
         cmp  al, 'Y'
         je   re
         cmp  al, 'y'
         je   re
         jmp  exit

 re:     jmp  restart

 exit:   int  20h                   ; program temination

start    ENDP

Code     ENDS

         END  entry
