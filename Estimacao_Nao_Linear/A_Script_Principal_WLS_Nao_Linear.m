% ------------------------------------- %
% Created by: Joao Pedro Lima Dantas    %
% email: jpldantas@usp.br               %
% ------------------------------------- %

%% Script Principal para o Estimador de Estados Não Linear Generalista 
tic;
clc; close all; clear

% Constantes:
e=0.00001; %Tolerância 

maxinter = 20; %Máximo de Interações

%% Dados de Entrada (Colocar Caminho da Pasta)

% ps: em dados_barras/dados_ramos/medicoes preencher caminho da pasta ou
% colocar a os dados na pasta: C_WLS_Não_Linear(Completo)

Caminho_barras='Dados_Barras_14';
Caminho_linhas='Dados_Ramos_14';
Caminho_medidas='Medições_14';

barras = xlsread(Caminho_barras);
linhas = xlsread(Caminho_linhas);
medidas = xlsread(Caminho_medidas); 

[nl, nb, de, para, shunt, de_z, para_z, tipo, z, Dp] = I_Leitura_Dados(barras, linhas, medidas);

%% Matriz de ponderação
W = diag(1 ./ (Dp.^2)); % Vetor de estados ponderado

%% Criação dinâmica das variáveis de estado (Generalizado)
% Criação com base no número de barras (nb)
O_simb = sym('O', [nb 1]); % Cria O1, O2, ... On
V_simb = sym('V', [nb 1]); % Cria V1, V2, ... Vn
vars = [O_simb(2:end); V_simb];

%% Chute Inicial: ângulos = 0, tensões = 1.0 p.u.
x0 = [zeros(nb-1, 1); ones(nb, 1)]; 
O = [0; O_simb(2:end)]; % Define O1 como referência (0 rad)
V = V_simb;

%% Matriz de Admitância Nodal 
[G, g, B, b] = B_Matriz_Admitancia_e_Ramos(nb, nl, linhas, de, para, shunt);

%% Equações de Potência do Ramos
[hx] = C_Equacoes_Potencia_Agrupadas(nb, nl, linhas, de_z, para_z, g, b, G, B, V, O, medidas, tipo);

%% Algoritmo Para a Implementação do Estimador WLS Não Linear
[x0, hxo, Hxo, Gxo] = D_Solve_WLS_Nao_Linear(hx, vars, W, z, x0, e, maxinter, nb);

%% Erro normalizado 
[rn] = E_Erro_Normalizado(z, hxo, W, Hxo, Gxo);

%% Índice UI
%[UI] = F_Indice_UI(Hxo, W, z);
%[UI, ei, Wi] = G_Indice_UI_estimativa_do_erro_composto(Hxo, W, z, rn, Dp);

%% Eliminação de Medidas
[rn] = H_Eliminacao_Medidas_teste(rn, nb, medidas, z, Dp, hx, vars, e, maxinter);

%[rn] = H_Eliminacao_Medidas2_teste(rn, nb, medidas, z, Dp, hx, vars, e, maxinter);

%%
tempo_total = toc; 
fprintf('O tempo de simulação foi de %.4f segundos.\n', tempo_total);
