function [id_medida_original] = F_Observabilidade(H_t_f, ordem_final,nb)
%% Verificação de observabilidade e Medida Critica
id_medida_original = []; 
fprintf('\n  ANÁLISE DE OBSERVABILIDADE  \n');
aux = nb-1;
H_t_f2 = H_t_f(1:aux,1:aux);
diag_principal = diag(H_t_f2);

if any(diag_principal == 0)
    disp('-> Sistema Não Observável');
else
    disp('-> Sistema Observável');
    fprintf('   ----------------------------------------\n');
%% Medidas Críticas

fprintf('\n  ANÁLISE DE MEDIDAS CRÍTICAS  \n');

% Matriz apenas com os dados 
matriz_analise = H_t_f; 
tolerancia = 1e-10; 

[num_linhas, num_colunas] = size(matriz_analise);
medidas_criticas_encontradas = false;

% Itera sobre cada linha da matriz fatorada
for i = 1:num_linhas
    cols_nao_nulas = find(abs(matriz_analise(i, :)) > tolerancia);
    
    if length(cols_nao_nulas) == 1
        coluna_critica = cols_nao_nulas; % Índice da coluna onde está o elemento
        
        % Busca qual é a medida original usando o vetor ordem_final
        id_medida_original = ordem_final(coluna_critica);
        
        fprintf('-> Linha %d possui pivô único na coluna %d.\n', i, coluna_critica);
        fprintf('   IDENTIFICADA MEDIDA CRÍTICA: Medida nº %d\n', id_medida_original);
        fprintf('   ----------------------------------------\n');
        
        medidas_criticas_encontradas = true;
    end
end

if ~medidas_criticas_encontradas
    disp('Nenhuma medida crítica encontrada (todas as linhas possuem redundância).');
end
end
fprintf('   ----------------------------------------\n');
end