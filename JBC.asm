use16
org 0x100 
mov ax,0x0013
int 0x10
push word 0xa000
pop es
xor di,di
juiceb:
in ax,0x40     ;random number (i think it is counter on clock?)
sub di,ax
stosb         
dec ax
stosb
mov ah,0x01 ; Check if key touched
int 0x16   ; Check if key touched
jz juiceb  ; if not we start allover again
xor ax,ax
mov al,0x03
int 0x10 ; clear screen
mov dx,text ; exit text
mov ah,0x09 ; exit text
int 0x21  
ret
text db "Juice B Crypts",0x24
