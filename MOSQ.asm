; setup block
use16
org 100h
xor ah,ah
mov al,02h
int 10h
mov cx,4h
; end
; this code block harvested from an old dos virus
new_shot:  
        push	cx			; Save the current count
		mov 	dx,0x00BE		; DX holds pitch
		mov   	bx,0xCCFB	        ; BX holds shot duration
		in    	al,061h			; Read the speaker port
		and   	al,11111100b		; Turn off the speaker bit
fire_shot:	
                xor	al,2                    ; Toggle the speaker bit
		out	061h,al			; Write AL to speaker port
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
        int 1Ah			; Get the time again
		cmp   	dx,bx			; Are we done yet?
		jne   	shoot_delay		; If not, keep checking
		pop	cx			; Restore the count
		loop	new_shot		; Do another shot
		; end sound block
		
; never the same color routine 
xor ah,ah
int 1Ah
xchg dx,bx	    
xor al,al  
xor dx,dx
; end
; set color
mov ah,0x06 ; ah to 6h
xor cx,cx  ; cx to zero
mov dx,0x184f
int 10h
; end
; print and exit
mov dx,text
mov ah,0x09
int 21h
mov ah,0x4C  ; MSDOS quit and return
int 21h
; end
text db "Fuck, man! Shit! Mosquitoes!",0x24
; EOF
