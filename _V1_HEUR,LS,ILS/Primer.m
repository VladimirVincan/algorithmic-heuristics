function func = Primer(n)
syms x1 x2

switch(n)
    case(1)
        fprintf('Funkcija "griewank"\n');
        fprintf('(x1.^2 + x2.^2)/200 - cos(x1).*cos(x2/sqrt(2)) + 1\n');
        [dims, lb, ub, sol, fval_sol] = griewank;
        fprintf('Globalni optimum je %d za vrednosti\n', fval_sol);
        fprintf('%d ', sol);
        fprintf('\n\n');
        func  = (x1.^2 + x2.^2)/200 - cos(x1).*cos(x2/sqrt(2)) + 1;
        ezimage(@griewank);
        
    case(2)
        fprintf('Funkcija "modschaffer1"\n');
        fprintf('0.5  + (sin(x1.^2 + x2.^2).^2 - 0.5) ./ (1+0.001*x1.^2 + x2.^2).^2\n');
        [dims, lb, ub, sol, fval_sol] = modschaffer1;
        fprintf('Globalni optimum je %d za vrednosti\n', fval_sol);
        fprintf('%d ', sol);
        fprintf('\n\n');
        func  = 0.5  + (sin(x1.^2 + x2.^2).^2 - 0.5) ./ (1+0.001*x1.^2 + x2.^2).^2;
        ezimage(@modschaffer1);
        
    case(3)
        fprintf('Funkcija "himmelblau"\n');
        fprintf('(x1.^2 + x2 - 11).^2 + (x1 + x2.^2 - 7).^2\n');
        [dims, lb, ub, sol, fval_sol] = himmelblau;
        fprintf('Globalni optimum je %d za vrednosti\n', fval_sol);
        fprintf('%d ', sol);
        fprintf('\n\n');
        func  = (x1.^2 + x2 - 11).^2 + (x1 + x2.^2 - 7).^2;
        ezimage(@himmelblau);
        
    case(4)
        fprintf('Funkcija "levi13"\n');
        fprintf('sin(3*pi*x1).^2 + (x1-1).^2.*(1 + sin(3*pi*x2).^2) + (x2-1).^2.*(1 + sin(2*pi*x2).^2)\n');
        [dims, lb, ub, sol, fval_sol] = levi13;
        fprintf('Globalni optimum je %d za vrednosti\n', fval_sol);
        fprintf('%d ', sol);
        fprintf('\n\n');
        func  = sin(3*pi*x1).^2 + (x1-1).^2.*(1 + sin(3*pi*x2).^2) + (x2-1).^2.*(1 + sin(2*pi*x2).^2);
        ezimage(@levi13);
        
    case(5)
        fprintf('Funkcija "holdertable"\n');
        fprintf('-abs(sin(x1).*cos(x2).*exp(abs(1 - sqrt(x1.^2 + x2.^2)/pi)))\n');
        [dims, lb, ub, sol, fval_sol] = holdertable;
        fprintf('Globalni optimum je %d za vrednosti\n', fval_sol);
        fprintf('%d ', sol);
        fprintf('\n\n');
        func  = -abs(sin(x1).*cos(x2).*exp(abs(1 - sqrt(x1.^2 + x2.^2)/pi)));
        ezimage(@holdertable);
        
    case(6)
        fprintf('Funkcija "penholder"\n');
        fprintf('-exp(-(abs(cos(x1).*cos(x2).*exp(abs(1 - sqrt(x1.^2 + x2.^2)/pi)))).^(-1))\n');
        [dims, lb, ub, sol, fval_sol] = penholder;
        fprintf('Globalni optimum je %d za vrednosti\n', fval_sol);
        fprintf('%d ', sol);
        fprintf('\n\n');
        func  = -exp(-(abs(cos(x1).*cos(x2).*exp(abs(1 - sqrt(x1.^2 + x2.^2)/pi)))).^(-1));
        ezimage(@penholder);
        
    case(7)
        fprintf('Funkcija "schweffel"\n');
        fprintf('-x1.*sin(sqrt(abs(x1))) -x2.*sin(sqrt(abs(x2)))\n');
        [dims, lb, ub, sol, fval_sol] = schweffel;
        fprintf('Globalni optimum je %d za vrednosti\n', fval_sol);
        fprintf('%d ', sol);
        fprintf('\n\n');
        func  = -x1.*sin(sqrt(abs(x1))) -x2.*sin(sqrt(abs(x2)));
        ezimage(@schweffel);
        
    case(8)
        fprintf('Funkcija "leon"\n');
        fprintf('100*(x2 - x1.^3).^2 + (1 - x1).^2\n');
        [dims, lb, ub, sol, fval_sol] = leon;
        fprintf('Globalni optimum je %d za vrednosti\n', fval_sol);
        fprintf('%d ', sol);
        fprintf('\n\n');
        func  = 100*(x2 - x1.^3).^2 + (1 - x1).^2;
        ezimage(@leon);
        
    case(9)
        fprintf('Funkcija "modschaffer4"\n');
        fprintf('0.5  + (cos(sin(abs(x1.^2 - x2.^2))).^2 - 0.5) ./ (1+0.001*(x1.^2 + x2.^2)).^2\n');
        [dims, lb, ub, sol, fval_sol] = modschaffer4;
        fprintf('Globalni optimum je %d za vrednosti\n', fval_sol);
        fprintf('%d ', sol);
        fprintf('\n\n');
        func  = 0.5  + (cos(sin(abs(x1.^2 - x2.^2))).^2 - 0.5) ./ (1+0.001*(x1.^2 + x2.^2)).^2;
        ezimage(@modschaffer4);
        
    case(10)
        fprintf('Funkcija "rastrigin"\n');
        fprintf('x1.^2 + x2.^2 - 10*cos(2*pi*x1) - 10*cos(2*pi*x2) + 20\n');
        [dims, lb, ub, sol, fval_sol] = rastrigin;
        fprintf('Globalni optimum je %d za vrednosti\n', fval_sol);
        fprintf('%d ', sol);
        fprintf('\n\n');
        func  = x1.^2 + x2.^2 - 10*cos(2*pi*x1) - 10*cos(2*pi*x2) + 20;
        ezimage(@rastrigin);
        
    case(11)
        fprintf('Funkcija "testtubeholder"\n');
        fprintf('-4*abs(sin(x1).*cos(x2).*exp(abs(cos((x1.^2 + x2.^2)/200))))\n');
        [dims, lb, ub, sol, fval_sol] = testtubeholder;
        fprintf('Globalni optimum je %d za vrednosti\n', fval_sol);
        fprintf('%d ', sol);
        fprintf('\n\n');
        func  = -4*abs(sin(x1).*cos(x2).*exp(abs(cos((x1.^2 + x2.^2)/200))));
        ezimage(@testtubeholder);
end