use16
org 0x100
push word 0xb800
pop es   
wloop:
in al,0x40
mov ah,al ; because in ah,0x40 is invalid
in al,0x60     
stosw
cmp al,0x01
jne wloop
int 0x20