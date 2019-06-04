clear all;

addpath('C:\Users\test\Desktop\PattRecClasses');
addpath('C:\Users\test\Desktop\PattRecClasses\GetSpeechFeatures');

directories = {'Computer','Fridge' ,'TurnOn','TurnOff', 'Washer','Heater'};
states = [6 5 6 4 4 5];
num_words = length(directories);
words = {};

recordingDir = 'C:\Users\test\Desktop\PattRecClasses\Recordings2\';
testSamples = 12;


window = 0.030;
bands = 13;

features = {};


for word_i = 1:num_words
    
    word_features = [];
    sample_lengths = zeros(num_words, 1);
    
    for sample_i = 1:testSamples
        %read the audio
        [sample,fs] = audioread(strcat(recordingDir, directories{word_i}, '\', int2str(sample_i), '.wav'));
        %words{word_i, sample_i} = sample;
        mfccs = GetSpeechFeatures(sample, fs, window, bands);
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

        word_features = [word_features features];
        sample_lengths(sample_i) = size(features, 2);

    end
    
    hmms(word_i) = MakeLeftRightHMM(states(word_i), GaussMixD(3), word_features, sample_lengths');
end

save('vari_states_15trained', 'hmms');


%read in each audio sample

%get the features and normalise

%put them in long vectors but remember how long each sample is