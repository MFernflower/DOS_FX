; Dedicated to a very MSDOS virus payload inspired music video - Titanium 2 step by Battles
use16
org 0x100 
mov al,0x03
int 0x10
mov dx,battles
mov ah,0x09
int 0x21
push word 0x0B800  
pop es           
mov di,0x000F
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
xor ax,ax ; reset screen
int 0x10 ; reset screen
mov dx,t2step
mov ah,0x09
int 0x21
int 0x20 
battles db 26 dup (0x20), "It's taking too long to figure it out!$"
t2step db 10 dup (0x20), "Alright already!$"
