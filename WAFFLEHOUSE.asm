use16
org 100h 
bloop:  
xor ax,ax
mov ah,06
xor cx,cx
mov dx,184fh
mov bh,30
int 10h
mov dx,WHOUSE 
mov ah,0x09
int 21h
mov ah,0x01 ; Check if key touched
int 16h   ; Check if key touched
jz bloop  ; if not we start allover again
mov al,0x03
int 10h
mov ah,0x4c
int 21h
WHOUSE db "WAFFLE HOUSE",0x21,0x24
