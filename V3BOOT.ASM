;===========================================================
;
;         Vaccine III    for Boot (Verson 64)
;                        1994/11/10
;                        by Cheolsoo Ahn
;
;===========================================================

CR        =     0Dh
LF        =     0Ah
TAB       =     09h
SPACE     =     20h

STCKSIZE  =    100h
PATHSIZE  =     40h
PATHNO    =     10
BUFFSIZE  =    200h

.MODEL SMALL

.STACK STCKSIZE


.DATA
;===========================================================
;        Initialized Data
;===========================================================

eMsg0     DB   '…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª', CR, LF
          DB   '∫                                                ∫', CR, LF
          DB   '∫        Vaccine III for Boot Virus  V64         ∫', CR, LF
          DB   '∫                                                ∫', CR, LF
          DB   '∫  (c) 1990-1995  Ahn Cheolsoo',27h,'s Anti-Virus Lab  ∫', CR, LF
          DB   '∫                                                ∫', CR, LF
          DB   '»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº$'
k1Msg0    DB   '‘…‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘ª', CR, LF
          DB   '‘∫                                              ‘∫', CR, LF
          DB   '‘∫       §Ç Ø• III (¶ÅÀa §a∑°ú·Øa∂w)  V64       ‘∫', CR, LF
          DB   '‘∫                                              ‘∫', CR, LF
          DB   '‘∫  (∏·) 1990-1995  ¥e¿ÈÆÅƒÒœA»·§a∑°ú·ØaµeäÅ≠°  ‘∫', CR, LF
          DB   '‘∫                                              ‘∫', CR, LF
          DB   '‘»‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘Õ‘º$'
k2Msg0    DB   '¶Æ¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶Ø', CR, LF
          DB   '¶≠                                              ¶≠', CR, LF
          DB   '¶≠       πÈ Ω≈ III (∫Œ∆Æ πŸ¿Ã∑ØΩ∫øÎ)  V64       ¶≠', CR, LF
          DB   '¶≠                                              ¶≠', CR, LF
          DB   '¶≠  (¿˙) 1990-1995  æ»√∂ºˆƒƒ«ª≈ÕπŸ¿Ã∑ØΩ∫ø¨±∏º“  ¶≠', CR, LF
          DB   '¶≠                                              ¶≠', CR, LF
          DB   '¶±¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶¨¶∞$'

BvMemData DW   0ABh
          DW   OFFSET AircopStr
          DW   OFFSET AircopNm
          DW   OFFSET AircopTm
          DW   81h
          DW   OFFSET AngelStr
          DW   OFFSET AngelNm
          DW   OFFSET AngelTm
          DW   79h
          DW   OFFSET CmosStr
          DW   OFFSET CmosNm
          DW   OFFSET CmosTm
          DW   153h
          DW   OFFSET XCmosStr
          DW   OFFSET XCmosNm
          DW   OFFSET XCmosTm
          DW   57h
          DW   OFFSET AntExeStr
          DW   OFFSET AntExeNm
          DW   OFFSET AntExeTm
          DW   0B7h
          DW   OFFSET AntTelStr
          DW   OFFSET AntTelNm
          DW   OFFSET AntTelTm
          DW   0B9h
          DW   OFFSET AntTelStr
          DW   OFFSET AntTelNm
          DW   OFFSET AntTelBTm
          DW   0AEh
          DW   OFFSET AzusaStr
          DW   OFFSET AzusaNm
          DW   OFFSET AzusaTm
          DW   77h
          DW   OFFSET BckUsrStr
          DW   OFFSET BckUsrNm
          DW   OFFSET BckUsrTm
          DW   125h
          DW   OFFSET BloodyStr
          DW   OFFSET BloodyNm
          DW   OFFSET BloodyTm
          DW   122h
          DW   OFFSET BloodyStr
          DW   OFFSET BloodyNm
          DW   OFFSET BloodyTm
          DW   60h
          DW   OFFSET B1Str
          DW   OFFSET B1Nm
          DW   OFFSET B1Tm
          DW   70h
          DW   OFFSET B437Str
          DW   OFFSET B437Nm
          DW   OFFSET B437Tm
          DW   16Fh
          DW   OFFSET BrainStr
          DW   OFFSET BrainNm
          DW   OFFSET BrainTm
          DW   31h
          DW   OFFSET BuptStr
          DW   OFFSET BuptNm
          DW   OFFSET BuptTm
          DW   1A3h
          DW   OFFSET DamaStr
          DW   OFFSET DamaNm
          DW   OFFSET DamaTm
          DW   62h
          DW   OFFSET DskKllStr
          DW   OFFSET DskKllNm
          DW   OFFSET DskKllTm
          DW   43h
          DW   OFFSET DrvIndStr
          DW   OFFSET DrvIndNm
          DW   OFFSET DrvIndTm
          DW   16Bh
          DW   OFFSET DullStr
          DW   OFFSET DullNm
          DW   OFFSET DullTm
          DW   13Fh
          DW   OFFSET FormStr
          DW   OFFSET FormNm
          DW   OFFSET FormTm
          DW   3B9h + 0Fh
          DW   OFFSET HideStr
          DW   OFFSET HideNm
          DW   OFFSET HideTm
          DW   6Ch
          DW   OFFSET HdSkStr
          DW   OFFSET HdSkNm
          DW   OFFSET HdSkTm
          DW   0E5Ch
          DW   OFFSET HdSk2Str
          DW   OFFSET HdSk2Nm
          DW   OFFSET HdSk2Tm
          DW   48h
          DW   OFFSET HoneyStr
          DW   OFFSET HoneyNm
          DW   OFFSET HoneyTm
          DW   229h
          DW   OFFSET JMStr
          DW   OFFSET JMNm
          DW   OFFSET JMTm
          DW   65h
          DW   OFFSET JoshiStr
          DW   OFFSET JoshiNm
          DW   OFFSET JoshiTm
          DW   8Fh
          DW   OFFSET KllDskStr
          DW   OFFSET KllDskNm
          DW   OFFSET KllDskTm
          DW   88h
          DW   OFFSET KimStr
          DW   OFFSET KimNm
          DW   OFFSET KimTm
          DW   145h
          DW   OFFSET LbcStr
          DW   OFFSET LbcNm
          DW   OFFSET LbcTm
          DW   169h
          DW   OFFSET Lbc2Str
          DW   OFFSET Lbc2Nm
          DW   OFFSET Lbc2Tm
          DW   77h
          DW   OFFSET LeanStr
          DW   OFFSET LeanNm
          DW   OFFSET LeanTm
          DW   80h
          DW   OFFSET MichStr
          DW   OFFSET MichNm
          DW   OFFSET MichTm
          DW   81h
          DW   OFFSET MichStr
          DW   OFFSET MichNm
          DW   OFFSET MichTm
          DW   0FBh
          DW   OFFSET MonkeyStr
          DW   OFFSET MonkeyNm
          DW   OFFSET MonkeyTm
          DW   2FBh
          DW   OFFSET MonkeyStr
          DW   OFFSET MonkeyNm
          DW   OFFSET MonkeyBTm
          DW   1DBh
          DW   OFFSET MountStr
          DW   OFFSET MountNm
          DW   OFFSET MountTm
          DW   74h
          DW   OFFSET NcDayStr
          DW   OFFSET NcDayNm
          DW   OFFSET NcDayTm
          DW   82h
          DW   OFFSET NointStr
          DW   OFFSET NointNm
          DW   OFFSET NointTm
          DW   6Fh
          DW   OFFSET OhioStr
          DW   OFFSET OhioNm
          DW   OFFSET OhioTm
          DW   61h
          DW   OFFSET OverwStr
          DW   OFFSET OverwNm
          DW   OFFSET OverwTm
          DW   8Bh
          DW   OFFSET ParityStr
          DW   OFFSET ParityNm
          DW   OFFSET ParityTm
          DW   88h
          DW   OFFSET PrtyBStr
          DW   OFFSET ParityNm
          DW   OFFSET PrtyBTm
          DW   41h
          DW   OFFSET PPStr
          DW   OFFSET PPNm
          DW   OFFSET PPTm
          DW   45h
          DW   OFFSET PocariStr
          DW   OFFSET PocariNm
          DW   OFFSET PocariTm
          DW   0A3h
          DW   OFFSET PrtChrStr
          DW   OFFSET PrtChrNm
          DW   OFFSET PrtChrTm
          DW   7Dh
          DW   OFFSET PrtScStr
          DW   OFFSET PrtScNm
          DW   OFFSET PrtScTm
          DW   0FEh
          DW   OFFSET RipStr
          DW   OFFSET RipNm
          DW   OFFSET RipTm
          DW   0B7h
          DW   OFFSET TimerStr
          DW   OFFSET TimerNm
          DW   OFFSET TimerTm
          DW   0CEh
          DW   OFFSET ScaleStr
          DW   OFFSET ScaleNm
          DW   OFFSET ScaleTm
          DW   0A1h
          DW   OFFSET SampoStr
          DW   OFFSET SampoNm
          DW   OFFSET SampoTm
          DW   0CCh
          DW   OFFSET SneakStr
          DW   OFFSET SneakNm
          DW   OFFSET SneakTm
          DW   0C9h
          DW   OFFSET SneakStr
          DW   OFFSET SneakNm
          DW   OFFSET SneakBTm
          DW   0E6h
          DW   OFFSET StamStr
          DW   OFFSET StamNm
          DW   OFFSET StamTm
          DW   0C0h
          DW   OFFSET StoneStr
          DW   OFFSET StoneNm
          DW   OFFSET StoneTm
          DW   0C0h
          DW   OFFSET StoneKStr
          DW   OFFSET StoneNm
          DW   OFFSET StoneKTm
          DW   0A0h
          DW   OFFSET SwissStr
          DW   OFFSET SwissNm
          DW   OFFSET SwissTm
          DW   0FFFFh

BvMemDt2  DW   98h
          DW   OFFSET FishStr
          DW   OFFSET FishNm
          DW   OFFSET FishTm
          DW   0B7h
          DW   OFFSET TimerStr
          DW   OFFSET TimerNm
          DW   OFFSET TimerTm
          DW   0FFFFh

FbsData   DW   0ABh
          DW   OFFSET AircopStr
          DW   OFFSET AircopNm
          DW   OFFSET AirCopTf
          DW   81h
          DW   OFFSET AngelStr
          DW   OFFSET AngelNm
          DW   OFFSET AngelTf
          DW   79h
          DW   OFFSET CmosStr
          DW   OFFSET CmosNm
          DW   OFFSET CmosTf
          DW   153h
          DW   OFFSET XCmosStr
          DW   OFFSET XCmosNm
          DW   OFFSET XCmosTf
          DW   57h
          DW   OFFSET AntExeStr
          DW   OFFSET AntExeNm
          DW   OFFSET AntExeTf
          DW   0B7h
          DW   OFFSET AntTelStr
          DW   OFFSET AntTelNm
          DW   OFFSET AntTelTf
          DW   0B9h
          DW   OFFSET AntTelStr
          DW   OFFSET AntTelNm
          DW   OFFSET AntTelTf
          DW   0AEh
          DW   OFFSET AzusaStr
          DW   OFFSET AzusaNm
          DW   OFFSET AzusaTf
          DW   77h
          DW   OFFSET BckUsrStr
          DW   OFFSET BckUsrNm
          DW   OFFSET BckUsrTf
          DW   125h
          DW   OFFSET BloodyStr
          DW   OFFSET BloodyNm
          DW   OFFSET BloodyTf
          DW   122h
          DW   OFFSET BloodyStr
          DW   OFFSET BloodyNm
          DW   OFFSET BloodyTf
          DW   60h
          DW   OFFSET B1Str
          DW   OFFSET B1Nm
          DW   OFFSET B1Tf
          DW   70h
          DW   OFFSET B437Str
          DW   OFFSET B437Nm
          DW   OFFSET B437Tf
          DW   16Fh
          DW   OFFSET BrainStr
          DW   OFFSET BrainNm
          DW   OFFSET BrainTf
          DW   31h
          DW   OFFSET BuptStr
          DW   OFFSET BuptNm
          DW   OFFSET BuptTf
          DW   0A3h
          DW   OFFSET DamaStr
          DW   OFFSET DamaNm
          DW   OFFSET DamaTf
          DW   62h
          DW   OFFSET DskKllStr
          DW   OFFSET DskKllNm
          DW   OFFSET DskKllTf
          DW   43h
          DW   OFFSET DrvIndStr
          DW   OFFSET DrvIndNm
          DW   OFFSET DrvIndTf
          DW   6Bh
          DW   OFFSET DullStr
          DW   OFFSET DullNm
          DW   OFFSET DullTf
          DW   98h
          DW   OFFSET FishStr
          DW   OFFSET FishNm
          DW   OFFSET FishTf
          DW   13Fh
          DW   OFFSET FormStr
          DW   OFFSET FormNm
          DW   OFFSET FormTf
          DW   6Ch
          DW   OFFSET HdSkStr
          DW   OFFSET HdSkNm
          DW   OFFSET HdSkTf
          DW   5Ch
          DW   OFFSET HdSk2Str
          DW   OFFSET HdSk2Nm
          DW   OFFSET HdSk2Tf
          DW   48h
          DW   OFFSET HoneyStr
          DW   OFFSET HoneyNm
          DW   OFFSET HoneyTf
          DW   29h
          DW   OFFSET JMStr
          DW   OFFSET JMNm
          DW   OFFSET JMTf
          DW   65h
          DW   OFFSET JoshiStr
          DW   OFFSET JoshiNm
          DW   OFFSET JoshiTf
          DW   8Fh
          DW   OFFSET KllDskStr
          DW   OFFSET KllDskNm
          DW   OFFSET KllDskTf
          DW   88h
          DW   OFFSET KimStr
          DW   OFFSET KimNm
          DW   OFFSET KimTf
          DW   45h
          DW   OFFSET LbcStr
          DW   OFFSET LbcNm
          DW   OFFSET LbcTf
          DW   69h
          DW   OFFSET Lbc2Str
          DW   OFFSET Lbc2Nm
          DW   OFFSET Lbc2Tf
          DW   77h
          DW   OFFSET LeanStr
          DW   OFFSET LeanNm
          DW   OFFSET LeanTf
          DW   80h
          DW   OFFSET MichStr
          DW   OFFSET MichNm
          DW   OFFSET MichTf
          DW   81h
          DW   OFFSET MichStr
          DW   OFFSET MichNm
          DW   OFFSET MichTf
          DW   0FBh
          DW   OFFSET MonkeyStr
          DW   OFFSET MonkeyNm
          DW   OFFSET MonkeyTf
          DW   1DBh
          DW   OFFSET MountStr
          DW   OFFSET MountNm
          DW   OFFSET MountTf
          DW   74h
          DW   OFFSET NcDayStr
          DW   OFFSET NcDayNm
          DW   OFFSET NcDayTf
          DW   82h
          DW   OFFSET NointStr
          DW   OFFSET NointNm
          DW   OFFSET NointTf
          DW   6Fh
          DW   OFFSET OhioStr
          DW   OFFSET OhioNm
          DW   OFFSET OhioTf
          DW   61h
          DW   OFFSET OverwStr
          DW   OFFSET OverwNm
          DW   OFFSET OverwTf
          DW   8Bh
          DW   OFFSET ParityStr
          DW   OFFSET ParityNm
          DW   OFFSET ParityTf
          DW   88h
          DW   OFFSET PrtyBStr
          DW   OFFSET ParityNm
          DW   OFFSET PrtyBTf
          DW   41h
          DW   OFFSET PPStr
          DW   OFFSET PPNm
          DW   OFFSET PPTf
          DW   45h
          DW   OFFSET PocariStr
          DW   OFFSET PocariNm
          DW   OFFSET PocariTf
          DW   0A3h
          DW   OFFSET PrtChrStr
          DW   OFFSET PrtChrNm
          DW   OFFSET PrtChrTf
          DW   7Dh
          DW   OFFSET PrtScStr
          DW   OFFSET PrtScNm
          DW   OFFSET PrtScTf
          DW   0FEh
          DW   OFFSET RipStr
          DW   OFFSET RipNm
          DW   OFFSET RipTf
          DW   0A1h
          DW   OFFSET SampoStr
          DW   OFFSET SampoNm
          DW   OFFSET SampoTf
          DW   0CEh
          DW   OFFSET ScaleStr
          DW   OFFSET ScaleNm
          DW   OFFSET ScaleTf
          DW   0CCh
          DW   OFFSET SneakStr
          DW   OFFSET SneakNm
          DW   OFFSET SneakTf
          DW   0C9h
          DW   OFFSET SneakStr
          DW   OFFSET SneakNm
          DW   OFFSET SneakTf
          DW   0E6h
          DW   OFFSET StamStr
          DW   OFFSET StamNm
          DW   OFFSET StamTf
          DW   0C0h
          DW   OFFSET StoneStr
          DW   OFFSET StoneNm
          DW   OFFSET StoneTf
          DW   0C0h
          DW   OFFSET StoneKStr
          DW   OFFSET StoneNm
          DW   OFFSET StoneTf
          DW   0A0h
          DW   OFFSET SwissStr
          DW   OFFSET SwissNm
          DW   OFFSET SwissTf
          DW   0B7h
          DW   OFFSET TimerStr
          DW   OFFSET TimerNm
          DW   OFFSET TimerTf
          DW   0FFFFh

MbsData   DW   81h
          DW   OFFSET AngelStr
          DW   OFFSET AngelNm
          DW   OFFSET AngelTh
          DW   79h
          DW   OFFSET CmosStr
          DW   OFFSET CmosNm
          DW   OFFSET CmosTh
          DW   153h
          DW   OFFSET XCmosStr
          DW   OFFSET XCmosNm
          DW   OFFSET XCmosTh
          DW   57h
          DW   OFFSET AntExeStr
          DW   OFFSET AntExeNm
          DW   OFFSET AntExeTh
          DW   0B7h
          DW   OFFSET AntTelStr
          DW   OFFSET AntTelNm
          DW   OFFSET AntTelTh
          DW   0B9h
          DW   OFFSET AntTelStr
          DW   OFFSET AntTelNm
          DW   OFFSET AntTelBTh
          DW   0AEh
          DW   OFFSET AzusaStr
          DW   OFFSET AzusaNm
          DW   OFFSET AzusaTh
          DW   77h
          DW   OFFSET BckUsrStr
          DW   OFFSET BckUsrNm
          DW   OFFSET BckUsrTh
          DW   125h
          DW   OFFSET BloodyStr
          DW   OFFSET BloodyNm
          DW   OFFSET BloodyTh
          DW   122h
          DW   OFFSET BloodyStr
          DW   OFFSET BloodyNm
          DW   OFFSET BloodyBTh
          DW   31h
          DW   OFFSET BuptStr
          DW   OFFSET BuptNm
          DW   OFFSET BuptTh
          DW   60h
          DW   OFFSET B1Str
          DW   OFFSET B1Nm
          DW   OFFSET B1Th
          DW   43h
          DW   OFFSET DrvIndStr
          DW   OFFSET DrvIndNm
          DW   OFFSET DrvIndTh
          DW   98h
          DW   OFFSET FishStr
          DW   OFFSET FishNm
          DW   OFFSET FishTh
          DW   2Dh
          DW   OFFSET HideStr2
          DW   OFFSET HideNm
          DW   OFFSET HideTh
          DW   5Ch
          DW   OFFSET HdSk2Str
          DW   OFFSET HdSk2Nm
          DW   OFFSET HdSk2Th
          DW   29h
          DW   OFFSET JMStr
          DW   OFFSET JMNm
          DW   OFFSET JMTh
          DW   65h
          DW   OFFSET JoshiStr
          DW   OFFSET JoshiNm
          DW   OFFSET JoshiTh
          DW   8Fh
          DW   OFFSET KllDskStr
          DW   OFFSET KllDskNm
          DW   OFFSET KllDskTh
          DW   45h
          DW   OFFSET LbcStr
          DW   OFFSET LbcNm
          DW   OFFSET LbcTh
          DW   77h
          DW   OFFSET LeanStr
          DW   OFFSET LeanNm
          DW   OFFSET LeanTh
          DW   80h
          DW   OFFSET MichStr
          DW   OFFSET MichNm
          DW   OFFSET MichTh
          DW   81h
          DW   OFFSET MichStr
          DW   OFFSET MichNm
          DW   OFFSET MichTh
          DW   0FBh
          DW   OFFSET MonkeyStr
          DW   OFFSET MonkeyNm
          DW   OFFSET MonkeyTh
          DW   74h
          DW   OFFSET NcDayStr
          DW   OFFSET NcDayNm
          DW   OFFSET NcDayTh
          DW   82h
          DW   OFFSET NointStr
          DW   OFFSET NointNm
          DW   OFFSET NointTh
          DW   61h
          DW   OFFSET OverwStr
          DW   OFFSET OverwNm
          DW   OFFSET OverwTh
          DW   8Bh
          DW   OFFSET ParityStr
          DW   OFFSET ParityNm
          DW   OFFSET ParityTh
          DW   88h
          DW   OFFSET PrtyBStr
          DW   OFFSET ParityNm
          DW   OFFSET PrtyBTh
          DW   45h
          DW   OFFSET PocariStr
          DW   OFFSET PocariNm
          DW   OFFSET PocariTh
          DW   0A3h
          DW   OFFSET PrtChrStr
          DW   OFFSET PrtChrNm
          DW   OFFSET PrtChrTh
          DW   0FEh
          DW   OFFSET RipStr
          DW   OFFSET RipNm
          DW   OFFSET RipTh
          DW   0A1h
          DW   OFFSET SampoStr
          DW   OFFSET SampoNm
          DW   OFFSET SampoTh
          DW   0CEh
          DW   OFFSET ScaleStr
          DW   OFFSET ScaleNm
          DW   OFFSET ScaleTh
          DW   0CCh
          DW   OFFSET SneakStr
          DW   OFFSET SneakNm
          DW   OFFSET SneakTh
          DW   0C9h
          DW   OFFSET SneakStr
          DW   OFFSET SneakNm
          DW   OFFSET SneakTh
          DW   0E6h
          DW   OFFSET StamStr
          DW   OFFSET StamNm
          DW   OFFSET StamTh
          DW   0C0h
          DW   OFFSET StoneStr
          DW   OFFSET StoneNm
          DW   OFFSET StoneTh
          DW   0C0h
          DW   OFFSET StoneKStr
          DW   OFFSET StoneNm
          DW   OFFSET StoneTh
          DW   0A0h
          DW   OFFSET SwissStr
          DW   OFFSET SwissNm
          DW   OFFSET SwissTh
          DW   0B7h
          DW   OFFSET TimerStr
          DW   OFFSET TimerNm
          DW   OFFSET TimerTh
          DW   0FFFFh

DbsData   DW   70h
          DW   OFFSET B437Str
          DW   OFFSET B437Nm
          DW   OFFSET B437Td
          DW   62h
          DW   OFFSET DskKllStr
          DW   OFFSET DskKllNm
          DW   OFFSET DskKllTd
          DW   6Bh
          DW   OFFSET DullStr
          DW   OFFSET DullNm
          DW   OFFSET DullTd
          DW   13Fh
          DW   OFFSET FormStr
          DW   OFFSET FormNm
          DW   OFFSET FormTd
          DW   41h
          DW   OFFSET PPStr
          DW   OFFSET PPNm
          DW   OFFSET PPTd
          DW   7Dh
          DW   OFFSET PrtScStr
          DW   OFFSET PrtScNm
          DW   OFFSET PrtScTd
          DW   0FFFFh

FvMemData DW   0FFFFh
;          DW   12Dh
;          DW   OFFSET JeruStr1
;          DW   OFFSET JeruNm
;          DW   OFFSET JeruTm1
;          DW   12Ch
;          DW   OFFSET JeruStr1
;          DW   OFFSET JeruNm
;          DW   OFFSET JeruTm1
;          DW   177h
;          DW   OFFSET JeruStr2
;          DW   OFFSET JeruNm
;          DW   OFFSET JeruTm1
;          DW   176h
;          DW   OFFSET JeruStr2
;          DW   OFFSET JeruNm
;          DW   OFFSET JeruTm1
;          DW   177h
;          DW   OFFSET JeruStr3
;          DW   OFFSET JeruNm
;          DW   OFFSET JeruTm2
;          DW   13Ch
;          DW   OFFSET SunStr
;          DW   OFFSET SunNm
;          DW   OFFSET SunTm
;          DW   13Ch
;          DW   OFFSET Sun17Str
;          DW   OFFSET Sun17Nm
;          DW   OFFSET SunTm
;         DW   114h
;         DW   OFFSET V1701St
;         DW   OFFSET V1701E
;         DW   114h
;         DW   OFFSET V1704St
;         DW   OFFSET V1704E
;         DW   510h
;         DW   OFFSET V1451St
;         DW   OFFSET V1451E
;         DW   0EBh
;         DW   OFFSET Nv30St
;         DW   OFFSET Nv30E
;         DW   0EBh
;         DW   OFFSET Nv30_6St
;         DW   OFFSET Nv30_6E
;         DW   0EBh
;         DW   OFFSET Nv30_7St
;         DW   OFFSET Nv30_7E
;         DW   146h
;         DW   OFFSET DavSt
;         DW   OFFSET DavE
;         DW   0Ch
;         DW   OFFSET SlowSt
;         DW   OFFSET SlowE
;         DW   1BCh
;         DW   OFFSET SepSt0
;         DW   OFFSET SepE
;         DW   17Ch
;         DW   OFFSET V1575St2
;         DW   OFFSET V1575E
;         DW   272h
;         DW   OFFSET V4096St
;         DW   OFFSET V4096E
;         DW   0FDh
;         DW   OFFSET BinSt
;         DW   OFFSET BinE
;         DW   21Dh
;         DW   OFFSET TermSt
;         DW   OFFSET TermE
;         DW   897h
;         DW   OFFSET Pl2900St
;         DW   OFFSET Pl2900E
;         DW   3B0h
;         DW   OFFSET TP05St
;         DW   OFFSET TP05E
;         DW   7D4h
;         DW   OFFSET TP44St
;         DW   OFFSET TP44E
;         DW   7DCh
;         DW   OFFSET TP45St
;         DW   OFFSET TP45E
;         DW   1D2h
;         DW   OFFSET DLSt
;         DW   OFFSET DLE
;         DW   106h
;         DW   OFFSET KPSt1
;         DW   OFFSET KPE
;         DW   19Bh
;         DW   OFFSET KitSt
;         DW   OFFSET KitE
;         DW   65h
;         DW   OFFSET SeoulSt
;         DW   OFFSET SeoulE
;         DW   1F1h
;         DW   OFFSET JdelSt
;         DW   OFFSET JdelE
;         DW   0E6h
;         DW   OFFSET AustSt
;         DW   OFFSET AustE
;         DW   271h
;         DW   OFFSET PiSt
;         DW   OFFSET PiE
;         DW   2BEh
;         DW   OFFSET StrSt
;         DW   OFFSET StrE
;         DW   1E3h
;         DW   OFFSET Mum11St
;         DW   OFFSET Mum11E
;         DW   19Dh
;         DW   OFFSET TraSt
;         DW   OFFSET TraE
;         DW   19Eh
;         DW   OFFSET Tra79St
;         DW   OFFSET Tra79E
;         DW   17Ch
;         DW   OFFSET NF3St
;         DW   OFFSET NF3E
;         DW   135h
;         DW   OFFSET TipSt
;         DW   OFFSET TipE
;         DW   118h
;         DW   OFFSET V905St
;         DW   OFFSET V905E
;         DW   27Bh
;         DW   OFFSET V1741St
;         DW   OFFSET V1741E
;         DW   339h
;         DW   OFFSET McGSt
;         DW   OFFSET McGE
;         DW   1D4h
;         DW   OFFSET LehighSt
;         DW   OFFSET LehighE
;         DW   71Bh
;         DW   OFFSET PossSt
;         DW   OFFSET PossE
;         DW   199h
;         DW   OFFSET MaltaSt
;         DW   OFFSET MaltaE
;         DW   136h
;         DW   OFFSET BthvnSt
;         DW   OFFSET BthvnE
;         DW   171h
;         DW   OFFSET Nov17St
;         DW   OFFSET Nov17E
;         DW   1BAh
;         DW   OFFSET AuroraSt
;         DW   OFFSET AuroraE
;         DW   117h
;         DW   OFFSET CurseSt
;         DW   OFFSET CurseE
;         DW   106h
;         DW   OFFSET KPUFOSt1
;         DW   OFFSET KPUFOE
;         DW   63Fh
;         DW   OFFSET OxanaSt
;         DW   OFFSET OxanaE
;         DW   2B1h
;         DW   OFFSET Scr2St
;         DW   OFFSET Scr2E
;         DW   12Eh
;         DW   OFFSET StormSt
;         DW   OFFSET StormE
;         DW   323h
;         DW   OFFSET Mc2824St
;         DW   OFFSET Mc2824E
;         DW   1DAh
;         DW   OFFSET Pi1548St
;         DW   OFFSET Pi1548E
;         DW   150h
;         DW   OFFSET Apr24St
;         DW   OFFSET Apr24E
;         DW   2B9h
;         DW   OFFSET KStrSt
;         DW   OFFSET KStrE
;         DW   33Bh
;         DW   OFFSET McGSt
;         DW   OFFSET McGE
;         DW   30h
;         DW   OFFSET NIRSt
;         DW   OFFSET NIRE
;         DW   118h
;         DW   OFFSET CurseCSt
;         DW   OFFSET CurseE
;         DW   118h
;         DW   OFFSET CurseDSt
;         DW   OFFSET CurseE
;         DW   3Ah
;         DW   OFFSET MXmasSt
;         DW   OFFSET MXmasE
;         DW   359h
;         DW   OFFSET V1013St
;         DW   OFFSET V1013E
;         DW   7Bh
;         DW   OFFSET CvexSt
;         DW   OFFSET CvexE
;         DW   5ABh
;         DW   OFFSET Key12St
;         DW   OFFSET Key12E
;         DW   239h
;         DW   OFFSET RoseSt
;         DW   OFFSET RoseE
;         DW   0D4h
;         DW   OFFSET WandSt
;         DW   OFFSET WandE
;         DW   436h
;         DW   OFFSET Wand13St
;         DW   OFFSET Wand13E
;         DW   45Fh
;         DW   OFFSET Wand14St
;         DW   OFFSET Wand14E
;         DW   0FFFFh

AircopStr DB   10, 8Bh, 7, 2Eh, 87h, 0, 89h, 7, 43h, 43h, 0E2h
CmosStr   DB   10, 73h, 3, 0E8h, 0CCh, 0, 0E8h, 0E8h, 0, 58h, 1Fh
XCmosStr  DB   10, 3Bh, 5, 75h, 34h, 0ADh, 3Bh, 45h, 2, 75h, 2Eh
AntExeStr DB   10, 57h, 0F3h, 0A6h, 05Fh, 74h, 0Eh, 81h, 0C7h, 0, 2
AntTelStr DB   10, 0BEh, 70h, 0, 3, 0F1h, 8Ah, 4Ch, 2, 8Ah, 74h
AzusaStr  DB   10, 8Eh, 0C0h, 0C7h, 6, 4Ch, 0, 0Bh, 0, 0A3h, 4Eh
BckUsrStr DB   10, 0ADh, 3Bh, 7, 75h, 2Ah, 0ADh, 3Bh, 47h, 2, 75h
BloodyStr DB   10, 0Eh, 7, 0FEh, 6, 8, 0, 80h, 3Eh, 8, 0
B1Str     DB   10, 0E8h, 2Dh, 1, 0E8h, 15h, 1, 72h, 55h, 0E8h, 0BCh
B437Str   DB   10, 0F3h, 0A4h, 0FFh, 2Eh, 0BFh, 7Ch, 33h, 0C0h, 0CDh, 13h
BrainStr  DB   10, 0E8h, 2Ah, 0, 0E8h, 4Bh, 0, 81h, 0C3h, 0, 2
BuptStr   DB   10, 0C6h, 6, 1Dh, 7Ch, 0, 0EAh, 4Dh, 6, 0, 0
DamaStr   DB   10, 0A3h, 0B8h, 1, 0E8h, 0E5h, 0, 73h, 2, 0CDh, 18h
DskKllStr DB   10, 75h, 8, 1Eh, 8Dh, 6, 3Bh, 2, 50h, 0FBh, 0CBh
DrvIndStr DB   10, 0C7h, 7, 0EFh, 1, 8Ch, 0C8h, 89h, 47h, 2, 0Eh
DullStr   DB   10, 8Bh, 0Eh, 0Bh, 1, 8Ah, 36h, 0Ah, 1, 0B2h, 80h
FishStr   DB   16, 2Eh, 8Ah, 2Eh, 0B5h, 0, 2Eh, 8Ah, 0Eh
          DB       0B6h, 0, 0B6h, 0, 2Eh, 8Ah, 16h, 0B7h
FormStr   DB   10, 0B8h, 1, 3, 8Bh, 0Eh, 49h, 0, 8Bh, 16h, 4Bh
HideStr   DB   10, 52h, 80h, 0E2h, 0F0h, 81h, 0FAh, 80h, 0, 5Ah, 75h
HideStr2  DB   10, 0CDh, 13h, 5Fh, 73h, 0Ch, 32h, 0E4h, 0CDh, 13h, 4Fh
HdSkStr   DB   10, 0CDh, 13h, 73h, 5, 59h, 0E2h, 0E5h, 0CDh, 18h, 59h
HdSk2Str  DB   10, 0F3h, 0A5h, 6, 0B8h, 64h, 7Ch, 50h, 0CBh, 6, 1Fh
HoneyStr  DB   10, 0B5h, 27h, 0B1h, 8, 0B6h, 1, 0B2h, 0, 0CDh, 13h
JMStr     DB   10, 0BBh, 39h, 7Ch, 0B9h, 7Eh, 1, 8Ah, 27h, 80h, 0F4h
JoshiStr  DB   9, 0A3h, 13h, 4, 0B1h, 6, 0D3h, 0E0h, 8Eh, 0C0h
KllDskStr DB   10, 0A3h, 0Eh, 0, 0E8h, 8Fh, 0, 73h, 2, 0CDh, 18h
KimStr    DB   7, 9Ch, 0FFh, 1Eh, 0BEh, 1, 72h, 28h
LbcStr    DB   10, 8Eh, 0D8h, 89h, 0Eh, 78h, 1, 89h, 16h, 7Ah, 1
Lbc2Str   DB   10, 0C7h, 6, 5Fh, 0, 0, 3, 0E8h, 27h, 0, 72h
MichStr   DB   10, 89h, 0Eh, 8, 0, 9Ch, 0FFh, 1Eh, 0Ah, 0, 72h
MonkeyStr DB   10, 0B8h, 1, 2, 9Ch, 2Eh, 0FFh, 1Eh, 0FCh, 1, 0C3h
MountStr  DB   10, 0CDh, 13h, 73h, 8, 4Fh, 75h, 0F9h, 31h, 0C0h, 0E9h
NcDayStr  DB   10, 0FCh, 0F3h, 0A4h, 2Eh, 0FFh, 2Eh, 2, 7Ch, 33h, 0C0h
NointStr  DB   10, 0FCh, 0F3h, 0A4h, 36h, 0FFh, 2Eh, 8Ah, 0, 8Eh, 0
OhioStr   DB   10, 0BBh, 0, 7Eh, 0B8h, 6, 2, 0CDh, 13h, 59h, 73h
OverwStr  DB   10, 0BBh, 0, 7Ch, 0B8h, 1, 2, 57h, 0CDh, 13h, 5Fh
ParityStr DB   10, 80h, 0FCh, 2, 75h, 47h, 83h, 0F9h, 1, 75h, 42h
PrtyBStr  DB   10, 80h, 0FCh, 2, 75h, 45h, 83h, 0F9h, 1, 75h, 40h
PPStr     DB   9, 0F3h, 0A5h, 8Eh, 0C8h, 0Eh, 1Fh, 0E8h, 0, 0
PocariStr DB   7, 0B8h, 5Bh, 1, 89h, 87h, 64h, 0
PrtChrStr DB   10, 0CDh, 13h, 72h, 0C0h, 80h, 0FAh, 80h, 74h, 5, 0B2h
PrtScStr  DB   10, 8Ah, 36h, 5Ch, 1, 8Bh, 0Eh, 5Dh, 1, 0CDh, 6Dh
RipStr    DB    8, 0CBh, 9Ch, 2Eh, 0FFh, 1Eh, 71h, 1, 0C3h
SampoStr  DB   10, 0FBh, 33h, 0C0h, 6, 53h, 0CBh, 0BFh, 4Ch, 0, 26h
ScaleStr  DB   10, 9Ch, 0FFh, 1Eh, 0Ah, 0, 73h, 6, 4Eh, 75h, 0F3h
SneakStr  DB   10, 72h, 8, 74h, 0Dh, 0E8h, 63h, 0, 0E8h, 32h, 0
StamStr   DB   10, 0F6h, 0C1h, 0FFh, 74h, 5, 0EAh, 0, 7Ch, 0, 0
StoneStr  DB   10, 0B1h, 6, 0D3h, 0E0h, 8Eh, 0C0h, 0A3h, 0Fh, 7Ch, 0B8h
StoneKStr DB   10, 0B1h, 6, 0D3h, 0E0h, 8Eh, 0C0h, 0A3h, 0Fh, 7Ch, 0EBh
SwissStr  DB   9, 75h, 7, 0BAh, 80h, 0, 0CDh, 13h, 0EBh, 20h
TimerStr  DB   10, 0CDh, 6Dh, 72h, 0Eh, 31h, 0F6h, 0FCh, 0ADh, 3Bh, 7
LeanStr   DB   10, 0A4h, 6, 0B8h, 7Eh, 0, 50h, 0CBh, 0E8h, 0F6h, 2
AngelStr  DB   10, 9Ch, 2Eh, 0FFh, 1Eh, 84h, 1, 73h, 3, 0E9h, 0A7h

;JeruStr1  DB   10, 0Fh, 20h, 0BAh, 11h, 8, 0D2h, 0EAh, 34h, 0F7h, 8Ch
;JeruStr2  DB   10, 2Eh, 89h, 1Eh, 17h, 0, 2Eh, 8Ch, 6, 19h, 0
;JeruStr3  DB   10, 2Eh, 89h, 1Eh, 13h, 0, 2Eh, 8Ch, 6, 15h, 0
;SunStr    DB   10, 8Dh, 0C9h, 8Fh, 0D1h, 0BDh, 5Eh, 7, 34h, 0C1h, 8Fh
;Sun17Str  DB   10, 8Dh, 0C9h, 8Fh, 0D1h, 0BDh, 0BFh, 7, 34h, 0C1h, 8Fh
;V1701Sr  DB   10, 8Eh, 0B8h, 4Eh, 2, 0BDh, 83h, 7, 32h, 35h, 32h
;V1704Sr  DB   10, 8Eh, 0B8h, 4Eh, 2, 0BDh, 86h, 7, 32h, 35h, 32h
;V1554xSr DB   7, 0Fh, 2, 2Fh, 0, 2Fh, 0Dh, 2
;V1554Sr  DB   8, 0E9h, 0D1h, 0FEh, 2Fh, 0, 2Fh, 0B5h, 6
;V1451Sr  DB   8, 0E9h, 38h, 0FFh, 2Fh, 0, 2Fh, 4Eh, 6
;Nv30Sr   DB   10, 8Dh, 0C9h, 8Fh, 0D1h, 0BDh, 0D1h, 8, 32h, 0C1h, 8Fh
;Nv30_6Sr DB   10, 8Dh, 0C9h, 8Fh, 0D1h, 0BDh, 0EBh, 8, 32h, 0C1h, 8Fh
;Nv30_7Sr DB   10, 8Dh, 0C9h, 8Fh, 0D1h, 0BDh, 0ECh, 8, 32h, 0C1h, 8Fh
;Tai677Sr DB   10, 0B5h, 40h, 0BAh, 0A6h, 3, 0BBh, 1, 0F9h, 0CEh, 22h
;Tai708Sr DB   10, 0B5h, 40h, 0BAh, 0C5h, 3, 0BBh, 1, 0F9h, 0CEh, 22h
;Tai743Sr DB   10, 0B5h, 40h, 0BAh, 0E8h, 3, 0BBh, 1, 0F9h, 0CEh, 22h
;Tai752Sr DB   10, 0B5h, 40h, 0BAh, 0F1h, 3, 0BBh, 1, 0F9h, 0CEh, 22h
;VienSr   DB   10, 8Ah, 0BDh, 17h, 1, 8Ch, 0FFh, 82h, 0C8h, 20h, 1
;DavSr    DB   10, 0ADh, 0AFh, 76h, 7, 0E3h, 0FBh, 8, 0EAh, 8Eh, 1
;InvSr    DB   10, 0E9h, 7Eh, 0FFh, 0E9h, 0AFh, 0FFh, 34h, 0C1h, 8Fh, 0C1h
;LibSr1   DB   9, 0BCh, 5Dh, 2, 8Ch, 10h, 1Fh, 5Ch, 4, 0CCh
;LibSr2   DB   9, 0E9h, 0EDh, 1, 0E9h, 0F5h, 1, 0E9h, 2, 2
;SlowSr   DB   6, 0BAh, 91h, 7, 2Fh, 81h, 35h
;SepSr1   DB   10, 7, 20h, 0B9h, 22h, 26h, 0BBh, 8Eh, 2, 0CEh, 22h
;SepSr2   DB   10, 0BFh, 6Eh, 2, 4, 0F1h, 0C0h, 1, 2, 0BAh, 6
;V1575Sr1 DB   6, 51h, 0B9h, 1, 2, 51h, 0CCh
;V1575Sr2 DB   10, 0E9h, 5Eh, 5, 0E9h, 0ACh, 1, 75h, 0Fh, 0A1h, 25h
;V4096Sr  DB   10, 0E9h, 1, 1, 5Ah, 82h, 0EAh, 76h, 3, 8Dh, 0C9h
;BinSr    DB   10, 2Fh, 81h, 3Fh, 0B1h, 1, 0ECh, 76h, 27h, 2Fh, 81h
;TermSr   DB   10, 2Fh, 81h, 3Fh, 0E4h, 3, 0ECh, 76h, 1Ch, 2Fh, 81h
;Pl2900Sr DB   10, 2Fh, 0, 2Fh, 1Dh, 1, 0E9h, 6Bh, 0, 0B5h, 1
;LepSr    DB   10, 8Ch, 1Fh, 9Bh, 4, 8Ch, 0Fh, 0ECh, 3, 8Ch, 17h
;TP05Sr   DB   10, 76h, 9, 27h, 0A1h, 0C8h, 1, 3Dh, 6, 74h, 33h
;TP44Sr   DB   8, 5Ch, 82h, 0ECh, 0D5h, 8, 2Fh, 0C7h, 88h
;TP45Sr   DB   8, 5Ch, 82h, 0ECh, 0DDh, 8, 2Fh, 0C7h, 88h
;DLSr     DB   10, 0BAh, 0A8h, 4, 0D2h, 0EAh, 0BFh, 26h, 2, 8Ah, 0F8h
;KPSr1    DB   10, 4, 1Fh, 3, 2, 54h, 0BCh, 34h, 2, 54h, 0CCh
;KPSr2    DB   10, 2Fh, 8Dh, 1Fh, 2Ah, 2, 0Fh, 20h, 0A4h, 1Ah, 2
;KitSr    DB   10, 0FBh, 8Fh, 17h, 0Ah, 1, 8Ch, 27h, 8, 1, 0FCh
;Dir2Sr   DB   10, 92h, 0C7h, 41h, 19h, 0, 8Ch, 79h, 14h, 0C8h, 41h
;SeoulSr  DB   10, 8Ch, 37h, 4, 2, 82h, 0C7h, 90h, 1, 0BAh, 6
;SonicSr  DB   10, 0E9h, 0E7h, 2, 0E9h, 0Fh, 2, 0E9h, 2Ah, 2, 0E9h
;JdelSr   DB   10, 7, 0BFh, 0F8h, 2, 57h, 0CCh, 8Dh, 0C9h, 8Fh, 0D1h
;Y4Sr     DB   10, 8Ch, 0D9h, 0B9h, 1, 58h, 0CEh, 22h, 84h, 0E2h, 0E1h
;AustSr   DB   10, 8Ch, 0FFh, 7, 0B9h, 0F1h, 1, 51h, 0F4h, 0A5h, 0CCh
;PiSr     DB   10, 2Fh, 0A2h, 2Ah, 2, 51h, 2Fh, 0A2h, 28h, 2, 51h
;StrSr    DB   7, 2Fh, 31h, 5, 47h, 0E3h, 0FAh, 0C4h
;Svc6Sr   DB   10, 02Fh, 3Bh, 0BDh, 24h, 13h, 73h, 4, 0EAh, 9Fh, 1
;Mum11Sr  DB   10, 2Fh, 0C8h, 7, 7Fh, 5, 0, 0, 2Fh, 8Ah, 17h
;TraSr    DB   10, 0A2h, 4, 1, 0BBh, 37h, 8, 0B2h, 5, 0D4h, 0EBh
;Tra79Sr  DB   10, 0A2h, 4, 1, 0BBh, 12h, 9, 0B2h, 5, 0D4h, 0EBh
;BBoSr    DB   10, 8Ch, 17h, 0AFh, 2, 82h, 0EBh, 0A5h, 1, 8Ah, 17h
;SatSr    DB   10, 8Fh, 46h, 2Dh, 5Fh, 57h, 84h, 0C7h, 21h, 0ADh, 0BAh
;KsunSr   DB   10, 82h, 0C4h, 0B0h, 3, 8Bh, 28h, 0BAh, 45h, 4, 0ADh
;V667Sr   DB   9, 0B5h, 48h, 33h, 0D3h, 0C7h, 7, 0CDh, 3, 5Dh
;NF3Sr    DB   10, 0Fh, 20h, 8Ah, 1Fh, 44h, 5, 8Dh, 7, 46h, 5
;TipSr    DB   7, 0F4h, 0A5h, 0B9h, 3Dh, 2, 51h, 0C4h
;SlaySr   DB   16,41h,0B2h,5, 0D4h,0E9h,8Dh,0DCh,4,0C4h,6,11h,1,8Fh,0D9h,8Dh,7
;V905Sr   DB   10, 0Fh, 20h, 0C7h, 7, 0A0h, 4, 2, 0B9h, 22h, 36h
;V1741Sr  DB   10, 0E9h, 94h, 1, 0E9h, 0A7h, 1, 5Eh, 0E9h, 25h, 1
;McGSr    DB   10, 51h, 0FDh, 0BAh, 0E4h, 0Bh, 0EBh, 0FCh, 5, 1, 1
;V657Sr   DB   9, 0B5h, 48h, 33h, 0D3h, 0C7h, 7, 0C3h, 3, 5Dh
;LehighSr DB   10, 0B9h, 22h, 36h, 0CEh, 22h, 8Ah, 5Dh, 0FDh, 8Dh, 45h
;PossSr1  DB   10, 2Fh, 8Ch, 1Fh, 0Dh, 2, 2Fh, 8Ch, 37h, 0Fh, 2
;PossSr2  DB   10, 8Fh, 0C1h, 27h, 81h, 3Fh, 0EDh, 2, 1, 76h, 7
;V928Sr   DB   10, 0E9h, 63h, 1, 0E9h, 0DAh, 2, 0E9h, 0ECh, 2, 73h
;BthvnSr1 DB   9, 7, 51h, 0EBh, 1, 4, 1, 1, 8Dh, 0C9h
;BthvnSr2 DB   9, 0E9h, 92h, 0Ah, 0E9h, 36h, 6, 0E9h, 43h, 6
;Nov17Sr1 DB   4, 52h, 0CCh, 4Eh, 5Bh
;Nov17Sr2 DB   10, 0F4h, 0A5h, 2Eh, 11h, 1, 51h, 0B9h, 7Dh, 2, 51h
;AuroraSr DB   10, 2Fh, 0A2h, 8Fh, 2, 84h, 0F9h, 1, 75h, 1Ah, 2Fh
;CurseSr  DB   10, 7, 0B9h, 24h, 2, 51h, 0EBh, 1, 1, 1, 1
;PS673Sr  DB   5, 0B9h, 49h, 2, 2Fh, 82h
;Tb448Sr  DB   10, 0BBh, 1, 2, 0BAh, 0C1h, 2, 0B5h, 41h, 0E9h, 15h
;KPUFOSr1 DB   10, 4, 1Fh, 3, 2, 54h, 0BCh, 44h, 2, 54h, 0CCh
;KPUFOSr2 DB   10, 2Fh, 8Dh, 1Fh, 3Ah, 2, 0Fh, 20h, 0A4h, 2Ah, 2
;OxanaSr  DB   10, 8Dh, 0C9h, 8Fh, 0D9h, 2Ch, 7, 0F8h, 4, 0A4h, 0F8h
;Scr2Sr   DB   7, 2Fh, 31h, 5, 47h, 0E3h, 0FAh, 0C4h
;StormSr  DB   10, 0B5h, 10h, 0CEh, 11h, 0C8h, 86h, 6Ch, 6, 1, 0B9h
;Mc2824Sr DB   10, 51h, 0FDh, 0BAh, 0F9h, 0Bh, 0EBh, 0FCh, 5, 1, 1
;Pi1548Sr DB   10, 0B5h, 0EEh, 0CEh, 22h, 0EAh, 11h, 5, 0EAh, 22h, 0
;Apr24Sr  DB   10, 7, 0B9h, 5Bh, 2, 51h, 0EBh, 0F5h, 4, 1, 1
;KStrSr   DB   10, 0ECh, 0F9h, 53h, 32h, 0CAh, 32h, 0D3h, 0B9h, 3, 43h
;NIRSr1   DB   10, 0BCh, 0B0h, 1, 0FAh, 27h, 1Ah, 1Fh, 3, 1, 7
;NIRSr2   DB   10, 0Fh, 20h, 0BFh, 7, 5, 0BAh, 9, 1, 0F4h, 0A7h
;CurseCSr DB   10, 7, 0B9h, 23h, 2, 51h, 0EBh, 1, 1, 1, 1
;CurseDSr DB   10, 7, 0B9h, 23h, 2, 51h, 0EBh, 2, 1, 1, 1
;MXmasSr  DB   10, 34h, 0F7h, 8Bh, 48h, 5, 3Dh, 1, 75h, 0Eh, 2Fh
;V1013Sr  DB   10, 2Fh, 8Fh, 7, 59h, 1, 0CEh, 22h, 0B9h, 22h, 36h
;CvexSr   DB   3, 0EAh, 0CFh, 3
;Key12Sr  DB   10, 0FBh, 2Fh, 8Dh, 1Fh, 0E5h, 6, 0Fh, 20h, 0A4h, 0D5h
;RoseSr   DB   10, 0F3h, 0AFh, 27h, 39h, 6, 0E1h, 0FAh, 84h, 0C8h, 4
;WandSr   DB   10, 7, 0B9h, 0DFh, 1, 51h, 0EBh, 5, 1, 1, 1
;Wand13Sr DB   10, 7, 0B9h, 41h, 5, 51h, 0EBh, 3, 1, 1, 1
;Wand14Sr DB   10, 7, 0B9h, 6Ah, 5, 51h, 0EBh, 1, 1, 1, 1
;FlipSr   DB   2, 0Fh, 0BCh, 0FEh, 2, 2, 20h, 0BAh, 0FEh, 2, 1, 0B3h, 0FEh, 1
;         DB   2, 82h, 0C2h, 0FEh, 2, 1, 0ECh, 0
;TeqSr1   DB   1, 0Fh, 0FFh, 3, 20h, 0FFh, 3, 0BFh, 0FEh, 2, 0FFh, 3, 0BCh
;         DB   0FEh, 2, 0FFh, 5, 0BAh, 0FEh, 2, 0FFh, 5, 8Bh, 1, 18h, 0
;TeqSr2   DB   1, 0Fh, 0FFh, 3, 20h, 0FFh, 3, 0BCh, 0FEh, 2, 0FFh, 3, 0BFh
;         DB   0FEh, 2, 0FFh, 5, 0BAh, 0FEh, 2, 0FFh, 5, 8Bh, 1, 15h, 0
;TeqSr3   DB   2, 8Dh, 0CCh, 0FFh, 3, 8Fh, 1, 0DCh, 0FFh, 3, 0BFh, 0FEh, 2
;         DB   0FFh, 3, 0BCh, 0FEh, 2, 0FFh, 5, 0BAh, 0FEh, 2, 0FFh, 5, 8Bh
;         DB   1, 18h, 0
;TeqSr4   DB   2, 8Dh, 0CCh, 0FFh, 3, 8Fh, 1, 0DCh, 0FFh, 3, 0BCh, 0FEh, 2
;         DB   0FFh, 3, 0BFh, 0FEh, 2, 0FFh, 5, 0BAh, 0FEh, 2, 0FFh, 5, 8Bh
;         DB   1, 15h, 0
;MaltaSr1 DB   0FFh, 8, 9Dh, 0FFh, 3, 51h, 0FFh,10, 5Bh, 0FEh, 1, 0FFh, 17, 5Ah
;         DB   0FFh, 8, 0BDh, 0FEh, 2, 0FFh, 8, 52h, 0FFh, 8, 0BAh, 0FEh, 2
;         DB   0FFh, 8, 53h, 0FFh,10, 54h, 0FFh, 9, 0Fh, 0FFh, 8, 0BFh, 0
;MaltaSr2 DB   0FFh, 8, 9Dh, 0FFh, 3, 51h, 0FFh, 2, 54h, 0FFh, 8, 1Fh
;         DB   0FFh, 3, 7, 0FFh, 2, 0Fh, 0FFh, 8, 8, 0FFh, 3, 0Fh
;         DB   0FFh, 9, 20h, 0FFh, 9, 0C0h, 0FEh, 2, 0FFh, 7, 0BAh, 0

AircopNm  DB   'Aircop$'
AngelNm   DB   'Angelina$'
CmosNm    DB   'Anti-CMOS$'
XCmosNm   DB   'Anti-Extended_CMOS$'
AntExeNm  DB   'Anti-EXE$'
AntTelNm  DB   'AntiTel$'
AzusaNm   DB   'Azusa$'
BckUsrNm  DB   'BackUSSR$'
BloodyNm  DB   'Bloody!$'
B1Nm      DB   'B1$'
B437Nm    DB   'Boot-437$'
BrainNm   DB   'Brain$'
BuptNm    DB   'BUPT Boot$'
DamaNm    DB   'Damanaegi$'
DskKllNm  DB   'Disk_Killer$'
DrvIndNm  DB   'Drive_Indicator$'
DullNm    DB   'Dull_Boy$'
FishNm    DB   'Fish_Boot$'
FormNm    DB   'Form$'
HideNm    DB   'Hiding Trojan horse$'
HdSkNm    DB   'Hide-and-Seek$'
HdSk2Nm   DB   'Hide-and-Seek.II$'
HoneyNm   DB   'Honey$'
JMNm      DB   'J&M$'
JoshiNm   DB   'Joshi$'
KllDskNm  DB   'Kill_Diskette$'
KimNm     DB   'Kim$'
LbcNm     DB   'LBC$'
Lbc2Nm    DB   'LBC.II$'
MichNm    DB   'Michelangelo$'
MonkeyNm  DB   'Monkey$'
MountNm   DB   'Mountain$'
NcDayNm   DB   'Nice_Day$'
NointNm   DB   'NoInt$'
OhioNm    DB   'Ohio$'
OverwNm   DB   'Overwriting_Boot$'
ParityNm  DB   'Parity_Boot$'
PPNm      DB   'Pingpong$'
PocariNm  DB   'Pocari$'
PrtChrNm  DB   'Print_Character$'
PrtScNm   DB   'PrintScreen$'
RipNm     DB   'Ripper$'
SampoNm   DB   'Sampo$'
ScaleNm   DB   'Scale$'
SneakNm   DB   'Sneaker$'
StamNm    DB   'Stamford$'
StoneNm   DB   'Stoned$'
SwissNm   DB   'Swiss_Boot$'
TimerNm   DB   'Timer$'
LeanNm    DB   'Leandro$'

;JeruNm    DB   'Jerusalem$'
;SunNm     DB   'Sunday$'
;Sun17Nm   DB   'Sunday.1733$'
;V1701Nm  DB   '1701$'
;V1704Nm  DB   '1704$'
;V1554xNm DB   '1554 or 1451$'
;V1554Nm  DB   '1554$'
;V1451Nm  DB   '1451$'
;Nv30Nm   DB   'November_30th$'
;Nv30_6Nm DB   'November_30th.2026$'
;Nv30_7Nm DB   'November_30th.2027$'
;Tai677Nm DB   'Taiwan.677$'
;Tai708Nm DB   'Taiwan.708$'
;Tai743Nm DB   'Taiwan.743$'
;Tai752Nm DB   'Taiwan.752$'
;VienNm   DB   'Vienna$'
;DavNm    DB   'Dark_Avenger$'
;InvNm    DB   'Invader$'
;LibNm    DB   'Liberty$'
;SlowNm   DB   'Slow$'
;SepNm    DB   'Separation$'
;V1575Nm  DB   '1575$'
;V4096Nm  DB   '4096$'
;BinNm    DB   'Bindae$'
;TermNm   DB   'Terminator$'
;Pl2900Nm DB   'Plastique.2900$'
;LepNm    DB   'Leprosy$'
;TP05Nm   DB   'TP05$'
;TP39Nm   DB   'TP39$'
;TP44Nm   DB   'TP44$'
;TP45Nm   DB   'TP45$'
;TP46Nm   DB   'TP46$'
;DLNm     DB   'DataLock$'
;KPNm     DB   'KeyPress$'
;KitNm    DB   'Kit$'
;Dir2Nm   DB   'Dir.II$'
;SeoulNm  DB   'Seoul$'
;SonicNm  DB   'Sonic$'
;JdelNm   DB   'Juvenile_Delinquent$'
;Y4Nm     DB   'Y4$'
;AustNm   DB   'Australian$'
;PiNm     DB   'Pipi$'
;StrNm    DB   'Stranger$'
;Svc6Nm   DB   'SVC.6.0$'
;Mum11Nm  DB   'Mummy.1.1$'
;TraNm    DB   'Traveller$'
;Tra79Nm  DB   'Traveller.1279$'
;BBoNm    DB   'BBodong$'
;SatNm    DB   'Saturday$'
;KsunNm   DB   'Korean_Sunday$'
;V667Nm   DB   '667$'
;NF3Nm    DB   'No_Frills.3.0$'
;TipNm    DB   'TIP$'
;SlayNm   DB   'Slayer$'
;V905Nm   DB   '905$'
;V1741Nm  DB   '1741$'
;McGNm    DB   'McGyver$'
;V657Nm   DB   '657$'
;LehighNm DB   'Lehigh$'
;PossNm   DB   'Possessed$'
;MaltaNm  DB   'Maltese Amoeba$'
;V928Nm   DB   '928$'
;BthvnNm  DB   'Beethoven$'
;Nov17Nm  DB   'November_17th$'
;AuroraNm DB   'Aurora$'
;CurseNm  DB   'Curse$'
;PS673Nm  DB   'PSMPC.673$'
;Tb448Nm  DB   'Turbo$'
;KPUFONm  DB   'KeyPress.UFO$'
;OxanaNm  DB   'Oxana$'
;Scr2Nm   DB   'Scream.II.696$'
;StormNm  DB   'Storm$'
;Mc2824Nm DB   'McGyver.2824$'
;Pi1548Nm DB   'Pipi.1548$'
;Apr24Nm  DB   'April_24th$'
;KStrNm   DB   'Korean_Stranger$'
;NIRNm    DB   'No_Import_Rice$'
;MXmasNm  DB   'Merry_Christmas$'
;V1013Nm  DB   '1013$'
;CvexNm   DB   'CVEX$'
;Key12Nm  DB   'Keypress.1236$'
;RoseNm   DB   'Rosebud$'
;WandNm   DB   'Wanderer$'
;Wand13Nm DB   'Wanderer.1347$'
;Wand14Nm DB   'Wanderer.1448$'
;FlipNm   DB   'Flip.2153$'
;TeqNm    DB   'Tequila$'

AircopTm  DB   0
          DW   1BCh
          DW   1
AngelTm   DB   0
          DW   184h
          DW   1
CmosTm    DB   0
          DW   7
          DW   2
XCmosTm   DB   0
          DW   6
          DW   1
AntExeTm  DB   10h, 0D3h
          DW   1
AntTelTm  DB   0
          DW   0AEh
          DW   1
AntTelBTm DB   0
          DW   0B0h
          DW   1
AzusaTm   DB   0
          DW   6Ch
          DW   1
BckUsrTm  DB   10h, 5Fh
          DW   1
BloodyTm  DB   0
          DW   0Bh
          DW   2
B1Tm      DB   0
          DW   1BCh
          DW   1
B437Tm    DB   0
          DW   0C5h
          DW   1
BrainTm   DB   10h, 6Dh
          DW   7
BuptTm    DB   0
          DW   1Fh
          DW   2
DamaTm    DB   0
          DW   1AEh
          DW   2
DskKllTm  DB   10h, 83h
          DW   8
DrvIndTm  DB   0
          DW   1FAh
          DW   1
DullTm    DB   10h, 6Dh
          DW   2
FishTm    DB   0
          DW   4AFh
          DW   0
FormTm    DB   0
          DW   41h
          DW   2
HideTm    DB   0
          DW   3B9h + 231h - 1FEh
          DW   1
HdSkTm    DB   10h, 6Dh
          DW   3
HdSk2Tm   DB   0
          DW   200h
          DW   4
HoneyTm   DB   10h, 60h
          DW   3
JMTm      DB   0
          DW   01BDh
          DW   2
JoshiTm   DB   0
          DW   7ACh
          DW   6
KllDskTm  DB   0
          DW   9
          DW   1
KimTm     DB   0
          DW   0BEh
          DW   1
LbcTm     DB   0
          DW   178h
          DW   2
Lbc2Tm    DB   0
          DW   50h
          DW   3
LeanTm    DB   10h, 7Fh
          DW   4
MichTm    DB   0
          DW   0Ah
          DW   2
MonkeyTm  DB   0
          DW   1FCh
          DW   1
MonkeyBTm DB   0
          DW   3FCh
          DW   1
MountTm   DB   10h, 60h
          DW   2
NcDayTm   DB   0
          DW   9
          DW   2
NointTm   DB   0
          DW   10Ch
          DW   2
OhioTm    DB   0
          DW   5E1h
          DW   7
OverwTm   DB   0
          DW   1A8h
          DW   1
ParityTm  DB   0
          DW   0D8h
          DW   1
PrtyBTm   DB   0
          DW   0D3h
          DW   1
PPTm      DB   0
          DW   12Ah
          DW   2
PocariTm  DB   10h, 1Fh
          DW   2
PrtChrTm  DB   20h
          DB   1Ch
          DW   1BEh
          DB   21h
          DW   1C2h
          DB   0
          DW   2
PrtScTm   DB   10h, 6Dh
          DW   2
RipTm     DB   0
          DW   171h
          DW   2
SampoTm   DB   0
          DW   20Ah
          DW   6
ScaleTm   DB   0
          DW   0Ah
          DW   2
SneakTm   DB   0
          DW   18Eh
          DW   1
SneakBTm  DB   0
          DW   18Bh
          DW   1
StamTm    DB   0
          DW   64h
          DW   1
StoneTm   DB   0
          DW   9
          DW   2
StoneKTm  DB   0
          DW   9
          DW   1
SwissTm   DB   0
          DW   1Fh
          DW   1
TimerTm   DB   10h, 6Dh
          DW   0

AircopTf  DB   90h
          DW   8Bh, 8Eh, 8Ah
          DB   0
AngelTf   DB   90h
          DW   6Dh, 6Eh, 6Ch
          DB   0
CmosTf    DB   80h
XCmosTf   DB   90h
          DW   0Bh, 0Dh, 0Ah
          DB   0
AntExeTf  DB   90h
          DW   5, 6, 4
          DB   0
AntTelTf  DB   80h
AzusaTf   DB   90h
          DW   0ECh, 0EFh, 0EBh
          DB   0
BckUsrTf  DB   90h
          DW   1A1h, 5Dh, 1A0h
          DB   0
BloodyTf  DB   90h
          DW   78h, 7Ah, 77h
          DB   0
B1Tf      DB   80h
B437Tf    DB   90h
          DW   85h, 8Fh, 0C4h
          DB   0
BrainTf   DB   90h
          DW   8, 6, 7
          DB   0
BuptTf    DB   80h
DamaTf    DB   90h
          DW   94h, 99h, 93h
          DB   0
DskKllTf  DB   0A0h
          DW   40h
          DB   0
DrvIndTf  DB   90h
          DW   58h, 0CBh, 0D1h
          DB   0
DullTf    DB   90h
          DW   7Dh, 80h, 7Ch
          DB   0
FishTf    DB   90h
          DW   0B5h, 0A3h, 0B6h
          DB   2
FormTf    DB   90h
          DW   4Ah, 4Ch, 49h
          DB   0
HdSkTf    DB   90h
          DW   35h, 32h, 34h
          DB   0
HdSk2Tf   DB   80h
HoneyTf   DB   90h
          DW   49h, 4Dh, 4Bh
          DB   -1
JMTf      DB   0B0h
          DB   0, 1, 0Eh
JoshiTf   DB   80h
KllDskTf  DB   90h
          DW   80h, 85h, 7Fh
          DB   0
KimTf     DB   90h
          DW   9Dh, 9Fh, 9Ch
          DB   0
LbcTf     DB   90h
          DW   5Eh, 63h, 5Dh
          DB   0
Lbc2Tf    DB   90h
          DW   63h, 68h, 62h
          DB   0
LeanTf    DB   90h
          DW   1Dh, 1Fh, 1Ch
          DB   0
MichTf    DB   90h
          DW   9, 1Ch, 8
          DB   0
MonkeyTf  DB   91h
          DW   45h, 75h, 72h
          DB   0
          DB   34h
          DW   1BFh
MountTf   DB   80h
NcDayTf   DB   90h
          DW   8, 0A0h, 7
          DB   0
NointTf   DB   90h
          DW   0AFh, 0B2h, 0AEh
          DB   0
OhioTf    DB   80h
OverwTf   DB   80h
ParityTf  DB   80h
PrtyBTf   DB   80h
PPTf      DB   0A0h
          DW   1F9h
          DB   1
PocariTf  DB   90h
          DW   69h, 17Dh, 68h
          DB   0
PrtChrTf  DB   90h
          DW   8, 0Ah, 7
          DB   0
PrtScTf   DB   90h
          DW   15Eh, 15Ch, 15Dh
          DB   0
RipTf     DB   90h
          DW   170h, 178h, 16Fh
          DB   0
SampoTf   DB   90h
          DW   40h, 145h, 41h
          DB   4
ScaleTf   DB   90h
          DW   167h, 163h, 166h
          DB   0
SneakTf   DB   90h
          DW   1B1h, 1B3h, 1B0h
          DB   0
StamTf    DB   90h
          DW   0F2h, 0F5h, 0F1h
          DB   0
StoneTf   DB   90h
          DW   108h, 10Bh, 107h
          DB   0
SwissTf   DB   90h
          DW   0AAh, 0ABh, 83h
          DB   0
TimerTf   DB   90h
          DW   8, 0Ah, 7
          DB   0

AngelTh   DB   10h
          DW   6Dh, 6Eh, 6Ch
          DB   0
CmosTh    DB   0
XCmosTh   DB   10h
          DW   199h, 19Ch, 198h
          DB   0
AntExeTh  DB   10h
          DW   5, 6, 4
          DB   0
AntTelTh  DB   10h
          DW   0F5h, 13Ah, 18Dh
          DB   0
AntTelBTh DB   10h
          DW   0F5h, 13Ah, 19Ch
          DB   0
AzusaTh   DB   0
BckUsrTh  DB   10h
          DW   1A1h, 56h, 1A0h
          DB   0
BloodyTh  DB   10h
          DW   11Fh, 122h, 11Eh
          DB   0
BloodyBTh DB   10h
          DW   11Ch, 11Fh, 11Bh
          DB   0
BuptTh    DB   0
B1Th      DB   10h
          DW   145h, 145h, 144h
          DB   0
DrvIndTh  DB   10h
          DW   58h, 5Eh, 95h
          DB   0
FishTh    DB   10h
          DW   0B5h, 0A3h, 0B6h
          DB   2
HideTh    DB   10h
          DW   1Fh, 22h, 1Eh
          DB   0
HdSk2Th   DB   10h
          DW   81h, 7Fh, 83h
          DB   5
JMTh      DB   20h
          DB   0, 0, 6
JoshiTh   DB   10h
          DW   1Eh, 95h, 1Fh
          DB   7
KllDskTh  DB   10h
          DW   80h, 85h, 7Fh
          DB   0
LbcTh     DB   10h
          DW   5Eh, 63h, 5Dh
          DB   0
LeanTh    DB   90h
          DW   1Dh, 1Fh, 1Ch
          DB   0
MichTh    DB   10h
          DW   9, 26h, 8
          DB   0
MonkeyTh  DB   11h
          DW   45h, 75h, 72h
          DB   0
          DB   34h
          DW   1BFh
NcDayTh   DB   0
NointTh   DB   10h
          DW   9Eh, 0A1h, 9Dh
          DB   0
OverwTh   DB   0
ParityTh  DB   10h
          DW   97h, 97h, 166h
          DB   0
PrtyBTh   DB   10h
          DW   94h, 94h, 160h
          DB   0
PocariTh  DB   10h
          DW   69h, 16Fh, 68h
          DB   0
PrtChrTh  DB   10h
          DW   8, 0Ah, 7
          DB   0
RipTh     DB   10h
          DW   170h, 178h, 16Fh
          DB   0
SampoTh   DB   10h
          DW   40h, 150h, 41h
          DB   4
ScaleTh   DB   10h
          DW   167h, 163h, 166h
          DB   0
SneakTh   DB   10h
          DW   1B1h, 1B3h, 1B0h
          DB   0
StamTh    DB   0
StoneTh   DB   10h
          DW   0FDh, 100h, 0FCh
          DB   0
SwissTh   DB   10h
          DW   85h, 0A4h, 83h
          DB   0
TimerTh   DB   10h
          DW   8, 0Ah, 7
          DB   0

B437Td    DB   90h
          DW   85h, 0A6h, 0ACh
          DB   0
DskKllTd  DB   80h
DullTd    DB   90h
          DW   0Ch, 0Ah, 0Bh
          DB   0
FormTd    DB   90h
          DW   4Ah, 4Ch, 49h
          DB   0
PPTd      DB   0A0h
          DW   1F9h
          DB   1
PrtScTd   DB   90h
          DW   15Eh, 15Ch, 15Dh
          DB   0

;JeruTm1   DB   0
;          DW   17h
;JeruTm2   DB   0
;          DW   13h
;SunTm     DB   0
;          DW   17h
 
VidAttr   DB   7
fLang     DB   0
fHelp     DB   0
fFD       DB   0
fSbdir    DB   0
fAll      DB   0
fCmp      DB   0
fErrSw    DB   0
fBvMem    DB   0
fFvMem    DB   0
fMbs      DB   0
fDbs      DB   0
OrgDir    DB   '\', (PATHSIZE - 1) DUP (0)
V3cfg     DB   'V3.CFG', 0
ArgNo     DB   0
CurArg    DB   0
Args      DB   (PATHNO * PATHSIZE) DUP (0)
RootDir   DB   '\', 0
UpDir     Db   '..', 0
AllFiles  DB   '*.*', 0
PathMsg   DB   'Checking '
CurPath   DB   0, ':\', (PATHSIZE - 3) DUP (0)
Exts      DB   'COM', 0, 'EXE', 0, 'OV?', 0, 'SYS', 0, 'BIN', 0
          DB   'PIF', 0, 'DAT', 0, 'FNT', 0, 'APP', 0, 'PGM', 0
          DB   'PRG', 0, 'SWP', 0, 'XTP', 0
Reboot    DD   0F000FFF0h

CrRt2     DB   LF
CrRt      DB   LF, CR, '$'
Colon     DB   ' : $'

MbsBin    DB  0FAh, 33h, 0C0h, 8Eh, 0D0h, 0BCh, 0, 7Ch
          DB  8Bh, 0F4h, 8Eh, 0C0h, 8Eh, 0D8h, 0FBh, 0FCh
          DB  0BFh, 0, 6, 0B9h, 0, 1, 0F2h, 0A5h
          DB  0EAh, 1Dh, 6, 0, 0, 0BEh, 0BEh, 7
          DB  0B3h, 4, 80h, 3Ch, 80h, 74h, 0Eh, 80h
          DB  3Ch, 0, 75h, 1Ch, 83h, 0C6h, 10h, 0FEh
          DB  0CBh, 75h, 0EFh, 0CDh, 18h, 8Bh, 0EEh, 8Bh
          DB  14h, 8Bh, 4Ch, 2, 83h, 0C6h, 10h, 0FEh
          DB  0CBh, 74h, 0Ah, 80h, 3Ch, 0, 74h, 0F4h
          DB  0BEh, 0C7h, 6, 0EBh, 30h, 0BFh, 4, 0
          DB  0B8h, 1, 2, 0BBh, 0, 7Ch, 57h, 0CDh
          DB  13h, 5Fh, 73h, 0Ch, 33h, 0C0h, 0CDh, 13h
          DB  4Fh, 75h, 0EDh, 0BEh, 0A8h, 6, 0EBh, 15h
          DB  0BFh, 0FEh, 7Dh, 81h, 3Dh, 55h, 0AAh, 74h
          DB  5, 0BEh, 8Fh, 6, 0EBh, 7, 8Bh, 0F5h
          DB  0EAh, 0, 7Ch, 0, 0, 0ACh, 0Ah, 0C0h
          DB  74h, 0Bh, 56h, 0B4h, 0Eh, 0BBh, 7, 0
          DB  0CDh, 10h, 5Eh, 0EBh, 0F0h, 0EBh, 0FEh
          DB  'Missing operating system', 0
          DB  'Error loading operating system', 0
          DB  'Invalid partition table', 0, 0

DbsBin    DB  0EBh, 3Ch, 90h
MsOem     DB  'MSDOS   '
          DB  33h DUP (0)
          DB  0FAh, 33h
          DB  0C0h, 8Eh, 0D0h, 0BCh, 0, 7Ch, 16h, 7
          DB  0BBh, 78h, 0, 36h, 0C5h, 37h, 1Eh, 56h
          DB  16h, 53h, 0BFh, 3Eh, 7Ch, 0B9h, 0Bh, 0
          DB  0FCh, 0F3h, 0A4h, 6, 1Fh, 0C6h, 45h, 0FEh
          DB  0Fh, 8Bh, 0Eh, 18h, 7Ch, 88h, 4Dh, 0F9h
          DB  89h, 47h, 2, 0C7h, 7, 3Eh, 7Ch, 0FBh
          DB  0CDh, 13h, 72h, 79h, 33h, 0C0h, 39h, 6
          DB  13h, 7Ch, 74h, 8, 8Bh, 0Eh, 13h, 7Ch
          DB  89h, 0Eh, 20h, 7Ch, 0A0h, 10h, 7Ch, 0F7h
          DB  26h, 16h, 7Ch, 3, 6, 1Ch, 7Ch, 13h
          DB  16h, 1Eh, 7Ch, 3, 6, 0Eh, 7Ch, 83h
          DB  0D2h, 0, 0A3h, 50h, 7Ch, 89h, 16h, 52h
          DB  7Ch, 0A3h, 49h, 7Ch, 89h, 16h, 4Bh, 7Ch
          DB  0B8h, 20h, 0, 0F7h, 26h, 11h, 7Ch, 8Bh
          DB  1Eh, 0Bh, 7Ch, 3, 0C3h, 48h, 0F7h, 0F3h
          DB  1, 6, 49h, 7Ch, 83h, 16h, 4Bh, 7Ch
          DB  0, 0BBh, 0, 5, 8Bh, 16h, 52h, 7Ch
          DB  0A1h, 50h, 7Ch, 0E8h, 92h, 0, 72h, 1Dh
          DB  0B0h, 1, 0E8h, 0ACh, 0, 72h, 16h, 8Bh
          DB  0FBh, 0B9h, 0Bh, 0, 0BEh, 0E6h, 7Dh, 0F3h
          DB  0A6h, 75h, 0Ah, 8Dh, 7Fh, 20h, 0B9h, 0Bh
          DB  0, 0F3h, 0A6h, 74h, 18h, 0BEh, 9Eh, 7Dh
          DB  0E8h, 5Fh, 0, 33h, 0C0h, 0CDh, 16h, 5Eh
          DB  1Fh, 8Fh, 4, 8Fh, 44h, 2, 0CDh, 19h
          DB  58h, 58h, 58h, 0EBh, 0E8h, 8Bh, 47h, 1Ah
          DB  48h, 48h, 8Ah, 1Eh, 0Dh, 7Ch, 32h, 0FFh
          DB  0F7h, 0E3h, 3, 6, 49h, 7Ch, 13h, 16h
          DB  4Bh, 7Ch, 0BBh, 0, 7, 0B9h, 3, 0
          DB  50h, 52h, 51h, 0E8h, 3Ah, 0, 72h, 0D8h
          DB  0B0h, 1, 0E8h, 54h, 0, 59h, 5Ah, 58h
          DB  72h, 0BBh, 5, 1, 0, 83h, 0D2h, 0
          DB  3, 1Eh, 0Bh, 7Ch, 0E2h, 0E2h, 8Ah, 2Eh
          DB  15h, 7Ch, 8Ah, 16h, 24h, 7Ch, 8Bh, 1Eh
          DB  49h, 7Ch, 0A1h, 4Bh, 7Ch, 0EAh, 0, 0
          DB  70h, 0, 0ACh, 0Ah, 0C0h, 74h, 29h, 0B4h
          DB  0Eh, 0BBh, 7, 0, 0CDh, 10h, 0EBh, 0F2h
          DB  3Bh, 16h, 18h, 7Ch, 73h, 19h, 0F7h, 36h
          DB  18h, 7Ch, 0FEh, 0C2h, 88h, 16h, 4Fh, 7Ch
          DB  33h, 0D2h, 0F7h, 36h, 1Ah, 7Ch, 88h, 16h
          DB  25h, 7Ch, 0A3h, 4Dh, 7Ch, 0F8h, 0C3h, 0F9h
          DB  0C3h, 0B4h, 2, 8Bh, 16h, 4Dh, 7Ch, 0B1h
          DB  6, 0D2h, 0E6h, 0Ah, 36h, 4Fh, 7Ch, 8Bh
          DB  0CAh, 86h, 0E9h, 8Ah, 16h, 24h, 7Ch, 8Ah
          DB  36h, 25h, 7Ch, 0CDh, 13h, 0C3h
          DB  CR, LF, 'Non-System disk or disk error'
          DB  CR, LF, 'Replace and press any key when ready'
          DB  CR, LF, 0
MsSysFile DB  'IO      SYS'
          DB  'MSDOS   SYS'
          DB  0, 0, 55h, 0AAh

PcOem     DB  'PCDOS   '
PcSysFile DB  'IBMBIO  COM'
          DB  'IBMDOS  COM'
DrOem     DB  'DRDOS   '
DrSysFile DB  'DRBIOS  SYS'
          DB  'DRBDOS  SYS'

pMsg      DW   OFFSET eMsgTbl
eMsgTbl   DW   OFFSET eMsg0
          DW   OFFSET eMsg1
          DW   OFFSET eMsg2
          DW   OFFSET eMsg3
          DW   OFFSET eMsg4
          DW   OFFSET eMsg5
          DW   OFFSET eMsg6
          DW   OFFSET eMsg7
          DW   OFFSET eMsg8
          DW   OFFSET eMsg9
          DW   OFFSET eMsg10
          DW   OFFSET eMsg11
          DW   OFFSET eMsg12
          DW   OFFSET eMsg13
          DW   OFFSET eMsg14
          DW   OFFSET eMsg15
          DW   OFFSET eMsg16
          DW   OFFSET eMsg17
k1MsgTbl  DW   OFFSET k1Msg0
          DW   OFFSET k1Msg1
          DW   OFFSET k1Msg2
          DW   OFFSET k1Msg3
          DW   OFFSET k1Msg4
          DW   OFFSET k1Msg5
          DW   OFFSET k1Msg6
          DW   OFFSET k1Msg7
          DW   OFFSET k1Msg8
          DW   OFFSET k1Msg9
          DW   OFFSET k1Msg10
          DW   OFFSET k1Msg11
          DW   OFFSET k1Msg12
          DW   OFFSET k1Msg13
          DW   OFFSET k1Msg14
          DW   OFFSET k1Msg15
          DW   OFFSET k1Msg16
          DW   OFFSET k1Msg17
k2MsgTbl  DW   OFFSET k2Msg0
          DW   OFFSET k2Msg1
          DW   OFFSET k2Msg2
          DW   OFFSET k2Msg3
          DW   OFFSET k1Msg4
          DW   OFFSET k2Msg5
          DW   OFFSET k2Msg6
          DW   OFFSET k2Msg7
          DW   OFFSET k2Msg8
          DW   OFFSET k1Msg9
          DW   OFFSET k2Msg10
          DW   OFFSET k2Msg11
          DW   OFFSET k2Msg12
          DW   OFFSET k2Msg13
          DW   OFFSET k2Msg14
          DW   OFFSET k2Msg15
          DW   OFFSET k2Msg16
          DW   OFFSET k2Msg17

eMsg1     DB   CR, LF, LF
          DB   'This program cannot be used for commercial purpose', CR, LF
          DB   'without a negotiated site license.$'
k1Msg1    DB   CR, LF, LF
          DB   '∑° œaù°ãaúë∑e ∏·∏b∏aµ¡ —s∑Å¥Ù∑°', CR, LF
          DB   '¨w¥Û∂w∑aù° ¨a∂wñI ÆÅ ¥ÙØsì°îa.$'
k2Msg1    DB   CR, LF, LF
          DB   '¿Ã «¡∑Œ±◊∑•¿∫ ¿˙¿€¿⁄øÕ «˘¿«æ¯¿Ã', CR, LF
          DB   'ªÛæ˜øÎ¿∏∑Œ ªÁøÎµ… ºˆ æ¯Ω¿¥œ¥Ÿ.$'
eMsg2     DB   'Usage: V3BOOT [drives:] [options]', CR, LF
;[\paths][files] [options]', CR, LF
          DB   '       (Options) /L  (L)anguage', CR, LF
          DB   '                     /L:E   (E)nglish', CR, LF
          DB   '                     /L:K1  (K)orean - combination code', CR, LF
          DB   '                     /L:K2  (K)orean - KS complete code', CR, LF
          DB   '                 /F  check several (F)loppy disks', CR, LF
;          DB   '                 /S  check lower (S)ubdirectories', CR, LF
;          DB   '                 /A  check (A)ll files', CR, LF
          DB   '                 /?  show this help message', CR, '$'
k1Msg2    DB   '¨a∂w§Û: V3BOOT [óaúa∑°ßaói:] [µ≥≠eói]', CR, LF
;[\ÃÅØaói][Ãa∑©ói] [µ≥≠eói]', CR, LF
          DB   '        (µ≥≠e)  /L  ¨a∂w ¥Â¥·', CR, LF
          DB   '                    /L:E   µw¥·', CR, LF
          DB   '                    /L:K1  π°–s—w –eãi', CR, LF
          DB   '                    /L:K2  µ≈¨˜—w –eãi', CR, LF
          DB   '                /F  µaú· ∏w∑Å œiù°œ° ó°Øa«aói∑i àÒ¨a', CR, LF
;          DB   '                /S  –a∂·∑Å ¨·ßaó°ùB…°ü°óiï° àÒ¨a', CR, LF
;          DB   '                /A  °°óe Ãa∑©ói∑i àÒ¨a', CR, LF
          DB   '                /?  ¨a∂w§Û∑i •°µa∫ë', CR, '$'
k2Msg2    DB   'ªÁøÎπ˝: V3BOOT [µÂ∂Û¿Ã∫ÍµÈ:] [ø…º«µÈ]', CR, LF
;[\∆–Ω∫µÈ][∆ƒ¿œµÈ] [ø…º«µÈ]', CR, LF
          DB   '        (ø…º«)  /L  ªÁøÎ ææÓ', CR, LF
          DB   '                    /L:E   øµæÓ', CR, LF
          DB   '                    /L:K1  ¡∂«’«¸ «—±€', CR, LF
          DB   '                    /L:K2  øœº∫«¸ «—±€', CR, LF
          DB   '                /F  ø©∑Ø ¿Â¿« «√∑Œ«« µΩ∫≈©µÈ¿ª ∞ÀªÁ', CR, LF
;          DB   '                /S  «œ¿ß¿« º≠∫Íµ∑∫≈‰∏ÆµÈµµ ∞ÀªÁ', CR, LF
;          DB   '                /A  ∏µÁ ∆ƒ¿œµÈ¿ª ∞ÀªÁ', CR, LF
          DB   '                /?  ªÁøÎπ˝¿ª ∫∏ø©¡‹', CR, '$'
eMsg3     DB   'Checking Memory : $'
k1Msg3    DB   'ã°¥‚∏w≠° àÒ¨a : $'
k2Msg3    DB   '±‚æÔ¿Âº“ ∞ÀªÁ : $'
eMsg4     DB   '                  $'
k1Msg4    DB   '                $'
eMsg5     DB   'Checking V3.EXE : $'
k1Msg5    DB   'V3.EXE àÒ¨a   : $'
k2Msg5    DB   'V3.EXE ∞ÀªÁ   : $'
eMsg6     DB   'CHECKING $'
k1Msg6    DB   ' àÒ¨a$'
k2Msg6    DB   ' ∞ÀªÁ$'
eMsg7     DB   'Master Boot Sector $'
k1Msg7    DB   '∫Å ¶ÅÀa ≠B»· $'
k2Msg7    DB   '¡÷ ∫Œ∆Æ ºΩ≈Õ $'
eMsg8     DB   'MS-DOS Boot Sector   : $'
k1Msg8    DB   'ï°Øa ¶ÅÀa ≠B»· : $'
k2Msg8    DB   'µµΩ∫ ∫Œ∆Æ ºΩ≈Õ : $'
eMsg9     DB   '                       $'
k1Msg9    DB   '                 $'
eMsg10    DB   'Directories & Files  : $'
k1Msg10   DB   'ó°ùB…°ü°µ¡ Ãa∑©: $'
k2Msg10   DB   'µ∑∫≈‰∏ÆøÕ ∆ƒ¿œ: $'
eMsg11    DB   'Insert a disk in drive and press <Enter>$'
k1Msg11   DB   'àÒ¨a–i ó°Øa«aüi ê˝â° <Enter> «°üi íÅüaØ≥Ø°µ°.$'
k2Msg11   dB   '∞ÀªÁ«“ µΩ∫≈©∏¶ ≥÷∞Ì <Enter> ≈∞∏¶ ¥©∏£Ω Ω√ø¿.$'
eMsg12    DB   'Continue anyway? (y/N) $'
k1Msg12   DB   'âÅ≠¢ ª•–ó–iåa∂a? (y/N) $'
k2Msg12   DB   '∞Ëº” ¡¯«‡«“±Óø‰? (y/N) $'
eMsg13    DB   'No (known) computer viruses$'
k1Msg13   DB   '(¥iùaª•) ƒÒœA»· §a∑°ú·Øaìe π•∏Å–aª° ¥g∑q$'
k2Msg13   DB   '(æÀ∑¡¡¯) ƒƒ«ª≈Õ πŸ¿Ã∑ØΩ∫¥¬ ¡∏¿Á«œ¡ˆ æ ¿Ω$'
eMsg14    DB   ' Virus found.', 7, '$'
k1Msg14   DB   ' Virus §iâe.', 7, '$'
k2Msg14   DB   ' Virus πﬂ∞ﬂ.', 7, '$'
eMsg15    DB   '                       Repair it? (y/N) $'
k1Msg15   DB   '                 â°√°âVØsì°åa? (y/N) $'
k2Msg15   DB   '                 ∞Ìƒ°∞⁄Ω¿¥œ±Ó? (y/N) $'
eMsg16    DB   ' -> Repaired$'
k1Msg16   DB   ' -> â°¡v∑q$'
k2Msg16   DB   ' -> ∞Ì√∆¿Ω$'
eMsg17    DB   'You must reboot to remove computer virus in memory completely.'
          DB   CR, LF, 'Press any key to reboot this computer.$'
k1Msg17   DB   'ã°¥‚∏w≠°µA¨· ƒÒœA»· §a∑°ú·Øaüi µ≈∏Â”° πAà·–aã° ∂·–Å¨·', CR, LF
          DB   'ƒÒœA»·üi îaØ° ¶ÅÀ∑Ø°≈a¥° –sì°îa. ¥a¢Å «°êa íÅüaØ≥Ø°µ°.$', CR, LF
k2Msg17   DB   '±‚æÔ¿Âº“ø°º≠ ƒƒ«ª≈Õ πŸ¿Ã∑ØΩ∫∏¶ øœ¿¸»˜ ¡¶∞≈«œ±‚ ¿ß«ÿº≠', CR, LF
          DB   'ƒƒ«ª≈Õ∏¶ ¥ŸΩ√ ∫Œ∆√Ω√ƒ—æﬂ «’¥œ¥Ÿ. æ∆π´ ≈∞≥™ ¥©∏£Ω Ω√ø¿.$', CR, LF

pErr      DW   OFFSET eErrTbl
eErrTbl   DW   OFFSET eErr0
          DW   OFFSET eErr1
          DW   OFFSET eErr2
          DW   OFFSET eErr3
          DW   OFFSET eErr4
          DW   OFFSET eErr5
          DW   OFFSET eErr6
          DW   OFFSET eErr7
          DW   OFFSET eErr8
          DW   OFFSET eErr9
;         DW   OFFSET eErr10
;         DW   OFFSET eErr11
;         DW   OFFSET eErr12
;         DW   OFFSET eErr13
;         DW   OFFSET eErr14
;         DW   OFFSET eErr15
;         DW   OFFSET eErr16
;         DW   OFFSET eErr17
k1ErrTbl  DW   OFFSET k1Err0
          DW   OFFSET eErr1
          DW   OFFSET k1Err2
          DW   OFFSET k1Err3
          DW   OFFSET k1Err4
          DW   OFFSET k1Err5
          DW   OFFSET k1Err6
          DW   OFFSET k1Err7
          DW   OFFSET k1Err8
          DW   OFFSET k1Err9
;         DW   OFFSET k1Err10
;         DW   OFFSET k1Err11
;         DW   OFFSET k1Err12
;         DW   OFFSET k1Err13
;         DW   OFFSET k1Err14
;         DW   OFFSET k1Err15
;         DW   OFFSET k1Err16
;         DW   OFFSET k1Err17
k2ErrTbl  DW   OFFSET k2Err0
          DW   OFFSET eErr1
          DW   OFFSET k2Err2
          DW   OFFSET k2Err3
          DW   OFFSET k2Err4
          DW   OFFSET k2Err5
          DW   OFFSET k2Err6
          DW   OFFSET k2Err7
          DW   OFFSET k2Err8
          DW   OFFSET k2Err9
;         DW   OFFSET k2Err10
;         DW   OFFSET k2Err11
;         DW   OFFSET k2Err12
;         DW   OFFSET eErr13
;         DW   OFFSET k2Err14
;         DW   OFFSET k2Err15
;         DW   OFFSET k2Err16
;         DW   OFFSET k2Err17

eErr0     DB   'ERROR: ', 7, '$'
k1Err0    DB   'µ°üA§i¨ó: ', 7, '$'
k2Err0    DB   'ø¿∑˘πﬂª˝: ', 7, '$'
eErr1     DB   'This program requires DOS 3.2 or above.$'
eErr2     DB   'Option is incorrect. Use /? to view options.$'
k1Err2    DB   'µ≥≠e∑i ∏i°µ ¨a∂w–ñØsì°îa.', CR, LF
          DB   '/?üi ¨a∂w–a°e ∏˜—¬–e µ≥≠e∑i •© ÆÅ ∑∂Øsì°îa.$'
k2Err2    DB   'ø…º«¿ª ¿ﬂ∏¯ ªÁøÎ«ﬂΩ¿¥œ¥Ÿ.', CR, LF
          DB   '/?∏¶ ªÁøÎ«œ∏È ¡§»Æ«— ø…º«¿ª ∫º ºˆ ¿÷Ω¿¥œ¥Ÿ.$'
eErr3     DB   'Drive is invalid. $'
k1Err3    DB   'óaúa∑°ßaàa π•∏Å–aª° ¥gØsì°îa. $'
k2Err3    DB   'µÂ∂Û¿Ã∫Í∞° ¡∏¿Á«œ¡ˆ æ Ω¿¥œ¥Ÿ. $'
eErr4     DB   'Cannot read disk. $'
k1Err4    DB   'ó°Øa«aüi ∑™∑i ÆÅ ¥ÙØsì°îa. $'
k2Err4    DB   'µΩ∫≈©∏¶ ¿–¿ª ºˆ æ¯Ω¿¥œ¥Ÿ. $'
eErr5     DB   'Cannot write disk. $'
k1Err5    DB   'ó°Øa«aµA ≥i ÆÅ ¥ÙØsì°îa. $'
k2Err5    DB   'µΩ∫≈©ø° æµ ºˆ æ¯Ω¿¥œ¥Ÿ. $'
eErr6     DB   'Pathname is invalid. $'
k1Err6    DB   'ÃÅØa∑°üq∑° π•∏Å–aª° ¥gØsì°îa. $'
k2Err6    DB   '∆–Ω∫¿Ã∏ß¿Ã ¡∏¿Á«œ¡ˆ æ Ω¿¥œ¥Ÿ. $'
eErr7     DB   'Cannot change directory. $'
k1Err7    DB   'ó°ùB…°ü°ù° ∑°ï∑–i ÆÅ ¥ÙØsì°îa. $'
k2Err7    DB   'µ∑∫≈‰∏Æ∑Œ ¿Ãµø«“ ºˆ æ¯Ω¿¥œ¥Ÿ. $'
eErr8     DB   'Cannot open file. $'
k1Err8    DB   'Ãa∑©∑i ¨a∂w–i ÆÅ ¥ÙØsì°îa. $'
k2Err8    DB   '∆ƒ¿œ¿ª ªÁøÎ«“ ºˆ æ¯Ω¿¥œ¥Ÿ. $'
eErr9     DB   'Cannot read file. $'
k1Err9    DB   'Ãa∑©∑i ∑™∑i ÆÅ ¥ÙØsì°îa. $'
k2Err9    DB   '∆ƒ¿œ¿ª ¿–¿ª ºˆ æ¯Ω¿¥œ¥Ÿ. $'


.DATA?
;===========================================================
;        Uninitialized Data
;===========================================================
;EndSeg    DW   ?
pSelfPath DD   ?
pSelfName DD   ?
V3path    DB   PATHSIZE DUP (?)
pV3file   DW   ?
pArgs     DW   ?
OrgDrv    DB   ?
EndHd     DB   ?
CurDrv    DB   ?
CurHd     DB   ?
DirLevel  DB   40h DUP (?)
Dta       DB   80h DUP (?)
fDrv      DB   ?
fFile     DB   ?
ParaBlk   DW   5 DUP (?)
Buffer    DB   BUFFSIZE DUP (?)
VirType   DB   ?


.CODE
;===========================================================
;         Initialization
;===========================================================
Start:    mov  ax, @data
          mov  ds, ax

          call GetDosVersion
          cmp  ax, 0314h
          jae  SetCEH
          mov  ax, 1
          call PrtErr
          call PrtCr
          jmp  ErrExit

          ;-------------------------------------------------
          ;    Set Critical Error Handler
          ;-------------------------------------------------

SetCEH:   mov  ax, 2524h
          mov  dx, OFFSET CritErrHndler
          int  21h

          ;-------------------------------------------------
          ;    Get System Informations
          ;-------------------------------------------------

;          mov  ax, ss
;          mov  bx, sp
;          add  bx, 10h
;          mov  cl, 4
;          shr  bx, cl
;          add  ax, bx
;          mov  EndSeg, ax

          call GetVideoMode
          jnc  GKB
          mov  VidAttr, 57h

GKB:      call GetKsBios
          jnc  GSP
          mov  fLang, 2

GSP:      push di
          push es
          call GetSelfPath
          mov  WORD PTR pSelfPath, di
          mov  WORD PTR pSelfPath[2], es

          call GetSelfName
          mov  WORD PTR pSelfName, di
          mov  WORD PTR pSelfName[2], es
          pop  es
          pop  di

          push si
          push di
          push ds
          push es
          push ds
          pop  es
          mov  di, OFFSET V3path
          lds  si, pSelfPath
          cmp  BYTE PTR [si + 1], ':'
          jne  CalcLen
          movsw
CalcLen:  mov  cx, WORD PTR es:pSelfName
          sub  cx, si
          rep  movsb
          mov  es:pV3file, di
          pop  es
          pop  ds
          pop  di
          pop  si

          call GetCurrentDrive
          mov  OrgDrv, al

          mov  dx, OFFSET OrgDir + 1
          call GetDir

          mov  dx, OFFSET Dta
          call SetDTA

          ;-------------------------------------------------
          ;    Read V3.CFG
          ;-------------------------------------------------

          push si
          push di
          push es
          mov  si, OFFSET V3Cfg
          push ds
          pop  es
          mov  di, pV3file
          mov  cx, 7
          rep  movsb
          pop  es
          pop  di
          pop  si

          mov  dx, OFFSET V3path
          call OpenFileForRead
          jc   ParseCfg

          mov  dx, OFFSET Buffer
          call ReadFile
          jc   ParseCfg

          call CloseFile

          ;-------------------------------------------------
          ;    Parse V3.CFG
          ;-------------------------------------------------

ParseCfg: push si

          mov  si, OFFSET Buffer
ChkCfg:   lodsb
          cmp  al, 0
          je   ECfg
          cmp  al, '/'
          jne  ChkCfg

ChkCfgSw: lodsb
          cmp  al, 0
          je   ECfg
          and  al, 5Fh
          cmp  al, 'L'
          je   CfgLang
          cmp  al, 'F'
          je   CfgFd
          cmp  al, 'S'
          je   CfgSb
          cmp  al, 'A'
          je   CfgAll
          cmp  al, 'C'
          je   CfgCmp
          jmp  ChkCfg

CfgLang:  lodsb
          cmp  al, 0
ECfg:     je   EndCfg
          cmp  al, '/'
          je   ChkCfgSw
          cmp  al, ':'
          jne  ChkCfg

          lodsb
          cmp  al, 0
          je   EndCfg
          cmp  al, '/'
          je   ChkCfgSw
          and  al, 5Fh
          cmp  al, 'E'
          je   CfgEng
          cmp  al, 'K'
          je   CfgKor
          jmp  ChkCfg

CfgEng:   mov  fLang, 0
          jmp  ChkCfg

CfgKor:   lodsb
          cmp  al, 0
          je   EndCfg
          cmp  al, '/'
          je   ChkCfgSw
          cmp  al, '1'
          je   CfgKor1
          cmp  al, '2'
          je   CfgKor2
          jmp  ChkCfg

CfgKor1:  mov  fLang, 1
          jmp  ChkCfg

CfgKor2:  mov  fLang, 2
          jmp  ChkCfg

CfgFd:    mov  fFD, 1
          jmp  ChkCfg

CfgSb:    mov  fSbdir, 1
          jmp  ChkCfg

CfgAll:   mov  fAll, 1
          jmp  ChkCfg

CfgCmp:   mov  fCmp, 1
          jmp  ChkCfg

EndCfg:   pop  si

          ;-------------------------------------------------
          ;    Parse Command-Line
          ;-------------------------------------------------

ParseCmd: push si
          push di
          push ds
          push es

          push ds
          push es
          pop  ds
          pop  es
          mov  si, 81h

ChkCmd:   lodsb
          cmp  al, CR
          jne  ScanChr
ECmd:     jmp  EndCmd
ScanChr:  cmp  al, SPACE
          je   ChkCmd
          cmp  al, TAB
          je   ChkCmd
          cmp  al, '/'
          je   ChkCmdSw

          dec  si
          mov  di, OFFSET es:Args
          mov  al, PATHSIZE
          mul  es:ArgNo
          add  di, ax
          inc  es:ArgNo
          cmp  es:ArgNo, PATHNO
          ja   ChkArg
          cmp  BYTE PTR [si + 1], ':'
          je   ChkArg
          mov  al, es:OrgDrv
          add  al, 'A'
          mov  ah, ':'
          stosw

ChkArg:   lodsb
          cmp  al, CR
          je   ECmd
          cmp  al, SPACE
          je   ChkCmd
          cmp  al, TAB
          je   ChkCmd
          cmp  al, '/'
          je   ChkCmdSw
          cmp  es:ArgNo, PATHNO
          ja   ChkArg
          cmp  al, 'a'
          jb   StArg
          cmp  al, 'z'
          ja   StArg
          sub  al, 20h
StArg:    stosb
          jmp  ChkArg

ChkCmdSw: lodsb
          cmp  al, CR
          je   CSErr
          cmp  al, '?'
          je   CmdHelp
          and  al, 5Fh
          cmp  al, 'L'
          je   CmdLang
          cmp  al, 'F'
          je   CmdFd
          cmp  al, 'S'
          je   CmdSb
          cmp  al, 'A'
          je   CmdAll
          cmp  al, 'C'
          je   CmdCmp
CSErr:    jmp  CmdSwErr

CmdHelp:  mov  es:fHelp, 1
          jmp  ChkSwVal

CmdLang:  lodsw
          and  ah, 5Fh
          cmp  ax, 'E:'
          je   CmdEng
          cmp  ax, 'K:'
          je   CmdKor
          jmp  CmdSwErr

CmdEng:   mov  es:fLang, 0
          jmp  ChkSwVal

CmdKor:   lodsb
          cmp  al, '1'
          je   CmdKor1
          cmp  al, '2'
          je   CmdKor2
          jmp  CmdSwErr

CmdKor1:  mov  es:fLang, 1
          jmp  ChkSwVal

CmdKor2:  mov  es:fLang, 2
          jmp  ChkSwVal

CmdFd:    mov  es:fFD, 1
          jmp  ChkSwVal

CmdSb:    mov  es:fSbdir, 1
          jmp  ChkSwVal

CmdAll:   mov  es:fAll, 1
          jmp  ChkSwVal

CmdCmp:   mov  es:fCmp, 1

ChkSwVal: lodsb
          cmp  al, CR
          je   EndCmd
          cmp  al, SPACE
          je   CCmd
          cmp  al, TAB
          je   CCmd
          cmp  al, '/'
          jne  CmdSwErr
          jmp  ChkCmdSw
CCmd:     jmp  ChkCmd

CmdSwErr: mov  es:fErrSw, 1

EndCmd:   pop  es
          pop  ds
          pop  di
          pop  si
          cmp  ArgNo, 10
          jbe  SetLang
          mov  ArgNo, 10

          ;-------------------------------------------------
          ;    Set Language
          ;-------------------------------------------------

SetLang:  cmp  fLang, 0
          je   SVM
          cmp  fLang, 1
          jne  SetK2Msg
          mov  ax, OFFSET k1MsgTbl
          mov  pMsg, ax
          mov  ax, OFFSET k1ErrTbl
          mov  pErr, ax
          jmp  SVM

SetK2Msg: mov  ax, OFFSET k2MsgTbl
          mov  pMsg, ax
          mov  ax, OFFSET k2ErrTbl
          mov  pErr, ax


;===========================================================
;         Print Title
;===========================================================

SVM:      push ds
          pop  es

          call Cls
          call SetCurPos0

          cmp  VidAttr, 7
          jne  PrtColTl
          mov  ax, 0
          call PrtMsg
          jmp  PrtNtc

PrtColTl: push bp
          mov  ax, 1301h
          mov  bx, pMsg
          mov  bp, [bx]
          xor  bh, bh
          mov  bl, VidAttr
          mov  cx, 362
          xor  dx, dx
          int  10h
          pop  bp

PrtNtc:   mov  ax, 1
          call PrtMsg
          call PrtCr2


;===========================================================
;         Check Memory
;===========================================================

          ;-------------------------------------------------
          ;    Check Memory for Boot viruses
          ;-------------------------------------------------

ChkBvMem: mov  ax, 3
          cmp  fBvMem, 0
          je   PrtChkMem
          inc  ax
PrtChkMem:call PrtMsg

          push es
          xor  ax, ax
          mov  es, ax
          mov  ax, es:[413h]
          mov  cl, 6
          shl  ax, cl
          mov  es, ax
          mov  bx, OFFSET BvMemData
          call CheckVirusInMem
          jnc  ChkBvMem2

          inc  fBvMem
          mov  dx, [bx + 4]
          call Print
          mov  ax, 14
          call PrtMsg
          call RepairMemForBV
          mov  ax, 16
          call PrtMsg
          call PrtCr
          pop  es
          jmp  ChkBvMem

ChkBvMem2:mov  ax, 5000h
NextSeg:  push ax
          mov  es, ax
          mov  bx, OFFSET BvMemDt2
          call CheckVirusInMem
          pop  ax
          jc   BvMem2
          inc  ax
          cmp  ax, 0A000h
          jb   NextSeg
          pop  es
          jmp  ChkFvMem

BvMem2:   inc  fBvMem
          mov  dx, [bx + 4]
          call Print
          mov  ax, 14
          call PrtMsg
          call RepairMemForBV
          mov  ax, 16
          call PrtMsg
          call PrtCr
          pop  es

          ;-------------------------------------------------
          ;    Check Memory for File viruses
          ;-------------------------------------------------

ChkFvMem: cmp  fFvMem, 0
          je   Get21hSeg
          mov  ax, 4
          call PrtMsg

Get21hSeg:push es
          xor  ax, ax
          mov  es, ax
          mov  es, es:[86h]
          mov  bx, OFFSET FvMemData
          call CheckVirusInMem
          jnc  EndChkMem

          inc  fFvMem
          mov  dx, [bx + 4]
          call Print
          mov  ax, 14
          call PrtMsg
          call RepairMemForFV
          mov  ax, 16
          call PrtMsg
          call PrtCr
          pop  es
          jmp  ChkFvMem

EndChkMem:pop  es

          mov  al, fFvMem
          add  fBvMem, al
          cmp  fBvMem, 0
          jne  EndCM
          mov  ax, 13
          call PrtMsg
          call PrtCr
EndCM:    call PrtCr


;===========================================================
;         Check V3.EXE
;===========================================================

;          mov  ax, 5
;          call PrtMsg


;          call PrtCr2


;===========================================================
;              Print Help Message
;===========================================================

          cmp  fErrSw, 0
          je   ChkHelp
          mov  ax, 2
          call PrtErr
          call PrtCr
          jmp  ErrExit

ChkHelp:  cmp  fHelp, 0
          je   ChkArgNo
PrtHelp:  mov  ax, 2
          call PrtMsg
          jmp  Exit

ChkArgNo: cmp  ArgNo, 0
          je   PrtHelp


;===========================================================
;         Check Argument & Drive
;===========================================================

CalcArg:  mov  bx, OFFSET Args
          mov  al, PATHSIZE
          mul  CurArg
          add  bx, ax
          mov  pArgs, bx

          ; Print Argument

          cmp  fLang, 0
          jne  PrtArg
          mov  ax, 6
          call PrtMsg
PrtArg:   mov  dx, bx
          call PrtChr
          cmp  fLang, 0
          je   GetDrvTp
          mov  ax, 6
          call PrtMsg
GetDrvTp: call PrtCr2

          mov  al, [bx]
          sub  al , 'A'
          mov  CurDrv, al

          cmp  BYTE PTR [bx + 2], 0
          jne  CDir

          call GetDriveType
          cmp  al, 0
          je   ChkFfd
          cmp  al, 1
          je   GDP
          cmp  al, 2
          je   CDir
          cmp  al, 3
          je   CDir

          mov  ax, 3
          call PrtErr
          mov  ax, 12
          call PrtAsk
          jc   NArg
          jmp  ErrExit
NArg:     call PrtCr2
          jmp  NextArg

GDP:      cmp  CurDrv, 2
          jne  CDir
          jmp  GetDP
CDir:     jmp  ChkDir


;===========================================================
;         Check Boot Sectors
;===========================================================

          ;-------------------------------------------------
          ;    Check F/D Boot Sector
          ;-------------------------------------------------

ChkFfd:   cmp  fFD, 0
          je   ReadFBS
          mov  ax, 11
          call PrtMsg
Reinput:  call InputChr
          cmp  al, CR
          jne  Reinput
          call PrtCr2
          dec  CurArg

ReadFBS:  mov  ax, 8
          cmp  fDbs, 0
          je   PrtChkFbs
          inc  ax
PrtChkFbs:call PrtMsg

          mov  al, CurDrv
          call ReadDosBootSector
          jnc  ChkFBS
          call PrtCr
          mov  ax, 4
          call PrtErr
          mov  ax, 12
          call PrtAsk
          jc   EndFbs1
          jmp  ErrExit

ChkFBS:   mov  bx, OFFSET FbsData
          call CheckBootVirusInBS
          jc   BvFBS
          jmp  EndChkFbs

BvFBS:    inc  fDbs
          mov  dx, [bx + 4]
          call Print
          mov  ax, 14
          call PrtMsg
          call PrtCr
          mov  ax, 15
          call PrtAsk
          jnc  EndFbs1

          mov  al, CurDrv
          call RepairDosBootSector
          jnc  RpFBS
          call PrtCr
          call PrtErr
          mov  ax, 12
          call PrtAsk
          jc   EndFbs1
          jmp  ErrExit

RpFBS:    mov  ax, 16
          call PrtMsg
          call PrtCr
          jmp  ReadFBS

EndChkFbs:cmp  fDbs, 0
          jne  EndFbs2
          mov  ax, 13
          call PrtMsg
EndFbs1:  call PrtCr
EndFbs2:  call PrtCr
          jmp  ChkDir

          ;-------------------------------------------------
          ;    Check H/D Master Boot Sector
          ;-------------------------------------------------

GetDP:    mov  dl, 80h
          call GetDrivePara
          jnc  CalcEndHd
          mov  ax, 4
          call PrtErr
          call PrtCr
          jmp  ErrExit
CalcEndHd:add  dl, 7Fh
          mov  EndHd, dl

          mov  dl, 80h
ChkDrvNo: cmp  dl, EndHd
          jbe  ChkFmbs
          jmp  ReadDBS

ChkFmbs:  mov  CurHd, dl
          cmp  fMbs, 0
          je   PrtChkMbs
          mov  ax, 9
          call PrtMsg
          jmp  ReadMbs
PrtChkMbs:mov  ax, 7
          call PrtMsg
          mov  ah, 2
          sub  dl, 4Fh
          int  21h
          mov  dx, OFFSET Colon
          call Print

ReadMbs:  mov  dl, CurHd
          call ReadMasterBootSector
          jnc  ChkMBS
          call PrtCr
          mov  ax, 4
          call PrtErr
          mov  ax, 12
          call PrtAsk
          jc   NextMBS
          jmp  ErrExit

ChkMBS:   mov  bx, OFFSET MbsData
          call CheckBootVirusInBS
          jc   BvMBS
          jmp  EndChkMbs

BvMBS:    inc  fMbs
          mov  dx, [bx + 4]
          call Print
          mov  ax, 14
          call PrtMsg
          call PrtCr
          mov  ax, 15
          call PrtAsk
          jnc  NextMBS

          mov  dl, CurHd
          call RepairMasterBootSector
          jnc  RpMBS
          call PrtCr
          call PrtErr
          mov  ax, 12
          call PrtAsk
          jc   NextMBS
          jmp  ErrExit

RpMBS:    mov  ax, 16
          call PrtMsg
          call PrtCr
          jmp  ReadMBS

EndChkMbs:cmp  fMbs, 0
          jne  EndMbs
          mov  ax, 13
          call PrtMsg

NextMBS:  call PrtCr
EndMbs:   call PrtCr
          inc  dl
          jmp  ChkDrvNo

          ;-------------------------------------------------
          ;    Check H/D DOS Boot Sector
          ;-------------------------------------------------

ReadDBS:  mov  ax, 8
          cmp  fDbs, 0
          je   PrtChkDbs
          inc  ax
PrtChkDbs:call PrtMsg

          mov  al, CurDrv
          call ReadDosBootSector
          jnc  ChkDBS
          call PrtCr
          mov  ax, 4
          call PrtErr
          mov  ax, 12
          call PrtAsk
          jc   EndDBS1
          jmp  ErrExit

ChkDBS:   mov  bx, OFFSET DbsData
          call CheckBootVirusInBS
          jc   BvDBS
          jmp  EndChkDBS

BvDBS:    inc  fDbs
          mov  dx, [bx + 4]
          call Print
          mov  ax, 14
          call PrtMsg
          call PrtCr
          mov  ax, 15
          call PrtAsk
          jnc  EndDBS1

          mov  al, CurDrv
          call RepairDosBootSector
          jnc  RpDBS
          call PrtCr
          call PrtErr
          mov  ax, 12
          call PrtAsk
          jc   EndDBS1
          jmp  ErrExit

RpDBS:    mov  ax, 16
          call PrtMsg
          call PrtCr
          jmp  ReadDBS

EndChkDbs:cmp  fDbs, 0
          jne  EndDbs2
          mov  ax, 13
          call PrtMsg
EndDbs1:  call PrtCr
EndDbs2:  call PrtCr


;===========================================================
;         Check Directories & Files
;===========================================================

ChkDir:   jmp  ChkCurArg
          mov  di, OFFSET DirLevel
          mov  bp, di
          mov  ax, 0101h
          mov  cx, 20h
          rep  stosw
          mov  fDrv, 0
          mov  fFile, 0

          mov  si, pArgs
          lodsw
          mov  CurPath, al
          sub  al, 'A'
          call SetDrive

          cmp  WORD PTR [si], '\'
          je   RtDir
          cmp  BYTE PTR [si], 0
          jne  ChkPath

          mov  fDrv, 1
RtDir:    mov  dx, OFFSET RootDir
          jmp  SetCurDir

ChkPath:  mov  ah, 4Eh
          mov  cx, 110111b
          mov  dx, si
          int  21h
          jnc  ChkAttr
          mov  ax, 6
          call PrtErr
          mov  ax, 12
          call PrtAsk
          jc   NA1
          jmp  ErrExit
NA1:      call PrtCr2
          jmp  NextArg

ChkAttr:  mov  dx, si
          test BYTE PTR Dta[15h], 10000b
          jnz  SetCurDir
          mov  fFile, 1
          jmp  GetPath

SetCurDir:call SetDir
          jnc  AllFile
ErrSetDir:mov  ax, 7
          call PrtErr
          mov  ax, 12
          call PrtAsk
          jc   NA1
          jmp  ErrExit

AllFile:  mov  dx, OFFSET AllFiles

GetPath:  push dx
          mov  al, CurDrv
          mov  dx, OFFSET CurPath + 3
          call GetDir
          xor  al, al
          mov  cx, PATHSIZE
          mov  di, OFFSET CurPath
          repne scasb
          cmp  BYTE PTR [di - 2], '\'
          je   FindFile1
          mov  WORD PTR [di - 1], '\'

FindFile1:pop  dx
          mov  ah, 4Eh
          mov  cx, 100111b
          int  21h
          jc   ChkFsub
          call CheckFile
          jc   ErEx1

FindFile2:mov  ah, 4Fh
          mov  cx, 100111b
          int  21h
          jc   ChkFsub
          call CheckFile
          jnc  FindFile2
ErEx1:    jmp  ErrExit

ChkFsub:  cmp  fDrv, 1
          je   FindDir1
          cmp  fFile, 1
          je   NA2
          cmp  fSbdir, 0
          jne  FindDir1
NA2:      jmp  NextArg

ToUpDir:  cmp  bp, OFFSET DirLevel
          je   NA2
          mov  dx, OFFSET UpDir
          call SetDir
ErrSD:    jc   ErrSetDir
          mov  BYTE PTR ds:[bp], 1
          dec  bp

FindDir1: xor  bl, bl
          mov  ah, 4Eh
          mov  cx, 110111b
          mov  dx, OFFSET AllFiles
          int  21h
          jc   ToUpDir
ChkDirEnt:test BYTE PTR Dta[15h], 10000b
          jz   FindDir2
          cmp  BYTE PTR Dta[1Eh], '.'
          je   FindDir2
          inc  bl
          cmp  bl, ds:[bp]
          jne  FindDir2
          inc  BYTE PTR ds:[bp]
          mov  dx, OFFSET Dta + 1Eh
          call SetDir
          jc   ErrSD
          inc  bp

          mov  al, CurDrv
          mov  dx, OFFSET CurPath + 3
          call GetDir
          xor  al, al
          mov  cx, PATHSIZE - 3
          mov  di, OFFSET CurPath + 3
          repne scasb
          cmp  BYTE PTR [di - 2], '\'
          je   FindFile3
          mov  WORD PTR [di - 1], '\'
FindFile3:mov  ah, 4Eh
          mov  cx, 100111b
          mov  dx, OFFSET AllFiles
          int  21h
          jc   FindDir1
          call CheckFile
          jc   ErEx2

FindFile4:mov  ah, 4Fh
          mov  cx, 100111b
          mov  dx, OFFSET AllFiles
          int  21h
          jc   FindDir1
          call CheckFile
          jnc  FindFile4
ErEx2:    jmp  ErrExit

FindDir2: mov  ah, 4Fh
          mov  cx, 110111b
          mov  dx, OFFSET AllFiles
          int  21h
          jnc  ChkDirEnt
          jmp  ToUpDir

NextArg:  mov  ah, 3
          xor  bh, bh
          int  10h
          mov  ah, 2
          xor  dl, dl
          int  10h
          mov  ax, 10
          call PrtMsg
          mov  ax, 13
          call PrtMsg
          mov  ah, 3
          int  10h
          mov  cx, 79
          sub  cl, dl
PrtSp:    mov  ax, 0E20h
          int  10h
          loop PrtSp
          call PrtCr2

ChkCurArg:inc  CurArg
          mov  al, CurArg
          cmp  al, ArgNo
          jae  Exit
          jmp  CalcArg

          ;-------------------------------------------------
          ;    End Program
          ;-------------------------------------------------

Exit:     cmp  fBvMem, 0
          je   NoErr
          mov  ax, 17
          call PrtMsg
          call InputChr
          jmp  Reboot

NoErr:    xor  al, al

ErrExit:  push ax
          mov  al, OrgDrv
          call SetDrive
          mov  dx, OFFSET OrgDir
          call SetDir
          pop  ax
          mov  ah, 4Ch
          int  21h


;===========================================================
;         Procedures
;===========================================================

GetDosVersion  PROC

          ; Input : (none)
          ; Output: AX = DOS version

          push bx
          push cx

          mov  ax, 3000h
          int  21h
          xchg ah, al

          pop  cx
          pop  bx
          ret

GetDosVersion  ENDP

;-----------------------------------------------------------

GetVideoMode  PROC

          ; Input : (none)
          ; Output: Carry flag = clear (mono)
          ;                      set   (color)

          push ax
          push bx

          mov  ax, 0500h                ; set display page
          int  10h

          mov  ah, 0Fh                  ; get video mode
          int  10h
          cmp  al, 02
          je   ExitGVM
          cmp  al, 07                   ; text(monochrome)
          je   ExitGVM

          cmp  al, 3
          je   Color
          mov  ax, 0003                 ; set video mode
          int  10h
Color:    stc

ExitGVM:  pop  bx
          pop  ax
          ret

GetVideoMode  ENDP

;-----------------------------------------------------------

GetKsBios  PROC

          ; Input : (none)
          ; Output: Carry flag = clear (no)
          ;                      set   (KS-BIOS)

          push ax
          push bx
          push es

          xor  bx, bx
          mov  es, bx

          mov  ax, 0FD00h
          int  10h
          mov  ax, es
          or   ax, bx
          jz   ExitGKB

          stc

ExitGKB:  pop  es
          pop  bx
          pop  ax
          ret

GetKsBios  ENDP

;-----------------------------------------------------------

GetSelfPath  PROC

          ; Input : ES    = segment of PSP
          ; Output: ES:DI = address of self pathname

          push ax
          push cx

          mov  es, es:[2Ch]
          xor  al, al
          xor  di, di
          mov  cx, 7FFFh

GSP1:     repnz scasb
          cmp  es:[di], al
          loopnz GSP1
          add  di, 3

          pop  cx
          pop  ax
          ret

GetSelfPath  ENDP

;-----------------------------------------------------------

GetSelfName  PROC

          ; Input : ES:DI = address of self pathname
          ; Output: ES:DI = address of self filename

          push ax
          push si
          push ds

          cmp  BYTE PTR es:[di + 1], ':'
          jne  GSN1
          inc  di
          inc  di

GSN1:     push es
          pop  ds
          mov  si, di

GSN2:     lodsb
          cmp  al, 0
          je   ExitGSN
          cmp  al, '\'
          jne  GSN2
          mov  di, si
          jmp  GSN2

ExitGSN:  pop  ds
          pop  si
          pop  ax
          ret

GetSelfName  ENDP

;-----------------------------------------------------------

GetCurrentDrive  PROC

          ; Input : (none)
          ; Output: AL = drive(0 = A, etc)

          mov  ah, 19h
          int  21h

          ret

GetCurrentDrive  ENDP

;-----------------------------------------------------------

GetDir  PROC

          ; Input : AL    = drive
          ;         DS:DX = address of buffer
          ; Output: (if fail)
          ;         Carry flag = set

          push ax
          push dx
          push si

          mov  ah, 47h
          mov  si, dx
          mov  dl, al
          inc  dl
          int  21h

          pop  si
          pop  dx
          pop  ax
          ret

GetDir  ENDP

;-----------------------------------------------------------

SetDTA  PROC

          ; Input : DS:DX = address of DTA
          ; Output: (none)

          push ax

          mov  ah, 1Ah
          int  21h

          pop  ax
          ret

SetDTA  ENDP

;-----------------------------------------------------------

GetDriveType  PROC

          ; (assume F/D <= 2)
          ; Input : AL = drive number(0 = A, 1 = B, etc)
          ; Output: AL =  0  (floppy drive)
          ;               1  (hard drive)
          ;               2  (RAM drive)
          ;               3  (CD-ROM/network drive)
          ;              FFh (invalid drive)

          push bx
          push dx
          push ds

          cmp  al, 2
          jae  ChkNet
          int  11h
          and  ax, 1
          jz   InvDrv
FlDrv:    mov  al, 0
          jmp  ExitGDT

ChkNet:   mov  bl, al
          inc  bl
          push bx
          mov  ax, 4409h
          int  21h
          pop  bx
          jc   InvDrv
          and  dx, 1000h
          jz   ChkRamDrv
          mov  al, 3
          jmp  ExitGDT

ChkRamDrv:mov  ax, 3200h
          mov  dl, bl
          int  21h
          cmp  al, 0FFh
          je   InvDrv
          cmp  BYTE PTR [bx + 8], 1
          ja   HdDrv
          mov  al, 2
          jmp  ExitGDT

HdDrv:    mov  al, 1
          jmp  ExitGDT

InvDrv:   mov  al, 0FFh

ExitGDT:  pop  ds
          pop  dx
          pop  bx
          ret

GetDriveType  ENDP

;-----------------------------------------------------------

GetDrivePara  PROC

          ; Input : DL = drive(BIOS)
          ; Output: (if success)
          ;         BL = drive type
          ;         CX = maximum cylinder/sector number
          ;         DH = maximum head number
          ;         DL = number of physical drives
          ;         (if fail)
          ;         Carry flag = set


          push ax
          push di
          push es

          mov  ah, 8
          int  13h

          pop  es
          pop  di
          pop  ax
          ret

GetDrivePara  ENDP

;-----------------------------------------------------------

Cls  PROC

          ; Input : (none)
          ; Output: (none)

          push ax
          push bx
          push cx
          push dx
          push bp
          push es

          mov  ax, 1130h                ; get font info
          xor  bx, bx
          mov  dl, 24
          int  10h

          mov  ax, 600h
          mov  bh, 7
          xor  cx, cx
          mov  dh, dl
          mov  dl, 79
          int  10h

          pop  es
          pop  bp
          pop  dx
          pop  cx
          pop  bx
          pop  ax
          ret

Cls  ENDP

;-----------------------------------------------------------

SetCurPos0  PROC

          ; Input : (none)
          ; Output: (none)

          push dx

          xor  dx, dx
          call SetCurPos

          pop  dx
          ret

SetCurPos0  ENDP

;-----------------------------------------------------------

SetCurPos  PROC

          ; Input : DX = (DH = y, DL = x)
          ; Output: (none)

          push ax
          push bx

          mov  ah, 2
          xor  bh, bh
          int  10h

          pop  bx
          pop  ax
          ret

SetCurPos  ENDP

;-----------------------------------------------------------

PrtMsg  PROC

          ; Input : AX = message number
          ; Output: (none)

          push ax
          push bx
          push dx

          mov  bx, pMsg
          shl  ax, 1
          add  bx, ax

          mov  dx, [bx]
          call Print

          pop  dx
          pop  bx
          pop  ax
          ret

PrtMsg  ENDP

;-----------------------------------------------------------

PrtErr  PROC

          ; Input : AX = error number
          ; Output: (none)

          push ax
          push bx
          push dx

          mov  bx, pErr
          mov  dx, [bx]
          call Print

          shl  ax, 1
          add  bx, ax
          mov  dx, [bx]
          call Print

          pop  dx
          pop  bx
          pop  ax
          ret

PrtErr  ENDP

;-----------------------------------------------------------

PrtAsk  PROC

          ; Input : AX = message number
          ; Output: Carry flag = clear (No or <Return>)
          ;                      set   (Yes)

          push ax

RetryPA:  pop  ax
          push ax
          call PrtMsg

          call InputChr

          cmp  al, CR
          je   ExitPA
          and  al, 5Fh
          cmp  al, 'N'
          je   ExitPA
          cmp  al, 'Y'
          je   ErrPA
          call PrtCr
          jmp  RetryPA

ErrPA:    stc

ExitPA:   pop  ax
          ret

PrtAsk  ENDP

;-----------------------------------------------------------

PrtCr  PROC

          ; Input : (none)
          ; Output: (none)

          push ax
          push dx

          mov  ah, 9
          mov  dx, OFFSET CrRt
          int  21h

          pop  dx
          pop  ax
          ret

PrtCr  ENDP

;-----------------------------------------------------------

PrtCr2  PROC

          ; Input : (none)
          ; Output: (none)

          push ax
          push dx

          mov  ah, 9
          mov  dx, OFFSET CrRt2
          int  21h

          pop  dx
          pop  ax
          ret

PrtCr2  ENDP

;-----------------------------------------------------------

Print  PROC

          ; Input : DS:DX = address of string(end with $)
          ; Output: (none)

          push ax

          mov  ah, 9
          int  21h

          pop  ax
          ret

Print  ENDP

;-----------------------------------------------------------

PrtChr  PROC

          ; Input : DS:DX = address of ASCIIZ string
          ; Output: (none)

          push ax
          push bx
          push si

          mov  si, dx
          xor  bh, bh

NextCh:   lodsb
          cmp  al, 0
          je   ExitPC
          mov  ah, 0Eh
          int  10h
          jmp  NextCh

ExitPC:   pop  si
          pop  bx
          pop  ax
          ret

PrtChr  ENDP

;-----------------------------------------------------------

InputChr  PROC

          ; Input : (none)
          ; Output: AL = character

          mov  ax, 0C01h
          int  21h

          ret

InputChr  ENDP

;-----------------------------------------------------------

CheckVirusInMem  PROC

          ; Input : ES = segment of virus program
          ;         BX = offset of data table
          ; Output: Carry flag = clear (no virus)
          ;                      set   (virus)

          push ax
          push cx
          push dx
          push si
          push di

          xor  cx, cx

ChkVMem:  mov  di, [bx]
          cmp  di, 0FFFFh
          je   ExitCVM
          mov  si, [bx + 2]
          lodsb
          mov  cl, al
          repz cmpsb
          je   FdVMem
          add  bx, 8
          jmp  ChkVMem

FdvMem:   stc

ExitCVM:  pop  di
          pop  si
          pop  dx
          pop  cx
          pop  ax
          ret

CheckVirusInMem  ENDP

;-----------------------------------------------------------

RepairMemForBV  PROC

          ; Input : BX = offset of data table
          ;         ES = segment of boot virus
          ; Output: (none)

          push ax
          push bx
          push cx
          push dx
          push si
          push di
          push ds
          push es

          mov  si, [bx + 6]
          lodsb
          cmp  al, 0
          je   BvMem0h
          cmp  al, 10h
          je   BvMem10h
          cmp  al, 20h
          je   BvMem20h

BvMem0h:  lodsw
          mov  bx, ax
          lodsw
          push ax
          lds  dx, es:[bx]
          jmp  Repair13h

BvMem10h: lodsb
          mov  ah, 35h
          int  21h
          lodsw
          push ax
          mov  dx, bx
          push es
          pop  ds
Repair13h:mov  ax, 2513h
          int  21h
          jmp  ReMemSize

BvMem20h: lodsb
          cmp  al, 0
          je   GetMemSz

          mov  ah, 25h
          push ax
          lodsw
          mov  bx, ax
          pop  ax
          push ds
          lds  dx, es:[bx]
          int  21h
          pop  ds
          jmp  BvMem20h

GetMemSz: lodsw
          push ax

ReMemSize:xor  ax, ax
          mov  ds, ax
          pop  ax
          add  ds:[413h], ax

          pop  es
          pop  ds
          pop  di
          pop  si
          pop  dx
          pop  cx
          pop  bx
          pop  ax
          ret

RepairMemForBV  ENDP

;-----------------------------------------------------------

RepairMemForFV  PROC

          ; Input : BX = offset of data table
          ;         ES = segment of boot virus
          ; Output: (none)

          push ax
          push bx
          push dx
          push si
          push ds

          mov  si, [bx + 6]
          lodsb
          cmp  al, 0
          je   FvMem0

FvMem0:   lodsw
          mov  bx, ax

          xor  ax, ax
          mov  ds, ax
          cli
          mov  ax, es:[bx]
          mov  ds:[84h], ax
          mov  ax, es:[bx + 2]
          mov  ds:[86h], ax
          sti
          jmp  ExitRMFV

ExitRMFV: pop  ds
          pop  si
          pop  dx
          pop  bx
          pop  ax
          ret

RepairMemForFV  ENDP

;-----------------------------------------------------------

CheckBootVirusInBS  PROC

          ; Input : BX = offset of data table
          ; Output: Carry flag = clear (no virus)
          ;                      set   (virus)

          push ax
          push cx
          push dx
          push si
          push di

          xor  cx, cx

ChkBvBS:  mov  di, [bx]
          cmp  di, 0FFFFh
          je   ExitCBVBS
          add  di, OFFSET Buffer
          mov  si, [bx + 2]
          lodsb
          mov  cl, al
          repz cmpsb
          je   FdBvBS
          add  bx, 8
          jmp  ChkBvBS

FdBvBS:   stc

ExitCBVBS:pop  di
          pop  si
          pop  dx
          pop  cx
          pop  ax
          ret

CheckBootVirusInBS  ENDP

;-----------------------------------------------------------

RepairMasterBootSector  PROC

          ; Input : BX = offset of data table
          ;         DL = drive
          ; Output: (if fail)
          ;         Carry flag = set
          ;         AX         = 4 (disk read error)
          ;                      5 (disk write error)

          push ax
          push bx
          push cx
          push dx
          push si
          push di

          mov  si, [bx + 6]
          lodsb
          mov  VirType, al
          cmp  al, 0
          je   BvMbs0h
          cmp  al, 10h
          je   BvMbs10h
          cmp  al, 11h
          je   BvMbs11h
          cmp  al, 20h
          je   BvMbs20h

BvMbs0h:  call ReconstructMBS
          call WriteMasterBootSector
          jc   ErrWMBS
          jmp  ExitRMBS

BvMbs11h: mov  al, [si + 7]
          mov  cs:DeinsMBS, al
          mov  bx, [si + 8]
          mov  al, Buffer[bx]
          mov  cs:DekeyMBS, al
BvMbs10h: lodsw
          mov  bx, ax
          mov  ch, Buffer[bx]
          lodsw
          mov  bx, ax
          mov  dh, Buffer[bx]
          lodsw
          mov  bx, ax
          mov  cl, Buffer[bx]
          lodsb
          add  cl, al
          call ReadPhysicalSectorToBuffer
          jc   ErrRMBS
          cmp  VirType, 10h
          je   WMBS
          mov  si, OFFSET Buffer
          mov  di, si
          mov  cx, 200h
DecrptMBS:lodsb
DeinsMBS  DB   ?
DekeyMBS  DB   ?
          stosb
          loop DecrptMBS
WMBS:     call WriteMasterBootSector
          jc   ErrWMBS
          jmp  ExitRMBS

BvMbs20h: lodsb
          mov  ch, al
          lodsb
          mov  dh, al
          lodsb
          mov  cl, al
          call ReadPhysicalSectorToBuffer
          jc   ErrRMBS
          call WriteMasterBootSector
          jc   ErrWMBS
          jmp  ExitRMBS

ExitRMBS: pop  di
          pop  si
          pop  dx
          pop  cx
          pop  bx
          pop  ax
          ret

ErrRMBS:  pop  di
          pop  si
          pop  dx
          pop  cx
          pop  bx
          pop  ax
          mov  ax, 4
          stc
          ret

ErrWMBS:  pop  di
          pop  si
          pop  dx
          pop  cx
          pop  bx
          pop  ax
          mov  ax, 5
          stc
          ret

RepairMasterBootSector  ENDP

;-----------------------------------------------------------

RepairDosBootSector  PROC

          ; Input : BX = offset of data table
          ;         AL = drive
          ; Output: (if fail)
          ;         Carry flag = set
          ;         AX         = 4 (disk read error)
          ;                      5 (disk write error)

          push ax
          push bx
          push cx
          push dx
          push si
          push di

          push ax
          mov  si, [bx + 6]
          lodsb
          mov  VirType, al
          cmp  al, 80h
          je   BvDbs80h
          cmp  al, 90h
          je   BvDbs90h
          cmp  al, 91h
          je   BvDbs91h
          cmp  al, 0A0h
          je   BvDbsA0h
          cmp  al, 0B0h
          jne  BvDbs80h
          jmp  BvDbsB0h

BvDbs80h: pop  ax
          call ReconstructDBS
          call WriteDosBootSector
          jc   EWDBS
          jmp  ExitRDBS

BvDbs91h: mov  al, [si + 7]
          mov  cs:DeinsDBS, al
          mov  bx, [si + 8]
          mov  al, Buffer[bx]
          mov  cs:DekeyDBS, al
BvDbs90h: lodsw
          mov  bx, ax
          mov  ch, Buffer[bx]
          lodsw
          mov  bx, ax
          mov  dh, Buffer[bx]
          lodsw
          mov  bx, ax
          mov  cl, Buffer[bx]
          lodsb
          add  cl, al
          pop  ax
          mov  dl, al
          push ax
          call GetDriveType
          cmp  al, 0
          je   RPS2
          add  dl, 7Eh
RPS2:     call ReadPhysicalSectorToBuffer
          pop  ax
          jc   ErrRDBS
          cmp  VirType, 90h
          je   WDBS
          push ax
          mov  si, OFFSET Buffer
          mov  di, si
          mov  cx, 200h
DecrptDBS:lodsb
DeinsDBS  DB   ?
DekeyDBS  DB   ?
          stosb
          loop DecrptDBS
          pop  ax
WDBS:     call WriteDosBootSector
EWDBS:    jc   ErrWDBS
          jmp  ExitRDBS

BvDbsA0h: lodsw
          mov  bx, ax
          mov  dx, WORD PTR Buffer[bx]
          xor  cx, cx
          lodsb
          add  dl, al
          adc  dh, 0
          pop  ax
          call ReadLogicalSectorToBuffer
          jc   ErrRDBS
          call WriteDosBootSector
          jc   ErrWDBS
          jmp  ExitRDBS

BvDbsB0h: lodsb
          mov  ch, al
          lodsb
          mov  dh, al
          lodsb
          mov  cl, al
          pop  ax
          mov  dl, al
          push ax
          call GetDriveType
          cmp  al, 0
          je   RPS3
          add  dl, 7Eh
RPS3:     call ReadPhysicalSectorToBuffer
          pop  ax
          jc   ErrRDBS
          call WriteDosBootSector
          jc   ErrWDBS
          jmp  ExitRDBS

ExitRDBS: pop  di
          pop  si
          pop  dx
          pop  cx
          pop  bx
          pop  ax
          ret

ErrRDBS:  pop  di
          pop  si
          pop  dx
          pop  cx
          pop  bx
          pop  ax
          mov  ax, 4
          stc
          ret

ErrWDBS:  pop  di
          pop  si
          pop  dx
          pop  cx
          pop  bx
          pop  ax
          mov  ax, 5
          stc
          ret

RepairDosBootSector  ENDP

;-----------------------------------------------------------

ReconstructMBS  PROC

          push ax
          push cx
          push si
          push di

          mov  si, OFFSET MbsBin
          mov  di, OFFSET Buffer
          mov  cx, 0E0h
          rep  movsb
          xor  ax, ax
          mov  cx, 0DEh
          rep  stosb

          pop  di
          pop  si
          pop  cx
          pop  ax
          ret

ReconstructMBS  ENDP

;-----------------------------------------------------------

ReconstructDBS  PROC

          ; Input : AL = drive
          ; Output: (none)

          push ax
          push bx
          push cx
          push dx
          push si
          push di

          push ds
          mov  bl, al
          inc  bl
          mov  ax, 440Dh
          mov  cx, 0860h
          int  21h
          mov  si, dx
          add  si, 7
          mov  di, OFFSET es:DbsBin + 0Bh
          mov  cx, 1Ah
          rep  movsb
          pop  ds

          push ds
          mov  ah, 32h
          mov  dl, bl
          int  21h
          call GetDosVersion
          cmp  ax, 400h
          jb   DirSec
          inc  bx
DirSec:   mov  al, dl
          dec  al
          xor  cx, cx
          mov  dx, [bx + 10h]
          pop  ds

          call ReadLogicalSectorToBuffer

          mov  si, OFFSET PcSysFile
          mov  di, OFFSET Buffer
          mov  cx, 11
          repz cmpsb
          jne  ChkDrSys
          mov  si, OFFSET PcOem
          mov  di, OFFSET MsOem
          mov  cx, 8
          rep  movsb
          mov  si, OFFSET PcSysFile
          mov  di, OFFSET MsSysFile
          mov  cx, 22
          rep  movsb
          jmp  CpyDbs

ChkDrSys: mov  si, OFFSET DrSysFile
          mov  di, OFFSET Buffer
          mov  cx, 11
          repz cmpsb
          jne  CpyDbs
          mov  si, OFFSET DrOem
          mov  di, OFFSET MsOem
          mov  cx, 8
          rep  movsb
          mov  si, OFFSET DrSysFile
          mov  di, OFFSET MsSysFile
          mov  cx, 22
          rep  movsb

CpyDbs:   mov  si, OFFSET DbsBin
          mov  di, OFFSET Buffer
          mov  cx, 200h
          rep  movsb

          pop  di
          pop  si
          pop  dx
          pop  cx
          pop  bx
          pop  ax
          ret

ReconstructDBS  ENDP

;-----------------------------------------------------------

ReadMasterBootSector  PROC

          ; Input : DL = drive
          ; Output: (if fail)
          ;         Carry flag = set

          push cx
          push dx

          mov  cx, 1
          xor  dh, dh
          call ReadPhysicalSectorToBuffer

          pop  dx
          pop  cx
          ret

ReadMasterBootSector  ENDP

;-----------------------------------------------------------

ReadPhysicalSectorToBuffer  PROC

          ; Input : CH = cylinder
          ;         CL = sector
          ;         DH = head
          ;         DL = drive
          ; Output: (if fail)
          ;         Carry flag = set

          push bx

          mov  bx, OFFSET Buffer
          call ReadPhysicalSector

          pop  bx
          ret

ReadPhysicalSectorToBuffer  ENDP

;-----------------------------------------------------------

ReadPhysicalSector  PROC

          ; Input : BX = offset of buffer
          ;         CH = cylinder
          ;         CL = sector
          ;         DH = head
          ;         DL = drive
          ; Output: (if fail)
          ;         Carry flag = set

          push ax
          push si

          call FlushBuffer

          mov  si, 4

RetryRPS: mov  ax, 0201h
          int  13h
          jnc  ExitRPS

          call ResetDrive
          cmp  si, 0
          je   ErrRPS
          dec  si
          jmp  RetryRPS

ErrRPS:   stc

ExitRPS:  pop  si
          pop  ax
          ret

ReadPhysicalSector  ENDP

;-----------------------------------------------------------

WriteMasterBootSector  PROC

          ; Input : DL = drive
          ; Output: (if fail)
          ;         Carry flag = set

          push cx
          push dx

          mov  cx, 1
          xor  dh, dh
          call WritePhysicalSectorFromBuffer

          pop  dx
          pop  cx
          ret

WriteMasterBootSector  ENDP

;-----------------------------------------------------------

WritePhysicalSectorFromBuffer  PROC

          ; Input : CH = cylinder
          ;         CL = sector
          ;         DH = head
          ;         DL = drive
          ; Output: (if fail)
          ;         Carry flag = set

          push bx

          mov  bx, OFFSET Buffer
          call WritePhysicalSector

          pop  bx
          ret

WritePhysicalSectorFromBuffer  ENDP

;-----------------------------------------------------------

WritePhysicalSector  PROC

          ; Input : BX = offset of buffer
          ;         CH = cylinder
          ;         CL = sector
          ;         DH = head
          ;         DL = drive
          ; Output: (if fail)
          ;         Carry flag = set

          push ax
          push si

          call FlushBuffer

          mov  si, 4

RetryWPS: mov  ax, 0301h
          int  13h
          jnc  FlBfWPS

          call ResetDrive
          cmp  si, 0
          je   ErrWPS
          dec  si
          jmp  RetryWPS

ErrWPS:   stc
          jmp  ExitWPS

FlBfWPS:  call FlushBuffer

ExitWPS:  pop  si
          pop  ax
          ret

WritePhysicalSector  ENDP

;-----------------------------------------------------------

ReadDosBootSector  PROC

          ; Input : AL = drive (0 = A, etc)
          ; Output: (if fail)
          ;         Carry flag = set

          push cx
          push dx

          xor  cx, cx
          xor  dx, dx
          call ReadLogicalSectorToBuffer

          pop  dx
          pop  cx
          ret

ReadDosBootSector  ENDP

;-----------------------------------------------------------

ReadLogicalSectorToBuffer  PROC

          push bx

          mov  bx, OFFSET Buffer
          call ReadLogicalSector

          pop  bx
          ret

ReadLogicalSectorToBuffer  ENDP

;-----------------------------------------------------------

ReadLogicalSector  PROC  NEAR

          ; Input : AL    = drive (0 = A, etc)
          ;         CX:DX = starting sector
          ;         DS:BX = address of buffer
          ; Output: (if fail)
          ;         Carry flag = set

          push ax
          push bx
          push cx
          push dx
          push bp
          push si
          push di

          call FlushBuffer

          or   cx, cx
          jnz  RdHgPt
          mov  cx, 1
          int  25h
          pop  ax
          jnc  ExitRLS

          pop  di
          pop  si
          pop  bp
          pop  dx
          pop  cx
          pop  bx
          pop  ax

          push ax
          push bx
          push cx
          push dx
          push bp
          push si
          push di

RdHgPt:   mov  si, OFFSET ParaBlk
          mov  [si], dx
          mov  [si + 2], cx
          mov  WORD PTR [si + 4], 1
          mov  [si + 6], bx
          mov  [si + 8], ds

          mov  cx, -1
          mov  bx, si
          int  25h
          pop  ax

ExitRLS:  pop  di
          pop  si
          pop  bp
          pop  dx
          pop  cx
          pop  bx
          pop  ax
          ret

ReadLogicalSector  ENDP

;-----------------------------------------------------------

WriteDosBootSector  PROC

          ; Input : AL = drive (0 = A, etc)
          ; Output: (if fail)
          ;         Carry flag = set

          push cx
          push dx

          xor  cx, cx
          xor  dx, dx
          call WriteLogicalSectorFromBuffer

          pop  dx
          pop  cx
          ret

WriteDosBootSector  ENDP

;-----------------------------------------------------------

WriteLogicalSectorFromBuffer  PROC

          push bx

          mov  bx, OFFSET Buffer
          call WriteLogicalSector

          pop  bx
          ret

WriteLogicalSectorFromBuffer  ENDP

;-----------------------------------------------------------

WriteLogicalSector  PROC  NEAR

          ; Input : AL    = drive (0 = A, etc)
          ;         CX:DX = starting sector
          ;         DS:BX = address of buffer
          ; Output: (if fail)
          ;         Carry flag = set

          push ax
          push bx
          push cx
          push dx
          push bp
          push si
          push di

          call FlushBuffer

          or   cx, cx
          jnz  WrHgPt
          mov  cx, 1
          int  26h
          pop  ax
          jnc  FlBfWLS

          pop  di
          pop  si
          pop  bp
          pop  dx
          pop  cx
          pop  bx
          pop  ax

          push ax
          push bx
          push cx
          push dx
          push bp
          push si
          push di

WrHgPt:   mov  si, OFFSET ParaBlk
          mov  [si], dx
          mov  [si + 2], cx
          mov  WORD PTR [si + 4], 1
          mov  [si + 6], bx
          mov  [si + 8], ds

          mov  cx, -1
          mov  bx, si
          int  26h
          pop  ax
          jc   ExitWLS

FlBfWLS:  call FlushBuffer

ExitWLS:  pop  di
          pop  si
          pop  bp
          pop  dx
          pop  cx
          pop  bx
          pop  ax
          ret

WriteLogicalSector  ENDP

;-----------------------------------------------------------

ResetDrive  PROC

          ; Input : DL = drive(0 - 7Fh: F/D, 80h - FFh: H/D)
          ; Output: (if fail)
          ;         Carry flag = set

          push ax

          xor  ah, ah
          int  13h

          pop  ax
          ret

ResetDrive  ENDP

;-----------------------------------------------------------

FlushBuffer  PROC

          ; Input : (none)
          ; Output: (none)

          push ax

          mov  ah, 0Dh
          int  21h

          pop  ax
          ret

FlushBuffer  ENDP

;-----------------------------------------------------------

SetDrive  PROC

          ; Input : AL = drive(0 = A, etc)
          ; Output: AL = number of logical drives

          push dx

          mov  ah, 0Eh
          mov  dl, al
          int  21h

          pop  dx
          ret

SetDrive  ENDP

;-----------------------------------------------------------

SetDir  PROC

          ; Input : DS:DX = address of buffer
          ; Output: (if fail)
          ;         Carry flag = set

          push ax

          mov  ah, 3Bh
          int  21h

          pop  ax
          ret

SetDir  ENDP

;-----------------------------------------------------------

CheckFile  PROC

          cmp  fAll, 1
          je   PrtPn
          mov  di, OFFSET Dta + 1Eh
          mov  al, '.'
          mov  cx, 13
          repnz scasb
          mov  si, OFFSET Exts
          mov  cx, 12
NextExt:  push cx
          push si
          push di
          mov  cx, 4
ChkExt:   lodsb
          cmp  al, '?'
          je   WildChr
          cmp  [di], al
          jne  NotMtch
WildChr:  inc  di
          loop ChkExt
          pop  di
          pop  si
          pop  cx
          jmp  PrtPn
NotMtch:  pop  di
          pop  si
          pop  cx
          add  si, 4
          loop NextExt
          jmp  ExitCFl

         ; Print Pathname

PrtPn:    xor  bh, bh
          mov  ah, 3
          int  10h
          mov  ah, 2
          xor  dl, dl
          int  10h

          mov  si, OFFSET PathMsg
NextPath1:lodsb
          cmp  al, 0
          je   PrtPath
          mov  ah, 0Eh
          int  10h
          jmp  NextPath1

PrtPath:  mov  si, OFFSET Dta + 1Eh
NextPath2:lodsb
          cmp  al, 0
          je   PrtSpc
          mov  ah, 0Eh
          int  10h
          jmp  NextPath2

PrtSpc:   mov  ah, 3
          int  10h
          mov  cx, 79
          sub  cl, dl
PrtSpace: mov  ax, 0E20h
          int  10h
          loop PrtSpace

          ; Open File

          mov  dx, OFFSET Dta + 1Eh
          call OpenFileForRead
          jnc  ReadF
          call PrtCr
          mov  ax, 8
          push ax
          call PrtErr
          mov  ax, 12
          call PrtAsk
          pop  ax
          jnc  ErrCFl
          call PrtCr2
          jmp  ExitCFl

ReadF:    call ReadFile
          jnc  ChkMZ
          call PrtCr
          mov  ax, 9
          push ax
          call PrtErr
          mov  ax, 12
          call PrtAsk
          pop  ax
          jnc  ErrCFl
          call PrtCr2
          jmp  ExitCFl

ChkMZ:    cmp  WORD PTR Buffer, 'MZ'
          je   ChkExe
          cmp  WORD PTR Buffer, 'ZM'
          je   ChkExe

ChkCom:   cmp  BYTE PTR Buffer, 0E9h
ChkExe:
;          mov  bx, OFFSET ExeData1
          mov  ax, WORD PTR Buffer[14h]
NextExe1: cmp  WORD PTR [bx], 0FFFFh
          je   Close
          cmp  [bx], ax
          je   CalExeEnt
          add  bx, 10
          jmp  NextExe1

CalExeEnt:mov  ax, WORD PTR Buffer[8]
          add  ax, WORD PTR Buffer[16h]
          mov  dx, 10h
          mul  dx
          add  ax, WORD PTR Buffer[14h]
          adc  dx, 0
          cmp  dx, 10h
          jb   RdExeEnt
          sub  dx, 10h
RdExeEnt: mov  cx, dx
          mov  dx, ax
          mov  ax, 4200h
          int  21h
;          jc
;
;          call ReadFileInTsr
;          jnc  RechkExe
;          jmp  Exit21h
;
; RechkExe:cmp  rBuffer, 0E9h
;          je   ChkExe2
;          cmp  rBuffer, 0E8h
;          jne  ChkExe3
;          cmp  WORD PTR rBuffer[1], 0
;          je   ChkExe3
;
; ChkExe2: mov  dx, WORD PTR rBuffer[1]
;          add  dx, 3
;          xor  cx, cx
;          sub  dx, 200h
;          sbb  cx, 0
;          mov  ax, 4201h
;          int  21h
;
;          call ReadFileInTsr
;          jnc  ChkExe3
;          jmp  Exit21h
;
; ChkExe3: call CloseFileInTsr
;
;          call IncBuffer
;
;          mov  bx, OFFSET ResidentGroup:ExeData1
;          call CheckFileVirusInTsr
;          jc   FdFVM
;
;          mov  bx, OFFSET ResidentGroup:ExeData4
;          call CheckPolyVirusInTsr
;          jc   FdFVM

Close:    call CloseFile

ExitCFl:  clc
          ret

ErrCFl:   stc
          ret

CheckFile  ENDP

;-----------------------------------------------------------

OpenFileForRead  PROC

          ; Input : DS:DX = address of filename
          ; Output: (if success)
          ;         BX    = handle
          ;         (if fail)
          ;         Carry flag = set

          push ax

          mov  ax, 3D00h
          int  21h
          jc   ExitOFFR
          mov  bx, ax

ExitOFFR: pop  ax
          ret

OpenFileForRead  ENDP

;-----------------------------------------------------------

OpenFileForWrite  PROC

          ; Input : DS:DX = address of filename
          ; Output: (if success)
          ;         BX    = handle
          ;         (if fail)
          ;         Carry flag = set

          push ax

          mov  ax, 3D02h
          int  21h
          jc   ExitOFFW
          mov  bx, ax

ExitOFFW: pop  ax
          ret

OpenFileForWrite  ENDP

;-----------------------------------------------------------

CloseFile  PROC

          ; Input : BX = handle
          ; Output: (if fail)
          ;         Carry flag = set

          push ax

          mov  ah, 3Eh
          int  21h

          pop  ax
          ret

CloseFile  ENDP

;-----------------------------------------------------------

ReadFile  PROC

          ; Input : BX    = handle
          ; Output: (if fail)
          ;         Carry flag = set

          push ax
          push cx
          push dx
          push di
          push es

          push ds
          pop  es
          mov  di, OFFSET Buffer
          xor  ax, ax
          mov  cx, 100h
          rep  stosw

          mov  ah, 3Fh
          mov  cx, BUFFSIZE
          mov  dx, OFFSET Buffer
          int  21h
          jnc  ExitRF

          call CloseFile
          stc

ExitRF:   pop  es
          pop  di
          pop  dx
          pop  cx
          pop  ax
          ret

ReadFile  ENDP

;-----------------------------------------------------------

WriteFile  PROC

          ; Input : BX    = handle
          ;         CX    = number of bytes
          ;         DS:DX = address of buffer
          ; Output: (if fail)
          ;         Carry flag = set

          push ax

          mov  ah, 40h
          int  21h
          jc   ErrWF

          cmp  cx, ax
          je   ExitWF

ErrWF:    call CloseFile
          stc

ExitWF:   pop  ax
          ret

WriteFile  ENDP

;-----------------------------------------------------------

DeleteFile  PROC

          ; Input : DS:DX = address of filename
          ; Output: (if fail)
          ;         Carry flag = set

          push ax

          mov  ah, 41h
          int  21h

          pop  ax
          ret

DeleteFile  ENDP

;-----------------------------------------------------------

CritErrHndler  PROC  FAR

          mov  al, 3                    ; Fail
          iret

CritErrHndler  ENDP

;-----------------------------------------------------------

END Start

