\ ******************************************************************************
\
\       Name: adder
\       Type: Variable
\   Category: Encyclopedia
\    Summary: Card data for the encyclopedia entry for the Adder
\
\ ******************************************************************************

.adder

 EQUB 1                 \ Inservice date: "2914 ({single cap}OUTWORLD
 EQUS "2914"            \                  WORKSHOPS)"
 CTOK 85                \
 CTOK 69                \ Encoded as:     "2914[85][69][81]"
 CTOK 81
 EQUB 0

 EQUB 2                 \ Combat factor:  "6"
 EQUS "6"               \
 EQUB 0                 \ Encoded as:     "6"

 EQUB 3                 \ Dimensions:     "45/8/30FT"
 EQUS "45/8/30"         \
 CTOK 42                \ Encoded as:     "45/8/30[42]"
 EQUB 0

 EQUB 4                 \ Speed:          "0.24LM"
 EQUS "0.24"            \
 CTOK 64                \ Encoded as:     "0.24[64]"
 EQUB 0

 EQUB 5                 \ Crew:           "1"
 EQUS "1"               \
 EQUB 0                 \ Encoded as:     "1"

 EQUB 6                 \ Range:          "6LY"
 EQUS "6"               \
 CTOK 63                \ Encoded as:     "6[63]"
 EQUB 0

 EQUB 7                 \ Cargo space:    "4TC"
 EQUS "4"               \
 CTOK 62                \ Encoded as:     "4[62]"
 EQUB 0

 EQUB 8                 \ Armaments:      "INGRAM 1928 AZ BEAM LASER{crlf}
 CTOK 56                \                  GERET STARSEEKER MISSILES"
 EQUS " 1928 AZ "       \
 ETWO 'B', 'E'          \ Encoded as:     "[56] 1928 AZ <247>am[49]{12}[48][46]"
 EQUS "am"
 CTOK 49
 EQUB 12
 CTOK 48
 CTOK 46
 EQUB 0

 EQUB 9                 \ Hull:           "D4-18/2L"
 EQUS "D4-18"           \
 CTOK 83                \ Encoded as:     "D4-18[83]"
 EQUB 0

 EQUB 10                \ Drive motors:   "AM 18 BI THRUST"
 EQUS "AM 18 "          \
 ETWO 'B', 'I'          \ Encoded as:     "AM 18 <234> [66]"
 EQUS " "
 CTOK 66
 EQUB 0

 EQUB 0

