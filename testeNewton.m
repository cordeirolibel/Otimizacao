
funcTeste = QuadFunc;
n = funcTeste.create(2);
pontoX = rand(n,1);

teste = FuncClass(funcTeste,pontoX);

n
disp('Antes, f(x) = ');
teste.funcX()

%set direcao
d = teste.newton();
%set passo
passo = teste.armijo();
%atualiza novo Xk
teste.updateX(passo);

disp('Depois, f(x) = ');
teste.funcX()

%===================PLOT===============
if(n==2)
  
  x = -5:0.5:5;
  y = -5:0.5:5;
  for i = 1:1:size(x)(2)
    for j = 1:1:size(y)(2)
      z(i,j) = teste.func([x(i);y(j)]);
    end
  end
  
  clf;
  figure(1);
  surf(x,y,z);
  hold on
  hold off
  figure(2);
  contour(z,16,'linewidth',2.0)
  hold on
  hold off
end

clear x y z