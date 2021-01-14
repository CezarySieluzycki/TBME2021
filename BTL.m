% Authors: Artur Matysiak & Cezary Sieluzycki
%
% If you decide to use this code please cite the IEEE TBME 2021 paper
% "Reducing the Number of MEG/EEG Trials Needed for the Estimation of 
% Brain Evoked Responses: A Bootstrap Approach".

% For preprocessed singleTrialData organized as a 
% 3D matrix (noTrials, noSamples, noChannnels)

noAttempts = 1e3; % The number of bootstrap realizations.
trialSets  = 10 : 10 : noTrials;

for trSet = 1 : length(trialSets)
    noTrials = trialSets(trSet);
    for ii = 1 : noAttempts
        labelsOfSelectedTrials = randsample(noTrials, noTrials, 'true');
        newSingleTrials = singleTrialData(labelsOfSelectedTrials, :, :);
        newMeanData = squeeze(mean(newSingleTrials));
        
        % Here, use the inverse-solution strategy of your choice
        % and save the result for each combination of trSet and ii.
    end
end