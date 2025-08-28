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
     
    push word 0x0b800 
    pop es
    
    main_loop:
    ; --- Randomness provider for main_loop (do not change values here!) ---
    mov ax, [12345]
    imul bx, ax, 22345
    add bx, 56789
    mov [12345], bx

    ; --- Write to screen ---
    mov al, 0x0F    ; 
    mov ah, bl      ; Use the new random value for color
    and ah, 0x0F    ; Mask to get a value from 0-15 for the color
    
    ; Get a random row (0-24)
    mov dx, bx
    and dh, 0x18     ; Mask to get a value from 0-24
    shr dh, 3

    ; Get a random column (0-79)
    mov dx, bx
    and dl, 0x4F     ; Mask to get a value from 0-79
    xor bh, bh       ; Page zero 
    mov ah, 0x02     ; Function to set cursor position
    int 0x10
    
    mov ah, 0x09     ; Function to write character and attribute
    mov cx, 1        ; Count of characters to write
    int 0x10
    
    mov dx, 0x41          
    insb                 

    mov ax, 0x0100     ; Check for keyboard press
    int 0x16           ; Do it
    jz main_loop       ; If zero flag is set we continue the loop
   
    mov ah, 0x3c ; Create the file (AH=3C)
    xor cx, cx ; Attribute: normal file (0)
    lea dx, [filename] ; Address of the filename
    int 0x21 ; Call DOS interrupt
    jc exit_program ; error handler


    mov bx, ax ;   File handle is returned in AX, store it in BX for later use
    mov ah, 0x40 ;  Write to a file
    lea dx, [file_contents] ; Address of the string to write
    mov cx, 5
    int 0x21

    ; Close the file (AH=3Eh)
    mov ah, 0x3E ; Function 3Eh: Close a file
    int 0x21
    
    ; exit block starts below (turn off pc speaker, clear screen, print fake error text and exit to dos)
    exit_program:
    in al, 0x61
    and al, 0xfc
    out 0x61, al
    
    mov ax, 0x0003
    int 0x10
    
    mov ax, 0x0900
    mov dx, exit_txt
    int 0x21
    
    mov ax, 0x4c00   
    int 0x21
    
    exit_txt db 'ERROR CODE: 0xFFBADA - TERMINAL SLAMMED!$'
    filename db 'poo.txt', 0 
    file_contents db 'shit$'

