use16
org 0x100

mov ax, 0x0013          ; mode '13h'
int 0x10                ; set video mode to 320x200 pixels, 256 colors
push word 0xa000
pop es                  ; set es segment to video memory

mloop:
push ds
mov ax, 0x0040       ; bios_data_area segment
mov ds, ax
mov ax, [0x006c]     ; get low word of timer ticks
pop ds
mov [seed], ax      ; store as the seed
call get_random     
stosw
mov ah,0x01
int 0x16
jz mloop

mov ax, 0x0003       ; clear screen 
int 0x10             ; call bios video interrupt
mov dx, text         ; load address of exit text
mov ah, 0x09         ; print string function
int 0x21             ; call dos interrupt
mov ax, 0x4c00       ; exit program
int 0x21             ; call dos interrupt

; generate a pseudo-random number
; output: ax = random number
get_random:
mov ax, [seed]      ; load the current seed
mov dx, [multiplier]  ; load the multiplier
imul dx              ; dx:ax = ax * dx
add ax, [increment]   ; add the increment
mov [seed], ax      ; store the new seed
ret

seed:           dw 0            ; Random seed (initially 0)
multiplier:     dw 32767        ; Multiplier for the algorithm
increment:      dw 12345        ; Increment for the algorithm
text db "Time Shifter 1.0 - OF CHANGING MINDS", 0x24
