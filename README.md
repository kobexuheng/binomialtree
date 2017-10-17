# binomialtree
CRR binomial tree computation for Eu, Am call,put options

6 m-files:

1.binomialtree.m
Run binomialtree.m. It will request us to enter 7 parameters in the form of [S,K,r,T,SIGAMA,N,q].
S is the underlying price at time 0.
K is the strike. 
r is the risk-free rate.
T is the tenor.
SIGMA is the volatility.
N is the number of steps.
q is the dividend.
Then it will output all the option prices and Greek values of European(call and put) and American(call and put) options.



2.underlyingprice.m
A m-file function. Enter underlyingprice(S,K,r,T,SIGAMA,N,q) to output the matrix of underlying prices.

3.callpriceE.m
A m-file function. Enter callpriceE(S,K,r,T,SIGAMA,N,q) to output the matrix of European call prices.

4.putpriceE.m
A m-file function. Enter putpriceE(S,K,r,T,SIGAMA,N,q) to output the matrix of European put prices.

5.callpriceA.m
A m-file function. Enter callpriceA(S,K,r,T,SIGAMA,N,q) to output the matrix of American call prices.

6.putpriceA.m
A m-file function. Enter putpriceA(S,K,r,T,SIGAMA,N,q) to output the matrix of American put prices.
