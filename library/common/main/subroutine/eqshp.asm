\ ******************************************************************************
\
\       Name: EQSHP
\       Type: Subroutine
\   Category: Equipment
IF _CASSETTE_VERSION OR _DISC_DOCKED OR _ELITE_A_VERSION OR _6502SP_VERSION OR _MASTER_VERSION \ Comment
\    Summary: Show the Equip Ship screen (red key f3)
ELIF _ELECTRON_VERSION
\    Summary: Show the Equip Ship screen (FUNC-4)
ENDIF
\
\ ------------------------------------------------------------------------------
\
\ Other entry points:
\
\   err                 Beep, pause and go to the docking bay (i.e. show the
\                       Status Mode screen)
\
\   pres                Given an item number A with the item name in recursive
\                       token Y, show an error to say that the item is already
\                       present, refund the cost of the item, and then beep and
\                       exit to the docking bay (i.e. show the Status Mode
\                       screen)
\                        
IF _ELITE_A_VERSION
\   pres+3              Show the error to say that an item is already present,
\                       and process a refund, but do not free up a space in the
\                       hold
\
ENDIF
\ ******************************************************************************

IF NOT(_ELITE_A_VERSION)

.bay

 JMP BAY                \ Go to the docking bay (i.e. show the Status Mode
                        \ screen)

ENDIF

.EQSHP

IF _CASSETTE_VERSION OR _ELECTRON_VERSION \ Platform

 JSR DIALS              \ Call DIALS to update the dashboard

ENDIF

IF _CASSETTE_VERSION OR _ELECTRON_VERSION OR _DISC_DOCKED OR _ELITE_A_VERSION \ 6502SP: In the 6502SP version, you can send the Equip Ship screen to the printer by pressing CTRL-f3

 LDA #32                \ Clear the top part of the screen, draw a white border,
 JSR TT66               \ and set the current view type in QQ11 to 32 (Equip
                        \ Ship screen)

ELIF _6502SP_VERSION OR _MASTER_VERSION

 LDA #32                \ Clear the top part of the screen, draw a white border,
 JSR TRADEMODE          \ and set up a printable trading screen with a view type
                        \ in QQ11 of 32 (Equip Ship screen)

ENDIF

IF _DISC_DOCKED OR _ELITE_A_VERSION \ Platform

 JSR FLKB               \ Flush the keyboard buffer

ENDIF

IF _CASSETTE_VERSION OR _ELECTRON_VERSION OR _DISC_DOCKED OR _ELITE_A_VERSION OR _MASTER_VERSION \ Tube

 LDA #12                \ Move the text cursor to column 12
 STA XC

ELIF _6502SP_VERSION

 LDA #12                \ Move the text cursor to column 12
 JSR DOXC

ENDIF

 LDA #207               \ Print recursive token 47 ("EQUIP") followed by a space
 JSR spc

 LDA #185               \ Print recursive token 25 ("SHIP") and draw a
 JSR NLIN3              \ horizontal line at pixel row 19 to box in the title

IF NOT(_ELITE_A_DOCKED)

 LDA #%10000000         \ Set bit 7 of QQ17 to switch to Sentence Case, with the
 STA QQ17               \ next letter in capitals

ELIF _ELITE_A_DOCKED

 JSR vdu_80             \ Call vdu_80 to switch to Sentence Case, with the next
                        \ letter in capitals

ENDIF

IF _CASSETTE_VERSION OR _ELECTRON_VERSION OR _DISC_DOCKED OR _ELITE_A_VERSION OR _MASTER_VERSION \ Tube

 INC YC                 \ Move the text cursor down one line

ELIF _6502SP_VERSION

 JSR INCYC              \ Move the text cursor down one line

ENDIF

IF _ELITE_A_VERSION

 JSR CTRL               \ Scan the keyboard to see if CTRL is currently pressed,
                        \ returning a negative value in A if it is

 BPL n_eqship           \ If CTRL is not being pressed, jump down to n_eqship to
                        \ keep processing the Equip Ship screen

 JMP n_buyship          \ CTRL is being pressed, which means CTRL-f3 is being
                        \ pressed, so jump to n_buyship to show the Buy Ship
                        \ screen instead

.bay

 JMP BAY                \ Go to the docking bay (i.e. show the Status Mode
                        \ screen)

.n_eqship

ENDIF

IF NOT(_ELITE_A_VERSION)

 LDA tek                \ Fetch the tech level of the current system from tek
 CLC                    \ and add 3 (the tech level is stored as 0-14, so A is
 ADC #3                 \ now set to between 3 and 17)

ELIF _ELITE_A_VERSION

 LDA tek                \ Fetch the tech level of the current system from tek
 CLC                    \ and add 2 (the tech level is stored as 0-14, so A is
 ADC #2                 \ now set to between 2 and 16)

ENDIF

IF _CASSETTE_VERSION OR _ELECTRON_VERSION \ Enhanced: There are up to 14 different types of ship equipment available in the enhanced version, as opposed to 12 in the cassette version (the extra options are mining and military lasers)

 CMP #12                \ If A >= 12 then set A = 12, so A is now set to between
 BCC P%+4               \ 3 and 12
 LDA #12

 STA Q                  \ Set QQ25 = A (so QQ25 is in the range 3-12 and
 STA QQ25               \ represents number of the most advanced item available
 INC Q                  \ in this system, which we can pass to gnum below when
                        \ asking which item we want to buy)
                        \
                        \ Set Q = A + 1 (so Q is in the range 4-13 and contains
                        \ QQ25 + 1, i.e. the highest item number on sale + 1)

ELIF _6502SP_VERSION OR _DISC_DOCKED OR _MASTER_VERSION

 CMP #12                \ If A >= 12 then set A = 14, so A is now set to between
 BCC P%+4               \ 3 and 14
 LDA #14

 STA Q                  \ Set QQ25 = A (so QQ25 is in the range 3-14 and
 STA QQ25               \ represents number of the most advanced item available
 INC Q                  \ in this system, which we can pass to gnum below when
                        \ asking which item we want to buy)
                        \
                        \ Set Q = A + 1 (so Q is in the range 4-15 and contains
                        \ QQ25 + 1, i.e. the highest item number on sale + 1)

ELIF _ELITE_A_VERSION

 CMP #12                \ If A >= 12 then set A = 14, so A is now set to between
 BCC P%+4               \ 2 and 14
 LDA #14

 STA Q                  \ Set QQ25 = A (so QQ25 is in the range 2-14 and
 STA QQ25               \ represents number of the most advanced item available
 INC Q                  \ in this system, which we can pass to gnum below when
                        \ asking which item we want to buy)
                        \
                        \ Set Q = A + 1 (so Q is in the range 3-15 and contains
                        \ QQ25 + 1, i.e. the highest item number on sale + 1)

ENDIF

IF NOT(_ELITE_A_VERSION)

 LDA #70                \ Set A = 70 - QQ14, where QQ14 contains the current
 SEC                    \ fuel in light years * 10, so this leaves the amount
 SBC QQ14               \ of fuel we need to fill 'er up (in light years * 10)

ELIF _ELITE_A_VERSION

 LDA new_range          \ Set A = new_range - QQ14, where QQ14 contains the
 SEC                    \ current fuel in light years * 10, so this leaves the
 SBC QQ14               \ amount of fuel we need to fill 'er up (in light years
                        \ * 10)

ENDIF

 ASL A                  \ The price of fuel is always 2 Cr per light year, so we
 STA PRXS               \ double A and store it in PRXS, as the first price in
                        \ the price list (which is reserved for fuel), and
                        \ because the table contains prices as price * 10, it's
                        \ in the right format (so tank containing 7.0 light
                        \ years of fuel would be 14.0 Cr, or a PRXS value of
                        \ 140)

IF _ELITE_A_VERSION

 LDA #0                 \ As the maximum amount of fuel in Elite-A can be more
 ROL A                  \ than 25.5 light years, we need to use PRXS(1 0) to
 STA PRXS+1             \ store the fuel level, so this catches bit 7 from the
                        \ left shift of the low byte above (which the ASL will
                        \ have put into the C flag), and sets bit 0 of the high
                        \ byte in PRXS+1 accordingly

ENDIF

 LDX #1                 \ We are now going to work our way through the equipment
                        \ price list at PRXS, printing out the equipment that is
                        \ available at this station, so set a counter in X,
                        \ starting at 1, to hold the number of the current item
                        \ plus 1 (so the item number in X loops through 1-13)

.EQL1

 STX XX13               \ Store the current item number + 1 in XX13

 JSR TT67               \ Print a newline

 LDX XX13               \ Print the current item number + 1 to 3 digits, left-
 CLC                    \ padding with spaces, and with no decimal point, so the
 JSR pr2                \ items are numbered from 1

 JSR TT162              \ Print a space

 LDA XX13               \ Print recursive token 104 + XX13, which will be in the
 CLC                    \ range 105 ("FUEL") to 116 ("GALACTIC HYPERSPACE ")
 ADC #104               \ so this prints the current item's name
 JSR TT27

 LDA XX13               \ Call prx-3 to set (Y X) to the price of the item with
 JSR prx-3              \ number XX13 - 1 (as XX13 contains the item number + 1)

 SEC                    \ Set the C flag so we will print a decimal point when
                        \ we print the price

IF _CASSETTE_VERSION OR _ELECTRON_VERSION OR _DISC_DOCKED OR _ELITE_A_VERSION OR _MASTER_VERSION \ Tube

 LDA #25                \ Move the text cursor to column 25
 STA XC

ELIF _6502SP_VERSION

 LDA #25                \ Move the text cursor to column 25
 JSR DOXC

ENDIF

 LDA #6                 \ Print the number in (Y X) to 6 digits, left-padding
 JSR TT11               \ with spaces and including a decimal point, which will
                        \ be the correct price for this item as (Y X) contains
                        \ the price * 10, so the trailing zero will go after the
                        \ decimal point (i.e. 5250 will be printed as 525.0)

 LDX XX13               \ Increment the current item number in XX13
 INX

 CPX Q                  \ If X < Q, loop back up to print the next item on the
 BCC EQL1               \ list of equipment available at this station

 JSR CLYNS              \ Clear the bottom three text rows of the upper screen,
                        \ and move the text cursor to column 1 on row 21, i.e.
                        \ the start of the top row of the three bottom rows

 LDA #127               \ Print recursive token 127 ("ITEM") followed by a
 JSR prq                \ question mark

 JSR gnum               \ Call gnum to get a number from the keyboard, which
                        \ will be the number of the item we want to purchase,
                        \ returning the number entered in A and R, and setting
                        \ the C flag if the number is bigger than the highest
                        \ item number in QQ25

 BEQ bay                \ If no number was entered, jump up to bay to go to the
                        \ docking bay (i.e. show the Status Mode screen)

 BCS bay                \ If the number entered was too big, jump up to bay to
                        \ go to the docking bay (i.e. show the Status Mode
                        \ screen)

 SBC #0                 \ Set A to the number entered - 1 (because the C flag is
                        \ clear), which will be the actual item number we want
                        \ to buy

IF _CASSETTE_VERSION OR _ELECTRON_VERSION OR _DISC_DOCKED OR _ELITE_A_VERSION \ Tube

 LDX #2                 \ Move the text cursor to column 2
 STX XC

 INC YC                 \ Move the text cursor down one line

ELIF _6502SP_VERSION

 PHA                    \ Store A on the stack so we can restore it after the
                        \ following call to DOXC

 LDA #2                 \ Move the text cursor to column 2
 JSR DOXC

 JSR INCYC              \ Move the text cursor down one line

 PLA                    \ Restore A from the stack

ELIF _MASTER_VERSION

 PHA                    \ Store A on the stack so we can restore it after the
                        \ following call to DOXC

 LDA #2                 \ Move the text cursor to column 2
 STA XC

 INC YC                 \ Move the text cursor down one line

 PLA                    \ Restore A from the stack

ENDIF

IF NOT(_ELITE_A_VERSION)

 PHA                    \ While preserving the value in A, call eq to subtract
 JSR eq                 \ the price of the item we want to buy (which is in A)
 PLA                    \ from our cash pot, but only if we have enough cash in
                        \ the pot. If we don't have enough cash, exit to the
                        \ docking bay (i.e. show the Status Mode screen)

ELIF _ELITE_A_VERSION

 PHA                    \ Store A on the stack so we can restore it after the
                        \ following code

 CMP #2                 \ If A < 2, then we are buying fuel or missiles, so jump
 BCC equip_space        \ down to equip_space to skip the checks for whether we
                        \ have enough free space in the hold (as fuel and
                        \ missiles don't take up hold space)

 LDA QQ20+16            \ Fetch the number of alien items in the hold into A, so
                        \ the following call to Tml will include these in the
                        \ total

 SEC                    \ Call Tml with X = 12 and the C flag set, to work out
 LDX #12                \ if there is space for one more tonne in the hold
 JSR Tml

 BCC equip_isspace      \ If the C flag is clear then there is indeed room for
                        \ another tonne, so jump to equip_isspace so we can buy
                        \ the new piece of equipment

 LDA #14                \ Otherwise there isn't room in the hold for any more
                        \ equipment, so set set A to the value for recursive
                        \ token 14 ("UNIT")

 JMP query_beep         \ Print the recursive token given in A followed by a
                        \ question mark, then make a beep, pause and go to the
                        \ docking bay (i.e. show the Status Mode screen)

.equip_isspace

 DEC new_hold           \ We are now going to buy the piece of equipment, so
                        \ decrement the free space in the hold, as equipment
                        \ takes up hold space in Elite-A

 PLA                    \ Set A to the value from the top of the stack (so it
 PHA                    \ contains the number of the item we want to buy)

.equip_space

 JSR eq                 \ Call eq to subtract the price of the item we want to
                        \ buy (which is in A) from our cash pot, but only if we
                        \ have enough cash in the pot. If we don't have enough
                        \ cash, exit to the docking bay (i.e. show the Status
                        \ Mode screen)

 PLA                    \ Restore A from the stack

ENDIF

 BNE et0                \ If A is not 0 (i.e. the item we've just bought is not
                        \ fuel), skip to et0

IF _CASSETTE_VERSION OR _ELECTRON_VERSION \ Other: The cassette version resets the MCNT main loop counter when we refuel, which the other versions don't. I don't know why it would do this - perhaps it's a remnant of some other code that was cleared out in later versions?

 STA MCNT               \ We just bought fuel, so we zero the main loop counter

ENDIF

IF NOT(_ELITE_A_VERSION)

 LDX #70                \ Set the current fuel level * 10 in QQ14 to 70, or 7.0
 STX QQ14               \ light years (a full tank)

ELIF _ELITE_A_VERSION

 LDX new_range          \ Set the current fuel level in QQ14 to our current
 STX QQ14               \ ship's maximum hyperspace range from new_range, so the
                        \ tank is now full

 JSR DIALS              \ Call DIALS to update the dashboard with the new fuel
                        \ level

 LDA #0                 \ Set A to 0 as the call to DIALS will have overwritten
                        \ the original value, and we still need it set
                        \ correctly so we can continue through the conditional
                        \ statements for all the other equipment

ENDIF

.et0

 CMP #1                 \ If A is not 1 (i.e. the item we've just bought is not
 BNE et1                \ a missile), skip to et1

 LDX NOMSL              \ Fetch the current number of missiles from NOMSL into X

 INX                    \ Increment X to the new number of missiles

IF _CASSETTE_VERSION OR _ELECTRON_VERSION \ Minor

 LDY #117               \ Set Y to recursive token 117 ("ALL")

ELIF _6502SP_VERSION OR _DISC_DOCKED OR _ELITE_A_VERSION OR _MASTER_VERSION

 LDY #124               \ Set Y to recursive token 124 ("ALL")

ENDIF

IF NOT(_ELITE_A_VERSION)

 CPX #5                 \ If buying this missile would give us 5 missiles, this
 BCS pres               \ is more than the maximum of 4 missiles that we can
                        \ fit, so jump to pres to show the error "All Present",
                        \ beep and exit to the docking bay (i.e. show the Status
                        \ Mode screen)

ELIF _ELITE_A_VERSION

 CPX new_missiles       \ If buying this missile would give us more than the
 BCS pres+3             \ maximum number of missiles that our current ship can
                        \ hold (which is stored in new_missiles), jump to pres+3
                        \ to show the error "All Present", do not free up any
                        \ space in the hold (as missiles do not take up hold
                        \ space), beep and exit to the docking bay (i.e. show
                        \ the Status Mode screen)

ENDIF

 STX NOMSL              \ Otherwise update the number of missiles in NOMSL

 JSR msblob             \ Reset the dashboard's missile indicators so none of
                        \ them are targeted

IF _6502SP_VERSION OR _MASTER_VERSION \ Platform: The MSBAR routine that msblob calls corrupts the A register in the 6502SP version, so we need to reset it

 LDA #1                 \ Set A to 1 as the call to msblob will have overwritten
                        \ the original value, and we still need it set
                        \ correctly so we can continue through the conditional
                        \ statements for all the other equipment

ENDIF

.et1

IF NOT(_ELITE_A_VERSION)

 LDY #107               \ Set Y to recursive token 107 ("LARGE CARGO{sentence
                        \ case} BAY")

 CMP #2                 \ If A is not 2 (i.e. the item we've just bought is not
 BNE et2                \ a large cargo bay), skip to et2

 LDX #37                \ If our current cargo capacity in CRGO is 37, then we
 CPX CRGO               \ already have a large cargo bay fitted, so jump to pres
 BEQ pres               \ to show the error "Large Cargo Bay Present", beep and
                        \ exit to the docking bay (i.e. show the Status Mode
                        \ screen)

 STX CRGO               \ Otherwise we just scored ourselves a large cargo bay,
                        \ so update our current cargo capacity in CRGO to 37

ELIF _ELITE_A_VERSION

 LDY #107               \ Set Y to recursive token 107 ("I.F.F.SYSTEM")

 CMP #2                 \ If A is not 2 (i.e. the item we've just bought is not
 BNE et2                \ an I.F.F. system), skip to et2

 LDX CRGO               \ If we already have an I.F.F. fitted (i.e. CRGO is
 BNE pres               \ non-zero), jump to pres to show the error "I.F.F.
                        \ System Present", beep and exit to the docking bay
                        \ (i.e. show the Status Mode screen)

 DEC CRGO               \ Otherwise we just scored ourselves an I.F.F. system,
                        \ so set CRGO to &FF (as CRGO was 0 before the DEC
                        \ instruction)

ENDIF

.et2

 CMP #3                 \ If A is not 3 (i.e. the item we've just bought is not
 BNE et3                \ an E.C.M. system), skip to et3

 INY                    \ Increment Y to recursive token 108 ("E.C.M.SYSTEM")

 LDX ECM                \ If we already have an E.C.M. fitted (i.e. ECM is
 BNE pres               \ non-zero), jump to pres to show the error "E.C.M.
                        \ System Present", beep and exit to the docking bay
                        \ (i.e. show the Status Mode screen)

 DEC ECM                \ Otherwise we just took delivery of a brand new E.C.M.
                        \ system, so set ECM to &FF (as ECM was 0 before the DEC
                        \ instruction)

.et3

 CMP #4                 \ If A is not 4 (i.e. the item we've just bought is not
 BNE et4                \ an extra pulse laser), skip to et4

IF NOT(_ELITE_A_VERSION)

 JSR qv                 \ Print a menu listing the four views, with a "View ?"
                        \ prompt, and ask for a view number, which is returned
                        \ in X (which now contains 0-3)

ENDIF

IF _CASSETTE_VERSION OR _ELECTRON_VERSION \ Platform: The refund code has been moved to the refund routine in the enhanced versions

 LDA #4                 \ This instruction doesn't appear to do anything, as we
                        \ either don't need it (if we already have this laser)
                        \ or we set A to 4 below (if we buy it)

 LDY LASER,X            \ If there is no laser mounted in the chosen view (i.e.
 BEQ ed4                \ LASER+X, which contains the laser power for view X, is
                        \ zero), jump to ed4 to buy a pulse laser

.ed7

 LDY #187               \ Otherwise we already have a laser mounted in this
 BNE pres               \ view, so jump to pres with Y set to token 27
                        \ (" LASER") to show the error "Laser Present", beep
                        \ and exit to the docking bay (i.e. show the Status
                        \ Mode screen)

.ed4

 LDA #POW               \ We just bought a pulse laser for view X, so we need
 STA LASER,X            \ to fit it by storing the laser power for a pulse laser
                        \ (given in POW) in LASER+X

ELIF _6502SP_VERSION OR _DISC_DOCKED OR _MASTER_VERSION

 LDA #POW               \ Call refund with A set to the power of the new pulse
 JSR refund             \ laser to install the new laser and process a refund if
                        \ we already have a laser fitted to this view

ELIF _ELITE_A_VERSION

 LDY new_pulse          \ Set Y to the power level of pulse lasers when fitted
                        \ to our current ship type

 BNE equip_leap         \ Jump to equip_merge (via equip_leap) to install the
                        \ new laser (this BNE is effectively a JMP as Y is never
                        \ zero)

ENDIF

IF NOT(_ELITE_A_VERSION)

 LDA #4                 \ Set A to 4 as we just overwrote the original value,
                        \ and we still need it set correctly so we can continue
                        \ through the conditional statements for all the other
                        \ equipment

ENDIF

.et4

 CMP #5                 \ If A is not 5 (i.e. the item we've just bought is not
 BNE et5                \ an extra beam laser), skip to et5

IF NOT(_ELITE_A_VERSION)

 JSR qv                 \ Print a menu listing the four views, with a "View ?"
                        \ prompt, and ask for a view number, which is returned
                        \ in X (which now contains 0-3)

ELIF _ELITE_A_VERSION

 LDY new_beam           \ Set Y to the power level of beam lasers when fitted to
                        \ our current ship type

.equip_leap

 BNE equip_frog         \ Jump to equip_merge (via equip_frog) to install the
                        \ new laser (this BNE is effectively a JMP as Y is never
                        \ zero)

ENDIF

IF _CASSETTE_VERSION \ Platform: The refund code has been moved to the refund routine in the enhanced versions

 STX T1                 \ Store the view in T1 so we can retrieve it below

 LDA #5                 \ Set A to 5 as the call to qv will have overwritten
                        \ the original value, and we still need it set
                        \ correctly so we can continue through the conditional
                        \ statements for all the other equipment

 LDY LASER,X            \ If there is no laser mounted in the chosen view (i.e.
 BEQ ed5                \ LASER+X, which contains the laser power for view X,
                        \ is zero), jump to ed5 to buy a beam laser

\BPL P%+4               \ This instruction is commented out in the original
                        \ source, though it would have no effect (it would
                        \ simply skip the BMI if A is positive, which is what
                        \ BMI does anyway)

 BMI ed7                \ If there is a beam laser already mounted in the chosen
                        \ view (i.e. LASER+X has bit 7 set, which indicates a
                        \ beam laser rather than a pulse laser), skip back to
                        \ ed7 to print a "Laser Present" error, beep and exit
                        \ to the docking bay (i.e. show the Status Mode screen)

 LDA #4                 \ If we get here then we already have a pulse laser in
 JSR prx                \ the selected view, so we call prx to set (Y X) to the
                        \ price of equipment item number 4 (extra pulse laser)
                        \ so we can give a refund of the pulse laser

 JSR MCASH              \ Add (Y X) cash to the cash pot in CASH, so we refund
                        \ the price of the pulse laser we are exchanging for a
                        \ new beam laser

.ed5

 LDA #POW+128           \ We just bought a beam laser for view X, so we need
 LDX T1                 \ to fit it by storing the laser power for a beam laser
 STA LASER,X            \ (given in POW+128) in LASER+X, using the view number
                        \ we stored in T1 earlier, as the call to prx will have
                        \ overwritten the original value in X

ELIF _ELECTRON_VERSION

 STX T1                 \ Store the view in T1 so we can retrieve it below

 LDA #5                 \ Set A to 5 as the call to qv will have overwritten
                        \ the original value, and we still need it set
                        \ correctly so we can continue through the conditional
                        \ statements for all the other equipment

 LDY LASER,X            \ If there is no laser mounted in the chosen view (i.e.
 BEQ ed5                \ LASER+X, which contains the laser power for view X,
                        \ is zero), jump to ed5 to buy a beam laser

 BMI ed7                \ If there is a beam laser already mounted in the chosen
                        \ view (i.e. LASER+X has bit 7 set, which indicates a
                        \ beam laser rather than a pulse laser), skip back to
                        \ ed7 to print a "Laser Present" error, beep and exit
                        \ to the docking bay (i.e. show the Status Mode screen)

 LDA #4                 \ If we get here then we already have a pulse laser in
 JSR prx                \ the selected view, so we call prx to set (Y X) to the
                        \ price of equipment item number 4 (extra pulse laser)
                        \ so we can give a refund of the pulse laser

 JSR MCASH              \ Add (Y X) cash to the cash pot in CASH, so we refund
                        \ the price of the pulse laser we are exchanging for a
                        \ new beam laser

.ed5

 LDA #POW+128           \ We just bought a beam laser for view X, so we need
 LDX T1                 \ to fit it by storing the laser power for a beam laser
 STA LASER,X            \ (given in POW+128) in LASER+X, using the view number
                        \ we stored in T1 earlier, as the call to prx will have
                        \ overwritten the original value in X

ELIF _6502SP_VERSION OR _DISC_DOCKED OR _MASTER_VERSION

 LDA #POW+128           \ Call refund with A set to the power of the new beam
 JSR refund             \ laser to install the new laser and process a refund if
                        \ we already have a laser fitted to this view

ENDIF

.et5

 LDY #111               \ Set Y to recursive token 107 ("FUEL SCOOPS")

 CMP #6                 \ If A is not 6 (i.e. the item we've just bought is not
 BNE et6                \ a fuel scoop), skip to et6

 LDX BST                \ If we already have fuel scoops fitted (i.e. BST is
 BEQ ed9                \ zero), jump to ed9, otherwise fall through into pres
                        \ to show the error "Fuel Scoops Present", beep and
                        \ exit to the docking bay (i.e. show the Status Mode
                        \ screen)

.pres

                        \ If we get here we need to show an error to say that
                        \ the item whose name is in recursive token Y is already
                        \ present, and then process a refund for the cost of
                        \ item number A

IF _ELITE_A_VERSION

 INC new_hold           \ We can't buy the requested equipment, so increment the
                        \ free space in the hold, as we decremented it earler
                        \ in anticipation of making a deal, but the deal has
                        \ fallen through

ENDIF

 STY K                  \ Store the item's name in K

 JSR prx                \ Call prx to set (Y X) to the price of equipment item
                        \ number A

 JSR MCASH              \ Add (Y X) cash to the cash pot in CASH, as the station
                        \ already took the money for this item in the JSR eq
                        \ instruction above, but we can't fit the item, so need
                        \ our money back

 LDA K                  \ Print the recursive token in K (the item's name)
 JSR spc                \ followed by a space

 LDA #31                \ Print recursive token 145 ("PRESENT")
 JSR TT27

.err

 JSR dn2                \ Call dn2 to make a short, high beep and delay for 1
                        \ second

 JMP BAY                \ Jump to BAY to go to the docking bay (i.e. show the
                        \ Status Mode screen)

.ed9

 DEC BST                \ We just bought a shiny new fuel scoop, so set BST to
                        \ &FF (as BST was 0 before the jump to ed9 above)

.et6

 INY                    \ Increment Y to recursive token 112 ("E.C.M.SYSTEM")

 CMP #7                 \ If A is not 7 (i.e. the item we've just bought is not
 BNE et7                \ an escape pod), skip to et7

 LDX ESCP               \ If we already have an escape pod fitted (i.e. ESCP is
 BNE pres               \ non-zero), jump to pres to show the error "Escape Pod
                        \ Present", beep and exit to the docking bay (i.e. show
                        \ the Status Mode screen)

 DEC ESCP               \ Otherwise we just bought an escape pod, so set ESCP
                        \ to &FF (as ESCP was 0 before the DEC instruction)

IF _ELITE_A_6502SP_PARA

 JSR update_pod         \ Update the dashboard colours to reflect that we now
                        \ have an escape pod

ENDIF

.et7

IF NOT(_ELITE_A_VERSION)

 INY                    \ Increment Y to recursive token 113 ("ENERGY BOMB")

 CMP #8                 \ If A is not 8 (i.e. the item we've just bought is not
 BNE et8                \ an energy bomb), skip to et8

 LDX BOMB               \ If we already have an energy bomb fitted (i.e. BOMB
 BNE pres               \ is non-zero), jump to pres to show the error "Energy
                        \ Bomb Present", beep and exit to the docking bay (i.e.
                        \ show the Status Mode screen)

 LDX #&7F               \ Otherwise we just bought an energy bomb, so set BOMB
 STX BOMB               \ to &7F

ELIF _ELITE_A_VERSION

 INY                    \ Increment Y to recursive token 113 ("HYPERSPACE UNIT")

 CMP #8                 \ If A is not 8 (i.e. the item we've just bought is not
 BNE et8                \ a hyperspace unit), skip to et8

 LDX BOMB               \ If we already have a hyperspace unit fitted (i.e. BOMB
 BNE pres               \ is non-zero), jump to pres to show the error
                        \ "Hyperspace Unit Present", beep and exit to the docking
                        \ bay (i.e. show the Status Mode screen)

 DEC BOMB               \ Otherwise we just bought an energy bomb, so set BOMB
                        \ to &FF (as BOMB was 0 before the DEC instruction)

ENDIF

.et8

 INY                    \ Increment Y to recursive token 114 ("ENERGY UNIT")

 CMP #9                 \ If A is not 9 (i.e. the item we've just bought is not
 BNE etA                \ an energy unit), skip to etA

 LDX ENGY               \ If we already have an energy unit fitted (i.e. ENGY is
 BNE pres               \ non-zero), jump to pres to show the error "Energy Unit
                        \ Present", beep and exit to the docking bay (i.e. show
                        \ the Status Mode screen)

IF NOT(_ELITE_A_VERSION)

 INC ENGY               \ Otherwise we just picked up an energy unit, so set
                        \ ENGY to 1 (as ENGY was 0 before the INC instruction)

ELIF _ELITE_A_VERSION

 LDX new_energy         \ Otherwise we just picked up an energy unit, so set
 STX ENGY               \ ENGY to new_energy, which is the value of our current
                        \ ship's ship energy refresh rate with an energy unit
                        \ fitted

ENDIF

.etA

 INY                    \ Increment Y to recursive token 115 ("DOCKING
                        \ COMPUTERS")

 CMP #10                \ If A is not 10 (i.e. the item we've just bought is not
 BNE etB                \ a docking computer), skip to etB

 LDX DKCMP              \ If we already have a docking computer fitted (i.e.
 BNE pres               \ DKCMP is non-zero), jump to pres to show the error
                        \ "Docking Computer Present", beep and exit to the
                        \ docking bay (i.e. show the Status Mode screen)

 DEC DKCMP              \ Otherwise we just got hold of a docking computer, so
                        \ set DKCMP to &FF (as DKCMP was 0 before the DEC
                        \ instruction)

.etB

 INY                    \ Increment Y to recursive token 116 ("GALACTIC
                        \ HYPERSPACE ")

 CMP #11                \ If A is not 11 (i.e. the item we've just bought is not
 BNE et9                \ a galactic hyperdrive), skip to et9

IF NOT(_ELITE_A_VERSION)

 LDX GHYP               \ If we already have a galactic hyperdrive fitted (i.e.
 BNE pres               \ GHYP is non-zero), jump to pres to show the error
                        \ "Galactic Hyperspace Present", beep and exit to the
                        \ docking bay (i.e. show the Status Mode screen)

ELIF _ELITE_A_VERSION

 LDX GHYP               \ Set X to the value of GHYP, which determines
                        \ whether we have a galactic hyperdrive fitted

.equip_gfrog

 BNE pres               \ If we already have a galactic hyperdrive fitted (i.e.
                        \ GHYP is non-zero), jump to pres to show the error
                        \ "Galactic Hyperspace Present", beep and exit to the
                        \ docking bay (i.e. show the Status Mode screen)

ENDIF

 DEC GHYP               \ Otherwise we just splashed out on a galactic
                        \ hyperdrive, so set GHYP to &FF (as GHYP was 0 before
                        \ the DEC instruction)

.et9

IF _6502SP_VERSION OR _DISC_DOCKED OR _MASTER_VERSION \ Enhanced: In the enhanced versions, mining and military lasers can be fitted in the Equip Ship screen

 INY                    \ Increment Y to recursive token 117 ("MILITARY  LASER")

 CMP #12                \ If A is not 12 (i.e. the item we've just bought is not
 BNE et10               \ a military laser), skip to et10

 JSR qv                 \ Print a menu listing the four views, with a "View ?"
                        \ prompt, and ask for a view number, which is returned
                        \ in X (which now contains 0-3)

 LDA #Armlas            \ Call refund with A set to the power of the new
 JSR refund             \ military laser to install the new laser and process a
                        \ refund if we already have a laser fitted to this view

.et10

 INY                    \ Increment Y to recursive token 118 ("MINING  LASER")

 CMP #13                \ If A is not 13 (i.e. the item we've just bought is not
 BNE et11               \ a mining laser), skip to et11

 JSR qv                 \ Print a menu listing the four views, with a "View ?"
                        \ prompt, and ask for a view number, which is returned
                        \ in X (which now contains 0-3)

 LDA #Mlas              \ Call refund with A set to the power of the new mining
 JSR refund             \ laser to install the new laser and process a refund if
                        \ we already have a laser fitted to this view

.et11

ELIF _ELITE_A_VERSION

 INY                    \ Increment Y to recursive token 117 ("MILITARY  LASER")

 CMP #12                \ If A is not 12 (i.e. the item we've just bought is not
 BNE et10               \ a military laser), skip to et10

 LDY new_military       \ Set Y to the power level of military lasers when
                        \ fitted to our current ship type

.equip_frog

 BNE equip_merge        \ Jump to equip_merge to install the new laser (this BNE
                        \ is effectively a JMP as Y is never zero)

.et10

 INY                    \ Increment Y to recursive token 118 ("MINING  LASER")

 CMP #13                \ If A is not 13 (i.e. the item we've just bought is not
 BNE et11               \ a mining laser), skip to et11

 LDY new_mining         \ Set Y to the power level of mining lasers when fitted
                        \ to our current ship type

.equip_merge

                        \ Now to install a new laser with the laser power in Y
                        \ and the item number in A

 PHA                    \ Store the item number in A on the stack

 TYA                    \ Store the laser power in Y on the stack
 PHA

 JSR qv                 \ Print a menu listing the four views, with a "View ?"
                        \ prompt, and ask for a view number, which is returned
                        \ in X (which now contains 0-3)

 PLA                    \ Retrieve the laser power of the new laser from the
                        \ stack into A

 LDY LASER,X            \ If there is no laser mounted in the chosen view (i.e.
 BEQ l_3113             \ LASER+X, which contains the laser power for view X, is
                        \ zero), jump to l_3113 to fit the new laser

                        \ We already have a laser fitted to this view, so 

 PLA                    \ Retrieve the item number from the stack into A

 LDY #187               \ Set Y to token 27 (" LASER") so the following jump to
                        \ pres will show the error "Laser Present", beep and
                        \ exit to the docking bay (i.e. show the Status Mode
                        \ screen)

 BNE equip_gfrog        \ Jump to pres via equip_gfrog (this BNE is effectively
                        \ a JMP as Y is never zero)

.l_3113

 STA LASER,X            \ Fit the new laser by storing the laser power in A into
                        \ LASER+X

 PLA                    \ Retrieve the item number from the stack into A

.et11

ENDIF

 JSR dn                 \ We are done buying equipment, so print the amount of
                        \ cash left in the cash pot, then make a short, high
                        \ beep to confirm the purchase, and delay for 1 second

 JMP EQSHP              \ Jump back up to EQSHP to show the Equip Ship screen
                        \ again and see if we can't track down another bargain

