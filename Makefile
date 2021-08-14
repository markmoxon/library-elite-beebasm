BEEBASM?=beebasm
PYTHON?=python

# Cassette version

# You can set the release that gets built by adding 'release=<rel>' to
# the make command, where <rel> is one of:
#
#   source-disc
#   text-sources
#
# So, for example:
#
#   make encrypt verify release=text-sources
#
# will build the version from the text sources on Ian Bell's site. If you
# omit the release parameter, it will build the source disc version.

ifeq ($(release-cassette), text-sources)
  rel-cassette=2
  folder-cassette=/text-sources
  suffix-cassette=-from-text-sources
else
  rel-cassette=1
  folder-cassette=/source-disc
  suffix-cassette=-from-source-disc
endif

# 6502 Second Processor version

# You can set the release that gets built by adding 'release-6502sp=<rel>' to
# the make command, where <rel> is one of:
#
#   source-disc
#   sng45
#   executive
#
# So, for example:
#
#   make encrypt verify release-6502sp=executive
#
# will build the Executive version. If you omit the release-6502sp parameter,
# it will build the SNG45 version.

ifeq ($(release-6502sp), source-disc)
  rel-6502sp=1
  folder-6502sp=/source-disc
  suffix-6502sp=-from-source-disc
else ifeq ($(release-6502sp), executive)
  rel-6502sp=3
  folder-6502sp=/executive
  suffix-6502sp=-executive
else
  rel-6502sp=2
  folder-6502sp=/sng45
  suffix-6502sp=-sng45
endif

# Disc version

# You can set the release that gets built by adding 'release-disc=<rel>' to
# the make command, where <rel> is one of:
#
#   ib-disc
#   sth
#
# So, for example:
#
#   make encrypt verify release-disc=ib-disc
#
# will build the version from the game disc on Ian Bell's site. If you omit
# the release-disc parameter, it will build the Stairway to Hell version.

ifeq ($(release-disc), ib-disc)
  rel-disc=1
  folder-disc=/ib-disc
  suffix-disc=-ib-disc
else
  rel-disc=2
  folder-disc=/sth
  suffix-disc=-sth
endif

# Master version

# You can set the release that gets built by adding 'release-master=<rel>' to
# the make command, where <rel> is one of:
#
#   sng47
#   compact
#
# So, for example:
#
#   make encrypt verify release-master=compact
#
# will build the Master Compact version. If you omit the release-master
# parameter, it will build the SNG47 version.

ifeq ($(release-master), compact)
  rel-master=2
  folder-master=/compact
  suffix-master=-compact
  boot-master=-opt 2
else
  rel-master=1
  folder-master=/sng47
  suffix-master=-sng47
  boot-master=-boot M128Elt
endif

# Electron version

rel-electron=1
folder-electron=/sth
suffix-electron=-sth

# Elite-A

# You can set the release that gets built by adding 'release=<rel>' to
# the make command, where <rel> is one of:
#
#   released
#   patched
#
# So, for example:
#
#   make encrypt verify release=patched
#
# will build the patched version. If you omit the release parameter,
# it will build the released version.

ifeq ($(release-elite-a), source-disc)
  rel-elite-a=2
  folder-elite-a=/source-disc
  suffix-elite-a=-from-source-disc
else
  rel-elite-a=1
  folder-elite-a=/released
  suffix-elite-a=-released
endif

# The following variables are written into elite-header.h.asm so they can be
# passed to BeebAsm:
#
# _REMOVE_CHECKSUMS
#   TRUE  = Disable checksums, max commander
#   FALSE = Enable checksums, standard commander
#
# _MATCH_EXTRACTED_BINARIES (for disc, 6502SP, Master versions)
#   TRUE  = Match binaries to release version (i.e. fill workspaces with noise)
#   FALSE = Zero-fill workspaces
#
# _VERSION
#   1 = BBC Micro cassette
#   2 = BBC Micro disc
#   3 = BBC Micro with 6502 Second Processor
#	4 = BBC Master
#	5 = Electron
#   6 = Elite-A
#
# _RELEASE (for cassette version)
#   1 = Source disc (default)
#
# _RELEASE (for disc version)
#   1 = Ian Bell's game disc
#   2 = Stairway to Hell version (default)
#
# _RELEASE (for 6502SP version)
#   1 = Source disc
#   2 = SNG45 (default)
#	3 = Executive version
#
# _RELEASE (for Master version)
#   1 = SNG47 (default)
#
# _RELEASE (for Electron version)
#   1 = Stairway to Hell version (default)
#
# _RELEASE (for Elite-A)
#   1 = Released version (default)
#   2 = Source disc
#

.PHONY:build
build:
	echo _VERSION=1 > versions/cassette/sources/elite-header.h.asm
	echo _RELEASE=$(rel-cassette) >> versions/cassette/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=TRUE >> versions/cassette/sources/elite-header.h.asm
	$(BEEBASM) -i versions/cassette/sources/elite-source.asm -v > versions/cassette/output/compile.txt
	$(BEEBASM) -i versions/cassette/sources/elite-bcfs.asm -v >> versions/cassette/output/compile.txt
	$(BEEBASM) -i versions/cassette/sources/elite-loader.asm -v >> versions/cassette/output/compile.txt
	$(PYTHON) versions/cassette/sources/elite-checksum.py -u -rel$(rel-cassette)
	$(BEEBASM) -i versions/cassette/sources/elite-disc.asm -do versions/cassette/elite-cassette$(suffix-cassette).ssd -boot ELTdata

	echo _VERSION=2 > versions/disc/sources/elite-header.h.asm
	echo _RELEASE=$(rel-disc) >> versions/disc/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=TRUE >> versions/disc/sources/elite-header.h.asm
	echo _MATCH_EXTRACTED_BINARIES=FALSE >> versions/disc/sources/elite-header.h.asm
	$(BEEBASM) -i versions/disc/sources/elite-text-tokens.asm -v > versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-missile.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-loader1.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-loader2.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-loader3.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-source-flight.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-source-docked.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-a.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-b.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-c.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-d.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-e.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-f.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-g.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-h.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-i.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-j.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-k.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-l.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-m.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-n.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-o.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-p.asm -v >> versions/disc/output/compile.txt
	$(PYTHON) versions/disc/sources/elite-checksum.py -u -rel$(rel-disc)
	$(BEEBASM) -i versions/disc/sources/elite-disc.asm -do versions/disc/elite-disc$(suffix-disc).ssd -boot ELITE2

	echo _VERSION=3 > versions/6502sp/sources/elite-header.h.asm
	echo _RELEASE=$(rel-6502sp) >> versions/6502sp/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=TRUE >> versions/6502sp/sources/elite-header.h.asm
	echo _MATCH_EXTRACTED_BINARIES=FALSE >> versions/6502sp/sources/elite-header.h.asm
	$(BEEBASM) -i versions/6502sp/sources/elite-source.asm -v > versions/6502sp/output/compile.txt
	$(BEEBASM) -i versions/6502sp/sources/elite-bcfs.asm -v >> versions/6502sp/output/compile.txt
	$(BEEBASM) -i versions/6502sp/sources/elite-z.asm -v >> versions/6502sp/output/compile.txt
	$(BEEBASM) -i versions/6502sp/sources/elite-loader1.asm -v >> versions/6502sp/output/compile.txt
	$(BEEBASM) -i versions/6502sp/sources/elite-loader2.asm -v >> versions/6502sp/output/compile.txt
	$(PYTHON) versions/6502sp/sources/elite-checksum.py -u -rel$(rel-6502sp)
	$(BEEBASM) -i versions/6502sp/sources/elite-disc.asm -do versions/6502sp/elite-6502sp$(suffix-6502sp).ssd -boot ELITE

	echo _VERSION=4 > versions/master/sources/elite-header.h.asm
	echo _RELEASE=$(rel-master) >> versions/master/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=TRUE >> versions/master/sources/elite-header.h.asm
	echo _MATCH_EXTRACTED_BINARIES=FALSE >> versions/master/sources/elite-header.h.asm
	$(BEEBASM) -i versions/master/sources/elite-loader.asm -v >> versions/master/output/compile.txt
	$(BEEBASM) -i versions/master/sources/elite-data.asm -v >> versions/master/output/compile.txt
	$(BEEBASM) -i versions/master/sources/elite-source.asm -v >> versions/master/output/compile.txt
	$(PYTHON) versions/master/sources/elite-checksum.py -u -rel$(rel-master)
	$(BEEBASM) -i versions/master/sources/elite-disc.asm $(boot-master) -do versions/master/elite-master$(suffix-master).ssd

	echo _VERSION=5 > versions/electron/sources/elite-header.h.asm
	echo _RELEASE=$(rel-electron) >> versions/electron/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=TRUE >> versions/electron/sources/elite-header.h.asm
	$(BEEBASM) -i versions/electron/sources/elite-source.asm -v > versions/electron/output/compile.txt
	$(BEEBASM) -i versions/electron/sources/elite-bcfs.asm -v >> versions/electron/output/compile.txt
	$(BEEBASM) -i versions/electron/sources/elite-loader.asm -v >> versions/electron/output/compile.txt
	$(PYTHON) versions/electron/sources/elite-checksum.py -u -rel$(rel-electron)
	$(BEEBASM) -i versions/electron/sources/elite-disc.asm -do versions/electron/elite-electron$(suffix-electron).ssd -opt 3

	echo _VERSION=6 > versions/elite-a/sources/elite-header.h.asm
	echo _RELEASE=$(rel-elite-a) >> versions/elite-a/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/elite-a/sources/elite-header.h.asm
	echo _MATCH_EXTRACTED_BINARIES=TRUE >> versions/elite-a/sources/elite-header.h.asm
	$(BEEBASM) -i versions/elite-a/sources/elite-text-tokens.asm -v > versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-missile.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-source-docked.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-source-flight.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-source-encyclopedia.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-6502sp-parasite.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-6502sp-io-processor.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-loader.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-a.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-b.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-c.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-d.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-e.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-f.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-g.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-h.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-i.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-j.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-k.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-l.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-m.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-n.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-o.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-p.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-q.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-r.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-s.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-t.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-u.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-v.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-w.asm -v >> versions/elite-a/output/compile.txt
	$(PYTHON) versions/elite-a/sources/elite-checksum.py -u -rel$(rel-elite-a)
	$(BEEBASM) -i versions/elite-a/sources/elite-disc.asm -do versions/elite-a/elite-a$(suffix-elite-a).ssd -opt 3

.PHONY:encrypt
encrypt:
	echo _VERSION=1 > versions/cassette/sources/elite-header.h.asm
	echo _RELEASE=$(rel-cassette) >> versions/cassette/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/cassette/sources/elite-header.h.asm
	$(BEEBASM) -i versions/cassette/sources/elite-source.asm -v > versions/cassette/output/compile.txt
	$(BEEBASM) -i versions/cassette/sources/elite-bcfs.asm -v >> versions/cassette/output/compile.txt
	$(BEEBASM) -i versions/cassette/sources/elite-loader.asm -v >> versions/cassette/output/compile.txt
	$(PYTHON) versions/cassette/sources/elite-checksum.py -rel$(rel-cassette)
	$(BEEBASM) -i versions/cassette/sources/elite-disc.asm -do versions/cassette/elite-cassette$(suffix-cassette).ssd -boot ELTdata

	echo _VERSION=2 > versions/disc/sources/elite-header.h.asm
	echo _RELEASE=$(rel-disc) >> versions/disc/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/disc/sources/elite-header.h.asm
	echo _MATCH_EXTRACTED_BINARIES=TRUE >> versions/disc/sources/elite-header.h.asm
	$(BEEBASM) -i versions/disc/sources/elite-text-tokens.asm -v > versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-missile.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-loader1.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-loader2.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-loader3.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-source-flight.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-source-docked.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-a.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-b.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-c.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-d.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-e.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-f.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-g.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-h.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-i.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-j.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-k.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-l.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-m.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-n.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-o.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-p.asm -v >> versions/disc/output/compile.txt
	$(PYTHON) versions/disc/sources/elite-checksum.py -rel$(rel-disc)
	$(BEEBASM) -i versions/disc/sources/elite-disc.asm -do versions/disc/elite-disc$(suffix-disc).ssd -boot ELITE2

	echo _VERSION=3 > versions/6502sp/sources/elite-header.h.asm
	echo _RELEASE=$(rel-6502sp) >> versions/6502sp/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/6502sp/sources/elite-header.h.asm
	echo _MATCH_EXTRACTED_BINARIES=TRUE >> versions/6502sp/sources/elite-header.h.asm
	$(BEEBASM) -i versions/6502sp/sources/elite-source.asm -v > versions/6502sp/output/compile.txt
	$(BEEBASM) -i versions/6502sp/sources/elite-bcfs.asm -v >> versions/6502sp/output/compile.txt
	$(BEEBASM) -i versions/6502sp/sources/elite-z.asm -v >> versions/6502sp/output/compile.txt
	$(BEEBASM) -i versions/6502sp/sources/elite-loader1.asm -v >> versions/6502sp/output/compile.txt
	$(BEEBASM) -i versions/6502sp/sources/elite-loader2.asm -v >> versions/6502sp/output/compile.txt
	$(PYTHON) versions/6502sp/sources/elite-checksum.py -rel$(rel-6502sp)
	$(BEEBASM) -i versions/6502sp/sources/elite-disc.asm -do versions/6502sp/elite-6502sp$(suffix-6502sp).ssd -boot ELITE

	echo _VERSION=4 > versions/master/sources/elite-header.h.asm
	echo _RELEASE=$(rel-master) >> versions/master/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/master/sources/elite-header.h.asm
	echo _MATCH_EXTRACTED_BINARIES=TRUE >> versions/master/sources/elite-header.h.asm
	$(BEEBASM) -i versions/master/sources/elite-loader.asm -v > versions/master/output/compile.txt
	$(BEEBASM) -i versions/master/sources/elite-data.asm -v >> versions/master/output/compile.txt
	$(BEEBASM) -i versions/master/sources/elite-source.asm -v >> versions/master/output/compile.txt
	$(PYTHON) versions/master/sources/elite-checksum.py -rel$(rel-master)
	$(BEEBASM) -i versions/master/sources/elite-disc.asm $(boot-master) -do versions/master/elite-master$(suffix-master).ssd

	echo _VERSION=5 > versions/electron/sources/elite-header.h.asm
	echo _RELEASE=$(rel-electron) >> versions/electron/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/electron/sources/elite-header.h.asm
	$(BEEBASM) -i versions/electron/sources/elite-source.asm -v > versions/electron/output/compile.txt
	$(BEEBASM) -i versions/electron/sources/elite-bcfs.asm -v >> versions/electron/output/compile.txt
	$(BEEBASM) -i versions/electron/sources/elite-loader.asm -v >> versions/electron/output/compile.txt
	$(PYTHON) versions/electron/sources/elite-checksum.py -rel$(rel-electron)
	$(BEEBASM) -i versions/electron/sources/elite-disc.asm -do versions/electron/elite-electron$(suffix-electron).ssd -opt 3

	echo _VERSION=6 > versions/elite-a/sources/elite-header.h.asm
	echo _RELEASE=$(rel-elite-a) >> versions/elite-a/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/elite-a/sources/elite-header.h.asm
	echo _MATCH_EXTRACTED_BINARIES=TRUE >> versions/elite-a/sources/elite-header.h.asm
	$(BEEBASM) -i versions/elite-a/sources/elite-text-tokens.asm -v > versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-missile.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-source-docked.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-source-flight.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-source-encyclopedia.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-6502sp-parasite.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-6502sp-io-processor.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-loader.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-a.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-b.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-c.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-d.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-e.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-f.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-g.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-h.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-i.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-j.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-k.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-l.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-m.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-n.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-o.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-p.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-q.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-r.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-s.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-t.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-u.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-v.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-w.asm -v >> versions/elite-a/output/compile.txt
	$(PYTHON) versions/elite-a/sources/elite-checksum.py -rel$(rel-elite-a)
	$(BEEBASM) -i versions/elite-a/sources/elite-disc.asm -do versions/elite-a/elite-a$(suffix-elite-a).ssd -opt 3

.PHONY:verify
verify:
	@$(PYTHON) versions/cassette/sources/crc32.py versions/cassette/extracted$(folder-cassette) versions/cassette/output
	@$(PYTHON) versions/disc/sources/crc32.py versions/disc/extracted$(folder-disc) versions/disc/output
	@$(PYTHON) versions/6502sp/sources/crc32.py versions/6502sp/extracted$(folder-6502sp) versions/6502sp/output
	@$(PYTHON) versions/master/sources/crc32.py versions/master/extracted$(folder-master) versions/master/output
	@$(PYTHON) versions/electron/sources/crc32.py versions/electron/extracted$(folder-electron) versions/electron/output
	@$(PYTHON) versions/elite-a/sources/crc32.py versions/elite-a/extracted$(folder-elite-a) versions/elite-a/output

.PHONY:cassette
cassette:
	echo _VERSION=1 > versions/cassette/sources/elite-header.h.asm
	echo _RELEASE=$(rel-cassette) >> versions/cassette/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/cassette/sources/elite-header.h.asm
	$(BEEBASM) -i versions/cassette/sources/elite-source.asm -v > versions/cassette/output/compile.txt
	$(BEEBASM) -i versions/cassette/sources/elite-bcfs.asm -v >> versions/cassette/output/compile.txt
	$(BEEBASM) -i versions/cassette/sources/elite-loader.asm -v >> versions/cassette/output/compile.txt
	$(PYTHON) versions/cassette/sources/elite-checksum.py -rel$(rel-cassette)
	$(BEEBASM) -i versions/cassette/sources/elite-disc.asm -do versions/cassette/elite-cassette$(suffix-cassette).ssd -boot ELTdata
	@$(PYTHON) versions/cassette/sources/crc32.py versions/cassette/extracted$(folder-cassette) versions/cassette/output

.PHONY:disc
disc:
	echo _VERSION=2 > versions/disc/sources/elite-header.h.asm
	echo _RELEASE=$(rel-disc) >> versions/disc/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/disc/sources/elite-header.h.asm
	echo _MATCH_EXTRACTED_BINARIES=TRUE >> versions/disc/sources/elite-header.h.asm
	$(BEEBASM) -i versions/disc/sources/elite-text-tokens.asm -v > versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-missile.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-loader1.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-loader2.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-loader3.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-source-flight.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-source-docked.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-a.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-b.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-c.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-d.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-e.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-f.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-g.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-h.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-i.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-j.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-k.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-l.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-m.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-n.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-o.asm -v >> versions/disc/output/compile.txt
	$(BEEBASM) -i versions/disc/sources/elite-ships-p.asm -v >> versions/disc/output/compile.txt
	$(PYTHON) versions/disc/sources/elite-checksum.py -rel$(rel-disc)
	$(BEEBASM) -i versions/disc/sources/elite-disc.asm -do versions/disc/elite-disc$(suffix-disc).ssd -boot ELITE2
	@$(PYTHON) versions/disc/sources/crc32.py versions/disc/extracted$(folder-disc) versions/disc/output

.PHONY:6502sp
6502sp:
	echo _VERSION=3 > versions/6502sp/sources/elite-header.h.asm
	echo _RELEASE=$(rel-6502sp) >> versions/6502sp/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/6502sp/sources/elite-header.h.asm
	echo _MATCH_EXTRACTED_BINARIES=TRUE >> versions/6502sp/sources/elite-header.h.asm
	$(BEEBASM) -i versions/6502sp/sources/elite-source.asm -v > versions/6502sp/output/compile.txt
	$(BEEBASM) -i versions/6502sp/sources/elite-bcfs.asm -v >> versions/6502sp/output/compile.txt
	$(BEEBASM) -i versions/6502sp/sources/elite-z.asm -v >> versions/6502sp/output/compile.txt
	$(BEEBASM) -i versions/6502sp/sources/elite-loader1.asm -v >> versions/6502sp/output/compile.txt
	$(BEEBASM) -i versions/6502sp/sources/elite-loader2.asm -v >> versions/6502sp/output/compile.txt
	$(PYTHON) versions/6502sp/sources/elite-checksum.py -rel$(rel-6502sp)
	$(BEEBASM) -i versions/6502sp/sources/elite-disc.asm -do versions/6502sp/elite-6502sp$(suffix-6502sp).ssd -boot ELITE
	@$(PYTHON) versions/6502sp/sources/crc32.py versions/6502sp/extracted$(folder-6502sp) versions/6502sp/output

.PHONY:master
master:
	echo _VERSION=4 > versions/master/sources/elite-header.h.asm
	echo _RELEASE=$(rel-master) >> versions/master/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/master/sources/elite-header.h.asm
	echo _MATCH_EXTRACTED_BINARIES=TRUE >> versions/master/sources/elite-header.h.asm
	$(BEEBASM) -i versions/master/sources/elite-loader.asm -v > versions/master/output/compile.txt
	$(BEEBASM) -i versions/master/sources/elite-data.asm -v >> versions/master/output/compile.txt
	$(BEEBASM) -i versions/master/sources/elite-source.asm -v >> versions/master/output/compile.txt
	$(PYTHON) versions/master/sources/elite-checksum.py -rel$(rel-master)
	$(BEEBASM) -i versions/master/sources/elite-disc.asm $(boot-master) -do versions/master/elite-master$(suffix-master).ssd
	@$(PYTHON) versions/master/sources/crc32.py versions/master/extracted$(folder-master) versions/master/output

.PHONY:electron
electron:
	echo _VERSION=5 > versions/electron/sources/elite-header.h.asm
	echo _RELEASE=$(rel-electron) >> versions/electron/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/electron/sources/elite-header.h.asm
	$(BEEBASM) -i versions/electron/sources/elite-source.asm -v > versions/electron/output/compile.txt
	$(BEEBASM) -i versions/electron/sources/elite-bcfs.asm -v >> versions/electron/output/compile.txt
	$(BEEBASM) -i versions/electron/sources/elite-loader.asm -v >> versions/electron/output/compile.txt
	$(PYTHON) versions/electron/sources/elite-checksum.py -rel$(rel-electron)
	$(BEEBASM) -i versions/electron/sources/elite-disc.asm -do versions/electron/elite-electron$(suffix-electron).ssd -opt 3
	@$(PYTHON) versions/electron/sources/crc32.py versions/electron/extracted$(folder-electron) versions/electron/output

.PHONY:elite-a
elite-a:
	echo _VERSION=6 > versions/elite-a/sources/elite-header.h.asm
	echo _RELEASE=$(rel-elite-a) >> versions/elite-a/sources/elite-header.h.asm
	echo _REMOVE_CHECKSUMS=FALSE >> versions/elite-a/sources/elite-header.h.asm
	echo _MATCH_EXTRACTED_BINARIES=TRUE >> versions/elite-a/sources/elite-header.h.asm
	$(BEEBASM) -i versions/elite-a/sources/elite-text-tokens.asm -v > versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-missile.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-source-docked.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-source-flight.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-source-encyclopedia.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-6502sp-parasite.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-6502sp-io-processor.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-loader.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-a.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-b.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-c.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-d.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-e.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-f.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-g.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-h.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-i.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-j.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-k.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-l.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-m.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-n.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-o.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-p.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-q.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-r.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-s.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-t.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-u.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-v.asm -v >> versions/elite-a/output/compile.txt
	$(BEEBASM) -i versions/elite-a/sources/elite-ships-w.asm -v >> versions/elite-a/output/compile.txt
	$(PYTHON) versions/elite-a/sources/elite-checksum.py -rel$(rel-elite-a)
	$(BEEBASM) -i versions/elite-a/sources/elite-disc.asm -do versions/elite-a/elite-a$(suffix-elite-a).ssd -opt 3
	@$(PYTHON) versions/elite-a/sources/crc32.py versions/elite-a/extracted$(folder-elite-a) versions/elite-a/output
