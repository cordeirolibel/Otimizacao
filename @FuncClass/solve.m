%>>>>>>>>        Otimizacao Irrestrita        <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - janeiro de 2016        %
%-------------------------------------------------------%

%dirc = metodo para direcao 
%   |newton
%   |gradiente
%   |gradiente conjugado
%   |quase-newton
%   |quase-newton DFP
%passo = metodo para passo
%   |armijo
%   |aurea
%kmax = numero maximo de interacoes
%prec = precisao de parada
function k = solve(obj,kmax,prec,dirc,passo)

  if(nargin==4) %(default)
    passo = 'armijo';
  end
  
  %BFGS ja eh o modo padrao
  if (strcmp(dirc,'quase-newton BFGS'))
    dirc = 'quase-newton';
  end
  
  k=0;
  switch dirc
    case 'newton'
      switch passo
        case 'armijo'
          for k=1:kmax
             if(mean(obj.gradX())<prec)
                break;
             end
             obj.newton();
             obj.armijo();                  
             obj.updateX();
           end
        case 'aurea'
          for k=1:kmax
             if(mean(obj.gradX())<prec)
                break;
             end
             obj.newton();
             obj.aurea(prec);                  
             obj.updateX();
           end
        otherwise
          disp(['Erro:',passo,' nao eh um metodo definido']);
        return
      end
    case 'gradiente'
      switch passo
        case 'armijo'
          for k=1:kmax
             if(mean(obj.gradX())<prec)
                break;
             end
             obj.gradiente();
             obj.armijo();                  
             obj.updateX();
           end
        case 'aurea'
          for k=1:kmax
             if(mean(obj.gradX())<prec)
                break;
             end
             obj.gradiente();
             obj.aurea(prec);                  
             obj.updateX();
           end
        otherwise
          disp(['Erro:',passo,' nao eh um metodo definido']);
        return
      end
    case 'gradiente conjugado'
      switch passo
        case 'armijo'
          for k=1:kmax
             if(mean(obj.gradX())<prec)
                break;
             end
             obj.gradienteConjugado();
             obj.armijo();                  
             obj.updateX();
           end
        case 'aurea'
          for k=1:kmax
             if(mean(obj.gradX())<prec)
                break;
             end
             obj.gradienteConjugado();
             obj.aurea(prec);                  
             obj.updateX();
           end
        otherwise
          disp(['Erro:',passo,' nao eh um metodo definido']);
        return
      end
    case 'quase-newton' %BFGS
      switch passo
        case 'armijo'
          for k=1:kmax
             if(mean(obj.gradX())<prec)
                break;
             end
             obj.quaseNewton(false);
             obj.armijo();                  
             obj.updateX();
           end
        case 'aurea'
          for k=1:kmax
             if(mean(obj.gradX())<prec)
                break;
             end
             obj.quaseNewton();
             obj.aurea(prec);                  
             obj.updateX();
           end
        otherwise
          disp(['Erro:',passo,' nao eh um metodo definido']);
        return
      end
    case 'quase-newton DFP'
      switch passo
        case 'armijo'
          for k=1:kmax
             if(mean(obj.gradX())<prec)
                break;
             end
             obj.quaseNewton(false);
             obj.armijo();                  
             obj.updateX();
           end
        case 'aurea'
          for k=1:kmax
             if(mean(obj.gradX())<prec)
                break;
             end
             obj.quaseNewton(false);
             obj.aurea(prec);                  
             obj.updateX();
           end
        otherwise
          disp(['Erro:',passo,' nao eh um metodo definido']);
        return
      end
    otherwise
      disp(['Erro:',dirc,' nao eh um metodo definido']);
      return 
  end
  
  #ajuste - sempre conta 1 a mais
  k = k-1;
  
end