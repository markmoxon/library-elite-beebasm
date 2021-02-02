\ ******************************************************************************
\
\ DISC ELITE MISSILE SHIP BLUEPRINT FILE
\
\ Elite was written by Ian Bell and David Braben and is copyright Acornsoft 1984
\
\ The code on this site has been disassembled from the version released on Ian
\ Bell's personal website at http://www.elitehomepage.org/
\
\ The commentary is copyright Mark Moxon, and any misunderstandings or mistakes
\ in the documentation are entirely my fault
\
\ The terminology and notations used in this commentary are explained at
\ https://www.bbcelite.com/about_site/terminology_used_in_this_commentary.html
\
\ ------------------------------------------------------------------------------
\
\ This source file produces the following binary file:
\
\   * output/MISSILE.bin
\
\ This gets loaded as part of elite-loader3.asm and gets moved to &7F00 during
\ the loading process.
\
\ ******************************************************************************

INCLUDE "versions/disc/sources/elite-header.h.asm"

_CASSETTE_VERSION       = (_VERSION = 1)
_DISC_VERSION           = (_VERSION = 2)
_6502SP_VERSION         = (_VERSION = 3)
_DISC_DOCKED            = TRUE
_DISC_FLIGHT            = FALSE
_IB_DISC                = (_RELEASE = 1)
_STH_DISC               = (_RELEASE = 2)

CODE% = &7F00
LOAD% = &244B

ORG CODE%

INCLUDE "library/common/main/macro/vertex.asm"
INCLUDE "library/common/main/macro/edge.asm"
INCLUDE "library/common/main/macro/face.asm"
INCLUDE "library/common/main/variable/ship_missile.asm"
INCLUDE "library/common/main/variable/vec.asm"

\ ******************************************************************************
\
\ Save output/MISSILE.bin
\
\ ******************************************************************************

PRINT "MISSILE"
PRINT "Assembled at ", ~CODE%
PRINT "Ends at ", ~P%
PRINT "Code size is ", ~(P% - CODE%)
PRINT "Execute at ", ~LOAD%
PRINT "Reload at ", ~LOAD%

PRINT "S.WORDS ",~CODE%," ",~P%," ",~LOAD%," ",~LOAD%
SAVE "versions/disc/output/MISSILE.bin", CODE%, P%, LOAD%