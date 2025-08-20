; Rainbow Barf dos prank program (Will hang your system when ran)
use16
org 0x100
push word 0x0B800  
pop es           
xor di,di      
mov ax,0x001A      
mov cx,0xFA  
cld
printloop:
inc ah 
stosw 
dec cx 
jnz printloop 
jz outstring
outstring:
mov dx,HiddenString
mov ah,0x09
int 0x21
hang_system:
nop
jmp hang_system
HiddenString DB 5 dup (0x20),"Rainbow Barf",0x21,0x20,0x24
