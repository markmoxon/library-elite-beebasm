\ ******************************************************************************
\
\       Name: DOCOL
\       Type: Subroutine
\   Category: Text
\    Summary: Set the text colour by sending a #SETCOL command to the I/O
\             processor
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The text colour
\
\ ******************************************************************************

.DOCOL

 PHA                    \ Store A, the colour number, on the stack

 LDA #SETCOL            \ Set A to #SETCOL, ready to send to the I/O processor

 BNE label              \ Jump to label to send a #SETCOL <colour> command to
                        \ the I/O processor, returning from the subroutine
                        \ using a tail call (this BNE is effectively a JMP as A
                        \ is never zero)

