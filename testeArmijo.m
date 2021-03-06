%>>>>>>>>        Otimização Irrestrita        <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%

func = 'ex4_5';
pontoX = [1;0];
gama = 0.8;
eta = 1/4;

teste = FuncClass(func,pontoX);

%set direcao
d = teste.gradienteConjugado();
%set passo
passo = teste.armijo(gama,eta);
%atualiza novo Xk
%teste.updateX(passo);

%========Plots=======%
clf;

x = 0:0.001:1;

%calcula funcoes
phiY = teste.phi(x);
taylorY = teste.taylor1(x);
NtaylorY = teste.Ntaylor1(x,eta);

%plot funcao principal
plot(x,phiY,'linewidth',2.0,'color','b')

%salva limites da funcao
limitesX = xlim();
limitesY = ylim();

%plot demais funcoes
hold on
plot(x,taylorY,'linewidth',2.0,'color','r')
plot(x,NtaylorY,'linewidth',2.0,'color','g')
line([passo,passo],[limitesY(1),limitesY(2)],'color','k','linewidth',2.0);

%retorna aos limites da funcao principal
xlim(limitesX);
ylim(limitesY);

%legendas
leg = legend('\phi(t)',
             'p(t)',
             'q(t)',
             't');
set (leg, 'fontsize', 14);

%print ('img/armijo','-djpg');
hold off
%==============

clear NtaylorY phiY taylorY x
