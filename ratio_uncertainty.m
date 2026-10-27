function [q,u] = ratio_uncertainty(numerator,denominator)
%RATIO_UNCERTAINTY Delta-method SE for a ratio of paired means.
% Each row must represent one independent acquisition unit, with paired
% numerator and denominator values from that same unit.
validateattributes(numerator,{'numeric'},{'real','finite','vector'});
validateattributes(denominator,{'numeric'},{'real','finite','vector'});
if numel(numerator) ~= numel(denominator)
    error('ratio_uncertainty:SizeMismatch', ...
        'Numerator and denominator must have the same number of units.');
end
z = double([numerator(:) denominator(:)]);
n = size(z,1);
if n < 2
    error('ratio_uncertainty:TooFewUnits', ...
        'At least two independent paired units are required.');
end
m = mean(z,1);
if m(2) == 0
    error('ratio_uncertainty:ZeroMeanDenominator', ...
        'The mean denominator must be nonzero.');
end
q = m(1) / m(2);
g = [1 / m(2); -m(1) / m(2)^2];
variance = g' * (cov(z) / n) * g;
tol = 64 * eps(max(1,norm(cov(z) / n,'fro') * norm(g)^2));
if variance < -tol
    error('ratio_uncertainty:NegativeVariance', ...
        'The propagated variance is negative beyond numerical tolerance.');
end
u = sqrt(max(0,variance));
end
