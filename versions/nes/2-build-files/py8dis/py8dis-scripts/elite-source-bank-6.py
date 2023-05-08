from commands import *


load(0x8000, "slices/bank6.bin", "6502")

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

entry(0x800C)
entry(0x800F)
entry(0x8015)
entry(0x8018)
entry(0x801B)
entry(0x801E)

byte(0x88BC, 0x895A - 0x88BC)
hexadecimal(0x88BC, 0x895A - 0x88BC)

entry(0x89D1)

byte(0x8D7A, 0x9FD0 - 0x8D7A)
hexadecimal(0x8D7A, 0x9FD0 - 0x8D7A)


entry(0xA000)
entry(0xA02B)
entry(0xA04A)
entry(0xA069)
entry(0xA082)
entry(0xA0F8)
entry(0xA166)
entry(0xA223)
entry(0xA281)
entry(0xA2C3)

entry(0xA39F)
entry(0xA3DE)

byte(0xA3F5, 0xA4AD - 0xA3F5)
hexadecimal(0xA3F5, 0xA4AD - 0xA3F5)
entry(0xA4AD)
entry(0xA5AB)

entry(0xA764)

entry(0xA91B)

byte(0xAB6F, 1)
hexadecimal(0xAB6F, 1)

byte(0xAB70, 1)
hexadecimal(0xAB70, 1)

byte(0xAB71, 1)
hexadecimal(0xAB71, 1)

byte(0xAB72, 1)
hexadecimal(0xAB72, 1)

byte(0xAB73, 0xAC6F - 0xAB73)
hexadecimal(0xAB73, 0xAC6F - 0xAB73)

entry(0xB459)
entry(0xB818)
entry(0xB88C)
entry(0xB8FE)
entry(0xB919)
entry(0xB980)
byte(0xBA06, 0xBA16 - 0xBA06)
hexadecimal(0xBA06, 0xBA16 - 0xBA06)
entry(0xBA16)
entry(0xBA17)
entry(0xBA63)
entry(0xBBDE)
entry(0xBC83)
entry(0xBE52)
entry(0xBED2)

byte(0xB89C, 0xB8FE - 0xB89C)
hexadecimal(0xB89C, 0xB8FE - 0xB89C)

byte(0xBE34, 4)
byte(0xBE38, 4)
hexadecimal(0xBE2C, 0xBE52 - 0xBE2C)

label(0xAB6F, "LTDEF")
label(0xAC96, "NOFX")
label(0xACA2, "NOFY")

subroutine(0xA771, "GRIDSET")
subroutine(0xA802, "GRS1")

exec(open('py8dis-scripts/common-variables.py').read())

go()
