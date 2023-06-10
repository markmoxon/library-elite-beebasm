\ ******************************************************************************
\
\ NES ELITE GAME SOURCE (BANK 7)
\
\ NES Elite was written by Ian Bell and David Braben and is copyright D. Braben
\ and I. Bell 1992
\
\ The code on this site has been reconstructed from a disassembly of the version
\ released on Ian Bell's personal website at http://www.elitehomepage.org/
\
\ The commentary is copyright Mark Moxon, and any misunderstandings or mistakes
\ in the documentation are entirely my fault
\
\ The terminology and notations used in this commentary are explained at
\ https://www.bbcelite.com/about_site/terminology_used_in_this_commentary.html
\
\ The deep dive articles referred to in this commentary can be found at
\ https://www.bbcelite.com/deep_dives
\
\ ------------------------------------------------------------------------------
\
\ This source file produces the following binary file:
\
\   * bank7.bin
\
\ ******************************************************************************

 INCLUDE "versions/nes/1-source-files/main-sources/elite-bank-options.asm"

IF _BANK = 7

 INCLUDE "versions/nes/1-source-files/main-sources/elite-build-options.asm"

 _CASSETTE_VERSION      = (_VERSION = 1)
 _DISC_VERSION          = (_VERSION = 2)
 _6502SP_VERSION        = (_VERSION = 3)
 _MASTER_VERSION        = (_VERSION = 4)
 _ELECTRON_VERSION      = (_VERSION = 5)
 _ELITE_A_VERSION       = (_VERSION = 6)
 _NES_VERSION           = (_VERSION = 7)
 _C64_VERSION           = (_VERSION = 8)
 _APPLE_VERSION         = (_VERSION = 9)
 _DISC_DOCKED           = FALSE
 _DISC_FLIGHT           = FALSE
 _ELITE_A_DOCKED        = FALSE
 _ELITE_A_FLIGHT        = FALSE
 _ELITE_A_SHIPS_R       = FALSE
 _ELITE_A_SHIPS_S       = FALSE
 _ELITE_A_SHIPS_T       = FALSE
 _ELITE_A_SHIPS_U       = FALSE
 _ELITE_A_SHIPS_V       = FALSE
 _ELITE_A_SHIPS_W       = FALSE
 _ELITE_A_ENCYCLOPEDIA  = FALSE
 _ELITE_A_6502SP_IO     = FALSE
 _ELITE_A_6502SP_PARA   = FALSE

 INCLUDE "versions/nes/1-source-files/main-sources/elite-source-common.asm"

ENDIF

\ ******************************************************************************
\
\ ELITE BANK 7
\
\ Produces the binary file bank7.bin.
\
\ ******************************************************************************

 CODE_BANK_7% = &C000
 LOAD_BANK_7% = &C000

 ORG CODE_BANK_7%

\INCLUDE "library/nes/main/subroutine/resetmmc1.asm"

\ ******************************************************************************
\
\       Name: ResetMMC1_b7
\       Type: Variable
\   Category: Start and end
\    Summary: The MMC1 mapper reset routine at the start of the ROM bank
\
\ ------------------------------------------------------------------------------
\
\ When the NES is switched on, it is hardwired to perform a JMP (&FFFC). At this
\ point, there is no guarantee as to which ROM banks are mapped to &8000 and
\ &C000, so to ensure that the game starts up correctly, we put the same code
\ in each ROM at the following locations:
\
\   * We put &C000 in address &FFFC in every ROM bank, so the NES always jumps
\     to &C000 when it starts up via the JMP (&FFFC), irrespective of which
\     ROM bank is mapped to &C000.
\
\   * We put the same reset routine at the start of every ROM bank, so the same
\     routine gets run, whichever ROM bank is mapped to &C000.
\
\ This reset routine is therefore called when the NES starts up, whatever the
\ bank configuration ends up being. It then switches ROM bank 7 to &C000 and
\ jumps into bank 7 at the game's entry point S%, which starts the game.
\
\ We need to give a different label to this version of the reset routine so we
\ can assemble bank 7 at the same time as banks 0 to 6, to enable the lower
\ banks to see the exported addresses for bank 7.
\
\ ******************************************************************************

.ResetMMC1_b7

 SEI                    \ Disable interrupts

 INC &C006              \ Reset the MMC1 mapper, which we can do by writing a
                        \ value with bit 7 set into any address in ROM space
                        \ (i.e. any address from &8000 to &FFFF)
                        \
                        \ The INC instruction does this in a more efficient
                        \ manner than an LDA/STA pair, as it:
                        \
                        \   * Fetches the contents of address &C006, which
                        \     contains the high byte of the JMP destination
                        \     below, i.e. the high byte of S%, which is &C0
                        \
                        \   * Adds 1, to give &C1
                        \
                        \   * Writes the value &C1 back to address &C006
                        \
                        \ &C006 is in the ROM space and &C1 has bit 7 set, so
                        \ the INC does all that is required to reset the mapper,
                        \ in fewer cycles and bytes than an LDA/STA pair
                        \
                        \ Resetting MMC1 maps bank 7 to &C000 and enables the
                        \ bank at &8000 to be switched, so this instruction
                        \ ensures that bank 7 is present

 JMP S%                 \ Jump to S% in bank 7 to start the game

\ ******************************************************************************
\
\       Name: S%
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.S%

 SEI
 CLD
 LDX #&FF
 TXS
 LDX #0
 STX startupDebug
 LDA #&10
 STA PPU_CTRL
 STA ppuCtrlCopy
 LDA #0
 STA PPU_MASK

.loop_CC01C

 LDA PPU_STATUS
 BPL loop_CC01C

.loop_CC021

 LDA PPU_STATUS
 BPL loop_CC021

.loop_CC026

 LDA PPU_STATUS
 BPL loop_CC026
 LDA #0
 STA K%
 LDA #&3C
 STA K%+1

.CC035

 LDX #&FF
 TXS
 JSR ResetVariables
 JMP ShowStartScreen

\ ******************************************************************************
\
\       Name: ResetVariables
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.ResetVariables

 LDA #0
 STA PPU_CTRL
 STA ppuCtrlCopy
 STA PPU_MASK
 STA setupPPUForIconBar
 LDA #&40
 STA JOY2
 INC &C006
 LDA PPU_STATUS

.loop_CC055

 LDA PPU_STATUS
 BPL loop_CC055

.loop_CC05A

 LDA PPU_STATUS
 BPL loop_CC05A

.loop_CC05F

 LDA PPU_STATUS
 BPL loop_CC05F
 LDA #0
 TAX

.loop_CC067

 STA ZP,X
 INX
 BNE loop_CC067
 LDA #3
 STA SC+1
 LDA #0
 STA SC
 TXA
 LDX #3
 TAY

.CC078

 STA (SC),Y
 INY
 BNE CC078
 INC SC+1
 DEX
 BNE CC078
 JSR SetupMMC1
 JSR ResetSoundL045E
 LDA #&80
 ASL A
 JSR DrawTitleScreen_b3
 JSR ResetDrawingPhase
 JSR ResetBuffers
 LDA #0
 STA DTW6
 LDA #&FF
 STA DTW2
 LDA #&FF
 STA DTW8

.CC0A3

 LDA #0
 JMP SetBank

\ ******************************************************************************
\
\       Name: subm_C0A8
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_C0A8

 CMP currentBank
 BNE SetBank
 RTS

\ ******************************************************************************
\
\       Name: ResetBank
\       Type: Subroutine
\   Category: Utility routines
\    Summary: ???
\
\ ******************************************************************************

.ResetBank

 PLA

\ ******************************************************************************
\
\       Name: SetBank
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Page a specified bank into memory at &8000
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The number of the bank to page into memory at &8000
\
\ ******************************************************************************

.SetBank

 DEC runningSetBank
 STA currentBank
 STA &FFFF
 LSR A
 STA &FFFF
 LSR A
 STA &FFFF
 LSR A
 STA &FFFF
 LSR A
 STA &FFFF
 INC runningSetBank
 BNE CC0CA
 RTS

.CC0CA

 LDA #0
 STA runningSetBank
 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 TXA
 PHA
 TYA
 PHA
 JSR PlayMusic_b6
 PLA
 TAY
 PLA
 TAX

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: LC0DF
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.LC0DF

 EQUB   6,   6,   7,   7

\ ******************************************************************************
\
\       Name: LC0E3
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.LC0E3

 EQUB &0B,   9, &0D, &0A

IF _NTSC

 EQUB &20, &20, &20, &20  ; C0DF: 06 06 07... ...
 EQUB &10,   0, &C4, &ED, &5E, &E5, &22, &E5  ; C0EB: 10 00 C4... ...
 EQUB &22,   0,   0, &ED, &5E, &E5, &22,   9  ; C0F3: 22 00 00... "..
 EQUB &68,   0,   0,   0,   0                 ; C0FB: 68 00 00... h..

ELIF _PAL

 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF
 EQUB &FF

ENDIF

INCLUDE "library/advanced/main/variable/log.asm"
INCLUDE "library/advanced/main/variable/logl.asm"
INCLUDE "library/advanced/main/variable/antilog-alogh.asm"
INCLUDE "library/6502sp/main/variable/antilogodd.asm"
INCLUDE "library/common/main/variable/sne.asm"
INCLUDE "library/common/main/variable/act.asm"
INCLUDE "library/common/main/variable/xx21.asm"

\ ******************************************************************************
\
\       Name: subm_C582
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_C582

 SEC                    \ Subtract 2131 (&0853) from cycleCount
 LDA cycleCount
 SBC #&53
 STA cycleCount
 LDA cycleCount+1
 SBC #&08
 STA cycleCount+1

 LDX addr1
 STX addr5
 LDA addr1+1
 CLC
 ADC #&70
 STA addr5+1
 LDA addr1+1
 ADC #&20
 STA PPU_ADDR
 STX PPU_ADDR
 LDY #0

.loop_CC5A6

 LDA (addr5),Y
 STA PPU_DATA
 INY
 CPY #&40
 BNE loop_CC5A6
 LDA addr1+1
 ADC #&23
 STA PPU_ADDR
 STX PPU_ADDR
 LDY #0

.loop_CC5BC

 LDA (addr5),Y
 STA PPU_DATA
 INY
 CPY #&40
 BNE loop_CC5BC
 LDA L00D7
 BMI CC5CD
 JMP subm_C630

.CC5CD

 STA L00D3
 JMP subm_C6C6

\ ******************************************************************************
\
\       Name: subm_C5D2
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_C5D2

 SEC                    \ Subtract 666 (&029A) from cycleCount
 LDA cycleCount
 SBC #&9A
 STA cycleCount
 LDA cycleCount+1
 SBC #&02
 STA cycleCount+1

 BMI CC5E4
 JMP CC5F3

.CC5E4

 LDA cycleCount         \ Add 623 (&026F) to cycleCount
 ADC #&6F
 STA cycleCount
 LDA cycleCount+1
 ADC #&02
 STA cycleCount+1

 JMP CC6F3

.CC5F3

 LDA #0
 STA addr5
 LDA L00D3
 ASL A
 ASL A
 ASL A
 TAY
 LDA #1
 ROL A
 STA addr4
 TYA
 ADC #&50
 TAX
 LDA addr4
 ADC #0
 STA PPU_ADDR
 STX PPU_ADDR
 LDA L00D6
 ADC addr4
 STA addr5+1
 LDX #&20

.loop_CC618

 LDA (addr5),Y
 STA PPU_DATA
 INY
 DEX
 BEQ CC624
 JMP loop_CC618

.CC624

 LDA L00D3
 CLC
 ADC #4
 STA L00D3
 BPL subm_C5D2
 JMP subm_C6C6

\ ******************************************************************************
\
\       Name: subm_C630
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_C630

 ASL A
 BMI subm_C5D2

 SEC                    \ Subtract 1297 (&0511) from cycleCount
 LDA cycleCount
 SBC #&11
 STA cycleCount
 LDA cycleCount+1
 SBC #&05
 STA cycleCount+1

 BMI CC645
 JMP CC654

.CC645

 LDA cycleCount         \ Add 1251 (&04E3) to cycleCount
 ADC #&E3
 STA cycleCount
 LDA cycleCount+1
 ADC #&04
 STA cycleCount+1

 JMP CC6F3

.CC654

 LDA #0
 STA addr5
 LDA L00D3
 ASL A
 ASL A
 ASL A
 TAY
 LDA #0
 ROL A
 STA addr4
 TYA
 ADC #&50
 TAX
 LDA addr4
 ADC #0
 STA PPU_ADDR
 STX PPU_ADDR
 LDA L00D6
 ADC addr4
 STA addr5+1
 LDX #&20

.loop_CC679

 LDA (addr5),Y
 STA PPU_DATA
 INY
 DEX
 BEQ CC685
 JMP loop_CC679

.CC685

 LDA #0
 STA addr5
 LDA L00D3
 ASL A
 ASL A
 ASL A
 TAY
 LDA #0
 ROL A
 STA addr4
 TYA
 ADC #&50
 TAX
 LDA addr4
 ADC #&10
 STA PPU_ADDR
 STX PPU_ADDR
 LDA L00D6
 ADC addr4
 STA addr5+1
 LDX #&20

.loop_CC6AA

 LDA (addr5),Y
 STA PPU_DATA
 INY
 DEX
 BEQ CC6B6
 JMP loop_CC6AA

.CC6B6

 LDA L00D3
 CLC
 ADC #4
 STA L00D3
 JMP subm_C630

\ ******************************************************************************
\
\       Name: subm_C6C0
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_C6C0

 JMP subm_C630

\ ******************************************************************************
\
\       Name: subm_C6C3
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_C6C3

 JMP subm_C582

\ ******************************************************************************
\
\       Name: subm_C6C6
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_C6C6

 LDX otherPhase
 LDA L03EF,X
 AND #&10
 BEQ CC6F3

 SEC                    \ Subtract 42 (&002A) from cycleCount
 LDA cycleCount
 SBC #&2A
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 BMI CC6E1
 JMP CC6F0

.CC6E1

 LDA cycleCount         \ Add 65521 (&FFF1) to cycleCount
 ADC #&F1
 STA cycleCount
 LDA cycleCount+1
 ADC #&FF
 STA cycleCount+1

 JMP CC6F3

.CC6F0

 JMP subm_C849

.CC6F3

 RTS

\ ******************************************************************************
\
\       Name: SendBuffersToPPU
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.SendBuffersToPPU

 LDA L00D3
 BEQ subm_C6C3
 BPL subm_C6C0
 LDX otherPhase
 LDA L03EF,X
 AND #&10
 BEQ CC77E

 SEC                    \ Subtract 56 (&0038) from cycleCount
 LDA cycleCount
 SBC #&38
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 TXA
 EOR #1
 TAY
 LDA L03EF,Y
 AND #&A0
 ORA L00F6
 CMP #&81
 BNE CC738
 LDA tile0Phase0,X
 BNE CC725
 LDA #&FF

.CC725

 CMP L00CA,X
 BEQ CC73B
 BCS CC73B

 SEC                    \ Subtract 32 (&0020) from cycleCount
 LDA cycleCount
 SBC #&20
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

.CC738

 JMP subm_C849

.CC73B

 LDA L03EF,X
 ASL A
 BPL CC6F3
 LDY L00CD,X
 AND #8
 BEQ CC749
 LDY #&80

.CC749

 TYA
 SEC
 SBC tile3Phase0,X
 CMP #&30
 BCC CC761

 SEC                    \ Subtract 60 (&003C) from cycleCount
 LDA cycleCount
 SBC #&3C
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

.loop_CC75E

 JMP subm_C849

.CC761

 LDA ppuCtrlCopy
 BEQ loop_CC75E

 SEC                    \ Subtract 134 (&0086) from cycleCount
 LDA cycleCount
 SBC #&86
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 LDA L00F6
 EOR palettePhase
 STA palettePhase
 JSR SetPaletteForPhase
 JMP subm_C849

.CC77E

 SEC                    \ Subtract 298 (&012A) from cycleCount
 LDA cycleCount
 SBC #&2A
 STA cycleCount
 LDA cycleCount+1
 SBC #&01
 STA cycleCount+1

 LDA L03EF
 AND #&A0
 CMP #&80
 BNE CC79E
 NOP
 NOP
 NOP
 NOP
 NOP
 LDX #0
 JMP CC7C7

.CC79E

 LDA L03F0
 AND #&A0
 CMP #&80
 BEQ CC7C5

 CLC                    \ Add 223 (&00DF) to cycleCount
 LDA cycleCount
 ADC #&DF
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 RTS

.loop_CC7B5

 CLC                    \ Add 45 (&002D) to cycleCount
 LDA cycleCount
 ADC #&2D
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CC7D2

.CC7C5

 LDX #1

.CC7C7

 STX otherPhase
 LDA L00F6
 BEQ loop_CC7B5
 STX palettePhase
 JSR SetPaletteForPhase

.CC7D2

 TXA
 ASL A
 ASL A
 ASL A
 STA pallettePhasex8
 LSR A
 ORA #&20
 STA ppuNametableAddr+1
 LDA #&10
 STA L00E0
 LDA #0
 STA ppuNametableAddr
 LDA L00CC
 STA tile3Phase0,X
 STA tile2Phase0,X
 LDA L00D2
 STA L00CA,X
 STA tile1Phase0,X
 LDA L03EF,X
 ORA #&10
 STA L03EF,X
 LDA #0
 STA addr4
 LDA L00CA,X
 ASL A
 ROL addr4
 ASL A
 ROL addr4
 ASL A
 STA L00DB,X
 LDA addr4
 ROL A
 ADC pattBufferHiAddr,X
 STA L04BE,X
 LDA #0
 STA addr4
 LDA tile3Phase0,X
 ASL A
 ROL addr4
 ASL A
 ROL addr4
 ASL A
 STA L00DD,X
 ROL addr4
 LDA addr4
 ADC nameBufferHiAddr,X
 STA L04C0,X
 LDA ppuNametableAddr+1
 SEC
 SBC nameBufferHiAddr,X
 STA L04C6,X
 JMP subm_C849

\ ******************************************************************************
\
\       Name: subm_C836
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_C836

 CLC                    \ Add 4 (&0004) to cycleCount
 LDA cycleCount
 ADC #&04
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CCBDD

.CC846

 JMP CCA2E

\ ******************************************************************************
\
\       Name: subm_C849
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_C849

 SEC                    \ Subtract 182 (&00B6) from cycleCount
 LDA cycleCount
 SBC #&B6
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 BMI CC85B
 JMP CC86A

.CC85B

 LDA cycleCount         \ Add 141 (&008D) to cycleCount
 ADC #&8D
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CC6F3

.CC86A

 LDA tile0Phase0,X
 BNE CC870
 LDA #&FF

.CC870

 STA temp1
 LDA ppuNametableAddr+1
 SEC
 SBC nameBufferHiAddr,X
 STA L04C6,X
 LDY L00DB,X
 LDA L04BE,X
 STA addr5+1
 LDA L00CA,X
 STA L00C9
 SEC
 SBC temp1
 BCS subm_C836
 LDX ppuCtrlCopy
 BEQ CC893
 CMP #&BF
 BCC CC846

.CC893

 LDA L00C9
 LDX #0
 STX addr4
 STX addr5
 ASL A
 ROL addr4
 ASL A
 ROL addr4
 ASL A
 ROL addr4
 ASL A
 TAX
 LDA addr4
 ROL A
 ADC L00E0
 STA PPU_ADDR
 STA addr4+1
 TXA
 ADC pallettePhasex8
 STA PPU_ADDR
 STA addr4
 JMP CC8D0

.CC8BB

 INC addr5+1

 SEC                    \ Subtract 27 (&001B) from cycleCount
 LDA cycleCount
 SBC #&1B
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 JMP CC925

.CC8CD

 JMP CC9EB

.CC8D0

 LDX L00C9

.CC8D2

 SEC                    \ Subtract 400 (&0190) from cycleCount
 LDA cycleCount
 SBC #&90
 STA cycleCount
 LDA cycleCount+1
 SBC #&01
 STA cycleCount+1

 BMI CC8E4
 JMP CC8F3

.CC8E4

 LDA cycleCount         \ Add 359 (&0167) to cycleCount
 ADC #&67
 STA cycleCount
 LDA cycleCount+1
 ADC #&01
 STA cycleCount+1

 JMP CCB30

.CC8F3

 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 BEQ CC8BB

.CC925

 LDA addr4
 CLC
 ADC #&10
 STA addr4
 LDA addr4+1
 ADC #0
 STA addr4+1
 STA PPU_ADDR
 LDA addr4
 STA PPU_ADDR
 INX
 CPX temp1
 BCS CC8CD
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 BEQ CC9D8

.CC971

 LDA addr4
 ADC #&10
 STA addr4
 LDA addr4+1
 ADC #0
 STA addr4+1
 STA PPU_ADDR
 LDA addr4
 STA PPU_ADDR
 INX
 CPX temp1
 BCS CC9FB
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 BEQ CCA1B

.CC9BC

 LDA addr4
 ADC #&10
 STA addr4
 LDA addr4+1
 ADC #0
 STA addr4+1
 STA PPU_ADDR
 LDA addr4
 STA PPU_ADDR
 INX
 CPX temp1
 BCS CCA08
 JMP CC8D2

.CC9D8

 INC addr5+1

 SEC                    \ Subtract 29 (&001D) from cycleCount
 LDA cycleCount
 SBC #&1D
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 CLC
 JMP CC971

.CC9EB

 CLC                    \ Add 224 (&00E0) to cycleCount
 LDA cycleCount
 ADC #&E0
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CCA08

.CC9FB

 CLC                    \ Add 109 (&006D) to cycleCount
 LDA cycleCount
 ADC #&6D
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

.CCA08

 STX L00C9
 NOP
 LDX otherPhase
 STY L00DB,X
 LDA addr5+1
 STA L04BE,X
 LDA L00C9
 STA L00CA,X
 JMP CCBBC

.CCA1B

 INC addr5+1

 SEC                    \ Subtract 29 (&001D) from cycleCount
 LDA cycleCount
 SBC #&1D
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 CLC
 JMP CC9BC

.CCA2E

 LDA L00C9
 LDX #0
 STX addr4
 STX addr5
 ASL A
 ROL addr4
 ASL A
 ROL addr4
 ASL A
 ROL addr4
 ASL A
 TAX
 LDA addr4
 ROL A
 ADC L00E0
 STA PPU_ADDR
 STA addr4+1
 TXA
 ADC pallettePhasex8
 STA PPU_ADDR
 STA addr4
 JMP CCA68

\ ******************************************************************************
\
\       Name: subm_CA56
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_CA56

 INC addr5+1

 SEC                    \ Subtract 27 (&001B) from cycleCount
 LDA cycleCount
 SBC #&1B
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 JMP CCABD

.CCA68

 LDX L00C9

.CCA6A

 SEC                    \ Subtract 266 (&010A) from cycleCount
 LDA cycleCount
 SBC #&0A
 STA cycleCount
 LDA cycleCount+1
 SBC #&01
 STA cycleCount+1

 BMI CCA7C
 JMP CCA8B

.CCA7C

 LDA cycleCount         \ Add 225 (&00E1) to cycleCount
 ADC #&E1
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CCB30

.CCA8B

 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 BEQ subm_CA56

.CCABD

 LDA addr4
 CLC
 ADC #&10
 STA addr4
 LDA addr4+1
 ADC #0
 STA addr4+1
 STA PPU_ADDR
 LDA addr4
 STA PPU_ADDR
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 BEQ CCB1D

.CCB04

 LDA addr4
 ADC #&10
 STA addr4
 LDA addr4+1
 ADC #0
 STA addr4+1
 STA PPU_ADDR
 LDA addr4
 STA PPU_ADDR
 INX
 INX
 JMP CCA6A

.CCB1D

 INC addr5+1

 SEC                    \ Subtract 29 (&001D) from cycleCount
 LDA cycleCount
 SBC #&1D
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 CLC
 JMP CCB04

.CCB30

 STX L00C9
 LDX otherPhase
 STY L00DB,X
 LDA addr5+1
 STA L04BE,X
 LDA L00C9
 STA L00CA,X
 JMP CC6F3

\ ******************************************************************************
\
\       Name: subm_CB42
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_CB42

 LDX otherPhase
 LDA #&20
 STA L03EF,X

 SEC                    \ Subtract 227 (&00E3) from cycleCount
 LDA cycleCount
 SBC #&E3
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 BMI CCB5B
 JMP CCB6A

.CCB5B

 LDA cycleCount         \ Add 176 (&00B0) to cycleCount
 ADC #&B0
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CC6F3

.CCB6A

 TXA
 EOR #1
 STA otherPhase
 CMP palettePhase
 BNE CCB8E
 TAX
 LDA L03EF,X
 AND #&A0
 CMP #&80
 BEQ CCB80
 JMP CC7D2

.CCB80

 CLC                    \ Add 151 (&0097) to cycleCount
 LDA cycleCount
 ADC #&97
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 RTS

.CCB8E

 CLC                    \ Add 163 (&00A3) to cycleCount
 LDA cycleCount
 ADC #&A3
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 RTS

\ ******************************************************************************
\
\       Name: subm_CB9C
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_CB9C

 CLC                    \ Add 58 (&003A) to cycleCount
 LDA cycleCount
 ADC #&3A
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CC6F3

.CCBAC

 CLC                    \ Add 53 (&0035) to cycleCount
 LDA cycleCount
 ADC #&35
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP subm_CB42

.CCBBC

 SEC                    \ Subtract 109 (&006D) from cycleCount
 LDA cycleCount
 SBC #&6D
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 BMI CCBCE
 JMP CCBDD

.CCBCE

 LDA cycleCount         \ Add 68 (&0044) to cycleCount
 ADC #&44
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CC6F3

.CCBDD

 LDX otherPhase
 LDA L03EF,X
 ASL A
 BPL subm_CB9C
 LDY L00CD,X
 AND #8
 BEQ CCBED
 LDY #&80

.CCBED

 STY temp1
 LDA tile3Phase0,X
 STA L00CF
 SEC
 SBC temp1
 BCS CCBAC
 LDY L00DD,X
 LDA L04C0,X
 STA addr5+1
 CLC
 ADC L04C6,X
 STA PPU_ADDR
 STY PPU_ADDR
 LDA #0
 STA addr5

.CCC0D

 SEC                    \ Subtract 393 (&0189) from cycleCount
 LDA cycleCount
 SBC #&89
 STA cycleCount
 LDA cycleCount+1
 SBC #&01
 STA cycleCount+1

 BMI subm_CC1F
 JMP SendToPPU1

\ ******************************************************************************
\
\       Name: subm_CC1F
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_CC1F

 LDA cycleCount         \ Add 349 (&015D) to cycleCount
 ADC #&5D
 STA cycleCount
 LDA cycleCount+1
 ADC #&01
 STA cycleCount+1

 JMP CCD26

\ ******************************************************************************
\
\       Name: SendToPPU1
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.SendToPPU1

 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 LDA (addr5),Y
 STA PPU_DATA
 INY
 BEQ CCD09
 LDA L00CF
 ADC #3
 STA L00CF
 CMP temp1
 BCS CCCFD
 JMP CCC0D

.CCCFD

 STA tile3Phase0,X
 STY L00DD,X
 LDA addr5+1
 STA L04C0,X
 JMP subm_CB42

.CCD09

 INC addr5+1

 SEC                    \ Subtract 26 (&001A) from cycleCount
 LDA cycleCount
 SBC #&1A
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 LDA L00CF
 CLC
 ADC #4
 STA L00CF
 CMP temp1
 BCS CCCFD
 JMP CCC0D

.CCD26

 LDA L00CF
 STA tile3Phase0,X
 STY L00DD,X
 LDA addr5+1
 STA L04C0,X
 JMP CC6F3

\ ******************************************************************************
\
\       Name: CopyNameBuffer0To1
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.CopyNameBuffer0To1

 LDY #0
 LDX #&10

.CCD38

 LDA nameBuffer0,Y
 STA nameBuffer1,Y
 LDA nameBuffer0+8*32,Y
 STA nameBuffer1+8*32,Y
 LDA nameBuffer0+16*32,Y
 STA nameBuffer1+16*32,Y
 LDA nameBuffer0+24*32,Y
 STA nameBuffer1+24*32,Y

 JSR SetupPPUForIconBar \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 DEX
 BNE CCD58
 LDX #&10

.CCD58

 DEY
 BNE CCD38
 LDA tileNumber
 STA tile0Phase0
 STA tile0Phase1
 RTS

\ ******************************************************************************
\
\       Name: DrawBoxTop
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.DrawBoxTop

 LDY #1
 LDA #3

.loop_CCD66

 STA nameBuffer0,Y
 INY
 CPY #&20
 BNE loop_CCD66
 RTS

\ ******************************************************************************
\
\       Name: DrawBoxEdges
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.DrawBoxEdges

 LDX drawingPhase
 BNE CCDF2

 LDA boxEdge1

 STA nameBuffer0+1
 STA nameBuffer0+1*32+1
 STA nameBuffer0+2*32+1
 STA nameBuffer0+3*32+1
 STA nameBuffer0+4*32+1
 STA nameBuffer0+5*32+1
 STA nameBuffer0+6*32+1
 STA nameBuffer0+7*32+1
 STA nameBuffer0+8*32+1
 STA nameBuffer0+9*32+1
 STA nameBuffer0+10*32+1
 STA nameBuffer0+11*32+1
 STA nameBuffer0+12*32+1
 STA nameBuffer0+13*32+1
 STA nameBuffer0+14*32+1
 STA nameBuffer0+15*32+1
 STA nameBuffer0+16*32+1
 STA nameBuffer0+17*32+1
 STA nameBuffer0+18*32+1
 STA nameBuffer0+19*32+1

 LDA boxEdge2

 STA nameBuffer0
 STA nameBuffer0+1*32
 STA nameBuffer0+2*32
 STA nameBuffer0+3*32
 STA nameBuffer0+4*32
 STA nameBuffer0+5*32
 STA nameBuffer0+6*32
 STA nameBuffer0+7*32
 STA nameBuffer0+8*32
 STA nameBuffer0+9*32
 STA nameBuffer0+10*32
 STA nameBuffer0+11*32
 STA nameBuffer0+12*32
 STA nameBuffer0+13*32
 STA nameBuffer0+14*32
 STA nameBuffer0+15*32
 STA nameBuffer0+16*32
 STA nameBuffer0+17*32
 STA nameBuffer0+18*32
 STA nameBuffer0+19*32

 RTS

.CCDF2

 LDA boxEdge1

 STA nameBuffer1+1
 STA nameBuffer1+1*32+1
 STA nameBuffer1+2*32+1
 STA nameBuffer1+3*32+1
 STA nameBuffer1+4*32+1
 STA nameBuffer1+5*32+1
 STA nameBuffer1+6*32+1
 STA nameBuffer1+7*32+1
 STA nameBuffer1+8*32+1
 STA nameBuffer1+9*32+1
 STA nameBuffer1+10*32+1
 STA nameBuffer1+11*32+1
 STA nameBuffer1+12*32+1
 STA nameBuffer1+13*32+1
 STA nameBuffer1+14*32+1
 STA nameBuffer1+15*32+1
 STA nameBuffer1+16*32+1
 STA nameBuffer1+17*32+1
 STA nameBuffer1+18*32+1
 STA nameBuffer1+19*32+1

 LDA boxEdge2

 STA nameBuffer1
 STA nameBuffer1+1*32
 STA nameBuffer1+2*32
 STA nameBuffer1+3*32
 STA nameBuffer1+4*32
 STA nameBuffer1+5*32
 STA nameBuffer1+6*32
 STA nameBuffer1+7*32
 STA nameBuffer1+8*32
 STA nameBuffer1+9*32
 STA nameBuffer1+10*32
 STA nameBuffer1+11*32
 STA nameBuffer1+12*32
 STA nameBuffer1+13*32
 STA nameBuffer1+14*32
 STA nameBuffer1+15*32
 STA nameBuffer1+16*32
 STA nameBuffer1+17*32
 STA nameBuffer1+18*32
 STA nameBuffer1+19*32

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 RTS

INCLUDE "library/common/main/variable/univ.asm"
INCLUDE "library/common/main/subroutine/ginf.asm"

\ ******************************************************************************
\
\       Name: HideSprites59_62
\       Type: Subroutine
\   Category: Drawing sprites
\    Summary: ???
\
\ ******************************************************************************

.HideSprites59_62

 LDX #4
 LDY #236
 JMP HideSprites

\ ******************************************************************************
\
\       Name: HideScannerSprites
\       Type: Subroutine
\   Category: Drawing sprites
\    Summary: ???
\
\ ******************************************************************************

.HideScannerSprites

 LDX #0

.loop_CCEA7

 LDA FRIN,X
 BEQ CCEBC
 BMI CCEB9
 JSR GINF
 LDY #&1F
 LDA (XX19),Y
 AND #&EF
 STA (XX19),Y

.CCEB9

 INX
 BNE loop_CCEA7

.CCEBC

 LDY #&2C
 LDX #&1B

\ ******************************************************************************
\
\       Name: HideSprites
\       Type: Subroutine
\   Category: Drawing sprites
\    Summary: Hide X sprites from sprite Y/4 onwards
\
\ ******************************************************************************

.HideSprites

 LDA #240

.loop_CCEC2

 STA ySprite0,Y
 INY
 INY
 INY
 INY
 DEX
 BNE loop_CCEC2
 RTS

 EQUB &0C, &20, &1F                           ; CECD: 0C 20 1F    . .

INCLUDE "library/nes/main/variable/namebufferhiaddr.asm"
INCLUDE "library/nes/main/variable/pattbufferhiaddr.asm"

\ ******************************************************************************
\
\       Name: IRQ
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.IRQ

 RTI

\ ******************************************************************************
\
\       Name: NMI
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.NMI

 JSR SendPaletteSprites
 LDA showUserInterface
 STA setupPPUForIconBar

IF _NTSC

 LDA #&1A
 STA cycleCount+1
 LDA #&8D
 STA cycleCount

ELIF _PAL

 LDA #&1D
 STA cycleCount+1
 LDA #&09
 STA cycleCount

ENDIF

 JSR UpdateScreen
 JSR ReadControllers
 LDA L03EE
 BPL CCEF2
 JSR subm_E802

.CCEF2

 JSR MoveIconBarPointer
 JSR UpdateJoystick
 JSR UpdateNMITimer
 LDA runningSetBank
 BNE CCF0C
 JSR PlayMusic_b6
 LDA nmiStoreA
 LDX nmiStoreX
 LDY nmiStoreY
 RTI

.CCF0C

 INC runningSetBank
 LDA nmiStoreA
 LDX nmiStoreX
 LDY nmiStoreY
 RTI

\ ******************************************************************************
\
\       Name: UpdateNMITimer
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.UpdateNMITimer

 DEC nmiTimer
 BNE CCF2D
 LDA #&32
 STA nmiTimer
 LDA nmiTimerLo
 CLC
 ADC #1
 STA nmiTimerLo
 LDA nmiTimerHi
 ADC #0
 STA nmiTimerHi

.CCF2D

 RTS

\ ******************************************************************************
\
\       Name: SendPaletteSprites
\       Type: Subroutine
\   Category: Drawing tiles
\    Summary: Send the current palette and sprite data to the PPU
\
\ ******************************************************************************

.SendPaletteSprites

 STA nmiStoreA          \ Store the values of A, X and Y so we can retrieve them
 STX nmiStoreX          \ later
 STY nmiStoreY

 LDA PPU_STATUS         \ Read from PPU_STATUS to clear bit 7 of PPU_STATUS and
                        \ reset the VBlank start flag

 INC frameCounter       \ Increment the frame counter

 LDA #0                 \ Write 0 to OAM_ADDR so we can use OAM_DMA to send
 STA OAM_ADDR           \ sprite data to the PPU

 LDA #&02               \ Write &02 to OAM_DMA to upload 256 bytes of sprite
 STA OAM_DMA            \ data from the sprite buffer at &02xx into the PPU

 LDA #%00000000         \ Set PPU_MASK as follows:
 STA PPU_MASK           \
                        \   * Bit 0 clear = normal colour (not monochrome)
                        \   * Bit 1 clear = hide leftmost 8 pixels of background
                        \   * Bit 2 clear  = hide sprites in leftmost 8 pixels
                        \   * Bit 3 clear = hide background
                        \   * Bit 4 clear = hide sprites
                        \   * Bit 5 clear = do not intensify greens
                        \   * Bit 6 clear = do not intensify blues
                        \   * Bit 7 clear = do not intensify reds

\ ******************************************************************************
\
\       Name: SetPaletteForPhase
\       Type: Subroutine
\   Category: Drawing tiles
\    Summary: Set the palette according to the palette phase and view type
\
\ ******************************************************************************

.SetPaletteForPhase

 LDA QQ11a              \ Set A to the current view (or the old view that is
                        \ still being shown, if we are in the process of
                        \ changing view)

 BNE paph2              \ If this is not the space view, jump to paph2

                        \ If we get here then this is the space view

 LDY visibleColour      \ Set Y to the colour to use for visible pixels

 LDA palettePhase       \ If palettePhase is non-zero (i.e. 1), jump to paph1
 BNE paph1

 LDA #&3F               \ Set PPU_ADDR = &3F01, so it points to palette 0 in
 STA PPU_ADDR           \ the PPU
 LDA #1
 STA PPU_ADDR

 LDA hiddenColour       \ Set A to the colour to use for hidden pixels

 STA PPU_DATA           \ Set palette 0 to the following:
 STY PPU_DATA           \
 STY PPU_DATA           \   * Colour 0 = background (black)
                        \
                        \   * Colour 1 = hidden colour
                        \
                        \   * Colour 2 = visible colour
                        \
                        \   * Colour 3 = visible colour
                        \
                        \ So pixels in colour 1 will be invisible, while pixels
                        \ in colour 2 will be visible

 LDA #0                 \ Change the PPU address away from the palette entries
 STA PPU_ADDR           \ to prevent the palette being corrupted
 LDA #0
 STA PPU_ADDR

 RTS                    \ Return from the subroutine

.paph1

 LDA #&3F               \ Set PPU_ADDR = &3F01, so it points to palette 0 in
 STA PPU_ADDR           \ the PPU
 LDA #1
 STA PPU_ADDR

 LDA hiddenColour       \ Set A to the colour to use for hidden pixels

 STY PPU_DATA           \ Set palette 0 to the following:
 STA PPU_DATA           \
 STY PPU_DATA           \   * Colour 0 = background (black)
                        \
                        \   * Colour 1 = visible colour
                        \
                        \   * Colour 2 = hidden colour
                        \
                        \   * Colour 3 = visible colour
                        \
                        \ So pixels in colour 1 will be visible, while pixels
                        \ in colour 2 will be invisible

 LDA #0                 \ Change the PPU address away from the palette entries
 STA PPU_ADDR           \ to prevent the palette being corrupted
 LDA #0
 STA PPU_ADDR

 RTS                    \ Return from the subroutine

.paph2

                        \ If we get here then this is not the space view

 CMP #&98               \ If the view is &98, jump to paph3 ???
 BEQ paph3

                        \ If we get here then this is not the space view or view
                        \ &98 ???

 LDA #&3F               \ Set PPU_ADDR = &3F15, so it points to sprite palette 1
 STA PPU_ADDR           \ in the PPU
 LDA #&15
 STA PPU_ADDR

 LDA visibleColour      \ Set palette 0 to the following:
 STA PPU_DATA           \
 LDA paletteColour2     \   * Colour 0 = background (black)
 STA PPU_DATA           \
 LDA paletteColour3     \   * Colour 1 = visible colour
 STA PPU_DATA           \
                        \   * Colour 2 = paletteColour2
                        \
                        \   * Colour 3 = paletteColour3

 LDA #0                 \ Change the PPU address away from the palette entries
 STA PPU_ADDR           \ to prevent the palette being corrupted
 LDA #0
 STA PPU_ADDR

 RTS                    \ Return from the subroutine

.paph3

                        \ If we get here then the view is &98 ???

 LDA #&3F               \ Set PPU_ADDR = &3F01, so it points to palette 0 in
 STA PPU_ADDR           \ the PPU
 LDA #1
 STA PPU_ADDR

 LDA visibleColour      \ Set palette 0 to the following:
 STA PPU_DATA           \
 LDA paletteColour2     \   * Colour 0 = background (black)
 STA PPU_DATA           \
 LDA paletteColour3     \   * Colour 1 = visible colour
 STA PPU_DATA           \
                        \   * Colour 2 = paletteColour2
                        \
                        \   * Colour 3 = paletteColour3

 LDA #0                 \ Change the PPU address away from the palette entries
 STA PPU_ADDR           \ to prevent the palette being corrupted
 LDA #0
 STA PPU_ADDR

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: SendPalettesToPPU
\       Type: Subroutine
\   Category: Drawing tiles
\    Summary: Send the palette data from XX3 to the PPU
\
\ ******************************************************************************

.SendPalettesToPPU

 LDA #&3F               \ Set PPU_ADDR = &3F01, so it points to palette 0 in
 STA PPU_ADDR           \ the PPU
 LDA #1
 STA PPU_ADDR

 LDX #1                 \ We are about to send the palette data from XX3 to
                        \ the PPU, so set an index counter in X so we send the
                        \ following:
                        \
                        \   XX3+1 goes to &3F01
                        \   XX3+2 goes to &3F02
                        \   ...
                        \   XX3+&30 goes to &3F30
                        \   XX3+&31 goes to &3F31
                        \
                        \ So the following loop sends data for the four
                        \ background palettes and the four sprite palettes

.sepa1

 LDA XX3,X              \ Set A to the X-th entry in XX3

 AND #%00111111         \ Clear bits 6 and 7

 STA PPU_DATA           \ Send the palette entry to the PPU

 INX                    \ Increment the loop counter

 CPX #&20               \ Loop back until we have sent XX3+1 through XX3+&1F
 BNE sepa1

 SEC                    \ Subtract 559 (&022F) from cycleCount
 LDA cycleCount
 SBC #&2F
 STA cycleCount
 LDA cycleCount+1
 SBC #&02
 STA cycleCount+1

 JMP UpdateScreen+4     \ Return to UpdateScreen to continue with the next
                        \ instruction following the call to this routine

\ ******************************************************************************
\
\       Name: UpdateScreen
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.UpdateScreen

 LDA updatePaletteInNMI \ If updatePaletteInNMI is non-zero, then jump up to
 BNE SendPalettesToPPU   \ SendPalettesToPPU to send the palette data in XX3 to
                        \ the PPU, before continuing with the next instruction

 JSR SendBuffersToPPU
 JSR ResetPPURegisters

 LDA cycleCount         \ Add 100 (&0064) to cycleCount
 CLC
 ADC #&64
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 BMI upsc1              \ If cycleCount is negative, skip the following
                        \ instruction

 JSR subm_D07C

.upsc1

 LDA #%00011110         \ Set PPU_MASK as follows:
 STA PPU_MASK           \
                        \   * Bit 0 clear = normal colour (not monochrome)
                        \   * Bit 1 set   = show leftmost 8 pixels of background
                        \   * Bit 2 set   = show sprites in leftmost 8 pixels
                        \   * Bit 3 set   = show background
                        \   * Bit 4 set   = show sprites
                        \   * Bit 5 clear = do not intensify greens
                        \   * Bit 6 clear = do not intensify blues
                        \   * Bit 7 clear = do not intensify reds

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: ResetPPURegisters
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.ResetPPURegisters

 LDX #&90
 LDA palettePhase
 BNE CD035
 LDX #&91

.CD035

 STX PPU_CTRL
 STX ppuCtrlCopy
 LDA #&20
 LDX palettePhase
 BNE CD042
 LDA #&24

.CD042

 STA PPU_ADDR
 LDA #0
 STA PPU_ADDR
 LDA PPU_DATA
 LDA PPU_DATA
 LDA PPU_DATA
 LDA PPU_DATA
 LDA PPU_DATA
 LDA PPU_DATA
 LDA PPU_DATA
 LDA PPU_DATA
 LDA #8
 STA PPU_SCROLL
 LDA #0
 STA PPU_SCROLL
 RTS

\ ******************************************************************************
\
\       Name: SetPPUTablesTo0
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.SetPPUTablesTo0

 LDA #0
 STA setupPPUForIconBar
 LDA ppuCtrlCopy
 AND #&EE
 STA PPU_CTRL
 STA ppuCtrlCopy
 CLC
 RTS

\ ******************************************************************************
\
\       Name: subm_D07C
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_D07C

 LDA cycleCount+1
 BEQ CD0D0

 SEC                    \ Subtract 363 (&016B) from cycleCount
 LDA cycleCount
 SBC #&6B
 STA cycleCount
 LDA cycleCount+1
 SBC #&01
 STA cycleCount+1

 BMI CD092
 JMP CD0A1

.CD092

 LDA cycleCount         \ Add 318 (&013E) to cycleCount
 ADC #&3E
 STA cycleCount
 LDA cycleCount+1
 ADC #&01
 STA cycleCount+1

 JMP CD0D0

.CD0A1

 LDA L00EF
 PHA
 LDA L00F0
 PHA
 LDA addr6
 PHA
 LDA addr6+1
 PHA
 LDX #0
 JSR ClearPartOfBuffer
 LDX #1
 JSR ClearPartOfBuffer
 PLA
 STA addr6+1
 PLA
 STA addr6
 PLA
 STA L00F0
 PLA
 STA L00EF

 CLC                    \ Add 238 (&00EE) to cycleCount
 LDA cycleCount
 ADC #&EE
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

.CD0D0

 SEC                    \ Subtract 32 (&0020) from cycleCount
 LDA cycleCount
 SBC #&20
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 BMI CD0E2
 JMP CD0F1

.CD0E2

 LDA cycleCount         \ Add xxx (&0FFF7) to cycleCount
 ADC #&F7
 STA cycleCount
 LDA cycleCount+1
 ADC #&0FF
 STA cycleCount+1

 JMP CD0F7

.CD0F1

 NOP
 NOP
 NOP
 JMP CD0D0

.CD0F7

 RTS

\ ******************************************************************************
\
\       Name: ReadControllers
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.ReadControllers

 LDA #1
 STA JOY1
 LSR A
 STA JOY1
 TAX
 JSR ScanButtons
 LDX scanController2
 BEQ CD15A

\ ******************************************************************************
\
\       Name: ScanButtons
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.ScanButtons

 LDA JOY1,X
 AND #3
 CMP #1
 ROR controller1A,X
 LDA JOY1,X
 AND #3
 CMP #1
 ROR controller1B,X
 LDA JOY1,X
 AND #3
 CMP #1
 ROR controller1Select,X
 LDA JOY1,X
 AND #3
 CMP #1
 ROR controller1Start,X
 LDA JOY1,X
 AND #3
 CMP #1
 ROR controller1Up,X
 LDA JOY1,X
 AND #3
 CMP #1
 ROR controller1Down,X
 LDA JOY1,X
 AND #3
 CMP #1
 ROR controller1Left,X
 LDA JOY1,X
 AND #3
 CMP #1
 ROR controller1Right,X

.CD15A

 RTS

 LDA frameCounter

.loop_CD15E

 CMP frameCounter
 BEQ loop_CD15E
 RTS

\ ******************************************************************************
\
\       Name: KeepPPUTablesAt0x2
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.KeepPPUTablesAt0x2

 JSR KeepPPUTablesAt0

\ ******************************************************************************
\
\       Name: KeepPPUTablesAt0
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.KeepPPUTablesAt0

 PHA
 LDX frameCounter

.loop_CD16B

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 CPX frameCounter
 BEQ loop_CD16B
 PLA
 RTS

\ ******************************************************************************
\
\       Name: subm_D17F
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_D17F

 LDA setupPPUForIconBar
 BEQ subm_D17F

.loop_CD183

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA setupPPUForIconBar
 BNE loop_CD183
 RTS

 LDX #0
 JSR CD19C
 LDX #1

.CD19C

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA L03EF,X
 BEQ CD1C7
 AND #&20
 BNE CD1B8
 JSR CD1C8
 JMP CD19C

.CD1B8

 JSR CD1C8
 LDA #0
 STA L03EF,X
 LDA L00D2
 STA tileNumber
 JMP DrawBoxTop

.CD1C7

 RTS

.CD1C8

 LDY frameCounter
 LDA tile3Phase0,X
 STA SC
 LDA tile2Phase0,X
 CPY frameCounter
 BNE CD1C8
 LDY SC
 CPY L00D8
 BCC CD1DE
 LDY L00D8

.CD1DE

 STY SC
 CMP SC
 BCS CD239
 STY tile2Phase0,X
 LDY #0
 STY addr6+1
 ASL A
 ROL addr6+1
 ASL A
 ROL addr6+1
 ASL A
 STA addr6
 LDA addr6+1
 ROL A
 ADC nameBufferHiAddr,X
 STA addr6+1
 LDA #0
 ASL SC
 ROL A
 ASL SC
 ROL A
 ASL SC
 ROL A
 ADC nameBufferHiAddr,X
 STA SC+1

.CD20B

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA SC
 SEC
 SBC addr6
 STA L00EF
 LDA SC+1
 SBC addr6+1
 BCC CD239
 STA L00F0
 ORA L00EF
 BEQ CD239
 LDA #3
 STA cycleCount+1
 LDA #&16
 STA cycleCount
 JSR ClearMemory
 JMP CD20B

.CD239

 LDY frameCounter
 LDA L00CA,X
 STA SC
 LDA tile1Phase0,X
 CPY frameCounter
 BNE CD239
 LDY SC
 CMP SC
 BCS CD2A2
 STY tile1Phase0,X
 LDY #0
 STY addr6+1
 ASL A
 ROL addr6+1
 ASL A
 ROL addr6+1
 ASL A
 STA addr6
 LDA addr6+1
 ROL A
 ADC pattBufferHiAddr,X
 STA addr6+1
 LDA #0
 ASL SC
 ROL A
 ASL SC
 ROL A
 ASL SC
 ROL A
 ADC pattBufferHiAddr,X
 STA SC+1

.CD274

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA SC
 SEC
 SBC addr6
 STA L00EF
 LDA SC+1
 SBC addr6+1
 BCC CD239
 STA L00F0
 ORA L00EF
 BEQ CD2A2
 LDA #3
 STA cycleCount+1
 LDA #&16
 STA cycleCount
 JSR ClearMemory
 JMP CD274

.CD2A2

 RTS

\ ******************************************************************************
\
\       Name: LD2A3
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.LD2A3

 EQUB &30                                     ; D2A3: 30          0

\ ******************************************************************************
\
\       Name: ClearPartOfBuffer
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.CD2A4

 NOP
 NOP

.CD2A6

 SEC                    \ Subtract 39 (&0027) from cycleCount
 LDA cycleCount
 SBC #&27
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

.CD2B3

 RTS

.CD2B4

 CLC                    \ Add 126 (&007E) to cycleCount
 LDA cycleCount
 ADC #&7E
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CD37E

.ClearPartOfBuffer

 LDA cycleCount+1
 BEQ CD2B3
 LDA L03EF,X
 BIT LD2A3
 BEQ CD2A4
 AND #8
 BEQ CD2A6

 SEC                    \ Subtract 213 (&00D5) from cycleCount
 LDA cycleCount
 SBC #&D5
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 BMI CD2E6
 JMP CD2F5

.CD2E6

 LDA cycleCount         \ Add 153 (&0099) to cycleCount
 ADC #&99
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CD2B3

.CD2F5

 LDA tile2Phase0,X
 LDY tile3Phase0,X
 CPY L00D8
 BCC CD2FF
 LDY L00D8

.CD2FF

 STY L00EF
 CMP L00EF
 BCS CD2B4
 LDY #0
 STY addr6+1
 ASL A
 ROL addr6+1
 ASL A
 ROL addr6+1
 ASL A
 STA addr6
 LDA addr6+1
 ROL A
 ADC nameBufferHiAddr,X
 STA addr6+1
 LDA #0
 ASL L00EF
 ROL A
 ASL L00EF
 ROL A
 ASL L00EF
 ROL A
 ADC nameBufferHiAddr,X
 STA L00F0
 LDA L00EF
 SEC
 SBC addr6
 STA L00EF
 LDA L00F0
 SBC addr6+1
 BCC CD359
 STA L00F0
 ORA L00EF
 BEQ CD35D
 JSR ClearMemory
 LDA addr6+1
 SEC
 SBC nameBufferHiAddr,X
 LSR A
 ROR addr6
 LSR A
 ROR addr6
 LSR A
 LDA addr6
 ROR A
 CMP tile2Phase0,X
 BCC CD37B
 STA tile2Phase0,X
 JMP CD37E

.CD359

 NOP
 NOP
 NOP
 NOP

.CD35D

 CLC                    \ Add 28 (&001C) to cycleCount
 LDA cycleCount
 ADC #&1C
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CD37E

.CD36D

 CLC                    \ Add 126 (&007E) to cycleCount
 LDA cycleCount
 ADC #&7E
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

.CD37A

 RTS

.CD37B

 NOP
 NOP
 NOP

.CD37E

 SEC                    \ Subtract 187 (&00BB) from cycleCount
 LDA cycleCount
 SBC #&BB
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 BMI CD390
 JMP CD39F

.CD390

 LDA cycleCount         \ Add 146 (&0092) to cycleCount
 ADC #&92
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CD37A

.CD39F

 LDA tile1Phase0,X
 LDY L00CA,X
 STY L00EF
 CMP L00EF
 BCS CD36D
 NOP
 LDY #0
 STY addr6+1
 ASL A
 ROL addr6+1
 ASL A
 ROL addr6+1
 ASL A
 STA addr6
 LDA addr6+1
 ROL A
 ADC pattBufferHiAddr,X
 STA addr6+1
 LDA #0
 ASL L00EF
 ROL A
 ASL L00EF
 ROL A
 ASL L00EF
 ROL A
 ADC pattBufferHiAddr,X
 STA L00F0
 LDA L00EF
 SEC
 SBC addr6
 STA L00EF
 LDA L00F0
 SBC addr6+1
 BCC CD3FC
 STA L00F0
 ORA L00EF
 BEQ CD401
 JSR ClearMemory
 LDA addr6+1
 SEC
 SBC pattBufferHiAddr,X
 LSR A
 ROR addr6
 LSR A
 ROR addr6
 LSR A
 LDA addr6
 ROR A
 CMP tile1Phase0,X
 BCC CD3FC
 STA tile1Phase0,X
 RTS

.CD3FC

 NOP
 NOP
 NOP
 NOP
 RTS

.CD401

 CLC                    \ Add 35 (&0023) to cycleCount
 LDA cycleCount
 ADC #&23
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 RTS

\ ******************************************************************************
\
\       Name: FillMemory
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.FillMemory

 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY

\ ******************************************************************************
\
\       Name: FillMemory32Bytes
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.FillMemory32Bytes

 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 RTS

\ ******************************************************************************
\
\       Name: ClearMemory
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.ClearMemory

 LDA L00F0
 BEQ CD789

 SEC                    \ Subtract 2105 (&0839) from cycleCount
 LDA cycleCount
 SBC #&39
 STA cycleCount
 LDA cycleCount+1
 SBC #&08
 STA cycleCount+1

 BMI CD726
 JMP CD735

.CD726

 LDA cycleCount         \ Add 2059 (&080B) to cycleCount
 ADC #&0B
 STA cycleCount
 LDA cycleCount+1
 ADC #&08
 STA cycleCount+1

 JMP CD743

.CD735

 LDA #0
 LDY #0
 JSR FillMemory
 DEC L00F0
 INC addr6+1
 JMP ClearMemory

.CD743

 SEC                    \ Subtract 318 (&013E) from cycleCount
 LDA cycleCount
 SBC #&3E
 STA cycleCount
 LDA cycleCount+1
 SBC #&01
 STA cycleCount+1

 BMI CD755
 JMP CD764

.CD755

 LDA cycleCount         \ Add 277 (&0115) to cycleCount
 ADC #&15
 STA cycleCount
 LDA cycleCount+1
 ADC #&01
 STA cycleCount+1

 JMP CD788

.CD764

 LDA #0
 LDY #0
 JSR FillMemory32Bytes
 LDA addr6
 CLC
 ADC #&20
 STA addr6
 LDA addr6+1
 ADC #0
 STA addr6+1
 JMP CD743

.CD77B

 CLC                    \ Add 132 (&0084) to cycleCount
 LDA cycleCount
 ADC #&84
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

.CD788

 RTS

.CD789

 SEC                    \ Subtract 186 (&00BA) from cycleCount
 LDA cycleCount
 SBC #&BA
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 BMI CD79B
 JMP CD7AA

.CD79B

 LDA cycleCount         \ Add 138 (&008A) to cycleCount
 ADC #&8A
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CD788

.CD7AA

 LDA L00EF
 BEQ CD77B
 LSR A
 LSR A
 LSR A
 LSR A
 CMP cycleCount+1
 BCS CD809
 LDA #0
 STA L00F0
 LDA L00EF
 ASL A
 ROL L00F0
 ASL A
 ROL L00F0
 ASL A
 ROL L00F0
 EOR #&FF
 SEC
 ADC cycleCount
 STA cycleCount
 LDA L00F0
 EOR #&FF
 ADC cycleCount+1
 STA cycleCount+1
 LDY #0
 STY L00F0
 LDA L00EF
 PHA
 ASL A
 ROL L00F0
 ADC L00EF
 STA L00EF
 LDA L00F0
 ADC #0
 STA L00F0
 LDA #LO(ClearMemory)
 SBC L00EF
 STA L00EF
 LDA #HI(ClearMemory)
 SBC L00F0
 STA L00F0
 LDA #0
 JSR CD806
 PLA
 CLC
 ADC addr6
 STA addr6
 LDA addr6+1
 ADC #0
 STA addr6+1
 RTS

.CD806

 JMP (L00EF)

.CD809

 CLC                    \ Add 118 (&0076) to cycleCount
 LDA cycleCount
 ADC #&76
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

.CD816

 SEC                    \ Subtract 321 (&0141) from cycleCount
 LDA cycleCount
 SBC #&41
 STA cycleCount
 LDA cycleCount+1
 SBC #&01
 STA cycleCount+1

 BMI CD828
 JMP CD837

.CD828

 LDA cycleCount         \ Add 280 (&0118) to cycleCount
 ADC #&18
 STA cycleCount
 LDA cycleCount+1
 ADC #&01
 STA cycleCount+1

 JMP CD855

.CD837

 LDA L00EF
 SEC
 SBC #&20
 BCC CD856
 STA L00EF
 LDA #0
 LDY #0
 JSR FillMemory32Bytes
 LDA addr6
 CLC
 ADC #&20
 STA addr6
 BCC CD816
 INC addr6+1
 JMP CD816

.CD855

 RTS

.CD856

 CLC                    \ Add 269 (&010D) to cycleCount
 LDA cycleCount
 ADC #&0D
 STA cycleCount
 LDA cycleCount+1
 ADC #&01
 STA cycleCount+1

.CD863

 SEC                    \ Subtract 119 (&0077) from cycleCount
 LDA cycleCount
 SBC #&77
 STA cycleCount
 LDA cycleCount+1
 SBC #&00
 STA cycleCount+1

 BMI CD875
 JMP CD884

.CD875

 LDA cycleCount         \ Add 78 (&004E) to cycleCount
 ADC #&4E
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 JMP CD855

.CD884

 LDA L00EF
 SEC
 SBC #8
 BCC CD8B7
 STA L00EF
 LDA #0
 LDY #0
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 STA (addr6),Y
 INY
 LDA addr6
 CLC
 ADC #8
 STA addr6
 BCC CD8B4
 INC addr6+1

.CD8B4

 JMP CD863

.CD8B7

 CLC                    \ Add 66 (&0042) to cycleCount
 LDA cycleCount
 ADC #&42
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 RTS

\ ******************************************************************************
\
\       Name: subm_D8C5
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_D8C5

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA L03EF
 AND #&40
 BNE subm_D8C5
 LDA L03F0
 AND #&40
 BNE subm_D8C5
 RTS

\ ******************************************************************************
\
\       Name: ChangeDrawingPhase
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.ChangeDrawingPhase

 LDA drawingPhase
 EOR #1
 TAX
 JSR SetDrawingPhase
 JMP CD19C

\ ******************************************************************************
\
\       Name: SetDrawingPhase
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.SetDrawingPhase

 STX drawingPhase
 LDA tile0Phase0,X
 STA tileNumber
 LDA nameBufferHiAddr,X
 STA nameBufferHi
 LDA #0
 STA pattBufferAddr
 STA drawingPhaseDebug

\ ******************************************************************************
\
\       Name: SetPatternBuffer
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.SetPatternBuffer

 LDA pattBufferHiAddr,X
 STA pattBufferAddr+1
 LSR A
 LSR A
 LSR A
 STA pattBufferHiDiv8
 RTS

\ ******************************************************************************
\
\       Name: subm_D908
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_D908

 LDY #0

.CD90A

 LDA (V),Y
 STA (SC),Y
 DEY
 BNE CD90A
 INC V+1
 INC SC+1
 DEX
 BNE CD90A
 RTS

\ ******************************************************************************
\
\       Name: subm_D919
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_D919

 LDY #0
 INC V
 INC V+1

.CD91F

 LDA (SC2),Y
 STA (SC),Y
 INY
 BNE CD92A
 INC SC+1
 INC SC2+1

.CD92A

 DEC V
 BNE CD91F
 DEC V+1
 BNE CD91F
 RTS

\ ******************************************************************************
\
\       Name: subm_D933
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_D933

 LDA PPU_STATUS

.loop_CD936

 LDA PPU_STATUS
 BPL loop_CD936

.loop_CD93B

 LDA PPU_STATUS
 BPL loop_CD93B

.CD940

 LDA PPU_STATUS
 BPL CD940
 RTS

\ ******************************************************************************
\
\       Name: subm_D946
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_D946

 TXA
 PHA
 JSR CD940
 JSR PlayMusic_b6
 PLA
 TAX
 RTS

\ ******************************************************************************
\
\       Name: subm_D951
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_D951

 JSR subm_D8C5
 LDA tileNumber
 STA tile0Phase0
 STA tile0Phase1
 LDA #&58
 STA L00CC
 LDA #&64
 STA L00CD
 STA L00CE
 LDA #&C4
 STA L03EF
 STA L03F0
 JMP subm_D8C5

\ ******************************************************************************
\
\       Name: subm_D96F
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_D96F

 JSR ChangeDrawingPhase
 JSR LL9_b1

\ ******************************************************************************
\
\       Name: subm_D975
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_D975

 LDA #&C8

\ ******************************************************************************
\
\       Name: subm_D977
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_D977

 PHA
 JSR DrawBoxEdges
 LDX drawingPhase
 LDA tileNumber
 STA tile0Phase0,X
 PLA
 STA L03EF,X
 RTS

\ ******************************************************************************
\
\       Name: SendToPPU2
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.SendToPPU2

 LDY #0
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA (SC),Y
 STA PPU_DATA
 INY
 LDA SC
 CLC
 ADC #&10
 STA SC
 BCC CD9F3
 INC SC+1

.CD9F3

 DEX
 BNE SendToPPU2
 RTS

INCLUDE "library/common/main/variable/twos.asm"
INCLUDE "library/common/main/variable/twos2.asm"
INCLUDE "library/common/main/variable/twfl.asm"
INCLUDE "library/common/main/variable/twfr.asm"
INCLUDE "library/nes/main/variable/ylookuplo.asm"
INCLUDE "library/nes/main/variable/ylookuphi.asm"

\ ******************************************************************************
\
\       Name: subm_DBD8
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_DBD8

 LDA #0
 STA SC+1
 LDA YC
 BEQ CDBFE
 LDA YC
 CLC
 ADC #1
 ASL A
 ASL A
 ASL A
 ASL A
 ROL SC+1
 SEC
 ROL A
 ROL SC+1
 STA SC
 STA SC2
 LDA SC+1
 ADC #&70
 STA SC+1
 ADC #4
 STA SC2+1
 RTS

.CDBFE

 LDA #HI(nameBuffer0+1*32+1)    \ Set SC(1 0) to the address of the second tile
 STA SC+1                       \ on tile row 1 in nametable buffer 0
 LDA #LO(nameBuffer0+1*32+1)
 STA SC

 LDA #HI(nameBuffer1+1*32+1)    \ Set SC2(1 0) to the address of the second tile
 STA SC2+1                      \ on tile row 1 in nametable buffer 1
 LDA #LO(nameBuffer1+1*32+1)
 STA SC2

 RTS

\ ******************************************************************************
\
\       Name: LOIN
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.LOIN

 STY YSAV

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA #&80
 STA S
 ASL A
 STA SWAP
 LDA X2
 SBC XX15
 BCS CDC30
 EOR #&FF
 ADC #1

.CDC30

 STA P
 SEC
 LDA Y2
 SBC Y1
 BCS CDC3D
 EOR #&FF
 ADC #1

.CDC3D

 STA Q
 CMP P
 BCC CDC46
 JMP CDE20

.CDC46

 LDX XX15
 CPX X2
 BCC CDC5E
 DEC SWAP
 LDA X2
 STA XX15
 STX X2
 TAX
 LDA Y2
 LDY Y1
 STA Y1
 STY Y2

.CDC5E

 LDX Q
 BEQ CDC84
 LDA logL,X
 LDX P
 SEC
 SBC logL,X
 BMI CDC88
 LDX Q
 LDA log,X
 LDX P
 SBC log,X
 BCS CDC80
 TAX
 LDA antilog,X
 JMP CDC98

.CDC80

 LDA #&FF
 BNE CDC98

.CDC84

 LDA #0
 BEQ CDC98

.CDC88

 LDX Q
 LDA log,X
 LDX P
 SBC log,X
 BCS CDC80
 TAX
 LDA antilogODD,X

.CDC98

 STA Q
 LDA P
 CLC
 ADC #1
 STA P
 LDY Y1
 CPY Y2
 BCS CDCAA
 JMP CDD62

.CDCAA

 LDA XX15
 LSR A
 LSR A
 LSR A
 CLC
 ADC yLookupLo,Y
 STA SC2
 LDA nameBufferHi
 ADC yLookupHi,Y
 STA SC2+1
 TYA
 AND #7
 TAY
 LDA XX15
 AND #7
 TAX
 LDA TWOS,X

.CDCC8

 STA R

.CDCCA

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0
 LDA (SC2,X)
 BNE CDCE5
 LDA tileNumber
 BEQ CDD32
 STA (SC2,X)
 INC tileNumber

.CDCE5

 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 CLC

.loop_CDCF5

 LDA R
 ORA (SC),Y
 STA (SC),Y
 DEC P
 BEQ CDD51
 LDA S
 ADC Q
 STA S
 BCC CDD0A
 DEY
 BMI CDD18

.CDD0A

 LSR R
 BNE loop_CDCF5
 LDA #&80
 INC SC2
 BNE CDCC8
 INC SC2+1
 BNE CDCC8

.CDD18

 LDA SC2
 SBC #&20
 STA SC2
 BCS CDD22
 DEC SC2+1

.CDD22

 LDY #7
 LSR R
 BNE CDCCA
 LDA #&80
 INC SC2
 BNE CDCC8
 INC SC2+1
 BNE CDCC8

.CDD32

 DEC P
 BEQ CDD51
 CLC
 LDA S
 ADC Q
 STA S
 BCC CDD42
 DEY
 BMI CDD18

.CDD42

 LSR R
 BNE CDD32
 LDA #&80
 INC SC2
 BNE CDD4E
 INC SC2+1

.CDD4E

 JMP CDCC8

.CDD51

 LDY YSAV

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 CLC
 RTS

.CDD62

 LDA XX15
 LSR A
 LSR A
 LSR A
 CLC
 ADC yLookupLo,Y
 STA SC2
 LDA nameBufferHi
 ADC yLookupHi,Y
 STA SC2+1
 TYA
 AND #7
 TAY
 LDA XX15
 AND #7
 TAX
 LDA TWOS,X

.CDD80

 STA R

.CDD82

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0
 LDA (SC2,X)
 BNE CDD9D
 LDA tileNumber
 BEQ CDDEE
 STA (SC2,X)
 INC tileNumber

.CDD9D

 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 CLC

.loop_CDDAD

 LDA R
 ORA (SC),Y
 STA (SC),Y
 DEC P
 BEQ CDD51
 LDA S
 ADC Q
 STA S
 BCC CDDC4
 INY
 CPY #8
 BEQ CDDD3

.CDDC4

 LSR R
 BNE loop_CDDAD
 LDA #&80
 INC SC2
 BNE CDD80
 INC SC2+1
 JMP CDD80

.CDDD3

 LDA SC2
 ADC #&1F
 STA SC2
 BCC CDDDD
 INC SC2+1

.CDDDD

 LDY #0
 LSR R
 BNE CDD82
 LDA #&80
 INC SC2
 BNE CDD80
 INC SC2+1
 JMP CDD80

.CDDEE

 DEC P
 BEQ CDE1C
 CLC
 LDA S
 ADC Q
 STA S
 BCC CDE00
 INY
 CPY #8
 BEQ CDDD3

.CDE00

 LSR R
 BNE CDDEE
 LDA #&80
 INC SC2
 BNE CDE0C
 INC SC2+1

.CDE0C

 JMP CDD80

.loop_CDE0F

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

.CDE1C

 LDY YSAV
 CLC
 RTS

.CDE20

 LDY Y1
 TYA
 LDX XX15
 CPY Y2
 BEQ loop_CDE0F
 BCS CDE3C
 DEC SWAP
 LDA X2
 STA XX15
 STX X2
 TAX
 LDA Y2
 STA Y1
 STY Y2
 TAY

.CDE3C

 LDX P
 BEQ CDE62
 LDA logL,X
 LDX Q
 SEC
 SBC logL,X
 BMI CDE66
 LDX P
 LDA log,X
 LDX Q
 SBC log,X
 BCS CDE5E
 TAX
 LDA antilog,X
 JMP CDE76

.CDE5E

 LDA #&FF
 BNE CDE76

.CDE62

 LDA #0
 BEQ CDE76

.CDE66

 LDX P
 LDA log,X
 LDX Q
 SBC log,X
 BCS CDE5E
 TAX
 LDA antilogODD,X

.CDE76

 STA P
 LDA XX15
 LSR A
 LSR A
 LSR A
 CLC
 ADC yLookupLo,Y
 STA SC2
 LDA nameBufferHi
 ADC yLookupHi,Y
 STA SC2+1
 TYA
 AND #7
 TAY
 SEC
 LDA X2
 SBC XX15
 LDA XX15
 AND #7
 TAX
 LDA TWOS,X
 STA R
 LDX Q
 INX
 BCS CDEDD
 JMP CDFAA

\ ******************************************************************************
\
\       Name: subm_DEA5
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_DEA5

 LDY YSAV
 CLC
 RTS

.CDEA9

 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 CLC
 LDX Q

.loop_CDEBB

 LDA R
 STA (SC),Y
 DEX
 BEQ subm_DEA5
 LDA S
 ADC P
 STA S
 BCC CDECE
 LSR R
 BCS CDF35

.CDECE

 DEY
 BPL loop_CDEBB
 LDY #7
 LDA SC2
 SBC #&1F
 STA SC2
 BCS CDEDD
 DEC SC2+1

.CDEDD

 STX Q

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0
 LDA (SC2,X)
 BNE CDEFD
 LDA tileNumber
 BEQ CDF4F
 STA (SC2,X)
 INC tileNumber
 JMP CDEA9

.CDEFD

 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 CLC
 LDX Q

.loop_CDF0F

 LDA R
 ORA (SC),Y
 STA (SC),Y
 DEX
 BEQ subm_DEA5
 LDA S
 ADC P
 STA S
 BCC CDF24
 LSR R
 BCS CDF35

.CDF24

 DEY
 BPL loop_CDF0F
 LDY #7
 LDA SC2
 SBC #&1F
 STA SC2
 BCS CDEDD
 DEC SC2+1
 BNE CDEDD

.CDF35

 ROR R
 INC SC2
 BNE CDF3D
 INC SC2+1

.CDF3D

 DEY
 BPL CDEDD
 LDY #7
 LDA SC2
 SBC #&1F
 STA SC2
 BCS CDEDD
 DEC SC2+1
 JMP CDEDD

.CDF4F

 LDX Q

.loop_CDF51

 DEX
 BEQ CDF72
 LDA S
 ADC P
 STA S
 BCC CDF60
 LSR R
 BCS CDF35

.CDF60

 DEY
 BPL loop_CDF51
 LDY #7
 LDA SC2
 SBC #&1F
 STA SC2
 BCS CDF6F
 DEC SC2+1

.CDF6F

 JMP CDEDD

.CDF72

 LDY YSAV
 CLC
 RTS

\ ******************************************************************************
\
\       Name: subm_DF76
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_DF76

 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 CLC
 LDX Q

.loop_CDF88

 LDA R
 STA (SC),Y
 DEX
 BEQ CDF72
 LDA S
 ADC P
 STA S
 BCC CDF9B
 ASL R
 BCS CE003

.CDF9B

 DEY
 BPL loop_CDF88
 LDY #7
 LDA SC2
 SBC #&1F
 STA SC2
 BCS CDFAA
 DEC SC2+1

.CDFAA

 STX Q

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0
 LDA (SC2,X)
 BNE CDFCA
 LDA tileNumber
 BEQ CE01F
 STA (SC2,X)
 INC tileNumber
 JMP subm_DF76

.CDFCA

 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 CLC
 LDX Q

.loop_CDFDC

 LDA R
 ORA (SC),Y
 STA (SC),Y
 DEX
 BEQ CE046
 LDA S
 ADC P
 STA S
 BCC CDFF1
 ASL R
 BCS CE003

.CDFF1

 DEY
 BPL loop_CDFDC
 LDY #7
 LDA SC2
 SBC #&1F
 STA SC2
 BCS CDFAA
 DEC SC2+1
 JMP CDFAA

.CE003

 ROL R
 LDA SC2
 BNE CE00B
 DEC SC2+1

.CE00B

 DEC SC2
 DEY
 BPL CDFAA
 LDY #7
 LDA SC2
 SBC #&1F
 STA SC2
 BCS CDFAA
 DEC SC2+1
 JMP CDFAA

.CE01F

 LDX Q

.loop_CE021

 DEX
 BEQ CE042
 LDA S
 ADC P
 STA S
 BCC CE030
 ASL R
 BCS CE003

.CE030

 DEY
 BPL loop_CE021
 LDY #7
 LDA SC2
 SBC #&1F
 STA SC2
 BCS CE03F
 DEC SC2+1

.CE03F

 JMP CDFAA

.CE042

 LDY YSAV
 CLC
 RTS

.CE046

 LDY YSAV
 CLC
 RTS

\ ******************************************************************************
\
\       Name: subm_E04A
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_E04A

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 STY YSAV
 LDA P
 LSR A
 LSR A
 LSR A
 CLC
 ADC yLookupLo,Y
 STA SC2
 LDA nameBufferHi
 ADC yLookupHi,Y
 STA SC2+1
 LDA P+1
 SEC
 SBC P
 LSR A
 LSR A
 LSR A
 TAY
 DEY

.CE075

 LDA (SC2),Y
 BNE CE083
 LDA #&33
 STA (SC2),Y
 DEY
 BPL CE075
 LDY YSAV
 RTS

.CE083

 STY T
 LDY pattBufferHiDiv8
 STY SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDY #7

.loop_CE0A3

 LDA #&FF
 EOR (SC),Y
 STA (SC),Y
 DEY
 BPL loop_CE0A3
 LDY T
 DEY
 BPL CE075
 LDY YSAV
 RTS

.CE0B4

 JMP CE2A6

 LDY YSAV

.loop_CE0B9

 RTS

\ ******************************************************************************
\
\       Name: subm_E0BA
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_E0BA

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 STY YSAV
 LDX XX15
 CPX X2
 BEQ loop_CE0B9
 BCC CE0D8
 LDA X2
 STA XX15
 STX X2
 TAX

.CE0D8

 DEC X2
 TXA
 LSR A
 LSR A
 LSR A
 CLC
 ADC yLookupLo,Y
 STA SC2
 LDA nameBufferHi
 ADC yLookupHi,Y
 STA SC2+1
 TYA
 AND #7
 TAY
 TXA
 AND #&F8
 STA T
 LDA X2
 AND #&F8
 SEC
 SBC T
 BEQ CE0B4
 LSR A
 LSR A
 LSR A
 STA R

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0
 LDA (SC2,X)
 BNE CE123
 LDA tileNumber
 BEQ CE120
 STA (SC2,X)
 INC tileNumber
 JMP CE163

.CE120

 JMP CE17E

.CE123

 CMP #&3C
 BCS CE163
 CMP #&25
 BCC CE120
 LDX pattBufferHiDiv8
 STX L00BD
 ASL A
 ROL L00BD
 ASL A
 ROL L00BD
 ASL A
 ROL L00BD
 STA L00BC
 LDA tileNumber
 BEQ CE120
 LDX #0
 STA (SC2,X)
 INC tileNumber
 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 STY T
 LDY #7

.loop_CE157

 LDA (L00BC),Y
 STA (SC),Y
 DEY
 BPL loop_CE157
 LDY T
 JMP CE172

.CE163

 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC

.CE172

 LDA XX15
 AND #7
 TAX
 LDA TWFR,X
 EOR (SC),Y
 STA (SC),Y

.CE17E

 INC SC2
 BNE CE184
 INC SC2+1

.CE184

 LDX R
 DEX
 BNE CE18C
 JMP CE22B

.CE18C

 STX R

\ ******************************************************************************
\
\       Name: subm_E18E
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_E18E

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0
 LDA (SC2,X)
 BEQ CE1C7
 CMP #&3C
 BCC CE1E4
 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 LDA #&FF
 EOR (SC),Y
 STA (SC),Y

.CE1BA

 INC SC2
 BNE CE1C0
 INC SC2+1

.CE1C0

 DEC R
 BNE subm_E18E
 JMP CE22B

.CE1C7

 TYA
 CLC
 ADC #&25
 STA (SC2,X)
 JMP CE1BA

.loop_CE1D0

 TYA
 EOR #&FF
 ADC #&33
 STA (SC2,X)
 INC SC2
 BNE CE1DD
 INC SC2+1

.CE1DD

 DEC R
 BNE subm_E18E
 JMP CE22B

.CE1E4

 STA SC
 TYA
 ADC SC
 CMP #&32
 BEQ loop_CE1D0
 LDA tileNumber
 BEQ CE1BA
 INC tileNumber
 STA (SC2,X)
 LDX pattBufferHiDiv8
 STX L00BD
 ASL A
 ROL L00BD
 ASL A
 ROL L00BD
 ASL A
 ROL L00BD
 STA L00BC
 LDA SC
 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 STY T
 LDY #7

.loop_CE219

 LDA (SC),Y
 STA (L00BC),Y
 DEY
 BPL loop_CE219
 LDY T
 LDA #&FF
 EOR (L00BC),Y
 STA (L00BC),Y
 JMP CE1BA

.CE22B

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0
 LDA (SC2,X)
 BNE CE24C
 LDA tileNumber
 BEQ CE249
 STA (SC2,X)
 INC tileNumber
 JMP CE28C

.CE249

 JMP CE32E

.CE24C

 CMP #&3C
 BCS CE28C
 CMP #&25
 BCC CE249
 LDX pattBufferHiDiv8
 STX L00BD
 ASL A
 ROL L00BD
 ASL A
 ROL L00BD
 ASL A
 ROL L00BD
 STA L00BC
 LDA tileNumber
 BEQ CE249
 LDX #0
 STA (SC2,X)
 INC tileNumber
 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 STY T
 LDY #7

.loop_CE280

 LDA (L00BC),Y
 STA (SC),Y
 DEY
 BPL loop_CE280
 LDY T
 JMP CE29B

.CE28C

 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC

.CE29B

 LDA X2
 AND #7
 TAX
 LDA TWFL,X
 JMP CE32A

.CE2A6

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0
 LDA (SC2,X)
 BNE CE2C7
 LDA tileNumber
 BEQ CE2C4
 STA (SC2,X)
 INC tileNumber
 JMP CE307

.CE2C4

 JMP CE32E

.CE2C7

 CMP #&3C
 BCS CE307
 CMP #&25
 BCC CE2C4
 LDX pattBufferHiDiv8
 STX L00BD
 ASL A
 ROL L00BD
 ASL A
 ROL L00BD
 ASL A
 ROL L00BD
 STA L00BC
 LDA tileNumber
 BEQ CE2C4
 LDX #0
 STA (SC2,X)
 INC tileNumber
 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 STY T
 LDY #7

.loop_CE2FB

 LDA (L00BC),Y
 STA (SC),Y
 DEY
 BPL loop_CE2FB
 LDY T
 JMP CE316

.CE307

 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC

.CE316

 LDA XX15
 AND #7
 TAX
 LDA TWFR,X
 STA T
 LDA X2
 AND #7
 TAX
 LDA TWFL,X
 AND T

.CE32A

 EOR (SC),Y
 STA (SC),Y

.CE32E

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDY YSAV
 RTS

\ ******************************************************************************
\
\       Name: subm_E33E
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_E33E

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 STY YSAV
 LDY Y1
 CPY Y2
 BEQ CE391
 BCC CE35C
 LDA Y2
 STA Y1
 STY Y2
 TAY

.CE35C

 LDA XX15
 LSR A
 LSR A
 LSR A
 CLC
 ADC yLookupLo,Y
 STA SC2
 LDA nameBufferHi
 ADC yLookupHi,Y
 STA SC2+1
 LDA XX15
 AND #7
 STA S
 LDA Y2
 SEC
 SBC Y1
 STA R
 TYA
 AND #7
 TAY
 BNE CE394
 JMP CE43D

.CE384

 STY T
 LDA R
 ADC T
 SBC #7
 BCC CE391
 JMP CE423

.CE391

 LDY YSAV
 RTS

.CE394

 STY Q

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0
 LDA (SC2,X)
 BNE CE3B7
 LDA tileNumber
 BEQ CE3B4
 STA (SC2,X)
 INC tileNumber
 JMP CE3F7

.CE3B4

 JMP CE384

.CE3B7

 CMP #&3C
 BCS CE3F7
 CMP #&25
 BCC CE3B4
 LDX pattBufferHiDiv8
 STX L00BD
 ASL A
 ROL L00BD
 ASL A
 ROL L00BD
 ASL A
 ROL L00BD
 STA L00BC
 LDA tileNumber
 BEQ CE3B4
 LDX #0
 STA (SC2,X)
 INC tileNumber
 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 STY T
 LDY #7

.loop_CE3EB

 LDA (L00BC),Y
 STA (SC),Y
 DEY
 BPL loop_CE3EB
 LDY T
 JMP CE406

.CE3F7

 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC

.CE406

 LDX S
 LDY Q
 LDA R
 BEQ CE420

.loop_CE40E

 LDA (SC),Y
 ORA TWOS,X
 STA (SC),Y
 DEC R
 BEQ CE420
 INY
 CPY #8
 BCC loop_CE40E
 BCS CE423

.CE420

 LDY YSAV
 RTS

.CE423

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDY #0
 LDA SC2
 CLC
 ADC #&20
 STA SC2
 BCC CE43D
 INC SC2+1

.CE43D

 LDA R
 BEQ CE420
 SEC
 SBC #8
 BCS CE449
 JMP CE394

.CE449

 STA R
 LDX #0
 LDA (SC2,X)
 BEQ CE4AA
 CMP #&3C
 BCC CE4B4
 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 LDX S
 LDY #0
 LDA (SC),Y
 ORA TWOS,X
 STA (SC),Y
 INY
 LDA (SC),Y
 ORA TWOS,X
 STA (SC),Y
 INY
 LDA (SC),Y
 ORA TWOS,X
 STA (SC),Y
 INY
 LDA (SC),Y
 ORA TWOS,X
 STA (SC),Y
 INY
 LDA (SC),Y
 ORA TWOS,X
 STA (SC),Y
 INY
 LDA (SC),Y
 ORA TWOS,X
 STA (SC),Y
 INY
 LDA (SC),Y
 ORA TWOS,X
 STA (SC),Y
 INY
 LDA (SC),Y
 ORA TWOS,X
 STA (SC),Y
 JMP CE423

.CE4AA

 LDA S
 CLC
 ADC #&34
 STA (SC2,X)

.CE4B1

 JMP CE423

.CE4B4

 STA SC
 LDA tileNumber
 BEQ CE4B1
 INC tileNumber
 STA (SC2,X)
 LDX pattBufferHiDiv8
 STX L00BD
 ASL A
 ROL L00BD
 ASL A
 ROL L00BD
 ASL A
 ROL L00BD
 STA L00BC
 LDA SC
 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 STY T
 LDY #7
 LDX S

.loop_CE4E4

 LDA (SC),Y
 ORA TWOS,X
 STA (L00BC),Y
 DEY
 BPL loop_CE4E4
 BMI CE4B1

\ ******************************************************************************
\
\       Name: PIXEL
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.PIXEL

 STX SC2
 STY T1
 TAY
 TXA
 LSR A
 LSR A
 LSR A
 CLC
 ADC yLookupLo,Y
 STA SC
 LDA nameBufferHi
 ADC yLookupHi,Y
 STA SC+1

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0
 LDA (SC,X)
 BNE CE521
 LDA tileNumber
 BEQ CE540
 STA (SC,X)
 INC tileNumber

.CE521

 LDX pattBufferHiDiv8
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 TYA
 AND #7
 TAY
 LDA SC2
 AND #7
 TAX
 LDA TWOS,X
 ORA (SC),Y
 STA (SC),Y

.CE540

 LDY T1
 RTS

\ ******************************************************************************
\
\       Name: DrawDash
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.DrawDash

 STX SC2
 STY T1
 TAY
 TXA
 LSR A
 LSR A
 LSR A
 CLC
 ADC yLookupLo,Y
 STA SC
 LDA nameBufferHi
 ADC yLookupHi,Y
 STA SC+1

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0
 LDA (SC,X)
 BNE CE574
 LDA tileNumber
 BEQ CE540
 STA (SC,X)
 INC tileNumber

.CE574

 LDX #&0C
 STX SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC
 TYA
 AND #7
 TAY
 LDA SC2
 AND #7
 TAX
 LDA TWOS2,X
 ORA (SC),Y
 STA (SC),Y
 LDY T1
 RTS

\ ******************************************************************************
\
\       Name: ECBLB2
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.ECBLB2

 LDA #&20
 STA ECMA
 LDY #2
 JMP NOISE

\ ******************************************************************************
\
\       Name: MSBAR
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.MSBAR

 TYA
 PHA
 LDY LE5AB,X
 PLA
 STA nameBuffer0+22*32,Y
 LDY #0
 RTS

\ ******************************************************************************
\
\       Name: LE5AB
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.LE5AB

 EQUB &00, &5F, &5E, &3F, &3E                 ; E5AB: 00 5F 5E... ._^

\ ******************************************************************************
\
\       Name: LE5B0_EN
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.LE5B0_EN

IF _NTSC

 EQUB &9F, &C2, &00, &75, &05, &8A, &40, &04  ; E5B0: 9F C2 00... ...

ELIF _PAL

 EQUB &9F, &C2, &00, &76, &05, &8A, &40, &04  ; E5B0: 9F C2 00... ...

ENDIF

 EQUB &83, &C2, &00, &6E, &03, &9C, &04, &14  ; E5B8: 83 C2 00... ...
 EQUB &44, &06, &40, &1F, &40, &1F, &21, &0E  ; E5C0: 44 06 40... D.@
 EQUB &83, &10, &03, &88, &8D, &01, &1F, &01  ; E5C8: 83 10 03... ...
 EQUB &15, &08, &14, &8E, &08, &1F, &08, &14  ; E5D0: 15 08 14... ...
 EQUB &08, &14, &21, &02, &83, &C3, &08, &01  ; E5D8: 08 14 21... ..!
 EQUB &04, &10, &03, &88, &9F, &9F, &22, &16  ; E5E0: 04 10 03... ...
 EQUB &83, &10, &03, &88, &21, &12, &83, &01  ; E5E8: 83 10 03... ...
 EQUB &08, &04, &1F, &10, &03, &88, &21, &02  ; E5F0: 08 04 1F... ...
 EQUB &83, &04, &13, &24, &11, &C3, &00, &01  ; E5F8: 83 04 13... ...
 EQUB &04, &C0                                ; E600: 04 C0       ..

\ ******************************************************************************
\
\       Name: LE602_DE
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.LE602_DE

IF _NTSC

 EQUB &9F, &C2, &00, &75, &05, &8A, &40, &04  ; E602: 9F C2 00... ...

ELIF _PAL

 EQUB &9F, &C2, &00, &76, &05, &8A, &40, &04  ; E602: 9F C2 00... ...

ENDIF

 EQUB &83, &C2, &00, &6E, &03, &9C, &04, &14  ; E60A: 83 C2 00... ...
 EQUB &44, &06, &40, &1F, &40, &1F, &21, &0E  ; E612: 44 06 40... D.@
 EQUB &83, &10, &03, &88, &8D, &01, &1F, &01  ; E61A: 83 10 03... ...
 EQUB &13, &08, &14, &8E, &08, &1F, &08, &1F  ; E622: 13 08 14... ...
 EQUB &08, &16, &21, &02, &83, &C3, &08, &01  ; E62A: 08 16 21... ..!
 EQUB &04, &10, &03, &88, &9F, &22, &16, &83  ; E632: 04 10 03... ...
 EQUB &10, &03, &88, &21, &12, &83, &10, &03  ; E63A: 10 03 88... ...
 EQUB &88, &21, &02, &83, &01, &0C, &04, &1F  ; E642: 88 21 02... .!.
 EQUB &04, &1E, &24, &16, &C3, &00, &01, &04  ; E64A: 04 1E 24... ..$
 EQUB &C0                                     ; E652: C0          .

\ ******************************************************************************
\
\       Name: LE653_FR
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.LE653_FR

IF _NTSC

 EQUB &9F, &C2, &00, &75, &05, &8A, &40, &04  ; E653: 9F C2 00... ...

ELIF _PAL

 EQUB &9F, &C2, &00, &76, &05, &8A, &40, &04  ; E653: 9F C2 00... ...

ENDIF

 EQUB &83, &C2, &00, &6E, &03, &9C, &04, &14  ; E65B: 83 C2 00... ...
 EQUB &44, &06, &40, &1F, &40, &1F, &21, &0E  ; E663: 44 06 40... D.@
 EQUB &83, &10, &03, &88, &8D, &01, &1F, &01  ; E66B: 83 10 03... ...
 EQUB &15, &08, &14, &8E, &08, &1F, &08, &1F  ; E673: 15 08 14... ...
 EQUB &08, &14, &21, &02, &83, &C3, &08, &01  ; E67B: 08 14 21... ..!
 EQUB &04, &10, &03, &88, &9F, &98, &22, &16  ; E683: 04 10 03... ...
 EQUB &83, &10, &03, &88, &21, &12, &83, &10  ; E68B: 83 10 03... ...
 EQUB &03, &88, &21, &02, &83, &01, &0E, &04  ; E693: 03 88 21... ..!
 EQUB &1F, &24, &11, &04, &1C, &C3, &00, &01  ; E69B: 1F 24 11... .$.
 EQUB &04                                     ; E6A3: 04          .

\ ******************************************************************************
\
\       Name: LE6A4_subm_E802
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.LE6A4_subm_E802

 EQUB &89, &10, &03, &88, &28, &19, &C2, &00  ; E6A4: 89 10 03... ...
 EQUB &A5, &00, &9F, &9F, &22, &16, &83, &10  ; E6AC: A5 00 9F... ...
 EQUB &03, &88, &9F, &04, &04, &83, &40, &04  ; E6B4: 03 88 9F... ...
 EQUB &83, &9F, &22, &12, &83, &10, &03, &88  ; E6BC: 83 9F 22... .."
 EQUB &9F, &01, &04, &83, &01, &04, &83, &01  ; E6C4: 9F 01 04... ...
 EQUB &04, &83, &01, &04, &83, &01, &04, &83  ; E6CC: 04 83 01... ...
 EQUB &01, &04, &83, &01, &04, &83, &01, &04  ; E6D4: 01 04 83... ...
 EQUB &83, &04, &04, &83, &01, &04, &83, &04  ; E6DC: 83 04 04... ...
 EQUB &04, &83, &04, &04, &83, &04, &04, &83  ; E6E4: 04 83 04... ...
 EQUB &04, &04, &83, &04, &04, &83, &04, &04  ; E6EC: 04 04 83... ...
 EQUB &83, &04, &04, &83, &04, &04, &83, &04  ; E6F4: 83 04 04... ...
 EQUB &04, &83, &04, &04, &83, &04, &04, &83  ; E6FC: 04 83 04... ...
 EQUB &04, &04, &83, &04, &04, &83, &04, &04  ; E704: 04 04 83... ...
 EQUB &83, &01, &04, &83, &9F, &10, &03, &88  ; E70C: 83 01 04... ...
 EQUB &9F, &9F, &22, &02, &83, &10, &03, &88  ; E714: 9F 9F 22... .."
 EQUB &9F, &9F, &9F, &9F, &21, &16, &83, &10  ; E71C: 9F 9F 9F... ...
 EQUB &03, &88, &9F, &08, &1E, &9F, &22, &02  ; E724: 03 88 9F... ...
 EQUB &83, &10, &03, &88, &9F, &10, &03, &88  ; E72C: 83 10 03... ...
 EQUB &9F, &9F, &9F, &10, &03, &88, &9F, &01  ; E734: 9F 9F 9F... ...
 EQUB &1F, &05, &1F, &01, &05, &9F, &10, &03  ; E73C: 1F 05 1F... ...
 EQUB &88, &9F, &9F, &9F, &10, &03, &88, &22  ; E744: 88 9F 9F... ...
 EQUB &02, &83, &9F, &10, &03, &88, &9F, &9F  ; E74C: 02 83 9F... ...
 EQUB &10, &03, &88, &9F, &21, &1A, &83, &10  ; E754: 10 03 88... ...
 EQUB &03, &88, &96, &22, &12, &83, &10, &03  ; E75C: 03 88 96... ...
 EQUB &88, &C4, &00, &6B, &03, &02, &16, &04  ; E764: 88 C4 00... ...
 EQUB &1E, &21, &22, &83, &10, &03, &88, &10  ; E76C: 1E 21 22... .!"
 EQUB &03, &88, &10, &03, &88, &10, &03, &88  ; E774: 03 88 10... ...

IF _NTSC

 EQUB &C2, &00, &64, &05, &22, &3A, &83, &10  ; E77C: C2 00 64... ..d

ELIF _PAL

 EQUB &C2, &00, &65, &05, &22, &3A, &83, &10  ; E77C: C2 00 64... ..d

ENDIF

 EQUB &03, &88, &C2, &00, &A5, &00, &9F, &21  ; E784: 03 88 C2... ...
 EQUB &02, &83, &10, &03, &88, &9F, &02, &04  ; E78C: 02 83 10... ...
 EQUB &83, &02, &04, &83, &02, &04, &83, &02  ; E794: 83 02 04... ...
 EQUB &04, &83, &02, &04, &83, &02, &04, &83  ; E79C: 04 83 02... ...
 EQUB &02, &04, &83, &02, &04, &83, &04, &04  ; E7A4: 02 04 83... ...
 EQUB &83, &02, &04, &83, &21, &12, &83, &10  ; E7AC: 83 02 04... ...
 EQUB &03, &88, &9F, &40, &1F, &40, &1F, &40  ; E7B4: 03 88 9F... ...
 EQUB &1F, &40, &1F, &22, &36, &83, &10, &03  ; E7BC: 1F 40 1F... .@.
 EQUB &88, &9F, &9F, &08, &1F, &08, &1F, &28  ; E7C4: 88 9F 9F... ...
 EQUB &0A, &83, &21, &0E, &83, &10, &03, &88  ; E7CC: 0A 83 21... ..!
 EQUB &9F, &9F, &21, &0E, &83, &10, &03, &88  ; E7D4: 9F 9F 21... ..!
 EQUB &9F, &21, &12, &83, &24, &1F, &08, &1F  ; E7DC: 9F 21 12... .!.
 EQUB &08, &1F, &83, &10, &03, &88, &C3, &08  ; E7E4: 08 1F 83... ...
 EQUB &01, &04, &9F, &21, &02, &83, &10, &03  ; E7EC: 01 04 9F... ...
 EQUB &88, &22, &1E, &83, &28, &0A, &C3, &00  ; E7F4: 88 22 1E... .".

IF _NTSC

 EQUB &86, &04, &10, &03, &88, &80            ; E7FC: 86 04 10... ...

ELIF _PAL

 EQUB &87, &04, &10, &03, &88, &80            ; E7FC: 86 04 10... ...

ENDIF

\ ******************************************************************************
\
\       Name: subm_E802
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_E802

 LDA controller1A
 ORA controller1B
 ORA controller1Left
 ORA controller1Right
 ORA controller1Up
 ORA controller1Down
 ORA controller1Start
 ORA controller1Select
 BPL CE822
 LDA #0
 STA L03EE
 RTS

.CE822

 LDX L04BD
 BNE CE83F
 LDY #0
 LDA (addr2),Y
 BMI CE878
 STA L04BC
 INY
 LDA (addr2),Y
 SEC
 TAX

.CE835

 LDA #1

.CE837

 ADC addr2
 STA addr2
 BCC CE83F
 INC addr2+1

.CE83F

 DEX
 STX L04BD
 LDA L04BC
 ASL controller1Right
 LSR A
 ROR controller1Right
 ASL controller1Left
 LSR A
 ROR controller1Left
 ASL controller1Down
 LSR A
 ROR controller1Down
 ASL controller1Up
 LSR A
 ROR controller1Up
 ASL controller1Select
 LSR A
 ROR controller1Select
 ASL controller1B
 LSR A
 ROR controller1B
 ASL controller1A
 LSR A
 ROR controller1A
 RTS

.CE878

 ASL A
 BEQ CE8DA
 BMI CE886
 ASL A
 TAX

.CE87F

 LDA #0
 STA L04BC
 BEQ CE835

.CE886

 ASL A
 BEQ CE8D1
 PHA
 INY
 LDA (addr2),Y
 STA L04BC
 INY
 LDA (addr2),Y
 STA addr4
 INY
 LDA (addr2),Y
 STA addr4+1
 LDY #0
 LDX #1
 PLA
 CMP #8
 BCS CE8AC
 LDA (addr4),Y
 BNE CE83F

.CE8A7

 LDA #4
 CLC
 BCC CE837

.CE8AC

 BNE CE8B4
 LDA (addr4),Y
 BEQ CE83F
 BNE CE8A7

.CE8B4

 CMP #&10
 BCS CE8BE
 LDA (addr4),Y
 BMI CE83F
 BPL CE8A7

.CE8BE

 BNE CE8C7
 LDA (addr4),Y
 BMI CE8A7
 JMP CE83F

.CE8C7

 LDA #&C0
 STA controller1Start
 LDX #&16
 CLC
 BCC CE87F

.CE8D1

 LDA #&E6
 STA addr2+1
 LDA #&A4
 STA addr2
 RTS

.CE8DA

 STA L03EE
 RTS

\ ******************************************************************************
\
\       Name: subm_E8DE
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_E8DE

 LDA controller1Start
 AND #&C0
 CMP #&40
 BNE CE8EE
 LDA #&50
 STA L0465
 BNE CE8FA

.CE8EE

 LDA L0465
 CMP #&50
 BEQ CE8FA

.CE8F5

 LDA #0
 STA L0465

.CE8FA

 LDA #&F0
 STA ySprite1
 STA ySprite2
 STA ySprite3
 STA ySprite4
 RTS

\ ******************************************************************************
\
\       Name: subm_E909
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_E909

 ASL A
 ASL A
 STA L0460
 LDX #0

 STX L0463
 STX L0462
 STX L0468
 STX L0467

IF _PAL

 STX PAL_EXTRA

ENDIF

 RTS

\ ******************************************************************************
\
\       Name: MoveIconBarPointer
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.MoveIconBarPointer

IF _NTSC

 DEC L0467

ELIF _PAL

 DEC &0468
 BNE CE928
 LSR &045F

.CE928

ENDIF

 BPL CE925
 INC L0467

.CE925

 DEC L0463
 BPL CE92D
 INC L0463

.CE92D

 LDA L0473
 BMI CE8F5
 LDA L045F
 BEQ subm_E8DE
 LDA L0462
 CLC
 ADC L0460
 STA L0460
 AND #3
 BNE CE98D
 LDA #0
 STA L0462
 LDA L0463
 BNE CE98D
 LDA controller1B
 ORA scanController2
 BPL CE98D
 LDX controller1Left
 BMI CE964
 LDA #0
 STA controller1Left
 JMP CE972

.CE964

 LDA #&FF
 CPX #&80
 BNE CE96F
 LDX #&0C
 STX L0463

.CE96F

 STA L0462

.CE972

 LDX controller1Right
 BMI CE97F
 LDA #0
 STA controller1Right
 JMP CE98D

.CE97F

 LDA #1
 CPX #&80
 BNE CE98A
 LDX #&0C
 STX L0463

.CE98A

 STA L0462

.CE98D

 LDA L0460
 BPL CE999
 LDA #0
 STA L0462
 BEQ CE9A4

.CE999

 CMP #&2D
 BCC CE9A4
 LDA #0
 STA L0462
 LDA #&2C

.CE9A4

 STA L0460
 LDA L0460
 AND #3
 ORA L0462
 BNE CEA04
 LDA controller1B
 BMI CEA04
 LDA controller1B
 BMI CEA04
 LDA controller1Select
 BNE CEA04
 LDA #&FB
 STA tileSprite1
 STA tileSprite2
 LDA L0461
 CLC

IF _NTSC

 ADC #&0B

ELIF _PAL

 ADC #&11

ENDIF

 STA ySprite1
 STA ySprite2
 LDA L0460
 ASL A
 ASL A
 ADC L0460
 ADC #6
 STA xSprite4
 ADC #1
 STA xSprite1
 ADC #&0D
 STA xSprite2
 ADC #1
 STA xSprite3
 LDA L0461
 CLC

IF _NTSC

 ADC #&13

ELIF _PAL

 ADC #&19

ENDIF

 STA ySprite4
 STA ySprite3
 LDA L0460
 BNE CEA40
 JMP CEA40

.CEA04

 LDA #&FC
 STA tileSprite1
 STA tileSprite2
 LDA L0461
 CLC

IF _NTSC

 ADC #8

ELIF _PAL

 ADC #&E

ENDIF

 STA ySprite1
 STA ySprite2
 LDA L0460
 ASL A
 ASL A
 ADC L0460
 ADC #6
 STA xSprite4
 ADC #1
 STA xSprite1
 ADC #&0D
 STA xSprite2
 ADC #1
 STA xSprite3
 LDA L0461
 CLC

IF _NTSC

 ADC #&10

ELIF _PAL

 ADC #&16

ENDIF

 STA ySprite4
 STA ySprite3

.CEA40

 LDA controller1Left
 ORA controller1Right
 ORA controller1Up
 ORA controller1Down
 BPL CEA53
 LDA #0
 STA L0468

.CEA53

 LDA controller1Select
 AND #&F0
 CMP #&80
 BEQ CEA73
 LDA controller1B
 AND #&C0
 CMP #&80
 BNE CEA6A
 LDA #&1E
 STA L0468

.CEA6A

 CMP #&40
 BNE CEA7E

IF _NTSC

 LDA L0468
 BEQ CEA7E

.CEA73

 LDA L0460
 LSR A
 LSR A
 TAY
 LDA (L00BE),Y
 STA L0465

ELIF _PAL

 LDA &0469
 BNE CEA80
 STA &045F
 BEQ CEA7E

.CEA80

 LDA #&28
 STA &0468
 LDA &045F
 BNE CEA73
 INC &045F
 BNE CEA7E

.CEA73

 LSR &045F
 LDA &0461
 LSR A
 LSR A
 TAY
 LDA (&BE),Y
 STA &0466

ENDIF

.CEA7E

 LDA controller1Start
 AND #&C0
 CMP #&40
 BNE CEA8C
 LDA #&50
 STA L0465

.CEA8C

 RTS

\ ******************************************************************************
\
\       Name: subm_EA8D
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_EA8D

 LDA controller1B
 BNE CEAA7
 LDA controller1Left
 ASL A
 ASL A
 ASL A
 ASL A
 STA L04BA
 LDA controller1Right
 ASL A
 ASL A
 ASL A
 ASL A
 STA L04BB
 RTS

.CEAA7

 LDA #0
 STA L04BA
 STA L04BB
 RTS

\ ******************************************************************************
\
\       Name: UpdateJoystick
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.UpdateJoystick

 LDA QQ11a
 BNE subm_EA8D
 LDX JSTX
 LDA #8
 STA addr4
 LDY scanController2
 BNE CEAC5
 LDA controller1B
 BMI CEB0C

.CEAC5

 LDA controller1Right,Y
 BPL CEACD
 JSR subm_EB19

.CEACD

 LDA controller1Left,Y
 BPL CEAD5
 JSR subm_EB0D

.CEAD5

 STX JSTX
 TYA
 BNE CEADB

.CEADB

 LDA #4
 STA addr4
 LDX JSTY
 LDA L03EB
 BMI CEAFB
 LDA controller1Down,Y
 BPL CEAEF
 JSR subm_EB19

.CEAEF

 LDA controller1Up,Y
 BPL CEAF7

.loop_CEAF4

 JSR subm_EB0D

.CEAF7

 STX JSTY
 RTS

.CEAFB

 LDA controller1Up,Y
 BPL CEB03
 JSR subm_EB19

.CEB03

 LDA controller1Down,Y
 BMI loop_CEAF4
 STX JSTY
 RTS

.CEB0C

 RTS

\ ******************************************************************************
\
\       Name: subm_EB0D
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_EB0D

 TXA
 CLC
 ADC addr4
 TAX
 BCC CEB16
 LDX #&FF

.CEB16

 BPL CEB24
 RTS

\ ******************************************************************************
\
\       Name: subm_EB19
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_EB19

 TXA
 SEC
 SBC addr4
 TAX
 BCS CEB22
 LDX #1

.CEB22

 BPL CEB26

.CEB24

 LDX #&80

.CEB26

 RTS

\ ******************************************************************************
\
\       Name: LEB27
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

 EQUB &01, &02, &03, &04, &05, &06, &07, &23  ; EB27: 01 02 03... ...
 EQUB &08, &00, &00, &0C, &00, &00, &00, &00  ; EB2F: 08 00 00... ...
 EQUB &11, &02, &03, &04, &15, &16, &17, &18  ; EB37: 11 02 03... ...
 EQUB &19, &1A, &1B, &0C, &00, &00, &00, &00  ; EB3F: 19 1A 1B... ...
 EQUB &01, &02, &24, &23, &15, &26, &27, &16  ; EB47: 01 02 24... ..$
 EQUB &29, &17, &1B, &0C, &00, &00, &00, &00  ; EB4F: 29 17 1B... )..
 EQUB &31, &32, &33, &34, &35, &00, &00, &00  ; EB57: 31 32 33... 123
 EQUB &00, &00, &00, &3C, &00, &00, &00, &00  ; EB5F: 00 00 00... ...

\ ******************************************************************************
\
\       Name: HideStardust
\       Type: Subroutine
\   Category: Stardust
\    Summary: ???
\
\ ******************************************************************************

.HideStardust

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX NOSTM
 LDY #152

\ ******************************************************************************
\
\       Name: HideSprites1
\       Type: Subroutine
\   Category: ???
\    Summary: Hide X+1 sprites from sprite Y/4 onwards
\
\ ******************************************************************************

.HideSprites1

 LDA #240

.loop_CEB7B

 STA ySprite0,Y
 INY
 INY
 INY
 INY
 DEX
 BPL loop_CEB7B
 RTS

\ ******************************************************************************
\
\       Name: subm_EB86
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_EB86

 LDA QQ11a
 CMP QQ11
 BEQ subm_EB8F

\ ******************************************************************************
\
\       Name: subm_EB8C
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_EB8C

 JSR subm_B63D_b3

\ ******************************************************************************
\
\       Name: subm_EB8F
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_EB8F

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #58

 LDY #20

 BNE HideSprites1

\ ******************************************************************************
\
\       Name: DELAY
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.DELAY

 JSR KeepPPUTablesAt0
 DEY
 BNE DELAY
 RTS

\ ******************************************************************************
\
\       Name: BEEP
\       Type: Subroutine
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.BEEP

 LDY #3
 BNE NOISE

\ ******************************************************************************
\
\       Name: EXNO3
\       Type: Subroutine
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.EXNO3

 LDY #&0D
 BNE NOISE

\ ******************************************************************************
\
\       Name: subm_EBB1
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_EBB1

 LDX #0
 JSR CEBCF

.loop_CEBB6

 LDX #1
 JSR CEBCF
 LDX #2
 BNE CEBCF

\ ******************************************************************************
\
\       Name: ECBLB
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.ECBLB

 LDX noiseLookup1,Y
 CPX #3
 BCC CEBCF
 BNE loop_CEBB6
 LDX #0
 JSR CEBCF
 LDX #2

.CEBCF

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA #0
 STA L0478,X
 LDA #&1A
 BNE CEC2B

\ ******************************************************************************
\
\       Name: BOOP
\       Type: Subroutine
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.BOOP

 LDY #4
 BNE NOISE

\ ******************************************************************************
\
\       Name: subm_EBE9
\       Type: Subroutine
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.subm_EBE9

 LDY #1
 BNE NOISE

\ ******************************************************************************
\
\       Name: subm_EBED
\       Type: Subroutine
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.subm_EBED

 JSR subm_EBB1
 LDY #&15

\ ******************************************************************************
\
\       Name: NOISE
\       Type: Subroutine
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.NOISE

 LDA L03EC
 BPL CEC2E
 LDX noiseLookup1,Y
 CPX #3
 BCC CEC0A
 TYA
 PHA
 DEX
 DEX
 DEX
 JSR CEC0A
 PLA
 TAY
 LDX #2

.CEC0A

 LDA L0302,X
 BEQ CEC17
 LDA noiseLookup2,Y
 CMP L0478,X
 BCC CEC2E

.CEC17

 LDA noiseLookup2,Y
 STA L0478,X

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 TYA

.CEC2B

 JSR subm_89D1_b6

.CEC2E

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 RTS

\ ******************************************************************************
\
\       Name: noiseLookup1
\       Type: Variable
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.noiseLookup1

 EQUB 2, 1, 1, 1, 1, 0, 0, 1, 2, 2, 2, 2, 3   ; EC3C: 02 01 01... ...
 EQUB 2, 2, 0, 0, 0, 0, 0, 2, 3, 3, 2, 1, 2   ; EC49: 02 02 00... ...
 EQUB 0, 2, 0, 1, 0, 0                        ; EC56: 00 02 00... ...

\ ******************************************************************************
\
\       Name: noiseLookup2
\       Type: Variable
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.noiseLookup2

 EQUB &80, &82, &C0, &21, &21, &10, &10, &41  ; EC5C: 80 82 C0... ...
 EQUB &82, &32, &84, &20, &C0, &60, &40, &80  ; EC64: 82 32 84... .2.
 EQUB &80, &80, &80, &90, &84, &33, &33, &20  ; EC6C: 80 80 80... ...
 EQUB &C0, &18, &10, &10, &10, &10, &10, &60  ; EC74: C0 18 10... ...
 EQUB &60                                     ; EC7C: 60          `

\ ******************************************************************************
\
\       Name: SetupPPUForIconBar
\       Type: Subroutine
\   Category: Screen mode
\    Summary: If the PPU has started drawing the icon bar, configure the PPU to
\             use nametable 0 and pattern table 0, while preserving A
\
\ ******************************************************************************

.SetupPPUForIconBar

 PHA                    \ Store the value of A on the stack so we can retrieve
                        \ it below

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 PLA                    \ Retrieve the value of A from the stack so it is
                        \ unchanged

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: GetShipBlueprint
\       Type: Subroutine
\   Category: Drawing ships
\    Summary: Fetch a specified byte from the current ship blueprint
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   Y                   The offset of the byte to return from the blueprint
\
\ Returns:
\
\   A                   The Y-th byte of the current ship blueprint
\
\ ******************************************************************************

.GetShipBlueprint

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 LDA (XX0),Y            \ Set A to the Y-th byte of the current ship blueprint

                        \ Fall through into ResetBankA to retrieve the bank
                        \ number we stored above and page it back into memory

\ ******************************************************************************
\
\       Name: ResetBankA
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Page a specified bank into memory at &8000 while preserving the
\             value of A
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   Stack               The number of the bank to page into memory at &8000
\
\ ******************************************************************************

.ResetBankA

 STA ASAV               \ Store the value of A so we can retrieve it below

 PLA                    \ Fetch the ROM bank number from the stack

 JSR SetBank            \ Page bank A into memory at &8000

 LDA ASAV               \ Restore the value of A that we stored above

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: GetDefaultNEWB
\       Type: Subroutine
\   Category: Drawing ships
\    Summary: Fetch the default NEWB flags for a specified ship type
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   Y                   The ship type
\
\ Returns:
\
\   A                   The default NEWB flags for ship type Y
\
\ ******************************************************************************

.GetDefaultNEWB

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 LDA E%-1,Y             \ Set A to the default NEWB flags for ship type Y

 JMP ResetBankA         \ Jump to ResetBankA to retrieve the bank number we
                        \ stored above and page it back into memory, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: IncreaseTally
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.IncreaseTally

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 LDA KWL%-1,X
 ASL A
 PHA
 LDA KWH%-1,X
 ROL A
 TAY
 PLA
 ADC TALLYL
 STA TALLYL
 TYA
 ADC TALLY
 STA TALLY

\ ******************************************************************************
\
\       Name: ResetBankP
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Page a specified bank into memory at &8000 while preserving the
\             value of A and the processor flags
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   Stack               The number of the bank to page into memory at &8000
\
\ ******************************************************************************

.ResetBankP

 PLA                    \ Fetch the ROM bank number from the stack

 PHP                    \ Store the processor flags on the stack so we can
                        \ retrieve them below

 JSR SetBank            \ Page bank A into memory at &8000

 PLP                    \ Restore the processor flags, so we return the correct
                        \ Z and N flags for the value of A

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: subm_ECE2
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ------------------------------------------------------------------------------
\
\ Other entry points:
\
\   subm_ECE2-1         Contains an RTS
\
\ ******************************************************************************

.subm_ECE2

 LDA L0465
 BEQ subm_ECE2-1

\ ******************************************************************************
\
\       Name: subm_B1D4_b0
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B1D4 routine in ROM bank 0
\
\ ------------------------------------------------------------------------------
\
\ Returns:
\
\   N, Z flags          Set according to the value of A passed to the routine
\
\ ******************************************************************************

.subm_B1D4_b0

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR subm_B1D4          \ Call subm_B1D4, now that it is paged into memory

 JMP ResetBankP         \ Jump to ResetBankP to retrieve the bank number we
                        \ stored above, page it back into memory and set the
                        \ processor flags according to the value of A, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: Set_K_K3_XC_YC
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.Set_K_K3_XC_YC

 LDA #2
 STA K
 STA K+1
 LDA #&45
 STA K+2
 LDA #8
 STA K+3
 LDA #3
 STA XC
 LDA #&19
 STA YC
 LDX #7
 LDY #7
 JMP subm_A0F8_b6

\ ******************************************************************************
\
\       Name: PlayMusic_b6
\       Type: Subroutine
\   Category: Sound
\    Summary: Call the PlayMusic routine in ROM bank 6
\
\ ******************************************************************************

.PlayMusic_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR PlayMusic          \ Call PlayMusic, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_8021_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_8021 routine in ROM bank 6
\
\ ******************************************************************************

.subm_8021_b6

 PHA                    \ ???
 JSR KeepPPUTablesAt0
 PLA

 ORA #&80
 STA L045E

 AND #&7F

 LDX L03ED
 BMI subm_ECE2-1

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 6 is already paged into memory, jump to
 CMP #6                 \ bank1
 BEQ bank1

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR subm_8021          \ Call subm_8021, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank1

 LDA ASAV               \ Restore the value of A that we stored above

 JMP subm_8021          \ ???

\ ******************************************************************************
\
\       Name: subm_89D1_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_89D1 routine in ROM bank 6
\
\ ******************************************************************************

.subm_89D1_b6

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 6 is already paged into memory, jump to
 CMP #6                 \ bank2
 BEQ bank2

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR subm_89D1          \ Call subm_89D1, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank2

 LDA ASAV               \ Restore the value of A that we stored above

 JMP subm_89D1          \ ???

\ ******************************************************************************
\
\       Name: WaitResetSound
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.WaitResetSound

 JSR KeepPPUTablesAt0

\ ******************************************************************************
\
\       Name: ResetSoundL045E
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.ResetSoundL045E

 LDA #0
 STA L045E

\ ******************************************************************************
\
\       Name: ResetSound_b6
\       Type: Subroutine
\   Category: Sound
\    Summary: Call the ResetSound routine in ROM bank 6
\
\ ******************************************************************************

.ResetSound_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR ResetSound         \ Call ResetSound, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_BF41_b5
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_BF41 routine in ROM bank 5
\
\ ******************************************************************************

.subm_BF41_b5

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #5                 \ Page ROM bank 5 into memory at &8000
 JSR SetBank

 JSR subm_BF41          \ Call subm_BF41, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B9F9_b4
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B9F9 routine in ROM bank 4
\
\ ******************************************************************************

.subm_B9F9_b4

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #4                 \ Page ROM bank 4 into memory at &8000
 JSR SetBank

 JSR subm_B9F9          \ Call subm_B9F9, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B96B_b4
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B96B routine in ROM bank 4
\
\ ******************************************************************************

.subm_B96B_b4

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #4                 \ Page ROM bank 4 into memory at &8000
 JSR SetBank

 JSR subm_B96B          \ Call subm_B96B, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B63D_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B63D routine in ROM bank 3
\
\ ******************************************************************************

.subm_B63D_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_B63D          \ Call subm_B63D, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B88C_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B88C routine in ROM bank 6
\
\ ******************************************************************************

.subm_B88C_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_B88C          \ Call subm_B88C, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: LL9_b1
\       Type: Subroutine
\   Category: Drawing ships
\    Summary: Call the LL9 routine in ROM bank 1
\
\ ******************************************************************************

.LL9_b1

 LDA currentBank        \ If ROM bank 1 is already paged into memory, jump to
 CMP #1                 \ bank3
 BEQ bank3

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 JSR LL9                \ Call LL9, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank3

 JMP LL9                \ Call LL9, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_BA23_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_BA23 routine in ROM bank 3
\
\ ******************************************************************************

.subm_BA23_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_BA23          \ Call subm_BA23, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: TIDY_b1
\       Type: Subroutine
\   Category: Maths (Geometry)
\    Summary: Call the TIDY routine in ROM bank 1
\
\ ******************************************************************************

.TIDY_b1

 LDA currentBank        \ If ROM bank 1 is already paged into memory, jump to
 CMP #1                 \ bank4
 BEQ bank4

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 JSR TIDY               \ Call TIDY, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank4

 JMP TIDY               \ Call TIDY, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: StartScreen_b6
\       Type: Subroutine
\   Category: Start and end
\    Summary: Call the StartScreen routine in ROM bank 6
\
\ ******************************************************************************

.StartScreen_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR StartScreen        \ Call StartScreen, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DemoShips_b0
\       Type: Subroutine
\   Category: Demo
\    Summary: Call the SpawnDemoShips routine in ROM bank 0
\
\ ******************************************************************************

.DemoShips_b0

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JMP DemoShips          \ Call DemoShips, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: STARS_b1
\       Type: Subroutine
\   Category: Stardust
\    Summary: Call the STARS routine in ROM bank 1
\
\ ******************************************************************************

.STARS_b1

 LDA currentBank        \ If ROM bank 1 is already paged into memory, jump to
 CMP #1                 \ bank5
 BEQ bank5

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 JSR STARS              \ Call STARS, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank5

 JMP STARS              \ Call STARS, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: CIRCLE2_b1
\       Type: Subroutine
\   Category: Drawing circles
\    Summary: Call the CIRCLE2 routine in ROM bank 1
\
\ ******************************************************************************

.CIRCLE2_b1

 LDA currentBank        \ If ROM bank 1 is already paged into memory, jump to
 CMP #1                 \ bank6
 BEQ bank6

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 JSR CIRCLE2            \ Call CIRCLE2, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank6

 JMP CIRCLE2            \ Call CIRCLE2, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SUN_b1
\       Type: Subroutine
\   Category: Drawing suns
\    Summary: Call the SUN routine in ROM bank 1
\
\ ******************************************************************************

.SUN_b1

 LDA currentBank        \ If ROM bank 1 is already paged into memory, jump to
 CMP #1                 \ bank7
 BEQ bank7

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 JSR SUN                \ Call SUN, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank7

 JMP SUN                \ Call SUN, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B2FB_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B2FB routine in ROM bank 3
\
\ ******************************************************************************

.subm_B2FB_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_B2FB          \ Call subm_B2FB, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B219_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B219 routine in ROM bank 3
\
\ ******************************************************************************

.subm_B219_b3

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank8
 BEQ bank8

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR subm_B219          \ Call subm_B219, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank8

 LDA ASAV               \ Restore the value of A that we stored above

 JMP subm_B219          \ Call subm_B219, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B9C1_b4
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B9C1 routine in ROM bank 4
\
\ ******************************************************************************

.subm_B9C1_b4

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #4                 \ Page ROM bank 4 into memory at &8000
 JSR SetBank

 JSR subm_B9C1          \ Call subm_B9C1, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_A082_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_A082 routine in ROM bank 6
\
\ ******************************************************************************

.subm_A082_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_A082          \ Call subm_A082, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_A0F8_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_A0F8 routine in ROM bank 6
\
\ ******************************************************************************

.subm_A0F8_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_A0F8          \ Call subm_A0F8, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B882_b4
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B882 routine in ROM bank 4
\
\ ******************************************************************************

.subm_B882_b4

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #4                 \ Page ROM bank 4 into memory at &8000
 JSR SetBank

 JSR subm_B882          \ Call subm_B882, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_A4A5_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_A4A5 routine in ROM bank 6
\
\ ******************************************************************************

.subm_A4A5_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_A4A5          \ Call subm_A4A5, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DEATH2_b0
\       Type: Subroutine
\   Category: Start and end
\    Summary: Switch to ROM bank 0 and call the DEATH2 routine
\
\ ******************************************************************************

.DEATH2_b0

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JMP DEATH2             \ Call DEATH2, which is now paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B358_b0
\       Type: Subroutine
\   Category: ???
\    Summary: Switch to ROM bank 0 and call the subm_B358 routine
\
\ ******************************************************************************

.subm_B358_b0

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JMP subm_B358          \ Call subm_B358, which is now paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B9E2_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B9E2 routine in ROM bank 3
\
\ ******************************************************************************

.subm_B9E2_b3

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank9
 BEQ bank9

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_B9E2          \ Call subm_B9E2, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank9

 JMP subm_B9E2          \ Call subm_B9E2, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B673_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B673 routine in ROM bank 3
\
\ ******************************************************************************

.subm_B673_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_B673          \ Call subm_B673, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B2BC_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B2BC routine in ROM bank 3
\
\ ******************************************************************************

.subm_B2BC_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_B2BC          \ Call subm_B2BC, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B248_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B248 routine in ROM bank 3
\
\ ******************************************************************************

.subm_B248_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_B248          \ Call subm_B248, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_BA17_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_BA17 routine in ROM bank 6
\
\ ******************************************************************************

.subm_BA17_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_BA17          \ Call subm_BA17, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_AFCD_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_AFCD routine in ROM bank 3
\
\ ******************************************************************************

.subm_AFCD_b3

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank10
 BEQ bank10

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_AFCD          \ Call subm_AFCD, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank10

 JMP subm_AFCD          \ Call subm_AFCD, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_BE52_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_BE52 routine in ROM bank 6
\
\ ******************************************************************************

.subm_BE52_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_BE52          \ Call subm_BE52, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_BED2_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_BED2 routine in ROM bank 6
\
\ ******************************************************************************

.subm_BED2_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_BED2          \ Call subm_BED2, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B0E1_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B0E1 routine in ROM bank 3
\
\ ******************************************************************************

.subm_B0E1_b3

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank11
 BEQ bank11

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR subm_B0E1          \ Call subm_B0E1, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank11

 LDA ASAV               \ Restore the value of A that we stored above

 JMP subm_B0E1          \ Call subm_B0E1, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B18E_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B18E routine in ROM bank 3
\
\ ******************************************************************************

.subm_B18E_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_B18E          \ Call subm_B18E, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: PAS1_b0
\       Type: Subroutine
\   Category: Keyboard
\    Summary: Call the PAS1 routine in ROM bank 0
\
\ ******************************************************************************

.PAS1_b0

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JSR PAS1               \ Call PAS1, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SetSystemImage_b5
\       Type: Subroutine
\   Category: Drawing images
\    Summary: Call the SetSystemImage routine in ROM bank 5
\
\ ******************************************************************************

.SetSystemImage_b5

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #5                 \ Page ROM bank 5 into memory at &8000
 JSR SetBank

 JSR SetSystemImage     \ Call SetSystemImage, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: GetSystemImage_b5
\       Type: Subroutine
\   Category: Drawing images
\    Summary: Call the GetSystemImage routine in ROM bank 5
\
\ ******************************************************************************

.GetSystemImage_b5

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #5                 \ Page ROM bank 5 into memory at &8000
 JSR SetBank

 JSR GetSystemImage     \ Call GetSystemImage, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SetCmdrImage_b4
\       Type: Subroutine
\   Category: Drawing images
\    Summary: Call the SetCmdrImage routine in ROM bank 4
\
\ ******************************************************************************

.SetCmdrImage_b4

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #4                 \ Page ROM bank 4 into memory at &8000
 JSR SetBank

 JSR SetCmdrImage       \ Call SetCmdrImage, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: GetCmdrImage_b4
\       Type: Subroutine
\   Category: Drawing images
\    Summary: Call the GetCmdrImage routine in ROM bank 4
\
\ ******************************************************************************

.GetCmdrImage_b4

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #4                 \ Page ROM bank 4 into memory at &8000
 JSR SetBank

 JSR GetCmdrImage       \ Call GetCmdrImage, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DIALS_b6
\       Type: Subroutine
\   Category: Dashboard
\    Summary: Call the DIALS routine in ROM bank 6
\
\ ******************************************************************************

.DIALS_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR DIALS              \ Call DIALS, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_BA63_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_BA63 routine in ROM bank 6
\
\ ******************************************************************************

.subm_BA63_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_BA63          \ Call subm_BA63, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B39D_b0
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B39D routine in ROM bank 0
\
\ ******************************************************************************

.subm_B39D_b0

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 0 is already paged into memory, jump to
 CMP #0                 \ bank12
 BEQ bank12

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR subm_B39D          \ Call subm_B39D, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank12

 LDA ASAV               \ Restore the value of A that we stored above

 JMP subm_B39D          \ Call subm_B39D, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: LL164_b6
\       Type: Subroutine
\   Category: Drawing circles
\    Summary: Call the LL164 routine in ROM bank 6
\
\ ******************************************************************************

.LL164_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR LL164              \ Call LL164, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B919_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B919 routine in ROM bank 6
\
\ ******************************************************************************

.subm_B919_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_B919          \ Call subm_B919, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_A166_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_A166 routine in ROM bank 6
\
\ ******************************************************************************

.subm_A166_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_A166          \ Call subm_A166, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SetKeyLogger_b6
\       Type: Subroutine
\   Category: Keyboard
\    Summary: Call the SetKeyLogger routine in ROM bank 6
\
\ ******************************************************************************

.SetKeyLogger_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR SetKeyLogger       \ Call SetKeyLogger, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: ChangeCmdrName_b6
\       Type: Subroutine
\   Category: Save and load
\    Summary: Call the ChangeCmdrName routine in ROM bank 6
\
\ ******************************************************************************

.ChangeCmdrName_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR ChangeCmdrName     \ Call ChangeCmdrName, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B8FE_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B8FE routine in ROM bank 6
\
\ ******************************************************************************

.subm_B8FE_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_B8FE          \ Call subm_B8FE, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B906_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B90D routine in ROM bank 6
\
\ ******************************************************************************

.subm_B906_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_B906          \ Call subm_B906, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_A5AB_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_A5AB routine in ROM bank 6
\
\ ******************************************************************************

.subm_A5AB_b6

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 6 is already paged into memory, jump to
 CMP #6                 \ bank13
 BEQ bank13

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR subm_A5AB          \ Call subm_A5AB, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank13

 LDA ASAV               \ Restore the value of A that we stored above

 JMP subm_A5AB          \ Call subm_A5AB, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: BEEP_b7
\       Type: Subroutine
\   Category: Sound
\    Summary: Call the BEEP routine in ROM bank 7
\
\ ******************************************************************************

.BEEP_b7

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JSR BEEP               \ Call BEEP, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DETOK_b2
\       Type: Subroutine
\   Category: Text
\    Summary: Call the DETOK routine in ROM bank 2
\
\ ******************************************************************************

.DETOK_b2

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 2 is already paged into memory, jump to
 CMP #2                 \ bank14
 BEQ bank14

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #2                 \ Page ROM bank 2 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR DETOK              \ Call DETOK, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank14

 LDA ASAV               \ Restore the value of A that we stored above

 JMP DETOK              \ Call DETOK, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DTS_b2
\       Type: Subroutine
\   Category: Text
\    Summary: Call the DTS routine in ROM bank 2
\
\ ******************************************************************************

.DTS_b2

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 2 is already paged into memory, jump to
 CMP #2                 \ bank15
 BEQ bank15

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #2                 \ Page ROM bank 2 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR DTS                \ Call DTS, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank15

 LDA ASAV               \ Restore the value of A that we stored above

 JMP DTS                \ Call DTS, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: PDESC_b2
\       Type: Subroutine
\   Category: Text
\    Summary: Call the PDESC routine in ROM bank 2
\
\ ******************************************************************************

.PDESC_b2

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #2                 \ Page ROM bank 2 into memory at &8000
 JSR SetBank

 JSR PDESC              \ Call PDESC, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_AE18_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_AE18 routine in ROM bank 3
\
\ ******************************************************************************

.subm_AE18_b3

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank16
 BEQ bank16

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR subm_AE18          \ Call subm_AE18, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank16

 LDA ASAV               \ Restore the value of A that we stored above

 JMP subm_AE18          \ Call subm_AE18, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_AC1D_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_AC1D routine in ROM bank 3
\
\ ******************************************************************************

.subm_AC1D_b3

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank17
 BEQ bank17

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR subm_AC1D          \ Call subm_AC1D, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank17

 LDA ASAV               \ Restore the value of A that we stored above

 JMP subm_AC1D          \ Call subm_AC1D, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_A730_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_A730 routine in ROM bank 3
\
\ ******************************************************************************

.subm_A730_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_A730          \ Call subm_A730, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_A775_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_A775 routine in ROM bank 3
\
\ ******************************************************************************

.subm_A775_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_A775          \ Call subm_A775, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawTitleScreen_b3
\       Type: Subroutine
\   Category: Start and end
\    Summary: Call the DrawTitleScreen routine in ROM bank 3
\
\ ******************************************************************************

.DrawTitleScreen_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR DrawTitleScreen    \ Call DrawTitleScreen, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_F126
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_F126

 LDA L0473
 BPL subm_F139

\ ******************************************************************************
\
\       Name: subm_A7B7_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_A7B7 routine in ROM bank 3
\
\ ******************************************************************************

.subm_A7B7_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_A7B7          \ Call subm_A7B7, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_F139
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_F139

 LDA #&74
 STA L00CD
 STA L00CE

\ ******************************************************************************
\
\       Name: subm_A9D1_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_A9D1 routine in ROM bank 3
\
\ ******************************************************************************

.subm_A9D1_b3

 LDA #&C0               \ Set A = &C0 ???

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank18
 BEQ bank18

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR subm_A9D1          \ Call subm_A9D1, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank18

 LDA ASAV               \ Restore the value of A that we stored above

 JMP subm_A9D1          \ Call subm_A9D1, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_A972_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_A972 routine in ROM bank 3
\
\ ******************************************************************************

.subm_A972_b3

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank19
 BEQ bank19

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_A972          \ Call subm_A972, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank19

 JMP subm_A972          \ Call subm_A972, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_AC5C_b3
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_AC5C routine in ROM bank 3
\
\ ******************************************************************************

.subm_AC5C_b3

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank20
 BEQ bank20

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR subm_AC5C          \ Call subm_AC5C, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank20

 JMP subm_AC5C          \ Call subm_AC5C, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_8980_b0
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_8980 routine in ROM bank 0
\
\ ******************************************************************************

.subm_8980_b0

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JSR subm_8980          \ Call subm_8980, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_B459_b6
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_B459 routine in ROM bank 6
\
\ ******************************************************************************

.subm_B459_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR subm_B459          \ Call subm_B459, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: MVS5_b0
\       Type: Subroutine
\   Category: Moving
\    Summary: Call the MVS5 routine in ROM bank 0
\
\ ******************************************************************************

.MVS5_b0

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 0 is already paged into memory, jump to
 CMP #0                 \ bank21
 BEQ bank21

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR MVS5               \ Call MVS5, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank21

 LDA ASAV               \ Restore the value of A that we stored above

 JMP MVS5               \ Call MVS5, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: HALL_b1
\       Type: Subroutine
\   Category: Ship hangar
\    Summary: Call the HALL routine in ROM bank 1
\
\ ******************************************************************************

.HALL_b1

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 JSR HALL               \ Call HALL, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: CHPR_b2
\       Type: Subroutine
\   Category: Text
\    Summary: Call the CHPR routine in ROM bank 2
\
\ ******************************************************************************

.CHPR_b2

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 2 is already paged into memory, jump to
 CMP #2                 \ bank22
 BEQ bank22

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #2                 \ Page ROM bank 2 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR CHPR               \ Call CHPR, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank22

 LDA ASAV               \ Restore the value of A that we stored above

 JMP CHPR               \ Call CHPR, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DASC_b2
\       Type: Subroutine
\   Category: Text
\    Summary: Call the DASC routine in ROM bank 2
\
\ ******************************************************************************

.DASC_b2

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 2 is already paged into memory, jump to
 CMP #2                 \ bank23
 BEQ bank23

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #2                 \ Page ROM bank 2 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR DASC               \ Call DASC, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank23

 LDA ASAV               \ Restore the value of A that we stored above

 JMP DASC               \ Call DASC, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: TT27_b2
\       Type: Subroutine
\   Category: Text
\    Summary: Call the TT27 routine in ROM bank 2
\
\ ******************************************************************************

.TT27_b2

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 2 is already paged into memory, jump to
 CMP #2                 \ bank24
 BEQ bank24

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #2                 \ Page ROM bank 2 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR TT27               \ Call TT27, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank24

 LDA ASAV               \ Restore the value of A that we stored above

 JMP TT27               \ Call TT27, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: ex_b2
\       Type: Subroutine
\   Category: Text
\    Summary: Call the ex routine in ROM bank 2
\
\ ******************************************************************************

.ex_b2

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 2 is already paged into memory, jump to
 CMP #2                 \ bank25
 BEQ bank25

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #2                 \ Page ROM bank 2 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR ex                 \ Call ex, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank25

 LDA ASAV               \ Restore the value of A that we stored above

 JMP ex                 \ Call ex, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: TT27_b0
\       Type: Subroutine
\   Category: Text
\    Summary: Call the TT27 routine in ROM bank 0
\
\ ******************************************************************************

.TT27_b0

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JSR TT27_0             \ Call TT27_0, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: BR1_b0
\       Type: Subroutine
\   Category: Start and end
\    Summary: Call the BR1 routine in ROM bank 0
\
\ ******************************************************************************

.BR1_b0

 LDA currentBank        \ If ROM bank 0 is already paged into memory, jump to
 CMP #0                 \ bank26
 BEQ bank26

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JSR BR1                \ Call BR1, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank26

 JMP BR1                \ Call BR1, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_F25A
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_F25A

 LDA #0
 LDY #&21
 STA (XX19),Y

\ ******************************************************************************
\
\       Name: subm_BAF3_b1
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_BAF3 routine in ROM bank 1
\
\ ******************************************************************************

.subm_BAF3_b1

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 JSR subm_BAF3          \ Call subm_BAF3, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: TT66_b0
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Call the TT66 routine in ROM bank 0
\
\ ******************************************************************************

.TT66_b0

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR TT66               \ Call TT66, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: CLIP_b1
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: Call the CLIP routine in ROM bank 1, drawing the clipped line if
\             it fits on-screen
\
\ ******************************************************************************

.CLIP_b1

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 JSR CLIP               \ Call CLIP, now that it is paged into memory

 BCS P%+5               \ If the C flag is set then the clipped line does not
                        \ fit on-screen, so skip the next instruction

 JSR LOIN               \ The clipped line fits on-screen, so draw it

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: ClearTiles_b3
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Call the ClearTiles routine in ROM bank 3
\
\ ******************************************************************************

.ClearTiles_b3

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank27
 BEQ bank27

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR ClearTiles         \ Call ClearTiles, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank27

 JMP ClearTiles         \ Call ClearTiles, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SCAN_b1
\       Type: Subroutine
\   Category: Dashboard
\    Summary: Call the SCAN routine in ROM bank 1
\
\ ******************************************************************************

.SCAN_b1

 LDA currentBank        \ If ROM bank 1 is already paged into memory, jump to
 CMP #1                 \ bank28
 BEQ bank28

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 JSR SCAN               \ Call SCAN, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank28

 JMP SCAN               \ Call SCAN, which is already paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_F2BD
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_F2BD

 JSR subm_EB86

\ ******************************************************************************
\
\       Name: subm_8926_b0
\       Type: Subroutine
\   Category: ???
\    Summary: Call the subm_8926 routine in ROM bank 0
\
\ ******************************************************************************

.subm_8926_b0

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JSR subm_8926          \ Call subm_8926, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: subm_F2CE
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_F2CE

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JSR CopyNameBuffer0To1

 JSR subm_F126          \ Call subm_F126, now that it is paged into memory

 LDX #1
 STX palettePhase
 RTS

\ ******************************************************************************
\
\       Name: CLYNS
\       Type: Subroutine
\   Category: Utility routines
\    Summary: ???
\
\ ------------------------------------------------------------------------------
\
\ Other entry points:
\
\   CLYNS+8             Don't zero L0393 and L0394
\
\ ******************************************************************************

.CLYNS

 LDA #0
 STA L0393
 STA L0394

 LDA #&FF
 STA DTW2
 LDA #&80
 STA QQ17
 LDA #&16
 STA YC
 LDA #1
 STA XC
 LDA L00D2
 STA tileNumber
 LDA QQ11
 BPL CF332
 LDA #&72
 STA SC+1
 LDA #&E0
 STA SC
 LDA #&76
 STA SC2+1
 LDA #&E0
 STA SC2
 LDX #2

.loop_CF311

 JSR SetupPPUForIconBar \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDY #2
 LDA #0

.loop_CF318

 STA (SC),Y
 STA (SC2),Y
 INY
 CPY #&1F
 BNE loop_CF318
 LDA SC
 ADC #&1F
 STA SC
 STA SC2
 BCC CF32F
 INC SC+1
 INC SC2+1

.CF32F

 DEX
 BNE loop_CF311

.CF332

 RTS

\ ******************************************************************************
\
\       Name: LF333
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.LF333

 EQUB &1C, &1A, &28, &16,   6                 ; F333: 1C 1A 28... ..(

\ ******************************************************************************
\
\       Name: GetStatusCondition
\       Type: Subroutine
\   Category: Status
\    Summary: ???
\
\ ******************************************************************************

.GetStatusCondition

 LDX #0
 LDY QQ12
 BNE CF355
 INX
 LDY JUNK
 LDA FRIN+2,Y
 BEQ CF355
 INX
 LDY L0472
 CPY #3
 BEQ subm_F359
 LDA ENERGY
 BMI CF355

.loop_CF354

 INX

.CF355

 STX L0472
 RTS

\ ******************************************************************************
\
\       Name: subm_F359
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_F359

 LDA ENERGY
 CMP #&A0
 BCC loop_CF354
 BCS CF355

\ ******************************************************************************
\
\       Name: subm_F362
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_F362

 LDY #&0C
 JSR DELAY
 LDA #0
 CLC
 ADC #0
 STA frameCounter
 STA nmiTimer
 STA nmiTimerLo
 STA nmiTimerHi
 STA palettePhase
 STA otherPhase
 STA drawingPhase
 LDA #&FF
 STA L0307
 LDA #&80
 STA L0308
 LDA #&1B
 STA L0309
 LDA #&34
 STA L030A
 JSR subm_F3AB
 LDA #0
 STA K%+6
 STA K%

\ ******************************************************************************
\
\       Name: subm_F39A
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_F39A

 LDA #&75
 STA RAND
 LDA #&0A
 STA RAND+1
 LDA #&2A
 STA RAND+2
 LDX #&E6
 STX RAND+3
 RTS

\ ******************************************************************************
\
\       Name: subm_F3AB
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_F3AB

 LDA #0
 STA L03EB
 STA L03ED
 LDA #&FF
 STA L03EA
 STA L03EC
 RTS

\ ******************************************************************************
\
\       Name: subm_F3BC
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_F3BC

 JSR subm_B63D_b3
 LDA #0
 JSR subm_8021_b6
 JSR subm_EB8F
 LDA #&FF
 STA QQ11a
 LDA #1
 STA scanController2
 LDA #&32
 STA nmiTimer
 LDA #0
 STA nmiTimerLo
 STA nmiTimerHi

.loop_CF3DA

 LDY #0

.loop_CF3DC

 STY L03FC
 LDA LF415,Y
 BEQ loop_CF3DA
 TAX
 LDA LF422,Y
 TAY
 LDA #6
 JSR TITLE
 BCS CF411
 LDY L03FC
 INY
 LDA nmiTimerHi
 CMP #1
 BCC loop_CF3DC
 LSR scanController2
 JSR WaitResetSound
 JSR subm_B63D_b3
 LDA language
 STA K%
 LDA #5
 STA K%+1
 JMP CC035

.CF411

 JSR WaitResetSound
 RTS

\ ******************************************************************************
\
\       Name: LF415
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.LF415

 EQUB &0B, &13, &14, &19, &1D, &15, &12, &1B  ; F415: 0B 13 14... ...
 EQUB &0A,   1, &11, &10,   0                 ; F41D: 0A 01 11... ...

\ ******************************************************************************
\
\       Name: LF422
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.LF422

 EQUB &64, &0A, &0A, &1E, &B4, &0A, &28, &5A  ; F422: 64 0A 0A... d..
 EQUB &0A, &46, &28, &0A

INCLUDE "library/common/main/subroutine/ze.asm"

\ ******************************************************************************
\
\       Name: subm_F454
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_F454

 PHA
 LDA NAME+7
 BMI CF463
 CLC
 ADC #1
 CMP #&64
 BCC CF463
 LDA #0

.CF463

 ORA #&80
 STA NAME+7
 PLA
 RTS

\ ******************************************************************************
\
\       Name: NLIN3
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: ???
\
\ ******************************************************************************

.NLIN3

 PHA
 LDA #0
 STA YC
 PLA
 JSR TT27_b2

\ ******************************************************************************
\
\       Name: NLIN4
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: ???
\
\ ******************************************************************************

.NLIN4

 LDA #4
 BNE subm_F47D
 LDA #1
 STA YC
 LDA #4

\ ******************************************************************************
\
\       Name: subm_F47D
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_F47D

 JSR SetupPPUForIconBar \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDY #1
 LDA #3

.loop_CF484

 STA nameBuffer0+2*32,Y
 INY
 CPY #&20
 BNE loop_CF484
 RTS

\ ******************************************************************************
\
\       Name: ResetDrawingPhase
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.ResetDrawingPhase

 LDX #0
 JSR SetDrawingPhase
 RTS

\ ******************************************************************************
\
\       Name: ResetBuffers
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.ResetBuffers

 LDA #&60
 STA SC2+1
 LDA #0
 STA SC2
 LDY #0
 LDX #&18
 LDA #0

.CF4A1

 STA (SC2),Y
 INY
 BNE CF4A1
 INC SC2+1
 DEX
 BNE CF4A1
 RTS

INCLUDE "library/common/main/subroutine/dornd.asm"
INCLUDE "library/common/main/subroutine/proj.asm"
INCLUDE "library/common/main/subroutine/pls6.asm"

\ ******************************************************************************
\
\       Name: UnpackToRAM
\       Type: Subroutine
\   Category: Drawing images
\    Summary: Unpack compressed image data to RAM
\
\ ------------------------------------------------------------------------------
\
\ UnpackToRAM copies data from V(1 0) to SC(1 0)
\ Fetch byte from V(1 0) and increment V(1 0), say byte is &xx
\   >= &40 store byte as is and move on to next
\   = &x0 store byte as is and move on to next
\   = &3F stop and return from subroutine - end of decompression
\   >= &20, jump to CF572
\           >= &30 jump to CF589 to copy next &0x bytes from V(1 0) as they
\                  are, incrementing V(1 0) as we go
\           >= &20 fetch next byte and store it for &0x bytes
\   >= &10, jump to CF56E to store &FF for &0x bytes
\   < &10, store 0 for &0x bytes
\ 
\ &00 = unchanged
\ &0x = store 0 for &0x bytes
\ &10 = unchanged
\ &1x = store &FF for &0x bytes
\ &20 = unchanged
\ &2x = store next byte for &0x bytes
\ &30 = unchanged
\ &3x = store next &0x bytes unchanged
\ &40 and above = unchanged
\
\ ******************************************************************************

.UnpackToRAM

 LDY #0

.CF52F

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0
 LDA (V,X)
 INC V
 BNE CF546
 INC V+1

.CF546

 CMP #&40
 BCS CF5A4
 TAX
 AND #&0F
 BEQ CF5A3
 CPX #&3F
 BEQ CF5AE
 TXA
 CMP #&20
 BCS CF572
 CMP #&10
 AND #&0F
 TAX
 BCS CF56E
 LDA #0

.CF561

 STA (SC),Y
 INY
 BNE CF568
 INC SC+1

.CF568

 DEX
 BNE CF561
 JMP CF52F

.CF56E

 LDA #&FF
 BNE CF561

.CF572

 LDX #0
 CMP #&30
 BCS CF589
 AND #&0F
 STA T
 LDA (V,X)
 LDX T
 INC V
 BNE CF561
 INC V+1
 JMP CF561

.CF589

 AND #&0F
 STA T

.loop_CF58D

 LDA (V,X)
 INC V
 BNE CF595
 INC V+1

.CF595

 STA (SC),Y
 INY
 BNE CF59C
 INC SC+1

.CF59C

 DEC T
 BNE loop_CF58D
 JMP CF52F

.CF5A3

 TXA

.CF5A4

 STA (SC),Y
 INY
 BNE CF52F
 INC SC+1
 JMP CF52F

.CF5AE

 RTS

\ ******************************************************************************
\
\       Name: UnpackToPPU
\       Type: Subroutine
\   Category: Drawing images
\    Summary: Unpack compressed image data and send it to the PPU
\
\ ******************************************************************************

.UnpackToPPU

 LDY #0

.CF5B1

 LDA (V),Y
 INY
 BNE CF5B8
 INC V+1

.CF5B8

 CMP #&40
 BCS CF605
 TAX
 AND #&0F
 BEQ CF604
 CPX #&3F
 BEQ CF60B
 TXA
 CMP #&20
 BCS CF5E0
 CMP #&10
 AND #&0F
 TAX
 BCS CF5DC
 LDA #0

.CF5D3

 STA PPU_DATA
 DEX
 BNE CF5D3
 JMP CF5B1

.CF5DC

 LDA #&FF
 BNE CF5D3

.CF5E0

 CMP #&30
 BCS CF5F1
 AND #&0F
 TAX
 LDA (V),Y
 INY
 BNE CF5D3
 INC V+1
 JMP CF5D3

.CF5F1

 AND #&0F
 TAX

.loop_CF5F4

 LDA (V),Y
 INY
 BNE CF5FB
 INC V+1

.CF5FB

 STA PPU_DATA
 DEX
 BNE loop_CF5F4
 JMP CF5B1

.CF604

 TXA

.CF605

 STA PPU_DATA
 JMP CF5B1

.CF60B

 RTS

\ ******************************************************************************
\
\       Name: FAROF2
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.FAROF2

 STA T

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA INWK+2
 ORA INWK+5
 ORA INWK+8
 ASL A
 BNE CF658
 LDA INWK+7
 LSR A
 STA K+2
 LDA INWK+1
 LSR A
 STA K
 LDA INWK+4
 LSR A
 STA K+1
 CMP K
 BCS CF639
 LDA K

.CF639

 CMP K+2
 BCS CF63F
 LDA K+2

.CF63F

 STA SC
 LDA K
 CLC
 ADC K+1
 ADC K+2
 SEC
 SBC SC
 LSR A
 LSR A
 STA SC+1
 LSR A
 LSR A
 ADC SC+1
 ADC SC
 CMP T
 RTS

.CF658

 SEC
 RTS

INCLUDE "library/common/main/subroutine/mu5.asm"
INCLUDE "library/common/main/subroutine/mult3.asm"
INCLUDE "library/common/main/subroutine/mls2.asm"
INCLUDE "library/common/main/subroutine/mls1.asm"
INCLUDE "library/common/main/subroutine/mu6.asm"
INCLUDE "library/common/main/subroutine/squa.asm"
INCLUDE "library/common/main/subroutine/squa2.asm"
INCLUDE "library/common/main/subroutine/mu1.asm"
INCLUDE "library/common/main/subroutine/mlu1.asm"
INCLUDE "library/common/main/subroutine/mlu2.asm"
INCLUDE "library/common/main/subroutine/multu.asm"
INCLUDE "library/common/main/subroutine/mu11.asm"
INCLUDE "library/common/main/subroutine/fmltu2.asm"
INCLUDE "library/common/main/subroutine/fmltu.asm"
INCLUDE "library/common/main/subroutine/mltu2.asm"
INCLUDE "library/common/main/subroutine/mut3.asm"
INCLUDE "library/common/main/subroutine/mut2.asm"
INCLUDE "library/common/main/subroutine/mut1.asm"
INCLUDE "library/common/main/subroutine/mult1.asm"
INCLUDE "library/common/main/subroutine/mult12.asm"
INCLUDE "library/common/main/subroutine/tas3.asm"
INCLUDE "library/common/main/subroutine/mad.asm"
INCLUDE "library/common/main/subroutine/add.asm"
INCLUDE "library/common/main/subroutine/tis1.asm"
INCLUDE "library/common/main/subroutine/dv42.asm"
INCLUDE "library/common/main/subroutine/dv41.asm"
INCLUDE "library/advanced/main/subroutine/dvid4.asm"
INCLUDE "library/common/main/subroutine/dvid3b2.asm"

\ ******************************************************************************
\
\       Name: cntr
\       Type: Subroutine
\   Category: Dashboard
\    Summary: Apply damping to the pitch or roll dashboard indicator
\
\ ******************************************************************************

.CFA13

 LDX #&80

.loop_CFA15

 RTS

.cntr

 STA T
 LDA auto
 BNE CFA22
 LDA L03EA
 BEQ loop_CFA15

.CFA22

 TXA
 BMI CFA2C
 CLC
 ADC T
 BMI CFA13
 TAX
 RTS

.CFA2C

 SEC
 SBC T
 BPL CFA13
 TAX
 RTS

INCLUDE "library/common/main/subroutine/bump2.asm"
INCLUDE "library/common/main/subroutine/redu2.asm"
INCLUDE "library/common/main/subroutine/ll5.asm"
INCLUDE "library/common/main/subroutine/ll28.asm"
INCLUDE "library/common/main/subroutine/tis2.asm"
INCLUDE "library/common/main/subroutine/norm.asm"

\ ******************************************************************************
\
\       Name: SetupMMC1
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.SetupMMC1

 LDA #&0E
 STA &9FFF
 LSR A
 STA &9FFF
 LSR A
 STA &9FFF
 LSR A
 STA &9FFF
 LSR A
 STA &9FFF
 LDA #0
 STA &BFFF
 LSR A
 STA &BFFF
 LSR A
 STA &BFFF
 LSR A
 STA &BFFF
 LSR A
 STA &BFFF
 LDA #0
 STA &DFFF
 LSR A
 STA &DFFF
 LSR A
 STA &DFFF
 LSR A
 STA &DFFF
 LSR A
 STA &DFFF
 JMP CC0A3

\ ******************************************************************************
\
\       Name: LFBCB
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

IF _NTSC

 EQUB &F5, &F5, &F5, &F5, &F6, &F6, &F6, &F6  ; FBCB: F5 F5 F5... ...
 EQUB &F7, &F7, &F7, &F7, &F7, &F8, &F8, &F8  ; FBD3: F7 F7 F7... ...
 EQUB &F8, &F9, &F9, &F9, &F9, &F9, &FA, &FA  ; FBDB: F8 F9 F9... ...
 EQUB &FA, &FA, &FA, &FB, &FB, &FB, &FB, &FB  ; FBE3: FA FA FA... ...
 EQUB &FC, &FC, &FC, &FC, &FC, &FD, &FD, &FD  ; FBEB: FC FC FC... ...
 EQUB &FD, &FD, &FD, &FE, &FE, &FE, &FE, &FE  ; FBF3: FD FD FD... ...
 EQUB &FF, &FF, &FF, &FF, &FF

ELIF _PAL

 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF
 EQUB &FF, &FF, &FF, &FF, &FF, &FF

ENDIF

\ ******************************************************************************
\
\       Name: lineImage
\       Type: Variable
\   Category: Drawing images
\    Summary: Image data for the horizontal line, vertical line and block images
\
\ ******************************************************************************

.lineImage

 EQUB &FF, &00, &00, &00, &00, &00, &00, &00  ; FC00: FF 00 00... ...
 EQUB &00, &FF, &00, &00, &00, &00, &00, &00  ; FC08: 00 FF 00... ...
 EQUB &00, &00, &FF, &00, &00, &00, &00, &00  ; FC10: 00 00 FF... ...
 EQUB &00, &00, &00, &FF, &00, &00, &00, &00  ; FC18: 00 00 00... ...
 EQUB &00, &00, &00, &00, &FF, &00, &00, &00  ; FC20: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &FF, &00, &00  ; FC28: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &FF, &00  ; FC30: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &00, &FF  ; FC38: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &00, &FF, &FF  ; FC40: 00 00 00... ...
 EQUB &00, &00, &00, &00, &00, &FF, &FF, &FF  ; FC48: 00 00 00... ...
 EQUB &00, &00, &00, &00, &FF, &FF, &FF, &FF  ; FC50: 00 00 00... ...
 EQUB &00, &00, &00, &FF, &FF, &FF, &FF, &FF  ; FC58: 00 00 00... ...
 EQUB &00, &00, &FF, &FF, &FF, &FF, &FF, &FF  ; FC60: 00 00 FF... ...
 EQUB &00, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; FC68: 00 FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; FC70: FF FF FF... ...
 EQUB &80, &80, &80, &80, &80, &80, &80, &80  ; FC78: 80 80 80... ...
 EQUB &40, &40, &40, &40, &40, &40, &40, &40  ; FC80: 40 40 40... @@@
 EQUB &20, &20, &20, &20, &20, &20, &20, &20  ; FC88: 20 20 20...
 EQUB &10, &10, &10, &10, &10, &10, &10, &10  ; FC90: 10 10 10... ...
 EQUB &08, &08, &08, &08, &08, &08, &08, &08  ; FC98: 08 08 08... ...
 EQUB &04, &04, &04, &04, &04, &04, &04, &04  ; FCA0: 04 04 04... ...
 EQUB &02, &02, &02, &02, &02, &02, &02, &02  ; FCA8: 02 02 02... ...
 EQUB &01, &01, &01, &01, &01, &01, &01, &01  ; FCB0: 01 01 01... ...
 EQUB &00, &00, &00, &00, &00, &FF, &FF, &FF  ; FCB8: 00 00 00... ...
 EQUB &FF, &FF, &FF, &00, &00, &00, &00, &00  ; FCC0: FF FF FF... ...
 EQUB &00, &00, &00, &00, &00, &C0, &C0, &C0  ; FCC8: 00 00 00... ...
 EQUB &C0, &C0, &C0, &00, &00, &00, &00, &00  ; FCD0: C0 C0 C0... ...
 EQUB &00, &00, &00, &00, &00, &03, &03, &03  ; FCD8: 00 00 00... ...
 EQUB &03, &03, &03, &00, &00, &00, &00, &00  ; FCE0: 03 03 03... ...

\ ******************************************************************************
\
\       Name: fontImage
\       Type: Variable
\   Category: Text
\    Summary: Image data for the text font
\
\ ******************************************************************************

.fontImage

 EQUB &00, &00, &00, &00, &00, &00, &00, &00
 EQUB &30, &30, &30, &30, &00, &30, &30, &00
 EQUB &7F, &63, &63, &63, &7F, &63, &63, &00
 EQUB &7F, &63, &63, &63, &63, &63, &7F, &00
 EQUB &78, &1E, &7F, &03, &7F, &63, &7F, &00
 EQUB &1F, &78, &7F, &63, &7F, &60, &7F, &00
 EQUB &7C, &CC, &78, &38, &6D, &C6, &7F, &00
 EQUB &30, &30, &30, &00, &00, &00, &00, &00
 EQUB &06, &0C, &18, &18, &18, &0C, &06, &00
 EQUB &60, &30, &18, &18, &18, &30, &60, &00
 EQUB &78, &1E, &7F, &63, &7F, &60, &7F, &00
 EQUB &1C, &36, &7F, &63, &7F, &60, &7F, &00
 EQUB &00, &00, &00, &00, &00, &30, &30, &60
 EQUB &00, &00, &00, &7E, &00, &00, &00, &00
 EQUB &00, &00, &00, &00, &00, &30, &30, &00
 EQUB &1C, &36, &7F, &63, &63, &63, &7F, &00
 EQUB &7F, &63, &63, &63, &63, &63, &7F, &00
 EQUB &1C, &0C, &0C, &0C, &0C, &0C, &3F, &00
 EQUB &7F, &03, &03, &7F, &60, &60, &7F, &00
 EQUB &7F, &03, &03, &3F, &03, &03, &7F, &00
 EQUB &60, &60, &66, &66, &7F, &06, &06, &00
 EQUB &7F, &60, &60, &7F, &03, &03, &7F, &00
 EQUB &7F, &60, &60, &7F, &63, &63, &7F, &00
 EQUB &7F, &03, &03, &07, &03, &03, &03, &00
 EQUB &7F, &63, &63, &7F, &63, &63, &7F, &00
 EQUB &7F, &63, &63, &7F, &03, &03, &7F, &00
 EQUB &00, &00, &30, &30, &00, &30, &30, &00
 EQUB &00, &00, &7E, &66, &7F, &63, &7F, &60
 EQUB &7F, &60, &60, &7E, &60, &60, &7F, &00
 EQUB &7F, &60, &60, &7E, &60, &60, &7F, &00
 EQUB &18, &0C, &06, &03, &06, &0C, &18, &00
 EQUB &7F, &03, &1F, &18, &00, &18, &18, &00
 EQUB &7F, &60, &60, &60, &60, &7F, &0C, &3C
 EQUB &7F, &63, &63, &63, &7F, &63, &63, &00
 EQUB &7E, &66, &66, &7F, &63, &63, &7F, &00
 EQUB &7F, &60, &60, &60, &60, &60, &7F, &00
 EQUB &7F, &33, &33, &33, &33, &33, &7F, &00
 EQUB &7F, &60, &60, &7E, &60, &60, &7F, &00
 EQUB &7F, &60, &60, &7E, &60, &60, &60, &00
 EQUB &7F, &60, &60, &60, &63, &63, &7F, &00
 EQUB &63, &63, &63, &7F, &63, &63, &63, &00
 EQUB &3F, &0C, &0C, &0C, &0C, &0C, &3F, &00
 EQUB &7F, &0C, &0C, &0C, &0C, &0C, &7C, &00
 EQUB &66, &66, &66, &7F, &63, &63, &63, &00
 EQUB &60, &60, &60, &60, &60, &60, &7F, &00
 EQUB &63, &77, &7F, &6B, &63, &63, &63, &00
 EQUB &63, &73, &7B, &6F, &67, &63, &63, &00
 EQUB &7F, &63, &63, &63, &63, &63, &7F, &00
 EQUB &7F, &63, &63, &7F, &60, &60, &60, &00
 EQUB &7F, &63, &63, &63, &63, &67, &7F, &03
 EQUB &7F, &63, &63, &7F, &66, &66, &66, &00
 EQUB &7F, &60, &60, &7F, &03, &03, &7F, &00
 EQUB &7E, &18, &18, &18, &18, &18, &18, &00
 EQUB &63, &63, &63, &63, &63, &63, &7F, &00
 EQUB &63, &63, &66, &6C, &78, &70, &60, &00
 EQUB &63, &63, &63, &6B, &7F, &77, &63, &00
 EQUB &63, &36, &1C, &1C, &1C, &36, &63, &00
 EQUB &63, &33, &1B, &0F, &07, &03, &03, &00
 EQUB &7F, &06, &0C, &18, &30, &60, &7F, &00
 EQUB &63, &3E, &63, &63, &7F, &63, &63, &00
 EQUB &63, &3E, &63, &63, &63, &63, &7F, &00
 EQUB &63, &00, &63, &63, &63, &63, &7F, &00
 EQUB &7E, &66, &66, &7F, &63, &63, &7F, &60
 EQUB &7F, &60, &60, &7E, &60, &60, &7F, &00
 EQUB &00, &00, &7F, &60, &60, &7F, &0C, &3C
 EQUB &00, &00, &7F, &03, &7F, &63, &7F, &00
 EQUB &60, &60, &7F, &63, &63, &63, &7F, &00
 EQUB &00, &00, &7F, &60, &60, &60, &7F, &00
 EQUB &03, &03, &7F, &63, &63, &63, &7F, &00
 EQUB &00, &00, &7F, &63, &7F, &60, &7F, &00
 EQUB &3F, &30, &30, &7C, &30, &30, &30, &00
 EQUB &00, &00, &7F, &63, &63, &7F, &03, &7F
 EQUB &60, &60, &7F, &63, &63, &63, &63, &00
 EQUB &18, &00, &78, &18, &18, &18, &7E, &00
 EQUB &0C, &00, &3C, &0C, &0C, &0C, &0C, &7C
 EQUB &60, &60, &66, &66, &7F, &63, &63, &00
 EQUB &78, &18, &18, &18, &18, &18, &7E, &00
 EQUB &00, &00, &77, &7F, &6B, &63, &63, &00
 EQUB &00, &00, &7F, &63, &63, &63, &63, &00
 EQUB &00, &00, &7F, &63, &63, &63, &7F, &00
 EQUB &00, &00, &7F, &63, &63, &7F, &60, &60
 EQUB &00, &00, &7F, &63, &63, &7F, &03, &03
 EQUB &00, &00, &7F, &60, &60, &60, &60, &00
 EQUB &00, &00, &7F, &60, &7F, &03, &7F, &00
 EQUB &30, &30, &7C, &30, &30, &30, &3F, &00
 EQUB &00, &00, &63, &63, &63, &63, &7F, &00
 EQUB &00, &00, &63, &66, &6C, &78, &70, &00
 EQUB &00, &00, &63, &63, &6B, &7F, &7F, &00
 EQUB &00, &00, &63, &36, &1C, &36, &63, &00
 EQUB &00, &00, &63, &63, &63, &7F, &03, &7F
 EQUB &00, &00, &7F, &0C, &18, &30, &7F, &00
 EQUB &36, &00, &7F, &03, &7F, &63, &7F, &00
 EQUB &36, &00, &7F, &63, &63, &63, &7F, &00
 EQUB &36, &00, &63, &63, &63, &63, &7F, &00

IF _NTSC

 EQUB &00, &8D, &06, &20, &A9, &4C, &00, &C0

ELIF _PAL

 EQUB &FF, &FF, &FF, &FF, &FF, &4C, &00, &C0

ENDIF

 EQUB &45, &4C, &20, &20, &20, &20, &20, &20
 EQUB &20, &20, &20, &20, &20, &20, &20, &20
 EQUB &00, &00, &00, &00, &38, &04, &01, &07
 EQUB &9C, &2A

\ ******************************************************************************
\
\       Name: Vectors
\       Type: Variable
\   Category: Text
\    Summary: Vectors at the end of the ROM bank
\
\ ******************************************************************************

 EQUW NMI               \ Vector to the NMI handler

 EQUW ResetMMC1_b7      \ Vector to the RESET handler

 EQUW IRQ               \ Vector to the IRQ/BRK handler

\ ******************************************************************************
\
\ Save bank7.bin
\
\ ******************************************************************************

IF _BANK = 7

 PRINT "S.bank7.bin ", ~CODE_BANK_7%, " ", ~P%, " ", ~LOAD_BANK_7%, " ", ~LOAD_BANK_7%
 SAVE "versions/nes/3-assembled-output/bank7.bin", CODE_BANK_7%, P%, LOAD_BANK_7%

ENDIF
