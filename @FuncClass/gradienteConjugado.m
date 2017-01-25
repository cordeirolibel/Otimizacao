%>>>>>>>>    Metodo do Gradiente Conjulgado   <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - Janeiro de 2017        %
%-------------------------------------------------------%

function direcao =  gradienteConjugado(obj)
  %reinicializacao da direcao a cada n passos
  if(mod(obj.k+1,obj.n)==0)
    obj.beta = 0;
  end

  if(isequal(obj.direcao,[]))
    direcao = -obj.gradX();
  else
    direcao = -obj.gradX()+obj.beta*obj.direcao;
  end
  
  obj.direcao = direcao;
  obj.direcao_state = true;
end