mu = function rayleigh_sample(N)

#Sample mu randomly
#====================

#Vector of random numbers
r=rand(N,1);

#Calculate mu for each random number
q = -8.*r + 4;
D = 1 + 0.25 .*q.*q;
u = (-q/2 + sqrt(D)).^(1/3);
mu = u - 1./u;


