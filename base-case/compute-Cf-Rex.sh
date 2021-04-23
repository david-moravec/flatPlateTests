#!/bin/bash
testType=$1


rho=1.2
nu=0.000015
if [ "${testType}" == "T3A" ]; then
	U=5.4
elif [ "${testType}" == "T3B" ]; then
	U=9.4
elif [ "${testType}" == "T3A-minus" ]; then
	U=19.8
fi
fold="./postProcessing/surfaces/1/wallShearStress_wall.raw"
#fold="./postProcessing/sampleTauW/1/line_mag\(wallShearStress\).xy"


while read line; do
	((n++))
    Cf[$n]=$(echo "$line*(-2)/($U*$U * $rho)" | bc -l | awk '{printf("%.8f", $1);}')
    echo $line
done < <(grep '^[0-9].*' $fold | awk '{print $5}')

while read line; do
	((i++))
	Rex=$(echo "$line * $U/$nu" | bc -l | awk '{printf("%7.f", $1);}')
	echo "$Rex ${Cf[$i]}"
done < <(grep '^[0-9].*' $fold | awk '{print $1}')
