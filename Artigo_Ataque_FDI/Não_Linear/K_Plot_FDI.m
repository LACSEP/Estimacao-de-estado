function K_Plot_FDI(x01, x02, rn, rn1, UI, UI2, ei, ei2, nb)
    %% --- CONFIGURAÇÕES GERAIS DE ESTILO ---
    cBlue = [0.1216 0.4667 0.7059]; 
    cRed  = [0.8500 0.3250 0.0980]; 
    fontMain = 12; 
    fontTitle = 14; 
    
    %% --- FIGURE 1: ESTADOS ---
    figure('Name', 'Detalhamento dos Estados', 'Color', 'w', 'Position', [100, 50, 600, 1000]); % Mais alto
    idx_ang = 1:(nb-1); 
    idx_vol = nb:(2*nb-1);
    
   %% --- Subplot 1: Ângulos ---
    subplot(2,1,1);
    hB1 = bar([x01(idx_ang), x02(idx_ang)], 'grouped');
    
    set(hB1(1), 'FaceColor', cBlue, 'EdgeColor', 'k', 'DisplayName', 'Base (Sem Ataque)');
    set(hB1(2), 'FaceColor', cRed,  'EdgeColor', 'k', 'DisplayName', 'Sob Ataque');
    legend('show', 'Location', 'best', 'Interpreter', 'latex', 'FontSize', 10);
    
    title('\textbf{Estados: \^Angulos de Tens\~ao ($\theta$)}', 'Interpreter', 'latex', 'FontSize', fontTitle);
    ylabel('\textbf{Radianos}', 'Interpreter', 'latex', 'FontSize', fontMain);
    xlabel('\textbf{Barras}', 'Interpreter', 'latex', 'FontSize', fontMain);
    xticks(1:length(idx_ang));
    xticklabels(string(2:nb)); 
    
    yl = ylim; 
    yticks(yl(1) : 0.05 : yl(2)); 
    grid on; box on;
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 11);
    
   %% --- Subplot 2: Magnitudes ---
    subplot(2,1,2);
    hB2 = bar([x01(idx_vol), x02(idx_vol)], 'grouped');
    set(hB2(1), 'FaceColor', cBlue, 'EdgeColor', 'k', 'DisplayName', 'Base (Sem Ataque)');
    set(hB2(2), 'FaceColor', cRed,  'EdgeColor', 'k', 'DisplayName', 'Sob Ataque');
    
    title('\textbf{Estados: Magnitudes de Tens\~ao ($V$)}', 'Interpreter', 'latex', 'FontSize', fontTitle);
    ylabel('\textbf{Magnitude (p.u.)}', 'Interpreter', 'latex', 'FontSize', fontMain);
    xlabel('\textbf{Barras}', 'Interpreter', 'latex', 'FontSize', fontMain);
    xticks(1:nb);
    ylim([0.90 1.15]); 
    yticks(0.90 : 0.025 : 1.15);
    
    grid on; box on;
    legend('show', 'Location', 'best', 'Interpreter', 'latex', 'FontSize', 10);
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 11);

    %% --- FIGURE 2: RESÍDUOS (A QUE VOCÊ QUERIA ARRUMAR) ---
    % ALTERAÇÃO 1: Position [x, y, 600, 1300]. 
    % Aumentei a altura para 1300 e reduzi a largura para 600. Isso "desachata" os gráficos.
    figure('Name', 'Analise de Residuos', 'Color', 'w', 'Position', [950, 50, 600, 1300]);
    
    % --- Subplot 1: Resíduos Normalizados ---
    subplot(3, 1, 1); 
    hold on; grid on; box on;
    p1 = plot(rn, '-o', 'Color', cBlue, 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', cBlue, 'DisplayName', 'Base (Sem Ataque)');
    p2 = plot(rn1, '--x', 'Color', 'r', 'LineWidth', 1.5, 'MarkerSize', 7, 'DisplayName', 'Sob Ataque');
    
    ylim([0 5]); 
    % ALTERAÇÃO 2: Eixo X travado para remover espaços laterais
    xlim([1 length(rn)]);
    
    yline(3.0, ':k', 'Label', 'Limiar (3.0)', 'LineWidth', 1.5, 'LabelVerticalAlignment', 'bottom', 'Interpreter', 'latex', 'HandleVisibility', 'off'); 
    title('\textbf{Compara\c{c}\~{a}o Entre Res\''iduos Normalizados}', 'Interpreter', 'latex', 'FontSize', fontTitle);
    ylabel('\textbf{Res\''iduo Norm.}', 'Interpreter', 'latex', 'FontSize', fontMain);
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 11);
    
    % --- Subplot 2: b chapeu ---
    subplot(3, 1, 2); 
    hold on; grid on; box on;
    plot(ei, '-o', 'Color', cBlue, 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', cBlue, 'HandleVisibility', 'off');
    plot(ei2, '--x', 'Color', 'r', 'LineWidth', 1.5, 'MarkerSize', 7, 'HandleVisibility', 'off');
        
    ylim([0 5]);
    % ALTERAÇÃO 2: Eixo X travado
    xlim([1 length(rn)]);
    
    yline(4.0, ':k', 'Label', 'Limiar (4.0)', 'LineWidth', 1.5, 'LabelVerticalAlignment', 'bottom', 'Interpreter', 'latex','HandleVisibility', 'off'); 
    title('\textbf{Compara\c{c}\~{a}o Entre $\hat{b}$}', 'Interpreter', 'latex', 'FontSize', fontTitle);
    ylabel('$\mathbf{\hat{b}}$', 'Interpreter', 'latex', 'FontSize', 14); 
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 11);
    
    % --- Subplot 3: UI ---
    subplot(3, 1, 3); 
    hold on; grid on; box on;
    plot(UI, '-o', 'Color', cBlue, 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', cBlue, 'HandleVisibility', 'off');
    plot(UI2, '--x', 'Color', 'r', 'LineWidth', 1.5, 'MarkerSize', 7, 'HandleVisibility', 'off');
    
    ylim([0 6]); 
    % ALTERAÇÃO 2: Eixo X travado
    xlim([1 length(rn)]);
    
    title('\textbf{Compara\c{c}\~{a}o Entre UI}', 'Interpreter', 'latex', 'FontSize', fontTitle);
    xlabel('\textbf{Medidas}', 'Interpreter', 'latex', 'FontSize', fontMain);
    ylabel('\textbf{UI}', 'Interpreter', 'latex', 'FontSize', fontMain);
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 11);
    
    hold off;
    
    %% --- LEGENDA ORIGINAL ---
    hL = legend([p1, p2], 'Base (Sem Ataque)', 'Sob Ataque', ...
           'Orientation', 'horizontal', ...
           'Location', 'northoutside', ...
           'Interpreter', 'latex', ...
           'FontSize', 11);
       
    hL.Position(2) = hL.Position(2) + 0.01; 
    set(gcf, 'Renderer', 'painters'); 
end