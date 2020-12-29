\ ******************************************************************************
\
\       Name: HAS1
\       Type: Subroutine
\   Category: Ship hanger
\    Summary: Draw a ship in the ship hanger
\
\ ------------------------------------------------------------------------------
\
\ The ship's position within the hanger is determined by the arguments and the
\ size of the ship's targetable area, as follows:
\
\   * The x-coordinate is (x_sign x_hi 0) from the arguments, so the ship can be
\     left of centre or right of centre
\
\   * The y-coordinate is negative and is lower down the screen for smaller
\     ships, so smaller ships are drawn closer to the ground (because they are)
\
\   * The z-coordinate is positive, with both z_hi (which is 1 or 2) and z_lo
\     coming from the arguments
\
\ Arguments:
\
\   XX15                Bits 0-7 = Ship's z_lo
\                       Bit 0    = Ship's x_sign
\
\   XX15+1              Bits 0-7 = Ship's x_hi
\                       Bit 0    = Ship's z_hi (1 if clear, or 2 if set)
\
\   XX15+2              Non-zero = Ship type to draw
\                       0        = Don't draw anything
\
\ Other entry points:
\
\   UNWISE              Contains an RTS
\
\ ******************************************************************************

.HAS1

 JSR ZINF               \ Call ZINF to reset the INWK ship workspace and reset
                        \ the orientation vectors, with nosev pointing out of
                        \ the screen, so this puts the ship flat on the
                        \ horizontal deck (the y = 0 plane) with its nose
                        \ pointing towards us

 LDA XX15               \ Set z_lo = XX15
 STA INWK+6

 LSR A                  \ Set the sign bit of x_sign to bit 0 of A
 ROR INWK+2

 LDA XX15+1             \ Set x_hi = XX15+1
 STA INWK

 LSR A                  \ Set z_hi = 1 + bit 0 of XX15+1
 LDA #1
 ADC #0
 STA INWK+7

 LDA #%10000000         \ Set bit 7 of y_sign, so y is negative
 STA INWK+5

 STA RAT2               \ Set RAT2 = %10000000, so the yaw calls in HAL5 below
                        \ are negative

 LDA #&B                \ Set the ship line heap pointer in INWK(35 34) to point
 STA INWK+34            \ to &0B00

 JSR DORND              \ We now perform a random number of small angle (3.6
 STA XSAV               \ degree) rotations to spin the ship on the deck while
                        \ keeping it flat on the deck (a bit like spinning a
                        \ bottle), so we set XSAV to a random number between 0
                        \ and 255 for the number of small yaw rotations to
                        \ perform, so the ship could be pointing in any
                        \ direction by the time we're done

.HAL5

 LDX #21                \ Rotate (sidev_x, nosev_x) by a small angle (yaw)
 LDY #9
 JSR MVS5

 LDX #23                \ Rotate (sidev_y, nosev_y) by a small angle (yaw)
 LDY #11
 JSR MVS5

 LDX #25                \ Rotate (sidev_z, nosev_z) by a small angle (yaw)
 LDY #13
 JSR MVS5

 DEC XSAV               \ Decrement the yaw counter in XSAV

 BNE HAL5               \ Loop back to yaw a little more until we have yawed
                        \ by the number of times in XSAV

 LDY XX15+2             \ Set Y = XX15+2, the ship type of the ship we need to
                        \ draw

 BEQ HA1                \ If Y = 0, return from the subroutine (as HA1 contains
                        \ an RTS)

 TYA                    \ Set X = 2 * Y
 ASL A
 TAX

 LDA XX21-2,X           \ Set XX0(1 0) to the X-th address in the ship blueprint
 STA XX0                \ address lookup table at XX21, so XX0(1 0) now points
 LDA XX21-1,X           \ to the blueprint for the ship we need to draw
 STA XX0+1

 BEQ HA1                \ If the high byte of the blueprint address is 0, then
                        \ this is not a valid blueprint address, so return from
                        \ the subroutine (as HA1 contains an RTS)

 LDY #1                 \ Set Q = ship byte #1
 LDA (XX0),Y
 STA Q

 INY                    \ Set R = ship byte #2
 LDA (XX0),Y            \
 STA R                  \ so (R Q) contains the ship's targetable area, which is
                        \ a square number

 JSR LL5                \ Set Q = SQRT(R Q)

 LDA #100               \ Set y_lo = (100 - Q) / 2
 SBC Q                  \
 LSR A                  \ so the bigger the ship's targetable area, the smaller
 STA INWK+3             \ the magnitude of the y-coordinate, so because we set
                        \ y_sign to be negative above, this means smaller ships
                        \ are drawn lower down, i.e. closer to the ground, while
                        \ larger ships are drawn higher up, as you would expect

 JSR TIDY               \ Call TIDY to tidy up the orientation vectors, to
                        \ prevent the ship from getting elongated and out of
                        \ shape due to the imprecise nature of trigonometry
                        \ in assembly language

 JMP LL9                \ Jump to LL9 to display the ship and return from the
                        \ subroutine using a tail call

.UNWISE

.HA1

 RTS                    \ Return from the subroutine

