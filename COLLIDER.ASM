; this is a rework of NEWPORT_A.asm I wrote when stoned - it makes a nice graphical effect 
USE16
ORG 0x100 
PUSH WORD 0x0B800  
POP ES           
XOR DI,DI 
KEYLOOP:
MOV AH,0x01
INT 0x16
JNZ EXIT1
MOV CX,0x07D0
WRITEMEM:
IN AX,0x40
STOSW
OR AX,0xBEEF
STOSW
LOOP WRITEMEM
JMP KEYLOOP

EXIT1:
INT 0x20

