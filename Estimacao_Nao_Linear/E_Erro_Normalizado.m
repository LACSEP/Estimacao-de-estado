function [rn] = E_Erro_Normalizado(z,hxo, W, Hxo, Gxo)
%% Erro e Erro normalizado 
r = z-hxo;
omega = diag(inv(W)-Hxo*(Gxo\Hxo'));
ori = sqrt(omega);
for i=1:length(z)
raux(i) = abs(r(i)/ori(i));
rn=raux';
end
disp ('Resíduos Normalizados:');
for i=1:length(rn)
    fprintf('  Medida %2d, |rn| = %.6f\n', i, rn(i));
end
end