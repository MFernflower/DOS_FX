; HEAVY PETTING ZOO - inspired by the deadmau5 song 
; most of this code is based on demo code written by Hackman
use16
org 100h
mov ax,0x0013
int 10h ; to mode 13 we go!
MOV AX,0x0A000
MOV DS,AX
xor bx,bx
xor ax,ax 
MAINLOOP:
mov [bx],ax
add bx,320
mov [bx],ax
add bx,320
mov [bx],ax
sub bx,1280 
inc bx
inc ax
cmp ax,0x0FF
jng MAINLOOP
mov ax,1301h
mov bx,000Bh ; last byte of BX seems to be text color?
mov cx,003Ah
mov dx,0A0Bh
int 10h
mov cx,0x1C
; this code harvested from an old dos virus
new_shot:  
                push	cx			; Save the current count
		mov 	dx,0140h		; DX holds pitch
		mov   	bx,0100h		; BX holds shot duration
		in    	al,061h			; Read the speaker port
		and   	al,11111100b		; Turn off the speaker bit
fire_shot:	
                xor	al,2                    ; Toggle the speaker bit
		out	061h,al			; Write AL to speaker port
		add     dx,09248h		;
		mov	cl,3                    ;
		ror	dx,cl			; Figure out the delay time
		mov	cx,dx                   ;
		and	cx,01FFh                ;
		or	cx,10                   ;
shoot_pause:  
                                      loop	shoot_pause             ; Delay a bit
		dec	bx			; Are we done with the shot?
		jnz	fire_shot		; If not, pulse the speaker
		and   	al,11111100b		; Turn off the speaker bit
		out   	061h,al			; Write AL to speaker port
		mov   	bx,0002h                ; BX holds delay time (ticks)
		xor   	ah,ah			; Get time function
		int   	1Ah			; BIOS timer interrupt
		add   	bx,dx                   ; Add current time to delay
shoot_delay:  
                                       int 0x1A			; Get the time again
		cmp   	dx,bx			; Are we done yet?
		jne   	shoot_delay		; If not, keep checking
		pop	cx			; Restore the count
		loop	new_shot		; Do another shot
;cleanup functions down below
keycheck:
mov ah,1h ; Check if key touched
int 16h   ; Check if key touched
jz keycheck
ret
