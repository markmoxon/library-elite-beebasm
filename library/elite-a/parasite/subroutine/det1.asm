\ ******************************************************************************
\
\       Name: DET1
\       Type: Subroutine
\   Category: Screen mode
\    Summary: AJD
\
\ ******************************************************************************

.DET1

 LDA #&95
 JSR tube_write
 TXA
 JMP tube_write
