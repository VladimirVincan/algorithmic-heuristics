function [best_result, best_pair] = RandomSearchAlgorithm(func, min_b, max_b)

max_iteration = 10000;
cost = 0;
best_pair = [];

syms x1 x2;

x1 = min_b;
x2 = max_b;

best_result = eval(func);

for i = 1 : max_iteration
    x1 = (max_b - min_b)*rand() + min_b;
    x2 = (max_b - min_b)*rand() + min_b;
    cost = eval(func);
    if(cost < best_result)
        best_result = cost;
        best_pair = [x1, x2];
        fprintf('Minimum u iteraciji %d i iznosi %i\n', i, best_result);
    end
end

fprintf('\nMinimalna vrednost funkcije je %i za parove\nx1 = %i\nx2 = %i\n\n',best_result, best_pair(1), best_pair(2));

%[x1, x2] = AdaptiveRandomSearch(func, best, best_pair);