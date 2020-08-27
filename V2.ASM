;
;
;        VACCINE II     Vaccine program for Brain & LBC Virus
;
;                       by    Ahn Cheolsoo
;
;                       computer : IBM - PC/XT/AT
;                       language : Turbo Assembler 1.0
;                       creation : 1988. 10. 1.
;


;================================================================
;         EQUATES DEFINITION
;================================================================

 CR       EQU   0Dh
 LF       EQU   0Ah
 BrainID  EQU   1234h
 LBCid    EQU   6845h
 READ     EQU   2                    ; function number of INT 13h
 WRITE    EQU   3                    ; function number of INT 13h


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

DiskIO    MACRO  Func, Head, Cylinder, Sector, No, BuffAdd
                                     ; BIOS INT 13h (disk I/O)
          mov  ah, Func              ; READ or WRITE
          mov  al, No                ; number of sectors
          mov  bx, offset BuffAdd    ; offset address of buffer
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
   db   'บ       VACCINE II for Brain & LBC virus      บ', CR, LF
   db   'บ                                             บ', CR, LF
   db   'บ     (c) Copyright 1989  by Ahn Cheolsoo     บ', CR, LF
   db   'บ                                             บ', CR, LF
   db   'ศอออออออออออออออออออออออออออออออออออออออออออออส', CR, LF
          db   LF, '$'
 Mess1    db   '  System is infected with Brain VIRUS.', 7, '$'
 Mess2    db   '  System is infected with LBC VIRUS.', 7, '$'
 Mess3    db   ' ---> CURED', CR, LF, LF, '$'
 Mess4    db   '  System is Safe.', CR, LF, LF, '$'
 Mess5    db   '  Insert a disk in drive and press <Enter>$'
 Mess6    db   CR, LF, LF, '$'
 Mess7    db   '  This disk is Safe.',CR,LF,LF,'$'
 Mess8    db   '  This disk is infected with Brain VIRUS.',CR,LF
          db   7, '  Processing the infected disk$'
 Mess9    db   '  This disk is infected with LBC VIRUS', CR, LF
          db   7, '  Processing the infected disk$'
 Mess10   db   '    Test another disk (Y/N) ? $'
 Mess11   db   '  --- protected ---', CR, LF, LF, '$'
 Mess12   db   '  --- Hard disk repaired ---', CR, LF, LF
 Mess13   db   '  You must reboot your system !', CR, LF, '$'
 ErrMess1 db   '    ***  Disk Read Error  ***',CR,LF,LF,'$'
 ErrMess2 db   '    ***  Disk Write Error  ***',CR,LF,LF,'$'
 ErrMess3 db   '  Invalid Boot Sector.', CR, LF, '$'
 ErrMess4 db   '  For repairing hard disk, you must use DOS 3.x'
          db   CR, LF, '$'
 ErrMess5 db   '  Cannot repair FAT (Disk contains only 1 FAT)'
          db   CR, LF, '$'
 ErrMess6 db   '  Damaged sector is not in first FAT.'
          db   CR, LF, '$'
 ErrMess7 db   '  Cannot find first partition.', CR, LF, '$'
 ErrMess8 db   '  Type of first partition is not MS-DOS.'
          db   CR, LF, '$'
 HelpMess db   '  To test the floppy or hard disk, specify A, B or C.'
          db   CR, LF, '$'

 Blabel    db   ' (c) Brain '        ; label of Brain virus
 Bhead     db   ?
 Bsector   db   ?
 Bcylin    db   ?

 LBCoff    dw   ?
 LBCseg    dw   ?
 TableSize dw   ?
 BootSize  dw   ?
 FATsize   dw   ?
 SectorNo  db   ?
 HeadNo    db   ?
 SecondFAT dw   ?

 Drive     db   ?
 InfFlag   db   0
 Buffer1   db   4 * 512 dup(0)       ; disk I/O buffer area
 Buffer2   db   3 * 512 dup(0)


 ;---------------------------------------------------------------
 ;        Main program starts here.
 ;---------------------------------------------------------------

 Start:   xor  ax, ax
          mov  es, ax
          ASSUME  es:DATA

          Print  Header              ; print Title Message


 ;---------------------------------------------------------------
 ;        System Memory Check
 ;---------------------------------------------------------------

          push ds
          mov  ax, es:MemSize        ; system memory size in AX
          cmp  ax, 280h
          jnz  BrainTest
          jmp  SystemOK

 BrainTest:
          mov  cl, 06                ; segment address
          shl  ax, cl                ;       = (size in KB) X 64
          mov  ds, ax
          mov  ax, ds:[0004]         ; Brain virus in memory ?
          cmp  ax, BrainID
          jnz  LBCtest
          inc  cs:InfFlag
          jmp  BrainInSystem

 LBCtest: mov  ax, ds:[0106h]
          cmp  ax, LBCid
          jnz  SystemOK
          inc  cs:InfFlag
          jmp  LBCinSystem

 BrainInSystem:
          pop  ds
          Print  Mess1

          mov  ax, es:BrainOff       ; recover changed vector
          mov  es:Int13off, ax
          mov  ax, es:BrainSeg
          mov  es:Int13seg, ax

          add  es:MemSize, 7

          jmp  SystemCured

 LBCinSystem:
          mov  ax, ds:[0178h]
          mov  cs:LBCoff, ax
          mov  ax, ds:[017Ah]
          mov  cs:LBCseg, ax

          pop  ds
          Print  Mess2

          mov  ax, LBCoff
          mov  es:Int13off, ax
          mov  ax, LBCseg
          mov  es:Int13seg, ax

          inc  es:MemSize
          inc  es:MemSize

 SystemCured:
          Print Mess3
          jmp  ArgCheck

 SystemOK:                           ; System is not infected.
          pop  ds
          Print  Mess4


 ;---------------------------------------------------------------
 ;        Argument Check
 ;---------------------------------------------------------------

 ArgCheck:
          push ds
          pop  es
          ASSUME  es:_TEXT

          mov  al, ds:[80h]
          cmp  al, 0
          jz   Help
          mov  al, ds:[82h]
          cmp  al, 'a'
          jz   DriveA
          cmp  al, 'A'
          jz   DriveA
          cmp  al, 'b'
          jz   DriveB
          cmp  al, 'B'
          jz   DriveB

          cmp  al, 'c'
          jz   DriveC
          cmp  al, 'C'
          jz   DriveC
          jmp  Help

 DriveC:  jmp  HardDisk

 Help:    Print  HelpMess
          cmp  InfFlag, 0
          jz   NoInf
          Print  Mess13
 NoInf:   xor  al, al
          jmp  Exit


 ;---------------------------------------------------------------
 ;        Test Floppy Disk
 ;---------------------------------------------------------------

 DriveA:  mov  Drive, 0
          jmp  FloppyDisk
 DriveB:  mov  Drive, 1

 FloppyDisk:
          Print  Mess5

 GetKey:  Input
          cmp  al, CR
          jnz  GetKey
          Print  Mess6

          ;  Read boot sector

          mov  cx, 4
 Retry:   push cx
          DiskIO  READ, 0, 0, 1, 1, Buffer1
                                     ; boot sector READ
          jnc  ReadOK                ; if error,
          mov  ah, 0                 ;  Reset Floppy Disk System
          int  13h
          pop  cx
          loop Retry                 ; try 4 times
          Print  ErrMess1
          jmp  FloppyDisk

          ;  Test LBC virus

 ReadOK:  cmp  word ptr Buffer1[6], LBCid
          jnz  BrainExam
          cmp  word ptr Buffer1[1FEh], 0AA55h
          jz   NoVirus
          jmp  LBCinDisk

          ;  Test Brain virus

 BrainExam:
          cmp  word ptr Buffer1[4], BrainID
          jnz  NoVirus
          cmp  word ptr Buffer1[1FEh], 0AA55h
          jnz  BrainInDisk

          ;  Protect floppy disk from Brain & LBC virus

 NoVirus: Print  Mess7
          cmp  word ptr Buffer1[4], BrainID
          jnz   Protect
          cmp  word ptr Buffer1[6], LBCid
          jnz   Protect
          jmp  OtherDisk

 Protect: mov  word ptr Buffer1[4], BrainID
          mov  word ptr Buffer1[6], LBCid
          DiskIO  WRITE, 0, 0, 1, 1, Buffer1
          jnc  WriteOK
          Print  ErrMess2
          jmp  FloppyDisk

 WriteOK: Print  Mess11
          jmp  OtherDisk


          ;  CURE THE BRAIN VIRUS

 BrainInDisk:
          Print  Mess8
          mov  al, Buffer1[6]        ; location of original
          mov  Bhead, al             ;          boot sector
          mov  al, Buffer1[7]
          mov  Bsector, al
          mov  al, Buffer1[8]
          mov  Bcylin, al

          ;  Repair the boot sector

          DiskIO READ, Bhead, Bcylin, Bsector, 1, Buffer1
                                     ; read original boot sector
          jnc  ExamBoot              ; if no error, repair boot
          Print  ErrMess1            ;                   sector
          jmp  FloppyDisk

 ExamBoot:
          cmp  word ptr Buffer1[01FEh], 0AA55h
          jz   RepairBoot
          Print  ErrMess3
          mov  al, 3
          jmp  Exit

 RepairBoot:
          mov  word ptr Buffer1[4], BrainID
          mov  word ptr Buffer1[6], LBCid

          DiskIO  WRITE, 0, 0, 1, 1, Buffer1
                                     ; write original boot sector
          jnc  ReadFAT               ; if no error, READ FAT
          Print  ErrMess2
          jmp  FloppyDisk

          ; Repair the FAT (File Allocation Table)

 ReadFAT: DiskIO  READ, 0, 0, 2, 4, Buffer1
                                     ; FAT read
          jnc  CalcCluster           ; if no error, calculate
          Print  ErrMess1            ;         cluster number
          jmp  FloppyDisk

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

          mov  si, offset Buffer1
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

          DiskIO  WRITE, 0, 0, 2, 4, Buffer1
                                     ; write the repaired FAT
          jnc  ReadDir1              ; if no error, repair label
          Print  ErrMess2
          jmp  FloppyDisk

          ;  Repair the volume label

 ReadDir1:
          DiskIO  READ, 0, 0, 6, 4, Buffer1
                                     ; read the first 4 directory
          jnc  ReadDir2              ;                     sector
          Print  ErrMess1
          jmp  FloppyDisk

 ReadDir2:
          DiskIO  READ, 1, 0, 1, 3, Buffer2
                                     ; read the 2nd 3 directory
          jnc  SearchDir             ;                   sector
          Print  ErrMess1
          jmp  FloppyDisk

 SearchDir:
          mov  cl, 6Ch               ; number of directory entry
          mov  si, 40h               ; third directory entry

 NextEntry:
          mov  al, Buffer1 [si + 0Bh] ; File attribute = 8 ?
          and  al, 8
          cmp  al, 8
          jz   LabelExist            ; if label present, jump
          add  si, 20h               ; next directory entry
          dec  cl
          jnz  NextEntry
          jmp  CureBrain

 LabelExist:
          push si
          mov  cx, 11                ; string length
          add  si, offset Buffer1
          mov  di, offset Blabel
          cld
          repe cmpsb                 ; compare volume label with
                                     ;                 (c) Brain
          jcxz BrainLabel            ; if match, jump
          pop  si
          jmp  CureBrain

 BrainLabel:
          pop  si
          mov  Buffer1[si], 0E5h     ; delete virus label

          DiskIO  WRITE, 0, 0, 6, 4, Buffer1
                                     ; write first 4 dir sector
          jnc  NextDir
          Print  ErrMess2
          jmp  FloppyDisk

 NextDir: DiskIO  WRITE, 1, 0, 1, 3, Buffer2
                                     ; write second 3 dir sector
          jnc  CureBrain
          Print  ErrMess2
          jmp  FloppyDisk

 CureBrain:
          Print Mess3
          jmp  OtherDisk


          ;  CURE THE LBC VIRUS

 LBCinDisk:
          Print  Mess9
          DiskIO  READ, 1, 0, 3, 1, Buffer1
          jnc  TestBoot
          Print  ErrMess1
          jmp  FloppyDisk

 TestBoot:
          cmp  word ptr Buffer1[01FEh], 0AA55h
          jz  NoErr
          Print  ErrMess3
          mov  al, 3
          jmp  Exit

 NoErr:   mov  word ptr Buffer1[4], BrainID
          mov  word ptr Buffer1[6], LBCid

          DiskIO  WRITE, 0, 0, 1, 1, Buffer1
                                     ; write original boot sector
          jnc  CureLBC
          Print  ErrMess2
          jmp  FloppyDisk

 CureLBC: Print  mess3


          ;  END OF JOB

 OtherDisk:
          Print  Mess10              ; examine another disk ?
          Input
          push ax
          Print  Mess6
          pop  ax
          cmp  al, 'Y'
          je   NextDisk
          cmp  al, 'y'
          je   NextDisk
          cmp  InfFlag, 0
          jz  NoFlag
          Print  Mess13
 NoFlag:  xor  al, al
          jmp  Exit

 NextDisk:
          jmp  FloppyDisk


 ;---------------------------------------------------------------
 ;        Test Hard Disk
 ;---------------------------------------------------------------

 HardDisk: mov  Drive, 80h
           DiskIO  READ, 0, 0, 1, 1, Buffer1
           jnc  HardOK
           Print  ErrMess1
           jmp  Exit

 HardOK:   cmp  word ptr Buffer1[6], 6845h
           jz   Infected
           cmp  word ptr Buffer1[01FEh], 0AA55h
           jz   BootOK
           Print  ErrMess3
           mov  al, 3
           jmp  Exit
 BootOK:   Print  Mess7
           xor  al, al
           jmp  Exit

           ;  Read the partition table

 Infected: Print  Mess9
           Print  Mess6

           mov  ah, 30h
           mov  al, 0
           int  21h
           cmp  al, 3
           jae  ReadMBoot
           Print  ErrMess4
           mov  al, 4
           jmp  Exit

 ReadMBoot:
           DiskIO  READ, 1, 0, 3, 1, Buffer1

           cmp  word ptr Buffer1[01FEh], 0AA55h
           jz   RepairPT
           Print  ErrMess3
           mov  al, 3
           jmp  Exit

           ; Repair the partition table

 RepairPT: DiskIO  WRITE, 0, 0, 1, 1, Buffer1

           ;  Repair the damaged FAT

           DiskIO  READ, 0, 0, 1, 1, Buffer1

           mov  bx, offset Buffer1 + 1AEh
 NextPart: add  bx, 10h
           cmp  bx, offset Buffer1 + 200h
           jb   InTable
           Print  ErrMess7
           mov  al, 7
           jmp  Exit
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
           Print  ErrMess8
           mov  al, 8
           jmp  Exit

 ReadBoot: mov  ax, [bx + 8]
           mov  TableSize, ax

           mov  cx, [bx + 2]
           mov  dh, [bx + 1]
           mov  ah, READ
           mov  al, 1
           mov  bx, offset Buffer1
           mov  dl, Drive
           int  13h

           mov  bx, offset Buffer1
           mov  al, [bx + 10h]
           cmp  al, 2
           jae  FATexist
           Print  ErrMess5
           mov  al, 5
           jmp  Exit

 FATexist: mov  ax, word ptr [bx + 0Eh]
           mov  BootSize, ax
           mov  ax, word ptr [bx + 16h]
           mov  FATsize, ax
           mov  ax, word ptr [bx + 18h]
           mov  SectorNo, al
           mov  ax, word ptr [bx + 1Ah]
           mov  HeadNo, al

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
 OutFAT:   Print  ErrMess6
           mov  al, 6
           jmp  Exit

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
           mov  bx, offset Buffer1
           mov  dl, Drive
           int  13h

           DiskIO  WRITE, 1, 0, 3, 1, Buffer1

           Print  Mess12

           xor  al, al
 Exit:     mov  ah, 4ch
           int  21h

_TEXT      ENDS

           END  Entry
