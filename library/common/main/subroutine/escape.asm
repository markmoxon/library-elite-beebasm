\ ******************************************************************************
\
\       Name: ESCAPE
\       Type: Subroutine
\   Category: Flight
\    Summary: Launch our escape pod
\
\ ------------------------------------------------------------------------------
\
\ This routine displays our doomed Cobra Mk III disappearing off into the ether
\ before arranging our replacement ship. Called when we press ESCAPE during
\ flight and have an escape pod fitted.
\
\ ******************************************************************************

.ESCAPE

IF _CASSETTE_VERSION \ Standard: Group A: In the cassette version, launching an escape pod in witchspace is immediately fatal, while in the disc version it launches properly. In the advanced versions, meanwhile, the launch key is disabled as soon as you enter witchspace

 LDA MJ                 \ Store the value of MJ on the stack (the "are we in
 PHA                    \ witchspace?" flag)

ENDIF

 JSR RES2               \ Reset a number of flight variables and workspaces

IF _CASSETTE_VERSION OR _DISC_FLIGHT OR _6502SP_VERSION OR _MASTER_VERSION

 LDX #CYL               \ Set the current ship type to a Cobra Mk III, so we
 STX TYPE               \ can show our ship disappear into the distance when we
                        \ eject in our pod

 JSR FRS1               \ Call FRS1 to launch the Cobra Mk III straight ahead,
                        \ like a missile launch, but with our ship instead

ENDIF

IF _6502SP_VERSION OR _DISC_FLIGHT OR _MASTER_VERSION \ Enhanced: When trying to spawn a Cobra Mk III to display when we use an escape pod, the enhanced versions will first try to spawn a normal Cobra, and if that fails, they will try again with a pirate Cobra

 BCS ES1                \ If the Cobra was successfully added to the local
                        \ bubble, jump to ES1 to skip the following instructions

 LDX #CYL2              \ The Cobra wasn't added to the local bubble for some
 JSR FRS1               \ reason, so try launching a pirate Cobra Mk III instead

.ES1

ENDIF

IF _CASSETTE_VERSION OR _DISC_FLIGHT OR _6502SP_VERSION OR _MASTER_VERSION

 LDA #8                 \ Set the Cobra's byte #27 (speed) to 8
 STA INWK+27

 LDA #194               \ Set the Cobra's byte #30 (pitch counter) to 194, so it
 STA INWK+30            \ pitches as we pull away

 LSR A                  \ Set the Cobra's byte #32 (AI flag) to %01100001, so it
 STA INWK+32            \ has no AI, and we can use this value as a counter to
                        \ do the following loop 97 times

ENDIF

.ESL1

IF _CASSETTE_VERSION OR _DISC_FLIGHT OR _6502SP_VERSION OR _MASTER_VERSION

 JSR MVEIT              \ Call MVEIT to move the Cobra in space

ENDIF

IF _MASTER_VERSION \ Master: In the Master version, if you launch your escape pod while looking out of the side or rear views, you won't see your Cobra as you leave it behind, while in the other versions you do

 LDA QQ11               \ If either of QQ11 or VIEW is non-zero (i.e. this is
 ORA VIEW               \ not the front space view), skip the following
 BNE P%+5               \ instruction

ENDIF

IF _CASSETTE_VERSION OR _DISC_FLIGHT OR _6502SP_VERSION OR _MASTER_VERSION

 JSR LL9                \ Call LL9 to draw the Cobra on-screen

 DEC INWK+32            \ Decrement the counter in byte #32

 BNE ESL1               \ Loop back to keep moving the Cobra until the AI flag
                        \ is 0, which gives it time to drift away from our pod

 JSR SCAN               \ Call SCAN to remove the Cobra from the scanner (by
                        \ redrawing it)

ENDIF

IF _CASSETTE_VERSION \ Standard: See group A

 JSR RESET              \ Call RESET to reset our ship and various controls

 PLA                    \ Restore the witchspace flag from before the escape pod
 BEQ P%+5               \ launch, and if we were in normal space, skip the
                        \ following instruction

 JMP DEATH              \ Launching an escape pod in witchspace is fatal, so
                        \ jump to DEATH to begin the funeral and return from the
                        \ subroutine using a tail call

ELIF _ELECTRON_VERSION

 JSR RESET              \ Call RESET to reset our ship and various controls

 LDA #0                 \ Set A = 0 so we can use it to zero the contents of
                        \ the cargo hold

ELIF _6502SP_VERSION OR _DISC_FLIGHT OR _MASTER_VERSION

 LDA #0                 \ Set A = 0 so we can use it to zero the contents of
                        \ the cargo hold

ENDIF

 LDX #16                \ We lose all our cargo when using our escape pod, so
                        \ up a counter in X so we can zero the 17 cargo slots
                        \ in QQ20

.ESL2

IF _CASSETTE_VERSION OR _ELECTRON_VERSION \ Comment

 STA QQ20,X             \ Set the X-th byte of QQ20 to zero (as we know A = 0
                        \ from the BEQ above), so we no longer have any of item
                        \ type X in the cargo hold

ELIF _6502SP_VERSION OR _DISC_FLIGHT OR _MASTER_VERSION

 STA QQ20,X             \ Set the X-th byte of QQ20 to zero, so we no longer
                        \ have any of item type X in the cargo hold

ENDIF

 DEX                    \ Decrement the counter

 BPL ESL2               \ Loop back to ESL2 until we have emptied the entire
                        \ cargo hold

 STA FIST               \ Launching an escape pod also clears our criminal
                        \ record, so set our legal status in FIST to 0 ("clean")

 STA ESCP               \ The escape pod is a one-use item, so set ESCP to 0 so
                        \ we no longer have one fitted

 LDA #70                \ Our replacement ship is delivered with a full tank of
 STA QQ14               \ fuel, so set the current fuel level in QQ14 to 70, or
                        \ 7.0 light years

IF _CASSETTE_VERSION OR _ELECTRON_VERSION \ Platform

 JMP BAY                \ Go to the docking bay (i.e. show the Status Mode
                        \ screen) and return from the subroutine with a tail
                        \ call

ELIF _6502SP_VERSION OR _DISC_FLIGHT OR _MASTER_VERSION

 JMP GOIN               \ Go to the docking bay (i.e. show the ship hanger
                        \ screen) and return from the subroutine with a tail
                        \ call

ENDIF

