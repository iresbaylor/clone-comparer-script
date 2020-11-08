i=1
while [ $i -le 20 ]
do
    ./run.sh single input/$i
	((i=i+1))
done

j=1
while [ $j -le 20 ]
do
    ./run.sh double input/$j
	((j=j+1))
done

