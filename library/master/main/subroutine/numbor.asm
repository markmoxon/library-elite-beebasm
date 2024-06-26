\ ******************************************************************************
\
\       Name: NUMBOR
\       Type: Subroutine
\   Category: Text
\    Summary: An unused routine that prints a number in hexadecimal
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   A                   The number to print
\
\ ******************************************************************************

.NUMBOR

 PHA                    \ Store A on the stack so we can grab the low nibble
                        \ from it later

 LSR A                  \ Shift A right so that it contains the high nibble
 LSR A                  \ of the original argument
 LSR A
 LSR A

 JSR DIDGIT             \ Call DIDGIT below to print 0-F for the high nibble

 PLA                    \ Restore A from the stack

 AND #%00001111         \ Extract the low nibble and fall through into DIDGIT
                        \ to print 0-F for the low nibble

.DIDGIT

 CMP #10                \ If A >= 10, skip the next three instructions
 BCS P%+7

 ADC #'0'               \ A < 10, so print the number in A as a digit 0-9 and
 JMP CHPR               \ return from the subroutine using a tail call

.DIDGIT2

 ADC #'6'               \ A >= 10, so print the number in A as a digit A-F and
 JMP CHPR               \ return from the subroutine using a tail call

