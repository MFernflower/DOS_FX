; Dedicated to a very MSDOS virus payload inspired music video - Titanium 2 step by Battles
; Titanium 2 Step REWRITE
use16
org 0x100 
mov dx,battles
mov ax,0x0900
int 0x21
mov ax,0xb800
mov es,ax
parta:
add di,0x051d
cmp di,0x3e80
jl partb
sub di,0x3e80
and di,0x05AF
partb:
mov al,[es:di]
add ax,di
mov [es:di],al
mov ah,0x01 ; Check if key touched
int 0x16   ; Check if key touched
jz parta  ; if not we start allover again
mov ax,0x0003 ; reset screen
int 0x10 ; reset screen
mov dx,t2step
mov ax,0x0900
int 0x21
ret      
padding: times 5 db 0x90
battles db "It's taking too long to figure it out!$"
t2step db "Alright already!$"
