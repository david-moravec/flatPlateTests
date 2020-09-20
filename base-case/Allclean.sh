#!/bin/bash

cd ${1}
rm -r 0.* 1  postProcessing 
rm *.csv *.png log*
rm *.foam
cd ../..

