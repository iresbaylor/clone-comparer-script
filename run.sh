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

	header=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar -M h pO pC nB nF m)
	headerLine="Results,$header,OXYGEN Time,CHLORINE Time,NICAD_BLOCKS Time,NICAD_FUNCTIONS Time"
	echo $headerLine > $outputFile

	i=0
	while [ $i -lt $num ]
	do
		# remove existing output
		rm -f $TOOL_OUTPUT/*

		repoName=${repositories[i]}
		dirName="${repoName##*/}"

		# Declare timestamp array & index
		declare -a timestamps
		t=0
		
		# Process PyClone
		cd tools/codeDuplicationParser

		# Oxygen
		start_time=$(date +%s.%6N)
		$py_bin/pypy3 -m cli -a oxygen $repoName
		exit_code=$?
		end_time=$(date +%s.%6N)
		if [ $? -ne 0 ]
		then
			echo "$repoName,PyClone (Oxygen) - unable to process" >> $outputFile
			((i=i+1))
			cd ../..
			continue
		fi
		timestamps[t]=$(pypy3 -c "print(\"%.6f\" % (${end_time} - ${start_time}))")
		((t=t+1))

		jsonFiles=(*.json)
		oxygenFile="${jsonFiles[0]}"
		mv $oxygenFile $oxygenFilename
		cp $oxygenFilename $TOOL_OUTPUT
		rm $oxygenFilename

		# Chlorine
		start_time=$(date +%s.%6N)
		$py_bin/pypy3 -m cli -a chlorine $repoName
		exit_code=$?
		end_time=$(date +%s.%6N)
		if [ $exit_code -ne 0 ]
		then
			echo "$repoName,PyClone (Chlorine) - unable to process" >> $outputFile
			((i=i+1))
			cd ../..
			continue
		fi
		timestamps[t]=$(pypy3 -c "print(\"%.6f\" % (${end_time} - ${start_time}))")
		((t=t+1))

		jsonFiles=(*.json)
		chlorineFile="${jsonFiles[0]}"
		mv $chlorineFile $chlorineFilename
		cp $chlorineFilename $TOOL_OUTPUT
		rm $chlorineFilename

		cd ..

		# Process NiCad
		cd NiCad

		# Blocks
		start_time=$(date +%s.%6N)
		./nicad6 blocks py ../../repos/$dirName
		exit_code=$?
		end_time=$(date +%s.%6N)
		if [[ $exit_code -ne 0 ]]
		then
			echo "$repoName,NiCad Blocks - unable to process" >> $outputFile
			((i=i+1))
			cd ../..
			continue
		fi
		cp ../../repos/$dirName\_blocks-blind-clones/$dirName\_blocks-blind-clones-0.30.xml $TOOL_OUTPUT
		mv $TOOL_OUTPUT/$dirName\_blocks-blind-clones-0.30.xml $TOOL_OUTPUT/$nicadBlocksFilename
		timestamps[t]=$(pypy3 -c "print(\"%.6f\" % (${end_time} - ${start_time}))")
		((t=t+1))

		# Functions
		start_time=$(date +%s.%6N)
		./nicad6 functions py ../../repos/$dirName
		exit_code=$?
		end_time=$(date +%s.%6N)
		if [[ $? -ne 0 ]] 
		then
			echo "$repoName,NiCad Functions - unable to process" >> $outputFile
			((i=i+1))
			cd ../..
			continue
		fi
		cp ../../repos/$dirName\_functions-blind-clones/$dirName\_functions-blind-clones-0.30.xml $TOOL_OUTPUT
		mv $TOOL_OUTPUT/$dirName\_functions-blind-clones-0.30.xml $TOOL_OUTPUT/$nicadFunctionsFilename
		timestamps[t]=$(pypy3 -c "print(\"%.6f\" % (${end_time} - ${start_time}))")
		((t=t+1))

		cd ..

		# Process Moss
		cd Moss
		echo "Flattening repository"
		./flatten.sh ../../repos/$dirName
		echo "Sending to Moss"
		mossLink=$(./moss -l python ../../repos/$dirName/*.py | tail -n 1)
		echo $mossLink > $TOOL_OUTPUT/$mossFilename

		cd ../..

		# Process Results
		echo "Processing Results"
		stats=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar -M s -pO $TOOL_OUTPUT/$oxygenFilename -pC $TOOL_OUTPUT/$chlorineFilename -nB $TOOL_OUTPUT/$nicadBlocksFilename -nF $TOOL_OUTPUT/$nicadFunctionsFilename -m $TOOL_OUTPUT/$mossFilename)
		results="$repoName,$stats,${timestamps[0]},${timestamps[1]},${timestamps[2]},${timestamps[3]}"
		echo $results >> $outputFile
		echo "Results Processed"

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

	# header=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar -M h pC pI nB nF)
	# headerLine="Results,$header,CHLORINE Time,IODINE Time,NICAD_BLOCKS Time,NICAD_FUNCTIONS Time"
	header=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar -M h pC nB nF)
        headerLine="Results,$header,CHLORINE Time,NICAD_BLOCKS Time,NICAD_FUNCTIONS Time"
	echo $headerLine > $outputFile
	
	i=0
	while [ $i -lt $num ]
	do
		repo1=${repositories[i]}
		dir1="${repo1##*/}"

		((j=i+1))
		if [ $j -gt $num ]
		then
			# There's an odd number of repositories - skip the last one
			((i=i+2))
			continue
		fi

		repo2=${repositories[j]}
		dir2="${repo2##*/}"

		# remove existing output
		rm -f $TOOL_OUTPUT/*

		# Declare timestamp array & index
		declare -a timestamps
		t=0

		# Process PyClone
		cd tools/codeDuplicationParser

		# Chlorine
		start_time=$(date +%s.%6N)
		$py_bin/pypy3 -m cli -a chlorine $repo1 $repo2
		exit_code=$?
		end_time=$(date +%s.%6N)
		if [ $exit_code -ne 0 ]
		then
			echo "$repoName,PyClone (Chlorine) - unable to process" >> $outputFile
			((j=j+1))
			cd ../..
			continue
		fi
		timestamps[t]=$(pypy3 -c "print(\"%.6f\" % (${end_time} - ${start_time}))")
		((t=t+1))

		jsonFiles=(*.json)
		chlorineFile="${jsonFiles[0]}"
		mv $chlorineFile $chlorineFilename
		cp $chlorineFilename $TOOL_OUTPUT
		rm $chlorineFilename

		# Iodine
		#start_time=$(date +%s.%6N)
		#$py_bin/pypy3 -m cli -a iodine $repo1 $repo2
		#exit_code=$?
		#end_time=$(date +%s.%6N)
		#if [ $exit_code -ne 0 ]
		#then
		#	echo "$repoName,PyClone (Iodine) - unable to process" >> $outputFile
		#	((j=j+1))
		#	cd ../..
		#	continue
		#fi
		#timestamps[t]=$(pypy3 -c "print(\"%.6f\" % (${end_time} - ${start_time}))")
		#((t=t+1))

		#jsonFiles=(*.json)
		#iodineFile="${jsonFiles[0]}"
		#mv $iodineFile $iodineFilename
		#cp $iodineFilename $TOOL_OUTPUT
		#rm $iodineFilename

		cd ..

		# Process NiCad
		cd NiCad

		# Blocks
		start_time=$(date +%s.%6N)
		./nicad6cross blocks py ../../repos/$dir1 ../../repos/$dir2
		exit_code=$?
		end_time=$(date +%s.%6N)
		if [ $exit_code -ne 0 ]
		then
			echo "$repoName,NiCad Blocks - unable to process" >> $outputFile
			((j=j+1))
			cd ../..
			continue
		fi
		timestamps[t]=$(pypy3 -c "print(\"%.6f\" % (${end_time} - ${start_time}))")
		((t=t+1))

		cp ../../repos/$dir1\_blocks-blind-crossclones/$dir1\_blocks-blind-crossclones-0.30.xml $TOOL_OUTPUT
		mv $TOOL_OUTPUT/$dir1\_blocks-blind-crossclones-0.30.xml $TOOL_OUTPUT/$nicadBlocksFilename

		# Functions
		start_time=$(date +%s.%6N)
		./nicad6cross functions py ../../repos/$dir1 ../../repos/$dir2
		exit_code=$?
		end_time=$(date +%s.%6N)
		if [ $exit_code -ne 0 ]
		then
			echo "$repoName,NiCad Functions - unable to process" >> $outputFile
			((j=j+1))
			cd ../..
			continue
		fi
		timestamps[t]=$(pypy3 -c "print(\"%.6f\" % (${end_time} - ${start_time}))")
		((t=t+1))

		cp ../../repos/$dir1\_functions-blind-crossclones/$dir1\_functions-blind-crossclones-0.30.xml $TOOL_OUTPUT
		mv $TOOL_OUTPUT/$dir1\_functions-blind-crossclones-0.30.xml $TOOL_OUTPUT/$nicadFunctionsFilename

		cd ../..

		# Process Results
		echo "Processing Results"
		#stats=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar -M d -pC $TOOL_OUTPUT/$chlorineFilename -pI $TOOL_OUTPUT/$iodineFilename -nB $TOOL_OUTPUT/$nicadBlocksFilename -nF $TOOL_OUTPUT/$nicadFunctionsFilename)
		stats=$(java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar -M d -pC $TOOL_OUTPUT/$chlorineFilename -nB $TOOL_OUTPUT/$nicadBlocksFilename -nF $TOOL_OUTPUT/$nicadFunctionsFilename)
		# results="$repo1,$repo2,$stats,${timestamps[0]},${timestamps[1]},${timestamps[2]},${timestamps[3]}"
		results="$repo1,$repo2,$stats,${timestamps[0]},${timestamps[1]},${timestamps[2]}"
		echo $results >> $outputFile
		echo "Results Processed"

		((i=i+2))
	done
}

print_usage() {
	echo "Usage: ./run.sh [-hk] -m <mode> -f <repository URL file>"
}

print_full_usage() {
	echo "Usage: ./run.sh [-hk] -m <mode> -f <repository URL file>"
	echo "Options:"
	echo "	-f <file>: file containing repositories to scan (required)"
	echo "	-h: print this help"
	echo "	-k: keep temporary files when the analysis finishes"
	echo "	-m <mode>: mode in which to run comparison (required, must be single or double)"
}

###
# Begin main script

while getopts 'f:hkm:' flag
do
	case "${flag}" in
		f) repository_file=${OPTARG} ;;
		h) print_full_usage
			exit 0;;
		k) keep=true ;;
		m) mode=${OPTARG} ;;
		*) print_usage
			exit 1;;
	esac
done

if [ $# == 0 ]
then
	print_usage
	exit 1
fi

if [ -z "$repository_file" ]
then
	echo "Must supply a file containing repositories to check (-f)"
	exit 3
fi

if [ "$mode" != "single" ] && [ "$mode" != "double" ]
then
	echo "Mode (-m) must be single or double"
	exit 2
fi

# Set output directories
OUTPUT="$(pwd)/output"
TOOL_OUTPUT="$(pwd)/toolOutput"

# Uncommend to Build the Maven project
# cd tools/clone-comparer
# mvn clean verify -q
# if [ $? -ne 0 ]
# then
# 	exit $?
# fi

# cd ../..
declare -a repositories

# Declare output files
outputFile=$OUTPUT/output-$mode-`date +%s`.csv
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
	if [ ! -z $line ]
	then
		repositories[num]=$line
		((num=num+1))
	fi
done < $repository_file

# Iterate over the repositories
mkdir -p repos
cd repos
i=0
while [ $i -lt $num ]
do
	git clone ${repositories[i]}
	((i=i+1))
done
cd ..

# Clear out any existing JSON files in PyClone
rm -f tools/codeDuplicationParser/*.json

virtualenv=venv
py_bin="$(pwd)/tools/codeDuplicationParser/$virtualenv/bin"

# Activate Python virtual environment
source tools/codeDuplicationParser/$virtualenv/bin/activate

# Create output directories
mkdir -p $OUTPUT
mkdir -p $TOOL_OUTPUT

# Run the clone tools
if [ $mode == 'single' ]
then
	run_single $repositories $outputFile $tempFiles
else
	run_double $repositories $outputFile $tempFiles
fi

# Clean up flattened repositories
if ! $keep
then
	rm -rf ./repos
fi
