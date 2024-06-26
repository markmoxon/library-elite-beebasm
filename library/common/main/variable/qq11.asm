.QQ11

 SKIP 1                 \ The type of the current view:
                        \
                        \   0   = Space view
                        \   1   = Title screen
                        \         Get commander name ("@", save/load commander)
                        \         In-system jump just arrived ("J")
IF _CASSETTE_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION OR _6502SP_VERSION OR _MASTER_VERSION \ Comment
                        \         Data on System screen (red key f6)
ELIF _ELECTRON_VERSION
                        \         Data on System screen (FUNC-7)
ENDIF
IF _CASSETTE_VERSION \ Platform: The cassette and Electron versions reuse view type 1 for the Buy Cargo screen and (for the cassette version) arrival from a mis-jump
                        \         Buy Cargo screen (red key f1)
                        \         Mis-jump just arrived (witchspace)
ELIF _ELECTRON_VERSION
                        \         Buy Cargo screen (FUNC-2)
ELIF _DISC_VERSION OR _ELITE_A_VERSION OR _6502SP_VERSION OR _MASTER_VERSION
                        \   2   = Buy Cargo screen (red key f1)
                        \   3   = Mis-jump just arrived (witchspace)
ENDIF
IF _CASSETTE_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION OR _6502SP_VERSION OR _MASTER_VERSION \ Comment
                        \   4   = Sell Cargo screen (red key f2)
                        \   6   = Death screen
                        \   8   = Status Mode screen (red key f8)
                        \         Inventory screen (red key f9)
ELIF _ELECTRON_VERSION
                        \   4   = Sell Cargo screen (FUNC-3)
                        \   6   = Death screen
                        \   8   = Status Mode screen (FUNC-9)
                        \         Inventory screen (FUNC-0)
ENDIF
IF _MASTER_VERSION \ Platform: The Master version has a unique view type for the title screen (13)
                        \   13  = Rotating ship view (title or mission screen)
ENDIF
IF _CASSETTE_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION OR _6502SP_VERSION OR _MASTER_VERSION \ Comment
                        \   16  = Market Price screen (red key f7)
                        \   32  = Equip Ship screen (red key f3)
                        \   64  = Long-range Chart (red key f4)
                        \   128 = Short-range Chart (red key f5)
ELIF _ELECTRON_VERSION
                        \   16  = Market Price screen (FUNC-8)
                        \   32  = Equip Ship screen (FUNC-4)
                        \   64  = Long-range Chart (FUNC-5)
                        \   128 = Short-range Chart (FUNC-6)
ENDIF
IF _6502SP_VERSION OR _DISC_VERSION OR _ELITE_A_VERSION OR _MASTER_VERSION \ Platform: In the enhanced versions, the launch view has its own QQ11 view type, 255
                        \   255 = Launch view
ENDIF
                        \
                        \ This value is typically set by calling routine TT66

