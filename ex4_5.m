%>>>>>>>> Busca Inexata - condicao de Armijo  <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - outubro de 2016        %
%-------------------------------------------------------%

function [y] = ex4_5 (X, ordem)

if nargin==1
  ordem=0; 
end

if ordem==0              
  y = (X(1)-2)^2/2+(X(2)-1)^2;  
elseif ordem==1 
  y = [(X(1)-2) , 2*(X(2)-1)];
else
  error('Ordem da derivada inexistente');
end
