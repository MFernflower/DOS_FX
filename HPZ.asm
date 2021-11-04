; HEAVY PETTING ZOO - inspired by the deadmau5 song 
; most of this code is based on demo code written by Hackman
; TODO: Make this code pretty - it looks like hell but FASM compiles it fine!
org 100h
xor ax,ax 
mov al,0x13
int 10h ; to mode 13 we go!
mov ax,0a000h 
mov ds,ax
xor bx,bx
xor ax,ax 
MAINLOOP:
nop
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
mov bx,0008h ; last byte of BX seems to be text color?
mov cx,003Ah
mov dx,0A0Bh
xor bp,bp
mov bp,text
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
xor ax,ax
mov al,0x02
int 10h
mov ax,0x0001
int 33h
xor bp,bp
mov ax,0x4C  ; MSDOS quit and return
int 21h
text db "HEAVY PETTING ZOO"
