use16
org 0x100

mov ax, 0x11 ; werid greyscale VGA mode          
int 0x10                
push word 0xA000
pop es                  

mloop:
mov ah, 0x02
int 0x1a
mov ah, dh
in al, 0x41
stosw
in al, 0x60
dec al
jnz mloop
mov ax, 0x3
int 0x10
int 0x20



