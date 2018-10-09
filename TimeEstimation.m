%% Time estimation for psychometric function

% Assuming 80% signal / 20% noise

TR = 3;

AverageTrialDuration = 0.5 + 2.2;

NumberOfLevels = 10;

NumberOfTrialsPerLevel = 4;

NumberOfContext = 3;

TimeDurationSecs = NumberOfContext * NumberOfTrialsPerLevel * NumberOfLevels * AverageTrialDuration;

TimeDurationSecs = TimeDurationSecs + TimeDurationSecs/4;

TimeDurationMin = TimeDurationSecs/60

TimeDurationTR = TimeDurationSecs/TR


