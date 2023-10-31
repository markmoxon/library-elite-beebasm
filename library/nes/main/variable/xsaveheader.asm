\ ******************************************************************************
\
\       Name: xSaveHeader
\       Type: Variable
\   Category: Save and load
\    Summary: The text column for the save and load headers for each language
\
\ ******************************************************************************

.xSaveHeader

 EQUB 8                 \ English

 EQUB 4                 \ German

 EQUB 4                 \ French

 EQUB 5                 \ There is no fourth language, so this byte is ignored
