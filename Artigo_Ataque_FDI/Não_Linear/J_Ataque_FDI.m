function [x02,rn1, Hxo1, za] = J_Ataque_FDI(x01,hx_func,hx, vars, W, z, x0, e, maxinter, nb)
aux = 2*nb-1;
c = 0.05* ones(aux, 1);

t1 = hx_func(x01 + c);
t2 = hx_func(x01);
t3 = x01 + c;
a = hx_func(x01 + c) - hx_func(x01);
%xa = x01 + c;
za = z + a;
% 20 medidas atacadas
%za = [z(1:10) + a(1:10); z(11:57)];

[x02, hxo1, Hxo1, Gxo1, hx_func1, Hx_func1] = D_Solve_WLS_Nao_Linear(hx, vars, W, za, x0, e, maxinter, nb);
[rn1,r1] = E_Erro_Normalizado(za, hxo1, W, Hxo1, Gxo1);
end

