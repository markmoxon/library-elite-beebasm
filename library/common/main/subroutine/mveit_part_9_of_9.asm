\ ******************************************************************************
\
\       Name: MVEIT (Part 9 of 9)
\       Type: Subroutine
\   Category: Moving
\    Summary: Move current ship: Redraw on scanner, if it hasn't been destroyed
\
\ ------------------------------------------------------------------------------
\
\ This routine has multiple stages. This stage does the following:
\
\   * If the ship is exploding or being removed, hide it on the scanner
\
\   * Otherwise redraw the ship on the scanner, now that it's been moved
\
\ ******************************************************************************

.MV5

IF _ELITE_A_6502SP_PARA

 BIT dockedp            \ AJD
 BPL l_noradar

ENDIF

IF NOT(_ELITE_A_DOCKED)

 LDA INWK+31            \ Fetch the ship's exploding/killed state from byte #31

ENDIF

IF _DISC_DOCKED OR _ELITE_A_ENCYCLOPEDIA \ Platform

 AND #%00100000         \ If we are exploding then jump to MVD1 to remove it
 BNE MVD1               \ from the scanner permanently

ELIF _CASSETTE_VERSION OR _ELECTRON_VERSION OR _6502SP_VERSION OR _DISC_FLIGHT OR _ELITE_A_FLIGHT OR _ELITE_A_6502SP_PARA OR _MASTER_VERSION

 AND #%10100000         \ If we are exploding or removing this ship then jump to
 BNE MVD1               \ MVD1 to remove it from the scanner permanently

ENDIF

IF NOT(_ELITE_A_DOCKED)

 LDA INWK+31            \ Set bit 4 to keep the ship visible on the scanner
 ORA #%00010000
 STA INWK+31

ENDIF

IF _CASSETTE_VERSION OR _ELECTRON_VERSION OR _6502SP_VERSION OR _DISC_FLIGHT OR _ELITE_A_FLIGHT OR _ELITE_A_6502SP_PARA OR _MASTER_VERSION \ Platform

 JMP SCAN               \ Display the ship on the scanner, returning from the
                        \ subroutine using a tail call

ENDIF

IF NOT(_ELITE_A_DOCKED)

.MVD1

 LDA INWK+31            \ Clear bit 4 to hide the ship on the scanner
 AND #%11101111
 STA INWK+31

ENDIF

IF _ELITE_A_6502SP_PARA

 .l_noradar

ENDIF

 RTS                    \ Return from the subroutine

