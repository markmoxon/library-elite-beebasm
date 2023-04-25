from commands import *


load(0x8000, "slices/bank2.bin", "6502")

config.set_lower_case(False)

# Remove all extras
config.set_label_references(False)
config.set_show_autogenerated_labels(False)
config.set_show_all_labels(False)
config.set_inline_comment_column(50)
config.set_subroutine_header("*" * 78)
config.set_indent_string(" ")

entry(0x8000)
string(0x8007, 5)

byte(0x800C, 0xA400 - 0x800C)
hexadecimal(0x800C, 0xA400 - 0x800C)

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
entry(0xB633)

label(0x800C, "TKN1")
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
label(0xB489, "qw")
label(0xB574, "DA1")
label(0xB605, "DAS1")
label(0xB66A, "RR1")

byte(0xB61E)
entry(0xB61F)

subroutine(0xB0EF, "DETOK_BANK2")
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
subroutine(0xB44F, "TT27_BANK2")
subroutine(0xB492, "TT43")
subroutine(0xB4AA, "ex")
subroutine(0xB4F5, "DASC_BANK2")
subroutine(0xB61F, "BELL")
subroutine(0xB633, "TT67X")
subroutine(0xB635, "CHPR")


exec(open('py8dis-scripts/common-variables.py').read())

go()
