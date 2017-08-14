% MATLAB Script
% Burning-in
% (i.e. Remove samples that may be affected by initial condition)
X = [ 0 1 0 ]'; % Cloudy
T = [ 8 2 0 ; 4 4 2 ; 2 6 2 ]' / 10;
%data = ['suny';'cloudy';'rainy'];
% celldata = cellstr(data);
for n = 1 : 10000 
X = sample(T * X);
end
% Sampling
X_tally = [ 0 0 0 ]';
for n = 1 : 10000
X = sample( T * X );
X_tally = X_tally + X;
end
X_tally = X_tally / 10000;
