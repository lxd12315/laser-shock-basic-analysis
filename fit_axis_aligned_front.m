function model = fit_axis_aligned_front(x,y)
%FIT_AXIS_ALIGNED_FRONT Fit an axis-aligned ellipse to contour coordinates.
% x and y must be finite, real coordinate vectors with at least five points.
% Coordinates must use the same spatial unit. Image segmentation and point
% screening are not performed by this function.
validateattributes(x,{'numeric'},{'real','finite','vector'});
validateattributes(y,{'numeric'},{'real','finite','vector'});
if numel(x) < 5 || numel(y) < 5
    error('fit_axis_aligned_front:TooFewPoints', ...
        'At least five contour points are required.');
end
if numel(x) ~= numel(y)
    error('fit_axis_aligned_front:SizeMismatch', ...
        'x and y must contain the same number of points.');
end
x = double(x(:));
y = double(y(:));
sx = max(abs(x));
sy = max(abs(y));
if sx == 0 || sy == 0
    error('fit_axis_aligned_front:ZeroScale', ...
        'Both coordinate axes must have a nonzero scale.');
end

u = x / sx;
v = y / sy;
B = [v.^2 u v ones(size(u))];
if rank(B) < 4
    error('fit_axis_aligned_front:DegenerateContour', ...
        'The contour coordinates do not determine a unique ellipse.');
end
beta = B \ (-u.^2);
if beta(1) <= 0
    error('fit_axis_aligned_front:NotEllipse', ...
        'The fitted conic is not a real axis-aligned ellipse.');
end
xc = -beta(2) / 2;
yc = -beta(3) / (2 * beta(1));
q = xc^2 + beta(1) * yc^2 - beta(4);
if ~isfinite(q) || q <= 0
    error('fit_axis_aligned_front:NotEllipse', ...
        'The fitted conic has nonpositive or nonfinite squared axes.');
end

model.center = [xc * sx yc * sy];
model.semiaxes = [sqrt(q) * sx sqrt(q / beta(1)) * sy];
model.normalization = [sx sy];
model.beta = beta;
model.algebraic_residual = u.^2 + B * beta;
end
