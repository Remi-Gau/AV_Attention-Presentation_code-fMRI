TrialsFinal = [2 0];

TrialTypes = [100  11; ...
              200  11; ...
              300  11];

TrialsPerLevel = 4;          
          
% a typical block has 12 trials of a given type (A, V, AV) including 9
% with a target
OneBlock = [ones(1,TrialsPerLevel) zeros(1,TrialsPerLevel/4)];

BlockTypes = 1:3;
LevelsForVisual = [.025, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7];

% Cartesian product... Solution found online. Seems also possible to use the ALLCOMB function if it has been downloaded from mathworks exchange.
sets = {BlockTypes, LevelsForVisual};
[x y] = ndgrid(sets{:});
% List of all possible combinations and repeats the matrix by the amount of times per condition.
Conditions = [x(:) y(:)];
Conditions = Conditions(randperm(length(Conditions)),:)

for BlockIndex = 1:length(Conditions);
    
    CurrentBlockType = Conditions(BlockIndex,1);
        
    OneBlock = OneBlock(randperm(length(OneBlock)));
    
    CurentBlockContent = [OneBlock ; zeros(1, length(OneBlock))];
    
    CurentBlockContent(:,OneBlock(1,:)==1) = ...
        repmat(TrialTypes(CurrentBlockType,:)',1,(size(CurentBlockContent(:,OneBlock(1,:)==1),2) ));
    
    CurentBlockContent(1,OneBlock(1,:)==0) = TrialTypes(CurrentBlockType,1);
    
    CurentBlockContent = CurentBlockContent(:);
    
    CurentBlockContent(CurentBlockContent==0) = [];
    
    CurentBlockContent(CurentBlockContent==11,2) = Conditions(BlockIndex,2);
    
    TrialsFinal = [TrialsFinal ; CurentBlockContent ; 0 0]; %#ok<AGROW>
    
end

TrialsFinal

for i = 3:12
    cd(strcat('Subject_', num2str(i)));
    
    TrialListFile = strcat('Trial_List_Subject_', num2str(i), '_Run_222.txt');
    fid = fopen (TrialListFile, 'w');
    for TrialInd = 1:length(TrialsFinal)
        fprintf (fid, '%3.2f %3.2f\n', TrialsFinal(TrialInd,1), TrialsFinal(TrialInd,2) );
    end
    fclose (fid);
    
    cd ..
end


%%
TrialsFinal = [1 0];

TrialTypes = [100  10; ...
              200  10; ...
              300  10];

TrialsPerLevel = 4;          
          
% a typical block has 12 trials of a given type (A, V, AV) including 9
% with a target
OneBlock = [ones(1,TrialsPerLevel) zeros(1,TrialsPerLevel/4)];

BlockTypes = 1:3;
LevelsForVisual = [3,4,5,6,7,7,8,9,10];

% Cartesian product... Also possible to use the ALLCOMB function from the mathworks exchange.
sets = {BlockTypes, LevelsForVisual};
[x y] = ndgrid(sets{:});
% List of all possible combinations and repeats the matrix by the amount of times per condition.
Conditions = [x(:) y(:)];
Conditions = Conditions(randperm(length(Conditions)),:)

for BlockIndex = 1:length(Conditions);
    
    CurrentBlockType = Conditions(BlockIndex,1);
        
    OneBlock = OneBlock(randperm(length(OneBlock)));
    
    CurentBlockContent = [OneBlock ; zeros(1, length(OneBlock))];
    
    CurentBlockContent(:,OneBlock(1,:)==1) = ...
        repmat(TrialTypes(CurrentBlockType,:)',1,(size(CurentBlockContent(:,OneBlock(1,:)==1),2) ));
    
    CurentBlockContent(1,OneBlock(1,:)==0) = TrialTypes(CurrentBlockType,1);
    
    CurentBlockContent = CurentBlockContent(:);
    
    CurentBlockContent(CurentBlockContent==0) = [];
    
    CurentBlockContent(CurentBlockContent==10,2) = Conditions(BlockIndex,2);
    
    TrialsFinal = [TrialsFinal ; CurentBlockContent ; 0 0]; %#ok<AGROW>
    
end

TrialsFinal

for i = 3:12
    cd(strcat('Subject_', num2str(i)));
    
    TrialListFile = strcat('Trial_List_Subject_', num2str(i), '_Run_111.txt');
    fid = fopen (TrialListFile, 'w');
    for TrialInd = 1:length(TrialsFinal)
        fprintf (fid, '%3.2f %3.2f\n', TrialsFinal(TrialInd,1), TrialsFinal(TrialInd,2) );
    end
    fclose (fid);
    
    cd ..
end