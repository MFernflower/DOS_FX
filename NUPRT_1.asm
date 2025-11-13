USE16
ORG 0x100
; NEWPORT A (NUPRT_1.asm) - named after the Vibrasphere song, not the ciggie brand 
PUSH WORD 0x0B800
POP ES
ABC:
in ax, 0x40
stosw
in ax, 0x41
stosw
mov ah,1
int 0x16
jz ABC
int 0x20
