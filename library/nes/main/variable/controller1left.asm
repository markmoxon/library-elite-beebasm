.controller1Left

 SKIP 1                 \ A shift register for recording presses of the left
                        \ button on controller 1
                        \
                        \ The controller is scanned every NMI and the result is
                        \ right-shifted into bit 7, with a 1 indicating a button
                        \ press and a 0 indicating no button press

