use16
org 100h      
les si,[bx]   ; small way to put 0a000h into es
mov ax,0x0013 ; mode 13
int 0x10      ; let's go
mov cx,0xBFBB 
main:
in ax,40h     ;random number (i think its counter on clock?)
stosb         ;write color to screen
loop main     ;loop cx times
mov ax,0x0100 ; Check if key touched
int 16h   ; Check if key touched
jz main  ; if not we start allover again
jnz exit ; else we go to exit routine

exit:
xor ax,ax 
int 0x10 
mov dx,text
mov ah,0x09
int 0x21
ret
text db "Juice B Crypts",0x24
