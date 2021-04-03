\ ******************************************************************************
\
\       Name: DKS3
\       Type: Subroutine
\   Category: Keyboard
\    Summary: Toggle a configuration setting and emit a beep
\
\ ------------------------------------------------------------------------------
\
\ This is called when the game is paused and a key is pressed that changes the
\ game's configuration.
\
\ Specifically, this routine toggles the configuration settings for the
\ following keys:
\
IF _CASSETTE_VERSION OR _DISC_VERSION OR _6502SP_VERSION \ Comment
\   * CAPS LOCK toggles keyboard flight damping (&40)
\   * A toggles keyboard auto-recentre (&41)
\   * X toggles author names on start-up screen (&42)
\   * F toggles flashing console bars (&43)
\   * Y toggles reverse joystick Y channel (&44)
\   * J toggles reverse both joystick channels (&45)
\   * K toggles keyboard and joystick (&46)
\
\ The numbers in brackets are the internal key numbers (see p.142 of the
\ Advanced User Guide for a list of internal key numbers). We pass the key that
\ has been pressed in X, and the configuration option to check it against in Y,
\ so this routine is typically called in a loop that loops through the various
\ configuration options.
ELIF _MASTER_VERSION
\   * CAPS LOCK toggles keyboard flight damping (0)
\   * A toggles keyboard auto-recentre (1)
\   * X toggles author names on start-up screen (2)
\   * F toggles flashing console bars (3)
\   * Y toggles reverse joystick Y channel (4)
\   * J toggles reverse both joystick channels (5)
\   * K toggles keyboard and joystick (6)
\
\ The numbers in brackets are the configuration options that we pass in Y. We
\ pass the ASCII code of the key that has been pressed in X, and the option to
\ check it against in Y, so this routine is typically called in a loop that
\ loops through the various configuration option.
ENDIF
\
\ Arguments:
\
IF _CASSETTE_VERSION OR _DISC_VERSION OR _6502SP_VERSION \ Comment
\   X                   The internal number of the key that's been pressed
\
\   Y                   The internal number of the configuration key to check
\                       against, from the list above (i.e. Y must be from &40 to
\                       &46)
ELIF _MASTER_VERSION
\   X                   The ASCII code of the key that's been pressed
\
\   Y                   The number of the configuration option to check against
\                       from the list above (i.e. Y must be from 0 to 6)
ENDIF
\
\ ******************************************************************************

.DKS3

IF _CASSETTE_VERSION OR _DISC_VERSION OR _6502SP_VERSION \ Platform

 STY T                  \ Store the configuration key argument in T

 CPX T                  \ If X <> Y, jump to Dk3 to return from the subroutine
 BNE Dk3

ELIF _MASTER_VERSION

 TXA                    \ Copy the ASCII code of the key that has been pressed
                        \ into A

 CMP CKEYS,Y            \ If the pressed key doesn't match the configuration key
 BNE Dk3                \ for option Y (as listed in the CKEYS table), then jump
                        \ to Dk3 to return from the subroutine

ENDIF

IF _CASSETTE_VERSION OR _DISC_VERSION OR _6502SP_VERSION \ Advanced: When toggling a configuration option in the Master version, we get two beeps when we turn the option on (which sounds like one long beep) and one beep when we turn it off (which sounds like a short beep), whereas the other versions beep when we turn it on and remain silent when we turn it off

                        \ We have a match between X and Y, so now to toggle
                        \ the relevant configuration byte. CAPS LOCK has a key
                        \ value of &40 and has its configuration byte at
                        \ location DAMP, A has a value of &41 and has its byte
                        \ at location DJD, which is DAMP+1, and so on. So we
                        \ can toggle the configuration byte by changing the
                        \ byte at DAMP + (X - &40), or to put it in indexing
                        \ terms, DAMP-&40,X. It's no coincidence that the
                        \ game's configuration bytes are set up in this order
                        \ and with these keys (and this is also why the sound
                        \ on/off keys are dealt with elsewhere, as the internal
                        \ key for S and Q are &51 and &10, which don't fit
                        \ nicely into this approach)

 LDA DAMP-&40,X         \ Fetch the byte from DAMP + (X - &40), invert it and
 EOR #&FF               \ put it back (0 means no and &FF means yes in the
 STA DAMP-&40,X         \ configuration bytes, so this toggles the setting)

ELIF _MASTER_VERSION

 LDA DAMP,Y             \ The configuration keys listed in CKEYS correspond to
 EOR #&FF               \ the configuration option settings from DAMP onwards,
 STA DAMP,Y             \ so to toggle a setting, we fetch the existing byte
                        \ from DAMP+Y, invert it and put it back (0 means no
                        \ and &FF means yes in the configuration bytes, so
                        \ this toggles the setting)

 BPL P%+5               \ If the result has a clear bit 7 (i.e. we just turned
                        \ the option off), skip the following instruction

 JSR BELL               \ We just turned the option on, so make a standard
                        \ system beep, so in all we make two beeps

ENDIF

 JSR BELL               \ Make a beep sound so we know something has happened

IF _CASSETTE_VERSION OR _DISC_VERSION OR _6502SP_VERSION \ Platform

 JSR DELAY              \ Wait for Y vertical syncs (Y is between 64 and 70, so
                        \ this is always a bit longer than a second)

ELIF _MASTER_VERSION

 TYA                    \ Store Y and A on the stack so we can retrieve them
 PHA                    \ below

 LDY #20                \ Wait for 20 vertical syncs (20/50 = 0.4 seconds)
 JSR DELAY

ENDIF

IF _CASSETTE_VERSION OR _DISC_VERSION OR _6502SP_VERSION \ Platform

 LDY T                  \ Restore the configuration key argument into Y

ELIF _MASTER_VERSION

 PLA                    \ Restore A and Y from the stack
 TAY

ENDIF

.Dk3

 RTS                    \ Return from the subroutine

