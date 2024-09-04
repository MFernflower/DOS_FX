use16
org 0x100 
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
push word 0x0B800  
pop es           
xor di,di              
mov ax,0x000F      
;cld
mov cx,0x07D0
printloop:
inc ah 
stosw  
loop printloop 
hangUp:
nop
jmp hangUp
