\ ******************************************************************************
\
\ ELITE-A SHIP BLUEPRINTS FILE V
\
\ Elite-A is an extended version of BBC Micro Elite by Angus Duggan
\
\ The original Elite was written by Ian Bell and David Braben and is copyright
\ Acornsoft 1984, and the extra code in Elite-A is copyright Angus Duggan
\
\ The code on this site is identical to Angus Duggan's source discs (it's just
\ been reformatted and variable names changed to be more readable)
\
\ The commentary is copyright Mark Moxon, and any misunderstandings or mistakes
\ in the documentation are entirely my fault
\
\ The terminology and notations used in this commentary are explained at
\ https://www.bbcelite.com/about_site/terminology_used_in_this_commentary.html
\
\ The deep dive articles referred to in this commentary can be found at
\ https://www.bbcelite.com/deep_dives
\
\ ------------------------------------------------------------------------------
\
\ This source file produces the following binary file:
\
\   * output/S.V.bin
\
\ ******************************************************************************

INCLUDE "versions/elite-a/sources/elite-header.h.asm"

_CASSETTE_VERSION       = (_VERSION = 1)
_DISC_VERSION           = (_VERSION = 2)
_6502SP_VERSION         = (_VERSION = 3)
_MASTER_VERSION         = (_VERSION = 4)
_ELECTRON_VERSION       = (_VERSION = 5)
_ELITE_A_VERSION        = (_VERSION = 6)
_DISC_DOCKED            = FALSE
_DISC_FLIGHT            = FALSE
_ELITE_A_DOCKED         = FALSE
_ELITE_A_FLIGHT         = TRUE
_ELITE_A_SHIPS_R        = FALSE
_ELITE_A_SHIPS_S        = FALSE
_ELITE_A_SHIPS_T        = FALSE
_ELITE_A_SHIPS_U        = FALSE
_ELITE_A_SHIPS_V        = TRUE
_ELITE_A_SHIPS_W        = FALSE
_ELITE_A_ENCYCLOPEDIA   = FALSE
_ELITE_A_6502SP_IO      = FALSE
_ELITE_A_6502SP_PARA    = FALSE
_RELEASED               = (_RELEASE = 1)
_SOURCE_DISC            = (_RELEASE = 2)

\ ******************************************************************************
\
\ Configuration variables
\
\ ******************************************************************************

SHIP_MISSILE = &7F00    \ The address of the missile ship blueprint

CODE% = &5600           \ The flight code loads this file at address &5600, at
LOAD% = &5600           \ label XX21

ORG CODE%

\ ******************************************************************************
\
\       Name: XX21
\       Type: Variable
\   Category: Drawing ships
\    Summary: Ship blueprints lookup table for the S.V file
\  Deep dive: Ship blueprints in the disc version
\
\ ******************************************************************************

.XX21

 EQUW SHIP_MISSILE      \ MSL  =  1 = Missile
 EQUW SHIP_DODO         \         2 = Dodecahedron ("Dodo") space station
 EQUW SHIP_ESCAPE_POD   \ ESC  =  3 = Escape pod
 EQUW SHIP_PLATE        \ PLT  =  4 = Alloy plate
 EQUW SHIP_CANISTER     \ OIL  =  5 = Cargo canister
 EQUW SHIP_BOULDER      \         6 = Boulder
 EQUW 0
 EQUW 0
 EQUW 0
 EQUW 0
 EQUW SHIP_COBRA_MK_3   \ CYL  = 11 = Cobra Mk III
 EQUW SHIP_BOA          \        12 = Boa
 EQUW SHIP_COBRA_MK_1   \        13 = Cobra Mk I
 EQUW 0
 EQUW 0
 EQUW SHIP_VIPER        \ COPS = 16 = Viper
 EQUW SHIP_COBRA_MK_1   \        17 = Cobra Mk I
 EQUW SHIP_SIDEWINDER   \        18 = Sidewinder
 EQUW SHIP_ADDER        \        19 = Adder
 EQUW 0
 EQUW SHIP_COBRA_MK_3   \        21 = Cobra Mk III
 EQUW 0
 EQUW 0
 EQUW 0
 EQUW SHIP_COBRA_MK_3   \        25 = Cobra Mk III
 EQUW 0
 EQUW SHIP_COBRA_MK_1   \        27 = Cobra Mk I
 EQUW SHIP_SIDEWINDER   \        28 = Sidewinder
 EQUW 0
 EQUW 0
 EQUW 0

\ ******************************************************************************
\
\       Name: E%
\       Type: Variable
\   Category: Drawing ships
\    Summary: Ship blueprints default NEWB flags for the S.V file
\  Deep dive: Ship blueprints
\             Advanced tactics with the NEWB flags
\
\ ******************************************************************************

.E%

 EQUB %00000000         \ Missile
 EQUB %01000000         \ Dodo space station                                 Cop
 EQUB %01000001         \ Escape pod                                 Trader, cop
 EQUB %00000000         \ Alloy plate
 EQUB %00000000         \ Cargo canister
 EQUB %00000000         \ Boulder
 EQUB 0
 EQUB 0
 EQUB 0
 EQUB 0
 EQUB %10100000         \ Cobra Mk III                      Innocent, escape pod
 EQUB %10100001         \ Boa                       Trader, innocent, escape pod
 EQUB %10100000         \ Cobra Mk I                        Innocent, escape pod
 EQUB 0
 EQUB 0
 EQUB %11000010         \ Viper                   Bounty hunter, cop, escape pod
 EQUB %10001100         \ Cobra Mk I                 Hostile, pirate, escape pod
 EQUB %00001100         \ Sidewinder                             Hostile, pirate
 EQUB %10000100         \ Adder                              Hostile, escape pod
 EQUB 0
 EQUB %10000100         \ Cobra Mk III                       Hostile, escape pod
 EQUB 0
 EQUB 0
 EQUB 0
 EQUB %10000010         \ Cobra Mk III                 Bounty hunter, escape pod
 EQUB 0
 EQUB %10000010         \ Cobra Mk I                   Bounty hunter, escape pod
 EQUB %00100010         \ Sidewinder                     Bounty hunter, innocent
 EQUB 0
 EQUB 0
 EQUB 0

INCLUDE "library/common/main/macro/vertex.asm"
INCLUDE "library/common/main/macro/edge.asm"
INCLUDE "library/common/main/macro/face.asm"
INCLUDE "library/enhanced/main/variable/ship_dodo.asm"
INCLUDE "library/common/main/variable/ship_escape_pod.asm"
INCLUDE "library/common/main/variable/ship_canister.asm"
INCLUDE "library/common/main/variable/ship_viper.asm"
INCLUDE "library/enhanced/main/variable/ship_cobra_mk_1.asm"
INCLUDE "library/common/main/variable/ship_sidewinder.asm"
INCLUDE "library/enhanced/main/variable/ship_boulder.asm"
INCLUDE "library/common/main/variable/ship_cobra_mk_3.asm"
INCLUDE "library/enhanced/main/variable/ship_boa.asm"
INCLUDE "library/enhanced/main/variable/ship_adder.asm"
INCLUDE "library/enhanced/main/variable/ship_plate.asm"

 EQUB 6                 \ AJD

\ ******************************************************************************
\
\ Save output/S.V.bin
\
\ ******************************************************************************

PRINT "S.S.V ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
SAVE "versions/elite-a/output/S.V.bin", CODE%, CODE% + &0A00
