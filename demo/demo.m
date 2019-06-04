clear all;

addpath('C:\Users\test\Desktop\PattRecClasses');
addpath('C:\Users\test\Desktop\PattRecClasses\GetSpeechFeatures');

clear all
load('vari_states_15trained.mat');
addpath('C:\Users\test\Desktop\PattRecClasses');
addpath('C:\Users\test\Desktop\PattRecClasses\GetSpeechFeatures');
% ar = audiorecorder(22050,16,1);
% disp('Start speaking.')
% recordblocking(ar, 3);
% disp('End of Recording.');
% play(ar);

words = {'Computer','Fridge' ,'TurnOn','TurnOff', 'Washer','Heater'};
% inputWord = getaudiodata(ar);
% filename = 'C:\Users\test\Desktop\PattRecClasses\Recordings2\Save\test.wav'; 
% audiowrite(filename,inputWord,22050);
[sample,fs] = audioread('C:\Users\test\Desktop\PattRecClasses\Recordings2\Save\1.wav');
mfccs = GetSpeechFeatures(sample, fs, 0.03 , 13);

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