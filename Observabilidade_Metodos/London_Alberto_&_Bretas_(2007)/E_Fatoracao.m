function [H_t_f, ordem_final] = E_Fatoracao(H_t, nb, nm)
%% Rotina Para Fatoração LU Com Permutação de Linhas e Colunas
    G = H_t;
    ordem_colunas = 1:nm; %
    
    % 1ª Etapa: FORWARD 
    for k = 1:(nb-1) % Itera sobre os pivôs
        
        % --- INÍCIO: LÓGICA DE RECUPERAÇÃO ---
        % Se o pivô G(k,k) for nulo, tenta recuperar...
        if abs(G(k,k)) < 1e-10 
            
            %fprintf('Medida %d nao observavel (pivô nulo), tentando recuperar...\n', k);
            pivo_encontrado = false;
            
            % Procura por um substituto da coluna k em diante
            % (Lógica do loop 'j' do código 1)
            for j = k:nm 
                if j > size(G, 2) 
                    break; 
                end
                
                % Se achar um elemento G(k,j) não nulo...
                if abs(G(k,j)) > 1e-10
                    %fprintf('Removendo medida na coluna %d para tentar recuperar observabilidade da medida %d\n', j, k);
                    
                    % --- Lógica de Reorganização de Colunas (exata do Código 1) ---
                    % Pega os dados e o índice da coluna 'j'
                    col_data_to_move = G(:, j);
                    col_idx_to_move = ordem_colunas(j);

                    % Remove a coluna 'j' da matriz e do vetor de ordem
                    G(:, j) = []; 
                    ordem_colunas(j) = [];

                    % Insere os dados e o índice na posição 'k'
                    G = [G(:, 1:k-1), col_data_to_move, G(:, k:end)];
                    ordem_colunas = [ordem_colunas(1:k-1), col_idx_to_move, ordem_colunas(k:end)];
                    % --- Fim da Lógica de Reorganização ---
                    
                    pivo_encontrado = true;
                    break; % Sai do loop 'j'
                end
            end
            
            if ~pivo_encontrado
                % Se não achou substituto, avisa e pula a etapa de eliminação
                warning('Recuperação falhou para a linha %d. A matriz pode ser singular.', k);
                continue; % Pula para a próxima iteração do 'k'
            end
        end
        % --- FIM: LÓGICA DE RECUPERAÇÃO ---
        
        % Processo de eliminação 
        % (só é executado se G(k,k) for ou se tornou não-nulo)
        if abs(G(k,k)) > 1e-10 
            for i = (k+1):nb % Itera sobre as linhas abaixo do pivô
                fator = G(i,k) / G(k,k);
                G(i,:) = G(i,:) - fator * G(k,:);
            end
        end
    end
    
    % 2ª Etapa: OPERAÇÃO DIAGONAL 
    for i = 1:(nb-1)
        if abs(G(i,i)) > 1e-10
            G(i,:) = G(i,:) / G(i,i);
        end
    end
    
    % 3ª Etapa: BACKWARD 
    for k = (nb-1):-1:2
        for i = (k-1):-1:1
            fator = G(i,k);
            G(i,:) = G(i,:) - fator * G(k,:);
        end
    end
    
    H_t_f = G;
    ordem_final = ordem_colunas;
end