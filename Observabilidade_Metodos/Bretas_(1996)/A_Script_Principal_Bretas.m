% ------------------------------------- %
% Created by: Joao Pedro Lima Dantas    %
% email: jpldantas@usp.br               %
% ------------------------------------- %

%% Código pelo Método do Bretas 
tic;
clc; close all; clear
format short

%% Dados de Entrada
barras = xlsread('Dados_Barras_14.xlsx');
linhas = xlsread('Dados_Ramos_14.xlsx');
medidas = xlsread('Medições_14.xlsx'); 

[nl, nb, nm, de, para, de_z, para_z, tipo, z, Dp] = B_Leitura_Dados(barras, linhas, medidas);

%% Matriz de ponderação
W = diag(1 ./ (Dp.^2)); % Vetor de estados ponderado

%% Matriz de Admitância Nodal 
[B,b] = C_Matrizes_adm_ramos(nb,nl,linhas,de, para);

%% Matriz de Jacobiana
[H,G] = D_Matriz_Jacobiana(nb, nl, b, B, W, medidas, de, para, de_z, para_z, tipo);

%% Fatoração
[G_fat] = E_Fatoracao(G,nb);

%Se ha mais de um caminho de fatoraçao e medida de injeçao que ligam nós de 
%diferentes caminhos, entao remove-se essa medida e faz o processo de novo

%% Saída em Imagem
[h] = F_Figure(G_fat);

%% Tempo Total
tempo_total = toc; 
fprintf('\nO tempo de simulação foi de %.4f segundos.\n', tempo_total);
