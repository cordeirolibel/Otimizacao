%>>>>>>>>        Otimizacao Irrestrita        <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - janeiro de 2016        %
%-------------------------------------------------------%

%dirc = metodo para direcao 
%passo = metodo para passo
%kmax = numero maximo de interacoes
%prec = precisao de parada
function k = solve(obj,dirc,passo,kmax,prec)
  k=0;
  switch dirc
    case 'newton'
      switch passo
        case 'armijo'
          for k=1:kmax
             obj.newton();
             obj.armijo();                  
             obj.updateX();
             if(mean(obj.gradX())<prec)
                break;
             end
           end
        case 'aurea'
          for k=1:kmax
             obj.newton();
             obj.aurea(prec);                  
             obj.updateX();
             if(mean(obj.gradX())<prec)
                break;
             end
           end
        otherwise
          disp(['Erro:',passo,' nao eh um metodo definido']);
        return
      end
    case 'gradiente'
      switch passo
        case 'armijo'
          for k=1:kmax
             obj.gradiente();
             obj.armijo();                  
             obj.updateX();
             if(mean(obj.gradX())<prec)
                break;
             end
           end
        case 'aurea'
          for k=1:kmax
             obj.gradiente();
             obj.aurea(prec);                  
             obj.updateX();
             if(mean(obj.gradX())<prec)
                break;
             end
           end
        otherwise
          disp(['Erro:',passo,' nao eh um metodo definido']);
        return
      end
    otherwise
      disp(['Erro:',dirc,' nao eh um metodo definido']);
      return 
  end
end