use16
org 0x100
mov ax, 0x0003  ; text mode 80x25 16 colours
int 0x10
; Switch PC speaker on and annoy user 
mov ax,0x21E0
mov cx,ax			
mov al,182
out 43h,al
mov ax,cx			
out 42h,al
mov al,ah
out 42h,al
in al,61h			
or al,03h
out 61h,al
; end
mov si,PAYLOAD
mov ax,0B800h
mov es,ax
mov cx,0x03BF ; LENGTH OF PAYLOAD IMAGE
call writeimage 
hang: 
nop
nop
nop
jmp hang



writeimage:                            ; this function was created by one Ian E. Davis -- I only changed like 4 lines to get it to compile with FASM
       PUSHA                           ; Save registers (186 and onward cpu's)
	   XOR     DX,DX                    ; this holds some screen location thing - since we want the center of the screen - zero it out
	   JCXZ    Done
       XOR     AX,AX                   ;Set Current attributes.
       CLD

LOOPA: LODSB                           ;Get next character.
       CMP     AL,32                   ;If a control character, jump.
       JC      ForeGround
       STOSW                           ;Save letter on screen.
Next:  LOOP    LOOPA
       JMP     Done                    ; may need to be marked as short for some --- FASM did not care 

ForeGround:
       CMP     AL,16                   ;If less than 16, then change the
       JNC     BackGround              ;foreground color.  Otherwise jump.
       AND     AH,0F0H                 ;Strip off old foreground.
       OR      AH,AL
       JMP     Next

BackGround:
       CMP     AL,24                   ;If less than 24, then change the
       JZ      NextLine                ;background color.  If exactly 24,
       JNC     FlashBitToggle          ;then jump down to next line.
       SUB     AL,16                   ;Otherwise jump to multiple output
       ADD     AL,AL                   ;routines.
       ADD     AL,AL
       ADD     AL,AL
       ADD     AL,AL
       AND     AH,8FH                  ;Strip off old background.
       OR      AH,AL
       JMP     Next

NextLine:
       ADD     DX,160                  ;If equal to 24,
       MOV     DI,DX                   ;then jump down to
       JMP     Next                    ;the next line.

FlashBitToggle:
       CMP     AL,27                   ;Does user want to toggle the blink
       JC      MultiOutput             ;attribute?
       JNZ     Next
       XOR     AH,128                  ;Done.
       JMP     Next

MultiOutput:
       CMP     AL,25                   ;Set Z flag if multi-space output.
       MOV     BX,CX                   ;Save main counter.
       LODSB                           ;Get count of number of times
       MOV     CL,AL                   ;to display character.
       MOV     AL,32
       JZ      StartOutput             ;Jump here if displaying spaces.
       LODSB                           ;Otherwise get character to use.
       DEC     BX                      ;Adjust main counter.

StartOutput:
       XOR     CH,CH
       INC     CX
       REP STOSW
       MOV     CX,BX
       DEC     CX                      ;Adjust main counter.
       LOOPNZ  LOOPA                   ;Loop if anything else to do...

Done:  
       POPA
       RET



PAYLOAD:
        DB      14,16,24,25,19,10,27,'MOV AX,0XFE03 / INT 0X21 - KEY'
        DB      ' TO GO ON!',24,25,19,14,27,'YOU ALWAYS REMEMBER YOU'
        DB      'R FIRST SHOT OF TEQUILA!',24,25,15,1,'ÚÄÄÄÂ',26,'(Ä'
        DB      '¿',24,25,15,'³',17,' ',10,26,0,4,' ',1,16,'³',17,' '
        DB      14,26,0,1,' ',26,0,2,' ',26,0,2,' ',26,0,1,' ',26,0,2
        DB      ' ',26,0,1,' ',26,0,2,' ',26,0,2,' ',26,0,1,' ',26,0,2
        DB      1,26,0,2,14,26,0,2,' ',26,0,2,' ',26,0,1,' ',26,0,2,' '
        DB      26,0,2,' ',26,0,2,' ',26,0,15,'  ',26,0,3,' ',26,0,1
        DB      ' ',1,16,'³',24,25,15,'ÃÄÄÄÅ',26,'(Ä´',24,25,15,'³',17
        DB      ' ',2,'s ',1,16,'³ ',8,26,3,'° ',9,26,3,'° ',10,26,3,'°'
        DB      ' ',11,26,3,'° ',12,26,3,'° ',13,26,3,'° ',14,26,3,'°'
        DB      ' ',15,26,3,'° ',1,'³',24,25,15,'³',17,' ',2,'y ',1,16
        DB      '³',25,'(³',24,25,15,'³',17,' ',2,'s ',1,16,'³ ',8,17
        DB      26,3,'°',16,' ',9,17,26,3,'°',16,' ',10,17,26,3,'°',16
        DB      ' ',11,17,26,3,'°',16,' ',12,17,26,3,'°',16,' ',13,17
        DB      26,3,'°',16,' ',14,17,26,3,'°',16,' ',15,17,26,3,'°',16
        DB      ' ',1,'³',24,25,15,'³',17,' ',2,'t ',1,16,'³',25,'(³'
        DB      24,25,15,'³',17,' ',2,'e ',1,16,'³ ',8,18,26,3,'°',16
        DB      ' ',9,18,26,3,'°',16,' ',10,18,26,3,'°',16,' ',11,18,26
        DB      3,'°',16,' ',12,18,26,3,'°',16,' ',13,18,26,3,'°',16,' '
        DB      14,18,26,3,'°',16,' ',15,18,26,3,'°',16,' ',1,'³',24,25
        DB      15,'³',17,' ',2,'m ',1,16,'³',25,'(³',24,25,15,'³',17
        DB      ' ',2,'÷ ',1,16,'³ ',8,19,26,3,'°',16,' ',9,19,26,3,'°'
        DB      16,' ',10,19,26,3,'°',16,' ',11,19,26,3,'°',16,' ',12
        DB      19,26,3,'°',16,' ',13,19,26,3,'°',16,' ',14,19,26,3,'°'
        DB      16,' ',15,19,26,3,'°',16,' ',1,'³',24,25,15,'³',17,' '
        DB      2,'e ',1,16,'³',25,'(³',24,25,15,'³',17,' ',2,'r ',1,16
        DB      '³ ',8,20,26,3,'°',16,' ',9,20,26,3,'°',16,' ',10,20,26
        DB      3,'°',16,' ',11,20,26,3,'°',16,' ',12,20,26,3,'°',16,' '
        DB      13,20,26,3,'°',16,' ',14,20,26,3,'°',16,' ',15,20,26,3
        DB      '°',16,' ',1,'³',24,25,15,'³',17,' ',2,'r ',1,16,'³',25
        DB      '(³',24,25,15,'³',17,' ',2,'o ',1,16,'³ ',8,21,26,3,'°'
        DB      16,' ',9,21,26,3,'°',16,' ',10,21,26,3,'°',16,' ',11,21
        DB      26,3,'°',16,' ',12,21,26,3,'°',16,' ',13,21,26,3,'°',16
        DB      ' ',14,21,26,3,'°',16,' ',15,21,26,3,'°',16,' ',1,'³'
        DB      24,25,15,'³',17,' ',2,'r ',1,16,'³',25,'(³',24,25,15,'³'
        DB      17,' ',2,'! ',1,16,'³ ',8,22,26,3,'°',16,' ',9,22,26,3
        DB      '°',16,' ',10,22,26,3,'°',16,' ',11,22,26,3,'°',16,' '
        DB      12,22,26,3,'°',16,' ',13,22,26,3,'°',16,' ',14,22,26,3
        DB      '°',16,' ',15,22,26,3,'°',16,' ',1,'³',24,25,15,'³',17
        DB      25,2,16,'³',25,'(³',24,25,15,'³',17,25,2,16,'³ ',8,23
        DB      26,3,'°',16,' ',9,23,26,3,'°',16,' ',10,23,26,3,'°',16
        DB      ' ',11,23,26,3,'°',16,' ',12,23,26,3,'°',16,' ',13,23
        DB      26,3,'°',16,' ',14,23,26,3,'°',16,' ',15,23,26,3,'°',16
        DB      ' ',1,'³',24,25,15,'ÀÄÄÄÁ',26,'(ÄÙ',24,25,15,11,'Goi'
        DB      'ng to hell and back with only ',14,17,'TheDraw',3,16
        DB      ', ',11,'FASM and DOSBOX!',24,24,24