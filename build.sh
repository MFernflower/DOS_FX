#!/bin/bash
for k in ./*.com
do
rm $k
done

for f in ./*.asm
do
fasm $f
done

