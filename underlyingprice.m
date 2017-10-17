%define the function with 7 inputs(N is the number of steps, q is the dividend)     
function [MS]=underlyingprice(S,K,r,T,SIGMA,N,q)
%calculate constants 'u' and 'd'
t=T/N;
u=exp(SIGMA*sqrt(t));
d=exp(-SIGMA*sqrt(t));
%define the matrix of underlying prices
MS=zeros(N+1);
%calculate underlying prices in every step
for i=1:(N+1)
   for j=1:i 
       MS(i,j)=S*u^(i-j)*d^(j-1);
   end
end
end