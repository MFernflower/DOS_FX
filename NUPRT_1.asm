USE16
ORG 0x100
; NEWPORT A (NUPRT_1.asm) - named after the Vibrasphere song, not the ciggie brand 
PUSH WORD 0x0B800
POP ES
ABC:
MOV DX,0x40
INSW
MOV DX,0x41
INSW
in al,0x60
dec ax
jnz ABC
int 0x20
