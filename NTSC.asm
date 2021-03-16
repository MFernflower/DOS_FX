org 0x100
waitloop:
; never the same color routine - BX has sort-of-random-hex number in it - AX, DX  and CX are blanked!!!
xor ah,ah
int 1Ah
xchg dx,bx	    
xor al,al  
xor cx,cx
xor dx,dx
; end
call os_dump_registers
mov ah,1h
int 16h
jz waitloop
jnz cleanup

cleanup:
mov al,0x02
int 10h ;restore text mode
mov ah,0x4C  ; MSDOS quit and return
int 21h

include "guilib.inc"
