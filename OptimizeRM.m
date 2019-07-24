function [ global_best_f, global_best ] = OptimizeRM( f, len, start_point, scale)
%Random mutations optimization.
%   Searching of a global minimum of 'f' function. 'len' 0 number of real
%   arguments.

global rmparams;

clear rmparams.best_f rmparams.funEvals rmparams.best_x

if(nargin<3)
    start_point = zeros(len,1);
end
if(nargin<4)
    scale = 1;
end
minmut = 1;
maxmut = rmparams.maxmut;
pop_size = rmparams.n_pop;
des_size = rmparams.n_des;
max_order = rmparams.p_max;
p_min = rmparams.p_min;
iters = rmparams.n_stall;
eps = rmparams.eps; 
b = rmparams.b;

min = -1*scale;
max = 1*scale;

funEval=0;

population = start_point*ones(1,pop_size) + min+(max-min)*rand(len, pop_size);
descendants = zeros (len, des_size, pop_size);
results = zeros(des_size, pop_size);
global_best = zeros(len);
global_best_f = inf;
local_best = zeros(pop_size);
not_changed = 0;

iteration = 0;
start_time = datetime('now');
while not_changed<iters
    changed = 0;
    %Generating descendants
    for p=1:pop_size

        local_best(p) = 1;
        for d=1:des_size
            descendants(:, d, p) = population(:, p);
            mutnumb = RandInt(minmut,maxmut);
            for m=1:mutnumb
                pos = randi(len);
                descendants(pos,d,p) = descendants(pos, d, p) + b^RandInt(p_min, max_order)*2*(rand()-0.5);
            end
            %Filling result
            v = descendants(:, d, p);
            r = f(v');
            funEval=funEval+1;
            results(d,p) = r;
            if(r<results(local_best(p), p))
                local_best(p) = d;
            end
        end
        %Renewing population
        population(:, p) = descendants(:, local_best(p), p);

        %Renewing global best
        if(global_best_f>=results(local_best(p), p))
            global_best_f_new = results(local_best(p), p);
            if abs(global_best_f_new - global_best_f)>eps
                changed = 1;
            end
            global_best_f=global_best_f_new;
            global_best = descendants(:, local_best(p), p); 
        end
    end
    if(changed)
        not_changed=0;        
    else
        not_changed = not_changed + 1;
    end
    iteration = iteration + 1;
    if(rmparams.display)
        stime = between(start_time, datetime('now'));
        fprintf("%i: %0.12f (%s)\n", iteration, global_best_f, stime);
    end
    rmparams.best_f(iteration)=global_best_f;
    rmparams.funEvals(iteration)=funEval;
    rmparams.best_x{iteration}=global_best;
end


end

