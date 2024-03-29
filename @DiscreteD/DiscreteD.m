classdef DiscreteD < ProbDistr
% subclass < superclass
%DiscreteD - class representing random discrete integer.
%
%A Random Variable with this distribution is an integer Z
%with possible values 1,...,length(ProbMass).
%
%Several DiscreteD objects may be collected in an array,
%
%Arne Leijon, 2014-08-29, allow PseudoCount, tested
%            2012-06-12, modified definition of PseudoCount

    properties (Dependent)
    % dependent varible not store data. by get and set
        DataSize;%  size of random variable, always ==1
    end
    properties (GetAccess=public,SetAccess=public)
        ProbMass=1;%    probability-mass column vector, always normalized
        PseudoCount=0;% real scalar = assumed number of unseen observations, 
        %               to secure non-zero probability mass for all possible outcomes.
        %               In training, PseudoCount is added
        %               to each each observed frequency.
        %In case of sparse training data, set PseudoCount=0.5 or so,
        %This would correspond to Jeffreys prior in a Bayesian training model.
    end
    methods (Access=public)
        %***** Constructor method:
        function pD=DiscreteD(pMass)
        %Constructor of Discrete Distribution object,
        %or array of such objects.
        %
        %Input:
        %pMass may be a DiscreteD object, then it is simply copied, otherwise
        %pMass= vector or matrix with relative probability values, not necessarily normalized
        %       if pMass is a vector, one DiscreteD object is created
        %       if pMass is a matrix, 
        %           each ROW defines a prob mass vector,
        %           and one DiscreteD object is created for each row.
        %
            switch nargin
                % return number of input parameter in function
                case 0% nothing, default object created
                case 1
                    if isa(pMass,'DiscreteD')
                        % isa: pMass belong to DiscreteD
                        pD=pMass;%just copy it
                    else
                        if any(size(pMass) ==1) %vector with prob. mass values
                            pD.ProbMass=pMass(:);%store columnwise internally
                            % 变成一列储存在概率分布里面 numel(pD) = 1
%                         end;
%                         pMass=pMass./repmat(sum(pMass),size(pMass,1),1);%normalize
                        else
                            pD=repmat(pD,size(pMass,1),1);
                            % repete pD row colomn,row = pMass.row, colomn = 1, numel(pD) > 1 
                            for i=1:size(pMass,1)%make one object for each input ROW
                                pD(i,1).ProbMass=pMass(i,:)';%store column-wise
                            end;
                        end
                    end;
                otherwise
                    error('Too many arguments');
            end;
        end
        %
        %***** Methods for general use:
        pMass=double(pD);%  convert back to matrix with probability mass values
        %                   i.e. inverse of DiscreteD constructor
        R=rand(pD,nData);%  generate sequence of random integer samples
        [p,logS]=prob(pD,Z);%   probability mass for observed samples
        function lP=logprob(pD,z)%  log probability mass
            lP=log(prob(pD,z));
        end
        H=entropy(pD);%     entropy [bits] for the distribution
        %
        %***** Training Methods:
        pD=init(pD,x);%     initialize crudely to given data
        aState=adaptStart(pD);%     initialize accumulator data structure for data statistics
        aState=adaptAccum(pD,aState,obsData,obsWeight);
        %           collect sufficient statistics from observed data vectors,
        %           without changing the object itself
        %           (may be called repeatedly with different data subsets).
        pD=adaptSet(pD,aState);%    finally adjust the object using accumulated statistics.   
    end
    methods% get/set methods
        function pD=set.ProbMass(pD,pMass)
            if any(size(pMass) ==1)%pMass must be a vector here!
                pD.ProbMass=pMass(:)./sum(pMass);%always normlized
            else
                error('ProbMass must be a vector');
            end
        end
        function pD=set.PseudoCount(pD,c)
            if c>=0
                pD.PseudoCount=c;
            else
                warning('DiscreteD:PseudoCount','PseudoCount must be non-negative');
            end;
        end
        function D=get.DataSize(pD)
            D=1;%always
        end
    end
end