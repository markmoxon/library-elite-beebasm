\ ******************************************************************************
\
\       Name: FACE
\       Type: Macro
\   Category: Drawing ships
\    Summary: Macro definition for adding faces to ship blueprints
\
\ ------------------------------------------------------------------------------
\
\ The following macro is used to build the ship blueprints:
\
\   FACE normal_x, normal_y, normal_z, visibility
\
\ See the deep dive on "Ship blueprints" for details of how faces are stored
\ in ship blueprints.
\
\ ******************************************************************************

MACRO FACE normal_x, normal_y, normal_z, visibility
  IF normal_x < 0
    s_x = 1 << 7
  ELSE
    s_x = 0
  ENDIF
  IF normal_y < 0
    s_y = 1 << 6
  ELSE
    s_y = 0
  ENDIF
  IF normal_z < 0
    s_z = 1 << 5
  ELSE
    s_z = 0
  ENDIF
  s = s_x + s_y + s_z + visibility
  ax = ABS(normal_x)
  ay = ABS(normal_y)
  az = ABS(normal_z)
  EQUB s, ax, ay, az
ENDMACRO

