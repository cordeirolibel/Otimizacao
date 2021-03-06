%>>>>>>>>          Metodo do Newton           <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%
% A=hessiana(x)
% B=-grad(X)
%   Ad=B
%  

function direcao = newton(obj)

  format long;
  
  %try using LU factorization 
  try
    direcao = linsolve(obj.hessianaX(),-obj.gradX());
  catch
    direcao = (-obj.hessianaX()\obj.gradX());
  end
  
  %save
  obj.direcao = direcao;
  obj.direcao_state = true;
end