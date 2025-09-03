    use16
    org 0x100                  ; MOZZIE.asm -  AI optimized version of SKEETER.asm that compiles to a com file
    mov cx, 3                  ; Loop counter
    ; BEGIN AI OPTIMIZED CODE FOR SOUND EFFECT
mosquito_loop:
    push cx                    ; Save loop counter
    mov dx, 0xF6D8             ; Set initial value for dx
    mov bx, 0xC2FB             ; Set initial value for bx
    in al, 061h                ; Read from port 061h
    and al, 11111100b          ; Clear the lower 2 bits
mosquito_fire:
    xor al, 2                  ; Toggle the lower bit
    out 061h, al               ; Write to port 061h
    mov cl, 3                  ; Set delay counter
mosquito_delay:
    loop mosquito_delay        ; Delay loop
    ror dx, cl                 ; Rotate dx right by cl bits
    mov cx, dx                 ; Move dx to cx
    and cx, 01FFh              ; Mask the lower 9 bits of cx
    or cx, 10                  ; Set the lower 5 bits of cx to 10
mosquito_pause:
    loop mosquito_pause        ; Delay loop
    dec bx                     ; Decrement bx
    jnz mosquito_fire          ; Repeat the fire loop if bx is not zero
    and al, 11111100b          ; Clear the lower 2 bits
    out 061h, al               ; Write to port 061h
    mov bx, 2                  ; Set bx to 2
    xor ah, ah                 ; Clear ah
    int 1Ah                    ; Get system time
    add bx, dx                 ; Add dx to bx
mosquito_delay2:
    int 1Ah                    ; Get system time
    cmp dx, bx                 ; Compare dx to bx
    jne mosquito_delay2        ; Repeat the delay loop if dx is not equal to bx
    pop cx                     ; Restore loop counter
    loop mosquito_loop         ; Repeat the main loop
    ; END AI OPTIMIZED CODE 
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
    text db 'Fuck, man! Shit! Mosquitoes!',0x24 
