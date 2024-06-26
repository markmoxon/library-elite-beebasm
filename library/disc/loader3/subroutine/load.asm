\ ******************************************************************************
\
\       Name: LOAD
\       Type: Subroutine
\   Category: Loader
\    Summary: Load the main docked code, set up various vectors, run a checksum
\             and start the game
\
IF NOT(_ELITE_A_VERSION)
\ ------------------------------------------------------------------------------
\
\ This routine also contains a hidden message from the authors for potential
\ crackers to enjoy:
\
\   Does your mother know you do this?
\
\ I bet this made quite a few people smile back in the day...
\
ENDIF
\ ******************************************************************************

.LOAD

IF NOT(_ELITE_A_VERSION)

 LDX #LO(LTLI)          \ Set (Y X) to point to LTLI ("L.T.CODE")
 LDY #HI(LTLI)

 JSR OSCLI              \ Call OSCLI to run the OS command in LTLI, which loads
                        \ the T.CODE binary (the main docked code) to its load
                        \ address of &11E3

ELIF _ELITE_A_VERSION

 LDX #LO(LTLI)          \ Set (Y X) to point to LTLI ("L.1.D")
 LDY #HI(LTLI)

 JSR OSCLI              \ Call OSCLI to run the OS command in LTLI, which loads
                        \ the 1.D binary (the main docked code) to its load
                        \ address of &11E3

ENDIF

IF NOT(_ELITE_A_VERSION)

 LDA #LO(S%+11)         \ Point BRKV to the fifth entry in the main docked
 STA BRKV               \ code's S% workspace, which contains JMP BRBR1
 LDA #HI(S%+11)
 STA BRKV+1

 LDA #LO(S%+6)          \ Point WRCHV to the third entry in the main docked
 STA WRCHV              \ code's S% workspace, which contains JMP CHPR
 LDA #HI(S%+6)
 STA WRCHV+1

 SEC                    \ Set the C flag so the checksum we calculate in A
                        \ starts with an initial value of 18 (17 plus carry)

 LDY #0                 \ Set Y = 0 to act as a byte pointer

 STY ZP                 \ Set the low byte of ZP(1 0) to 0, so ZP(1 0) always
                        \ points to the start of a page

 LDX #&11               \ Set X = &11, so ZP(1 0) will point to &1100 when we
                        \ stick X in ZP+1 below

 TXA                    \ Set A = &11 = 17, to set the initial value of the
                        \ checksum to 18 (17 plus carry)

.l1

 STX ZP+1               \ Set the high byte of ZP(1 0) to the page number in X

 ADC (ZP),Y             \ Set A = A + the Y-th byte of ZP(1 0)

 DEY                    \ Decrement the byte pointer

 BNE l1                 \ Loop back to add the next byte until we have added the
                        \ whole page

 INX                    \ Increment the page number in X

 CPX #&54               \ Loop back to checksum the next page until we have
 BCC l1                 \ checked up to (but not including) page &54

 CMP &55FF              \ Compare the checksum with the value in &55FF, which is
                        \ in the docked file we just loaded, in the byte before
                        \ the ship hangar blueprints at XX21

IF _REMOVE_CHECKSUMS

 NOP                    \ If we have disabled checksums, then ignore the result
 NOP                    \ of the checksum comparison

ELSE

IF _STH_DISC OR _IB_DISC

 BNE P%                 \ If the checksums don't match then enter an infinite
                        \ loop, which hangs the computer

ELIF _SRAM_DISC

 NOP                    \ The sideways RAM variant ignores the result of the
 NOP                    \ checksum comparison

ENDIF

ENDIF

ENDIF

 JMP S%+3               \ Jump to the second entry in the main docked code's S%
                        \ workspace to start a new game

.LTLI

IF NOT(_ELITE_A_VERSION)

 EQUS "L.T.CODE"        \ This is short for "*LOAD T.CODE"
 EQUB 13

 EQUS "Does your mother know you do this?"

ELIF _ELITE_A_VERSION

 EQUS "L.1.D"           \ This is short for "*LOAD 1.D"
 EQUB 13

ENDIF

