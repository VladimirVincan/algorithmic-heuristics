function AdaptiveRandomSearch(func, min_b, max_b, best_result, best_pair)

% ulazni parametri
max_iteration = 5000;
min_b = -5;
max_b = 5;
cost = 0;
step_size_init = 0.05;
step_size_small_factor = 1.3;
step_size_large_factor = 3;
step_size_iter_factor = 10;
no_change_max = 20;

no_change_count = 0;
step_size = (max_b - min_b) * step_size_init;

syms x1 x2;
%func = (x1.^2 + x2.^2)/200 - cos(x1).*cos(x2/sqrt(2)) + 1;

x1 = best_pair(1);
x2 = best_pair(2);

current_pair = best_pair;
best = best_result;

for i = 1 : max_iteration
    pair1 = takeStep(min_b, max_b, current_pair, step_size);
    cost1 = getCost(func, pair1);
    step_size_large = 0;
    if(mod(i,step_size_iter_factor) == 0)
        step_size_large = step_size * step_size_large_factor;
    else
        step_size_large = step_size * step_size_small_factor;
    end
    pair2 = takeStep(min_b, max_b, current_pair, step_size_large);
    cost2 = getCost(func, pair2);
    if(cost1 <= best || cost2 <= best)
        if(cost2 < cost1)
            best = cost2;
            current_pair = pair2; 
            step_size = step_size_large;
        else
            best = cost1;
            current_pair = pair1;
        end
        no_change_count = 0;
        fprintf('Minimum u iteraciji %d i iznosi %i\n', i, best);
    else
        no_change_count = no_change_count + 1;
        if(no_change_count > no_change_max)
            no_change_count = 0;
            step_size = step_size/step_size_small_factor;
        end
    end 
end

fprintf('\nMinimalna vrednost funkcije je %i za parove\nx1 = %i\nx2 = %i\n',best, current_pair(1), current_pair(2));

%x1 = current_pair(1);
%x2 = current_pair(2);