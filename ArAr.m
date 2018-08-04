% 40Ar/39Ar age calculator
function [t,sigt] = ArAr(l,J,Ar40Ar39,sigAr)
    
    t = log(Ar40Ar39*J + 1)/l;
    t = t(:);
    sigt = sqrt(sigAr.^2 .* (J/(l*(Ar40Ar39*J+1))).^2 );
    sigt = sigt';
    
end