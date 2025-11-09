use16
org 0x100
mov ax, 0x0013
int 0x10                ; Set video mode to 320x200 pixels, 256 colors
push word 0xa000
pop es                  ; Set ES segment to video memory
mov DI, 0xFFFF          ; Initialize DI
wloop:
in ax, 0x40          ; Get random number from timer
sub di, ax           ; Subtract random number from DI
stosb                ; Store byte at ES:DI and increment DI
stosb                ; Store byte at ES:DI and increment DI (again)
mov ah, 0x01         ; Check if a key is pressed
int 0x16             ; Call BIOS keyboard interrupt
jz wloop             ; If no key is pressed, loop back
xor ax,ax
int 0x10            
mov dx, text         ; Load address of exit text
mov ah, 0x09         ; Print string function
int 0x21             ; Call DOS interrupt
int 0x20
text db "Juice B Crypts", 0x24
