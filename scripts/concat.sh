#!/bin/bash

if [ $# -ne 1 ]
then
	echo "usage: concat.sh <target directory>"
	exit 1
fi

targetDir=$1
files=($targetDir/output-*)
i=0
size=${#files[@]}
while [ $i -lt $size ]
do
        cat "${files[i]}" >> total.csv
        ((i=i+1))
done

