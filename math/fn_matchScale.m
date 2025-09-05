function [Bmatched] = fn_matchScale(A, B)
% Match array B to the scale (std) and mean of A.
% Steps: mean-subtract B, scale to std(A), then add mean(A).
% NaNs are ignored when computing statistics.
%
% Inputs:  A, B  (numeric arrays; any shape)
% Outputs: Bmatched (same size as B), params (struct of used stats)

muA = mean(A(:), 'omitnan');
sdA = std( A(:), 0, 'omitnan');

muB = mean(B(:), 'omitnan');
sdB = std( B(:), 0, 'omitnan');

% protect against zero/NaN std
if ~isfinite(sdB) || sdB == 0
    scale = 0;              % cannot scale a constant; result becomes all muA after shift
else
    scale = sdA / sdB;
end

Bmatched = (B - muB) * scale + muA;

if ~isfinite(muA); muA = NaN; end
if ~isfinite(sdA); sdA = NaN; end
if ~isfinite(muB); muB = NaN; end
if ~isfinite(sdB); sdB = NaN; end

params = struct( ...
    'muA', muA, 'sdA', sdA, ...
    'muB', muB, 'sdB', sdB, ...
    'scale', scale, ...
    'effectiveShift', muA - scale*muB);   % so that Bmatched = scale*B + effectiveShift
end
