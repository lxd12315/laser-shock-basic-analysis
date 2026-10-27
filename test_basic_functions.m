% Synthetic numerical checks only; no experimental results are generated.
t=linspace(0,2*pi,100)';x=2+4*cos(t);y=-1+2*sin(t);
m=fit_axis_aligned_front(x,y);
assert(norm(m.center-[2 -1])<1e-10);
assert(norm(m.semiaxes-[4 2])<1e-10);
r=ray_ellipse_distance(m,[2 -1],[0 pi/2]);assert(norm(r-[4 2])<1e-10);
[q,u]=ratio_uncertainty([2 4 6],[1 2 3]);assert(abs(q-2)<1e-12&&u<1e-7);
disp('All basic numerical checks passed.');
