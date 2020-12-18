\ ******************************************************************************
\
\       Name: SETVDU19
\       Type: Subroutine
\   Category: Screen mode
\    Summary: Implement the #SETVDU19 <offset> command (change mode 1 palette)
\
\ ------------------------------------------------------------------------------
\
\ This routine is run when the parasite sends a #SETVDU19 <offset> command. It
\ updates the VNT+3 location in the IRQ1 handler to change the palette that's
\ applied to the top part of the screen (the four-colour mode 1 part). The
\ parameter is the offset within the TVT3 palette block of the desired palette.
\
\ Arguments:
\
\   A                   The offset within the TVT3 table of palettes:
\
\                         * 0 = Yellow, red, cyan palette (space view)
\
\                         * 16 = Yellow, red, white palette (charts)
\
\                         * 32 = Yellow, white, cyan palette (title screen)
\
\                         * 48 = Yellow, magenta, white palette (trading)
\
\ ******************************************************************************

.SETVDU19

 STA VNT3+1             \ Store the new colour in VNT3+1, in the IRQ1 routine,
                        \ which modifies which TVT3 palette block gets applied
                        \ to the mode 1 part of the screen

 JMP PUTBACK            \ Jump to PUTBACK to restore the USOSWRCH handler and
                        \ return from the subroutine using a tail call

