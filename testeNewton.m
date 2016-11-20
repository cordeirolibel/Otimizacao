
funcTeste = QuadFunc;
n = funcTeste.create();
pontoX = rand(n,1);

teste = FuncClass(@(funcTeste.func),pontoX);

teste.funcX();
teste.gradX();

#set direcao
d = teste.newton();
#set passo
passo = teste.armijo(gama,fracN);
#atualiza novo Xk
teste.updateX(passo);

teste.funcX();
teste.gradX();