%define the function with 7 inputs(N is the number of steps, q is the dividend)     
function [MC]=callpriceA(S,K,r,T,SIGMA,N,q)
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
%define the matrix of call prices(American)
MC=zeros(N+1);
%calculate call prices(payoffs) in time N
for j=1:(N+1)
   if(MS(N+1,j)>K)
      MC(N+1,j)=MS(N+1,j)-K;
   else
      MC(N+1,j)=0;
   end
end
%calculate 'p'(the probability of St going up)
p=(exp((r-q)*t)-d)/(u-d);
%calculate all call prices(American)
for i=N:-1:1
    for j=1:i
      MC(i,j)=max(exp(-r*t)*(MC(i+1,j)*p+MC(i+1,j+1)*(1-p)),MS(i,j)-K);
    end
end
end