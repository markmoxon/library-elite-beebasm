\ ******************************************************************************
\
\ NES ELITE GAME SOURCE (BANK 0)
\
\ NES Elite was written by Ian Bell and David Braben and is copyright D. Braben
\ and I. Bell 1991/1992
\
\ The code on this site has been reconstructed from a disassembly of the version
\ released on Ian Bell's personal website at http://www.elitehomepage.org/
\
\ The commentary is copyright Mark Moxon, and any misunderstandings or mistakes
\ in the documentation are entirely my fault
\
\ The terminology and notations used in this commentary are explained at
\ https://www.bbcelite.com/about_site/terminology_used_in_this_commentary.html
\
\ The deep dive articles referred to in this commentary can be found at
\ https://www.bbcelite.com/deep_dives
\
\ ------------------------------------------------------------------------------
\
\ This source file produces the following binary file:
\
\   * bank0.bin
\
\ ******************************************************************************

 INCLUDE "versions/nes/1-source-files/main-sources/elite-build-options.asm"

 _CASSETTE_VERSION      = (_VERSION = 1)
 _DISC_VERSION          = (_VERSION = 2)
 _6502SP_VERSION        = (_VERSION = 3)
 _MASTER_VERSION        = (_VERSION = 4)
 _ELECTRON_VERSION      = (_VERSION = 5)
 _ELITE_A_VERSION       = (_VERSION = 6)
 _NES_VERSION           = (_VERSION = 7)
 _C64_VERSION           = (_VERSION = 8)
 _APPLE_VERSION         = (_VERSION = 9)
 _DISC_DOCKED           = FALSE
 _DISC_FLIGHT           = FALSE
 _ELITE_A_DOCKED        = FALSE
 _ELITE_A_FLIGHT        = FALSE
 _ELITE_A_SHIPS_R       = FALSE
 _ELITE_A_SHIPS_S       = FALSE
 _ELITE_A_SHIPS_T       = FALSE
 _ELITE_A_SHIPS_U       = FALSE
 _ELITE_A_SHIPS_V       = FALSE
 _ELITE_A_SHIPS_W       = FALSE
 _ELITE_A_ENCYCLOPEDIA  = FALSE
 _ELITE_A_6502SP_IO     = FALSE
 _ELITE_A_6502SP_PARA   = FALSE

 _BANK = 0

 INCLUDE "versions/nes/1-source-files/main-sources/elite-source-common.asm"

 INCLUDE "versions/nes/1-source-files/main-sources/elite-source-bank-7.asm"

\ ******************************************************************************
\
\ ELITE BANK 0
\
\ Produces the binary file bank0.bin.
\
\ ******************************************************************************

 CODE% = &8000
 LOAD% = &8000

 ORG CODE%

INCLUDE "library/nes/main/subroutine/resetmmc1.asm"
INCLUDE "library/nes/main/subroutine/interrupts.asm"
INCLUDE "library/nes/main/variable/version_number.asm"

\ ******************************************************************************
\
\       Name: ResetShipStatus
\       Type: Subroutine
\   Category: Flight
\    Summary: Reset the ship's speed, hyperspace counter, laser temperature,
\             shields and energy banks
\
\ ******************************************************************************

.ResetShipStatus

 LDA #0                 \ Reduce the speed to 0
 STA DELTA

 STA QQ22+1             \ Reset the on-screen hyperspace counter

 LDA #0                 \ Cool down the lasers completely
 STA GNTMP

 LDA #&FF               \ Recharge the forward and aft shields
 STA FSH
 STA ASH

 STA ENERGY             \ Recharge the energy banks

 RTS                    \ Return from the subroutine

INCLUDE "library/enhanced/main/subroutine/doentry.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_4_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_5_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_6_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_7_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_8_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_9_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_10_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_11_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_12_of_16.asm"

\ ******************************************************************************
\
\       Name: Main flight loop (Part 3a of 16)
\       Type: Subroutine
\   Category: Main loop
\    Summary: Display in-flight messages, call parts 4 to 12 of the main flight
\             loop for each slot, and fall through into parts 13 to 16
\
\ ******************************************************************************

.main1

 DEC DLY                \ Decrement the delay counter in DLY, which is used to
                        \ control how long flight messages remain on-screen

 BMI main4              \ If DLY is now negative, jump to main4 to set DLY to
                        \ zero and skip the following, as there is no flight
                        \ message to display

 BEQ main2              \ DLY is now zero so it must have been non-zero before
                        \ we decremented it, so jump to main2 to remove the
                        \ flight message from the screen, as its timer has run
                        \ down

                        \ DLY is non-zero, so we need to redraw any flight
                        \ messages we may have, so they remain on-screen while
                        \ DLY is still ticking down

 JSR PrintFlightMessage \ Print the current in-flight message, if there is one

 JMP main3              \ Jump to main3 to display the message we just printed
                        \ and continue with the rest of the main loop

.main2

 JSR CLYNS              \ Clear the bottom three text rows of the upper screen,
                        \ and move the text cursor to column 1 on row 21, i.e.
                        \ the start of the top row of the three bottom rows

.main3

 JSR DrawMessageInNMI   \ Configure the NMI to display the in-flight message
                        \ that we just printed

 JMP MA16               \ Jump to MA16 to skip the following and continue with
                        \ the rest of the main loop

.FlightLoop4To16

 LDA QQ11               \ If this is not the space view (i.e. QQ11 is non-zero),
 BNE main1              \ jump to main1 to print the flight message for
                        \ non-space views, rejoining the main subroutine at MA16
                        \ below

 DEC DLY                \ Decrement the delay counter in DLY, which is used to
                        \ control how long flight messages remain on-screen

 BMI main4              \ If DLY is now 0 or negative, jump to main4 to set DLY
 BEQ main4              \ to zero and skip the following, as there is no flight
                        \ message to display

                        \ DLY is non-zero, so we need to redraw any flight
                        \ messages we may have, so they remain on-screen while
                        \ DLY is still ticking down

 JSR PrintFlightMessage \ Print the current flight message, if there is one

 JMP MA16               \ Jump to MA16 to skip the following and continue with
                        \ the rest of the main loop

.main4

 LDA #0                 \ Set DLY to 0 so that it doesn't decrement below zero
 STA DLY

.MA16

 LDA ECMP               \ If our E.C.M is not on, skip to MA69, otherwise keep
 BEQ MA69               \ going to drain some energy

 JSR DENGY              \ Call DENGY to deplete our energy banks by 1

 BEQ MA70               \ If we have no energy left, jump to MA70 to turn our
                        \ E.C.M. off

.MA69

 LDA ECMA               \ If an E.C.M is going off (ours or an opponent's) then
 BEQ MA66               \ keep going, otherwise skip to MA66

 LDA #128               \ Set K+2 = 128 to send to the DrawLightning routine as
 STA K+2                \ the x-coordinate of the centre of the lightning, so
                        \ it is centred on-screen

 LDA #127               \ Set K = 127 to send to the DrawLightning routine as
 STA K                  \ half the height of the lightning, so it fills the
                        \ whole screen width

 LDA halfScreenHeight   \ Set K+3 to the y-coordinate of the centre of the
 STA K+3                \ screen in halfScreenHeight, to send to the
                        \ DrawLightning routine as the y-coordinate of the
                        \ centre of the lightning, so it is centred on-screen

 STA K+1                \ Set K+1 to the y-coordinate of the centre of the
                        \ screen in halfScreenHeight, to send to the
                        \ DrawLightning routine as half the height of the
                        \ lightning, so it fills the whole screen height

 JSR DrawLightning_b6   \ Draw the lightning effect of the E.C.M. going off

 DEC ECMA               \ Decrement the E.C.M. countdown timer, and if it has
 BNE MA66               \ reached zero, keep going, otherwise skip to MA66

.MA70

 JSR ECMOF              \ If we get here then either we have either run out of
                        \ energy, or the E.C.M. timer has run down, so switch
                        \ off the E.C.M.

.MA66

 LDX #0                 \ We are about to work our way through all the ships in
                        \ the bubble, calling MAL1 (parts 4 to 12 of the main
                        \ flight loop) for each of them, so set X as a ship slot
                        \ counter

 LDA FRIN               \ If slot 0 is empty, jump to main5 to move on to the
 BEQ main5              \ next slot

 JSR MAL1               \ Call parts 4 to 12 of the main flight loop to update
                        \ the ship in slot 0

.main5

 LDX #2                 \ We deal with the sun/space station in slot 1 below, so
                        \ we now skip to slot 2 by setting X accordingly

.main6

 LDA FRIN,X             \ If slot X is empty then we have reached the last slot,
 BEQ main7              \ so jump to main7 to stop updating the slots

 JSR MAL1               \ Call parts 4 to 12 of the main flight loop to update
                        \ the ship in slot X

 JMP main6              \ Loop back until we have updated all the ship slots

.main7

 LDX #1                 \ We now process the sun/space station in slot 1, so we
                        \ set X as the slot number

 LDA FRIN+1             \ If slot 1 is empty then there is no sun or space
 BEQ MA18               \ station (which can happen in witchspace), so jump to
                        \ part 13 of the main loop as we are done updating the
                        \ ship slots

 BPL main8              \ If bit 7 of the ship type is clear, then this is the
                        \ space station rather than the sun, so jump to main8
                        \ to skip the following

 LDY #0                 \ Set the "space station present" flag to 0, as we are
 STY SSPR               \ no longer in the space station's safe zone

.main8

 JSR MAL1               \ Call parts 4 to 12 of the main flight loop to update
                        \ the sun or space station in slot 2

                        \ Fall through into part 13 to continue working through
                        \ the main flight loop

INCLUDE "library/common/main/subroutine/main_flight_loop_part_13_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_14_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_15_of_16.asm"

\ ******************************************************************************
\
\       Name: Main flight loop (Part 16 of 16)
\       Type: Subroutine
\   Category: Main loop
\    Summary: Call stardust routine
\  Deep dive: Program flow of the main game loop
\
\ ------------------------------------------------------------------------------
\
\ The main flight loop covers most of the flight-specific aspects of Elite. This
\ section covers the following:
\
\   * Jump to the stardust routine if we are in a space view
\
\   * Return from the main flight loop
\
\ ******************************************************************************

.MA23

 LDA QQ11               \ If this is not the space view (i.e. QQ11 is non-zero)
 BNE MA232              \ then jump to MA232 to return from the main flight loop
                        \ (as MA232 is an RTS)

 JMP STARS_b1           \ This is a space view, so jump to the STARS routine to
                        \ process the stardust, and return from the main flight
                        \ loop using a tail call

\ ******************************************************************************
\
\       Name: ChargeShields
\       Type: Subroutine
\   Category: Flight
\    Summary: Charge the shields and energy banks
\
\ ******************************************************************************

.ChargeShields

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX ENERGY             \ Fetch our ship's energy levels and skip to b if bit 7
 BPL b                  \ is not set, i.e. only charge the shields from the
                        \ energy banks if they are at more than 50% charge

 LDX ASH                \ Call SHD to recharge our aft shield and update the
 JSR SHD                \ shield status in ASH
 STX ASH

 LDX FSH                \ Call SHD to recharge our forward shield and update
 JSR SHD                \ the shield status in FSH
 STX FSH

.b

 SEC                    \ Set A = ENERGY + ENGY + 1, so our ship's energy
 LDA ENGY               \ level goes up by 2 if we have an energy unit fitted,
 ADC ENERGY             \ otherwise it goes up by 1

 BCS paen1              \ If the value of A did not overflow (the maximum
 STA ENERGY             \ energy level is &FF), then store A in ENERGY

.paen1

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: CheckAltitude
\       Type: Subroutine
\   Category: Flight
\    Summary: Perform an altitude check with the planet, ending the game if we
\             hit the ground
\
\ ******************************************************************************

.CheckAltitude

 LDY #&FF               \ Set our altitude in ALTIT to &FF, the maximum
 STY ALTIT

 INY                    \ Set Y = 0

 JSR m                  \ Call m to calculate the maximum distance to the
                        \ planet in any of the three axes, returned in A

 BNE MA232              \ If A > 0 then we are a fair distance away from the
                        \ planet in at least one axis, so jump to MA232 to skip
                        \ the rest of the altitude check

 JSR MAS3               \ Set A = x_hi^2 + y_hi^2 + z_hi^2, so using Pythagoras
                        \ we now know that A now contains the square of the
                        \ distance between our ship (at the origin) and the
                        \ centre of the planet at (x_hi, y_hi, z_hi)

 BCS MA232              \ If the C flag was set by MAS3, then the result
                        \ overflowed (was greater than &FF) and we are still a
                        \ fair distance from the planet, so jump to MA232 as we
                        \ haven't crashed into the planet

 SBC #36                \ Subtract 36 from x_hi^2 + y_hi^2 + z_hi^2. The radius
                        \ of the planet is defined as 6 units and 6^2 = 36, so
                        \ A now contains the high byte of our altitude above
                        \ the planet surface, squared

 BCC MA282              \ If A < 0 then jump to MA282 as we have crashed into
                        \ the planet

 STA R                  \ Set (R Q) = (A Q)

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 JSR LL5                \ We are getting close to the planet, so we need to
                        \ work out how close. We know from the above that A
                        \ contains our altitude squared, so we store A in R
                        \ and call LL5 to calculate:
                        \
                        \   Q = SQRT(R Q) = SQRT(A Q)
                        \
                        \ Interestingly, Q doesn't appear to be set to 0 for
                        \ this calculation, so presumably this doesn't make a
                        \ difference

 LDA Q                  \ Store the result in ALTIT, our altitude
 STA ALTIT

 BNE MA232              \ If our altitude is non-zero then we haven't crashed,
                        \ so jump to MA232 to skip to the next section

.MA282

 JMP DEATH              \ If we get here then we just crashed into the planet
                        \ or got too close to the sun, so jump to DEATH to start
                        \ the funeral preparations and return from the main
                        \ flight loop using a tail call

.MA232

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/main_flight_loop_part_1_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_2_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_3_of_16.asm"
INCLUDE "library/enhanced/main/subroutine/spin.asm"

\ ******************************************************************************
\
\       Name: HideHiddenColour
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Set the hidden colour to black, so that pixels in this colour in
\             palette 0 are invisible
\
\ ------------------------------------------------------------------------------
\
\ Other entry points:
\
\   oh                  Contains an RTS
\
\ ******************************************************************************

.HideHiddenColour

 LDA #&0F               \ Set hiddenColour to &0F, which is black, so this hides
 STA hiddenColour       \ any pixels that use the hidden colour in palette 0

.oh

 RTS                    \ Return from the subroutine

INCLUDE "library/advanced/main/variable/scacol.asm"

\ ******************************************************************************
\
\       Name: SetAXTo15 (Unused)
\       Type: Subroutine
\   Category: Utility routines
\    Summary: An unused routine that sets A and X to 15
\
\ ******************************************************************************

.SetAXTo15

 LDA #15                \ Set A = 15

 TAX                    \ Set X = 15

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: PrintCombatRank
\       Type: Subroutine
\   Category: Status
\    Summary: Print the current combat rank
\
\ ------------------------------------------------------------------------------
\
\ This routine is based on part of the STATUS routine from the original source,
\ so I have kept the original st3 and st4 labels.
\
\ ******************************************************************************

.PrintCombatRank

 LDA #16                \ Print recursive token 130 ("RATING:") followed by
 JSR TT68               \ a colon

 LDA languageNumber     \ If bit 0 of languageNumber is clear then the chosen
 AND #%00000001         \ language is not English, so skip the following
 BEQ P%+5               \ instruction (as the screen has a different layout in
                        \ the other languages)

 JSR TT162              \ Print a space

 LDA TALLY+1            \ Fetch the high byte of the kill tally, and if it is
 BNE st4                \ not zero, then we have more than 256 kills, so jump
                        \ to st4 to work out whether we are Competent,
                        \ Dangerous, Deadly or Elite

                        \ Otherwise we have fewer than 256 kills, so we are one
                        \ of Harmless, Mostly Harmless, Poor, Average or Above
                        \ Average

 TAX                    \ Set X to 0 (as A is 0)

 LDX TALLY              \ Set X to the low byte of the kill tally

 CPX #0                 \ Increment A if X >= 0
 ADC #0

 CPX #2                 \ Increment A if X >= 2
 ADC #0

 CPX #8                 \ Increment A if X >= 8
 ADC #0

 CPX #24                \ Increment A if X >= 24
 ADC #0

 CPX #44                \ Increment A if X >= 44
 ADC #0

 CPX #130               \ Increment A if X >= 130
 ADC #0

 TAX                    \ Set X to A, which will be as follows:
                        \
                        \   * 1 (Harmless)        when TALLY = 0 or 1
                        \
                        \   * 2 (Mostly Harmless) when TALLY = 2 to 7
                        \
                        \   * 3 (Poor)            when TALLY = 8 to 23
                        \
                        \   * 4 (Average)         when TALLY = 24 to 43
                        \
                        \   * 5 (Above Average)   when TALLY = 44 to 129
                        \
                        \   * 6 (Competent)       when TALLY = 130 to 255
                        \
                        \ Note that the Competent range also covers kill counts
                        \ from 256 to 511, but those are covered by st4 below

.st3

 TXA                    \ Store the combat rank in X on the stack
 PHA

 LDA languageNumber     \ If bits 0 and 2 of languageNumber are clear then the
 AND #%00000101         \ chosen language is not English or French, so skip
 BEQ P%+8               \ the following two instructions (as the screen has a
                        \ different layout in German)

 JSR TT162              \ Print two spaces
 JSR TT162

 PLA                    \ Set A to the combat rank we stored on the stack above

 CLC                    \ Print recursive token 135 + A, which will be in the
 ADC #21                \ range 136 ("HARMLESS") to 144 ("---- E L I T E ----")
 JMP plf                \ followed by a newline, returning from the subroutine
                        \ using a tail call

.st4

                        \ We call this from above with the high byte of the
                        \ kill tally in A, which is non-zero, and want to return
                        \ with the following in X, depending on our rating:
                        \
                        \   Competent = 6
                        \   Dangerous = 7
                        \   Deadly    = 8
                        \   Elite     = 9
                        \
                        \ The high bytes of the top tier ratings are as follows,
                        \ so this a relatively simple calculation:
                        \
                        \   Competent       = 1 to 2
                        \   Dangerous       = 2 to 9
                        \   Deadly          = 10 to 24
                        \   Elite           = 25 and up

 LDX #9                 \ Set X to 9 for an Elite rating

 CMP #25                \ If A >= 25, jump to st3 to print out our rating, as we
 BCS st3                \ are Elite

 DEX                    \ Decrement X to 8 for a Deadly rating

 CMP #10                \ If A >= 10, jump to st3 to print out our rating, as we
 BCS st3                \ are Deadly

 DEX                    \ Decrement X to 7 for a Dangerous rating

 CMP #2                 \ If A >= 2, jump to st3 to print out our rating, as we
 BCS st3                \ are Dangerous

 DEX                    \ Decrement X to 6 for a Competent rating

 BNE st3                \ Jump to st3 to print out our rating, as we are
                        \ Competent (this BNE is effectively a JMP as A will
                        \ never be zero)

\ ******************************************************************************
\
\       Name: PrintLegalStatus
\       Type: Subroutine
\   Category: Status
\    Summary: Print the current legal status (clean, offender or fugitive)
\
\ ******************************************************************************

.PrintLegalStatus

 LDA #125               \ Print recursive token 125 ("LEGAL STATUS:) followed
 JSR spc                \ by a space

 LDA #19                \ Set A to token 133 ("CLEAN")

 LDY FIST               \ Fetch our legal status, and if it is 0, we are clean,
 BEQ st5                \ so jump to st5 to print "Clean"

 CPY #40                \ Set the C flag if Y >= 40, so C is set if we have
                        \ a legal status of 40+ (i.e. we are a fugitive)

 ADC #1                 \ Add 1 + C to A, so if C is not set (i.e. we have a
                        \ legal status between 1 and 49) then A is set to token
                        \ 134 ("OFFENDER"), and if C is set (i.e. we have a
                        \ legal status of 50+) then A is set to token 135
                        \ ("FUGITIVE")

.st5

 JMP plf                \ Print the text token in A (which contains our legal
                        \ status) followed by a newline, returning from the
                        \ subroutine using a tail call

INCLUDE "library/common/main/subroutine/status.asm"

\ ******************************************************************************
\
\       Name: UpdateView
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Update the view
\
\ ******************************************************************************

.UpdateView

 LDA firstFreeTile      \ If firstFreeTile = 0, set firstFreeTile = 255
 BNE upvw1              \
 LDA #255               \ This ensures that the call to CopyNameBuffer0To1 below
 STA firstFreeTile      \ tells the NMI handler to send pattern entries up to
                        \ the first free tile, or to send tiles up to the very
                        \ end if we have run out of free tiles (which is when
                        \ firstFreeTile is zero)

.upvw1

 LDA #0                 \ Tell the NMI handler to send nametable entries from
 STA firstNametableTile \ tile 0 onwards

 LDA #108               \ Tell the NMI handler to only clear nametable entries
 STA maxNameTileToClear \ up to tile 108 * 8 = 864 (i.e. up to the end of tile
                        \ row 26)

 STA lastNameTile       \ Tell the PPU to send nametable entries up to tile
 STA lastNameTile+1     \ 108 * 8 = 864 (i.e. to the end of tile row 26) in both
                        \ bitplanes

 LDX #37                \ Set X = 37 to use as the first pattern tile for when
                        \ there is an icon bar

 LDA QQ11               \ If bit 6 of the view type is clear, then there is an
 AND #%01000000         \ icon bar, so jump to upvw2 to skip the following
 BEQ upvw2              \ instruction

 LDX #4                 \ Set X = 4 to use as the first pattern tile for when
                        \ there is no icon bar

.upvw2

 STX firstPatternTile   \ Tell the NMI handler to send pattern entries from
                        \ pattern X in the buffer (i.e. from pattern 4 if there
                        \ is no icon bar, or from pattern 37 if there is an
                        \ icon bar)

 JSR DrawBoxEdges       \ Draw the left and right edges of the box along the
                        \ sides of the screen, drawing into the nametable buffer
                        \ for the drawing bitplane

 JSR CopyNameBuffer0To1 \ Copy the contents of nametable buffer 0 to nametable
                        \ buffer and tell the NMI handler to send pattern
                        \ entries up to the first free tile

 LDA QQ11               \ If the new view in QQ11 is the same as the old view in
 CMP QQ11a              \ QQ11a, then jump to upvw6 to call UpdateScreen before
 BEQ upvw6              \ jumping back to upvw3 (which will either call
                        \ SendViewToPPU to update the view straight away, if
                        \ it's been faded to black, otherwise it will call
                        \ SetupFullViewInNMI to update the view in VBlank, to
                        \ prevent screen corruption)

 JSR SendViewToPPU_b3   \ Otherwise the view is changing, so it has already been
                        \ faded out and we can call SendViewToPPU to update the
                        \ view straight away without caring about screen
                        \ corruption

.upvw3

 LDX #&FF               \ Set X = &FF to use as the value of showIconBarPointer
                        \ below (i.e. show the icon bar pointer)

 LDA QQ11               \ If the view type in QQ11 is &95 (Trumble mission
 CMP #&95               \ briefing), jump to upvw4 to set showIconBarPointer to
 BEQ upvw4              \ 0 (i.e. hide the icon bar pointer)

 CMP #&DF               \ If the view type in QQ11 is &DF (Start screen with
 BEQ upvw4              \ the normal font loaded), jump to upvw4 to set
                        \ showIconBarPointer to 0 (i.e. hide the icon bar
                        \ pointer)

 CMP #&92               \ If the view type in QQ11 is &92 (Mission 1 rotating
 BEQ upvw4              \ ship briefing), jump to upvw4 to to set
                        \ showIconBarPointer to 0 (i.e. hide the icon bar
                        \ pointer)

 CMP #&93               \ If the view type in QQ11 is &93 (Mission 1 text
 BEQ upvw4              \ briefing), jump to upvw4 to to set showIconBarPointer
                        \ to 0 (i.e. hide the icon bar pointer)

 ASL A                  \ If bit 6 of the view type in QQ11 is clear, then there
 BPL upvw5              \ is an icon bar, so jump to upvw5 to set
                        \ showIconBarPointer to &FF (i.e. show the icon bar
                        \ pointer)

.upvw4

 LDX #0                 \ Set X = 0 to use as the value of showIconBarPointer
                        \ below (i.e. hide the icon bar pointer)

.upvw5

 STX showIconBarPointer \ Set showIconBarPointer to X, so we set it as follows:
                        \
                        \   * 0 if the view is a mission briefing, or the Start
                        \     screen with the normal font loaded, or has no
                        \     icon bar (in which case we hide the icon bar
                        \     pointer)
                        \
                        \   * &FF otherwise (in which case we show the icon bar
                        \     pointer)

 LDA firstFreeTile      \ Tell the NMI handler to send pattern entries from the
 STA firstPatternTile   \ first free tile onwards, so we don't waste time
                        \ resending the static tiles we have already sent

 RTS                    \ Return from the subroutine

.upvw6

 JSR UpdateScreen       \ Update the screen by sending data to the PPU, either
                        \ immediately or during VBlank, depending on whether
                        \ the screen is visible

 JMP upvw3              \ Jump back to upvw3 to continue updating the view

\ ******************************************************************************
\
\       Name: yHeadshot
\       Type: Variable
\   Category: Status
\    Summary: The text row for the headshot on the Status Mode page
\
\ ******************************************************************************

.yHeadshot

 EQUB 8                 \ English

 EQUB 8                 \ German

 EQUB 10                \ French

 EQUB 8                 \ There is no fourth language, so this byte is ignored

\ ******************************************************************************
\
\       Name: DrawScreenInNMI
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Configure the NMI handler to draw the screen
\
\ ******************************************************************************

.DrawScreenInNMI

 JSR WaitForPPUToFinish \ Wait until both bitplanes of the screen have been
                        \ sent to the PPU, so the screen is fully updated and
                        \ there is no more data waiting to be sent to the PPU

 LDA #0                 \ Tell the NMI handler to send nametable entries from
 STA firstNametableTile \ tile 0 onwards

 LDA #100               \ Tell the NMI handler to only clear nametable entries
 STA maxNameTileToClear \ up to tile 100 * 8 = 800 (i.e. up to the end of tile
                        \ row 24)

 LDA #37                \ Tell the NMI handler to send pattern entries from
 STA firstPatternTile   \ pattern 37 in the buffer

 JSR SetupPPUForIconBar \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 JSR DrawBoxEdges       \ Draw the left and right edges of the box along the
                        \ sides of the screen, drawing into the nametable buffer
                        \ for the drawing bitplane

 JSR CopyNameBuffer0To1 \ Copy the contents of nametable buffer 0 to nametable
                        \ buffer and tell the NMI handler to send pattern
                        \ entries up to the first free tile

 LDA #%11000100         \ Set both bitplane flags as follows:
 STA bitplaneFlags      \
 STA bitplaneFlags+1    \   * Bit 2 set   = send tiles up to end of the buffer
                        \   * Bit 3 clear = don't clear buffers after sending
                        \   * Bit 4 clear = we've not started sending data yet
                        \   * Bit 5 clear = we have not yet sent all the data
                        \   * Bit 6 set   = send both pattern and nametable data
                        \   * Bit 7 set   = send data to the PPU
                        \
                        \ Bits 0 and 1 are ignored and are always clear

 LDA firstFreeTile      \ Tell the NMI handler to send pattern entries from the
 STA firstPatternTile   \ first free tile onwards, so we don't waste time
                        \ resending the static tiles we have already sent

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: PrintTokenCrTab
\       Type: Subroutine
\   Category: Text
\    Summary: Print a token, a newline and the correct indent for Status Mode
\             entries in the chosen language
\
\ ******************************************************************************

.PrintTokenCrTab

 JSR TT27_b2            \ Print the token in A

                        \ Fall through into PrintCrTab to print a newline and
                        \ the correct indent for the chosen language

\ ******************************************************************************
\
\       Name: PrintCrTab
\       Type: Subroutine
\   Category: Text
\    Summary: Print a newline and the correct indent for Status Mode entries in
\             the chosen language
\
\ ******************************************************************************

.PrintCrTab

 JSR TT67               \ Print a newline

 LDX languageIndex      \ Move the text cursor to the correct column for the
 LDA xStatusMode,X      \ Status Mode entry in the chosen language
 STA XC

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: xStatusMode
\       Type: Variable
\   Category: Status
\    Summary: The text column for the Status Mode entries for each language
\
\ ******************************************************************************

.xStatusMode

 EQUB 3                 \ English

 EQUB 3                 \ German

 EQUB 1                 \ French

 EQUB 3                 \ There is no fourth language, so this byte is ignored

INCLUDE "library/common/main/subroutine/mvt3.asm"
INCLUDE "library/common/main/subroutine/mvs5.asm"
INCLUDE "library/common/main/variable/tens.asm"
INCLUDE "library/common/main/subroutine/pr2.asm"
INCLUDE "library/common/main/subroutine/tt11.asm"
INCLUDE "library/common/main/subroutine/bprnt.asm"

\ ******************************************************************************
\
\       Name: DrawPitchRollBars
\       Type: Subroutine
\   Category: Dashboard
\    Summary: ???
\
\ ------------------------------------------------------------------------------
\
\ Moves sprite 11 to coord (JSTX, 29)
\              12 to coord (JSTY, 37)
\
\ ******************************************************************************

.DrawPitchRollBars

 LDA JSTX
 EOR #&FF
 LSR A
 LSR A
 LSR A
 CLC
 ADC #&D8
 STA SC2
 LDY #&1D
 LDA #&0B
 JSR C8BB4
 LDA JSTY
 LSR A
 LSR A
 LSR A
 CLC
 ADC #&D8
 STA SC2
 LDY #&25
 LDA #&0C

.C8BB4

 ASL A
 ASL A
 TAX
 LDA SC2
 SEC
 SBC #4
 STA xSprite0,X
 TYA
 CLC

 ADC #170+YPAL

 STA ySprite0,X
 RTS

INCLUDE "library/common/main/subroutine/escape.asm"
INCLUDE "library/enhanced/main/subroutine/hme2.asm"
INCLUDE "library/common/main/subroutine/tactics_part_1_of_7.asm"
INCLUDE "library/common/main/subroutine/tactics_part_2_of_7.asm"
INCLUDE "library/common/main/subroutine/tactics_part_3_of_7.asm"
INCLUDE "library/common/main/subroutine/tactics_part_4_of_7.asm"
INCLUDE "library/common/main/subroutine/tactics_part_5_of_7.asm"
INCLUDE "library/common/main/subroutine/tactics_part_6_of_7.asm"
INCLUDE "library/common/main/subroutine/tactics_part_7_of_7.asm"
INCLUDE "library/enhanced/main/subroutine/dockit.asm"
INCLUDE "library/enhanced/main/subroutine/vcsu1.asm"
INCLUDE "library/enhanced/main/subroutine/vcsub.asm"
INCLUDE "library/common/main/subroutine/tas1.asm"
INCLUDE "library/enhanced/main/subroutine/tas4.asm"
INCLUDE "library/enhanced/main/subroutine/tas6.asm"
INCLUDE "library/enhanced/main/subroutine/dcs1.asm"
INCLUDE "library/common/main/subroutine/hitch.asm"
INCLUDE "library/common/main/subroutine/frs1.asm"
INCLUDE "library/common/main/subroutine/frmis.asm"
INCLUDE "library/common/main/subroutine/angry.asm"
INCLUDE "library/common/main/subroutine/fr1.asm"
INCLUDE "library/common/main/subroutine/sescp.asm"
INCLUDE "library/common/main/subroutine/sfs1.asm"
INCLUDE "library/common/main/subroutine/sfs2.asm"

\ ******************************************************************************
\
\       Name: LAUN
\       Type: Subroutine
\   Category: Flight
\    Summary: Make the launch sound and draw the launch tunnel
\
\ ------------------------------------------------------------------------------
\
\ This is shown when launching from or docking with the space station.
\
\ ******************************************************************************

.LAUN

 LDA #&00               \ Clear the screen and and set the view type in QQ11 to
 JSR ChangeToView       \ &00 (Space view with no fonts loaded)

 JSR HideMostSprites    \ Hide all sprites except for sprite 0 and the icon bar
                        \ pointer

 LDY #12                \ Call the NOISE routine with Y = 12 to make the first
 JSR NOISE              \ sound of the ship launching from the station

 LDA #128               \ Set K+2 = 128 to send to DrawLaunchBox and
 STA K+2                \ DrawLightning as the x-coordinate of the centre of the
                        \ boxes and lightning (so they are centred on-screen)

 LDA halfScreenHeight   \ Set K+3 to half the screen height to send to
 STA K+3                \ DrawLaunchBox and DrawLightning as the y-coordinate of
                        \ the centre of the boxes and lightning (so they are
                        \ centred on-screen)

 LDA #80                \ Set XP to use as a counter for the duration of the
 STA XP                 \ hyperspace effect, so we run the following loop 80
                        \ times

 LDA #112               \ Set YP to use as a counter for when we show the
 STA YP                 \ lightning effect at the end of the tunnel, which we
                        \ show when YP < 100 (so we wait until 13 frames have
                        \ passed before drawing the lightning)
                        \
                        \ Also, at the start of each frame, we keep subtracting
                        \ 16 from STP until STP < YP, and only then do we start
                        \ drawing boxes and, possibly, the lightning

 LDY #4                 \ Wait until four NMI interrupts have passed (i.e. the
 JSR DELAY              \ next four VBlanks)

 LDY #24                \ Call the NOISE routine with Y = 24 to make the second
 JSR NOISE              \ sound of the ship launching from the station

.laun1

 JSR CheckForPause-3    \ Check whether the pause button has been pressed or an
                        \ icon bar button has been chosen, and process pause or
                        \ unpause if a pause-related button has been pressed

 JSR FlipDrawingPlane   \ Flip the drawing bitplane so we draw into the bitplane
                        \ that isn't visible on-screen

 LDA XP                 \ Set STP = 96 + (XP mod 16)
 AND #15                \
 ORA #96                \
 STA STP                \ So over the course of the 80 iterations around the
                        \ loop, STP starts at 96, then counts down from 112 to
                        \ 96, and keeps repeating this countdown until XP is
                        \ zero and STP is 96
                        \
                        \ The higher the value of STP, the closer together the
                        \ lines in the tunnel, so this makes the tunnel lines
                        \ move further away as the animation progresses, giving
                        \ a feeling of moving forwards through the tunnel

 LDA #%10000000         \ Set bit 7 of tempVar so we can detect when we are on
 STA tempVar            \ the first iteration of the laun2 loop

                        \ We now draw the boxes in the launch tunnel effect,
                        \ looping back to hype2 for each new line
                        \
                        \ STP gets decremented by 16 for each box, so STP is
                        \ set to the starting point (in the range 96 to 112),
                        \ and gets decremented by 16 for each box until it is
                        \ negative
                        \
                        \ As STP decreases, the boxes get bigger, so this loop
                        \ draws the boxes from the smallest in the middle and
                        \ working out towards the edges

.laun2

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA STP                \ Set STP = STP + 16
 SEC                    \
 SBC #16                \ And set A to the new value of STP

 BMI laun4              \ If STP is now negative, then jump to laun4 to move on
                        \ to the next frame, so we dtop drawing boxes in this
                        \ frame

 STA STP                \ Update STP with the new value

 CMP YP                 \ If STP >= YP, jump to laun2 to keep reducing STP until
 BCS laun2              \ STP < YP

 STA Q                  \ Set Q to the new value of STP

                        \ We now calculate how far the top edge of this box is
                        \ from the centre of the screen in a vertical direction,
                        \ with the result being boxes that are closer together,
                        \ the closer they are to the centre
                        \
                        \ We space out the boxes using a reciprocal algorithm,
                        \ where the distance of line n from the centre is
                        \ proportional to 1/n, so the boxes get spaced roughly
                        \ in the proportions of 1/2, 1/3, 1/4, 1/5 and so on, so
                        \ the boxes bunch closer together as n increases
                        \
                        \ STP also includes the iteration number, modded so it
                        \ runs from 15 to 0, so over the course of the animation
                        \ the boxes move away from the centre line, as the
                        \ iteration decreases and the value of R below increases

 LDA #8                 \ Set A = 8 to use in the following division

 JSR LL28               \ Call LL28 to calculate:
                        \
                        \   R = 256 * A / Q
                        \     = 256 * 8 / STP
                        \
                        \ So R is the vertical distance of the current box top
                        \ top from the centre of the screen
                        \
                        \ The maximum value of STP is 112 - 16 = 96, and the
                        \ minimum is 0 (the latter being enforced by the
                        \ comparison above), so R ranges from 21 to 255

 LDA R                  \ Set A = R - 20
 SEC                    \
 SBC #20                \ This sets the range of values in A to 1 to 235

                        \ We can now use A as half the height of the box to
                        \ draw, to give us an effect where the boxes are more
                        \ spread out as they get taller, and which get bigger
                        \ as the animation progesses, with the difference in
                        \ size between frames being more pronounced with the
                        \ bigger boxes

 CMP #84                \ If A >= 84, jump to laun4 to move on to the next frame
 BCS laun4              \ as the box is outside the edges of the screen (so we
                        \ can stop drawing lines in this frame as we have now
                        \ drawn them all)

 STA K+1                \ Set K+1 = A to send to DrawLaunchBox and DrawLightning
                        \ as half the height of the box/lightning

 LSR A                  \ Set K = 1.5 * K+1 to send to DrawLaunchBox and
 ADC K+1                \ DrawLightning as half the width of the box, so the box
 STA K                  \ is 50% wider than it is tall (as it's a space station
                        \ slot)

 ASL tempVar            \ Set the C flag to bit 7 of tempVar and zero tempVar
                        \ (as we know that only bit 7 of tempVar is set before
                        \ the shift)

 BCC laun3              \ If the C flag is clear then this is not the first
                        \ iteration of the laun2 loop for this frame, so jump to
                        \ laun3 to draw the box, skipping the lightning (so we
                        \ only draw the lightning on the first iteration of
                        \ laun2 for this frame

                        \ If we get here then this is the first iteration of the
                        \ laun2 loop for this frame, so we consider drawing the
                        \ lightning effect at the end of the tunnel

 LDA YP                 \ If YP >= 100, jump to laun3 to skip drawing the
 CMP #100               \ lightning as the tunnel exit is too small to contain
 BCS laun3              \ the lightning effect

 LDA K+1                \ If K+1 >= 72, jump to laun5 to draw the lightning but
 CMP #72                \ without drawing any boxes, as the first box (which is
 BCS laun5              \ the smallest) doesn't fit on-screen

 LDA STP                \ Store the value of STP on the stack so we can retrieve
 PHA                    \ it after the call to DrawLightning (as DrawLightning
                        \ corrupts the value of STP)

 JSR DrawLightning_b6   \ Call DrawLightning to draw the lightning effect at the
                        \ end of the tunnel, centred on the centre of the screen
                        \ and in a rectangle with a half-height of K and a
                        \ half-width of 1.5 * K (so it fits within the smallest
                        \ launch box)

 PLA                    \ Restore the value of STP that we stored on the stack
 STA STP

.laun3

 JSR DrawLaunchBox_b6   \ Draw a box centred on the centre of the screen, with a
                        \ half-height of K and a half-width of 1.5 * K

 JMP laun2              \ Loop back to laun2 to draw the next box

.laun4

 JSR DrawBitplaneInNMI  \ Configure the NMI to send the drawing bitplane to the
                        \ PPU after drawing the box edges and setting the next
                        \ free tile number

 DEC YP                 \ Decrement the lightning counter in YP

 DEC XP                 \ Decrement the frame counter in XP

 BNE laun1              \ Loop back to laun1 to draw the next frame of the
                        \ animation, until the frame counter runs down to 0

 LDY #23                \ Call the NOISE routine with Y = 23 to make the third
 JMP NOISE              \ sound of the ship launching from the station,
                        \ returning from the subroutine using a tail call

.laun5

                        \ We call this from the first iteration of the loop in
                        \ this frame, and when K+1 >= 72, which means that the
                        \ first box in this frame (which will be the smallest)
                        \ is too big for the screen, so we just draw the
                        \ lightning effect and don't draw any boxes

 LDA #72                \ Set K+1 = 72 to pass to DrawLightning as half the
 STA K+1                \ height of the lightning effect

 LDA STP                \ Store the value of STP on the stack so we can retrieve
 PHA                    \ it after the call to DrawLightning (as DrawLightning
                        \ corrupts the value of STP)

 JSR DrawLightning_b6   \ Call DrawLightning to draw the lightning effect at the
                        \ end of the tunnel, centred on the centre of the screen
                        \ and in a rectangle with a half-height of K and a
                        \ half-width of 1.5 * K (so it fits within the smallest
                        \ launch box)

 PLA                    \ Restore the value of STP that we stored on the stack
 STA STP

 JMP laun2              \ Loop back to laun2 to draw the next box

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/lasli.asm"
INCLUDE "library/enhanced/main/subroutine/brief2.asm"
INCLUDE "library/enhanced/main/subroutine/brp.asm"
INCLUDE "library/enhanced/main/subroutine/brief3.asm"
INCLUDE "library/enhanced/main/subroutine/debrief2.asm"
INCLUDE "library/enhanced/main/subroutine/debrief.asm"
INCLUDE "library/advanced/main/subroutine/tbrief.asm"
INCLUDE "library/enhanced/main/subroutine/brief.asm"
INCLUDE "library/nes/main/subroutine/bris_b0.asm"
INCLUDE "library/common/main/subroutine/ping.asm"

\ ******************************************************************************
\
\       Name: PlayDemo
\       Type: Subroutine
\   Category: Demo
\    Summary: ???
\
\ ******************************************************************************

.PlayDemo

 JSR RES2

 JSR ResetCommander_b6  \ Reset the current commander and current position to
                        \ the default "JAMESON" commander

 LDA #0
 STA QQ14
 STA CASH
 STA CASH+1
 LDA #&FF
 STA ECM
 LDA #1
 STA ENGY
 LDA #&8F
 STA LASER

 LDA #&FF               \ Set demoInProgress = &FF to indicate that we are
 STA demoInProgress     \ playing the demo

 JSR SOLAR
 LDA #0
 STA DELTA
 STA ALPHA
 STA ALP1
 STA QQ12
 STA VIEW

 JSR TT66               \ Clear the screen and and set the view type in QQ11 to
                        \ &00 (Space view with no fonts loaded)

 LSR demoInProgress     \ Clear bit 7 of demoInProgress

 JSR CopyNameBuffer0To1 \ Copy the contents of nametable buffer 0 to nametable
                        \ buffer and tell the NMI handler to send pattern
                        \ entries up to the first free tile

 JSR SetupFullViewInNMI \ Configure the PPU to send tiles for a full screen
                        \ (no dashboard) during VBlank

 JSR SetupSpaceView
 JSR FixRandomNumbers
 JSR SetupDemoShip
 LDA #6
 STA INWK+30
 LDA #&18
 STA INWK+29
 LDA #&12
 JSR NWSHP
 LDA #&0A
 JSR RunDemoFlightLoop
 LDA #&92
 STA K%+114
 LDA #1
 STA K%+112
 JSR SetupDemoShip
 LDA #6
 STA INWK+30
 ASL INWK+2
 LDA #&C0
 STA INWK+29
 LDA #&13
 JSR NWSHP
 LDA #6
 JSR RunDemoFlightLoop
 JSR SetupDemoShip
 LDA #6
 STA INWK+30
 ASL INWK+2
 LDA #0
 STA XX1
 LDA #&46
 STA INWK+6
 LDA #&11
 JSR NWSHP
 LDA #5
 JSR RunDemoFlightLoop
 LDA #&C0
 STA K%+198
 LDA #&0B
 JSR RunDemoFlightLoop
 LDA #&32
 STA nmiTimer
 LDA #0
 STA nmiTimerLo
 STA nmiTimerHi

 JSR SIGHT_b3           \ Draw the laser crosshairs

 LSR allowInSystemJump
 JSR UpdateIconBar_b3
 LDA soundVar06
 STA soundVar05
 LDA #&10
 STA DELTA
 JMP MLOOP

\ ******************************************************************************
\
\       Name: RunDemoFlightLoop
\       Type: Subroutine
\   Category: Demo
\    Summary: ???
\
\ ******************************************************************************

.RunDemoFlightLoop

 STA LASCT

.loop_C95E7

 JSR FlipDrawingPlane   \ Flip the drawing bitplane so we draw into the bitplane
                        \ that isn't visible on-screen

 JSR FlightLoop4To16

 JSR DrawBitplaneInNMI  \ Configure the NMI to send the drawing bitplane to the
                        \ PPU after drawing the box edges and setting the next
                        \ free tile number

 LDA iconBarChoice
 JSR CheckForPause
 DEC LASCT
 BNE loop_C95E7
 RTS

\ ******************************************************************************
\
\       Name: SetupDemoShip
\       Type: Subroutine
\   Category: Demo
\    Summary: ???
\
\ ******************************************************************************

.SetupDemoShip

 JSR ZINF
 LDA #&60
 STA INWK+14
 ORA #&80
 STA INWK+22
 LDA #&FE
 STA INWK+32
 LDA #&20
 STA INWK+27
 LDA #&80
 STA INWK+2
 LDA #&28
 STA XX1
 LDA #&28
 STA INWK+3
 LDA #&3C
 STA INWK+6
 RTS

INCLUDE "library/enhanced/main/subroutine/tnpr1.asm"
INCLUDE "library/common/main/subroutine/tnpr.asm"
INCLUDE "library/nes/main/subroutine/setnewviewtype.asm"
INCLUDE "library/common/main/subroutine/tt20.asm"
INCLUDE "library/common/main/subroutine/tt54.asm"
INCLUDE "library/common/main/subroutine/tt146.asm"
INCLUDE "library/common/main/subroutine/tt60.asm"
INCLUDE "library/common/main/subroutine/ttx69.asm"
INCLUDE "library/common/main/subroutine/tt69.asm"
INCLUDE "library/common/main/subroutine/tt67.asm"
INCLUDE "library/common/main/subroutine/tt70.asm"
INCLUDE "library/common/main/subroutine/spc.asm"
INCLUDE "library/nes/main/subroutine/printspaceandtoken.asm"
INCLUDE "library/nes/main/variable/xdataonsystem.asm"

\ ******************************************************************************
\
\       Name: PrintTokenAndColon
\       Type: Subroutine
\   Category: Text
\    Summary: Print a character followed by a colon, ensuring that the colon is
\             always drawn in colour 3 on a black background
\
\ ------------------------------------------------------------------------------
\
\ The colon is printed using font style 3. This draws the colon in colour 3 on
\ background colour 0 (i.e. green on black), but without using the normal font.
\
\ This ensures that the colon will be drawn in green when the colon's tile falls
\ within a 2x2 attribute block that's set to draw white text (i.e. where colour
\ 1 is white). This happens in the Status Mode screen in French, and in the Data
\ on System screen.
\
\ Arguments:
\
\   A                   The character to be printed
\
\ ******************************************************************************

.PrintTokenAndColon

 JSR TT27_b2            \ Print the character in A

 LDA #3                 \ Set the font style to green text on a black background
 STA fontStyle          \ (colour 3 on background colour 0)

 LDA #':'               \ Print a colon
 JSR TT27_b2

 LDA #1                 \ Set the font style to print in the normal font
 STA fontStyle

 RTS                    \ Return from the subroutine

INCLUDE "library/nes/main/variable/radiustext.asm"
INCLUDE "library/common/main/subroutine/tt25.asm"
INCLUDE "library/common/main/subroutine/tt22.asm"
INCLUDE "library/common/main/subroutine/tt15.asm"
INCLUDE "library/common/main/subroutine/tt14.asm"
INCLUDE "library/common/main/subroutine/tt128.asm"
INCLUDE "library/common/main/subroutine/tt210.asm"
INCLUDE "library/common/main/subroutine/tt213.asm"

\ ******************************************************************************
\
\       Name: PrintCharacter
\       Type: Subroutine
\   Category: Text
\    Summary: Print a character and set the C flag
\
\ ******************************************************************************

.PrintCharacter

 JSR DASC_b2            \ Print the character in A

 SEC                    \ Set the C flag

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/tt16.asm"

\ ******************************************************************************
\
\       Name: TT103
\       Type: Subroutine
\   Category: Charts
\    Summary: Draw a small set of crosshairs on a chart
\
\ ------------------------------------------------------------------------------
\
\ Draw a small set of crosshairs on a galactic chart at the coordinates in
\ (QQ9, QQ10).
\
\ ******************************************************************************

.TT103

 LDA QQ11               \ Fetch the current view type into A

 CMP #&9C               \ If the view type in QQ11 is &9C (Short-range Chart),
 BEQ TT105              \ jump to TT105 to draw the correct crosshairs for that
                        \ chart

                        \ We now set the pixel coordinates of the crosshairs in
                        \ QQ9 and QQ9+1 so they fit into the chart, with a
                        \ 31-pixel margin on the left and a 32-pixel margin at
                        \ the top, for the chart title
                        \
                        \ The Long-range Chart is twice as wide as it is high,
                        \ so we need to scale the y-coordinate in QQ19+1 by an
                        \ extra division by 2 when compared to the x-coordinate

 LDA QQ9                \ Set QQ19 = 31 + QQ9 - (QQ9 / 4)
 LSR A                  \          = 31 + 0.75 * QQ9
 LSR A
 STA T1
 LDA QQ9
 SEC
 SBC T1
 CLC
 ADC #31
 STA QQ19

 LDA QQ10               \ Set QQ19+1 = 32 + (QQ10 - (QQ10 / 4)) / 2
 LSR A                  \            = 32 + 0.375 * QQ10
 LSR A
 STA T1                 
 LDA QQ10
 SEC
 SBC T1
 LSR A
 CLC
 ADC #32
 STA QQ19+1

 LDA #4                 \ Set QQ19+2 to 4 denote crosshairs of size 4 (though
 STA QQ19+2             \ this is ignored by DrawCrosshairs, which always draws
                        \ the crosshairs as a single-tile square reticle)

 JMP DrawCrosshairs     \ Jump to TT15 to draw a square reticle at the
                        \ crosshairs coordinates, returning from the
                        \ subroutine using a tail call

INCLUDE "library/common/main/subroutine/tt123.asm"
INCLUDE "library/common/main/subroutine/tt105.asm"

\ ******************************************************************************
\
\       Name: DrawCrosshairs
\       Type: Subroutine
\   Category: Charts
\    Summary: Draw a set of moveable crosshairs as a square reticle
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   QQ19                The pixel x-coordinate of the centre of the crosshairs
\
\   QQ19+1              The pixel y-coordinate of the centre of the crosshairs
\
\ ******************************************************************************

.DrawCrosshairs

 LDA #248               \ Set the tile pattern number for sprite 15 to 248,
 STA tileSprite15       \ which contains a one-tile square outline that we can
                        \ use as a square reticle to implement crosshairs on the
                        \ chart

 LDA #%00000001         \ Set the attributes for sprite 15 as follows:
 STA attrSprite15
                        \     * Bits 0-1    = sprite palette 1
                        \     * Bit 5 clear = show in front of background
                        \     * Bit 6 clear = do not flip horizontally
                        \     * Bit 7 clear = do not flip vertically

 LDA QQ19               \ Set SC2 to the pixel x-coordinate of the centre of the
 STA SC2                \ crosshairs

 LDY QQ19+1             \ Set Y to the pixel y-coordinate of the centre of the
                        \ crosshairs

 LDA #15                \ Set X = 15 * 4, so X is the index of sprite 15 within
 ASL A                  \ the sprite buffer, as each sprite takes up four bytes
 ASL A                  \ (in other words, xSprite0 + X and ySprite0 + X are the
 TAX                    \ addresses of the x- and y-coordinates of sprite 15 in
                        \ the sprite buffer)

 LDA SC2                \ Set the pixel x-coordinate of sprite 15 to SC2 - 4
 SEC                    \
 SBC #4                 \ So the centre of the square reticle in sprite 15 is at
 STA xSprite0,X         \ x-coordinate SC2, as the reticle is eight pixels wide

 TYA                    \ Set the pixel y-coordinate of sprite 15 to Y + 10
 CLC                    \
 ADC #10+YPAL           \ So the reticle is drawn 10 pixels below the coordinate
 STA ySprite0,X         \ in the QQ19+1 argument ???

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: HideCrosshairs
\       Type: Subroutine
\   Category: Charts
\    Summary: Hide the moveable crosshairs (i.e. the square reticle)
\
\ ******************************************************************************

.HideCrosshairs

 LDA #240               \ Set the y-coordinate of sprite 15 to 240, so it is
 STA ySprite15          \ below the bottom of the screen and is therefore hidden

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: xShortRange
\       Type: Variable
\   Category: Charts
\    Summary: The text column for the Short-range Chart title for each language
\
\ ******************************************************************************

.xShortRange

 EQUB 7                 \ English

 EQUB 8                 \ German

 EQUB 10                \ French

 EQUB 8                 \ There is no fourth language, so this byte is ignored

INCLUDE "library/common/main/subroutine/tt23.asm"

\ ******************************************************************************
\
\       Name: DrawChartSystem
\       Type: Subroutine
\   Category: Charts
\    Summary: Draw system blobs on short-range chart
\
\ ------------------------------------------------------------------------------
\
\ Increments systemsOnChart
\ Sets sprite systemsOnChart to tile 213+K at (K3-4, K4+10)
\ K = 2 or 3 or 4 -> 215-217
\
\ ******************************************************************************

.DrawChartSystem

 LDY systemsOnChart
 CPY #24
 BCS C9CF7
 INY
 STY systemsOnChart
 TYA
 ASL A
 ASL A
 TAY
 LDA K3
 SBC #3
 STA xSprite38,Y
 LDA K4
 CLC

 ADC #10+YPAL

 STA ySprite38,Y
 LDA #&D5
 CLC
 ADC K
 STA tileSprite38,Y
 LDA #2
 STA attrSprite38,Y

.C9CF7

 RTS

INCLUDE "library/common/main/subroutine/tt81.asm"

\ ******************************************************************************
\
\       Name: SelectNearbySystem
\       Type: Subroutine
\   Category: Universe
\    Summary: Set the current system to the nearest system and update the
\             selected system flags accordingly
\
\ ******************************************************************************

.SelectNearbySystem

 JSR TT111              \ Select the system closest to galactic coordinates
                        \ (QQ9, QQ10)

 JMP SetSelectionFlags  \ Jump to SetSelectionFlags to set the selected system
                        \ flags for the new system and update the icon bar if
                        \ required

\ ******************************************************************************
\
\       Name: SetSelectedSystem
\       Type: Subroutine
\   Category: Universe
\    Summary: Set the selected system to the nearest system, if we don't already
\             have a selected system
\
\ ******************************************************************************

.SetSelectedSystem

 LDA selectedSystemFlag \ If bit 7 of selectedSystemFlag is set, then we already
 BMI SetCurrentSystem   \ have a selected system, so jump to SetCurrentSystem
                        \ to ensure we keep using this system as our selected
                        \ system, returning from the subroutine using a tail
                        \ call

                        \ If we get here then we do not already have a selected
                        \ system, so now we set it up

 JSR TT111              \ Select the system closest to galactic coordinates
                        \ (QQ9, QQ10)

 LDA QQ11               \ If the view in QQ11 is not %0000110x (i.e. 12 or 13,
 AND #%00001110         \ which are the Short-range Chart and Long-range Chart),
 CMP #%00001100         \ jump to pchm1 to skip the following as we don't need
 BNE pchm1              \ to update the message on the chart view

 JSR TT103              \ Draw small crosshairs at coordinates (QQ9, QQ10),
                        \ which will draw the crosshairs at our current home
                        \ system

 LDA #0                 \ Set QQ17 = 0 to switch to ALL CAPS
 STA QQ17

 JSR CLYNS              \ Clear the bottom three text rows of the upper screen,
                        \ and move the text cursor to column 1 on row 21, i.e.
                        \ the start of the top row of the three bottom rows

 JSR cpl                \ Call cpl to print out the system name for the seeds
                        \ in QQ15

 LDA #%10000000         \ Set bit 7 of QQ17 to switch standard tokens to
 STA QQ17               \ Sentence Case

 LDA #12                \ Print a newline
 JSR DASC_b2

 JSR TT146              \ If the distance to this system is non-zero, print
                        \ "DISTANCE", then the distance, "LIGHT YEARS" and a
                        \ paragraph break, otherwise just move the cursor down
                        \ a line

 JSR DrawMessageInNMI   \ Configure the NMI to display the updated message that
                        \ we just printed, showing the current system name and
                        \ distance

.pchm1

                        \ Falll through into SetSelectionFlags to set the
                        \ selected system flags for the new system

\ ******************************************************************************
\
\       Name: SetSelectionFlags
\       Type: Subroutine
\   Category: Universe
\    Summary: Set the selected system flags for the currently selected system
\             and update the icon bar if required
\
\ ******************************************************************************

.SetSelectionFlags

 LDA QQ8+1              \ If the high byte of the distance to the selected
 BNE ssel3              \ system in QQ18(1 0) is non-zero, then it is a long way
                        \ from us, so jump to ssel3 to set the selected system
                        \ flags to indicate we can't hyperspace there

 LDA QQ8                \ If the low byte of the distance to the selected
 BNE ssel1              \ system in QQ18(1 0) is non-zero, then jump to ssel1
                        \ to check whether we have enough fuel to hyperspace
                        \ there

                        \ If we get here then QQ18(1 0) is zero, so the selected
                        \ system is the same as the current system

 LDA MJ                 \ If MJ is zero then we are not in witchspace, so jump
 BEQ ssel3              \ to ssel3 to set the selected system flags to indicate
                        \ we can't hyperspace to the selected system (as it is
                        \ the same as the current system)

 BNE ssel2              \ MJ is non-zero so we are in witchspace, so jump to
                        \ ssel2 to set the selected system flags to indicate we
                        \ can hyperspace to the selected system (as we are in
                        \ the middle of nowhere without a current system)

.ssel1

 CMP QQ14               \ If the distance to the selected system is equal to the
 BEQ ssel2              \ fuel level in QQ14, jump to ssel2 to set the selected
                        \ system flags to indicate we can hyperspace to the
                        \ selected system

 BCS ssel3              \ If the distance to the selected system is greater than
                        \ the fuel level in QQ14, jump to ssel3 to set the
                        \ selected system flags to indicate we can't hyperspace
                        \ to the selected system (as we don't have enough fuel)

                        \ If we get here then the distance to the selected
                        \ system is less than the fuel level in QQ14, so fall
                        \ through into ssel2 to set the selected system flags to
                        \ indicate we can hyperspace to the selected system

.ssel2

 LDA #%11000000         \ Set A so we set bits 6 and 7 of the selected system
                        \ flags below to indicate that a system is selected and
                        \ we can hyperspace to it

 BNE ssel4              \ Jump to ssel4 to skip the following instruction (this
                        \ BNE is effectively a JMP as A is never zero)

.ssel3

 LDA #%10000000         \ Set A so we set bit 7 and clear bit 6 of the selected
                        \ system flags below to indicate that a system is
                        \ selected but we can't hyperspace to it

.ssel4

 TAX                    \ Copy A into X so we can set selectedSystemFlag to this
                        \ value below

 EOR selectedSystemFlag \ Flip bit 7 and possibly bit 6 in selectedSystemFlag
                        \ and keep the result in A

 STX selectedSystemFlag \ Set selectedSystemFlag to X

 ASL A                  \ If bit 6 of the EOR result in A is clear, then the
 BPL RTS6               \ state of bit 6 did not changed in the update above, so
                        \ we don't need to update the icon bar to show or hide
                        \ the hyperspave button, so return from the subroutine
                        \ (as RTS6 contains an RTS)

 JMP UpdateIconBar_b3   \ Otherwise the newly selected system has a different
                        \ "can we hyperspace here?" status to the previous
                        \ selected system, so we need to update the icon bar to
                        \ either hide or show the hyperspace button, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SetCurrentSystem
\       Type: Subroutine
\   Category: Universe
\    Summary: Set the seeds for the selected system to the system that we last
\             snapped the crosshairs to
\
\ ------------------------------------------------------------------------------
\
\ Other entry points:
\
\   RTS6                Contains an RTS
\
\ ******************************************************************************

.SetCurrentSystem

 LDX #5                 \ Set up a counter in X to copy six bytes (for three
                        \ 16-bit numbers)

.ssys1

 LDA selectedSystem,X   \ Copy the X-th byte in selectedSystem to the X-th byte
 STA QQ15,X             \ in QQ15, to set the selected system to the previous
                        \ system that we snapped the crosshairs to

 DEX                    \ Decrement the counter

 BPL ssys1              \ Loop back until we have copied all six seeds

.RTS6

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/tt111.asm"
INCLUDE "library/common/main/subroutine/hy6-docked.asm"

\ ******************************************************************************
\
\       Name: GalacticHyperdrive
\       Type: Subroutine
\   Category: Flight
\    Summary: If we are in space and the countdown has ended, activate the
\             galactic hyperdrive
\
\ ******************************************************************************

.GalacticHyperdrive

 LDA QQ12               \ If we are docked (QQ12 = &FF) then jump to dockEd to
 BNE dockEd             \ print an error message and return from the subroutine
                        \ using a tail call (as we can't hyperspace when docked)

 LDA QQ22+1             \ Fetch QQ22+1, which contains the number that's shown
                        \ on-screen during hyperspace countdown

 BEQ Ghy                \ If the countdown is zero, then the galactic hyperdrive
                        \ has been activated, so jump to Ghy to process it

 RTS                    \ Otherwise return from the subroutine

INCLUDE "library/common/main/subroutine/hyp.asm"
INCLUDE "library/common/main/subroutine/ww.asm"
INCLUDE "library/common/main/subroutine/ghy.asm"
INCLUDE "library/common/main/subroutine/jmp.asm"
INCLUDE "library/common/main/subroutine/pr6.asm"
INCLUDE "library/common/main/subroutine/pr5.asm"
INCLUDE "library/common/main/subroutine/tt147.asm"
INCLUDE "library/common/main/subroutine/prq.asm"
INCLUDE "library/common/main/subroutine/tt151.asm"

\ ******************************************************************************
\
\       Name: PrintSpacedHyphen
\       Type: Subroutine
\   Category: Text
\    Summary: Print two spaces, then a "-", and then another two spaces
\
\ ******************************************************************************

.PrintSpacedHyphen

 JSR TT162              \ Print two spaces
 JSR TT162

 LDA #'-'               \ Print a "-" character
 JSR TT27_b2

 JSR TT162              \ Print two spaces, returning from the subroutine using
 JMP TT162              \ a tail call

INCLUDE "library/common/main/subroutine/tt152.asm"
INCLUDE "library/common/main/subroutine/tt162.asm"
INCLUDE "library/common/main/subroutine/tt160.asm"
INCLUDE "library/common/main/subroutine/tt161.asm"
INCLUDE "library/common/main/subroutine/tt16a.asm"
INCLUDE "library/common/main/subroutine/tt163.asm"

\ ******************************************************************************
\
\       Name: PrintNumberInHold
\       Type: Subroutine
\   Category: Market
\    Summary: Print the number of units of a specified item that we have in the
\             hold
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   QQ29                The item number
\
\ ******************************************************************************

.PrintNumberInHold

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDY QQ29               \ Set Y to the current item number

 LDA #3                 \ Set A = 3 to use as the number of digits below

 LDX QQ20,Y             \ Set X to the number of units of this item that we
                        \ already have in the hold

 BEQ PrintSpacedHyphen  \ If we don't have any units of this item in the hold,
                        \ jump to PrintSpacedHyphen to print two spaces, a "-",
                        \ and two spaces

 CLC                    \ Otherwise print the 8-bit number in X to 3 digits, as
 JSR pr2+2              \ we set A to 3 above

 JMP TT152              \ Print the unit ("t", "kg" or "g") for the market item,
                        \ with a following space if required to make it two
                        \ characters long, and return from the subroutine using
                        \ a tail call

\ ******************************************************************************
\
\       Name: yMarketPrice
\       Type: Variable
\   Category: Market
\    Summary: The text row for the Market Price title for each language
\
\ ******************************************************************************

.yMarketPrice

 EQUB 4                 \ English

 EQUB 5                 \ German

 EQUB 4                 \ French

 EQUB 4                 \ There is no fourth language, so this byte is ignored

INCLUDE "library/common/main/subroutine/tt167.asm"

\ ******************************************************************************
\
\       Name: BuyAndSellCargo
\       Type: Subroutine
\   Category: Market
\    Summary: Process the buying and selling of cargo on the Market Price screen
\
\ ******************************************************************************

.BuyAndSellCargo

 LDA QQ12               \ If we are docked (QQ12 = &FF) then jump to sell3 to
 BNE sell3              \ show the buy/sell screen

.sell1

                        \ If we get here then we are in space, so we just
                        \ display the view as we can't buy or sell cargo in
                        \ space

 JSR SetScreenForUpdate \ Get the screen ready for updating by hiding all
                        \ sprites, after fading the screen to black if we are
                        \ changing view

 JSR DrawInventoryIcon  \ Draw the inventory icon on top of the second button
                        \ in the icon bar

 JMP UpdateView         \ Update the view, returning from the subroutine using
                        \ a tail call

.sell2

 JMP sell13             \ Jump to sell13 to process the left button being
                        \ pressed

.sell3

 LDA #0                 \ We're going to highlight the current market item and
 STA QQ29               \ let the player move the highlight up and down, so use
                        \ QQ29 to denote the number of the currently selected
                        \ item, starting with item 0 at the top of the list

 JSR HighlightSaleItem  \ Highlight the name, price and availability of market
                        \ item 0 on the correct row for the chosen language

 JSR PrintCash          \ Print our cash levels in the correct place for the
                        \ chosen language

 JSR sell1              \ Call sell1 above to clear the screen and update the
                        \ view

.sell4

 JSR SetupPPUForIconBar \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA controller1B       \ If the B button is being pressed, jump to sell6
 BMI sell6

 LDA controller1Up      \ If neither of the up or down buttons are being
 ORA controller1Down    \ pressed, jump to sell5
 BEQ sell5

 LDA controller1Left    \ If neither of the left or right buttons are being
 ORA controller1Right   \ pressed, jump to sell6
 BNE sell6

.sell5

                        \ If we get here then at least one of the direction
                        \ buttons is being pressed

 LDA controller1Up      \ If the up button is being pressed and has been held
 AND #%11110000         \ down for at least four VBlanks, jump to sell7
 CMP #%11110000
 BEQ sell7

 LDA controller1Down    \ If the down button is being pressed and has been held
 AND #%11110000         \ down for at least four VBlanks, jump to sell10
 CMP #%11110000
 BEQ sell10

 LDA controller1Leftx8  \ If the left button is being pressed and has been held
 CMP #%11110000         \ down for at least four VBlanks, jump to sell13 via 
 BEQ sell2              \ sell2

 LDA controller1Rightx8 \ If the right button is being pressed and has been held
 CMP #%11110000         \ down for at least four VBlanks, jump to sell12
 BEQ sell12

.sell6

                        \ If we get here then either the B button is being
                        \ pressed or no directional buttons are being pressed

 LDA iconBarChoice      \ If iconBarChoice = 0 then nothing has been chosen on
 BEQ sell4              \ the icon bar (if it had, iconBarChoice would contain
                        \ the number of the chosen icon bar button), so loop
                        \ back to sell4 to keep listening for button presses

                        \ If we get here then either a choice has been made on
                        \ the icon bar during NMI and the number of the icon bar
                        \ button is in iconBarChoice, or the Start button has
                        \ been pressed and iconBarChoice is 80

 JSR CheckForPause-3    \ If the Start button has been pressed then process the
                        \ pause menu and set the C flag, otherwise clear it

 BCS sell4              \ If it was the pause button, loop back to sell4 to pick
                        \ up where we left off and keep listening for button
                        \ presses

 RTS                    \ Otherwise a choice has been made from the icon bar, so
                        \ return from the subroutine

.sell7

                        \ If we get here then the up button is being pressed

 LDA QQ29               \ Set A to the number of the currently selected item in
                        \ QQ29

 JSR PrintMarketItem    \ Print the name, price and availability of market item
                        \ item A on the correct row for the chosen language, to
                        \ remove the highlight from the currrent item

 LDA QQ29               \ Set A = QQ29 - 1
 SEC                    \
 SBC #1                 \ So A is the number of the item above the currently
                        \ selected item

 BPL sell8              \ If A is negative, set A = 0, so 0 is the minimum value
 LDA #0                 \ of A (so we can't move the highlight off the top of
                        \ the list of items)

.sell8

 STA QQ29               \ Store the updated item number in QQ29

.sell9

 LDA QQ29               \ Set A to the number of the currently selected item in
                        \ QQ29 (we do this so we can jump here)

 JSR HighlightSaleItem  \ Highlight the name, price and availability of market
                        \ item A on the correct row for the chosen language

 JSR DrawScreenInNMI    \ Configure the NMI handler to draw the screen, so the
                        \ screen gets updated

 JSR WaitForPPUToFinish \ Wait until both bitplanes of the screen have been
                        \ sent to the PPU, so the screen is fully updated and
                        \ there is no more data waiting to be sent to the PPU

 JMP sell4              \ Jump back to sell4 to keep listening for button
                        \ presses

.sell10

                        \ If we get here then the down button is being pressed

 LDA QQ29               \ Set A to the number of the currently selected item in
                        \ QQ29

 JSR PrintMarketItem    \ Print the name, price and availability of market item
                        \ item A on the correct row for the chosen language, to
                        \ remove the highlight from the currrent item

 LDA QQ29               \ Set A = QQ29 + 1
 CLC                    \
 ADC #1                 \ So A is the number of the item below the currently
                        \ selected item

 CMP #17                \ If A = 17, set A = 16, so 16 is the maximum value of
 BNE sell11             \ A (so we can't move the highlight off the bottom of
 LDA #16                \ the list of items)

.sell11

 STA QQ29               \ Store the updated item number in QQ29

 JMP sell9              \ Jump up to sell9 to highlight the newly selected item
                        \ and go back to listening for button presses

.sell12

                        \ If we get here then the right button is being pressed,
                        \ so we process buying an item

 LDA #1                 \ Call tnpr with the selecred market item in QQ29 and
 JSR tnpr               \ A set to 1, to work out whether we have room in the
                        \ hold for the selected item (A is preserved by this
                        \ call, and the C flag contains the result)

 BCS sell14             \ If the C flag is set then we have no room in the hold
                        \ for the selected item, so jump to sell4 via sell14 to
                        \ abort the sale and keep listening for button presses

 LDY QQ29               \ Fetch the currently selected market item number from
                        \ QQ29 into Y

 LDA AVL,Y              \ Set A to the number of available units of the market
                        \ item in Y

 BEQ sell14             \ If there are no units available, jump to sell4 via
                        \ sell14 to abort the sale and keep listening for button
                        \ presses

 LDA QQ24               \ Set P to the item's price / 4
 STA P

 LDA #0                 \ Set A = 0, so (A P) contains the item's price / 4

 JSR GC2                \ Call GC2 to calculate:
                        \
                        \   (Y X) = (A P) * 4
                        \
                        \ which will be the total price of this transaction, as
                        \ (A P) contains the item's price / 4

 JSR LCASH              \ Subtract (Y X) cash from the cash pot in CASH

 BCC sell14             \ If the C flag is clear, we didn't have enough cash,
                        \ so jump to sell4 via sell14 to abort the sale and keep
                        \ listening for button presses

 JSR UpdateSaveCount    \ Update the save counter for the current commander

 LDY #&1C               \ Make a trill noise to indicate that we have bought
 JSR NOISE              \ something

 LDY QQ29               \ Fetch the currently selected market item number from
                        \ QQ29 into Y

 LDA AVL,Y              \ Set A to the number of available units of the market
                        \ item in Y

 SEC                    \ Subtract 1 from the market availability, as we just
 SBC #1                 \ bought one unit
 STA AVL,Y

 LDA QQ20,Y             \ Set A to the number of units of this item that we
                        \ already have in the hold

 CLC                    \ Add 1 to the number of units and update the number in
 ADC #1                 \ the hold
 STA QQ20,Y

 JSR PrintCash          \ Print our cash levels in the correct place for the
                        \ chosen language

 JMP sell9              \ Jump up to sell9 to update the highlighted item with
                        \ the new availability and go back to listening for
                        \ button presses

.sell13

                        \ If we get here then the left button is being pressed,
                        \ so we process selling an item

 LDY QQ29               \ Fetch the currently selected market item number from
                        \ QQ29 into Y

 LDA AVL,Y              \ If there are 99 or more units available on the market,
 CMP #99                \ then the market is already saturated, so jump to sell4
 BCS sell14             \ via sell14 to abort the sale and keep listening for
                        \ button presses

 LDA QQ20,Y             \ Set A to the number of units of this item that we
                        \ already have in the hold

 BEQ sell14             \ If we don't have any items of this type in the hold,
                        \ jump to sell4 via sell14 to abort the sale and keep
                        \ listening for button presses

 JSR UpdateSaveCount    \ Update the save counter for the current commander

 SEC                    \ Subtract 1 from the number of units and update the
 SBC #1                 \ number in the hold
 STA QQ20,Y

 LDA AVL,Y              \ Add 1 to the market availability, as we just sold
 CLC                    \ one unit into the market
 ADC #1
 STA AVL,Y

 LDA QQ24               \ Set P to the item's price / 4
 STA P

 LDA #0                 \ Set A = 0, so (A P) contains the item's price / 4

 JSR GC2                \ Call GC2 to calculate:
                        \
                        \   (Y X) = (A P) * 4
                        \
                        \ which will be the total price of this transaction, as
                        \ (A P) contains the item's price / 4

 JSR MCASH              \ Add (Y X) cash to the cash pot in CASH

 JSR PrintCash          \ Print our cash levels in the correct place for the
                        \ chosen language

 LDY #3                 \ Make a beep sound to indicate that we have made a
 JSR NOISE              \ sale

 JMP sell9              \ Jump up to sell9 to update the highlighted item with
                        \ the new availability and go back to listening for
                        \ button presses

.sell14

 JMP sell4              \ Jump up to sell4 to keep listening for button presses

\ ******************************************************************************
\
\       Name: HighlightSaleItem
\       Type: Subroutine
\   Category: Market
\    Summary: Highlight the name, price and availability of a market item on the
\             correct row for the chosen language
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The item number of the market item to dsplay
\
\ ******************************************************************************

.HighlightSaleItem

 TAY                    \ Set Y to the market item number

 LDX #2                 \ Set the font style to print in the highlight font
 STX fontStyle

 CLC                    \ Move the text cursor to the row for this market item,
 LDX languageIndex      \ starting from item 0 at the top, on the correct row
 ADC yMarketPrice,X     \ for the chosen language
 STA YC

 TYA                    \ Call TT151 to print the item name, market price and
 JSR TT151              \ availability of the current item, and set QQ24 to the
                        \ item's price / 4, QQ25 to the quantity available and
                        \ QQ19+1 to byte #1 from the market prices table for
                        \ this item

 LDX #1                 \ Set the font style to print in the normal font
 STX fontStyle

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: PrintMarketItem
\       Type: Subroutine
\   Category: Market
\    Summary: Print the name, price and availability of a market item on the
\             correct row for the chosen language
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The item number of the market item to dsplay
\
\ ******************************************************************************

.PrintMarketItem

 TAY                    \ Set Y to the market item number

 CLC                    \ Move the text cursor to the row for this market item,
 LDX languageIndex      \ starting from item 0 at the top, on the correct row
 ADC yMarketPrice,X     \ for the chosen language
 STA YC

 TYA                    \ Call TT151 to print the item name, market price and
 JMP TT151              \ availability of the current item, and set QQ24 to the
                        \ item's price / 4, QQ25 to the quantity available and
                        \ QQ19+1 to byte #1 from the market prices table for
                        \ this item
                        \
                        \ When done, return from the subroutine using a tail
                        \ call

\ ******************************************************************************
\
\       Name: PrintCash
\       Type: Subroutine
\   Category: Market
\    Summary: Print our cash levels in the correct place for the chosen language
\
\ ******************************************************************************

.PrintCash

 LDA #%10000000         \ Set bit 7 of QQ17 to switch standard tokens to
 STA QQ17               \ Sentence Case

 LDX languageIndex      \ Move the text cursor to the correct row for the chosen
 LDA yCash,X            \ language, as given in the yCash table
 STA YC

 LDA xCash,X            \ Move the text cursor to the correct column for the
 STA XC                 \ chosen, as given in the xCash table

 JMP PCASH              \ Jump to PCASH to print recursive token 119
                        \ ("CASH:{cash} CR{crlf}"), followed by a space, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: xCash
\       Type: Variable
\   Category: Market
\    Summary: The text column for our cash levels on the Market Price page
\
\ ******************************************************************************

.xCash

 EQUB 5                 \ English

 EQUB 5                 \ German

 EQUB 3                 \ French

 EQUB 5                 \ There is no fourth language, so this byte is ignored

\ ******************************************************************************
\
\       Name: yCash
\       Type: Variable
\   Category: Market
\    Summary: The text row for the cash levels on the Market Price page
\
\ ******************************************************************************

.yCash

 EQUB 22                \ English

 EQUB 23                \ German

 EQUB 22                \ French

 EQUB 22                \ There is no fourth language, so this byte is ignored

INCLUDE "library/common/main/subroutine/var.asm"
INCLUDE "library/common/main/subroutine/hyp1.asm"
INCLUDE "library/common/main/subroutine/gvl.asm"
INCLUDE "library/common/main/subroutine/gthg.asm"
INCLUDE "library/common/main/subroutine/mjp.asm"
INCLUDE "library/common/main/subroutine/tt18.asm"

\ ******************************************************************************
\
\       Name: RedrawCurrentView
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Update the current view when we arrive in a new system
\
\ ******************************************************************************

.RedrawCurrentView

 LDA QQ11               \ If this is the space view (i.e. QQ11 is zero), jump to
 BEQ witc5              \ witc5 to set the current space view type to 4 and show
                        \ the front space view

 LDA QQ11               \ If the view in QQ11 is not %0000110x (i.e. 12 or 13,
 AND #%00001110         \ which are the Short-range Chart and Long-range Chart),
 CMP #%00001100         \ jump to witc2 to keep checking for other view types
 BNE witc2

 LDA QQ11               \ If the view type in QQ11 is not &9C (Short-range
 CMP #&9C               \ Chart), then this must be the Long-range Chart, so
 BNE witc1              \ jump to TT22 via witc1 to show the Long-range Chart

 JMP TT23               \ Otherwise this is the Short-range Chart, so jump to
                        \ TT23 to show the Short-range Chart, returning from the
                        \ subroutine using a tail call

.witc1

 JMP TT22               \ This is the Long-range Chart, so jump to TT22 to show
                        \ it, returning from the subroutine using a tail call

.witc2

 LDA QQ11               \ If the view type in QQ11 is not &97 (Inventory), then
 CMP #&97               \ jump to witc3 to keep checking for other view types
 BNE witc3

 JMP TT213              \ This is the Inventory screen, so jump to TT213 to show
                        \ it, returning from the subroutine using a tail call

.witc3

 CMP #&BA               \ If the view type in QQ11 is not &BA (Market Price),
 BNE witc4              \ then jump to witc4 to display the Status Mode screen

 LDA #&97               \ Set the view type in QQ11 to &97 (Inventory), so the
 STA QQ11               \ call to TT167 toggles this to the Market Price screen

 JMP TT167              \ Jump to TT167 to show the Market Price screen,
                        \ returning from the subroutine using a tail call

.witc4

 JMP STATUS             \ Jump to STATUS to display the Status Mode screen,
                        \ returning from the subroutine using a tail call

.witc5

 LDX #4                 \ If we get here then this is the space view, so set the
 STX VIEW               \ current space view to 4 to denote that we are
                        \ generating a new space view and fall through into
                        \ TT110 to show the front space view (at which point
                        \ VIEW will change to 0)

INCLUDE "library/common/main/subroutine/tt110.asm"
INCLUDE "library/common/main/subroutine/tt114.asm"
INCLUDE "library/common/main/subroutine/lcash.asm"
INCLUDE "library/common/main/subroutine/mcash.asm"
INCLUDE "library/common/main/subroutine/gc2.asm"

\ ******************************************************************************
\
\       Name: StartAfterLoad
\       Type: Subroutine
\   Category: Start and end
\    Summary: Start the game following a commander file load
\
\ ------------------------------------------------------------------------------
\
\ This routine is very similar to the BR1 routine.
\
\ ******************************************************************************

.StartAfterLoad

 JSR ping               \ Set the target system coordinates (QQ9, QQ10) to the
                        \ current system coordinates (QQ0, QQ1) we just loaded

 JSR TT111              \ Select the system closest to galactic coordinates
                        \ (QQ9, QQ10)

 JSR jmp                \ Set the current system to the selected system

 LDX #5                 \ We now want to copy the seeds for the selected system
                        \ in QQ15 into QQ2, where we store the seeds for the
                        \ current system, so set up a counter in X for copying
                        \ 6 bytes (for three 16-bit seeds)

.stal1

 LDA QQ15,X             \ Copy the X-th byte in QQ15 to the X-th byte in QQ2
 STA QQ2,X

 DEX                    \ Decrement the counter

 BPL stal1              \ Loop back to stal1 if we still have more bytes to copy

 INX                    \ Set X = 0 (as we ended the above loop with X = &FF)

 STX EV                 \ Set EV, the extra vessels spawning counter, to 0, as
                        \ we are entering a new system with no extra vessels
                        \ spawned

 LDA QQ3                \ Set the current system's economy in QQ28 to the
 STA QQ28               \ selected system's economy from QQ3

 LDA QQ5                \ Set the current system's tech level in tek to the
 STA tek                \ selected system's economy from QQ5

 LDA QQ4                \ Set the current system's government in gov to the
 STA gov                \ selected system's government from QQ4

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: DrawCobraMkIII
\       Type: Subroutine
\   Category: Equipment
\    Summary: Draw the Cobra Mk III on the Equip Ship screen
\
\ ******************************************************************************

.DrawCobraMkIII

 LDA #20                \ Set XC and YC so the call to DrawImageNames draws the
 STA YC                 \ Cobra Mk III at text column 2 on row 20
 LDA #2
 STA XC

 LDA #26                \ Set K = 26 so the call to DrawImageNames draws 26
 STA K                  \ tiles in each row

 LDA #5                 \ Set K+1 = 5 so the call to DrawImageNames draws 5 rows
 STA K+1                \ of tiles

 LDA #HI(cobraNames)    \ Set V(1 0) = cobraNames, so the call to DrawImageNames
 STA V+1                \ draws the Cobra Mk III
 LDA #LO(cobraNames)
 STA V

 LDA #0                 \ Set K+2 = 0, so the call to DrawImageNames copies the
 STA K+2                \ entries directly from cobraNames to the nametable
                        \ buffer without adding an offset

 JSR DrawImageNames_b4  \ Draw the Cobra Mk III at text column 2 on row 20

 JMP DrawEquipment_b6   \ Draw the currently fitted equipment onto the Cobra Mk
                        \ III image, returning from the subroutine using a tail
                        \ call

\ ******************************************************************************
\
\       Name: HighlightEquipment
\       Type: Subroutine
\   Category: Equipment
\    Summary: Highlight an item of equipment on the Equip Ship screen
\
\ ******************************************************************************

.HighlightEquipment

 LDX #2                 \ Set the font style to print in the highlight font
 STX fontStyle

 LDX XX13               \ Set X to the item number to print

 JSR PrintEquipment+2   \ Print the name and price for the equipment item in X

 LDX #1                 \ Set the font style to print in the normal font
 STX fontStyle

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: PrintEquipment
\       Type: Subroutine
\   Category: Equipment
\    Summary: Print the name and price for a specified item of equipment
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   XX13                The item number + 1 (i.e. 1 for fuel)
\
\   Q                   The highest item number on sale + 1
\
\ Other entry points:
\
\   PrintEquipment+2    Print the item number in X
\
\ ******************************************************************************

.PrintEquipment

 LDX XX13               \ Set X to the item number to print

 JSR SetupPPUForIconBar \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 STX XX13               \ Store the item number in XX13, in case we entered the
                        \ routine at PrintEquipment+2

 TXA                    \ Set A = X + 2
 CLC                    \
 ADC #2                 \ So the first item (item 1) will be on row 3, and so on

 LDX Q                  \ If Q >= 12, set A = A - 1 so we move everything up the
 CPX #12                \ screen by one line when the highest item number on
 BCC preq1              \ sale is at least 11
 SEC
 SBC #1

.preq1

 STA YC                 \ Move the text cursor to row A

 LDA #1                 \ Move the text cursor to column 1
 STA XC

 LDA languageNumber     \ If bit 1 of languageNumber is set then the chosen
 AND #%00000010         \ language is French, so jump to preq2 to skip the
 BNE preq2              \ following

 JSR TT162              \ Print a space

.preq2

 JSR TT162              \ Print a space

 LDA XX13               \ Print recursive token 104 + XX13, which will be in the
 CLC                    \ range 105 ("FUEL") to 116 ("GALACTIC HYPERSPACE ")
 ADC #104               \ so this prints the current item's name
 JSR TT27_b2

 JSR WaitForIconBarPPU  \ Wait until the PPU starts drawing the icon bar

 LDA XX13               \ If the current item number in XX13 is not 1, then it
 CMP #1                 \ is not the fuel level, so jump to preq3 to skip the
 BNE preq3              \ following (which prints the fuel level)

 LDA #' '               \ Print a space
 JSR TT27_b2

 LDA #'('               \ Print an open bracket
 JSR TT27_b2

 LDX QQ14               \ Set X to the current fuel level * 10

 SEC                    \ Set the C flag so the call to pr2+2 prints a decimal
                        \ point

 LDA #0                 \ Set the number of digits to 0 for the call to pr2+2,
                        \ so the number is not padded with spaces

 JSR pr2+2              \ Print the fuel level with a decimal point and no
                        \ padding

 LDA #195               \ Print recursive token 35 ("LIGHT YEARS")
 JSR TT27_b2

 LDA #')'               \ Print a closing bracket
 JSR TT27_b2

 LDA languageNumber     \ If bit 2 of languageNumber is set then the chosen
 AND #%00000100         \ language is French, so jump to preq3 to skip the
 BNE preq3              \ following (which prints the price)

                        \ Bit 2 of languageNumber is clear, so the chosen
                        \ language is English or German, so now we print the
                        \ price

 LDA XX13               \ Call prx-3 to set (Y X) to the price of the item with
 JSR prx-3              \ number XX13 - 1 (as XX13 contains the item number + 1)

 SEC                    \ Set the C flag so we will print a decimal point when
                        \ we print the price

 LDA #5                 \ Print the number in (Y X) to 5 digits, left-padding
 JSR TT11               \ with spaces and including a decimal point, which will
                        \ be the correct price for this item as (Y X) contains
                        \ the price * 10, so the trailing zero will go after the
                        \ decimal point (i.e. 5250 will be printed as 525.0)

 LDA #' '               \ Print a space
 JMP TT27_b2

.preq3

 LDA #' '               \ Print a space
 JSR TT27_b2

 LDA XC                 \ Loop back to print another space until XC = 24, so
 CMP #24                \ so this tabs the text cursor to column 24
 BNE preq3

 LDA XX13               \ Call prx-3 to set (Y X) to the price of the item with
 JSR prx-3              \ number XX13 - 1 (as XX13 contains the item number + 1)

 SEC                    \ Set the C flag so we will print a decimal point when
                        \ we print the price

 LDA #6                 \ Print the number in (Y X) to 6 digits, left-padding
 JSR TT11               \ with spaces and including a decimal point, which will
                        \ be the correct price for this item as (Y X) contains
                        \ the price * 10, so the trailing zero will go after the
                        \ decimal point (i.e. 5250 will be printed as 525.0)

 JMP TT162              \ Print a space and return from the subroutine using a
                        \ tail call

\ ******************************************************************************
\
\       Name: MoveEquipmentUp
\       Type: Subroutine
\   Category: Equipment
\    Summary: Move the currently selected item up the list of equipment
\
\ ******************************************************************************

.MoveEquipmentUp

 JSR PrintEquipment     \ Print the name and price for the equipment item in
                        \ XX13

 LDA XX13               \ Set A = XX13 - 1, so A contains the item number above
 SEC                    \ the currently selected item in the equipment list
 SBC #1

 BNE equp1              \ If XX13 is non-zero then we have not just tried to
                        \ move off the top of the list, so jump to equp1 to skip
                        \ the following instruction

 LDA #1                 \ Set A = 1 to set the currently selected item to the
                        \ first item in the list, so we don't go past the top
                        \ of the list

.equp1

 STA XX13               \ Store the new item number in XX13, so we move up the
                        \ equipment list

                        \ Fall through into UpdateEquipment to highlight the
                        \ newly chosen item of equipment, update the Cobra Mk
                        \ III, redraw the screen and rejoin the main EQSHP
                        \ routine to continue checking for button presses

\ ******************************************************************************
\
\       Name: UpdateEquipment
\       Type: Subroutine
\   Category: Equipment
\    Summary: Highlight the newly chosen item of equipment, update the Cobra Mk
\             III, redraw the screen and rejoin the main EQSHP routine
\
\ ******************************************************************************

.UpdateEquipment

 JSR HighlightEquipment \ Highlight the item of equipment in XX13

 JSR DrawEquipment_b6   \ Draw the currently fitted equipment onto the Cobra Mk
                        \ III image

 JSR DrawScreenInNMI    \ Configure the NMI handler to draw the screen, so the
                        \ screen gets updated

 JSR WaitForPPUToFinish \ Wait until both bitplanes of the screen have been
                        \ sent to the PPU, so the screen is fully updated and
                        \ there is no more data waiting to be sent to the PPU

 JMP equi1              \ Rejoin the main EQSHP routine at equi1 to continue
                        \ checking for button presses

\ ******************************************************************************
\
\       Name: MoveEquipmentDown
\       Type: Subroutine
\   Category: Equipment
\    Summary: Move the currently selected item down the list of equipment
\
\ ******************************************************************************

.MoveEquipmentDown

 JSR PrintEquipment     \ Print the name and price for the equipment item in
                        \ XX13

 LDA XX13               \ Set A = XX13 + 1, so A contains the item number below
 CLC                    \ the currently selected item in the equipment list
 ADC #1

 CMP Q                  \ If A has not reached Q, which contains the number of
 BNE eqdn1              \ items in the list plus 1, then we have not fallen off
                        \ the bottom of the list, so jump to eqdn1 to skip the
                        \ following

 LDA Q                  \ Set A = Q - 1 to set the currently selected item to
 SBC #1                 \ the bottom item in the list, so we don't go past the
                        \ bottom of the list (the subtraction works because we
                        \ just passed through a BNE, so the comparison was
                        \ equal which sets the C flag)

.eqdn1

 STA XX13               \ Store the new item number in XX13, so we move down the
                        \ equipment list

 JMP UpdateEquipment    \ Jump up to UpdateEquipment to highlight the newly
                        \ chosen item of equipment, update the Cobra Mk III,
                        \ redraw the screen and rejoin the main EQSHP routine to
                        \ continue checking for button presses

\ ******************************************************************************
\
\       Name: xEquipShip
\       Type: Variable
\   Category: Equipment
\    Summary: The text column for the Equip Ship title for each language
\
\ ******************************************************************************

.xEquipShip

 EQUB 12                \ English

 EQUB 8                 \ German

 EQUB 10                \ French

INCLUDE "library/common/main/subroutine/eqshp.asm"
INCLUDE "library/common/main/subroutine/dn.asm"
INCLUDE "library/common/main/subroutine/eq.asm"
INCLUDE "library/common/main/subroutine/prx.asm"

\ ******************************************************************************
\
\       Name: PrintLaserView
\       Type: Subroutine
\   Category: Equipment
\    Summary: Print the name of a laser view in the laser-buying popup, filled
\             to the right by the correct number of spaces to fill the popup
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   Y                   The number of the laser view:
\
\                         * 0 = front
\                         * 1 = rear
\                         * 2 = left
\                         * 3 = right
\
\ Returns:
\
\   Y                   Y is preserved
\
\ ******************************************************************************

.PrintLaserView

 LDA #12                \ Move the text cursor to column 12
 STA XC

 TYA                    \ Store Y on the stack so we can retrieve it at the end
 PHA                    \ of the subroutine

 CLC                    \ Move the text cursor to row Y + 8, so we print the
 ADC #8                 \ view on row 8 (front) to 11 (right)
 STA YC

 JSR TT162              \ Print a space

 LDA languageNumber     \ If either bit 1 or bit 2 of languageNumber is set then
 AND #%00000110         \ the chosen language is German or French, so jump to
 BNE lasv1              \ lasv1 to skip the following

 JSR TT162              \ The chosen language is English, so print a space

.lasv1

 PLA                    \ Set A to the argument Y, which we stored on the stack
 PHA                    \ above

 CLC                    \ Print recursive token 96 + A, which will print from 96
 ADC #96                \ ("FRONT") through to 99 ("RIGHT")
 JSR TT27_b2

.lasv2

 JSR TT162              \ Print a space

 LDA XC                 \ Keep printing spaces until we reach the column given
 LDX languageIndex      \ in the xLaserView table for the chosen language, so we
 CMP xLaserView,X       \ blank out the rest of the line to the edge of the
 BNE lasv2              \ popup (so the popup covers what's underneath it)

 PLA                    \ Retrieve Y from the stack so it is unchanged by the
 TAY                    \ subroutine call

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: xLaserView
\       Type: Variable
\   Category: Equipment
\    Summary: The text column of the right edge of the laser-buying popup, so
\             the popup gets filled with spaces and covers what's underneath it
\
\ ******************************************************************************

.xLaserView

 EQUB 21                \ English

 EQUB 21                \ German

 EQUB 22                \ French

 EQUB 21                \ There is no fourth language, so this byte is ignored

\ ******************************************************************************
\
\       Name: HighlightLaserView
\       Type: Subroutine
\   Category: Equipment
\    Summary: Highlight 
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   Y                   The number of the laser view:
\
\                         * 0 = front
\                         * 1 = rear
\                         * 2 = left
\                         * 3 = right
\
\ Returns:
\
\   Y                   Y is preserved
\
\ ******************************************************************************

.HighlightLaserView

 LDA #2                 \ Set the font style to print in the highlight font
 STA fontStyle

 JSR PrintLaserView     \ Print the name of the laser view specified in Y at the
                        \ correct on-screen position for the popup menu

 LDA #1                 \ Set the font style to print in the normal font
 STA fontStyle

 TYA                    \ Store Y on the stack so we can retrieve it at the end
 PHA                    \ of the subroutine

 JSR DrawScreenInNMI    \ Configure the NMI handler to draw the screen, so the
                        \ screen gets updated

 JSR WaitForPPUToFinish \ Wait until both bitplanes of the screen have been
                        \ sent to the PPU, so the screen is fully updated and
                        \ there is no more data waiting to be sent to the PPU

 PLA                    \ Retrieve Y from the stack so it is unchanged by the
 TAY                    \ subroutine call

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: popupWidth
\       Type: Variable
\   Category: Equipment
\    Summary: The width of the popup that shows the views available for
\             installing lasers in the Equipment screen
\
\ ******************************************************************************

.popupWidth

 EQUB 10                \ English

 EQUB 10                \ German

 EQUB 11                \ French

 EQUB 10                \ There is no fourth language, so this byte is ignored

\ ******************************************************************************
\
\       Name: qv
\       Type: Subroutine
\   Category: Equipment
\    Summary: Print a popup menu of the four space views, for buying lasers
\
\ ------------------------------------------------------------------------------
\
\ Returns:
\
\   X                   The chosen view number (0-3)
\
\ ******************************************************************************

.qv

 JSR SetupPPUForIconBar \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA controller1Leftx8  \ If the left button, right button or A button is being
 ORA controller1Rightx8 \ pressed, loop back to qv until they are released
 ORA controller1A
 BMI qv

 LDY #3                 \ We now print a popup menu showing all four views, so
                        \ set a view counter in Y, starting with view 3 (right)

.vpop1

 JSR PrintLaserView     \ Print the name of the laser view specified in Y at the
                        \ correct on-screen position for the popup menu

 DEY                    \ Decrement the view counter in Y

 BNE vpop1              \ Loop back to print the next view until we have printed
                        \ all four view names in the popup

                        \ Next, we highlight the first view (front) as by this
                        \ point Y = 0

 LDA #2                 \ Set the font style to print in the highlight font
 STA fontStyle

 JSR PrintLaserView     \ Print the name of the laser view specified in Y at the
                        \ correct on-screen position for the popup menu

 LDA #1                 \ Set the font style to print in the normal font
 STA fontStyle

                        \ We now draw a box around the list of views to make it
                        \ look like a popup menu

 LDA #11                \ Move the text cursor to column 11
 STA XC

 STA K+2                \ Set K+2 = 11 to pass to DrawSmallBox as the text row
                        \ on which to draw the top-left corner of the small box

 LDA #7                 \ Move the text cursor to row 7
 STA YC

 STA K+3                \ Set K+3 = 7 to pass to DrawSmallBox as the text column
                        \ on which to draw the top-left corner of the small box

 LDX languageIndex      \ Set K to the correct width for the laser view popup in
 LDA popupWidth,X       \ the chosen language, to pass to DrawSmallBox as the
 STA K                  \ width of the small box

 LDA #6                 \ Set K+1 = 6 to pass to DrawSmallBox as the height of
 STA K+1                \ the small box

 JSR DrawSmallBox_b3    \ Draw a box around the popup, with the top-left corner
                        \ at (7, 11), a height of 6 rows, and the correct width
                        \ for the chosen language

 JSR DrawScreenInNMI    \ Configure the NMI handler to draw the screen, so the
                        \ screen gets updated

                        \ The popup menu is now on-screen, so now we manage the
                        \ process of making a choice

 LDY #0                 \ We use Y to keep track of the highlighted view, which
                        \ we set to the front view above, so set Y = 0 to
                        \ reflect this

.vpop2

 JSR SetupPPUForIconBar \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA controller1Up      \ If the up button is not being pressed, jump to vpop4
 BPL vpop4              \ to move on to the next button check

                        \ If we get here then we need to move the highlight up
                        \ the menu, wrapping around if we go off the top

 JSR PrintLaserView     \ Print the name of the laser view specified in Y at the
                        \ correct on-screen position for the popup menu, to
                        \ remove the highlight from the current selection

 DEY                    \ Decrement Y to move the number of the selected view up
                        \ the menu

 BPL vpop3              \ If the view number is positive when we have not gone
                        \ off the top of the menu, so jump to vpop3 to skip the
                        \ following instruction

 LDY #3                 \ We just moved past the top of the menu, so set Y to 3
                        \ to move the selection to the bottom entry in the menu
                        \ (the right view)

.vpop3

 JSR HighlightLaserView \ Highlight the Y-th entry in the popup menu, to reflect
                        \ the new choice

.vpop4

 LDA controller1Down    \ If the down button is not being pressed, jump to vpop6
 BPL vpop6              \ to move on to the next button check

                        \ If we get here then we need to move the highlight down
                        \ the menu, wrapping around if we go off the bottom

 JSR PrintLaserView     \ Print the name of the laser view specified in Y at the
                        \ correct on-screen position for the popup menu, to
                        \ remove the highlight from the current selection

 INY                    \ Increment Y to move the number of the selected view
                        \ down the menu

 CPY #4                 \ If Y is not 4 then we have not gone off the bottom of
 BNE vpop5              \ the menu, so jump to vpop5 to skip the following
                        \ instruction

 LDY #0                 \ We just moved past the bottom of the menu, so set Y to
                        \ 0 to move the selection to the top entry in the menu
                        \ (the front view)

.vpop5

 JSR HighlightLaserView \ Highlight the Y-th entry in the popup menu, to reflect
                        \ the new choice

.vpop6

 LDA controller1A       \ If the A button is being pressed, jump to vpop7 to
 BMI vpop7              \ return the highlighted view as the chosen laser view

 LDA iconBarChoice      \ If iconBarChoice = 0 then nothing has been chosen on
 BEQ vpop2              \ the icon bar (if it had, iconBarChoice would contain
                        \ the number of the chosen icon bar button), so loop
                        \ back to vpop2 to keep processing the popup keys

                        \ If we get here then either a choice has been made on
                        \ the icon bar during NMI and the number of the icon bar
                        \ button is in iconBarChoice, or the Start button has
                        \ been pressed and iconBarChoice is 80

 CMP #80                \ If iconBarChoice = 80 then the Start button has been
 BNE vpop7              \ pressed to pause the game, so if this is not the case,
                        \ then a different icon bar option has been chosen, so
                        \ jump to vpop7 to return from the subroutine and abort
                        \ the laser purchase

                        \ If we get here then iconBarChoice = 80, which means
                        \ the Start button has been pressed to pause the game

 LDA #0                 \ Set iconBarChoice = 0 to clear the pause button press
 STA iconBarChoice      \ so we don't simply re-enter the pause when we resume 

 JSR PauseGame_b6       \ Pause the game and process choices from the pause menu
                        \ until the game is unpaused by another press of Start

 JMP vpop2              \ Jump back to vpop2 to pick up where we left off and go
                        \ back to processing the popup choice

.vpop7

 TYA                    \ Copy the number of the highlighted laser view from Y
 TAX                    \ into X, so we can return the choice in X

 RTS                    \ Return from the subroutine

INCLUDE "library/enhanced/main/subroutine/refund.asm"
INCLUDE "library/common/main/variable/prxs.asm"

\ ******************************************************************************
\
\       Name: SetSelectedSeeds
\       Type: Subroutine
\   Category: Universe
\    Summary: Set the seeds for the selected system in QQ15 to the seeds in the
\             safehouse
\
\ ******************************************************************************

.SetSelectedSeeds

 LDX #5                 \ We now want to copy the seeds for the selected system
                        \ from safehouse into QQ15, where we store the seeds for
                        \ the selected system, so set up a counter in X for
                        \ copying six bytes (for three 16-bit seeds)

.safe1

 LDA safehouse,X        \ Copy the X-th byte in safehouse to the X-th byte in
 STA QQ15,X             \ QQ15

 DEX                    \ Decrement the counter

 BPL safe1              \ Loop back until we have copied all six bytes

INCLUDE "library/common/main/subroutine/cpl.asm"
INCLUDE "library/common/main/subroutine/cmn.asm"
INCLUDE "library/common/main/subroutine/ypl.asm"
INCLUDE "library/common/main/subroutine/tal.asm"
INCLUDE "library/common/main/subroutine/fwl.asm"

\ ******************************************************************************
\
\       Name: Print4Spaces
\       Type: Subroutine
\   Category: Text
\    Summary: Print four spaces
\
\ ******************************************************************************

.Print4Spaces

 JSR Print2Spaces       \ Print two spaces

                        \ Fall through into Print2Spaces to print another two
                        \ newlines

\ ******************************************************************************
\
\       Name: Print2Spaces
\       Type: Subroutine
\   Category: Text
\    Summary: Print two spaces
\
\ ******************************************************************************

.Print2Spaces

 JSR TT162              \ Print two spaces, returning from the subroutin using a
 JMP TT162              \ tail call

\ ******************************************************************************
\
\       Name: ypls
\       Type: Subroutine
\   Category: Text
\    Summary: Print the current system name
\
\ ******************************************************************************

.ypls

 JMP ypl                \ Jump to ypl to print the current system name and
                        \ return from the subroutine using a tail call

INCLUDE "library/common/main/subroutine/csh.asm"
INCLUDE "library/common/main/subroutine/plf.asm"
INCLUDE "library/common/main/subroutine/tt68.asm"
INCLUDE "library/common/main/subroutine/tt73.asm"

\ ******************************************************************************
\
\       Name: tals
\       Type: Subroutine
\   Category: Text
\    Summary: Print the current galaxy number
\
\ ******************************************************************************

.tals

 JMP tal                \ Jump to tal to print the current galaxy number and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: PrintCtrlCode
\       Type: Subroutine
\   Category: Text
\    Summary: Print a control code (in the range 0 to 9)
\
\ ******************************************************************************

.PrintCtrlCode

 TXA                    \ Copy the token number from X to A. We can then keep
                        \ decrementing X and testing it against zero, while
                        \ keeping the original token number intact in A; this
                        \ effectively implements a switch statement on the
                        \ value of the token

 BEQ csh                \ If token = 0, this is control code 0 (current amount
                        \ of cash and newline), so jump to csh to print the
                        \ amount of cash and return from the subroutine using
                        \ a tail call

 DEX                    \ If token = 1, this is control code 1 (current galaxy
 BEQ tals               \ number), so jump to tal via tals to print the galaxy
                        \ number and return from the subroutine using a tail
                        \ call

 DEX                    \ If token = 2, this is control code 2 (current system
 BEQ ypls               \ name), so jump to ypl via ypls to print the current
                        \ system name  and return from the subroutine using a
                        \ tail call

 DEX                    \ If token > 3, skip the following instruction
 BNE P%+5

 JMP cpl                \ This token is control code 3 (selected system name)
                        \ so jump to cpl to print the selected system name
                        \ and return from the subroutine using a tail call

 DEX                    \ If token <> 4, skip the following instruction
 BNE P%+5

 JMP cmn                \ This token is control code 4 (commander name) so jump
                        \ to cmn to print the commander name and return from the
                        \ subroutine using a tail call

 DEX                    \ If token = 5, this is control code 5 (fuel, newline,
 BEQ fwls               \ cash, newline), so jump to fwl via fwls to print the
                        \ fuel level and return from the subroutine using a tail
                        \ call

 DEX                    \ If token > 6, skip the following three instructions
 BNE ptok2

 LDA #%10000000         \ This token is control code 6 (switch to Sentence
 STA QQ17               \ Case), so set bit 7 of QQ17 to switch to Sentence Case

.ptok1

 RTS                    \ Return from the subroutine

.ptok2

 DEX                    \ If token = 7, this is control code 7 (beep), so jump
 BEQ ptok1              \ to ptok1 to return from the subroutine

 DEX                    \ If token > 8, jump to ptok3
 BNE ptok3

 STX QQ17               \ This is control code 8, so set QQ17 = 0 to switch to
                        \ ALL CAPS (we know X is zero as we just passed through
                        \ a BNE)

 RTS                    \ Return from the subroutine

.ptok3

                        \ If we get here then token > 8, so this is control code
                        \ 9 (print a colon then tab to column 22 or 23)

 JSR TT73               \ Print a colon

 LDA languageNumber     \ If bit 1 of languageNumber is set, then the chosen
 AND #%00000010         \ language is German, so jump to ptok4 to move the text
 BNE ptok4              \ cursor to column 23

 LDA #22                \ Bit 1 of languageNumber is clear, so the chosen
 STA XC                 \ language is English or French, so move the text cursor
                        \ to column 22

 RTS                    \ Return from the subroutine

.ptok4

 LDA #23                \ Move the text cursor to column 23
 STA XC

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: fwls
\       Type: Subroutine
\   Category: Text
\    Summary: Print fuel and cash levels
\
\ ******************************************************************************

.fwls

 JMP fwl                \ Jump to fwl to print the fuel and cash levels, and
                        \ return from the subroutine using a tail call

INCLUDE "library/common/main/subroutine/sos1.asm"
INCLUDE "library/common/main/subroutine/solar.asm"
INCLUDE "library/common/main/subroutine/nwstars.asm"
INCLUDE "library/common/main/subroutine/nwq.asm"
INCLUDE "library/common/main/subroutine/wpshps.asm"
INCLUDE "library/common/main/subroutine/shd.asm"
INCLUDE "library/common/main/subroutine/dengy.asm"
INCLUDE "library/common/main/subroutine/compas.asm"
INCLUDE "library/common/main/subroutine/sp1.asm"
INCLUDE "library/common/main/subroutine/sp2.asm"
INCLUDE "library/common/main/subroutine/sps4.asm"
INCLUDE "library/common/main/subroutine/oops.asm"
INCLUDE "library/common/main/subroutine/nwsps.asm"
INCLUDE "library/common/main/subroutine/nwshp.asm"
INCLUDE "library/common/main/subroutine/nws1.asm"
INCLUDE "library/common/main/subroutine/ks3.asm"
INCLUDE "library/common/main/subroutine/ks1.asm"
INCLUDE "library/common/main/subroutine/ks4.asm"
INCLUDE "library/common/main/subroutine/ks2.asm"

\ ******************************************************************************
\
\       Name: CopyShipDataToINWK
\       Type: Subroutine
\   Category: Universe
\    Summary: Copy the ship's data block from INF to INWK
\
\ ******************************************************************************

.CopyShipDataToINWK

 JSR SetupPPUForIconBar \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDY #NI%-1             \ There are NI% bytes in each ship data block (and in
                        \ the INWK workspace, so we set a counter in Y so we can
                        \ loop through them

.cink1

 LDA (INF),Y            \ Load the Y-th byte of INF and store it in the Y-th
 STA INWK,Y             \ byte of INWK

 DEY                    \ Decrement the loop counter

 BPL cink1              \ Loop back for the next byte until we have copied the
                        \ last byte from INF to INWK

INCLUDE "library/common/main/subroutine/killshp.asm"
INCLUDE "library/common/main/subroutine/abort.asm"
INCLUDE "library/common/main/subroutine/abort2.asm"

\ ******************************************************************************
\
\       Name: YESNO
\       Type: Subroutine
\   Category: Controllers
\    Summary: Display "YES" or "NO" and wait until one is chosen
\
\ ------------------------------------------------------------------------------
\
\ Returns:
\
\   A                   The result:
\
\                         * 1 if "YES" was chosen
\
\                         * 2 if "NO" was chosen
\
\ ******************************************************************************

.YESNO

 LDA fontStyle          \ Store the current font style on the stack, so we can
 PHA                    \ restore it when we return from the subroutine

 LDA #2                 \ Set the font style to print in the highlight font
 STA fontStyle

 LDA #1                 \ Push a value of 1 onto the stack, so the following
 PHA                    \ prints extended token 1 ("YES")

.yeno1

 JSR CLYNS              \ Clear the bottom three text rows of the upper screen,
                        \ and move the text cursor to column 1 on row 21, i.e.
                        \ the start of the top row of the three bottom rows

 LDA #15                \ Move the text cursor to column 15
 STA XC

 PLA                    \ Print the extended token whose number is on the stack,
 PHA                    \ so this will be "YES" (token 1) or "NO" (token 2)
 JSR DETOK_b2

 JSR DrawMessageInNMI   \ Configure the NMI to display the YES/NO message that
                        \ we just printed

 LDA controller1A       \ If "A" is being pressed on the controller, jump to
 BMI yeno3              \ to record the choice

 LDA controller1Up      \ If neither the up nor down arrow is being pressed on
 ORA controller1Down    \ the controller, jump to yeno2 to pause and loop back
 BPL yeno2              \ to keep waiting for a choice to be made

                        \ If we get here then either the up or down arrow is
                        \ being pressed, so we toggle the on-screen choice
                        \ between "YES" and "NO"

 PLA                    \ Flip the value on the top of the stack between 1 and 2
 EOR #3                 \ by EOR'ing with 3, which toggles the token between
 PHA                    \ "YES" and "NO"

.yeno2

 LDY #8                 \ Wait until eight NMI interrupts have passed (i.e. the
 JSR DELAY              \ next eight VBlanks)

 JMP yeno1              \ Loop back to print "YES" or NO" and wait for a choice

.yeno3

 LDA #0                 \ ???
 STA pressedButton

 STA controller1A       \ Reset the key logger for the controller "A" button as
                        \ we have consumed the key press

 PLA                    \ Set X to the value from the top of the stack, which
 TAX                    \ will be 1 for "YES" or 2 for "NO", giving us our
                        \ result to return

 PLA                    \ Restore the font style that we stored on the stack
 STA fontStyle          \ so it's unchanged by the routine

 TXA                    \ Copy X to A, so we return the result in both A and X

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: ReadDirectionalPad
\       Type: Subroutine
\   Category: Controllers
\    Summary: ???
\
\ ******************************************************************************

.ReadDirectionalPad

 LDA QQ11
 BNE CAD2E

 JSR DOKEY
 TXA
 RTS

.CAD2E

 JSR DOKEY
 LDX #0
 LDY #0
 LDA controller1B
 BMI CAD52
 LDA controller1Leftx8
 BPL CAD40
 DEX

.CAD40

 LDA controller1Rightx8
 BPL CAD46
 INX

.CAD46

 LDA controller1Up
 BPL CAD4C
 INY

.CAD4C

 LDA controller1Down
 BPL CAD52
 DEY

.CAD52

 LDA pressedButton
 RTS

INCLUDE "library/enhanced/main/subroutine/there.asm"
INCLUDE "library/common/main/subroutine/reset.asm"
INCLUDE "library/common/main/subroutine/res2.asm"
INCLUDE "library/common/main/subroutine/zinf.asm"

\ ******************************************************************************
\
\       Name: SetScreenHeight
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Set the screen height variables to the specified height
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The y-coordinate of the centre of the screen (i.e. half
\                       the screen height)
\
\ ******************************************************************************

.SetScreenHeight

 STA halfScreenHeight   \ Store the half-screen height in halfScreenHeight

 ASL A                  \ Double the half-screen height in A to get the full
                        \ screen height, while setting the C flag to bit 7 of
                        \ the original argument
                        \
                        \ This routine is only ever called with A set to either
                        \ 72 or 77, so the C flag is never set

 STA screenHeight       \ Store the full screen height in screenHeight

 SBC #0                 \ Set the value of Yx2M1 as follows:
 STA Yx2M1              \
                        \   * If the C flag is set: Yx2M1 = screenHeight
                        \
                        \   * If the C flag is clear: Yx2M1 = screenHeight - 1
                        \
                        \ This routine is only ever called with A set to either
                        \ 72 or 77, so the C flag is never set, so we always set
                        \ Yx2M1 = screenHeight - 1

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/msblob.asm"
INCLUDE "library/common/main/subroutine/main_game_loop_part_1_of_6.asm"
INCLUDE "library/common/main/subroutine/main_game_loop_part_2_of_6.asm"
INCLUDE "library/common/main/subroutine/main_game_loop_part_3_of_6.asm"
INCLUDE "library/common/main/subroutine/main_game_loop_part_4_of_6.asm"
INCLUDE "library/common/main/subroutine/main_game_loop_part_5_of_6.asm"
INCLUDE "library/common/main/subroutine/main_game_loop_part_6_of_6.asm"

\ ******************************************************************************
\
\       Name: LB079
\       Type: Variable
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.LB079

 EQUB 5, 5, 5, 6                              ; B079: 05 05 05... ...

INCLUDE "library/common/main/subroutine/tt102.asm"
INCLUDE "library/common/main/subroutine/bad.asm"

\ ******************************************************************************
\
\       Name: FAROF
\       Type: Subroutine
\   Category: Maths (Geometry)
\    Summary: Compare x_hi, y_hi and z_hi with 224
\
\ ------------------------------------------------------------------------------
\
\ Compare x_hi, y_hi and z_hi with 224, and set the C flag if all three <= 224,
\ otherwise clear the C flag.
\
\ Returns:
\
\   C flag              Set if x_hi <= 224 and y_hi <= 224 and z_hi <= 224
\
\                       Clear otherwise (i.e. if any one of them are bigger than
\                       224)
\
\ ******************************************************************************

.FAROF

 LDA INWK+2             \ If any of x_sign, y_sign or z_sign are non-zero
 ORA INWK+5             \ (ignoring the sign in bit 7), then jump to faro2 to
 ORA INWK+8             \ return the C flag clear, to indicate that one of x, y
 ASL A                  \ and z is greater that 224
 BNE faro2

 LDA #224               \ If x_hi > 224, jump to faro1 to return the C flag
 CMP INWK+1             \ clear
 BCC faro1

 CMP INWK+4             \ If y_hi > 224, jump to faro1 to return the C flag
 BCC faro1              \ clear

 CMP INWK+7             \ If z_hi > 224, clear the C flag, otherwise set it

.faro1

                        \ By this point the C flag is clear if any of x_hi, y_hi
                        \ or z_hi are greater than 224, otherwise all three are
                        \ less than or equal to 224 and the C flag is set

 RTS                    \ Return from the subroutine

.faro2

 CLC                    \ Clear the C flag to indicate that at least one of the
                        \ axes is greater than 224

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/mas4.asm"

\ ******************************************************************************
\
\       Name: CheckForPause
\       Type: Subroutine
\   Category: Icon bar
\    Summary: Pause the game if the pause button (Start) is pressed
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The button number to check to see if it is the pause
\                       button (a value of 80 indicates the pause button)
\
\ Returns:
\
\   C flag              The status of the pause button:
\
\                         * Clear if the pause button is not being pressed
\
\                         * Set if the pause button is being pressed, in which
\                           case we return from the subroutine after pausing the
\                           the game, processing any choices from the icon bar,
\                           and unpausing the game when Start is pressed again
\
\ Other entry points:
\
\   CheckForPause-3     Set A to the number of the icon bar button in
\                       iconBarChoice so we check whether the pause button is
\                       being pressed
\
\ ******************************************************************************

 LDA iconBarChoice      \ Set A to the number of the icon bar button that has
                        \ been chosen from the icon bar (for when this routine
                        \ is called via the CheckForPause-3 entry point)

.CheckForPause

 CMP #80                \ If iconBarChoice = 80 then the Start button has been
 BNE cpse1              \ pressed to pause the game, so if this is not the case,
                        \ jump to cpse1 to return from the subroutine with the
                        \ C flag clear and without pausing

 LDA #0                 \ Set iconBarChoice = 0 to clear the pause button press
 STA iconBarChoice      \ so we don't simply re-enter the pause when we resume 

 JSR PauseGame_b6       \ Pause the game and process choices from the pause menu
                        \ until the game is unpaused by another press of Start

 SEC                    \ Set the C flag to indicate that the game was paused

 RTS                    \ Return from the subroutine

.cpse1

 CLC                    \ Clear the C flag to indicate that the game was not
                        \ paused

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/death.asm"

\ ******************************************************************************
\
\       Name: ShowStartScreen
\       Type: Subroutine
\   Category: Start and end
\    Summary: ???
\
\ ******************************************************************************

.ShowStartScreen

 LDA #&FF               \ Set soundVar07 = &FF ???
 STA soundVar07

 LDA #&80               \ Set soundVar08 = &80 ???
 STA soundVar08

 LDA #&1B               \ Set soundVar09 = &1B ???
 STA soundVar09

 LDA #&34               \ Set soundVar0A = &34 ???
 STA soundVar0A

 JSR ResetMusic         \ Reset the current tune to 0 and stop the music

 JSR JAMESON_b6         \ Set the current position to the default "JAMESON"
                        \ commander

 JSR ResetOptions       \ Reset the game options to their default values

 LDA #1                 \ Set the font style to print in the normal font
 STA fontStyle

 LDX #&FF               \ Set the old view type in QQ11a to &FF (Segue screen
 STX QQ11a              \ from Title screen to Demo)

 TXS                    \ Set the stack pointer to &01FF, which is the standard
                        \ location for the 6502 stack, so this instruction
                        \ effectively resets the stack

 JSR RESET              \ Call RESET to initialise most of the game variables

 JSR ChooseLanguage_b6  \ Show the Start screen and process the language choice

                        \ Fall through into DEATH2 to show the title screen and
                        \ start the game

\ ******************************************************************************
\
\       Name: DEATH2
\       Type: Subroutine
\   Category: Start and end
\    Summary: Reset most of the game and restart from the title screen
\
\ ------------------------------------------------------------------------------
\
\ This routine is called following death, and when the game is quit by pressing
\ ESCAPE when paused.
\
\ ******************************************************************************

.DEATH2

 LDX #&FF               \ Set the stack pointer to &01FF, which is the standard
 TXS                    \ location for the 6502 stack, so this instruction
                        \ effectively resets the stack

 INX                    \ Set chartToShow = 0 ???
 STX chartToShow

 JSR RES2               \ Reset a number of flight variables and workspaces

 LDA #5                 \ Set the icon par pointer to button 5 (which is the
 JSR SetIconBarPointer  \ sixth button of 12, just before the halfway point)

 JSR U%                 \ Call U% to clear the key logger

 JSR DrawTitleScreen    \ Draw the title screen with the rotating ships,
                        \ returning when a key is pressed

 LDA controller1Select  \ If Select, Start, A and B are all pressed at the same
 AND controller1Start   \ time on controller 1, jump to dead2 to skip the demo
 AND controller1A       \ and show the credits scrolltext instead
 AND controller1B
 BNE dead2

 LDA controller1Select  \ If Select is pressed on either controller, jump to
 ORA controller2Select  \ dead3 to skip the demo and start the game straight
 BNE dead3              \ away

                        \ If we get here then we start the demo

 LDA #0                 \ Store 0 on the stack, so this can be retrieved below
 PHA                    \ to pass to ShowScrollText, so the demo gets run after
                        \ the scroll text is shown

 JSR BR1                \ Reset a number of variables, ready to start a new game

 LDA #&FF               \ Set the view type in QQ11 to &FF (Segue screen from
 STA QQ11               \ Title screen to Demo)

 LDA autoPlayDemo       \ If autoPlayDemo is zero then the demo is not being
 BEQ dead1              \ autplayed, so jump to dead1 to skip the following
                        \ instruction

 JSR SetupDemoUniverse  \ The demo is running and is being autoplayed by the
                        \ computer, so call SetupDemoUniverse to set up the
                        \ local bubble for the demo

.dead1

 JSR WaitForNMI         \ Wait until the next NMI interrupt has passed (i.e. the
                        \ next VBlank)

 LDA #4                 \ Set the music to tune #4
 JSR ChooseMusic_b6

 LDA soundVar05         \ Set soundVar05 = soundVar05 + 6 ???
 CLC
 ADC #6
 STA soundVar05

 PLA                    \ Set A to the value of A that we put on the stack above
                        \ (i.e. set A = 0)

 JMP ShowScrollText_b6  \ Jump to ShowScrollText to show the scroll text and run
                        \ the demo, returning from the subroutine using a tail
                        \ call

.dead2

                        \ If we get here then we show the credits scrolltext

 JSR BR1                \ Reset a number of variables, ready to start a new game

 LDA #&FF               \ Set the view type in QQ11 to &FF (Segue screen from
 STA QQ11               \ Title screen to Demo)

 JSR WaitForNMI         \ Wait until the next NMI interrupt has passed (i.e. the
                        \ next VBlank)

 LDA #4                 \ Set the music to tune #4
 JSR ChooseMusic_b6

 LDA #2                 \ Set A = 2 to pass to ShowScrollText, so the credits
                        \ scroll text is shown instead of the demo introduction,
                        \ and to skip the demo after the scroll text

 JMP ShowScrollText_b6  \ Jump to ShowScrollText to show the scroll text and
                        \ skip the demo, returning from the subroutine using a
                        \ tail call

.dead3

                        \ If we get here then we start the game without playing
                        \ the demo

 JSR FadeToBlack_b3     \ Fade the screen to black over the next four VBlanks

                        \ Fall through into StartGame to reset the stack and go
                        \ to the docking bay (i.e. show the Status Mode screen)

\ ******************************************************************************
\
\       Name: StartGame
\       Type: Subroutine
\   Category: Start and end
\    Summary: Reset the stack and game variables, and start the game by going to
\             the docking bay
\
\ ******************************************************************************

.StartGame

 LDX #&FF               \ Set the stack pointer to &01FF, which is the standard
 TXS                    \ location for the 6502 stack, so this instruction
                        \ effectively resets the stack

 JSR BR1                \ Reset a number of variables, ready to start a new game

                        \ Fall through into the BAY routine to go to the docking
                        \ bay (i.e. show the Status Mode screen)

INCLUDE "library/common/main/subroutine/bay.asm"
INCLUDE "library/common/main/subroutine/br1_part_2_of_2.asm"

\ ******************************************************************************
\
\       Name: ChangeToView
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: ???
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The type of the new view
\
\ ******************************************************************************

.ChangeToView

 JSR TT66               \ Clear the screen and and set the view type in QQ11 to
                        \ the value of A

 JSR CopyNameBuffer0To1 \ Copy the contents of nametable buffer 0 to nametable
                        \ buffer and tell the NMI handler to send pattern
                        \ entries up to the first free tile

 JSR UpdateScreen       \ Update the screen by sending data to the PPU, either
                        \ immediately or during VBlank, depending on whether
                        \ the screen is visible

 LDA #&00               \ Set the view type in QQ11 to &00 (Space view with no
 STA QQ11               \ font loaded)

 STA QQ11a              \ Set the old view type in QQ11a to &00 (Space view with
                        \ no fonts loaded)

 STA showIconBarPointer \ Set showIconBarPointer to 0 to indicate that we should
                        \ hide the icon bar pointer

 LDA firstFreeTile      \ Tell the NMI handler to send pattern entries from the
 STA firstPatternTile   \ first free tile onwards, so we don't waste time
                        \ resending the static tiles we have already sent

 LDA #80                \ Tell the NMI handler to only clear nametable entries
 STA maxNameTileToClear \ up to tile 80 * 8 = 640 (i.e. up to the end of tile
                        \ row 19)

 LDX #8                 \ Tell the NMI handler to send nametable entries from
 STX firstNametableTile \ tile 8 * 8 = 64 onwards (i.e. from the start of tile
                        \ row 2)

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/title.asm"
INCLUDE "library/common/main/subroutine/zero.asm"
INCLUDE "library/common/main/subroutine/u_per_cent-zektran.asm"
INCLUDE "library/common/main/subroutine/mas1.asm"
INCLUDE "library/common/main/subroutine/mas2.asm"
INCLUDE "library/common/main/subroutine/mas3.asm"

\ ******************************************************************************
\
\       Name: SpawnSpaceStation
\       Type: Subroutine
\   Category: Universe
\    Summary: Add a space station to the local bubble of universe if we are
\             close enough to the station's orbit
\
\ ******************************************************************************

.SpawnSpaceStation

                        \ We now check the distance from our ship (at the
                        \ origin) towards the point where we will spawn the
                        \ space station if we are close enough
                        \
                        \ This point is calculated by starting at the planet's
                        \ centre and adding 2 * nosev, which takes us to a point
                        \ above the planet's surface, at an altitude that
                        \ matches the planet's radius
                        \
                        \ This point pitches and rolls around the planet as the
                        \ nosev vector rotates with the planet, and if our ship
                        \ is within a distance of (100 0) from this point in all
                        \ three axes, then we spawn the space station at this
                        \ point, with the station's slot facing towards the
                        \ planet, along the nosev vector
                        \
                        \ This works because in the following, we calculate the
                        \ station's coordinates one axis at a time, and store
                        \ the results in the INWK block, so by the time we have
                        \ calculated and checked all three, the ship data block
                        \ is set up with the correct spawning coordinates

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0                 \ Call MAS1 with X = 0, Y = 9 to do the following:
 LDY #9                 \
 JSR MAS1               \   (x_sign x_hi x_lo) += (nosev_x_hi nosev_x_lo) * 2
                        \
                        \   A = |x_sign|

 BNE MA23S2             \ If A > 0, jump to MA23S2 to skip the following, as we
                        \ are too far from the planet in the x-direction to
                        \ bump into a space station

 LDX #3                 \ Call MAS1 with X = 3, Y = 11 to do the following:
 LDY #11                \
 JSR MAS1               \   (y_sign y_hi y_lo) += (nosev_y_hi nosev_y_lo) * 2
                        \
                        \   A = |y_sign|

 BNE MA23S2             \ If A > 0, jump to MA23S2 to skip the following, as we
                        \ are too far from the planet in the y-direction to
                        \ bump into a space station

 LDX #6                 \ Call MAS1 with X = 6, Y = 13 to do the following:
 LDY #13                \
 JSR MAS1               \   (z_sign z_hi z_lo) += (nosev_z_hi nosev_z_lo) * 2
                        \
                        \   A = |z_sign|

 BNE MA23S2             \ If A > 0, jump to MA23S2 to skip the following, as we
                        \ are too far from the planet in the z-direction to
                        \ bump into a space station

 LDA #100               \ Call FAROF2 to compare x, y and z with 100, which will
 JSR FAROF2             \ clear the C flag if the distance to the point is < 100
                        \ or set the C flag if it is >= 100

 BCS MA23S2             \ Jump to MA23S2 if the distance to point (x, y, z) is
                        \ >= 100 (i.e. we must be near enough to the planet to
                        \ bump into a space station)

 JSR NWSPS              \ Add a new space station to our local bubble of
                        \ universe

 SEC                    \ Set the C flag to indicate that we have added the
                        \ space station

 RTS                    \ Return from the subroutine

.MA23S2

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 CLC                    \ Clear the C flag to indicate that we have not added
                        \ the space station

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/sps2.asm"
INCLUDE "library/common/main/subroutine/sps3.asm"
INCLUDE "library/common/main/subroutine/sps1.asm"
INCLUDE "library/common/main/subroutine/tas2.asm"

\ ******************************************************************************
\
\       Name: WARP
\       Type: Subroutine
\   Category: Flight
\    Summary: Process the fast-forward button to end the demo, dock instantly or
\             perform an in-system jump
\
\ ******************************************************************************

.WARP

 LDA demoInProgress     \ If the demo is not in progress, jump to warp1 to skip
 BEQ warp1              \ the following

                        \ If we get here then the demo is in progress, in which
                        \ case the fast-forward icon ends the demo and starts
                        \ the game

 JSR ResetShipStatus    \ Reset the ship's speed, hyperspace counter, laser
                        \ temperature, shields and energy banks

 JMP StartGame          \ Jump to StartGame to reset the stack and go to the
                        \ docking bay (i.e. show the Status Mode screen)

.warp1

 LDA auto               \ If the docking computer is engaged (auto is non-zero)
 AND SSPR               \ and we are inside the space station safe zone (SSPR
 BEQ warp2              \ is non-zero), then this sets A to be non-zero, so if
                        \ this is not the case, jump to warp2 to skip the
                        \ following

                        \ If we get here then the docking computer is engaged
                        \ and we are in the space station safe zone, in which
                        \ case the fast-forward button docks us instantly

 JMP GOIN               \ Go to the docking bay (i.e. show the ship hangar
                        \ screen) and return from the subroutine with a tail
                        \ call

.warp2

 JSR FastForwardJump    \ Do an in-system (faat-forward) jump and run the
                        \ distance checks

 BCS warp3              \ If the C flag is set then we are too close to the
                        \ planet or sun for any more jumps, so jump to warp3
                        \ to stop jumping

 JSR FastForwardJump    \ Do a second in-system (faat-forward) jump and run the
                        \ distance checks

 BCS warp3              \ If the C flag is set then we are too close to the
                        \ planet or sun for any more jumps, so jump to warp3
                        \ to stop jumping

 JSR FastForwardJump    \ Do a third in-system (faat-forward) jump and run the
                        \ distance checks

 BCS warp3              \ If the C flag is set then we are too close to the
                        \ planet or sun for any more jumps, so jump to warp3
                        \ to stop jumping

 JSR WaitForNMI         \ Wait until the next NMI interrupt has passed (i.e. the
                        \ next VBlank)

 JSR InSystemJump       \ Do a fourth in-system jump (faat-forward) without
                        \ doing the distance checks

.warp3

 LDA #1                 \ Set the main loop counter to 1, so the next iteration
 STA MCNT               \ through the main loop will potentially spawn ships
                        \ (see part 2 of the main game loop at me3)

 LSR A                  \ Set EV, the extra vessels spawning counter, to 0
 STA EV                 \ (the LSR produces a 0 as A was previously 1)

 JSR CheckAltitude      \ Perform an altitude check with the planet, ending the
                        \ game if we hit the ground

 LDA QQ11               \ If this is not the space view, jump to warp4 to skip
 BNE warp4              \ the updating of the space view and return from the
                        \ subroutine

 LDX VIEW               \ Set X to the current view (front, rear, left or right)

 DEC VIEW               \ Decrement the view in VIEW so the call to LOOK1 thinks
                        \ the view has changed, so it will update the screen

 JMP LOOK1              \ Jump to LOOK1 to initialise the view in X, returning
                        \ from the subroutine using a tail call

.warp4

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: FastForwardJump
\       Type: Subroutine
\   Category: Flight
\    Summary: Try to do an in-system jump
\
\ ------------------------------------------------------------------------------
\
\ Returns:
\
\   C flag              The status at the end of the jump:
\
\                         * Clear if the jump ends with us nowhere near the
\                           planet or sun
\
\                         * Set if the jump ends with us being too close to the
\                           planet or sun
\
\ ******************************************************************************

.FastForwardJump

 JSR WaitForNMI         \ Wait until the next NMI interrupt has passed (i.e. the
                        \ next VBlank)

 JSR InSystemJump       \ Call InSystemJump to do an in-system jump

                        \ Fall through into CheckDistances to work out if we are
                        \ close to the planet or sun, returning the result in
                        \ the C flag accordingly

\ ******************************************************************************
\
\       Name: CheckDistances
\       Type: Subroutine
\   Category: Flight
\    Summary: Check the distance to the planet and sun
\
\ ------------------------------------------------------------------------------
\
\ Other entry points:
\
\   CheckDistances+2
\
\ ******************************************************************************

.CheckDistances

 LDA #&80

 LSR A
 STA T
 LDY #0
 JSR cdis1
 BCS cdis7
 LDA SSPR
 BNE cdis7
 LDY #&2A

.cdis1

 LDA K%+2,Y
 ORA K%+5,Y
 ASL A
 BNE cdis5
 LDA K%+8,Y
 LSR A
 BNE cdis5
 LDA K%+7,Y
 ROR A
 SEC
 SBC #&20
 BCS cdis2
 EOR #&FF
 ADC #1

.cdis2

 STA K+2
 LDA K%+1,Y
 LSR A
 STA K
 LDA K%+4,Y
 LSR A
 STA K+1
 CMP K
 BCS cdis3
 LDA K

.cdis3

 CMP K+2
 BCS cdis4
 LDA K+2

.cdis4

 STA SC
 LDA K
 CLC
 ADC K+1
 ADC K+2
 SEC
 SBC SC
 LSR A
 LSR A
 STA SC+1
 LSR A
 LSR A
 ADC SC+1
 ADC SC
 CMP T
 BCC cdis6

.cdis5

 CLC
 RTS

.cdis6

 SEC

.cdis7

 RTS

\ ******************************************************************************
\
\       Name: InSystemJump
\       Type: Subroutine
\   Category: Flight
\    Summary: Perform an in-system jump
\
\ ******************************************************************************

.InSystemJump

 LDY #&20

.loop_CB667

 JSR ChargeShields
 DEY
 BNE loop_CB667
 LDX #0
 STX GNTMP

.CB672

 STX XSAV
 LDA FRIN,X
 BEQ CB6A7
 BMI CB686
 JSR GINF

 JSR CopyShipDataToINWK \ Copy the ship's data block from INF to INWK

 LDX XSAV
 JMP CB672

.CB686

 JSR GINF
 LDA #&80
 STA S
 LSR A
 STA R
 LDY #7
 LDA (XX19),Y
 STA P
 INY
 LDA (XX19),Y
 JSR ADD
 STA (XX19),Y
 DEY
 TXA
 STA (XX19),Y
 LDX XSAV
 INX
 BNE CB672

.CB6A7

 RTS

INCLUDE "library/common/main/subroutine/dokey.asm"

\ ******************************************************************************
\
\       Name: PrintMessage
\       Type: Subroutine
\   Category: Text
\    Summary: Print a message in the middle of the screen (used for "GAME OVER"
\             and demo missile messages only)
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The text token to be printed
\
\   Y                   The length of time to leave the message on-screen
\
\ ******************************************************************************

.PrintMessage

 PHA                    \ Store A on the stack so we can restore it after the
                        \ following

 STY DLY                \ Set the message delay in DLY to Y

 LDA #%11000000         \ Set the DTW4 flag to %11000000 (justify text, buffer
 STA DTW4               \ entire token including carriage returns)

 LDA #0                 \ Set DTW5 = 0, to reset the size of the message in the
 STA DTW5               \ text buffer at BUF

 PLA                    \ Restore A from the stack

 JSR ex_b2              \ Print the recursive token in A

 JMP StoreMessage       \ Jump to StoreMessage to copy the message from the
                        \ justified text buffer in BUF into the message buffer
                        \ at messageBuffer, returning ffom the subroutine using
                        \ a tail call

INCLUDE "library/common/main/subroutine/mess.asm"
INCLUDE "library/common/main/subroutine/mes9.asm"

\ ******************************************************************************
\
\       Name: StoreMessage
\       Type: Subroutine
\   Category: Text
\    Summary: Copy a message from the justified text buffer at BUF into the
\             message buffer
\
\ ******************************************************************************

.StoreMessage

 LDA #32                \ Set A = 32 - DTW5
 SEC                    \
 SBC DTW5               \ Where DTW5 is the size of the justified text buffer at
                        \ BUF, so A contains the number of characters remaining
                        \ if we print the message buffer on one line (as each
                        \ line contains 32 characters)

 BCS smes1              \ If the subtraction didn't underflow, then the message
                        \ in the message buffer will fit on one line, so jump to
                        \ smes1 with the remaining number of characters in A

                        \ The subraction underflowed, so the message will not
                        \ fit on one line
                        \
                        \ In this case we just print as many characters as we
                        \ can and truncate the message at the end of the line

 LDA #31                \ Set the size of the message buffer in DTW5 to 31,
 STA DTW5               \ which is the maximum size of a one-line message

 LDA #2                 \ Set A = 2 so the message will be printed in column 1
                        \ on the left of the screen

.smes1

                        \ When we get here, A contains the number of characters
                        \ remaining if we were to print the message on one line
                        \ of the screen

 LSR A                  \ Set A = A / 2
                        \
                        \ So A now contains half the amount of free space left
                        \ if we print the message on one line, which is the
                        \ amount of space on each side of the message when it is
                        \ centred on the line
                        \
                        \ In other words, this is the column number where we
                        \ need to print our message for it to be centred
                        \ on-screen

 STA messXC             \ Store A in messXC, so when we erase the message via
                        \ the branch to me1 above, messXC will tell us where to
                        \ print it

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX DTW5               \ Set the size of the message in the message buffer to
 STX messageLength      \ the size of the justified text buffer, as we are about
                        \ to copy from one to the other

 INX                    \ Set X as a character counter so we can loop through
                        \ message and copy it one character at a time (we
                        \ increment it so X is at least 1, to make the following
                        \ loop work)

.smes2

 LDA BUF-1,X            \ Copy the character number X - 1 from BUF into
 STA messageBuffer-1,X  \ messageBuffer

 DEX                    \ Decrement the character counter

 BNE smes2              \ Loop back until we have copied all X characters

 STX de                 \ Zero de, the flag that appends " DESTROYED" to the
                        \ end of the next text token, so that it doesn't append
                        \ it to the next message

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

                        \ Fall through into DisableJustifyText to reset DTW4 and
                        \ DTW5 to turn off justified text and reset the
                        \ justified text buffer

\ ******************************************************************************
\
\       Name: DisableJustifyText
\       Type: Subroutine
\   Category: Text
\    Summary: Turn off justified text and reset the justified text buffer
\
\ ------------------------------------------------------------------------------
\
\ Other entry points:
\
\   RTS5                Contains an RTS
\
\ ******************************************************************************

.DisableJustifyText

 LDA #0                 \ Set DTW4 = %00000000 (do not justify text, print
 STA DTW4               \ buffer on carriage return)

 STA DTW5               \ Set DTW5 = 0, to reset the size of the message in the
                        \ text buffer at BUF

.RTS5

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: PrintFlightMessage
\       Type: Subroutine
\   Category: Text
\    Summary: Print an in-flight message
\
\ ******************************************************************************

.PrintFlightMessage

 LDA messYC             \ Set A to the current row for in-flight messages

 LDX QQ11               \ If this is the space view, jump to fmes1 to skip the
 BEQ fmes1              \ following and leave A with this value, so we print the
                        \ in-flight message on the row specified in messYC

 JSR CLYNS+8            \ Clear the bottom two text rows of the visible screen,
                        \ but without resetting the in-flight message timer

 LDA #23                \ Set A to 23, so we print the in-flight message on row
                        \ 23 for all views other than the space view

.fmes1

 STA YC                 \ Move the text cursor to the row in A

 LDX #0                 \ Set QQ17 = 0 to switch to ALL CAPS
 STX QQ17

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA messXC             \ Move the text cursor to column messXC, which we set
 STA XC                 \ to the text column of the current in-flight message
                        \ when we called MESS to display it

 LDA messXC             \ This appears to be an unnecessary duplicate of the
 STA XC                 \ above

 LDY #0                 \ We now work through the message one character at a
                        \ time, so set a character counter in Y

.fmes2

 LDA messageBuffer,Y    \ Fetch the Y-th character from the message buffer

 JSR CHPR_b2            \ Print the character

 INY                    \ Increment the character counter in Y

 CPY messageLength      \ Loop back until we have printed all the characters in
 BNE fmes2              \ the buffer, whose size is in messageLength

 LDA QQ11               \ If this is the space view, jump to RTS5 to return from
 BEQ RTS5               \ the subroutine, as the NMI handler will take care of
                        \ updating the screen when we next flip bitplanes

 JMP DrawMessageInNMI   \ Configure the NMI to display the message that we just
                        \ printed, returning from the subroutine using a tail
                        \ call

INCLUDE "library/common/main/subroutine/ouch.asm"
INCLUDE "library/common/main/subroutine/ou2.asm"
INCLUDE "library/common/main/subroutine/ou3.asm"
INCLUDE "library/common/main/variable/qq23.asm"
INCLUDE "library/enhanced/main/subroutine/pas1.asm"
INCLUDE "library/common/main/subroutine/mveit_part_1_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_2_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_3_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_4_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_5_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_6_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_7_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_8_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_9_of_9.asm"
INCLUDE "library/common/main/subroutine/mvt1.asm"
INCLUDE "library/common/main/subroutine/mvs4.asm"
INCLUDE "library/common/main/subroutine/mvt6.asm"
INCLUDE "library/common/main/subroutine/mv40.asm"
INCLUDE "library/common/main/subroutine/plut-pu1.asm"
INCLUDE "library/common/main/subroutine/look1.asm"
INCLUDE "library/common/main/subroutine/flip.asm"

\ ******************************************************************************
\
\       Name: SendSpaceViewToPPU
\       Type: Subroutine
\   Category: PPU
\    Summary: ???
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X                   The space view to set:
\
\                         * 0 = front
\
\                         * 1 = rear
\
\                         * 2 = left
\
\                         * 3 = right
\
\                         * 4 = generating a new space view
\
\ ******************************************************************************

.SendSpaceViewToPPU

 LDA #72                \ Set the screen height variables for a screen height of
 JSR SetScreenHeight    \ 144 (i.e. 2 * 72)

 STX VIEW               \ Set the current space view to X

 LDA #&00               \ Clear the screen and and set the view type in QQ11 to
 JSR TT66               \ &00 (Space view with no fonts loaded)

 JSR CopyNameBuffer0To1 \ Copy the contents of nametable buffer 0 to nametable
                        \ buffer and tell the NMI handler to send pattern
                        \ entries up to the first free tile

 JSR SendViewToPPU_b3   \ Configure the PPU for the view type in QQ11

 JMP ResetStardust      \ Hide the sprites for the stardust and return from the
                        \ subroutine using a tail call

\ ******************************************************************************
\
\       Name: SetSpaceViewInNMI
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Set the current space view and configure the NMI to send both
\             bitplanes to the PPU during VBlank
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X                   The space view to set:
\
\                         * 0 = front
\
\                         * 1 = rear
\
\                         * 2 = left
\
\                         * 3 = right
\
\                         * 4 = generating a new space view
\
\ ******************************************************************************

.SetSpaceViewInNMI

 STX VIEW               \ Set the current space view to X

 LDA #&00               \ Clear the screen and and set the view type in QQ11 to
 JSR TT66               \ &00 (Space view with no fonts loaded)

 JSR CopyNameBuffer0To1 \ Copy the contents of nametable buffer 0 to nametable
                        \ buffer and tell the NMI handler to send pattern
                        \ entries up to the first free tile

 LDA #80                \ Tell the PPU to send nametable entries up to tile
 STA lastNameTile       \ 80 * 8 = 640 (i.e. to the end of tile row 19) in both
 STA lastNameTile+1     \ bitplanes

 JSR SetupViewInNMI_b3  \ Setup the view and configure the NMI to send both
                        \ bitplanes to the PPU during VBlank

                        \ Fall through into ResetStardust to hide the sprites
                        \ for the stardust

\ ******************************************************************************
\
\       Name: ResetStardust
\       Type: Subroutine
\   Category: Stardust
\    Summary: Hide the sprites for the stardust
\
\ ******************************************************************************

.ResetStardust

 LDX #NOST              \ Set X to the maximum number of stardust particles, so
                        \ we loop through all the particles of stardust in the
                        \ following, hiding them all

 LDY #152               \ Set Y to the starting index in the sprite buffer, so
                        \ we start hiding from sprite 152 / 4 = 38 (as each
                        \ sprite in the buffer consists of four bytes)

.rest1

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA #240               \ Set A to the y-coordinate that's just below the bottom
                        \ of the screen, so we can hide the required sprites by
                        \ moving them off-screen

 STA ySprite0,Y         \ Set the y-coordinate for sprite Y / 4 to 240 to hide
                        \ it (the division by four is because each sprite in the
                        \ sprite buffer has four bytes of data)

 LDA #210               \ Set the sprite to use pattern number 210 for the
 STA tileSprite0,Y      \ largest particle of stardust (the stardust particle
                        \ patterns run from pattern 210 to 214, decreasing in
                        \ size as the number increases)

 TXA                    \ Take the particle number, which is between 1 and 20
 LSR A                  \ (as NOST is 20), and rotate it around from %76543210
 ROR A                  \ to %10xxxxx3 (where x indicates a zero), storing the
 ROR A                  \ result as the sprite attribute
 AND #%11100001         \
 STA attrSprite0,Y      \ This sets the flip horizontally and flip vertically
                        \ attributes to bits 0 and 1 of the particle number, and
                        \ the palette to bit 3 of the particle number, so the
                        \ reset stardust particles have a variety of reflections
                        \ and palettes

 INY                    \ Add 4 to Y so it points to the next sprite's data in
 INY                    \ the sprite buffer
 INY
 INY

 DEX                    \ Decrement the loop counter in X

 BNE rest1              \ Loop back until we have hidden X sprites

 JSR WaitForNMI         \ Wait until the next NMI interrupt has passed (i.e. the
                        \ next VBlank)

 JSR SIGHT_b3           \ Draw the laser crosshairs

                        \ Fall through into SetupSpaceView to finish setting up
                        \ the space view's NMI configuration

\ ******************************************************************************
\
\       Name: SetupSpaceView
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Set up the NMI variables for the space view
\
\ ******************************************************************************

.SetupSpaceView

 LDA #&FF               \ Set showIconBarPointer = &FF to indicate that we
 STA showIconBarPointer \ should show the icon bar pointer

 LDA #&2C               \ Set the visible colour to cyan (&2C)
 STA visibleColour

 LDA firstFreeTile      \ Tell the NMI handler to send pattern entries from the
 STA firstPatternTile   \ first free tile onwards, so we don't waste time
                        \ resending the static tiles we have already sent

 LDA #80                \ Tell the NMI handler to only clear nametable entries
 STA maxNameTileToClear \ up to tile 80 * 8 = 640 (i.e. up to the end of tile
                        \ row 19)

 LDX #8                 \ Tell the NMI handler to send nametable entries from
 STX firstNametableTile \ tile 8 * 8 = 64 onwards (i.e. from the start of tile
                        \ row 2)

 LDA #116               \ Tell the NMI handler to send nametable entries up to
 STA lastNameTile       \ tile 116 * 8 = 800 (i.e. up to the end of tile row 28)
                        \ in bitplane 0

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/ecmof.asm"
INCLUDE "library/common/main/subroutine/sfrmis.asm"
INCLUDE "library/common/main/subroutine/exno2.asm"

\ ******************************************************************************
\
\       Name: LBEAB
\       Type: Variable
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.LBEAB

 EQUB &1B, &17, &0E, &0D, &0D                 ; BEAB: 1B 17 0E... ...

INCLUDE "library/common/main/subroutine/exno.asm"

\ ******************************************************************************
\
\       Name: TT66
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Clear the screen and set the new view type
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The type of the new view (see QQ11 for a list of view
\                       types)
\
\ ******************************************************************************

.TT66

 STA QQ11               \ Set the new view type in QQ11 to A

 LDA QQ11a              \ If bit 7 is set in either QQ11 or QQ11a, then either
 ORA QQ11               \ there is no dashboard in either view, or it is being
 BMI scrn1              \ added or removed, so jump to scrn1 to skip clearing
                        \ the existing scanner, as we don't need to worry about
                        \ preserving it

 LDA QQ11               \ If bit 7 of QQ11 is clear, then bit 7 must be clear in
 BPL scrn1              \ both QQ11 and QQ11a as we didn't take the branch
                        \ above, so we are switching between views that both
                        \ have dashboards, so jump to scrn1 to skip clearing the
                        \ scanner as we want to retain it

                        \ Strangely, we can never get here, as we take the first
                        \ branch above when bit 7 of QQ11 is set, and we take
                        \ the second branch when bit 7 of QQ11 is clear

 JSR ClearScanner       \ Remove all ships from the scanner and hide the scanner
                        \ sprites

.scrn1

 JSR WaitForPPUToFinish \ Wait until both bitplanes of the screen have been
                        \ sent to the PPU, so the screen is fully updated and
                        \ there is no more data waiting to be sent to the PPU

 JSR ClearScreen_b3     \ Clear the screen by zeroing patterns 66 to 255 in
                        \ both pattern buffer, and clearing both nametable
                        \ buffers to the background tile

 LDA #16                \ Set the text row for in-flight messages in the space
 STA messYC             \ view to row 16

 LDX #0                 \ Set flipEveryBitplane0 = 0 ???
 STX flipEveryBitplane0

 JSR SetDrawingBitplane \ Set the drawing bitplane to bitplane 0

 LDA #%10000000         \ Set bit 7 of QQ17 to switch to Sentence Case
 STA QQ17

 STA DTW2               \ Set bit 7 of DTW2 to indicate we are not currently
                        \ printing a word

 STA DTW1               \ Set bit 7 of DTW1 to indicate ???

 LDA #%00000000         \ Set DTW6 = %00000000 to disable lower case
 STA DTW6

 STA LAS2               \ Set LAS2 = 0 to stop any laser pulsing

 STA DLY                \ Set the delay in DLY to 0, to indicate that we are
                        \ no longer showing an in-flight message, so any new
                        \ in-flight messages will be shown instantly

 STA de                 \ Clear de, the flag that appends " DESTROYED" to the
                        \ end of the next text token, so that it doesn't

 LDA #1                 \ Move the text cursor to column 1 on row 1
 STA XC
 STA YC

 JSR SetLinePatterns_b3 \ Load the line patterns for the new view into the
                        \ pattern buffers

                        \ We now set X to the type of icon bar to show in the
                        \ new view

 LDA QQ11               \ If bit 6 of the new view in QQ11 is set then it
 LDX #&FF               \ doesn't have an icon bar, so jump to scrn2 with
 AND #%01000000         \ X = &FF to hide the icon bar on row 27
 BNE scrn2

 LDX #4                 \ If the new view in QQ11 is 1, then we are on the title
 LDA QQ11               \ screen, so jump to scrn2 with X = 4 so we show the
 CMP #1                 \ copyright message in the icon bar
 BEQ scrn2

 LDX #2                 \ If the new view in QQ11 is %0000110x (i.e. 12 or 13,
 LDA QQ11               \ which are the Short-range Chart and Long-range Chart),
 AND #%00001110         \ jump to scrn2 with X = 2 to show the icon bar for the
 CMP #%00001100         \ charts
 BEQ scrn2

 LDX #1                 \ If we are not docked (QQ12 = 0), jump to scrn2 with
 LDA QQ12               \ X = 1 to show the flight icon bar
 BEQ scrn2

 LDX #0                 \ Otherwise fall through into scrn2 with X = 0 to show
                        \ the docked icon bar

.scrn2

 LDA QQ11               \ If bit 7 of the new view in QQ11 is set then there is
 BMI scrn5              \ no dashboard, so jump to scrn5 to show the icon bar
                        \ type with type X on row 27

                        \ If we get here then the new view has the dashboard, so
                        \ we initialise it if required

 TXA                    \ Show the icon bar with type X
 JSR SetupIconBar_b3

 LDA QQ11a              \ If bit 7 of the old view in QQ11a is clear, then the
 BPL scrn3              \ old view has a dashboard, so jump to scrn3 to skip the
                        \ following two instructions, as we don't need to
                        \ initialise the dashboard

 JSR SetScreenForUpdate \ Get the screen ready for updating by hiding all
                        \ sprites, after fading the screen to black if we are
                        \ changing view

 JSR ResetScanner_b3    \ Reset the sprites used for drawing ships on the
                        \ scanner

.scrn3

 JSR DrawDashNames_b3   \ Draw the dashboard into the nametable buffers for
                        \ both bitplanes

 JSR msblob             \ Display the dashboard's missile indicators in black

 JMP scrn8              \ Jump to scrn8 to continue setting up the view

.scrn4

 JMP SetViewAttrs_b3    \ Set up attribute buffer 0 for the chosen view,
                        \ returning from the subroutine using a tail call

.scrn5

                        \ If we get here then there is no dashboard in the new
                        \ view

 TXA                    \ Show the icon bar with type X
 JSR SetupIconBar_b3

                        \ The next two comparisons aren't necessary as both &C4
                        \ and &8D have bit 4 clear, so they would be caught by
                        \ the AND #%00010000 below anyway, but there's no harm
                        \ in being explicit, I guess

 LDA QQ11               \ If the view type in QQ11 is &C4 (Game Over screen),
 CMP #&C4               \ jump to scrn4 to set up attribute buffer 0 and
 BEQ scrn4              \ return from the subroutine

 LDA QQ11               \ If the view type in QQ11 is &8D (Long-range Chart),
 CMP #&8D               \ jump to scrn6 to skip loading the font into pattern
 BEQ scrn6              \ buffer 0

 CMP #&CF               \ If the view type in QQ11 is &CF (Start screen with
 BEQ scrn6              \ no fonts loaded), jump to scrn6 to skip loading
                        \ the font into pattern buffer 0

 AND #%00010000         \ If bit 4 of the new view in QQ11 is clear, jump to
 BEQ scrn6              \ scrn6 to skip loading the font into pattern buffer 0

                        \ If we get here then the new view we are setting up is
                        \ not the Game Over screen, the Long-range Chart or the
                        \ Start screen, and bit 4 of QQ11 is set

 LDA #66                \ Load the font into pattern buffer 0, and a set of
 JSR LoadNormalFont_b3  \ filled blocks into pattern buffer 1, from pattern 66
                        \ to 160
                        \
                        \ If the view type in QQ11 is &BB (Save and load with
                        \ font loaded in both bitplanes), then this also loads
                        \ an inverted font into pattern buffer 1, from pattern
                        \ 66 to 160

.scrn6

 LDA QQ11               \ If bit 5 of the new view in QQ11 is clear, jump to
 AND #%00100000         \ scrn7 to skip loading the normal font
 BEQ scrn7

 JSR LoadHighFont_b3    \ Load the font into pattern buffer 1, and a set of
                        \ filled blocks into pattern buffer 0, from pattern 161
                        \ to 255

.scrn7

                        \ The new view doesn't have a dashboard, so now we draw
                        \ the left and right edges of the box on the rows where
                        \ the dashboard would be, overwriting the edges of the
                        \ dashboard from the old view (if it had one)

 LDA #1                 \ Draw the left edge of the box on rows 20 to 26
 STA nameBuffer0+20*32+1
 STA nameBuffer0+21*32+1
 STA nameBuffer0+22*32+1
 STA nameBuffer0+23*32+1
 STA nameBuffer0+24*32+1
 STA nameBuffer0+25*32+1
 STA nameBuffer0+26*32+1

 LDA #2                 \ Draw the right edge of the box on rows 20 to 26
 STA nameBuffer0+20*32
 STA nameBuffer0+21*32
 STA nameBuffer0+22*32
 STA nameBuffer0+23*32
 STA nameBuffer0+24*32
 STA nameBuffer0+25*32
 STA nameBuffer0+26*32

 LDA QQ11               \ If bit 6 of the new view in QQ11 is set, then there is
 AND #%01000000         \ no icon bar, so jump to scrn8... which has no effect,
 BNE scrn8              \ as that's the next instruction anyway, so presumably
                        \ this was left behind after deleting the code that
                        \ would be skipped

.scrn8

 JSR SetViewAttrs_b3    \ Set up attribute buffer 0 for the chosen view

                        \ The six instructions between here and scrn9 have no
                        \ effect, as we always end up at scrn9 and don't take
                        \ any notice of the flags

 LDA demoInProgress     \ If bit 7 of demoInProgress is set then we are
 BMI scrn9              \ initialising the demo, so jump to scrn9

 LDA QQ11               \ If bit 7 of the new view in QQ11 is clear, jump to
 BPL scrn9              \ scrn9

 CMP QQ11a              \ If the view we are switching from in QQ11a is 0 (the
 BEQ scrn9              \ space view), jump to scrn9... which has no effect,
                        \ as that's the next instruction anyway, so presumably
                        \ this was left behind after deleting the code that
                        \ would be skipped

.scrn9

 JSR DrawBoxTop         \ Draw the top edge of the box along the top of the
                        \ screen in nametable buffer 0

 LDX languageIndex      \ Set X to the index of the chosen language

 LDA QQ11               \ If this is the space view (QQ11 = 0), jump to scrn10
 BEQ scrn10             \ to print the view name at the top of the screen

 CMP #1                 \ If this is not the title screen (QQ11 = 1), jump to
 BNE scrn12             \ scrn12 to skip printing a title at the top of the
                        \ screen

                        \ If we get here then the new view is the title screen

 LDA #0                 \ Move the text cursor to row 0
 STA YC

 LDX languageIndex      \ Move the text cursor to the correct column for the
 LDA xTitleScreen,X     \ title screen in the chosen language
 STA XC

 LDA #30                \ Set A = 30 so we print recursive token 144 when we
                        \ jump to scrn11 ("--- E L I T E ---")

 BNE scrn11             \ Jump to scrn11 to print ("--- E L I T E ---") at the
                        \ top of the screen (this BNE is effectively a JMP as
                        \ A is never zero)

.scrn10

                        \ If we get here then the new view is the space view
                        \ and we jumped here with A = 0

 STA YC                 \ Move the text cursor to row 0

 LDA xSpaceView,X       \ Move the text cursor to the correct column for the
 STA XC                 \ space view name in the chosen language

 LDA languageNumber     \ If bit 1 of languageNumber is set, then the chosen
 AND #%00000010         \ language is Geman, so jump to scrn13 to print the view
 BNE scrn13             \ name after the view noun (so we print "ANSICHT VORN"
                        \ and "ANSICHT HINTEN" instead of "FRONT VIEW" and "REAR
                        \ VIEW", for example)

 JSR PrintSpaceViewName \ Print the name of the current space view (i.e.
                        \ "FRONT", "REAR", "LEFT" or "RIGHT")

 JSR TT162              \ Print a space

 LDA #175               \ Set A = 175 so the next instruction prints recursive
                        \ token 15 ("VIEW ")

.scrn11

 JSR TT27_b2            \ Print the text token in A

.scrn12

 LDX #1                 \ Move the text cursor to column 1 on row 1
 STX XC
 STX YC

 DEX                    \ Set QQ17 = 0 to switch to ALL CAPS
 STX QQ17

 RTS                    \ Return from the subroutine

.scrn13

                        \ If we get here then we want to print the view name
                        \ after the view noun

 LDA #175               \ Print recursive token 15 ("VIEW ") followed by a space
 JSR spc

 JSR PrintSpaceViewName \ Print the name of the current space view (i.e.
                        \ "FRONT", "REAR", "LEFT" or "RIGHT")

 JMP scrn12             \ Jump back to scrn12 to finish off

\ ******************************************************************************
\
\       Name: PrintSpaceViewName
\       Type: Subroutine
\   Category: Text
\    Summary: Print the name of the current space view
\
\ ******************************************************************************

.PrintSpaceViewName

 LDA VIEW               \ Load the current view into A:
                        \
                        \   0 = front
                        \   1 = rear
                        \   2 = left
                        \   3 = right

 ORA #&60               \ OR with &60 so we get a value of &60 to &63 (96 to 99)

 JMP TT27_b2            \ Print recursive token 96 to 99, which will be in the
                        \ range "FRONT" to "RIGHT", returning from the
                        \ subroutine using a tail call

INCLUDE "library/nes/main/variable/vectors.asm"

\ ******************************************************************************
\
\ Save bank0.bin
\
\ ******************************************************************************

 PRINT "S.bank0.bin ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
 SAVE "versions/nes/3-assembled-output/bank0.bin", CODE%, P%, LOAD%
