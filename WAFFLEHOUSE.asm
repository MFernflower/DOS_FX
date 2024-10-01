use16
org 0x100
bloop:  
xor ax,ax
mov ah,06
xor cx,cx
mov dx,0x184f
mov bh,30
int 10h
mov dx,WHOUSE 
mov ah,0x09
int 0x21
mov ah,0x01 ; Check if key touched
int 0x16  ; Check if key touched
jz bloop  ; if not we start allover again
MOV AX,0x0003 
INT 0x10 
MOV AX,0x4C00 
INT 0x21      
WHOUSE db "WAFFLE HOUSE",0x21,0x24
