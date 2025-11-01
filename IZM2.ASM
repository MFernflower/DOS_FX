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

in al, 0x60
dec ax
jnz main_loop
    
mov ax, 0x0003       ; clear screen 
int 0x10             ; do it
mov dx, text         ; Load address of exit text
mov ah, 0x09         ; Print string function
int 0x21             ; Call DOS interrupt
ret
text db "Young hustler, a little gotta last$"

