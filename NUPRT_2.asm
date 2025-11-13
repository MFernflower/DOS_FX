USE16
ORG 0x100
; NEWPORT B (NUPRT_2.asm) - named after the Vibrasphere song, not the ciggie brand 
PUSH WORD 0x0B800
POP ES
MOV DX, 0x41
ABC:
insw
in al, 0x60
dec ax
jnz ABC
int 0x20
