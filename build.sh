#!/bin/bash
for k in ./*.com
do
  echo -e "\e[31mRemoving old com file $k...\e[0m"
  rm $k
done

for f in ./*.asm
do
  echo -e "\e[36mProcessing $f file...\e[0m"
  fasm $f
  echo -e '\007'
done
