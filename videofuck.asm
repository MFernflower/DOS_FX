use16
org 100h
xor ax,ax 
xor cx,cx
int 10h  
mov ax,0x0001
int 33h
mov ah,0x4C  
int 21h
