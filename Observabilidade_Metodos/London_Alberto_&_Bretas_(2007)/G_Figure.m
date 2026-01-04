function [h] = G_Figure(H_t_f, ordem_final)
%% Criação de Figura
figure;
h = heatmap(H_t_f); 
h.XLabel = 'Número da Medida'; 
h.YLabel = 'Variáveis de Estado';
h.XDisplayLabels = string(ordem_final);
title('Visualização da Matriz Hdelta'); 
h.CellLabelFormat = '%.2f';
h.Colormap = gray;
h.ColorbarVisible = 'off';
end