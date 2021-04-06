org 100h
xor ax,ax 
xor cx,cx
int 10h    ; When ax and cx are blanked calling int 10 gets us a fucky video mode           
mov ah,0x4C  
int 21h