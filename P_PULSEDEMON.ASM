use16
org 0x100
les ax, [si]
hlt ; put CLI here if you want to be an asshole >:-)
X:stosw
in al,0x40        
out 0x61,al        
jmp short X
