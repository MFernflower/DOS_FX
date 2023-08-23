use16
org 100h      
mov ax,0x0013 ; mode 13
int 0x10      ; let's go
les si,[bx]   ; small way to put 0a000h into es 
mov cx,0xBFBB 
juiceb:
in ax,40h     ;random number (i think its counter on clock?)
sub di,ax
stosb         ;write color to screen
loop juiceb   ;loop cx times
mov ax,0x0100 ; Check if key touched
int 16h   ; Check if key touched
jz juiceb  ; if not we start allover again
jnz exit ; else we go to exit routine

exit:
xor ax,ax 
int 0x10 
mov dx,text
mov ah,0x09
int 0x21
int 0x20
;ret
text db "Juice B Crypts",0x24
