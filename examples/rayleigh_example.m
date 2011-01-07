#Calculate randomly sampled scattering angles for 
#Rayleigh scattering

clear;

#Rayleigh phase function as function of mu
mu=[-1:0.01:1]';
P=3/4.*(1+mu.^2);
figure(1);
plot(mu, P);
xlabel("mu");
ylabel("P");
title("Rayleigh phase function");
print "rayleigh_phase.pdf";
dat=[mu P];
save "rayleigh_phase_mu.dat" dat;
clear dat;

#Rayleigh phase function as function of theta
theta=acos(mu);
P=3/4.*(1+cos(theta).^2);
figure(2);
plot(theta*180/pi, P);
xlabel("theta [degrees]");
ylabel("P");
title("Rayleigh phase function");
print "rayleigh_phase_theta.pdf";
dat=[theta.*180/pi,P];
save "rayleigh_phase_theta.dat" dat;
clear dat;

# cumulative distribution
F=(3.*mu+mu.^3 + 4)./8;
figure(3);
plot(mu, F);
xlabel("mu");
ylabel("F(mu)");
print "rayleigh_cum_distr.pdf"

dat = [mu F];
save "rayleigh_cumulative.dat" dat;

clear;


#Sample mu randomly
#====================

#Vector of random numbers
r=rand(100000,1);

#Calculate mu for each random number
q = -8.*r + 4;
D = 1 + 0.25 .*q.*q;
u = (-q/2 + sqrt(D)).^(1/3);
mu = u - 1./u;

#Draw histogram
figure(4);
hist(mu,20);
title("Random sampling of Rayleigh scattering angle");
xlabel("mu");
ylabel("counts");
print "rayleigh_hist.pdf";

[y x]=hist(mu,20);
dat=[x' y'];
save "rayleigh_hist.dat" dat;
