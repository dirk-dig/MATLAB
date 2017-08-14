function [y,Y] = linearised_transform(func,dfunc, x,X, q,Q, xs,qs, varargin)
%function [y,Y] = linearised_transform(func,dfunc, x,X, q,Q, xs,qs, ...)
%
% Given two independent Gaussian variables, (x,X) and (q,Q), transform them
% according to the nonlinear function y = func(x,q,...). This function is
% linearised about the points (xs,qs).
%
% INPUTS:
%   func - handle to the nonlinear function, use either @myfunc or 'myfunc'
%   dfunc - handle to function for comparing outputs, v = dfunc(y1,y2)
%   x,X - mean and covariance of parameter x
%   q,Q - mean and covariance of parameter q
%   xs,qs - linearisation points for x and q, respectively
%   ... - optional arguments (p1,p2,etc), such that y = func(x,q,p1,p2,etc) 
%
% OUTPUTS:
%   y,Y - transformed mean and covariance
%
% Tim Bailey 2007, modified 2009.

F = numerical_Jacobian(xs, func, dfunc, [], qs, varargin{:});
G = numerical_Jacobian(qs, @funcq, dfunc, [], xs, func, varargin{:});

yf = feval(func, xs, qs, varargin{:});
ylin = F*(x-xs) + G*(q-qs);

y = yf + ylin;
Y = F*X*F' + G*Q*G';

%
%

function y = funcq(q,x, func, varargin)
y = feval(func, x,q, varargin{:});
