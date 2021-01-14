% Authors: Artur Matysiak & Cezary Sieluzycki
%
% If you decide to use this code please cite the IEEE TBME 2021 paper
% "Reducing the Number of MEG/EEG Trials Needed for the Estimation of 
% Brain Evoked Responses: A Bootstrap Approach".

% For preprocessed singleTrialData organized as a 
% 3D matrix (noTrials, noSamples, noChannnels), where noSamples is even.

noAttempts = 1e3; % The number of bootstrap realizations.
trialSets  = 10 : 10 : noTrials;

fftSingleTrial = fft(singleTrialData(:, 1:noSamples, :), noSamples, 2);
for trSet = 1 : length(trialSets)
    noTrials = trialSets(trSet);
    for ii = 1 : noAttempts
        boots               = zeros(noTrials, noSamples);
        bootFftSingleTrial  = zeros(noTrials, noSamples, noOfChan);
        newSingleTrials     = zeros(noTrials, noSamples, noOfChan);
        for jj = 1 : noTrials
            boots(jj, 1:noSamples/2+1) = randsample(noTrials, noSamples/2+1, 'true');
            boots(jj, noSamples : -1 : noSamples/2+2) = boots(jj, 2:noSamples/2);
            for kk = 1 : noSamples % Across frequencies in fact, as we have as many fs as ts.
                bootFftSingleTrial(jj, kk, :) = fftSingleTrial(boots(jj,kk), kk, :);
            end
            newSingleTrials(jj, :, :) = ifft(bootFftSingleTrial(jj, :, :), noSamples, 2);
        end
        newMeanData = squeeze(mean(newSingleTrials));

        % Here, use the inverse-solution strategy of your choice
        % and save the result for each combination of trSet and ii.
    end
end