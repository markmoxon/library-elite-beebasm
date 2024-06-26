\ ******************************************************************************
\
\       Name: ruplaLo
\       Type: Variable
\   Category: Text
\    Summary: Address lookup table for the RUPLA text token table in three
\             different languages (low byte)
\  Deep dive: Multi-language support in NES Elite
\
\ ******************************************************************************

.ruplaLo

 EQUB LO(RUPLA - 1)     \ English

 EQUB LO(RUPLA_DE - 1)  \ German

 EQUB LO(RUPLA_FR - 1)  \ French

 EQUB &43               \ There is no fourth language, so this byte is ignored

