%>>>>>>>>        Otimização Irrestrita        <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%

func = "ex4_5";
pontoX = [1;0];
gama = 0.8;
fracN = 1/4;

teste = FuncClass(func,pontoX);
#set direcao
d = teste.gradiente();
#set passo
passo = teste.armijo(gama,fracN);
#teste.updateX(passo);

%========Plots=======%
clf;

x = 0:0.001:1;

#calcula funcoes
phiY = teste.phi(x);
taylorY = teste.taylor1(x);
NtaylorY = teste.Ntaylor1(x,fracN);

#plot funcao principal
plot(x,phiY,'linewidth',2.0,'color','b')

#salva limites da funcao
limitesX = xlim();
limitesY = ylim();

#plot demais funcoes
hold on
plot(x,taylorY,'linewidth',2.0,'color','r')
plot(x,NtaylorY,'linewidth',2.0,'color','g')
line([passo,passo],[limitesY(1),limitesY(2)],'color','k','linewidth',2.0);

#retorna aos limites da funcao principal
xlim(limitesX);
ylim(limitesY);
hold off
#==============

#clear teste;
