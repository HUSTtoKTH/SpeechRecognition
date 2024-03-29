%H=entropy(pD)
%method to calculate entropy H(Z) of discrete random variable Z,
%represented by a DiscreteD object or array of DiscreteD objects
%Entropy is defined as H(Z)=E[ -log2(prob(Z)) ]
%
%Input:
%pD=    DiscreteD object or array of DiscreteD objects
%
%Result:
%H=     Entropy [bits per sample]
%       size(H)=size(pD)
%
%Arne Leijon 2004-11-24 tested

function H=entropy(pD)
pDsize=size(pD);%size of DiscreteD array
H=zeros(pDsize);%init storage for entropy values
pDlength=prod(pDsize);%number of GaussD objects
for i=1:pDlength
    H(i)=-pD(i).ProbMass'*log2(max(pD(i).ProbMass,realmin));%avoid log(0)
end;