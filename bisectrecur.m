% step by step bisection
% Run with set horizontal axis intervals for a general law of motion
% diagram. Or use a recursive setup to find the next kt+1 with every
% new solution.
function [m] = bisectrecur(B,s,A,a,d,l1,l2,t,kj)

% bisection parameters
k1 = 0.001;
k2 = 100;
m=0;
eps = 1e-6;         % tolerance epsilon

% really ugly function with fixed kj
ff=@(k) -k+((1-t).*l1.*A.*(1-a).*kj.^a.*(l1+l2).^(-a)- ...
            B.^(-1./s).*(1+A.*a.*k.^(a-1).*(l1+l2).^(1-a)-d).^(-1./s).* ...
            A.*(1-a).*k.^a.*(l1+l2).^(-a).*(l2+t.*l1))./ ...
            (1+B.^(-1./s).*(1+A.*a.*k.^(a-1).*(l1+l2).^(1-a)-d).^((s-1)./s));

% Recursion until steady
if ff(k1) * ff(k2) >= 0 
    fprintf('\nerror, change endpoints\n')
else 
    m = (k1+k2)./2;
    error = abs(ff(m));
    while error > eps
    if ff(m) * ff(k1) < 0
        k2 = m;
    else k1 = m;
    end
        m = (k1+k2)./2;
        error = abs(ff(m));
    end
end

end