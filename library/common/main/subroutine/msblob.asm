\ ******************************************************************************
\
\       Name: msblob
\       Type: Subroutine
\   Category: Dashboard
IF _CASSETTE_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION OR _6502SP_VERSION OR _MASTER_VERSION \ Comment
\    Summary: Display the dashboard's missile indicators in green
ELIF _ELECTRON_VERSION
\    Summary: Display the dashboard's missile indicators as white squares
ENDIF
\
\ ------------------------------------------------------------------------------
\
\ Display the dashboard's missile indicators, with all the missiles reset to
IF _CASSETTE_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION \ Comment
\ green/cyan (i.e. not armed or locked).
ELIF _ELECTRON_VERSION
\ white squares (i.e. not armed or locked).
ELIF _6502SP_VERSION OR _MASTER_VERSION
\ green (i.e. not armed or locked).
ENDIF
\
\ ******************************************************************************

.msblob

 LDX #4                 \ Set up a loop counter in X to count through all four
                        \ missile indicators

.ss

 CPX NOMSL              \ If the counter is equal to the number of missiles,
 BEQ SAL8               \ jump down to SQL8 to draw remaining the missiles, as
IF _CASSETTE_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION \ Comment
                        \ the rest of them are present and should be drawn in
                        \ green/cyan
ELIF _ELECTRON_VERSION
                        \ the rest of them are present and should be drawn as
                        \ white squares
ELIF _6502SP_VERSION OR _MASTER_VERSION
                        \ the rest of them are present and should be drawn in
                        \ green
ENDIF

IF _CASSETTE_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION OR _6502SP_VERSION OR _MASTER_VERSION \ Screen

 LDY #0                 \ Draw the missile indicator at position X in black
 JSR MSBAR

ELIF _ELECTRON_VERSION

 LDY #&04               \ Draw the missile indicator at position X in black
 JSR MSBAR

ENDIF

 DEX                    \ Decrement the counter to point to the next missile

 BNE ss                 \ Loop back to ss if we still have missiles to draw

 RTS                    \ Return from the subroutine

.SAL8

IF _CASSETTE_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION \ Screen

 LDY #&EE               \ Draw the missile indicator at position X in green/cyan
 JSR MSBAR

ELIF _6502SP_VERSION OR _MASTER_VERSION

 LDY #GREEN2            \ Draw the missile indicator at position X in green
 JSR MSBAR

ELIF _ELECTRON_VERSION

 LDY #&09               \ Draw the missile indicator at position X as a white
 JSR MSBAR              \ square

ENDIF

 DEX                    \ Decrement the counter to point to the next missile

 BNE SAL8               \ Loop back to SAL8 if we still have missiles to draw

 RTS                    \ Return from the subroutine

