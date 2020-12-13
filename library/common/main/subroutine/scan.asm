\ ******************************************************************************
\
\       Name: SCAN
\       Type: Subroutine
\   Category: Dashboard
\    Summary: Display the current ship on the scanner
\  Deep dive: The 3D scanner
\
\ ------------------------------------------------------------------------------
\
\ This is used both to display a ship on the scanner, and to erase it again.
\
\ Arguments:
\
\   INWK                The ship's data block
\
\ ******************************************************************************

.SCAN

 LDA INWK+31            \ Fetch the ship's scanner flag from byte #31

 AND #%00010000         \ If bit 4 is clear then the ship should not be shown
 BEQ SC5                \ on the scanner, so return from the subroutine (as SC5
                        \ contains an RTS)

IF _CASSETTE_VERSION

 LDA TYPE               \ Fetch the ship's type from TYPE into A

ELIF _6502SP_VERSION

 LDX TYPE               \ Fetch the ship's type from TYPE into X

ENDIF

 BMI SC5                \ If this is the planet or the sun, then the type will
                        \ have bit 7 set and we don't want to display it on the
                        \ scanner, so return from the subroutine (as SC5
                        \ contains an RTS)

IF _CASSETTE_VERSION

 LDX #&FF               \ Set X to the default scanner colour of green/cyan
                        \ (a 4-pixel mode 5 byte in colour 3)

\CMP #TGL               \ These instructions are commented out in the original
\BEQ SC49               \ source. Along with the block just below, they would
                        \ set X to colour 1 (red) for asteroids, cargo canisters
                        \ and escape pods, rather than green/cyan. Presumably
                        \ they decided it didn't work that well against the red
                        \ ellipse and took this code out for release

 CMP #MSL               \ If this is not a missile, skip the following
 BNE P%+4               \ instruction

 LDX #&F0               \ This is a missile, so set X to colour 2 (yellow/white)

\CMP #AST               \ These instructions are commented out in the original
\BCC P%+4               \ source. See above for an explanation of what they do
\LDX #&0F
\.SC49

 STX COL                \ Store X, the colour of this ship on the scanner, in
                        \ COL

ELIF _6502SP_VERSION

 LDA scacol,X           \ Set A to the scanner colour for this ship type from
                        \ the X-th entry in the scacol table 

 STA SCANcol            \ Store the scanner colour in SCANcol so it can be sent
                        \ to the I/O processor with the #onescan command

ENDIF

 LDA INWK+1             \ If any of x_hi, y_hi and z_hi have a 1 in bit 6 or 7,
 ORA INWK+4             \ then the ship is too far away to be shown on the
 ORA INWK+7             \ scanner, so return from the subroutine (as SC5
 AND #%11000000         \ contains an RTS)
 BNE SC5

                        \ If we get here, we know x_hi, y_hi and z_hi are all
                        \ 63 (%00111111) or less

                        \ Now, we convert the x_hi coordinate of the ship into
                        \ the screen x-coordinate of the dot on the scanner,
                        \ using the following (see the deep dive on "The 3D
                        \ scanner" for an explanation):
                        \
                        \   X1 = 123 + (x_sign x_hi)

 LDA INWK+1             \ Set x_hi

 CLC                    \ Clear the C flag so we can do addition below

 LDX INWK+2             \ Set X = x_sign

 BPL SC2                \ If x_sign is positive, skip the following

 EOR #%11111111         \ x_sign is negative, so flip the bits in A and subtract
 ADC #1                 \ 1 to make it a negative number (bit 7 will now be set
                        \ as we confirmed above that bits 6 and 7 are clear). So
                        \ this gives A the sign of x_sign and gives it a value
                        \ range of -63 (%11000001) to 0

.SC2

IF _CASSETTE_VERSION

 ADC #123               \ Set X1 = 123 + x_hi
 STA X1

ELIF _6502SP_VERSION

 ADC #123               \ Set A = 123 + x_hi
 
 STA SCANx1             \ Store the x-coordinate in SCANx1 so it can be sent
                        \ to the I/O processor with the #onescan command

ENDIF

                        \ Next, we convert the z_hi coordinate of the ship into
                        \ the y-coordinate of the base of the ship's stick,
                        \ like this (see the deep dive on "The 3D scanner" for
                        \ an explanation):
                        \
                        \   SC = 220 - (z_sign z_hi) / 4
                        \
                        \ though the following code actually does it like this:
                        \
                        \   SC = 255 - (35 + z_hi / 4)

 LDA INWK+7             \ Set A = z_hi / 4
 LSR A                  \
 LSR A                  \ So A is in the range 0-15

 CLC                    \ Clear the C flag

 LDX INWK+8             \ Set X = z_sign

 BPL SC3                \ If z_sign is positive, skip the following

 EOR #%11111111         \ z_sign is negative, so flip the bits in A and set the
 SEC                    \ C flag. As above, this makes A negative, this time
                        \ with a range of -16 (%11110000) to -1 (%11111111). And
                        \ as we are about to do an ADC, the SEC effectively adds
                        \ another 1 to that value, giving a range of -15 to 0

.SC3

 ADC #35                \ Set A = 35 + A to give a number in the range 20 to 50

 EOR #%11111111         \ Flip all the bits and store in SC, so SC is in the
 STA SC                 \ range 205 to 235, with a higher z_hi giving a lower SC

                        \ Now for the stick height, which we calculate using the
                        \ following (see the deep dive on "The 3D scanner" for
                        \ an explanation):
                        \
                        \ A = - (y_sign y_hi) / 2

 LDA INWK+4             \ Set A = y_hi / 2
 LSR A

 CLC                    \ Clear the C flag

 LDX INWK+5             \ Set X = y_sign

 BMI SCD6               \ If y_sign is negative, skip the following, as we
                        \ already have a positive value in A

 EOR #%11111111         \ y_sign is positive, so flip the bits in A and set the
 SEC                    \ C flag. This makes A negative, and as we are about to
                        \ do an ADC below, the SEC effectively adds another 1 to
                        \ that value to implement two's complement negation, so
                        \ we don't need to add another 1 here

.SCD6

                        \ We now have all the information we need to draw this
                        \ ship on the scanner, namely:
                        \
                        \   X1 = the screen x-coordinate of the ship's dot
                        \
                        \   SC = the screen y-coordinate of the base of the
                        \        stick
                        \
                        \   A = the screen height of the ship's stick, with the
                        \       correct sign for adding to the base of the stick
                        \       to get the dot's y-coordinate
                        \
                        \ First, though, we have to make sure the dot is inside
                        \ the dashboard, by moving it if necessary

 ADC SC                 \ Set A = SC + A, so A now contains the y-coordinate of
                        \ the end of the stick, plus the length of the stick, to
                        \ give us the screen y-coordinate of the dot

IF _CASSETTE_VERSION

 BPL ld246              \ If the result has bit 0 clear, then the result has
                        \ overflowed and is bigger than 256, so jump to ld246 to
                        \ set A to the maximum allowed value of 246 (this
                        \ instruction isn't required as we test both the maximum
                        \ and minimum below, but it might save a few cycles)

ELIF _6502SP_VERSION

 BPL FIXIT              \ If the result has bit 0 clear, then the result has
                        \ overflowed and is bigger than 256, so jump to FIXIT to
                        \ set A to the maximum allowed value of 246 (this
                        \ instruction isn't required as we test both the maximum
                        \ and minimum below, but it might save a few cycles)

ENDIF

 CMP #194               \ If A >= 194, skip the following instruction, as 194 is
 BCS P%+4               \ the minimum allowed value of A

 LDA #194               \ A < 194, so set A to 194, the minimum allowed value
                        \ for the y-coordinate of our ship's dot

 CMP #247               \ If A < 247, skip the following instruction, as 246 is
 BCC P%+4               \ the maximum allowed value of A

IF _CASSETTE_VERSION

.ld246

ELIF _6502SP_VERSION

.FIXIT

ENDIF

 LDA #246               \ A >= 247, so set A to 246, the maximum allowed value
                        \ for the y-coordinate of our ship's dot

IF _CASSETTE_VERSION

 STA Y1                 \ Store A in Y1, as it now contains the screen
                        \ y-coordinate for the ship's dot, clipped so that it
                        \ fits within the dashboard

ELIF _6502SP_VERSION

 STA SCANy1             \ Store the y-coordinate in SCANy1 so it can be sent
                        \ to the I/O processor with the #onescan command

ENDIF

 SEC                    \ Set A = A - SC to get the stick length, by reversing
 SBC SC                 \ the ADC SC we did above. This clears the C flag if the
                        \ result is negative (i.e. the stick length is negative)
                        \ and sets it if the result is positive (i.e. the stick
                        \ length is negative)

                        \ So now we have the following:
                        \
                        \   X1 = the screen x-coordinate of the ship's dot,
                        \        clipped to fit into the dashboard
                        \
                        \   Y1 = the screen y-coordinate of the ship's dot,
                        \        clipped to fit into the dashboard
                        \
                        \   SC = the screen y-coordinate of the base of the
                        \        stick
                        \
                        \   A = the screen height of the ship's stick, with the
                        \       correct sign for adding to the base of the stick
                        \       to get the dot's y-coordinate
                        \
                        \   C = 0 if A is negative, 1 if A is positive
                        \
                        \ and we can get on with drawing the dot and stick

IF _CASSETTE_VERSION

 PHP                    \ Store the flags (specifically the C flag) from the
                        \ above subtraction

\BCS SC48               \ These instructions are commented out in the original
\EOR #&FF               \ source. They would negate A if the C flag were set,
\ADC #1                 \ which would reverse the direction of all the sticks,
                        \ so you could turn your joystick around. Perhaps one of
                        \ the authors' test sticks was easier to use upside
                        \ down? Who knows...

.SC48

 PHA                    \ Store the stick height in A on the stack

 JSR CPIX4              \ Draw a double-height mode 5 dot at (X1, Y1). This also
                        \ leaves the following variables set up for the dot's
                        \ top-right pixel, the last pixel to be drawn (as the
                        \ dot gets drawn from the bottom up):
                        \
                        \   SC(1 0) = screen address of the pixel's character
                        \             block
                        \
                        \   Y = number of the character row containing the pixel
                        \
                        \   X = the pixel's number (0-3) in that row
                        \
                        \ We can use there as the starting point for drawing the
                        \ stick, if there is one

 LDA CTWOS+1,X          \ Load the same mode 5 1-pixel byte that we just used
 AND COL                \ for the top-right pixel, and mask it with the same
 STA X1                 \ colour, storing the result in X1, so we can use it as
                        \ the character row byte for the stick

 PLA                    \ Restore the stick height from the stack into A

 PLP                    \ Restore the flags from above, so the C flag once again
                        \ reflects the sign of the stick height

 TAX                    \ Copy the stick height into X

 BEQ RTS                \ If the stick height is zero, then there is no stick to
                        \ draw, so return from the subroutine (as RTS contains
                        \ an RTS)

 BCC RTS+1              \ If the C flag is clear then the stick height in A is
                        \ negative, so jump down to RTS+1

.VLL1

                        \ If we get here then the stick length is positive (so
                        \ the dot is below the ellipse and the stick is above
                        \ the dot, and we need to draw the stick upwards from
                        \ the dot)

 DEY                    \ We want to draw the stick upwards, so decrement the
                        \ pixel row in Y

 BPL VL1                \ If Y is still positive then it correctly points at the
                        \ line above, so jump to VL1 to skip the following

 LDY #7                 \ We just decremented Y up through the top of the
                        \ character block, so we need to move it to the last row
                        \ in the character above, so set Y to 7, the number of
                        \ the last row

 DEC SC+1               \ Decrement the high byte of the screen address to move
                        \ to the character block above

.VL1

 LDA X1                 \ Set A to the character row byte for the stick, which
                        \ we stored in X1 above, and which has the same pixel
                        \ pattern as the bottom-right pixel of the dot (so the
                        \ stick comes out of the right side of the dot)

 EOR (SC),Y             \ Draw the stick on row Y of the character block using
 STA (SC),Y

 DEX                    \ Decrement (positive) the stick height in X

 BNE VLL1               \ If we still have more stick to draw, jump up to VLL1
                        \ to draw the next pixel

.RTS

 RTS                    \ Return from the subroutine

                        \ If we get here then the stick length is negative (so
                        \ the dot is above the ellipse and the stick is below
                        \ the dot, and we need to draw the stick downwards from
                        \ the dot)

 INY                    \ We want to draw the stick downwards, so we first
                        \ increment the row counter so that it's pointing to the
                        \ bottom-right pixel in the dot (as opposed to the top-
                        \ right pixel that the call to CPIX2 finished on)

 CPY #8                 \ If the row number in Y is less than 8, then it
 BNE P%+6               \ correctly points at the next line down, so jump to
                        \ VLL2 to skip the following

 LDY #0                 \ We just incremented Y down through the bottom of the
                        \ character block, so we need to move it to the first
                        \ row in the character below, so set Y to 0, the number
                        \ of the first row

 INC SC+1               \ Increment the high byte of the screen address to move
                        \ to the character block above

.VLL2

 INY                    \ We want to draw the stick itself, heading downwards,
                        \ so increment the pixel row in Y

 CPY #8                 \ If the row number in Y is less than 8, then it
 BNE VL2                \ correctly points at the next line down, so jump to
                        \ VL2 to skip the following

 LDY #0                 \ We just incremented Y down through the bottom of the
                        \ character block, so we need to move it to the first
                        \ row in the character below, so set Y to 0, the number
                        \ of the first row

 INC SC+1               \ Increment the high byte of the screen address to move
                        \ to the character block above

.VL2

 LDA X1                 \ Set A to the character row byte for the stick, which
                        \ we stored in X1 above, and which has the same pixel
                        \ pattern as the bottom-right pixel of the dot (so the
                        \ stick comes out of the right side of the dot)

 EOR (SC),Y             \ Draw the stick on row Y of the character block using
 STA (SC),Y

 INX                    \ Decrement the (negative) stick height in X

 BNE VLL2               \ If we still have more stick to draw, jump up to VLL2
                        \ to draw the next pixel

 RTS                    \ Return from the subroutine

ELIF _6502SP_VERSION

 STA SCANlen            \ Store the stick height in SCANlen so it can be sent
                        \ to the I/O processor with the #onescan command

 ROR SCANflg            \ Rotate the C flag into bit 7 of SCANflg, so bit 7 is
                        \ the sign bit of the stick length

.SC48

 LDX #LO(SCANpars)      \ Send a #onescan command to the I/O processor to draw
 LDY #HI(SCANpars)      \ the ship on the scanner, returning from the subroutine
 LDA #onescan           \ using a tail call
 JMP OSWORD

ENDIF
