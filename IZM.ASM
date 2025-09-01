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

mov ah, 0x01
int 0x16
jz main_loop
    
mov ax, 0x0003       ; clear screen 
int 0x10             ; Call BIOS video interrupt
mov dx, text         ; Load address of exit text
mov ah, 0x09         ; Print string function
int 0x21             ; Call DOS interrupt
mov ax, 0x4C00       ; Exit program
int 0x21             ; Call DOS interrupt
text db "Young hustler, don't move so fast$"