\ ******************************************************************************
\
\       Name: SLIDE
\       Type: Subroutine
\   Category: Demo
\    Summary: Display a Star Wars scroll text
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   (Y X)               The contents of the first slide
\
\ ******************************************************************************

.SLIDE

 JSR GRIDSET

 JSR ZEVB               \ Call ZEVB to zero-fill the Y1VB variable

 LDA #YELLOW
 JSR DOCOL
 LDA #254
 STA BALI

.SLL2

 JSR GRID
 DEC BALI
 DEC BALI
 BNE SLL2

.SL1

 JSR ZEVB               \ Call ZEVB to zero-fill the Y1VB variable

 LDA #2
 STA BALI

.GRID

 LDY #0
 STY UPO
 STY INWK+8
 STY INWK+1
 STY INWK+4
 DEY

.GRIDL

 INY
 STZ INWK+7 \++
 LDA Y1TB,Y
 BNE P%+5
 JMP GREX
 SEC
 SBC BALI
 BCC GRIDL
 STA R
 ASL A
 ROL INWK+7
 ASL A
 ROL INWK+7
 ADC #D
 STA INWK+6
 LDA INWK+7
 ADC #0
 STA INWK+7
 STZ S
 LDA #128
 STA P
 JSR ADD
 STA INWK+5
 STX INWK+3
 LDA X1TB,Y
 EOR #128
 BPL GR2
 EOR #&FF
 INA \++

.GR2

 STA INWK
 LDA X1TB,Y
 EOR #128
 AND #128
 STA INWK+2
 STY YS
 JSR PROJ
 LDY YS
 LDA K3
 STA XX15
 LDA K3+1
 STA XX15+1
 LDA K4
 STA XX15+2
 LDA K4+1
 STA XX15+3
 STZ INWK+7 \++
 LDA Y2TB,Y
 SEC
 SBC BALI
 BCC GR6
 STA R
 ASL A
 ROL INWK+7
 ASL A
 ROL INWK+7
 ADC #D
 STA INWK+6
 LDA INWK+7
 ADC #0
 STA INWK+7
 STZ S
 LDA #128
 STA P
 JSR ADD
 STA INWK+5
 STX INWK+3
 LDA X2TB,Y
 EOR #128
 BPL GR3
 EOR #&FF
 INA \++

.GR3

 STA INWK
 LDA X2TB,Y
 EOR #128
 AND #128
 STA INWK+2
 JSR PROJ
 LDA K3
 STA XX15+4
 LDA K3+1
 STA XX15+5
 LDA K4
 STA XX12
 LDA K4+1
 STA XX12+1
 JSR LL145
 LDY YS
 BCS GR6
 INC UPO
 LDX UPO
 LDA X1
 STA X1UB,X
 LDA Y1
 STA Y1UB,X
 LDA X2
 STA X2UB,X
 LDA Y2
 STA Y2UB,X

.GR6

 JMP GRIDL

.GREX

 LDY UPO
 BEQ GREX2

.GRL2

 LDA Y1VB,Y
 BEQ GR4
 STA Y1
 LDA X1VB,Y
 STA X1
 LDA X2VB,Y
 STA X2
 LDA Y2VB,Y
 STA Y2

 JSR LOIN               \ Draw a line from (X1, Y1) to (X2, Y2)

.GR4

 LDA X1UB,Y
 STA X1
 STA X1VB,Y
 LDA Y1UB,Y
 STA Y1
 STA Y1VB,Y
 LDA X2UB,Y
 STA X2
 STA X2VB,Y
 LDA Y2UB,Y
 STA Y2
 STA Y2VB,Y

 JSR LOIN               \ Draw a line from (X1, Y1) to (X2, Y2)

 DEY
 BNE GRL2
 JSR LBFL

.GREX2

 RTS

