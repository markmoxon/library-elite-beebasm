\ ******************************************************************************
\
\       Name: ee3
\       Type: Subroutine
\   Category: Text
\    Summary: Print the hyperspace countdown in the top-left of the screen
\
\ ------------------------------------------------------------------------------
\
\ Print the 8-bit number in X at text location (0, 1). Print the number to
\ 5 digits, left-padding with spaces for numbers with fewer than 3 digits (so
\ numbers < 10000 are right-aligned), with no decimal point.
\
\ Arguments:
\
\   X                   The number to print
\
\ ******************************************************************************

.ee3

IF _CASSETTE_VERSION OR _DISC_VERSION

 LDY #1                 \ Move the text cursor to row 1
 STY YC

 DEY                    \ Move the text cursor to column 0
 STY XC

ELIF _6502SP_VERSION

 LDA #RED               \ Send a #SETCOL RED command to the I/O processor to
 JSR DOCOL              \ switch to colour 2, which is red in the space view

 LDA #1                 \ Move the text cursor to column 1 on row 1
 JSR DOXC
 JSR DOYC

 LDY #0                 \ Set Y = 0 for the high byte in pr6

ENDIF

                        \ Fall through into pr6 to print X to 5 digits, as the
                        \ high byte in Y is 0

