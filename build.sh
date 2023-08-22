#!/bin/bash
for k in ./*.com
do
  echo -e "\e[31mRemoving old com file $k...\e[0m"
  # take action on each file. $f store current file name
  rm $k
done

for f in ./*.asm
do
  echo -e "\e[36mProcessing $f file...\e[0m"
  # take action on each file. $f store current file name
  fasm $f
done
