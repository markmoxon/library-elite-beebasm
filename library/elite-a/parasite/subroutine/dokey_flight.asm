\ ******************************************************************************
\
\       Name: DOKEY_FLIGHT
\       Type: Subroutine
\   Category: Keyboard
\    Summary: Scan for the seven primary flight controls (flight version)
\
\ ******************************************************************************

.DOKEY_FLIGHT

 JSR U%                 \ Call U% to clear the key logger

 LDA QQ22+1             \ Fetch QQ22+1, which contains the number that's shown
                        \ on-screen during hyperspace countdown

 BEQ l_open             \ If the hyperspace countdown is non-zero, jump to
 JMP DK4_FLIGHT         \ DK4_FLIGHT to skip scanning for primary flight keys,
                        \ and move on to scanning for pause, configuration and
                        \ secondary flight keys

.l_open

 LDA JSTK               \ If JSTK is non-zero, then we are configured to use
 BNE DKJ1               \ the joystick rather than keyboard, so jump to DKJ1
                        \ to read the joystick flight controls, before jumping
                        \ to DK4 to scan for pause, configuration and secondary
                        \ flight keys

 LDY #7                 \ We're going to work our way through the primary flight
                        \ control keys (pitch, roll, speed and laser), so set a
                        \ counter in Y so we can loop through all 7

.DKL2

 JSR DKS1               \ Call DKS1 to see if the KYTB key at offset Y is being
                        \ pressed, and set the key logger accordingly

 DEY                    \ Decrement the loop counter

 BNE DKL2               \ Loop back for the next key, working our way from A at
                        \ KYTB+7 down to ? at KYTB+1

 LDA auto               \ If auto is 0, then the docking computer is not
 BEQ DK15               \ currently activated, so jump to DK15 to skip the
                        \ docking computer manoeuvring code below

.auton

 JSR ZINF               \ Call ZINF to reset the INWK ship workspace

 LDA #96                \ Set nosev_z_hi = 96
 STA INWK+14

 ORA #%10000000         \ Set sidev_x_hi = -96
 STA INWK+22

 STA TYPE               \ Set the ship type to -96, so the negative value will
                        \ let us check in the DOCKIT routine whether this is our
                        \ ship that is activating its docking computer, rather
                        \ than an NPC ship docking

 LDA DELTA              \ Set the ship speed to DELTA (our speed)
 STA INWK+27

 JSR DOCKIT             \ Call DOCKIT to calculate the docking computer's moves
                        \ and update INWK with the results

                        \ We now "press" the relevant flight keys, depending on
                        \ the results from DOCKIT, starting with the pitch keys

 LDA INWK+27            \ Fetch the updated ship speed from byte #27 into A

 CMP #22                \ If A < 22, skip the next instruction
 BCC P%+4

 LDA #22                \ Set A = 22, so the maximum speed during docking is 22

 STA DELTA              \ Update DELTA to the new value in A

 LDA #&FF               \ Set A = &FF, which we can insert into the key logger
                        \ to "fake" the docking computer working the keyboard

 LDX #0                 \ Set X = 0, so we "press" KY1 below ("?", slow down)

 LDY INWK+28            \ If the updated acceleration in byte #28 is zero, skip
 BEQ DK11               \ to DK11

 BMI P%+3               \ If the updated acceleration is negative, skip the
                        \ following instruction

 INX                    \ The updated acceleration is positive, so increment X
                        \ to 1, so we "press" KY2 below (Space, speed up)

 STA KY1,X              \ Store &FF in either KY1 or KY2 to "press" the relevant
                        \ key, depending on whether the updated acceleration is
                        \ negative (in which case we "press" KY1, "?", to slow
                        \ down) or positive (in which case we "press" KY2,
                        \ Space, to speed up)

.DK11

                        \ We now "press" the relevant roll keys, depending on
                        \ the results from DOCKIT

 LDA #128               \ Set A = 128, which indicates no change in roll when
                        \ stored in JSTX (i.e. the centre of the roll indicator)

 LDX #0                 \ Set X = 0, so we "press" KY3 below ("<", increase
                        \ roll, which rolls our ship in a clockwise direction)

 ASL INWK+29            \ Shift ship byte #29 left, which shifts bit 7 of the
                        \ updated roll counter (i.e. the roll direction) into
                        \ the C flag

 BEQ DK12               \ If the remains of byte #29 is zero, then the updated
                        \ roll counter is zero, so jump to DK12 set JSTX to 128,
                        \ to indicate there's no change in the roll

 BCC P%+3               \ If the C flag is clear, skip the following instruction

 INX                    \ The C flag is set, i.e. the direction of the updated
                        \ roll counter is negative (anti-clockwise roll), so
                        \ increment X to 1 so we "press" KY4 below (">",
                        \ decrease roll, which rolls our ship in an
                        \ anti-clockwise direction)

 BIT INWK+29            \ We shifted the updated roll counter to the left above,
 BPL DK14               \ so this tests bit 6 of the original value, and if it
                        \ is clear (i.e. the magnitude is less than 64), jump to
                        \ DK14 to "press" the key and leave JSTX unchanged

 LDA #64                \ The magnitude of the updated roll is 64 or more, so
 STA JSTX               \ set JSTX to 64 (so the roll decreases at half the
                        \ maximum rate)

 LDA #0                 \ And set A = 0 so we do not "press" any keys (so if the
                        \ docking computer needs to make a serious roll, it does
                        \ so by setting JSTX directly rather than by "pressing"
                        \ a key)

.DK14

 STA KY3,X              \ Store A in either KY3 or KY4, depending on whether
                        \ the updated roll rate is increasing (KY3) or
                        \ decreasing (KY4)

 LDA JSTX               \ Fetch A from JSTX so the next instruction has no
                        \ effect

.DK12

 STA JSTX               \ Store A in JSTX to update the current roll rate

                        \ We now "press" the relevant pitch keys, depending on
                        \ the results from DOCKIT

 LDA #128               \ Set A = 128, which indicates no change in pitch when
                        \ stored in JSTX (i.e. the centre of the pitch
                        \ indicator)

 LDX #0                 \ Set X = 0, so we "press" KY5 below ("X", decrease
                        \ pitch, which pulls the nose up)

 ASL INWK+30            \ Shift ship byte #30 left, which shifts bit 7 of the
                        \ updated pitch counter (i.e. the pitch direction) into
                        \ the C flag

 BEQ DK13               \ If the remains of byte #30 is zero, then the updated
                        \ pitch counter is zero, so jump to DK13 set JSTY to
                        \ 128, to indicate there's no change in the pitch

 BCS P%+3               \ If the C flag is set, skip the following instruction

 INX                    \ The C flag is clear, i.e. the direction of the updated
                        \ pitch counter is positive (dive), so increment X to 1
                        \ so we "press" KY6 below ("S", increase pitch, which
                        \ pushes the nose down)

 STA KY5,X              \ Store 128 in either KY5 or KY6 to "press" the relevant
                        \ key, depending on whether the pitch direction is
                        \ negative (in which case we "press" KY5, "X", to
                        \ decrease the pitch) or positive (in which case we
                        \ "press" KY6, "S", to increase the pitch)

 LDA JSTY               \ Fetch A from JSTY so the next instruction has no
                        \ effect

.DK13

 STA JSTY               \ Store A in JSTY to update the current pitch rate

.DK15

 LDX JSTX               \ Set X = JSTX, the current roll rate (as shown in the
                        \ RL indicator on the dashboard)

 LDA #7                 \ Set A to 7, which is the amount we want to alter the
                        \ roll rate by if the roll keys are being pressed

 LDY KL+3               \ If the "<" key is being pressed, then call the BUMP2
 BEQ P%+5               \ routine to increase the roll rate in X by A
 JSR BUMP2

 LDY KL+4               \ If the ">" key is being pressed, then call the REDU2
 BEQ P%+5               \ routine to decrease the roll rate in X by A, taking
 JSR REDU2              \ the keyboard auto re-centre setting into account

 STX JSTX               \ Store the updated roll rate in JSTX

 ASL A                  \ Double the value of A, to 14

 LDX JSTY               \ Set X = JSTY, the current pitch rate (as shown in the
                        \ DC indicator on the dashboard)

 LDY KL+5               \ If the "X" key is being pressed, then call the REDU2
 BEQ P%+5               \ routine to decrease the pitch rate in X by A, taking
 JSR REDU2              \ the keyboard auto re-centre setting into account

 LDY KL+6               \ If the "S" key is being pressed, then call the BUMP2
 BEQ P%+5               \ routine to increase the pitch rate in X by A
 JSR BUMP2

 STX JSTY               \ Store the updated roll rate in JSTY

                        \ Fall through into DK4_FLIGHT to scan for other keys

