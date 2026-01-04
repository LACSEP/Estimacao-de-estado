function [x01, H, G] = E_Solve_WLS(nb, hx, z, W)
%% Equações de Potência do Ramos
O_simb = sym('O', [nb 1]);
vars = [O_simb(2:end)];

H = double(jacobian(hx, vars)); 
G = H'*W*H;
x0 = G\(H'*W*z);

%% valores Dos Ângulos

    % fprintf('Ângulos de todas as barras:\n');
    % fprintf(' O1 = %.6f rad (Referência)\n', 0.0);
    % for i = 1:(nb-1)
    %     %fprintf(' O%d = %.6f rad \n', i+1, x0(i));
    %     fprintf(' O%d = %.6f rad (%.6f graus)\n', i+1, x0(i), rad2deg(x0(i)));
    % end  
    x01 = x0;
end