    use16

    org 0x100

    ; Send the PIT control byte (0xb6) to port 0x43.
    mov al, 0xb6
    out 0x43, al

    ; Load the pit divisor value into the AX register.
    mov ax, 0x1BAF

    ; Send the low byte of the divisor to PIT channel 2, port 0x42.
    out 0x42, al

    ; Send the high byte of the divisor to PIT channel 2, port 0x42.
    mov al, ah
    out 0x42, al

    ; --- Turn on the PC speaker ---
    in al, 0x61
    or al, 0x03
    out 0x61, al

    hang_loop:
    ; --- Randomness provider (do not change values here!) ---
    mov ax, [12345]
    imul bx, ax, 22345
    add bx, 56789
    mov [12345], bx

    ; --- Write to screen ---
    mov al, bh      ; random char
    mov ah, bl      ; random color
    mov dx, bx
    and dl, 0x4F     ; Mask to get a value from 0-79
    xor bh, bh       ; Page zero 
    mov ah, 0x02     ; Function to set cursor position
    int 0x10
    
    mov ah, 0x09     ; Function to write character and attribute
    mov cx, 0x0018   ; Count of characters to write
    int 0x10
    jmp hang_loop
