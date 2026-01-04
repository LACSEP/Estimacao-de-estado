function [B,b] = C_Matrizes_adm_ramos(nb,nl,linhas,de, para)
%% Matriz de Admitância Nodal 
B = zeros(nb,nb);
for i=1:nl
    % Elementos série
    aux = 1/linhas(i,4);
    B(de(i), para(i)) =  aux;
    B(para(i), de(i)) =  aux;
 
    % Elementos próprios (diagonal)
    B(de(i), de(i)) = B(de(i), de(i)) - aux;
    B(para(i), para(i)) = B(para(i), para(i)) - aux; 
end

%% matriz dos ramos
b = zeros(nb,nb);
for i = 1:nl
    aux2 = 1/linhas(i,4);
    b(de(i), para(i)) =  aux2;
    b(para(i), de(i)) =  aux2;
end
end