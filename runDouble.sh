#!/bin/bash

FILENAME=$1
declare -a repositories

# Get the repositories from the file
num=0
while read line
do
	repositories[num]=$line
	((num=num+1))
done < $FILENAME

# Iterate over the repositories
i=0
while [ $i -lt $num ]
do
	j=$i
	while [ $j -lt $num ]
	do
		if [ ${repositories[i]} != ${repositories[j]} ]
		then
			python3 -m cli -a chlorine ${repositories[i]} ${repositories[j]}
		fi
		((j=j+1))
	done
	((i=i+1))
done

