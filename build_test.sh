#!/bin/bash

for f in ./*.{asm,ASM}
do
fasm $f
done

mkdir ./bin_out

mv ./*.{exe,com} ./bin_out

exit
