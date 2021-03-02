\ ******************************************************************************
\
\       Name: HATB
\       Type: Variable
\   Category: Ship hanger
\    Summary: Ship hanger group table
\
\ ------------------------------------------------------------------------------
\
\ This table contains groups of ships to show in the ship hanger. A group of
\ ships is shown half the time (the other half shows a solo ship), and each of
\ the four groups is equally likely.
\
\ The bytes for each ship in the group contain the following information:
\
\   Byte #0             Non-zero = Ship type to draw
\                       0        = don't draw anything
\
\   Byte #1             Bits 0-7 = Ship's x_hi
\                       Bit 0    = Ship's z_hi (1 if clear, or 2 if set)
\
\   Byte #2             Bits 0-7 = Ship's z_lo
\                       Bit 0    = Ship's x_sign
\
\ Ths ship's y-coordinate is calculated in the has1 routine from the size of
\ its targetable area. Ships of type 0 are not shown.
\
IF _DISC_DOCKED \ Comment
\ Note that ship numbers are for the ship hanger blueprints at XX21 in the
\ docked code, rather than the full set of ships in the flight code. They are:
\
\   1 = Cargo canister
\   2 = Shuttle
\   3 = Transporter
\   4 = Cobra Mk III
\   5 = Python
\   6 = Viper
\   7 = Krait
\   8 = Constrictor
\
ENDIF
\ ******************************************************************************

.HATB

                        \ Hanger group for X = 0
                        \
                        \ Shuttle (left) and Transporter (right)

IF _DISC_DOCKED \ Platform
 EQUB 2                 \ Ship type in the hanger = 2 = Shuttle
ELIF _6502SP_VERSION
 EQUB 9                 \ Ship type = 9 = Shuttle
ENDIF
 EQUB %01010100         \ x_hi = %01010100 = 84, z_hi   = 1     -> x = -84
 EQUB %00111011         \ z_lo = %00111011 = 59, x_sign = 1        z = +315

IF _DISC_DOCKED \ Platform
 EQUB 3                 \ Ship type in the hanger = 3 = Transporter
ELIF _6502SP_VERSION
 EQUB 10                \ Ship type = 10 = Transporter
ENDIF
 EQUB %10000010         \ x_hi = %10000010 = 130, z_hi   = 1    -> x = +130
 EQUB %10110000         \ z_lo = %10110000 = 176, x_sign = 0       z = +432

 EQUB 0                 \ No third ship
 EQUB 0
 EQUB 0

                        \ Hanger group for X = 9
                        \
                        \ Three cargo canisters (left, far right and forward,
                        \ right)

IF _DISC_DOCKED \ Platform
 EQUB 1                 \ Ship type in the hanger = 1 = Cargo canister
ELIF _6502SP_VERSION
 EQUB OIL               \ Ship type = OIL = Cargo canister
ENDIF
 EQUB %01010000         \ x_hi = %01010000 = 80, z_hi   = 1     -> x = -80
 EQUB %00010001         \ z_lo = %00010001 = 17, x_sign = 1        z = +273

IF _DISC_DOCKED \ Platform
 EQUB 1                 \ Ship type in the hanger = 1 = Cargo canister
ELIF _6502SP_VERSION
 EQUB OIL               \ Ship type = OIL = Cargo canister
ENDIF
 EQUB %11010001         \ x_hi = %11010001 = 209, z_hi = 2      -> x = +209
 EQUB %00101000         \ z_lo = %00101000 =  40, x_sign = 0       z = +552

IF _DISC_DOCKED \ Platform
 EQUB 1                 \ Ship type in the hanger = 1 = Cargo canister
ELIF _6502SP_VERSION
 EQUB OIL               \ Ship type = OIL = Cargo canister
ENDIF
 EQUB %01000000         \ x_hi = %01000000 = 64, z_hi   = 1     -> x = +64
 EQUB %00000110         \ z_lo = %00000110 = 6,  x_sign = 0        z = +262

                        \ Hanger group for X = 18
                        \
IF _DISC_DOCKED \ Feature
                        \ Transporter (right) and Cobra Mk III (left)
ELIF _6502SP_VERSION
                        \ Viper (right) and Krait (left)
ENDIF
                        \
                        \ (This group consists of a Transporter and Cobra Mk III
                        \ in the disc version)

IF _DISC_DOCKED \ Feature
 EQUB 3                 \ Ship type in the hanger = 3 = Transporter
ELIF _6502SP_VERSION
 EQUB COPS              \ Ship type = COPS = Viper
ENDIF
 EQUB %01100000         \ x_hi = %01100000 =  96, z_hi   = 1    -> x = +96
 EQUB %10010000         \ z_lo = %10010000 = 144, x_sign = 0       z = +400

IF _DISC_DOCKED \ Feature
 EQUB 4                 \ Ship type in the hanger = 4 = Cobra Mk III
ELIF _6502SP_VERSION
 EQUB KRA               \ Ship type = KRA = Krait
ENDIF
 EQUB %00010000         \ x_hi = %00010000 =  16, z_hi   = 1    -> x = -16
 EQUB %11010001         \ z_lo = %11010001 = 209, x_sign = 1       z = +465

 EQUB 0                 \ No third ship
 EQUB 0
 EQUB 0

                        \ Hanger group for X = 27
                        \
                        \ Viper (right and forward) and Krait (left)

IF _DISC_DOCKED \ Platform
 EQUB 6                 \ Ship type in the hanger = 6 = Viper
ELIF _6502SP_VERSION
 EQUB 16                \ Ship type = 16 = Viper
ENDIF
 EQUB %01010001         \ x_hi = %01010001 =  81, z_hi  = 2     -> x = +81
 EQUB %11111000         \ z_lo = %11111000 = 248, x_sign = 0       z = +760

IF _DISC_DOCKED \ Platform
 EQUB 7                 \ Ship type in the hanger = 7 = Krait
ELIF _6502SP_VERSION
 EQUB 19                \ Ship type = 19 = Krait
ENDIF
 EQUB %01100000         \ x_hi = %01100000 = 96,  z_hi   = 1    -> x = -96
 EQUB %01110101         \ z_lo = %01110101 = 117, x_sign = 1       z = +373

 EQUB 0                 \ No third ship
 EQUB 0
 EQUB 0
