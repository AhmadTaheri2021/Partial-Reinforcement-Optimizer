% Minimize the 10-dimensional sphere function and plot convergence.
rng(42, 'twister');
[bestPosition, bestCost, history] = pro(@(x) sum(x.^2), 10, -100, 100, 30, 10000);
fprintf('Best objective after %d evaluations: %.8g\n', numel(history), bestCost);
figure;
semilogy(max(history, realmin));
xlabel('Objective evaluations');
ylabel('Best sphere value');
grid on;
