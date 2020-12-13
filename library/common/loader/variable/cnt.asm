\ ******************************************************************************
\
\       Name: CNT
\       Type: Variable
\   Category: Drawing planets
\    Summary: A counter for use in drawing Saturn's planetary body
\
\ ------------------------------------------------------------------------------
\
\ Defines the number of iterations of the PLL1 loop, which draws the planet part
\ of the loading screen's Saturn.
\
\ ******************************************************************************

.CNT

IF _CASSETTE_VERSION

 EQUW &0500             \ The number of iterations of the PLL1 loop (1280)

ELIF _6502SP_VERSION

 EQUW &0300             \ The number of iterations of the PLL1 loop (768)

ENDIF
