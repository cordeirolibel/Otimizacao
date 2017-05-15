%%%% Para recuperar resultados e fazer graficos PP

% --------------------------- METODOS ---------------------------------------
% 1 = Cauchy
% 2 = Newton
% 3 = Gradiente Conjugado
% 4 = Quase-Newton
% 5 = Quase-Newton DFP
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
%%% nmet = numero de metodos

%%% dados
%%% nn = numero de variacoes n
%%% nlmin = numero de variacoes de lambdamin
%%% nlmax = numero de variacoes de lambdamax
%nprob = nn*nlmin*nlmax; %% total de problemas testados

load guarda_dados_1.mat
% -------------------------------------------------------------------------

for i=1:nprob
    for j=1:nmet
        if it(i,j)==kmax
            it(i,j)=NaN;
        end
    end
end

% -------------------------------------------------------------------------
% ITERACOES
% -------------------------------------------------------------------------

% % -------------------------------------------------------------------------
figure(1)

perf(it,2)
leg_text = '';
for var = variant
  switch var
    case 1
      leg_text = [leg_text;'Cauchy'];
    case 2
      leg_text = [leg_text;'Newton'];
    case 3
      leg_text = [leg_text;'Grad Conj'];
    case 4
      leg_text = [leg_text;'BFGS'];
    case 5
      leg_text = [leg_text;'DFP'];
  end
end
leg = legend(leg_text,4);
set (leg, 'fontsize', 14,'Location','SouthEast');
title('Performance profile - Iteracoes','fontsize', 14);
%print ('img/pp1','-djpg');
print ('img/pp_mgh3','-djpg');
hold off;

