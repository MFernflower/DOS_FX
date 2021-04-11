org 0x100
xor ax,ax 
xor cx,cx
push bp
int 10h   
; When ax and cx are blanked calling int 10 gets us a fucky video mode               
mov cx,0x1C
; this code harvested from an old dos virus - makes a rat-a-tat sound on the PC speaker
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
nop
mov ax,1300h                   ; print string call
mov bx,8Ah                     ; attribute flag
mov cx,18h                    ; length of string 
mov dx,0xC00            ; start position
mov bp,si                     ; fill string area with bullshit 
int 10h ; do it
xor ax,ax
waitkb:                          
mov ah,1h                       
int 16h
jz waitkb    
jnz fall

fall:
mov ah,0x4C  
pop bp
int 21h

