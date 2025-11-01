; A prank program version of newport that uses only 8 bytes
; written by HellMood
use16
org 0x100
les ax, [si]
cli
X:stosb
in ax, 0x40
jmp short X
