\ ******************************************************************************
\
\       Name: TT217
\       Type: Subroutine
\   Category: Elite-A: Keyboard
\    Summary: AJD
\
\ ******************************************************************************


.TT217

.t

 LDA #&8D
 JSR tube_write
 JSR tube_read
 TAX

.out

 RTS

