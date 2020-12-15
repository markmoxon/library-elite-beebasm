\ ******************************************************************************
\
\       Name: FONT%
\       Type: Variable
\   Category: Text
\    Summary: A copy of the character definition bitmap table from the MOS ROM
\
\ ------------------------------------------------------------------------------
\
\ This is used by the TT26 routine to save time looking up the character bitmaps
\ from the ROM. Note that FONT% contains just the high byte (i.e. the page
\ number) of the address of this table, rather than the full address.
\
\ The contents of the P.FONT.bin file included here are taken straight from the
\ following three pages in the BBC Micro OS 1.20 ROM:
\
\   ASCII 32-63  are defined in &C000-&C0FF (page 0)
\   ASCII 64-95  are defined in &C100-&C1FF (page 1)
\   ASCII 96-126 are defined in &C200-&C2F0 (page 2)
\
\ The code could look these values up each time (as the cassette version does),
\ but it's quicker to use a lookup table, at the expense of three pages of
\ memory.
\
\ ******************************************************************************

ORG CODE%

FONT% = P% DIV 256

INCBIN "versions/6502sp/binaries/P.FONT.bin"

