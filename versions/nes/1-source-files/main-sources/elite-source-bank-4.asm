\ ******************************************************************************
\
\ NES ELITE GAME SOURCE (BANK 4)
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
\   * bank4.bin
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
ZP               = &0000
RAND             = &0002
RAND_1           = &0002
RAND_2           = &0003
RAND_3           = &0004
T1               = &0006
SC               = &0007
SCH              = &0008
INWK             = &0009
XX1              = &0009
INWK_1           = &000A
INWK_2           = &000B
INWK_3           = &000C
INWK_4           = &000D
INWK_5           = &000E
INWK_6           = &000F
INWK_7           = &0010
INWK_8           = &0011
INWK_9           = &0012
INWK_10          = &0013
INWK_11          = &0014
INWK_12          = &0015
INWK_13          = &0016
INWK_14          = &0017
INWK_15          = &0018
INWK_16          = &0019
INWK_17          = &001A
INWK_18          = &001B
INWK_19          = &001C
INWK_20          = &001D
INWK_21          = &001E
INWK_22          = &001F
INWK_23          = &0020
INWK_24          = &0021
INWK_25          = &0022
INWK_26          = &0023
INWK_27          = &0024
INWK_28          = &0025
INWK_29          = &0026
INWK_30          = &0027
INWK_31          = &0028
INWK_32          = &0029
INWK_33          = &002A
INWK_34          = &002B
INWK_35          = &002C
NEWB             = &002D
P                = &002F
P_1              = &0030
P_2              = &0031
XC               = &0032
YC               = &003B
QQ17             = &003C
K3               = &003D
XX2              = &003D
XX2_1            = &003E
XX2_2            = &003F
XX2_3            = &0040
XX2_4            = &0041
XX2_5            = &0042
XX2_6            = &0043
XX2_7            = &0044
XX2_8            = &0045
XX2_9            = &0046
XX2_10           = &0047
XX2_11           = &0048
XX2_12           = &0049
XX2_13           = &004A
K4               = &004B
K4_1             = &004C
XX16             = &004D
XX16_1           = &004E
XX16_2           = &004F
XX16_3           = &0050
XX16_4           = &0051
XX16_5           = &0052
XX16_6           = &0053
XX16_7           = &0054
XX16_8           = &0055
XX16_9           = &0056
XX16_10          = &0057
XX16_11          = &0058
XX16_12          = &0059
XX16_13          = &005A
XX16_14          = &005B
XX16_15          = &005C
XX16_16          = &005D
XX16_17          = &005E
XX0              = &005F
XX0_1            = &0060
INF              = &0061
XX19             = &0061
INF_1            = &0062
V                = &0063
V_1              = &0064
XX               = &0065
XX_1             = &0066
YY               = &0067
YY_1             = &0068
BETA             = &0069
BET1             = &006A
QQ22             = &006B
QQ22_1           = &006C
ECMA             = &006D
ALP1             = &006E
ALP2             = &006F
ALP2_1           = &0070
X1               = &0071
XX15             = &0071
Y1               = &0072
X2               = &0073
Y2               = &0074
XX15_4           = &0075
XX15_5           = &0076
XX12             = &0077
XX12_1           = &0078
XX12_2           = &0079
XX12_3           = &007A
XX12_4           = &007B
XX12_5           = &007C
K                = &007D
K_1              = &007E
K_2              = &007F
K_3              = &0080
QQ15             = &0082
QQ15_1           = &0083
QQ15_2           = &0084
QQ15_3           = &0085
QQ15_4           = &0086
QQ15_5           = &0087
K5               = &0088
XX18             = &0088
XX18_1           = &0089
XX18_2           = &008A
XX18_3           = &008B
K6               = &008C
K6_1             = &008D
K6_2             = &008E
K6_3             = &008F
K6_4             = &0090
BET2             = &0091
BET2_1           = &0092
DELTA            = &0093
DELT4            = &0094
DELT4_1          = &0095
U                = &0096
Q                = &0097
R                = &0098
S                = &0099
T                = &009A
XSAV             = &009B
YSAV             = &009C
XX17             = &009D
W                = &009E
QQ11             = &009F
ZZ               = &00A0
XX13             = &00A1
MCNT             = &00A2
TYPE             = &00A3
ALPHA            = &00A4
QQ12             = &00A5
TGT              = &00A6
FLAG             = &00A7
CNT              = &00A8
CNT2             = &00A9
STP              = &00AA
XX4              = &00AB
XX20             = &00AC
RAT              = &00AE
RAT2             = &00AF
widget           = &00B0
Yx1M2            = &00B1
Yx2M2            = &00B2
Yx2M1            = &00B3
messXC           = &00B4
newzp            = &00B6
NEXT_TILE        = &00B8
PATTERNS_HI      = &00B9
T5               = &00BA
T5_1             = &00BB
ADDR1_LO         = &00D4
ADDR1_HI         = &00D5
NAMES_HI         = &00E6
L00E9            = &00E9
T6               = &00EB
T6_1             = &00EC
T7               = &00ED
T7_1             = &00EE
BANK             = &00F7
XX3              = &0100
XX3_1            = &0101
SPR_00_Y         = &0200
SPR_00_TILE      = &0201
SPR_00_ATTR      = &0202
SPR_00_X         = &0203
SPR_01_Y         = &0204
SPR_01_TILE      = &0205
SPR_01_ATTR      = &0206
SPR_01_X         = &0207
SPR_02_Y         = &0208
SPR_02_TILE      = &0209
SPR_02_ATTR      = &020A
SPR_02_X         = &020B
SPR_03_Y         = &020C
SPR_03_TILE      = &020D
SPR_03_ATTR      = &020E
SPR_03_X         = &020F
SPR_04_Y         = &0210
SPR_04_TILE      = &0211
SPR_04_ATTR      = &0212
SPR_04_X         = &0213
SPR_05_Y         = &0214
SPR_05_TILE      = &0215
SPR_05_ATTR      = &0216
SPR_05_X         = &0217
SPR_06_Y         = &0218
SPR_06_TILE      = &0219
SPR_06_ATTR      = &021A
SPR_06_X         = &021B
SPR_07_Y         = &021C
SPR_07_TILE      = &021D
SPR_07_ATTR      = &021E
SPR_07_X         = &021F
SPR_08_Y         = &0220
SPR_08_TILE      = &0221
SPR_08_ATTR      = &0222
SPR_08_X         = &0223
SPR_09_Y         = &0224
SPR_09_TILE      = &0225
SPR_09_ATTR      = &0226
SPR_09_X         = &0227
SPR_10_Y         = &0228
SPR_10_TILE      = &0229
SPR_10_ATTR      = &022A
SPR_10_X         = &022B
SPR_11_Y         = &022C
SPR_11_TILE      = &022D
SPR_11_ATTR      = &022E
SPR_11_X         = &022F
SPR_12_Y         = &0230
SPR_12_TILE      = &0231
SPR_12_ATTR      = &0232
SPR_12_X         = &0233
SPR_13_Y         = &0234
SPR_13_TILE      = &0235
SPR_13_ATTR      = &0236
SPR_13_X         = &0237
SPR_14_Y         = &0238
SPR_14_TILE      = &0239
SPR_14_ATTR      = &023A
SPR_14_X         = &023B
SPR_15_Y         = &023C
SPR_15_TILE      = &023D
SPR_15_ATTR      = &023E
SPR_15_X         = &023F
SPR_16_Y         = &0240
SPR_16_TILE      = &0241
SPR_16_ATTR      = &0242
SPR_16_X         = &0243
SPR_17_Y         = &0244
SPR_17_TILE      = &0245
SPR_17_ATTR      = &0246
SPR_17_X         = &0247
SPR_18_Y         = &0248
SPR_18_TILE      = &0249
SPR_18_ATTR      = &024A
SPR_18_X         = &024B
SPR_19_Y         = &024C
SPR_19_TILE      = &024D
SPR_19_ATTR      = &024E
SPR_19_X         = &024F
SPR_20_Y         = &0250
SPR_20_TILE      = &0251
SPR_20_ATTR      = &0252
SPR_20_X         = &0253
SPR_21_Y         = &0254
SPR_21_TILE      = &0255
SPR_21_ATTR      = &0256
SPR_21_X         = &0257
SPR_22_Y         = &0258
SPR_22_TILE      = &0259
SPR_22_ATTR      = &025A
SPR_22_X         = &025B
SPR_23_Y         = &025C
SPR_23_TILE      = &025D
SPR_23_ATTR      = &025E
SPR_23_X         = &025F
SPR_24_Y         = &0260
SPR_24_TILE      = &0261
SPR_24_ATTR      = &0262
SPR_24_X         = &0263
SPR_25_Y         = &0264
SPR_25_TILE      = &0265
SPR_25_ATTR      = &0266
SPR_25_X         = &0267
SPR_26_Y         = &0268
SPR_26_TILE      = &0269
SPR_26_ATTR      = &026A
SPR_26_X         = &026B
SPR_27_Y         = &026C
SPR_27_TILE      = &026D
SPR_27_ATTR      = &026E
SPR_27_X         = &026F
SPR_28_Y         = &0270
SPR_28_TILE      = &0271
SPR_28_ATTR      = &0272
SPR_28_X         = &0273
SPR_29_Y         = &0274
SPR_29_TILE      = &0275
SPR_29_ATTR      = &0276
SPR_29_X         = &0277
SPR_30_Y         = &0278
SPR_30_TILE      = &0279
SPR_30_ATTR      = &027A
SPR_30_X         = &027B
SPR_31_Y         = &027C
SPR_31_TILE      = &027D
SPR_31_ATTR      = &027E
SPR_31_X         = &027F
SPR_32_Y         = &0280
SPR_32_TILE      = &0281
SPR_32_ATTR      = &0282
SPR_32_X         = &0283
SPR_33_Y         = &0284
SPR_33_TILE      = &0285
SPR_33_ATTR      = &0286
SPR_33_X         = &0287
SPR_34_Y         = &0288
SPR_34_TILE      = &0289
SPR_34_ATTR      = &028A
SPR_34_X         = &028B
SPR_35_Y         = &028C
SPR_35_TILE      = &028D
SPR_35_ATTR      = &028E
SPR_35_X         = &028F
SPR_36_Y         = &0290
SPR_36_TILE      = &0291
SPR_36_ATTR      = &0292
SPR_36_X         = &0293
SPR_37_Y         = &0294
SPR_37_TILE      = &0295
SPR_37_ATTR      = &0296
SPR_37_X         = &0297
SPR_38_Y         = &0298
SPR_38_TILE      = &0299
SPR_38_ATTR      = &029A
SPR_38_X         = &029B
SPR_39_Y         = &029C
SPR_39_TILE      = &029D
SPR_39_ATTR      = &029E
SPR_39_X         = &029F
SPR_40_Y         = &02A0
SPR_40_TILE      = &02A1
SPR_40_ATTR      = &02A2
SPR_40_X         = &02A3
SPR_41_Y         = &02A4
SPR_41_TILE      = &02A5
SPR_41_ATTR      = &02A6
SPR_41_X         = &02A7
SPR_42_Y         = &02A8
SPR_42_TILE      = &02A9
SPR_42_ATTR      = &02AA
SPR_42_X         = &02AB
SPR_43_Y         = &02AC
SPR_43_TILE      = &02AD
SPR_43_ATTR      = &02AE
SPR_43_X         = &02AF
SPR_44_Y         = &02B0
SPR_44_TILE      = &02B1
SPR_44_ATTR      = &02B2
SPR_44_X         = &02B3
SPR_45_Y         = &02B4
SPR_45_TILE      = &02B5
SPR_45_ATTR      = &02B6
SPR_45_X         = &02B7
SPR_46_Y         = &02B8
SPR_46_TILE      = &02B9
SPR_46_ATTR      = &02BA
SPR_46_X         = &02BB
SPR_47_Y         = &02BC
SPR_47_TILE      = &02BD
SPR_47_ATTR      = &02BE
SPR_47_X         = &02BF
SPR_48_Y         = &02C0
SPR_48_TILE      = &02C1
SPR_48_ATTR      = &02C2
SPR_48_X         = &02C3
SPR_49_Y         = &02C4
SPR_49_TILE      = &02C5
SPR_49_ATTR      = &02C6
SPR_49_X         = &02C7
SPR_50_Y         = &02C8
SPR_50_TILE      = &02C9
SPR_50_ATTR      = &02CA
SPR_50_X         = &02CB
SPR_51_Y         = &02CC
SPR_51_TILE      = &02CD
SPR_51_ATTR      = &02CE
SPR_51_X         = &02CF
SPR_52_Y         = &02D0
SPR_52_TILE      = &02D1
SPR_52_ATTR      = &02D2
SPR_52_X         = &02D3
SPR_53_Y         = &02D4
SPR_53_TILE      = &02D5
SPR_53_ATTR      = &02D6
SPR_53_X         = &02D7
SPR_54_Y         = &02D8
SPR_54_TILE      = &02D9
SPR_54_ATTR      = &02DA
SPR_54_X         = &02DB
SPR_55_Y         = &02DC
SPR_55_TILE      = &02DD
SPR_55_ATTR      = &02DE
SPR_55_X         = &02DF
SPR_56_Y         = &02E0
SPR_56_TILE      = &02E1
SPR_56_ATTR      = &02E2
SPR_56_X         = &02E3
SPR_57_Y         = &02E4
SPR_57_TILE      = &02E5
SPR_57_ATTR      = &02E6
SPR_57_X         = &02E7
SPR_58_Y         = &02E8
SPR_58_TILE      = &02E9
SPR_58_ATTR      = &02EA
SPR_58_X         = &02EB
SPR_59_Y         = &02EC
SPR_59_TILE      = &02ED
SPR_59_ATTR      = &02EE
SPR_59_X         = &02EF
SPR_60_Y         = &02F0
SPR_60_TILE      = &02F1
SPR_60_ATTR      = &02F2
SPR_60_X         = &02F3
SPR_61_Y         = &02F4
SPR_61_TILE      = &02F5
SPR_61_ATTR      = &02F6
SPR_61_X         = &02F7
SPR_62_Y         = &02F8
SPR_62_TILE      = &02F9
SPR_62_ATTR      = &02FA
SPR_62_X         = &02FB
SPR_63_Y         = &02FC
SPR_63_TILE      = &02FD
SPR_63_ATTR      = &02FE
SPR_63_X         = &02FF
FRIN             = &036A
MJ               = &038A
VIEW             = &038E
EV               = &0392
TP               = &039E
QQ0              = &039F
QQ1              = &03A0
CASH             = &03A1
QQ14             = &03A5
GCNT             = &03A7
CRGO             = &03AC
QQ20             = &03AD
BST              = &03BF
BOMB             = &03C0
GHYP             = &03C3
ESCP             = &03C6
NOMSL            = &03C8
FIST             = &03C9
AVL              = &03CA
QQ26             = &03DB
TALLY            = &03DC
TALLY_1          = &03DD
QQ21             = &03DF
NOSTM            = &03E5
DTW6             = &03F3
DTW2             = &03F4
DTW3             = &03F5
DTW4             = &03F6
DTW5             = &03F7
DTW1             = &03F8
DTW8             = &03F9
XP               = &03FA
YP               = &03FB
MSTG             = &0401
QQ19             = &044D
QQ19_1           = &044E
QQ19_3           = &0450
QQ19_4           = &0450
K2               = &0459
K2_1             = &045A
K2_2             = &045B
K2_3             = &045C
QQ19_2           = &045F
L046C            = &046C
BOXEDGE1         = &046E
BOXEDGE2         = &046F
CONT2_SCAN       = &0475
SWAP             = &047F
XSAV2            = &0481
YSAV2            = &0482
QQ24             = &0487
QQ25             = &0488
QQ28             = &0489
QQ29             = &048A
L048B            = &048B
gov              = &048C
tek              = &048D
QQ2              = &048E
QQ3              = &0494
QQ4              = &0495
QQ5              = &0496
QQ8              = &049B
QQ8_1            = &049C
QQ9              = &049D
QQ10             = &049E
QQ18_LO          = &04A4
QQ18_HI          = &04A5
TKN1_LO          = &04A6
TKN1_HI          = &04A7
LANG             = &04A8
CONT1_DOWN       = &04AA
CONT2_DOWN       = &04AB
CONT1_UP         = &04AC
CONT2_UP         = &04AD
CONT1_LEFT       = &04AE
CONT2_LEFT       = &04AF
CONT1_RIGHT      = &04B0
CONT2_RIGHT      = &04B1
CONT1_A          = &04B2
CONT2_A          = &04B3
CONT1_B          = &04B4
CONT2_B          = &04B5
CONT1_START      = &04B6
CONT2_START      = &04B7
CONT1_SELECT     = &04B8
CONT2_SELECT     = &04B9
SX               = &04C8
SY               = &04DD
SZ               = &04F2
BUFm1            = &0506
BUF              = &0507
BUF_1            = &0508
HANGFLAG         = &0561
MANY             = &0562
SSPR             = &0564
SXL              = &05A5
SYL              = &05BA
SZL              = &05CF
safehouse        = &05E4
Kpercent         = &0600
PPU_CTRL         = &2000
PPU_MASK         = &2001
PPU_STATUS       = &2002
OAM_ADDR         = &2003
OAM_DATA         = &2004
PPU_SCROLL       = &2005
PPU_ADDR         = &2006
PPU_DATA         = &2007
SQ1_ENV          = &4000
SQ1_SWEEP        = &4001
SQ1_LO           = &4002
SQ1_HI           = &4003
SQ2_ENV          = &4004
SQ2_SWEEP        = &4005
SQ2_LO           = &4006
SQ2_HI           = &4007
TRI_CTRL         = &4008
TRI_LO           = &400A
TRI_HI           = &400B
NOI_ENV          = &400C
NOI_RAND         = &400E
NOI_LEN          = &400F
OAM_DMA          = &4014
APU_FLAGS        = &4015
CONTROLLER_1     = &4016
CONTROLLER_2     = &4017
PATTERNS_0       = &6000
PATTERNS_1       = &6800
NAMES_0          = &7000
NAMES_1          = &7400
LC006            = &C006
Spercent         = &C007
RESETBANK        = &C0AD
SETBANK          = &C0AE
LC0DF            = &C0DF
log              = &C100
logL             = &C200
antilog          = &C300
antilogODD       = &C400
SNE              = &C500
ACT              = &C520
XX21m2           = &C53E
XX21m1           = &C53F
XX21             = &C540
SENDTOPPU1       = &CC2E
COPYNAMES        = &CD34
BOXEDGES         = &CD6F
UNIV             = &CE7E
UNIV_1           = &CE7F
GINF             = &CE90
sub_CE9E         = &CE9E
sub_CEA5         = &CEA5
NAMES_LOOKUP     = &CED0
PATTERNS_LOOKUP  = &CED2
IRQ              = &CED4
NMI              = &CED5
SETPALETTE       = &CF2E
RESETNAMES1      = &D02D
NAMETABLE0       = &D06D
CONTROLLERS      = &D0F8
FILLMEMORY       = &D710
SENDTOPPU2       = &D986
TWOS             = &D9F7
TWOS2            = &DA01
TWFL             = &DA09
TWFR             = &DA10
ylookupLO        = &DA18
ylookupHI        = &DAF8
LDBD8            = &DBD8
LOIN             = &DC0F
PIXEL            = &E4F0
PIXELx2          = &E543
ECBLB2           = &E596
DELAY            = &EBA2
EXNO3            = &EBAD
BOOP             = &EBE5
NOISE            = &EBF2
SET_NAMETABLE_0_A = &EC7D
LDA_XX0_Y        = &EC8D
LDA_EPC_Y        = &ECA0
INC_TALLY        = &ECAE
CB1D4_BANK0      = &ECE2
SETK_K3_XC_YC    = &ECF9
C811E_BANK6      = &ED16
C8021_BANK6      = &ED24
C89D1_BANK6      = &ED50
C8012_BANK6      = &ED6B
CBF41_BANK5      = &ED81
CB9F9_BANK4      = &ED8F
CB96B_BANK4      = &ED9D
CB63D_BANK3      = &EDAB
CB88C_BANK6      = &EDB9
CA070_BANK1      = &EDC7
CBA23_BANK3      = &EDDC
TIDY_BANK1       = &EDEA
CBC83_BANK6      = &EDFF
C9522_BANK0      = &EE0D
CB1BE_BANK1      = &EE15
CAC25_BANK1      = &EE3F
CB2FB_BANK3      = &EE54
CB219_BANK3      = &EE62
CB9C1_BANK4      = &EE78
CA082_BANK6      = &EE8B
CA0F8_BANK6      = &EE99
CB882_BANK4      = &EEA7
CA4A5_BANK6      = &EEB5
CB2EF_BANK0      = &EEC3
CB9E2_BANK3      = &EED3
CB673_BANK3      = &EEE8
CB2BC_BANK3      = &EEF6
CB248_BANK3      = &EF04
CBA17_BANK6      = &EF12
CAFCD_BANK3      = &EF20
CBE52_BANK6      = &EF35
CBED2_BANK6      = &EF43
CB0E1_BANK3      = &EF51
CB18E_BANK3      = &EF6C
PAS1_BANK0       = &EF7A
CBED7_BANK5      = &EF88
CBEEA_BANK5      = &EF96
CB93C_BANK4      = &EFA4
CB8F9_BANK4      = &EFB2
CA2C3_BANK6      = &EFC0
CBA63_BANK6      = &EFCE
CB39D_BANK0      = &EFDC
LL164_BANK6      = &EFF7
CB919_BANK6      = &F005
CA166_BANK6      = &F013
CBBDE_BANK6      = &F021
CBB37_BANK6      = &F02F
CB8FE_BANK6      = &F03D
CB90D_BANK6      = &F04B
CA5AB_BANK6      = &F059
CEBA9_BANK0      = &F06F
DETOK_BANK2      = &F082
DTS_BANK2        = &F09D
CB3E8_BANK2      = &F0B8
CAE18_BANK3      = &F0C6
CAC1D_BANK3      = &F0E1
CA730_BANK3      = &F0FC
CA775_BANK3      = &F10A
CAABC_BANK3      = &F118
CA7B7_BANK3      = &F126
CA9D1_BANK3      = &F139
CA972_BANK3      = &F15C
CAC5C_BANK3      = &F171
CF186_BANK6      = &F186
CB459_BANK6      = &F194
MVS5_BANK0       = &F1A2
HALL_BANK1       = &F1BD
CB635_BANK2      = &F1CB
DASC_BANK2       = &F1E6
TT27_BANK2       = &F201
CB4AA_BANK2      = &F21C
TT27_BANK0       = &F237
CA379_BANK0      = &F245
CBAF3_BANK1      = &F25A
TT66_BANK0       = &F26E
CA65D_BANK1      = &F280
CB341_BANK3      = &F293
SCAN_BANK1       = &F2A8
C8926_BANK0      = &F2BD
CCD34_BANK0      = &F2CE
CLYNS            = &F2DE
LF333            = &F333
sub_CF338        = &F338
sub_CF359        = &F359
sub_CF3BC        = &F3BC
sub_CF42A        = &F42A
Ze               = &F42E
sub_CF454        = &F454
sub_CF46A        = &F46A
NLIN4            = &F473
DORND2           = &F4AC
DORND            = &F4AD
PROJ             = &F4C1
LF52D            = &F52D
LF5AF            = &F5AF
MU5              = &F65A
MULT3            = &F664
MLS2             = &F6BA
MLS1             = &F6C2
MULTSm2          = &F6C4
MULTS            = &F6C6
MU6              = &F707
SQUA             = &F70C
SQUA2            = &F70E
MU1              = &F713
MLU1             = &F718
MLU2             = &F71D
MULTU            = &F721
MU11             = &F725
FMLTU2           = &F766
FMLTU            = &F770
MLTU2m2          = &F7AB
MLTU2            = &F7AD
MUT2             = &F7D2
MUT1             = &F7D6
MULT1            = &F7DA
MULT12           = &F83C
TAS3             = &F853
MAD              = &F86F
ADD              = &F872
TIS1             = &F8AE
DV42             = &F8D1
DV41             = &F8D4
DVID3B2          = &F962
LL5              = &FA55
LL28             = &FA91
NORM             = &FAF8

 ORG &8000

.pydis_start
 SEI                                          ; 8000: 78          x
 INC LC006                                    ; 8001: EE 06 C0    ...
 JMP Spercent                                 ; 8004: 4C 07 C0    L..

 EQUS "@ 5.0"                                 ; 8007: 40 20 35... @ 5
.L800C
L800E = L800C+2
L800F = L800C+3
L951C = L800C+5392
L951D = L800C+5393
 EQUB &0E, &00, &1E, &00, &95, &01, &05, &03  ; 800C: 0E 00 1E... ...
 EQUB &73, &04, &F9, &05, &83, &07, &04, &09  ; 8014: 73 04 F9... s..
 EQUB &87, &0A, &09, &0C, &7C, &0D, &FC, &0E  ; 801C: 87 0A 09... ...
 EQUB &8E, &10, &05, &12, &87, &13, &0F, &05  ; 8024: 8E 10 05... ...
 EQUB &32, &03, &19, &47, &BC, &05, &32, &07  ; 802C: 32 03 19... 2..
 EQUB &38, &43, &04, &21, &2D, &5F, &83, &57  ; 8034: 38 43 04... 8C.
 EQUB &04, &FE, &FF, &7F, &FF, &04, &80, &B0  ; 803C: 04 FE FF... ...
 EQUB &DC, &EA, &05, &C0, &E0, &F4, &0F, &01  ; 8044: DC EA 05... ...
 EQUB &33, &01, &02, &03, &04, &21, &04, &00  ; 804C: 33 01 02... 3..
 EQUB &21, &01, &06, &F7, &DF, &FE, &6B, &FF  ; 8054: 21 01 06... !..
 EQUB &21, &1B, &56, &39, &0D, &08, &20, &01  ; 805C: 21 1B 56... !.V
 EQUB &14, &00, &04, &20, &02, &F1, &C5, &78  ; 8064: 14 00 04... ...
 EQUB &F6, &CE, &7E, &F3, &DE, &37, &0F, &3F  ; 806C: F6 CE 7E... ..~
 EQUB &87, &09, &31, &83, &0C, &20, &6D, &EB  ; 8074: 87 09 31... ..1
 EQUB &58, &A5, &54, &AB, &54, &BE, &22, &F6  ; 807C: 58 A5 54... X.T
 EQUB &E7, &C3, &89, &32, &1C, &36, &7E, &00  ; 8084: E7 C3 89... ...
 EQUB &23, &80, &24, &C0, &09, &39, &01, &04  ; 808C: 23 80 24... #.$
 EQUB &05, &03, &09, &0D, &17, &04, &04, &23  ; 8094: 05 03 09... ...
 EQUB &01, &33, &03, &1B, &0B, &7F, &80, &C7  ; 809C: 01 33 03... .3.
 EQUB &E9, &D4, &F0, &C2, &B6, &02, &E0, &D1  ; 80A4: E9 D4 F0... ...
 EQUB &B8, &22, &FC, &D8, &FA, &32, &23, &3D  ; 80AC: B8 22 FC... .".
 EQUB &FF, &10, &44, &54, &44, &32, &01, &1F  ; 80B4: FF 10 44... ..D
 EQUB &FD, &FF, &FE, &33, &28, &38, &28, &DF  ; 80BC: FD FF FE... ...
 EQUB &FE, &87, &21, &2F, &57, &21, &1F, &87  ; 80C4: FE 87 21... ..!
 EQUB &DB, &DE, &FF, &CF, &32, &17, &3B, &22  ; 80CC: DB DE FF... ...
 EQUB &7F, &21, &37, &24, &40, &80, &20, &60  ; 80D4: 7F 21 37... .!7
 EQUB &D0, &05, &80, &B0, &A0, &36, &0F, &17  ; 80DC: D0 05 80... ...
 EQUB &01, &0A, &01, &05, &02, &34, &13, &03  ; 80E4: 01 0A 01... ...
 EQUB &03, &01, &04, &21, &02, &80, &7D, &D3  ; 80EC: 03 01 04... ...
 EQUB &FE, &55, &62, &B5, &C2, &C0, &FE, &FC  ; 80F4: FE 55 62... .Ub
 EQUB &FF, &D7, &E3, &76, &92, &AA, &AB, &BB  ; 80FC: FF D7 E3... ...
 EQUB &BA, &21, &29, &10, &21, &29, &7C, &22  ; 8104: BA 21 29... .!)
 EQUB &6C, &7C, &7D, &EF, &D7, &EE, &81, &21  ; 810C: 6C 7C 7D... l|}
 EQUB &03, &7D, &96, &FF, &55, &8C, &5A, &87  ; 8114: 03 7D 96... .}.
 EQUB &21, &07, &FF, &7F, &FE, &D6, &8E, &DC  ; 811C: 21 07 FF... !..
 EQUB &E0, &50, &00, &A0, &00, &40, &02, &90  ; 8124: E0 50 00... .P.
 EQUB &22, &80, &0F, &06, &AA, &54, &E1, &B5  ; 812C: 22 80 0F... "..
 EQUB &FA, &B5, &37, &1F, &17, &7F, &3E, &1E  ; 8134: FA B5 37... ..7
 EQUB &0E, &0F, &23, &4F, &82, &C6, &BB, &45  ; 813C: 0E 0F 23... ..#
 EQUB &C6, &21, &39, &83, &FF, &C7, &C6, &7C  ; 8144: C6 21 39... .!9
 EQUB &32, &38, &01, &C7, &12, &AA, &54, &21  ; 814C: 32 38 01... 28.
 EQUB &0E, &5A, &BE, &5A, &F0, &D0, &FC, &F8  ; 8154: 0E 5A BE... .Z.
 EQUB &F0, &22, &E0, &23, &E4, &0F, &04, &21  ; 815C: F0 22 E0... .".
 EQUB &01, &0C, &7F, &21, &07, &AF, &38, &13  ; 8164: 01 0C 7F... ...
 EQUB &16, &09, &02, &00, &0F, &2F, &07, &87  ; 816C: 16 09 02... ...
 EQUB &C2, &43, &21, &21, &00, &83, &22, &AB  ; 8174: C2 43 21... .C!
 EQUB &EF, &FE, &45, &EE, &BA, &FF, &AB, &C7  ; 817C: EF FE 45... ..E
 EQUB &FF, &FE, &45, &EF, &7C, &FC, &C0, &EA  ; 8184: FF FE 45... ..E
 EQUB &91, &D0, &20, &80, &00, &E0, &E8, &C0  ; 818C: 91 D0 20... ..
 EQUB &C2, &86, &84, &21, &08, &0F, &0F, &0F  ; 8194: C2 86 84... ...
 EQUB &0F, &0F, &0F, &07, &3F, &0F, &05, &32  ; 819C: 0F 0F 0F... ...
 EQUB &03, &19, &47, &BC, &05, &32, &07, &38  ; 81A4: 03 19 47... ..G
 EQUB &43, &04, &21, &2D, &5F, &83, &57, &04  ; 81AC: 43 04 21... C.!
 EQUB &FE, &FF, &7F, &FF, &04, &80, &B0, &DC  ; 81B4: FE FF 7F... ...
 EQUB &EA, &05, &C0, &E0, &F4, &0F, &01, &33  ; 81BC: EA 05 C0... ...
 EQUB &01, &02, &03, &04, &21, &04, &00, &21  ; 81C4: 01 02 03... ...
 EQUB &01, &06, &F7, &DF, &FE, &6B, &FF, &21  ; 81CC: 01 06 F7... ...
 EQUB &1B, &56, &39, &0D, &08, &20, &01, &14  ; 81D4: 1B 56 39... .V9
 EQUB &00, &04, &20, &02, &F1, &C5, &78, &F6  ; 81DC: 00 04 20... ..
 EQUB &CE, &7E, &F3, &DE, &37, &0F, &3F, &87  ; 81E4: CE 7E F3... .~.
 EQUB &09, &31, &83, &0C, &20, &6D, &EB, &58  ; 81EC: 09 31 83... .1.
 EQUB &A5, &54, &AB, &54, &BE, &22, &F6, &E7  ; 81F4: A5 54 AB... .T.
 EQUB &C3, &89, &32, &1C, &36, &7E, &00, &23  ; 81FC: C3 89 32... ..2
 EQUB &80, &24, &C0, &09, &39, &01, &04, &05  ; 8204: 80 24 C0... .$.
 EQUB &03, &09, &0D, &17, &04, &04, &23, &01  ; 820C: 03 09 0D... ...
 EQUB &33, &03, &1B, &0B, &7F, &80, &AF, &D5  ; 8214: 33 03 1B... 3..
 EQUB &F8, &FA, &C2, &B6, &02, &D0, &B9, &23  ; 821C: F8 FA C2... ...
 EQUB &FC, &D4, &FA, &32, &23, &3D, &FF, &10  ; 8224: FC D4 FA... ...
 EQUB &44, &54, &44, &32, &01, &1F, &FD, &FF  ; 822C: 44 54 44... DTD
 EQUB &FE, &33, &28, &38, &28, &DF, &86, &AF  ; 8234: FE 33 28... .3(
 EQUB &57, &21, &3F, &BF, &87, &DB, &DE, &CF  ; 823C: 57 21 3F... W!?
 EQUB &97, &21, &3B, &23, &7F, &57, &24, &40  ; 8244: 97 21 3B... .!;
 EQUB &80, &20, &60, &D0, &05, &80, &B0, &A0  ; 824C: 80 20 60... . `
 EQUB &36, &0F, &15, &01, &0A, &01, &05, &02  ; 8254: 36 0F 15... 6..
 EQUB &34, &13, &03, &03, &01, &05, &80, &7D  ; 825C: 34 13 03... 4..
 EQUB &D3, &FE, &55, &62, &B5, &22, &C0, &FE  ; 8264: D3 FE 55... ..U
 EQUB &FC, &FF, &D7, &E3, &76, &92, &AA, &AB  ; 826C: FC FF D7... ...
 EQUB &BB, &BA, &21, &29, &10, &21, &29, &7C  ; 8274: BB BA 21... ..!
 EQUB &22, &6C, &7C, &7D, &EF, &D7, &EE, &32  ; 827C: 22 6C 7C... "l|
 EQUB &01, &03, &7D, &96, &FF, &55, &8C, &5A  ; 8284: 01 03 7D... ..}
 EQUB &22, &07, &FF, &7F, &FE, &D6, &8E, &DC  ; 828C: 22 07 FF... "..
 EQUB &E0, &50, &00, &A0, &00, &40, &02, &90  ; 8294: E0 50 00... .P.
 EQUB &22, &80, &0F, &06, &AA, &54, &E1, &B5  ; 829C: 22 80 0F... "..
 EQUB &FA, &B5, &37, &1F, &17, &7F, &3E, &1E  ; 82A4: FA B5 37... ..7
 EQUB &0E, &0F, &23, &4F, &82, &C6, &BB, &45  ; 82AC: 0E 0F 23... ..#
 EQUB &C6, &21, &39, &83, &FF, &C7, &C6, &7C  ; 82B4: C6 21 39... .!9
 EQUB &32, &38, &01, &C7, &12, &AA, &54, &21  ; 82BC: 32 38 01... 28.
 EQUB &0E, &5A, &BE, &5A, &F0, &D0, &FC, &F8  ; 82C4: 0E 5A BE... .Z.
 EQUB &F0, &22, &E0, &23, &E4, &0F, &04, &21  ; 82CC: F0 22 E0... .".
 EQUB &01, &0C, &7C, &21, &07, &AF, &38, &13  ; 82D4: 01 0C 7C... ..|
 EQUB &16, &09, &02, &00, &0E, &2D, &07, &87  ; 82DC: 16 09 02... ...
 EQUB &C2, &43, &21, &21, &00, &82, &22, &45  ; 82E4: C2 43 21... .C!
 EQUB &C7, &FE, &45, &EE, &BA, &7C, &45, &83  ; 82EC: C7 FE 45... ..E
 EQUB &FF, &FE, &45, &EF, &22, &7C, &C0, &EA  ; 82F4: FF FE 45... ..E
 EQUB &91, &D0, &20, &80, &00, &E0, &68, &C0  ; 82FC: 91 D0 20... ..
 EQUB &C2, &86, &84, &21, &08, &0F, &0F, &0F  ; 8304: C2 86 84... ...
 EQUB &0F, &0F, &0F, &07, &3F, &0F, &05, &32  ; 830C: 0F 0F 0F... ...
 EQUB &03, &19, &47, &BC, &05, &32, &07, &38  ; 8314: 03 19 47... ..G
 EQUB &43, &04, &21, &2D, &5F, &83, &57, &04  ; 831C: 43 04 21... C.!
 EQUB &FE, &FF, &7F, &FF, &04, &80, &B0, &DC  ; 8324: FE FF 7F... ...
 EQUB &EA, &05, &C0, &E0, &F4, &0F, &01, &33  ; 832C: EA 05 C0... ...
 EQUB &01, &02, &03, &04, &21, &04, &00, &21  ; 8334: 01 02 03... ...
 EQUB &01, &06, &F7, &DF, &FE, &6B, &FF, &21  ; 833C: 01 06 F7... ...
 EQUB &1B, &56, &39, &0D, &08, &20, &01, &14  ; 8344: 1B 56 39... .V9
 EQUB &00, &04, &20, &02, &F1, &C5, &78, &F6  ; 834C: 00 04 20... ..
 EQUB &CE, &7E, &F3, &DE, &37, &0F, &3F, &87  ; 8354: CE 7E F3... .~.
 EQUB &09, &31, &83, &0C, &20, &6D, &EB, &58  ; 835C: 09 31 83... .1.
 EQUB &A5, &54, &AB, &54, &BE, &22, &F6, &E7  ; 8364: A5 54 AB... .T.
 EQUB &C3, &89, &32, &1C, &36, &7E, &00, &23  ; 836C: C3 89 32... ..2
 EQUB &80, &24, &C0, &09, &39, &01, &04, &05  ; 8374: 80 24 C0... .$.
 EQUB &03, &09, &0D, &17, &04, &04, &23, &01  ; 837C: 03 09 0D... ...
 EQUB &33, &03, &1B, &0B, &7F, &80, &C7, &F4  ; 8384: 33 03 1B... 3..
 EQUB &FF, &4C, &D0, &7E, &02, &F8, &F4, &FF  ; 838C: FF 4C D0... .L.
 EQUB &83, &E0, &80, &FA, &20, &21, &07, &BA  ; 8394: 83 E0 80... ...
 EQUB &BB, &C6, &22, &6C, &32, &01, &1F, &FB  ; 839C: BB C6 22... .."
 EQUB &C6, &D7, &32, &29, &28, &10, &FF, &FE  ; 83A4: C6 D7 32... ..2
 EQUB &FF, &5F, &FF, &65, &21, &17, &FD, &FE  ; 83AC: FF 5F FF... ._.
 EQUB &12, &5F, &FF, &83, &32, &0F, &03, &24  ; 83B4: 12 5F FF... ._.
 EQUB &40, &80, &20, &60, &D0, &05, &80, &B0  ; 83BC: 40 80 20... @.
 EQUB &A0, &36, &0F, &15, &01, &0A, &01, &05  ; 83C4: A0 36 0F... .6.
 EQUB &02, &34, &13, &03, &03, &01, &04, &F7  ; 83CC: 02 34 13... .4.
 EQUB &9D, &FC, &59, &55, &62, &B5, &AA, &F8  ; 83D4: 9D FC 59... ..Y
 EQUB &E2, &22, &FE, &D7, &E3, &76, &7F, &21  ; 83DC: E2 22 FE... .".
 EQUB &11, &AB, &BA, &BB, &21, &29, &10, &21  ; 83E4: 11 AB BA... ...
 EQUB &29, &82, &7C, &6C, &22, &7C, &EF, &D7  ; 83EC: 29 82 7C... ).|
 EQUB &EE, &C7, &DF, &73, &7F, &21, &34, &55  ; 83F4: EE C7 DF... ...
 EQUB &8D, &5A, &AA, &21, &3F, &8F, &12, &D6  ; 83FC: 8D 5A AA... .Z.
 EQUB &8E, &DC, &FC, &E0, &50, &00, &A0, &00  ; 8404: 8E DC FC... ...
 EQUB &40, &02, &90, &22, &80, &0F, &06, &54  ; 840C: 40 02 90... @..
 EQUB &E1, &B5, &FA, &B5, &22, &1F, &35, &17  ; 8414: E1 B5 FA... ...
 EQUB &3E, &1E, &0E, &0F, &24, &4F, &C6, &BB  ; 841C: 3E 1E 0E... >..
 EQUB &45, &C6, &21, &39, &C7, &12, &C6, &7C  ; 8424: 45 C6 21... E.!
 EQUB &32, &38, &01, &C7, &13, &54, &21, &0E  ; 842C: 32 38 01... 28.
 EQUB &5A, &BE, &5A, &22, &F0, &D0, &F8, &F0  ; 8434: 5A BE 5A... Z.Z
 EQUB &22, &E0, &24, &E4, &0F, &04, &21, &01  ; 843C: 22 E0 24... ".$
 EQUB &0C, &7C, &84, &AF, &38, &13, &16, &09  ; 8444: 0C 7C 84... .|.
 EQUB &02, &00, &0E, &2C, &07, &87, &C2, &43  ; 844C: 02 00 0E... ...
 EQUB &21, &21, &00, &82, &C6, &22, &BB, &FE  ; 8454: 21 21 00... !!.
 EQUB &45, &EE, &BA, &7C, &C6, &C7, &FF, &FE  ; 845C: 45 EE BA... E..
 EQUB &45, &EF, &22, &7C, &42, &EA, &91, &D0  ; 8464: 45 EF 22... E."
 EQUB &20, &80, &00, &E0, &68, &C0, &C2, &86  ; 846C: 20 80 00...  ..
 EQUB &84, &21, &08, &0F, &0F, &0F, &0F, &0F  ; 8474: 84 21 08... .!.
 EQUB &0F, &07, &3F, &0F, &21, &01, &04, &33  ; 847C: 0F 07 3F... ..?
 EQUB &08, &02, &01, &B9, &04, &33, &1C, &06  ; 8484: 08 02 01... ...
 EQUB &33, &C9, &04, &21, &1A, &60, &32, &04  ; 848C: 33 C9 04... 3..
 EQUB &25, &03, &89, &42, &46, &64, &AC, &05  ; 8494: 25 03 89... %..
 EQUB &58, &40, &C6, &05, &21, &3C, &E0, &8E  ; 849C: 58 40 C6... X@.
 EQUB &0F, &02, &32, &03, &02, &02, &32, &04  ; 84A4: 0F 02 32... ..2
 EQUB &02, &03, &34, &03, &02, &00, &02, &02  ; 84AC: 02 03 34... ..4
 EQUB &44, &21, &22, &86, &55, &40, &B1, &6A  ; 84B4: 44 21 22... D!"
 EQUB &FD, &6C, &21, &24, &30, &00, &21, &1F  ; 84BC: FD 6C 21... .l!
 EQUB &71, &EA, &FD, &FF, &21, &18, &A4, &4D  ; 84C4: 71 EA FD... q..
 EQUB &30, &AB, &FE, &55, &22, &AD, &21, &08  ; 84CC: 30 AB FE... 0..
 EQUB &00, &83, &D7, &FE, &55, &10, &90, &21  ; 84D4: 00 83 D7... ...
 EQUB &25, &52, &32, &04, &19, &AC, &7E, &99  ; 84DC: 25 52 32... %R2
 EQUB &20, &21, &03, &00, &F9, &21, &1C, &AE  ; 84E4: 20 21 03...  !.
 EQUB &7E, &04, &80, &00, &40, &80, &02, &80  ; 84EC: 7E 04 80... ~..
 EQUB &00, &80, &02, &40, &39, &05, &04, &01  ; 84F4: 00 80 02... ...
 EQUB &05, &03, &09, &0D, &17, &00, &24, &01  ; 84FC: 05 03 09... ...
 EQUB &33, &03, &1B, &0B, &F5, &FF, &E2, &A7  ; 8504: 33 03 1B... 3..
 EQUB &49, &E4, &C4, &AE, &F7, &FF, &FE, &C1  ; 850C: 49 E4 C4... I..
 EQUB &B0, &22, &F8, &D0, &BB, &45, &C6, &FF  ; 8514: B0 22 F8... .".
 EQUB &21, &11, &C6, &54, &44, &BB, &FF, &C6  ; 851C: 21 11 C6... !..
 EQUB &FF, &FE, &33, &28, &38, &28, &5F, &FE  ; 8524: FF FE 33... ..3
 EQUB &8F, &CB, &21, &25, &4F, &47, &EB, &DE  ; 852C: 8F CB 21... ..!
 EQUB &12, &35, &07, &1B, &3F, &3F, &17, &00  ; 8534: 12 35 07... .5.
 EQUB &22, &40, &00, &80, &20, &60, &D0, &05  ; 853C: 22 40 00... "@.
 EQUB &80, &B0, &A0, &36, &0F, &15, &01, &0A  ; 8544: 80 B0 A0... ...
 EQUB &01, &05, &02, &34, &13, &03, &03, &01  ; 854C: 01 05 02... ...
 EQUB &04, &10, &80, &7D, &D3, &FE, &55, &62  ; 8554: 04 10 80... ...
 EQUB &B5, &D2, &C0, &FE, &FC, &FF, &D7, &E3  ; 855C: B5 D2 C0... ...
 EQUB &76, &92, &AA, &AB, &BB, &BA, &21, &29  ; 8564: 76 92 AA... v..
 EQUB &10, &21, &29, &7C, &22, &6C, &7C, &7D  ; 856C: 10 21 29... .!)
 EQUB &EF, &D7, &EE, &32, &11, &03, &7D, &96  ; 8574: EF D7 EE... ...
 EQUB &FF, &55, &8C, &5A, &97, &21, &07, &FF  ; 857C: FF 55 8C... .U.
 EQUB &7F, &FE, &D6, &8E, &DC, &E0, &50, &00  ; 8584: 7F FE D6... ...
 EQUB &A0, &00, &40, &02, &90, &22, &80, &0F  ; 858C: A0 00 40... ..@
 EQUB &06, &AA, &54, &E1, &B5, &F0, &B5, &37  ; 8594: 06 AA 54... ..T
 EQUB &12, &15, &7F, &3E, &1E, &0E, &0F, &23  ; 859C: 12 15 7F... ...
 EQUB &4F, &82, &C6, &BB, &45, &C6, &21, &39  ; 85A4: 4F 82 C6... O..
 EQUB &82, &FF, &C7, &C6, &7C, &32, &38, &01  ; 85AC: 82 FF C7... ...
 EQUB &C7, &12, &AA, &54, &21, &0E, &5A, &21  ; 85B4: C7 12 AA... ...
 EQUB &1E, &5A, &90, &50, &FC, &F8, &F0, &22  ; 85BC: 1E 5A 90... .Z.
 EQUB &E0, &23, &E4, &0F, &04, &21, &01, &0C  ; 85C4: E0 23 E4... .#.
 EQUB &73, &21, &05, &AA, &38, &11, &16, &09  ; 85CC: 73 21 05... s!.
 EQUB &02, &00, &0F, &2F, &07, &87, &C3, &43  ; 85D4: 02 00 0F... ...
 EQUB &21, &21, &00, &55, &AB, &AA, &C7, &EE  ; 85DC: 21 21 00... !!.
 EQUB &55, &AA, &92, &EF, &AB, &C7, &14, &7C  ; 85E4: 55 AA 92... U..
 EQUB &9C, &40, &AA, &21, &11, &D0, &20, &80  ; 85EC: 9C 40 AA... .@.
 EQUB &00, &E0, &E8, &C0, &C2, &86, &84, &21  ; 85F4: 00 E0 E8... ...
 EQUB &08, &0F, &0F, &0F, &0F, &0F, &0F, &07  ; 85FC: 08 0F 0F... ...
 EQUB &3F, &0F, &21, &01, &04, &33, &08, &02  ; 8604: 3F 0F 21... ?.!
 EQUB &01, &B9, &04, &33, &1C, &06, &33, &C9  ; 860C: 01 B9 04... ...
 EQUB &04, &21, &1A, &60, &32, &04, &25, &03  ; 8614: 04 21 1A... .!.
 EQUB &89, &42, &46, &64, &AC, &05, &58, &40  ; 861C: 89 42 46... .BF
 EQUB &C6, &05, &21, &3C, &E0, &8E, &0F, &02  ; 8624: C6 05 21... ..!
 EQUB &32, &03, &02, &02, &32, &04, &02, &03  ; 862C: 32 03 02... 2..
 EQUB &34, &03, &02, &00, &02, &02, &44, &21  ; 8634: 34 03 02... 4..
 EQUB &22, &86, &55, &40, &B1, &6A, &FD, &6C  ; 863C: 22 86 55... ".U
 EQUB &21, &24, &30, &00, &21, &1F, &71, &EA  ; 8644: 21 24 30... !$0
 EQUB &FD, &FF, &21, &18, &A4, &4D, &30, &AB  ; 864C: FD FF 21... ..!
 EQUB &FE, &55, &22, &AD, &21, &08, &00, &83  ; 8654: FE 55 22... .U"
 EQUB &D7, &FE, &55, &10, &90, &21, &25, &52  ; 865C: D7 FE 55... ..U
 EQUB &32, &04, &19, &AC, &7E, &99, &20, &21  ; 8664: 32 04 19... 2..
 EQUB &03, &00, &F9, &21, &1C, &AE, &7E, &04  ; 866C: 03 00 F9... ...
 EQUB &80, &00, &40, &80, &02, &80, &00, &80  ; 8674: 80 00 40... ..@
 EQUB &02, &40, &39, &05, &04, &01, &05, &03  ; 867C: 02 40 39... .@9
 EQUB &09, &0D, &17, &00, &24, &01, &33, &03  ; 8684: 09 0D 17... ...
 EQUB &1B, &0B, &F6, &FF, &C3, &E9, &D4, &F0  ; 868C: 1B 0B F6... ...
 EQUB &C2, &B6, &F7, &FF, &E7, &D1, &B8, &22  ; 8694: C2 B6 F7... ...
 EQUB &FC, &D8, &BA, &22, &45, &FF, &10, &44  ; 869C: FC D8 BA... ...
 EQUB &54, &44, &BB, &FF, &45, &FF, &FE, &33  ; 86A4: 54 44 BB... TD.
 EQUB &28, &38, &28, &DF, &FE, &87, &21, &2F  ; 86AC: 28 38 28... (8(
 EQUB &57, &21, &1F, &87, &DB, &DE, &FF, &CF  ; 86B4: 57 21 1F... W!.
 EQUB &32, &17, &3B, &22, &7F, &21, &37, &00  ; 86BC: 32 17 3B... 2.;
 EQUB &22, &40, &00, &80, &20, &60, &D0, &05  ; 86C4: 22 40 00... "@.
 EQUB &80, &B0, &A0, &36, &0F, &15, &01, &0A  ; 86CC: 80 B0 A0... ...
 EQUB &01, &05, &02, &34, &13, &03, &03, &01  ; 86D4: 01 05 02... ...
 EQUB &04, &21, &02, &80, &7D, &D3, &FE, &55  ; 86DC: 04 21 02... .!.
 EQUB &62, &B5, &C2, &C0, &FE, &FC, &FF, &D7  ; 86E4: 62 B5 C2... b..
 EQUB &E3, &76, &92, &AA, &AB, &BB, &BA, &21  ; 86EC: E3 76 92... .v.
 EQUB &29, &10, &21, &29, &7C, &22, &6C, &7C  ; 86F4: 29 10 21... ).!
 EQUB &7D, &EF, &D7, &EE, &81, &21, &03, &7D  ; 86FC: 7D EF D7... }..
 EQUB &96, &FF, &55, &8C, &5A, &87, &21, &07  ; 8704: 96 FF 55... ..U
 EQUB &FF, &7F, &FE, &D6, &8E, &DC, &E0, &50  ; 870C: FF 7F FE... ...
 EQUB &00, &A0, &00, &40, &02, &90, &22, &80  ; 8714: 00 A0 00... ...
 EQUB &0F, &06, &AA, &54, &E1, &B5, &F0, &B5  ; 871C: 0F 06 AA... ...
 EQUB &37, &12, &17, &7F, &3E, &1E, &0E, &0F  ; 8724: 37 12 17... 7..
 EQUB &23, &4F, &82, &C6, &BB, &45, &C6, &21  ; 872C: 23 4F 82... #O.
 EQUB &39, &82, &FF, &C7, &C6, &7C, &32, &38  ; 8734: 39 82 FF... 9..
 EQUB &01, &C7, &12, &AA, &54, &21, &0E, &5A  ; 873C: 01 C7 12... ...
 EQUB &21, &1E, &5A, &90, &D0, &FC, &F8, &F0  ; 8744: 21 1E 5A... !.Z
 EQUB &22, &E0, &23, &E4, &0F, &04, &21, &01  ; 874C: 22 E0 23... ".#
 EQUB &0C, &75, &21, &07, &AB, &38, &11, &16  ; 8754: 0C 75 21... .u!
 EQUB &09, &02, &00, &0E, &2D, &07, &87, &C3  ; 875C: 09 02 00... ...
 EQUB &43, &21, &21, &00, &21, &39, &22, &45  ; 8764: 43 21 21... C!!
 EQUB &C7, &EE, &55, &AA, &92, &C6, &45, &83  ; 876C: C7 EE 55... ..U
 EQUB &14, &7C, &5C, &C0, &AA, &21, &11, &D0  ; 8774: 14 7C 5C... .|\
 EQUB &20, &80, &00, &E0, &68, &C0, &C2, &86  ; 877C: 20 80 00...  ..
 EQUB &84, &21, &08, &0F, &0F, &0F, &0F, &0F  ; 8784: 84 21 08... .!.
 EQUB &0F, &07, &3F, &0F, &21, &01, &04, &33  ; 878C: 0F 07 3F... ..?
 EQUB &08, &02, &01, &B9, &04, &33, &1C, &06  ; 8794: 08 02 01... ...
 EQUB &33, &C9, &04, &21, &1A, &60, &32, &04  ; 879C: 33 C9 04... 3..
 EQUB &25, &03, &89, &42, &46, &64, &AC, &05  ; 87A4: 25 03 89... %..
 EQUB &58, &40, &C6, &05, &21, &3C, &E0, &8E  ; 87AC: 58 40 C6... X@.
 EQUB &0F, &02, &32, &03, &02, &02, &32, &04  ; 87B4: 0F 02 32... ..2
 EQUB &02, &03, &34, &03, &02, &00, &02, &02  ; 87BC: 02 03 34... ..4
 EQUB &44, &21, &22, &86, &55, &40, &B1, &6A  ; 87C4: 44 21 22... D!"
 EQUB &FD, &6C, &21, &24, &30, &00, &21, &1F  ; 87CC: FD 6C 21... .l!
 EQUB &71, &EA, &FD, &FF, &21, &18, &A4, &4D  ; 87D4: 71 EA FD... q..
 EQUB &30, &AB, &FE, &55, &22, &AD, &21, &08  ; 87DC: 30 AB FE... 0..
 EQUB &00, &83, &D7, &FE, &55, &10, &90, &21  ; 87E4: 00 83 D7... ...
 EQUB &25, &52, &32, &04, &19, &AC, &7E, &99  ; 87EC: 25 52 32... %R2
 EQUB &20, &21, &03, &00, &F9, &21, &1C, &AE  ; 87F4: 20 21 03...  !.
 EQUB &7E, &04, &80, &00, &40, &80, &02, &80  ; 87FC: 7E 04 80... ~..
 EQUB &00, &80, &02, &40, &39, &05, &04, &01  ; 8804: 00 80 02... ...
 EQUB &05, &03, &09, &0D, &17, &00, &24, &01  ; 880C: 05 03 09... ...
 EQUB &33, &03, &1B, &0B, &FF, &FE, &FF, &F4  ; 8814: 33 03 1B... 3..
 EQUB &FF, &4C, &D0, &7E, &13, &F4, &FF, &83  ; 881C: FF 4C D0... .L.
 EQUB &E0, &80, &BB, &54, &C7, &BB, &B8, &C4  ; 8824: E0 80 BB... ...
 EQUB &22, &6C, &BB, &FF, &BB, &C7, &D6, &22  ; 882C: 22 6C BB... "l.
 EQUB &28, &10, &FF, &FE, &87, &21, &2F, &57  ; 8834: 28 10 FF... (..
 EQUB &21, &1F, &87, &DB, &FE, &FF, &CF, &32  ; 883C: 21 1F 87... !..
 EQUB &17, &3B, &22, &7F, &57, &00, &22, &40  ; 8844: 17 3B 22... .;"
 EQUB &00, &80, &20, &60, &D0, &05, &80, &B0  ; 884C: 00 80 20... ..
 EQUB &A0, &36, &0F, &15, &01, &0A, &01, &05  ; 8854: A0 36 0F... .6.
 EQUB &02, &34, &13, &03, &03, &01, &04, &F7  ; 885C: 02 34 13... .4.
 EQUB &9D, &FC, &59, &55, &62, &B5, &AA, &F8  ; 8864: 9D FC 59... ..Y
 EQUB &E2, &22, &FE, &D7, &E3, &76, &7F, &21  ; 886C: E2 22 FE... .".
 EQUB &12, &AA, &BB, &BA, &33, &28, &11, &28  ; 8874: 12 AA BB... ...
 EQUB &82, &7C, &6C, &7C, &7D, &EF, &D7, &EF  ; 887C: 82 7C 6C... .|l
 EQUB &C7, &32, &01, &03, &7D, &96, &FF, &55  ; 8884: C7 32 01... .2.
 EQUB &8C, &5A, &22, &07, &FF, &7F, &FE, &D6  ; 888C: 8C 5A 22... .Z"
 EQUB &8E, &DC, &E0, &50, &00, &A0, &00, &40  ; 8894: 8E DC E0... ...
 EQUB &02, &90, &22, &80, &0F, &06, &54, &E1  ; 889C: 02 90 22... .."
 EQUB &B5, &F0, &B5, &37, &12, &15, &13, &3E  ; 88A4: B5 F0 B5... ...
 EQUB &1E, &0E, &0F, &24, &4F, &C6, &BB, &45  ; 88AC: 1E 0E 0F... ...
 EQUB &C6, &21, &39, &82, &55, &FF, &C6, &7C  ; 88B4: C6 21 39... .!9
 EQUB &32, &38, &01, &C7, &13, &AA, &D4, &21  ; 88BC: 32 38 01... 28.
 EQUB &0E, &5A, &21, &1E, &5A, &90, &D0, &7C  ; 88C4: 0E 5A 21... .Z!
 EQUB &78, &F0, &22, &E0, &23, &E4, &0F, &04  ; 88CC: 78 F0 22... x."
 EQUB &21, &01, &0C, &74, &21, &02, &AB, &38  ; 88D4: 21 01 0C... !..
 EQUB &11, &16, &09, &02, &00, &0E, &2D, &07  ; 88DC: 11 16 09... ...
 EQUB &87, &C3, &43, &21, &21, &00, &82, &C6  ; 88E4: 87 C3 43... ..C
 EQUB &BB, &83, &EE, &55, &AA, &92, &7C, &22  ; 88EC: BB 83 EE... ...
 EQUB &C7, &14, &7C, &5C, &80, &AA, &21, &11  ; 88F4: C7 14 7C... ..|
 EQUB &D0, &20, &80, &00, &E0, &68, &C0, &C2  ; 88FC: D0 20 80... . .
 EQUB &86, &84, &21, &08, &0F, &0F, &0F, &0F  ; 8904: 86 84 21... ..!
 EQUB &0F, &0F, &07, &3F, &0F, &05, &32, &02  ; 890C: 0F 0F 07... ...
 EQUB &14, &62, &D4, &04, &34, &01, &0B, &1D  ; 8914: 14 62 D4... .b.
 EQUB &2B, &04, &AA, &10, &BA, &10, &04, &7D  ; 891C: 2B 04 AA... +..
 EQUB &13, &04, &80, &50, &8C, &56, &05, &A0  ; 8924: 13 04 80... ...
 EQUB &70, &A8, &0F, &01, &3C, &01, &02, &03  ; 892C: 70 A8 0F... p..
 EQUB &02, &07, &07, &06, &06, &00, &01, &00  ; 8934: 02 07 07... ...
 EQUB &01, &04, &AA, &F1, &AA, &D5, &4E, &B1  ; 893C: 01 04 AA... ...
 EQUB &6A, &FD, &55, &21, &0E, &55, &00, &21  ; 8944: 6A FD 55... j.U
 EQUB &3F, &71, &EA, &FD, &AA, &21, &01, &AA  ; 894C: 3F 71 EA... ?q.
 EQUB &45, &BA, &AB, &FE, &55, &7D, &FE, &55  ; 8954: 45 BA AB... E..
 EQUB &10, &21, &01, &C7, &FE, &55, &AB, &21  ; 895C: 10 21 01... .!.
 EQUB &1E, &AB, &56, &E5, &21, &1B, &AC, &7E  ; 8964: 1E AB 56... ..V
 EQUB &54, &E1, &54, &21, &01, &F8, &21, &1C  ; 896C: 54 E1 54... T.T
 EQUB &AE, &7E, &00, &23, &80, &24, &C0, &08  ; 8974: AE 7E 00... .~.
 EQUB &39, &05, &04, &05, &05, &03, &09, &0D  ; 897C: 39 05 04... 9..
 EQUB &17, &00, &24, &01, &33, &03, &1B, &0B  ; 8984: 17 00 24... ..$
 EQUB &FF, &F5, &FC, &FB, &E2, &88, &44, &BC  ; 898C: FF F5 FC... ...
 EQUB &FF, &F7, &FC, &C7, &81, &70, &F8, &C0  ; 8994: FF F7 FC... ...
 EQUB &BB, &55, &AA, &FF, &10, &C6, &54, &44  ; 899C: BB 55 AA... .U.
 EQUB &BB, &FF, &AA, &12, &33, &28, &38, &28  ; 89A4: BB FF AA... ...
 EQUB &FF, &5E, &7F, &BF, &8F, &21, &23, &45  ; 89AC: FF 5E 7F... .^.
 EQUB &7B, &FE, &DF, &7F, &C7, &34, &03, &1D  ; 89B4: 7B FE DF... {..
 EQUB &3F, &07, &24, &40, &80, &20, &60, &D0  ; 89BC: 3F 07 24... ?.$
 EQUB &05, &80, &B0, &A0, &36, &0F, &15, &01  ; 89C4: 05 80 B0... ...
 EQUB &0A, &01, &05, &02, &34, &13, &03, &03  ; 89CC: 0A 01 05... ...
 EQUB &01, &04, &21, &12, &80, &7D, &D3, &FE  ; 89D4: 01 04 21... ..!
 EQUB &55, &62, &B5, &D0, &C0, &FE, &FC, &FF  ; 89DC: 55 62 B5... Ub.
 EQUB &D7, &E3, &76, &92, &AA, &AB, &BB, &BA  ; 89E4: D7 E3 76... ..v
 EQUB &21, &29, &10, &21, &29, &7C, &22, &6C  ; 89EC: 21 29 10... !).
 EQUB &7C, &7D, &EF, &D7, &EE, &91, &21, &03  ; 89F4: 7C 7D EF... |}.
 EQUB &7D, &96, &FF, &55, &8C, &5A, &32, &17  ; 89FC: 7D 96 FF... }..
 EQUB &07, &FF, &7F, &FE, &D6, &8E, &DC, &E0  ; 8A04: 07 FF 7F... ...
 EQUB &50, &00, &A0, &00, &40, &02, &90, &22  ; 8A0C: 50 00 A0... P..
 EQUB &80, &0F, &06, &AA, &54, &E1, &BB, &F4  ; 8A14: 80 0F 06... ...
 EQUB &B1, &58, &21, &12, &7F, &36, &3E, &1E  ; 8A1C: B1 58 21... .X!
 EQUB &04, &0B, &4E, &07, &4D, &82, &C6, &BB  ; 8A24: 04 0B 4E... ..N
 EQUB &45, &C6, &21, &39, &82, &21, &28, &C7  ; 8A2C: 45 C6 21... E.!
 EQUB &C6, &7C, &32, &38, &01, &C6, &7D, &FF  ; 8A34: C6 7C 32... .|2
 EQUB &AA, &54, &21, &0E, &BA, &5E, &32, &1A  ; 8A3C: AA 54 21... .T!
 EQUB &34, &90, &FC, &F8, &F0, &40, &A0, &E4  ; 8A44: 34 90 FC... 4..
 EQUB &C0, &64, &0F, &04, &21, &01, &0C, &78  ; 8A4C: C0 64 0F... .d.
 EQUB &21, &04, &A8, &38, &12, &14, &09, &02  ; 8A54: 21 04 A8... !..
 EQUB &00, &07, &2B, &07, &85, &C3, &42, &21  ; 8A5C: 00 07 2B... ..+
 EQUB &21, &00, &21, &38, &AA, &21, &28, &10  ; 8A64: 21 00 21... !.!
 EQUB &44, &21, &01, &54, &BA, &C7, &AB, &C7  ; 8A6C: 44 21 01... D!.
 EQUB &EF, &BB, &FE, &AB, &44, &21, &3C, &40  ; 8A74: EF BB FE... ...
 EQUB &21, &2A, &91, &50, &20, &80, &00, &C0  ; 8A7C: 21 2A 91... !*.
 EQUB &A8, &C0, &42, &86, &84, &21, &08, &0F  ; 8A84: A8 C0 42... ..B
 EQUB &0F, &0F, &0F, &0F, &0F, &07, &3F, &0F  ; 8A8C: 0F 0F 0F... ...
 EQUB &05, &32, &02, &14, &62, &D4, &04, &34  ; 8A94: 05 32 02... .2.
 EQUB &01, &0B, &1D, &2B, &04, &AA, &10, &BA  ; 8A9C: 01 0B 1D... ...
 EQUB &10, &04, &7D, &13, &04, &80, &50, &8C  ; 8AA4: 10 04 7D... ..}
 EQUB &56, &05, &A0, &70, &A8, &0F, &01, &3C  ; 8AAC: 56 05 A0... V..
 EQUB &01, &02, &03, &02, &07, &07, &06, &06  ; 8AB4: 01 02 03... ...
 EQUB &00, &01, &00, &01, &04, &AA, &F1, &AA  ; 8ABC: 00 01 00... ...
 EQUB &D5, &4E, &B1, &6A, &FD, &55, &21, &0E  ; 8AC4: D5 4E B1... .N.
 EQUB &55, &00, &21, &3F, &71, &EA, &FD, &AA  ; 8ACC: 55 00 21... U.!
 EQUB &21, &01, &AA, &45, &BA, &AB, &FE, &55  ; 8AD4: 21 01 AA... !..
 EQUB &7D, &FE, &55, &10, &21, &01, &C7, &FE  ; 8ADC: 7D FE 55... }.U
 EQUB &55, &AB, &21, &1E, &AB, &56, &E5, &21  ; 8AE4: 55 AB 21... U.!
 EQUB &1B, &AC, &7E, &54, &E1, &54, &21, &01  ; 8AEC: 1B AC 7E... ..~
 EQUB &F8, &21, &1C, &AE, &7E, &00, &23, &80  ; 8AF4: F8 21 1C... .!.
 EQUB &24, &C0, &08, &39, &05, &04, &05, &05  ; 8AFC: 24 C0 08... $..
 EQUB &03, &09, &0D, &17, &00, &24, &01, &33  ; 8B04: 03 09 0D... ...
 EQUB &03, &1B, &0B, &F5, &FF, &E2, &A7, &49  ; 8B0C: 03 1B 0B... ...
 EQUB &E4, &C4, &AE, &F7, &FF, &FE, &C1, &B0  ; 8B14: E4 C4 AE... ...
 EQUB &22, &F8, &D0, &BB, &45, &C6, &FF, &21  ; 8B1C: 22 F8 D0... "..
 EQUB &11, &C6, &54, &44, &BB, &FF, &C6, &FF  ; 8B24: 11 C6 54... ..T
 EQUB &FE, &33, &28, &38, &28, &5F, &FE, &8F  ; 8B2C: FE 33 28... .3(
 EQUB &CB, &21, &25, &4F, &47, &EB, &DE, &12  ; 8B34: CB 21 25... .!%
 EQUB &35, &07, &1B, &3F, &3F, &17, &24, &40  ; 8B3C: 35 07 1B... 5..
 EQUB &80, &20, &60, &D0, &05, &80, &B0, &A0  ; 8B44: 80 20 60... . `
 EQUB &36, &0F, &15, &01, &0A, &01, &05, &02  ; 8B4C: 36 0F 15... 6..
 EQUB &34, &13, &03, &03, &01, &04, &10, &80  ; 8B54: 34 13 03... 4..
 EQUB &7D, &D3, &FE, &55, &62, &B5, &D2, &C0  ; 8B5C: 7D D3 FE... }..
 EQUB &FE, &FC, &FF, &D7, &E3, &76, &92, &AA  ; 8B64: FE FC FF... ...
 EQUB &AB, &BB, &BA, &21, &29, &10, &21, &29  ; 8B6C: AB BB BA... ...
 EQUB &7C, &22, &6C, &7C, &7D, &EF, &D7, &EE  ; 8B74: 7C 22 6C... |"l
 EQUB &32, &11, &03, &7D, &96, &FF, &55, &8C  ; 8B7C: 32 11 03... 2..
 EQUB &5A, &97, &21, &07, &FF, &7F, &FE, &D6  ; 8B84: 5A 97 21... Z.!
 EQUB &8E, &DC, &E0, &50, &00, &A0, &00, &40  ; 8B8C: 8E DC E0... ...
 EQUB &02, &90, &22, &80, &0F, &06, &AA, &54  ; 8B94: 02 90 22... .."
 EQUB &E1, &BB, &F4, &B1, &58, &21, &12, &7F  ; 8B9C: E1 BB F4... ...
 EQUB &36, &3E, &1E, &04, &0B, &4E, &07, &4D  ; 8BA4: 36 3E 1E... 6>.
 EQUB &82, &C6, &BB, &45, &C6, &21, &39, &82  ; 8BAC: 82 C6 BB... ...
 EQUB &21, &28, &C7, &C6, &7C, &32, &38, &01  ; 8BB4: 21 28 C7... !(.
 EQUB &C6, &7D, &FF, &AA, &54, &21, &0E, &BA  ; 8BBC: C6 7D FF... .}.
 EQUB &5E, &32, &1A, &34, &90, &FC, &F8, &F0  ; 8BC4: 5E 32 1A... ^2.
 EQUB &40, &A0, &E4, &C0, &64, &0F, &04, &21  ; 8BCC: 40 A0 E4... @..
 EQUB &01, &0C, &78, &21, &05, &A9, &38, &12  ; 8BD4: 01 0C 78... ..x
 EQUB &14, &09, &02, &00, &07, &2A, &07, &85  ; 8BDC: 14 09 02... ...
 EQUB &C3, &42, &21, &21, &00, &BA, &AB, &21  ; 8BE4: C3 42 21... .B!
 EQUB &29, &10, &44, &21, &01, &54, &BA, &45  ; 8BEC: 29 10 44... ).D
 EQUB &AA, &C7, &EF, &BB, &FE, &AB, &44, &21  ; 8BF4: AA C7 EF... ...
 EQUB &3C, &40, &21, &2A, &91, &50, &20, &80  ; 8BFC: 3C 40 21... <@!
 EQUB &00, &C0, &A8, &C0, &42, &86, &84, &21  ; 8C04: 00 C0 A8... ...
 EQUB &08, &0F, &0F, &0F, &0F, &0F, &0F, &07  ; 8C0C: 08 0F 0F... ...
 EQUB &3F, &0F, &05, &32, &02, &14, &62, &D4  ; 8C14: 3F 0F 05... ?..
 EQUB &04, &34, &01, &0B, &1D, &2B, &04, &AA  ; 8C1C: 04 34 01... .4.
 EQUB &10, &BA, &10, &04, &7D, &13, &04, &80  ; 8C24: 10 BA 10... ...
 EQUB &50, &8C, &56, &05, &A0, &70, &A8, &0F  ; 8C2C: 50 8C 56... P.V
 EQUB &01, &3C, &01, &02, &03, &02, &07, &07  ; 8C34: 01 3C 01... .<.
 EQUB &06, &06, &00, &01, &00, &01, &04, &AA  ; 8C3C: 06 06 00... ...
 EQUB &F1, &AA, &D5, &4E, &B1, &6A, &FD, &55  ; 8C44: F1 AA D5... ...
 EQUB &21, &0E, &55, &00, &21, &3F, &71, &EA  ; 8C4C: 21 0E 55... !.U
 EQUB &FD, &AA, &21, &01, &AA, &45, &BA, &AB  ; 8C54: FD AA 21... ..!
 EQUB &FE, &55, &7D, &FE, &55, &10, &21, &01  ; 8C5C: FE 55 7D... .U}
 EQUB &C7, &FE, &55, &AB, &21, &1E, &AB, &56  ; 8C64: C7 FE 55... ..U
 EQUB &E5, &21, &1B, &AC, &7E, &54, &E1, &54  ; 8C6C: E5 21 1B... .!.
 EQUB &21, &01, &F8, &21, &1C, &AE, &7E, &00  ; 8C74: 21 01 F8... !..
 EQUB &23, &80, &24, &C0, &08, &39, &05, &04  ; 8C7C: 23 80 24... #.$
 EQUB &05, &05, &03, &09, &0D, &17, &00, &24  ; 8C84: 05 05 03... ...
 EQUB &01, &33, &03, &1B, &0B, &12, &F5, &EE  ; 8C8C: 01 33 03... .3.
 EQUB &A4, &51, &44, &21, &3C, &12, &F7, &FE  ; 8C94: A4 51 44... .QD
 EQUB &C3, &80, &21, &38, &C0, &BB, &EF, &6D  ; 8C9C: C3 80 21... ..!
 EQUB &D6, &10, &C7, &54, &44, &BB, &FF, &EF  ; 8CA4: D6 10 C7... ...
 EQUB &FE, &FF, &33, &28, &38, &28, &FF, &FE  ; 8CAC: FE FF 33... ..3
 EQUB &5F, &EF, &4B, &21, &15, &45, &79, &FE  ; 8CB4: 5F EF 4B... _.K
 EQUB &FF, &DF, &FF, &87, &33, &03, &39, &07  ; 8CBC: FF DF FF... ...
 EQUB &24, &40, &80, &20, &60, &D0, &05, &80  ; 8CC4: 24 40 80... $@.
 EQUB &B0, &A0, &36, &0F, &15, &01, &0A, &01  ; 8CCC: B0 A0 36... ..6
 EQUB &05, &02, &34, &13, &03, &03, &01, &04  ; 8CD4: 05 02 34... ..4
 EQUB &21, &02, &80, &7D, &D3, &FE, &55, &62  ; 8CDC: 21 02 80... !..
 EQUB &B5, &D0, &C0, &FE, &FC, &FF, &D7, &E3  ; 8CE4: B5 D0 C0... ...
 EQUB &76, &92, &AA, &AB, &BB, &BA, &21, &29  ; 8CEC: 76 92 AA... v..
 EQUB &10, &21, &29, &7C, &22, &6C, &7C, &7D  ; 8CF4: 10 21 29... .!)
 EQUB &EF, &D7, &EE, &81, &21, &03, &7D, &96  ; 8CFC: EF D7 EE... ...
 EQUB &FF, &55, &8C, &5A, &32, &17, &07, &FF  ; 8D04: FF 55 8C... .U.
 EQUB &7F, &FE, &D6, &8E, &DC, &E0, &50, &00  ; 8D0C: 7F FE D6... ...
 EQUB &A0, &00, &40, &02, &90, &22, &80, &0F  ; 8D14: A0 00 40... ..@
 EQUB &06, &AA, &54, &E1, &B5, &FA, &B5, &37  ; 8D1C: 06 AA 54... ..T
 EQUB &1F, &17, &7F, &3E, &1E, &0E, &0F, &23  ; 8D24: 1F 17 7F... ...
 EQUB &4F, &82, &C6, &BB, &45, &C6, &21, &39  ; 8D2C: 4F 82 C6... O..
 EQUB &83, &FF, &C7, &C6, &7C, &32, &38, &01  ; 8D34: 83 FF C7... ...
 EQUB &C7, &12, &AA, &54, &21, &0E, &5A, &BE  ; 8D3C: C7 12 AA... ...
 EQUB &5A, &F0, &D0, &FC, &F8, &F0, &22, &E0  ; 8D44: 5A F0 D0... Z..
 EQUB &23, &E4, &0F, &0F, &02, &7F, &3E, &07  ; 8D4C: 23 E4 0F... #..
 EQUB &2F, &13, &16, &09, &02, &00, &0F, &2F  ; 8D54: 2F 13 16... /..
 EQUB &07, &07, &02, &03, &01, &00, &7D, &22  ; 8D5C: 07 07 02... ...
 EQUB &AB, &EF, &FE, &45, &EE, &BA, &83, &AB  ; 8D64: AB EF FE... ...
 EQUB &C7, &FF, &FE, &45, &EF, &7C, &FC, &C0  ; 8D6C: C7 FF FE... ...
 EQUB &E8, &90, &D0, &20, &80, &00, &E0, &E8  ; 8D74: E8 90 D0... ...
 EQUB &22, &C0, &22, &80, &0F, &0F, &0F, &0F  ; 8D7C: 22 C0 22... "."
 EQUB &0F, &0F, &08, &3F, &0F, &21, &01, &04  ; 8D84: 0F 0F 08... ...
 EQUB &33, &08, &02, &01, &B9, &04, &33, &1C  ; 8D8C: 33 08 02... 3..
 EQUB &06, &33, &C9, &04, &21, &1A, &60, &32  ; 8D94: 06 33 C9... .3.
 EQUB &04, &25, &03, &89, &42, &46, &64, &AC  ; 8D9C: 04 25 03... .%.
 EQUB &05, &58, &40, &C6, &05, &21, &3C, &E0  ; 8DA4: 05 58 40... .X@
 EQUB &8E, &0F, &02, &32, &03, &02, &02, &32  ; 8DAC: 8E 0F 02... ...
 EQUB &04, &02, &03, &34, &03, &02, &00, &02  ; 8DB4: 04 02 03... ...
 EQUB &02, &44, &21, &22, &86, &55, &4E, &B1  ; 8DBC: 02 44 21... .D!
 EQUB &6A, &F5, &6C, &21, &24, &30, &00, &21  ; 8DC4: 6A F5 6C... j.l
 EQUB &3F, &71, &EA, &FD, &FF, &21, &18, &A4  ; 8DCC: 3F 71 EA... ?q.
 EQUB &21, &0D, &82, &AB, &FE, &55, &22, &AD  ; 8DD4: 21 0D 82... !..
 EQUB &21, &08, &00, &21, &01, &C7, &FE, &55  ; 8DDC: 21 08 00... !..
 EQUB &10, &90, &21, &25, &52, &E4, &21, &1B  ; 8DE4: 10 90 21... ..!
 EQUB &AC, &7E, &99, &20, &21, &03, &00, &F9  ; 8DEC: AC 7E 99... .~.
 EQUB &21, &1C, &AE, &7E, &04, &80, &00, &40  ; 8DF4: 21 1C AE... !..
 EQUB &80, &02, &80, &00, &80, &02, &40, &39  ; 8DFC: 80 02 80... ...
 EQUB &05, &04, &01, &01, &03, &09, &0D, &17  ; 8E04: 05 04 01... ...
 EQUB &00, &24, &01, &33, &03, &1B, &0B, &EF  ; 8E0C: 00 24 01... .$.
 EQUB &D7, &B7, &DA, &73, &21, &06, &B8, &21  ; 8E14: D7 B7 DA... ...
 EQUB &0E, &FF, &E7, &D7, &BA, &8F, &81, &00  ; 8E1C: 0E FF E7... ...
 EQUB &70, &BB, &12, &D6, &BB, &44, &EE, &54  ; 8E24: 70 BB 12... p..
 EQUB &BB, &12, &FE, &FF, &AB, &32, &28, &38  ; 8E2C: BB 12 FE... ...
 EQUB &FF, &FE, &DF, &B7, &9B, &C1, &21, &3B  ; 8E34: FF FE DF... ...
 EQUB &E1, &FE, &FF, &DF, &B7, &E7, &33, &03  ; 8E3C: E1 FE FF... ...
 EQUB &01, &1D, &00, &22, &40, &00, &80, &20  ; 8E44: 01 1D 00... ...
 EQUB &60, &D0, &05, &80, &B0, &A0, &36, &0F  ; 8E4C: 60 D0 05... `..
 EQUB &15, &01, &0A, &01, &05, &02, &34, &13  ; 8E54: 15 01 0A... ...
 EQUB &03, &03, &01, &04, &21, &3E, &00, &7D  ; 8E5C: 03 03 01... ...
 EQUB &D3, &FE, &55, &62, &B5, &22, &C0, &FE  ; 8E64: D3 FE 55... ..U
 EQUB &FC, &FF, &D7, &E3, &76, &82, &AA, &AB  ; 8E6C: FC FF D7... ...
 EQUB &BB, &BA, &21, &29, &10, &21, &29, &23  ; 8E74: BB BA 21... ..!
 EQUB &6C, &7C, &7D, &EF, &D7, &EE, &F9, &21  ; 8E7C: 6C 7C 7D... l|}
 EQUB &01, &7D, &96, &FF, &55, &8C, &5A, &22  ; 8E84: 01 7D 96... .}.
 EQUB &07, &FF, &7F, &FE, &D6, &8E, &DC, &E0  ; 8E8C: 07 FF 7F... ...
 EQUB &50, &00, &A0, &00, &40, &02, &90, &22  ; 8E94: 50 00 A0... P..
 EQUB &80, &0F, &06, &AA, &54, &E1, &B1, &F2  ; 8E9C: 80 0F 06... ...
 EQUB &B5, &37, &12, &15, &7F, &3E, &1E, &0E  ; 8EA4: B5 37 12... .7.
 EQUB &0F, &23, &4F, &82, &C6, &BB, &45, &C6  ; 8EAC: 0F 23 4F... .#O
 EQUB &21, &39, &82, &FF, &C7, &C6, &7C, &32  ; 8EB4: 21 39 82... !9.
 EQUB &38, &01, &C7, &12, &AA, &54, &32, &0E  ; 8EBC: 38 01 C7... 8..
 EQUB &1A, &9E, &5A, &90, &50, &FC, &F8, &F0  ; 8EC4: 1A 9E 5A... ..Z
 EQUB &22, &E0, &23, &E4, &0F, &0F, &02, &72  ; 8ECC: 22 E0 23... ".#
 EQUB &3E, &05, &2B, &11, &16, &09, &02, &00  ; 8ED4: 3E 05 2B... >.+
 EQUB &0F, &2F, &07, &07, &03, &03, &01, &00  ; 8EDC: 0F 2F 07... ./.
 EQUB &7C, &AB, &BB, &C7, &EE, &55, &21, &28  ; 8EE4: 7C AB BB... |..
 EQUB &92, &83, &AB, &C7, &14, &7C, &9C, &40  ; 8EEC: 92 83 AB... ...
 EQUB &A8, &10, &D0, &20, &80, &00, &E0, &E8  ; 8EF4: A8 10 D0... ...
 EQUB &22, &C0, &22, &80, &0F, &0F, &0F, &0F  ; 8EFC: 22 C0 22... "."
 EQUB &0F, &0F, &08, &3F, &0F, &04, &32, &14  ; 8F04: 0F 0F 08... ...
 EQUB &02, &00, &53, &88, &03, &34, &08, &06  ; 8F0C: 02 00 53... ..S
 EQUB &03, &21, &71, &03, &21, &1A, &20, &44  ; 8F14: 03 21 71... .!q
 EQUB &A5, &7C, &02, &21, &09, &82, &46, &66  ; 8F1C: A5 7C 02... .|.
 EQUB &6C, &AD, &04, &4C, &40, &C0, &21, &0A  ; 8F24: 6C AD 04... l..
 EQUB &04, &30, &E0, &80, &84, &0F, &01, &21  ; 8F2C: 04 30 E0... .0.
 EQUB &01, &00, &3B, &03, &01, &02, &01, &04  ; 8F34: 01 00 3B... ..;
 EQUB &02, &00, &01, &01, &03, &01, &02, &21  ; 8F3C: 02 00 01... ...
 EQUB &04, &75, &DA, &AC, &F5, &AA, &D1, &EA  ; 8F44: 04 75 DA... .u.
 EQUB &F5, &F8, &DC, &AE, &F6, &AB, &D1, &EA  ; 8F4C: F5 F8 DC... ...
 EQUB &FD, &FF, &21, &18, &A4, &21, &0D, &82  ; 8F54: FD FF 21... ..!
 EQUB &AB, &FE, &55, &22, &AD, &21, &08, &00  ; 8F5C: AB FE 55... ..U
 EQUB &21, &01, &C7, &FE, &55, &21, &11, &AE  ; 8F64: 21 01 C7... !..
 EQUB &34, &1B, &35, &E2, &17, &AE, &7E, &8E  ; 8F6C: 34 1B 35... 4.5
 EQUB &32, &1F, &3B, &75, &E3, &21, &16, &AE  ; 8F74: 32 1F 3B... 2.;
 EQUB &7E, &02, &80, &00, &80, &00, &40, &80  ; 8F7C: 7E 02 80... ~..
 EQUB &03, &80, &03, &40, &39, &01, &04, &05  ; 8F84: 03 80 03... ...
 EQUB &01, &03, &09, &0D, &17, &00, &24, &01  ; 8F8C: 01 03 09... ...
 EQUB &33, &03, &1B, &0B, &EF, &D7, &B7, &9A  ; 8F94: 33 03 1B... 3..
 EQUB &43, &21, &06, &B0, &21, &0C, &FF, &E7  ; 8F9C: 43 21 06... C!.
 EQUB &D7, &FA, &BF, &81, &00, &70, &BB, &FF  ; 8FA4: D7 FA BF... ...
 EQUB &D7, &FE, &93, &44, &EE, &54, &BB, &12  ; 8FAC: D7 FE 93... ...
 EQUB &FE, &FF, &AB, &32, &28, &38, &FF, &FE  ; 8FB4: FE FF AB... ...
 EQUB &DF, &B7, &8F, &C1, &21, &1B, &61, &FE  ; 8FBC: DF B7 8F... ...
 EQUB &FF, &DF, &B7, &FF, &33, &03, &01, &1D  ; 8FC4: FF DF B7... ...
 EQUB &00, &22, &40, &00, &80, &20, &60, &D0  ; 8FCC: 00 22 40... ."@
 EQUB &05, &80, &B0, &A0, &36, &0F, &15, &01  ; 8FD4: 05 80 B0... ...
 EQUB &0A, &01, &05, &02, &34, &13, &03, &03  ; 8FDC: 0A 01 05... ...
 EQUB &01, &04, &BE, &00, &7D, &D3, &FE, &55  ; 8FE4: 01 04 BE... ...
 EQUB &62, &B5, &40, &C0, &FE, &FC, &FF, &D7  ; 8FEC: 62 B5 40... b.@
 EQUB &E3, &76, &22, &AA, &AB, &BB, &BA, &21  ; 8FF4: E3 76 22... .v"
 EQUB &29, &10, &21, &29, &23, &6C, &7C, &7D  ; 8FFC: 29 10 21... ).!
 EQUB &EF, &D7, &EE, &FB, &21, &01, &7D, &96  ; 9004: EF D7 EE... ...
 EQUB &FF, &55, &8C, &5A, &32, &05, &07, &FF  ; 900C: FF 55 8C... .U.
 EQUB &7F, &FE, &D6, &8E, &DC, &E0, &50, &00  ; 9014: 7F FE D6... ...
 EQUB &A0, &00, &40, &02, &90, &22, &80, &0F  ; 901C: A0 00 40... ..@
 EQUB &06, &AA, &54, &E1, &BB, &F0, &B5, &58  ; 9024: 06 AA 54... ..T
 EQUB &21, &14, &7F, &36, &3E, &1E, &04, &0F  ; 902C: 21 14 7F... !..
 EQUB &4A, &07, &4B, &82, &C6, &BB, &45, &C6  ; 9034: 4A 07 4B... J.K
 EQUB &21, &39, &00, &BA, &C7, &C6, &7C, &32  ; 903C: 21 39 00... !9.
 EQUB &38, &01, &C6, &12, &AA, &54, &21, &0E  ; 9044: 38 01 C6... 8..
 EQUB &BA, &21, &1E, &5A, &21, &34, &50, &FC  ; 904C: BA 21 1E... .!.
 EQUB &F8, &F0, &40, &E0, &A4, &C0, &A4, &0F  ; 9054: F8 F0 40... ..@
 EQUB &0F, &02, &70, &3E, &04, &28, &12, &14  ; 905C: 0F 02 70... ..p
 EQUB &09, &02, &00, &0F, &2B, &07, &05, &03  ; 9064: 09 02 00... ...
 EQUB &02, &01, &00, &FE, &AA, &21, &38, &10  ; 906C: 02 01 00... ...
 EQUB &82, &21, &11, &44, &AA, &21, &01, &AB  ; 9074: 82 21 11... .!.
 EQUB &C7, &EF, &7D, &EE, &BB, &54, &21, &1C  ; 907C: C7 EF 7D... ..}
 EQUB &40, &21, &28, &90, &50, &20, &80, &00  ; 9084: 40 21 28... @!(
 EQUB &E0, &A8, &C0, &40, &22, &80, &0F, &0F  ; 908C: E0 A8 C0... ...
 EQUB &0F, &0F, &0F, &0F, &08, &3F, &0F, &05  ; 9094: 0F 0F 0F... ...
 EQUB &34, &02, &14, &32, &24, &04, &33, &01  ; 909C: 34 02 14... 4..
 EQUB &0B, &0D, &CB, &04, &AA, &10, &BA, &10  ; 90A4: 0B 0D CB... ...
 EQUB &04, &7D, &13, &04, &80, &50, &98, &48  ; 90AC: 04 7D 13... .}.
 EQUB &05, &A0, &60, &A6, &0F, &02, &39, &02  ; 90B4: 05 A0 60... ..`
 EQUB &01, &00, &05, &04, &06, &06, &01, &01  ; 90BC: 01 00 05... ...
 EQUB &23, &03, &21, &01, &02, &21, &1A, &9D  ; 90C4: 23 03 21... #.!
 EQUB &4E, &21, &35, &7E, &F1, &6A, &F5, &E5  ; 90CC: 4E 21 35... N!5
 EQUB &E2, &F1, &F8, &FF, &F1, &EA, &FD, &AA  ; 90D4: E2 F1 F8... ...
 EQUB &21, &01, &AA, &45, &BA, &AB, &FE, &55  ; 90DC: 21 01 AA... !..
 EQUB &7D, &FE, &55, &10, &21, &01, &C7, &FE  ; 90E4: 7D FE 55... }.U
 EQUB &55, &B0, &72, &A5, &58, &FD, &21, &1E  ; 90EC: 55 B0 72... U.r
 EQUB &BC, &6E, &4F, &8F, &34, &1F, &3F, &FF  ; 90F4: BC 6E 4F... .nO
 EQUB &1F, &BE, &7E, &00, &80, &02, &22, &40  ; 90FC: 1F BE 7E... ..~
 EQUB &22, &C0, &02, &23, &80, &03, &39, &05  ; 9104: 22 C0 02... "..
 EQUB &04, &05, &05, &03, &09, &0D, &17, &00  ; 910C: 04 05 05... ...
 EQUB &24, &01, &33, &03, &1B, &0B, &EF, &D7  ; 9114: 24 01 33... $.3
 EQUB &F7, &9A, &C7, &64, &21, &01, &C8, &FF  ; 911C: F7 9A C7... ...
 EQUB &E7, &D7, &FA, &BF, &83, &80, &30, &BB  ; 9124: E7 D7 FA... ...
 EQUB &7D, &C7, &D6, &BB, &44, &EF, &54, &BB  ; 912C: 7D C7 D6... }..
 EQUB &12, &FE, &D7, &AB, &32, &28, &38, &FF  ; 9134: 12 FE D7... ...
 EQUB &EE, &EB, &B3, &D7, &4B, &32, &01, &2F  ; 913C: EE EB B3... ...
 EQUB &FE, &FF, &FB, &AB, &EF, &87, &32, &03  ; 9144: FE FF FB... ...
 EQUB &01, &24, &40, &80, &20, &60, &D0, &05  ; 914C: 01 24 40... .$@
 EQUB &80, &B0, &A0, &36, &0F, &15, &01, &0A  ; 9154: 80 B0 A0... ...
 EQUB &01, &05, &02, &34, &13, &03, &03, &01  ; 915C: 01 05 02... ...
 EQUB &04, &21, &3E, &00, &7D, &D3, &FE, &55  ; 9164: 04 21 3E... .!>
 EQUB &62, &B5, &40, &C0, &FE, &FC, &FF, &D7  ; 916C: 62 B5 40... b.@
 EQUB &E3, &76, &82, &AA, &AB, &BB, &BA, &21  ; 9174: E3 76 82... .v.
 EQUB &29, &10, &21, &29, &44, &22, &6C, &7C  ; 917C: 29 10 21... ).!
 EQUB &7D, &EF, &D7, &EE, &F9, &21, &01, &6D  ; 9184: 7D EF D7... }..
 EQUB &96, &EF, &65, &9C, &5A, &32, &05, &07  ; 918C: 96 EF 65... ..e
 EQUB &FF, &6F, &FE, &F6, &9E, &DC, &E0, &50  ; 9194: FF 6F FE... .o.
 EQUB &00, &A0, &00, &40, &02, &90, &22, &80  ; 919C: 00 A0 00... ...
 EQUB &0F, &06, &AA, &54, &E1, &B5, &FA, &B5  ; 91A4: 0F 06 AA... ...
 EQUB &37, &1F, &17, &7F, &3E, &1E, &0E, &0F  ; 91AC: 37 1F 17... 7..
 EQUB &23, &4F, &82, &C6, &BB, &45, &C6, &21  ; 91B4: 23 4F 82... #O.
 EQUB &39, &83, &FF, &C7, &C6, &7C, &32, &38  ; 91BC: 39 83 FF... 9..
 EQUB &01, &C7, &12, &AA, &54, &21, &0E, &5A  ; 91C4: 01 C7 12... ...
 EQUB &BE, &5A, &F0, &D0, &FC, &F8, &F0, &22  ; 91CC: BE 5A F0... .Z.
 EQUB &E0, &23, &E4, &0F, &0F, &02, &7F, &3E  ; 91D4: E0 23 E4... .#.
 EQUB &06, &2F, &13, &16, &09, &02, &00, &0E  ; 91DC: 06 2F 13... ./.
 EQUB &2F, &07, &07, &02, &03, &01, &00, &FF  ; 91E4: 2F 07 07... /..
 EQUB &44, &AB, &EF, &FE, &45, &EE, &BA, &00  ; 91EC: 44 AB EF... D..
 EQUB &45, &C7, &FF, &FE, &45, &EF, &7C, &FC  ; 91F4: 45 C7 FF... E..
 EQUB &C0, &E8, &90, &D0, &20, &80, &00, &E0  ; 91FC: C0 E8 90... ...
 EQUB &E8, &22, &C0, &22, &80, &0F, &0F, &0F  ; 9204: E8 22 C0... .".
 EQUB &0F, &0F, &0F, &08, &3F, &0F, &05, &32  ; 920C: 0F 0F 0F... ...
 EQUB &02, &14, &62, &D4, &04, &34, &01, &0B  ; 9214: 02 14 62... ..b
 EQUB &1D, &2B, &04, &AA, &10, &BA, &10, &04  ; 921C: 1D 2B 04... .+.
 EQUB &7D, &13, &04, &80, &50, &8C, &56, &05  ; 9224: 7D 13 04... }..
 EQUB &A0, &70, &A8, &0F, &01, &3C, &01, &02  ; 922C: A0 70 A8... .p.
 EQUB &03, &02, &07, &04, &00, &06, &00, &01  ; 9234: 03 02 07... ...
 EQUB &00, &01, &04, &AA, &F1, &AA, &D5, &4E  ; 923C: 00 01 04... ...
 EQUB &B1, &6A, &F5, &55, &21, &0E, &55, &00  ; 9244: B1 6A F5... .j.
 EQUB &21, &3F, &71, &EA, &FD, &AA, &21, &01  ; 924C: 21 3F 71... !?q
 EQUB &AA, &45, &BA, &AB, &FE, &55, &7D, &FE  ; 9254: AA 45 BA... .E.
 EQUB &55, &10, &21, &01, &C7, &FE, &55, &AB  ; 925C: 55 10 21... U.!
 EQUB &21, &1E, &AB, &56, &E5, &21, &1A, &BC  ; 9264: 21 1E AB... !..
 EQUB &6E, &54, &E1, &54, &21, &01, &F8, &21  ; 926C: 6E 54 E1... nT.
 EQUB &1C, &BE, &7E, &00, &23, &80, &C0, &40  ; 9274: 1C BE 7E... ..~
 EQUB &00, &C0, &08, &39, &01, &04, &01, &05  ; 927C: 00 C0 08... ...
 EQUB &03, &09, &0D, &17, &00, &24, &01, &33  ; 9284: 03 09 0D... ...
 EQUB &03, &1B, &0B, &EF, &D5, &FF, &8F, &B3  ; 928C: 03 1B 0B... ...
 EQUB &32, &36, &0C, &E0, &FF, &E7, &DF, &EF  ; 9294: 32 36 0C... 26.
 EQUB &F3, &CE, &83, &00, &BB, &55, &45, &FF  ; 929C: F3 CE 83... ...
 EQUB &BB, &C6, &6C, &21, &28, &BB, &FF, &BB  ; 92A4: BB C6 6C... ..l
 EQUB &83, &D7, &AA, &AB, &10, &FF, &6E, &EB  ; 92AC: 83 D7 AA... ...
 EQUB &F3, &57, &CB, &61, &21, &0F, &FE, &FF  ; 92B4: F3 57 CB... .W.
 EQUB &FB, &EB, &6F, &E7, &83, &21, &01, &00  ; 92BC: FB EB 6F... ..o
 EQUB &40, &00, &40, &80, &20, &60, &D0, &05  ; 92C4: 40 00 40... @.@
 EQUB &80, &B0, &A0, &36, &0F, &15, &01, &0A  ; 92CC: 80 B0 A0... ...
 EQUB &01, &05, &02, &34, &13, &03, &03, &01  ; 92D4: 01 05 02... ...
 EQUB &04, &32, &3C, &02, &7D, &D3, &FE, &55  ; 92DC: 04 32 3C... .2<
 EQUB &62, &B5, &40, &C2, &FE, &FC, &FF, &D7  ; 92E4: 62 B5 40... b.@
 EQUB &E3, &76, &82, &AA, &AB, &BB, &10, &21  ; 92EC: E3 76 82... .v.
 EQUB &29, &82, &C7, &44, &22, &6C, &7C, &D7  ; 92F4: 29 82 C7... )..
 EQUB &EF, &C7, &C6, &69, &81, &6D, &96, &EF  ; 92FC: EF C7 C6... ...
 EQUB &65, &9C, &5A, &21, &05, &87, &FF, &6F  ; 9304: 65 9C 5A... e.Z
 EQUB &FE, &F6, &9E, &DC, &E0, &50, &00, &A0  ; 930C: FE F6 9E... ...
 EQUB &00, &40, &02, &90, &22, &80, &0F, &06  ; 9314: 00 40 02... .@.
 EQUB &AA, &54, &E3, &B9, &FA, &B5, &5A, &21  ; 931C: AA 54 E3... .T.
 EQUB &14, &7F, &36, &3E, &1C, &06, &05, &4A  ; 9324: 14 7F 36... ..6
 EQUB &05, &4B, &BA, &44, &C7, &21, &39, &40  ; 932C: 05 4B BA... .K.
 EQUB &21, &29, &54, &AA, &7D, &21, &38, &00  ; 9334: 21 29 54... !)T
 EQUB &C6, &BF, &FE, &21, &21, &75, &AA, &54  ; 933C: C6 BF FE... ...
 EQUB &8E, &21, &3A, &BE, &5A, &B4, &50, &FC  ; 9344: 8E 21 3A... .!:
 EQUB &F8, &70, &C0, &40, &A4, &40, &A4, &0F  ; 934C: F8 70 C0... .p.
 EQUB &0F, &02, &75, &3E, &08, &25, &08, &12  ; 9354: 0F 02 75... ..u
 EQUB &06, &09, &03, &0A, &27, &0B, &07, &05  ; 935C: 06 09 03... ...
 EQUB &01, &02, &00, &55, &AA, &45, &44, &21  ; 9364: 01 02 00... ...
 EQUB &38, &91, &21, &04, &59, &20, &6D, &C7  ; 936C: 38 91 21... 8.!
 EQUB &83, &C7, &6E, &FB, &A6, &21, &3C, &20  ; 9374: 83 C7 6E... ..n
 EQUB &48, &A0, &10, &40, &A0, &80, &C0, &C8  ; 937C: 48 A0 10... H..
 EQUB &A0, &40, &C0, &80, &0F, &0F, &0F, &05  ; 9384: A0 40 C0... .@.
 EQUB &BE, &07, &40, &0F, &0F, &09, &3F, &0F  ; 938C: BE 07 40... ..@
 EQUB &21, &01, &04, &33, &08, &02, &01, &B9  ; 9394: 21 01 04... !..
 EQUB &04, &33, &1C, &06, &33, &C9, &04, &21  ; 939C: 04 33 1C... .3.
 EQUB &1A, &60, &32, &04, &25, &03, &89, &42  ; 93A4: 1A 60 32... .`2
 EQUB &46, &64, &AC, &05, &58, &40, &C6, &05  ; 93AC: 46 64 AC... Fd.
 EQUB &21, &3C, &E0, &8E, &0F, &02, &32, &03  ; 93B4: 21 3C E0... !<.
 EQUB &02, &02, &33, &04, &02, &04, &02, &38  ; 93BC: 02 02 33... ..3
 EQUB &03, &02, &00, &02, &00, &01, &44, &22  ; 93C4: 03 02 00... ...
 EQUB &86, &55, &4E, &B1, &6A, &F5, &6C, &21  ; 93CC: 86 55 4E... .UN
 EQUB &24, &30, &00, &21, &3F, &71, &EA, &FD  ; 93D4: 24 30 00... $0.
 EQUB &FF, &21, &18, &A4, &21, &0D, &82, &AB  ; 93DC: FF 21 18... .!.
 EQUB &FE, &55, &22, &AD, &21, &08, &00, &21  ; 93E4: FE 55 22... .U"
 EQUB &01, &C7, &FE, &55, &10, &90, &21, &25  ; 93EC: 01 C7 FE... ...
 EQUB &52, &E4, &21, &1B, &BC, &6E, &99, &20  ; 93F4: 52 E4 21... R.!
 EQUB &21, &03, &00, &F9, &21, &1C, &BE, &7F  ; 93FC: 21 03 00... !..
 EQUB &04, &80, &00, &C0, &40, &02, &80, &00  ; 9404: 04 80 00... ...
 EQUB &80, &02, &80, &3E, &05, &03, &01, &07  ; 940C: 80 02 80... ...
 EQUB &03, &09, &0D, &17, &03, &07, &07, &03  ; 9414: 03 09 0D... ...
 EQUB &01, &03, &32, &1B, &0B, &EF, &DE, &FF  ; 941C: 01 03 32... ..2
 EQUB &9F, &DA, &67, &21, &06, &D0, &FF, &EF  ; 9424: 9F DA 67... ..g
 EQUB &DF, &FF, &BA, &8F, &81, &20, &BB, &D6  ; 942C: DF FF BA... ...
 EQUB &21, &01, &AB, &92, &C7, &22, &6C, &BB  ; 9434: 21 01 AB... !..
 EQUB &12, &D7, &FE, &22, &AB, &10, &FF, &EF  ; 943C: 12 D7 FE... ...
 EQUB &EB, &F3, &B7, &CB, &C1, &21, &0F, &12  ; 9444: EB F3 B7... ...
 EQUB &FB, &EB, &AF, &E7, &32, &03, &01, &80  ; 944C: FB EB AF... ...
 EQUB &00, &80, &40, &80, &20, &60, &D0, &23  ; 9454: 00 80 40... ..@
 EQUB &C0, &80, &00, &80, &B0, &A0, &36, &0F  ; 945C: C0 80 00... ...
 EQUB &15, &01, &0A, &01, &05, &02, &34, &13  ; 9464: 15 01 0A... ...
 EQUB &03, &03, &01, &04, &21, &3C, &00, &7D  ; 946C: 03 03 01... ...
 EQUB &D3, &FE, &55, &62, &B5, &40, &C0, &FE  ; 9474: D3 FE 55... ..U
 EQUB &FC, &FF, &D7, &E3, &76, &82, &AA, &AB  ; 947C: FC FF D7... ...
 EQUB &BB, &BA, &32, &11, &28, &83, &44, &22  ; 9484: BB BA 32... ..2
 EQUB &6C, &7C, &7D, &D7, &EF, &C6, &69, &21  ; 948C: 6C 7C 7D... l|}
 EQUB &01, &6D, &96, &EF, &65, &9C, &5A, &32  ; 9494: 01 6D 96... .m.
 EQUB &05, &07, &FF, &6F, &FE, &F6, &9E, &DC  ; 949C: 05 07 FF... ...
 EQUB &E0, &50, &00, &A0, &00, &40, &02, &90  ; 94A4: E0 50 00... .P.
 EQUB &22, &80, &0F, &06, &AA, &54, &E3, &B9  ; 94AC: 22 80 0F... "..
 EQUB &FA, &B5, &37, &13, &14, &7F, &3E, &1C  ; 94B4: FA B5 37... ..7
 EQUB &06, &07, &22, &4F, &4E, &C6, &BA, &45  ; 94BC: 06 07 22... .."
 EQUB &C7, &32, &38, &01, &FF, &AA, &C7, &7C  ; 94C4: C7 32 38... .28
 EQUB &21, &38, &00, &C7, &12, &6C, &AA, &54  ; 94CC: 21 38 00... !8.
 EQUB &8E, &21, &3A, &BE, &5A, &90, &50, &FC  ; 94D4: 8E 21 3A... .!:
 EQUB &F8, &70, &22, &C0, &23, &E4, &0F, &0F  ; 94DC: F8 70 22... .p"
 EQUB &02, &72, &3E, &07, &2B, &11, &16, &09  ; 94E4: 02 72 3E... .r>
 EQUB &02, &00, &0F, &2F, &07, &07, &03, &03  ; 94EC: 02 00 0F... ...
 EQUB &01, &00, &D6, &22, &45, &C7, &EE, &55  ; 94F4: 01 00 D6... ...
 EQUB &AA, &92, &21, &39, &45, &83, &14, &7C  ; 94FC: AA 92 21... ..!
 EQUB &9C, &C0, &A8, &10, &D0, &20, &80, &00  ; 9504: 9C C0 A8... ...
 EQUB &E0, &E8, &22, &C0, &22, &80, &0F, &0F  ; 950C: E0 E8 22... .."
 EQUB &0F, &0F, &0F, &0F, &08, &3F, &0E, &00  ; 9514: 0F 0F 0F... ...
 EQUB &1E, &00, &95, &01, &10, &03, &7D, &04  ; 951C: 1E 00 95... ...
 EQUB &11, &06, &A4, &07, &2C, &09, &AC, &0A  ; 9524: 11 06 A4... ...
 EQUB &28, &0C, &9F, &0D, &27, &0F, &C9, &10  ; 952C: 28 0C 9F... (..
 EQUB &40, &12, &D6, &13, &1D, &FC, &F0, &E0  ; 9534: 40 12 D6... @..
 EQUB &13, &E0, &04, &13, &32, &0F, &01, &03  ; 953C: 13 E0 04... ...
 EQUB &15, &7F, &32, &1F, &0F, &1F, &11, &22  ; 9544: 15 7F 32... ..2
 EQUB &C0, &23, &80, &0F, &04, &22, &07, &23  ; 954C: C0 23 80... .#.
 EQUB &03, &21, &01, &81, &21, &01, &1D, &FE  ; 9554: 03 21 01... .!.
 EQUB &22, &FC, &0D, &21, &01, &00, &32, &01  ; 955C: 22 FC 0D... "..
 EQUB &02, &00, &20, &05, &25, &01, &03, &16  ; 9564: 02 00 20... ..
 EQUB &22, &7F, &22, &FC, &22, &FE, &14, &22  ; 956C: 22 7F 22... "."
 EQUB &01, &03, &21, &02, &81, &C0, &00, &32  ; 9574: 01 03 21... ..!
 EQUB &21, &01, &02, &81, &C2, &81, &32, &01  ; 957C: 21 01 02... !..
 EQUB &09, &03, &21, &02, &87, &21, &02, &04  ; 9584: 09 03 21... ..!
 EQUB &21, &01, &81, &32, &03, &07, &22, &7F  ; 958C: 21 01 81... !..
 EQUB &1E, &28, &E0, &22, &03, &06, &22, &80  ; 9594: 1E 28 E0... .(.
 EQUB &06, &28, &0F, &1A, &00, &A0, &D7, &13  ; 959C: 06 28 0F... .(.
 EQUB &C0, &00, &22, &20, &60, &22, &E0, &B0  ; 95A4: C0 00 22... .."
 EQUB &00, &21, &05, &02, &10, &32, &0B, &01  ; 95AC: 00 21 05... .!.
 EQUB &02, &40, &02, &10, &A0, &02, &38, &07  ; 95B4: 02 40 02... .@.
 EQUB &01, &08, &08, &0D, &0F, &0F, &1B, &12  ; 95BC: 01 08 08... ...
 EQUB &00, &21, &0A, &D7, &14, &F7, &EE, &75  ; 95C4: 00 21 0A... .!.
 EQUB &AA, &55, &21, &22, &48, &B0, &DC, &CF  ; 95CC: AA 55 21... .U!
 EQUB &C3, &A0, &C0, &90, &44, &03, &E0, &7F  ; 95D4: C3 A0 C0... ...
 EQUB &21, &0F, &04, &32, &01, &0F, &FC, &E0  ; 95DC: 21 0F 04... !..
 EQUB &02, &21, &1B, &77, &E6, &87, &33, &0A  ; 95E4: 02 21 1B... .!.
 EQUB &07, &12, &44, &FF, &DF, &EF, &5D, &AA  ; 95EC: 07 12 44... ..D
 EQUB &55, &88, &34, &25, &02, &00, &01, &40  ; 95F4: 55 88 34... U.4
 EQUB &04, &AA, &40, &21, &0A, &20, &21, &0A  ; 95FC: 04 AA 40... ..@
 EQUB &04, &40, &80, &21, &08, &A0, &00, &20  ; 9604: 04 40 80... .@.
 EQUB &02, &36, &04, &02, &20, &0A, &00, &08  ; 960C: 02 36 04... .6.
 EQUB &00, &AA, &21, &04, &A1, &21, &08, &A0  ; 9614: 00 AA 21... ..!
 EQUB &03, &80, &02, &21, &05, &04, &3F, &0F  ; 961C: 03 80 02... ...
 EQUB &0F, &0F, &0F, &0F, &0B, &80, &0F, &0F  ; 9624: 0F 0F 0F... ...
 EQUB &21, &01, &00, &32, &01, &02, &00, &20  ; 962C: 21 01 00... !..
 EQUB &0F, &0E, &22, &01, &03, &32, &02, &01  ; 9634: 0F 0E 22... .."
 EQUB &02, &32, &21, &01, &02, &81, &C2, &81  ; 963C: 02 32 21... .2!
 EQUB &32, &01, &09, &03, &21, &02, &87, &21  ; 9644: 32 01 09... 2..
 EQUB &02, &05, &80, &0F, &0B, &22, &03, &06  ; 964C: 02 05 80... ...
 EQUB &22, &80, &0F, &0A, &15, &02, &23, &E0  ; 9654: 22 80 0F... "..
 EQUB &23, &F0, &00, &21, &05, &02, &10, &32  ; 965C: 23 F0 00... #..
 EQUB &0B, &01, &02, &40, &02, &10, &A0, &04  ; 9664: 0B 01 02... ...
 EQUB &33, &0E, &0F, &0F, &23, &1F, &03, &1D  ; 966C: 33 0E 0F... 3..
 EQUB &F8, &FE, &12, &F7, &FD, &12, &02, &C0  ; 9674: F8 FE 12... ...
 EQUB &13, &21, &1F, &F0, &02, &21, &07, &13  ; 967C: 13 21 1F... .!.
 EQUB &F1, &32, &1F, &3F, &13, &DF, &7F, &1C  ; 9684: F1 32 1F... .2.
 EQUB &EF, &F7, &FB, &F1, &F8, &71, &15, &7F  ; 968C: EF F7 FB... ...
 EQUB &21, &2F, &56, &FC, &FE, &FF, &FE, &FF  ; 9694: 21 2F 56... !/V
 EQUB &FE, &FF, &FE, &7F, &16, &FE, &15, &FD  ; 969C: FE FF FE... ...
 EQUB &E8, &D5, &12, &EF, &DF, &BF, &33, &1F  ; 96A4: E8 D5 12... ...
 EQUB &3F, &1E, &3F, &1D, &FC, &F0, &E0, &13  ; 96AC: 3F 1E 3F... ?.?
 EQUB &E0, &04, &13, &32, &0F, &01, &03, &15  ; 96B4: E0 04 13... ...
 EQUB &7F, &32, &1F, &0F, &1F, &11, &22, &C0  ; 96BC: 7F 32 1F... .2.
 EQUB &23, &80, &0F, &04, &22, &07, &23, &03  ; 96C4: 23 80 0F... #..
 EQUB &21, &01, &81, &21, &01, &1D, &FE, &22  ; 96CC: 21 01 81... !..
 EQUB &FC, &0D, &21, &01, &00, &81, &21, &02  ; 96D4: FC 0D 21... ..!
 EQUB &00, &20, &04, &31, &02, &25, &01, &03  ; 96DC: 00 20 04... . .
 EQUB &16, &22, &7F, &22, &FC, &22, &FE, &14  ; 96E4: 16 22 7F... .".
 EQUB &22, &01, &03, &21, &02, &81, &C0, &20  ; 96EC: 22 01 03... "..
 EQUB &32, &21, &01, &02, &81, &C2, &81, &22  ; 96F4: 32 21 01... 2!.
 EQUB &09, &03, &21, &02, &87, &21, &02, &04  ; 96FC: 09 03 21... ..!
 EQUB &21, &01, &81, &32, &03, &07, &22, &7F  ; 9704: 21 01 81... !..
 EQUB &1E, &28, &E0, &22, &03, &06, &22, &80  ; 970C: 1E 28 E0... .(.
 EQUB &06, &28, &0F, &1A, &00, &A0, &D7, &13  ; 9714: 06 28 0F... .(.
 EQUB &C0, &00, &22, &20, &60, &22, &E0, &B0  ; 971C: C0 00 22... .."
 EQUB &00, &21, &0B, &02, &10, &32, &0B, &01  ; 9724: 00 21 0B... .!.
 EQUB &02, &A0, &02, &10, &A0, &02, &38, &07  ; 972C: 02 A0 02... ...
 EQUB &01, &08, &08, &0D, &0F, &0F, &1B, &12  ; 9734: 01 08 08... ...
 EQUB &00, &21, &0A, &D7, &14, &F7, &EE, &75  ; 973C: 00 21 0A... .!.
 EQUB &AA, &55, &21, &22, &48, &B0, &DC, &CF  ; 9744: AA 55 21... .U!
 EQUB &C3, &A0, &C0, &90, &44, &03, &E0, &7F  ; 974C: C3 A0 C0... ...
 EQUB &21, &0F, &04, &32, &01, &0F, &FC, &E0  ; 9754: 21 0F 04... !..
 EQUB &02, &21, &1B, &77, &E6, &87, &33, &0A  ; 975C: 02 21 1B... .!.
 EQUB &07, &12, &44, &FF, &DF, &EF, &5D, &AA  ; 9764: 07 12 44... ..D
 EQUB &55, &88, &34, &25, &02, &00, &01, &40  ; 976C: 55 88 34... U.4
 EQUB &04, &AA, &40, &21, &0A, &20, &21, &0A  ; 9774: 04 AA 40... ..@
 EQUB &04, &40, &80, &21, &08, &A0, &00, &20  ; 977C: 04 40 80... .@.
 EQUB &02, &36, &04, &02, &20, &0A, &00, &08  ; 9784: 02 36 04... .6.
 EQUB &00, &AA, &21, &04, &A1, &21, &08, &A0  ; 978C: 00 AA 21... ..!
 EQUB &03, &80, &02, &21, &05, &04, &3F, &0F  ; 9794: 03 80 02... ...
 EQUB &0F, &0F, &0F, &0F, &0B, &80, &0F, &0F  ; 979C: 0F 0F 0F... ...
 EQUB &21, &01, &00, &81, &21, &02, &00, &20  ; 97A4: 21 01 00... !..
 EQUB &04, &21, &02, &0F, &09, &22, &01, &03  ; 97AC: 04 21 02... .!.
 EQUB &32, &02, &01, &00, &20, &32, &21, &01  ; 97B4: 32 02 01... 2..
 EQUB &02, &81, &C2, &81, &22, &09, &03, &21  ; 97BC: 02 81 C2... ...
 EQUB &02, &87, &21, &02, &05, &80, &0F, &0B  ; 97C4: 02 87 21... ..!
 EQUB &22, &03, &06, &22, &80, &0F, &0A, &15  ; 97CC: 22 03 06... "..
 EQUB &02, &23, &E0, &23, &F0, &00, &21, &0B  ; 97D4: 02 23 E0... .#.
 EQUB &02, &10, &32, &0B, &01, &02, &A0, &02  ; 97DC: 02 10 32... ..2
 EQUB &10, &A0, &04, &33, &0E, &0F, &0F, &23  ; 97E4: 10 A0 04... ...
 EQUB &1F, &03, &1D, &F8, &FE, &12, &F7, &FD  ; 97EC: 1F 03 1D... ...
 EQUB &12, &02, &C0, &13, &21, &1F, &F0, &02  ; 97F4: 12 02 C0... ...
 EQUB &21, &07, &13, &F1, &32, &1F, &3F, &13  ; 97FC: 21 07 13... !..
 EQUB &DF, &7F, &1C, &EF, &F7, &FB, &F1, &F8  ; 9804: DF 7F 1C... ...
 EQUB &71, &15, &7F, &21, &2F, &56, &FC, &FE  ; 980C: 71 15 7F... q..
 EQUB &FF, &FE, &FF, &FE, &FF, &FE, &7F, &16  ; 9814: FF FE FF... ...
 EQUB &FE, &15, &FD, &E8, &D5, &12, &EF, &DF  ; 981C: FE 15 FD... ...
 EQUB &BF, &33, &1F, &3F, &1E, &3F, &1D, &FC  ; 9824: BF 33 1F... .3.
 EQUB &F0, &E0, &13, &E0, &04, &13, &32, &0F  ; 982C: F0 E0 13... ...
 EQUB &01, &03, &15, &7F, &32, &1F, &0F, &1F  ; 9834: 01 03 15... ...
 EQUB &11, &22, &C0, &23, &80, &0F, &04, &22  ; 983C: 11 22 C0... .".
 EQUB &07, &23, &03, &21, &01, &81, &21, &01  ; 9844: 07 23 03... .#.
 EQUB &1D, &FE, &22, &FC, &0B, &B0, &00, &22  ; 984C: 1D FE 22... .."
 EQUB &01, &04, &21, &1A, &04, &25, &01, &03  ; 9854: 01 04 21... ..!
 EQUB &16, &22, &7F, &22, &FC, &22, &FE, &14  ; 985C: 16 22 7F... .".
 EQUB &04, &32, &02, &01, &80, &C0, &00, &21  ; 9864: 04 32 02... .2.
 EQUB &01, &02, &81, &C2, &81, &21, &03, &04  ; 986C: 01 02 81... ...
 EQUB &21, &02, &87, &21, &02, &80, &04, &81  ; 9874: 21 02 87... !..
 EQUB &33, &01, &03, &07, &22, &7F, &1E, &28  ; 987C: 33 01 03... 3..
 EQUB &E0, &21, &03, &07, &80, &07, &28, &0F  ; 9884: E0 21 03... .!.
 EQUB &1A, &00, &A0, &D7, &13, &C0, &00, &22  ; 988C: 1A 00 A0... ...
 EQUB &20, &60, &22, &E0, &B0, &00, &21, &03  ; 9894: 20 60 22...  `"
 EQUB &02, &10, &32, &0B, &01, &02, &80, &02  ; 989C: 02 10 32... ..2
 EQUB &10, &A0, &02, &38, &07, &01, &08, &08  ; 98A4: 10 A0 02... ...
 EQUB &0D, &0F, &0F, &1B, &12, &00, &21, &0A  ; 98AC: 0D 0F 0F... ...
 EQUB &D7, &14, &F7, &EE, &75, &AA, &55, &21  ; 98B4: D7 14 F7... ...
 EQUB &22, &48, &B0, &DC, &CF, &C3, &A0, &C0  ; 98BC: 22 48 B0... "H.
 EQUB &90, &44, &03, &E0, &7F, &21, &0F, &04  ; 98C4: 90 44 03... .D.
 EQUB &32, &01, &0F, &FC, &E0, &02, &21, &1B  ; 98CC: 32 01 0F... 2..
 EQUB &77, &E6, &87, &33, &0A, &07, &12, &44  ; 98D4: 77 E6 87... w..
 EQUB &FF, &DF, &EF, &5D, &AA, &55, &88, &34  ; 98DC: FF DF EF... ...
 EQUB &25, &02, &00, &01, &40, &04, &AA, &40  ; 98E4: 25 02 00... %..
 EQUB &21, &0A, &20, &21, &0A, &04, &40, &80  ; 98EC: 21 0A 20... !.
 EQUB &21, &08, &A0, &00, &20, &02, &36, &04  ; 98F4: 21 08 A0... !..
 EQUB &02, &20, &0A, &00, &08, &00, &AA, &21  ; 98FC: 02 20 0A... . .
 EQUB &04, &A1, &21, &08, &A0, &03, &80, &02  ; 9904: 04 A1 21... ..!
 EQUB &21, &05, &04, &3F, &0F, &0F, &0F, &0F  ; 990C: 21 05 04... !..
 EQUB &0F, &0B, &80, &0F, &0D, &B0, &00, &22  ; 9914: 0F 0B 80... ...
 EQUB &01, &04, &21, &1A, &0F, &0F, &02, &32  ; 991C: 01 04 21... ..!
 EQUB &02, &01, &03, &21, &01, &02, &81, &C2  ; 9924: 02 01 03... ...
 EQUB &81, &21, &03, &04, &21, &02, &87, &21  ; 992C: 81 21 03... .!.
 EQUB &02, &80, &04, &80, &0F, &0C, &21, &03  ; 9934: 02 80 04... ...
 EQUB &07, &80, &0F, &0B, &15, &02, &23, &E0  ; 993C: 07 80 0F... ...
 EQUB &23, &F0, &00, &21, &03, &02, &10, &32  ; 9944: 23 F0 00... #..
 EQUB &0B, &01, &02, &80, &02, &10, &A0, &04  ; 994C: 0B 01 02... ...
 EQUB &33, &0E, &0F, &0F, &23, &1F, &03, &1D  ; 9954: 33 0E 0F... 3..
 EQUB &F8, &FE, &12, &F7, &FD, &12, &02, &C0  ; 995C: F8 FE 12... ...
 EQUB &13, &21, &1F, &F0, &02, &21, &07, &13  ; 9964: 13 21 1F... .!.
 EQUB &F1, &32, &1F, &3F, &13, &DF, &7F, &1C  ; 996C: F1 32 1F... .2.
 EQUB &EF, &F7, &FB, &F1, &F8, &71, &15, &7F  ; 9974: EF F7 FB... ...
 EQUB &21, &2F, &56, &FC, &FE, &FF, &FE, &FF  ; 997C: 21 2F 56... !/V
 EQUB &FE, &FF, &FE, &7F, &16, &FE, &15, &FD  ; 9984: FE FF FE... ...
 EQUB &E8, &D5, &12, &EF, &DF, &BF, &33, &1F  ; 998C: E8 D5 12... ...
 EQUB &3F, &1E, &3F, &1B, &FE, &22, &FC, &E0  ; 9994: 3F 1E 3F... ?.?
 EQUB &C0, &12, &F7, &20, &04, &12, &6F, &21  ; 999C: C0 12 F7... ...
 EQUB &07, &04, &14, &34, &3F, &1F, &1F, &0F  ; 99A4: 07 04 14... ...
 EQUB &1F, &11, &C0, &24, &80, &00, &21, &01  ; 99AC: 1F 11 C0... ...
 EQUB &06, &E0, &50, &21, &2A, &05, &35, &0E  ; 99B4: 06 E0 50... ..P
 EQUB &15, &A8, &07, &07, &23, &03, &23, &01  ; 99BC: 15 A8 07... ...
 EQUB &1D, &FE, &22, &FC, &08, &84, &00, &21  ; 99C4: 1D FE 22... .."
 EQUB &13, &02, &21, &01, &00, &21, &01, &42  ; 99CC: 13 02 21... ..!
 EQUB &00, &90, &05, &25, &01, &03, &16, &22  ; 99D4: 00 90 05... ...
 EQUB &7F, &22, &FC, &22, &FE, &14, &00, &21  ; 99DC: 7F 22 FC... .".
 EQUB &01, &03, &21, &02, &81, &C0, &00, &32  ; 99E4: 01 03 21... ..!
 EQUB &21, &01, &02, &81, &C2, &81, &00, &21  ; 99EC: 21 01 02... !..
 EQUB &09, &03, &21, &02, &87, &21, &02, &04  ; 99F4: 09 03 21... ..!
 EQUB &21, &01, &81, &32, &03, &07, &22, &7F  ; 99FC: 21 01 81... !..
 EQUB &1E, &28, &E0, &22, &03, &06, &22, &80  ; 9A04: 1E 28 E0... .(.
 EQUB &06, &28, &0F, &18, &21, &01, &F9, &22  ; 9A0C: 06 28 0F... .(.
 EQUB &F8, &FF, &FB, &12, &C0, &02, &20, &00  ; 9A14: F8 FF FB... ...
 EQUB &A0, &80, &B0, &00, &21, &05, &07, &40  ; 9A1C: A0 80 B0... ...
 EQUB &06, &39, &07, &01, &00, &08, &01, &0B  ; 9A24: 06 39 07... .9.
 EQUB &03, &1B, &00, &23, &3F, &FF, &BF, &12  ; 9A2C: 03 1B 00... ...
 EQUB &FB, &FF, &FA, &F9, &FA, &F9, &F2, &E1  ; 9A34: FB FF FA... ...
 EQUB &A0, &CC, &CB, &C3, &E0, &F0, &F8, &7E  ; 9A3C: A0 CC CB... ...
 EQUB &03, &60, &6F, &21, &0F, &04, &32, &01  ; 9A44: 03 60 6F... .`o
 EQUB &0D, &EC, &E0, &02, &21, &0B, &67, &A6  ; 9A4C: 0D EC E0... ...
 EQUB &87, &33, &0E, &1F, &3E, &FD, &BF, &FF  ; 9A54: 87 33 0E... .3.
 EQUB &BF, &21, &3F, &BF, &21, &3F, &9F, &34  ; 9A5C: BF 21 3F... .!?
 EQUB &0F, &02, &00, &01, &05, &BF, &57, &33  ; 9A64: 0F 02 00... ...
 EQUB &2A, &05, &12, &03, &80, &F0, &AA, &5D  ; 9A6C: 2A 05 12... *..
 EQUB &8A, &21, &21, &02, &32, &03, &1F, &AA  ; 9A74: 8A 21 21... .!!
 EQUB &75, &A2, &21, &08, &02, &FA, &D4, &A9  ; 9A7C: 75 A2 21... u.!
 EQUB &40, &90, &03, &80, &07, &3F, &0F, &0F  ; 9A84: 40 90 03... @..
 EQUB &0F, &0F, &02, &21, &01, &06, &E0, &50  ; 9A8C: 0F 0F 02... ...
 EQUB &21, &2A, &05, &32, &0E, &15, &A8, &0F  ; 9A94: 21 2A 05... !*.
 EQUB &0F, &02, &84, &00, &21, &13, &02, &21  ; 9A9C: 0F 02 84... ...
 EQUB &01, &00, &21, &01, &42, &00, &90, &0F  ; 9AA4: 01 00 21... ..!
 EQUB &0F, &21, &01, &03, &32, &02, &01, &02  ; 9AAC: 0F 21 01... .!.
 EQUB &32, &21, &01, &02, &81, &C2, &81, &00  ; 9AB4: 32 21 01... 2!.
 EQUB &21, &09, &03, &21, &02, &87, &21, &02  ; 9ABC: 21 09 03... !..
 EQUB &05, &80, &0F, &0B, &22, &03, &06, &22  ; 9AC4: 05 80 0F... ...
 EQUB &80, &0F, &08, &22, &FC, &15, &02, &A0  ; 9ACC: 80 0F 08... ...
 EQUB &E0, &A0, &F0, &B0, &F0, &00, &21, &05  ; 9AD4: E0 A0 F0... ...
 EQUB &07, &40, &08, &36, &0A, &0F, &0B, &1F  ; 9ADC: 07 40 08... .@.
 EQUB &1B, &1F, &00, &22, &7F, &1A, &22, &FB  ; 9AE4: 1B 1F 00... ...
 EQUB &F7, &F8, &FE, &EF, &EB, &F3, &FD, &12  ; 9AEC: F7 F8 FE... ...
 EQUB &03, &EF, &7F, &6F, &21, &0F, &F0, &02  ; 9AF4: 03 EF 7F... ...
 EQUB &21, &01, &EF, &FD, &ED, &E1, &32, &1F  ; 9AFC: 21 01 EF... !..
 EQUB &3F, &FF, &EF, &AF, &9F, &7F, &17, &22  ; 9B04: 3F FF EF... ?..
 EQUB &BF, &DF, &E7, &22, &0F, &57, &FB, &F1  ; 9B0C: BF DF E7... ...
 EQUB &F8, &F1, &15, &7F, &21, &2F, &56, &1F  ; 9B14: F8 F1 15... ...
 EQUB &FE, &15, &FD, &E8, &D5, &CF, &22, &E0  ; 9B1C: FE 15 FD... ...
 EQUB &D5, &BF, &33, &1F, &3F, &1E, &3F, &1B  ; 9B24: D5 BF 33... ..3
 EQUB &FE, &22, &FC, &E0, &C0, &12, &F7, &20  ; 9B2C: FE 22 FC... .".
 EQUB &04, &12, &6F, &21, &07, &04, &14, &34  ; 9B34: 04 12 6F... ..o
 EQUB &3F, &1F, &1F, &0F, &1F, &11, &C0, &24  ; 9B3C: 3F 1F 1F... ?..
 EQUB &80, &00, &21, &01, &06, &E0, &50, &21  ; 9B44: 80 00 21... ..!
 EQUB &2A, &05, &35, &0E, &15, &A8, &07, &07  ; 9B4C: 2A 05 35... *.5
 EQUB &23, &03, &23, &01, &1D, &FE, &22, &FC  ; 9B54: 23 03 23... #.#
 EQUB &08, &84, &00, &21, &0B, &02, &21, &01  ; 9B5C: 08 84 00... ...
 EQUB &00, &21, &01, &42, &00, &A0, &05, &25  ; 9B64: 00 21 01... .!.
 EQUB &01, &03, &16, &22, &7F, &22, &FC, &22  ; 9B6C: 01 03 16... ...
 EQUB &FE, &14, &22, &01, &03, &21, &02, &81  ; 9B74: FE 14 22... .."
 EQUB &C0, &00, &32, &21, &01, &02, &81, &C2  ; 9B7C: C0 00 32... ..2
 EQUB &81, &32, &01, &09, &03, &21, &02, &87  ; 9B84: 81 32 01... .2.
 EQUB &21, &02, &04, &21, &01, &81, &32, &03  ; 9B8C: 21 02 04... !..
 EQUB &07, &22, &7F, &1E, &28, &E0, &22, &03  ; 9B94: 07 22 7F... .".
 EQUB &06, &22, &80, &06, &28, &0F, &18, &21  ; 9B9C: 06 22 80... .".
 EQUB &01, &F9, &22, &F8, &FF, &FB, &12, &C0  ; 9BA4: 01 F9 22... .."
 EQUB &02, &20, &00, &A0, &80, &B0, &00, &21  ; 9BAC: 02 20 00... . .
 EQUB &0B, &07, &A0, &06, &39, &07, &01, &00  ; 9BB4: 0B 07 A0... ...
 EQUB &08, &01, &0B, &03, &1B, &00, &23, &3F  ; 9BBC: 08 01 0B... ...
 EQUB &FF, &BF, &12, &FB, &FF, &FA, &F9, &FA  ; 9BC4: FF BF 12... ...
 EQUB &F9, &F2, &E1, &A0, &CC, &CB, &C3, &E0  ; 9BCC: F9 F2 E1... ...
 EQUB &F0, &F8, &7E, &03, &60, &6F, &21, &0F  ; 9BD4: F0 F8 7E... ..~
 EQUB &04, &32, &01, &0D, &EC, &E0, &02, &21  ; 9BDC: 04 32 01... .2.
 EQUB &0B, &67, &A6, &87, &33, &0E, &1F, &3E  ; 9BE4: 0B 67 A6... .g.
 EQUB &FD, &BF, &FF, &BF, &21, &3F, &BF, &21  ; 9BEC: FD BF FF... ...
 EQUB &3F, &9F, &34, &0F, &02, &00, &01, &05  ; 9BF4: 3F 9F 34... ?.4
 EQUB &BF, &57, &33, &2A, &05, &12, &03, &80  ; 9BFC: BF 57 33... .W3
 EQUB &F0, &AA, &5D, &8A, &21, &21, &02, &32  ; 9C04: F0 AA 5D... ..]
 EQUB &03, &1F, &AA, &75, &A2, &21, &08, &02  ; 9C0C: 03 1F AA... ...
 EQUB &FA, &D4, &A9, &40, &90, &03, &80, &07  ; 9C14: FA D4 A9... ...
 EQUB &3F, &0F, &0F, &0F, &0F, &02, &21, &01  ; 9C1C: 3F 0F 0F... ?..
 EQUB &06, &E0, &50, &21, &2A, &05, &32, &0E  ; 9C24: 06 E0 50... ..P
 EQUB &15, &A8, &0F, &0F, &02, &84, &00, &21  ; 9C2C: 15 A8 0F... ...
 EQUB &0B, &02, &21, &01, &00, &21, &01, &42  ; 9C34: 0B 02 21... ..!
 EQUB &00, &A0, &0F, &0E, &22, &01, &03, &32  ; 9C3C: 00 A0 0F... ...
 EQUB &02, &01, &02, &32, &21, &01, &02, &81  ; 9C44: 02 01 02... ...
 EQUB &C2, &81, &32, &01, &09, &03, &21, &02  ; 9C4C: C2 81 32... ..2
 EQUB &87, &21, &02, &05, &80, &0F, &0B, &22  ; 9C54: 87 21 02... .!.
 EQUB &03, &06, &22, &80, &0F, &08, &22, &FC  ; 9C5C: 03 06 22... .."
 EQUB &15, &02, &A0, &E0, &A0, &F0, &B0, &F0  ; 9C64: 15 02 A0... ...
 EQUB &00, &21, &0B, &07, &A0, &08, &36, &0A  ; 9C6C: 00 21 0B... .!.
 EQUB &0F, &0B, &1F, &1B, &1F, &00, &22, &7F  ; 9C74: 0F 0B 1F... ...
 EQUB &1A, &22, &FB, &F7, &F8, &FE, &EF, &EB  ; 9C7C: 1A 22 FB... .".
 EQUB &F3, &FD, &12, &03, &EF, &7F, &6F, &21  ; 9C84: F3 FD 12... ...
 EQUB &0F, &F0, &02, &21, &01, &EF, &FD, &ED  ; 9C8C: 0F F0 02... ...
 EQUB &E1, &32, &1F, &3F, &FF, &EF, &AF, &9F  ; 9C94: E1 32 1F... .2.
 EQUB &7F, &17, &22, &BF, &DF, &E7, &22, &0F  ; 9C9C: 7F 17 22... .."
 EQUB &57, &FB, &F1, &F8, &F1, &15, &7F, &21  ; 9CA4: 57 FB F1... W..
 EQUB &2F, &56, &1F, &FE, &15, &FD, &E8, &D5  ; 9CAC: 2F 56 1F... /V.
 EQUB &CF, &22, &E0, &D5, &BF, &33, &1F, &3F  ; 9CB4: CF 22 E0... .".
 EQUB &1E, &3F, &1B, &FE, &22, &FC, &E0, &C0  ; 9CBC: 1E 3F 1B... .?.
 EQUB &12, &F7, &20, &04, &12, &6F, &21, &07  ; 9CC4: 12 F7 20... ..
 EQUB &04, &14, &34, &3F, &1F, &1F, &0F, &1F  ; 9CCC: 04 14 34... ..4
 EQUB &11, &C0, &24, &80, &00, &21, &01, &06  ; 9CD4: 11 C0 24... ..$
 EQUB &E0, &50, &21, &2A, &05, &35, &0E, &15  ; 9CDC: E0 50 21... .P!
 EQUB &A8, &07, &07, &23, &03, &23, &01, &1D  ; 9CE4: A8 07 07... ...
 EQUB &FE, &22, &FC, &08, &21, &04, &02, &B0  ; 9CEC: FE 22 FC... .".
 EQUB &00, &22, &01, &00, &40, &06, &31, &02  ; 9CF4: 00 22 01... .".
 EQUB &25, &01, &03, &16, &22, &7F, &22, &FC  ; 9CFC: 25 01 03... %..
 EQUB &22, &FE, &14, &04, &32, &02, &01, &80  ; 9D04: 22 FE 14... "..
 EQUB &C0, &00, &21, &01, &02, &81, &C2, &81  ; 9D0C: C0 00 21... ..!
 EQUB &33, &03, &09, &09, &03, &82, &21, &07  ; 9D14: 33 03 09... 3..
 EQUB &82, &04, &21, &01, &81, &32, &03, &07  ; 9D1C: 82 04 21... ..!
 EQUB &22, &7F, &1E, &28, &E0, &21, &03, &07  ; 9D24: 22 7F 1E... "..
 EQUB &80, &07, &28, &0F, &18, &21, &01, &F9  ; 9D2C: 80 07 28... ..(
 EQUB &22, &F8, &FF, &FB, &12, &C0, &02, &20  ; 9D34: 22 F8 FF... "..
 EQUB &00, &A0, &80, &B0, &00, &21, &03, &07  ; 9D3C: 00 A0 80... ...
 EQUB &80, &06, &39, &07, &01, &00, &08, &01  ; 9D44: 80 06 39... ..9
 EQUB &0B, &03, &1B, &00, &23, &3F, &FF, &BF  ; 9D4C: 0B 03 1B... ...
 EQUB &12, &FB, &FF, &FA, &F9, &FA, &F9, &F2  ; 9D54: 12 FB FF... ...
 EQUB &E1, &A0, &CC, &CB, &C3, &E0, &F0, &F8  ; 9D5C: E1 A0 CC... ...
 EQUB &7E, &03, &60, &6F, &21, &0F, &04, &32  ; 9D64: 7E 03 60... ~.`
 EQUB &01, &0D, &EC, &E0, &02, &21, &0B, &67  ; 9D6C: 01 0D EC... ...
 EQUB &A6, &87, &33, &0E, &1F, &3E, &FD, &BF  ; 9D74: A6 87 33... ..3
 EQUB &FF, &BF, &21, &3F, &BF, &21, &3F, &9F  ; 9D7C: FF BF 21... ..!
 EQUB &34, &0F, &02, &00, &01, &05, &BF, &57  ; 9D84: 34 0F 02... 4..
 EQUB &33, &2A, &05, &12, &03, &80, &F0, &AA  ; 9D8C: 33 2A 05... 3*.
 EQUB &5D, &8A, &21, &21, &02, &32, &03, &1F  ; 9D94: 5D 8A 21... ].!
 EQUB &AA, &75, &A2, &21, &08, &02, &FA, &D4  ; 9D9C: AA 75 A2... .u.
 EQUB &A9, &40, &90, &03, &80, &07, &3F, &0F  ; 9DA4: A9 40 90... .@.
 EQUB &0F, &0F, &0F, &02, &21, &01, &06, &E0  ; 9DAC: 0F 0F 0F... ...
 EQUB &50, &21, &2A, &05, &32, &0E, &15, &A8  ; 9DB4: 50 21 2A... P!*
 EQUB &0F, &0F, &02, &21, &04, &02, &B0, &00  ; 9DBC: 0F 0F 02... ...
 EQUB &22, &01, &00, &40, &06, &21, &02, &0F  ; 9DC4: 22 01 00... "..
 EQUB &0D, &32, &02, &01, &03, &21, &01, &02  ; 9DCC: 0D 32 02... .2.
 EQUB &81, &C2, &81, &33, &03, &09, &09, &03  ; 9DD4: 81 C2 81... ...
 EQUB &82, &21, &07, &82, &05, &80, &0F, &0B  ; 9DDC: 82 21 07... .!.
 EQUB &21, &03, &07, &80, &0F, &09, &22, &FC  ; 9DE4: 21 03 07... !..
 EQUB &15, &02, &A0, &E0, &A0, &F0, &B0, &F0  ; 9DEC: 15 02 A0... ...
 EQUB &00, &21, &03, &07, &80, &08, &36, &0A  ; 9DF4: 00 21 03... .!.
 EQUB &0F, &0B, &1F, &1B, &1F, &00, &22, &7F  ; 9DFC: 0F 0B 1F... ...
 EQUB &1A, &22, &FB, &F7, &F8, &FE, &EF, &EB  ; 9E04: 1A 22 FB... .".
 EQUB &F3, &FD, &12, &03, &EF, &7F, &6F, &21  ; 9E0C: F3 FD 12... ...
 EQUB &0F, &F0, &02, &21, &01, &EF, &FD, &ED  ; 9E14: 0F F0 02... ...
 EQUB &E1, &32, &1F, &3F, &FF, &EF, &AF, &9F  ; 9E1C: E1 32 1F... .2.
 EQUB &7F, &17, &22, &BF, &DF, &E7, &22, &0F  ; 9E24: 7F 17 22... .."
 EQUB &57, &FB, &F1, &F8, &F1, &15, &7F, &21  ; 9E2C: 57 FB F1... W..
 EQUB &2F, &56, &1F, &FE, &15, &FD, &E8, &D5  ; 9E34: 2F 56 1F... /V.
 EQUB &CF, &22, &E0, &D5, &BF, &33, &1F, &3F  ; 9E3C: CF 22 E0... .".
 EQUB &1E, &3F, &1D, &FC, &F0, &E0, &13, &E0  ; 9E44: 1E 3F 1D... .?.
 EQUB &04, &13, &32, &0F, &01, &03, &15, &7F  ; 9E4C: 04 13 32... ..2
 EQUB &32, &1F, &0F, &1F, &11, &22, &C0, &23  ; 9E54: 32 1F 0F... 2..
 EQUB &80, &00, &21, &01, &06, &E0, &50, &21  ; 9E5C: 80 00 21... ..!
 EQUB &2A, &05, &35, &0E, &15, &A8, &07, &07  ; 9E64: 2A 05 35... *.5
 EQUB &23, &03, &23, &01, &1D, &FE, &22, &FC  ; 9E6C: 23 03 23... #.#
 EQUB &08, &21, &04, &80, &21, &35, &02, &21  ; 9E74: 08 21 04... .!.
 EQUB &01, &00, &21, &01, &40, &21, &02, &58  ; 9E7C: 01 00 21... ..!
 EQUB &05, &25, &01, &03, &16, &22, &7F, &22  ; 9E84: 05 25 01... .%.
 EQUB &FC, &22, &FE, &14, &00, &21, &01, &03  ; 9E8C: FC 22 FE... .".
 EQUB &21, &02, &81, &C0, &00, &32, &21, &01  ; 9E94: 21 02 81... !..
 EQUB &02, &81, &C2, &81, &00, &21, &09, &03  ; 9E9C: 02 81 C2... ...
 EQUB &21, &02, &87, &21, &02, &04, &21, &01  ; 9EA4: 21 02 87... !..
 EQUB &81, &32, &03, &07, &22, &7F, &1C, &21  ; 9EAC: 81 32 03... .2.
 EQUB &01, &F9, &28, &E0, &22, &03, &06, &22  ; 9EB4: 01 F9 28... ..(
 EQUB &80, &06, &28, &0F, &16, &00, &21, &3F  ; 9EBC: 80 06 28... ..(
 EQUB &F9, &22, &F8, &FC, &FB, &13, &C0, &02  ; 9EC4: F9 22 F8... .".
 EQUB &20, &00, &A0, &80, &B0, &00, &21, &05  ; 9ECC: 20 00 A0...  ..
 EQUB &07, &40, &06, &21, &07, &02, &35, &08  ; 9ED4: 07 40 06... .@.
 EQUB &01, &0B, &03, &1B, &23, &3F, &7F, &BF  ; 9EDC: 01 0B 03... ...
 EQUB &13, &FB, &FF, &FA, &F9, &FA, &F9, &F1  ; 9EE4: 13 FB FF... ...
 EQUB &E3, &A0, &CC, &CB, &C3, &E0, &40, &FC  ; 9EEC: E3 A0 CC... ...
 EQUB &FF, &03, &60, &6F, &21, &0F, &00, &80  ; 9EF4: FF 03 60... ..`
 EQUB &02, &32, &01, &0D, &EC, &E0, &00, &32  ; 9EFC: 02 32 01... .2.
 EQUB &03, &0B, &67, &A6, &87, &32, &0E, &05  ; 9F04: 03 0B 67... ..g
 EQUB &7F, &FF, &BF, &FF, &BF, &21, &3F, &BF  ; 9F0C: 7F FF BF... ...
 EQUB &33, &3F, &1F, &8F, &23, &07, &24, &0F  ; 9F14: 33 3F 1F... 3?.
 EQUB &21, &07, &18, &FC, &23, &FE, &FF, &FE  ; 9F1C: 21 07 18... !..
 EQUB &12, &7F, &1F, &23, &C0, &24, &E0, &C0  ; 9F24: 12 7F 1F... ...
 EQUB &3F, &0F, &0F, &0F, &0F, &02, &21, &01  ; 9F2C: 3F 0F 0F... ?..
 EQUB &06, &E0, &50, &21, &2A, &05, &32, &0E  ; 9F34: 06 E0 50... ..P
 EQUB &15, &A8, &0F, &0F, &02, &21, &04, &80  ; 9F3C: 15 A8 0F... ...
 EQUB &21, &35, &02, &21, &01, &00, &21, &01  ; 9F44: 21 35 02... !5.
 EQUB &40, &21, &02, &58, &0F, &0F, &21, &01  ; 9F4C: 40 21 02... @!.
 EQUB &03, &32, &02, &01, &02, &32, &21, &01  ; 9F54: 03 32 02... .2.
 EQUB &02, &81, &C2, &81, &00, &21, &09, &03  ; 9F5C: 02 81 C2... ...
 EQUB &21, &02, &87, &21, &02, &05, &80, &0F  ; 9F64: 21 02 87... !..
 EQUB &02, &FC, &08, &22, &03, &06, &22, &80  ; 9F6C: 02 FC 08... ...
 EQUB &0F, &06, &7F, &23, &FC, &15, &02, &A0  ; 9F74: 0F 06 7F... ...
 EQUB &E0, &A0, &F0, &B0, &F0, &00, &21, &05  ; 9F7C: E0 A0 F0... ...
 EQUB &07, &40, &08, &36, &0A, &0F, &0B, &1F  ; 9F84: 07 40 08... .@.
 EQUB &1B, &1F, &23, &7F, &1A, &22, &FB, &F7  ; 9F8C: 1B 1F 23... ..#
 EQUB &F8, &FE, &EF, &EB, &F3, &FD, &12, &03  ; 9F94: F8 FE EF... ...
 EQUB &EF, &7F, &6F, &21, &0F, &F0, &02, &21  ; 9F9C: EF 7F 6F... ..o
 EQUB &01, &EF, &FD, &ED, &E1, &32, &1F, &3F  ; 9FA4: 01 EF FD... ...
 EQUB &FF, &EF, &AF, &9F, &7F, &17, &22, &BF  ; 9FAC: FF EF AF... ...
 EQUB &DF, &E7, &22, &0F, &4F, &24, &EF, &1F  ; 9FB4: DF E7 22... .."
 EQUB &1F, &12, &CF, &22, &E0, &E5, &23, &EF  ; 9FBC: 1F 12 CF... ...
 EQUB &EE, &3F, &1D, &FC, &F0, &E0, &13, &E0  ; 9FC4: EE 3F 1D... .?.
 EQUB &04, &13, &32, &0F, &01, &03, &15, &7F  ; 9FCC: 04 13 32... ..2
 EQUB &32, &1F, &0F, &1F, &11, &22, &C0, &23  ; 9FD4: 32 1F 0F... 2..
 EQUB &80, &00, &21, &01, &06, &E0, &50, &21  ; 9FDC: 80 00 21... ..!
 EQUB &2A, &05, &35, &0E, &15, &A8, &07, &07  ; 9FE4: 2A 05 35... *.5
 EQUB &23, &03, &23, &01, &1D, &FE, &22, &FC  ; 9FEC: 23 03 23... #.#
 EQUB &08, &84, &00, &21, &13, &02, &21, &01  ; 9FF4: 08 84 00... ...
 EQUB &00, &21, &01, &42, &00, &90, &05, &25  ; 9FFC: 00 21 01... .!.
 EQUB &01, &03, &16, &22, &7F, &22, &FC, &22  ; A004: 01 03 16... ...
 EQUB &FE, &14, &00, &21, &01, &03, &21, &02  ; A00C: FE 14 00... ...
 EQUB &81, &C0, &00, &32, &21, &01, &02, &81  ; A014: 81 C0 00... ...
 EQUB &C2, &81, &00, &21, &09, &03, &21, &02  ; A01C: C2 81 00... ...
 EQUB &87, &21, &02, &04, &21, &01, &81, &32  ; A024: 87 21 02... .!.
 EQUB &03, &07, &22, &7F, &1C, &21, &01, &F9  ; A02C: 03 07 22... .."
 EQUB &28, &E0, &22, &03, &06, &22, &80, &06  ; A034: 28 E0 22... (."
 EQUB &28, &0F, &16, &00, &21, &3F, &F9, &22  ; A03C: 28 0F 16... (..
 EQUB &F8, &FC, &FB, &13, &C0, &02, &20, &00  ; A044: F8 FC FB... ...
 EQUB &A0, &80, &B0, &00, &21, &05, &07, &40  ; A04C: A0 80 B0... ...
 EQUB &06, &21, &07, &02, &35, &08, &01, &0B  ; A054: 06 21 07... .!.
 EQUB &03, &1B, &23, &3F, &7F, &BF, &13, &FB  ; A05C: 03 1B 23... ..#
 EQUB &FF, &FA, &F9, &FA, &F9, &F1, &E3, &A0  ; A064: FF FA F9... ...
 EQUB &CC, &CB, &C3, &E0, &40, &FC, &FF, &03  ; A06C: CC CB C3... ...
 EQUB &60, &6F, &21, &0F, &00, &80, &02, &32  ; A074: 60 6F 21... `o!
 EQUB &01, &0D, &EC, &E0, &00, &32, &03, &0B  ; A07C: 01 0D EC... ...
 EQUB &67, &A6, &87, &32, &0E, &05, &7F, &FF  ; A084: 67 A6 87... g..
 EQUB &BF, &FF, &BF, &21, &3F, &BF, &33, &3F  ; A08C: BF FF BF... ...
 EQUB &1F, &8F, &23, &07, &24, &0F, &21, &07  ; A094: 1F 8F 23... ..#
 EQUB &18, &FC, &23, &FE, &FF, &FE, &12, &7F  ; A09C: 18 FC 23... ..#
 EQUB &1F, &23, &C0, &24, &E0, &C0, &3F, &0F  ; A0A4: 1F 23 C0... .#.
 EQUB &0F, &0F, &0F, &02, &21, &01, &06, &E0  ; A0AC: 0F 0F 0F... ...
 EQUB &50, &21, &2A, &05, &32, &0E, &15, &A8  ; A0B4: 50 21 2A... P!*
 EQUB &0F, &0F, &02, &84, &00, &21, &13, &02  ; A0BC: 0F 0F 02... ...
 EQUB &21, &01, &00, &21, &01, &42, &00, &90  ; A0C4: 21 01 00... !..
 EQUB &0F, &0F, &21, &01, &03, &32, &02, &01  ; A0CC: 0F 0F 21... ..!
 EQUB &02, &32, &21, &01, &02, &81, &C2, &81  ; A0D4: 02 32 21... .2!
 EQUB &00, &21, &09, &03, &21, &02, &87, &21  ; A0DC: 00 21 09... .!.
 EQUB &02, &05, &80, &0F, &02, &FC, &08, &22  ; A0E4: 02 05 80... ...
 EQUB &03, &06, &22, &80, &0F, &06, &7F, &23  ; A0EC: 03 06 22... .."
 EQUB &FC, &15, &02, &A0, &E0, &A0, &F0, &B0  ; A0F4: FC 15 02... ...
 EQUB &F0, &00, &21, &05, &07, &40, &08, &36  ; A0FC: F0 00 21... ..!
 EQUB &0A, &0F, &0B, &1F, &1B, &1F, &23, &7F  ; A104: 0A 0F 0B... ...
 EQUB &1A, &22, &FB, &F7, &F8, &FE, &EF, &EB  ; A10C: 1A 22 FB... .".
 EQUB &F3, &FD, &12, &03, &EF, &7F, &6F, &21  ; A114: F3 FD 12... ...
 EQUB &0F, &F0, &02, &21, &01, &EF, &FD, &ED  ; A11C: 0F F0 02... ...
 EQUB &E1, &32, &1F, &3F, &FF, &EF, &AF, &9F  ; A124: E1 32 1F... .2.
 EQUB &7F, &17, &22, &BF, &DF, &E7, &22, &0F  ; A12C: 7F 17 22... .."
 EQUB &4F, &24, &EF, &1F, &1F, &12, &CF, &22  ; A134: 4F 24 EF... O$.
 EQUB &E0, &E5, &23, &EF, &EE, &3F, &1D, &FC  ; A13C: E0 E5 23... ..#
 EQUB &F0, &E0, &13, &E0, &04, &13, &32, &0F  ; A144: F0 E0 13... ...
 EQUB &01, &03, &15, &7F, &32, &1F, &0F, &1F  ; A14C: 01 03 15... ...
 EQUB &11, &22, &C0, &23, &80, &00, &21, &01  ; A154: 11 22 C0... .".
 EQUB &06, &E0, &50, &21, &2A, &05, &35, &0E  ; A15C: 06 E0 50... ..P
 EQUB &15, &A8, &07, &07, &23, &03, &23, &01  ; A164: 15 A8 07... ...
 EQUB &1D, &FE, &22, &FC, &08, &21, &04, &00  ; A16C: 1D FE 22... .."
 EQUB &81, &10, &00, &21, &01, &00, &21, &01  ; A174: 81 10 00... ...
 EQUB &40, &00, &21, &02, &10, &04, &25, &01  ; A17C: 40 00 21... @.!
 EQUB &03, &16, &22, &7F, &22, &FC, &22, &FE  ; A184: 03 16 22... .."
 EQUB &14, &00, &21, &01, &03, &21, &02, &81  ; A18C: 14 00 21... ..!
 EQUB &C0, &00, &32, &21, &01, &02, &81, &C2  ; A194: C0 00 32... ..2
 EQUB &81, &00, &21, &09, &03, &21, &02, &87  ; A19C: 81 00 21... ..!
 EQUB &21, &02, &04, &21, &01, &81, &32, &03  ; A1A4: 21 02 04... !..
 EQUB &07, &22, &7F, &16, &00, &27, &FE, &23  ; A1AC: 07 22 7F... .".
 EQUB &C0, &05, &22, &03, &06, &22, &80, &06  ; A1B4: C0 05 22... .."
 EQUB &23, &06, &06, &17, &28, &FE, &09, &21  ; A1BC: 23 06 06... #..
 EQUB &05, &02, &10, &32, &0B, &01, &02, &40  ; A1C4: 05 02 10... ...
 EQUB &02, &10, &A0, &0A, &18, &22, &FE, &FC  ; A1CC: 02 10 A0... ...
 EQUB &F8, &F0, &E0, &C0, &21, &01, &02, &21  ; A1D4: F8 F0 E0... ...
 EQUB &01, &02, &78, &12, &02, &FF, &00, &7F  ; A1DC: 01 02 78... ..x
 EQUB &21, &01, &00, &E0, &02, &FF, &00, &FC  ; A1E4: 21 01 00... !..
 EQUB &00, &32, &01, &0F, &05, &21, &3C, &FE  ; A1EC: 00 32 01... .2.
 EQUB &13, &7F, &38, &3F, &1F, &0F, &07, &00  ; A1F4: 13 7F 38... ..8
 EQUB &03, &07, &07, &23, &0F, &CF, &21, &07  ; A1FC: 03 07 07... ...
 EQUB &18, &FC, &23, &FE, &FF, &FE, &12, &7F  ; A204: 18 FC 23... ..#
 EQUB &1F, &80, &22, &C0, &23, &E0, &E6, &C0  ; A20C: 1F 80 22... .."
 EQUB &3F, &0F, &0F, &0F, &0F, &02, &21, &01  ; A214: 3F 0F 0F... ?..
 EQUB &06, &E0, &50, &21, &2A, &05, &32, &0E  ; A21C: 06 E0 50... ..P
 EQUB &15, &A8, &0F, &0F, &02, &21, &04, &00  ; A224: 15 A8 0F... ...
 EQUB &81, &10, &00, &21, &01, &00, &21, &01  ; A22C: 81 10 00... ...
 EQUB &40, &00, &21, &02, &10, &0F, &0E, &21  ; A234: 40 00 21... @.!
 EQUB &01, &03, &32, &02, &01, &02, &32, &21  ; A23C: 01 03 32... ..2
 EQUB &01, &02, &81, &C2, &81, &00, &21, &09  ; A244: 01 02 81... ...
 EQUB &03, &21, &02, &87, &21, &02, &05, &80  ; A24C: 03 21 02... .!.
 EQUB &0B, &27, &FE, &05, &40, &E0, &40, &22  ; A254: 0B 27 FE... .'.
 EQUB &03, &06, &22, &80, &0B, &33, &04, &0E  ; A25C: 03 06 22... .."
 EQUB &04, &00, &17, &28, &FE, &20, &40, &00  ; A264: 04 00 17... ...
 EQUB &10, &05, &21, &05, &02, &10, &32, &0B  ; A26C: 10 05 21... ..!
 EQUB &01, &02, &40, &02, &10, &A0, &02, &32  ; A274: 01 02 40... ..@
 EQUB &08, &04, &00, &10, &04, &18, &24, &FE  ; A27C: 08 04 00... ...
 EQUB &FC, &F8, &F1, &E3, &02, &57, &00, &21  ; A284: FC F8 F1... ...
 EQUB &01, &FC, &12, &02, &FF, &21, &3F, &FF  ; A28C: 01 FC 12... ...
 EQUB &57, &8B, &F1, &02, &FF, &F8, &FF, &D4  ; A294: 57 8B F1... W..
 EQUB &A3, &21, &1F, &02, &D4, &02, &7E, &16  ; A29C: A3 21 1F... .!.
 EQUB &7F, &32, &3F, &1F, &8F, &C7, &23, &0F  ; A2A4: 7F 32 3F... .2?
 EQUB &23, &EF, &CF, &1F, &1F, &12, &C7, &23  ; A2AC: 23 EF CF... #..
 EQUB &E0, &23, &EF, &E6, &3F, &1B, &FE, &22  ; A2B4: E0 23 EF... .#.
 EQUB &FC, &E0, &C0, &12, &F7, &20, &04, &12  ; A2BC: FC E0 C0... ...
 EQUB &6F, &21, &03, &04, &14, &34, &3F, &1F  ; A2C4: 6F 21 03... o!.
 EQUB &1F, &0F, &1F, &11, &C0, &24, &80, &00  ; A2CC: 1F 0F 1F... ...
 EQUB &21, &01, &06, &E0, &50, &21, &2A, &05  ; A2D4: 21 01 06... !..
 EQUB &37, &0E, &15, &A8, &07, &07, &03, &03  ; A2DC: 37 0E 15... 7..
 EQUB &24, &01, &1D, &FE, &22, &FC, &08, &21  ; A2E4: 24 01 1D... $..
 EQUB &04, &22, &80, &50, &00, &22, &01, &00  ; A2EC: 04 22 80... .".
 EQUB &40, &00, &32, &02, &14, &04, &23, &01  ; A2F4: 40 00 32... @.2
 EQUB &81, &21, &01, &03, &16, &22, &7F, &22  ; A2FC: 81 21 01... .!.
 EQUB &FC, &22, &FE, &14, &00, &21, &01, &03  ; A304: FC 22 FE... .".
 EQUB &21, &02, &81, &C0, &33, &01, &21, &01  ; A30C: 21 02 81... !..
 EQUB &02, &81, &C2, &81, &00, &21, &09, &03  ; A314: 02 81 C2... ...
 EQUB &21, &02, &87, &21, &02, &04, &21, &01  ; A31C: 21 02 87... !..
 EQUB &81, &32, &03, &07, &22, &7F, &16, &00  ; A324: 81 32 03... .2.
 EQUB &27, &FE, &23, &C0, &05, &22, &03, &06  ; A32C: 27 FE 23... '.#
 EQUB &22, &80, &06, &23, &06, &06, &17, &28  ; A334: 22 80 06... "..
 EQUB &FE, &09, &21, &05, &07, &40, &0E, &18  ; A33C: FE 09 21... ..!
 EQUB &22, &FE, &FC, &F8, &F0, &E0, &C0, &03  ; A344: 22 FE FC... "..
 EQUB &21, &01, &07, &FF, &00, &7F, &21, &01  ; A34C: 21 01 07... !..
 EQUB &04, &FF, &00, &FC, &0B, &12, &7F, &34  ; A354: 04 FF 00... ...
 EQUB &3F, &1F, &0F, &07, &04, &22, &01, &00  ; A35C: 3F 1F 0F... ?..
 EQUB &C2, &02, &21, &01, &60, &F8, &32, &04  ; A364: C2 02 21... ..!
 EQUB &01, &04, &60, &32, &1F, &03, &04, &32  ; A36C: 01 04 60... ..`
 EQUB &01, &0C, &F0, &80, &21, &01, &04, &32  ; A374: 01 0C F0... ...
 EQUB &0C, &3F, &41, &09, &86, &00, &3F, &0F  ; A37C: 0C 3F 41... .?A
 EQUB &0F, &0F, &0F, &02, &21, &01, &06, &E0  ; A384: 0F 0F 0F... ...
 EQUB &50, &21, &2A, &05, &32, &0E, &15, &A8  ; A38C: 50 21 2A... P!*
 EQUB &0F, &0F, &02, &21, &04, &22, &80, &50  ; A394: 0F 0F 02... ...
 EQUB &00, &22, &01, &00, &40, &00, &32, &02  ; A39C: 00 22 01... .".
 EQUB &14, &07, &80, &0F, &06, &21, &01, &03  ; A3A4: 14 07 80... ...
 EQUB &36, &02, &01, &00, &01, &21, &01, &02  ; A3AC: 36 02 01... 6..
 EQUB &81, &C2, &81, &00, &21, &09, &03, &21  ; A3B4: 81 C2 81... ...
 EQUB &02, &87, &21, &02, &05, &80, &0B, &27  ; A3BC: 02 87 21... ..!
 EQUB &FE, &05, &40, &E0, &40, &22, &03, &06  ; A3C4: FE 05 40... ..@
 EQUB &22, &80, &0B, &33, &04, &0E, &04, &00  ; A3CC: 22 80 0B... "..
 EQUB &17, &28, &FE, &20, &40, &00, &10, &05  ; A3D4: 17 28 FE... .(.
 EQUB &21, &05, &07, &40, &06, &32, &08, &04  ; A3DC: 21 05 07... !..
 EQUB &00, &10, &04, &18, &24, &FE, &FC, &F8  ; A3E4: 00 10 04... ...
 EQUB &F0, &E0, &02, &57, &00, &32, &0B, &02  ; A3EC: F0 E0 02... ...
 EQUB &20, &10, &02, &FF, &21, &3F, &FF, &57  ; A3F4: 20 10 02...  ..
 EQUB &8B, &21, &01, &02, &FF, &F8, &FF, &D4  ; A3FC: 8B 21 01... .!.
 EQUB &A2, &03, &D4, &00, &A0, &80, &21, &08  ; A404: A2 03 D4... ...
 EQUB &10, &14, &7F, &33, &3F, &1F, &0F, &C0  ; A40C: 10 14 7F... ...
 EQUB &00, &32, &01, &03, &E3, &22, &E7, &C7  ; A414: 00 32 01... .2.
 EQUB &21, &0C, &67, &FB, &FD, &14, &00, &80  ; A41C: 21 0C 67... !.g
 EQUB &F8, &FF, &BF, &FF, &F4, &FE, &00, &32  ; A424: F8 FF BF... ...
 EQUB &03, &3F, &FF, &FB, &FF, &5F, &FF, &60  ; A42C: 03 3F FF... .?.
 EQUB &CC, &BF, &7F, &14, &21, &07, &02, &80  ; A434: CC BF 7F... ...
 EQUB &8F, &22, &CF, &C6, &3F, &1A, &FE, &22  ; A43C: 8F 22 CF... .".
 EQUB &FC, &22, &F0, &E0, &12, &21, &34, &05  ; A444: FC 22 F0... .".
 EQUB &FF, &6F, &21, &07, &05, &13, &31, &3F  ; A44C: FF 6F 21... .o!
 EQUB &23, &1F, &21, &0F, &1F, &11, &C0, &C2  ; A454: 23 1F 21... #.!
 EQUB &85, &80, &33, &05, &02, &01, &04, &80  ; A45C: 85 80 33... ..3
 EQUB &40, &E0, &50, &21, &2A, &04, &36, &01  ; A464: 40 E0 50... @.P
 EQUB &0E, &15, &A8, &07, &07, &43, &A3, &C1  ; A46C: 0E 15 A8... ...
 EQUB &81, &22, &01, &1D, &FE, &22, &FC, &08  ; A474: 81 22 01... .".
 EQUB &21, &04, &22, &80, &50, &00, &22, &01  ; A47C: 21 04 22... !."
 EQUB &00, &40, &00, &32, &02, &14, &04, &23  ; A484: 00 40 00... .@.
 EQUB &01, &81, &21, &01, &03, &16, &22, &7F  ; A48C: 01 81 21... ..!
 EQUB &22, &FC, &22, &FE, &14, &00, &21, &01  ; A494: 22 FC 22... "."
 EQUB &03, &21, &02, &81, &C0, &33, &01, &21  ; A49C: 03 21 02... .!.
 EQUB &01, &02, &81, &C2, &81, &00, &21, &09  ; A4A4: 01 02 81... ...
 EQUB &03, &21, &02, &87, &21, &02, &04, &21  ; A4AC: 03 21 02... .!.
 EQUB &01, &81, &32, &03, &07, &22, &7F, &16  ; A4B4: 01 81 32... ..2
 EQUB &00, &21, &04, &22, &FE, &23, &04, &00  ; A4BC: 00 21 04... .!.
 EQUB &23, &C0, &05, &22, &03, &06, &22, &80  ; A4C4: 23 C0 05... #..
 EQUB &06, &23, &06, &06, &40, &12, &23, &40  ; A4CC: 06 23 06... .#.
 EQUB &00, &21, &04, &02, &21, &04, &0D, &21  ; A4D4: 00 21 04... .!.
 EQUB &05, &07, &40, &0E, &40, &02, &40, &0E  ; A4DC: 05 07 40... ..@
 EQUB &21, &01, &07, &FF, &00, &7F, &21, &01  ; A4E4: 21 01 07... !..
 EQUB &04, &FF, &00, &FC, &0F, &07, &22, &01  ; A4EC: 04 FF 00... ...
 EQUB &00, &21, &02, &02, &21, &01, &60, &F8  ; A4F4: 00 21 02... .!.
 EQUB &32, &04, &01, &04, &60, &32, &1F, &03  ; A4FC: 32 04 01... 2..
 EQUB &04, &32, &01, &0C, &F0, &80, &21, &01  ; A504: 04 32 01... .2.
 EQUB &04, &32, &0C, &3F, &41, &09, &80, &00  ; A50C: 04 32 0C... .2.
 EQUB &3F, &0F, &0F, &0F, &0C, &36, &02, &05  ; A514: 3F 0F 0F... ?..
 EQUB &00, &05, &02, &01, &04, &80, &40, &E0  ; A51C: 00 05 02... ...
 EQUB &50, &21, &2A, &04, &33, &01, &0E, &15  ; A524: 50 21 2A... P!*
 EQUB &A8, &02, &40, &A0, &C0, &80, &0F, &0B  ; A52C: A8 02 40... ..@
 EQUB &21, &04, &22, &80, &50, &00, &22, &01  ; A534: 21 04 22... !."
 EQUB &00, &40, &00, &32, &02, &14, &07, &80  ; A53C: 00 40 00... .@.
 EQUB &0F, &06, &21, &01, &03, &36, &02, &01  ; A544: 0F 06 21... ..!
 EQUB &00, &01, &21, &01, &02, &81, &C2, &81  ; A54C: 00 01 21... ..!
 EQUB &00, &21, &09, &03, &21, &02, &87, &21  ; A554: 00 21 09... .!.
 EQUB &02, &05, &80, &0B, &27, &FE, &05, &40  ; A55C: 02 05 80... ...
 EQUB &E0, &40, &22, &03, &06, &22, &80, &0B  ; A564: E0 40 22... .@"
 EQUB &33, &04, &0E, &04, &00, &17, &28, &FE  ; A56C: 33 04 0E... 3..
 EQUB &20, &40, &00, &10, &05, &21, &05, &07  ; A574: 20 40 00...  @.
 EQUB &40, &06, &32, &08, &04, &00, &10, &04  ; A57C: 40 06 32... @.2
 EQUB &18, &22, &FE, &F0, &C0, &21, &06, &10  ; A584: 18 22 FE... .".
 EQUB &40, &80, &02, &57, &00, &32, &0B, &02  ; A58C: 40 80 02... @..
 EQUB &20, &10, &02, &FF, &21, &1F, &FF, &57  ; A594: 20 10 02...  ..
 EQUB &8B, &21, &01, &02, &FF, &F8, &FF, &D4  ; A59C: 8B 21 01... .!.
 EQUB &A2, &03, &D4, &00, &A0, &80, &21, &08  ; A5A4: A2 03 D4... ...
 EQUB &10, &12, &32, &1F, &07, &C1, &10, &32  ; A5AC: 10 12 32... ..2
 EQUB &04, &02, &02, &33, &01, &03, &03, &87  ; A5B4: 04 02 02... ...
 EQUB &22, &C7, &21, &0C, &67, &FB, &FD, &14  ; A5BC: 22 C7 21... ".!
 EQUB &00, &80, &F8, &FF, &BF, &FF, &F4, &FE  ; A5C4: 00 80 F8... ...
 EQUB &00, &32, &03, &3F, &FF, &FB, &FF, &5F  ; A5CC: 00 32 03... .2.
 EQUB &FF, &60, &CC, &BF, &7F, &14, &21, &01  ; A5D4: FF 60 CC... .`.
 EQUB &02, &22, &80, &C3, &22, &C7, &3F, &1D  ; A5DC: 02 22 80... .".
 EQUB &FC, &F0, &E0, &13, &E0, &04, &13, &32  ; A5E4: FC F0 E0... ...
 EQUB &0F, &01, &03, &15, &7F, &32, &1F, &0F  ; A5EC: 0F 01 03... ...
 EQUB &1F, &11, &22, &C0, &23, &80, &00, &21  ; A5F4: 1F 11 22... .."
 EQUB &01, &06, &E0, &50, &21, &2A, &05, &35  ; A5FC: 01 06 E0... ...
 EQUB &0E, &14, &A8, &07, &07, &23, &03, &23  ; A604: 0E 14 A8... ...
 EQUB &01, &1D, &FE, &22, &FC, &08, &21, &04  ; A60C: 01 1D FE... ...
 EQUB &22, &80, &50, &00, &22, &01, &00, &40  ; A614: 22 80 50... ".P
 EQUB &02, &21, &14, &04, &22, &01, &22, &41  ; A61C: 02 21 14... .!.
 EQUB &21, &01, &03, &16, &22, &7F, &22, &FC  ; A624: 21 01 03... !..
 EQUB &22, &FE, &14, &00, &21, &01, &03, &21  ; A62C: 22 FE 14... "..
 EQUB &02, &81, &C0, &33, &03, &21, &01, &02  ; A634: 02 81 C0... ...
 EQUB &81, &C2, &81, &80, &21, &09, &04, &86  ; A63C: 81 C2 81... ...
 EQUB &21, &02, &04, &21, &01, &81, &32, &03  ; A644: 21 02 04... !..
 EQUB &07, &22, &7F, &16, &00, &21, &04, &22  ; A64C: 07 22 7F... .".
 EQUB &FE, &23, &04, &00, &23, &C0, &05, &22  ; A654: FE 23 04... .#.
 EQUB &03, &06, &22, &80, &06, &23, &06, &06  ; A65C: 03 06 22... .."
 EQUB &40, &12, &23, &40, &00, &21, &04, &02  ; A664: 40 12 23... @.#
 EQUB &21, &04, &0D, &21, &0B, &02, &10, &32  ; A66C: 21 04 0D... !..
 EQUB &0B, &01, &02, &A0, &02, &10, &A0, &0A  ; A674: 0B 01 02... ...
 EQUB &40, &02, &40, &0E, &21, &01, &07, &FF  ; A67C: 40 02 40... @.@
 EQUB &00, &7F, &21, &01, &04, &FF, &00, &FC  ; A684: 00 7F 21... ..!
 EQUB &0F, &0D, &21, &01, &08, &60, &32, &1F  ; A68C: 0F 0D 21... ..!
 EQUB &03, &04, &32, &01, &0C, &F0, &80, &0F  ; A694: 03 04 32... ..2
 EQUB &04, &3F, &0F, &0F, &0F, &0F, &02, &21  ; A69C: 04 3F 0F... .?.
 EQUB &01, &06, &E0, &50, &21, &2A, &05, &32  ; A6A4: 01 06 E0... ...
 EQUB &0E, &14, &A8, &0F, &0F, &02, &21, &04  ; A6AC: 0E 14 A8... ...
 EQUB &22, &80, &50, &00, &22, &01, &00, &40  ; A6B4: 22 80 50... ".P
 EQUB &02, &21, &14, &06, &22, &40, &0F, &06  ; A6BC: 02 21 14... .!.
 EQUB &21, &01, &03, &36, &02, &01, &00, &03  ; A6C4: 21 01 03... !..
 EQUB &21, &01, &02, &81, &C2, &81, &80, &21  ; A6CC: 21 01 02... !..
 EQUB &09, &04, &86, &21, &02, &05, &80, &0B  ; A6D4: 09 04 86... ...
 EQUB &27, &FE, &05, &40, &E0, &40, &22, &03  ; A6DC: 27 FE 05... '..
 EQUB &06, &22, &80, &0B, &33, &04, &0E, &04  ; A6E4: 06 22 80... .".
 EQUB &00, &17, &28, &FE, &20, &40, &00, &10  ; A6EC: 00 17 28... ..(
 EQUB &05, &21, &0B, &02, &10, &32, &0B, &01  ; A6F4: 05 21 0B... .!.
 EQUB &02, &A0, &02, &10, &A0, &02, &32, &08  ; A6FC: 02 A0 02... ...
 EQUB &04, &00, &10, &04, &18, &22, &FE, &F0  ; A704: 04 00 10... ...
 EQUB &C0, &21, &06, &10, &40, &80, &02, &57  ; A70C: C0 21 06... .!.
 EQUB &00, &32, &0B, &02, &20, &10, &02, &FF  ; A714: 00 32 0B... .2.
 EQUB &21, &1F, &FF, &57, &8B, &21, &01, &02  ; A71C: 21 1F FF... !..
 EQUB &FF, &F8, &FF, &D4, &A2, &03, &D4, &00  ; A724: FF F8 FF... ...
 EQUB &A0, &80, &21, &08, &10, &12, &32, &1F  ; A72C: A0 80 21... ..!
 EQUB &07, &C1, &10, &32, &04, &02, &08, &35  ; A734: 07 C1 10... ...
 EQUB &0C, &07, &0B, &01, &04, &04, &80, &F8  ; A73C: 0C 07 0B... ...
 EQUB &7F, &BF, &21, &15, &03, &32, &03, &3F  ; A744: 7F BF 21... ..!
 EQUB &FD, &FA, &50, &02, &60, &C0, &A0, &00  ; A74C: FD FA 50... ..P
 EQUB &40, &03, &21, &01, &07, &3F, &1D, &FC  ; A754: 40 03 21... @.!
 EQUB &F0, &E0, &13, &E0, &04, &13, &32, &0F  ; A75C: F0 E0 13... ...
 EQUB &01, &03, &15, &7F, &32, &1F, &0F, &1F  ; A764: 01 03 15... ...
 EQUB &11, &22, &C0, &23, &80, &00, &21, &01  ; A76C: 11 22 C0... .".
 EQUB &06, &E0, &50, &21, &2A, &05, &35, &0E  ; A774: 06 E0 50... ..P
 EQUB &14, &A8, &07, &07, &23, &03, &23, &01  ; A77C: 14 A8 07... ...
 EQUB &1D, &FE, &22, &FC, &03, &21, &01, &04  ; A784: 1D FE 22... .."
 EQUB &21, &04, &80, &02, &C0, &32, &11, &01  ; A78C: 21 04 80... !..
 EQUB &00, &40, &03, &21, &08, &10, &02, &22  ; A794: 00 40 03... .@.
 EQUB &01, &22, &41, &21, &01, &03, &16, &22  ; A79C: 01 22 41... ."A
 EQUB &7F, &22, &FC, &22, &FE, &14, &00, &21  ; A7A4: 7F 22 FC... .".
 EQUB &01, &03, &21, &02, &81, &C0, &35, &03  ; A7AC: 01 03 21... ..!
 EQUB &01, &01, &00, &02, &81, &C3, &83, &80  ; A7B4: 01 01 00... ...
 EQUB &21, &01, &02, &80, &00, &86, &82, &04  ; A7BC: 21 01 02... !..
 EQUB &21, &01, &81, &32, &03, &07, &22, &7F  ; A7C4: 21 01 81... !..
 EQUB &16, &00, &D2, &02, &21, &02, &00, &22  ; A7CC: 16 00 D2... ...
 EQUB &02, &23, &C0, &0F, &06, &23, &06, &06  ; A7D4: 02 23 C0... .#.
 EQUB &96, &02, &80, &00, &22, &80, &33, &02  ; A7DC: 96 02 80... ...
 EQUB &06, &06, &23, &02, &00, &21, &02, &09  ; A7E4: 06 06 23... ..#
 EQUB &32, &01, &03, &07, &80, &0D, &80, &22  ; A7EC: 32 01 03... 2..
 EQUB &C0, &23, &80, &00, &80, &04, &21, &02  ; A7F4: C0 23 80... .#.
 EQUB &05, &21, &01, &07, &FF, &00, &7F, &21  ; A7FC: 05 21 01... .!.
 EQUB &01, &04, &FF, &00, &FC, &0F, &80, &0C  ; A804: 01 04 FF... ...
 EQUB &21, &01, &08, &60, &32, &1F, &03, &04  ; A80C: 21 01 08... !..
 EQUB &32, &01, &0C, &F0, &80, &0F, &04, &3F  ; A814: 32 01 0C... 2..
 EQUB &0F, &0F, &0F, &0F, &01, &30, &61, &06  ; A81C: 0F 0F 0F... ...
 EQUB &E0, &50, &21, &2A, &05, &32, &0E, &14  ; A824: E0 50 21... .P!
 EQUB &A8, &05, &32, &18, &0C, &0F, &02, &40  ; A82C: A8 05 32... ..2
 EQUB &00, &40, &21, &01, &04, &21, &04, &80  ; A834: 00 40 21... .@!
 EQUB &02, &C0, &32, &11, &01, &00, &40, &03  ; A83C: 02 C0 32... ..2
 EQUB &21, &08, &10, &02, &21, &04, &00, &44  ; A844: 21 08 10... !..
 EQUB &40, &0F, &06, &21, &01, &03, &38, &02  ; A84C: 40 0F 06... @..
 EQUB &01, &00, &03, &01, &01, &00, &02, &81  ; A854: 01 00 03... ...
 EQUB &C3, &83, &80, &21, &01, &02, &80, &00  ; A85C: C3 83 80... ...
 EQUB &86, &82, &05, &80, &0B, &FE, &F6, &AA  ; A864: 86 82 05... ...
 EQUB &46, &33, &12, &06, &0E, &05, &40, &E0  ; A86C: 46 33 12... F3.
 EQUB &40, &0F, &06, &33, &04, &0E, &04, &00  ; A874: 40 0F 06... @..
 EQUB &FF, &DE, &AA, &C4, &90, &C0, &E0, &38  ; A87C: FF DE AA... ...
 EQUB &06, &0E, &0E, &06, &0E, &06, &02, &06  ; A884: 06 0E 0E... ...
 EQUB &20, &40, &00, &10, &05, &32, &01, &03  ; A88C: 20 40 00...  @.
 EQUB &07, &80, &05, &32, &08, &04, &00, &10  ; A894: 07 80 05... ...
 EQUB &04, &C0, &22, &E0, &C0, &E0, &C0, &80  ; A89C: 04 C0 22... .."
 EQUB &C0, &24, &02, &21, &0E, &20, &00, &80  ; A8A4: C0 24 02... .$.
 EQUB &02, &57, &00, &32, &0B, &02, &20, &10  ; A8AC: 02 57 00... .W.
 EQUB &02, &FF, &21, &1F, &FF, &57, &8B, &21  ; A8B4: 02 FF 21... ..!
 EQUB &01, &02, &FF, &F8, &FF, &D4, &A2, &03  ; A8BC: 01 02 FF... ...
 EQUB &D4, &00, &A0, &80, &21, &08, &10, &24  ; A8C4: D4 00 A0... ...
 EQUB &80, &E0, &21, &08, &00, &21, &02, &08  ; A8CC: 80 E0 21... ..!
 EQUB &35, &0C, &07, &0B, &01, &04, &04, &80  ; A8D4: 35 0C 07... 5..
 EQUB &F8, &7F, &BF, &21, &15, &03, &32, &03  ; A8DC: F8 7F BF... ...
 EQUB &3F, &FD, &FA, &50, &02, &60, &C0, &A0  ; A8E4: 3F FD FA... ?..
 EQUB &00, &40, &0B, &3F, &1B, &FE, &22, &FC  ; A8EC: 00 40 0B... .@.
 EQUB &E0, &C0, &12, &F7, &20, &04, &12, &6F  ; A8F4: E0 C0 12... ...
 EQUB &21, &03, &04, &14, &34, &3F, &1F, &1F  ; A8FC: 21 03 04... !..
 EQUB &0F, &1F, &11, &C0, &24, &80, &00, &21  ; A904: 0F 1F 11... ...
 EQUB &01, &06, &E0, &50, &21, &2A, &05, &37  ; A90C: 01 06 E0... ...
 EQUB &0E, &14, &A8, &07, &07, &03, &03, &24  ; A914: 0E 14 A8... ...
 EQUB &01, &1D, &FE, &22, &FC, &08, &21, &04  ; A91C: 01 1D FE... ...
 EQUB &03, &50, &22, &01, &00, &40, &03, &21  ; A924: 03 50 22... .P"
 EQUB &14, &03, &22, &01, &22, &41, &21, &01  ; A92C: 14 03 22... .."
 EQUB &03, &16, &22, &7F, &22, &FC, &22, &FE  ; A934: 03 16 22... .."
 EQUB &14, &00, &21, &01, &03, &21, &02, &81  ; A93C: 14 00 21... ..!
 EQUB &C0, &33, &03, &21, &01, &02, &82, &C1  ; A944: C0 33 03... .3.
 EQUB &83, &80, &21, &09, &03, &80, &21, &06  ; A94C: 83 80 21... ..!
 EQUB &82, &04, &21, &01, &81, &32, &03, &07  ; A954: 82 04 21... ..!
 EQUB &22, &7F, &16, &00, &D2, &02, &21, &02  ; A95C: 22 7F 16... "..
 EQUB &00, &22, &02, &23, &C0, &05, &21, &03  ; A964: 00 22 02... .".
 EQUB &06, &21, &01, &80, &07, &23, &06, &06  ; A96C: 06 21 01... .!.
 EQUB &96, &02, &80, &00, &22, &80, &33, &02  ; A974: 96 02 80... ...
 EQUB &06, &06, &23, &02, &00, &21, &02, &09  ; A97C: 06 06 23... ..#
 EQUB &21, &0B, &07, &A0, &0E, &80, &22, &C0  ; A984: 21 0B 07... !..
 EQUB &23, &80, &00, &80, &04, &21, &02, &05  ; A98C: 23 80 00... #..
 EQUB &21, &01, &07, &FF, &00, &7F, &21, &01  ; A994: 21 01 07... !..
 EQUB &04, &FF, &00, &FC, &0F, &80, &03, &22  ; A99C: 04 FF 00... ...
 EQUB &04, &34, &1F, &0E, &0A, &11, &03, &21  ; A9A4: 04 34 1F... .4.
 EQUB &01, &08, &60, &32, &1F, &03, &04, &32  ; A9AC: 01 08 60... ..`
 EQUB &01, &0C, &F0, &80, &05, &21, &01, &02  ; A9B4: 01 0C F0... ...
 EQUB &21, &01, &02, &22, &40, &F0, &E0, &A0  ; A9BC: 21 01 02... !..
 EQUB &10, &02, &3F, &0F, &0F, &0F, &0F, &02  ; A9C4: 10 02 3F... ..?
 EQUB &21, &01, &06, &E0, &50, &21, &2A, &05  ; A9CC: 21 01 06... !..
 EQUB &32, &0E, &14, &A8, &0F, &0F, &02, &21  ; A9D4: 32 0E 14... 2..
 EQUB &04, &03, &50, &22, &01, &00, &40, &03  ; A9DC: 04 03 50... ..P
 EQUB &21, &14, &05, &22, &40, &0F, &06, &21  ; A9E4: 21 14 05... !..
 EQUB &01, &03, &36, &02, &01, &00, &03, &21  ; A9EC: 01 03 36... ..6
 EQUB &01, &02, &82, &C1, &83, &80, &21, &09  ; A9F4: 01 02 82... ...
 EQUB &03, &80, &21, &06, &82, &05, &80, &0B  ; A9FC: 03 80 21... ..!
 EQUB &FE, &F6, &AA, &46, &33, &12, &06, &0E  ; AA04: FE F6 AA... ...
 EQUB &05, &40, &E0, &40, &21, &03, &06, &21  ; AA0C: 05 40 E0... .@.
 EQUB &01, &80, &0C, &33, &04, &0E, &04, &00  ; AA14: 01 80 0C... ...
 EQUB &FF, &DE, &AA, &C4, &90, &C0, &E0, &38  ; AA1C: FF DE AA... ...
 EQUB &06, &0E, &0E, &06, &0E, &06, &02, &06  ; AA24: 06 0E 0E... ...
 EQUB &20, &40, &00, &10, &05, &21, &0B, &07  ; AA2C: 20 40 00...  @.
 EQUB &A0, &06, &32, &08, &04, &00, &10, &04  ; AA34: A0 06 32... ..2
 EQUB &C0, &22, &E0, &C0, &E0, &C0, &80, &C0  ; AA3C: C0 22 E0... .".
 EQUB &24, &02, &21, &0E, &20, &00, &84, &02  ; AA44: 24 02 21... $.!
 EQUB &57, &00, &32, &0B, &02, &20, &10, &02  ; AA4C: 57 00 32... W.2
 EQUB &FF, &21, &1F, &FF, &57, &8B, &21, &01  ; AA54: FF 21 1F... .!.
 EQUB &02, &FF, &F8, &FF, &D4, &A2, &03, &D4  ; AA5C: 02 FF F8... ...
 EQUB &00, &A0, &80, &21, &08, &10, &24, &80  ; AA64: 00 A0 80... ...
 EQUB &E0, &21, &08, &00, &42, &3D, &15, &04  ; AA6C: E0 21 08... .!.
 EQUB &3F, &0E, &1F, &11, &04, &00, &0C, &07  ; AA74: 3F 0E 1F... ?..
 EQUB &8B, &01, &04, &04, &80, &F8, &7F, &BF  ; AA7C: 8B 01 04... ...
 EQUB &21, &15, &03, &32, &03, &3F, &FD, &FA  ; AA84: 21 15 03... !..
 EQUB &50, &02, &61, &C0, &A3, &00, &41, &21  ; AA8C: 50 02 61... P.a
 EQUB &01, &02, &50, &40, &F8, &E0, &F0, &10  ; AA94: 01 02 50... ..P
 EQUB &40, &00, &3F, &02, &7F, &7B, &34, &17  ; AA9C: 40 00 3F... @.?
 EQUB &1F, &1F, &0F, &03, &32, &0C, &08, &05  ; AAA4: 1F 1F 0F... ...
 EQUB &12, &22, &E3, &41, &80, &06, &80, &03  ; AAAC: 12 22 E3... .".
 EQUB &FF, &BF, &7C, &FC, &F4, &F8, &03, &C0  ; AAB4: FF BF 7C... ..|
 EQUB &80, &00, &21, &08, &00, &31, &02, &23  ; AABC: 80 00 21... ..!
 EQUB &07, &32, &05, &02, &03, &24, &02, &03  ; AAC4: 07 32 05... .2.
 EQUB &20, &23, &70, &50, &20, &03, &24, &20  ; AACC: 20 23 70...  #p
 EQUB &0A, &40, &0F, &21, &01, &09, &20, &40  ; AAD4: 0A 40 0F... .@.
 EQUB &30, &34, &28, &14, &0F, &05, &22, &40  ; AADC: 30 34 28... 04(
 EQUB &22, &20, &10, &33, &08, &04, &03, &07  ; AAE4: 22 20 10... " .
 EQUB &FF, &09, &35, &02, &01, &06, &0A, &14  ; AAEC: FF 09 35... ..5
 EQUB &78, &D0, &22, &01, &22, &02, &32, &04  ; AAF4: 78 D0 22... x."
 EQUB &08, &10, &60, &32, &03, &01, &07, &21  ; AAFC: 08 10 60... ..`
 EQUB &01, &06, &63, &D5, &77, &5D, &32, &22  ; AB04: 01 06 63... ..c
 EQUB &1C, &02, &DD, &22, &36, &32, &3E, &1C  ; AB0C: 1C 02 DD... ...
 EQUB &03, &60, &C0, &06, &80, &40, &06, &3F  ; AB14: 03 60 C0... .`.
 EQUB &08, &40, &90, &68, &54, &21, &26, &59  ; AB1C: 08 40 90... .@.
 EQUB &DA, &21, &2E, &04, &80, &40, &A0, &D0  ; AB24: DA 21 2E... .!.
 EQUB &03, &35, &01, &03, &0A, &00, &21, &10  ; AB2C: 03 35 01... .5.
 EQUB &48, &68, &D4, &B0, &40, &B4, &A4, &21  ; AB34: 48 68 D4... Hh.
 EQUB &37, &F5, &DF, &FB, &7F, &FF, &21, &1F  ; AB3C: 37 F5 DF... 7..
 EQUB &7F, &60, &D8, &22, &FC, &12, &F7, &FB  ; AB44: 7F 60 D8... .`.
 EQUB &05, &20, &D0, &68, &02, &21, &01, &02  ; AB4C: 05 20 D0... . .
 EQUB &32, &0D, &3A, &65, &76, &AA, &9B, &65  ; AB54: 32 0D 3A... 2.:
 EQUB &6D, &9B, &BF, &67, &60, &D4, &70, &BC  ; AB5C: 6D 9B BF... m..
 EQUB &FC, &70, &F8, &F0, &37, &3F, &19, &1E  ; AB64: FC 70 F8... .p.
 EQUB &0D, &06, &05, &01, &00, &4D, &F6, &9A  ; AB6C: 0D 06 05... ...
 EQUB &ED, &21, &35, &D7, &99, &4B, &30, &D2  ; AB74: ED 21 35... .!5
 EQUB &DC, &21, &2E, &EB, &57, &B1, &6E, &04  ; AB7C: DC 21 2E... .!.
 EQUB &A0, &00, &C8, &D4, &03, &33, &06, &15  ; AB84: A0 00 C8... ...
 EQUB &2A, &46, &9B, &8D, &21, &33, &5D, &66  ; AB8C: 2A 46 9B... *F.
 EQUB &BB, &DF, &EF, &BF, &7D, &B7, &BF, &FF  ; AB94: BB DF EF... ...
 EQUB &FD, &F8, &F0, &C8, &A0, &22, &C0, &80  ; AB9C: FD F8 F0... ...
 EQUB &04, &3A, &24, &1B, &0D, &06, &01, &04  ; ABA4: 04 3A 24... .:$
 EQUB &05, &0E, &D6, &35, &CF, &72, &5D, &CD  ; ABAC: 05 0E D6... ...
 EQUB &66, &21, &3A, &62, &B8, &5E, &EB, &AD  ; ABB4: 66 21 3A... f!:
 EQUB &B7, &DA, &6F, &04, &22, &C4, &F6, &FF  ; ABBC: B7 DA 6F... ..o
 EQUB &05, &38, &01, &02, &06, &02, &01, &0E  ; ABC4: 05 38 01... .8.
 EQUB &15, &2B, &FF, &7F, &FF, &DD, &6F, &F7  ; ABCC: 15 2B FF... .+.
 EQUB &BF, &FB, &DF, &FF, &FE, &FF, &7F, &FC  ; ABD4: BF FB DF... ...
 EQUB &FB, &EE, &DE, &BF, &FA, &10, &23, &80  ; ABDC: FB EE DE... ...
 EQUB &04, &21, &0D, &02, &21, &18, &00, &21  ; ABE4: 04 21 0D... .!.
 EQUB &08, &02, &36, &31, &04, &41, &04, &00  ; ABEC: 08 02 36... ..6
 EQUB &02, &02, &AD, &97, &21, &37, &4A, &BB  ; ABF4: 02 02 AD... ...
 EQUB &21, &0D, &57, &92, &FD, &7F, &F7, &FF  ; ABFC: 21 0D 57... !.W
 EQUB &FB, &F7, &EF, &FF, &02, &80, &C0, &F0  ; AC04: FB F7 EF... ...
 EQUB &F8, &D6, &7B, &05, &36, &01, &03, &07  ; AC0C: F8 D6 7B... ..{
 EQUB &03, &05, &2B, &53, &7F, &FD, &F7, &BE  ; AC14: 03 05 2B... ..+
 EQUB &BF, &9F, &FC, &FE, &B6, &BB, &BA, &B5  ; AC1C: BF 9F FC... ...
 EQUB &F6, &9B, &E9, &9C, &66, &58, &A2, &21  ; AC24: F6 9B E9... ...
 EQUB &28, &FF, &61, &81, &92, &00, &81, &00  ; AC2C: 28 FF 61... (.a
 EQUB &21, &03, &22, &80, &00, &23, &80, &02  ; AC34: 21 03 22... !."
 EQUB &31, &08, &23, &04, &33, &02, &03, &01  ; AC3C: 31 08 23... 1.#
 EQUB &06, &21, &08, &20, &82, &38, &2B, &0D  ; AC44: 06 21 08... .!.
 EQUB &43, &15, &09, &02, &04, &03, &FF, &FE  ; AC4C: 43 15 09... C..
 EQUB &77, &FF, &7F, &12, &7F, &ED, &BA, &DD  ; AC54: 77 FF 7F... w..
 EQUB &6A, &F6, &5B, &ED, &FD, &22, &80, &C0  ; AC5C: 6A F6 5B... j.[
 EQUB &E0, &B8, &44, &B3, &51, &07, &80, &04  ; AC64: E0 B8 44... ..D
 EQUB &40, &60, &40, &50, &04, &22, &10, &22  ; AC6C: 40 60 40... @`@
 EQUB &30, &04, &37, &01, &03, &0A, &17, &04  ; AC74: 30 04 37... 0.7
 EQUB &0F, &3F, &F5, &9F, &6B, &6F, &7F, &EF  ; AC7C: 0F 3F F5... .?.
 EQUB &FD, &7C, &FA, &F0, &E4, &C0, &93, &32  ; AC84: FD 7C FA... .|.
 EQUB &35, &3A, &6A, &74, &73, &CC, &F1, &C8  ; AC8C: 35 3A 6A... 5:j
 EQUB &40, &90, &40, &20, &02, &80, &37, &01  ; AC94: 40 90 40... @.@
 EQUB &09, &01, &05, &0A, &0B, &26, &9E, &48  ; AC9C: 09 01 05... ...
 EQUB &00, &80, &06, &50, &64, &21, &31, &10  ; ACA4: 00 80 06... ...
 EQUB &33, &0E, &02, &01, &03, &21, &02, &00  ; ACAC: 33 0E 02... 3..
 EQUB &80, &02, &80, &FF, &21, &3F, &DF, &21  ; ACB4: 80 02 80... ...
 EQUB &37, &9D, &21, &2D, &4A, &21, &1B, &FB  ; ACBC: 37 9D 21... 7.!
 EQUB &7E, &FF, &BF, &FF, &E7, &FF, &7B, &AD  ; ACC4: 7E FF BF... ~..
 EQUB &AA, &D3, &75, &DC, &EB, &FE, &F7, &22  ; ACCC: AA D3 75... ..u
 EQUB &C0, &40, &A8, &F0, &9E, &EF, &74, &23  ; ACD4: C0 40 A8... .@.
 EQUB &30, &21, &12, &52, &21, &31, &20, &21  ; ACDC: 30 21 12... 0!.
 EQUB &23, &23, &40, &23, &60, &40, &20, &03  ; ACE4: 23 23 40... ##@
 EQUB &23, &01, &33, &03, &0F, &3B, &72, &EE  ; ACEC: 23 01 33... #.3
 EQUB &F7, &BB, &21, &3F, &77, &7F, &BE, &FE  ; ACF4: F7 BB 21... ..!
 EQUB &D9, &F4, &F0, &C0, &83, &21, &04, &47  ; ACFC: D9 F4 F0... ...
 EQUB &33, &1B, &26, &2C, &98, &B8, &64, &D0  ; AD04: 33 1B 26... 3.&
 EQUB &A2, &B0, &80, &C8, &20, &00, &40, &C1  ; AD0C: A2 B0 80... ...
 EQUB &37, &01, &0A, &05, &26, &1B, &CA, &26  ; AD14: 37 01 0A... 7..
 EQUB &8C, &70, &B0, &F0, &C0, &04, &40, &60  ; AD1C: 8C 70 B0... .p.
 EQUB &21, &18, &D6, &C2, &21, &01, &C0, &88  ; AD24: 21 18 D6... !..
 EQUB &38, &21, &15, &08, &0A, &00, &09, &00  ; AD2C: 38 21 15... 8!.
 EQUB &04, &FF, &BE, &DF, &D7, &7B, &21, &2F  ; AD34: 04 FF BE... ...
 EQUB &B5, &21, &2B, &FD, &FF, &FE, &DF, &13  ; AD3C: B5 21 2B... .!+
 EQUB &CF, &9B, &ED, &DF, &B3, &ED, &7B, &ED  ; AD44: CF 9B ED... ...
 EQUB &F6, &23, &80, &40, &60, &C0, &E0, &60  ; AD4C: F6 23 80... .#.
 EQUB &D0, &F0, &E5, &73, &34, &2F, &17, &0E  ; AD54: D0 F0 E5... ...
 EQUB &1F, &70, &F0, &60, &30, &20, &22, &C0  ; AD5C: 1F 70 F0... .p.
 EQUB &40, &34, &1E, &0B, &2E, &13, &7F, &6D  ; AD64: 40 34 1E... @4.
 EQUB &32, &2F, &2B, &FE, &FC, &B9, &22, &F4  ; AD6C: 32 2F 2B... 2/+
 EQUB &F0, &22, &E8, &4D, &32, &13, &36, &5D  ; AD74: F0 22 E8... .".
 EQUB &68, &5B, &78, &92, &90, &69, &80, &B1  ; AD7C: 68 5B 78... h[x
 EQUB &41, &39, &02, &0E, &04, &05, &13, &0A  ; AD84: 41 39 02... A9.
 EQUB &05, &34, &16, &5D, &6D, &30, &60, &F0  ; AD8C: 05 34 16... .4.
 EQUB &60, &30, &78, &D0, &B8, &A0, &C1, &21  ; AD94: 60 30 78... `0x
 EQUB &24, &88, &10, &40, &48, &30, &00, &32  ; AD9C: 24 88 10... $..
 EQUB &02, &01, &00, &81, &00, &21, &02, &80  ; ADA4: 02 01 00... ...
 EQUB &56, &35, &13, &09, &06, &81, &05, &40  ; ADAC: 56 35 13... V5.
 EQUB &A1, &F7, &7B, &EF, &EB, &55, &D6, &21  ; ADB4: A1 F7 7B... ..{
 EQUB &2B, &95, &DB, &22, &FD, &F7, &FE, &FB  ; ADBC: 2B 95 DB... +..
 EQUB &BF, &FD, &70, &60, &25, &E0, &C0, &03  ; ADC4: BF FD 70... ..p
 EQUB &21, &0E, &04, &32, &0F, &0C, &43, &64  ; ADCC: 21 0E 04... !..
 EQUB &32, &13, &3B, &BB, &45, &80, &B0, &A8  ; ADD4: 32 13 3B... 2.;
 EQUB &21, &13, &F8, &F0, &D0, &00, &6F, &77  ; ADDC: 21 13 F8... !..
 EQUB &7F, &77, &7F, &33, &37, &2E, &1B, &F0  ; ADE4: 7F 77 7F... .w.
 EQUB &C5, &B0, &D0, &60, &98, &C2, &E8, &23  ; ADEC: C5 B0 D0... ...
 EQUB &50, &A0, &21, &32, &61, &21, &19, &BE  ; ADF4: 50 A0 21... P.!
 EQUB &32, &0C, &21, &58, &B2, &E5, &21, &21  ; ADFC: 32 0C 21... 2.!
 EQUB &CC, &32, &07, &36, &6A, &6F, &DD, &73  ; AE04: CC 32 07... .2.
 EQUB &BE, &ED, &5B, &22, &F0, &D8, &78, &22  ; AE0C: BE ED 5B... ..[
 EQUB &E0, &F0, &C0, &36, &34, &11, &0C, &06  ; AE14: E0 F0 C0... ...
 EQUB &03, &01, &03, &21, &01, &00, &40, &21  ; AE1C: 03 01 03... ...
 EQUB &01, &60, &90, &48, &30, &4E, &57, &B5  ; AE24: 01 60 90... .`.
 EQUB &21, &2F, &5E, &47, &21, &37, &A6, &5E  ; AE2C: 21 2F 5E... !/^
 EQUB &35, &13, &2D, &26, &15, &0B, &81, &FB  ; AE34: 35 13 2D... 5.-
 EQUB &12, &7B, &12, &7D, &FE, &23, &80, &04  ; AE3C: 12 7B 12... .{.
 EQUB &C0, &03, &21, &1F, &71, &36, &08, &03  ; AE44: C0 03 21... ..!
 EQUB &05, &3D, &11, &04, &77, &F0, &32, &0F  ; AE4C: 05 3D 11... .=.
 EQUB &03, &42, &20, &80, &20, &F6, &FF, &89  ; AE54: 03 42 20... .B
 EQUB &00, &40, &03, &C0, &80, &03, &22, &0B  ; AE5C: 00 40 03... .@.
 EQUB &36, &0F, &0D, &0B, &07, &07, &0F, &90  ; AE64: 36 0F 0D... 6..
 EQUB &64, &D0, &D4, &A8, &E8, &44, &50, &21  ; AE6C: 64 D0 D4... d..
 EQUB &3D, &48, &34, &18, &38, &2E, &3E, &7E  ; AE74: 3D 48 34... =H4
 EQUB &58, &21, &11, &4C, &21, &27, &91, &21  ; AE7C: 58 21 11... X!.
 EQUB &28, &4E, &32, &11, &05, &BF, &EF, &21  ; AE84: 28 4E 32... (N2
 EQUB &37, &DF, &BA, &B4, &68, &D0, &60, &22  ; AE8C: 37 DF BA... 7..
 EQUB &80, &05, &3C, &38, &18, &0E, &06, &03  ; AE94: 80 05 3C... ..<
 EQUB &02, &07, &0A, &13, &4B, &09, &1F, &58  ; AE9C: 02 07 0A... ...
 EQUB &E4, &21, &26, &C6, &32, &0D, &03, &8B  ; AEA4: E4 21 26... .!&
 EQUB &CF, &F8, &00, &44, &FF, &BF, &7F, &FB  ; AEAC: CF F8 00... ...
 EQUB &FE, &32, &0F, &1B, &9F, &CF, &60, &A2  ; AEB4: FE 32 0F... .2.
 EQUB &B9, &FB, &46, &33, &25, &37, &37, &10  ; AEBC: B9 FB 46... ..F
 EQUB &93, &59, &68, &DC, &F6, &BA, &EF, &8F  ; AEC4: 93 59 68... .Yh
 EQUB &BD, &BF, &FF, &DC, &C7, &55, &21, &05  ; AECC: BD BF FF... ...
 EQUB &E1, &F1, &E2, &F2, &BF, &68, &D0, &D7  ; AED4: E1 F1 E2... ...
 EQUB &21, &12, &B3, &21, &02, &DB, &FF, &30  ; AEDC: 21 12 B3... !..
 EQUB &00, &E9, &22, &77, &5F, &FE, &83, &32  ; AEE4: 00 E9 22... .."
 EQUB &02, &03, &FB, &E8, &88, &61, &21, &32  ; AEEC: 02 03 FB... ...
 EQUB &A7, &20, &00, &21, &02, &78, &21, &3E  ; AEF4: A7 20 00... . .
 EQUB &D4, &80, &FE, &02, &DA, &33, &22, &0A  ; AEFC: D4 80 FE... ...
 EQUB &05, &50, &C3, &42, &52, &49, &60, &C0  ; AF04: 05 50 C3... .P.
 EQUB &80, &06, &21, &01, &06, &21, &2A, &40  ; AF0C: 80 06 21... ..!
 EQUB &FB, &03, &32, &3F, &0F, &55, &80, &FF  ; AF14: FB 03 32... ..2
 EQUB &03, &FF, &EB, &32, &01, &06, &80, &03  ; AF1C: 03 FF EB... ...
 EQUB &EC, &21, &31, &E6, &E7, &31, &27, &23  ; AF24: EC 21 31... .!1
 EQUB &07, &77, &21, &17, &22, &80, &5F, &00  ; AF2C: 07 77 21... .w!
 EQUB &FF, &7F, &22, &80, &34, &16, &08, &F6  ; AF34: FF 7F 22... .."
 EQUB &08, &E8, &EE, &37, &0C, &07, &32, &33  ; AF3C: 08 E8 EE... ...
 EQUB &73, &3A, &3A, &BA, &22, &BB, &FF, &FE  ; AF44: 73 3A 3A... s::
 EQUB &F4, &02, &F7, &E0, &F8, &37, &15, &05  ; AF4C: F4 02 F7... ...
 EQUB &9C, &0E, &14, &96, &0E, &4E, &22, &80  ; AF54: 9C 0E 14... ...
 EQUB &02, &80, &00, &40, &5F, &3B, &18, &0A  ; AF5C: 02 80 00... ...
 EQUB &2A, &0C, &0A, &2C, &0E, &CC, &03, &02  ; AF64: 2A 0C 0A... *..
 EQUB &01, &02, &21, &25, &84, &F4, &10, &D4  ; AF6C: 01 02 21... ..!
 EQUB &94, &35, &18, &1F, &1F, &18, &1C, &92  ; AF74: 94 35 18... .5.
 EQUB &00, &4D, &21, &1D, &FF, &FE, &02, &21  ; AF7C: 00 4D 21... .M!
 EQUB &25, &5B, &7B, &02, &40, &41, &C0, &FF  ; AF84: 25 5B 7B... %[{
 EQUB &40, &A4, &03, &9D, &00, &FF, &21, &0A  ; AF8C: 40 A4 03... @..
 EQUB &04, &FF, &47, &E0, &20, &10, &03, &F0  ; AF94: 04 FF 47... ..G
 EQUB &40, &21, &06, &07, &9D, &03, &34, &37  ; AF9C: 40 21 06... @!.
 EQUB &0D, &02, &01, &40, &03, &FD, &BF, &FF  ; AFA4: 0D 02 01... ...
 EQUB &FB, &34, &07, &03, &07, &0B, &A7, &60  ; AFAC: FB 34 07... .4.
 EQUB &22, &C0, &02, &13, &03, &32, &1E, &08  ; AFB4: 22 C0 02... "..
 EQUB &F8, &F0, &FB, &36, &02, &0C, &08, &3B  ; AFBC: F8 F0 FB... ...
 EQUB &3C, &1F, &5F, &7F, &22, &80, &00, &F3  ; AFC4: 3C 1F 5F... <._
 EQUB &21, &0E, &13, &03, &56, &21, &06, &22  ; AFCC: 21 0E 13... !..
 EQUB &8E, &9E, &03, &E0, &4B, &00, &80, &96  ; AFD4: 8E 9E 03... ...
 EQUB &21, &3F, &7F, &7E, &21, &0F, &8F, &32  ; AFDC: 21 3F 7F... !?.
 EQUB &1E, &1C, &8E, &03, &94, &FF, &02, &21  ; AFE4: 1E 1C 8E... ...
 EQUB &32, &FE, &7E, &FF, &33, &1C, &1B, &1F  ; AFEC: 32 FE 7E... 2.~
 EQUB &FF, &7F, &03, &A6, &21, &2E, &13, &03  ; AFF4: FF 7F 03... ...
 EQUB &64, &80, &00, &40, &FF, &C1, &40, &00  ; AFFC: 64 80 00... d..
 EQUB &10, &03, &FE, &21, &08, &00, &21, &04  ; B004: 10 03 FE... ...
 EQUB &03, &10, &E0, &80, &02, &80, &07, &FF  ; B00C: 03 10 E0... ...
 EQUB &34, &3D, &1F, &07, &03, &03, &C0, &22  ; B014: 34 3D 1F... 4=.
 EQUB &80, &FF, &21, &22, &90, &32, &02, &1F  ; B01C: 80 FF 21... ..!
 EQUB &03, &FF, &00, &21, &05, &12, &32, &0B  ; B024: 03 FF 00... ...
 EQUB &19, &10, &FF, &21, &0F, &AF, &12, &03  ; B02C: 19 10 FF... ...
 EQUB &15, &03, &FC, &14, &03, &EF, &8F, &5F  ; B034: 15 03 FC... ...
 EQUB &9F, &BF, &21, &3E, &BF, &FF, &7F, &21  ; B03C: 9F BF 21... ..!
 EQUB &3F, &FF, &9F, &FF, &22, &01, &00, &6C  ; B044: 3F FF 9F... ?..
 EQUB &15, &23, &FE, &14, &03, &59, &14, &02  ; B04C: 15 23 FE... .#.
 EQUB &32, &01, &28, &FC, &13, &65, &D7, &BA  ; B054: 32 01 28... 2.(
 EQUB &7F, &78, &F8, &22, &C0, &68, &E0, &0A  ; B05C: 7F 78 F8... .x.
 EQUB &33, &0F, &17, &07, &05, &14, &04, &15  ; B064: 33 0F 17... 3..
 EQUB &7E, &FE, &FF, &FD, &F9, &12, &21, &3F  ; B06C: 7E FE FF... ~..
 EQUB &7F, &12, &FD, &FF, &22, &FC, &13, &F3  ; B074: 7F 12 FD... ...
 EQUB &FF, &F9, &FF, &FD, &FF, &C0, &22, &F0  ; B07C: FF F9 FF... ...
 EQUB &15, &03, &15, &03, &12, &FC, &F8, &FF  ; B084: 15 03 15... ...
 EQUB &03, &C0, &80, &02, &FF, &00, &34, &31  ; B08C: 03 C0 80... ...
 EQUB &04, &00, &03, &02, &BF, &21, &1E, &CD  ; B094: 04 00 03... ...
 EQUB &32, &26, &37, &EA, &58, &20, &E7, &FF  ; B09C: 32 26 37... 2&7
 EQUB &FD, &21, &25, &FF, &80, &5F, &21, &0F  ; B0A4: FD 21 25... .!%
 EQUB &E4, &F1, &B0, &21, &3F, &64, &4B, &5E  ; B0AC: E4 F1 B0... ...
 EQUB &BF, &22, &7F, &81, &FF, &4A, &21, &28  ; B0B4: BF 22 7F... .".
 EQUB &AD, &DF, &7E, &F3, &33, &3F, &01, &02  ; B0BC: AD DF 7E... ..~
 EQUB &FE, &C9, &F8, &E2, &00, &21, &1D, &22  ; B0C4: FE C9 F8... ...
 EQUB &FC, &10, &60, &40, &20, &80, &08, &22  ; B0CC: FC 10 60... ..`
 EQUB &01, &22, &03, &32, &07, &0F, &B3, &79  ; B0D4: 01 22 03... .".
 EQUB &ED, &E4, &40, &82, &32, &1B, &1D, &B0  ; B0DC: ED E4 40... ..@
 EQUB &D0, &E8, &F8, &6C, &21, &3C, &DA, &4E  ; B0E4: D0 E8 F8... ...
 EQUB &21, &0A, &07, &F7, &35, &1F, &1B, &3F  ; B0EC: 21 0A 07... !..
 EQUB &1F, &1E, &5F, &5D, &84, &03, &23, &80  ; B0F4: 1F 1E 5F... .._
 EQUB &C0, &21, &3E, &79, &68, &82, &21, &2D  ; B0FC: C0 21 3E... .!>
 EQUB &5B, &32, &2C, &2D, &22, &C0, &60, &20  ; B104: 5B 32 2C... [2,
 EQUB &00, &80, &C0, &80, &51, &34, &38, &3F  ; B10C: 00 80 C0... ...
 EQUB &11, &0B, &03, &20, &40, &00, &80, &04  ; B114: 11 0B 03... ...
 EQUB &3F, &13, &05, &30, &48, &84, &82, &81  ; B11C: 3F 13 05... ?..
 EQUB &80, &00, &80, &05, &80, &40, &20, &04  ; B124: 80 00 80... ...
 EQUB &34, &01, &06, &0C, &18, &00, &30, &58  ; B12C: 34 01 06... 4..
 EQUB &88, &24, &0C, &80, &05, &20, &00, &34  ; B134: 88 24 0C... .$.
 EQUB &18, &04, &02, &03, &02, &32, &08, &04  ; B13C: 18 04 02... ...
 EQUB &04, &80, &C0, &20, &90, &03, &33, &03  ; B144: 04 80 C0... ...
 EQUB &06, &08, &10, &22, &20, &40, &80, &05  ; B14C: 06 08 10... ...
 EQUB &23, &0C, &22, &08, &21, &18, &10, &30  ; B154: 23 0C 22... #."
 EQUB &00, &34, &06, &01, &02, &01, &03, &B2  ; B15C: 00 34 06... .4.
 EQUB &21, &09, &65, &21, &12, &CA, &21, &28  ; B164: 21 09 65... !.e
 EQUB &66, &21, &34, &CC, &34, &2C, &23, &D1  ; B16C: 66 21 34... f!4
 EQUB &14, &A8, &4E, &91, &03, &80, &40, &E0  ; B174: 14 A8 4E... ..N
 EQUB &30, &21, &28, &00, &34, &01, &03, &04  ; B17C: 30 21 28... 0!(
 EQUB &08, &10, &20, &22, &40, &80, &09, &34  ; B184: 08 10 20... ..
 EQUB &01, &03, &06, &0C, &30, &22, &60, &C0  ; B18C: 01 03 06... ...
 EQUB &80, &04, &39, &1B, &04, &02, &01, &00  ; B194: 80 04 39... ..9
 EQUB &02, &06, &05, &29, &CA, &30, &8D, &A2  ; B19C: 02 06 05... ...
 EQUB &32, &32, &19, &85, &9C, &47, &A1, &21  ; B1A4: 32 32 19... 22.
 EQUB &14, &52, &48, &21, &25, &90, &02, &80  ; B1AC: 14 52 48... .RH
 EQUB &C0, &34, &22, &32, &0A, &02, &04, &23  ; B1B4: C0 34 22... .4"
 EQUB &01, &35, &03, &01, &02, &04, &08, &10  ; B1BC: 01 35 03... .5.
 EQUB &00, &80, &08, &21, &01, &02, &32, &03  ; B1C4: 00 80 08... ...
 EQUB &04, &10, &20, &42, &21, &07, &E0, &40  ; B1CC: 04 10 20... ..
 EQUB &06, &31, &06, &27, &0F, &CE, &FB, &BE  ; B1D4: 06 31 06... .1.
 EQUB &FB, &FF, &FD, &12, &52, &68, &C8, &B5  ; B1DC: FB FF FD... ...
 EQUB &44, &F2, &A8, &6D, &21, &03, &81, &21  ; B1E4: 44 F2 A8... D..
 EQUB &08, &00, &32, &04, &08, &10, &02, &80  ; B1EC: 08 00 32... ..2
 EQUB &C0, &60, &30, &33, &18, &0C, &06, &06  ; B1F4: C0 60 30... .`0
 EQUB &36, &01, &03, &06, &0E, &1C, &38, &60  ; B1FC: 36 01 03... 6..
 EQUB &C0, &80, &21, &01, &22, &40, &32, &03  ; B204: C0 80 21... ..!
 EQUB &01, &49, &44, &45, &4A, &21, &09, &64  ; B20C: 01 49 44... .ID
 EQUB &21, &16, &63, &99, &A7, &5D, &D7, &21  ; B214: 21 16 63... !.c
 EQUB &03, &9F, &7F, &6D, &FF, &7F, &12, &02  ; B21C: 03 9F 7F... ...
 EQUB &26, &80, &31, &07, &23, &03, &21, &01  ; B224: 26 80 31... &.1
 EQUB &03, &17, &7F, &D4, &F2, &BC, &EA, &F6  ; B22C: 03 17 7F... ...
 EQUB &FD, &FB, &FC, &02, &88, &00, &80, &02  ; B234: FD FB FC... ...
 EQUB &80, &32, &03, &01, &07, &C0, &60, &30  ; B23C: 80 32 03... .2.
 EQUB &34, &18, &0C, &06, &03, &0E, &22, &20  ; B244: 34 18 0C... 4..
 EQUB &0D, &35, &01, &07, &0C, &0E, &18, &30  ; B24C: 0D 35 01... .5.
 EQUB &60, &C0, &80, &03, &36, &02, &03, &05  ; B254: 60 C0 80... `..
 EQUB &0F, &1B, &3F, &6E, &CA, &C5, &95, &8B  ; B25C: 0F 1B 3F... ..?
 EQUB &8C, &33, &33, &0E, &37, &BF, &6F, &BF  ; B264: 8C 33 33... .33
 EQUB &DF, &12, &7F, &15, &22, &FE, &22, &FC  ; B26C: DF 12 7F... ...
 EQUB &80, &07, &36, &3F, &1F, &0F, &0F, &03  ; B274: 80 07 36... ..6
 EQUB &01, &02, &12, &FD, &14, &7F, &00, &C0  ; B27C: 01 02 12... ...
 EQUB &20, &C8, &62, &D2, &B5, &E4, &00, &80  ; B284: 20 C8 62...  .b
 EQUB &00, &40, &00, &21, &18, &00, &84, &08  ; B28C: 00 40 00... .@.
 EQUB &80, &60, &30, &35, &18, &0C, &04, &02  ; B294: 80 60 30... .`0
 EQUB &03, &00, &23, &20, &21, &24, &46, &22  ; B29C: 03 00 23... ..#
 EQUB &50, &23, &20, &03, &20, &40, &04, &36  ; B2A4: 50 23 20... P#
 EQUB &01, &03, &07, &06, &1C, &38, &70, &E0  ; B2AC: 01 03 07... ...
 EQUB &C0, &80, &02, &22, &01, &34, &06, &0B  ; B2B4: C0 80 02... ...
 EQUB &0F, &3F, &7F, &FF, &BC, &FC, &F9, &F3  ; B2BC: 0F 3F 7F... .?.
 EQUB &E7, &C7, &9B, &21, &2F, &5D, &4F, &7F  ; B2C4: E7 C7 9B... ...
 EQUB &21, &37, &DF, &FF, &22, &BF, &16, &FC  ; B2CC: 21 37 DF... !7.
 EQUB &22, &F8, &F0, &E0, &C0, &80, &03, &32  ; B2D4: 22 F8 F0... "..
 EQUB &3F, &1F, &47, &63, &79, &FC, &12, &DE  ; B2DC: 3F 1F 47... ?.G
 EQUB &EA, &F7, &F5, &FF, &F6, &FF, &FB, &00  ; B2E4: EA F7 F5... ...
 EQUB &41, &20, &21, &28, &84, &D0, &4A, &D4  ; B2EC: 41 20 21... A !
 EQUB &03, &20, &03, &10, &21, &01, &08, &80  ; B2F4: 03 20 03... . .
 EQUB &23, &C0, &22, &60, &E0, &34, &32, &12  ; B2FC: 23 C0 22... #."
 EQUB &12, &04, &10, &00, &21, &11, &03, &10  ; B304: 12 04 10... ...
 EQUB &22, &40, &02, &80, &34, &0C, &1C, &18  ; B30C: 22 40 02... "@.
 EQUB &38, &22, &30, &22, &70, &38, &01, &03  ; B314: 38 22 30... 8"0
 EQUB &06, &0B, &0B, &0F, &17, &17, &BE, &FC  ; B31C: 06 0B 0B... ...
 EQUB &F9, &F2, &F7, &E4, &E7, &ED, &6F, &97  ; B324: F9 F2 F7... ...
 EQUB &7F, &4F, &BF, &17, &FE, &F9, &FB, &FF  ; B32C: 7F 4F BF... .O.
 EQUB &F0, &C0, &80, &30, &22, &F0, &F8, &F0  ; B334: F0 C0 80... ...
 EQUB &25, &7F, &22, &3F, &21, &1F, &FF, &FD  ; B33C: 25 7F 22... %."
 EQUB &FE, &FF, &FE, &FF, &FD, &FF, &A9, &EC  ; B344: FE FF FE... ...
 EQUB &F6, &F9, &7E, &FA, &BF, &5E, &21, &08  ; B34C: F6 F9 7E... ..~
 EQUB &84, &10, &21, &14, &AA, &21, &29, &D4  ; B354: 84 10 21... ..!
 EQUB &6A, &04, &22, &01, &41, &21, &03, &25  ; B35C: 6A 04 22... j."
 EQUB &E0, &23, &C0, &03, &21, &01, &05, &21  ; B364: E0 23 C0... .#.
 EQUB &21, &A4, &93, &22, &7A, &7F, &21, &3F  ; B36C: 21 A4 93... !..
 EQUB &02, &30, &6C, &60, &23, &E0, &23, &70  ; B374: 02 30 6C... .0l
 EQUB &22, &30, &37, &18, &19, &0C, &0F, &3B  ; B37C: 22 30 37... "07
 EQUB &4F, &2F, &9F, &67, &32, &3D, &17, &23  ; B384: 4F 2F 9F... O/.
 EQUB &EF, &FF, &EF, &FF, &22, &F7, &1F, &11  ; B38C: EF FF EF... ...
 EQUB &22, &F8, &24, &F0, &22, &E0, &22, &0F  ; B394: 22 F8 24... ".$
 EQUB &33, &07, &03, &01, &03, &FF, &FE, &12  ; B39C: 33 07 03... 3..
 EQUB &FE, &FF, &7F, &21, &3F, &CF, &B1, &A8  ; B3A4: FE FF 7F... ...
 EQUB &4A, &D0, &A1, &B8, &C8, &59, &A1, &EC  ; B3AC: 4A D0 A1... J..
 EQUB &D2, &D9, &EA, &F4, &FE, &23, &03, &87  ; B3B4: D2 D9 EA... ...
 EQUB &22, &03, &83, &21, &01, &C0, &27, &80  ; B3BC: 22 03 83... "..
 EQUB &04, &21, &0C, &00, &21, &01, &05, &21  ; B3C4: 04 21 0C... .!.
 EQUB &06, &00, &F8, &21, &1D, &C0, &05, &FC  ; B3CC: 06 00 F8... ...
 EQUB &80, &04, &70, &03, &22, &04, &00, &21  ; B3D4: 80 04 70... ..p
 EQUB &02, &04, &6F, &9B, &34, &2F, &2B, &57  ; B3DC: 02 04 6F... ..o
 EQUB &17, &BB, &AF, &FB, &13, &23, &FD, &1C  ; B3E4: 17 BB AF... ...
 EQUB &FE, &FC, &F8, &F0, &E0, &22, &C0, &06  ; B3EC: FE FC F8... ...
 EQUB &33, &0F, &07, &03, &24, &01, &21, &07  ; B3F4: 33 0F 07... 3..
 EQUB &EC, &B4, &F6, &E0, &E7, &23, &E3, &F2  ; B3FC: EC B4 F6... ...
 EQUB &FC, &74, &30, &12, &BB, &00, &40, &80  ; B404: FC 74 30... .t0
 EQUB &02, &F0, &E0, &60, &00, &C0, &7F, &21  ; B40C: 02 F0 E0... ...
 EQUB &06, &00, &31, &38, &23, &18, &21, &01  ; B414: 06 00 31... ..1
 EQUB &00, &A0, &05, &F0, &03, &38, &1F, &0C  ; B41C: 00 A0 05... ...
 EQUB &0E, &0E, &18, &08, &01, &00, &23, &0F  ; B424: 0E 0E 18... ...
 EQUB &21, &08, &00, &4F, &FF, &00, &13, &32  ; B42C: 21 08 00... !..
 EQUB &1E, &18, &E0, &80, &21, &01, &FC, &FD  ; B434: 1E 18 E0... ...
 EQUB &FC, &32, &04, &17, &77, &9F, &CF, &7F  ; B43C: FC 32 04... .2.
 EQUB &22, &3F, &21, &3D, &FF, &F9, &FB, &14  ; B444: 22 3F 21... "?!
 EQUB &21, &25, &13, &BF, &BE, &22, &BC, &BE  ; B44C: 21 25 13... !%.
 EQUB &C0, &80, &0E, &32, &15, &3F, &06, &AA  ; B454: C0 80 0E... ...
 EQUB &7F, &05, &21, &14, &12, &7F, &03, &21  ; B45C: 7F 05 21... ..!
 EQUB &13, &CE, &23, &C3, &23, &03, &83, &E3  ; B464: 13 CE 23... ..#
 EQUB &02, &80, &12, &80, &03, &21, &02, &00  ; B46C: 02 80 12... ...
 EQUB &22, &F0, &10, &21, &03, &00, &28, &1C  ; B474: 22 F0 10... "..
 EQUB &00, &32, &01, &0B, &03, &34, &1F, &07  ; B47C: 00 32 01... .2.
 EQUB &0E, &0E, &24, &0F, &CF, &8F, &08, &23  ; B484: 0E 0E 24... ..$
 EQUB &1C, &35, &1E, &1C, &1E, &1C, &1E, &06  ; B48C: 1C 35 1E... .5.
 EQUB &22, &03, &23, &38, &23, &3F, &22, &38  ; B494: 22 03 23... ".#
 EQUB &03, &13, &02, &7E, &22, &3F, &23, &80  ; B49C: 03 13 02... ...
 EQUB &32, &3E, &3F, &00, &12, &03, &62, &FF  ; B4A4: 32 3E 3F... 2>?
 EQUB &00, &F5, &FF, &04, &B8, &00, &C0, &E0  ; B4AC: 00 F5 FF... ...
 EQUB &04, &80, &21, &01, &07, &62, &03, &33  ; B4B4: 04 80 21... ..!
 EQUB &08, &02, &01, &00, &BF, &03, &21, &02  ; B4BC: 08 02 01... ...
 EQUB &40, &00, &21, &04, &E3, &33, &07, &03  ; B4C4: 40 00 21... @.!
 EQUB &07, &40, &80, &02, &80, &13, &04, &21  ; B4CC: 07 40 80... .@.
 EQUB &01, &22, &F0, &F8, &31, &06, &23, &07  ; B4D4: 01 22 F0... .".
 EQUB &34, &1C, &1F, &3F, &3F, &04, &21, &0C  ; B4DC: 34 1C 1F... 4..
 EQUB &13, &04, &8F, &23, &CF, &04, &21, &1F  ; B4E4: 13 04 8F... ...
 EQUB &03, &7F, &23, &3F, &9C, &22, &1C, &21  ; B4EC: 03 7F 23... ..#
 EQUB &3E, &04, &63, &03, &FF, &7F, &FF, &FE  ; B4F4: 3E 04 63... >.c
 EQUB &34, &38, &3C, &3F, &3F, &05, &D1, &12  ; B4FC: 34 38 3C... 48<
 EQUB &04, &21, &3F, &00, &22, &80, &00, &32  ; B504: 04 21 3F... .!?
 EQUB &3E, &3F, &7F, &FF, &03, &21, &01, &F7  ; B50C: 3E 3F 7F... >?.
 EQUB &FE, &F8, &FF, &0F, &0C, &DD, &6F, &32  ; B514: FE F8 FF... ...
 EQUB &3F, &0F, &04, &14, &22, &06, &22, &0E  ; B51C: 3F 0F 04... ?..
 EQUB &14, &04, &14, &04, &FE, &13, &04, &7F  ; B524: 14 04 14... ...
 EQUB &13, &7F, &23, &7E, &FF, &BF, &FF, &DF  ; B52C: 13 7F 23... ..#
 EQUB &02, &22, &01, &14, &24, &FE, &14, &04  ; B534: 02 22 01... .".
 EQUB &14, &04, &14, &23, &7F, &FE, &FC, &F0  ; B53C: 14 04 14... ...
 EQUB &E0, &80, &F0, &C0, &80, &09, &34, &1F  ; B544: E0 80 F0... ...
 EQUB &0F, &03, &01, &04, &14, &03, &21, &01  ; B54C: 0F 03 01... ...
 EQUB &14, &7F, &15, &FB, &F7, &15, &FD, &12  ; B554: 14 7F 15... ...
 EQUB &22, &EF, &F7, &FF, &FB, &FF, &FD, &FE  ; B55C: 22 EF F7... "..
 EQUB &C0, &22, &E0, &F0, &14, &04, &14, &04  ; B564: C0 22 E0... .".
 EQUB &12, &FE, &F8, &04, &80, &05, &32, &0F  ; B56C: 12 FE F8... ...
 EQUB &03, &04, &4F, &21, &01, &12, &36, &0F  ; B574: 03 04 4F... ..O
 EQUB &07, &3F, &1F, &FF, &0F, &12, &02, &A0  ; B57C: 07 3F 1F... .?.
 EQUB &F0, &FF, &EE, &CF, &C0, &04, &FE, &FF  ; B584: F0 FF EE... ...
 EQUB &7F, &02, &35, &17, &1F, &0F, &FF, &0C  ; B58C: 7F 02 35... ..5
 EQUB &12, &02, &13, &00, &20, &FE, &02, &22  ; B594: 12 02 13... ...
 EQUB &80, &F0, &0F, &35, &0C, &0E, &1E, &1F  ; B59C: 80 F0 0F... ...
 EQUB &3F, &7D, &E4, &E2, &04, &80, &C0, &E0  ; B5A4: 3F 7D E4... ?}.
 EQUB &F0, &21, &01, &07, &21, &08, &00, &21  ; B5AC: F0 21 01... .!.
 EQUB &04, &00, &22, &20, &22, &60, &78, &07  ; B5B4: 04 00 22... .."
 EQUB &40, &22, &80, &02, &33, &04, &1E, &1E  ; B5BC: 40 22 80... @".
 EQUB &08, &21, &0C, &02, &21, &0E, &0C, &3F  ; B5C4: 08 21 0C... .!.
 EQUB &01, &02, &00, &00, &00, &00, &00, &00  ; B5CC: 01 02 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B5D4: 00 00 00... ...
 EQUB &00, &00, &00, &00, &03, &04, &00, &00  ; B5DC: 00 00 00... ...
 EQUB &05, &06, &07, &00, &00, &00, &00, &00  ; B5E4: 05 06 07... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B5EC: 00 00 00... ...
 EQUB &00, &00, &00, &08, &09, &0A, &00, &00  ; B5F4: 00 00 00... ...
 EQUB &0B, &0C, &0D, &0E, &00, &00, &00, &00  ; B5FC: 0B 0C 0D... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B604: 00 00 00... ...
 EQUB &00, &00, &0F, &10, &11, &12, &00, &00  ; B60C: 00 00 0F... ...
 EQUB &00, &13, &14, &15, &16, &00, &00, &00  ; B614: 00 13 14... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B61C: 00 00 00... ...
 EQUB &17, &18, &19, &1A, &1B, &00, &00, &00  ; B624: 17 18 19... ...
 EQUB &00, &1C, &1D, &1E, &1F, &20, &00, &00  ; B62C: 00 1C 1D... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &21  ; B634: 00 00 00... ...
 EQUB &22, &23, &24, &25, &26, &00, &00, &00  ; B63C: 22 23 24... "#$
 EQUB &00, &27, &28, &29, &2A, &2B, &2C, &2D  ; B644: 00 27 28... .'(
 EQUB &00, &00, &2E, &2F, &00, &00, &30, &31  ; B64C: 00 00 2E... ...
 EQUB &32, &33, &34, &35, &36, &00, &00, &00  ; B654: 32 33 34... 234
 EQUB &00, &00, &37, &38, &39, &3A, &3B, &3C  ; B65C: 00 00 37... ..7
 EQUB &00, &00, &3D, &3E, &00, &3F, &40, &41  ; B664: 00 00 3D... ..=
 EQUB &42, &43, &44, &45, &00, &00, &00, &00  ; B66C: 42 43 44... BCD
 EQUB &00, &00, &00, &46, &47, &48, &49, &4A  ; B674: 00 00 00... ...
 EQUB &4B, &00, &4C, &4D, &00, &4E, &4F, &50  ; B67C: 4B 00 4C... K.L
 EQUB &51, &52, &53, &00, &00, &00, &00, &00  ; B684: 51 52 53... QRS
 EQUB &00, &00, &00, &54, &55, &56, &57, &58  ; B68C: 00 00 00... ...
 EQUB &59, &5A, &5B, &5C, &00, &5D, &5E, &5F  ; B694: 59 5A 5B... YZ[
 EQUB &60, &61, &62, &00, &00, &00, &00, &00  ; B69C: 60 61 62... `ab
 EQUB &00, &00, &00, &63, &64, &65, &66, &67  ; B6A4: 00 00 00... ...
 EQUB &68, &69, &6A, &6B, &6C, &6D, &6E, &6F  ; B6AC: 68 69 6A... hij
 EQUB &70, &71, &72, &00, &00, &00, &00, &00  ; B6B4: 70 71 72... pqr
 EQUB &00, &00, &00, &00, &73, &74, &75, &76  ; B6BC: 00 00 00... ...
 EQUB &77, &78, &79, &7A, &7B, &7C, &7D, &7E  ; B6C4: 77 78 79... wxy
 EQUB &7F, &80, &00, &00, &00, &00, &00, &00  ; B6CC: 7F 80 00... ...
 EQUB &00, &81, &82, &83, &84, &85, &86, &87  ; B6D4: 00 81 82... ...
 EQUB &88, &89, &8A, &8B, &8C, &8D, &8E, &8F  ; B6DC: 88 89 8A... ...
 EQUB &90, &91, &92, &93, &00, &00, &00, &00  ; B6E4: 90 91 92... ...
 EQUB &00, &00, &94, &95, &96, &97, &98, &99  ; B6EC: 00 00 94... ...
 EQUB &9A, &9B, &9C, &9D, &9E, &9F, &A0, &A1  ; B6F4: 9A 9B 9C... ...
 EQUB &A2, &A3, &A4, &A5, &00, &00, &00, &00  ; B6FC: A2 A3 A4... ...
 EQUB &00, &00, &00, &00, &A6, &A7, &A8, &A9  ; B704: 00 00 00... ...
 EQUB &AA, &AB, &AC, &AD, &AE, &AF, &B0, &B1  ; B70C: AA AB AC... ...
 EQUB &B2, &B3, &00, &00, &00, &00, &00, &00  ; B714: B2 B3 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &B4, &B5  ; B71C: 00 00 00... ...
 EQUB &B6, &B7, &B8, &B9, &BA, &BB, &BC, &BD  ; B724: B6 B7 B8... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B72C: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &BE  ; B734: 00 00 00... ...
 EQUB &BF, &C0, &C1, &C2, &C3, &C4, &C5, &00  ; B73C: BF C0 C1... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B744: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B74C: 00 00 00... ...
 EQUB &00, &C6, &C7, &C8, &00, &00, &00, &00  ; B754: 00 C6 C7... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B75C: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B764: 00 00 00... ...
 EQUB &00, &C9, &CA, &CB, &00, &00, &00, &00  ; B76C: 00 C9 CA... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B774: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B77C: 00 00 00... ...
 EQUB &00, &00, &CC, &CD, &00, &00, &00, &00  ; B784: 00 00 CC... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B78C: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B794: 00 00 00... ...
 EQUB &00, &00, &CE, &CF, &00, &00, &00, &00  ; B79C: 00 00 CE... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B7A4: 00 00 00... ...
 EQUB &01, &00, &00, &00, &00, &02, &03, &00  ; B7AC: 01 00 00... ...
 EQUB &04, &05, &00, &00, &00, &06, &07, &00  ; B7B4: 04 05 00... ...
 EQUB &08, &09, &0A, &0B, &0C, &0D, &0E, &00  ; B7BC: 08 09 0A... ...
 EQUB &0F, &10, &11, &12, &13, &14, &00, &00  ; B7C4: 0F 10 11... ...
 EQUB &15, &16, &17, &18, &19, &1A, &00, &00  ; B7CC: 15 16 17... ...
 EQUB &00, &1B, &1C, &1D, &1E, &1F, &00, &00  ; B7D4: 00 1B 1C... ...
 EQUB &00, &00, &20, &21, &22, &00, &00, &00  ; B7DC: 00 00 20... ..
 EQUB &00, &00, &00, &23, &00, &00, &00, &00  ; B7E4: 00 00 00... ...
 EQUB &00, &00, &00, &00, &45, &46, &47, &48  ; B7EC: 00 00 00... ...
 EQUB &49, &00, &00, &00, &00, &00, &4A, &4B  ; B7F4: 49 00 00... I..
 EQUB &4C, &4D, &4E, &4F, &50, &51, &52, &53  ; B7FC: 4C 4D 4E... LMN
 EQUB &54, &55, &00, &00, &00, &56, &57, &58  ; B804: 54 55 00... TU.
 EQUB &59, &5A, &5B, &5C, &5D, &00, &00, &00  ; B80C: 59 5A 5B... YZ[
 EQUB &5E, &5F, &60, &61, &62, &63, &64, &65  ; B814: 5E 5F 60... ^_`
 EQUB &66, &67, &68, &69, &00, &00, &6A, &6B  ; B81C: 66 67 68... fgh
 EQUB &6C, &6D, &6E, &6F, &70, &71, &72, &73  ; B824: 6C 6D 6E... lmn
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B82C: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &74  ; B834: 00 00 00... ...
 EQUB &75, &76, &77, &78, &79, &7A, &7B, &7C  ; B83C: 75 76 77... uvw
 EQUB &7D, &7E, &7F, &00, &00, &00, &00, &00  ; B844: 7D 7E 7F... }~.
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B84C: 00 00 00... ...
 EQUB &00, &80, &81, &82, &83, &84, &85, &86  ; B854: 00 80 81... ...
 EQUB &87, &88, &89, &8A, &8B, &00, &00, &00  ; B85C: 87 88 89... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B864: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B86C: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &00  ; B874: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &AD, &DD  ; B87C: 00 00 00... ...
 EQUB &03, &D0, &1F, &AE, &DC, &03, &E0, &00  ; B884: 03 D0 1F... ...
 EQUB &69, &00, &E0, &02, &69, &00, &E0, &08  ; B88C: 69 00 E0... i..
 EQUB &69, &00, &E0, &18, &69, &00, &E0, &2C  ; B894: 69 00 E0... i..
 EQUB &69, &00, &E0, &82, &69, &00, &AA, &4C  ; B89C: 69 00 E0... i..
 EQUB &B7, &B8, &A2, &09, &C9, &19, &B0, &0B  ; B8A4: B7 B8 A2... ...
 EQUB &CA, &C9, &0A, &B0, &06, &CA, &C9, &02  ; B8AC: CA C9 0A... ...
 EQUB &B0, &01, &CA, &CA, &8A, &85, &99, &0A  ; B8B4: B0 01 CA... ...
 EQUB &65, &99, &85, &99, &AE, &71, &04, &F0  ; B8BC: 65 99 85... e..
 EQUB &01, &CA, &8A, &18, &65, &99, &AA, &BD  ; B8C4: 01 CA 8A... ...
 EQUB &DB, &B8, &CD, &1A, &95, &90, &05, &AD  ; B8CC: DB B8 CD... ...
 EQUB &1A, &95, &E9, &01, &85, &99, &60, &00  ; B8D4: 1A 95 E9... ...
 EQUB &01, &02, &03, &04, &05, &06, &06, &07  ; B8DC: 01 02 03... ...
 EQUB &08, &08, &08, &09, &09, &09, &0A, &0A  ; B8E4: 08 08 08... ...
 EQUB &0A, &0B, &0B, &0B, &0C, &0C, &0C, &0D  ; B8EC: 0A 0B 0B... ...
 EQUB &0D, &0D, &0E, &0E, &0E                 ; B8F4: 0D 0D 0E... ...

.sub_CB8F9
 LDA #0                                       ; B8F9: A9 00       ..
 STA SCH                                      ; B8FB: 85 08       ..
 LDA L046C                                    ; B8FD: AD 6C 04    .l.
 ASL A                                        ; B900: 0A          .
 ROL SCH                                      ; B901: 26 08       &.
 ASL A                                        ; B903: 0A          .
 ROL SCH                                      ; B904: 26 08       &.
 ASL A                                        ; B906: 0A          .
 ROL SCH                                      ; B907: 26 08       &.
 STA SC                                       ; B909: 85 07       ..
 STA T5                                       ; B90B: 85 BA       ..
 LDA SCH                                      ; B90D: A5 08       ..
 ADC #&68 ; 'h'                               ; B90F: 69 68       ih
 STA T5_1                                     ; B911: 85 BB       ..
 LDA SCH                                      ; B913: A5 08       ..
 ADC #&60 ; '`'                               ; B915: 69 60       i`
 STA SCH                                      ; B917: 85 08       ..
 LDA L048B                                    ; B919: AD 8B 04    ...
 ASL A                                        ; B91C: 0A          .
 TAX                                          ; B91D: AA          .
 LDA L951C,X                                  ; B91E: BD 1C 95    ...
 CLC                                          ; B921: 18          .
 ADC #&1A                                     ; B922: 69 1A       i.
 STA V                                        ; B924: 85 63       .c
 LDA L951D,X                                  ; B926: BD 1D 95    ...
 ADC #&95                                     ; B929: 69 95       i.
 STA V_1                                      ; B92B: 85 64       .d
 JSR LF52D                                    ; B92D: 20 2D F5     -.
 LDA T5                                       ; B930: A5 BA       ..
 STA SC                                       ; B932: 85 07       ..
 LDA T5_1                                     ; B934: A5 BB       ..
 STA SCH                                      ; B936: 85 08       ..
 JSR LF52D                                    ; B938: 20 2D F5     -.
 RTS                                          ; B93B: 60          `

 JSR sub_CB8F9                                ; B93C: 20 F9 B8     ..
 LDA L048B                                    ; B93F: AD 8B 04    ...
 ASL A                                        ; B942: 0A          .
 TAX                                          ; B943: AA          .
 CLC                                          ; B944: 18          .
 LDA L800E,X                                  ; B945: BD 0E 80    ...
 ADC #&0C                                     ; B948: 69 0C       i.
 STA V                                        ; B94A: 85 63       .c
 LDA L800F,X                                  ; B94C: BD 0F 80    ...
 ADC #&80                                     ; B94F: 69 80       i.
 STA V_1                                      ; B951: 85 64       .d
 LDA #4                                       ; B953: A9 04       ..
 STA PPU_ADDR                                 ; B955: 8D 06 20    ..
 LDA #&50 ; 'P'                               ; B958: A9 50       .P
 STA PPU_ADDR                                 ; B95A: 8D 06 20    ..
 JSR LF5AF                                    ; B95D: 20 AF F5     ..
 LDA #&AA                                     ; B960: A9 AA       ..
 STA V_1                                      ; B962: 85 64       .d
 LDA #&9F                                     ; B964: A9 9F       ..
 STA V                                        ; B966: 85 63       .c
 JMP LF5AF                                    ; B968: 4C AF F5    L..

 LDA #&AB                                     ; B96B: A9 AB       ..
 STA V_1                                      ; B96D: 85 64       .d
 LDA #&1C                                     ; B96F: A9 1C       ..
 STA V                                        ; B971: 85 63       .c
 LDA NEXT_TILE                                ; B973: A5 B8       ..
 TAY                                          ; B975: A8          .
 STY K_2                                      ; B976: 84 7F       ..
 ASL A                                        ; B978: 0A          .
 STA SC                                       ; B979: 85 07       ..
 LDA #0                                       ; B97B: A9 00       ..
 ROL A                                        ; B97D: 2A          *
 ASL SC                                       ; B97E: 06 07       ..
 ROL A                                        ; B980: 2A          *
 ASL SC                                       ; B981: 06 07       ..
 ROL A                                        ; B983: 2A          *
 ADC #&60 ; '`'                               ; B984: 69 60       i`
 STA SCH                                      ; B986: 85 08       ..
 ADC #8                                       ; B988: 69 08       i.
 STA T5_1                                     ; B98A: 85 BB       ..
 LDA SC                                       ; B98C: A5 07       ..
 STA T5                                       ; B98E: 85 BA       ..
 JSR LF52D                                    ; B990: 20 2D F5     -.
 LDA T5                                       ; B993: A5 BA       ..
 STA SC                                       ; B995: 85 07       ..
 LDA T5_1                                     ; B997: A5 BB       ..
 STA SCH                                      ; B999: 85 08       ..
 JSR LF52D                                    ; B99B: 20 2D F5     -.
 LDA #&B5                                     ; B99E: A9 B5       ..
 STA V_1                                      ; B9A0: 85 64       .d
 LDA #&CC                                     ; B9A2: A9 CC       ..
 STA V                                        ; B9A4: 85 63       .c
 LDA #&18                                     ; B9A6: A9 18       ..
 STA K                                        ; B9A8: 85 7D       .}
 LDA #&14                                     ; B9AA: A9 14       ..
 STA K_1                                      ; B9AC: 85 7E       .~
 LDA #1                                       ; B9AE: A9 01       ..
 STA YC                                       ; B9B0: 85 3B       .;
 LDA #5                                       ; B9B2: A9 05       ..
 STA XC                                       ; B9B4: 85 32       .2
 JSR sub_CB9C1                                ; B9B6: 20 C1 B9     ..
 LDA NEXT_TILE                                ; B9B9: A5 B8       ..
 CLC                                          ; B9BB: 18          .
 ADC #&D0                                     ; B9BC: 69 D0       i.
 STA NEXT_TILE                                ; B9BE: 85 B8       ..
 RTS                                          ; B9C0: 60          `

.sub_CB9C1
 LDA #&20 ; ' '                               ; B9C1: A9 20       .
 SEC                                          ; B9C3: 38          8
 SBC K                                        ; B9C4: E5 7D       .}
 STA ZZ                                       ; B9C6: 85 A0       ..
 JSR LDBD8                                    ; B9C8: 20 D8 DB     ..
 LDA SC                                       ; B9CB: A5 07       ..
 CLC                                          ; B9CD: 18          .
 ADC XC                                       ; B9CE: 65 32       e2
 STA SC                                       ; B9D0: 85 07       ..
 LDY #0                                       ; B9D2: A0 00       ..
.CB9D4
 LDX K                                        ; B9D4: A6 7D       .}
.loop_CB9D6
 LDA (V),Y                                    ; B9D6: B1 63       .c
 BEQ CB9DD                                    ; B9D8: F0 03       ..
 CLC                                          ; B9DA: 18          .
 ADC K_2                                      ; B9DB: 65 7F       e.
.CB9DD
 STA (SC),Y                                   ; B9DD: 91 07       ..
 INY                                          ; B9DF: C8          .
 BNE CB9E6                                    ; B9E0: D0 04       ..
 INC V_1                                      ; B9E2: E6 64       .d
 INC SCH                                      ; B9E4: E6 08       ..
.CB9E6
 DEX                                          ; B9E6: CA          .
 BNE loop_CB9D6                               ; B9E7: D0 ED       ..
 LDA SC                                       ; B9E9: A5 07       ..
 CLC                                          ; B9EB: 18          .
 ADC ZZ                                       ; B9EC: 65 A0       e.
 STA SC                                       ; B9EE: 85 07       ..
 BCC CB9F4                                    ; B9F0: 90 02       ..
 INC SCH                                      ; B9F2: E6 08       ..
.CB9F4
 DEC K_1                                      ; B9F4: C6 7E       .~
 BNE CB9D4                                    ; B9F6: D0 DC       ..
 RTS                                          ; B9F8: 60          `

 LDA #1                                       ; B9F9: A9 01       ..
 STA XC                                       ; B9FB: 85 32       .2
 ASL A                                        ; B9FD: 0A          .
 STA YC                                       ; B9FE: 85 3B       .;
 LDX #8                                       ; BA00: A2 08       ..
 STX K                                        ; BA02: 86 7D       .}
 STX K_1                                      ; BA04: 86 7E       .~
 LDX #6                                       ; BA06: A2 06       ..
 LDY #6                                       ; BA08: A0 06       ..
 LDA #&43 ; 'C'                               ; BA0A: A9 43       .C
 STA K_2                                      ; BA0C: 85 7F       ..
 LDA CNT                                      ; BA0E: A5 A8       ..
 LSR A                                        ; BA10: 4A          J
 LSR A                                        ; BA11: 4A          J
 STA K_3                                      ; BA12: 85 80       ..
 LDA #&B7                                     ; BA14: A9 B7       ..
 STA V_1                                      ; BA16: 85 64       .d
 LDA #&AC                                     ; BA18: A9 AC       ..
 STA V                                        ; BA1A: 85 63       .c
 LDA #1                                       ; BA1C: A9 01       ..
 STA S                                        ; BA1E: 85 99       ..
 LDA XC                                       ; BA20: A5 32       .2
 ASL A                                        ; BA22: 0A          .
 ASL A                                        ; BA23: 0A          .
 ASL A                                        ; BA24: 0A          .
 ADC #0                                       ; BA25: 69 00       i.
 STA SC                                       ; BA27: 85 07       ..
 TXA                                          ; BA29: 8A          .
 ADC SC                                       ; BA2A: 65 07       e.
 STA SC                                       ; BA2C: 85 07       ..
 LDA YC                                       ; BA2E: A5 3B       .;
 ASL A                                        ; BA30: 0A          .
 ASL A                                        ; BA31: 0A          .
 ASL A                                        ; BA32: 0A          .
 ADC #6                                       ; BA33: 69 06       i.
 STA SCH                                      ; BA35: 85 08       ..
 TYA                                          ; BA37: 98          .
 ADC SCH                                      ; BA38: 65 08       e.
 STA SCH                                      ; BA3A: 85 08       ..
 LDA K_3                                      ; BA3C: A5 80       ..
 ASL A                                        ; BA3E: 0A          .
 ASL A                                        ; BA3F: 0A          .
 TAX                                          ; BA40: AA          .
 LDA K_1                                      ; BA41: A5 7E       .~
 STA T                                        ; BA43: 85 9A       ..
 LDY #0                                       ; BA45: A0 00       ..
.CBA47
 LDA L00E9                                    ; BA47: A5 E9       ..
 BPL CBA54                                    ; BA49: 10 09       ..
 LDA PPU_STATUS                               ; BA4B: AD 02 20    ..
 ASL A                                        ; BA4E: 0A          .
 BPL CBA54                                    ; BA4F: 10 03       ..
 JSR NAMETABLE0                               ; BA51: 20 6D D0     m.
.CBA54
 LDA SC                                       ; BA54: A5 07       ..
 STA T5                                       ; BA56: 85 BA       ..
 LDA K                                        ; BA58: A5 7D       .}
 STA ZZ                                       ; BA5A: 85 A0       ..
.CBA5C
 LDA (V),Y                                    ; BA5C: B1 63       .c
 INY                                          ; BA5E: C8          .
 BNE CBA63                                    ; BA5F: D0 02       ..
 INC V_1                                      ; BA61: E6 64       .d
.CBA63
 CMP #0                                       ; BA63: C9 00       ..
 BEQ CBA82                                    ; BA65: F0 1B       ..
 ADC K_2                                      ; BA67: 65 7F       e.
 STA SPR_00_TILE,X                            ; BA69: 9D 01 02    ...
 LDA S                                        ; BA6C: A5 99       ..
 STA SPR_00_ATTR,X                            ; BA6E: 9D 02 02    ...
 LDA T5                                       ; BA71: A5 BA       ..
 STA SPR_00_X,X                               ; BA73: 9D 03 02    ...
 LDA SCH                                      ; BA76: A5 08       ..
 STA SPR_00_Y,X                               ; BA78: 9D 00 02    ...
 TXA                                          ; BA7B: 8A          .
 CLC                                          ; BA7C: 18          .
 ADC #4                                       ; BA7D: 69 04       i.
 BCS CBA97                                    ; BA7F: B0 16       ..
 TAX                                          ; BA81: AA          .
.CBA82
 LDA T5                                       ; BA82: A5 BA       ..
 CLC                                          ; BA84: 18          .
 ADC #8                                       ; BA85: 69 08       i.
 STA T5                                       ; BA87: 85 BA       ..
 DEC ZZ                                       ; BA89: C6 A0       ..
 BNE CBA5C                                    ; BA8B: D0 CF       ..
 LDA SCH                                      ; BA8D: A5 08       ..
 ADC #8                                       ; BA8F: 69 08       i.
 STA SCH                                      ; BA91: 85 08       ..
 DEC T                                        ; BA93: C6 9A       ..
 BNE CBA47                                    ; BA95: D0 B0       ..
.CBA97
 RTS                                          ; BA97: 60          `

 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BA98: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BAA0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BAA8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BAB0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BAB8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BAC0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BAC8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BAD0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BAD8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BAE0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BAE8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BAF0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BAF8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB00: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB08: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB10: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB18: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB20: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB28: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB30: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB38: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB40: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB48: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB50: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB58: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB60: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB68: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB70: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB78: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB80: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB88: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB90: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BB98: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BBA0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BBA8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BBB0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BBB8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BBC0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BBC8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BBD0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BBD8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BBE0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BBE8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BBF0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BBF8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC00: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC08: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC10: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC18: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC20: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC28: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC30: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC38: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC40: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC48: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC50: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC58: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC60: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC68: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC70: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC78: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC80: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC88: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC90: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BC98: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BCA0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BCA8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BCB0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BCB8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BCC0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BCC8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BCD0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BCD8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BCE0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BCE8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BCF0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BCF8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD00: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD08: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD10: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD18: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD20: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD28: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD30: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD38: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD40: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD48: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD50: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD58: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD60: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD68: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD70: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD78: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD80: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD88: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD90: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BD98: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BDA0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BDA8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BDB0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BDB8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BDC0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BDC8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BDD0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BDD8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BDE0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BDE8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BDF0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BDF8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE00: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE08: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE10: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE18: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE20: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE28: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE30: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE38: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE40: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE48: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE50: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE58: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE60: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE68: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE70: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE78: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE80: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE88: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE90: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BE98: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BEA0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BEA8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BEB0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BEB8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BEC0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BEC8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BED0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BED8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BEE0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BEE8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BEF0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BEF8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF00: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF08: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF10: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF18: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF20: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF28: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF30: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF38: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF40: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF48: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF50: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF58: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF60: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF68: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF70: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF78: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF80: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF88: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF90: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF98: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFA0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFA8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFB0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFB8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFC0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFC8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFD0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFD8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFE0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFE8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFF0: FF FF FF... ...
 EQUB &FF, &FF,   7, &C0,   0, &C0,   7, &C0  ; BFF8: FF FF 07... ...
.pydis_end



\ ******************************************************************************
\
\ Save bank4.bin
\
\ ******************************************************************************

 PRINT "S.bank4.bin ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
 SAVE "versions/nes/3-assembled-output/bank4.bin", CODE%, P%, LOAD%
