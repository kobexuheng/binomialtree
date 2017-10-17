%enter 7 inputs as a 1*7 matrix
prompt='please enter [S,K,r,T,SIGMA,N,q] = ';
inputs=input(prompt);
%assign actual values to variables
S=inputs(1,1);
K=inputs(1,2);
r=inputs(1,3);
T=inputs(1,4);
SIGMA=inputs(1,5);
N=inputs(1,6);
q=inputs(1,7);
%calculate the matrix of underlying prices
MS=underlyingprice(S,K,r,T,SIGMA,N,q);
%calculate the matrix of call and put prices(European & American)
MCE=callpriceE(S,K,r,T,SIGMA,N,q);
MPE=putpriceE(S,K,r,T,SIGMA,N,q);
MCA=callpriceA(S,K,r,T,SIGMA,N,q);
MPA=putpriceA(S,K,r,T,SIGMA,N,q);
%calculate Greek values(Delta,Gamma,Vega,Theta,Rho)
%Delta(European call,put & American call,put)
DeltaCE=(MCE(2,1)-MCE(2,2))/(MS(2,1)-MS(2,2));
DeltaPE=(MPE(2,1)-MPE(2,2))/(MS(2,1)-MS(2,2));
DeltaCA=(MCA(2,1)-MCA(2,2))/(MS(2,1)-MS(2,2));
DeltaPA=(MPA(2,1)-MPA(2,2))/(MS(2,1)-MS(2,2));
%Gamma(European call,put & American call,put)
GammaCE=((MCE(3,1)-MCE(3,2))/(MS(3,1)-MS(3,2))-(MCE(3,2)-MCE(3,3))/(MS(3,2)-MS(3,3)))/(0.5*(MS(3,1)-MS(3,3)));
GammaPE=((MPE(3,1)-MPE(3,2))/(MS(3,1)-MS(3,2))-(MPE(3,2)-MPE(3,3))/(MS(3,2)-MS(3,3)))/(0.5*(MS(3,1)-MS(3,3)));
GammaCA=((MCA(3,1)-MCA(3,2))/(MS(3,1)-MS(3,2))-(MCA(3,2)-MCA(3,3))/(MS(3,2)-MS(3,3)))/(0.5*(MS(3,1)-MS(3,3)));
GammaPA=((MPA(3,1)-MPA(3,2))/(MS(3,1)-MS(3,2))-(MPA(3,2)-MPA(3,3))/(MS(3,2)-MS(3,3)))/(0.5*(MS(3,1)-MS(3,3)));
%Vega(European call,put & American call,put)
%take 0.001*SIGMA as delta SIGMA
VCE=callpriceE(S,K,r,T,SIGMA*1.001,N,q)-callpriceE(S,K,r,T,SIGMA*0.999,N,q);
VPE=putpriceE(S,K,r,T,SIGMA*1.001,N,q)-putpriceE(S,K,r,T,SIGMA*0.999,N,q);
VCA=callpriceA(S,K,r,T,SIGMA*1.001,N,q)-callpriceA(S,K,r,T,SIGMA*0.999,N,q);
VPA=putpriceA(S,K,r,T,SIGMA*1.001,N,q)-putpriceA(S,K,r,T,SIGMA*0.999,N,q);
VegaCE=VCE(1,1)/(0.002*SIGMA);
VegaPE=VPE(1,1)/(0.002*SIGMA);
VegaCA=VCA(1,1)/(0.002*SIGMA);
VegaPA=VPA(1,1)/(0.002*SIGMA);
%Theta(European call,put & American call,put)
ThetaCE=(MCE(3,2)-MCE(1,1))/(2*T/N);
ThetaPE=(MPE(3,2)-MPE(1,1))/(2*T/N);
ThetaCA=(MCA(3,2)-MCA(1,1))/(2*T/N);
ThetaPA=(MPA(3,2)-MPA(1,1))/(2*T/N);
%Rho(European call,put & American call,put)
%take 0.001*r as delta r
RCE=callpriceE(S,K,r*1.001,T,SIGMA,N,q)-callpriceE(S,K,r*0.999,T,SIGMA,N,q);
RPE=putpriceE(S,K,r*1.001,T,SIGMA,N,q)-putpriceE(S,K,r*0.999,T,SIGMA,N,q);
RCA=callpriceA(S,K,r*1.001,T,SIGMA,N,q)-callpriceA(S,K,r*0.999,T,SIGMA,N,q);
RPA=putpriceA(S,K,r*1.001,T,SIGMA,N,q)-putpriceA(S,K,r*0.999,T,SIGMA,N,q);
RhoCE=RCE(1,1)/(0.002*r);
RhoPE=RPE(1,1)/(0.002*r);
RhoCA=RCA(1,1)/(0.002*r);
RhoPA=RPA(1,1)/(0.002*r);
%output results of European call option
fprintf('result:\n')
fprintf('European call\n');
fprintf('\tcall prices in each node:\n');
for i=1:(N+1)
    for j=1:i
        fprintf('\tC(%d,%d)=%.4f\t',i-1,i-j,MCE(i,j));
    end
    fprintf('\n');
end  
fprintf('\tGreek values(European call):\n');
fprintf('\tDelta=%.4f\n',DeltaCE);
fprintf('\tGamma=%.4f\n',GammaCE);      
fprintf('\tVega=%.4f\n',VegaCE);
fprintf('\tTheta=%.4f\n',ThetaCE);
fprintf('\tRho=%.4f\n',RhoCE);
%output results of European put option
fprintf('European put\n');
fprintf('\tput prices in each node:\n');
for i=1:(N+1)
    for j=1:i
        fprintf('\tP(%d,%d)=%.4f\t',i-1,i-j,MPE(i,j));
    end
    fprintf('\n');
end    
fprintf('\tGreek values(European put):\n');
fprintf('\tDelta=%.4f\n',DeltaPE);
fprintf('\tGamma=%.4f\n',GammaPE);      
fprintf('\tVega=%.4f\n',VegaPE);
fprintf('\tTheta=%.4f\n',ThetaPE);
fprintf('\tRho=%.4f\n',RhoPE);
%output results of American call option
fprintf('American call\n');
fprintf('\tcall prices in each node:\n');
for i=1:(N+1)
    for j=1:i
        fprintf('\tC(%d,%d)=%.4f\t',i-1,i-j,MCA(i,j));
    end
    fprintf('\n');
end
fprintf('\tGreek values(American call):\n');
fprintf('\tDelta=%.4f\n',DeltaCA);
fprintf('\tGamma=%.4f\n',GammaCA);      
fprintf('\tVega=%.4f\n',VegaCA);
fprintf('\tTheta=%.4f\n',ThetaCA);
fprintf('\tRho=%.4f\n',RhoCA);
%output results of American put option
fprintf('American put\n');
fprintf('\tput prices in each node:\n');
for i=1:(N+1)
    for j=1:i
        fprintf('\tP(%d,%d)=%.4f\t',i-1,i-j,MPA(i,j));
    end
    fprintf('\n');
end
fprintf('\tGreek values(American put):\n');
fprintf('\tDelta=%.4f\n',DeltaPA);
fprintf('\tGamma=%.4f\n',GammaPA);      
fprintf('\tVega=%.4f\n',VegaPA);
fprintf('\tTheta=%.4f\n',ThetaPA);
fprintf('\tRho=%.4f\n',RhoPA);
