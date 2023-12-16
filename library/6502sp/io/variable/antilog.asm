\ ******************************************************************************
\
\       Name: antilog
\       Type: Variable
\   Category: Maths (Arithmetic)
\    Summary: Binary antilogarithm table
\
\ ------------------------------------------------------------------------------
\
\ At byte n, the table contains:
\
\   2^((n / 2 + 128) / 16) / 256
\
\ which equals:
\
\   2^(n / 32 + 8) / 256
\
\ ******************************************************************************

.antilog

IF _MATCH_ORIGINAL_BINARIES

 EQUB &01, &01, &01, &01, &01, &01, &01, &01
 EQUB &01, &01, &01, &01, &01, &01, &01, &01
 EQUB &01, &01, &01, &01, &01, &01, &01, &01
 EQUB &01, &01, &01, &01, &01, &01, &01, &01
 EQUB &02, &02, &02, &02, &02, &02, &02, &02
 EQUB &02, &02, &02, &02, &02, &02, &02, &02
 EQUB &02, &02, &02, &03, &03, &03, &03, &03
 EQUB &03, &03, &03, &03, &03, &03, &03, &03
 EQUB &04, &04, &04, &04, &04, &04, &04, &04
 EQUB &04, &04, &04, &05, &05, &05, &05, &05
 EQUB &05, &05, &05, &06, &06, &06, &06, &06
 EQUB &06, &06, &07, &07, &07, &07, &07, &07
 EQUB &08, &08, &08, &08, &08, &08, &09, &09
 EQUB &09, &09, &09, &0A, &0A, &0A, &0A, &0B
 EQUB &0B, &0B, &0B, &0C, &0C, &0C, &0C, &0D
 EQUB &0D, &0D, &0E, &0E, &0E, &0E, &0F, &0F
 EQUB &10, &10, &10, &11, &11, &11, &12, &12
 EQUB &13, &13, &13, &14, &14, &15, &15, &16
 EQUB &16, &17, &17, &18, &18, &19, &19, &1A
 EQUB &1A, &1B, &1C, &1C, &1D, &1D, &1E, &1F
 EQUB &20, &20, &21, &22, &22, &23, &24, &25
 EQUB &26, &26, &27, &28, &29, &2A, &2B, &2C
 EQUB &2D, &2E, &2F, &30, &31, &32, &33, &34
 EQUB &35, &36, &38, &39, &3A, &3B, &3D, &3E
 EQUB &40, &41, &42, &44, &45, &47, &48, &4A
 EQUB &4C, &4D, &4F, &51, &52, &54, &56, &58
 EQUB &5A, &5C, &5E, &60, &62, &64, &67, &69
 EQUB &6B, &6D, &70, &72, &75, &77, &7A, &7D
 EQUB &80, &82, &85, &88, &8B, &8E, &91, &94
 EQUB &98, &9B, &9E, &A2, &A5, &A9, &AD, &B1
 EQUB &B5, &B8, &BD, &C1, &C5, &C9, &CE, &D2
 EQUB &D7, &DB, &E0, &E5, &EA, &EF, &F5, &FA

ELSE

 FOR I%, 0, 255

  EQUB INT(2^((I% / 2 + 128) / 16) + 0.5) DIV 256

 NEXT

ENDIF

