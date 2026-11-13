function test_pro
% Verify every call against the returned trace, including 1-D rescheduling.
for n = [1, 4]
    for budget = [5, 6, 37]
        calls = zeros(budget,1);
        used = 0;
        lb = -(1:n);
        ub = 2 * (1:n);
        rng(17);
        [x, f, trace] = pro(@record, n, lb', ub, 5, budget);
        assert(used == budget && isequal(trace, cummin(calls)));
        assert(f == trace(end) && f == sum(x.^2));
        used = 0;
        rng(17);
        [x2, f2, trace2] = pro(@record, n, lb', ub, 5, budget);
        assert(isequal(x,x2) && f == f2 && isequal(trace,trace2));
    end
end

    function y = record(x)
        assert(isequal(size(x), [1,n]) && all(x >= lb & x <= ub));
        y = sum(x.^2);
        used = used + 1;
        calls(used) = y;
    end
end
