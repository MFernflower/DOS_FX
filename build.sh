#!/bin/bash

for f in ./*.asm
do
fasm $f
done

for p in ./*.ASM
do
fasm $p
done

mkdir ./bin_out

mv ./*.{exe,com} ./bin_out
