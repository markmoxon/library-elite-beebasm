\ ******************************************************************************
\
\ ELITE DISC IMAGE SCRIPT
\
\ Elite was written by Ian Bell and David Braben and is copyright Acornsoft 1984
\
\ The code on this site is identical to the source discs released on Ian Bell's
\ personal website at http://www.elitehomepage.org/ (it's just been reformatted
\ to be more readable)
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
\ This source file produces the following SSD disc image:
\
\   * elite-cassette-from-source-disc.ssd
\
\ This can be loaded into an emulator or a real BBC Micro.
\
\ ******************************************************************************

\PUTFILE "versions/cassette/binaries/$.!BOOT.bin", "!BOOT", &FFFFFF, &FFFFFF
PUTFILE "versions/cassette/binaries/$.ELITE.bin", "ELITE", &FF1900, &FF8023
PUTFILE "versions/cassette/output/ELITE.bin", "ELTdata", &FF1100, &FF2000
PUTFILE "versions/cassette/output/ELTcode.bin", "ELTcode", &FF1128, &FF1128
PUTFILE "versions/cassette/output/README.txt", "README", &FFFFFF, &FFFFFF
