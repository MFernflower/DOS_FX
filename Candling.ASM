use16
org 0x100

mov ax, 0x11 ; werid greyscale VGA mode          
int 0x10                
push word 0xA000
pop es                  

parta:
mov ah, 0x02
int 0x1a
mov ah, dh
in al, 0x41
stosw
mov ah, 0x01 ; Check if key touched
int 0x16   ; Check if key touched
jz parta  ; if not we start allover again
mov ax, 0x3
int 0x10
int 0x20
