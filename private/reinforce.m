function [bestPosition, bestCost, history] = reinforce(objective, positions, costs, lb, ub, budget, prefix)
% The legacy entry point supplies evaluated learners and an empty history.
[count, n] = size(positions);
rate = 0.7;
schedules = 0.9 + 0.1 * rand(count,n);
[bestCost, leader] = min(costs);
bestPosition = positions(leader,:);
history = zeros(budget,1);
used = numel(prefix);
history(1:used) = prefix;

while used < budget
    [~, order] = sort(costs);
    for rank = 1:count
        i = order(rank);
        peer = i;
        if rank < count
            peer = order(randi([rank+1, count]));
        end
        % Select the highest-priority coordinates (equations 1 and 2).
        tau = used / budget;
        [~, priority] = sort(schedules(i,:), 'descend');
        selected = priority(1:max(1, ceil(n * rand * exp(tau - 1))));
        candidate = positions(i,:);
        if rand < 0.5
            direction = bestPosition(selected) - candidate(selected);
        else
            direction = candidate(selected) - positions(peer,selected);
        end
        factor = tau + rand * mean(schedules(i,selected) / max(schedules(i,:)));
        candidate(selected) = candidate(selected) + factor * direction;
        outside = candidate < lb | candidate > ub;
        candidate(outside) = lb(outside) + rand(1,nnz(outside)) .* (ub(outside) - lb(outside));

        cost = evaluate(objective, candidate);
        if cost < costs(i)
            positions(i,:) = candidate;
            costs(i) = cost;
            schedules(i,selected) = schedules(i,selected) * (1 + rate/2);
            if cost < bestCost
                bestPosition = candidate;
                bestCost = cost;
            end
        else
            schedules(i,selected) = schedules(i,selected) * (1 - rate);
        end
        used = used + 1;
        history(used) = bestCost;

        if used < budget && std(schedules(i,:)) == 0
            schedules(i,:) = 0.9 + 0.1 * rand(1,n);
            positions(i,:) = lb + rand(1,n) .* (ub - lb);
            costs(i) = evaluate(objective, positions(i,:));
            if costs(i) < bestCost
                bestPosition = positions(i,:);
                bestCost = costs(i);
            end
            used = used + 1;
            history(used) = bestCost;
        end
        if used == budget
            break
        end
    end
end
end
