use16
org 0x100
mov ax,0x0013
int 0x10
mov ax,0x0A000
mov ds,ax
xor bx,bx
xor ax,ax 
MAINLOOP:
mov [bx],ax
add bx,320
mov [bx],ax
add bx,320
mov [bx],ax
sub bx,1280 
inc bx
inc ax
cmp ax,0x01FF
jng MAINLOOP
; turn on pc speaker here
mov cx,0x0000
mov al,182
out 0x43,al
mov ax,cx			
out 0x42,al
mov al,ah
out 42h,al
in al,0x61			
or al,0x03
out 0x61, al
; draw garbage on screen 
mov ax,0x1301
mov bx,0x0006 ; last byte of BX seems to be text color?
mov cx,0x003A
mov dx,0x0A0B
int 0x10
; Delay for a bit then return to dos (after shutting off pc speaker and clearing the screen)
xor ax,ax
int 1ah      ; get the time of day count
add  dx,222   ; this is a okay delay for what we are doing
mov bx,dx    ; store end of delay value in bx
again:                           
int 0x1a
cmp dx,bx
jne again
mov ax,0x0003 
int 0x10 
in al,0x61
and al,0xFC
out 0x61,al
mov ax,0x4C00 
int 0x21      
