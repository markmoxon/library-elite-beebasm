\ ******************************************************************************
\
\       Name: BRIS_b0
\       Type: Subroutine
\   Category: Missions
\    Summary: Clear the screen, display "INCOMING MESSAGE" and wait for 2
\             seconds
\
\ ******************************************************************************

.BRIS_b0

 LDA #216               \ Print extended token 216 ("{clear screen}{tab 6}{move
 JSR DETOK_b2           \ to row 10, white, lower case}{white}{all caps}INCOMING
                        \ MESSAGE"

 JSR DrawViewInNMI2     \ ???

 LDY #100               \ Delay for 100 vertical syncs (100/50 = 2 seconds) and
 JMP DELAY              \ return from the subroutine using a tail call

