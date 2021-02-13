set terminal png
set title "Comparison"
set output "comparison.png"

set xlabel "Rex"
set ylabel "Cf" offset 2
set logscale x
set logscale y
set xrange [1000:1e6]
set yrange [1e-3:3e-2]
set grid
set key right
set colorsequence podo

h(z) = 0.644 / (z**0.5)
k(w) = 0.445 / (log(0.06*w))**2

cd "./other/bez_prechodu/compare"

plot h(x) lt rgb "blue" title 'Blasius', k(x) lt rgb "green" title 'White', for [fold in system("ls")] fold."/Cf-Rex/data.dat" with linespoints pt 10 ps 0.1 lw 2 title fold, "/home/david/OpenFOAM/david-7/run/flatPlateTests/WrayAgarwalTransition/ercoftac_T3A_cf.dat" ti "Experiment"
