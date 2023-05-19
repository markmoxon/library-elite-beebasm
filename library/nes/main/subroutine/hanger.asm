\ ******************************************************************************
\
\       Name: HANGER
\       Type: Subroutine
\   Category: Ship hangar
\    Summary: Display the ship hangar
\
\ ******************************************************************************

.CB575

 EQUB &50, &58          \ ???
 EQUB &62, &78

.HANGER

 LDX #0                 \ ???

.CB57B

 STX TGT
 LDA CB575,X
 TAY
 LDA #8
 LDX #&1C
 JSR HAL3
 LDA #&F0
 LDX #&1C
 JSR HAS3
 LDA HANGFLAG
 BEQ HA2
 LDA #&80
 LDX #&0C
 JSR HAL3
 LDA #&7F
 LDX #&0C
 JSR HAS3
.HA2
 LDX TGT
 INX
 CPX #4
 BNE CB57B
 JSR DORND
 AND #7
 ORA #4
 LDY #0
.loop_CB5B2
 JSR HAS2
 CLC
 ADC #&0A
 BCS CB5BE
 CMP #&F8
 BCC loop_CB5B2
.CB5BE
 RTS
