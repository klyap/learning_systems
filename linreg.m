n = 100;
ext = 1;
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

%Setting up points
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

% actually plotting
figure
axis([-1, 1, -1, 1])
plot (xplus, yplus, '+')
hold on
plot (xminus, yminus, 'o')
%plot (x1, x2, '*')
hold on
refline(slope,intercept)

%% Find w using Lin Reg
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
        
        %only plot points that are right st wrong pts stay blue
        for a=1:n
            if (reclass(a) > 0) &&  (y(a) > 0)
                xplus = [xplus; x1(a)];
                yplus = [yplus; x2(a)];
        
            elseif (reclass(a) < 0) &&  (y(a) < 0)
                xminus = [xminus; x1(a)];
                yminus = [yminus; x2(a)];
            else
                incorrect = incorrect + 1;
            end
            
        end

% actualyl plotting

hold on
plot (xplus, yplus, '+ g')
hold on
plot (xminus, yminus, 'o g')
%plot (x1, x2, '*')
hold on
%refline(w(2),w(3))


%% Check how correct it is (compare new classification to target)
%{
for b=1:n
    if data(b,1) * w(2) + w(1) < data(b,2) 
        if (data(b,3) < 0)    
          incorrect = incorrect + 1;
        end
        
    else
        if (data(b,3) > 0) 
          incorrect = incorrect + 1;
        end
    end
end
%}

% another way to classify pts with hypothesis
%{
    ynew = (data(:, 1) * w(3) + w(2) > x2) * 2 - 1;
    %for debugging
    check = y + ynew;
    for b=1:n
        if ynew(b) ~= data(b,3)   
            incorrect = incorrect + 1;
        end
    end
%}

%using reclass
%{
for b=1:n
        if reclass(b) ~= y(b)   
            incorrect = incorrect + 1;
        end
%}
end



%% Find Eout

% Generate the points.
	 x1out = (rand(n, 1) - 0.5)*2;
	 x2out = (rand(n, 1) - 0.5)*2;
	
     yout = (x1out * slope + intercept > x2out) * 2 - 1;
     dataout = horzcat(x1out, x2out, yout);
     
     Xout = horzcat(ones([n,1]), x1out, x2out);
     reclassout = Xout * w;
% Check fresh points on hypothesis function 	
%{
for b=1:n
    if dataout(b,1) * w(3) + w(2) < dataout(b,2) 
        if (dataout(b,3) < 0)
          incorrectout = incorrectout + 1;
        end
    else
        if (dataout(b,3) > 0) 
          incorrectout = incorrectout + 1;
        end
    end
end
%}

%using same function as plotting
for a=1:n
    if (reclassout(a) > 0) &&  (yout(a) > 0)
        continue
    elseif (reclassout(a) < 0) &&  (yout(a) < 0)
        continue
    else
        incorrectout = incorrectout + 1;
    end

end

avg = incorrect/n/runs
Eout = incorrectout/n/runs


