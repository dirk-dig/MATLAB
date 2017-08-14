function x=simdmc(P,p0,n)
K=size(P,1)-1; %highest no. state
sx=0:K; %state space
x=zeros(n+1,1); %initialization
if (length(p0)==1) %convert integer p0 to prob vector
p0=((0:K)==p0);
end
x(1)=finiterv(sx,p0,1); %x(m)= state at time m-1
for m=1:n
x(m+1)=finiterv(sx,P(x(m)+1,:),1);
end
