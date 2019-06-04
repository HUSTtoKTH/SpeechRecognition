clear all;

addpath('C:\Users\test\Desktop\PattRecClasses');
addpath('C:\Users\test\Desktop\PattRecClasses\GetSpeechFeatures');

load('vari_states_15trained.mat');
for index = 1:6
    % disp('Press enter to start.')
    % pause
    % ar = audiorecorder(22050,16,1);
    % disp('Start speaking.')
    % recordblocking(ar, 3);
    % disp('End of Recording.');
    % play(ar);
    
    words = {'Computer','Fridge' ,'TurnOn','TurnOff', 'Washer','Heater'};
    % inputWord = getaudiodata(ar);
    % filename = strcat('C:\Users\test\Desktop\PattRecClasses\Recordings2\Save\test.wav'); 
    % audiowrite(filename,inputWord,22050);
    [sample,fs] = audioread(strcat('C:\Users\test\Desktop\PattRecClasses\Recordings2\', words{index}, '\', int2str(2), '.wav'));
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
    subplot(2,3,index);
    plot(lP);
    set(gca,'xtick',[1:6]);
    set(gca,'XTickLabel', words)
    xlabel(strcat("Real Input word is",words{index}));
    ylabel('matched-degree'); 
    [c, i] = max(lP);
    
    disp(strcat(['Most likely word is ' words{i}]));
    

end