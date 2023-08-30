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
\   * We put the same reset routine (this routine, ResetMMC1) at the start of
\     every ROM bank, so the same routine gets run, whichever ROM bank is mapped
\     to &C000.
\
\ This ResetMMC1 routine is therefore called when the NES starts up, whatever
\ bank configuration ends up being. It then switches ROM bank 7 to &C000 and
\ jumps into bank 7 at the game's entry point BEGIN, which starts the game.
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
                        \     below, i.e. the high byte of BEGIN, which is &C0
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

 JMP BEGIN              \ Jump to BEGIN in bank 7 to start the game

\ ******************************************************************************
\
\       Name: BEGIN
\       Type: Subroutine
\   Category: Start and end
\    Summary: Run through the NES initialisation process, reset the variables
\             and start the game
\
\ ******************************************************************************

.BEGIN

 SEI                    \ Disable interrupts

 CLD                    \ Clear the decimal flag, so we're not in decimal mode
                        \ (this has no effect on the NES, as BCD mode is
                        \ disabled in the 2A03 CPU, but we do this to ensure
                        \ compatibility with 6502-based debuggers)

 LDX #&FF               \ Set the stack pointer to &01FF, which is the standard
 TXS                    \ location for the 6502 stack, so this instruction
                        \ effectively resets the stack

 LDX #0                 \ Set startupDebug = 0 (though this value is never read,
 STX startupDebug       \ so this has no effect)

 LDA #%00010000         \ Configure the PPU by setting PPU_CTRL as follows:
 STA PPU_CTRL           \
                        \   * Bits 0-1    = base nametable address %00 (&2000)
                        \   * Bit 2 clear = increment PPU_ADDR by 1 each time
                        \   * Bit 3 clear = sprite pattern table is at &0000
                        \   * Bit 4 set   = background pattern table is at &1000
                        \   * Bit 5 clear = sprites are 8x8 pixels
                        \   * Bit 6 clear = use PPU 0 (the only option on a NES)
                        \   * Bit 7 clear = disable VBlank NMI generation

 STA ppuCtrlCopy        \ Store the new value of PPU_CTRL in ppuCtrlCopy so we
                        \ can check its value without having to access the PPU

 LDA #%00000000         \ Configure the PPU by setting PPU_MASK as follows:
 STA PPU_MASK           \
                        \   * Bit 0 clear = normal colour (not monochrome)
                        \   * Bit 1 clear = hide leftmost 8 pixels of background
                        \   * Bit 2 clear = hide sprites in leftmost 8 pixels
                        \   * Bit 3 clear = hide background
                        \   * Bit 4 clear = hide sprites
                        \   * Bit 5 clear = do not intensify greens
                        \   * Bit 6 clear = do not intensify blues
                        \   * Bit 7 clear = do not intensify reds

                        \ We now wait for three VBlanks to pass to ensure that 
                        \ the PPU has stabilised after starting up

.sper1

 LDA PPU_STATUS         \ Wait for the first VBlank to pass, which will set bit
 BPL sper1              \ 7 of PPU_STATUS (and reading PPU_STATUS clears bit 7,
                        \ ready for the next VBlank)

.sper2

 LDA PPU_STATUS         \ Wait for the second VBlank to pass
 BPL sper2

.sper3

 LDA PPU_STATUS         \ Wait for the third VBlank to pass
 BPL sper3

 LDA #0                 \ Set K% = 0 (English) to set as the default highlighted
 STA K%                 \ language on the Start screen (see the ChooseLanguage
                        \ routine)

 LDA #60                \ Set K%+1 = 60 to use as the value of the third counter
 STA K%+1               \ when deciding how long to wait on the Start screen
                        \ before auto-playing the demo (see the ChooseLanguage
                        \ routine)

                        \ Fall through into ResetToStartScreen to reset memory
                        \ and show the Start screen

\ ******************************************************************************
\
\       Name: ResetToStartScreen
\       Type: Subroutine
\   Category: Start and end
\    Summary: Reset the stack and the game's variables and show the Start screen
\
\ ******************************************************************************

.ResetToStartScreen

 LDX #&FF               \ Set the stack pointer to &01FF, which is the standard
 TXS                    \ location for the 6502 stack, so this instruction
                        \ effectively resets the stack

 JSR ResetVariables     \ Reset all the RAM (in both the NES and cartridge), as
                        \ it is in an undefined state when the NES is switched
                        \ on, initialise all the game's variables, and switch to
                        \ ROM bank 0

 JMP ShowStartScreen    \ Jump to ShowStartScreen in bank 0 to show the start
                        \ screen and start the game

\ ******************************************************************************
\
\       Name: ResetVariables
\       Type: Subroutine
\   Category: Start and end
\    Summary: Reset all the RAM (in both the NES and cartridge), initialise all
\             the game's variables, and switch to ROM bank 0
\
\ ******************************************************************************

.ResetVariables

 LDA #%00000000         \ Configure the PPU by setting PPU_CTRL as follows:
 STA PPU_CTRL           \
                        \   * Bits 0-1    = base nametable address %00 (&2000)
                        \   * Bit 2 clear = increment PPU_ADDR by 1 each time
                        \   * Bit 3 clear = sprite pattern table is at &0000
                        \   * Bit 4 clear = background pattern table is at &0000
                        \   * Bit 5 clear = sprites are 8x8 pixels
                        \   * Bit 6 clear = use PPU 0 (the only option on a NES)
                        \   * Bit 7 clear = disable VBlank NMI generation

 STA ppuCtrlCopy        \ Store the new value of PPU_CTRL in ppuCtrlCopy so we
                        \ can check its value without having to access the PPU

 STA PPU_MASK           \ Configure the PPU by setting PPU_MASK as follows:
                        \
                        \   * Bit 0 clear = normal colour (not monochrome)
                        \   * Bit 1 clear = hide leftmost 8 pixels of background
                        \   * Bit 2 clear = hide sprites in leftmost 8 pixels
                        \   * Bit 3 clear = hide background
                        \   * Bit 4 clear = hide sprites
                        \   * Bit 5 clear = do not intensify greens
                        \   * Bit 6 clear = do not intensify blues
                        \   * Bit 7 clear = do not intensify reds

 STA setupPPUForIconBar \ Clear bit 7 of setupPPUForIconBar so we do nothing
                        \ when the PPU starts drawing the icon bar

 LDA #%01000000         \ ???
 STA JOY2

 INC &C006              \ Reset the MMC1 mapper, which we can do by writing a
                        \ value with bit 7 set into any address in ROM space
                        \ (i.e. any address from &8000 to &FFFF)
                        \
                        \ The INC instruction does this in a more efficient
                        \ manner than an LDA/STA pair, as it:
                        \
                        \   * Fetches the contents of address &C006, which
                        \     contains the high byte of the JMP destination
                        \     in the JMP BEGIN instruction, i.e. the high byte
                        \     of BEGIN, which is &C0
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

 LDA PPU_STATUS         \ Read the PPU_STATUS register, which clear the VBlank
                        \ latch in bit 7, so the following loops will wait for
                        \ three VBlanks in total

.resv1

 LDA PPU_STATUS         \ Wait for the first VBlank to pass, which will set bit
 BPL resv1              \ 7 of PPU_STATUS (and reading PPU_STATUS clears bit 7,
                        \ ready for the next VBlank)

.resv2

 LDA PPU_STATUS         \ Wait for the second VBlank to pass
 BPL resv2

.resv3

 LDA PPU_STATUS         \ Wait for the third VBlank to pass
 BPL resv3

                        \ We now zero the RAM in the NES, as follows:
                        \
                        \   * Zero page from &0000 to &00FF
                        \
                        \   * The rest of RAM from &0300 to &05FF
                        \
                        \ This clears all of the NES's built-in RAM except for
                        \ page 1, which is used for the stack

 LDA #0                 \ Set A to zero so we can poke it into memory

 TAX                    \ Set X to 0 to use as an index counter as we loop
                        \ through zero page

.resv4

 STA ZP,X               \ Zero the X-th byte of zero page at ZP

 INX                    \ Increment the byte counter

 BNE resv4              \ Loop back until we have zeroed the whole of zero page
                        \ from &0000 to &00FF

 LDA #&03               \ Set SC(1 0) = &0300
 STA SC+1
 LDA #&00
 STA SC

 TXA                    \ Set A = 0 once again so we can poke it into memory

 LDX #3                 \ We now zero three pages of memory at &0300, &0400 and
                        \ &0500, so set a page counter in X

 TAY                    \ Set Y = 0 to use as an index counter for each page of
                        \ memory

.resv5

 STA (SC),Y             \ Zero the Y-th byte of the page at SC(1 0)

 INY                    \ Increment the byte counter

 BNE resv5              \ Loop back until we have zeroed the whole page of
                        \ memory at SC(1 0)

 INC SC+1               \ Increment the high byte of SC(1 0) so it points at the
                        \ next page of memory

 DEX                    \ Decrement the page counter

 BNE resv5              \ Loop back until we have zeroed three pages of memory
                        \ from &0300 to &05FF

 JSR SetupMMC1          \ Configure the MMC1 mapper and page ROM bank 0 into
                        \ memory at &8000

 JSR ResetMusic         \ ???

 LDA #%10000000         \ Set A = 0 and set the C flag
 ASL A

 JSR ResetScreen_b3     \ Reset the screen by clearing down the PPU, setting
                        \ all colours to black, and resetting the screen-related
                        \ variables

 JSR SetDrawingPlaneTo0 \ Set the drawing bitplane to 0

 JSR ResetBuffers       \ Reset the pattern and nametable buffers

 LDA #00000000          \ Set DTW6 = %00000000 so lower case is not enabled
 STA DTW6

 LDA #%11111111         \ Set DTW2 = %11111111 to denote that we are not
 STA DTW2               \ currently printing a word

 LDA #%11111111         \ Set DTW8 = %11111111 to denote ???
 STA DTW8

\ ******************************************************************************
\
\       Name: SetBank0
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Page ROM bank 0 into memory at &8000
\
\ ******************************************************************************

.SetBank0

 LDA #0                 \ Page ROM bank 0 into memory at &8000 and return from
 JMP SetBank            \ the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SetNonZeroBank
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Page a specified ROM bank into memory at &8000, but only if it is
\             non-zero
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The number of the ROM bank to page into memory at &8000
\
\ ******************************************************************************

.SetNonZeroBank

 CMP currentBank        \ If the ROM bank number in A is non-zero, jump to
 BNE SetBank            \ SetBank to page bank A into memory, returning from the
                        \ subroutine using a tail call

 RTS                    \ Otherwise return from the subroutine

\ ******************************************************************************
\
\       Name: ResetBank
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Retrieve a ROM bank number from the stack and page that bank into
\             memory at &8000
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   Stack               The number of the ROM bank to page into memory at &8000
\
\ ******************************************************************************

.ResetBank

 PLA                    \ Retrieve the ROM bank number from the stack into A

                        \ Fall through into SetBank to page ROM bank A into
                        \ memory at &8000

\ ******************************************************************************
\
\       Name: SetBank
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Page a specified ROM bank into memory at &8000
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The number of the ROM bank to page into memory at &8000
\
\ ******************************************************************************

.SetBank

 DEC runningSetBank     \ Decrement runningSetBank from 0 to &FF to denote that
                        \ we are in the process of switching ROM banks
                        \
                        \ This will disable the call to PlayMusic in the NMI
                        \ handler, which instead will increment runningSetBank
                        \ each time it is called

 STA currentBank        \ Store the number of the new ROM bank in currentBank

 STA &FFFF              \ Set the MMC1 PRG bank register (which is mapped to
 LSR A                  \ &C000-&DFFF) to the ROM bank number in A, to map the
 STA &FFFF              \ specified ROM bank into memory at &8000
 LSR A                  \
 STA &FFFF              \ Bit 4 of the ROM bank number will be zero, as A is in
 LSR A                  \ the range 0 to 7, which also ensures that CHR-RAM is
 STA &FFFF              \ enabled
 LSR A
 STA &FFFF

 INC runningSetBank     \ Increment runningSetBank again

 BNE sban1              \ If runningSetBank is non-zero, then this means the NMI
                        \ handler was called while we were switching the ROM
                        \ bank, in which case PlayMusic won't have been called
                        \ in the NMI handler, so jump to sban1 to call the
                        \ PlayMusic routine now instead

 RTS                    \ Return from the subroutine

.sban1

 LDA #0                 \ Set runningSetBank = 0 so the NMI handler knows we are
 STA runningSetBank     \ no longer switching ROM banks

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 TXA                    \ Store X and Y on the stack
 PHA
 TYA
 PHA

 JSR PlayMusic_b6       \ Call the PlayMusic routine to play the background
                        \ music

 PLA                    \ Retrieve X and Y from the stack
 TAY
 PLA
 TAX

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: xTitleScreen
\       Type: Variable
\   Category: Start and end
\    Summary: The text column for the title screen's title for each language
\
\ ******************************************************************************

.xTitleScreen

 EQUB 6                 \ English

 EQUB 6                 \ German

 EQUB 7                 \ French

 EQUB 7                 \ There is no fourth language, so this byte is ignored

\ ******************************************************************************
\
\       Name: xSpaceView
\       Type: Variable
\   Category: Flight
\    Summary: The text column for the space view name for each language
\
\ ******************************************************************************

.xSpaceView

 EQUB 11                \ English

 EQUB 9                 \ German

 EQUB 13                \ French

 EQUB 10                \ There is no fourth language, so this byte is ignored

IF _NTSC

 EQUB &20, &20, &20     \ These bytes appear to be unused
 EQUB &20, &10, &00
 EQUB &C4, &ED, &5E
 EQUB &E5, &22, &E5
 EQUB &22, &00, &00
 EQUB &ED, &5E, &E5
 EQUB &22, &09, &68
 EQUB &00, &00, &00
 EQUB &00

ELIF _PAL

 EQUB &FF, &FF, &FF     \ These bytes appear to be unused
 EQUB &FF, &FF, &FF
 EQUB &FF, &FF, &FF
 EQUB &FF, &FF, &FF
 EQUB &FF, &FF, &FF
 EQUB &FF, &FF, &FF
 EQUB &FF, &FF, &FF
 EQUB &FF, &FF, &FF
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
\       Name: SendBarNamesToPPU
\       Type: Subroutine
\   Category: PPU
\    Summary: Send the nametable entries for the icon bar to the PPU
\
\ ------------------------------------------------------------------------------
\
\ Nametable data for the icon bar is sent to PPU nametables 0 and 1.
\
\ ******************************************************************************

.SendBarNamesToPPU

 SUBTRACT_CYCLES 2131   \ Subtract 2131 from the cycle count

 LDX iconBarOffset      \ Set X to the low byte of iconBarOffset(1 0), to use in
                        \ the following calculations

 STX dataForPPU         \ Set dataForPPU(1 0) = nameBuffer0 + iconBarOffset(1 0)
 LDA iconBarOffset+1    \
 CLC                    \ So dataForPPU(1 0) points to the entry in nametable
 ADC #HI(nameBuffer0)   \ buffer 0 for the start of the icon bar (the addition
 STA dataForPPU+1       \ works because the low byte of nameBuffer0 is 0)

 LDA iconBarOffset+1    \ Set (A X) = PPU_NAME_0 + iconBarOffset(1 0)
 ADC #HI(PPU_NAME_0)    \
                        \ The addition works because the low byte of PPU_NAME_0
                        \ is 0

 STA PPU_ADDR           \ Set PPU_ADDR = (A X)
 STX PPU_ADDR           \              = PPU_NAME_0 + iconBarOffset(1 0)
                        \
                        \ So PPU_ADDR points to the tile entry in the PPU's
                        \ nametable 0 for the start of the icon bar

 LDY #0                 \ We now send the nametable entries for the icon bar to
                        \ the PPU's nametable 0, so set a counter in Y

.ibar1

 LDA (dataForPPU),Y     \ Send the Y-th nametable entry from dataForPPU(1 0) to
 STA PPU_DATA           \ the PPU

 INY                    \ Increment the loop counter

 CPY #2*32              \ Loop back until we have sent 2 rows of 32 tiles
 BNE ibar1

 LDA iconBarOffset+1    \ Set (A X) = PPU_NAME_1 + iconBarOffset(1 0)
 ADC #HI(PPU_NAME_1-1)  \
                        \ The addition works because the low byte of PPU_NAME_1
                        \ is 0 and because the C flag is set (as we just passed
                        \ through the BNE above)

 STA PPU_ADDR           \ Set PPU_ADDR = (A X)
 STX PPU_ADDR           \              = PPU_NAME_1 + iconBarOffset(1 0)
                        \
                        \ So PPU_ADDR points to the tile entry in the PPU's
                        \ nametable 1 for the start of the icon bar

 LDY #0                 \ We now send the nametable entries for the icon bar to
                        \ the PPU's nametable 1, so set a counter in Y

.ibar2

 LDA (dataForPPU),Y     \ Send the Y-th nametable entry from dataForPPU(1 0) to
 STA PPU_DATA           \ the PPU

 INY                    \ Increment the loop counter

 CPY #2*32              \ Loop back until we have sent 2 rows of 32 tiles
 BNE ibar2

 LDA skipBarPatternsPPU \ If bit 7 of skipBarPatternsPPU is set, we do not send
 BMI ibar3              \ the pattern data to the PPU, so jump to ibar3 to skip
                        \ the following

 JMP SendBarPattsToPPU  \ Bit 7 of skipBarPatternsPPU is clear, we do want to
                        \ send the icon bar's pattern data to the PPU, so jump
                        \ to SendBarPattsToPPU to do just that, returning from
                        \ the subroutine using a tail call

.ibar3

 STA barPatternCounter  \ Set barPatternCounter = 128 so the NMI handler does
                        \ not send any more icon bar data to the PPU

 JMP ConsiderSendTiles  \ Jump to ConsiderSendTiles to start sending tiles to
                        \ the PPU, but only if there are enough free cycles

\ ******************************************************************************
\
\       Name: SendBarPatts2ToPPU
\       Type: Subroutine
\   Category: PPU
\    Summary: Send pattern data for tiles 64-127 for the icon bar to the PPU,
\             split across multiple calls to the NMI handler if required
\
\ ------------------------------------------------------------------------------
\
\ Pattern data for icon bar patterns 64 to 127 is sent to PPU pattern table 0
\ only.
\
\ ******************************************************************************

.SendBarPatts2ToPPU

 SUBTRACT_CYCLES 666    \ Subtract 666 from the cycle count

 BMI patt1              \ If the result is negative, jump to patt1 to stop
                        \ sending patterns in this VBlank, as we have run out of
                        \ cycles (we will pick up where we left off in the next
                        \ VBlank)

 JMP patt2              \ The result is positive, so we have enough cycles to
                        \ keep sending PPU data in this VBlank, so jump to patt2
                        \ to send the patterns

.patt1

 ADD_CYCLES 623         \ Add 623 to the cycle count

 JMP RTS1               \ Return from the subroutine (as RTS1 contains an RTS)

.patt2

 LDA #0                 \ Set the low byte of dataForPPU(1 0) to 0
 STA dataForPPU

 LDA barPatternCounter  \ Set Y = (barPatternCounter mod 64) * 8
 ASL A                  \
 ASL A                  \ And set the C flag to the overflow bit
 ASL A                  \
 TAY                    \ The mod 64 part comes from the fact that we shift bits
                        \ 7 and 6 left out of A and discard them, so this is the
                        \ same as (barPatternCounter AND %00111111) * 8

 LDA #%00000001         \ Set addr = %0000001C
 ROL A                  \
 STA addr               \ And clear the C flag (as it gets set to bit 7 of A)
                        \
                        \ So we now have the following:
                        \
                        \   (addr Y) = (2 0) + (barPatternCounter mod 64) * 8
                        \            = &0200 + (barPatternCounter mod 64) * 8
                        \            = 64 * 8 + (barPatternCounter mod 64) * 8
                        \            = (64 + barPatternCounter mod 64) * 8
                        \
                        \ We only call this routine when this is true:
                        \
                        \   64 < barPatternCounter < 128
                        \
                        \ in which case we know that:
                        \
                        \   64 + barPatternCounter mod 64 = barPatternCounter
                        \
                        \ So we if we substitute this into the above, we get:
                        \
                        \   (addr Y) = (10 + 64 + barPatternCounter mod 64) * 8
                        \            = barPatternCounter * 8

 TYA                    \ Set (A X) = (addr Y) + PPU_PATT_0 + &50
 ADC #&50               \           = PPU_PATT_0 + &50 + barPatternCounter * 8
 TAX                    \
                        \ Starting with the low bytes

 LDA addr               \ And then the high bytes (this works because we know
 ADC #HI(PPU_PATT_0)    \ the low byte of PPU_PATT_0 is 0)

 STA PPU_ADDR           \ Set PPU_ADDR = (A X)
 STX PPU_ADDR           \           = PPU_PATT_0 + &50 + barPatternCounter * 8
                        \           = PPU_PATT_0 + (10 + barPatternCounter) * 8
                        \
                        \ So PPU_ADDR points to a pattern in PPU pattern table
                        \ 0, which is at address PPU_PATT_0 in the PPU
                        \
                        \ So it points to pattern 10 when barPatternCounter is
                        \ zero, and points to patterns 10 to 137 as
                        \ barPatternCounter increments from 0 to 127

 LDA iconBarImageHi     \ Set dataForPPU(1 0) = (iconBarImageHi 0) + (addr 0)
 ADC addr               \
 STA dataForPPU+1       \ We know from above that:
                        \
                        \   (addr Y) = &0200 + (barPatternCounter mod 64) * 8
                        \            = 64 * 8 + (barPatternCounter mod 64) * 8
                        \            = (64 + barPatternCounter mod 64) * 8
                        \            = barPatternCounter * 8
                        \
                        \ So this means that:
                        \
                        \   dataForPPU(1 0) + Y
                        \           = (iconBarImageHi 0) + (addr 0) + Y
                        \           = (iconBarImageHi 0) + (addr Y)
                        \           = (iconBarImageHi 0) + barPatternCounter * 8
                        \
                        \ We know that (iconBarImageHi 0) points to the current
                        \ icon bar's image data  aticonBarImage0, iconBarImage1,
                        \ iconBarImage2, iconBarImage3 or iconBarImage4
                        \
                        \ So dataForPPU(1 0) + Y points to the pattern within
                        \ the icon bar's image data that corresponds to pattern
                        \ number barPatternCounter, so this is the data that we
                        \ want to send to the PPU

 LDX #32                \ We now send 32 bytes to the PPU, which equates to four
                        \ tile patterns (as each tile pattern contains eight
                        \ bytes)
                        \
                        \ We send 32 pattern bytes, starting from the Y-th byte
                        \ of dataForPPU(1 0), which corresponds to pattern
                        \ number barPatternCounter in dataForPPU(1 0)

.patt3

 LDA (dataForPPU),Y     \ Send the Y-th byte from dataForPPU(1 0) to the PPU
 STA PPU_DATA

 INY                    \ Increment the index in Y to point to the next byte
                        \ from dataForPPU(1 0)

 DEX                    \ Decrement the loop counter

 BEQ patt4              \ If the loop counter is now zero, jump to patt4 to exit
                        \ the loop

 JMP patt3              \ Loop back to send the next byte

.patt4

 LDA barPatternCounter  \ Add 4 to barPatternCounter, as we just sent four tile
 CLC                    \ patterns
 ADC #4
 STA barPatternCounter

 BPL SendBarPatts2ToPPU \ If barPatternCounter < 128, loop back to the start of
                        \ the routine to send another four pattern tiles

 JMP ConsiderSendTiles  \ Jump to ConsiderSendTiles to start sending tiles to
                        \ the PPU, but only if there are enough free cycles

\ ******************************************************************************
\
\       Name: SendBarPattsToPPU
\       Type: Subroutine
\   Category: PPU
\    Summary: Send pattern data for tiles 0-127 for the icon bar to the PPU,
\             split across multiple calls to the NMI handler if required
\
\ ------------------------------------------------------------------------------
\
\ Pattern data for icon bar patterns 0 to 63 is sent to both pattern table 0 and
\ 1 in the PPU, while pattern data for icon bar patterns 64 to 127 is sent to
\ pattern table 0 only (the latter is done via the SendBarPatts2ToPPU routine).
\
\ Arguments:
\
\   A                   A counter for the icon bar tile patterns to send to the
\                       PPU, which works its way from 0 to 128 as pattern data
\                       is sent to the PPU over successive calls to the NMI
\                       handler
\
\ ******************************************************************************

.SendBarPattsToPPU

 ASL A                  \ If bit 6 of A is set, then 64 < A < 128, so jump to
 BMI SendBarPatts2ToPPU \ SendBarPatts2ToPPU to send patterns 64 to 127 to
                        \ pattern table 0 in the PPU

                        \ If we get here then both bit 6 and bit 7 of A are
                        \ clear, so 0 < A < 64, so we now send patterns 0 to 63
                        \ to pattern table 0 and 1 in the PPU

 SUBTRACT_CYCLES 1297   \ Subtract 1297 from the cycle count

 BMI patn1              \ If the result is negative, jump to patn1 to stop
                        \ sending patterns in this VBlank, as we have run out of
                        \ cycles (we will pick up where we left off in the next
                        \ VBlank)

 JMP patn2              \ The result is positive, so we have enough cycles to
                        \ keep sending PPU data in this VBlank, so jump to patn2
                        \ to send the patterns

.patn1

 ADD_CYCLES 1251        \ Add 1251 to the cycle count

 JMP RTS1               \ Return from the subroutine (as RTS1 contains an RTS)

.patn2

 LDA #0                 \ Set the low byte of dataForPPU(1 0) to 0
 STA dataForPPU

 LDA barPatternCounter  \ Set Y = barPatternCounter * 8
 ASL A                  \
 ASL A                  \ And set the C flag to the overflow bit
 ASL A                  \
 TAY                    \ Note that in the above we shift bits 7 and 6 left out
                        \ out of A and discard them, but because we know that
                        \ 0 < barPatternCounter < 64, this has no effect

 LDA #%00000000         \ Set addr = %0000000C
 ROL A                  \
 STA addr               \ And clear the C flag (as it gets set to bit 7 of A)
                        \
                        \ So we now have the following:
                        \
                        \   (addr Y) = barPatternCounter * 8

 TYA                    \ Set (A X) = (addr Y) + PPU_PATT_0 + &50
 ADC #&50               \           = PPU_PATT_0 + &50 + barPatternCounter * 8
 TAX                    \
                        \ Starting with the low bytes

 LDA addr               \ And then the high bytes (this works because we know
 ADC #HI(PPU_PATT_0)    \ the low byte of PPU_PATT_0 is 0)

 STA PPU_ADDR           \ Set PPU_ADDR = (A X)
 STX PPU_ADDR           \           = PPU_PATT_0 + &50 + barPatternCounter * 8
                        \           = PPU_PATT_0 + (10 + barPatternCounter) * 8
                        \
                        \ So PPU_ADDR points to a pattern in PPU pattern table
                        \ 0, which is at address PPU_PATT_0 in the PPU
                        \
                        \ So it points to pattern 10 when barPatternCounter is
                        \ zero, and points to patterns 10 to 137 as
                        \ barPatternCounter increments from 0 to 127

 LDA iconBarImageHi     \ Set dataForPPU(1 0) = (iconBarImageHi 0) + (addr 0)
 ADC addr               \
 STA dataForPPU+1       \ This means that:
                        \
                        \   dataForPPU(1 0) + Y
                        \           = (iconBarImageHi 0) + (addr 0) + Y
                        \           = (iconBarImageHi 0) + (addr Y)
                        \           = (iconBarImageHi 0) + barPatternCounter * 8
                        \
                        \ We know that (iconBarImageHi 0) points to the current
                        \ icon bar's image data  aticonBarImage0, iconBarImage1,
                        \ iconBarImage2, iconBarImage3 or iconBarImage4
                        \
                        \ So dataForPPU(1 0) + Y points to the pattern within
                        \ the icon bar's image data that corresponds to pattern
                        \ number barPatternCounter, so this is the data that we
                        \ want to send to the PPU

 LDX #32                \ We now send 32 bytes to the PPU, which equates to four
                        \ tile patterns (as each tile pattern contains eight
                        \ bytes)
                        \
                        \ We send 32 pattern bytes, starting from the Y-th byte
                        \ of dataForPPU(1 0), which corresponds to pattern
                        \ number barPatternCounter in dataForPPU(1 0)

.patn3

 LDA (dataForPPU),Y     \ Send the Y-th byte from dataForPPU(1 0) to the PPU
 STA PPU_DATA

 INY                    \ Increment the index in Y to point to the next byte
                        \ from dataForPPU(1 0)

 DEX                    \ Decrement the loop counter

 BEQ patn4              \ If the loop counter is now zero, jump to patn4 to exit
                        \ the loop

 JMP patn3              \ Loop back to send the next byte

.patn4

 LDA #0                 \ Set the low byte of dataForPPU(1 0) to 0
 STA dataForPPU

 LDA barPatternCounter  \ Set Y = barPatternCounter * 8
 ASL A                  \
 ASL A                  \ And set the C flag to the overflow bit
 ASL A                  \
 TAY                    \ Note that in the above we shift bits 7 and 6 left out
                        \ out of A and discard them, but because we know that
                        \ 0 < barPatternCounter < 64, this has no effect

 LDA #%00000000         \ Set addr = %0000000C
 ROL A                  \
 STA addr               \ And clear the C flag (as it gets set to bit 7 of A)
                        \
                        \ So we now have the following:
                        \
                        \   (addr Y) = barPatternCounter * 8

 TYA                    \ Set (A X) = (addr Y) + PPU_PATT_1 + &50
 ADC #&50               \           = PPU_PATT_1 + &50 + barPatternCounter * 8
 TAX                    \
                        \ Starting with the low bytes

 LDA addr               \ And then the high bytes (this works because we know
 ADC #HI(PPU_PATT_1)    \ the low byte of PPU_PATT_1 is 0)

 STA PPU_ADDR           \ Set PPU_ADDR = (A X)
 STX PPU_ADDR           \           = PPU_PATT_1 + &50 + barPatternCounter * 8
                        \           = PPU_PATT_1 + (10 + barPatternCounter) * 8
                        \
                        \ So PPU_ADDR points to a pattern in PPU pattern table
                        \ 1, which is at address PPU_PATT_1 in the PPU
                        \
                        \ So it points to pattern 10 when barPatternCounter is
                        \ zero, and points to patterns 10 to 137 as
                        \ barPatternCounter increments from 0 to 127

 LDA iconBarImageHi     \ Set dataForPPU(1 0) = (iconBarImageHi 0) + (addr 0)
 ADC addr               \
 STA dataForPPU+1       \ This means that:
                        \
                        \   dataForPPU(1 0) + Y
                        \           = (iconBarImageHi 0) + (addr 0) + Y
                        \           = (iconBarImageHi 0) + (addr Y)
                        \           = (iconBarImageHi 0) + barPatternCounter * 8
                        \
                        \ We know that (iconBarImageHi 0) points to the current
                        \ icon bar's image data  aticonBarImage0, iconBarImage1,
                        \ iconBarImage2, iconBarImage3 or iconBarImage4
                        \
                        \ So dataForPPU(1 0) + Y points to the pattern within
                        \ the icon bar's image data that corresponds to pattern
                        \ number barPatternCounter, so this is the data that we
                        \ want to send to the PPU

 LDX #32                \ We now send 32 bytes to the PPU, which equates to four
                        \ tile patterns (as each tile pattern contains eight
                        \ bytes)
                        \
                        \ We send 32 pattern bytes, starting from the Y-th byte
                        \ of dataForPPU(1 0), which corresponds to pattern
                        \ number barPatternCounter in dataForPPU(1 0)

.patn5

 LDA (dataForPPU),Y     \ Send the Y-th byte from dataForPPU(1 0) to the PPU
 STA PPU_DATA

 INY                    \ Increment the index in Y to point to the next byte
                        \ from dataForPPU(1 0)

 DEX                    \ Decrement the loop counter

 BEQ patn6              \ If the loop counter is now zero, jump to patn6 to exit
                        \ the loop

 JMP patn5              \ Loop back to send the next byte

.patn6

 LDA barPatternCounter  \ Add 4 to barPatternCounter, as we just sent four tile
 CLC                    \ patterns
 ADC #4
 STA barPatternCounter

 JMP SendBarPattsToPPU  \ Loop back to the start of the routine to send another
                        \ four pattern tiles to both PPU pattern tables

\ ******************************************************************************
\
\       Name: SendBarPattsToPPUS
\       Type: Subroutine
\   Category: PPU
\    Summary: Send the tile pattern data for the icon bar to the PPU (this is a
\             jump so we can call this routine using a branch instruction)
\
\ ******************************************************************************

.SendBarPattsToPPUS

 JMP SendBarPattsToPPU  \ Jump to SendBarPattsToPPU to send the tile pattern
                        \ data for the icon bar to the PPU, returning from the
                        \ subroutine using a tail call

\ ******************************************************************************
\
\       Name: SendBarNamesToPPUS
\       Type: Subroutine
\   Category: PPU
\    Summary: Send the nametable entries for the icon bar to the PPU (this is a
\             jump so we can call this routine using a branch instruction)
\
\ ******************************************************************************

.SendBarNamesToPPUS

 JMP SendBarNamesToPPU  \ Jump to SendBarNamesToPPU to send the nametable
                        \ entries for the icon bar to the PPU, returning from
                        \ the subroutine using a tail call

\ ******************************************************************************
\
\       Name: ConsiderSendTiles
\       Type: Subroutine
\   Category: PPU
\    Summary: If there are enough free cycles, move on to the next stage of
\             sending tile patterns to the PPU
\
\ ------------------------------------------------------------------------------
\
\ Other entry points:
\
\   RTS1                Contains an RTS
\
\ ******************************************************************************

.ConsiderSendTiles

 LDX nmiBitplane        \ Set X to the current NMI bitplane (i.e. the bitplane
                        \ for which we are sending data to the PPU in the NMI
                        \ handler)

 LDA bitplaneFlags,X    \ Set A to the bitplane flags for the NMI bitplane

 AND #%00010000         \ If bit 4 of A is clear, then we are not currently in
 BEQ RTS1               \ the process of sending tile data to the PPU for this
                        \ bitplane, so return from the subroutine (as RTS1
                        \ contains an RTS)

 SUBTRACT_CYCLES 42     \ Subtract 42 from the cycle count

 BMI next1              \ If the result is negative, jump to next1 to stop
                        \ sending patterns in this VBlank, as we have run out of
                        \ cycles (we will pick up where we left off in the next
                        \ VBlank)

 JMP next2              \ The result is positive, so we have enough cycles to
                        \ keep sending PPU data in this VBlank, so jump to
                        \ SendPatternsToPPU via next2 to move on to the next
                        \ stage of sending tile patterns to the PPU

.next1

 ADD_CYCLES 65521       \ Add 65521 to the cycle count (i.e. subtract 15) ???

 JMP RTS1               \ Return from the subroutine (as RTS1 contains an RTS)

.next2

 JMP SendPatternsToPPU  \ Jump to SendPatternsToPPU to move on to the next stage
                        \ of sending tile patterns to the PPU

.RTS1

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: SendBuffersToPPU (Part 1 of 3)
\       Type: Subroutine
\   Category: PPU
\    Summary: Send the icon bar nametable and palette data to the PPU, if it has
\             changed, before moving on to tile data in part 2
\
\ ******************************************************************************

.SendBuffersToPPU

 LDA barPatternCounter  \ If barPatternCounter = 0, then we need to send the
 BEQ SendBarNamesToPPUS \ nametable entries for the icon bar to the PPU, so
                        \ jump to SendBarNamesToPPU via SendBarNamesToPPUS,
                        \ returning from the subroutine using a tail call

 BPL SendBarPattsToPPUS \ If 0 < barPatternCounter < 128, then we need to send
                        \ the pattern data for the icon bar to the PPU, so
                        \ jump to SendBarPattsToPPU via SendBarPattsToPPUS,
                        \ returning from the subroutine using a tail call

                        \ If we get here then barPatternCounter >= 128, so we
                        \ do not need to send any icon bar data to the PPU

                        \ Fall through into part 2 to look at sending tile data
                        \ to the PPU for the rest of the screen

\ ******************************************************************************
\
\       Name: SendBuffersToPPU (Part 2 of 3)
\       Type: Subroutine
\   Category: PPU
\    Summary: If we are already sending tile data to the PPU, pick up where we
\             left off, otherwise jump to part 3 to check for new data to send
\
\ ******************************************************************************

 LDX nmiBitplane        \ Set X to the current NMI bitplane (i.e. the bitplane
                        \ for which we are sending data to the PPU in the NMI
                        \ handler)

 LDA bitplaneFlags,X    \ Set A to the bitplane flags for the NMI bitplane

 AND #%00010000         \ If bit 4 of A is clear, then we are not currently in
 BEQ sbuf7              \ the process of sending tile data to the PPU for this
                        \ bitplane, so jump to sbuf7 in part 3 to start sending
                        \ tile data

                        \ If we get here then we are already in the process of
                        \ sending tile data to the PPU, split across multiple
                        \ calls to the NMI handler, so before we can consider
                        \ sending data data for anything else, we need to finish
                        \ the job that we already started

 SUBTRACT_CYCLES 56     \ Subtract 56 from the cycle count

 TXA                    \ Set Y to the inverse of X, so Y is the opposite
 EOR #1                 \ bitplane to the NMI bitplane
 TAY

 LDA bitplaneFlags,Y    \ Set A to the bitplane flags for the opposite plane
                        \ to the NMI bitplane

 AND #%10100000         \ If bitplanes are enabled then enableBitplanes = 1, so
 ORA enableBitplanes    \ this jumps to sbuf2 if any of the following are true
 CMP #%10000001         \ for the opposite bitplane:
 BNE sbuf2              \
                        \   * Bitplanes are disabled
                        \
                        \   * Bit 5 is set (we have already sent all the data
                        \     to the PPU for the opposite bitplane)
                        \
                        \   * Bit 7 is clear (do not send data to the PPU for
                        \     the opposite bitplane)
                        \
                        \ If any of these are true, we jump to SendPatternsToPPU
                        \ via sbuf2 to continue sending tiles to the PPU for the
                        \ current bitplane

                        \ If we get here then the following are true:
                        \
                        \   * Bitplanes are enabled
                        \
                        \   * We have not sent all the data for the opposite
                        \     bitplane to the PPU
                        \
                        \   * The opposite bitplane is configured to be sent to
                        \     the PPU

 LDA lastPatternTile,X  \ Set A to the number of the last pattern number to send
                        \ for this bitplane

 BNE sbuf1              \ If it it zero (i.e. we have no free tiles), then set
 LDA #255               \ A to 255, so we can use A as an upper limit

.sbuf1

 CMP sendingPattTile,X  \ If A >= sendingPattTile, then the number of the last
 BEQ sbuf3              \ tile to send is bigger than the number of the tile for
 BCS sbuf3              \ which we are currently sending pattern data to the PPU
                        \ for this bitplane, which means there is still some
                        \ pattern data to send before we have processed all the
                        \ tiles, so jump to sbuf3
                        \
                        \ Ths BEQ appears to be superfluous here as BCS will
                        \ catch an equality

                        \ If we get here then we have finished sending pattern
                        \ data to the PPU, so we now move on to the next stage
                        \ by jumping to SendPatternsToPPU after adjusting the
                        \ cycle count

 SUBTRACT_CYCLES 32     \ Subtract 32 from the cycle count

.sbuf2

 JMP SendPatternsToPPU  \ Jump to SendPatternsToPPU to continue sending tile
                        \ data to the PPU

.sbuf3

                        \ If we get here then the following are true:
                        \
                        \   * Bitplanes are enabled
                        \
                        \   * We have not sent all the data for the opposite
                        \     bitplane to the PPU
                        \
                        \   * The opposite bitplane is configured to be sent to
                        \     the PPU
                        \
                        \   * We are in the process of sending data for the
                        \     current bitplane to the PPU
                        \
                        \   * We still have pattern data to send to the PPU for
                        \     this bitplane

 LDA bitplaneFlags,X    \ Set A to the bitplane flags for the NMI bitplane

 ASL A                  \ Shift A left by one place, so bit 7 becomes bit 6 of
                        \ the original flags, and so on

 BPL RTS1               \ If bit 6 of the bitplane flags is clear, then this
                        \ bitplane is only configured to send pattern data and
                        \ not nametable data, and to stop sending the pattern
                        \ data if the other bitplane is ready to be sent
                        \
                        \ This is is the case here as we only jump to sbuf3 if
                        \ the other bitplane is configured to send data to the
                        \ PPU, so we stop sending the pattern data for this
                        \ bitplane by returning from the subroutine (as RTS1
                        \ contains an RTS)

 LDY lastNameTile,X     \ Set Y to the number of the last tile we need to send
                        \ for this bitplane, divided by 8

 AND #%00001000         \ If bit 2 of the bitplane flags is set (as A was
 BEQ sbuf4              \ shifted left above), set Y = 128 to override the last
 LDY #128               \ tile number with 128, which means send all tiles (as
                        \ 128 * 8 = 1024 and 1024 is the buffer size)

.sbuf4

 TYA                    \ Set A = Y - sendingNameTile
 SEC                    \       = lastNameTile - sendingNameTile
 SBC sendingNameTile,X  \
                        \ So this is the number of tiles for which we still have
                        \ to send nametable entries, as sendingNameTile is the
                        \ number of the tile for which we are currently sending
                        \ nametable entries to the PPU, divided by 8

 CMP #48                \ If A < 48, then we have fewer than 48 * 8 = 384
 BCC sbuf6              \ nametable entries to send, so jump to sbuf6 to swap
                        \ the hidden and visible bitplanes before sending the
                        \ next batch of tiles ???

 SUBTRACT_CYCLES 60     \ Subtract 60 from the cycle count

.sbuf5

 JMP SendPatternsToPPU  \ Jump to SendPatternsToPPU to continue sending tile
                        \ data to the PPU

.sbuf6

 LDA ppuCtrlCopy        \ If ppuCtrlCopy is zero then we are not worried about
 BEQ sbuf5              \ keeping PPU writes within VBlank, so jump to sbuf5 to
                        \ skip the following bitplane flip and crack on with
                        \ sending data to the PPU

 SUBTRACT_CYCLES 134    \ Subtract 134 from the cycle count

 LDA enableBitplanes    \ If bitplanes are enabled then enableBitplanes will be
 EOR hiddenBitplane     \ 1, so this flips hiddenBitplane between 0 and 1 when
 STA hiddenBitplane     \ bitplanes are enabled, and does nothing when they
                        \ aren't (so it effectively swaps the hidden and visible
                        \ bitplanes)

 JSR SetPaletteForView  \ Set the correct background and sprite palettes for
                        \ the current view and (if this is the space view) the
                        \ hidden bit plane

 JMP SendPatternsToPPU  \ Jump to SendPatternsToPPU to continue sending tile
                        \ data to the PPU

\ ******************************************************************************
\
\       Name: SendBuffersToPPU (Part 3 of 3)
\       Type: Subroutine
\   Category: PPU
\    Summary: If we need to send tile nametable and pattern data to the PPU for
\             either bitplane, start doing just that
\
\ ******************************************************************************

.sbuf7

                        \ If we get here then we are not currently sending tile
                        \ data to the PPU, so now we check which bitplane is
                        \ configured to be sent, configure the NMI handler to
                        \ send data for that bitplane to the PPU (over multiple
                        \ calls to the NMI handler, if required), and we also
                        \ hide the bitplane we are updating from the screen, so
                        \ we don't corrupt the screen while updating it

 SUBTRACT_CYCLES 298    \ Subtract 298 from the cycle count

 LDA bitplaneFlags      \ Set A to the bitplane flags for bitplane 0

 AND #%10100000         \ This jumps to sbuf8 if any of the following are true
 CMP #%10000000         \ for bitplane 0:
 BNE sbuf8              \
                        \   * Bit 5 is set (we have already sent all the data
                        \     to the PPU for bitplane 0)
                        \
                        \   * Bit 7 is clear (do not send data to the PPU for
                        \     bitplane 0)
                        \
                        \ If any of these are true, we jump to sbuf8 to consider
                        \ sending bitplane 1 instead

                        \ If we get here then we have not already send all the
                        \ data to the PPU for bitplane 0, and bitplane 0 is
                        \ configured to be sent, so we start sending data for
                        \ bitplane 0 to the PPU

 NOP                    \ This looks like code that has been removed
 NOP
 NOP
 NOP
 NOP

 LDX #0                 \ Set X = 0 and jump to sbuf11 to start sending tile
 JMP sbuf11             \ data to the PPU for bitplane 0

.sbuf8

 LDA bitplaneFlags+1    \ Set A to the bitplane flags for bitplane 1

 AND #%10100000         \ This jumps to sbuf10 if both of the following are true
 CMP #%10000000         \ for bitplane 1:
 BEQ sbuf10             \
                        \   * Bit 5 is clear (we have not already sent all the
                        \     data to the PPU for bitplane 1)
                        \
                        \   * Bit 7 is set (send data to the PPU for bitplane 1)
                        \
                        \ If both of these are true then jump to sbuf10 to start
                        \ sending data for bitplane 1 to the PPU

                        \ If we get here then we don't need to send either
                        \ bitplane to the PPU, so we update the cycle count and
                        \ return from the subroutine

 ADD_CYCLES_CLC 223     \ Add 223 to the cycle count

 RTS                    \ Return from the subroutine

.sbuf9

 ADD_CYCLES_CLC 45      \ Add 45 to the cycle count

 JMP SendTilesToPPU     \ Jump to SendTilesToPPU to set up the variables for
                        \ sending tile data to the PPU, and then send them

.sbuf10

 LDX #1                 \ Set X = 1 so we start sending tile data to the PPU
                        \ for bitplane 1

.sbuf11

                        \ If we get here then we are about to start sending tile
                        \ data to the PPU for bitplane X, so we set nmiBitplane
                        \ to X (so the NMI handler sends data to the PPU for
                        \ that bitplane), and we also set hiddenBitplane to X,
                        \ so that the bitplane we are updating is hidden from
                        \ view (and the other bitplane is shown on-screen)
                        \
                        \ So this is the part of the code that swaps animation
                        \ frames when drawing the space view

 STX nmiBitplane        \ Set the NMI bitplane to the value in X, which will
                        \ be 0 or 1 depending on the value of the bitplane flags
                        \ we tested above

 LDA enableBitplanes    \ If enableBitplanes = 0 then bitplanes are not enabled
 BEQ sbuf9              \ (we must be on the Start screen), so jump to sbuf9 to
                        \ update the cycle count and skip the following two
                        \ instructions

 STX hiddenBitplane     \ Set the hidden bitplane to be the same as the NMI
                        \ bitplane, so the rest of the NMI handler update the
                        \ hidden bitplane (we only want to update the hidden
                        \ bitplane, to avoid messing up the screen)

 JSR SetPaletteForView  \ Set the correct background and sprite palettes for
                        \ the current view and (if this is the space view) the
                        \ hidden bitplane

                        \ Fall through into SendTilesToPPU to set up the
                        \ variables for sending tile data to the PPU, and then
                        \ send them

\ ******************************************************************************
\
\       Name: SendTilesToPPU
\       Type: Subroutine
\   Category: PPU
\    Summary: Set up the variables needed to send the tile nametable and pattern
\             data to the PPU, and then send them
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X                   The current value of nmiBitplane
\
\ ******************************************************************************

.SendTilesToPPU

 TXA                    \ Set nmiBitplane8 = X << 3
 ASL A                  \                  = nmiBitplane * 8
 ASL A                  \
 ASL A                  \ So nmiBitplane has the following values:
 STA nmiBitplane8       \
                        \   * 0 when nmiBitplane is 0
                        \
                        \   * 8 when nmiBitplane is 1

 LSR A                  \ Set A = nmiBitplane << 2
                        \
                        \ So A has the following values:
                        \
                        \   * 0 when nmiBitplane is 0
                        \
                        \   * 4 when nmiBitplane is 1

 ORA #HI(PPU_NAME_0)    \ Set the high byte of ppuNametableAddr(1 0) to
 STA ppuNametableAddr+1 \ HI(PPU_NAME_0) + A, which will be:
                        \
                        \   * HI(PPU_NAME_0)         when nmiBitplane is 0
                        \
                        \   * HI(PPU_NAME_0) + &04   when nmiBitplane is 1

 LDA #HI(PPU_PATT_1)    \ Set ppuPatternTableHi to point to the high byte of
 STA ppuPatternTableHi  \ pattern table 1 in the PPU

 LDA #0                 \ Zero the low byte of ppuNametableAddr(1 0), so we end
 STA ppuNametableAddr   \ up with ppuNametableAddr(1 0) set to:
                        \
                        \   * PPU_NAME_0 (&2000)     when nmiBitplane = 0
                        \
                        \   * PPU_NAME_1 (&2400)     when nmiBitplane = 1
                        \
                        \ So ppuNametableAddr(1 0) points to the correct PPU
                        \ nametable address for this bitplane

 LDA firstNametableTile \ Set sendingNameTile for this bitplane to the value of
 STA sendingNameTile,X  \ firstNametableTile, which contains the number of the
                        \ first tile to send to the PPU nametable

 STA clearingNameTile,X \ Set clearingNameTile for this bitplane to the same
                        \ value, so we start to clear tiles from the same point
                        \ once they have been sent to the PPU nametable

 LDA firstPatternTile   \ Set sendingPattTile for this bitplane to the value of
 STA sendingPattTile,X  \ firstPatternTile, which contains the number of the
                        \ first tile to send to the PPU pattern table

 STA clearingPattTile,X \ Set clearingPattTile for this bitplane to the same
                        \ value, so we start to clear tiles from the same point
                        \ once they have been sent to the PPU pattern table

 LDA bitplaneFlags,X    \ Set bit 4 in the bitplane flags to indicate that we
 ORA #%00010000         \ are now sending tile data to the PPU in the NMI
 STA bitplaneFlags,X    \ handler (so we can detect this in the next VBlank if
                        \ we have to split the process across multiple VBlanks)

 LDA #0                 \ Set (addr A) to sendingPattTile for this bitplane,
 STA addr               \ which we just set to the number of the first tile to
 LDA sendingPattTile,X  \ send to the PPU pattern table

 ASL A                  \ Set (addr A) = (pattBufferHiAddr 0) + (addr A) * 8
 ROL addr               \              = pattBufferX + sendingPattTile * 8
 ASL A                  \
 ROL addr               \ Starting with the low bytes
 ASL A                  \
                        \ In the above, pattBufferX is either pattBuffer0 or
                        \ pattBuffer1, depending on the bitplane in X, as these
                        \ are the values stored in the pattBufferHiAddr variable

 STA pattTileBuffLo,X   \ Store the low byte in pattTileBuffLo for this bitplane

 LDA addr               \ We now add the high bytes, storing the result in
 ROL A                  \ pattTileBuffHi for this bitplane
 ADC pattBufferHiAddr,X \
 STA pattTileBuffHi,X   \ So we now have the following for this bitplane:
                        \
                        \   (pattTileBuffHi pattTileBuffLo) =
                        \                      pattBufferX + sendingPattTile * 8
                        \
                        \ which points to the data for tile sendingPattTile in
                        \ the pattern buffer for bitplane X

 LDA #0                 \ Set (addr A) to sendingNameTile for this bitplane,
 STA addr               \ which we just set to the number of the first tile to
 LDA sendingNameTile,X  \ send to the PPU nametable

 ASL A                  \ Set (addr A) = (nameBufferHiAddr 0) + (addr A) * 8
 ROL addr               \              = nameBufferX + sendingNameTile * 8
 ASL A                  \
 ROL addr               \ Starting with the low bytes
 ASL A                  \
                        \ In the above, pattBufferX is either pattBuffer0 or
                        \ pattBuffer1, depending on the bitplane in X, as these
                        \ are the values stored in the pattBufferHiAddr variable

 STA nameTileBuffLo,X   \ Store the low byte in nameTileBuffLo for this bitplane

 ROL addr               \ We now add the high bytes, storing the result in
 LDA addr               \ nameTileBuffHi for this bitplane
 ADC nameBufferHiAddr,X \
 STA nameTileBuffHi,X   \ So we now have the following for this bitplane:
                        \
                        \   (nameTileBuffHi nameTileBuffLo) =
                        \                      nameBufferX + sendingNameTile * 8
                        \
                        \ which points to the data for tile sendingNameTile in
                        \ the nametable buffer for bitplane X

 LDA ppuNametableAddr+1 \ Set the high byte of the following calculation:
 SEC                    \
 SBC nameBufferHiAddr,X \   (ppuToBuffNameHi 0) = (ppuNametableAddr+1 0)
 STA ppuToBuffNameHi,X  \                          - (nameBufferHiAddr 0)
                        \
                        \ So ppuToBuffNameHi for this bitplane contains a high
                        \ byte that we can add to a nametable buffer address to
                        \ get the corresponding address in the PPU nametable

 JMP SendPatternsToPPU  \ Now that we have set up all the variables needed, we
                        \ can jump to SendPatternsToPPU to move on to the next
                        \ stage of sending tile patterns to the PPU

\ ******************************************************************************
\
\       Name: SendPatternsToPPU (Part 1 of 6)
\       Type: Subroutine
\   Category: PPU
\    Summary: Calculate how many tile patterns we need to send and jump to the
\             most efficient routine for sending them
\
\ ******************************************************************************

.spat1

 ADD_CYCLES_CLC 4       \ Add 4 to the cycle count

 JMP SendNametableNow   \ Jump to SendNametableNow to start sending nametable
                        \ entries to the PPU immediately

.spat2

 JMP spat21             \ Jump down to part 4 to start sending pattern data
                        \ until we run out of cycles

.SendPatternsToPPU

 SUBTRACT_CYCLES 182    \ Subtract 182 from the cycle count

 BMI spat3              \ If the result is negative, jump to spat3 to stop
                        \ sending PPU data in this VBlank, as we have run out of
                        \ cycles (we will pick up where we left off in the next
                        \ VBlank)

 JMP spat4              \ The result is positive, so we have enough cycles to
                        \ keep sending PPU data in this VBlank, so jump to spat4
                        \ to start sending tile pattern data to the PPU

.spat3

 ADD_CYCLES 141         \ Add 141 to the cycle count

 JMP RTS1               \ Return from the subroutine (as RTS1 contains an RTS)

.spat4

 LDA lastPatternTile,X  \ Set A to the number of the last pattern number to send
                        \ for this bitplane

 BNE spat5              \ If it it zero (i.e. we have no free tiles), then set
 LDA #255               \ A to 255, so we can use A as an upper limit

.spat5

 STA lastTile           \ Store the result in lastTile, as we want to stop
                        \ sending tiles once we have reached this tile

 LDA ppuNametableAddr+1 \ Set the high byte of the following calculation:
 SEC                    \
 SBC nameBufferHiAddr,X \   (ppuToBuffNameHi 0) = (ppuNametableAddr+1 0)
 STA ppuToBuffNameHi,X  \                          - (nameBufferHiAddr 0)
                        \
                        \ So ppuToBuffNameHi for this bitplane contains a high
                        \ byte that we can add to a PPU nametable addredd to get
                        \ the corresponding address in the nametable buffer

 LDY pattTileBuffLo,X   \ Set Y to the low byte of the address of the pattern
                        \ buffer for sendingPattTile in bitplane X (i.e. the
                        \ address of the next tile we want to send)
                        \
                        \ We can use this as an index when copying data from
                        \ the pattern buffer, as we know the pattern buffers
                        \ start on page boundaries, so the low byte of the
                        \ address of the the start of each buffer is zero

 LDA pattTileBuffHi,X   \ Set the high byte of dataForPPU(1 0) to the high byte
 STA dataForPPU+1       \ of the pattern buffer for this bitplane, as we want
                        \ to copy data from the pattern buffer to the PPU

 LDA sendingPattTile,X  \ Set A to the number of the next tile we want to send
                        \ from the pattern buffer for this bitplane

 STA pattTileCounter    \ Store the number in pattTileCounter, so we can keep
                        \ track of which tile we are sending

 SEC                    \ Set A = A - lastTile
 SBC lastTile           \       = pattTileCounter - lastTile

 BCS spat1              \ If pattTileCounter >= lastTile then we have already
                        \ sent all the tile patterns (right up to the last
                        \ tile), so jump to spat1 to move on to sending the
                        \ nametable entries

 LDX ppuCtrlCopy        \ If ppuCtrlCopy is zero then we are not worried about
 BEQ spat6              \ keeping PPU writes within VBlank, so jump to spat6 to
                        \ skip the following and crack on with sending as much
                        \ pattern data as we can to the PPU

                        \ The above subtraction underflowed, as it cleared the C
                        \ flag, so the result in A is a negative number and we
                        \ should interpret &BF in the following as a signed
                        \ integer, -65

 CMP #&BF               \ If A < &BF
 BCC spat2              \
                        \ i.e. pattTileCounter - lastTile < -65
                        \      lastTile - pattTileCounter > 65
                        \
                        \ Then we have 65 or more patterns to sent to the PPU,
                        \ so jump to part 4 (via spat2) to send them until we
                        \ run out of cycles, without bothering to check for the
                        \ last tile (as we have more tiles to send than we can
                        \ fit into one VBlank)
                        \
                        \ Otherwise we have 64 or fewer tile patterns to send,
                        \ so fall through into part 2 to send them one tile at a
                        \ time, checking each one is the last tile yo see if
                        \ it's the last tile

\ ******************************************************************************
\
\       Name: SendPatternsToPPU (Part 2 of 6)
\       Type: Subroutine
\   Category: PPU
\    Summary: Configure variables for sending data to the PPU one tile at a time
\             with checks
\
\ ******************************************************************************

.spat6

 LDA pattTileCounter    \ Set (addr A) = pattTileCounter
 LDX #0
 STX addr

 STX dataForPPU         \ Zero the low byte of dataForPPU(1 0)
                        \
                        \ We set the high byte in part 1, so dataForPPU(1 0) now
                        \ contains the address of the pattern buffer for this
                        \ bitplane

 ASL A                  \ Set (addr X) = (addr A) << 4
 ROL addr               \              = pattTileCounter * 16
 ASL A
 ROL addr
 ASL A
 ROL addr
 ASL A
 TAX

 LDA addr               \ Set (A X) = (ppuPatternTableHi 0) + (addr X)
 ROL A                  \         = (ppuPatternTableHi 0) + pattTileCounter * 16
 ADC ppuPatternTableHi  \
                        \ ppuPatternTableHi contains the high byte of the
                        \ address of the PPU pattern table to which we send
                        \ dynamic tile patterns; it contains HI(PPU_PATT_1),
                        \ so (A X) now contains the address in PPU pattern
                        \ table 1 for tile number pattTileCounter (as there are
                        \ 16 bytes in the pattern table for each tile)

                        \ We now set both PPU_ADDR and addr(1 0) to the
                        \ following:
                        \
                        \   * (A X)         when nmiBitplane is 0
                        \
                        \   * (A X) + 8     when nmiBitplane is 1
                        \
                        \ We add 8 in the second example to point the address to
                        \ bitplane 1, as the PPU interleaves each tile pattern
                        \ as 8 bytes of one bitplane followed by 8 bytes of the
                        \ other bitplane, so bitplane 1's data always appears 8
                        \ bytes after the corresponding bitplane 0 data

 STA PPU_ADDR           \ Set the high byte of PPU_ADDR to A

 STA addr+1             \ Set the high byte of addr to A

 TXA                    \ Set A = X + nmiBitplane8
 ADC nmiBitplane8       \       = X + nmiBitplane * 8
                        \
                        \ So we add 8 to the low byte when we are writing to
                        \ bit plane 1, otherwise we leave the low byte alone

 STA PPU_ADDR           \ Set the low byte of PPU_ADDR to A

 STA addr               \ Set the high byte of addr to A

                        \ So PPU_ADDR and addr(1 0) both contain the PPU
                        \ address to which we should send our pattern data for
                        \ this bitplane

 JMP spat9              \ Jump into part 3 to send pattern data to the PPU

\ ******************************************************************************
\
\       Name: SendPatternsToPPU (Part 3 of 6)
\       Type: Subroutine
\   Category: PPU
\    Summary: Send pattern data to the PPU for one tile at a time, checking
\             after each one to see if is the last tile
\
\ ******************************************************************************

.spat7

 INC dataForPPU+1       \ Increment the high byte of dataForPPU(1 0) to point to
                        \ the start of the next page in memory

 SUBTRACT_CYCLES 27     \ Subtract 27 from the cycle count

 JMP spat13             \ Jump down to spat13 to continue sending data to the
                        \ PPU

.spat8

 JMP spat17             \ Jump down to spat17 to move on to sending nametable
                        \ entries to the PPU

.spat9

                        \ This is the entry point for part 3

 LDX pattTileCounter    \ We will now work our way through tiles, sending data
                        \ each one, so set a counter in X that starts with the
                        \ number of the next tile to send to the PPU

.spat10

 SUBTRACT_CYCLES 400    \ Subtract 400 from the cycle count

 BMI spat11             \ If the result is negative, jump to spat11 to stop
                        \ sending PPU data in this VBlank, as we have run out of
                        \ cycles (we will pick up where we left off in the next
                        \ VBlank)

 JMP spat12             \ The result is positive, so we have enough cycles to
                        \ keep sending PPU data in this VBlank, so jump to
                        \ spat12 to send pattern data to the PPU

.spat11

 ADD_CYCLES 359         \ Add 359 to the cycle count

 JMP spat30             \ Jump to part 6 to save progress for use in the next
                        \ VBlank and return from the subroutine

.spat12

                        \ If we get here then we send pattern data to the PPU

 SEND_DATA_TO_PPU 8     \ Send 8 bytes from dataForPPU to the PPU, starting at
                        \ index Y and updating Y to point to the byte after the
                        \ block that is sent

 BEQ spat7              \ If Y = 0 then the next byte is in the next page in
                        \ memory, so jump to spat7 to point dataForPPU(1 0) at
                        \ the start of this next page, before returning here

.spat13

 LDA addr               \ Set the following:
 CLC                    \
 ADC #16                \   PPU_ADDR = addr(1 0) + 16
 STA addr               \
 LDA addr+1             \   addr(1 0) = addr(1 0) + 16
 ADC #0                 \
 STA addr+1             \ So PPU_ADDR and addr(1 0) both point to the next
 STA PPU_ADDR           \ tile's pattern in the PPU for this bitplane, as each
 LDA addr               \ tile has 16 bytes of pattern data (8 in each bitplane)
 STA PPU_ADDR

 INX                    \ Increment the tile number in X

 CPX lastTile           \ If we have reached the last tile, jump to spat19 (via
 BCS spat8              \ spat8 and spat17) to move on to sending the nametable
                        \ entries

 SEND_DATA_TO_PPU 8     \ Send 8 bytes from dataForPPU to the PPU, starting at
                        \ index Y and updating Y to point to the byte after the
                        \ block that is sent

 BEQ spat16             \ If Y = 0 then the next byte is in the next page in
                        \ memory, so jump to spat16 to point dataForPPU(1 0) at
                        \ the start of this next page, before returning here
                        \ with the C flag clear, ready for the next addition

.spat14

 LDA addr               \ Set the following:
 ADC #16                \
 STA addr               \   PPU_ADDR = addr(1 0) + 16
 LDA addr+1             \
 ADC #0                 \   addr(1 0) = addr(1 0) + 16
 STA addr+1             \
 STA PPU_ADDR           \ The addition works because the C flag is clear, either
 LDA addr               \ because we passed through the BCS above, or because we
 STA PPU_ADDR           \ jumped to spat16 and back
                        \
                        \ So PPU_ADDR and addr(1 0) both point to the next
                        \ tile's pattern in the PPU for this bitplane, as each
                        \ tile has 16 bytes of pattern data (8 in each bitplane)

 INX                    \ Increment the tile number in X

 CPX lastTile           \ If we have reached the last tile, jump to spat19 (via
 BCS spat18             \ spat18) to move on to sending the nametable entries

 SEND_DATA_TO_PPU 8     \ Send 8 bytes from dataForPPU to the PPU, starting at
                        \ index Y and updating Y to point to the byte after the
                        \ block that is sent

 BEQ spat20             \ If Y = 0 then the next byte is in the next page in
                        \ memory, so jump to spat20 to point dataForPPU(1 0) at
                        \ the start of this next page, before returning here
                        \ with the C flag clear, ready for the next addition

.spat15

 LDA addr               \ Set the following:
 ADC #16                \
 STA addr               \   PPU_ADDR = addr(1 0) + 16
 LDA addr+1             \
 ADC #0                 \   addr(1 0) = addr(1 0) + 16
 STA addr+1             \
 STA PPU_ADDR           \ The addition works because the C flag is clear, either
 LDA addr               \ because we passed through the BCS above, or because we
 STA PPU_ADDR           \ jumped to spat20 and back
                        \
                        \ So PPU_ADDR and addr(1 0) both point to the next
                        \ tile's pattern in the PPU for this bitplane, as each
                        \ tile has 16 bytes of pattern data (8 in each bitplane)

 INX                    \ Increment the tile number in X

 CPX lastTile           \ If we have reached the last tile, jump to spat19 to
 BCS spat19             \ move on to sending the nametable entries

 JMP spat10             \ Otherwise we still have patterns to send, so jump back
                        \ to spat10 to check the cycle count and potentially
                        \ send the next batch

.spat16

 INC dataForPPU+1       \ Increment the high byte of dataForPPU(1 0) to point to
                        \ the start of the next page in memory

 SUBTRACT_CYCLES 29     \ Subtract 29 from the cycle count

 CLC                    \ Clear the C flag so the addition works at spat14

 JMP spat14             \ Jump up to spat14 to continue sending data to the PPU

.spat17

 ADD_CYCLES_CLC 224     \ Add 224 to the cycle count

 JMP spat19             \ Jump to spat19 to move on to sending nametable entries
                        \ to the PPU

.spat18

 ADD_CYCLES_CLC 109     \ Add 109 to the cycle count

.spat19

                        \ If we get here then we have sent the last tile's
                        \ pattern data, so we now move on to sending the
                        \ nametable entries to the PPU
                        \
                        \ Before jumping to SendNametableToPPU, we need to store
                        \ the following variables, so they can be picked up by
                        \ the new routine:
                        \
                        \   * (pattTileBuffHi pattTileBuffLo)
                        \
                        \   * sendingPattTile
                        \
                        \ Incidentally, these are the same variables that we
                        \ save when storing progress for the next VBlank, which
                        \ makes sense

 STX pattTileCounter    \ Store X in pattTileCounter to use below

 NOP                    \ This looks like code that has been removed

 LDX nmiBitplane        \ Set (pattTileBuffHi pattTileBuffLo) for this bitplane
 STY pattTileBuffLo,X   \ to dataForPPU(1 0) + Y (which is the address of the
 LDA dataForPPU+1       \ next byte of data to be sent from the pattern buffer)
 STA pattTileBuffHi,X

 LDA pattTileCounter    \ Set sendingPattTile for this bitplane to the value of
 STA sendingPattTile,X  \ X we stored above (which is the number / 8 of the next
                        \ tile to be sent from the pattern buffer)

 JMP SendNametableToPPU \ Jump to SendNametableToPPU to start sending the tile
                        \ nametable to the PPU

.spat20

 INC dataForPPU+1       \ Increment the high byte of dataForPPU(1 0) to point to
                        \ the start of the next page in memory

 SUBTRACT_CYCLES 29     \ Subtract 29 from the cycle count

 CLC                    \ Clear the C flag so the addition works at spat15

 JMP spat15             \ Jump up to spat14 to continue sending data to the PPU

\ ******************************************************************************
\
\       Name: SendPatternsToPPU (Part 4 of 6)
\       Type: Subroutine
\   Category: PPU
\    Summary: Configure variables for sending data to the PPU until we run out
\             of cycles
\
\ ******************************************************************************

.spat21

 LDA pattTileCounter    \ Set (addr A) = pattTileCounter
 LDX #0
 STX addr

 STX dataForPPU         \ Zero the low byte of dataForPPU(1 0)
                        \
                        \ We set the high byte in part 1, so dataForPPU(1 0) now
                        \ contains the address of the pattern buffer for this
                        \ bitplane

 ASL A                  \ Set (addr X) = (addr A) << 4
 ROL addr               \              = pattTileCounter * 16
 ASL A
 ROL addr
 ASL A
 ROL addr
 ASL A
 TAX

 LDA addr               \ Set (A X) = (ppuPatternTableHi 0) + (addr X)
 ROL A                  \         = (ppuPatternTableHi 0) + pattTileCounter * 16
 ADC ppuPatternTableHi  \
                        \ ppuPatternTableHi contains the high byte of the
                        \ address of the PPU pattern table to which we send
                        \ dynamic tile patterns; it contains HI(PPU_PATT_1),
                        \ so (A X) now contains the address in PPU pattern
                        \ table 1 for tile number pattTileCounter (as there are
                        \ 16 bytes in the pattern table for each tile)

                        \ We now set both PPU_ADDR and addr(1 0) to the
                        \ following:
                        \
                        \   * (A X)         when nmiBitplane is 0
                        \
                        \   * (A X) + 8     when nmiBitplane is 1
                        \
                        \ We add 8 in the second example to point the address to
                        \ bitplane 1, as the PPU interleaves each tile pattern
                        \ as 8 bytes of one bitplane followed by 8 bytes of the
                        \ other bitplane, so bitplane 1's data always appears 8
                        \ bytes after the corresponding bitplane 0 data

 STA PPU_ADDR           \ Set the high byte of PPU_ADDR to A

 STA addr+1             \ Set the high byte of addr to A

 TXA                    \ Set A = X + nmiBitplane8
 ADC nmiBitplane8       \       = X + nmiBitplane * 8
                        \
                        \ So we add 8 to the low byte when we are writing to
                        \ bit plane 1, otherwise we leave the low byte alone

 STA PPU_ADDR           \ Set the low byte of PPU_ADDR to A

 STA addr               \ Set the high byte of addr to A

                        \ So PPU_ADDR and addr(1 0) both contain the PPU
                        \ address to which we should send our pattern data for
                        \ this bitplane

 JMP spat23             \ Jump into part 5 to send pattern data to the PPU

\ ******************************************************************************
\
\       Name: SendPatternsToPPU (Part 5 of 6)
\       Type: Subroutine
\   Category: PPU
\    Summary: Send pattern data to the PPU for two tiles at a time, until we run
\             out of cycles (and without checking for the last tile)
\
\ ******************************************************************************

.spat22

 INC dataForPPU+1       \ Increment the high byte of dataForPPU(1 0) to point to
                        \ the start of the next page in memory

 SUBTRACT_CYCLES 27     \ Subtract 27 from the cycle count

 JMP spat27             \ Jump down to spat27 to continue sending data to the
                        \ PPU

.spat23

                        \ This is the entry point for part 5

 LDX pattTileCounter    \ We will now work our way through tiles, sending data
                        \ each one, so set a counter in X that starts with the
                        \ number of the next tile to send to the PPU

.spat24

 SUBTRACT_CYCLES 266    \ Subtract 266 from the cycle count

 BMI spat25             \ If the result is negative, jump to spat25 to stop
                        \ sending PPU data in this VBlank, as we have run out of
                        \ cycles (we will pick up where we left off in the next
                        \ VBlank)

 JMP spat26             \ The result is positive, so we have enough cycles to
                        \ keep sending PPU data in this VBlank, so jump to
                        \ spat26 to send pattern data to the PPU

.spat25

 ADD_CYCLES 225         \ Add 225 to the cycle count

 JMP spat30             \ Jump to part 6 to save progress for use in the next
                        \ VBlank and return from the subroutine

.spat26

                        \ If we get here then we send pattern data to the PPU

 SEND_DATA_TO_PPU 8     \ Send 8 bytes from dataForPPU to the PPU, starting at
                        \ index Y and updating Y to point to the byte after the
                        \ block that is sent

 BEQ spat22             \ If Y = 0 then the next byte is in the next page in
                        \ memory, so jump to spat22 to point dataForPPU(1 0) at
                        \ the start of this next page, before returning here

.spat27

 LDA addr               \ Set the following:
 CLC                    \
 ADC #16                \   PPU_ADDR = addr(1 0) + 16
 STA addr               \
 LDA addr+1             \   addr(1 0) = addr(1 0) + 16
 ADC #0                 \
 STA addr+1             \ So PPU_ADDR and addr(1 0) both point to the next
 STA PPU_ADDR           \ tile's pattern in the PPU for this bitplane, as each
 LDA addr               \ tile has 16 bytes of pattern data (8 in each bitplane)
 STA PPU_ADDR

 SEND_DATA_TO_PPU 8     \ Send 8 bytes from dataForPPU to the PPU, starting at
                        \ index Y and updating Y to point to the byte after the
                        \ block that is sent

 BEQ spat29             \ If Y = 0 then the next byte is in the next page in
                        \ memory, so jump to spat29 to point dataForPPU(1 0) at
                        \ the start of this next page, before returning here
                        \ with the C flag clear, ready for the next addition

.spat28

 LDA addr               \ Set the following:
 ADC #16                \
 STA addr               \   PPU_ADDR = addr(1 0) + 16
 LDA addr+1             \
 ADC #0                 \   addr(1 0) = addr(1 0) + 16
 STA addr+1             \
 STA PPU_ADDR           \ The addition works because the C flag is clear, either
 LDA addr               \ because we passed through the BCS above, or because we
 STA PPU_ADDR           \ jumped to spat29 and back
                        \
                        \ So PPU_ADDR and addr(1 0) both point to the next
                        \ tile's pattern in the PPU for this bitplane, as each
                        \ tile has 16 bytes of pattern data (8 in each bitplane)

 INX                    \ Increment the tile number in X twice, as we just sent
 INX                    \ data for two tiles

 JMP spat24             \ Loop back to spat24 to check the cycle count and
                        \ potentially send the next batch

.spat29

 INC dataForPPU+1       \ Increment the high byte of dataForPPU(1 0) to point to
                        \ the start of the next page in memory

 SUBTRACT_CYCLES 29     \ Subtract 29 from the cycle count

 CLC                    \ Clear the C flag so the addition works at spat15

 JMP spat28             \ Jump up to spat28 to continue sending data to the PPU

\ ******************************************************************************
\
\       Name: SendPatternsToPPU (Part 6 of 6)
\       Type: Subroutine
\   Category: PPU
\    Summary: Save progress for use in the next VBlank and return from the
\             subroutine
\
\ ******************************************************************************

.spat30

                        \ We now store the following variables, so they can be
                        \ picked up when we return in the next VBlank:
                        \
                        \   * (pattTileBuffHi pattTileBuffLo)
                        \
                        \   * sendingPattTile

 STX pattTileCounter    \ Store X in pattTileCounter to use below

 LDX nmiBitplane        \ Set (pattTileBuffHi pattTileBuffLo) for this bitplane
 STY pattTileBuffLo,X   \ to dataForPPU(1 0) + Y (which is the address of the
 LDA dataForPPU+1       \ next byte of data to be sent from the pattern buffer
 STA pattTileBuffHi,X   \ in the next VBlank)

 LDA pattTileCounter    \ Set sendingPattTile for this bitplane to the value of
 STA sendingPattTile,X  \ X we stored above (which is the number / 8 of the next
                        \ tile to be sent from the pattern buffer in the next
                        \ VBlank)

 JMP RTS1               \ Return from the subroutine (as RTS1 contains an RTS)

\ ******************************************************************************
\
\       Name: SendOtherBitplane
\       Type: Subroutine
\   Category: PPU
\    Summary: Check whether we should send another bitplane to the PPU
\
\ ******************************************************************************

.SendOtherBitplane

 LDX nmiBitplane        \ Set X to the current NMI bitplane (i.e. the bitplane
                        \ for which we have been sending data to the PPU)

 LDA #%00100000         \ Set the NMI bitplane flags as follows:
 STA bitplaneFlags,X    \
                        \   * Bit 2 clear = send tiles up to configured numbers
                        \   * Bit 3 clear = don't clear buffers after sending
                        \   * Bit 4 clear = we've not started sending data yet
                        \   * Bit 5 set   = we have already sent all the data
                        \   * Bit 6 clear = only send pattern data to the PPU
                        \   * Bit 7 clear = do not send data to the PPU
                        \
                        \ Bits 0 and 1 are ignored and are always clear
                        \
                        \ So this indicates that we have finished sending data
                        \ to the PPU for this bitplane

 SUBTRACT_CYCLES 227    \ Subtract 227 from the cycle count

 BMI obit1              \ If the result is negative, jump to obit1 to stop
                        \ sending PPU data in this VBlank, as we have run out of
                        \ cycles (we will pick up where we left off in the next
                        \ VBlank)

 JMP obit2              \ The result is positive, so we have enough cycles to
                        \ keep sending PPU data in this VBlank, so jump to obit2
                        \ to check whether we should send this bitplane to the
                        \ PPU

.obit1

 ADD_CYCLES 176         \ Add 176 to the cycle count

 JMP RTS1               \ Return from the subroutine (as RTS1 contains an RTS)

.obit2

 TXA                    \ Flip the NMI bitplane between 0 and 1, to it's the
 EOR #1                 \ opposite bitplane to the one we just sent
 STA nmiBitplane

 CMP hiddenBitplane     \ If the NMI bitplane is now different to the hidden
 BNE obit4              \ bitplane, jump to obit4 to update the cycle count
                        \ and return from the subroutine, as we already sent
                        \ the bitplane that's hidden (we only want to update
                        \ the hidden bitplane, to avoid messing up the screen)

                        \ If we get here then the new NMI bitplane is the same
                        \ as the bitplane that's hidden, so we should send it
                        \ to the PPU (this might happen if the value of
                        \ hiddenBitplane changes while we are still sending
                        \ data to the PPU across multiple calls to the NMI
                        \ handler) ???

 TAX                    \ Set X to the newly flipped NMI bitplane

 LDA bitplaneFlags,X    \ Set A to the bitplane flags for the newly flipped NMI
                        \ bitplane

 AND #%10100000         \ This jumps to obit3 if both of the following are true
 CMP #%10000000         \ for bitplane 1:
 BEQ obit3              \
                        \   * Bit 5 is clear (we have not already sent all the
                        \     data to the PPU for the bitplane)
                        \
                        \   * Bit 7 is set (send data to the PPU for the
                        \     bitplane)
                        \
                        \ If both of these are true then jump to obit3 to update
                        \ the cycle count and return from the subroutine without
                        \ sending any more tile data to the PPU in this VBlank

                        \ If we get here then the new bitplane is not configured
                        \ to be sent to the PPU, so we send it now ???

 JMP SendTilesToPPU     \ Jump to SendTilesToPPU to set up the variables for
                        \ sending tile data to the PPU, and then send them

.obit3

 ADD_CYCLES_CLC 151     \ Add 151 to the cycle count

 RTS                    \ Return from the subroutine

.obit4

 ADD_CYCLES_CLC 163     \ Add 163 to the cycle count

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: SendNametableToPPU
\       Type: Subroutine
\   Category: PPU
\    Summary: Send the tile nametable to the PPU if there are enough cycles left
\             in the current VBlank
\
\ ------------------------------------------------------------------------------
\
\ Other entry points:
\
\   SendNametableNow    Send the nametable without checking the cycle count
\
\ ******************************************************************************

.snam1

 ADD_CYCLES_CLC 58      \ Add 58 to the cycle count

 JMP RTS1               \ Return from the subroutine (as RTS1 contains an RTS)

.snam2

 ADD_CYCLES_CLC 53      \ Add 53 to the cycle count

 JMP SendOtherBitplane  \ Jump to SendOtherBitplane to consider sending the
                        \ other bitplane to the PPU, if required

.SendNametableToPPU

 SUBTRACT_CYCLES 109    \ Subtract 109 from the cycle count

 BMI snam3              \ If the result is negative, jump to snam3 to stop
                        \ sending PPU data in this VBlank, as we have run out of
                        \ cycles (we will pick up where we left off in the next
                        \ VBlank)

 JMP SendNametableNow   \ The result is positive, so we have enough cycles to
                        \ keep sending PPU data in this VBlank, so jump to
                        \ SendNametableNow to start sending nametable data to
                        \ the PPU

.snam3

 ADD_CYCLES 68          \ Add 68 to the cycle count

 JMP RTS1               \ Return from the subroutine (as RTS1 contains an RTS)

.SendNametableNow

 LDX nmiBitplane        \ Set X to the current NMI bitplane (i.e. the bitplane
                        \ for which we are sending data to the PPU in the NMI
                        \ handler)

 LDA bitplaneFlags,X    \ Set A to the bitplane flags for the NMI bitplane

 ASL A                  \ Shift A left by one place, so bit 7 becomes bit 6 of
                        \ the original flags, and so on

 BPL snam1              \ If bit 6 of the bitplane flags is clear, then this
                        \ bitplane is only configured to send pattern data and
                        \ not nametable data, so jump to snam1 to return from
                        \ the subroutine

 LDY lastNameTile,X     \ Set Y to the number of the last tile we need to send
                        \ for this bitplane, divided by 8

 AND #%00001000         \ If bit 2 of the bitplane flags is set (as A was
 BEQ snam4              \ shifted left above), set Y = 128 to override the last
 LDY #128               \ tile number with 128, which means send all tiles (as
                        \ 128 * 8 = 1024 and 1024 is the buffer size)

.snam4

 STY lastTile           \ Store Y in lastTile, as we want to stop sending
                        \ nametable entries when we reach this tile

 LDA sendingNameTile,X  \ Set A to the number of the next tile we want to send
                        \ from the nametable buffer for this bitplane, divided
                        \ by 8 (we divide by 8 because there are 1024 entries in
                        \ each nametable, which doesn't fit into one byte, so we
                        \ divide by 8 so the maximum counter value is 128)

 STA nameTileCounter    \ Store the number in nameTileCounter, so we can keep
                        \ track of which tile we are sending (so nameTileCounter
                        \ contains the current tile number, divided by 8)

 SEC                    \ Set A = A - lastTile
 SBC lastTile           \       = nameTileCounter - lastTile

 BCS snam2              \ If nameTileCounter >= lastTile then we have already
                        \ sent all the nametable entries (right up to the last
                        \ tile), so jump to snam2 to consider sending the other
                        \ bitplane

 LDY nameTileBuffLo,X   \ Set Y to the low byte of the address of the nametable
                        \ buffer for sendingNameTile in bitplane X (i.e. the
                        \ address of the next tile we want to send)
                        \
                        \ We can use this as an index when copying data from
                        \ the nametable buffer, as we know the nametable buffers
                        \ start on page boundaries, so the low byte of the
                        \ address of the the start of each buffer is zero

 LDA nameTileBuffHi,X   \ Set the high byte of dataForPPU(1 0) to the high byte
 STA dataForPPU+1       \ of the nametable buffer for this bitplane, as we want
                        \ to copy data from the nametable buffer to the PPU

 CLC                    \ Set the high byte of the following calculation:
 ADC ppuToBuffNameHi,X  \
                        \   (A 0) = (nameTileBuffHi 0) + (ppuToBuffNameHi 0)
                        \
                        \ (ppuToBuffNameHi 0) for this bitplane contains a high
                        \ byte that we can add to a nametable buffer address to
                        \ get the corresponding address in the PPU nametable, so
                        \ this sets (A 0) to the high byte of the correct PPU
                        \ nametable address for this tile
                        \
                        \ We already set Y as the low byte above, so we now have
                        \ the full PPU address in (A Y)

 STA PPU_ADDR           \ Set PPU_ADDR = (A Y)
 STY PPU_ADDR           \
                        \ So PPU_ADDR points to the address in the PPU to which
                        \ we send the nametable data

 LDA #0                 \ Set the low byte of dataForPPU(1 0) to 0, so that
 STA dataForPPU         \ dataForPPU(1 0) points to the start of the nametable
                        \ buffer, and dataForPPU(1 0) + Y therefore points to
                        \ the nametable entry for tile sendingNameTile

.snam5

 SUBTRACT_CYCLES 393    \ Subtract 393 from the cycle count

 BMI snam6              \ If the result is negative, jump to snam6 to stop
                        \ sending PPU data in this VBlank, as we have run out of
                        \ cycles (we will pick up where we left off in the next
                        \ VBlank)

                        \ If we get here then the result is positive, so the C
                        \ flag will be set as the subtraction didn't underflow

 JMP snam7              \ The result is positive, so we have enough cycles to
                        \ keep sending PPU data in this VBlank, so jump to snam7
                        \ to do just that

.snam6

 ADD_CYCLES 349         \ Add 349 to the cycle count

 JMP snam10             \ Jump to snam10 to save progress for use in the next
                        \ VBlank and return from the subroutine

.snam7

 SEND_DATA_TO_PPU 32    \ Send 32 bytes from dataForPPU to the PPU, starting at
                        \ index Y and updating Y to point to the byte after the
                        \ block that is sent

 BEQ snam9              \ If Y = 0 then the next byte is in the next page in
                        \ memory, so jump to snam9 to point dataForPPU(1 0) at
                        \ the start of this next page, before looping back to
                        \ snam5 to potentially send the next batch

                        \ We got here by jumping to snam7 from above, which we
                        \ did with the C flag set, so the ADC #3 below actually
                        \ adds 4

 LDA nameTileCounter    \ Add 4 to nameTileCounter, as we just sent 4 * 8 = 32
 ADC #3                 \ nametable entries (and nameTileCounter counts the tile
 STA nameTileCounter    \ number, divided by 8)

 CMP lastTile           \ If nameTileCounter >= lastTile then we have reached
 BCS snam8              \ the last tile, so jump to snam8 to update the
                        \ variables and jump to SendOtherBitplane to consider
                        \ sending the other bitplane

 JMP snam5              \ Otherwise we still have nametable entries to send, so
                        \ loop back to snam5 to check the cycles and send the
                        \ next batch

.snam8

                        \ If we get here then we have sent the last nametable
                        \ entry, so we now move on to considering whether to
                        \ send the other bitplane to the PPU, if required
                        \
                        \ Before jumping to SendOtherBitplane, we need to store
                        \ the following variables, so they can be picked up by
                        \ the new routine:
                        \
                        \   * (nameTileBuffHi nameTileBuffLo)
                        \
                        \   * sendingNameTile
                        \
                        \ Incidentally, these are the same variables that we
                        \ save when storing progress for the next VBlank, which
                        \ makes sense

 STA sendingNameTile,X  \ Set sendingNameTile for this bitplane to the value of
                        \ nameTileCounter, which we stored in A before jumping
                        \ here

 STY nameTileBuffLo,X   \ Set (nameTileBuffHi nameTileBuffLo) for this bitplane
 LDA dataForPPU+1       \ to dataForPPU(1 0) + Y (which is the address of the
 STA nameTileBuffHi,X   \ next byte of data to be sent from the nametable
                        \ buffer)

 JMP SendOtherBitplane  \ Jump to SendOtherBitplane to consider sending the
                        \ other bitplane to the PPU, if required

.snam9

 INC dataForPPU+1       \ Increment the high byte of dataForPPU(1 0) to point to
                        \ the start of the next page in memory

 SUBTRACT_CYCLES 26     \ Subtract 26 from the cycle count

 LDA nameTileCounter    \ Add 4 to nameTileCounter, as we just sent 4 * 8 = 32
 CLC                    \ nametable entries (and nameTileCounter counts the tile
 ADC #4                 \ number, divided by 8)
 STA nameTileCounter

 CMP lastTile           \ If nameTileCounter >= lastTile then we have reached
 BCS snam8              \ the last tile, so jump to snam8 to update the
                        \ variables and jump to SendOtherBitplane to consider
                        \ sending the other bitplane

 JMP snam5              \ Otherwise we still have nametable entries to send, so
                        \ loop back to snam5 to check the cycles and send the
                        \ next batch

.snam10

                        \ We now store the following variables, so they can be
                        \ picked up when we return in the next VBlank:
                        \
                        \   * (nameTileBuffHi nameTileBuffLo)
                        \
                        \   * sendingNameTile

 LDA nameTileCounter    \ Set sendingNameTile for this bitplane to the number
 STA sendingNameTile,X  \ of the tile to send next, in nameTileCounter

 STY nameTileBuffLo,X   \ Set (nameTileBuffHi nameTileBuffLo) for this bitplane
 LDA dataForPPU+1       \ to dataForPPU(1 0) + Y (which is the address of the
 STA nameTileBuffHi,X   \ next byte of data to be sent from the nametable
                        \ buffer)

 JMP RTS1               \ Return from the subroutine (as RTS1 contains an RTS)

\ ******************************************************************************
\
\       Name: CopyNameBuffer0To1
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Copy the contents of nametable buffer 0 to nametable buffer 1
\             and set the next free tile number for both bitplanes
\
\ ******************************************************************************

.CopyNameBuffer0To1

 LDY #0                 \ Set Y = 0 so we can use it as an index starting at 0,
                        \ and then counting down from 255 to 0

 LDX #16                \ The following loop also updates a counter in X that
                        \ counts down from 16 to 1 and back to 16 again, but it
                        \ isn't used anywhere, so presumably this is left over
                        \ from some functionality that was later removed

.copy1

 LDA nameBuffer0,Y      \ Copy the Y-th byte of nametable buffer 0 to nametable
 STA nameBuffer1,Y      \ buffer 1, so this copies the first 256 bytes as Y
                        \ counts down

 LDA nameBuffer0+256,Y  \ Copy byte 256, and bytes 511 to 255 into nametable
 STA nameBuffer1+256,Y  \ buffer 1 as Y counts down

 LDA nameBuffer0+512,Y  \ Copy byte 512, and bytes 767 to 511 into nametable
 STA nameBuffer1+512,Y  \ buffer 1 as Y counts down

 LDA nameBuffer0+768,Y  \ Copy byte 768, and bytes 1023 to 769 into nametable
 STA nameBuffer1+768,Y  \ buffer 1 as Y counts down

 JSR SetupPPUForIconBar \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 DEX                    \ Decrement the counter in X, wrapping it back up to 16
 BNE copy2              \ when it reaches 0
 LDX #16

.copy2

 DEY                    \ Decrement the index counter in Y

 BNE copy1              \ Loop back to copy1 to copy the next four bytes, until
                        \ we have copied the whole buffer

 LDA firstFreeTile      \ Tell the NMI handler to send pattern entries up to the
 STA lastPatternTile    \ first free tile, for both bitplanes
 STA lastPatternTile+1

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: DrawBoxTop
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Draw the top edge of the box along the top of the screen in
\             nametable buffer 0
\
\ ******************************************************************************

.DrawBoxTop

 LDY #1                 \ Set Y as an index into the nametable, as we want to
                        \ draw the top bar from column 1 to 31

 LDA #3                 \ Set A = 3 as the tile number to use for the top of the
                        \ box (it's a three-pixel high horizontal bar)

.boxt1

 STA nameBuffer0,Y      \ Set the Y-th entry in nametable 0 to tile 3

 INY                    \ Increment the column counter

 CPY #32                \ Loop back until we have drawn in columns 1 through 31
 BNE boxt1

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: DrawBoxEdges
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Draw the left and right edges of the box along the sides of the
\             screen, drawing into the nametable buffer for the drawing bitplane
\
\ ******************************************************************************

.DrawBoxEdges

 LDX drawingBitplane    \ If the drawing bitplane is set to 1, jump to boxe1 to
 BNE boxe1              \ draw the box edges in bitplane 1

                        \ Otherwise we draw the box edges in bitplane 0

 LDA boxEdge1           \ Set A to the tile number for the left edge of the box,
                        \ which will either be tile 1 for the normal view (a
                        \ three-pixel wide vertical bar along the right edge of
                        \ the tile), or tile 0 (blank) for the death screen

 STA nameBuffer0+1      \ Write this tile into column 1 on rows 0 to 19 in
 STA nameBuffer0+1*32+1 \ nametable buffer 0 to draw the left edge of the box
 STA nameBuffer0+2*32+1 \ (column 1 is the left edge because the screen is
 STA nameBuffer0+3*32+1 \ scrolled horizontally by one block)
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

 LDA boxEdge2           \ Set A to the tile number for the right edge of the
                        \ box, which will either be tile 2 for the normal view
                        \ (a three-pixel wide vertical bar along the left edge
                        \ of the tile), or tile 0 (blank) for the death screen

 STA nameBuffer0        \ Write this tile into column 0 on rows 0 to 19 in
 STA nameBuffer0+1*32   \ nametable buffer 0 to draw the right edge of the box
 STA nameBuffer0+2*32   \ (column 0 is the right edge because the screen is
 STA nameBuffer0+3*32   \ scrolled horizontally by one block)
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

 RTS                    \ Return from the subroutine

.boxe1

 LDA boxEdge1           \ Set A to the tile number for the left edge of the box,
                        \ which will either be tile 1 for the normal view (a
                        \ three-pixel wide vertical bar along the right edge of
                        \ the tile), or tile 0 (blank) for the death screen

 STA nameBuffer1+1      \ Write this tile into column 1 on rows 0 to 19 in
 STA nameBuffer1+1*32+1 \ nametable buffer 1 to draw the left edge of the box
 STA nameBuffer1+2*32+1 \ (column 1 is the left edge because the screen is
 STA nameBuffer1+3*32+1 \ scrolled horizontally by one block)
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

 LDA boxEdge2           \ Set A to the tile number for the right edge of the
                        \ box, which will either be tile 2 for the normal view
                        \ (a three-pixel wide vertical bar along the left edge
                        \ of the tile), or tile 0 (blank) for the death screen

 STA nameBuffer1        \ Write this tile into column 0 on rows 0 to 19 in
 STA nameBuffer1+1*32   \ nametable buffer 1 to draw the right edge of the box
 STA nameBuffer1+2*32   \ (column 0 is the right edge because the screen is
 STA nameBuffer1+3*32   \ scrolled horizontally by one block)
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

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/variable/univ.asm"
INCLUDE "library/common/main/subroutine/ginf.asm"

\ ******************************************************************************
\
\       Name: HideExplosionBurst
\       Type: Subroutine
\   Category: Drawing ships
\    Summary: Hide the four sprites that make up the explosion burst that
\             flashes up when a ship explodes
\
\ ******************************************************************************

.HideExplosionBurst

 LDX #4                 \ Set X = 4 so we hide four sprites

 LDY #236               \ Set Y so we start hiding from sprite 236 / 4 = 59

 JMP HideSprites        \ Jump to HideSprites to hide four sprites from sprite
                        \ 59 onwards (i.e. 59 to 62), returning from the
                        \ subroutine using a tail call

\ ******************************************************************************
\
\       Name: ClearScanner
\       Type: Subroutine
\   Category: Dashboard
\    Summary: Remove all ships from the scanner and hide the scanner sprites
\
\ ******************************************************************************

.ClearScanner

 LDX #0                 \ Set up a counter in X to work our way through all the
                        \ ship slots in FRIN

.csca1

 LDA FRIN,X             \ Fetch the ship type in slot X

 BEQ csca3              \ If the slot contains 0 then it is empty and we have
                        \ checked all the slots (as they are always shuffled
                        \ down in the main loop to close up and gaps), so jump
                        \ to csca3WS2 as we are done

 BMI csca2              \ If the slot contains a ship type with bit 7 set, then
                        \ it contains the planet or the sun, so jump down to
                        \ csca2 to skip this slot, as the planet and sun don't
                        \ appear on the scanner

 JSR GINF               \ Call GINF to get the address of the data block for
                        \ ship slot X and store it in INF

 LDY #31                \ Clear bit 4 in the ship's byte #31, which hides it
 LDA (INF),Y            \ from the scanner
 AND #%11101111
 STA (INF),Y

.csca2

 INX                    \ Increment X to point to the next ship slot

 BNE csca1              \ Loop back up to process the next slot (this BNE is
                        \ effectively a JMP as X will never be zero)

.csca3

 LDY #44                \ Set Y so we start hiding from sprite 44 / 4 = 11

 LDX #27                \ Set X = 27 so we hide 27 sprites

                        \ Fall through into HideSprites to hide 27 sprites
                        \ from sprite 11 onwards (i.e. the scanner sprites from
                        \ 11 to 37)

\ ******************************************************************************
\
\       Name: HideSprites
\       Type: Subroutine
\   Category: Drawing sprites
\    Summary: Hide X sprites from sprite Y / 4 onwards
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X                   The number of sprites to hide
\
\   Y                   The number of the first sprite to hide * 4
\
\ ******************************************************************************

.HideSprites

 LDA #240               \ Set A to the y-coordinate that's just below the bottom
                        \ of the screen, so we can hide the required sprites by
                        \ moving them off-screen

.hspr1

 STA ySprite0,Y         \ Set the y-coordinate for sprite Y / 4 to 240 to hide
                        \ it (the division by four is because each sprite in the
                        \ sprite buffer has four bytes of data)

 INY                    \ Add 4 to Y so it points to the next sprite's data in
 INY                    \ the sprite buffer
 INY
 INY

 DEX                    \ Decrement the loop counter in X

 BNE hspr1              \ Loop back until we have hidden X sprites

 RTS                    \ Return from the subroutine

 EQUB &0C, &20, &1F     \ These bytes appear to be unused

INCLUDE "library/nes/main/variable/namebufferhiaddr.asm"
INCLUDE "library/nes/main/variable/pattbufferhiaddr.asm"

\ ******************************************************************************
\
\       Name: IRQ
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Handle IRQ interrupts by doing nothing
\
\ ******************************************************************************

.IRQ

 RTI                    \ Return from the interrupt handler

\ ******************************************************************************
\
\       Name: NMI
\       Type: Subroutine
\   Category: Utility routines
\    Summary: The NMI interrupt handler that gets called every VBlank and which
\             updates the screen, reads the controllers and plays music
\
\ ******************************************************************************

.NMI

 JSR SendPaletteSprites \ Send the current palette and sprite data to the PPU

 LDA showUserInterface  \ Set the value of setupPPUForIconBar so that if there
 STA setupPPUForIconBar \ is an on-screen user interface (which there will be if
                        \ this isn't the game over screen), then the calls to
                        \ the SETUP_PPU_FOR_ICON_BAR macro sprinkled throughout
                        \ the codebase will make sure we set nametable 0 and
                        \ palette table 0 when the PPU starts drawing the icon
                        \ bar

IF _NTSC

 LDA #HI(6797)          \ Set cycleCount = 6797
 STA cycleCount+1       \
 LDA #LO(6797)          \ We use this to keep track of how many cycles we have
 STA cycleCount         \ left in the current VBlank, so we only send data to
                        \ the PPU when VBlank is in progress, splitting up the
                        \ larger PPU operations across multiple VBlanks

ELIF _PAL

 LDA #HI(7433)          \ Set cycleCount = 7433
 STA cycleCount+1       \
 LDA #LO(7433)          \ We use this to keep track of how many cycles we have
 STA cycleCount         \ left in the current VBlank, so we only send data to
                        \ the PPU when VBlank is in progress, splitting up the
                        \ larger PPU operations across multiple VBlanks

ENDIF

 JSR SendScreenToPPU    \ Update the screen by sending the nametable and pattern
                        \ data from the buffers to the PPU, configuring the PPU
                        \ registers accordinaly, and clearing the buffers if
                        \ required

 JSR ReadControllers    \ Read the buttons on the controllers

 LDA autoPlayDemo       \ If bit 7 of autoPlayDemo is clear then the demo is not
 BPL inmi1              \ being played automatically, so jump to inmi1 to skip
                        \ the following

 JSR AutoPlayDemo       \ Bit 7 of autoPlayDemo is set, so call AutoPlayDemo to
                        \ automatically play the demo using the controller key
                        \ presses in the autoplayKeys tables

.inmi1

 JSR MoveIconBarPointer \ Move the sprites that make up the icon bar pointer

 JSR UpdateJoystick     \ Update the values of JSTX and JSTY with the values
                        \ from the controller

 JSR UpdateNMITimer     \ Update the NMI timer, which we can use in place of
                        \ hardware timers (which the NES does not support)

 LDA runningSetBank     \ If the NMI handler was called from within the SetBank
 BNE inmi2              \ routine, then runningSetBank will be &FF, so jump to
                        \ inmi2 to skip the call to PlayMusic

 JSR PlayMusic_b6       \ Call the PlayMusic routine to play the background
                        \ music

 LDA nmiStoreA          \ Restore the values of A, X and Y that we stored at
 LDX nmiStoreX          \ the start of the NMI handler
 LDY nmiStoreY

 RTI                    \ Return from the interrupt handler

.inmi2

 INC runningSetBank     \ Increment runningSetBank

 LDA nmiStoreA          \ Restore the values of A, X and Y that we stored at
 LDX nmiStoreX          \ the start of the NMI handler
 LDY nmiStoreY

 RTI                    \ Return from the interrupt handler

\ ******************************************************************************
\
\       Name: UpdateNMITimer
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Update the NMI timer, which we can use in place of hardware
\             timers (which the NES does not support)
\
\ ******************************************************************************

.UpdateNMITimer

 DEC nmiTimer           \ Decrement the NMI timer counter, so that it counts
                        \ each NMI interrupt

 BNE nmit1              \ If it hsn't reached zero yet, jump to nmit1 to return
                        \ from the subroutine

 LDA #50                \ Wrap the NMI timer round to start counting down from
 STA nmiTimer           \ 50 once again, as it just reached zero

 LDA nmiTimerLo         \ Increment (nmiTimerHi nmiTimerLo)
 CLC
 ADC #1
 STA nmiTimerLo
 LDA nmiTimerHi
 ADC #0
 STA nmiTimerHi

.nmit1

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: SendPaletteSprites
\       Type: Subroutine
\   Category: Drawing sprites
\    Summary: Send the current palette and sprite data to the PPU
\
\ ******************************************************************************

.SendPaletteSprites

 STA nmiStoreA          \ Store the values of A, X and Y so we can retrieve them
 STX nmiStoreX          \ at the end of the NMI handler
 STY nmiStoreY

 LDA PPU_STATUS         \ Read from PPU_STATUS to clear bit 7 of PPU_STATUS and
                        \ reset the VBlank start flag

 INC frameCounter       \ Increment the frame counter

 LDA #0                 \ Write 0 to OAM_ADDR so we can use OAM_DMA to send
 STA OAM_ADDR           \ sprite data to the PPU

 LDA #&02               \ Write &02 to OAM_DMA to upload 256 bytes of sprite
 STA OAM_DMA            \ data from the sprite buffer at &02xx into the PPU

 LDA #%00000000         \ Configure the PPU by setting PPU_MASK as follows:
 STA PPU_MASK           \
                        \   * Bit 0 clear = normal colour (not monochrome)
                        \   * Bit 1 clear = hide leftmost 8 pixels of background
                        \   * Bit 2 clear = hide sprites in leftmost 8 pixels
                        \   * Bit 3 clear = hide background
                        \   * Bit 4 clear = hide sprites
                        \   * Bit 5 clear = do not intensify greens
                        \   * Bit 6 clear = do not intensify blues
                        \   * Bit 7 clear = do not intensify reds

                        \ Fall through into SetPaletteForView to set the correct
                        \ palette for the current view

\ ******************************************************************************
\
\       Name: SetPaletteForView
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Set the correct background and sprite palettes for the current
\             view and (if this is the space view) the hidden bit plane
\
\ ******************************************************************************

.SetPaletteForView

 LDA QQ11a              \ Set A to the current view (or the old view that is
                        \ still being shown, if we are in the process of
                        \ changing view)

 BNE palv2              \ If this is not the space view, jump to palv2

                        \ If we get here then this is the space view

 LDY visibleColour      \ Set Y to the colour to use for visible pixels

 LDA hiddenBitplane     \ If hiddenBitplane is non-zero (i.e. 1), jump to palv1
 BNE palv1              \ to hide pixels in bitplane 1

                        \ If we get here then hiddenBitplane = 0, so now we hide
                        \ pixels in bitplane 0 and show pixels in bitplane 1

 LDA #&3F               \ Set PPU_ADDR = &3F01, so it points to background
 STA PPU_ADDR           \ palette 0 in the PPU
 LDA #&01
 STA PPU_ADDR

 LDA hiddenColour       \ Set A to the colour to use for hidden pixels

 STA PPU_DATA           \ Set palette 0 to the following:
 STY PPU_DATA           \
 STY PPU_DATA           \   * Colour 0 = background (black)
                        \
                        \   * Colour 1 = hidden colour (bitplane 0)
                        \
                        \   * Colour 2 = visible colour (bitplane 1)
                        \
                        \   * Colour 3 = visible colour
                        \
                        \ So pixels in bitplane 0 will be hidden, while
                        \ pixels in bitplane 1 will be visible
                        \
                        \ i.e. pixels in the hiddenBitplane will be hidden

 LDA #&00               \ Change the PPU address away from the palette entries
 STA PPU_ADDR           \ to prevent the palette being corrupted
 LDA #&00
 STA PPU_ADDR

 RTS                    \ Return from the subroutine

.palv1

                        \ If we get here then hiddenBitplane = 1, so now we hide
                        \ pixels in bitplane 1 and show pixels in bitplane 0

 LDA #&3F               \ Set PPU_ADDR = &3F01, so it points to background
 STA PPU_ADDR           \ palette 0 in the PPU
 LDA #&01
 STA PPU_ADDR

 LDA hiddenColour       \ Set A to the colour to use for hidden pixels

 STY PPU_DATA           \ Set palette 0 to the following:
 STA PPU_DATA           \
 STY PPU_DATA           \   * Colour 0 = background (black)
                        \
                        \   * Colour 1 = visible colour (bitplane 0)
                        \
                        \   * Colour 2 = hidden colour (bitplane 1)
                        \
                        \   * Colour 3 = visible colour
                        \
                        \ So pixels in bitplane 0 will be visible, while
                        \ pixels in bitplane 1 will be hidden
                        \
                        \ i.e. pixels in the hiddenBitplane will be hidden

 LDA #&00               \ Change the PPU address away from the palette entries
 STA PPU_ADDR           \ to prevent the palette being corrupted
 LDA #&00
 STA PPU_ADDR

 RTS                    \ Return from the subroutine

.palv2

                        \ If we get here then this is not the space view

 CMP #&98               \ If this is the Status Mode screen, jump to palv3
 BEQ palv3

                        \ If we get here then this is not the space view or the
                        \ Status Mode screen

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

 LDA #&00               \ Change the PPU address away from the palette entries
 STA PPU_ADDR           \ to prevent the palette being corrupted
 LDA #&00
 STA PPU_ADDR

 RTS                    \ Return from the subroutine

.palv3

                        \ If we get here then this is the Status Mode screen

 LDA #&3F               \ Set PPU_ADDR = &3F01, so it points to background
 STA PPU_ADDR           \ palette 0 in the PPU
 LDA #&01
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

 LDA #&00               \ Change the PPU address away from the palette entries
 STA PPU_ADDR           \ to prevent the palette being corrupted
 LDA #&00
 STA PPU_ADDR

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: SendPalettesToPPU
\       Type: Subroutine
\   Category: PPU
\    Summary: Send the palette data from XX3 to the PPU
\
\ ******************************************************************************

.SendPalettesToPPU

 LDA #&3F               \ Set PPU_ADDR = &3F01, so it points to background
 STA PPU_ADDR           \ palette 0 in the PPU
 LDA #&01
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

 SUBTRACT_CYCLES 559    \ Subtract 559 from the cycle count

 JMP SendScreenToPPU+4  \ Return to SendScreenToPPU to continue with the next
                        \ instruction following the call to this routine

\ ******************************************************************************
\
\       Name: SendScreenToPPU
\       Type: Subroutine
\   Category: PPU
\    Summary: Update the screen with the contents of the buffers
\
\ ------------------------------------------------------------------------------
\
\ Other entry points:
\
\   SendScreenToPPU+4   Re-entry point following the call to SendPalettesToPPU
\                       at the start of the routine
\
\ ******************************************************************************

.SendScreenToPPU

 LDA updatePaletteInNMI \ If updatePaletteInNMI is non-zero, then jump up to
 BNE SendPalettesToPPU  \ SendPalettesToPPU to send the palette data in XX3 to
                        \ the PPU, before continuing with the next instruction

 JSR SendBuffersToPPU   \ Send the contents of the nametable and pattern buffers
                        \ to the PPU to update the screen

 JSR SetPPURegisters    \ Set PPU_CTRL, PPU_ADDR and PPU_SCROLL for the current
                        \ hidden bitplane

 LDA cycleCount         \ Add 100 (&0064) to cycleCount
 CLC
 ADC #&64
 STA cycleCount
 LDA cycleCount+1
 ADC #&00
 STA cycleCount+1

 BMI upsc1              \ If the result is negative, jump to upsc1 to stop
                        \ sending PPU data in this VBlank, as we have run out of
                        \ cycles (we will pick up where we left off in the next
                        \ VBlank)

 JSR ClearBuffers       \ The result is positive, so we have enough cycles to
                        \ keep sending PPU data in this VBlank, so call
                        \ ClearBuffers to reset the buffers for both bitplanes

.upsc1

 LDA #%00011110         \ Configure the PPU by setting PPU_MASK as follows:
 STA PPU_MASK           \
                        \   * Bit 0 clear = normal colour (i.e. not monochrome)
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
\       Name: SetPPURegisters
\       Type: Subroutine
\   Category: PPU
\    Summary: Set PPU_CTRL, PPU_ADDR and PPU_SCROLL for the current palette
\             bitplane
\
\ ******************************************************************************

.SetPPURegisters

 LDX #%10010000         \ Set X to use as the value of PPU_CTRL for when
                        \ hiddenBitplane is 1:
                        \
                        \   * Bits 0-1    = base nametable address %00 (&2000)
                        \   * Bit 2 clear = increment PPU_ADDR by 1 each time
                        \   * Bit 3 clear = sprite pattern table is at &0000
                        \   * Bit 4 set   = background pattern table is at &1000
                        \   * Bit 5 clear = sprites are 8x8 pixels
                        \   * Bit 6 clear = use PPU 0 (the only option on a NES)
                        \   * Bit 7 set   = enable VBlank NMI generation

 LDA hiddenBitplane     \ If hiddenBitplane is non-zero (i.e. 1), skip the
 BNE resp1              \ following

 LDX #%10010001         \ Set X to use as the value of PPU_CTRL for when
                        \ hiddenBitplane is 0:
                        \
                        \   * Bits 0-1    = base nametable address %01 (&2400)
                        \   * Bit 2 clear = increment PPU_ADDR by 1 each time
                        \   * Bit 3 clear = sprite pattern table is at &0000
                        \   * Bit 4 set   = background pattern table is at &1000
                        \   * Bit 5 clear = sprites are 8x8 pixels
                        \   * Bit 6 clear = use PPU 0 (the only option on a NES)
                        \   * Bit 7 set   = enable VBlank NMI generation

.resp1

 STX PPU_CTRL           \ Configure the PPU with the above value of PPU_CTRL,
                        \ according to the hidden bitplane, so we set:
                        \
                        \   * Nametable 0 when hiddenBitplane = 1
                        \
                        \   * Nametable 1 when hiddenBitplane = 0
                        \
                        \ This makes sure that the screen shows the nametable
                        \ for the visible bitplane, and not the hidden bitplane

 STX ppuCtrlCopy        \ Store the new value of PPU_CTRL in ppuCtrlCopy so we
                        \ can check its value without having to access the PPU

 LDA #&20               \ If hiddenBitplane = 0 then set A = &24, otherwise set
 LDX hiddenBitplane     \ A = &20, to use as the high byte of the PPU_ADDR
 BNE resp2              \ address
 LDA #&24

.resp2

 STA PPU_ADDR           \ Set PPU_ADDR to point to the nametable address that we
 LDA #&00               \ just configured:
 STA PPU_ADDR           \
                        \   * &2000 (nametable 0) when hiddenBitplane = 1
                        \
                        \   * &2400 (nametable 1) when hiddenBitplane = 0
                        \
                        \ So we now flush the pipeline for the nametable that we
                        \ are showing on-screen, to avoid any corruption

 LDA PPU_DATA           \ Read from PPU_DATA eight times to clear the pipeline
 LDA PPU_DATA           \ and reset the internal PPU read buffer
 LDA PPU_DATA
 LDA PPU_DATA
 LDA PPU_DATA
 LDA PPU_DATA
 LDA PPU_DATA
 LDA PPU_DATA

 LDA #8                 \ Set the horizontal scroll to 8, so the leftmost tile
 STA PPU_SCROLL         \ on each row is scrolled around to the right side
                        \
                        \ This means that in terms of tiles, column 1 is the
                        \ left edge of the screen, then columns 2 to 31 form the
                        \ body of the screen, and column 0 is the right edge of
                        \ the screen

 LDA #0                 \ Set the vertical scroll to 0
 STA PPU_SCROLL

 RTS                    \ Return from the subroutine

INCLUDE "library/nes/main/subroutine/setpputablesto0.asm"

\ ******************************************************************************
\
\       Name: ClearBuffers
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: If there are enough free cycles, clear down the nametable and
\             pattern buffers for both bitplanes
\
\ ******************************************************************************

.ClearBuffers

 LDA cycleCount+1       \ If the high byte of cycleCount(1 0) is zero, then the
 BEQ cbuf3              \ cycle count is 255 or less, so jump to cbuf3 to skip
                        \ the buffer clearing, as we have run out of cycles (we
                        \ will pick up where we left off in the next VBlank)

 SUBTRACT_CYCLES 363    \ Subtract 363 from the cycle count

 BMI cbuf1              \ If the result is negative, jump to cbuf1 to skip the
                        \ buffer clearing, as we have run out of cycles (we
                        \ will pick up where we left off in the next VBlank)

 JMP cbuf2              \ The result is positive, so we have enough cycles to
                        \ clear the buffers, so jump to cbuf2 to do just that

.cbuf1

 ADD_CYCLES 318         \ Add 318 to the cycle count

 JMP cbuf3              \ Jump to cbuf3 to skip the buffer clearing and return
                        \ from the subroutine

.cbuf2

 LDA clearBlockSize     \ Store clearBlockSize(1 0) and clearAddress(1 0) on the
 PHA                    \ stack, so we can use them in the ClearPlaneBuffers
 LDA clearBlockSize+1   \ routine and can restore them to their original values
 PHA                    \ afterwards (in case the NMI handler was called while
 LDA clearAddress       \ these variables are being used)
 PHA
 LDA clearAddress+1
 PHA

 LDX #0                 \ Call ClearPlaneBuffers with X = 0 to clear the buffers
 JSR ClearPlaneBuffers  \ for bitplane 0

 LDX #1                 \ Call ClearPlaneBuffers with X = 1 to clear the buffers
 JSR ClearPlaneBuffers  \ for bitplane 1

 PLA                    \ Retore clearBlockSize(1 0) and clearAddress(1 0) from
 STA clearAddress+1     \ the stack
 PLA
 STA clearAddress
 PLA
 STA clearBlockSize+1
 PLA
 STA clearBlockSize

 ADD_CYCLES_CLC 238     \ Add 238 to the cycle count

.cbuf3

                        \ This part of the routine repeats the code in cbuf5
                        \ until we run out of cycles, though as cbuf5 only
                        \ contains NOPs, this doesn't achieve anything other
                        \ than running down the cycle counter (perhaps it's
                        \ designed to even out each call to the NMI handler,
                        \ or is just left over from development)

 SUBTRACT_CYCLES 32     \ Subtract 32 from the cycle count

 BMI cbuf4              \ If the result is negative, jump to cbuf4 to return
                        \ from the subroutine, as we have run out of cycles

 JMP cbuf5              \ The result is positive, so we have enough cycles to
                        \ continue, so jump to cbuf5

.cbuf4

 ADD_CYCLES 65527       \ Add 65527 to the cycle count (i.e. subtract 9) ???

 JMP cbuf6              \ Jump to cbuf6 to return from the subroutine

.cbuf5

 NOP                    \ This looks like code that has been removed
 NOP
 NOP

 JMP cbuf3              \ Jump back to cbuf3 to check the cycle count and keep
                        \ running the above until the cycle count runs out

.cbuf6

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: ReadControllers
\       Type: Subroutine
\   Category: Controllers
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
 BEQ RTS3

\ ******************************************************************************
\
\       Name: ScanButtons
\       Type: Subroutine
\   Category: Controllers
\    Summary: ???
\
\ ------------------------------------------------------------------------------
\
\ Other entry points:
\
\   RTS3                Contains an RTS
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

.RTS3

 RTS

\ ******************************************************************************
\
\       Name: WaitForNextFrame
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Wait until the frame counter increments (i.e. the next VBlank)
\
\ ******************************************************************************

.WaitForNextFrame

 LDA frameCounter       \ Set A to the frame counter, which increments with each
                        \ call to the NMI handler

.wfrm1

 CMP frameCounter       \ Loop back to wfrm1 until the frame counter changes,
 BEQ wfrm1              \ which will happen when the NMI handler has been called
                        \ again (i.e. at the next VBlank)

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: WaitFor2NMIs
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Wait until two NMI interrupts have passed (i.e. the next two
\             VBlanks)
\
\ ------------------------------------------------------------------------------
\
\ Returns:
\
\   A                   A is preserved
\
\ ******************************************************************************

.WaitFor2NMIs

 JSR WaitForNMI         \ Wait until the next NMI interrupt has passed (i.e. the
                        \ next VBlank)

                        \ Fall through into WaitForNMI to wait for the second
                        \ NMI interrupt

\ ******************************************************************************
\
\       Name: WaitForNMI
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Wait until the next NMI interrupt has passed (i.e. the next
\             VBlank)
\
\ ------------------------------------------------------------------------------
\
\ Returns:
\
\   A                   A is preserved
\
\ ******************************************************************************

.WaitForNMI

 PHA                    \ Store A on the stack to preserve it

 LDX frameCounter       \ Set X to the frame counter, which increments with each
                        \ call to the NMI handler

.wnmi1

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 CPX frameCounter       \ Loop back to wnmi1 until the frame counter changes,
 BEQ wnmi1              \ which will happen when the NMI handler has been called
                        \ again (i.e. at the next VBlank)

 PLA                    \ Retrieve A from the stack so that it's preserved

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: WaitForIconBarPPU
\       Type: Subroutine
\   Category: PPU
\    Summary: Wait until the PPU starts drawing the icon bar
\
\ ******************************************************************************

.WaitForIconBarPPU

 LDA setupPPUForIconBar \ Loop back to the start until setupPPUForIconBar is
 BEQ WaitForIconBarPPU  \ non-zero, at which point the SETUP_PPU_FOR_ICON_BAR
                        \ macro and SetupPPUForIconBar routine are checking to
                        \ see whether the icon bar is being drawn by the PPU

.wbar1

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA setupPPUForIconBar \ Loop back until setupPPUForIconBar is zero, at which
 BNE wbar1              \ point the icon bar is being drawn by the PPU

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: ClearDrawingPlane (Part 1 of 3)
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Clear the nametable and pattern buffers for the newly flipped
\             drawing plane
\
\ ------------------------------------------------------------------------------
\
\ This routine is only called when we have just flipped the drawing plane
\ between 0 and 1 in the FlipDrawingPlane routine.
\
\ Arguments:
\
\   X                   The drawing bitplane to clear
\
\ ******************************************************************************

 LDX #0                 \ This code is never called, but it provides an entry
 JSR ClearDrawingPlane  \ point for clearing both bitplanes, which would have
 LDX #1                 \ been useful during development

.ClearDrawingPlane

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA bitplaneFlags,X    \ If the flags for the new drawing bitplane are zero
 BEQ cdra2              \ then the bitplane's buffers are already clear (as we
                        \ will have zeroed the flags in cdra1 following a
                        \ successful clearance), so jump to cdra2 to return
                        \ from the subroutine

 AND #%00100000         \ If bit 5 of the bitplane flags is set, then we have
 BNE cdra1              \ already sent all the data to the PPU for this
                        \ bitplane, so jump to cdra1 to clear the buffers in
                        \ their entirety

 JSR cdra3              \ If we get here then bit 5 of the bitplane flags is
                        \ clear, which means we have not already sent all the
                        \ data to the PPU for this bitplane, so call cdra3 below
                        \ to clear out as much buffer space as we can for now

 JMP ClearDrawingPlane  \ Jump back to the start of the routine so we keep
                        \ clearing as much buffer space as we can until all the
                        \ data has been sent to the PPU (at which point bit 5
                        \ will be set and we will take the cdra1 branch instead)

.cdra1

 JSR cdra3              \ If we get here then bit 5 of the bitplane flags is
                        \ set, which means we have already sent all the data to
                        \ the PPU for this bitplane, so call cdra3 below to
                        \ clear out all remaining buffer space for this bitplane

 LDA #0                 \ Set the new drawing bitplane flags as follows:
 STA bitplaneFlags,X    \
                        \   * Bit 2 clear = send tiles up to configured numbers
                        \   * Bit 3 clear = don't clear buffers after sending
                        \   * Bit 4 clear = we've not started sending data yet
                        \   * Bit 5 clear = we have not yet sent all the data
                        \   * Bit 6 clear = only send pattern data to the PPU
                        \   * Bit 7 clear = do not send data to the PPU
                        \
                        \ Bits 0 and 1 are ignored and are always clear

 LDA firstPatternTile   \ Set the next free tile number in firstFreeTile to the
 STA firstFreeTile      \ value of firstPatternTile, which contains the number
                        \ of the first tile we just cleared, so it's also the
                        \ tile we can start drawing into when we next start
                        \ drawing into tiles

 JMP DrawBoxTop         \ Draw the top of the box into the new drawing bitplane,
                        \ returning from the subroutine using a tail call

.cdra2

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: ClearDrawingPlane (Part 2 of 3)
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Clear the nametable buffers for the newly flipped drawing plane
\
\ ******************************************************************************

.cdra3

 LDY frameCounter       \ Set Y to the frame counter, which is incremented every
                        \ VBlank by the NMI handler

 LDA sendingNameTile,X  \ Set SC to sendingNameTile for this bitplane, which
 STA SC                 \ contains the number of the last tile that was sent to
                        \ the PPU nametable by the NMI handler, divided by 8
                        \
                        \ So this contains the number of the last tile we need
                        \ to clear in the nametable buffer, divided by 8

 LDA clearingNameTile,X \ Set A to clearingNameTile for this bitplane, which
                        \ contains the number of the first tile we need to
                        \ clear in the nametable buffer, divided by 8

 CPY frameCounter       \ If the frame counter has incremented since we fetched
 BNE cdra3              \ it above, then the tile numbers we just fetched might
                        \ already be out of date (as the NMI handler runs at
                        \ every VBlank, so it may have been run between now and
                        \ the frameCounter fetch above), so jump back to cdra3
                        \ to fetch them all again

 LDY SC                 \ Set Y to the number of the last tile divided by 8,
                        \ which we fetched above

 CPY maxNameTileToClear \ If Y >= maxNameTileToClear then set Y to the value of
 BCC cdra4              \ maxNameTileToClear, so Y is capped to a maximum value
 LDY maxNameTileToClear \ of maxNameTileToClear

.cdra4

 STY SC                 \ Set SC to the number of the last tile, capped by the
                        \ maximum value in maxNameTileToClear

 CMP SC                 \ If A >= SC then the first tile we need to clear is
 BCS cdra6              \ after the last tile we need to clear, which means
                        \ there are no nametable tiles to clear, so jump to
                        \ to cdra6 to move on to clearing the pattern buffer
                        \ in part 3

 STY clearingNameTile,X \ Set clearingNameTile to the number of the last tile
                        \ to clear, if we don't clear the whole buffer here
                        \ (which will be the case if the buffer is still being
                        \ sent to the PPU), then we can pick it up again from
                        \ the tile after the batch we are about to clear

 LDY #0                 \ Set clearAddress(1 0) = (nameBufferHiAddr 0) + A * 8
 STY clearAddress+1     \                  = (nameBufferHiAddr 0) + first tile
 ASL A                  \
 ROL clearAddress+1     \ So clearAddress(1 0) contains the address in this
 ASL A                  \ bitplane's nametable buffer of the first tile we sent 
 ROL clearAddress+1
 ASL A
 STA clearAddress
 LDA clearAddress+1
 ROL A
 ADC nameBufferHiAddr,X
 STA clearAddress+1

 LDA #0                 \ Set SC(1 0) = (0 SC) * 8 + (nameBufferHiAddr 0)
 ASL SC                 \
 ROL A                  \ So SC(1 0) contains the address in this bitplane's
 ASL SC                 \ nametable buffer of the last tile we sent
 ROL A
 ASL SC
 ROL A
 ADC nameBufferHiAddr,X
 STA SC+1

.cdra5

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA SC                 \ Set clearBlockSize(1 0) = SC(1 0) - clearAddress(1 0)
 SEC                    \
 SBC clearAddress       \ So clearBlockSize(1 0) contains the number of tiles we
 STA clearBlockSize     \ already sent from this bitplane's nametable buffer
 LDA SC+1               \
 SBC clearAddress+1     \ If the subtraction underflows, then there are no tiles
 BCC cdra6              \ to send, so jump to cdra6 to move on to clearing the
 STA clearBlockSize+1   \ pattern buffer in part 3

                        \ By this point, clearBlockSize(1 0) contains the number
                        \ of tiles we sent from this bitplane's nametable
                        \ buffer, so it contains the number of nametable entries
                        \ we need to clear
                        \
                        \ Also, clearAddress(1 0) contains the address of the
                        \ first tile we sent from this bitplane's nametable
                        \ buffer

 ORA clearBlockSize     \ If both the high and low bytes of clearBlockSize(1 0)
 BEQ cdra6              \ are zero, then there are no tiles to clear, so jump to
                        \ cdra6 to clear the pattern buffer

 LDA #HI(790)           \ Set cycleCount = 790, so the call to ClearMemory
 STA cycleCount+1       \ doesn't run out of cycles and quit early (we are not
 LDA #LO(790)           \ in the NMI handler, so we don't need to count cycles,
 STA cycleCount         \ so this just ensures that the cycle-counting checks
                        \ are not triggered)

 JSR ClearMemory        \ Call ClearMemory to zero clearBlockSize(1 0) nametable
                        \ entries from address clearAddress(1 0) onwards

 JMP cdra5              \ The above should clear the whole block, but if the NMI
                        \ handler is called at VBlank while we are doing this,
                        \ then cycleCount may end up ticking down to zero while
                        \ we are still clearing memory, which would abort the
                        \ call to ClearMemory early, so we now loop back to
                        \ cdra5 to pick up where we left off, eventually exiting
                        \ the loop via the BCC cdra6 instruction above (at which
                        \ point we know for sure that we have cleared the whole
                        \ block)

\ ******************************************************************************
\
\       Name: ClearDrawingPlane (Part 3 of 3)
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Clear the nametable buffers for the newly flipped drawing plane
\
\ ******************************************************************************

.cdra6

 LDY frameCounter       \ Set Y to the frame counter, which is incremented every
                        \ VBlank by the NMI handler

 LDA sendingPattTile,X  \ Set SC to sendingPattTile for this bitplane, which
 STA SC                 \ contains the number of the last tile that was sent to
                        \ the PPU pattern table by the NMI handler
                        \
                        \ So this contains the number of the last tile we need
                        \ to clear in the pattern buffer

 LDA clearingPattTile,X \ Set A to clearingPattTile for this bitplane, which
                        \ contains the number of the first tile we need
                        \ to clear in the pattern buffer

 CPY frameCounter       \ If the frame counter has incremented since we fetched
 BNE cdra6              \ it above, then the tile numbers we just fetched might
                        \ already be out of date (as the NMI handler runs at
                        \ every VBlank, so it may have been run between now and
                        \ the frameCounter fetch above), so jump back to cdra6
                        \ to fetch them all again

 LDY SC                 \ Set Y to the number of the last tile, which we fetched
                        \ above

 CMP SC                 \ If A >= SC then the first tile we need to clear is
 BCS cdra8              \ after the last tile we need to clear, which means
                        \ there are no pattern entries to clear, so jump to
                        \ to cdra8 to return from the subroutine as we are done

 STY clearingPattTile,X \ Set clearingPattTile to the number of the last tile
                        \ to clear, if we don't clear the whole buffer here
                        \ (which will be the case if the buffer is still being
                        \ sent to the PPU), then we can pick it up again from
                        \ the tile after the batch we are about to clear

 LDY #0                 \ Set clearAddress(1 0) = (pattBufferHiAddr 0) + A * 8
 STY clearAddress+1     \                  = (pattBufferHiAddr 0) + first tile
 ASL A                  \
 ROL clearAddress+1     \ So clearAddress(1 0) contains the address in this
 ASL A                  \ bitplane's pattern buffer of the first tile we sent 
 ROL clearAddress+1
 ASL A
 STA clearAddress
 LDA clearAddress+1
 ROL A
 ADC pattBufferHiAddr,X
 STA clearAddress+1

 LDA #0                 \ Set SC(1 0) = (0 SC) * 8 + (pattBufferHiAddr 0)
 ASL SC                 \
 ROL A                  \ So SC(1 0) contains the address in this bitplane's
 ASL SC                 \ pattern buffer of the last tile we sent
 ROL A
 ASL SC
 ROL A
 ADC pattBufferHiAddr,X
 STA SC+1

.cdra7

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA SC                 \ Set clearBlockSize(1 0) = SC(1 0) - clearAddress(1 0)
 SEC                    \
 SBC clearAddress       \ So clearBlockSize(1 0) contains the number of tiles we
 STA clearBlockSize     \ already sent from this bitplane's pattern buffer
 LDA SC+1               \
 SBC clearAddress+1     \ If the subtraction underflows, then there are no tiles
 BCC cdra6              \ to send, so jump to cdra6 to make sure we have cleared
 STA clearBlockSize+1   \ the whole pattern buffer

                        \ By this point, clearBlockSize(1 0) contains the number
                        \ of tiles we sent from this bitplane's pattern buffer,
                        \ so it contains the number of pattern entries we need
                        \ to clear
                        \
                        \ Also, clearAddress(1 0) contains the address of the
                        \ first tile we sent from this bitplane's pattern buffer

 ORA clearBlockSize     \ If both the high and low bytes of clearBlockSize(1 0)
 BEQ cdra8              \ are zero, then there are no tiles to clear, so jump to
                        \ cdra8 to return from the subroutine, as we are done

 LDA #HI(790)           \ Set cycleCount = 790, so the call to ClearMemory
 STA cycleCount+1       \ doesn't run out of cycles and quit early (we are not
 LDA #LO(790)           \ in the NMI handler, so we don't need to count cycles,
 STA cycleCount         \ so this just ensures that the cycle-counting checks
                        \ are not triggered)

 JSR ClearMemory        \ Call ClearMemory to zero clearBlockSize(1 0) nametable
                        \ entries from address clearAddress(1 0) onwards


 JMP cdra7              \ The above should clear the whole block, but if the NMI
                        \ handler is called at VBlank while we are doing this,
                        \ then cycleCount may end up ticking down to zero while
                        \ we are still clearing memory, which would abort the
                        \ call to ClearMemory early, so we now loop back to
                        \ cdra7 to pick up where we left off, eventually exiting
                        \ the loop via the BCC cdra6 instruction above (at which
                        \ point we know for sure that we have cleared the whole
                        \ block)

.cdra8

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: flagsForClearing
\       Type: Variable
\   Category: Drawing the screen
\    Summary: A bitplane mask to control how bitplane buffer clearing works in
\             the ClearPlaneBuffers routine
\
\ ******************************************************************************

.flagsForClearing

 EQUB %00110000         \ The bitplane flags with ones in this byte must be
                        \ clear for the clearing process in ClearPlaneBuffers
                        \ to be activated
                        \
                        \ So this configuration means that clearing will only be
                        \ attempted on bitplanes where:
                        \
                        \   * We are in the process of sending this bitplane's
                        \     data to the PPU (bit 4 is set)
                        \
                        \   * We have already sent all the data to the PPU for
                        \     this bitplane (bit 5 is set)
                        \
                        \ If both bitplane flags are clear, then the buffers are
                        \ not cleared
                        \
                        \ Note that this is separate from bit 3, which controls
                        \ whether clearing is enabled and which overrides the
                        \ above (bit 2 must be set for any clearing to take
                        \ place)

\ ******************************************************************************
\
\       Name: ClearPlaneBuffers (Part 1 of 2)
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Clear the nametable and pattern buffers of data that has already
\             been sent to the PPU, starting with the nametable buffer
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X                   The bitplane to clear
\
\ ******************************************************************************

.pbuf1

 NOP                    \ This looks like code that has been removed
 NOP

.pbuf2

 SUBTRACT_CYCLES 39     \ Subtract 39 from the cycle count

.pbuf3

 RTS                    \ Return from the subroutine

.pbuf4

 ADD_CYCLES_CLC 126     \ Add 126 to the cycle count

 JMP pbuf13             \ Jump to pbuf13 in part 2 to consider clearing the
                        \ pattern buffer

.ClearPlaneBuffers

 LDA cycleCount+1       \ If the high byte of cycleCount(1 0) is zero, then the
 BEQ pbuf3              \ cycle count is 255 or less, so jump to pbuf3 to skip
                        \ the buffer clearing, as we have run out of cycles (we
                        \ will pick up where we left off in the next VBlank)

 LDA bitplaneFlags,X    \ If both bits 4 and 5 of the current bitplane flags are
 BIT flagsForClearing   \ clear, then this means:
 BEQ pbuf1              \ 
                        \   * Bit 4 clear = we've not started sending data yet
                        \   * Bit 5 clear = we have not yet sent all the data
                        \
                        \ So we are not currently sending tile data to the PPU
                        \ for this bitplane, and we have not already sent the
                        \ data, so we do not need to clear this bitplane as we
                        \ only do so after sending its data to the PPU, which
                        \ we are not currently doing

 AND #%00001000         \ If bit 3 of the of the current bitplane flags is
 BEQ pbuf2              \ clear, then this bitplane is configured not to be
                        \ cleared after it has been sent to the PPU, so jump to
                        \ pbuf2 to return from the subroutine withough clearing
                        \ the buffers

                        \ If we get here then we are either in the process of
                        \ sending this bitplane's data to the PPU, or we have
                        \ already sent it, and the bitplane is configured to be
                        \ cleared
                        \
                        \ If we have already sent the data to the PPU, then we
                        \ no longer need it, so we need to clear the buffers so
                        \ they are blank and ready to be drawn for the next
                        \ frame
                        \
                        \ If we are still in the process of sending this
                        \ bitplane's data to the PPU, then we can clear the
                        \ buffers up to the point where we have sent the data,
                        \ as we don't need to keep any data that we have sent
                        \
                        \ The following routine clears the buffers from the
                        \ first tile we sent, up to the tile numbers given by
                        \ sendingNameTile and sendingPattTile, which will work
                        \ in both cases, whether or not we have finished sending
                        \ all the data to the PPU

 SUBTRACT_CYCLES 213    \ Subtract 213 from the cycle count

 BMI pbuf5              \ If the result is negative, jump to pbuf5 to skip the
                        \ buffer clearing, as we have run out of cycles (we
                        \ will pick up where we left off in the next VBlank)

 JMP pbuf6              \ The result is positive, so we have enough cycles to
                        \ clear the buffers, so jump to pbuf6 to do just that

.pbuf5

 ADD_CYCLES 153         \ Add 153 to the cycle count

 JMP pbuf3              \ Jump to pbuf3 to skip the buffer clearing and return
                        \ from the subroutine

.pbuf6

 LDA clearingNameTile,X \ Set A to clearingNameTile for this bitplane, which
                        \ contains the number of the first tile we need to
                        \ clear in the nametable buffer, divided by 8

 LDY sendingNameTile,X  \ Set Y to sendingNameTile for this bitplane, which we
                        \ used in SendNametableToPPU to keep track of the
                        \ current tile number as we sent them to the PPU
                        \ nametable, so this contains the number of the last
                        \ tile, divided by 8, that we sent to the PPU nametable
                        \ for this bitplane
                        \
                        \ So this contains the number of the last tile we need
                        \ to clear in the nametable buffer, divided by 8

 CPY maxNameTileToClear \ If Y >= maxNameTileToClear then set Y to the value of
 BCC pbuf7              \ maxNameTileToClear, so Y is capped to a maximum value
 LDY maxNameTileToClear \ of maxNameTileToClear

.pbuf7

 STY clearBlockSize     \ Set clearBlockSize to the number of the last tile we
                        \ need to clear, divided by 8

 CMP clearBlockSize     \ If A >= clearBlockSize, then the first tile we need to
 BCS pbuf4              \ clear is after the last tile we need to clear, which
                        \ means there are no nametable tiles to clear, so jump
                        \ to pbuf4 to move on to clearing the pattern buffer in
                        \ part 2

 LDY #0                 \ Set clearAddress(1 0) = (nameBufferHiAddr 0) + A * 8
 STY clearAddress+1     \                  = (nameBufferHiAddr 0) + first tile
 ASL A                  \
 ROL clearAddress+1     \ So clearAddress(1 0) contains the address of the first
 ASL A                  \ tile we sent in this bitplane's nametable buffer
 ROL clearAddress+1
 ASL A
 STA clearAddress
 LDA clearAddress+1
 ROL A
 ADC nameBufferHiAddr,X
 STA clearAddress+1

 LDA #0                 \ Set clearBlockSize(1 0) = (0 clearBlockSize) * 8
 ASL clearBlockSize     \                           + (nameBufferHiAddr 0)
 ROL A                  \                  = (nameBufferHiAddr 0) + last tile
 ASL clearBlockSize     \
 ROL A                  \ So clearBlockSize(1 0) points to the address of the
 ASL clearBlockSize     \ last tile we sent in this bitplane's nametable buffer
 ROL A
 ADC nameBufferHiAddr,X
 STA clearBlockSize+1

 LDA clearBlockSize     \ Set clearBlockSize(1 0)
 SEC                    \        = clearBlockSize(1 0) - clearAddress(1 0)
 SBC clearAddress       \
 STA clearBlockSize     \ So clearBlockSize(1 0) contains the number of tiles we
 LDA clearBlockSize+1   \ already sent from this bitplane's nametable buffer
 SBC clearAddress+1     \
 BCC pbuf8              \ If the subtraction underflows, then there are no tiles
 STA clearBlockSize+1   \ to send, so jump to pbuf8 to move on to clearing the
                        \ pattern buffer in part 2

                        \ By this point, clearBlockSize(1 0) contains the number
                        \ of tiles we sent from this bitplane's nametable
                        \ buffer, so it contains the number of nametable entries
                        \ we need to clear
                        \
                        \ Also, clearAddress(1 0) contains the address of the
                        \ first tile we sent from this bitplane's nametable
                        \ buffer

 ORA clearBlockSize     \ If both the high and low bytes of clearBlockSize(1 0)
 BEQ pbuf9              \ are zero, then there are no tiles to clear, so jump to
                        \ pbuf9 and on to part 2 to consider clearing the
                        \ pattern buffer

 JSR ClearMemory        \ Call ClearMemory to zero clearBlockSize(1 0) nametable
                        \ entries from address clearAddress(1 0) onwards
                        \
                        \ If we run out of cycles in the current VBlank, then
                        \ this may not clear the whole block, so it updates
                        \ clearBlockSize(1 0) and clearAddress(1 0) as it clears
                        \ so we can pick it up in the next VBlank

 LDA clearAddress+1     \ Set (A clearAddress)
 SEC                    \     = clearAddress(1 0) - (nameBufferHiAddr 0)
 SBC nameBufferHiAddr,X

 LSR A                  \ Set A to the bottom byte of (A clearAddress) / 8
 ROR clearAddress       \
 LSR A                  \ This effectively reverses the calculation we did
 ROR clearAddress       \ above, so A contains the number of the next tile
 LSR A                  \ we need to clear, as returned by ClearMemory, divided
 LDA clearAddress       \ by 8
 ROR A                  \
                        \ We only need to take the low byte, as we know the high
                        \ byte will be zero after this many shifts, as that's
                        \ how we built the value of clearAddress(1 0) above

 CMP clearingNameTile,X \ If A >= clearingNameTile then we did manage to clear
 BCC pbuf12             \ some nametable entries in ClearMemory, so update the
 STA clearingNameTile,X \ value of clearingNameTile with the new first tile
                        \ number so the next call to this routine will pick up
                        \ where we left off

 JMP pbuf13             \ Jump to pbuf13 in part 2 to consider clearing the
                        \ pattern buffer

.pbuf8

 NOP                    \ This looks like code that has been removed
 NOP
 NOP
 NOP

.pbuf9

 ADD_CYCLES_CLC 28      \ Add 28 to the cycle count

 JMP pbuf13             \ Jump to pbuf13 in part 2 to consider clearing the
                        \ pattern buffer

.pbuf10

 ADD_CYCLES_CLC 126     \ Add 126 to the cycle count

.pbuf11

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: ClearPlaneBuffers (Part 2 of 2)
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Clear the pattern buffer of data that has already been sent to the
\             PPU for the current bitplane
\
\ ******************************************************************************

.pbuf12

 NOP                    \ This looks like code that has been removed
 NOP
 NOP

.pbuf13

 SUBTRACT_CYCLES 187    \ Subtract 187 from the cycle count

 BMI pbuf14             \ If the result is negative, jump to pbuf14 to skip the
                        \ pattern buffer clearing, as we have run out of cycles
                        \ (we will pick up where we left off in the next VBlank)

 JMP pbuf15             \ The result is positive, so we have enough cycles to
                        \ clear the pattern buffer, so jump to pbuf15 to do just
                        \ that

.pbuf14

 ADD_CYCLES 146         \ Add 146 to the cycle count

 JMP pbuf11             \ Jump to pbuf11 to return from the subroutine

.pbuf15

 LDA clearingPattTile,X \ Set A to clearingPattTile for this bitplane, which
                        \ contains the number of the first tile we need
                        \ to clear in the pattern buffer

 LDY sendingPattTile,X  \ Set Y to sendingPattTile for this bitplane, which we
                        \ used in SendPatternsToPPU to keep track of the current
                        \ tile number as we sent them to the PPU pattern table,
                        \ so this contains the number of the last tile that we
                        \ sent to the PPU pattern table for this bitplane
                        \
                        \ So this contains the number of the last tile we need
                        \ to clear in the nametable buffer

 STY clearBlockSize     \ Set clearBlockSize to the number of the last tile we
                        \ need to clear

 CMP clearBlockSize     \ If A >= clearBlockSize, then the first tile we need to
 BCS pbuf10             \ clear is after the last tile we need to clear, which
                        \ means there are no nametable tiles to clear, so jump
                        \ to pbuf10 to return from the subroutine

 NOP                    \ This looks like code that has been removed

 LDY #0                 \ Set clearAddress(1 0) = (pattBufferHiAddr 0) + A * 8
 STY clearAddress+1     \                  = (pattBufferHiAddr 0) + first tile
 ASL A                  \
 ROL clearAddress+1     \ So clearAddress(1 0) contains the address of the first
 ASL A                  \ tile we sent in this bitplane's pattern buffer
 ROL clearAddress+1
 ASL A
 STA clearAddress
 LDA clearAddress+1
 ROL A
 ADC pattBufferHiAddr,X
 STA clearAddress+1

 LDA #0                 \ Set clearBlockSize(1 0) = (0 clearBlockSize) * 8
 ASL clearBlockSize     \                           + (pattBufferHiAddr 0)
 ROL A                  \                  = (pattBufferHiAddr 0) + last tile
 ASL clearBlockSize     \
 ROL A                  \ So clearBlockSize(1 0) points to the address of the
 ASL clearBlockSize     \ last tile we sent in this bitplane's pattern buffer
 ROL A
 ADC pattBufferHiAddr,X
 STA clearBlockSize+1

 LDA clearBlockSize     \ Set clearBlockSize(1 0)
 SEC                    \        = clearBlockSize(1 0) - clearAddress(1 0)
 SBC clearAddress       \
 STA clearBlockSize     \ So clearBlockSize(1 0) contains the number of tiles we
 LDA clearBlockSize+1   \ already sent from this bitplane's pattern buffer
 SBC clearAddress+1
 BCC pbuf16
 STA clearBlockSize+1
 ORA clearBlockSize
 BEQ pbuf17

 JSR ClearMemory        \ Call ClearMemory to zero clearBlockSize(1 0) pattern
                        \ buffer bytes from address clearAddress(1 0) onwards

 LDA clearAddress+1     \ Set (A clearAddress)
 SEC                    \     = clearAddress(1 0) - (pattBufferHiAddr 0)
 SBC pattBufferHiAddr,X

 LSR A                  \ Set A to the bottom byte of (A clearAddress) / 8
 ROR clearAddress       \
 LSR A                  \ This effectively reverses the calculation we did
 ROR clearAddress       \ above, so A contains the number of the next tile
 LSR A                  \ we need to clear, as returned by ClearMemory, divided
 LDA clearAddress       \ by 8
 ROR A                  \
                        \ We only need to take the low byte, as we know the high
                        \ byte will be zero after this many shifts, as that's
                        \ how we built the value of clearAddress(1 0) above

 CMP clearingPattTile,X \ If A >= clearingPattTile then we did manage to clear
 BCC pbuf16             \ some pattern bytes in ClearMemory, so update the
 STA clearingPattTile,X \ value of clearingPattTile with the new first tile
                        \ number so the next call to this routine will pick up
                        \ where we left off

 RTS                    \ Return from the subroutine

.pbuf16

 NOP                    \ This looks like code that has been removed
 NOP
 NOP
 NOP

 RTS                    \ Return from the subroutine

.pbuf17

 ADD_CYCLES_CLC 35      \ Add 35 to the cycle count

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: FillMemory
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Fill a block of memory with a specified value
\
\ ------------------------------------------------------------------------------
\
\ When called directly, this routine fills a whole page of memory (256 bytes)
\ with the value in A.
\
\ It can also be called at an arbitrary entry point to fill a specified number
\ of locations, anywhere from 0 to 255 bytes. The entry point is calculated as
\ as an offset backwards from the end of the FillMemory32Bytes routine (which
\ ends at ClearMemory), such that jumping to this entry point will fill the
\ required number of bytes. Each FILL_MEMORY macro call takes up three bytes
\ (two bytes for the STA (clearAddress),Y and one for the INY), so the
\ calculation is essentially:
\
\   ClearMemory - 1 - (3 * clearBlockSize)
\
\ where clearBlockSize is the size of the block to clear, in bytes. See the
\ ClearMemory routine for an example of this calculation in action.
\
\ Arguments:
\
\   clearAddress(1 0)   The base address of the block of memory to fill
\
\   Y                   The index into clearAddress(1 0) from which to fill
\
\   A                   The value to fill
\
\ Returns:
\
\   Y                   The index in Y is updated to point to the byte after the
\                       filled block
\
\ ******************************************************************************

.FillMemory

 FILL_MEMORY 224        \ Fill 224 bytes at clearAddress(1 0) + Y with A

                        \ Falling through into FillMemory32Bytes to fill another
                        \ 32 bytes, bringing the total to 256

\ ******************************************************************************
\
\       Name: FillMemory32Bytes
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Fill a 32-byte block of memory with a specified value
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   clearAddress(1 0)   The base address of the block of memory to fill
\
\   Y                   The index into clearAddress(1 0) from which to fill
\
\   A                   The value to fill
\
\ Returns:
\
\   Y                   The index in Y is updated to point to the byte after the
\                       filled block
\
\ ******************************************************************************

.FillMemory32Bytes

 FILL_MEMORY 32         \ Fill 32 bytes at clearAddress(1 0) + Y with A

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: ClearMemory
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Clear a block of memory, split across multiple calls if required
\
\ ------------------------------------------------------------------------------
\
\ This routine clears a block of memory, but only if there are enough cycles in
\ the cycle count. If it runs out of cycles, it will pick up where it left off
\ when called again.
\
\ Arguments:
\
\   clearAddress        The address of the block to clear
\
\   clearBlockSize      The size of the block to clear as a 16-bit number, must
\                       be a multiple of 8 bytes
\
\ Returns:
\
\   clearAddress        The address of the next byte to clear in the block,
\                       ready for the next call (if the whole block was not
\                       cleared)
\
\   clearBlockSize      The size of the block, reduced by the number of bytes
\                       cleared in the current call, so it's ready for the next
\                       call (this will be 0 if this call cleared the whole
\                       block)
\
\ ******************************************************************************

.ClearMemory

 LDA clearBlockSize+1   \ If the high byte of the block size is zero, then jump
 BEQ cmem8              \ to cmem8 to clear a block of fewer than 256 bytes

                        \ If we get here then the high byte of the block size is
                        \ non-zero, so the block we need to clear consists of
                        \ one or more page-sized blocks (i.e. 256-byte blocks),
                        \ as well as one block with fewer than 256 bytes
                        \
                        \ We now concentrate on clearing the page-sized blocks,
                        \ leaving the block with fewer than 256 bytes for the
                        \ next VBlank

                        \ First we consider whether we can clear a block of 256
                        \ bytes

 SUBTRACT_CYCLES 2105   \ Subtract 2105 from the cycle count

 BMI cmem1              \ If the result is negative, jump to cmem1 to consider
                        \ clearing a 32-byte block in this VBlank, as we don't
                        \ have enough cycles for a 256-byte block

 JMP cmem2              \ The result is positive, so we have enough cycles to
                        \ clear a 256-byte block in this VBlank, so jump to
                        \ cmem2 to do just that

.cmem1

 ADD_CYCLES 2059        \ Add 2059 to the cycle count

 JMP cmem3              \ Jump to cmem3 to consider clearing the block with
                        \ fewer than 256 bytes

.cmem2

 LDA #0                 \ Set A = 0 so the call to FillMemory zeroes the memory
                        \ block

 LDY #0                 \ Set an index in Y to pass to FillMemory, so we start
                        \ clearing memory from clearAddress(1 0) onwards

 JSR FillMemory         \ Call FillMemory to clear a whole 256-byte block of
                        \ memory at clearAddress(1 0)

 DEC clearBlockSize+1   \ Decrement the high byte of clearBlockSize(1 0), which
                        \ is the same as subtracting 256, as we just cleared 256
                        \ bytes of memory

 INC clearAddress+1     \ Increment the high byte of clearAddress(1 0) to point
                        \ at the next 256-byte block of memory after the block
                        \ we just cleared, so we clear that next

 JMP ClearMemory        \ Jump back to ClearMemory to consider clearing the next
                        \ 256 bytes of memory

.cmem3

                        \ If we get here then we did not have enough cycles to
                        \ send a 256-byte block

                        \ Now we consider whether we can clear a block of 32
                        \ bytes

 SUBTRACT_CYCLES 318    \ Subtract 318 from the cycle count

 BMI cmem4              \ If the result is negative, jump to cmem4 to skip
                        \ clearing the next 32-byte block in this VBlank, as we
                        \ have run out of cycles (we will pick up where we left
                        \ off in the next VBlank)

 JMP cmem5              \ The result is positive, so we have enough cycles to
                        \ clear the next 32-byte block in this VBlank, so jump
                        \ to cmem5 to do just that

.cmem4

 ADD_CYCLES 277         \ Add 277 to the cycle count

 JMP cmem7              \ Jump to cmem7 to return from the subroutine

.cmem5

 LDA #0                 \ Set A = 0 so the call to FillMemory zeroes the memory
                        \ block

 LDY #0                 \ Set an index in Y to pass to FillMemory, so we start
                        \ clearing memory from clearAddress(1 0) onwards

 JSR FillMemory32Bytes  \ Call FillMemory to clear 32 bytes of memory from
                        \ clearAddress(1 0) to clearAddress(1 0) + 31

 LDA clearAddress       \ Set clearAddress(1 0) = clearAddress(1 0) + 32
 CLC                    \
 ADC #32                \ So it points at the next memory location to clear
 STA clearAddress       \ after the block we just cleared
 LDA clearAddress+1
 ADC #0
 STA clearAddress+1

 JMP cmem3              \ Jump back to cmem3 to consider clearing the next 32
                        \ bytes of memory, which we can keep doing until we run
                        \ out of cycles because we only get here if we don't
                        \ have enough cycles for a 256-byte block, so the cycles
                        \ will run out before we manage to clear eight blocks of
                        \ 32 bytes

.cmem6

 ADD_CYCLES_CLC 132     \ Add 132 to the cycle count

.cmem7

 RTS                    \ Return from the subroutine

.cmem8

                        \ If we get here then we need to clear a block of fewer
                        \ than 256 bytes

 SUBTRACT_CYCLES 186    \ Subtract 186 from the cycle count

 BMI cmem9              \ If the result is negative, jump to cmem9 to skip
                        \ clearing the block in this VBlank, as we have run out
                        \ of cycles (we will pick up where we left off in the
                        \ next VBlank)

 JMP cmem10             \ The result is positive, so we have enough cycles to
                        \ clear the block in this VBlank, so jump to cmem10
                        \ to do just that

.cmem9

 ADD_CYCLES 138         \ Add 138 to the cycle count

 JMP cmem7              \ Jump to cmem7 to return from the subroutine

.cmem10

 LDA clearBlockSize     \ Set A to the size of the block we need to clear, which
                        \ is in the low byte of clearBlockSize(1 0) (as we only
                        \ get here when the high byte of clearBlockSize(1 0) is
                        \ zero)

 BEQ cmem6              \ If the block size is zero, then there are no bytes to
                        \ clear, so jump to cmem6 to return from the subroutine

 LSR A                  \ Set A = clearBlockSize / 16
 LSR A
 LSR A
 LSR A

 CMP cycleCount+1       \ If A >= high byte of cycleCount(1 0), then:
 BCS cmem12             \
                        \   clearBlockSize / 16 >= cycleCount(1 0) / 256
                        \
                        \ so:
                        \
                        \   clearBlockSize >= cycleCount(1 0) / 16
                        \
                        \ If clearing each byte takes up to 16 cycles, then this
                        \ means we can't clear the whole block in this VBlank,
                        \ as we don't have enough cycles, so jump to cmem12 to
                        \ consider clearing it in blocks of 32 bytes rather than
                        \ all at once
                        \
                        \ (I don't know why this calculation counts 16 cycles
                        \ per byte, as it only takes 8 cycles for FILL_MEMORY
                        \ to clear a byte; perhaps it's an overestimation to be
                        \ safe and cater for all this extra logic code?) ???

                        \ If we get here then we can clear the block of memory
                        \ in one go

                        \ First we subtract the number of cycles that we need to
                        \ clear the memory block from the cycle count
                        \
                        \ Each call to the FILL_MEMORY macro takes 8 cycles (6
                        \ for the STA (clearAddress),Y instruction and 2 for the
                        \ INY instruction), so the total number of cycles we
                        \ will take will be clearBlockSize(1 0) * 8, so that's
                        \ what we subtract from the cycle count

 LDA #0                 \ Set the high byte of clearBlockSize(1 0) = 0 (though
 STA clearBlockSize+1   \ this should already be the case)

 LDA clearBlockSize     \ Set (A clearBlockSize+1) = clearBlockSize(1 0)

 ASL A                  \ Set (A clearBlockSize+1) = (A clearBlockSize+1) * 8
 ROL clearBlockSize+1   \                          = clearBlockSize(1 0) * 8
 ASL A
 ROL clearBlockSize+1
 ASL A
 ROL clearBlockSize+1

 EOR #&FF               \ Set cycleCount(1 0) = cycleCount(1 0)
 SEC                    \                        + ~(A clearBlockSize+1) + 1
 ADC cycleCount         \
 STA cycleCount         \   = cycleCount(1 0) - (A clearBlockSize+1)
 LDA clearBlockSize+1   \   = cycleCount(1 0) - clearBlockSize(1 0) * 8
 EOR #&FF
 ADC cycleCount+1
 STA cycleCount+1

                        \ Next we calculate the entry point into the FillMemory
                        \ routine that will fill clearBlockSize(1 0) bytes of
                        \ memory
                        \
                        \ FillMemory consists of 256 sequential FILL_MEMORY
                        \ macros, each of which fills one byte, as follows:
                        \
                        \   STA (clearAddress),Y
                        \   INY
                        \
                        \ The first instruction takes up two bytes while the INY
                        \ takes up one, so each byte that FillMemory fills takes
                        \ up three bytes of instruction memory
                        \
                        \ The FillMemory routine ends with an RTS, and is
                        \ followed by the ClearMemory routine, so we can work
                        \ out the entry point for filling clearBlockSize bytes
                        \ as follows:
                        \
                        \   ClearMemory - 1 - (3 * clearBlockSize)
                        \
                        \ The 1 is for the RTS, and each of the byte fills has
                        \ three instructions
                        \
                        \ So this is what we calculate next

 LDY #0                 \ Set an index in Y to pass to FillMemory (which we call
                        \ via the JMP (clearBlockSize) instruction below, so we
                        \ start clearing memory from clearAddress(1 0) onwards

 STY clearBlockSize+1   \ Set the high byte of clearBlockSize(1 0) = 0 

 LDA clearBlockSize     \ Store the size of the memory block that we want to
 PHA                    \ clear on the stack, so we can retrieve it below

 ASL A                  \ Set clearBlockSize(1 0)
 ROL clearBlockSize+1   \        = clearBlockSize(1 0) * 2 + clearBlockSize(1 0)
 ADC clearBlockSize     \        = clearBlockSize(1 0) * 3
 STA clearBlockSize     \
 LDA clearBlockSize+1   \ So clearBlockSize(1 0) contains the block size * 3
 ADC #0
 STA clearBlockSize+1

                        \ At this point the C flag is clear, as the high byte
                        \ addition will never overflow, so this means the SBC
                        \ in the following will subtract an extra 1

 LDA #LO(ClearMemory)   \ Set clearBlockSize(1 0)
 SBC clearBlockSize     \        = ClearMemory - clearBlockSize(1 0) - 1
 STA clearBlockSize     \        = ClearMemory - (block size * 3) - 1
 LDA #HI(ClearMemory)   \
 SBC clearBlockSize+1   \ So clearBlockSize(1 0) is the address of the entry
 STA clearBlockSize+1   \ point in FillMemory that fills clearBlockSize(1 0)
                        \ bytes with zero, and we can now call it with this
                        \ instruction:
                        \
                        \   JMP (clearBlockSize)
                        \
                        \ So calling cmem11 below will fill memory with the
                        \ value of A, for clearBlockSize(1 0) bytes from
                        \ clearAddress(1 0) + Y onwards
                        \
                        \ We already set Y to 0 above, so it will start filling
                        \ from clearAddress(1 0) onwards

 LDA #0                 \ Set A = 0 so the call to FillMemory via the
                        \ JMP (clearBlockSize) instruction zeroes the memory
                        \ block

 JSR cmem11             \ Jump to cmem11 to call the correct entry point in
                        \ FillMemory to clear the memory block, returning here
                        \ when it's done

 PLA                    \ Set A to the size of the memory block that we want to
                        \ clear, which we stored on the stack above

 CLC                    \ Set clearAddress(1 0) = clearAddress(1 0) + A
 ADC clearAddress       \
 STA clearAddress       \ So it points at the next memory location to clear
 LDA clearAddress+1     \ after the block we just cleared
 ADC #0
 STA clearAddress+1

 RTS                    \ Return from the subroutine

.cmem11

 JMP (clearBlockSize)   \ We set up clearBlockSize(1 0) to point to the entry
                        \ point in FillMemory that will fill the correct number
                        \ of bytes with zero, so this clears our memory block
                        \ and returns to the PLA above using a tail call

.cmem12

                        \ If we get here then we need to consider clearing the
                        \ memory in blocks of 32 bytes rather than all at once

 ADD_CYCLES_CLC 118     \ Add 118 to the cycle count

.cmem13

 SUBTRACT_CYCLES 321    \ Subtract 321 from the cycle count

 BMI cmem14             \ If the result is negative, jump to cmem14 to skip
                        \ clearing the block in this VBlank, as we have run out
                        \ of cycles (we will pick up where we left off in the
                        \ next VBlank)

 JMP cmem15             \ The result is positive, so we have enough cycles to
                        \ clear the block in this VBlank, so jump to cmem15
                        \ to do just that

.cmem14

 ADD_CYCLES 280         \ Add 280 to the cycle count

 JMP cmem16             \ Jump to cmem16 to return from the subroutine

.cmem15

 LDA clearBlockSize     \ Set A = clearBlockSize - 32
 SEC
 SBC #32

 BCC cmem17             \ If the subtraction underflowed, then we need to clear
                        \ fewer than 32 bytes (as clearBlockSize < 32), so jump
                        \ to cmem17 to do just that

 STA clearBlockSize     \ Set clearBlockSize - 32 = A
                        \                         = clearBlockSize - 32
                        \
                        \ So clearBlockSize(1 0) is updated with the new block
                        \ size, as we are about to clear 32 bytes

 LDA #0                 \ Set A = 0 so the call to FillMemory32Bytes zeroes the
                        \ memory block

 LDY #0                 \ Set an index in Y to pass to FillMemory32Bytes, so we
                        \ start clearing memory from clearAddress(1 0) onwards

 JSR FillMemory32Bytes  \ Call FillMemory32Bytes to clear a 32-byte block of
                        \ memory at clearAddress(1 0)

 LDA clearAddress       \ Set clearAddress(1 0) = clearAddress(1 0) + 32
 CLC                    \
 ADC #32                \ So it points at the next memory location to clear
 STA clearAddress       \ after the block we just cleared
 BCC cmem13
 INC clearAddress+1

 JMP cmem13             \ Jump back to cmem13 to consider clearing the next 32
                        \ bytes of memory

.cmem16

 RTS                    \ Return from the subroutine

.cmem17

                        \ If we get here then we need to clear fewer than 32
                        \ bytes of memory

 ADD_CYCLES_CLC 269     \ Add 269 to the cycle count

.cmem18

 SUBTRACT_CYCLES 119    \ Subtract 119 from the cycle count

 BMI cmem19             \ If the result is negative, jump to cmem19 to skip
                        \ clearing the block in this VBlank, as we have run out
                        \ of cycles (we will pick up where we left off in the
                        \ next VBlank)

 JMP cmem20             \ The result is positive, so we have enough cycles to
                        \ clear the block in this VBlank, so jump to cmem20
                        \ to do just that

.cmem19

 ADD_CYCLES 78          \ Add 78 to the cycle count

 JMP cmem16             \ Jump to cmem16 to return from the subroutine

.cmem20

 LDA clearBlockSize     \ Set A = clearBlockSize - 8
 SEC
 SBC #8

 BCC cmem22             \ If the subtraction underflowed, then we need to clear
                        \ fewer than 8 bytes (as clearBlockSize < 8), so jump
                        \ to cmem22 to return from the subroutine, as this means
                        \ we have filled the whole block (as we only clear
                        \ memory blocks in multiples of 8 bytes)

 STA clearBlockSize     \ Set clearBlockSize - 8 = A
                        \                         = clearBlockSize - 8
                        \
                        \ So clearBlockSize(1 0) is updated with the new block
                        \ size, as we are about to clear 8 bytes

 LDA #0                 \ Set A = 0 so the FILL_MEMORY macro zeroes the memory
                        \ block

 LDY #0                 \ Set an index in Y to pass to the FILL_MEMORY macro, so
                        \ we start clearing memory from clearAddress(1 0)
                        \ onwards

 FILL_MEMORY 8          \ Fill eight bytes at clearAddress(1 0) + Y with A, so
                        \ this zeroes eight bytes at clearAddress(1 0) and
                        \ increments the index counter in Y

 LDA clearAddress       \ Set clearAddress(1 0) = clearAddress(1 0) + 8
 CLC                    \
 ADC #8                 \ So it points at the next memory location to clear
 STA clearAddress       \ after the block we just cleared
 BCC cmem21
 INC clearAddress+1

.cmem21

 JMP cmem18             \ Jump back to cmem18 to consider clearing the next 8
                        \ bytes of memory

.cmem22

 ADD_CYCLES_CLC 66      \ Add 66 to the cycle count

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: WaitForPPUToFinish
\       Type: Subroutine
\   Category: PPU
\    Summary: Wait until the NMI handler has finished updating both bitplanes,
\             so the screen is no longer refreshing
\
\ ******************************************************************************

.WaitForPPUToFinish

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA bitplaneFlags      \ Keep looping back to the start of the routine until
 AND #%01000000         \ bit 6 of the bitplane flags for bitplane 0 is clear
 BNE WaitForPPUToFinish

 LDA bitplaneFlags+1    \ Do the same for bitplane 1
 AND #%01000000
 BNE WaitForPPUToFinish

                        \ We get here when both bitplanes have bit 6 clear,
                        \ which means neither bitplane is configured to send
                        \ nametable data to the PPU
                        \
                        \ This means the screen has finished refreshing and
                        \ there is no longer any nametable data that needs
                        \ sending to the PPU, so we can return from the
                        \ subroutine

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: FlipDrawingPlane
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Flip the drawing bitplane
\
\ ******************************************************************************

.FlipDrawingPlane

 LDA drawingBitplane    \ Set X to the opposite bitplane to the current drawing
 EOR #1                 \ bitplane
 TAX

 JSR SetDrawingBitplane \ Set X as the new drawing bitplane, so this effectively
                        \ flips the drawing bitplane between 0 and 1

 JMP ClearDrawingPlane  \ Jump to ClearDrawingPlane to clear the buffers for the
                        \ new drawing bitplane, returning from the subroutine
                        \ using a tail call

\ ******************************************************************************
\
\       Name: SetDrawingBitplane
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Set the drawing bitplane to a specified value
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X                   The new value of the drawing bitplane
\
\ ******************************************************************************

.SetDrawingBitplane

 STX drawingBitplane    \ Set the drawing bitplane to X

 LDA lastPatternTile,X  \ Set the next free tile number in firstFreeTile to the
 STA firstFreeTile      \ number of the last pattern tile that was sent to the
                        \ PPU for the new bitplane

 LDA nameBufferHiAddr,X \ Set the high byte of the nametable buffer for the new
 STA nameBufferHi       \ bitplane in nameBufferHiAddr

 LDA #0                 \ Set the low byte of pattBufferAddr(1 0) to zero (we
 STA pattBufferAddr     \ will set the high byte in SetPatternBuffer below

 STA drawingPlaneDebug  \ Set drawingPlaneDebug = 0 (though this value is never
                        \ read, so this has no effect)

                        \ Fall through into SetPatternBuffer to set the high
                        \ bytes of the patten buffer address variables

\ ******************************************************************************
\
\       Name: SetPatternBuffer
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Set the high byte of the pattern buffer address variables
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X                   The bitplane whose pattern address we should use
\
\ ******************************************************************************

.SetPatternBuffer

 LDA pattBufferHiAddr,X \ Set the high byte of pattBufferAddr(1 0) to the
 STA pattBufferAddr+1   \ correct address for the pattern buffer for bitplane X

 LSR A                  \ Set pattBufferHiDiv8 to the high byte of the pattern
 LSR A                  \ buffer address, divided by 8
 LSR A
 STA pattBufferHiDiv8

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: CopySmallBlock
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Copy a small number of pages in memory
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   V(1 0)              Source address
\
\   SC(1 0)             Destination address
\
\   X                   Number of pages of memory to copy
\
\ ******************************************************************************

.CopySmallBlock

 LDY #0                 \ Set an index counter in Y

.cops1

 LDA (V),Y              \ Copy the Y-th byte from V(1 0) to SC(1 0)
 STA (SC),Y

 DEY                    \ Decrement the index counter

 BNE cops1              \ Loop back until we have copied a whole page of bytes

 INC V+1                \ Increment the high bytes of V(1 0) and SC(1 0) to
 INC SC+1               \ point to the next page in memory

 DEX                    \ Decrement the page counter

 BNE cops1              \ Loop back until we have copied X pages of memory

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: CopyLargeBlock
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Copy a large number of pages in memory
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   SC2(1 0)            Source address
\
\   SC(1 0)             Destination address
\
\   V                   The number of pages top copy in each set
\
\   V+1                 The number of sets, so we copy V * V+1 pages
\
\   X                   Number of pages of memory to copy
\
\ ******************************************************************************

.CopyLargeBlock

 LDY #0                 \ Set an index counter in Y

 INC V                  \ Increment the page counter in V so we can use a BNE
                        \ below to copy V pages

 INC V+1                \ Increment the page counter in V+1 so we can use a BNE
                        \ below to copy V+1 sets of V pages

.copl1

 LDA (SC2),Y            \ Copy the Y-th byte from SC2(1 0) to SC(1 0)
 STA (SC),Y

 INY                    \ Increment the index counter

 BNE copl2              \ If we haven't reached the end of the page, jump to
                        \ copl2 to skip the following

 INC SC+1               \ Increment the high bytes of SC(1 0) and SC2(1 0) to
 INC SC2+1              \ point to the next page in memory

.copl2

 DEC V                  \ Loop back to repeat the above until we have copied V
 BNE copl1              \ pages

 DEC V+1                \ Loop back to repeat the above until we have copied V+1
 BNE copl1              \ sets of V pages

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: WaitFor3xVBlank
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Wait for three VBlanks to pass
\
\ ******************************************************************************

.WaitFor3xVBlank

 LDA PPU_STATUS         \ Read the PPU_STATUS register, which clear the VBlank
                        \ latch in bit 7, so the following loops will wait for
                        \ three VBlanks in total

.wait1

 LDA PPU_STATUS         \ Wait for the first VBlank to pass, which will set bit
 BPL wait1              \ 7 of PPU_STATUS (and reading PPU_STATUS clears bit 7,
                        \ ready for the next VBlank)

.wait2

 LDA PPU_STATUS         \ Wait for the second VBlank to pass
 BPL wait2

                        \ Fall through into WaitForVBlank to wait for the third
                        \ VBlank before returning from the subroutine

\ ******************************************************************************
\
\       Name: WaitForVBlank
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Wait for the next VBlank to pass
\
\ ******************************************************************************

.WaitForVBlank

 LDA PPU_STATUS         \ Wait for the next VBlank to pass
 BPL WaitForVBlank

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: PlayMusicAtVBlank
\       Type: Subroutine
\   Category: Sound
\    Summary: Wait for the next VBlank and play the background music
\
\ ------------------------------------------------------------------------------
\
\ Returns:
\
\   X                   X is preserved
\
\ ******************************************************************************

.PlayMusicAtVBlank

 TXA                    \ Store X on the stack, so we can retrieve it below
 PHA

 JSR WaitForVBlank      \ Wait for the next VBlank to pass

 JSR PlayMusic_b6       \ Call the PlayMusic routine to play the background
                        \ music

 PLA                    \ Restore X from the stack so it is preserved
 TAX

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: DrawMessageInNMI
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Configure the NMI to send the portion of the screen that contains
\             the in-flight message to the PPU (i.e. tile rows 22 to 24)
\
\ ******************************************************************************

.DrawMessageInNMI

 JSR WaitForPPUToFinish \ Wait until both bitplanes of the screen have been
                        \ sent to the PPU, so the screen is fully updated and
                        \ there is no more data waiting to be sent to the PPU

 LDA firstFreeTile      \ Tell the NMI handler to send pattern entries up to the
 STA lastPatternTile    \ first free tile, for both bitplanes
 STA lastPatternTile+1

 LDA #88                \ Tell the NMI handler to send nametable entries from
 STA firstNametableTile \ tile 88 * 8 = 704 onwards (i.e. from the start of tile
                        \ row 22)

 LDA #100               \ Tell the NMI handler to send nametable entries up to
 STA lastNameTile       \ tile 100 * 8 = 800 (i.e. up to the end of tile row 24)
 STA lastNameTile+1     \ in both bitplanes

 LDA #%11000100         \ Set both bitplane flags as follows:
 STA bitplaneFlags      \
 STA bitplaneFlags+1    \   * Bit 2 set   = send tiles up to end of the buffer
                        \   * Bit 3 clear = don't clear buffers after sending
                        \   * Bit 4 clear = we've not started sending data yet
                        \   * Bit 5 clear = we have not yet sent all the data
                        \   * Bit 6 set   = send both pattern and nametable data
                        \   * Bit 7 set   = send data to the PPU
                        \
                        \ Bits 0 and 1 are ignored and are always clear

 JMP WaitForPPUToFinish \ Wait until both bitplanes of the screen have been
                        \ sent to the PPU, so the screen is fully updated and
                        \ there is no more data waiting to be sent to the PPU,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawShipInBitplane
\       Type: Subroutine
\   Category: Drawing ships
\    Summary: Flip the drawing bitplane and draw the current ship in the newly
\             flipped bitplane
\
\ ******************************************************************************

.DrawShipInBitplane

 JSR FlipDrawingPlane   \ Flip the drawing bitplane

 JSR LL9_b1             \ Draw the current ship into the newly flipped drawing
                        \ bitplane

                        \ Fall through into DrawBitplaneInNMI to configure the
                        \ NMI to send the drawing bitplane to the PPU

\ ******************************************************************************
\
\       Name: DrawBitplaneInNMI
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Configure the NMI to send the drawing bitplane to the PPU after
\             drawing the box edges and setting the next free tile number
\
\ ******************************************************************************

.DrawBitplaneInNMI

 LDA #%11001000         \ Set A so we set the drawing bitplane flags in
                        \ SetDrawPlaneFlags as follows:
                        \
                        \   * Bit 2 clear = send tiles up to configured numbers
                        \   * Bit 3 set   = clear buffers after sending data
                        \   * Bit 4 clear = we've not started sending data yet
                        \   * Bit 5 clear = we have not yet sent all the data
                        \   * Bit 6 set   = send both pattern and nametable data
                        \   * Bit 7 set   = send data to the PPU
                        \
                        \ Bits 0 and 1 are ignored and are always clear
                        \
                        \ This configures the NMI to send nametable and pattern
                        \ data for the drawing bitplane to the PPU during VBlank

                        \ Fall through into SetDrawPlaneFlags to set the
                        \ bitplane flags, draw the box edges and set the next
                        \ free tile number

\ ******************************************************************************
\
\       Name: SetDrawPlaneFlags
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Set the drawing bitplane flags to the specified value, draw the
\             box edges and set the next free tile number
\
\ ******************************************************************************

.SetDrawPlaneFlags

 PHA                    \ Store A on the stack, so we can retrieve them below
                        \ when setting the new drawing bitplane flags

 JSR DrawBoxEdges       \ Draw the left and right edges of the box along the
                        \ sides of the screen, drawing into the nametable buffer
                        \ for the drawing bitplane

 LDX drawingBitplane    \ Set X to the drawing bitplane

 LDA firstFreeTile      \ Tell the NMI handler to send pattern entries up to the
 STA lastPatternTile,X  \ first free tile, for the drawing bitplane in X

 PLA                    \ Retrieve A from the stack and set it as the value of
 STA bitplaneFlags,X    \ the drawing bitplane flags

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: SendInventoryToPPU
\       Type: Subroutine
\   Category: PPU
\    Summary: Send X batches of 16 bytes from SC(1 0) to the PPU, for sending
\             the inventory icon bar image
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X                   The number of batches of 16 bytes to send to the PPU
\
\   SC(1 0)             The address of the data to send
\
\ ******************************************************************************

.SendInventoryToPPU

 LDY #0                 \ Set Y as an index counter for the following block,
                        \ which sends 16 bytes of data from SC(1 0) to the PPU,
                        \ using Y as an index that starts at 0 and increments
                        \ after each byte
                        \
                        \ We repeat this process for X iterations

                        \ We repeat the following code 16 times, so it sends
                        \ one whole pattern of 16 bytes to the PPU (eight bytes
                        \ for each bitplane)

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA (SC),Y             \ Send the Y-th byte of SC(1 0) to the PPU and increment
 STA PPU_DATA           \ the index in Y
 INY

 LDA SC                 \ Set SC(1 0) = SC(1 0) + 16
 CLC                    \
 ADC #16                \ Starting with the low bytes
 STA SC

 BCC smis1              \ And then the high bytes
 INC SC+1

.smis1

 DEX                    \ Decrement the block counter in X

 BNE SendInventoryToPPU \ Loop back to the start of the subroutine until we have
                        \ sent X batches of 16 bytes

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/variable/twos.asm"
INCLUDE "library/common/main/variable/twos2.asm"
INCLUDE "library/common/main/variable/twfl.asm"
INCLUDE "library/common/main/variable/twfr.asm"
INCLUDE "library/nes/main/variable/ylookuplo.asm"
INCLUDE "library/nes/main/variable/ylookuphi.asm"

\ ******************************************************************************
\
\       Name: GetRowNameAddress
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Get the addresses in the nametable buffers for the start of a
\             given character row
\
\ ------------------------------------------------------------------------------
\
\ This routine returns the index of the start of a text row in the nametable
\ buffers. Character row 0 (i.e. YC = 0) is mapped to the second row on-screen,
\ as the first row is taken up by the box edge.
\
\ It's also worth noting that the first column in the nametable is column 1, not
\ column 0, as the screen has a horizontal scroll of 8, so the leftmost tile
\ on each row is scrolled around to the right side. This means that in terms of
\ tiles, column 1 is the left edge of the screen, then columns 2 to 31 form the
\ body of the screen, and column 0 is the right edge of the screen.
\
\ Arguments:
\
\   YC                  The text row
\
\
\ Returns:
\
\   SC(1 0)             The address in nametable buffer 0 for the start of the
\                       row
\
\   SC2(1 0)            The address in nametable buffer 1 for the start of the
\                       row
\
\ ******************************************************************************

.GetRowNameAddress

 LDA #0                 \ Set SC+1 = 0, for use at the top byte of SC(1 0) in
 STA SC+1               \ the calculation below

 LDA YC                 \ If YC = 0, then we need to return the address of the
 BEQ grow1              \ start of the top character row (i.e. the second row
                        \ on-screen), so jump to grow1

 LDA YC                 \ Set A = YC + 1
 CLC                    \
 ADC #1                 \ So this is the nametable row number for text row YC,
                        \ as nametable row 0 is taken up by the top box edge

 ASL A                  \ Set SC(1 0) = (SC+1 A) << 5 + 1
 ASL A                  \             = (0 A) << 5 + 1
 ASL A                  \             = (YC + 1) * 32 + 1
 ASL A                  \
 ROL SC+1               \ This sets SC(1 0) to the offset within the nametable
 SEC                    \ of the start of the relevant row, as there are 32
 ROL A                  \ tiles on each row
 ROL SC+1               \
 STA SC                 \ The YC + 1 part skips the top on-screen row to start
                        \ just below the top box edge, and the final + 1 takes
                        \ care of the horizontal scrolling, which makes the
                        \ first column number 1 rather than 0
                        \
                        \ The final ROL SC+1 also clears the C flag, as we know
                        \ bits 1 to 7 of SC+1 were clear before the rotation

 STA SC2                \ Set the low byte of SC2(1 0) to the low byte of
                        \ SC(1 0), as the the addresses of the two nametable
                        \ buffers only differ in the high bytes

 LDA SC+1               \ Set SC(1 0) = SC(1 0) + nameBuffer0
 ADC #HI(nameBuffer0)   \
 STA SC+1               \ So SC(1 0) now points to the row's address in
                        \ nametable buffer 0 (this addition works because we
                        \ know that the C flag is clear and the low byte of
                        \ nameBuffer0 is zero)
                        \
                        \ This addition will never overflow, as we know SC+1 is
                        \ in the range 0 to 3, so this also clears the C flag

                        \ Each nametable buffer is 1024 bytes in size, which is
                        \ four pages of 256 bytes, and nametable buffer 1 is
                        \ straight after nametable buffer 0 in memory, so we can
                        \ calculate the row's address in nametable buffer 1 in
                        \ SC2(1 0) by simply adding 4 to the high byte

 ADC #4                 \ Set SC2(1 0) = SC(1 0) + (4 0)
 STA SC2+1              \
                        \ So SC2(1 0) now points to the row's address in
                        \ nametable buffer 1 (this addition works because we
                        \ know that the C flag is clear

 RTS                    \ Return from the subroutine

.grow1

                        \ If we get here then we want to return the address of
                        \ the top character row (as YC = ), which is actually
                        \ the second on-screen row (row 1), as the first row is
                        \ taken up by the top of the box

 LDA #HI(nameBuffer0+1*32+1)    \ Set SC(1 0) to the address of the tile in
 STA SC+1                       \ column 1 on tile row 1 in nametable buffer 0
 LDA #LO(nameBuffer0+1*32+1)
 STA SC

 LDA #HI(nameBuffer1+1*32+1)    \ Set SC(1 0) to the address of the tile in
 STA SC2+1                      \ column 1 on tile row 1 in nametable buffer 1
 LDA #LO(nameBuffer1+1*32+1)
 STA SC2

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/loin_part_1_of_7.asm"
INCLUDE "library/common/main/subroutine/loin_part_2_of_7.asm"
INCLUDE "library/nes/main/subroutine/loin_part_3_of_7.asm"
INCLUDE "library/nes/main/subroutine/loin_part_4_of_7.asm"
INCLUDE "library/common/main/subroutine/loin_part_5_of_7.asm"
INCLUDE "library/nes/main/subroutine/loin_part_6_of_7.asm"
INCLUDE "library/nes/main/subroutine/loin_part_7_of_7.asm"

\ ******************************************************************************
\
\       Name: DrawSunRowOfBlocks
\       Type: Subroutine
\   Category: Drawing suns
\    Summary: Draw a row of character blocks that contain sunlight, silhouetting
\             any existing content against the sun
\
\ ------------------------------------------------------------------------------
\
\ This routine fills a row of whole character blocks with sunlight, turning any
\ existing content into a black silhouette on the cyan sun. It effectively fills
\ the character blocks containing the horizontal pixel line (P, Y) to (P+1, Y).
\
\ Arguments:
\
\   P                   A pixel x-coordinate in the character block from which
\                       we start the fill
\
\   P+1                 A pixel x-coordinate in the character block where we
\                       finish the fill
\
\   Y                   A pixel y-coordinate on the character row to fill
\
\ Returns:
\
\   Y                   Y is preserved
\
\ ******************************************************************************

.DrawSunRowOfBlocks

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 STY YSAV               \ Store Y in YSAV so we can retrieve it below

 LDA P                  \ Set SC2(1 0) = (nameBufferHi 0) + yLookup(Y) + P * 8
 LSR A                  \
 LSR A                  \ where yLookup(Y) uses the (yLookupHi yLookupLo) table
 LSR A                  \ to convert the pixel y-coordinate in Y into the number
 CLC                    \ of the first tile on the row containing the pixel
 ADC yLookupLo,Y        \
 STA SC2                \ Adding nameBufferHi and P * 8 therefore sets SC2(1 0)
 LDA nameBufferHi       \ to the address of the entry in the nametable buffer
 ADC yLookupHi,Y        \ that contains the tile number for the tile containing
 STA SC2+1              \ the pixel at (P, Y)

 LDA P+1                \ Set Y = (P+1 - P) * 8 - 1
 SEC                    \
 SBC P                  \ So Y is the number of tiles we need to fill in the row
 LSR A
 LSR A
 LSR A
 TAY
 DEY

.fill1

 LDA (SC2),Y            \ If the nametable entry for the Y-th tile is non-zero,
 BNE fill2              \ then there is already something there, so jump to
                        \ fill2 to fill this tile using EOR logic (so the pixels
                        \ that are already there are still visible against the
                        \ sun, as black pixels on the sun's cyan background)

 LDA #51                \ Otherwise the nametable entry is zero, which is just
 STA (SC2),Y            \ the background, so set this tile to pattern 51

 DEY                    \ Decrement the tile counter in Y

 BPL fill1              \ Loop back until we have filled the entire row of tiles

 LDY YSAV               \ Retrieve the value of Y we stored above

 RTS                    \ Return from the subroutine

.fill2

                        \ If we get here then A contains the pattern number of
                        \ the non-empty tile that we want to fill, so we now
                        \ need to fill that pattern in the pattern buffer while
                        \ keeping the existing content

 STY T                  \ Store Y in T so we can retrieve it below

 LDY pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STY SC+1               \             = (pattBufferHiAddr A*8)
 ASL A                  \
 ROL SC+1               \ This is the address of pattern number A in the current
 ASL A                  \ pattern buffer, as each pattern in the buffer consists
 ROL SC+1               \ of eight bytes
 ASL A                  \
 ROL SC+1               \ So this is the address of the pattern for the tile
 STA SC                 \ that we want to fill, so now to fill it

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDY #7                 \ We now loop through each pixel row within this tile's
                        \ pattern, filling the whole pattern with cyan, but
                        \ EOR'ing with the pattern that is already there so it
                        \ is still visible against the sun, as black pixels on
                        \ the sun's cyan background

.fill3

 LDA #%11111111         \ Invert the Y-th pixel row by EOR'ing with %11111111
 EOR (SC),Y
 STA (SC),Y

 DEY                    \ Decrement Y to point to the pixel line above

 BPL fill3              \ Loop back until we have filled all 8 pixel lines in
                        \ the pattern

 LDY T                  \ Retrieve the value of Y we stored above, so it now
                        \ contains the tile counter from the loop at fill1

 DEY                    \ Decrement the tile counter in Y, as we just filled a
                        \ tile

 BPL fill1              \ If there are still more tiles to fill on this row,
                        \ loop back to fill1 to continue filling them

 LDY YSAV               \ Retrieve the value of Y we stored above

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: HLOIN (Part 1 of 5)
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: Draw a horizontal line from (X1, Y1) to (X2, Y1) using EOR logic
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X1                  The screen x-coordinate of the start of the line
\
\   X2                  The screen x-coordinate of the end of the line
\
\   Y1                  The screen y-coordinate of the line
\
\ Returns:
\
\   Y                   Y is preserved
\
\ ******************************************************************************

.hlin1

 JMP hlin23             \ Jump to hlin23 to draw the line when it's all within
                        \ one character block

 LDY YSAV               \ Restore Y from YSAV, so that it's preserved

.hlin2

 RTS                    \ Return from the subroutine

.HLOIN

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 STY YSAV               \ Store Y into YSAV, so we can preserve it across the
                        \ call to this subroutine

 LDX X1                 \ Set X = X1

 CPX X2                 \ If X1 = X2 then the start and end points are the same,
 BEQ hlin2              \ so return from the subroutine (as hlin2 contains
                        \ an RTS)

 BCC hlin3              \ If X1 < X2, jump to hlin3 to skip the following code,
                        \ as (X1, Y1) is already the left point

 LDA X2                 \ Swap the values of X1 and X2, so we know that (X1, Y1)
 STA X1                 \ is on the left and (X2, Y1) is on the right
 STX X2

 TAX                    \ Set X = X1 once again

.hlin3

 DEC X2                 \ Decrement X2 so we do not draw a pixel at the end
                        \ point

 TXA                    \ Set SC2(1 0) = (nameBufferHi 0) + yLookup(Y) + X1 / 8
 LSR A                  \
 LSR A                  \ where yLookup(Y) uses the (yLookupHi yLookupLo) table
 LSR A                  \ to convert the pixel y-coordinate in Y into the number
 CLC                    \ of the first tile on the row containing the pixel
 ADC yLookupLo,Y        \
 STA SC2                \ Adding nameBufferHi and X1 / 8 therefore sets SC2(1 0)
 LDA nameBufferHi       \ to the address of the entry in the nametable buffer
 ADC yLookupHi,Y        \ that contains the tile number for the tile containing
 STA SC2+1              \ the pixel at (X1, Y), i.e. the line we are drawing

 TYA                    \ Set Y = Y mod 8, which is the pixel row within the
 AND #7                 \ character block at which we want to draw the start of
 TAY                    \ our line (as each character block has 8 rows)
                        \
                        \ As we are drawing a horizontal line, we do not need to
                        \ vary the value of Y, as we will always want to draw on
                        \ the same pixel row within each character block

 TXA                    \ Set T = X1 with bits 0-2 cleared
 AND #%11111000         \
 STA T                  \ Each character block contains 8 pixel rows, so to get
                        \ the address of the first byte in the character block
                        \ that we need to draw into, as an offset from the start
                        \ of the row, we clear bits 0-2
                        \
                        \ T is therefore the offset within the row of the start
                        \ of the line at x-coordinate X1

 LDA X2                 \ Set A = X2 with bits 0-2 cleared
 AND #%11111000         \
 SEC                    \ A is therefore the offset within the row of the end
                        \ of the line at x-coordinate X2

 SBC T                  \ Set A = A - T
                        \
                        \ So A contains the width of the line in terms of pixel
                        \ bytes (which is the same as the number of character
                        \ blocks that the line spans, less 1 and multiplied by
                        \ 8)

 BEQ hlin1              \ If the line starts and ends in the same character
                        \ block then A will be zero, so jump to hlin23 via hlin1
                        \ to draw the line when it's all within one character
                        \ block

 LSR A                  \ Otherwise set R = A / 8
 LSR A                  \
 LSR A                  \ So R contains the number of character blocks that the
 STA R                  \ line spans, less 1 (so R = 0 means it spans one block,
                        \ R = 1 means it spans two blocks, and so on)

\ ******************************************************************************
\
\       Name: HLOIN (Part 2 of 5)
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: Draw the left end of the line
\
\ ******************************************************************************

                        \ We now start the drawing process, beginning with the
                        \ left end of the line, whose nametable entry is in
                        \ SC2(1 0)

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0                 \ If the nametable buffer entry is non-zero for the tile
 LDA (SC2,X)            \ containing the pixels that we want to draw, then a
 BNE hlin5              \ tile has already been allocated to this entry, so skip
                        \ the following

 LDA firstFreeTile      \ If firstFreeTile is zero then we have run out of tiles
 BEQ hlin4              \ to use for drawing lines and pixels, so jump to hlin9
                        \ via hlin4 to move on to the next character block to
                        \ the right, as we don't have enough dynamic tiles to
                        \ draw the left end of the line

 STA (SC2,X)            \ Otherwise firstFreeTile contains the number of the
                        \ next available tile for drawing, so allocate this
                        \ tile to cover the pixels that we want to draw by
                        \ setting the nametable entry to the tile number we just
                        \ fetched

 INC firstFreeTile      \ Increment firstFreeTile to point to the next available
                        \ dynamic tile for drawing, so it can be used the next
                        \ time we need to draw lines or pixels into a tile

 JMP hlin7              \ Jump to hlin7 to draw the line, starting by drawing
                        \ the left end into the newly allocated tile number in A

.hlin4

 JMP hlin9              \ Jump to hlin9 to move right by one character block
                        \ without drawing anything

.hlin5

                        \ If we get here then A contains the tile number that's
                        \ already allocated to this part of the line in the
                        \ nametable buffer

 CMP #60                \ If A >= 60, then the tile that's already allocated is
 BCS hlin7              \ one of the tiles we have reserved for dynamic drawing,
                        \ so jump to hlin7 to draw the line, starting by drawing
                        \ the left end into the tile number in A

 CMP #37                \ If A < 37, then the tile that's already allocated is
 BCC hlin4              \ one of the icon bar tiles, so jump to hlin9 via hlin4
                        \ to move right by one character block without drawing
                        \ anything, as we can't draw on the icon bar

                        \ If we get here then 37 <= A <= 59, so the tile that's
                        \ already allocated is one of the pre-rendered tiles
                        \ containing horizontal and vertical line patterns
                        \
                        \ We don't want to draw over the top of the pre-rendered
                        \ patterns as that will break them, so instead we make a
                        \ copy of the pre-rendered tile's pattern in a newly
                        \ allocated dynamic tile, and then draw our line into
                        \ the dynamic tile, thus preserving what's already shown
                        \ on-screen while still drawing our new line

 LDX pattBufferHiDiv8   \ Set SC3(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC3+1              \              = (pattBufferHi A) + A * 8
 ASL A                  \
 ROL SC3+1              \ So SC3(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC3+1              \ pattern data), which means SC3(1 0) points to the
 ASL A                  \ pattern data for the tile containing the pre-rendered
 ROL SC3+1              \ pattern that we want to copy
 STA SC3

 LDA firstFreeTile      \ If firstFreeTile is zero then we have run out of
 BEQ hlin4              \ dynamic tiles for drawing lines and pixels, so jump to
                        \ hlin9 via hlin4 to move right by one character block
                        \ without drawing anything, as we don't have enough
                        \ dynamic tiles to draw the left end of the line

 LDX #0                 \ Otherwise firstFreeTile contains the number of the
 STA (SC2,X)            \ next available tile for drawing, so allocate this
                        \ tile to cover the pixels that we want to copy by
                        \ setting the nametable entry to the tile number we just
                        \ fetched

 INC firstFreeTile      \ Increment firstFreeTile to point to the next available
                        \ dynamic tile for drawing, so it can be used the next
                        \ time we need to draw lines or pixels into a tile

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the dynamic tile we just fetched
 ROL SC+1
 STA SC

                        \ We now have a new dynamic tile in SC(1 0) into which
                        \ we can draw the left end of our line, so we now need
                        \ to copy the pattern of the pre-rendered tile that we
                        \ want to draw on top of
                        \
                        \ Each pattern is made up of eight bytes, so we simply
                        \ need to copy eight bytes from SC3(1 0) to SC(1 0)

 STY T                  \ Store Y in T so we can retrieve it after the following
                        \ loop

 LDY #7                 \ We now copy eight bytes from SC3(1 0) to SC(1 0), so
                        \ set a counter in Y

.hlin6

 LDA (SC3),Y            \ Copy the Y-th byte of SC3(1 0) to the Y-th byte of
 STA (SC),Y             \ SC(1 0)

 DEY                    \ Decrement the counter

 BPL hlin6              \ Loop back until we have copied all eight bytes

 LDY T                  \ Restore the value of Y from before the loop, so it
                        \ once again contains the pixel row offset within the
                        \ each character block for the line we are drawing

 JMP hlin8              \ Jump to hlin8 to draw the left end of the line into
                        \ the tile that we just copied

.hlin7

                        \ If we get here then we have either allocated a new
                        \ tile number for the line, or the tile number already
                        \ allocated to this part of the line is >= 60, which is
                        \ a dynamic tile into which we can draw
                        \
                        \ In either case the tile number is in A

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the tile containing the line we are
 ROL SC+1               \ drawing
 STA SC

.hlin8

                        \ We now draw the left end of our horizontal line

 LDA X1                 \ Set X = X1 mod 8, which is the horizontal pixel number
 AND #7                 \ within the character block where the line starts (as
 TAX                    \ each pixel line in the character block is 8 pixels
                        \ wide)

 LDA TWFR,X             \ Fetch a ready-made byte with X pixels filled in at the
                        \ right end of the byte (so the filled pixels start at
                        \ point X and go all the way to the end of the byte),
                        \ which is the shape we want for the left end of the
                        \ line

 EOR (SC),Y             \ Store this into the pattern buffer at SC(1 0), using
 STA (SC),Y             \ EOR logic so it merges with whatever is already
                        \ on-screen, so we have now drawn the line's left cap

.hlin9

 INC SC2                \ Increment SC2(1 0) to point to the next tile number to
 BNE P%+4               \ the right in the nametable buffer
 INC SC2+1

 LDX R                  \ Fetch the number of character blocks in which we need
                        \ to draw, which we stored in R above

 DEX                    \ If R = 1, then we only have the right cap to draw, so
 BNE hlin10             \ jump to hlin17 to draw the right end of the line
 JMP hlin17

.hlin10

 STX R                  \ Otherwise we haven't reached the right end of the line
                        \ yet, so decrement R as we have just drawn one block

\ ******************************************************************************
\
\       Name: HLOIN (Part 3 of 5)
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: Draw the middle part of the line
\
\ ******************************************************************************

                        \ We now draw the middle part of the line (i.e. the part
                        \ between the left and right caps)

.hlin11

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0                 \ If the nametable buffer entry is zero for the tile
 LDA (SC2,X)            \ containing the pixels that we want to draw, then a
 BEQ hlin13             \ tile has not yet been allocated to this entry, so jump
                        \ to hlin13 to allocate a new dynamic tile

                        \ If we get here then A contains the tile number that's
                        \ already allocated to this part of the line in the
                        \ nametable buffer

 CMP #60                \ If A < 60, then the tile that's already allocated is
 BCC hlin15             \ either an icon bar tile, or one of the pre-rendered
                        \ tiles containing horizontal and vertical line
                        \ patterns, so jump to hlin15 to process drawing on top
                        \ off the pre-rendered tile

                        \ If we get here then the tile number already allocated
                        \ to this part of the line is >= 60, which is a dynamic
                        \ tile into which we can draw
                        \
                        \ The tile number is in A

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the tile containing the line we are
 ROL SC+1               \ drawing
 STA SC

 LDA #%11111111         \ Set A to a pixel byte containing eight pixels in a row

 EOR (SC),Y             \ Store this into the pattern buffer at SC(1 0), using
 STA (SC),Y             \ EOR logic so it merges with whatever is already
                        \ on-screen, so we have now drawn one character block
                        \ of the middle portion of the line

.hlin12

 INC SC2                \ Increment SC2(1 0) to point to the next tile number to
 BNE P%+4               \ the right in the nametable buffer
 INC SC2+1

 DEC R                  \ Decrement the number of character blocks in which we
                        \ need to draw, as we have just drawn one block

 BNE hlin11             \ If there are still more character blocks to draw, loop
                        \ back to hlin11 to draw the next one

 JMP hlin17             \ Otherwise we have finished drawing the middle portion
                        \ of the line, so jump to hlin17 to draw the right end
                        \ of the line

.hlin13

                        \ If we get here then there is no dynamic tile allocated
                        \ to the part of the line we want to draw, so we can use
                        \ one of the pre-rendered tiles that contains an 8-pixel
                        \ horizontal line on the correct pixel row
                        \
                        \ We jump here with X = 0

 TYA                    \ Set A = Y + 37
 CLC                    \
 ADC #37                \ Tiles 37 to 44 contain pre-rendered patterns as
                        \ follows:
                        \
                        \   * Tile 37 has a horizontal line on pixel row 0
                        \   * Tile 38 has a horizontal line on pixel row 1
                        \     ...
                        \   * Tile 43 has a horizontal line on pixel row 6
                        \   * Tile 44 has a horizontal line on pixel row 7
                        \
                        \ So A contains the pre-rendered tile number that
                        \ contains an 8-pixel line on pixel row Y, and as Y
                        \ contains the offset of the pixel row for the line we
                        \ are drawing, this means A contains the correct tile
                        \ number for this part of the line

 STA (SC2,X)            \ Display the pre-rendered tile on-screen by setting
                        \ the nametable entry to A

 JMP hlin12             \ Jump up to hlin12 to move on to the next character
                        \ block to the right

.hlin14

                        \ If we get here then A + Y = 50, which means we can
                        \ alter the current pre-rendered tile to draw our line
                        \
                        \ This is how it works. Tiles 44 to 51 contain
                        \ pre-rendered patterns as follows:
                        \
                        \   * Tile 44 has a horizontal line on pixel row 7
                        \   * Tile 45 is filled from pixel row 7 to pixel row 6
                        \   * Tile 46 is filled from pixel row 7 to pixel row 5
                        \     ...
                        \   * Tile 50 is filled from pixel row 7 to pixel row 1
                        \   * Tile 51 is filled from pixel row 7 to pixel row 0
                        \
                        \ Y contains the number of the pixel row for the line we
                        \ are drawing, so if A + Y = 50, this means:
                        \
                        \   * We want to draw pixel row 0 on top of tile 50
                        \   * We want to draw pixel row 1 on top of tile 49
                        \     ...
                        \   * We want to draw pixel row 5 on top of tile 45
                        \   * We want to draw pixel row 6 on top of tile 44
                        \
                        \ In other words, if A + Y = 50, then we want to draw
                        \ the pixel row just above the rows that are already
                        \ filled in the pre-rendered pattern, which means we
                        \ can simply swap the pre-rendered pattern to the next
                        \ one in the list (e.g. going from four filled lines to
                        \ five filled lines, for example)
                        \
                        \ We jump here with a BEQ, so the C flag is set for the
                        \ following addition, so the C flag can be used as the
                        \ plus 1 in the two's complement calculation

 TYA                    \ Set A = 51 + C + ~Y
 EOR #&FF               \       = 51 + (1 + ~Y)
 ADC #51                \       = 51 - Y
                        \
                        \ So A contains the number of the pre-rendered tile that
                        \ has our horizontal line drawn on pixel row Y, and all
                        \ the lines below that filled, which is what we want

 STA (SC2,X)            \ Display the pre-rendered tile on-screen by setting
                        \ the nametable entry to A

 INC SC2                \ Increment SC2(1 0) to point to the next tile number to
 BNE P%+4               \ the right in the nametable buffer
 INC SC2+1

 DEC R                  \ Decrement the number of character blocks in which we
                        \ need to draw, as we have just drawn one block

 BNE hlin11             \ If there are still more character blocks to draw, loop
                        \ back to hlin11 to draw the next one

 JMP hlin17             \ Otherwise we have finished drawing the middle portion
                        \ of the line, so jump to hlin17 to draw the right end
                        \ of the line

.hlin15

                        \ If we get here then A <= 59, so the tile that's
                        \ already allocated is either an icon bar tile, or one
                        \ of the pre-rendered tiles containing horizontal and
                        \ vertical line patterns
                        \
                        \ We jump here with the C flag clear, so the addition
                        \ below will work correctly, and with X = 0, so the
                        \ write to (SC2,X) will also work properly

 STA SC                 \ Set SC to the number of the tile that is already
                        \ allocated to this part of the screen, so we can
                        \ retrieve it later

 TYA                    \ If A + Y = 50, then we are drawing our line just
 ADC SC                 \ above the top line of a pre-rendered tile that is
 CMP #50                \ filled from the bottom row to the row just below Y,
 BEQ hlin14             \ so jump to hlin14 to switch this tile to another
                        \ pre-rendered tile that contains the line we want to
                        \ draw (see hlin14 for a full explanation of this logic)

                        \ If we get here then 37 <= A <= 59, so the tile that's
                        \ already allocated is one of the pre-rendered tiles
                        \ containing horizontal and vertical line patterns, but
                        \ isn't a tile we can simply replace with another
                        \ pre-rendered tile
                        \
                        \ We don't want to draw over the top of the pre-rendered
                        \ patterns as that will break them, so instead we make a
                        \ copy of the pre-rendered tile's pattern in a newly
                        \ allocated dynamic tile, and then draw our line into
                        \ the dynamic tile, thus preserving what's already shown
                        \ on-screen while still drawing our new line

 LDA firstFreeTile      \ If firstFreeTile is zero then we have run out of tiles
 BEQ hlin12             \ to use for drawing lines and pixels, so jump to hlin12
                        \ to move right by one character block without drawing
                        \ anything, as we don't have enough dynamic tiles to
                        \ draw this part of the line

 INC firstFreeTile      \ Increment firstFreeTile to point to the next available
                        \ dynamic tile for drawing, so it can be used the next
                        \ time we need to draw lines or pixels into a tile

 STA (SC2,X)            \ Otherwise firstFreeTile contains the number of the
                        \ next available tile for drawing, so allocate this tile
                        \ to contain the pre-rendered tile that we want to copy
                        \ by setting the nametable entry to the tile number we
                        \ just fetched

 LDX pattBufferHiDiv8   \ Set SC3(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC3+1              \              = (pattBufferHi A) + A * 8
 ASL A                  \
 ROL SC3+1              \ So SC3(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC3+1              \ pattern data), which means SC3(1 0) points to the
 ASL A                  \ pattern data for the dynamic tile we just fetched
 ROL SC3+1
 STA SC3

 LDA SC                 \ Set A to the the number of the tile that is already
                        \ allocated to this part of the screen, which we stored
                        \ in SC above

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the tile containing the pre-rendered
 ROL SC+1               \ pattern that we want to copy
 STA SC

                        \ We now have a new dynamic tile in SC3(1 0) into which
                        \ we can draw the left end of our line, so we now need
                        \ to copy the pattern of the pre-rendered tile that we
                        \ want to draw on top of
                        \
                        \ Each pattern is made up of eight bytes, so we simply
                        \ need to copy eight bytes from SC(1 0) to SC3(1 0)

 STY T                  \ Store Y in T so we can retrieve it after the following
                        \ loop

 LDY #7                 \ We now copy eight bytes from SC(1 0) to SC3(1 0), so
                        \ set a counter in Y

.hlin16

 LDA (SC),Y             \ Copy the Y-th byte of SC(1 0) to the Y-th byte of
 STA (SC3),Y            \ SC3(1 0)

 DEY                    \ Decrement the counter

 BPL hlin16             \ Loop back until we have copied all eight bytes

 LDY T                  \ Restore the value of Y from before the loop, so it
                        \ once again contains the pixel row offset within the
                        \ each character block for the line we are drawing

 LDA #%11111111         \ Set A to a pixel byte containing eight pixels in a row

 EOR (SC3),Y            \ Store this into the pattern buffer at SC3(1 0), using
 STA (SC3),Y            \ EOR logic so it merges with whatever is already
                        \ on-screen, so we have now drawn one character block
                        \ of the middle portion of the line

 JMP hlin12             \ Loop back to hlin12 to continue drawing  the line in
                        \ the next character block to the right

\ ******************************************************************************
\
\       Name: HLOIN (Part 4 of 5)
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: Draw the right end of the line
\
\ ******************************************************************************

.hlin17

                        \ We now finish off the drawing process with the right
                        \ end of the line

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0                 \ If the nametable buffer entry is non-zero for the tile
 LDA (SC2,X)            \ containing the pixels that we want to draw, then a
 BNE hlin19             \ tile has already been allocated to this entry, so skip
                        \ the following

 LDA firstFreeTile      \ If firstFreeTile is zero then we have run out of tiles
 BEQ hlin18             \ to  use for drawing lines and pixels, so jump to
                        \ hlin30 via hlin18 to return from the subroutine, as we
                        \ don't have enough dynamic tiles to draw the right end
                        \ of the line

 STA (SC2,X)            \ Otherwise firstFreeTile contains the number of the
                        \ next available tile for drawing, so allocate this tile
                        \ to cover the pixels that we want to draw by setting
                        \ the nametable entry to the tile number we just fetched

 INC firstFreeTile      \ Increment firstFreeTile to point to the next available
                        \ dynamic tile for drawing, so it can be used the next
                        \ time we need to draw lines or pixels into a tile

 JMP hlin21             \ Jump to hlin21 to draw the right end of the line into
                        \ the newly allocated tile number in A

.hlin18

 JMP hlin30             \ Jump to hlin30 to return from the subroutine

.hlin19

                        \ If we get here then A contains the tile number that's
                        \ already allocated to this part of the line in the
                        \ nametable buffer

 CMP #60                \ If A >= 60, then the tile that's already allocated is
 BCS hlin21             \ oneof the tiles we have reserved for dynamic drawing,
                        \ so jump to hlin21 to draw the right end of the line

 CMP #37                \ If A < 37, then the tile that's already allocated is
 BCC hlin18             \ one of the icon bar tiles, so jump to hlin30 via
                        \ hlin18 to return from the subroutine, as we can't draw
                        \ on the icon bar

                        \ If we get here then 37 <= A <= 59, so the tile that's
                        \ already allocated is one of the pre-rendered tiles
                        \ containing horizontal and vertical line patterns
                        \
                        \ We don't want to draw over the top of the pre-rendered
                        \ patterns as that will break them, so instead we make a
                        \ copy of the pre-rendered tile's pattern in a newly
                        \ allocated dynamic tile, and then draw our line into
                        \ the dynamic tile, thus preserving what's already shown
                        \ on-screen while still drawing our new line

 LDX pattBufferHiDiv8   \ Set SC3(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC3+1              \              = (pattBufferHi A) + A * 8
 ASL A                  \
 ROL SC3+1              \ So SC3(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC3+1              \ pattern data), which means SC3(1 0) points to the
 ASL A                  \ pattern data for the tile containing the pre-rendered
 ROL SC3+1              \ pattern that we want to copy
 STA SC3

 LDA firstFreeTile      \ If firstFreeTile is zero then we have run out of
 BEQ hlin18             \ dynamic tiles for drawing lines and pixels, so jump to
                        \ hlin30 via hlin18 to return from the subroutine, as we
                        \ don't have enough dynamic tiles to draw the right end
                        \ of the line

 LDX #0                 \ Otherwise firstFreeTile contains the number of the
 STA (SC2,X)            \ next available tile for drawing, so allocate this tile
                        \ to contain the pre-rendered tile that we want to copy
                        \ by setting the nametable entry to the tile number we
                        \ just fetched

 INC firstFreeTile      \ Increment firstFreeTile to point to the next available
                        \ dynamic tile for drawing, so it can be used the next
                        \ time we need to draw lines or pixels into a tile

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the dynamic tile we just fetched
 ROL SC+1
 STA SC

                        \ We now have a new dynamic tile in SC(1 0) into which
                        \ we can draw the right end of our line, so we now need
                        \ to copy the pattern of the pre-rendered tile that we
                        \ want to draw on top of
                        \
                        \ Each pattern is made up of eight bytes, so we simply
                        \ need to copy eight bytes from SC3(1 0) to SC(1 0)

 STY T                  \ Store Y in T so we can retrieve it after the following
                        \ loop

 LDY #7                 \ We now copy eight bytes from SC3(1 0) to SC(1 0), so
                        \ set a counter in Y

.hlin20

 LDA (SC3),Y            \ Copy the Y-th byte of SC3(1 0) to the Y-th byte of
 STA (SC),Y             \ SC(1 0)

 DEY                    \ Decrement the counter

 BPL hlin20             \ Loop back until we have copied all eight bytes

 LDY T                  \ Restore the value of Y from before the loop, so it
                        \ once again contains the pixel row offset within the
                        \ each character block for the line we are drawing

 JMP hlin22             \ Jump to hlin22 to draw the right end of the line into
                        \ the tile that we just copied

.hlin21

                        \ If we get here then we have either allocated a new
                        \ tile number for the line, or the tile number already
                        \ allocated to this part of the line is >= 60, which is
                        \ a dynamic tile into which we can draw
                        \
                        \ In either case the tile number is in A

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the tile containing the line we are
 ROL SC+1               \ drawing
 STA SC

.hlin22

                        \ We now draw the right end of our horizontal line

 LDA X2                 \ Set X = X2 mod 8, which is the horizontal pixel number
 AND #7                 \ within the character block where the line ends (as
 TAX                    \ each pixel line in the character block is 8 pixels
                        \ wide)

 LDA TWFL,X             \ Fetch a ready-made byte with X pixels filled in at the
                        \ left end of the byte (so the filled pixels start at
                        \ the left edge and go up to point X), which is the
                        \ shape we want for the right end of the line

 JMP hlin29             \ Jump to hlin29 to poke the pixel byte into the pattern
                        \ buffer

\ ******************************************************************************
\
\       Name: HLOIN (Part 5 of 5)
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: Draw the line when it's all within one character block
\
\ ******************************************************************************

.hlin23

                        \ If we get here then the line starts and ends in the
                        \ same character block

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0                 \ If the nametable buffer entry is non-zero for the tile
 LDA (SC2,X)            \ containing the pixels that we want to draw, then a
 BNE hlin25             \ tile has already been allocated to this entry, so skip
                        \ the following

 LDA firstFreeTile      \ If firstFreeTile is zero then we have run out of tiles
 BEQ hlin24             \ to use for drawing lines and pixels, so jump to hlin30
                        \ via hlin24 to return from the subroutine, as we don't
                        \ have enough dynamic tiles to draw the line

 STA (SC2,X)            \ Otherwise firstFreeTile contains the number of the
                        \ next available tile for drawing, so allocate this tile
                        \ to cover the pixels that we want to draw by setting
                        \ the nametable entry to the tile number we just fetched

 INC firstFreeTile      \ Increment firstFreeTile to point to the next available
                        \ dynamic tile for drawing, so it can be used the next
                        \ time we need to draw lines or pixels into a tile

 JMP hlin27             \ Jump to hlin27 to draw the line into the newly
                        \ allocated tile number in A

.hlin24

 JMP hlin30             \ Jump to hlin30 to return from the subroutine

.hlin25

                        \ If we get here then A contains the tile number that's
                        \ already allocated to this part of the line in the
                        \ nametable buffer

 CMP #60                \ If A >= 60, then the tile that's already allocated is
 BCS hlin27             \ one of the tiles we have reserved for dynamic drawing,
                        \ so jump to hlin27 to draw the line into the tile
                        \ number in A

 CMP #37                \ If A < 37, then the tile that's already allocated is
 BCC hlin24             \ one of the icon bar tiles, so jump to hlin30 via
                        \ hlin24 to return from the subroutine, as we can't draw
                        \ on the icon bar

                        \ If we get here then 37 <= A <= 59, so the tile that's
                        \ already allocated is one of the pre-rendered tiles
                        \ containing horizontal and vertical line patterns
                        \
                        \ We don't want to draw over the top of the pre-rendered
                        \ patterns as that will break them, so instead we make a
                        \ copy of the pre-rendered tile's pattern in a newly
                        \ allocated dynamic tile, and then draw our line into
                        \ the dynamic tile, thus preserving what's already shown
                        \ on-screen while still drawing our new line

 LDX pattBufferHiDiv8   \ Set SC3(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC3+1              \              = (pattBufferHi A) + A * 8
 ASL A                  \
 ROL SC3+1              \ So SC3(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC3+1              \ pattern data), which means SC3(1 0) points to the
 ASL A                  \ pattern data for the tile containing the pre-rendered
 ROL SC3+1              \ pattern that we want to copy
 STA SC3

 LDA firstFreeTile      \ If firstFreeTile is zero then we have run out of
 BEQ hlin24             \ dynamic tiles for drawing lines and pixels, so jump to
                        \ hlin30 via hlin24 to return from the subroutine, as we
                        \ don't have enough dynamic tiles to draw the line

 LDX #0                 \ Otherwise firstFreeTile contains the number of the
 STA (SC2,X)            \ next available tile for drawing, so allocate this tile
                        \ to contain the pre-rendered tile that we want to copy
                        \ by setting the nametable entry to the tile number we
                        \ just fetched

 INC firstFreeTile      \ Increment firstFreeTile to point to the next available
                        \ dynamic tile for drawing, so it can be used the next
                        \ time we need to draw lines or pixels into a tile

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the dynamic tile we just fetched
 ROL SC+1
 STA SC

                        \ We now have a new dynamic tile in SC(1 0) into which
                        \ we can draw our line, so we now need to copy the
                        \ pattern of the pre-rendered tile that we want to draw
                        \ on top of
                        \
                        \ Each pattern is made up of eight bytes, so we simply
                        \ need to copy eight bytes from SC3(1 0) to SC(1 0)

 STY T                  \ Store Y in T so we can retrieve it after the following
                        \ loop

 LDY #7                 \ We now copy eight bytes from SC3(1 0) to SC(1 0), so
                        \ set a counter in Y

.hlin26

 LDA (SC3),Y            \ Copy the Y-th byte of SC3(1 0) to the Y-th byte of
 STA (SC),Y             \ SC(1 0)

 DEY                    \ Decrement the counter

 BPL hlin26             \ Loop back until we have copied all eight bytes

 LDY T                  \ Restore the value of Y from before the loop, so it
                        \ once again contains the pixel row offset within the
                        \ each character block for the line we are drawing

 JMP hlin28             \ Jump to hlin28 to draw the line into the tile that
                        \ we just copied

.hlin27

                        \ If we get here then we have either allocated a new
                        \ tile number for the line, or the tile number already
                        \ allocated to this part of the line is >= 60, which is
                        \ a dynamic tile into which we can draw
                        \
                        \ In either case the tile number is in A

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the tile containing the line we are
 ROL SC+1               \ drawing
 STA SC

.hlin28

                        \ We now draw our horizontal line into the relevant
                        \ character block

 LDA X1                 \ Set X = X1 mod 8, which is the horizontal pixel number
 AND #7                 \ within the character block where the line starts (as
 TAX                    \ each pixel line in the character block is 8 pixels
                        \ wide)

 LDA TWFR,X             \ Fetch a ready-made byte with X pixels filled in at the
                        \ right end of the byte (so the filled pixels start at
                        \ point X and go all the way to the end of the byte),
                        \ which is the shape we want for the left end of the
                        \ line

 STA T                  \ Store the pixel shape for the right end of the line in
                        \ T

 LDA X2                 \ Set X = X2 mod 8, which is the horizontal pixel number
 AND #7                 \ within the character block where the line ends (as
 TAX                    \ each pixel line in the character block is 8 pixels
                        \ wide)

 LDA TWFL,X             \ Fetch a ready-made byte with X pixels filled in at the
                        \ left end of the byte (so the filled pixels start at
                        \ the left edge and go up to point X), which is the
                        \ shape we want for the right end of the line

 AND T                  \ Set A to the overlap of the pixel byte for the left
                        \ end of the line (in T) and the right end of the line
                        \ (in A) by AND'ing them together, which gives us the
                        \ pixels that are in the horizontal line we want to draw

.hlin29

 EOR (SC),Y             \ Store this into the pattern buffer at SC(1 0), using
 STA (SC),Y             \ EOR logic so it merges with whatever is already
                        \ on-screen, so we have now drawn our entire horizontal
                        \ line within this one character block

.hlin30

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDY YSAV               \ Restore Y from YSAV, so that it's preserved

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: DrawVerticalLine (Part 1 of 3)
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: Draw a vertical line from (X1, Y1) to (X1, Y2)
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X1                  The screen x-coordinate of the line
\
\   Y1                  The screen y-coordinate of the start of the line
\
\   Y2                  The screen y-coordinate of the end of the line
\
\ Returns:
\
\   Y                   Y is preserved
\
\ ******************************************************************************

.DrawVerticalLine

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 STY YSAV               \ Store Y into YSAV, so we can preserve it across the
                        \ call to this subroutine

 LDY Y1                 \ Set Y = Y1

 CPY Y2                 \ If Y1 = Y2 then the start and end points are the same,
 BEQ vlin3              \ so return from the subroutine (as vlin3 contains
                        \ an RTS)

 BCC vlin1              \ If Y1 < Y2, jump to vlin1 to skip the following code,
                        \ as (X1, Y1) is already the top point

 LDA Y2                 \ Swap the values of Y1 and Y2, so we know that (X1, Y1)
 STA Y1                 \ is at the top and (X1, Y2) is at the bottom
 STY Y2

 TAY                    \ Set Y = Y1 once again

.vlin1

 LDA X1                 \ Set SC2(1 0) = (nameBufferHi 0) + yLookup(Y) + X1 / 8
 LSR A                  \
 LSR A                  \ where yLookup(Y) uses the (yLookupHi yLookupLo) table
 LSR A                  \ to convert the pixel y-coordinate in Y into the number
 CLC                    \ of the first tile on the row containing the pixel
 ADC yLookupLo,Y        \
 STA SC2                \ Adding nameBufferHi and X1 / 8 therefore sets SC2(1 0)
 LDA nameBufferHi       \ to the address of the entry in the nametable buffer
 ADC yLookupHi,Y        \ that contains the tile number for the tile containing
 STA SC2+1              \ the pixel at (X1, Y), i.e. the line we are drawing

 LDA X1                 \ Set S = X1 mod 8, which is the pixel column within the
 AND #7                 \ character block at which we want to draw the start of
 STA S                  \ our line (as each character block has 8 columns)
                        \
                        \ As we are drawing a vertical line, we do not need to
                        \ vary the value of S, as we will always want to draw on
                        \ the same pixel column within each character block

 LDA Y2                 \ Set R = Y2 - Y1
 SEC                    \
 SBC Y1                 \ So R is the height of the line we want to draw, which
 STA R                  \ we will use as a counter as we work our way along the
                        \ line from top to bottom - in other words, R will the
                        \ height remaining that we have to draw

 TYA                    \ Set Y = Y1 mod 8, which is the pixel row within the
 AND #7                 \ character block at which we want to draw the start of
 TAY                    \ our line (as each character block has 8 rows)

 BNE vlin4              \ If Y is non-zero then our vertical line is starting
                        \ inside a character block rather than from the very
                        \ top, so jump to vlin4 to draw the top end of the line

 JMP vlin13             \ Otherwise jump to vlin13 to draw the middle part of
                        \ the line from full-height line segments, as we don't
                        \ need to draw a separate block for the top end

\ ******************************************************************************
\
\       Name: DrawVerticalLine (Part 2 of 3)
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: Draw the top end or bottom end of the line
\
\ ******************************************************************************

.vlin2

                        \ If we get here then we need to move down by one
                        \ character block without drawing anything, and then
                        \ move on to drawing the middle portion of the line

 STY T                  \ Set A = R + Y
 LDA R                  \       = pixels to left draw + current pixel row
 ADC T                  \
                        \ So A contains the total number of pixels left to draw
                        \ in our line

 SBC #7                 \ At this point the C flag is clear, as the above
                        \ addition won't overflow, so this sets A = R + Y - 8
                        \ and sets the flags accordingly

 BCC vlin3              \ If the above subtraction didn't underflow then
                        \ R + Y < 8, so there is less than one block height to
                        \ draw, so there would be nothing more to draw after
                        \ moving down one line, so jump to vlin3 to return
                        \ from the subroutine

 JMP vlin12             \ Jump to vlin12 to move on drawing the middle
                        \ portion of the line

.vlin3

 LDY YSAV               \ Restore Y from YSAV, so that it's preserved

 RTS                    \ Return from the subroutine

.vlin4

                        \ We now draw either the top end or the bottom end of
                        \ the line into the nametable entry in SC2(1 0)

 STY Q                  \ Set Q to the pixel row of the top of the line that we
                        \ want to draw (which will be Y1 mod 8 for the top end
                        \ of the line, or 0 for the bottom end of the line)
                        \
                        \ For the top end of the line, we draw down from row
                        \ Y1 mod 8 to the bottom of the character block, which
                        \ will correctly draw the top end of the line
                        \
                        \ For the bottom end of the line, we draw down from row
                        \ 0 until R runs down, which will correctly draw the
                        \ bottom end of the line

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0                 \ If the nametable buffer entry is non-zero for the tile
 LDA (SC2,X)            \ containing the pixels that we want to draw, then a
 BNE vlin6              \ tile has already been allocated to this entry, so skip
                        \ the following

 LDA firstFreeTile      \ If firstFreeTile is zero then we have run out of tiles
 BEQ vlin5              \ to use for drawing lines and pixels, so jump to vlin2
                        \ via vlin5 to move on to the next character block down,
                        \ as we don't have enough dynamic tiles to draw the top
                        \ block of the line

 STA (SC2,X)            \ Otherwise firstFreeTile contains the number of the
                        \ next available tile for drawing, so allocate this
                        \ tile to cover the pixels that we want to draw by
                        \ setting the nametable entry to the tile number we just
                        \ fetched

 INC firstFreeTile      \ Increment firstFreeTile to point to the next available
                        \ dynamic tile for drawing, so it can be used the next
                        \ time we need to draw lines or pixels into a tile

 JMP vlin8              \ Jump to vlin8 to draw the line, starting by drawing
                        \ the top end into the newly allocated tile number in A

.vlin5

 JMP vlin2              \ Jump to vlin2 to move on to the next character block
                        \ down

.vlin6

 CMP #60                \ If A >= 60, then the tile that's already allocated is
 BCS vlin8              \ one of the tiles we have reserved for dynamic drawing,
                        \ so jump to vlin8 to draw the line, starting by drawing
                        \ the top end into the tile number in A

 CMP #37                \ If A < 37, then the tile that's already allocated is
 BCC vlin5              \ one of the icon bar tiles, so jump to vlin2 via vlin5
                        \ to move down by one character block without drawing
                        \ anything, as we can't draw on the icon bar

                        \ If we get here then 37 <= A <= 59, so the tile that's
                        \ already allocated is one of the pre-rendered tiles
                        \ containing horizontal and vertical line patterns
                        \
                        \ We don't want to draw over the top of the pre-rendered
                        \ patterns as that will break them, so instead we make a
                        \ copy of the pre-rendered tile's pattern in a newly
                        \ allocated dynamic tile, and then draw our line into
                        \ the dynamic tile, thus preserving what's already shown
                        \ on-screen while still drawing our new line

 LDX pattBufferHiDiv8   \ Set SC3(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC3+1              \              = (pattBufferHi A) + A * 8
 ASL A                  \
 ROL SC3+1              \ So SC3(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC3+1              \ pattern data), which means SC3(1 0) points to the
 ASL A                  \ pattern data for the tile containing the pre-rendered
 ROL SC3+1              \ pattern that we want to copy
 STA SC3

 LDA firstFreeTile      \ If firstFreeTile is zero then we have run out of
 BEQ vlin5              \ dynamic tiles for drawing lines and pixels, so jump to
                        \ vlin2 via vlin5 to move down by one character block
                        \ without drawing anything, as we don't have enough
                        \ dynamic tiles to draw the top end of the line

 LDX #0                 \ Otherwise firstFreeTile contains the number of the
 STA (SC2,X)            \ next available tile for drawing, so allocate this
                        \ tile to cover the pixels that we want to copy by
                        \ setting the nametable entry to the tile number we just
                        \ fetched

 INC firstFreeTile      \ Increment firstFreeTile to point to the next available
                        \ dynamic tile for drawing, so it can be used the next
                        \ time we need to draw lines or pixels into a tile

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the dynamic tile we just fetched
 ROL SC+1
 STA SC

                        \ We now have a new dynamic tile in SC(1 0) into which
                        \ we can draw the top end of our line, so we now need
                        \ to copy the pattern of the pre-rendered tile that we
                        \ want to draw on top of
                        \
                        \ Each pattern is made up of eight bytes, so we simply
                        \ need to copy eight bytes from SC3(1 0) to SC(1 0)

 STY T                  \ Store Y in T so we can retrieve it after the following
                        \ loop

 LDY #7                 \ We now copy eight bytes from SC3(1 0) to SC(1 0), so
                        \ set a counter in Y

.vlin7

 LDA (SC3),Y            \ Copy the Y-th byte of SC3(1 0) to the Y-th byte of
 STA (SC),Y             \ SC(1 0)

 DEY                    \ Decrement the counter

 BPL vlin7              \ Loop back until we have copied all eight bytes

 LDY T                  \ Restore the value of Y from before the loop, so it
                        \ once again contains the pixel row offset within the
                        \ each character block for the line we are drawing

 JMP vlin9              \ Jump to hlin8 to draw the top end of the line into
                        \ the tile that we just copied

.vlin8

                        \ If we get here then we have either allocated a new
                        \ tile number for the line, or the tile number already
                        \ allocated to this part of the line is >= 60, which is
                        \ a dynamic tile into which we can draw
                        \
                        \ In either case the tile number is in A

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the tile containing the line we are
 ROL SC+1               \ drawing
 STA SC

.vlin9

 LDX S                  \ Set X to the pixel column within the character block
                        \ at which we want to draw our line, which we stored in
                        \ S in part 1

 LDY Q                  \ Set Y to y-coordinate of the start of the line, which
                        \ we stored in Q above

 LDA R                  \ If the height remaining in R is 0 then we have no more 
 BEQ vlin11             \ line to draw, so jump to vlin11 to return from the
                        \ subroutine

.vlin10

 LDA (SC),Y             \ Draw a pixel at x-coordinate X into the Y-th byte
 ORA TWOS,X             \ of SC(1 0)
 STA (SC),Y

 DEC R                  \ Decrement the height remaining counter in R, as we
                        \ just drew a pixel

 BEQ vlin11             \ If the height remaining in R is 0 then we have no more 
                        \ line to draw, so jump to vlin11 to return from the
                        \ subroutine

 INY                    \ Increment the y-coordinate in Y so we move down the
                        \ line by one pixel

 CPY #8                 \ If Y < 8, loop back to vlin10 draw the next pixel as
 BCC vlin10             \ we haven't yet reached the bottom of the character
                        \ block containing the line's top end

 BCS vlin12             \ If Y >= 8 then we have drawn our vertical line from
                        \ the starting point to the bottom of the character
                        \ block containing the line's top end, so jump to vlin12
                        \ to move down one row to draw the middle portion of the
                        \ line

.vlin11

 LDY YSAV               \ Restore Y from YSAV, so that it's preserved

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: DrawVerticalLine (Part 3 of 3)
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: Draw the middle portion of the line from full-height blocks
\
\ ******************************************************************************

.vlin12

                        \ We now draw the middle part of the line (i.e. the part
                        \ between the top and bottom caps)

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDY #0                 \ We want to start drawing the line from the top pixel
                        \ line in the next character row, so set Y = 0 to use as
                        \ the pixel row number

                        \ Next, we update SC2(1 0) to the address of the next
                        \ row down in the nametable buffer, which we can do by
                        \ adding 32 as there are 32 tiles in each row

 LDA SC2                \ Set SC2(1 0) = SC2(1 0) + 32
 CLC                    \
 ADC #32                \ Starting with the low bytes
 STA SC2

 BCC vlin13             \ And then the high bytes
 INC SC2+1

.vlin13

                        \ We jump here from part 2 if the line starts at the top
                        \ of a character block

 LDA R                  \ If the height remaining in R is 0 then we have no more 
 BEQ vlin11             \ line to draw, so jump to vlin11 to return from the
                        \ subroutine

 SEC                    \ Set A = A - 8
 SBC #8                 \       = R - 8
                        \
                        \ So this subtracts 8 pixels (one block) from the number
                        \ of pixels we still have to draw

 BCS vlin14             \ If the subtraction didn't underflow, then there are at
                        \ least 8 more pixels to draw, so jump to vlin14 to draw
                        \ another block's worth of pixels

 JMP vlin4              \ The subtraction underflowed, so R is less than 8 and
                        \ we need to stop drawing full-height blocks and draw
                        \ the bottom end of the line, so jump to vlin4 with
                        \ Y = 0 to do just this

.vlin14

 STA R                  \ Store the updated number of pixels left to draw, which
                        \ we calculated in the subtraction above

 LDX #0                 \ If the nametable buffer entry is zero for the tile
 LDA (SC2,X)            \ containing the pixels that we want to draw, then a
 BEQ vlin15             \ tile has not yet been allocated to this entry, so jump
                        \ to vlin15 to place a pre-rendered tile into the
                        \ nametable entry

 CMP #60                \ If A < 60, then the tile that's already allocated is
 BCC vlin17             \ either an icon bar tile, or one of the pre-rendered
                        \ tiles containing horizontal and vertical line
                        \ patterns, so jump to vlin17 to process drawing on top
                        \ off the pre-rendered tile

                        \ If we get here then the tile number already allocated
                        \ to this part of the line is >= 60, which is a dynamic
                        \ tile into which we can draw
                        \
                        \ The tile number is in A

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the tile containing the line we are
 ROL SC+1               \ drawing
 STA SC

 LDX S                  \ Set X to the pixel column within the character block
                        \ at which we want to draw our line, which we stored in
                        \ S in part 1

 LDY #0                 \ We are going to draw a vertical line from pixel row 0
                        \ to row 7, so set an index in Y to count up

                        \ We repeat the following code eight times, so it draws
                        \ eight pixels from the top of the character block to
                        \ the bottom

 LDA (SC),Y             \ Draw a pixel at x-coordinate X into the Y-th byte
 ORA TWOS,X             \ of SC(1 0)
 STA (SC),Y

 INY                    \ Increment the index in Y

 LDA (SC),Y             \ Draw a pixel at x-coordinate X into the Y-th byte
 ORA TWOS,X             \ of SC(1 0)
 STA (SC),Y

 INY                    \ Increment the index in Y

 LDA (SC),Y             \ Draw a pixel at x-coordinate X into the Y-th byte
 ORA TWOS,X             \ of SC(1 0)
 STA (SC),Y

 INY                    \ Increment the index in Y

 LDA (SC),Y             \ Draw a pixel at x-coordinate X into the Y-th byte
 ORA TWOS,X             \ of SC(1 0)
 STA (SC),Y

 INY                    \ Increment the index in Y

 LDA (SC),Y             \ Draw a pixel at x-coordinate X into the Y-th byte
 ORA TWOS,X             \ of SC(1 0)
 STA (SC),Y

 INY                    \ Increment the index in Y

 LDA (SC),Y             \ Draw a pixel at x-coordinate X into the Y-th byte
 ORA TWOS,X             \ of SC(1 0)
 STA (SC),Y

 INY                    \ Increment the index in Y

 LDA (SC),Y             \ Draw a pixel at x-coordinate X into the Y-th byte
 ORA TWOS,X             \ of SC(1 0)
 STA (SC),Y

 INY                    \ Increment the index in Y

 LDA (SC),Y             \ Draw a pixel at x-coordinate X into the Y-th byte
 ORA TWOS,X             \ of SC(1 0)
 STA (SC),Y

 JMP vlin12             \ Loop back to move down a row and draw the next block

.vlin15

 LDA S                  \ Set A to the pixel column within the character block
                        \ at which we want to draw our line, which we stored in
                        \ S in part 1

 CLC                    \ Patterns 52 to 59 contain pre-rendered tiles, each
 ADC #52                \ containing a single-pixel vertical line, with a line
 STA (SC2,X)            \ at column 0 in pattern 52, a line at column 1 in
                        \ pattern 53, and so on up to column 7 in pattern 58,
                        \ so this sets the nametable entry for the character
                        \ block we are drawing to the correct pre-rendered tile
                        \ for drawing a vertical line in pixel column A

.vlin16

 JMP vlin12             \ Loop back to move down a row and draw the next block

.vlin17

                        \ If we get here then A <= 59, so the tile that's
                        \ already allocated is either an icon bar tile, or one
                        \ of the pre-rendered tiles containing horizontal and
                        \ vertical line patterns
                        \
                        \ We jump here with X = 0, so the write to (SC2,X)
                        \ below will work properly

 STA SC                 \ Set SC to the number of the tile that is already
                        \ allocated to this part of the screen, so we can
                        \ retrieve it later

 LDA firstFreeTile      \ If firstFreeTile is zero then we have run out of tiles
 BEQ vlin16             \ to use for drawing lines and pixels, so jump to vlin16
                        \ to move down by one character block without drawing
                        \ anything, as we don't have enough dynamic tiles to
                        \ draw this part of the line

 INC firstFreeTile      \ Increment firstFreeTile to point to the next available
                        \ dynamic tile for drawing, so it can be used the next
                        \ time we need to draw lines or pixels into a tile

 STA (SC2,X)            \ Otherwise firstFreeTile contains the number of the
                        \ next available tile for drawing, so allocate this tile
                        \ to contain the pre-rendered tile that we want to copy
                        \ by setting the nametable entry to the tile number we
                        \ just fetched

 LDX pattBufferHiDiv8   \ Set SC3(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC3+1              \              = (pattBufferHi A) + A * 8
 ASL A                  \
 ROL SC3+1              \ So SC3(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC3+1              \ pattern data), which means SC3(1 0) points to the
 ASL A                  \ pattern data for the dynamic tile we just fetched
 ROL SC3+1
 STA SC3

 LDA SC                 \ Set A to the the number of the tile that is already
                        \ allocated to this part of the screen, which we stored
                        \ in SC above

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the tile containing the pre-rendered
 ROL SC+1               \ pattern that we want to copy
 STA SC

                        \ We now have a new dynamic tile in SC3(1 0) into which
                        \ we can draw the middle part of our line, so we now
                        \ need to copy the pattern of the pre-rendered tile that
                        \ we want to draw on top of
                        \
                        \ Each pattern is made up of eight bytes, so we simply
                        \ need to copy eight bytes from SC(1 0) to SC3(1 0)

 STY T                  \ Store Y in T so we can retrieve it after the following
                        \ loop

 LDY #7                 \ We now copy eight bytes from SC(1 0) to SC3(1 0), so
                        \ set a counter in Y

 LDX S                  \ Set X to the pixel column within the character block
                        \ at which we want to draw our line, which we stored in
                        \ S in part 1

.vlin18

 LDA (SC),Y             \ Draw a pixel at x-coordinate X into the Y-th byte
 ORA TWOS,X             \ of SC(1 0) and store the result in the Y-th byte of
 STA (SC3),Y            \ SC3(1 0), so this copies the pre-rendered pattern,
                        \ superimposes our vertical line on the result and
                        \ stores it in the pattern buffer for the tile we just
                        \ allocated

 DEY                    \ Decrement the counter

 BPL vlin18             \ Loop back until we have copied all eight bytes

 BMI vlin16             \ Jump to vlin12 via vlin16 to move down a row and draw
                        \ the next block 

\ ******************************************************************************
\
\       Name: PIXEL
\       Type: Subroutine
\   Category: Drawing pixels
\    Summary: Draw a 1-pixel dot
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X                   The screen x-coordinate of the point to draw
\
\   A                   The screen y-coordinate of the point to draw
\
\ Returns:
\
\   Y                   Y is preserved
\
\ Other entry points:
\
\   pixl2               Restore the value of Y and return from the subroutine
\
\ ******************************************************************************

.PIXEL

 STX SC2                \ Set SC2 to the pixel's x-coordinate in X

 STY T1                 \ Store Y in T1 so we can retrieve it at the end of the
                        \ subroutine

 TAY                    \ Set Y to the pixel's y-coordinate

 TXA                    \ Set SC(1 0) = (nameBufferHi 0) + yLookup(Y) + X / 8
 LSR A                  \
 LSR A                  \ where yLookup(Y) uses the (yLookupHi yLookupLo) table
 LSR A                  \ to convert the pixel y-coordinate in Y into the number
 CLC                    \ of the first tile on the row containing the pixel
 ADC yLookupLo,Y        \
 STA SC                 \ Adding nameBufferHi and X / 8 therefore sets SC(1 0)
 LDA nameBufferHi       \ to the address of the entry in the nametable buffer
 ADC yLookupHi,Y        \ that contains the tile number for the tile containing
 STA SC+1               \ the pixel at (X, Y), i.e. the line we are drawing

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0                 \ If the nametable buffer entry is non-zero for the tile
 LDA (SC,X)             \ containing the pixel that we want to draw, then a tile
 BNE pixl1              \ has already been allocated to this entry, so skip the
                        \ following

 LDA firstFreeTile      \ If firstFreeTile is zero then we have run out of tiles
 BEQ pixl2              \ to use for drawing lines and pixels, so jump to pixl2
                        \ to return from the subroutine, as we can't draw the
                        \ pixel

 STA (SC,X)             \ Otherwise firstFreeTile contains the number of the
                        \ next available tile for drawing, so allocate this tile
                        \ to cover the pixel that we want to draw by setting the
                        \ nametable entry to the tile number we just fetched

 INC firstFreeTile      \ Increment firstFreeTile to point to the next available
                        \ tile for drawing, so it can be added to the nametable
                        \ the next time we need to draw lines or pixels into a
                        \ tile

.pixl1

 LDX pattBufferHiDiv8   \ Set SC(1 0) = (pattBufferHiDiv8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the tile containing the line we are
 ROL SC+1               \ drawing
 STA SC

 TYA                    \ Set Y = Y mod 8, which is the pixel row within the
 AND #7                 \ character block at which we want to draw the start of
 TAY                    \ our line (as each character block has 8 rows)

 LDA SC2                \ Set X = X mod 8, which is the horizontal pixel number
 AND #7                 \ within the character block where the line starts (as
 TAX                    \ each pixel line in the character block is 8 pixels
                        \ wide, and we set SC2 to the x-coordinate above)

 LDA TWOS,X             \ Fetch a 1-pixel byte from TWOS where pixel X is set

 ORA (SC),Y             \ Store the pixel byte into screen memory at SC(1 0),
 STA (SC),Y             \ using OR logic so it merges with whatever is already
                        \ on-screen

.pixl2

 LDY T1                 \ Restore the value of Y from T1 so it is preserved

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: DrawDash
\       Type: Subroutine
\   Category: Drawing pixels
\    Summary: Draw a 2-pixel dash
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X                   The screen x-coordinate of the dash to draw
\
\   A                   The screen y-coordinate of the dash to draw
\
\ Returns:
\
\   Y                   Y is preserved
\
\ ******************************************************************************

.DrawDash

 STX SC2                \ Set SC2 to the pixel's x-coordinate in X

 STY T1                 \ Store Y in T1 so we can retrieve it at the end of the
                        \ subroutine

 TAY                    \ Set Y to the pixel's y-coordinate

 TXA                    \ Set SC(1 0) = (nameBufferHi 0) + yLookup(Y) + X / 8
 LSR A                  \
 LSR A                  \ where yLookup(Y) uses the (yLookupHi yLookupLo) table
 LSR A                  \ to convert the pixel y-coordinate in Y into the number
 CLC                    \ of the first tile on the row containing the pixel
 ADC yLookupLo,Y        \
 STA SC                 \ Adding nameBufferHi and X / 8 therefore sets SC(1 0)
 LDA nameBufferHi       \ to the address of the entry in the nametable buffer
 ADC yLookupHi,Y        \ that contains the tile number for the tile containing
 STA SC+1               \ the pixel at (X, Y), i.e. the line we are drawing

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0                 \ If the nametable buffer entry is non-zero for the tile
 LDA (SC,X)             \ containing the pixel that we want to draw, then a tile
 BNE dash1              \ has already been allocated to this entry, so skip the
                        \ following

 LDA firstFreeTile      \ If firstFreeTile is zero then we have run out of tiles
 BEQ pixl2              \ to use for drawing lines and pixels, so jump to pixl2
                        \ to return from the subroutine, as we can't draw the
                        \ dash

 STA (SC,X)             \ Otherwise firstFreeTile contains the number of the
                        \ next available tile for drawing, so allocate this tile
                        \ to cover the dash that we want to draw by setting the
                        \ nametable entry to the tile number we just fetched

 INC firstFreeTile      \ Increment firstFreeTile to point to the next available
                        \ tile for drawing, so it can be added to the nametable
                        \ the next time we need to draw lines or pixels into a
                        \ tile

.dash1

 LDX #HI(pattBuffer0)/8 \ Set SC(1 0) = (pattBuffer0/8 A) * 8
 STX SC+1               \             = (pattBufferHi 0) + A * 8
 ASL A                  \
 ROL SC+1               \ So SC(1 0) is the address in the pattern buffer for
 ASL A                  \ tile number A (as each tile contains 8 bytes of
 ROL SC+1               \ pattern data), which means SC(1 0) points to the
 ASL A                  \ pattern data for the tile containing the line we are
 ROL SC+1               \ drawing
 STA SC

 TYA                    \ Set Y = Y mod 8, which is the pixel row within the
 AND #7                 \ character block at which we want to draw the start of
 TAY                    \ our line (as each character block has 8 rows)

 LDA SC2                \ Set X = X mod 8, which is the horizontal pixel number
 AND #7                 \ within the character block where the line starts (as
 TAX                    \ each pixel line in the character block is 8 pixels
                        \ wide, and we set SC2 to the x-coordinate above)

 LDA TWOS2,X            \ Fetch a 2-pixel byte from TWOS2 where pixels X and X+1
                        \ are set

 ORA (SC),Y             \ Store the dash byte into screen memory at SC(1 0),
 STA (SC),Y             \ using OR logic so it merges with whatever is already
                        \ on-screen

 LDY T1                 \ Restore the value of Y from T1 so it is preserved

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: ECBLB2
\       Type: Subroutine
\   Category: Dashboard
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
\   Category: Dashboard
\    Summary: ???
\
\ ******************************************************************************

.MSBAR

 TYA
 PHA
 LDY missileNames,X
 PLA
 STA nameBuffer0+22*32,Y
 LDY #0
 RTS

\ ******************************************************************************
\
\       Name: missileNames
\       Type: Variable
\   Category: Dashboard
\    Summary: ???
\
\ ******************************************************************************

.missileNames

 EQUB &00, &5F, &5E, &3F, &3E

\ ******************************************************************************
\
\       Name: autoplayKeys_EN
\       Type: Variable
\   Category: Demo
\    Summary: ???
\
\ ******************************************************************************

.autoplayKeys_EN

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
\       Name: autoplayKeys_DE
\       Type: Variable
\   Category: Demo
\    Summary: ???
\
\ ******************************************************************************

.autoplayKeys_DE

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
\       Name: autoplayKeys_FR
\       Type: Variable
\   Category: Demo
\    Summary: ???
\
\ ******************************************************************************

.autoplayKeys_FR

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
\       Name: autoplayKeys_ALL
\       Type: Variable
\   Category: Demo
\    Summary: ???
\
\ ******************************************************************************

.autoplayKeys_ALL

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
\       Name: AutoPlayDemo
\       Type: Subroutine
\   Category: Demo
\    Summary: Automatically play the demo using the key presses from the
\             autoplayKeys tables
\
\ ******************************************************************************

.AutoPlayDemo

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
 STA autoPlayDemo
 RTS

.CE822

 LDX demoLoopCounter
 BNE CE83F
 LDY #0
 LDA (autoplayKeys),Y
 BMI CE878
 STA autoplayKey
 INY
 LDA (autoplayKeys),Y
 SEC
 TAX

.CE835

 LDA #1

.CE837

 ADC autoplayKeys
 STA autoplayKeys
 BCC CE83F
 INC autoplayKeys+1

.CE83F

 DEX
 STX demoLoopCounter
 LDA autoplayKey
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
 STA autoplayKey
 BEQ CE835

.CE886

 ASL A
 BEQ CE8D1
 PHA
 INY
 LDA (autoplayKeys),Y
 STA autoplayKey
 INY
 LDA (autoplayKeys),Y
 STA addr
 INY
 LDA (autoplayKeys),Y
 STA addr+1
 LDY #0
 LDX #1
 PLA
 CMP #8
 BCS CE8AC
 LDA (addr),Y
 BNE CE83F

.CE8A7

 LDA #4
 CLC
 BCC CE837

.CE8AC

 BNE CE8B4
 LDA (addr),Y
 BEQ CE83F
 BNE CE8A7

.CE8B4

 CMP #&10
 BCS CE8BE
 LDA (addr),Y
 BMI CE83F
 BPL CE8A7

.CE8BE

 BNE CE8C7
 LDA (addr),Y
 BMI CE8A7
 JMP CE83F

.CE8C7

 LDA #&C0
 STA controller1Start
 LDX #&16
 CLC
 BCC CE87F

.CE8D1

 LDA #HI(autoplayKeys_ALL)
 STA autoplayKeys+1
 LDA #LO(autoplayKeys_ALL)
 STA autoplayKeys
 RTS

.CE8DA

 STA autoPlayDemo
 RTS

\ ******************************************************************************
\
\       Name: HideIconBarPointer
\       Type: Subroutine
\   Category: Icon bar
\    Summary: ???
\
\ ******************************************************************************

.HideIconBarPointer

 LDA controller1Start   \ If the Start button on controller 1 was being held
 AND #%11000000         \ down (bit 6 is set) but is no longer being held down
 CMP #%01000000         \ (bit 7 is clear) then keep going, otherwise jump to
 BNE CE8EE              \ CE8EE

 LDA #80
 STA pointerButton
 BNE CE8FA

.CE8EE

 LDA pointerButton
 CMP #80
 BEQ CE8FA

.CE8F5

 LDA #0
 STA pointerButton

.CE8FA

 LDA #240               \ Set A to the y-coordinate that's just below the bottom
                        \ of the screen, so we can hide the icon bar pointer
                        \ sprites by moving them off-screen

 STA ySprite1           \ Set the y-coordinates for the four icon bar pointer
 STA ySprite2           \ sprites to 240, to move them off-screen
 STA ySprite3
 STA ySprite4

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: SetIconBarPointer
\       Type: Subroutine
\   Category: Icon bar
\    Summary: Set the icon bar pointer to a specific position
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The button number on which to position the pointer
\
\ ******************************************************************************

.SetIconBarPointer

 ASL A                  \ Set xIconBarPointer =  A * 4
 ASL A                  \
 STA xIconBarPointer    \ As xIconBarPointer contains the x-coordinate of the
                        \ icon bar pointer, incrementing by 4 for each button

 LDX #0                 \ Zero all the pointer timer and movement variables so
 STX pointerPosition    \ the pointer is static and in the correct position
 STX pointerDirection
 STX L0468
 STX pointerTimer

IF _PAL

 STX pointerTimerOn     \ Zero the PAL-specific pointer timer variable

ENDIF

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: MoveIconBarPointer
\       Type: Subroutine
\   Category: Icon bar
\    Summary: Move the sprites that make up the icon bar pointer
\
\ ******************************************************************************

.MoveIconBarPointer

 DEC pointerTimer

IF _PAL

 BNE CE928
 LSR pointerTimerOn

.CE928

ENDIF

 BPL CE925
 INC pointerTimer

.CE925

 DEC pointerPosition
 BPL CE92D
 INC pointerPosition

.CE92D

 LDA screenFadedToBlack \ If bit 7 of screenFadedToBlack is set then we have
 BMI CE8F5              \ already faded the screen to black, so jump to CE8F5
                        \ to ???

 LDA showIconBarPointer \ If showIconBarPointer = 0 then the icon bar pointer
 BEQ HideIconBarPointer \ should be hidden, so jump to HideIconBarPointer to do
                        \ just that

 LDA pointerDirection
 CLC
 ADC xIconBarPointer
 STA xIconBarPointer

 AND #3
 BNE CE98D

 LDA #0
 STA pointerDirection

 LDA pointerPosition
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

 CPX #%10000000
 BNE CE96F

 LDX #12
 STX pointerPosition

.CE96F

 STA pointerDirection

.CE972

 LDX controller1Right
 BMI CE97F

 LDA #0
 STA controller1Right

 JMP CE98D

.CE97F

 LDA #1

 CPX #%10000000
 BNE CE98A

 LDX #12
 STX pointerPosition

.CE98A

 STA pointerDirection

.CE98D

 LDA xIconBarPointer
 BPL CE999

 LDA #0
 STA pointerDirection

 BEQ CE9A4

.CE999

 CMP #45
 BCC CE9A4

 LDA #0
 STA pointerDirection

 LDA #44

.CE9A4

 STA xIconBarPointer

 LDA xIconBarPointer
 AND #3
 ORA pointerDirection
 BNE CEA04

 LDA controller1B
 BMI CEA04

 LDA controller1B
 BMI CEA04

 LDA controller1Select
 BNE CEA04

 LDA #251
 STA tileSprite1
 STA tileSprite2

 LDA yIconBarPointer
 CLC

 ADC #11+YPAL
 STA ySprite1
 STA ySprite2

 LDA xIconBarPointer
 ASL A
 ASL A
 ADC xIconBarPointer
 ADC #6
 STA xSprite4

 ADC #1
 STA xSprite1

 ADC #13
 STA xSprite2

 ADC #1
 STA xSprite3

 LDA yIconBarPointer
 CLC
 ADC #19+YPAL
 STA ySprite4
 STA ySprite3

 LDA xIconBarPointer
 BNE CEA40

 JMP CEA40

.CEA04

 LDA #252
 STA tileSprite1
 STA tileSprite2

 LDA yIconBarPointer
 CLC

 ADC #8+YPAL
 STA ySprite1
 STA ySprite2

 LDA xIconBarPointer
 ASL A
 ASL A
 ADC xIconBarPointer
 ADC #6
 STA xSprite4

 ADC #1
 STA xSprite1

 ADC #13
 STA xSprite2

 ADC #1
 STA xSprite3

 LDA yIconBarPointer
 CLC
 ADC #16+YPAL
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
 AND #%11110000
 CMP #%10000000
 BEQ CEA73

 LDA controller1B
 AND #%11000000
 CMP #%10000000
 BNE CEA6A

 LDA #30
 STA L0468

.CEA6A

 CMP #%01000000
 BNE CEA7E

IF _NTSC

 LDA L0468
 BEQ CEA7E

.CEA73

ELIF _PAL

 LDA L0468
 BNE CEA80

 STA pointerTimerOn
 BEQ CEA7E

.CEA80

 LDA #40
 STA pointerTimer

 LDA pointerTimerOn
 BNE CEA73

 INC pointerTimerOn
 BNE CEA7E

.CEA73

 LSR pointerTimerOn

ENDIF

 LDA xIconBarPointer    \ Set Y to the button number that the icon bar pointer
 LSR A                  \ is over
 LSR A
 TAY

 LDA (barButtons),Y     \ Set pointerButton to the Y-th entry from the button
 STA pointerButton      \ table for this icon bar

.CEA7E

 LDA controller1Start   \ If the Start button on controller 1 was being held
 AND #%11000000         \ down (bit 6 is set) but is no longer being held down
 CMP #%01000000         \ (bit 7 is clear) then keep going, otherwise jump to
 BNE CEA8C              \ CEA8C

 LDA #80
 STA pointerButton

.CEA8C

 RTS

\ ******************************************************************************
\
\       Name: ScaleController
\       Type: Subroutine
\   Category: Controllers
\    Summary: ???
\
\ ******************************************************************************

.ScaleController

 LDA controller1B
 BNE CEAA7

 LDA controller1Left
 ASL A
 ASL A
 ASL A
 ASL A
 STA controller1Leftx8

 LDA controller1Right
 ASL A
 ASL A
 ASL A
 ASL A
 STA controller1Rightx8

 RTS

.CEAA7

 LDA #0
 STA controller1Leftx8
 STA controller1Rightx8

 RTS

\ ******************************************************************************
\
\       Name: UpdateJoystick
\       Type: Subroutine
\   Category: Controllers
\    Summary: Update the values of JSTX and JSTY with the values from the
\             controller
\
\ ******************************************************************************

.UpdateJoystick

 LDA QQ11a
 BNE ScaleController
 LDX JSTX
 LDA #8
 STA addr
 LDY scanController2
 BNE CEAC5
 LDA controller1B
 BMI CEB0C

.CEAC5

 LDA controller1Right,Y
 BPL CEACD
 JSR DecreaseX

.CEACD

 LDA controller1Left,Y
 BPL CEAD5
 JSR IncreaseX

.CEAD5

 STX JSTX
 TYA
 BNE CEADB

.CEADB

 LDA #4
 STA addr
 LDX JSTY
 LDA JSTGY
 BMI CEAFB
 LDA controller1Down,Y
 BPL CEAEF
 JSR DecreaseX

.CEAEF

 LDA controller1Up,Y
 BPL CEAF7

.loop_CEAF4

 JSR IncreaseX

.CEAF7

 STX JSTY
 RTS

.CEAFB

 LDA controller1Up,Y
 BPL CEB03
 JSR DecreaseX

.CEB03

 LDA controller1Down,Y
 BMI loop_CEAF4
 STX JSTY
 RTS

.CEB0C

 RTS

\ ******************************************************************************
\
\       Name: IncreaseX
\       Type: Subroutine
\   Category: Controllers
\    Summary: ???
\
\ ******************************************************************************

.IncreaseX

 TXA
 CLC
 ADC addr
 TAX
 BCC CEB16
 LDX #&FF

.CEB16

 BPL CEB24
 RTS

\ ******************************************************************************
\
\       Name: DecreaseX
\       Type: Subroutine
\   Category: Controllers
\    Summary: ???
\
\ ******************************************************************************

.DecreaseX

 TXA
 SEC
 SBC addr
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
\       Name: iconBarButtons
\       Type: Variable
\   Category: Icon bar
\    Summary: A list of button numbers for each icon bar type
\
\ ******************************************************************************

.iconBarButtons

                        \ Icon bar 0 (docked)

 EQUB  1                \ Launch
 EQUB  2                \ Market Price
 EQUB  3                \ Status Mode
 EQUB  4                \ Charts
 EQUB  5                \ Equip Ship
 EQUB  6                \ Save and load
 EQUB  7                \ Change commander name (only on save screen)
 EQUB 35                \ Data on System
 EQUB  8                \ Inventory
 EQUB  0                \ (blank)
 EQUB  0                \ (blank)
 EQUB 12                \ Fast forward

 EQUD  0

                        \ Icon bar 1 (flight)

 EQUB 17                \ Docking computer
 EQUB  2                \ Market Price
 EQUB  3                \ Status Mode
 EQUB  4                \ Charts
 EQUB 21                \ Front space view (and rear, left, right)
 EQUB 22                \ Hyperspace (only when system is selected)
 EQUB 23                \ E.C.M. (if fitted)
 EQUB 24                \ Target missile
 EQUB 25                \ Fire targetted missile
 EQUB 26                \ Energy bomb (if fitted)
 EQUB 27                \ Escape capsule (if fitted)
 EQUB 12                \ Fast forward

 EQUD  0

                        \ Icon bar 2 (charts)

 EQUB  1                \ Launch
 EQUB  2                \ Market Price
 EQUB 36                \ Switch chart range (long, short)
 EQUB 35                \ Data on System
 EQUB 21                \ Front space view (only in flight)
 EQUB 38                \ Return pointer to current system
 EQUB 39                \ Search for system
 EQUB 22                \ Hyperspace (only when system is selected)
 EQUB 41                \ Galactic Hyperspace (if fitted)
 EQUB 23                \ E.C.M. (if fitted)
 EQUB 27                \ Escape capsule (if fitted)
 EQUB 12                \ Fast forward

 EQUD  0

                        \ Icon bar 3 (pause options)

 EQUB 49                \ Direction of y-axis
 EQUB 50                \ Damping toggle
 EQUB 51                \ Music toggle
 EQUB 52                \ Sound toggle
 EQUB 53                \ Number of pilots
 EQUB  0                \ (blank)
 EQUB  0                \ (blank)
 EQUB  0                \ (blank)
 EQUB  0                \ (blank)
 EQUB  0                \ (blank)
 EQUB  0                \ (blank)
 EQUB 60                \ Restart

 EQUD  0

\ ******************************************************************************
\
\       Name: HideStardust
\       Type: Subroutine
\   Category: Stardust
\    Summary: Hide the stardust sprites
\
\ ******************************************************************************

.HideStardust

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX NOSTM              \ Set X = NOSTM so we hide NOSTM+1 sprites

 LDY #152               \ Set Y so we start hiding from sprite 152 / 4 = 38

                        \ Fall through into HideMoreSprites to hide NOSTM+1
                        \ sprites from sprite 38 onwards (i.e. 38 to 58 in
                        \ normal space when NOSTM is 20, or 38 to 41 in
                        \ witchspace when NOSTM is 3)

\ ******************************************************************************
\
\       Name: HideMoreSprites
\       Type: Subroutine
\   Category: Drawing sprites
\    Summary: Hide X + 1 sprites from sprite Y / 4 onwards
\
\ ------------------------------------------------------------------------------
\
\ This routine is similar to HideSprites, except it hides X + 1 sprites rather
\ than X sprites.
\
\ Arguments:
\
\   X                   The number of sprites to hide (we hide X + 1)
\
\   Y                   The number of the first sprite to hide * 4
\
\ ******************************************************************************

.HideMoreSprites

 LDA #240               \ Set A to the y-coordinate that's just below the bottom
                        \ of the screen, so we can hide the required sprites by
                        \ moving them off-screen

.hisp1

 STA ySprite0,Y         \ Set the y-coordinate for sprite Y / 4 to 240 to hide
                        \ it (the division by four is because each sprite in the
                        \ sprite buffer has four bytes of data)

 INY                    \ Add 4 to Y so it points to the next sprite's data in
 INY                    \ the sprite buffer
 INY
 INY

 DEX                    \ Decrement the loop counter in X

 BPL hisp1              \ Loop back until we have hidden X + 1 sprites

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: SetScreenForUpdate
\       Type: Subroutine
\   Category: Drawing sprites
\    Summary: Get the screen ready for updating by hiding all sprites, after
\             fading the screen to black if we are changing view
\
\ ******************************************************************************

.SetScreenForUpdate

 LDA QQ11a              \ If QQ11 = QQ11a, then we are not currently changing
 CMP QQ11               \ view, so jump to HideMostSprites to hide all sprites
 BEQ HideMostSprites    \ except for sprite 0 and the icon bar pointer

                        \ Otherwise fall through into FadeAndHideSprites to fade
                        \ the screen to black and hide all the sprites

\ ******************************************************************************
\
\       Name: FadeAndHideSprites
\       Type: Subroutine
\   Category: Drawing sprites
\    Summary: Fade the screen to black and hide all sprites
\
\ ******************************************************************************

.FadeAndHideSprites

 JSR FadeToBlack_b3     \ Fade the screen to black over the next four VBlanks

\ ******************************************************************************
\
\       Name: HideMostSprites
\       Type: Subroutine
\   Category: Drawing sprites
\    Summary: Hide all sprites except for sprite 0 and the icon bar pointer
\
\ ******************************************************************************

.HideMostSprites

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #58                \ Set X = 58 so we hide 59 sprites

 LDY #20                \ Set Y so we start hiding from sprite 20 / 4 = 5

 BNE HideMoreSprites    \ Jump to HideMoreSprites to hide 59 sprites from
                        \ sprite 5 onwards (i.e. sprites 5 to 63, which only
                        \ leaves sprite 0 and the icon bar pointer sprites 1 to
                        \ 4)
                        \
                        \ We return from the subroutine using a tail call (this
                        \ BNE is effectively a JMP as Y is never zero)

INCLUDE "library/common/main/subroutine/delay.asm"

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

 LDY #13
 BNE NOISE

\ ******************************************************************************
\
\       Name: FlushSoundChannels
\       Type: Subroutine
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.FlushSoundChannels

 LDX #0
 JSR FlushSoundChannel

.loop_CEBB6

 LDX #1
 JSR FlushSoundChannel

 LDX #2
 BNE FlushSoundChannel

\ ******************************************************************************
\
\       Name: ECBLB
\       Type: Subroutine
\   Category: Dashboard
\    Summary: ???
\
\ ******************************************************************************

.ECBLB

 LDX soundLookup1,Y

 CPX #3
 BCC FlushSoundChannel

 BNE loop_CEBB6

 LDX #0
 JSR FlushSoundChannel

 LDX #2

\ ******************************************************************************
\
\       Name: FlushSoundChannel
\       Type: Subroutine
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.FlushSoundChannel

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA #0
 STA soundPriority,X

 LDA #26
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
\       Name: MakeScoopSound
\       Type: Subroutine
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.MakeScoopSound

 LDY #1
 BNE NOISE

\ ******************************************************************************
\
\       Name: HyperspaceSound
\       Type: Subroutine
\   Category: Sound
\    Summary: Make the hyperspace sound
\
\ ******************************************************************************

.HyperspaceSound

 JSR FlushSoundChannels

 LDY #21

\ ******************************************************************************
\
\       Name: NOISE
\       Type: Subroutine
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.NOISE

 LDA DNOIZ
 BPL CEC2E
 LDX soundLookup1,Y
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
 LDA soundLookup2,Y
 CMP soundPriority,X
 BCC CEC2E

.CEC17

 LDA soundLookup2,Y
 STA soundPriority,X

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 TYA

.CEC2B

 JSR MakeNoise_b6

.CEC2E

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 RTS

\ ******************************************************************************
\
\       Name: soundLookup1
\       Type: Variable
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.soundLookup1

 EQUB 2, 1, 1, 1, 1, 0, 0, 1, 2, 2, 2, 2, 3   ; EC3C: 02 01 01... ...
 EQUB 2, 2, 0, 0, 0, 0, 0, 2, 3, 3, 2, 1, 2   ; EC49: 02 02 00... ...
 EQUB 0, 2, 0, 1, 0, 0                        ; EC56: 00 02 00... ...

\ ******************************************************************************
\
\       Name: soundLookup2
\       Type: Variable
\   Category: Sound
\    Summary: ???
\
\ ******************************************************************************

.soundLookup2

 EQUB &80, &82, &C0, &21, &21, &10, &10, &41  ; EC5C: 80 82 C0... ...
 EQUB &82, &32, &84, &20, &C0, &60, &40, &80  ; EC64: 82 32 84... .2.
 EQUB &80, &80, &80, &90, &84, &33, &33, &20  ; EC6C: 80 80 80... ...
 EQUB &C0, &18, &10, &10, &10, &10, &10, &60  ; EC74: C0 18 10... ...
 EQUB &60                                     ; EC7C: 60          `

\ ******************************************************************************
\
\       Name: SetupPPUForIconBar
\       Type: Subroutine
\   Category: PPU
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
\   Category: Status
\    Summary: Add the kill count to the fractional and low bytes of our combat
\             rank tally following a kill
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   X                   The type of the ship that was killed
\
\
\ Returns:
\
\   C flag              If set, the addition overflowed
\
\ ******************************************************************************

.IncreaseTally

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

                        \ Ihe fractional kill count is taken from the KWL%
                        \ table, according to the ship's type (we look up the
                        \ X-1-th value from KWL% because ship types start at 1
                        \ rather than 0)

 LDA KWL%-1,X           \ Double the fractional kill count and push the low byte
 ASL A                  \ onto the stack
 PHA

 LDA KWH%-1,X           \ Double the integer kill count and put the high byte
 ROL A                  \ in Y
 TAY

 PLA                    \ Add the doubled fractional kill count to our tally,
 ADC TALLYL             \ starting by adding the fractional bytes:
 STA TALLYL             \
                        \   TALLYL = TALLYL + fractional kill count

 TYA                    \ And then we add the low byte of TALLY(1 0):
 ADC TALLY              \
 STA TALLY              \   TALLY = TALLY + carry + integer kill count

                        \ Fall through into ResetBankP to reset the ROM bank to
                        \ the value we stored on the stack

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
\ Other entry points:
\
\   RTS4                Contains an RTS
\
\ ******************************************************************************

.ResetBankP

 PLA                    \ Fetch the ROM bank number from the stack

 PHP                    \ Store the processor flags on the stack so we can
                        \ retrieve them below

 JSR SetBank            \ Page bank A into memory at &8000

 PLP                    \ Restore the processor flags, so we return the correct
                        \ Z and N flags for the value of A

.RTS4

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: CheckPauseButton
\       Type: Subroutine
\   Category: Icon bar
\    Summary: Pause the game if the icon bar pointer is not over a blank button
\             and the pause button is pressed
\
\ ******************************************************************************

.CheckPauseButton

 LDA pointerButton      \ If pointerButton = 0 then the icon bar pointer is over
 BEQ RTS4               \ a blank button, so jump to RTS4 to return from the
                        \ subroutine

                        \ Otherwise fall through into CheckForPause_b0 to pause
                        \ the game if the pause button is pressed

\ ******************************************************************************
\
\       Name: CheckForPause_b0
\       Type: Subroutine
\   Category: Icon bar
\    Summary: Call the CheckForPause routine in ROM bank 0
\
\ ------------------------------------------------------------------------------
\
\ Returns:
\
\   N, Z flags          Set according to the value of A passed to the routine
\
\ ******************************************************************************

.CheckForPause_b0

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR CheckForPause      \ Call CheckForPause, now that it is paged into memory

 JMP ResetBankP         \ Jump to ResetBankP to retrieve the bank number we
                        \ stored above, page it back into memory and set the
                        \ processor flags according to the value of A, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawInventoryIcon
\       Type: Subroutine
\   Category: Icon bar
\    Summary: Draw the inventory icon on top of the second button in the icon
\             bar
\
\ ******************************************************************************

.DrawInventoryIcon

                        \ We draw the inventory icon image from sprites with
                        \ sequential patterns, so first we configure the
                        \ variables to pass to the DrawSpriteImage routine

 LDA #2                 \ Set K = 2, to pass as the number of columns in the
 STA K                  \ image to DrawSpriteImage below

 STA K+1                \ Set K+1 = 2, to pass as the number of rows in the
                        \ image to DrawSpriteImage below

 LDA #69                \ Set K+2 = 69, so we draw the inventory icon image
 STA K+2                \ using pattern 69 onwards

 LDA #8                 \ Set K+3 = 8, so we build the image from sprite 8
 STA K+3                \ onwards

 LDA #3                 \ Set XC = 3 so we draw the image with the top-left
 STA XC                 \ corner in tile column 3

 LDA #25                \ Set YC = 25 so we draw the image with the top-left
 STA YC                 \ corner on tile row 25

 LDX #7                 \ Set X = 7 so we draw the image seven pixels into the
                        \ (XC, YC) character block along the x-axis

 LDY #7                 \ Set Y = 7 so we draw the image seven pixels into the
                        \ (XC, YC) character block along the y-axis

 JMP DrawSpriteImage_b6 \ Draw the inventory icon from sprites, using pattern
                        \ #69 onwards, returning from the subroutine using a
                        \ tail call

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
\       Name: ChooseMusic_b6
\       Type: Subroutine
\   Category: Sound
\    Summary: Call the ChooseMusic routine in ROM bank 6
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The number of the tune to choose
\
\ ******************************************************************************

.ChooseMusic_b6

 PHA                    \ Wait until the next NMI interrupt has passed (i.e. the
 JSR WaitForNMI         \ next VBlank), preserving the value in A via the stack
 PLA

 ORA #%10000000         \ Set bit 7 of the tune number and store in newTune to
 STA newTune            \ indicate that we are now in the process of changing to
                        \ this tune

 AND #%01111111         \ Clear bit 7 to set A to the tune number once again

 LDX disableMusic       \ If music is disabled then bit 7 of disableMusic will
 BMI RTS4               \ be set, so jump to RTS4 to return from the subroutine
                        \ as we can't choose a new tune if music is disabled

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 6 is already paged into memory, jump to
 CMP #6                 \ bank1
 BEQ bank1

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR ChooseMusic        \ Call ChooseMusic, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank1

 LDA ASAV               \ Restore the value of A that we stored above

 JMP ChooseMusic        \ Call ChooseMusic, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: MakeNoise_b6
\       Type: Subroutine
\   Category: Sound
\    Summary: Call the MakeNoise routine in ROM bank 6
\
\ ******************************************************************************

.MakeNoise_b6

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 6 is already paged into memory, jump to
 CMP #6                 \ bank2
 BEQ bank2

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR MakeNoise          \ Call MakeNoise, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank2

 LDA ASAV               \ Restore the value of A that we stored above

 JMP MakeNoise          \ Call MakeNoise, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: ResetMusicAfterNMI
\       Type: Subroutine
\   Category: Sound
\    Summary: Wait for the next NMI before resetting the current tune to 0 and
\             stopping the music
\
\ ******************************************************************************

.ResetMusicAfterNMI

 JSR WaitForNMI         \ Wait until the next NMI interrupt has passed (i.e. the
                        \ next VBlank)

                        \ Fall through into ResetMusic to reset the current tune
                        \ to 0 and stop the music

\ ******************************************************************************
\
\       Name: ResetMusic
\       Type: Subroutine
\   Category: Sound
\    Summary: Reset the current tune to 0 and stop the music
\
\ ******************************************************************************

.ResetMusic

 LDA #0                 \ Set newTune to to indicate that we have no tune
 STA newTune            \ selected (as bits 0-6 are zero) and we are not in the
                        \ process of changing tunes (as bit 7 is clear)

                        \ Fall through into StopMusic_b6 to stop the music

\ ******************************************************************************
\
\       Name: StopMusic_b6
\       Type: Subroutine
\   Category: Sound
\    Summary: Call the StopMusic routine in ROM bank 6
\
\ ******************************************************************************

.StopMusic_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR StopMusicS         \ Call StopMusic via StopMusicS, now that it is paged
                        \ into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SetDemoAutoPlay_b5
\       Type: Subroutine
\   Category: Demo
\    Summary: Call the SetDemoAutoPlay routine in ROM bank 5
\
\ ******************************************************************************

.SetDemoAutoPlay_b5

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #5                 \ Page ROM bank 5 into memory at &8000
 JSR SetBank

 JSR SetDemoAutoPlay    \ Call SetDemoAutoPlay, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawSmallLogo_b4
\       Type: Subroutine
\   Category: Start and end
\    Summary: Call the DrawSmallLogo routine in ROM bank 4
\
\ ******************************************************************************

.DrawSmallLogo_b4

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #4                 \ Page ROM bank 4 into memory at &8000
 JSR SetBank

 JSR DrawSmallLogo      \ Call DrawSmallLogo, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawBigLogo_b4
\       Type: Subroutine
\   Category: Start and end
\    Summary: Call the DrawBigLogo routine in ROM bank 4
\
\ ******************************************************************************

.DrawBigLogo_b4

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #4                 \ Page ROM bank 4 into memory at &8000
 JSR SetBank

 JSR DrawBigLogo        \ Call DrawBigLogo, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: FadeToBlack_b3
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the FadeToBlack routine in ROM bank 3
\
\ ******************************************************************************

.FadeToBlack_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR FadeToBlack        \ Call FadeToBlack, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: UpdateSaveSlots_b6
\       Type: Subroutine
\   Category: Save and load
\    Summary: Call the UpdateSaveSlots routine in ROM bank 6
\
\ ******************************************************************************

.UpdateSaveSlots_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR UpdateSaveSlots    \ Call UpdateSaveSlots, now that it is paged into memory

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
\       Name: SIGHT_b3
\       Type: Subroutine
\   Category: Flight
\    Summary: Call the SIGHT routine in ROM bank 3
\
\ ******************************************************************************

.SIGHT_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR SIGHT              \ Call SIGHT, now that it is paged into memory

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
\       Name: ChooseLanguage_b6
\       Type: Subroutine
\   Category: Start and end
\    Summary: Call the ChooseLanguage routine in ROM bank 6
\
\ ******************************************************************************

.ChooseLanguage_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR ChooseLanguage     \ Call ChooseLanguage, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: PlayDemo_b0
\       Type: Subroutine
\   Category: Demo
\    Summary: Call the PlayDemo routine in ROM bank 0
\
\ ******************************************************************************

.PlayDemo_b0

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JMP PlayDemo           \ Call PlayDemo, which is already paged into memory, and
                        \ return from the subroutine using a tail call

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
\       Name: DrawBackground_b3
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the DrawBackground routine in ROM bank 3
\
\ ******************************************************************************

.DrawBackground_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR DrawBackground     \ Call DrawBackground, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawSystemImage_b3
\       Type: Subroutine
\   Category: Universe
\    Summary: Call the DrawSystemImage routine in ROM bank 3
\
\ ******************************************************************************

.DrawSystemImage_b3

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank8
 BEQ bank8

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR DrawSystemImage    \ Call DrawSystemImage, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank8

 LDA ASAV               \ Restore the value of A that we stored above

 JMP DrawSystemImage    \ Call DrawSystemImage, which is already paged into
                        \ memory, and return from the subroutine using a tail
                        \ call

\ ******************************************************************************
\
\       Name: DrawImageNames_b4
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the DrawImageNames routine in ROM bank 4
\
\ ******************************************************************************

.DrawImageNames_b4

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #4                 \ Page ROM bank 4 into memory at &8000
 JSR SetBank

 JSR DrawImageNames     \ Call DrawImageNames, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawCmdrImage_b6
\       Type: Subroutine
\   Category: Status
\    Summary: Call the DrawCmdrImage routine in ROM bank 6
\
\ ******************************************************************************

.DrawCmdrImage_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR DrawCmdrImage      \ Call DrawCmdrImage, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawSpriteImage_b6
\       Type: Subroutine
\   Category: Drawing sprites
\    Summary: Call the DrawSpriteImage routine in ROM bank 6
\
\ ******************************************************************************

.DrawSpriteImage_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR DrawSpriteImage    \ Call DrawSpriteImage, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: GetHeadshotType_b4
\       Type: Subroutine
\   Category: Status
\    Summary: Call the GetHeadshotType routine in ROM bank 4
\
\ ******************************************************************************

.GetHeadshotType_b4

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #4                 \ Page ROM bank 4 into memory at &8000
 JSR SetBank

 JSR GetHeadshotType    \ Call GetHeadshotType, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawEquipment_b6
\       Type: Subroutine
\   Category: Equipment
\    Summary: Call the DrawEquipment routine in ROM bank 6
\
\ ******************************************************************************

.DrawEquipment_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR DrawEquipment      \ Call DrawEquipment, now that it is paged into memory

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
\       Name: StartGame_b0
\       Type: Subroutine
\   Category: Start and end
\    Summary: Switch to ROM bank 0 and call the StartGame routine
\
\ ******************************************************************************

.StartGame_b0

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JMP StartGame          \ Call StartGame, which is now paged into memory, and
                        \ return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SetViewAttrs_b3
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the SetViewAttrs routine in ROM bank 3
\
\ ******************************************************************************

.SetViewAttrs_b3

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank9
 BEQ bank9

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR SetViewAttrs       \ Call SetViewAttrs, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank9

 JMP SetViewAttrs       \ Call SetViewAttrs, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: FadeToColour_b3
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the FadeToColour routine in ROM bank 3
\
\ ******************************************************************************

.FadeToColour_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR FadeToColour       \ Call FadeToColour, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawSmallBox_b3
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the DrawSmallBox routine in ROM bank 3
\
\ ******************************************************************************

.DrawSmallBox_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR DrawSmallBox       \ Call DrawSmallBox, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawImageFrame_b3
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the DrawImageFrame routine in ROM bank 3
\
\ ******************************************************************************

.DrawImageFrame_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR DrawImageFrame     \ Call DrawImageFrame, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawLaunchBoxes_b6
\       Type: Subroutine
\   Category: Flight
\    Summary: Call the DrawLaunchBoxes routine in ROM bank 6
\
\ ******************************************************************************

.DrawLaunchBoxes_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR DrawLaunchBoxes    \ Call DrawLaunchBoxes, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SetLinePatterns_b3
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the SetLinePatterns routine in ROM bank 3
\
\ ******************************************************************************

.SetLinePatterns_b3

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank10
 BEQ bank10

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR SetLinePatterns    \ Call SetLinePatterns, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank10

 JMP SetLinePatterns    \ Call SetLinePatterns, which is already paged into
                        \ memory, and return from the subroutine using a tail
                        \ call

\ ******************************************************************************
\
\       Name: TT24_b6
\       Type: Subroutine
\   Category: Universe
\    Summary: Call the TT24 routine in ROM bank 6
\
\ ******************************************************************************

.TT24_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR TT24               \ Call TT24, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: ClearDashEdge_b6
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the ClearDashEdge routine in ROM bank 6
\
\ ******************************************************************************

.ClearDashEdge_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR ClearDashEdge      \ Call ClearDashEdge, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: LoadFontPlane0_b3
\       Type: Subroutine
\   Category: Text
\    Summary: Call the LoadFontPlane0 routine in ROM bank 3
\
\ ******************************************************************************

.LoadFontPlane0_b3

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank11
 BEQ bank11

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR LoadFontPlane0     \ Call LoadFontPlane0, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank11

 LDA ASAV               \ Restore the value of A that we stored above

 JMP LoadFontPlane0     \ Call LoadFontPlane0, which is already paged into
                        \ memory, and return from the subroutine using a tail
                        \ call

\ ******************************************************************************
\
\       Name: LoadFontPlane1_b3
\       Type: Subroutine
\   Category: Text
\    Summary: Call the LoadFontPlane1 routine in ROM bank 3
\
\ ******************************************************************************

.LoadFontPlane1_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR LoadFontPlane1     \ Call LoadFontPlane1, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: PAS1_b0
\       Type: Subroutine
\   Category: Controllers
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
\       Name: GetSystemImage_b5
\       Type: Subroutine
\   Category: Universe
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
\       Name: GetSystemBack_b5
\       Type: Subroutine
\   Category: Universe
\    Summary: Call the GetSystemBack routine in ROM bank 5
\
\ ******************************************************************************

.GetSystemBack_b5

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #5                 \ Page ROM bank 5 into memory at &8000
 JSR SetBank

 JSR GetSystemBack      \ Call GetSystemBack, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: GetCmdrImage_b4
\       Type: Subroutine
\   Category: Status
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
\       Name: GetHeadshot_b4
\       Type: Subroutine
\   Category: Status
\    Summary: Call the GetHeadshot routine in ROM bank 4
\
\ ******************************************************************************

.GetHeadshot_b4

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #4                 \ Page ROM bank 4 into memory at &8000
 JSR SetBank

 JSR GetHeadshot        \ Call GetHeadshot, now that it is paged into memory

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
\       Name: InputName_b6
\       Type: Subroutine
\   Category: Controllers
\    Summary: Call the InputName routine in ROM bank 6
\
\ ******************************************************************************

.InputName_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR InputName          \ Call InputName, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: ChangeToView_b0
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the ChangeToView routine in ROM bank 0
\
\ ******************************************************************************

.ChangeToView_b0

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 0 is already paged into memory, jump to
 CMP #0                 \ bank12
 BEQ bank12

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR ChangeToView       \ Call ChangeToView, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank12

 LDA ASAV               \ Restore the value of A that we stored above

 JMP ChangeToView       \ Call ChangeToView, which is already paged into
                        \ memory, and return from the subroutine using a tail
                        \ call

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
\       Name: DrawLightning_b6
\       Type: Subroutine
\   Category: Flight
\    Summary: Call the DrawLightning routine in ROM bank 6
\
\ ******************************************************************************

.DrawLightning_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR DrawLightning      \ Call DrawLightning, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: PauseGame_b6
\       Type: Subroutine
\   Category: Icon bar
\    Summary: Call the PauseGame routine in ROM bank 6
\
\ ******************************************************************************

.PauseGame_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR PauseGame          \ Call PauseGame, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SetKeyLogger_b6
\       Type: Subroutine
\   Category: Controllers
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
\       Name: ResetCommander_b6
\       Type: Subroutine
\   Category: Save and load
\    Summary: Call the ResetCommander routine in ROM bank 6
\
\ ******************************************************************************

.ResetCommander_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR ResetCommander     \ Call ResetCommander, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: JAMESON_b6
\       Type: Subroutine
\   Category: Save and load
\    Summary: Call the JAMESON routine in ROM bank 6
\
\ ******************************************************************************

.JAMESON_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR JAMESON            \ Call JAMESON, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: ShowScrollText_b6
\       Type: Subroutine
\   Category: Demo
\    Summary: Call the ShowScrollText routine in ROM bank 6
\
\ ******************************************************************************

.ShowScrollText_b6

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 6 is already paged into memory, jump to
 CMP #6                 \ bank13
 BEQ bank13

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR ShowScrollText     \ Call ShowScrollText, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank13

 LDA ASAV               \ Restore the value of A that we stored above

 JMP ShowScrollText     \ Call ShowScrollText, which is already paged into
                        \ memory, and return from the subroutine using a tail
                        \ call

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
\       Name: SetupIconBar_b3
\       Type: Subroutine
\   Category: Icon bar
\    Summary: Call the SetupIconBar routine in ROM bank 3
\
\ ******************************************************************************

.SetupIconBar_b3

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank16
 BEQ bank16

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR SetupIconBar       \ Call SetupIconBar, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank16

 LDA ASAV               \ Restore the value of A that we stored above

 JMP SetupIconBar       \ Call SetupIconBar, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: ShowIconBar_b3
\       Type: Subroutine
\   Category: Icon bar
\    Summary: Call the ShowIconBar routine in ROM bank 3
\
\ ******************************************************************************

.ShowIconBar_b3

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank17
 BEQ bank17

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR ShowIconBar        \ Call ShowIconBar, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank17

 LDA ASAV               \ Restore the value of A that we stored above

 JMP ShowIconBar        \ Call ShowIconBar, which is already paged into memory,
                        \ and return from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: DrawDashNames_b3
\       Type: Subroutine
\   Category: Dashboard
\    Summary: Call the DrawDashNames routine in ROM bank 3
\
\ ******************************************************************************

.DrawDashNames_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR DrawDashNames      \ Call DrawDashNames, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: ResetScanner_b3
\       Type: Subroutine
\   Category: Dashboard
\    Summary: Call the ResetScanner routine in ROM bank 3
\
\ ******************************************************************************

.ResetScanner_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR ResetScanner       \ Call ResetScanner, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: ResetScreen_b3
\       Type: Subroutine
\   Category: Start and end
\    Summary: Call the ResetScreen routine in ROM bank 3
\
\ ******************************************************************************

.ResetScreen_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR ResetScreen        \ Call ResetScreen, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: UpdateScreen
\       Type: Subroutine
\   Category: PPU
\    Summary: Update the screen by sending data to the PPU, either immediately
\             or during VBlank, depending on whether the screen is visible
\
\ ******************************************************************************

.UpdateScreen

 LDA screenFadedToBlack \ If bit 7 of screenFadedToBlack is clear then the
 BPL SetupFullViewInNMI \ screen is visible and has not been faded to black, so
                        \ we need to send the view to the PPU in the NMI handler
                        \ to avoid corrupting the screen, so jump to
                        \ SetupFullViewInNMI to configure the NMI handler
                        \ accordingly

                        \ Otherwise the screen has been faded to black, so we
                        \ can fall through into SendViewToPPU to send the view
                        \ straight to the PPU without having to restrict
                        \ ourselves to VBlank

\ ******************************************************************************
\
\       Name: SendViewToPPU_b3
\       Type: Subroutine
\   Category: PPU
\    Summary: Call the SendViewToPPU routine in ROM bank 3
\
\ ******************************************************************************

.SendViewToPPU_b3

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR SendViewToPPU      \ Call SendViewToPPU, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SetupFullViewInNMI
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Configure the PPU to send tiles for a full screen (no dashboard)
\             during VBlank
\
\ ******************************************************************************

.SetupFullViewInNMI

 LDA #116               \ Tell the PPU to send nametable entries up to tile
 STA lastNameTile       \ 116 * 8 = 928 (i.e. to the end of tile row 28) in both
 STA lastNameTile+1     \ bitplanes

                        \ Fall through into SetupViewInNMI_b3 to setup the view
                        \ and configure the NMI to send both bitplanes to the
                        \ PPU during VBlank

\ ******************************************************************************
\
\       Name: SetupViewInNMI_b3
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the SetupViewInNMI routine in ROM bank 3
\
\ ******************************************************************************

.SetupViewInNMI_b3

 LDA #%11000000         \ Set A to the bitplane flags to set for the drawing
                        \ bitplane in the call to SetupViewInNMI below:
                        \
                        \   * Bit 2 clear = send tiles up to configured numbers
                        \   * Bit 3 clear = don't clear buffers after sending
                        \   * Bit 4 clear = we've not started sending data yet
                        \   * Bit 5 clear = we have not yet sent all the data
                        \   * Bit 6 set   = send both pattern and nametable data
                        \   * Bit 7 set   = send data to the PPU
                        \
                        \ Bits 0 and 1 are ignored and are always clear

 STA ASAV               \ Store the value of A so we can retrieve it below

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank18
 BEQ bank18

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 LDA ASAV               \ Restore the value of A that we stored above

 JSR SetupViewInNMI     \ Call SetupViewInNMI, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank18

 LDA ASAV               \ Restore the value of A that we stored above

 JMP SetupViewInNMI     \ Call SetupViewInNMI, which is already paged into
                        \ memory, and return from the subroutine using a tail
                        \ call

\ ******************************************************************************
\
\       Name: SendBitplaneToPPU_b3
\       Type: Subroutine
\   Category: PPU
\    Summary: Call the SendBitplaneToPPU routine in ROM bank 3
\
\ ******************************************************************************

.SendBitplaneToPPU_b3

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank19
 BEQ bank19

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR SendBitplaneToPPU  \ Call SendBitplaneToPPU, now that it is paged into
                        \ memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank19

 JMP SendBitplaneToPPU  \ Call SendBitplaneToPPU, which is already paged into
                        \ memory, and return from the subroutine using a tail
                        \ call

\ ******************************************************************************
\
\       Name: UpdateIconBar_b3
\       Type: Subroutine
\   Category: Icon bar
\    Summary: Call the UpdateIconBar routine in ROM bank 3
\
\ ******************************************************************************

.UpdateIconBar_b3

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank20
 BEQ bank20

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR UpdateIconBar      \ Call UpdateIconBar, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank20

 JMP UpdateIconBar      \ Call UpdateIconBar, which is already paged into
                        \ memory, and return from the subroutine using a tail
                        \ call

\ ******************************************************************************
\
\       Name: DrawScreenInNMI_b0
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the DrawScreenInNMI routine in ROM bank 0
\
\ ******************************************************************************

.DrawScreenInNMI_b0

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JSR DrawScreenInNMI    \ Call DrawScreenInNMI, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: SVE_b6
\       Type: Subroutine
\   Category: Save and load
\    Summary: Call the SVE routine in ROM bank 6
\
\ ******************************************************************************

.SVE_b6

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #6                 \ Page ROM bank 6 into memory at &8000
 JSR SetBank

 JSR SVE                \ Call SVE, now that it is paged into memory

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
\       Name: PrintCtrlCode_b0
\       Type: Subroutine
\   Category: Text
\    Summary: Call the PrintCtrlCode routine in ROM bank 0
\
\ ******************************************************************************

.PrintCtrlCode_b0

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JSR PrintCtrlCode      \ Call PrintCtrlCode, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: StartAfterLoad_b0
\       Type: Subroutine
\   Category: Start and end
\    Summary: Call the StartAfterLoad routine in ROM bank 0
\
\ ******************************************************************************

.StartAfterLoad_b0

 LDA currentBank        \ If ROM bank 0 is already paged into memory, jump to
 CMP #0                 \ bank26
 BEQ bank26

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JSR StartAfterLoad     \ Call StartAfterLoad, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank26

 JMP StartAfterLoad     \ Call StartAfterLoad, which is already paged into
                        \ memory, and return from the subroutine using a tail
                        \ call

\ ******************************************************************************
\
\       Name: RemoveFromScanner_b1
\       Type: Subroutine
\   Category: Dashboard
\    Summary: Remove a ship from the scanner
\
\ ******************************************************************************

.RemoveFromScanner_b1

 LDA #0                 \ Zero byte #33 in the current ship's data block at K%,
 LDY #33                \ so it is not shown on the scanner (a non-zero byte #33
 STA (INF),Y            \ represents the ship's number on the scanner, with a
                        \ ship number of zero indicating that the ship is not
                        \ shown on the scanner)

                        \ Fall through into HideFromScanner to hide the scanner
                        \ sprites for this ship and reset byte #33 in the INWK
                        \ workspace

\ ******************************************************************************
\
\       Name: HideFromScanner_b1
\       Type: Subroutine
\   Category: Dashboard
\    Summary: Call the HideFromScanner routine in ROM bank 1
\
\ ******************************************************************************

.HideFromScanner_b1

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #1                 \ Page ROM bank 1 into memory at &8000
 JSR SetBank

 JSR HideFromScanner    \ Call HideFromScanner, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: TT66_b0
\       Type: Subroutine
\   Category: Drawing the screen
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
\       Name: LOIN_b1
\       Type: Subroutine
\   Category: Drawing lines
\    Summary: Call the CLIP routine in ROM bank 1, drawing the clipped line if
\             it fits on-screen
\
\ ******************************************************************************

.LOIN_b1

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
\       Name: ClearScreen_b3
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the ClearScreen routine in ROM bank 3
\
\ ******************************************************************************

.ClearScreen_b3

 LDA currentBank        \ If ROM bank 3 is already paged into memory, jump to
 CMP #3                 \ bank27
 BEQ bank27

 PHA                    \ Otherwise store the current bank number on the stack

 LDA #3                 \ Page ROM bank 3 into memory at &8000
 JSR SetBank

 JSR ClearScreen        \ Call ClearScreen, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

.bank27

 JMP ClearScreen        \ Call ClearScreen, which is already paged into memory,
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
\       Name: UpdateViewWithFade
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Fade the screen to black, if required, hide all sprites and update
\             the view
\
\ ******************************************************************************

.UpdateViewWithFade

 JSR SetScreenForUpdate \ Get the screen ready for updating by hiding all
                        \ sprites, after fading the screen to black if we are
                        \ changing view

                        \ Fall through into UpdateView to update the view

\ ******************************************************************************
\
\       Name: UpdateView_b0
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Call the UpdateView routine in ROM bank 0
\
\ ******************************************************************************

.UpdateView_b0

 LDA currentBank        \ Fetch the number of the ROM bank that is currently
 PHA                    \ paged into memory at &8000 and store it on the stack

 LDA #0                 \ Page ROM bank 0 into memory at &8000
 JSR SetBank

 JSR UpdateView         \ Call UpdateView, now that it is paged into memory

 JMP ResetBank          \ Fetch the previous ROM bank number from the stack and
                        \ page that bank back into memory at &8000, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: UpdateHangarView
\       Type: Subroutine
\   Category: PPU
\    Summary: Update the hangar view on-screen by sending the data to the PPU,
\             either immediately or during VBlank
\
\ ******************************************************************************

.UpdateHangarView

 LDA #0                 \ Page ROM bank 0 into memory at &8000 (this isn't
 JSR SetBank            \ strictly necessarily as this routine gets jumped to
                        \ from the end of the HALL routine in bank 1, which
                        \ itself is only called via HALL_b1, so the latter will
                        \ revert to bank 0 following the RTS below and none of
                        \ the following calls are to bank 0)

 JSR CopyNameBuffer0To1 \ Copy the contents of nametable buffer 0 to nametable
                        \ buffer

 JSR UpdateScreen       \ Update the screen by sending data to the PPU, either
                        \ immediately or during VBlank, depending on whether
                        \ the screen is visible

 LDX #1                 \ Hide bitplane 1, so:
 STX hiddenBitplane     \
                        \   * Colour %01 (1) is the visible colour (cyan)
                        \   * Colour %10 (2) is the hidden colour (black)

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/clyns.asm"

\ ******************************************************************************
\
\       Name: alertColours
\       Type: Variable
\   Category: Status
\    Summary: Colours for the background of the commander image to show the
\             status condition when we are not looking at the space view
\
\ ******************************************************************************

.alertColours

 EQUB &1C               \ Colour for condition Docked (blue-green)

 EQUB &1A               \ Colour for condition Green (green)

 EQUB &28               \ Colour for condition Yellow (orange)

 EQUB &16               \ Colour for condition Red (light red)

 EQUB &06               \ Flash with this colour (dark red) for condition Red

\ ******************************************************************************
\
\       Name: GetStatusCondition
\       Type: Subroutine
\   Category: Status
\    Summary: Calculate our ship's status condition
\
\ ------------------------------------------------------------------------------
\
\ Returns:
\
\   statusCondition     Our ship's status condition:
\
\                         * 0 = Docked
\
\                         * 1 = Green
\
\                         * 2 = Yellow
\
\                         * 3 = Red
\
\   X                   Also contains the status condition
\
\ ******************************************************************************

.GetStatusCondition

 LDX #0                 \ We start with a status condition of 0, which means
                        \ there is nothing to worry about

 LDY QQ12               \ Fetch the docked status from QQ12, and if we are
 BNE cond2              \ docked, jump to cond2 to return 0 ("Docked") as our
                        \ status condition

 INX                    \ We are in space, so increment X to 1 ("Green")

 LDY JUNK               \ Set Y to the number of junk items in our local bubble
                        \ of universe (where junk is asteroids, canisters,
                        \ escape pods and so on)

 LDA FRIN+2,Y           \ The ship slots at FRIN are ordered with the first two
                        \ slots reserved for the planet and sun/space station,
                        \ and then any ships, so if the slot at FRIN+2+Y is not
                        \ empty (i.e. is non-zero), then that means the number
                        \ of non-asteroids in the vicinity is at least 1

 BEQ cond2              \ So if X = 0, there are no ships in the vicinity, so
                        \ jump to cond2 to store 1 ("Green") as our status
                        \ condition

 INX                    \ Otherwise there are non-asteroids in the vicinity, so
                        \ increment X to 2 ("Yellow")

 LDY statusCondition    \ If the previous condition in statusCondition was 3
 CPY #3                 \ ("Red"), then jump to cond3
 BEQ cond3

 LDA ENERGY             \ If our energy levels are 128 or greater, jump to cond2
 BMI cond2              \ to store 2 ("Yellow") as our status condition

.cond1

                        \ If we get here then either our energy levels are less
                        \ than 128, or our previous condition was "Red" and our
                        \ energy levels are less than 160
                        \
                        \ So once our energy levels are low enough to trigger a
                        \ "Red" status, it stays that way until our energy
                        \ levels recover to a higher level

 INX                    \ Increment X to 3 ("Red")

.cond2

 STX statusCondition    \ Store our new status condition in statusCondition

 RTS                    \ Return from the subroutine

.cond3

 LDA ENERGY             \ If our energy levels are less than 160, jump to cond1
 CMP #160               \ to return a "Red" status condition
 BCC cond1

 BCS cond2              \ Jump to cond2 to return a "Yellow" status condition
                        \ (this BCS is effectively a JMP as we just passed
                        \ through a BCC)

\ ******************************************************************************
\
\       Name: SetupDemoUniverse
\       Type: Subroutine
\   Category: Demo
\    Summary: Initialise the local bubble of univers for the demo
\
\ ******************************************************************************

.SetupDemoUniverse

 LDY #12                \ Wait until 12 NMI interrupts have passed (i.e. the
 JSR DELAY              \ next 12 VBlanks)

 LDA #0                 \ Set A = 0
 CLC                    \
 ADC #0                 \ The ADC has no effect, so presumably it was left over
                        \ from a previous version of the code

 STA frameCounter       \ Reset the frame counter to zero

 STA nmiTimer           \ Set the NMI timer to zero
 STA nmiTimerLo
 STA nmiTimerHi

 STA hiddenBitplane     \ Set the hidden, NMI and drawing bitplanes to 0
 STA nmiBitplane
 STA drawingBitplane

 LDA #&FF               \ Set L0307 = &FF ???
 STA L0307

 LDA #&80               \ Set L0308 = &80 ???
 STA L0308

 LDA #&1B               \ Set L0309 = &1B ???
 STA L0309

 LDA #&34               \ Set L030A = &34 ???
 STA L030A

 JSR ResetOptions       \ Reset the game options to their default values

 LDA #0                 \ Set K%+6 = 0 ???
 STA K%+6

 STA K%                 \ Set K% = 0 ???

                        \ Fall through into FixRandomNumbers to set the random
                        \ number seeds to a known state

\ ******************************************************************************
\
\       Name: FixRandomNumbers
\       Type: Subroutine
\   Category: Demo
\    Summary: Fix the random number seeds to a known value so the random numbers
\             generated are always the same when we run the demo
\
\ ******************************************************************************

.FixRandomNumbers

 LDA #&75               \ Set the random number seeds to a known state, so the
 STA RAND               \ demo plays out in the same way every time
 LDA #&0A
 STA RAND+1
 LDA #&2A
 STA RAND+2
 LDX #&E6
 STX RAND+3

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: ResetOptions
\       Type: Subroutine
\   Category: Start and end
\    Summary: Reset the game options to their default values
\
\ ******************************************************************************

.ResetOptions

 LDA #0                 \ Configure the joystick Y-channel to the default
 STA JSTGY              \ direction (i.e. not reversed) by setting JSTGY to 0

 STA disableMusic       \ Configure music to be enabled by default by setting
                        \ disableMusic to 0

 LDA #&FF               \ Configure damping to be enabled by default by setting
 STA DAMP               \ DAMP to &FF

 STA DNOIZ              \ Configure sound to be enabled by default by setting
                        \ DNOIZ to &FF

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: DrawTitleScreen
\       Type: Subroutine
\   Category: Start and end
\    Summary: Draw a sequence of rotating ships on-screen while checking for
\             button presses on the controllers
\
\ ******************************************************************************

.DrawTitleScreen

 JSR FadeToBlack_b3     \ Fade the screen to black over the next four VBlanks

 LDA #0                 \ Set the music to tune 0 (no music)
 JSR ChooseMusic_b6

 JSR HideMostSprites    \ Hide all sprites except for sprite 0 and the icon bar
                        \ pointer

 LDA #&FF               \ Set the old view type in QQ11a to &FF (Segue screen
 STA QQ11a              \ from Title screen to Demo)

 LDA #1                 \ Set scanController2 = 1 so we scan both controllers,
 STA scanController2    \ so the game can be started by pressing a key on either
                        \ controller while the ships are rotating on-screen

 LDA #50                \ Set the NMI timer, which decrements each VBlank, to 50
 STA nmiTimer           \ so it counts down to zero and back up to 50 again

 LDA #0                 \ Set (nmiTimerHi nmiTimerLo) = 0 so we can time how
 STA nmiTimerLo         \ long to show the rotating ships before switching back
 STA nmiTimerHi         \ to the Start screen

.dtit1

 LDY #0                 \ We are about to start running through a list of ships
                        \ to display on the title screen, so set a ship counter
                        \ in Y

.dtit2

 STY L03FC              \ Store the ship counter in L03FC so we can retrieve it
                        \ below

 LDA titleShipType,Y    \ Set A to the ship type of the ship we want to display,
                        \ from the Y-th entry in the titleShipType table

 BEQ dtit1              \ If the ship type is zero then we have already worked
                        \ our way through the list, so jump back to dtit1 to
                        \ start from the beginning of the list again

 TAX                    \ Store the ship type in X

 LDA titleShipDist,Y    \ Set Y to the distance of the ship we want to display,
 TAY                    \ from the Y-th entry in the titleShipDist table

 LDA #6                 \ Call TITLE to draw the ship type in X, starting with
 JSR TITLE              \ it far away, and bringing it to a distance of Y (the
                        \ argument in A is ignored)

 BCS dtit3              \ If a button was pressed while the ship was being shown
                        \ on-screen, TITLE will return with the C flag set, in
                        \ which case jump to dtit3 to stop the music and return
                        \ from the subroutine

 LDY L03FC              \ Restore the ship counter that we stored above and put
 INY                    \ it into Y

 LDA nmiTimerHi         \ If the high byte of (nmiTimerHi nmiTimerLo) is still 0
 CMP #1                 \ then jump back to dtit2 to show the next ship
 BCC dtit2

                        \ If we get here then the NMI timer has run down to the
                        \ point where (nmiTimerHi nmiTimerLo) is >= 256, which
                        \ means we have shown the title screen for at least
                        \ 50 * 256 VBlanks, as each tick of nmiTimerLo happens
                        \ when the nmiTimer has counted down from 50 VBlanks,
                        \ and each tick happens once every VBlank
                        \
                        \ On the PAL NES, VBlank happens 50 times a second, so
                        \ this means the title screen has been showing for 256
                        \ seconds, or about 4 minutes and 16 seconds
                        \
                        \ On the NTSC NES, VBlank happens 60 times a second, so
                        \ this means the title screen has been showing for 213
                        \ seconds, or about 3 minutes and 33 seconds

 LSR scanController2    \ Set scanController2 = 0 so we no longer scan both
                        \ controllers

 JSR ResetMusicAfterNMI \ Wait for the next NMI before resetting the current
                        \ tune to 0 (no tune) and stopping the music

 JSR FadeToBlack_b3     \ Fade the screen to black over the next four VBlanks

 LDA languageIndex      \ Set K% to the index of the currently selected
 STA K%                 \ language, so when we show the Start screen, the
                        \ correct language is highlighted

 LDA #5                 \ Set K%+1 = 5 to use as the value of the third counter
 STA K%+1               \ when deciding how long to wait on the Start screen
                        \ before auto-playing the demo

 JMP ResetToStartScreen \ Reset the stack and the game's variables and show the
                        \ Start screen, returning from the subroutine using a
                        \ tail call

.dtit3

 JSR ResetMusicAfterNMI \ Wait for the next NMI before resetting the current
                        \ tune to 0 (no tune) and stopping the music

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: titleShipType
\       Type: Variable
\   Category: Start and end
\    Summary: The types of ship to show rotating on the title screen
\
\ ******************************************************************************

.titleShipType

 EQUB 11                \ Cobra Mk III
 EQUB 19                \ Krait
 EQUB 20                \ Adder
 EQUB 25                \ Asp Mk II
 EQUB 29                \ Thargoid
 EQUB 21                \ Gecko
 EQUB 18                \ Mamba
 EQUB 27                \ Fer-de-lance
 EQUB 10                \ Transporter
 EQUB  1                \ Missile
 EQUB 17                \ Sidewinder
 EQUB 16                \ Viper

 EQUB 0

\ ******************************************************************************
\
\       Name: titleShipDist
\       Type: Variable
\   Category: Start and end
\    Summary: The distances at which to show the rotating title screen ships
\
\ ******************************************************************************

.titleShipDist

 EQUB 100               \ Cobra Mk III
 EQUB 10                \ Krait
 EQUB 10                \ Adder
 EQUB 30                \ Asp Mk II
 EQUB 180               \ Thargoid
 EQUB 10                \ Gecko
 EQUB 40                \ Mamba
 EQUB 90                \ Fer-de-lance
 EQUB 10                \ Transporter
 EQUB 70                \ Missile
 EQUB 40                \ Sidewinder
 EQUB 10                \ Viper

INCLUDE "library/common/main/subroutine/ze.asm"

\ ******************************************************************************
\
\       Name: UpdateSaveCount
\       Type: Subroutine
\   Category: Save and load
\    Summary: Update the save counter for the current commander
\
\ ------------------------------------------------------------------------------
\
\ Returns:
\
\   A                   A is preserved
\
\ ******************************************************************************

.UpdateSaveCount

 PHA                    \ Store A on the stack so we can retrieve it below

 LDA SVC                \ If bit 7 of SVC is set, then we have already
 BMI scnt1              \ incremented the save counter for the current
                        \ commander, so jump to scnt1 to skip the following and
                        \ leave SVC alone

 CLC                    \ Set A = A + 1, to increment the save counter
 ADC #1

 CMP #100               \ If A < 100, skip the following instruction
 BCC scnt1

 LDA #0                 \ Set A = 0, so the save counter goes from zero to 100
                        \ and around back to zero again

.scnt1

 ORA #%10000000         \ Set bit 7 of A to flag the save counter as increments,
                        \ so the next call to this routine does nothing

 STA SVC                \ Store the updated save counter in SVC

 PLA                    \ Retrieve the value of A we stored on the stack above

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/nlin3.asm"
INCLUDE "library/common/main/subroutine/nlin4.asm"
INCLUDE "library/common/main/subroutine/nlin2.asm"

\ ******************************************************************************
\
\       Name: SetDrawingPlaneTo0
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Set the drawing bitplane to 0
\
\ ******************************************************************************

.SetDrawingPlaneTo0

 LDX #0                 \ Set the drawing bitplane to 0
 JSR SetDrawingBitplane

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: ResetBuffers
\       Type: Subroutine
\   Category: Drawing the screen
\    Summary: Reset the pattern and nametable buffers
\
\ ------------------------------------------------------------------------------
\
\ The pattern buffers are in a continuous block of memory as follows:
\
\   * pattBuffer0 (&6000 to &67FF)
\   * pattBuffer1 (&6800 to &6FFF)
\   * nameBuffer0 (&7000 to &73BF)
\   * attrBuffer0 (&73C0 to &73FF)
\   * nameBuffer1 (&7400 to &77BF)
\   * attrBuffer1 (&77C0 to &77FF)
\
\ This covers &1800 bytes (24 pages of memory), and this routine zeroes the
\ whole lot.
\
\ ******************************************************************************

.ResetBuffers

 LDA #HI(pattBuffer0)   \ Set SC2(1 0) to pattBuffer0, the address of the first
 STA SC2+1              \ of the buffers we want to clear
 LDA #Lo(pattBuffer0)
 STA SC2

 LDY #0                 \ Set Y as a byte counter that we can use as an index
                        \ into each page of memory as we clear them

 LDX #&18               \ We want to zero memory from &6000 to &7800, so set a
                        \ page counter in X to count each page of memory as we
                        \ clear them

 LDA #0                 \ We are going to clear the buffers by filling them with
                        \ zeroes, so set A = 0 so we can poke it into memory

.rbuf1

 STA (SC2),Y            \ Zero the Y-th byte of SC2(1 0)

 INY                    \ Increment the byte counter

 BNE rbuf1              \ Loop back until we have zeroed a full page of memory

 INC SC2+1              \ Increment the high byte of SC2(1 0) so it points to
                        \ the next page in memory

 DEX                    \ Decrement the page counter in X

 BNE rbuf1              \ Loop back until we have zeroed all X pages of memory

 RTS                    \ Return from the subroutine

INCLUDE "library/common/main/subroutine/dornd.asm"
INCLUDE "library/common/main/subroutine/proj.asm"
INCLUDE "library/common/main/subroutine/pls6.asm"

\ ******************************************************************************
\
\       Name: UnpackToRAM
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Unpack compressed image data to RAM
\
\ ------------------------------------------------------------------------------
\
\ This routine unpacks compressed data into RAM. The data is typically nametable
\ or pattern data that is unpacked into the nametable or pattern buffers.
\
\ UnpackToRAM reads packed data from V(1 0) and writes unpacked data to SC(1 0)
\ by fetching bytes one at a time from V(1 0), incrementing V(1 0) after each
\ fetch, and unpacking and writing the data to SC(1 0) as it goes.
\
\ If we fetch byte &xx from V(1 0), then we unpack it as follows:
\
\   * If &xx >= &40, output byte &xx as it is and move on to the next byte
\
\   * If &xx = &x0, output byte &x0 as it is and move on to the next byte
\
\   * If &xx = &3F, stop and return from the subroutine, as we have finished
\
\   * If &xx >= &20, jump to upac6 to do the following:
\
\     * If &xx >= &30, jump to upac7 to output the next &0x bytes from V(1 0) as
\                      they are, incrementing V(1 0) as we go
\
\     * If &xx >= &20, fetch the next byte from V(1 0), increment V(1 0), and
\                      output the fetched byte for &0x bytes
\
\   * If &xx >= &10, jump to upac5 to output &FF for &0x bytes
\
\   * If &xx < &10, output 0 for &0x bytes
\
\ In summary, this is how each byte gets unpacked:
\
\   &00 = unchanged
\   &0x = output 0 for &0x bytes
\   &10 = unchanged
\   &1x = output &FF for &0x bytes
\   &20 = unchanged
\   &2x = output the next byte for &0x bytes
\   &30 = unchanged
\   &3x = output the next &0x bytes unchanged
\   &40 and above = unchanged
\
\ ******************************************************************************

.UnpackToRAM

 LDY #0                 \ We work our way through the packed data at SC(1 0), so
                        \ set an index counter in Y, starting from the first
                        \ data byte at offset zero

.upac1

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDX #0                 \ Set X = 0, so we can use a LDA (V,X) instruction below
                        \ to fetch the next data byte from V(1 0), as the 6502
                        \ doesn't have a LDA (V) instruction

 LDA (V,X)              \ Set A to the byte of packed data at V(1 0), which is
                        \ the next byte of data to unpack
                        \
                        \ As X = 0, this instruction is effectively LDA (V),
                        \ which isn't a valid 6502 instruction on its own

 INC V                  \ Increment V(1 0) to point to the next byte of packed
 BNE upac2              \ data
 INC V+1

.upac2

 CMP #&40               \ If A >= &40, jump to unpac12 to output the data in A
 BCS upac12             \ as it is, and move on to the next byte

                        \ If we get here then we know that the data byte in A is
                        \ of the form &0x, &1x, &2x or &3x

 TAX                    \ Store the packed data byte in X so we can retrieve it
                        \ below

 AND #&0F               \ If the data byte in A is in the format &x0, jump to
 BEQ upac11             \ upac11 to output the data in X as it is, and move on
                        \ to the next byte

 CPX #&3F               \ If the data byte in X is &3F, then this indicates we
 BEQ upac13             \ have reached the end of the packed data, so jump to
                        \ upac13 to return from the subroutine, as we are done

 TXA                    \ Set A back to the unpacked data byte, which we stored
                        \ in X above

 CMP #&20               \ If A >= &20, jump to upac6 to process values of &2x
 BCS upac6              \ and &3x (as we already processed values above &40)

                        \ If we get here then we know that the data byte in A is
                        \ of the form &0x or &1x (and not &x0)

 CMP #&10               \ If A >= &10, set the C flag

 AND #&0F               \ Set X to the lower nibble of A, so it contains the
 TAX                    \ number of zeroes or &FF bytes that we need to output
                        \ when the data byte is &0x or &1x

 BCS upac5              \ If the data byte in A was >= &10, then we know that A
                        \ is of the form &1x, so jump to upac5 to output the
                        \ number of &FF bytes specified in X

                        \ If we get here then we know that A is of the form
                        \ &0x, so we need to output the number of zero bytes
                        \ specified in X

 LDA #0                 \ Set A as the byte to write to SC(1 0), so we output
                        \ zeroes

.upac3

                        \ This loop writes byte A to SC(1 0), X times

 STA (SC),Y             \ Write the byte in A to SC(1 0)

 INY                    \ Increment Y to point to the next data byte

 BNE upac4              \ If Y has now wrapped round to zero, loop back to upac1
                        \ to unpack the next data byte

 INC SC+1               \ Otherwise Y is now zero, so increment the high byte of
                        \ SC(1 0) to point to the next page, so that SC(1 0) + Y
                        \ still points to the next data byte

.upac4

 DEX                    \ Decrement the byte counter in X

 BNE upac3              \ Loop back to upac3 to write the byte in A again, until
                        \ we have written it X times

 JMP upac1              \ Jump back to upac1 to unpack the next byte

.upac5

                        \ If we get here then we know that A is of the form
                        \ &1x, so we need to output the number of &FF bytes
                        \ specified in X

 LDA #&FF               \ Set A as the byte to write to SC(1 0), so we output
                        \ &FF

 BNE upac3              \ Jump to the loop at upac3 to output &FF to SC(1 0),
                        \ X times (this BNE is effectively a JMP as A is never
                        \ zero)

.upac6

                        \ If we get here then we know that the data byte in A is
                        \ of the form &2x or &3x (and not &x0)

 LDX #0                 \ Set X = 0, so we can use a LDA (V,X) instruction below
                        \ to fetch the next data byte from V(1 0), as the 6502
                        \ doesn't have a LDA (V) instruction

 CMP #&30               \ If A >= &30 then jump to upac7 to process bytes in the
 BCS upac7              \ for &3x

                        \ If we get here then we know that the data byte in A is
                        \ of the form &2x (and not &x0)

 AND #&0F               \ Set T to the lower nibble of A, so it contains the
 STA T                  \ number of times that we need to output the byte
                        \ following the &2x data byte

 LDA (V,X)              \ Set A to the byte of packed data at V(1 0), which is
                        \ the next byte of data to unpack, i.e. the byte that we
                        \ need to write X times
                        \
                        \ As X = 0, this instruction is effectively LDA (V),
                        \ which isn't a valid 6502 instruction on its own

 LDX T                  \ Set X to the number of times we need to output the
                        \ byte in A

 INC V                  \ Increment V(1 0) to point to the next data byte (as we
 BNE upac3              \ just read the one after the &2x data byte), and jump
 INC V+1                \ to the loop in upac3 to output the byte in A, X times
 JMP upac3

.upac7

                        \ If we get here then we know that the data byte in A is
                        \ of the form &3x (and not &x0), and we jump here with
                        \ X set to 0

 AND #&0F               \ Set T to the lower nibble of A, so it contains the
 STA T                  \ number of unchanged bytes that we need to output
                        \ following the &3x data byte

.upac8

 LDA (V,X)              \ Set A to the byte of packed data at V(1 0), which is
                        \ the next byte of data to unpack
                        \
                        \ As X = 0, this instruction is effectively LDA (V),
                        \ which isn't a valid 6502 instruction on its own

 INC V                  \ Increment V(1 0) to point to the next data byte (as we
 BNE upac9              \ just read the one after the &2x data byte)
 INC V+1

                        \ We now loop T times, outputting the next data byte on
                        \ each iteration, so we end up writing the next T bytes
                        \ unchanged

.upac9

 STA (SC),Y             \ Write the unpacked data in A to the Y-th byte of
                        \ SC(1 0)

 INY                    \ Increment Y to point to the next data byte

 BNE upac10             \ If Y has now wrapped round to zero, increment the
 INC SC+1               \ high byte of SC(1 0) to point to the next page, so
                        \ that SC(1 0) + Y still points to the next data byte

.upac10

 DEC T                  \ Decrement the loop counter in T

 BNE upac8              \ Loop back until we have copied the next T bytes
                        \ unchanged from V(1 0) to SC(1 0)

 JMP upac1              \ Jump back to upac1 to unpack the next byte

.upac11

 TXA                    \ Set A back to the unpacked data byte, which we stored
                        \ in X before jumping here

.upac12

 STA (SC),Y             \ Write the unpacked data in A to the Y-th byte of
                        \ SC(1 0)

 INY                    \ Increment Y to point to the next data byte

 BNE upac1              \ If Y has now wrapped round to zero, loop back to upac1
                        \ to unpack the next data byte

 INC SC+1               \ Otherwise Y is now zero, so increment the high byte of
 JMP upac1              \ SC(1 0) to point to the next page, so that SC(1 0) + Y
                        \ still points to the next data byte

.upac13

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: UnpackToPPU
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Unpack compressed image data and send it to the PPU
\
\ ------------------------------------------------------------------------------
\
\ This routine unpacks compressed data and sends it straight to the PPU. The
\ data is typically nametable or pattern data that is unpacked into the PPU's
\ nametable or pattern tables.
\
\ The algorithm is described in the UnpackToRAM routine.
\
\ ******************************************************************************

.UnpackToPPU

 LDY #0                 \ We work our way through the packed data at SC(1 0), so
                        \ set an index counter in Y, starting from the first
                        \ data byte at offset zero

.upak1

 LDA (V),Y              \ Set A to the Y-th byte of packed data at V(1 0), which
                        \ is the next byte of data to unpack

 INY                    \ Increment Y to point to the next byte of packed data

 BNE upak2              \ If Y has now wrapped round to zero, increment the
 INC V+1                \ high byte of V(1 0) to point to the next page, so
                        \ that V(1 0) + Y still points to the next data byte

.upak2

 CMP #&40               \ If A >= &40, jump to upak10 to send the data in A
 BCS upak10             \ as it is, and move on to the next byte

 TAX                    \ Store the packed data byte in X so we can retrieve it
                        \ below

 AND #&0F               \ If the data byte in A is in the format &x0, jump to
 BEQ upak9              \ upak9 to send the data in X as it is, and move on
                        \ to the next byte

 CPX #&3F               \ If the data byte in X is &3F, then this indicates we
 BEQ upak11             \ have reached the end of the packed data, so jump to
                        \ upak11 to return from the subroutine, as we are done

 TXA                    \ Set A back to the unpacked data byte, which we stored
                        \ in X above

 CMP #&20               \ If A >= &20, jump to upak5 to process values of &2x
 BCS upak5              \ and &3x (as we already processed values above &40)

                        \ If we get here then we know that the data byte in A is
                        \ of the form &0x or &1x (and not &x0)

 CMP #&10               \ If A >= &10, set the C flag

 AND #&0F               \ Set X to the lower nibble of A, so it contains the
 TAX                    \ number of zeroes or &FF bytes that we need to send
                        \ when the data byte is &0x or &1x


 BCS upak4              \ If the data byte in A was >= &10, then we know that A
                        \ is of the form &1x, so jump to upak4 to send the
                        \ number of &FF bytes specified in X

                        \ If we get here then we know that A is of the form
                        \ &0x, so we need to send the number of zero bytes
                        \ specified in X

 LDA #0                 \ Set A as the byte to write to the PPU, so we send
                        \ zeroes

.upak3

                        \ This loop sends byte A to the PPU, X times

 STA PPU_DATA           \ Send the byte in A to the PPU

 DEX                    \ Decrement the byte counter in X

 BNE upak3              \ Loop back to upak3 to send the byte in A again, until
                        \ we have sent it X times

 JMP upak1              \ Jump back to upak1 to unpack the next byte

.upak4

                        \ If we get here then we know that A is of the form
                        \ &1x, so we need to send the number of &FF bytes
                        \ specified in X

 LDA #&FF               \ Set A as the byte to send to the PPU

 BNE upak3              \ Jump to the loop at upak3 to send &FF to the PPU,
                        \ X times (this BNE is effectively a JMP as A is never
                        \ zero)

.upak5

                        \ If we get here then we know that the data byte in A is
                        \ of the form &2x or &3x (and not &x0)

 CMP #&30               \ If A >= &30 then jump to upak6 to process bytes in the
 BCS upak6              \ for &3x

 AND #&0F               \ Set X to the lower nibble of A, so it contains the
 TAX                    \ number of times that we need to send the byte
                        \ following the &2x data byte

 LDA (V),Y              \ Set A to the Y-th byte of packed data at V(1 0), which
                        \ is the next byte of data to unpack, i.e. the byte that
                        \ we need to write X times

 INY                    \ Increment Y to point to the next byte of packed data

 BNE upak3              \ If Y has now wrapped round to zero, increment the
 INC V+1                \ high byte of V(1 0) to point to the next page, so
 JMP upak3              \ that V(1 0) + Y still points to the next data byte,
                        \ and jump to the loop in upak3 to send the byte in A,
                        \ X times

.upak6

                        \ If we get here then we know that the data byte in A is
                        \ of the form &3x (and not &x0), and we jump here with
                        \ X set to 0

 AND #&0F               \ Set X to the lower nibble of A, so it contains the
 TAX                    \ number of unchanged bytes that we need to send
                        \ following the &3x data byte

.upak7

 LDA (V),Y              \ Set A to the Y-th byte of packed data at V(1 0), which
                        \ is the next byte of data to unpack

 INY                    \ Increment Y to point to the next byte of packed data

 BNE upak8              \ If Y has now wrapped round to zero, increment the
 INC V+1                \ high byte of V(1 0) to point to the next page, so
                        \ that V(1 0) + Y still points to the next data byte

.upak8

 STA PPU_DATA           \ Send the unpacked data in A to the PPU

 DEX                    \ Decrement the byte counter in X

 BNE upak7              \ Loop back to upak7 to send the next byte, until we
                        \ have sent the next X bytes

 JMP upak1              \ Jump back to upak1 to unpack the next byte

.upak9

 TXA                    \ Set A back to the unpacked data byte, which we stored
                        \ in X before jumping here

.upak10

 STA PPU_DATA           \ Send the byte in A to the PPU

 JMP upak1              \ Jump back to upak1 to unpack the next byte

.upak11

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: FAROF2
\       Type: Subroutine
\   Category: Maths (Geometry)
\    Summary: Compare x_hi, y_hi and z_hi with A
\
\ ------------------------------------------------------------------------------
\
\ Calculate the distance from the origin to the point (x, y, z) and compare it
\ with the argument A, clearing the C flag if the distance is < A, or setting
\ the C flag if the distance is >= A.
\
\ Returns:
\
\   C flag              Clear if the distance to (x, y, z) < A
\
\                       Set if the distance to (x, y, z) >= A
\
\ ******************************************************************************

.FAROF2

 STA T                  \ Store the value that we want to compare x, y z with
                        \ in T

 SETUP_PPU_FOR_ICON_BAR \ If the PPU has started drawing the icon bar, configure
                        \ the PPU to use nametable 0 and pattern table 0

 LDA INWK+2             \ If any of x_sign, y_sign or z_sign are non-zero
 ORA INWK+5             \ (ignoring the sign in bit 7), then jump to farr3 to
 ORA INWK+8             \ return the C flag set, to indicate that A is smaller
 ASL A                  \ than x, y, z
 BNE farr3

 LDA INWK+7             \ Set K+2 = z_hi / 2
 LSR A
 STA K+2

 LDA INWK+1             \ Set K = x_hi / 2
 LSR A
 STA K

 LDA INWK+4             \ Set K+1 = y_hi / 2
 LSR A                  \
 STA K+1                \ This also sets A = K+1

                        \ From this point on we are only working with the high
                        \ bytes, so to make things easier to follow, let's just
                        \ refer to x_hi, y_hi and z_hi as x, y and z, so:
                        \
                        \   K   = x / 2
                        \   K+1 = y / 2
                        \   K+2 = z / 2

 CMP K                  \ If A >= K, jump to farr1 to skip the next instruction
 BCS farr1

 LDA K                  \ Set A = K, so A = max(K, K+1)

.farr1

 CMP K+2                \ If A >= K+2, jump to farr2 to skip the next
 BCS farr2              \ instruction

 LDA K+2                \ Set A = K+2, so A = max(A, K+2)
                        \                   = max(K, K+1, K+2)

.farr2

 STA SC                 \ Set SC = A
                        \        = max(K, K+1, K+2)
                        \        = max(x / 2, y / 2, z / 2)
                        \        = max(x, y, z) / 2

 LDA K                  \ Set SC+1 = (K + K+1 + K+2 - SC) / 4
 CLC                    \          = (x/2 + y/2 + z/2 - max(x, y, z) / 2) / 4
 ADC K+1                \          = (x + y + z - max(x, y, z)) / 8
 ADC K+2                \
 SEC                    \ 
 SBC SC
 LSR A
 LSR A
 STA SC+1

 LSR A                  \ Set A = (SC+1 / 4) + SC+1 + SC
 LSR A                  \       = 5/4 * SC+1 + SC
 ADC SC+1               \       = 5 * (x + y + z - max(x, y, z)) / (8 * 4)
 ADC SC                 \          + max(x, y, z) / 2
                        \
                        \ If h is the longest of x, y, z, and a and b are the
                        \ other two sides, then we have:
                        \
                        \   max(x, y, z) = h
                        \
                        \   x + y + z - max(x, y, z) = a + b + h - h
                        \                            = a + b
                        \
                        \ So:
                        \
                        \   A = 5 * (a + b) / (8 * 4) + h / 2
                        \     = 5/32 * a + 5/32 * b + 1/2 * h
                        \
                        \ Presumably this estimates the length of the (x, y, z),
                        \ i.e. |x y z|, in some way, though I don't understand
                        \ how

 CMP T                  \ If A < T, C will be clear, otherwise C will be set
                        \
                        \ So the C flag is clear if |x y z| <  argument A
                        \                  set   if |x y z| >= argument A

 RTS                    \ Return from the subroutine

.farr3

 SEC                    \ Set the C flag to indicate A < x and A < y and A < z

 RTS                    \ Return from the subroutine

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
 LDA DAMP
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
\   Category: Utility routines
\    Summary: Configure the MMC1 mapper and page ROM bank 0 into memory at &8000
\
\ ******************************************************************************

.SetupMMC1

 LDA #%00001110         \ Set the MMC1 Control register (which is mapped to
 STA &9FFF              \ &8000-&9FFF) as follows:
 LSR A                  \
 STA &9FFF              \   * Bit 0 clear, Bit 1 set = Vertical mirroring (which
 LSR A                  \     overrides the horizontal mirroring set in the iNES
 STA &9FFF              \     header)
 LSR A                  \
 STA &9FFF              \   * Bits 2,3 set = PRG ROM bank mode 3 = fix ROM bank
 LSR A                  \     7 at &C000 and switch 16K ROM banks at &8000
 STA &9FFF              \
                        \   * Bit 4 clear = CHR ROM bank mode 0 = switch 8K at
                        \     a time

 LDA #0                 \ Set the MMC1 CHR bank 0 register (which is mapped to
 STA &BFFF              \ &A000-&BFFF) to map CHR-ROM to &0000, though this has
 LSR A                  \ no effect as we have no CHR-ROM (we have CHR-RAM
 STA &BFFF              \ instead, which is always mapped to &6000-&7FFF)
 LSR A
 STA &BFFF
 LSR A
 STA &BFFF
 LSR A
 STA &BFFF

 LDA #0                 \ Set the MMC1 CHR bank 1 register (which is mapped to
 STA &DFFF              \ &C000-&DFFF) to map CHR-ROM to &1000, though this has
 LSR A                  \ no effect as we have no CHR-ROM (we have CHR-RAM
 STA &DFFF              \ instead, which is always mapped to &6000-&7FFF)
 LSR A
 STA &DFFF
 LSR A
 STA &DFFF
 LSR A
 STA &DFFF

 JMP SetBank0           \ Page ROM bank 0 into memory at &8000, returning from
                        \ the subroutine using a tail call

IF _NTSC

 EQUB &F5, &F5, &F5     \ These bytes appear to be unused
 EQUB &F5, &F6, &F6
 EQUB &F6, &F6, &F7
 EQUB &F7, &F7, &F7
 EQUB &F7, &F8, &F8
 EQUB &F8, &F8, &F9
 EQUB &F9, &F9, &F9
 EQUB &F9, &FA, &FA
 EQUB &FA, &FA, &FA
 EQUB &FB, &FB, &FB
 EQUB &FB, &FB, &FC
 EQUB &FC, &FC, &FC
 EQUB &FC, &FD, &FD
 EQUB &FD, &FD, &FD
 EQUB &FD, &FE, &FE
 EQUB &FE, &FE, &FE
 EQUB &FF, &FF, &FF
 EQUB &FF, &FF

ELIF _PAL

 EQUB &FF, &FF, &FF     \ These bytes appear to be unused
 EQUB &FF, &FF, &FF
 EQUB &FF, &FF, &FF
 EQUB &FF, &FF, &FF
 EQUB &FF, &FF, &FF
 EQUB &FF, &FF, &FF
 EQUB &FF, &FF, &FF
 EQUB &FF

ENDIF

\ ******************************************************************************
\
\       Name: lineImage
\       Type: Variable
\   Category: Drawing lines
\    Summary: Image data for the horizontal line, vertical line and block images
\
\ ******************************************************************************

.lineImage

 EQUB &FF, &00, &00, &00, &00, &00, &00, &00
 EQUB &00, &FF, &00, &00, &00, &00, &00, &00
 EQUB &00, &00, &FF, &00, &00, &00, &00, &00
 EQUB &00, &00, &00, &FF, &00, &00, &00, &00
 EQUB &00, &00, &00, &00, &FF, &00, &00, &00
 EQUB &00, &00, &00, &00, &00, &FF, &00, &00
 EQUB &00, &00, &00, &00, &00, &00, &FF, &00
 EQUB &00, &00, &00, &00, &00, &00, &00, &FF
 EQUB &00, &00, &00, &00, &00, &00, &FF, &FF
 EQUB &00, &00, &00, &00, &00, &FF, &FF, &FF
 EQUB &00, &00, &00, &00, &FF, &FF, &FF, &FF
 EQUB &00, &00, &00, &FF, &FF, &FF, &FF, &FF
 EQUB &00, &00, &FF, &FF, &FF, &FF, &FF, &FF
 EQUB &00, &FF, &FF, &FF, &FF, &FF, &FF, &FF
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF
 EQUB &80, &80, &80, &80, &80, &80, &80, &80
 EQUB &40, &40, &40, &40, &40, &40, &40, &40
 EQUB &20, &20, &20, &20, &20, &20, &20, &20
 EQUB &10, &10, &10, &10, &10, &10, &10, &10
 EQUB &08, &08, &08, &08, &08, &08, &08, &08
 EQUB &04, &04, &04, &04, &04, &04, &04, &04
 EQUB &02, &02, &02, &02, &02, &02, &02, &02
 EQUB &01, &01, &01, &01, &01, &01, &01, &01
 EQUB &00, &00, &00, &00, &00, &FF, &FF, &FF
 EQUB &FF, &FF, &FF, &00, &00, &00, &00, &00
 EQUB &00, &00, &00, &00, &00, &C0, &C0, &C0
 EQUB &C0, &C0, &C0, &00, &00, &00, &00, &00
 EQUB &00, &00, &00, &00, &00, &03, &03, &03
 EQUB &03, &03, &03, &00, &00, &00, &00, &00

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

 EQUB &00, &8D, &06     \ These bytes appear to be unused
 EQUB &20, &A9, &4C
 EQUB &00, &C0, &45
 EQUB &4C, &20, &20
 EQUB &20, &20, &20
 EQUB &20, &20, &20
 EQUB &20, &20, &20
 EQUB &20, &20, &20
 EQUB &00, &00, &00
 EQUB &00, &38, &04
 EQUB &01, &07, &9C
 EQUB &2A

ELIF _PAL

 EQUB &FF, &FF, &FF     \ These bytes appear to be unused
 EQUB &FF, &FF, &4C
 EQUB &00, &C0, &45
 EQUB &4C, &20, &20
 EQUB &20, &20, &20
 EQUB &20, &20, &20
 EQUB &20, &20, &20
 EQUB &20, &20, &20
 EQUB &00, &00, &00
 EQUB &00, &38, &04
 EQUB &01, &07, &9C
 EQUB &2A

ENDIF

\ ******************************************************************************
\
\       Name: Vectors
\       Type: Variable
\   Category: Utility routines
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
