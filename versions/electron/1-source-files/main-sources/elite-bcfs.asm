\ ******************************************************************************
\
\ ELECTRON ELITE BIG CODE FILE SOURCE
\
\ Electron Elite was written by Ian Bell and David Braben and is copyright
\ Acornsoft 1984
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
\ The deep dive articles referred to in this commentary can be found at
\ https://www.bbcelite.com/deep_dives
\
\ ------------------------------------------------------------------------------
\
\ This source file produces the following binary files:
\
\   * 3-assembled-output/ELITECO.bin
\
\ after reading in the following files:
\
\   * 3-assembled-output/ELTA.bin
\   * 3-assembled-output/ELTB.bin
\   * 3-assembled-output/ELTC.bin
\   * 3-assembled-output/ELTD.bin
\   * 3-assembled-output/ELTE.bin
\   * 3-assembled-output/ELTF.bin
\   * 3-assembled-output/ELTG.bin
\   * 3-assembled-output/SHIPS.bin
\   * 3-assembled-output/WORDS9.bin
\
\ ******************************************************************************

INCLUDE "versions/electron/1-source-files/main-sources/elite-header.h.asm"

_CASSETTE_VERSION       = (_VERSION = 1)
_DISC_VERSION           = (_VERSION = 2)
_6502SP_VERSION         = (_VERSION = 3)
_MASTER_VERSION         = (_VERSION = 4)
_ELECTRON_VERSION       = (_VERSION = 5)
_ELITE_A_VERSION        = (_VERSION = 6)

GUARD &5800             \ Guard against assembling over screen memory

\ ******************************************************************************
\
\ Configuration variables
\
\ ******************************************************************************

CODE% = &0D00           \ CODE% is set to the location that the main game code
                        \ gets moved to after it is loaded

LOAD% = &2000           \ The load address of the main game code file

\ ******************************************************************************
\
\ Load the compiled binaries to create the Big Code File
\
\ ******************************************************************************

ORG CODE%

.elitea

PRINT "elitea = ", ~P%
INCBIN "versions/electron/3-assembled-output/ELTA.bin"

.eliteb

PRINT "eliteb = ", ~P%
INCBIN "versions/electron/3-assembled-output/ELTB.bin"

.elitec

PRINT "elitec = ", ~P%
INCBIN "versions/electron/3-assembled-output/ELTC.bin"

.elited

PRINT "elited = ", ~P%
INCBIN "versions/electron/3-assembled-output/ELTD.bin"

.elitee

PRINT "elitee = ", ~P%
INCBIN "versions/electron/3-assembled-output/ELTE.bin"

.elitef

PRINT "elitef = ", ~P%
INCBIN "versions/electron/3-assembled-output/ELTF.bin"

.eliteg

PRINT "eliteg = ", ~P%
INCBIN "versions/electron/3-assembled-output/ELTG.bin"

.checksum0

PRINT "checksum0 = ", ~P%

 SKIP 1                 \ We skip this byte so we can insert the checksum later
                        \ in elite-checksum.py

.ships

PRINT "ships = ", ~P%
INCBIN "versions/electron/3-assembled-output/SHIPS.bin"

.end

\ ******************************************************************************
\
\ Save 3-assembled-output/ELITECO.unprot.bin
\
\ ******************************************************************************

PRINT "P% = ", ~P%
PRINT "S.ELITECO ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
SAVE "versions/electron/3-assembled-output/ELITECO.unprot.bin", CODE%, P%, LOAD%