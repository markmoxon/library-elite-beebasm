\ ******************************************************************************
\
\       Name: LSHIPS
\       Type: Subroutine
\   Category: Elite-A: Loader
\    Summary: AJD
\
\ ******************************************************************************

.LSHIPS

 LDA #0
 STA &9F \ reset finder

.SHIPinA

 LDX #&00
 LDA tek
 CMP #&0A
 BCS mix_station
 INX

.mix_station

 LDY #&02
 JSR install_ship
 LDY #9

.mix_retry

 LDA #0
 STA &34

.mix_match

 JSR DORND
 CMP #ship_total \ # POSSIBLE SHIPS
 BCS mix_match
 ASL A
 ASL A
 STA &35
 TYA
 AND #&07
 TAX
 LDA mix_bits,X
 LDX &35
 CPY #16
 BCC mix_byte2
 CPY #24
 BCC mix_byte3
 INX \24-28

.mix_byte3

 INX \16-23

.mix_byte2

 INX \8-15
 AND ship_bits,X
 BEQ mix_fail

.mix_try

 JSR DORND
 LDX &35
 CMP ship_bytes,X
 BCC mix_ok

.mix_fail

 DEC &34
 BNE mix_match
 LDX #ship_total*4

.mix_ok

 STY &36
 CPX #52  \ ANACONDA?
 BEQ mix_anaconda
 CPX #116 \ DRAGON?
 BEQ mix_dragon
 TXA
 LSR A
 LSR A
 TAX

.mix_install

 JSR install_ship
 LDY &36

.mix_next

 INY
 CPY #15
 BNE mix_skip
 INY
 INY

.mix_skip

 CPY #29
 BNE mix_retry
 RTS

.mix_anaconda

 LDX #13
 LDY #14
 JSR install_ship
 LDX #14
 LDY #15
 JMP mix_install

.mix_dragon

 LDX #29
 LDY #14
 JSR install_ship
 LDX #17
 LDY #15
 JMP mix_install

