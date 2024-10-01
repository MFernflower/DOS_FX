; 13hfuck.asm - interesting video effect caused by quickly calling int 21h ah 9 while in mode 13h (this effect works in DOSBOX but is untested in anything else)
use16
org 100h      
mov ax,0x0013 ; mode 13
int 0x10      ; let's go
;----------
; MAIN LOOP
mloop:
mov dx,byte_string
mov ah,0x9
int 21h 
mov ah,0x1
int 16h
jz mloop
jnz cleanup
;----------
cleanup:
MOV AX,0x0003 
INT 0x10 
MOV AX,0x4C00 
INT 0x21      
byte_string db 1Ah,9h,5Eh,24h
