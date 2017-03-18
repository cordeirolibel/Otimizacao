%>>>>>>>> Busca Exata - Metodo da Secao Aurea <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - outubro de 2016        %
%-------------------------------------------------------%

%>> Retorna o melhor passo para a funcao phi
% epsilon = erro maximo de intervalo para parada        
% corte = true: define se salva os cortes do intervalo      
function [passo,cortes,phiT] = aurea(obj,epsilon, corte)

%===========================%
%  a       u    v       b   %
%  [-------|----|-------]   %
%  |       |    |           %
%  |       |    |           %
%  a'   u' v'   b'          %
%  [----|--|----]           %
%===========================%

format long;

%se direcao nao esta definida
if(!obj.testDire())
  return
end

cortes = [];
phiT = [];

if(nargin==2)
  corte = false;
end

p =  0.01;
%procura o intervalo a, b
a = 0;
s = p;
b = 2*p;
while obj.phi(b) < obj.phi(s)
  a = s;
  s = b;
  b = 2*b;
end


% razao aurea
n_ouro = (1+sqrt(5))/2;

u = (a+n_ouro*a+n_ouro*b)/(2*n_ouro+1);
v = a+b-u;
phiU = obj.phi(u);
phiV = obj.phi(v);
k =0;

while (b-a)>epsilon
  %elimina intervalo [v,b]
  if phiU < phiV
    b = v;
    v = u;
    u = a+b-v;
    if(corte)%save corte
      cortes = [cortes,b];
    end
    phiV = phiU;
    phiU = obj.phi(u);
  %elimina intervalo [a,u]
  else
    a = u;
    u = v;
    v = a+b-u;
    if(corte)%save corte
      cortes = [cortes,a];
    end
    phiU = phiV;
    phiV = obj.phi(v);
  end
  k = k+1;
  if(corte)%save corte
      phiT(k) = obj.phi((u+v)/2);
  end
end

passo = (u+v)/2;

%save
obj.passo = passo;
obj.passo_state = true;

clear a b u v k p n_ouro

end