use16
org 0x100
les ax, [si]
cli
X:stosw
in al,0x40        
out 0x61,al        
jmp short X