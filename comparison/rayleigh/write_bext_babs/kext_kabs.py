from pylab import *

x=loadtxt('tau_abs.dat')
lam=LAM

data=zeros((49,3))
# Calculate mean values for each layer
for i in range(1, 49):
    data[i,0] = x[i,1] 
    data[i,1] = x[i,2]/(x[i-1,1]-x[i,1])
    data[i,2] = x[i,3]/(x[i-1,1]-x[i,1]);

    
data[0,:]=[115., 0., 0.]

savetxt('bsca_babs_lambda'+str(lam)+'.dat', data, fmt='%10.6f')
