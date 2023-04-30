from commands import *


load(0x8000, "slices/bank2.bin", "6502")

config.set_lower_case(False)

# Remove all extras
config.set_label_references(False)
config.set_show_autogenerated_labels(False)
config.set_show_all_labels(False)
config.set_inline_comment_column(46)
config.set_subroutine_header("*" * 78)
config.set_indent_string(" ")

entry(0x8000)
string(0x8007, 5)

byte(0x800C, 0x8BB1 - 0x800C)
hexadecimal(0x800C, 0x8BB1 - 0x800C)
byte(0x8BB1, 0x8BC8 - 0x8BB1)
hexadecimal(0x8BB1, 0x8BC8 - 0x8BB1)
byte(0x8BC8, 0x8BDF - 0x8BC8)
hexadecimal(0x8BC8, 0x8BDF - 0x8BC8)
byte(0x8BDF, 0x8DFD - 0x8BDF)
hexadecimal(0x8BDF, 0x8DFD - 0x8BDF)

byte(0x8DFD, 0x9732 - 0x8DFD)
hexadecimal(0x8DFD, 0x9732 - 0x8DFD)
byte(0x9732, 0x9749 - 0x9732)
hexadecimal(0x9732, 0x9749 - 0x9732)
byte(0x9749, 0x9760 - 0x9749)
hexadecimal(0xA1B8, 0x9760 - 0x9749)
byte(0x9760, 0x9A2D - 0x9760)
hexadecimal(0x9760, 0x9A2D - 0x9760)

byte(0x9A2D, 0xA1A1 - 0x9A2D)
hexadecimal(0x9A2D, 0xA1A1 - 0x9A2D)
byte(0xA1A1, 0xA1B8 - 0xA1A1)
hexadecimal(0xA1A1, 0xA1B8 - 0xA1A1)
byte(0xA1B8, 0xA1CF - 0xA1B8)
hexadecimal(0xA1B8, 0xA1CF - 0xA1B8)
byte(0xA1CF, 0xA3CF - 0xA1CF)
hexadecimal(0xA1CF, 0xA3CF - 0xA1CF)

byte(0xA3CF, 0xA79C - 0xA3CF)
hexadecimal(0xA3CF, 0xA79C - 0xA3CF)
byte(0xA79C, 0xAC4D - 0xA79C)
hexadecimal(0xA79C, 0xAC4D - 0xA79C)
byte(0xAC4D, 0xB0CE - 0xAC4D)
hexadecimal(0xAC4D, 0xB0CE - 0xAC4D)

#byte(0xB0CE, 0xB0D4 - 0xB0CE)
entry(0xB0D6)

entry(0xB26C)
entry(0xB279)
entry(0xB281)
entry(0xB287)
entry(0xB291)
entry(0xB292)
entry(0xB29B)
byte(0xB2A1)
entry(0xB2A2)
entry(0xB2A8)
byte(0xB2AA)
entry(0xB2AB)
entry(0xB2B5)
entry(0xB2D3)
entry(0xB2F6)
entry(0xB373)

#byte(0xB3D4, 0xB3E8 - 0xB3D4)
entry(0xB3E8)

entry(0xB633)

label(0x800C, "TKN1")
label(0x8BB1, "RUPLA")
label(0x8BC8, "RUGAL")
label(0x8BDF, "RUTOK")

label(0x8DFD, "TKN1_DE")
label(0x9732, "RUPLA_DE")
label(0x9749, "RUGAL_DE")
label(0x9760, "RUTOK_DE")

label(0x9A2D, "TKN1_FR")
label(0xA1A1, "RUPLA_FR")
label(0xA1B8, "RUGAL_FR")
label(0xA1CF, "RUTOK_FR")

label(0xA3CF, "QQ18")
label(0xA79C, "QQ18_DE")
label(0xAC4D, "QQ18_FR")

#label(0xAB44, "RUPLA_IT")  # Mine
#label(0xAB5B, "RUGAL_IT")  # Mine
#label(0xAB72, "RUTOK_IT")  # Mine

label(0xB0CE, "RUTOK_LO")
label(0xB0D2, "RUTOK_HI")
label(0xB1A9, "DT3")
label(0xB204, "JMTBm2")
label(0xB205, "JMTBm1")
label(0xB206, "JMTB")

label(0xB246, "MTIN")
label(0xB319, "TKN2")
label(0xB31A, "TKN2_1")
label(0xB31B, "TKN2_2")
label(0xB31C, "TKN2_3")
label(0xB333, "QQ16")
label(0xB334, "QQ16_1")
label(0xB3D4, "RUPLA_LO")
label(0xB3D8, "RUPLA_HI")
label(0xB3DC, "RUGAL_LO")
label(0xB3E0, "RUGAL_HI")
label(0xB3E4, "NRU")
label(0xB489, "qw")
label(0xB574, "DA1")
label(0xB605, "DAS1")
label(0xB66A, "RR1")

byte(0xB61E)
entry(0xB61F)

subroutine(0xB0D6, "DETOK3")
subroutine(0xB0EF, "DETOK")
subroutine(0xB14B, "DETOK2")
subroutine(0xB26C, "MT27")
subroutine(0xB270, "MT28")
subroutine(0xB279, "MT1")
subroutine(0xB27C, "MT2")
subroutine(0xB287, "MT8")
subroutine(0xB291, "FILEPR")
subroutine(0xB291, "MT16")
subroutine(0xB291, "OTHERFILEPR")
subroutine(0xB292, "MT9")
subroutine(0xB29B, "MT6")
subroutine(0xB2A2, "MT5")
subroutine(0xB2A8, "MT14")
subroutine(0xB2AB, "MT15")
subroutine(0xB2B5, "MT17")
subroutine(0xB2D3, "MT18")
subroutine(0xB2F6, "MT26")
subroutine(0xB2FB, "MT19")
subroutine(0xB301, "VOWEL")
subroutine(0xB373, "BRIS")
subroutine(0xB380, "PAUSE")
subroutine(0xB3B1, "MT23")
subroutine(0xB3B4, "MT29")
subroutine(0xB3B8, "MT13")
subroutine(0xB3C1, "PAUSE2")
subroutine(0xB3E8, "PDESC")
subroutine(0xB44F, "TT27")
subroutine(0xB492, "TT43")
subroutine(0xB4AA, "ex")
subroutine(0xB4F5, "DASC")
subroutine(0xB61F, "BELL")
subroutine(0xB633, "TT67X")
subroutine(0xB635, "CHPR")


exec(open('py8dis-scripts/common-variables.py').read())

go()
