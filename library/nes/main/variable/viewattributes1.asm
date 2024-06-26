\ ******************************************************************************
\
\       Name: viewAttributes1
\       Type: Variable
\   Category: Drawing the screen
\    Summary: Packed view attribute data for attribute set 1
\
\ ------------------------------------------------------------------------------
\
\ When unpacked, the PPU attributes for this view's screen are as follows:
\
\   3F 0F 0F 0F 0F 0F 0F 0F
\   33 00 00 00 00 00 00 00
\   33 00 00 00 00 00 00 00
\   33 00 00 00 00 00 00 00
\   33 00 00 00 00 00 00 00
\   FF FF AF AF AF AF AF AF
\   77 DD AA AA AA AA AA 5A
\   07 0D 0F 0F 0F 0F 0E 05
\
\ ******************************************************************************

.viewAttributes1

 EQUB &31, &3F, &27, &0F, &21, &33, &07, &21
 EQUB &33, &07, &21, &33, &07, &21, &33, &07
 EQUB &12, &26, &AF, &77, &DD, &25, &AA, &5A
 EQUB &32, &07, &0D, &24, &0F, &32, &0E, &05
 EQUB &3F

