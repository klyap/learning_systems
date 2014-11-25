%% Linear Regression
% This file generates "n" random points classified using a linear function
% and calculates the average in-sample error (Ein) and 
% out-of-sample error (Eout) using classification by linear regression.

n = 100;
incorrect = 0;
incorrectout = 0;


for runs=1:1
	% Generate the points.
	 x1 = (rand(n, 1) - 0.5)*2;
	 x2 = (rand(n, 1) - 0.5)*2;
	
	% Draw a random line in the area.
	 point = (rand(2, 1) - 0.5)*2;
	 point2 = (rand(2, 1) - 0.5)*2;
	 slope = (point2(2) - point(2)) / (point2(1) - point(1));
	 intercept = point(2) - slope * point(1);
	
	% Assign the dependent values. if y(x1, x2) > x, make it +1
	 y = (x1 * slope + intercept > x2) * 2 - 1;
     
	% Return the values.
    data = horzcat(x1, x2, y);

%% Plot

% Setting up points
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

% plotting original points in blue
figure
axis([-1, 1, -1, 1])
plot (xplus, yplus, '+')
hold on
plot (xminus, yminus, 'o')
%plot (x1, x2, '*')
hold on
refline(slope,intercept)

%% Find w using Linear Regression
X = horzcat(ones([n,1]), x1, x2);

pinvX = inv(X.' * X) * X.';

w = pinvX * y;
reclass = X * w;

%% Plot reclassified points

%Setting up points
        yplus = ones([0, 0]);
        yminus = ones([0, 0]);
        xplus = ones([0, 0]);
        xminus = ones([0, 0]);
        
        %only plot points that are right so wrong pts stay blue
        for a=1:n
            if (reclass(a) > 0) &&  (y(a) > 0)
                xplus = [xplus; x1(a)];
                yplus = [yplus; x2(a)];
        
            elseif (reclass(a) < 0) &&  (y(a) < 0)
                xminus = [xminus; x1(a)];
                yminus = [yminus; x2(a)];
            else
                % increment count of incorrect classification
                incorrect = incorrect + 1;
            end
            
        end

% actually plotting

hold on
plot (xplus, yplus, '+ g')
hold on
plot (xminus, yminus, 'o g')
%plot (x1, x2, '*')
hold on
%refline(w(2),w(3))

end



%% Find Eout

% Generate test points.
	 x1out = (rand(n, 1) - 0.5)*2;
	 x2out = (rand(n, 1) - 0.5)*2;
	
     yout = (x1out * slope + intercept > x2out) * 2 - 1;
     dataout = horzcat(x1out, x2out, yout);
     
     Xout = horzcat(ones([n,1]), x1out, x2out);
     reclassout = Xout * w;
     
% Check fresh points on hypothesis function 	
for a=1:n
    if (reclassout(a) > 0) &&  (yout(a) > 0)
        continue
    elseif (reclassout(a) < 0) &&  (yout(a) < 0)
        continue
    else
        incorrectout = incorrectout + 1;
    end

end

Ein = incorrect/n/runs
Eout = incorrectout/n/runs


