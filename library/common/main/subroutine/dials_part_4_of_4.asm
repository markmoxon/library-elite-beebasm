\ ******************************************************************************
\
\       Name: DIALS (Part 4 of 4)
\       Type: Subroutine
\   Category: Dashboard
\    Summary: Update the dashboard: shields, fuel, laser & cabin temp, altitude
\  Deep dive: The dashboard indicators
\
\ ******************************************************************************

IF _CASSETTE_VERSION OR _DISC_VERSION

 LDA #&78               \ Set SC(1 0) = &7810, which is the screen address for
 STA SC+1               \ the character block containing the left end of the
 LDA #&10               \ top indicator in the left part of the dashboard, the
 STA SC                 \ one showing the forward shield

ELIF _6502SP_VERSION

 LDA #&70               \ Set SC(1 0) = &7020, which is the screen address for
 STA SC+1               \ the character block containing the left end of the
 LDA #&20               \ top indicator in the left part of the dashboard, the
 STA SC                 \ one showing the forward shield

ENDIF

 LDA FSH                \ Draw the forward shield indicator using a range of
 JSR DILX               \ 0-255, and increment SC to point to the next indicator
                        \ (the aft shield)

 LDA ASH                \ Draw the aft shield indicator using a range of 0-255,
 JSR DILX               \ and increment SC to point to the next indicator (the
                        \ fuel level)

IF _6502SP_VERSION

 LDA #YELLOW2           \ Set K (the colour we should show for high values) to
 STA K                  \ yellow

 STA K+1                \ Set K+1 (the colour we should show for low values) to
                        \ yellow, so the fuel indicator always shows in this
                        \ colour

ENDIF

 LDA QQ14               \ Draw the fuel level indicator using a range of 0-63,
 JSR DILX+2             \ and increment SC to point to the next indicator (the
                        \ cabin temperature)

IF _CASSETTE_VERSION OR _DISC_VERSION

 JSR PZW                \ Call PZW to set A to the colour for dangerous values
                        \ and X to the colour for safe values

ELIF _6502SP_VERSION

 JSR PZW2               \ Call PZW2 to set A to the colour for dangerous values
                        \ and X to the colour for safe values, suitable for
                        \ non-striped indicators

ENDIF

 STX K+1                \ Set K+1 (the colour we should show for low values) to
                        \ X (the colour to use for safe values)

 STA K                  \ Set K (the colour we should show for high values) to
                        \ A (the colour to use for dangerous values)

                        \ The above sets the following indicators to show red
                        \ for high values and yellow/white for low values, which
                        \ we use for the cabin and laser temperature bars

 LDX #11                \ Set T1 to 11, the threshold at which we change the
 STX T1                 \ cabin and laser temperature indicators' colours

 LDA CABTMP             \ Draw the cabin temperature indicator using a range of
 JSR DILX               \ 0-255, and increment SC to point to the next indicator
                        \ (the laser temperature)

 LDA GNTMP              \ Draw the laser temperature indicator using a range of
 JSR DILX               \ 0-255, and increment SC to point to the next indicator
                        \ (the altitude)

 LDA #240               \ Set T1 to 240, the threshold at which we change the
 STA T1                 \ altitude indicator's colour. As the altitude has a
                        \ range of 0-255, pixel 16 will not be filled in, and
                        \ 240 would change the colour when moving between pixels
                        \ 15 and 16, so this effectively switches off the colour
                        \ change for the altitude indicator

IF _CASSETTE_VERSION OR _DISC_FLIGHT

 STA K+1                \ Set K+1 (the colour we should show for low values) to
                        \ 240, or &F0 (dashboard colour 2, yellow/white), so the
                        \ altitude indicator always shows in this colour

 LDA ALTIT              \ Draw the altitude indicator using a range of 0-255
 JSR DILX

 JMP COMPAS             \ We have now drawn all the indicators, so jump to
                        \ COMPAS to draw the compass, returning from the
                        \ subroutine using a tail call

ELIF _DISC_DOCKED

 STA K+1                \ Set K+1 (the colour we should show for low values) to
                        \ 240, or &F0 (dashboard colour 2, yellow/white), so the
                        \ altitude indicator always shows in this colour

 LDA ALTIT              \ Draw the altitude indicator using a range of 0-255,
 JMP DILX               \ returning from the subroutine using a tail call

ELIF _6502SP_VERSION

 LDA #YELLOW2           \ Set K (the colour we should show for high values) to
 STA K                  \ yellow

 STA K+1                \ Set K+1 (the colour we should show for low values) to
                        \ yellow, so the altitude indicator always shows in this
                        \ colour

 LDA ALTIT              \ Draw the altitude indicator using a range of 0-255,
 JMP DILX               \ returning from the subroutine using a tail call

ENDIF

