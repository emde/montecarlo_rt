domain_height=2;   # height of domain 
tautot=10;         # optical thickness
sza=0*pi/180;     # solar zenith angle 
N=1000;            # number of photons
g=0.85;            # Asymmetry parameter for Henyey-Greenstein phase function

boa_flx=0; toa_flx=0;

for np=1:N
  
  dx(1)=0;
  dx(2)=sin(sza); 
  dx(3)=-cos(sza); 
  pz=domain_height;
  
  while(1==1) 
    
    r=rand;  # Random tau
    tau=-log(r);
    
    if(dx(3)!=0.0) # else the photon stays at the same height pz
       s=tau/tautot*domain_height;
       pz=pz+s*dx(3);
    endif
    
    if(pz<0)
      boa_flx ++;
      break;
    elseif(pz > domain_height)
      toa_flx ++;
      break; 
    endif
    
    r=rand;   # Random scattering angle (Henyey-Greenstein)
    a=(1-g*g)/(g*(2*r-1)+1);
    mu = (-a*a+g*g+1)/(2*g);
    
    r=rand;  # Random phi
    phi= 2*pi*r;
    
    if( dx(1)==0. && dx(2)==0.)  # sample new direction
      u(1)=1.;                   
      u(2)=1.;
    else 
      u(1)=-dx(2);
      u(2)=dx(1);
    endif
    u(3)=0.;
    norm=sqrt(u(1)^2+u(2)^2+u(3)^2);
    u./=norm;
    
    v(1) = -dx(3)*u(2);
    v(2) = dx(3)*u(1);
    v(3) = dx(1)*u(2) - dx(2)*u(1);
    norm=sqrt(v(1)^2+v(2)^2+v(3)^2);
    v./=norm;
    
    if (mu != 1.0)  # if mu=1 the direction is not changed
      dx= cos(phi).*u + sin(phi).*v  + dx.* mu/sqrt(1-mu*mu); 
    endif
    norm=sqrt(dx(1)*dx(1)+dx(2)*dx(2)+dx(3)*dx(3));
    dx./=norm;
  endwhile
endfor

disp(['Counts       TOA: ',num2str(toa_flx),'  BOA: ',num2str(boa_flx)]);
disp(['Transmission TOA: ',num2str(toa_flx/N*cos(sza)), \
      '  BOA: ', num2str(boa_flx/N*cos(sza))]);
disp(['Error        TOA: ', \
     num2str(sqrt((N-toa_flx)/(N*toa_flx))*cos(sza)),\ 
     '  BOA: ', num2str(sqrt((N-toa_flx)/(N*boa_flx))*cos(sza))]);
