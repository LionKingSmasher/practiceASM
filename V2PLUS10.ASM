;
;
;         VACCINE II plus  -  version 1.0
;
;                 Vaccine program  for Brain virus
;                                      LBC virus
;                                      Jerusalem-B virus
;
;                 by   Ahn Cheolsoo
;
;                 computer : IBM - PC/XT/AT
;                 language : Turbo Assembler 1.0
;                 creation : 1988. 11. 10.
;


;================================================================
;         EQUATES DEFINITION
;================================================================

 CR       EQU   0Dh
 LF       EQU   0Ah
 READ     EQU   2                    ; function number of INT 13h
 WRITE    EQU   3                    ; function number of INT 13h

 BrainID  EQU   1234h
 LBCid    EQU   6845h
 LBChead  EQU   1
 LBCcylin EQU   0
 LBCsect  EQU   3
 JeruFunc EQU   0E0h
 JeruID   EQU   300h


;================================================================
;         MACROS DEFINITION
;================================================================

Print     MACRO  String              ; string print function
          mov  dx, offset String
          mov  ah, 9
          int  21h
          ENDM

Input     MACRO                      ; character input => AL
          mov  ah, 0Ch
          mov  al, 1
          int  21h
          ENDM

DiskIO    MACRO  Func, Head, Cylinder, Sector, No
                                     ; BIOS INT 13h (disk I/O)
          mov  ah, Func              ; READ or WRITE
          mov  al, No                ; number of sectors
          mov  bx, offset Buffer     ; offset address of buffer
          mov  ch, Cylinder          ; cylinder
          mov  cl, Sector            ; sector
          mov  dh, Head              ; head
          mov  dl, Drive             ; drive No
          int  13h
          ENDM


;================================================================
;         DATA SEGMENT
;================================================================

DATA      SEGMENT  AT  0h

          ORG  004Ch                 ; original INT 13h vector
 Int13off dw   ?                     ;    offset  address
 Int13seg dw   ?                     ;    segment address

          ORG  01B4h                 ; vector of INT 6Dh
 BrainOff dw   ?
 BrainSeg dw   ?

          ORG  0413h                 ; BIOS data area
 MemSize  dw  ?                      ; (system memory size in KB)

DATA      ENDS


;================================================================
;         CODE SEGMENT
;================================================================

_TEXT     SEGMENT  WORD  PUBLIC  'CODE'

          ASSUME  cs:_TEXT, ds:_TEXT
          ORG  100h

 Entry:   jmp  Start


;----------------------------------------------------------------
;         Constants & Variables
;----------------------------------------------------------------

 Header   db   LF
   db   'ษอออออออออออออออออออออออออออออออออออออออออออออป', CR, LF
   db   'บ                                             บ', CR, LF
   db   'บ       VACCINE II plus  (Version 1.0)        บ', CR, LF
   db   'บ                                             บ', CR, LF
   db   'บ     (c) Copyright 1989  by Ahn Cheolsoo     บ', CR, LF
   db   'บ                                             บ', CR, LF
   db   'ศอออออออออออออออออออออออออออออออออออออออออออออส', CR, LF
          db   LF, '$'
 Mess1    db   '  Insert a disk in drive and press <Enter>$'
 Mess2    db   CR, LF, LF, '$'
 Mess3    db   ' ---> CURED', CR, LF, LF, '$'
 Mess4    db   '    Test another disk (Y/N) ? $'
 Mess5    db   '  --- protected ---', CR, LF, LF, '$'
 Mess6    db   '  --- Hard disk repaired ---', CR, LF, LF
 Mess7    db   '  You must reboot your system !', CR, LF, '$'
 Mmess1   db   '  System is Safe.', CR, LF, LF, '$'
 Mmess2   db   '  System is infected with Brain VIRUS.', 7, '$'
 Mmess3   db   '  System is infected with LBC VIRUS.', 7, '$'
 Mmess4   db   '  System is infected with Jerusalem-B VIRUS',7,'$'
 Dmess1   db   '  Boot sector is Safe.',CR,LF,LF,'$'
 Dmess2   db   '  Boot sector is infected with Brain VIRUS.',CR,LF
          db   7, '  Processing the infected boot sector$'
 Dmess3   db   '  Boot sector is infected with LBC VIRUS', CR, LF
          db   7, '  Processing the infected boot sector$'
 Dmess4   db   '  Searching Jerusalem-B VIRUS...', CR, LF, LF, '$'
 Dmess5   db   '  No infected files.', CR, LF, LF, '$'
 ErrMess1 db   '    ***  Disk Read Error  ***',CR,LF,LF,'$'
 ErrMess2 db   '    ***  Disk Write Error  ***',CR,LF,LF,'$'
 ErrMess3 db   '  Invalid Boot Sector.', CR, LF, '$'
 ErrMess4 db   '  Cannot repair FAT (Disk contains only 1 FAT)'
          db   CR, LF, '$'
 ErrMess5 db   '  Damaged sector is not in first FAT.'
          db   CR, LF, '$'
 ErrMess6 db   '  Cannot find first partition.', CR, LF, '$'
 ErrMess7 db   '  Type of first partition is not MS-DOS.'
          db   CR, LF, '$'
 HelpMess db   '  To test the disk, specify drive name.'
          db   CR, LF, '$'

 xfcb1    db  0FFh
          db  5 dup (0)
          db  8
          db  ?
          db  11 dup ('?')
          db  25 dup (0)
 xfcb2    db  0FFh
          db  5 dup (0)
          db  8
          db  ?
          db  11 dup ('?')
          db  5 dup (0)
          db  'PROTECTED  '
          db  14 dup (0)

 Blabel    db ' (c) Brain '
 Bhead     db   ?
 Bsector   db   ?
 Bcylin    db   ?

 LBCoff    dw   ?
 LBCseg    dw   ?

 JeruSig   db   'MsDos'

 TableSize dw   ?
 BootSize  dw   ?
 FATsize   dw   ?
 SectorNo  db   ?
 HeadNo    db   ?
 SecondFAT dw   ?
 CurDrive  db   ?
 CurDir    db   64 dup (0)
 Root      db   '\', 0
 Parent    db   '..', 0
 COM       db   '*.COM', 0
 EXE       db   '*.EXE', 0
 DirName   db   '*.*', 0
 DirLevel  dw   32 dup (?)

 Drive     db   ?
 Handle    dw   ?
 Attr      dw   ?
 Time      dw   ?
 Date      dw   ?
 FSize     dw   ?
 Lpointer  dw   ?
 Hpointer  dw   ?
 Bseg      dw   ?
 Fhigh     dw   ?
 Flow      dw   ?
 Shigh     dw   ?
 Slow      dw   ?

 InfFlag   db   0
 JeruBFlag db   0
 InfEXE    db   0
 Buffer    db   4 * 512 dup(0)       ; disk I/O buffer area


 ;---------------------------------------------------------------
 ;        Main program starts here.
 ;---------------------------------------------------------------

 Start:   mov  sp, offset StackSpace
          mov  bx, sp
          add  bx, 0Fh
          mov  cl, 4
          shr  bx, cl
          mov  ah, 4Ah
          int  21h

          Print  Header              ; print Title Message


 ;---------------------------------------------------------------
 ;        Check System Memory
 ;---------------------------------------------------------------

          call CheckBrainInMemory
          call CheckLBCInMemory
          call CheckBrainInMemory

          call CheckJeruBInMemory

          cmp  InfFlag, 0
          jnz  CheckArg
          Print  Mmess1


 ;---------------------------------------------------------------
 ;        Check Argument
 ;---------------------------------------------------------------

 CheckArg:
          mov  al, ds:[80h]
          cmp  al, 0
          jz   Help
          mov  al, ds:[5Ch]
          jz   Help
          dec  al
          cmp  al, 2
          jb   Floppy
          add  al, 7Eh
 Floppy:  mov  Drive, al
          jmp  CheckDisk

 Help:    Print  HelpMess
          cmp  InfFlag, 0
          jz   NoInf
          Print  Mess7
 NoInf:   jmp  Exit


 ;---------------------------------------------------------------
 ;        Check Disk
 ;---------------------------------------------------------------

 CheckDisk:
          cmp  Drive, 1
          ja   CheckHard

 CheckFloppy:
          call CheckFloppyBoot

 CheckHard:
          cmp  Drive, 80h
          jne  CheckJeruB
          call CheckHardBoot

 CheckJeruB:
          Print  Dmess4

          mov  JeruBFlag, 0

          mov  di, offset DirLevel
          mov  bp, di
          mov  ax, 0101h
          mov  cx, 32
          rep  stosw

          cmp  Drive, 80h
          jb   FDrive
          sub  Drive, 7Eh

 FDrive:  mov  ah, 19h               ; Get current disk
          int  21h
          mov  CurDrive, al

          mov  ah, 47h               ; Get current directory
          mov  dl, CurDrive
          inc  dl
          mov  si, offset CurDir
          int  21h

          mov  ah, 0Eh               ; Select disk
          mov  dl, Drive
          int  21h

          mov  ah, 3Bh               ; Set current directory
          mov  dx, offset Root
          int  21h

 FirstFile:
          mov  ah, 0Bh               ; Check input status
          int  21h
          cmp  al, 0
          jz   FindCOM
          jmp  RecoverDD

 FindCOM: mov  ah, 4Eh               ; Find first file
          xor  cx, cx
          mov  dx, offset COM
          int  21h
          jc   FindEXE
          call CheckJeruBInCOM

 NextCOM: mov  ah, 4Fh
          int  21h
          jc   FindEXE
          call CheckJeruBInCOM
          jmp  NextCOM

 FindEXE: mov  ah, 4Eh               ; Find first file
          xor  cx, cx
          mov  dx, offset EXE
          int  21h
          jc   FirstDir
          call CheckJeruBInEXE

 NextEXE: mov  ah, 4Fh
          int  21h
          jc   FirstDir
          call CheckJeruBInEXE
          jmp  NextEXE

 ParentDir:
          cmp  bp, offset DirLevel
          jnz  Continue
          jmp  RecoverDD

 Continue:
          mov  dx, offset Parent
          mov  ah, 3Bh
          int  21h
          mov  byte ptr ds:[bp], 1
          dec  bp

 FirstDir:
          xor  bl, bl
          mov  dx, offset DirName
          mov  cx, 10h
          mov  ah, 4Eh
          int  21h
          jc   ParentDir

 CkDir:   cmp  byte ptr ds:[80h + 15h], 10h
          jnz  NextDir
          cmp  byte ptr ds:[80h + 1Eh], '.'
          jz   NextDir
          inc  bl
          cmp  bl, ds:[bp]
          jnz  NextDir
          inc  byte ptr ds:[bp]
          mov  dx, 80h + 1Eh
          mov  ah, 3Bh
          int  21h
          inc  bp
          jmp  FirstFile

 NextDir: mov  ah, 4Fh
          int  21h
          jc   ParentDir
          jmp  CkDir

 RecoverDD:
          mov  ah, 0Eh
          mov  dl, CurDrive
          int  21h

          mov  ah, 3Bh
          mov  dx, offset Root
          int  21h

          mov  ah, 3Bh
          mov  dx, offset CurDir
          int  21h

          cmp  JeruBFlag, 0
          jnz  CheckD
          Print  Dmess5

 CheckD:  cmp  Drive, 1
          ja   CheckFlag

          Print  Mess4              ; examine another disk ?
          Input
          push ax
          Print  Mess2
          pop  ax
          cmp  al, 'y'
          jne  CheckCapital
          jmp  CheckFloppy
 CheckCapital:
          cmp  al, 'Y'
          jne  CheckFlag
          jmp  CheckFloppy
 CheckFlag:
          cmp  InfFlag, 0
          jz   Exit
          Print  Mess7

 Exit:    xor  al, al
 Quit:    mov  ah, 4Ch
          int  21h

 ;---------------------------------------------------------------

 CheckBrainInMemory  PROC  near

          push es
          xor  ax, ax
          mov  es, ax

          mov  ax, es:MemSize        ; system memory size in AX
          mov  cl, 6                 ; segment address
          shl  ax, cl                ;       = (size in KB) X 64
          push ds
          mov  ds, ax
          mov  ax, ds:[0004]         ; Brain virus in memory ?
          pop  ds
          cmp  ax, BrainID
          jnz  ExitCheckBrain

          Print  Mmess2

          inc  InfFlag

          mov  ax, es:BrainOff       ; recover changed vector
          mov  es:Int13off, ax
          mov  ax, es:BrainSeg
          mov  es:Int13seg, ax

          add  es:MemSize, 7

          Print  Mess3

 ExitCheckBrain:
          pop  es
          ret

 CheckBrainInMemory  ENDP

 ;---------------------------------------------------------------

 CheckLBCInMemory    PROC  near

          push es
          xor  ax, ax
          mov  es, ax

          mov  ax, es:MemSize        ; system memory size in AX
          mov  cl, 6                 ; segment address
          shl  ax, cl                ;       = (size in KB) X 64
          push ds
          mov  ds, ax
          mov  ax, ds:[0106h]        ; LBC virus in memory ?
          cmp  ax, LBCid
          jnz  ExitCheckLBC

          inc  cs:InfFlag

          mov  ax, ds:[0178h]
          mov  es:Int13off, ax
          mov  ax, ds:[017Ah]
          mov  es:Int13seg, ax

          inc  es:MemSize
          inc  es:MemSize

          push cs
          pop  ds
          Print  Mmess3
          Print  Mess3

 ExitCheckLBC:
          pop  ds
          pop  es
          ret

 CheckLBCInMemory  ENDP

 ;---------------------------------------------------------------

 CheckFloppyBoot  PROC near

          Print  Mess1

 GetKey:  Input
          cmp  al, CR
          jnz  GetKey
          Print  Mess2

          ;  Read boot sector

 ReadBootRecord:
          mov  cx, 4
 Retry:   push cx
          DiskIO  READ, 0, 0, 1, 1
          jnc  LBCexam
          mov  ah, 0
          int  13h
          pop  cx
          loop Retry
          Print  ErrMess1
          jmp  CheckFloppyBoot

          ;  Test LBC virus

 LBCexam: pop  cx
          cmp  word ptr Buffer[6], LBCid
          jnz  BrainExam
          cmp  word ptr Buffer[1FEh], 0AA55h
          jz   NoVirus
          jmp  LBCinDisk

          ;  Test Brain virus

 BrainExam:
          cmp  word ptr Buffer[4], BrainID
          jnz  NoVirus
          cmp  word ptr Buffer[1FEh], 0AA55h
          jnz  BrainInDisk

          ;  Protect floppy disk from Brain & LBC virus

 NoVirus: Print  Dmess1
          cmp  word ptr Buffer[4], BrainID
          jnz  Protect
          cmp  word ptr Buffer[6], LBCid
          jnz  Protect
          ret

 Protect: mov  word ptr Buffer[4], BrainID
          mov  word ptr Buffer[6], LBCid
          DiskIO  WRITE, 0, 0, 1, 1
          jnc  WriteOK
          Print  ErrMess2
          jmp  CheckFloppyBoot

 WriteOK: Print  Mess5
          ret

          ;  CURE THE BRAIN VIRUS

 BrainInDisk:
          Print  Dmess2
          mov  al, Buffer[6]         ; location of original
          mov  Bhead, al             ;          boot sector
          mov  al, Buffer[7]
          mov  Bsector, al
          mov  al, Buffer[8]
          mov  Bcylin, al

          ;  Repair the boot sector

          DiskIO READ, Bhead, Bcylin, Bsector, 1
                                     ; read original boot sector
          jnc  RepairBoot            ; if no error, repair boot
          Print  ErrMess1            ;                   sector
          jmp  CheckFloppyBoot

 RepairBoot:
          DiskIO  WRITE, 0, 0, 1, 1  ; write original boot sector
          jnc  ReadFAT               ; if no error, READ FAT
          Print  ErrMess2
          jmp  CheckFloppyBoot

          ; Repair the FAT (File Allocation Table)

 ReadFAT: DiskIO  READ, 0, 0, 2, 4   ; FAT read
          jnc  CalcCluster           ; if no error, calculate
          Print  ErrMess1            ;         cluster number
          jmp  CheckFloppyBoot

          ;  Convert physical sector to logical sector

 CalcCluster:
          xor  ah, ah
          mov  al, Bcylin            ; logical sector =
          shl  ax, 1                 ;  (Cylinder X 2 + head) X 9
          xor  dh, dh                ;             + sector -1
          mov  dl, Bhead
          add  ax, dx
          mov  cl, 9
          mul  cl
          xor  dh, dh
          mov  dl, Bsector
          add  ax, dx
          sub  ax, 1

          ;  Convert logical sector to cluster number

          shr  ax, 1                 ; cluster =
          sub  ax, 4                 ;  (logical sector/2) - 4

          mov  si, offset Buffer
          mov  dl, 3

 RepairFAT:
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
          jnz  NoWholeNum            ; if not whole number, jump

          and  ax, 0F000h            ; make cluster staus 0
          jmp  BadToGood

 NoWholeNum:
          and  ax, 000Fh             ; make cluster status 0

 BadToGood:
          mov  [bx + si], ax         ; repair FAT
          mov  [bx + si + 400h], ax  ; repair the copy of FAT
          pop  dx
          pop  ax
          inc  ax                    ; next cluster
          dec  dl
          jnz  RepairFAT

          DiskIO  WRITE, 0, 0, 2, 4  ; write the repaired FAT
          jnc  ReadDir               ; if no error, repair label
          Print  ErrMess2
          jmp  CheckFloppyBoot

          ;  Repair the volume label

 ReadDir: mov  ah, Drive
          inc  ah
          mov  xfcb1[7], ah
          mov  xfcb2[7], ah
          mov  dx, offset xfcb1
          mov  ah, 11h
          int  21h
          or   al, al
          jne  NoLabel

          mov  cx, 11
          mov  si, 88h
          mov  di, offset Blabel
          cld
          repe cmpsb
          jcxz BrainLabel
          jmp  NoLabel

 BrainLabel:
          mov  ah, 17h
          mov  dx, offset xfcb2
          int  21h

 NoLabel: Print  Mess3

          DiskIO  READ, 0, 0, 1, 1
          jnc  ReExamBoot
          Print  ErrMess1
          jmp  CheckFloppyBoot

 ReExamBoot:
          cmp  word ptr Buffer[01FEh], 0AA55h
          jz   NormBoot
          Print  ErrMess3
          mov  al, 3
          jmp  Quit

 NormBoot:
          jmp  Protect

          ;  CURE THE LBC VIRUS

 LBCinDisk:
          Print  Dmess3
          DiskIO  READ, LBChead, LBCcylin, LBCsect, 1
          jnc  KillLBC
          Print  ErrMess1
          jmp  CheckFloppyBoot

 KillLBC: DiskIO  WRITE, 0, 0, 1, 1  ; write original boot sector
          jnc  ClearSector
          Print  ErrMess2
          jmp  CheckFloppyBoot

 ClearSector:
          cld
          mov  ax, 0
          mov  cx, 256
          mov  di, offset Buffer
          rep  stosw

          DiskIO  WRITE, LBChead, LBCcylin, LBCsect, 1
          jnc  CureLBC
          Print  ErrMess2
          jmp  CheckFloppyBoot

 CureLBC: Print  Mess3

          DiskIO  READ, 0, 0, 1, 1
          jnc  ReTestBoot
          Print  ErrMess1
          jmp  CheckFloppyBoot

 ReTestBoot:
          cmp  word ptr Buffer[01FEh], 0AA55h
          jz   NoErr
          cmp  word ptr Buffer[4], BrainID
          jnz  BadBoot
          jmp  BrainInDisk

 BadBoot: Print  ErrMess3
          mov  al, 3
          jmp  Quit

 NoErr:   jmp  Protect

 CheckFloppyBoot  ENDP

 ;---------------------------------------------------------------

 CheckHardBoot  PROC  near

           DiskIO  READ, 0, 0, 1, 1
           jnc  HardOK
           Print  ErrMess1
           mov  al, 1
           jmp  Quit

 HardOK:   cmp  word ptr Buffer[6], 6845h
           jz   Infected
           cmp  word ptr Buffer[01FEh], 0AA55h
           jz   BootOK
           Print  ErrMess3
           ret

 BootOK:   Print  Dmess1
           ret

           ;  Read the partition table

 Infected: Print  Dmess3
           Print  Mess2

           DiskIO  READ, LBChead, LBCcylin, LBCsect, 1

           cmp  word ptr Buffer[01FEh], 0AA55h
           jz   RepairPT
           Print  ErrMess3
           mov  al, 3
           jmp  Quit

           ; Repair the partition table

 RepairPT: DiskIO  WRITE, 0, 0, 1, 1

           ;  Repair the damaged FAT

           DiskIO  READ, 0, 0, 1, 1

           mov  bx, offset Buffer + 1AEh
 NextPart: add  bx, 10h
           cmp  bx, offset Buffer + 200h
           jb   InTable
           Print  ErrMess6
           mov  al, 7
           jmp  Quit
 InTable:  mov  ax, [bx + 2]
           and  ax, 1111111111000000b
           cmp  ax, 0
           jnz  NextPart
           cmp  word ptr [bx + 0Eh], 0
           jnz  NextPart
           cmp  word ptr [bx + 0Ch], 0
           jz   NextPart

           cmp  byte ptr [bx + 4], 1
           jz   ReadBoot
           cmp  byte ptr [bx + 4], 4
           jz   ReadBoot
           cmp  byte ptr [bx + 4], 6
           jz   ReadBoot
           Print  ErrMess7
           mov  al, 8
           jmp  Quit

 ReadBoot: mov  ax, [bx + 8]
           mov  TableSize, ax

           mov  cx, [bx + 2]
           mov  dh, [bx + 1]
           mov  ah, READ
           mov  al, 1
           mov  bx, offset Buffer
           mov  dl, Drive
           int  13h

           mov  bx, offset Buffer
           mov  al, [bx + 10h]
           cmp  al, 2
           jae  FATexist
           Print  ErrMess4
           mov  al, 5
           jmp  Quit

 FATexist: mov  ax, word ptr [bx + 0Eh]
           mov  BootSize, ax
           mov  ax, word ptr [bx + 16h]
           mov  FATsize, ax

           mov  ah, 8
           mov  dl, 80h
           int  13h
           and  cl, 00111111b
           mov  SectorNo, cl
           inc  dh
           mov  HeadNo, dh

           mov  si, TableSize
           add  si, BootSize
           mov  di, si
           add  di, FATsize

           mov  al, SectorNo
           add  al, 2

           cmp  ax, si
           jb   OutFAT
           cmp  ax, di
           jb   InFAT
 OutFAT:   Print  ErrMess5
           mov  al, 6
           jmp  Quit

 InFAT:    sub  ax, si
           add  ax, di
           mov  SecondFAT, ax

           div  SectorNo
           inc  ah
           mov  cl, ah

           mov  ax, SecondFAT
           div  SectorNo
           xor  ah, ah
           div  HeadNo
           mov  ch, al
           mov  dh, ah

           mov  ah, READ
           mov  al, 1
           mov  bx, offset Buffer
           mov  dl, Drive
           int  13h

           DiskIO  WRITE, LBChead, LBCcylin, LBCsect, 1

           Print  Mess6

           jmp  Exit

 CheckHardBoot  ENDP

 ;---------------------------------------------------------------

 CheckJeruBInMemory  PROC  near

         mov  ah, JeruFunc
         int  21h
         cmp  ax, JeruID
         jnz  ExitCheckJeruB

         Print  Mmess4

         push ds
         push es
         inc  InfFlag

         mov  ax, 3521h
         int  21h

         mov  ah, 2Ah
         int  21h
         cmp  cx, 07C3h
         jz   Reset21h
         cmp  al, 5
         jnz  Reset08h
         cmp  dl, 0Dh
         jnz  Reset08h
         jmp  Reset21h

 Reset08h:
         mov  ax, 2508h
         lds  dx, es:[13h]
         int  21h

 Reset21h:
         mov  ax, 2521h
         lds  dx, es:[17h]
         int  21h

         mov  ax, es
         sub  ax, 10h
         mov  es, ax
         mov  ah, 49h
         int  21h

         ASSUME  es:_TEXT
         pop  es
         pop  ds
         Print  Mess3

 ExitCheckJeruB:
         ret

 CheckJeruBInMemory  ENDP

 ;---------------------------------------------------------------

 CheckJeruBInCOM  PROC  near

        mov  ax, 3D02h                 ; open file
        mov  dx, 80h +  1Eh
        int  21h
        mov  Handle, ax
        mov  bx, ax

        mov  ax, 4200h                 ; set file pointer
        xor  cx, cx
        mov  dx, 5                     ; offset from start
        int  21h

        mov  ah, 3Fh                   ; read file
        mov  cx, 5
        mov  dx, offset buffer
        int  21h

        mov  si, offset buffer         ; Is it 'MsDos' ?
        mov  di, offset JeruSig
        mov  cx, 5
        repz cmpsb
        jz   JeruBInCOM
        jmp  ExitJeruBInCOM

        ;-------------------------------------------------------

 JeruBInCOM:
        mov  JeruBFlag, 1

        mov  ah, 2
        mov  dl, ' '
        int  21h
        int  21h

        mov  bx, 80h + 1Eh
 PrintChar:
        mov  dl, [bx]
        cmp  dl, 0
        jz   StartTxCOM
        mov  ah, 2
        int  21h
        inc  bx
        jmp  PrintChar

 StartTxCOM:
        mov  ax, 4300h                 ; get attribute
        mov  dx, 80h + 1Eh
        int  21h
        mov  Attr, cx

        mov  ax, 4301h                 ; set attribute
        xor  cx, cx
        int  21h

        mov  ax, 5700h                 ; get date & time
        mov  bx, Handle
        int  21h
        mov  Time, cx
        mov  Date, dx

        mov  ax, 4202h
        xor  cx, cx
        xor  dx, dx
        int  21h
        mov  FSize, ax

        mov  ax, 4200h                 ; set file pointer
        xor  cx, cx
        mov  dx, 710h
        int  21h

        push es
        mov  ah, 48h                   ; allocate memory block
        mov  bx, 1000h
        int  21h
        mov  es, ax

        mov  bx, Handle                ; read file
        mov  cx, FSize
        sub  cx, 715h
        push ds
        push es
        pop  ds
        mov  ah, 3Fh
        xor  dx, dx
        int  21h
        pop  ds

        mov  ah, 3Ch                   ; create file
        mov  cx, 0
        mov  dx, 80h + 1Eh
        int  21h
        mov  bx, ax

        mov  ah, 40h                   ; write file
        mov  cx, FSize
        sub  cx, 715h
        push ds
        push es
        pop  ds
        xor  dx, dx
        int  21h
        pop  ds

        mov  ah, 49h                   ; release memory
        int  21h
        pop  es

        mov  ax, 5701h                 ; set date & time
        mov  cx, Time
        mov  dx, Date
        int  21h

        mov  ax, 4301h
        mov  cx, Attr
        mov  dx, 80h + 1Eh
        int  21h

        Print  Mess3

 ExitJeruBInCOM:
        mov  ah, 3Eh                   ; close file
        int  21h
        ret

 CheckJeruBInCOM  ENDP

 ;---------------------------------------------------------------

 CheckJeruBInEXE  PROC  near

        mov  InfEXE, 0

        mov  ax, 3D00h                 ; open file
        mov  dx, 80h + 1Eh
        int  21h
        mov  Handle, ax
        mov  bx, ax

        mov  ax, 4202h                 ; get file size
        xor  cx, cx
        xor  dx, dx
        int  21h
        mov  Lpointer, ax
        mov  Hpointer, dx

 ReExam:
        cmp  ax, 710h                  ; file size > 710h ?
        jbe  ExamFlag

        sub  ax, 710h                  ; file size - 710h
        sbb  dx, 0

        mov  cx, dx                    ; set file pointer
        mov  dx, ax
        mov  ax, 4200h
        int  21h

        mov  ah, 3Fh                   ; read file
        mov  cx, 100h
        mov  dx, offset Buffer
        int  21h

        mov  si, offset Buffer + 5     ; Is it 'MsDos' ?
        mov  di, offset JeruSig
        mov  cx, 5
        repz cmpsb
        jz   JeruBInfected

 ExamFlag:                             ; infected ?
        cmp  InfEXE, 1
        jz   JeruBInEXE
        jmp  ExitJeruBInEXE

 JeruBInfected:                        ; next position
        mov  InfEXE, 1
        sub  Lpointer, 710h
        sbb  Hpointer, 0
        mov  ax, Lpointer
        mov  dx, Hpointer
        jmp  ReExam

        ;-------------------------------------------------------

 JeruBInEXE:
        mov  JeruBFlag, 1

        mov  ah, 2
        mov  dl, ' '
        int  21h
        int  21h

        mov  bx, 80h + 1Eh
 PrintCh:
        mov  dl, [bx]
        cmp  dl, 0
        jz   StartTxEXE
        mov  ah, 2
        int  21h
        inc  bx
        jmp  PrintCh

 StartTxEXE:
        mov  ax, 4300h                 ; get attribute
        mov  dx, 80h + 1Eh
        int  21h
        mov  Attr, cx

        mov  ax, 4301h                 ; set attribute
        xor  cx, cx
        int  21h

        mov  ax, 5700h                 ; get date & time
        mov  bx, Handle
        int  21h
        mov  Time, cx
        mov  Date, dx

        push es
        mov  dx, Hpointer
        mov  ax, Lpointer
        mov  cx, 10h
        div  cx
        mov  bx, ax
        mov  ah, 48h                   ; allocate memory block
        int  21h
        mov  es, ax

        mov  Bseg, es
        mov  Fhigh, 0
        mov  Flow, 0
        mov  ax, Hpointer
        mov  Shigh, ax
        mov  ax, Lpointer
        mov  Slow, ax

        mov  ax, 4200h                 ; set file pointer
        mov  bx, Handle
        mov  cx, Hpointer
        mov  dx, Lpointer
        int  21h

        mov  ah, 3Fh                   ; read file
        mov  cx, 100h
        mov  dx, offset Buffer
        int  21h

        mov  ax, 4200h                 ; set file pointer
        xor  cx, cx
        xor  dx, dx
        int  21h

 Again: cmp  Shigh, 0
        jz   Remainder

        mov  ah, 3Fh                   ; read file
        mov  cx, 0FFF0h
        xor  dx, dx
        mov  ds, Bseg
        int  21h
        push cs
        pop  ds

        add  Bseg, 0FFFh
        add  Flow, 0FFF0h
        adc  Fhigh, 0
        sub  Slow, 0FFF0h
        sbb  Shigh, 0

        mov  ax, 4200h
        mov  cx, Fhigh
        mov  dx, Flow
        int  21h
        jmp  Again

 Remainder:
        mov  ah, 3Fh                   ; read file
        mov  cx, Slow
        mov  dx, dx
        mov  ds, Bseg
        int  21h
        push cs
        pop  ds

        mov  ax, word ptr Buffer[45h]           ; repair header
        mov  es:[0Eh], ax
        mov  ax, word ptr Buffer[43h]
        mov  es:[10h], ax
        mov  ax, word ptr Buffer[47h]
        mov  es:[14h], ax
        mov  ax, word ptr Buffer[49h]
        mov  es:[16h], ax
        mov  dx, Hpointer
        mov  ax, Lpointer
        mov  cx, 512
        div  cx
        cmp  dx, 0
        jz   NoRemain
        inc  ax
 NoRemain:
        mov  es:[4], ax
        mov  es:[2], dx

        mov  ah, 3Ch                   ; create file
        mov  cx, 0
        mov  dx, 80h + 1Eh
        int  21h
        mov  bx, ax

        mov  Bseg, es
        mov  Fhigh, 0
        mov  Flow, 0
        mov  ax, Hpointer
        mov  Shigh, ax
        mov  ax, Lpointer
        mov  Slow, ax

 Again2:
        cmp  Shigh, 0
        jz   NoHigh

        mov  ah, 40h                   ; write file
        mov  cx, 0FFF0h
        xor  dx, dx
        mov  ds, Bseg
        int  21h
        push cs
        pop  ds

        add  Bseg, 0FFFh
        add  Flow, 0FFF0h
        adc  Fhigh, 0
        sub  Slow, 0FFF0h
        sbb  Shigh, 0

        mov  ax, 4200h
        mov  cx, Fhigh
        mov  dx, Flow
        int  21h
        jmp  Again2

 NoHigh:
        mov  ah, 40h                   ; write file
        mov  cx, Slow
        mov  dx, dx
        mov  ds, Bseg
        int  21h
        push cs
        pop  ds

        mov  ah, 49h                   ; release memory
        int  21h
        pop  es

        mov  ax, 5701h                 ; set date & time
        mov  cx, Time
        mov  dx, Date
        int  21h

        mov  ax, 4301h
        mov  cx, Attr
        mov  dx, 80h + 1Eh
        int  21h

        Print  Mess3

 ExitJeruBInEXE:
        mov  ah, 3Eh                   ; close file
        int  21h
        ret

 CheckJeruBInEXE  ENDP

 ;---------------------------------------------------------------

 Parameter      LABEL  BYTE
 StackSpace     EQU    Parameter + 100h

 ;---------------------------------------------------------------

_TEXT      ENDS

           END  Entry



