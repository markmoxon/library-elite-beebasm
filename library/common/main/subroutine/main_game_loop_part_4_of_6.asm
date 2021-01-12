\ ******************************************************************************
\
\       Name: Main game loop (Part 4 of 6)
\       Type: Subroutine
\   Category: Main loop
\    Summary: Potentially spawn lone bounty hunter, Thargoid, or up to 4 pirates
\
\ ------------------------------------------------------------------------------
\
\ This section covers the following:
\
IF _CASSETTE_VERSION OR _DISC_VERSION
\   * Potentially spawn (35% chance) either a lone bounty hunter (a Mamba,
\     Python or Cobra Mk III), a Thargoid, or a group of up to 4 pirates
\     (Sidewinders and/or Mambas)
ELIF _6502SP_VERSION
\   * Potentially spawn (35% chance) either a lone bounty hunter (a Cobra Mk
\     III, Asp Mk II, Python or Fer-de-lance), a Thargoid, or a group of up to 4
\     pirates (a mix of Sidewinders, Mambas, Kraits, Adders, Geckos, Cobras Mk I
\     and III, and Worms)
\
\   * Also potentially spawn a Constrictor if this is the mission 1 endgame, or
\     Thargoids if mission 2 is in progress
ENDIF
\
\ ******************************************************************************

IF _CASSETTE_VERSION OR _DISC_VERSION

 DEC EV                 \ Decrement EV, the extra vessels spawning delay, and
 BPL MLOOP              \ jump to MLOOP if it is still positive, so we only
                        \ do the following when the EV counter runs down

ELIF _6502SP_VERSION

 DEC EV                 \ Decrement EV, the extra vessels spawning delay, and
 BPL MLOOPS             \ jump to MLOOPS if it is still positive, so we only
                        \ do the following when the EV counter runs down

ENDIF

 INC EV                 \ EV is negative, so bump it up again, setting it back
                        \ to 0

IF _6502SP_VERSION

 LDA TP                 \ Fetch bits 2 and 3 of TP, which contain the status of
 AND #%00001100         \ mission 2

 CMP #%00001000         \ If bit 3 is set and bit 2 is clear, keep going to
 BNE nopl               \ spawn a Thargoid as we are transporting the plans in
                        \ mission 2 and the Thargoids are trying to stop us,
                        \ otherwise jump to nopl to skip spawning a Thargoid

 JSR DORND              \ Set A and X to random numbers

 CMP #200               \ If the random number in A < 200 (78% chance), jump to
 BCC nopl               \ nopl to skip spawning a Thargoid

.fothg2

 JSR GTHG               \ Call GTHG to spawn a Thargoid ship and a Thargon
                        \ companion

.nopl

ENDIF

 JSR DORND              \ Set A and X to random numbers

 LDY gov                \ If the government of this system is 0 (anarchy), jump
 BEQ LABEL_2            \ straight to LABEL_2 to start spawning pirates or a
                        \ lone bounty hunter

IF _CASSETTE_VERSION OR _DISC_VERSION

 CMP #90                \ If the random number in A >= 90 (65% chance), jump to
 BCS MLOOP              \ MLOOP to stop spawning (so there's a 35% chance of
                        \ spawning pirates or a lone bounty hunter)

 AND #7                 \ Reduce the random number in A to the range 0-7, and
 CMP gov                \ if A is less than government of this system, jump
 BCC MLOOP              \ to MLOOP to stop spawning (so safer governments with
                        \ larger gov numbers have a greater chance of jumping
                        \ out, which is another way of saying that more
                        \ dangerous systems spawn pirates and bounty hunters
                        \ more often)

ELIF _6502SP_VERSION

 CMP #90                \ If the random number in A >= 90 (65% chance), jump to
 BCS MLOOPS             \ MLOOPS to stop spawning (so there's a 35% chance of
                        \ spawning pirates or a lone bounty hunter)

 AND #7                 \ Reduce the random number in A to the range 0-7, and
 CMP gov                \ if A is less than government of this system, jump
 BCC MLOOPS             \ to MLOOPS to stop spawning (so safer governments with
                        \ larger gov numbers have a greater chance of jumping
                        \ out, which is another way of saying that more
                        \ dangerous systems spawn pirates and bounty hunters
                        \ more often)

ENDIF

.LABEL_2

IF _6502SP_VERSION

                        \ In the 6502 Second Processor version, the LABEL_2
                        \ label is actually ` (a backtick), but that doesn't
                        \ compile in BeebAsm and it's pretty cryptic, so
                        \ instead this version sticks with the label LABEL_2
                        \ from the cassette version

ENDIF

                        \ Now to spawn a lone bounty hunter, a Thargoid or a
                        \ group of pirates

 JSR Ze                 \ Call Ze to initialise INWK to a potentially hostile
                        \ ship, and set A and X to random values

IF _CASSETTE_VERSION OR _DISC_VERSION

 CMP #200               \ If the random number in A >= 200 (13% chance), jump
 BCS mt1                \ to mt1 to spawn pirates, otherwise keep going to
                        \ spawn a lone bounty hunter or a Thargoid

ELIF _6502SP_VERSION

 CMP #100               \ If the random number in A >= 100 (61% chance), jump
 BCS mt1                \ to mt1 to spawn pirates, otherwise keep going to
                        \ spawn a lone bounty hunter or a Thargoid

ENDIF

 INC EV                 \ Increase the extra vessels spawning counter, to
                        \ prevent the next attempt to spawn extra vessels

IF _CASSETTE_VERSION OR _DISC_VERSION

 AND #3                 \ Set A = Y = random number in the range 3-6, which
 ADC #3                 \ we will use to determine the type of ship
 TAY

                        \ We now build the AI flag for this ship in A

 TXA                    \ First, set the C flag if X >= 200 (22% chance)
 CMP #200

ELIF _6502SP_VERSION

 AND #3                 \ Set A = random number in the range 0-3, which we
                        \ will now use to determine the type of ship

 ADC #CYL2              \ Add A to #CYL2 (we know the C flag is clear as we
                        \ passed through the BCS above), so A is now one of the
                        \ lone bounty hunter ships, i.e. Cobra Mk III (pirate),
                        \ Asp Mk II, Python (pirate) or Fer-de-lance

 TAY                    \ Copy the new ship type to Y

 JSR THERE              \ Call THERE to see if we are in the Constrictor's
                        \ system in mission 1

 BCC NOCON              \ If the C flag is clear then we are not in the
                        \ Constrictor's system, so skip to NOCON

 LDA #%11111001         \ Set the AI flag of this ship so that it has E.C.M.,
 STA INWK+32            \ has a very high aggression level of 28 out of 31, is
                        \ hostile, and has AI enabled - nasty stuff!

 LDA TP                 \ Fetch bits 0 and 1 of TP, which contain the status of
 AND #%00000011         \ mission 1

 LSR A                  \ Shift bit 0 into the C flag

 BCC NOCON              \ If bit 0 is clear, skip to NOCON as mission 1 is not
                        \ in progress

 ORA MANY+CON           \ Bit 0 of A now contains bit 1 of TP, so this will be
                        \ set if we have already completed mission 1, so this OR
                        \ will be non-zero if we have either completed mission
                        \ 1, or there is already a Constrictor in our local
                        \ bubble of universe (in which case MANY+CON will be
                        \ non-zero)

 BEQ YESCON             \ If A = 0 then mission 1 is in progress, we haven't
                        \ completed it yet, and there is no Constrictor in the
                        \ vicinity, so jump to YESCON to spawn the Constrictor

.NOCON

 LDA #%00000100         \ Set bit 2 of the NEWB flags and clear all other bits,
 STA NEWB               \ so the ship we are about to spawn is hostile

                        \ We now build the AI flag for this ship in A

 JSR DORND              \ Set A and X to random numbers

 CMP #200               \ First, set the C flag if X >= 200 (22% chance)

ENDIF

 ROL A                  \ Set bit 0 of A to the C flag (i.e. there's a 22%
                        \ chance of this ship having E.C.M.)

 ORA #%11000000         \ Set bits 6 and 7 of A, so the ship is hostile (bit 6)
                        \ and has AI (bit 7)

IF _CASSETTE_VERSION OR _DISC_VERSION

 CPY #6                 \ If Y = 6 (i.e. a Thargoid), jump down to the tha
 BEQ tha                \ routine to decide whether or not to spawn it (where
                        \ there's a 22% chance of this happening)

 STA INWK+32            \ Store A in the AI flag of this ship

 TYA                    \ Add a new ship of type Y to the local bubble, so
 JSR NWSHP              \ that's a Mamba, Cobra Mk III or Python

ELIF _6502SP_VERSION

 STA INWK+32            \ Store A in the AI flag of this ship

 TYA

 EQUB &2C               \ Skip the next instruction by turning it into
                        \ &2C &A9 &1F, or BIT &1FA9, which does nothing apart
                        \ from affect the flags

.YESCON

 LDA #CON               \ If we jump straight here, we are in the mission 1
                        \ endgame and it's time to spawn the Constrictor, so
                        \ set A to the Constrictor's type

.focoug

 JSR NWSHP              \ Spawn the new ship, whether it's a pirate, Thargoid,
                        \ Cougar or Constrictor

ENDIF

.mj1

 JMP MLOOP              \ Jump down to MLOOP, as we are done spawning ships

IF _6502SP_VERSION

.fothg

 LDA K%+6               \ Fetch the z_lo coordinate of the first ship in the K%
 AND #%00111110         \ block (i.e. the planet) and extract bits 1-5

 BNE fothg2             \ If any of bits 1-5 are set (96.8% chance), jump up to
                        \ fothg2 to spawn a Thargoid

                        \ If we get here then we're going to spawn a Cougar, a
                        \ very rare event indeed. How rare? Well, all the
                        \ following have to happen in sequence:
                        \
                        \  * Main loop iteration = 0 (1 in 256 iterations)
                        \  * Skip asteroid spawning (87% chance)
                        \  * Skip cop spawning (0.4% chance)
                        \  * Skip Thargoid spawning (3.2% chance)
                        \
                        \ so the chances of spawning a Cougar on any single main
                        \ loop iteration are slim, to say the least

 LDA #18                \ Give the ship we're about to spawn a speed of 27
 STA INWK+27

 LDA #%01111001         \ Give it an E.C.M., and make it hostile and pretty
 STA INWK+32            \ aggressive (though don't give it AI)

 LDA #COU               \ Set the ship type to a Cougar and jump up to focoug
 BNE focoug             \ to spawn it

ENDIF

.mt1

 AND #3                 \ It's time to spawn a group of pirates, so set A to a
                        \ random number in the range 0-3, which will be the
                        \ loop counter for spawning pirates below (so we will
                        \ spawn 1-4 pirates)

 STA EV                 \ Delay further spawnings by this number

 STA XX13               \ Store the number in XX13, the pirate counter

.mt3

 JSR DORND              \ Set A and X to random numbers

IF _CASSETTE_VERSION OR _DISC_VERSION

 AND #3                 \ Set A to a random number in the range 0-3

 ORA #1                 \ Set A to %01 or %11 (Sidewinder or Mamba)

ELIF _6502SP_VERSION

 STA T                  \ Set T to a random number

 JSR DORND              \ Set A and X to random numbers

 AND T                  \ Set A to the AND of two random numbers, so each bit
                        \ has 25% chance of being set which makes the chances
                        \ of a smaller number higher

 AND #7                 \ Reduce A to a random number in the range 0-7, though
                        \ with a bigger chance of a smaller number in this range

 ADC #PACK              \ #PACK is set to #SH3, the ship type for a Sidewinder,
                        \ so this sets our new ship type to one of the pack
                        \ hunters, namely a Sidewinder, Mamba, Krait, Adder,
                        \ Gecko, Cobra Mk I, Worm or Cobra Mk III (pirate)

ENDIF

 JSR NWSHP              \ Add a new ship of type A to the local bubble

 DEC XX13               \ Decrement the pirate counter

 BPL mt3                \ If we need more pirates, loop back up to mt3,
                        \ otherwise we are done spawning, so fall through into
                        \ the end of the main loop at MLOOP

