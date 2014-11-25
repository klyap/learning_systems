%% Stochastic Gradient Descent
% This file generates "n" random points classified using a linear function
% and calculates the average iterations needed (avgIterations) and 
% out-of-sample error (Eout) using classification by stochastic gradient
% descent.

N = 100; % number of points
n = 0.01;

for runs=1:1
	
    % Generate the points.
	 x1 = (rand(N, 1) - 0.5)*2;
	 x2 = (rand(N, 1) - 0.5)*2;
	
	% Draw a random line in the area.
	 point = (rand(2, 1) - 0.5)*2;
	 point2 = (rand(2, 1) - 0.5)*2;
	 slope = (point2(2) - point(2)) / (point2(1) - point(1));
	 intercept = point(2) - slope * point(1);
	
	% Assign the dependent values. if y(x1, x2) > x, make it +1
	 y = (x1 * slope + intercept > x2) * 2 - 1;
    
    %Classify points
        yplus = ones([0, 0]);
        yminus = ones([0, 0]);
        xplus = ones([0, 0]);
        xminus = ones([0, 0]);
        
        for a=1:n
            if x1(a) * slope + intercept > x2(a)
                xplus = [xplus; x1(a)];
                yplus = [yplus; x2(a)];
            else
                xminus = [xminus; x1(a)];
                yminus = [yminus; x2(a)];
            end
        end
    

      %% Find Eout

    % Generate the points.
	 x1out = (rand(N, 1) - 0.5)*2;
	 x2out = (rand(N, 1) - 0.5)*2;
	
     yout = (x1out * slope + intercept > x2out) * 2 - 1;
    
     
     Xout = horzcat(ones([N,1]), x1out, x2out);

        
    %set weights
    w = [0 0 0];
 
    %% do log reg
    iteration = 0;
    sumIterations = 0;
    sum = 0;

    for run=1:100

        while 1
            iteration = iteration + 1;
            p = randperm(N);
            wnew = w;
            for i = 1:N
                x2i = x2(p(i));
                x = x1(p(i));
                xvect = [1 x x2i];

                Ein = -(y(p(i))*xvect)/(1 + exp(y(p(i))*dot(wnew.',xvect)));
                wnew = wnew - (n * Ein);
            end

            check = norm(w - wnew);

            if check < 0.01
                break
            end

            w = wnew;
        end


        sumIterations = sumIterations + iteration;

        for a=1:N
           Ein_out = log(1 + exp(-yout(a)*dot(w, Xout(a,:))));
           sum = sum + Ein_out;
        end
        
     end % of runs
 
    avgIterations = sumIterations / run
    avgEout = sum / N / run
 

end