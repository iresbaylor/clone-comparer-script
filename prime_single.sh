repoFile=$1

if [ $# -ne 1 ]
then
	echo "Usage: prime_single.sh <repofile>"
	exit 1
fi

oxygen_min_node_weights=(15 20 25 30 35)
chlorine_min_node_weights=(15 20 25 30 35)
chlorine_min_match_coefficient=(0.75 0.8 0.85 0.9 0.95)

i=0
while [ $i -lt 5 ]
do
    j=0
    while [ $j -lt 5 ]
    do
        # Oxygen parameters
        export OXYGEN_MIN_NODE_WEIGHT=${oxygen_min_node_weights[i]}

        # Chlorine parameters
        export CHLORINE_MIN_NODE_WEIGHT=${chlorine_min_node_weights[i]}
        export CHLORINE_MIN_MATCH_COEFFICIENT=${chlorine_min_match_coefficient[j]}
	testNum=$((i * 5 + j + 1))
	fileName=output/"$testNum".test
	echo "Single - Test $testNum" | tee -a $fileName
	echo "Parameters,,OXYGEN_MIN_NODE_WEIGHT,CHLORINE_MIN_NODE_WEIGHT,CHLORINE_MIN_MATCH_COEFFICIENT" | tee -a $fileName
	echo ",,$OXYGEN_MIN_NODE_WEIGHT,$CHLORINE_MIN_NODE_WEIGHT,$CHLORINE_MIN_MATCH_COEFFICIENT" | tee -a $fileName
	echo ""
        ./run.sh single $repoFile
	((j=j+1))
    done
    ((i=i+1))
done
