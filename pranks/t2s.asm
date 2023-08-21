; Dedicated to a very MSDOS virus payload inspired music video - Titanium 2 step by Battles
; hangs machine but should not/does not damage anythig 
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

battles db "IT'S TAKING TOO LONG TO FIGURE IT OUT",0x21,0x24
