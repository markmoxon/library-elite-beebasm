\ ******************************************************************************
\
\ NES ELITE GAME SOURCE (BANK 0)
\
\ NES Elite was written by Ian Bell and David Braben and is copyright D. Braben
\ and I. Bell 1991/1992
\
\ The code on this site has been reconstructed from a disassembly of the version
\ released on Ian Bell's personal website at http://www.elitehomepage.org/
\
\ The commentary is copyright Mark Moxon, and any misunderstandings or mistakes
\ in the documentation are entirely my fault
\
\ The terminology and notations used in this commentary are explained at
\ https://www.bbcelite.com/about_site/terminology_used_in_this_commentary.html
\
\ The deep dive articles referred to in this commentary can be found at
\ https://www.bbcelite.com/deep_dives
\
\ ------------------------------------------------------------------------------
\
\ This source file produces the following binary file:
\
\   * bank0.bin
\
\ ******************************************************************************

 _BANK = 0

 INCLUDE "versions/nes/1-source-files/main-sources/elite-build-options.asm"

 _CASSETTE_VERSION      = (_VERSION = 1)
 _DISC_VERSION          = (_VERSION = 2)
 _6502SP_VERSION        = (_VERSION = 3)
 _MASTER_VERSION        = (_VERSION = 4)
 _ELECTRON_VERSION      = (_VERSION = 5)
 _ELITE_A_VERSION       = (_VERSION = 6)
 _NES_VERSION           = (_VERSION = 7)
 _C64_VERSION           = (_VERSION = 8)
 _APPLE_VERSION         = (_VERSION = 9)
 _DISC_DOCKED           = FALSE
 _DISC_FLIGHT           = FALSE
 _ELITE_A_DOCKED        = FALSE
 _ELITE_A_FLIGHT        = FALSE
 _ELITE_A_SHIPS_R       = FALSE
 _ELITE_A_SHIPS_S       = FALSE
 _ELITE_A_SHIPS_T       = FALSE
 _ELITE_A_SHIPS_U       = FALSE
 _ELITE_A_SHIPS_V       = FALSE
 _ELITE_A_SHIPS_W       = FALSE
 _ELITE_A_ENCYCLOPEDIA  = FALSE
 _ELITE_A_6502SP_IO     = FALSE
 _ELITE_A_6502SP_PARA   = FALSE

 INCLUDE "versions/nes/1-source-files/main-sources/elite-source-common.asm"

 INCLUDE "versions/nes/1-source-files/main-sources/elite-source-bank-7.asm"

\ ******************************************************************************
\
\ ELITE BANK 0
\
\ Produces the binary file bank0.bin.
\
\ ******************************************************************************

 CODE% = &8000
 LOAD% = &8000

 ORG CODE%

INCLUDE "library/nes/main/subroutine/resetmmc1.asm"
INCLUDE "library/nes/main/subroutine/interrupts.asm"
INCLUDE "library/nes/main/variable/version_number.asm"
INCLUDE "library/nes/main/subroutine/resetshipstatus.asm"
INCLUDE "library/enhanced/main/subroutine/doentry.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_4_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_5_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_6_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_7_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_8_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_9_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_10_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_11_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_12_of_16.asm"
INCLUDE "library/nes/main/subroutine/main-flight-loop-part-3a-of-16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_13_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_14_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_15_of_16.asm"
INCLUDE "library/nes/main/subroutine/main-flight-loop-part-16-of-16.asm"
INCLUDE "library/nes/main/subroutine/chargeshields.asm"
INCLUDE "library/nes/main/subroutine/checkaltitude.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_1_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_2_of_16.asm"
INCLUDE "library/common/main/subroutine/main_flight_loop_part_3_of_16.asm"
INCLUDE "library/enhanced/main/subroutine/spin.asm"
INCLUDE "library/nes/main/subroutine/hidehiddencolour.asm"
INCLUDE "library/advanced/main/variable/scacol.asm"
INCLUDE "library/nes/main/subroutine/setaxto15.asm"
INCLUDE "library/nes/main/subroutine/printcombatrank.asm"
INCLUDE "library/nes/main/subroutine/printlegalstatus.asm"
INCLUDE "library/common/main/subroutine/status.asm"
INCLUDE "library/nes/main/subroutine/updateview.asm"
INCLUDE "library/nes/main/variable/yheadshot.asm"
INCLUDE "library/nes/main/subroutine/drawscreeninnmi.asm"
INCLUDE "library/nes/main/subroutine/printtokencrtab.asm"
INCLUDE "library/nes/main/subroutine/printcrtab.asm"
INCLUDE "library/nes/main/variable/xstatusmode.asm"
INCLUDE "library/common/main/subroutine/mvt3.asm"
INCLUDE "library/common/main/subroutine/mvs5.asm"
INCLUDE "library/common/main/variable/tens.asm"
INCLUDE "library/common/main/subroutine/pr2.asm"
INCLUDE "library/common/main/subroutine/tt11.asm"
INCLUDE "library/common/main/subroutine/bprnt.asm"
INCLUDE "library/nes/main/subroutine/drawpitchrollbars.asm"
INCLUDE "library/common/main/subroutine/escape.asm"
INCLUDE "library/enhanced/main/subroutine/hme2.asm"
INCLUDE "library/common/main/subroutine/tactics_part_1_of_7.asm"
INCLUDE "library/common/main/subroutine/tactics_part_2_of_7.asm"
INCLUDE "library/common/main/subroutine/tactics_part_3_of_7.asm"
INCLUDE "library/common/main/subroutine/tactics_part_4_of_7.asm"
INCLUDE "library/common/main/subroutine/tactics_part_5_of_7.asm"
INCLUDE "library/common/main/subroutine/tactics_part_6_of_7.asm"
INCLUDE "library/common/main/subroutine/tactics_part_7_of_7.asm"
INCLUDE "library/enhanced/main/subroutine/dockit.asm"
INCLUDE "library/enhanced/main/subroutine/vcsu1.asm"
INCLUDE "library/enhanced/main/subroutine/vcsub.asm"
INCLUDE "library/common/main/subroutine/tas1.asm"
INCLUDE "library/enhanced/main/subroutine/tas4.asm"
INCLUDE "library/enhanced/main/subroutine/tas6.asm"
INCLUDE "library/enhanced/main/subroutine/dcs1.asm"
INCLUDE "library/common/main/subroutine/hitch.asm"
INCLUDE "library/common/main/subroutine/frs1.asm"
INCLUDE "library/common/main/subroutine/frmis.asm"
INCLUDE "library/common/main/subroutine/angry.asm"
INCLUDE "library/common/main/subroutine/fr1.asm"
INCLUDE "library/common/main/subroutine/sescp.asm"
INCLUDE "library/common/main/subroutine/sfs1.asm"
INCLUDE "library/common/main/subroutine/sfs2.asm"
INCLUDE "library/nes/main/subroutine/laun.asm"
INCLUDE "library/common/main/subroutine/lasli.asm"
INCLUDE "library/enhanced/main/subroutine/brief2.asm"
INCLUDE "library/enhanced/main/subroutine/brp.asm"
INCLUDE "library/enhanced/main/subroutine/brief3.asm"
INCLUDE "library/enhanced/main/subroutine/debrief2.asm"
INCLUDE "library/enhanced/main/subroutine/debrief.asm"
INCLUDE "library/advanced/main/subroutine/tbrief.asm"
INCLUDE "library/enhanced/main/subroutine/brief.asm"
INCLUDE "library/nes/main/subroutine/bris_b0.asm"
INCLUDE "library/common/main/subroutine/ping.asm"
INCLUDE "library/nes/main/subroutine/playdemo.asm"
INCLUDE "library/nes/main/subroutine/rundemoflightloop.asm"
INCLUDE "library/nes/main/subroutine/setupdemoship.asm"
INCLUDE "library/enhanced/main/subroutine/tnpr1.asm"
INCLUDE "library/common/main/subroutine/tnpr.asm"
INCLUDE "library/nes/main/subroutine/setnewviewtype.asm"
INCLUDE "library/common/main/subroutine/tt20.asm"
INCLUDE "library/common/main/subroutine/tt54.asm"
INCLUDE "library/common/main/subroutine/tt146.asm"
INCLUDE "library/common/main/subroutine/tt60.asm"
INCLUDE "library/common/main/subroutine/ttx69.asm"
INCLUDE "library/common/main/subroutine/tt69.asm"
INCLUDE "library/common/main/subroutine/tt67.asm"
INCLUDE "library/common/main/subroutine/tt70.asm"
INCLUDE "library/common/main/subroutine/spc.asm"
INCLUDE "library/nes/main/subroutine/printspaceandtoken.asm"
INCLUDE "library/nes/main/variable/xdataonsystem.asm"
INCLUDE "library/nes/main/subroutine/printtokenandcolon.asm"
INCLUDE "library/nes/main/variable/radiustext.asm"
INCLUDE "library/common/main/subroutine/tt25.asm"
INCLUDE "library/common/main/subroutine/tt22.asm"
INCLUDE "library/common/main/subroutine/tt15.asm"
INCLUDE "library/common/main/subroutine/tt14.asm"
INCLUDE "library/common/main/subroutine/tt128.asm"
INCLUDE "library/common/main/subroutine/tt210.asm"
INCLUDE "library/common/main/subroutine/tt213.asm"
INCLUDE "library/nes/main/subroutine/printcharacter.asm"
INCLUDE "library/common/main/subroutine/tt16.asm"
INCLUDE "library/nes/main/subroutine/tt103.asm"
INCLUDE "library/common/main/subroutine/tt123.asm"
INCLUDE "library/common/main/subroutine/tt105.asm"
INCLUDE "library/nes/main/subroutine/drawcrosshairs.asm"
INCLUDE "library/nes/main/subroutine/hidecrosshairs.asm"
INCLUDE "library/nes/main/variable/xshortrange.asm"
INCLUDE "library/common/main/subroutine/tt23.asm"
INCLUDE "library/nes/main/subroutine/drawchartsystem.asm"
INCLUDE "library/common/main/subroutine/tt81.asm"
INCLUDE "library/nes/main/subroutine/selectnearbysystem.asm"
INCLUDE "library/nes/main/subroutine/setselectedsystem.asm"
INCLUDE "library/nes/main/subroutine/setselectionflags.asm"
INCLUDE "library/nes/main/subroutine/setcurrentsystem.asm"
INCLUDE "library/common/main/subroutine/tt111.asm"
INCLUDE "library/common/main/subroutine/hy6-docked.asm"
INCLUDE "library/nes/main/subroutine/galactichyperdrive.asm"
INCLUDE "library/common/main/subroutine/hyp.asm"
INCLUDE "library/common/main/subroutine/ww.asm"
INCLUDE "library/common/main/subroutine/ghy.asm"
INCLUDE "library/common/main/subroutine/jmp.asm"
INCLUDE "library/common/main/subroutine/pr6.asm"
INCLUDE "library/common/main/subroutine/pr5.asm"
INCLUDE "library/common/main/subroutine/tt147.asm"
INCLUDE "library/common/main/subroutine/prq.asm"
INCLUDE "library/common/main/subroutine/tt151.asm"
INCLUDE "library/nes/main/subroutine/printspacedhyphen.asm"
INCLUDE "library/common/main/subroutine/tt152.asm"
INCLUDE "library/common/main/subroutine/tt162.asm"
INCLUDE "library/common/main/subroutine/tt160.asm"
INCLUDE "library/common/main/subroutine/tt161.asm"
INCLUDE "library/common/main/subroutine/tt16a.asm"
INCLUDE "library/common/main/subroutine/tt163.asm"
INCLUDE "library/nes/main/subroutine/printnumberinhold.asm"
INCLUDE "library/nes/main/variable/ymarketprice.asm"
INCLUDE "library/common/main/subroutine/tt167.asm"
INCLUDE "library/nes/main/subroutine/buyandsellcargo.asm"
INCLUDE "library/nes/main/subroutine/highlightsaleitem.asm"
INCLUDE "library/nes/main/subroutine/printmarketitem.asm"
INCLUDE "library/nes/main/subroutine/printcash.asm"
INCLUDE "library/nes/main/variable/xcash.asm"
INCLUDE "library/nes/main/variable/ycash.asm"
INCLUDE "library/common/main/subroutine/var.asm"
INCLUDE "library/common/main/subroutine/hyp1.asm"
INCLUDE "library/common/main/subroutine/gvl.asm"
INCLUDE "library/common/main/subroutine/gthg.asm"
INCLUDE "library/common/main/subroutine/mjp.asm"
INCLUDE "library/common/main/subroutine/tt18.asm"
INCLUDE "library/nes/main/subroutine/redrawcurrentview.asm"
INCLUDE "library/common/main/subroutine/tt110.asm"
INCLUDE "library/common/main/subroutine/tt114.asm"
INCLUDE "library/common/main/subroutine/lcash.asm"
INCLUDE "library/common/main/subroutine/mcash.asm"
INCLUDE "library/common/main/subroutine/gc2.asm"
INCLUDE "library/nes/main/subroutine/setupafterload.asm"
INCLUDE "library/nes/main/subroutine/drawcobramkiii.asm"
INCLUDE "library/nes/main/subroutine/highlightequipment.asm"
INCLUDE "library/nes/main/subroutine/printequipment.asm"
INCLUDE "library/nes/main/subroutine/moveequipmentup.asm"
INCLUDE "library/nes/main/subroutine/updateequipment.asm"
INCLUDE "library/nes/main/subroutine/moveequipmentdown.asm"
INCLUDE "library/nes/main/variable/xequipship.asm"
INCLUDE "library/common/main/subroutine/eqshp.asm"
INCLUDE "library/common/main/subroutine/dn.asm"
INCLUDE "library/common/main/subroutine/eq.asm"
INCLUDE "library/common/main/subroutine/prx.asm"
INCLUDE "library/nes/main/subroutine/printlaserview.asm"
INCLUDE "library/nes/main/variable/xlaserview.asm"
INCLUDE "library/nes/main/subroutine/highlightlaserview.asm"
INCLUDE "library/nes/main/variable/popupwidth.asm"
INCLUDE "library/nes/main/subroutine/qv.asm"
INCLUDE "library/enhanced/main/subroutine/refund.asm"
INCLUDE "library/common/main/variable/prxs.asm"
INCLUDE "library/nes/main/subroutine/setselectedseeds.asm"
INCLUDE "library/common/main/subroutine/cpl.asm"
INCLUDE "library/common/main/subroutine/cmn.asm"
INCLUDE "library/common/main/subroutine/ypl.asm"
INCLUDE "library/common/main/subroutine/tal.asm"
INCLUDE "library/common/main/subroutine/fwl.asm"
INCLUDE "library/nes/main/subroutine/print4spaces.asm"
INCLUDE "library/nes/main/subroutine/print2spaces.asm"
INCLUDE "library/nes/main/subroutine/ypls.asm"
INCLUDE "library/common/main/subroutine/csh.asm"
INCLUDE "library/common/main/subroutine/plf.asm"
INCLUDE "library/common/main/subroutine/tt68.asm"
INCLUDE "library/common/main/subroutine/tt73.asm"
INCLUDE "library/nes/main/subroutine/tals.asm"
INCLUDE "library/nes/main/subroutine/printctrlcode.asm"
INCLUDE "library/nes/main/subroutine/fwls.asm"
INCLUDE "library/common/main/subroutine/sos1.asm"
INCLUDE "library/common/main/subroutine/solar.asm"
INCLUDE "library/common/main/subroutine/nwstars.asm"
INCLUDE "library/common/main/subroutine/nwq.asm"
INCLUDE "library/common/main/subroutine/wpshps.asm"
INCLUDE "library/common/main/subroutine/shd.asm"
INCLUDE "library/common/main/subroutine/dengy.asm"
INCLUDE "library/common/main/subroutine/compas.asm"
INCLUDE "library/common/main/subroutine/sp1.asm"
INCLUDE "library/common/main/subroutine/sp2.asm"
INCLUDE "library/common/main/subroutine/sps4.asm"
INCLUDE "library/common/main/subroutine/oops.asm"
INCLUDE "library/common/main/subroutine/nwsps.asm"
INCLUDE "library/common/main/subroutine/nwshp.asm"
INCLUDE "library/common/main/subroutine/nws1.asm"
INCLUDE "library/common/main/subroutine/ks1.asm"
INCLUDE "library/common/main/subroutine/ks4.asm"
INCLUDE "library/common/main/subroutine/ks2.asm"
INCLUDE "library/nes/main/subroutine/removeship.asm"
INCLUDE "library/common/main/subroutine/killshp.asm"
INCLUDE "library/common/main/subroutine/abort.asm"
INCLUDE "library/common/main/subroutine/abort2.asm"
INCLUDE "library/nes/main/subroutine/yesno.asm"
INCLUDE "library/nes/main/subroutine/tt17.asm"
INCLUDE "library/enhanced/main/subroutine/there.asm"
INCLUDE "library/common/main/subroutine/reset.asm"
INCLUDE "library/common/main/subroutine/res2.asm"
INCLUDE "library/common/main/subroutine/zinf.asm"
INCLUDE "library/nes/main/subroutine/setscreenheight.asm"
INCLUDE "library/common/main/subroutine/msblob.asm"
INCLUDE "library/common/main/subroutine/main_game_loop_part_1_of_6.asm"
INCLUDE "library/common/main/subroutine/main_game_loop_part_2_of_6.asm"
INCLUDE "library/common/main/subroutine/main_game_loop_part_3_of_6.asm"
INCLUDE "library/common/main/subroutine/main_game_loop_part_4_of_6.asm"
INCLUDE "library/common/main/subroutine/main_game_loop_part_5_of_6.asm"
INCLUDE "library/common/main/subroutine/main_game_loop_part_6_of_6.asm"
INCLUDE "library/nes/main/variable/trumblesounds.asm"
INCLUDE "library/common/main/subroutine/tt102.asm"
INCLUDE "library/common/main/subroutine/bad.asm"
INCLUDE "library/nes/main/subroutine/farof.asm"
INCLUDE "library/common/main/subroutine/mas4.asm"
INCLUDE "library/nes/main/subroutine/checkforpause.asm"
INCLUDE "library/common/main/subroutine/death.asm"
INCLUDE "library/nes/main/subroutine/showstartscreen.asm"
INCLUDE "library/nes/main/subroutine/death2.asm"
INCLUDE "library/nes/main/subroutine/startgame.asm"
INCLUDE "library/common/main/subroutine/bay.asm"
INCLUDE "library/common/main/subroutine/br1_part_2_of_2.asm"
INCLUDE "library/nes/main/subroutine/changetoview.asm"
INCLUDE "library/common/main/subroutine/title.asm"
INCLUDE "library/common/main/subroutine/zero.asm"
INCLUDE "library/common/main/subroutine/u_per_cent-zektran.asm"
INCLUDE "library/common/main/subroutine/mas1.asm"
INCLUDE "library/common/main/subroutine/mas2.asm"
INCLUDE "library/common/main/subroutine/mas3.asm"
INCLUDE "library/nes/main/subroutine/spawnspacestation.asm"
INCLUDE "library/common/main/subroutine/sps2.asm"
INCLUDE "library/common/main/subroutine/sps3.asm"
INCLUDE "library/common/main/subroutine/sps1.asm"
INCLUDE "library/common/main/subroutine/tas2.asm"
INCLUDE "library/nes/main/subroutine/warp.asm"
INCLUDE "library/nes/main/subroutine/fastforwardjump.asm"
INCLUDE "library/nes/main/subroutine/checkjumpsafety.asm"
INCLUDE "library/nes/main/subroutine/insystemjump.asm"
INCLUDE "library/common/main/subroutine/dokey.asm"
INCLUDE "library/nes/main/subroutine/printmessage.asm"
INCLUDE "library/common/main/subroutine/mess.asm"
INCLUDE "library/common/main/subroutine/mes9.asm"
INCLUDE "library/nes/main/subroutine/storemessage.asm"
INCLUDE "library/nes/main/subroutine/disablejustifytext.asm"
INCLUDE "library/nes/main/subroutine/printflightmessage.asm"
INCLUDE "library/common/main/subroutine/ouch.asm"
INCLUDE "library/common/main/subroutine/ou2.asm"
INCLUDE "library/common/main/subroutine/ou3.asm"
INCLUDE "library/common/main/variable/qq23.asm"
INCLUDE "library/enhanced/main/subroutine/pas1.asm"
INCLUDE "library/common/main/subroutine/mveit_part_1_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_2_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_3_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_4_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_5_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_6_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_7_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_8_of_9.asm"
INCLUDE "library/common/main/subroutine/mveit_part_9_of_9.asm"
INCLUDE "library/common/main/subroutine/mvt1.asm"
INCLUDE "library/common/main/subroutine/mvs4.asm"
INCLUDE "library/common/main/subroutine/mvt6.asm"
INCLUDE "library/common/main/subroutine/mv40.asm"
INCLUDE "library/common/main/subroutine/plut-pu1.asm"
INCLUDE "library/common/main/subroutine/look1.asm"
INCLUDE "library/common/main/subroutine/flip.asm"
INCLUDE "library/nes/main/subroutine/sendspaceviewtoppu.asm"
INCLUDE "library/nes/main/subroutine/setspaceviewinnmi.asm"
INCLUDE "library/nes/main/subroutine/resetstardust.asm"
INCLUDE "library/nes/main/subroutine/setupspaceview.asm"
INCLUDE "library/common/main/subroutine/ecmof.asm"
INCLUDE "library/common/main/subroutine/sfrmis.asm"
INCLUDE "library/common/main/subroutine/exno2.asm"
INCLUDE "library/nes/main/variable/explosionsounds.asm"
INCLUDE "library/common/main/subroutine/exno.asm"
INCLUDE "library/nes/main/subroutine/tt66.asm"
INCLUDE "library/nes/main/subroutine/printspaceviewname.asm"
INCLUDE "library/nes/main/variable/vectors.asm"

\ ******************************************************************************
\
\ Save bank0.bin
\
\ ******************************************************************************

 PRINT "S.bank0.bin ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
 SAVE "versions/nes/3-assembled-output/bank0.bin", CODE%, P%, LOAD%
