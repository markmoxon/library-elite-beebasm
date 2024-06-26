\ ******************************************************************************
\
\       Name: SetupMMC1
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Configure the MMC1 mapper and page ROM bank 0 into memory at &8000
\  Deep dive: Splitting NES Elite across multiple ROM banks
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
 STA &9FFF              \   * Bits 2,3 set = PRG-ROM bank mode 3 = fix ROM bank
 LSR A                  \     7 at &C000 and switch 16K ROM banks at &8000
 STA &9FFF              \
                        \   * Bit 4 clear = CHR-ROM bank mode 0 = switch 8K at
                        \     a time

 LDA #0                 \ Set the MMC1 CHR bank 0 register (which is mapped to
 STA &BFFF              \ &A000-&BFFF) to map the first 4K of CHR-RAM to &0000
 LSR A                  \ in the PPU, so pattern table 0 is writable RAM
 STA &BFFF
 LSR A
 STA &BFFF
 LSR A
 STA &BFFF
 LSR A
 STA &BFFF

 LDA #0                 \ Set the MMC1 CHR bank 1 register (which is mapped to
 STA &DFFF              \ &C000-&DFFF) to map the second 4K of CHR-RAM to &1000
 LSR A                  \ in the PPU, so pattern table 1 is writable RAM
 STA &DFFF
 LSR A
 STA &DFFF
 LSR A
 STA &DFFF
 LSR A
 STA &DFFF

 JMP SetBank0           \ Page ROM bank 0 into memory at &8000, returning from
                        \ the subroutine using a tail call

