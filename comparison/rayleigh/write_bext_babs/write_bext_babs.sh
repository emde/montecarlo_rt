#!/bin/bash

for lam in 300 320 350 380 400 500; do

    sed "s/LAM/$lam/" rayleigh.inp | uvspec &> dummy
    
    # Verbose output for optical properties has 23 columns.
    # $1 level $3 altitude $5 dtau Rayleigh $23 absorption
    
    gawk '(NF==23 && $1!="#" && $1!="sum"){print $1, $3, $5, $23}' dummy >\
	    tau_abs.dat
	    
    sed "s/LAM/$lam/" kext_kabs.py | python
    
done 



