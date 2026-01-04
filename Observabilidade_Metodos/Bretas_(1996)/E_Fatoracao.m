function [G_fat] = E_Fatoracao(G,nb)
% implemenetação da fatoração LU
G_fat = G;
    % Etapa Forward (Eliminação Gaussiana)
    for i = 1:nb
        for j = 1:nb
            if j ~= i && j < i && G_fat(j, j) ~= 0
                F = -G_fat(i, j) / G_fat(j, j);
                G_fat(i, :) = F * G_fat(j, :) + G_fat(i, :);
            end
        end
    end

    % Etapa de Diagonalização (Normalização)
    for i = 1:nb
        if G_fat(i, i) > 1e-5
            D = 1 / G_fat(i, i);
            G_fat(i, :) = D * G_fat(i, :);
        end
    end

    %disp('Matriz G fatorada (para teste de observabilidade):');
    %disp(G_fat);
end


