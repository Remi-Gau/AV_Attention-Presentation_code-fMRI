clear
clc
close all


%%
SubInd = 1;
RunsToCreate = [1 2 5 6 9 10];
FirstConditionAllocation = [1 2 2 1  2 1 1 2  1 2 2 1];
NbStimPerBlock= 13;


% 1 --> AudioOnly block ; 2 --> VisualOnly block ; 3 --> AudioVisual block
BlockOrders = [ 1 2 3 1 2 3 1 2 3];

Trials = [  100; ... % Auditory Only
            200; ... % Visual Only
            300]; ... % AV

Targets = [ 10; ... % Auditory Target
            11];    % Visual Target

Attend2Audio_Fixation = 1; %#ok<NASGU>
Attend2Visual_Fixation = 2; %#ok<NASGU>
Long_Fixation = 0;

Run2Remove = repmat(1:3,1,4);



%%
RunNb = 1;

while RunNb <= length(RunsToCreate)
    %%
    if mod(RunNb,2)~=0
        % Stores lists of blockorders
        SequenceList = cell(3,3,2);

        for j=1:2
            % Counts which type of transition is missing for each block order
            FullHouse = zeros(3,3);

            %             % A V AV
            % Transition = [...
            %               1 1 1; ...  % A
            %               1 1 1; ...  % V
            %               1 1 1]; ... % AV

            while sum(FullHouse(:))<9

                % Counts the number of each type of transition of each type
                TransitionTest = 2*ones(3,3);

                % Each type of transition must be present only once at the most
                while any(TransitionTest(:)>1)

                    % Creates a new block order
                    BlockOrders = BlockOrders(randperm((size(BlockOrders,2))));

                    % Count each type of transition
                    TransitionTest = zeros(3,3);
                    for i=2:9
                        TransitionTest(BlockOrders(i-1),BlockOrders(i)) = TransitionTest(BlockOrders(i-1),BlockOrders(i)) + 1;
                    end

                end

                % Find which type of transition is missing and store the current block order
                [I,J] = find(TransitionTest==0);
                SequenceList{I,J,j} = BlockOrders;
                FullHouse(I,J) = 1;

            end

        end

        clear temp FullHouse I J i j TransitionTest
    end


    %%
    for h=1:2
        %%
        RunInd = RunsToCreate(RunNb)

        AttentionCondition = FirstConditionAllocation(RunInd);
        if AttentionCondition == 1
            NeglectCondition = 2;
        else
            NeglectCondition = 1;
        end

        AttentionCondition;

        TrialsFinal = AttentionCondition;


        %% Creates series of trials for each block
        B=[];
        TempTrials=cell(3,3);

        % Creates templates of blocks with template
        for i=1:3
            % Blocks with no target
            for j=1:3
                TempTrials{i,j} = repmat(Trials(i,:), NbStimPerBlock, 1);
            end

            % Blocks with one target at the end of the block
            TempTrials{i,2} = [TempTrials{i,2} ; Targets(AttentionCondition)];
            TempTrials{i,3} = [TempTrials{i,3} ; Targets(NeglectCondition)];

            % Blocks with two target at the end of the block
            while 1
                temp = [ceil(rand*2)+1 ; ceil(rand*8)+2 ; ceil(rand(2,1)*NbStimPerBlock-1+4)];
                if min(abs(diff(sort(temp))))>2
                    temp = sort(temp);
                    break
                end
            end

            A = NaN(NbStimPerBlock+4,1);
            A(temp) = [Targets(AttentionCondition) Targets(NeglectCondition) Targets(AttentionCondition) Targets(NeglectCondition)];
            A(isnan(A(:,1)),:) = repmat(Trials(i,:),NbStimPerBlock, 1);

            TempTrials{i,4} = A;
            clear A
        end

        clear i j temp



        %% Combines those templates
        % Take a blockorder from our list
        BlockOrders = cell2mat(SequenceList(Run2Remove(RunInd), Run2Remove(RunInd), AttentionCondition));

        while 1

            Check = [[NaN ; BlockOrders(1:end-1)'] BlockOrders'  zeros(9,1)];

            % The number in these matrix refers to :
            % 1 --> Block with no target,
            % 2 --> Block with one auditory target,
            % 3 --> Block with one visual target,
            % 4 --> Block with one target of each type,
            TargetCounter = {[1 2 3 4] ; ... % For Audio only
                [1 2 3 4] ; ... % For Visual only
                [1 2 3 4]};     % For Audiovisual

            for j=1:9
                TrialType = BlockOrders(j);
                IndexChosenBlock = ceil(rand*length(TargetCounter{TrialType,1}));
                ChosenBlock = TargetCounter{TrialType,1}(IndexChosenBlock);

                Check(j,3) = ChosenBlock;

                TargetCounter{TrialType,1}(IndexChosenBlock)=[];
            end

            % Make sure that this series of blocks has:
            % - a block of each type with no target
            % - 2 with two targets
            % - one with only one target of each type
            if sum(Check(:,3)==1)==3 && sum(Check(:,3)==4)==3 && sum(Check(:,3)==AttentionCondition+1)==2 && sum(Check(:,3)==NeglectCondition+1)==1
                Check; %#ok<VUNUS>
                break;
            end

        end

        AllCheck{RunInd,h} = Check(:,2:end);
        
        Check(:,2:3)

        for i=1:9
            ChosenBlock = Check(i,3);
            TrialType = BlockOrders(i);
            A = TempTrials(TrialType, ChosenBlock);
            A = [A ; Long_Fixation];
            B = [B ; A];
        end

        B=cell2mat(B);

        TrialsFinal = [TrialsFinal ; B]; %#ok<*AGROW>

        TrialsFinal(end) = [];

        mkdir(strcat('Subject_', num2str(SubInd)));
        cd(strcat('Subject_', num2str(SubInd)));
        TrialListFile = strcat('Trial_List_Subject_', num2str(SubInd), '_Run_', num2str(RunInd), '.txt');
        fid = fopen (TrialListFile, 'w');
        for TrialInd = 1:length(TrialsFinal)
            fprintf (fid, '%i\n', TrialsFinal(TrialInd) );
        end
        fclose (fid);
        cd ..


        RunNb = RunNb + 1;

    end

end


RunNb = 1;
RunsToReuse = [3 4 7 8 11 12];
%% Creates the even numbered runs
while RunNb <= length(RunsToReuse)

    for h=1:2

        RunInd = RunsToReuse(RunNb)
        
        AttentionCondition = FirstConditionAllocation(RunInd)
        if AttentionCondition == 1
            NeglectCondition = 2;
        else
            NeglectCondition = 1;
        end

        TrialsFinal = AttentionCondition;


        %% Creates series of trials for each block
        B=[];
        TempTrials=cell(3,3);

        % Creates templates of blocks with template
        for i=1:3
            % Blocks with no target
            for j=1:3
                TempTrials{i,j} = repmat(Trials(i,:), NbStimPerBlock, 1);
            end

            % Blocks with one target at the end of the block
            TempTrials{i,2} = [TempTrials{i,2} ; Targets(AttentionCondition)];
            TempTrials{i,3} = [TempTrials{i,3} ; Targets(NeglectCondition)];

            % Blocks with two target at the end of the block
            while 1
                temp = [ceil(rand*2)+1 ; ceil(rand*8)+2 ; ceil(rand(2,1)*NbStimPerBlock-1+4)];
                if min(abs(diff(sort(temp))))>2
                    temp = sort(temp);
                    break
                end
            end

            A = NaN(NbStimPerBlock+4,1);
            A(temp) = [Targets(AttentionCondition) Targets(NeglectCondition) Targets(AttentionCondition) Targets(NeglectCondition)];
            A(isnan(A(:,1)),:) = repmat(Trials(i,:),NbStimPerBlock, 1);

            TempTrials{i,4} = A;
            clear A
        end

        clear i j temp

        %%
        if h==1
            Check = AllCheck{RunInd-1,2};
        elseif h==2
            Check = AllCheck{RunInd-3,1};
        end;

        Check = flipud(Check)

        for i=1:9
            ChosenBlock = Check(i,2);
            TrialType = BlockOrders(i);
            A = TempTrials(TrialType, ChosenBlock);
            A = [A ; Long_Fixation];
            B = [B ; A];
        end

        B=cell2mat(B);

        TrialsFinal = [TrialsFinal ; B]; %#ok<*AGROW>

        TrialsFinal(end) = [];

        mkdir(strcat('Subject_', num2str(SubInd)));
        cd(strcat('Subject_', num2str(SubInd)));
        TrialListFile = strcat('Trial_List_Subject_', num2str(SubInd), '_Run_', num2str(RunInd), '.txt');
        fid = fopen (TrialListFile, 'w');
        for TrialInd = 1:length(TrialsFinal)
            fprintf (fid, '%i\n', TrialsFinal(TrialInd) );
        end
        fclose (fid);
        cd ..


        RunNb = RunNb + 1;

    end
end


%% Creates sequences for other subjects

NbSubject = 12;

StartDirectory = pwd;

cd(strcat('Subject_1'));

FilesList =  dir(strcat('Trial_List_Subject_*_Run_?.txt'));
Temp = dir(strcat('Trial_List_Subject_*_Run_??.txt'));

FilesList = {FilesList.name}'

for i=1:length(Temp)
    FilesList{length(FilesList)+1} = Temp(i).name
end

ReverseOrder = size(FilesList,1):-1:1;

FilesListPsychCurve = dir(strcat('Trial_List_Subject_*_Run_???.txt'));

cd ..

for SubjInd = 2:NbSubject
    
    mkdir(strcat('Subject_', num2str(SubjInd)));
    cd(strcat('Subject_', num2str(SubjInd)));

    for FileInd=1:size(FilesList,1)
        if mod(SubjInd,2)~=0
            copyfile(fullfile(StartDirectory, 'Subject_1', FilesList{FileInd}), ...
                fullfile(pwd, strcat('Trial_List_Subject_', num2str(SubjInd), '_Run_', num2str(FileInd),'.txt') ),'f')
        else
            copyfile(fullfile(StartDirectory, 'Subject_1', FilesList{FileInd}), ...
                fullfile(pwd, strcat('Trial_List_Subject_', num2str(SubjInd), '_Run_', num2str(ReverseOrder(FileInd)),'.txt') ),'f')           
        end
    end
    
    for FileInd=1:size(FilesListPsychCurve,1)
           copyfile(fullfile(StartDirectory, 'Subject_1', FilesListPsychCurve(FileInd).name), ...
            fullfile(pwd, strcat('Trial_List_Subject_', num2str(SubjInd), FilesListPsychCurve(FileInd).name(end-11:end),'.txt') ),'f')
    end
    
    cd ..
    
end;