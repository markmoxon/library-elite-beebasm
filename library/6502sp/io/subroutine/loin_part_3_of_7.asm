\ ******************************************************************************
\
\       Name: LOIN (Part 3 of 7)
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ This routine draws a line from (X1, Y1) to (X2, Y2). It has multiple stages.
\
\ ******************************************************************************

 LDA #&88
 AND COL
 STA LI100+1
 LDA #&44
 AND COL
 STA LI110+1
 LDA #&22
 AND COL
 STA LI120+1
 LDA #&11
 AND COL
 STA LI130+1
 LDA SWAP
 BEQ LI190
 LDA R
 BEQ LI100+6
 CMP #2
 BCC LI110+6
 CLC
 BEQ LI120+6
 BNE LI130+6

.LI190

 DEX
 LDA R
 BEQ LI100
 CMP #2
 BCC LI110
 CLC
 BEQ LI120
 JMP LI130

.LI100

 LDA #&88
 EOR (SC),Y
 STA (SC),Y
 DEX

.LIEXS

 BEQ LIEX
 LDA S
 ADC Q
 STA S
 BCC LI110
 CLC
 DEY
 BMI LI101

.LI110

 LDA #&44
 EOR (SC),Y
 STA (SC),Y
 DEX
 BEQ LIEX
 LDA S
 ADC Q
 STA S
 BCC LI120
 CLC
 DEY
 BMI LI111

.LI120

 LDA #&22
 EOR (SC),Y
 STA (SC),Y
 DEX
 BEQ LIEX
 LDA S
 ADC Q
 STA S
 BCC LI130
 CLC
 DEY
 BMI LI121

.LI130

 LDA #&11
 EOR (SC),Y
 STA (SC),Y
 LDA S
 ADC Q
 STA S
 BCC LI140
 CLC
 DEY
 BMI LI131

.LI140

 DEX
 BEQ LIEX
 LDA SC
 ADC #8
 STA SC
 BCC LI100
 INC SC+1
 CLC
 BCC LI100

.LI101

 DEC SC+1
 DEC SC+1
 LDY #7
 BPL LI110

.LI111

 DEC SC+1
 DEC SC+1
 LDY #7
 BPL LI120

.LI121

 DEC SC+1
 DEC SC+1
 LDY #7
 BPL LI130

.LI131

 DEC SC+1
 DEC SC+1
 LDY #7
 BPL LI140

.LIEX

 RTS

