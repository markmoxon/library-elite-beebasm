.YSAV2

IF _CASSETTE_VERSION OR _ELECTRON_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION \ Comment

 SKIP 1                 \ Temporary storage, used for storing the value of the Y
                        \ register in the TT26 routine

ELIF _6502SP_VERSION OR _MASTER_VERSION

 SKIP 1                 \ This byte appears to be unused

ENDIF

