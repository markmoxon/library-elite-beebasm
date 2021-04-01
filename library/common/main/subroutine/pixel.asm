\ ******************************************************************************
\
\       Name: PIXEL
\       Type: Subroutine
\   Category: Drawing pixels
IF _CASSETTE_VERSION OR _DISC_VERSION \ Comment
\    Summary: Draw a 1-pixel dot, 2-pixel dash or 4-pixel square
\  Deep dive: Drawing monochrome pixels in mode 4
ELIF _MASTER_VERSION
\    Summary: Draw a 1-pixel dot, 2-pixel dash or 4-pixel square
\  Deep dive: Drawing monochrome pixels in mode 5
ELIF _6502SP_VERSION
\    Summary: Implement the OSWORD 241 command (draw space view pixels)
\  Deep dive: Drawing colour pixels in mode 5
ENDIF
\
\ ------------------------------------------------------------------------------
\
IF _CASSETTE_VERSION OR _DISC_VERSION \ Comment
\ Draw a point at screen coordinate (X, A) with the point size determined by the
\ distance in ZZ. This applies to the top part of the screen (the monochrome
\ mode 4 portion).
ELIF _MASTER_VERSION
\ Draw a point at screen coordinate (X, A) with the point size determined by the
\ distance in ZZ. This applies to the top part of the screen (the 4-colour mode
\ 5 portion).
ELIF _6502SP_VERSION
\ This routine is run when the parasite sends an OSWORD 241 command with
\ parameters in the block at OSSC(1 0). It draws a dot (or collection of dots)
\ in the space view.
\
\ It can draw two types of dot, depending on bits 0-2 of the dot's distance:
\
\   * Draw the dot using the dot's distance to determine both the dot's colour
\     and size. This draws a a 1-pixel dot, 2-pixel dash or 4-pixel square in
\     a colour that's determined by the distance (as per the colour table in
\     PXCL). These kinds of dot are sent by the PIXEL3 routine in the parasite.
\
\   * Draw the dot using the dot's distance to determine the dot's size, either
\     a 2-pixel dash or 4-pixel square. The dot is always drawn in white (which
\     is actually a cyan/red stripe). These kinds of dot are sent by the PIXEL
\     routine in the parasite.
\
\ The parameters match those put into the PBUF/pixbl block in the parasite.
ENDIF
\
\ Arguments:
\
IF _CASSETTE_VERSION OR _DISC_VERSION OR _MASTER_VERSION \ Comment
\   X                   The screen x-coordinate of the point to draw
\
\   A                   The screen y-coordinate of the point to draw
\
\   ZZ                  The distance of the point (further away = smaller point)
\
\ Returns:
\
\   Y                   Y is preserved
\
\ Other entry points:
\
\   PX4                 Contains an RTS
ELIF _6502SP_VERSION
\   OSSC(1 0)           A parameter block as follows:
\
\                         * Byte #0 = The size of the pixel buffer being sent
\
\                         * Byte #2 = The distance of the first dot
\
\                           * Bits 0-2 clear = Draw a 2-pixel dash or 4-pixel
\                             square, as determined by the distance, in white
\                             (cyan/red)
\
\                           * Any of bits 0-2 set = Draw a 1-pixel dot, 2-pixel
\                             dash or 4-pixel square in the correct colour, as
\                             determined by the distance
\
\                         * Byte #3 = The x-coordinate of the first dot
\
\                         * Byte #4 = The y-coordinate of the first dot
\
\                         * Byte #5 = The distance of the second dot
\
\                         * Byte #6 = The x-coordinate of the second dot
\
\                         * Byte #7 = The y-coordinate of the second dot
\
\                       and so on
ENDIF
\
\ ******************************************************************************

.PIXEL

IF _6502SP_VERSION \ Tube

 LDY #0                 \ Set Q to byte #0 from the block pointed to by OSSC,
 LDA (OSSC),Y           \ which contains the size of the pixel buffer
 STA Q

 INY                    \ Increment Y to 2, so y now points at the data for the
 INY                    \ first pixel in the command block

.PXLO

 LDA (OSSC),Y           \ Set P to byte #2 from the Y-th pixel block in OSSC,
 STA P                  \ which contains the point's distance value (ZZ)

 AND #%00000111         \ If ZZ is a multiple of 8 (which will be the case for
 BEQ PX5                \ pixels sent by the parasite's PIXEL routine), jump to
                        \ PX5

                        \ Otherwise this pixel was sent by the parasite's PIXEL3
                        \ routine and will have an odd value of ZZ, and we use
                        \ the distance value to determine the dot's colour and
                        \ size

 TAX                    \ Set S to the ZZ-th value from the PXCL table, to get
 LDA PXCL,X             \ the correct colour byte for this pixel, depending on
 STA S                  \ the distance

 INY                    \ Increment Y to 3

 LDA (OSSC),Y           \ Set X to byte #3 from the Y-th pixel block in OSSC,
 TAX                    \ contains the pixel's x-coordinate

 INY                    \ Increment Y to 4

 LDA (OSSC),Y           \ Set Y to byte #4 from the Y-th pixel block in OSSC,
 STY T1                 \ which contains the pixel's y-coordinate, and store Y,
 TAY                    \ the index of this pixel's y-coordinate, in T1

ELIF _MASTER_VERSION

 STY T1                 \ Store Y, the index of this pixel's y-coordinate, in T1

 LDY #%00001111         \ Set bits 1 and 2 of the Access Control Register at
 STY VIA+&34            \ SHEILA+&34 to switch screen memory into &3000-&7FFF

 TAY                    \ Copy the screen y-coordinate from A into Y

ENDIF

IF _CASSETTE_VERSION OR _DISC_VERSION \ Screen

 STY T1                 \ Store Y in T1

 TAY                    \ Copy A into Y, for use later

 LSR A                  \ Set SCH = &60 + A >> 3
 LSR A
 LSR A
 ORA #&60
 STA SCH

 TXA                    \ Set SC = (X >> 3) * 8
 AND #%11111000
 STA SC

 TYA                    \ Set Y = Y AND %111
 AND #%00000111
 TAY

 TXA                    \ Set X = X AND %111
 AND #%00000111
 TAX

 LDA ZZ                 \ If distance in ZZ >= 144, then this point is a very
 CMP #144               \ long way away, so jump to PX3 to fetch a 1-pixel point
 BCS PX3                \ from TWOS and EOR it into SC+Y

 LDA TWOS2,X            \ Otherwise fetch a 2-pixel dash from TWOS2 and EOR it
 EOR (SC),Y             \ into SC+Y
 STA (SC),Y

 LDA ZZ                 \ If distance in ZZ >= 80, then this point is a medium
 CMP #80                \ distance away, so jump to PX13 to stop drawing, as a
 BCS PX13               \ 2-pixel dash is enough

                        \ Otherwise we keep going to draw another 2 pixel point
                        \ either above or below the one we just drew, to make a
                        \ 4-pixel square

 DEY                    \ Reduce Y by 1 to point to the pixel row above the one
 BPL PX14               \ we just plotted, and if it is still positive, jump to
                        \ PX14 to draw our second 2-pixel dash

 LDY #1                 \ Reducing Y by 1 made it negative, which means Y was
                        \ 0 before we did the DEY above, so set Y to 1 to point
                        \ to the pixel row after the one we just plotted

.PX14

 LDA TWOS2,X            \ Fetch a 2-pixel dash from TWOS2 and EOR it into this
 EOR (SC),Y             \ second row to make a 4-pixel square
 STA (SC),Y

.PX13

 LDY T1                 \ Restore Y from T1, so Y is preserved by the routine

.PX4

 RTS                    \ Return from the subroutine

ELIF _6502SP_VERSION OR _MASTER_VERSION

 LDA ylookup,Y          \ Look up the page number of the character row that
 STA SC+1               \ contains the pixel with the y-coordinate in Y, and
                        \ store it in the high byte of SC(1 0) at SC+1

 TXA                    \ Each character block contains 8 pixel rows, so to get
 AND #%11111100         \ the address of the first byte in the character block
 ASL A                  \ that we need to draw into, as an offset from the start
                        \ of the row, we clear bits 0-1 and shift left to double
                        \ it (as each character row contains two pages of bytes,
                        \ or 512 bytes, which cover 256 pixels). This also
                        \ shifts bit 7 of the x-coordinate into the C flag

 STA SC                 \ Store the address of the character block in the low
                        \ byte of SC(1 0), so now SC(1 0) points to the
                        \ character block we need to draw into

 BCC P%+4               \ If the C flag is clear then skip the next instruction

 INC SC+1               \ The C flag is set, which means bit 7 of X1 was set
                        \ before the ASL above, so the x-coordinate is in the
                        \ right half of the screen (i.e. in the range 128-255).
                        \ Each row takes up two pages in memory, so the right
                        \ half is in the second page but SC+1 contains the value
                        \ we looked up from ylookup, which is the page number of
                        \ the first memory page for the row... so we need to
                        \ increment SC+1 to point to the correct page

 TYA                    \ Set Y to just bits 0-2 of the y-coordinate, which will
 AND #%00000111         \ be the number of the pixel row we need to draw into
 TAY                    \ within the character block

 TXA                    \ Copy bits 0-1 of the x-coordinate to bits 0-1 of X,
 AND #%00000011         \ which will now be in the range 0-3, and will contain
 TAX                    \ the two pixels to show in the character row

ENDIF

IF _6502SP_VERSION \ Other

 LDA P                  \ If the pixel's ZZ distance, which we stored in P, is
 BMI PX3                \ greater than 127, jump to PX3 to plot a 1-pixel dot

ELIF _MASTER_VERSION

 LDA ZZ                 \ Set A to the pixel's distance in ZZ

ENDIF

IF _6502SP_VERSION \ Label

 CMP #80                \ If the pixel's ZZ distance is < 80, then the dot is
 BCC PX2                \ pretty close, so jump to PX2 to to draw a four-pixel
                        \ square

 LDA TWOS2,X            \ Fetch a mode 1 2-pixel byte with the pixels set as in
 AND S                  \ X, and AND with the colour byte we fetched into S
                        \ so that pixel takes on the colour we want to draw
                        \ (i.e. A is acting as a mask on the colour byte)

ELIF _MASTER_VERSION

 CMP #80                \ If the pixel's ZZ distance is < 80, then the dot is
 BCC PX21               \ pretty close, so jump to PX21 to to draw a four-pixel
                        \ square

 LDA TWOS2,X            \ Fetch a mode 1 2-pixel byte with the pixels set as in
 AND COL                \ X, and AND with the colour byte we fetched into COL
                        \ so that pixel takes on the colour we want to draw
                        \ (i.e. A is acting as a mask on the colour byte)

ENDIF

IF _6502SP_VERSION OR _MASTER_VERSION \ Screen

 EOR (SC),Y             \ Draw the pixel on-screen using EOR logic, so we can
 STA (SC),Y             \ remove it later without ruining the background that's
                        \ already on-screen

ENDIF

IF _6502SP_VERSION \ Platform

 LDY T1                 \ Set Y to the index of this pixel's y-coordinate byte
                        \ in the command block, which we stored in T1 above

 INY                    \ Increment Y, so it now points to the first byte of
                        \ the next pixel in the command block

 CPY Q                  \ If the index hasn't reached the value in Q (which
 BNE PXLO               \ contains the size of the pixel buffer), loop back to
                        \ PXLO to draw the next pixel in the buffer

 RTS                    \ Return from the subroutine

.PX2

                        \ If we get here, we need to plot a 4-pixel square in
                        \ in the correct colour for this pixel's distance

 LDA TWOS2,X            \ Fetch a mode 1 2-pixel byte with the pixels set as in
 AND S                  \ X, and AND with the colour byte we fetched into S
                        \ so that pixel takes on the colour we want to draw
                        \ (i.e. A is acting as a mask on the colour byte)

ELIF _MASTER_VERSION

 LDY #%00001001         \ Clear bits 1 and 2 of the Access Control Register at
 STY VIA+&34            \ SHEILA+&34 to switch main memory back into &3000-&7FFF

 LDY T1                 \ Restore Y from T1, so Y is preserved by the routine

.PX4

 RTS                    \ Return from the subroutine

.PX21

                        \ If we get here, we need to plot a 4-pixel square in
                        \ in the correct colour for this pixel's distance

 LDA TWOS2,X            \ Fetch a mode 1 2-pixel byte with the pixels set as in
 AND COL                \ X, and AND with the colour byte we fetched into COL
                        \ so that pixel takes on the colour we want to draw
                        \ (i.e. A is acting as a mask on the colour byte)

ENDIF

IF _6502SP_VERSION OR _MASTER_VERSION \ Screen

 EOR (SC),Y             \ Draw the pixel on-screen using EOR logic, so we can
 STA (SC),Y             \ remove it later without ruining the background that's
                        \ already on-screen

 DEY                    \ Reduce Y by 1 to point to the pixel row above the one
 BPL P%+4               \ we just plotted, and if it is still positive, skip the
                        \ next instruction

 LDY #1                 \ Reducing Y by 1 made it negative, which means Y was
                        \ 0 before we did the DEY above, so set Y to 1 to point
                        \ to the pixel row after the one we just plotted

                        \ We now draw our second dash

ENDIF

IF _6502SP_VERSION \ Label

 LDA TWOS2,X            \ Fetch a mode 1 2-pixel byte with the pixels set as in
 AND S                  \ X, and AND with the colour byte we fetched into S
                        \ so that pixel takes on the colour we want to draw
                        \ (i.e. A is acting as a mask on the colour byte)

ELIF _MASTER_VERSION

 LDA TWOS2,X            \ Fetch a mode 1 2-pixel byte with the pixels set as in
 AND COL                \ X, and AND with the colour byte we fetched into COL
                        \ so that pixel takes on the colour we want to draw
                        \ (i.e. A is acting as a mask on the colour byte)

ENDIF

IF _6502SP_VERSION OR _MASTER_VERSION \ Screen

 EOR (SC),Y             \ Draw the pixel on-screen using EOR logic, so we can
 STA (SC),Y             \ remove it later without ruining the background that's
                        \ already on-screen

ENDIF

IF _6502SP_VERSION \ Platform

 LDY T1                 \ Set Y to the index of this pixel's y-coordinate byte
                        \ in the command block, which we stored in T1 above

 INY                    \ Increment Y, so it now points to the first byte of
                        \ the next pixel in the command block

 CPY Q                  \ If the index hasn't reached the value in Q (which
 BNE PXLO               \ contains the size of the pixel buffer), loop back to
                        \ PXLO to draw the next pixel in the buffer

 RTS                    \ Return from the subroutine

ELIF _MASTER_VERSION

 LDY #%00001001         \ Clear bits 1 and 2 of the Access Control Register at
 STY VIA+&34            \ SHEILA+&34 to switch main memory back into &3000-&7FFF

 LDY T1                 \ Restore Y from T1, so Y is preserved by the routine

 RTS                    \ Return from the subroutine

ENDIF

IF _6502SP_VERSION \ Platform

.PX3

                        \ If we get here, the dot is a long way away (at a
                        \ distance that is > 127), so we want to draw a 1-pixel
                        \ dot

 LDA TWOS,X             \ Fetch a mode 1 1-pixel byte with the pixel set as in
 AND S                  \ X, and AND with the colour byte we fetched into S
                        \ so that pixel takes on the colour we want to draw
                        \ (i.e. A is acting as a mask on the colour byte)

 EOR (SC),Y             \ Draw the pixel on-screen using EOR logic, so we can
 STA (SC),Y             \ remove it later without ruining the background that's
                        \ already on-screen

 LDY T1                 \ Set Y to the index of this pixel's y-coordinate byte
                        \ in the command block, which we stored in T1 above

 INY                    \ Increment Y, so it now points to the first byte of
                        \ the next pixel in the command block

 CPY Q                  \ If the index hasn't reached the value in Q (which
 BNE PXLO               \ contains the size of the pixel buffer), loop back to
                        \ PXLO to draw the next pixel in the buffer

 RTS                    \ Return from the subroutine

.PX5

                        \ If we get here then the pixel's distance value (ZZ) is
                        \ a multiple of 8, as set by the parasite's PIXEL
                        \ routine

 INY                    \ Increment Y to 3

 LDA (OSSC),Y           \ Set X to byte #3 from the Y-th pixel block in OSSC,
 TAX                    \ contains the pixel's x-coordinate

 INY                    \ Increment Y to 4

 LDA (OSSC),Y           \ Set Y to byte #4 from the Y-th pixel block in OSSC,
 STY T1                 \ which contains the pixel's y-coordinate, and store Y,
 TAY                    \ the index of this pixel's y-coordinate, in T1

 LDA ylookup,Y          \ Look up the page number of the character row that
 STA SC+1               \ contains the pixel with the y-coordinate in Y, and
                        \ store it in the high byte of SC(1 0) at SC+1

 TXA                    \ Each character block contains 8 pixel rows, so to get
 AND #%11111100         \ the address of the first byte in the character block
 ASL A                  \ that we need to draw into, as an offset from the start
                        \ of the row, we clear bits 0-1 and shift left to double
                        \ it (as each character row contains two pages of bytes,
                        \ or 512 bytes, which cover 256 pixels). This also
                        \ shifts bit 7 of the x-coordinate into the C flag

 STA SC                 \ Store the address of the character block in the low
                        \ byte of SC(1 0), so now SC(1 0) points to the
                        \ character block we need to draw into

 BCC P%+4               \ If the C flag is clear then skip the next instruction

 INC SC+1               \ The C flag is set, which means bit 7 of X1 was set
                        \ before the ASL above, so the x-coordinate is in the
                        \ right half of the screen (i.e. in the range 128-255).
                        \ Each row takes up two pages in memory, so the right
                        \ half is in the second page but SC+1 contains the value
                        \ we looked up from ylookup, which is the page number of
                        \ the first memory page for the row... so we need to
                        \ increment SC+1 to point to the correct page

 TYA                    \ Set Y to just bits 0-2 of the y-coordinate, which will
 AND #%00000111         \ be the number of the pixel row we need to draw into
 TAY                    \ within the character block

 TXA                    \ Copy bits 0-1 of the x-coordinate to bits 0-1 of X,
 AND #%00000011         \ which will now be in the range 0-3, and will contain
 TAX                    \ the two pixels to show in the character row

 LDA P                  \ Fetch the pixel's distance into P

 CMP #80                \ If the pixel's ZZ distance is >= 80, then the dot is
 BCS PX6                \ a medium distance away, so jump to PX6 to to draw a
                        \ single pixel

 LDA TWOS2,X            \ Fetch a mode 1 2-pixel byte with the pixels set as in
 AND #WHITE             \ X, and AND with #WHITE to make it white (i.e.
                        \ cyan/red)

 EOR (SC),Y             \ Draw the pixel on-screen using EOR logic, so we can
 STA (SC),Y             \ remove it later without ruining the background that's
                        \ already on-screen

 DEY                    \ Reduce Y by 1 to point to the pixel row above the one
 BPL P%+4               \ we just plotted, and if it is still positive, skip the
                        \ next instruction

 LDY #1                 \ Reducing Y by 1 made it negative, which means Y was
                        \ 0 before we did the DEY above, so set Y to 1 to point
                        \ to the pixel row after the one we just plotted

                        \ We now draw our second dash

.PX6

 LDA TWOS2,X            \ Fetch a mode 1 2-pixel byte with the pixels set as in
 AND #WHITE             \ X, and AND with #WHITE to make it white (i.e.
                        \ cyan/red)

 EOR (SC),Y             \ Draw the pixel on-screen using EOR logic, so we can
 STA (SC),Y             \ remove it later without ruining the background that's
                        \ already on-screen

 LDY T1                 \ Set Y to the index of this pixel's y-coordinate byte
                        \ in the command block, which we stored in T1 above

 INY                    \ Increment Y, so it now points to the first byte of
                        \ the next pixel in the command block

 CPY Q                  \ If the index has reached the value in Q (which
 BEQ P%+5               \ contains the size of the pixel buffer), skip the next
                        \ instruction

 JMP PXLO               \ We haven't reached the end of the buffer, so loop back
                        \ to PXLO to draw the next pixel in the buffer

 RTS                    \ Return from the subroutine

ENDIF

