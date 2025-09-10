    use16
    org 0x100
    push word 0x0b800
    pop es        
    mov di,0x0000
    draw_loop:
    mov cx, 0x27ff
    call delay_loop
    in al,  0x40
    and al, 0x6F
    stosb
    cmp di, 0x0CFF 
    jne draw_loop
    xor ax,ax
    int 0x16
    erase_loop:
    mov cx, 0x270f
    call delay_loop
    dec di
    mov byte [ES:DI], 0x00
    cmp di, 0x0000
    jne erase_loop
    int 0x20
    
delay_loop:
    loop $
    ret