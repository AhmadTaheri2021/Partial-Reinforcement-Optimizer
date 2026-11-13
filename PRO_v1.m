function [BestCosts, BestSolCost] = PRO_v1(N, MaxFEs, LB, UB, population, pop_size, ObjFunc_ID)
%PRO_V1 Run PRO with an evaluated population and an external CEC2017 objective.
%   MaxFEs counts additional evaluations after the supplied population.
validateattributes(N, {'double'}, {'scalar','integer','positive','finite'});
validateattributes(MaxFEs, {'double'}, {'scalar','integer','positive','finite'});
validateattributes(pop_size, {'double'}, {'scalar','integer','positive','finite'});
validateattributes(population, {'struct'}, {'numel',pop_size});
[LB, UB] = boxBounds(N, LB, UB);
positions = zeros(pop_size,N);
costs = zeros(pop_size,1);
for i = 1:pop_size
    point = population(i).Position;
    validateattributes(point, {'double'}, {'vector','numel',N,'finite','real'});
    positions(i,:) = reshape(point, 1, N);
    if any(positions(i,:) < LB | positions(i,:) > UB)
        error('pro:Population', 'Initial positions must lie within the bounds.');
    end
    validateattributes(population(i).Cost, {'numeric'}, {'real','scalar','nonnan'});
    costs(i) = population(i).Cost;
end
objective = @(x) cec17_func(x(:), ObjFunc_ID);
[~, BestSolCost, BestCosts] = reinforce(objective, positions, costs, LB, UB, MaxFEs, []);
end
