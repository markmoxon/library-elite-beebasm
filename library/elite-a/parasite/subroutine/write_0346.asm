\ ******************************************************************************
\
\       Name: write_0346
\       Type: Subroutine
\   Category: Tube
\    Summary: AJD
\
\ ******************************************************************************

.write_0346

 PHA
 LDA #&97
 JSR tube_write
 PLA
 JMP tube_write

