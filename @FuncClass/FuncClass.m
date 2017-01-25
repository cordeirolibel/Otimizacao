%>>>>>>>>        Otimizacao Irrestrita        <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%

classdef FuncClass<handle
    properties (SetAccess = private)
        funcao
        gradX_save
        funcX_save
        hessianaX_save
        gradX_ponto
        funcX_ponto
        hessianaX_ponto
        passo_state
        direcao_state
        beta
    end
    properties (SetAccess = public)
        pontoX
        direcao
        passo
        k
        n
    end
    methods(SetAccess = public)
        function obj = FuncClass(funcao,pontoX,direcao)
            obj.funcao = funcao;
            obj.pontoX = pontoX;  
            obj.n = size(pontoX)(1);
            if(nargin==1)
              obj.direcao = [];
              obj.direcao_state = false;
            elseif(nargin==2)
              obj.direcao = [];
              obj.direcao_state = false;
            else%nargin==3, direcao definida
              obj.direcao =direcao;
              obj.direcao_state = true;
            end
            obj.passo_state = false;
            obj.beta = 0;
            obj.k=0;
        end
        %imprimindo todos os dados do objeto
        function print(obj)
          disp(['Funcao: ',obj.funcao]);
          disp('PontoX: ');
          obj.pontoX
          disp('Direcao: ');
          obj.direcao
        end
        %definido em armijo.m
        passo =  armijo(obj,gama,fracN)
        %definido em aurea.m
        [passo,cortes,phiT] = aurea(obj,epsilon, corte)
        %metodo do gradiente
        direcao =  gradiente(obj)
        %metodo de Newton
        direcao = newton(obj)
        %metodo do gradiente conjulgado
        direcao =  gradienteConjugado(obj)
        %definido em solve.m
        k = solve(obj,dirc,passo,kmax,prec)
        %hessiana da funcao definida
        function out = hessiana(obj, x)
          out = obj.func(x,2);
        end
        %gradiente da funcao definida
        function out = grad(obj, x)
          out = obj.func(x,1);
        end
        %valor da funcao definida de derivada ordem no ponto x
        function out = func(obj, x, ordem)
          if(nargin == 2)
            ordem = 0;
          end
          try
            out = feval(obj.funcao,x,ordem);
          catch
            out = obj.funcao.func(x,ordem);
          end
        end
        %hessiana da funcao definida no pontoX
        function out = hessianaX(obj)
          %verifica se nao foi calculado
          if(!isequal(obj.pontoX, obj.hessianaX_ponto))
            obj.hessianaX_save = obj.hessiana(obj.pontoX);
            obj.hessianaX_ponto = obj.pontoX;
          end
          out = obj.hessianaX_save;
        end
        %gradiente da funcao definida no pontoX
        function out = gradX(obj)
          %verifica se nao foi calculado
          if(!isequal(obj.pontoX, obj.gradX_ponto))
            obj.gradX_save = obj.grad(obj.pontoX);
            obj.gradX_ponto = obj.pontoX;
          end
          out = obj.gradX_save;
        end
        %valor da funcao definida de derivada ordem no pontoX
        function out = funcX(obj)
          %verifica se nao foi calculado
          if(!isequal(obj.pontoX, obj.funcX_ponto))
            obj.funcX_save = obj.func(obj.pontoX);
            obj.funcX_ponto = obj.pontoX;
          end
          out = obj.funcX_save;
        end
        %funcao phi auxiliar
        function out = phi(obj, passos)
          %testa se direcao estao definidos
          if(!obj.testDire())
            return
          end
          out = [];
          for passo = passos
            out = [out,obj.func(obj.pontoX + passo*obj.direcao)] ;
          end
        end
        %definindo taylor1 de phi no pontoX
        function out = taylor1(obj,passos)
          %testa se direcao esta definida
          if(!obj.testDire())
            return
          end
          out = [];
          for passo = passos
            out = [out,obj.funcX()+ passo*obj.gradX()'*obj.direcao];
          end
        end
        %definindo Ntaylor1 de phi no pontoX
        function out = Ntaylor1(obj,passos,fracN)
          %testa se direcao esta definida
          if(!obj.testDire())
            return
          end
          out = [];
          for passo = passos
            out = [out,obj.funcX()+ fracN*passo*obj.gradX()'*obj.direcao];
          end
        end
        function setDirecao(obj,direcao)
          obj.direcao = direcao;
          obj.direcao_state = true;
        end
        function setPasso(obj,passo)
          obj.passo = direcao;
          obj.passo_state = true;
        end
        %testa se passo esta definido
        function out = testPasso(obj,message)
          if(nargin==1)%habilitado mensagem de erro
            message = true;
          end
          if(obj.passo_state==false)
            if(message)
              disp('Erro: Passo nao esta definido');
            end
            out = false;
          else 
            out = true;
          end
        end
        %testa se direcao esta definido
        function out = testDire(obj,message)
          if(nargin==1)
            message = true;
          end
          if(obj.direcao_state ==false)
            if(message)
              disp('Erro: Direcao nao esta definida');
            end
            out = false;
          else 
            out = true;
          end
        end
        %atualiza pontoX
        function out = updateX(obj)
          %testa se passo ou direcao estao definidos
          if(!obj.testPasso()||!obj.testDire())
            return
          end
          grad_ant = obj.gradX()'*obj.gradX();
          out = obj.pontoX + obj.passo*obj.direcao;
          obj.pontoX= out;
          %para o gradiente conjugado
          if(grad_ant!=0)
            obj.beta = (obj.gradX()'*obj.gradX())/(grad_ant);
          else
            obj.beta = 0;
          end
          %clear
          obj.passo_state = false;
          obj.direcao_state = false;
          obj.k+=1;
        end
    end
end