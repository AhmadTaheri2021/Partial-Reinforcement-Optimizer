function [bestPosition, bestCost, history] = pro(objective, n, lb, ub, populationSize, maxEvaluations)
%PRO Minimize a scalar objective over box bounds using partial reinforcement.
%   [X, F, HISTORY] = PRO(OBJECTIVE, N, LB, UB, POPULATIONSIZE, MAXEVALUATIONS)
%   passes 1-by-N row vectors to OBJECTIVE. HISTORY(j) is the best value
%   after j calls, including initialization. Set rng before calling to replay a run.

validateattributes(objective, {'function_handle'}, {'scalar'});
validateattributes(n, {'double'}, {'scalar','integer','positive','finite'});
validateattributes(populationSize, {'double'}, {'scalar','integer','positive','finite'});
validateattributes(maxEvaluations, {'double'}, {'scalar','integer','finite','>=',populationSize});
[lb, ub] = boxBounds(n, lb, ub);
positions = zeros(populationSize, n);
costs = zeros(populationSize, 1);
for i = 1:populationSize
    positions(i,:) = lb + rand(1,n) .* (ub - lb);
    costs(i) = evaluate(objective, positions(i,:));
end
[bestPosition, bestCost, history] = reinforce(objective, positions, costs, lb, ub, ...
    maxEvaluations, cummin(costs));
end
