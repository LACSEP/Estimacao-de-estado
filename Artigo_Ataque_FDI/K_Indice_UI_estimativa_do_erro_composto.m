function [UI, ei, Wi] = K_Indice_UI_estimativa_do_erro_composto(H1, W, z, rn, Dp)

K = H1*inv(H1'*W*H1)*H1'*W;
%I = sqrt(K/(1-K))
for i=1:length(z)
UI_aux(i) = abs(sqrt(K(i,i)/(1-K(i,i))));
UI=UI_aux';
%% Estimanando erro de medidas

ei(i) = (rn(i))*(sqrt((UI(i))^2+1));
Wi(i) = ei(i)*Dp(i);
end
end