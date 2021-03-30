set terminal png
set title "residuals ".type
set output "../".caseFold."/residuals-".type.".png"

set logscale y
set title "Residuals"
set ylabel 'Residual'
set xlabel 'Iteration'
plot "< cat ../".caseFold."/log.simpleFoam | grep 'Solving for Ux' | cut -d' ' -f9 | tr -d ','" title 'Ux' with lines,\
"< cat ../".caseFold."/log.simpleFoam | grep 'Solving for Uy' | cut -d' ' -f9 | tr -d ','" title 'Uy' with lines,\
"< cat ../".caseFold."/log.simpleFoam | grep 'Solving for Uz' | cut -d' ' -f9 | tr -d ','" title 'Uz' with lines,\
"< cat ../".caseFold."/log.simpleFoam | grep 'Solving for omega' | cut -d' ' -f9 | tr -d ','" title 'omega' with lines,\
"< cat ../".caseFold."/log.simpleFoam | grep 'Solving for k' | cut -d' ' -f9 | tr -d ','" title 'k' with lines,\
"< cat ../".caseFold."/log.simpleFoam | grep 'Solving for p' | cut -d' ' -f9 | tr -d ','" title 'p' with lines,\
"< cat ../".caseFold."/log.simpleFoam | grep 'Solving for R' | cut -d' ' -f9 | tr -d ','" title 'R' with lines, \
"< cat ../".caseFold."/log.simpleFoam | grep 'Solving for gamma' | cut -d' ' -f9 | tr -d ','" title 'gamma' with lines
