use16
org 0x100
les ax, [si]
insw
X:
stosw
out 0x42,al        
out 0x61,al        
in al, 0x40
jmp X
