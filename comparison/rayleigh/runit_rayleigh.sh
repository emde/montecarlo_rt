#!/bin/bash

szas=`gawk '{print $1}' szas.dat`
lam=500

mkdir lambda$lam
for sza in $szas; do
    for alb in 0 0.2 0.5 1; do 
	sed "s/SZA/$sza/" rayleigh.inp | sed "s/ALB/$alb/" |\
	    sed "s/LAM/$lam/" > uvspec.inp
	uvspec < uvspec.inp > dummy
	gawk '(NR==1) {print $2+$3}' dummy >> \
	    f_sur_alb$alb.dat
	gawk '(NR==2) {print $4}' dummy >> \
	    f_toa_alb$alb.dat
    done 
done


for alb in 0 0.2 0.5 1; do   
    paste szas.dat f_sur_alb$alb.dat > \
	lambda$lam/flx_sur_alb$alb.dat
    paste szas.dat f_toa_alb$alb.dat > \
	lambda$lam/flx_toa_alb$alb.dat
done

rm f_*