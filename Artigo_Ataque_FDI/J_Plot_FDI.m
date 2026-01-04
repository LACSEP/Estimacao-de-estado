function J_Plot_FDI(x01, x02, rn, rn1, UI, UI2, ei, ei2, nb)
    %% --- CONFIGURAÇÕES GERAIS DE ESTILO ---
    cBlue = [0.1216 0.4667 0.7059]; 
    
    % COR AJUSTADA (Salmão/Vermelho claro)
    cAttackStyle = [1.0, 0.4, 0.4]; 
    
    fontMain = 12; 
    fontTitle = 14; 
    
    %% --- FIGURE 1: ESTADOS (ÂNGULOS) ---
    figure('Name', 'Detalhamento dos Estados', 'Color', 'w', 'Position', [100, 50, 600, 1300]); 
    idx_ang = 1:(nb-1); 
    
   %% --- Subplot 1: Ângulos ---
    subplot(1,1,1);
    hold on; grid on; box on;
    
    % 1. Conversão de Radianos para Graus
    ang_base_deg = x01(idx_ang) * (180/pi);
    ang_atk_deg  = x02(idx_ang) * (180/pi);
    
    % 2. Plotagem
    % Linha Azul (Sem Ataque)
    plot(idx_ang, ang_base_deg, '-', 'Color', cBlue, 'LineWidth', 1.5, 'DisplayName', 'Sem Ataque');
    
    % Linha Vermelha Sólida (Sob Ataque) - ESPESSURA REDUZIDA PARA 1.5
    plot(idx_ang, ang_atk_deg, '-', 'Color', cAttackStyle, 'LineWidth', 1.5, 'DisplayName', 'Sob Ataque (CMC)');
    
    % 3. Formatação
    title('\textbf{\^Angulos de Tens\~ao Estimados}', 'Interpreter', 'latex', 'FontSize', fontTitle);
    ylabel('\textbf{\^Angulo de Tens\~ao (graus)}', 'Interpreter', 'latex', 'FontSize', fontMain);
    xlabel('\textbf{Barras}', 'Interpreter', 'latex', 'FontSize', fontMain);
    
    xticks(1:length(idx_ang));
    xticklabels(string(2:nb)); 
    xlim([1 length(idx_ang)]);
    
    % Legenda
    legend('show', 'Location', 'northoutside', 'Orientation', 'horizontal', 'Interpreter', 'latex', 'FontSize', 11);
    
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 11);
    hold off;
  
  
    %% --- FIGURE 2: RESÍDUOS (MANTIDO) ---
    figure('Name', 'Analise de Residuos', 'Color', 'w', 'Position', [950, 50, 800, 800]);
    
    subplot(3, 1, 1); 
    hold on; grid on; box on;
    p1 = plot(rn, '-o', 'Color', cBlue, 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', cBlue, 'DisplayName', 'Sem Ataque');
    p2 = plot(rn1, '--x', 'Color', 'r', 'LineWidth', 1.5, 'MarkerSize', 7, 'DisplayName', 'Sob Ataque (MQP)');
    ylim([0 6]); xlim([1 length(rn)]);
    yline(3.0, ':k', 'HandleVisibility', 'off'); 
    title('\textbf{Compara\c{c}\~{a}o Entre Res\''iduos Normalizados}', 'Interpreter', 'latex', 'FontSize', fontTitle);
    ylabel('\textbf{Res\''iduo Norm.}', 'Interpreter', 'latex', 'FontSize', fontMain);
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 11);
    
    subplot(3, 1, 2); 
    hold on; grid on; box on;
    plot(ei, '-o', 'Color', cBlue, 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', cBlue, 'HandleVisibility', 'off');
    plot(ei2, '--x', 'Color', 'r', 'LineWidth', 1.5, 'MarkerSize', 7, 'HandleVisibility', 'off');
    ylim([0 6]); xlim([1 length(rn)]);
    yline(4.0, ':k', 'HandleVisibility', 'off'); 
    title('\textbf{Compara\c{c}\~{a}o Entre $\hat{b}$}', 'Interpreter', 'latex', 'FontSize', fontTitle);
    ylabel('$\mathbf{\hat{b}}$', 'Interpreter', 'latex', 'FontSize', 14); 
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 11);
    
    subplot(3, 1, 3); 
    hold on; grid on; box on;
    plot(UI, '-o', 'Color', cBlue, 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', cBlue, 'HandleVisibility', 'off');
    plot(UI2, '--x', 'Color', 'r', 'LineWidth', 1.5, 'MarkerSize', 7, 'HandleVisibility', 'off');
    ylim([0 6]); xlim([1 length(rn)]);
    title('\textbf{Compara\c{c}\~{a}o Entre UI}', 'Interpreter', 'latex', 'FontSize', fontTitle);
    xlabel('\textbf{Medidas}', 'Interpreter', 'latex', 'FontSize', fontMain);
    ylabel('\textbf{UI}', 'Interpreter', 'latex', 'FontSize', fontMain);
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 11);
    
    hL = legend([p1, p2], 'Sem Ataque', 'Sob Ataque (MQP)', 'Orientation', 'horizontal', 'Location', 'northoutside', 'Interpreter', 'latex', 'FontSize', 11);
    hL.Position(2) = hL.Position(2) + 0.01; 
    set(gcf, 'Renderer', 'painters'); 
end