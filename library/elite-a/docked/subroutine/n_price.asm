\ ******************************************************************************
\
\       Name: n_price
\       Type: Subroutine
\   Category: Buying ships
\    Summary: AJD
\
\ ******************************************************************************

.n_price

 \ put price 0 <= Y <= &C into 40-43
 LDX new_offsets,Y
 LDY #3

.n_lprice

 LDA new_price,X
 STA K,Y
 INX
 DEY
 BPL n_lprice
 RTS
