function [hx] = C_Equacoes_Potencia_Agrupadas(nb, nl, linhas, de_z, para_z, g, b, G, B, V, O, medidas, tipo)

%% Fluxos de Potência
P_flow = sym(zeros(nb, nb));
Q_flow = sym(zeros(nb, nb));

for i = 1:nl
    k = linhas(i,1);
    m = linhas(i,2);
    b_shunt_meio = linhas(i,5)/2; %possui shunt
    a = 1/linhas(i,6);
    
if linhas(i,6)==0
    % fluxos de potência ativa
     P_flow(k,m) = (V(k))^2*g(k,m) - V(k)*V(m)*(g(k,m)*cos(O(k)-O(m)) + b(k,m)*sin(O(k)-O(m)));
     P_flow(m,k) = (V(m))^2*g(k,m) - V(m)*V(k)*(g(k,m)*cos(O(m)-O(k)) + b(k,m)*sin(O(m)-O(k)));

    % fluxos de potência reativa
     Q_flow(k,m) = -(V(k))^2*(b(k,m)+b_shunt_meio) - V(k)*V(m)*(g(k,m)*sin(O(k)-O(m)) - b(k,m)*cos(O(k)-O(m)));
     Q_flow(m,k) = -(V(m))^2*(b(k,m)+b_shunt_meio) - V(m)*V(k)*(g(k,m)*sin(O(m)-O(k)) - b(k,m)*cos(O(m)-O(k)));
else
    % fluxos de potência ativa
     P_flow(k,m) = (a^2)*(V(k))^2*g(k,m) - (a)*V(k)*V(m)*(g(k,m)*cos(O(k)-O(m)) + b(k,m)*sin(O(k)-O(m)));
     P_flow(m,k) = (V(m))^2*g(k,m) - (a)*V(m)*V(k)*(g(k,m)*cos(O(m)-O(k)) + b(k,m)*sin(O(m)-O(k)));

    % fluxos de potência reativa
     Q_flow(k,m) = -(a^2)*(V(k))^2*(b(k,m)+b_shunt_meio) - (a)*V(k)*V(m)*(g(k,m)*sin(O(k)-O(m)) - b(k,m)*cos(O(k)-O(m)));
     Q_flow(m,k) = -(V(m))^2*(b(k,m)+b_shunt_meio) - (a)*V(m)*V(k)*(g(k,m)*sin(O(m)-O(k)) - b(k,m)*cos(O(m)-O(k)));
end
end
        
% Injeções de Potência
Pinj = sym(zeros(nb, 1));
Qinj = sym(zeros(nb, 1));
for k = 1:nb
    for m = 1:nb
        Pinj(k) = Pinj(k) + V(k)*V(m)*(G(k,m)*cos(O(k)-O(m)) + B(k,m)*sin(O(k)-O(m)));
        Qinj(k) = Qinj(k) + V(k)*V(m)*(G(k,m)*sin(O(k)-O(m)) - B(k,m)*cos(O(k)-O(m)));
    end
end
%% agrupamento de medidas
hx = sym([]); % Inicia hx simbólico vazio
for i = 1:size(medidas, 1)
    if tipo(i)==0
        hx = [hx; P_flow(de_z(i), para_z(i))];
    elseif tipo(i)==1  
        hx= [hx; Q_flow(de_z(i), para_z(i))];       
    elseif tipo(i)==2
        hx = [hx; Pinj(de_z(i))];
    elseif  tipo(i)==3
        hx = [hx; Qinj(de_z(i))]; 
    elseif tipo(i)==4
        hx = [hx; V(de_z(i))];
    end
end
end