function [nl, nb, de, para, de_z, para_z, tipo, z, Dp] = B_Leitura_Dados(barras, linhas, medidas)
%% Leitura do Dados de Barras e Linhas
nl=size(linhas,1);
nb=size(barras,1);
de = linhas(:,1);
para = linhas(:,2);

%% Leitura dos Dados das Medições
de_z = medidas(:,1);
para_z = medidas(:,2);             
tipo = medidas(:,4);
z = medidas(:,3);
Dp = medidas(:,5);
end
