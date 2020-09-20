#!/bin/bash
testType=$1
caseFold=$2


rho=1.2
nu=0.000015
if [ "${testType}" == "T3A" ]; then
	U=5.4
elif [ "${testType}" == "T3B" ]; then
	U=9.4
elif [ "${testType}" == "T3A-minus" ]; then
	U=19.8
fi


while read line; do
	((n++))
	Cf[$n]=$(echo "$line*2/($U*$U * $rho)" | bc -l | awk '{printf("%.8f", $1);}')
done < <(grep '^[0-9].*' "../${caseFold}/postProcessing/sampleTauW/1/line_mag(wallShearStress).xy" | awk '{print $2}')

while read line; do
	((i++))
	Rex=$(echo "$line * $U/$nu" | bc -l | awk '{printf("%7.f", $1);}')
	echo "$Rex ${Cf[$i]}"
done < <(grep '^[0-9].*' "../${caseFold}/postProcessing/sampleTauW/1/line_mag(wallShearStress).xy" | awk '{print $1}')
