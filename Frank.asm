org 100h
xor ax,ax
mov al,0x02
int 10h
mov	cl,00
mov	dl,4fh
mov	ah,06		;clear the display window
mov	al,00
mov	bh,0fh		;blank line attribs
mov	ch,00		;starting at upper left corner
mov	cl,00		
mov	dh,00		;row 0
mov	dl,4fh		;column 4Fh
int	10h
mov	ah,02		;set cursor position
mov	dh,00		;to row 0,
mov	dl,1fh		;column 1Fh
mov	bh,00		;in graphics mode
int	10h
mov	dx,eyes  
mov	ah,09		
int	21h
mov	ah,02		;reposition character
mov	dh,01		;to row 1,
mov	dl,00		;column 0
int	10h
mov	ah,09		;write character and attrib
mov	al,0dch		;character shape
mov	bl,0x0f		;character colour
mov	cx,50h		;number of characters.
int	10h
mov	ah,02		;reposition cursor
mov	dh,18h		;to row 18h
mov	dl,00		;column 0
int	10h
mov	ah,09		;write character & attribute
mov	al,0dfh		;character shape
mov bl,0x0f
mov	cx,0050h	;number of characters
int	10h
mov	dl,00		;back to column 0
make_teeth:
mov	ah,02		;set cursor position
mov	dh,02		;to row 2
int 10h
mov ah,09  ;write the character
mov al,0x55 ; tooth character
mov bl,0x03  ; colour code
mov cx,1  ;only one tooth
int 10h
mov ah,02
mov dh,17h  ;row 17h
inc dl  ;increase column number
int 10h
mov ah,09  ;write a character there.
mov al,0xd2             ; bottom teeth
mov bl,ah
int 10h
inc dl  ;increment column number
cmp dl,0x50  ;is there hex 50 of them yet?
jl make_teeth ;make more if not
mov ah,02  ;set cursor position
mov dx,0x03D0
xor bh,bh
int 10h
mov dx,frank
mov ah,09  
int 21h
waitloop:
mov ah,1h
nop
int 16h
jz waitloop
jnz cleanup
cleanup:
xor ax,ax
xor cx,cx
mov al,0x02
int 10h ;restore text mode
mov ah,0x4C  ; MSDOS quit and return
int 21h

frank db "Bitey frank! Bite Bite Bite!",0x20,0x24
eyes db 0x28,0x4f,0x29,35 dup 0x20,0x28,0x4f,0x29,0x24


; FRANK.ASM - draw a face and then return to MSDOS - video effect code mostly lifted from old dos virus called 'MALMSEY' 
; Dedicated to DankPod's goofy ass snake - Frank!
