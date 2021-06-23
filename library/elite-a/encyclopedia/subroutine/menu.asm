\ ******************************************************************************
\
\       Name: menu
\       Type: Subroutine
\   Category: Encyclopedia
\    Summary: AJD
\
\ ******************************************************************************

.menu

 LDA menu_entry,X
 STA QQ25
 LDA menu_offset,X
 STA QQ29
 LDA menu_query,X
 PHA
 LDA menu_title,X
 PHA
 LDA menu_titlex,X
 PHA
 LDA #&20
 JSR TT66
 JSR MT1
 PLA
 STA XC
 PLA
 JSR write_msg3
 JSR NLIN4

IF _ELITE_A_ENCYCLOPEDIA

 JSR MT2
 LDA #&80
 STA QQ17

ENDIF

 INC YC
 LDX #&00

.menu_loop

 STX XX13
 JSR TT67
 LDX XX13
 INX
 CLC
 JSR pr2
 JSR TT162

IF _ELITE_A_6502SP_PARA

 JSR MT2
 LDA #&80
 STA QQ17

ENDIF

 CLC
 LDA XX13
 ADC QQ29
 JSR write_msg3
 LDX XX13
 INX
 CPX QQ25
 BCC menu_loop
 JSR CLYNS
 PLA
 JSR write_msg3
 LDA #'?'
 JSR DASC
 JSR gnum
 BEQ menu_start
 BCS menu_start
 RTS

.menu_start

 JMP BAY
