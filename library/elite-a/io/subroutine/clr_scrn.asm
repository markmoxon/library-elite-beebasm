\ ******************************************************************************
\
\       Name: clr_scrn
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Clear the top part of the screen (the space view)
\
\ ------------------------------------------------------------------------------
\
\ This routine is run when the parasite sends a clr_scrn command. It clears the
\ top part of the screen (the mode 4 space view).
\
\ ******************************************************************************

.clr_scrn

 LDX #&60               \ Set X to the screen memory page for the top row of the
                        \ screen (as screen memory starts at &6000)

.BOL1

 JSR ZES1               \ Call ZES1 to zero-fill the page in X, which clears
                        \ that character row on the screen

 INX                    \ Increment X to point to the next page, i.e. the next
                        \ character row

 CPX #&78               \ Loop back to BOL1 until we have cleared page &7700,
 BNE BOL1               \ the last character row in the space view part of the
                        \ screen (the top part)

 RTS                    \ Return from the subroutine

