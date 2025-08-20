@echo off
cwsdpmi
for %%f in (*.asm) do (
    fasm %%f
)
for %%p in (*.ASM) do (
    fasm %%p
)
mkdir bin_out
move *.exe bin_out
move *.com bin_out
move *.EXE bin_out
move *.COM bin_out
