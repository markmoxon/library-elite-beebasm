
.l_54c8

 STA &87

.l_54ca

 JSR vdu_80
 JSR l_360a
 STA &0343
 STA &034A
 STA &034B
 LDX #&60

.l_54dc

 JSR l_42a1
 INX
 CPX #&78
 BNE l_54dc
 LDX &2F
 BEQ l_54eb
 JSR l_30ac

.l_54eb

 LDY #&01
 STY cursor_y
 LDA &87
 BNE l_5507
 LDY #&0B
 STY cursor_x
 LDA view_dirn
 ORA #&60
 JSR l_339a
 JSR l_3142
 LDA #&AF
 JSR l_339a

.l_5507

 LDX #&00
 STX &34
 STX &35
 STX vdu_stat
 DEX
 STX &36
 JSR l_1868
 LDA #&02
 STA &34
 STA &36
 JSR l_551e

.l_551e

 JSR l_5521

.l_5521

 LDA #&00
 STA &35
 LDA #&BF
 STA &37
 DEC &34
 DEC &36
 JMP l_16c4

.l_5530

 JSR l_55f7
 DEY
 BNE l_5530
 RTS

.l_5537

 LDA #&14
 STA cursor_y
 LDA #&75
 STA ptr+&01
 LDA #&07
 STA ptr
 JSR l_2b60
 LDA #&00
 JSR l_5550
 INC ptr+&01
 INY
 STY cursor_x

.l_5550

 LDY #&E9

.l_5552

 STA (ptr),Y
 DEY
 BNE l_5552

.l_5557

 RTS

.iff_xor

 EQUB &00, &00, &0F	\, &FF, &F0 overlap

.iff_base

 EQUB &FF, &F0, &FF, &F0, &FF

.l_5558

 LDA &65
 AND #&10
 BEQ l_5557
 LDA &8C
 BMI l_5557
 JSR iff_index
 LDA iff_base,X
 STA &91
 LDA iff_xor,X
 STA &37
 LDA &47
 ORA &4A
 ORA &4D
 AND #&C0
 BNE l_5557
 LDA &47
 CLC
 LDX &48
 BPL l_5581
 EOR #&FF
 ADC #&01

.l_5581

 ADC #&7B
 STA &34
 LDA &4D
 LSR A
 LSR A
 CLC
 LDX &4E
 BPL l_5591
 EOR #&FF
 SEC

.l_5591

 ADC #&23
 EOR #&FF
 STA ptr
 LDA &4A
 LSR A
 CLC
 LDX &4B
 BMI l_55a2
 EOR #&FF
 SEC

.l_55a2

 ADC ptr
 BPL l_55b0
 CMP #&C2
 BCS l_55ac
 LDA #&C2

.l_55ac

 CMP #&F7
 BCC l_55b2

.l_55b0

 LDA #&F6

.l_55b2

 STA &35
 SEC
 SBC ptr
 \	PHP
 PHA
 JSR l_36a7
 LDA pixels+&11,X
 TAX
 AND &91	\ iff
 STA &34
 TXA
 AND &37
 STA &35
 PLA
 \	PLP
 TAX
 BEQ l_55da
 \	BCC l_55db
 BMI l_55db

.l_55ca

 DEY
 BPL l_55d1
 LDY #&07
 DEC ptr+&01

.l_55d1

 LDA &34
 EOR &35	\ iff
 STA &34	\ iff
 EOR (ptr),Y
 STA (ptr),Y
 DEX
 BNE l_55ca

.l_55da

 RTS

.l_55db

 INY
 CPY #&08
 BNE l_55e4
 LDY #&00
 INC ptr+&01

.l_55e4

 INY
 CPY #&08
 BNE l_55ed
 LDY #&00
 INC ptr+&01

.l_55ed

 LDA &34
 EOR &35	\ iff
 STA &34	\ iff
 EOR (ptr),Y
 STA (ptr),Y
 INX
 BNE l_55e4
 RTS

.l_55f7

 LDA #&00
 STA &8B

.l_55fb

 LDA &8B
 BEQ l_55fb
 RTS 
