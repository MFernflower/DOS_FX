    use16
    org 0x100
    push word 0x0b800
    pop es           
    draw_loop:
    mov cx, 8000
    call delay_loop
    mov ax, 0xFEFE
    stosb
    mov ah,0x01
    int 0x16
    jz draw_loop
    mov dx, text
    mov ah, 0x09
    int 0x21
    int 0x20
    text db 'WHY IS IT YELLOW???',0x24 
delay_loop:
    loop $
    ret
