use16
org 0x100
mov ax, 0x0013
int 0x10                ; Set video mode to 320x200 pixels, 256 colors
push word 0xa000

pop es                  ; Set ES segment to video memory
mov cx, (320 * 200) / 2      ; Total number of pixels
xor di,di
draw_loop:
    in ax, 0x41
    xchg bx , ax
    in ax, 0x40
    and ax, bx
    stosw
    loop draw_loop
    
    ; Wait for a key press before exiting
    xor ax, ax
    int 0x16
    
    ; Restore original video mode (Mode 03h)
    mov ax, 0x0003
    int 0x10 
    
    ; Exit to DOS
    mov ax, 0x4c00
    int 0x21
