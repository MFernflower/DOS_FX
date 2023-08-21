use16
org 100h  
 
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
