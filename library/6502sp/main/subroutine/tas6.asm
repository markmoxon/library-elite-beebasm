\ ******************************************************************************
\       Name: TAS6
\ ******************************************************************************

.TAS6

 LDA XX15
 EOR #128
 STA XX15
 LDA XX15+1
 EOR #128
 STA XX15+1
 LDA XX15+2
 EOR #128
 STA XX15+2
 RTS
