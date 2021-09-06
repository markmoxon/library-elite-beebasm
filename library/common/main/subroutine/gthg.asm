\ ******************************************************************************
\
\       Name: GTHG
\       Type: Subroutine
\   Category: Universe
\    Summary: Spawn a Thargoid ship and a Thargon companion
\  Deep dive: Fixing ship positions
\
\ ******************************************************************************

.GTHG

 JSR Ze                 \ Call Ze to initialise INWK
                        \
                        \ Note that because Ze uses the value of X returned by
                        \ DORND, and X contains the value of A returned by the
                        \ previous call to DORND, this does not set the new ship
                        \ to a totally random location. See the deep dive on
                        \ "Fixing ship positions" for details

 LDA #%11111111         \ Set the AI flag in byte #32 so that the ship has AI,
 STA INWK+32            \ is extremely and aggressively hostile, and has E.C.M.

 LDA #THG               \ Call NWSHP to add a new Thargoid ship to our local
 JSR NWSHP              \ bubble of universe

 LDA #TGL               \ Call NWSHP to add a new Thargon ship to our local
 JMP NWSHP              \ bubble of universe, and return from the subroutine
                        \ using a tail call

