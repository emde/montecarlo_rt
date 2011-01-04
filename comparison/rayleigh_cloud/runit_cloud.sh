#!/bin/bash

taus=`gawk '{print $1}' tau.dat`

for lam in 320 350 400 500; do
    
    mkdir lambda$lam
    for tau in $taus; do
	for alb in 0 0.2 0.5 1; do 
	    sed "s/TAU/$tau/" cloud.inp | sed "s/ALB/$alb/" |\
		sed "s/LAM/$lam/" > uvspec.inp
	    uvspec < uvspec.inp > dummy
	    gawk '(NR==1) {print $2+$3}' dummy >> \
		f_sur_alb$alb.dat
	    gawk '(NR==2) {print $4}' dummy >> \
		f_toa_alb$alb.dat
	done 
    done
    
    
    for alb in 0 0.2 0.5 1; do   
	paste tau.dat f_sur_alb$alb.dat > \
	    lambda$lam/flx_sur_alb$alb.dat
	paste tau.dat f_toa_alb$alb.dat > \
	    lambda$lam/flx_toa_alb$alb.dat
    done

    rm f_*

done