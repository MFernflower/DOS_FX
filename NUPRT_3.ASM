use16
org 0x100
; NEWPORT C (NUPRT_3.asm) - named after the Vibrasphere song, not the ciggie brand 
PUSH WORD 0x0B800
POP ES
ABC:
mov dx,0x40
insw
in al,0x60
dec ax
jnz ABC
int 0x20
