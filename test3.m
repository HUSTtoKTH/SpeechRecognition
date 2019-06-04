clear all;

p0=[1 0]';
A=[0.9 0.1 0;0 0.9 0.1];
mc=MarkovChain(p0,A);
pD(1)=GaussD('Mean',0,'StDev',1);
pD(2)=GaussD('Mean',3,'StDev',2);
h=HMM(mc,pD);
nStates=h.nStates;
x =[-0.2 2.6 1.3 ]
pX=prob(pD,x);
[alfaHat,c]=forward(mc,pX);
betaHat=backward(mc,pX,c)

logP=logprob(h,x);