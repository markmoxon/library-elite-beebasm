\ ******************************************************************************
\       Name: DOBULB
\ ******************************************************************************

.DOBULB

 TAX
 BNE ECBLB
 LDA #16*8
 STA SC
 LDA #&7B
 STA SC+1
 LDY #15

.BULL

 LDA SPBT,Y
 EOR (SC),Y
 STA (SC),Y
 DEY
 BPL BULL
 JMP PUTBACK

