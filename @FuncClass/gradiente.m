%>>>>>>>>         Metodo do Gradiente         <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%

function direcao =  gradiente(obj)

direcao = -obj.gradX();
obj.direcao = direcao;

end