\ ******************************************************************************
\
\       Name: DELT
\       Type: Subroutine
\   Category: Save and load
\    Summary: Catalogue a disc, ask for a filename to delete, and delete the
\             file
\
\ ------------------------------------------------------------------------------
\
\ This routine asks for a disc drive number, and if it is a valid number (0-3)
\ it displays a catalogue of the disc in that drive. It then asks for a filename
\ to delete, updates the OS command at DELI so that when that command is run, it
\ it deletes the correct file, and then it does the deletion.
\
\ Other entry points:
\
\   DELT-1              \ Contains an RTS
\
\ ******************************************************************************

.DELT

 JSR CATS               \ Call CATS to ask for a drive number, catalogue that
                        \ disc and update the catalogue command at CTLI

 BCS SVE                \ If the C flag is set then an invalid drive number was
                        \ entered as part of the catalogue process, so jump to
                        \ SVE to display the disc access menu

 LDA CTLI+1             \ The call to CATS above put the drive number into
 STA DELI+7             \ CTLI+1, so copy the drive number into DELI+7 so that
                        \ the drive number in the "DELETE:0.E.1234567" string
                        \ gets updated (i.e. the number after the colon)

 LDA #9                 \ Print extended token 9 ("{clear bottom of screen}FILE
 JSR DETOK              \ TO DELETE?")

 JSR MT26               \ Call MT26 to fetch a line of text from the keyboard
                        \ to INWK+5, with the text length in Y

 TYA                    \ If no text was entered (Y = 0) then jump to SVE to
 BEQ SVE                \ display the disc access menu

                        \ We now copy the entered filename from INWK to DELI, so
                        \ that it overwrites the filename part of the string,
                        \ i.e. the "E.1234567" part of "DELETE:0.E.1234567"

 LDX #9                 \ Set up a counter in X to count from 9 to 1, so that we
                        \ copy the string starting at INWK+4+1 (i.e. INWK+5) to
                        \ DELI+8+1 (i.e. DELI+9 onwards, or "E.1234567")

.DELL1

 LDA INWK+4,X           \ Copy the X-th byte of INWK+4 to the X-th byte of
 STA DELI+8,X           \ DELI+8

 DEX                    \ Decrement the loop counter

 BNE DELL1              \ Loop back to DELL1 to copy the next character until we
                        \ have copied the whole filename

 LDX #LO(DELI)          \ Set (Y X) to point to the OS command at DELI, which
 LDY #HI(DELI)          \ contains the DFS command for deleting this file

 JSR SCLI2              \ Call SCLI2 to execute the OS command at (Y X), which
                        \ deletes the file, setting the SVN flag while it's
                        \ running to indicate disc access is in progress

 JMP SVE                \ Jump to SVE to display the disc access menu and return
                        \ from the subroutine using a tail call

