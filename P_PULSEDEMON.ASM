use16
org 0x100
les ax, [si]
nop
PULSE_DEMON:
stosw
in al, 0x40
out 0x42,al        
out 0x61,al        
jmp PULSE_DEMON
