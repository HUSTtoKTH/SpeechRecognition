function S=rand(mc,T)
%S=rand(mc,T) returns a random state sequence from given MarkovChain object.
%
%Input:
%mc=    a single MarkovChain object
%T= scalar defining maximum length of desired state sequence.
%   An infinite-duration MarkovChain always generates sequence of length=T
%   A finite-duration MarkovChain may return shorter sequence,
%   if END state was reached before T samples.
%
%Result:
%S= integer row vector with random state sequence,
%   NOT INCLUDING the END state,
%   even if encountered within T samples
%If mc has INFINITE duration,
%   length(S) == T
%If mc has FINITE duration,
%   length(S) <= T
%
%---------------------------------------------
%Code Authors:
%---------------------------------------------
% Since the initial state of aMarkov chain, and its transitions conditioned
% on the current state, can be seen as discrete random variables, you can
% use the DiscreteD class and the rand method you implemented in the
% previous step to simplify your work here.

S=zeros(1,T);%space for resulting row vector
nS=mc.nStates;

% % Initial state
pD = DiscreteD(mc.InitialProb);
S(1) = rand(pD, 1);
% % Transition state.
% if finiteDuration(mc)
%     % finite
%     i = 1;
%     while(S(i) ~= size(mc.TransitionProb,2) && i < T)
%         pD = DiscreteD(mc.TransitionProb(S(i), :)); 
%         tState = rand(pD, 1);
%         S(i+1) = tState;
%         i = i+1;
%     end
% else
%     % infinite
%     for i=2:T
%         pD = DiscreteD(mc.TransitionProb(S(i-1), :)); 
%         tState = rand(pD, 1);
%         S(i) = tState;
%     end
% end
% Get first state

% Generate rest of state sequence.
for i=2:T
    Distr = DiscreteD(mc.TransitionProb(S(i-1), :)); %Get transition probs from where we are
    state = rand(Distr, 1);
    if state == nS + 1 %Check if we reached the end
        S = S(S~=0)
        return;
    end
    S(i) = state;
end