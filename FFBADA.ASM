use16
org 0x100

push word 0x0B800  
pop es           

mloop:
push ds
mov ax,0x0040       ; bios_data_area segment
mov ds,ax
mov ax,[0x006c]     ; get low word of timer ticks
pop ds
mov [seed],ax      ; store as the seed
call get_random     
and al,0xF ; mask that makes the effect less "gross"
stosb
mov ah,0x01
int 0x16
jz mloop

int 0x20 ; kill process - back to msdos

; generate a pseudo-random number
; output: ax = random number
get_random:
mov ax,[seed]      ; load the current seed
mov dx,[multiplier]  ; load the multiplier
imul dx              ; dx:ax = ax * dx
add ax,[increment]   ; add the increment
mov [seed],ax      ; store the new seed
ret

seed:           dw 0            ; Random seed (initially 0)
multiplier:     dw 32767        ; Multiplier for the algorithm
increment:      dw 12345        ; Increment for the algorithm

