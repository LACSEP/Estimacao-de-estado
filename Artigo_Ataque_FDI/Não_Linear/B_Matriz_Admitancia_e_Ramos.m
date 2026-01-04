function [G, g, B, b] = B_Matriz_Admitancia_e_Ramos(nb, nl, linhas, de, para, shunt)
y = zeros(nb,nb);

for i=1:nl
    t = linhas(i,6);
    if(linhas(i,6) == 0) %para ramos sem transfomadores
    % Elementos série
    Y = -1/(linhas(i,3) + j*linhas(i,4));
    y(de(i), para(i)) =  Y;
    y(para(i), de(i)) =  Y;
  
    % Elementos próprios (diagonal)
    y(de(i), de(i)) = y(de(i), de(i)) - Y + j*(linhas(i,5)/2);
    y(para(i), para(i)) = y(para(i), para(i)) - Y + j*(linhas(i,5)/2);
   
    else %para ramos com transfomadores
    Y = -1/(linhas(i,3) + j*linhas(i,4));
    y(de(i), para(i)) =  Y/t;
    y(para(i), de(i)) =  Y/t;
    
    % Elementos próprios (diagonal)
    y(de(i), de(i)) = y(de(i), de(i)) - Y/t^2 + j*(linhas(i,5)/2);
    y(para(i), para(i)) = y(para(i), para(i)) - Y + j*(linhas(i,5)/2);    
    end
end

% com capacitor
for p = 1:nb
    
    if shunt(p) ~= 0
        y(p, p) = y(p, p) + j*shunt(p);
    end
end

G = real(y);
B = imag(y);

%% matriz para os ramos
ra = zeros(nb,nb);
for i = 1:nl
    Y2 = 1/(linhas(i,3) + j*linhas(i,4));
    ra(de(i), para(i)) =  Y2;
    ra(para(i), de(i)) =  Y2;
end
g = real(ra);
b = imag(ra);
end