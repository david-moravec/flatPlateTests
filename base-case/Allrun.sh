#!/bin/bash
#first argument is the name of the folder case (T3A, T3B, T3A-) 
function plotResiduals() {
	sleep 15
	gnuplot residuals.gp &
	GNUPLOT_PID=$!

	while pgrep -x "simpleFoam" > /dev/null; do
		:
	done
	kill $GNUPLOT_PID
}

echo "Enter number for starting a given case"
echo "number 1 for T3A"
echo "number 2 for T3B"
echo "number 3 for T3A-"
echo "number 4 for all three cases"

read answer

caseFold="flatPlate-test"

if [ $answer == 1 ]; then
	declare -a caseType=("T3A")
elif [ $answer == 2 ]; then
	declare -a caseType=("T3B")
elif [ $answer == 3 ]; then
	declare -a caseType=("T3A-")
elif [ $answer == 4 ]; then
	declare -a caseType=("T3A" "T3B" "T3A-minus")
else
	echo "undefined choice"
	exit
fi


turbModel=${PWD##*/}
#echo "enter name of a directory which will be used for saving the plot and csv file:"
#read dirName
for i in "${caseType[@]}"; do
	./Allclean.sh $caseFold

	cd $caseFold
	echo $i

	rm -r 0
	cp -r ${i}.0 "0" 

	blockMesh

    if [ $1 == 'parallel' ]; then
        decomposePar -force
	    mpirun -np 2 simpleFoam -parallel > log.simpleFoam &
        plotResiduals
        reconstructPar
    else 
        simpleFoam > log.simpleFoam &
        plotResiduals
    fi
    ./createGraph.sh
done

echo "DONE!!!"
