NRU% = 0
NI% = 37
MSL = 1
SST = 2
OIL = 5
RED = $F0
WHITE = $FF
LL = 30

\ New vars: L0098, L0099, L009B, L00FC
\ KL vars: L00C9, L00CB, L00D0, L00D1

\ XX3

CPU 1

ZP      = $0000
RAND    = $0002
T1      = $0006
SC      = $000A
P       = $000C
XC      = $0010
COL     = $0011
YC      = $0012
QQ17    = $0013
K3      = $0014
K4      = $0022
XX16    = $0024
XX0     = $0036
INF     = $0038
V       = $003A
XX      = $003C
YY      = $003E
SUNX    = $0040
BETA    = $0042
BET1    = $0043
QQ22    = $0044
ECMA    = $0046
ALP1    = $0047
ALP2    = $0048
XX15    = $004A
Y1      = $004B
X2      = $004C
Y2      = $004D
XX12    = $0050
K       = $0056
LAS     = $005A
MSTG    = $005B
DL      = $005C
LSP     = $005D
QQ15    = $005E
XX18    = $0064
QQ19    = $006D
BET2    = $0073
DELTA   = $0075
DELT4   = $0076
U       = $0078
Q       = $0079
R       = $007A
S       = $007B
T       = $007C
XSAV    = $007D
YSAV    = $007E
XX17    = $007F
U_COPY  = $0080
QQ11    = $0081
ZZ      = $0082
XX13    = $0083
MCNT    = $0084
TYPE    = $0085
ALPHA   = $0086
QQ12    = $0087
TGT     = $0088
FLAG    = $0089
CNT     = $008A
CNT2    = $008B
STP     = $008C
XX4     = $008D
XX20    = $008E
XX14    = $008F
RAT     = $0091
RAT2    = $0092
K2      = $0093
widget  = $0097
L0098   = $0098
L0099   = $0099
messXC  = $009A
L009B   = $009B
INWK    = $009C
XX19    = $00BD
NEWB    = $00C0
JSTX    = $00C1
JSTY    = $00C2
KL      = $00C3
KY17    = $00C4
KY14    = $00C5
KY15    = $00C6
KY20    = $00C7
KY7     = $00C8
L00C9   = $00C9
KY18    = $00CA
L00CB   = $00CB
KY19    = $00CC
KY12    = $00CD
KY2     = $00CE
KY16    = $00CF
L00D0   = $00D0
L00D1   = $00D1
KY1     = $00D2
KY13    = $00D3
LSX     = $00D4
FSH     = $00D5
ASH     = $00D6
ENERGY  = $00D7
QQ3     = $00D8
QQ4     = $00D9
QQ5     = $00DA
QQ6     = $00DB
QQ7     = $00DD
QQ8     = $00DF
QQ9     = $00E1
QQ10    = $00E2
NOSTM   = $00E3
L00FC   = $00FC
XX3     = $0100
USERV   = $0200
BRKV    = $0202
IRQ1V   = $0204
IRQ2V   = $0206
CLIV    = $0208
BYTEV   = $020A
WORDV   = $020C
WRCHV   = $020E
RDCHV   = $0210
FILEV   = $0212
ARGSV   = $0214
BGETV   = $0216
BPUTV   = $0218
GBPBV   = $021A
FINDV   = $021C
FSCV    = $021E
EVENTV  = $0220
UPTV    = $0222
NETV    = $0224
VDUV    = $0226
KEYV    = $0228
INSV    = $022A
REMV    = $022C
CNPV    = $022E
INDV1   = $0230
INDV2   = $0232
INDV3   = $0234
K%      = $0400
L0401   = $0401
L0402   = $0402
L0404   = $0404
L0405   = $0405
L0406   = $0406
L0407   = $0407
L0408   = $0408
L0425   = $0425
L0427   = $0427
L0429   = $0429
L042D   = $042D
L042F   = $042F
L0431   = $0431
L0433   = $0433
L0449   = $0449
L06A9   = $06A9
L0791   = $0791
FRIN    = $0E41
L0E45   = $0E45
MANY    = $0E4E
SSPR    = $0E50
L0E58   = $0E58
L0E5E   = $0E5E
L0E6B   = $0E6B
L0E6D   = $0E6D
JUNK    = $0E70
auto    = $0E71
ECMP    = $0E72
MJ      = $0E73
CABTMP  = $0E74
LAS2    = $0E75
MSAR    = $0E76
VIEW    = $0E77
LASCT   = $0E78
GNTMP   = $0E79
HFX     = $0E7A
EV      = $0E7B
DLY     = $0E7C
de      = $0E7D
LSX2    = $0E7E
LSY2    = $0F7E
LSO     = $107E
BUF     = $1146
SX      = $11A0
SXL     = $11B5
SY      = $11CA
SYL     = $11DF
L11ED   = $11ED
SZ      = $11F4
SZL     = $1209
LASX    = $121E
LASY    = $121F
ALTIT   = $1221
SWAP    = $1222
L1229   = $1229
NAME    = $122C
TP      = $1234
QQ0     = $1235
QQ1     = $1236
QQ21    = $1237
CASH    = $123D
QQ14    = $1241
COK     = $1242
GCNT    = $1243
LASER   = $1244
CRGO    = $124A
QQ20    = $124B
ECM     = $125C
BST     = $125D
BOMB    = $125E
ENGY    = $125F
DKCMP   = $1260
GHYP    = $1261
ESCP    = $1262
L1264   = $1264
L1265   = $1265
L1266   = $1266
NOMSL   = $1267
FIST    = $1268
AVL     = $1269
QQ26    = $127A
TALLY   = $127B
SVC     = $127D
MCH     = $1281
COMX    = $1282
COMY    = $1283
QQ24    = $1292
QQ25    = $1293
QQ28    = $1294
QQ29    = $1295
gov     = $1296
tek     = $1297
SLSP    = $1298
QQ2     = $129A
KTRAN   = $129F
safehouse = $12A0
L12A6   = $12A6
L12A7   = $12A7
L12A8   = $12A8
L12A9   = $12A9
L7FFE   = $7FFE
L7FFF   = $7FFF
XX21    = $8000
L8002   = $8002
L8003   = $8003
L8007   = $8007
L8040   = $8040
L8041   = $8041
E%      = $8042
L8062   = $8062
TALLYFRAC = $8063
L8083   = $8083
TALLYINT = $8084
QQ18    = $A000
SNE     = $A3C0
ACT     = $A3E0
TKN1    = $A400
LAF47   = $AF47
RUPLA   = $AF48
LAF61   = $AF61
RUGAL   = $AF62
RUTOK   = $AF7C
LDDEB   = $DDEB
VIA     = $FE00
LFE01   = $FE01
LFE18   = $FE18
LFE19   = $FE19
LFE20   = $FE20
LFE21   = $FE21
LFE30   = $FE30
LFE34   = $FE34
LFE40   = $FE40
LFE41   = $FE41
LFE43   = $FE43
LFE44   = $FE44
LFE45   = $FE45
LFE4D   = $FE4D
LFE4E   = $FE4E
LFE4F   = $FE4F
LFE6E   = $FE6E
OSWRSC  = $FFB3
OSRDSC  = $FFB9
OSEVEN  = $FFBF
GSINIT  = $FFC2
GSREAD  = $FFC5
NVRDCH  = $FFC8
NNWRCH  = $FFCB
OSFIND  = $FFCE
OSGBPB  = $FFD1
OSBPUT  = $FFD4
OSBGET  = $FFD7
OSARGS  = $FFDA
OSFILE  = $FFDD
OSRDCH  = $FFE0
OSASCI  = $FFE3
OSNEWL  = $FFE7
OSWRCH  = $FFEE
OSWORD  = $FFF1
OSBYTE  = $FFF4
OSCLI   = $FFF7
LFFFF   = $FFFF

        org     $1300
.TVT3
        EQUB    $00,$34,$24,$17,$74,$64,$57,$47
        EQUB    $B1,$A1,$96,$86,$F1,$E1,$D6,$C6
        EQUB    $00,$34,$24,$17,$74,$64,$57,$47
        EQUB    $B0,$A0,$96,$86,$F0,$E0,$D6,$C6
        EQUB    $00,$34,$24,$17,$74,$64,$57,$47
        EQUB    $B1,$A1,$90,$80,$F1,$E1,$D0,$C0
        EQUB    $00,$34,$24,$17,$74,$64,$57,$47
        EQUB    $B0,$A0,$92,$82,$F0,$E0,$D2,$C2

.VEC
        EQUB    $88

.L1341
        EQUB    $88

.WSCAN
        STZ     DL
.WSCAN1
        LDA     DL
        BEQ     WSCAN1

        RTS

.DELAY
        JSR     WSCAN

        DEY
        BNE     DELAY

        RTS

.BEEP_LONG_LOW
        LDY     #$00
        BRA     NOISE

.BEEP
        LDY     #$01
        BRA     NOISE

.L1358
        EQUB    $C0

        EQUB    $A0,$80

.L135B
        EQUB    $FF,$BF,$9F,$DF,$EF

.MASTER_DKSn
        LDX     #$FF
        STX     LFE43
        STA     LFE4F
        LDA     #$00
        STA     LFE40
        PHA
        PLA
        PHA
        PLA
        LDA     #$08
        STA     LFE40
.L1376
        RTS

.L1377
        LDY     #$03
        LDA     #$00
.L137B
        STA     L144C,Y
        DEY
        BNE     L137B

        SEI
.L1382
        LDA     L135B,Y
        JSR     MASTER_DKSn

        INY
        CPY     #$05
        BNE     L1382

        CLI
        RTS

.BEING_HIT_NOISE
        LDY     #$09
        JSR     NOISE

        LDY     #$05
        BRA     NOISE

.LASER_NOISE
        LDY     #$03
        JSR     NOISE

        LDY     #$05
.NOISE
        LDA     L2C55
        BNE     L1376

        LDA     L146E,Y
        LSR     A
        CLV
        LDX     #$00
        BCS     L13B7

        INX
        LDA     L145A
        CMP     L145B
        BCC     L13B7

        INX
.L13B7
        LDA     L1462,Y
        CMP     L1459,X
        BCC     L1376

        SEI
        STA     L1459,X
        LSR     A
        AND     #$07
        STA     L1453,X
        LDA     L1486,Y
        STA     L1456,X
        LDA     L146E,Y
        STA     L1450,X
        AND     #$0F
        LSR     A
        STA     L145C,X
        LDA     L147A,Y
        BVC     L13E1

        ASL     A
.L13E1
        STA     L145F,X
        LDA     #$80
        STA     L144D,X
        CLI
        SEC
        RTS

.L13EC
        LDY     #$02
.L13EE
        LDA     L144D,Y
        BEQ     L1449

        BMI     L13FB

        LDA     L145C,Y
        BEQ     L1416

        EQUB    $2C

.L13FB
        LDA     #$00
        CLC
        CLD
        ADC     L145F,Y
        STA     L145F,Y
        PHA
        ASL     A
        ASL     A
        AND     #$0F
        ORA     L1358,Y
        JSR     MASTER_DKSn

        PLA
        LSR     A
        LSR     A
        JSR     MASTER_DKSn

.L1416
        TYA
        TAX
        LDA     L144D,Y
        BMI     L1439

        DEC     L1450,X
        BEQ     L142F

        LDA     L1450,X
        AND     L1456,X
        BNE     L1449

        DEC     L1453,X
        BNE     L143C

.L142F
        LDA     #$00
        STA     L144D,Y
        STA     L1459,Y
        BEQ     L1443

.L1439
        LSR     L144D,X
.L143C
        LDA     L1453,Y
        CLC
        ADC     L2C61
.L1443
        EOR     L135B,Y
        JSR     MASTER_DKSn

.L1449
        DEY
        BPL     L13EE

.L144C
        RTS

.L144D
        EQUB    $00

        EQUB    $00,$00

.L1450
        EQUB    $00,$00,$00

.L1453
        EQUB    $00,$00,$00

.L1456
        EQUB    $00,$00,$00

.L1459
        EQUB    $00

.L145A
        EQUB    $00

.L145B
        EQUB    $00

.L145C
        EQUB    $00,$00,$00

.L145F
        EQUB    $00,$00,$00

.L1462
        EQUB    $4B,$5B,$3F,$EB,$FF,$09,$FF,$8B
        EQUB    $CF,$E7,$FF,$EF

.L146E
        EQUB    $40,$10,$01,$FC,$F3,$19,$F9,$7C
        EQUB    $F1,$FA,$FE,$FE

.L147A
        EQUB    $F0,$20,$10,$30,$03,$01,$08,$80
        EQUB    $16,$38,$00,$80

.L1486
        EQUB    $FF,$FF,$00,$03,$1F,$01,$07,$07
        EQUB    $0F,$03,$0F,$0F

.STARTUP
        SEI
        LDA     #$39
        STA     LFE4E
        LDA     #$7F
        STA     LFE6E
        LDA     IRQ1V
        STA     VEC
        LDA     IRQ1V+1
        STA     L1341
        LDA     #$CB
        STA     IRQ1V
        LDA     #$14
        STA     IRQ1V+1
        LDA     L153A
        STA     LFE45
        CLI
        RTS

.L14BB
        EQUB    $34

        EQUB    $43,$25,$16,$86,$70,$61,$52,$C3
        EQUB    $B4,$A5,$96,$07,$F0,$E1,$D2

.IRQ1
        PHY
        LDY     #$0F
        LDA     #$02
        BIT     LFE4D
        BNE     LINSCN

        LDA     #$14
        STA     LFE20
        LDA     ESCP
        AND     #$04
        EOR     #$34
        STA     LFE21
.L14E4
        LDA     L14BB,Y
        STA     LFE21
        DEY
        BNE     L14E4

        LDA     LFE18
        AND     #$03
        TAY
        LDA     LFE19
        STA     L12A7,Y
        INY
        TYA
        CMP     #$03
        BCC     L1501

        LDA     #$00
.L1501
        STA     LFE18
        PLY
        LDA     LFE44
        LDA     L00FC
        RTI

.LINSCN
        LDA     LFE41
        LDA     L00FC
        PHA
        LDA     L153B
        STA     DL
        STA     LFE44
        LDA     L153A
        STA     LFE45
        LDA     HFX
        BNE     L1532

        LDA     #$18
        STA     LFE20
.VNT3
        LDA     TVT3,Y
L152A = VNT3+1
        STA     LFE21
        DEY
        BNE     VNT3

.L1532
        PHX
        JSR     L13EC

        PLX
        PLA
        PLY
        RTI

.L153A
        EQUB    $39

.L153B
        EQUB    $1E

.DOVDU19
        STA     L152A
        RTS

.MASTER_MOVE_ZP_3000
        LDA     #$0F
        STA     LFE34
        LDX     #$90
.L1547
        LDA     ZP,X
        STA     L3000,X
        INX
        BNE     L1547

        LDA     #$09
        STA     LFE34
        RTS

.MASTER_SWAP_ZP_3000
        LDA     #$0F
        STA     LFE34
        LDX     #$90
.L155C
        LDA     ZP,X
        LDY     L3000,X
        STY     ZP,X
        STA     L3000,X
        INX
        CPX     #$F0
        BNE     L155C

        LDA     #$09
        STA     LFE34
        LDA     #$06
        STA     LFE30
        RTS

.L1576
        EQUB    $40

        EQUB    $40,$40,$40,$40,$40,$40,$40,$42
        EQUB    $42,$42,$42,$42,$42,$42,$42,$44
        EQUB    $44,$44,$44,$44,$44,$44,$44,$46
        EQUB    $46,$46,$46,$46,$46,$46,$46,$48
        EQUB    $48,$48,$48,$48,$48,$48,$48,$4A
        EQUB    $4A,$4A,$4A,$4A,$4A,$4A,$4A,$4C
        EQUB    $4C,$4C,$4C,$4C,$4C,$4C,$4C,$4E
        EQUB    $4E,$4E,$4E,$4E,$4E,$4E,$4E,$50
        EQUB    $50,$50,$50,$50,$50,$50,$50,$52
        EQUB    $52,$52,$52,$52,$52,$52,$52,$54
        EQUB    $54,$54,$54,$54,$54,$54,$54,$56
        EQUB    $56,$56,$56,$56,$56,$56,$56,$58
        EQUB    $58,$58,$58,$58,$58,$58,$58,$5A
        EQUB    $5A,$5A,$5A,$5A,$5A,$5A,$5A,$5C
        EQUB    $5C,$5C,$5C,$5C,$5C,$5C,$5C,$5E
        EQUB    $5E,$5E,$5E,$5E,$5E,$5E,$5E,$60
        EQUB    $60,$60,$60,$60,$60,$60,$60,$62
        EQUB    $62,$62,$62,$62,$62,$62,$62,$64
        EQUB    $64,$64,$64,$64,$64,$64,$64,$66
        EQUB    $66,$66,$66,$66,$66,$66,$66,$68
        EQUB    $68,$68,$68,$68,$68,$68,$68,$6A
        EQUB    $6A,$6A,$6A,$6A,$6A,$6A,$6A,$6C
        EQUB    $6C,$6C,$6C,$6C,$6C,$6C,$6C,$6E
        EQUB    $6E,$6E,$6E,$6E,$6E,$6E,$6E,$70
        EQUB    $70,$70,$70,$70,$70,$70,$70,$72
        EQUB    $72,$72,$72,$72,$72,$72,$72,$74
        EQUB    $74,$74,$74,$74,$74,$74,$74,$76
        EQUB    $76,$76,$76,$76,$76,$76,$76,$78
        EQUB    $78,$78,$78,$78,$78,$78,$78,$7A
        EQUB    $7A,$7A,$7A,$7A,$7A,$7A,$7A,$7C
        EQUB    $7C,$7C,$7C,$7C,$7C,$7C,$7C,$7E
        EQUB    $7E,$7E,$7E,$7E,$7E,$7E,$7E

.SC5
        RTS

.SCAN
        LDA     INWK+31
        AND     #$10
        BEQ     SC5

        LDX     TYPE
        BMI     SC5

        LDA     scacol,X
        STA     COL
        LDA     INWK+1
        ORA     INWK+4
        ORA     INWK+7
        AND     #$C0
        BNE     SC5

        LDA     INWK+1
        CLC
        LDX     INWK+2
        BPL     SC2

        EOR     #$FF
        ADC     #$01
        CLC
.SC2
        ADC     #$7D
        AND     #$FE
        STA     XX15
        TAX
        DEX
        DEX
        LDA     INWK+7
        LSR     A
        LSR     A
        CLC
        LDY     INWK+8
        BPL     SC3

        EOR     #$FF
        SEC
.SC3
        ADC     #$23
        EOR     #$FF
        STA     Y2
        LDA     INWK+4
        LSR     A
        CLC
        LDY     INWK+5
        BMI     SCD6

        EOR     #$FF
        SEC
.SCD6
        ADC     Y2
        BPL     FIXIT

        CMP     #$C2
        BCS     L16CC

        LDA     #$C2
.L16CC
        CMP     #$F7
        BCC     L16D2

.FIXIT
        LDA     #$F6
.L16D2
        LDY     #$0F
        STY     LFE34
        JSR     CPIX2

        LDA     Y1
        SEC
        SBC     Y2
        BEQ     RTS

        BCC     RTS_PLUS_1

        TAX
        INX
        JMP     VL1

.VLL1
        LDA     R
        EOR     (SC),Y
        STA     (SC),Y
.VL1
        DEY
        BPL     L16F9

        LDA     SC+1
        SBC     #$02
        STA     SC+1
        LDY     #$07
.L16F9
        DEX
        BNE     VLL1

.RTS
        LDA     #$09
        STA     LFE34
        RTS

.RTS_PLUS_1
        LDA     Y2
        SEC
        SBC     Y1
        TAX
        INX
        JMP     VL2

.VLL2
        LDA     R
        EOR     (SC),Y
        STA     (SC),Y
.VL2
        INY
        CPY     #$08
        BNE     L171F

        LDA     SC+1
        ADC     #$01
        STA     SC+1
        LDY     #$00
.L171F
        DEX
        BNE     VLL2

        LDA     #$09
        STA     LFE34
        RTS

.LL30
        STY     YSAV
        LDA     #$0F
        STA     LFE34
        JSR     LOIN

        LDA     #$09
        STA     LFE34
        LDY     YSAV
        RTS

.L173A
        EQUB    $88

        EQUB    $44,$22,$11

.TWOS2
        EQUB    $CC,$66,$33,$33

.CTWOS
        EQUB    $AA,$AA

.L1744
        EQUB    $55,$55,$AA,$AA,$4C,$49,$1D

.LOIN
        LDA     #$80
        STA     S
        ASL     A
        STA     SWAP
        LDA     X2
        SBC     XX15
        BCS     LI1

        EOR     #$FF
        ADC     #$01
        SEC
.LI1
        STA     P
        LDA     Y2
        SBC     Y1
        BCS     LI2

        EOR     #$FF
        ADC     #$01
.LI2
        STA     Q
        CMP     P
        BCC     STPX

        JMP     STPY

.STPX
        LDX     XX15
        CPX     X2
        BCC     LI3

        DEC     SWAP
        LDA     X2
        STA     XX15
        STX     X2
        TAX
        LDA     Y2
        LDY     Y1
        STA     Y1
        STY     Y2
.LI3
        LDY     Y1
        LDA     L1576,Y
        STA     SC+1
        LDA     Y1
        AND     #$07
        TAY
        TXA
        AND     #$FC
        ASL     A
        STA     SC
        BCC     L17A1

        INC     SC+1
.L17A1
        TXA
        AND     #$03
        STA     R
        LDX     Q
        BEQ     LIlog7

        LDA     logL,X
        LDX     P
        SEC
        SBC     logL,X
        LDX     Q
        LDA     log,X
        LDX     P
        SBC     log,X
        BCS     LIlog5

        TAX
        LDA     antilog,X
        JMP     LIlog6

.LIlog5
        LDA     #$FF
        BNE     LIlog6

.LIlog7
        LDA     #$00
.LIlog6
        STA     Q
        LDX     P
        BEQ     LIEXS

        INX
        LDA     Y2
        CMP     Y1
        BCC     L17DC

        JMP     DOWN

.L17DC
        LDA     #$88
        AND     COL
        STA     L181A
        LDA     #$44
        AND     COL
        STA     L182F
        LDA     #$22
        AND     COL
        STA     L1844
        LDA     #$11
        AND     COL
        STA     L1859
        LDA     SWAP
        BEQ     LI190

        LDA     R
        BEQ     L181F

        CMP     #$02
        BCC     L1834

        CLC
        BEQ     L1849

        BNE     L185E

.LI190
        DEX
        LDA     R
        BEQ     LI100

        CMP     #$02
        BCC     LI110

        CLC
        BEQ     LI120

        JMP     LI130

.LI100
        LDA     #$88
L181A = LI100+1
        EOR     (SC),Y
        STA     (SC),Y
.L181F
        DEX
.LIEXS
        BEQ     LIEX

        LDA     S
        ADC     Q
        STA     S
        BCC     LI110

        CLC
        DEY
        BMI     LI101

.LI110
        LDA     #$44
L182F = LI110+1
        EOR     (SC),Y
        STA     (SC),Y
.L1834
        DEX
        BEQ     LIEX

        LDA     S
        ADC     Q
        STA     S
        BCC     LI120

        CLC
        DEY
        BMI     LI111

.LI120
        LDA     #$22
L1844 = LI120+1
        EOR     (SC),Y
        STA     (SC),Y
.L1849
        DEX
        BEQ     LIEX

        LDA     S
        ADC     Q
        STA     S
        BCC     LI130

        CLC
        DEY
        BMI     LI121

.LI130
        LDA     #$11
L1859 = LI130+1
        EOR     (SC),Y
        STA     (SC),Y
.L185E
        LDA     S
        ADC     Q
        STA     S
        BCC     LI140

        CLC
        DEY
        BMI     LI131

.LI140
        DEX
        BEQ     LIEX

        LDA     SC
        ADC     #$08
        STA     SC
        BCC     LI100

        INC     SC+1
        CLC
        BCC     LI100

.LI101
        DEC     SC+1
        DEC     SC+1
        LDY     #$07
        BPL     LI110

.LI111
        DEC     SC+1
        DEC     SC+1
        LDY     #$07
        BPL     LI120

.LI121
        DEC     SC+1
        DEC     SC+1
        LDY     #$07
        BPL     LI130

.LI131
        DEC     SC+1
        DEC     SC+1
        LDY     #$07
        BPL     LI140

.LIEX
        RTS

.DOWN
        LDA     #$88
        AND     COL
        STA     L18E8
        LDA     #$44
        AND     COL
        STA     L18FD
        LDA     #$22
        AND     COL
        STA     L1912
        LDA     #$11
        AND     COL
        STA     L1927
        LDA     SC
        SBC     #$F8
        STA     SC
        LDA     SC+1
        SBC     #$00
        STA     SC+1
        TYA
        EOR     #$F8
        TAY
        LDA     SWAP
        BEQ     LI191

        LDA     R
        BEQ     L18ED

        CMP     #$02
        BCC     L1902

        CLC
        BEQ     L1917

        BNE     L192C

.LI191
        DEX
        LDA     R
        BEQ     LI200

        CMP     #$02
        BCC     LI210

        CLC
        BEQ     LI220

        BNE     LI230

.LI200
        LDA     #$88
L18E8 = LI200+1
        EOR     (SC),Y
        STA     (SC),Y
.L18ED
        DEX
        BEQ     LIEX

        LDA     S
        ADC     Q
        STA     S
        BCC     LI210

        CLC
        INY
        BEQ     LI201

.LI210
        LDA     #$44
L18FD = LI210+1
        EOR     (SC),Y
        STA     (SC),Y
.L1902
        DEX
        BEQ     LIEX

        LDA     S
        ADC     Q
        STA     S
        BCC     LI220

        CLC
        INY
        BEQ     LI211

.LI220
        LDA     #$22
L1912 = LI220+1
        EOR     (SC),Y
        STA     (SC),Y
.L1917
        DEX
        BEQ     LIEX2

        LDA     S
        ADC     Q
        STA     S
        BCC     LI230

        CLC
        INY
        BEQ     LI221

.LI230
        LDA     #$11
L1927 = LI230+1
        EOR     (SC),Y
        STA     (SC),Y
.L192C
        LDA     S
        ADC     Q
        STA     S
        BCC     LI240

        CLC
        INY
        BEQ     LI231

.LI240
        DEX
        BEQ     LIEX2

        LDA     SC
        ADC     #$08
        STA     SC
        BCC     LI200

        INC     SC+1
        CLC
        BCC     LI200

.LI201
        INC     SC+1
        INC     SC+1
        LDY     #$F8
        BNE     LI210

.LI211
        INC     SC+1
        INC     SC+1
        LDY     #$F8
        BNE     LI220

.LI221
        INC     SC+1
        INC     SC+1
        LDY     #$F8
        BNE     LI230

.LI231
        INC     SC+1
        INC     SC+1
        LDY     #$F8
        BNE     LI240

.LIEX2
        RTS

.STPY
        LDY     Y1
        TYA
        LDX     XX15
        CPY     Y2
        BCS     LI15

        DEC     SWAP
        LDA     X2
        STA     XX15
        STX     X2
        TAX
        LDA     Y2
        STA     Y1
        STY     Y2
        TAY
.LI15
        LDA     L1576,Y
        STA     SC+1
        TXA
        AND     #$FC
        ASL     A
        STA     SC
        BCC     L1992

        INC     SC+1
.L1992
        TXA
        AND     #$03
        TAX
        LDA     L173A,X
        STA     R
        LDX     P
        BEQ     LIfudge

        LDA     logL,X
        LDX     Q
        SEC
        SBC     logL,X
        LDX     P
        LDA     log,X
        LDX     Q
        SBC     log,X
        BCS     LIlog3

        TAX
        LDA     antilog,X
        JMP     LIlog2

.LIlog3
        LDA     #$FF
.LIlog2
        STA     P
.LIfudge
        LDX     Q
        BEQ     LIEX7

        INX
        LDA     X2
        SEC
        SBC     XX15
        BCS     L19CF

        JMP     LFT

.LIEX7
        RTS

.L19CF
        LDA     SWAP
        BEQ     LI290

        TYA
        AND     #$07
        TAY
        BNE     L19DD

        JMP     L1B18

.L19DD
        CPY     #$02
        BCS     L19E4

        JMP     L1B04

.L19E4
        CLC
        BNE     L19EA

        JMP     L1AF0

.L19EA
        CPY     #$04
        BCS     L19F1

        JMP     L1ADC

.L19F1
        CLC
        BNE     L19F7

        JMP     L1AC8

.L19F7
        CPY     #$06
        BCS     L19FE

        JMP     L1AB4

.L19FE
        CLC
        BEQ     L1A04

        JMP     L1A8C

.L1A04
        JMP     L1AA0

.LI290
        DEX
        TYA
        AND     #$07
        TAY
        BNE     L1A11

        JMP     LI307

.L1A11
        CPY     #$02
        BCS     L1A18

        JMP     LI306

.L1A18
        CLC
        BNE     L1A1E

        JMP     LI305

.L1A1E
        CPY     #$04
        BCC     LI304S

        CLC
        BEQ     LI303S

        CPY     #$06
        BCC     LI302S

        CLC
        BEQ     LI301S

        JMP     LI300

.LI310
        LSR     R
        BCC     LI301

        LDA     #$88
        STA     R
        LDA     SC
        ADC     #$07
        STA     SC
        BCC     LI301

        INC     SC+1
        CLC
.LI301S
        BCC     LI301

.LI311
        LSR     R
        BCC     LI302

        LDA     #$88
        STA     R
        LDA     SC
        ADC     #$07
        STA     SC
        BCC     LI302

        INC     SC+1
        CLC
.LI302S
        BCC     LI302

.LI312
        LSR     R
        BCC     LI303

        LDA     #$88
        STA     R
        LDA     SC
        ADC     #$07
        STA     SC
        BCC     LI303

        INC     SC+1
        CLC
.LI303S
        BCC     LI303

.LI313
        LSR     R
        BCC     LI304

        LDA     #$88
        STA     R
        LDA     SC
        ADC     #$07
        STA     SC
        BCC     LI304

        INC     SC+1
        CLC
.LI304S
        BCC     LI304

.LIEX3
        RTS

.LI300
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1A8C
        DEX
        BEQ     LIEX3

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI310

.LI301
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1AA0
        DEX
        BEQ     LIEX3

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI311

.LI302
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1AB4
        DEX
        BEQ     LIEX3

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI312

.LI303
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1AC8
        DEX
        BEQ     LIEX3

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI313

.LI304
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1ADC
        DEX
        BEQ     LIEX4

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI314

.LI305
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1AF0
        DEX
        BEQ     LIEX4

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI315

.LI306
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1B04
        DEX
        BEQ     LIEX4

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI316

.LI307
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1B18
        DEX
        BEQ     LIEX4

        DEC     SC+1
        DEC     SC+1
        LDY     #$07
        LDA     S
        ADC     P
        STA     S
        BCS     L1B2C

        JMP     LI300

.L1B2C
        LSR     R
        BCS     L1B33

        JMP     LI300

.L1B33
        LDA     #$88
        STA     R
        LDA     SC
        ADC     #$07
        STA     SC
        BCS     L1B42

        JMP     LI300

.L1B42
        INC     SC+1
        CLC
        JMP     LI300

.LIEX4
        RTS

.LI314
        LSR     R
        BCC     LI305

        LDA     #$88
        STA     R
        LDA     SC
        ADC     #$07
        STA     SC
        BCC     LI305

        INC     SC+1
        CLC
        BCC     LI305

.LI315
        LSR     R
        BCC     LI306

        LDA     #$88
        STA     R
        LDA     SC
        ADC     #$07
        STA     SC
        BCC     LI306

        INC     SC+1
        CLC
        BCC     LI306

.LI316
        LSR     R
        BCC     LI307

        LDA     #$88
        STA     R
        LDA     SC
        ADC     #$07
        STA     SC
        BCC     LI307

        INC     SC+1
        CLC
        BCC     LI307

.LFT
        LDA     SWAP
        BEQ     LI291

        TYA
        AND     #$07
        TAY
        BNE     L1B96

        JMP     L1CD1

.L1B96
        CPY     #$02
        BCS     L1B9D

        JMP     L1CBD

.L1B9D
        CLC
        BNE     L1BA3

        JMP     L1CA9

.L1BA3
        CPY     #$04
        BCS     L1BAA

        JMP     L1C95

.L1BAA
        CLC
        BNE     L1BB0

        JMP     L1C81

.L1BB0
        CPY     #$06
        BCS     L1BB7

        JMP     L1C6D

.L1BB7
        CLC
        BEQ     L1BBD

        JMP     L1C45

.L1BBD
        JMP     L1C59

.LI291
        DEX
        TYA
        AND     #$07
        TAY
        BNE     L1BCA

        JMP     LI407

.L1BCA
        CPY     #$02
        BCS     L1BD1

        JMP     LI406

.L1BD1
        CLC
        BNE     L1BD7

        JMP     LI405

.L1BD7
        CPY     #$04
        BCC     LI404S

        CLC
        BEQ     LI403S

        CPY     #$06
        BCC     LI402S

        CLC
        BEQ     LI401S

        JMP     LI400

.LI410
        ASL     R
        BCC     LI401

        LDA     #$11
        STA     R
        LDA     SC
        SBC     #$08
        STA     SC
        BCS     L1BFA

        DEC     SC+1
.L1BFA
        CLC
.LI401S
        BCC     LI401

.LI411
        ASL     R
        BCC     LI402

        LDA     #$11
        STA     R
        LDA     SC
        SBC     #$08
        STA     SC
        BCS     L1C0F

        DEC     SC+1
.L1C0F
        CLC
.LI402S
        BCC     LI402

.LI412
        ASL     R
        BCC     LI403

        LDA     #$11
        STA     R
        LDA     SC
        SBC     #$08
        STA     SC
        BCS     L1C24

        DEC     SC+1
.L1C24
        CLC
.LI403S
        BCC     LI403

.LI413
        ASL     R
        BCC     LI404

        LDA     #$11
        STA     R
        LDA     SC
        SBC     #$08
        STA     SC
        BCS     L1C39

        DEC     SC+1
.L1C39
        CLC
.LI404S
        BCC     LI404

.LIEX5
        RTS

.LI400
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1C45
        DEX
        BEQ     LIEX5

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI410

.LI401
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1C59
        DEX
        BEQ     LIEX5

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI411

.LI402
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1C6D
        DEX
        BEQ     LIEX5

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI412

.LI403
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1C81
        DEX
        BEQ     LIEX5

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI413

.LI404
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1C95
        DEX
        BEQ     LIEX6

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI414

.LI405
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1CA9
        DEX
        BEQ     LIEX6

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI415

.LI406
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1CBD
        DEX
        BEQ     LIEX6

        DEY
        LDA     S
        ADC     P
        STA     S
        BCS     LI416

.LI407
        LDA     R
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.L1CD1
        DEX
        BEQ     LIEX6

        DEC     SC+1
        DEC     SC+1
        LDY     #$07
        LDA     S
        ADC     P
        STA     S
        BCS     L1CE5

        JMP     LI400

.L1CE5
        ASL     R
        BCS     L1CEC

        JMP     LI400

.L1CEC
        LDA     #$11
        STA     R
        LDA     SC
        SBC     #$08
        STA     SC
        BCS     L1CFA

        DEC     SC+1
.L1CFA
        CLC
        JMP     LI400

.LIEX6
        RTS

.LI414
        ASL     R
        BCC     LI405

        LDA     #$11
        STA     R
        LDA     SC
        SBC     #$08
        STA     SC
        BCS     L1D11

        DEC     SC+1
.L1D11
        CLC
        BCC     LI405

.LI415
        ASL     R
        BCC     LI406

        LDA     #$11
        STA     R
        LDA     SC
        SBC     #$08
        STA     SC
        BCS     L1D26

        DEC     SC+1
.L1D26
        CLC
        BCC     LI406

.LI416
        ASL     R
        BCC     LI407

        LDA     #$11
        STA     R
        LDA     SC
        SBC     #$08
        STA     SC
        BCS     L1D3B

        DEC     SC+1
.L1D3B
        CLC
        JMP     LI407

.HLOIN
        LDA     Y1
        AND     #$03
        TAX
        LDA     orange,X
        STA     COL
.HLOIN3
        STY     YSAV
        LDY     #$0F
        STY     LFE34
        LDX     XX15
        CPX     X2
        BEQ     HL6

        BCC     HL5

        LDA     X2
        STA     XX15
        STX     X2
        TAX
.HL5
        DEC     X2
        LDY     Y1
        LDA     L1576,Y
        STA     SC+1
        TYA
        AND     #$07
        STA     SC
        TXA
        AND     #$FC
        ASL     A
        TAY
        BCC     HL1

        INC     SC+1
.HL1
        TXA
        AND     #$FC
        STA     T
        LDA     X2
        AND     #$FC
        SEC
        SBC     T
        BEQ     HL2

        LSR     A
        LSR     A
        STA     R
        LDA     XX15
        AND     #$03
        TAX
        LDA     TWFR,X
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
        TYA
        ADC     #$08
        TAY
        BCS     HL7

.HL8
        LDX     R
        DEX
        BEQ     HL3

        CLC
.HLL1
        LDA     COL
        EOR     (SC),Y
        STA     (SC),Y
        TYA
        ADC     #$08
        TAY
        BCS     HL9

.HL10
        DEX
        BNE     HLL1

.HL3
        LDA     X2
        AND     #$03
        TAX
        LDA     L1DF5,X
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
.HL6
        LDY     #$09
        STY     LFE34
        LDY     YSAV
        RTS

.HL2
        LDA     XX15
        AND     #$03
        TAX
        LDA     TWFR,X
        STA     T
        LDA     X2
        AND     #$03
        TAX
        LDA     L1DF5,X
        AND     T
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
        LDY     #$09
        STY     LFE34
        LDY     YSAV
        RTS

.HL7
        INC     SC+1
        CLC
        JMP     HL8

.HL9
        INC     SC+1
        CLC
        JMP     HL10

.L1DF5
        EQUB    $88

        EQUB    $CC,$EE,$FF

.TWFR
        EQUB    $FF,$77,$33,$11

.orange
        EQUB    $A5,$A5,$5A,$5A

.PIX1
        JSR     ADD_COPY

        STA     YY+1
        TXA
        STA     SYL,Y
.PIXEL2
        LDA     XX15
        BPL     PX1

        EOR     #$7F
        CLC
        ADC     #$01
.PX1
        EOR     #$80
        TAX
        LDA     Y1
        AND     #$7F
        CMP     #$60
        BCS     L1E61

        LDA     Y1
        BPL     PX2

        EOR     #$7F
        ADC     #$01
.PX2
        STA     T
        LDA     #$61
        SBC     T
.PIXEL
        STY     T1
        LDY     #$0F
        STY     LFE34
        TAY
        LDA     L1576,Y
        STA     SC+1
        TXA
        AND     #$FC
        ASL     A
        STA     SC
        BCC     L1E43

        INC     SC+1
.L1E43
        TYA
        AND     #$07
        TAY
        TXA
        AND     #$03
        TAX
        LDA     ZZ
        CMP     #$50
        BCC     PX2_REPEAT

        LDA     TWOS2,X
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
        LDY     #$09
        STY     LFE34
        LDY     T1
.L1E61
        RTS

.PX2_REPEAT
        LDA     TWOS2,X
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
        DEY
        BPL     L1E70

        LDY     #$01
.L1E70
        LDA     TWOS2,X
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
        LDY     #$09
        STY     LFE34
        LDY     T1
        RTS

        EQUB    $FA

        EQUB    $0F,$0F,$F0,$F0,$A5,$A5,$0F

.DOT
        LDA     #$0F
        STA     LFE34
        LDA     COMX
        STA     XX15
        LDX     COMC
        STX     COL
        LDA     COMY
        CPX     #$0F
        BNE     L1EA5

        JSR     CPIX2

        LDA     Y1
        DEC     A
.L1EA5
        JSR     CPIX2

        LDA     #$09
        STA     LFE34
        RTS

.CPIX2
        STA     Y1
        TAY
        LDA     L1576,Y
        STA     SC+1
        LDA     XX15
        AND     #$FC
        ASL     A
        STA     SC
        BCC     L1EC2

        INC     SC+1
        CLC
.L1EC2
        TYA
        AND     #$07
        TAY
        LDA     XX15
        AND     #$02
        TAX
        LDA     CTWOS,X
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
        LDA     L1744,X
        BPL     CP1

        LDA     SC
        ADC     #$08
        STA     SC
        BCC     L1EE3

        INC     SC+1
.L1EE3
        LDA     L1744,X
.CP1
        AND     COL
        STA     R
        EOR     (SC),Y
        STA     (SC),Y
        RTS

.ECBLB2
        LDA     #$20
        STA     ECMA
.ECBLB
        LDA     #$0F
        STA     LFE34
        LDA     #$70
        STA     SC
        LDA     #$7A
        STA     SC+1
        LDY     #$0F
.BULL2
        LDA     ECBT,Y
        EOR     (SC),Y
        STA     (SC),Y
        DEY
        BPL     BULL2

        BMI     L1F27

.SPBLB
        LDA     #$0F
        STA     LFE34
        LDA     #$80
        STA     SC
        LDA     #$7B
        STA     SC+1
        LDY     #$0F
.BULL
        LDA     L1F2D,Y
        EOR     (SC),Y
        STA     (SC),Y
        DEY
        BPL     BULL

.L1F27
        LDA     #$09
        STA     LFE34
        RTS

.L1F2D
        EQUB    $FF

        EQUB    $FF,$AA,$FF,$FF,$00,$FF,$FF,$FF
        EQUB    $FF,$00,$FF,$FF,$55,$FF,$FF

.ECBT
        EQUB    $FF,$FF,$AA,$FF,$FF,$AA,$FF,$FF
        EQUB    $FF,$FF,$00,$FF,$FF,$00,$FF,$FF

.MSBAR
        LDA     #$0F
        STA     LFE34
        TXA
        PHA
        ASL     A
        ASL     A
        ASL     A
        ASL     A
        STA     T
        LDA     #$61
        SBC     T
        STA     SC
        LDA     #$7C
        STA     SC+1
        TYA
        LDY     #$05
.MBL1
        STA     (SC),Y
        DEY
        BNE     MBL1

        PHA
        LDA     SC
        CLC
        ADC     #$08
        STA     SC
        PLA
        AND     #$AA
        LDY     #$05
.MBL2
        STA     (SC),Y
        DEY
        BNE     MBL2

        PLX
        LDA     #$09
        STA     LFE34
        RTS

.L1F85
        EQUB    $00

.HANGER
        LDX     #$02
        LDA     #$0F
        STA     LFE34
.HAL1
        STX     T
        LDA     #$82
        STX     Q
        JSR     DVID4_COPY

        LDA     P
        CLC
        ADC     #$60
        TAY
        LDA     L1576,Y
        STA     SC+1
        STA     R
        LDA     P
        AND     #$07
        STA     SC
        LDY     #$00
        JSR     HAS2

        LDY     R
        INY
        STY     SC+1
        LDA     #$40
        LDY     #$F8
        JSR     HAS3

        LDY     L1F85
        BEQ     HA2

        LDY     #$00
        LDA     #$88
        JSR     HAL3

        DEC     SC+1
        LDY     #$F8
        LDA     #$10
        JSR     HAS3

.HA2
        LDX     T
        INX
        CPX     #$0D
        BCC     HAL1

        LDA     #$3C
        STA     S
        LDA     #$10
        LDX     #$40
        STX     R
.HAL6
        LDX     R
        STX     SC+1
        STA     T
        AND     #$FC
        STA     SC
        LDX     #$88
        LDY     #$01
.HAL7
        TXA
        AND     (SC),Y
        BNE     HA6

        TXA
        AND     #$F0
        ORA     (SC),Y
        STA     (SC),Y
        INY
        CPY     #$08
        BNE     HAL7

        INC     SC+1
        INC     SC+1
        LDY     #$00
        BEQ     HAL7

.HA6
        LDA     T
        CLC
        ADC     #$10
        BCC     L2010

        INC     R
.L2010
        DEC     S
        BNE     HAL6

        LDA     #$09
        STA     LFE34
        RTS

.HA3
        RTS

.HAS2
        LDA     #$22
.HAL2
        TAX
        AND     (SC),Y
        BNE     HA3

        TXA
        AND     #$F0
        ORA     (SC),Y
        STA     (SC),Y
        TXA
        LSR     A
        BCC     HAL2

        TYA
        ADC     #$07
        TAY
        LDA     #$88
        BCC     HAL2

        INC     SC+1
.HAL3
        TAX
        AND     (SC),Y
        BNE     HA3

        TXA
        AND     #$F0
        ORA     (SC),Y
        STA     (SC),Y
        TXA
        LSR     A
        BCC     HAL3

        TYA
        ADC     #$07
        TAY
        LDA     #$88
        BCC     HAL3

        RTS

.HAS3
        TAX
        AND     (SC),Y
        BNE     HA3

        TXA
        ORA     (SC),Y
        STA     (SC),Y
        TXA
        ASL     A
        BCC     HAS3

        TYA
        SBC     #$08
        TAY
        LDA     #$10
        BCS     HAS3

        RTS

.DVID4_COPY
        LDX     #$08
        ASL     A
        STA     P
        LDA     #$00
.DVL4
        ROL     A
        BCS     DV8

        CMP     Q
        BCC     DV5

.DV8
        SBC     Q
.DV5
        ROL     P
        DEX
        BNE     DVL4

        RTS

.cls
        JSR     TTX66

        JMP     RR4

.TT67_COPY
        LDA     #$0C
.TT26
        STA     K3
        PHY
        PHX
        LDY     QQ17
        CPY     #$FF
        BEQ     RR4S

        LDY     #$0F
        STY     LFE34
        TAY
        BEQ     RR4S

        BMI     RR4S

        CMP     #$0B
        BEQ     cls

        CMP     #$07
        BNE     L20A4

        JMP     R5

.L20A4
        CMP     #$20
        BCS     RR1

        CMP     #$0A
        BEQ     RRX1

        LDX     #$01
        STX     XC
.RRX1
        CMP     #$0D
        BEQ     RR4S

        INC     YC
.RR4S
        JMP     RR4

.RR1
        LDX     #$23
        ASL     A
        ASL     A
        BCC     L20C1

        LDX     #$25
.L20C1
        ASL     A
        BCC     L20C5

        INX
.L20C5
        STA     P
        STX     P+1
        LDA     XC
        LDX     CATF
        BEQ     RR5

        CPY     #$20
        BNE     RR5

        CMP     #$11
        BEQ     RR4

.RR5
        ASL     A
        ASL     A
        ASL     A
        STA     SC
        LDA     YC
        CPY     #$7F
        BNE     RR2

        DEC     XC
        ASL     A
        ASL     SC
        ADC     #$3F
        TAX
        LDY     #$F0
        JSR     ZES2

        BEQ     RR4

.RR2
        INC     XC
        CMP     #$18
        BCC     RR3

        JSR     TTX66

        LDA     #$0F
        STA     LFE34
        LDA     #$01
        STA     XC
        STA     YC
        LDA     K3
        JMP     RR4

.RR3
        ASL     A
        ASL     SC
        ADC     #$40
        STA     SC+1
        LDA     SC
        CLC
        ADC     #$08
        STA     P+2
        LDA     SC+1
        STA     P+3
        LDY     #$07
.RRL1
        LDA     (P),Y
        AND     #$F0
        STA     U_COPY
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        ORA     U_COPY
        AND     COL
        EOR     (SC),Y
        STA     (SC),Y
        LDA     (P),Y
        AND     #$0F
        STA     U_COPY
        ASL     A
        ASL     A
        ASL     A
        ASL     A
        ORA     U_COPY
        AND     COL
        EOR     (P+2),Y
        STA     (P+2),Y
        DEY
        BPL     RRL1

.RR4
        LDA     #$09
        STA     LFE34
        PLX
        PLY
        LDA     K3
        CLC
        RTS

.R5
        JSR     BEEP

        JMP     RR4

.TTX66
        LDX     #$0F
        STX     LFE34
        LDX     #$40
.BOL1
        JSR     ZES1

        INX
        CPX     #$70
        BNE     BOL1

.BOX
        LDX     #$0F
        STX     LFE34
        LDA     COL
        PHA
        LDA     #$0F
        STA     COL
        LDY     #$01
        STY     YC
        STY     XC
        LDX     #$00
        STX     Y1
        STX     Y2
        STX     XX15
        DEX
        STX     X2
        JSR     LOIN

        LDA     #$02
        STA     XX15
        STA     X2
        JSR     BOS2

        JSR     BOS2

        LDA     COL
        STA     L4000
        STA     L41F8
        PLA
        STA     COL
        LDA     #$09
        STA     LFE34
        RTS

.BOS2
        JSR     BOS1

.BOS1
        STZ     Y1
        LDA     #$BF
        STA     Y2
        DEC     XX15
        DEC     X2
        JMP     LOIN

.ZES1
        LDY     #$00
        STY     SC
.ZES2
        LDA     #$00
        STX     SC+1
.ZEL1
        STA     (SC),Y
        INY
        BNE     ZEL1

        RTS

.CLYNS
        STZ     DLY
        STZ     de
        LDA     #$FF
        STA     DTW2
        LDA     #$80
        STA     QQ17
        LDA     #$14
        STA     YC
        JSR     TT67_COPY

        LDA     #$0F
        STA     LFE34
        LDA     #$6A
        STA     SC+1
        LDA     #$00
        STA     SC
        LDX     #$03
.CLYL
        LDY     #$08
.EE2
        STA     (SC),Y
        INY
        BNE     EE2

        INC     SC+1
        STA     (SC),Y
        LDY     #$F7
.L21F3
        STA     (SC),Y
        DEY
        BNE     L21F3

        INC     SC+1
        DEX
        BNE     CLYL

        LDA     #$09
        STA     LFE34
        LDA     #$00
        RTS

.DIALS
        LDA     #$0F
        STA     LFE34
        LDA     #$01
        STA     LDDEB
        LDA     #$A0
        STA     SC
        LDA     #$71
        STA     SC+1
        JSR     PZW2

        STX     K+1
        STA     K
        LDA     #$0E
        STA     T1
        LDA     DELTA
        JSR     L22EE

        STZ     R
        STZ     P
        LDA     #$08
        STA     S
        LDA     ALP1
        LSR     A
        LSR     A
        ORA     ALP2
        EOR     #$80
        JSR     ADD_COPY

        JSR     DIL2

        LDA     BETA
        LDX     BET1
        BEQ     L2245

        SBC     #$01
.L2245
        JSR     ADD_COPY

        JSR     DIL2

        LDY     #$00
        JSR     PZW

        STX     K
        STA     K+1
        LDX     #$03
        STX     T1
.DLL23
        STY     XX15,X
        DEX
        BPL     DLL23

        LDX     #$03
        LDA     ENERGY
        LSR     A
        LSR     A
        STA     Q
.DLL24
        SEC
        SBC     #$10
        BCC     DLL26

        STA     Q
        LDA     #$10
        STA     XX15,X
        LDA     Q
        DEX
        BPL     DLL24

        BMI     DLL9

.DLL26
        LDA     Q
        STA     XX15,X
.DLL9
        LDA     XX15,Y
        STY     P
        JSR     DIL

        LDY     P
        INY
        CPY     #$04
        BNE     DLL9

        LDA     #$70
        STA     SC+1
        LDA     #$20
        STA     SC
        LDA     FSH
        JSR     DILX

        LDA     ASH
        JSR     DILX

        LDA     #$0F
        STA     K
        STA     K+1
        LDA     QQ14
        JSR     L22ED

        JSR     PZW2

        STX     K+1
        STA     K
        LDX     #$0B
        STX     T1
        LDA     CABTMP
        JSR     DILX

        LDA     GNTMP
        JSR     DILX

        LDA     #$F0
        STA     T1
        LDA     #$0F
        STA     K
        STA     K+1
        LDA     ALTIT
        JSR     DILX

        LDA     #$09
        STA     LFE34
        JMP     COMPAS

.PZW2
        LDX     #$3F
        EQUB    $2C

.PZW
        LDX     #$23
        LDA     MCNT
        AND     #$08
        AND     FLH
        BEQ     L22E8

        LDA     #$0C
        RTS

.L22E8
        LDA     #$03
        RTS

.DILX
        LSR     A
        LSR     A
.L22ED
        LSR     A
.L22EE
        LSR     A
.DIL
        STA     Q
        LDX     #$FF
        STX     R
        CMP     T1
        BCS     DL30

        LDA     K+1
        BNE     DL31

.DL30
        LDA     K
.DL31
        STA     COL
        LDY     #$02
        LDX     #$07
.DL1
        LDA     Q
        CMP     #$02
        BCC     DL2

        SBC     #$02
        STA     Q
        LDA     R
.DL5
        AND     COL
        STA     (SC),Y
        INY
        STA     (SC),Y
        INY
        STA     (SC),Y
        TYA
        CLC
        ADC     #$06
        TAY
        DEX
        BMI     DL6

        BPL     DL1

.DL2
        EOR     #$01
        STA     Q
        LDA     R
.DL3
        ASL     A
        AND     #$AA
        DEC     Q
        BPL     DL3

        PHA
        STZ     R
        LDA     #$63
        STA     Q
        PLA
        JMP     DL5

.DL6
        INC     SC+1
        INC     SC+1
        RTS

.DIL2
        LDY     #$01
        STA     Q
.DLL10
        SEC
        LDA     Q
        SBC     #$02
        BCS     DLL11

        LDA     #$FF
        LDX     Q
        STA     Q
        LDA     CTWOS,X
        AND     #$3F
        BNE     DLL12

.DLL11
        STA     Q
        LDA     #$00
.DLL12
        STA     (SC),Y
        INY
        STA     (SC),Y
        INY
        STA     (SC),Y
        INY
        STA     (SC),Y
        TYA
        CLC
        ADC     #$05
        TAY
        CPY     #$3C
        BCC     DLL10

        INC     SC+1
        INC     SC+1
        RTS

.ADD_COPY
        STA     T1
        AND     #$80
        STA     T
        EOR     S
        BMI     MU8_COPY

        LDA     R
        CLC
        ADC     P
        TAX
        LDA     S
        ADC     T1
        ORA     T
        RTS

.MU8_COPY
        LDA     S
        AND     #$7F
        STA     U
        LDA     P
        SEC
        SBC     R
        TAX
        LDA     T1
        AND     #$7F
        SBC     U
        BCS     MU9_COPY

        STA     U
        TXA
        EOR     #$FF
        ADC     #$01
        TAX
        LDA     #$00
        SBC     U
        ORA     #$80
.MU9_COPY
        EOR     T
        RTS

        EQUB    $41,$23,$6D,$65,$6D,$3A,$53,$54
        EQUB    $41,$6C,$61,$74,$63,$68,$3A,$52
        EQUB    $54,$53,$0D,$13,$74,$09,$5C,$2E
        EQUB    $2E,$2E,$2E,$0D,$18,$60,$05,$20
        EQUB    $0D,$1A,$F4,$21,$5C,$2E,$2E,$2E
        EQUB    $2E,$2E,$2E,$2E,$2E,$2E,$2E,$42
        EQUB    $61,$79,$20,$56,$69,$65,$77,$2E
        EQUB    $2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E
        EQUB    $2E,$0D,$1A,$FE,$05,$20,$0D,$1B
        EQUB    $08,$11,$2E,$48,$41

        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $18,$18,$18,$18,$18,$00,$18,$00
        EQUB    $6C,$6C,$6C,$00,$00,$00,$00,$00
        EQUB    $36,$36,$7F,$36,$7F,$36,$36,$00
        EQUB    $0C,$3F,$68,$3E,$0B,$7E,$18,$00
        EQUB    $60,$66,$0C,$18,$30,$66,$06,$00
        EQUB    $38,$6C,$6C,$38,$6D,$66,$3B,$00
        EQUB    $0C,$18,$30,$00,$00,$00,$00,$00
        EQUB    $0C,$18,$30,$30,$30,$18,$0C,$00
        EQUB    $30,$18,$0C,$0C,$0C,$18,$30,$00
        EQUB    $00,$18,$7E,$3C,$7E,$18,$00,$00
        EQUB    $00,$18,$18,$7E,$18,$18,$00,$00
        EQUB    $00,$00,$00,$00,$00,$18,$18,$30
        EQUB    $00,$00,$00,$7E,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$18,$18,$00
        EQUB    $00,$06,$0C,$18,$30,$60,$00,$00
        EQUB    $3C,$66,$6E,$7E,$76,$66,$3C,$00
        EQUB    $18,$38,$18,$18,$18,$18,$7E,$00
        EQUB    $3C,$66,$06,$0C,$18,$30,$7E,$00
        EQUB    $3C,$66,$06,$1C,$06,$66,$3C,$00
        EQUB    $0C,$1C,$3C,$6C,$7E,$0C,$0C,$00
        EQUB    $7E,$60,$7C,$06,$06,$66,$3C,$00
        EQUB    $1C,$30,$60,$7C,$66,$66,$3C,$00
        EQUB    $7E,$06,$0C,$18,$30,$30,$30,$00
        EQUB    $3C,$66,$66,$3C,$66,$66,$3C,$00
        EQUB    $3C,$66,$66,$3E,$06,$0C,$38,$00
        EQUB    $00,$00,$18,$18,$00,$18,$18,$00
        EQUB    $00,$00,$18,$18,$00,$18,$18,$30
        EQUB    $0C,$18,$30,$60,$30,$18,$0C,$00
        EQUB    $00,$00,$7E,$00,$7E,$00,$00,$00
        EQUB    $30,$18,$0C,$06,$0C,$18,$30,$00
        EQUB    $3C,$66,$0C,$18,$18,$00,$18,$00
        EQUB    $3C,$66,$6E,$6A,$6E,$60,$3C,$00
        EQUB    $3C,$66,$66,$7E,$66,$66,$66,$00
        EQUB    $7C,$66,$66,$7C,$66,$66,$7C,$00
        EQUB    $3C,$66,$60,$60,$60,$66,$3C,$00
        EQUB    $78,$6C,$66,$66,$66,$6C,$78,$00
        EQUB    $7E,$60,$60,$7C,$60,$60,$7E,$00
        EQUB    $7E,$60,$60,$7C,$60,$60,$60,$00
        EQUB    $3C,$66,$60,$6E,$66,$66,$3C,$00
        EQUB    $66,$66,$66,$7E,$66,$66,$66,$00
        EQUB    $7E,$18,$18,$18,$18,$18,$7E,$00
        EQUB    $3E,$0C,$0C,$0C,$0C,$6C,$38,$00
        EQUB    $66,$6C,$78,$70,$78,$6C,$66,$00
        EQUB    $60,$60,$60,$60,$60,$60,$7E,$00
        EQUB    $63,$77,$7F,$6B,$6B,$63,$63,$00
        EQUB    $66,$66,$76,$7E,$6E,$66,$66,$00
        EQUB    $3C,$66,$66,$66,$66,$66,$3C,$00
        EQUB    $7C,$66,$66,$7C,$60,$60,$60,$00
        EQUB    $3C,$66,$66,$66,$6A,$6C,$36,$00
        EQUB    $7C,$66,$66,$7C,$6C,$66,$66,$00
        EQUB    $3C,$66,$60,$3C,$06,$66,$3C,$00
        EQUB    $7E,$18,$18,$18,$18,$18,$18,$00
        EQUB    $66,$66,$66,$66,$66,$66,$3C,$00
        EQUB    $66,$66,$66,$66,$66,$3C,$18,$00
        EQUB    $63,$63,$6B,$6B,$7F,$77,$63,$00
        EQUB    $66,$66,$3C,$18,$3C,$66,$66,$00
        EQUB    $66,$66,$66,$3C,$18,$18,$18,$00
        EQUB    $7E,$06,$0C,$18,$30,$60,$7E,$00
        EQUB    $7C,$60,$60,$60,$60,$60,$7C,$00
        EQUB    $00,$60,$30,$18,$0C,$06,$00,$00
        EQUB    $3E,$06,$06,$06,$06,$06,$3E,$00
        EQUB    $18,$3C,$66,$42,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$FF
        EQUB    $1C,$36,$30,$7C,$30,$30,$7E,$00
        EQUB    $00,$00,$3C,$06,$3E,$66,$3E,$00
        EQUB    $60,$60,$7C,$66,$66,$66,$7C,$00
        EQUB    $00,$00,$3C,$66,$60,$66,$3C,$00
        EQUB    $06,$06,$3E,$66,$66,$66,$3E,$00
        EQUB    $00,$00,$3C,$66,$7E,$60,$3C,$00
        EQUB    $1C,$30,$30,$7C,$30,$30,$30,$00
        EQUB    $00,$00,$3E,$66,$66,$3E,$06,$3C
        EQUB    $60,$60,$7C,$66,$66,$66,$66,$00
        EQUB    $18,$00,$38,$18,$18,$18,$3C,$00
        EQUB    $18,$00,$38,$18,$18,$18,$18,$70
        EQUB    $60,$60,$66,$6C,$78,$6C,$66,$00
        EQUB    $38,$18,$18,$18,$18,$18,$3C,$00
        EQUB    $00,$00,$36,$7F,$6B,$6B,$63,$00
        EQUB    $00,$00,$7C,$66,$66,$66,$66,$00
        EQUB    $00,$00,$3C,$66,$66,$66,$3C,$00
        EQUB    $00,$00,$7C,$66,$66,$7C,$60,$60
        EQUB    $00,$00,$3E,$66,$66,$3E,$06,$07
        EQUB    $00,$00,$6C,$76,$60,$60,$60,$00
        EQUB    $00,$00,$3E,$60,$3C,$06,$7C,$00
        EQUB    $30,$30,$7C,$30,$30,$30,$1C,$00
        EQUB    $00,$00,$66,$66,$66,$66,$3E,$00
        EQUB    $00,$00,$66,$66,$66,$3C,$18,$00
        EQUB    $00,$00,$63,$6B,$6B,$7F,$36,$00
        EQUB    $00,$00,$66,$3C,$18,$3C,$66,$00
        EQUB    $00,$00,$66,$66,$66,$3E,$06,$3C
        EQUB    $00,$00,$7E,$0C,$18,$30,$7E,$00
        EQUB    $0C,$18,$18,$70,$18,$18,$0C,$00
        EQUB    $18,$18,$18,$00,$18,$18,$18,$00
        EQUB    $30,$18,$18,$0E,$18,$18,$30,$00
        EQUB    $31,$6B,$46,$00,$00,$00,$00,$00
        EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

.log
        EQUB    $00,$00,$20,$32,$40,$4A,$52,$59
        EQUB    $60,$65,$6A,$6E,$72,$76,$79,$7D
        EQUB    $80,$82,$85,$87,$8A,$8C,$8E,$90
        EQUB    $92,$94,$96,$98,$99,$9B,$9D,$9E
        EQUB    $A0,$A1,$A2,$A4,$A5,$A6,$A7,$A9
        EQUB    $AA,$AB,$AC,$AD,$AE,$AF,$B0,$B1
        EQUB    $B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9
        EQUB    $B9,$BA,$BB,$BC,$BD,$BD,$BE,$BF
        EQUB    $C0,$C0,$C1,$C2,$C2,$C3,$C4,$C4
        EQUB    $C5,$C6,$C6,$C7,$C7,$C8,$C9,$C9
        EQUB    $CA,$CA,$CB,$CC,$CC,$CD,$CD,$CE
        EQUB    $CE,$CF,$CF,$D0,$D0,$D1,$D1,$D2
        EQUB    $D2,$D3,$D3,$D4,$D4,$D5,$D5,$D5
        EQUB    $D6,$D6,$D7,$D7,$D8,$D8,$D9,$D9
        EQUB    $D9,$DA,$DA,$DB,$DB,$DB,$DC,$DC
        EQUB    $DD,$DD,$DD,$DE,$DE,$DE,$DF,$DF
        EQUB    $E0,$E0,$E0,$E1,$E1,$E1,$E2,$E2
        EQUB    $E2,$E3,$E3,$E3,$E4,$E4,$E4,$E5
        EQUB    $E5,$E5,$E6,$E6,$E6,$E7,$E7,$E7
        EQUB    $E7,$E8,$E8,$E8,$E9,$E9,$E9,$EA
        EQUB    $EA,$EA,$EA,$EB,$EB,$EB,$EC,$EC
        EQUB    $EC,$EC,$ED,$ED,$ED,$ED,$EE,$EE
        EQUB    $EE,$EE,$EF,$EF,$EF,$EF,$F0,$F0
        EQUB    $F0,$F1,$F1,$F1,$F1,$F1,$F2,$F2
        EQUB    $F2,$F2,$F3,$F3,$F3,$F3,$F4,$F4
        EQUB    $F4,$F4,$F5,$F5,$F5,$F5,$F5,$F6
        EQUB    $F6,$F6,$F6,$F7,$F7,$F7,$F7,$F7
        EQUB    $F8,$F8,$F8,$F8,$F9,$F9,$F9,$F9
        EQUB    $F9,$FA,$FA,$FA,$FA,$FA,$FB,$FB
        EQUB    $FB,$FB,$FB,$FC,$FC,$FC,$FC,$FC
        EQUB    $FD,$FD,$FD,$FD,$FD,$FD,$FE,$FE
        EQUB    $FE,$FE,$FE,$FF,$FF,$FF,$FF,$FF

.logL
        EQUB    $60,$00,$00,$B8,$00,$4D,$B8,$D6
        EQUB    $00,$70,$4D,$B4,$B8,$6A,$D6,$05
        EQUB    $00,$CC,$70,$EF,$4D,$8E,$B4,$C1
        EQUB    $B8,$9A,$6A,$28,$D6,$75,$05,$89
        EQUB    $00,$6C,$CC,$23,$70,$B4,$EF,$22
        EQUB    $4D,$71,$8E,$A4,$B4,$BD,$C1,$BF
        EQUB    $B8,$AC,$9A,$85,$6A,$4B,$28,$01
        EQUB    $D6,$A7,$75,$3F,$05,$C9,$89,$46
        EQUB    $00,$B7,$6C,$1D,$CC,$79,$23,$CB
        EQUB    $70,$13,$B4,$52,$EF,$8A,$22,$B9
        EQUB    $4D,$E0,$71,$00,$8E,$1A,$A4,$2D
        EQUB    $B4,$39,$BD,$40,$C1,$41,$BF,$3C
        EQUB    $B8,$32,$AC,$24,$9A,$10,$85,$F8
        EQUB    $6A,$DB,$4B,$BA,$28,$95,$01,$6C
        EQUB    $D6,$3F,$A7,$0E,$75,$DA,$3F,$A2
        EQUB    $05,$67,$C9,$29,$89,$E8,$46,$A3
        EQUB    $00,$5C,$B7,$12,$6C,$C5,$1D,$75
        EQUB    $CC,$23,$79,$CE,$23,$77,$CB,$1E
        EQUB    $70,$C2,$13,$64,$B4,$03,$52,$A1
        EQUB    $EF,$3D,$8A,$D6,$22,$6E,$B9,$03
        EQUB    $4D,$97,$E0,$29,$71,$B9,$00,$47
        EQUB    $8E,$D4,$1A,$5F,$A4,$E8,$2D,$70
        EQUB    $B4,$F7,$39,$7B,$BD,$FF,$40,$81
        EQUB    $C1,$01,$41,$80,$BF,$FE,$3C,$7A
        EQUB    $B8,$F5,$32,$6F,$AC,$E8,$24,$5F
        EQUB    $9A,$D5,$10,$4A,$85,$BE,$F8,$31
        EQUB    $6A,$A3,$DB,$13,$4B,$83,$BA,$F1
        EQUB    $28,$5F,$95,$CB,$01,$36,$6C,$A1
        EQUB    $D6,$0A,$3F,$73,$A7,$DB,$0E,$42
        EQUB    $75,$A7,$DA,$0C,$3F,$71,$A2,$D4
        EQUB    $05,$36,$67,$98,$C9,$F9,$29,$59
        EQUB    $89,$B8,$E8,$17,$46,$75,$A3,$D2

.antilog
        EQUB    $01,$01,$01,$01,$01,$01,$01,$01
        EQUB    $01,$01,$01,$01,$01,$01,$01,$01
        EQUB    $01,$01,$01,$01,$01,$01,$01,$01
        EQUB    $01,$01,$01,$01,$01,$01,$01,$01
        EQUB    $02,$02,$02,$02,$02,$02,$02,$02
        EQUB    $02,$02,$02,$02,$02,$02,$02,$02
        EQUB    $02,$02,$02,$03,$03,$03,$03,$03
        EQUB    $03,$03,$03,$03,$03,$03,$03,$03
        EQUB    $04,$04,$04,$04,$04,$04,$04,$04
        EQUB    $04,$04,$04,$05,$05,$05,$05,$05
        EQUB    $05,$05,$05,$06,$06,$06,$06,$06
        EQUB    $06,$06,$07,$07,$07,$07,$07,$07
        EQUB    $08,$08,$08,$08,$08,$08,$09,$09
        EQUB    $09,$09,$09,$0A,$0A,$0A,$0A,$0B
        EQUB    $0B,$0B,$0B,$0C,$0C,$0C,$0C,$0D
        EQUB    $0D,$0D,$0E,$0E,$0E,$0E,$0F,$0F
        EQUB    $10,$10,$10,$11,$11,$11,$12,$12
        EQUB    $13,$13,$13,$14,$14,$15,$15,$16
        EQUB    $16,$17,$17,$18,$18,$19,$19,$1A
        EQUB    $1A,$1B,$1C,$1C,$1D,$1D,$1E,$1F
        EQUB    $20,$20,$21,$22,$22,$23,$24,$25
        EQUB    $26,$26,$27,$28,$29,$2A,$2B,$2C
        EQUB    $2D,$2E,$2F,$30,$31,$32,$33,$34
        EQUB    $35,$36,$38,$39,$3A,$3B,$3D,$3E
        EQUB    $40,$41,$42,$44,$45,$47,$48,$4A
        EQUB    $4C,$4D,$4F,$51,$52,$54,$56,$58
        EQUB    $5A,$5C,$5E,$60,$62,$64,$67,$69
        EQUB    $6B,$6D,$70,$72,$75,$77,$7A,$7D
        EQUB    $80,$82,$85,$88,$8B,$8E,$91,$94
        EQUB    $98,$9B,$9E,$A2,$A5,$A9,$AD,$B1
        EQUB    $B5,$B8,$BD,$C1,$C5,$C9,$CE,$D2
        EQUB    $D7,$DB,$E0,$E5,$EA,$EF,$F5,$FA

        EQUB    $01,$02,$03,$04,$05,$06,$00,$01
        EQUB    $02,$03,$04,$05,$06,$00,$01,$02
        EQUB    $03,$04,$05,$06,$00,$01,$02,$03
        EQUB    $04,$05,$06,$00,$01,$02,$03,$04
        EQUB    $05,$06,$00,$01,$02,$03,$04,$05
        EQUB    $06,$00,$01,$02,$03,$04,$05,$06
        EQUB    $00,$01,$02,$03,$04,$05,$06,$00
        EQUB    $01,$02,$03,$04,$05,$06,$00,$01
        EQUB    $02,$03,$04,$05,$06,$00,$01,$02
        EQUB    $03,$04,$05,$06,$00,$01,$02,$03
        EQUB    $04,$05,$06,$00,$01,$02,$03,$04
        EQUB    $05,$06,$00,$01,$02,$03,$04,$05
        EQUB    $06,$00,$01,$02,$03,$04,$05,$06
        EQUB    $00,$01,$02,$03,$04,$05,$06,$00
        EQUB    $01,$02,$03,$04,$05,$06,$00,$01
        EQUB    $02,$03,$04,$05,$06,$00,$01,$02
        EQUB    $03,$04,$05,$06,$00,$01,$02,$03
        EQUB    $04,$05,$06,$00,$01,$02,$03,$04
        EQUB    $05,$06,$00,$01,$02,$03,$04,$05
        EQUB    $06,$00,$01,$02,$03,$04,$05,$06
        EQUB    $00,$01,$02,$03,$04,$05,$06,$00
        EQUB    $01,$02,$03,$04,$05,$06,$00,$01
        EQUB    $02,$03,$04,$05,$06,$00,$01,$02
        EQUB    $03,$04,$05,$06,$00,$01,$02,$03
        EQUB    $04,$05,$06,$00,$01,$02,$03,$04
        EQUB    $05,$06,$00,$01,$02,$03,$04,$05
        EQUB    $06,$00,$01,$02,$03,$04,$05,$06
        EQUB    $00,$01,$02,$03,$04,$05,$06,$00
        EQUB    $01,$02,$03,$04,$05,$06,$00,$01
        EQUB    $02,$03,$04,$05,$06,$00,$01,$02
        EQUB    $03,$04,$05,$06,$00,$01,$02,$03
        EQUB    $04,$05,$06,$00,$01,$02,$03,$04
        EQUB    $01,$01,$01,$01,$01,$01,$02,$02
        EQUB    $02,$02,$02,$02,$02,$03,$03,$03
        EQUB    $03,$03,$03,$03,$04,$04,$04,$04
        EQUB    $04,$04,$04,$05,$05,$05,$05,$05
        EQUB    $05,$05,$06,$06,$06,$06,$06,$06
        EQUB    $06,$07,$07,$07,$07,$07,$07,$07
        EQUB    $08,$08,$08,$08,$08,$08,$08,$09
        EQUB    $09,$09,$09,$09,$09,$09,$0A,$0A
        EQUB    $0A,$0A,$0A,$0A,$0A,$0B,$0B,$0B
        EQUB    $0B,$0B,$0B,$0B,$0C,$0C,$0C,$0C
        EQUB    $0C,$0C,$0C,$0D,$0D,$0D,$0D,$0D
        EQUB    $0D,$0D,$0E,$0E,$0E,$0E,$0E,$0E
        EQUB    $0E,$0F,$0F,$0F,$0F,$0F,$0F,$0F
        EQUB    $10,$10,$10,$10,$10,$10,$10,$11
        EQUB    $11,$11,$11,$11,$11,$11,$12,$12
        EQUB    $12,$12,$12,$12,$12,$13,$13,$13
        EQUB    $13,$13,$13,$13,$14,$14,$14,$14
        EQUB    $14,$14,$14,$15,$15,$15,$15,$15
        EQUB    $15,$15,$16,$16,$16,$16,$16,$16
        EQUB    $16,$17,$17,$17,$17,$17,$17,$17
        EQUB    $18,$18,$18,$18,$18,$18,$18,$19
        EQUB    $19,$19,$19,$19,$19,$19,$1A,$1A
        EQUB    $1A,$1A,$1A,$1A,$1A,$1B,$1B,$1B
        EQUB    $1B,$1B,$1B,$1B,$1C,$1C,$1C,$1C
        EQUB    $1C,$1C,$1C,$1D,$1D,$1D,$1D,$1D
        EQUB    $1D,$1D,$1E,$1E,$1E,$1E,$1E,$1E
        EQUB    $1E,$1F,$1F,$1F,$1F,$1F,$1F,$1F
        EQUB    $20,$20,$20,$20,$20,$20,$20,$21
        EQUB    $21,$21,$21,$21,$21,$21,$22,$22
        EQUB    $22,$22,$22,$22,$22,$23,$23,$23
        EQUB    $23,$23,$23,$23,$24,$24,$24,$24
        EQUB    $24,$24,$24,$25,$25,$25,$25,$25
        EQUB    $96,$97,$9A,$9B,$9D,$9E,$9F,$A6
        EQUB    $A7,$AB,$AC,$AD,$AE,$AF,$B2,$B3
        EQUB    $B4,$B5,$B6,$B7,$B9,$BA,$BB,$BC
        EQUB    $BD,$BE,$BF,$CB,$CD,$CE,$CF,$D3
        EQUB    $D6,$D7,$D9,$DA,$DB,$DC,$DD,$DE
        EQUB    $DF,$E5,$E6,$E7,$E9,$EA,$EB,$EC
        EQUB    $ED,$EE,$EF,$F2,$F3,$F4,$F5,$F6
        EQUB    $F7,$F9,$FA,$FB,$FC,$FD,$FE,$FF

.COMC
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00

.CATF
        EQUB    $00,$00

.L2C55
        EQUB    $00

.DAMP
        EQUB    $00

.DJD
        EQUB    $00

.PATG
        EQUB    $00

.FLH
        EQUB    $00

.L2C5A
        EQUB    $00

.L2C5B
        EQUB    $00

.JSTK
        EQUB    $00,$00

.L2C5E
        EQUB    $00

.BSTK
        EQUB    $00,$00

.L2C61
        EQUB    $07

.L2C62
        EQUB    $01,$41,$58,$46,$59,$4A,$4B,$55
        EQUB    $54,$60

.S%
        CLD
        JSR     MOVE_CODE

        JSR     BRKBK

        JMP     BEGIN

.MOVE_CODE
        LDA     #$C0
        STA     FRIN
        LDA     #$2C
        STA     FRIN+1
        LDA     #$7F
        LDY     #$47
        LDX     #$19
        JSR     MOVE_CODE_L1

        LDA     #$FF
        STA     FRIN
        LDA     #$7F
        STA     FRIN+1
        LDA     #$B1
        LDY     #$FF
        LDX     #$62
.MOVE_CODE_L1
        STX     T
        STA     SC+1
        LDA     #$00
        STA     SC
.MOVE_CODE_L2
        LDA     (SC),Y
        SEC
        SBC     T
        STA     (SC),Y
        STA     T
        TYA
        BNE     L2CAF

        DEC     SC+1
.L2CAF
        DEY
        CPY     FRIN
        BNE     MOVE_CODE_L2

        LDA     SC+1
        CMP     FRIN+1
        BNE     MOVE_CODE_L2

        RTS

        EQUB    $B7

        EQUB    $AA,$45,$23

.DOENTRY
        JSR     RES2

        JSR     LAUN

        LDA     #$00
        STA     DELTA
        STA     GNTMP
        STA     QQ22+1
        LDA     #$FF
        STA     FSH
        STA     ASH
        STA     ENERGY
        JSR     HALL

        LDY     #$2C
        JSR     DELAY

        LDA     TP
        AND     #$03
        BNE     EN1

        LDA     TALLY+1
        BEQ     EN4

        LDA     GCNT
        LSR     A
        BNE     EN4

        JMP     BRIEF

.EN1
        CMP     #$03
        BNE     EN2

        JMP     DEBRIEF

.EN2
        LDA     GCNT
        CMP     #$02
        BNE     EN4

        LDA     TP
        AND     #$0F
        CMP     #$02
        BNE     EN3

        LDA     TALLY+1
        CMP     #$05
        BCC     EN4

        JMP     BRIEF2

.EN3
        CMP     #$06
        BNE     EN5

        LDA     QQ0
        CMP     #$D7
        BNE     EN4

        LDA     QQ1
        CMP     #$54
        BNE     EN4

        JMP     BRIEF3

.EN5
        CMP     #$0A
        BNE     EN4

        LDA     QQ0
        CMP     #$3F
        BNE     EN4

        LDA     QQ1
        CMP     #$48
        BNE     EN4

        JMP     DEBRIEF2

.EN4
        JMP     BAY

        EQUB    $FB

        EQUB    $04,$F7,$08,$EF,$10,$DF,$20,$BF
        EQUB    $40,$7F,$80

.M%
        LDA     K%
        STA     RAND
        LDX     JSTX
        JSR     cntr

        JSR     cntr

        TXA
        EOR     #$80
        TAY
        AND     #$80
        STA     ALP2
        STX     JSTX
        EOR     #$80
        STA     ALP2+1
        TYA
        BPL     L2D72

        EOR     #$FF
        CLC
        ADC     #$01
.L2D72
        LSR     A
        LSR     A
        CMP     #$08
        BCS     L2D79

        LSR     A
.L2D79
        STA     ALP1
        ORA     ALP2
        STA     ALPHA
        LDX     JSTY
        JSR     cntr

        TXA
        EOR     #$80
        TAY
        AND     #$80
        STX     JSTY
        STA     BET2+1
        EOR     #$80
        STA     BET2
        TYA
        BPL     L2D97

        EOR     #$FF
.L2D97
        ADC     #$04
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        CMP     #$03
        BCS     L2DA2

        LSR     A
.L2DA2
        STA     BET1
        ORA     BET2
        STA     BETA
        LDA     BSTK
        BEQ     BS2

        LDA     L12A9
        LSR     A
        LSR     A
        CMP     #$28
        BCC     L2DB8

        LDA     #$28
.L2DB8
        STA     DELTA
        BNE     MA4

.BS2
        LDA     KY2
        BEQ     MA17

        LDA     DELTA
        CMP     #$28
        BCS     MA17

        INC     DELTA
.MA17
        LDA     KY1
        BEQ     MA4

        DEC     DELTA
        BNE     MA4

        INC     DELTA
.MA4
        LDA     KY15
        AND     NOMSL
        BEQ     MA20

        LDY     #$0C
        JSR     ABORT

        JSR     BEEP_LONG_LOW

        LDA     #$00
        STA     MSAR
.MA20
        LDA     MSTG
        BPL     MA25

        LDA     KY14
        BEQ     MA25

        LDX     NOMSL
        BEQ     MA25

        STA     MSAR
        LDY     #$0F
        JSR     MSBAR

.MA25
        LDA     KY16
        BEQ     MA24

        LDA     MSTG
        BMI     MA64

        JSR     FRMIS

.MA24
        LDA     KY12
        BEQ     MA76

        LDA     BOMB
        BMI     MA76

        ASL     BOMB
        BEQ     MA76

        JSR     L31ED

.MA76
        LDA     KY20
        BEQ     MA78

        LDA     #$00
        STA     auto
.MA78
        LDA     KY13
        AND     ESCP
        BEQ     noescp

        LDA     MJ
        BNE     noescp

        JMP     ESCAPE

.noescp
        LDA     KY18
        BEQ     L2E36

        JSR     WARP

.L2E36
        LDA     KY17
        AND     ECM
        BEQ     MA64

        LDA     ECMA
        BNE     MA64

        DEC     ECMP
        JSR     ECBLB2

.MA64
        LDA     KY19
        AND     DKCMP
        BEQ     MA68

        STA     auto
.MA68
        LDA     #$00
        STA     LAS
        STA     DELT4
        LDA     DELTA
        LSR     A
        ROR     DELT4
        LSR     A
        ROR     DELT4
        STA     DELT4+1
        LDA     LASCT
        BNE     MA3

        LDA     KY7
        BEQ     MA3

        LDA     GNTMP
        CMP     #$F2
        BCS     MA3

        LDX     VIEW
        LDA     LASER,X
        BEQ     MA3

        PHA
        AND     #$7F
        STA     LAS
        STA     LAS2
        JSR     LASER_NOISE

        JSR     LASLI

        PLA
        BPL     ma1

        LDA     #$00
.ma1
        AND     #$FA
        STA     LASCT
.MA3
        LDX     #$00
.MAL1
        STX     XSAV
        LDA     FRIN,X
        BNE     L2E9D

        JMP     MA18

.L2E9D
        STA     TYPE
        JSR     GINF

        LDY     #$24
.MAL2
        LDA     (INF),Y
        STA     INWK,Y
        DEY
        BPL     MAL2

        LDA     TYPE
        BMI     MA21

        ASL     A
        TAY
        LDA     L7FFE,Y
        STA     XX0
        LDA     L7FFF,Y
        STA     XX0+1
        LDA     BOMB
        BPL     MA21

        CPY     #$04
        BEQ     MA21

        CPY     #$3A
        BEQ     MA21

        CPY     #$3E
        BCS     MA21

        LDA     INWK+31
        AND     #$20
        BNE     MA21

        ASL     INWK+31
        SEC
        ROR     INWK+31
        LDX     TYPE
        JSR     EXNO2

.MA21
        JSR     MVEIT

        LDY     #$24
.MAL3
        LDA     INWK,Y
        STA     (INF),Y
        DEY
        BPL     MAL3

        LDA     INWK+31
        AND     #$A0
        JSR     MAS4

        BNE     MA65

        LDA     INWK
        ORA     INWK+3
        ORA     INWK+6
        BMI     MA65

        LDX     TYPE
        BMI     MA65

        CPX     #$02
        BEQ     ISDK

        AND     #$C0
        BNE     MA65

        CPX     #$01
        BEQ     MA65

        LDA     BST
        AND     INWK+5
        BPL     MA58

        CPX     #$05
        BEQ     oily

        LDY     #$00
        LDA     (XX0),Y
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        BEQ     MA58

        ADC     #$01
        BNE     slvy2

.oily
        JSR     DORND

        AND     #$07
.slvy2
        JSR     tnpr1

        LDY     #$4E
        BCS     MA59

        LDY     QQ29
        ADC     QQ20,Y
        STA     QQ20,Y
        TYA
        ADC     #$D0
        JSR     MESS

        ASL     NEWB
        SEC
        ROR     NEWB
.MA65
        JMP     MA26

.ISDK
        LDA     L0449
        AND     #$04
        BNE     MA62

        LDA     INWK+14
        CMP     #$D6
        BCC     MA62

        JSR     SPS1

        LDA     X2
        CMP     #$59
        BCC     MA62

        LDA     INWK+16
        AND     #$7F
        CMP     #$50
        BCC     MA62

.GOIN
        JMP     DOENTRY

.MA62
        LDA     DELTA
        CMP     #$05
        BCC     MA67

        JMP     DEATH

.MA59
        JSR     EXNO3

        ASL     INWK+31
        SEC
        ROR     INWK+31
        BNE     MA26

.MA67
        LDA     #$01
        STA     DELTA
        LDA     #$05
        BNE     MA63

.MA58
        ASL     INWK+31
        SEC
        ROR     INWK+31
        LDA     INWK+35
        SEC
        ROR     A
.MA63
        JSR     OOPS

        JSR     EXNO3

.MA26
        LDA     NEWB
        BPL     L2F99

        JSR     SCAN

.L2F99
        LDA     QQ11
        BNE     MA15

        JSR     PLUT

        JSR     HITCH

        BCC     MA8

        LDA     MSAR
        BEQ     MA47

        JSR     BEEP

        LDX     XSAV
        LDY     #$03
        JSR     ABORT2

.MA47
        LDA     LAS
        BEQ     MA8

        LDX     #$0F
        JSR     EXNO

        LDA     TYPE
        CMP     #$02
        BEQ     L3004

        CMP     #$1F
        BCC     BURN

        LDA     LAS
        CMP     #$17
        BNE     L3004

        LSR     LAS
        LSR     LAS
.BURN
        LDA     INWK+35
        SEC
        SBC     LAS
        BCS     MA14

        ASL     INWK+31
        SEC
        ROR     INWK+31
        LDA     TYPE
        CMP     #$07
        BNE     nosp

        LDA     LAS
        CMP     #$32
        BNE     nosp

        JSR     DORND

        LDX     #$08
        AND     #$03
        JSR     SPIN2

.nosp
        LDY     #$04
        JSR     SPIN

        LDY     #$05
        JSR     SPIN

        LDX     TYPE
.L2FFF
        JSR     EXNO2

L3000 = L2FFF+1
.MA14
        STA     INWK+35
.L3004
        LDA     TYPE
        JSR     ANGRY

.MA8
        JSR     LL9

.MA15
        LDY     #$23
        LDA     INWK+35
        STA     (INF),Y
        LDA     NEWB
        BMI     KS1S

        LDA     INWK+31
        BPL     MAC1

        AND     #$20
        BEQ     MAC1

        LDA     NEWB
        AND     #$40
        ORA     FIST
        STA     FIST
        LDA     DLY
        ORA     MJ
        BNE     KS1S

        LDY     #$0A
        LDA     (XX0),Y
        BEQ     KS1S

        TAX
        INY
        LDA     (XX0),Y
        TAY
        JSR     MCASH

        LDA     #$00
        JSR     MESS

.KS1S
        JMP     KS1

.MAC1
        LDA     TYPE
        BMI     MA27

        JSR     FAROF

        BCC     KS1S

.MA27
        LDY     #$1F
        LDA     INWK+31
        STA     (INF),Y
        LDX     XSAV
        INX
        JMP     MAL1

.MA18
        LDA     BOMB
        BPL     MA77

        JSR     WSCAN_COPY

        ASL     BOMB
        BMI     MA77

        JSR     L31AC

.MA77
        LDA     MCNT
        AND     #$07
        BNE     MA22

        LDX     ENERGY
        BPL     b

        LDX     ASH
        JSR     SHD

        STX     ASH
        LDX     FSH
        JSR     SHD

        STX     FSH
.b
        SEC
        LDA     ENGY
        ADC     ENERGY
        BCS     L308D

        STA     ENERGY
.L308D
        LDA     MJ
        BNE     MA23S

        LDA     MCNT
        AND     #$1F
        BNE     MA93

        LDA     SSPR
        BNE     MA23S

        TAY
        JSR     MAS2

        BNE     MA23S

        LDX     #$1C
.MAL4
        LDA     K%,X
        STA     INWK,X
        DEX
        BPL     MAL4

        INX
        LDY     #$09
        JSR     MAS1

        BNE     MA23S

        LDX     #$03
        LDY     #$0B
        JSR     MAS1

        BNE     MA23S

        LDX     #$06
        LDY     #$0D
        JSR     MAS1

        BNE     MA23S

        LDA     #$C0
        JSR     FAROF2

        BCC     MA23S

        JSR     WPLS

        JSR     NWSPS

.MA23S
        JMP     MA23

.MA22
        LDA     MJ
        BNE     MA23S

        LDA     MCNT
        AND     #$1F
.MA93
        CMP     #$0A
        BNE     MA29

        LDA     #$32
        CMP     ENERGY
        BCC     L30EE

        ASL     A
        JSR     MESS

.L30EE
        LDY     #$FF
        STY     ALTIT
        INY
        JSR     m

        BNE     MA23

        JSR     MAS3

        BCS     MA23

        SBC     #$24
        BCC     MA28

        STA     R
        JSR     LL5

        LDA     Q
        STA     ALTIT
        BNE     MA23

.MA28
        JMP     DEATH

.MA29
        CMP     #$0F
        BNE     MA33

        LDA     auto
        BEQ     MA23

        LDA     #$7B
        BNE     MA34

.MA33
        CMP     #$14
        BNE     MA23

        LDA     #$1E
        STA     CABTMP
        LDA     SSPR
        BNE     MA23

        LDY     #$25
        JSR     MAS2

        BNE     MA23

        JSR     MAS3

        EOR     #$FF
        ADC     #$1E
        STA     CABTMP
        BCS     MA28

        CMP     #$E0
        BCC     MA23

        LDA     BST
        BEQ     MA23

        LDA     DELT4+1
        LSR     A
        ADC     QQ14
        CMP     #$46
        BCC     L3154

        LDA     #$46
.L3154
        STA     QQ14
        LDA     #$A0
.MA34
        JSR     MESS

.MA23
        LDA     LAS2
        BEQ     MA16

        LDA     LASCT
        CMP     #$08
        BCS     MA16

        JSR     LASLI2

        LDA     #$00
        STA     LAS2
.MA16
        LDA     ECMP
        BEQ     MA69

        JSR     DENGY

        BEQ     MA70

.MA69
        LDA     ECMA
        BEQ     MA66

        LDY     #$07
        JSR     NOISE

        DEC     ECMA
        BNE     MA66

.MA70
        JSR     ECMOF

.MA66
        LDA     QQ11
        BNE     oh

        JMP     STARS

.SPIN
        JSR     DORND

        BPL     oh

        TYA
        TAX
        LDY     #$00
        AND     (XX0),Y
        AND     #$0F
.SPIN2
        STA     CNT
        BEQ     oh

.L31A2
        LDA     #$00
        JSR     SFS1

        DEC     CNT
        BNE     L31A2

.oh
        RTS

.L31AC
        LDA     #$FF
        STA     COL
        LDA     QQ11
        BNE     L31DE

        LDY     #$01
        LDA     L321D
        STA     XX12
        LDA     L3227
        STA     XX12+1
.L31C0
        LDA     XX12
        STA     XX15
        LDA     XX12+1
        STA     Y1
        LDA     L321D,Y
        STA     X2
        STA     XX12
        LDA     L3227,Y
        STA     Y2
        STA     XX12+1
        JSR     LL30

        INY
        CPY     #$0A
        BCC     L31C0

.L31DE
        RTS

.WSCAN_COPY
        JSR     L31E2

.L31E2
        JSR     L31E5

.L31E5
        LDY     #$06
        JSR     NOISE

        JSR     L31AC

.L31ED
        LDY     #$00
.L31EF
        JSR     DORND

        AND     #$7F
        ADC     #$03
        STA     L3227,Y
        TXA
        AND     #$1F
        CLC
        ADC     L3213,Y
        STA     L321D,Y
        INY
        CPY     #$0A
        BCC     L31EF

        LDX     #$00
        STX     L3226
        DEX
        STX     L321D
        BCS     L31AC

.L3213
        CPX     #$E0
        CPY     #$A0
        BRA     L3279

        EQUB    $40

        EQUB    $20,$00,$00

.L321D
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00

.L3226
        EQUB    $00

.L3227
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00

.MT27
        LDA     #$D9
        BNE     L3237

        LDA     #$DC
.L3237
        CLC
        ADC     GCNT
        BNE     DETOK

.DETOK3
        PHA
        TAX
        TYA
        PHA
        LDA     V
        PHA
        LDA     V+1
        PHA
        LDA     #$7C
        STA     V
        LDA     #$AF
        BNE     DTEN

.DETOK
        PHA
        TAX
        TYA
        PHA
        LDA     V
        PHA
        LDA     V+1
        PHA
        LDA     #$00
        STA     V
        LDA     #$A4
.DTEN
        STA     V+1
        LDY     #$00
.DTL1
        LDA     (V),Y
        EOR     #$57
        BNE     DT1

        DEX
        BEQ     DTL2

.DT1
        INY
        BNE     DTL1

        INC     V+1
        BNE     DTL1

.DTL2
        INY
        BNE     L3278

        INC     V+1
.L3278
        LDA     (V),Y
L3279 = L3278+1
        EOR     #$57
        BEQ     DTEX

        JSR     DETOK2

        JMP     DTL2

.DTEX
        PLA
        STA     V+1
        PLA
        STA     V
        PLA
        TAY
        PLA
        RTS

.DETOK2
        CMP     #$20
        BCC     DT3

        BIT     DTW3
        BPL     DT8

        TAX
        TYA
        PHA
        LDA     V
        PHA
        LDA     V+1
        PHA
        TXA
        JSR     TT27

        JMP     DT7

.DT8
        CMP     #$5B
        BCC     DTS

        CMP     #$81
        BCC     DT6

        CMP     #$D7
        BCC     DETOK

        SBC     #$D7
        ASL     A
        PHA
        TAX
        LDA     TKN2,X
        JSR     DTS

        PLA
        TAX
        LDA     L340A,X
.DTS
        CMP     #$41
        BCC     DT9

        BIT     DTW6
        BMI     DT10

        BIT     DTW2
        BMI     DT5

.DT10
        ORA     L3B66
.DT5
        AND     DTW8
.DT9
        JMP     DASC

.DT3
        TAX
        TYA
        PHA
        LDA     V
        PHA
        LDA     V+1
        PHA
        TXA
        ASL     A
        TAX
        LDA     L33C7,X
        STA     L32F5
        LDA     VRTS,X
        STA     L32F6
        TXA
        LSR     A
.DTM
        JSR     DASC

L32F5 = DTM+1
L32F6 = DTM+2
.DT7
        PLA
        STA     V+1
        PLA
        STA     V
        PLA
        TAY
        RTS

.DT6
        STA     SC
        TYA
        PHA
        LDA     V
        PHA
        LDA     V+1
        PHA
        JSR     DORND

        TAX
        LDA     #$00
        CPX     #$33
        ADC     #$00
        CPX     #$66
        ADC     #$00
        CPX     #$99
        ADC     #$00
        CPX     #$CC
        LDX     SC
        ADC     L49C1,X
        JSR     DETOK

        JMP     DT7

        LDA     #$00
        EQUB    $2C

.MT2
        LDA     #$20
        STA     L3B66
        LDA     #$00
        STA     DTW6
        RTS

        LDA     #$06
        JSR     DOXC

        LDA     #$FF
        STA     DTW2
        RTS

        LDA     #$01
        STA     XC
        JMP     TT66

.MT13
        LDA     #$80
        STA     DTW6
        LDA     #$20
        STA     L3B66
        RTS

        LDA     #$80
        STA     QQ17
        LDA     #$FF
        EQUB    $2C

.MT5
        LDA     #$00
        STA     DTW3
        RTS

.MT14
        LDA     #$80
        EQUB    $2C

.MT15
        LDA     #$00
        STA     DTW4
        ASL     A
        STA     DTW5
        RTS

        LDA     QQ17
        AND     #$BF
        STA     QQ17
        LDA     #$03
        JSR     TT27

        LDX     DTW5
        LDA     BUF-1,X
        JSR     VOWEL

        BCC     MT171

        DEC     DTW5
.MT171
        LDA     #$99
        JMP     DETOK

        JSR     MT19

        JSR     DORND

        AND     #$03
        TAY
.MT18L
        JSR     DORND

        AND     #$3E
        TAX
        LDA     L340B,X
        JSR     DTS

        LDA     L340C,X
        JSR     DTS

        DEY
        BPL     MT18L

        RTS

.MT19
        LDA     #$DF
        STA     DTW8
        RTS

.VOWEL
        ORA     #$20
        CMP     #$61
        BEQ     VRTS

        CMP     #$65
        BEQ     VRTS

        CMP     #$69
        BEQ     VRTS

        CMP     #$6F
        BEQ     VRTS

        CMP     #$75
        BEQ     VRTS

.L33C7
        CLC
.VRTS
        RTS

.L33C9
        EQUB    $29,$33,$2C,$33,$E6,$57,$E6,$57
        EQUB    $5B,$33,$54,$33,$72,$3B,$37,$33
        EQUB    $42,$33,$72,$3B,$97,$35,$72,$3B
        EQUB    $49,$33,$61,$33,$64,$33,$70,$3B
        EQUB    $6E,$33,$8C,$33,$AB,$33,$72,$3B
        EQUB    $C1,$21,$BD,$49,$D3,$49,$F8,$49
        EQUB    $B3,$49,$0A,$69,$31,$32,$35,$32
        EQUB    $D6,$49,$60,$69,$69,$69,$72,$3B

.TKN2
        EQUB    $0C

.L340A
        EQUB    $0A

.L340B
        EQUB    $41

.L340C
        EQUB    $42,$4F,$55,$53,$45,$49,$54,$49
        EQUB    $4C,$45,$54,$53,$54,$4F,$4E,$4C
        EQUB    $4F,$4E,$55,$54,$48,$4E,$4F

.QQ16
        EQUB    $41

.L3424
        EQUB    $4C,$4C,$45,$58,$45,$47,$45,$5A
        EQUB    $41,$43,$45,$42,$49,$53,$4F,$55
        EQUB    $53,$45,$53,$41,$52,$4D,$41,$49
        EQUB    $4E,$44,$49,$52,$45,$41,$3F,$45
        EQUB    $52,$41,$54,$45,$4E,$42,$45,$52
        EQUB    $41,$4C,$41,$56,$45,$54,$49,$45
        EQUB    $44,$4F,$52,$51,$55,$41,$4E,$54
        EQUB    $45,$49,$53,$52,$49,$4F,$4E

.L3463
        EQUB    $3A,$30,$2E,$45

.L3467
        EQUB    $2E

.NA%
        EQUB    $6A,$61,$6D,$65,$73,$6F,$6E

.L346F
        EQUB    $0D

.L3470
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$10,$0F,$11
        EQUB    $00,$03,$1C,$0E,$00,$00,$0A,$00
        EQUB    $11,$3A,$07,$09,$08,$00,$00,$00
        EQUB    $00,$80

.CHK2
        EQUB    $00

.CHK
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$3A,$30,$2E
        EQUB    $45,$2E

.L34CD
        EQUB    $4A,$41,$4D,$45,$53,$4F,$4E,$0D
        EQUB    $00,$14,$AD,$4A,$5A,$48,$02,$53
        EQUB    $B7,$00,$00,$03,$E8,$46,$00,$00
        EQUB    $0F,$00,$00,$00,$00,$00,$16,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$03,$00,$10,$0F,$11
        EQUB    $00,$03,$1C,$0E,$00,$00,$0A,$00
        EQUB    $11,$3A,$07,$09,$08,$00,$00,$00
        EQUB    $00,$80,$AA,$03,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00

.shpcol
        EQUB    $00,$0F,$FF,$FF,$FF,$FF,$F0,$F0
        EQUB    $F0,$FF,$FF,$FF,$FF,$FF,$FF,$F0
        EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        EQUB    $FF,$FF,$FF,$FF,$C9,$FA,$FA,$FF
        EQUB    $FF,$FF

.scacol
        EQUB    $00,$0F,$0C,$30,$30,$30,$03,$03
        EQUB    $03,$3C,$3C,$3C,$33,$33,$33,$03
        EQUB    $3C,$3C,$3C,$3C,$3C,$3C,$3C,$30
        EQUB    $3C,$3C,$33,$3C,$3C,$3F,$3C,$3C
        EQUB    $00,$3C,$00,$00,$00,$00

.UNIV
        EQUB    $00

.L357A
        EQUB    $04,$25,$04,$4A,$04,$6F,$04,$94
        EQUB    $04,$B9,$04,$DE,$04,$03,$05,$28
        EQUB    $05,$4D,$05,$72,$05,$97,$05,$BC
        EQUB    $05

.FLKB
        RTS

.NLIN3
        JSR     TT27

.NLIN4
        LDA     #$13
        BNE     NLIN2

.NLIN
        LDA     #$17
.L359D
        INC     YC
.NLIN2
        STA     Y1
        LDA     #$0F
        STA     COL
        LDX     #$02
        STX     XX15
        LDX     #$FE
        STX     X2
        JSR     HLOIN3

        LDA     #$FF
        STA     COL
        RTS

.HLOIN2
        JSR     EDGES

        STY     Y1
        LDA     #$00
        STA     LSO,Y
        JMP     HLOIN

.BLINE
        TXA
        ADC     K4
        STA     XX18+6
        LDA     K4+1
        ADC     T
        STA     XX18+7
        LDA     FLAG
        BEQ     BL1

        INC     FLAG
.BL5
        LDY     LSP
        LDA     #$FF
        CMP     LSY2-1,Y
        BEQ     BL7

        STA     LSY2,Y
        INC     LSP
        BNE     BL7

.BL1
        LDA     XX18
        STA     XX15
        LDA     XX18+1
        STA     Y1
        LDA     XX18+2
        STA     X2
        LDA     XX18+3
        STA     Y2
        LDA     XX18+4
        STA     XX15+4
        LDA     XX18+5
        STA     XX15+5
        LDA     XX18+6
        STA     XX12
        LDA     XX18+7
        STA     XX12+1
        JSR     LL145

        BCS     BL5

        LDA     SWAP
        BEQ     BL9

        LDA     XX15
        LDY     X2
        STA     X2
        STY     XX15
        LDA     Y1
        LDY     Y2
        STA     Y2
        STY     Y1
.BL9
        LDY     LSP
        LDA     LSY2-1,Y
        CMP     #$FF
        BNE     BL8

        LDA     XX15
        STA     LSX2,Y
        LDA     Y1
        STA     LSY2,Y
        INY
.BL8
        LDA     X2
        STA     LSX2,Y
        LDA     Y2
        STA     LSY2,Y
        INY
        STY     LSP
        JSR     LL30

        LDA     XX13
        BNE     BL5

.BL7
        LDA     XX18+4
        STA     XX18
        LDA     XX18+5
        STA     XX18+1
        LDA     XX18+6
        STA     XX18+2
        LDA     XX18+7
        STA     XX18+3
        LDA     CNT
        CLC
        ADC     STP
        STA     CNT
        RTS

.FLIP
        LDA     #$FA
        STA     COL
        LDY     NOSTM
.FLL1
        LDX     SY,Y
        LDA     SX,Y
        STA     Y1
        STA     SY,Y
        TXA
        STA     XX15
        STA     SX,Y
        LDA     SZ,Y
        STA     ZZ
        JSR     PIXEL2

        DEY
        BNE     FLL1

        RTS

.STARS
        LDA     #$FA
        STA     COL
        LDX     VIEW
        BEQ     STARS1

        DEX
        BNE     ST11

        JMP     STARS6

.ST11
        JMP     STARS2

.STARS1
        LDY     NOSTM
.STL1
        JSR     DV42

        LDA     R
        LSR     P
        ROR     A
        LSR     P
        ROR     A
        ORA     #$01
        STA     Q
        LDA     SZL,Y
        SBC     DELT4
        STA     SZL,Y
        LDA     SZ,Y
        STA     ZZ
        SBC     DELT4+1
        STA     SZ,Y
        JSR     MLU1

        STA     YY+1
        LDA     P
        ADC     SYL,Y
        STA     YY
        STA     R
        LDA     Y1
        ADC     YY+1
        STA     YY+1
        STA     S
        LDA     SX,Y
        STA     XX15
        JSR     MLU2

        STA     XX+1
        LDA     P
        ADC     SXL,Y
        STA     XX
        LDA     XX15
        ADC     XX+1
        STA     XX+1
        EOR     ALP2+1
        JSR     MLS1

        JSR     ADD

        STA     YY+1
        STX     YY
        EOR     ALP2
        JSR     MLS2

        JSR     ADD

        STA     XX+1
        STX     XX
        LDX     BET1
        LDA     YY+1
        EOR     BET2+1
        JSR     L44EA

        STA     Q
        JSR     MUT2

        ASL     P
        ROL     A
        STA     T
        LDA     #$00
        ROR     A
        ORA     T
        JSR     ADD

        STA     XX+1
        TXA
        STA     SXL,Y
        LDA     YY
        STA     R
        LDA     YY+1
        STA     S
        LDA     #$00
        STA     P
        LDA     BETA
        EOR     #$80
        JSR     PIX1

        LDA     XX+1
        STA     XX15
        STA     SX,Y
        AND     #$7F
        CMP     #$78
        BCS     KILL1

        LDA     YY+1
        STA     SY,Y
        STA     Y1
        AND     #$7F
        CMP     #$78
        BCS     KILL1

        LDA     SZ,Y
        CMP     #$10
        BCC     KILL1

        STA     ZZ
.STC1
        JSR     PIXEL2

        DEY
        BEQ     L375A

        JMP     STL1

.L375A
        RTS

.KILL1
        JSR     DORND

        ORA     #$04
        STA     Y1
        STA     SY,Y
        JSR     DORND

        ORA     #$08
        STA     XX15
        STA     SX,Y
        JSR     DORND

        ORA     #$90
        STA     SZ,Y
        STA     ZZ
        LDA     Y1
        JMP     STC1

.STARS6
        LDY     NOSTM
.STL6
        JSR     DV42

        LDA     R
        LSR     P
        ROR     A
        LSR     P
        ROR     A
        ORA     #$01
        STA     Q
        LDA     SX,Y
        STA     XX15
        JSR     MLU2

        STA     XX+1
        LDA     SXL,Y
        SBC     P
        STA     XX
        LDA     XX15
        SBC     XX+1
        STA     XX+1
        JSR     MLU1

        STA     YY+1
        LDA     SYL,Y
        SBC     P
        STA     YY
        STA     R
        LDA     Y1
        SBC     YY+1
        STA     YY+1
        STA     S
        LDA     SZL,Y
        ADC     DELT4
        STA     SZL,Y
        LDA     SZ,Y
        STA     ZZ
        ADC     DELT4+1
        STA     SZ,Y
        LDA     XX+1
        EOR     ALP2
        JSR     MLS1

        JSR     ADD

        STA     YY+1
        STX     YY
        EOR     ALP2+1
        JSR     MLS2

        JSR     ADD

        STA     XX+1
        STX     XX
        LDA     YY+1
        EOR     BET2+1
        LDX     BET1
        JSR     L44EA

        STA     Q
        LDA     XX+1
        STA     S
        EOR     #$80
        JSR     MUT1

        ASL     P
        ROL     A
        STA     T
        LDA     #$00
        ROR     A
        ORA     T
        JSR     ADD

        STA     XX+1
        TXA
        STA     SXL,Y
        LDA     YY
        STA     R
        LDA     YY+1
        STA     S
        LDA     #$00
        STA     P
        LDA     BETA
        JSR     PIX1

        LDA     XX+1
        STA     XX15
        STA     SX,Y
        LDA     YY+1
        STA     SY,Y
        STA     Y1
        AND     #$7F
        CMP     #$6E
        BCS     KILL6

        LDA     SZ,Y
        CMP     #$A0
        BCS     KILL6

        STA     ZZ
.STC6
        JSR     PIXEL2

        DEY
        BEQ     ST3_UC

        JMP     STL6

.ST3_UC
        RTS

.KILL6
        JSR     DORND

        AND     #$7F
        ADC     #$0A
        STA     SZ,Y
        STA     ZZ
        LSR     A
        BCS     ST4_UC

        LSR     A
        LDA     #$FC
        ROR     A
        STA     XX15
        STA     SX,Y
        JSR     DORND

        STA     Y1
        STA     SY,Y
        JMP     STC6

.ST4_UC
        JSR     DORND

        STA     XX15
        STA     SX,Y
        LSR     A
        LDA     #$E6
        ROR     A
        STA     Y1
        STA     SY,Y
        BNE     STC6

.MAS1
        LDA     INWK,Y
        ASL     A
        STA     K+1
        LDA     INWK+1,Y
        ROL     A
        STA     K+2
        LDA     #$00
        ROR     A
        STA     K+3
        JSR     MVT3

        STA     INWK+2,X
        LDY     K+1
        STY     INWK,X
        LDY     K+2
        STY     INWK+1,X
        AND     #$7F
        RTS

.m
        LDA     #$00
.MAS2
        ORA     L0402,Y
        ORA     L0405,Y
        ORA     L0408,Y
        AND     #$7F
        RTS

.MAS3
        LDA     L0401,Y
        JSR     SQUA2

        STA     R
        LDA     L0404,Y
        JSR     SQUA2

        ADC     R
        BCS     MA30

        STA     R
        LDA     L0407,Y
        JSR     SQUA2

        ADC     R
        BCC     L38CC

.MA30
        LDA     #$FF
.L38CC
        RTS

.wearedocked
        LDA     #$CD
        JSR     DETOK

        JSR     TT67_COPY

        JMP     L3915

.st4
        LDX     #$09
        CMP     #$19
        BCS     st3

        DEX
        CMP     #$0A
        BCS     st3

        DEX
        CMP     #$02
        BCS     st3

        DEX
        BNE     st3

.STATUS
        LDA     #$08
        JSR     TRADEMODE

        JSR     TT111

        LDA     #$07
        STA     XC
        LDA     #$7E
        JSR     NLIN3

        LDA     #$0F
        LDY     QQ12
        BNE     wearedocked

        LDA     #$E6
        LDY     JUNK
        LDX     FRIN+2,Y
        BEQ     st6

        LDY     ENERGY
        CPY     #$80
        ADC     #$01
.st6
        JSR     plf

.L3915
        LDA     #$7D
        JSR     spc

        LDA     #$13
        LDY     FIST
        BEQ     st5

        CPY     #$32
        ADC     #$01
.st5
        JSR     plf

        LDA     #$10
        JSR     spc

        LDA     TALLY+1
        BNE     st4

        TAX
        LDA     TALLY
        LSR     A
        LSR     A
.L3938
        INX
        LSR     A
        BNE     L3938

.st3
        TXA
        CLC
        ADC     #$15
        JSR     plf

        LDA     #$12
        JSR     plf2

        LDA     ESCP
        BEQ     L3952

        LDA     #$70
        JSR     plf2

.L3952
        LDA     BST
        BEQ     L395C

        LDA     #$6F
        JSR     plf2

.L395C
        LDA     ECM
        BEQ     L3966

        LDA     #$6C
        JSR     plf2

.L3966
        LDA     #$71
        STA     XX4
.stqv
        TAY
        LDX     L11ED,Y
        BEQ     L3973

        JSR     plf2

.L3973
        INC     XX4
        LDA     XX4
        CMP     #$75
        BCC     stqv

        LDX     #$00
.st
        STX     CNT
        LDY     LASER,X
        BEQ     st1

        TXA
        CLC
        ADC     #$60
        JSR     spc

        LDA     #$67
        LDX     CNT
        LDY     LASER,X
        CPY     #$8F
        BNE     L3998

        LDA     #$68
.L3998
        CPY     #$97
        BNE     L399E

        LDA     #$75
.L399E
        CPY     #$32
        BNE     L39A4

        LDA     #$76
.L39A4
        JSR     plf2

.st1
        LDX     CNT
        INX
        CPX     #$04
        BCC     st

        RTS

.plf2
        JSR     plf

        LDA     #$06
        STA     XC
        RTS

.MVT3
        LDA     K+3
        STA     S
        AND     #$80
        STA     T
        EOR     INWK+2,X
        BMI     MV13

        LDA     K+1
        CLC
        ADC     INWK,X
        STA     K+1
        LDA     K+2
        ADC     INWK+1,X
        STA     K+2
        LDA     K+3
        ADC     INWK+2,X
        AND     #$7F
        ORA     T
        STA     K+3
        RTS

.MV13
        LDA     S
        AND     #$7F
        STA     S
        LDA     INWK,X
        SEC
        SBC     K+1
        STA     K+1
        LDA     INWK+1,X
        SBC     K+2
        STA     K+2
        LDA     INWK+2,X
        AND     #$7F
        SBC     S
        ORA     #$80
        EOR     T
        STA     K+3
        BCS     MV14

        LDA     #$01
        SBC     K+1
        STA     K+1
        LDA     #$00
        SBC     K+2
        STA     K+2
        LDA     #$00
        SBC     K+3
        AND     #$7F
        ORA     T
        STA     K+3
.MV14
        RTS

.MVS5
        LDA     INWK+1,X
        AND     #$7F
        LSR     A
        STA     T
        LDA     INWK,X
        SEC
        SBC     T
        STA     R
        LDA     INWK+1,X
        SBC     #$00
        STA     S
        LDA     INWK,Y
        STA     P
        LDA     INWK+1,Y
        AND     #$80
        STA     T
        LDA     INWK+1,Y
        AND     #$7F
        LSR     A
        ROR     P
        LSR     A
        ROR     P
        LSR     A
        ROR     P
        LSR     A
        ROR     P
        ORA     T
        EOR     RAT2
        STX     Q
        JSR     ADD

        STA     K+1
        STX     K
        LDX     Q
        LDA     INWK+1,Y
        AND     #$7F
        LSR     A
        STA     T
        LDA     INWK,Y
        SEC
        SBC     T
        STA     R
        LDA     INWK+1,Y
        SBC     #$00
        STA     S
        LDA     INWK,X
        STA     P
        LDA     INWK+1,X
        AND     #$80
        STA     T
        LDA     INWK+1,X
        AND     #$7F
        LSR     A
        ROR     P
        LSR     A
        ROR     P
        LSR     A
        ROR     P
        LSR     A
        ROR     P
        ORA     T
        EOR     #$80
        EOR     RAT2
        STX     Q
        JSR     ADD

        STA     INWK+1,Y
        STX     INWK,Y
        LDX     Q
        LDA     K
        STA     INWK,X
        LDA     K+1
        STA     INWK+1,X
        RTS

.L3A9F
        EQUB    $48,$76,$E8,$00

.pr2
        LDA     #$03
.L3AA5
        LDY     #$00
.TT11
        STA     U
        LDA     #$00
        STA     K
        STA     K+1
        STY     K+2
        STX     K+3
.BPRNT
        LDX     #$0B
        STX     T
        PHP
        BCC     TT30

        DEC     T
        DEC     U
.TT30
        LDA     #$0B
        SEC
        STA     XX17
        SBC     U
        STA     U
        INC     U
        LDY     #$00
        STY     S
        JMP     TT36

.TT35
        ASL     K+3
        ROL     K+2
        ROL     K+1
        ROL     K
        ROL     S
        LDX     #$03
.tt35_lc
        LDA     K,X
        STA     XX15,X
        DEX
        BPL     tt35_lc

        LDA     S
        STA     XX15+4
        ASL     K+3
        ROL     K+2
        ROL     K+1
        ROL     K
        ROL     S
        ASL     K+3
        ROL     K+2
        ROL     K+1
        ROL     K
        ROL     S
        CLC
        LDX     #$03
.tt36_lc
        LDA     K,X
        ADC     XX15,X
        STA     K,X
        DEX
        BPL     tt36_lc

        LDA     XX15+4
        ADC     S
        STA     S
        LDY     #$00
.TT36
        LDX     #$03
        SEC
.tt37_lc
        LDA     K,X
        SBC     L3A9F,X
        STA     XX15,X
        DEX
        BPL     tt37_lc

        LDA     S
        SBC     #$17
        STA     XX15+4
        BCC     TT37

        LDX     #$03
.tt38_lc
        LDA     XX15,X
        STA     K,X
        DEX
        BPL     tt38_lc

        LDA     XX15+4
        STA     S
        INY
        JMP     TT36

.TT37
        TYA
        BNE     TT32

        LDA     T
        BEQ     TT32

        DEC     U
        BPL     TT34

        LDA     #$20
        BNE     tt34_lc

.TT32
        LDY     #$00
        STY     T
        CLC
        ADC     #$30
.tt34_lc
        JSR     DASC

.TT34
        DEC     T
        BPL     L3B54

        INC     T
.L3B54
        DEC     XX17
        BMI     rT10

        BNE     L3B62

        PLP
        BCC     L3B62

        LDA     #$2E
        JSR     DASC

.L3B62
        JMP     TT35

.rT10
        RTS

.L3B66
        EQUB    $20

.DTW2
        EQUB    $FF

.DTW3
        EQUB    $00

.DTW4
        EQUB    $00

.DTW5
        EQUB    $00

.DTW6
        EQUB    $00

.DTW8
        EQUB    $FF

.FEED
        LDA     #$0C
        EQUB    $2C

.MT16
        LDA     #$41
DTW7 = MT16+1
.DASC
        STX     SC
        LDX     #$FF
        STX     DTW8
        CMP     #$2E
        BEQ     DA8

        CMP     #$3A
        BEQ     DA8

        CMP     #$0A
        BEQ     DA8

        CMP     #$0C
        BEQ     DA8

        CMP     #$20
        BEQ     DA8

        INX
.DA8
        STX     DTW2
        LDX     SC
        BIT     DTW4
        BMI     L3B9B

        JMP     TT26

.L3B9B
        BIT     DTW4
        BVS     L3BA4

        CMP     #$0C
        BEQ     DA1

.L3BA4
        LDX     DTW5
        STA     BUF,X
        LDX     SC
        INC     DTW5
        CLC
        RTS

.DA1
        TXA
        PHA
        TYA
        PHA
.DA5
        LDX     DTW5
        BEQ     L3C32

        CPX     #$1F
        BCC     DA6

        LSR     SC+1
.DA11
        LDA     SC+1
        BMI     L3BC8

        LDA     #$40
        STA     SC+1
.L3BC8
        LDY     #$1D
.DAL1
        LDA     BUF+LL
        CMP     #$20
        BEQ     DA2

.DAL2
        DEY
        BMI     DA11

        BEQ     DA11

        LDA     BUF,Y
        CMP     #$20
        BNE     DAL2

        ASL     SC+1
        BMI     DAL2

        STY     SC
        LDY     DTW5
.DAL6
        LDA     BUF,Y
        STA     BUF+1,Y
        DEY
        CPY     SC
        BCS     DAL6

        INC     DTW5
.DAL3
        CMP     BUF,Y
        BNE     DAL1

        DEY
        BPL     DAL3

        BMI     DA11

.DA2
        LDX     #$1E
        JSR     DAS1

        LDA     #$0C
        JSR     TT26

        LDA     DTW5
        SBC     #$1E
        STA     DTW5
        TAX
        BEQ     L3C32

        LDY     #$00
        INX
.DAL4
        LDA     BUF+LL+1,Y
        STA     BUF,Y
        INY
        DEX
        BNE     DAL4

        BEQ     DA5

.DAS1
        LDY     #$00
.DAL5
        LDA     BUF,Y
        JSR     TT26

        INY
        DEX
        BNE     DAL5

        RTS

.DA6
        JSR     DAS1

.L3C32
        STX     DTW5
        PLA
        TAY
        PLA
        TAX
        LDA     #$0C
.L3C3B
        EQUB    $2C

.BELL
        LDA     #$07
        JMP     TT26

.ESCAPE
        JSR     RES2

        LDX     #$0B
        STX     TYPE
        JSR     FRS1

        BCS     ES1

        LDX     #$18
        JSR     FRS1

.ES1
        LDA     #$08
        STA     INWK+27
        LDA     #$C2
        STA     INWK+30
        LSR     A
        STA     INWK+32
.ESL1
        JSR     MVEIT

        LDA     QQ11
        ORA     VIEW
        BNE     L3C6A

        JSR     LL9

.L3C6A
        DEC     INWK+32
        BNE     ESL1

        JSR     SCAN

        LDA     #$00
        LDX     #$10
.ESL2
        STA     QQ20,X
        DEX
        BPL     ESL2

        STA     FIST
        STA     ESCP
        LDA     #$46
        STA     QQ14
        JMP     GOIN

.HME2
        LDA     #$FF
        STA     COL
        LDA     #$0E
        JSR     DETOK

        JSR     TT103

        JSR     TT81

        LDA     #$00
        STA     XX20
.HME3
        JSR     MT14

        JSR     cpl

        LDX     DTW5
        LDA     INWK+5,X
        CMP     #$0D
        BNE     HME6

.HME4
        DEX
        LDA     INWK+5,X
        ORA     #$20
        CMP     BUF,X
        BEQ     HME4

        TXA
        BMI     HME5

.HME6
        JSR     TT20

        INC     XX20
        BNE     HME3

        JSR     TT111

        JSR     TT103

        JSR     BEEP_LONG_LOW

        LDA     #$D7
        JMP     DETOK

.HME5
        LDA     QQ15+3
        STA     QQ9
        LDA     QQ15+1
        STA     QQ10
        JSR     TT111

        JSR     TT103

        JSR     MT15

        JMP     T95_UC

.L3CE1
        EQUB    $0B

        EQUB    $44,$3B,$00,$82,$B0,$00,$00,$00
        EQUB    $05,$50,$11,$05,$D1,$28,$05,$40
        EQUB    $06,$10,$60,$90,$13,$10,$D1,$00
        EQUB    $00,$00,$14,$51,$F8,$10,$60,$75
        EQUB    $00,$00,$00

.HALL
        LDA     #$00
        JSR     DOVDU19

        LDA     #$00
        JSR     TT66

        JSR     DORND

        BPL     HA7

        AND     #$03
        STA     T
        ASL     A
        ASL     A
        ASL     A
        ADC     T
        TAX
        LDY     #$03
        STY     CNT2
.HAL8
        LDY     #$02
.HAL9
        LDA     L3CE1,X
        STA     XX15,Y
        INX
        DEY
        BPL     HAL9

        TXA
        PHA
        JSR     HAS1

        PLA
        TAX
        DEC     CNT2
        BNE     HAL8

        LDY     #$80
        BNE     HA9

.HA7
        LSR     A
        STA     Y1
        JSR     DORND

        STA     XX15
        JSR     DORND

        AND     #$03
        ADC     #$11
        STA     X2
        JSR     HAS1

        LDY     #$00
.HA9
        STY     L1F85
        JMP     HANGER

.HAS1
        JSR     ZINF

        LDA     XX15
        STA     INWK+6
        LSR     A
        ROR     INWK+2
        LDA     Y1
        STA     INWK
        LSR     A
        LDA     #$01
        ADC     #$00
        STA     INWK+7
        LDA     #$80
        STA     INWK+5
        STA     RAT2
        LDA     #$0B
        STA     INWK+34
        JSR     DORND

        STA     XSAV
.HAL5
        LDX     #$15
        LDY     #$09
        JSR     MVS5

        LDX     #$17
        LDY     #$0B
        JSR     MVS5

        LDX     #$19
        LDY     #$0D
        JSR     MVS5

        DEC     XSAV
        BNE     HAL5

        LDY     X2
        BEQ     HA1

        TYA
        ASL     A
        TAX
        LDA     L7FFE,X
        STA     XX0
        LDA     L7FFF,X
        STA     XX0+1
        BEQ     HA1

        LDY     #$01
        LDA     (XX0),Y
        STA     Q
        INY
        LDA     (XX0),Y
        STA     R
        JSR     LL5

        LDA     #$64
        SBC     Q
        LSR     A
        STA     INWK+3
        JSR     TIDY

        JMP     LL9

.HA1
        RTS

.TA35_COPY
        LDA     INWK
        ORA     INWK+3
        ORA     INWK+6
        BNE     TA87_COPY

        LDA     #$50
        JSR     OOPS

.TA87_COPY
        LDX     #$04
        BNE     L3E37

.TA34
        LDA     #$00
        JSR     MAS4

        BEQ     L3DE0

        JMP     TN4

.L3DE0
        JSR     L3E3A

        JSR     EXNO3

        LDA     #$FA
        JMP     OOPS

.TA18
        LDA     ECMA
        BNE     TA35_COPY

        LDA     INWK+32
        ASL     A
        BMI     TA34

        LSR     A
        TAX
        LDA     UNIV,X
        STA     V
        LDA     L357A,X
        JSR     VCSUB

        LDA     K3+2
        ORA     K3+5
        ORA     K3+8
        AND     #$7F
        ORA     K3+1
        ORA     K3+4
        ORA     K3+7
        BNE     TA64

        LDA     INWK+32
        CMP     #$82
        BEQ     TA35_COPY

        LDY     #$1F
        LDA     (V),Y
        BIT     L3E48
        BNE     TA35

        ORA     #$80
        STA     (V),Y
.TA35
        LDA     INWK
        ORA     INWK+3
        ORA     INWK+6
        BNE     TA87

        LDA     #$50
        JSR     OOPS

.TA87
        LDA     INWK+32
        AND     #$7F
        LSR     A
        TAX
.L3E37
        JSR     EXNO2

.L3E3A
        ASL     INWK+31
        SEC
        ROR     INWK+31
.TA1
        RTS

.TA64
        JSR     DORND

        CMP     #$10
        BCS     TA19S

.M32
        LDY     #$20
L3E48 = M32+1
        LDA     (V),Y
        LSR     A
        BCS     L3E51

.TA19S
        JMP     TA19

.L3E51
        JMP     ECBLB2

.TACTICS
        LDA     #$03
        STA     RAT
        LDA     #$04
        STA     RAT2
        LDA     #$16
        STA     CNT2
        CPX     #$01
        BEQ     TA18

        CPX     #$02
        BNE     TA13

        LDA     NEWB
        AND     #$04
        BNE     TN5

        LDA     L0E58
        BNE     TA1

        JSR     DORND

        CMP     #$FD
        BCC     TA1

        AND     #$01
        ADC     #$08
        TAX
        BNE     TN6

.TN5
        JSR     DORND

        CMP     #$F0
        BCC     TA1

        LDA     L0E5E
        CMP     #$06
        BCS     TA22

        LDX     #$10
.TN6
        LDA     #$F1
        JMP     SFS1

.TA13
        CPX     #$0F
        BNE     TA17

        JSR     DORND

        CMP     #$C8
        BCC     TA22

        LDX     #$00
        STX     INWK+32
        LDX     #$24
        STX     NEWB
        AND     #$03
        ADC     #$11
        TAX
        JSR     TN6

        LDA     #$00
        STA     INWK+32
        RTS

.TA17
        LDY     #$0E
        LDA     INWK+35
        CMP     (XX0),Y
        BCS     TA21

        INC     INWK+35
.TA21
        CPX     #$1E
        BNE     TA14

        LDA     L0E6B
        BNE     TA14

        LSR     INWK+32
        ASL     INWK+32
        LSR     INWK+27
.TA22
        RTS

.TA14
        JSR     DORND

        LDA     NEWB
        LSR     A
        BCC     TN1

        CPX     #$32
        BCS     TA22

.TN1
        LSR     A
        BCC     TN2

        LDX     FIST
        CPX     #$28
        BCC     TN2

        LDA     NEWB
        ORA     #$04
        STA     NEWB
        LSR     A
        LSR     A
.TN2
        LSR     A
        BCS     TN3

        LSR     A
        LSR     A
        BCC     GOPL

        JMP     DOCKIT

.GOPL
        JSR     SPS1

        JMP     TA151

.TN3
        LSR     A
        BCC     TN4

        LDA     SSPR
        BEQ     TN4

        LDA     INWK+32
        AND     #$81
        STA     INWK+32
.TN4
        LDX     #$08
.TAL1
        LDA     INWK,X
        STA     K3,X
        DEX
        BPL     TAL1

.TA19
        JSR     TAS2

        LDY     #$0A
        JSR     TAS3

        STA     CNT
        LDA     TYPE
        CMP     #$01
        BNE     L3F28

        JMP     TA20

.L3F28
        CMP     #$0E
        BNE     TN7

        JSR     DORND

        CMP     #$C8
        BCC     TN7

        JSR     DORND

        LDX     #$17
        CMP     #$64
        BCS     L3F3E

        LDX     #$11
.L3F3E
        JMP     TN6

.TN7
        JSR     DORND

        CMP     #$FA
        BCC     TA7

        JSR     DORND

        ORA     #$68
        STA     INWK+29
.TA7
        LDY     #$0E
        LDA     (XX0),Y
        LSR     A
        CMP     INWK+35
        BCC     TA3

        LSR     A
        LSR     A
        CMP     INWK+35
        BCC     ta3_lc

        JSR     DORND

        CMP     #$E6
        BCC     ta3_lc

        LDX     TYPE
        LDA     L8041,X
        BPL     ta3_lc

        LDA     NEWB
        AND     #$F0
        STA     NEWB
        LDY     #$24
        STA     (INF),Y
        LDA     #$00
        STA     INWK+32
        JMP     SESCP

.ta3_lc
        LDA     INWK+31
        AND     #$07
        BEQ     TA3

        STA     T
        JSR     DORND

        AND     #$1F
        CMP     T
        BCS     TA3

        LDA     ECMA
        BNE     TA3

        DEC     INWK+31
        LDA     TYPE
        CMP     #$1D
        BNE     TA16

        LDX     #$1E
        LDA     INWK+32
        JMP     SFS1

.TA16
        JMP     SFRMIS

.TA3
        LDA     #$00
        JSR     MAS4

        AND     #$E0
        BNE     TA4

        LDX     CNT
        CPX     #$A0
        BCC     TA4

        LDY     #$13
        LDA     (XX0),Y
        AND     #$F8
        BEQ     TA4

        LDA     INWK+31
        ORA     #$40
        STA     INWK+31
        CPX     #$A3
        BCC     TA4

        LDA     (XX0),Y
        LSR     A
        JSR     OOPS

        DEC     INWK+28
        LDA     ECMA
        BNE     L4039

        JSR     BEING_HIT_NOISE

.TA4
        LDA     INWK+7
        CMP     #$03
        BCS     TA5

        LDA     INWK+1
        ORA     INWK+4
        AND     #$FE
        BEQ     TA15

.TA5
        JSR     DORND

        ORA     #$80
        CMP     INWK+32
        BCS     TA15

.TA20
        JSR     TAS6

        LDA     CNT
        EOR     #$80
.TA152
        STA     CNT
.TA15
        LDY     #$10
        JSR     TAS3

        TAX
        EOR     #$80
        AND     #$80
        STA     INWK+30
.L4000
        TXA
        ASL     A
        CMP     RAT2
        BCC     TA11

        LDA     RAT
        ORA     INWK+30
        STA     INWK+30
.TA11
        LDA     INWK+29
        ASL     A
        CMP     #$20
        BCS     TA12

        LDY     #$16
        JSR     TAS3

        TAX
        EOR     INWK+30
        AND     #$80
        EOR     #$80
        STA     INWK+29
        TXA
        ASL     A
        CMP     RAT2
        BCC     TA12

        LDA     RAT
        ORA     INWK+29
        STA     INWK+29
.TA12
        LDA     CNT
        BMI     TA9

        CMP     CNT2
        BCC     TA9

        LDA     #$03
        STA     INWK+28
.L4039
        RTS

.TA9
        AND     #$7F
        CMP     #$12
        BCC     TA10

        LDA     #$FF
        LDX     TYPE
        CPX     #$01
        BNE     L4049

        ASL     A
.L4049
        STA     INWK+28
.TA10
        RTS

.TA151
        LDY     #$0A
        JSR     TAS3

        CMP     #$98
        BCC     ttt

        LDX     #$00
        STX     RAT2
.ttt
        JMP     TA152

.DOCKIT
        LDA     #$06
        STA     RAT2
        LSR     A
        STA     RAT
        LDA     #$1D
        STA     CNT2
        LDA     SSPR
        BNE     L406F

.GOPLS
        JMP     GOPL

.L406F
        JSR     VCSU1

        LDA     K3+2
        ORA     K3+5
        ORA     K3+8
        AND     #$7F
        BNE     GOPLS

        JSR     TA2

        LDA     Q
        STA     K
        JSR     TAS2

        LDY     #$0A
        JSR     TAS4

        BMI     PH1

        CMP     #$23
        BCC     PH1

        LDY     #$0A
        JSR     TAS3

        CMP     #$A2
        BCS     PH3

        LDA     K
        CMP     #$9D
        BCC     PH2

        LDA     TYPE
        BMI     PH3

.PH2
        JSR     TAS6

        JSR     TA151

.PH22
        LDX     #$00
        STX     INWK+28
        INX
        STX     INWK+27
        RTS

.PH1
        JSR     VCSU1

        JSR     DCS1

        JSR     DCS1

        JSR     TAS2

        JSR     TAS6

        JMP     TA151

.TN11
        INC     INWK+28
        LDA     #$7F
        STA     INWK+29
        BNE     TN13

.PH3
        LDX     #$00
        STX     RAT2
        STX     INWK+30
        LDA     TYPE
        BPL     PH32

        EOR     XX15
        EOR     Y1
        ASL     A
        LDA     #$02
        ROR     A
        STA     INWK+29
        LDA     XX15
        ASL     A
        CMP     #$0C
        BCS     PH22

        LDA     Y1
        ASL     A
        LDA     #$02
        ROR     A
        STA     INWK+30
        LDA     Y1
        ASL     A
        CMP     #$0C
        BCS     PH22

.PH32
        STX     INWK+29
        LDA     INWK+22
        STA     XX15
        LDA     INWK+24
        STA     Y1
        LDA     INWK+26
        STA     X2
        LDY     #$10
        JSR     TAS4

        ASL     A
        CMP     #$42
        BCS     TN11

        JSR     PH22

.TN13
        LDA     K3+10
        BNE     TNRTS

        ASL     NEWB
        SEC
        ROR     NEWB
.TNRTS
        RTS

.VCSU1
        LDA     #$25
        STA     V
        LDA     #$04
.VCSUB
        STA     V+1
        LDY     #$02
        JSR     TAS1

        LDY     #$05
        JSR     TAS1

        LDY     #$08
.TAS1
        LDA     (V),Y
        EOR     #$80
        STA     K+3
        DEY
        LDA     (V),Y
        STA     K+2
        DEY
        LDA     (V),Y
        STA     K+1
        STY     U
        LDX     U
        JSR     MVT3

        LDY     U
        STA     K3+2,X
        LDA     K+2
        STA     K3+1,X
        LDA     K+1
        STA     K3,X
        RTS

.TAS4
        LDX     L0425,Y
        STX     Q
        LDA     XX15
        JSR     MULT12

        LDX     L0427,Y
        STX     Q
        LDA     Y1
        JSR     MAD

        STA     S
        STX     R
        LDX     L0429,Y
        STX     Q
        LDA     X2
        JMP     MAD

.TAS6
        LDA     XX15
        EOR     #$80
        STA     XX15
        LDA     Y1
        EOR     #$80
        STA     Y1
        LDA     X2
        EOR     #$80
        STA     X2
        RTS

.DCS1
        JSR     L418B

.L418B
        LDA     L042F
        LDX     #$00
        JSR     TAS7

        LDA     L0431
        LDX     #$03
        JSR     TAS7

        LDA     L0433
        LDX     #$06
.TAS7
        ASL     A
        STA     R
        LDA     #$00
        ROR     A
        EOR     #$80
        EOR     K3+2,X
        BMI     TS71

        LDA     R
        ADC     K3,X
        STA     K3,X
        BCC     TS72

        INC     K3+1,X
.TS72
        RTS

.TS71
        LDA     K3,X
        SEC
        SBC     R
        STA     K3,X
        LDA     K3+1,X
        SBC     #$00
        STA     K3+1,X
        BCS     TS72

        LDA     K3,X
        EOR     #$FF
        ADC     #$01
        STA     K3,X
        LDA     K3+1,X
        EOR     #$FF
        ADC     #$00
        STA     K3+1,X
        LDA     K3+2,X
        EOR     #$80
        STA     K3+2,X
        JMP     TS72

.HITCH
        CLC
        LDA     INWK+8
        BNE     HI1

        LDA     TYPE
        BMI     HI1

        LDA     INWK+31
        AND     #$20
        ORA     INWK+1
        ORA     INWK+4
        BNE     HI1

        LDA     INWK
        JSR     SQUA2

.L41F7
        STA     S
L41F8 = L41F7+1
        LDA     P
        STA     R
        LDA     INWK+3
        JSR     SQUA2

        TAX
        LDA     P
        ADC     R
        STA     R
        TXA
        ADC     S
        BCS     TN10

        STA     S
        LDY     #$02
        LDA     (XX0),Y
        CMP     S
        BNE     HI1

        DEY
        LDA     (XX0),Y
        CMP     R
.HI1
        RTS

.TN10
        CLC
        RTS

.FRS1
        JSR     ZINF

        LDA     #$1C
        STA     INWK+3
        LSR     A
        STA     INWK+6
        LDA     #$80
        STA     INWK+5
        LDA     MSTG
        ASL     A
        ORA     #$80
        STA     INWK+32
.fq1
        LDA     #$60
        STA     INWK+14
        ORA     #$80
        STA     INWK+22
        LDA     DELTA
        ROL     A
        STA     INWK+27
        TXA
        JMP     NWSHP

.FRMIS
        LDX     #$01
        JSR     FRS1

        BCC     FR1

        LDX     MSTG
        JSR     GINF

        LDA     FRIN,X
        JSR     ANGRY

        LDY     #$00
        JSR     ABORT

        DEC     NOMSL
        LDY     #$08
        JSR     NOISE

.ANGRY
        CMP     #$02
        BEQ     AN2

        LDY     #$24
        LDA     (INF),Y
        AND     #$20
        BEQ     L4274

        JSR     AN2

.L4274
        LDY     #$20
        LDA     (INF),Y
        BEQ     HI1

        ORA     #$80
        STA     (INF),Y
        LDY     #$1C
        LDA     #$02
        STA     (INF),Y
        ASL     A
        LDY     #$1E
        STA     (INF),Y
        LDA     TYPE
        CMP     #$0B
        BCC     AN3

        LDY     #$24
        LDA     (INF),Y
        ORA     #$04
        STA     (INF),Y
.AN3
        RTS

.AN2
        LDA     L0449
        ORA     #$04
        STA     L0449
        RTS

.FR1
        LDA     #$C9
        JMP     MESS

.SESCP
        LDX     #$03
.L42A8
        LDA     #$FE
.SFS1
        STA     T1
        TXA
        PHA
        LDA     XX0
        PHA
        LDA     XX0+1
        PHA
        LDA     INF
        PHA
        LDA     INF+1
        PHA
        LDY     #$24
.FRL2
        LDA     INWK,Y
        STA     XX3,Y
        LDA     (INF),Y
        STA     INWK,Y
        DEY
        BPL     FRL2

        LDA     TYPE
        CMP     #$02
        BNE     rx

        TXA
        PHA
        LDA     #$20
        STA     INWK+27
        LDX     #$00
        LDA     INWK+10
        JSR     SFS2

        LDX     #$03
        LDA     INWK+12
        JSR     SFS2

        LDX     #$06
        LDA     INWK+14
        JSR     SFS2

        PLA
        TAX
.rx
        LDA     T1
        STA     INWK+32
        LSR     INWK+29
        ASL     INWK+29
        TXA
        CMP     #$09
        BCS     NOIL

        CMP     #$04
        BCC     NOIL

        PHA
        JSR     DORND

        ASL     A
        STA     INWK+30
        TXA
        AND     #$0F
        STA     INWK+27
        LDA     #$FF
        ROR     A
        STA     INWK+29
        PLA
.NOIL
        JSR     NWSHP

        PLA
        STA     INF+1
        PLA
        STA     INF
        LDX     #$24
.FRL3
        LDA     XX3,X
        STA     INWK,X
        DEX
        BPL     FRL3

        PLA
        STA     XX0+1
        PLA
        STA     XX0
        PLA
        TAX
        RTS

.SFS2
        ASL     A
        STA     R
        LDA     #$00
        ROR     A
        JMP     MVT1

.LL164
        LDY     #$0A
        JSR     NOISE

        LDY     #$0B
        JSR     NOISE

        LDA     #$04
        STA     HFX
        JSR     HFS2

        STZ     HFX
        RTS

.LAUN
        LDY     #$08
        JSR     NOISE

        LDA     #$08
.HFS2
        STA     STP
        LDA     QQ11
        PHA
        LDA     #$00
        JSR     TT66

        PLA
        STA     QQ11
.HFS1
        LDX     #$80
        STX     K3
        LDX     #$60
        STX     K4
        LDX     #$00
        STX     XX4
        STX     K3+1
        STX     K4+1
.HFL5
        JSR     HFL1

        INC     XX4
        LDX     XX4
        CPX     #$08
        BNE     HFL5

        RTS

.HFL1
        LDA     XX4
        AND     #$07
        CLC
        ADC     #$08
        STA     K
.HFL2
        LDA     #$01
        STA     LSP
        JSR     CIRCLE2

        ASL     K
        BCS     HF8

        LDA     K
        CMP     #$A0
        BCC     HFL2

.HF8
        RTS

.STARS2
        LDA     #$00
        CPX     #$02
        ROR     A
        STA     RAT
        EOR     #$80
        STA     RAT2
        JSR     ST2

        LDY     NOSTM
.STL2
        LDA     SZ,Y
        STA     ZZ
        LSR     A
        LSR     A
        LSR     A
        JSR     DV41

        LDA     P
        STA     L009B
        EOR     RAT2
        STA     S
        LDA     SXL,Y
        STA     P
        LDA     SX,Y
        STA     XX15
        JSR     ADD

        STA     S
        STX     R
        LDA     SY,Y
        STA     Y1
        EOR     BET2
        LDX     BET1
        JSR     L44EA

        JSR     ADD

        STX     XX
        STA     XX+1
        LDX     SYL,Y
        STX     R
        LDX     Y1
        STX     S
        LDX     BET1
        EOR     BET2+1
        JSR     L44EA

        JSR     ADD

        STX     YY
        STA     YY+1
        LDX     ALP1
        EOR     ALP2
        JSR     L44EA

        STA     Q
        LDA     XX
        STA     R
        LDA     XX+1
        STA     S
        EOR     #$80
        JSR     MAD

        STA     XX+1
        TXA
        STA     SXL,Y
        LDA     YY
        STA     R
        LDA     YY+1
        STA     S
        JSR     MAD

        STA     S
        STX     R
        LDA     #$00
        STA     P
        LDA     ALPHA
        JSR     PIX1

        LDA     XX+1
        STA     SX,Y
        STA     XX15
        AND     #$7F
        EOR     #$7F
        CMP     L009B
        BCC     KILL2

        BEQ     KILL2

        LDA     YY+1
        STA     SY,Y
        STA     Y1
        AND     #$7F
        CMP     #$74
        BCS     ST5_UC

.STC2
        JSR     PIXEL2

        DEY
        BEQ     ST2

        JMP     STL2

.ST2
        LDA     ALPHA
        EOR     RAT
        STA     ALPHA
        LDA     ALP2
        EOR     RAT
        STA     ALP2
        EOR     #$80
        STA     ALP2+1
        LDA     BET2
        EOR     RAT
        STA     BET2
        EOR     #$80
        STA     BET2+1
        RTS

.KILL2
        JSR     DORND

        STA     Y1
        STA     SY,Y
        LDA     #$73
        ORA     RAT
        STA     XX15
        STA     SX,Y
        BNE     STF1

.ST5_UC
        JSR     DORND

        STA     XX15
        STA     SX,Y
        LDA     #$6E
        ORA     ALP2+1
        STA     Y1
        STA     SY,Y
.STF1
        JSR     DORND

        ORA     #$08
        STA     ZZ
        STA     SZ,Y
        BNE     STC2

.MU5
        STA     K
        STA     K+1
        STA     K+2
        STA     K+3
        CLC
        RTS

.MULT3
        STA     R
        AND     #$7F
        STA     K+2
        LDA     Q
        AND     #$7F
        BEQ     MU5

        SEC
        SBC     #$01
        STA     T
        LDA     P+1
        LSR     K+2
        ROR     A
        STA     K+1
        LDA     P
        ROR     A
        STA     K
        LDA     #$00
        LDX     #$18
.MUL2
        BCC     L44C9

        ADC     T
.L44C9
        ROR     A
        ROR     K+2
        ROR     K+1
        ROR     K
        DEX
        BNE     MUL2

        STA     T
        LDA     R
        EOR     Q
        AND     #$80
        ORA     T
        STA     K+3
        RTS

.MLS2
        LDX     XX
        STX     R
        LDX     XX+1
        STX     S
.MLS1
        LDX     ALP1
.L44EA
        STX     P
        TAX
        AND     #$80
        STA     T
        TXA
        AND     #$7F
        BEQ     MU6

        TAX
        DEX
        STX     T1
        LDA     #$00
        LSR     P
        BCC     L4502

        ADC     T1
.L4502
        ROR     A
        ROR     P
        BCC     L4509

        ADC     T1
.L4509
        ROR     A
        ROR     P
        BCC     L4510

        ADC     T1
.L4510
        ROR     A
        ROR     P
        BCC     L4517

        ADC     T1
.L4517
        ROR     A
        ROR     P
        BCC     L451E

        ADC     T1
.L451E
        ROR     A
        ROR     P
        LSR     A
        ROR     P
        LSR     A
        ROR     P
        LSR     A
        ROR     P
        ORA     T
        RTS

.MU6
        STA     P+1
        STA     P
        RTS

.SQUA
        AND     #$7F
.SQUA2
        STA     P
        TAX
        BNE     MU11

.MU1
        CLC
        STX     P
        TXA
        RTS

.MLU1
        LDA     SY,Y
        STA     Y1
.MLU2
        AND     #$7F
        STA     P
.MULTU
        LDX     Q
        BEQ     MU1

.MU11
        DEX
        STX     T
        LDA     #$00
        TAX
        LSR     P
        BCC     L4557

        ADC     T
.L4557
        ROR     A
        ROR     P
        BCC     L455E

        ADC     T
.L455E
        ROR     A
        ROR     P
        BCC     L4565

        ADC     T
.L4565
        ROR     A
        ROR     P
        BCC     L456C

        ADC     T
.L456C
        ROR     A
        ROR     P
        BCC     L4573

        ADC     T
.L4573
        ROR     A
        ROR     P
        BCC     L457A

        ADC     T
.L457A
        ROR     A
        ROR     P
        BCC     L4581

        ADC     T
.L4581
        ROR     A
        ROR     P
        BCC     L4588

        ADC     T
.L4588
        ROR     A
        ROR     P
        RTS

.FMLTU2
        AND     #$1F
        TAX
        LDA     SNE,X
        STA     Q
        LDA     K
.FMLTU
        STX     P
        STA     widget
        TAX
        BEQ     MU3

        LDA     logL,X
        LDX     Q
        BEQ     MU3again

        CLC
        ADC     logL,X
        LDA     log,X
        LDX     widget
        ADC     log,X
        BCC     MU3again

        TAX
        LDA     antilog,X
        LDX     P
        RTS

.MU3again
        LDA     #$00
.MU3
        LDX     P
        RTS

.L45BE
        STX     Q
.MLTU2
        EOR     #$FF
        LSR     A
        STA     P+1
        LDA     #$00
        LDX     #$10
        ROR     P
.MUL7
        BCS     MU21

        ADC     Q
        ROR     A
        ROR     P+1
        ROR     P
        DEX
        BNE     MUL7

        RTS

.MU21
        LSR     A
        ROR     P+1
        ROR     P
        DEX
        BNE     MUL7

        RTS

        LDX     ALP1
        STX     P
.MUT2
        LDX     XX+1
        STX     S
.MUT1
        LDX     XX
        STX     R
.MULT1
        TAX
        AND     #$7F
        LSR     A
        STA     P
        TXA
        EOR     Q
        AND     #$80
        STA     T
        LDA     Q
        AND     #$7F
        BEQ     mu10

        TAX
        DEX
        STX     T1
        LDA     #$00
        TAX
        BCC     L460B

        ADC     T1
.L460B
        ROR     A
        ROR     P
        BCC     L4612

        ADC     T1
.L4612
        ROR     A
        ROR     P
        BCC     L4619

        ADC     T1
.L4619
        ROR     A
        ROR     P
        BCC     L4620

        ADC     T1
.L4620
        ROR     A
        ROR     P
        BCC     L4627

        ADC     T1
.L4627
        ROR     A
        ROR     P
        BCC     L462E

        ADC     T1
.L462E
        ROR     A
        ROR     P
        BCC     L4635

        ADC     T1
.L4635
        ROR     A
        ROR     P
        LSR     A
        ROR     P
        ORA     T
        RTS

.mu10
        STA     P
        RTS

.MULT12
        JSR     MULT1

        STA     S
        LDA     P
        STA     R
        RTS

.TAS3
        LDX     INWK,Y
        STX     Q
        LDA     XX15
        JSR     MULT12

        LDX     INWK+2,Y
        STX     Q
        LDA     Y1
        JSR     MAD

        STA     S
        STX     R
        LDX     INWK+4,Y
        STX     Q
        LDA     X2
.MAD
        JSR     MULT1

.ADD
        STA     T1
        AND     #$80
        STA     T
        EOR     S
        BMI     MU8

        LDA     R
        CLC
        ADC     P
        TAX
        LDA     S
        ADC     T1
        ORA     T
        RTS

.MU8
        LDA     S
        AND     #$7F
        STA     U
        LDA     P
        SEC
        SBC     R
        TAX
        LDA     T1
        AND     #$7F
        SBC     U
        BCS     MU9

        STA     U
        TXA
        EOR     #$FF
        ADC     #$01
        TAX
        LDA     #$00
        SBC     U
        ORA     #$80
.MU9
        EOR     T
        RTS

.TIS1
        STX     Q
        EOR     #$80
        JSR     MAD

        TAX
        AND     #$80
        STA     T
        TXA
        AND     #$7F
        LDX     #$FE
        STX     T1
.DVL3
        ASL     A
        CMP     #$60
        BCC     DV4

        SBC     #$60
.DV4
        ROL     T1
        BCS     DVL3

        LDA     T1
        ORA     T
        RTS

.DV42
        LDA     SZ,Y
.DV41
        STA     Q
        LDA     DELTA
.DVID4
        ASL     A
        STA     P
        LDA     #$00
        ROL     A
        CMP     Q
        BCC     L46DC

        SBC     Q
.L46DC
        ROL     P
        ROL     A
        CMP     Q
        BCC     L46E5

        SBC     Q
.L46E5
        ROL     P
        ROL     A
        CMP     Q
        BCC     L46EE

        SBC     Q
.L46EE
        ROL     P
        ROL     A
        CMP     Q
        BCC     L46F7

        SBC     Q
.L46F7
        ROL     P
        ROL     A
        CMP     Q
        BCC     L4700

        SBC     Q
.L4700
        ROL     P
        ROL     A
        CMP     Q
        BCC     L4709

        SBC     Q
.L4709
        ROL     P
        ROL     A
        CMP     Q
        BCC     L4712

        SBC     Q
.L4712
        ROL     P
        ROL     A
        CMP     Q
        BCC     L471B

        SBC     Q
.L471B
        ROL     P
        LDX     #$00
        STA     widget
        TAX
        BEQ     LLfix_COPY

        LDA     logL,X
        LDX     Q
        SEC
        SBC     logL,X
        LDX     widget
        LDA     log,X
        LDX     Q
        SBC     log,X
        BCS     LL2_COPY

        TAX
        LDA     antilog,X
.LLfix_COPY
        STA     R
        RTS

.LL2_COPY
        LDA     #$FF
        STA     R
        RTS

.DVID3B2
        STA     P+2
        LDA     INWK+6
        ORA     #$01
        STA     Q
        LDA     INWK+7
        STA     R
        LDA     INWK+8
        STA     S
        LDA     P
        ORA     #$01
        STA     P
        LDA     P+2
        EOR     S
        AND     #$80
        STA     T
        LDY     #$00
        LDA     P+2
        AND     #$7F
.DVL9
        CMP     #$40
        BCS     DV14

        ASL     P
        ROL     P+1
        ROL     A
        INY
        BNE     DVL9

.DV14
        STA     P+2
        LDA     S
        AND     #$7F
.DVL6
        DEY
        ASL     Q
        ROL     R
        ROL     A
        BPL     DVL6

        STA     Q
        LDA     #$FE
        STA     R
        LDA     P+2
.LL31_COPY
        ASL     A
        BCS     LL29_COPY

        CMP     Q
        BCC     L4794

        SBC     Q
.L4794
        ROL     R
        BCS     LL31_COPY

        JMP     LL31_COPY_RTS

.LL29_COPY
        SBC     Q
        SEC
        ROL     R
        BCS     LL31_COPY

        LDA     R
.LL31_COPY_RTS
        LDA     #$00
        STA     K+1
        STA     K+2
        STA     K+3
        TYA
        BPL     DV12

        LDA     R
.DVL8
        ASL     A
        ROL     K+1
        ROL     K+2
        ROL     K+3
        INY
        BNE     DVL8

        STA     K
        LDA     K+3
        ORA     T
        STA     K+3
        RTS

.DV13
        LDA     R
        STA     K
        LDA     T
        STA     K+3
        RTS

.DV12
        BEQ     DV13

        LDA     R
.DVL10
        LSR     A
        DEY
        BNE     DVL10

        STA     K
        LDA     T
        STA     K+3
        RTS

.cntr
        LDA     auto
        BNE     cnt2_lc

        LDA     DAMP
        BNE     RE1

.cnt2_lc
        TXA
        BPL     BUMP

        DEX
        BMI     L485E

.BUMP
        INX
        BNE     RE1

        DEX
        BEQ     BUMP

.RE1
        RTS

.BUMP2
        STA     T
        TXA
        CLC
        ADC     T
        TAX
        BCC     RE2

        LDX     #$FF
.RE2
        BPL     djd1

.L4800
        LDA     T
        RTS

.REDU2
        STA     T
        TXA
        SEC
        SBC     T
        TAX
        BCS     RE3

        LDX     #$01
.RE3
        BPL     L4800

.djd1
        LDA     DJD
        BNE     L4800

        LDX     #$80
        BMI     L4800

.ARCTAN
        LDA     P
        EOR     Q
        STA     T1
        LDA     Q
        BEQ     AR2

        ASL     A
        STA     Q
        LDA     P
        ASL     A
        CMP     Q
        BCS     AR1

        JSR     ARS1

        SEC
.AR4
        LDX     T1
        BMI     AR3

        RTS

.AR1
        LDX     Q
        STA     Q
        STX     P
        TXA
        JSR     ARS1

        STA     T
        LDA     #$40
        SBC     T
        BCS     AR4

.AR2
        LDA     #$3F
        RTS

.AR3
        STA     T
        LDA     #$80
        SBC     T
        RTS

.ARS1
        JSR     LL28

        LDA     R
        LSR     A
        LSR     A
        LSR     A
        TAX
        LDA     ACT,X
.L485E
        RTS

.LASLI
        JSR     DORND

        AND     #$07
        ADC     #$5C
        STA     LASY
        JSR     DORND

        AND     #$07
        ADC     #$7C
        STA     LASX
        LDA     GNTMP
        ADC     #$08
        STA     GNTMP
        JSR     DENGY

.LASLI2
        LDA     QQ11
        BNE     L485E

        LDA     #$F0
        STA     COL
        LDA     #$20
        LDY     #$E0
        DEC     LASY
        DEC     LASY
        JSR     las_lc

        INC     LASY
        INC     LASY
        LDA     #$30
        LDY     #$D0
.las_lc
        STA     X2
        LDA     LASX
        STA     XX15
        LDA     LASY
        STA     Y1
        LDA     #$BF
        STA     Y2
        JSR     LL30

        LDA     LASX
        STA     XX15
        LDA     LASY
        STA     Y1
        STY     X2
        LDA     #$BF
        STA     Y2
        JMP     LL30

.PDESC
        LDA     QQ8
        ORA     QQ8+1
        BNE     PD1

        LDA     QQ12
        BPL     PD1

        LDY     #$00
.PDL1
        LDA     LAF47,Y
        CMP     ZZ
        BNE     PD2

        LDA     LAF61,Y
        AND     #$7F
        CMP     GCNT
        BNE     PD2

        LDA     LAF61,Y
        BMI     PD3

        LDA     TP
        LSR     A
        BCC     PD1

        JSR     MT14

        LDA     #$01
        EQUB    $2C

.PD3
        LDA     #$B0
        JSR     DETOK2

        TYA
        JSR     DETOK3

        LDA     #$B1
        BNE     PD4

.PD2
        DEY
        BNE     PDL1

.PD1
        LDX     #$03
.PDL1_BRACES
        LDA     QQ15+2,X
        STA     RAND,X
        DEX
        BPL     PDL1_BRACES

        LDA     #$05
.PD4
        JMP     DETOK

.BRIEF2
        LDA     TP
        ORA     #$04
        STA     TP
        LDA     #$0B
.BRP
        LDX     #$FF
        STX     COL
        JSR     DETOK

        JMP     BAY

.BRIEF3
        LDA     TP
        AND     #$F0
        ORA     #$0A
        STA     TP
        LDA     #$DE
        BNE     BRP

.DEBRIEF2
        LDA     TP
        ORA     #$04
        STA     TP
        LDA     #$02
        STA     ENGY
        INC     TALLY+1
        LDA     #$DF
        BNE     BRP

.DEBRIEF
        LSR     TP
        ASL     TP
        LDX     #$50
        LDY     #$C3
        JSR     MCASH

        LDA     #$0F
.BRPS
        BNE     BRP

.BRIEF
        LSR     TP
        SEC
        ROL     TP
        JSR     BRIS

        JSR     ZINF

        LDA     #$1F
        STA     TYPE
        JSR     NWSHP

        LDA     #$01
        JSR     DOXC

        STA     INWK+7
        LDA     #$0D
        JSR     TT66

        LDA     #$40
        STA     MCNT
.BRL1
        LDX     #$7F
        STX     INWK+29
        STX     INWK+30
        JSR     LL9

        JSR     MVEIT

        DEC     MCNT
        BNE     BRL1

.BRL2
        LSR     INWK
        INC     INWK+6
        BEQ     BR2

        INC     INWK+6
        BEQ     BR2

        LDX     INWK+3
        INX
        CPX     #$78
        BCC     L499D

        LDX     #$78
.L499D
        STX     INWK+3
        JSR     LL9

        JSR     MVEIT

        DEC     MCNT
        JMP     BRL2

.BR2
        INC     INWK+7
        JSR     PAS1

        LDA     #$0A
        BNE     BRPS

.BRIS
        LDA     #$D8
        JSR     DETOK

        LDY     #$64
        JMP     DELAY

.PAUSE
        JSR     PAS1

.L49C0
        BNE     PAUSE

L49C1 = L49C0+1
.PAL1
        JSR     PAS1

        BEQ     PAL1

        LDA     #$00
        STA     INWK+31
        LDA     #$01
        JSR     TT66

        JSR     LL9

        LDA     #$0A
        BIT     L06A9
        STA     YC
        LDA     #$FF
        STA     COL
        JMP     MT13

.PAS1
        LDA     #$78
        STA     INWK+3
        LDA     #$00
        STA     INWK
        STA     INWK+6
        LDA     #$02
        STA     INWK+7
        JSR     LL9

        JSR     MVEIT

        JMP     RDKEY

.PAUSE2
        JSR     RDKEY

        BNE     PAUSE2

        JSR     RDKEY

        BEQ     PAUSE2

        RTS

.GINF
        TXA
        ASL     A
        TAY
        LDA     UNIV,Y
        STA     INF
        LDA     L357A,Y
        STA     INF+1
        RTS

.ping
        LDX     #$01
.pl1
        LDA     QQ0,X
        STA     QQ9,X
        DEX
        BPL     pl1

        RTS

.L4A1C
        EQUB    $10

        EQUB    $15,$1A,$1F,$9B,$A0,$2E,$A5,$24
        EQUB    $29,$3D,$33,$38,$AA,$42,$47,$4C
        EQUB    $51,$56,$8C,$60,$65,$87,$82,$5B
        EQUB    $6A,$B4,$B9,$BE,$E1,$E6,$EB,$F0
        EQUB    $F5,$FA,$73,$78,$7D

.L4A42
        LSR     A
.L4A43
        RTS

.L4A44
        RTS

.L4A45
        STA     XX15
        STA     X2
        LDA     #$18
        STA     Y1
        LDA     #$98
        STA     Y2
        JMP     LL30

.tnpr1
        STA     QQ29
        LDA     #$01
.tnpr
        PHA
        LDX     #$0C
        CPX     QQ29
        BCC     kg

.Tml
        ADC     QQ20,X
        DEX
        BPL     Tml

        ADC     L1265
        CMP     CRGO
        PLA
        RTS

.kg
        LDY     QQ29
        ADC     QQ20,Y
        CMP     #$C8
        PLA
        RTS

.DOXC
        STA     XC
        RTS

.DOYC
        STA     YC
        RTS

        INC     YC
        RTS

.TRADEMODE
        JSR     TT66

        JSR     FLKB

.L4A88
        LDA     #$30
        JSR     DOVDU19

        LDA     #$FF
        STA     COL
        RTS

.TT20
        JSR     L4A95

.L4A95
        JSR     TT54

.TT54
        LDA     QQ15
        CLC
        ADC     QQ15+2
        TAX
        LDA     QQ15+1
        ADC     QQ15+3
        TAY
        LDA     QQ15+2
        STA     QQ15
        LDA     QQ15+3
        STA     QQ15+1
        LDA     QQ15+5
        STA     QQ15+3
        LDA     QQ15+4
        STA     QQ15+2
        CLC
        TXA
        ADC     QQ15+2
        STA     QQ15+4
        TYA
        ADC     QQ15+3
        STA     QQ15+5
        RTS

.TT146
        LDA     QQ8
        ORA     QQ8+1
        BNE     TT63

        INC     YC
        RTS

.TT63
        LDA     #$BF
        JSR     TT68

        LDX     QQ8
        LDY     QQ8+1
        SEC
        JSR     pr5

        LDA     #$C3
.TT60
        JSR     TT27

.TTX69
        INC     YC
.TT69
        LDA     #$80
        STA     QQ17
.TT67
        LDA     #$0C
        JMP     TT27

.TT70
        LDA     #$AD
        JSR     TT27

        JMP     TT72

.spc
        JSR     TT27

        JMP     TT162

.TT25
        LDA     #$01
        JSR     TRADEMODE

        LDA     #$09
        STA     XC
        LDA     #$A3
        JSR     NLIN3

        JSR     TTX69

        JSR     TT146

        LDA     #$C2
        JSR     TT68

        LDA     QQ3
        CLC
        ADC     #$01
        LSR     A
        CMP     #$02
        BEQ     TT70

        LDA     QQ3
        BCC     TT71

        SBC     #$05
        CLC
.TT71
        ADC     #$AA
        JSR     TT27

.TT72
        LDA     QQ3
        LSR     A
        LSR     A
        CLC
        ADC     #$A8
        JSR     TT60

        LDA     #$A2
        JSR     TT68

        LDA     QQ4
        CLC
        ADC     #$B1
        JSR     TT60

        LDA     #$C4
        JSR     TT68

        LDX     QQ5
        INX
        CLC
        JSR     pr2

        JSR     TTX69

        LDA     #$C0
        JSR     TT68

        SEC
        LDX     QQ6
        JSR     pr2

        LDA     #$C6
        JSR     TT60

        LDA     #$28
        JSR     TT27

        LDA     QQ15+4
        BMI     TT75

        LDA     #$BC
        JSR     TT27

        JMP     TT76

.TT75
        LDA     QQ15+5
        LSR     A
        LSR     A
        PHA
        AND     #$07
        CMP     #$03
        BCS     TT205

        ADC     #$E3
        JSR     spc

.TT205
        PLA
        LSR     A
        LSR     A
        LSR     A
        CMP     #$06
        BCS     TT206

        ADC     #$E6
        JSR     spc

.TT206
        LDA     QQ15+3
        EOR     QQ15+1
        AND     #$07
        STA     QQ19
        CMP     #$06
        BCS     TT207

        ADC     #$EC
        JSR     spc

.TT207
        LDA     QQ15+5
        AND     #$03
        CLC
        ADC     QQ19
        AND     #$07
        ADC     #$F2
        JSR     TT27

.TT76
        LDA     #$53
        JSR     TT27

        LDA     #$29
        JSR     TT60

        LDA     #$C1
        JSR     TT68

        LDX     QQ7
        LDY     QQ7+1
        JSR     pr6

        JSR     TT162

        STZ     QQ17
        LDA     #$4D
        JSR     TT27

        LDA     #$E2
        JSR     TT60

        LDA     #$FA
        JSR     TT68

        LDA     QQ15+5
        LDX     QQ15+3
        AND     #$0F
        CLC
        ADC     #$0B
        TAY
        JSR     pr5

        JSR     TT162

        LDA     #$6B
        JSR     DASC

        LDA     #$6D
        JSR     DASC

        JSR     TTX69

        JMP     PDESC

.TT24
        LDA     QQ15+1
        AND     #$07
        STA     QQ3
        LDA     QQ15+2
        LSR     A
        LSR     A
        LSR     A
        AND     #$07
        STA     QQ4
        LSR     A
        BNE     TT77

        LDA     QQ3
        ORA     #$02
        STA     QQ3
.TT77
        LDA     QQ3
        EOR     #$07
        CLC
        STA     QQ5
        LDA     QQ15+3
        AND     #$03
        ADC     QQ5
        STA     QQ5
        LDA     QQ4
        LSR     A
        ADC     QQ5
        STA     QQ5
        ASL     A
        ASL     A
        ADC     QQ3
        ADC     QQ4
        ADC     #$01
        STA     QQ6
        LDA     QQ3
        EOR     #$07
        ADC     #$03
        STA     P
        LDA     QQ4
        ADC     #$04
        STA     Q
        JSR     MULTU

        LDA     QQ6
        STA     Q
        JSR     MULTU

        ASL     P
        ROL     A
        ASL     P
        ROL     A
        ASL     P
        ROL     A
        STA     QQ7+1
        LDA     P
        STA     QQ7
        RTS

.TT22
        LDA     #$40
        JSR     TT66

        LDA     #$10
        JSR     DOVDU19

        LDA     #$FF
        STA     COL
        LDA     #$07
        STA     XC
        JSR     TT81

        LDA     #$C7
        JSR     TT27

        JSR     NLIN

        LDA     #$99
        JSR     L359D

        JSR     TT14

        LDX     #$00
.TT83
        STX     XSAV
        LDX     QQ15+3
        LDY     QQ15+4
        TYA
        ORA     #$50
        STA     ZZ
        LDA     #$0F
        STA     COL
        LDA     QQ15+1
        JSR     L4A42

        CLC
        ADC     #$18
        JSR     PIXEL

        JSR     TT20

        LDX     XSAV
        INX
        BNE     TT83

        LDA     QQ9
        JSR     L4A44

        STA     QQ19
        LDA     QQ10
        JSR     L4A42

        STA     QQ19+1
        LDA     #$04
        STA     QQ19+2
        LDA     #$AF
        STA     COL
.TT15
        LDA     #$18
        LDX     QQ11
        BPL     TT178

        LDA     #$00
.TT178
        STA     QQ19+5
        LDA     QQ19
        SEC
        SBC     QQ19+2
        BIT     QQ11
        BMI     TT84

        BCC     L4CC7

        CMP     #$02
        BCS     TT84

.L4CC7
        LDA     #$02
.TT84
        STA     XX15
        LDA     QQ19
        CLC
        ADC     QQ19+2
        BCS     L4CD6

        CMP     #$FE
        BCC     TT85

.L4CD6
        LDA     #$FE
.TT85
        STA     X2
        LDA     QQ19+1
        CLC
        ADC     QQ19+5
        STA     Y1
        JSR     HLOIN3

        LDA     QQ19+1
        SEC
        SBC     QQ19+2
        BCS     TT86

        LDA     #$00
.TT86
        CLC
        ADC     QQ19+5
        STA     Y1
        LDA     QQ19+1
        CLC
        ADC     QQ19+2
        ADC     QQ19+5
        CMP     #$98
        BCC     TT87

        LDX     QQ11
        BMI     TT87

        LDA     #$98
.TT87
        STA     Y2
        LDA     QQ19
        STA     XX15
        STA     X2
        JMP     LL30

.TT126
        LDA     #$68
        STA     QQ19
        LDA     #$5A
        STA     QQ19+1
        LDA     #$10
        STA     QQ19+2
        LDA     #$AF
        STA     COL
        JSR     TT15

        LDA     QQ14
        JSR     L4A43

        STA     K
        JMP     TT128

.TT14
        LDA     QQ11
        BMI     TT126

        LDA     QQ14
        LSR     A
        JSR     L4A42

        STA     K
        LDA     QQ0
        JSR     L4A44

        STA     QQ19
        LDA     QQ1
        JSR     L4A42

        STA     QQ19+1
        LDA     #$07
        STA     QQ19+2
        LDA     #$FF
        STA     COL
        JSR     TT15

        LDA     QQ19+1
        CLC
        ADC     #$18
        STA     QQ19+1
.TT128
        LDA     QQ19
        STA     K3
        LDA     QQ19+1
        STA     K4
        STZ     K4+1
        STZ     K3+1
        LDX     #$01
        STX     LSP
        INX
        STX     STP
        LDA     #$F0
        STA     COL
        JMP     CIRCLE2

.TT219
        LDA     #$02
        JSR     TRADEMODE

        JSR     TT163

        LDA     #$80
        STA     QQ17
        LDA     #$00
        STA     QQ29
.TT220
        JSR     TT151

        LDA     QQ25
        BNE     TT224

        JMP     TT222

.TQ4
        LDY     #$B0
.Tc
        JSR     TT162

        TYA
        JSR     prq

        JSR     dn2

.TT224
        JSR     CLYNS

        LDA     #$CC
        JSR     TT27

        LDA     QQ29
        CLC
        ADC     #$D0
        JSR     TT27

        LDA     #$2F
        JSR     TT27

        JSR     TT152

        LDA     #$3F
        JSR     TT27

        JSR     TT67

        LDX     #$00
        STX     R
        LDX     #$0C
        STX     T1
        JSR     gnum

        BCS     TQ4

        STA     P
        JSR     tnpr

        LDY     #$CE
        LDA     R
        BEQ     L4DD8

        BCS     Tc

.L4DD8
        LDA     QQ24
        STA     Q
        JSR     GCASH

        JSR     LCASH

        LDY     #$C5
        BCC     Tc

        LDY     QQ29
        LDA     R
        PHA
        CLC
        ADC     QQ20,Y
        STA     QQ20,Y
        LDA     AVL,Y
        SEC
        SBC     R
        STA     AVL,Y
        PLA
        BEQ     TT222

        JSR     dn

.TT222
        LDA     QQ29
        CLC
        ADC     #$05
        JSR     DOYC

        LDA     #$00
        JSR     DOXC

        INC     QQ29
        LDA     QQ29
        CMP     #$11
        BCS     BAY2

        JMP     TT220

.BAY2
        LDA     #$89
        JMP     FRCE

.gnum
        LDA     #$F0
        STA     COL
        LDX     #$00
        STX     R
        LDX     #$0C
        STX     T1
.TT223
        JSR     TT217

        LDX     R
        BNE     NWDAV2

        CMP     #$59
        BEQ     NWDAV1

        CMP     #$4E
        BEQ     NWDAV3

.NWDAV2
        STA     Q
        SEC
        SBC     #$30
        BCC     OUT

        CMP     #$0A
        BCS     BAY2

        STA     S
        LDA     R
        CMP     #$1A
        BCS     OUT_COPY

        ASL     A
        STA     T
        ASL     A
        ASL     A
        ADC     T
        ADC     S
        BCS     OUT_COPY

        STA     R
        CMP     QQ25
        BEQ     TT226

        BCS     OUT_COPY

.TT226
        LDA     Q
        JSR     DASC

        DEC     T1
        BNE     TT223

.OUT
        LDA     #$FF
        STA     COL
        LDA     R
        RTS

.NWDAV1
        JSR     DASC

        LDA     QQ25
        STA     R
        JMP     OUT

.NWDAV3
        JSR     DASC

        STZ     R
        JMP     OUT

.NWDAV4
        JSR     TT67

        LDA     #$B0
        JSR     prq

        JSR     dn2

        LDY     QQ29
        JMP     NWDAVxx

.OUT_COPY
        LDA     Q
        JSR     DASC

        SEC
        JMP     OUT

.TT208
        LDA     #$04
        JSR     TRADEMODE

        LDA     #$0A
        STA     XC
        LDA     #$CD
        JSR     TT27

        LDA     #$CE
        JSR     NLIN3

        JSR     TT67

.TT210
        LDY     #$00
.TT211
        STY     QQ29
.NWDAVxx
        LDX     QQ20,Y
        BEQ     TT212

        TYA
        ASL     A
        ASL     A
        TAY
        LDA     L6E6E,Y
        STA     QQ19+1
        TXA
        PHA
        JSR     TT69

        CLC
        LDA     QQ29
        ADC     #$D0
        JSR     TT27

        LDA     #$0E
        JSR     DOXC

        PLA
        TAX
        STA     QQ25
        CLC
        JSR     pr2

        JSR     TT152

        LDA     QQ11
        CMP     #$04
        BNE     TT212

        LDA     #$CD
        JSR     TT27

        LDA     #$CE
        JSR     DETOK

        JSR     gnum

        BEQ     TT212

        BCS     NWDAV4

        LDA     QQ29
        LDX     #$FF
        STX     QQ17
        JSR     TT151

        LDY     QQ29
        LDA     QQ20,Y
        SEC
        SBC     R
        STA     QQ20,Y
        LDA     R
        STA     P
        LDA     QQ24
        STA     Q
        JSR     GCASH

        JSR     MCASH

        LDA     #$00
        STA     QQ17
.TT212
        LDY     QQ29
        INY
        CPY     #$11
        BCC     TT211

        LDA     QQ11
        CMP     #$04
        BNE     L4F3E

        JSR     dn2

        JMP     BAY2

.L4F3E
        JSR     TT69

        LDA     L1264
        ORA     L1265
        BNE     L4F4A

.L4F49
        RTS

.L4F4A
        CLC
        LDA     #$00
        LDX     L1264
        LDY     L1265
        JSR     TT11

        JSR     DORND

        AND     #$03
        CLC
        ADC     #$6F
        JSR     DETOK

        LDA     #$C6
        JSR     DETOK

        LDA     L1265
        BNE     L4F71

        LDX     L1264
        DEX
        BEQ     L4F49

.L4F71
        LDA     #$73
        JMP     DASC

.TT213
        LDA     #$08
        JSR     TRADEMODE

        LDA     #$0B
        STA     XC
        LDA     #$A4
        JSR     TT60

        JSR     NLIN4

        JSR     fwl

        LDA     CRGO
        CMP     #$1A
        BCC     L4F96

        LDA     #$6B
        JSR     TT27

.L4F96
        JMP     TT210

        JSR     TT27

        LDA     #$CE
        JSR     DETOK

        JSR     TT217

        ORA     #$20
        CMP     #$79
        BEQ     TT218

        LDA     #$6E
        JMP     DASC

.TT218
        JSR     DASC

        SEC
        RTS

.TT16
        TXA
        PHA
        DEY
        TYA
        EOR     #$FF
        PHA
        JSR     WSCAN

        JSR     TT103

        PLA
        STA     QQ19+3
        LDA     QQ10
        JSR     TT123

        LDA     QQ19+4
        STA     QQ10
        STA     QQ19+1
        PLA
        STA     QQ19+3
        LDA     QQ9
        JSR     TT123

        LDA     QQ19+4
        STA     QQ9
        STA     QQ19
.TT103
        LDA     #$AF
        STA     COL
        LDA     QQ11
        BMI     TT105

        LDA     QQ9
        JSR     L4A44

        STA     QQ19
        LDA     QQ10
        JSR     L4A42

        STA     QQ19+1
        LDA     #$04
        STA     QQ19+2
        JMP     TT15

.TT123
        STA     QQ19+4
        CLC
        ADC     QQ19+3
        LDX     QQ19+3
        BMI     TT124

        BCC     TT125

        RTS

.TT124
        BCC     TT180

.TT125
        STA     QQ19+4
.TT180
        RTS

.TT105
        LDA     QQ9
        SEC
        SBC     QQ0
        BCS     L5017

        EOR     #$FF
        ADC     #$01
.L5017
        CMP     #$1D
        BCS     TT180

        LDA     QQ9
        SEC
        SBC     QQ0
        BPL     TT179

        CMP     #$E9
        BCC     TT180

.TT179
        ASL     A
        ASL     A
        CLC
        ADC     #$68
        JSR     L4A43

        STA     QQ19
        LDA     QQ10
        SEC
        SBC     QQ1
        BCS     L503D

        EOR     #$FF
        ADC     #$01
.L503D
        CMP     #$23
        BCS     TT180

        LDA     QQ10
        SEC
        SBC     QQ1
        ASL     A
        CLC
        ADC     #$5A
        JSR     L4A43

        STA     QQ19+1
        LDA     #$08
        STA     QQ19+2
        LDA     #$AF
        STA     COL
        JMP     TT15

.TT23
        LDA     #$80
        JSR     TT66

        LDA     #$10
        JSR     DOVDU19

        LDA     #$FF
        STA     COL
        LDA     #$07
        STA     XC
        LDA     #$BE
        JSR     NLIN3

        JSR     TT14

        JSR     TT103

        JSR     TT81

        LDA     #$FF
        STA     COL
        LDA     #$00
        STA     XX20
        LDX     #$18
.EE3
        STA     INWK,X
        DEX
        BPL     EE3

.TT182
        LDA     QQ15+3
        SEC
        SBC     QQ0
        BCS     TT184

        EOR     #$FF
        ADC     #$01
.TT184
        CMP     #$1D
        BCS     L50FB

        LDA     QQ15+1
        SEC
        SBC     QQ1
        BCS     TT186

        EOR     #$FF
        ADC     #$01
.TT186
        CMP     #$28
        BCS     L50FB

        LDA     QQ15+3
        SEC
        SBC     QQ0
        ASL     A
        ASL     A
        ADC     #$68
        JSR     L4A43

        STA     XX12
        LSR     A
        LSR     A
        LSR     A
        INC     A
        STA     XC
        LDA     QQ15+1
        SEC
        SBC     QQ1
        ASL     A
        ADC     #$5A
        JSR     L4A43

        STA     K4
        LSR     A
        LSR     A
        LSR     A
        TAY
        LDX     INWK,Y
        BEQ     EE4

        INY
        LDX     INWK,Y
        BEQ     EE4

        DEY
        DEY
        LDX     INWK,Y
        BNE     ee1

.EE4
        STY     YC
        CPY     #$03
        BCC     TT187

        CPY     #$15
        BCS     TT187

        TYA
        PHA
        LDA     QQ15+3
        JSR     L5193

        PLA
        TAY
        LDA     QQ8+1
        BNE     TT187

        LDA     QQ8
        CMP     #$46
.L50FB
        BCS     TT187

        LDA     #$FF
        STA     INWK,Y
        LDA     #$80
        STA     QQ17
        JSR     cpl

.ee1
        LDA     #$00
        STA     K3+1
        STA     K4+1
        STA     K+1
        LDA     XX12
        STA     K3
        LDA     QQ15+5
        AND     #$01
        ADC     #$02
        STA     K
        JSR     FLFLLS

        JSR     SUN

        JSR     FLFLLS

        LDA     #$FF
        STA     COL
.TT187
        JSR     TT20

        INC     XX20
        BEQ     L5134

        JMP     TT182

.L5134
        RTS

.TT81
        LDX     #$05
.L5137
        LDA     QQ21,X
        STA     QQ15,X
        DEX
        BPL     L5137

        RTS

.TT111
        JSR     TT81

        LDY     #$7F
        STY     T
        LDA     #$00
        STA     U
.TT130
        LDA     QQ15+3
        SEC
        SBC     QQ9
        BCS     TT132

        EOR     #$FF
        ADC     #$01
.TT132
        LSR     A
        STA     S
        LDA     QQ15+1
        SEC
        SBC     QQ10
        BCS     TT134

        EOR     #$FF
        ADC     #$01
.TT134
        LSR     A
        CLC
        ADC     S
        CMP     T
        BCS     TT135

        STA     T
        LDX     #$05
.TT136
        LDA     QQ15,X
        STA     QQ19,X
        DEX
        BPL     TT136

        LDA     U
        STA     ZZ
.TT135
        JSR     TT20

        INC     U
        BNE     TT130

        LDX     #$05
.TT137
        LDA     QQ19,X
        STA     QQ15,X
        DEX
        BPL     TT137

        LDA     QQ15+1
        STA     QQ10
        LDA     QQ15+3
        STA     QQ9
.L5193
        SEC
        SBC     QQ0
        BCS     TT139

        EOR     #$FF
        ADC     #$01
.TT139
        JSR     SQUA2

        STA     K+1
        LDA     P
        STA     K
        LDA     QQ15+1
        SEC
        SBC     QQ1
        BCS     TT141

        EOR     #$FF
        ADC     #$01
.TT141
        LSR     A
        JSR     SQUA2

        PHA
        LDA     P
        CLC
        ADC     K
        STA     Q
        PLA
        ADC     K+1
        BCC     L51C5

        LDA     #$FF
.L51C5
        STA     R
        JSR     LL5

        LDA     Q
        ASL     A
        LDX     #$00
        STX     QQ8+1
        ROL     QQ8+1
        ASL     A
        ROL     QQ8+1
        STA     QQ8
        JMP     TT24

.hy6
        JSR     CLYNS

        LDA     #$0F
        STA     XC
        LDA     #$F0
        STA     COL
        LDA     #$CD
        JMP     DETOK

.hyp
        LDA     QQ12
        BNE     hy6

        LDA     QQ22+1
        BEQ     L51F4

        RTS

.L51F4
        LDA     #$FF
        STA     COL
        JSR     CTRL

        BMI     Ghy

        LDA     QQ11
        BEQ     TTX110

        AND     #$C0
        BNE     L5206

        RTS

.L5206
        JSR     hm

.TTX111
        LDA     QQ8
        ORA     QQ8+1
        BNE     L5210

        RTS

.L5210
        LDX     #$05
.sob
        LDA     QQ15,X
        STA     safehouse,X
        DEX
        BPL     sob

        LDA     #$07
        STA     XC
        LDA     #$16
        STA     YC
        LDA     #$00
        STA     QQ17
        LDA     #$BD
        JSR     TT27

        LDA     QQ8+1
        BNE     goTT147

        LDA     QQ14
        CMP     QQ8
        BCS     L5239

.goTT147
        JMP     TT147

.L5239
        LDA     #$2D
        JSR     TT27

        JSR     cpl

        LDA     #$0F
.wW2
        STA     QQ22+1
        STA     QQ22
        TAX
        JMP     ee3_lc

.TTX110
        JSR     TT111

        JMP     TTX111

.Ghy
        LDX     GHYP
        BEQ     L527A

        INX
        STX     GHYP
        STX     FIST
        LDA     #$02
        JSR     wW2

        LDX     #$05
        INC     GCNT
        LDA     GCNT
        AND     #$F7
        STA     GCNT
.G1
        LDA     QQ21,X
        ASL     A
        ROL     QQ21,X
        DEX
        BPL     G1

.zZ_lc
        LDA     #$60
L527A = zZ_lc+1
        STA     QQ9
        STA     QQ10
        JSR     TT110

        JSR     TT111

        LDX     #$05
.dumdeedum
        LDA     QQ15,X
        STA     safehouse,X
        DEX
        BPL     dumdeedum

        LDX     #$00
        STX     QQ8
        STX     QQ8+1
        LDA     #$74
        JSR     MESS

.jmp
        LDA     QQ9
        STA     QQ0
        LDA     QQ10
        STA     QQ1
        RTS

.ee3_lc
        LDA     #$F0
        STA     COL
        LDA     #$01
        STA     XC
        STA     YC
        LDY     #$00
        CLC
        LDA     #$03
        JMP     TT11

.pr6
        CLC
.pr5
        LDA     #$05
        JMP     TT11

.TT147
        LDA     #$CA
.prq
        JSR     TT27

        LDA     #$3F
        JMP     TT27

.TT151q
        PLA
        RTS

.TT151
        PHA
        STA     QQ19+4
        ASL     A
        ASL     A
        STA     QQ19
        LDA     MJ
        BNE     TT151q

        LDA     #$01
        JSR     DOXC

        PLA
        ADC     #$D0
        JSR     TT27

        LDA     #$0E
        STA     XC
        LDX     QQ19
        LDA     L6E6E,X
        STA     QQ19+1
        LDA     QQ26
        AND     L6E70,X
        CLC
        ADC     L6E6D,X
        STA     QQ24
        JSR     TT152

        JSR     var

        LDA     QQ19+1
        BMI     TT155

        LDA     QQ24
        ADC     QQ19+3
        JMP     TT156

.TT155
        LDA     QQ24
        SEC
        SBC     QQ19+3
.TT156
        STA     QQ24
        STA     P
        LDA     #$00
        JSR     GC2

        SEC
        JSR     pr5

        LDY     QQ19+4
        LDA     #$05
        LDX     AVL,Y
        STX     QQ25
        CLC
        BEQ     TT172

        JSR     L3AA5

        JMP     TT152

.TT172
        LDA     #$19
        JSR     DOXC

        LDA     #$2D
        BNE     L5349

.TT152
        LDA     QQ19+1
        AND     #$60
        BEQ     TT160

        CMP     #$20
        BEQ     TT161

        JSR     TT16a

.TT162
        LDA     #$20
.L5349
        JMP     TT27

.TT160
        LDA     #$74
        JSR     DASC

        BCC     TT162

.TT161
        LDA     #$6B
        JSR     DASC

.TT16a
        LDA     #$67
        JMP     DASC

.TT163
        LDA     #$11
        JSR     DOXC

        LDA     #$FF
        BNE     L5349

.TT167
        LDA     #$10
        JSR     TRADEMODE

        LDA     #$05
        STA     XC
        LDA     #$A7
        JSR     NLIN3

        LDA     #$03
        STA     YC
        JSR     TT163

        LDA     #$06
        STA     YC
        LDA     #$00
        STA     QQ29
.TT168
        LDX     #$80
        STX     QQ17
        JSR     TT151

        INC     YC
        INC     QQ29
        LDA     QQ29
        CMP     #$11
        BCC     TT168

        RTS

.var
        LDA     QQ19+1
        AND     #$1F
        LDY     QQ28
        STA     QQ19+2
        CLC
        LDA     #$00
        STA     AVL+16
.TT153
        DEY
        BMI     TT154

        ADC     QQ19+2
        JMP     TT153

.TT154
        STA     QQ19+3
        RTS

        JSR     TT111

.L53B5
        JSR     jmp

        LDX     #$05
.TT112
        LDA     safehouse,X
        STA     QQ2,X
        DEX
        BPL     TT112

        INX
        STX     EV
        LDA     QQ3
        STA     QQ28
        LDA     QQ5
        STA     tek
        LDA     QQ4
        STA     gov
        JSR     DORND

        STA     QQ26
        LDX     #$00
        STX     XX4
.hy9
        LDA     L6E6E,X
        STA     QQ19+1
        JSR     var

        LDA     L6E70,X
        AND     QQ26
        CLC
        ADC     L6E6F,X
        LDY     QQ19+1
        BMI     TT157

        SEC
        SBC     QQ19+3
        JMP     TT158

.TT157
        CLC
        ADC     QQ19+3
.TT158
        BPL     TT159

        LDA     #$00
.TT159
        LDY     XX4
        AND     #$3F
        STA     AVL,Y
        INY
        TYA
        STA     XX4
        ASL     A
        ASL     A
        TAX
        CMP     #$3F
        BCC     hy9

        RTS

.GTHG
        JSR     Ze

        LDA     #$FF
        STA     INWK+32
        LDA     #$1D
        JSR     NWSHP

        LDA     #$1E
        JMP     NWSHP

.ptg
        LSR     COK
        SEC
        ROL     COK
.MJP
        LDA     #$03
        JSR     TT66

        JSR     LL164

        JSR     RES2

        STY     MJ
.MJP1
        JSR     GTHG

        LDA     #$02
        CMP     L0E6B
        BCS     MJP1

        STA     NOSTM
        LDX     #$00
        JSR     LOOK1

        LDA     QQ1
        EOR     #$1F
        STA     QQ1
        RTS

.RTS111
        RTS

.TT18
        LDA     QQ14
        SEC
        SBC     QQ8
        BCS     L5461

        LDA     #$00
.L5461
        STA     QQ14
        LDA     QQ11
        BNE     ee5

        JSR     TT66

        JSR     LL164

.ee5
        JSR     CTRL

        AND     PATG
        BMI     ptg

        JSR     DORND

        CMP     #$FD
        BCS     MJP

        JSR     L53B5

        JSR     RES2

        JSR     L5A24

        LDA     QQ11
        AND     #$3F
        BNE     RTS111

        JSR     TTX66

        LDA     QQ11
        BNE     TT114

        INC     QQ11
.TT110
        LDX     QQ12
        BEQ     NLUNCH

        JSR     LAUN

        JSR     RES2

        JSR     TT111

        INC     INWK+8
        JSR     SOS1

        LDA     #$80
        STA     INWK+8
        INC     INWK+7
        JSR     NWSPS

        LDA     #$0C
        STA     DELTA
        JSR     BAD

        ORA     FIST
        STA     FIST
        LDA     #$FF
        STA     QQ11
        JSR     HFS1

.NLUNCH
        LDX     #$00
        STX     QQ12
        JMP     LOOK1

.TT114
        BMI     TT115

        JMP     TT22

.TT115
        JMP     TT23

.LCASH
        STX     T1
        LDA     CASH+3
        SEC
        SBC     T1
        STA     CASH+3
        STY     T1
        LDA     CASH+2
        SBC     T1
        STA     CASH+2
        LDA     CASH+1
        SBC     #$00
        STA     CASH+1
        LDA     CASH
        SBC     #$00
        STA     CASH
        BCS     TT113

.MCASH
        TXA
        CLC
        ADC     CASH+3
        STA     CASH+3
        TYA
        ADC     CASH+2
        STA     CASH+2
        LDA     CASH+1
        ADC     #$00
        STA     CASH+1
        LDA     CASH
        ADC     #$00
        STA     CASH
        CLC
.TT113
        RTS

.GCASH
        JSR     MULTU

.GC2
        ASL     P
        ROL     A
        ASL     P
        ROL     A
        TAY
        LDX     P
        RTS

.bay_lc
        JMP     BAY

.EQSHP
        LDA     #$20
        JSR     TRADEMODE

        LDA     #$0C
        STA     XC
        LDA     #$CF
        JSR     spc

        LDA     #$B9
        JSR     NLIN3

        LDA     #$80
        STA     QQ17
        INC     YC
        LDA     tek
        CLC
        ADC     #$03
        CMP     #$0C
        BCC     L5550

        LDA     #$0E
.L5550
        STA     Q
        STA     QQ25
        INC     Q
        LDA     #$46
        SEC
        SBC     QQ14
        ASL     A
        STA     L5735
        LDX     #$01
.EQL1
        STX     XX13
        JSR     TT67

        LDX     XX13
        CLC
        JSR     pr2

        JSR     TT162

        LDA     XX13
        CLC
        ADC     #$68
        JSR     TT27

        LDA     XX13
        JSR     L56AA

        SEC
        LDA     #$19
        STA     XC
        LDA     #$06
        JSR     TT11

        LDX     XX13
        INX
        CPX     Q
        BCC     EQL1

        JSR     CLYNS

        LDA     #$7F
        JSR     prq

        JSR     gnum

        BEQ     bay_lc

        BCS     bay_lc

        SBC     #$00
        PHA
        LDA     #$02
        STA     XC
        INC     YC
        PLA
        PHA
        JSR     eq

        PLA
        BNE     et0

        LDX     #$46
        STX     QQ14
.et0
        CMP     #$01
        BNE     et1

        LDX     NOMSL
        INX
        LDY     #$7C
        CPX     #$05
        BCS     pres

        STX     NOMSL
        JSR     msblob

        LDA     #$01
.et1
        LDY     #$6B
        CMP     #$02
        BNE     et2

        LDX     #$25
        CPX     CRGO
        BEQ     pres

        STX     CRGO
.et2
        CMP     #$03
        BNE     et3

        INY
        LDX     ECM
        BNE     pres

        DEC     ECM
.et3
        CMP     #$04
        BNE     et4

        JSR     qv

        LDA     #$0F
        JSR     refund

        LDA     #$04
.et4
        CMP     #$05
        BNE     et5

        JSR     qv

        LDA     #$8F
        JSR     refund

.et5
        LDY     #$6F
        CMP     #$06
        BNE     et6

        LDX     BST
        BEQ     ed9

.pres
        STY     K
        JSR     prx

        JSR     MCASH

        LDA     K
        JSR     spc

        LDA     #$1F
        JSR     TT27

.err
        JSR     dn2

        JMP     BAY

.ed9
        DEC     BST
.et6
        INY
        CMP     #$07
        BNE     et7

        LDX     ESCP
        BNE     pres

        DEC     ESCP
.et7
        INY
        CMP     #$08
        BNE     et8

        LDX     BOMB
        BNE     pres

        LDX     #$7F
        STX     BOMB
.et8
        INY
        CMP     #$09
        BNE     etA

        LDX     ENGY
        BNE     pres

        INC     ENGY
.etA
        INY
        CMP     #$0A
        BNE     etB

        LDX     DKCMP
        BNE     pres

        DEC     DKCMP
.etB
        INY
        CMP     #$0B
        BNE     et9

        LDX     GHYP
        BNE     pres

        DEC     GHYP
.et9
        INY
        CMP     #$0C
        BNE     et10

        JSR     qv

        LDA     #$97
        JSR     refund

.et10
        INY
        CMP     #$0D
        BNE     et11

        JSR     qv

        LDA     #$32
        JSR     refund

.et11
        JSR     dn

        JMP     EQSHP

.dn
        JSR     TT162

        LDA     #$77
        JSR     spc

.dn2
        JSR     BEEP

        LDY     #$19
        JMP     DELAY

.eq
        JSR     prx

        JSR     LCASH

        BCS     c

        LDA     #$C5
        JSR     prq

        JMP     err

.L56AA
        SEC
        SBC     #$01
.prx
        ASL     A
        TAY
        LDX     L5735,Y
        LDA     L5736,Y
        TAY
.c
        RTS

.qv
        LDA     tek
        CMP     #$08
        BCC     L56C3

        LDA     #$20
        JSR     TT66

.L56C3
        LDA     #$10
        TAY
        STA     YC
.qv1
        LDA     #$0C
        STA     XC
        TYA
        CLC
        ADC     #$20
        JSR     spc

        LDA     YC
        CLC
        ADC     #$50
        JSR     TT27

        INC     YC
        LDY     YC
        CPY     #$14
        BCC     qv1

        JSR     CLYNS

.qv2
        LDA     #$AF
        JSR     prq

        JSR     TT217

        SEC
        SBC     #$30
        CMP     #$04
        BCC     qv3

        JSR     CLYNS

        JMP     qv2

.qv3
        TAX
        RTS

.hm
        JSR     TT103

        JSR     TT111

        JSR     TT103

        JMP     CLYNS

.refund
        STA     T1
        LDA     LASER,X
        BEQ     ref3

        LDY     #$04
        CMP     #$0F
        BEQ     ref1

        LDY     #$05
        CMP     #$8F
        BEQ     ref1

        LDY     #$0C
        CMP     #$97
        BEQ     ref1

        LDY     #$0D
.ref1
        STX     ZZ
        TYA
        JSR     prx

        JSR     MCASH

        LDX     ZZ
.ref3
        LDA     T1
        STA     LASER,X
        RTS

.L5735
        EQUB    $01

.L5736
        EQUB    $00,$2C,$01,$A0,$0F,$70,$17,$A0
        EQUB    $0F,$10,$27,$82,$14,$10,$27,$28
        EQUB    $23,$98,$3A,$10,$27,$50,$C3,$60
        EQUB    $EA,$40,$1F

.cpl
        LDX     #$05
.TT53
        LDA     QQ15,X
        STA     QQ19,X
        DEX
        BPL     TT53

        LDY     #$03
        BIT     QQ15
        BVS     L5761

        DEY
.L5761
        STY     T
.TT55
        LDA     QQ15+5
        AND     #$1F
        BEQ     L576E

        ORA     #$80
        JSR     TT27

.L576E
        JSR     TT54

        DEC     T
        BPL     TT55

        LDX     #$05
.TT56
        LDA     QQ19,X
        STA     QQ15,X
        DEX
        BPL     TT56

        RTS

.cmn
        LDY     #$00
.QUL4
        LDA     NAME,Y
        CMP     #$0D
        BEQ     L578E

        JSR     DASC

        INY
        BNE     QUL4

.L578E
        RTS

.ypl
        BIT     MJ
        BMI     ypl16

        JSR     TT62

        JSR     cpl

.TT62
        LDX     #$05
.TT78
        LDA     QQ15,X
        LDY     QQ2,X
        STA     QQ2,X
        STY     QQ15,X
        DEX
        BPL     TT78

.ypl16
        RTS

.tal
        CLC
        LDX     GCNT
        INX
        JMP     pr2

.fwl
        LDA     #$69
        JSR     TT68

        LDX     QQ14
        SEC
        JSR     pr2

        LDA     #$C3
        JSR     plf

        LDA     #$77
        BNE     TT27

.csh
        LDX     #$03
.pc1
        LDA     CASH,X
        STA     K,X
        DEX
        BPL     pc1

        LDA     #$09
        STA     U
        SEC
        JSR     BPRNT

        LDA     #$E2
.plf
        JSR     TT27

        JMP     TT67

.TT68
        JSR     TT27

.TT73
        LDA     #$3A
.TT27
        TAX
        BEQ     csh

        BMI     TT43

        DEX
        BEQ     tal

        DEX
        BEQ     ypl

        DEX
        BNE     L57F7

        JMP     cpl

.L57F7
        DEX
        BEQ     cmn

        DEX
        BEQ     fwl

        DEX
        BNE     L5805

        LDA     #$80
        STA     QQ17
        RTS

.L5805
        DEX
        DEX
        BNE     L580C

        STX     QQ17
        RTS

.L580C
        DEX
        BEQ     crlf

        CMP     #$60
        BCS     ex

        CMP     #$0E
        BCC     L581B

        CMP     #$20
        BCC     qw

.L581B
        LDX     QQ17
        BEQ     TT74

        BMI     TT41

        BIT     QQ17
        BVS     TT46

.TT42
        CMP     #$41
        BCC     TT44

        CMP     #$5B
        BCS     TT44

        ADC     #$20
.TT44
        JMP     DASC

.TT41
        BIT     QQ17
        BVS     TT45

        CMP     #$41
        BCC     TT74

        PHA
        TXA
        ORA     #$40
        STA     QQ17
        PLA
        BNE     TT44

.qw
        ADC     #$72
        BNE     ex

.crlf
        LDA     #$15
        JSR     DOXC

        JMP     TT73

.TT45
        CPX     #$FF
        BEQ     TT48

        CMP     #$41
        BCS     TT42

.TT46
        PHA
        TXA
        AND     #$BF
        STA     QQ17
        PLA
.TT74
        JMP     DASC

.TT43
        CMP     #$A0
        BCS     TT47

        AND     #$7F
        ASL     A
        TAY
        LDA     QQ16,Y
        JSR     TT27

        LDA     L3424,Y
        CMP     #$3F
        BEQ     TT48

        JMP     TT27

.TT47
        SBC     #$A0
.ex
        TAX
        LDA     #$00
        STA     V
        LDA     #$A0
        STA     V+1
        LDY     #$00
        TXA
        BEQ     TT50

.TT51
        LDA     (V),Y
        BEQ     TT49

        INY
        BNE     TT51

        INC     V+1
        BNE     TT51

.TT49
        INY
        BNE     TT59

        INC     V+1
.TT59
        DEX
        BNE     TT51

.TT50
        TYA
        PHA
        LDA     V+1
        PHA
        LDA     (V),Y
        EOR     #$23
        JSR     TT27

        PLA
        STA     V+1
        PLA
        TAY
        INY
        BNE     L58B2

        INC     V+1
.L58B2
        LDA     (V),Y
        BNE     TT50

.TT48
        RTS

        LDX     #$15
.L58B9
        LDA     ZP,X
        LDY     ZP,X
        STA     ZP,X
        STY     ZP,X
        INX
        BNE     L58B9

        RTS

.EX2
        LDA     INWK+31
        ORA     #$A0
        STA     INWK+31
        RTS

.DOEXP
        LDA     INWK+31
        AND     #$40
        BEQ     L58D5

        JSR     PTCLS

.L58D5
        LDA     INWK+6
        STA     T
        LDA     INWK+7
        CMP     #$20
        BCC     L58E3

        LDA     #$FE
        BNE     yy_lc

.L58E3
        ASL     T
        ROL     A
        ASL     T
        ROL     A
        SEC
        ROL     A
.yy_lc
        STA     Q
        LDY     #$01
        LDA     (XX19),Y
        STA     L12A6
        ADC     #$04
        BCS     EX2

        STA     (XX19),Y
        JSR     DVID4

        LDA     P
        CMP     #$1C
        BCC     L5907

        LDA     #$FE
        BNE     LABEL_1

.L5907
        ASL     R
        ROL     A
        ASL     R
        ROL     A
        ASL     R
        ROL     A
.LABEL_1
        DEY
        STA     (XX19),Y
        LDA     INWK+31
        AND     #$BF
        STA     INWK+31
        AND     #$08
        BEQ     TT48

        LDY     #$02
        LDA     (XX19),Y
        TAY
.EXL1
        LDA     XX3-7,Y
        STA     (XX19),Y
        DEY
        CPY     #$06
        BNE     EXL1

        LDA     INWK+31
        ORA     #$40
        STA     INWK+31
.PTCLS
        LDY     #$00
        LDA     (XX19),Y
        STA     Q
        INY
        LDA     (XX19),Y
        BPL     L593F

        EOR     #$FF
.L593F
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        ORA     #$01
        STA     U
        INY
        LDA     (XX19),Y
        STA     TGT
        LDA     RAND+1
        PHA
        LDY     #$06
.EXL5
        LDX     #$03
.EXL3
        INY
        LDA     (XX19),Y
        STA     K3,X
        DEX
        BPL     EXL3

        STY     CNT
        LDY     #$02
.EXL2
        INY
        LDA     (XX19),Y
        EOR     CNT
        STA     LFFFF,Y
        CPY     #$06
        BNE     EXL2

        LDY     U
        STY     CNT2
.DORND2_UNROLLED
        CLC
        LDA     RAND
        ROL     A
        TAX
        ADC     RAND+2
        STA     RAND
        STX     RAND+2
        LDA     RAND+1
        TAX
        ADC     RAND+3
        STA     RAND+1
        STX     RAND+3
        STA     ZZ
        AND     #$03
        TAX
        LDA     L5A0D,X
        STA     COL
        LDA     K3+1
        STA     R
        LDA     K3
        JSR     EXS1

        BNE     EX11

        CPX     #$BF
        BCS     EX11

        STX     Y1
        LDA     K3+3
        STA     R
        LDA     K3+2
        JSR     EXS1

        BNE     EX4

        LDA     Y1
        JSR     PIXEL

.EX4
        DEC     CNT2
        BPL     DORND2_UNROLLED

        LDY     CNT
        CPY     TGT
        BCC     EXL5

        PLA
        STA     RAND+1
        LDA     L0406
        STA     RAND+3
        RTS

.EX11
        CLC
        LDA     RAND
        ROL     A
        TAX
        ADC     RAND+2
        STA     RAND
        STX     RAND+2
        LDA     RAND+1
        TAX
        ADC     RAND+3
        STA     RAND+1
        STX     RAND+3
        JMP     EX4

.EXS1
        STA     S
        CLC
        LDA     RAND
        ROL     A
        TAX
        ADC     RAND+2
        STA     RAND
        STX     RAND+2
        LDA     RAND+1
        TAX
        ADC     RAND+3
        STA     RAND+1
        STX     RAND+3
        ROL     A
        BCS     EX5

        JSR     FMLTU

        ADC     R
        TAX
        LDA     S
        ADC     #$00
        RTS

.EX5
        JSR     FMLTU

        STA     T
        LDA     R
        SBC     T
        TAX
        LDA     S
        SBC     #$00
        RTS

        EQUB    $00

        EQUB    $02

.L5A0D
        EQUB    $0F,$F0,$0F,$FF

.SOS1
        JSR     msblob

        LDA     #$7F
        STA     INWK+29
        STA     INWK+30
        LDA     tek
        AND     #$02
        ORA     #$80
        JMP     NWSHP

.L5A24
        LDA     L1264
        BEQ     SOLAR

        LDA     #$00
        STA     QQ20
        STA     QQ20+6
        JSR     DORND

        AND     #$0F
        ADC     L1264
        ORA     #$04
        ROL     A
        STA     L1264
        ROL     L1265
        BPL     SOLAR

        ROR     L1265
.SOLAR
        LSR     FIST
        JSR     ZINF

        LDA     QQ15+1
        AND     #$03
        ADC     #$03
        STA     INWK+8
        ROR     A
        STA     INWK+2
        STA     INWK+5
        JSR     SOS1

        LDA     QQ15+3
        AND     #$07
        ORA     #$81
        STA     INWK+8
        LDA     QQ15+5
        AND     #$03
        STA     INWK+2
        STA     INWK+1
        LDA     #$00
        STA     INWK+29
        STA     INWK+30
        LDA     #$81
        JSR     NWSHP

.NWSTARS
        LDA     QQ11
        BNE     WPSHPS

.nWq
        LDA     #$FA
        STA     COL
        LDY     NOSTM
.SAL4
        JSR     DORND

        ORA     #$08
        STA     SZ,Y
        STA     ZZ
        JSR     DORND

        STA     SX,Y
        STA     XX15
        JSR     DORND

        STA     SY,Y
        STA     Y1
        JSR     PIXEL2

        DEY
        BNE     SAL4

.WPSHPS
        LDX     #$00
.WSL1
        LDA     FRIN,X
        BEQ     WS2

        BMI     WS1

        STA     TYPE
        JSR     GINF

        LDY     #$1F
.WSL2
        LDA     (INF),Y
        STA     INWK,Y
        DEY
        BPL     WSL2

        STX     XSAV
        JSR     SCAN

        LDX     XSAV
        LDY     #$1F
        LDA     (INF),Y
        AND     #$A7
        STA     (INF),Y
.WS1
        INX
        BNE     WSL1

.WS2
        LDX     #$00
        STX     LSP
        DEX
        STX     LSX2
        STX     LSY2
.FLFLLS
        LDY     #$C7
        LDA     #$00
.SAL6
        STA     LSO,Y
        DEY
        BNE     SAL6

        DEY
        STY     LSX
        RTS

.DET1
        LDA     #$06
        SEI
        STA     VIA
        STX     LFE01
        CLI
        RTS

.L5AF0
        DEX
        RTS

.SHD
        INX
        BEQ     L5AF0

.DENGY
        DEC     ENERGY
        PHP
        BNE     L5AFC

        INC     ENERGY
.L5AFC
        PLP
        RTS

.COMPAS
        JSR     DOT

        LDA     SSPR
        BNE     SP1

        JSR     SPS1

        JMP     SP2

.SPS2
        ASL     A
        TAX
        LDA     #$00
        ROR     A
        TAY
        LDA     #$14
        STA     Q
        TXA
        JSR     DVID4

        LDX     P
        TYA
        BMI     LL163

        LDY     #$00
        RTS

.LL163
        LDY     #$FF
        TXA
        EOR     #$FF
        TAX
        INX
        RTS

.SPS4
        LDX     #$08
.SPL1
        LDA     L0425,X
        STA     K3,X
        DEX
        BPL     SPL1

        JMP     TAS2

.SP1
        JSR     SPS4

.SP2
        LDA     XX15
        JSR     SPS2

        TXA
        ADC     #$C3
        STA     COMX
        LDA     Y1
        JSR     SPS2

        STX     T
        LDA     #$CC
        SBC     T
        STA     COMY
        LDA     #$0F
        LDX     X2
        BPL     L5B5B

        LDA     #$0C
.L5B5B
        STA     COMC
        JMP     DOT

.OOPS
        STA     T
        LDX     #$00
        LDY     #$08
        LDA     (INF),Y
        BMI     OO1

        LDA     FSH
        SBC     T
        BCC     OO2

        STA     FSH
        RTS

.OO2
        LDX     #$00
        STX     FSH
        BCC     OO3

.OO1
        LDA     ASH
        SBC     T
        BCC     OO5

        STA     ASH
        RTS

.OO5
        LDX     #$00
        STX     ASH
.OO3
        ADC     ENERGY
        STA     ENERGY
        BEQ     L5B8F

        BCS     L5B92

.L5B8F
        JMP     DEATH

.L5B92
        JSR     EXNO3

        JMP     OUCH

.SPS3
        LDA     L0401,X
        STA     K3,X
        LDA     L0402,X
        TAY
        AND     #$7F
        STA     K3+1,X
        TYA
        AND     #$80
        STA     K3+2,X
        RTS

.NWSPS
        JSR     SPBLB

        LDX     #$81
        STX     INWK+32
        LDX     #$00
        STX     INWK+30
        STX     NEWB
        STX     FRIN+1
        DEX
        STX     INWK+29
        LDX     #$0A
        JSR     NwS1

        JSR     NwS1

        JSR     NwS1

        LDA     spasto
        STA     L8002
        LDA     L6761
        STA     L8003
        LDA     tek
        CMP     #$0A
        BCC     notadodo

        LDA     L8040
        STA     L8002
        LDA     L8041
        STA     L8003
.notadodo
        LDA     #$7E
        STA     XX19
        LDA     #$10
        STA     INWK+34
        LDA     #$02
.NWSHP
        STA     T
        LDX     #$00
.NWL1
        LDA     FRIN,X
        BEQ     NW1

        INX
        CPX     #$0C
        BCC     NWL1

.NW3
        CLC
.L5C01
        RTS

.NW1
        JSR     GINF

        LDA     T
        BMI     NW2

        ASL     A
        TAY
        LDA     L7FFF,Y
        BEQ     NW3

        STA     XX0+1
        LDA     L7FFE,Y
        STA     XX0
        CPY     #$04
        BEQ     NW6

        LDY     #$05
        LDA     (XX0),Y
        STA     T1
        LDA     SLSP
        SEC
        SBC     T1
        STA     XX19
        LDA     SLSP+1
        SBC     #$00
        STA     INWK+34
        LDA     XX19
        SBC     INF
        TAY
        LDA     INWK+34
        SBC     INF+1
        BCC     L5C01

        BNE     NW4

        CPY     #$25
        BCC     L5C01

.NW4
        LDA     XX19
        STA     SLSP
        LDA     INWK+34
        STA     SLSP+1
.NW6
        LDY     #$0E
        LDA     (XX0),Y
        STA     INWK+35
        LDY     #$13
        LDA     (XX0),Y
        AND     #$07
        STA     INWK+31
        LDA     T
.NW2
        STA     FRIN,X
        TAX
        BMI     NW8

        CPX     #$0F
        BEQ     gangbang

        CPX     #$03
        BCC     NW7

        CPX     #$0B
        BCS     NW7

.gangbang
        INC     JUNK
.NW7
        INC     MANY,X
.NW8
        LDY     T
        LDA     L8041,Y
        AND     #$6F
        ORA     NEWB
        STA     NEWB
        LDY     #$24
.NWL3
        LDA     INWK,Y
        STA     (INF),Y
        DEY
        BPL     NWL3

        SEC
        RTS

.NwS1
        LDA     INWK,X
        EOR     #$80
        STA     INWK,X
        INX
        INX
        RTS

.ABORT
        LDX     #$FF
.ABORT2
        STX     MSTG
        LDX     NOMSL
        JSR     MSBAR

        STY     MSAR
        RTS

        EQUB    $04

        EQUB    $00,$00,$00,$00

.PROJ
        LDA     INWK
        STA     P
        LDA     INWK+1
        STA     P+1
        LDA     INWK+2
        JSR     PLS6

        BCS     L5CDD

        LDA     K
        ADC     #$80
        STA     K3
        TXA
        ADC     #$00
        STA     K3+1
        LDA     INWK+3
        STA     P
        LDA     INWK+4
        STA     P+1
        LDA     INWK+5
        EOR     #$80
        JSR     PLS6

        BCS     L5CDD

        LDA     K
        ADC     #$60
        STA     K4
        TXA
        ADC     #$00
        STA     K4+1
        CLC
.L5CDD
        RTS

.PL2
        LDA     TYPE
        LSR     A
        BCS     L5CE6

        JMP     WPLS2

.L5CE6
        JMP     WPLS

.PLANET
        LDA     #$AF
        STA     COL
        LDA     INWK+8
        CMP     #$30
        BCS     PL2

        ORA     INWK+7
        BEQ     PL2

        JSR     PROJ

        BCS     PL2

        LDA     #$60
        STA     P+1
        LDA     #$00
        STA     P
        JSR     DVID3B2

        LDA     K+1
        BEQ     PL82

        LDA     #$F8
        STA     K
.PL82
        LDA     TYPE
        LSR     A
        BCC     PL9

        JMP     SUN

.PL9
        JSR     WPLS2

        JSR     CIRCLE

        BCS     PL20

        LDA     K+1
        BEQ     PL25

.PL20
        RTS

.PL25
        LDA     TYPE
        CMP     #$80
        BNE     PL26

        LDA     K
        CMP     #$06
        BCC     PL20

        LDA     INWK+14
        EOR     #$80
        STA     P
        LDA     INWK+20
        JSR     PLS4

        LDX     #$09
        JSR     PLS1

        STA     K2
        STY     XX16
        JSR     PLS1

        STA     K2+1
        STY     XX16+1
        LDX     #$0F
        JSR     PLS5

        JSR     PLS2

        LDA     INWK+14
        EOR     #$80
        STA     P
        LDA     INWK+26
        JSR     PLS4

        LDX     #$15
        JSR     PLS5

        JMP     PLS2

.PL26
        LDA     INWK+20
        BMI     PL20

        LDX     #$0F
        JSR     PLS3

        CLC
        ADC     K3
        STA     K3
        TYA
        ADC     K3+1
        STA     K3+1
        JSR     PLS3

        STA     P
        LDA     K4
        SEC
        SBC     P
        STA     K4
        STY     P
        LDA     K4+1
        SBC     P
        STA     K4+1
        LDX     #$09
        JSR     PLS1

        LSR     A
        STA     K2
        STY     XX16
        JSR     PLS1

        LSR     A
        STA     K2+1
        STY     XX16+1
        LDX     #$15
        JSR     PLS1

        LSR     A
        STA     K2+2
        STY     XX16+2
        JSR     PLS1

        LSR     A
        STA     K2+3
        STY     XX16+3
        LDA     #$40
        STA     TGT
        LDA     #$00
        STA     CNT2
        JMP     PLS22

.PLS1
        LDA     INWK,X
        STA     P
        LDA     INWK+1,X
        AND     #$7F
        STA     P+1
        LDA     INWK+1,X
        AND     #$80
        JSR     DVID3B2

        LDA     K
        LDY     K+1
        BEQ     L5DD5

        LDA     #$FE
.L5DD5
        LDY     K+3
        INX
        INX
        RTS

.PLS2
        LDA     #$1F
        STA     TGT
.PLS22
        LDX     #$00
        STX     CNT
        DEX
        STX     FLAG
.PLL4
        LDA     CNT2
        AND     #$1F
        TAX
        LDA     SNE,X
        STA     Q
        LDA     K2+2
        JSR     FMLTU

        STA     R
        LDA     K2+3
        JSR     FMLTU

        STA     K
        LDX     CNT2
        CPX     #$21
        LDA     #$00
        ROR     A
        STA     XX16+5
        LDA     CNT2
        CLC
        ADC     #$10
        AND     #$1F
        TAX
        LDA     SNE,X
        STA     Q
        LDA     K2+1
        JSR     FMLTU

        STA     K+2
        LDA     K2
        JSR     FMLTU

        STA     P
        LDA     CNT2
        ADC     #$0F
        AND     #$3F
        CMP     #$21
        LDA     #$00
        ROR     A
        STA     XX16+4
        LDA     XX16+5
        EOR     XX16+2
        STA     S
        LDA     XX16+4
        EOR     XX16
        JSR     ADD

        STA     T
        BPL     PL42

        TXA
        EOR     #$FF
        CLC
        ADC     #$01
        TAX
        LDA     T
        EOR     #$7F
        ADC     #$00
        STA     T
.PL42
        TXA
        ADC     K3
        STA     XX18+4
        LDA     T
        ADC     K3+1
        STA     XX18+5
        LDA     K
        STA     R
        LDA     XX16+5
        EOR     XX16+3
        STA     S
        LDA     K+2
        STA     P
        LDA     XX16+4
        EOR     XX16+1
        JSR     ADD

        EOR     #$80
        STA     T
        BPL     PL43

        TXA
        EOR     #$FF
        CLC
        ADC     #$01
        TAX
        LDA     T
        EOR     #$7F
        ADC     #$00
        STA     T
.PL43
        JSR     BLINE

        CMP     TGT
        BEQ     L5E8C

        BCS     PL40

.L5E8C
        LDA     CNT2
        CLC
        ADC     STP
        AND     #$3F
        STA     CNT2
        JMP     PLL4

.PL40
        RTS

.L5E99
        JMP     WPLS

.PLF3
        TXA
        EOR     #$FF
        CLC
        ADC     #$01
        TAX
.PLF17
        LDA     #$FF
        BNE     PLF5

.SUN
        LDA     #$F0
        STA     COL
        LDA     #$01
        STA     LSX
        JSR     CHKON

        BCS     L5E99

        LDA     #$00
        LDX     K
        CPX     #$60
        ROL     A
        CPX     #$28
        ROL     A
        CPX     #$10
        ROL     A
        STA     CNT
        LDA     L0099
        LDX     P+2
        BNE     PLF2_UC

        CMP     P+1
        BCC     PLF2_UC

        LDA     P+1
        BNE     PLF2_UC

        LDA     #$01
.PLF2_UC
        STA     TGT
        LDA     L0099
        SEC
        SBC     K4
        TAX
        LDA     #$00
        SBC     K4+1
        BMI     PLF3

        BNE     PLF4

        INX
        DEX
        BEQ     PLF17

        CPX     K
        BCC     PLF5

.PLF4
        LDX     K
        LDA     #$00
.PLF5
        STX     V
        STA     V+1
        LDA     K
        JSR     SQUA2

        STA     K2+1
        LDA     P
        STA     K2
        LDY     L0099
        LDA     SUNX
        STA     YY
        LDA     SUNX+1
        STA     YY+1
.PLFL2
        CPY     TGT
        BEQ     PLFL

        LDA     LSO,Y
        BEQ     PLFL13

        JSR     HLOIN2

.PLFL13
        DEY
        BNE     PLFL2

.PLFL
        LDA     V
        JSR     SQUA2

        STA     T
        LDA     K2
        SEC
        SBC     P
        STA     Q
        LDA     K2+1
        SBC     T
        STA     R
        STY     Y1
        JSR     LL5

        LDY     Y1
        JSR     DORND

        AND     CNT
        CLC
        ADC     Q
        BCC     PLF44

        LDA     #$FF
.PLF44
        LDX     LSO,Y
        STA     LSO,Y
        BEQ     PLF11

        LDA     SUNX
        STA     YY
        LDA     SUNX+1
        STA     YY+1
        TXA
        JSR     EDGES

        LDA     XX15
        STA     XX
        LDA     X2
        STA     XX+1
        LDA     K3
        STA     YY
        LDA     K3+1
        STA     YY+1
        LDA     LSO,Y
        JSR     EDGES

        BCS     PLF23

        LDA     X2
        LDX     XX
        STX     X2
        STA     XX
        JSR     HLOIN

.PLF23
        LDA     XX
        STA     XX15
        LDA     XX+1
        STA     X2
.PLF16
        JSR     HLOIN

.PLF6
        DEY
        BEQ     PLF8

        LDA     V+1
        BNE     PLF10

        DEC     V
        BNE     PLFL

        DEC     V+1
.PLFLS
        JMP     PLFL

.PLF11
        LDX     K3
        STX     YY
        LDX     K3+1
        STX     YY+1
        JSR     EDGES

        BCC     PLF16

        LDA     #$00
        STA     LSO,Y
        BEQ     PLF6

.PLF10
        LDX     V
        INX
        STX     V
        CPX     K
        BCC     PLFLS

        BEQ     PLFLS

        LDA     SUNX
        STA     YY
        LDA     SUNX+1
        STA     YY+1
.PLFL3
        LDA     LSO,Y
        BEQ     PLF9

        JSR     HLOIN2

.PLF9
        DEY
        BNE     PLFL3

.PLF8
        CLC
        LDA     K3
        STA     SUNX
        LDA     K3+1
        STA     SUNX+1
.RTS2
        RTS

.CIRCLE
        JSR     CHKON

        BCS     RTS2

        LDA     #$00
        STA     LSX2
        LDX     K
        LDA     #$08
        CPX     #$08
        BCC     PL89

        LSR     A
        CPX     #$3C
        BCC     PL89

        LSR     A
.PL89
        STA     STP
.CIRCLE2
        LDX     #$FF
        STX     FLAG
        INX
        STX     CNT
.PLL3
        LDA     CNT
        JSR     FMLTU2

        LDX     #$00
        STX     T
        LDX     CNT
        CPX     #$21
        BCC     PL37

        EOR     #$FF
        ADC     #$00
        TAX
        LDA     #$FF
        ADC     #$00
        STA     T
        TXA
        CLC
.PL37
        ADC     K3
        STA     XX18+4
        LDA     K3+1
        ADC     T
        STA     XX18+5
        LDA     CNT
        CLC
        ADC     #$10
        JSR     FMLTU2

        TAX
        LDA     #$00
        STA     T
        LDA     CNT
        ADC     #$0F
        AND     #$3F
        CMP     #$21
        BCC     PL38

        TXA
        EOR     #$FF
        ADC     #$00
        TAX
        LDA     #$FF
        ADC     #$00
        STA     T
        CLC
.PL38
        JSR     BLINE

        CMP     #$41
        BCS     L6041

        JMP     PLL3

.L6041
        CLC
        RTS

.WPLS2
        LDY     LSX2
        BNE     WP1

.WPL1
        CPY     LSP
        BCS     WP1

        LDA     LSY2,Y
        CMP     #$FF
        BEQ     WP2

        STA     Y2
        LDA     LSX2,Y
        STA     X2
        JSR     LL30

        INY
        LDA     SWAP
        BNE     WPL1

        LDA     X2
        STA     XX15
        LDA     Y2
        STA     Y1
        JMP     WPL1

.WP2
        INY
        LDA     LSX2,Y
        STA     XX15
        LDA     LSY2,Y
        STA     Y1
        INY
        JMP     WPL1

.WP1
        LDA     #$01
        STA     LSP
        LDA     #$FF
        STA     LSX2
.L6086
        RTS

.WPLS
        LDA     LSX
        BMI     L6086

        LDA     SUNX
        STA     YY
        LDA     SUNX+1
        STA     YY+1
        LDY     #$BF
.WPL2
        LDA     LSO,Y
        BEQ     L609D

        JSR     HLOIN2

.L609D
        DEY
        BNE     WPL2

        DEY
        STY     LSX
        RTS

.EDGES
        STA     T
        CLC
        ADC     YY
        STA     X2
        LDA     YY+1
        ADC     #$00
        BMI     ED1

        BEQ     L60B7

        LDA     #$FF
        STA     X2
.L60B7
        LDA     YY
        SEC
        SBC     T
        STA     XX15
        LDA     YY+1
        SBC     #$00
        BNE     ED3

        CLC
        RTS

.ED3
        BPL     ED1

        LDA     #$00
        STA     XX15
        CLC
        RTS

.ED1
        LDA     #$00
        STA     LSO,Y
        SEC
        RTS

.CHKON
        LDA     K3
        CLC
        ADC     K
        LDA     K3+1
        ADC     #$00
        BMI     PL21

        LDA     K3
        SEC
        SBC     K
        LDA     K3+1
        SBC     #$00
        BMI     PL31

        BNE     PL21

.PL31
        LDA     K4
        CLC
        ADC     K
        STA     P+1
        LDA     K4+1
        ADC     #$00
        BMI     PL21

        STA     P+2
        LDA     K4
        SEC
        SBC     K
        TAX
        LDA     K4+1
        SBC     #$00
        BMI     PL44

        BNE     PL21

        CPX     L0099
        RTS

.PL21
        SEC
        RTS

.PLS3
        JSR     PLS1

        STA     P
        LDA     #$DE
        STA     Q
        STX     U
        JSR     MULTU

        LDX     U
        LDY     K+3
        BPL     PL12

        EOR     #$FF
        CLC
        ADC     #$01
        BEQ     PL12

        LDY     #$FF
        RTS

.PL12
        LDY     #$00
        RTS

.PLS4
        STA     Q
        JSR     ARCTAN

        LDX     INWK+14
        BMI     L613B

        EOR     #$80
.L613B
        LSR     A
        LSR     A
        STA     CNT2
        RTS

.PLS5
        JSR     PLS1

        STA     K2+2
        STY     XX16+2
        JSR     PLS1

        STA     K2+3
        STY     XX16+3
        RTS

.PLS6
        JSR     DVID3B2

        LDA     K+3
        AND     #$7F
        ORA     K+2
        BNE     PL21

        LDX     K+1
        CPX     #$04
        BCS     PL6

        LDA     K+3
        BPL     PL6

        LDA     K
        EOR     #$FF
        ADC     #$01
        STA     K
        TXA
        EOR     #$FF
        ADC     #$00
        TAX
.PL44
        CLC
.PL6
        RTS

.L6174
        JSR     t_lc

        CMP     #$59
        BEQ     PL6

        CMP     #$4E
        BNE     L6174

        CLC
        RTS

.TT17
        LDA     QQ11
        BNE     L618A

        JSR     DOKEY

        TXA
        RTS

.L618A
        JSR     DOKEY

        LDA     JSTK
        BEQ     L61A3

        LDA     JSTY
        JSR     L61D4

        TAY
        LDA     JSTX
        EOR     #$FF
        JSR     L61D4

        TAX
        LDA     KL
        RTS

.L61A3
        LDA     KL
        LDX     #$00
        LDY     #$00
        CMP     #$8C
        BNE     L61AE

        DEX
.L61AE
        CMP     #$8D
        BNE     L61B3

        INX
.L61B3
        CMP     #$8E
        BNE     L61B8

        DEY
.L61B8
        CMP     #$8F
        BNE     L61BD

        INY
.L61BD
        PHX
        LDA     #$00
        JSR     DKS4

        BMI     L61C9

        PLX
        LDA     KL
        RTS

.L61C9
        PLA
        ASL     A
        ASL     A
        TAX
        TYA
        ASL     A
        ASL     A
        TAY
        LDA     KL
        RTS

.L61D4
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        ADC     #$00
        SBC     #$03
        RTS

.KS3
        LDA     P
        STA     SLSP
        LDA     P+1
        STA     SLSP+1
        RTS

.KS1
        LDX     XSAV
        JSR     KILLSHP

        LDX     XSAV
        JMP     MAL1

.KS4
        JSR     ZINF

        JSR     FLFLLS

        STA     FRIN+1
        STA     SSPR
        JSR     SPBLB

        LDA     #$06
        STA     INWK+5
        LDA     #$81
        JMP     NWSHP

.KS2
        LDX     #$FF
.KSL4
        INX
        LDA     FRIN,X
        BEQ     KS3

        CMP     #$01
        BNE     KSL4

        TXA
        ASL     A
        TAY
        LDA     UNIV,Y
        STA     SC
        LDA     L357A,Y
        STA     SC+1
        LDY     #$20
        LDA     (SC),Y
        BPL     KSL4

        AND     #$7F
        LSR     A
        CMP     XX4
        BCC     KSL4

        BEQ     KS6

        SBC     #$01
        ASL     A
        ORA     #$80
        STA     (SC),Y
        BNE     KSL4

.KS6
        LDA     #$00
        STA     (SC),Y
        BEQ     KSL4

.KILLSHP
        STX     XX4
        LDA     MSTG
        CMP     XX4
        BNE     KS5

        LDY     #$0C
        JSR     ABORT

        LDA     #$C8
        JSR     MESS

.KS5
        LDY     XX4
        LDX     FRIN,Y
        CPX     #$02
        BEQ     KS4

        CPX     #$1F
        BNE     lll

        LDA     TP
        ORA     #$02
        STA     TP
        INC     TALLY+1
.lll
        CPX     #$0F
        BEQ     blacksuspenders

        CPX     #$03
        BCC     KS7

        CPX     #$0B
        BCS     KS7

.blacksuspenders
        DEC     JUNK
.KS7
        DEC     MANY,X
        LDX     XX4
        LDY     #$05
        LDA     (XX0),Y
        LDY     #$21
        CLC
        ADC     (INF),Y
        STA     P
        INY
        LDA     (INF),Y
        ADC     #$00
        STA     P+1
.KSL1
        INX
        LDA     FRIN,X
        STA     FRIN-1,X
        BNE     L629E

        JMP     KS2

.L629E
        ASL     A
        TAY
        LDA     L7FFE,Y
        STA     SC
        LDA     L7FFF,Y
        STA     SC+1
        LDY     #$05
        LDA     (SC),Y
        STA     T
        LDA     P
        SEC
        SBC     T
        STA     P
        LDA     P+1
        SBC     #$00
        STA     P+1
        TXA
        ASL     A
        TAY
        LDA     UNIV,Y
        STA     SC
        LDA     L357A,Y
        STA     SC+1
        LDY     #$24
        LDA     (SC),Y
        STA     (INF),Y
        DEY
        LDA     (SC),Y
        STA     (INF),Y
        DEY
        LDA     (SC),Y
        STA     K+1
        LDA     P+1
        STA     (INF),Y
        DEY
        LDA     (SC),Y
        STA     K
        LDA     P
        STA     (INF),Y
        DEY
.KSL2
        LDA     (SC),Y
        STA     (INF),Y
        DEY
        BPL     KSL2

        LDA     SC
        STA     INF
        LDA     SC+1
        STA     INF+1
        LDY     T
.KSL3
        DEY
        LDA     (K),Y
        STA     (P),Y
        TYA
        BNE     KSL3

        BEQ     KSL1

.THERE
        LDX     GCNT
        DEX
        BNE     THEX

        LDA     QQ0
        CMP     #$90
        BNE     THEX

        LDA     QQ1
        CMP     #$21
        BEQ     L6318

.THEX
        CLC
.L6318
        RTS

        PHA
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        JSR     L6324

        PLA
        AND     #$0F
.L6324
        CMP     #$0A
        BCS     L632D

        ADC     #$30
        JMP     TT26

.L632D
        ADC     #$36
        JMP     TT26

.RESET
        JSR     ZERO

        LDX     #$06
.SAL3
        STA     BETA,X
        DEX
        BPL     SAL3

        STX     L2C5A
        TXA
        STA     QQ12
        LDX     #$02
.REL5
        STA     FSH,X
        DEX
        BPL     REL5

.RES2
        LDA     #$14
        STA     NOSTM
        LDX     #$FF
        STX     LSX2
        STX     LSY2
        STX     MSTG
        LDA     #$80
        STA     JSTY
        STA     ALP2
        STA     BET2
        ASL     A
        STA     BETA
        STA     BET1
        STA     ALP2+1
        STA     BET2+1
        STA     MCNT
        LDA     #$03
        STA     DELTA
        STA     ALPHA
        STA     ALP1
        LDA     #$00
        STA     L0098
        LDA     #$BF
        STA     L0099
        LDA     SSPR
        BEQ     L6382

        JSR     SPBLB

.L6382
        LDA     ECMA
        BEQ     yu

        JSR     ECMOF

.yu
        JSR     WPSHPS

        JSR     ZERO

        LDA     #$00
        STA     SLSP
        LDA     #$08
        STA     SLSP+1
.ZINF
        LDY     #$24
        LDA     #$00
.ZI1
        STA     INWK,Y
        DEY
        BPL     ZI1

        LDA     #$60
        STA     INWK+18
        STA     INWK+22
        ORA     #$80
        STA     INWK+14
        RTS

.msblob
        LDX     #$04
.ss
        CPX     NOMSL
        BEQ     SAL8

        LDY     #$00
        JSR     MSBAR

        DEX
        BNE     ss

        RTS

.SAL8
        LDY     #$0C
        JSR     MSBAR

        DEX
        BNE     SAL8

        RTS

.me2
        LDA     QQ11
        BNE     L63D9

        LDA     MCH
        JSR     MESS

        LDA     #$00
        STA     DLY
        JMP     me3

.L63D9
        JSR     CLYNS

        JMP     me3

.Ze
        JSR     ZINF

        JSR     DORND

        STA     T1
        AND     #$80
        STA     INWK+2
        TXA
        AND     #$80
        STA     INWK+5
        LDA     #$19
        STA     INWK+1
        STA     INWK+4
        STA     INWK+7
        TXA
        CMP     #$F5
        ROL     A
        ORA     #$C0
        STA     INWK+32
        CLC
.DORND
        LDA     RAND
        ROL     A
        TAX
        ADC     RAND+2
        STA     RAND
        STX     RAND+2
        LDA     RAND+1
        TAX
        ADC     RAND+3
        STA     RAND+1
        STX     RAND+3
        RTS

.MTT4
        JSR     DORND

        LSR     A
        STA     INWK+32
        STA     INWK+29
        ROL     INWK+31
        AND     #$1F
        ORA     #$10
        STA     INWK+27
        JSR     DORND

        BMI     nodo

        LDA     INWK+32
        ORA     #$C0
        STA     INWK+32
        LDX     #$10
        STX     NEWB
.nodo
        AND     #$02
        ADC     #$0B
        CMP     #$0F
        BEQ     TT100

        JSR     NWSHP

.TT100
        JSR     M%

        DEC     DLY
        BEQ     me2

        BPL     me3

        INC     DLY
.me3
        DEC     MCNT
        BEQ     L6453

.ytq
        JMP     MLOOP

.L6453
        LDA     MJ
        BNE     ytq

        JSR     DORND

        CMP     #$23
        BCS     MTT1

        LDA     JUNK
        CMP     #$03
        BCS     MTT1

        JSR     ZINF

        LDA     #$26
        STA     INWK+7
        JSR     DORND

        STA     INWK
        STX     INWK+3
        AND     #$80
        STA     INWK+2
        TXA
        AND     #$80
        STA     INWK+5
        ROL     INWK+1
        ROL     INWK+1
        JSR     DORND

        BVS     MTT4

        ORA     #$6F
        STA     INWK+29
        LDA     SSPR
        BNE     MTT1

        TXA
        BCS     MTT2

        AND     #$1F
        ORA     #$10
        STA     INWK+27
        BCC     MTT3

.MTT2
        ORA     #$7F
        STA     INWK+30
.MTT3
        JSR     DORND

        CMP     #$FC
        BCC     thongs

        LDA     #$0F
        STA     INWK+32
        BNE     whips

.thongs
        CMP     #$0A
        AND     #$01
        ADC     #$05
.whips
        JSR     NWSHP

.MTT1
        LDA     SSPR
        BEQ     L64BC

.MLOOPS
        JMP     MLOOP

.L64BC
        JSR     BAD

        ASL     A
        LDX     L0E5E
        BEQ     L64C8

        ORA     FIST
.L64C8
        STA     T
        JSR     Ze

        CMP     #$88
        BEQ     fothg

        CMP     T
        BCS     L64DA

        LDA     #$10
        JSR     NWSHP

.L64DA
        LDA     L0E5E
        BNE     MLOOPS

        DEC     EV
        BPL     MLOOPS

        INC     EV
        LDA     TP
        AND     #$0C
        CMP     #$08
        BNE     nopl

        JSR     DORND

        CMP     #$DC
        BCC     nopl

.fothg2
        JSR     GTHG

.nopl
        JSR     DORND

        LDY     gov
        BEQ     LABEL_2

        CMP     #$5A
        BCS     MLOOPS

        AND     #$07
        CMP     gov
        BCC     MLOOPS

.LABEL_2
        JSR     Ze

        CMP     #$64
        BCS     mt1_lc

        INC     EV
        AND     #$03
        ADC     #$18
        TAY
        JSR     THERE

        BCC     NOCON

        LDA     #$F9
        STA     INWK+32
        LDA     TP
        AND     #$03
        LSR     A
        BCC     NOCON

        ORA     L0E6D
        BEQ     YESCON

.NOCON
        LDA     #$04
        STA     NEWB
        JSR     DORND

        CMP     #$C8
        ROL     A
        ORA     #$C0
        STA     INWK+32
        TYA
        EQUB    $2C

.YESCON
        LDA     #$1F
.focoug
        JSR     NWSHP

        JMP     MLOOP

.fothg
        LDA     L0406
        AND     #$3E
        BNE     fothg2

        LDA     #$12
        STA     INWK+27
        LDA     #$79
        STA     INWK+32
        LDA     #$20
        BNE     focoug

.mt1_lc
        AND     #$03
        STA     EV
        STA     XX13
.mt3
        JSR     DORND

        STA     T
        JSR     DORND

        AND     T
        AND     #$07
        ADC     #$11
        JSR     NWSHP

        DEC     XX13
        BPL     mt3

.MLOOP
        LDX     #$FF
        TXS
        LDX     GNTMP
        BEQ     EE20

        DEC     GNTMP
.EE20
        LDX     LASCT
        BEQ     NOLASCT

        DEX
        BEQ     L658D

        DEX
.L658D
        STX     LASCT
.NOLASCT
        JSR     DIALS

        LDA     QQ11
        BEQ     L65A2

        AND     PATG
        LSR     A
        BCS     L65A2

        LDY     #$02
        JSR     DELAY

.L65A2
        JSR     TT17

.FRCE
        JSR     TT102

        LDA     QQ12
        BEQ     L65AF

        JMP     MLOOP

.L65AF
        JMP     TT100

.TT102
        CMP     #$88
        BNE     L65B9

        JMP     STATUS

.L65B9
        CMP     #$84
        BNE     L65C0

        JMP     TT22

.L65C0
        CMP     #$85
        BNE     L65C7

        JMP     TT23

.L65C7
        CMP     #$86
        BNE     TT92

        JSR     TT111

        JMP     TT25

.TT92
        CMP     #$89
        BNE     L65D8

        JMP     TT213

.L65D8
        CMP     #$87
        BNE     L65DF

        JMP     TT167

.L65DF
        CMP     #$80
        BNE     fvw

        JMP     TT110

.fvw
        BIT     QQ12
        BPL     INSP

        CMP     #$83
        BNE     L65F1

        JMP     EQSHP

.L65F1
        CMP     #$81
        BNE     L65F8

        JMP     TT219

.L65F8
        CMP     #$40
        BNE     nosave

        JSR     SVE

        BCC     L6604

        JMP     QU5

.L6604
        JMP     BAY

.nosave
        CMP     #$82
        BNE     LABEL_3

        JMP     TT208

.INSP
        CMP     #$81
        BEQ     L6620

        CMP     #$82
        BEQ     L661D

        CMP     #$83
        BNE     LABEL_3

        LDX     #$03
        EQUB    $2C

.L661D
        LDX     #$02
        EQUB    $2C

.L6620
        LDX     #$01
        JMP     LOOK1

.LABEL_3
        LDA     KL
        CMP     #$48
        BNE     NWDAV5

        JMP     hyp

.NWDAV5
        CMP     #$44
        BEQ     T95_UC

        CMP     #$46
        BNE     HME1

        LDA     QQ12
        BEQ     t95

        LDA     QQ11
        AND     #$C0
        BEQ     t95

        JMP     HME2

.HME1
        STA     T1
        LDA     QQ11
        AND     #$C0
        BEQ     TT107

        LDA     QQ22+1
        BNE     TT107

        LDA     T1
        CMP     #$4F
        BNE     ee2_lc

        JSR     TT103

        JSR     ping

        JMP     TT103

.ee2_lc
        JSR     TT16

.TT107
        LDA     QQ22+1
        BEQ     t95

        DEC     QQ22
        BNE     t95

        LDX     QQ22+1
        DEX
        JSR     ee3_lc

        LDA     #$05
        STA     QQ22
        LDX     QQ22+1
        JSR     ee3_lc

        DEC     QQ22+1
        BNE     t95

        JMP     TT18

.t95
        RTS

.T95_UC
        LDA     QQ11
        AND     #$C0
        BEQ     t95

        JSR     hm

        JSR     cpl

        LDA     #$80
        STA     QQ17
        LDA     #$0C
        JSR     DASC

        JMP     TT146

.BAD
        LDA     QQ20+3
        CLC
        ADC     QQ20+6
        ASL     A
        ADC     QQ20+10
        RTS

.FAROF
        LDA     #$E0
.FAROF2
        CMP     INWK+1
        BCC     FA1

        CMP     INWK+4
        BCC     FA1

        CMP     INWK+7
.FA1
        RTS

.MAS4
        ORA     INWK+1
        ORA     INWK+4
        ORA     INWK+7
        RTS

.L66B8
        EQUB    $FF

.BRBR
        LDX     L66B8
        TXS
        JSR     MASTER_SWAP_ZP_3000

        STZ     CATF
        LDY     #$00
        LDA     #$07
.BRBRLOOP
        JSR     TT26

        INY
        LDA     (&FD),Y
        BNE     BRBRLOOP

        JSR     t_lc

        JMP     SVE

.DEATH
        LDY     #$04
        JSR     NOISE

        JSR     RES2

        ASL     DELTA
        ASL     DELTA
        LDX     #$18
        JSR     DET1

        LDA     #$0D
        JSR     TT66

        STZ     QQ11
        JSR     BOX

        JSR     nWq

        LDA     #$FF
        STA     COL
        LDA     #$0C
        STA     XC
        STA     YC
        LDA     #$92
        JSR     ex

.D1
        JSR     Ze

        LSR     A
        LSR     A
        STA     INWK
        LDY     #$00
        STY     INWK+1
        STY     INWK+4
        STY     INWK+7
        STY     INWK+32
        DEY
        STY     MCNT
        EOR     #$2A
        STA     INWK+3
        ORA     #$50
        STA     INWK+6
        TXA
        AND     #$8F
        STA     INWK+29
        LDY     #$40
        STY     LASCT
        SEC
        ROR     A
        AND     #$87
        STA     INWK+30
        LDX     #$05
        LDA     L8007
        BEQ     D3

        BCC     D3

        DEX
.D3
        JSR     fq1

        JSR     DORND

        AND     #$80
        LDY     #$1F
        STA     (INF),Y
        LDA     L0E45
        BEQ     D1

        LDA     #$00
        STA     DELTA
        JSR     M%

.D2
        JSR     M%

        DEC     LASCT
        BNE     D2

        LDX     #$1F
        JSR     DET1

        JMP     DEATH2

.spasto
        DEY
.L6761
        DEY
.BEGIN
        LDX     #$1E
        LDA     #$00
.BEL1
        STA     COMC,X
        DEX
        BPL     BEL1

        LDA     L8002
        STA     spasto
        LDA     L8003
        STA     L6761
        JSR     L68BB

        LDX     #$FF
        TXS
        JSR     RESET

.DEATH2
        LDX     #$FF
        TXS
        JSR     RES2

        JSR     U%

        LDA     #$03
        STA     XC
        LDX     #$0B
        LDA     #$06
        LDY     #$C8
        JSR     TITLE

        CPX     #$59
        BNE     QU5

        JSR     DFAULT

        JSR     SVE

.QU5
        JSR     DFAULT

        JSR     msblob

        LDA     #$07
        LDX     #$20
        LDY     #$64
        JSR     TITLE

        JSR     ping

        JSR     TT111

        JSR     jmp

        LDX     #$05
.likeTT112
        LDA     QQ15,X
        STA     QQ2,X
        DEX
        BPL     likeTT112

        INX
        STX     EV
        LDA     QQ3
        STA     QQ28
        LDA     QQ5
        STA     tek
        LDA     QQ4
        STA     gov
.BAY
        LDA     #$FF
        STA     QQ12
        LDA     #$88
        JMP     FRCE

.DFAULT
        LDX     #$54
.QUL1
        LDA     L3467,X
        STA     NAME-1,X
        DEX
        BNE     QUL1

        STX     QQ11
.L67EC
        JSR     CHECK

        CMP     CHK
        BNE     L67EC

        EOR     #$A9
        TAX
        LDA     COK
        CPX     CHK2
        BEQ     tZ

        ORA     #$80
.tZ
        ORA     #$08
        STA     COK
        RTS

.TITLE
        STY     L1229
        PHA
        STX     TYPE
        JSR     RESET

        JSR     U%

        JSR     ZINF

        LDA     #$20
        JSR     DOVDU19

        LDA     #$0D
        JSR     TT66

        LDA     #$F0
        STA     COL
        LDA     #$00
        STA     QQ11
        LDA     #$60
        STA     INWK+14
        LDA     #$60
        STA     INWK+7
        LDX     #$7F
        STX     INWK+29
        STX     INWK+30
        INX
        STX     QQ17
        LDA     TYPE
        JSR     NWSHP

        LDA     #$06
        STA     XC
        LDA     #$1E
        JSR     plf

        LDA     #$0A
        JSR     DASC

        LDA     #$06
        STA     XC
        LDA     PATG
        BEQ     awe

        LDA     #$0D
        JSR     DETOK

.awe
        LDY     #$00
        STY     DELTA
        STY     JSTK
        LDA     #$14
        STA     YC
        LDA     #$01
        STA     XC
        PLA
        JSR     DETOK

        LDA     #$07
        STA     XC
        LDA     #$0C
        JSR     DETOK

        LDA     #$0C
        STA     CNT2
        LDA     #$05
        STA     MCNT
        STZ     JSTK
.TLL2
        LDA     INWK+7
        CMP     #$01
        BEQ     TL1

        DEC     INWK+7
.TL1
        JSR     MVEIT

        LDX     L1229
        STX     INWK+6
        LDA     #$00
        STA     INWK
        STA     INWK+3
        JSR     LL9

        DEC     MCNT
        LDA     LFE40
        AND     #$10
        BEQ     TL2

        JSR     RDKEY

        BEQ     TLL2

        RTS

.TL2
        DEC     JSTK
        RTS

.CHECK
        LDX     #$49
        CLC
        TXA
.QUL2
        ADC     L346F,X
        EOR     L3470,X
        DEX
        BNE     QUL2

        RTS

.L68BB
        LDY     #$60
.L68BD
        LDA     L34CD,Y
        STA     NA%,Y
        DEY
        BPL     L68BD

        LDY     #$07
        STY     L6A8B
        RTS

.TRNME
        LDX     #$07
        LDA     L6A8A
        STA     L6A8B
.GTL1
        LDA     INWK+5,X
        STA     NA%,X
        DEX
        BPL     GTL1

.TR1
        LDX     #$07
.GTL2
        LDA     NA%,X
        STA     INWK+5,X
        DEX
        BPL     GTL2

        RTS

.GTNMEW
        LDX     #$04
.GTL3
        LDA     L3463,X
        STA     INWK,X
        DEX
        BPL     GTL3

        LDA     #$07
        STA     L695D
        LDA     #$08
        JSR     DETOK

        JSR     MT26

        LDA     #$09
        STA     L695D
        TYA
        BEQ     TR1

        STY     L6A8A
        RTS

.MT26
        LDA     COL
        PHA
        LDA     #$F0
        STA     COL
        LDY     #$08
        JSR     DELAY

        JSR     FLKB

        LDY     #$00
.L691B
        JSR     TT217

        CMP     #$0D
        BEQ     L6945

        CMP     #$1B
        BEQ     L694E

        CMP     #$7F
        BEQ     L6953

        CPY     L695D
        BCS     L693E

        CMP     L695E
        BCC     L693E

        CMP     L695F
        BCS     L693E

        STA     INWK+5,Y
        INY
        EQUB    $2C

.L693E
        LDA     #$07
.L6940
        JSR     TT26

        BCC     L691B

.L6945
        STA     INWK+5,Y
        LDA     #$0C
        JSR     TT26

        EQUB    $24

.L694E
        SEC
        PLA
        STA     COL
        RTS

.L6953
        TYA
        BEQ     L693E

        DEY
        LDA     #$7F
        BNE     L6940

.L695B
        EQUB    $A1

        EQUB    $00

.L695D
        EQUB    $09

.L695E
        EQUB    $21

.L695F
        EQUB    $7B

.L6960
        LDA     #$03
        CLC
        ADC     L2C5E
        JMP     DETOK

        LDA     #$02
        SEC
        SBC     L2C5E
        JMP     DETOK

.ZERO
        LDX     #$3C
        LDA     #$00
.ZEL2
        STA     FRIN,X
        DEX
        BPL     ZEL2

        RTS

.CATS
        JSR     GTDRV

        BCS     L69A5

        STA     L6ACB
        STA     DTW7
        LDA     #$03
        JSR     DETOK

        LDA     #$01
        STA     CATF
        STA     XC
        JSR     MASTER_SWAP_ZP_3000

        LDX     #$C7
        LDY     #$6A
        JSR     OSCLI

        JSR     MASTER_SWAP_ZP_3000

        STZ     CATF
        CLC
.L69A5
        RTS

.DELT
        JSR     CATS

        BCS     SVE

        LDA     L6ACB
        STA     L6AD5
        LDA     #$08
        JSR     DETOK

        JSR     MT26

        TYA
        BEQ     SVE

        LDX     #$09
.DELL1
        LDA     INWK+4,X
        STA     L6AD6,X
        DEX
        BNE     DELL1

        JSR     MASTER_SWAP_ZP_3000

        LDX     #$CD
        LDY     #$6A
        JSR     OSCLI

        JSR     MASTER_SWAP_ZP_3000

        JMP     SVE

.SVE
        TSX
        STX     L66B8
        JSR     L4A88

        LDA     #$01
        JSR     DETOK

        JSR     t_lc

        CMP     #$31
        BEQ     MASTER_LOAD

        CMP     #$32
        BEQ     SV1

        CMP     #$33
        BEQ     CAT

        CMP     #$34
        BNE     L69FB

        JSR     DELT

        JMP     SVE

.L69FB
        CMP     #$35
        BNE     L6A0F

        LDA     #$E0
        JSR     DETOK

        JSR     L6174

        BCC     L6A0F

        JSR     L68BB

        JMP     DFAULT

.L6A0F
        CLC
        RTS

.CAT
        JSR     CATS

        JSR     t_lc

        JMP     SVE

.MASTER_LOAD
        JSR     GTNMEW

        JSR     GTDRV

        BCS     L6A2C

        STA     L6B05
        JSR     LOD

        JSR     TRNME

        SEC
.L6A2C
        RTS

.SV1
        JSR     GTNMEW

        JSR     TRNME

        LSR     SVC
        LDA     #$04
        JSR     DETOK

        LDX     #$4C
.SVL1
        LDA     TP,X
        STA     L3470,X
        DEX
        BPL     SVL1

        JSR     CHECK

        STA     CHK
        PHA
        ORA     #$80
        STA     K
        EOR     COK
        STA     K+2
        EOR     CASH+2
        STA     K+1
        EOR     #$5A
        EOR     TALLY+1
        STA     K+3
        CLC
        JSR     TT67

        JSR     TT67

        PLA
        EOR     #$A9
        STA     CHK2
        LDY     #$4C
.L6A71
        LDA     L3470,Y
        STA     L0791,Y
        DEY
        BPL     L6A71

        JSR     GTDRV

        BCS     L6A85

        STA     L6AE5
        JSR     L6B16

.L6A85
        EQUB    $20

        EQUB    $DF,$67,$18,$60

.L6A8A
        EQUB    $07

.L6A8B
        EQUB    $07

.GTDRV
        LDA     #$02
        JSR     DETOK

        JSR     t_lc

        ORA     #$10
        JSR     TT26

        PHA
        JSR     FEED

        PLA
        CMP     #$30
        BCC     LOR

        CMP     #$34
        RTS

.LOD
        JSR     ZEBC

        LDA     L0791
        BMI     L6ABA

        LDY     #$4C
.LOL1
        LDA     L0791,Y
        STA     L3470,Y
        DEY
        BPL     LOL1

.LOR
        SEC
        RTS

.L6ABA
        LDA     #$09
        JSR     DETOK

        JSR     t_lc

        JMP     SVE

        RTS

        RTS

        EQUS    "CAT"

        EQUS    " "

.L6ACB
        EQUS    "1"

        EQUB    $0D

        EQUS    "DELE"

        EQUS    "TE :"

.L6AD5
        EQUS    "1"

.L6AD6
        EQUS    ".1234567"

        EQUB    $0D

        EQUS    "SAVE :"

.L6AE5
        EQUS    "1.E."

.L6AE9
        EQUS    "JAMESON  E7E +100 0 0"

        EQUB    $0D

        EQUS    "LOAD :"

.L6B05
        EQUS    "1.E."

.L6B09
        EQUS    "JAMESON  E7E"

        EQUB    $0D

.L6B16
        LDY     #$4C
.L6B18
        LDA     L3470,Y
        STA     LSX2,Y
        DEY
        BPL     L6B18

        LDA     #$00
        LDY     #$4C
.L6B25
        STA     LSX2,Y
        INY
        BNE     L6B25

        LDY     #$00
.L6B2D
        LDA     NA%,Y
        CMP     #$0D
        BEQ     L6B3C

        STA     L6AE9,Y
        INY
        CPY     #$07
        BCC     L6B2D

.L6B3C
        LDA     #$20
        STA     L6AE9,Y
        INY
        CPY     #$07
        BCC     L6B3C

        JSR     MASTER_SWAP_ZP_3000

        LDX     #$DF
        LDY     #$6A
        JSR     OSCLI

        JMP     MASTER_SWAP_ZP_3000

.ZEBC
        LDY     #$00
.L6B55
        LDA     INWK+5,Y
        CMP     #$0D
        BEQ     L6B64

        STA     L6B09,Y
        INY
        CPY     #$07
        BCC     L6B55

.L6B64
        LDA     #$20
        STA     L6B09,Y
        INY
        CPY     #$07
        BCC     L6B64

        JSR     MASTER_SWAP_ZP_3000

        LDX     #$FF
        LDY     #$6A
        JSR     OSCLI

        JSR     MASTER_SWAP_ZP_3000

        LDY     #$4C
.L6B7D
        LDA     LSX2,Y
        STA     L0791,Y
        DEY
        BPL     L6B7D

        RTS

        RTS

.SPS1
        LDX     #$00
        JSR     SPS3

        LDX     #$03
        JSR     SPS3

        LDX     #$06
        JSR     SPS3

.TAS2
        LDA     K3
        ORA     K3+3
        ORA     K3+6
        ORA     #$01
        STA     K3+9
        LDA     K3+1
        ORA     K3+4
        ORA     K3+7
.TAL2
        ASL     K3+9
        ROL     A
        BCS     TA2

        ASL     K3
        ROL     K3+1
        ASL     K3+3
        ROL     K3+4
        ASL     K3+6
        ROL     K3+7
        BCC     TAL2

.TA2
        LDA     K3+1
        LSR     A
        ORA     K3+2
        STA     XX15
        LDA     K3+4
        LSR     A
        ORA     K3+5
        STA     Y1
        LDA     K3+7
        LSR     A
        ORA     K3+8
        STA     X2
.NORM
        LDA     XX15
        JSR     SQUA

        STA     R
        LDA     P
        STA     Q
        LDA     Y1
        JSR     SQUA

        STA     T
        LDA     P
        ADC     Q
        STA     Q
        LDA     T
        ADC     R
        STA     R
        LDA     X2
        JSR     SQUA

        STA     T
        LDA     P
        ADC     Q
        STA     Q
        LDA     T
        ADC     R
        STA     R
        JSR     LL5

        LDA     XX15
        JSR     TIS2

        STA     XX15
        LDA     Y1
        JSR     TIS2

        STA     Y1
        LDA     X2
        JSR     TIS2

        STA     X2
        RTS

.WARP
        LDX     JUNK
        LDA     FRIN+2,X
        ORA     SSPR
        ORA     MJ
        BNE     WA1

        LDY     L0408
        BMI     WA3

        TAY
        JSR     MAS2

        CMP     #$02
        BCC     WA1

.WA3
        LDY     L042D
        BMI     WA2

        LDY     #$25
        JSR     m

        CMP     #$02
        BCC     WA1

.WA2
        LDA     #$81
        STA     S
        STA     R
        STA     P
        LDA     L0408
        JSR     ADD

        STA     L0408
        LDA     L042D
        JSR     ADD

        STA     L042D
        LDA     #$01
        STA     QQ11
        STA     MCNT
        LSR     A
        STA     EV
        LDX     VIEW
        JMP     LOOK1

.WA1
        JMP     BEEP_LONG_LOW

        RTS

.DKS3
        TXA
        CMP     L2C62,Y
        BNE     Dk3

        LDA     DAMP,Y
        EOR     #$FF
        STA     DAMP,Y
        BPL     L6C83

        JSR     BELL

.L6C83
        JSR     BELL

        TYA
        PHA
        LDY     #$14
        JSR     DELAY

        PLA
        TAY
.Dk3
        RTS

.DOKEY
        JSR     L7ED7

        LDA     auto
        BEQ     L6CF2

        JSR     ZINF

        LDA     #$60
        STA     INWK+14
        ORA     #$80
        STA     INWK+22
        STA     TYPE
        LDA     DELTA
        STA     INWK+27
        JSR     DOCKIT

        LDA     INWK+27
        CMP     #$16
        BCC     L6CB4

        LDA     #$16
.L6CB4
        STA     DELTA
        LDA     #$FF
        LDX     #$0F
        LDY     INWK+28
        BEQ     DK11

        BMI     L6CC2

        LDX     #$0B
.L6CC2
        STA     KL,X
.DK11
        LDA     #$80
        LDX     #$0D
        ASL     INWK+29
        BEQ     DK12

        BCC     L6CD0

        LDX     #$0E
.L6CD0
        BIT     INWK+29
        BPL     DK14

        LDA     #$40
        STA     JSTX
        LDA     #$00
.DK14
        STA     KL,X
        LDA     JSTX
.DK12
        STA     JSTX
        LDA     #$80
        LDX     #$06
        ASL     INWK+30
        BEQ     DK13

        BCS     L6CEC

        LDX     #$08
.L6CEC
        STA     KL,X
        LDA     JSTY
.DK13
        STA     JSTY
.L6CF2
        LDA     JSTK
        BEQ     DK15

        LDA     L12A7
        EOR     L2C5B
        ORA     #$01
        STA     JSTX
        LDA     L12A8
        EOR     #$FF
        EOR     L2C5B
        EOR     L2C5A
        STA     JSTY
        LDA     LFE40
        AND     #$10
        BNE     DK4

        LDA     #$FF
        STA     KY7
        BNE     DK4

.DK15
        LDX     JSTX
        LDA     #$07
        LDY     L00D0
        BEQ     L6D26

        JSR     BUMP2

.L6D26
        LDY     L00D1
        BEQ     L6D2D

        JSR     REDU2

.L6D2D
        STX     JSTX
        ASL     A
        LDX     JSTY
        LDY     L00C9
        BEQ     L6D39

        JSR     REDU2

.L6D39
        LDY     L00CB
        BEQ     L6D40

        JSR     BUMP2

.L6D40
        STX     JSTY
.DK4
        LDX     KL
        CPX     #$8B
        BNE     DK2

.FREEZE
        JSR     WSCAN

        JSR     RDKEY

        CPX     #$51
        BNE     DK6

        LDX     #$FF
        STX     L2C55
        LDX     #$51
.DK6
        LDY     #$00
.DKL4
        JSR     DKS3

        INY
        CPY     #$09
        BNE     DKL4

        LDA     L2C61
        CPX     #$2E
        BEQ     L6D70

        CPX     #$2C
        BNE     L6D83

        DEC     A
        EQUB    $24

.L6D70
        INC     A
        TAY
        AND     #$F8
        BNE     L6D79

        STY     L2C61
.L6D79
        PHX
        JSR     BEEP

        LDY     #$0A
        JSR     DELAY

        PLX
.L6D83
        CPX     #$42
        BNE     nobit

        LDA     BSTK
        EOR     #$FF
        STA     BSTK
        STA     JSTK
        STA     L2C5B
        BPL     L6D9A

        JSR     BELL

.L6D9A
        JSR     BELL

.nobit
        CPX     #$53
        BNE     DK7

        LDA     #$00
        STA     L2C55
.DK7
        CPX     #$1B
        BNE     L6DAD

        JMP     DEATH2

.L6DAD
        CPX     #$7F
        BNE     FREEZE

.DK2
        RTS

.TT217
        STY     YSAV
.t_lc
        LDY     #$02
        JSR     DELAY

        JSR     RDKEY

        BNE     t_lc

.t2
        JSR     RDKEY

        BEQ     t2

        LDY     YSAV
        TAX
.out_lc
        RTS

.me1
        STX     DLY
        PHA
        LDA     #$0F
        STA     COL
        LDA     MCH
        JSR     mes9

        PLA
.MESS
        PHA
        LDX     QQ11
        BEQ     L6DDE

        JSR     CLYNS

.L6DDE
        LDA     #$15
        STA     YC
        LDA     #$0F
        STA     COL
        LDX     #$00
        STX     QQ17
        LDA     messXC
        STA     XC
        PLA
        LDY     #$14
        CPX     DLY
        BNE     me1

        STY     DLY
        STA     MCH
        LDA     #$C0
        STA     DTW4
        LDA     de
        LSR     A
        LDA     #$00
        BCC     L6E0B

        LDA     #$0A
.L6E0B
        STA     DTW5
        LDA     MCH
        JSR     TT27

        LDA     #$20
        SEC
        SBC     DTW5
        LSR     A
        STA     messXC
        STA     XC
        JSR     MT15

        LDA     MCH
.mes9
        JSR     TT27

        LSR     de
        BCC     out_lc

        LDA     #$FD
        JMP     TT27

.OUCH
        JSR     DORND

        BMI     out_lc

        CPX     #$16
        BCS     out_lc

        LDA     QQ20,X
        BEQ     out_lc

        LDA     DLY
        BNE     out_lc

        LDY     #$03
        STY     de
        STA     QQ20,X
        CPX     #$11
        BCS     ou1

        TXA
        ADC     #$D0
        JMP     MESS

.ou1
        BEQ     ou2

        CPX     #$12
        BEQ     ou3

        TXA
        ADC     #$5D
        JMP     MESS

.ou2
        LDA     #$6C
        JMP     MESS

.ou3
        LDA     #$6F
        JMP     MESS

.L6E6D
        EQUB    $13

.L6E6E
        EQUB    $82

.L6E6F
        EQUB    $06

.L6E70
        EQUB    $01,$14,$81,$0A,$03,$41,$83,$02
        EQUB    $07,$28,$85,$E2,$1F,$53,$85,$FB
        EQUB    $0F,$C4,$08,$36,$03,$EB,$1D,$08
        EQUB    $78,$9A,$0E,$38,$03,$75,$06,$28
        EQUB    $07,$4E,$01,$11,$1F,$7C,$0D,$1D
        EQUB    $07,$B0,$89,$DC,$3F,$20,$81,$35
        EQUB    $03,$61,$A1,$42,$07,$AB,$A2,$37
        EQUB    $1F,$2D,$C1,$FA,$0F,$35,$0F,$C0
        EQUB    $07

.TI2
        TYA
        LDY     #$02
        JSR     TIS3

        STA     INWK+20
        JMP     TI3

.TI1
        TAX
        LDA     Y1
        AND     #$60
        BEQ     TI2

        LDA     #$02
        JSR     TIS3

        STA     INWK+18
        JMP     TI3

.TIDY
        LDA     INWK+10
        STA     XX15
        LDA     INWK+12
        STA     Y1
        LDA     INWK+14
        STA     X2
        JSR     NORM

        LDA     XX15
        STA     INWK+10
        LDA     Y1
        STA     INWK+12
        LDA     X2
        STA     INWK+14
        LDY     #$04
        LDA     XX15
        AND     #$60
        BEQ     TI1

        LDX     #$02
        LDA     #$00
        JSR     TIS3

        STA     INWK+16
.TI3
        LDA     INWK+16
        STA     XX15
        LDA     INWK+18
        STA     Y1
        LDA     INWK+20
        STA     X2
        JSR     NORM

        LDA     XX15
        STA     INWK+16
        LDA     Y1
        STA     INWK+18
        LDA     X2
        STA     INWK+20
        LDA     INWK+12
        STA     Q
        LDA     INWK+20
        JSR     MULT12

        LDX     INWK+14
        LDA     INWK+18
        JSR     TIS1

        EOR     #$80
        STA     INWK+22
        LDA     INWK+16
        JSR     MULT12

        LDX     INWK+10
        LDA     INWK+20
        JSR     TIS1

        EOR     #$80
        STA     INWK+24
        LDA     INWK+18
        JSR     MULT12

        LDX     INWK+12
        LDA     INWK+16
        JSR     TIS1

        EOR     #$80
        STA     INWK+26
        LDA     #$00
        LDX     #$0E
.TIL1
        STA     INWK+9,X
        DEX
        DEX
        BPL     TIL1

        RTS

.TIS2
        TAY
        AND     #$7F
        CMP     Q
        BCS     TI4

        LDX     #$FE
        STX     T
.TIL2
        ASL     A
        CMP     Q
        BCC     L6F65

        SBC     Q
.L6F65
        ROL     T
        BCS     TIL2

        LDA     T
        LSR     A
        LSR     A
        STA     T
        LSR     A
        ADC     T
        STA     T
        TYA
        AND     #$80
        ORA     T
        RTS

.TI4
        TYA
        AND     #$80
        ORA     #$60
        RTS

.TIS3
        STA     P+2
        LDA     INWK+10,X
        STA     Q
        LDA     INWK+16,X
        JSR     MULT12

        LDX     INWK+10,Y
        STX     Q
        LDA     INWK+16,Y
        JSR     MAD

        STX     P
        LDY     P+2
        LDX     INWK+10,Y
        STX     Q
        EOR     #$80
        STA     P+1
        EOR     Q
        AND     #$80
        STA     T
        LDA     #$00
        LDX     #$10
        ASL     P
        ROL     P+1
        ASL     Q
        LSR     Q
.DVL2
        ROL     A
        CMP     Q
        BCC     L6FBA

        SBC     Q
.L6FBA
        ROL     P
        ROL     P+1
        DEX
        BNE     DVL2

        LDA     P
        ORA     T
        RTS

        EQUB    $02

        EQUB    $0F,$31,$32,$33,$34,$35,$36,$37
        EQUB    $38,$39,$30,$31,$32,$33,$34,$35
        EQUB    $36,$37

.SHPPT
        JSR     PROJ

        ORA     K3+1
        BNE     nono

        LDA     K4
        CMP     #$BE
        BCS     nono

        JSR     Shpt

        LDA     K4
        CLC
        ADC     #$01
        JSR     Shpt

        LDA     #$08
        ORA     INWK+31
        STA     INWK+31
        JMP     LL155

.nono
        LDA     #$F7
        AND     INWK+31
        STA     INWK+31
        JMP     LL155

.Shpt
        STA     Y1
        STA     Y2
        LDA     K3
        STA     XX15
        CLC
        ADC     #$03
        BCC     L7012

        LDA     #$FF
.L7012
        STA     X2
        JMP     L78F8

.LL5
        LDY     R
        LDA     Q
        STA     S
        LDX     #$00
        STX     Q
        LDA     #$08
        STA     T
.LL6
        CPX     Q
        BCC     LL7

        BNE     LL8

        CPY     #$40
        BCC     LL7

.LL8
        TYA
        SBC     #$40
        TAY
        TXA
        SBC     Q
        TAX
.LL7
        ROL     Q
        ASL     S
        TYA
        ROL     A
        TAY
        TXA
        ROL     A
        TAX
        ASL     S
        TYA
        ROL     A
        TAY
        TXA
        ROL     A
        TAX
        DEC     T
        BNE     LL6

        RTS

.LL28
        CMP     Q
        BCS     LL2

        STA     widget
        TAX
        BEQ     LLfix

        LDA     logL,X
        LDX     Q
        SEC
        SBC     logL,X
        LDX     widget
        LDA     log,X
        LDX     Q
        SBC     log,X
        BCS     LL2

        TAX
        LDA     antilog,X
.LLfix
        STA     R
        RTS

        BCS     LL2

        LDX     #$FE
        STX     R
.LL31
        ASL     A
        BCS     LL29

        CMP     Q
        BCC     L7082

        SBC     Q
.L7082
        ROL     R
        BCS     LL31

        RTS

.LL29
        SBC     Q
        SEC
        ROL     R
        BCS     LL31

        LDA     R
        RTS

.LL2
        LDA     #$FF
        STA     R
        RTS

.LL38
        EOR     S
        BMI     LL39

        LDA     Q
        CLC
        ADC     R
        RTS

.LL39
        LDA     R
        SEC
        SBC     Q
        BCC     L70A9

        CLC
        RTS

.L70A9
        PHA
        LDA     S
        EOR     #$80
        STA     S
        PLA
        EOR     #$FF
        ADC     #$01
        RTS

.LL51
        LDX     #$00
        LDY     #$00
.ll51_lc
        LDA     XX15
        STA     Q
        LDA     XX16,X
        JSR     FMLTU

        STA     T
        LDA     Y1
        EOR     XX16+1,X
        STA     S
        LDA     X2
        STA     Q
        LDA     XX16+2,X
        JSR     FMLTU

        STA     Q
        LDA     T
        STA     R
        LDA     Y2
        EOR     XX16+3,X
        JSR     LL38

        STA     T
        LDA     XX15+4
        STA     Q
        LDA     XX16+4,X
        JSR     FMLTU

        STA     Q
        LDA     T
        STA     R
        LDA     XX15+5
        EOR     XX16+5,X
        JSR     LL38

        STA     XX12,Y
        LDA     S
        STA     XX12+1,Y
        INY
        INY
        TXA
        CLC
        ADC     #$06
        TAX
        CMP     #$11
        BCC     ll51_lc

        RTS

.LL25
        JMP     PLANET

.LL9
        LDX     TYPE
        BMI     LL25

        LDA     shpcol,X
        STA     COL
        LDA     #$1F
        STA     XX4
        LDY     #$01
        STY     XX14
        DEY
        LDA     #$08
        BIT     INWK+31
        BNE     L712B

        LDA     #$00
        EQUB    $2C

.L712B
        LDA     (XX19),Y
        STA     XX14+1
        LDA     NEWB
        BMI     EE51

        LDA     #$20
        BIT     INWK+31
        BNE     EE28

        BPL     EE28

        ORA     INWK+31
        AND     #$3F
        STA     INWK+31
        LDA     #$00
        LDY     #$1C
        STA     (INF),Y
        LDY     #$1E
        STA     (INF),Y
        JSR     EE51

        LDY     #$01
        LDA     #$12
        STA     (XX19),Y
        LDY     #$07
        LDA     (XX0),Y
        LDY     #$02
        STA     (XX19),Y
.EE55
        INY
        JSR     DORND

        STA     (XX19),Y
        CPY     #$06
        BNE     EE55

.EE28
        LDA     INWK+8
        BPL     LL10

.LL14
        LDA     INWK+31
        AND     #$20
        BEQ     EE51

        LDA     INWK+31
        AND     #$F7
        STA     INWK+31
        JMP     DOEXP

.EE51
        LDA     #$08
        BIT     INWK+31
        BEQ     L7186

        EOR     INWK+31
        STA     INWK+31
        JMP     LL155

.L7186
        RTS

.LL10
        LDA     INWK+7
        CMP     #$C0
        BCS     LL14

        LDA     INWK
        CMP     INWK+6
        LDA     INWK+1
        SBC     INWK+7
        BCS     LL14

        LDA     INWK+3
        CMP     INWK+6
        LDA     INWK+4
        SBC     INWK+7
        BCS     LL14

        LDY     #$06
        LDA     (XX0),Y
        TAX
        LDA     #$FF
        STA     XX3,X
        STA     XX3+1,X
        LDA     INWK+6
        STA     T
        LDA     INWK+7
        LSR     A
        ROR     T
        LSR     A
        ROR     T
        LSR     A
        ROR     T
        LSR     A
        BNE     LL13

        LDA     T
        ROR     A
        LSR     A
        LSR     A
        LSR     A
        STA     XX4
        BPL     LL17

.LL13
        LDY     #$0D
        LDA     (XX0),Y
        CMP     INWK+7
        BCS     LL17

        LDA     #$20
        AND     INWK+31
        BNE     LL17

        JMP     SHPPT

.LL17
        LDX     #$05
.LL15
        LDA     INWK+21,X
        STA     XX16,X
        LDA     INWK+15,X
        STA     XX16+6,X
        LDA     INWK+9,X
        STA     XX16+12,X
        DEX
        BPL     LL15

        LDA     #$C5
        STA     Q
        LDY     #$10
.LL21
        LDA     XX16,Y
        ASL     A
        LDA     XX16+1,Y
        ROL     A
        JSR     LL28

        LDX     R
        STX     XX16,Y
        DEY
        DEY
        BPL     LL21

        LDX     #$08
.ll91_lc
        LDA     INWK,X
        STA     XX18,X
        DEX
        BPL     ll91_lc

        LDA     #$FF
        STA     K4+1
        LDY     #$0C
        LDA     INWK+31
        AND     #$20
        BEQ     EE29

        LDA     (XX0),Y
        LSR     A
        LSR     A
        TAX
        LDA     #$FF
.EE30
        STA     K3,X
        DEX
        BPL     EE30

        INX
        STX     XX4
.LL41
        JMP     LL42

.EE29
        LDA     (XX0),Y
        BEQ     LL41

        STA     XX20
        LDY     #$12
        LDA     (XX0),Y
        TAX
        LDA     XX18+7
        TAY
        BEQ     LL91

.L723C
        INX
        LSR     XX18+4
        ROR     XX18+3
        LSR     XX18+1
        ROR     XX18
        LSR     A
        ROR     XX18+6
        TAY
        BNE     L723C

.LL91
        STX     XX17
        LDA     XX18+8
        STA     XX15+5
        LDA     XX18
        STA     XX15
        LDA     XX18+2
        STA     Y1
        LDA     XX18+3
        STA     X2
        LDA     XX18+5
        STA     Y2
        LDA     XX18+6
        STA     XX15+4
        JSR     LL51

        LDA     XX12
        STA     XX18
        LDA     XX12+1
        STA     XX18+2
        LDA     XX12+2
        STA     XX18+3
        LDA     XX12+3
        STA     XX18+5
        LDA     XX12+4
        STA     XX18+6
        LDA     XX12+5
        STA     XX18+8
        LDY     #$04
        LDA     (XX0),Y
        CLC
        ADC     XX0
        STA     V
        LDY     #$11
        LDA     (XX0),Y
        ADC     XX0+1
        STA     V+1
        LDY     #$00
.LL86
        LDA     (V),Y
        STA     XX12+1
        AND     #$1F
        CMP     XX4
        BCS     LL87

        TYA
        LSR     A
        LSR     A
        TAX
        LDA     #$FF
        STA     K3,X
        TYA
        ADC     #$04
        TAY
        JMP     LL88

.LL87
        LDA     XX12+1
        ASL     A
        STA     XX12+3
        ASL     A
        STA     XX12+5
        INY
        LDA     (V),Y
        STA     XX12
        INY
        LDA     (V),Y
        STA     XX12+2
        INY
        LDA     (V),Y
        STA     XX12+4
        LDX     XX17
        CPX     #$04
        BCC     LL92

        LDA     XX18
        STA     XX15
        LDA     XX18+2
        STA     Y1
        LDA     XX18+3
        STA     X2
        LDA     XX18+5
        STA     Y2
        LDA     XX18+6
        STA     XX15+4
        LDA     XX18+8
        STA     XX15+5
        JMP     LL89

.ovflw
        LSR     XX18
        LSR     XX18+6
        LSR     XX18+3
        LDX     #$01
.LL92
        LDA     XX12
        STA     XX15
        LDA     XX12+2
        STA     X2
        LDA     XX12+4
        DEX
        BMI     LL94

.L72F9
        LSR     XX15
        LSR     X2
        LSR     A
        DEX
        BPL     L72F9

.LL94
        STA     R
        LDA     XX12+5
        STA     S
        LDA     XX18+6
        STA     Q
        LDA     XX18+8
        JSR     LL38

        BCS     ovflw

        STA     XX15+4
        LDA     S
        STA     XX15+5
        LDA     XX15
        STA     R
        LDA     XX12+1
        STA     S
        LDA     XX18
        STA     Q
        LDA     XX18+2
        JSR     LL38

        BCS     ovflw

        STA     XX15
        LDA     S
        STA     Y1
        LDA     X2
        STA     R
        LDA     XX12+3
        STA     S
        LDA     XX18+3
        STA     Q
        LDA     XX18+5
        JSR     LL38

        BCS     ovflw

        STA     X2
        LDA     S
        STA     Y2
.LL89
        LDA     XX12
        STA     Q
        LDA     XX15
        JSR     FMLTU

        STA     T
        LDA     XX12+1
        EOR     Y1
        STA     S
        LDA     XX12+2
        STA     Q
        LDA     X2
        JSR     FMLTU

        STA     Q
        LDA     T
        STA     R
        LDA     XX12+3
        EOR     Y2
        JSR     LL38

        STA     T
        LDA     XX12+4
        STA     Q
        LDA     XX15+4
        JSR     FMLTU

        STA     Q
        LDA     T
        STA     R
        LDA     XX15+5
        EOR     XX12+5
        JSR     LL38

        PHA
        TYA
        LSR     A
        LSR     A
        TAX
        PLA
        BIT     S
        BMI     L7395

        LDA     #$00
.L7395
        STA     K3,X
        INY
.LL88
        CPY     XX20
        BCS     LL42

        JMP     LL86

.LL42
        LDY     XX16+2
        LDX     XX16+3
        LDA     XX16+6
        STA     XX16+2
        LDA     XX16+7
        STA     XX16+3
        STY     XX16+6
        STX     XX16+7
        LDY     XX16+4
        LDX     XX16+5
        LDA     XX16+12
        STA     XX16+4
        LDA     XX16+13
        STA     XX16+5
        STY     XX16+12
        STX     XX16+13
        LDY     XX16+10
        LDX     XX16+11
        LDA     XX16+14
        STA     XX16+10
        LDA     XX16+15
        STA     XX16+11
        STY     XX16+14
        STX     XX16+15
        LDY     #$08
        LDA     (XX0),Y
        STA     XX20
        LDA     XX0
        CLC
        ADC     #$14
        STA     V
        LDA     XX0+1
        ADC     #$00
        STA     V+1
        LDY     #$00
        STY     CNT
.LL48
        STY     XX17
        LDA     (V),Y
        STA     XX15
        INY
        LDA     (V),Y
        STA     X2
        INY
        LDA     (V),Y
        STA     XX15+4
        INY
        LDA     (V),Y
        STA     T
        AND     #$1F
        CMP     XX4
        BCC     L742F

        INY
        LDA     (V),Y
        STA     P
        AND     #$0F
        TAX
        LDA     K3,X
        BNE     LL49

        LDA     P
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        TAX
        LDA     K3,X
        BNE     LL49

        INY
        LDA     (V),Y
        STA     P
        AND     #$0F
        TAX
        LDA     K3,X
        BNE     LL49

        LDA     P
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        TAX
        LDA     K3,X
        BNE     LL49

.L742F
        JMP     LL50

.LL49
        LDA     T
        STA     Y1
        ASL     A
        STA     Y2
        ASL     A
        STA     XX15+5
        JSR     LL51

        LDA     INWK+2
        STA     X2
        EOR     XX12+1
        BMI     LL52

        CLC
        LDA     XX12
        ADC     INWK
        STA     XX15
        LDA     INWK+1
        ADC     #$00
        STA     Y1
        JMP     LL53

.LL52
        LDA     INWK
        SEC
        SBC     XX12
        STA     XX15
        LDA     INWK+1
        SBC     #$00
        STA     Y1
        BCS     LL53

        EOR     #$FF
        STA     Y1
        LDA     #$01
        SBC     XX15
        STA     XX15
        BCC     L7474

        INC     Y1
.L7474
        LDA     X2
        EOR     #$80
        STA     X2
.LL53
        LDA     INWK+5
        STA     XX15+5
        EOR     XX12+3
        BMI     LL54

        CLC
        LDA     XX12+2
        ADC     INWK+3
        STA     Y2
        LDA     INWK+4
        ADC     #$00
        STA     XX15+4
        JMP     LL55

.LL54
        LDA     INWK+3
        SEC
        SBC     XX12+2
        STA     Y2
        LDA     INWK+4
        SBC     #$00
        STA     XX15+4
        BCS     LL55

        EOR     #$FF
        STA     XX15+4
        LDA     Y2
        EOR     #$FF
        ADC     #$01
        STA     Y2
        LDA     XX15+5
        EOR     #$80
        STA     XX15+5
        BCC     LL55

        INC     XX15+4
.LL55
        LDA     XX12+5
        BMI     LL56

        LDA     XX12+4
        CLC
        ADC     INWK+6
        STA     T
        LDA     INWK+7
        ADC     #$00
        STA     U
        JMP     LL57

.LL61
        LDX     Q
        BEQ     LL84

        LDX     #$00
.LL63
        LSR     A
        INX
        CMP     Q
        BCS     LL63

        STX     S
        JSR     LL28

        LDX     S
        LDA     R
.LL64
        ASL     A
        ROL     U
        BMI     LL84

        DEX
        BNE     LL64

        STA     R
        RTS

.LL84
        LDA     #$32
        STA     R
        STA     U
        RTS

.LL62
        LDA     #$80
        SEC
        SBC     R
        STA     XX3,X
        INX
        LDA     #$00
        SBC     U
        STA     XX3,X
        JMP     LL66

.LL56
        LDA     INWK+6
        SEC
        SBC     XX12+4
        STA     T
        LDA     INWK+7
        SBC     #$00
        STA     U
        BCC     LL140

        BNE     LL57

        LDA     T
        CMP     #$04
        BCS     LL57

.LL140
        LDA     #$00
        STA     U
        LDA     #$04
        STA     T
.LL57
        LDA     U
        ORA     Y1
        ORA     XX15+4
        BEQ     LL60

        LSR     Y1
        ROR     XX15
        LSR     XX15+4
        ROR     Y2
        LSR     U
        ROR     T
        JMP     LL57

.LL60
        LDA     T
        STA     Q
        LDA     XX15
        CMP     Q
        BCC     LL69

        JSR     LL61

        JMP     LL65

.LL69
        JSR     LL28

.LL65
        LDX     CNT
        LDA     X2
        BMI     LL62

        LDA     R
        CLC
        ADC     #$80
        STA     XX3,X
        INX
        LDA     U
        ADC     #$00
        STA     XX3,X
.LL66
        TXA
        PHA
        LDA     #$00
        STA     U
        LDA     T
        STA     Q
        LDA     Y2
        CMP     Q
        BCC     LL67

        JSR     LL61

        JMP     LL68

.LL70
        LDA     #$60
        CLC
        ADC     R
        STA     XX3,X
        INX
        LDA     #$00
        ADC     U
        STA     XX3,X
        JMP     LL50

.LL67
        JSR     LL28

.LL68
        PLA
        TAX
        INX
        LDA     XX15+5
        BMI     LL70

        LDA     #$60
        SEC
        SBC     R
        STA     XX3,X
        INX
        LDA     #$00
        SBC     U
        STA     XX3,X
.LL50
        CLC
        LDA     CNT
        ADC     #$04
        STA     CNT
        LDA     XX17
        ADC     #$06
        TAY
        BCS     LL72

        CMP     XX20
        BCS     LL72

        JMP     LL48

.LL72
        LDA     INWK+31
        AND     #$20
        BEQ     EE31

        LDA     INWK+31
        ORA     #$08
        STA     INWK+31
        JMP     DOEXP

.EE31
        LDY     #$09
        LDA     (XX0),Y
        STA     XX20
        LDA     #$08
        ORA     INWK+31
        STA     INWK+31
        LDY     #$00
        STY     XX17
        BIT     INWK+31
        BVC     LL170

        LDA     INWK+31
        AND     #$BF
        STA     INWK+31
        LDY     #$06
        LDA     (XX0),Y
        TAY
        LDX     XX3,Y
        STX     XX15
        INX
        BEQ     LL170

        LDX     XX3+1,Y
        STX     Y1
        INX
        BEQ     LL170

        LDX     XX3+2,Y
        STX     X2
        LDX     XX3+3,Y
        STX     Y2
        LDA     #$00
        STA     XX15+4
        STA     XX15+5
        STA     XX12+1
        LDA     INWK+6
        STA     XX12
        LDA     INWK+2
        BPL     L7616

        DEC     XX15+4
.L7616
        JSR     LL145

        BCS     LL170

        JSR     L78F8

.LL170
        LDY     #$03
        CLC
        LDA     (XX0),Y
        ADC     XX0
        STA     V
        LDY     #$10
        LDA     (XX0),Y
        ADC     XX0+1
        STA     V+1
        LDY     #$05
        LDA     (XX0),Y
        STA     CNT
.LL75
        LDY     #$00
        LDA     (V),Y
        CMP     XX4
        BCC     LL78

        INY
        LDA     (V),Y
        STA     P
        AND     #$0F
        TAX
        LDA     K3,X
        BNE     LL79

        LDA     P
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        TAX
        LDA     K3,X
        BEQ     LL78

.LL79
        INY
        LDA     (V),Y
        TAX
        LDA     XX3,X
        STA     XX15
        LDA     XX3+1,X
        STA     Y1
        LDA     XX3+2,X
        STA     X2
        LDA     XX3+3,X
        STA     Y2
        INY
        LDA     (V),Y
        TAX
        LDA     XX3,X
        STA     XX15+4
        LDA     XX3+2,X
        STA     XX12
        LDA     XX3+3,X
        STA     XX12+1
        LDA     XX3+1,X
        STA     XX15+5
        JSR     LL147

        BCS     LL78

        JSR     L78F8

.LL78
        LDA     XX14
        CMP     CNT
        BCS     LL81

        LDA     V
        CLC
        ADC     #$04
        STA     V
        BCC     ll81_lc

        INC     V+1
.ll81_lc
        INC     XX17
        LDY     XX17
        CPY     XX20
        BCC     LL75

.LL81
        JMP     LL155

.LL118
        LDA     Y1
        BPL     LL119

        STA     S
        JSR     LL120

        TXA
        CLC
        ADC     X2
        STA     X2
        TYA
        ADC     Y2
        STA     Y2
        LDA     #$00
        STA     XX15
        STA     Y1
        TAX
.LL119
        BEQ     LL134

        STA     S
        DEC     S
        JSR     LL120

        TXA
        CLC
        ADC     X2
        STA     X2
        TYA
        ADC     Y2
        STA     Y2
        LDX     #$FF
        STX     XX15
        INX
        STX     Y1
.LL134
        LDA     Y2
        BPL     LL135

        STA     S
        LDA     X2
        STA     R
        JSR     LL123

        TXA
        CLC
        ADC     XX15
        STA     XX15
        TYA
        ADC     Y1
        STA     Y1
        LDA     #$00
        STA     X2
        STA     Y2
.LL135
        LDA     X2
        SEC
        SBC     #$C0
        STA     R
        LDA     Y2
        SBC     #$00
        STA     S
        BCC     LL136

        JSR     LL123

        TXA
        CLC
        ADC     XX15
        STA     XX15
        TYA
        ADC     Y1
        STA     Y1
        LDA     #$BF
        STA     X2
        LDA     #$00
        STA     Y2
.LL136
        RTS

.LL120
        LDA     XX15
        STA     R
        JSR     LL129

        PHA
        LDX     T
        BNE     LL121

.LL122
        LDA     #$00
        TAX
        TAY
        LSR     S
        ROR     R
        ASL     Q
        BCC     LL126

.LL125
        TXA
        CLC
        ADC     R
        TAX
        TYA
        ADC     S
        TAY
.LL126
        LSR     S
        ROR     R
        ASL     Q
        BCS     LL125

        BNE     LL126

        PLA
        BPL     LL133

        RTS

.LL123
        JSR     LL129

        PHA
        LDX     T
        BNE     LL122

.LL121
        LDA     #$FF
        TAY
        ASL     A
        TAX
.LL130
        ASL     R
        ROL     S
        LDA     S
        BCS     LL131

        CMP     Q
        BCC     LL132

.LL131
        SBC     Q
        STA     S
        LDA     R
        SBC     #$00
        STA     R
        SEC
.LL132
        TXA
        ROL     A
        TAX
        TYA
        ROL     A
        TAY
        BCS     LL130

        PLA
        BMI     LL128

.LL133
        TXA
        EOR     #$FF
        ADC     #$01
        TAX
        TYA
        EOR     #$FF
        ADC     #$00
        TAY
.LL128
        RTS

.LL129
        LDX     XX12+2
        STX     Q
        LDA     S
        BPL     LL127

        LDA     #$00
        SEC
        SBC     R
        STA     R
        LDA     S
        PHA
        EOR     #$FF
        ADC     #$00
        STA     S
        PLA
.LL127
        EOR     XX12+3
        RTS

.LL145
        LDA     #$00
        STA     SWAP
        LDA     XX15+5
.LL147
        LDX     #$BF
        ORA     XX12+1
        BNE     LL107

        CPX     XX12
        BCC     LL107

        LDX     #$00
.LL107
        STX     XX13
        LDA     Y1
        ORA     Y2
        BNE     LL83

        LDA     #$BF
        CMP     X2
        BCC     LL83

        LDA     XX13
        BNE     LL108

.LL146
        LDA     X2
        STA     Y1
        LDA     XX15+4
        STA     X2
        LDA     XX12
        STA     Y2
        CLC
        RTS

.LL109
        SEC
        RTS

.LL108
        LSR     XX13
.LL83
        LDA     XX13
        BPL     LL115

        LDA     Y1
        AND     XX15+5
        BMI     LL109

        LDA     Y2
        AND     XX12+1
        BMI     LL109

        LDX     Y1
        DEX
        TXA
        LDX     XX15+5
        DEX
        STX     XX12+2
        ORA     XX12+2
        BPL     LL109

        LDA     X2
        CMP     #$C0
        LDA     Y2
        SBC     #$00
        STA     XX12+2
        LDA     XX12
        CMP     #$C0
        LDA     XX12+1
        SBC     #$00
        ORA     XX12+2
        BPL     LL109

.LL115
        TYA
        PHA
        LDA     XX15+4
        SEC
        SBC     XX15
        STA     XX12+2
        LDA     XX15+5
        SBC     Y1
        STA     XX12+3
        LDA     XX12
        SEC
        SBC     X2
        STA     XX12+4
        LDA     XX12+1
        SBC     Y2
        STA     XX12+5
        EOR     XX12+3
        STA     S
        LDA     XX12+5
        BPL     LL110

        LDA     #$00
        SEC
        SBC     XX12+4
        STA     XX12+4
        LDA     #$00
        SBC     XX12+5
        STA     XX12+5
.LL110
        LDA     XX12+3
        BPL     LL111

        SEC
        LDA     #$00
        SBC     XX12+2
        STA     XX12+2
        LDA     #$00
        SBC     XX12+3
.LL111
        TAX
        BNE     LL112

        LDX     XX12+5
        BEQ     LL113

.LL112
        LSR     A
        ROR     XX12+2
        LSR     XX12+5
        ROR     XX12+4
        JMP     LL111

.LL113
        STX     T
        LDA     XX12+2
        CMP     XX12+4
        BCC     LL114

        STA     Q
        LDA     XX12+4
        JSR     LL28

        JMP     LL116

.LL114
        LDA     XX12+4
        STA     Q
        LDA     XX12+2
        JSR     LL28

        DEC     T
.LL116
        LDA     R
        STA     XX12+2
        LDA     S
        STA     XX12+3
        LDA     XX13
        BEQ     LL138

        BPL     LLX117

.LL138
        JSR     LL118

        LDA     XX13
        BPL     LL124

        LDA     Y1
        ORA     Y2
        BNE     LL137

        LDA     X2
        CMP     #$C0
        BCS     LL137

.LLX117
        LDX     XX15
        LDA     XX15+4
        STA     XX15
        STX     XX15+4
        LDA     XX15+5
        LDX     Y1
        STX     XX15+5
        STA     Y1
        LDX     X2
        LDA     XX12
        STA     X2
        STX     XX12
        LDA     XX12+1
        LDX     Y2
        STX     XX12+1
        STA     Y2
        JSR     LL118

        DEC     SWAP
.LL124
        PLA
        TAY
        JMP     LL146

.LL137
        PLA
        TAY
        SEC
        RTS

.LL155
        LDY     XX14
.L78D3
        CPY     XX14+1
        BCS     L78F1

        LDA     (XX19),Y
        INY
        STA     XX15
        LDA     (XX19),Y
        INY
        STA     Y1
        LDA     (XX19),Y
        INY
        STA     X2
        LDA     (XX19),Y
        INY
        STA     Y2
        JSR     LL30

        JMP     L78D3

.L78F1
        LDA     XX14
        LDY     #$00
        STA     (XX19),Y
.L78F7
        RTS

.L78F8
        LDY     XX14
        CPY     XX14+1
        PHP
        LDX     #$03
.L78FF
        LDA     XX15,X
        STA     XX12,X
        DEX
        BPL     L78FF

        JSR     LL30

        LDA     (XX19),Y
        STA     XX15
        LDA     XX12
        STA     (XX19),Y
        INY
        LDA     (XX19),Y
        STA     Y1
        LDA     XX12+1
        STA     (XX19),Y
        INY
        LDA     (XX19),Y
        STA     X2
        LDA     XX12+2
        STA     (XX19),Y
        INY
        LDA     (XX19),Y
        STA     Y2
        LDA     XX12+3
        STA     (XX19),Y
        INY
        STY     XX14
        PLP
        BCS     L78F7

        JMP     LL30

.MVEIT
        LDA     INWK+31
        AND     #$A0
        BNE     MV30

        LDA     MCNT
        EOR     XSAV
        AND     #$0F
        BNE     MV3

        JSR     TIDY

.MV3
        LDX     TYPE
        BPL     L794D

        JMP     MV40

.L794D
        LDA     INWK+32
        BPL     MV30

        CPX     #$01
        BEQ     MV26

        LDA     MCNT
        EOR     XSAV
        AND     #$07
        BNE     MV30

.MV26
        JSR     TACTICS

.MV30
        JSR     SCAN

        LDA     INWK+27
        ASL     A
        ASL     A
        STA     Q
        LDA     INWK+10
        AND     #$7F
        JSR     FMLTU

        STA     R
        LDA     INWK+10
        LDX     #$00
        JSR     L7ADF

        LDA     INWK+12
        AND     #$7F
        JSR     FMLTU

        STA     R
        LDA     INWK+12
        LDX     #$03
        JSR     L7ADF

        LDA     INWK+14
        AND     #$7F
        JSR     FMLTU

        STA     R
        LDA     INWK+14
        LDX     #$06
        JSR     L7ADF

        LDA     INWK+27
        CLC
        ADC     INWK+28
        BPL     L79A2

        LDA     #$00
.L79A2
        LDY     #$0F
        CMP     (XX0),Y
        BCC     L79AA

        LDA     (XX0),Y
.L79AA
        STA     INWK+27
        LDA     #$00
        STA     INWK+28
        LDX     ALP1
        LDA     INWK
        EOR     #$FF
        STA     P
        LDA     INWK+1
        JSR     L45BE

        STA     P+2
        LDA     ALP2+1
        EOR     INWK+2
        LDX     #$03
        JSR     MVT6

        STA     K2+3
        LDA     P+1
        STA     K2+1
        EOR     #$FF
        STA     P
        LDA     P+2
        STA     K2+2
        LDX     BET1
        JSR     L45BE

        STA     P+2
        LDA     K2+3
        EOR     BET2
        LDX     #$06
        JSR     MVT6

        STA     INWK+8
        LDA     P+1
        STA     INWK+6
        EOR     #$FF
        STA     P
        LDA     P+2
        STA     INWK+7
        JSR     MLTU2

        STA     P+2
        LDA     K2+3
        STA     INWK+5
        EOR     BET2
        EOR     INWK+8
        BPL     MV43

        LDA     P+1
        ADC     K2+1
        STA     INWK+3
        LDA     P+2
        ADC     K2+2
        STA     INWK+4
        JMP     MV44

.MV43
        LDA     K2+1
        SBC     P+1
        STA     INWK+3
        LDA     K2+2
        SBC     P+2
        STA     INWK+4
        BCS     MV44

        LDA     #$01
        SBC     INWK+3
        STA     INWK+3
        LDA     #$00
        SBC     INWK+4
        STA     INWK+4
        LDA     INWK+5
        EOR     #$80
        STA     INWK+5
.MV44
        LDX     ALP1
        LDA     INWK+3
        EOR     #$FF
        STA     P
        LDA     INWK+4
        JSR     L45BE

        STA     P+2
        LDA     ALP2
        EOR     INWK+5
        LDX     #$00
        JSR     MVT6

        STA     INWK+2
        LDA     P+2
        STA     INWK+1
        LDA     P+1
        STA     INWK
.MV45
        LDA     DELTA
        STA     R
        LDA     #$80
        LDX     #$06
        JSR     MVT1

        LDA     TYPE
        AND     #$81
        CMP     #$81
        BNE     L7A68

        RTS

.L7A68
        LDY     #$09
        JSR     MVS4

        LDY     #$0F
        JSR     MVS4

        LDY     #$15
        JSR     MVS4

        LDA     INWK+30
        AND     #$80
        STA     RAT2
        LDA     INWK+30
        AND     #$7F
        BEQ     MV8

        CMP     #$7F
        SBC     #$00
        ORA     RAT2
        STA     INWK+30
        LDX     #$0F
        LDY     #$09
        JSR     MVS5

        LDX     #$11
        LDY     #$0B
        JSR     MVS5

        LDX     #$13
        LDY     #$0D
        JSR     MVS5

.MV8
        LDA     INWK+29
        AND     #$80
        STA     RAT2
        LDA     INWK+29
        AND     #$7F
        BEQ     MV5

        CMP     #$7F
        SBC     #$00
        ORA     RAT2
        STA     INWK+29
        LDX     #$0F
        LDY     #$15
        JSR     MVS5

        LDX     #$11
        LDY     #$17
        JSR     MVS5

        LDX     #$13
        LDY     #$19
        JSR     MVS5

.MV5
        LDA     INWK+31
        AND     #$A0
        BNE     MVD1

        LDA     INWK+31
        ORA     #$10
        STA     INWK+31
        JMP     SCAN

.MVD1
        LDA     INWK+31
        AND     #$EF
        STA     INWK+31
        RTS

.L7ADF
        AND     #$80
.MVT1
        ASL     A
        STA     S
        LDA     #$00
        ROR     A
        STA     T
        LSR     S
        EOR     INWK+2,X
        BMI     MV10

        LDA     R
        ADC     INWK,X
        STA     INWK,X
        LDA     S
        ADC     INWK+1,X
        STA     INWK+1,X
        LDA     INWK+2,X
        ADC     #$00
        ORA     T
        STA     INWK+2,X
        RTS

.MV10
        LDA     INWK,X
        SEC
        SBC     R
        STA     INWK,X
        LDA     INWK+1,X
        SBC     S
        STA     INWK+1,X
        LDA     INWK+2,X
        AND     #$7F
        SBC     #$00
        ORA     #$80
        EOR     T
        STA     INWK+2,X
        BCS     MV11

        LDA     #$01
        SBC     INWK,X
        STA     INWK,X
        LDA     #$00
        SBC     INWK+1,X
        STA     INWK+1,X
        LDA     #$00
        SBC     INWK+2,X
        AND     #$7F
        ORA     T
        STA     INWK+2,X
.MV11
        RTS

.MVS4
        LDA     ALPHA
        STA     Q
        LDX     INWK+2,Y
        STX     R
        LDX     INWK+3,Y
        STX     S
        LDX     INWK,Y
        STX     P
        LDA     INWK+1,Y
        EOR     #$80
        JSR     MAD

        STA     INWK+3,Y
        STX     INWK+2,Y
        STX     P
        LDX     INWK,Y
        STX     R
        LDX     INWK+1,Y
        STX     S
        LDA     INWK+3,Y
        JSR     MAD

        STA     INWK+1,Y
        STX     INWK,Y
        STX     P
        LDA     BETA
        STA     Q
        LDX     INWK+2,Y
        STX     R
        LDX     INWK+3,Y
        STX     S
        LDX     INWK+4,Y
        STX     P
        LDA     INWK+5,Y
        EOR     #$80
        JSR     MAD

        STA     INWK+3,Y
        STX     INWK+2,Y
        STX     P
        LDX     INWK+4,Y
        STX     R
        LDX     INWK+5,Y
        STX     S
        LDA     INWK+3,Y
        JSR     MAD

        STA     INWK+5,Y
        STX     INWK+4,Y
        RTS

.MVT6
        TAY
        EOR     INWK+2,X
        BMI     MV50

        LDA     P+1
        CLC
        ADC     INWK,X
        STA     P+1
        LDA     P+2
        ADC     INWK+1,X
        STA     P+2
        TYA
        RTS

.MV50
        LDA     INWK,X
        SEC
        SBC     P+1
        STA     P+1
        LDA     INWK+1,X
        SBC     P+2
        STA     P+2
        BCC     MV51

        TYA
        EOR     #$80
        RTS

.MV51
        LDA     #$01
        SBC     P+1
        STA     P+1
        LDA     #$00
        SBC     P+2
        STA     P+2
        TYA
        RTS

.MV40
        LDA     ALPHA
        EOR     #$80
        STA     Q
        LDA     INWK
        STA     P
        LDA     INWK+1
        STA     P+1
        LDA     INWK+2
        JSR     MULT3

        LDX     #$03
        JSR     MVT3

        LDA     K+1
        STA     K2+1
        STA     P
        LDA     K+2
        STA     K2+2
        STA     P+1
        LDA     BETA
        STA     Q
        LDA     K+3
        STA     K2+3
        JSR     MULT3

        LDX     #$06
        JSR     MVT3

        LDA     K+1
        STA     P
        STA     INWK+6
        LDA     K+2
        STA     P+1
        STA     INWK+7
        LDA     K+3
        STA     INWK+8
        EOR     #$80
        JSR     MULT3

        LDA     K+3
        AND     #$80
        STA     T
        EOR     K2+3
        BMI     MV1

        LDA     K
        CLC
        ADC     K2
        LDA     K+1
        ADC     K2+1
        STA     INWK+3
        LDA     K+2
        ADC     K2+2
        STA     INWK+4
        LDA     K+3
        ADC     K2+3
        JMP     MV2

.MV1
        LDA     K
        SEC
        SBC     K2
        LDA     K+1
        SBC     K2+1
        STA     INWK+3
        LDA     K+2
        SBC     K2+2
        STA     INWK+4
        LDA     K2+3
        AND     #$7F
        STA     P
        LDA     K+3
        AND     #$7F
        SBC     P
        STA     P
        BCS     MV2

        LDA     #$01
        SBC     INWK+3
        STA     INWK+3
        LDA     #$00
        SBC     INWK+4
        STA     INWK+4
        LDA     #$00
        SBC     P
        ORA     #$80
.MV2
        EOR     T
        STA     INWK+5
        LDA     ALPHA
        STA     Q
        LDA     INWK+3
        STA     P
        LDA     INWK+4
        STA     P+1
        LDA     INWK+5
        JSR     MULT3

        LDX     #$00
        JSR     MVT3

        LDA     K+1
        STA     INWK
        LDA     K+2
        STA     INWK+1
        LDA     K+3
        STA     INWK+2
        JMP     MV45

.PLUT
        LDX     VIEW
        BEQ     L7CD1

        DEX
        BNE     PU2

        LDA     INWK+2
        EOR     #$80
        STA     INWK+2
        LDA     INWK+8
        EOR     #$80
        STA     INWK+8
        LDA     INWK+10
        EOR     #$80
        STA     INWK+10
        LDA     INWK+14
        EOR     #$80
        STA     INWK+14
        LDA     INWK+16
        EOR     #$80
        STA     INWK+16
        LDA     INWK+20
        EOR     #$80
        STA     INWK+20
        LDA     INWK+22
        EOR     #$80
        STA     INWK+22
        LDA     INWK+26
        EOR     #$80
        STA     INWK+26
.L7CD1
        RTS

.PU2
        LDA     #$00
        CPX     #$02
        ROR     A
        STA     RAT2
        EOR     #$80
        STA     RAT
        LDA     INWK
        LDX     INWK+6
        STA     INWK+6
        STX     INWK
        LDA     INWK+1
        LDX     INWK+7
        STA     INWK+7
        STX     INWK+1
        LDA     INWK+2
        EOR     RAT
        TAX
        LDA     INWK+8
        EOR     RAT2
        STA     INWK+2
        STX     INWK+8
        LDY     #$09
        JSR     PUS1

        LDY     #$0F
        JSR     PUS1

        LDY     #$15
.PUS1
        LDA     INWK,Y
        LDX     INWK+4,Y
        STA     INWK+4,Y
        STX     INWK,Y
        LDA     INWK+1,Y
        EOR     RAT
        TAX
        LDA     INWK+5,Y
        EOR     RAT2
        STA     INWK+1,Y
        STX     INWK+5,Y
.LO2
        RTS

.LQ
        STX     VIEW
        JSR     TT66

        JSR     SIGHT

        LDA     BOMB
        BPL     L7D32

        JSR     L31AC

.L7D32
        JMP     NWSTARS

.LOOK1
        LDA     #$00
        JSR     DOVDU19

        LDY     QQ11
        BNE     LQ

        CPX     VIEW
        BEQ     LO2

        STX     VIEW
        JSR     TT66

        JSR     FLIP

        LDA     BOMB
        BPL     L7D54

        JSR     L31AC

.L7D54
        JSR     WPSHPS

.SIGHT
        LDY     VIEW
        LDA     LASER,Y
        BEQ     LO2

        LDY     #$00
        CMP     #$0F
        BEQ     L7D70

        INY
        CMP     #$8F
        BEQ     L7D70

        INY
        CMP     #$97
        BEQ     L7D70

        INY
.L7D70
        LDA     L7D8B,Y
        STA     COL
        LDA     #$80
        STA     QQ19
        LDA     #$48
        STA     QQ19+1
        LDA     #$14
        STA     QQ19+2
        JSR     TT15

        LDA     #$0A
        STA     QQ19+2
        JMP     TT15

.L7D8B
        EQUB    $0F

        EQUB    $FF,$FF,$0F

        EQUB    $FA

        EQUB    $FA,$FA,$FA

.TT66
        STA     QQ11
        JSR     TTX66

        JSR     MT2

        LDA     #$00
        STA     LSP
        LDA     #$80
        STA     QQ17
        STA     DTW2
        JSR     FLFLLS

        LDA     #$00
        STA     LAS2
        STA     DLY
        STA     de
        LDX     QQ22+1
        BEQ     OLDBOX

        JSR     ee3_lc

.OLDBOX
        LDA     QQ11
        BNE     tt66_lc

        LDA     #$0B
        STA     XC
        LDA     #$FF
        STA     COL
        LDA     VIEW
        ORA     #$60
        JSR     TT27

        JSR     TT162

        LDA     #$AF
        JSR     TT27

.tt66_lc
        LDX     #$00
        STX     QQ17
        RTS

.L7DDC
        EQUB    $00

        EQUB    $40,$FE,$A0,$5F,$8C,$43,$FE,$8E
        EQUB    $4F,$FE,$EA,$AE,$4F,$FE,$60,$51
        EQUB    $33,$34,$35,$84,$38,$87,$2D,$5E
        EQUB    $8C,$36,$37,$BC,$00,$FC,$60,$80
        EQUB    $57,$45,$54,$37,$49,$39,$30,$5F
        EQUB    $8E,$38,$39,$BC,$00,$FD,$60,$31
        EQUB    $32,$44,$52,$36,$55,$4F,$50,$5B
        EQUB    $8F,$81,$82,$0D,$4C,$20,$02,$01
        EQUB    $41,$58,$46,$59,$4A,$4B,$40,$3A
        EQUB    $0D,$83,$7F,$AE,$4C,$FE,$FD,$02
        EQUB    $53,$43,$47,$48,$4E,$4C,$3B,$5D
        EQUB    $7F,$85,$84,$86,$4C,$FA,$00,$00
        EQUB    $5A,$20,$56,$42,$4D,$2C,$2E,$2F
        EQUB    $8B,$30,$31,$33,$00,$00,$00,$1B
        EQUB    $81,$82,$83,$85,$86,$88,$89,$5C
        EQUB    $8D,$34,$35,$32,$2C,$4E,$E3

.KYTB
        EQUB    $22,$23,$35,$37,$41,$42,$45,$51
        EQUB    $52,$60,$62,$65,$66,$67,$68,$70
        EQUB    $F0

.RDKEY_REAL
        JSR     U%

        LDA     #$10
        CLC
.L7E73
        LDY     #$03
        SEI
        STY     LFE40
        LDY     #$7F
        STY     LFE43
        STA     LFE4F
        LDY     LFE4F
        LDA     #$0B
        STA     LFE40
        CLI
        TYA
        BMI     DKS1

.L7E8D
        ADC     #$01
        BPL     L7E73

        CLD
        LDA     L00CB
        EOR     #$FF
        AND     KY19
        STA     KY19
        LDA     KL
        TAX
        RTS

.DKS1
        EOR     #$80
        STA     KL
.L7EA2
        CMP     KYTB,X
        BCC     L7E8D

        BEQ     L7EAC

        INX
        BNE     L7EA2

.L7EAC
        DEC     KY17,X
        INX
        CLC
        BCC     L7E8D

.CTRL
        LDA     #$01
.DKS4
        LDX     #$03
        SEI
        STX     LFE40
        LDX     #$7F
        STX     LFE43
        STA     LFE4F
        LDX     LFE4F
        LDA     #$0B
        STA     LFE40
        CLI
        TXA
        RTS

.U%
        LDA     #$00
        LDX     #$11
.DKL3
        STA     JSTY,X
        DEX
        BNE     DKL3

        RTS

.L7ED7
        SED
.RDKEY
        TYA
        PHA
        JSR     RDKEY_REAL

        PLA
        TAY
        LDA     L7DDC,X
        STA     KL
        TAX
        RTS

.L7EE6
        RTS

.ECMOF
        LDA     #$00
        STA     ECMA
        STA     ECMP
        JMP     ECBLB

.SFRMIS
        LDX     #$01
        JSR     L42A8

        BCC     L7EE6

        LDA     #$78
        JSR     MESS

        LDY     #$08
        JMP     NOISE

.EXNO2
        LDA     L1266
        CLC
        ADC     L8062,X
        STA     L1266
        LDA     TALLY
        ADC     L8083,X
        STA     TALLY
        BCC     EXNO3

        INC     TALLY+1
        LDA     #$65
        JSR     MESS

.EXNO3
        LDY     #$04
        JMP     NOISE

.EXNO
        LDY     #$06
        JMP     NOISE

.BRKBK
        LDA     #$B9
        STA     BRKV
        LDA     #$66
        STA     BRKV+1
        LDA     #$85
        STA     WRCHV
        LDA     #$20
        STA     WRCHV+1
        JSR     MASTER_MOVE_ZP_3000

        JSR     STARTUP

        JMP     L1377

        CLI
        RTI

.BeebDisEndAddr




\ ******************************************************************************
\
\ Save output/BCODE.unprot.bin
\
\ ******************************************************************************

CODE% = &1300
LOAD% = &1300
PRINT "S.BCODE ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
SAVE "versions/master/output/BCODE.unprot.bin", CODE%, P%, LOAD%

