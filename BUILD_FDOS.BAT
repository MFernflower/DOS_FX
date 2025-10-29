@echo off
cwsdpmi -p
echo DOS_FX BUILDSCRIPT FOR FREEDOS SYSTEMS
for %%f in (*.asm *.ASM) do C:\DEVEL\FASM\fasm.exe %%f 
if not exist bin_out mkdir bin_out
move /Y *.com bin_out
cwsdpmi -u
