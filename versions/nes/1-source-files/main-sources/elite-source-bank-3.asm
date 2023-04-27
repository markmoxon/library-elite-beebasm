\ ******************************************************************************
\
\ NES ELITE GAME SOURCE (BANK 3)
\
\ NES Elite was written by Ian Bell and David Braben and is copyright D. Braben
\ and I. Bell 1992
\
\ The code on this site has been reconstructed from a disassembly of the version
\ released on Ian Bell's personal website at http://www.elitehomepage.org/
\
\ The commentary is copyright Mark Moxon, and any misunderstandings or mistakes
\ in the documentation are entirely my fault
\
\ The terminology and notations used in this commentary are explained at
\ https://www.bbcelite.com/about_site/terminology_used_in_this_commentary.html
\
\ The deep dive articles referred to in this commentary can be found at
\ https://www.bbcelite.com/deep_dives
\
\ ------------------------------------------------------------------------------
\
\ This source file produces the following binary file:
\
\   * bank3.bin
\
\ ******************************************************************************

 INCLUDE "versions/nes/1-source-files/main-sources/elite-build-options.asm"

 _CASSETTE_VERSION      = (_VERSION = 1)
 _DISC_VERSION          = (_VERSION = 2)
 _6502SP_VERSION        = (_VERSION = 3)
 _MASTER_VERSION        = (_VERSION = 4)
 _ELECTRON_VERSION      = (_VERSION = 5)
 _ELITE_A_VERSION       = (_VERSION = 6)
 _NES_VERSION           = (_VERSION = 7)
 _C64_VERSION           = (_VERSION = 8)
 _APPLE_VERSION         = (_VERSION = 9)
 _NTSC                  = (_VARIANT = 1)
 _PAL                   = (_VARIANT = 2)
 _DISC_DOCKED           = FALSE
 _DISC_FLIGHT           = FALSE
 _ELITE_A_DOCKED        = FALSE
 _ELITE_A_FLIGHT        = FALSE
 _ELITE_A_SHIPS_R       = FALSE
 _ELITE_A_SHIPS_S       = FALSE
 _ELITE_A_SHIPS_T       = FALSE
 _ELITE_A_SHIPS_U       = FALSE
 _ELITE_A_SHIPS_V       = FALSE
 _ELITE_A_SHIPS_W       = FALSE
 _ELITE_A_ENCYCLOPEDIA  = FALSE
 _ELITE_A_6502SP_IO     = FALSE
 _ELITE_A_6502SP_PARA   = FALSE

CODE% = &8000
LOAD% = &8000

; Memory locations
ZP                = &0000
RAND              = &0002
RAND_1            = &0002
RAND_2            = &0003
RAND_3            = &0004
T1                = &0006
SC                = &0007
SC_1              = &0008
INWK              = &0009
XX1               = &0009
INWK_1            = &000A
INWK_2            = &000B
INWK_3            = &000C
INWK_4            = &000D
INWK_5            = &000E
INWK_6            = &000F
INWK_7            = &0010
INWK_8            = &0011
INWK_9            = &0012
INWK_10           = &0013
INWK_11           = &0014
INWK_12           = &0015
INWK_13           = &0016
INWK_14           = &0017
INWK_15           = &0018
INWK_16           = &0019
INWK_17           = &001A
INWK_18           = &001B
INWK_19           = &001C
INWK_20           = &001D
INWK_21           = &001E
INWK_22           = &001F
INWK_23           = &0020
INWK_24           = &0021
INWK_25           = &0022
INWK_26           = &0023
INWK_27           = &0024
INWK_28           = &0025
INWK_29           = &0026
INWK_30           = &0027
INWK_31           = &0028
INWK_32           = &0029
INWK_33           = &002A
INWK_34           = &002B
INWK_35           = &002C
NEWB              = &002D
P                 = &002F
P_1               = &0030
P_2               = &0031
XC                = &0032
L0033             = &0033
L0034             = &0034
L0035             = &0035
L0036             = &0036
YC                = &003B
QQ17              = &003C
K3                = &003D
XX2               = &003D
XX2_1             = &003E
XX2_2             = &003F
XX2_3             = &0040
XX2_4             = &0041
XX2_5             = &0042
XX2_6             = &0043
XX2_7             = &0044
XX2_8             = &0045
XX2_9             = &0046
XX2_10            = &0047
XX2_11            = &0048
XX2_12            = &0049
XX2_13            = &004A
K4                = &004B
K4_1              = &004C
XX16              = &004D
XX16_1            = &004E
XX16_2            = &004F
XX16_3            = &0050
XX16_4            = &0051
XX16_5            = &0052
XX16_6            = &0053
XX16_7            = &0054
XX16_8            = &0055
XX16_9            = &0056
XX16_10           = &0057
XX16_11           = &0058
XX16_12           = &0059
XX16_13           = &005A
XX16_14           = &005B
XX16_15           = &005C
XX16_16           = &005D
XX16_17           = &005E
XX0               = &005F
XX0_1             = &0060
INF               = &0061
XX19              = &0061
INF_1             = &0062
V                 = &0063
V_1               = &0064
XX                = &0065
XX_1              = &0066
YY                = &0067
YY_1              = &0068
BETA              = &0069
BET1              = &006A
L006C             = &006C
ECMA              = &006D
ALP1              = &006E
ALP2              = &006F
ALP2_1            = &0070
X1                = &0071
XX15              = &0071
Y1                = &0072
X2                = &0073
Y2                = &0074
XX15_4            = &0075
XX15_5            = &0076
XX12              = &0077
XX12_1            = &0078
XX12_2            = &0079
XX12_3            = &007A
XX12_4            = &007B
XX12_5            = &007C
K                 = &007D
K_1               = &007E
K_2               = &007F
K_3               = &0080
QQ15              = &0082
QQ15_1            = &0083
QQ15_2            = &0084
QQ15_3            = &0085
QQ15_4            = &0086
QQ15_5            = &0087
K5                = &0088
XX18              = &0088
XX18_1            = &0089
XX18_2            = &008A
XX18_3            = &008B
K6                = &008C
K6_1              = &008D
K6_2              = &008E
K6_3              = &008F
K6_4              = &0090
BET2              = &0091
BET2_1            = &0092
DELTA             = &0093
DELT4             = &0094
DELT4_1           = &0095
U                 = &0096
Q                 = &0097
R                 = &0098
S                 = &0099
T                 = &009A
XSAV              = &009B
YSAV              = &009C
XX17              = &009D
W                 = &009E
QQ11              = &009F
ZZ                = &00A0
XX13              = &00A1
MCNT              = &00A2
TYPE              = &00A3
ALPHA             = &00A4
QQ12              = &00A5
TGT               = &00A6
FLAG              = &00A7
CNT               = &00A8
CNT2              = &00A9
STP               = &00AA
XX4               = &00AB
XX20              = &00AC
RAT               = &00AE
RAT2              = &00AF
widget            = &00B0
Yx1M2             = &00B1
Yx2M2             = &00B2
Yx2M1             = &00B3
newzp             = &00B6
L00B8             = &00B8
L00BA             = &00BA
L00BB             = &00BB
L00BE             = &00BE
L00BF             = &00BF
L00C0             = &00C0
L00C1             = &00C1
L00C2             = &00C2
L00C3             = &00C3
L00C4             = &00C4
L00C5             = &00C5
L00C6             = &00C6
L00C7             = &00C7
L00C8             = &00C8
L00CA             = &00CA
L00CB             = &00CB
L00CC             = &00CC
L00CD             = &00CD
L00CE             = &00CE
L00D0             = &00D0
L00D1             = &00D1
L00D2             = &00D2
L00D3             = &00D3
L00D4             = &00D4
L00D5             = &00D5
L00D6             = &00D6
L00D7             = &00D7
L00D9             = &00D9
L00DA             = &00DA
L00DF             = &00DF
L00E0             = &00E0
L00E3             = &00E3
L00E4             = &00E4
L00E9             = &00E9
L00EA             = &00EA
L00F3             = &00F3
L00F4             = &00F4
L00F5             = &00F5
BANK              = &00F7
XX3m3             = &00F9
XX3               = &0100
XX3_1             = &0101
L0102             = &0102
L0103             = &0103
L0114             = &0114
L0115             = &0115
L0116             = &0116
L0117             = &0117
L0200             = &0200
L0201             = &0201
L0202             = &0202
L0203             = &0203
L0205             = &0205
L0206             = &0206
L0209             = &0209
L020A             = &020A
L020D             = &020D
L020E             = &020E
L0211             = &0211
L0212             = &0212
L0214             = &0214
L0215             = &0215
L0216             = &0216
L0217             = &0217
L0218             = &0218
L0219             = &0219
L021A             = &021A
L021B             = &021B
L021C             = &021C
L021D             = &021D
L021E             = &021E
L021F             = &021F
L0220             = &0220
L0221             = &0221
L0222             = &0222
L0223             = &0223
L0224             = &0224
L0228             = &0228
L022C             = &022C
L0300             = &0300
FRIN              = &036A
MJ                = &038A
VIEW              = &038E
EV                = &0392
L0395             = &0395
TP                = &039E
QQ0               = &039F
QQ1               = &03A0
CASH              = &03A1
QQ14              = &03A5
L03A6             = &03A6
GCNT              = &03A7
L03A8             = &03A8
CRGO              = &03AC
QQ20              = &03AD
L03BE             = &03BE
BST               = &03BF
BOMB              = &03C0
GHYP              = &03C3
L03C4             = &03C4
ESCP              = &03C6
NOMSL             = &03C8
FIST              = &03C9
AVL               = &03CA
QQ26              = &03DB
TALLY             = &03DC
TALLY_1           = &03DD
QQ21              = &03DF
NOSTM             = &03E5
L03EA             = &03EA
L03EB             = &03EB
L03EC             = &03EC
L03ED             = &03ED
L03EF             = &03EF
L03F0             = &03F0
L03F2             = &03F2
DTW6              = &03F3
DTW2              = &03F4
DTW3              = &03F5
DTW4              = &03F6
DTW5              = &03F7
DTW1              = &03F8
DTW8              = &03F9
MSTG              = &0401
QQ19              = &044D
QQ19_1            = &044E
QQ19_3            = &0450
QQ19_4            = &0450
K2                = &0459
K2_1              = &045A
K2_2              = &045B
K2_3              = &045C
QQ19_2            = &045F
L0461             = &0461
L0464             = &0464
L046C             = &046C
L0473             = &0473
L0475             = &0475
SWAP              = &047F
QQ24              = &0487
QQ25              = &0488
QQ28              = &0489
QQ29              = &048A
L048B             = &048B
gov               = &048C
tek               = &048D
QQ2               = &048E
QQ3               = &0494
QQ4               = &0495
QQ5               = &0496
QQ8               = &049B
QQ8_1             = &049C
QQ9               = &049D
QQ10              = &049E
QQ18_LO           = &04A4
QQ18_HI           = &04A5
TKN1_LO           = &04A6
TKN1_HI           = &04A7
LANG              = &04A8
SX                = &04C8
SY                = &04DD
SZ                = &04F2
BUFm1             = &0506
BUF               = &0507
BUF_1             = &0508
HANGFLAG          = &0561
MANY              = &0562
SSPR              = &0564
SXL               = &05A5
SYL               = &05BA
SZL               = &05CF
safehouse         = &05E4
Kpercent          = &0600
PPUCTRL           = &2000
PPUMASK           = &2001
PPUSTATUS         = &2002
OAMADDR           = &2003
OAMDATA           = &2004
PPUSCROLL         = &2005
PPUADDR           = &2006
PPUDATA           = &2007
OAMDMA            = &4014
LC006             = &C006
LC007             = &C007
RESETBANK         = &C0AD
SETBANK           = &C0AE
log               = &C100
logL              = &C200
antilog           = &C300
antilogODD        = &C400
SNE               = &C500
ACT               = &C520
XX21m2            = &C53E
XX21m1            = &C53F
XX21              = &C540
LC6F4             = &C6F4
UNIV              = &CE7E
UNIV_1            = &CE7E
GINF              = &CE90
NMI               = &CED5
NAMETABLE0        = &D06D
LD164             = &D164
LD167             = &D167
LD8C5             = &D8C5
LD8EC             = &D8EC
LD933             = &D933
LD946             = &D946
LD977             = &D977
LD986             = &D986
LDBD8             = &DBD8
LOIN              = &DC0F
PIXEL             = &E4F0
ECBLB2            = &E596
DELAY             = &EBA2
EXNO3             = &EBAD
BOOP              = &EBE5
NOISE             = &EBF2
NAMETABLE0_BANK7  = &EC7D
LECF9             = &ECF9
TIDY              = &EDEA
LEE54             = &EE54
LEE99             = &EE99
LEEE8             = &EEE8
PAS1_BANK7        = &EF7A
LEF88             = &EF88
LEF96             = &EF96
LEFA4             = &EFA4
LEFB2             = &EFB2
LL164             = &EFF7
DETOK_BANK7       = &F082
DTS               = &F09D
F186_BANK7        = &F186
MVS5_BANK7        = &F1A2
HALL              = &F1BD
DASC_BANK7        = &F1E6
TT27_BANK7        = &F201
TT27_control_codes = &F237
TT66              = &F26E
SCAN_BANK7        = &F2A8
CLYNS             = &F2DE
Ze                = &F42E
NLIN4             = &F473
DORND2            = &F4AC
DORND             = &F4AD
PROJ              = &F4C1
LF52D             = &F52D
LF5AF             = &F5AF
MU5               = &F65A
MULT3             = &F664
MLS2              = &F6BA
MLS1              = &F6C2
MULTSm2           = &F6C4
MULTS             = &F6C6
MU6               = &F707
SQUA              = &F70C
SQUA2             = &F70E
MU1               = &F713
MLU1              = &F718
MLU2              = &F71D
MULTU             = &F721
MU11              = &F725
FMLTU2            = &F766
FMLTU             = &F770
MLTU2m2           = &F7AB
MLTU2             = &F7AD
MUT2              = &F7D2
MUT1              = &F7D6
MULT1             = &F7DA
MULT12            = &F83C
TAS3              = &F853
MAD               = &F86F
ADD               = &F872
TIS1              = &F8AE
DV42              = &F8D1
DV41              = &F8D4
DVID3B2           = &F962
LL5               = &FA55
LL28              = &FA91
NORM              = &FAF8

 ORG &8000

.pydis_start
 SEI                                              ; 8000: 78          x
 INC LC006                                        ; 8001: EE 06 C0    ...
 JMP LC007                                        ; 8004: 4C 07 C0    L..

 EQUS "@ 5.0"                                     ; 8007: 40 20 35... @ 5
 EQUS "  NES ELITE IMAGE 5.2  -   24 APR 1992 "   ; 800C: 20 20 4E...   N
 EQUS " (C) D.Braben & I.Bell 1991/92  "          ; 8033: 20 28 43...  (C
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 8053: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 805C: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 8065: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 806E: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 8077: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 8080: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 8089: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 8092: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 809B: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 80A4: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 80AD: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 80B6: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 80BF: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 80C8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 80D1: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 80DA: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 80E3: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 80EC: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 80F5: FF FF FF... ...
 EQUB &FF, &FF,   0,   0,   0,   0,   0,   0,   0 ; 80FE: FF FF 00... ...
 EQUB   0, &FE, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 8107: 00 FE FF... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8110: 00 00 00... ...
 EQUB   1,   1, &7D, &7D, &BB, &BB, &BB,   0,   0 ; 8119: 01 01 7D... ..}
 EQUB   0,   0,   0,   0,   0,   0, &FF, &FF, &FF ; 8122: 00 00 00... ...
 EQUB &FF, &FF, &FF, &FF, &FF,   0,   0,   0,   0 ; 812B: FF FF FF... ...
 EQUB   0,   0,   0,   0, &E0, &F0, &F0, &F7, &F7 ; 8134: 00 00 00... ...
 EQUB &FB, &FB, &FB,   0,   0,   0,   0,   0,   0 ; 813D: FB FB FB... ...
 EQUB   0,   0,   3,   3,   3,   3,   3,   3,   7 ; 8146: 00 00 03... ...
 EQUB   7,   0,   0,   0,   0,   0,   0,   0,   0 ; 814F: 07 00 00... ...
 EQUB &C0, &C0, &C0, &C0, &C0, &C0, &E0, &E0,   0 ; 8158: C0 C0 C0... ...
 EQUB   0,   0,   0,   2,   6, &0E,   6, &0F, &1F ; 8161: 00 00 00... ...
 EQUB &1C, &DC, &DA, &B6, &AE, &B6,   0,   0,   0 ; 816A: 1C DC DA... ...
 EQUB &84, &20, &50, &88, &50, &FE, &FF,   1, &29 ; 8173: 84 20 50... . P
 EQUB &55, &A9,   5, &A9,   0,   0,   0,   0,   0 ; 817C: 55 A9 05... U..
 EQUB   0,   0,   1, &FF, &F7, &61, &57, &41, &75 ; 8185: 00 00 01... ...
 EQUB &43, &77,   0,   0,   0,   0,   0, &40, &A0 ; 818E: 43 77 00... Cw.
 EQUB   0, &E0, &F0, &F0, &F7, &F7, &FB, &FB, &FB ; 8197: 00 E0 F0... ...
 EQUB   0,   0, &0D,   0,   7,   0,   0,   0, &0F ; 81A0: 00 00 0D... ...
 EQUB &1F, &12, &DF, &D8, &BF, &A5, &AD,   0,   0 ; 81A9: 1F 12 DF... ...
 EQUB &6A,   0, &58,   0,   0,   0, &FE, &FF, &95 ; 81B2: 6A 00 58... j.X
 EQUB &FF, &A7, &FF, &A0, &B5,   0,   0, &1C, &63 ; 81BB: FF A7 FF... ...
 EQUB &41, &80, &80, &80, &FF, &FF, &FF, &FF, &FF ; 81C4: 41 80 80... A..
 EQUB &F7, &E3, &F7,   0,   0,   0, &40,   0, &80 ; 81CD: F7 E3 F7... ...
 EQUB &90, &80, &E0, &F0, &F0, &B7, &F7, &FB, &EB ; 81D6: 90 80 E0... ...
 EQUB &FB,   0,   0,   0,   0,   0,   0,   7,   0 ; 81DF: FB 00 00... ...
 EQUB &0F, &1F, &1F, &DF, &DF, &B0, &B7, &B0,   0 ; 81E8: 0F 1F 1F... ...
 EQUB   0,   0,   0, &1C, &20, &E0, &20, &FE, &FF ; 81F1: 00 00 00... ...
 EQUB &FF, &E3, &DD, &21, &EF, &21,   0,   0, &0F ; 81FA: FF E3 DD... ...
 EQUB   0, &3F,   1, &7D, &44, &FF, &F0, &E0, &E0 ; 8203: 00 3F 01... .?.
 EQUB &FF,   1,   1,   0,   0,   0, &80, &40, &40 ; 820C: FF 01 01... ...
 EQUB &40, &40, &40, &E0, &10, &10, &17, &17, &1B ; 8215: 40 40 40... @@@
 EQUB &1B, &1B,   0,   0,   0,   0,   0,   0,   0 ; 821E: 1B 1B 00... ...
 EQUB   0, &0F, &1F, &1F, &D1, &D5, &B1, &B5, &B5 ; 8227: 00 0F 1F... ...
 EQUB   0,   0,   0, &0E, &0A, &0E, &0A, &0A, &FE ; 8230: 00 00 00... ...
 EQUB &FF, &FF, &11, &55, &11, &55, &55,   0,   0 ; 8239: FF FF 11... ...
 EQUB   0, &6C,   0, &5D,   0, &EC, &FF, &FF, &FF ; 8242: 00 6C 00... .l.
 EQUB &92, &FE, &A3, &FE, &12,   0,   0,   0,   0 ; 824B: 92 FE A3... ...
 EQUB &C0, &E0, &C0,   0, &E0, &F0, &F0, &17, &D7 ; 8254: C0 E0 C0... ...
 EQUB &FB, &DB, &1B,   0,   0,   0,   1,   2,   2 ; 825D: FB DB 1B... ...
 EQUB   2,   2, &0F, &1F, &1C, &D9, &DA, &BA, &BA ; 8266: 02 02 0F... ...
 EQUB &BA,   0,   0, &C0, &E0, &D0, &10, &D0, &D0 ; 826F: BA 00 00... ...
 EQUB &FE, &3F, &CF, &E7, &C7,   7,   7,   7,   0 ; 8278: FE 3F CF... .?.
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8281: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 828A: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8293: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 829C: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 82A5: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 82AE: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 82B7: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 82C0: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 82C9: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 82D2: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 82DB: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 82E4: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0, &20, &1F,   0 ; 82ED: 00 00 00... ...
 EQUB &20,   0, &3F, &3F, &3F, &1F, &20,   0, &5F ; 82F6: 20 00 3F...  .?
 EQUB &40,   0,   0,   0,   0, &FF,   0,   0,   0 ; 82FF: 40 00 00... @..
 EQUB &FF, &FF, &FF, &FF,   0,   0, &FF,   0,   0 ; 8308: FF FF FF... ...
 EQUB   0,   0, &82,   1, &10, &92, &10, &93, &93 ; 8311: 00 00 82... ...
 EQUB &93, &11, &92,   0, &45, &44,   0,   0,   0 ; 831A: 93 11 92... ...
 EQUB   8, &F0,   1,   9,   1, &F9, &F9, &F9, &F1 ; 8323: 08 F0 01... ...
 EQUB   9,   0, &F4,   4,   0,   0,   0,   0,   0 ; 832C: 09 00 F4... ...
 EQUB   0,   1, &0B, &0F, &0F, &1F, &1F, &3F, &3F ; 8335: 00 01 0B... ...
 EQUB &7E, &74,   0,   0,   0,   0,   0,   0, &80 ; 833E: 7E 74 00... ~t.
 EQUB &D0, &F0, &F0, &F8, &F8, &FC, &FC, &7E, &2E ; 8347: D0 F0 F0... ...
 EQUB   2,   0,   0, &20, &1F,   0, &20,   0, &3A ; 8350: 02 00 00... ...
 EQUB &3C, &3C, &1F, &20,   0, &5F, &40, &20,   0 ; 8359: 3C 3C 1F... <<.
 EQUB   0,   0, &FF,   0,   0,   0, &55, &AD,   1 ; 8362: 00 00 FF... ...
 EQUB &FF,   0,   0, &FF,   0, &22, &54,   8,   0 ; 836B: FF 00 00... ...
 EQUB &FF,   0,   0,   0, &7F, &7F,   8, &FF,   0 ; 8374: FF 00 00... ...
 EQUB   0, &FF,   0,   0,   0,   0,   8, &F0,   1 ; 837D: 00 FF 00... ...
 EQUB   9,   1, &F9, &F9, &19, &F1,   9,   0, &F4 ; 8386: 09 01 F9... ...
 EQUB   4,   0,   0,   0, &20, &1F,   0, &20,   0 ; 838F: 04 00 00... ...
 EQUB &25, &2D, &24, &1F, &20,   0, &5F, &40,   0 ; 8398: 25 2D 24... %-$
 EQUB   0,   0,   0, &FF,   0,   0,   0, &B4, &B5 ; 83A1: 00 00 00... ...
 EQUB &B4, &FF,   0,   0, &FF,   0, &41, &63, &1C ; 83AA: B4 FF 00... ...
 EQUB   0, &FF,   0,   0,   0, &FF, &FF, &FF, &FF ; 83B3: 00 FF 00... ...
 EQUB   0,   0, &FF,   0,   0, &20,   0,   8, &F0 ; 83BC: 00 00 FF... ...
 EQUB   1,   9,   1, &F9, &D9, &F9, &F1,   9,   0 ; 83C5: 01 09 01... ...
 EQUB &F4,   4, &1C,   0,   0,   0, &FF,   0,   0 ; 83CE: F4 04 1C... ...
 EQUB   0, &DD, &E3, &FF, &FF,   0,   0, &FF,   0 ; 83D7: 00 DD E3... ...
 EQUB &7D,   1, &1F,   0, &FF,   0,   0,   0,   0 ; 83E0: 7D 01 1F... }..
 EQUB   0, &C0, &C0,   0,   0, &FF,   0, &40, &40 ; 83E9: 00 C0 C0... ...
 EQUB   0,   8, &F0,   1,   9,   1, &19, &19, &39 ; 83F2: 00 08 F0... ...
 EQUB &71,   9,   0, &F4,   4,   0, &0E,   0,   0 ; 83FB: 71 09 00... q..
 EQUB &FF,   0,   0,   0, &FF, &FF, &FF, &FF,   0 ; 8404: FF 00 00... ...
 EQUB   0, &FF,   0,   0, &DD,   0,   0, &FF,   0 ; 840D: 00 FF 00... ...
 EQUB   0,   0, &FF, &22, &FF, &FF,   0,   0, &FF ; 8416: 00 00 FF... ...
 EQUB   0,   0, &A0,   0,   8, &F0,   1,   9,   1 ; 841F: 00 00 A0... ...
 EQUB &F9, &59, &F9, &F1,   9,   0, &F4,   4,   2 ; 8428: F9 59 F9... .Y.
 EQUB   2,   0, &20, &1F,   0, &20,   0, &3A, &3A ; 8431: 02 00 20... ..
 EQUB &3C, &1F, &20,   0, &5F, &40, &D0, &D0, &C0 ; 843A: 3C 1F 20... <.
 EQUB   0, &FF,   0,   0,   0,   7,   7, &0F, &3F ; 8443: 00 FF 00... ...
 EQUB   0,   0, &FF,   0,   0,   0,   0,   0,   0 ; 844C: 00 00 FF... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8455: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 845E: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8467: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8470: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8479: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8482: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 848B: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8494: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 849D: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 84A6: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 84AF: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 84B8: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 84C1: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 84CA: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 84D3: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 84DC: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 84E5: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 84EE: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 84F7: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0, &FE ; 8500: 00 00 00... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF,   0,   0 ; 8509: FF FF FF... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   1,   1 ; 8512: 00 00 00... ...
 EQUB &7D, &7D, &BB, &BB, &BB,   0,   0,   0,   0 ; 851B: 7D 7D BB... }}.
 EQUB   0,   0,   0,   0, &FF, &FF, &FF, &FF, &FF ; 8524: 00 00 00... ...
 EQUB &FF, &FF, &FF,   0,   0,   0,   0,   0,   0 ; 852D: FF FF FF... ...
 EQUB   0,   0, &E0, &F0, &F0, &F7, &F7, &FB, &FB ; 8536: 00 00 E0... ...
 EQUB &FB,   0,   0,   0,   0,   0,   0,   0,   0 ; 853F: FB 00 00... ...
 EQUB   3,   3,   3,   3,   3,   3,   7,   7,   0 ; 8548: 03 03 03... ...
 EQUB   0,   0,   0,   0,   0,   0,   0, &C0, &C0 ; 8551: 00 00 00... ...
 EQUB &C0, &C0, &C0, &C0, &E0, &E0,   0,   0,   0 ; 855A: C0 C0 C0... ...
 EQUB   1,   5,   6,   7,   6, &0F, &1F, &1C, &D0 ; 8563: 01 05 06... ...
 EQUB &D4, &B6, &B7, &B6,   0,   0,   0, &84, &20 ; 856C: D4 B6 B7... ...
 EQUB &50,   8, &50, &FE, &FF,   1, &29, &55, &A9 ; 8575: 50 08 50... P.P
 EQUB   5, &A9,   0,   0,   0,   0,   0,   0,   0 ; 857E: 05 A9 00... ...
 EQUB   1, &FF, &F7, &61, &57, &41, &75, &43, &77 ; 8587: 01 FF F7... ...
 EQUB   0,   0,   0,   0,   0, &40, &A0,   0, &E0 ; 8590: 00 00 00... ...
 EQUB &F0, &F0, &F7, &F7, &FB, &FB, &FB,   0,   0 ; 8599: F0 F0 F7... ...
 EQUB &0D,   0,   7,   0,   0,   0, &0F, &1F, &12 ; 85A2: 0D 00 07... ...
 EQUB &DF, &D8, &BF, &A5, &AD,   0,   0, &6A,   0 ; 85AB: DF D8 BF... ...
 EQUB &58,   0,   0,   0, &FE, &FF, &95, &FF, &A7 ; 85B4: 58 00 00... X..
 EQUB &FF, &A0, &B5,   0,   0, &1C, &63, &41, &80 ; 85BD: FF A0 B5... ...
 EQUB &80, &80, &FF, &FF, &FF, &FF, &FF, &F7, &E3 ; 85C6: 80 80 FF... ...
 EQUB &F7,   0,   0,   0, &40,   0, &80, &90, &80 ; 85CF: F7 00 00... ...
 EQUB &E0, &F0, &F0, &B7, &F7, &FB, &EB, &FB,   0 ; 85D8: E0 F0 F0... ...
 EQUB   0,   2,   0,   0,   4,   0,   1, &0F, &1F ; 85E1: 00 02 00... ...
 EQUB &1D, &DF, &DF, &BA, &BF, &BF,   0,   0,   0 ; 85EA: 1D DF DF... ...
 EQUB   4,   0,   0, &A0, &10, &FE, &FF, &FF, &BB ; 85F3: 04 00 00... ...
 EQUB &BF, &4F, &BF, &BF,   0,   0,   0,   0,   0 ; 85FC: BF 4F BF... .O.
 EQUB   0,   0,   0,   0,   1,   1, &7D, &7D, &BB ; 8605: 00 00 00... ...
 EQUB &BA, &BB,   0,   0,   0,   3, &27, &6F, &EF ; 860E: BA BB 00... ...
 EQUB &6F, &FF, &FF, &FC, &D0, &A6, &6B, &E3, &65 ; 8617: 6F FF FF... o..
 EQUB   0,   0,   0, &80, &C0, &E0, &E0, &E0, &E0 ; 8620: 00 00 00... ...
 EQUB &F0, &70, &97, &57, &EB, &2B, &2B,   0,   0 ; 8629: F0 70 97... .p.
 EQUB   0,   2,   5,   8,   2,   1, &0F, &1F, &1F ; 8632: 00 02 05... ...
 EQUB &DD, &D8, &B2, &B5, &BC,   0,   0, &10, &28 ; 863B: DD D8 B2... ...
 EQUB &42, &84, &28, &52, &FE, &FF, &EF, &C7, &95 ; 8644: 42 84 28... B.(
 EQUB &39, &53, &85,   0,   0,   0,   0,   0,   0 ; 864D: 39 53 85... 9S.
 EQUB   0,   1,   0,   1,   1, &7D, &7D, &BB, &BB ; 8656: 00 01 00... ...
 EQUB &BA,   0,   0,   2,   4,   8, &10, &E0, &C0 ; 865F: BA 00 00... ...
 EQUB &FF, &FF, &FC, &F8, &F1, &E3,   6, &0E,   0 ; 8668: FF FF FC... ...
 EQUB   0,   0,   0,   0,   3,   7,   2, &0F, &1F ; 8671: 00 00 00... ...
 EQUB &1F, &DF, &DF, &BC, &B8, &B8,   0,   8, &10 ; 867A: 1F DF DF... ...
 EQUB &20, &40, &80,   0, &40, &FE, &F3, &E3, &C7 ; 8683: 20 40 80...  @.
 EQUB &8F, &1F, &3F, &3F,   0,   0, &24, &1F, &1F ; 868C: 8F 1F 3F... ..?
 EQUB &7F, &1F, &1F, &FF, &BB, &FB, &E0, &E0, &40 ; 8695: 7F 1F 1F... ...
 EQUB &E0, &E0,   0,   0, &80,   0,   0, &C0,   0 ; 869E: E0 E0 00... ...
 EQUB   0, &E0, &B0, &F0, &F7, &F7, &5B, &FB, &FB ; 86A7: 00 E0 B0... ...
 EQUB   0,   0,   0,   0,   1,   0,   0,   0, &0F ; 86B0: 00 00 00... ...
 EQUB &1F, &1F, &DE, &DD, &BC, &BF, &BC,   0,   0 ; 86B9: 1F 1F DE... ...
 EQUB &40, &E0, &F0,   0,   0,   0, &FE, &BF, &5F ; 86C2: 40 E0 F0... @..
 EQUB &EF, &F7,   7, &FF,   7,   0,   0,   0, &21 ; 86CB: EF F7 07... ...
 EQUB &31, &39, &31, &21, &FF, &FF, &9C, &AD, &B5 ; 86D4: 31 39 31... 191
 EQUB &B9, &B5, &AD,   0,   0,   0,   0, &80, &C0 ; 86DD: B9 B5 AD... ...
 EQUB &80,   0, &E0, &F0, &F0, &77, &B7, &DB, &BB ; 86E6: 80 00 E0... ...
 EQUB &7B,   0,   0,   0, &20, &1F,   0, &20,   0 ; 86EF: 7B 00 00... {..
 EQUB &3F, &3F, &3F, &1F, &20,   0, &5F, &40,   0 ; 86F8: 3F 3F 3F... ???
 EQUB   0,   0,   0, &FF,   0,   0,   0, &FF, &FF ; 8701: 00 00 00... ...
 EQUB &FF, &FF,   0,   0, &FF,   0,   0,   0,   0 ; 870A: FF FF 00... ...
 EQUB &82,   1, &10, &92, &10, &93, &93, &93, &11 ; 8713: 82 01 10... ...
 EQUB &92,   0, &45, &44,   0,   0,   0,   8, &F0 ; 871C: 92 00 45... ..E
 EQUB   1,   9,   1, &F9, &F9, &F9, &F1,   9,   0 ; 8725: 01 09 01... ...
 EQUB &F4,   4,   0,   0,   0,   0,   0,   0,   1 ; 872E: F4 04 00... ...
 EQUB &0B, &0F, &0F, &1F, &1F, &3F, &3F, &7E, &74 ; 8737: 0B 0F 0F... ...
 EQUB   0,   0,   0,   0,   0,   0, &80, &D0, &F0 ; 8740: 00 00 00... ...
 EQUB &F0, &F8, &F8, &FC, &FC, &7E, &2E,   4,   1 ; 8749: F0 F8 F8... ...
 EQUB   0, &20, &1F,   0, &20,   0, &35, &30, &3C ; 8752: 00 20 1F... . .
 EQUB &1F, &20,   0, &5F, &40, &20,   0,   0,   0 ; 875B: 1F 20 00... . .
 EQUB &FF,   0,   0,   0, &55, &AD,   1, &FF,   0 ; 8764: FF 00 00... ...
 EQUB   0, &FF,   0, &22, &54,   8,   0, &FF,   0 ; 876D: 00 FF 00... ...
 EQUB   0,   0, &7F, &7F,   8, &FF,   0,   0, &FF ; 8776: 00 00 7F... ...
 EQUB   0,   0,   0,   0,   8, &F0,   1,   9,   1 ; 877F: 00 00 00... ...
 EQUB &F9, &F9, &19, &F1,   9,   0, &F4,   4,   0 ; 8788: F9 F9 19... ...
 EQUB   0,   0, &20, &1F,   0, &20,   0, &25, &2D ; 8791: 00 00 20... ..
 EQUB &24, &1F, &20,   0, &5F, &40,   0,   0,   0 ; 879A: 24 1F 20... $.
 EQUB   0, &FF,   0,   0,   0, &B4, &B5, &B4, &FF ; 87A3: 00 FF 00... ...
 EQUB   0,   0, &FF,   0, &41, &63, &1C,   0, &FF ; 87AC: 00 00 FF... ...
 EQUB   0,   0,   0, &FF, &FF, &FF, &FF,   0,   0 ; 87B5: 00 00 00... ...
 EQUB &FF,   0,   0, &20,   0,   8, &F0,   1,   9 ; 87BE: FF 00 00... ...
 EQUB   1, &F9, &D9, &F9, &F1,   9,   0, &F4,   4 ; 87C7: 01 F9 D9... ...
 EQUB   6, &1C,   8, &20, &1F,   0, &20,   0, &3F ; 87D0: 06 1C 08... ...
 EQUB &3F, &3F, &1F, &20,   0, &5F, &40, &0C, &47 ; 87D9: 3F 3F 1F... ??.
 EQUB   2,   0, &FF,   0,   0,   0, &FF, &BF, &FF ; 87E2: 02 00 FF... ...
 EQUB &FF,   0,   0, &FF,   0, &27,   3,   0,   0 ; 87EB: FF 00 00... ...
 EQUB &FF,   0,   0,   0, &A7, &D2, &FC, &FF,   0 ; 87F4: FF 00 00... ...
 EQUB   0, &FF,   0, &C0, &80,   0,   8, &F0,   1 ; 87FD: 00 FF 00... ...
 EQUB   9,   1, &59, &99, &79, &F1,   9,   0, &F4 ; 8806: 09 01 59... ..Y
 EQUB   4,   0,   0,   0, &20, &1F,   0, &20,   0 ; 880F: 04 00 00... ...
 EQUB &3E, &3F, &3F, &1F, &20,   0, &5F, &40, &80 ; 8818: 3E 3F 3F... >??
 EQUB   0,   0,   0, &FF,   0,   0,   0, &2D, &7F ; 8821: 00 00 00... ...
 EQUB &FF, &FF,   0,   0, &FF,   0, &90, &30, &20 ; 882A: FF FF 00... ...
 EQUB   0, &FF,   0,   0,   0,   9, &8E, &DE, &FF ; 8833: 00 FF 00... ...
 EQUB   0,   0, &FF,   0,   0,   0,   0,   8, &F0 ; 883C: 00 00 FF... ...
 EQUB   1,   9,   1, &39, &F9, &F9, &F1,   9,   0 ; 8845: 01 09 01... ...
 EQUB &F4,   4,   4,   6,   0, &20, &1F,   0, &20 ; 884E: F4 04 04... ...
 EQUB   0, &34, &36, &31, &1F, &20,   0, &5F, &40 ; 8857: 00 34 36... .46
 EQUB &C0, &80,   0,   0, &FF,   0,   0,   0, &3F ; 8860: C0 80 00... ...
 EQUB &7F, &FF, &FF,   0,   0, &FF,   0, &24,   0 ; 8869: 7F FF FF... ...
 EQUB   0,   0, &FF,   0,   0,   0, &FB, &BB, &FF ; 8872: 00 00 FF... ...
 EQUB &FF,   0,   0, &FF,   0, &80,   0,   0,   8 ; 887B: FF 00 00... ...
 EQUB &F0,   1,   9,   1, &F9, &B9, &F9, &F1,   9 ; 8884: F0 01 09... ...
 EQUB   0, &F4,   4,   1,   0,   0, &20, &1F,   0 ; 888D: 00 F4 04... ...
 EQUB &20,   0, &3D, &3C, &3F, &1F, &20,   0, &5F ; 8896: 20 00 3D...  .=
 EQUB &40, &F0,   0,   0,   0, &FF,   0,   0,   0 ; 889F: 40 F0 00... @..
 EQUB &F7,   7, &FF, &FF,   0,   0, &FF,   0,   0 ; 88A8: F7 07 FF... ...
 EQUB   0,   0,   0, &FF,   0,   0,   0, &9C, &FF ; 88B1: 00 00 00... ...
 EQUB &FF, &FF,   0,   0, &FF,   0,   0,   0,   0 ; 88BA: FF FF 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 88C3: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 88CC: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 88D5: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 88DE: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 88E7: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 88F0: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 88F9: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0, &FE, &FF, &FF ; 8902: 00 00 00... ...
 EQUB &FF, &FF, &FF, &FF, &FF,   0,   0,   0,   0 ; 890B: FF FF FF... ...
 EQUB   0,   0,   0,   0,   0,   1,   1, &7D, &7D ; 8914: 00 00 00... ...
 EQUB &BB, &BB, &BB,   0,   0,   0,   0,   0,   0 ; 891D: BB BB BB... ...
 EQUB   0,   0, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; 8926: 00 00 FF... ...
 EQUB &FF,   0,   0,   0,   0,   0,   0,   0,   0 ; 892F: FF 00 00... ...
 EQUB &E0, &F0, &F0, &F7, &F7, &FB, &FB, &FB,   0 ; 8938: E0 F0 F0... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   3,   3 ; 8941: 00 00 00... ...
 EQUB   3,   3,   3,   3,   7,   7,   0,   0,   0 ; 894A: 03 03 03... ...
 EQUB   0,   0,   0,   0,   0, &C0, &C0, &C0, &C0 ; 8953: 00 00 00... ...
 EQUB &C0, &C0, &E0, &E0,   0,   0,   0,   0,   2 ; 895C: C0 C0 E0... ...
 EQUB   6, &0E,   6, &0F, &1F, &1C, &DC, &DA, &B6 ; 8965: 06 0E 06... ...
 EQUB &AE, &B6,   0,   0,   0, &84, &20, &50, &88 ; 896E: AE B6 00... ...
 EQUB &50, &FE, &FF,   1, &29, &55, &A9,   5, &A9 ; 8977: 50 FE FF... P..
 EQUB   0,   0,   0,   0,   0,   0,   0,   1, &FF ; 8980: 00 00 00... ...
 EQUB &F7, &61, &57, &41, &75, &43, &77,   0,   0 ; 8989: F7 61 57... .aW
 EQUB   0,   0,   0, &40, &A0,   0, &E0, &F0, &F0 ; 8992: 00 00 00... ...
 EQUB &F7, &F7, &FB, &FB, &FB,   0,   0,   1,   6 ; 899B: F7 F7 FB... ...
 EQUB   4,   8,   8,   8, &0F, &1F, &1F, &DF, &DF ; 89A4: 04 08 08... ...
 EQUB &BF, &BE, &BF,   0,   0, &C0, &34, &10,   8 ; 89AD: BF BE BF... ...
 EQUB   9,   8, &FE, &FF, &FF, &FB, &FF, &7F, &3E ; 89B6: 09 08 FE... ...
 EQUB &7F,   0,   0,   0, &6C,   0, &5D,   0, &EC ; 89BF: 7F 00 00... ...
 EQUB &FF, &FF, &FF, &92, &FE, &A3, &FE, &12,   0 ; 89C8: FF FF FF... ...
 EQUB   0,   0,   0, &C0, &E0, &C0,   0, &E0, &F0 ; 89D1: 00 00 00... ...
 EQUB &F0, &17, &D7, &FB, &DB, &1B,   0,   0,   2 ; 89DA: F0 17 D7... ...
 EQUB   0,   0,   4,   0,   1, &0F, &1F, &1D, &DF ; 89E3: 00 00 04... ...
 EQUB &DF, &BA, &BF, &BF,   0,   0,   0,   4,   0 ; 89EC: DF BA BF... ...
 EQUB   0, &A0, &10, &FE, &FF, &FF, &BB, &BF, &4F ; 89F5: 00 A0 10... ...
 EQUB &BF, &BF,   0,   0,   4,   4,   4,   4, &7B ; 89FE: BF BF 00... ...
 EQUB   4, &FF, &FF, &FB, &C0, &DB, &DB, &84, &DB ; 8A07: 04 FF FF... ...
 EQUB   0,   0,   0,   0,   0,   0, &C0,   0, &E0 ; 8A10: 00 00 00... ...
 EQUB &F0, &F0, &77, &77, &7B, &3B, &7B,   0,   0 ; 8A19: F0 F0 77... ..w
 EQUB   0,   0,   0,   0,   0,   0, &0F, &1F, &1E ; 8A22: 00 00 00... ...
 EQUB &DC, &DF, &BF, &BF, &BF,   0,   0,   0,   0 ; 8A2B: DC DF BF... ...
 EQUB   0,   0,   0,   0, &FE, &FF, &0F, &E7, &C7 ; 8A34: 00 00 00... ...
 EQUB &8F, &9F, &FF,   0,   0,   0,   0,   0,   0 ; 8A3D: 8F 9F FF... ...
 EQUB   0,   0,   0,   1,   1, &7D, &7D, &BB, &BA ; 8A46: 00 00 00... ...
 EQUB &BB,   0,   0,   0,   3, &27, &6F, &EF, &6F ; 8A4F: BB 00 00... ...
 EQUB &FF, &FF, &FC, &D0, &A6, &6B, &E3, &65,   0 ; 8A58: FF FF FC... ...
 EQUB   0,   0, &80, &C0, &E0, &E0, &E0, &E0, &F0 ; 8A61: 00 00 80... ...
 EQUB &70, &97, &57, &EB, &2B, &2B,   0,   0,   0 ; 8A6A: 70 97 57... p.W
 EQUB   0,   2,   6, &0E,   6, &0F, &1F, &1F, &DD ; 8A73: 00 02 06... ...
 EQUB &DA, &B6, &AE, &B6,   0,   0,   0,   0, &10 ; 8A7C: DA B6 AE... ...
 EQUB &30, &38, &38, &FE, &FF, &FF, &C3, &A9, &46 ; 8A85: 30 38 38... 088
 EQUB &43, &85,   0,   0,   1, &22, &54, &88, &22 ; 8A8E: 43 85 00... C..
 EQUB &15, &FF, &FF, &FE, &DC, &89, &23, &55, &C8 ; 8A97: 15 FF FF... ...
 EQUB   0,   0,   0, &80, &20, &40, &80, &20, &E0 ; 8AA0: 00 00 00... ...
 EQUB &F0, &F0, &77, &57, &9B, &3B, &5B,   0,   0 ; 8AA9: F0 F0 77... ..w
 EQUB   0,   0,   1,   0,   0,   0, &0F, &1F, &1F ; 8AB2: 00 00 01... ...
 EQUB &DE, &DD, &BC, &BF, &BC,   0,   0, &40, &E0 ; 8ABB: DE DD BC... ...
 EQUB &F0,   0,   0,   0, &FE, &BF, &5F, &EF, &F7 ; 8AC4: F0 00 00... ...
 EQUB   7, &FF,   7,   0,   0,   0, &21, &31, &39 ; 8ACD: 07 FF 07... ...
 EQUB &31, &21, &FF, &FF, &9C, &AD, &B5, &B9, &B5 ; 8AD6: 31 21 FF... 1!.
 EQUB &AD,   0,   0,   0,   0, &80, &C0, &80,   0 ; 8ADF: AD 00 00... ...
 EQUB &E0, &F0, &F0, &77, &B7, &DB, &BB, &7B,   0 ; 8AE8: E0 F0 F0... ...
 EQUB   0,   0, &20, &1F,   0, &20,   0, &3F, &3F ; 8AF1: 00 00 20... ..
 EQUB &3F, &1F, &20,   0, &5F, &40,   0,   0,   0 ; 8AFA: 3F 1F 20... ?.
 EQUB   0, &FF,   0,   0,   0, &FF, &FF, &FF, &FF ; 8B03: 00 FF 00... ...
 EQUB   0,   0, &FF,   0,   0,   0,   0, &82,   1 ; 8B0C: 00 00 FF... ...
 EQUB &10, &92, &10, &93, &93, &93, &11, &92,   0 ; 8B15: 10 92 10... ...
 EQUB &45, &44,   0,   0,   0,   8, &F0,   1,   9 ; 8B1E: 45 44 00... ED.
 EQUB   1, &F9, &F9, &F9, &F1,   9,   0, &F4,   4 ; 8B27: 01 F9 F9... ...
 EQUB   0,   0,   0,   0,   0,   0,   1, &0B, &0F ; 8B30: 00 00 00... ...
 EQUB &0F, &1F, &1F, &3F, &3F, &7E, &74,   0,   0 ; 8B39: 0F 1F 1F... ...
 EQUB   0,   0,   0,   0, &80, &D0, &F0, &F0, &F8 ; 8B42: 00 00 00... ...
 EQUB &F8, &FC, &FC, &7E, &2E,   2,   0,   0, &20 ; 8B4B: F8 FC FC... ...
 EQUB &1F,   0, &20,   0, &3A, &3C, &3C, &1F, &20 ; 8B54: 1F 00 20... ..
 EQUB   0, &5F, &40, &20,   0,   0,   0, &FF,   0 ; 8B5D: 00 5F 40... ._@
 EQUB   0,   0, &55, &AD,   1, &FF,   0,   0, &FF ; 8B66: 00 00 55... ..U
 EQUB   0, &22, &54,   8,   0, &FF,   0,   0,   0 ; 8B6F: 00 22 54... ."T
 EQUB &7F, &7F,   8, &FF,   0,   0, &FF,   0,   0 ; 8B78: 7F 7F 08... ...
 EQUB   0,   0,   8, &F0,   1,   9,   1, &F9, &F9 ; 8B81: 00 00 08... ...
 EQUB &19, &F1,   9,   0, &F4,   4,   4,   6,   1 ; 8B8A: 19 F1 09... ...
 EQUB &20, &1F,   0, &20,   0, &3F, &3F, &3F, &1F ; 8B93: 20 1F 00...  ..
 EQUB &20,   0, &5F, &40, &10, &32, &C0,   0, &FF ; 8B9C: 20 00 5F...  ._
 EQUB   0,   0,   0, &FF, &FD, &FF, &FF,   0,   0 ; 8BA5: 00 00 00... ...
 EQUB &FF,   0,   0, &DD,   0,   0, &FF,   0,   0 ; 8BAE: FF 00 00... ...
 EQUB   0, &FF, &22, &FF, &FF,   0,   0, &FF,   0 ; 8BB7: 00 FF 22... .."
 EQUB   0, &A0,   0,   8, &F0,   1,   9,   1, &F9 ; 8BC0: 00 A0 00... ...
 EQUB &59, &F9, &F1,   9,   0, &F4,   4,   6, &1C ; 8BC9: 59 F9 F1... Y..
 EQUB   8, &20, &1F,   0, &20,   0, &3F, &3F, &3F ; 8BD2: 08 20 1F... . .
 EQUB &1F, &20,   0, &5F, &40, &0C, &47,   2,   0 ; 8BDB: 1F 20 00... . .
 EQUB &FF,   0,   0,   0, &FF, &BF, &FF, &FF,   0 ; 8BE4: FF 00 00... ...
 EQUB   0, &FF,   0,   4,   4,   4,   0, &FF,   0 ; 8BED: 00 FF 00... ...
 EQUB   0,   0, &DB, &C0, &FB, &FF,   0,   0, &FF ; 8BF6: 00 00 DB... ...
 EQUB   0,   0,   0,   0,   8, &F0,   1,   9,   1 ; 8BFF: 00 00 00... ...
 EQUB &79, &79, &F9, &F1,   9,   0, &F4,   4,   0 ; 8C08: 79 79 F9... yy.
 EQUB   0,   0,   0, &FF,   0,   0,   0, &9F, &9F ; 8C11: 00 00 00... ...
 EQUB &FF, &FF,   0,   0, &FF,   0, &27,   3,   0 ; 8C1A: FF FF 00... ...
 EQUB   0, &FF,   0,   0,   0, &A7, &D2, &FC, &FF ; 8C23: 00 FF 00... ...
 EQUB   0,   0, &FF,   0, &C0, &80,   0,   8, &F0 ; 8C2C: 00 00 FF... ...
 EQUB   1,   9,   1, &59, &99, &79, &F1,   9,   0 ; 8C35: 01 09 01... ...
 EQUB &F4,   4,   2,   0,   0, &20, &1F,   0, &20 ; 8C3E: F4 04 02... ...
 EQUB   0, &3A, &3D, &3F, &1F, &20,   0, &5F, &40 ; 8C47: 00 3A 3D... .:=
 EQUB &18, &10,   0,   0, &FF,   0,   0,   0, &C5 ; 8C50: 18 10 00... ...
 EQUB &2B, &87, &FF,   0,   0, &FF,   0,   8,   0 ; 8C59: 2B 87 FF... +..
 EQUB   0,   0, &FF,   0,   0,   0, &E2, &F7, &FF ; 8C62: 00 00 FF... ...
 EQUB &FF,   0,   0, &FF,   0,   0,   0,   0,   8 ; 8C6B: FF 00 00... ...
 EQUB &F0,   1,   9,   1, &D9, &F9, &F9, &F1,   9 ; 8C74: F0 01 09... ...
 EQUB   0, &F4,   4,   1,   0,   0, &20, &1F,   0 ; 8C7D: 00 F4 04... ...
 EQUB &20,   0, &3D, &3C, &3F, &1F, &20,   0, &5F ; 8C86: 20 00 3D...  .=
 EQUB &40, &F0,   0,   0,   0, &FF,   0,   0,   0 ; 8C8F: 40 F0 00... @..
 EQUB &F7,   7, &FF, &FF,   0,   0, &FF,   0,   0 ; 8C98: F7 07 FF... ...
 EQUB   0,   0,   0, &FF,   0,   0,   0, &9C, &FF ; 8CA1: 00 00 00... ...
 EQUB &FF, &FF,   0,   0, &FF,   0,   0,   0,   0 ; 8CAA: FF FF 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8CB3: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8CBC: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8CC5: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8CCE: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8CD7: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8CE0: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8CE9: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8CF2: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8CFB: 00 00 00... ...
 EQUB   0,   0,   0,   0, &FE, &FF, &FF, &FF, &FF ; 8D04: 00 00 00... ...
 EQUB &FF, &FF, &FF,   0,   0,   0,   0,   0,   0 ; 8D0D: FF FF FF... ...
 EQUB   0,   0,   0,   1,   1, &7D, &7D, &BB, &BB ; 8D16: 00 00 00... ...
 EQUB &BB,   0,   0,   0,   0,   0,   0,   0,   0 ; 8D1F: BB 00 00... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF,   0 ; 8D28: FF FF FF... ...
 EQUB   0,   0,   0,   0,   0,   0,   0, &E0, &F0 ; 8D31: 00 00 00... ...
 EQUB &F0, &F7, &F7, &FB, &FB, &FB,   0,   0,   0 ; 8D3A: F0 F7 F7... ...
 EQUB   0,   0,   0,   0,   0,   3,   3,   3,   3 ; 8D43: 00 00 00... ...
 EQUB   3,   3,   7,   7,   0,   0,   0,   0,   0 ; 8D4C: 03 03 07... ...
 EQUB   0,   0,   0, &C0, &C0, &C0, &C0, &C0, &C0 ; 8D55: 00 00 00... ...
 EQUB &E0, &E0,   0,   0,   1,   0,   0,   0,   0 ; 8D5E: E0 E0 00... ...
 EQUB   0, &0F, &1C, &1D, &DE, &DF, &BF, &BF, &BF ; 8D67: 00 0F 1C... ...
 EQUB   0,   0, &F0, &E0, &40,   0,   0,   0, &FE ; 8D70: 00 00 F0... ...
 EQUB   7, &F7, &EF, &5F, &BF, &FF, &BF,   0,   0 ; 8D79: 07 F7 EF... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   1,   1 ; 8D82: 00 00 00... ...
 EQUB &7D, &7D, &BB, &BA, &BA,   0,   0,   0,   0 ; 8D8B: 7D 7D BB... }}.
 EQUB   0,   0,   0,   0, &FF, &FF, &FF, &E0, &9F ; 8D94: 00 00 00... ...
 EQUB &7F, &FF, &FF,   0,   0,   0,   0,   0,   0 ; 8D9D: 7F FF FF... ...
 EQUB   0,   0, &E0, &F0, &F0, &F7, &37, &DB, &EB ; 8DA6: 00 00 E0... ...
 EQUB &EB,   0,   0,   0,   0,   0,   0,   0,   0 ; 8DAF: EB 00 00... ...
 EQUB &0F, &1F, &1E, &DE, &DE, &BE, &BE, &B8,   0 ; 8DB8: 0F 1F 1E... ...
 EQUB   0,   0,   0,   0,   0,   0,   0, &FE, &FF ; 8DC1: 00 00 00... ...
 EQUB   3,   3, &FB, &FB, &FB, &E3,   0,   0,   0 ; 8DCA: 03 03 FB... ...
 EQUB   0,   0,   0,   0,   0, &FF, &FF, &FE, &FC ; 8DD3: 00 00 00... ...
 EQUB &C8, &C8, &C8, &C8,   0,   0,   0,   0,   0 ; 8DDC: C8 C8 C8... ...
 EQUB   0,   0,   0, &0F, &1F, &1C, &D8, &D8, &BC ; 8DE5: 00 00 00... ...
 EQUB &B8, &B8,   0,   0,   0,   0,   0,   0,   0 ; 8DEE: B8 B8 00... ...
 EQUB   0, &FE, &FF, &FF, &7F, &67, &C3, &43, &67 ; 8DF7: 00 FE FF... ...
 EQUB   0,   0, &1F, &31, &3F, &28, &3F, &25, &FF ; 8E00: 00 00 1F... ...
 EQUB &FF, &E0, &C0, &C0, &C0, &C0, &C0,   0,   0 ; 8E09: FF E0 C0... ...
 EQUB   0, &80, &80, &80, &80, &80, &E0, &F0, &70 ; 8E12: 00 80 80... ...
 EQUB &77, &37, &3B, &3B, &3B,   0,   0,   0,   0 ; 8E1B: 77 37 3B... w7;
 EQUB   1,   0,   0,   0, &0F, &1F, &1F, &DE, &DD ; 8E24: 01 00 00... ...
 EQUB &BC, &BF, &BC,   0,   0, &40, &E0, &F0,   0 ; 8E2D: BC BF BC... ...
 EQUB   0,   0, &FE, &BF, &5F, &EF, &F7,   7, &FF ; 8E36: 00 00 FE... ...
 EQUB   7,   0,   0,   0,   0,   0,   0,   0,   0 ; 8E3F: 07 00 00... ...
 EQUB &FF, &FF, &FF, &EA, &9F, &7F, &FF, &FF,   0 ; 8E48: FF FF FF... ...
 EQUB   0,   0,   0,   0,   0,   0,   0, &E0, &F0 ; 8E51: 00 00 00... ...
 EQUB &F0, &F7, &B7, &FB, &FB, &FB,   0,   0,   4 ; 8E5A: F0 F7 B7... ...
 EQUB   2,   1,   0,   0,   0, &0F, &1F, &1A, &DC ; 8E63: 02 01 00... ...
 EQUB &DE, &BE, &BE, &B8,   0,   0,   4,   8, &10 ; 8E6C: DE BE BE... ...
 EQUB &A0, &40, &A0, &FE, &FF,   3,   3, &EB, &5B ; 8E75: A0 40 A0... .@.
 EQUB &BB, &43,   0,   0, &40, &20, &11, &0A,   4 ; 8E7E: BB 43 00... .C.
 EQUB &0A, &FF, &FF, &BE, &DC, &C8, &C0, &C8, &C0 ; 8E87: 0A FF FF... ...
 EQUB   0,   0, &40, &80,   0,   0,   0,   0, &E0 ; 8E90: 00 00 40... ..@
 EQUB &F0, &B0, &77, &F7, &FB, &FB, &FB,   0,   0 ; 8E99: F0 B0 77... ..w
 EQUB   0,   0,   0,   0,   0,   0, &0F, &1F, &1F ; 8EA2: 00 00 00... ...
 EQUB &DE, &DE, &BE, &BF, &BE,   0,   0,   0,   0 ; 8EAB: DE DE BE... ...
 EQUB   0,   0,   0,   0, &FE, &FF, &1F, &0F, &0F ; 8EB4: 00 00 00... ...
 EQUB &0F, &1F, &0F,   0,   0,   0,   0,   0,   0 ; 8EBD: 0F 1F 0F... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8EC6: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8ECF: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8ED8: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8EE1: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 8EEA: 00 00 00... ...
 EQUB &20, &1F,   0, &20,   0, &3F, &3F, &3F, &1F ; 8EF3: 20 1F 00...  ..
 EQUB &20,   0, &5F, &40,   0,   0,   0,   0, &FF ; 8EFC: 20 00 5F...  ._
 EQUB   0,   0,   0, &FF, &FF, &FF, &FF,   0,   0 ; 8F05: 00 00 00... ...
 EQUB &FF,   0,   0,   0,   0, &82,   1, &10, &92 ; 8F0E: FF 00 00... ...
 EQUB &10, &93, &93, &93, &11, &92,   0, &45, &44 ; 8F17: 10 93 93... ...
 EQUB   0,   0,   0,   8, &F0,   1,   9,   1, &F9 ; 8F20: 00 00 00... ...
 EQUB &F9, &F9, &F1,   9,   0, &F4,   4,   0,   0 ; 8F29: F9 F9 F1... ...
 EQUB   0,   0,   0,   0,   1, &0B, &0F, &0F, &1F ; 8F32: 00 00 00... ...
 EQUB &1F, &3F, &3F, &7E, &74,   0,   0,   0,   0 ; 8F3B: 1F 3F 3F... .??
 EQUB   0,   0, &80, &D0, &F0, &F0, &F8, &F8, &FC ; 8F44: 00 00 80... ...
 EQUB &FC, &7E, &2E,   0,   0,   1, &20, &1F,   0 ; 8F4D: FC 7E 2E... .~.
 EQUB &20,   0, &3F, &3E, &3D, &1C, &20,   0, &5F ; 8F56: 20 00 3F...  .?
 EQUB &40, &40, &E0, &F0,   0, &FF,   0,   0,   0 ; 8F5F: 40 40 E0... @@.
 EQUB &5F, &EF, &F7,   7,   0,   0, &FF,   0,   0 ; 8F68: 5F EF F7... _..
 EQUB   0,   0,   0, &FF,   0,   0,   0, &7F, &9F ; 8F71: 00 00 00... ...
 EQUB &E0, &FF,   0,   0, &FF,   0,   0,   0,   0 ; 8F7A: E0 FF 00... ...
 EQUB   8, &F0,   1,   9,   0, &D9, &39, &F9, &F1 ; 8F83: 08 F0 01... ...
 EQUB   9,   0, &F4,   4,   0,   0,   0, &20, &1F ; 8F8C: 09 00 F4... ...
 EQUB   0, &20,   0, &30, &30, &39, &1F, &20,   0 ; 8F95: 00 20 00... . .
 EQUB &5F, &40,   0,   0,   0,   0, &FF,   0,   0 ; 8F9E: 5F 40 00... _@.
 EQUB   0, &C3, &C3, &E7, &FF,   0,   0, &FF,   0 ; 8FA7: 00 C3 C3... ...
 EQUB   0,   0,   0,   0, &FF,   0,   0,   0, &C8 ; 8FB0: 00 00 00... ...
 EQUB &FC, &FE, &FF,   0,   0, &FF,   0,   0,   0 ; 8FB9: FC FE FF... ...
 EQUB   0,   0, &FF,   0,   0,   0, &C3, &C3, &FF ; 8FC2: 00 00 FF... ...
 EQUB &FF,   0,   0, &FF,   0, &3F, &7F, &7F,   0 ; 8FCB: FF 00 00... ...
 EQUB &FF,   0,   0,   0, &C0, &E4, &FF, &FF,   0 ; 8FD4: FF 00 00... ...
 EQUB   0, &FF,   0, &80, &A0, &E0,   8, &F0,   1 ; 8FDD: 00 FF 00... ...
 EQUB   9,   1, &39, &F9, &F9, &F1,   9,   0, &F4 ; 8FE6: 09 01 39... ..9
 EQUB   4,   1,   0,   0, &20, &1F,   0, &20,   0 ; 8FEF: 04 01 00... ...
 EQUB &3D, &3E, &3F, &1F, &20,   0, &5F, &40, &F0 ; 8FF8: 3D 3E 3F... =>?
 EQUB &E0, &40,   0, &FF,   0,   0,   0, &F7, &EF ; 9001: E0 40 00... .@.
 EQUB &5F, &BF,   0,   0, &FF,   0,   0,   0,   0 ; 900A: 5F BF 00... _..
 EQUB   8, &F0,   1,   9,   1, &D9, &39, &F9, &F1 ; 9013: 08 F0 01... ...
 EQUB   9,   0, &F4,   4,   1,   2,   4, &20, &1F ; 901C: 09 00 F4... ...
 EQUB   0, &20,   0, &30, &30, &39, &1F, &20,   0 ; 9025: 00 20 00... . .
 EQUB &5F, &40, &10,   8,   4,   0, &FF,   0,   0 ; 902E: 5F 40 10... _@.
 EQUB   0, &C3, &C3, &E3, &FF,   0,   0, &FF,   0 ; 9037: 00 C3 C3... ...
 EQUB &11, &20, &40,   0, &FF,   0,   0,   0, &C8 ; 9040: 11 20 40... . @
 EQUB &DC, &BE, &FF,   0,   0, &FF,   0,   0, &80 ; 9049: DC BE FF... ...
 EQUB &40,   8, &F0,   1,   9,   1, &F9, &79, &B9 ; 9052: 40 08 F0... @..
 EQUB &F1,   9,   0, &F4,   4,   0,   0,   0, &20 ; 905B: F1 09 00... ...
 EQUB &1F,   0, &20,   0, &3C, &3C, &3F, &1F, &20 ; 9064: 1F 00 20... ..
 EQUB   0, &5F, &40,   0,   0,   0,   0, &FF,   0 ; 906D: 00 5F 40... ._@
 EQUB   0,   0,   7,   7, &FF, &FF,   0,   0, &FF ; 9076: 00 00 07... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 907F: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 9088: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 9091: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 909A: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 90A3: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 90AC: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 90B5: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 90BE: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 90C7: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 90D0: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 90D9: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 90E2: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 90EB: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 90F4: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 90FD: 00 00 00... ...
 EQUB   0,   0, &0F, &1F, &1F, &DF, &DF, &BF, &BF ; 9106: 00 00 0F... ...
 EQUB &BF,   0,   0,   0,   0,   0,   0,   0,   0 ; 910F: BF 00 00... ...
 EQUB &FE, &FF, &FF, &FF, &FF, &FF, &FF, &FF,   0 ; 9118: FE FF FF... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   1 ; 9121: 00 00 00... ...
 EQUB   1, &7D, &7D, &BB, &BB, &BB,   0,   0,   0 ; 912A: 01 7D 7D... .}}
 EQUB   0,   0,   0,   0,   0, &FF, &FF, &FF, &FF ; 9133: 00 00 00... ...
 EQUB &FF, &FF, &FF, &FF,   0,   0,   0,   0,   0 ; 913C: FF FF FF... ...
 EQUB   0,   0,   0, &E0, &F0, &F0, &F7, &F7, &FB ; 9145: 00 00 00... ...
 EQUB &FB, &FB,   0,   0,   0,   0,   0,   0,   0 ; 914E: FB FB 00... ...
 EQUB   0,   3,   3,   3,   3,   3,   3,   7,   7 ; 9157: 00 03 03... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0, &C0 ; 9160: 00 00 00... ...
 EQUB &C0, &C0, &C0, &C0, &C0, &E0, &E0,   0,   0 ; 9169: C0 C0 C0... ...
 EQUB   0,   0,   0, &F8,   0,   0, &FF, &FF, &FF ; 9172: 00 00 00... ...
 EQUB &FF, &FF, &FF,   7, &FF,   0,   0, &FB, &C3 ; 917B: FF FF FF... ...
 EQUB &C3, &C3, &C3, &C3, &FF, &FF, &FF, &C7, &FF ; 9184: C3 C3 C3... ...
 EQUB &FF, &FF, &FF,   0,   0, &EF, &6D, &6D, &6D ; 918D: FF FF FF... ...
 EQUB &6F, &6C, &FF, &FF, &FF, &7D, &FF, &FF, &FF ; 9196: 6F 6C FF... ol.
 EQUB &FC,   0,   0, &B6, &B6, &B6, &B6, &9E,   6 ; 919F: FC 00 00... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &DF, &67,   0 ; 91A8: FF FF FF... ...
 EQUB   0, &FB, &DB, &DB, &F3, &DB, &DB, &FF, &FF ; 91B1: 00 FB DB... ...
 EQUB &FF, &DF, &FF, &F7, &DF, &FF,   0,   0, &7D ; 91BA: FF DF FF... ...
 EQUB &61, &61, &6D, &6D, &6D, &FF, &FF, &FF, &E3 ; 91C3: 61 61 6D... aam
 EQUB &FF, &FF, &FF, &FF,   0,   0, &B7, &B3, &B3 ; 91CC: FF FF FF... ...
 EQUB &F3, &B3, &B3, &FF, &FF, &FF, &FB, &FF, &FF ; 91D5: F3 B3 B3... ...
 EQUB &BF, &FF,   0,   0, &81,   0,   0,   0,   0 ; 91DE: BF FF 00... ...
 EQUB   0, &FF, &FF, &FF, &7E, &FF, &FF, &FF, &FF ; 91E7: 00 FF FF... ...
 EQUB   0,   0, &DF, &DB, &DB, &DB, &DF, &C3, &FF ; 91F0: 00 00 DF... ...
 EQUB &FF, &FF, &FB, &FF, &FF, &FF, &E3,   0,   0 ; 91F9: FF FF FB... ...
 EQUB &7D, &6C, &6C, &6C, &7C, &0C, &FF, &FF, &FF ; 9202: 7D 6C 6C... }ll
 EQUB &EE, &FF, &FF, &FF, &8F,   0,   0, &C0, &C0 ; 920B: EE FF FF... ...
 EQUB &C0, &C0, &C0, &D8, &FF, &FF, &FF, &FF, &FF ; 9214: C0 C0 C0... ...
 EQUB &FF, &FF, &FF,   0,   0, &F0, &D8, &D8, &D8 ; 921D: FF FF FF... ...
 EQUB &D8, &DB, &FF, &FF, &FF, &DF, &FF, &FF, &FF ; 9226: D8 DB FF... ...
 EQUB &FF,   0,   0, &7D, &6D, &6D, &79, &6D, &6D ; 922F: FF 00 00... ...
 EQUB &FF, &FF, &FF, &EF, &FF, &FB, &EF, &EF,   0 ; 9238: FF FF FF... ...
 EQUB   0, &F7, &B6, &B6, &E7, &B6, &B6, &FF, &FF ; 9241: 00 F7 B6... ...
 EQUB &FF, &BE, &FF, &EF, &BE, &FF,   0,   0, &DF ; 924A: FF BE FF... ...
 EQUB &DB, &DB, &DE, &DB, &DB, &FF, &FF, &FF, &FB ; 9253: DB DB DE... ...
 EQUB &FF, &FE, &FB, &FF,   0,   0, &7D, &61, &61 ; 925C: FF FE FB... ...
 EQUB &79, &61, &61, &FF, &FF, &FF, &E3, &FF, &FF ; 9265: 79 61 61... yaa
 EQUB &E7, &FF,   0,   0, &F0, &B0, &B0, &B0, &B0 ; 926E: E7 FF 00... ...
 EQUB &B0, &FF, &FF, &FF, &BF, &FF, &FF, &FF, &FF ; 9277: B0 FF FF... ...
 EQUB   0,   0, &3E, &36, &36, &3E, &36, &36, &FF ; 9280: 00 00 3E... ..>
 EQUB &FF, &FF, &F7, &FF, &FF, &F7, &FF,   0,   0 ; 9289: FF FF F7... ...
 EQUB &FB, &DB, &DB, &DB, &DB, &DB, &FF, &FF, &FF ; 9292: FB DB DB... ...
 EQUB &DF, &FF, &FF, &FF, &FF,   0,   0, &C0, &60 ; 929B: DF FF FF... ...
 EQUB &60, &60, &60, &60, &FF, &FF, &FF, &7F, &FF ; 92A4: 60 60 60... ```
 EQUB &FF, &FF, &FF,   0,   0, &78, &30, &30, &30 ; 92AD: FF FF FF... ...
 EQUB &30, &33, &FF, &FF, &FF, &B7, &FF, &FF, &FF ; 92B6: 30 33 FF... 03.
 EQUB &FF,   0,   0, &7D, &6D, &6D, &79, &6D, &6D ; 92BF: FF 00 00... ...
 EQUB &FF, &FF, &FF, &EF, &FF, &FB, &EF, &FF,   0 ; 92C8: FF FF FF... ...
 EQUB   0, &F6, &86, &86, &E6, &86, &86, &FF, &FF ; 92D1: 00 F6 86... ...
 EQUB &FF, &8F, &FF, &FF, &9F, &FF,   0,   0, &18 ; 92DA: FF 8F FF... ...
 EQUB &18, &18, &18, &18, &18, &FF, &FF, &FF, &FF ; 92E3: 18 18 18... ...
 EQUB &FF, &FF, &FF, &FF,   0,   0,   0,   0,   0 ; 92EC: FF FF FF... ...
 EQUB &1F,   0,   0, &FF, &FF, &FF, &FF, &FF, &FF ; 92F5: 1F 00 00... ...
 EQUB &E0, &FF,   0,   0,   0, &20, &1F,   0, &20 ; 92FE: E0 FF 00... ...
 EQUB   0, &3F, &3F, &3F, &1F, &20,   0, &5F, &40 ; 9307: 00 3F 3F... .??
 EQUB   0,   0,   0,   0, &FF,   0,   0,   0, &FF ; 9310: 00 00 00... ...
 EQUB &FF, &FF, &FF,   0,   0, &FF,   0,   0,   0 ; 9319: FF FF FF... ...
 EQUB   0, &82,   1, &10, &92, &10, &93, &93, &93 ; 9322: 00 82 01... ...
 EQUB &11, &92,   0, &45, &44,   0,   0,   0,   8 ; 932B: 11 92 00... ...
 EQUB &F0,   1,   9,   1, &F9, &F9, &F9, &F1,   9 ; 9334: F0 01 09... ...
 EQUB   0, &F4,   4,   0,   0,   0,   0,   0,   0 ; 933D: 00 F4 04... ...
 EQUB   1, &0B, &0F, &0F, &1F, &1F, &3F, &3F, &7E ; 9346: 01 0B 0F... ...
 EQUB &74,   0,   0,   0,   0,   0,   0, &80, &D0 ; 934F: 74 00 00... t..
 EQUB &F0, &F0, &F8, &F8, &FC, &FC, &7E, &2E, &FB ; 9358: F0 F0 F8... ...
 EQUB   0,   0,   0, &FF,   0,   0,   0, &FF,   4 ; 9361: 00 00 00... ...
 EQUB &FF, &FF,   0,   0, &FF,   0, &EC,   0,   0 ; 936A: FF FF 00... ...
 EQUB   0, &FF,   0,   0,   0, &FF, &13, &FF, &FF ; 9373: 00 FF 00... ...
 EQUB   0,   0, &FF,   0, &0C,   0,   0,   0, &FF ; 937C: 00 00 FF... ...
 EQUB   0,   0,   0, &FD, &F3, &FF, &FF,   0,   0 ; 9385: 00 00 00... ...
 EQUB &FF,   0, &DB,   0,   0,   0, &FF,   0,   0 ; 938E: FF 00 DB... ...
 EQUB   0, &FF, &24, &FF, &FF,   0,   0, &FF,   0 ; 9397: 00 FF 24... ..$
 EQUB &7D,   0,   0,   0, &FF,   0,   0,   0, &FF ; 93A0: 7D 00 00... }..
 EQUB &82, &FF, &FF,   0,   0, &FF,   0, &B3,   0 ; 93A9: 82 FF FF... ...
 EQUB   0,   0, &FF,   0,   0,   0, &FF, &4C, &FF ; 93B2: 00 00 FF... ...
 EQUB &FF,   0,   0, &FF,   0, &C3,   0,   0,   0 ; 93BB: FF 00 00... ...
 EQUB &FF,   0,   0,   0, &FF, &3C, &FF, &FF,   0 ; 93C4: FF 00 00... ...
 EQUB   0, &FF,   0, &0C,   0,   0,   0, &FF,   0 ; 93CD: 00 FF 00... ...
 EQUB   0,   0, &FF, &F3, &FF, &FF,   0,   0, &FF ; 93D6: 00 00 FF... ...
 EQUB   0, &D8,   0,   0,   0, &FF,   0,   0,   0 ; 93DF: 00 D8 00... ...
 EQUB &FF, &27, &FF, &FF,   0,   0, &FF,   0, &F3 ; 93E8: FF 27 FF... .'.
 EQUB   0,   0,   0, &FF,   0,   0,   0, &F7, &0C ; 93F1: 00 00 00... ...
 EQUB &FF, &FF,   0,   0, &FF,   0, &B6,   0,   0 ; 93FA: FF FF 00... ...
 EQUB   0, &FF,   0,   0,   0, &FF, &49, &FF, &FF ; 9403: 00 FF 00... ...
 EQUB   0,   0, &FF,   0, &DF,   0,   0,   0, &FF ; 940C: 00 00 FF... ...
 EQUB   0,   0,   0, &FF, &20, &FF, &FF,   0,   0 ; 9415: 00 00 00... ...
 EQUB &FF,   0, &B0,   0,   0,   0, &FF,   0,   0 ; 941E: FF 00 B0... ...
 EQUB   0, &FF, &4F, &FF, &FF,   0,   0, &FF,   0 ; 9427: 00 FF 4F... ..O
 EQUB &36,   0,   0,   0, &FF,   0,   0,   0, &FF ; 9430: 36 00 00... 6..
 EQUB &C9, &FF, &FF,   0,   0, &FF,   0, &C0,   0 ; 9439: C9 FF FF... ...
 EQUB   0,   0, &FF,   0,   0,   0, &DF, &3F, &FF ; 9442: 00 00 FF... ...
 EQUB &FF,   0,   0, &FF,   0, &7B,   0,   0,   0 ; 944B: FF 00 00... ...
 EQUB &FF,   0,   0,   0, &FF, &84, &FF, &FF,   0 ; 9454: FF 00 00... ...
 EQUB   0, &FF,   0, &F7,   0,   0,   0, &FF,   0 ; 945D: 00 FF 00... ...
 EQUB   0,   0, &FF,   8, &FF, &FF,   0,   0, &FF ; 9466: 00 00 FF... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 946F: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 9478: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 9481: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 948A: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 9493: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 949C: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 94A5: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 94AE: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 94B7: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 94C0: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 94C9: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 94D2: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 94DB: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 94E4: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 94ED: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 94F6: 00 00 00... ...
 EQUB   0,   9, &0B, &0C,   6, &0D, &0E, &0F, &10 ; 94FF: 00 09 0B... ...
 EQUB   6, &11, &12, &13, &14,   6, &15, &16, &17 ; 9508: 06 11 12... ...
 EQUB &18,   6, &19, &1A, &1B, &1C,   6,   7,   8 ; 9511: 18 06 19... ...
 EQUB   4,   5,   6,   7,   8, &0A, &28, &2A, &2B ; 951A: 04 05 06... ...
 EQUB &26, &2C, &2D, &2E, &2F, &26, &30, &31, &24 ; 9523: 26 2C 2D... &,-
 EQUB &32, &26, &33, &34, &24, &35, &26, &36, &37 ; 952C: 32 26 33... 2&3
 EQUB &38, &39, &26, &25, &27, &24, &25, &26, &25 ; 9535: 38 39 26... 89&
 EQUB &27, &29,   9, &0B, &0C,   6, &0D, &0E, &0F ; 953E: 27 29 09... ').
 EQUB &10,   6, &11, &12, &13, &14, &15, &16, &17 ; 9547: 10 06 11... ...
 EQUB &18, &19, &1A, &1B,   8, &1C, &1D,   6, &1E ; 9550: 18 19 1A... ...
 EQUB &1F, &20, &21,   6, &22, &23, &0A, &28, &2A ; 9559: 1F 20 21... . !
 EQUB &2B, &26, &2C, &2D, &2E, &2F, &26, &30, &31 ; 9562: 2B 26 2C... +&,
 EQUB &32, &33, &26, &34, &35, &36, &37, &26, &38 ; 956B: 32 33 26... 23&
 EQUB &39, &3A, &3B, &26, &3C, &3D, &3E, &3F, &26 ; 9574: 39 3A 3B... 9:;
 EQUB &40, &27, &29,   9, &0B, &0C,   6, &0D, &0E ; 957D: 40 27 29... @')
 EQUB &0F, &10,   6, &11, &12, &13, &14,   6, &15 ; 9586: 0F 10 06... ...
 EQUB &16, &17, &18, &19, &1A, &1B, &1C, &1D,   6 ; 958F: 16 17 18... ...
 EQUB &1E, &1F, &20, &21,   6, &22, &23, &0A, &28 ; 9598: 1E 1F 20... ..
 EQUB &2A, &2B, &26, &2C, &2D, &2E, &2F, &26, &30 ; 95A1: 2A 2B 26... *+&
 EQUB &31, &32, &33, &26, &34, &35, &24, &36, &26 ; 95AA: 31 32 33... 123
 EQUB &37, &38, &39, &3A, &26, &3B, &3C, &3D, &3E ; 95B3: 37 38 39... 789
 EQUB &26, &3F, &27, &29,   9, &0B, &0C, &0D, &0E ; 95BC: 26 3F 27... &?'
 EQUB &0F, &10, &11,   6, &12,   8, &13, &14,   6 ; 95C5: 0F 10 11... ...
.L95CE
 EQUB &15, &16, &17, &18, &0D, &19, &1A, &1B, &1C ; 95CE: 15 16 17... ...
 EQUB   6, &1D, &1E, &1F, &20,   6, &15, &16, &0A ; 95D7: 06 1D 1E... ...
 EQUB &28, &2A, &2B, &26, &2C, &2D, &2E, &2F, &26 ; 95E0: 28 2A 2B... (*+
 EQUB &30, &27, &24, &31, &26, &32, &33, &34, &35 ; 95E9: 30 27 24... 0'$
 EQUB &26, &2C, &36, &37, &38, &26, &39, &3A, &3B ; 95F2: 26 2C 36... &,6
 EQUB &3C, &26, &32, &33, &29, &0A,   5,   8, &0C ; 95FB: 3C 26 32... <&2
 EQUB &0D, &0E, &0F, &10, &11, &12, &13, &14, &15 ; 9604: 0D 0E 0F... ...
 EQUB &16,   8, &17, &18, &19, &1A, &1B, &1C, &1D ; 960D: 16 08 17... ...
 EQUB &1E, &1F, &20, &21, &22, &23, &24,   8,   9 ; 9616: 1E 1F 20... ..
 EQUB &0B, &29, &25, &26, &26, &2B, &2C, &2D, &2E ; 961F: 0B 29 25... .)%
 EQUB &2F, &30, &26, &31, &32, &33, &26, &34, &2F ; 9628: 2F 30 26... /0&
 EQUB &35, &36, &2F, &37, &38, &2E, &39, &3A, &2F ; 9631: 35 36 2F... 56/
 EQUB &3B, &36, &26, &26, &28, &2A, &45, &46, &47 ; 963A: 3B 36 26... ;6&
 EQUB &48, &47, &49, &4A, &4B, &4C, &4D, &4E, &4F ; 9643: 48 47 49... HGI
 EQUB &4D, &4C, &4D, &4E, &4F, &4D, &4C, &4D, &50 ; 964C: 4D 4C 4D... MLM
 EQUB &4F, &4D, &4C, &51, &52, &46, &47, &48, &47 ; 9655: 4F 4D 4C... OML
 EQUB &49, &53, &54, &55, &55, &55, &55, &56, &57 ; 965E: 49 53 54... IST
 EQUB &58, &59,   0, &5A, &5B, &5C, &5D, &5E, &5F ; 9667: 58 59 00... XY.
 EQUB &60, &61, &62, &63, &64, &65,   0, &66, &67 ; 9670: 60 61 62... `ab
 EQUB &68, &69, &6A, &6B, &85, &85, &6E, &54, &55 ; 9679: 68 69 6A... hij
 EQUB &55, &55, &55, &6F, &70,   0, &71, &72, &73 ; 9682: 55 55 55... UUU
 EQUB &74, &75, &76, &77, &78, &79, &7A, &7B, &7C ; 968B: 74 75 76... tuv
 EQUB &7D, &7E, &7F, &80,   0, &81, &82, &83, &84 ; 9694: 7D 7E 7F... }~.
 EQUB &85, &85, &6E, &54, &55, &55, &55, &55, &86 ; 969D: 85 85 6E... ..n
 EQUB &70, &87, &88, &89, &8A, &8B, &8C, &8D, &8C ; 96A6: 70 87 88... p..
 EQUB &8E, &8F, &8C, &90, &8C, &91, &92, &93, &94 ; 96AF: 8E 8F 8C... ...
 EQUB &95, &96, &97, &55, &55, &55, &55, &98, &54 ; 96B8: 95 96 97... ...
 EQUB &55, &55, &55, &55, &99, &9A, &9B, &9C, &9D ; 96C1: 55 55 55... UUU
 EQUB &9E, &9F, &A0, &A1, &A2, &A2, &A3, &A2, &A4 ; 96CA: 9E 9F A0... ...
 EQUB &A0, &A5, &A6, &A7, &A8, &A9, &AA, &AB, &55 ; 96D3: A0 A5 A6... ...
 EQUB &55, &55, &55, &98, &54, &55, &55, &55, &55 ; 96DC: 55 55 55... UUU
 EQUB &AC, &AD, &58, &AE, &AF, &B0, &B1, &B2, &B3 ; 96E5: AC AD 58... ..X
 EQUB &B4, &B5, &B6, &B7, &B8, &B9, &BA, &BB, &BC ; 96EE: B4 B5 B6... ...
 EQUB &BD, &67, &BE, &BF, &55, &55, &55, &55, &98 ; 96F7: BD 67 BE... .g.
 EQUB &54, &55, &55, &55, &55, &C0, &C1,   0,   0 ; 9700: 54 55 55... TUU
 EQUB   0,   0,   0, &C2, &C3, &C4, &C5, &C6, &C7 ; 9709: 00 00 00... ...
 EQUB &C8, &C9,   0,   0,   0,   0,   0, &CA, &97 ; 9712: C8 C9 00... ...
 EQUB &55, &55, &55, &55, &98,   0,   0,   0,   0 ; 971B: 55 55 55... UUU
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 9724: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 972D: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 9736: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 973F: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 9748: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 9751: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0, &32, &17, &3F ; 975A: 00 00 00... ...
 EQUB   5, &21,   7, &E8, &C0, &FC, &E8, &D1, &83 ; 9763: 05 21 07... .!.
 EQUB &21,   7, &98,   0, &80,   4, &AA, &FF,   0 ; 976C: 21 07 98... !..
 EQUB &7F,   0, &13, &55,   7, &AA, &FF,   0, &FF ; 9775: 7F 00 13... ...
 EQUB   0, &13, &55,   0, &10, &21, &38,   4, &AA ; 977E: 00 13 55... ..U
 EQUB &FF,   0, &C7,   0, &13, &55,   0, &32,   1 ; 9787: FF 00 C7... ...
 EQUB   3,   4, &AA, &FF,   0, &FC,   0, &13, &55 ; 9790: 03 04 AA... ...
 EQUB   2, &80,   0, &32,   6, &0C, &5C, &B8, &F8 ; 9799: 02 80 00... ...
 EQUB   0, &7F,   0, &F9, &F3, &A3, &46, &21,   7 ; 97A2: 00 7F 00... ...
 EQUB   9, &FF, &7F,   5, &10, &22, &38, &10,   5 ; 97AB: 09 FF 7F... ...
 EQUB &22, &C7, &33, &28, &38, &38, &10, &0A, &12 ; 97B4: 22 C7 33... ".3
 EQUB   5, &34,   1,   3,   3,   1,   5, &22, &FC ; 97BD: 05 34 01... .4.
 EQUB &34,   2,   3,   3,   1,   2, &22, &80,   6 ; 97C6: 34 02 03... 4..
 EQUB &22, &7F, &23, &80,   2, &35,   1,   3,   3 ; 97CF: 22 7F 23... ".#
 EQUB   1,   1,   4, &22, &FC, &22,   2, &32,   3 ; 97D8: 01 01 04... ...
 EQUB   1, &0A, &FF, &FE,   5, &32,   1,   3,   0 ; 97E1: 01 0A FF... ...
 EQUB &40, &20, &33, &34, &1A, &1F,   0, &FC,   0 ; 97EA: 40 20 33... @ 3
 EQUB &BF, &DF, &CB, &65, &E0, &E8, &FC,   4, &80 ; 97F3: BF DF CB... ...
 EQUB &E0, &34, &17,   3, &3F, &17, &8B, &C1, &60 ; 97FC: E0 34 17... .4.
 EQUB &21, &19,   3, &31,   2, &23,   3, &35,   2 ; 9805: 21 19 03... !..
 EQUB   7,   4,   6,   5, &23,   4, &21,   5,   8 ; 980E: 07 04 06... ...
 EQUB &FF,   5, &12,   3, &21, &0C,   0, &21, &0C ; 9817: FF 05 12... ...
 EQUB   0, &21, &11, &FF, &31, &3F, &24, &22, &21 ; 9820: 00 21 11... .!.
 EQUB &2E, &AE, &23,   8, &22,   9, &22,   8, &C8 ; 9829: 2E AE 23... ..#
 EQUB &F6, &F7, &23, &B6, &B5, &32, &34, &35,   3 ; 9832: F6 F7 23... ..#
 EQUB &F0, &F2, &21, &12,   0, &10,   4, &21,   4 ; 983B: F0 F2 21... ..!
 EQUB &E4, &21, &12, &E0, &32,   2,   1,   2, &50 ; 9844: E4 21 12... .!.
 EQUB &40,   2, &21, &0C, &10, &32,   5, &15, &8A ; 984D: 40 02 21... @.!
 EQUB &90, &40,   9, &21,   1,   3, &21,   2, &0A ; 9856: 90 40 09... .@.
 EQUB &7F,   3, &21,   9, &40,   2, &7F,   6, &FF ; 985F: 7F 03 21... ..!
 EQUB &57,   2, &21,   9, &40,   2, &FF, &57,   5 ; 9868: 57 02 21... W.!
 EQUB &FF, &E0, &5D, &10,   0, &7F,   2, &FF, &E0 ; 9871: FF E0 5D... ..]
 EQUB &5D,   5, &FF, &21,   4, &5D,   0, &21, &17 ; 987A: 5D 05 FF... ]..
 EQUB &40,   2, &FF, &21,   4, &5D,   5, &FF,   0 ; 9883: 40 02 FF... @..
 EQUB &55, &21,   1, &FF,   3, &FF,   0, &55,   5 ; 988C: 55 21 01... U!.
 EQUB &FF, &80, &D5,   0, &FF,   3, &FF, &80, &D5 ; 9895: FF 80 D5... ...
 EQUB   5, &FF, &20, &55,   0, &E8, &21,   2,   2 ; 989E: 05 FF 20... ..
 EQUB &FF, &20, &55,   5, &FF, &21,   6, &5D, &10 ; 98A7: FF 20 55... . U
 EQUB   0, &FD,   2, &FF, &21,   6, &5D,   6, &FF ; 98B0: 00 FD 02... ...
 EQUB &55,   2, &20, &21,   5,   2, &FF, &55,   6 ; 98B9: 55 02 20... U.
 EQUB &80, &7F, &21,   1,   2, &20, &21,   4,   0 ; 98C2: 80 7F 21... ..!
 EQUB &80, &7F, &0C, &80,   3, &40, &80,   2, &32 ; 98CB: 80 7F 0C... ...
 EQUB &0A,   2,   2, &30, &21,   8, &A0, &A8, &51 ; 98D4: 0A 02 02... ...
 EQUB &32,   9,   2,   4, &21, &0F, &4F, &48,   0 ; 98DD: 32 09 02... 2..
 EQUB &21,   8,   4, &20, &21, &27, &48, &21,   7 ; 98E6: 21 08 04... !..
 EQUB &23, &10, &22, &90, &32, &11, &12, &10, &6F ; 98EF: 23 10 22... #."
 EQUB &EF, &23, &6F, &AE, &21, &2C, &AE,   4, &F0 ; 98F8: EF 23 6F... .#o
 EQUB &32,   8,   4,   0, &14, &34, &0F,   7,   3 ; 9901: 32 08 04... 2..
 EQUB   7,   3, &21,   1,   0, &22,   1, &21, &17 ; 990A: 07 03 21... ..!
 EQUB &FC, &F0, &E0, &C1, &80, &81, &32,   1, &17 ; 9913: FC F0 E0... ...
 EQUB   7, &D0, &7F, &36, &1F, &0F,   7,   3,   3 ; 991C: 07 D0 7F... ...
 EQUB   1, &D1,   2, &35,   1,   2,   4,   8,   8 ; 9925: 01 D1 02... ...
 EQUB   0, &FC, &F8, &F0, &E1, &83, &22,   7, &9F ; 992E: 00 FC F8... ...
 EQUB &34,   3,   7, &0F, &1E, &7C, &22, &F8, &60 ; 9937: 34 03 07... 4..
 EQUB &12, &FE, &FD, &FB, &22, &F7, &FF,   8, &28 ; 9940: 12 FE FD... ...
 EQUB &E0,   3, &21, &0C,   0, &21, &0D,   0, &21 ; 9949: E0 03 21... ..!
 EQUB &11, &FF, &31, &3F, &24, &22, &21, &2E, &AE ; 9952: 11 FF 31... ..1
 EQUB &23,   8, &C8, &21,   8, &88, &21,   8, &C8 ; 995B: 23 08 C8... #..
 EQUB &F6, &F7, &36, &36, &37, &36, &37, &36, &37 ; 9964: F6 F7 36... ..6
 EQUB   4, &34,   1,   7, &0C, &38,   4, &41, &33 ; 996D: 04 34 01... .4.
 EQUB   7, &0C, &38,   2, &21, &0F, &78, &C0, &AA ; 9976: 07 0C 38... ..8
 EQUB   4, &21, &0F, &78, &C0, &AA,   2, &21, &0F ; 997F: 04 21 0F... .!.
 EQUB &F8, &AA, &32,   1,   6, &AA, &30, &40, &21 ; 9988: F8 AA 32... ..2
 EQUB &0F, &F8, &AA, &32,   1,   6, &AA, &30, &40 ; 9991: 0F F8 AA... ...
 EQUB &C8, &30, &EA, &80,   0, &AA,   0, &21,   1 ; 999A: C8 30 EA... .0.
 EQUB &C8, &30, &EA, &80,   0, &AA,   0, &33,   1 ; 99A3: C8 30 EA... .0.
 EQUB   4,   8, &BA, &10, &20, &EA, &80,   0, &32 ; 99AC: 04 08 BA... ...
 EQUB   4,   8, &BA, &10, &20, &EA, &80,   0, &32 ; 99B5: 04 08 BA... ...
 EQUB   6,   1, &AA,   2, &AA,   2, &32,   6,   1 ; 99BE: 06 01 AA... ...
 EQUB &AA,   2, &AA,   2, &21,   8, &90, &FA, &21 ; 99C7: AA 02 AA... ...
 EQUB &38, &44, &EB, &22, &80, &21,   8, &90, &FA ; 99D0: 38 44 EB... 8D.
 EQUB &21, &38, &44, &EB, &22, &80,   2, &AA,   2 ; 99D9: 21 38 44... !8D
 EQUB &AA, &C0, &30,   2, &AA,   2, &AA, &C0, &30 ; 99E2: AA C0 30... ..0
 EQUB &22, &80, &AA, &22, &80, &AA, &81, &86, &22 ; 99EB: 22 80 AA... "..
 EQUB &80, &AA, &22, &80, &AA, &81, &86, &10, &21 ; 99F4: 80 AA 22... .."
 EQUB   8, &AB, &3D, &0C, &32, &EA,   1,   1, &10 ; 99FD: 08 AB 3D... ..=
 EQUB   8, &AB, &0C, &32, &EA,   1,   1, &60, &80 ; 9A06: 08 AB 0C... ...
 EQUB &AA,   2, &AA,   2, &60, &80, &AA,   2, &AA ; 9A0F: AA 02 AA... ...
 EQUB   2, &20, &10, &AA, &34,   8,   4, &AA,   1 ; 9A18: 02 20 10... . .
 EQUB   0, &20, &10, &AA, &39,   8,   4, &AA,   1 ; 9A21: 00 20 10... . .
 EQUB   0, &11, &0C, &AA,   1,   0, &AA,   0, &80 ; 9A2A: 00 11 0C... ...
 EQUB &34, &11, &0C, &AA,   1,   0, &AA,   0, &80 ; 9A33: 34 11 0C... 4..
 EQUB &F8, &21, &0F, &AA, &80, &60, &BA, &34, &0C ; 9A3C: F8 21 0F... .!.
 EQUB   2, &F8, &0F, &AA, &80, &60, &BA, &32, &0C ; 9A45: 02 F8 0F... ...
 EQUB   2,   0, &80, &F8, &32, &0F,   1, &AA,   3 ; 9A4E: 02 00 80... ...
 EQUB &80, &F8, &32, &0F,   1, &AA,   6, &C0, &F0 ; 9A57: 80 F8 32... ..2
 EQUB &32, &18, &0E,   4, &C2, &F0, &35, &18, &0E ; 9A60: 32 18 0E... 2..
 EQUB &12, &10, &11, &25, &10, &6C, &EE, &6E, &EE ; 9A69: 12 10 11... ...
 EQUB &6F, &EF, &6F, &EF, &21,   4,   0, &21,   8 ; 9A72: 6F EF 6F... o.o
 EQUB &60,   4, &35,   3,   7,   7, &97, &0F, &13 ; 9A7B: 60 04 35... `.5
 EQUB &22,   1, &80, &21,   1, &40, &20, &33, &18 ; 9A84: 22 01 80... "..
 EQUB   7,   1, &81,   0, &C1, &A0, &D0, &E4, &F8 ; 9A8D: 07 01 81... ...
 EQUB   2, &21,   2,   0, &32,   4,   8, &30, &C0 ; 9A96: 02 21 02... .!.
 EQUB &38,   1,   3,   1,   7, &0B, &17, &4F, &3F ; 9A9F: 38 01 03... 8..
 EQUB   8, &18,   3, &21,   8,   0, &21,   9,   0 ; 9AA8: 08 18 03... ...
 EQUB &21, &15, &FF, &31, &3F, &24, &22, &21, &2A ; 9AB1: 21 15 FF... !..
 EQUB &AA,   8, &21,   8,   0, &24, &10, &22, &18 ; 9ABA: AA 08 21... ..!
 EQUB &30, &6A, &22, &60, &30, &33, &3D, &0E,   7 ; 9AC3: 30 6A 22... 0j"
 EQUB &30, &6A, &22, &60, &30, &36, &3D, &0E,   7 ; 9ACC: 30 6A 22... 0j"
 EQUB   1, &AA, &0C, &30, &40, &D5,   2, &21,   1 ; 9AD5: 01 AA 0C... ...
 EQUB &AA, &21, &0C, &30, &40, &D5,   2, &80, &AA ; 9ADE: AA 21 0C... .!.
 EQUB   3, &55,   2, &80, &AA,   3, &55,   2, &21 ; 9AE7: 03 55 02... .U.
 EQUB   2, &AE, &21,   8, &10, &20, &55, &22, &80 ; 9AF0: 02 AE 21... ..!
 EQUB &21,   2, &AE, &21,   8, &10, &20, &55, &22 ; 9AF9: 21 02 AE... !..
 EQUB &80,   0, &AA,   3, &55,   3, &AA,   3, &55 ; 9B02: 80 00 AA... ...
 EQUB   2, &21,   1, &AB, &3E,   2,   4,   4, &5D ; 9B0B: 02 21 01... .!.
 EQUB   8, &10,   1, &AB,   2,   4,   4, &5D,   8 ; 9B14: 08 10 01... ...
 EQUB &10, &21, &0C, &AB,   3, &55,   2, &21, &0C ; 9B1D: 10 21 0C... .!.
 EQUB &AB,   3, &55,   2, &98, &EA, &23, &80, &D5 ; 9B26: AB 03 55... ..U
 EQUB &22, &80, &98, &EA, &23, &80, &D5, &23, &80 ; 9B2F: 22 80 98... "..
 EQUB &AA, &40, &22, &20, &55, &10, &21,   8, &80 ; 9B38: AA 40 22... .@"
 EQUB &AA, &40, &22, &20, &55, &10, &21,   8, &40 ; 9B41: AA 40 22... .@"
 EQUB &AA, &10, &35,   8,   4, &57,   1,   1, &40 ; 9B4A: AA 10 35... ..5
 EQUB &AA, &10, &33,   8,   4, &57, &23,   1, &AA ; 9B53: AA 10 33... ..3
 EQUB   3, &55,   2, &21,   1, &AA,   3, &55,   2 ; 9B5C: 03 55 02... .U.
 EQUB &80, &EA, &30, &32, &0C,   2, &55,   2, &80 ; 9B65: 80 EA 30... ..0
 EQUB &EA, &30, &32, &0C,   2, &55,   2, &21,   6 ; 9B6E: EA 30 32... .02
 EQUB &AB, &22,   3, &21,   6, &DE, &58, &70, &21 ; 9B77: AB 22 03... .".
 EQUB   6, &AB, &22,   3, &21,   6, &DE, &58, &70 ; 9B80: 06 AB 22... .."
 EQUB   8, &10,   0, &24,   8, &22, &18, &23, &10 ; 9B89: 08 10 00... ...
 EQUB &35, &12, &11, &12, &10, &15, &6F, &EF, &68 ; 9B92: 35 12 11... 5..
 EQUB &E8, &68, &E8, &6A, &EA,   7, &70, &FF, &FC ; 9B9B: E8 68 E8... .h.
 EQUB &24, &BC, &8C, &8D,   3, &40, &23, &C0, &40 ; 9BA4: 24 BC 8C... $..
 EQUB &E0, &20, &60, &A0, &23, &20, &A0,   3, &21 ; 9BAD: E0 20 60... . `
 EQUB &0C,   0, &21, &0C,   0, &21, &1D, &FF, &31 ; 9BB6: 0C 00 21... ..!
 EQUB &3F, &25, &22, &A2, &23,   8, &88, &23,   8 ; 9BBF: 3F 25 22... ?%"
 EQUB &48, &F6, &F7, &76, &21, &37, &B6, &B7, &B6 ; 9BC8: 48 F6 F7... H..
 EQUB &B7,   3, &21,   1,   4, &36, &1C, &0E, &0F ; 9BD1: B7 03 21... ..!
 EQUB   6,   3,   1,   2, &21,   1,   4, &58, &33 ; 9BDA: 06 03 01... ...
 EQUB &2E,   7,   1,   2, &C0, &F0, &A4, &51, &21 ; 9BE3: 2E 07 01... ...
 EQUB &18, &C0, &7A, &21, &0F,   5, &C0, &7A, &21 ; 9BEC: 18 C0 7A... ..z
 EQUB &0F,   4, &80, &21,   1, &AA, &84, &F8, &21 ; 9BF5: 0F 04 80... ...
 EQUB &1F,   3, &21,   1, &AA, &84, &F8, &21, &1F ; 9BFE: 1F 03 21... ..!
 EQUB   4, &AA,   2, &C0, &FF,   3, &AA,   2, &C0 ; 9C07: 04 AA 02... ...
 EQUB &FF,   3, &AA,   3, &AA, &FF,   2, &AA,   3 ; 9C10: FF 03 AA... ...
 EQUB &AA, &FF,   0, &20, &AA, &22, &40, &80, &AA ; 9C19: AA FF 00... ...
 EQUB &80, &7F, &20, &AA, &22, &40, &80, &AA, &80 ; 9C22: 80 7F 20... ..
 EQUB &7F,   0, &AA,   3, &AA,   0, &FF,   0, &AA ; 9C2B: 7F 00 AA... ...
 EQUB   3, &AA,   0, &FF, &80, &AA, &23, &80, &AA ; 9C34: 03 AA 00... ...
 EQUB &80, &FF, &80, &AA, &23, &80, &AA, &80, &FF ; 9C3D: 80 FF 80... ...
 EQUB &21,   4, &AE, &22,   2, &21,   1, &AB,   0 ; 9C46: 21 04 AE... !..
 EQUB &FF, &21,   4, &AE, &22,   2, &21,   1, &AB ; 9C4F: FF 21 04... .!.
 EQUB   0, &FF,   0, &AA,   2, &21,   1, &FF, &80 ; 9C58: 00 FF 00... ...
 EQUB   2, &AA,   2, &21,   1, &FF, &80,   0, &80 ; 9C61: 02 AA 02... ...
 EQUB &EA, &20, &21, &1F, &F8, &80,   2, &80, &EA ; 9C6A: EA 20 21... . !
 EQUB &20, &21, &1F, &F8, &80,   2, &21,   1, &AF ; 9C73: 20 21 1F...  !.
 EQUB &F8, &80,   3, &22,   1, &AF, &F8, &80,   3 ; 9C7C: F8 80 03... ...
 EQUB &21,   2, &C0,   4, &21, &1A, &74, &E0, &C0 ; 9C85: 21 02 C0... !..
 EQUB   2, &35,   3, &0F, &25, &8A, &18,   3, &80 ; 9C8E: 02 35 03... .5.
 EQUB   4, &21, &38, &70, &F0, &60, &C0, &80,   2 ; 9C97: 04 21 38... .!8
 EQUB &23, &10, &21, &12, &22, &10, &32, &11, &16 ; 9CA0: 23 10 21... #.!
 EQUB &6F, &EF, &69, &E8, &6A, &EA, &68, &E9,   3 ; 9CA9: 6F EF 69... o.i
 EQUB &30,   3, &70, &FF, &FC, &22, &8C, &22, &BC ; 9CB2: 30 03 70... 0.p
 EQUB &8C, &8D,   3, &21, &0D,   3, &21, &1C, &FF ; 9CBB: 8C 8D 03... ...
 EQUB &37, &3F, &22, &22, &2F, &2F, &23, &A3, &23 ; 9CC4: 37 3F 22... 7?"
 EQUB   8, &49, &33,   9,   8,   8, &88, &F6, &F7 ; 9CCD: 08 49 33... .I3
 EQUB &22, &36, &76, &75, &74, &75, &21,   3,   3 ; 9CD6: 22 36 76... "6v
 EQUB &C0, &40,   2, &32,   4,   1,   3, &90, &5A ; 9CDF: C0 40 02... .@.
 EQUB   0, &F0, &FE, &32, &1F,   3,   4, &34,   8 ; 9CE8: 00 F0 FE... ...
 EQUB   1, &20,   4,   6, &E0, &FF, &7F, &21, &0F ; 9CF1: 01 20 04... . .
 EQUB   4, &10,   0, &80, &10, &21,   1,   5, &FC ; 9CFA: 04 10 00... ...
 EQUB &12, &21,   1,   3, &C0, &21,   3,   2, &21 ; 9D03: 12 21 01... .!.
 EQUB   6,   5, &F8, &12,   4, &80, &21,   7,   8 ; 9D0C: 06 05 F8... ...
 EQUB &21, &3F,   6, &21, &3F, &40, &BF,   6, &FF ; 9D15: 21 3F 06... !?.
 EQUB   6, &FF,   0, &FF,   6, &FF,   6, &FF,   0 ; 9D1E: 06 FF 00... ...
 EQUB &21, &17,   6, &FF,   6, &FF,   0, &44,   6 ; 9D27: 21 17 06... !..
 EQUB &FF,   6, &FF,   0, &7F,   6, &FC,   6, &FC ; 9D30: FF 06 FF... ...
 EQUB &21,   2, &FD,   5, &21, &1F, &12,   4, &21 ; 9D39: 21 02 FD... !..
 EQUB   1, &E0,   6, &21, &3F, &12, &80,   3, &21 ; 9D42: 01 E0 06... ...
 EQUB   3, &C0,   2, &60,   2, &21,   7, &FF, &FE ; 9D4B: 03 C0 02... ...
 EQUB &F0,   4, &21,   8,   0, &32,   1,   8, &80 ; 9D54: F0 04 21... ..!
 EQUB   0, &21, &0F, &7F, &F8, &C0,   4, &10, &80 ; 9D5D: 00 21 0F... .!.
 EQUB &21,   4, &20,   4, &C0,   3, &32,   3,   2 ; 9D66: 21 04 20... !.
 EQUB   2, &20, &80,   3, &21,   9, &5A,   0, &23 ; 9D6F: 02 20 80... . .
 EQUB &10, &93, &90, &21, &16, &10, &21, &17, &6F ; 9D78: 10 93 90... ...
 EQUB &EF, &23, &68, &A8, &21, &28, &A8,   3, &20 ; 9D81: EF 23 68... .#h
 EQUB   0, &30,   0, &40, &FF, &FC, &24, &8C, &BC ; 9D8A: 00 30 00... .0.
 EQUB &BD,   3, &21,   1,   3, &21, &1C, &FF, &37 ; 9D93: BD 03 21... ..!
 EQUB &3F, &2E, &2E, &2F, &2F, &23, &A3, &23,   8 ; 9D9C: 3F 2E 2E... ?..
 EQUB &48, &21,   8,   0, &21,   8, &80, &F6, &F7 ; 9DA5: 48 21 08... H!.
 EQUB &32, &36, &37, &76, &7E, &74, &7C, &21,   1 ; 9DAE: 32 36 37... 267
 EQUB   7, &21, &0E, &0F, &DF, &34, &0F,   7,   3 ; 9DB7: 07 21 0E... .!.
 EQUB   1,   5, &21, &0C,   5, &FF, &22, &F3, &12 ; 9DC0: 01 05 21... ..!
 EQUB   3, &60,   0, &60,   0, &EE,   3, &23, &17 ; 9DC9: 03 60 00... .`.
 EQUB &22, &11,   3, &21, &29,   0, &21,   1,   0 ; 9DD2: 22 11 03... "..
 EQUB &93,   3, &44, &24, &6C,   3, &80,   0, &98 ; 9DDB: 93 03 44... ..D
 EQUB   0, &80,   3, &7F, &22, &67, &22, &7F, &0B ; 9DE4: 00 80 03... ...
 EQUB &FB, &F0, &E0, &C0, &80,   3, &C0,   7, &21 ; 9DED: FB F0 E0... ...
 EQUB &38,   7, &23, &10, &21, &12, &10, &21,   2 ; 9DF6: 38 07 23... 8.#
 EQUB &10, &21,   5, &6F, &EF, &68, &E8, &68, &78 ; 9DFF: 10 21 05... .!.
 EQUB &34, &2A, &3A,   0, &38, &22, &10, &21, &38 ; 9E08: 34 2A 3A... 4*:
 EQUB   4, &21, &38, &22, &10, &21, &38,   6, &FF ; 9E11: 04 21 38... .!8
 EQUB   7, &FF,   4, &28, &18, &28, &18, &23,   1 ; 9E1A: 07 FF 04... ...
 EQUB &FF, &24, &C0, &23,   1, &FF, &24, &C0,   8 ; 9E23: FF 24 C0... .$.
 EQUB &E0, &98, &86, &81, &86, &98, &E0,   9, &FF ; 9E2C: E0 98 86... ...
 EQUB &81, &42, &32, &24, &18,   3, &C0, &60, &30 ; 9E35: 81 42 32... .B2
 EQUB &34, &18, &0C,   6,   2,   0, &C0, &60, &30 ; 9E3E: 34 18 0C... 4..
 EQUB &34, &18, &0C,   6,   2,   3, &31, &18, &23 ; 9E47: 34 18 0C... 4..
 EQUB &3C, &21, &18, &0B, &34, &18, &3C, &3C, &18 ; 9E50: 3C 21 18... <!.
 EQUB &0D, &22, &18, &0E, &21, &18, &0F, &10, &0F ; 9E59: 0D 22 18... .".
 EQUB &22, &18,   6, &22, &18,   5, &34,   8, &1C ; 9E62: 22 18 06... "..
 EQUB &18,   8,   4, &34, &18, &2C, &24, &18,   3 ; 9E6B: 18 08 04... ...
 EQUB &10, &34, &34, &28, &28, &1C, &10,   2, &36 ; 9E74: 10 34 34... .44
 EQUB &18, &38, &2C, &18, &3C, &18,   9, &28, &18 ; 9E7D: 18 38 2C... .8,
 EQUB &0F, &78, &0E, &78, &21, &18, &0D, &78, &22 ; 9E86: 0F 78 0E... .x.
 EQUB &18, &0C, &78, &23, &18, &0B, &78, &24, &18 ; 9E8F: 18 0C 78... ..x
 EQUB &0A, &78, &25, &18,   9, &78, &26, &18,   8 ; 9E98: 0A 78 25... .x%
 EQUB &78, &27, &18,   3, &13,   2, &FF,   5, &12 ; 9EA1: 78 27 18... x'.
 EQUB   4, &80,   3, &FF,   5, &12,   3, &80, &C0 ; 9EAA: 04 80 03... ...
 EQUB &80,   2, &FF,   5, &12,   3, &C0, &E0, &C0 ; 9EB3: 80 02 FF... ...
 EQUB   2, &FF,   5, &12,   3, &E0, &F0, &E0,   2 ; 9EBC: 02 FF 05... ...
 EQUB &FF,   5, &12,   3, &F0, &F8, &F0,   2, &FF ; 9EC5: FF 05 12... ...
 EQUB   5, &12,   3, &F8, &FC, &F8,   2, &FF,   5 ; 9ECE: 05 12 03... ...
 EQUB &12,   3, &FC, &FE, &FC,   2, &FF,   5, &12 ; 9ED7: 12 03 FC... ...
 EQUB   3, &FE, &FF, &FE,   2, &FF,   5, &12,   3 ; 9EE0: 03 FE FF... ...
 EQUB &13,   2, &FF,   2, &15,   4, &80,   3, &FF ; 9EE9: 13 02 FF... ...
 EQUB   3, &80,   0, &12,   3, &80, &C0, &80,   2 ; 9EF2: 03 80 00... ...
 EQUB &FF,   2, &80, &C0, &80, &12,   3, &C0, &E0 ; 9EFB: FF 02 80... ...
 EQUB &C0,   2, &FF,   2, &C0, &E0, &C0, &12,   3 ; 9F04: C0 02 FF... ...
 EQUB &E0, &F0, &E0,   2, &FF,   2, &E0, &F0, &E0 ; 9F0D: E0 F0 E0... ...
 EQUB &12,   3, &F0, &F8, &F0,   2, &FF,   2, &F0 ; 9F16: 12 03 F0... ...
 EQUB &F8, &F0, &12,   3, &F8, &FC, &F8,   2, &FF ; 9F1F: F8 F0 12... ...
 EQUB   2, &F8, &FC, &F8, &12,   3, &FC, &FE, &FC ; 9F28: 02 F8 FC... ...
 EQUB   2, &FF,   2, &FC, &FE, &FC, &12,   3, &FE ; 9F31: 02 FF 02... ...
 EQUB &FF, &FE,   2, &FF,   2, &FE, &FF, &FE, &12 ; 9F3A: FF FE 02... ...
 EQUB &10, &33, &0C, &3A, &2B, &87, &E3, &A4, &35 ; 9F43: 10 33 0C... .3.
 EQUB   8,   4, &34, &27, &3A, &BB, &48, &90, &21 ; 9F4C: 08 04 34... ..4
 EQUB &18,   2, &33, &18, &24, &18, &0F,   6, &33 ; 9F55: 18 02 33... ..3
 EQUB &18, &3C, &18,   3, &FF, &26, &81, &12, &26 ; 9F5E: 18 3C 18... .<.
 EQUB &81, &FF,   2, &34, &18, &3C, &3C, &18, &0F ; 9F67: 81 FF 02... ...
 EQUB   5, &34, &18, &3C, &3C, &18,   2, &70, &24 ; 9F70: 05 34 18... .4.
 EQUB &60, &23, &C0, &70, &23, &60, &22, &40, &22 ; 9F79: 60 23 C0... `#.
 EQUB &C0, &7F, &24, &60, &23, &C0, &7F, &23, &60 ; 9F82: C0 7F 24... ..$
 EQUB &22, &40, &22, &C0, &22, &60, &24, &C0, &12 ; 9F8B: 22 40 22... "@"
 EQUB &60, &22, &40, &23, &C0, &FF, &FE, &24, &C0 ; 9F94: 60 22 40... `"@
 EQUB &0C, &18,   8, &3F,   7, &21,   1, &0B, &32 ; 9F9D: 0C 18 08... ...
 EQUB   5, &34, &6B, &D6, &9F,   3, &34,   2, &0F ; 9FA6: 05 34 6B... .4k
 EQUB &1F, &3F, &7F,   2, &14, &DF, &B7,   3, &12 ; 9FAF: 1F 3F 7F... .?.
 EQUB &7F, &BF, &CF,   2, &FE, &F5, &F9, &FB, &FD ; 9FB8: 7F BF CF... ...
 EQUB &D3,   3, &22, &FE, &FD, &FB, &FF,   3, &C0 ; 9FC1: D3 03 22... .."
 EQUB &B0, &CC, &F2, &69,   4, &C0, &F0, &EC, &F6 ; 9FCA: B0 CC F2... ...
 EQUB   6, &32,   2, &0B,   6, &32,   1,   7,   5 ; 9FD3: 06 32 02... .2.
 EQUB &21, &2B, &EA, &FC,   5, &21, &1F, &F5, &FF ; 9FDC: 21 2B EA... !+.
 EQUB   4, &21,   1, &FF, &5F, &F9,   5, &12, &21 ; 9FE5: 04 21 01... .!.
 EQUB   7,   4, &9F, &FF, &EE, &BB,   4, &7F, &13 ; 9FEE: 07 04 9F... ...
 EQUB   3, &21, &19, &12, &E0, &BF,   3, &21,   7 ; 9FF7: 03 21 19... .!.
 EQUB &14,   3, &FD, &FB, &E6, &D8, &21, &27,   3 ; A000: 14 03 FD... ...
 EQUB &22, &FE, &12, &DF,   3, &BE, &DF, &DA, &FD ; A009: 22 FE 12... "..
 EQUB &C5,   3, &7F, &BF, &EC, &21, &36, &FB,   3 ; A012: C5 03 7F... ...
 EQUB &60, &FF, &10, &7E, &A7,   3, &80, &FF, &33 ; A01B: 60 FF 10... `..
 EQUB &0F,   1, &18,   4, &21, &1E, &5F, &10, &CE ; A024: 0F 01 18... ...
 EQUB   4, &E0, &FF, &EF, &21, &31,   5, &40, &21 ; A02D: 04 E0 FF... ...
 EQUB   3, &F6,   5, &FF, &FC, &21,   1,   5, &E0 ; A036: 03 F6 05... ...
 EQUB &32, &0A, &2F,   6, &21,   5, &D0,   6, &80 ; A03F: 32 0A 2F... 2./
 EQUB &E0, &0E, &32,   1,   6,   7, &34,   1,   3 ; A048: E0 0E 32... ..2
 EQUB   6, &19, &30, &65, &D2, &67, &87,   0, &38 ; A051: 06 19 30... ..0
 EQUB   1,   6, &0F, &1B, &2F, &1F, &3F, &2F, &5F ; A05A: 01 06 0F... ...
 EQUB &FF, &FE, &79, &F7, &FF, &EF, &16, &F7, &FF ; A063: FF FE 79... ..y
 EQUB &F3, &DF, &EE, &21, &14, &EB, &FD, &FB, &F7 ; A06C: F3 DF EE... ...
 EQUB &DC, &FE, &12, &F6, &FA, &22, &FC, &9E, &F5 ; A075: DC FE 12... ...
 EQUB &CE, &BC, &98, &68, &D0, &E0, &67, &EF, &FF ; A07E: CE BC 98... ...
 EQUB &DF, &FF, &BF, &22, &7F, &B4, &58, &86, &21 ; A087: DF FF BF... ...
 EQUB   3,   0, &21,   1,   2, &FB, &FF, &FD, &FE ; A090: 03 00 21... ..!
 EQUB &14, &80, &40, &10, &48, &B4, &4A, &BF, &21 ; A099: 14 80 40... ..@
 EQUB &2C,   0, &80, &E0, &B0, &48, &A4, &C0, &D1 ; A0A2: 2C 00 80... ,..
 EQUB   7, &C0,   8, &20, &FF,   0, &21,   5,   4 ; A0AB: 07 C0 08... ...
 EQUB &21, &1F,   7, &21,   1, &EA, &21,   2, &7F ; A0B4: 21 1F 07... !..
 EQUB &21,   6,   3, &FE, &21, &14,   6, &6B, &81 ; A0BD: 21 06 03... !..
 EQUB &FA, &FE, &A1, &21, &0E,   2, &21, &1C, &7F ; A0C6: FA FE A1... ...
 EQUB &21,   5,   5, &A7, &8C, &21, &11,   0, &55 ; A0CF: 21 05 05... !..
 EQUB   3, &5F, &F3, &EE,   5, &7E, &DD, &21, &16 ; A0D8: 03 5F F3... ._.
 EQUB &FC, &68, &21, &0A, &85, &21,   1, &FF, &21 ; A0E1: FC 68 21... .h!
 EQUB &3E, &E9, &22,   3, &21,   1,   2, &BF, &7F ; A0EA: 3E E9 22... >."
 EQUB &FD, &32, &3F, &0B, &E8, &F5, &FE, &7F, &12 ; A0F3: FD 32 3F... .2?
 EQUB &C0, &F4,   3, &FB, &FD,   0, &F8, &D4,   2 ; A0FC: C0 F4 03... ...
 EQUB &A1, &FC, &FE, &FF,   5, &78, &86, &BF, &21 ; A105: A1 FC FE... ...
 EQUB &1F,   0, &80, &53,   0, &87, &78,   6, &21 ; A10E: 1F 00 80... ...
 EQUB &3D, &E0, &FF, &F0,   0, &21, &0A, &C0,   0 ; A117: 3D E0 FF... =..
 EQUB &C0, &21, &1F,   6, &83, &FF, &FE,   0, &21 ; A120: C0 21 1F... .!.
 EQUB   2, &C0,   2, &7C,   7, &12,   0, &21, &13 ; A129: 02 C0 02... ...
 EQUB &C0, &0B, &F8, &FE,   0, &80, &0F,   1, &34 ; A132: C0 0B F8... ...
 EQUB   1,   3,   6, &0D,   6, &35,   1,   2, &0D ; A13B: 01 03 06... ...
 EQUB &1F, &3A, &74, &A9, &52, &81, &35, &27,   2 ; A144: 1F 3A 74... .:t
 EQUB   0,   5, &0B, &57, &AF, &21, &3F, &5B, &8F ; A14D: 00 05 0B... ...
 EQUB &34, &1F, &3F, &7F, &3F, &DF, &EE, &FD, &5F ; A156: 34 1F 3F... 4.?
 EQUB &16, &F7, &12, &EF, &D5, &AB, &54, &BB, &71 ; A15F: 16 F7 12... ...
 EQUB &22, &EF, &12, &F7, &FB, &FC, &FE, &F9, &F5 ; A168: 22 EF 12... "..
 EQUB &E9, &B2, &4C, &B2, &DE, &F2, &23, &FE, &FD ; A171: E9 B2 4C... ..L
 EQUB &F3, &CD, &32, &21,   1, &80,   0, &C0, &D0 ; A17A: F3 CD 32... ..2
 EQUB &B4, &AC, &92, &E4, &12, &21, &3F, &6F, &7B ; A183: B4 AC 92... ...
 EQUB &7F, &6F, &21, &23,   6, &80, &A0, &16, &7F ; A18C: 7F 6F 21... .o!
 EQUB &DF, &37, &1C, &2C,   4,   5,   2,   0,   1 ; A195: DF 37 1C... .7.
 EQUB   0, &E0, &F0, &22, &F8, &FC, &22, &FE, &FF ; A19E: 00 E0 F0... ...
 EQUB &E0, &30, &98, &4C, &A7, &FB, &7D, &BD, &0D ; A1A7: E0 30 98... .0.
 EQUB &80, &C0, &60, &0C, &34,   1,   2, &0C, &1D ; A1B0: 80 C0 60... ..`
 EQUB   5, &35,   1,   3,   3, &1A, &1C, &65, &B9 ; A1B9: 05 35 01... .5.
 EQUB &21, &12, &60, &C2, &A1, &33,   4,   1,   2 ; A1C2: 21 12 60... !.`
 EQUB &40, &EC, &DF, &BF, &5E, &4B, &95, &32, &2E ; A1CB: 40 EC DF... @..
 EQUB &17, &6F, &BF, &5F, &FA, &BF, &7F, &12, &21 ; A1D4: 17 6F BF... .o.
 EQUB &3F, &7F, &14, &FB, &54, &E9, &E6, &D8, &7F ; A1DD: 3F 7F 14... ?..
 EQUB &FB, &FD, &FE, &FF, &BE, &D8, &E0, &80, &A5 ; A1E6: FB FD FE... ...
 EQUB &4F, &B5, &CA, &B1, &7E, &21, &1F, &DF, &F8 ; A1EF: 4F B5 CA... O..
 EQUB &F0, &C0,   5, &E2, &82, &21, &3B, &DA, &73 ; A1F8: F0 C0 05... ...
 EQUB &21, &1F, &C3, &D8, &22,   1,   0, &21,   1 ; A201: 21 1F C3... !..
 EQUB   4, &82, &C0, &8E, &CC, &60, &D7, &72, &21 ; A20A: 04 82 C0... ...
 EQUB &18, &61, &20, &60, &36, &21,   7, &28,   1 ; A213: 18 61 20... .a
 EQUB   7, &28, &96, &45, &21, &0F, &F9, &40,   2 ; A21C: 07 28 96... .(.
 EQUB &F7, &79, &21, &3E, &F0, &32,   7, &3F, &12 ; A225: F7 79 21... .y!
 EQUB   0, &D3, &EB, &FE, &BA, &6F, &36, &2E, &0F ; A22E: 00 D3 EB... ...
 EQUB &FF, &2C, &14,   1, &C1, &22, &D0, &FC, &32 ; A237: FF 2C 14... .,.
 EQUB &3D, &1C, &AD, &95, &6D, &73, &21, &3D, &F2 ; A240: 3D 1C AD... =..
 EQUB &80, &C0, &40, &20, &10, &21,   8, &40, &21 ; A249: 80 C0 40... ..@
 EQUB   4, &10, &21,   8, &42, &21, &11, &40, &22 ; A252: 04 10 21... ..!
 EQUB &50, &D0, &0C, &80,   0, &20, &21,   8,   8 ; A25B: 50 D0 0C... P..
 EQUB &21, &3F, &7A, &BD, &9E, &85, &AA, &D9, &FC ; A264: 21 3F 7A... !?z
 EQUB   0, &21,   5, &42, &61, &72, &51, &20,   0 ; A26D: 00 21 05... .!.
 EQUB &45, &8B, &34, &16, &2B, &54, &31, &64, &F2 ; A276: 45 8B 34... E.4
 EQUB &BF, &7D, &FB, &F7, &EF, &CE, &98,   0, &F4 ; A27F: BF 7D FB... .}.
 EQUB &A3, &CC, &10, &44, &90, &60, &FD, &FF, &FC ; A288: A3 CC 10... ...
 EQUB &F0, &E0, &80,   3, &D5, &55,   2, &21,   5 ; A291: F0 E0 80... ...
 EQUB   2, &48,   8, &5B, &4E, &34, &1D, &0A, &51 ; A29A: 02 48 08... .H.
 EQUB   2, &0A, &DF, &FE, &DE, &85, &39, &2E,   3 ; A2A3: 02 0A DF... ...
 EQUB &80,   1,   0,   1,   1,   0,   1,   3, &50 ; A2AC: 80 01 00... ...
 EQUB &E8, &FD, &7F, &D0, &7E, &38, &2F, &15, &2F ; A2B5: E8 FD 7F... ...
 EQUB &17,   2,   0, &2F,   1,   2, &BE, &21,   3 ; A2BE: 17 02 00... ...
 EQUB &42, &F3, &21, &1D, &BF, &22, &ED, &41, &FC ; A2C7: 42 F3 21... B.!
 EQUB &BD, &21, &0C, &E0, &40,   2, &33, &23,   2 ; A2D0: BD 21 0C... .!.
 EQUB &2E,   0, &82, &55, &AD, &EA, &DD, &FD, &D1 ; A2D9: 2E 00 82... ...
 EQUB &FF, &7D, &AA, &50,   0, &FD, &EF, &32, &3B ; A2E2: FF 7D AA... .}.
 EQUB &0C, &BB, &C1, &AA, &FF, &21,   2, &80, &E0 ; A2EB: 0C BB C1... ...
 EQUB &F0, &44, &21, &3E, &55,   0, &50, &70, &B0 ; A2F4: F0 44 21... .D!
 EQUB &D0, &60, &E9, &21, &37, &CA,   8, &34,   4 ; A2FD: D0 60 E9... .`.
 EQUB   2, &16, &0A, &42, &A0, &21,   2, &8E,   8 ; A306: 02 16 0A... ...
 EQUB &35, &0E,   4,   6,   4,   8,   3, &34,   4 ; A30F: 35 0E 04... 5..
 EQUB &0E, &0C,   8,   8, &34,   4, &0C, &1C, &0A ; A318: 0E 0C 08... ...
 EQUB   5, &22, &0E, &21,   4,   2, &60,   5, &80 ; A321: 05 22 0E... .".
 EQUB &50, &7D, &0C, &21, &0D, &0E, &60, &B0,   7 ; A32A: 50 7D 0C... P}.
 EQUB &60, &3E, &0B,   7, &0F, &0A, &1F, &16, &19 ; A333: 60 3E 0B... `>.
 EQUB &0F,   4,   2,   1,   5,   0,   9, &21,   6 ; A33C: 0F 04 02... ...
 EQUB   0, &78, &F8, &68, &70, &22, &F0, &E0,   0 ; A345: 00 78 F8... .x.
 EQUB &90, &10, &90, &A0, &40, &80,   2, &21,   8 ; A34E: 90 10 90... ...
 EQUB   0, &21,   8,   3, &21, &18,   0, &21, &18 ; A357: 00 21 08... .!.
 EQUB   0, &35, &18,   8,   0, &18, &3C, &20, &7E ; A360: 00 35 18... .5.
 EQUB &5A, &3E, &24, &3C, &34, &2C, &3C, &2C,   0 ; A369: 5A 3E 24... Z>$
 EQUB &3C, &18,   0,   8, &18,   0, &18,   3, &A0 ; A372: 3C 18 00... <..
 EQUB   7, &B0, &A0,   8, &33, &3C, &34, &2C,   6 ; A37B: 07 B0 A0... ...
 EQUB &21, &18, &10, &21,   4,   0, &21,   4,   3 ; A384: 21 18 10... !..
 EQUB &21, &18,   0, &37, &2C,   4, &2C,   4,   0 ; A38D: 21 18 00... !..
 EQUB &18, &3C, &20, &7E, &5A, &66, &7E, &7A, &56 ; A396: 18 3C 20... .<
 EQUB &7A, &56,   0, &37, &3C, &18,   0,   4, &2C ; A39F: 7A 56 00... zV.
 EQUB   4, &2C,   2, &A0,   7, &F0, &A0,   0, &A0 ; A3A8: 04 2C 02... .,.
 EQUB   6, &21, &3C, &22, &7A, &21, &24,   4, &37 ; A3B1: 06 21 3C... .!<
 EQUB &18, &24, &24, &18,   0,   8,   8,   3, &21 ; A3BA: 18 24 24... .$$
 EQUB &18,   2, &22, &18, &21,   8,   0, &32, &18 ; A3C3: 18 02 22... .."
 EQUB &3C, &20, &7E, &5A, &3D, &24, &3C, &34, &2C ; A3CC: 3C 20 7E... < ~
 EQUB &2C, &3C,   0, &3C, &18,   0,   8, &18, &18 ; A3D5: 2C 3C 00... ,<.
 EQUB   4, &C0,   7, &E0, &C0,   9, &21, &18, &10 ; A3DE: 04 C0 07... ...
 EQUB   6, &22, &18, &3A, &28,   8, &24,   0,   8 ; A3E7: 06 22 18... .".
 EQUB &10,   8, &10, &34, &34,   2, &10, &21, &18 ; A3F0: 10 08 10... ...
 EQUB &10,   0, &35, &3C, &2C, &34, &2C, &3C, &7E ; A3F9: 10 00 35... ..5
 EQUB &4A, &6A,   0, &10, &21, &18, &10,   2, &22 ; A402: 4A 6A 00... Jj.
 EQUB &34,   2, &A0, &21,   5, &CA, &20,   4, &C0 ; A40B: 34 02 A0... 4..
 EQUB &CE, &21,   4, &C0,   6, &7E, &22, &7A, &66 ; A414: CE 21 04... .!.
 EQUB   4, &36, &18, &24, &24, &18,   0, &0F, &20 ; A41D: 04 36 18... .6.
 EQUB &60,   4, &32,   6, &2F, &78, &F0, &0D, &C0 ; A426: 60 04 32... `.2
 EQUB &32, &0A,   3,   4, &22, &7E, &21, &3C,   5 ; A42F: 32 0A 03... 2..
 EQUB &22, &30,   8, &99, &21, &33, &66, &CC, &99 ; A438: 22 30 08... "0.
 EQUB &21, &33, &0A, &66, &80, &99, &32, &33, &26 ; A441: 21 33 0A... !3.
 EQUB &8C,   3, &4C, &32, &19, &33, &66, &4C, &21 ; A44A: 8C 03 4C... ..L
 EQUB &38, &76, &C2, &C3, &83, &46, &7C, &21, &18 ; A453: 38 76 C2... 8v.
 EQUB &C7, &BB, &23, &7D, &BB, &C7, &FF, &35,   8 ; A45C: C7 BB 23... ..#
 EQUB &2C, &3C, &2C,   4,   3, &34,   4, &1C, &7C ; A465: 2C 3C 2C... ,<,
 EQUB &1C,   4, &80,   0, &CD,   6, &80, &F0,   8 ; A46E: 1C 04 80... ...
 EQUB &60, &70, &30, &32,   8,   4,   3, &7C, &6C ; A477: 60 70 30... `p0
 EQUB &4C, &74, &78,   5, &21,   8,   0, &21,   8 ; A480: 4C 74 78... Ltx
 EQUB   3, &2B,   8,   2, &24,   8, &22, &0C,   2 ; A489: 03 2B 08... .+.
 EQUB &3F,   0,   0,   0,   6, &0F, &16, &10, &16 ; A492: 3F 00 00... ?..
 EQUB   0,   0,   6, &1F, &3F, &3F, &3F, &39,   0 ; A49B: 00 00 06... ...
 EQUB   0,   0,   0,   0, &80, &80, &80,   0,   0 ; A4A4: 00 00 00... ...
 EQUB   0, &80, &C0, &40, &40, &40, &16, &16, &16 ; A4AD: 00 80 C0... ...
 EQUB   6,   0,   0,   0,   0, &39, &39, &39, &19 ; A4B6: 06 00 00... ...
 EQUB   6,   0,   0,   0, &80, &80, &80,   0,   0 ; A4BF: 06 00 00... ...
 EQUB   0,   0,   0, &40, &40, &40, &80,   0,   0 ; A4C8: 00 00 00... ...
 EQUB   0,   0,   0, &22, &80, &C0, &E0, &F0, &F8 ; A4D1: 00 00 00... ...
 EQUB &A0, &80, &40, &22, &20, &10, &32,   8,   4 ; A4DA: A0 80 40... ..@
 EQUB &5E, &0F, &21,   1,   0, &3C,   6, &0C,   0 ; A4E3: 5E 0F 21... ^.!
 EQUB &3C,   6, &CC, &3C,   0,   6, &0A, &12, &22 ; A4EC: 3C 06 CC... <..
 EQUB &42,   0, &21,   4, &4C, &3E, &1D, &1E,   5 ; A4F5: 42 00 21... B.!
 EQUB &0F,   2, &13,   1, &33, &22,   1, &0A,   0 ; A4FE: 0F 02 13... ...
 EQUB &1D, &1C, &21, &1E,   2, &80, &C0, &A0, &78 ; A507: 1D 1C 21... ..!
 EQUB &B0, &78,   0, &80, &40, &20, &50, &88, &48 ; A510: B0 78 00... .x.
 EQUB &84, &36,   2,   1,   1, &0F, &3F, &2F, &7E ; A519: 84 36 02... .6.
 EQUB &F5,   0, &32,   4,   8, &10, &22, &20, &41 ; A522: F5 00 32... ..2
 EQUB &8A, &30, &22, &F0, &A0, &40, &A0, &20,   0 ; A52B: 8A 30 22... .0"
 EQUB &21,   8,   2, &40, &80, &40, &22, &E0, &10 ; A534: 21 08 02... !..
 EQUB   0, &21,   8,   0, &21,   4,   3, &22, &0F ; A53D: 00 21 08... .!.
 EQUB &22,   7, &31,   3, &23,   1, &FA, &71, &37 ; A546: 22 07 31... ".1
 EQUB &36, &3F, &1E, &3B,   7, &8F,   2, &81, &22 ; A54F: 36 3F 1E... 6?.
 EQUB &C0, &E0, &C4, &F8, &70,   2, &80, &C0,   0 ; A558: C0 E0 C4... ...
 EQUB &60, &A8, &F0,   2, &80, &40, &20, &22, &10 ; A561: 60 A8 F0... `..
 EQUB &21,   8,   2, &23, &48, &78, &22, &58,   2 ; A56A: 21 08 02... !..
 EQUB &40,   2, &22, &20,   0, &3E,   1,   3, &0C ; A573: 40 02 22... @."
 EQUB &1A, &35, &2A, &35, &4F,   1,   2,   6, &0C ; A57C: 1A 35 2A... .5*
 EQUB &18, &31, &63, &62, &B8, &D8, &88, &B0,   0 ; A585: 18 31 63... .1c
 EQUB &22, &C5, &86, &32,   7, &27, &77, &4F, &FF ; A58E: 22 C5 86... "..
 EQUB &BF, &21, &3E, &7C,   0, &20, &40, &C0, &22 ; A597: BF 21 3E... .!>
 EQUB &80,   2, &E0, &22, &C0, &22, &80,   3, &21 ; A5A0: 80 02 E0... ...
 EQUB   1,   7, &24,   1,   4, &21,   7, &93, &33 ; A5A9: 01 07 24... ..$
 EQUB   3, &0A, &0A, &40, &43,   0, &F8, &EC, &FC ; A5B2: 03 0A 0A... ...
 EQUB &22, &F5, &FF, &7C, &21, &3D, &C8, &F8, &E8 ; A5BB: 22 F5 FF... "..
 EQUB &F8, &E8, &F8, &F1, &20, &24,   8, &21, &18 ; A5C4: F8 E8 F8... ...
 EQUB &22, &10, &D0, &58, &10, &58, &BC, &22, &30 ; A5CD: 22 10 D0... "..
 EQUB &4C, &90, &22, &20, &60, &40,   2, &21,   2 ; A5D6: 4C 90 22... L."
 EQUB &68, &72, &58, &60, &72, &21, &3B, &10, &32 ; A5DF: 68 72 58... hrX
 EQUB &0B, &33, &4F, &47, &5F, &4F, &67, &35, &2F ; A5E8: 0B 33 4F... .3O
 EQUB &17, &0F, &3A, &1E, &5E, &B4, &32, &26, &1C ; A5F1: 17 0F 3A... ..:
 EQUB &10, &78, &24, &FE, &22, &FC, &F8, &F0,   3 ; A5FA: 10 78 24... .x$
 EQUB &21, &0B,   0, &32,   5,   2,   4, &21,   7 ; A603: 21 0B 00... !..
 EQUB   0, &3E,   3,   1,   0,   2, &17, &23, &FA ; A60C: 00 3E 03... .>.
 EQUB   3, &8A, &0E,   3, &1D,   8, &1B, &FA, &21 ; A615: 03 8A 0E... ...
 EQUB   3, &F3, &F2, &32,   3, &33, &F8, &F3, &21 ; A61E: 03 F3 F2... ...
 EQUB &37, &C4, &22, &37, &EF, &CC,   0, &E4, &21 ; A627: 37 C4 22... 7."
 EQUB   4, &E4, &C4, &21,   4, &E7, &B8, &7F, &D7 ; A630: 04 E4 C4... ...
 EQUB &B1, &21, &21, &B1, &FD, &F1, &21,   3,   0 ; A639: B1 21 21... .!!
 EQUB &31, &2F, &24, &21, &A1, &EB, &E0, &CF, &32 ; A642: 31 2F 24... 1/$
 EQUB   8, &0F, &E8, &EB, &21, &1F, &D6, &21, &1F ; A64B: 08 0F E8... ...
 EQUB &EF, &35,   8, &0F, &0F,   8, &0F, &10,   0 ; A654: EF 35 08... .5.
 EQUB &80, &21, &3F,   0, &BC, &21,   1,   0, &22 ; A65D: 80 21 3F... .!?
 EQUB &E0, &C0, &40, &80, &7F, &7E, &22, &80, &36 ; A666: E0 C0 40... ..@
 EQUB &1C,   8,   7,   3,   0,   1,   0, &7C, &34 ; A66F: 1C 08 07... ...
 EQUB &38, &18, &0F,   7,   3, &10, &21, &38, &10 ; A678: 38 18 0F... 8..
 EQUB &12, &34, &0B,   7, &FE, &18, &10, &30, &12 ; A681: 12 34 0B... .4.
 EQUB &21,   7, &FF, &7F, &32, &0C, &1C, &88, &22 ; A68A: 21 07 FF... !..
 EQUB &AF, &76, &57, &DB, &22, &0C, &21, &1C, &15 ; A693: AF 76 57... .vW
 EQUB &60, &F0, &60, &12, &80, &21,   2, &F8, &70 ; A69C: 60 F0 60... `.`
 EQUB &60, &E0, &12,   0, &22, &FC, &F8, &70, &E0 ; A6A5: 60 E0 12... `..
 EQUB &C0, &80,   3, &7C, &F8, &F0, &E0, &C0,   3 ; A6AE: C0 80 03... ...
 EQUB &36, &3D, &1F,   7,   7,   2,   1,   2, &35 ; A6B7: 36 3D 1F... 6=.
 EQUB   3, &1F, &0F,   1,   3,   3, &AD, &AF, &77 ; A6C0: 03 1F 0F... ...
 EQUB &57, &DA, &AC, &F8, &70, &FE, &12, &FC, &FE ; A6C9: 57 DA AC... W..
 EQUB &F8, &70, &F8, &F0, &E0, &C0,   6, &C0, &80 ; A6D2: F8 70 F8... .p.
 EQUB   5, &FC,   2, &30, &50,   3, &F8,   0, &20 ; A6DB: 05 FC 02... ...
 EQUB &60, &20,   5, &10, &22, &30, &20,   2, &32 ; A6E4: 60 20 05... ` .
 EQUB &0E, &1E, &26, &30,   2, &10, &22, &30, &20 ; A6ED: 0E 1E 26... ..&
 EQUB   2, &22, &3E, &26, &30,   2, &10, &22, &30 ; A6F6: 02 22 3E... .">
 EQUB &20,   2, &28, &30, &22, &C0, &10, &22, &30 ; A6FF: 20 02 28...  .(
 EQUB &20,   2, &22, &FE, &26, &30,   8, &32, &1E ; A708: 20 02 22...  ."
 EQUB &0E,   9, &30, &21, &18,   6, &22, &7E,   3 ; A711: 0E 09 30... ..0
 EQUB &3F, &35, &51, &38, &3F, &11, &0B,   3, &21 ; A71A: 3F 35 51... ?5Q
 EQUB &0C,   2, &21, &0E,   4, &20, &40,   0, &80 ; A723: 0C 02 21... ..!
 EQUB &0C, &0D, &13, &3F, &A0, &E0, &A5, &E9, &10 ; A72C: 0C 0D 13... ...
 EQUB   9, &AD,   2, &20, &0A, &10,   3, &20, &6D ; A735: 09 AD 02... ...
 EQUB &D0, &B9, &3F, &96, &99, &C0, &72, &99, &C0 ; A73E: D0 B9 3F... ..?
 EQUB &76, &88, &D0, &E7, &AD, &E0, &72, &8D, &C0 ; A747: 76 88 D0... v..
 EQUB &72, &AD,   0, &73, &8D, &E0, &72, &AD, &20 ; A750: 72 AD 00... r..
 EQUB &73, &8D,   0, &73, &AD, &40, &73, &8D, &20 ; A759: 73 8D 00... s..
 EQUB &73, &AD, &80, &73, &8D, &60, &73, &AD, &A0 ; A762: 73 AD 80... s..
 EQUB &73, &8D, &80, &73, &A9,   0, &8D, &A0, &73 ; A76B: 73 8D 80... s..
 EQUB &60, &A5, &E9, &10,   9, &AD,   2, &20, &0A ; A774: 60 A5 E9... `..
 EQUB &10,   3, &20, &6D, &D0, &A0, &60, &A9,   0 ; A77D: 10 03 20... ..
 EQUB &99, &9F, &73, &88, &D0, &FA, &A9, &CB, &8D ; A786: 99 9F 73... ..s
 EQUB &2D,   2, &8D, &31,   2, &A9,   3, &8D, &2E ; A78F: 2D 02 8D... -..
 EQUB   2, &8D, &32,   2, &A9,   0, &8D, &36,   2 ; A798: 02 8D 32... ..2
 EQUB &A2, &18, &A0, &38, &A9, &DA, &99,   1,   2 ; A7A1: A2 18 A0... ...
 EQUB &A9,   0, &99,   2,   2, &C8, &C8, &C8, &C8 ; A7AA: A9 00 99... ...
 EQUB &CA, &D0, &EF                               ; A7B3: CA D0 EF    ...

 RTS                                              ; A7B6: 60          `

 JSR LD167                                        ; A7B7: 20 67 D1     g.
 LDA L00F5                                        ; A7BA: A5 F5       ..
 PHA                                              ; A7BC: 48          H
 LDA #0                                           ; A7BD: A9 00       ..
 STA L00F5                                        ; A7BF: 85 F5       ..
 STA PPUCTRL                                      ; A7C1: 8D 00 20    ..
 STA L00E9                                        ; A7C4: 85 E9       ..
 LDA #0                                           ; A7C6: A9 00       ..
 STA PPUMASK                                      ; A7C8: 8D 01 20    ..
 LDA W                                            ; A7CB: A5 9E       ..
 CMP #&B9                                         ; A7CD: C9 B9       ..
 BNE CA7D4                                        ; A7CF: D0 03       ..
 JMP CA87D                                        ; A7D1: 4C 7D A8    L}.

.CA7D4
 CMP #&9D                                         ; A7D4: C9 9D       ..
 BEQ CA83A                                        ; A7D6: F0 62       .b
 CMP #&DF                                         ; A7D8: C9 DF       ..
 BEQ CA83A                                        ; A7DA: F0 5E       .^
 CMP #&96                                         ; A7DC: C9 96       ..
 BNE CA7E6                                        ; A7DE: D0 06       ..
 JSR LEF88                                        ; A7E0: 20 88 EF     ..
 JMP CA8A2                                        ; A7E3: 4C A2 A8    L..

.CA7E6
 CMP #&98                                         ; A7E6: C9 98       ..
 BNE CA7F0                                        ; A7E8: D0 06       ..
 JSR LEFA4                                        ; A7EA: 20 A4 EF     ..
 JMP CA8A2                                        ; A7ED: 4C A2 A8    L..

.CA7F0
 CMP #&BA                                         ; A7F0: C9 BA       ..
 BNE CA810                                        ; A7F2: D0 1C       ..
 LDA #4                                           ; A7F4: A9 04       ..
 STA PPUADDR                                      ; A7F6: 8D 06 20    ..
 LDA #&50 ; 'P'                                   ; A7F9: A9 50       .P
 STA PPUADDR                                      ; A7FB: 8D 06 20    ..
 LDA #&A4                                         ; A7FE: A9 A4       ..
 STA SC_1                                         ; A800: 85 08       ..
 LDA #&93                                         ; A802: A9 93       ..
 STA SC                                           ; A804: 85 07       ..
 LDA #&F5                                         ; A806: A9 F5       ..
 STA L048B                                        ; A808: 8D 8B 04    ...
 LDX #4                                           ; A80B: A2 04       ..
 JMP CA89F                                        ; A80D: 4C 9F A8    L..

.CA810
 CMP #&BB                                         ; A810: C9 BB       ..
 BNE CA82A                                        ; A812: D0 16       ..
 LDA #4                                           ; A814: A9 04       ..
 STA PPUADDR                                      ; A816: 8D 06 20    ..
 LDA #&50 ; 'P'                                   ; A819: A9 50       .P
 STA PPUADDR                                      ; A81B: 8D 06 20    ..
 LDA #&A4                                         ; A81E: A9 A4       ..
 STA V_1                                          ; A820: 85 64       .d
 LDA #&D3                                         ; A822: A9 D3       ..
 STA V                                            ; A824: 85 63       .c
 LDA #3                                           ; A826: A9 03       ..
 BNE CA891                                        ; A828: D0 67       .g
.CA82A
 LDA #0                                           ; A82A: A9 00       ..
 CMP L048B                                        ; A82C: CD 8B 04    ...
 BEQ CA8A2                                        ; A82F: F0 71       .q
 STA L048B                                        ; A831: 8D 8B 04    ...
 JSR sub_CA95D                                    ; A834: 20 5D A9     ].
 JMP CA8A2                                        ; A837: 4C A2 A8    L..

.CA83A
 LDA #&24 ; '$'                                   ; A83A: A9 24       .$
 STA L00D9                                        ; A83C: 85 D9       ..
 LDA #1                                           ; A83E: A9 01       ..
 CMP L048B                                        ; A840: CD 8B 04    ...
 BEQ CA8A2                                        ; A843: F0 5D       .]
 STA L048B                                        ; A845: 8D 8B 04    ...
 LDA #4                                           ; A848: A9 04       ..
 STA PPUADDR                                      ; A84A: 8D 06 20    ..
 LDA #&40 ; '@'                                   ; A84D: A9 40       .@
 STA PPUADDR                                      ; A84F: 8D 06 20    ..
 LDX #&5F ; '_'                                   ; A852: A2 5F       ._
 LDA #&FC                                         ; A854: A9 FC       ..
 STA SC_1                                         ; A856: 85 08       ..
 LDA #&E8                                         ; A858: A9 E8       ..
 STA SC                                           ; A85A: 85 07       ..
 JSR sub_CA909                                    ; A85C: 20 09 A9     ..
 LDA W                                            ; A85F: A5 9E       ..
 CMP #&DF                                         ; A861: C9 DF       ..
 BNE CA8A2                                        ; A863: D0 3D       .=
 LDA #&0E                                         ; A865: A9 0E       ..
 STA PPUADDR                                      ; A867: 8D 06 20    ..
 LDA #&30 ; '0'                                   ; A86A: A9 30       .0
 STA PPUADDR                                      ; A86C: 8D 06 20    ..
 LDA #&A7                                         ; A86F: A9 A7       ..
 STA V_1                                          ; A871: 85 64       .d
 LDA #&1B                                         ; A873: A9 1B       ..
 STA V                                            ; A875: 85 63       .c
 JSR LF5AF                                        ; A877: 20 AF F5     ..
 JMP CA8A2                                        ; A87A: 4C A2 A8    L..

.CA87D
 LDA #4                                           ; A87D: A9 04       ..
 STA PPUADDR                                      ; A87F: 8D 06 20    ..
 LDA #&50 ; 'P'                                   ; A882: A9 50       .P
 STA PPUADDR                                      ; A884: 8D 06 20    ..
 LDA #&9F                                         ; A887: A9 9F       ..
 STA V_1                                          ; A889: 85 64       .d
 LDA #&A1                                         ; A88B: A9 A1       ..
 STA V                                            ; A88D: 85 63       .c
 LDA #2                                           ; A88F: A9 02       ..
.CA891
 CMP L048B                                        ; A891: CD 8B 04    ...
 BEQ CA8A2                                        ; A894: F0 0C       ..
 STA L048B                                        ; A896: 8D 8B 04    ...
 JSR LF5AF                                        ; A899: 20 AF F5     ..
 JMP CA8A2                                        ; A89C: 4C A2 A8    L..

.CA89F
 JSR LD986                                        ; A89F: 20 86 D9     ..
.CA8A2
 JSR sub_CAC86                                    ; A8A2: 20 86 AC     ..
 LDA #&10                                         ; A8A5: A9 10       ..
 STA PPUADDR                                      ; A8A7: 8D 06 20    ..
 LDA #0                                           ; A8AA: A9 00       ..
 STA PPUADDR                                      ; A8AC: 8D 06 20    ..
 LDY #0                                           ; A8AF: A0 00       ..
 LDX #&50 ; 'P'                                   ; A8B1: A2 50       .P
.loop_CA8B3
 LDA LAA6C,Y                                      ; A8B3: B9 6C AA    .l.
 STA PPUDATA                                      ; A8B6: 8D 07 20    ..
 INY                                              ; A8B9: C8          .
 DEX                                              ; A8BA: CA          .
 BNE loop_CA8B3                                   ; A8BB: D0 F6       ..
 LDA #&1F                                         ; A8BD: A9 1F       ..
 STA PPUADDR                                      ; A8BF: 8D 06 20    ..
 LDA #&F0                                         ; A8C2: A9 F0       ..
 STA PPUADDR                                      ; A8C4: 8D 06 20    ..
 LDA #0                                           ; A8C7: A9 00       ..
 LDX #&10                                         ; A8C9: A2 10       ..
.loop_CA8CB
 STA PPUDATA                                      ; A8CB: 8D 07 20    ..
 DEX                                              ; A8CE: CA          .
 BNE loop_CA8CB                                   ; A8CF: D0 FA       ..
 JSR LD946                                        ; A8D1: 20 46 D9     F.
 LDX #0                                           ; A8D4: A2 00       ..
 JSR sub_CA972                                    ; A8D6: 20 72 A9     r.
 LDX #1                                           ; A8D9: A2 01       ..
 JSR sub_CA972                                    ; A8DB: 20 72 A9     r.
 LDX #0                                           ; A8DE: A2 00       ..
 STX L00F3                                        ; A8E0: 86 F3       ..
 STX L00F4                                        ; A8E2: 86 F4       ..
 JSR LD8EC                                        ; A8E4: 20 EC D8     ..
 JSR LD946                                        ; A8E7: 20 46 D9     F.
 LDA W                                            ; A8EA: A5 9E       ..
 STA QQ11                                         ; A8EC: 85 9F       ..
 AND #&40 ; '@'                                   ; A8EE: 29 40       )@
 BEQ CA8FC                                        ; A8F0: F0 0A       ..
 LDA W                                            ; A8F2: A5 9E       ..
 CMP #&DF                                         ; A8F4: C9 DF       ..
 BEQ CA8FC                                        ; A8F6: F0 04       ..
 LDA #0                                           ; A8F8: A9 00       ..
 BEQ CA8FE                                        ; A8FA: F0 02       ..
.CA8FC
 LDA #&80                                         ; A8FC: A9 80       ..
.CA8FE
 STA L00EA                                        ; A8FE: 85 EA       ..
 PLA                                              ; A900: 68          h
 STA L00F5                                        ; A901: 85 F5       ..
 STA PPUCTRL                                      ; A903: 8D 00 20    ..
 JMP LEEE8                                        ; A906: 4C E8 EE    L..

.sub_CA909
 LDY #0                                           ; A909: A0 00       ..
.CA90B
 LDA (SC),Y                                       ; A90B: B1 07       ..
 STA PPUDATA                                      ; A90D: 8D 07 20    ..
 INY                                              ; A910: C8          .
 LDA (SC),Y                                       ; A911: B1 07       ..
 STA PPUDATA                                      ; A913: 8D 07 20    ..
 INY                                              ; A916: C8          .
 LDA (SC),Y                                       ; A917: B1 07       ..
 STA PPUDATA                                      ; A919: 8D 07 20    ..
 INY                                              ; A91C: C8          .
 LDA (SC),Y                                       ; A91D: B1 07       ..
 STA PPUDATA                                      ; A91F: 8D 07 20    ..
 INY                                              ; A922: C8          .
 LDA (SC),Y                                       ; A923: B1 07       ..
 STA PPUDATA                                      ; A925: 8D 07 20    ..
 INY                                              ; A928: C8          .
 LDA (SC),Y                                       ; A929: B1 07       ..
 STA PPUDATA                                      ; A92B: 8D 07 20    ..
 INY                                              ; A92E: C8          .
 LDA (SC),Y                                       ; A92F: B1 07       ..
 STA PPUDATA                                      ; A931: 8D 07 20    ..
 INY                                              ; A934: C8          .
 LDA (SC),Y                                       ; A935: B1 07       ..
 STA PPUDATA                                      ; A937: 8D 07 20    ..
 INY                                              ; A93A: C8          .
 BNE CA93F                                        ; A93B: D0 02       ..
 INC SC_1                                         ; A93D: E6 08       ..
.CA93F
 LDA #0                                           ; A93F: A9 00       ..
 STA PPUDATA                                      ; A941: 8D 07 20    ..
 STA PPUDATA                                      ; A944: 8D 07 20    ..
 STA PPUDATA                                      ; A947: 8D 07 20    ..
 STA PPUDATA                                      ; A94A: 8D 07 20    ..
 STA PPUDATA                                      ; A94D: 8D 07 20    ..
 STA PPUDATA                                      ; A950: 8D 07 20    ..
 STA PPUDATA                                      ; A953: 8D 07 20    ..
 STA PPUDATA                                      ; A956: 8D 07 20    ..
 DEX                                              ; A959: CA          .
 BNE CA90B                                        ; A95A: D0 AF       ..
 RTS                                              ; A95C: 60          `

.sub_CA95D
 LDA #4                                           ; A95D: A9 04       ..
 STA PPUADDR                                      ; A95F: 8D 06 20    ..
 LDA #&50 ; 'P'                                   ; A962: A9 50       .P
 STA PPUADDR                                      ; A964: 8D 06 20    ..
 LDA #&97                                         ; A967: A9 97       ..
 STA V_1                                          ; A969: 85 64       .d
 LDA #&60 ; '`'                                   ; A96B: A9 60       .`
 STA V                                            ; A96D: 85 63       .c
 JMP LF5AF                                        ; A96F: 4C AF F5    L..

.sub_CA972
 STX L00C0                                        ; A972: 86 C0       ..
 STX L00F4                                        ; A974: 86 F4       ..
 STX L00F3                                        ; A976: 86 F3       ..
 LDA #0                                           ; A978: A9 00       ..
 STA L00CC                                        ; A97A: 85 CC       ..
 LDA W                                            ; A97C: A5 9E       ..
 CMP #&DF                                         ; A97E: C9 DF       ..
 BNE CA986                                        ; A980: D0 04       ..
 LDA #4                                           ; A982: A9 04       ..
 BNE CA988                                        ; A984: D0 02       ..
.CA986
 LDA #&25 ; '%'                                   ; A986: A9 25       .%
.CA988
 STA L00D2                                        ; A988: 85 D2       ..
 LDA L00B8                                        ; A98A: A5 B8       ..
 STA L00C1,X                                      ; A98C: 95 C1       ..
 LDA #&C4                                         ; A98E: A9 C4       ..
 JSR LD977                                        ; A990: 20 77 D9     w.
 JSR CA99B                                        ; A993: 20 9B A9     ..
 LDA L00B8                                        ; A996: A5 B8       ..
 STA L00C3,X                                      ; A998: 95 C3       ..
 RTS                                              ; A99A: 60          `

.CA99B
 TXA                                              ; A99B: 8A          .
 PHA                                              ; A99C: 48          H
 LDA #&3F ; '?'                                   ; A99D: A9 3F       .?
 STA L00D1                                        ; A99F: 85 D1       ..
 LDA #&FF                                         ; A9A1: A9 FF       ..
 STA L00D0                                        ; A9A3: 85 D0       ..
 JSR LC6F4                                        ; A9A5: 20 F4 C6     ..
 PLA                                              ; A9A8: 68          h
 PHA                                              ; A9A9: 48          H
 TAX                                              ; A9AA: AA          .
 LDA L03EF,X                                      ; A9AB: BD EF 03    ...
 AND #&20 ; ' '                                   ; A9AE: 29 20       )
 BNE CA9CC                                        ; A9B0: D0 1A       ..
 LDA #&10                                         ; A9B2: A9 10       ..
 STA L00D1                                        ; A9B4: 85 D1       ..
 LDA #0                                           ; A9B6: A9 00       ..
 STA L00D0                                        ; A9B8: 85 D0       ..
 JSR LC6F4                                        ; A9BA: 20 F4 C6     ..
 PLA                                              ; A9BD: 68          h
 TAX                                              ; A9BE: AA          .
 LDA L03EF,X                                      ; A9BF: BD EF 03    ...
 AND #&20 ; ' '                                   ; A9C2: 29 20       )
 BNE CA9CE                                        ; A9C4: D0 08       ..
 JSR LD946                                        ; A9C6: 20 46 D9     F.
 JMP CA99B                                        ; A9C9: 4C 9B A9    L..

.CA9CC
 PLA                                              ; A9CC: 68          h
 TAX                                              ; A9CD: AA          .
.CA9CE
 JMP LD946                                        ; A9CE: 4C 46 D9    LF.

 PHA                                              ; A9D1: 48          H
 JSR LD8C5                                        ; A9D2: 20 C5 D8     ..
 LDA W                                            ; A9D5: A5 9E       ..
 CMP #&96                                         ; A9D7: C9 96       ..
 BNE CA9E1                                        ; A9D9: D0 06       ..
 JSR LEF96                                        ; A9DB: 20 96 EF     ..
 JMP CA9E8                                        ; A9DE: 4C E8 A9    L..

.CA9E1
 CMP #&98                                         ; A9E1: C9 98       ..
 BNE CA9E8                                        ; A9E3: D0 03       ..
 JSR LEFB2                                        ; A9E5: 20 B2 EF     ..
.CA9E8
 LDA W                                            ; A9E8: A5 9E       ..
 AND #&40 ; '@'                                   ; A9EA: 29 40       )@
 BEQ CA9F2                                        ; A9EC: F0 04       ..
 LDA #0                                           ; A9EE: A9 00       ..
 STA L00EA                                        ; A9F0: 85 EA       ..
.CA9F2
 JSR sub_CAC86                                    ; A9F2: 20 86 AC     ..
 LDA #0                                           ; A9F5: A9 00       ..
 STA L00CC                                        ; A9F7: 85 CC       ..
 LDA #&25 ; '%'                                   ; A9F9: A9 25       .%
 STA L00D2                                        ; A9FB: 85 D2       ..
 LDA L00B8                                        ; A9FD: A5 B8       ..
 STA L00C1                                        ; A9FF: 85 C1       ..
 STA L00C2                                        ; AA01: 85 C2       ..
 LDA #&54 ; 'T'                                   ; AA03: A9 54       .T
 LDX #0                                           ; AA05: A2 00       ..
 PLA                                              ; AA07: 68          h
 JSR LD977                                        ; AA08: 20 77 D9     w.
 INC L00C0                                        ; AA0B: E6 C0       ..
 JSR LD977                                        ; AA0D: 20 77 D9     w.
 JSR LD8C5                                        ; AA10: 20 C5 D8     ..
 LDA #&50 ; 'P'                                   ; AA13: A9 50       .P
 STA L00CD                                        ; AA15: 85 CD       ..
 STA L00CE                                        ; AA17: 85 CE       ..
 LDA W                                            ; AA19: A5 9E       ..
 STA QQ11                                         ; AA1B: 85 9F       ..
 LDA L00B8                                        ; AA1D: A5 B8       ..
 STA L00C3                                        ; AA1F: 85 C3       ..
 STA L00C4                                        ; AA21: 85 C4       ..
 LDA #0                                           ; AA23: A9 00       ..
 LDX #0                                           ; AA25: A2 00       ..
 STX L00F3                                        ; AA27: 86 F3       ..
 STX L00F4                                        ; AA29: 86 F4       ..
 JSR LD8EC                                        ; AA2B: 20 EC D8     ..
 LDA W                                            ; AA2E: A5 9E       ..
 AND #&40 ; '@'                                   ; AA30: 29 40       )@
 BNE CAA3B                                        ; AA32: D0 07       ..
 JSR LD167                                        ; AA34: 20 67 D1     g.
 LDA #&80                                         ; AA37: A9 80       ..
 STA L00EA                                        ; AA39: 85 EA       ..
.CAA3B
 LDA L0473                                        ; AA3B: AD 73 04    .s.
 BPL CAA43                                        ; AA3E: 10 03       ..
 JMP LEEE8                                        ; AA40: 4C E8 EE    L..

.CAA43
 LDA W                                            ; AA43: A5 9E       ..
 AND #&0F                                         ; AA45: 29 0F       ).
 TAX                                              ; AA47: AA          .
 LDA LAA5C,X                                      ; AA48: BD 5C AA    .\.
 CMP L03F2                                        ; AA4B: CD F2 03    ...
 STA L03F2                                        ; AA4E: 8D F2 03    ...
 JSR sub_CB57F                                    ; AA51: 20 7F B5     ..
 DEC L00DA                                        ; AA54: C6 DA       ..
 JSR LD167                                        ; AA56: 20 67 D1     g.
 INC L00DA                                        ; AA59: E6 DA       ..
 RTS                                              ; AA5B: 60          `

.LAA5C
 EQUB   0,   2, &0A, &0A,   0, &0A,   6,   8,   8 ; AA5C: 00 02 0A... ...
 EQUB   5,   1,   7,   3,   4,   0,   9           ; AA65: 05 01 07... ...
.LAA6C
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; AA6C: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; AA75: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   3,   3,   3 ; AA7E: 00 00 00... ...
 EQUB   3,   3,   3,   3,   3,   0,   0,   0,   0 ; AA87: 03 03 03... ...
 EQUB   0,   0,   0,   0, &C0, &C0, &C0, &C0, &C0 ; AA90: 00 00 00... ...
 EQUB &C0, &C0, &C0,   0,   0,   0,   0,   0,   0 ; AA99: C0 C0 C0... ...
 EQUB   0,   0,   0,   0,   0, &FF, &FF, &FF,   0 ; AAA2: 00 00 00... ...
 EQUB   0,   0,   0,   0,   0,   0,   0,   0,   0 ; AAAB: 00 00 00... ...
 EQUB &0F, &1F, &1F, &DF, &DF, &BF, &BF, &BF      ; AAB4: 0F 1F 1F... ...

 JSR LD933                                        ; AABC: 20 33 D9     3.
 LDA #2                                           ; AABF: A9 02       ..
 STA L00D5                                        ; AAC1: 85 D5       ..
 LDA #&80                                         ; AAC3: A9 80       ..
 STA L00D4                                        ; AAC5: 85 D4       ..
 LDA #&3F ; '?'                                   ; AAC7: A9 3F       .?
 STA PPUADDR                                      ; AAC9: 8D 06 20    ..
 LDA #0                                           ; AACC: A9 00       ..
 STA PPUADDR                                      ; AACE: 8D 06 20    ..
 LDA #&0F                                         ; AAD1: A9 0F       ..
 LDX #&1F                                         ; AAD3: A2 1F       ..
.loop_CAAD5
 STA PPUDATA                                      ; AAD5: 8D 07 20    ..
 DEX                                              ; AAD8: CA          .
 BPL loop_CAAD5                                   ; AAD9: 10 FA       ..
 LDA #&20 ; ' '                                   ; AADB: A9 20       .
 STA PPUADDR                                      ; AADD: 8D 06 20    ..
 LDA #0                                           ; AAE0: A9 00       ..
 STA PPUADDR                                      ; AAE2: 8D 06 20    ..
 LDA #0                                           ; AAE5: A9 00       ..
 LDX #8                                           ; AAE7: A2 08       ..
 LDY #0                                           ; AAE9: A0 00       ..
.CAAEB
 STA PPUDATA                                      ; AAEB: 8D 07 20    ..
 DEY                                              ; AAEE: 88          .
 BNE CAAEB                                        ; AAEF: D0 FA       ..
 JSR LD933                                        ; AAF1: 20 33 D9     3.
 LDA #0                                           ; AAF4: A9 00       ..
 DEX                                              ; AAF6: CA          .
 BNE CAAEB                                        ; AAF7: D0 F2       ..
 LDA #&F5                                         ; AAF9: A9 F5       ..
 STA L03F2                                        ; AAFB: 8D F2 03    ...
 STA L048B                                        ; AAFE: 8D 8B 04    ...
 LDA #0                                           ; AB01: A9 00       ..
 STA PPUADDR                                      ; AB03: 8D 06 20    ..
 LDA #0                                           ; AB06: A9 00       ..
 STA PPUADDR                                      ; AB08: 8D 06 20    ..
 LDY #0                                           ; AB0B: A0 00       ..
 LDX #&50 ; 'P'                                   ; AB0D: A2 50       .P
.loop_CAB0F
 LDA LAA6C,Y                                      ; AB0F: B9 6C AA    .l.
 STA PPUDATA                                      ; AB12: 8D 07 20    ..
 INY                                              ; AB15: C8          .
 DEX                                              ; AB16: CA          .
 BNE loop_CAB0F                                   ; AB17: D0 F6       ..
 LDA #&10                                         ; AB19: A9 10       ..
 STA PPUADDR                                      ; AB1B: 8D 06 20    ..
 LDA #0                                           ; AB1E: A9 00       ..
 STA PPUADDR                                      ; AB20: 8D 06 20    ..
 LDY #0                                           ; AB23: A0 00       ..
 LDX #&50 ; 'P'                                   ; AB25: A2 50       .P
.loop_CAB27
 LDA LAA6C,Y                                      ; AB27: B9 6C AA    .l.
 STA PPUDATA                                      ; AB2A: 8D 07 20    ..
 INY                                              ; AB2D: C8          .
 DEX                                              ; AB2E: CA          .
 BNE loop_CAB27                                   ; AB2F: D0 F6       ..
 LDY #0                                           ; AB31: A0 00       ..
.loop_CAB33
 LDA #&F0                                         ; AB33: A9 F0       ..
 STA L0200,Y                                      ; AB35: 99 00 02    ...
 INY                                              ; AB38: C8          .
 LDA #&FE                                         ; AB39: A9 FE       ..
 STA L0200,Y                                      ; AB3B: 99 00 02    ...
 INY                                              ; AB3E: C8          .
 LDA #3                                           ; AB3F: A9 03       ..
 STA L0200,Y                                      ; AB41: 99 00 02    ...
 INY                                              ; AB44: C8          .
 LDA #0                                           ; AB45: A9 00       ..
 STA L0200,Y                                      ; AB47: 99 00 02    ...
 INY                                              ; AB4A: C8          .
 BNE loop_CAB33                                   ; AB4B: D0 E6       ..
 JSR sub_CA95D                                    ; AB4D: 20 5D A9     ].
 LDA #&9D                                         ; AB50: A9 9D       ..
 STA L0200                                        ; AB52: 8D 00 02    ...
 LDA #&FE                                         ; AB55: A9 FE       ..
 STA L0201                                        ; AB57: 8D 01 02    ...
 LDA #&F8                                         ; AB5A: A9 F8       ..
 STA L0203                                        ; AB5C: 8D 03 02    ...
 LDA #&23 ; '#'                                   ; AB5F: A9 23       .#
 STA L0202                                        ; AB61: 8D 02 02    ...
 LDA #&FB                                         ; AB64: A9 FB       ..
 STA L0205                                        ; AB66: 8D 05 02    ...
 STA L0209                                        ; AB69: 8D 09 02    ...
 LDA #&FD                                         ; AB6C: A9 FD       ..
 STA L020D                                        ; AB6E: 8D 0D 02    ...
 STA L0211                                        ; AB71: 8D 11 02    ...
 LDA #3                                           ; AB74: A9 03       ..
 STA L0206                                        ; AB76: 8D 06 02    ...
 LDA #&43 ; 'C'                                   ; AB79: A9 43       .C
 STA L020A                                        ; AB7B: 8D 0A 02    ...
 LDA #&43 ; 'C'                                   ; AB7E: A9 43       .C
 STA L020E                                        ; AB80: 8D 0E 02    ...
 LDA #3                                           ; AB83: A9 03       ..
 STA L0212                                        ; AB85: 8D 12 02    ...
 JSR LD933                                        ; AB88: 20 33 D9     3.
 LDA #0                                           ; AB8B: A9 00       ..
 STA OAMADDR                                      ; AB8D: 8D 03 20    ..
 LDA #2                                           ; AB90: A9 02       ..
 STA OAMDMA                                       ; AB92: 8D 14 40    ..@
 LDA #0                                           ; AB95: A9 00       ..
 STA L00F4                                        ; AB97: 85 F4       ..
 STA L00C0                                        ; AB99: 85 C0       ..
 STA L00F3                                        ; AB9B: 85 F3       ..
 LDA #&10                                         ; AB9D: A9 10       ..
 STA L00E0                                        ; AB9F: 85 E0       ..
 LDA #0                                           ; ABA1: A9 00       ..
 STA L00DF                                        ; ABA3: 85 DF       ..
 LDA #&20 ; ' '                                   ; ABA5: A9 20       .
 STA L00E4                                        ; ABA7: 85 E4       ..
 LDA #0                                           ; ABA9: A9 00       ..
 STA L00E3                                        ; ABAB: 85 E3       ..
 LDA #&28 ; '('                                   ; ABAD: A9 28       .(
 STA L03EF                                        ; ABAF: 8D EF 03    ...
 STA L03F0                                        ; ABB2: 8D F0 03    ...
 LDA #4                                           ; ABB5: A9 04       ..
 STA L00C3                                        ; ABB7: 85 C3       ..
 STA L00C4                                        ; ABB9: 85 C4       ..
 STA L00C5                                        ; ABBB: 85 C5       ..
 STA L00C6                                        ; ABBD: 85 C6       ..
 STA L00CA                                        ; ABBF: 85 CA       ..
 STA L00CB                                        ; ABC1: 85 CB       ..
 STA L00C7                                        ; ABC3: 85 C7       ..
 STA L00C8                                        ; ABC5: 85 C8       ..
 LDA #&0F                                         ; ABC7: A9 0F       ..
 STA L0033                                        ; ABC9: 85 33       .3
 STA L0034                                        ; ABCB: 85 34       .4
 STA L0035                                        ; ABCD: 85 35       .5
 STA L0036                                        ; ABCF: 85 36       .6
 LDA #0                                           ; ABD1: A9 00       ..
 STA L00DA                                        ; ABD3: 85 DA       ..
 STA QQ11                                         ; ABD5: 85 9F       ..
 LDA #&FF                                         ; ABD7: A9 FF       ..
 STA L0473                                        ; ABD9: 8D 73 04    .s.
 JSR LD933                                        ; ABDC: 20 33 D9     3.
 LDA #&90                                         ; ABDF: A9 90       ..
 STA L00F5                                        ; ABE1: 85 F5       ..
 STA PPUCTRL                                      ; ABE3: 8D 00 20    ..
 RTS                                              ; ABE6: 60          `

.sub_CABE7
 LDA W                                            ; ABE7: A5 9E       ..
 CMP #&BA                                         ; ABE9: C9 BA       ..
 BNE CAC08                                        ; ABEB: D0 1B       ..
 LDA L0464                                        ; ABED: AD 64 04    .d.
 CMP #3                                           ; ABF0: C9 03       ..
 BEQ CABFA                                        ; ABF2: F0 06       ..
 JSR LECF9                                        ; ABF4: 20 F9 EC     ..
 JMP CAC08                                        ; ABF7: 4C 08 AC    L..

.CABFA
 LDX #&F0                                         ; ABFA: A2 F0       ..
 STX L0220                                        ; ABFC: 8E 20 02    . .
 STX L0224                                        ; ABFF: 8E 24 02    .$.
 STX L0228                                        ; AC02: 8E 28 02    .(.
 STX L022C                                        ; AC05: 8E 2C 02    .,.
.CAC08
 LDA #2                                           ; AC08: A9 02       ..
 STA L00D5                                        ; AC0A: 85 D5       ..
 LDA #&80                                         ; AC0C: A9 80       ..
 STA L00D4                                        ; AC0E: 85 D4       ..
 LDA W                                            ; AC10: A5 9E       ..
 BPL CAC1C                                        ; AC12: 10 08       ..
 LDA #3                                           ; AC14: A9 03       ..
 STA L00D5                                        ; AC16: 85 D5       ..
 LDA #&60 ; '`'                                   ; AC18: A9 60       .`
 STA L00D4                                        ; AC1A: 85 D4       ..
.CAC1C
 RTS                                              ; AC1C: 60          `

 TAY                                              ; AC1D: A8          .
 LDA W                                            ; AC1E: A5 9E       ..
 AND #&40 ; '@'                                   ; AC20: 29 40       )@
 BNE CAC1C                                        ; AC22: D0 F8       ..
 STY L0464                                        ; AC24: 8C 64 04    .d.
 JSR sub_CACEB                                    ; AC27: 20 EB AC     ..
 LDA #2                                           ; AC2A: A9 02       ..
 STA L00D5                                        ; AC2C: 85 D5       ..
 LDA #&80                                         ; AC2E: A9 80       ..
 STA L00D4                                        ; AC30: 85 D4       ..
 LDA W                                            ; AC32: A5 9E       ..
 BPL CAC3E                                        ; AC34: 10 08       ..
 LDA #3                                           ; AC36: A9 03       ..
 STA L00D5                                        ; AC38: 85 D5       ..
 LDA #&60 ; '`'                                   ; AC3A: A9 60       .`
 STA L00D4                                        ; AC3C: 85 D4       ..
.CAC3E
 LDA L0464                                        ; AC3E: AD 64 04    .d.
 ASL A                                            ; AC41: 0A          .
 ASL A                                            ; AC42: 0A          .
 ADC #&81                                         ; AC43: 69 81       i.
 STA L00D6                                        ; AC45: 85 D6       ..
 LDX #0                                           ; AC47: A2 00       ..
 STX L00D3                                        ; AC49: 86 D3       ..
.loop_CAC4B
 LDA L00E9                                        ; AC4B: A5 E9       ..
 BPL CAC58                                        ; AC4D: 10 09       ..
 LDA PPUSTATUS                                    ; AC4F: AD 02 20    ..
 ASL A                                            ; AC52: 0A          .
 BPL CAC58                                        ; AC53: 10 03       ..
 JSR NAMETABLE0                                   ; AC55: 20 6D D0     m.
.CAC58
 LDA L00D3                                        ; AC58: A5 D3       ..
 BPL loop_CAC4B                                   ; AC5A: 10 EF       ..
 LDA L0464                                        ; AC5C: AD 64 04    .d.
 JSR sub_CAE18                                    ; AC5F: 20 18 AE     ..
 LDA W                                            ; AC62: A5 9E       ..
 AND #&40 ; '@'                                   ; AC64: 29 40       )@
 BNE CAC85                                        ; AC66: D0 1D       ..
 JSR sub_CABE7                                    ; AC68: 20 E7 AB     ..
 LDA #&80                                         ; AC6B: A9 80       ..
 STA L00D7                                        ; AC6D: 85 D7       ..
 ASL A                                            ; AC6F: 0A          .
 STA L00D3                                        ; AC70: 85 D3       ..
.loop_CAC72
 LDA L00E9                                        ; AC72: A5 E9       ..
 BPL CAC7F                                        ; AC74: 10 09       ..
 LDA PPUSTATUS                                    ; AC76: AD 02 20    ..
 ASL A                                            ; AC79: 0A          .
 BPL CAC7F                                        ; AC7A: 10 03       ..
 JSR NAMETABLE0                                   ; AC7C: 20 6D D0     m.
.CAC7F
 LDA L00D3                                        ; AC7F: A5 D3       ..
 BPL loop_CAC72                                   ; AC81: 10 EF       ..
 ASL L00D7                                        ; AC83: 06 D7       ..
.CAC85
 RTS                                              ; AC85: 60          `

.sub_CAC86
 LDA L00E9                                        ; AC86: A5 E9       ..
 BPL CAC93                                        ; AC88: 10 09       ..
 LDA PPUSTATUS                                    ; AC8A: AD 02 20    ..
 ASL A                                            ; AC8D: 0A          .
 BPL CAC93                                        ; AC8E: 10 03       ..
 JSR NAMETABLE0                                   ; AC90: 20 6D D0     m.
.CAC93
 LDA #&F8                                         ; AC93: A9 F8       ..
 STA L0203                                        ; AC95: 8D 03 02    ...
 LDY #&12                                         ; AC98: A0 12       ..
 LDX #&9D                                         ; AC9A: A2 9D       ..
 LDA W                                            ; AC9C: A5 9E       ..
 BPL CACCC                                        ; AC9E: 10 2C       .,
 CMP #&C4                                         ; ACA0: C9 C4       ..
 BNE CACA8                                        ; ACA2: D0 04       ..
 LDX #&F0                                         ; ACA4: A2 F0       ..
 BNE CACCC                                        ; ACA6: D0 24       .$
.CACA8
 LDY #&19                                         ; ACA8: A0 19       ..
 LDX #&D5                                         ; ACAA: A2 D5       ..
 CMP #&B9                                         ; ACAC: C9 B9       ..
 BNE CACB7                                        ; ACAE: D0 07       ..
 LDX #&96                                         ; ACB0: A2 96       ..
 LDA #&F8                                         ; ACB2: A9 F8       ..
 STA L0203                                        ; ACB4: 8D 03 02    ...
.CACB7
 LDA W                                            ; ACB7: A5 9E       ..
 AND #&0F                                         ; ACB9: 29 0F       ).
 CMP #&0F                                         ; ACBB: C9 0F       ..
 BNE CACC1                                        ; ACBD: D0 02       ..
 LDX #&A6                                         ; ACBF: A2 A6       ..
.CACC1
 CMP #&0D                                         ; ACC1: C9 0D       ..
 BNE CACCC                                        ; ACC3: D0 07       ..
 LDX #&AD                                         ; ACC5: A2 AD       ..
 LDA #&F8                                         ; ACC7: A9 F8       ..
 STA L0203                                        ; ACC9: 8D 03 02    ...
.CACCC
 STX L0200                                        ; ACCC: 8E 00 02    ...
 TYA                                              ; ACCF: 98          .
 SEC                                              ; ACD0: 38          8
 ROL A                                            ; ACD1: 2A          *
 ASL A                                            ; ACD2: 0A          .
 ASL A                                            ; ACD3: 0A          .
 STA L0461                                        ; ACD4: 8D 61 04    .a.
 LDA L0464                                        ; ACD7: AD 64 04    .d.
 ASL A                                            ; ACDA: 0A          .
 ASL A                                            ; ACDB: 0A          .
 ADC #&81                                         ; ACDC: 69 81       i.
 STA L00D6                                        ; ACDE: 85 D6       ..
 LDA W                                            ; ACE0: A5 9E       ..
 AND #&40 ; '@'                                   ; ACE2: 29 40       )@
 BNE CACEA                                        ; ACE4: D0 04       ..
 LDX #0                                           ; ACE6: A2 00       ..
 STX L00D3                                        ; ACE8: 86 D3       ..
.CACEA
 RTS                                              ; ACEA: 60          `

.sub_CACEB
 JSR sub_CAD2A                                    ; ACEB: 20 2A AD     *.
 LDY #2                                           ; ACEE: A0 02       ..
 JSR CAF2E                                        ; ACF0: 20 2E AF     ..
 LDY #4                                           ; ACF3: A0 04       ..
 JSR sub_CAF5B                                    ; ACF5: 20 5B AF     [.
 LDY #7                                           ; ACF8: A0 07       ..
 JSR CAF2E                                        ; ACFA: 20 2E AF     ..
 LDY #9                                           ; ACFD: A0 09       ..
 JSR sub_CAF5B                                    ; ACFF: 20 5B AF     [.
 LDY #&0C                                         ; AD02: A0 0C       ..
 JSR CAF2E                                        ; AD04: 20 2E AF     ..
 LDY #&1D                                         ; AD07: A0 1D       ..
 JSR sub_CAF5B                                    ; AD09: 20 5B AF     [.
.sub_CAD0C
 LDY #&0E                                         ; AD0C: A0 0E       ..
 JSR sub_CAF5B                                    ; AD0E: 20 5B AF     [.
 LDY #&11                                         ; AD11: A0 11       ..
 JSR CAF2E                                        ; AD13: 20 2E AF     ..
.sub_CAD16
 LDY #&13                                         ; AD16: A0 13       ..
 JSR sub_CAF5B                                    ; AD18: 20 5B AF     [.
 LDY #&16                                         ; AD1B: A0 16       ..
 JSR CAF2E                                        ; AD1D: 20 2E AF     ..
 LDY #&18                                         ; AD20: A0 18       ..
 JSR sub_CAF5B                                    ; AD22: 20 5B AF     [.
 LDY #&1B                                         ; AD25: A0 1B       ..
 JMP CAF2E                                        ; AD27: 4C 2E AF    L..

.sub_CAD2A
 LDA L0464                                        ; AD2A: AD 64 04    .d.
 ASL A                                            ; AD2D: 0A          .
 ASL A                                            ; AD2E: 0A          .
 ASL A                                            ; AD2F: 0A          .
 ASL A                                            ; AD30: 0A          .
 ASL A                                            ; AD31: 0A          .
 ASL A                                            ; AD32: 0A          .
 TAY                                              ; AD33: A8          .
 BNE CAD3A                                        ; AD34: D0 04       ..
 LDA #&94                                         ; AD36: A9 94       ..
 BNE CAD3C                                        ; AD38: D0 02       ..
.CAD3A
 LDA #&95                                         ; AD3A: A9 95       ..
.CAD3C
 DEY                                              ; AD3C: 88          .
 STY V                                            ; AD3D: 84 63       .c
 ADC #0                                           ; AD3F: 69 00       i.
 STA V_1                                          ; AD41: 85 64       .d
 LDA W                                            ; AD43: A5 9E       ..
 BMI CAD5A                                        ; AD45: 30 13       0.
 LDA #&72 ; 'r'                                   ; AD47: A9 72       .r
 STA SC_1                                         ; AD49: 85 08       ..
 LDA #&80                                         ; AD4B: A9 80       ..
 STA SC                                           ; AD4D: 85 07       ..
 LDA #&76 ; 'v'                                   ; AD4F: A9 76       .v
 STA L00BB                                        ; AD51: 85 BB       ..
 LDA #&80                                         ; AD53: A9 80       ..
 STA L00BA                                        ; AD55: 85 BA       ..
 JMP CAD77                                        ; AD57: 4C 77 AD    Lw.

.CAD5A
 LDA #&73 ; 's'                                   ; AD5A: A9 73       .s
 STA SC_1                                         ; AD5C: 85 08       ..
 LDA #&60 ; '`'                                   ; AD5E: A9 60       .`
 STA SC                                           ; AD60: 85 07       ..
 LDA #&77 ; 'w'                                   ; AD62: A9 77       .w
 STA L00BB                                        ; AD64: 85 BB       ..
 LDA #&60 ; '`'                                   ; AD66: A9 60       .`
 STA L00BA                                        ; AD68: 85 BA       ..
 LDA L00E9                                        ; AD6A: A5 E9       ..
 BPL CAD77                                        ; AD6C: 10 09       ..
 LDA PPUSTATUS                                    ; AD6E: AD 02 20    ..
 ASL A                                            ; AD71: 0A          .
 BPL CAD77                                        ; AD72: 10 03       ..
 JSR NAMETABLE0                                   ; AD74: 20 6D D0     m.
.CAD77
 LDY #&3F ; '?'                                   ; AD77: A0 3F       .?
.loop_CAD79
 LDA (V),Y                                        ; AD79: B1 63       .c
 STA (SC),Y                                       ; AD7B: 91 07       ..
 STA (L00BA),Y                                    ; AD7D: 91 BA       ..
 DEY                                              ; AD7F: 88          .
 CPY #&21 ; '!'                                   ; AD80: C0 21       .!
 BNE loop_CAD79                                   ; AD82: D0 F5       ..
 LDA L00E9                                        ; AD84: A5 E9       ..
 BPL CAD91                                        ; AD86: 10 09       ..
 LDA PPUSTATUS                                    ; AD88: AD 02 20    ..
 ASL A                                            ; AD8B: 0A          .
 BPL CAD91                                        ; AD8C: 10 03       ..
 JSR NAMETABLE0                                   ; AD8E: 20 6D D0     m.
.CAD91
 LDA (V),Y                                        ; AD91: B1 63       .c
 STA (SC),Y                                       ; AD93: 91 07       ..
 STA (L00BA),Y                                    ; AD95: 91 BA       ..
 DEY                                              ; AD97: 88          .
 BNE CAD91                                        ; AD98: D0 F7       ..
 LDA L00E9                                        ; AD9A: A5 E9       ..
 BPL CADA7                                        ; AD9C: 10 09       ..
 LDA PPUSTATUS                                    ; AD9E: AD 02 20    ..
 ASL A                                            ; ADA1: 0A          .
 BPL CADA7                                        ; ADA2: 10 03       ..
 JSR NAMETABLE0                                   ; ADA4: 20 6D D0     m.
.CADA7
 LDY #&20 ; ' '                                   ; ADA7: A0 20       .
 LDA (V),Y                                        ; ADA9: B1 63       .c
 LDY #0                                           ; ADAB: A0 00       ..
 STA (SC),Y                                       ; ADAD: 91 07       ..
 STA (L00BA),Y                                    ; ADAF: 91 BA       ..
 LDY #&40 ; '@'                                   ; ADB1: A0 40       .@
 LDA (V),Y                                        ; ADB3: B1 63       .c
 LDY #&20 ; ' '                                   ; ADB5: A0 20       .
 STA (SC),Y                                       ; ADB7: 91 07       ..
 STA (L00BA),Y                                    ; ADB9: 91 BA       ..
 RTS                                              ; ADBB: 60          `

.CADBC
 LDA #&73 ; 's'                                   ; ADBC: A9 73       .s
 STA SC_1                                         ; ADBE: 85 08       ..
 LDA #&60 ; '`'                                   ; ADC0: A9 60       .`
 STA SC                                           ; ADC2: 85 07       ..
 LDA #&77 ; 'w'                                   ; ADC4: A9 77       .w
 STA L00BB                                        ; ADC6: 85 BB       ..
 LDA #&60 ; '`'                                   ; ADC8: A9 60       .`
 STA L00BA                                        ; ADCA: 85 BA       ..
 LDY #&3F ; '?'                                   ; ADCC: A0 3F       .?
 LDA #0                                           ; ADCE: A9 00       ..
.loop_CADD0
 STA (SC),Y                                       ; ADD0: 91 07       ..
 STA (L00BA),Y                                    ; ADD2: 91 BA       ..
 DEY                                              ; ADD4: 88          .
 BNE loop_CADD0                                   ; ADD5: D0 F9       ..
 LDA #&20 ; ' '                                   ; ADD7: A9 20       .
 LDY #0                                           ; ADD9: A0 00       ..
 STA (SC),Y                                       ; ADDB: 91 07       ..
 STA (L00BA),Y                                    ; ADDD: 91 BA       ..
 RTS                                              ; ADDF: 60          `

.CADE0
 LDA L03EB                                        ; ADE0: AD EB 03    ...
 BEQ CADEA                                        ; ADE3: F0 05       ..
 LDY #2                                           ; ADE5: A0 02       ..
 JSR sub_CAF9A                                    ; ADE7: 20 9A AF     ..
.CADEA
 LDA L03EA                                        ; ADEA: AD EA 03    ...
 BEQ CADF4                                        ; ADED: F0 05       ..
 LDY #4                                           ; ADEF: A0 04       ..
 JSR sub_CAF96                                    ; ADF1: 20 96 AF     ..
.CADF4
 LDA L03ED                                        ; ADF4: AD ED 03    ...
 BPL CADFE                                        ; ADF7: 10 05       ..
 LDY #7                                           ; ADF9: A0 07       ..
 JSR sub_CAF9A                                    ; ADFB: 20 9A AF     ..
.CADFE
 LDA L03EC                                        ; ADFE: AD EC 03    ...
 BMI CAE08                                        ; AE01: 30 05       0.
 LDY #9                                           ; AE03: A0 09       ..
 JSR sub_CAF96                                    ; AE05: 20 96 AF     ..
.CAE08
 LDA L0475                                        ; AE08: AD 75 04    .u.
 BNE CAE12                                        ; AE0B: D0 05       ..
 LDY #&0C                                         ; AE0D: A0 0C       ..
 JSR sub_CAF9A                                    ; AE0F: 20 9A AF     ..
.CAE12
 JSR sub_CAD0C                                    ; AE12: 20 0C AD     ..
.CAE15
 JMP CAEC6                                        ; AE15: 4C C6 AE    L..

.sub_CAE18
 TAY                                              ; AE18: A8          .
 BMI CADBC                                        ; AE19: 30 A1       0.
 STA L0464                                        ; AE1B: 8D 64 04    .d.
 LDA L00E9                                        ; AE1E: A5 E9       ..
 BPL CAE2B                                        ; AE20: 10 09       ..
 LDA PPUSTATUS                                    ; AE22: AD 02 20    ..
 ASL A                                            ; AE25: 0A          .
 BPL CAE2B                                        ; AE26: 10 03       ..
 JSR NAMETABLE0                                   ; AE28: 20 6D D0     m.
.CAE2B
 JSR sub_CAD2A                                    ; AE2B: 20 2A AD     *.
 LDA L0464                                        ; AE2E: AD 64 04    .d.
 BEQ CAEAB                                        ; AE31: F0 78       .x
 CMP #1                                           ; AE33: C9 01       ..
 BEQ CAE42                                        ; AE35: F0 0B       ..
 CMP #3                                           ; AE37: C9 03       ..
 BEQ CADE0                                        ; AE39: F0 A5       ..
 CMP #2                                           ; AE3B: C9 02       ..
 BNE CAE15                                        ; AE3D: D0 D6       ..
 JMP CAEE5                                        ; AE3F: 4C E5 AE    L..

.CAE42
 LDA SSPR                                         ; AE42: AD 64 05    .d.
 BNE CAE4C                                        ; AE45: D0 05       ..
 LDY #2                                           ; AE47: A0 02       ..
 JSR CAF2E                                        ; AE49: 20 2E AF     ..
.CAE4C
 LDA L03BE                                        ; AE4C: AD BE 03    ...
 BNE CAE56                                        ; AE4F: D0 05       ..
 LDY #&11                                         ; AE51: A0 11       ..
 JSR CAF2E                                        ; AE53: 20 2E AF     ..
.CAE56
 LDA L006C                                        ; AE56: A5 6C       .l
 BNE CAE60                                        ; AE58: D0 06       ..
 LDA L0395                                        ; AE5A: AD 95 03    ...
 ASL A                                            ; AE5D: 0A          .
 BMI CAE65                                        ; AE5E: 30 05       0.
.CAE60
 LDY #&0E                                         ; AE60: A0 0E       ..
 JSR sub_CAF5B                                    ; AE62: 20 5B AF     [.
.CAE65
 LDA W                                            ; AE65: A5 9E       ..
 BEQ CAE6F                                        ; AE67: F0 06       ..
 JSR sub_CAD16                                    ; AE69: 20 16 AD     ..
 JMP CAE9C                                        ; AE6C: 4C 9C AE    L..

.CAE6F
 LDA NOMSL                                        ; AE6F: AD C8 03    ...
 BNE CAE79                                        ; AE72: D0 05       ..
 LDY #&13                                         ; AE74: A0 13       ..
 JSR sub_CAF5B                                    ; AE76: 20 5B AF     [.
.CAE79
 LDA MSTG                                         ; AE79: AD 01 04    ...
 BPL CAE83                                        ; AE7C: 10 05       ..
 LDY #&16                                         ; AE7E: A0 16       ..
 JSR CAF2E                                        ; AE80: 20 2E AF     ..
.CAE83
 LDA BOMB                                         ; AE83: AD C0 03    ...
 BNE CAE8D                                        ; AE86: D0 05       ..
 LDY #&18                                         ; AE88: A0 18       ..
 JSR sub_CAF5B                                    ; AE8A: 20 5B AF     [.
.CAE8D
 LDA MJ                                           ; AE8D: AD 8A 03    ...
 BNE CAE97                                        ; AE90: D0 05       ..
 LDA L03C4                                        ; AE92: AD C4 03    ...
 BNE CAE9C                                        ; AE95: D0 05       ..
.CAE97
 LDY #&1B                                         ; AE97: A0 1B       ..
 JSR CAF2E                                        ; AE99: 20 2E AF     ..
.CAE9C
 LDA L0300                                        ; AE9C: AD 00 03    ...
 AND #&C0                                         ; AE9F: 29 C0       ).
 BEQ CAEBB                                        ; AEA1: F0 18       ..
.CAEA3
 LDY #&1D                                         ; AEA3: A0 1D       ..
 JSR sub_CAF5B                                    ; AEA5: 20 5B AF     [.
 JMP CAEBB                                        ; AEA8: 4C BB AE    L..

.CAEAB
 LDA L03A6                                        ; AEAB: AD A6 03    ...
 BNE CAEB6                                        ; AEAE: D0 06       ..
 LDA W                                            ; AEB0: A5 9E       ..
 CMP #&BB                                         ; AEB2: C9 BB       ..
 BEQ CAEBB                                        ; AEB4: F0 05       ..
.CAEB6
 LDY #&11                                         ; AEB6: A0 11       ..
 JSR CAF2E                                        ; AEB8: 20 2E AF     ..
.CAEBB
 LDA W                                            ; AEBB: A5 9E       ..
 CMP #&BA                                         ; AEBD: C9 BA       ..
 BNE CAEC6                                        ; AEBF: D0 05       ..
 LDY #4                                           ; AEC1: A0 04       ..
 JSR sub_CAF5B                                    ; AEC3: 20 5B AF     [.
.CAEC6
 LDA L00E9                                        ; AEC6: A5 E9       ..
 BPL CAED3                                        ; AEC8: 10 09       ..
 LDA PPUSTATUS                                    ; AECA: AD 02 20    ..
 ASL A                                            ; AECD: 0A          .
 BPL CAED3                                        ; AECE: 10 03       ..
 JSR NAMETABLE0                                   ; AED0: 20 6D D0     m.
.CAED3
 LDA L0464                                        ; AED3: AD 64 04    .d.
 ASL A                                            ; AED6: 0A          .
 ASL A                                            ; AED7: 0A          .
 ASL A                                            ; AED8: 0A          .
 ASL A                                            ; AED9: 0A          .
 ADC #&27 ; '''                                   ; AEDA: 69 27       i'
 STA L00BE                                        ; AEDC: 85 BE       ..
 LDA #&EB                                         ; AEDE: A9 EB       ..
 ADC #0                                           ; AEE0: 69 00       i.
 STA L00BF                                        ; AEE2: 85 BF       ..
 RTS                                              ; AEE4: 60          `

.CAEE5
 LDX #4                                           ; AEE5: A2 04       ..
 LDA QQ12                                         ; AEE7: A5 A5       ..
 BEQ CAEF6                                        ; AEE9: F0 0B       ..
 LDY #&0C                                         ; AEEB: A0 0C       ..
 JSR CAF2E                                        ; AEED: 20 2E AF     ..
 JSR sub_CAD16                                    ; AEF0: 20 16 AD     ..
 JMP CAEA3                                        ; AEF3: 4C A3 AE    L..

.CAEF6
 LDY #2                                           ; AEF6: A0 02       ..
 JSR CAF2E                                        ; AEF8: 20 2E AF     ..
 LDA L006C                                        ; AEFB: A5 6C       .l
 BEQ CAF0C                                        ; AEFD: F0 0D       ..
 LDY #&0E                                         ; AEFF: A0 0E       ..
 JSR sub_CAF5B                                    ; AF01: 20 5B AF     [.
 LDY #&11                                         ; AF04: A0 11       ..
 JSR CAF2E                                        ; AF06: 20 2E AF     ..
 JMP CAF12                                        ; AF09: 4C 12 AF    L..

.CAF0C
 LDA L0395                                        ; AF0C: AD 95 03    ...
 ASL A                                            ; AF0F: 0A          .
 BMI CAF17                                        ; AF10: 30 05       0.
.CAF12
 LDY #&13                                         ; AF12: A0 13       ..
 JSR sub_CAF5B                                    ; AF14: 20 5B AF     [.
.CAF17
 LDA GHYP                                         ; AF17: AD C3 03    ...
 BNE CAF21                                        ; AF1A: D0 05       ..
 LDY #&16                                         ; AF1C: A0 16       ..
 JSR CAF2E                                        ; AF1E: 20 2E AF     ..
.CAF21
 LDA L03BE                                        ; AF21: AD BE 03    ...
 BNE CAF2B                                        ; AF24: D0 05       ..
 LDY #&18                                         ; AF26: A0 18       ..
 JSR sub_CAF5B                                    ; AF28: 20 5B AF     [.
.CAF2B
 JMP CAE8D                                        ; AF2B: 4C 8D AE    L..

.CAF2E
 LDA L00E9                                        ; AF2E: A5 E9       ..
 BPL CAF3B                                        ; AF30: 10 09       ..
 LDA PPUSTATUS                                    ; AF32: AD 02 20    ..
 ASL A                                            ; AF35: 0A          .
 BPL CAF3B                                        ; AF36: 10 03       ..
 JSR NAMETABLE0                                   ; AF38: 20 6D D0     m.
.CAF3B
 LDA #4                                           ; AF3B: A9 04       ..
 STA (SC),Y                                       ; AF3D: 91 07       ..
 STA (L00BA),Y                                    ; AF3F: 91 BA       ..
 INY                                              ; AF41: C8          .
 LDA #5                                           ; AF42: A9 05       ..
 STA (SC),Y                                       ; AF44: 91 07       ..
 STA (L00BA),Y                                    ; AF46: 91 BA       ..
 TYA                                              ; AF48: 98          .
 CLC                                              ; AF49: 18          .
 ADC #&1F                                         ; AF4A: 69 1F       i.
 TAY                                              ; AF4C: A8          .
 LDA #&24 ; '$'                                   ; AF4D: A9 24       .$
 STA (SC),Y                                       ; AF4F: 91 07       ..
 STA (L00BA),Y                                    ; AF51: 91 BA       ..
 INY                                              ; AF53: C8          .
 LDA #&25 ; '%'                                   ; AF54: A9 25       .%
 STA (SC),Y                                       ; AF56: 91 07       ..
 STA (L00BA),Y                                    ; AF58: 91 BA       ..
 RTS                                              ; AF5A: 60          `

.sub_CAF5B
 LDA L00E9                                        ; AF5B: A5 E9       ..
 BPL CAF68                                        ; AF5D: 10 09       ..
 LDA PPUSTATUS                                    ; AF5F: AD 02 20    ..
 ASL A                                            ; AF62: 0A          .
 BPL CAF68                                        ; AF63: 10 03       ..
 JSR NAMETABLE0                                   ; AF65: 20 6D D0     m.
.CAF68
 LDA #6                                           ; AF68: A9 06       ..
 STA (SC),Y                                       ; AF6A: 91 07       ..
 STA (L00BA),Y                                    ; AF6C: 91 BA       ..
 INY                                              ; AF6E: C8          .
 LDA #7                                           ; AF6F: A9 07       ..
 STA (SC),Y                                       ; AF71: 91 07       ..
 STA (L00BA),Y                                    ; AF73: 91 BA       ..
 INY                                              ; AF75: C8          .
 LDA #8                                           ; AF76: A9 08       ..
 STA (SC),Y                                       ; AF78: 91 07       ..
 STA (L00BA),Y                                    ; AF7A: 91 BA       ..
 TYA                                              ; AF7C: 98          .
 CLC                                              ; AF7D: 18          .
 ADC #&1E                                         ; AF7E: 69 1E       i.
 TAY                                              ; AF80: A8          .
 LDA #&26 ; '&'                                   ; AF81: A9 26       .&
 STA (SC),Y                                       ; AF83: 91 07       ..
 STA (L00BA),Y                                    ; AF85: 91 BA       ..
 INY                                              ; AF87: C8          .
 LDA #&25 ; '%'                                   ; AF88: A9 25       .%
 STA (SC),Y                                       ; AF8A: 91 07       ..
 STA (L00BA),Y                                    ; AF8C: 91 BA       ..
 INY                                              ; AF8E: C8          .
 LDA #&27 ; '''                                   ; AF8F: A9 27       .'
 STA (SC),Y                                       ; AF91: 91 07       ..
 STA (L00BA),Y                                    ; AF93: 91 BA       ..
 RTS                                              ; AF95: 60          `

.sub_CAF96
 JSR sub_CAFAB                                    ; AF96: 20 AB AF     ..
 INY                                              ; AF99: C8          .
.sub_CAF9A
 LDA L00E9                                        ; AF9A: A5 E9       ..
 BPL CAFA7                                        ; AF9C: 10 09       ..
 LDA PPUSTATUS                                    ; AF9E: AD 02 20    ..
 ASL A                                            ; AFA1: 0A          .
 BPL CAFA7                                        ; AFA2: 10 03       ..
 JSR NAMETABLE0                                   ; AFA4: 20 6D D0     m.
.CAFA7
 JSR sub_CAFAB                                    ; AFA7: 20 AB AF     ..
 INY                                              ; AFAA: C8          .
.sub_CAFAB
 LDA L95CE,Y                                      ; AFAB: B9 CE 95    ...
 STA (SC),Y                                       ; AFAE: 91 07       ..
 STA (L00BA),Y                                    ; AFB0: 91 BA       ..
 STY T                                            ; AFB2: 84 9A       ..
 TYA                                              ; AFB4: 98          .
 CLC                                              ; AFB5: 18          .
 ADC #&20 ; ' '                                   ; AFB6: 69 20       i
 TAY                                              ; AFB8: A8          .
 LDA L95CE,Y                                      ; AFB9: B9 CE 95    ...
 STA (SC),Y                                       ; AFBC: 91 07       ..
 STA (L00BA),Y                                    ; AFBE: 91 BA       ..
 LDY T                                            ; AFC0: A4 9A       ..
 RTS                                              ; AFC2: 60          `

.loop_CAFC3
 LDX #4                                           ; AFC3: A2 04       ..
 STX L00B8                                        ; AFC5: 86 B8       ..
 RTS                                              ; AFC7: 60          `

.loop_CAFC8
 LDX #&25 ; '%'                                   ; AFC8: A2 25       .%
 STX L00B8                                        ; AFCA: 86 B8       ..
 RTS                                              ; AFCC: 60          `

 LDA W                                            ; AFCD: A5 9E       ..
 CMP #&CF                                         ; AFCF: C9 CF       ..
 BEQ loop_CAFC3                                   ; AFD1: F0 F0       ..
 CMP #&10                                         ; AFD3: C9 10       ..
 BEQ loop_CAFC8                                   ; AFD5: F0 F1       ..
 LDX #&42 ; 'B'                                   ; AFD7: A2 42       .B
 LDA W                                            ; AFD9: A5 9E       ..
 BMI CAFDF                                        ; AFDB: 30 02       0.
 LDX #&3C ; '<'                                   ; AFDD: A2 3C       .<
.CAFDF
 STX L00B8                                        ; AFDF: 86 B8       ..
 LDA #&FC                                         ; AFE1: A9 FC       ..
 STA V_1                                          ; AFE3: 85 64       .d
 LDA #0                                           ; AFE5: A9 00       ..
 STA V                                            ; AFE7: 85 63       .c
 LDA #&61 ; 'a'                                   ; AFE9: A9 61       .a
 STA SC_1                                         ; AFEB: 85 08       ..
 LDA #&28 ; '('                                   ; AFED: A9 28       .(
 STA SC                                           ; AFEF: 85 07       ..
 LDA #&69 ; 'i'                                   ; AFF1: A9 69       .i
 STA L00BB                                        ; AFF3: 85 BB       ..
 LDA #&28 ; '('                                   ; AFF5: A9 28       .(
 STA L00BA                                        ; AFF7: 85 BA       ..
 LDY #0                                           ; AFF9: A0 00       ..
 LDX #&25 ; '%'                                   ; AFFB: A2 25       .%
.CAFFD
 LDA L00E9                                        ; AFFD: A5 E9       ..
 BPL CB00A                                        ; AFFF: 10 09       ..
 LDA PPUSTATUS                                    ; B001: AD 02 20    ..
 ASL A                                            ; B004: 0A          .
 BPL CB00A                                        ; B005: 10 03       ..
 JSR NAMETABLE0                                   ; B007: 20 6D D0     m.
.CB00A
 LDA (V),Y                                        ; B00A: B1 63       .c
 STA (SC),Y                                       ; B00C: 91 07       ..
 STA (L00BA),Y                                    ; B00E: 91 BA       ..
 INY                                              ; B010: C8          .
 LDA (V),Y                                        ; B011: B1 63       .c
 STA (SC),Y                                       ; B013: 91 07       ..
 STA (L00BA),Y                                    ; B015: 91 BA       ..
 INY                                              ; B017: C8          .
 LDA (V),Y                                        ; B018: B1 63       .c
 STA (SC),Y                                       ; B01A: 91 07       ..
 STA (L00BA),Y                                    ; B01C: 91 BA       ..
 INY                                              ; B01E: C8          .
 LDA (V),Y                                        ; B01F: B1 63       .c
 STA (SC),Y                                       ; B021: 91 07       ..
 STA (L00BA),Y                                    ; B023: 91 BA       ..
 INY                                              ; B025: C8          .
 LDA (V),Y                                        ; B026: B1 63       .c
 STA (SC),Y                                       ; B028: 91 07       ..
 STA (L00BA),Y                                    ; B02A: 91 BA       ..
 INY                                              ; B02C: C8          .
 LDA (V),Y                                        ; B02D: B1 63       .c
 STA (SC),Y                                       ; B02F: 91 07       ..
 STA (L00BA),Y                                    ; B031: 91 BA       ..
 INY                                              ; B033: C8          .
 LDA (V),Y                                        ; B034: B1 63       .c
 STA (SC),Y                                       ; B036: 91 07       ..
 STA (L00BA),Y                                    ; B038: 91 BA       ..
 INY                                              ; B03A: C8          .
 LDA (V),Y                                        ; B03B: B1 63       .c
 STA (SC),Y                                       ; B03D: 91 07       ..
 STA (L00BA),Y                                    ; B03F: 91 BA       ..
 INY                                              ; B041: C8          .
 BNE CB04A                                        ; B042: D0 06       ..
 INC V_1                                          ; B044: E6 64       .d
 INC SC_1                                         ; B046: E6 08       ..
 INC L00BB                                        ; B048: E6 BB       ..
.CB04A
 INX                                              ; B04A: E8          .
 CPX #&3C ; '<'                                   ; B04B: E0 3C       .<
 BNE CAFFD                                        ; B04D: D0 AE       ..
.CB04F
 LDA L00E9                                        ; B04F: A5 E9       ..
 BPL CB05C                                        ; B051: 10 09       ..
 LDA PPUSTATUS                                    ; B053: AD 02 20    ..
 ASL A                                            ; B056: 0A          .
 BPL CB05C                                        ; B057: 10 03       ..
 JSR NAMETABLE0                                   ; B059: 20 6D D0     m.
.CB05C
 CPX L00B8                                        ; B05C: E4 B8       ..
 BEQ CB0B4                                        ; B05E: F0 54       .T
 LDA (V),Y                                        ; B060: B1 63       .c
 STA (L00BA),Y                                    ; B062: 91 BA       ..
 LDA #0                                           ; B064: A9 00       ..
 STA (SC),Y                                       ; B066: 91 07       ..
 INY                                              ; B068: C8          .
 LDA (V),Y                                        ; B069: B1 63       .c
 STA (L00BA),Y                                    ; B06B: 91 BA       ..
 LDA #0                                           ; B06D: A9 00       ..
 STA (SC),Y                                       ; B06F: 91 07       ..
 INY                                              ; B071: C8          .
 LDA (V),Y                                        ; B072: B1 63       .c
 STA (L00BA),Y                                    ; B074: 91 BA       ..
 LDA #0                                           ; B076: A9 00       ..
 STA (SC),Y                                       ; B078: 91 07       ..
 INY                                              ; B07A: C8          .
 LDA (V),Y                                        ; B07B: B1 63       .c
 STA (L00BA),Y                                    ; B07D: 91 BA       ..
 LDA #0                                           ; B07F: A9 00       ..
 STA (SC),Y                                       ; B081: 91 07       ..
 INY                                              ; B083: C8          .
 LDA (V),Y                                        ; B084: B1 63       .c
 STA (L00BA),Y                                    ; B086: 91 BA       ..
 LDA #0                                           ; B088: A9 00       ..
 STA (SC),Y                                       ; B08A: 91 07       ..
 INY                                              ; B08C: C8          .
 LDA (V),Y                                        ; B08D: B1 63       .c
 STA (L00BA),Y                                    ; B08F: 91 BA       ..
 LDA #0                                           ; B091: A9 00       ..
 STA (SC),Y                                       ; B093: 91 07       ..
 INY                                              ; B095: C8          .
 LDA (V),Y                                        ; B096: B1 63       .c
 STA (L00BA),Y                                    ; B098: 91 BA       ..
 LDA #0                                           ; B09A: A9 00       ..
 STA (SC),Y                                       ; B09C: 91 07       ..
 INY                                              ; B09E: C8          .
 LDA (V),Y                                        ; B09F: B1 63       .c
 STA (L00BA),Y                                    ; B0A1: 91 BA       ..
 LDA #0                                           ; B0A3: A9 00       ..
 STA (SC),Y                                       ; B0A5: 91 07       ..
 INY                                              ; B0A7: C8          .
 BNE CB0B0                                        ; B0A8: D0 06       ..
 INC V_1                                          ; B0AA: E6 64       .d
 INC SC_1                                         ; B0AC: E6 08       ..
 INC L00BB                                        ; B0AE: E6 BB       ..
.CB0B0
 INX                                              ; B0B0: E8          .
 JMP CB04F                                        ; B0B1: 4C 4F B0    LO.

.CB0B4
 LDA L00E9                                        ; B0B4: A5 E9       ..
 BPL CB0C1                                        ; B0B6: 10 09       ..
 LDA PPUSTATUS                                    ; B0B8: AD 02 20    ..
 ASL A                                            ; B0BB: 0A          .
 BPL CB0C1                                        ; B0BC: 10 03       ..
 JSR NAMETABLE0                                   ; B0BE: 20 6D D0     m.
.CB0C1
 LDA #0                                           ; B0C1: A9 00       ..
 LDX #&30 ; '0'                                   ; B0C3: A2 30       .0
.loop_CB0C5
 STA (L00BA),Y                                    ; B0C5: 91 BA       ..
 STA (SC),Y                                       ; B0C7: 91 07       ..
 INY                                              ; B0C9: C8          .
 BNE CB0D0                                        ; B0CA: D0 04       ..
 INC L00BB                                        ; B0CC: E6 BB       ..
 INC SC_1                                         ; B0CE: E6 08       ..
.CB0D0
 DEX                                              ; B0D0: CA          .
 BNE loop_CB0C5                                   ; B0D1: D0 F2       ..
 LDA L00E9                                        ; B0D3: A5 E9       ..
 BPL CB0E0                                        ; B0D5: 10 09       ..
 LDA PPUSTATUS                                    ; B0D7: AD 02 20    ..
 ASL A                                            ; B0DA: 0A          .
 BPL CB0E0                                        ; B0DB: 10 03       ..
 JSR NAMETABLE0                                   ; B0DD: 20 6D D0     m.
.CB0E0
 RTS                                              ; B0E0: 60          `

 STA SC                                           ; B0E1: 85 07       ..
 SEC                                              ; B0E3: 38          8
 SBC #&20 ; ' '                                   ; B0E4: E9 20       .
 STA L00D9                                        ; B0E6: 85 D9       ..
 LDA SC                                           ; B0E8: A5 07       ..
 CLC                                              ; B0EA: 18          .
 ADC #&5F ; '_'                                   ; B0EB: 69 5F       i_
 STA L00B8                                        ; B0ED: 85 B8       ..
 LDX #0                                           ; B0EF: A2 00       ..
 LDA W                                            ; B0F1: A5 9E       ..
 CMP #&BB                                         ; B0F3: C9 BB       ..
 BNE CB0F8                                        ; B0F5: D0 01       ..
 DEX                                              ; B0F7: CA          .
.CB0F8
 STX T                                            ; B0F8: 86 9A       ..
 LDA #0                                           ; B0FA: A9 00       ..
 ASL SC                                           ; B0FC: 06 07       ..
 ROL A                                            ; B0FE: 2A          *
 ASL SC                                           ; B0FF: 06 07       ..
 ROL A                                            ; B101: 2A          *
 ASL SC                                           ; B102: 06 07       ..
 ROL A                                            ; B104: 2A          *
 ADC #&60 ; '`'                                   ; B105: 69 60       i`
 STA L00BB                                        ; B107: 85 BB       ..
 ADC #8                                           ; B109: 69 08       i.
 STA SC_1                                         ; B10B: 85 08       ..
 LDA SC                                           ; B10D: A5 07       ..
 STA L00BA                                        ; B10F: 85 BA       ..
 LDA #&FC                                         ; B111: A9 FC       ..
 STA V_1                                          ; B113: 85 64       .d
 LDA #&E8                                         ; B115: A9 E8       ..
 STA V                                            ; B117: 85 63       .c
 LDX #&5F ; '_'                                   ; B119: A2 5F       ._
 LDY #0                                           ; B11B: A0 00       ..
.CB11D
 LDA L00E9                                        ; B11D: A5 E9       ..
 BPL CB12A                                        ; B11F: 10 09       ..
 LDA PPUSTATUS                                    ; B121: AD 02 20    ..
 ASL A                                            ; B124: 0A          .
 BPL CB12A                                        ; B125: 10 03       ..
 JSR NAMETABLE0                                   ; B127: 20 6D D0     m.
.CB12A
 LDA (V),Y                                        ; B12A: B1 63       .c
 STA (L00BA),Y                                    ; B12C: 91 BA       ..
 AND T                                            ; B12E: 25 9A       %.
 EOR T                                            ; B130: 45 9A       E.
 STA (SC),Y                                       ; B132: 91 07       ..
 INY                                              ; B134: C8          .
 LDA (V),Y                                        ; B135: B1 63       .c
 STA (L00BA),Y                                    ; B137: 91 BA       ..
 AND T                                            ; B139: 25 9A       %.
 EOR T                                            ; B13B: 45 9A       E.
 STA (SC),Y                                       ; B13D: 91 07       ..
 INY                                              ; B13F: C8          .
 LDA (V),Y                                        ; B140: B1 63       .c
 STA (L00BA),Y                                    ; B142: 91 BA       ..
 AND T                                            ; B144: 25 9A       %.
 EOR T                                            ; B146: 45 9A       E.
 STA (SC),Y                                       ; B148: 91 07       ..
 INY                                              ; B14A: C8          .
 LDA (V),Y                                        ; B14B: B1 63       .c
 STA (L00BA),Y                                    ; B14D: 91 BA       ..
 AND T                                            ; B14F: 25 9A       %.
 EOR T                                            ; B151: 45 9A       E.
 STA (SC),Y                                       ; B153: 91 07       ..
 INY                                              ; B155: C8          .
 LDA (V),Y                                        ; B156: B1 63       .c
 STA (L00BA),Y                                    ; B158: 91 BA       ..
 AND T                                            ; B15A: 25 9A       %.
 EOR T                                            ; B15C: 45 9A       E.
 STA (SC),Y                                       ; B15E: 91 07       ..
 INY                                              ; B160: C8          .
 LDA (V),Y                                        ; B161: B1 63       .c
 STA (L00BA),Y                                    ; B163: 91 BA       ..
 AND T                                            ; B165: 25 9A       %.
 EOR T                                            ; B167: 45 9A       E.
 STA (SC),Y                                       ; B169: 91 07       ..
 INY                                              ; B16B: C8          .
 LDA (V),Y                                        ; B16C: B1 63       .c
 STA (L00BA),Y                                    ; B16E: 91 BA       ..
 AND T                                            ; B170: 25 9A       %.
 EOR T                                            ; B172: 45 9A       E.
 STA (SC),Y                                       ; B174: 91 07       ..
 INY                                              ; B176: C8          .
 LDA (V),Y                                        ; B177: B1 63       .c
 STA (L00BA),Y                                    ; B179: 91 BA       ..
 AND T                                            ; B17B: 25 9A       %.
 EOR T                                            ; B17D: 45 9A       E.
 STA (SC),Y                                       ; B17F: 91 07       ..
 INY                                              ; B181: C8          .
 BNE CB18A                                        ; B182: D0 06       ..
 INC V_1                                          ; B184: E6 64       .d
 INC L00BB                                        ; B186: E6 BB       ..
 INC SC_1                                         ; B188: E6 08       ..
.CB18A
 DEX                                              ; B18A: CA          .
 BNE CB11D                                        ; B18B: D0 90       ..
 RTS                                              ; B18D: 60          `

 LDA #&65 ; 'e'                                   ; B18E: A9 65       .e
 STA L00BB                                        ; B190: 85 BB       ..
 LDA #8                                           ; B192: A9 08       ..
 STA L00BA                                        ; B194: 85 BA       ..
 LDA #&6D ; 'm'                                   ; B196: A9 6D       .m
 STA SC_1                                         ; B198: 85 08       ..
 LDA #8                                           ; B19A: A9 08       ..
 STA SC                                           ; B19C: 85 07       ..
 LDX #&5F ; '_'                                   ; B19E: A2 5F       ._
 LDA W                                            ; B1A0: A5 9E       ..
 CMP #&BB                                         ; B1A2: C9 BB       ..
 BNE CB1A8                                        ; B1A4: D0 02       ..
 LDX #&46 ; 'F'                                   ; B1A6: A2 46       .F
.CB1A8
 TXA                                              ; B1A8: 8A          .
 CLC                                              ; B1A9: 18          .
 ADC L00B8                                        ; B1AA: 65 B8       e.
 STA L00B8                                        ; B1AC: 85 B8       ..
 LDA #&FC                                         ; B1AE: A9 FC       ..
 STA V_1                                          ; B1B0: 85 64       .d
 LDA #&E8                                         ; B1B2: A9 E8       ..
 STA V                                            ; B1B4: 85 63       .c
 LDY #0                                           ; B1B6: A0 00       ..
.CB1B8
 LDA L00E9                                        ; B1B8: A5 E9       ..
 BPL CB1C5                                        ; B1BA: 10 09       ..
 LDA PPUSTATUS                                    ; B1BC: AD 02 20    ..
 ASL A                                            ; B1BF: 0A          .
 BPL CB1C5                                        ; B1C0: 10 03       ..
 JSR NAMETABLE0                                   ; B1C2: 20 6D D0     m.
.CB1C5
 LDA (V),Y                                        ; B1C5: B1 63       .c
 STA (SC),Y                                       ; B1C7: 91 07       ..
 LDA #&FF                                         ; B1C9: A9 FF       ..
 STA (L00BA),Y                                    ; B1CB: 91 BA       ..
 INY                                              ; B1CD: C8          .
 LDA (V),Y                                        ; B1CE: B1 63       .c
 STA (SC),Y                                       ; B1D0: 91 07       ..
 LDA #&FF                                         ; B1D2: A9 FF       ..
 STA (L00BA),Y                                    ; B1D4: 91 BA       ..
 INY                                              ; B1D6: C8          .
 LDA (V),Y                                        ; B1D7: B1 63       .c
 STA (SC),Y                                       ; B1D9: 91 07       ..
 LDA #&FF                                         ; B1DB: A9 FF       ..
 STA (L00BA),Y                                    ; B1DD: 91 BA       ..
 INY                                              ; B1DF: C8          .
 LDA (V),Y                                        ; B1E0: B1 63       .c
 STA (SC),Y                                       ; B1E2: 91 07       ..
 LDA #&FF                                         ; B1E4: A9 FF       ..
 STA (L00BA),Y                                    ; B1E6: 91 BA       ..
 INY                                              ; B1E8: C8          .
 LDA (V),Y                                        ; B1E9: B1 63       .c
 STA (SC),Y                                       ; B1EB: 91 07       ..
 LDA #&FF                                         ; B1ED: A9 FF       ..
 STA (L00BA),Y                                    ; B1EF: 91 BA       ..
 INY                                              ; B1F1: C8          .
 LDA (V),Y                                        ; B1F2: B1 63       .c
 STA (SC),Y                                       ; B1F4: 91 07       ..
 LDA #&FF                                         ; B1F6: A9 FF       ..
 STA (L00BA),Y                                    ; B1F8: 91 BA       ..
 INY                                              ; B1FA: C8          .
 LDA (V),Y                                        ; B1FB: B1 63       .c
 STA (SC),Y                                       ; B1FD: 91 07       ..
 LDA #&FF                                         ; B1FF: A9 FF       ..
 STA (L00BA),Y                                    ; B201: 91 BA       ..
 INY                                              ; B203: C8          .
 LDA (V),Y                                        ; B204: B1 63       .c
 STA (SC),Y                                       ; B206: 91 07       ..
 LDA #&FF                                         ; B208: A9 FF       ..
 STA (L00BA),Y                                    ; B20A: 91 BA       ..
 INY                                              ; B20C: C8          .
 BNE CB215                                        ; B20D: D0 06       ..
 INC V_1                                          ; B20F: E6 64       .d
 INC SC_1                                         ; B211: E6 08       ..
 INC L00BB                                        ; B213: E6 BB       ..
.CB215
 DEX                                              ; B215: CA          .
 BNE CB1B8                                        ; B216: D0 A0       ..
 RTS                                              ; B218: 60          `

 STX K                                            ; B219: 86 7D       .}
 STY K_1                                          ; B21B: 84 7E       .~
 LDA L00B8                                        ; B21D: A5 B8       ..
 STA L046C                                        ; B21F: 8D 6C 04    .l.
 CLC                                              ; B222: 18          .
 ADC #&38 ; '8'                                   ; B223: 69 38       i8
 STA L00B8                                        ; B225: 85 B8       ..
 LDA L046C                                        ; B227: AD 6C 04    .l.
 STA K_2                                          ; B22A: 85 7F       ..
 JSR LEE54                                        ; B22C: 20 54 EE     T.
 LDA #&45 ; 'E'                                   ; B22F: A9 45       .E
 STA K_2                                          ; B231: 85 7F       ..
 LDA #8                                           ; B233: A9 08       ..
 STA K_3                                          ; B235: 85 80       ..
 LDX #0                                           ; B237: A2 00       ..
 LDY #0                                           ; B239: A0 00       ..
 JSR LEE99                                        ; B23B: 20 99 EE     ..
 DEC XC                                           ; B23E: C6 32       .2
 DEC YC                                           ; B240: C6 3B       .;
 INC K                                            ; B242: E6 7D       .}
 INC K_1                                          ; B244: E6 7E       .~
 INC K_1                                          ; B246: E6 7E       .~
 JSR sub_CB2A9                                    ; B248: 20 A9 B2     ..
 LDY #0                                           ; B24B: A0 00       ..
 LDA #&40 ; '@'                                   ; B24D: A9 40       .@
 STA (SC),Y                                       ; B24F: 91 07       ..
 STA (L00BA),Y                                    ; B251: 91 BA       ..
 LDA #&3C ; '<'                                   ; B253: A9 3C       .<
 JSR CB29D                                        ; B255: 20 9D B2     ..
 LDA #&3E ; '>'                                   ; B258: A9 3E       .>
 STA (SC),Y                                       ; B25A: 91 07       ..
 STA (L00BA),Y                                    ; B25C: 91 BA       ..
 DEC K_1                                          ; B25E: C6 7E       .~
 JMP CB276                                        ; B260: 4C 76 B2    Lv.

.CB263
 JSR NAMETABLE0_BANK7                             ; B263: 20 7D EC     }.
 LDA #1                                           ; B266: A9 01       ..
 LDY #0                                           ; B268: A0 00       ..
 STA (SC),Y                                       ; B26A: 91 07       ..
 STA (L00BA),Y                                    ; B26C: 91 BA       ..
 LDA #2                                           ; B26E: A9 02       ..
 LDY K                                            ; B270: A4 7D       .}
 STA (SC),Y                                       ; B272: 91 07       ..
 STA (L00BA),Y                                    ; B274: 91 BA       ..
.CB276
 LDA SC                                           ; B276: A5 07       ..
 CLC                                              ; B278: 18          .
 ADC #&20 ; ' '                                   ; B279: 69 20       i
 STA SC                                           ; B27B: 85 07       ..
 STA L00BA                                        ; B27D: 85 BA       ..
 BCC CB285                                        ; B27F: 90 04       ..
 INC SC_1                                         ; B281: E6 08       ..
 INC L00BB                                        ; B283: E6 BB       ..
.CB285
 DEC K_1                                          ; B285: C6 7E       .~
 BNE CB263                                        ; B287: D0 DA       ..
 LDY #0                                           ; B289: A0 00       ..
 LDA #&41 ; 'A'                                   ; B28B: A9 41       .A
 STA (SC),Y                                       ; B28D: 91 07       ..
 STA (L00BA),Y                                    ; B28F: 91 BA       ..
 LDA #&3D ; '='                                   ; B291: A9 3D       .=
 JSR CB29D                                        ; B293: 20 9D B2     ..
 LDA #&3F ; '?'                                   ; B296: A9 3F       .?
 STA (SC),Y                                       ; B298: 91 07       ..
 STA (L00BA),Y                                    ; B29A: 91 BA       ..
 RTS                                              ; B29C: 60          `

.CB29D
 LDY #1                                           ; B29D: A0 01       ..
.loop_CB29F
 STA (SC),Y                                       ; B29F: 91 07       ..
 STA (L00BA),Y                                    ; B2A1: 91 BA       ..
 INY                                              ; B2A3: C8          .
 CPY K                                            ; B2A4: C4 7D       .}
 BNE loop_CB29F                                   ; B2A6: D0 F7       ..
 RTS                                              ; B2A8: 60          `

.sub_CB2A9
 JSR LDBD8                                        ; B2A9: 20 D8 DB     ..
 LDA SC                                           ; B2AC: A5 07       ..
 CLC                                              ; B2AE: 18          .
 ADC XC                                           ; B2AF: 65 32       e2
 STA SC                                           ; B2B1: 85 07       ..
 STA L00BA                                        ; B2B3: 85 BA       ..
 BCC CB2BB                                        ; B2B5: 90 04       ..
 INC SC_1                                         ; B2B7: E6 08       ..
 INC L00BB                                        ; B2B9: E6 BB       ..
.CB2BB
 RTS                                              ; B2BB: 60          `

 LDA K_2                                          ; B2BC: A5 7F       ..
 STA XC                                           ; B2BE: 85 32       .2
 LDA K_3                                          ; B2C0: A5 80       ..
 STA YC                                           ; B2C2: 85 3B       .;
 JSR sub_CB2A9                                    ; B2C4: 20 A9 B2     ..
 LDA #&3D ; '='                                   ; B2C7: A9 3D       .=
 JSR CB29D                                        ; B2C9: 20 9D B2     ..
 LDX K_1                                          ; B2CC: A6 7E       .~
 JMP CB2E3                                        ; B2CE: 4C E3 B2    L..

.CB2D1
 JSR NAMETABLE0_BANK7                             ; B2D1: 20 7D EC     }.
 LDA SC                                           ; B2D4: A5 07       ..
 CLC                                              ; B2D6: 18          .
 ADC #&20 ; ' '                                   ; B2D7: 69 20       i
 STA SC                                           ; B2D9: 85 07       ..
 STA L00BA                                        ; B2DB: 85 BA       ..
 BCC CB2E3                                        ; B2DD: 90 04       ..
 INC SC_1                                         ; B2DF: E6 08       ..
 INC L00BB                                        ; B2E1: E6 BB       ..
.CB2E3
 LDA #1                                           ; B2E3: A9 01       ..
 LDY #0                                           ; B2E5: A0 00       ..
 STA (SC),Y                                       ; B2E7: 91 07       ..
 STA (L00BA),Y                                    ; B2E9: 91 BA       ..
 LDA #2                                           ; B2EB: A9 02       ..
 LDY K                                            ; B2ED: A4 7D       .}
 STA (SC),Y                                       ; B2EF: 91 07       ..
 STA (L00BA),Y                                    ; B2F1: 91 BA       ..
 DEX                                              ; B2F3: CA          .
 BNE CB2D1                                        ; B2F4: D0 DB       ..
 LDA #&3C ; '<'                                   ; B2F6: A9 3C       .<
 JMP CB29D                                        ; B2F8: 4C 9D B2    L..

 JSR LDBD8                                        ; B2FB: 20 D8 DB     ..
 LDA SC                                           ; B2FE: A5 07       ..
 CLC                                              ; B300: 18          .
 ADC XC                                           ; B301: 65 32       e2
 STA SC                                           ; B303: 85 07       ..
 STA L00BA                                        ; B305: 85 BA       ..
 BCC CB30D                                        ; B307: 90 04       ..
 INC SC_1                                         ; B309: E6 08       ..
 INC L00BB                                        ; B30B: E6 BB       ..
.CB30D
 LDX K_1                                          ; B30D: A6 7E       .~
.CB30F
 LDA L00E9                                        ; B30F: A5 E9       ..
 BPL CB31C                                        ; B311: 10 09       ..
 LDA PPUSTATUS                                    ; B313: AD 02 20    ..
 ASL A                                            ; B316: 0A          .
 BPL CB31C                                        ; B317: 10 03       ..
 JSR NAMETABLE0                                   ; B319: 20 6D D0     m.
.CB31C
 LDY #0                                           ; B31C: A0 00       ..
 LDA K_2                                          ; B31E: A5 7F       ..
.loop_CB320
 STA (L00BA),Y                                    ; B320: 91 BA       ..
 STA (SC),Y                                       ; B322: 91 07       ..
 CLC                                              ; B324: 18          .
 ADC #1                                           ; B325: 69 01       i.
 INY                                              ; B327: C8          .
 CPY K                                            ; B328: C4 7D       .}
 BNE loop_CB320                                   ; B32A: D0 F4       ..
 STA K_2                                          ; B32C: 85 7F       ..
 LDA SC                                           ; B32E: A5 07       ..
 CLC                                              ; B330: 18          .
 ADC #&20 ; ' '                                   ; B331: 69 20       i
 STA SC                                           ; B333: 85 07       ..
 STA L00BA                                        ; B335: 85 BA       ..
 BCC CB33D                                        ; B337: 90 04       ..
 INC SC_1                                         ; B339: E6 08       ..
 INC L00BB                                        ; B33B: E6 BB       ..
.CB33D
 DEX                                              ; B33D: CA          .
 BNE CB30F                                        ; B33E: D0 CF       ..
 RTS                                              ; B340: 60          `

 LDA #0                                           ; B341: A9 00       ..
 STA SC_1                                         ; B343: 85 08       ..
 LDA #&42 ; 'B'                                   ; B345: A9 42       .B
 ASL A                                            ; B347: 0A          .
 ROL SC_1                                         ; B348: 26 08       &.
 ASL A                                            ; B34A: 0A          .
 ROL SC_1                                         ; B34B: 26 08       &.
 ASL A                                            ; B34D: 0A          .
 ROL SC_1                                         ; B34E: 26 08       &.
 STA SC                                           ; B350: 85 07       ..
 STA L00BA                                        ; B352: 85 BA       ..
 LDA SC_1                                         ; B354: A5 08       ..
 ADC #&68 ; 'h'                                   ; B356: 69 68       ih
 STA L00BB                                        ; B358: 85 BB       ..
 LDA SC_1                                         ; B35A: A5 08       ..
 ADC #&60 ; '`'                                   ; B35C: 69 60       i`
 STA SC_1                                         ; B35E: 85 08       ..
 LDX #&42 ; 'B'                                   ; B360: A2 42       .B
 LDY #0                                           ; B362: A0 00       ..
.CB364
 LDA #0                                           ; B364: A9 00       ..
 STA (SC),Y                                       ; B366: 91 07       ..
 STA (L00BA),Y                                    ; B368: 91 BA       ..
 INY                                              ; B36A: C8          .
 STA (SC),Y                                       ; B36B: 91 07       ..
 STA (L00BA),Y                                    ; B36D: 91 BA       ..
 INY                                              ; B36F: C8          .
 STA (SC),Y                                       ; B370: 91 07       ..
 STA (L00BA),Y                                    ; B372: 91 BA       ..
 INY                                              ; B374: C8          .
 STA (SC),Y                                       ; B375: 91 07       ..
 STA (L00BA),Y                                    ; B377: 91 BA       ..
 INY                                              ; B379: C8          .
 STA (SC),Y                                       ; B37A: 91 07       ..
 STA (L00BA),Y                                    ; B37C: 91 BA       ..
 INY                                              ; B37E: C8          .
 STA (SC),Y                                       ; B37F: 91 07       ..
 STA (L00BA),Y                                    ; B381: 91 BA       ..
 INY                                              ; B383: C8          .
 STA (SC),Y                                       ; B384: 91 07       ..
 STA (L00BA),Y                                    ; B386: 91 BA       ..
 INY                                              ; B388: C8          .
 STA (SC),Y                                       ; B389: 91 07       ..
 STA (L00BA),Y                                    ; B38B: 91 BA       ..
 INY                                              ; B38D: C8          .
 BNE CB394                                        ; B38E: D0 04       ..
 INC SC_1                                         ; B390: E6 08       ..
 INC L00BB                                        ; B392: E6 BB       ..
.CB394
 LDA L00E9                                        ; B394: A5 E9       ..
 BPL CB3A1                                        ; B396: 10 09       ..
 LDA PPUSTATUS                                    ; B398: AD 02 20    ..
 ASL A                                            ; B39B: 0A          .
 BPL CB3A1                                        ; B39C: 10 03       ..
 JSR NAMETABLE0                                   ; B39E: 20 6D D0     m.
.CB3A1
 INX                                              ; B3A1: E8          .
 BNE CB364                                        ; B3A2: D0 C0       ..
 LDA #0                                           ; B3A4: A9 00       ..
 STA SC                                           ; B3A6: 85 07       ..
 STA L00BA                                        ; B3A8: 85 BA       ..
 LDA #&70 ; 'p'                                   ; B3AA: A9 70       .p
 STA SC_1                                         ; B3AC: 85 08       ..
 LDA #&74 ; 't'                                   ; B3AE: A9 74       .t
 STA L00BB                                        ; B3B0: 85 BB       ..
 LDX #&1C                                         ; B3B2: A2 1C       ..
.CB3B4
 LDY #&20 ; ' '                                   ; B3B4: A0 20       .
 LDA #0                                           ; B3B6: A9 00       ..
.loop_CB3B8
 STA (SC),Y                                       ; B3B8: 91 07       ..
 STA (L00BA),Y                                    ; B3BA: 91 BA       ..
 DEY                                              ; B3BC: 88          .
 BPL loop_CB3B8                                   ; B3BD: 10 F9       ..
 LDA L00E9                                        ; B3BF: A5 E9       ..
 BPL CB3CC                                        ; B3C1: 10 09       ..
 LDA PPUSTATUS                                    ; B3C3: AD 02 20    ..
 ASL A                                            ; B3C6: 0A          .
 BPL CB3CC                                        ; B3C7: 10 03       ..
 JSR NAMETABLE0                                   ; B3C9: 20 6D D0     m.
.CB3CC
 LDA SC                                           ; B3CC: A5 07       ..
 CLC                                              ; B3CE: 18          .
 ADC #&20 ; ' '                                   ; B3CF: 69 20       i
 STA SC                                           ; B3D1: 85 07       ..
 STA L00BA                                        ; B3D3: 85 BA       ..
 BCC CB3DB                                        ; B3D5: 90 04       ..
 INC SC_1                                         ; B3D7: E6 08       ..
 INC L00BB                                        ; B3D9: E6 BB       ..
.CB3DB
 DEX                                              ; B3DB: CA          .
 BNE CB3B4                                        ; B3DC: D0 D6       ..
 RTS                                              ; B3DE: 60          `

 EQUB &0F, &2C, &0F, &2C, &0F, &28,   0, &1A, &0F ; B3DF: 0F 2C 0F... .,.
 EQUB &10,   0, &16, &0F, &10,   0, &1C, &0F, &38 ; B3E8: 10 00 16... ...
 EQUB &2A, &15, &0F, &1C, &22, &28, &0F, &16, &28 ; B3F1: 2A 15 0F... *..
 EQUB &27, &0F, &15, &20, &25, &0F                ; B3FA: 27 0F 15... '..
 EQUS "888"                                       ; B400: 38 38 38    888
 EQUB &0F, &10,   6, &1A, &0F, &22,   0, &28, &0F ; B403: 0F 10 06... ...
 EQUB &10,   0, &1C, &0F, &38, &10, &15, &0F, &10 ; B40C: 10 00 1C... ...
 EQUB &0F, &1C, &0F,   6, &28, &25, &0F, &15, &20 ; B415: 0F 1C 0F... ...
 EQUB &25, &0F, &2C, &0F, &2C, &0F, &28,   0, &1A ; B41E: 25 0F 2C... %.,
 EQUB &0F, &10,   0, &16, &0F, &10,   0, &3A, &0F ; B427: 0F 10 00... ...
 EQUB &38, &10, &15, &0F, &1C, &10, &28, &0F,   6 ; B430: 38 10 15... 8..
 EQUB &10, &27, &0F,   0, &10, &25, &0F, &2C, &0F ; B439: 10 27 0F... .'.
 EQUB &2C, &0F, &10, &1A, &28, &0F, &10,   0, &16 ; B442: 2C 0F 10... ,..
 EQUB &0F, &10,   0, &1C, &0F, &38, &2A, &15, &0F ; B44B: 0F 10 00... ...
 EQUB &1C, &22, &28, &0F,   6, &28, &27, &0F, &15 ; B454: 1C 22 28... ."(
 EQUB &20, &25, &0F, &2C, &0F, &2C, &0F           ; B45D: 20 25 0F...  %.
 EQUS " (%"                                       ; B464: 20 28 25     (%
 EQUB &0F, &10,   0, &16, &0F, &10,   0, &1C, &0F ; B467: 0F 10 00... ...
 EQUB &38, &2A, &15, &0F, &1C, &22, &28, &0F,   6 ; B470: 38 2A 15... 8*.
 EQUB &28, &27, &0F, &15, &20, &25, &0F, &28, &10 ; B479: 28 27 0F... ('.
 EQUB   6, &0F, &10,   0, &1A, &0F, &0C, &1C, &2C ; B482: 06 0F 10... ...
 EQUB &0F, &10,   0, &1C, &0F, &0C, &1C, &2C, &0F ; B48B: 0F 10 00... ...
 EQUB &18, &28, &38, &0F                          ; B494: 18 28 38... .(8
 EQUS "%5%"                                       ; B498: 25 35 25    %5%
 EQUB &0F, &15, &20, &25, &0F, &2A,   0,   6, &0F ; B49B: 0F 15 20... ..
 EQUB &20,   0, &2A, &0F, &10,   0, &20, &0F, &10 ; B4A4: 20 00 2A...  .*
 EQUB   0, &1C, &0F, &38, &2A, &15, &0F, &27, &28 ; B4AD: 00 1C 0F... ...
 EQUB &17, &0F,   6, &28, &27, &0F, &15, &20, &25 ; B4B6: 17 0F 06... ...
 EQUB &0F, &28, &0F, &25, &0F, &10,   6, &1A, &0F ; B4BF: 0F 28 0F... .(.
 EQUB &10, &0F, &1A, &0F, &10,   0, &1C, &0F, &38 ; B4C8: 10 0F 1A... ...
 EQUB &2A, &15, &0F, &18, &28, &38, &0F,   6, &2C ; B4D1: 2A 15 0F... *..
 EQUB &2C, &0F, &15, &20, &25, &0F, &1C, &10, &30 ; B4DA: 2C 0F 15... ,..
 EQUB &0F, &20,   0, &2A, &0F, &2A,   0,   6, &0F ; B4E3: 0F 20 00... . .
 EQUB &10,   0, &1C, &0F, &0F, &10, &30, &0F, &17 ; B4EC: 10 00 1C... ...
 EQUB &27, &37, &0F, &0F, &28, &38, &0F, &15, &25 ; B4F5: 27 37 0F... '7.
 EQUB &25, &0F, &1C, &2C, &3C, &0F, &38, &11, &11 ; B4FE: 25 0F 1C... %..
 EQUB &0F, &16,   0, &20, &0F, &2B,   0, &25, &0F ; B507: 0F 16 00... ...
 EQUB &10, &1A, &25, &0F,   8, &18, &27, &0F, &0F ; B510: 10 1A 25... ..%
 EQUB &28, &38, &0F,   0, &10, &30, &0F, &2C, &0F ; B519: 28 38 0F... (8.
 EQUB &2C, &0F, &10, &28, &1A, &0F, &10,   0, &16 ; B522: 2C 0F 10... ,..
 EQUB &0F, &10,   0, &1C, &0F, &38, &2A, &15, &0F ; B52B: 0F 10 00... ...
 EQUB &1C, &22, &28, &0F,   6, &28, &27, &0F, &15 ; B534: 1C 22 28... ."(
 EQUB &20, &25                                    ; B53D: 20 25        %
.LB53F
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0F ; B53F: 0F 0F 0F... ...
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F,   0,   1 ; B548: 0F 0F 0F... ...
 EQUB   2,   3,   4,   5,   6,   7,   8,   9, &0A ; B551: 02 03 04... ...
 EQUB &0B, &0C, &0F, &0F, &0F, &10, &11, &12, &13 ; B55A: 0B 0C 0F... ...
 EQUB &14, &15, &16, &17, &18, &19, &1A, &1B, &1C ; B563: 14 15 16... ...
 EQUB &0F, &0F, &0F                               ; B56C: 0F 0F 0F    ...
 EQUS " !", '"', "#$%&'()*+,"                     ; B56F: 20 21 22...  !"
 EQUB &0F, &0F, &0F                               ; B57C: 0F 0F 0F    ...

.sub_CB57F
 LDA QQ11                                         ; B57F: A5 9F       ..
 AND #&0F                                         ; B581: 29 0F       ).
 TAX                                              ; B583: AA          .
 LDA #0                                           ; B584: A9 00       ..
 STA SC_1                                         ; B586: 85 08       ..
 LDA LAA5C,X                                      ; B588: BD 5C AA    .\.
 LDY #0                                           ; B58B: A0 00       ..
 STY SC_1                                         ; B58D: 84 08       ..
 ASL A                                            ; B58F: 0A          .
 ASL A                                            ; B590: 0A          .
 ASL A                                            ; B591: 0A          .
 ASL A                                            ; B592: 0A          .
 ASL A                                            ; B593: 0A          .
 ROL SC_1                                         ; B594: 26 08       &.
 ADC #&DF                                         ; B596: 69 DF       i.
 STA SC                                           ; B598: 85 07       ..
 LDA #&B3                                         ; B59A: A9 B3       ..
 ADC SC_1                                         ; B59C: 65 08       e.
 STA SC_1                                         ; B59E: 85 08       ..
 LDY #&20 ; ' '                                   ; B5A0: A0 20       .
.loop_CB5A2
 LDA (SC),Y                                       ; B5A2: B1 07       ..
 STA XX3,Y                                        ; B5A4: 99 00 01    ...
 DEY                                              ; B5A7: 88          .
 BPL loop_CB5A2                                   ; B5A8: 10 F8       ..
 LDA QQ11                                         ; B5AA: A5 9F       ..
 BEQ CB5DE                                        ; B5AC: F0 30       .0
 CMP #&98                                         ; B5AE: C9 98       ..
 BEQ CB607                                        ; B5B0: F0 55       .U
 CMP #&96                                         ; B5B2: C9 96       ..
 BNE CB5DB                                        ; B5B4: D0 25       .%
 LDA QQ15                                         ; B5B6: A5 82       ..
 EOR QQ15_5                                       ; B5B8: 45 87       E.
 EOR QQ15_2                                       ; B5BA: 45 84       E.
 LSR A                                            ; B5BC: 4A          J
 LSR A                                            ; B5BD: 4A          J
 EOR #&0C                                         ; B5BE: 49 0C       I.
 AND #&1C                                         ; B5C0: 29 1C       ).
 TAX                                              ; B5C2: AA          .
 LDA LB6A5,X                                      ; B5C3: BD A5 B6    ...
 STA L0114                                        ; B5C6: 8D 14 01    ...
 LDA LB6A6,X                                      ; B5C9: BD A6 B6    ...
 STA L0115                                        ; B5CC: 8D 15 01    ...
 LDA LB6A7,X                                      ; B5CF: BD A7 B6    ...
 STA L0116                                        ; B5D2: 8D 16 01    ...
 LDA LB6A8,X                                      ; B5D5: BD A8 B6    ...
 STA L0117                                        ; B5D8: 8D 17 01    ...
.CB5DB
 JMP CB607                                        ; B5DB: 4C 07 B6    L..

.CB5DE
 LDA XX3                                          ; B5DE: AD 00 01    ...
 LDY L0103                                        ; B5E1: AC 03 01    ...
 LDA L00F3                                        ; B5E4: A5 F3       ..
 BNE CB5EF                                        ; B5E6: D0 07       ..
 STA XX3_1                                        ; B5E8: 8D 01 01    ...
 STY L0102                                        ; B5EB: 8C 02 01    ...
 RTS                                              ; B5EE: 60          `

.CB5EF
 STY XX3_1                                        ; B5EF: 8C 01 01    ...
 STA L0102                                        ; B5F2: 8D 02 01    ...
 RTS                                              ; B5F5: 60          `

.sub_CB5F6
 JSR sub_CB5F9                                    ; B5F6: 20 F9 B5     ..
.sub_CB5F9
 LDX #&1F                                         ; B5F9: A2 1F       ..
.loop_CB5FB
 LDY XX3,X                                        ; B5FB: BC 00 01    ...
 LDA LB53F,Y                                      ; B5FE: B9 3F B5    .?.
 STA XX3,X                                        ; B601: 9D 00 01    ...
 DEX                                              ; B604: CA          .
 BNE loop_CB5FB                                   ; B605: D0 F4       ..
.CB607
 LDA #&0F                                         ; B607: A9 0F       ..
 STA L0033                                        ; B609: 85 33       .3
 LDA QQ11                                         ; B60B: A5 9F       ..
 BPL CB627                                        ; B60D: 10 18       ..
 CMP #&C4                                         ; B60F: C9 C4       ..
 BEQ CB627                                        ; B611: F0 14       ..
 CMP #&98                                         ; B613: C9 98       ..
 BEQ CB62D                                        ; B615: F0 16       ..
 LDA L0115                                        ; B617: AD 15 01    ...
 STA L0034                                        ; B61A: 85 34       .4
 LDA L0116                                        ; B61C: AD 16 01    ...
 STA L0035                                        ; B61F: 85 35       .5
 LDA L0117                                        ; B621: AD 17 01    ...
 STA L0036                                        ; B624: 85 36       .6
 RTS                                              ; B626: 60          `

.CB627
 LDA L0103                                        ; B627: AD 03 01    ...
 STA L0034                                        ; B62A: 85 34       .4
 RTS                                              ; B62C: 60          `

.CB62D
 LDA XX3_1                                        ; B62D: AD 01 01    ...
 STA L0034                                        ; B630: 85 34       .4
 LDA L0102                                        ; B632: AD 02 01    ...
 STA L0035                                        ; B635: 85 35       .5
 LDA L0103                                        ; B637: AD 03 01    ...
 STA L0036                                        ; B63A: 85 36       .6
 RTS                                              ; B63C: 60          `

 LDA QQ11                                         ; B63D: A5 9F       ..
 CMP #&FF                                         ; B63F: C9 FF       ..
 BEQ CB66D                                        ; B641: F0 2A       .*
 LDA L0473                                        ; B643: AD 73 04    .s.
 BMI CB66D                                        ; B646: 30 25       0%
 JSR LD8C5                                        ; B648: 20 C5 D8     ..
 JSR LD167                                        ; B64B: 20 67 D1     g.
 JSR sub_CB57F                                    ; B64E: 20 7F B5     ..
 DEC L00DA                                        ; B651: C6 DA       ..
 JSR sub_CB5F9                                    ; B653: 20 F9 B5     ..
 JSR LD164                                        ; B656: 20 64 D1     d.
 JSR sub_CB5F9                                    ; B659: 20 F9 B5     ..
 JSR LD164                                        ; B65C: 20 64 D1     d.
 JSR sub_CB5F9                                    ; B65F: 20 F9 B5     ..
 JSR LD164                                        ; B662: 20 64 D1     d.
 JSR sub_CB5F9                                    ; B665: 20 F9 B5     ..
 JSR LD164                                        ; B668: 20 64 D1     d.
 INC L00DA                                        ; B66B: E6 DA       ..
.CB66D
 LDA #&FF                                         ; B66D: A9 FF       ..
 STA L0473                                        ; B66F: 8D 73 04    .s.
 RTS                                              ; B672: 60          `

 JSR LD167                                        ; B673: 20 67 D1     g.
 JSR sub_CB57F                                    ; B676: 20 7F B5     ..
 JSR sub_CB5F6                                    ; B679: 20 F6 B5     ..
 JSR sub_CB5F9                                    ; B67C: 20 F9 B5     ..
 DEC L00DA                                        ; B67F: C6 DA       ..
 JSR LD164                                        ; B681: 20 64 D1     d.
 JSR sub_CB57F                                    ; B684: 20 7F B5     ..
 JSR sub_CB5F6                                    ; B687: 20 F6 B5     ..
 JSR LD164                                        ; B68A: 20 64 D1     d.
 JSR sub_CB57F                                    ; B68D: 20 7F B5     ..
 JSR sub_CB5F9                                    ; B690: 20 F9 B5     ..
 JSR LD164                                        ; B693: 20 64 D1     d.
 JSR sub_CB57F                                    ; B696: 20 7F B5     ..
 JSR CB607                                        ; B699: 20 07 B6     ..
 JSR LD167                                        ; B69C: 20 67 D1     g.
 INC L00DA                                        ; B69F: E6 DA       ..
 LSR L0473                                        ; B6A1: 4E 73 04    Ns.
 RTS                                              ; B6A4: 60          `

.LB6A5
 EQUB &0F                                         ; B6A5: 0F          .
.LB6A6
 EQUB &25                                         ; B6A6: 25          %
.LB6A7
 EQUB &16                                         ; B6A7: 16          .
.LB6A8
 EQUB &15, &0F, &35, &16, &25, &0F, &34,   4, &14 ; B6A8: 15 0F 35... ..5
 EQUB &0F, &27, &28, &17, &0F, &29, &2C, &19, &0F ; B6B1: 0F 27 28... .'(
 EQUB &2A, &1B, &0A, &0F, &32, &21,   2, &0F, &2C ; B6BA: 2A 1B 0A... *..
 EQUB &22, &1C, &18,   0                          ; B6C3: 22 1C 18... "..
.LB6C7
 EQUB &32                                         ; B6C7: 32          2
.LB6C8
 EQUB   0, &56,   0, &77,   0, &8B,   0, &A6,   0 ; B6C8: 00 56 00... .V.
 EQUB &C1,   0, &DA,   0, &EF,   0,   4,   1, &19 ; B6D1: C1 00 DA... ...
 EQUB   1, &2F,   1, &55,   1, &77,   1, &9A,   1 ; B6DA: 01 2F 01... ./.
 EQUB &B7,   1, &D6,   1, &F4,   1, &25,   2, &57 ; B6E3: B7 01 D6... ...
 EQUB   2, &89,   2, &96,   2, &A5,   2, &B5,   2 ; B6EC: 02 89 02... ...
 EQUB &CC,   2                                    ; B6F5: CC 02       ..
 EQUS "1?'"                                       ; B6F7: 31 3F 27    1?'
 EQUB &0F, &21, &33,   7, &21, &33,   7, &21, &33 ; B6FA: 0F 21 33... .!3
 EQUB   7, &21, &33,   7, &FF, &BF, &23, &AF, &22 ; B703: 07 21 33... .!3
 EQUB &AB, &AE, &77, &99, &25, &AA, &5A, &32,   7 ; B70C: AB AE 77... ..w
 EQUB   9, &25, &0A, &21, &0F                     ; B715: 09 25 0A... .%.
 EQUS "?1?'"                                      ; B71A: 3F 31 3F... ?1?
 EQUB &0F, &21, &33,   7, &21, &33,   7, &21, &33 ; B71E: 0F 21 33... .!3
 EQUB   7, &21, &33,   7, &12, &26, &AF, &77, &DD ; B727: 07 21 33... .!3
 EQUB &25, &AA, &5A, &32,   7, &0D, &24, &0F, &32 ; B730: 25 AA 5A... %.Z
 EQUB &0E,   5, &3F, &18                          ; B739: 0E 05 3F... ..?
 EQUS "w'Uw'Uw'Uw'Uw'U"                           ; B73D: 77 27 55... w'U
 EQUB &18, &28, &0F, &3F, &18                     ; B74C: 18 28 0F... .(.
 EQUS "w'Uw'Uw'Uw'Uw'U"                           ; B751: 77 27 55... w'U
 EQUB &15, &22, &BF, &EF, &25, &0F, &22, &0B, &21 ; B760: 15 22 BF... .".
 EQUB &0E                                         ; B769: 0E          .
 EQUS "?1?'"                                      ; B76A: 3F 31 3F... ?1?
 EQUB &0F, &21, &33,   7                          ; B76E: 0F 21 33... .!3
 EQUS "s'Pw'Uw'Uw'U"                              ; B772: 73 27 50... s'P
 EQUB &F7, &FD, &14, &FE, &F5, &28, &0F           ; B77E: F7 FD 14... ...
 EQUS "?1?'"                                      ; B785: 3F 31 3F... ?1?
 EQUB &0F, &21, &33,   7, &21, &33,   7, &21, &33 ; B789: 0F 21 33... .!3
 EQUB   7, &21, &33,   7, &21, &33,   7, &21, &33 ; B792: 07 21 33... .!3
 EQUB   7, &28, &0F, &3F, &28, &AF                ; B79B: 07 28 0F... .(.
 EQUS "w'Uw'Uw'Uw'Uw'U"                           ; B7A1: 77 27 55... w'U
 EQUB &18, &28, &0F, &3F, &28, &AF                ; B7B0: 18 28 0F... .(.
 EQUS "w'Zw'Uw'Uw'Uw'U"                           ; B7B6: 77 27 5A... w'Z
 EQUB &18, &28, &0F, &3F, &28, &AF                ; B7C5: 18 28 0F... .(.
 EQUS "w'Uw'Uw'Uw'Uw'U"                           ; B7CB: 77 27 55... w'U
 EQUB &18, &28, &0F                               ; B7DA: 18 28 0F    .(.
 EQUS "?(_w'Uw'Uw'Uw'U"                           ; B7DD: 3F 28 5F... ?(_
 EQUB &BB, &27, &AA, &FB, &27, &FA, &18, &3F, &23 ; B7EC: BB 27 AA... .'.
 EQUB &0F                                         ; B7F5: 0F          .
 EQUS "%_!3"                                      ; B7F6: 25 5F 21... %_!
 EQUB   0, &21,   4                               ; B7FA: 00 21 04    .!.
 EQUS "E$U!3"                                     ; B7FD: 45 24 55... E$U
 EQUB   2, &54, &55, &99, &22, &AA, &21, &33,   0 ; B802: 02 54 55... .TU
 EQUB &21,   4, &22, &55, &99, &22, &AA, &F7, &27 ; B80B: 21 04 22... !."
 EQUB &F5, &1F, &11, &28, &0F, &3F, &23, &0F      ; B814: F5 1F 11... ...
 EQUS "O$_!3"                                     ; B81C: 4F 24 5F... O$_
 EQUB 2                                           ; B821: 02          .
 EQUS "%U!3"                                      ; B822: 25 55 21... %U!
 EQUB 0                                           ; B826: 00          .
 EQUS "@TU"                                       ; B827: 40 54 55    @TU
 EQUB &99, &22, &AA, &21, &33,   0, &21,   4, &45 ; B82A: 99 22 AA... .".
 EQUB &55, &99, &22, &AA, &1F, &19, &28, &0F, &3F ; B833: 55 99 22... U."
 EQUB &23, &0F                                    ; B83C: 23 0F       #.
 EQUS "%_!3"                                      ; B83E: 25 5F 21... %_!
 EQUB   0, &21,   4                               ; B842: 00 21 04    .!.
 EQUS "E$U!3"                                     ; B845: 45 24 55... E$U
 EQUB 0                                           ; B84A: 00          .
 EQUS '"', "PU"                                   ; B84B: 22 50 55    "PU
 EQUB &99, &22, &AA, &21, &33,   0, &21,   4, &22 ; B84E: 99 22 AA... .".
 EQUB &55, &99, &22, &AA, &1F, &1F, &12, &3F, &23 ; B857: 55 99 22... U."
 EQUB &AF, &25, &5F, &BB, &22, &AA                ; B860: AF 25 5F... .%_
 EQUS '"', "Z#U"                                  ; B866: 22 5A 23... "Z#
 EQUB &BB, &AA, &22, &A5, &22, &55,   2, &FB, &24 ; B86A: BB AA 22... .."
 EQUB &FA, &FF,   2, &16, &22, &F0, &1F, &19, &3F ; B873: FA FF 02... ...
 EQUB &25, &AF, &23, &5F, &BB, &AA                ; B87C: 25 AF 23... %.#
 EQUS "j#Z", '"', "U"                             ; B882: 6A 23 5A... j#Z
 EQUB &BB, &22, &AA                               ; B887: BB 22 AA    .".
 EQUS "e", '"', "U"                               ; B88A: 65 22 55    e"U
 EQUB   2, &FB, &24, &FA, &FF,   2, &16, &22, &F0 ; B88D: 02 FB 24... ..$
 EQUB &1F, &11, &28, &0F, &3F, &23, &AF           ; B896: 1F 11 28... ..(
 EQUS "o$_"                                       ; B89D: 6F 24 5F    o$_
 EQUB &BB, &23, &AA                               ; B8A0: BB 23 AA    .#.
 EQUS "ZV", '"', "U"                              ; B8A3: 5A 56 22... ZV"
 EQUB &BB, &AA                                    ; B8A7: BB AA       ..
 EQUS "jV", '"', "U", '"'                         ; B8A9: 6A 56 22... jV"
 EQUB   5, &FB, &24, &FA, &FF,   2, &16,   2, &1F ; B8AE: 05 FB 24... ..$
 EQUB &19, &3F, &18                               ; B8B7: 19 3F 18    .?.
 EQUS "s", '"', "P", '"'                          ; B8BA: 73 22 50... s"P
 EQUB &A0                                         ; B8BE: A0          .
 EQUS "`", '"', "Pw"                              ; B8BF: 60 22 50... `"P
 EQUB   0, &99, &22, &AA                          ; B8C3: 00 99 22... .."
 EQUS "f", '"', "Us", '"', "P", '"'               ; B8C7: 66 22 55... f"U
 EQUB &AA                                         ; B8CE: AA          .
 EQUS "f", '"', "UwU"                             ; B8CF: 66 22 55... f"U
 EQUB &99, &22, &AA                               ; B8D4: 99 22 AA    .".
 EQUS "f", '"', "U37"                             ; B8D7: 66 22 55... f"U
 EQUB   5,   9, &22, &AA, &A6, &22, &A5, &F3, &22 ; B8DC: 05 09 22... .."
 EQUB &F0, &24, &FA, &19, &3F, &18                ; B8E5: F0 24 FA... .$.
 EQUS "s", '"', "P", '"'                          ; B8EB: 73 22 50... s"P
 EQUB &A0                                         ; B8EF: A0          .
 EQUS "`", '"', "Pw"                              ; B8F0: 60 22 50... `"P
 EQUB   0, &99, &22, &AA                          ; B8F4: 00 99 22... .."
 EQUS "f", '"', "Us", '"', "P", '"'               ; B8F8: 66 22 55... f"U
 EQUB &AA                                         ; B8FF: AA          .
 EQUS "f", '"', "UwU"                             ; B900: 66 22 55... f"U
 EQUB &99, &22, &AA                               ; B905: 99 22 AA    .".
 EQUS "f", '"', "U37"                             ; B908: 66 22 55... f"U
 EQUB   5,   9, &8A, &AA, &A6, &22, &A5, &F3, &22 ; B90D: 05 09 8A... ...
 EQUB &F0, &F8, &23, &FA, &19, &3F, &18           ; B916: F0 F8 23... ..#
 EQUS "s", '"', "P", '"'                          ; B91D: 73 22 50... s"P
 EQUB &A0                                         ; B921: A0          .
 EQUS "`", '"', "Pw"                              ; B922: 60 22 50... `"P
 EQUB   0, &99, &22, &AA                          ; B926: 00 99 22... .."
 EQUS "f", '"', "Us", '"', "P", '"'               ; B92A: 66 22 55... f"U
 EQUB &AA                                         ; B931: AA          .
 EQUS "f", '"', "UwU"                             ; B932: 66 22 55... f"U
 EQUB &99, &22, &AA                               ; B937: 99 22 AA    .".
 EQUS "f", '"', "U37"                             ; B93A: 66 22 55... f"U
 EQUB   5,   9, &8A, &AA, &A6, &22, &A5, &F3, &22 ; B93F: 05 09 8A... ...
 EQUB &F0, &F8, &23, &FA, &19, &3F, &AF, &27, &5F ; B948: F0 F8 23... ..#
 EQUB &FB, &FA, &26, &F5, &1F, &1F, &1A, &28, &0F ; B951: FB FA 26... ..&
 EQUB &3F, &23, &AF, &25, &5F, &FB, &22, &FA, &25 ; B95A: 3F 23 AF... ?#.
 EQUB &F5, &1F, &1F, &1A, &28, &0F, &3F, &22, &AF ; B963: F5 1F 1F... ...
 EQUS "o%_"                                       ; B96C: 6F 25 5F    o%_
 EQUB &FB, &FA, &F6, &25, &F5, &1F, &1F, &1A, &28 ; B96F: FB FA F6... ...
 EQUB &0F                                         ; B978: 0F          .
 EQUS "?1?'"                                      ; B979: 3F 31 3F... ?1?
 EQUB &0F, &21, &33,   7, &21, &33,   7, &21, &33 ; B97D: 0F 21 33... .!3
 EQUB   7, &21, &33,   7, &21, &33,   7, &18, &28 ; B986: 07 21 33... .!3
 EQUB &0F                                         ; B98F: 0F          .
 EQUS "?1?'"                                      ; B990: 3F 31 3F... ?1?
 EQUB &0F, &21, &33,   7, &21, &33,   7, &21, &33 ; B994: 0F 21 33... .!3
 EQUB   7, &21, &33,   7, &F3, &27, &F0, &FB      ; B99D: 07 21 33... .!3
 EQUS "'Z("                                       ; B9A5: 27 5A 28    'Z(
 EQUB &0F, &3F,   0,   1, &16,   4,   5,   2, &0A ; B9A8: 0F 3F 00... .?.
 EQUB &13, &0D,   9,   6, &10,   3,   3,   2, &17 ; B9B1: 13 0D 09... ...
 EQUB   0,   1, &16,   4,   5,   2, &0B, &14, &0E ; B9BA: 00 01 16... ...
 EQUB   9,   7, &11,   3,   3,   2,   2,   0,   1 ; B9C3: 09 07 11... ...
 EQUB &16,   4,   5,   2, &0C, &15, &0F,   9,   8 ; B9CC: 16 04 05... ...
 EQUB &12,   3,   3,   2, &17                     ; B9D5: 12 03 03... ...
.LB9DA
 EQUB &AA, &BA, &CA, &AA                          ; B9DA: AA BA CA... ...
.LB9DE
 EQUB &B9, &B9, &B9, &B9                          ; B9DE: B9 B9 B9... ...

 LDX LANG                                         ; B9E2: AE A8 04    ...
 LDA LB9DA,X                                      ; B9E5: BD DA B9    ...
 STA V                                            ; B9E8: 85 63       .c
 LDA LB9DE,X                                      ; B9EA: BD DE B9    ...
 STA V_1                                          ; B9ED: 85 64       .d
 LDA W                                            ; B9EF: A5 9E       ..
 AND #&0F                                         ; B9F1: 29 0F       ).
 TAY                                              ; B9F3: A8          .
 LDA (V),Y                                        ; B9F4: B1 63       .c
 ASL A                                            ; B9F6: 0A          .
 TAX                                              ; B9F7: AA          .
 LDA LB6C7,X                                      ; B9F8: BD C7 B6    ...
 ADC #&C5                                         ; B9FB: 69 C5       i.
 STA V                                            ; B9FD: 85 63       .c
 LDA LB6C8,X                                      ; B9FF: BD C8 B6    ...
 ADC #&B6                                         ; BA02: 69 B6       i.
 STA V_1                                          ; BA04: 85 64       .d
 LDA #&73 ; 's'                                   ; BA06: A9 73       .s
 STA SC_1                                         ; BA08: 85 08       ..
 LDA #&C0                                         ; BA0A: A9 C0       ..
 STA SC                                           ; BA0C: 85 07       ..
 JMP LF52D                                        ; BA0E: 4C 2D F5    L-.

.loop_CBA11
 LDA #&F0                                         ; BA11: A9 F0       ..
 STA L0214                                        ; BA13: 8D 14 02    ...
 STA L0218                                        ; BA16: 8D 18 02    ...
 STA L021C                                        ; BA19: 8D 1C 02    ...
 STA L0220                                        ; BA1C: 8D 20 02    . .
 STA L0224                                        ; BA1F: 8D 24 02    .$.
 RTS                                              ; BA22: 60          `

 LDY VIEW                                         ; BA23: AC 8E 03    ...
 LDA L03A8,Y                                      ; BA26: B9 A8 03    ...
 BEQ loop_CBA11                                   ; BA29: F0 E6       ..
 CMP #&18                                         ; BA2B: C9 18       ..
 BNE CBA32                                        ; BA2D: D0 03       ..
 JMP CBAC6                                        ; BA2F: 4C C6 BA    L..

.CBA32
 CMP #&8F                                         ; BA32: C9 8F       ..
 BNE CBA39                                        ; BA34: D0 03       ..
 JMP CBB08                                        ; BA36: 4C 08 BB    L..

.CBA39
 CMP #&97                                         ; BA39: C9 97       ..
 BNE CBA83                                        ; BA3B: D0 46       .F
 LDA #&80                                         ; BA3D: A9 80       ..
 STA L0222                                        ; BA3F: 8D 22 02    .".
 LDA #&40 ; '@'                                   ; BA42: A9 40       .@
 STA L021A                                        ; BA44: 8D 1A 02    ...
 LDA #0                                           ; BA47: A9 00       ..
 STA L021E                                        ; BA49: 8D 1E 02    ...
 STA L0216                                        ; BA4C: 8D 16 02    ...
 LDY #&CF                                         ; BA4F: A0 CF       ..
 STY L0215                                        ; BA51: 8C 15 02    ...
 STY L0219                                        ; BA54: 8C 19 02    ...
 INY                                              ; BA57: C8          .
 STY L021D                                        ; BA58: 8C 1D 02    ...
 STY L0221                                        ; BA5B: 8C 21 02    .!.
 LDA #&76 ; 'v'                                   ; BA5E: A9 76       .v
 STA L0217                                        ; BA60: 8D 17 02    ...
 LDA #&86                                         ; BA63: A9 86       ..
 STA L021B                                        ; BA65: 8D 1B 02    ...
 LDA #&7E ; '~'                                   ; BA68: A9 7E       .~
 STA L021F                                        ; BA6A: 8D 1F 02    ...
 STA L0223                                        ; BA6D: 8D 23 02    .#.
 LDA #&53 ; 'S'                                   ; BA70: A9 53       .S
 STA L0214                                        ; BA72: 8D 14 02    ...
 STA L0218                                        ; BA75: 8D 18 02    ...
 LDA #&4B ; 'K'                                   ; BA78: A9 4B       .K
 STA L021C                                        ; BA7A: 8D 1C 02    ...
 LDA #&5B ; '['                                   ; BA7D: A9 5B       .[
 STA L0220                                        ; BA7F: 8D 20 02    . .
 RTS                                              ; BA82: 60          `

.CBA83
 LDA #3                                           ; BA83: A9 03       ..
 STA L0216                                        ; BA85: 8D 16 02    ...
 LDA #&43 ; 'C'                                   ; BA88: A9 43       .C
 STA L021A                                        ; BA8A: 8D 1A 02    ...
 LDA #&83                                         ; BA8D: A9 83       ..
 STA L021E                                        ; BA8F: 8D 1E 02    ...
 LDA #&C3                                         ; BA92: A9 C3       ..
 STA L0222                                        ; BA94: 8D 22 02    .".
 LDA #&D1                                         ; BA97: A9 D1       ..
 STA L0215                                        ; BA99: 8D 15 02    ...
 STA L0219                                        ; BA9C: 8D 19 02    ...
 STA L021D                                        ; BA9F: 8D 1D 02    ...
 STA L0221                                        ; BAA2: 8D 21 02    .!.
 LDA #&76 ; 'v'                                   ; BAA5: A9 76       .v
 STA L0217                                        ; BAA7: 8D 17 02    ...
 STA L021F                                        ; BAAA: 8D 1F 02    ...
 LDA #&86                                         ; BAAD: A9 86       ..
 STA L021B                                        ; BAAF: 8D 1B 02    ...
 STA L0223                                        ; BAB2: 8D 23 02    .#.
 LDA #&4B ; 'K'                                   ; BAB5: A9 4B       .K
 STA L0214                                        ; BAB7: 8D 14 02    ...
 STA L0218                                        ; BABA: 8D 18 02    ...
 LDA #&5B ; '['                                   ; BABD: A9 5B       .[
 STA L021C                                        ; BABF: 8D 1C 02    ...
 STA L0220                                        ; BAC2: 8D 20 02    . .
 RTS                                              ; BAC5: 60          `

.CBAC6
 LDA #1                                           ; BAC6: A9 01       ..
 LDY #&CC                                         ; BAC8: A0 CC       ..
 STA L0216                                        ; BACA: 8D 16 02    ...
 STA L021A                                        ; BACD: 8D 1A 02    ...
 STA L021E                                        ; BAD0: 8D 1E 02    ...
 STA L0222                                        ; BAD3: 8D 22 02    .".
 STY L0215                                        ; BAD6: 8C 15 02    ...
 STY L0219                                        ; BAD9: 8C 19 02    ...
 INY                                              ; BADC: C8          .
 STY L021D                                        ; BADD: 8C 1D 02    ...
 STY L0221                                        ; BAE0: 8C 21 02    .!.
 LDA #&72 ; 'r'                                   ; BAE3: A9 72       .r
 STA L0217                                        ; BAE5: 8D 17 02    ...
 LDA #&8A                                         ; BAE8: A9 8A       ..
 STA L021B                                        ; BAEA: 8D 1B 02    ...
 LDA #&7E ; '~'                                   ; BAED: A9 7E       .~
 STA L021F                                        ; BAEF: 8D 1F 02    ...
 STA L0223                                        ; BAF2: 8D 23 02    .#.
 LDA #&53 ; 'S'                                   ; BAF5: A9 53       .S
 STA L0214                                        ; BAF7: 8D 14 02    ...
 STA L0218                                        ; BAFA: 8D 18 02    ...
 LDA #&47 ; 'G'                                   ; BAFD: A9 47       .G
 STA L021C                                        ; BAFF: 8D 1C 02    ...
 LDA #&5F ; '_'                                   ; BB02: A9 5F       ._
 STA L0220                                        ; BB04: 8D 20 02    . .
 RTS                                              ; BB07: 60          `

.CBB08
 LDA #2                                           ; BB08: A9 02       ..
 STA L0216                                        ; BB0A: 8D 16 02    ...
 LDA #&42 ; 'B'                                   ; BB0D: A9 42       .B
 STA L021A                                        ; BB0F: 8D 1A 02    ...
 LDA #&82                                         ; BB12: A9 82       ..
 STA L021E                                        ; BB14: 8D 1E 02    ...
 LDA #&C2                                         ; BB17: A9 C2       ..
 STA L0222                                        ; BB19: 8D 22 02    .".
 LDA #&CE                                         ; BB1C: A9 CE       ..
 STA L0215                                        ; BB1E: 8D 15 02    ...
 STA L0219                                        ; BB21: 8D 19 02    ...
 STA L021D                                        ; BB24: 8D 1D 02    ...
 STA L0221                                        ; BB27: 8D 21 02    .!.
 LDA #&7A ; 'z'                                   ; BB2A: A9 7A       .z
 STA L0217                                        ; BB2C: 8D 17 02    ...
 STA L021F                                        ; BB2F: 8D 1F 02    ...
 LDA #&82                                         ; BB32: A9 82       ..
 STA L021B                                        ; BB34: 8D 1B 02    ...
 STA L0223                                        ; BB37: 8D 23 02    .#.
 LDA #&4B ; 'K'                                   ; BB3A: A9 4B       .K
 STA L0214                                        ; BB3C: 8D 14 02    ...
 STA L0218                                        ; BB3F: 8D 18 02    ...
 LDA #&5B ; '['                                   ; BB42: A9 5B       .[
 STA L021C                                        ; BB44: 8D 1C 02    ...
 STA L0220                                        ; BB47: 8D 20 02    . .
 RTS                                              ; BB4A: 60          `

 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BB4B: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BB54: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BB5D: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BB66: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BB6F: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BB78: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BB81: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BB8A: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BB93: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BB9C: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BBA5: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BBAE: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BBB7: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BBC0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BBC9: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BBD2: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BBDB: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BBE4: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BBED: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BBF6: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BBFF: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC08: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC11: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC1A: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC23: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC2C: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC35: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC3E: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC47: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC50: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC59: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC62: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC6B: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC74: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC7D: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC86: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC8F: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BC98: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BCA1: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BCAA: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BCB3: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BCBC: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BCC5: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BCCE: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BCD7: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BCE0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BCE9: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BCF2: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BCFB: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD04: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD0D: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD16: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD1F: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD28: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD31: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD3A: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD43: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD4C: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD55: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD5E: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD67: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD70: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD79: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD82: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD8B: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD94: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BD9D: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BDA6: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BDAF: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BDB8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BDC1: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BDCA: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BDD3: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BDDC: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BDE5: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BDEE: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BDF7: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE00: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE09: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE12: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE1B: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE24: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE2D: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE36: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE3F: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE48: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE51: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE5A: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE63: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE6C: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE75: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE7E: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE87: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE90: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BE99: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BEA2: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BEAB: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BEB4: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BEBD: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BEC6: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BECF: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BED8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BEE1: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BEEA: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BEF3: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BEFC: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF05: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF0E: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF17: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF20: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF29: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF32: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF3B: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF44: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF4D: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF56: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF5F: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF68: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF71: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF7A: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF83: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF8C: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF95: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BF9E: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BFA7: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BFB0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BFB9: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BFC2: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BFCB: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BFD4: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BFDD: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BFE6: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF ; BFEF: FF FF FF... ...
 EQUB &FF, &FF,   7, &C0,   0, &C0,   7, &C0      ; BFF8: FF FF 07... ...
.pydis_end



\ ******************************************************************************
\
\ Save bank3.bin
\
\ ******************************************************************************

 PRINT "S.bank3.bin ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
 SAVE "versions/nes/3-assembled-output/bank3.bin", CODE%, P%, LOAD%
