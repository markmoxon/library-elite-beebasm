
.run_tcode

 JSR clr_common
 JMP dcode_in

.d_1220

 JSR clr_common
 JMP dead_in

.d_1228

 LDA &0900
 STA &00
 LDX adval_x
 CPX new_max
 BCC n_highx
 LDX new_max

.n_highx

 CPX new_min
 BCS n_lowx
 LDX new_min

.n_lowx

 JSR d_29ff
 JSR d_29ff
 TXA
 EOR #&80
 TAY
 AND #&80
 STA &32
 STX adval_x
 EOR #&80
 STA &33
 TYA
 BPL d_124d
 EOR #&FF
 CLC
 ADC #&01

.d_124d

 LSR A
 LSR A
 CMP #&08
 BCS d_1254
 LSR A

.d_1254

 STA &31
 ORA &32
 STA &8D
 LDX adval_y
 CPX new_max
 BCC n_highy
 LDX new_max

.n_highy

 CPX new_min
 BCS n_lowy
 LDX new_min

.n_lowy

 JSR d_29ff
 TXA
 EOR #&80
 TAY
 AND #&80
 STX adval_y
 STA &7C
 EOR #&80
 STA &7B
 TYA
 BPL d_1274
 EOR #&FF

.d_1274

 ADC #&04
 LSR A
 LSR A
 LSR A
 LSR A
 CMP #&03
 BCS d_127f
 LSR A

.d_127f

 STA &2B
 ORA &7B
 STA &2A
 LDA &0302
 BEQ d_12ab
 LDA &7D
 CMP new_speed
 BCC speed_up

.d_12ab

 LDA &0301
 BEQ d_12b6
 DEC &7D
 BNE d_12b6

.speed_up

 INC &7D

.d_12b6

 LDA &030B
 AND cmdr_misl
 BEQ d_12cd
 LDY #&EE
 JSR d_3805
 JSR d_439f
 LDA #&00
 STA target

.d_12cd

 LDA &45
 BPL d_12e3
 LDA &030A
 BEQ d_12e3
 LDX cmdr_misl
 BEQ d_12e3
 STA target
 LDY #&E0
 DEX
 JSR d_383d

.d_12e3

 LDA &030C
 BEQ d_12ef
 LDA &45
 BMI d_1326
 JSR d_252e

.d_12ef

 LDA &0308
 AND cmdr_bomb
 BEQ d_12f7
 INC cmdr_bomb
 INC new_hold	\***
 JSR rnd_seq
 STA data_homex	\cmdr_homex
 STX data_homey	\cmdr_homey
 JSR snap_hype
 JSR hyper_snap

.d_12f7

 LDA &030F
 AND cmdr_dock
 BNE dock_toggle
 LDA &0310
 BEQ d_1301
 LDA #&00

.dock_toggle

 STA &033F

.d_1301

 LDA &0309
 AND cmdr_escape
 BEQ d_130c
 JMP d_20c1

.d_130c

 LDA &030E
 BEQ d_1314
 JSR d_434e

.d_1314

 LDA &030D
 AND cmdr_ecm
 BEQ d_1326
 LDA &30
 BNE d_1326
 DEC &0340
 JSR d_3813

.d_1326

 LDA #&00
 STA &44
 STA &7E
 LDA &7D
 LSR A
 ROR &7E
 LSR A
 ROR &7E
 STA &7F
 JSR read_0346
 BNE d_1374
 LDA &0307
 BEQ d_1374
 LDA laser_t
 CMP #&F2
 BCS d_1374
 LDX view_dirn
 LDA cmdr_laser,X
 BEQ d_1374
 PHA
 AND #&7F
 STA &0343
 STA &44
 LDA #&00
 JSR sound
 JSR d_2a82
 PLA
 BPL d_136f
 LDA #&00

.d_136f

 JSR write_0346

.d_1374

 LDX #&00

.d_1376

 STX &84
 LDA ship_type,X
 BNE aaaargh
 JMP d_153f

.aaaargh

 STA &8C
 JSR ship_ptr
 LDY #&24

.d_1387

 LDA (&20),Y
 STA &46,Y
 DEY
 BPL d_1387
 LDA &8C
 BMI d_13b6
 ASL A
 TAY
 LDA ship_data,Y
 STA &1E
 LDA ship_data+1,Y
 STA &1F

.d_13b6

 JSR d_50a0
 LDY #&24

.d_13bb

 LDA &46,Y
 STA (&20),Y
 DEY
 BPL d_13bb
 LDA &65
 AND #&A0
 JSR d_41bf
 BNE d_141d
 LDA &46
 ORA &49
 ORA &4C
 BMI d_141d
 LDX &8C
 BMI d_141d
 CPX #&02
 BEQ d_1420
 AND #&C0
 BNE d_141d
 CPX #&01
 BEQ d_141d
 LDA cmdr_scoop
 AND &4B
 BPL d_1464
 CPX #&05
 BEQ d_13fd
 LDY #&00
 LDA (&1E),Y
 LSR A
 LSR A
 LSR A
 LSR A
 BEQ d_1464
 ADC #&01
 BNE d_1402

.d_13fd

 JSR rnd_seq
 \	AND #&07
 AND #&0F

.d_1402

 TAX
 JSR d_2aec
 BCS d_1464
 INC cmdr_cargo,X
 TXA
 ADC #&D0
 JSR d_45c6
 JSR top_6a

.d_141d

 JMP d_1473

.d_1420

 LDA &0949
 AND #&04
 BNE d_1449
 LDA &54
 CMP #&D6
 BCC d_1449
 LDY #&25
 JSR d_42ae
 LDA &36
 CMP #&56
 BCC d_1449
 LDA &56
 AND #&7F
 CMP #&50
 BCC d_1449

.d_143e

 JSR clr_common
 LDA #&08
 JSR d_263d
 JMP run_tcode
 \d_1452
 \	JSR d_43b1
 \	JSR d_2160
 \	BNE d_1473

.d_1449

 LDA &7D
 CMP #&05
 BCS n_crunch
 LDA &033F
 AND #&04
 EOR #&05
 BNE d_146d

.d_1464

 LDA #&40
 JSR n_hit
 JSR anger_8c

.n_crunch

 LDA #&80

.d_146d

 JSR n_through
 JSR d_43b1

.d_1473

 LDA &6A
 BPL d_147a
 JSR d_5558

.d_147a

 LDA &87
 BNE d_14f0
 LDX view_dirn
 BEQ d_1486
 JSR d_5404

.d_1486

 JSR d_24c7
 BCC d_14ed
 LDA target
 BEQ d_149a
 JSR sound_20
 LDX &84
 LDY #&0E
 JSR d_3807

.d_149a

 LDA &44
 BEQ d_14ed
 LDX #&0F
 JSR d_43dd
 LDA &44
 LDY &8C
 CPY #&02
 BEQ d_14e8
 CPY #&1F
 BNE d_14b7
 LSR A

.d_14b7

 LSR A
 JSR n_hit	\ hit enemy
 BCS d_14e6
 LDA &8C
 CMP #&07
 BNE d_14d9
 LDA &44
 CMP new_mining
 BNE d_14d9
 JSR rnd_seq
 LDX #&08
 AND #&03
 JSR d_1687

.d_14d9

 LDY #&04
 JSR d_1678
 LDY #&05
 JSR d_1678
 JSR d_43ce

.d_14e6


.d_14e8

 JSR anger_8c

.d_14ed

 JSR d_488c

.d_14f0

 LDY #&23
 LDA &69
 STA (&20),Y
 LDA &6A
 BMI d_1527
 LDA &65
 BPL d_152a
 AND #&20
 BEQ d_152a
 BIT &6A	\ A=&20
 BVS n_badboy
 BEQ n_goodboy
 LDA #&80

.n_badboy

 ASL A
 ROL A

.n_bitlegal

 LSR A
 BIT cmdr_legal
 BNE n_bitlegal
 ADC cmdr_legal
 BCS d_1527
 STA cmdr_legal
 BCC d_1527

.n_goodboy

 LDA &034A
 ORA &0341
 BNE d_1527
 LDY #&0A
 LDA (&1E),Y
 TAX
 INY
 LDA (&1E),Y
 TAY
 JSR add_money
 LDA #&00
 JSR d_45c6

.d_1527

 JMP d_3d7f

.n_hit

 \ hit opponent
 STA &D1
 SEC
 LDY #&0E	\ opponent shield
 LDA (&1E),Y
 AND #&07
 SBC &D1
 BCS n_kill
 \	BCC n_defense
 \	LDA #0
 \n_defense
 CLC
 ADC &69
 STA &69
 BCS n_kill
 JSR d_2160

.n_kill

 \ C clear if dead
 RTS

.d_152a

 LDA &8C
 BMI d_1533
 JSR d_41b2
 BCC d_1527

.d_1533

 LDY #&1F
 LDA &65
 STA (&20),Y
 LDX &84
 INX
 JMP d_1376

.d_153f

 LDA &8A
 AND #&07
 BNE d_15c2
 LDX energy
 BPL d_156c
 LDX r_shield
 JSR d_3626
 STX r_shield
 LDX f_shield
 JSR d_3626
 STX f_shield

.d_156c

 SEC
 LDA cmdr_eunit
 ADC energy
 BCS d_1578
 STA energy

.d_1578

 LDA &0341
 BNE d_15bf
 LDA &8A
 AND #&1F
 BNE d_15cb
 LDA &0320
 BNE d_15bf
 TAY
 JSR d_1c43
 BNE d_15bf
 LDX #&1C

.d_1590

 LDA &0900,X
 STA &46,X
 DEX
 BPL d_1590
 INX
 LDY #&09
 JSR d_1c20
 BNE d_15bf
 LDX #&03
 LDY #&0B
 JSR d_1c20
 BNE d_15bf
 LDX #&06
 LDY #&0D
 JSR d_1c20
 BNE d_15bf
 LDA #&C0
 JSR d_41b4
 BCC d_15bf
 JSR d_3c30
 JSR d_3740

.d_15bf

 JMP d_1648

.d_15c2

 LDA &0341
 BNE d_15bf
 LDA &8A
 AND #&1F

.d_15cb

 CMP #&0A
 BNE d_15fd
 LDA #&32
 CMP energy
 BCC d_15da
 ASL A
 JSR d_45c6

.d_15da

 LDY #&FF
 STY altitude
 INY
 JSR d_1c41
 BNE d_1648
 JSR d_1c4f
 BCS d_1648
 SBC #&24
 BCC d_15fa
 STA &82
 JSR sqr_root
 LDA &81
 STA altitude
 BNE d_1648

.d_15fa

 JMP d_41c6

.d_15fd

 CMP #&0F
 BNE d_160a
 LDA &033F
 BEQ d_1648
 LDA #&7B
 BNE d_1645

.d_160a

 CMP #&14
 BNE d_1648
 LDA #&1E
 STA cabin_t
 LDA &0320
 BNE d_1648
 LDY #&25
 JSR d_1c43
 BNE d_1648
 JSR d_1c4f
 EOR #&FF
 ADC #&1E
 STA cabin_t
 BCS d_15fa
 CMP #&E0
 BCC d_1648
 LDA cmdr_scoop
 BEQ d_1648
 LDA &7F
 LSR A
 ADC cmdr_fuel
 CMP new_range
 BCC d_1640
 LDA new_range

.d_1640

 STA cmdr_fuel
 LDA #&A0

.d_1645

 JSR d_45c6

.d_1648

 LDA &0343
 BEQ d_165c
 JSR read_0346	\LDA &0346
 CMP #&08
 BCS d_165c
 JSR d_2aa1
 LDA #&00
 STA &0343

.d_165c

 LDA &0340
 BEQ d_1666
 JSR d_3629
 BEQ d_166e

.d_1666

 LDA &30
 BEQ d_1671
 DEC &30
 BNE d_1671

.d_166e

 JSR sound_0

.d_1671

 LDA &87
 BNE d_1694
 JMP d_1a25

.d_1678

 JSR rnd_seq
 BPL d_1694
 PHA
 TYA
 TAX
 PLA
 LDY #&00
 AND (&1E),Y
 AND #&0F

.d_1687

 STA &93
 BEQ d_1694

.d_168b

 LDA #&00
 JSR d_2592
 DEC &93
 BNE d_168b

.d_1694

 RTS

.d_1907

 JSR scale_angle
 STA &27
 TXA
 STA &0F95,Y

.d_1910

 LDA &34
 BPL d_1919
 EOR #&7F
 CLC
 ADC #&01

.d_1919

 EOR #&80
 TAX
 LDA &35
 AND #&7F
 CMP #&60
 BCS d_196a
 LDA &35
 BPL d_192c
 EOR #&7F
 ADC #&01

.d_192c

 STA &D1
 LDA #&61
 SBC &D1
 JMP draw_pixel

.d_196a

 RTS

.d_1a05

 LDY &03C3

.d_1a08

 LDX &0F82,Y
 LDA &0F5C,Y
 STA &35
 STA &0F82,Y
 TXA
 STA &34
 STA &0F5C,Y
 LDA &0FA8,Y
 STA &88
 JSR d_1910
 DEY
 BNE d_1a08
 RTS

.d_1a25

 LDX view_dirn
 BEQ d_1a33
 DEX
 BNE d_1a30
 JMP d_1b20

.d_1a30

 JMP d_2679

.d_1a33

 LDY &03C3

.d_1a36

 JSR d_295e
 LDA &82
 LSR &1B
 ROR A
 LSR &1B
 ROR A
 ORA #&01
 STA &81
 LDA &0FBB,Y
 SBC &7E
 STA &0FBB,Y
 LDA &0FA8,Y
 STA &88
 SBC &7F
 STA &0FA8,Y
 JSR d_2817
 STA &27
 LDA &1B
 ADC &0F95,Y
 STA &26
 STA &82
 LDA &35
 ADC &27
 STA &27
 STA &83
 LDA &0F5C,Y
 STA &34
 JSR d_281c
 STA &25
 LDA &1B
 ADC &0F6F,Y
 STA &24
 LDA &34
 ADC &25
 STA &25
 EOR &33
 JSR d_27c6
 JSR scale_angle
 STA &27
 STX &26
 EOR &32
 JSR d_27be
 JSR scale_angle
 STA &25
 STX &24
 LDX &2B
 LDA &27
 EOR &7C
 JSR d_27c8
 STA &81
 JSR d_289e
 ASL &1B
 ROL A
 STA &D1
 LDA #&00
 ROR A
 ORA &D1
 JSR scale_angle
 STA &25
 TXA
 STA &0F6F,Y
 LDA &26
 STA &82
 LDA &27
 STA &83
 LDA #&00
 STA &1B
 LDA &2A
 EOR #&80
 JSR d_1907
 LDA &25
 STA &34
 STA &0F5C,Y
 AND #&7F
 CMP #&78
 BCS d_1afd
 LDA &27
 STA &0F82,Y
 STA &35
 AND #&7F
 CMP #&78
 BCS d_1afd
 LDA &0FA8,Y
 CMP #&10
 BCC d_1afd
 STA &88

.d_1af3

 JSR d_1910
 DEY
 BEQ d_1afc
 JMP d_1a36

.d_1afc

 RTS

.d_1afd

 JSR rnd_seq
 ORA #&04
 STA &35
 STA &0F82,Y
 JSR rnd_seq
 ORA #&08
 STA &34
 STA &0F5C,Y
 JSR rnd_seq
 ORA #&90
 STA &0FA8,Y
 STA &88
 LDA &35
 JMP d_1af3

.d_1b20

 LDY &03C3

.d_1b23

 JSR d_295e
 LDA &82
 LSR &1B
 ROR A
 LSR &1B
 ROR A
 ORA #&01
 STA &81
 LDA &0F5C,Y
 STA &34
 JSR d_281c
 STA &25
 LDA &0F6F,Y
 SBC &1B
 STA &24
 LDA &34
 SBC &25
 STA &25
 JSR d_2817
 STA &27
 LDA &0F95,Y
 SBC &1B
 STA &26
 STA &82
 LDA &35
 SBC &27
 STA &27
 STA &83
 LDA &0FBB,Y
 ADC &7E
 STA &0FBB,Y
 LDA &0FA8,Y
 STA &88
 ADC &7F
 STA &0FA8,Y
 LDA &25
 EOR &32
 JSR d_27c6
 JSR scale_angle
 STA &27
 STX &26
 EOR &33
 JSR d_27be
 JSR scale_angle
 STA &25
 STX &24
 LDA &27
 EOR &7C
 LDX &2B
 JSR d_27c8
 STA &81
 LDA &25
 STA &83
 EOR #&80
 JSR d_28a2
 ASL &1B
 ROL A
 STA &D1
 LDA #&00
 ROR A
 ORA &D1
 JSR scale_angle
 STA &25
 TXA
 STA &0F6F,Y
 LDA &26
 STA &82
 LDA &27
 STA &83
 LDA #&00
 STA &1B
 LDA &2A
 JSR d_1907
 LDA &25
 STA &34
 STA &0F5C,Y
 LDA &27
 STA &0F82,Y
 STA &35
 AND #&7F
 CMP #&6E
 BCS d_1bea
 LDA &0FA8,Y
 CMP #&A0
 BCS d_1bea
 STA &88

.d_1be0

 JSR d_1910
 DEY
 BEQ d_1be9
 JMP d_1b23

.d_1bea

 JSR rnd_seq
 AND #&7F
 ADC #&0A
 STA &0FA8,Y
 STA &88
 LSR A
 BCS d_1c0d
 LSR A
 LDA #&FC
 ROR A
 STA &34
 STA &0F5C,Y
 JSR rnd_seq
 STA &35
 STA &0F82,Y
 JMP d_1be0

.d_1c0d

 JSR rnd_seq
 STA &34
 STA &0F5C,Y
 LSR A
 LDA #&E6
 ROR A
 STA &35
 STA &0F82,Y
 BNE d_1be0

.d_1c20

 LDA &46,Y
 ASL A
 STA &41
 LDA &47,Y
 ROL A
 STA &42
 LDA #&00
 ROR A
 STA &43
 JSR d_1d4c
 STA &48,X
 LDY &41
 STY &46,X
 LDY &42
 STY &47,X
 AND #&7F

.d_1be9

 RTS

.d_1c41

 LDA #&00

.d_1c43

 ORA &0902,Y
 ORA &0905,Y
 ORA &0908,Y
 AND #&7F
 RTS

.d_1c4f

 LDA &0901,Y
 JSR square
 STA &82
 LDA &0904,Y
 JSR square
 ADC &82
 BCS d_1c6d
 STA &82
 LDA &0907,Y
 JSR square
 ADC &82
 BCC d_1c6f

.d_1c6d

 LDA #&FF

.d_1c6f

 RTS

.d_1d4c

 LDA &43
 STA &83
 AND #&80
 STA &D1
 EOR &48,X
 BMI d_1d70
 LDA &41
 CLC
 ADC &46,X
 STA &41
 LDA &42
 ADC &47,X
 STA &42
 LDA &43
 ADC &48,X
 AND #&7F
 ORA &D1
 STA &43
 RTS

.d_1d70

 LDA &83
 AND #&7F
 STA &83
 LDA &46,X
 SEC
 SBC &41
 STA &41
 LDA &47,X
 SBC &42
 STA &42
 LDA &48,X
 AND #&7F
 SBC &83
 ORA #&80
 EOR &D1
 STA &43
 BCS d_1da7
 LDA #&01
 SBC &41
 STA &41
 LDA #&00
 SBC &42
 STA &42
 LDA #&00
 SBC &43
 AND #&7F
 ORA &D1
 STA &43

.d_1da7

 RTS

.d_20c1

 JSR clr_common
 LDX #&03	\ escape capsule
 STX &8C
 JSR d_2508
 LDA #&10
 STA &61
 LDA #&C2
 STA &64
 LSR A
 STA &66

.d_20dd

 JSR d_50a0
 JSR d_488c
 DEC &66
 BNE d_20dd
 JSR d_5558
 LDA #&00
 STA cmdr_cargo+&10
 LDX #&0C	\LDX #&10	\ save gold/plat/gems

.d_20ee

 STA cmdr_cargo,X
 DEX
 BPL d_20ee
 STA cmdr_legal
 STA cmdr_escape
 INC new_hold	\**
 LDA new_range
 STA cmdr_fuel
 JSR update_pod
 JSR set_home
 JSR snap_hype
 JSR data_home
 JMP d_143e

.d_2102

 LDA #&00
 JSR d_41bf
 BEQ d_210c
 JMP d_21c5

.d_210c

 JSR d_2160
 JSR d_43b1
 LDA #&FA
 JMP d_36e4

.d_2117

 LDA &30
 BNE d_2150
 LDA &66
 ASL A
 BMI d_2102
 LSR A
 TAX
 LDA ship_addr,X
 STA &22
 LDA ship_addr+&01,X
 JSR d_2409
 LDA &D4
 ORA &D7
 ORA &DA
 AND #&7F
 ORA &D3
 ORA &D6
 ORA &D9
 BNE d_2166
 LDA &66
 CMP #&82
 BEQ d_2150
 LDY #&23	\ missile damage
 SEC
 LDA (&22),Y
 SBC #&40
 BCS n_misshit
 LDY #&1F
 LDA (&22),Y
 BIT d_216d+&01
 BNE d_2150
 ORA #&80	\ missile hits

.n_misshit

 STA (&22),Y

.d_2150

 LDA &46
 ORA &49
 ORA &4C
 BNE d_215d
 LDA #&50
 JSR d_36e4

.d_215d

 JSR d_43ce

.d_2160

 ASL &65
 SEC
 ROR &65

.d_2165

 RTS

.d_2166

 JSR rnd_seq
 CMP #&10
 BCS d_2174

.d_216d

 LDY #&20
 LDA (&22),Y
 LSR A
 BCS d_2177

.d_2174

 JMP d_221a

.d_2177

 JMP d_3813

.d_217a

 LDY #&03
 STY &99
 INY
 STY &9A
 LDA #&16
 STA &94
 CPX #&01
 BEQ d_2117
 CPX #&02
 BNE d_21bb
 LDA &6A
 AND #&04
 BNE d_21a6
 LDA &0328
 ORA &033F	\ no shuttles if docking computer on
 BNE d_2165
 JSR rnd_seq
 CMP #&FD
 BCC d_2165
 AND #&01
 ADC #&08
 TAX
 BNE d_21b6	\ BRA

.d_21a6

 JSR rnd_seq
 CMP #&F0
 BCC d_2165
 LDA &032E
 CMP #&07	\ viper hordes
 BCS d_21d4
 LDX #&10

.d_21b6

 LDA #&F1
 JMP d_2592

.d_21bb

 LDY #&0E
 LDA &69
 CMP (&1E),Y
 BCS d_21c5
 INC &69

.d_21c5

 CPX #&1E
 BNE d_21d5
 LDA &033B
 BNE d_21d5
 LSR &66
 ASL &66
 LSR &61

.d_21d4

 RTS

.d_21d5

 JSR rnd_seq
 LDA &6A
 LSR A
 BCC d_21e1
 CPX #&64
 BCS d_21d4

.d_21e1

 LSR A
 BCC d_21f3
 LDX cmdr_legal
 CPX #&28
 BCC d_21f3
 LDA &6A
 ORA #&04
 STA &6A
 LSR A
 LSR A

.d_21f3

 LSR A
 BCS d_2203
 LSR A
 LSR A
 BCC d_21fd
 JMP d_2346

.d_21fd

 LDY #&00
 JSR d_42ae
 JMP d_2324

.d_2203

 LSR A
 BCC d_2211
 LDA &0320
 BEQ d_2211
 LDA &66
 AND #&81
 STA &66

.d_2211

 LDX #&08

.d_2213

 LDA &46,X
 STA &D2,X
 DEX
 BPL d_2213

.d_221a

 JSR d_42bd
 JSR d_28de
 STA &93
 LDA &8C
 CMP #&01
 BNE d_222b
 JMP d_22dd

.d_222b

 CMP #&0E
 BNE d_223b
 JSR rnd_seq
 CMP #&C8
 BCC d_223b
 LDX #&0F
 JMP d_21b6

.d_223b

 JSR rnd_seq
 CMP #&FA
 BCC d_2249
 JSR rnd_seq
 ORA #&68
 STA &63

.d_2249

 LDY #&0E
 LDA (&1E),Y
 LSR A
 CMP &69
 BCC d_2294
 LSR A
 LSR A
 CMP &69
 BCC d_226d
 JSR rnd_seq
 CMP #&E6
 BCC d_226d
 LDX &8C
 LDA ship_flags,X
 BPL d_226d
 LDA #&00
 STA &66
 JMP d_258e

.d_226d

 LDA &65
 AND #&07
 BEQ d_2294
 STA &D1
 JSR rnd_seq
 \	AND #&1F
 AND #&0F
 CMP &D1
 BCS d_2294
 LDA &30
 BNE d_2294
 DEC &65
 LDA &8C
 CMP #&1D
 BNE d_2291
 LDX #&1E
 LDA &66
 JMP d_2592

.d_2291

 JMP d_43be

.d_2294

 LDA #&00
 JSR d_41bf
 AND #&E0
 BNE d_22c6
 LDX &93
 CPX #&A0
 BCC d_22c6
 LDY #&13
 LDA (&1E),Y
 AND #&F8
 BEQ d_22c6
 LDA &65
 ORA #&40
 STA &65
 CPX #&A3
 BCC d_22c6
 LDA (&1E),Y
 LSR A
 JSR d_36e4
 DEC &62
 LDA &30
 BNE d_2311
 LDA #&08
 JMP sound

.d_22c6

 LDA &4D
 CMP #&03
 BCS d_22d4
 LDA &47
 ORA &4A
 AND #&FE
 BEQ d_22e6

.d_22d4

 JSR rnd_seq
 ORA #&80
 CMP &66
 BCS d_22e6

.d_22dd

 JSR d_245d
 LDA &93
 EOR #&80

.d_22e4

 STA &93

.d_22e6

 LDY #&10
 JSR d_28e0
 TAX
 JSR d_2332
 STA &64
 LDA &63
 ASL A
 CMP #&20
 BCS d_2305
 LDY #&16
 JSR d_28e0
 TAX
 EOR &64
 JSR d_2332
 STA &63

.d_2305

 LDA &93
 BMI d_2312
 CMP &94
 BCC d_2312
 LDA #&03
 STA &62

.d_2311

 RTS

.d_2312

 AND #&7F
 CMP #&12
 BCC d_2323
 LDA #&FF
 LDX &8C
 CPX #&01
 BNE d_2321
 ASL A

.d_2321

 STA &62

.d_2323

 RTS

.d_2324

 JSR d_28de
 CMP #&98
 BCC d_232f
 LDX #&00
 STX &9A

.d_232f

 JMP d_22e4

.d_2332

 EOR #&80
 AND #&80
 STA &D1
 TXA
 ASL A
 CMP &9A
 BCC d_2343
 LDA &99
 ORA &D1
 RTS

.d_2343

 LDA &D1
 RTS

.d_2346

 LDA #&06
 STA &9A
 LSR A
 STA &99
 LDA #&1D
 STA &94
 LDA &0320
 BNE d_2359

.d_2356

 JMP d_21fd

.d_2359

 JSR d_2403
 LDA &D4
 ORA &D7
 ORA &DA
 AND #&7F
 BNE d_2356
 JSR d_42e0
 LDA &81
 STA &40
 JSR d_42bd
 LDY #&0A
 JSR d_243b
 BMI d_239a
 CMP #&23
 BCC d_239a
 JSR d_28de
 CMP #&A2
 BCS d_23b4
 LDA &40
 CMP #&9D
 BCC d_238c
 LDA &8C
 BMI d_23b4

.d_238c

 JSR d_245d
 JSR d_2324

.d_2392

 LDX #&00
 STX &62
 INX
 STX &61
 RTS

.d_239a

 JSR d_2403
 JSR d_2470
 JSR d_2470
 JSR d_42bd
 JSR d_245d
 JMP d_2324

.d_23ac

 INC &62
 LDA #&7F
 STA &63
 BNE d_23f9

.d_23b4

 LDX #&00
 STX &9A
 STX &64
 LDA &8C
 BPL d_23de
 EOR &34
 EOR &35
 ASL A
 LDA #&02
 ROR A
 STA &63
 LDA &34
 ASL A
 CMP #&0C
 BCS d_2392
 LDA &35
 ASL A
 LDA #&02
 ROR A
 STA &64
 LDA &35
 ASL A
 CMP #&0C
 BCS d_2392

.d_23de

 STX &63
 LDA &5C
 STA &34
 LDA &5E
 STA &35
 LDA &60
 STA &36
 LDY #&10
 JSR d_243b
 ASL A
 CMP #&42
 BCS d_23ac
 JSR d_2392

.d_23f9

 LDA &DC
 BNE d_2402

.top_6a

 ASL &6A
 SEC
 ROR &6A

.d_2402

 RTS

.d_2403

 LDA #&25
 STA &22
 LDA #&09

.d_2409

 STA &23
 LDY #&02
 JSR d_2417
 LDY #&05
 JSR d_2417
 LDY #&08

.d_2417

 LDA (&22),Y
 EOR #&80
 STA &43
 DEY
 LDA (&22),Y
 STA &42
 DEY
 LDA (&22),Y
 STA &41
 STY &80
 LDX &80
 JSR d_1d4c
 LDY &80
 STA &D4,X
 LDA &42
 STA &D3,X
 LDA &41
 STA &D2,X
 RTS

.d_243b

 LDX &0925,Y
 STX &81
 LDA &34
 JSR l_2287
 LDX &0927,Y
 STX &81
 LDA &35
 JSR l_22ad
 STA &83
 STX &82
 LDX &0929,Y
 STX &81
 LDA &36
 JMP l_22ad

.d_245d

 LDA &34
 EOR #&80
 STA &34
 LDA &35
 EOR #&80
 STA &35
 LDA &36
 EOR #&80
 STA &36
 RTS

.d_2470

 JSR d_2473

.d_2473

 LDA &092F
 LDX #&00
 JSR d_2488
 LDA &0931
 LDX #&03
 JSR d_2488
 LDA &0933
 LDX #&06

.d_2488

 ASL A
 STA &82
 LDA #&00
 ROR A
 EOR #&80
 EOR &D4,X
 BMI d_249f
 LDA &82
 ADC &D2,X
 STA &D2,X
 BCC d_249e
 INC &D3,X

.d_249e

 RTS

.d_249f

 LDA &D2,X
 SEC
 SBC &82
 STA &D2,X
 LDA &D3,X
 SBC #&00
 STA &D3,X
 BCS d_249e
 LDA &D2,X
 EOR #&FF
 ADC #&01
 STA &D2,X
 LDA &D3,X
 EOR #&FF
 ADC #&00
 STA &D3,X
 LDA &D4,X
 EOR #&80
 STA &D4,X
 JMP d_249e

.d_24c7

 CLC
 LDA &4E
 BNE d_2505
 LDA &8C
 BMI d_2505
 LDA &65
 AND #&20
 ORA &47
 ORA &4A
 BNE d_2505
 LDA &46
 JSR square
 STA &83
 LDA &1B
 STA &82
 LDA &49
 JSR square
 TAX
 LDA &1B
 ADC &82
 STA &82
 TXA
 ADC &83
 BCS d_2506
 STA &83
 LDY #&02
 LDA (&1E),Y
 CMP &83
 BNE d_2505
 DEY
 LDA (&1E),Y
 CMP &82

.d_2505

 RTS

.d_2506

 CLC
 RTS

.d_2508

 JSR init_ship
 LDA #&1C
 STA &49
 LSR A
 STA &4C
 LDA #&80
 STA &4B
 LDA &45
 ASL A
 ORA #&80
 STA &66

.d_251d

 LDA #&60
 STA &54
 ORA #&80
 STA &5C
 LDA &7D
 ROL A
 STA &61
 TXA
 JMP ins_ship

.d_252e

 LDX #&01
 JSR d_2508
 BCC d_2589
 LDX &45
 JSR ship_ptr
 LDA ship_type,X
 JSR d_254d
 DEC cmdr_misl
 JSR show_missle	\ redraw missiles
 STY target
 STX &45
 JMP n_sound30

.anger_8c

 LDA &8C

.d_254d

 CMP #&02
 BEQ d_2580
 LDY #&24
 LDA (&20),Y
 AND #&20
 BEQ d_255c
 JSR d_2580

.d_255c

 LDY #&20
 LDA (&20),Y
 BEQ d_2505
 ORA #&80
 STA (&20),Y
 LDY #&1C
 LDA #&02
 STA (&20),Y
 ASL A
 LDY #&1E
 STA (&20),Y
 LDA &8C
 CMP #&0B
 BCC d_257f
 LDY #&24
 LDA (&20),Y
 ORA #&04
 STA (&20),Y

.d_257f

 RTS

.d_2580

 LDA &0949
 ORA #&04
 STA &0949
 RTS

.d_2589

 LDA #&C9
 JMP d_45c6

.d_258e

 LDX #&03

.d_2590

 LDA #&FE

.d_2592

 STA &06
 TXA
 PHA
 LDA &1E
 PHA
 LDA &1F
 PHA
 LDA &20
 PHA
 LDA &21
 PHA
 LDY #&24

.d_25a4

 LDA &46,Y
 STA &0100,Y
 LDA (&20),Y
 STA &46,Y
 DEY
 BPL d_25a4
 LDA &6A
 AND #&1C
 STA &6A
 LDA &8C
 CMP #&02
 BNE d_25db
 TXA
 PHA
 LDA #&20
 STA &61
 LDX #&00
 LDA &50
 JSR d_261a
 LDX #&03
 LDA &52
 JSR d_261a
 LDX #&06
 LDA &54
 JSR d_261a
 PLA
 TAX

.d_25db

 LDA &06
 STA &66
 LSR &63
 ASL &63
 TXA
 CMP #&09
 BCS d_25fe
 CMP #&04
 BCC d_25fe
 PHA
 JSR rnd_seq
 ASL A
 STA &64
 TXA
 AND #&0F
 STA &61
 LDA #&FF
 ROR A
 STA &63
 PLA

.d_25fe

 JSR ins_ship
 PLA
 STA &21
 PLA
 STA &20
 LDX #&24

.d_2609

 LDA &0100,X
 STA &46,X
 DEX
 BPL d_2609
 PLA
 STA &1F
 PLA
 STA &1E
 PLA
 TAX
 RTS

.d_261a

 ASL A
 STA &82
 LDA #&00
 ROR A
 JMP d_524c

.d_2623

 LDA #&38
 JSR sound
 LDA #&01
 STA &0348
 JSR update_pod
 LDA #&04
 JSR d_263d
 DEC &0348
 JMP update_pod

.d_2636

 JSR n_sound30
 LDA #&08

.d_263d

 STA &95
 JSR clr_temp
 JMP pattern

.d_2679

 LDA #&00
 CPX #&02
 ROR A
 STA &99
 EOR #&80
 STA &9A
 JSR d_272d
 LDY &03C3

.d_268a

 LDA &0FA8,Y
 STA &88
 LSR A
 LSR A
 LSR A
 JSR d_2961
 LDA &1B
 EOR &9A
 STA &83
 LDA &0F6F,Y
 STA &1B
 LDA &0F5C,Y
 STA &34
 JSR scale_angle
 STA &83
 STX &82
 LDA &0F82,Y
 STA &35
 EOR &7B
 LDX &2B
 JSR d_27c8
 JSR scale_angle
 STX &24
 STA &25
 LDX &0F95,Y
 STX &82
 LDX &35
 STX &83
 LDX &2B
 EOR &7C
 JSR d_27c8
 JSR scale_angle
 STX &26
 STA &27
 LDX &31
 EOR &32
 JSR d_27c8
 STA &81
 LDA &24
 STA &82
 LDA &25
 STA &83
 EOR #&80
 JSR l_22ad
 STA &25
 TXA
 STA &0F6F,Y
 LDA &26
 STA &82
 LDA &27
 STA &83
 JSR l_22ad
 STA &83
 STX &82
 LDA #&00
 STA &1B
 LDA &8D
 JSR d_1907
 LDA &25
 STA &0F5C,Y
 STA &34
 AND #&7F
 CMP #&74
 BCS d_2748
 LDA &27
 STA &0F82,Y
 STA &35
 AND #&7F
 CMP #&74
 BCS d_275b

.d_2724

 JSR d_1910
 DEY
 BEQ d_272d
 JMP d_268a

.d_272d

 LDA &8D
 EOR &99
 STA &8D
 LDA &32
 EOR &99
 STA &32
 EOR #&80
 STA &33
 LDA &7B
 EOR &99
 STA &7B
 EOR #&80
 STA &7C
 RTS

.d_2748

 JSR rnd_seq
 STA &35
 STA &0F82,Y
 LDA #&73
 ORA &99
 STA &34
 STA &0F5C,Y
 BNE d_276c

.d_275b

 JSR rnd_seq
 STA &34
 STA &0F5C,Y
 LDA #&6E
 ORA &33
 STA &35
 STA &0F82,Y

.d_276c

 JSR rnd_seq
 ORA #&08
 STA &88
 STA &0FA8,Y
 BNE d_2724

.d_2778

 STA &40

.n_store

 STA &41
 STA &42
 STA &43
 CLC
 RTS

.d_2782

 STA &82
 AND #&7F
 STA &42
 LDA &81
 AND #&7F
 BEQ d_2778
 SEC
 SBC #&01
 STA &D1
 LDA &1C
 LSR &42
 ROR A
 STA &41
 LDA &1B
 ROR A
 STA &40
 LDA #&00
 LDX #&18

.d_27a3

 BCC d_27a7
 ADC &D1

.d_27a7

 ROR A
 ROR &42
 ROR &41
 ROR &40
 DEX
 BNE d_27a3
 STA &D1
 LDA &82
 EOR &81
 AND #&80
 ORA &D1
 STA &43
 RTS

.d_27be

 LDX &24
 STX &82
 LDX &25
 STX &83

.d_27c6

 LDX &31

.d_27c8

 STX &1B
 TAX
 AND #&80
 STA &D1
 TXA
 AND #&7F
 BEQ d_2838
 TAX
 DEX
 STX &06
 LDA #&00
 LSR &1B
 BCC d_27e0
 ADC &06

.d_27e0

 ROR A
 ROR &1B
 BCC d_27e7
 ADC &06

.d_27e7

 ROR A
 ROR &1B
 BCC d_27ee
 ADC &06

.d_27ee

 ROR A
 ROR &1B
 BCC d_27f5
 ADC &06

.d_27f5

 ROR A
 ROR &1B
 BCC d_27fc
 ADC &06

.d_27fc

 ROR A
 ROR &1B
 LSR A
 ROR &1B
 LSR A
 ROR &1B
 LSR A
 ROR &1B
 ORA &D1
 RTS

.d_2817

 LDA &0F82,Y
 STA &35

.d_281c

 AND #&7F
 STA &1B
 JMP price_mult

.d_2838

 STA &1C
 STA &1B
 RTS

.d_286c

 BCC d_2870
 ADC &D1

.d_2870

 ROR A
 ROR &1B
 DEX
 BNE d_286c
 RTS

.d_2877

 STX &81

.d_2879

 EOR #&FF
 LSR A
 STA &1C
 LDA #&00
 LDX #&10
 ROR &1B

.d_2884

 BCS d_2891
 ADC &81
 ROR A
 ROR &1C
 ROR &1B
 DEX
 BNE d_2884
 RTS

.d_2891

 LSR A
 ROR &1C
 ROR &1B
 DEX
 BNE d_2884
 RTS

.d_289e

 LDX &25
 STX &83

.d_28a2

 LDX &24
 STX &82
 JMP l_2259

.d_28de

 LDY #&0A

.d_28e0

 LDX &46,Y
 STX &81
 LDA &34
 JSR l_2287
 LDX &48,Y
 STX &81
 LDA &35
 JSR l_22ad
 STA &83
 STX &82
 LDX &4A,Y
 STX &81
 LDA &36
 JMP l_22ad

.d_295e

 LDA &0FA8,Y

.d_2961

 STA &81
 LDA &7D
 JMP l_2316

.d_297e

 STA &1D
 LDA &4C
 STA &81
 LDA &4D
 STA &82
 LDA &4E
 STA &83
 LDA &1B
 ORA #&01
 STA &1B
 LDA &1D
 EOR &83
 AND #&80
 STA &D1
 LDY #&00
 LDA &1D
 AND #&7F

.d_29a0

 CMP #&40
 BCS d_29ac
 ASL &1B
 ROL &1C
 ROL A
 INY
 BNE d_29a0

.d_29ac

 STA &1D
 LDA &83
 AND #&7F
 BMI d_29bc

.d_29b4

 DEY
 ASL &81
 ROL &82
 ROL A
 BPL d_29b4

.d_29bc

 STA &81
 LDA #&FE
 STA &82
 LDA &1D
 JSR l_3f7d
 LDA #&00
 JSR n_store	\ swapped
 TYA
 BPL d_29f0
 LDA &82

.d_29d4

 ASL A
 ROL &41
 ROL &42
 ROL &43
 INY
 BNE d_29d4
 STA &40
 LDA &43
 ORA &D1
 STA &43
 RTS

.d_29e7

 LDA &82
 STA &40
 LDA &D1
 STA &43
 RTS

.d_29f0

 BEQ d_29e7
 LDA &82

.d_29f4

 LSR A
 DEY
 BNE d_29f4
 STA &40
 LDA &D1
 STA &43
 RTS

.d_29ff

 LDA &033F
 BNE d_2a09
 LDA cap_flag
 BNE d_2a15

.d_2a09

 TXA
 BPL d_2a0f
 DEX
 BMI d_2a15

.d_2a0f

 INX
 BNE d_2a15
 DEX
 BEQ d_2a0f

.d_2a15

 RTS

.d_2a16

 STA &D1
 TXA
 CLC
 ADC &D1
 TAX
 BCC d_2a21
 LDX #&FF

.d_2a21

 BPL d_2a33

.d_2a23

 LDA &D1
 RTS

.d_2a26

 STA &D1
 TXA
 SEC
 SBC &D1
 TAX
 BCS d_2a31
 LDX #&01

.d_2a31

 BPL d_2a23

.d_2a33

 LDA a_flag
 BNE d_2a23
 LDX #&80
 BMI d_2a23

.d_2a3c

 LDA &1B
 EOR &81
 STA &06
 LDA &81
 BEQ d_2a6b
 ASL A
 STA &81
 LDA &1B
 ASL A
 CMP &81
 BCS d_2a59
 JSR d_2a75
 SEC

.d_2a54

 LDX &06
 BMI d_2a6e
 RTS

.d_2a59

 LDX &81
 STA &81
 STX &1B
 TXA
 JSR d_2a75
 STA &D1
 LDA #&40
 SBC &D1
 BCS d_2a54

.d_2a6b

 LDA #&3F
 RTS

.d_2a6e

 STA &D1
 LDA #&80
 SBC &D1
 RTS

.d_2a75

 JSR l_3f75
 LDA &82
 LSR A
 LSR A
 LSR A
 TAX
 LDA _07E0,X

.d_2a81

 RTS

.d_2a82

 JSR rnd_seq
 AND #&07
 ADC #&5C
 STA &0FCF
 JSR rnd_seq
 AND #&07
 ADC #&7C
 STA &0FCE
 LDA laser_t
 ADC #&08
 STA laser_t
 JSR d_3629

.d_2aa1

 LDA &87
 BNE d_2a81
 LDA #&20
 LDY #&E0
 JSR d_2ab0
 LDA #&30
 LDY #&D0

.d_2ab0

 STA &36
 LDA &0FCE
 STA &34
 LDA &0FCF
 STA &35
 LDA #&BF
 STA &37
 JSR draw_line
 LDA &0FCE
 STA &34
 LDA &0FCF
 STA &35
 STY &36
 LDA #&BF
 STA &37
 JMP draw_line

.d_2aec

 CPX #&10
 BEQ n_aliens
 CPX #&0D
 BCS d_2b04

.n_aliens

 LDY #&0C
 SEC
 LDA cmdr_cargo+&10

.d_2af9

 ADC cmdr_cargo,Y
 BCS n_cargo
 DEY
 BPL d_2af9
 CMP new_hold

.n_cargo

 RTS

.d_2b04

 LDA cmdr_cargo,X
 ADC #&00
 RTS

.d_3011

 LDA &2F
 ORA &8E
 BNE d_3084+&01
 JSR l_3c91
 BMI d_305e
 LDA &87
 BNE d_3023
 JSR snap_hype
 JMP d_3026

.d_3023

 JSR snap_cursor

.d_3026

 LDA hype_dist
 ORA hype_dist+&01
 BEQ d_3084+&01
 LDA #&07
 STA cursor_x
 LDA #&17
 STA cursor_y
 LDA #&00
 STA vdu_stat
 LDA #&BD
 JSR de_token
 LDA hype_dist+&01
 BNE d_30b9
 LDA cmdr_fuel
 CMP hype_dist
 BCC d_30b9
 LDA #&2D
 JSR de_token
 JSR write_planet

.d_3054

 LDA #&0F
 STA &2F
 STA &2E
 TAX
 \	JMP d_30ac
 BNE d_30ac

.d_305e

 LDX cmdr_ghype
 BEQ d_3084+&01
 INC new_hold	\**
 INX
 STX cmdr_ghype
 STX cmdr_legal
 STX cmdr_cour
 STX cmdr_cour+1
 JSR d_3054
 LDX #&05
 INC cmdr_galxy
 LDA cmdr_galxy
 AND #&07
 STA cmdr_galxy

.d_307a

 LDA cmdr_gseed,X
 ASL A
 ROL cmdr_gseed,X
 DEX
 BPL d_307a

.d_3084

 LDA #&60
 STA data_homex
 STA data_homey
 JSR d_3292
 JSR snap_hype
 LDX #&00
 STX hype_dist
 STX hype_dist+&01
 LDA #&74
 JSR d_45c6
 JMP data_home

.d_30ac

 LDY #&01
 STY cursor_x
 STY cursor_y
 DEY
 JMP writec_5

.d_30b9

 LDA #&CA
 JMP token_query

.d_31ab

 JSR data_home
 LDX #&05

.d_31b0

 LDA &6C,X
 STA &03B2,X
 DEX
 BPL d_31b0
 INX
 STX &0349
 LDA data_econ
 STA home_econ
 LDA data_tech
 STA home_tech
 LDA data_govm
 STA home_govmt
 JSR rnd_seq
 STA cmdr_price
 JMP mung_prices

.d_320e

 JSR d_3f62
 LDA #&FF
 STA &66
 LDA #&1D
 JSR ins_ship
 LDA #&1E
 JMP ins_ship

.d_3226

 LDA #&03
 JSR d_427e
 LDA #&03
 JSR clr_scrn
 JSR d_2623
 JSR clr_common
 STY &0341

.d_3239

 JSR d_320e
 LDA #&03
 CMP &033B
 BCS d_3239
 STA &03C3
 LDX #&00
 JSR d_5493
 LDA cmdr_homey
 EOR #&1F
 STA cmdr_homey

.r_rts

 RTS

.d_3254

 LDA cmdr_fuel
 SEC
 SBC hype_dist
 STA cmdr_fuel

.hyper_snap

 LDA &87
 BNE d_3268
 JSR clr_scrn
 JSR d_2623

.d_3268

 \	JSR l_3c91
 \	AND x_flag
 \	BMI d_321f
 JSR rnd_seq
 CMP #&FD
 BCS d_3226
 JSR d_31ab
 JSR clr_common
 JSR d_3580
 JSR d_4255
 LDA &87
 AND #&3F
 BNE r_rts
 JSR clr_temp
 LDA &87
 BNE d_32c8
 INC &87

.d_3292

 LDX &8E
 BEQ d_32c1
 JSR d_2636
 JSR clr_common
 JSR snap_hype
 INC &4E
 JSR d_356d
 LDA #&80
 STA &4E
 INC &4D
 JSR d_3740
 LDA #&0C
 STA &7D
 JSR d_41a6
 ORA cmdr_legal
 STA cmdr_legal
 LDA #&FF
 STA &87
 JSR pattern

.d_32c1

 LDX #&00
 STX &8E
 JMP d_5493

.d_32c8

 BMI d_32cd
 JMP long_map

.d_32cd

 JMP short_map

.write_0346

 PHA
 LDA #&97
 JSR tube_write
 PLA
 JMP tube_write

.read_0346

 LDA #&98
 JSR tube_write
 JSR tube_read
 STA &0346
 RTS
