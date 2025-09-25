    use16
    org 0x100
    push word 0x0b800
    pop es        
    xor di,di
    draw_loop:
    mov cx, 0x2fff
    loop $
    inc di
    lahf
    or ah, 0xE0
    mov byte [ES:DI],ah
    cmp di,0x1FFF
    jne draw_loop
    erase_loop:
    mov cx, 0x2fff
    loop $
    dec di
    mov byte [ES:DI], 0x00
    cmp di, 0x0000
    jne erase_loop 
    int 0x20
