\ ******************************************************************************
\
\       Name: MJP
\       Type: Subroutine
\   Category: Flight
\    Summary: Process a mis-jump into witchspace
\
\ ------------------------------------------------------------------------------
\
\ Process a mis-jump into witchspace (which happens very rarely). Witchspace has
\ a strange, almost dust-free aspect to it, and it is populated by hostile
\ Thargoids. Using our escape pod will be fatal, and our position on the
\ galactic chart is in-between systems. It is a scary place...
\
\ There is a 1% chance that this routine is called from TT18 instead of doing
\ a normal hyperspace, or we can manually trigger a mis-jump by holding down
\ CTRL after first enabling the "author display" configuration option ("X") when
\ paused.
\
\ Other entry points:
\
\   ptg                 Called when the user manually forces a mis-jump
\
IF _6502SP_VERSION OR _MASTER_VERSION \ Comment
\   RTS111              Contains an RTS
\
ENDIF
\ ******************************************************************************

.ptg

 LSR COK                \ Set bit 0 of the competition flags in COK, so that the
 SEC                    \ copmpetition code will include the fact that we have
 ROL COK                \ manually forced a mis-jump into witchspace

.MJP

IF _DISC_FLIGHT \ Platform

 LDA #3                 \ Call SHIPinA to load ship blueprints file D, which is
 JSR SHIPinA            \ one of the two files that contain Thargoids

ENDIF

IF _CASSETTE_VERSION \ Minor

\LDA #1                 \ This instruction is commented out in the original
                        \ source - it is not required as a call to TT66-2 sets
                        \ A to 1 for us. This is presumably an example of the
                        \ authors saving a couple of bytes by calling TT66-2
                        \ instead of TT66, while leaving the original LDA
                        \ instruction in place

 JSR TT66-2             \ Clear the top part of the screen, draw a white border,
                        \ and set the current view type in QQ11 to 1

ELIF _DISC_FLIGHT OR _6502SP_VERSION OR _MASTER_VERSION

 LDA #3                 \ Clear the top part of the screen, draw a white border,
 JSR TT66               \ and set the current view type in QQ11 to 3

ENDIF

 JSR LL164              \ Call LL164 to show the hyperspace tunnel and make the
                        \ hyperspace sound for a second time (as we already
                        \ called LL164 in TT18)

 JSR RES2               \ Reset a number of flight variables and workspaces, as
                        \ well as setting Y to &FF

 STY MJ                 \ Set the mis-jump flag in MJ to &FF, to indicate that
                        \ we are now in witchspace

.MJP1

 JSR GTHG               \ Call GTHG to spawn a Thargoid ship

IF _CASSETTE_VERSION OR _DISC_VERSION OR _6502SP_VERSION

 LDA #3                 \ Fetch the number of Thargoid ships from MANY+THG, and
 CMP MANY+THG           \ if it is less than 3, loop back to MJP1 to spawn
 BCS MJP1               \ another one, until we have three Thargoids

ELIF _MASTER_VERSION

 LDA #2                 \ Fetch the number of Thargoid ships from MANY+THG, and
 CMP MANY+THG           \ if it is less than 2, loop back to MJP1 to spawn
 BCS MJP1               \ another one, until we have three Thargoids ???

ENDIF

 STA NOSTM              \ Set NOSTM (the maximum number of stardust particles)
                        \ to 3, so there are fewer bits of stardust in
                        \ witchspace (normal space has a maximum of 18)

 LDX #0                 \ Initialise the front space view
 JSR LOOK1

 LDA QQ1                \ Fetch the current system's galactic y-coordinate in
 EOR #%00011111         \ QQ1 and flip bits 0-5, so we end up somewhere in the
 STA QQ1                \ vicinity of our original destination, but above or
                        \ below it in the galactic chart

IF _MASTER_VERSION \ Platform

 RTS                    \ Return from the subroutine

ENDIF

IF _6502SP_VERSION OR _MASTER_VERSION \ Label

.RTS111

ENDIF

 RTS                    \ Return from the subroutine

