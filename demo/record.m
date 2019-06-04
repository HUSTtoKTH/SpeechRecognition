
    % 录音录3秒钟
    ar = audiorecorder(22050,16,1);
    disp('Start speaking.')
    recordblocking(ar, 3);
    disp('End of Recording.');
    % 回放录音数据
    play(ar);
    pause(3);
    % 获取录音数据
    myRecording = getaudiodata(ar);
    %存储语音信号
    filename = 'C:\Users\test\Desktop\PattRecClasses\Recordings2\Save\1.wav'; 
    audiowrite(filename,myRecording,22050);