use16
org 0x100
push word 0x0B800  
pop es           
xor di,di 
mov cx,0x07D0
mov ax,0x0110 
writeMem:
inc ax
stosw 
loop writeMem
hangUp:
nop
jmp hangUp
signature db 0xFF,0xBA,0xDA
