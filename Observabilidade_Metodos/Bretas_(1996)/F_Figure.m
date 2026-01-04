function [h] = F_Figure(G_fat)
%% Criação de Figura
figure;
h = heatmap(G_fat); 
title('Visualização da Matriz G Fatorada'); 
h.CellLabelFormat = '%.2f';
h.Colormap = gray;
h.ColorbarVisible = 'off';
end