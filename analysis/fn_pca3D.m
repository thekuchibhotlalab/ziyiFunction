function [proj_data, coeff, score, latent, explained] = fn_pca3D(data, norm_option, nComponents)
% PCA on neuron dimension (first dimension) of a 3D matrix
%
% Inputs:
%   data         - nNeuron x time x trialType matrix
%   norm_option  - 'zscore' or 'center' (default: 'center')
%   nComponents  - (optional) number of principal components to retain
%
% Outputs:
%   proj_data    - nComponent x time x trialType projection
%   coeff        - PCA weights (neuron x component)
%   score        - Scores in PCA space (sample x component)
%   latent       - Eigenvalues (variance captured)
%   explained    - Percent variance explained by each component

    if nargin < 2 || isempty(norm_option)
        norm_option = 'center';
    end
    if nargin < 3
        nComponents = [];
    end

    [nNeuron, nTime, nCond] = size(data);
    data_2d = reshape(data, nNeuron, []);

    switch lower(norm_option)
        case 'zscore'
            data_2d = zscore(data_2d, 0, 2);  % normalize across each neuron
        case 'center'
            data_2d = data_2d - mean(data_2d, 2);  % mean-center each neuron
        otherwise
            error('Unknown normalization option: use ''zscore'' or ''center''.');
    end

    % PCA expects observations in rows (samples) and variables in columns
    [coeff, score, latent, ~, explained] = pca(data_2d');

    if ~isempty(nComponents)
        coeff = coeff(:, 1:nComponents);
        score = score(:, 1:nComponents);
        latent = latent(1:nComponents);
        explained = explained(1:nComponents);
    end

    % Reshape score to (nComponent x time x trialType)
    proj_data = reshape(score', size(score, 2), nTime, nCond);
end
