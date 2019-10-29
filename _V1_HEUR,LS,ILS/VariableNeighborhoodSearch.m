function [best_result, best_pair] = VariableNeighborhoodSearch(func, stop_iterations, k_max, L, min_b, max_b)

    iterations = 0;

    [best_result, best_pair] = RandomSolutionInNeighborhood(func, L, min_b,max_b,min_b,max_b);
    candidate_result = best_result;
    candidate_piar = best_pair;

    while not(StopCondition(iterations, stop_iterations))
        x_min = min_b;
        x_max = max_b;
        y_min = min_b;
        y_max = max_b;

        %fprintf('Iteration [%d] = %i\n', iterations, best_result);
        
        for k = 1:k_max
            %fprintf('\nIteracija k[%d] = %i\nx1 = %i\nx2 = %i\n\n', k, best_result, best_pair(1),best_pair(2));
            [candidate_result, candidate_pair] = RandomSolutionInNeighborhood(func, L,x_min,x_max,y_min,y_max);
            if(candidate_result < best_result)
                best_result = candidate_result;
                best_pair = candidate_pair;
                %fprintf('Minimum u iteraciji %d i iznosi %i\n', k, best_result);
                fprintf('\nIteracija k[%d] = %i\nx1 = %i\nx2 = %i\n\n', k, best_result, best_pair(1),best_pair(2));
                iterations = 0;
            end
            %fprintf('\nx_min = %i\nx_max = %i\ny_min = %i\ny_max = %i\n\n', x_min, x_max, y_min ,y_max);
            %fprintf('\nx1 = %i\nx2 = %i\n\n', best_pair(1), best_pair(2));
            [x_min, x_max, y_min, y_max] = CalculateNeighborhood(x_min, x_max, y_min, y_max, best_pair);
        end
        iterations = iterations + 1;
    end
    % fprintf('\nMinimalna vrednost funkcije je %i za parove\nx1 = %i\nx2 = %i\n\n',best_result, best_pair(1), best_pair(2));
    fprintf('\n Gotovo. Vrednost = %i za parove\nx1 = %i\nx2 = %i\n\n',best_result, best_pair(1), best_pair(2));
end % function

function [truth] = StopCondition(iterations, stop_iterations)
    if (iterations >= stop_iterations)
        truth = 1;
    else 
        truth = 0;
    end
end % function

function [best_result, best_pair] = RandomSolutionInNeighborhood(func, max_iteration, x_min, x_max, y_min, y_max)

    cost = 0;
    best_pair = [x_min; y_min];

    syms x1 x2;

    x1 = x_min;
    x2 = y_min;
    
    %fprintf('\nx_min = %i\nx_max = %i\ny_min = %i\ny_max = %i\n', x_min, x_max, y_min ,y_max);
    
    best_result = eval(func);
    
    %fprintf('\nx1 = %i\nx2 = %i\n', best_pair(1), best_pair(2));

    for i = 1 : max_iteration
        x1 = (x_max - x_min)*rand() + x_min;
        x2 = (y_max - y_min)*rand() + y_min;
        cost = eval(func);
        if(cost < best_result)
            best_result = cost;
            best_pair = [x1, x2];
            %fprintf('Minimum u iteraciji %d i iznosi %i\n', i, best_result);
        end
    end
    %fprintf('\nx1 = %i\nx2 = %i\n\n', best_pair(1), best_pair(2));

    %fprintf('\nMinimalna vrednost funkcije je %i za parove\nx1 = %i\nx2 = %i\n\n',best_result, best_pair(1), best_pair(2));
end % function

function [x_min, x_max, y_min, y_max] = CalculateNeighborhood(x_min_old, x_max_old, y_min_old, y_max_old, best_pair)
    x_min = (best_pair(1) - x_min_old)*rand() + x_min_old;
    x_max = (x_max_old - best_pair(1))*rand() + best_pair(1);
    
    y_min = (best_pair(2) - y_min_old)*rand() + y_min_old;
    y_max = (y_max_old - best_pair(2))*rand() + best_pair(2);
end %function

