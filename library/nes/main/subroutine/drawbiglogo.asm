\ ******************************************************************************
\
\       Name: DrawBigLogo
\       Type: Subroutine
\   Category: Start and end
\    Summary: Set the pattern and nametable buffer entries for the big Elite
\             logo on the Start screen
\
\ ******************************************************************************

.DrawBigLogo

 LDA #HI(bigLogoImage)  \ Set V(1 0) = bigLogoImage
 STA V+1                \
 LDA #LO(bigLogoImage)  \ So we can unpack the image data for the big Elite logo
 STA V                  \ into the pattern buffers

 LDA firstFreePattern   \ Set K+2 to the next free pattern number, to send to
 TAY                    \ the DrawImageNames routine below as the pattern number
 STY K+2                \ of the start of the big logo data

 ASL A                  \ Set SC(1 0) = pattBuffer0 + firstFreePattern * 8
 STA SC                 \
 LDA #LO(pattBuffer0)   \ So this points to the pattern in pattern buffer 0 that
 ROL A                  \ corresponds to the next free pattern in
 ASL SC                 \ firstFreePattern
 ROL A
 ASL SC
 ROL A
 ADC #HI(pattBuffer0)
 STA SC+1

 ADC #8                 \ Set SC2(1 0) = SC(1 0) + (8 0)
 STA SC2+1              \
 LDA SC                 \ Pattern buffer 0 consists of 8 pages of memory and is
 STA SC2                \ followed by pattern buffer 1, so this sets SC2(1 0) to
                        \ the pattern in pattern buffer 1 that corresponds to
                        \ the next free pattern in firstFreePattern

 JSR UnpackToRAM        \ Unpack the data at V(1 0) into SC(1 0), updating
                        \ V(1 0) as we go
                        \
                        \ SC(1 0) is pattBuffer0 + firstFreePattern * 8, so this
                        \ unpacks the big logo pattern data into pattern buffer
                        \ 0, starting from pattern firstFreePattern

 LDA SC2                \ Set SC(1 0) = SC2(1 0)
 STA SC                 \             = pattBuffer1 + picturePattern * 8
 LDA SC2+1
 STA SC+1

 JSR UnpackToRAM        \ Unpack the data at V(1 0) into SC(1 0), updating
                        \ V(1 0) as we go
                        \
                        \ SC(1 0) is pattBuffer0 + firstFreePattern * 8, so this
                        \ unpacks the big logo pattern data into pattern buffer
                        \ 0, starting from pattern firstFreePattern

 LDA #HI(bigLogoNames)  \ Set V(1 0) = bigLogoNames, so the call to
 STA V+1                \ DrawImageNames draws the big Elite logo
 LDA #LO(bigLogoNames)
 STA V

 LDA #24                \ Set K = 24 so the call to DrawImageNames draws 26
 STA K                  \ tiles in each row

 LDA #20                \ Set K+1 = 20 so the call to DrawImageNames draws 20
 STA K+1                \ rows of tiles

 LDA #1                 \ Set XC and YC so the call to DrawImageNames draws the
 STA YC                 \ big logo at text column 5 on row 1
 LDA #5
 STA XC

 JSR DrawImageNames     \ Draw the big Elite logo at text column 5 on row 1

 LDA firstFreePattern   \ The big logo takes up 208 patterns, so add 208 to the
 CLC                    \ next free pattern number in firstFreePattern, as we
 ADC #208               \ just used up that many patterns
 STA firstFreePattern

 RTS                    \ Return from the subroutine

