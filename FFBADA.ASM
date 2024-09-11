use16
org 0x100
push word 0x0B800  
pop es           
xor di,di 
mov cx,0x07D0
mov ax,0x0110 
writeMem:
inc ax
stosw 
loop writeMem
keyExit:
mov ah,0x01 ; Check if key touched
int 0x16   ; Check if key touched
jz keyExit  ; if not we start allover again
mov al,0x03 ; clear screen
int 0x10 ; clear screen
ret