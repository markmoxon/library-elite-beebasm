\ ******************************************************************************
\       Name: DOT
\ ******************************************************************************

.DOT

 LDA COMY
 STA DOTY1
 LDA COMX
 STA DOTX1
 LDA COMC
 STA DOTCOL
 LDX #(DOTpars MOD256)
 LDY #(DOTpars DIV256)
 LDA #DOdot
 JMP OSWORD

.DOTpars

 EQUB 5
 EQUB 0

.DOTX1

 BRK

.DOTY1

 BRK

.DOTCOL

 BRK
 RTS

