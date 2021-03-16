org 100h
mov ax,0x0000
mov al,0x13
int 10h
mov ax,0x0a000
mov ds,ax
xor ax,ax
mov al,0xB6         
out 0x43,al
mov ax,0x07D0
out 0x42,al        
mov al,ah
out 0x42,al
in al,0x61         
or al,0x3   
out 0x61,al
xor bx,bx
xor ax,ax
vgafuck: 
mov [bx],ax
inc bx
inc ax
jno vgafuck
nop
xor bx,bx
xor ax,ax
hang:
nop
jmp hang
