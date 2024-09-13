; setup block needed for fasm to compile a DOS mode exe
use16
format MZ
push cs
pop ds
; end
; a subroutine I stole from an old dos virus and tweaked so that it makes an annoying noise on the bios beeper
mov cx,0x0004
new_shot:
push cx
mov dx,0xFFFF
mov bx,0x22FB
in al,061h
and al,11111100b
fire_shot:
xor al,2
out 061h,al
mov cl,3
ror dx,cl
mov cx,dx
and cx,01FFh
or cx,10
shoot_pause:
loop shoot_pause
dec bx
jnz fire_shot
and al,11111100b
out 061h,al
mov bx,0002h
xor ah,ah
int 1Ah
add bx,dx
shoot_delay:
int 1Ah
cmp dx,bx
jne shoot_delay
pop cx
loop new_shot
; end
; begin: a routine to clear the screen, print random colored text to screen then exit
mov ax,0x0003
int 0x10
xor ax,ax
int 0x1A
xchg dx,bx
mov ah,0x06
xor cx,cx
mov dx,0x184f
int 10h
mov dx,text
mov ah,0x09
int 0x21
mov ax,0x4C00
int 0x21
; end
text db 'Fuck, man! Shit! Mosquitoes!',0x24
