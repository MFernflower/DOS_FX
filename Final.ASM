use16
org 0x100
pusha
  mov ah, 0x00
  mov al, 0x03  ; text mode 80x25 16 colours
  int 0x10
  popa
      MOV     SI,PAYLOAD
       MOV     AX,0B800h
       MOV ES,AX
       MOV     DI,1*2 + 1*160-162 
       MOV     CX,874
       PUSH    SI                      ;Save registers.
       PUSH    DI
       PUSH    AX
       PUSH    BX
       PUSH    CX
       PUSH    DX
       JCXZ    Done

       MOV     DX,DI                   ;Save X coordinate for later.
       XOR     AX,AX                   ;Set Current attributes.
       CLD

LOOPA: LODSB                           ;Get next character.
       CMP     AL,32                   ;If a control character, jump.
       JC      ForeGround
       STOSW                           ;Save letter on screen.
Next:  LOOP    LOOPA
       JMP     Short Done

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

Done:  POP     DX                      ;Restore registers.
       POP     CX
       POP     BX
       POP     AX
       POP     DI
       POP     SI
       RET



PAYLOAD:
        DB      14,16,24,25,19,10,27,'MOV AX,0XFE03 / INT 0X21 - KEY'
        DB      ' TO GO ON!',24,25,19,14,27,'YOU ALWAYS REMEMBER YOU'
        DB      'R FIRST SHOT OF TEQUILA!',24,25,15,1,'UAAAA',26,'(A'
        DB      '¢¯',24,25,15,'©ø',17,25,2,16,'©ø',17,25,2,14,'8',25,3,'9'
        DB      25,2,'10',25,2,'11',25,2,'12',25,2,'13',25,2,'14',25,2
        DB      '15  ',1,16,'©ø',24,25,15,'AAAAA',26,'(A¢¥',24,25,15,'©ø'
        DB      17,' ',14,'0 ',1,16,'©ø ',8,26,3,'¡Æ ',9,26,3,'¡Æ ',10,26
        DB      3,'¡Æ ',11,26,3,'¡Æ ',12,26,3,'¡Æ ',13,26,3,'¡Æ ',14,26,3
        DB      '¡Æ ',15,26,3,'¡Æ ',1,'©ø',24,25,15,'©ø',17,25,2,16,'©ø',25
        DB      '(©ø',24,25,15,'©ø',17,' ',14,'1 ',1,16,'©ø ',8,17,26,3,'¡Æ'
        DB      16,' ',9,17,26,3,'¡Æ',16,' ',10,17,26,3,'¡Æ',16,' ',11,17
        DB      26,3,'¡Æ',16,' ',12,17,26,3,'¡Æ',16,' ',13,17,26,3,'¡Æ',16
        DB      ' ',14,17,26,3,'¡Æ',16,' ',15,17,26,3,'¡Æ',16,' ',1,'©ø'
        DB      24,25,15,'©ø',17,25,2,16,'©ø',25,'(©ø',24,25,15,'©ø',17,' '
        DB      14,'2 ',1,16,'©ø ',8,18,26,3,'¡Æ',16,' ',9,18,26,3,'¡Æ',16
        DB      ' ',10,18,26,3,'¡Æ',16,' ',11,18,26,3,'¡Æ',16,' ',12,18
        DB      26,3,'¡Æ',16,' ',13,18,26,3,'¡Æ',16,' ',14,18,26,3,'¡Æ',16
        DB      ' ',15,18,26,3,'¡Æ',16,' ',1,'©ø',24,25,15,'©ø',17,25,2,16
        DB      '©ø',25,'(©ø',24,25,15,'©ø',17,' ',14,'3 ',1,16,'©ø ',8,19
        DB      26,3,'¡Æ',16,' ',9,19,26,3,'¡Æ',16,' ',10,19,26,3,'¡Æ',16
        DB      ' ',11,19,26,3,'¡Æ',16,' ',12,19,26,3,'¡Æ',16,' ',13,19
        DB      26,3,'¡Æ',16,' ',14,19,26,3,'¡Æ',16,' ',15,19,26,3,'¡Æ',16
        DB      ' ',1,'©ø',24,25,15,'©ø',17,25,2,16,'©ø',25,'(©ø',24,25,15
        DB      '©ø',17,' ',14,'4 ',1,16,'©ø ',8,20,26,3,'¡Æ',16,' ',9,20
        DB      26,3,'¡Æ',16,' ',10,20,26,3,'¡Æ',16,' ',11,20,26,3,'¡Æ',16
        DB      ' ',12,20,26,3,'¡Æ',16,' ',13,20,26,3,'¡Æ',16,' ',14,20
        DB      26,3,'¡Æ',16,' ',15,20,26,3,'¡Æ',16,' ',1,'©ø',24,25,15,'©ø'
        DB      17,25,2,16,'©ø',25,'(©ø',24,25,15,'©ø',17,' ',14,'5 ',1,16
        DB      '©ø ',8,21,26,3,'¡Æ',16,' ',9,21,26,3,'¡Æ',16,' ',10,21,26
        DB      3,'¡Æ',16,' ',11,21,26,3,'¡Æ',16,' ',12,21,26,3,'¡Æ',16,' '
        DB      13,21,26,3,'¡Æ',16,' ',14,21,26,3,'¡Æ',16,' ',15,21,26,3
        DB      '¡Æ',16,' ',1,'©ø',24,25,15,'©ø',17,25,2,16,'©ø',25,'(©ø',24
        DB      25,15,'©ø',17,' ',14,'6 ',1,16,'©ø ',8,22,26,3,'¡Æ',16,' '
        DB      9,22,26,3,'¡Æ',16,' ',10,22,26,3,'¡Æ',16,' ',11,22,26,3
        DB      '¡Æ',16,' ',12,22,26,3,'¡Æ',16,' ',13,22,26,3,'¡Æ',16,' '
        DB      14,22,26,3,'¡Æ',16,' ',15,22,26,3,'¡Æ',16,' ',1,'©ø',24,25
        DB      15,'©ø',17,25,2,16,'©ø',25,'(©ø',24,25,15,'©ø',17,' ',14,'7'
        DB      ' ',1,16,'©ø ',8,23,26,3,'¡Æ',16,' ',9,23,26,3,'¡Æ',16,' '
        DB      10,23,26,3,'¡Æ',16,' ',11,23,26,3,'¡Æ',16,' ',12,23,26,3
        DB      '¡Æ',16,' ',13,23,26,3,'¡Æ',16,' ',14,23,26,3,'¡Æ',16,' '
        DB      15,23,26,3,'¡Æ',16,' ',1,'©ø',24,25,15,'AAAAA',26,'(AU'
        DB      24,25,16,11,'Going to hell and back with only FASM a'
        DB      'nd DOSBOX!',24,24,24
