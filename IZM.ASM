use16
org 0x100
mov ax, 0x0013          ; mode '13h'
int 0x10                ; Set video mode to 320x200 pixels, 256 colors
push word 0xa000
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
int 0x10             ; Call BIOS video interrupt
mov dx, text         ; Load address of exit text
mov ah, 0x09         ; Print string function
int 0x21             ; Call DOS interrupt
int 0x20
text db "Young hustler, don't move so fast$"
