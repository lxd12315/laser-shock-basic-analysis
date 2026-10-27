function radius = ray_ellipse_distance(model,origin,theta_rad)
% Intersect outward rays from a fixed interaction origin with an ellipse.
% theta_rad is relative to the +x direction; adapt axes explicitly to images.
c=model.center;a=model.semiaxes(1);b=model.semiaxes(2);
dx=origin(1)-c(1);dy=origin(2)-c(2);
ux=cos(theta_rad);uy=sin(theta_rad);
A=ux.^2/a^2+uy.^2/b^2;
B=2*(dx*ux/a^2+dy*uy/b^2);C=dx^2/a^2+dy^2/b^2-1;
D=B.^2-4*A*C;assert(all(D(:)>=0),'A ray misses the fitted ellipse.');
r1=(-B+sqrt(D))./(2*A);r2=(-B-sqrt(D))./(2*A);
r1(r1<0)=NaN;r2(r2<0)=NaN;
radius=max([r1(:)';r2(:)'],[],1,'omitnan');radius=reshape(radius,size(theta_rad));
assert(all(isfinite(radius(:))),'No outward intersection.');
end
