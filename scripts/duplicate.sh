#!/bin/bash

# This script duplicates a file of repositories so that the double algorithm can run each repo
# against itself

input_file=$1

if [ -z $input_file ]
then
	echo "Usage: ./duplicate.sh <input file>"
	exit 1
fi

output_file="$1-double"

while read line
do
	echo $line >> $output_file;
	echo $line >> $output_file;
done < $input_file
