    use16
    org 0x100
    push word 0x0b800
    pop es        
    xor di, di
    draw_loop:
    mov cx, 0x27ff
    loop $
    in ax, 0x41
    neg ax
    stosb
    cmp di, 0x0CFF 
    jne draw_loop
    xor ax,ax
    int 0x16
    erase_loop:
    mov cx, 0x27ff
    loop $
    dec di
    mov byte [ES:DI], 0x00
    cmp di, 0x0000
    jne erase_loop 
    ret
