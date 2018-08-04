% This function recalculates an 40Ar/39Ar age with a new standard age.

function t2 = ARARchangestd(std_old,std_new,t1,l)
    defval('l',5.543e-10)
    t2 = log((exp(l*t1)-1)*(exp(l*std_new)-1)/(exp(l*std_old)-1) + 1)/l;
end