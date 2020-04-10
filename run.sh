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
	tempFiles=$3

	# Get temp files
	oxygenFilename="${tempFiles[0]}"
	chlorineFilename="${tempFiles[1]}"
	iodineFilename="${tempFiles[2]}"
	nicadBlocksFilename="${tempFiles[3]}"
	nicadFunctionsFilename="${tempFiles[4]}"
	mossFilename="${tempFiles[5]}"

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
		mv $oxygenFile $oxygenFilename
		cp $oxygenFilename ../../output
		rm $oxygenFilename

		# Chlorine
		python3 -m cli -a chlorine $repoName
		jsonFiles=(*.json)
		chlorineFile="${jsonFiles[0]}"
		mv $chlorineFile $chlorineFilename
		cp $chlorineFilename ../../output
		rm $chlorineFilename

		cd ..

		# Process NiCad
		cd NiCad

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
		mv ../../output/$dirName\_blocks-blind-clones-0.30.xml ../../output/$nicadBlocksFilename

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
		mv ../../output/$dirName\_functions-blind-clones-0.30.xml ../../output/$nicadFunctionsFilename

		cd ..

		# Process Moss
		cd Moss
		echo "Flattening repository"
		./flatten.sh ../../repos/$dirName
		echo "Sending to Moss"
		mossLink=$(./moss -l python ../../repos/$dirName/*.py | tail -n 1)
		echo $mossLink > ../../output/$mossFilename

		cd ../..

		# Process Results
		echo "Processing Results"
		stats=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar -M s -pO output/$oxygenFilename -pC output/$chlorineFilename -nB output/$nicadBlocksFilename -nF output/$nicadFunctionsFilename -m output/$mossFilename)
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
	tempFiles=$3

	# Get temp files
	oxygenFilename="${tempFiles[0]}"
	chlorineFilename="${tempFiles[1]}"
	iodineFilename="${tempFiles[2]}"
	nicadBlocksFilename="${tempFiles[3]}"
	nicadFunctionsFilename="${tempFiles[4]}"
	mossFilename="${tempFiles[5]}"
	
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

			# Chlorine
			python3 -m cli -a chlorine $repo1 $repo2
			jsonFiles=(*.json)
			chlorineFile="${jsonFiles[0]}"
			mv $chlorineFile $chlorineFilename
			cp $chlorineFilename ../../output
			rm $chlorineFilename

			# Iodine
			python3 -m cli -a iodine $repo1 $repo2
			jsonFiles=(*.json)
			iodineFile="${jsonFiles[0]}"
			mv $iodineFile $iodineFilename
			cp $iodineFilename ../../output
			rm $iodineFilename

			cd ..

			# Process NiCad
			cd NiCad

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
			mv ../../output/$dir1\_blocks-blind-crossclones-0.30.xml ../../output/$nicadBlocksFilename

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
			mv ../../output/$dir1\_functions-blind-crossclones-0.30.xml ../../output/$nicadFunctionsFilename

			cd ../..

			# Process Results
			echo "Processing Results"
			stats=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar -M d -pC output/$chlorineFilename -pI output/$iodineFilename -nB output/$nicadBlocksFilename -nF output/$nicadFunctionsFilename)
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
	echo "Usage: <mode (single/double)> <repository URL file>"
	exit 1
fi

mode=$1
repository_file=$2

if [ $mode != "single" ] && [ $mode != "double" ]
then
	echo "Mode must be single or double"
	exit 2
fi

# Build the Maven project
cd tools/clone-comparer
mvn clean package
cd ../..

declare -a repositories

# Declare output files
outputFile=output-$mode-`date +%s`.csv
declare -a tempFiles
tempFiles[0]=oxygen.json
tempFiles[1]=chlorine.json
tempFiles[2]=iodine.json
tempFiles[3]=nicad-blocks.xml
tempFiles[4]=nicad-functions.xml
tempFiles[5]=moss.txt

# Get the repositories from the file
num=0
while read line
do
	repositories[num]=$line
	((num=num+1))
done < $repository_file

# Iterate over the repositories
mkdir repos
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

#virtualenv=venv
virtualenv=venv_pypy

# Activate Python virtual environment
source tools/codeDuplicationParser/$virtualenv/bin/activate

# Create output directory
mkdir output

# Run the clone tools
if [ $mode == 'single' ]
then
	header=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar -M h pO pC nB nF m)
	headerLine="Results,$header"
	echo $headerLine > $outputFile
	run_single $repositories $outputFile $tempFiles
else
	header=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar -M h pC pI nB nF)
	headerLine="Results,$header"
	echo $headerLine > $outputFile
	run_double $repositories $outputFile $tempFiles
fi

# Clean up flattened repositories
rm -rf ./repos
