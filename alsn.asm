    ; alsn.asm - A Loop So Nice 
    use16
    org 0x100
    
    push word 0x0b800
    pop es           
    
    draw_loop:
    xor ax, ax
    int 0x1a
    movzx si, dl   
    and si, 0x3F      
    add si, 0x1A   
    call play_sound_subroutine
    stosb
    mov ah,0x01
    int 0x16
    jz draw_loop
    
    mov ax, 0x0003
    int 0x10
    
    mov ax, 0x4c00
    int 0x21
    
   
    
play_sound_subroutine:
    push ax
    push dx
    push si
    
    ; Set the timer mode for the PC speaker
    mov al, 0xB6
    out 0x43, al
    
    ; Load the 32-bit value for division
    mov dx, 0x0012
    mov ax, 0x2A30
    
    div si             ; Divide 1193180 (DX:AX) by the frequency in SI
    
    ; Output the low and high bytes of the result to the timer port
    out 0x42, al
    mov al, ah
    out 0x42, al

    ; Enable the speaker
    in al, 0x61
    or al, 0x03
    out 0x61, al

    ; Delay for a brief period
    mov cx, 4000
    call delay_loop

    ; Disable the speaker
    in al, 0x61
    and al, 0xFC
    out 0x61, al

    pop si
    pop dx
    pop ax
    ret

delay_loop:
    loop $
    ret