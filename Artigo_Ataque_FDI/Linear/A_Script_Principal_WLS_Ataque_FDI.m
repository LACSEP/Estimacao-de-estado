% ------------------------------------- %
% Created by: Joao Pedro Lima Dantas    %
% email: jpldantas@usp.br               %
% ------------------------------------- %

%% Código para o Estimador de Estados Linear Generalista
tic;
clc; close all; clear

%% Dados de Entrada
barras = readmatrix('Dados_Barras_14.xlsx');
linhas = readmatrix('Dados_Ramos_14.xlsx');
medidas = readmatrix('Medições_14a.xlsx'); 

%% Leitura do Dados de Barras e Linhas
[nl, nb, de, para, de_z, para_z, tipo, z, Dp] = B_Leitura_Dados(barras, linhas, medidas);

%% Matriz de ponderação
W = diag(1 ./ (Dp.^2)); % Vetor de estados ponderado

%% Matriz de Admitância Nodal 
[B,b] = C_Matrizes_adm_ramos(nb, nl, linhas, de, para);

%% Equações de Potência do Ramos
[hx] = D_Equacoes_Potencia_Agrupadas(nb, nl, b, B, medidas, de, para, de_z, para_z, tipo);

%% Algoritmo Para a Implementação do Estimador WLS Linear
[x01, H1, G1] = E_Solve_WLS(nb, hx, z, W);

%% Erro e Erro normalizado 
[rn] = F_Erro_Normalizado(z, W, x01, H1, G1);
[UI, ei, Wi] = K_Indice_UI_estimativa_do_erro_composto(H1, W, z, rn, Dp);

%% Ataque FDI - Linear

[rn1, x02, za,a] = I_Ataque_FDI(nb,H1,z, W,G1,x01);
[UI2, ei2, Wi2] = K_Indice_UI_estimativa_do_erro_composto(H1, W, za, rn1, Dp);
%% Eliminação de medidas  
%[rn] = G_Eliminacao_Medidas(rn, nb, medidas, z, Dp, hx);

%% Plotagem Detalhada: Ângulos, Tensões e Resíduos (Corrigido)
J_Plot_FDI(x01, x02, rn, rn1, UI, UI2, ei, ei2, nb);
%% Tempo Total

%% --- EXPORTAÇÃO COMPLETA PARA PYTHON ---

% 1. Exportação das Métricas (Medidas)
% Garante que sejam vetores coluna
rn = rn(:); rn1 = rn1(:);
ei = ei(:); ei2 = ei2(:);
UI = UI(:); UI2 = UI2(:);

T_metricas = table(rn, rn1, ei, ei2, UI, UI2);
writetable(T_metricas, 'dados_metricas.csv');

% 2. Exportação dos Estados (Ângulos)
% Garante que sejam vetores coluna
x01 = x01(:); 
x02 = x02(:);

T_estados = table(x01, x02);
writetable(T_estados, 'dados_estados.csv');

fprintf('Exportação concluída com sucesso!\n');
fprintf('Arquivos gerados: "dados_metricas.csv" e "dados_estados.csv"\n');

tempo_total = toc; 
fprintf('O tempo de simulação foi de %.4f segundos.\n', tempo_total);
