    ; TERMINAL SLAM - A large portion of this code was made by AI but fixed by myself  
    ; Named after a squarepusher song
    use16
    org 0x100

    ; Send the PIT control byte (0xb6) to port 0x43.
    mov al, 0xb6
    out 0x43, al

    ; Load the pit divisor value into the AX register.
    mov ax, 0x2BAD

    ; Send the low byte of the divisor to PIT channel 2, port 0x42.
    out 0x42, al

    ; Send the high byte of the divisor to PIT channel 2, port 0x42.
    mov al, ah
    out 0x42, al

    ; --- Turn on the PC speaker ---
    in al, 0x61
    or al, 0x03
    out 0x61, al

    main_loop:
    ; --- Randomness provider for main_loop (do not change values here!) ---
    mov ax, [12345]
    imul bx, ax, 22345
    add bx, 56789
    mov [12345], bx

    ; --- Write to screen ---
    mov al, 0xB0    ; 
    mov ah, bl      ; Use the new random value for color
    and ah, 0x0F    ; Mask to get a value from 0-15 for the color
    
    ; Get a random row (0-24)
    mov dx, bx
    and dh, 0x18     ; Mask to get a value from 0-24
    shr dh, 3

    ; Get a random column (0-79)
    mov dx, bx
    and dl, 0x4F     ; Mask to get a value from 0-79
    
    mov ah, 0x02     ; Function to set cursor position
    int 0x10
    
    mov ah, 0x09     ; Function to write character and attribute
    mov cx, 1       ; Count of characters to write
    int 0x10

 
    mov ax, 0x0100     ; Check for keyboard press
    int 0x16           ; Do it
    jz main_loop       ; If zero flag is set we the continue loop - else we drop down to the exit block

    ; exit block starts below (turn off pc speaker, clear screen, print text and exit to dos)
    in al, 0x61
    and al, 0xfc
    out 0x61, al
    mov ax, 0x0003
    int 0x10
    mov ax, 0x0900
    mov dx, exit_txt
    int 0x21
    mov ax, 0x4c00   ; Return to MS-DOS
    int 0x21
    exit_txt db '0xFFBADA - TERMINAL SLAMMED!$'
