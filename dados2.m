%>>>>>>>>        Otimizacao Irrestrita        <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%

%numero de funcoes criadas
n_testes = 50; 
%dimensao
n = 2; 

for i=1:1:n_testes
  funcTeste(i) = QuadFunc;
  funcTeste(i).create(n);
  pontoX = rand(n,1);
  testes(i) = FuncClass(funcTeste(i),pontoX);
end
