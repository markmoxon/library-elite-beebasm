\ ******************************************************************************
\
\       Name: SHIP_ANACONDA
\       Type: Variable
\   Category: Drawing ships
\    Summary: Ship blueprint for an Anaconda
\
\ ******************************************************************************

.SHIP_ANACONDA

 EQUB 7                 \ Max. canisters on demise = 7
 EQUW 100 * 100         \ Targetable area          = 100 * 100
 EQUB &6E               \ Edges data offset (low)  = &006E
 EQUB &D2               \ Faces data offset (low)  = &00D2
 EQUB 93                \ Max. edge count          = (93 - 1) / 4 = 23
 EQUB 48                \ Gun vertex               = 48
 EQUB 46                \ Explosion count          = 10, as (4 * n) + 6 = 46
 EQUB 90                \ Number of vertices       = 90 / 6 = 15
 EQUB 25                \ Number of edges          = 25
 EQUW 0                 \ Bounty                   = 0
 EQUB 48                \ Number of faces          = 48 / 4 = 12
 EQUB 36                \ Visibility distance      = 
 EQUB 252               \ Max. energy              = 252
 EQUB 14                \ Max. speed               = 14
 EQUB &00               \ Edges data offset (high) = &006E
 EQUB &00               \ Faces data offset (high) = &00D2
 EQUB 1                 \ Normals are scaled by    = 2^1 = 2
 EQUB %00111111         \ Laser power              = 7
                        \ Missiles                 = 7

\VERTEX    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,    7,  -58,     1,      0,    5,     5,         30    \ Vertex 0
 VERTEX  -43,  -13,  -37,     1,      0,    2,     2,         30    \ Vertex 1
 VERTEX  -26,  -47,   -3,     2,      0,    3,     3,         30    \ Vertex 2
 VERTEX   26,  -47,   -3,     3,      0,    4,     4,         30    \ Vertex 3
 VERTEX   43,  -13,  -37,     4,      0,    5,     5,         30    \ Vertex 4
 VERTEX    0,   48,  -49,     5,      1,    6,     6,         30    \ Vertex 5
 VERTEX  -69,   15,  -15,     2,      1,    7,     7,         30    \ Vertex 6
 VERTEX  -43,  -39,   40,     3,      2,    8,     8,         31    \ Vertex 7
 VERTEX   43,  -39,   40,     4,      3,    9,     9,         31    \ Vertex 8
 VERTEX   69,   15,  -15,     5,      4,   10,    10,         30    \ Vertex 9
 VERTEX  -43,   53,  -23,    15,     15,   15,    15,         31    \ Vertex 10
 VERTEX  -69,   -1,   32,     7,      2,    8,     8,         31    \ Vertex 11
 VERTEX    0,    0,  254,    15,     15,   15,    15,         31    \ Vertex 12
 VERTEX   69,   -1,   32,     9,      4,   10,    10,         31    \ Vertex 13
 VERTEX   43,   53,  -23,    15,     15,   15,    15,         31    \ Vertex 14

\EDGE vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     1,     0,         30    \ Edge 0
 EDGE       1,       2,     2,     0,         30    \ Edge 1
 EDGE       2,       3,     3,     0,         30    \ Edge 2
 EDGE       3,       4,     4,     0,         30    \ Edge 3
 EDGE       0,       4,     5,     0,         30    \ Edge 4
 EDGE       0,       5,     5,     1,         29    \ Edge 5
 EDGE       1,       6,     2,     1,         29    \ Edge 6
 EDGE       2,       7,     3,     2,         29    \ Edge 7
 EDGE       3,       8,     4,     3,         29    \ Edge 8
 EDGE       4,       9,     5,     4,         29    \ Edge 9
 EDGE       5,      10,     6,     1,         30    \ Edge 10
 EDGE       6,      10,     7,     1,         30    \ Edge 11
 EDGE       6,      11,     7,     2,         30    \ Edge 12
 EDGE       7,      11,     8,     2,         30    \ Edge 13
 EDGE       7,      12,     8,     3,         31    \ Edge 14
 EDGE       8,      12,     9,     3,         31    \ Edge 15
 EDGE       8,      13,     9,     4,         30    \ Edge 16
 EDGE       9,      13,    10,     4,         30    \ Edge 17
 EDGE       9,      14,    10,     5,         30    \ Edge 18
 EDGE       5,      14,     6,     5,         30    \ Edge 19
 EDGE      10,      14,    11,     6,         30    \ Edge 20
 EDGE      10,      12,    11,     7,         31    \ Edge 21
 EDGE      11,      12,     8,     7,         31    \ Edge 22
 EDGE      12,      13,    10,     9,         31    \ Edge 23
 EDGE      12,      14,    11,    10,         31    \ Edge 24

\FACE normal_x, normal_y, normal_z, visibility
 FACE        0,      -51,      -49,         30    \ Face 0
 FACE      -51,       18,      -87,         30    \ Face 1
 FACE      -77,      -57,      -19,         30    \ Face 2
 FACE        0,      -90,       16,         31    \ Face 3
 FACE       77,      -57,      -19,         30    \ Face 4
 FACE       51,       18,      -87,         30    \ Face 5
 FACE        0,      111,      -20,         30    \ Face 6
 FACE      -97,       72,       24,         31    \ Face 7
 FACE     -108,      -68,       34,         31    \ Face 8
 FACE      108,      -68,       34,         31    \ Face 9
 FACE       97,       72,       24,         31    \ Face 10
 FACE        0,       94,       18,         31    \ Face 11
