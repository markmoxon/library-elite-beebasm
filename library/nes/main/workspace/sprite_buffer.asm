\ ******************************************************************************
\
\       Name: Sprite buffer
\       Type: Workspace
\    Address: &0200 to &02FF
\   Category: Workspaces
\    Summary: Configuration data for sprites 0 to 63, which gets copied to the
\             PPU to update the screen
\
\ ------------------------------------------------------------------------------
\
\ Each sprite has the following data associated with it:
\
\   * The sprite's screen coordinates in (x, y)
\
\   * The number of the pattern that is drawn on-screen for this sprite
\
\   * The sprite's attributes, which are:
\
\       * Bit 0-1: Palette to use when drawing the sprite (from sprite palettes
\                  0 to 3 at PPU addresses &3F11, &3F15, &3F19 and &3F1D)
\
\       * Bit 5: Priority (0 = in front of background, 1 = behind background)
\
\       * Bit 6: Flip horizontally (0 = no flip, 1 = flip)
\
\       * Bit 7: Flip vertically (0 = no flip, 1 = flip)
\
\ ******************************************************************************

 ORG &0200

.ySprite0

 SKIP 1                 \ Screen y-coordinate for sprite 0

.pattSprite0

 SKIP 1                 \ Pattern number for sprite 0

.attrSprite0

 SKIP 1                 \ Attributes for sprite 0

.xSprite0

 SKIP 1                 \ Screen x-coordinate for sprite 0

.ySprite1

 SKIP 1                 \ Screen y-coordinate for sprite 1

.pattSprite1

 SKIP 1                 \ Pattern number for sprite 1

.attrSprite1

 SKIP 1                 \ Attributes for sprite 1

.xSprite1

 SKIP 1                 \ Screen x-coordinate for sprite 1

.ySprite2

 SKIP 1                 \ Screen y-coordinate for sprite 2

.pattSprite2

 SKIP 1                 \ Pattern number for sprite 2

.attrSprite2

 SKIP 1                 \ Attributes for sprite 2

.xSprite2

 SKIP 1                 \ Screen x-coordinate for sprite 2

.ySprite3

 SKIP 1                 \ Screen y-coordinate for sprite 3

.pattSprite3

 SKIP 1                 \ Pattern number for sprite 3

.attrSprite3

 SKIP 1                 \ Attributes for sprite 3

.xSprite3

 SKIP 1                 \ Screen x-coordinate for sprite 3

.ySprite4

 SKIP 1                 \ Screen y-coordinate for sprite 4

.pattSprite4

 SKIP 1                 \ Pattern number for sprite 4

.attrSprite4

 SKIP 1                 \ Attributes for sprite 4

.xSprite4

 SKIP 1                 \ Screen x-coordinate for sprite 4

.ySprite5

 SKIP 1                 \ Screen y-coordinate for sprite 5

.pattSprite5

 SKIP 1                 \ Pattern number for sprite 5

.attrSprite5

 SKIP 1                 \ Attributes for sprite 5

.xSprite5

 SKIP 1                 \ Screen x-coordinate for sprite 5

.ySprite6

 SKIP 1                 \ Screen y-coordinate for sprite 6

.pattSprite6

 SKIP 1                 \ Pattern number for sprite 6

.attrSprite6

 SKIP 1                 \ Attributes for sprite 6

.xSprite6

 SKIP 1                 \ Screen x-coordinate for sprite 6

.ySprite7

 SKIP 1                 \ Screen y-coordinate for sprite 7

.pattSprite7

 SKIP 1                 \ Pattern number for sprite 7

.attrSprite7

 SKIP 1                 \ Attributes for sprite 7

.xSprite7

 SKIP 1                 \ Screen x-coordinate for sprite 7

.ySprite8

 SKIP 1                 \ Screen y-coordinate for sprite 8

.pattSprite8

 SKIP 1                 \ Pattern number for sprite 8

.attrSprite8

 SKIP 1                 \ Attributes for sprite 8

.xSprite8

 SKIP 1                 \ Screen x-coordinate for sprite 8

.ySprite9

 SKIP 1                 \ Screen y-coordinate for sprite 9

.pattSprite9

 SKIP 1                 \ Pattern number for sprite 9

.attrSprite9

 SKIP 1                 \ Attributes for sprite 9

.xSprite9

 SKIP 1                 \ Screen x-coordinate for sprite 9

.ySprite10

 SKIP 1                 \ Screen y-coordinate for sprite 10

.pattSprite10

 SKIP 1                 \ Pattern number for sprite 10

.attrSprite10

 SKIP 1                 \ Attributes for sprite 10

.xSprite10

 SKIP 1                 \ Screen x-coordinate for sprite 10

.ySprite11

 SKIP 1                 \ Screen y-coordinate for sprite 11

.pattSprite11

 SKIP 1                 \ Pattern number for sprite 11

.attrSprite11

 SKIP 1                 \ Attributes for sprite 11

.xSprite11

 SKIP 1                 \ Screen x-coordinate for sprite 11

.ySprite12

 SKIP 1                 \ Screen y-coordinate for sprite 12

.pattSprite12

 SKIP 1                 \ Pattern number for sprite 12

.attrSprite12

 SKIP 1                 \ Attributes for sprite 12

.xSprite12

 SKIP 1                 \ Screen x-coordinate for sprite 12

.ySprite13

 SKIP 1                 \ Screen y-coordinate for sprite 13

.pattSprite13

 SKIP 1                 \ Pattern number for sprite 13

.attrSprite13

 SKIP 1                 \ Attributes for sprite 13

.xSprite13

 SKIP 1                 \ Screen x-coordinate for sprite 13

.ySprite14

 SKIP 1                 \ Screen y-coordinate for sprite 14

.pattSprite14

 SKIP 1                 \ Pattern number for sprite 14

.attrSprite14

 SKIP 1                 \ Attributes for sprite 14

.xSprite14

 SKIP 1                 \ Screen x-coordinate for sprite 14

.ySprite15

 SKIP 1                 \ Screen y-coordinate for sprite 15

.pattSprite15

 SKIP 1                 \ Pattern number for sprite 15

.attrSprite15

 SKIP 1                 \ Attributes for sprite 15

.xSprite15

 SKIP 1                 \ Screen x-coordinate for sprite 15

.ySprite16

 SKIP 1                 \ Screen y-coordinate for sprite 16

.pattSprite16

 SKIP 1                 \ Pattern number for sprite 16

.attrSprite16

 SKIP 1                 \ Attributes for sprite 16

.xSprite16

 SKIP 1                 \ Screen x-coordinate for sprite 16

.ySprite17

 SKIP 1                 \ Screen y-coordinate for sprite 17

.pattSprite17

 SKIP 1                 \ Pattern number for sprite 17

.attrSprite17

 SKIP 1                 \ Attributes for sprite 17

.xSprite17

 SKIP 1                 \ Screen x-coordinate for sprite 17

.ySprite18

 SKIP 1                 \ Screen y-coordinate for sprite 18

.pattSprite18

 SKIP 1                 \ Pattern number for sprite 18

.attrSprite18

 SKIP 1                 \ Attributes for sprite 18

.xSprite18

 SKIP 1                 \ Screen x-coordinate for sprite 18

.ySprite19

 SKIP 1                 \ Screen y-coordinate for sprite 19

.pattSprite19

 SKIP 1                 \ Pattern number for sprite 19

.attrSprite19

 SKIP 1                 \ Attributes for sprite 19

.xSprite19

 SKIP 1                 \ Screen x-coordinate for sprite 19

.ySprite20

 SKIP 1                 \ Screen y-coordinate for sprite 20

.pattSprite20

 SKIP 1                 \ Pattern number for sprite 20

.attrSprite20

 SKIP 1                 \ Attributes for sprite 20

.xSprite20

 SKIP 1                 \ Screen x-coordinate for sprite 20

.ySprite21

 SKIP 1                 \ Screen y-coordinate for sprite 21

.pattSprite21

 SKIP 1                 \ Pattern number for sprite 21

.attrSprite21

 SKIP 1                 \ Attributes for sprite 21

.xSprite21

 SKIP 1                 \ Screen x-coordinate for sprite 21

.ySprite22

 SKIP 1                 \ Screen y-coordinate for sprite 22

.pattSprite22

 SKIP 1                 \ Pattern number for sprite 22

.attrSprite22

 SKIP 1                 \ Attributes for sprite 22

.xSprite22

 SKIP 1                 \ Screen x-coordinate for sprite 22

.ySprite23

 SKIP 1                 \ Screen y-coordinate for sprite 23

.pattSprite23

 SKIP 1                 \ Pattern number for sprite 23

.attrSprite23

 SKIP 1                 \ Attributes for sprite 23

.xSprite23

 SKIP 1                 \ Screen x-coordinate for sprite 23

.ySprite24

 SKIP 1                 \ Screen y-coordinate for sprite 24

.pattSprite24

 SKIP 1                 \ Pattern number for sprite 24

.attrSprite24

 SKIP 1                 \ Attributes for sprite 24

.xSprite24

 SKIP 1                 \ Screen x-coordinate for sprite 24

.ySprite25

 SKIP 1                 \ Screen y-coordinate for sprite 25

.pattSprite25

 SKIP 1                 \ Pattern number for sprite 25

.attrSprite25

 SKIP 1                 \ Attributes for sprite 25

.xSprite25

 SKIP 1                 \ Screen x-coordinate for sprite 25

.ySprite26

 SKIP 1                 \ Screen y-coordinate for sprite 26

.pattSprite26

 SKIP 1                 \ Pattern number for sprite 26

.attrSprite26

 SKIP 1                 \ Attributes for sprite 26

.xSprite26

 SKIP 1                 \ Screen x-coordinate for sprite 26

.ySprite27

 SKIP 1                 \ Screen y-coordinate for sprite 27

.pattSprite27

 SKIP 1                 \ Pattern number for sprite 27

.attrSprite27

 SKIP 1                 \ Attributes for sprite 27

.xSprite27

 SKIP 1                 \ Screen x-coordinate for sprite 27

.ySprite28

 SKIP 1                 \ Screen y-coordinate for sprite 28

.pattSprite28

 SKIP 1                 \ Pattern number for sprite 28

.attrSprite28

 SKIP 1                 \ Attributes for sprite 28

.xSprite28

 SKIP 1                 \ Screen x-coordinate for sprite 28

.ySprite29

 SKIP 1                 \ Screen y-coordinate for sprite 29

.pattSprite29

 SKIP 1                 \ Pattern number for sprite 29

.attrSprite29

 SKIP 1                 \ Attributes for sprite 29

.xSprite29

 SKIP 1                 \ Screen x-coordinate for sprite 29

.ySprite30

 SKIP 1                 \ Screen y-coordinate for sprite 30

.pattSprite30

 SKIP 1                 \ Pattern number for sprite 30

.attrSprite30

 SKIP 1                 \ Attributes for sprite 30

.xSprite30

 SKIP 1                 \ Screen x-coordinate for sprite 30

.ySprite31

 SKIP 1                 \ Screen y-coordinate for sprite 31

.pattSprite31

 SKIP 1                 \ Pattern number for sprite 31

.attrSprite31

 SKIP 1                 \ Attributes for sprite 31

.xSprite31

 SKIP 1                 \ Screen x-coordinate for sprite 31

.ySprite32

 SKIP 1                 \ Screen y-coordinate for sprite 32

.pattSprite32

 SKIP 1                 \ Pattern number for sprite 32

.attrSprite32

 SKIP 1                 \ Attributes for sprite 32

.xSprite32

 SKIP 1                 \ Screen x-coordinate for sprite 32

.ySprite33

 SKIP 1                 \ Screen y-coordinate for sprite 33

.pattSprite33

 SKIP 1                 \ Pattern number for sprite 33

.attrSprite33

 SKIP 1                 \ Attributes for sprite 33

.xSprite33

 SKIP 1                 \ Screen x-coordinate for sprite 33

.ySprite34

 SKIP 1                 \ Screen y-coordinate for sprite 34

.pattSprite34

 SKIP 1                 \ Pattern number for sprite 34

.attrSprite34

 SKIP 1                 \ Attributes for sprite 34

.xSprite34

 SKIP 1                 \ Screen x-coordinate for sprite 34

.ySprite35

 SKIP 1                 \ Screen y-coordinate for sprite 35

.pattSprite35

 SKIP 1                 \ Pattern number for sprite 35

.attrSprite35

 SKIP 1                 \ Attributes for sprite 35

.xSprite35

 SKIP 1                 \ Screen x-coordinate for sprite 35

.ySprite36

 SKIP 1                 \ Screen y-coordinate for sprite 36

.pattSprite36

 SKIP 1                 \ Pattern number for sprite 36

.attrSprite36

 SKIP 1                 \ Attributes for sprite 36

.xSprite36

 SKIP 1                 \ Screen x-coordinate for sprite 36

.ySprite37

 SKIP 1                 \ Screen y-coordinate for sprite 37

.pattSprite37

 SKIP 1                 \ Pattern number for sprite 37

.attrSprite37

 SKIP 1                 \ Attributes for sprite 37

.xSprite37

 SKIP 1                 \ Screen x-coordinate for sprite 37

.ySprite38

 SKIP 1                 \ Screen y-coordinate for sprite 38

.pattSprite38

 SKIP 1                 \ Pattern number for sprite 38

.attrSprite38

 SKIP 1                 \ Attributes for sprite 38

.xSprite38

 SKIP 1                 \ Screen x-coordinate for sprite 38

.ySprite39

 SKIP 1                 \ Screen y-coordinate for sprite 39

.pattSprite39

 SKIP 1                 \ Pattern number for sprite 39

.attrSprite39

 SKIP 1                 \ Attributes for sprite 39

.xSprite39

 SKIP 1                 \ Screen x-coordinate for sprite 39

.ySprite40

 SKIP 1                 \ Screen y-coordinate for sprite 40

.pattSprite40

 SKIP 1                 \ Pattern number for sprite 40

.attrSprite40

 SKIP 1                 \ Attributes for sprite 40

.xSprite40

 SKIP 1                 \ Screen x-coordinate for sprite 40

.ySprite41

 SKIP 1                 \ Screen y-coordinate for sprite 41

.pattSprite41

 SKIP 1                 \ Pattern number for sprite 41

.attrSprite41

 SKIP 1                 \ Attributes for sprite 41

.xSprite41

 SKIP 1                 \ Screen x-coordinate for sprite 41

.ySprite42

 SKIP 1                 \ Screen y-coordinate for sprite 42

.pattSprite42

 SKIP 1                 \ Pattern number for sprite 42

.attrSprite42

 SKIP 1                 \ Attributes for sprite 42

.xSprite42

 SKIP 1                 \ Screen x-coordinate for sprite 42

.ySprite43

 SKIP 1                 \ Screen y-coordinate for sprite 43

.pattSprite43

 SKIP 1                 \ Pattern number for sprite 43

.attrSprite43

 SKIP 1                 \ Attributes for sprite 43

.xSprite43

 SKIP 1                 \ Screen x-coordinate for sprite 43

.ySprite44

 SKIP 1                 \ Screen y-coordinate for sprite 44

.pattSprite44

 SKIP 1                 \ Pattern number for sprite 44

.attrSprite44

 SKIP 1                 \ Attributes for sprite 44

.xSprite44

 SKIP 1                 \ Screen x-coordinate for sprite 44

.ySprite45

 SKIP 1                 \ Screen y-coordinate for sprite 45

.pattSprite45

 SKIP 1                 \ Pattern number for sprite 45

.attrSprite45

 SKIP 1                 \ Attributes for sprite 45

.xSprite45

 SKIP 1                 \ Screen x-coordinate for sprite 45

.ySprite46

 SKIP 1                 \ Screen y-coordinate for sprite 46

.pattSprite46

 SKIP 1                 \ Pattern number for sprite 46

.attrSprite46

 SKIP 1                 \ Attributes for sprite 46

.xSprite46

 SKIP 1                 \ Screen x-coordinate for sprite 46

.ySprite47

 SKIP 1                 \ Screen y-coordinate for sprite 47

.pattSprite47

 SKIP 1                 \ Pattern number for sprite 47

.attrSprite47

 SKIP 1                 \ Attributes for sprite 47

.xSprite47

 SKIP 1                 \ Screen x-coordinate for sprite 47

.ySprite48

 SKIP 1                 \ Screen y-coordinate for sprite 48

.pattSprite48

 SKIP 1                 \ Pattern number for sprite 48

.attrSprite48

 SKIP 1                 \ Attributes for sprite 48

.xSprite48

 SKIP 1                 \ Screen x-coordinate for sprite 48

.ySprite49

 SKIP 1                 \ Screen y-coordinate for sprite 49

.pattSprite49

 SKIP 1                 \ Pattern number for sprite 49

.attrSprite49

 SKIP 1                 \ Attributes for sprite 49

.xSprite49

 SKIP 1                 \ Screen x-coordinate for sprite 49

.ySprite50

 SKIP 1                 \ Screen y-coordinate for sprite 50

.pattSprite50

 SKIP 1                 \ Pattern number for sprite 50

.attrSprite50

 SKIP 1                 \ Attributes for sprite 50

.xSprite50

 SKIP 1                 \ Screen x-coordinate for sprite 50

.ySprite51

 SKIP 1                 \ Screen y-coordinate for sprite 51

.pattSprite51

 SKIP 1                 \ Pattern number for sprite 51

.attrSprite51

 SKIP 1                 \ Attributes for sprite 51

.xSprite51

 SKIP 1                 \ Screen x-coordinate for sprite 51

.ySprite52

 SKIP 1                 \ Screen y-coordinate for sprite 52

.pattSprite52

 SKIP 1                 \ Pattern number for sprite 52

.attrSprite52

 SKIP 1                 \ Attributes for sprite 52

.xSprite52

 SKIP 1                 \ Screen x-coordinate for sprite 52

.ySprite53

 SKIP 1                 \ Screen y-coordinate for sprite 53

.pattSprite53

 SKIP 1                 \ Pattern number for sprite 53

.attrSprite53

 SKIP 1                 \ Attributes for sprite 53

.xSprite53

 SKIP 1                 \ Screen x-coordinate for sprite 53

.ySprite54

 SKIP 1                 \ Screen y-coordinate for sprite 54

.pattSprite54

 SKIP 1                 \ Pattern number for sprite 54

.attrSprite54

 SKIP 1                 \ Attributes for sprite 54

.xSprite54

 SKIP 1                 \ Screen x-coordinate for sprite 54

.ySprite55

 SKIP 1                 \ Screen y-coordinate for sprite 55

.pattSprite55

 SKIP 1                 \ Pattern number for sprite 55

.attrSprite55

 SKIP 1                 \ Attributes for sprite 55

.xSprite55

 SKIP 1                 \ Screen x-coordinate for sprite 55

.ySprite56

 SKIP 1                 \ Screen y-coordinate for sprite 56

.pattSprite56

 SKIP 1                 \ Pattern number for sprite 56

.attrSprite56

 SKIP 1                 \ Attributes for sprite 56

.xSprite56

 SKIP 1                 \ Screen x-coordinate for sprite 56

.ySprite57

 SKIP 1                 \ Screen y-coordinate for sprite 57

.pattSprite57

 SKIP 1                 \ Pattern number for sprite 57

.attrSprite57

 SKIP 1                 \ Attributes for sprite 57

.xSprite57

 SKIP 1                 \ Screen x-coordinate for sprite 57

.ySprite58

 SKIP 1                 \ Screen y-coordinate for sprite 58

.pattSprite58

 SKIP 1                 \ Pattern number for sprite 58

.attrSprite58

 SKIP 1                 \ Attributes for sprite 58

.xSprite58

 SKIP 1                 \ Screen x-coordinate for sprite 58

.ySprite59

 SKIP 1                 \ Screen y-coordinate for sprite 59

.pattSprite59

 SKIP 1                 \ Pattern number for sprite 59

.attrSprite59

 SKIP 1                 \ Attributes for sprite 59

.xSprite59

 SKIP 1                 \ Screen x-coordinate for sprite 59

.ySprite60

 SKIP 1                 \ Screen y-coordinate for sprite 60

.pattSprite60

 SKIP 1                 \ Pattern number for sprite 60

.attrSprite60

 SKIP 1                 \ Attributes for sprite 60

.xSprite60

 SKIP 1                 \ Screen x-coordinate for sprite 60

.ySprite61

 SKIP 1                 \ Screen y-coordinate for sprite 61

.pattSprite61

 SKIP 1                 \ Pattern number for sprite 61

.attrSprite61

 SKIP 1                 \ Attributes for sprite 61

.xSprite61

 SKIP 1                 \ Screen x-coordinate for sprite 61

.ySprite62

 SKIP 1                 \ Screen y-coordinate for sprite 62

.pattSprite62

 SKIP 1                 \ Pattern number for sprite 62

.attrSprite62

 SKIP 1                 \ Attributes for sprite 62

.xSprite62

 SKIP 1                 \ Screen x-coordinate for sprite 62

.ySprite63

 SKIP 1                 \ Screen y-coordinate for sprite 63

.pattSprite63

 SKIP 1                 \ Pattern number for sprite 63

.attrSprite63

 SKIP 1                 \ Attributes for sprite 63

.xSprite63

 SKIP 1                 \ Screen x-coordinate for sprite 63

