function cost = evaluate(objective, position)
cost = objective(position);
validateattributes(cost, {'numeric'}, {'scalar','real','nonnan'});
end
