import os
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import csv

#iterTime = input("Please enter latest time:\n")

#resultsTauW = open( "postProcessing/sampleTauW/" + iterTime + "/line_mag(wallShearStress).xy")
resultsTauW = open( "postProcessing/sampleTauW/1/line_mag(wallShearStress).xy")

ReX = []
CeF = []
cfBlasius = [.664]
cfTurb = [.059]
TauW = []
U = 9.4  

nu = 1.5e-5
rho = 1.2

for line in resultsTauW:
    numbsStr = line.split()
    tempX, tempTauW = [float(x) for x in numbsStr]
    tempReX = tempX * U / nu
    if tempReX != 0:
        tempCfBlasius = 0.664 / tempReX**0.5
        tempCfTurb = 0.455 / (np.log(0.06 * tempReX))**2
        cfBlasius.append(tempCfBlasius)
        cfTurb.append(tempCfTurb)
    ReX.append(tempReX)
    TauW.append(tempTauW)
    tempCeF = tempTauW /(0.5 * U**2 * rho)
    CeF.append(tempCeF)

#for line in .resultsTauW:
#    tempTauW = float(line)
#    TauW.append(tempTauW)
#    tempCeF = 2 * tempTauW / (U**2 * rho)
#    CeF.append(tempCeF)
    

#CeF.append(CeF[-1])

## exporting data
ReXFormated = ['%.2f' % elem for elem in ReX]
results = []

for zCeF, zReX in zip(CeF, ReXFormated):
    results.append('{}, {}'.format(zReX, zCeF))

with open("plot-data.csv", "w") as f:
    for row in results:
        f.write('{}\n'.format(row))
    
## ploting data       
plt.figure()

lineKOmega = plt.plot(ReX, CeF, label='kOmegaSST')
lineBlasius = plt.plot(ReX, cfBlasius, label='Blasius')
lineTurb = plt.plot(ReX, cfTurb, label='White')

axes = plt.gca()
axes.set_xlim([100, 1e6])
axes.set_ylim([0.003,0.03])

plt.xscale("log")
plt.yscale("log")
plt.xlabel("ReX")
plt.ylabel("cf")
plt.title('T3B cf - ReX')
plt.legend()

plt.savefig("plot.png")
#plt.show()
