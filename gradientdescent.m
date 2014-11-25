
iteration = 0;
u = 1;
v = 1;
n = 0.1;

while iteration < 15
    
    E = (u*exp(v) - 2*v*exp(-u))^2;
   if E <= 10^(-14)
       break
   end
    gradEu = 2*(u*exp(v) - 2*v*exp(-1 * u))*(exp(v)+2*v*exp(-u));
    unew = u - n * gradEu;
    u = unew;
        
    gradEv = 2*(u*exp(v) - 2*v*exp(-1 * u))*(u*exp(v)-2*exp(-u));
    vnew = v - n * gradEv;
    v = vnew;
    
    iteration = iteration + 1
    E
    u
    v
end