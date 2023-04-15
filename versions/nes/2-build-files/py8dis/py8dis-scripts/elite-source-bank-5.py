from commands import *


load(0x8000, "slices/bank5.bin", "6502")

config.set_lower_case(False)

# Remove all extras
# config.set_label_references(False)
# config.set_hex_dump(False)
# config.show_autogenerated_labels = False
# config.show_all_labels = False
config.set_inline_comment_column(50)

entry(0x8000)
entry(0x8007)
string(0x8008, 4)

entry(0x800C)

exec(open('py8dis-scripts/common-variables.py').read())

go()

