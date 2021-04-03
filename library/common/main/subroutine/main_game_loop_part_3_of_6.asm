\ ******************************************************************************
\
\       Name: Main game loop (Part 3 of 6)
\       Type: Subroutine
\   Category: Main loop
\    Summary: Potentially spawn a cop, particularly if we've been bad
\  Deep dive: Program flow of the main game loop
\             Ship data blocks
\
\ ------------------------------------------------------------------------------
\
\ This section covers the following:
\
\   * Potentially spawn a cop (in a Viper), very rarely if we have been good,
\     more often if have been naughty, and very often if we have been properly
\     bad
\
IF _6502SP_VERSION OR _MASTER_VERSION \ Comment
\   * Very rarely, consider spawning a Thargoid, or vanishingly rarely, a Cougar
\
ENDIF
\ ******************************************************************************

.MTT1

IF _CASSETTE_VERSION \ Minor

 LDA SSPR               \ If we are inside the space station's safe zone, jump
 BNE MLOOP              \ to MLOOP to skip the following

ELIF _6502SP_VERSION OR _DISC_VERSION OR _MASTER_VERSION

 LDA SSPR               \ If we are outside the space station's safe zone, skip
 BEQ P%+5               \ the following instruction

.MLOOPS

 JMP MLOOP              \ Jump to MLOOP to skip the following

ENDIF

 JSR BAD                \ Call BAD to work out how much illegal contraband we
                        \ are carrying in our hold (A is up to 40 for a
                        \ standard hold crammed with contraband, up to 70 for
                        \ an extended cargo hold full of narcotics and slaves)

 ASL A                  \ Double A to a maximum of 80 or 140

 LDX MANY+COPS          \ If there are no cops in the local bubble, skip the
 BEQ P%+5               \ next instruction

 ORA FIST               \ There are cops in the vicinity and we've got a hold
                        \ full of jail time, so OR the value in A with FIST to
                        \ get a new value that is at least as high as both
                        \ values, to reflect the fact that they have almost
                        \ certainly scanned our ship

 STA T                  \ Store our badness level in T

 JSR Ze                 \ Call Ze to initialise INWK to a potentially hostile
                        \ ship, and set A and X to random values

IF _6502SP_VERSION OR _MASTER_VERSION \ Advanced: When considering spawning cops, the advanced versions have a 0.4% chance of spawning a Cougar or a Thargoid instead

 CMP #136               \ If the random number in A = 136 (0.4% chance), jump
 BEQ fothg              \ to fothg in part 4 to spawn either a Thargoid or, very
                        \ rarely, a Cougar

ENDIF

 CMP T                  \ If the random value in A >= our badness level, which
 BCS P%+7               \ will be the case unless we have been really, really
                        \ bad, then skip the following two instructions (so if
                        \ we are really bad, there's a higher chance of
                        \ spawning a cop, otherwise we got away with it, for
                        \ now)

 LDA #COPS              \ Add a new police ship to the local bubble
 JSR NWSHP

IF _CASSETTE_VERSION \ Label

 LDA MANY+COPS          \ If we now have at least one cop in the local bubble,
 BNE MLOOP              \ jump down to MLOOP, otherwise fall through into the
                        \ next part to look at spawning something else

ELIF _6502SP_VERSION OR _DISC_VERSION OR _MASTER_VERSION

 LDA MANY+COPS          \ If we now have at least one cop in the local bubble,
 BNE MLOOPS             \ jump down to MLOOPS, otherwise fall through into the
                        \ next part to look at spawning something else

ENDIF

