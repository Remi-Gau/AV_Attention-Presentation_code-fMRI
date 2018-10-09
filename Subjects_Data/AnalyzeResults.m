clc
clear all
close all

NbSubject = 3;

StartDirectory = pwd;

for SubjInd = 1 : NbSubject

    cd(strcat('Subject_', num2str(SubjInd)))
    
    cd('Runs')

    %%
    LogFileList = dir('Logfile*.txt');
    
    HIT_TOTAL = zeros(4,3,size(LogFileList,1));
    MISS_TOTAL = zeros(4,3,size(LogFileList,1));
    FALSE_ALARM_TOTAL = zeros(4,3,size(LogFileList,1));
    CORRECT_REJECTION_TOTAL = zeros(4,3,size(LogFileList,1));

    IndStart = 5;% first row of data points in txt file

    TargetTimeOut = 2000; % ms
    TargetTimeOut = TargetTimeOut * 10000;

    %%
    for FileInd = 1:size(LogFileList,1)

        %%
        disp(LogFileList(FileInd).name)

        fid = fopen(fullfile (pwd, LogFileList(FileInd).name));
        FileContent = textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s', 'headerlines', IndStart, 'returnOnError',0);
        fclose(fid);

        EOF = find(strcmp('Final_Fixation', FileContent{1,3}));
        if isempty(EOF)
            EOF = find(strcmp('Quit', FileContent{1,2})) - 1;
        end

        Stim_Time = {FileContent{1,3}(1:EOF)  FileContent{1,4}(1:EOF)};

        %%
        % Identify the two attenttional component of the run
        IndexStartAudioAttention = find(strcmp('Attend2Audio_Fixation', Stim_Time{1,1}));
        if isempty(IndexStartAudioAttention)
            IndexStartAudioAttention = inf;
        end

        IndexStartVisualAttention = find(strcmp('Attend2Visual_Fixation', Stim_Time{1,1}));
        if isempty(IndexStartVisualAttention)
            IndexStartVisualAttention = inf;
        end

        % Identify the first condition of the run
        if IndexStartAudioAttention < IndexStartVisualAttention
            FirstCondition = 1;
            SecondCondition = 2;
            IndexSecondCondition = IndexStartVisualAttention;
        else
            FirstCondition = 2;
            SecondCondition = 1;
            IndexSecondCondition = IndexStartAudioAttention;
        end

        % Identify targets and responses
        IndexAudiotarget = find(strcmp('Auditory_Target', Stim_Time{1,1}));
        IndexVisualTarget = find(strcmp('Visual_Target', Stim_Time{1,1}));
        IndexTargets = sort([IndexAudiotarget ; IndexVisualTarget]);
        IndexResponses = sort(find(strcmp('1', Stim_Time{1,1})));

        %%
        HIT = zeros(4,3);
        MISS = zeros(4,3);
        FALSE_ALARM = zeros(4,3);
        CORRECT_REJECTION = zeros(4,3);
        EXTRA_ANSWERS = 0;

        StimPresented = 0;
        TargetORDistractor = 0;
        TargetPresentationTime = 0;

        % Loop to analyze the whole run;
        CurrentCondition = FirstCondition;
        for Ind = 1 : length(Stim_Time{1,1})

            if Ind==IndexSecondCondition
                CurrentCondition = SecondCondition;
            end

            if strcmp('AudioOnly_Trial', Stim_Time{1,1}(Ind))
                CurrentTrialType = 1;
            elseif strcmp('VisualOnly_Trial', Stim_Time{1,1}(Ind))
                CurrentTrialType = 2;
            elseif strcmp('AudioVisual_Trial', Stim_Time{1,1}(Ind))
                CurrentTrialType = 3;
            end

            if StimPresented == 1 && str2double(char(Stim_Time{1,2}(Ind))) > TargetPresentationTime + TargetTimeOut
                StimPresented = 0;
                if TargetORDistractor == 1
                    MISS(TrialTypeOfInterest, CurrentCondition) = MISS(TrialTypeOfInterest, CurrentCondition) + 1;
                else
                    CORRECT_REJECTION(TrialTypeOfInterest, CurrentCondition) = CORRECT_REJECTION(TrialTypeOfInterest, CurrentCondition) + 1;
                end
            end

            if strcmp('Auditory_Target', Stim_Time{1,1}(Ind))
                if StimPresented == 1;
                    if TargetORDistractor == 1
                        MISS(TrialTypeOfInterest, CurrentCondition) = MISS(TrialTypeOfInterest, CurrentCondition) + 1;
                    else
                        CORRECT_REJECTION(TrialTypeOfInterest, CurrentCondition) = CORRECT_REJECTION(TrialTypeOfInterest, CurrentCondition) + 1;
                    end
                end
                StimPresented = 1; TrialTypeOfInterest = CurrentTrialType;
                TargetPresentationTime = str2double(char(Stim_Time{1,2}(Ind)));

                if FirstCondition==1 && Ind<IndexStartVisualAttention
                    TargetORDistractor = 1;
                else
                    TargetORDistractor = 0;
                end

            elseif strcmp('Visual_Target', Stim_Time{1,1}(Ind))
                if StimPresented == 1;
                    if TargetORDistractor == 1
                        MISS(TrialTypeOfInterest, CurrentCondition) = MISS(TrialTypeOfInterest, CurrentCondition) + 1;
                    else
                        CORRECT_REJECTION(TrialTypeOfInterest, CurrentCondition) = CORRECT_REJECTION(TrialTypeOfInterest, CurrentCondition) + 1;
                    end
                end
                StimPresented = 1; TrialTypeOfInterest = CurrentTrialType;
                TargetPresentationTime = str2double(char(Stim_Time{1,2}(Ind)));

                if FirstCondition==2 && Ind<IndexStartAudioAttention
                    TargetORDistractor = 1;
                else
                    TargetORDistractor = 0;
                end

            elseif strcmp('1', Stim_Time{1,1}(Ind))
                if StimPresented == 1
                    if TargetORDistractor == 1
                        HIT(TrialTypeOfInterest, CurrentCondition) = HIT(TrialTypeOfInterest, CurrentCondition) + 1;
                    else
                        FALSE_ALARM(TrialTypeOfInterest, CurrentCondition) = FALSE_ALARM(TrialTypeOfInterest, CurrentCondition) + 1;
                    end   
                else
                    EXTRA_ANSWERS = EXTRA_ANSWERS + 1;
                end
                StimPresented = 0;
            else
            end

        end 

        if StimPresented == 1
            MISS(TrialTypeOfInterest, CurrentCondition) = MISS(TrialTypeOfInterest, CurrentCondition) + 1;
        end;

        if length(IndexTargets)~=sum(sum(HIT+MISS+FALSE_ALARM+CORRECT_REJECTION))
            warning('Houston ! We are missing some targets !'); %#ok<WNTAG>
        end

        %%
        for i=1:size(HIT,1)
            HIT(i,end) = sum(HIT(i,1:end-1));
            MISS(i,end) = sum(MISS(i,1:end-1));
            FALSE_ALARM(i,end) = sum(FALSE_ALARM(i,1:end-1));
            CORRECT_REJECTION(i,end) = sum(CORRECT_REJECTION(i,1:end-1));
        end

        for j=1:size(HIT,2)
            HIT(end,j) = sum(HIT(1:end-1,j));
            MISS(end,j) = sum(MISS(1:end-1,j));
            FALSE_ALARM(end,j) = sum(FALSE_ALARM(1:end-1,j));
            CORRECT_REJECTION(end,j) = sum(CORRECT_REJECTION(1:end-1,j));
        end

        HIT_TOTAL(:,:,FileInd) = HIT;
        MISS_TOTAL(:,:,FileInd) = MISS;
        FALSE_ALARM_TOTAL(:,:,FileInd) = FALSE_ALARM;
        CORRECT_REJECTION_TOTAL(:,:,FileInd) = CORRECT_REJECTION;

        for i=1:size(HIT,1)
            for j=1:size(HIT,2)

            FalseAlarmRate = FALSE_ALARM(i,j)/(FALSE_ALARM(i,j)+CORRECT_REJECTION(i,j));
            if FalseAlarmRate==1
                FalseAlarmRate = 1 - 1/(2*(CORRECT_REJECTION(i,j)+FALSE_ALARM(i,j)));
            end
            if FalseAlarmRate==0
                FalseAlarmRate = 1/(2*(CORRECT_REJECTION(i,j)+FALSE_ALARM(i,j)));
            end

            HitRate = HIT(i,j)/(HIT(i,j)+MISS(i,j));
            if HitRate==1
                HitRate = 1 - 1/(2*((HIT(i,j)+MISS(i,j))));
            end
            if HitRate==0
                HitRate = 1/(2*((HIT(i,j)+MISS(i,j))));
            end


            D_prime(i,j) = norminv(HitRate)-norminv(FalseAlarmRate);
            Accuracy(i,j) = (HIT(i,j) + CORRECT_REJECTION(i,j)) / (HIT(i,j)+MISS(i,j)+FALSE_ALARM(i,j)+CORRECT_REJECTION(i,j));

            end
        end

        %D_prime
        %Accuracy
        
    end
    
    fprintf('Subject %i average', SubjInd)
    
    HIT_TOTAL = sum(HIT_TOTAL,3);
    MISS_TOTAL = sum(MISS_TOTAL,3);
    FALSE_ALARM_TOTAL = sum(FALSE_ALARM_TOTAL,3);
    CORRECT_REJECTION_TOTAL = sum(CORRECT_REJECTION_TOTAL,3);

    for i=1:size(HIT_TOTAL,1)
        for j=1:size(HIT_TOTAL,2)
            
            FalseAlarmRate = FALSE_ALARM_TOTAL(i,j)/(FALSE_ALARM_TOTAL(i,j)+CORRECT_REJECTION_TOTAL(i,j));
            if FalseAlarmRate==1
                FalseAlarmRate = 1 - 1/(2*(CORRECT_REJECTION_TOTAL(i,j)+FALSE_ALARM_TOTAL(i,j)));
            end
            if FalseAlarmRate==0
                FalseAlarmRate = 1/(2*(CORRECT_REJECTION_TOTAL(i,j)+FALSE_ALARM_TOTAL(i,j)));
            end

            HitRate = HIT_TOTAL(i,j)/(HIT_TOTAL(i,j)+MISS_TOTAL(i,j));
            if HitRate==1
                HitRate = 1 - 1/(2*((HIT_TOTAL(i,j)+MISS_TOTAL(i,j))));
            end
            if HitRate==0
                HitRate = 1/(2*((HIT_TOTAL(i,j)+MISS_TOTAL(i,j))));
            end


            D_prime_TOTAL(i,j) = norminv(HitRate)-norminv(FalseAlarmRate);
            Accuracy_TOTAL(i,j) = (HIT_TOTAL(i,j) + CORRECT_REJECTION_TOTAL(i,j)) / (HIT_TOTAL(i,j)+MISS_TOTAL(i,j)+FALSE_ALARM_TOTAL(i,j)+CORRECT_REJECTION_TOTAL(i,j));

        end
    end
    
    D_prime_TOTAL
    Accuracy_TOTAL
    
    cd(StartDirectory)

end