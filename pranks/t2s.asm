; Dedicated to a very MSDOS virus payload inspired music video - Titanium 2 step by Battles
; hangs machine but should not/does not damage os install or files
use16
org 100h  
mov dx,battles
mov ah,0x09
int 21h
mov ax,0xb800
mov es,ax
label_1:
add di,0x51d
cmp di,0x3e80
jl label_2
sub di,0x3e80
and di,0x012a
label_2:
mov al,[es:di]
add ax,di
mov [es:di],al
jmp label_1

battles db 0x49,0x54,0x27,0x53,0x20,0x54,0x41,0x4B,0x49,0x4E,0x47,0x20,0x54,0x4F,0x4F,0x20,0x4C,0x4F,0x4E,0x47,0x20,0x54,0x4F,0x20,0x46,0x49,0x47,0x55,0x52,0x45,0x20,0x49,0x54,0x20,0x4F,0x55,0x54,0x21,0x24
