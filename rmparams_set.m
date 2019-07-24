function  res = rmparams_set( n_pop, n_des, eps, n_stall )
%RMPARAMS_SET Summary of this function goes here
%   Detailed explanation goes here
global rmparams;

rmparams.n_pop=n_pop;
if nargin>=2
    rmparams.n_des=n_des;
    if nargin>=3
        rmparams.eps=eps;
        if nargin >=4
            rmparams.n_stall=n_stall;
        end
    end
end
res = rmparams;
end

