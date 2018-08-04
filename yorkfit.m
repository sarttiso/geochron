% X: observations in x dimension
% Y: observations in y dimension
% wx: weights for each observation in x
% wy: weights for each observation in y
% r: correlations between data errors
% j: number of times to iterate
%
% b: slope
% c: intercept
%
% Based on: 'Least Squares Fitting of a  Straight Line with Correlcated
% Errors', Derek York, 1969

function [b,c,bstd,cstd] = yorkfit(x,y,wx,wy,r,j)

b0 = polyfit(x,y,1);
b0 = b0(1);     % Initial guess for slope

for j = 1:j
    Z  = (wx.*wy)./(b0^2*wy+wx-2*b0*r.*sqrt(wx.*wy));
    Xm = sum(Z.*x)/sum(Z);
    Ym = sum(Z.*y)/sum(Z);
    U  = x-Xm;
    V  = y-Ym;
    a  = sqrt(wx.*wy);
    b = sum(Z.^2.*V.* (U./wy + (b0*V)./wx - (b0*U+V).*(r./a)))/ ...
        sum(Z.^2.*U.* (U./wy + (b0*V)./wx - (b0*U+V).*(r./a)));
    b0 = b;
end
c = Ym - b*Xm;

bp = Z.*(U./wy + (b*V)./wx - (b*U+V).*(r./a));
u = Xm + bp;
v = Ym + b*bp;

xm = sum(Z.*u)/sum(Z);
ym = sum(Z.*v)/sum(Z);

bstd = sqrt(1./sum(Z.*(u-xm).^2));
cstd = sqrt( (1./sum(Z)) + xm^2*bstd^2);

end