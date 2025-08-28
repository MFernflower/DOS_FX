    use16
    org 0x100
    mov ax, 0x0013
    int 0x10               
    push word 0xa000
    pop es                 
    mov cx, (320 * 200) / 2  
    xor di,di
    draw_loop:
    in ah, 0x41
    in al, 0x40
    and al, ah
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
