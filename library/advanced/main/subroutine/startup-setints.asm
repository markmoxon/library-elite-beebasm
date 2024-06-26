\ ******************************************************************************
\
IF _6502SP_VERSION \ Comment
\       Name: STARTUP
ELIF _MASTER_VERSION
\       Name: SETINTS
ENDIF
\       Type: Subroutine
\   Category: Loader
IF _6502SP_VERSION \ Comment
\    Summary: Set the various vectors, interrupts and timers, and terminate the
\             loading process so the vector handlers can take over
ELIF _MASTER_VERSION
\    Summary: Set the various vectors, interrupts and timers
ENDIF
\
\ ******************************************************************************

IF _6502SP_VERSION \ Tube

.STARTUP

 LDA RDCHV              \ Store the current RDCHV vector in newosrdch(2 1),
 STA newosrdch+1        \ which modifies the address portion of the JSR &FFFF
 LDA RDCHV+1            \ instruction at the start of the newosrdch routine and
 STA newosrdch+2        \ changes it to a JSR to the existing RDCHV address

 LDA #LO(newosrdch)     \ Disable interrupts and set WRCHV to newosrdch, so
 SEI                    \ calls to OSRDCH are now handled by newosrdch, which
 STA RDCHV              \ lets us implement all our custom OSRDCH commands
 LDA #HI(newosrdch)
 STA RDCHV+1

ELIF _MASTER_VERSION

.SETINTS

 SEI                    \ Disable interrupts

ENDIF

 LDA #%00111001         \ Set 6522 System VIA interrupt enable register IER
 STA VIA+&4E            \ (SHEILA &4E) bits 0 and 3-5 (i.e. disable the Timer1,
                        \ CB1, CB2 and CA2 interrupts from the System VIA)

IF _6502SP_VERSION \ 6502SP: The Executive version support speech via the Watford Electronics Beeb Speech Synthesiser, which attaches to the user port, so unlike the other versions, the loader doesn't disable the 6522 User VIA

IF _SNG45 OR _SOURCE_DISC

 LDA #%01111111         \ Set 6522 User VIA interrupt enable register IER
 STA &FE6E              \ (SHEILA &6E) bits 0-7 (i.e. disable all hardware
                        \ interrupts from the User VIA)

ELIF _EXECUTIVE

 LDA #%01111111         \ At this point, the other 6502SP versions set the 6522
                        \ User VIA interrupt enable register IER to this value
                        \ to disable all hardware interrupts from the User VIA,
                        \ but the Executive version is missing the STA &FE6E
                        \ instruction, so it doesn't disable all the interrupts.
                        \ This is because the Watford Electronics Beeb Speech
                        \ Synthesiser that the Executive version supports plugs
                        \ into the user port, which is controlled by the 6522
                        \ User VIA, so this ensures we don't disable the speech
                        \ synthesiser if one is fitted

ENDIF

ELIF _MASTER_VERSION

 LDA #%01111111         \ Set 6522 User VIA interrupt enable register IER
 STA &FE6E              \ (SHEILA &6E) bits 0-7 (i.e. disable all hardware
                        \ interrupts from the User VIA)

ENDIF

 LDA IRQ1V              \ Store the current IRQ1V vector in VEC, so VEC(1 0) now
 STA VEC                \ contains the original address of the IRQ1 handler
 LDA IRQ1V+1
 STA VEC+1

 LDA #LO(IRQ1)          \ Set the IRQ1V vector to IRQ1, so IRQ1 is now the
 STA IRQ1V              \ interrupt handler
 LDA #HI(IRQ1)
 STA IRQ1V+1

IF _6502SP_VERSION \ Minor

 LDA #VSCAN             \ Set 6522 System VIA T1C-L timer 1 high-order counter
 STA VIA+&45            \ (SHEILA &45) to VSCAN (57) to start the T1 counter
                        \ counting down from 14592 at a rate of 1 MHz (this is
                        \ a different value to the main game code and to the
                        \ loader's IRQ1 routine in the cassette version)

ELIF _MASTER_VERSION

 LDA VSCAN              \ Set 6522 System VIA T1C-L timer 1 high-order counter
 STA VIA+&45            \ (SHEILA &45) to the contents of VSCAN (57) to start
                        \ the T1 counter counting down from 14592 at a rate of
                        \ 1 MHz

ENDIF

 CLI                    \ Enable interrupts again

IF _6502SP_VERSION \ Tube

.NOINT

 LDA WORDV              \ Store the current WORDV vector in notours(2 1)
 STA notours+1
 LDA WORDV+1
 STA notours+2

 LDA #LO(NWOSWD)        \ Disable interrupts and set WORDV to NWOSWD, so calls
 SEI                    \ to OSWORD are now handled by NWOSWD, which lets us
 STA WORDV              \ implement all our custom OSWORD commands
 LDA #HI(NWOSWD)
 STA WORDV+1

 CLI                    \ Enable interrupts again

ELIF _MASTER_VERSION

 RTS                    \ Return from the subroutine

ENDIF

IF _6502SP_VERSION \ 6502SP: The 6502SP version implements a hook that enables you to add arbitrary code to the start-up process. The code needs to be inserted at location &0B00 in the I/O processor, and it needs to start with the characters "TINA"

 LDA #&FF               \ Set the text and graphics colour to cyan
 STA COL

 LDA TINA               \ If the contents of locations TINA to TINA+3 are "TINA"
 CMP #'T'               \ then keep going, otherwise jump to PUTBACK to point
 BNE PUTBACK            \ WRCHV to USOSWRCH, and then end the program, as from
 LDA TINA+1             \ now on the handlers pointed to by the vectors will
 CMP #'I'               \ handle everything
 BNE PUTBACK
 LDA TINA+2
 CMP #'N'
 BNE PUTBACK
 LDA TINA+3
 CMP #'A'
 BNE PUTBACK

 JSR TINA+4             \ TINA to TINA+3 contains the string "TINA", so call the
                        \ subroutine at TINA+4
                        \
                        \ This allows us to add a code hook into the start-up
                        \ process by populating the TINW workspace at &0B00 with
                        \ "TINA" followed by the code for a subroutine, and it
                        \ will be called just before the setup code terminates
                        \ on the I/O processor

                        \ Fall through into PUTBACK to point WRCHV to USOSWRCH,
                        \ and then end the program, as from now on the handlers
                        \ pointed to by the vectors will handle everything

ENDIF

