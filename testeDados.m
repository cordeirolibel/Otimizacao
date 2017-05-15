%>>>>>>>>        Otimizacao Irrestrita        <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%

dados3;

n_testes
disp('i   f(x)    f(x+1)    f(x)>f(x+1)')

for i = 1:1:n_testes
  ant = testes(i).funcX();
  %se direcao nao foi definida
  if(!testes(i).testDire(false))
    testes(i).quaseNewton();
  end
  passo = testes(i).armijo();
  testes(i).updateX();
  atual = testes(i).funcX()
  %imprimindo resultado
  disp([int2str(i),' ',mat2str(ant),' ',mat2str(atual),' ', int2str(ant>atual)])
end