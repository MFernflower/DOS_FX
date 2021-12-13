@echo off
echo DROP FASM.EXE INTO SOURCE DIRECTORY AND THEN RUN THIS
cd %cd%
del *.com
for %%a in (*.asm) do (
fasm.exe "%%a"
)
