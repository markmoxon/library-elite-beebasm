\ ******************************************************************************
\
\       Name: tube_read
\       Type: Subroutine
\   Category: Tube
\    Summary: AJD
\
\ ******************************************************************************

.tube_read

 BIT tube_r2s
 NOP
 BPL tube_read
 LDA tube_r2d
 RTS
