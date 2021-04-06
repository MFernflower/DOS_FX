org 100h
mov ah,0x00  ; AH = 0x00
mov al,0x03 ; AL = 0x03
int 10h    ; set textmode we want 
mov ax,0B800h   ; segment of video buffer
mov es,ax       ; put this into es
xor di,di       ; clean up our mess but now ES:DI points to video memory
xor ax,ax       ; Flush AX so AH is now zero
mov al,0x1A     ; character to keep sending to screen goes into AL (AH = 0x00 AL=0x1A) 
mov cx,0x60A     ; when should we stop the counter?
cld
printloop:
inc ah ; do rainbow effect - this will end  up  overflowing AH - at least I think so
stosw  ; output everything
dec cx
jnz printloop  ; when counter hits zero stop writing to screen
jz waitloop ; and wait for user
;---------------------------------------------------
waitloop:
mov ah,0x1
int 16h
jz waitloop
jnz cleanup
;---------------------------------------------------
cleanup:
xor ax,ax
xor cx,cx 
mov al,0x03
int 10h ;restore text mode
mov ah,0x4C  ; MSDOS quit and return 
int 21h         
