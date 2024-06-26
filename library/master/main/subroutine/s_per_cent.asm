\ ******************************************************************************
\
\       Name: S%
\       Type: Subroutine
\   Category: Loader
\    Summary: Move code, set up break handler and start the game
\
\ ******************************************************************************

 RTS                    \ This byte appears to be unused, but it might be a
                        \ hangover from the cassette version, where this byte is
                        \ used for a checksum

.S%

 CLD                    \ Clear the D flag to make sure we are in binary mode

 JSR DEEOR              \ Call DEEOR to unscramble the main code

 JSR COLD               \ Call COLD to set up the break handler

\JSR Checksum           \ This instruction is commented out in the original
                        \ source

 JMP BEGIN              \ Jump to BEGIN to start the game

