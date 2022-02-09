; 13hfuck.asm - interesting video effect caused by quickly calling int 21h ah 9 while in mode 13h (this effect works in DOSBOX but is untested in anything else)
org 100h ; tell FASM this is a com file
xor ax,ax  ;clear AX
mov al,0x13 ;AL now set to 0x13
int 10h  ;now we enter 13h video mode
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
mov al,0x03
int 10h
ret
byte_string db 1Ah,9h,5Eh,24h
