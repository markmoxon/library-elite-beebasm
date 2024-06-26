\ ******************************************************************************
\
\       Name: setzp
\       Type: Subroutine
\   Category: Utility routines
\    Summary: Copy the top part of zero page (&0090 to &00FF) into the buffer at
\             &3000
\
\ ******************************************************************************

.setzp

IF _COMPACT

 JSR NMICLAIM           \ Claim the NMI workspace (&00A0 to &00A7) from the MOS
                        \ so the game can use it

ENDIF

 LDA #%00001111         \ Set bits 1 and 2 of the Access Control Register at
 STA VIA+&34            \ SHEILA &34 to switch screen memory into &3000-&7FFF

 LDX #&90               \ We want to save zero page from &0090 and up, so set an
                        \ index in X, starting from &90

.sz1

 LDA ZP,X               \ Copy the X-th byte of ZP to the X-th byte of &3000
 STA &3000,X

 INX                    \ Increment the loop counter

 BNE sz1                \ Loop back until we have copied the last byte of zero
                        \ page

 LDA #%00001001         \ Clear bits 1 and 2 of the Access Control Register at
 STA VIA+&34            \ SHEILA &34 to switch main memory back into &3000-&7FFF

 RTS                    \ Return from the subroutine

