function [rn_novo] = G_Eliminacao_Medidas(rn, nb, medidas, z, Dp, hx)
rn_novo=rn;

while max(abs(rn_novo))>3
    Eli = find(rn_novo == max(abs(rn_novo)));
    fprintf('  Medida a Ser Eliminada: %2d\n', Eli);
    medidas(Eli) = [];
    z(Eli) = [];
    Dp(Eli) = [];
    hx(Eli) = [];
    W = diag(1 ./ (Dp.^2)); % Vetor de estados ponderado
    [x0, H, G] = E_Solve_WLS(nb, hx, z, W);
    [rn] = F_Erro_Normalizado(z, W, x0, H, G);
rn_novo=rn;
 if max(abs(rn_novo))<3
    disp('Nenhuma Medida Precisa Ser Mais Eliminada');
end
end
