#!/bin/bash
i=$1
caseFold=$2
turbModel=$3

if [ $i == 'T3A-minus' ];  then
    xDown=1000000
    xUp=3000000
else
    xDown=1000
    xUp=1000000
fi

postProcess -func sampleU
postProcess -func sampleTauW

../compute-Cf-Rex.sh $i $caseFold > Cf-Rex-${i}.dat
head -n -1 Cf-Rex-${i}.dat > temp.dat; mv temp.dat Cf-Rex-${i}.dat

cd ../scripts

gnuplot -e "caseFold='$caseFold'; type='${i}'; turbModel='${turbModel}'" saveResiduals.gp 
gnuplot -e "caseFold='$caseFold'; type='${i}'; turbModel='${turbModel}'; x-down=${xDown}; x-up=${xUp}" Cf-Rex.gp 

cd ../$caseFold

resultFold="../results/${i}/Cf-Rex/"
if [ ! -d "${resultFold}" ] ; then 
    mkdir -p "${resultFold}"
    echo "creating folder"
fi

cp "./Cf-Rex-${i}.png" "${resultFold}/Cf-Rex-${i}.png"
cp "./Cf-Rex-${i}.png" "${resultFold}/../../Cf-Rex-${i}.png"
cp "./Cf-Rex-${i}.dat" "${resultFold}/data.dat"
cp "./residuals-${i}.png" "${resultFold}/../residuals-${i}.png"
