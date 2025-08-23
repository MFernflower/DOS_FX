    ; NT2S.asm - New (AI rewritten) Titanium 2 Step 
    use16
    org 0x100 
    mov ax, 0x0003
    int 0x10
    push word 0x0B800
    pop es
    mov di, 0x000F

main_loop:
    ; Increment the index by 0x051D
    add di, 0x051D

    ; Check if the index has reached the end of the screen
    cmp di, 0x3E80
    jl continue

    ; Wrap around to the beginning of the screen
    sub di, 0x3E80
    and di, 0x05AF

continue:
    ; Modify the character at the current position
    mov al, [es:di]
    add ax, di
    not ax
    mov [es:di], al

    ; Check if a key has been pressed
    mov ah, 0x01
    int 0x16
    jz main_loop

    ; Reset the screen
    mov ax, 0x0003
    int 0x10

    ; Display the exit message
    mov dx, battles
    mov ax, 0x0900
    int 0x21

    ; Exit the program
    mov ax, 0x4C00
    int 0x21
    
    battles db "It's taking too long to figure it out!$"
