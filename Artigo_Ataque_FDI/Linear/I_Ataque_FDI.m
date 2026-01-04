function [rn1, x02, za,a] = I_Ataque_FDI(nb,H1,z, W,G1,x01)
aux = nb-1;
c = 0.05* ones(aux, 1);
%c = [0.05 * ones(6, 1); zeros(7, 1)];
a = H1*c;
za = z + a;
%x02 = x01 + c;
x02 = (H1'*W*H1)\(H1'* W*za);
[rn1] = F_Erro_Normalizado(za, W, x02, H1, G1);
end

