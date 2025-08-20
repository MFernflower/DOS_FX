@echo off
cwsdpmi
for %%f in (*.asm *.ASM) do C:\fasm.exe %%f 
wcl IZM.c
if not exist bin_out mkdir bin_out
move *.exe bin_out
move *.com bin_out
