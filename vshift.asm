use16
org 0x100

; Get into text mode video memory and set up regs
mov ax, 0xB800
mov es, ax
xor di, di
mov cx, 2000
xor bx, bx

.loop:
    ; Skip empty space characters entirely
    mov al, [es:di]
    cmp al, 0x20
    je .next

    ; Update attribute: keep high nibble, replace low with current color
    mov al, [es:di + 1]
    and al, 0xF0
    or al, bl
    mov [es:di + 1], al

    ; Increment character & mask to prevent 0x80+ (black blocks)
    inc byte [es:di]
    and byte [es:di], 0x7F

.next:
    add di, 2

    ; Advance without trashing everything
    inc bl
    cmp bl, 0x10
    jb .no_wrap
    mov bl, 0x01
.no_wrap:

    ; Delay
    push cx
    mov cx, 0xFFFE
.dly:
    loop .dly
    pop cx

    dec cx
    jnz .loop

    int 0x20