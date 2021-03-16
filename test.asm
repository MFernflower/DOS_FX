org 100h
mov ax,0x0000 ; xor ax,ax 
mov cx,0x0000 ; xor cx,cx
int 10h    ; When ax and cx are blanked calling int 10 gets us a fucky video mode                
push bp
nop
mov ax,1300h                   ; print string
mov bx,0x8A              ; attribute
mov cx,5                       ; length of string
mov dx,0xC11             ; start position
mov bp,poop             
int 10h
nop
waitkb:                          
mov ah,1h                       
int 16h
jz waitkb    
jnz fall

fall:
pop bp
mov ah,0x4C  
int 21h

poop DB "test",0x21
