function res = TestFunc( x )
%TESTFUNC Summary of this function goes here
%   Detailed explanation goes here

res = sum(abs(sin(x)))-4*abs(sin(x(1)));

end

