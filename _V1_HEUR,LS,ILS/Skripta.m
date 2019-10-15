% griewank, modschaffer1 (adaptivni se zaglavi, a kombinovani uspe da nadje bolje)
% himelblau, levi13 (oba dobro rade, samo je kombinovani uspeo da nadje resenje 0)
% holdertable, penholder, schweffel (ne mogu da nadju resenja ni jedan ni drugi)
% leon, modshaffer4, rastrigin, testtubeholder (oba nadju resenje)

clear all
clc

n = 0;
min_b = -5;
max_b = 5;

fprintf('Izaberite funkciju:\n1) griewank\n2) modschaffer1\n3) himelblau\n4) levi13\n');
fprintf('5) holdertable\n6) penholder\n7) schweffel\n8) leon\n9) modshaffer4\n10) rastrigin\n11) testtubeholder\n');

while (n < 1 | n > 11)
    n = input('n = ');
end
fprintf('\n');

func = Primer(n);

n = 0;
fprintf('Izaberite algoritam\n1) Random search algorithm\n2) Adaptive random search algorithm\n3) 1 i 2 kombinovano\n');
while (n < 1 | n > 3)
    n = input('n = ');
end
fprintf('\n');

switch(n)
    case 1
        [best_result, best_pair] = RandomSearchAlgorithm(func, min_b, max_b);
    case 2
        x1 = (max_b - min_b)*rand() + min_b;
        x2 = (max_b - min_b)*rand() + min_b;
        best_result = eval(func);
        best_pair = [x1, x2];
        AdaptiveRandomSearch(func, min_b, max_b, best_result, best_pair);
    case 3
        [best_result, best_pair] = RandomSearchAlgorithm(func, min_b, max_b);
        AdaptiveRandomSearch(func, min_b, max_b, best_result, best_pair);
end