function [x,P,w] = linearised_update(func,dfunc, x,P, z,R, xs, varargin)
%function [x,P,w] = linearised_update(func,dfunc, x,P, z,R, xs, ...)
%
% Perform linearised fusion of a measurement z with a prior state estimate
% (x,P) given a measurement model of the form: z = func(x,...) + r, where r
% is zero-mean Gaussian measurement noise with covariance R.
%
% INPUTS:
%   func - handle to the nonlinear function, use either @myfunc or 'myfunc'
%   dfunc - handle to function for comparing measurements, v = dfunc(z1,z2)
%   x,P - mean and covariance of parameter x
%   z,R - measurement and its noise covariance
%   xs - linearisation point for func(x,...) with respect to x
%   ... - optional arguments (p1,p2,etc), such that z = func(x,p1,p2,etc) 
%
% OUTPUTS:
%   x,P - updated mean and covariance of parameter x
%   w - weight (or evidence) of fusion
%
% Tim Bailey 2007.

if isempty(dfunc), dfunc = @default_dfunc; end

H = numerical_jacobian(xs, func, dfunc, [], varargin{:});
zpred = feval(func, xs, varargin{:}) + H*(x-xs);
v = feval(dfunc, z, zpred);

[x,P,w] = kf_update(x,P, v,R,H);   

%
%

function v = default_dfunc(z1, z2)
v = z1 - z2;
