.Yx2M1

 SKIP 1                 \ This is used to store the number of pixel rows in the
                        \ space view, which is also the y-coordinate of the
IF NOT(_NES_VERSION)
                        \ bottom pixel row of the space view (it is set to 191
                        \ in the RES2 routine)
ELIF _NES_VERSION
                        \ bottom pixel row of the space view
ENDIF

