use16
org 100h      
mov ax,0x0013 ; mode 13
int 0x10      ; let's go
mov cx,0xBFBB 
les si,[bx]   ; small way to put 0a000h into es 
juiceb:
in ax,0x40     ;random number (i think its counter on clock?)
sub di,ax
stosb         ;write color to screen
loop juiceb   ;loop cx times
mov ah,0x01 ; Check if key touched
int 0x16   ; Check if key touched
jz juiceb  ; if not we start allover again
xor ax,ax ; clear AX
int 0x10 ; clear screen
mov dx,text ; exit text
mov ah,0x09 ; exit text
int 0x21  
ret
text db "Juice B Crypts",0x24
