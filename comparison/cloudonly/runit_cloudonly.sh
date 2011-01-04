#!/bin/bash

taus=`gawk '{print $1}' tau.dat`
for sza in 0 30 60; do
    for alb in 0 0.2 0.5 1; do
	for gg in 0 0.5 0.85; do
	    for tau in $taus; do 
		sed "s/TAU/$tau/" cloudonly.inp | sed "s/SZA/$sza/" | \
		    sed "s/ALB/$alb/" | sed "s/GG/$gg/" > uvspec.inp
		uvspec< uvspec.inp > dummy
		gawk '(NR==1) {print $2+$3}' dummy >> \
		    f_sur_sza$sza\_gg$gg\_alb$alb.dat
		gawk '(NR==2) {print $4}' dummy >> \
		    f_toa_sza$sza\_gg$gg\_alb$alb.dat
	    done
	done
    done
done

for sza in 0 30 60; do
 for alb in 0 0.2 0.5 1; do 
     for gg in 0 0.5 0.85; do
    
	 paste tau.dat f_sur_sza$sza\_gg$gg\_alb$alb.dat > \
	     flx_sur_sza$sza\_gg$gg\_alb$alb.dat
	 paste tau.dat f_toa_sza$sza\_gg$gg\_alb$alb.dat > \
	     flx_toa_sza$sza\_gg$gg\_alb$alb.dat
     done
 done
done

rm f_*