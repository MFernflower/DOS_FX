    use16
    org 0x100
    push word 0x0b800
    pop es        
    xor di, di
    
    draw_loop:
    cld
    mov bx, 0x0FF0
    mov cx, 0xefff
    loop $
    mov ax, 0x02fe
    stosw
    cmp di, bx
    jne draw_loop

    xor ah, ah
    int 0x16

    erase_loop:
    std
    mov cx, 0xefff
    loop $ 
    mov ax,0x0100
    stosw
    xor bx, bx
    cmp di, bx
    jne erase_loop
    mov ax,0x0003
    int 0x10
    int 0x20
