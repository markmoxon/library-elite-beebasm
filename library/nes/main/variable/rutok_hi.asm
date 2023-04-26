\ ******************************************************************************
\
\       Name: RUTOK_HI
\       Type: Variable
\   Category: Text
\    Summary: Address lookup table for the RUTOK text token table in three
\             different languages (high byte)
\
\ ******************************************************************************

.RUTOK_HI

 EQUB HI(RUTOK)         \ English

 EQUB HI(RUTOK_DE)      \ German

 EQUB HI(RUTOK_FR)      \ French

 EQUB &AB               \ There is no fourth language, so this byte is ignored

