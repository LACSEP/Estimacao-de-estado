% ------------------------------------- %
% Created by: Joao Pedro Lima Dantas    %
% email: jpldantas@usp.br               %
% ------------------------------------- %

%% Observabilidade pelo Metódo da Matriz Hdelta (London Jr 2007)
tic;
clc; close all; clear 

%% Dados de Entrada

% ps: em dados_barras/dados_ramos/medicoes preencher caminh da pasta ou
% colocar a os dados na pasta: D_Matriz_H_delta.

dados_barras = 'Dados_Barras_14.xlsx';
dados_ramos = 'Dados_Ramos_14.xlsx';
medicoes = 'Medições_14_2.xlsx';

barras = xlsread(dados_barras);
linhas = xlsread(dados_ramos);
medidas = xlsread(medicoes); 

[nl, nb, nm, de, para, de_z, para_z, tipo, z, Dp] = B_Leitura_Dados(barras, linhas, medidas);

%% Matriz de ponderação
W = diag(1 ./ (Dp.^2)); 

%% Matriz de Admitância Nodal 
[B,b] = C_Matrizes_adm_ramos(nb,nl,linhas,de, para);

%% Matriz de Jacobiana
[H,H_t] = D_Matriz_Jacobiana(nb, nl, B, b, medidas, de, para, de_z, para_z, tipo);

%% Fatoração
[H_t_f, ordem_final] = E_Fatoracao(H_t,nb,nm);

%% Verificação de observabilidade e Medida Critica
[id_medida_original] = F_Observabilidade(H_t_f, ordem_final,nb);

%teste
%[id_medida_original] = F_Observabilidade2(H_t_f, ordem_final);

%% Saída em Imagem
[h] = G_Figure(H_t_f, ordem_final);
               
%% Tempo Total
tempo_total = toc; 
fprintf('\nO tempo de simulação foi de %.4f segundos.\n', tempo_total);
