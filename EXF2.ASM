    use16
    org 0x100
start:     
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
    xor ax, ax
    int 0x1A
    xchg dx, bx
    and bx, 0x7FFF              ; Mask the bx register to ensure the letters are never black
    mov ah, 0x06
    xor cx, cx
    mov dx, 0x184f
    int 0x10
    mov dx, text
    mov ah, 0x09
    int 0x21
    mov ax,0x4C00
    int 0x21
    text db 'WHY IS IT YELLOW???',0x24 
delay_loop:
    loop $
    ret
