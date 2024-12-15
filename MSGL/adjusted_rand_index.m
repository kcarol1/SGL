function ARI = adjusted_rand_index(labels_true, labels_pred)
    % adjusted_rand_index calculates the Adjusted Rand Index (ARI)
    % between two cluster label assignments.
    %
    % Parameters:
    % labels_true: Ground truth class labels (vector)
    % labels_pred: Predicted cluster labels (vector)
    %
    % Returns:
    % ARI: Adjusted Rand Index value (scalar)

    % Validate input lengths
    if length(labels_true) ~= length(labels_pred)
        error('labels_true and labels_pred must have the same length.');
    end

    % Compute the contingency table
    contingency = contingency_matrix(labels_true, labels_pred);

    % Compute sums of the contingency table
    sum_rows = sum(contingency, 2); % Sum over rows
    sum_cols = sum(contingency, 1); % Sum over columns
    total = sum(contingency(:));    % Total sum

    % Compute the pair counts
    sum_comb_c = sum(sum(comb2(contingency))); % Combination within contingency cells
    sum_comb_row = sum(comb2(sum_rows));       % Combination of row sums
    sum_comb_col = sum(comb2(sum_cols));      % Combination of column sums

    % Expected index and max index
    expected_index = (sum_comb_row * sum_comb_col) / comb2(total);
    max_index = (sum_comb_row + sum_comb_col) / 2;

    % Adjusted Rand Index calculation
    ARI = (sum_comb_c - expected_index) / (max_index - expected_index);
end

function C = contingency_matrix(labels_true, labels_pred)
    % Constructs a contingency matrix for two label vectors
    % labels_true and labels_pred should be vectors of the same length

    classes_true = unique(labels_true);
    classes_pred = unique(labels_pred);

    num_classes_true = length(classes_true);
    num_classes_pred = length(classes_pred);

    C = zeros(num_classes_true, num_classes_pred);

    for i = 1:num_classes_true
        for j = 1:num_classes_pred
            C(i, j) = sum(labels_true == classes_true(i) & labels_pred == classes_pred(j));
        end
    end
end

function result = comb2(n)
    % Calculate combinations of 2: n choose 2
    result = n .* (n - 1) / 2;
end
