#!/bin/bash

#compares two turb models, graphs resuts from two turbulent models that are passed as parameters when running the script

#for two given turbulent models
turbModel1=${1///}
turbModel2=${2///}

testFolder="flatPlate-test"

for var in "$@" ; do
	turbModel="${var///}"
	cd "${turbModel}/results"
	###for all cases starting with T
	for dir in */ ; do
		if [[ $dir =~ ^T ]] ; then
			compareFold="../../compare/${turbModel1}-${turbModel2}/${dir}"
			mkdir -p "${compareFold}"
			cp "${dir}Cf-Rex/Cf-Rex-${dir///}.dat" "${compareFold}Cf-Rex_${turbModel}.dat" 
            pwd
#			while read -r line; do
#				echo "reading line"
#				echo "${line}" >> "${compareFold}/${turbModel}.dat"
#			done < <(sed -i 's/,//g' "results/${dir///}/Cf-Rex/data.csv") 
		fi
	done

	cd "../.."
done

###loop for ploting data
cd "compare/${turbModel1}-${turbModel2}"
for dir in */; do
	cd "${dir}"
	cp "../../../Cf-Rex.gp" "./"
	gnuplot -e "turbModel1='${turbModel1}'; turbModel2='${turbModel2}'; case='${dir///}'" Cf-Rex.gp
    cp *.png ../
#	gnuplot ../../Cf-Rex.gp 
	rm "Cf-Rex.gp"
	cd ".."
done

echo "DONE!!!"

		
