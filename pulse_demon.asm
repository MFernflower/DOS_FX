    use16
    org 0x100
    
    mov ax, 0x0013
    int 0x10      
    
    push word 0xa000
    pop es           
    
    mov cx, (320 * 200) / 2

    draw_loop:
    push cx
    mov ax, [12345]
    imul ax, 22345
    add ax, 56789
    mov [12345], ax
    stosw
    movzx si, al     
    and si, 0x3F      
    add si, 0xF1     
    call play_sound_subroutine
    pop cx
    loop draw_loop
    
    ; Exit to DOS
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
    mov cx, 2000
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
