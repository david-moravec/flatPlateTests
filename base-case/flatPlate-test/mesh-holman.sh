#!/bin/bash

rm mesh-holman-xy.dat
touch mesh-holman-xy.dat
rm mesh-holman.p2dfmt
touch mesh-holman.p2dfmt

#extract x and y coordinates form file
while read line; do    
    echo $line >> mesh-holman-xy.dat
done < <(grep '^\s' "./mesh-holman.dat" | awk '{print $1, $2}')

echo "  1" >> mesh-holman.p2dfmt
echo "  636     106" >> mesh-holman.p2dfmt

while read line; do
    ((n++))
    x[$n]=$line
    if [[ "$n" -eq 3 ]]; then
        echo ${x[@]} >> mesh-holman.p2dfmt
        n=0
    fi

done < <(grep '[0-9].*' "./mesh-holman-xy.dat" | awk '{print $1;list[i++]=$2}END{for(j=0;j<i;j++){print list[j];}}')
rm -r constant/polyMesh

plot3dToFoam -2D 0.01 -noBlank mesh-holman.p2dfmt
autoPatch -overwrite 90

cd constant/polyMesh

rm boundary-tmp
touch boundary-tmp

head -n32 boundary >> boundary-tmp
tail -n +27 boundary >> boundary-tmp

sed -i '0,/auto0/{s/auto0/bottom/}' boundary-tmp
sed -i '0,/auto0/{s/auto0/flatplate/}' boundary-tmp
sed -i '0,/635/{s/635/35/}' boundary-tmp
sed -i '0,/635/{s/635/600/}' boundary-tmp
sed -i '0,/patch/{s/patch/wall/}' boundary-tmp
sed -i 's/auto1/back/g' boundary-tmp
sed -i 's/auto2/front/g' boundary-tmp
sed -i 's/auto3/inlet/g' boundary-tmp
sed -i 's/auto4/outlet/g' boundary-tmp
sed -i 's/auto5/top/g' boundary-tmp

cp boundary-tmp boundary
