\ ******************************************************************************
\
\       Name: do_BYTEV
\       Type: Subroutine
\   Category: Loader
\    Summary: AJD
\
\ ******************************************************************************

 \ trap BYTEV

.do_BYTEV

 CMP #&8F \ ROM service request
 BNE old_BYTEV
 CPX #&F \ vector claim?
 BNE old_BYTEV
 JSR old_BYTEV

