
% load('vari_states_15trained.mat');
% [X,S]=rand(hmms(1),198);

% [sample,fs] = audioread('C:\Users\test\Desktop\PattRecClasses\Recordings2\Computer\1.wav');
% %words{word_i, sample_i} = sample;
% mfccs = GetSpeechFeatures(sample, fs, 0.03, 13);
% % [mfccs, f, t]=getNormalisedFeatures(sample, fs, window, bands);
% norm_mfccs = zscore(mfccs.').';

% % dynamic
% delta = diff(norm_mfccs,1,2);
% [m,n]=size(delta);
% delta=[zeros(m,1),delta];
% deltaDelta = diff(delta,1,2);
% [m,n]=size(deltaDelta);
% deltaDelta=[zeros(m,1),deltaDelta];
% features = [norm_mfccs; delta;deltaDelta];

% word_features = [word_features features];
% Time = 1/fs*(1:length(sample))';
% subplot(1,2,2)
% colormap jet;
% imagesc(Time, 1:13,word_features); 
% xlabel('Time (sec)');
% ylabel('MFCCS');
% title('Cepstrogram of one training data'); 
% colorbar('location', 'EastOutside');
% subplot(1,2,1)
% colormap jet;
% imagesc(Time, 1:13,X); 
% xlabel('Time (sec)');
% ylabel('MFCCS');
% title('Cepstrogram of rand HMM '); 
% colorbar('location', 'EastOutside');



% load('vari_states_15trained.mat');
% [X,S]=rand(hmms(1),198);

[sample,fs] = audioread('C:\Users\test\Desktop\PattRecClasses\Recordings2\TurnOff\1.wav');
%words{word_i, sample_i} = sample;
mfccs = GetSpeechFeatures(sample, fs, 0.03, 13);
% [mfccs, f, t]=getNormalisedFeatures(sample, fs, window, bands);
norm_mfccs = zscore(mfccs.').';

% dynamic
delta = diff(norm_mfccs,1,2);
[m,n]=size(delta);
delta=[zeros(m,1),delta];
deltaDelta = diff(delta,1,2);
[m,n]=size(deltaDelta);
deltaDelta=[zeros(m,1),deltaDelta];
features = [norm_mfccs; delta;deltaDelta];
word_features = [];
word_features = [word_features features];
Time = 1/fs*(1:length(sample))';
figure(1)
colormap jet;
subplot(1, 2 ,1);
imagesc(Time, 1:13,word_features); 
xlabel('Time (sec)');
ylabel('MFCCS');
title('Cepstrogram of one training data'); 
colorbar('location', 'EastOutside');


[sample,fs] = audioread('C:\Users\test\Desktop\PattRecClasses\Recordings2\Fan\1.wav');
%words{word_i, sample_i} = sample;
mfccs = GetSpeechFeatures(sample, fs, 0.03, 13);
% [mfccs, f, t]=getNormalisedFeatures(sample, fs, window, bands);
norm_mfccs = zscore(mfccs.').';

% dynamic
delta = diff(norm_mfccs,1,2);
[m,n]=size(delta);
delta=[zeros(m,1),delta];
deltaDelta = diff(delta,1,2);
[m,n]=size(deltaDelta);
deltaDelta=[zeros(m,1),deltaDelta];
features = [norm_mfccs; delta;deltaDelta];
word_features = [];
word_features = [word_features features];
Time = 1/fs*(1:length(sample))';
figure(1)
colormap jet;
subplot(1, 2 ,2);
imagesc(Time, 1:13,word_features); 
xlabel('Time (sec)');
ylabel('MFCCS');
title('Cepstrogram of one training data'); 
colorbar('location', 'EastOutside');
