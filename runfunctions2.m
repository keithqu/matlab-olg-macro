% KQ, 10/2016
%
% OLG model with CRRA utility and many customizable parameters
% 2 subroutines:
%   * bisect.m which simply solves for a steady state
%   * bisectrecur.m which solves for the next time period.
%       Here it is used to draw a general capital motion diagram, but it
%       can easily be used with a different setup to hone in on the steady
%       state one step at a time.

clc;
clear;

% Solution for base case; m*1.1 will be used for interval bounds
m=bisect(1,1,25,(1./3),(1./2),1,0,0);
fprintf('\nPart (c) steady state capital stock: %.8f\n',m);

% Start recursion at kj=0.001 to avoid triggering errors, though it will
% still work starting at 0.
kt=linspace(0.001,m*1.1,100);
for i=1:100
    mc(i)=bisectrecur(1,1,25,(1./3),(1./2),1,0,0,kt(i));
end

% Now let's do part d with l2=1/2
ssd=bisect(1,1,25,(1./3),(1./2),1,0.5,0);
fprintf('\nPart (d) steady state capital stock: %.8f\n',ssd);
for i=1:100
    md(i)=bisectrecur(1,1,25,(1./3),(1./2),1,0.5,0,kt(i));
end

%Part e with s=2
sse=bisect(1,2,25,(1./3),(1./2),1,0,0);
fprintf('\nPart (e) steady state capital stock: %.8f\n',sse);
for i=1:100
    me(i)=bisectrecur(1,2,25,(1./3),(1./2),1,0,0,kt(i));
end

%Part f with t=0.1
ssf=bisect(1,1,25,(1./3),(1./2),1,0,0.1);
fprintf('\nPart (f) steady state capital stock: %.8f\n',ssf);
for i=1:100
    mf(i)=bisectrecur(1,1,25,(1./3),(1./2),1,0,0.1,kt(i));
end

figure;
hold on;
plot(kt,mc,kt,kt,'--'), xlabel('Kt'),ylabel('Kt+1'),title('Capital motion'), grid on;
axis([0,m*1.1,0,m*1.1]);
text(m,m,['c: (' num2str(m) ')']);

plot(kt,md);
text(ssd,ssd,['d: (' num2str(ssd) ')']);

plot(kt,me);
text(sse,sse,['e: (' num2str(sse) ')']);

plot(kt,mf);
text(ssf,ssf,['f: (' num2str(ssf) ')']);
