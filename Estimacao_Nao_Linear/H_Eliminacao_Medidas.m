function [rn] = H_Eliminacao_Medidas(rn, nb, medidas, z, Dp, hx, vars, e, maxinter)

rn_novo=rn;
x0 = [zeros(nb-1, 1); ones(nb, 1)]; 

while max(abs(rn_novo))>3
    Eli = find(rn_novo == max(abs(rn_novo)));
    fprintf('  Medida a Ser Eliminada: %2d\n', Eli);
    medidas(Eli) = [];
    z(Eli) = [];
    Dp(Eli) = [];
    hx(Eli) = [];
    W = diag(1 ./ (Dp.^2)); % Vetor de estados ponderado
 [x0, hxo, Hxo, Gxo] = D_Solve_WLS_Nao_Linear(hx, vars, W, z, x0, e, maxinter, nb);
 [rn] = E_Erro_Normalizado(z, hxo, W, Hxo, Gxo);
 rn_novo=rn;
 if max(abs(rn_novo))<3
    disp('Nenhuma Medida Precisa Ser Mais Eliminada');
 end
end

