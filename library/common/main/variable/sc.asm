.SC

 SKIP 1                 \ Screen address (low byte)
                        \
                        \ Elite draws on-screen by poking bytes directly into
                        \ screen memory, and SC(1 0) is typically set to the
                        \ address of the character block containing the pixel
                        \ we want to draw (see the deep dives on "Drawing
                        \ monochrome pixels in mode 4" and "Drawing colour
                        \ pixels in mode 5" for more details)

