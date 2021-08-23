\ ******************************************************************************
\
\ DISC ELITE LOADER (PART 2) SOURCE
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
\ The deep dive articles referred to in this commentary can be found at
\ https://www.bbcelite.com/deep_dives
\
\ ------------------------------------------------------------------------------
\
\ This source file produces the following binary file:
\
\   * 3-assembled-output/ELITE3.bin
\
\ ******************************************************************************

INCLUDE "versions/disc/sources/elite-header.h.asm"

_CASSETTE_VERSION       = (_VERSION = 1)
_DISC_VERSION           = (_VERSION = 2)
_6502SP_VERSION         = (_VERSION = 3)
_MASTER_VERSION         = (_VERSION = 4)
_ELECTRON_VERSION       = (_VERSION = 5)
_ELITE_A_VERSION        = (_VERSION = 6)
_DISC_DOCKED            = FALSE
_DISC_FLIGHT            = TRUE
_ELITE_A_DOCKED         = FALSE
_ELITE_A_FLIGHT         = FALSE
_ELITE_A_SHIPS_R        = FALSE
_ELITE_A_SHIPS_S        = FALSE
_ELITE_A_SHIPS_T        = FALSE
_ELITE_A_SHIPS_U        = FALSE
_ELITE_A_SHIPS_V        = FALSE
_ELITE_A_SHIPS_W        = FALSE
_ELITE_A_ENCYCLOPEDIA   = FALSE
_ELITE_A_6502SP_IO      = FALSE
_ELITE_A_6502SP_PARA    = FALSE
_IB_DISC                = (_RELEASE = 1)
_STH_DISC               = (_RELEASE = 2)

GUARD &7C00             \ Guard against assembling over screen memory

\ ******************************************************************************
\
\ Configuration variables
\
\ ******************************************************************************

VIA = &FE00             \ Memory-mapped space for accessing internal hardware,
                        \ such as the video ULA, 6845 CRTC and 6522 VIAs (also
                        \ known as SHEILA)

OSNEWL = &FFE7          \ The address for the OSNEWL routine
OSWRCH = &FFEE          \ The address for the OSWRCH routine
OSBYTE = &FFF4          \ The address for the OSBYTE routine
OSWORD = &FFF1          \ The address for the OSWORD routine
OSCLI = &FFF7           \ The address for the OSCLI vector

CODE% = &5700
LOAD% = &5700

INCLUDE "library/disc/loader2/workspace/zp.asm"

\ ******************************************************************************
\
\ ELITE LOADER
\
\ ******************************************************************************

ORG CODE%

INCLUDE "library/disc/loader2/subroutine/elite_loader_part_1_of_4.asm"

 SKIP 8                 \ These bytes appear to be unused
 NOP
 NOP

INCLUDE "library/disc/loader2/subroutine/elite_loader_part_2_of_4.asm"

 NOP                    \ These bytes appear to be unused
 NOP
 NOP
 NOP

INCLUDE "library/disc/loader2/subroutine/elite_loader_part_4_of_4.asm"

 SKIP 15                \ These bytes appear to be unused

INCLUDE "library/disc/loader2/variable/mess1.asm"

 SKIP 4                 \ These bytes appear to be unused

INCLUDE "library/disc/loader2/subroutine/elite_loader_part_3_of_4.asm"

 SKIP 63                \ These bytes appear to be unused
 EQUB &32
 SKIP 13

INCLUDE "library/disc/loader2/subroutine/mpl.asm"
INCLUDE "library/disc/loader2/copyblock/loadcode.asm"

 SKIP 487               \ These bytes appear to be unused

INCLUDE "library/disc/loader2/variable/echar.asm"
INCLUDE "library/disc/loader2/variable/logo.asm"

 SKIP 28                \ These bytes appear to be unused
 EQUB &02, &0D
 SKIP 8

INCLUDE "library/disc/loader2/subroutine/prot1.asm"

 SKIP 14                \ These bytes appear to be unused

INCLUDE "library/disc/loader2/subroutine/loadscr.asm"
INCLUDE "library/disc/loader2/subroutine/logos.asm"
INCLUDE "library/disc/loader2/subroutine/prstr.asm"
INCLUDE "library/disc/loader2/subroutine/unused_copy_protection_routine.asm"

\ ******************************************************************************
\
\ Save 3-assembled-output/ELITE2.bin
\
\ ******************************************************************************

PRINT "S.ELITE3 ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
SAVE "versions/disc/3-assembled-output/ELITE3.bin", CODE%, P%, LOAD%

