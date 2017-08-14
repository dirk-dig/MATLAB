function x=finiterv(s,p,m)
% returns m samples
% of finite (s,p) rv
%s=s(:);p=p(:);
r=rand(m,1);
cdf=cumsum(p);
x=s(1+count(cdf,r));