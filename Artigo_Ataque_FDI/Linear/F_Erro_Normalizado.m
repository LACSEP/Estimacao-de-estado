function [rn] = F_Erro_Normalizado(z, W, x01, H, G)
r = z-H*x01;
omega = diag(inv(W)-H*inv(G)*H');
ori = sqrt(omega);
for i=1:length(z)
raux(i) = abs(r(i)/ori(i));
rn=raux';
end
%disp ('Resíduos Normalizados:');
% for i=1:length(rn)
%     fprintf('  Medida %2d, |rn| = %.6f\n', i, rn(i));
% end
end
