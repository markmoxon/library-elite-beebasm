\ ******************************************************************************
\
\       Name: BR1 (Part 1 of 2)
\       Type: Subroutine
\   Category: Start and end
\    Summary: Start or restart the game
\
\ ------------------------------------------------------------------------------
\
IF _CASSETTE_VERSION OR _DISC_VERSION \ Comment
\ BRKV is set to point to BR1 by elite-loader.asm.
ENDIF
IF _6502SP_VERSION
\ Other entry points:
\
\   QU5                 Restart the game using the last saved commander without
\                       asking whether to load a new commander file
ENDIF
\
\ ******************************************************************************

.BR1

IF _6502SP_VERSION \ Tube

 JSR ZEKTRAN            \ Reset the key logger buffer that gets returned from
                        \ the I/O processor

ENDIF

IF _CASSETTE_VERSION OR _DISC_VERSION \ Tube

 LDX #3                 \ Set XC = 3 (set text cursor to column 3)
 STX XC

ELIF _6502SP_VERSION

 LDA #3                 \ Move the text cursor to column 3
 JSR DOXC

 LDX #3                 \ Set X = 3 for the call to FX200

ENDIF

 JSR FX200              \ Disable the ESCAPE key and clear memory if the BREAK
                        \ key is pressed (*FX 200,3)


IF _CASSETTE_VERSION \ Minor

 LDX #CYL               \ Call TITLE to show a rotating Cobra Mk III (#CYL) and
 LDA #128               \ token 128 ("  LOAD NEW COMMANDER (Y/N)?{crlf}{crlf}"),
 JSR TITLE              \ returning with the internal number of the key pressed
                        \ in A

ELIF _DISC_VERSION OR _6502SP_VERSION

 LDX #CYL               \ Call TITLE to show a rotating Cobra Mk III (#CYL) and
 LDA #6                 \ token 6 ("LOAD NEW {single cap}COMMANDER {all caps}
 JSR TITLE              \ (Y/N)?{sentence case}{cr}{cr}"), returning with the
                        \ internal number of the key pressed in A

ENDIF

IF _6502SP_VERSION \ Advanced: Pressing TAB in the title screen of the 6502SP version will start the demo

 CMP #&60               \ Did we press TAB? If not, skip the following
 BNE P%+5               \ instruction

.BRGO

 JMP DEMON              \ We pressed TAB, so jump to DEMON to show the demo

ENDIF

 CMP #&44               \ Did we press "Y"? If not, jump to QU5, otherwise
 BNE QU5                \ continue on to load a new commander

IF _CASSETTE_VERSION \ Platform

\BR1                    \ These instructions are commented out in the original
\LDX #3                 \ source. This block starts with the same *FX call as
\STX XC                 \ above, then clears the screen, calls a routine to
\JSR FX200              \ flush the keyboard buffer (FLKB) that isn't present
\LDA #1                 \ in the cassette version but is in other versions,
\JSR TT66               \ and then it displays "LOAD NEW COMMANDER (Y/N)?" and
\JSR FLKB               \ lists the current cargo, before falling straight into
\LDA #14                \ the load routine below, whether or not we have
\JSR TT214              \ pressed "Y". This may be a bit of testing code, as the
\BCC QU5                \ first line is a commented label, BR1, which is where
                        \ BRKV points, so when this is uncommented, pressing
                        \ the BREAK key should jump straight to the load screen

 JSR GTNME              \ We want to load a new commander, so we need to get
                        \ the commander name to load

 JSR LOD                \ We then call the LOD subroutine to load the commander
                        \ file to address NA%+8, which is where we store the
                        \ commander save file

 JSR TRNME              \ Once loaded, we copy the commander name to NA%

 JSR TTX66              \ And we clear the top part of the screen and draw a
                        \ white border

ELIF _DISC_VERSION OR _6502SP_VERSION

 JSR DFAULT             \ Call DFAULT to reset the current commander data block
                        \ to the last saved commander

 JSR SVE                \ Call SVE to load a new commander into the last saved
                        \ commander data block

.QU5

 JSR DFAULT             \ Call DFAULT to reset the current commander data block
                        \ to the last saved commander

ENDIF