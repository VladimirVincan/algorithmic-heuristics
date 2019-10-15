function cost = getCost(func, pair)
    syms x1 x2
    
    x1 = pair(1);
    x2 = pair(2);
    cost = eval(func);
    
end