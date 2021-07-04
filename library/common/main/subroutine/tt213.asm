\ ******************************************************************************
\
\       Name: TT213
\       Type: Subroutine
\   Category: Inventory
IF _CASSETTE_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION OR _6502SP_VERSION OR _MASTER_VERSION \ Comment
\    Summary: Show the Inventory screen (red key f9)
ELIF _ELECTRON_VERSION
\    Summary: Show the Inventory screen (FUNC-0)
ENDIF
\
\ ******************************************************************************

.TT213

IF _CASSETTE_VERSION OR _ELECTRON_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION \ 6502SP: In the 6502SP version, you can send the Inventory screen to the printer by pressing CTRL-f9

 LDA #8                 \ Clear the top part of the screen, draw a white border,
 JSR TT66               \ and set the current view type in QQ11 to 8 (Inventory
                        \ screen)

ELIF _6502SP_VERSION OR _MASTER_VERSION

 LDA #8                 \ Clear the top part of the screen, draw a white border,
 JSR TRADEMODE          \ and set up a printable trading screen with a view type
                        \ in QQ11 of 4 (Inventory screen)

ENDIF

IF _CASSETTE_VERSION OR _ELECTRON_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION OR _MASTER_VERSION \ Tube

 LDA #11                \ Move the text cursor to column 11 to print the screen
 STA XC                 \ title

ELIF _6502SP_VERSION

 LDA #11                \ Move the text cursor to column 11 to print the screen
 JSR DOXC               \ title

ENDIF

 LDA #164               \ Print recursive token 4 ("INVENTORY{crlf}") followed
 JSR TT60               \ by a paragraph break and Sentence Case

 JSR NLIN4              \ Draw a horizontal line at pixel row 19 to box in the
                        \ title. The authors could have used a call to NLIN3
                        \ instead and saved the above call to TT60, but you
                        \ just can't optimise everything

 JSR fwl                \ Call fwl to print the fuel and cash levels on two
                        \ separate lines

IF NOT(_ELITE_A_VERSION)

 LDA CRGO               \ If our ship's cargo capacity is < 26 (i.e. we do not
 CMP #26                \ have a cargo bay extension), skip the following two
 BCC P%+7               \ instructions

 LDA #107               \ We do have a cargo bay extension, so print recursive
 JSR TT27               \ token 107 ("LARGE CARGO{sentence case} BAY")

ELIF _ELITE_A_DOCKED OR _ELITE_A_6502SP_PARA

 LDA #14                \ Print recursive token 128 ("SPACE") followed by a
 JSR TT68               \ colon

 LDX new_hold           \ Set X to the amount of free space in our current
 DEX                    \ ship's hold, minus 1 as new_hold contains the amount
                        \ of free space plus 1

 CLC                    \ Call pr2 to print the amount of free space as a
 JSR pr2                \ 3-digit number without a decimal point (by clearing
                        \ the C flag)

 JSR TT160              \ Print "t" (for tonne) and a space

ELIF _ELITE_A_FLIGHT

 LDA #14                \ Print recursive token 128 ("SPACE") followed by a
 JSR TT68               \ colon

 LDX new_hold           \ Set X to the amount of free space in our current
 DEX                    \ ship's hold, minus 1 as new_hold contains the amount
                        \ of free space plus 1

 JSR pr2-1              \ Call pr2-1 to print the amount of free space as a
                        \ 3-digit number without a decimal point

 JSR TT160              \ Print "t" (for tonne) and a space

ENDIF

 JMP TT210              \ Jump to TT210 to print the contents of our cargo bay
                        \ and return from the subroutine using a tail call

