    use16
    org 0x100
    mov al, 0x13
    int 0x10               
    push word 0xa000
    pop es  
    mov cx, (320 * 200) / 2  

    xor di,di
    draw_loop:
    in ax,0x41
    xor ax, cx
    stosw
    loop draw_loop
    
    ; Wait for a key press before exiting
    xor ax, ax
    int 0x16
    mov ax, 0x0003
    int 0x10 
    int 0x20
