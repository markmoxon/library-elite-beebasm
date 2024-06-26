\ ******************************************************************************
\
\       Name: lineImage
\       Type: Variable
\   Category: Drawing lines
\    Summary: Image data for the horizontal line, vertical line and block images
\  Deep dive: Drawing lines in the NES version
\
\ ------------------------------------------------------------------------------
\
\ You can view the tiles that make up the line images here:
\
\ https://elite.bbcelite.com/images/source/nes/lineImage_ram.png
\
\ ******************************************************************************

.lineImage

 EQUB &FF, &00, &00, &00, &00, &00, &00, &00
 EQUB &00, &FF, &00, &00, &00, &00, &00, &00
 EQUB &00, &00, &FF, &00, &00, &00, &00, &00
 EQUB &00, &00, &00, &FF, &00, &00, &00, &00
 EQUB &00, &00, &00, &00, &FF, &00, &00, &00
 EQUB &00, &00, &00, &00, &00, &FF, &00, &00
 EQUB &00, &00, &00, &00, &00, &00, &FF, &00
 EQUB &00, &00, &00, &00, &00, &00, &00, &FF
 EQUB &00, &00, &00, &00, &00, &00, &FF, &FF
 EQUB &00, &00, &00, &00, &00, &FF, &FF, &FF
 EQUB &00, &00, &00, &00, &FF, &FF, &FF, &FF
 EQUB &00, &00, &00, &FF, &FF, &FF, &FF, &FF
 EQUB &00, &00, &FF, &FF, &FF, &FF, &FF, &FF
 EQUB &00, &FF, &FF, &FF, &FF, &FF, &FF, &FF
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF
 EQUB &80, &80, &80, &80, &80, &80, &80, &80
 EQUB &40, &40, &40, &40, &40, &40, &40, &40
 EQUB &20, &20, &20, &20, &20, &20, &20, &20
 EQUB &10, &10, &10, &10, &10, &10, &10, &10
 EQUB &08, &08, &08, &08, &08, &08, &08, &08
 EQUB &04, &04, &04, &04, &04, &04, &04, &04
 EQUB &02, &02, &02, &02, &02, &02, &02, &02
 EQUB &01, &01, &01, &01, &01, &01, &01, &01
 EQUB &00, &00, &00, &00, &00, &FF, &FF, &FF
 EQUB &FF, &FF, &FF, &00, &00, &00, &00, &00
 EQUB &00, &00, &00, &00, &00, &C0, &C0, &C0
 EQUB &C0, &C0, &C0, &00, &00, &00, &00, &00
 EQUB &00, &00, &00, &00, &00, &03, &03, &03
 EQUB &03, &03, &03, &00, &00, &00, &00, &00

