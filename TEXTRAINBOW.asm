USE16
ORG 0x100 
PUSH WORD 0x0B800  
POP ES           
XOR DI,DI
mov ax,0x001A     ; character to keep sending to screen goes into AL (AH = 0x00 AL=0x1A) 
mov cx,0x60A     ; when should we stop the counter?
cld
printloop:
inc ah ; do rainbow effect - this will end  up overflowing AH - at least I think so?
stosw  ; output everything
loop printloop
;---------------------------------------------------
waitloop:
mov ah,0x1
int 16h
jz waitloop
jnz cleanup
;---------------------------------------------------
cleanup:
MOV AX,0x0002 ; CLEAR SCREEN
INT 0x10 ; CLEAR SCREEN
MOV AX,0x4C00 ; exit back to dos the safe way
INT 0x21      ; do it
