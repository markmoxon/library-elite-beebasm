.XX14

IF _CASSETTE_VERSION OR _DISC_VERSION OR _6502SP_VERSION \ Platform

 SKIP 1                 \ This byte appears to be unused

ELIF _MASTER_VERSION

 SKIP 1                 \ The pointer to the current position in the ship line
                        \ heap as we work our way through the new ship's edges
                        \ (and the corresponding old ship's edges) when drawing
                        \ the ship in the main ship-drawing routine at LL9

 SKIP 1                 \ The size of the existing ship line heap for the ship
                        \ we are drawing in LL9, i.e. the number of lines in the
                        \ old ship that is currently shown on-screen and which
                        \ we need to erase

ENDIF

