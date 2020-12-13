\ ******************************************************************************
\
\       Name: DKS2
\       Type: Subroutine
\   Category: Keyboard
\    Summary: Read the joystick position
\
\ ------------------------------------------------------------------------------
\
\ Return the value of ADC channel in X (used to read the joystick). The value
\ will be inverted if the game has been configured to reverse both joystick
\ channels (which can be done by pausing the game and pressing J).
\
\ Arguments:
\
\   X                   The ADC channel to read:
\
\                         * 1 = joystick X
\
\                         * 2 = joystick Y
\
\ Returns:
\
\   (A X)               The 16-bit value read from channel X, with the value
\                       inverted if the game has been configured to reverse the
\                       joystick
\
\ ******************************************************************************

.DKS2

IF _CASSETTE_VERSION

 LDA #128               \ Call OSBYTE 128 to fetch the 16-bit value from ADC
 JSR OSBYTE             \ channel X, returning (Y X), i.e. the high byte in Y
                        \ and the low byte in X

 TYA                    \ Copy Y to A, so the result is now in (A X)

ELIF _6502SP_VERSION

 LDA KTRAN+7,X          \ Fetch either the joystick X value or joystick Y value 
                        \ from the key logger buffer, depending on the value of
                        \ X (i.e. fetch either KTRAN+8 or KTRAN+0)

ENDIF

 EOR JSTE               \ The high byte A is now EOR'd with the value in
                        \ location JSTE, which contains &FF if both joystick
                        \ channels are reversed and 0 otherwise (so A now
                        \ contains the high byte but inverted, if that's what
                        \ the current settings say)

 RTS                    \ Return from the subroutine
