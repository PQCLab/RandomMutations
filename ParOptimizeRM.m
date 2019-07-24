function [ global_best_f, global_best, bests, funEvals ] = ParOptimizeRM( f, len)
%Random mutations optimization.
%   Searching of a global minimum of 'f' function. 'len' 0 number of real
%   arguments.

global rmparams;

minmut = 1;
maxmut = rmparams.maxmut;
pop_size = rmparams.n_pop;
des_size = rmparams.n_des;
max_order = rmparams.p_max;
p_min = rmparams.p_min;
iters = rmparams.n_stall;
eps = rmparams.eps; 
b = rmparams.b;

min = -1;
max = 1;

funEval=0;

population = min+(max-min)*rand(len, pop_size);
descendants = zeros (len, des_size, pop_size);
results = zeros(des_size, pop_size);
global_best = zeros(len);
global_best_f = inf;
local_best = zeros(pop_size);
not_changed = 0;

iteration = 0;
while not_changed<iters
    changed = 0;
    %Generating descendants
    for p=1:pop_size

        local_best(p) = 1;
        for d=1:des_size
            descendants(:, d, p) = population(:, p);
            mutnumb = RandInt(minmut,maxmut);
            for m=1:mutnumb;
                pos = randi(len);
                descendants(pos,d,p) = descendants(pos, d, p) + b^RandInt(p_min, max_order)*2*(rand()-0.5);
            end;
            %Filling result            
        tasks{d} = descendants(:, d, p)';
        end
        
        par_res=zeros(1,des_size);
        
        %place to add parfor
        parfor d=1:des_size
            task = tasks{d};
            par_res(d) = f(task);
        end
        
        funEval=funEval+des_size;
        for d=1:des_size    
            r = par_res(d);
            results(d,p) = r;
            if(r<results(local_best(p), p))
                local_best(p) = d;
            end;
        end;
        %Renewing population
        population(:, p) = descendants(:, local_best(p), p);

        %Renewing global best
        if(global_best_f>=results(local_best(p), p))
            global_best_f_new = results(local_best(p), p);
            if abs(global_best_f_new - global_best_f)>eps
                changed = 1;
            end;
            global_best_f=global_best_f_new;
            global_best = descendants(:, local_best(p), p); 
        end;
    end;
    if(changed)
        not_changed=0;        
    else
        not_changed = not_changed + 1;
    end;
    iteration = iteration + 1;
    if(rmparams.display)
        iteration
        global_best_f
    end
    bests(iteration)=global_best_f;
    funEvals(iteration)=funEval;
end;


end

