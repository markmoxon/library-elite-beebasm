from commands import *


load(0x8000, "slices/bank2.bin", "6502")

config.set_lower_case(False)

# Remove all extras
config.set_label_references(False)
config.set_show_autogenerated_labels(False)
config.set_show_all_labels(False)
config.set_inline_comment_column(50)
config.set_subroutine_header("*" * 78)

entry(0x8000)
string(0x8007, 5)

byte(0x800C, 0xC000 - 0x800C)

exec(open('py8dis-scripts/common-variables.py').read())

go()

