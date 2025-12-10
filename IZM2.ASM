use16                                                                                      
org 0x100
push word 0xB800
pop es          
mloop:
add di, 0x051D
cmp di, 0x3E80
mov al, [es:di]
add al, dl
mov [es:di], al
mov ah, 0x01
int 0x16
jz mloop
mov ax, 0x3
int 0x10
int 0x20


