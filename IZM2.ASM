use16
org 0x100
push word 0x0B800
pop es                  ; Set ES segment to video memory
mloop:

add di, 0x051D
cmp di, 0x3E80
mov al, [es:di]
add al, dl
mov [es:di], al

mov ah,0x01
int 0x16
jz mloop

mov ax, 0x0003       ; clear screen 
int 0x10             ; do it    
mov dx, text         ; Load address of exit text
mov ah, 0x09         ; Print string function
int 0x21             ; do it
int 0x20             ; Exit 
text db "Young hustler, a little gotta last$"


