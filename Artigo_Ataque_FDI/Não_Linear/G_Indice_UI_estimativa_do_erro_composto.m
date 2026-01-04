function [UI, ei, Wi] = G_Indice_UI_estimativa_do_erro_composto(Hxo, W, z, rn, Dp)
K = Hxo*inv(Hxo'*W*Hxo)*Hxo'*W;
%I = sqrt(K/(1-K))
for i=1:length(z)
UI_aux(i) = abs(sqrt(K(i,i)/(1-K(i,i))));
UI=UI_aux';
%% Estimanando erro de medidas

ei(i) = (rn(i))*(sqrt((UI(i))^2+1));
Wi(i) = ei(i)*Dp(i);
end
% disp ('Índice UI:');
% for i=1:length(UI)
%     fprintf('  Medida %2d, |UI| = %.6f\n', i, UI(i));
% end
% 
% disp ('Estimativa do Erro:');
% for i=1:length(UI)
%     fprintf('  Medida %2d, |ei| = %.6f\n', i, ei(i));
% end
% 
% disp ('Erro:');
% for i=1:length(UI)
%     fprintf('  Medida %2d, |Wi| = %.6f\n', i, Wi(i));
% end
end