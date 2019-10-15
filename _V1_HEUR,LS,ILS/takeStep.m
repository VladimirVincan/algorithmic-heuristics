function pair = takeStep(min_b, max_b, current_pair, step_size)
    
    pair = [0, 0];
    for i = 1 : length(current_pair)
        minimum = max(min_b, current_pair(i)-step_size);
        maximum = min(max_b, current_pair(i)+step_size);
        pair(i) = (maximum - minimum)*rand() + minimum;
    end
    
end