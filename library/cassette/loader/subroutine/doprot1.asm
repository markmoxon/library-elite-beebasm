\ ******************************************************************************
\
\       Name: doPROT1
\       Type: Subroutine
\   Category: Copy protection
\    Summary: Routine to self-modify the loader code
\
\ ------------------------------------------------------------------------------
\
\ This routine modifies various bits of code in-place as part of the copy
\ protection mechanism. It is called with A = &48 and X = 255.
\
\ ******************************************************************************

.doPROT1

 LDY #&DB               \ Store &EFDB in TRTB%(1 0) to point to the keyboard
 STY TRTB%              \ translation table for OS 0.1 (which we will overwrite
 LDY #&EF               \ with a call to OSBYTE later)
 STY TRTB%+1

 LDY #2                 \ Set the high byte of V219(1 0) to 2
 STY V219+1

 STA PROT1-255,X        \ Poke &48 into PROT1, which changes the instruction
                        \ there to a PHA

 LDY #&18
 STY V219+1,X           \ Set the low byte of V219(1 0) to &18 (as X = 255), so
                        \ V219(1 0) now contains &0218

 RTS                    \ Return from the subroutine
