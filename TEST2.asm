org 100h
xor ax,ax
mov al,0x02
int 10h
xor ax,ax
mov ah,0x06    ; scroll up function
xor al,al     ; clear entire screen
xor cx,cx     ; upper left corner ch=row, cl=column
mov dx,0x184f  ; lower right corner dh=row, dl=column 
mov bh,0x70   ;QSPRAYER uses this color scheme
int 10h
mov dx,message
mov ah,0x09  
int 21h
xor ax,ax
mov ax,0x4c
int 21h
message db "All this asm for some colorful text?",0x20,0x24
