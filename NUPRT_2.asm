USE16
ORG 0x100
; NEWPORT B (NUPRT_2.asm) - named after the Vibrasphere song, not the ciggie brand 
PUSH WORD 0x0B800
POP ES
wloop:
MOV DX,0x41
INSW
MOV AX,0x0100
INT 0x16
JZ wloop
INT 0x20
