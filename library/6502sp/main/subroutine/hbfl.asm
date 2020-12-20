\ ******************************************************************************
\
\       Name: HBFL
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: Draw a horizontal line by sending an OSWORD 247 command to the I/O
\             processor
\
\ ******************************************************************************

.HBFL

 LDA HBUP
 STA HBUF
 CMP #2
 BEQ HBZE2
 LDA #2
 STA HBUP
 LDA #247

 LDX #LO(HBUF)          \ Set (Y X) to point to the HBUF parameter block
 LDY #HI(HBUF)

 JSR OSWORD

.HBZE2

 LDY T1
 RTS

.HBZE

 LDA #2
 STA HBUP
 RTS

