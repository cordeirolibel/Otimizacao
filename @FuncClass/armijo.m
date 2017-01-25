%>>>>>>>> Busca Inexata - condicao de Armijo  <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - outubro de 2016        %
%-------------------------------------------------------%

function passo =  armijo(obj,gama,eta)

%se direcao nao esta definida
if(!obj.testDire())
  return
end
if(nargin==2)
  eta = 0.25;
elseif(nargin==1)
  gama = 0.8;
  eta = 0.25;
end
%Entrada invalida
if (eta<=0) || (eta>=1)
  disp('eta invalido, valida no intervalo (0,1)')
  break;
end

format long;

%definindo func_aux
function [y] = func_aux(t)
  y = obj.funcX()+(eta*t*obj.gradX()'*obj.direcao) ;
end

passo = 1;

k=0;
%Busca do passo
while obj.phi(passo) > func_aux(passo)
  k+=1;
  passo = gama*passo;
end

obj.passo = passo;
obj.passo_state = true;

end