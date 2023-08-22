; Rainbow Barf dos prank program (Will hang your system when ran)
use16
org 100h
xor ax,ax
mov al,0x03
int 10h
mov ax,0B800h  
mov es,ax            
;xor di,di       
;xor ax,ax       
mov al,0x1A      
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
int 21h
jmp hang_system
hang_system:
nop
nop
jmp hang_system
HiddenString DB 5 dup (0x20),"Rainbow Barf",0x21,0x20,0x24
