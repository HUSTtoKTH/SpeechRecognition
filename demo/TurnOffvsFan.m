clear all;

addpath('C:\Users\test\Desktop\PattRecClasses');
addpath('C:\Users\test\Desktop\PattRecClasses\GetSpeechFeatures');

load('vari_states_15trained.mat');


    words = {'Computer','Fridge' ,'TurnOn','TurnOff', 'Washer','Heater'};

    [sample,fs] = audioread(strcat('C:\Users\test\Desktop\PattRecClasses\Recordings2\TurnOff\12.wav'));
    mfccs = GetSpeechFeatures(sample, 22050, 0.03 , 13);
    
    norm_mfccs = zscore(mfccs.').';
    delta = diff(norm_mfccs,1,2);
    [m,n]=size(delta);
    delta=[zeros(m,1),delta];
    deltaDelta = diff(delta,1,2);
    [m,n]=size(deltaDelta);
    deltaDelta=[zeros(m,1),deltaDelta];
    features = [norm_mfccs; delta;deltaDelta];
    lP = logprob(hmms, features);
    plot(lP);
    set(gca,'xtick',[1:6]);
    set(gca,'XTickLabel', words)
    
    [c, i] = max(lP);
    
    disp(strcat(['Most likely word is ' words{i}]));
    
