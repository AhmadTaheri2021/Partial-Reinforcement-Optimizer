# Partial Reinforcement Optimizer (PRO)

MATLAB implementation of the Partial Reinforcement Optimizer for box-constrained minimization. Each learner maintains a priority for each decision variable. PRO perturbs a subset of high-priority variables, accepts improvements, and adjusts the priorities according to the outcome.

## Quick start

Clone the repository and open its root folder in MATLAB. The optimizer and sphere example use base MATLAB.

```matlab
rng(42, 'twister');
sphereCost = @(x) sum(x.^2);
[x, f, history] = pro(sphereCost, 10, -100, 100, 30, 10000);
```

This minimizes the 10-dimensional sphere function with 30 learners and 10,000 objective evaluations. The known minimum is zero at the origin. Run `Run_PRO` for a convergence plot.

## MATLAB API

```matlab
[x, f, history] = pro(objective, n, lb, ub, populationSize, maxEvaluations)
```

- `objective` receives a 1-by-`n` row vector and returns a real scalar cost. Smaller values are better.
- `lb` and `ub` may be scalars or vectors of length `n`. Equal bounds fix a coordinate.
- `maxEvaluations` must be at least `populationSize`. The budget includes initialization, candidate evaluations, and rescheduling.
- `x` is the best position observed, `f` its cost, and `history(j)` the best cost through evaluation `j`. The optimizer uses the caller's random stream.

## Running an external CEC2017 benchmark

Keep the benchmark in a separate directory with its original `input_data/` folder. Add the PRO repository to the MATLAB path and change the working directory to the benchmark folder. The original evaluator opens data files relative to the working directory. Use a MEX binary built for your platform, or compile the supplied source with a configured MATLAB C++ compiler.

```matlab
addpath('/absolute/path/to/Partial-Reinforcement-Optimizer');
cd('/absolute/path/to/PRO Matlab Code CEC2017');
% If your platform needs a new binary, compile once:
% mex cec17_func.cpp
rng(42, 'twister');
functionId = 1;
objective = @(x) cec17_func(x(:), functionId);
[x, f, history] = pro(objective, 10, -100, 100, 30, 100000);
```

If the benchmark directory also contains the original MATLAB scripts, MATLAB gives those local scripts precedence. The example above calls the new `pro` entry point directly.

Existing experiments with pre-evaluated learners can use the original calling convention:

```matlab
[BestCosts, BestSolCost] = PRO_v1(N, MaxFEs, LB, UB, population, pop_size, ObjFunc_ID);
```

Each learner supplies `Position` and `Cost`. Here `MaxFEs` counts **additional** objective calls. Both entry points now count rescheduled learners, retain improvements found during rescheduling, and stop exactly at the requested budget. These changes and caller-controlled seeding can produce different convergence traces from the 2023 scripts.

## Tests

Run from the repository root:

```matlab
addpath('tests');
test_pro
```

## Citation

Ahmad Taheri, Keyvan RahimiZadeh, Amin Beheshti, Jan Baumbach, Ravipudi Venkata Rao, Seyedali Mirjalili, and Amir H. Gandomi. “Partial reinforcement optimizer: an evolutionary optimization algorithm.” *Expert Systems with Applications* 238 (2024), 122070.

## License

[Apache License 2.0](LICENSE)
