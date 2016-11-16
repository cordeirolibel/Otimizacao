%>>>>>>>> Busca Inexata - condicao de Armijo  <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - outubro de 2016        %
%-------------------------------------------------------%

function passo =  armijo(obj,gama,fracN)

#se direcao nao esta definida
if(!obj.testDire())
  return
end

#Entrada invalida
if (fracN<=0) || (fracN>=1)
  disp('fracN invalido, valida no intervalo (0,1)')
  break;
end

format long;

#definindo func_aux
function [y] = func_aux(p)
  y = obj.funcX()+(fracN*p*obj.gradX()*obj.direcao) ;
end

passo = 1;

k=0;
#Busca do passo
while obj.phi(passo) > func_aux(passo)
  k+=1;
  passo = gama*passo;
end

obj.passo = passo;

end