\ ******************************************************************************
\
\       Name: BRP
\       Type: Subroutine
\   Category: Missions
\    Summary: Print an extended token and show the Status Mode screen
\
\ ******************************************************************************

.BRP

 JSR DETOK              \ Print the extended token in A

 JMP BAY                \ Jump to BAY to go to the docking bay (i.e. show the
                        \ Status Mode screen) and return from the subroutine
                        \ using a tail call
