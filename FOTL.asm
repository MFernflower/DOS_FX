use16
org 0x100

mov al, 0x13          ; mode '13h'
int 0x10                ; Set video mode to 320x200 pixels, 256 colors
push word 0xa000
pop es                  ; Set ES segment to video memory

wloop:
mov dx, 0x40          ; read a byte of data from port 0x40
insb                  ; write this byte into video memory  
mov dx, text         ; Load address of exit text
mov ah, 0x09         ; Print string function
int 0x21             ; Call DOS interrupt
mov ah, 0x01          ; Check if a key is pressed
int 0x16              ; Call BIOS keyboard interrupt
jz wloop              ; If no key is pressed, loop back

mov ax, 0x0003         ; clear screen 
int 0x10             ; Call BIOS video interrupt
int 0x20
text db "Change my pitch up! Smack my VGA up!", 0x24
