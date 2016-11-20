%>>>>>>>>          Metodo do Newton           <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%
% A=hessiana(x)
% B=-grad(X)
%   Ad=B
%  

function direcao = newton(obj)
  #using LU factorization 
  direcao = linsolve(obj.hessianaX(),-obj.gradX());
  obj.direcao = direcao;
end