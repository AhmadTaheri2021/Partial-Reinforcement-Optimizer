function [lb, ub] = boxBounds(n, lb, ub)
% Expand scalar bounds and normalize coordinate vectors to rows.
lb = expandBound(lb, n);
ub = expandBound(ub, n);
if any(lb > ub)
    error('pro:Bounds', 'Each lower bound must be at most its upper bound.');
end
end

function bound = expandBound(bound, n)
validateattributes(bound, {'double'}, {'real','finite','vector','nonempty'});
if isscalar(bound)
    bound = repmat(bound, 1, n);
elseif numel(bound) == n
    bound = reshape(bound, 1, n);
else
    error('pro:Bounds', 'Supply a scalar bound or one bound per dimension.');
end
end
