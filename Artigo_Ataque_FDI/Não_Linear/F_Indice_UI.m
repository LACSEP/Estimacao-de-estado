function [UI] = F_Indice_UI(Hxo, W, z)
K = Hxo*inv(Hxo'*W*Hxo)*Hxo'*W;
%I = sqrt(K/(1-K))
for i=1:length(z)
UI_aux(i) = abs(sqrt(K(i,i)/(1-K(i,i))));
UI=UI_aux';
end
%disp ('Índice UI:');
% for i=1:length(UI)
%     fprintf('  Medida %2d, |UI| = %.6f\n', i, UI(i));
% end
end