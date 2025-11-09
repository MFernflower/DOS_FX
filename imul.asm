    use16
    org 0x100
    
    mov ax, 0x0013
    int 0x10      
    
    push word 0xa000
    pop es           
    
    mov cx, 320 * 200 
    xor di,di
    
    draw_loop:
    mov ax, [12345]
    imul ax, 22345
    add ax, 56789
    mov [12345], ax
    neg ax
    stosb
    loop draw_loop

   ; Wait for a key press before exiting
    xor ax, ax
    int 0x16
    mov al, 0x03
    int 0x10 
    int 0x20
