# Random mutations optimization
MATLAB library for global optimization of an arbitrary function by random mutations algorithm. Version 0.2.

https://arxiv.org/abs/1304.3703

Before using the library, please read the [terms of use](#terms-of-use).

## Getting started
To use the library download and include the files to the search path.

Initialize the optimizer by calling `rm_init` and use the function `OptimizeRM` to perform optimization.

* `[global_best_f, global_best] = OptimizeRM(f, len)` returns minimum value `global_best_f` and minimum point `global_best` for the function handler `f` with `len` number of point parameters
* `[___] = OptimizeRM(f, len, start_point)` specifies the initial point `start_point` of search; by default `start_point` is an array of zeros
* `[___] = OptimizeRM(f, len, start_point, scale)` specifies the mutations scale (mutations are being multiplied by `scale`); by default `scale = 1`

## Optimizer parameters

Parameters of the algorithm are stored in the global variable `rmparams`:
* `rmparams.display` - display output (default: `1`)
* `rmparams.n_pop` - size of the population (default: `50`); linearly increases computation time, increases the probability of finding the global minimum
* `rmparams.n_des` - number of descendants (default: `10`); linearly increases computation time, increases the speed of convergence nearby the obtained minimum
* `rmparams.maxmut` - maximum number of parameters being mutated (default: `5`); should be greater than 2, depends on the function being optimized, but usually 5 works well
* `rmparams.n_stall` - number of iterations to stop the search when answer is less than `rmparams.eps` (default: `10`)
* `rmparams.eps` - optimization function tolerance (default: `1e-6`)
* `rmparams.p_min` - minimum scale power (default: `-9`); decreases convergence speed, increases accuracy of local convergence
* `rmparams.p_max` - maximum scale power (default: `1`)
* `rmparams.b` - scale factor (default: `10`)

Varying parameter is being changed by a factor `m*rmparams.b^p`, where `m` is uniformly distributed from `-1` to `1`, `p` is an integer uniformly distributed from `rmparams.p_min` to `rmparams.p_max`.

Calling `rm_init` initializes `rmparams` with default parameters values.

Variable `rmparams` also stores debug information on iterations:
* `rmparams.best_f` - array of minimal values on each iteration
* `rmparams.funEvals` - array of numbers of total evaluations of `f` from the start for each iteration
* `rmparams.best_x` - cell array of minimal points on each iteration

## Example
The following MATLAB script evaluates the global maximum of the function ![\sum{|sin(x_k+b)|}](https://latex.codecogs.com/svg.latex?\sum{|\sin(x_k+b)|}).
```
rm_init; % Initialize optimizer parameters
rmparams.n_pop = 100; % Change population size
[result, result_p] = OptimizeRM(@(p)-TestFunc(p, 0.5), 100); % Evaluate minimum

function res = TestFunc(x, b) % Function to minimize
  res = sum(abs(sin(x+b)));
end
```

## <a name="#terms-of-use">Terms of use</a>
This library is distributed under GNU General Public License v3.0.

For using the library in research work, please cite as:
> [1] Chernyavskiy A. Yu., Calculation of quantum discord and entanglement measures using the random mutations optimization algorithm, arXiv:1304.3703 [quant-ph], 2013.  
> [2] Chernyavskiy A. Yu., Global optimization solver for MATLAB, URL: https://github.com/PQCLab/RandomMutations
