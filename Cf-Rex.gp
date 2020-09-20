set terminal png
set title case 
set output case."-".turbModel1."-".turbModel2.".png"

set xlabel "Rex"
set ylabel "Cf" offset 2
set logscale x
set logscale y
set xrange [1000:1e6]
set yrange [1e-3:3e-2]
set grid

set key right

h(z) = 0.644 / (z**0.5)
k(w) = 0.445 / (log(0.06*w))**2

plot h(x) lt rgb "blue" title 'Blasius', k(x) lt rgb "green" title 'White', "Cf-Rex_".turbModel1.".dat" with linespoints pt 7 ps 0.1 lt rgb "red" title turbModel1, "Cf-Rex_".turbModel2.".dat" with linespoints pt 7 ps 0.1 lt rgb "black" title turbModel2 
