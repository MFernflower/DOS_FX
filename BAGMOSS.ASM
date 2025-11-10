    use16
    org 0x100
    push word 0x0b800
    pop es        
    xor di,di
    
    draw_loop:
    cld
    mov bx,0x0FF0
    mov cx,0xefff
    loop $
    mov ax,0x02fe
    mov dx,0x41 
    insw
    cmp di, bx
    jne draw_loop

    xor ax, ax
    int 0x16

    erase_loop:
    std
    mov cx,0xefff
    loop $ 
    stosw
    xor bx, bx
    cmp di, bx
    jne erase_loop
    mov al,0x03
    int 0x10
    int 0x20
