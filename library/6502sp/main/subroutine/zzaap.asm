\ ******************************************************************************
\
\       Name: ZZAAP
\       Type: Subroutine
\   Category: Demo
\    Summary: 
\
\ ******************************************************************************

.ZZAAP

 LDA #RED
 JSR DOCOL
 LDA #128
 STA X1
 STA X2
 LDA #67
 STA Y1
 LDA #160
 STA Y2
 JMP LL30

