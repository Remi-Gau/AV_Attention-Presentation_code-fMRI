clear all; close all; clc;

%%
RunsToCreate = [1 3 5];

NbStimPerBlock= 50;

% BLOCKS
% 1 --> AudioOnly block ; 2 --> VisualOnly block ; 3 --> AudioVisual block
BlockOrderAll =      [1 2 3  1 2 3  1 2 3  1 2 3  1 2 3  1 2 3];
AttCondOrderAll = [1 1 1  1 1 1  1 1 1  2 2 2  2 2 2  2 2 2];

% TRIALS
Trials = [...
    100; ... % Auditory Only
    200; ... % Visual Only
    300]; ... % AV
    
% TARGETS
Targets = [...
    10;... % Auditory Target
    11];    % Visual Target

Attend2Audio_Fixation = 1;
Attend2Visual_Fixation = 2;
Long_Fixation = 0;


%% Run duration
SOA_Fix = .1; %1.55
StimDur = 0.63;

AvgBlockDur = round((SOA_Fix+StimDur)*NbStimPerBlock) %#ok<*NOPTS>

FinalFixationDur=40;
LongFixationDur=16; %Between blocks

RunDur = numel(BlockOrderAll)*(AvgBlockDur+LongFixationDur)+FinalFixationDur;
RunDurMin = RunDur/60


%%
for RunNb = 1:length(RunsToCreate)
    
    %%
    RunInd = RunsToCreate(RunNb)
    
    BlockOrder = BlockOrderAll;
    AttCondOrder = AttCondOrderAll;
    
    %% Creates a permutated block order
    
    % Makes sure that the transition from one condition to another are
    % balanced across runs.
    
    %             % A V AV
    % Transition = [...
    %               1 1 1; ...  % A
    %               1 1 1; ...  % V
    %               1 1 1]; ... % AV
    
    
    % Each type of transition must be present only once at the most
    % Attention condition not randomised
    %     while 1
    %
    %         % Creates a new block order
    %         TMP1 = [1 2 3];
    %         TMP2 = [];
    %         for i=1:numel(BlockOrder)/3
    %             TMP2 = [TMP2 TMP1(randperm(length(TMP1)))]; %#ok<AGROW>
    %         end
    %
    %
    %         % Count each type of transition
    %         TransitionTest = zeros(3,3);
    %         for i=2:numel(BlockOrder)
    %             TransitionTest(TMP2(i-1),TMP2(i)) = TransitionTest(TMP2(i-1), TMP2(i)) + 1;
    %         end
    %
    %         % Break if we have at least 1 transition but not more than 2
    %         % and if we do not have more than 3 blocks with the same attention
    %         if ~any(any([TransitionTest(:)<1 TransitionTest(:)>2],2))
    %             break
    %         end
    %
    %     end
    
    % Each type of transition must be present only once at the most
    % Attention condition randomised
    while 1
        
        % Creates a new block order
        TMP1 = randperm((size(BlockOrder,2)));
        TMP2 = BlockOrder(TMP1);
        TMP3 = AttCondOrder(TMP1);
        
        % Count each type of transition
        TransitionTest = zeros(3,3);
        for i=2:numel(BlockOrder)
            TransitionTest(TMP2(i-1),TMP2(i)) = TransitionTest(TMP2(i-1), TMP2(i)) + 1;
        end
        
        % Break if we have at least 1 transition but not more than 2
        % and if we do not have more than 3 blocks with the same attention
        % type in a row
        if ~any(any([TransitionTest(:)<1 TransitionTest(:)>2],2)) && ...
                isempty(strfind(num2str(diff(TMP3)==0),num2str([1 1 1 1])))
            break
        end
        
    end
    AttCondOrder = TMP3
    
    BlockOrder = TMP2
    TransitionTest
    
    clear TMP1 TMP2 TMP3 TransitionTest
    
    
    %% Creates series of trials for each block
    % Determine how much time before the end the high concentration of
    % targets starts
    TargetAfter = floor([32-6 32-8]/.65);
    
    for RunOddEven = 1:2
        
        fprintf('\nRun %i\n', RunInd+RunOddEven-1)
        
        TrialsFinal = [];
        
        TargetPerBlock = {...
            [1 1 2] [1 1 2] [1 1 2]; ...
            [1 1 2] [1 1 2] [1 1 2]};
        
        for iBlock=1:length(BlockOrder)
            
            AttCond = AttCondOrder(iBlock);
            if AttCond==2
                NeglCond = 1;
            else
                NeglCond = 2;
            end
            
            TrialType = BlockOrder(iBlock);
            
            tmp = ceil(rand*length(TargetPerBlock{AttCond,TrialType}));
            NbTargets = TargetPerBlock{AttCond,TrialType}(tmp);
            TargetPerBlock{AttCond,TrialType}(tmp)=[];
            clear tmp
            
            if NbTargets==1;
                TEMP1 = [...
                    repmat(Trials(TrialType,:), 1, TargetAfter(NbTargets));
                    zeros(1,TargetAfter(NbTargets))];
                TEMP2 = [...
                    repmat(Trials(TrialType,:), 1, NbStimPerBlock-TargetAfter(NbTargets));
                    Targets' zeros(1,NbStimPerBlock-TargetAfter(NbTargets)-2*NbTargets)];
                
            else
                TEMP1 = [...
                    repmat(Trials(TrialType,:), 1, TargetAfter(NbTargets));
                    Targets' zeros(1,TargetAfter(NbTargets)- NbTargets)];
                TEMP2 = [...
                    repmat(Trials(TrialType,:), 1, NbStimPerBlock-TargetAfter(NbTargets));
                    Targets' zeros(1,NbStimPerBlock-TargetAfter(NbTargets)- NbTargets)];
                
            end
            
            TEMP1 = TEMP1(:,randperm(length(TEMP1)));
            TEMP2 = TEMP2(:,randperm(length(TEMP2)));
            TempTrials = [TEMP1 TEMP2];
            TempTrials = TempTrials(:);
            TempTrials(TempTrials==0) = [];
            
            TrialsFinal = [TrialsFinal; AttCond; TempTrials]; %#ok<AGROW>
            
        end
        
        TargetPerBlock
%         TrialsFinal
        
        for iSubj = 2:6
            mkdir(strcat('Subject_', num2str(iSubj)));
            cd(strcat('Subject_', num2str(iSubj)));
            TrialListFile = strcat('Trial_List_Subject_', num2str(iSubj), '_Run_', num2str(RunInd+RunOddEven-1), '.txt');
            fid = fopen (TrialListFile, 'w');
            for TrialInd = 1:length(TrialsFinal)
                fprintf (fid, '%i\n', TrialsFinal(TrialInd) );
            end
            fclose (fid);
            cd ..
        end
        
        BlockOrder = fliplr(BlockOrder);
        AttCondOrder = fliplr(AttCondOrder);
    end
    
end

