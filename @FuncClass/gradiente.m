%>>>>>>>>         Metodo do Gradiente         <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%

function direcao =  gradiente(obj)

  format long;
  
  direcao = -obj.gradX();
  
  %save
  obj.direcao = direcao;
  obj.direcao_state = true;

end