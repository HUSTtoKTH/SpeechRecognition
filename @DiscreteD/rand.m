function R=rand(pD,nData)
%% ================================================================
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD= DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData] one row, nDara column
%
%% ===============================================================
%Code Authors: EQ2341 Pattern Recognition and Machine Learning Group 8
%% ================================================================

if numel(pD)>1  %return number of items in PD
    error('Method works only for a single DiscreteD object');
end;

%*** Insert your own code here and remove the following error message 
% All values, pD.ProbMass store columnwise internally
Values = 1:size(pD.ProbMass);
R = randsample(Values,nData,true,pD.ProbMass);