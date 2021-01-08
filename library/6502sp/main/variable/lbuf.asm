\ ******************************************************************************
\
\       Name: LBUF
\       Type: Variable
\   Category: Drawing lines
\    Summary: The multi-segment line buffer used by LOIN
\
\ ******************************************************************************

.LBUF

IF _MATCH_EXTRACTED_BINARIES

 IF _SNG45
  INCBIN "versions/6502sp/extracted/workspaces-SNG45/ELTB-LBUF.bin"
 ELIF _SOURCE_DISC
  INCBIN "versions/6502sp/extracted/workspaces/ELTB-LBUF.bin"
 ENDIF

ELSE

 SKIP &100

ENDIF

