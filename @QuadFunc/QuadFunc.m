%>>>>>>>>    Criando funcao quadratica        <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - novembro de 2016       %
%-------------------------------------------------------%
% f(x) = (1/2)x'Ax+b'x+c, xeR^n

classdef QuadFunc<handle
    properties (SetAccess = private)
        A
        b
        c
    end
    properties (SetAccess = public)
        n
    end
    methods(SetAccess = public)
      function obj = QuadFunc(n)
        if(nargin==0)
          obj.A = [];
          n=0;
        else
          obj.create(n);
        end
      end
      #criacao das variaveis da funcao
      function out = create(obj, n)
        if(nargin==1)
            n = floor(rand()*100)+1;
        end
        obj.A = rand(n,n);
        obj.A = obj.A*obj.A';#restricao para ser semi-definida positiva
        obj.b = rand(n,1);
        obj.c = rand(1);
        obj.n = n;
        out = n;
      end
      function out = func(obj, x, ordem)# xeR^n
        if(isequal(obj.A,[]))
           disp("Erro:Funcao ainda nao foi criada");
           disp("     Tente usar obj.create(n)");
           return;
        end
        %ordem nao informado
        if(nargin==2)
          ordem = 0;
        end
        if(ordem==0)
          out = (1/2)*x'*obj.A*x+obj.b'*x+obj.c;
        elseif (ordem==1)
          out = obj.A*x+obj.b;
        elseif (ordem==2)
          out = obj.A;
        else
          out = 0;
        end
      end
    end
end