\ ******************************************************************************
\
\ 6502 SECOND PROCESSOR ELITE I/O LOADER (PART 1) SOURCE
\
\ 6502 Second Processor Elite was written by Ian Bell and David Braben and is
\ copyright Acornsoft 1985
\
\ The code on this site is identical to the version released on Ian Bell's
\ personal website at http://www.elitehomepage.org/
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
\   * output/ELITE.bin
\
\ ******************************************************************************

INCLUDE "versions/6502sp/sources/elite-header.h.asm"

_CASSETTE_VERSION       = TRUE AND (_VERSION = 1)
_DISC_VERSION           = TRUE AND (_VERSION = 2)
_6502SP_VERSION         = TRUE AND (_VERSION = 3)

IF _6502SP_VERSION

 _SNG45                 = (_SUBVERSION = 1)
 _SOURCE_DISC           = (_SUBVERSION = 2)

ELSE

 _SNG45                 = FALSE
 _SOURCE_DISC           = FALSE

ENDIF

\ ******************************************************************************
\
\ Configuration variables
\
\ ******************************************************************************

N% = 77                 \ N% is set to the number of bytes in the VDU table, so
                        \ we can loop through them in the loader below

OSWRCH = &FFEE          \ The address for the OSWRCH routine
OSBYTE = &FFF4          \ The address for the OSBYTE routine
OSWORD = &FFF1          \ The address for the OSWORD routine
SCLI = &FFF7            \ The address for the OSCLI routine

VIA = &FE00             \ Memory-mapped space for accessing internal hardware,
                        \ such as the video ULA, 6845 CRTC and 6522 VIAs (also
                        \ known as SHEILA)

IRQ1V = &204            \ The IRQ1V vector that we intercept to implement the
                        \ split-sceen mode

ZP = &90                \ Temporary storage, used all over the place

P = &92                 \ Temporary storage, used all over the place

Q = &93                 \ Temporary storage, used all over the place

YY = &94                \ Temporary storage, used when drawing Saturn

T = &95                 \ Temporary storage, used all over the place

CODE% = &2000
LOAD% = &2000

ORG CODE%

INCLUDE "library/common/loader/variable/b_per_cent.asm"
INCLUDE "library/common/loader/variable/e_per_cent.asm"
INCLUDE "library/common/loader/macro/fne.asm"
INCLUDE "library/6502sp/loader1/subroutine/elite_loader.asm"
INCLUDE "library/common/loader/subroutine/pll1.asm"
INCLUDE "library/common/loader/subroutine/dornd.asm"
INCLUDE "library/6502sp/loader1/variable/rand.asm"
INCLUDE "library/common/loader/subroutine/squa2.asm"
INCLUDE "library/common/loader/subroutine/pix.asm"
INCLUDE "library/common/loader/variable/twos.asm"
INCLUDE "library/common/loader/variable/cnt.asm"
INCLUDE "library/common/loader/variable/cnt2.asm"
INCLUDE "library/common/loader/variable/cnt3.asm"
INCLUDE "library/common/loader/subroutine/root.asm"
INCLUDE "library/common/loader/subroutine/osb.asm"
INCLUDE "library/6502sp/loader1/variable/mess1.asm"
INCLUDE "library/6502sp/loader1/variable/mess2.asm"

\ ******************************************************************************
\
\ Save output/ELITE.bin
\
\ ******************************************************************************

PRINT "S.ELITE ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
SAVE "versions/6502sp/output/ELITE.bin", CODE%, P%, LOAD%