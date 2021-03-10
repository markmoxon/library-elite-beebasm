\ ******************************************************************************
\
\       Name: SPIN
\       Type: Subroutine
\   Category: Universe
\    Summary: Randomly spawn cargo from a destroyed ship
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   Y                   The type of cargo to consider spawning (typically #PLT
\                       or #OIL)
\
\ Other entry points:
\
\   oh                  Contains an RTS
\
\   SPIN2               Remove any randomness: spawn cargo of a specific type
\                       (given in X), and always spawn the number given in A
\
\ ******************************************************************************

.SPIN

 JSR DORND              \ Fetch a random number, and jump to oh if it is
 BPL oh                 \ positive (50% chance)

IF _DISC_FLIGHT \ Other: Group A: This might be a bug fix? It prevents the value in A from being changed from a random number to the cargo type to be spawned, which would stop the amount of cargo being spawned from being random (so presumably the 6502SP version always spawns the same amount of cargo from each ship type, with no random factor at all)

 PHA                    \ Store A on the stack so we can restore it after the
                        \ following transfers

ENDIF

 TYA                    \ Copy the cargo type from Y into A and X
 TAX

IF _DISC_FLIGHT \ Other: See group A

 PLA                    \ Restore A from the stack

ENDIF

 LDY #0                 \ Fetch the first byte of the hit ship's blueprint,
 AND (XX0),Y            \ which determines the maximum number of bits of
                        \ debris shown when the ship is destroyed, and AND
                        \ with the random number we just fetched

 AND #15                \ Reduce the random number in A to the range 0-15

.SPIN2

 STA CNT                \ Store the result in CNT, so CNT contains a random
                        \ number between 0 and the maximum number of bits of
                        \ debris that this ship will release when destroyed
                        \ (to a maximum of 15 bits of debris)

.spl

 BEQ oh                 \ We're going to go round a loop using CNT as a counter
                        \ so this checks whether the counter is zero and jumps
                        \ to oh when it gets there (which might be straight
                        \ away)

 LDA #0                 \ Call SFS1 to spawn the specified cargo from the now
 JSR SFS1               \ deceased parent ship, giving the spawned canister an
                        \ AI flag of 0 (no AI, no E.C.M., non-hostile)

 DEC CNT                \ Decrease the loop counter

 BNE spl+2              \ Jump back up to the LDA &0 instruction above (this BPL
                        \ is effectively a JMP as CNT will never be negative)

.oh

 RTS                    \ Return from the subroutine

