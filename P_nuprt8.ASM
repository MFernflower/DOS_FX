; A prank program version of newport that uses only 8 bytes
; shoutout to HellMood
use16
org 0x100
les ax, [si]
aas
XS:
stosb
in ax, 0x40
jmp XS
