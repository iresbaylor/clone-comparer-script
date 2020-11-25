repoFile=$1

if [ $# -ne 1 ]
then
        echo "Usage: prime_double.sh <repofile>"
        exit 1
fi

chlorine_min_node_weights=(15 20 25 30 35)
chlorine_min_match_coefficient=(0.75 0.8 0.85 0.9 0.95)
iodine_min_nodes=(15 20 25 30 35)
iodine_max_holes=(10 15 20 25 30)
iodine_hole_mass_limits=(5 10 15 20 25)

i=0
while [ $i -lt 5 ]
do
    j=0
    while [ $j -lt 5 ]
    do
        # Chlorine parameters
        export CHLORINE_MIN_NODE_WEIGHT=${chlorine_min_node_weights[i]}
        export CHLORINE_MIN_MATCH_COEFFICIENT=${chlorine_min_match_coefficient[j]}

        # Iodine parameters
        export IODINE_MIN_NODES=${iodine_min_nodes[i]}
        export IODINE_MAX_HOLES=${iodine_max_holes[j]}
        export IODINE_HOLE_MASS_LIMIT=${iodine_hole_mass_limits[(((i+j)%5))]}

	testNum=$((i * 5 + j + 1))
	fileName=output/"$testNum".test
	echo "Double - Test $testNum" | tee -a $fileName
        echo "Parameters,,CHLORINE_MIN_NODE_WEIGHT,CHLORINE_MIN_MATCH_COEFFICIENT,IODINE_MIN_NODES,IODINE_MAX_HOLES,IODINE_HOLE_MASS_LIMIT" | tee -a $fileName
	echo ",,$CHLORINE_MIN_NODE_WEIGHT,$CHLORINE_MIN_MATCH_COEFFICIENT,$IODINE_MIN_NODES,$IODINE_MAX_HOLES,$IODINE_HOLE_MASS_LIMIT" | tee -a $fileName
        echo ""

        ./run.sh double $repoFile
        ((j=j+1))
    done
    ((i=i+1))
done
