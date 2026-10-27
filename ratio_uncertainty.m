function [q,u] = ratio_uncertainty(numerator,denominator)
% Delta-method uncertainty for the ratio of paired independent-unit means.
% Rows must be independent acquisition units, not recombined data rows.
n=numel(numerator);assert(n==numel(denominator)&&n>=2);
z=[numerator(:) denominator(:)];assert(all(isfinite(z),'all'));
m=mean(z,1);assert(m(2)~=0);q=m(1)/m(2);
g=[1/m(2);-m(1)/m(2)^2];u=sqrt(max(0,g'*(cov(z)/n)*g));
end
