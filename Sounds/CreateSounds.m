clear all
clc

SamplingRate = 44100 ;
StimDuration = 0.5;

AttenuationRange = linspace(0.05, 0.4, 10);

SoundCell = {};


%%
TargetFreq = 440;
TargetDuration = 0.1;
TargetSound = sin(2*pi*TargetFreq*(0:TargetDuration*SamplingRate)/SamplingRate);
TukeyWin = tukeywin(length(TargetSound),0.35)';
TargetSound = TargetSound .* TukeyWin;
%plot(TargetSound)
%sound(TargetSound,SamplingRate)
TargetSound = [TargetSound' TargetSound'];
wavwrite(TargetSound,SamplingRate,strcat('TargetSound_',num2str(TargetFreq), '_Hz.wav'));


%% Creates looming sounds
% Original sound
Sound = randn(1, StimDuration*SamplingRate)';

% Looming parameters
x = 1:length(Sound);
y = x'/length(Sound); % linear looming
z = exp(x'/length(Sound))-1; % exponential looming

% Tukey window
TukeyWin = tukeywin(length(Sound),0.05)';


% White Noise
Whitenoise = Sound;
SoundCell{1,1} = 'Whitenoise';
SoundCell{1,2} = Whitenoise;

% Pink Noise
a=zeros(1, length(Sound));
a(1)=1;
for i=2:length(Sound)
    a(i) = (i-2.5) * a(i-1) / (i-1);
end
PinkNoise = filter(1, a, Sound);
SoundCell{2,1} = 'PinkNoise';
SoundCell{2,2} = PinkNoise;

% Brown Noise
a=zeros(1, length(Sound));
a(1)=1;
for i=2:length(Sound)
    a(i) = (i-2.5) * a(i-1) / (i-1)^2;
end
BrownNoise = filter(1, a, Sound);
SoundCell{3,1} = 'BrownNoise';
SoundCell{3,2} = BrownNoise;



%% Save sounds
for SoundInd=1:size(SoundCell,1)
    
    TEMP = SoundCell{SoundInd,2};
    TEMP = TEMP/max(abs(TEMP));
    TEMP2 = [TEMP  TEMP];
    wavwrite(TEMP2,SamplingRate,strcat(SoundCell{SoundInd,1}, '.wav'));
    TEMP = TEMP .* TukeyWin';
    TEMP2 = [TEMP  TEMP];
    wavwrite(TEMP2,SamplingRate,strcat(SoundCell{SoundInd,1}, '_Tukey.wav'));
   
    
    TEMPLinear =  TEMP .* y;
    TEMPLinear = TEMPLinear/max(abs(TEMPLinear));
    TEMP2 = [TEMPLinear  TEMPLinear];
    wavwrite(TEMP2,SamplingRate,strcat(SoundCell{SoundInd,1},'_Linear.wav'));
    TEMPLinear = TEMPLinear .* TukeyWin';
    TEMP2 = [TEMPLinear  TEMPLinear];
    wavwrite(TEMP2,SamplingRate,strcat(SoundCell{SoundInd,1}, '_Linear_Tukey.wav'));
    
    TEMPExp =  TEMP .* z;
    TEMPExp = TEMPExp/max(abs(TEMPExp));
    TEMP2 = [TEMPExp  TEMPExp];
    wavwrite(TEMP2,SamplingRate,strcat(SoundCell{SoundInd,1},'_Exp.wav'));
    TEMPExp = TEMPExp .* TukeyWin';
    TEMP2 = [TEMPExp  TEMPExp];
    wavwrite(TEMP2,SamplingRate,strcat(SoundCell{SoundInd,1}, '_Exp_Tukey.wav'));

end


%%
for i=1:5
    Looming_Sound_And_Target = wavread('Whitenoise_Exp_Tukey.wav');
    Target_alone = zeros(size(Looming_Sound_And_Target));
    A = 1+(i-1)*length(TargetSound);
    B = (i)*length(TargetSound);
    if B > length(Looming_Sound_And_Target)
        B = length(Looming_Sound_And_Target);
    end
    
    for AttenuationIndex = 1:length(AttenuationRange)
        Looming_Sound_And_Target(A:B-1,:) = Looming_Sound_And_Target(A:B-1,:) + TargetSound(1:B-A,:) * AttenuationRange(AttenuationIndex);
        Target_alone = zeros(size(Looming_Sound_And_Target));
        Target_alone(A:B-1,:) = Target_alone(A:B-1,:) + TargetSound(1:B-A,:) * AttenuationRange(AttenuationIndex);
        Target_alone = Target_alone / max(max(Target_alone));
        
        % sound(Looming_Sound_And_Target,SamplingRate)
        % sound(Target_alone,SamplingRate)

        wavwrite(Looming_Sound_And_Target,SamplingRate,strcat('Looming_Noise_And_Target_', num2str(i), '_Attenuation_' , num2str(AttenuationIndex),'.wav'));
        wavwrite(Target_alone,SamplingRate,strcat('Target_alone_', num2str(i), '_Attenuation_' , num2str(AttenuationIndex),'.wav'));
    end;

end





%% frequency modulated (FM) sound
clc

SamplingRate = 44100;
StimDuration = 0.5;

% BaseFreq = [220 330 440 660 880 990 1110 880*2];
% FreqRange = 1;
% FreqRange = (FreqRange * BaseFreq)'
% mrate = 1;    % modulation rate
% mindex = 110;	% modulation index (for fm = max_freq_change/modulation rate)
% 
% for FreqInd = 1 :length(FreqRange)
%     fc = FreqRange(FreqInd);
%     mindex = FreqRange(FreqInd)/2.5;
%     f_fm(FreqInd,1:length(t))  = sin((2 * pi * fc * t) + (-mindex * sin(2 * mrate * pi * t))) ;
% end

BaseFreq = [55 110 150 220 330 380 440 660 880 990 1110 1500 2500 3000];
% FreqRange = [0.25 0.5 linspace(1,6,4)];
FreqRange = 1;
FreqRange = (FreqRange * BaseFreq)'

mrate = 1;    % modulation rate
mindex = 440;	% modulation index (for fm = max_freq_change/modulation rate)

t = 0 : 1/SamplingRate : StimDuration;

y = t'/length(t); % linear looming
z = exp(15000*t'/length(t))-1; % exponential looming
TukeyWin = tukeywin(length(t), 0.05)'; % Tukey window

for FreqInd = 1 :length(FreqRange)
    fc = FreqRange(FreqInd);
    mindex = FreqRange(FreqInd)/1.5;
    f_fm(FreqInd,1:length(t))  = sin((2 * pi * fc * t) + (-mindex * sin(2 * mrate * pi * t))) ;
end

Final = sum(f_fm,1)';
Final  =  Final .* z;
Final = Final .* TukeyWin';
Final = Final/max(abs(Final));

% subplot(211)
plot(Final)

% Spectrum = abs( fft(Final) );
% Spectrum = Spectrum / sum(Spectrum);
% 
% subplot(212)
% semilogx(Spectrum(1:fix(length(Spectrum)/2)))
% axis([20 20000 0 max(Spectrum)])

%sound(Final,SamplingRate)

%Looming_Sound = [Final'; Final'];
%wavwrite(Final,SamplingRate,strcat('Looming_Sound.wav'));




%%
for i=1:5
    Looming_Sound_And_Target = Looming_Sound';
    Target_alone = zeros(size(Looming_Sound_And_Target));
    A = 1+(i-1)*length(TargetSound);
    B = (i)*length(TargetSound);
    if B > length(Looming_Sound_And_Target)
        B = length(Looming_Sound_And_Target);
    end

    
    for AttenuationIndex = 1:length(AttenuationRange)
        Looming_Sound_And_Target(A:B-1,:) = Looming_Sound_And_Target(A:B-1,:) + TargetSound(1:B-A,:) * AttenuationRange(AttenuationIndex);
        
        %sound(Looming_Sound_And_Target,SamplingRate)

        wavwrite(Looming_Sound_And_Target,SamplingRate,strcat('Looming_Sound_And_Target_', num2str(i), '_Attenuation_' , num2str(AttenuationIndex),'.wav'));
    end;
    

end






%%
SoundList = dir('*.wav');

% Reads the sounds
% for SoundInd=1:size(SoundList,1)
%     [Y,FS,NBITS]=wavread(SoundList(SoundInd).name);
%     sound(Y,FS);
% end

%% creates names list
B=[]
A = char({SoundList(:).name});
for i=1:size(A,1)
 B(i,:) = strrep(A(i,:), '.wav', ' ');
end
[repmat(['sound {wavefile { filename = "'], size(SoundList,1),1) A repmat(['"; } ; } '], size(SoundList,1),1) B repmat(';', size(SoundList,1),1)]
fprintf('\n')

% for SoundInd=1:size(SoundList,1)
%     fprintf(['sound {wavefile { filename = "' char({SoundList(SoundInd).name}) '"; } ; } '  SoundList(SoundInd).name(1:end-4) ';']);
%     fprintf('\n')
% end
