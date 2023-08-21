org 100h
mov ax,0x0003
int 10h      ; set textmode we want 
mov ax,0B800h   ; segment of video buffer
mov es,ax       ; put this into es
xor di,di       ; clean up our mess but now ES:DI points to video memory
xor ax,ax       ; Flush AX 
mov al,0x20      
mov cx,0xAD    ; when should we stop the counter?
cld
printloop:
inc ah 
stosw 
dec cx      ; subtract from our counter
jnz printloop  ; when counter hits zero stop writing to screen
; fall down to end code to hand control back to dos leaving our "smear" on the screen
mov ah,0x4C
int 21h
; Modification of RAINBOW.asm that puts a rainbow streak ontop of the screen and then hands control back to dos
