%>>>>>>>>        Otimizacao Irrestrita        <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%

func = "ex4_5";
pontoX = [1;0];
testes(1) = FuncClass(func,pontoX);

func = "ex4_5";
pontoX = [1;0];
direcao = [3;1];
testes(2) = FuncClass(func,pontoX,direcao);

func = "ex4_5";
pontoX = [3;2];
testes(3) = FuncClass(func,pontoX);

func = "ex4_5";
pontoX = [30;20];
testes(4) = FuncClass(func,pontoX);

n_testes = 4;

clear func pontoX direcao