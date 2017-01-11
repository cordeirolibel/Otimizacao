%>>>>>>>>        Otimizacao Irrestrita        <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%

dados1;

n_testes
disp('i   f(x)    f(x+1)')

for i = 1:1:n_testes
  ant = testes(i).funcX();
  %se direcao nao foi definida
  if(!testes(i).testDire(false))
    testes(i).newton();
  end
  passo = testes(i).armijo();
  testes(i).updateX();
  %imprimindo resultado
  [i,ant,testes(i).funcX()]
end