%>>>>>>>>        Metodo Quase-Newton          <<<<<<<<<<%
%       Gustavo Cordeiro - UTFPR - março de 2017        %
%-------------------------------------------------------%
%
%bfgs = false  -> utiliza o metodo DFG (default)
%bfgs = false  -> utiliza o metodo BFGS

function direcao = quaseNewton(obj,bfgs)

  format long;

  if(nargin==1)%se nao mencionado utiliza metodo DFG
    bfgs = false;
  end
   
  %dados do objeto, para simplificar a visualização
  H = obj.H;%aproximacao da inversa da hessiana do ponto anterior
  p = obj.p;
  q = obj.q;
  
  if(H==0)            %primeira vez, nao tem H anterior
    obj.H = obj.hessianaX();
  elseif(bfgs==false) %metodo DFP
    obj.H = H + (p*p')/(p'*q) - (H*q*q'*H)/(q'*H*q);
  else                %metodo BFGS
    obj.H = H + (1+(q'*H*q)/(p'*q))*(p*p')/(p'*q) - (p*q'*H+H*q*p')/(p'*q);
  end

  direcao = -obj.H*obj.gradX();
  
  %save
  obj.direcao = direcao;
  obj.direcao_state = true;
end