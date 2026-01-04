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
medidas = readmatrix('Medições_14.xlsx'); 

%% Leitura do Dados de Barras e Linhas
[nl, nb, de, para, de_z, para_z, tipo, z, Dp] = B_Leitura_Dados(barras, linhas, medidas);

%% Matriz de ponderação
W = diag(1 ./ (Dp.^2)); % Vetor de estados ponderado

%% Matriz de Admitância Nodal 
[B,b] = C_Matrizes_adm_ramos(nb, nl, linhas, de, para);

%% Equações de Potência do Ramos
[hx] = D_Equacoes_Potencia_Agrupadas(nb, nl, b, B, medidas, de, para, de_z, para_z, tipo);

%% Algoritmo Para a Implementação do Estimador WLS Linear
[x0, H, G] = E_Solve_WLS(nb, hx, z, W);

%% Erro e Erro normalizado 
[rn] = F_Erro_Normalizado(z, W, x0, H, G);

%% Eliminação de medidas  
[rn_novo] = G_Eliminacao_Medidas(rn, nb, medidas, z, Dp, hx);

%% Tempo Total
tempo_total = toc; 
fprintf('O tempo de simulação foi de %.4f segundos.\n', tempo_total);
