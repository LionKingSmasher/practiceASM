;
;	  VACCINE III  -  Test Version
;
;	      Vaccine program  for Brain virus	      Jerusalem virus
;                                  LBC virus          Sunday virus
;                                  LBC-II virus       1701 virus
;                                  Stoned virus       1704 virus
;				   Ping Pong virus    1554 virus
;                                  Disk Killer virus  November 30th virus
;                                  Mountain virus     November 30th-II virus
;                                  Damanaegi virus    Dark Avenger virus
;                                  Aircop virus       Vienna virus
;                                                     Taiwan virus
;						      1451 virus
;
;                 by   Ahn Cheolsoo
;
;                 computer : IBM - PC/XT/AT
;                 language : Turbo Assembler 1.0
;                 start of programming : 1990. 10. 15.
;		  end	of programming : 1990. 11. 11.
;		  1st revision	       : 1990. 11. 12.
;

;================================================================
;         EQUATES DEFINITION
;================================================================

 CR       EQU   0Dh
 LF       EQU   0Ah
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

          ORG  0020h                 ; original INT 8h vector
 Int8off  dw   ?                     ;    offset  address
 Int8seg  dw   ?                     ;    segment address

          ORG  0048h
 Int12off dw   ?
 Int12seg dw   ?

          ORG  004Ch                 ; original INT 13h vector
 Int13off dw   ?                     ;    offset  address
 Int13seg dw   ?                     ;    segment address

	  ORG  0064h
 Int19off dw   ?
 Int19seg dw   ?

          ORG  0070h
 Int1Coff dw   ?
 Int1Cseg dw   ?

          ORG  0180h                 ; vector of INT 60h
 Int60off dw   ?
 Int60seg dw   ?

          ORG  01B4h                 ; vector of INT 6Dh
 BrainOff dw   ?
 BrainSeg dw   ?

          ORG  0204h
 Int81off dw   ?                     ; used by Disk Killer virus
 Int81seg dw   ?                     ; in storing INT 8 vector

          ORG  020Ch
 Int83off dw   ?                     ; used by Disk Killer virus
 Int83seg dw   ?                     ; in storing INT 13h vector

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

 Logo  db   CR, LF
       db   'ษออออออออออออออออออออออออออออออออออออออออออออออออป', CR, LF
       db   'บ                                                บ', CR, LF
       db   'บ    Vaccine III (Disinfector) - Test version    บ', CR, LF
       db   'บ                                (Revision I)    บ', CR, LF
       db   'บ      (c) Copyright 1990   by Ahn Cheolsoo      บ', CR, LF
       db   'บ                                                บ', CR, LF
       db   'ศออออออออออออออออออออออออออออออออออออออออออออออออผ', CR, LF, LF
       db   'This program cannot be used for commercial purpose', CR, LF
       db   'without a negotiated site license.'
 Mess2    db   CR, LF, LF, '$'
 Mess1    db   '  Insert a disk in drive and press <Enter>$'
 Mess3    db   ' --> CURED', CR, LF, LF, '$'
 Mess4    db   CR, LF, '    Test another disk (y/N) ? $'
 Mess7	  db   CR, LF, '  You must reboot system with uninfected DOS disk.'
          db   CR, LF, LF, '$'
 Mess9    db   ' --> CURED', CR, LF, '$'
 Mess10   db   CR, LF, '$'

 BootV1   db   'Brain VIRUS$'
 BootV2   db   'LBC VIRUS$'
 BootV3   db   'LBC-II VIRUS$'
 BootV4   db   'Stoned VIRUS$'
 BootV5   db   'Ping Pong VIRUS$'
 BootV6   db   'Disk Killer VIRUS$'
 BootV7   db   'Mountain VIRUS$'
 BootV8   db   'Damaneagi VIRUS$'
 BootV9   db   'Aircop VIRUS$'
 FileV1   db   'Jerusalem VIRUS$'
 FileV2   db   'Sunday VIRUS$'
 FileV3   db   '1701 VIRUS$'
 FileV3a  db   '1701 or '
 FileV4   db   '1704 VIRUS$'
 FileV5   db   '1554(1559) VIRUS$'
 FileV6   db   'November 30th VIRUS$'
 FileV6a  db   'November 30th or '
 FileV7   db   'November 30th-II VIRUS$'
 FileV8   db   'Dark Avenger VIRUS$'
 FileV9   db   'Vienna VIRUS$'
 FileV10  db   'Taiwan VIRUS$'
 FileV11  db   '1451 VIRUS$'

 V3Str		db  6, 0EBh, 13h, 73h, 43h, 65h, 66h
 BrainStr1      db  6, 0B9h, 5h, 0h, 0BBh, 0h, 7Eh
 BrainStr2      db  6, 8Ah, 36h, 9h, 7Ch, 0B2h, 0h
 LbcStr1	db  6, 0C7h, 6h, 80h, 1, 3, 0
 Lbc2Str1       db  6, 2Dh, 3h, 0h, 89h, 7h, 0B1h
 Lbc2Str2       db  6, 0Eh, 1Fh, 88h, 16h, 5Ah, 0h
 StonedStr1     db  6, 0BEh, 4h, 0h, 0B8h, 1h, 2h
 StonedStr2     db  6, 0A1h, 13h, 4h, 48h, 48h, 0A3h
 PingPongStr1   db  6, 80h, 26h, 0F8h, 7Dh, 80h, 8Bh
 PingPongStr2   db  6, 80h, 26h, 0F7h, 7Dh, 0FBh, 3Dh
 DiskKillerStr1 db  6, 0B8h, 0h, 7Ch, 0B1h, 4h, 0D3h
 DiskKillerStr2 db  6, 88h, 16h, 0F4h, 1h, 8Bh, 87h
 MountainStr1	db  5, 8Eh, 0D0h, 0E9h, 7Ah, 1h
 MountainStr2	db  6, 0BAh, 0h, 1h, 0B9h, 3h, 0h
 DamanaegiStr1  db  6, 0A3h, 0B8h, 1h, 0E8h, 0E5h, 0h
 DamanaegiStr2  db  6, 0C6h, 6h, 0B5h, 1h, 0h, 0C7h
 AircopStr1     db  6, 0BBh, 0h, 7Ch, 8Bh, 0F3h, 0B9h
 AircopStr2     db  6, 4Eh, 4Fh, 0B9h, 33h, 0h, 0FDh

 JeruStrM	db  7, 8Ch, 0C8h, 8Eh, 0D0h, 0BCh, 10h, 7h
 JeruStr1       db  6, 1Fh, 0B9h, 10h, 7h, 0D1h, 0E9h
 JeruStr2	db  7, 8Ch, 0C8h, 8Eh, 0D0h, 0BCh, 0h, 7h
 SundayStrM	db  7, 33h, 0C9h, 0B8h, 1h, 43h, 0CDh, 21h
 SundayStr1     db  6, 1Fh, 0B9h, 5Fh, 6h, 0D1h, 0E9h
 SundayStr2	db  7, 8Ch, 0C8h, 8Eh, 0D0h, 0BCh, 5Dh, 6h
 V1554xStr	db  5, 2Eh, 0FFh, 2Eh, 0Ch, 1h
 V1554Str1	db  6, 0B8h, 12h, 6h, 0BAh, 28h, 0h
 V1554Str2	db  5, 2Eh, 0FFh, 2Eh, 0B4h, 5h
 V1451StrM	db  5, 2Eh, 0FFh, 2Eh, 0E0h, 4h
 V1451Str1	db  6, 0B8h, 0ABh, 5h, 0BAh, 28h, 0h
 V1451Str2	db  5, 2Eh, 0FFh, 2Eh, 4Dh, 5h
 Nov30xStrM	db  5, 2Eh, 0FFh, 2Eh, 1Ch, 0h
 Nov30Str1      db  6, 1Fh, 0B9h, 0D0h, 7h, 0D1h, 0E9h
 Nov30Str2      db  7, 8Ch, 0C8h, 8Eh, 0D0h, 0BCh, 0D0h, 7h
 Nov30IIStr1    db  6, 1Fh, 0B9h, 0EAh, 7h, 0D1h, 0E9h
 Nov30IIStr2	db  7, 8Ch, 0C8h, 8Eh, 0D0h, 0BCh, 0EAh, 7h
 DavStrM	db  6, 2Eh, 83h, 3Eh, 8h, 7h, 0h
 DavStr1        db  6, 0E8h, 0h, 0h, 5Eh, 81h, 0EEh
 DavStr2        db  7, 0B4h, 49h, 0CDh, 21h, 0BBh, 0FFh, 0FFh
 TaiwanStr1     db  7, 0A0h, 75h, 4h, 1Fh, 0A2h, 4Ah, 1h
 TaiwanStr2	db  6, 0B9h, 0C4h, 2h, 0BAh, 0h, 0F8h
 V170xStrM	db  5, 2Eh, 0FFh, 2Eh, 37h, 1h
 V1704Str1      db  7, 8Dh, 0B7h, 4Dh, 1h, 0BCh, 85h, 6h
 V1701Str1      db  7, 8Dh, 0B7h, 4Dh, 1h, 0BCh, 82h, 6h
 ViennaStr1     db  6, 8Bh, 0F2h, 81h, 0C6h, 0Ah, 0h
 ViennaStr2     db  6, 89, 0BCh, 16h, 0h, 8Bh, 0FEh

 Mmess0   db   '  The size of memory is $'
 Mmess00  db   'K Byte.', CR, LF, '$'
 Mmess000 db   '  System is probably infected with unknown boot virus.'
          db   7, CR, LF, LF, '$'
 Mmess1   db   '  System is Safe.', CR, LF, LF, '$'
 Mmess2   db   '  System is infected with ', 7, '$'
 Bmess1   db   '  Boot record is Safe.', CR, LF, LF, '$'
 Bmess2   db   '  Boot record is infected with ', 7, '$'
 Bmess3   db   '  Master boot record is infected with ', 7, '$'
 Bmess4   db   '  DOS boot record is infected with ', 7, '$'
 Bmess5   db   '  Master boot record is Safe.', CR, LF, LF, '$'
 Bmess6   db   '  DOS boot record is Safe.', CR, LF, LF, '$'
 Fmess1   db   '  Searching $'
 Fmess2   db   '  No infected files.', CR, LF, LF, '$'
 Fmess3   db   '                found ', 7, '$'
 Fmess4   db   ' - Repair it? (y/N) $'

 ErrMess1 db   '    ***  Disk Read Error  ***', 7, CR, LF, LF, '$'
 ErrMess2 db   '    ***  Disk Write Error  ***', 7, CR, LF, LF, '$'
 ErrMess3 db   '  Boot record is invalid or copy-protected.'
          db   7, CR, LF, LF, '$'
;          db   '  Copy-protected disk must not be repaired.', CR, LF
;          db   '  Do you want to repair it? (y/N) $'
 ErrMess4 db   '  Cannot repair FAT - disk has only one FAT'
          db   7, CR, LF, '$'
 ErrMess5 db   '  Damaged sector is not in FAT.', 7, CR, LF, '$'
 ErrMess6 db   '  Cannot find MS-DOS partition in hard disk.', 7, CR, LF, '$'
 ErrMess7 db   '  Damaged sector is not in MS-DOS partition.'
          db   7, CR, LF, '$'
 ErrMess8 db   '  Memory allocation error.', 7, CR, LF, '$'
 ErrMess9 db   '  Media descriptor byte is invalid.', 7, CR, LF, '$'
 ErrMess10 db  '  Cannot obtain drive parameter.', 7, CR, LF, '$'
 ErrMess11 db  '  Master boot record is invalid.', 7, CR, LF, '$'
 ErrMess12 db  '  DOS boot record is invalid.', 7, CR, LF, LF, '$'
 ErrMess13 db  '  Cannot find original boot record.', 7, CR, LF, '$'
 ErrMess14 db  '  Cannot find original master boot record.', 7, CR, LF, '$'
 ErrMess15 db  '  Cannot find original DOS boot record.', 7, CR, LF, '$'
 ErrMess16 db  '  DOS boot record is damaged.', 7, CR, LF, '$'
 ErrMess17 db  '  Invalid switch - use /A or /E only.', 7, CR, LF, '$'
 ErrMess18 db  '  Cannot find such pathname.', 7, CR, LF, '$'
 ErrMess19 db  CR, LF, '  Cannot open file.', 7, CR, LF, '$'
 ErrMess20 db  CR, LF, '  Cannot find current directory.', 7, CR, LF, '$'
 ErrMess21 db  CR, LF, '  Cannot close file.', 7, CR, LF, '$'
 ErrMess22 db  CR, LF, '  Cannot set pointer in file.', 7, CR, LF, '$'
 ErrMess23 db  CR, LF, '  Cannot get or set file attribute.', 7, CR, LF, '$'
 ErrMess24 db  CR, LF, '  Cannot get or set file date & time.', 7, CR, LF, '$'
 ErrMess25 db  CR, LF, '  Cannot read file.', 7, CR, LF, '$'
 ErrMess26 db  CR, LF, '  Cannot write file.', 7, CR, LF, '$'
 ErrMess30 db  '  This file may be modified or infected with virus.'
	   db  CR, LF, '  Please use a clean copy.', 7, CR, LF, '$'
 HelpMess db   'Usage: v3 [drive][pathname][filename] [/A|/E|/Mxxx]', CR, LF
	  db   '          [/A]: search (A)ll files (default)', CR, LF
	  db   '          [/E]: search (E)xecutable files only', CR, LF
	  db   '          [/Mxxx]: designate the system (M)emory size'
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
          db  'VACCINE III'
          db  14 dup (0)

 Blabel   db ' (c) Brain '
 Mlabel   db 'Mountain1.2'

 SysMem        dw   ?
 UserMem       dw   0
 SysMemSize    db   4 dup (0)
 V3	       db   'V3.COM', 0

 HeadNo        db   ?
 SectorNo      db   ?
 CylinderNo    db   ?
 Rsector       dd   ?
 Cluster       dw   ?
 FATbit        db   ?
 DosHeadNo     db   ?
 DosSectorNo   db   ?
 DosCylindNo   label byte
 DosCylinderNo dw   ?
 DosRsector    dd   ?

 SectorPerCluster  db  ?
 ReservedSector    dw  ?
 NoFAT             db  ?
 NoDirEntry        dw  ?
 SectorPerFAT      dw  ?
 MaxSector db  ?
 MaxHead   db  ?

 LBCsector    db  ?
 LBCcylinder  db  ?
 LBChead      db  ?
 PPrsector    dw  ?
 VirSize      dw  ?
 Encryp170x   dw  ?

 NoBadCluster db  ?
 LocCluster   dw  ?
 UpperFlag    db  ?
 AllFlag      db  1
 Int21offset	dw  ?
 StartPathname	dw  0
 Delimiter	db  CR, '<', '>', '|'
 Pathname	db  64 dup (?)
 OffsetPathname dw  ?
 InfFlag        db  ?
 NoInfectedFile dw  ?
 NoVirusInFile  db  ?
 VirusInCOM     db  ?
 FileNotExist   db  ?
 TaiwanFlag     db  0

 Cursor    dw   ?
 CursorPos dw   ?
 CurDrive  db   ?
 Drive	   db	0
 CurDir    db   '\'
 CurDir2   db   64 dup (0)
 TranDir   db   64 dup (0)
 Root      db   '\', 0
 Parent    db   '..', 0
 COM       db   '*.COM', 0
 EXE       db   '*.EXE', 0
 DirName   db   '*.*', 0
 DTA       db   128 dup (?)
 ExeHeader db   1Ch dup (?)

 Handle    dw   ?
 Attr      dw   ?
 Time      dw   ?
 Date      dw   ?
 Lpointer  dw   ?
 Hpointer  dw   ?
 OrigLength dw  ?
 OrigSS    dw   ?
 OrigSP    dw   ?
 OrigIP    dw   ?
 OrigCS    dw   ?
 VirNameOffset dw ?
 RegSeg    dw   ?
 RegOff    dw   ?
 CSoffset  dw   ?
 IPoffset  dw   ?
 SSoffset  dw   ?
 SPoffset  dw   ?
 StartOffset dw  ?
 StartByte   dw  ?


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

          Print  Logo              ; print Title Message


 ;---------------------------------------------------------------
 ;        Check Argument
 ;---------------------------------------------------------------

	  call GetCursor

          mov  si, 80h
          lodsb
          cmp  al, 0
          jz   Help

 CheckFirstChar:
          lodsb
          cmp  al, 9
          jz   CheckFirstChar
          cmp  al, ' '
          jz   CheckFirstChar
          cmp  al, '/'
          jz   Help
          mov  cx, 4
          mov  di, offset Delimiter
          repne scasb
          jz   Help
          jmp  CheckNextChar

 Help:	  Print  HelpMess
	  jmp  Exit

	  ;-----------------------------------------------

 CheckNextChar:
          lodsb
          cmp  al, ':'
	  jnz  RecheckFirstChar1
          mov  al, [si - 2]
          and  al, 5Fh
          mov  Drive, al

 CheckDelimiter:
          lodsb
          cmp  al, 9
          jz   CheckDelimiter
          cmp  al, ' '
          jz   CheckDelimiter
          cmp  al, '/'
          jz   CheckSwitch
          mov  cx, 4
          mov  di, offset Delimiter
	  repne scasb
	  jnz  RecheckFirstChar2
	  jmp  CheckSystemMemory

	  ;-----------------------------------------------

 RecheckFirstChar1:
	  dec  si
 RecheckFirstChar2:
          dec  si
          mov  StartPathname, si

 RecheckDelimiter:
          lodsb
          cmp  al, 9
          jz   EndOfPathname
          cmp  al, ' '
          jz   EndOfPathname
          cmp  al, '/'
          jz   EndOfPathname
          mov  cx, 4
          mov  di, offset Delimiter
          repne scasb
          jnz  RecheckDelimiter
 EndOfPathname:
	  push si
	  mov  dl, al
	  mov  byte ptr [si - 1], 0
	  mov  si, StartPathname
	  mov  di, offset Pathname
 LoadOneChar:
	  lodsb
	  stosb
	  cmp  al, 0
	  jnz  LoadOneChar
	  pop  si
	  mov  al, dl

	  ;-----------------------------------------------

 ScanSlash:
          cmp  al, '/'
	  jz   CheckSwitch
	  mov  cx, 4
	  mov  di, offset Delimiter
	  repne scasb
	  jz   CheckSystemMemory
 RescanSlash:
	  lodsb
	  jmp  ScanSlash

 CheckSwitch:
	  lodsb
	  cmp  al, 9
	  jz   ScanSlash
	  cmp  al, ' '
	  jz   ScanSlash
	  mov  cx, 4
	  mov  di, offset Delimiter
	  repne scasb
	  jz   CheckSystemMemory
	  and  al, 5Fh
	  cmp  al, 'A'
	  jz   SetAllFlag
          cmp  al, 'E'
          jz   ResetAllFlag
	  cmp  al, 'M'
	  jz   SaveMemSize
          Print  ErrMess17
	  jmp  Exit

 ResetAllFlag:
	  mov  AllFlag, 0
 SetAllFlag:
	  jmp  RescanSlash

 SaveMemSize:
	  lodsb
	  cmp  al, '/'
	  jz   CheckSwitch
	  mov  cx, 4
	  mov  di, offset Delimiter
	  repne scasb
	  jz   CheckSystemMemory
	  cmp  al, '0'
	  jb   RescanSlash
	  cmp  al, '9'
	  ja   RescanSlash
	  mov  bl, al
	  mov  ax, UserMem
	  mov  dl, 10
	  mul  dl
	  sub  bl, '0'
	  add  al, bl
	  adc  ah, 0
	  mov  UserMem, ax
	  jmp  SaveMemSize


 ;---------------------------------------------------------------
 ;        Check System Memory
 ;---------------------------------------------------------------

 CheckSystemMemory:
          push es

 CheckVirusInMemory:
          xor  ax, ax
          mov  es, ax
          mov  ax, es:MemSize        ; system memory size in AX
          mov  SysMem, ax
          mov  cl, 6                 ; segment address
          shl  ax, cl                ;       = (size in KB) X 64
          mov  es, ax

          cmp  InfFlag, 0
          jne  CheckBrainInMemory1
          Print  Mmess0
          mov  dx, SysMem
          xor  cx, cx
          lea  di, SysMemSize
 HexaToDecimal:
          push cx
          mov  ax, dx
          xor  dx, dx
          mov  cx, 10
          div  cx
          xchg ax, dx
          add  al, 30h
          mov  [di], al
          inc  di
          pop  cx
          inc  cx
          cmp  dx, 0
          jnz  HexaToDecimal

 PrintSysMemSize:
          dec  di
          mov  dl, [di]
          mov  ah, 2
          int  21h
          loop PrintSysMemSize
          Print  Mmess00

 CheckBrainInMemory1:
          mov  si, offset BrainStr1
          mov  di, 169h
          call SearchString
          jc   CheckBrainInMemory2
          jmp  ClearBrainInMemory

 CheckBrainInMemory2:
          mov  si, offset BrainStr2
          mov  di, 1A2h
          call SearchString
          jc   CheckLbcInMemory1
          jmp  ClearBrainInMemory

 CheckLbcInMemory1:
          mov  si, offset LbcStr1
	  mov  di, 159h
          call SearchString
          jc   CheckLbcInMemory2
          jmp  ClearLbcInMemory

 CheckLbcInMemory2:
	  mov  si, offset LbcStr1
	  mov  di, 1DAh
          call SearchString
          jc   CheckLbc2InMemory1
          jmp  ClearLbcInMemory

 CheckLbc2InMemory1:
          mov  si, offset Lbc2Str1
          mov  di, 117h
          call SearchString
          jc   CheckLbc2InMemory2
          jmp  ClearLbc2InMemory

 CheckLbc2InMemory2:
          mov  si, offset Lbc2Str2
          mov  di, 1EBh
          call SearchString
          jc   CheckStonedInMemory1
          jmp  ClearLbc2InMemory

 CheckStonedInMemory1:
          mov  si, offset StonedStr1
          mov  di, 40h
          call SearchString
          jc   CheckStonedInMemory2
          jmp  ClearStonedInMemory

 CheckStonedInMemory2:
          mov  si, offset StonedStr2
          mov  di, 0B8h
          call SearchString
          jc   CheckPingPongInMemory1
          jmp  ClearStonedInMemory

 CheckPingPongInMemory1:
          mov  si, offset PingPongStr1
          mov  di, 4Eh
          call SearchString
          jc   CheckPingPongInMemory2
          jmp  ClearPingPongInMemory

 CheckPingPongInMemory2:
          mov  si, offset PingPongStr2
          mov  di, 1D1h
          call SearchString
          jc   CheckDiskKillerInMemory1
          jmp  ClearPingPongInMemory

 CheckDiskKillerInMemory1:
          mov  si, offset DiskKillerStr1
          mov  di, 6Ch
          call SearchString
          jc   CheckDiskKillerInMemory2
          jmp  ClearDiskKillerInMemory

 CheckDiskKillerInMemory2:
          mov  si, offset DiskKillerStr2
          mov  di, 195h
          call SearchString
          jc   CheckMountainInMemory1
          jmp  ClearDiskKillerInMemory

 CheckMountainInMemory1:
          mov  si, offset MountainStr1
	  mov  di, 44h
          call SearchString
          jc   CheckMountainInMemory2
          jmp  ClearMountainInMemory

 CheckMountainInMemory2:
          mov  si, offset MountainStr2
	  mov  di, 1D2h
          call SearchString
          jc   CheckDamanaegiInMemory1
          jmp  ClearMountainInMemory

 CheckDamanaegiInMemory1:
          mov  si, offset DamanaegiStr1
          mov  di, 1A3h
          call SearchString
          jc   CheckDamanaegiInMemory2
          jmp  ClearDamanaegiInMemory

 CheckDamanaegiInMemory2:
          mov  si, offset DamanaegiStr2
          mov  di, 26Dh
          call SearchString
          jc   CheckAircopInMemory1
          jmp  ClearDamanaegiInMemory

 CheckAircopInMemory1:
          mov  si, offset AircopStr1
          mov  di, 71h
          call SearchString
          jc   CheckAircopInMemory2
          jmp  ClearAircopInMemory

 CheckAircopInMemory2:
          mov  si, offset AircopStr2
          mov  di, 177h
          call SearchString
          jc   ExitCheckBootVInMemory
          jmp  ClearAircopInMemory

 ExitCheckBootVInMemory:
          pop  es
          cmp  InfFlag, 0
          jz   CheckMemorySize
          jmp  CheckFileVInMemory

 CheckMemorySize:
          mov  ax, SysMem
          cmp  ax, 280h
	  jz   CFVIM
          cmp  ax, 200h
	  jz   CFVIM
          cmp  ax, 100h
	  jz   CFVIM
	  cmp  ax, UserMem
	  jz   CFVIM
          mov  InfFlag, 1
	  Print  Mmess000
 CFVIM:   jmp  CheckFileVInMemory

          ;------------------------------------------------------

 ClearBrainInMemory:
          Print  Mmess2
          Print  BootV1

          inc  InfFlag

          push ds
          xor  ax, ax
          mov  ds, ax
          ASSUME  ds:DATA
          mov  ax, BrainOff          ; recover changed vector
          mov  Int13off, ax
          mov  ax, BrainSeg
          mov  Int13seg, ax
          add  MemSize, 7
          pop  ds
          ASSUME  ds:_TEXT

          Print  Mess3
          jmp  CheckVirusInMemory

          ;------------------------------------------------------

 ClearLBCInMemory:
          Print  Mmess2
          Print  BootV2

          inc  InfFlag

          push ds
          xor  ax, ax
          mov  ds, ax
          ASSUME  ds:DATA
          mov  ax, es:[0178h]
          mov  Int13off, ax
          mov  ax, es:[017Ah]
          mov  Int13seg, ax
          inc  MemSize
          inc  MemSize
          pop  ds
          ASSUME  ds:_TEXT

          Print  Mess3
          jmp  CheckVirusInMemory

          ;------------------------------------------------------

 ClearLBC2InMemory:
          Print  Mmess2
          Print  BootV3

          inc  InfFlag

          push ds
          xor  ax, ax
          mov  ds, ax
          ASSUME  ds:DATA
          mov  ax, es:[50h]
          mov  Int13off, ax
          mov  ax, es:[52h]
          mov  Int13seg, ax

          mov  ax, es:[0227h]
          shr  ax, 1
          jnb  Not1Ch
          mov  ax, es:[54h]
          mov  Int1Coff, ax
          mov  ax, es:[56h]
          mov  Int1Cseg, ax

 Not1Ch:  add  MemSize, 3
          pop  ds
          ASSUME  ds:_TEXT

          Print  Mess3
          jmp  CheckVirusInMemory

          ;------------------------------------------------------

 ClearStonedInMemory:
          Print  Mmess2
          Print  BootV4

          inc  InfFlag

          push ds
          xor  ax, ax
          mov  ds, ax
          ASSUME  ds:DATA
          mov  ax, es:[09h]
          mov  Int13off, ax
          mov  ax, es:[0Bh]
          mov  Int13seg, ax
          inc  MemSize
          inc  MemSize
          pop  ds
          ASSUME  ds:_TEXT

          Print  Mess3
          jmp  CheckVirusInMemory

          ;------------------------------------------------------

 ClearPingPongInMemory:
          Print  Mmess2
          Print  BootV5

          inc  InfFlag

          push ds
          xor  ax, ax
          mov  ds, ax
          ASSUME  ds:DATA

          push es
          mov  ax, 3513h             ; get 13h int vector
          int  21h
          mov  cx, es
          mov  ax, 3508h
          int  21h
          mov  bx, es
          pop  es
          cmp  bx, cx
          jnz  Repair13h

          mov  ax, es:[03C9h]        ; recover 8h vector
          mov  Int8off, ax
          mov  ax, es:[03CBh]
          mov  Int8seg, ax

 Repair13h:                          ; recover 13h vector
          mov  ax, es:[012Ah]
          mov  Int13off, ax
          mov  ax, es:[012Ch]
          mov  Int13seg, ax
          inc  MemSize
          inc  MemSize
          pop  ds
          ASSUME  ds:_TEXT

          Print  Mess3
          jmp  CheckVirusInMemory

          ;------------------------------------------------------

 ClearDiskKillerInMemory:
          Print  Mmess2
          Print  BootV6
          inc  InfFlag

          push ds
          xor  ax, ax
          mov  ds, ax
          ASSUME  ds:DATA
          mov  ax, Int81off
          mov  Int8off, ax
          mov  ax, Int81seg
          mov  Int8seg, ax
          mov  ax, Int83off
          mov  Int13off, ax
          mov  ax, Int83seg
          mov  Int13seg, ax

          add  MemSize, 8
          pop  ds
          ASSUME  ds:_TEXT

          Print  Mess3
          jmp  CheckVirusInMemory

          ;------------------------------------------------------

 ClearMountainInMemory:
          Print Mmess2
          Print BootV7
          inc  InfFlag

          push ds
          xor  ax, ax
          mov  ds, ax
          ASSUME ds:DATA
          mov  ax, Int60off
          mov  Int13off, ax
          mov  ax, Int60seg
          mov  Int13seg, ax
          add  MemSize, 2
          pop  ds
          ASSUME  ds:_TEXT

          Print  Mess3
          jmp  CheckVirusInMemory

          ;------------------------------------------------------

 ClearDamanaegiInMemory:
          Print  Mmess2
          Print  BootV8
          inc  InfFlag

          push ds
          xor  ax, ax
          mov  ds, ax
          ASSUME  ds:DATA
          mov  ax, es:[1AEh]
          mov  Int13off, ax
          mov  ax, es:[1B0h]
          mov  Int13seg, ax
          add  MemSize, 2
          pop  ds
          ASSUME  ds:_TEXT

          Print  Mess3
          jmp  CheckVirusInMemory

          ;------------------------------------------------------

 ClearAircopInMemory:
          Print  Mmess2
          Print  BootV9
          inc  InfFlag

          push ds
          xor  ax, ax
          mov  ds, ax
          ASSUME  ds:DATA
	  mov  ax, Int12seg
	  cmp  ax, Int13seg
	  jne  ClearAircopInMemory2
	  mov  ax, es:[1B8h]
	  mov  Int12off, ax
	  mov  ax, es:[1BAh]
	  mov  Int12seg, ax

 ClearAircopInMemory2:
          mov  ax, es:[1BCh]
          mov  Int13off, ax
          mov  ax, es:[1BEh]
          mov  Int13seg, ax
          mov  ax, es:[1C0h]
          mov  Int19off, ax
          mov  ax, es:[1C2h]
          mov  Int19seg, ax
          inc  MemSize
          pop  ds
          ASSUME  ds:_TEXT

          Print  Mess3
          jmp  CheckVirusInMemory

;----------------------------------------------------------------

 CheckFileVInMemory:
	  xor  ax, ax
	  mov  es, ax
	  les  di, es:[84h]
	  mov  Int21offset, di
	  mov  si, offset JeruStrM
	  add  di, 39Ch - 35Bh
	  call SearchString
	  jc   CheckSundayInMemory
	  jmp  JeruInMemory

 CheckSundayInMemory:
	  mov  si, offset SundayStrM
	  mov  di, Int21offset
	  add  di, 40Ah - 3D2h
	  call SearchString
	  jc   Check170xInMemory
	  jmp  SundayInMemory

 Check170xInMemory:
	  mov  si, offset V170xStrM
	  mov  di, Int21offset
	  add  di, 32Eh - 329h
	  call SearchString
	  jc   Check1554InMemory
	  jmp  V170xInMemory

 Check1554InMemory:
	  mov  di, Int21offset
	  mov  al, 0EAh
	  mov  cx, 80h
 Rescan:  repnz scasb
	  cmp  cx, 0
	  jz   CheckNov30xInMemory
	  cmp  word ptr es:[di], 413h
	  jnz  Rescan
	  cmp  word ptr es:[di + 2], 9A00h
	  jnz  Rescan
	  jmp  V1554InMemory

 CheckNov30xInMemory:
	  mov  si, offset Nov30xStrM
	  mov  di, Int21offset
	  add  di, 310h - 2DDh
	  call SearchString
	  jc   CheckDavInMemory
	  jmp  Nov30xInMemory

 CheckDavInMemory:
	  mov  si, offset DavStrM
	  mov  di, Int21offset
	  add  di, 66FFh - 66CAh
	  call SearchString
	  jc   Check1451InMemory
	  jmp  DavInMemory

 Check1451InMemory:
	  mov  si, offset V1451StrM
	  mov  di, Int21offset
	  add  di, 428h - 413h
	  call SearchString
	  jc   CheckInfFlag
	  jmp  V1451InMemory

 CheckInfFlag:
          cmp  InfFlag, 0
          jnz  NextStep
          Print  Mmess1
 NextStep:
	  push cs
	  pop  es
	  jmp  SelfCheck

	  ;------------------------------------------------------

 JeruInMemory:
          Print  Mmess2
          Print  FileV1
          inc  InfFlag

          mov  ah, 2Ah
          int  21h
          cmp  cx, 07C3h
	  jz   ResetJeru21h
          cmp  al, 5
	  jnz  ResetJeru08h
          cmp  dl, 0Dh
	  jz   ResetJeru21h

 ResetJeru08h:
          mov  ax, 2508h
          lds  dx, es:[13h]
          int  21h

 ResetJeru21h:
          mov  ax, 2521h
          lds  dx, es:[17h]
          int  21h

	  push cs
	  pop  ds
          Print  Mess3
	  jmp  CheckFileVInMemory

	  ;------------------------------------------------------

 SundayInMemory:
          Print  Mmess2
          Print  FileV2
          inc  InfFlag

          mov  ah, 2Ah
          int  21h
          cmp  cx, 07C5h
	  jz   ResetSunday21h

          mov  ax, 2508h
          lds  dx, es:[13h]
          int  21h

 ResetSunday21h:
          mov  ax, 2521h
          lds  dx, es:[17h]
          int  21h

	  push cs
          pop  ds
	  Print  Mess3
	  jmp  CheckFileVInMemory

	  ;------------------------------------------------------

 V170xInMemory:
          Print  Mmess2
          Print  FileV3a
          inc  InfFlag

          mov  ax, 2521h
          lds  dx, es:[0137h]
          int  21h

          mov  ah, 2Ah               ; get date
          int  21h
          cmp  cx, 07C4h
	  ja   ExitV170xInMemory
          jz   Y1988
          cmp  cx, 07BCh
	  jnz  ExitV170xInMemory

          mov  ax, 2528h
          lds  dx, es:[013Bh]
          int  21h

 Y1988:   cmp  dh, 0Ah
	  jb   ExitV170xInMemory

          mov  ax, 251Ch
          lds  dx, es:[0133h]
          int  21h

 ExitV170xInMemory:
	  push cs
          pop  ds
	  Print  Mess3
	  jmp  CheckFileVInMemory

	  ;------------------------------------------------------

 V1554InMemory:
	  Print  Mmess2
	  Print  FileV5
	  inc  InfFlag

	  mov  ax, 9A00h
	  mov  ds, ax
	  mov  ax, ds:[428h]
	  mov  es:[di -1], ax
	  mov  ax, ds:[42Ah]
	  mov  es:[di + 1], ax
	  mov  ax, ds:[49Dh]
	  sub  ax, di
	  sub  ax, 4
	  mov  es:[di + 3], al

	  push cs
	  pop  ds
	  Print  Mess3
	  jmp  CheckFileVInMemory

	  ;------------------------------------------------------

 Nov30xInMemory:
           Print  Mmess2
	   Print  FileV6a
           inc  InfFlag

           mov  ax, 2521h
           lds  dx, es:[1Ch]
           int  21h

           mov  ax, 2520h
           lds  dx, es:[28h]
           int  21h

           mov  ax, 2527h
           lds  dx, es:[2Ch]
           int  21h

	   push cs
           pop  ds
           Print  Mess3
	   jmp	CheckFileVInMemory

	   ;-----------------------------------------------------

 DavInMemory:
	   Print  Mmess2
	   Print  FileV8
	   inc	InfFlag

	   mov	bx, Int21offset
	   xor	ax, ax
	   mov	ds, ax
	   mov	ax, es:[bx + 6B2Bh - 66CAh]
	   mov	ds:[84h], ax
	   mov	ax, es:[bx + 6B2Dh - 66CAh]
	   mov	ds:[86h], ax
	   mov	ax, es:[bx + 6B27h - 66CAh]
	   mov	ds:[9Ch], ax
	   mov	ax, es:[bx + 6B29h - 66CAh]
	   mov	ds:[9Eh], ax

	   push cs
	   pop	ds
	   Print  Mess3
	   jmp	CheckFileVInMemory

	   ;-----------------------------------------------------

  V1451InMemory:
	   Print  Mmess2
	   Print  FileV11
	   inc	InfFlag

	   mov	ax, 2521h
	   lds	dx, es:[4E0h]
	   int	21h

	   push cs
	   pop	ds
	   Print  Mess3
	   jmp	CheckFileVInMemory


 ;---------------------------------------------------------------
 ;        Check Disk
 ;---------------------------------------------------------------

 SelfCheck:
	  mov  ax, 3000h
	  int  21h
	  cmp  al, 3
	  jae  Dos3
	  mov  dx, offset V3
	  jmp  OpenV3

 Dos3:	  mov  es, ds:[2Ch]
	  xor  al, al
	  xor  di, di
	  mov  cx, 7FFFh
 ScanEnv: repnz  scasb
	  cmp  es:[di], al
	  loopnz ScanEnv
	  push es
	  pop  ds
	  mov  dx, di
	  add  dx, 3

OpenV3:   mov  ax, 3D00h
	  int  21h
	  push cs
	  pop  ds
	  push cs
	  pop  es
	  jnc  ReadV3
	  Print  ErrMess19
	  jmp  Exit

 ReadV3:  mov  bx, ax
	  mov  ah, 3Fh
	  mov  cx, 6
	  mov  dx, offset Buffer
	  int  21h
	  jnc  CheckV3
	  Print  ErrMess22
	  jmp  Exit

 CheckV3: mov  si, offset V3Str
	  mov  di, offset Buffer
	  call SearchString
	  jnc  CheckDisk
	  Print  ErrMess30
	  jmp  Exit

 CheckDisk:
          mov  al, Drive
          cmp  al, 0
          jz   GetCurrentDisk
          sub  al, 'A'
          jmp  CheckDiskType

 GetCurrentDisk:
          mov  ah, 19h
          int  21h

 CheckDiskType:
          mov  Drive, al
          cmp  al, 2
          jb   CheckFloppy
          je   CheckHard
          jmp  CheckFileVirus

 CheckFloppy:
          call CheckFloppyBoot
          jmp  CheckFileVirus

 CheckHard:
          add  Drive, 7Eh
          call CheckHardBoot
          sub  Drive, 7Eh
          jmp  CheckFileVirus


;--------------------------------------------------------------
;        Check Boot sector in floppy disk
;--------------------------------------------------------------

 CheckFloppyBoot  PROC near

          Print  Mess1
 GetKey:  Input
          cmp  al, CR
          jnz  GetKey
          Print  Mess2

 ReadFloppyBoot:
          call ReadMasterBR
          mov  FATbit, 12

          ;  Test Brain virus

 ExamBrainInFloppy1:
          mov  si, offset BrainStr1
          mov  di, offset Buffer + 169h
          call SearchString
          jc   ExamBrainInFloppy2
          jmp  BrainInFloppy

 ExamBrainInFloppy2:
          mov  si, offset BrainStr2
          mov  di, offset Buffer + 1A2h
          call SearchString
          jc   ExamLbcInFloppy1
          jmp  BrainInFloppy

          ;  Test LBC virus

 ExamLbcInFloppy1:
          mov  si, offset LbcStr1
	  mov  di, offset Buffer + 59h
          call SearchString
          jc   ExamLbcInFloppy2
          jmp  LbcInFloppy

 ExamLbcInFloppy2:
	  mov  si, offset LbcStr1
	  mov  di, offset Buffer + 0DAh
          call SearchString
          jc   ExamLbc2InFloppy1
          jmp  LbcInFloppy

          ;  Test LBC-II virus

 ExamLbc2InFloppy1:
          mov  si, offset Lbc2Str1
          mov  di, offset Buffer + 17h
          call SearchString
          jc   ExamLbc2InFloppy2
          jmp  Lbc2InFloppy

 ExamLbc2InFloppy2:
          mov  si, offset Lbc2Str2
          mov  di, offset Buffer + 0EBh
          call SearchString
          jc   ExamStonedInFloppy1
          jmp  Lbc2InFloppy

          ;  Test Stoned virus

 ExamStonedInFloppy1:
          mov  si, offset StonedStr1
          mov  di, offset Buffer + 40h
          call SearchString
          jc   ExamStonedInFloppy2
          jmp  StonedInFloppy

 ExamStonedInFloppy2:
          mov  si, offset StonedStr2
          mov  di, offset Buffer + 0B8h
          call SearchString
          jc   ExamPingPongInFloppy1
          jmp  StonedInFloppy

          ;  Test Ping Pong virus

 ExamPingPongInFloppy1:
          mov  si, offset PingPongStr1
          mov  di, offset Buffer + 4Eh
          call SearchString
          jc   ExamPingPongInFloppy2
          jmp  PingPongInFloppy

 ExamPingPongInFloppy2:
          mov  si, offset PingPongStr2
          mov  di, offset Buffer + 1D1h
          call SearchString
          jc   ExamDiskKillerInFloppy1
          jmp  PingPongInFloppy

          ;  Test Disk Killer virus

 ExamDiskKillerInFloppy1:
          mov  si, offset DiskKillerStr1
          mov  di, offset Buffer + 6Ch
          call SearchString
          jc   ExamDiskKillerInFloppy2
          jmp  DiskKillerInFloppy

 ExamDiskKillerInFloppy2:
          mov  si, offset DiskKillerStr2
          mov  di, offset Buffer + 195h
          call SearchString
          jc   ExamMountainInFloppy1
          jmp  DiskKillerInFloppy

          ;  Test Mountain virus

 ExamMountainInFloppy1:
          mov  si, offset MountainStr1
	  mov  di, offset Buffer + 44h
          call SearchString
          jc   ExamMountainInFloppy2
          jmp  MountainInFloppy

 ExamMountainInFloppy2:
          mov  si, offset MountainStr2
	  mov  di, offset Buffer + 1D2h
          call SearchString
          jc   ExamDamanaegiInFloppy1
          jmp  MountainInFloppy

          ;  Test Damanaegi virus

 ExamDamanaegiInFloppy1:
          mov  si, offset DamanaegiStr1
          mov  di, offset Buffer + 0A3h
          call SearchString
          jc   ExamDamanaegiInFloppy2
          jmp  DamanaegiInFloppy

 ExamDamanaegiInFloppy2:
          mov  si, offset DamanaegiStr2
          mov  di, offset Buffer + 16Dh
          call SearchString
          jc   ExamAircopInFloppy1
          jmp  DamanaegiInFloppy

          ;  Test Aircop virus

 ExamAircopInFloppy1:
          mov  si, offset AircopStr1
          mov  di, offset Buffer + 71h
          call SearchString
          jc   ExamAircopInFloppy2
          jmp  AircopInFloppy

 ExamAircopInFloppy2:
          mov  si, offset AircopStr2
          mov  di, offset Buffer + 177h
          call SearchString
          jc   EndExamFloppyBoot
          jmp  AircopInFloppy

          ;  Test end of boot record

 EndExamFloppyBoot:
          cmp  word ptr Buffer[1FEh], 0AA55h
          jne  InvalidBootRecord
          Print  Bmess1
          ret

 InvalidBootRecord:
          Print  ErrMess3           ; invalid boot sector
;         call CursorOn
;         Input
;         push ax
;         Print  Mess2
;         pop  ax
;         and  al, 5Fh
;         cmp  al, 'Y'
;         je   RepairBootRecord
          ret

 RepairBootRecord:
          jmp  Exit

          ;----------------------------
          ;  Eradicate the Brain virus
          ;----------------------------

 BrainInFloppy:
          Print  Bmess2
          Print  BootV1

          mov  al, Buffer[6]           ; location of original
          mov  HeadNo, al              ;          boot sector
          mov  al, Buffer[7]
          mov  SectorNo, al
          mov  al, Buffer[8]
          mov  CylinderNo, al
          call RepairMasterBR

          call GetFloppyBPB
          call SectorToRsector
          call RsectorToCluster

          mov  NoBadCluster, 3
          call ClearBadCluster

          mov  di, offset Blabel
          call RepairLabel

          Print  Mess3
          jmp  ReadFloppyBoot

          ;----------------------------
          ;  Eradicate the LBC virus
          ;----------------------------

 LbcInFloppy:
          Print  Bmess2
          Print  BootV2

          mov  al, Buffer[5Dh]
          mov  SectorNo, al
          mov  al, Buffer[5Eh]
          mov  CylinderNo, al
          mov  al, Buffer[63h]
          mov  HeadNo, al
          call RepairMasterBR

          call ClearSector

          Print  Mess3
          jmp  ReadFloppyBoot

          ;-----------------------------
          ;  Eradicate the LBC-II virus
          ;-----------------------------

 Lbc2InFloppy:
          Print  Bmess2
          Print  BootV3

          mov  ah, Buffer[62h]
          mov  SectorNo, ah
          inc  SectorNo
          mov  ah, Buffer[63h]
          mov  CylinderNo, ah
          mov  ah, Buffer[68h]
          mov  HeadNo, ah
          call RepairMasterBR

          call GetFloppyBPB
          mov  Cluster, 355
          mov  NoBadCluster, 1
          call ClearBadCluster

          Print  Mess3
          jmp  ReadFloppyBoot

          ;----------------------------
          ; Eradicate the Stoned virus
          ;----------------------------

 StonedInFloppy:
          Print  Bmess2
          Print  BootV4

          mov  al, Buffer[107h]
          mov  SectorNo, al
          mov  al, Buffer[108h]
          mov  CylinderNo, al
          mov  al, Buffer[10Bh]
          mov  HeadNo, al
          call RepairMasterBR

          call  ClearSector

          Print  Mess3
          jmp  ReadFloppyBoot

          ;---------------------------------
          ; Eradicate the Ping Pong-B virus
          ;---------------------------------

 PingPongInFloppy:
          Print  Bmess2
          Print  BootV5

          mov  ax, word ptr Buffer[1F9h]
          inc  ax
          mov  word ptr Rsector, ax

          call GetFloppyBPB
          call RsectorToSector
          call RepairMasterBR

          dec  word ptr Rsector
          call RsectorToCluster
          mov  NoBadCluster, 1
          call ClearBadCluster

          Print  Mess3
          jmp  ReadFloppyBoot

          ;---------------------------------
          ; Eradicate the Disk Killer virus
          ;---------------------------------

 DiskKillerInFloppy:
          Print  Bmess2
          Print  BootV6

          mov  ax, word ptr Buffer[40h]
          mov  word ptr Rsector, ax

          call GetFloppyBPB
          call RsectorToSector
          call RepairMasterBR

          sub  word ptr Rsector, 4
          call RsectorToCluster
          mov  NoBadCluster, 3
          call ClearBadCluster

          Print  Mess3
          jmp  ReadFloppyBoot

          ;------------------------------
          ; Eradicate the Mountain virus
          ;------------------------------

 MountainInFloppy:
          Print  Bmess2
          Print  BootV7

          mov  HeadNo, 0
          mov  CylinderNo, 0
          mov  SectorNo, 1
          call ClearSector
          mov  HeadNo, 1
          mov  SectorNo, 3
          call ClearSector

          mov  di, offset Mlabel
          call RepairLabel

          Print  Mess3
          jmp  ReadFloppyBoot

          ;-------------------------------
          ; Eradicate the Damanaegi virus
          ;-------------------------------

 DamanaegiInFloppy:
          Print  Bmess2
          Print  BootV8

          mov  al, Buffer[93h]
          mov  SectorNo, al
          mov  al, Buffer[94h]
          mov  CylinderNo, al
          mov  al, Buffer[99h]
          mov  HeadNo, al
          call RepairMasterBR
          call ClearSector

          Print  Mess3
          jmp  ReadFloppyBoot

          ;----------------------------
          ; Eradicate the Aircop virus
          ;----------------------------

 AircopInFloppy:
          Print  Bmess2
          Print  BootV9

          mov  al, Buffer[8Ah]
          mov  SectorNo, al
          mov  al, Buffer[8Bh]
          mov  CylinderNo, al
          mov  al, buffer[8Eh]
          mov  HeadNo, al
          call RepairMasterBR

          Print  Mess3
          jmp  ReadFloppyBoot

 CheckFloppyBoot  ENDP


 ;---------------------------------------------------------------
 ;        Check Boot sector in hard disk
 ;--------------------------------------------------------------

 CheckHardBoot  PROC  near

          call ReadMasterBR

          mov  si, offset LbcStr1
	  mov  di, offset Buffer + 59h
          call SearchString
          jc   ExamLbcInHard2
          jmp  LbcInHard

 ExamLbcInHard2:
	  mov  si, offset LbcStr1
	  mov  di, offset Buffer + 0DAh
          call SearchString
          jc   ExamStonedInHard1
          jmp  LbcInHard

 ExamStonedInHard1:
          mov  si, offset StonedStr1
          mov  di, offset Buffer + 40h
          call SearchString
          jc   ExamStonedInHard2
          jmp  StonedInHard

 ExamStonedInHard2:
          mov  si, offset StonedStr2
          mov  di, offset Buffer + 0B8h
          call SearchString
          jc   CheckMBRend
          jmp  StonedInHard

 CheckMBRend:
          cmp  word ptr Buffer[01FEh], 0AA55h
          jz   CheckDOSBootRecord
          Print  ErrMess11
          jmp  Exit

 CheckDOSBootRecord:
          Print  Bmess5

          call ReadDosBR

          mov  si, offset PingPongStr1
          mov  di, offset Buffer + 4Eh
          call SearchString
          jc   ExamPingPongInHard2
          jmp  PingPongInHard

 ExamPingPongInHard2:
          mov  si, offset PingPongStr2
          mov  di, offset Buffer + 1D1h
          call SearchString
          jc   ExamDiskKillerInHard1
          jmp  PingPongInHard

 ExamDiskKillerInHard1:
          mov  si, offset DiskKillerStr1
          mov  di, offset Buffer + 6Ch
          call SearchString
          jc   ExamDiskKillerInHard2
          jmp  DiskKillerInHard

 ExamDiskKillerInHard2:
          mov  si, offset DiskKillerStr2
          mov  di, offset Buffer + 195h
          call SearchString
          jc   CheckDosBRend
          jmp  DiskKillerInHard

          ;  Test end of boot record

 CheckDosBRend:
          cmp  word ptr Buffer[1FEh], 0AA55h
          jz   ValidDosBR

          Print  ErrMess12           ; invalid DOS boot sector
          ret

 ValidDosBR:
          Print  Bmess6
          ret

          ;-----------------------------------
          ;  Eradicate LBC virus in hard disk
          ;-----------------------------------

 LBCinHard:
          Print  Bmess3
          Print  BootV2

          mov  al, Buffer[5Dh]
          mov  LBCsector, al
          mov  SectorNo, al
          mov  al, Buffer[5Eh]
          mov  LBCcylinder, al
          mov  CylinderNo, al
          mov  al, Buffer[63h]
          mov  LBChead, al
          mov  HeadNo, al
          call RepairMasterBR

          ; Repair the damaged FAT

          call GetDriveParameter
          call SectorToRsector

          call ReadDosBR

          mov  ax, word ptr DosRsector[2]
          cmp  ax, word ptr Rsector[2]
          ja   NotInDosPartition
          mov  ax, word ptr DosRsector
          cmp  ax, word ptr Rsector
          ja   NotInDosPartition
          je   InDosBootRecord
          jmp  InDosPartition

 NotInDosPartition:
          Print  ErrMess7
          jmp  Exit

 InDosBootRecord:
          Print  ErrMess16
          jmp  Exit

 InDosPartition:
          call GetHardBPB

          cmp  NoFAT, 2
          jae  SecondFATexist
          Print  ErrMess4
          jmp  Exit

 SecondFATexist:
          mov  ax, word ptr DosRsector
          add  ax, ReservedSector
          add  ax, SectorPerFAT
          cmp  ax, word ptr Rsector
          ja   Read2ndFAT
          Print  ErrMess5
          jmp  Exit

 Read2ndFAT:
          mov  bx, word ptr Rsector
          sub  bx, word ptr DosRsector
          sub  bx, ReservedSector
          add  ax, bx
          mov  word ptr Rsector, ax
          call RsectorToSector
          DiskIO  READ, HeadNo, CylinderNo, SectorNo, 1
          jnc  RepairFAT
          Print  ErrMess1
          jmp  Exit

 RepairFAT:
          DiskIO  WRITE, LBChead, LBCcylinder, LBCsector, 1
          jnc  QuitLBCinHard
          Print  ErrMess2
          jmp  Exit

 QuitLBCinHard:
          Print  Mess3
          Print  Mess7
          jmp  Exit

          ;-----------------------------------------
          ; Eradicate the Stoned virus in hard disk
          ;-----------------------------------------

 StonedInHard:
          Print  Bmess3
          Print  BootV4

          mov  al, Buffer[0FCh]
          mov  SectorNo, al
          mov  al, Buffer[0FDh]
          mov  CylinderNo, al
          mov  al, Buffer[100h]
          mov  HeadNo, al
          call RepairMasterBR

          Print  Mess3
          Print  Mess7
          jmp  Exit

          ;--------------------------------------------
          ; Eradicate the Ping Pong virus in hard disk
          ;--------------------------------------------

 PingPongInHard:
          Print  Bmess2
          Print  BootV5

          mov  ax, word ptr Buffer[01F9h]
          mov  PPrsector, ax
          inc  ax
          add  ax, word ptr DosRsector
          mov  word ptr Rsector[2], 0
          mov  word ptr Rsector, ax
          call GetDriveParameter
          call RsectorToSector
          call RepairDosBR

          call GetHardBPB
          mov  ax, PPrsector
          mov  word ptr Rsector, ax
          call RsectorToCluster

          mov  ax, word ptr DosRsector
          add  ReservedSector, ax
          mov  NoBadCluster, 1
          call ClearBadCluster

          Print  Mess3
          Print  Mess7
          jmp  Exit

          ;----------------------------------------------
          ; Eradicate the Disk Killer virus in hard disk
          ;----------------------------------------------

 DiskKillerInHard:
          Print  Bmess2
          Print  BootV6

          mov  ax, word ptr DosRsector
          dec  ax
          mov  word ptr Rsector, ax
          call GetDriveParameter
          call RsectorToSector
          call RepairDosBR

          Print  Mess3
          Print  Mess7
          jmp  Exit

 CheckHardBoot  ENDP

;---------------------------------------------------------------

 ReadMasterBR  PROC  near

          ; Input  = (no)
          ; Output = read (Master) Boot Record

          mov  cx, 4
 Retry:   push cx
          DiskIO  READ, 0, 0, 1, 1
          jnc  ExitReadMasterBR
          mov  ah, 0
          int  13h
          pop  cx
          loop Retry

          Print  ErrMess1
          jmp  Exit

 ExitReadMasterBR:
          pop  cx
          ret

 ReadMasterBR  ENDP

;---------------------------------------------------------------

 ReadDosBR  PROC  near

          ; Input  = Master boot record in Buffer
          ; Output = DOS boot record in Buffer,
          ;          FATbit, DosHeadNo, DosSectorNo,
          ;          DosCylinderNo, DosRsector

          mov  FATbit, 16
          mov  si, offset Buffer
          add  si, 1BEh
          mov  cx, 4
 NextPartition:
          cmp  byte ptr [si + 4], 1
          jz   FAT12bitPartition
          cmp  byte ptr [si + 4], 4
          jz   DosPartition
          cmp  byte ptr [si + 4], 6
          jz   DosPartition
          add  si, 10h
          loop NextPartition
          Print  ErrMess6
          jmp  Exit
 FAT12bitPartition:
          mov  FATbit, 12

 DosPartition:
          mov  al, [si + 1]
          mov  DosHeadNo, al
          mov  al, [si + 2]
          and  al, 00111111b
          mov  DosSectorNo, al
          mov  al, [si + 2]
          mov  cl, 6
          shr  al, cl
          mov  byte ptr DosCylinderNo[1], al
          mov  al, [si + 3]
          mov  byte ptr DosCylinderNo, al
          mov  ax, [si + 8]
          mov  word ptr DosRsector, ax
          mov  ax, [si + 0Ah]
          mov  word ptr DosRsector[2], ax

          DiskIO  READ, DosHeadNo, DosCylindNo, DosSectorNo, 1
          jnc  ExitReadDosBR
          Print  ErrMess1
          jmp  Exit

 ExitReadDosBR:
          ret

 ReadDosBR  ENDP

;---------------------------------------------------------------

 RepairMasterBR  PROC  near

          ; Input  = HeadNo, CylinderNo, SectorNo
          ;               of Original Boot Record
          ; Output = (repair Master Boot Record)

          DiskIO READ, HeadNo, CylinderNo, SectorNo, 1
          jnc  ExamMasterBR
          Print  ErrMess1
          jmp  Exit

 ExamMasterBR:
          cmp  word ptr Buffer[1FEh], 0AA55h
          jz   WriteMasterBR
        ; Print  Mess2
          cmp  Drive, 80h
          jae  CanNotRepairBR

 WriteMasterBR:
          DiskIO  WRITE, 0, 0, 1, 1
          jnc  ExitRepairMasterBR
          Print  ErrMess2
          jmp  Exit

 ExitRepairMasterBR:
          ret

 CanNotRepairBR:
          Print  ErrMess14
          jmp  Exit

 RepairMasterBR  ENDP

;---------------------------------------------------------------

 RepairDosBR  PROC  near

          ; Input  = HeadNo, CylinderNo, SectorNo (original DOS BR)
          ;          DosHeadNo, DosCylinderNo, DosSectorNo
          ; Output = (repair DOS boot record)

          DiskIO  READ, HeadNo, CylinderNo, SectorNo, 1
          jnc  ExamDosBR
          Print  ErrMess1
          jmp  Exit

 ExamDosBR:
          cmp  word ptr Buffer[1FEh], 0AA55h
          jz   WriteDosBR
          Print  Mess2
          Print  ErrMess15
          jmp  Exit

 WriteDosBR:
          DiskIO  WRITE, DosHeadNo, DosCylindNo, DosSectorNo, 1
          jnc  ExitRepairDosBR
          Print  ErrMess2
          jmp  Exit

 ExitRepairDosBR:
          ret

 RepairDosBR  ENDP

;---------------------------------------------------------------

 GetFloppyBPB  PROC  near

          ; Input  = Drive
          ; Output = SectorPerCluster, ReservedSector, NoFAT
          ;          NoDirEntry, SectorPerFAT, MaxSector, MaxHead

          push ds
          mov  ah, 1Ch
          mov  dl, Drive
          inc  dl
          int  21h
          cmp  al, 0FFh
          jne  GetMDB
          Print  ErrMess1
          jmp  Exit

 GetMDB:  mov  ah, ds:[bx]
          pop  ds
          mov  ReservedSector, 1
          mov  NoFAT, 2

          cmp  ah, 0F0h
          jz   MDBf0
          cmp  ah, 0F9h
          jz   MDBf9
          cmp  ah, 0FCh
          jnz  NotFC
          jmp  MDBfc
 NotFC:   cmp  ah, 0FDh
          jnz  NotFD
          jmp  MDBfd
 NotFD:   cmp  ah, 0FEh
          jnz  NotFE
          jmp  MDBfe
 NotFE:   cmp  ah, 0FFh
          jnz  NotFF
          jmp  MDBff
 NotFF:   Print  ErrMess9
          jmp  Exit

 MDBf0:   mov  SectorPerCluster, 1
          mov  NoDirEntry, 0E0h
          mov  SectorPerFAT, 9
          mov  MaxSector, 18
          mov  MaxHead, 2
          ret

 MDBf9:   mov  SectorPerCluster, al
          mov  MaxHead, 2
          cmp  SectorPerCluster, 2
          je   ThreeInchDisk
          mov  NoDirEntry, 0E0h
          mov  SectorPerFAT, 7
          mov  MaxSector, 15
          ret

 ThreeInchDisk:
          mov  NoDirEntry, 70h
          mov  SectorPerFAT, 3
          mov  MaxSector, 9
          ret

 MDBfc:   mov  SectorPerCluster, 1
          mov  NoDirEntry, 40h
          mov  SectorPerFAT, 2
          mov  MaxSector, 9
          mov  MaxHead, 1
          ret

 MDBfd:   mov  SectorPerCluster, 2
          mov  NoDirEntry, 70h
          mov  SectorPerFAT, 2
          mov  MaxSector, 9
          mov  MaxHead, 2
          ret

 MDBfe:   mov  SectorPerCluster, 1
          mov  NoDirEntry, 40h
          mov  SectorPerFAT, 1
          mov  MaxSector, 8
          mov  MaxHead, 1
          ret

 MDBff:   mov  SectorPerCluster, 2
          mov  NoDirEntry, 70h
          mov  SectorPerFAT, 1
          mov  MaxSector, 8
          mov  MaxHead, 2
          ret

 GetFloppyBPB  ENDP

;---------------------------------------------------------------

 GetDriveParameter  PROC  near

          ; Input  = Drive
          ; Output = MaxSector, MaxHead

          mov  ah, 8
          mov  dl, Drive
          int  13h
          and  cl, 00111111b
          mov  MaxSector, cl
          inc  dh
          mov  MaxHead, dh
          ret

 GetDriveParameter  ENDP

;---------------------------------------------------------------

 GetHardBPB  PROC  near

          ; Input  = DOS boot record in Buffer
          ; Output = SectorPerCluster, ReservedSector,
          ;          NoFAT, NoDirEntry, SectorPerFAT

          mov  al, Buffer[0Dh]
          mov  SectorPerCluster, al
          mov  ax, word ptr Buffer[0Eh]
          mov  ReservedSector, ax
          mov  al, Buffer[10h]
          mov  NoFAT, al
          mov  ax, word ptr Buffer[11h]
          mov  NoDirEntry, ax
          mov  ax, word ptr Buffer[16h]
          mov  SectorPerFAT, ax
          ret

 GetHardBPB  ENDP

;---------------------------------------------------------------

 SectorToRsector  PROC  near

          ; Input  = HeadNo, CylinderNo, SectorNo,
          ;          MaxHead, MaxSector
          ; Output = Rsector

          mov  al, CylinderNo
          mov  cl, MaxHead
          mul  cl
          add  al, HeadNo
          adc  ah, 0
          mov  cl, MaxSector
          xor  ch, ch
          mul  cx
          mov  cl, SectorNo
          dec  cl
          add  al, cl
          adc  ah, 0
          adc  dx, 0
          mov  word ptr Rsector, ax
          mov  word ptr Rsector[2], dx

          ret

 SectorToRsector  ENDP

;---------------------------------------------------------------

 RsectorToSector  PROC  near

          ; Input  = Rsector, MaxSector, MaxHead
          ; Output = HeadNo, CylinderNo, SectorNo

          xor  dx, dx
          mov  ax, word ptr Rsector
          xor  ch, ch
          mov  cl, MaxSector
          div  cx
          inc  dl
          mov  SectorNo, dl
          xor  dx, dx
          mov  cl, MaxHead
          div  cx
          mov  HeadNo, dl
          mov  CylinderNo, al
          ret

 RsectorToSector  ENDP

;---------------------------------------------------------------

 RsectorToCluster  PROC  near

          ; Input  = Rsector
          ; Output = Cluster

          ; calculate the sector No of system area
          mov  cx, ReservedSector        ; Reserved sector
          mov  al, NoFAT                 ; No of FAT
          cbw
          mul  SectorPerFAT              ; No of sector/FAT
          add  cx, ax
          mov  ax, 20h
          mul  NoDirEntry                ; No of root dir entry
          add  ax, 01FFh
          mov  bx, 200h
          div  bx
          add  cx, ax                    ; sector No of system area

          ; calculate cluster from relative sector
          mov  ax, word ptr Rsector      ; relative sector ->
          mov  dx, word ptr Rsector[2]
          clc
          sub  ax, cx
          sbb  dx, 0
          mov  cl, SectorPerCluster      ; sector/cluster
          xor  ch, ch
          div  cx
          inc  ax
          inc  ax
          mov  Cluster, ax
          ret

 RsectorToCluster  ENDP

;------------------------------------------------------------------

 ClearBadCluster  PROC  near

          ; Input  = FATbit, ReservedSector, Cluster, NoBadCluster
          ; Output = (Clear Bad Cluster)

          mov  ax, Cluster
          cmp  FATbit, 12
          jnz  FAT16bit

          ; calculate location of cluster
          shl  ax, 1
          add  ax, Cluster
          mov  UpperFlag, 0
          test ax, 1
          jz   MakeOneHalf
          inc  UpperFlag
 MakeOneHalf:
          shr  ax, 1                      ; location of cluster
          jmp  CalcLocCluster

 FAT16bit:
          shl  ax, 1

 CalcLocCluster:
          ; calculate location of cluster in FAT
          mov  cx, 200h
          xor  dx, dx
          div  cx
          add  ax, ReservedSector
          mov  LocCluster, dx
          mov  word ptr Rsector, ax

          ; load FAT
          call RsectorToSector
          DiskIO READ, HeadNo, CylinderNo, SectorNo, 2
          jnc  FindBadClusterInFAT
          Print  ErrMess1
          jmp  Exit

 FindBadClusterInFAT:
          mov  bx, offset Buffer
          add  bx, LocCluster
          xor  ch, ch
          mov  cl, NoBadCluster

          cmp  FATbit, 12
          jnz  ClearFAT16bit

 ClearFAT12bit:
          mov  ax, [bx]
          cmp  UpperFlag, 0
          jnz  IgnoreLower4Bit
          and  ax, 0FFFh
          cmp  ax, 0FF7h
          jnz  ExitClearBadCluster
          and  word ptr [bx], 0F000h
          jmp  NextBadCluster
 IgnoreLower4Bit:
          and  ax, 0FFF0h
          cmp  ax, 0FF70h
          jnz  ExitClearBadCluster
          and  word ptr [bx], 000Fh
          inc  bx

 NextBadCluster:
          inc  bx
          xor  UpperFlag, 1
          loop ClearFAT12bit
          jmp  WriteFAT

 ClearFAT16bit:
          mov  ax, [bx]
          cmp  ax, 0FFF7h
          mov  word ptr [bx], 0
          inc  bx
          inc  bx
          loop ClearFAT16bit

 WriteFAT:
          DiskIO WRITE, HeadNo, CylinderNo, SectorNo, 2
          jnc  ExitClearBadCluster
          Print  ErrMess2
          jmp  Exit

 ExitClearBadCluster:
          ret

 ClearBadCluster  ENDP

;---------------------------------------------------------------

 RepairLabel  PROC  near

          ; Input = DI : offset address of virus label

          mov  ah, Drive
          inc  ah
          mov  xfcb1[7], ah
          mov  xfcb2[7], ah
          mov  dx, offset xfcb1
          mov  ah, 11h
          int  21h
          or   al, al
          je   LabelExist
          ret

 LabelExist:
          mov  cx, 11
          mov  si, 88h
          cld
          repe cmpsb
          jcxz VirusLabelExist
          ret

 VirusLabelExist:
          mov  ah, 17h
          mov  dx, offset xfcb2
          int  21h
          ret

 RepairLabel  ENDP

;---------------------------------------------------------------

 ClearSector  PROC  near

          ; Input  = HeadNo, CylinderNo, SectorNo
          ; Output = (Clear sector)

          cld
          xor  ax, ax
          mov  cx, 256
          mov  di, offset Buffer
          rep  stosw

          DiskIO  WRITE, HeadNo, CylinderNo, SectorNo, 1
          jnc  ExitClearSector
          Print  ErrMess2
          jmp  Exit
 ExitClearSector:
          ret

 ClearSector ENDP

;---------------------------------------------------------------

 SearchString  PROC  near

          ; Input = SI : offset address of virus string
          ;         DI : offset address of Buffer
          ; Ouput = carry flag

          xor  ah, ah
          lodsb
          mov  cx, ax
          repz cmpsb
          jcxz StringExist
          stc
          ret

 StringExist:
          clc
          ret

 SearchString  ENDP


;---------------------------------------------------------------
;         Check File Viruses
;---------------------------------------------------------------

 CheckFileVirus:
	  mov  NoInfectedFile, 0
	  mov  ax, 2524h
	  mov  dx, offset CriticalError
	  int  21h
	  jmp  GetCurDisk

 CriticalError:
	  push cs
	  pop  ds
	  Print  Mess2
	  Print  ErrMess2
	  jmp  RestoreAll

 GetCurDisk:
          mov  ah, 19h               ; Get current disk
          int  21h
          mov  CurDrive, al

          mov  ah, 47h               ; Get current directory
          mov  dl, CurDrive
          inc  dl
          mov  si, offset CurDir2
          int  21h
          jnc  SetInt23
          Print  ErrMess19
          jmp  Exit

 SetInt23:
          mov  ax, 2523h             ; Int 23h set
          mov  dx, offset RestoreAll
          int  21h

          call CursorOff

          mov  ah, 0Eh               ; Select disk
          mov  dl, Drive
          int  21h

          mov  ah, 1Ah
          mov  dx, offset DTA
          int  21h

          ;------------------------------------------------

          cmp  StartPathname, 0
          jnz  PresentPathname
          jmp  NoPathname

 PresentPathname:
          mov  ah, 3Bh                  ; set current dir
          lea  dx, Pathname
          int  21h
          jc   InvalidPathname
          jmp  CheckAllFlag

 InvalidPathname:
          lea  si, Pathname
          xor  cx, cx
 SearchZero:
          lodsb
          inc  cx
          cmp  al, 0
          jnz  SearchZero
          dec  si
          std
 SearchBackSlash:
          lodsb
          cmp  al, '\'
          jz   FoundBackSlash
          loop SearchBackSlash

          cld                                  ; exist filename only
          mov  OffsetPathname, si
          inc  OffsetPathname
          call FindFiles
          cmp  FileNotExist, 1
          jz   FileNotExisted
          jmp  RecoverDD
 FileNotExisted:
          Print  ErrMess18
          jmp  Exit

 FoundBackSlash:
          cld
          mov  byte ptr [si + 1], 0
          mov  OffsetPathname, si
          add  OffsetPathname, 2

          cmp  Pathname, 0
          jnz  NotInRoot
          lea  dx, Root
          jmp  ChangeDirectory
 NotInRoot:
          lea  dx, Pathname
 ChangeDirectory:
          mov  ah, 3Bh
          int  21h
          jnc  DirExist
          Print  ErrMess18
          jmp  CheckD

 DirExist:
          call FindFiles
          cmp  FileNotExist, 1
          jnz  FileExisted
          Print  ErrMess18
 FileExisted:
          jmp  CheckD

 CheckAllFlag:
          cmp  AllFlag, 0
          jnz  CheckAllFiles

          lea  ax, COM
          mov  OffsetPathname, ax
          call FindFiles

          lea  ax, EXE
          mov  OffsetPathname, ax
          call FindFiles

          jmp  RecoverDD

 CheckAllFiles:
          lea  ax, DirName
          mov  OffsetPathname, ax
          call FIndFiles

          jmp  RecoverDD

          ;---------------------------------------------------

 Nopathname:
          mov  di, offset DirLevel
          mov  bp, di
          mov  ax, 0101h
          mov  cx, 32
          rep  stosw

          mov  ah, 3Bh               ; Set current directory
          lea  dx, Root
	  int  21h

 SearchFiles:
          cmp  AllFlag, 0
          jnz  SearchAllFiles

          lea  ax, COM
          mov  OffsetPathname, ax
          call FindFiles

          lea  ax, EXE
          mov  OffsetPathname, ax
          call FindFiles

          jmp  FirstDir

 SearchAllFiles:
          lea  ax, DirName
          mov  OffsetPathname, ax
          call FIndFiles

          jmp  FirstDir

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

 CkDir:   cmp  byte ptr DTA[15h], 10h
          jnz  NextDir
          cmp  byte ptr DTA[1Eh], '.'
          jz   NextDir
          inc  bl
          cmp  bl, ds:[bp]
          jnz  NextDir
          inc  byte ptr ds:[bp]
          mov  dx, offset DTA + 1Eh
          mov  ah, 3Bh                  ; set current dir
          int  21h
          inc  bp
          jmp  SearchFiles

 NextDir: mov  ah, 4Fh
          int  21h
          jc   ParentDir
          jmp  CkDir

          ;---------------------------------------------------

 RecoverDD:
          mov  ah, 3
          xor  bh, bh
          int  10h
          xor  dl, dl
          mov  ah, 2
          int  10h
          mov  ah, 0Ah
          mov  al, ' '
          mov  cx, 80
          int  10h
          xor  dl, dl
          mov  ah, 2
          int  10h

          cmp  NoInfectedFile, 0
          jnz  CheckD
          Print  Fmess2

 CheckD:  cmp  Drive, 1
          ja   CheckFlag
          cmp  StartPathname, 0
          jnz  CheckFlag

          Print  Mess4              ; examine another disk ?
          call CursorOn
          Input
          push ax
          Print  Mess2
          pop  ax
          and  al, 5Fh
          cmp  al, 'Y'
          jne  CheckFlag
          mov  ah, 0Eh
          mov  dl, CurDrive
          int  21h
          mov  ah, 3Bh
          mov  dx, offset CurDir
          int  21h
          jmp  CheckFloppy
 CheckFlag:
          cmp  InfFlag, 0
          jz   RestoreAll
          Print  Mess7

 RestoreAll:
          mov  ah, 0Eh              ; restore drive
          mov  dl, CurDrive
          int  21h
          mov  ah, 3Bh              ; restore directory
          mov  dx, offset CurDir
          int  21h

 Exit:    call CursorOn
          xor  al, al
          mov  ah, 4Ch
          int  21h

;--------------------------------------------------------------

 FindFiles  PROC  near

          ; Input  = OffsetPathname
          ; Output = (Seach and cure virus)

          mov  FileNotExist, 0
          mov  ah, 4Eh
          mov  cx, 100111b
          mov  dx, OffsetPathname
          int  21h
          jnc  FoundFirstFile
          mov  FileNotExist, 1
          ret

 FoundFirstFile:
          call CheckFileType

 FindNextFiles:
          mov  ah, 4Fh
          mov  cx, 100111b
          mov  dx, OffsetPathname
          int  21h
          jnc  FoundNextFile
          ret

 FoundNextFile:
          call CheckFileType
          jmp  FindNextFiles

 FindFiles  ENDP

;--------------------------------------------------------------

 CheckFileType  PROC  near

          mov  ah, 3                ; to the begining of line
          xor  bh, bh
          int  10h
          xor  dl, dl
          mov  ah, 2
          int  10h

          Print  Fmess1             ; print drive name
          mov  ah, 2
          mov  dl, Drive
          add  dl, 'A'
          int  21h
          mov  dl, ':'
          int  21h
          mov  dl, '\'
          int  21h

          mov  ah, 47h              ; get current dir
          mov  dl, Drive
          inc  dl
          lea  si, TranDir
          int  21h
          jnc  PrintDirName
          Print  ErrMess20
          jmp  Exit

 PrintDirName:                      ; print dir name
          mov  ah, 2
          lea  si, TranDir
          mov  dl, [si]
          cmp  dl, 0
          jz   PrintFilename
 NextDirname:
          int  21h
          inc  si
          mov  dl, [si]
          cmp  dl, 0
          jz   PrintBackSlash
          jmp  NextDirname

 PrintBackSlash:                    ; print file name
          mov  dl, '\'
          int  21h
 PrintFilename:
          mov  si, offset DTA + 1Eh
 NextFilename:
          mov  dl, [si]
          cmp  dl, 0
          jz   ExamHeader
          int  21h
          inc  si
          jmp  NextFilename

 ExamHeader:
          mov  ah, 3h
          xor  bx, bx
          int  10h
          mov  CursorPos, dx
          mov  cx, 79
          xor  dh, dh
          sub  cx, dx
          mov  ah, 0Ah
          mov  al, ' '
          int  10h
          mov  ah, 2
          xor  bx, bx
          mov  dx, CursorPos
          int  10h

	  xor  al, al
          call OpenFile

          mov  ah, 3Fh              ; read file
          mov  cx, 1Ch
          mov  dx, offset ExeHeader
	  int  21h
	  jnc  CloseExamFile
	  Print  ErrMess25
	  jmp  Exit

 CloseExamFile:
          call CloseFile

          mov  NoVirusInFile, 0
          cmp  word ptr ExeHeader, 5A4Dh
          jz   EXEfile
          call CheckVirusInCOM
          ret

 EXEfile: call CheckVirusInEXE
          ret

 CheckFileType  ENDP


;---------------------------------------------------------------
;         Cure File Viruses
;---------------------------------------------------------------

 CheckVirusInCOM  PROC  near

          mov  VirSize, 0
          mov  TaiwanFlag, 0
          mov  Encryp170x, 0

	  xor  al, al
          call OpenFile

          mov  ax, 4202h                 ; get file size
          xor  cx, cx
          xor  dx, dx
          int  21h
          jc   FailToSetPointer
          mov  Lpointer, ax

          mov  ax, 4200h                 ; set file pointer
          xor  cx, cx                    ;         to start
          xor  dx, dx
          int  21h
          jnc  ReadStartOfFile
 FailToSetPointer:
          Print  ErrMess22
          jmp  Exit

 ReadStartOfFile:
          mov  ah, 3Fh                   ; read file
          mov  cx, 200h
          mov  dx, offset Buffer
	  int  21h
	  jnc  CheckComFileSize1
	  Print  ErrMess25
	  jmp  Exit

 CheckComFileSize1:
          mov  ax, Lpointer
	  cmp  ax, 2451
	  jae  Check1554xInCOM
          cmp  ax, 2027
          jae  CheckNov30iiInCom1
          cmp  ax, 2001
	  jae  CNIC
          cmp  ax, 1814
	  jae  CJIC
          cmp  ax, 1637
	  jae  CSIC
          cmp  ax, 1416
          jae  CTIC
	  jmp  CheckJmpInCom1
 CNIC:	  jmp  CheckNov30InCom1
 CJIC:	  jmp  CheckJeruInCom1
 CSIC:	  jmp  CheckSundayInCom1
 CTIC:    jmp  CheckTaiwanInCom1

 Check1554xInCom:
	  mov  si, offset V1554xStr
	  mov  di, offset Buffer + 7
          call SearchString
	  jc   CheckNov30iiInCom1
	  mov  dx, word ptr Buffer[0Eh]
	  sub  dx, 10h
	  mov  cl, 4
	  shl  dx, cl
	  mov  OrigLength, dx
	  mov  ax, 4200h
	  mov  bx, Handle
	  xor  cx, cx
	  int  21h
	  jnc  Read1554x
	  Print  ErrMess22
	  jmp  Exit

 Read1554x:
	  mov  ah, 3Fh
	  mov  cx, 100h
	  mov  dx, offset Buffer
	  int  21h
	  jnc  Diff1554x
	  Print  ErrMess25
	  jmp  Exit

 Diff1554x:
	  mov  si, offset V1451Str1
	  mov  di, offset Buffer + 68h
	  call SearchString
	  jc   V1554IC
	  jmp  V1451InCom
 V1554IC: jmp  V1554InCom

 CheckNov30iiInCom1:
          mov  si, offset Nov30iiStr1
          mov  di, offset Buffer + 0D7h
          call SearchString
          jc   CheckNov30iiInCom2
          jmp  Nov30iiInCom

 CheckNov30iiInCom2:
          mov  si, offset Nov30iiStr2
          mov  di, offset Buffer + 0EBh
          call SearchString
          jc   CheckNov30InCom1
          jmp  Nov30iiInCom

 CheckNov30InCom1:
          mov  si, offset Nov30Str1
          mov  di, offset Buffer + 0D7h
          call SearchString
          jc   CheckNov30InCom2
          jmp  Nov30InCom

 CheckNov30InCom2:
          mov  si, offset Nov30Str2
          mov  di, offset Buffer + 0EBh
          call SearchString
          jc   CheckJeruInCom1
          jmp  Nov30InCom

 CheckJeruInCom1:
          mov  si, offset JeruStr1
          mov  di, offset Buffer + 12Eh
          call SearchString
          jc   CheckJeruInCom2
          jmp  JeruInCom

 CheckJeruInCom2:
          mov  si, offset JeruStr2
          mov  di, offset Buffer + 142h
          call SearchString
          jc   CheckSundayInCom1
          jmp  JeruInCom

 CheckSundayInCom1:
          mov  si, offset SundayStr1
          mov  di, offset Buffer + 129h
          call SearchString
          jc   CheckSundayInCom2
          jmp  SundayInCom

 CheckSundayInCom2:
          mov  si, offset SundayStr2
          mov  di, offset Buffer + 13Ch
          call SearchString
          jc   CheckTaiwanInCom1
          jmp  SundayInCom

 CheckTaiwanInCom1:
          mov  si, offset TaiwanStr1
          mov  di, offset Buffer + 0DEh
          call SearchString
          jc   CheckTaiwanInCom2
          jmp  TaiwanInCom1

 CheckTaiwanInCom2:
          mov  si, offset TaiwanStr2
          mov  di, offset Buffer + 13Ah
          call SearchString
          jc   CheckJmpInCom1
          jmp  TaiwanInCom1

          ;-------------------------------------------------------

 CheckJmpInCom1:
          cmp  Buffer, 0E9h
          je   CheckJmpInCom2
          jmp  NotVirusInCom

 CheckJmpInCom2:
          mov  ax, 4200h
          mov  bx, Handle
          xor  cx, cx
          mov  dx, word ptr Buffer[1]
          add  dx, 3
          mov  OrigLength, dx
	  int  21h
	  jnc  ReadJmpInCom
	  Print  ErrMess22
	  jmp  Exit

 ReadJmpInCom:
          mov  ah, 3Fh
          mov  cx, 200h
          mov  dx, offset Buffer
	  int  21h
	  jnc  CheckComFileSize2
	  Print  ErrMess25
	  jmp  Exit

 CheckComFileSize2:
          mov  ax, Lpointer
          cmp  ax, 3575
          jae  CheckDavInCom1
          cmp  ax, 1707
          jae  Check1704InCom1
          cmp  ax, 1704
          jae  Check1701InCom1
          cmp  ax, 658
          jae  CheckViennaInCom1
          jmp  NotVirusInCom

 CheckDavInCom1:
          mov  si, offset DavStr1
          mov  di, offset Buffer
          call SearchString
          jc   CheckDavInCom2
          jmp  DavInCom

 CheckDavInCom2:
          mov  si, offset DavStr2
          mov  di, offset Buffer + 652Dh - 6444h
          call SearchString
          jc   Check1704InCom1
          jmp  DavInCom

 Check1704InCom1:
          mov  si, offset V1704Str1
          mov  di, offset Buffer + 1Eh - 0Bh
          call SearchString
          jc   Check1701InCom1
          jmp  V1704InCom

 Check1701InCom1:
          mov  si, offset V1701Str1
          mov  di, offset Buffer + 1Eh - 0Bh
          call SearchString
          jc   CheckViennaInCom1
          jmp  V1701InCom

 CheckViennaInCom1:
          mov  si, offset ViennaStr1
          mov  di, offset Buffer + 124h - 11Fh
          call SearchString
          jc   CheckViennaInCom2
          jmp  ViennaInCom

 CheckViennaInCom2:
          mov  si, offset ViennaStr2
          mov  di, offset Buffer + 177h - 11Fh
          call SearchString
          jc   NotVirusInCom
          jmp  ViennaInCom

 NotVirusInCom:
          call CloseFile
          cmp  NoVirusInFile, 0
          je   ExitCheckVirusInCom
          inc  NoInfectedFile
 ExitCheckVirusInCom:
          ret

          ;-------------------------------------------------------

 Nov30iiInCom:
          mov  VirSize, 7EAh
          mov  ax, offset FileV7
          jmp  CommonInNov30

 Nov30InCom:
          mov  VirSize, 7D0h
          mov  ax, offset FileV6
 CommonInNov30:
          mov  VirNameOffset, ax
          mov  ax, word ptr Buffer[5]
          mov  OrigLength, ax
          jmp  FoundVirusInCom

 JeruInCom:
          mov  VirSize, 710h
          mov  ax, offset FileV1
          jmp  CommonInJeru

 SundayInCom:
          mov  VirSize, 65Fh
          mov  ax, offset FileV2
 CommonInJeru:
          mov  VirNameOffset, ax
          mov  ax, word ptr Buffer[11h]
          mov  OrigLength, ax
          jmp  FoundVirusInCom

 TaiwanInCom1:
          mov  ax, offset FileV10
          mov  VirNameOffset, ax
          mov  ax, word ptr Buffer[48h]
          cmp  ax, 708
          ja   TaiwanInCom2
          mov  OrigLength, ax
          mov  VirSize, 708
          jmp  FoundVirusInCom

 TaiwanInCom2:
          mov  VirSize, ax
          mov  OrigLength, 708
          inc  TaiwanFlag
          jmp  FoundVirusInCom

 V1554InCom:
          mov  ax, offset FileV5
          mov  StartOffset, 4F7h
	  jmp  CommonIn1554x

 V1451InCom:
	  mov  ax, offset FileV11
	  mov  StartOffset, 490h
 CommonIn1554x:
	  mov  VirNameOffset, ax
	  mov  StartByte, 20h
	  jmp  FoundVirusInCom

 DavInCom:
          mov  ax, offset FileV8
          mov  VirNameOffset, ax
          sub  OrigLength, 6444h - 63DCh
          mov  StartOffset, 705h
          mov  StartByte, 3
          jmp  FoundVirusInCom

 V1704InCom:
          mov  Encryp170x, 585h
          mov  ax, offset FileV4
          jmp  CommonIn170x

 V1701InCom:
          mov  Encryp170x, 582h
          mov  ax, offset FileV3
 CommonIn170x:
          mov  VirNameOffset, ax
          dec  OrigLength
          jmp  FoundVirusInCom

 ViennaInCom:
          mov  ax, offset FileV9
          mov  VirNameOffset, ax
          mov  StartOffset, 322h - 11Fh
          mov  StartByte, 3
          jmp  FoundVirusInCom

          ;------------------------------------------------------

 FoundVirusInCom:
          inc  NoVirusInFile
          cmp  NoVirusInFile, 1
          jnz  PrintMsgInCom
          Print  Mess10
 PrintMsgInCom:
          Print  Fmess3
          mov  ah, 9
          mov  dx, VirNameOffset
          int  21h
          Print  Fmess4
          call CursorOn
          Input
          call CursorOff
          and  al, 5Fh
          cmp  al, 'Y'
          je   DecideVirusType
          Print  Mess10
          jmp  NotVirusInCom

 DecideVirusType:
	  call CloseFile
	  call GetResetAttr
	  mov  al, 2
	  call OpenFile

          cmp  VirSize, 0
          jnz  EradVirusInCom1
          cmp  Encryp170x, 0
          jz   EVIC2
          jmp  EradVirusInCom3
 EVIC2:   jmp  EradVirusInCom2

          ;----------------------------------------------------------

 EradVirusInCom1:
          call AllocMem
          call GetTime

          mov  ax, 4200h
          xor  cx, cx
          mov  dx, VirSize
          int  21h
          jnc  ReadOrigCom
          Print  ErrMess22
          jmp  Exit
 ReadOrigCom:
          mov  ah, 3Fh
          mov  cx, OrigLength
          push es
          pop  ds
          xor  dx, dx
	  int  21h
          push cs
          pop  ds
	  jnc  SetOrigLoc
          Print  ErrMess25
          jmp  Exit

SetOrigLoc:
          mov  ax, 4200h
          xor  cx, cx
          xor  dx, dx
	  int  21h
	  jnc  WriteOrigCom
	  Print  ErrMess22
	  jmp  Exit

 WriteOrigCom:
          mov  ah, 40h
          mov  cx, OrigLength
          push es
          pop  ds
          xor  dx, dx
          int  21h
          push cs
          pop  ds
          jnc  CheckTaiwanFlag
          Print  ErrMess26
          jmp  Exit

 CheckTaiwanFlag:
          cmp  TaiwanFlag, 0
          jz   AdjustComSize
          mov  ax, 4200h
          xor  cx, cx
          mov  dx, VirSize
	  int  21h
	  jnc  AdjustComSize
	  Print  ErrMess22
	  jmp  Exit

 AdjustComSize:
          mov  ah, 40h
          xor  cx, cx
          int  21h
          jnc  RestoreComTime
          Print  ErrMess26
          jmp  Exit

 RestoreComTime:
          call RestoreTime
          call DeallocMem
	  call CloseFile
	  call RestoreAttr
          Print  Mess9
          jmp  CheckVirusInCom

          ;------------------------------------------------------

 EradVirusInCom2:
          mov  ax, 4200h
          mov  bx, Handle
          xor  cx, cx
          mov  dx, OrigLength
          add  dx, StartOffset
	  int  21h
	  jnc  ReadOrigByte
	  Print  ErrMess22
	  jmp  Exit

ReadOrigByte:
          mov  ah, 3Fh
          mov  cx, StartByte
          mov  dx, offset Buffer
          int  21h
	  jnc  EradVirusInCom23
	  Print  ErrMess25
	  jmp  Exit

 EradVirusInCom3:
          call AllocMem
          mov  ax, 4200h
          mov  bx, Handle
          xor  cx, cx
          xor  dx, dx
	  int  21h
	  jnc  Read170xFile
	  Print  ErrMess22
	  jmp  Exit

 Read170xFile:
          mov  ah, 3Fh
          mov  cx, Lpointer
          push es
          pop  ds
          mov  dx, 100h
          int  21h
          push cs
	  pop  ds
	  jnc  Decrypt170xFile
	  Print  ErrMess25
	  jmp  Exit

 Decrypt170xFile:
          mov  si, Lpointer
          sub  si, Encryp170x
          push si
          mov  di, Encryp170x
          add  di, 100h
 Decrypt: xor  es:[si], si
          xor  es:[si], di
          inc  si
          dec  di
          jnz  Decrypt

          pop  si
          add  si, 11
          mov  ax, es:[si]
          mov  word ptr Buffer, ax
          mov  al, es:[si + 2]
          mov  Buffer[2], al

          call DeallocMem
          mov  StartByte, 3

 EradVirusInCom23:
          call GetTime

          mov  ax, 4200h
          xor  cx, cx
          xor  dx, dx
          int  21h
          mov  ah, 40h
          mov  cx, StartByte
          mov  dx, offset Buffer
	  int  21h
	  jnc  AdjustOrigComSize
	  Print ErrMess26
	  jmp  Exit

 AdjustOrigComSize:
          mov  ax, 4200h
          xor  cx, cx
          mov  dx, OrigLength
	  int  21h
          mov  ah, 40h
          xor  cx, cx
	  int  21h
	  jnc  ComFileCured
	  Print  ErrMess26
	  jmp  Exit

 ComFileCured:
          call RestoreTime
	  call CloseFile
	  call RestoreAttr
          Print  Mess9
          jmp  CheckVirusInCom

 CheckVirusInCOM  ENDP

 ;---------------------------------------------------------------

 CheckVirusInEXE  PROC  near

	  xor  al, al
          call OpenFile                  ; open EXE file

          mov  ah, 3Fh                      ; read Header
          mov  cx, 1Ch
          mov  dx, offset ExeHeader
	  int  21h
	  jnc  CalcExeEntry
	  Print  ErrMess25
	  jmp  Exit

 CalcExeEntry:
          mov  ax, word ptr ExeHeader[8]    ; calc the entry point of EXE
          add  ax, word ptr ExeHeader[16h]
          mov  dx, 10h
          mul  dx
          add  ax, word ptr ExeHeader[14h]
          adc  dx, 0
          mov  Lpointer, ax
          mov  Hpointer, dx

          mov  cx, dx                    ; set pointer to entry
          mov  dx, ax
          mov  ax, 4200h
	  int  21h
	  jnc  ReadExeEntry1
	  Print  ErrMess22
	  jmp  Exit

 ReadExeEntry1:
          mov  ah, 3Fh                   ; read EXE entry
          mov  cx, 100h
          mov  dx, offset Buffer
	  int  21h
	  jnc  JmpInExeEntry
	  Print  ErrMess25
	  jmp  Exit

 JmpInExeEntry:
          cmp  Buffer, 0E9h              ; 'JMP' instruction
          jnz  ExamJeruInExe1
          mov  ax, Lpointer
          add  ax, word ptr Buffer[1]
          adc  Hpointer, 0
          add  ax, 3
          adc  Hpointer, 0
          mov  Lpointer, ax
          mov  dx, ax
          mov  cx, Hpointer
          mov  ax, 4200h
	  int  21h
	  jnc  ReadExeEntry2
	  Print  ErrMess22
	  jmp  Exit

 ReadExeEntry2:
          mov  ah, 3Fh
          mov  cx, 100h
          mov  dx, offset Buffer
	  int  21h
	  jnc  ExamJeruInExe1
	  Print  ErrMess25
	  jmp  Exit

 ExamJeruInExe1:
          mov  si, offset JeruStr1
          mov  di, offset Buffer - 0C5h + 12Eh
          call SearchString
          jc   ExamJeruInEXE2
          jmp  JeruInEXE

 ExamJeruInExe2:
          mov  si, offset JeruStr2
          mov  di, offset Buffer - 0C5h + 142h
          call SearchString
          jc   ExamSundayInEXE1
          jmp  JeruInEXE

 ExamSundayInExe1:
          mov  si, offset SundayStr1
          mov  di, offset Buffer - 0C4h + 129h
          call SearchString
          jc   ExamSundayInExe2
          jmp  SundayInExe

 ExamSundayInExe2:
          mov  si, offset SundayStr2
          mov  di, offset Buffer - 0C4h + 13Ch
          call SearchString
          jc   Exam1554InExe1
          jmp  SundayInExe

 Exam1554InExe1:
	  mov  si, offset V1554Str2
          mov  di, offset Buffer - 54Fh + 57Ah
          call SearchString
          jc   Exam1554InExe2
          jmp  V1554InExe

 Exam1554InExe2:
	  mov  si, offset V1554Str2
          mov  di, offset Buffer - 54Fh + 5F9h
          call SearchString
	  jc   Exam1451InExe1
          jmp  V1554InExe

 Exam1451InExe1:
	  mov  si, offset V1451Str2
	  mov  di, offset Buffer - 54Fh + 57Ah
	  call SearchString
	  jc   Exam1451InExe2
	  jmp  V1451InExe

 Exam1451InExe2:
	  mov  si, offset V1451Str2
	  mov  di, offset Buffer - 54Fh + 5F9h
	  call SearchString
	  jc   ExamNov30InExe1
	  jmp  V1451InExe

 ExamNov30InExe1:
          mov  si, offset Nov30Str1
          mov  di, offset Buffer - 6Ch + 0D7h
          call SearchString
          jc   ExamNov30InExe2
          jmp  Nov30InExe

 ExamNov30InExe2:
          mov  si, offset Nov30Str2
          mov  di, offset Buffer - 6Ch + 0EBh
          call SearchString
          jc   ExamNov30iiInExe1
          jmp  Nov30InExe

 ExamNov30iiInExe1:
          mov  si, offset Nov30iiStr1
          mov  di, offset Buffer - 6Ch + 0D7h
          call SearchString
          jc   ExamNov30iiInExe2
          jmp  Nov30iiInExe

 ExamNov30iiInExe2:
          mov  si, offset Nov30iiStr2
          mov  di, offset Buffer - 6Ch + 0EBh
          call SearchString
          jc   ExamDavInExe1
          jmp  Nov30iiInExe

 ExamDavInExe1:
          mov  si, offset DavStr1
          mov  di, offset Buffer
          call SearchString
          jc   ExamDavInExe2
          jmp  DavInExe

 ExamDavInExe2:
          mov  si, offset DavStr2
          mov  di, offset Buffer + 652Dh - 6444h
          call SearchString
          jc   NotVirusInExe
          jmp  DavInExe

 NotVirusInEXE:
          call CloseFile
          cmp  NoVirusInFile, 0
          je   ExitCheckVirusInExe
          inc  NoInfectedFile
 ExitCheckVirusInExe:
          ret

 JeruInEXE:
          mov  ax, offset FileV1
          mov  VirNameOffset, ax
          sub  Lpointer, 0C5h
          sbb  Hpointer, 0
          mov  ax, Lpointer
          mov  RegOff, ax
          mov  ax, Hpointer
          mov  RegSeg, ax
          mov  CSoffset, 49h
          mov  IPoffset, 47h
          mov  SSoffset, 45h
          mov  SPoffset, 43h
          jmp  EradVirusInExe1

 SundayInExe:
          mov  ax, offset FileV2
          mov  VirNameOffset, ax
          sub  Lpointer, 0C4h
          sbb  Hpointer, 0
          mov  ax, Lpointer
          mov  RegOff, ax
          mov  ax, Hpointer
          mov  RegSeg, ax
          mov  CSoffset, 49h
          mov  IPoffset, 47h
          mov  SSoffset, 45h
          mov  SPoffset, 43h
          jmp  EradVirusInExe1

 V1554InExe:
	  mov  ax, Lpointer
	  mov  RegOff, ax
	  mov  ax, Hpointer
	  mov  RegSeg, ax
	  sub  Lpointer, 54Fh - 28h
	  sbb  Hpointer, 0
	  mov  ax, offset FileV5
	  jmp  V1554xInExe

 V1451InExe:
	  mov  ax, Lpointer
	  mov  RegOff, ax
	  mov  ax, Hpointer
	  mov  RegSeg, ax
	  sub  Lpointer, 4E8h - 28h
	  sbb  Hpointer, 0
	  mov  ax, offset FileV11
 V1554xInExe:
	  mov  VirNameOffset, ax
          mov  CSoffset, 5B6h - 54Fh
          mov  IPoffset, 5B4h - 54Fh
          mov  SSoffset, 5A1h - 54Fh
          mov  SPoffset, 5A3h - 54Fh
          jmp  EradVirusInExe1

 Nov30InExe:
          mov  ax, offset FileV6
          jmp  Nov30AllInExe

 Nov30iiInExe:
          mov  ax, offset FileV7
 Nov30AllInExe:
          mov  VirNameOffset, ax
          sub  Lpointer, 6Ch
          sbb  Hpointer, 0
          mov  ax, Lpointer
          mov  RegOff, ax
          mov  ax, Hpointer
          mov  RegSeg, ax
          mov  CSoffset, 0Eh
          mov  IPoffset, 0Ch
          mov  SSoffset, 14h
          mov  SPoffset, 16h
          jmp  EradVirusInExe1

 DavInExe:
          mov  ax, offset FileV8
          mov  VirNameOffset, ax
          sub  Lpointer, 68h
          sbb  Hpointer, 0
          mov  ax, Lpointer
          mov  dx, Hpointer
          add  ax, 69E3h - 63DCh
          adc  dx, 0
          mov  RegOff, ax
          mov  RegSeg, dx
          mov  CSoffset, 6ADBh - 69E3h
          mov  IPoffset, 6AD9h - 69E3h
          mov  SSoffset, 6ADFh - 69E3h
          mov  SPoffset, 6ADDh - 69E3h

 EradVirusInExe1:
          inc  NoVirusInFile
          cmp  NoVirusInFile, 1
          jnz  PrintMsgInEXE
          Print  Mess10
 PrintMsgInEXE:
          Print  Fmess3
          mov  ah, 9
          mov  dx, VirNameOffset
          int  21h
          Print  Fmess4
          call CursorOn
          Input
          call CursorOff
          and  al, 5Fh
          cmp  al, 'Y'
          je   EradVirusInEXE2
          Print  Mess10
          jmp  NotVirusInEXE

 EradVirusInEXE2:
	  call CloseFile
	  call GetResetAttr
	  mov  al, 2
	  call OpenFile

          mov  ax, 4200h
          mov  dx, RegOff
          mov  cx, RegSeg
	  int  21h
	  jnc  ReadVirDataInExe
	  Print  ErrMess22
	  jmp  Exit

 ReadVirDataInExe:
          mov  ah, 3Fh
          mov  cx, 100h
          mov  dx, offset Buffer
	  int  21h
	  jnc  SaveExeHeader
	  Print  ErrMess25
	  jmp  Exit

 SaveExeHeader:
          mov  bx, SPoffset
          mov  ax, word ptr Buffer[bx]
          mov  OrigSP, ax
          mov  bx, SSoffset
          mov  ax, word ptr Buffer[bx]
          mov  OrigSS, ax
          mov  bx, IPoffset
          mov  ax, word ptr Buffer[bx]
          mov  OrigIP, ax
          mov  bx, CSoffset
          mov  ax, word ptr Buffer[bx]
          mov  OrigCS, ax

          call CureExeFile
	  call CloseFile
	  call RestoreAttr
          jmp  CheckVirusInExe

 CheckVirusInExe  ENDP

;----------------------------------------------------------

 GetCursor  PROC  near

          mov  ah, 3
          int  10h
          cmp  cx, 67h
          jne  NoBug
          mov  cx, 607h
 NoBug:   mov  Cursor, cx
	  ret

 GetCursor  ENDP

 ;----------------------------------------------------------

 CursorOff  PROC  near

          mov  ah, 1
          mov  cx, 2000h
          int  10h
          ret

 CursorOff  ENDP

;----------------------------------------------------------

 CursorOn  PROC  near

          mov  ah, 1
          mov  cx, Cursor
          int  10h
          ret

 CursorOn  ENDP

;----------------------------------------------------------

 AllocMem  PROC  near

          mov  ah, 48h
          mov  bx, 1000h
          int  21h
          jnc  Allocated
          Print  ErrMess8
          jmp  Exit
 Allocated:
          mov  es, ax
          ret

 AllocMem  ENDP

;----------------------------------------------------------

 DeallocMem  PROC  near

          mov  ah, 49h
          int  21h
          push cs
          pop  es
          ret

 DeallocMem  ENDP

;----------------------------------------------------------

 CureExeFile  PROC  near

          ; Input = ExeHeader, Hpointer, Lpointer,
          ;         OrigCS, OrigIP, OrigSS, OrigSP

          mov  dx, Hpointer
          mov  ax, Lpointer
          mov  cx, 200h
          div  cx
          cmp  dx, 0
          jz   NotRemain
          inc  ax
 NotRemain:
          mov  word ptr ExeHeader[2], dx
          mov  word ptr ExeHeader[4], ax

          mov  ax, OrigSS
          mov  word ptr ExeHeader[0Eh], ax
          mov  ax, OrigSP
          mov  word ptr ExeHeader[10h], ax
          mov  ax, OrigIP
          mov  word ptr ExeHeader[14h], ax
          mov  ax, OrigCS
          mov  word ptr ExeHeader[16h], ax

          call GetTime

          mov  ax, 4200h
          mov  bx, Handle
          xor  cx, cx
          xor  dx, dx
	  int  21h
	  jnc  RestoreExeHeader
	  Print  ErrMess22
	  jmp  Exit

 RestoreExeHeader:
          mov  ah, 40h
          mov  cx, 1Ch
          mov  dx, offset ExeHeader
	  int  21h
	  jnc  AdjustExeSize
	  Print  ErrMess26
	  jmp  Exit

 AdjustExeSize:
          mov  ax, 4200h
          mov  cx, Hpointer
          mov  dx, Lpointer
          int  21h
          mov  ah, 40h
          xor  cx, cx
	  int  21h
	  jnc  ExeFileCured
	  Print  ErrMess26
	  jmp  Exit

 ExeFileCured:
          call RestoreTime

          Print  Mess9

          ret

 CureExeFile  ENDP

;---------------------------------------------------------------------

 GetResetAttr  PROC  near

          mov  ax, 4300h
          mov  dx, offset DTA + 1Eh
          int  21h
          jnc  SaveAttr
          Print  ErrMess23
          jmp  Exit
 SaveAttr:mov  Attr, cx

          mov  ax, 4301h
          mov  dx, offset DTA + 1Eh
          xor  cx, cx
          int  21h
          jnc  ExitGetAttr
          Print  ErrMess23
          jmp  Exit

 ExitGetAttr:
          ret

 GetResetAttr  ENDP

;---------------------------------------------------------------

 RestoreAttr  PROC  near

          mov  ax, 4301h
          mov  cx, Attr
          mov  dx, offset DTA + 1Eh
          int  21h
          jnc  ExitRestoreAttr
          Print  ErrMess23
          jmp  Exit

 ExitRestoreAttr:
          ret

 RestoreAttr  ENDP

;---------------------------------------------------------------

 OpenFile  PROC  near

	  mov  ah, 3Dh
          mov  dx, offset DTA + 1Eh
          int  21h
          jnc  ExitOpenFile
          Print  ErrMess19
          jmp  Exit
 ExitOpenFile:
	  mov  Handle, ax
	  mov  bx, ax
          ret

 OpenFile  ENDP

;---------------------------------------------------------------

 CloseFile  PROC  near

          mov  ah, 3Eh
          mov  bx, Handle
          int  21h
          jnc  ExitCloseFile
          Print  ErrMess21
          jmp  Exit
 ExitCloseFile:
          ret

 CloseFile  ENDP

;---------------------------------------------------------------

 GetTime  PROC  near

          ; Output = Date, Time

          mov  ax, 5700h
          mov  bx, Handle
          int  21h
          jnc  ExitGetTime
          Print  ErrMess24
          jmp  Exit

 ExitGetTime:
          mov  Time, cx
          mov  Date, dx
          ret

 GetTime  ENDP

;---------------------------------------------------------------

 RestoreTime  PROC  near

          ; Input  = Time, Date

          mov  ax, 5701h
          mov  bx, Handle
          mov  cx, Time
          mov  dx, Date
          int  21h
          jnc  ExitRestoreTime
          Print  ErrMess24
          jmp  Exit

 ExitRestoreTime:
          ret

 RestoreTime  ENDP

;---------------------------------------------------------------

 Buffer         LABEL  BYTE
 DirLevel       EQU    Buffer + 4 * 200h
 BufferSpace    EQU    DirLevel + 64
 StackSpace     EQU    BufferSpace + 100h

 ;---------------------------------------------------------------

_TEXT     ENDS

          END  Entry
