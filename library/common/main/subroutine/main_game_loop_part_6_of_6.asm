\ ******************************************************************************
\
\       Name: Main game loop (Part 6 of 6)
\       Type: Subroutine
\   Category: Main loop
\    Summary: Process non-flight key presses (red function keys, docked keys)
\  Deep dive: Program flow of the main game loop
\
\ ------------------------------------------------------------------------------
\
\ This is the second half of the minimal game loop, which we iterate when we are
\ docked. This section covers the following:
\
\   * Process more key presses (red function keys, docked keys etc.)
\
\ It also support joining the main loop with a key already "pressed", so we can
\ jump into the main game loop to perform a specific action. In practice, this
\ is used when we enter the docking bay in BAY to display Status Mode (red key
\ f8), and when we finish buying or selling cargo in BAY2 to jump to the
\ Inventory (red key f9).
\
\ Other entry points:
\
\   FRCE                The entry point for the main game loop if we want to
\                       jump straight to a specific screen, by pretending to
\                       "press" a key, in which case A contains the internal key
\                       number of the key we want to "press"
\
IF _CASSETTE_VERSION \ Comment
\   tha                 Consider spawning a Thargoid (22% chance)
\
ENDIF
\ ******************************************************************************

.FRCE

 JSR TT102              \ Call TT102 to process the key pressed in A

IF _CASSETTE_VERSION OR _6502SP_VERSION OR _DISC_DOCKED \ Platform

 LDA QQ12               \ Fetch the docked flag from QQ12 into A

 BNE MLOOP              \ If we are docked, loop back up to MLOOP just above
                        \ to restart the main loop, but skipping all the flight
                        \ and spawning code in the top part of the main loop

ELIF _MASTER_VERSION

 LDA QQ12               \ Fetch the docked flag from QQ12 into A

 BEQ P%+5               \ ???

 JMP MLOOP

ENDIF

 JMP TT100              \ Otherwise jump to TT100 to restart the main loop from
                        \ the start

IF _CASSETTE_VERSION \ Platform

.tha

 JSR DORND              \ Set A and X to random numbers

 CMP #200               \ If A < 200 (78% chance), skip the next instruction
 BCC P%+5

 JSR GTHG               \ Call GTHG to spawn a Thargoid ship

 JMP MLOOP              \ Jump back into the main loop at MLOOP, which is just
                        \ after the ship-spawning section

ENDIF

