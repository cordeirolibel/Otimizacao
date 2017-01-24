

funcTeste = QuadFunc;
funcTeste.create(7,2,50);
pontoX = rand(7,1);

func = FuncClass(funcTeste,pontoX);

k = func.solve('newton','armijo',20,0.001)