%>>>>>>>>        Otimizacao Irrestrita        <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%

dados;

n_testes
for i = 1:1:n_testes
  [i,testes(i).funcX()]
  %se direcao nao foi definida
  if(!testes(i).testDire(false))
    testes(i).gradiente();
  end
  passo = testes(i).armijo();
  testes(i).updateX();
  
  [i,testes(i).funcX()]
end