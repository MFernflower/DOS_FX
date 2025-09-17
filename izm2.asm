use16
org 0x100
push word 0x0B800
pop es                  ; Set ES segment to video memory
xor di, di
main_loop:

add di, 0x051D
cmp di, 0x3E80
mov al, [es:di]
add al, dl
mov [es:di], al

mov ah, 0x01
int 0x16
jz main_loop
    
mov al, 0x03         ; clear screen 
int 0x10             ; do it
mov dx, text         ; Load address of exit text
mov ah, 0x09         ; Print string function
int 0x21             ; Call DOS interrupt
int 0x20
text db "Young hustler, a little gotta last$"
