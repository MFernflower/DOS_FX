    use16
    org 0x100
    push word 0x0B800      
    pop es
    xor di, di          
    mov cx, 0xAFFF         
    mov dx, 0xFFFF
    mov al, 0x00
PrintLoop:
    lahf                ; get semi-random attribute 
    stosw               ; Store the character (AL) and attribute (AH)
    inc al              
    dec dh              
    jnz PrintLoop       
    mov dh, 0xF2        
    loop PrintLoop     
    mov ax, 0x0003
    int 0x10
    ret