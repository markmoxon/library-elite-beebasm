\ ******************************************************************************
\
\       Name: buy_invnt
\       Type: Subroutine
\   Category: Elite-A
\    Summary: AJD
\
\ ******************************************************************************

.buy_invnt

 SBC #&50
 BCC buy_top
 CMP #&0A
 BCC buy_func

.buy_top

 LDA #&01

.buy_func

 TAX
 LDA func_tab,X
 JMP FRCE

