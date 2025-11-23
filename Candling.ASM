use16
org 0x100

mov al, 0x13          
int 0x10                
push word 0xa000
pop es                  

mloop:
mov ah, 0x02
int 0x1a
mov ah, dh
in al, 0x41
stosw
; out 0x61, al
in al, 0x60
dec al
jnz mloop
mov al, 0x03
int 0x10
int 0x20

