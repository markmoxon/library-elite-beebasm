\ ******************************************************************************
\       Name: PAS1
\ ******************************************************************************

.PAS1

 LDA #112
 STA INWK+3
 LDA #0
 STA INWK
 STA INWK+6
 LDA #2
 STA INWK+7
 JSR LL9
 JSR MVEIT
 JMP RDKEY

