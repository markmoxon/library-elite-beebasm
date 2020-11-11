\ ******************************************************************************
\
\       Name: EXNO3
\       Type: Subroutine
\   Category: Sound
\    Summary: Make an explosion sound
\
\ ------------------------------------------------------------------------------
\
\ Make the sound of death in the cold, hard vacuum of space. Apparently, in
\ Elite space, everyone can hear you scream.
\
\ This routine also makes the sound of a destroyed cargo canister if we don't
\ get scooping right, the sound of us colliding with another ship, and the sound
\ of us being hit with depleted shields. It is not a good sound to hear.
\
\ ******************************************************************************

.EXNO3

 LDA #16                \ Call the NOISE routine with A = 16 to make the first
 JSR NOISE              \ death sound

 LDA #24                \ Call the NOISE routine with A = 24 to make the second
 BNE NOISE              \ death sound and return from the subroutine using a
                        \ tail call (this BNE is effectively a JMP as A will
                        \ never be zero)

