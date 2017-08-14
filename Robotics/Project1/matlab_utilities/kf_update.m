function [x,P,w]= kf_update(x,P, v,R,H, logflag)
%function [x,P,w] = kf_update(x,P, v,R,H, logflag)
%
% Calculate the Kalman filter update given a linear observation model of 
% the form z = H*x + r, where r is zero-mean Gaussian measurement noise
% with covariance R. 
%
% INPUTS:
%   x,P - prior state estimate (mean and covariance)
%   v - innovation, v = z - H*x for linear models
%   R - observation uncertainty (covariance)
%   H - measurement model
%   logflag - <optional> - if non-zero, sets w = log(w)
%
% OUTPUTS:
%   x,P - posterior state estimate
%   w - the update normalising constant
%
% NOTES:
%   The innovation (v) is input rather than the observation (z) to cater
%   for linearised models where v = z - h(xs) - H*(x-xs). Moreover,
%   linearised computation of v may have to account for model
%   discontinuities. See linearised_update.m for an implementation. 
%
% Tim Bailey 2005, modified 2007.

if nargin == 5, logflag = 0; end

PHt = P*H';
S = H*PHt + R;

Sc  = chol(S);  % S = Sc'*Sc
Sci = inv(Sc);  % inv(S) = Sci*Sci'
Wc = PHt * Sci; % "normalised" gain
vc = Sci'*v;    % "normalised" innovation

% Update 
x = x + Wc*vc; 
P = P - Wc*Wc';

% Update weight
D = size(v,1);
numer = -0.5 * vc'*vc; 
if logflag ~= 0
    denom = 0.5*D*log(2*pi) + sum(log(diag(Sc)));
    w = numer - denom;
else
    denom = (2*pi)^(D/2) * prod(diag(Sc));
    w = exp(numer) / denom;
end
