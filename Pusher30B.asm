    use16
    org 0x100
    ; text mode pusher effect in 30 bytes 
    push word 0x0b800
    pop es        
    mov di,0x000A
    draw_loop:
    mov cx, 0x2fff
    call delay_loop
    inc di
    lahf 
    mov byte [ES:DI], ah
    cmp di, 0x0CFF 
    jne draw_loop
    xor ax,ax 
    int 0x16
    int 0x20 ; kill process and return to DOS
    
        
delay_loop:
    loop $
    ret