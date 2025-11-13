use16
org 0x100              
push word 0xb800
pop es                  

mloop:
mov ah, 0x02
int 0x1a
mov ah, dh
in al, 0x40
out 0x61, al
stosw
in al, 0x60
dec al
jnz mloop

int 0x20
