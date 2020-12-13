\ ******************************************************************************
\
\ ELITE LOADER SOURCE
\
\ Elite was written by Ian Bell and David Braben and is copyright Acornsoft 1984
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
\   * output/ELITE.unprot.bin
\
\ after reading in the following files:
\
\   * binaries/DIALS.bin
\   * binaries/P.ELITE.bin
\   * binaries/P.A-SOFT.bin
\   * binaries/P.(C)ASFT.bin
\   * output/WORDS9.bin
\   * output/PYTHON.bin
\
\ ******************************************************************************

INCLUDE "versions/cassette/sources/elite-header.h.asm"

_CASSETTE_VERSION       = TRUE AND (_VERSION = 1)
_DISC_VERSION           = TRUE AND (_VERSION = 2)
_6502SP_VERSION         = TRUE AND (_VERSION = 3)

\ ******************************************************************************
\
\ Configuration variables
\
\ ******************************************************************************

DISC = TRUE             \ Set to TRUE to load the code above DFS and relocate
                        \ down, so we can load the cassette version from disc

PROT = FALSE            \ Set to TRUE to enable the tape protection code

LOAD% = &1100           \ LOAD% is the load address of the main game code file
                        \ ("ELTcode" for loading from disc, "ELITEcode" for
                        \ loading from tape)

C% = &0F40              \ C% is set to the location that the main game code gets
                        \ moved to after it is loaded

S% = C%                 \ S% points to the entry point for the main game code

L% = LOAD% + &28        \ L% points to the start of the actual game code from
                        \ elite-source.asm, after the &28 bytes of header code
                        \ that are inserted by elite-bcfs.asm

D% = &563A              \ D% is set to the size of the main game code

LC% = &6000 - C%        \ LC% is set to the maximum size of the main game code
                        \ (as the code starts at C% and screen memory starts
                        \ at &6000)

N% = 67                 \ N% is set to the number of bytes in the VDU table, so
                        \ we can loop through them in part 2 below

SVN = &7FFD             \ SVN is where we store the "saving in progress" flag,
                        \ and it matches the location in elite-source.asm

VEC = &7FFE             \ VEC is where we store the original value of the IRQ1
                        \ vector, and it matches the value in elite-source.asm

LEN1 = 15               \ Size of the BEGIN% routine that gets pushed onto the
                        \ stack and executed there

LEN2 = 18               \ Size of the MVDL routine that gets pushed onto the
                        \ stack and executed there

LEN = LEN1 + LEN2       \ Total number of bytes that get pushed on the stack for
                        \ execution there (33)

LE% = &0B00             \ LE% is the address to which the code from UU% onwards
                        \ is copied in part 3. It contains:
                        \
                        \   * ENTRY2, the entry point for the second block of
                        \     loader code
                        \
                        \   * IRQ1, the interrupt routine for the split-screen
                        \     mode
                        \
                        \   * BLOCK, which by this point has already been put
                        \     on the stack by this point
                        \
                        \   * The variables used by the above

IF DISC

 CODE% = &E00+&300      \ CODE% is set to the assembly address of the loader
                        \ code file that we assemble in this file ("ELITE")

ELSE

 CODE% = &E00

ENDIF

NETV = &224             \ MOS vectors that we want to intercept
IRQ1V = &204

OSWRCH = &FFEE          \ The address for the OSWRCH routine
OSBYTE = &FFF4          \ The address for the OSBYTE routine
OSWORD = &FFF1          \ The address for the OSWORD routine
OSPRNT = &234           \ The address for the OSPRNT vector

VIA = &FE00             \ Memory-mapped space for accessing internal hardware,
                        \ such as the video ULA, 6845 CRTC and 6522 VIAs (also
                        \ known as SHEILA)

VSCAN = 57-1            \ Defines the split position in the split-screen mode

TRTB% = &04             \ TRTB%(1 0) points to the keyboard translation table

ZP = &70                \ Temporary storage, used all over the place

P = &72                 \ Temporary storage, used all over the place

Q = &73                 \ Temporary storage, used all over the place

YY = &74                \ Temporary storage, used when drawing Saturn

T = &75                 \ Temporary storage, used all over the place

SC = &76                \ Used to store the screen address while plotting pixels

BLPTR = &78             \ Gets set to &03CA as part of the obfuscation code

V219 = &7A              \ Gets set to &0218 as part of the obfuscation code

K3 = &80                \ Temporary storage, used for preserving the A register

BLCNT = &81             \ Stores the tape loader block count as part of the copy
                        \ protection code in IRQ1

BLN = &83               \ Gets set to &03C6 as part of the obfuscation code

EXCN = &85              \ Gets set to &03C2 as part of the obfuscation code

INCLUDE "library/cassette/loader/subroutine/elite_loader_part_1_of_6.asm"
INCLUDE "library/common/loader/variable/b_per_cent.asm"
INCLUDE "library/common/loader/variable/e_per_cent.asm"
INCLUDE "library/cassette/loader/subroutine/swine.asm"
INCLUDE "library/cassette/loader/subroutine/osb.asm"
INCLUDE "library/cassette/loader/variable/authors_names.asm"
INCLUDE "library/cassette/loader/variable/oscliv.asm"
INCLUDE "library/cassette/loader/variable/david9.asm"
INCLUDE "library/cassette/loader/variable/david23.asm"
INCLUDE "library/cassette/loader/subroutine/doprot1.asm"
INCLUDE "library/cassette/loader/variable/mhca.asm"
INCLUDE "library/cassette/loader/subroutine/david7.asm"
INCLUDE "library/common/loader/macro/fne.asm"
INCLUDE "library/cassette/loader/subroutine/elite_loader_part_2_of_6.asm"
INCLUDE "library/cassette/loader/subroutine/elite_loader_part_3_of_6.asm"
INCLUDE "library/cassette/loader/subroutine/elite_loader_part_4_of_6.asm"
INCLUDE "library/common/loader/subroutine/pll1.asm"
INCLUDE "library/common/loader/subroutine/dornd.asm"
INCLUDE "library/common/loader/subroutine/squa2.asm"
INCLUDE "library/common/loader/subroutine/pix.asm"
INCLUDE "library/common/loader/variable/twos.asm"
INCLUDE "library/common/loader/variable/cnt.asm"
INCLUDE "library/common/loader/variable/cnt2.asm"
INCLUDE "library/common/loader/variable/cnt3.asm"
INCLUDE "library/common/loader/subroutine/root.asm"
INCLUDE "library/cassette/loader/subroutine/begin_per_cent.asm"
INCLUDE "library/cassette/loader/subroutine/domove.asm"
INCLUDE "library/cassette/loader/workspace/uu_per_cent.asm"
INCLUDE "library/cassette/loader/variable/checkbyt.asm"
INCLUDE "library/cassette/loader/variable/mainsum.asm"
INCLUDE "library/cassette/loader/variable/foolv.asm"
INCLUDE "library/cassette/loader/variable/checkv.asm"
INCLUDE "library/cassette/loader/variable/block1.asm"
INCLUDE "library/cassette/loader/variable/block2.asm"
INCLUDE "library/cassette/loader/subroutine/tt26.asm"
INCLUDE "library/cassette/loader/subroutine/osprint.asm"
INCLUDE "library/cassette/loader/subroutine/command.asm"
INCLUDE "library/cassette/loader/variable/mess1.asm"
INCLUDE "library/cassette/loader/subroutine/elite_loader_part_5_of_6.asm"
INCLUDE "library/cassette/loader/variable/m2.asm"
INCLUDE "library/cassette/loader/subroutine/irq1.asm"
INCLUDE "library/cassette/loader/variable/block.asm"
INCLUDE "library/cassette/loader/subroutine/elite_loader_part_6_of_6.asm"
INCLUDE "library/cassette/loader/subroutine/checker.asm"
INCLUDE "library/cassette/loader/variable/xc.asm"
INCLUDE "library/cassette/loader/variable/yc.asm"

\ ******************************************************************************
\
\ Save output/ELITE.unprot.bin
\
\ ******************************************************************************

COPYBLOCK LE%, P%, UU%  \ Copy the block that we assembled at LE% to UU%, which
                        \ is where it will actually run

PRINT "BLOCK offset = ", ~(BLOCK - LE%) + (UU% - CODE%)
PRINT "ENDBLOCK offset = ",~(ENDBLOCK - LE%) + (UU% - CODE%)
PRINT "MAINSUM offset = ",~(MAINSUM - LE%) + (UU% - CODE%)
PRINT "TUT offset = ",~(TUT - LE%) + (UU% - CODE%)
PRINT "UU% = ",~UU%," Q% = ",~Q%, " OSB = ",~OSB

PRINT "Memory usage: ", ~LE%, " - ",~P%
PRINT "Stack: ",LEN + ENDBLOCK - BLOCK

PRINT "S. ELITE ", ~CODE%, " ", ~UU% + (P% - LE%), " ", ~run, " ", ~CODE%
SAVE "versions/cassette/output/ELITE.unprot.bin", CODE%, UU% + (P% - LE%), run, CODE%