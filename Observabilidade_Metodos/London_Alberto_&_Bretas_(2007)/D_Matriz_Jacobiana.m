function [H,H_t] = D_Matriz_Jacobiana(nb, nl, b, B, medidas, de, para, de_z, para_z, tipo)
%% Criação dinâmica das variáveis de estado 
O_simb = sym('O', [nb 1]); % Cria O1, O2, ... On
V_simb = sym('V', [nb 1]); % Cria V1, V2, ... Vn
O = [O_simb(1:end)]; 
V = V_simb;
vars = [O_simb(1:end)];

%% Equações de Potência do Ramos
P_flow = sym(zeros(nb, nb));

for i = 1:nl
    % k = linhas(i,1);
    % m = linhas(i,2);

    k = de(i);
    m = para(i);
    
    % fluxos de potência ativa
     P_flow(k,m) = (O(k)-O(m))*b(k,m);
     P_flow(m,k) = - P_flow(k,m);
end
        
% Injeções de Potência
Pinj = sym(zeros(nb, 1));

for k = 1:nb
    for m = 1:nb
        Pinj(k) = Pinj(k) + (O(k)-O(m))*B(k,m);
    end
end

%% Automatização de medidas
hx = sym([]); % Inicia hx simbólico vazio
for i = 1:size(medidas, 1)
    if tipo(i)==0 % Medida de Fluxo
        hx = [hx; P_flow(de_z(i), para_z(i))];
    elseif tipo(i)==2 % Medida de Injeção
        hx = [hx; Pinj(de_z(i))];
    elseif tipo(i)==3
        hx = [hx; V(de_z(i))]; 
    end
end
H = double(jacobian(hx, vars)); 
H_t = H';
end