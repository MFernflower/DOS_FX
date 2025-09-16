    use16
    org 0x100
    push word 0x0b800
    pop es        
    xor di,di
    draw_loop:
    mov cx,0x2fff
    loop $
    inc di
    lahf 
    mov byte [ES:DI],ah
    cmp di,0x1FFF
    jne draw_loop
    int 0x20 ; kill process and return to DOS