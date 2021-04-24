\ ******************************************************************************
\
\       Name: S% (Part 1 of 2)
\       Type: Workspace
\    Address: &0D00 to &0D0F
\   Category: Workspaces
\    Summary: Vector addresses, compass colour and configuration settings
\
\ ------------------------------------------------------------------------------
\
\ Contains addresses that are used by the loader to set up vectors, the current
\ compass colour, and the game's configuration settings.
\
\ ******************************************************************************

.S%

 EQUB &40               \ This gets set to &40 by elite-loader.asm as part of
                        \ the copy protection

.KEYB

 EQUB 0                 \ This flag indicates whether we are currently reading
                        \ from the keyboard using OSRDCH or OSWORD, so the
                        \ keyboard interrupt handler at KEY1 knows whether to
                        \ pass key presses on to the OS
                        \
                        \   * 0 = we are not reading from the keyboard with an
                        \         OS command
                        \
                        \   * &FF = we are currently reading from the keyboard
                        \           with an OS command

 EQUW 0                 \ Gets set to the original value of IRQ1V by
                        \ elite-loader.asm

 EQUW 0                 \ Gets set to the original value of KEYV by
                        \ elite-loader.asm

 EQUW 0                 \ This flag is flipped between 0 and &FF every time the
                        \ interrupt routine at IRQ1 is called, but it is never
                        \ read anywhere, so presumably it isn't actually used

 EQUW TT170             \ The entry point for the main game; once the main code
                        \ has been loaded, decrypted and moved to the right
                        \ place by elite-loader.asm, the game is started by a
                        \ JMP (S%+8) instruction, which jumps to the main entry
                        \ point at TT170 via this location

 EQUW TT26              \ WRCHV is set to point here by elite-loader.asm

 EQUW IRQ1              \ IRQ1V is set to point here by elite-loader.asm

 EQUW BR1               \ BRKV is set to point here by elite-loader.asm

