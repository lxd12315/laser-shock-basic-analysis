function radius = ray_ellipse_distance(model,origin,theta_rad)
%RAY_ELLIPSE_DISTANCE Intersect rays with an axis-aligned ellipse.
% origin is [x y]; theta_rad is measured from +x in the coordinate system
% used for the fitted ellipse. Returns the forward ellipse intersection
% in the same spatial unit as model.center and model.semiaxes.
if ~isstruct(model) || ~isfield(model,'center') || ~isfield(model,'semiaxes')
    error('ray_ellipse_distance:InvalidModel', ...
        'model must contain center and semiaxes fields.');
end
validateattributes(model.center,{'numeric'},{'real','finite','vector','numel',2});
validateattributes(model.semiaxes,{'numeric'},{'real','finite','positive','vector','numel',2});
validateattributes(origin,{'numeric'},{'real','finite','vector','numel',2});
validateattributes(theta_rad,{'numeric'},{'real','finite'});

c = double(model.center(:));
ab = double(model.semiaxes(:));
o = double(origin(:));
a = ab(1);
b = ab(2);
dx = o(1) - c(1);
dy = o(2) - c(2);
ux = cos(theta_rad);
uy = sin(theta_rad);
A = ux.^2 / a^2 + uy.^2 / b^2;
B = 2 * (dx .* ux / a^2 + dy .* uy / b^2);
C = dx^2 / a^2 + dy^2 / b^2 - 1;
D = B.^2 - 4 .* A .* C;
scale = max([1; abs(B(:)).^2; abs(4 .* A(:) .* C)]);
tol = 32 * eps(scale);
if any(D(:) < -tol)
    error('ray_ellipse_distance:RayMissesEllipse', ...
        'At least one ray does not intersect the ellipse.');
end
D = max(D,0);
r1 = (-B + sqrt(D)) ./ (2 .* A);
r2 = (-B - sqrt(D)) ./ (2 .* A);
r1(r1 < 0) = -Inf;
r2(r2 < 0) = -Inf;
radius = max(r1,r2);
if any(~isfinite(radius(:)))
    error('ray_ellipse_distance:NoForwardIntersection', ...
        'At least one ray has no nonnegative intersection.');
end
end
