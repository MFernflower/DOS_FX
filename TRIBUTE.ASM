use16
org 0x100
MOV AX,0x0003
INT 0x10
MOV AX,0x21E0
MOV CX,AX
MOV AL,182
OUT 43H,AL
MOV AX,CX
OUT 42H,AL
MOV AL,AH
OUT 42H,AL
IN AL,61H
OR AL,03H
OUT 61H,AL
MOV SI,PAYLOAD
PUSH WORD 0x0B800
POP ES
XOR DI,DI
MOV CX,0x03BF
PUSH SI
XOR DX,DX
JCXZ Done
XOR AX,AX
CLD
LOOPA:LODSB
CMP AL,32
JC ForeGround
STOSW
Next:LOOP LOOPA
JMP Done
ForeGround:
CMP AL,16
JNC BackGround
AND AH,0F0H
OR AH,AL
JMP Next
BackGround:
CMP AL,24
JZ NextLine
JNC FlashBitToggle
SUB AL,16
ADD AL,AL
ADD AL,AL
ADD AL,AL
ADD AL,AL
AND AH,8FH
OR AH,AL
JMP Next
NextLine:
ADD DX,160
MOV DI,DX
JMP Next
FlashBitToggle:
CMP AL,27
JC MultiOutput
JNZ Next
XOR AH,128
JMP Next
MultiOutput:
CMP AL,25
MOV BX,CX
LODSB
MOV CL,AL
MOV AL,32
JZ StartOutput
LODSB
DEC BX
StartOutput:
XOR CH,CH
INC CX
REP STOSW
MOV CX,BX
DEC CX
LOOPNZ LOOPA
Done:
mov cx,0x0020
new_shot:
push cx
mov dx,0140h
mov bx,0100h
in al,061h
and al,11111100b
fire_shot:
xor al,2
out 061h,al
add dx,09248h
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
int 0x1A
cmp dx,bx
jne shoot_delay
pop cx
loop new_shot
mov AX,0x0003
int 0x10
MOV AX,0x4C00
INT 0x21
PAYLOAD FILE 'PAYLOAD.BIN'