function [Kappa, confusionMatrix] = calculateKappa(Y, res)
% calculateKappa computes the Cohen's Kappa coefficient and confusion matrix.
% Input:
%   Y: Ground truth labels
%   res: Predicted labels
% Output:
%   Kappa: Cohen's Kappa coefficient
%   confusionMatrix: The confusion matrix

% Compute confusion matrix
confusionMatrix = confusionmat(Y, res);

% Total number of samples
total = sum(confusionMatrix(:));

% Observed agreement
diagSum = sum(diag(confusionMatrix)); % Sum of diagonal elements
p0 = diagSum / total; % Observed agreement

% Expected agreement
rowSums = sum(confusionMatrix, 2); % Sum of each row
colSums = sum(confusionMatrix, 1); % Sum of each column
pe = sum(rowSums .* colSums) / (total^2); % Expected agreement

% Cohen's Kappa
Kappa = (p0 - pe) / (1 - pe);

end
