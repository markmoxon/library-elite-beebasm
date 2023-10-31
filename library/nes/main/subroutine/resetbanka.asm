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
