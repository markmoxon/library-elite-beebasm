\ ******************************************************************************
\
\       Name: SCALEX
\       Type: Subroutine
\   Category: Maths (Geometry)
\    Summary: Scale the x-coordinate in A
\
\ ------------------------------------------------------------------------------
\
\ This routine (and the related SCALEY and SCALEY2 routines) are called from
\ various places in the code to scale the value in A. This scaling can be
\ changed by changing these routines (for example, by changing an RTS to an LSR
\ A). This code is left over from the conversion to other platforms, where
\ the scale factor might need to be different.
\
\ ******************************************************************************

.SCALEX

 RTS                    \ Return from the subroutine

