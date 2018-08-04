% K-Ar age calculator
function [t,sigt] = KAr(l,le,Ar40K40,sigAK)
    Ar40K40 = Ar40K40(:);
    sigAK = sigAK(:);
    
    t = log(Ar40K40*(l/le) + 1)/l;
    t = t(:);
    sigt = sqrt(sigAK.^2 .* (1./(Ar40K40*l+le)).^2 );
    sigt = sigt(:);
    
end