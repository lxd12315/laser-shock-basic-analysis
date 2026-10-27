% Synthetic numerical checks only; no experimental results are generated.
t = linspace(0,2*pi,100)';
x = 2 + 4*cos(t);
y = -1 + 2*sin(t);
m = fit_axis_aligned_front(x,y);
assert(norm(m.center-[2 -1]) < 1e-10);
assert(norm(m.semiaxes-[4 2]) < 1e-10);
fprintf('Ellipse center: expected [2 -1], computed [%.12g %.12g]\n',m.center);
fprintf('Ellipse semiaxes: expected [4 2], computed [%.12g %.12g]\n',m.semiaxes);

% Rays from the center, an off-center origin, and vectorized angles.
r = ray_ellipse_distance(m,[2 -1],[0 pi/2]);
assert(norm(r-[4 2]) < 1e-10);
r = ray_ellipse_distance(m,[0 -1],0);
assert(abs(r-6) < 1e-10);
fprintf('Off-center ray distance: expected 6, computed %.12g\n',r);
r = ray_ellipse_distance(m,[2 -1],[0 pi/4 pi/2]);
assert(isequal(size(r),[1 3]));
expected = 1/sqrt((cos(pi/4)^2/16)+(sin(pi/4)^2/4));
assert(abs(r(2)-expected) < 1e-10);
fprintf('45-degree ray distance: expected %.12g, computed %.12g\n',expected,r(2));

% Paired-unit delta-method result, checked against direct calculation.
a = [2 4 5 7]';
b = [1 3 2 4]';
[q,u] = ratio_uncertainty(a,b);
mu = mean([a b],1);
g = [1/mu(2); -mu(1)/mu(2)^2];
u_expected = sqrt(g'*(cov([a b])/numel(a))*g);
assert(abs(q-mu(1)/mu(2)) < 1e-12);
assert(abs(u-u_expected) < 1e-12);
fprintf('Paired ratio: expected %.12g, computed %.12g\n',mu(1)/mu(2),q);
fprintf('Ratio standard uncertainty: expected %.12g, computed %.12g\n',u_expected,u);

assert_error(@() fit_axis_aligned_front([1 2 3],[1 2 3]), ...
    'fit_axis_aligned_front:TooFewPoints');
assert_error(@() ratio_uncertainty(1,2), ...
    'ratio_uncertainty:TooFewUnits');
assert_error(@() ray_ellipse_distance(m,[20 20],0), ...
    'ray_ellipse_distance:RayMissesEllipse');

disp('All reference numerical and input-validation checks passed.');

function assert_error(f,expected_id)
try
    f();
catch exception
    assert(strcmp(exception.identifier,expected_id), ...
        'Expected error %s but received %s.', ...
        expected_id,exception.identifier);
    return
end
error('test_basic_functions:ExpectedError', ...
    'Expected error %s was not raised.',expected_id);
end
