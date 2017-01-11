
funcTeste = QuadFunc;
n = funcTeste.create(2);
pontoX = rand(n,1);

teste = FuncClass(funcTeste,pontoX);

n
disp('Antes, f(x) = ');
f_ant = teste.funcX()
ant = teste.pontoX;

%set direcao
teste.newton();
%set passo
teste.armijo();
%atualiza novo Xk
teste.updateX();

disp('Depois, f(x) = ');
f_prox = teste.funcX()
prox = teste.pontoX;

%===================PLOT===============
if(n==2)
  %definido centro igual a ponto prox e escala que de para ver o ponto ant
  dx = 1.2*abs(ant(1) - prox(1));
  dy = 1.2*abs(ant(2) - prox(2));
  x = prox(1)-dx:dx/10:prox(1)+dx;
  y = prox(2)-dy:dy/10:prox(2)+dy;
  
  %calculando os pontos
  for i = 1:1:size(x)(2)
    for j = 1:1:size(y)(2)
      z(i,j) = teste.func([x(i);y(j)]);
    end
  end
  
  clf;
  figure(1);
  grafico = surf(x,y,z');
  
  hold on
  line([ant(1),prox(1)],[ant(2),prox(2)],[f_ant,f_prox],'color','k','linewidth',4.0);
  
  %pausa para ajustar o grafico
  %disp ('press to continue') ;
  %pause () ;
  
  print ('img/newton','-djpg');
  hold off
  
  %======2 grafico, curvas de nivel
  figure(2);
  
  contour(x,y,z',16,'linewidth',2.0)
  
  hold on
  line([ant(1),prox(1)],[ant(2),prox(2)],'color','k','linewidth',3.0);
  print ('img/newton2','-djpg');
  hold off
end

clear x y z dx dy ant prox f_ant f_prox