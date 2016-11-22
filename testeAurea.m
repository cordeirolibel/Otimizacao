%>>>>>>>> Busca Exata - Metodo da Secao Aurea <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%

teste = FuncClass("ex4_5",[1;0]);

teste.setDirecao([3;1]);
[passo,cortes,phiT] = teste.aurea(0.01,true);
passo

%========Plots=======%

clf;

%plot phi e cortes
x = 0:0.001:1;
y = teste.phi(x);
plot (x,y,'linewidth',2.0);
hold on
for i = 1:size(cortes,2)
  line([cortes(i),cortes(i)],[0,teste.phi(cortes(i))],'color','k','linewidth',2.0);
  text(cortes(i),teste.phi(cortes(i))/2,int2str(i));
end
hold off

%plot intervalos
figure(2);
plot(phiT,'linewidth',2.0);