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

# Run the clone tools
i=0
while [ $i -lt $num ]
do
	cd tools
	repoName=${repositories[i]}
	dirName="${repoName##*/}"

	# Process PyClone
	cd codeDuplicationParser

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

	# Functions
	./nicad5 functions py ../../repos/$dirName
	cp ../../repos/$dirName\_functions-blind-clones/$dirName\_functions-blind-clones-0.30.xml ../../output
	mv ../../output/$dirName\_functions-blind-clones-0.30.xml ../../output/nicad-functions.xml

	# Blocks
	./nicad5 blocks py ../../repos/$dirName
	cp ../../repos/$dirName\_blocks-blind-clones/$dirName\_blocks-blind-clones-0.30.xml ../../output
	mv ../../output/$dirName\_blocks-blind-clones-0.30.xml ../../output/nicad-blocks.xml

	cd ..

	# Process Moss
	cd Moss
	echo "Flattening repository"
	./flatten.sh ../../repos/$dirName
	echo "Sending to Moss"
	mossLink=$(./moss -l python ../../repos/$dirName/*.py | tail -n 1)
	cd ..

	# Process Results
	cd ..
	java -jar tools/clone-comparer/target/clone-comparer-1.0-SNAPSHOT.jar output/oxygen.json output/chlorine.json output/nicad-functions.xml output/nicad-blocks.xml $mossLink > output.txt
	((i=i+1))
done

cd ..
rm -rf ./repos/*
