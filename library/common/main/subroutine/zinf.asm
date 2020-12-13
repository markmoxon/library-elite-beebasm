\ ******************************************************************************
\
\       Name: ZINF
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Reset the INWK workspace and orientation vectors
\
\ ------------------------------------------------------------------------------
\
\ Zero-fill the INWK ship workspace and reset the orientation vectors, with
\ nosev pointing into the screen.
\
\ Returns:
\
\   Y                   Y is set to &FF
\
\ ******************************************************************************

.ZINF

 LDY #NI%-1             \ There are NI% bytes in the INWK workspace, so set a
                        \ counter in Y so we can loop through them

 LDA #0                 \ Set A to 0 so we can zero-fill the workspace

.ZI1

 STA INWK,Y             \ Zero the Y-th byte of the INWK workspace

 DEY                    \ Decrement the loop counter

 BPL ZI1                \ Loop back for the next byte, ending when we have
                        \ zero-filled the last byte at INWK, which leaves Y
                        \ with a value of &FF

                        \ Finally, we reset the orientation vectors as follows:
                        \
                        \   sidev = (1,  0,  0)
                        \   roofv = (0,  1,  0)
                        \   nosev = (0,  0, -1)
                        \
                        \ 96 * 256 (&6000) represents 1 in the orientation
                        \ vectors, while -96 * 256 (&E000) represents -1. We
                        \ already set the vectors to zero above, so we just
                        \ need to set up the high bytes of the diagonal values
                        \ and we're done

 LDA #96                \ Set A to represent a 1 (in vector terms)

 STA INWK+18            \ Set byte #18 = roofv_y_hi = 96 = 1

 STA INWK+22            \ Set byte #22 = sidev_x_hi = 96 = 1

 ORA #128               \ Flip the sign of A to represent a -1

 STA INWK+14            \ Set byte #14 = nosev_z_hi = -96 = -1

 RTS                    \ Return from the subroutine
