    clear
% test Markov chain rand function
%mc=MarkovChain(pInit,pTrans);%creates, with given InitialProb,TransitionProb
    mc=MarkovChain([0.75;0.25],[0.99 0.01;0.03 0.97]);
    testS = rand(mc,10000);
    tabulate(testS);
%h=HMM('MarkovChain',mc,'OutputDistr',pDgen);
    pD(1) = GaussD('Mean',0,'StDev',1);
    pD(2) = GaussD('Mean',3,'StDev',2);
    hmm1 = HMM(mc,pD);
    [x1,s1]=rand(hmm1,10000);
    Ex = mean(x1);
    Vx = var(x1);
%plot 500 contiguous samples X from the HMM
    [x2,s2] = rand(hmm1,500);
    figure;
    plot(x2);title('500 samples from HMM');xlabel('Time t');ylabel('Output Xt');

% % new HMM plot 500 contiguous samples X from the HMM
    newpD(1) = GaussD('Mean',0,'StDev',1);
    newpD(2) = GaussD('Mean',0,'StDev',2);
    hmm2 = HMM(mc,newpD);
    [x3,s3] = rand(hmm2,500);
    figure;
    plot(x3);title('500 samples from new HMM');xlabel('Time t');ylabel('Output Xt');
% test finite-duration HMM
    newMc=MarkovChain([0.75;0.25],[0.4 0.5 0.1;0.4 0.4 0.2]);
    hmm3 = HMM(newMc,pD);
    length = zeros(1,100);
    for i=1:100
        [x4,s4] = rand(hmm3, 500);
        length(i) = numel(s4);
    end
    mean = mean(length)
    max = max(length)
    min = min(length)
%  test with vectoc Gaussian
    vectorpD(1) = GaussD('Mean',[10 -10],'Covariance',[2 1;1 4],'AllowCorr',true);
    vectorpD(2) = GaussD('Mean',[0 0],'Covariance',[4 1;1 2],'AllowCorr',true);
    hmm4 = HMM(mc,vectorpD);
% %plot 500 contiguous samples X from the HMM
    [x5,s5] = rand(hmm4,500);
    figure;
    plot(x5(1,:))
    hold on;
    plot(x5(2,:));title('500 samples from vector Gaussian');xlabel('Time t');ylabel('Output Xt');
