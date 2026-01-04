function [x01, hxo, Hxo, Gxo, hx_func, Hx_func] = D_Solve_WLS_Nao_Linear(hx, vars, W, z, x0, e, maxinter, nb)
Hx = jacobian(hx, vars); 
%Gx = (Hx)'*W*Hx;
hx_func = matlabFunction(hx, 'Vars', {vars}); 
Hx_func = matlabFunction(Hx,'Vars', {vars}); 
%Gx_func = matlabFunction(Gx,'Vars', {vars}); 
erro = inf;
inter = 0;
while erro >= e 
    hxo = hx_func(x0);
    Hxo = Hx_func(x0);
    %Gxo = Gx_func(x0);
    Gxo = (Hxo)'*W*Hxo;
    deltax = Gxo\((Hxo')*W*(z-hxo));
    x1 = x0 + deltax; 
    erro = norm(deltax, 2);
    if inter > maxinter
    fprintf(' Numero maximo de iterações excedido \n');
    return;
    
    end
    x0=x1;   
inter=inter+1;
end
x01 = x0;
%% talvez retirar
hxo = hx_func(x0);
Hxo = Hx_func(x0);
Gxo = (Hxo)'*W*Hxo;
%Gxo = Gx_func(x0);
    %% valores finais 
    % fprintf('\nInteração %d\n', inter);   
    % fprintf('Ângulos de todas as barras:\n');
    % fprintf(' O1 = %.6f rad (Referência)\n', 0.0);
    % for i = 1:(nb-1)
    %     %fprintf(' O%d = %.6f rad \n', i+1, x0(i));
    %     fprintf(' O%d = %.6f rad (%.6f graus)\n', i+1, x0(i), rad2deg(x0(i)));
    % end
    
    % fprintf('Tensões de todas as barras:\n');
    % for i = 1:nb
    %     % O valor da tensão i está na posição (nb-1) + i do vetor x0
    %     fprintf(' V%d = %.6f pu \n', i, x0(nb-1 + i));
    % end
end