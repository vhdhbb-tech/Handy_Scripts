#!/bin/bash 

My_Directory="/home/vhdhbb/"

for file in "$My_Directory"/*; do 
  if [ -f "$file" ];then
    perm=$(stat -c %a $file) 
    if [ "$perm" -eq 775 ];then
      echo "$file has permissions $perm"
    fi
  fi
done