; A prank program version of newport that uses only 6 bytes 
; written by HellMood
use16
org 0x100
les bx,[si]
aas
stosb 
jmp cx