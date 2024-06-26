IF _CASSETTE_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION OR _MASTER_VERSION \ Comment
\ ******************************************************************************
\
\       Name: VEC
\       Type: Variable
\   Category: Drawing the screen
\    Summary: The original value of the IRQ1 vector
\
\ ******************************************************************************

ENDIF

.VEC

IF _CASSETTE_VERSION OR _6502SP_VERSION OR _ELITE_A_VERSION \ Minor

 SKIP 2                 \ VEC = &7FFE
                        \
                        \ This gets set to the value of the original IRQ1 vector
                        \ by the loading process

ELIF _DISC_VERSION

IF _STH_DISC OR _IB_DISC

 EQUW &0004             \ VEC = &7FFE
                        \
                        \ This gets set to the value of the original IRQ1 vector
                        \ by the loading process
                        \
                        \ This default value is random workspace noise left over
                        \ from the BBC Micro assembly process; it gets
                        \ overwritten

ELIF _SRAM_DISC

 SKIP 2                 \ VEC = &7FFE
                        \
                        \ This gets set to the value of the original IRQ1 vector
                        \ by the loading process

ENDIF

ELIF _MASTER_VERSION

 EQUW &8888             \ This gets set to the value of the original IRQ1 vector
                        \ by the STARTUP routine

ENDIF

