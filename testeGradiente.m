
kmax = 10;

funcTeste = QuadFunc;
n = funcTeste.create(2);
pontoX = rand(n,1);

teste = FuncClass(funcTeste,pontoX);

%criando pontos

pts{1} = teste.pontoX;
f_pts(1) = teste.funcX();

for k=1:kmax
  %set direcao
  teste.gradiente();
  %set passo
  teste.armijo();
  %atualiza novo Xk
  teste.updateX();
  
  pts{k+1} = teste.pontoX;
  f_pts(k+1) = teste.funcX();
end

%===================PLOT===============
%definido centro igual a ponto prox e escala que de para ver o ponto ant
dx = 1.2*abs(pts{1}(1) - pts{kmax+1}(1));
dy = 1.2*abs(pts{1}(2) - pts{kmax+1}(2));
x = pts{kmax+1}(1)-dx:dx/10:pts{kmax+1}(1)+dx;
y = pts{kmax+1}(2)-dy:dy/10:pts{kmax+1}(2)+dy;

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
for k = 1:kmax
  line([pts{k}(1),pts{k+1}(1)],[pts{k}(2),pts{k+1}(2)],[f_pts(k),f_pts(k+1)],'color','k','linewidth',4.0);
end
%line([pts{1}(1),pts{kmax+1}(1)],[pts{1}(2),pts{kmax+1}(2)],[f_pts(1),f_pts(kmax+1)],'color','k','linewidth',4.0);

%pausa para ajustar o grafico
%disp ('press to continue') ;
%pause () ;

%print ('img/gradiente','-djpg');
hold off

%======2 grafico, curvas de nivel
figure(2);

contour(x,y,z',16,'linewidth',2.0)

hold on
for k = 1:kmax
  line([pts{k}(1),pts{k+1}(1)],[pts{k}(2),pts{k+1}(2)],[f_pts(k),f_pts(k+1)],'color','k','linewidth',3.0);
end
%line([pts{1}(1),pts{kmax+1}(1)],[pts{1}(2),pts{kmax+1}(2)],[f_pts(1),f_pts(kmax+1)],'color','k','linewidth',3.0);

print ('img/gradiente2','-djpg');
hold off


clear x y z dx dy ant prox f_ant f_prox