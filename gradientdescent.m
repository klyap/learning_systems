%% Coordinate Descent
% This file takes in imported classified data sets for 
% training (x1, x2) with their classification (y)
% as well as for testing (x1out, x2out) with their classification (yout).
% It finds the error after 15 iterations.

iteration = 0;
u = 1;
v = 1;
n = 0.1; %learning rate

while iteration < 15
   
   % nonlinear error surface
   E = (u*exp(v) - 2*v*exp(-u))^2;
   
   if E <= 10^(-14)
       break
   end
   
   %partial derivative of E with respect to u
    gradEu = 2*(u*exp(v) - 2*v*exp(-1 * u))*(exp(v)+2*v*exp(-u));
    unew = u - n * gradEu;
    u = unew;
        
    %partial derivative of E with respect to v
    gradEv = 2*(u*exp(v) - 2*v*exp(-1 * u))*(u*exp(v)-2*exp(-u));
    vnew = v - n * gradEv;
    v = vnew;
    
    iteration = iteration + 1

end

    E
    u
    v