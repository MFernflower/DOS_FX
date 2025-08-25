@echo off
echo DOS_FX BUILDSCRIPT FOR FREEDOS SYSTEMS
cwsdpmi
for %%f in (*.asm *.ASM) do C:\fasm.exe %%f 
if not exist bin_out mkdir bin_out
move /Y *.exe bin_out
move /Y *.com bin_out
