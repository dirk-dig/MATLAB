function [x,P] = kf_update_joseph_modified(x,P,v,R,H)
%function [x,P] = kf_update_joseph_modified(x,P,v,R,H)
%
% Kalman update that uses the Joseph form to compute the posterior
% covariance. The implementation is the same as for kf_update_joseph.m
% but with (hopefully) improved numerics. 
%
% Tim Bailey 2011.

% Inverse of innovation covariance
PHt = P*H';
Si = inv_posdef(H*PHt + R);

% Kalman gain
W = PHt*Si;

% State update
x = x + W*v; 

% Joseph-form covariance update
C = eye(size(P)) - W*H;
P = transform_posdef(P,C) + transform_posdef(R,W);
PSD_check = chol(P);
