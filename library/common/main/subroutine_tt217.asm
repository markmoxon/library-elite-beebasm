\ ******************************************************************************
\
\       Name: TT217
\       Type: Subroutine
\   Category: Keyboard
\    Summary: Scan the keyboard until a key is pressed
\
\ ------------------------------------------------------------------------------
\
\ Scan the keyboard until a key is pressed, and return the key's ASCII code.
\ If, on entry, a key is already being held down, then wait until that key is
\ released first (so this routine detects the first key down event following
\ the subroutine call).
\
\ Returns:
\
\   X                   The ASCII code of the key that was pressed
\
\   A                   Contains the same as X
\
\   Y                   Y is preserved
\
\ Other entry points:
\
\   out                 Contains an RTS
\
\ ******************************************************************************

.TT217

 STY YSAV               \ Store Y in temporary storage, so we can restore it
                        \ later

.^t

IF _CASSETTE_VERSION

 JSR DELAY-5            \ Delay for 8 vertical syncs (8/50 = 0.16 seconds) so we
                        \ don't take up too much CPU time while looping round


ELIF _6502SP_VERSION

 LDY #2
 JSR DELAY

ENDIF

 JSR RDKEY              \ Scan the keyboard, starting from Q

 BNE t                  \ If a key was already being held down when we entered
                        \ this routine, keep looping back up to t, until the
                        \ key is released

.t2

 JSR RDKEY              \ Any pre-existing key press is now gone, so we can
                        \ start scanning the keyboard again, starting from Q

 BEQ t2                 \ Keep looping up to t2 until a key is pressed

 TAY                    \ Copy A to Y, so Y contains the internal key number
                        \ of the key pressed

IF _CASSETTE_VERSION

 LDA (TRTB%),Y          \ The address in TRTB% points to the MOS key
                        \ translation table, which is used to translate
                        \ internal key values to ASCII, so this fetches the
                        \ key's ASCII code into A


ELIF _6502SP_VERSION

 LDA TRANTABLE,Y        \ TRANTABLE oints to the MOS key translation table,
                        \ which is used to translate internal key values to
                        \ ASCII, so this fetches the key's ASCII code into A

ENDIF

 LDY YSAV               \ Restore the original value of Y we stored above

 TAX                    \ Copy A into X

.^out

 RTS                    \ Return from the subroutine

