\ ******************************************************************************
\       Name: PBFL
\ by sending an OSWORD 241 command to the I/O processor
\ ******************************************************************************

.PBFL

 LDA PBUP               \ Set the first byte in pixbl (the number of bytes to
 STA pixbl              \ transmit with the OSWORD 241 command) to PBUP

 CMP #2                 \ If PBUP = 2 then jump to PBZE2 as there is no pixel
 BEQ PBZE2              \ data to transmit to the I/O processor

 LDA #2                 \ Set PBUP = 2 to reset the pixel buffer
 STA PBUP

 LDA #DUST              \ Send a #SETCOL DUST command to the I/O processor to
 JSR DOCOL              \ switch to stripe 3-2-3-2, which is cyan/red in the
                        \ space view

 LDA #241               \ Send an OSWORD 241 command to the I/O processor to
 LDX #LO(pixbl)         \ draw the pixel described in the pixbl block
 LDY #HI(pixbl)
 JSR OSWORD

.PBZE2

 LDY T1
 RTS

.PBZE

 LDA #2
 STA PBUP
 RTS
