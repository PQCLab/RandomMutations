function [ res ] = RandInt( min, max )
%RANDINT Summary of this function goes here
%   Detailed explanation goes here
res = randi(max-min+1)+min-1;

end

