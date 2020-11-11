\ ******************************************************************************
\
\       Name: qv
\       Type: Subroutine
\   Category: Equipment
\    Summary: Print a menu of the four space views, for buying lasers
\
\ ------------------------------------------------------------------------------
\
\ Print a menu in the bottom-middle of the screen, at row 16, column 12, that
\ lists the four available space views, like this:
\
\                 0 Front
\                 1 Rear
\                 2 Left
\                 3 Right
\
\ Also print a "View ?" prompt and ask for a view number. The menu is shown
\ when we choose to buy a new laser in the Equip Ship screen.
\
\ Returns:
\
\   X                   The chosen view number (0-3)
\
\ ******************************************************************************

.qv

IF _CASSETTE_VERSION

 LDY #16                \ Move the text cursor to row 16, and at the same time
 STY YC                 \ set Y to a counter going from 16-20 in the loop below

ELIF _6502SP_VERSION

 LDA tek
 CMP #8
 BCC P%+7
 LDA #32
 JSR TT66
 LDA #16
 TAY
 JSR DOYC

ENDIF

.qv1

IF _CASSETTE_VERSION

 LDX #12                \ Move the text cursor to column 12
 STX XC

ELIF _6502SP_VERSION

 LDA #12                \ Move the text cursor to column 12
 JSR DOXC

ENDIF

 TYA                    \ Transfer the counter value from Y to A

 CLC                    \ Print ASCII character "0" - 16 + A, so as A goes from
 ADC #'0'-16            \ 16 to 20, this prints "0" through "3" followed by a
 JSR spc                \ space

 LDA YC                 \ Print recursive text token 80 + YC, so as YC goes from
 CLC                    \ 16 to 20, this prints "FRONT", "REAR", "LEFT" and
 ADC #80                \ "RIGHT"
 JSR TT27

IF _CASSETTE_VERSION

 INC YC                 \ Move the text cursor down a row)

ELIF _6502SP_VERSION

 JSR INCYC              \ Move the text cursor down a row)

ENDIF

 LDY YC                 \ Update Y with the incremented counter in YC

 CPY #20                \ If Y < 20 then loop back up to qv1 to print the next
 BCC qv1                \ view in the menu

IF _CASSETTE_VERSION

.qv3

ENDIF

 JSR CLYNS              \ Clear the bottom three text rows of the upper screen,
                        \ and move the text cursor to column 1 on row 21, i.e.
                        \ the start of the top row of the three bottom rows

.qv2

 LDA #175               \ Print recursive text token 15 ("VIEW ") followed by
 JSR prq                \ a question mark

 JSR TT217              \ Scan the keyboard until a key is pressed, and return
                        \ the key's ASCII code in A (and X)

 SEC                    \ Subtract ASCII '0' from the key pressed, to leave the
 SBC #'0'               \ numeric value of the key in A (if it was a number key)

IF _CASSETTE_VERSION

 CMP #4                 \ If the number entered in A >= 4, then it is not a
 BCS qv3                \ valid view number, so jump back to qv3 to try again

ELIF _6502SP_VERSION

 CMP #4
 BCC qv3
 JSR CLYNS
 JMP qv2

.qv3

ENDIF

 TAX                    \ We have a valid view number, so transfer it to X

 RTS                    \ Return from the subroutine

