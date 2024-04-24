#!/bin/bash
for k in ./*.com
do
  echo "\e[31mRemoving old com file $k...\e[0m"
  rm $k
done

for f in ./*.asm
do
  echo "\e[36mProcessing $f file...\e[0m"
  fasm $f
done
echo '\007'
