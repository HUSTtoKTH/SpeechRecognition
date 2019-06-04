directories = {'Computer','Fridge' ,'TurnOn','TurnOff', 'Washer','Heater'};
recordingDir = 'C:\Users\test\Desktop\PattRecClasses\Recordings2\';
addpath('C:\Users\test\Desktop\PattRecClasses');
addpath('C:\Users\test\Desktop\PattRecClasses\GetSpeechFeatures');
load('vari_states_15trained.mat');
for index = 1:length(directories)
    for j = 13:15
        [sample,fs] = audioread(strcat(recordingDir, directories{index}, '\', int2str(j), '.wav'));
        %words{word_i, sample_i} = sample;
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
        % plot(lP);
        [c, i] = max(lP);
        disp(strcat(['Original word is ' directories{index}]));
        disp(strcat(['Most likely word is ' directories{i}]));
    end
end

