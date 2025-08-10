; HEAVY PETTING ZOO - name inspired by the deadmau5 song 
; most of this code is based on demo code written by Hackman
use16
org 0x100
mov ax,0x0013
int 10h ; to mode 13 we go!
mov ax,0x0A000
mov ds,ax
xor bx,bx
xor ax,ax 
MAINLOOP:
mov [bx],ax
add bx,320
mov [bx],ax
add bx,320
mov [bx],ax
sub bx,1280 
inc bx
inc ax
cmp ax,0x0FF
jng MAINLOOP
mov ax,0x1301
mov bx,0006h ; last byte of BX seems to be text color?
mov cx,0x003A
mov dx,0x0A0B
int 10h
mov cx,0x1C
keycheck:
mov ah,1h ; Check if key touched
int 16h   ; Check if key touched
jz keycheck
mov ax,0x0002 ; CLEAR SCREEN
int 0x10 ; CLEAR SCREEN
mov ax,0x4C00 ; exit back to dos the safe way
int 0x21      ; do it
