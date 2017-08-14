function M = gauss_mutual_information(P, idx)
%function M = gauss_mutual_information(P, idx)
%
% INPUTS:  
%   P - covariance matrix
%   idx - index of subspace
%
% OUTPUT: H - entropy
%
%
% Tim Bailey 2008. 

idx = unique(idx); % ensure no repeated indices
idy = idx_other(idx, size(P,1));

P11 = P(idx,idx);
P12 = P(idx,idy);
P22 = P(idy,idy);
Pc = P11 - P12*inv_posdef(P22)*P12';
M = -0.5 * log(det(P11)/det(Pc));
