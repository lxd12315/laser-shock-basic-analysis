function model = fit_axis_aligned_front(x,y)
% Fit an axis-aligned ellipse to an already extracted contour.
% Inputs: equally sized coordinate vectors, in the same spatial units.
% This function does not perform image segmentation or statistical screening.
x=x(:);y=y(:);assert(numel(x)==numel(y)&&numel(x)>=5);
assert(all(isfinite(x))&&all(isfinite(y)));
sx=max(abs(x));sy=max(abs(y));assert(sx>0&&sy>0);
u=x/sx;v=y/sy;B=[v.^2 u v ones(size(u))];
beta=B\(-u.^2);assert(rank(B)==4,'Contour is geometrically degenerate.');
xc=-beta(2)/2;yc=-beta(3)/(2*beta(1));
q=xc^2+beta(1)*yc^2-beta(4);
assert(beta(1)>0&&q>0,'The fitted conic is not a real ellipse.');
model.center=[xc*sx yc*sy];model.semiaxes=[sqrt(q)*sx sqrt(q/beta(1))*sy];
model.normalization=[sx sy];model.beta=beta;
model.algebraic_residual=u.^2+B*beta;
end
