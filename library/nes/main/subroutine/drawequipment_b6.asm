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

