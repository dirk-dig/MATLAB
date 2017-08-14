function [y, Y] = unscented_transform_additive(func, dfunc, x, P, q, Q, varargin)
%function [y, Y] = unscented_transform_additive(func, dfunc, x, P, q, Q, ...)
%
% INPUTS:
%   func - function handle (@myfunc) or string ('myfunc') for non-linear transform.
%   dfunc - function handle (or string) for residual between two transformed values: e = mydfunc(y1, y2).
%   x, P - initial mean and covariance.
%   q, Q - mean and covariance of additive component.
%   ... - optional arguments such that 'func' has form: y = myfunc(x, ...).
%
% OUTPUTS:
%   y, Y - transformed mean and covariance.
%
% This function performs an unscented transform for functions with a simple additive 
% component. That is functions of the form: y = f(x) + q, where x and q are Gaussian with 
% covariances P and Q, respectively. 
%
% For functions of the form: y = f(x) + G*q, where G is a matrix, simply perform the linear 
% transformation beforehand. For example,
%   [y, Y] = unscented_transform_additive_noise(@f, @fdiff, x, P, G*q, G*Q*G', ...)
%
% For further notes on the use of "unscented_transform_additive", see the help 
% information for "unscented_transform".
%
% Tim Bailey 2006.

% Set up some values
D = length(x);  % state dimension
N = D*2 + 1;    % number of samples
scale = 3;      % want scale = D+kappa == 3
kappa = scale-D;

% Create samples
%Ps = chol(P)' * sqrt(scale); 
Ps = sqrt_posdef(P) * sqrt(scale); 
ss = [x, repvec(x,D)+Ps, repvec(x,D)-Ps];

% Transform samples according to function 'func'
if isempty(dfunc), dfunc = @default_dfunc; end
ys = feval(func, ss, varargin{:});  % compute (possibly discontinuous) transform
base = repvec(ys(:,1), N);          % set first transformed sample as the base
delta = feval(dfunc, base, ys);     % compute correct residual
ys = base - delta;                  % offset ys from base according to correct residual

% Calculate predicted observation mean
idx = 2:N;
y = (2*kappa*ys(:,1) + sum(ys(:,idx),2)) / (2*scale); 

% Calculate new unscented covariance
dy = ys - repvec(y,N);
Y  = (2*kappa*dy(:,1)*dy(:,1)' + dy(:,idx)*dy(:,idx)') / (2*scale);
% Note: if x is a matrix of column vectors, then x*x' produces the sum of outer-products.

% Add noise
y = y + q;
Y = Y + Q;

%
%

function e = default_dfunc(y1, y2)
e = y1 - y2;

%
%

function x = repvec(x,N)
x = x(:, ones(1,N));
