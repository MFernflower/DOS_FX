    use16
    org 0x100
    push word 0x0B800      
    pop es
    xor di, di          
    mov cx, 0xAFFF         
    mov dx, 0xFFFF
    xor ax, ax
PrintLoop:
    lahf               
    stosw              
    inc al              
    dec dh              
    jnz PrintLoop       
    mov dh, 0xF2        
    loop PrintLoop     
    mov ax,0x0003
    int 0x10             ; Call BIOS video interrupt
    mov dx, text         ; Load address of exit text
    mov ah, 0x09         ; Print string function
    int 0x21             
    int 0x20
    text db "Hiding in the pattern in between the rows?$"
