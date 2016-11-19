%>>>>>>>>         Metodo do Gradiente         <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%

classdef FuncClass<handle
    properties (SetAccess = private)
        funcao
        gradX_save
        funcX_save
        gradX_ponto
        funcX_ponto
        passo
    end
    properties (SetAccess = public)
        pontoX
        direcao
    end
    methods(SetAccess = public)
        function obj = FuncClass(funcao,pontoX,direcao)
            obj.funcao = funcao;
            obj.pontoX = pontoX;
            if(nargin==3)
              obj.direcao =direcao;
            else 
              obj.direcao = [];
            end
            obj.passo = -1;
        end
        #imprimindo todos os dados do objeto
        function print(obj)
          disp(["Funcao: ",obj.funcao]);
          disp("PontoX: ");
          obj.pontoX
          disp(["Gama: ",num2str(obj.gama)]);
          disp(["FracN: ",num2str(obj.fracN)]);
          disp("Direcao: ");
          obj.direcao
        end
        #definido em armijo.m
        passo =  armijo(obj,gama,fracN)
        #definido em aurea.m
        [passo,cortes,phiT] = aurea(obj,epsilon, corte)
        #metodo do gradiente
        direcao =  gradiente(obj)
        #gradiente da funcao definida
        function out = grad(obj, x)
          out = obj.func(x,1);
        end
        #valor da funcao definida de derivada ordem no ponto x
        function out = func(obj, x, ordem)
          if(nargin == 2)
            ordem = 0;
          end
          out = feval(obj.funcao,x,ordem);
        end
        #gradiente da funcao definida no pontoX
        function out = gradX(obj)
          #verifica se nao foi calculado
          if(!isequal(obj.pontoX, obj.gradX_ponto))
            obj.gradX_save = obj.grad(obj.pontoX);
            obj.gradX_ponto = obj.pontoX;
          end
          out = obj.gradX_save;
        end
        #valor da funcao definida de derivada ordem no pontoX
        function out = funcX(obj)
          #verifica se nao foi calculado
          if(!isequal(obj.pontoX, obj.funcX_ponto))
            obj.funcX_save = obj.func(obj.pontoX);
            obj.funcX_ponto = obj.pontoX;
          end
          out = obj.funcX_save;
        end
        #funcao phi auxiliar
        function out = phi(obj, passos)
          #testa se direcao estao definidos
          if(!obj.testDire())
            return
          end
          out = [];
          for passo = passos
            out = [out,obj.func(obj.pontoX + passo*obj.direcao)] ;
          end
        end
        #definindo taylor1
        function out = taylor1(obj,passos)
          #testa se direcao estao definidos
          if(!obj.testDire())
            return
          end
          out = [];
          for passo = passos
            out = [out,obj.funcX()+ passo*obj.gradX()*obj.direcao];
          end
        end
        #definindo Ntaylor1
        function out = Ntaylor1(obj,passos,fracN)
          #testa se direcao estao definidos
          if(!obj.testDire())
            return
          end
          out = [];
          for passo = passos
            out = [out,obj.funcX()+ fracN*passo*obj.gradX()*obj.direcao];
          end
        end
        function setDirecao(obj,direcao)
          obj.direcao = direcao;
        end
        #testa se passo esta definido
        function out = testPasso(obj)
          if(obj.passo==-1)
            disp("Erro: Passo nao esta definido");
            out = false;
          else 
            out = true;
          end
        end
        #testa se direcao esta definido
        function out = testDire(obj)
          if(isequal(obj.direcao,[]))
            disp("Erro: Direcao nao esta definida");
            out = false;
          else 
            out = true;
          end
        end
        #atualiza pontoX
        function out = updateX(obj,passo)
          #testa se passo ou direcao estao definidos
          if(!obj.testPasso()||!obj.testDire())
            return
          end
          out = obj.pontoX + passo*obj.direcao;
          obj.pontoX= out;
          #clear
          obj.passo = -1;
          obj.direcao = [];
        end
    end
end