function Ui = inv_triu(U)
%function Ui = inv_triu(U)
%
% INPUT: U - upper-triangular matrix
% OUTPUT: Ui - upper-triangular inverse of U 
%
% It may be faster to use: Ui = inv(U);
%
% Tim Bailey 2009.

% Based on inv_triu in Tom Minka's Lightspeed library
if issparse(U)
    I = speye(size(U));
else
    I = eye(size(U));
end
Ui = U\I;
    
% See also:
% http://www.mathworks.de/matlabcentral/newsreader/view_thread/2558
