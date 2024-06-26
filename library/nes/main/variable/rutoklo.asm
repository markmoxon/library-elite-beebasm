\ ******************************************************************************
\
\       Name: rutokLo
\       Type: Variable
\   Category: Text
\    Summary: Address lookup table for the RUTOK text token table in three
\             different languages (low byte)
\  Deep dive: Multi-language support in NES Elite
\
\ ******************************************************************************

.rutokLo

 EQUB LO(RUTOK)         \ English

 EQUB LO(RUTOK_DE)      \ German

 EQUB LO(RUTOK_FR)      \ French

 EQUB &72               \ There is no fourth language, so this byte is ignored

