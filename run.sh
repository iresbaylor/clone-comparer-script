#!/bin/bash

# Author: Denton Wood
# Description: This script runs clone tools and compares outputs of each
# Tools: PyClone (https://github.com/calebdehaan/codeDuplicationParser)
# NiCad (https://www.txl.ca/txl-nicaddownload.html)
# Moss (https://theory.stanford.edu/~aiken/moss/)

###
# run_single()
#
# Description: Runs the script in single-repository mode. Each repository is
# 				only compared to itself.
# Arguments:
#	repositories - the array of repositories to compare
#	outputFile - file to print output to
#

run_single() {
	repositories=$1
	outputFile=$2

	i=0
	while [ $i -lt $num ]
	do
		# remove existing output
		rm output/*

		repoName=${repositories[i]}
		dirName="${repoName##*/}"
		
		# Process PyClone
		cd tools/codeDuplicationParser

		# Oxygen
		python3 -m cli -a oxygen $repoName
		jsonFiles=(*.json)
		oxygenFile="${jsonFiles[0]}"
		mv $oxygenFile oxygen.json
		cp oxygen.json ../../output
		rm oxygen.json

		# Chlorine
		python3 -m cli -a chlorine $repoName
		jsonFiles=(*.json)
		chlorineFile="${jsonFiles[0]}"
		mv $chlorineFile chlorine.json
		cp chlorine.json ../../output
		rm chlorine.json

		cd ..

		# Process NiCad
		cd NiCad-5.2

		# Blocks
		./nicad5 blocks py ../../repos/$dirName
		cp ../../repos/$dirName\_blocks-blind-clones/$dirName\_blocks-blind-clones-0.30.xml ../../output
		# Stop if error
		if [[ $? -ne 0 ]]
		then
			echo "NiCad Blocks - unable to process" >> $outputFile
			((i=i+1))
			continue
		fi
		mv ../../output/$dirName\_blocks-blind-clones-0.30.xml ../../output/nicad-blocks.xml

		# Functions
		./nicad5 functions py ../../repos/$dirName
		cp ../../repos/$dirName\_functions-blind-clones/$dirName\_functions-blind-clones-0.30.xml ../../output
		# Stop if error
		if [[ $? -ne 0 ]] 
		then
			echo "NiCad Functions - unable to process" >> $outputFile
			((i=i+1))
			continue
		fi
		mv ../../output/$dirName\_functions-blind-clones-0.30.xml ../../output/nicad-functions.xml

		cd ..

		# Process Moss
		cd Moss
		echo "Flattening repository"
		./flatten.sh ../../repos/$dirName
		echo "Sending to Moss"
		mossLink=$(./moss -l python ../../repos/$dirName/*.py | tail -n 1)
		echo $mossLink
		cd ..

		# Process Results
		echo "Processing Results"
		cd ..
		stats=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar output/oxygen.json output/chlorine.json output/nicad-blocks.xml output/nicad-functions.xml $mossLink)
		results="$dirName,$stats"
		echo $results >> $outputFile

		((i=i+1))
	done
}

###
# run_double()
#
# Description: Runs the script in dual-repository mode. Each repository is
# 				compared to every other repository
# Arguments:
#	repositories - the array of repositories to compare
#	outputFile - file to print output to
#

run_double() {
	repositories=$1
	outputFile=$2
	
	i=0
	while [ $i -lt $num ]
	do
		repo1=${repositories[i]}
		dir1="${repo1##*/}"

		j=$i
		while [ $j -lt $num ]
		do
			repo2=${repositories[j]}
			dir2="${repo2##*/}"

			if [ $dir1 == $dir2 ]
			then
				((j=j+1))
				continue
			fi

			# remove existing output
			rm output/*

			# Process PyClone
			cd tools/codeDuplicationParser

			# Oxygen (can't be run in two-repo mode)
			touch ../../output/oxygen.json

			# Chlorine
			python3 -m cli -a chlorine $repo1 $repo2
			jsonFiles=(*.json)
			chlorineFile="${jsonFiles[0]}"
			mv $chlorineFile chlorine.json
			cp chlorine.json ../../output
			rm chlorine.json

			cd ..

			# Process NiCad
			cd NiCad-5.2

			# Blocks
			./nicad5cross blocks py ../../repos/$dir1 ../../repos/$dir2
			cp ../../repos/$dir1\_blocks-blind-crossclones/$dir1\_blocks-blind-crossclones-0.30.xml ../../output
			# Stop if error
			if [[ $? -ne 0 ]]
			then
				echo "NiCad Blocks - unable to process" >> $outputFile
				((j=j+1))
				continue
			fi
			mv ../../output/$dir1\_blocks-blind-crossclones-0.30.xml ../../output/nicad-blocks.xml

			# Functions
			./nicad5cross functions py ../../repos/$dir1 ../../repos/$dir2
			cp ../../repos/$dir1\_functions-blind-crossclones/$dir1\_functions-blind-crossclones-0.30.xml ../../output
			# Stop if error
			if [[ $? -ne 0 ]] 
			then
				echo "NiCad Functions - unable to process" >> $outputFile
				((j=j+1))
				continue
			fi
			mv ../../output/$dir1\_functions-blind-crossclones-0.30.xml ../../output/nicad-functions.xml

			cd ..

			# Process Moss
			# Moss is going to be difficult - handles projects as one big file instead of separate files

			# cd Moss
			# echo "Flattening repository"
			# ./flatten.sh ../../repos/$dir1
			# ./flatten.sh ../../repos/$dir2
			# echo "Sending to Moss"
			# mossLink=$(./moss -l python ../../repos/$dir1/*.py | tail -n 1)
			# echo $mossLink
			# cd ..

			mossLink="link"

			# Process Results
			echo "Processing Results"
			cd ..
			stats=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar output/oxygen.json output/chlorine.json output/nicad-blocks.xml output/nicad-functions.xml $mossLink)
			results="$dir1,$dir2,$stats"
			echo $results >> $outputFile

			((j=j+1))
		done
		((i=i+1))
	done
}

###
# Begin main script

# Handle arguments
if [ $# -ne 2 ]
then
	echo "Usage: <repository URL file> <mode (single/double)>"
	exit 1
fi

repository_file=$1
mode=$2

if [ $mode != "single" ] && [ $mode != "double" ]
then
	echo "Mode must be single or double"
	exit 2
fi

declare -a repositories

outputFile=output-$mode.csv

# Overwrite output file if it exists
rm $outputFile

# Print new header line
header=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar header)
headerLine="Results,$header"
echo $headerLine > $outputFile

# Get the repositories from the file
num=0
while read line
do
	repositories[num]=$line
	((num=num+1))
done < $repository_file

# Iterate over the repositories
cd repos
i=0
while [ $i -lt $num ]
do
	git clone ${repositories[i]}
	((i=i+1))
done
cd ..

# Clear out any existing JSON files in PyClone
rm tools/codeDuplicationParser/*.json

# Activate Python virtual environment
source tools/codeDuplicationParser/venv/bin/activate

# Run the clone tools
if [ $mode == 'single' ]
then
	run_single $repositories $outputFile
else
	run_double $repositories $outputFile
fi

# Clean up flattened repositories
rm -rf ./repos/*