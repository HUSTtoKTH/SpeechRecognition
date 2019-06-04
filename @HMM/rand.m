

function [X,S]=rand(h,nSamples)
%[X,S]=rand(h,nSamples);generates a random sequence of data
%from a given Hidden Markov Model.
%
%Input:
%h=         HMM object
%nSamples=  maximum no of output samples (scalars or column vectors)
%
%Result:
%X= matrix or row vector with output data samples
%S= row vector with corresponding integer state values
%   obtained from the h.StateGen component.
%   nS= length(S) == size(X,2)= number of output samples.
%   If the StateGen can generate infinite-duration sequences,
%       nS == nSamples
%   If the StateGen is a finite-duration MarkovChain,
%       nS <= nSamples
%
%----------------------------------------------------
%Code Authors:
%----------------------------------------------------

if numel(h)>1
    error('Method works only for a single object');
end;
%h=HMM(mc,pD) creates a HMM with StateGen=mc, and OutputDistr=pD
mc = h.StateGen;
% generate souce state
S = rand(mc,nSamples)
% generate observed output
dataSize = DataSize(h);
X=zeros(dataSize, numel(S));
for i=1:numel(S)
    % the distributation of S(i)
    pD = h.OutputDistr(S(i));
    % use the rand method in distributaion to generate the data with dataSize
    rowOfData = rand(pD,1);
    % transfer into column and save into X i column
    X(:,i) = rowOfData(:);
end

end