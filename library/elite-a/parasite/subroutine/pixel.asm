\ ******************************************************************************
\
\       Name: PIXEL
\       Type: Subroutine
\   Category: Drawing pixels
\    Summary: Draw a 1-pixel dot, 2-pixel dash or 4-pixel square by sending a
\             draw_pixel command to the I/O processor
\
\ ------------------------------------------------------------------------------
\
\ Draw a point at screen coordinate (X, A) with the point size determined by the
\ distance in ZZ. This applies to the top part of the screen (the monochrome
\ mode 4 portion).
\
\ Arguments:
\
\   X                   The screen x-coordinate of the point to draw
\
\   A                   The screen y-coordinate of the point to draw
\
\   ZZ                  The distance of the point (further away = smaller point)
\
\ ******************************************************************************

.PIXEL

 PHA                    \ Store the y-coordinate on the stack

 LDA #&82               \ Send command &82 to the I/O processor:
 JSR tube_write         \
                        \   draw_pixel(x, y, distance)
                        \
                        \ which will draw a pixel at (x, y) with the size
                        \ determined by the distance

 TXA                    \ Send the first parameter to the I/O processor:
 JSR tube_write         \
                        \   * x = X

 PLA                    \ Send the second parameter to the I/O processor:
 JSR tube_write         \
                        \   * y = A

 LDA ZZ                 \ Send the third parameter to the I/O processor:
 JMP tube_write         \
                        \   * distance = ZZ
                        \
                        \ and return from the subroutine using a tail call

