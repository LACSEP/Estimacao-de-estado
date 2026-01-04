function [hx] = D_Equacoes_Potencia_Agrupadas(nb, nl, b, B, medidas, de, para, de_z, para_z, tipo)
%% Equações de Potência do Ramos
O_simb = sym('O', [nb 1]);
O = [0; O_simb(2:end)]; 

for i = 1:nl
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
    end
end
end
