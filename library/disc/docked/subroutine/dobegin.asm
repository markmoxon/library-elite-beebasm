\ ******************************************************************************
\
\       Name: DOBEGIN
\       Type: Subroutine
\   Category: Loader
\    Summary: Decrypt the main docked code, initialise the configuration
\             variables and start the game
\
\ ******************************************************************************

.DOBEGIN

 JSR scramble           \ Decrypt the main docked code between &1300 and &5FFF

 JMP BEGIN              \ Jump to BEGIN to initialise the configuration
                        \ variables and start the game
