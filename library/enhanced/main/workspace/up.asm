\ ******************************************************************************
\
\       Name: UP
\       Type: Workspace
IF _DISC_VERSION OR _ELITE_A_VERSION \ Comment
\    Address: &0300 to &03CF
ELIF _6502SP_VERSION
\    Address: &0800 to &0974
ENDIF
\   Category: Workspaces
IF _DISC_VERSION OR _ELITE_A_VERSION OR _6502SP_VERSION \ Comment
\    Summary: Ship slots, variables
ELIF _MASTER_VERSION
\    Summary: Configuration variables
ENDIF
\
\ ******************************************************************************

IF _DISC_VERSION OR _ELITE_A_VERSION \ Platform

 ORG &0300

ELIF _6502SP_VERSION

 ORG &0800

.UP

 SKIP 0                 \ The start of the UP workspace

\.QQ16

 SKIP 65                \ This QQ16 label is present in the original source, but
                        \ it is overridden by the QQ16 label in the Elite A
                        \ section, so this declaration has no effect. BeebAsm
                        \ does not allow labels to be defined twice, so this one
                        \ is commented out

ENDIF

IF _DISC_VERSION OR _6502SP_VERSION OR _ELITE_A_VERSION \ Platform

INCLUDE "library/common/main/variable/kl.asm"
INCLUDE "library/common/main/variable/ky1.asm"
INCLUDE "library/common/main/variable/ky2.asm"
INCLUDE "library/common/main/variable/ky3.asm"
INCLUDE "library/common/main/variable/ky4.asm"
INCLUDE "library/common/main/variable/ky5.asm"
INCLUDE "library/common/main/variable/ky6.asm"
INCLUDE "library/common/main/variable/ky7.asm"
INCLUDE "library/common/main/variable/ky12.asm"
INCLUDE "library/common/main/variable/ky13.asm"
INCLUDE "library/common/main/variable/ky14.asm"
INCLUDE "library/common/main/variable/ky15.asm"
INCLUDE "library/common/main/variable/ky16.asm"
INCLUDE "library/common/main/variable/ky17.asm"
INCLUDE "library/common/main/variable/ky18.asm"
INCLUDE "library/common/main/variable/ky19.asm"
INCLUDE "library/enhanced/main/variable/ky20.asm"
INCLUDE "library/common/main/variable/frin.asm"
INCLUDE "library/common/main/variable/many.asm"
INCLUDE "library/common/main/variable/sspr.asm"
INCLUDE "library/enhanced/main/variable/junk.asm"
INCLUDE "library/enhanced/main/variable/auto.asm"
INCLUDE "library/common/main/variable/ecmp.asm"
INCLUDE "library/common/main/variable/mj.asm"
INCLUDE "library/common/main/variable/cabtmp.asm"
INCLUDE "library/common/main/variable/las2.asm"
INCLUDE "library/common/main/variable/msar.asm"
INCLUDE "library/common/main/variable/view.asm"
INCLUDE "library/common/main/variable/lasct.asm"
INCLUDE "library/common/main/variable/gntmp.asm"
INCLUDE "library/common/main/variable/hfx.asm"
INCLUDE "library/common/main/variable/ev.asm"
INCLUDE "library/common/main/variable/dly.asm"
INCLUDE "library/common/main/variable/de.asm"
INCLUDE "library/common/main/variable/jstx.asm"
INCLUDE "library/common/main/variable/jsty.asm"
INCLUDE "library/common/main/variable/xsav2.asm"
INCLUDE "library/common/main/variable/ysav2.asm"
INCLUDE "library/advanced/main/variable/name.asm"
INCLUDE "library/common/main/variable/tp.asm"
INCLUDE "library/common/main/variable/qq0.asm"
INCLUDE "library/common/main/variable/qq1.asm"
INCLUDE "library/common/main/variable/qq21.asm"
INCLUDE "library/common/main/variable/cash.asm"
INCLUDE "library/common/main/variable/qq14.asm"
INCLUDE "library/common/main/variable/cok.asm"
INCLUDE "library/common/main/variable/gcnt.asm"
INCLUDE "library/common/main/variable/laser.asm"

ENDIF

IF _DISC_VERSION OR _6502SP_VERSION \ Platform

 SKIP 2                 \ These bytes appear to be unused (they were originally
                        \ used for up/down lasers, but they were dropped)

ELIF _ELITE_A_VERSION

INCLUDE "library/elite-a/main/variable/cmdr_type.asm"

ENDIF

IF _DISC_VERSION OR _6502SP_VERSION OR _ELITE_A_VERSION \ Platform

INCLUDE "library/common/main/variable/crgo.asm"
INCLUDE "library/common/main/variable/qq20.asm"
INCLUDE "library/common/main/variable/ecm.asm"
INCLUDE "library/common/main/variable/bst.asm"
INCLUDE "library/common/main/variable/bomb.asm"
INCLUDE "library/common/main/variable/engy.asm"
INCLUDE "library/common/main/variable/dkcmp.asm"
INCLUDE "library/common/main/variable/ghyp.asm"
INCLUDE "library/common/main/variable/escp.asm"

ENDIF

IF _DISC_VERSION OR _6502SP_VERSION \ Platform

 SKIP 4                 \ These bytes appear to be unused

ELIF _ELITE_A_VERSION

INCLUDE "library/elite-a/main/variable/cmdr_cour.asm"
INCLUDE "library/elite-a/main/variable/cmdr_courx.asm"
INCLUDE "library/elite-a/main/variable/cmdr_coury.asm"

ENDIF

IF _DISC_VERSION OR _6502SP_VERSION OR _ELITE_A_VERSION \ Platform

INCLUDE "library/common/main/variable/nomsl.asm"
INCLUDE "library/common/main/variable/fist.asm"
INCLUDE "library/common/main/variable/avl.asm"
INCLUDE "library/common/main/variable/qq26.asm"
INCLUDE "library/common/main/variable/tally.asm"
INCLUDE "library/common/main/variable/svc.asm"
INCLUDE "library/common/main/variable/mch.asm"
INCLUDE "library/common/main/variable/fsh.asm"
INCLUDE "library/common/main/variable/ash.asm"
INCLUDE "library/common/main/variable/energy.asm"
INCLUDE "library/common/main/variable/comx.asm"
INCLUDE "library/common/main/variable/comy.asm"
INCLUDE "library/common/main/variable/qq24.asm"
INCLUDE "library/common/main/variable/qq25.asm"
INCLUDE "library/common/main/variable/qq28.asm"
INCLUDE "library/common/main/variable/qq29.asm"
INCLUDE "library/common/main/variable/gov.asm"
INCLUDE "library/common/main/variable/tek.asm"
INCLUDE "library/common/main/variable/slsp.asm"
INCLUDE "library/common/main/variable/qq2.asm"
INCLUDE "library/common/main/variable/qq3.asm"
INCLUDE "library/common/main/variable/qq4.asm"
INCLUDE "library/common/main/variable/qq5.asm"
INCLUDE "library/common/main/variable/qq6.asm"
INCLUDE "library/common/main/variable/qq7.asm"
INCLUDE "library/common/main/variable/qq8.asm"
INCLUDE "library/common/main/variable/qq9.asm"
INCLUDE "library/common/main/variable/qq10.asm"
INCLUDE "library/common/main/variable/nostm.asm"

ENDIF

IF _DISC_VERSION OR _ELITE_A_VERSION \ Platform

 SKIP 1                 \ This byte appears to be unused

INCLUDE "library/common/main/variable/comc.asm"
INCLUDE "library/common/main/variable/dnoiz.asm"
INCLUDE "library/common/main/variable/damp.asm"
INCLUDE "library/common/main/variable/djd.asm"
INCLUDE "library/common/main/variable/patg.asm"
INCLUDE "library/common/main/variable/flh.asm"
INCLUDE "library/common/main/variable/jstgy.asm"
INCLUDE "library/common/main/variable/jste.asm"
INCLUDE "library/common/main/variable/jstk.asm"
INCLUDE "library/enhanced/main/variable/bstk.asm"
INCLUDE "library/enhanced/main/variable/catf.asm"

ELIF _6502SP_VERSION

INCLUDE "library/advanced/main/variable/buf.asm"

 PRINT "UP workspace from  ", ~UP," to ", ~P%

ELIF _MASTER_VERSION

INCLUDE "library/common/main/variable/comc.asm"

.dials

 EQUD 0                 \ These bytes appear to be unused
 EQUD 0
 EQUD 0
 EQUW 0

.mscol

 EQUD 0                 \ This byte appears to be unused

INCLUDE "library/enhanced/main/variable/catf.asm"

.DFLAG

 EQUB 0                 \ This byte appears to be unused

INCLUDE "library/common/main/variable/dnoiz.asm"
INCLUDE "library/common/main/variable/damp.asm"
INCLUDE "library/common/main/variable/djd.asm"
INCLUDE "library/common/main/variable/patg.asm"
INCLUDE "library/common/main/variable/flh.asm"
INCLUDE "library/common/main/variable/jstgy.asm"
INCLUDE "library/common/main/variable/jste.asm"
INCLUDE "library/common/main/variable/jstk.asm"
INCLUDE "library/master/main/variable/uptog.asm"
INCLUDE "library/master/main/variable/disk.asm"
INCLUDE "library/enhanced/main/variable/bstk.asm"

 SKIP 1                 \ This byte appears to be unused

INCLUDE "library/master/main/variable/vol.asm"

ENDIF

IF _ELITE_A_VERSION

INCLUDE "library/elite-a/main/variable/new_pulse.asm"
INCLUDE "library/elite-a/main/variable/new_beam.asm"
INCLUDE "library/elite-a/main/variable/new_military.asm"
INCLUDE "library/elite-a/main/variable/new_mining.asm"
INCLUDE "library/elite-a/main/variable/new_mounts.asm"
INCLUDE "library/elite-a/main/variable/new_missiles.asm"
INCLUDE "library/elite-a/main/variable/new_shields.asm"
INCLUDE "library/elite-a/main/variable/new_energy.asm"
INCLUDE "library/elite-a/main/variable/new_speed.asm"
INCLUDE "library/elite-a/main/variable/new_hold.asm"
INCLUDE "library/elite-a/main/variable/new_range.asm"
INCLUDE "library/elite-a/main/variable/new_costs.asm"
INCLUDE "library/elite-a/main/variable/new_max.asm"
INCLUDE "library/elite-a/main/variable/new_min.asm"
INCLUDE "library/elite-a/main/variable/new_space.asm"

ENDIF

